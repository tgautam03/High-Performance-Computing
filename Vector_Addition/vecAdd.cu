#include <iostream>
#include <cuda.h>
#include <cuda_runtime.h>

using namespace std;

void add(Vector v1, Vector v2, Vector v3) {
    assert (v1.device == false && v2.device == false && v3.device == false);
    assert (v1.len == v2.len);
    assert (v1.len == v3.len);

    for (int i = 0; i < v1.len; i++)
        v3.put(v1[i] + v2[i], i);
}