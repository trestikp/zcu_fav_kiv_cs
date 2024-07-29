#pragma once

#include <hal/intdef.h>

// // struktura, ktera bude predchazet kazdemu alokovanemu bloku na kernelove halde
// struct USpace_Chunk_Header
// {
//     USpace_Chunk_Header* prev;
//     USpace_Chunk_Header* next;
//     uint32_t size;
//     bool is_free;
// };

// // simple "first-fit" allocator for userspace memory
// class Userspace_Heap
// {
//     private:
//         USpace_Chunk_Header* head;
//         /** last makes sense for this case because we are not supporting "Free", so we will only be allocating more */
//         USpace_Chunk_Header* last;
//         USpace_Chunk_Header* Alloc_Next_Page();

//     public:
//         Userspace_Heap();

//         void* sbrk(uint32_t increment);
// };


class Userspace_Heap
{
    private:
        /** first allocated page = start of the heap */
        uint32_t heap_start = 0;
        /** current heap head = where to start allocating new memory */
        uint32_t heap_head  = 0;
        /** allocated heap size = used to calc if there is enough memory for allocation */
        uint32_t heap_size  = 0;

        /** Allocates new page and maps it to pt (page table) */
        uint32_t alloc_and_memmap(uint32_t* pt);

    public:
        Userspace_Heap();

        void* sbrk(uint32_t* pt, uint32_t increment);
};

extern Userspace_Heap UHeap;