#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <ncurses.h>
#include "lab4.h"

extern Node *g_root;

/* ----------------------------------------------------------------
 * TODO 29  check_integrity
 *
 * Use BFS to verify:
 *   - Every question node has both yes and no children (non-NULL).
 *   - Every solution node has both children NULL.
 * Return 1 if valid, 0 if any violation is found.
 * ---------------------------------------------------------------- */
int check_integrity(void) {
    if(g_root == NULL) return 1;

    Queue q;
    q_init(&q);
    q_enqueue(&q, g_root, 0);

    while(!q_empty(&q)) {
        Node* curr;
        int temp;
        q_dequeue(&q, &curr, &temp);

        if(curr->isQuestion == 1 && (curr->yes == NULL || curr->no == NULL)) {
            q_free(&q);
            return 0;
        }
        if(curr->isQuestion == 0 && (curr->yes != NULL || curr->no != NULL)) {
            q_free(&q);
            return 0;
        }

        if(curr->yes != NULL) q_enqueue(&q, curr->yes, 0);
        if(curr->no != NULL) q_enqueue(&q, curr->no, 0);
    }

    return 1;
}

/* ----------------------------------------------------------------
 * TODO 30  find_shortest_path
 *
 * Given the exact text of two solution leaves, display the
 * questions that distinguish them.  Use BFS with a parent-tracking
 * PathNode array to find both leaves, build ancestor arrays for
 * each, find the Lowest Common Ancestor (LCA), then print:
 *   - The shared path of questions both solutions pass through.
 *   - The divergence question (LCA) and which branch leads where.
 *
 * Display results with mvprintw.  Print an error if either
 * solution is not found.  Free all allocations before returning.
 * ---------------------------------------------------------------- */
typedef struct PathNode {
    int parentId;    /* parent of index, -1 for root */
    int isYes;       /* 1 = yes path, 0 = no path, -1 for root */
    Node* node;
} PathNode;

void find_shortest_path(const char *sol1, const char *sol2) {
    if(g_root == NULL) {
        mvprintw(10, 2, "Error: knowledge base is empty.");
        refresh();
        return;
    }
    //mvprintw(10, 2, "find_shortest_path not yet implemented.");
    //refresh();
    
    if(sol1 == NULL) {
        mvprintw(10, 2, "Error: solution 1 string points to NULL.");
        refresh();
        return;
    }

    if(sol2 == NULL) {
        mvprintw(10, 2, "Error: solution 2 string points to NULL.");
        refresh();
        return;
    }

    int sol1Index = -1;
    int sol2Index = -1;
    
    int nodeCount = count_nodes(g_root);
    PathNode pathArray[nodeCount];

    Queue q;
    q_init(&q);

    int idCounter = 0;
    q_enqueue(&q, g_root, idCounter);
    pathArray[0].parentId = -1;
    pathArray[0].isYes = -1;
    pathArray[0].node = g_root;

    while(!q_empty(&q)) {
        if(sol1Index != -1 && sol2Index != -1) break;

        Node* curr;
        int id;
        q_dequeue(&q, &curr, &id);

        if(curr->yes != NULL) {
            q_enqueue(&q, curr->yes, ++idCounter);

            pathArray[idCounter].parentId = id;
            pathArray[idCounter].isYes = 1;
            pathArray[idCounter].node = curr->yes;

            if(strcmp(curr->yes->text, sol1) == 0) sol1Index = idCounter;
            if(strcmp(curr->yes->text, sol2) == 0) sol2Index = idCounter;
        }
        if(curr->no != NULL) {
            q_enqueue(&q, curr->no, ++idCounter);

            pathArray[idCounter].parentId = id;
            pathArray[idCounter].isYes = 0;
            pathArray[idCounter].node = curr->no;

            if(strcmp(curr->no->text, sol1) == 0) sol1Index = idCounter;
            if(strcmp(curr->no->text, sol2) == 0) sol2Index = idCounter;
        }
    }

    q_free(&q); // need to free remaining queue if both solutions are found early.
    
    if(sol1Index == -1 && sol2Index == -1) {
        mvprintw(10, 2, "Error: solution A and solution B string not found");
        refresh();
        return;
    }

    if(sol1Index == -1) {
        mvprintw(10, 2, "Error: solution A string not found");
        refresh();
        return;
    }

    if(sol2Index == -1) {
        mvprintw(10, 2, "Error: solution B string not found");
        refresh();
        return;
    }
    
    PathNode* sol1Ancestors[nodeCount];
    PathNode* sol2Ancestors[nodeCount];
    int sol1AncestorsCount = 0;
    int sol2AncestorsCount = 0;
    sol1Ancestors[sol1AncestorsCount++] = &pathArray[sol1Index];
    sol2Ancestors[sol2AncestorsCount++] = &pathArray[sol2Index];

    while(sol1Ancestors[sol1AncestorsCount - 1]->parentId != -1) {
        int parentId = sol1Ancestors[sol1AncestorsCount - 1]->parentId;
        sol1Ancestors[sol1AncestorsCount++] = &pathArray[parentId];
    }
    while(sol2Ancestors[sol2AncestorsCount - 1]->parentId != -1) {
        int parentId = sol2Ancestors[sol2AncestorsCount - 1]->parentId;
        sol2Ancestors[sol2AncestorsCount++] = &pathArray[parentId];
    }

    int printLine = 10;

    attron(A_BOLD);
    mvprintw(printLine++, 2, "Distinguishing path between:");
    attroff(A_BOLD);

    mvprintw(printLine++, 3, "A: \"%s\"", sol1);
    mvprintw(printLine++, 3, "B: \"%s\"", sol2);
    printLine++;

    attron(A_BOLD);
    mvprintw(printLine++, 2, "Shared path (both solutions pass through):");
    attroff(A_BOLD);

    int printCol = 2;
    mvprintw(printLine++, printCol++, "%s", g_root->text);

    int inwardIterator = 2; // all nodes GCA is the root
    while(sol1Ancestors[sol1AncestorsCount - inwardIterator] == sol2Ancestors[sol2AncestorsCount - inwardIterator]) {
        if(sol1Ancestors[sol1AncestorsCount - inwardIterator]->isYes) {
            mvprintw(printLine++, printCol++, "YES -> %s", sol1Ancestors[sol1AncestorsCount - inwardIterator]->node->text);
        } else {
            mvprintw(printLine++, printCol++, "NO  -> %s", sol1Ancestors[sol1AncestorsCount - inwardIterator]->node->text);
        }
        inwardIterator++;
    }
    printLine++;

    // diverges here
    
    attron(A_BOLD);
    mvprintw(printLine++, 2, "Divergence point (LCA):");
    attroff(A_BOLD);
    mvprintw(printLine++, 3, "%s:", sol1Ancestors[sol1AncestorsCount - inwardIterator + 1]->node->text);

    if(sol1Ancestors[sol1AncestorsCount - inwardIterator]->isYes) {
        mvprintw(printLine++, 4, "YES -> %s", sol1Ancestors[sol1AncestorsCount - inwardIterator]->node->text);
        mvprintw(printLine++, 4, "NO  -> %s", sol2Ancestors[sol2AncestorsCount - inwardIterator]->node->text);
    } else {
        mvprintw(printLine++, 4, "YES -> %s", sol2Ancestors[sol2AncestorsCount - inwardIterator]->node->text);
        mvprintw(printLine++, 4, "NO  -> %s", sol1Ancestors[sol1AncestorsCount - inwardIterator]->node->text);
    }

    refresh();
}
