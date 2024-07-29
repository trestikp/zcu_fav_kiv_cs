#include <std_io.h>


uint32_t std::fputs(uint32_t file, const char* string)
{
    return write(file, string, strlen(string));
}

char* std::fgets(uint32_t file, char *s, uint32_t s_len)
{
    wait(file); // no deadline set, should wait indefinetly
    
    uint32_t n = 0;
    if ((n = read(file, s, s_len)) > 0)
        return s;
    
    return nullptr;
}

uint32_t std::fgets_nb(uint32_t file, char *s, uint32_t s_len)
{
    return read(file, s, s_len);
}