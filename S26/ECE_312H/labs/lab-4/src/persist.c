#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <stdint.h>
#include "lab4.h"

extern Node *g_root;

#define MAGIC   0x54454348u   /* "TECH" */
#define VERSION 1u

typedef struct { Node *node; int id; } NodeMapping;

/* ----------------------------------------------------------------
 * TODO 27  save_tree
 *
 * Serialize the entire tree to a binary file using BFS order.
 *
 * File format:
 *   Header:  uint32 magic | uint32 version | uint32 nodeCount
 *   Per node (BFS order):
 *     uint8  isQuestion
 *     uint32 textLen          (bytes, no null terminator in file)
 *     char[] text             (exactly textLen bytes)
 *     int32  yesId            (-1 if NULL)
 *     int32  noId             (-1 if NULL)
 *
 * Return 1 on success, 0 on failure.
 * ---------------------------------------------------------------- */
int save_tree(const char *filename) {
    if(filename == NULL) return 0;
    if(g_root == NULL) return 0;

    FILE *f = fopen(filename, "wb");
    if(!f) return 0;

    uint32_t nodeCount = count_nodes(g_root);
    NodeMapping nodeMap[nodeCount];
    
    Queue q;
    q_init(&q);

    int idCounter = 0;
    q_enqueue(&q, g_root, idCounter);

    while(!q_empty(&q)) { // constructs nodeMap array for mappings
        Node* curr;
        int id;
        q_dequeue(&q, &curr, &id);

        nodeMap[id].node = curr;
        nodeMap[id].id = id;

        if(curr->yes != NULL) q_enqueue(&q, curr->yes, ++idCounter);
        if(curr->no != NULL) q_enqueue(&q, curr->no, ++idCounter);
    }

    q_free(&q); // should be redundant, q should already be empty, just making sure
    
    uint32_t magic = MAGIC;
    uint32_t version = VERSION;
    fwrite(&magic, sizeof(uint32_t), 1, f);
    fwrite(&version, sizeof(uint32_t), 1, f);
    fwrite(&nodeCount, sizeof(uint32_t), 1, f);
    
    idCounter = 0;
    q_enqueue(&q, g_root, idCounter);

    while(q_empty(&q) != 1) {
        Node* curr;
        int id;
        q_dequeue(&q, &curr, &id);

        uint8_t isQuestion = (uint8_t)curr->isQuestion;
        uint32_t textLen = (uint32_t)strlen(curr->text);
        fwrite(&isQuestion, sizeof(uint8_t), 1, f);
        fwrite(&textLen, sizeof(uint32_t), 1, f);

        for(int i = 0; i < (int)textLen; i++) {
            char a = curr->text[i];
            fwrite(&a, sizeof(char), 1, f);
        }

        int32_t yesId = -1;
        int32_t noId = -1;

        for(int i = 0; i < (int)nodeCount; i++) {
            if(nodeMap[i].node == curr->yes) {
                yesId = (int32_t)nodeMap[i].id;
            }
            if(nodeMap[i].node == curr->no) {
                noId = (int32_t)nodeMap[i].id;
            }
        }

        fwrite(&yesId, sizeof(int32_t), 1, f);
        fwrite(&noId, sizeof(int32_t), 1, f);

        if(curr->yes != NULL) q_enqueue(&q, curr->yes, ++idCounter);
        if(curr->no != NULL) q_enqueue(&q, curr->no, ++idCounter);
    }

    fclose(f);
    return 1;
}

/* ----------------------------------------------------------------
 * TODO 28  load_tree
 *
 * Read a file written by save_tree and reconstruct the tree.
 * Validate the magic number.  Read all nodes into a flat array
 * first, then link children in a second pass.
 * Free any existing g_root before installing the new one.
 * Return 1 on success, 0 on any error (free partial allocations).
 * ---------------------------------------------------------------- */
int load_tree(const char *filename) {
    if(filename == NULL) return 0;

    FILE *f = fopen(filename, "rb");
    if(!f) return 0;

    uint32_t magic;
    fread(&magic, sizeof(uint32_t), 1, f);

    if(magic != MAGIC) return 0;

    uint32_t version;
    uint32_t nodeCount;
    fread(&version, sizeof(uint32_t), 1, f);
    fread(&nodeCount, sizeof(uint32_t), 1, f);

    Node* nodePointerArray[nodeCount];
    for(int i = 0; i < (int)nodeCount; i++) {
        nodePointerArray[i] = (Node*)malloc(sizeof(Node));
    }
    // Node* nodeArray = (Node*)malloc(sizeof(Node) * nodeCount);
    NodeMapping nodeMap[nodeCount];

    for(int i = 0; i < (int)nodeCount; i++) {
        Node* curr = nodePointerArray[i];

        uint8_t isQuestion;
        fread(&isQuestion, sizeof(uint8_t), 1, f);
        curr->isQuestion = (int)isQuestion;

        uint32_t textLen;
        fread(&textLen, sizeof(uint32_t), 1, f);
        curr->text = (char*)malloc(textLen + 1);
        fread(curr->text, sizeof(char), textLen, f);
        curr->text[textLen] = '\0';

        int32_t yesId;
        int32_t noId;
        fread(&yesId, sizeof(int32_t), 1, f);
        fread(&noId, sizeof(int32_t), 1, f);
        curr->yes = NULL;
        curr->no = NULL;
        
        nodeMap[i].node = curr;
        nodeMap[i].id = i;
    }

    fclose(f);
    f = fopen(filename, "rb");
    fread(&magic, sizeof(uint32_t), 1, f);
    if(magic != MAGIC) return 0;
    fread(&version, sizeof(uint32_t), 1, f);
    fread(&nodeCount, sizeof(uint32_t), 1, f);

    for(int i = 0; i < (int)nodeCount; i++) {
        Node* curr = nodePointerArray[i];

        uint8_t isQuestion;
        uint32_t textLen;
        fread(&isQuestion, sizeof(uint8_t), 1, f);
        fread(&textLen, sizeof(uint32_t), 1, f);

        char* temp = (char*)malloc(textLen);
        if(temp == NULL) return 0;
        fread(temp, sizeof(char), textLen, f);
        free(temp);

        int32_t yesId;
        int32_t noId;
        fread(&yesId, sizeof(int32_t), 1, f);
        fread(&noId, sizeof(int32_t), 1, f);

        if(yesId != -1) curr->yes = nodeMap[yesId].node;
        if(noId != -1) curr->no = nodeMap[noId].node;
    }

    free_tree(g_root);
    g_root = nodePointerArray[0];

    fclose(f);
    return 1;
}
