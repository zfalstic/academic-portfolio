// ECE 312 - Memory Pool Allocator Lab
// Name: Dawson Zhang
// EID:  ddz249

#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <stdint.h>
#include "mempool.h"

/* Global pool instance */
MemoryPool g_pool = {0};

/* ============================================================================
 * HELPER FUNCTIONS (PROVIDED - DO NOT MODIFY)
 * ============================================================================ */

/*
 * Check if a pointer is within the pool's address range.
 */
static inline int ptr_in_pool(void* p) {
    return g_pool.pool_start &&
           (char*)p >= (char*)g_pool.pool_start &&
           (char*)p <  (char*)g_pool.pool_start + g_pool.total_size;
}

/*
 * Insert a block into the master list (all_list) after 'pos'.
 * If pos is NULL, insert at head.
 */
static void all_list_insert_after(MemoryBlock* pos, MemoryBlock* node) {
    if (!pos) {
        node->all_prev = NULL;
        node->all_next = g_pool.all_list;
        if (g_pool.all_list) g_pool.all_list->all_prev = node;
        g_pool.all_list = node;
        return;
    }
    node->all_prev = pos;
    node->all_next = pos->all_next;
    if (pos->all_next) pos->all_next->all_prev = node;
    pos->all_next = node;
}

/*
 * Remove a block from the master list (all_list).
 */
static void all_list_remove(MemoryBlock* node) {
    if (node->all_prev) node->all_prev->all_next = node->all_next;
    else                g_pool.all_list = node->all_next;
    if (node->all_next) node->all_next->all_prev = node->all_prev;
    node->all_prev = node->all_next = NULL;
}

/*
 * Find the block header for a given data pointer by scanning all_list.
 */
static MemoryBlock* find_block_by_ptr(void* ptr) {
    for (MemoryBlock* b = g_pool.all_list; b; b = b->all_next) {
        if (b->data == ptr) return b;
    }
    return NULL;
}

/* ============================================================================
 * STUDENT FUNCTIONS - IMPLEMENT THESE
 * ============================================================================ */

/*
 * pool_init: Initialize the memory pool
 * 
 * This function must:
 *   1. Check if pool is already initialized 
 *   2. Allocate memoryfor the pool 
 *   3. Create ONE initial free block that spans the entire pool:
 *   4. Initialize all g_pool fields:
 *   5. Add the initial block to all_list 
 * 
 * Returns: 0 on success, -1 on failure
 */
int pool_init(void) {
    if(g_pool.pool_start) return -1;

    void* pool_ptr = malloc(POOL_SIZE);
    if(!pool_ptr) return -1;

    MemoryBlock* block_ptr = (MemoryBlock*)malloc(sizeof(MemoryBlock));
    if(!block_ptr) return -1;

    block_ptr->size = POOL_SIZE;
    block_ptr->is_free = 1;
    block_ptr->data = pool_ptr;
    block_ptr->next = NULL;
    block_ptr->prev = NULL;
    block_ptr->all_next = NULL;
    block_ptr->all_prev = NULL;

    g_pool.pool_start = pool_ptr;
    g_pool.total_size = POOL_SIZE;
    g_pool.free_size = POOL_SIZE;
    g_pool.free_list = block_ptr;
    g_pool.all_list = block_ptr;
    g_pool.total_blocks = 1;
    g_pool.free_blocks = 1;
    
    return 0;
}

/*
 * pool_cleanup: Free all memory associated with the pool
 * 
 * This function must:
 *   1. Check pool_start 
 *   2. Free all block headers 
 *   3. Free the pool memory itself 
 *   4. Zero out g_pool 
 * 
 * HINT: Save the next pointer before freeing each node!
 */
void pool_cleanup(void) {
    if(!g_pool.pool_start) return;

    MemoryBlock* current = g_pool.all_list; // first block pointer in all list
    
    do {
        MemoryBlock* prev = current;
        current = current->next;
        free(prev);
    } while(current);

    free(g_pool.pool_start);

    memset(&g_pool, 0, sizeof(MemoryPool));
}

