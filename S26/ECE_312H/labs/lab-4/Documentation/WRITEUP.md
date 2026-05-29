# ECE 312 Lab 4 Write-Up: Tech Support Diagnosis Tool

**Name:** [Dawson Zhang]
**EID:** [DDZ249]
**Date:** [04/13/2026]

---

## What This Document Is

1–2 pages of honest reflection on the decisions you made and the problems you hit. Not a summary of the lab spec.

Full credit requires:
- Two specific design choices with a stated reason and a named alternative
- Four Big-O analyses with reasoning shown
- Two concrete bugs (symptom → cause → fix → rule)
- Reflection on the knowledge base you grew through sessions
- A note on `find_shortest_path`

Vague entries ("I had a leak and fixed it") earn no credit.

---

## Section 1 — Design Choices (two required, ~100 words each)

For each: what did you choose, what was the alternative, and why?

Candidate topics:
- Array-backed stack vs. linked-list stack
- Two-pass design in `load_tree` — why not link during the read phase?
- Dynamic `PathNode` array in `find_shortest_path` vs. fixed-size stack array
- Ownership model for nodes in undo/redo — why not free on undo?
- Iterative diagnosis loop — what state did you have to track explicitly?

### 1.A — [utils.c]

*What I chose:*
In `find_shortest_path` I chose to fixed-size stack array approach.

*What I considered instead:*
I considered setting up a linked-list but ultimately chose the array approach.

*Why:*
At first, I was set on doing a linked-list approach, because assuming a well
developed tree, your size of the array would be proportional to the log of the
amount of Nodes, and a linked-list approach would save a comporable amount of
memory. O(log N) vs. O(N). I chose the fixed-size stack array approach because
it felt simpler to implement and avoided potential memory errors. In CPP,
I would no brainer use a vector instead.

---

### 1.B — [utils.c]

*What I chose:*
I chose not to use the hash in `find_shortest_path`.

*What I considered instead:*
I considered using the hash to keep track of the ID's during traversal.

*Why:*
I ended up not using the hash primarily because I found the process of
manipulating ID's in my path arrays more straightforward. To be quite
frank, I feel like the inteded approach with the hash is less
intuitive and unecessary for our pourposes of finding the shortest
path.

---

## Section 2 — Complexity Analysis (all four required)

Show the reasoning, not just the answer.

### 2.1 — Amortized cost of a single FrameStack push
A single FrameStack push requires O(1) time. Depending on whether or not
the stack is at capacity, more memory could be allocated in the process
of pushing a new frame.

### 2.2 — Hash table average-case lookup
Precisely, hash table average-case and worst-case lookup requires O(N/M + K)
time. Where N is the size of the hash table, M is the number of buckets, and
K is the amount of ID's for a given key. Assuming N/M >> K, we can rewrite
the complexity as O(N/M). As your number of buckets -> infinity, complexity
decreases to O(1).

### 2.3 — Diagnosis traversal (best, worst, average)
Best: O(1), root is a solution node.
Average: O(log N), where N is the size of the tree. Assuming tree is near-balanced.
Worst: O(N), where N is the size of the tree. Tree is perfectly un-balanced.

### 2.4 — `find_shortest_path` time and space
Best: O(1), root is NULL, either strings are NULL.
Average: O(N), assuming a balanced tree, the solution nodes are at the deepest point
of the tree, so full traversal will be needed to find either solution.
Worst: O(N), worst case traversal will BFS the entire tree.

---

## Section 3 — Bugs (two required)

### 3.A — [Check integrity root is NULL]

*Symptom:*
Not getting full points for the `check_integrity` function.

*Cause:* [quote the wrong line or describe the wrong logic]
`if(g_root == NULL) return 0;`
Wrong logic because the integrity of a tree that is NULL is valid.

*Fix:*
Change the return from 0 to a 1.

*Rule that would have prevented it:*
Looking through test cases and seeing that NULL root is valid.

---

### 3.B — [Hash put losing linked list on insertion]

*Symptom:*
Losing existing data in linked list on insertion.

*Cause:*
Losing the existing pointer before I inserted at head.

*Fix:*
Making sure to create a temp to keep track of the current head before
making a new head.

*Rule that would have prevented it:*
Insertion at end would be harder to mess up regarding losing the head pointer.

---

## Section 4 — Knowledge Base Reflection (~100 words)

1. How many nodes does your submitted `techsupport.dat` contain?
31

2. What categories of problems did you teach the program? Give one example question/solution pair for each category.
Is the issue with the Wi-Fi connectivity?

3. Look at the tree with `[V]`.  Are the questions you taught it good distinguishing questions — do they split the remaining candidates roughly in half?  Name one question you would improve and describe what you would replace it with.
I think they are all created pretty well. I utilized AI when I got stuck and made sure to split the tree perfectly balanced.

4. Describe one `[F]ind Path` result.  What were the two solutions, what was the shared path, and did the output match your expectation?

  Solution A: Restart your computer and try again.

  Solution B: Reinstall or update your audio drivers.



  Distinguishing path between:
   A: "Restart your computer and try again."
   B: "Reinstall or update your audio drivers."

  Shared path (both solutions pass through):
  Is the problem with a network device?
   NO  -> Is the problem related to your display or monitor?
    NO  -> Is the problem related to audio or sound?

  Divergence point (LCA):
   Is the problem related to audio or sound?:
    YES -> Is there no sound at all?
    NO  -> Is your computer running slowly or freezing?

---

## Section 5 — Reflection (3–5 sentences)

Answer at least two:

- What was the hardest part and why?

I think that for me the hardest part was figuring out the hash and the push
function associated with it. This was particularly challenging for me because
there are a lot of data structures that the stack is built on top of and
it is easy to loose track of what array does what.

- What did the iterative diagnosis loop teach you about recursion?
- What would you do differently if starting over?

If I could do something differently when starting over, I would choose to 
spend some time with all the separate markdown files that give us some 
direction on how to implement all the different methods.

- Was there a moment something clicked? What was it?

---

## Section 6 — Time Log

| Date | Hours | What you worked on |
|------|-------|--------------------|
| | | |
| | | |
| | | |
| | | |
| | | |
| | | |
| | | |
| | | |
| | | |
| | | |

**Total hours:** ___
