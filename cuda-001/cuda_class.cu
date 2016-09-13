/*
 *
 */

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

__device__ Base::Base(){

}

__device__ Base::~Base(){

}

__device__ Derived1::Derived1(){

}

__device__ Derived1::~Derived1(){

}

__device__ void Derived1::print(){
	printf(" DERIVED_1\n");

}

__device__ Derived2::Derived2(){

}

__device__ Derived2::~Derived2(){

}

__device__ void Derived2::print(){
	printf(" DERIVED_2\n");

}

Container::Container(){

	num_d1 = 0;
	num_d2 = 0;

	d1 = NULL;
	d2 = NULL;

}

Container::~Container(){

}

__device__ void Container::init(int amount1, int amount2){
	d1 = new Derived1[amount1];
	d2 = new Derived2[amount2];
}

__device__ void Container::cleanup(){
	if(d1 != NULL) delete[] d1;
	if(d2 != NULL) delete[] d2;
}
