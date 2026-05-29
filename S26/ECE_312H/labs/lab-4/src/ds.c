#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <ctype.h>
#include "lab4.h"

/* ----------------------------------------------------------------
 * ds.c  --  all data structures for the Tech Support Diagnosis Tool
 *
 * Implement every function marked TODO.  The only functions in this
 * entire lab permitted to use recursion are free_tree and count_nodes.
 * Everything else must be iterative.
 * ---------------------------------------------------------------- */


/* ====== Tree nodes ============================================== */

/* TODO 1 */
Node *create_question_node(const char *question) {
    if(question == NULL) return NULL;

    Node* newNode = (Node*)malloc(sizeof(Node));
    if(newNode == NULL) return NULL;

    newNode->yes = NULL;
    newNode->no = NULL;
    newNode->isQuestion = 1;

    newNode->text = (char*)malloc(strlen(question) + 1);
    if(newNode->text == NULL) return NULL;
    strcpy(newNode->text, question);

    return newNode;
}

/* TODO 2 */
Node *create_solution_node(const char *solution) {
    if(solution == NULL) return NULL;

    Node* newNode = (Node*)malloc(sizeof(Node));
    if(newNode == NULL) return NULL;

    newNode->yes = NULL;
    newNode->no = NULL;
    newNode->isQuestion = 0;

    newNode->text = (char*)malloc(strlen(solution) + 1);
    if(newNode->text == NULL) return NULL;
    strcpy(newNode->text, solution);

    return newNode;
}

/* TODO 3  (recursion allowed) */
void free_tree(Node *node) {
    if(node == NULL) return;

    free_tree(node->yes);
    free_tree(node->no);

    free(node->text);
    free(node);
}

/* TODO 4  (recursion allowed) */
int count_nodes(Node *root) {
    if(root == NULL) return 0;

    return count_nodes(root->yes) + count_nodes(root->no) + 1;
}


/* ====== FrameStack  (dynamic array, iterative traversal) ======== */

/* TODO 5 */
void fs_init(FrameStack *s) {
    if(s == NULL) return;
    
    s->size = 0;
    s->capacity = 1; // Assuming starting at capacity of 1

    s->frames = (Frame*)malloc(sizeof(Frame) * s->capacity);
    if(s->frames == NULL) return;

    //s->frames->node = NULL;
    //s->frames->answeredYes = -1;
}

/* TODO 6 */
void fs_push(FrameStack *s, Node *node, int answeredYes) {
    if(s == NULL) return;
    //if(node == NULL) return;

    if(s->size == s->capacity) {
        s->frames = (Frame*)realloc(s->frames, sizeof(Frame) * s->capacity * 2);
        if(s->frames == NULL) return;

        s->capacity *= 2;
    }

    Frame* stackPointer = (s->frames + s->size);
    stackPointer->node = node;
    stackPointer->answeredYes = answeredYes;

    s->size++;
}

/* TODO 7 */
Frame fs_pop(FrameStack *s) {
    if(s == NULL) return (Frame){0};
    if(s->size == 0) return (Frame){0};

    Frame* stackPointer = (s->frames + s->size - 1);
    Frame top = *stackPointer;

    s->size--;

    return top;
}

/* TODO 8 */
int fs_empty(FrameStack *s) {
    if(s == NULL) return -1;

    return (int)(s->size == 0);
}

/* TODO 9 */
void fs_free(FrameStack *s) {
    if(s == NULL) return;
    if(s->frames == NULL) return;
    free(s->frames);
    s->frames = NULL;
}


/* ====== EditStack  (dynamic array, undo/redo) =================== */

/* TODO 10 */
void es_init(EditStack *s) {
    if(s == NULL) return;
    
    s->size = 0;
    s->capacity = 1; // Assuming starting at capacity of 1

    s->edits = (Edit*)malloc(sizeof(Edit) * s->capacity);
    if(s->edits == NULL) return;
}

