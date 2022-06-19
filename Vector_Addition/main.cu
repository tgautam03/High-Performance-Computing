#include <iostream>
#include <assert.h>
#include <cuda.h>
#include <cuda_runtime.h>
using namespace std;

#include "Vector.cu"
#include "utils.cu"
// #include "vecAdd.cu"

int main() {
    // Length of an array
    int len = 0;
    std::cout <<"Enter the length of vector: ";
    std::cin >> len;

    Vector v1(len), v2(len), v3(len);
    // initialise(v1, len); initialise(v2, len); initialise(v3, len);

    // Initialising vectors
    rand_init(v1);
    rand_init(v2);
    val_init(v3,0);

    print(v1, "v1");
    print(v2, "v2");
    print(v3, "v3");


    // Moving to GPU
    Vector d_v1 = toDevice(v1, false);
    Vector d_v2 = toDevice(v2, false);
    Vector d_v3 = toDevice(v3, false);

    // CPU sum
    // add(v1, v2, v3);
    // print(v3, "v3");

    // GPU sum
    int numThrds = 256;
    // int thr_per_blk = numThrds;
    // int blk_in_grid = ceil( float(v1.len) / thr_per_blk );

    // // Launch kernel
    // addKernel<<< blk_in_grid, thr_per_blk >>>(d_v1.ptr, d_v2.ptr, d_v3.ptr, d_v1.len);
    // addDevice(d_v1, d_v2, d_v3, numThrds);
    
    // Moving back from GPU
    // Vector h_v3 = toHost(d_v3);

    // print(h_v3, "h_v3");

    return 0;
}