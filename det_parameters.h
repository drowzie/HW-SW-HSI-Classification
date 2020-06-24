//#define	DEBUG 1
#define ALG1

//image size
//#define N_bands 16
#define N_bands 16
//#define N_pixels (512*217)
//#define N_pixels (86*83)
#define N_pixels (7138)

#define m_samples (50)

#define N_Values (4096)

#define N_Values_B ((N_Values-m_samples))

#define Total_Values_B (m_samples*(N_Values-m_samples))

#define HLS_OUT_SIZE (m_samples*m_samples*3)

#define ST_SIZE 36

#define threshold 0.99

//change these together
#define byte_in 2   	   //input byte size
//#define byte_in 8   	   //input byte size
#define byte_out 8		   //output byte size
//typedef s16 datatype;
//typedef s32 datatype;
//typedef s64 outputtype;


typedef s32 datatype;
typedef s32 outputtype;


typedef float datatype_HLS;
typedef float outputtype_HLS;


#define image_file_name "spca_32.bin"
//#define image_file_name "spca_d.bin"
#define results_file_name "results.bin"


#define corr_percent 100  //correlation subsampling
