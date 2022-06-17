#include <iostream>
#include <stdlib.h>
#include <assert.h>


// Randomly initialise a vector
void rand_init(Vector h_v) 
{
    assert (h_v.device == false);
    for (int i = 0; i < h_v.len; i++)
    {
        float r1 = rand() % 100;
        float r2 = rand() % 10;

        h_v.ptr[i] = r1/r2;
    }
}

// Initialise a vector with specific value
void val_init(Vector h_v, float val) 
{
    assert (h_v.device == false);
    for (int i = 0; i < h_v.len; i++)
        h_v.ptr[i] = val;
}

// Print the vector
void print(Vector h_v, string name)
{
    assert (h_v.device == false);
    std::cout << "Vector " << name << ": " ;

    for (int i = 0; i < h_v.len; i++)
        std::cout << h_v.ptr[i] << " ";
    std::cout << "\n";
}

// Move data to device
Vector toDevice(Vector h_v, bool del=false)
{
    assert (h_v.device == false);

    Vector d_v(h_v.len, true);
    cudaMemcpy(d_v.ptr, h_v.ptr, h_v.len*sizeof(float), cudaMemcpyHostToDevice);

    if (del==true)
        h_v.free();

    return d_v;
}

// Move data to Host 
Vector toHost(Vector d_v, bool del=true)
{
    assert (d_v.device == true);

    Vector h_v(d_v.len, false);
    cudaMemcpy(h_v.ptr, d_v.ptr, d_v.len*sizeof(float), cudaMemcpyDeviceToHost);

    if (del==true)
        d_v.free();

    return h_v;
}