#include <iostream>
#include <stdlib.h>
#include <assert.h>

using namespace std;

class Vector {
    public:
    // Length attribute
    int len = 0;
    // Pointer to the vector
    float *ptr = 0;

    // Constructor to randomly initialise vector
    Vector(int len) {
        Vector::len = len;

        Vector::ptr = new float[len];
        for (int i = 0; i < len; i++)
        {
            float r1 = rand() % 100;
            float r2 = rand() % 10;

            Vector::ptr[i] = r1/r2;
        }
    }

    // Constructor to initialise vector as specific value
    Vector(int len, float val) {
        Vector::len = len;

        Vector::ptr = new float[len];
        for (int i = 0; i < len; i++)
            Vector::ptr[i] = val;
    }

    // Constructor to specifically initialise vector
    Vector(float *ptr, int len) {
        Vector::len = len;
        Vector::ptr = new float[len];
        
        Vector::ptr = ptr;
    }

    // Print vector
    void print(string name);

    // Get value at a specific index
    float operator[](int i);

    // Assign value at a specific index
    void put(float val, int idx);
};

void Vector::print(string name) {
    std::cout << "Vector " << name << ": " ;

    for (int i = 0; i < Vector::len; i++)
        std::cout << Vector::ptr[i] << " ";
    std::cout << "\n";
}

float Vector::operator[](int i) {
    return Vector::ptr[i];
}

void Vector::put(float val, int idx) {
    Vector::ptr[idx] = val;
}


void add(Vector v1, Vector v2, Vector v3) {
    assert (v1.len == v2.len);
    assert (v1.len == v3.len);

    for (int i = 0; i < v1.len; i++)
        v3.put(v1[i] + v2[i], i);
}
/*
int main() {
    int len = 0;
    std::cout <<"Enter the length of vector: ";
    std::cin >> len;

    // Testing constructor 1
    Vector v1(len);

    v1.print();

    // Testing constructor 2
    float *ptr = 0;
    ptr = new float[len];

    for (int i = 0; i < len; i++)
    {
        float r1 = rand() % 100;
        float r2 = rand() % 10;

        ptr[i] = r1/r2;
    }

    Vector v2(ptr, len);

    v2.print();

    return 0;
}
*/