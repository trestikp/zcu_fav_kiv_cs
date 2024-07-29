#pragma once

#include <chromosome.h>
#include <hal/intdef.h>

#define GEN_SIZE 100
#define CO_P_CNT 3 // Crossover parent count

class Generation
{
    private:
        Chromosome gen[GEN_SIZE];
    
    public:

        void evaluate_gen(float target);

        /**
         * @brief Creates the next generation into @g (g must be initialized).
         * 
         * @param g target generation
         */
        void next_gen(Generation *g);
        void init_random();

        Chromosome* get_best_chromosome();

        /** 
         * Returns the most accurate prediction (Chromosome fitness) from generation.
         * 
         * NOTE: This function assumes the generation is sorted before its call.
         */
        float get_best_result();

        /**
         * @brief Returns pointer to the parameters of the best chromosome in generation.
         * 
         * @return float* - start of the params array. Use PARAM_COUNT constant for iteration.
         */
        float* get_best_params();
};