#pragma once

#include <hal/intdef.h>

// random number generator - Linear congruential generator
class LCG {
    private:
        // randomly chosen numbers, a and c should be primes
        const int a = 5039101, c = 19205573, mod = 1234098756;
        int seed; //maybe unsigned int?

    public:
        LCG();
        LCG(int p_seed);

        void set_seed(int p_seed);
        int get_seed();
        int get_next();
};

extern LCG lcgInstance;