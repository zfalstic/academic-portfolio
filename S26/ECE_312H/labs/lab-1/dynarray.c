// ECE 312 - Dynamic Array Lab
// Name: <Your Name Here>
// EID:  <Your EID Here>

#include <stdlib.h>
#include "dynarray.h"

/*
 * Creates a new DynamicArray with the specified initial capacity.
 * Returns: Pointer to the new DynamicArray, or NULL on failure
 */
DynamicArray* createArray(int initialCapacity) {
    if(initialCapacity <= 0) return NULL;

    DynamicArray* arr = malloc(sizeof(DynamicArray));
    int* dataptr = malloc(sizeof(int) * initialCapacity);

    if(dataptr == NULL) {
        free(dataptr);
        free(arr);
        return NULL;
    }

    arr->data = dataptr;
    arr->size = 0;
    arr->capacity = initialCapacity;
    return arr;
}

/*
 * Frees all memory associated with the DynamicArray.
 */
void destroyArray(DynamicArray* arr) {
    if(arr == NULL) return;
    free(arr->data);
    free(arr);
}

/*
 * Adds an element to the end of the array.
 * Returns: 0 on success, -1 on failure
 */
int addElement(DynamicArray* arr, int value) {
    if(arr == NULL) return -1;
    if(arr->size == arr->capacity) {
        int* newptr = realloc(arr->data, arr->capacity * 2 * sizeof(int));
        if(newptr == NULL) return -1;
        arr->capacity = arr->capacity * 2;
        arr->data = newptr;
    }
    arr->data[arr->size] = value;
    arr->size++;
    return 0;
}

/*
 * Retrieves the element at the specified index.
 * Returns: 0 on success, -1 on failure (invalid index or NULL pointers)
 */
int getElement(DynamicArray* arr, int index, int* result) {
    if(arr == NULL || result == NULL) return -1;
    if(index < 0 || index >= arr->size) return -1;
    *result = arr->data[index];
    return 0;
}

/*
 * Sets the element at the specified index to the given value.
 * Returns: 0 on success, -1 on failure
 */
int setElement(DynamicArray* arr, int index, int value) {
    if(arr == NULL) return -1;
    if(index < 0 || index >= arr->size) return -1;
    arr->data[index] = value;
    return 0;
}

/*
 * Returns the current number of elements in the array.
 * Returns -1 if arr is NULL.
 */
int getSize(DynamicArray* arr) {
    if(arr == NULL) return -1;
    return arr->size;
}

/*
 * Returns the current capacity of the array.
 * Returns -1 if arr is NULL.
 */
int getCapacity(DynamicArray* arr) {
    if(arr == NULL) return -1;
    return arr->capacity;
}

/*
 * Removes the element at the specified index.
 * Returns: 0 on success, -1 on failure
 */
int removeElement(DynamicArray* arr, int index) {
    if(arr == NULL) return -1;
    if(index < 0 || index >= arr->size) return -1;
    for(int i = index; i < arr->size; i++) {
        arr->data[i] = arr->data[i + 1];
    }
    arr->size--;
    return 0;
}
