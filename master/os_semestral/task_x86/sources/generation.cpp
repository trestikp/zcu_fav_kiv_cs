#include <generation.h>

#include <stdio.h>
#include <q_sort.h>

void Generation::evaluate_gen(float measured_value)
{
    for (int i = 0; i < GEN_SIZE; i++)
    {
        gen[i].fitness(measured_value);
    }

    // --- sort gen for easier work with it
    // debug print before
    // for (int i = 0; i < GEN_SIZE; i++)
    //     printf("%f, ", gen[i].get_prediction());
    // printf("\n");
    
    quicksort(gen, GEN_SIZE); // TODO: sort here?

    // debug print after
    // for (int i = 0; i < GEN_SIZE; i++)
    //     printf("%f, ", gen[i].get_prediction());
    // printf("\n");
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

void Generation::next_gen(Generation *g)
{
    // --- use top 10% without change
    for (int i = 0; i < (GEN_SIZE / 10); i++)
        g->gen[i] = gen[i]; // this should copy right? TODO

    // --- crossbreed (top) 80% chromosomes - includes top 10%
    for (int i = 0; i < (GEN_SIZE / 80); i += 2)
    {
        // TODO off1 and off2 dont need to be new, redo it to g->gen[i]
        Chromosome off1, off2;
        gen[i].crossover(gen[i + 1], off1, off2);

        g->gen[(GEN_SIZE / 10) + i] = off1;
        g->gen[(GEN_SIZE / 10) + i + 1] = off2;
    }

    // --- put copy of top 10% to the back
    for (int i = 0; i < (GEN_SIZE / 10); i++)
        g->gen[GEN_SIZE - i] = gen[i]; // order of last top 10% doesn't really matter as they will be mutated

    // --- mutate 40%? last
    for (int i = (GEN_SIZE / 60); i < GEN_SIZE; i++)
        g->gen[i].mutate();
}