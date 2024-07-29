#include <drivers/lcg.h>

LCG lcgInstance;

LCG::LCG() {}; // does this need to be specified?
LCG::LCG(int p_seed) 
    : seed(p_seed) {};


void LCG::set_seed(int p_seed) {
    seed = p_seed;
}

int LCG::get_seed() {
    return seed;
}

int LCG::get_next() {
    seed = (a * seed + c) % mod;
    return seed;
}