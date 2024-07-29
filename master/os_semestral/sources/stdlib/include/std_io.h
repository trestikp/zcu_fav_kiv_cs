#pragma once

#include <hal/intdef.h>
#include <stdfile.h>
#include <stdstring.h>

namespace std
{
    /**
     * @brief Puts string into file "stream".
     * 
     * @param file target "stream"
     * @param string source that is put to "stream"
     * @return uint32_t number of written bytes. 0 on non-written, positive number otherwise.
     */
    uint32_t fputs(uint32_t file, const char* string);

    /**
     * @brief Reads (BLOCKING!) string from file "stream" into a buffer.
     * 
     * NOTE: This read is BLOCKING and will wait until input is ready. This is to have the same functionality
     *  as regular fgets in standard library (Linux).
     * 
     * @param file source file "stream"
     * @param s target buffer
     * @param s_len target buffer length
     * @return char* On success returns pointer to target string. NULL (nullptr) otherwise.
     */
    char* fgets(uint32_t file, char *s, uint32_t s_len);

    /**
     * @brief Reads (NON! blocking) string from file "stream" into a buffer. If this read fails to read anything
     * it returns NULL (nullptr). It DOES NOT wait until input is ready.
     * 
     * @param file source file "stream"
     * @param s target buffer
     * @param s_len target buffer length
     * @return char* On success returns pointer to target string. NULL (nullptr) otherwise.
     */
    uint32_t fgets_nb(uint32_t file, char *s, uint32_t s_len);
};