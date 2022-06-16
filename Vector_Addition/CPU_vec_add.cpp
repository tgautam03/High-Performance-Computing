#include <iostream>
using namespace std;

#include "Vector.cpp"

int main() {
    // Length of an array
    int len = 0;
    std::cout <<"Enter the length of vector: ";
    std::cin >> len;

    Vector v1(len), v2(len), v3(len, 0);

    v1.print("v1");
    v2.print("v2");
    v3.print("v3");

    add(v1, v2, v3);

    v3.print("v3");
    return 0;
}