#pragma once

#include <hal/intdef.h>

#define DEF_BUFFER_SIZE 128

template <typename T>
class Circular_Buffer
{
    const uint32_t buffer_size = DEF_BUFFER_SIZE;
    T buf[DEF_BUFFER_SIZE]  = {0};

    uint32_t read_idx    = 0;
    uint32_t write_idx   = 0;

    public:
        Circular_Buffer();
        Circular_Buffer(uint32_t buf_size);
        
        // basic functionality
        uint32_t add(T elem);
        T pop();
        T peek();
        void remove();
        uint32_t get_max_buffer_size();
        uint32_t get_buffer_len();

        // getter
        T* get_buffer();

        // convinience (char) functions
        uint32_t read(T *target, uint32_t t_len);
        uint32_t read_until(T *target, uint32_t t_len, T stopper);
        uint32_t write(T *target, uint32_t t_len);
};


template <typename T>
Circular_Buffer<T>::Circular_Buffer()
{

}

template <typename T>
Circular_Buffer<T>::Circular_Buffer(uint32_t buf_size) : buffer_size(buf_size)
{

}

template <typename T>
uint32_t Circular_Buffer<T>::add(T elem)
{
    uint8_t new_write = (write_idx + 1) % buffer_size;
    
    // allowing ovewriting end (to prevent never receiving EOL)
    // if (new_write == read_idx) return 1; // this means the buffer is full

    buf[write_idx] = elem;
    write_idx = new_write;

    return 0;
}

template <typename T>
T Circular_Buffer<T>::pop()
{
    if (read_idx == write_idx) return 0; // there is nothing to read (pop)

    T ret_val = buf[read_idx];
    read_idx = (read_idx + 1) % buffer_size;

    return ret_val;
}

template <typename T>
T Circular_Buffer<T>::peek()
{
    if (read_idx == write_idx) return 0; // there is nothing to read (peek)
    return buf[read_idx];
}

template <typename T>
void Circular_Buffer<T>::remove()
{
    if (read_idx != write_idx)
        read_idx = (read_idx + 1) % buffer_size;
}

template <typename T>
uint32_t Circular_Buffer<T>::get_max_buffer_size()
{
    return buffer_size;
}

template <typename T>
uint32_t Circular_Buffer<T>::get_buffer_len()
{
    return (buffer_size + write_idx - read_idx) % buffer_size;
}

template <typename T>
T* Circular_Buffer<T>::get_buffer()
{
    return buf;
}

/**
 * @brief Reads from internal buffer to target until there is nothing to read or target is filled.
 * 
 * Note: Doesn't use pop() internally so it can avoid considering 0 as error value.
 * 
 * @tparam T container data type
 * @param target 
 * @param t_len 
 * @return uint32_t 
 */
template <typename T>
uint32_t Circular_Buffer<T>::read(T *target, uint32_t t_len)
{
    // Note: Doesn't use pop() internally so it can avoid considering 0 as error value.
    uint32_t i = 0;
    while ((read_idx != write_idx) && (i < t_len))
    {
        target[i++] = buf[read_idx];
        read_idx = (read_idx + 1) % buffer_size;
    }

    return i;
}

template <typename T>
uint32_t Circular_Buffer<T>::read_until(T *target, uint32_t t_len, T stopper)
{
    uint32_t read_idx_tmp = read_idx;
    // --- find index of stopper element
    // changed read_idx_tmp < write_idx to !=, to support buffer overrun (input longer than buffer itself)
    while ((read_idx_tmp != write_idx) && buf[read_idx_tmp] != stopper)
        read_idx_tmp = (read_idx_tmp + 1) % buffer_size; // not inlining this as im not sure when read_idx_tmp++ happens

    if (read_idx_tmp == write_idx) return 0; // stopper doesn't exist in current buffer

    // --- copy buf to target until stopped
    // second param is buffer size using local temporary read index
    uint32_t len = ((buffer_size + read_idx_tmp - read_idx) % buffer_size) + 1; // get length of line + terminal char
    return read(target, len < t_len ? len : t_len);
}

template <typename T>
uint32_t Circular_Buffer<T>::write(T *target, uint32_t t_len)
{
    uint32_t i = 0;
    // while ((i < t_len) && (add(target[i++]) == 0))
    //     ;
    while ((i < t_len) && (add(target[i]) == 0))
        i++;

    return i; // number of inserted elements - DOES NOT have to equal t_len!
}