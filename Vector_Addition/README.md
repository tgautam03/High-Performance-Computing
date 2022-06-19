# Vector Addition

## CUDA C++

The very first thing I've done here is to define a custom class `Vector`. It has: 
- the length (`len`) of the vector, 
- along with the pointer `ptr` to the data in memory, and 
- a bool variable `device` indication if the memory is allocated on RAM or VRAM (`true` for VRAM and `false` for RAM).
- There's also a constructor which enables easy definition of the `Vector` type.

```cpp
// Defining 3 Vectors and allocating space in RAM
Vector v1(len), v2(len), v3(len); 
```
> Note that by default, the secomd argument is `false`, i.e. if we want to allocate memory on VRAM we would write something like `Vector v(len, true);`

For details see the file [Vector.cu](https://github.com/tgautam03/High-Performance-Computing/blob/main/Vector_Addition/Vector.cu)

The next thing to do is initialise the above defined vectors with values. I'll randomly initialise `v1`, `v2` and zero initialise `v3`.

```cpp
// Initialising vectors
rand_init(v1);
rand_init(v2);
val_init(v3,0);
```

I'm using custom functions here which can be found in [utils.cu](https://github.com/tgautam03/High-Performance-Computing/blob/main/Vector_Addition/utils.cu) file.

Now, let's move these to VRAM. I'm again using a custom function here which is defined in [utils.cu](https://github.com/tgautam03/High-Performance-Computing/blob/main/Vector_Addition/utils.cu) file.

```cpp
// Moving to GPU and not deleting the data in RAM
Vector d_v1 = toDevice(v1, false);
Vector d_v2 = toDevice(v2, false);
Vector d_v3 = toDevice(v3, false);
```

Next, I'll perform computation on CPU and GPU respectively, and move data back from VRAM to RAM. 

```cpp
// CPU sum
add(v1, v2, v3);
print(v3, "v3");

// GPU sum
int numThrds = 256;
addDevice(d_v1, d_v2, d_v3, numThrds);

// Moving back from GPU
Vector h_v3 = toHost(d_v3);
```

All these functions are defined in [utils.cu](https://github.com/tgautam03/High-Performance-Computing/blob/main/Vector_Addition/utils.cu) and [vecAdd.cu](https://github.com/tgautam03/High-Performance-Computing/blob/main/Vector_Addition/vecAdd.cu) file.

**Minimum Reproducible** example can be found in file [main.cu](https://github.com/tgautam03/High-Performance-Computing/blob/main/Vector_Addition/main.cu).

