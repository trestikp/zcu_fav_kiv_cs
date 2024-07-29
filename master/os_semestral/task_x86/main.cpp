#include <chromosome.h>
#include <generation.h>

#include <stdio.h>
#include <stdlib.h>
#include <stdint.h>
#include <time.h>

#include <chrono> // FIXME: debug only

#define FAKE_M_COUNT 500

int main (int argc, char *argv[])
{
    // --- init RNG
    srand(static_cast<unsigned int>(time(0)));

    // --- fake t_delta and t_pred inputs
    uint32_t t_delta = 5;
    uint32_t t_pred = 15;

    // this is to fake input in actual arm task
    uint32_t input_count = 0;
    // float fake_measurements[10] = {9.8, 11.3, 13.1, 10.0, 6.4, 8.7, 9.2, 8.3, 5.9, 9.8};
    float fake_measurements[FAKE_M_COUNT];
    for (int i = 0; i < FAKE_M_COUNT; i++)
        fake_measurements[i] = 5 + static_cast<float> (rand() / static_cast<float> (RAND_MAX / (12 - 5)));

    uint32_t gens_needed = t_pred / t_delta + 1;
    uint32_t gen_index = 0;
    uint32_t gen_counter = 0;
    uint32_t free_gen = gens_needed - 1; // index

    // maybe do array of pointers? **gens
    // using **gens to easily swap generations, so the last generation is always "temp"
    Generation* gens[gens_needed];
    // Generation *gens = (Generation*) malloc(gens_needed * sizeof(Generation));

    // init generations randomly for the first runs
    for (int i = 0; i < gens_needed; i++)
    {
        gens[i] = (Generation*) malloc(sizeof(Generation)); // or new Generation(); ?
        gens[i]->init_random();
    }

    Generation *source_gen, *target_gen, *tmp_gen;

    // FIXME: debug
    auto start = std::chrono::high_resolution_clock::now();
    auto end = std::chrono::high_resolution_clock::now();
    auto duration = std::chrono::duration_cast<std::chrono::microseconds>(end - start);

    // because we can only evaluate generation when we get real value, we can only have one generation per t_delta

    while (1)
    {
        if (input_count == FAKE_M_COUNT) break; // NOTE: this wont be in the arm version
        

        if (gen_index < (gens_needed - 1))
        {
            printf("NaN - can't compute yet\n");
            // init generation might be there, but all gens were already randomly init-ed beforehand
        } 
        else 
        {
            // everything below is basically else

            source_gen = gens[gen_index % (gens_needed - 1)];
            target_gen = gens[(gens_needed - 1)]; // last generation in array will always be "temp"

            float input = fake_measurements[input_count];

            start = std::chrono::high_resolution_clock::now();
            // evaluate_gen takes about 6x more than next_gen()
            source_gen->evaluate_gen(input); // TODO maybe do the evaluation 1 by 1 or mabye every few chromosomes and check for uart when they are done
            end = std::chrono::high_resolution_clock::now();
            duration = std::chrono::duration_cast<std::chrono::microseconds>(end - start);
            // printf("Eval gen took: %d us\n", duration.count());

            float res = source_gen->get_best_result();
            // printf("Prediction result: %f\nMeasured value: %f\n", res, input);
            float dev = input - res;
            if (dev < 0) dev = -dev;
            printf("Deviation: %f\n", dev);

            start = std::chrono::high_resolution_clock::now();
            source_gen->next_gen(target_gen);
            end = std::chrono::high_resolution_clock::now();
            duration = std::chrono::duration_cast<std::chrono::microseconds>(end - start);
            // printf("Next gen took: %d us\n", duration.count());

            tmp_gen = target_gen;
            target_gen = source_gen;
            source_gen = tmp_gen;
        }

        gen_index++; // gen_index can overflow, but it might be fine, since it starts from 0? - atleast it dones break indexing

        input_count++; // NOTE: this wont be in the arm version
    }

    // wtf this is seg fault
    // for (int i = 0; i < gens_needed; i++)
    //     free(gens[i]);
    
    return 0;
}