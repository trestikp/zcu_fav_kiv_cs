#include <drivers/uart.h>
#include <drivers/bcm_aux.h>
#include <drivers/gpio.h>
#include <interrupt_controller.h>

#include <stdstring.h>


Circular_Buffer<char> sUART0_Buffer;

CUART sUART0(sAUX);

CUART::CUART(CAUX& aux)
    : mAUX(aux), mOpened(false)
{

}

bool CUART::Open()
{
    // TODO: zamek, aby se neco neseslo

    if (mOpened)
        return false;

    // rezervujeme si TX a RX piny, exkluzivne pro nas (R i W, ackoliv je jeden jen vstupni a jeden jen vystupni)
    if (!sGPIO.Reserve_Pin(14, true, true))
        return false;

    if (!sGPIO.Reserve_Pin(15, true, true))
    {
        sGPIO.Free_Pin(14, true, true);
        return false;
    }

    mAUX.Enable(hal::AUX_Peripherals::MiniUART);
    mAUX.Set_Register(hal::AUX_Reg::MU_IIR, 0);
    mAUX.Set_Register(hal::AUX_Reg::MU_IER, 0);
    mAUX.Set_Register(hal::AUX_Reg::MU_MCR, 0);
    mAUX.Set_Register(hal::AUX_Reg::MU_CNTL, 3); // RX and TX enabled

    // nastavime GPIO 14 a 15 na jejich alt funkci 5, coz je UART kanal 1
    sGPIO.Set_GPIO_Function(14, NGPIO_Function::Alt_5);
    sGPIO.Set_GPIO_Function(15, NGPIO_Function::Alt_5);

    mOpened = true;

    // nastavime vychozi rychlost a velikost znaku
    Set_Char_Length(NUART_Char_Length::Char_8);
    Set_Baud_Rate(NUART_Baud_Rate::BR_9600);

    return true;
}

void CUART::Close()
{
    if (!mOpened)
        return;

    // zakazeme AUX periferii
    mAUX.Disable(hal::AUX_Peripherals::MiniUART);

    // piny 14 a 15 prepneme na Input (tak zerou nejmin proudu)
    sGPIO.Set_GPIO_Function(14, NGPIO_Function::Input);
    sGPIO.Set_GPIO_Function(15, NGPIO_Function::Input);

    // uvolnime piny
    sGPIO.Free_Pin(14, true, true);
    sGPIO.Free_Pin(15, true, true);

    mOpened = false;
}

bool CUART::Is_Opened() const
{
    return mOpened;
}

NUART_Char_Length CUART::Get_Char_Length()
{
    if (!mOpened)
        return NUART_Char_Length::Char_8;

    return static_cast<NUART_Char_Length>(mAUX.Get_Register(hal::AUX_Reg::MU_LCR) & 0x1);
}

void CUART::Set_Char_Length(NUART_Char_Length len)
{
    if (!mOpened)
        return;

    mAUX.Set_Register(hal::AUX_Reg::MU_LCR, (mAUX.Get_Register(hal::AUX_Reg::MU_LCR) & 0xFFFFFFFE) | static_cast<unsigned int>(len));
}

NUART_Baud_Rate CUART::Get_Baud_Rate()
{
    if (!mOpened)
        return NUART_Baud_Rate::BR_1200;

    return mBaud_Rate;
}

void CUART::Set_Baud_Rate(NUART_Baud_Rate rate)
{
    if (!mOpened)
        return;

    mBaud_Rate = rate;

    const unsigned int val = ((hal::Default_Clock_Rate / static_cast<unsigned int>(rate)) / 8) - 1;

    mAUX.Set_Register(hal::AUX_Reg::MU_CNTL, 0);

    mAUX.Set_Register(hal::AUX_Reg::MU_BAUD, val);

    mAUX.Set_Register(hal::AUX_Reg::MU_CNTL, 3);
}

