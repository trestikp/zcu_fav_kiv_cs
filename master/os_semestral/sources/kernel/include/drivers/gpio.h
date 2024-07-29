#pragma once

#include <hal/intdef.h>
#include <hal/peripherals.h>
#include <fs/filesystem.h>
#include <process/spinlock.h>

constexpr uint32_t Invalid_Pin = static_cast<uint32_t>(-1);

// funkce GPIO pinu
enum class NGPIO_Function : unsigned int
{
	Input	= 0b000, // 000 - vstupni pin
	Output	= 0b001, // 001 - vystupni pin
	Alt_5	= 0b010, // 010 - alternativni funkce 5
	Alt_4	= 0b011, // 011 - alternativni funkce 4
	Alt_0	= 0b100, // 100 - alternativni funkce 0
	Alt_1	= 0b101, // 101 - alternativni funkce 1
	Alt_2	= 0b110, // 110 - alternativni funkce 2
	Alt_3	= 0b111, // 111 - alternativni funkce 3
	
	// pro alternativni funkce viz dokumentace desky/SoC
	// alternativni funkce mohou byt napr. UART, SPI, I2C, atd. (kde treba existuje HW podpora)
	
	Unspecified = 0b1000, // 1000 - deska takove nezna, je to jen pro nas
};

// zdroj preruseni
enum class NGPIO_Interrupt_Type
{
	Rising_Edge,	// vzestupna hrana signalu
	Falling_Edge,	// sestupna hrana signalu
	High,			// vysoka uroven napeti
	Low,			// nizka uroven napeti
};

/*
 * Trida obstaravajici komunikaci s GPIO piny
 */
class CGPIO_Handler
{
	private:
		// bazova adresa memory-mapped IO, inicializuje konstruktor
		volatile unsigned int* const mGPIO;

		// rezervace pinu pro cteni
		uint32_t mPin_Reservations_Read[1 + (hal::GPIO_Pin_Count / 32)];
		// rezervace pinu pro zapis
		uint32_t mPin_Reservations_Write[1 + (hal::GPIO_Pin_Count / 32)];

		struct TWaiting_File
		{
			IFile* file;
			uint32_t pin_idx;
			TWaiting_File* prev;
			TWaiting_File* next;
		};

		TWaiting_File* mWaiting_Files;

		spinlock_t mLock;
		
	protected:
		// vybira GPFSEL registr a pozici bitu pro dany pin
		bool Get_GPFSEL_Location(uint32_t pin, uint32_t& reg, uint32_t& bit_idx) const;
		// vybira GPCLR registr a pozici bitu pro dany pin
		bool Get_GPCLR_Location(uint32_t pin, uint32_t& reg, uint32_t& bit_idx) const;
		// vybira GPSET registr a pozici bitu pro dany pin
		bool Get_GPSET_Location(uint32_t pin, uint32_t& reg, uint32_t& bit_idx) const;
		// vybira GPLEV registr a pozici bitu pro dany pin
		bool Get_GPLEV_Location(uint32_t pin, uint32_t& reg, uint32_t& bit_idx) const;
		// vybira GPEDS registr a pozici bitu pro dany pin
		bool Get_GPEDS_Location(uint32_t pin, uint32_t& reg, uint32_t& bit_idx) const;
		// vybira registr pro nastaveni/vymazani priznaku pro vyvolani preruseni
		bool Get_GP_IRQ_Detect_Location(uint32_t pin, NGPIO_Interrupt_Type type, uint32_t& reg, uint32_t& bit_idx) const;

		// vraci pin, na kterem byla detekovana udalost - nic nemaze, vnejsi kod musi volat Clear. Pokud uz neni zadny
		// pin s detekovanou udalosti, vraci hodnotu Invalid_Pin
		uint32_t Get_Detected_Event_Pin() const;
		// vymaze priznak z event detect registru pro dany pin
		void Clear_Detected_Event(uint32_t pin);
	
	public:
		CGPIO_Handler(unsigned int gpio_base_addr);
		
		// nastavi funkci GPIO pinu
		void Set_GPIO_Function(uint32_t pin, NGPIO_Function func);
		// vraci, jakou funkci ma dany GPIO pin
		NGPIO_Function Get_GPIO_Function(uint32_t pin) const;
		
		// nastavi vystupni uroven GPIO pinu
		void Set_Output(uint32_t pin, bool set);

		// zjisti hodnotu na vstupu GPIO
		bool Get_Input(uint32_t pin);

		// rezervuje pin pro exkluzivni vyuziti
		bool Reserve_Pin(uint32_t pin, bool read, bool write);
		// zrusi rezervaci na pin
		bool Free_Pin(uint32_t pin, bool read, bool write);

		// povoli detekci udalosti na danem pinu - nekontroluje, zda je pin v nejakem stavu (napr. zda je vstupni)
		void Enable_Event_Detect(uint32_t pin, NGPIO_Interrupt_Type type);
		// zakaze detekci udalosti na danem pinu - nekontroluje, zda je pin v nejakem stavu (napr. zda je vstupni)
		void Disable_Event_Detect(uint32_t pin, NGPIO_Interrupt_Type type);

		// handluje IRQ (pokud vubec k nejakemu doslo)
		void Handle_IRQ();

		// pocka na udalost (zablokuje proces)
		void Wait_For_Event(IFile* file, uint32_t pin);
};

// globalni instance pro hlavni GPIO port
extern CGPIO_Handler sGPIO;
