#include <drivers/gpio.h>
#include <drivers/uart.h>
#include <drivers/bcm_aux.h>

CUART sUART0(sAUX);

CUART::CUART(CAUX& aux)
    : mAUX(aux)
{
    mAUX.Enable(hal::AUX_Peripherals::MiniUART);
    //mAUX.Set_Register(hal::AUX_Reg::ENABLES, mAUX.Get_Register(hal::AUX_Reg::ENABLES) | 0x01);
    mAUX.Set_Register(hal::AUX_Reg::MU_IIR, 0);
    mAUX.Set_Register(hal::AUX_Reg::MU_IER, 0);
    mAUX.Set_Register(hal::AUX_Reg::MU_MCR, 0);
    mAUX.Set_Register(hal::AUX_Reg::MU_CNTL, 3); // RX and TX enabled
}

void CUART::Set_Char_Length(NUART_Char_Length len)
{
    mAUX.Set_Register(hal::AUX_Reg::MU_LCR, (mAUX.Get_Register(hal::AUX_Reg::MU_LCR) & 0xFFFFFFFE) | static_cast<unsigned int>(len));
}

void CUART::Set_Baud_Rate(NUART_Baud_Rate rate)
{
    constexpr unsigned int Clock_Rate = 250000000; // taktovaci frekvence hlavniho jadra
    const unsigned int val = ((Clock_Rate / static_cast<unsigned int>(rate)) / 8) - 1;

    mAUX.Set_Register(hal::AUX_Reg::MU_CNTL, 0);

    mAUX.Set_Register(hal::AUX_Reg::MU_BAUD, val);

    mAUX.Set_Register(hal::AUX_Reg::MU_CNTL, 3);
}

void CUART::Write(char c)
{
    // dokud ma status registr priznak "vystupni fronta plna", nelze prenaset dalsi bit
    while (!(mAUX.Get_Register(hal::AUX_Reg::MU_LSR) & (1 << 5)))
        ;

    mAUX.Set_Register(hal::AUX_Reg::MU_IO, c);
}

void CUART::Write(const char* str)
{
    int i;

    for (i = 0; str[i] != '\0'; i++)
        Write(str[i]);
}

void CUART::Start() {
    // enable mini UART on AUX coprocessor
    mAUX.Enable(hal::AUX_Peripherals::MiniUART);
    
    // UART1 is on pins 14 and 15, alternative 5
    sGPIO.Set_GPIO_Function(14, NGPIO_Function::Alt_5);
    sGPIO.Set_GPIO_Function(15, NGPIO_Function::Alt_5);

    // setting UART parameters
    mAUX.Set_Register(hal::AUX_Reg::MU_IIR, 0);
    mAUX.Set_Register(hal::AUX_Reg::MU_IER, 0);
    mAUX.Set_Register(hal::AUX_Reg::MU_MCR, 0);
    mAUX.Set_Register(hal::AUX_Reg::MU_CNTL, 3); // RX and TX enabled
    sUART0.Set_Baud_Rate(NUART_Baud_Rate::BR_115200);
	sUART0.Set_Char_Length(NUART_Char_Length::Char_8);
    // nastavit parametery uart
    // data lenth - LCR, modulacni rychlost - spocitat podle vzorecku (asi Vmod = f / (8 * B + 1), kde B je velikost registru (asi IO?))
    // transmitter enable CTL
    // reciever enable
}

void CUART::Stop() {
    mAUX.Disable(hal::AUX_Peripherals::MiniUART);
}

// impl. write_string(const char *str) -- pozor, nemame std knihovny - tedy zadny strlen ani prevody
char CUART::Read() {
    while (!(mAUX.Get_Register(hal::AUX_Reg::MU_LSR) & 0x01))
        ;

    uint32_t c = mAUX.Get_Register(hal::AUX_Reg::MU_IO);
    return (char) c; // this should take LS 8 bits (only LS 8 bits carry value)
}