// Includes
#include <iostream>
#include <fstream>
#include <stdlib.h>
#include <string>
#include <time.h>

#include <cuda.h>
#include <cuda_runtime.h>

#define GLM_FORCE_CUDA
#include <glm.hpp>

#include "cuda_class.h"

using namespace std;

// Defs
#ifdef _WIN32
#  define WINDOWS_LEAN_AND_MEAN
#  define NOMINMAX
#  include <windows.h>
#endif


__global__ void KERNEL_SETUP(Container *container){
	container->init(5,5);

}

__global__ void KERNEL_CLEANUP(Container *container){
	container->cleanup();
}

__global__ void KERNEL_MAIN(Container *container){
	for(int i=0; i< container->num_d1; i++){
		container->d1[i].print();
	}

	for(int i=0; i< container->num_d2; i++){
		container->d2[i].print();
	}

}

int main(int argc, const char * argv[]){
	cudaError_t result = cudaSuccess;
	const char *resultString;

	Container *c;

	cudaMalloc((void**)&c, sizeof(Container));
	result = cudaGetLastError();
	if(result != cudaSuccess){
		resultString = cudaGetErrorString(result);
		cout << "Error : " << resultString << std::endl;
	}

	KERNEL_SETUP<<<1,1>>>(c);
	cudaDeviceSynchronize();
	result = cudaGetLastError();
	if(result != cudaSuccess){
		resultString = cudaGetErrorString(result);
		cout << "Error : " << resultString << std::endl;
	}
	cout << "SETUP OK..." << std::endl;

	KERNEL_MAIN<<<1,1>>>(c);
	cudaDeviceSynchronize();
	result = cudaGetLastError();
	if(result != cudaSuccess){
		resultString = cudaGetErrorString(result);
		cout << "Error : " << resultString << std::endl;
	}
	cout << "MAIN OK..." << std::endl;

	KERNEL_CLEANUP<<<1,1>>>(c);
	cudaDeviceSynchronize();
	result = cudaGetLastError();
	if(result != cudaSuccess){
		resultString = cudaGetErrorString(result);
		cout << "Error : " << resultString << std::endl;
	}

	if(c != NULL) cudaFree(c);
	result = cudaGetLastError();
	if(result != cudaSuccess){
		resultString = cudaGetErrorString(result);
		cout << "Error : " << resultString << std::endl;
	}
	cout << "CLEANUP OK..." << std::endl;

	// get outta here
	cudaDeviceReset();
	return EXIT_SUCCESS;

}
