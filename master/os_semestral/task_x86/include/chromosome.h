#pragma once

#define PARAM_COUNT 5

enum Params : int
{
    A = 0,
    B = 1,
    C = 2,
    D = 3,
    E = 4,
};

enum Par_Lower : int
{
    A_Low = -5,
    B_Low = -5,
    C_Low = -5,
    D_Low = -5,
    E_Low = -5,
};

enum Par_Higher : int
{
    A_High = 5,
    B_High = 5,
    C_High = 5,
    D_High = 5,
    E_High = 5,
};

class Chromosome
{
    public:
        // Calculates fitness with actual measured value and stores it in fit and also returns it.
        float fitness(float &measured_value);
        void mutate();
        // TODO: this might need something like "yt" param, but i dont know if yt is measured value or predicted
        void crossover(Chromosome &other, Chromosome &offspring1, Chromosome &offspring2);
        void init_randomly();

        float get_fitness();
        float get_prediction();

        // need those for quick sort
        bool operator < (Chromosome const &obj);
        bool operator > (Chromosome const &obj);
        // Chromosome operator <= (Chromosome const &obj);
        // Chromosome operator >= (Chromosome const &obj);

    private:
        const static float par_low[PARAM_COUNT];
        const static float par_high[PARAM_COUNT];
        const static float yt_limit[2]; // 0 = lower limit, 1 = higher limit

        float yt = 0;
        float yt_pred = 0; // this is our prediction
        float params[5] = {0}; // parameters: A, B, C, D, E
        float fit = 0;

        float b_in_t();
        void predict();
};