#include <stdio.h>
#include <stdlib.h>
#include <math.h>
#include <time.h>
#include "platform.h"
#include "xil_printf.h"
#include "xsdps.h"
#include "ff.h"
#include "det_parameters.h"
#include "xaxidma.h"
//#include "xmcdma.h"
#include "xparameters.h"
#include "xil_exception.h"
#include "xdebug.h"
#include "xSvd_top.h"
//#include <time.h>
#include "xtmrctr.h"
#include "xscugic.h"

#ifdef XPAR_INTC_0_DEVICE_ID
 #include "xintc.h"
#else
 #include "xscugic.h"
#endif

/*
 * Device hardware build related constants.
 */

// HLS macc HW instance


#define DMA_DEV_ID_HLS	XPAR_AXIDMA_1_DEVICE_ID

#define DMA_DEV_ID		XPAR_AXIDMA_0_DEVICE_ID
//#define MCDMA_DEV_ID	XPAR_AXI_MCDMA_0_DEVICE_ID

#ifdef XPAR_AXI_7SDDR_0_S_AXI_BASEADDR
#define DDR_BASE_ADDR		XPAR_AXI_7SDDR_0_S_AXI_BASEADDR
#elif XPAR_MIG7SERIES_0_BASEADDR
#define DDR_BASE_ADDR	XPAR_MIG7SERIES_0_BASEADDR
#elif XPAR_MIG_0_BASEADDR
#define DDR_BASE_ADDR	XPAR_MIG_0_BASEADDR
#elif XPAR_PSU_DDR_0_S_AXI_BASEADDR
#define DDR_BASE_ADDR	XPAR_PSU_DDR_0_S_AXI_BASEADDR
#endif

#ifndef DDR_BASE_ADDR
#warning CHECK FOR THE VALID DDR ADDRESS IN XPARAMETERS.H, \
		DEFAULT SET TO 0x01000000
#define MEM_BASE_ADDR		0x01000000
#else
#define MEM_BASE_ADDR		(DDR_BASE_ADDR + 0x1000000)
#endif

#ifdef XPAR_INTC_0_DEVICE_ID
#define RX_INTR_ID		XPAR_INTC_0_AXIDMA_0_S2MM_INTROUT_VEC_ID
#define TX_INTR_ID		XPAR_INTC_0_AXIDMA_0_MM2S_INTROUT_VEC_ID
//#define RX_INTR_ID_HLS	XPAR_INTC_0_AXIDMA_S2MM_INTROUT_VEC_ID
//#define TX_INTR_ID_HLS	XPAR_INTC_0_AXIDMA_MM2S_INTROUT_VEC_ID
#else
#define RX_INTR_ID		XPAR_FABRIC_AXIDMA_0_S2MM_INTROUT_VEC_ID
#define TX_INTR_ID		XPAR_FABRIC_AXIDMA_0_MM2S_INTROUT_VEC_ID
//#define RX_INTR_ID_HLS	XPAR_FABRIC_AXIDMA_0_S2MM_INTROUT_VEC_ID
//#define TX_INTR_ID_HLS	XPAR_FABRIC_AXIDMA_0_MM2S_INTROUT_VEC_ID
#endif

#define TX_BUFFER_BASE		(MEM_BASE_ADDR + 0x00100000)
#define RX_BUFFER_BASE		(MEM_BASE_ADDR + 0x00300000)
#define RX_BUFFER_HIGH		(MEM_BASE_ADDR + 0x004FFFFF)

//#define TX_BUFFER_BASE_HLS	(MEM_BASE_ADDR + 0x01000000)
//#define RX_BUFFER_BASE_HLS	(MEM_BASE_ADDR + 0x03000000)
//#define RX_BUFFER_HIGH_HLS	(MEM_BASE_ADDR + 0x04FFFFFF)

#ifdef XPAR_INTC_0_DEVICE_ID
#define INTC_DEVICE_ID          XPAR_INTC_0_DEVICE_ID
#else
#define INTC_DEVICE_ID          XPAR_SCUGIC_SINGLE_DEVICE_ID
#endif

