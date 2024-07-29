#pragma once

#include <hal/peripherals.h>
#include <drivers/bcm_aux.h>
#include <drivers/bridges/uart_defs.h>
#include <circ_buffer.h>
#include <fs/filesystem.h>
#include <process/spinlock.h>

class CUART
{
    public:
        using UART_IRQ_Callback = void(*)();

    private:
        // odkaz na AUX driver
        CAUX& mAUX;

        // byl UART kanal otevreny?
        bool mOpened;

        // nastavena baud rate, ukladame ji proto, ze do registru se uklada (potencialne ztratovy) prepocet
        NUART_Baud_Rate mBaud_Rate;

        // taken from gpio.h
        struct TWaiting_File
		{
			IFile* file;
			TWaiting_File* prev;
			TWaiting_File* next;
		};

		TWaiting_File* mWaiting_Files;

        spinlock_t mLock;

    public:        
        CUART(CAUX& aux);

        // otevre UART kanal, exkluzivne
        bool Open();
        // uzavre UART kanal, uvolni ho pro ostatni
        void Close();
        // je UART kanal momentalne otevreny?
        bool Is_Opened() const;

        NUART_Char_Length Get_Char_Length();
        void Set_Char_Length(NUART_Char_Length len);

        NUART_Baud_Rate Get_Baud_Rate();
        void Set_Baud_Rate(NUART_Baud_Rate rate);

        // interrupts
        void Enable_RX_Interrupt();     // Enables interrupt on data received
        void Disable_RX_Interrupt();    // Disables interrupt on data received

        void IRQ_Callback();            // This is called from interrupt handler
        bool Is_UART_IRQ_Pending();    // Interrupt handler uses this to check if UART has interrupt pending

        void Wait_For_Event(IFile* file);

        // miniUART na RPi0 nepodporuje nic moc jineho uzitecneho, napr. paritni bity, vice stop-bitu nez 1, atd.

        void Write(char c);
        void Write(const char* str);
        void Write(const char* str, unsigned int len);
        void Write(unsigned int num);
        void Write_Hex(unsigned int num);
        
        char Read();
};

extern CUART sUART0;
extern Circular_Buffer<char> sUART0_Buffer;