/*
 * find_free_block: Find a free block of at least 'size' bytes
 * 
 * This function must:
 *   1. Traverse the free_list from head to tail
 *   2. Return the FIRST block where that will satisfy the request 
 *   3. Return NULL if no suitable block is found
 * 
 * This implements the "first-fit" allocation strategy.
 * Do NOT remove the block from the free list here.
 */
MemoryBlock* find_free_block(size_t size) {
    if(size < 0) return NULL;
    MemoryBlock* current = g_pool.free_list;
    while(current) {
        if(current->size >= size) return current;
        current = current->next;
    }
    return NULL;
}

/*
 * add_to_free_list: Insert a block into the free list in address order
 * 
 * This function must:
 *   1. Mark the block as free
 *   2. Increment g_pool.free_blocks
 *   3. Find the correct position in free_list 
 *   4. Insert the block at that position.
 */
void add_to_free_list(MemoryBlock* block) {
    if(!block) return;

    block->is_free = 1;
    g_pool.free_blocks++;

    MemoryBlock* current = g_pool.free_list;
    MemoryBlock* prev = NULL;
    while(current && (current->data < block->data)) {
        prev = current;
        current = current->next;
    }
    if(!prev && !current) { // add to empty free_list
        block->next = NULL;
        block->prev = NULL;
        g_pool.free_list = block;
    } else if(!prev) { // block has the lowest address
        block->next = current;
        block->prev = NULL;
        current->prev = block;
        g_pool.free_list = block;
    } else if(!current) {  // block has the highest address
        block->next = NULL;
        block->prev = prev;
        prev->next = block;
    } else {
        block->next = current;
        block->prev = current->prev;
        current->prev->next = block;
        current->prev = block;
    }
}

/*
 * remove_from_free_list: Remove a block from the free list
 * 
 * This function must:
 *   1. Update the appropriate pointers 
 *   2. Update  pointer(s) in the 'next block'
 *   3. Clear the block's pointers
 *   4. Decrement g_pool.free_blocks
 * 
 * Do NOT change is_free here - that's done by the caller.
 */
void remove_from_free_list(MemoryBlock* block) {
    if(!block) return;

    if(block->prev) {
        block->prev->next = block->next;
    } else {
        g_pool.free_list = block->next;
    }

    if(block->next) block->next->prev = block->prev;

    block->next = NULL;
    block->prev = NULL;

    g_pool.free_blocks--;
}

/*
 * split_block: Split a block into allocated portion and free remainder
 * 
 * This function must:
 *   1. Check if block->size >= size (don't forget about alignment) 
 *   2. Allocate a NEW MemoryBlock header for the remainder (if any)
 *   3. Set up the new block.
 *   4. Add new block to all_list 
 *   5. Add new block to free_list 
 *   6. Update block->size = size
 *   7. Increment g_pool.total_blocks
 * 
 * IMPORTANT: The new block's header is allocated separately (on the heap),
 *            NOT carved from the pool. Only payload goes in the pool.
 */
void split_block(MemoryBlock* block, size_t size) {
    if(block->size < size + ALIGNMENT) return;

    MemoryBlock* block_ptr = (MemoryBlock*)malloc(sizeof(MemoryBlock));
    if(!block_ptr) return;

    size_t leftover = block->size - size;
    block_ptr->size = leftover;
    block_ptr->is_free = 1;
    block_ptr->data = (uint8_t*)block->data + size;

    all_list_insert_after(block, block_ptr);
    add_to_free_list(block_ptr);

    block->size = size;
    g_pool.total_blocks++;
}

