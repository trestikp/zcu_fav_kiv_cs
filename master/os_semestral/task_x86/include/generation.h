#pragma once

#include <stdint.h>

#include <chromosome.h>

#define GEN_SIZE 100

class Generation
{
    private:
        // Chromosome gen[GEN_SIZE];

        // uint32_t top_ten[10];
    
    public:
        Chromosome gen[GEN_SIZE];

        void evaluate_gen(float measured_value);
        void next_gen(Generation *g);
        void init_random();
        /** 
         * Returns the most accurate prediction (Chromosome fitness) from generation.
         * 
         * NOTE: This function assumes the generation is sorted before its call.
         */
        float get_best_result();
};