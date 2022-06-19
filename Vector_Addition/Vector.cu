#include <iostream>
#include <stdlib.h>
#include <cuda.h>
#include <cuda_runtime.h>

using namespace std;

class Vector 
{
    public:
    // Length attribute
    int len = 0;
    // Pointer to the vector
    float *ptr = 0;
    // device
    bool device = false;

    // Constructor to setup vector pointer
    Vector(int, bool); 

    // Free up the memory
    void free();
};


// Constructor to setup vector pointer
Vector::Vector(int len_, bool device_=false) 
{
    Vector::len = len_;
    Vector::device = device_;

    if (device_ == false)
        Vector::ptr = new float[len_];
    else
    {
        cudaError_t err = cudaMalloc((void**)&(Vector::ptr), (Vector::len)*sizeof(float));

        if (err != cudaSuccess)
        {
            std::cout << cudaGetErrorString(err) << " in " 
            << __FILE__ << " at " << __LINE__ << "\n";

            exit(EXIT_FAILURE);
        }
        else
            std::cout << "Memory Allocation on Device success! \n";
    }
}


void Vector::free() {
    if (Vector::device == false)
    {
        delete[] Vector::ptr;
        std::cout << "Freed host memory! \n";
    }
    else
    {
        cudaFree(Vector::ptr);
        std::cout << "Freed device memory! \n";
    }
}