/*
 * main.h
 *
 *  Created on: 13 Sep 2016
 *      Author: erik
 */

#ifndef MAIN_H_
#define MAIN_H_

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

using namespace std;

// Abstract class
class Base{
public:
	__device__ Base();
	__device__ virtual ~Base() = 0;

	__device__ virtual void print(int i) = 0;

private:
protected:

};

// Derived from Base
class Derived1: public Base{
public:
	__device__ Derived1();
	__device__ ~Derived1();

	__device__ void print(int i);
private:
protected:

};

class Derived2: public Base{
public:
	__device__ Derived2();
	__device__ ~Derived2();
	__device__ void print(int i);
private:
protected:

};

// Wrapper class
class Container{
public:
	Container();
	~Container();

	__device__ void init(int d1, int d2);
	__device__ void cleanup();

	int			num_d1;
	int 		num_d2;

	// array of pointers to derived classes
	Base**		classes;
private:
protected:
};

#endif /* MAIN_H_ */
