// ECE 312 - Linked List Lab
// Name: Dawson Zhang
// EID: ddz249

#include <stdlib.h>
#include "linkedlist.h"

/*
 * Creates a new empty linked list.
 * 
 * Returns: Pointer to the new LinkedList, or NULL on failure
 */
LinkedList* createList(void) {
    LinkedList* newList = (LinkedList*)malloc(sizeof(LinkedList));
    if(newList) {
        newList->head = NULL;
        newList->size = 0;
    }
    return newList;
}

/*
 * Frees all memory associated with the linked list.
 * 
 * Returns: Nothing 
 */
void destroyList(LinkedList* list) {
    if(!list) return;
    if(!(list->head)) {
        free(list);
        return;
    }

    Node* current = list->head;
    Node* next;
    do {
        next = current->next;
        free(current);
        current = next;
    } while (current);
    free(list);
}

/*
 * Inserts a new element at the front (head) of the list.
 * 
 * Returns: 0 on success, -1 on failure
 */
int insertAtHead(LinkedList* list, int value) {
    if(!list) return -1;
    Node* newNode = (Node*)malloc(sizeof(Node));
    if(!newNode) return -1;

    newNode->data = value;
    newNode->next = list->head;
    list->head = newNode;
    list->size++;
    return 0;
}

/*
 * Inserts a new element at the end (tail) of the list.
 * 
 * Returns: 0 on success, -1 on failure
 */
int insertAtTail(LinkedList* list, int value) {
    if(!list) return -1;
    list->size++;

    Node* newNode = (Node*)malloc(sizeof(Node));
    if(!newNode) return -1;

    newNode->data = value;
    newNode->next = NULL;
    if(!(list->head)) {
        list->head = newNode;
        return 0;
    }

    Node* current = list->head;
    while(current->next) {
        current = current->next;
    }
    current->next = newNode;
    return 0;
}

/*
 * Inserts a new element at the specified index.
 *
 * Returns: 0 on success, -1 if index invalid or allocation fails
 */
int insertAtIndex(LinkedList* list, int index, int value) {
    if(!list) return -1;
    if(index < 0 || index > list->size) return -1;
    if(index == 0) return insertAtHead(list, value);
    if(index == list->size) return insertAtTail(list, value);

    Node* newNode = (Node*)malloc(sizeof(Node));
    if(!newNode) return -1;
    newNode->data = value;

    Node* current = list->head;
    for(int i = 0; i < index - 1; i++) {
        if(!current) return -1;
        current = current->next;
    }
    newNode->next = current->next;
    current->next = newNode;
    list->size++;
    return 0;
}

/*
 * Removes the element at the front (head) of the list.
 *
 * Returns: 0 on success, -1 if list is empty
 */
int removeAtHead(LinkedList* list) {
    if(!list) return -1;
    if(!(list->head)) return -1;

    Node* nodeTemp = list->head->next;
    free(list->head);
    list->head = nodeTemp;
    list->size--;
    return 0;
}

/*
 * Removes the element at the specified index.
 * 
 * Returns: 0 on success, -1 if index is out of bounds
 */
int removeAtIndex(LinkedList* list, int index) {
    if(!list) return -1;
    if(index < 0 || index > list->size - 1) return -1;
    if(index == 0) return removeAtHead(list);

    Node* current = list->head;
    for(int i = 0; i < index - 1; i++) {
        if(!current) return -1;
        current = current->next;
    }

    Node* nodeTemp = current->next->next;
    free(current->next);
    current->next = nodeTemp;
    list->size--;
    return 0;
}

/*
 * Retrieves the element at the specified index.
 *
 * Returns: 0 on success, -1 if index out of bounds or NULL pointers
 */
int getElement(LinkedList* list, int index, int* result) {
    if(!list) return -1;
    if(index < 0 || index >= list->size) return -1;

    Node* current = list->head;
    for(int i = 0; i < index; i++) {
        if(!current) return -1;
        current = current->next;
    }
    *result = current->data;
    return 0;
}

/*
 * Returns the number of elements in the list.
 *
 * Returns -1 if list is NULL.
 */
int getSize(LinkedList* list) {
    if(!list) return -1;
    return list->size;
}
