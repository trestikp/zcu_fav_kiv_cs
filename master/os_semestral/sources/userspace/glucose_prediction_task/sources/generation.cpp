#include <generation.h>
#include <q_sort.h>

#include <stdstring.h>

void Generation::evaluate_gen(float target)
{
    for (int i = 0; i < GEN_SIZE; i++)
    {
        gen[i].fitness(target);
    }

    // --- sort gen for easier work with it
    quicksort(gen, GEN_SIZE);
}

void Generation::init_random()
{
    for (int i = 0; i < GEN_SIZE; i++)
        gen[i].init_randomly();
}

float Generation::get_best_result()
{
    return gen[0].get_prediction();
}

float* Generation::get_best_params()
{
    return gen[0].get_params();
}

Chromosome* Generation::get_best_chromosome()
{
    return &(gen[0]); // technically the same as: return gen;
}

void Generation::next_gen(Generation *g)
{
    // --- splits
    uint32_t top10 = (GEN_SIZE / 10);
    uint32_t around80 = (GEN_SIZE / 80); // ~80% but need to be divisible by CO_P_CNT (3)
    if (around80 % CO_P_CNT) around80 += (CO_P_CNT + (around80 % CO_P_CNT)); // making around80 divisible by 3
    uint32_t remains = GEN_SIZE - top10 - around80;

    // --- use top 10% without change
    for (int i = 0; i < top10; i++)
        g->gen[i] = gen[i];

    // --- crossbreed (top) ~80% chromosomes - includes top 10% (to crossbreed the best samples)
    for (int i = 0; i < around80; i += CO_P_CNT)
    {
        // uses avg to create an offspring -> 2 parents = 1 offspring, 3 parent = 3 off springs (1-2, 1-3, 2-3)
        // to avoid having to create universal algorithm it is assumed that CO_P_CNT is always 3
        gen[i].crossover(gen[i + 1]     , g->gen[top10 + i]);        // 1-2
        gen[i].crossover(gen[i + 2]     , g->gen[top10 + i + 1]);    // 1-3
        gen[i + 1].crossover(gen[i + 2] , g->gen[top10 + i + 2]);    // 2-3
    }

    // --- put copy of top 10% to the back (this is because those will be mutaded)
    for (int i = 0; i < remains; i++)
        g->gen[GEN_SIZE - i] = gen[i]; // order doesn't matter - they will be mutated

    // --- mutate 40%? last
    for (int i = (GEN_SIZE / 60); i < GEN_SIZE; i++)
        g->gen[i].mutate();
}