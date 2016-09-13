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
	container->d1 = new Derived1();
	container->d2 = new Derived2();

}

__global__ void KERNEL_CLEANUP(Container *container){
	if(container->d1 != NULL) delete(d1);
	if(container->d2 != NULL) delete(d2);

}

__global__ void KERNEL_MAIN(Container *container){

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

	// init container with 5 derived classes each
	c->init(5,5);

	KERNEL_SETUP<<<1,1>>>(c);
	cudaDeviceSynchronize();
	result = cudaGetLastError();
	if(result != cudaSuccess){
		resultString = cudaGetErrorString(result);
		cout << "Error : " << resultString << std::endl;
	}

	KERNEL_MAIN<<<1,1>>>(c);
	cudaDeviceSynchronize();
	result = cudaGetLastError();
	if(result != cudaSuccess){
		resultString = cudaGetErrorString(result);
		cout << "Error : " << resultString << std::endl;
	}

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

	// get outta here
	cudaDeviceReset();
	return EXIT_SUCCESS;

}
