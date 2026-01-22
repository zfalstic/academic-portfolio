// ECE 312 Lab 0
// Dawson Zhang
// ddz249
// Spring 2026

#include "Lab0.h"
#include "math.h"

/*
    Write a function that takes in an integer x and returns 1 if x is prime and 0 if x is not prime.
*/
int isPrime(int x) {
    if(x < 2) {
        return 0;
    }
    for(int i = 2; i < x; i++) {
        if(x % i == 0) {
            return 0;
        }
    }
    return 1;
}

/*
    Write a function that takes in two legs of a right triange, x and y, and returns the length of the hypotenuse.
*/
double calculateHypotenuse(double x, double y) {
    if(x < 0 || y < 0) {
        return -1;
    }
    return sqrt(x * x + y * y);
}

/*
    Write a function that finds the greatest common divisor of two integers x and y.
*/
int gcd(int x, int y) {
    int result = 1;
    for(int i = 2; i <= x * y; i++) {
        if(x % i == 0 && y % i == 0) {
            result = i;
        }
    }
    return result;
}
