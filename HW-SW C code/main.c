#include <stdio.h>
#include <stdlib.h>
#include <inttypes.h>
#include "platform.h"
#include "xil_printf.h"
#include "xparameters.h"
#include "xtime_l.h"
#include "xil_io.h"
#include "xsdps.h"		/* SD device driver */
#include "xil_cache.h"
#include "xplatform_info.h"
#include "ff.h"
#include "math.h"
#include "functions.h"
#include "det_parameters.h"
#include "xSvd_top.h"
#include "xtmrctr.h"
#define MAX_PKT_LEN (N_bands*N_pixels*2)
//#define MAX_PKT_LEN (108 * sizeof(float) )
#define NUMBER_OF_TRANSFERS (1)


/*****************************************************************************/

int main()
{


	init_platform();

	//TIMER
	XTime tStart, tEnd;

    //Start timer
    XTime_GetTime(&tStart);

    //HW timer
    init_timer ( XPAR_AXI_TIMER_0_DEVICE_ID , 0 );
    u32 value1 = start_timer ( 0 );
	xil_printf("\r\n--- Entering main() --- \r\n");



	//IMPORT HYPERSPECTRAL CUBE TO DDR

	read_data(HyperMatrixFile,HyperData);


    xil_printf("\r\n--- Read file() --- \r\n");


    xil_printf("HyperData : \n");
    //for(int j = 0; j < 3; j++){
    for(int j = 0; j < 3; j++){
    	for(int i = j*N_bands ; i < j*N_bands + N_bands; i++){
    		xil_printf("%d;",HyperData[i]);
    	}
    	xil_printf("\n");
    }



int max,min;
max = HyperData[0];
min = HyperData[0];

/*
 * Find maximum and minimum in all array elements.
 */
for(int i=1; i<N_pixels*N_bands; i++)
{
	/* If current element is greater than max */
	if(HyperData[i] > max)
	{
	   max = HyperData[i];
	}

	/* If current element is smaller than min */
	if(HyperData[i] < min)
	{
		min = HyperData[i];
	}
}
printf(" max = %d, min = %d \n", max,min);


//disable debug while writing
	*(BRAM_BASE_ADDR + 3) = 0;

    //WRITING sR^-1 vector to BRAM
  	for (int i = 0; i< 	65536 - 1; i++){

  			*(BRAM_BASE_ADDR + 1) = HyperData[i];
  		}
  	xil_printf("UPLOADED HSI DATA \n");

//enable debugging
// print some values from the A matrix --- Debugging mode
*(BRAM_BASE_ADDR + 3) = 0;
for (int i = 0; i< 15; i++)
{

	*(BRAM_BASE_ADDR + 2) = i;
	printf("sr3: %d; ", *(BRAM_BASE_ADDR + 3));
	printf("sr2: %d; ", *(BRAM_BASE_ADDR + 2));
	printf("A: %d; ", *(BRAM_BASE_ADDR));
	printf("SR: %d; \n", *(BRAM_BASE_ADDR + 1));
}
xil_printf("END DEBUG \n");


//disable debug
*(BRAM_BASE_ADDR + 3) = 0;

// Copy matrix A contents to local memory
for (int i = 0; i< m_samples; i++)
{
	for(int j = 0 ; j < m_samples; j++)
	{
		*(BRAM_BASE_ADDR + 2) = i*m_samples + j;
		A_Mat[i][j] = *(BRAM_BASE_ADDR);
		A_Mat_Inv[i][j] = *(BRAM_BASE_ADDR); // copy of A matrix will be used for inverse

	}
}

//////////////// Receive Matrix B through AXI_Stream ////////////////////
// Hyperdata2 -> dummy data to send, we need to send some data even if it will not be used by MasterOutput to stream back matrix B
 datatype HyperData_2 [2] ;
 for (int i = 0; i< 2 ; i++)
 {
	 HyperData_2[i] = HyperData[i];
 }

int Status;
Status = setup_DMA();
if (Status != XST_SUCCESS) {
		xil_printf("FAILED SETTING UP DMA \n");
		printf("FAILED 1 ");
				return XST_FAILURE;
			}
xil_printf("Setup DMA for matrix B\n");
//send and receive packets
Status = main_DMA(HyperData_2, receiver, MAX_PKT_LEN, NUMBER_OF_TRANSFERS);
if (Status != XST_SUCCESS) {
			printf("FAILED 2");
			return XST_FAILURE;
		}
xil_printf("Matrix B Received!\n");

ReceiveData (receiver,N_Values_B);

//HW timer
u32 value2 = stop_timer ( 0 ); // Graph Construction timer
u32 Graph_HW_time = value2 - value1;


//debug print matrix B
for (int i = 0; i< 50; i++)
{
	printf("sr3: %d; ", receiver[i]);

}

for (int i = 0; i< m_samples; i++)
{
	for(int j = 0 ; j < N_Values_B; j++)
	{
		int k = i*m_samples + j;
		B_Mat[i][j] = receiver[k];

	}
}

//////////////// We got A and B /////////////////////////
/*
* This function calculates the inverse of the A matrix and pivoting
* information stored in 'P'. The inverse is returned through the matrix 'A' itself.
* 'B', X', and 'Y' are used as temporary spaces.
int LUPinverse(int size, int P[size], double LU[size][size], double B[size][size], double X[size], double Y[size])
*/
if(LUPinverse(m_samples, P, A_Mat_Inv,B,X,Y) < 0)
{
	printf("Matrix inversion unsuccessful.\n");
	return -1;
}
// forming A^(-1/2)
for (int i = 0; i< m_samples; i++)
{
	for(int j = 0 ; j < m_samples; j++)
	{
		A_Mat_Inv[i][j] = sqrt(A_Mat_Inv[i][j]);

	}
}
// forming B^T
for (int i = 0; i< m_samples; i++)
{
	for(int j = 0 ; j < N_Values_B; j++)
	{
    B_Mat_T[j][i] = B_Mat[i][j];
  }
}
// forming Q
outputtype_HLS Q_Mat [m_samples][m_samples] = {};
outputtype_HLS Q_tmp1 [m_samples][m_samples] = {};
outputtype_HLS Q_tmp2 [m_samples][m_samples] = {};
//  A^(-1/2)*(BB^T) * A^(-1/2)
for (int i = 0; i< m_samples; i++)
{
	for(int j = 0 ; j < m_samples; j++)
	{
		Q_tmp1[i][j]=0;
		for(int k=0; k < N_Values_B; k++)
		{
		Q_tmp1[i][j] += B_Mat[i][k] * B_Mat_T[k][j];
		}
		Q_tmp2[i][j]=0;
		for(int k=0; k < m_samples; k++)
		{
		Q_tmp2[i][j] += A_Mat_Inv[i][k] * Q_tmp1[k][j];
		}
		Q_Mat[i][j]=0;
		for(int k=0; k < m_samples; k++)
		{
		Q_Mat[i][j] += Q_tmp2[i][k] * A_Mat_Inv[k][j];
		}
	}
}

// Q = A + A^(-1/2)*(BB^T)* A^(-1/2)
for (int i = 0; i< m_samples; i++)
{
	for(int j = 0 ; j < m_samples; j++)
	{
		Q_Mat[i][j] = Q_Mat[i][j] + A_Mat[i][j];
	}

}

////////////////////// Send Q matrix to SVD /////////////////
// preparing Q for streaming (1D array)
outputtype_HLS Q_HLS[m_samples*m_samples];
for (int i = 0; i< m_samples; i++)
{
	for(int j = 0 ; j < m_samples; j++)
	{
		int k = i*m_samples + j;
		Q_HLS[k] = Q_Mat[i][j];
	}

}

value1 = start_timer ( 0 );

xil_printf("Setup HLS DMA core\n");

int status_HLS;

status_HLS = setup_DMA_HLS();
if (status_HLS != XST_SUCCESS)
{
	xil_printf("FAILED SETTING UP DMA \n");
	printf("FAILED setup HLS DMA ");
	return XST_FAILURE;
			}
xil_printf("Setup success\n");

xil_printf("Setup HLS HW Accelerator\n");

Setup_HW_Accelerator( Q_HLS,  receiver_HLS);

xil_printf("Setup success\n");
xil_printf("Run HW Accelerator\n");
int ind;
ind = Run_HW_Accelerator( Q_HLS,  receiver_HLS, NUMBER_OF_TRANSFERS );
if(ind != XST_SUCCESS){
print("HLS peripheral setup failed\n\r");
exit(-1);
 }
ReceiveData_HLS (receiver_HLS, HLS_OUT_SIZE);
xil_printf("Received SVD of Q\n");

value2 = stop_timer ( 0 ); // HLS SVD core timer
u32 HLS_Timer = value2 - value1;

// print some values of S
for (int i = 0; i< 36; i++)
{
	printf("sr3: %d \t %f; \n",i, receiver_HLS[i]);
}
// Reuse Q_tmp1 for collecting eigenvalues S
for (int i = 0; i< m_samples; i++)
{
	for(int j = 0 ; j < m_samples; j++)
	{	// square root eigenvalues of Q
		int k = i*m_samples + j;
		Q_tmp1[i][j] = receiver_HLS[k];
	}
}
// Reuse Q_tmp2 for collecting eigenvictors U=V
for (int i = 0; i< m_samples; i++)
{
	for(int j = 0 ; j < m_samples; j++)
	{
		int k = i*m_samples + j + (m_samples*m_samples);
		Q_tmp2[i][j] = receiver_HLS[k];  // eigenvectors of Q
	}
}
///// Forming matrix V ///////
// Get eigenvalues inverse
if(LUPinverse(m_samples, P, Q_tmp1,B,X,Y) < 0)
{
	printf("Matrix inversion unsuccessful.\n");
	return -1;
}
// forming \Lambda^(-1/2)
for (int i = 0; i< m_samples; i++)
{
	for(int j = 0 ; j < m_samples; j++)
	{
		Q_tmp1[i][j] = sqrt(Q_tmp1[i][j]);

	}
}

// forming Q
outputtype_HLS V_Mat [N_Values][m_samples] = {};
outputtype_HLS V_tmp1 [N_Values][m_samples] = {};
outputtype_HLS V_tmp2 [m_samples][m_samples] = {};
//forming [ A
//				B^T ]
for (int i = 0; i< N_Values; i++)
{
	for(int j = 0 ; j < m_samples; j++)
	{
		if (i < m_samples)
		V_tmp1[i][j]= A_Mat[i][j];
		else V_tmp1[i][j]= B_Mat_T[i][j];;
	}
}

// Reuse Q_Mat for forming matrix V
for (int i = 0; i< m_samples; i++)
{
	for(int j = 0 ; j < m_samples; j++)
	{
		Q_Mat[i][j]=0;
		for(int k=0; k < m_samples; k++)
		{
		Q_Mat[i][j] += Q_tmp2[i][j] * Q_tmp1[k][j];
		}
		V_tmp2[i][j]=0;
		for(int k=0; k < m_samples; k++)
		{
		V_tmp2[i][j] += A_Mat_Inv[i][j] * Q_Mat[k][j];
		}
	}
}
for (int i = 0; i< N_Values; i++)
{
	for(int j = 0 ; j < m_samples; j++)
	{
		V_Mat[i][j]=0;
		for(int k=0; k < m_samples; k++)
		{
		V_Mat[i][j] += V_tmp1[i][j] * V_tmp2[k][j];
		}
	}
}
/////// Spectral Embedding  //////////////
int k = 6 ; // number of clusterings
float embed [N_Values][m_samples];
float (*y_ptr)[N_Values*k] = 0;
for (int col = 0 ; col<k ; col++)
{
    for (int row = 0 ; row<N_Values ; row++)
    {
    	int l = row*k + col;
        embed[row][col] = V_Mat[row][col+1]/V_Mat[row][0];
        *y_ptr[l] = embed[row][col];
    }
}

///////////// K-means Clustering //////////////

int *final_cluster_assignment=0;
int point_num, dim;
srand((unsigned) 0);
point_num = rand();
dim = k;
float *centroids = (float *)malloc(sizeof(float) * dim * k);
for ( int clust_num = 0; clust_num < k; clust_num++ )
{
    point_num = rand();
    point_num = point_num % N_Values;
    for ( int dim_num = 0; dim_num < dim; dim_num++ )
    {
    centroids[clust_num*dim + dim_num] = *y_ptr[point_num*dim + dim_num];
    }
}
kmeans(dim,		     // dimension of data -> k columns of E
		*y_ptr, // 1D pointer to eigenvectos
		N_Values,            // number of elements of y.
	   k,            // number of clusters
	   centroids,         // initial cluster centroids
	   final_cluster_assignment  // output
           );
// print final clusters
for (int i =0; i < 10 ; i++)
{
	printf("Clusters:  %d; \n", final_cluster_assignment[i]);
}


outputtype Clusters_32t[N_Values];
	for(int i=0;i<N_Values;i++){
		Clusters_32t[i]= (s32)( final_cluster_assignment[i]);
    	}

write_data(ResultsFile, Clusters_32t);

//Stop timer
XTime_GetTime(&tEnd);


xil_printf ("\n HW Timer : %d\n", HLS_Timer + Graph_HW_time );

printf("t=%15.5lf sec\n",(long double)((tEnd-tStart) *2)/(long double)XPAR_PS7_CORTEXA9_0_CPU_CLK_FREQ_HZ);


  cleanup_platform();

  return 0;

}
