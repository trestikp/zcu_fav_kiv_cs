#pragma once

#include <hal/intdef.h>

// limits: https://en.cppreference.com/w/c/types/limits

#define RAND_MAX 0xFFFFFFFF

#define FLT_MIN 1.175494e-38
#define FLT_MAX 3.402823e+38

#define INT_MIN -2147483648
#define INT_MAX +2147483647
#define UINT_MAX 4294967295 // this is equal to RAND_MAX

class Random
{
    private:
        char buf[sizeof(uint32_t)] = {0};
        uint32_t rng_file = 0;

        uint32_t rand();

    public:
        Random();

        /**
         * @brief Opens Random Generator File. This must be called before using rand.
         * 
         */
        void open_rand();

        float rand_float(float low = FLT_MIN, float high = FLT_MAX);
        int32_t rand_int(int32_t low = INT_MIN, int32_t high = INT_MAX);
        uint32_t rand_unsigned_int(uint32_t low = 0, uint32_t high = UINT_MAX);
};

extern Random rand;

namespace std
{
    void* malloc(uint32_t size);
};