void CUART::Write(char c)
{
    if (!mOpened)
        return;

    // dokud ma status registr priznak "vystupni fronta plna", nelze prenaset dalsi bit
    while (!(mAUX.Get_Register(hal::AUX_Reg::MU_LSR) & (1 << 5)))
        ;

    mAUX.Set_Register(hal::AUX_Reg::MU_IO, c);
}

void CUART::Write(const char* str)
{
    if (!mOpened)
        return;

    int i;

    for (i = 0; str[i] != '\0'; i++)
        Write(str[i]);
}

void CUART::Write(const char* str, unsigned int len)
{
    if (!mOpened)
        return;

    unsigned int i;

    for (i = 0; i < len; i++)
        Write(str[i]);
}

void CUART::Write(unsigned int num)
{
    if (!mOpened)
        return;

    static char buf[16];

    itoa(num, buf, 10);
    Write(buf);
}

void CUART::Write_Hex(unsigned int num)
{
    if (!mOpened)
        return;

    static char buf[16];

    itoa(num, buf, 16);
    Write(buf);
}

char CUART::Read()
{
    // if there is something to read
    if (mAUX.Get_Register(hal::AUX_Reg::MU_LSR) & 0x01)
    {
        return mAUX.Get_Register(hal::AUX_Reg::MU_IO);
    }

    return -1; // there is nothing to read
}

void CUART::Enable_RX_Interrupt()
{
    // AUX and UART interrupts must be enabled
    sInterruptCtl.Enable_IRQ(hal::IRQ_Source::AUX);
    sInterruptCtl.Enable_IRQ(hal::IRQ_Source::UART);

    // bit 0 is RX interrupt (!see errata, doc is wrong!)
    mAUX.Set_Register(hal::AUX_Reg::MU_IER, 0x01);
}

void CUART::Disable_RX_Interrupt()
{
    mAUX.Set_Register(hal::AUX_Reg::MU_IER, 0x00);
}

void CUART::IRQ_Callback()
{
    TWaiting_File* wf, *tmpwf;

    // loading to Circular_Buffer
    char c;
    char stop = -1; // for some reason not using this variable doesn't work TODO: try to make it work
    uint8_t rv = 0;
    while (((c = Read()) != stop) && rv == 0) {
        rv = sUART0_Buffer.add(c);
        // write read char, so the user see what input they wrote (qemu otherwise doesn't print pressed keys)
        sUART0.Write(c);
    }

    spinlock_lock(&mLock);

    // from gpio.cpp - slightly altered (notifying all processes)
    // zkusime najit proces, ktery na udalost na tomto pinu ceka
    wf = mWaiting_Files;
    while (wf != nullptr)
    {
        // probudime proces
        wf->file->Notify(NotifyAll);

        // prelinkujeme spojovy seznam atd.

        if (wf->prev)
            wf->prev->next = wf->next;
        if (wf->next)
            wf->next->prev = wf->prev;

        tmpwf = wf;

        if (mWaiting_Files == wf)
            mWaiting_Files = wf->next;

        wf = wf->next;

        delete tmpwf;
    }

    spinlock_unlock(&mLock);

    // clear IRQ
    uint32_t iir = mAUX.Get_Register(hal::AUX_Reg::MU_IIR);
    // iir ^= 0x01 << 0; // zero last bit = reset irq
    iir ^= 0x01; // saving the shift by 0, as we dont need it for LSB (compiler most likely optimizes this)
    mAUX.Set_Register(hal::AUX_Reg::MU_IIR, iir);

    asm volatile("swi 7");
}

bool CUART::Is_UART_IRQ_Pending()
{
    // doc specify, that bit 0 is LOW when interrupt is pending
    return !(mAUX.Get_Register(hal::AUX_Reg::MU_IIR) & 0x01);
}

void CUART::Wait_For_Event(IFile* file)
{
    spinlock_lock(&mLock);

	TWaiting_File* wf = new TWaiting_File;
	wf->file = file;
	wf->prev = nullptr;
	wf->next = mWaiting_Files;

	mWaiting_Files = wf;

	spinlock_unlock(&mLock);
}