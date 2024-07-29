#include <memory/userspace_heap.h>
#include <memory/pages.h>
#include <memory/pt_alloc.h>

#define USERSPACE_HEAP_START 0x21000000

Userspace_Heap UHeap;

Userspace_Heap::Userspace_Heap()
{
    //
}

uint32_t Userspace_Heap::alloc_and_memmap(uint32_t* pt)
{
    uint32_t pg = sPage_Manager.Alloc_Page();
    
    if (!pg)
        return 1;

    map_memory(pt, pg - mem::MemoryVirtualBase, heap_start + heap_size);
    heap_size += mem::PageSize;

    return 0;
}

void* Userspace_Heap::sbrk(uint32_t* pt,uint32_t increment)
{
    if (heap_start == 0)
    {
        heap_start = USERSPACE_HEAP_START;
        if (alloc_and_memmap(pt))
            return nullptr; // failed to allocate memory
        // heap_start = mem::MemoryVirtualBase;
        heap_head = heap_start;
    }

    while ((heap_size - heap_head) < increment)
        // if we ran out of pages to get enough memory, it would be nice to free the pages allocated here, but in this work we dont implement free
        if (alloc_and_memmap(pt))
            return nullptr; // failed to allocate memory
    
    heap_head += increment;

    // return previous heap_head as its a start of the allocated mem
    return (void*) (heap_head - increment);
}