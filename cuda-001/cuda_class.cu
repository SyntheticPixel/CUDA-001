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
	printf("0");

}

__device__ Base::~Base(){
	printf("0");
}


__device__ void Base::print(int i){
	printf(" BASE : %d\n", i);

}

__device__ Derived1::Derived1(){
	printf("1");

}

__device__ Derived1::~Derived1(){
	printf("-1");

}

__device__ void Derived1::print(int i){
	printf(" DERIVED_1 : %d\n", i);

}

__device__ Derived2::Derived2(){
	printf("2");

}

__device__ Derived2::~Derived2(){
	printf("-2");
}

__device__ void Derived2::print(int i){
	printf(" DERIVED_2 : %d\n", i);

}

Container::Container(){

	num_d1 = 0;
	num_d2 = 0;

	classes = NULL;
}

Container::~Container(){

}

__device__ void Container::init(int amount1, int amount2){

	// add the claases to the vector

	int t = amount1 + amount2;
	classes = new Base*[t];

	for(int i = 0; i < amount1; i++){
		classes[i] = new Derived1();
		printf("\n");
	}

	for(int i = amount1; i < amount1+amount2; i++){
		classes[i] = new Derived2();
		printf("\n");
	}
}

__device__ void Container::cleanup(){

	// delete all instances
	int t = num_d1 + num_d2;
	for(int i = 0; i < t; i++){
		Base * p;
		p = classes[i];
		if(p != NULL) delete p;
	}

	// delete the master pointer
	if(classes != NULL) delete[] classes;

	num_d1 = 0;
	num_d2 = 0;
}