/*
 * coalesce_blocks: Merge adjacent free blocks
 * 
 * This function must:
 *   1. Walk through free_list checking each pair of adjacent blocks
 *   2. When merging cur and nxt:
 *      - Size is the sum of the two blocks 
 *      - Remove nxt from free_list
 *      - Remove nxt from all_list 
 *      - Release the header
 *      - Decrement g_pool.total_blocks
 *      - Catch chains of 3+ blocks
 *   3. If not adjacent, advance to next block
 * 
 * HINT: After merging, don't move cur forward - there might be another
 *       adjacent block to merge.
 */
void coalesce_blocks(void) {
    MemoryBlock* current = g_pool.free_list;
    while(current && current->next) {
        MemoryBlock* next = current->next;
        if((uint8_t*)current->data + current->size != (uint8_t*)next->data) {
            current = current->next;
            continue;
        }
        current->size += next->size;
        current->next = next->next;
        current->all_next = next->all_next;
        g_pool.total_blocks--;
        all_list_remove(next);
        remove_from_free_list(next);
        free(next);
    }
}

/*
 * pool_malloc: Allocate memory from the pool
 * 
 * This function must:
 *   1. Check size 
 *   2. Account for aligntment
 *   3. Find a suitable block using find_free_block()
 *   4. If no block found, return NULL
 *   5. Remove the block from free_list
 *   6. Split the block if there's leftover space
 *   7. Mark the block as allocated (is_free = 0)
 *   8. Subtract the allocated size from g_pool.free_size
 *   9. Return block->data (the payload pointer)
 */
void* pool_malloc(size_t size) {
    if(size == 0) return NULL;

    size = ALIGN(size);
    if(size > g_pool.free_size) return NULL;

    MemoryBlock* block_ptr = find_free_block(size);
    remove_from_free_list(block_ptr);
    split_block(block_ptr, size);

    block_ptr->is_free = 0;
    g_pool.free_size -= size;

    return block_ptr->data;
}

/*
 * pool_free: Free a previously allocated block
 * 
 * This function must:
 *   1. Return immediately if ptr is NULL
 *   2. Check if ptr is in the pool using 
 *   3. Find the block header 
 *   4. Check for double-free (is_free already 1); print error if so
 *   5. Add block->size back to g_pool.free_size
 *   6. Add the block back to free_list 
 *   7. Coalesce adjacent free blocks 
 */
void pool_free(void* ptr) {
    if(!ptr) return;
    if(!ptr_in_pool(ptr)) return;

    MemoryBlock* block_ptr = find_block_by_ptr(ptr);
    if(block_ptr->is_free) {
        printf("error");
        return;
    }

    g_pool.free_size += block_ptr->size;

    add_to_free_list(block_ptr);
    coalesce_blocks();
}

/* ============================================================================
 * PROVIDED FUNCTION - DO NOT MODIFY
 * ============================================================================ */

/*
 * pool_stats: Print memory pool statistics
 */
void pool_stats(void) {
    size_t largest_free = 0, free_count = 0, free_bytes = 0;
    for (MemoryBlock* cur = g_pool.free_list; cur; cur = cur->next) {
        if (cur->is_free) {
            free_count++;
            free_bytes += cur->size;
            if (cur->size > largest_free) largest_free = cur->size;
        }
    }
    
    if (g_pool.free_size == 0 && free_bytes) g_pool.free_size = free_bytes;

    double frag = 0.0;
    if (g_pool.free_size > 0) {
        frag = 1.0 - (double)largest_free / (double)g_pool.free_size;
        if (frag < 0.0) frag = 0.0;
        if (frag > 1.0) frag = 1.0;
    }

    printf("=== Memory Pool Statistics ===\n");
    printf("Total pool size : %zu bytes\n", g_pool.total_size);
    printf("Free memory     : %zu bytes\n", g_pool.free_size);
    printf("Total blocks    : %d\n", g_pool.total_blocks);
    printf("Free blocks     : %d (scanned=%zu)\n", g_pool.free_blocks, free_count);
    printf("Largest free    : %zu bytes\n", largest_free);
    printf("Fragmentation   : %.1f%%\n", frag * 100.0);
    printf("==============================\n");
}
