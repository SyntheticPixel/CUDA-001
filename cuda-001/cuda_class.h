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
	Base();
	virtual ~Base() = 0;

	virtual void print() = 0;

private:
protected:

};

// Derived from Base
class Derived1: public Base{
public:
	Derived1();
	~Derived1();
private:
protected:

};

class Container{
public:
	Container();
	~Container();

	Base 		*bases;
	Derived1 	*derivations;
private:
protected:
};

#endif /* MAIN_H_ */
