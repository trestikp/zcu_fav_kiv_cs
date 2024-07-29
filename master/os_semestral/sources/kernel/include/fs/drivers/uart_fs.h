#pragma once

#include <drivers/uart.h>
#include <hal/peripherals.h>
#include <memory/kernel_heap.h>
#include <fs/filesystem.h>
#include <process/process_manager.h>
#include <stdstring.h>

// virtualni UART soubor
class CUART_File final : public IFile
{
    private:
        // UART kanal
        int mChannel;

    public:
        CUART_File(int channel)
            : IFile(NFile_Type_Major::Character), mChannel(channel)
        {
            //
        }

        ~CUART_File()
        {
            Close();
        }

        virtual uint32_t Read(char* buffer, uint32_t num) override
        {
            if (num > 0 && buffer != nullptr)
            {
                if (mChannel == 0)
                {
                    // uint32_t n = sUART0.Read(buffer, num);
                    uint32_t n = sUART0_Buffer.read(buffer, num);
                    return n;
                }
            }

            return 0;
        }

        virtual uint32_t Write(const char* buffer, uint32_t num) override
        {
            if (num > 0 && buffer != nullptr)
            {
                if (mChannel == 0)
                {
                    sUART0.Write(buffer, num);
                    return num;
                }
            }

            return 0;
        }

        virtual bool Close() override
        {
            if (mChannel < 0)
                return false;

            if (mChannel == 0)
                sUART0.Close();
            mChannel = -1;

            return IFile::Close();
        }

        virtual bool IOCtl(NIOCtl_Operation dir, void* ctlptr) override
        {
            // proces chce ziskat parametry - naformatujeme mu je do jim dodane struktury (v jeho adr. prostoru)
            if (dir == NIOCtl_Operation::Get_Params)
            {
                TUART_IOCtl_Params* params = reinterpret_cast<TUART_IOCtl_Params*>(ctlptr);
                if (mChannel == 0)
                {
                    params->baud_rate = sUART0.Get_Baud_Rate();
                    params->char_length = sUART0.Get_Char_Length();
                    return true;
                }
            }
            // proces chce nastavit parametry
            else if (dir == NIOCtl_Operation::Set_Params)
            {
                TUART_IOCtl_Params* params = reinterpret_cast<TUART_IOCtl_Params*>(ctlptr);
                if (mChannel == 0)
                {
                    sUART0.Set_Baud_Rate(params->baud_rate);
                    sUART0.Set_Char_Length(params->char_length);
                    return true;
                }
            } else if (dir == NIOCtl_Operation::Enable_Event_Detection)
            {
                TUART_IOCtl_Params* params = reinterpret_cast<TUART_IOCtl_Params*>(ctlptr);
                if (mChannel == 0 && params->rx_interrupt)
                {
                    sUART0.Enable_RX_Interrupt();
                }
            } else if (dir == NIOCtl_Operation::Disable_Event_Detection)
            {
                TUART_IOCtl_Params* params = reinterpret_cast<TUART_IOCtl_Params*>(ctlptr);
                if (mChannel == 0 && !params->rx_interrupt)
                {
                    sUART0.Disable_RX_Interrupt();
                }
            }


            return false;
        }

        virtual bool Wait(uint32_t count) override
        {
            Wait_Enqueue_Current();
            sUART0.Wait_For_Event(this);

            // zablokujeme, probudi nas az notify 
	        sProcessMgr.Block_Current_Process();
            return true;
        }
};

class CUART_FS_Driver : public IFilesystem_Driver
{
	public:
		virtual void On_Register() override
        {
            //
        }

        virtual IFile* Open_File(const char* path, NFile_Open_Mode mode) override
        {
            // jedina slozka path - kanal UARTu

            int channel = atoi(path);
            if (channel != 0) // mame jen jeden kanal
                return nullptr;

            if (!sUART0.Open())
                return nullptr;

            CUART_File* f = new CUART_File(channel);

            return f;
        }
};

CUART_FS_Driver fsUART_FS_Driver;
