#include <iostream>
using namespace std;

#include "Vector.cu"
#include "utils.cu"
#include "vecAdd.cu"

int main() {
    // Length of an array
    int len = 0;
    std::cout <<"Enter the length of vector: ";
    std::cin >> len;

    Vector v1(len), v2(len), v3(len);

    // Initialising vectors
    rand_init(v1);
    rand_init(v2);
    val_init(v3,0);

    print(v1, "v1");
    print(v2, "v2");
    print(v3, "v3");

    // CPU sum
    add(v1, v2, v3);
    print(v3, "v3");

    // Moving to GPU
    Vector d_v1 = toDevice(v1, true);
    print(v1, "v1");
    
    // Moving back from GPU
    Vector h_v1 = toHost(d_v1);

    print(h_v1, "h_v1");

    return 0;
}