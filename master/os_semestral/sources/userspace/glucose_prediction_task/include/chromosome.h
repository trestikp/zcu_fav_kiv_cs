#pragma once

#include <hal/intdef.h>

#define PARAM_COUNT 5


// hopefully i avoid static initialization order fiasco
namespace Chromosome_NS
{
    // those global instances serve as replacement for static variables (static variables don't work)
    extern const char* par_names[PARAM_COUNT];
    extern const float par_low[PARAM_COUNT];
    extern const float par_high[PARAM_COUNT];
    extern const float yt_limit[2]; // 0 = lower limit, 1 = higher limit
    extern float t_delta; // t_delta in seconds - setter must convert this
};

enum Params : int
{
    A = 0,
    B = 1,
    C = 2,
    D = 3,
    E = 4,
};

class Chromosome
{
    public:
        // Calculates fitness with actual measured value and stores it in fit and also returns it.
        float fitness(float &measured_value);
        void mutate();
        void crossover(Chromosome &other, Chromosome &offspring);

        void init_randomly();
        float predict(float yt);

        float get_fitness();
        float get_prediction();
        float* get_params();

        // need those for quick sort
        bool operator < (Chromosome const &obj);
        bool operator > (Chromosome const &obj);

    private:
        float yt_pred = 0; // this is our prediction
        float params[5] = {0}; // parameters: A, B, C, D, E
        float fit = 0;

        float b_in_t(float yt);
};