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

Base::Base(){

}

Base::~Base(){

}

Derived1::Derived1(){

}

Derived1::~Derived1(){

}

void Derived1::print(){
	cout << "DERIVED1" << std::endl;

}

Derived2::Derived2(){
	cout << "DERIVED2" << std::endl;

}

Derived2::~Derived2(){

}

void Derived2::print(){

}

Container::Container(){
	bases = NULL;
	d1 = NULL;
	d2 = NULL;

}

Container::~Container(){

}
