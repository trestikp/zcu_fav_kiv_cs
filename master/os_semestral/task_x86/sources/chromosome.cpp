#include <chromosome.h>

// #include <cstdlib>
#include <stdlib.h>


const float Chromosome::par_low[]     = {-5, -5, -5, -5, -5};
const float Chromosome::par_high[]    = { 5,  5,  5,  5,  5};
const float Chromosome::yt_limit[]    = { 3, 20};

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
float Chromosome::b_in_t()
{
    // TODO fix derivation
    float derivation = 5 / 1.0 / (24.0 * 60.0 * 60.0); // diferenci ceho? y(t) a t? to mi moc nedava smysl
    return (params[Params::D] / params[Params::E]) * derivation + (1 / params[Params::E]) * yt;
}

// y(t + t_pred) = A * b(t) + B * b(t) * (b(t) - y(t)) + C
void Chromosome::predict()
{
    float bt = b_in_t();
    yt_pred = params[Params::A] * bt + params[Params::B] * bt * (bt - yt) + params[Params::C];
}

float Chromosome::fitness(float &measured_value)
{
    predict();
    fit = (yt_pred - measured_value) * (yt_pred - measured_value);
    return fit;
}

void Chromosome::mutate()
{
    // ideally randomize some parameters
    // for simplicity modifying only a single parameter, because it can be difficult to randomly select multiple (its already too much calculation anyway)

    // --- select random parameter
    // 0 + rand(5); <0,5>
    int p = 0 + rand() % PARAM_COUNT;
    // --- select random value
    params[p] = par_low[p] + static_cast<float> (rand() / static_cast<float> (RAND_MAX / (par_high[p] - par_low[p]))); // generation of flow from a certain interval
    // -5 + rand(10); <-5,5> - limits for parameters, those need to be done yet!
}

void Chromosome::crossover(Chromosome &other, Chromosome &offspring1, Chromosome &offspring2)
{
    // how to cross breed those? this method is kinda lame, but thanks to it param limits don't have to be checked
    for (int i = 0; i < PARAM_COUNT; i++)
    {
        if (i % 2) 
        {
            offspring1.params[i] = other.params[i];
            offspring2.params[i] = params[i];
        }
        else
        {
            offspring1.params[i] = params[i];
            offspring2.params[i] = other.params[i];
        }
    }
}

void Chromosome::init_randomly()
{
    for (int i = 0; i < PARAM_COUNT; i++)
        params[i] = par_low[i] + static_cast<float> (rand() / static_cast<float> (RAND_MAX / (par_high[i] - par_low[i]))); // generation of flow from a certain interval

    yt = yt_limit[0] + static_cast<float> (rand() / static_cast<float> (RAND_MAX / (yt_limit[1] - yt_limit[0]))); // generation of flow from a certain interval
}

float Chromosome::get_fitness()
{
    return fit;
}

float Chromosome::get_prediction()
{
    return yt_pred;
}