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

Container::Container(){
	bases = NULL;
	derivations = NULL;

}

Container::~Container(){

}
