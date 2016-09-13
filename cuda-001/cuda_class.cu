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

#include "cuda_class.h"

using namespace std;

__device__ Base::Base(){

}

__device__ Base::~Base(){
}

__device__ Derived1::Derived1(){
	printf(" Derived1 created\n");

}

__device__ Derived1::~Derived1(){
	printf(" Derived1 deleted\n");

}

__device__ void Derived1::print(int i){
	printf(description);
	printf(" DERIVED_1 : %d\n", i);

}

__device__ Derived2::Derived2(){
	printf(" Derived2 created\n");

}

__device__ Derived2::~Derived2(){
	printf(" Derived2 deleted\n");

}

__device__ void Derived2::print(int i){
	printf(description);
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
	num_d1 = amount1;
	num_d2 = amount2;

	int t = amount1 + amount2;
	classes = new Base*[t];

	for(int i = 0; i < amount1; i++){
		//classes[i] = reinterpret_cast<Base *>(new Derived1());
		classes[i] = new Derived1();
	}

	for(int i = amount1; i < t; i++){
		//classes[i] = reinterpret_cast<Base *>(new Derived2());
		classes[i] = new Derived2();
	}
}

__device__ void Container::cleanup(){

	// delete all instances
	int t = num_d1 + num_d2;
	for(int i = 0; i < t; i++){
		Base *p;
		//p = reinterpret_cast<Base *>(classes[i]);
		p = classes[i];
		if(p != NULL){
			delete p;
			printf(" deleted pointer %d of %d\n", i, t);
		}
	}

	// delete the master pointer
	if(classes != NULL){
		delete[] classes;
		printf(" deleted master pointer\n");
	}

	num_d1 = 0;
	num_d2 = 0;
}
