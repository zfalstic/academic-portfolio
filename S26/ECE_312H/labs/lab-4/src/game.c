#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <ncurses.h>
#include "lab4.h"

extern Node      *g_root;
extern EditStack  g_undo;
extern EditStack  g_redo;
extern Hash       g_index;

/* ----------------------------------------------------------------
 * TODO 31  run_diagnosis
 *
 * Walk the decision tree iteratively (no recursion) using a
 * FrameStack.  At each question node ask the user yes/no and push
 * the appropriate child.  At each solution leaf display the fix and
 * ask whether it solved the problem.
 *
 * If the fix did not help, enter the learning phase:
 *   - Ask the user what would actually fix the problem.
 *   - Ask for a yes/no question that distinguishes their problem
 *     from the solution just shown.
 *   - Ask which answer applies to their problem.
 *   - Create a new question node and a new solution node, wire them
 *     correctly, graft them into the tree, record an Edit for
 *     undo/redo, and index the new question with canonicalize/h_put.
 *
 * Edge case: if parent is NULL the root itself must be replaced.
 * ---------------------------------------------------------------- */
void run_diagnosis(void) {
    clear();
    attron(COLOR_PAIR(5) | A_BOLD);
    mvprintw(0, 0, "%-80s", " Tech Support Diagnosis");
    attroff(COLOR_PAIR(5) | A_BOLD);

    mvprintw(2, 2, "I'll help diagnose your tech problem.");
    mvprintw(3, 2, "Answer each question with y or n.");
    mvprintw(4, 2, "Press any key to start...");
    refresh();
    getch();

    int printLine = 6;

    FrameStack s;
    fs_init(&s);
    
    fs_push(&s, g_root, -1);

    Node* curr;
    Node* parent;
    int parentAnsweredYes = -1;

    while(!fs_empty(&s)) {
        Frame frame = fs_pop(&s);
        curr = frame.node;

        if(curr->isQuestion) {
            int ans = get_yes_no(printLine++, 2, curr->text);
            parent = curr;
            if(ans == 1) {
                parentAnsweredYes = 1;
                fs_push(&s, curr->yes, 1);
            }
            if(ans == 0) {
                parentAnsweredYes = 0;
                fs_push(&s, curr->no, 0);
            }
        }
    }

    fs_free(&s);

    // curr will be pointing to the solution node

    mvprintw(printLine++, 2, "%s", curr->text);
    int ans = get_yes_no(printLine++, 2, "Does this fix the problem?");
    if(ans == 1) return;

    // learning phase

    // 1. What actually fixes it
    char *raw = get_input(printLine++, 2, "What would fix your problem? ");
    char newSolutionText[256];
    strncpy(newSolutionText, raw, 255);
    newSolutionText[255] = '\0';

    // 2. A question that distinguishes their problem
    raw = get_input(printLine++, 2, "Enter a yes/no question that identifies your problem: ");
    char newQuestionText[256];
    strncpy(newQuestionText, raw, 255);
    newQuestionText[255] = '\0';

    // 3. Which answer applies to their problem
    ans = get_yes_no(printLine++, 2, "For your problem, is the answer yes or no? (y/n) ");

    Node* newQuestion = create_question_node(newQuestionText);
    Node* newSolution = create_solution_node(newSolutionText);

    if(ans == 1) {
        newQuestion->yes = newSolution;
        newQuestion->no = curr;
    } else {
        newQuestion->yes = curr;
        newQuestion->no = newSolution;
    }

    Edit e = {
        EDIT_INSERT_SPLIT,
        parent,
        parentAnsweredYes,
        curr,
        newQuestion,
        newSolution
    };

    es_push(&g_undo, e);
    es_clear(&g_redo);

    if(parent == NULL) g_root = newQuestion;
    else if(parentAnsweredYes == 1) parent->yes = newQuestion;
    else parent->no = newQuestion;
}

/* ----------------------------------------------------------------
 * TODO 32  undo_last_edit
 * Return 1 on success, 0 if the undo stack is empty.
 * ---------------------------------------------------------------- */
int undo_last_edit(void) {
    if(es_empty(&g_undo)) return 0;

    Edit e = es_pop(&g_undo);
    es_push(&g_redo, e);

    if(e.parent == NULL) g_root = e.oldLeaf;
    else if(e.wasYesChild == 1) e.parent->yes = e.oldLeaf;
    else e.parent->no = e.oldLeaf;

    return 1;
}

/* ----------------------------------------------------------------
 * TODO 33  redo_last_edit
 * Return 1 on success, 0 if the redo stack is empty.
 * ---------------------------------------------------------------- */
int redo_last_edit(void) {
    if(es_empty(&g_redo)) return 0;

    Edit e = es_pop(&g_redo);
    es_push(&g_undo, e);

    if(e.parent == NULL) g_root = e.newQuestion;
    else if(e.wasYesChild == 1) e.parent->yes = e.newQuestion;
    else e.parent->no = e.newQuestion;

    return 1;
}