/* TODO 11 */
void es_push(EditStack *s, Edit e) {
    if(s == NULL) return;

    if(s->size == s->capacity) {
        s->edits = (Edit*)realloc(s->edits, sizeof(Edit) * s->capacity * 2);
        if(s->edits == NULL) return;

        s->capacity *= 2;
    }

    Edit* stackPointer = (s->edits + s->size);
    *stackPointer = e;

    s->size++;
}

/* TODO 12 */
Edit es_pop(EditStack *s) {
    if(s == NULL) return (Edit){0};
    if(s->size == 0) return (Edit){0};

    Edit* stackPointer = (s->edits + s->size - 1);
    Edit top = *stackPointer;

    s->size--;

    return top;
}

/* TODO 13 */
int es_empty(EditStack *s) {
    if(s == NULL) return -1;

    return (int)(s->size == 0);
}

/* TODO 14 */
void es_clear(EditStack *s) {
    if(s == NULL) return;

    s->size = 0;
}

/* provided -- do not modify */
void es_free(EditStack *s) {
    free(s->edits);
    s->edits    = NULL;
    s->size     = 0;
    s->capacity = 0;
}

void free_edit_stack(EditStack *s) { es_free(s); }


/* ====== Queue  (linked list, BFS) ============================== */

/* TODO 15 */
void q_init(Queue *q) {
    if(q == NULL) return;

    q->size = 0;
    q->front = NULL;
    q->rear = NULL;
}

/* TODO 16 */
void q_enqueue(Queue *q, Node *node, int id) {
    if(q == NULL) return;

    QueueNode* newNode = (QueueNode*)malloc(sizeof(QueueNode));
    if(newNode == NULL) return;

    newNode->treeNode = node;
    newNode->id = id;
    newNode->next = NULL;

    if(q->rear != NULL) q->rear->next = newNode;
    q->rear = newNode;
    if(q->size == 0) q->front = newNode;

    q->size++;
}

/* TODO 17 */
int q_dequeue(Queue *q, Node **node, int *id) { // 1 for success, 0 for failure
    if(q == NULL) return 0;
    if(q->front == NULL || q->size == 0) return 0;

    *node = q->front->treeNode;
    *id = q->front->id;

    QueueNode* temp = q->front;
    q->front = q->front->next;
    free(temp);

    if(q->size == 1) q->rear = NULL;
    q->size--;

    return 1;
}

/* TODO 18 */
int q_empty(Queue *q) {
    if(q == NULL) return -1;

    return (int)(q->size == 0);
}

/* TODO 19 */
void q_free(Queue *q) {
    if(q == NULL) return;
    if(q->front == NULL || q->size == 0) return;

    QueueNode* curr = q->front;
    while(curr != NULL) {
        QueueNode* next = curr->next;
        free(curr);
        curr = next;
    }
}


/* ====== Hash table  (separate chaining) ======================== */

/* TODO 20
 * Convert a string to a canonical key:
 *   letters  -> lowercase
 *   spaces   -> underscore
 *   anything else -> drop
 * Caller owns the returned string and must free() it.
 */
char *canonicalize(const char *s) {
    if (s == NULL) return strdup("");

    char* newString = (char*)malloc(strlen(s) + 1);
    int j = 0;

    for(int i = 0; s[i] != '\0'; i++) {
        char c = s[i];
        if(c >= 'a' && c <= 'z') newString[j++] = c;
        else if(c >= 'A' && c <= 'Z') newString[j++] = c + 0x20;
        else if(c == ' ') newString[j++] = '_';
    }
    newString[j] = '\0';

    return newString;
}

/* TODO 21  (djb2: hash = hash*33 + c, seed 5381) */
unsigned h_hash(const char *s) {
    if(s == NULL) return 0;

    unsigned hash = 5381;
    for(int i = 0; s[i] != '\0'; i++) {
        hash = hash * 33 + s[i];
    }

    return hash;
}

