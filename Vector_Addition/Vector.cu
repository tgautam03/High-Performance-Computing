#include <iostream>
#include <stdlib.h>
#include <assert.h>
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
    Vector(int len, bool device=false) 
    {
        Vector::len = len;
        Vector::device = device;

        if (device == false)
            Vector::ptr = new float[len];
        else
            cudaMalloc((void**)&(Vector::ptr), (Vector::len)*sizeof(float));
    }

    // Get value at a specific index
    float operator[](int idx);

    // Assign value at a specific index
    void put(float val, int idx);

    // Free up the memory
    void free();
};

float Vector::operator[](int idx) {
    return Vector::ptr[idx];
}

void Vector::put(float val, int idx) {
    Vector::ptr[idx] = val;
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