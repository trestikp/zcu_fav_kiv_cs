#include <chromosome.h>

#include <std_lib.h>
#include <stdstring.h>


// const char* par_names[] = {"A\0", "B\0", "C\0", "D\0", "E\0"};
const char* Chromosome_NS::par_names[] = {"A", "B", "C", "D", "E"};
const float Chromosome_NS::par_low[]   = {-5, -5, -5, -5, -5};
const float Chromosome_NS::par_high[]  = { 5,  5,  5,  5,  5};
float       Chromosome_NS::t_delta     = 0.0;


bool Chromosome::operator < (Chromosome const &obj)
{
    return fit < obj.fit;
}

bool Chromosome::operator > (Chromosome const &obj)
{
    return fit > obj.fit;
}

// b(t) = D/E * dy(t)/dt + 1/E * y(t)
// dy(t)/dt je v sice derivace, vzhledem k povaze hodnot stačí aproximovat diferencí dělenou číslem 1.0/(24.0*60.0*60,0), je-li t v sekundách
float Chromosome::b_in_t(float yt)
{
    float derivation = Chromosome_NS::t_delta / 1.0 / (24.0 * 60.0); // from my understanding t_delta is "differential"
    return (params[Params::D] / params[Params::E]) * derivation + (1 / params[Params::E]) * yt;
}

// y(t + t_pred) = A * b(t) + B * b(t) * (b(t) - y(t)) + C
float Chromosome::predict(float yt)
{
    float bt = b_in_t(yt);
    yt_pred = params[Params::A] * bt + params[Params::B] * bt * (bt - yt) + params[Params::C];
    return yt_pred;
}

float Chromosome::fitness(float &measured_value)
{
    predict(measured_value);
    fit = (yt_pred - measured_value) * (yt_pred - measured_value);
    return fit;
}

void Chromosome::mutate()
{
    uint32_t indexes[PARAM_COUNT];
    uint8_t p, tmp;
    uint8_t i_cnt = rand.rand_int(1, PARAM_COUNT - 2); // choose number of parameters that is modified <1,3>
    float new_low, new_high;

    // --- init indexes
    for (int i = 0; i < PARAM_COUNT; i++)
        indexes[i] = i;

    // --- choses which indexes will be mutated, by putting selected indexes (by random) at the end of the array
    for (int i = 0; i < i_cnt; i++)
    {
        p = rand.rand_int(0, PARAM_COUNT - i); // select param index, that WILL NOT be modified
        
        // put randomly selected index to to the end of array - those indexes WILL NOT be iterated
        tmp = indexes[PARAM_COUNT - i];
        indexes[PARAM_COUNT - i] = indexes[p];
        indexes[p] = tmp;
    }

    // --- modify "not selected" params. New limits are within |1| to either side
    for (int i = 0; i < PARAM_COUNT - i_cnt; i++)
    {
        // new_low = (params[indexes[i]] - 1.0) < Chromosome_NS::par_low[indexes[i]] ? Chromosome_NS::par_low[indexes[i]] : params[indexes[i]] - 1.0;
        new_low = params[indexes[i]] - 1.0;
        if (new_low < Chromosome_NS::par_low[indexes[i]]) 
            new_low = Chromosome_NS::par_low[indexes[i]];

        new_high = params[indexes[i]] + 1.0;
        if (new_high > Chromosome_NS::par_high[indexes[i]])
            new_high = Chromosome_NS::par_high[indexes[i]];

        params[indexes[i]] = rand.rand_float(new_low, new_high);
    }
}

void Chromosome::crossover(Chromosome &other, Chromosome &offspring)
{
    for (int i = 0; i < PARAM_COUNT; i++)
    {
        offspring.params[i] = (params[i] + other.params[i]) / 2;
    }
}

void Chromosome::init_randomly()
{
    for (int i = 0; i < PARAM_COUNT; i++)
        params[i] = rand.rand_float(Chromosome_NS::par_low[i], Chromosome_NS::par_high[i]);
}

float Chromosome::get_fitness()
{
    return fit;
}

float Chromosome::get_prediction()
{
    return yt_pred;
}

float* Chromosome::get_params()
{
    return params;
}