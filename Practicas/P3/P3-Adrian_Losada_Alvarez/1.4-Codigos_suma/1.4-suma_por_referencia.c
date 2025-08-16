#include <stdio.h>

int suma(int a, int b, int *c) {
    *c = a + b;
}

int main() {
    int a=5, b=10, c;

    suma(a, b, &c);

    return 0;
}