/* TODO 22 */
void h_init(Hash *h, int nbuckets) {
    if(h == NULL) return;

    h->nbuckets = nbuckets;
    h->size = 0;

    h->buckets = (Entry**)malloc(8 * nbuckets); // 8 bytes is pointer size
    if(h->buckets == NULL) return;

    for(int i = 0; i < nbuckets; i++) {
        h->buckets[i] = NULL;
    }
}


/* TODO 23 */
int h_put(Hash *h, const char *key, int solutionId) {
    if(h == NULL) return 0;
    if(key == NULL) return 0;

    unsigned hash = h_hash(key);
    int index = hash % h->nbuckets;

    Entry** bucketPointer = h->buckets + index;

    Entry* foundKey = *bucketPointer;
    while(foundKey != NULL) { // iterate through each entry in bucket, if found key foundKey will be pointer otherwise NULL
        if(strcmp(foundKey->key, key) == 0) break;
        foundKey = foundKey->next;
    }

    if(foundKey == NULL) { // if not found in linked list, I will insert to head because it's easier
        Entry* newEntry = (Entry*)malloc(sizeof(Entry));
        if(newEntry == NULL) return 0;

        newEntry->key = (char*)(malloc(strlen(key) + 1));
        if(newEntry->key == NULL) return 0;
        strcpy(newEntry->key, key);

        newEntry->next = *(bucketPointer); // insertion into head
        *(bucketPointer) = newEntry;

        IdList* idList = &(newEntry->vals);
        idList->count = 1;
        idList->capacity = 1;

        idList->ids = (int*)malloc(sizeof(int) * idList->capacity);
        if(idList->ids == NULL) return 0;
        *(idList->ids) = solutionId;

        h->size++;
        return 1;
    }

    IdList* idList = &(foundKey->vals);

    for(int i = 0; i < idList->count; i++) {
        if(*(idList->ids + i) == solutionId) return 0; // ID was already in bucket
    }

    if(idList->count == idList->capacity) {
        idList->ids = (int*)realloc(idList->ids, sizeof(int) * 2 * idList->capacity);
        if(idList->ids == NULL) return 0;
        idList->capacity *= 2;
    }

    *(idList->ids + idList->count) = solutionId;
    idList->count++;
    return 1;
}

/* TODO 24 */
int h_contains(const Hash *h, const char *key, int solutionId) {
    if(h == NULL) return -1;
    if(key == NULL) return -1;

    unsigned hash = h_hash(key);
    int index = hash % h->nbuckets;

    Entry** bucketPointer = h->buckets + index;

    Entry* foundKey = *bucketPointer;
    while(foundKey != NULL) {
        if(strcmp(foundKey->key, key) == 0) break;
        foundKey = foundKey->next;
    }

    if(foundKey == NULL) return 0;

    IdList* idList = &(foundKey->vals);
    for(int i = 0; i < idList->count; i++) {
        if(*(idList->ids + i) == solutionId) return 1;
    }

    return 0;
}

/* TODO 25 */
int *h_get_ids(const Hash *h, const char *key, int *outCount) {
    if(outCount == NULL) return NULL;
    *outCount = 0;

    if(h == NULL) return NULL;
    if(key == NULL) return NULL;

    unsigned hash = h_hash(key);
    int index = hash % h->nbuckets;

    Entry** bucketPointer = h->buckets + index;

    Entry* foundKey = *bucketPointer;
    while(foundKey != NULL) {
        if(strcmp(foundKey->key, key) == 0) break;
        foundKey = foundKey->next;
    }

    if(foundKey == NULL) return NULL;

    IdList* idList = &(foundKey->vals);
    *outCount = idList->count;
    return idList->ids;
}

/* TODO 26 */
void h_free(Hash *h) {
    if(h == NULL) return;

    for(int i = 0; i < h->nbuckets; i++) {
        Entry* curr = *(h->buckets + i);
        while(curr != NULL) {
            free(curr->vals.ids);
            free(curr->key);

            Entry* temp = curr;
            curr = curr->next;
            free(temp);
        }
    }

    free(h->buckets);
}
