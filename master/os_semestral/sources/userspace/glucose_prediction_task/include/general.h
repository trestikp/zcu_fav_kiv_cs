#pragma once

// kernel includes
#include <hal/intdef.h>
#include <drivers/uart.h>

// stdlib + stdutils includes
#include <stdstring.h>
#include <stdfile.h>
#include <std_io.h>
#include <circ_buffer.h>

// task includes
#include <generation.h>

#define GENS_PER_DELTA 100

#define LARGE_BUFF  128
#define MEDUIM_BUFF 64
#define SMALL_BUFF  32


enum class Res_Code : int
{
    NO_ERR      = 0,
    INPUT_ERR   = 1,
    PARSE_ERR   = 2,
    MEM_FAIL    = 3,
};

enum class Input
{
    ERR         = 0,
    NO_INPUT    = 1,
    STOP_CMD    = 2,
    PARAM_CMD   = 3,
    FLOAT_IN    = 4,
};

enum class App_State
{
    CALCULATING,
    WAITING_FOR_INPUT,
};

class General
{
    private:
        // general
        App_State state = App_State::WAITING_FOR_INPUT;
            
        // uart

        uint32_t uart_file;
        char uart_buf[DEF_BUFFER_SIZE];
        char out_buf[LARGE_BUFF];

        // user interaction

        Circular_Buffer<char> cb;
        Res_Code err_no = Res_Code::NO_ERR; // flag for determining errors - default is 0 = no error
        uint32_t t_delta = 0;   // user input value
        uint32_t t_pred = 0;    // user input value
        float measured_value = 0.0; // user input value

        // genetic algorithm (gea)

        uint32_t t_steps;   // t_pred / t_delta - used to be number of required generations (obsolete)
        uint32_t delta_counter = 0;
        float* past_measurements = nullptr;     // array of measurements for each t_delta (size = t_steps)
        float* predicted_values = nullptr;      // this is currently unused, but it could be used in fitness
        Generation* old_gen = nullptr;    // old generation - fall back when "stop" command is called
        Generation* gen = nullptr;        // current generation - used for prediction
        Generation* next_gen = nullptr;   // used for creating new generation

        uint32_t gen_counter = 0;


        bool buf_contains_char(char target);
        void reset_err_no();
        void set_err_no(Res_Code e);

        /**************************************************************************************************************/
        /*    used for reading input                                                                                  */
        /**************************************************************************************************************/

        /**
         * @brief Repeatedly reads UART until a whole line was read. This read is blocking. Read will
         * repeat until a whole line is read and wait for input otherwise (this should put the processto sleep).
         * 
         * @return uint32_t 
         */
        uint32_t read_line();

        /**
         * @brief Reads UART. If there is a line returns 0. Line is read into uart_buf.
         * 
         * @return uint32_t 
         */
        uint32_t read_line_non_blocking();

        /**
         * @brief Reads line from UART and attempts to parse it to int. If and error occurs function
         * returns 0 and sets err_no flag with appropriate error.
         * 
         * err_no (type Res_Code):
         *  1 = read line failed
         *  2 = parsing to int failed
         * 
         * @return int 
         */
        int read_int();

        uint32_t read_int_into(uint32_t &target);
        Input parse_val_or_command();
        uint32_t read_cb_line_to_buf();

        /**************************************************************************************************************/
        /*    GEA functions                                                                                           */
        /**************************************************************************************************************/

        bool malloc_success(void* ptr);
        float pm_avg(); // get past measurements average

    public:
        General();

        uint32_t setup_uart();
        Res_Code get_res_no();

        App_State get_app_state();
        void reset_state();
        void init_defaults();
        void trim_eol(char* buf);

        /**************************************************************************************************************/
        /*    interaction with user                                                                                   */
        /**************************************************************************************************************/

        void print_welcome_banner();
        void print_val_command_request();
        void print_app_crash();
        void print_line(const char* str);
        void print_line_and_prompt_input(const char* str);        
        void prompt_user_input();

        uint32_t read_t_delta();
        uint32_t read_t_pred();
        Input read_val_or_command();
        Input read_val_or_command_blocking();

        /**************************************************************************************************************/
        /*    generic algorithm controls                                                                              */
        /**************************************************************************************************************/

        Res_Code setup_gea();
        void do_stop_command();
        void do_parameters_command();
        void start_calculate();
        void do_calculate();
};