#ifdef XPAR_INTC_0_DEVICE_ID
 #define INTC		XIntc
 #define INTC_HANDLER	XIntc_InterruptHandler
#else
 #define INTC		XScuGic
 #define INTC_HANDLER	XScuGic_InterruptHandler
#endif


/* Timeout loop counter for reset
 */
#define RESET_TIMEOUT_COUNTER	10000





extern FIL fil;		/* File object */
extern FATFS fatfs;
extern char HyperMatrixFile[32];
extern char ResultsFile[32];
extern char TargetFile[32];
extern char *SD_File;
extern u32 Platform;


extern datatype HyperData[N_pixels * N_bands] ; //__attribute__ ((aligned(32)));


extern double R [N_bands][N_bands] ;
extern  int P[m_samples];
extern double B[m_samples][m_samples] ;
extern double X[m_samples] ;
extern double Y[m_samples] ;


extern double sR[N_bands];
extern double xR[N_bands] ;
extern double result[N_pixels] ;
extern datatype target[N_bands];
extern s32 R32[N_bands][N_bands];
extern s32 sR32[N_bands];
extern volatile u32 *BRAM_BASE_ADDR;
extern outputtype receiver [N_Values_B];
extern outputtype_HLS receiver_HLS [HLS_OUT_SIZE];
extern XAxiDma AxiDma;		/* Instance of the XAxiDma */
extern XAxiDma AxiDma_HLS;
extern INTC Intc;	/* Instance of the Interrupt Controller */
extern volatile int TxDone;
extern volatile int RxDone;
extern volatile int Error;
extern XTmrCtr TimerCounter;


extern datatype A_Mat [m_samples][m_samples];
extern datatype A_Mat_Inv [m_samples][m_samples] ;
extern outputtype_HLS B_Mat [m_samples][N_Values_B];
extern outputtype_HLS B_Mat_T [N_Values_B][m_samples] ;



#ifndef DEBUG
extern void xil_printf(const char *format, ...);
#endif

#ifdef XPAR_UARTNS550_0_BASEADDR
static void Uart550_Setup(void);
#endif

int ReceiveData(outputtype* array, int Length);
void TxIntrHandler(void *Callback);
void RxIntrHandler(void *Callback);
int main_DMA(datatype* array,outputtype* receiver, int MAX_PKT_LEN, int NUMBER_OF_TRANSFERS);
int setup_DMA(void);

int SetupIntrSystem(INTC * IntcInstancePtr,
			   XAxiDma * AxiDmaPtr, u16 TxIntrId, u16 RxIntrId);
void DisableIntrSystem(INTC * IntcInstancePtr,
					u16 TxIntrId, u16 RxIntrId);

int init_timer ( u16 DeviceId , u8 TmrCtrNumber );
u32 start_timer (u8 TmrCtrNumber );
u32 stop_timer (u8 TmrCtrNumber );

double scalarProduct (double*, datatype*, int);
double scalarProduct2 (datatype* a, datatype* b, int N);
int FfsSd(char*, datatype * );
int FfsSdWrite (char*, outputtype *);
int read_data(char*, datatype * );
int write_data(char*, outputtype *);
//void matrixMult(s16*,s16*,s16*);
//void removeMean(s16*,s32*,int,int);


void hls_macc_isr(void *);
int setup_interrupt();
int Setup_HW_Accelerator(float [m_samples*m_samples], float [HLS_OUT_SIZE]);
int Run_HW_Accelerator(float [], float[], int);
int ReceiveData_HLS(outputtype_HLS* , int );
int XSvd_top_init(XSvd_top *);
void XSvd_topStart(void *);
int XSvd_topSetup();
int setup_DMA_HLS(void);

int rand_num(int ) ;

//void sample_rand(datatype *, int size , int, double[size]  );
int LUPdecompose(int, double (*)[], int *);
int LUPinverse(int size, int P[size], double LU[size][size], double [size][size], double [size], double [size]);
void arrayMatrixProduct(int, datatype *, double [][N_bands], double *);
void GaussJordan (int size, double R[size][size], double B[size][size]);
void printBits(size_t const size, void const * const ptr);
