# High Performance Computing
The crucial point in *High Performance Parallel Programming* is to understand which part of the code should use CPU and which will benefit from the execution on a GPU. 

## CPU vs GPU
| CPU | GPU |
| --- | --- |
| Latency oriented device | Throughput oriented device |
| ALUs are powerful but small in number | ALUs are Efficient but large in number |
| Large Cache | Small Cache |
| Sophisticated control unit | Simple control unit |

> CPUs are effective for sequential parts of a program while GPUs thrive on parallel parts.

## Vector Addition
CUDA C++ example:

```cpp
// Essential Imports
#include <iostream>
#include <assert.h>
#include <cuda.h>
#include <cuda_runtime.h>
using namespace std;

// Importing custom class Vector and functions
#include "Vector.cu"
#include "utils.cu"
#include "vecAdd.cu"

int main() {
    // Length of an array entered by the user
    int len = 0;
    std::cout <<"Enter the length of vector: ";
    std::cin >> len;

    // Initialising vectors
    Vector v1(len), v2(len), v3(len);

    // Random numbers in vector
    rand_init(v1);
    rand_init(v2);
    // Zeros in vector
    val_init(v3,0);

    // Prints out the initialised vectors
    print(v1, "v1");
    print(v2, "v2");
    print(v3, "v3");


    // Moving data to GPU and not deleting the data in RAM
    Vector d_v1 = toDevice(v1, false);
    Vector d_v2 = toDevice(v2, false);
    Vector d_v3 = toDevice(v3, false);

    // CPU sum
    add(v1, v2, v3);
    print(v3, "v3");

    // GPU sum
    int numThrds = 256; // Number of threads per block
    addDevice(d_v1, d_v2, d_v3, numThrds);
    
    // Moving back result from GPU
    Vector h_v3 = toHost(d_v3);

    print(h_v3, "h_v3");
    
    return 0;
}
```
```
Enter the length of vector: 4
Vector v1: 13.8333 15.4 18.6 43 
Vector v2: 49 8.85714 10 10.5 
Vector v3: 0 0 0 0 
Memory Allocation on Device success! 
Memory Allocation on Device success! 
Memory Allocation on Device success! 
Vector v3: 62.8333 24.2571 28.6 53.5 
Freed device memory! 
Vector h_v3: 62.8333 24.2571 28.6 53.5 
```