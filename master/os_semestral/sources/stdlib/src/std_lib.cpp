#include <std_lib.h>

#include <stdfile.h>
#include <stdstring.h>


Random rand;

Random::Random()
{

}

void Random::open_rand()
{
    // rng_file is already open... skipping
    if (rng_file != 0 && rng_file != Invalid_Handle)
        return;

    // Read_Write tries to open the file exclusively - only opened once
    rng_file = open("DEV:trng", NFile_Open_Mode::Read_Write);

    if (rng_file == Invalid_Handle)
        // if opening file exclusively fails, try to open as Read_Only
        rng_file = open("DEV:trng", NFile_Open_Mode::Read_Only);
}

float Random::rand_float(float low, float high)
{
    return low + static_cast<float>(rand() / static_cast<float>(RAND_MAX / (high - low)));
}

int32_t Random::rand_int(int32_t low, int32_t high)
{
    // do we want + 1? = include "high"?
    return low + (rand() % (high - low + 1));
}

uint32_t Random::rand_unsigned_int(uint32_t low, uint32_t high)
{
    // do we want + 1? = include "high"?
    return low + (rand() % (high - low + 1));
}

uint32_t Random::rand()
{
    // bzero(buf, sizeof(uint32_t)); // shouldn't be necessary
    read(rng_file, buf, sizeof(uint32_t));

	return *((uint32_t*) buf);
}

void* std::malloc(uint32_t size)
{
    uint32_t addr;

    asm volatile("mov r0, %0" : : "r" (size));
    asm volatile("swi 6");
    asm volatile("mov %0, r0" : "=r" (addr));

    return (void*) addr;
}