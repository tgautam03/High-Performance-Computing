// Forward declaration
__global__ void addKernel(float *a, float *b, float *c, int N);

void add(Vector v1, Vector v2, Vector v3) 
{
    assert (v1.device == false && v2.device == false && v3.device == false);
    assert (v1.len == v2.len);
    assert (v1.len == v3.len);

    for (int i = 0; i < v1.len; i++)
        v3.ptr[i]=v1.ptr[i] + v2.ptr[i];
}


void addDevice(Vector &v1, Vector &v2, Vector &v3, int numThrds)
{
    assert (v1.device == true && v2.device == true && v3.device == true);
    assert (v1.len == v2.len);
    assert (v1.len == v3.len);

    // addDevice(d_v1, d_v2, d_v3, 256);
    int thr_per_blk = numThrds;
    int blk_in_grid = ceil( float(v1.len) / thr_per_blk );

    // Launch kernel
    addKernel<<< blk_in_grid, thr_per_blk >>>(v1.ptr, v2.ptr, v3.ptr, v1.len);
}


// Kernel
__global__ void addKernel(float *a, float *b, float *c, int N)
{
    int id = blockDim.x * blockIdx.x + threadIdx.x;
    if(id < N) c[id] = a[id] + b[id];
}
