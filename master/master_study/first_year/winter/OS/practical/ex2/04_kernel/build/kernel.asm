
./kernel:     file format elf32-littlearm


Disassembly of section .text:

00008000 <_start>:
_start():
/home/cf/ZCU/OS/practical/ex2/04_kernel/kernel/src/start.s:8
;@ tady budou symboly, ktere chceme na zacatek kodove sekce
.section .text.start

;@ vstupni bod do kernelu - nechame ho vlozit na zacatek kodu
_start:
    mov sp,#0x8000			;@ nastavime stack pointer na spodek zasobniku
    8000:	e3a0d902 	mov	sp, #32768	; 0x8000
/home/cf/ZCU/OS/practical/ex2/04_kernel/kernel/src/start.s:9
	bl _c_startup			;@ C startup kod (inicializace prostredi)
    8004:	eb000242 	bl	8914 <_c_startup>
/home/cf/ZCU/OS/practical/ex2/04_kernel/kernel/src/start.s:10
	bl _cpp_startup			;@ C++ startup kod (volani globalnich konstruktoru, ...)
    8008:	eb00025b 	bl	897c <_cpp_startup>
/home/cf/ZCU/OS/practical/ex2/04_kernel/kernel/src/start.s:11
    bl _kernel_main			;@ skocime do hlavniho kodu jadra (v C)
    800c:	eb00020a 	bl	883c <_kernel_main>
/home/cf/ZCU/OS/practical/ex2/04_kernel/kernel/src/start.s:12
	bl _cpp_shutdown		;@ C++ shutdown kod (volani globalnich destruktoru, ...)
    8010:	eb00026f 	bl	89d4 <_cpp_shutdown>

00008014 <hang>:
hang():
/home/cf/ZCU/OS/practical/ex2/04_kernel/kernel/src/start.s:14
hang:
    b hang
    8014:	eafffffe 	b	8014 <hang>

00008018 <__cxa_guard_acquire>:
__cxa_guard_acquire():
/home/cf/ZCU/OS/practical/ex2/04_kernel/kernel/src/cxx.cpp:11
	extern "C" int __cxa_guard_acquire (__guard *);
	extern "C" void __cxa_guard_release (__guard *);
	extern "C" void __cxa_guard_abort (__guard *);

	extern "C" int __cxa_guard_acquire (__guard *g)
	{
    8018:	e52db004 	push	{fp}		; (str fp, [sp, #-4]!)
    801c:	e28db000 	add	fp, sp, #0
    8020:	e24dd00c 	sub	sp, sp, #12
    8024:	e50b0008 	str	r0, [fp, #-8]
/home/cf/ZCU/OS/practical/ex2/04_kernel/kernel/src/cxx.cpp:12
		return !*(char *)(g);
    8028:	e51b3008 	ldr	r3, [fp, #-8]
    802c:	e5d33000 	ldrb	r3, [r3]
    8030:	e3530000 	cmp	r3, #0
    8034:	03a03001 	moveq	r3, #1
    8038:	13a03000 	movne	r3, #0
    803c:	e6ef3073 	uxtb	r3, r3
/home/cf/ZCU/OS/practical/ex2/04_kernel/kernel/src/cxx.cpp:13
	}
    8040:	e1a00003 	mov	r0, r3
    8044:	e28bd000 	add	sp, fp, #0
    8048:	e49db004 	pop	{fp}		; (ldr fp, [sp], #4)
    804c:	e12fff1e 	bx	lr

00008050 <__cxa_guard_release>:
__cxa_guard_release():
/home/cf/ZCU/OS/practical/ex2/04_kernel/kernel/src/cxx.cpp:16

	extern "C" void __cxa_guard_release (__guard *g)
	{
    8050:	e52db004 	push	{fp}		; (str fp, [sp, #-4]!)
    8054:	e28db000 	add	fp, sp, #0
    8058:	e24dd00c 	sub	sp, sp, #12
    805c:	e50b0008 	str	r0, [fp, #-8]
/home/cf/ZCU/OS/practical/ex2/04_kernel/kernel/src/cxx.cpp:17
		*(char *)g = 1;
    8060:	e51b3008 	ldr	r3, [fp, #-8]
    8064:	e3a02001 	mov	r2, #1
    8068:	e5c32000 	strb	r2, [r3]
/home/cf/ZCU/OS/practical/ex2/04_kernel/kernel/src/cxx.cpp:18
	}
    806c:	e320f000 	nop	{0}
    8070:	e28bd000 	add	sp, fp, #0
    8074:	e49db004 	pop	{fp}		; (ldr fp, [sp], #4)
    8078:	e12fff1e 	bx	lr

0000807c <__cxa_guard_abort>:
__cxa_guard_abort():
/home/cf/ZCU/OS/practical/ex2/04_kernel/kernel/src/cxx.cpp:21

	extern "C" void __cxa_guard_abort (__guard *)
	{
    807c:	e52db004 	push	{fp}		; (str fp, [sp, #-4]!)
    8080:	e28db000 	add	fp, sp, #0
    8084:	e24dd00c 	sub	sp, sp, #12
    8088:	e50b0008 	str	r0, [fp, #-8]
/home/cf/ZCU/OS/practical/ex2/04_kernel/kernel/src/cxx.cpp:23

	}
    808c:	e320f000 	nop	{0}
    8090:	e28bd000 	add	sp, fp, #0
    8094:	e49db004 	pop	{fp}		; (ldr fp, [sp], #4)
    8098:	e12fff1e 	bx	lr

0000809c <__dso_handle>:
__dso_handle():
/home/cf/ZCU/OS/practical/ex2/04_kernel/kernel/src/cxx.cpp:27
}

extern "C" void __dso_handle()
{
    809c:	e52db004 	push	{fp}		; (str fp, [sp, #-4]!)
    80a0:	e28db000 	add	fp, sp, #0
/home/cf/ZCU/OS/practical/ex2/04_kernel/kernel/src/cxx.cpp:29
    // ignore dtors for now
}
    80a4:	e320f000 	nop	{0}
    80a8:	e28bd000 	add	sp, fp, #0
    80ac:	e49db004 	pop	{fp}		; (ldr fp, [sp], #4)
    80b0:	e12fff1e 	bx	lr

000080b4 <__cxa_atexit>:
__cxa_atexit():
/home/cf/ZCU/OS/practical/ex2/04_kernel/kernel/src/cxx.cpp:32

extern "C" void __cxa_atexit()
{
    80b4:	e52db004 	push	{fp}		; (str fp, [sp, #-4]!)
    80b8:	e28db000 	add	fp, sp, #0
/home/cf/ZCU/OS/practical/ex2/04_kernel/kernel/src/cxx.cpp:34
    // ignore dtors for now
}
    80bc:	e320f000 	nop	{0}
    80c0:	e28bd000 	add	sp, fp, #0
    80c4:	e49db004 	pop	{fp}		; (ldr fp, [sp], #4)
    80c8:	e12fff1e 	bx	lr

000080cc <__cxa_pure_virtual>:
__cxa_pure_virtual():
/home/cf/ZCU/OS/practical/ex2/04_kernel/kernel/src/cxx.cpp:37

extern "C" void __cxa_pure_virtual()
{
    80cc:	e52db004 	push	{fp}		; (str fp, [sp, #-4]!)
    80d0:	e28db000 	add	fp, sp, #0
/home/cf/ZCU/OS/practical/ex2/04_kernel/kernel/src/cxx.cpp:39
    // pure virtual method called
}
    80d4:	e320f000 	nop	{0}
    80d8:	e28bd000 	add	sp, fp, #0
    80dc:	e49db004 	pop	{fp}		; (ldr fp, [sp], #4)
    80e0:	e12fff1e 	bx	lr

000080e4 <__aeabi_unwind_cpp_pr1>:
__aeabi_unwind_cpp_pr1():
/home/cf/ZCU/OS/practical/ex2/04_kernel/kernel/src/cxx.cpp:42

extern "C" void __aeabi_unwind_cpp_pr1()
{
    80e4:	e52db004 	push	{fp}		; (str fp, [sp, #-4]!)
    80e8:	e28db000 	add	fp, sp, #0
/home/cf/ZCU/OS/practical/ex2/04_kernel/kernel/src/cxx.cpp:43 (discriminator 1)
	while (true)
    80ec:	eafffffe 	b	80ec <__aeabi_unwind_cpp_pr1+0x8>

000080f0 <_ZN13CGPIO_HandlerC1Ej>:
_ZN13CGPIO_HandlerC2Ej():
/home/cf/ZCU/OS/practical/ex2/04_kernel/kernel/src/drivers/gpio.cpp:6
#include <hal/peripherals.h>
#include <drivers/gpio.h>

CGPIO_Handler sGPIO(hal::GPIO_Base);

CGPIO_Handler::CGPIO_Handler(unsigned int gpio_base_addr)
    80f0:	e52db004 	push	{fp}		; (str fp, [sp, #-4]!)
    80f4:	e28db000 	add	fp, sp, #0
    80f8:	e24dd00c 	sub	sp, sp, #12
    80fc:	e50b0008 	str	r0, [fp, #-8]
    8100:	e50b100c 	str	r1, [fp, #-12]
/home/cf/ZCU/OS/practical/ex2/04_kernel/kernel/src/drivers/gpio.cpp:7
	: mGPIO(reinterpret_cast<unsigned int*>(gpio_base_addr))
    8104:	e51b200c 	ldr	r2, [fp, #-12]
    8108:	e51b3008 	ldr	r3, [fp, #-8]
    810c:	e5832000 	str	r2, [r3]
/home/cf/ZCU/OS/practical/ex2/04_kernel/kernel/src/drivers/gpio.cpp:10
{
	//
}
    8110:	e51b3008 	ldr	r3, [fp, #-8]
    8114:	e1a00003 	mov	r0, r3
    8118:	e28bd000 	add	sp, fp, #0
    811c:	e49db004 	pop	{fp}		; (ldr fp, [sp], #4)
    8120:	e12fff1e 	bx	lr

00008124 <_ZNK13CGPIO_Handler19Get_GPFSEL_LocationEjRjS0_>:
_ZNK13CGPIO_Handler19Get_GPFSEL_LocationEjRjS0_():
/home/cf/ZCU/OS/practical/ex2/04_kernel/kernel/src/drivers/gpio.cpp:13

bool CGPIO_Handler::Get_GPFSEL_Location(uint32_t pin, uint32_t& reg, uint32_t& bit_idx) const
{
    8124:	e52db004 	push	{fp}		; (str fp, [sp, #-4]!)
    8128:	e28db000 	add	fp, sp, #0
    812c:	e24dd014 	sub	sp, sp, #20
    8130:	e50b0008 	str	r0, [fp, #-8]
    8134:	e50b100c 	str	r1, [fp, #-12]
    8138:	e50b2010 	str	r2, [fp, #-16]
    813c:	e50b3014 	str	r3, [fp, #-20]	; 0xffffffec
/home/cf/ZCU/OS/practical/ex2/04_kernel/kernel/src/drivers/gpio.cpp:14
	if (pin > hal::GPIO_Pin_Count)
    8140:	e51b300c 	ldr	r3, [fp, #-12]
    8144:	e3530036 	cmp	r3, #54	; 0x36
    8148:	9a000001 	bls	8154 <_ZNK13CGPIO_Handler19Get_GPFSEL_LocationEjRjS0_+0x30>
/home/cf/ZCU/OS/practical/ex2/04_kernel/kernel/src/drivers/gpio.cpp:15
		return false;
    814c:	e3a03000 	mov	r3, #0
    8150:	ea000033 	b	8224 <_ZNK13CGPIO_Handler19Get_GPFSEL_LocationEjRjS0_+0x100>
/home/cf/ZCU/OS/practical/ex2/04_kernel/kernel/src/drivers/gpio.cpp:17
	
	switch (pin / 10)
    8154:	e51b300c 	ldr	r3, [fp, #-12]
    8158:	e59f20d4 	ldr	r2, [pc, #212]	; 8234 <_ZNK13CGPIO_Handler19Get_GPFSEL_LocationEjRjS0_+0x110>
    815c:	e0832392 	umull	r2, r3, r2, r3
    8160:	e1a031a3 	lsr	r3, r3, #3
    8164:	e3530005 	cmp	r3, #5
    8168:	979ff103 	ldrls	pc, [pc, r3, lsl #2]
    816c:	ea00001d 	b	81e8 <_ZNK13CGPIO_Handler19Get_GPFSEL_LocationEjRjS0_+0xc4>
    8170:	00008188 	andeq	r8, r0, r8, lsl #3
    8174:	00008198 	muleq	r0, r8, r1
    8178:	000081a8 	andeq	r8, r0, r8, lsr #3
    817c:	000081b8 			; <UNDEFINED> instruction: 0x000081b8
    8180:	000081c8 	andeq	r8, r0, r8, asr #3
    8184:	000081d8 	ldrdeq	r8, [r0], -r8	; <UNPREDICTABLE>
/home/cf/ZCU/OS/practical/ex2/04_kernel/kernel/src/drivers/gpio.cpp:19
	{
		case 0: reg = static_cast<uint32_t>(hal::GPIO_Reg::GPFSEL0); break;
    8188:	e51b3010 	ldr	r3, [fp, #-16]
    818c:	e3a02000 	mov	r2, #0
    8190:	e5832000 	str	r2, [r3]
    8194:	ea000013 	b	81e8 <_ZNK13CGPIO_Handler19Get_GPFSEL_LocationEjRjS0_+0xc4>
/home/cf/ZCU/OS/practical/ex2/04_kernel/kernel/src/drivers/gpio.cpp:20
		case 1: reg = static_cast<uint32_t>(hal::GPIO_Reg::GPFSEL1); break;
    8198:	e51b3010 	ldr	r3, [fp, #-16]
    819c:	e3a02001 	mov	r2, #1
    81a0:	e5832000 	str	r2, [r3]
    81a4:	ea00000f 	b	81e8 <_ZNK13CGPIO_Handler19Get_GPFSEL_LocationEjRjS0_+0xc4>
/home/cf/ZCU/OS/practical/ex2/04_kernel/kernel/src/drivers/gpio.cpp:21
		case 2: reg = static_cast<uint32_t>(hal::GPIO_Reg::GPFSEL2); break;
    81a8:	e51b3010 	ldr	r3, [fp, #-16]
    81ac:	e3a02002 	mov	r2, #2
    81b0:	e5832000 	str	r2, [r3]
    81b4:	ea00000b 	b	81e8 <_ZNK13CGPIO_Handler19Get_GPFSEL_LocationEjRjS0_+0xc4>
/home/cf/ZCU/OS/practical/ex2/04_kernel/kernel/src/drivers/gpio.cpp:22
		case 3: reg = static_cast<uint32_t>(hal::GPIO_Reg::GPFSEL3); break;
    81b8:	e51b3010 	ldr	r3, [fp, #-16]
    81bc:	e3a02003 	mov	r2, #3
    81c0:	e5832000 	str	r2, [r3]
    81c4:	ea000007 	b	81e8 <_ZNK13CGPIO_Handler19Get_GPFSEL_LocationEjRjS0_+0xc4>
/home/cf/ZCU/OS/practical/ex2/04_kernel/kernel/src/drivers/gpio.cpp:23
		case 4: reg = static_cast<uint32_t>(hal::GPIO_Reg::GPFSEL4); break;
    81c8:	e51b3010 	ldr	r3, [fp, #-16]
    81cc:	e3a02004 	mov	r2, #4
    81d0:	e5832000 	str	r2, [r3]
    81d4:	ea000003 	b	81e8 <_ZNK13CGPIO_Handler19Get_GPFSEL_LocationEjRjS0_+0xc4>
/home/cf/ZCU/OS/practical/ex2/04_kernel/kernel/src/drivers/gpio.cpp:24
		case 5: reg = static_cast<uint32_t>(hal::GPIO_Reg::GPFSEL5); break;
    81d8:	e51b3010 	ldr	r3, [fp, #-16]
    81dc:	e3a02005 	mov	r2, #5
    81e0:	e5832000 	str	r2, [r3]
    81e4:	e320f000 	nop	{0}
/home/cf/ZCU/OS/practical/ex2/04_kernel/kernel/src/drivers/gpio.cpp:27
	}
	
	bit_idx = (pin % 10) * 3;
    81e8:	e51b100c 	ldr	r1, [fp, #-12]
    81ec:	e59f3040 	ldr	r3, [pc, #64]	; 8234 <_ZNK13CGPIO_Handler19Get_GPFSEL_LocationEjRjS0_+0x110>
    81f0:	e0832193 	umull	r2, r3, r3, r1
    81f4:	e1a021a3 	lsr	r2, r3, #3
    81f8:	e1a03002 	mov	r3, r2
    81fc:	e1a03103 	lsl	r3, r3, #2
    8200:	e0833002 	add	r3, r3, r2
    8204:	e1a03083 	lsl	r3, r3, #1
    8208:	e0412003 	sub	r2, r1, r3
    820c:	e1a03002 	mov	r3, r2
    8210:	e1a03083 	lsl	r3, r3, #1
    8214:	e0832002 	add	r2, r3, r2
    8218:	e51b3014 	ldr	r3, [fp, #-20]	; 0xffffffec
    821c:	e5832000 	str	r2, [r3]
/home/cf/ZCU/OS/practical/ex2/04_kernel/kernel/src/drivers/gpio.cpp:29
	
	return true;
    8220:	e3a03001 	mov	r3, #1
/home/cf/ZCU/OS/practical/ex2/04_kernel/kernel/src/drivers/gpio.cpp:30
}
    8224:	e1a00003 	mov	r0, r3
    8228:	e28bd000 	add	sp, fp, #0
    822c:	e49db004 	pop	{fp}		; (ldr fp, [sp], #4)
    8230:	e12fff1e 	bx	lr
    8234:	cccccccd 	stclgt	12, cr12, [ip], {205}	; 0xcd

00008238 <_ZNK13CGPIO_Handler18Get_GPCLR_LocationEjRjS0_>:
_ZNK13CGPIO_Handler18Get_GPCLR_LocationEjRjS0_():
/home/cf/ZCU/OS/practical/ex2/04_kernel/kernel/src/drivers/gpio.cpp:33

bool CGPIO_Handler::Get_GPCLR_Location(uint32_t pin, uint32_t& reg, uint32_t& bit_idx) const
{
    8238:	e52db004 	push	{fp}		; (str fp, [sp, #-4]!)
    823c:	e28db000 	add	fp, sp, #0
    8240:	e24dd014 	sub	sp, sp, #20
    8244:	e50b0008 	str	r0, [fp, #-8]
    8248:	e50b100c 	str	r1, [fp, #-12]
    824c:	e50b2010 	str	r2, [fp, #-16]
    8250:	e50b3014 	str	r3, [fp, #-20]	; 0xffffffec
/home/cf/ZCU/OS/practical/ex2/04_kernel/kernel/src/drivers/gpio.cpp:34
	if (pin > hal::GPIO_Pin_Count)
    8254:	e51b300c 	ldr	r3, [fp, #-12]
    8258:	e3530036 	cmp	r3, #54	; 0x36
    825c:	9a000001 	bls	8268 <_ZNK13CGPIO_Handler18Get_GPCLR_LocationEjRjS0_+0x30>
/home/cf/ZCU/OS/practical/ex2/04_kernel/kernel/src/drivers/gpio.cpp:35
		return false;
    8260:	e3a03000 	mov	r3, #0
    8264:	ea00000c 	b	829c <_ZNK13CGPIO_Handler18Get_GPCLR_LocationEjRjS0_+0x64>
/home/cf/ZCU/OS/practical/ex2/04_kernel/kernel/src/drivers/gpio.cpp:37
	
	reg = static_cast<uint32_t>((pin < 32) ? hal::GPIO_Reg::GPCLR0 : hal::GPIO_Reg::GPCLR1);
    8268:	e51b300c 	ldr	r3, [fp, #-12]
    826c:	e353001f 	cmp	r3, #31
    8270:	8a000001 	bhi	827c <_ZNK13CGPIO_Handler18Get_GPCLR_LocationEjRjS0_+0x44>
/home/cf/ZCU/OS/practical/ex2/04_kernel/kernel/src/drivers/gpio.cpp:37 (discriminator 1)
    8274:	e3a0200a 	mov	r2, #10
    8278:	ea000000 	b	8280 <_ZNK13CGPIO_Handler18Get_GPCLR_LocationEjRjS0_+0x48>
/home/cf/ZCU/OS/practical/ex2/04_kernel/kernel/src/drivers/gpio.cpp:37 (discriminator 2)
    827c:	e3a0200b 	mov	r2, #11
/home/cf/ZCU/OS/practical/ex2/04_kernel/kernel/src/drivers/gpio.cpp:37 (discriminator 4)
    8280:	e51b3010 	ldr	r3, [fp, #-16]
    8284:	e5832000 	str	r2, [r3]
/home/cf/ZCU/OS/practical/ex2/04_kernel/kernel/src/drivers/gpio.cpp:38 (discriminator 4)
	bit_idx = pin % 32;
    8288:	e51b300c 	ldr	r3, [fp, #-12]
    828c:	e203201f 	and	r2, r3, #31
    8290:	e51b3014 	ldr	r3, [fp, #-20]	; 0xffffffec
    8294:	e5832000 	str	r2, [r3]
/home/cf/ZCU/OS/practical/ex2/04_kernel/kernel/src/drivers/gpio.cpp:40 (discriminator 4)
	
	return true;
    8298:	e3a03001 	mov	r3, #1
/home/cf/ZCU/OS/practical/ex2/04_kernel/kernel/src/drivers/gpio.cpp:41
}
    829c:	e1a00003 	mov	r0, r3
    82a0:	e28bd000 	add	sp, fp, #0
    82a4:	e49db004 	pop	{fp}		; (ldr fp, [sp], #4)
    82a8:	e12fff1e 	bx	lr

000082ac <_ZNK13CGPIO_Handler18Get_GPSET_LocationEjRjS0_>:
_ZNK13CGPIO_Handler18Get_GPSET_LocationEjRjS0_():
/home/cf/ZCU/OS/practical/ex2/04_kernel/kernel/src/drivers/gpio.cpp:44

bool CGPIO_Handler::Get_GPSET_Location(uint32_t pin, uint32_t& reg, uint32_t& bit_idx) const
{
    82ac:	e52db004 	push	{fp}		; (str fp, [sp, #-4]!)
    82b0:	e28db000 	add	fp, sp, #0
    82b4:	e24dd014 	sub	sp, sp, #20
    82b8:	e50b0008 	str	r0, [fp, #-8]
    82bc:	e50b100c 	str	r1, [fp, #-12]
    82c0:	e50b2010 	str	r2, [fp, #-16]
    82c4:	e50b3014 	str	r3, [fp, #-20]	; 0xffffffec
/home/cf/ZCU/OS/practical/ex2/04_kernel/kernel/src/drivers/gpio.cpp:45
	if (pin > hal::GPIO_Pin_Count)
    82c8:	e51b300c 	ldr	r3, [fp, #-12]
    82cc:	e3530036 	cmp	r3, #54	; 0x36
    82d0:	9a000001 	bls	82dc <_ZNK13CGPIO_Handler18Get_GPSET_LocationEjRjS0_+0x30>
/home/cf/ZCU/OS/practical/ex2/04_kernel/kernel/src/drivers/gpio.cpp:46
		return false;
    82d4:	e3a03000 	mov	r3, #0
    82d8:	ea00000c 	b	8310 <_ZNK13CGPIO_Handler18Get_GPSET_LocationEjRjS0_+0x64>
/home/cf/ZCU/OS/practical/ex2/04_kernel/kernel/src/drivers/gpio.cpp:48
	
	reg = static_cast<uint32_t>((pin < 32) ? hal::GPIO_Reg::GPSET0 : hal::GPIO_Reg::GPSET1);
    82dc:	e51b300c 	ldr	r3, [fp, #-12]
    82e0:	e353001f 	cmp	r3, #31
    82e4:	8a000001 	bhi	82f0 <_ZNK13CGPIO_Handler18Get_GPSET_LocationEjRjS0_+0x44>
/home/cf/ZCU/OS/practical/ex2/04_kernel/kernel/src/drivers/gpio.cpp:48 (discriminator 1)
    82e8:	e3a02007 	mov	r2, #7
    82ec:	ea000000 	b	82f4 <_ZNK13CGPIO_Handler18Get_GPSET_LocationEjRjS0_+0x48>
/home/cf/ZCU/OS/practical/ex2/04_kernel/kernel/src/drivers/gpio.cpp:48 (discriminator 2)
    82f0:	e3a02008 	mov	r2, #8
/home/cf/ZCU/OS/practical/ex2/04_kernel/kernel/src/drivers/gpio.cpp:48 (discriminator 4)
    82f4:	e51b3010 	ldr	r3, [fp, #-16]
    82f8:	e5832000 	str	r2, [r3]
/home/cf/ZCU/OS/practical/ex2/04_kernel/kernel/src/drivers/gpio.cpp:49 (discriminator 4)
	bit_idx = pin % 32;
    82fc:	e51b300c 	ldr	r3, [fp, #-12]
    8300:	e203201f 	and	r2, r3, #31
    8304:	e51b3014 	ldr	r3, [fp, #-20]	; 0xffffffec
    8308:	e5832000 	str	r2, [r3]
/home/cf/ZCU/OS/practical/ex2/04_kernel/kernel/src/drivers/gpio.cpp:51 (discriminator 4)
	
	return true;
    830c:	e3a03001 	mov	r3, #1
/home/cf/ZCU/OS/practical/ex2/04_kernel/kernel/src/drivers/gpio.cpp:52
}
    8310:	e1a00003 	mov	r0, r3
    8314:	e28bd000 	add	sp, fp, #0
    8318:	e49db004 	pop	{fp}		; (ldr fp, [sp], #4)
    831c:	e12fff1e 	bx	lr

00008320 <_ZNK13CGPIO_Handler18Get_GPLEV_LocationEjRjS0_>:
_ZNK13CGPIO_Handler18Get_GPLEV_LocationEjRjS0_():
/home/cf/ZCU/OS/practical/ex2/04_kernel/kernel/src/drivers/gpio.cpp:55

bool CGPIO_Handler::Get_GPLEV_Location(uint32_t pin, uint32_t& reg, uint32_t& bit_idx) const
{
    8320:	e52db004 	push	{fp}		; (str fp, [sp, #-4]!)
    8324:	e28db000 	add	fp, sp, #0
    8328:	e24dd014 	sub	sp, sp, #20
    832c:	e50b0008 	str	r0, [fp, #-8]
    8330:	e50b100c 	str	r1, [fp, #-12]
    8334:	e50b2010 	str	r2, [fp, #-16]
    8338:	e50b3014 	str	r3, [fp, #-20]	; 0xffffffec
/home/cf/ZCU/OS/practical/ex2/04_kernel/kernel/src/drivers/gpio.cpp:56
	if (pin > hal::GPIO_Pin_Count)
    833c:	e51b300c 	ldr	r3, [fp, #-12]
    8340:	e3530036 	cmp	r3, #54	; 0x36
    8344:	9a000001 	bls	8350 <_ZNK13CGPIO_Handler18Get_GPLEV_LocationEjRjS0_+0x30>
/home/cf/ZCU/OS/practical/ex2/04_kernel/kernel/src/drivers/gpio.cpp:57
		return false;
    8348:	e3a03000 	mov	r3, #0
    834c:	ea00000c 	b	8384 <_ZNK13CGPIO_Handler18Get_GPLEV_LocationEjRjS0_+0x64>
/home/cf/ZCU/OS/practical/ex2/04_kernel/kernel/src/drivers/gpio.cpp:59
	
	reg = static_cast<uint32_t>((pin < 32) ? hal::GPIO_Reg::GPLEV0 : hal::GPIO_Reg::GPLEV1);
    8350:	e51b300c 	ldr	r3, [fp, #-12]
    8354:	e353001f 	cmp	r3, #31
    8358:	8a000001 	bhi	8364 <_ZNK13CGPIO_Handler18Get_GPLEV_LocationEjRjS0_+0x44>
/home/cf/ZCU/OS/practical/ex2/04_kernel/kernel/src/drivers/gpio.cpp:59 (discriminator 1)
    835c:	e3a0200d 	mov	r2, #13
    8360:	ea000000 	b	8368 <_ZNK13CGPIO_Handler18Get_GPLEV_LocationEjRjS0_+0x48>
/home/cf/ZCU/OS/practical/ex2/04_kernel/kernel/src/drivers/gpio.cpp:59 (discriminator 2)
    8364:	e3a0200e 	mov	r2, #14
/home/cf/ZCU/OS/practical/ex2/04_kernel/kernel/src/drivers/gpio.cpp:59 (discriminator 4)
    8368:	e51b3010 	ldr	r3, [fp, #-16]
    836c:	e5832000 	str	r2, [r3]
/home/cf/ZCU/OS/practical/ex2/04_kernel/kernel/src/drivers/gpio.cpp:60 (discriminator 4)
	bit_idx = pin % 32;
    8370:	e51b300c 	ldr	r3, [fp, #-12]
    8374:	e203201f 	and	r2, r3, #31
    8378:	e51b3014 	ldr	r3, [fp, #-20]	; 0xffffffec
    837c:	e5832000 	str	r2, [r3]
/home/cf/ZCU/OS/practical/ex2/04_kernel/kernel/src/drivers/gpio.cpp:62 (discriminator 4)
	
	return true;
    8380:	e3a03001 	mov	r3, #1
/home/cf/ZCU/OS/practical/ex2/04_kernel/kernel/src/drivers/gpio.cpp:63
}
    8384:	e1a00003 	mov	r0, r3
    8388:	e28bd000 	add	sp, fp, #0
    838c:	e49db004 	pop	{fp}		; (ldr fp, [sp], #4)
    8390:	e12fff1e 	bx	lr

00008394 <_ZN13CGPIO_Handler17Set_GPIO_FunctionEj14NGPIO_Function>:
_ZN13CGPIO_Handler17Set_GPIO_FunctionEj14NGPIO_Function():
/home/cf/ZCU/OS/practical/ex2/04_kernel/kernel/src/drivers/gpio.cpp:66
		
void CGPIO_Handler::Set_GPIO_Function(uint32_t pin, NGPIO_Function func)
{
    8394:	e92d4800 	push	{fp, lr}
    8398:	e28db004 	add	fp, sp, #4
    839c:	e24dd018 	sub	sp, sp, #24
    83a0:	e50b0010 	str	r0, [fp, #-16]
    83a4:	e50b1014 	str	r1, [fp, #-20]	; 0xffffffec
    83a8:	e1a03002 	mov	r3, r2
    83ac:	e54b3015 	strb	r3, [fp, #-21]	; 0xffffffeb
/home/cf/ZCU/OS/practical/ex2/04_kernel/kernel/src/drivers/gpio.cpp:68
	uint32_t reg, bit;
	if (!Get_GPFSEL_Location(pin, reg, bit))
    83b0:	e24b300c 	sub	r3, fp, #12
    83b4:	e24b2008 	sub	r2, fp, #8
    83b8:	e51b1014 	ldr	r1, [fp, #-20]	; 0xffffffec
    83bc:	e51b0010 	ldr	r0, [fp, #-16]
    83c0:	ebffff57 	bl	8124 <_ZNK13CGPIO_Handler19Get_GPFSEL_LocationEjRjS0_>
    83c4:	e1a03000 	mov	r3, r0
    83c8:	e2233001 	eor	r3, r3, #1
    83cc:	e6ef3073 	uxtb	r3, r3
    83d0:	e3530000 	cmp	r3, #0
    83d4:	1a000015 	bne	8430 <_ZN13CGPIO_Handler17Set_GPIO_FunctionEj14NGPIO_Function+0x9c>
/home/cf/ZCU/OS/practical/ex2/04_kernel/kernel/src/drivers/gpio.cpp:71
		return;
	
	mGPIO[reg] = (mGPIO[reg] & (~static_cast<unsigned int>(7 << bit)) )
    83d8:	e51b3010 	ldr	r3, [fp, #-16]
    83dc:	e5932000 	ldr	r2, [r3]
    83e0:	e51b3008 	ldr	r3, [fp, #-8]
    83e4:	e1a03103 	lsl	r3, r3, #2
    83e8:	e0823003 	add	r3, r2, r3
    83ec:	e5932000 	ldr	r2, [r3]
    83f0:	e51b300c 	ldr	r3, [fp, #-12]
    83f4:	e3a01007 	mov	r1, #7
    83f8:	e1a03311 	lsl	r3, r1, r3
    83fc:	e1e03003 	mvn	r3, r3
    8400:	e0021003 	and	r1, r2, r3
/home/cf/ZCU/OS/practical/ex2/04_kernel/kernel/src/drivers/gpio.cpp:72
				| (static_cast<unsigned int>(func) << bit);
    8404:	e55b2015 	ldrb	r2, [fp, #-21]	; 0xffffffeb
    8408:	e51b300c 	ldr	r3, [fp, #-12]
    840c:	e1a02312 	lsl	r2, r2, r3
/home/cf/ZCU/OS/practical/ex2/04_kernel/kernel/src/drivers/gpio.cpp:71
	mGPIO[reg] = (mGPIO[reg] & (~static_cast<unsigned int>(7 << bit)) )
    8410:	e51b3010 	ldr	r3, [fp, #-16]
    8414:	e5930000 	ldr	r0, [r3]
    8418:	e51b3008 	ldr	r3, [fp, #-8]
    841c:	e1a03103 	lsl	r3, r3, #2
    8420:	e0803003 	add	r3, r0, r3
/home/cf/ZCU/OS/practical/ex2/04_kernel/kernel/src/drivers/gpio.cpp:72
				| (static_cast<unsigned int>(func) << bit);
    8424:	e1812002 	orr	r2, r1, r2
/home/cf/ZCU/OS/practical/ex2/04_kernel/kernel/src/drivers/gpio.cpp:71
	mGPIO[reg] = (mGPIO[reg] & (~static_cast<unsigned int>(7 << bit)) )
    8428:	e5832000 	str	r2, [r3]
    842c:	ea000000 	b	8434 <_ZN13CGPIO_Handler17Set_GPIO_FunctionEj14NGPIO_Function+0xa0>
/home/cf/ZCU/OS/practical/ex2/04_kernel/kernel/src/drivers/gpio.cpp:69
		return;
    8430:	e320f000 	nop	{0}
/home/cf/ZCU/OS/practical/ex2/04_kernel/kernel/src/drivers/gpio.cpp:73
}
    8434:	e24bd004 	sub	sp, fp, #4
    8438:	e8bd8800 	pop	{fp, pc}

0000843c <_ZNK13CGPIO_Handler17Get_GPIO_FunctionEj>:
_ZNK13CGPIO_Handler17Get_GPIO_FunctionEj():
/home/cf/ZCU/OS/practical/ex2/04_kernel/kernel/src/drivers/gpio.cpp:76

NGPIO_Function CGPIO_Handler::Get_GPIO_Function(uint32_t pin) const
{
    843c:	e92d4800 	push	{fp, lr}
    8440:	e28db004 	add	fp, sp, #4
    8444:	e24dd010 	sub	sp, sp, #16
    8448:	e50b0010 	str	r0, [fp, #-16]
    844c:	e50b1014 	str	r1, [fp, #-20]	; 0xffffffec
/home/cf/ZCU/OS/practical/ex2/04_kernel/kernel/src/drivers/gpio.cpp:78
	uint32_t reg, bit;
	if (!Get_GPFSEL_Location(pin, reg, bit))
    8450:	e24b300c 	sub	r3, fp, #12
    8454:	e24b2008 	sub	r2, fp, #8
    8458:	e51b1014 	ldr	r1, [fp, #-20]	; 0xffffffec
    845c:	e51b0010 	ldr	r0, [fp, #-16]
    8460:	ebffff2f 	bl	8124 <_ZNK13CGPIO_Handler19Get_GPFSEL_LocationEjRjS0_>
    8464:	e1a03000 	mov	r3, r0
    8468:	e2233001 	eor	r3, r3, #1
    846c:	e6ef3073 	uxtb	r3, r3
    8470:	e3530000 	cmp	r3, #0
    8474:	0a000001 	beq	8480 <_ZNK13CGPIO_Handler17Get_GPIO_FunctionEj+0x44>
/home/cf/ZCU/OS/practical/ex2/04_kernel/kernel/src/drivers/gpio.cpp:79
		return NGPIO_Function::Unspecified;
    8478:	e3a03008 	mov	r3, #8
    847c:	ea00000a 	b	84ac <_ZNK13CGPIO_Handler17Get_GPIO_FunctionEj+0x70>
/home/cf/ZCU/OS/practical/ex2/04_kernel/kernel/src/drivers/gpio.cpp:81
	
	return static_cast<NGPIO_Function>((mGPIO[reg] >> bit) & 7);
    8480:	e51b3010 	ldr	r3, [fp, #-16]
    8484:	e5932000 	ldr	r2, [r3]
    8488:	e51b3008 	ldr	r3, [fp, #-8]
    848c:	e1a03103 	lsl	r3, r3, #2
    8490:	e0823003 	add	r3, r2, r3
    8494:	e5932000 	ldr	r2, [r3]
    8498:	e51b300c 	ldr	r3, [fp, #-12]
    849c:	e1a03332 	lsr	r3, r2, r3
    84a0:	e6ef3073 	uxtb	r3, r3
    84a4:	e2033007 	and	r3, r3, #7
    84a8:	e6ef3073 	uxtb	r3, r3
/home/cf/ZCU/OS/practical/ex2/04_kernel/kernel/src/drivers/gpio.cpp:82 (discriminator 1)
}
    84ac:	e1a00003 	mov	r0, r3
    84b0:	e24bd004 	sub	sp, fp, #4
    84b4:	e8bd8800 	pop	{fp, pc}

000084b8 <_ZN13CGPIO_Handler10Set_OutputEjb>:
_ZN13CGPIO_Handler10Set_OutputEjb():
/home/cf/ZCU/OS/practical/ex2/04_kernel/kernel/src/drivers/gpio.cpp:85

void CGPIO_Handler::Set_Output(uint32_t pin, bool set)
{
    84b8:	e92d4800 	push	{fp, lr}
    84bc:	e28db004 	add	fp, sp, #4
    84c0:	e24dd018 	sub	sp, sp, #24
    84c4:	e50b0010 	str	r0, [fp, #-16]
    84c8:	e50b1014 	str	r1, [fp, #-20]	; 0xffffffec
    84cc:	e1a03002 	mov	r3, r2
    84d0:	e54b3015 	strb	r3, [fp, #-21]	; 0xffffffeb
/home/cf/ZCU/OS/practical/ex2/04_kernel/kernel/src/drivers/gpio.cpp:87
	uint32_t reg, bit;
	if (!(set && Get_GPSET_Location(pin, reg, bit)) && !(!set && Get_GPCLR_Location(pin, reg, bit)))
    84d4:	e55b3015 	ldrb	r3, [fp, #-21]	; 0xffffffeb
    84d8:	e2233001 	eor	r3, r3, #1
    84dc:	e6ef3073 	uxtb	r3, r3
    84e0:	e3530000 	cmp	r3, #0
    84e4:	1a000009 	bne	8510 <_ZN13CGPIO_Handler10Set_OutputEjb+0x58>
/home/cf/ZCU/OS/practical/ex2/04_kernel/kernel/src/drivers/gpio.cpp:87 (discriminator 2)
    84e8:	e24b300c 	sub	r3, fp, #12
    84ec:	e24b2008 	sub	r2, fp, #8
    84f0:	e51b1014 	ldr	r1, [fp, #-20]	; 0xffffffec
    84f4:	e51b0010 	ldr	r0, [fp, #-16]
    84f8:	ebffff6b 	bl	82ac <_ZNK13CGPIO_Handler18Get_GPSET_LocationEjRjS0_>
    84fc:	e1a03000 	mov	r3, r0
    8500:	e2233001 	eor	r3, r3, #1
    8504:	e6ef3073 	uxtb	r3, r3
    8508:	e3530000 	cmp	r3, #0
    850c:	0a00000e 	beq	854c <_ZN13CGPIO_Handler10Set_OutputEjb+0x94>
/home/cf/ZCU/OS/practical/ex2/04_kernel/kernel/src/drivers/gpio.cpp:87 (discriminator 3)
    8510:	e55b3015 	ldrb	r3, [fp, #-21]	; 0xffffffeb
    8514:	e3530000 	cmp	r3, #0
    8518:	1a000009 	bne	8544 <_ZN13CGPIO_Handler10Set_OutputEjb+0x8c>
/home/cf/ZCU/OS/practical/ex2/04_kernel/kernel/src/drivers/gpio.cpp:87 (discriminator 6)
    851c:	e24b300c 	sub	r3, fp, #12
    8520:	e24b2008 	sub	r2, fp, #8
    8524:	e51b1014 	ldr	r1, [fp, #-20]	; 0xffffffec
    8528:	e51b0010 	ldr	r0, [fp, #-16]
    852c:	ebffff41 	bl	8238 <_ZNK13CGPIO_Handler18Get_GPCLR_LocationEjRjS0_>
    8530:	e1a03000 	mov	r3, r0
    8534:	e2233001 	eor	r3, r3, #1
    8538:	e6ef3073 	uxtb	r3, r3
    853c:	e3530000 	cmp	r3, #0
    8540:	0a000001 	beq	854c <_ZN13CGPIO_Handler10Set_OutputEjb+0x94>
/home/cf/ZCU/OS/practical/ex2/04_kernel/kernel/src/drivers/gpio.cpp:87 (discriminator 7)
    8544:	e3a03001 	mov	r3, #1
    8548:	ea000000 	b	8550 <_ZN13CGPIO_Handler10Set_OutputEjb+0x98>
/home/cf/ZCU/OS/practical/ex2/04_kernel/kernel/src/drivers/gpio.cpp:87 (discriminator 8)
    854c:	e3a03000 	mov	r3, #0
/home/cf/ZCU/OS/practical/ex2/04_kernel/kernel/src/drivers/gpio.cpp:87 (discriminator 10)
    8550:	e3530000 	cmp	r3, #0
    8554:	1a00000a 	bne	8584 <_ZN13CGPIO_Handler10Set_OutputEjb+0xcc>
/home/cf/ZCU/OS/practical/ex2/04_kernel/kernel/src/drivers/gpio.cpp:90
		return;
	
	mGPIO[reg] = (1 << bit);
    8558:	e51b300c 	ldr	r3, [fp, #-12]
    855c:	e3a02001 	mov	r2, #1
    8560:	e1a01312 	lsl	r1, r2, r3
    8564:	e51b3010 	ldr	r3, [fp, #-16]
    8568:	e5932000 	ldr	r2, [r3]
    856c:	e51b3008 	ldr	r3, [fp, #-8]
    8570:	e1a03103 	lsl	r3, r3, #2
    8574:	e0823003 	add	r3, r2, r3
    8578:	e1a02001 	mov	r2, r1
    857c:	e5832000 	str	r2, [r3]
    8580:	ea000000 	b	8588 <_ZN13CGPIO_Handler10Set_OutputEjb+0xd0>
/home/cf/ZCU/OS/practical/ex2/04_kernel/kernel/src/drivers/gpio.cpp:88
		return;
    8584:	e320f000 	nop	{0}
/home/cf/ZCU/OS/practical/ex2/04_kernel/kernel/src/drivers/gpio.cpp:91
}
    8588:	e24bd004 	sub	sp, fp, #4
    858c:	e8bd8800 	pop	{fp, pc}

00008590 <_Z41__static_initialization_and_destruction_0ii>:
_Z41__static_initialization_and_destruction_0ii():
/home/cf/ZCU/OS/practical/ex2/04_kernel/kernel/src/drivers/gpio.cpp:91
    8590:	e92d4800 	push	{fp, lr}
    8594:	e28db004 	add	fp, sp, #4
    8598:	e24dd008 	sub	sp, sp, #8
    859c:	e50b0008 	str	r0, [fp, #-8]
    85a0:	e50b100c 	str	r1, [fp, #-12]
    85a4:	e51b3008 	ldr	r3, [fp, #-8]
    85a8:	e3530001 	cmp	r3, #1
    85ac:	1a000006 	bne	85cc <_Z41__static_initialization_and_destruction_0ii+0x3c>
/home/cf/ZCU/OS/practical/ex2/04_kernel/kernel/src/drivers/gpio.cpp:91 (discriminator 1)
    85b0:	e51b300c 	ldr	r3, [fp, #-12]
    85b4:	e59f201c 	ldr	r2, [pc, #28]	; 85d8 <_Z41__static_initialization_and_destruction_0ii+0x48>
    85b8:	e1530002 	cmp	r3, r2
    85bc:	1a000002 	bne	85cc <_Z41__static_initialization_and_destruction_0ii+0x3c>
/home/cf/ZCU/OS/practical/ex2/04_kernel/kernel/src/drivers/gpio.cpp:4
CGPIO_Handler sGPIO(hal::GPIO_Base);
    85c0:	e59f1014 	ldr	r1, [pc, #20]	; 85dc <_Z41__static_initialization_and_destruction_0ii+0x4c>
    85c4:	e59f0014 	ldr	r0, [pc, #20]	; 85e0 <_Z41__static_initialization_and_destruction_0ii+0x50>
    85c8:	ebfffec8 	bl	80f0 <_ZN13CGPIO_HandlerC1Ej>
/home/cf/ZCU/OS/practical/ex2/04_kernel/kernel/src/drivers/gpio.cpp:91
}
    85cc:	e320f000 	nop	{0}
    85d0:	e24bd004 	sub	sp, fp, #4
    85d4:	e8bd8800 	pop	{fp, pc}
    85d8:	0000ffff 	strdeq	pc, [r0], -pc	; <UNPREDICTABLE>
    85dc:	20200000 	eorcs	r0, r0, r0
    85e0:	00008cdc 	ldrdeq	r8, [r0], -ip

000085e4 <_GLOBAL__sub_I_sGPIO>:
_GLOBAL__sub_I_sGPIO():
/home/cf/ZCU/OS/practical/ex2/04_kernel/kernel/src/drivers/gpio.cpp:91
    85e4:	e92d4800 	push	{fp, lr}
    85e8:	e28db004 	add	fp, sp, #4
    85ec:	e59f1008 	ldr	r1, [pc, #8]	; 85fc <_GLOBAL__sub_I_sGPIO+0x18>
    85f0:	e3a00001 	mov	r0, #1
    85f4:	ebffffe5 	bl	8590 <_Z41__static_initialization_and_destruction_0ii>
    85f8:	e8bd8800 	pop	{fp, pc}
    85fc:	0000ffff 	strdeq	pc, [r0], -pc	; <UNPREDICTABLE>

00008600 <_ZN3LCGC1Ev>:
_ZN3LCGC2Ev():
/home/cf/ZCU/OS/practical/ex2/04_kernel/kernel/src/drivers/lcg.cpp:5
#include <drivers/lcg.h>

LCG lcgInstance;

LCG::LCG() {}; // does this need to be specified?
    8600:	e52db004 	push	{fp}		; (str fp, [sp, #-4]!)
    8604:	e28db000 	add	fp, sp, #0
    8608:	e24dd00c 	sub	sp, sp, #12
    860c:	e50b0008 	str	r0, [fp, #-8]
    8610:	e51b3008 	ldr	r3, [fp, #-8]
    8614:	e59f202c 	ldr	r2, [pc, #44]	; 8648 <_ZN3LCGC1Ev+0x48>
    8618:	e5832000 	str	r2, [r3]
    861c:	e51b3008 	ldr	r3, [fp, #-8]
    8620:	e59f2024 	ldr	r2, [pc, #36]	; 864c <_ZN3LCGC1Ev+0x4c>
    8624:	e5832004 	str	r2, [r3, #4]
    8628:	e51b3008 	ldr	r3, [fp, #-8]
    862c:	e59f201c 	ldr	r2, [pc, #28]	; 8650 <_ZN3LCGC1Ev+0x50>
    8630:	e5832008 	str	r2, [r3, #8]
    8634:	e51b3008 	ldr	r3, [fp, #-8]
    8638:	e1a00003 	mov	r0, r3
    863c:	e28bd000 	add	sp, fp, #0
    8640:	e49db004 	pop	{fp}		; (ldr fp, [sp], #4)
    8644:	e12fff1e 	bx	lr
    8648:	004ce3fd 	strdeq	lr, [ip], #-61	; 0xffffffc3
    864c:	01250dc5 	smlawteq	r5, r5, sp, r0
    8650:	498eda44 	stmibmi	lr, {r2, r6, r9, fp, ip, lr, pc}

00008654 <_ZN3LCGC1Ei>:
_ZN3LCGC2Ei():
/home/cf/ZCU/OS/practical/ex2/04_kernel/kernel/src/drivers/lcg.cpp:6
LCG::LCG(int p_seed) 
    8654:	e52db004 	push	{fp}		; (str fp, [sp, #-4]!)
    8658:	e28db000 	add	fp, sp, #0
    865c:	e24dd00c 	sub	sp, sp, #12
    8660:	e50b0008 	str	r0, [fp, #-8]
    8664:	e50b100c 	str	r1, [fp, #-12]
/home/cf/ZCU/OS/practical/ex2/04_kernel/kernel/src/drivers/lcg.cpp:7
    : seed(p_seed) {};
    8668:	e51b3008 	ldr	r3, [fp, #-8]
    866c:	e59f2038 	ldr	r2, [pc, #56]	; 86ac <_ZN3LCGC1Ei+0x58>
    8670:	e5832000 	str	r2, [r3]
    8674:	e51b3008 	ldr	r3, [fp, #-8]
    8678:	e59f2030 	ldr	r2, [pc, #48]	; 86b0 <_ZN3LCGC1Ei+0x5c>
    867c:	e5832004 	str	r2, [r3, #4]
    8680:	e51b3008 	ldr	r3, [fp, #-8]
    8684:	e59f2028 	ldr	r2, [pc, #40]	; 86b4 <_ZN3LCGC1Ei+0x60>
    8688:	e5832008 	str	r2, [r3, #8]
    868c:	e51b3008 	ldr	r3, [fp, #-8]
    8690:	e51b200c 	ldr	r2, [fp, #-12]
    8694:	e583200c 	str	r2, [r3, #12]
    8698:	e51b3008 	ldr	r3, [fp, #-8]
    869c:	e1a00003 	mov	r0, r3
    86a0:	e28bd000 	add	sp, fp, #0
    86a4:	e49db004 	pop	{fp}		; (ldr fp, [sp], #4)
    86a8:	e12fff1e 	bx	lr
    86ac:	004ce3fd 	strdeq	lr, [ip], #-61	; 0xffffffc3
    86b0:	01250dc5 	smlawteq	r5, r5, sp, r0
    86b4:	498eda44 	stmibmi	lr, {r2, r6, r9, fp, ip, lr, pc}

000086b8 <_ZN3LCG8set_seedEi>:
_ZN3LCG8set_seedEi():
/home/cf/ZCU/OS/practical/ex2/04_kernel/kernel/src/drivers/lcg.cpp:10


void LCG::set_seed(int p_seed) {
    86b8:	e52db004 	push	{fp}		; (str fp, [sp, #-4]!)
    86bc:	e28db000 	add	fp, sp, #0
    86c0:	e24dd00c 	sub	sp, sp, #12
    86c4:	e50b0008 	str	r0, [fp, #-8]
    86c8:	e50b100c 	str	r1, [fp, #-12]
/home/cf/ZCU/OS/practical/ex2/04_kernel/kernel/src/drivers/lcg.cpp:11
    seed = p_seed;
    86cc:	e51b3008 	ldr	r3, [fp, #-8]
    86d0:	e51b200c 	ldr	r2, [fp, #-12]
    86d4:	e583200c 	str	r2, [r3, #12]
/home/cf/ZCU/OS/practical/ex2/04_kernel/kernel/src/drivers/lcg.cpp:12
}
    86d8:	e320f000 	nop	{0}
    86dc:	e28bd000 	add	sp, fp, #0
    86e0:	e49db004 	pop	{fp}		; (ldr fp, [sp], #4)
    86e4:	e12fff1e 	bx	lr

000086e8 <_ZN3LCG8get_seedEv>:
_ZN3LCG8get_seedEv():
/home/cf/ZCU/OS/practical/ex2/04_kernel/kernel/src/drivers/lcg.cpp:14

int LCG::get_seed() {
    86e8:	e52db004 	push	{fp}		; (str fp, [sp, #-4]!)
    86ec:	e28db000 	add	fp, sp, #0
    86f0:	e24dd00c 	sub	sp, sp, #12
    86f4:	e50b0008 	str	r0, [fp, #-8]
/home/cf/ZCU/OS/practical/ex2/04_kernel/kernel/src/drivers/lcg.cpp:15
    return seed;
    86f8:	e51b3008 	ldr	r3, [fp, #-8]
    86fc:	e593300c 	ldr	r3, [r3, #12]
/home/cf/ZCU/OS/practical/ex2/04_kernel/kernel/src/drivers/lcg.cpp:16
}
    8700:	e1a00003 	mov	r0, r3
    8704:	e28bd000 	add	sp, fp, #0
    8708:	e49db004 	pop	{fp}		; (ldr fp, [sp], #4)
    870c:	e12fff1e 	bx	lr

00008710 <_ZN3LCG8get_nextEv>:
_ZN3LCG8get_nextEv():
/home/cf/ZCU/OS/practical/ex2/04_kernel/kernel/src/drivers/lcg.cpp:18

int LCG::get_next() {
    8710:	e92d4800 	push	{fp, lr}
    8714:	e28db004 	add	fp, sp, #4
    8718:	e24dd008 	sub	sp, sp, #8
    871c:	e50b0008 	str	r0, [fp, #-8]
/home/cf/ZCU/OS/practical/ex2/04_kernel/kernel/src/drivers/lcg.cpp:19
    seed = (a * seed + c) % mod;
    8720:	e51b3008 	ldr	r3, [fp, #-8]
    8724:	e5933000 	ldr	r3, [r3]
    8728:	e51b2008 	ldr	r2, [fp, #-8]
    872c:	e592200c 	ldr	r2, [r2, #12]
    8730:	e0020392 	mul	r2, r2, r3
    8734:	e51b3008 	ldr	r3, [fp, #-8]
    8738:	e5933004 	ldr	r3, [r3, #4]
    873c:	e0822003 	add	r2, r2, r3
    8740:	e51b3008 	ldr	r3, [fp, #-8]
    8744:	e5933008 	ldr	r3, [r3, #8]
    8748:	e1a01003 	mov	r1, r3
    874c:	e1a00002 	mov	r0, r2
    8750:	eb00013d 	bl	8c4c <__aeabi_idivmod>
    8754:	e1a03001 	mov	r3, r1
    8758:	e1a02003 	mov	r2, r3
    875c:	e51b3008 	ldr	r3, [fp, #-8]
    8760:	e583200c 	str	r2, [r3, #12]
/home/cf/ZCU/OS/practical/ex2/04_kernel/kernel/src/drivers/lcg.cpp:20
    return seed;
    8764:	e51b3008 	ldr	r3, [fp, #-8]
    8768:	e593300c 	ldr	r3, [r3, #12]
/home/cf/ZCU/OS/practical/ex2/04_kernel/kernel/src/drivers/lcg.cpp:21
    876c:	e1a00003 	mov	r0, r3
    8770:	e24bd004 	sub	sp, fp, #4
    8774:	e8bd8800 	pop	{fp, pc}

00008778 <_Z41__static_initialization_and_destruction_0ii>:
_Z41__static_initialization_and_destruction_0ii():
/home/cf/ZCU/OS/practical/ex2/04_kernel/kernel/src/drivers/lcg.cpp:21
    8778:	e92d4800 	push	{fp, lr}
    877c:	e28db004 	add	fp, sp, #4
    8780:	e24dd008 	sub	sp, sp, #8
    8784:	e50b0008 	str	r0, [fp, #-8]
    8788:	e50b100c 	str	r1, [fp, #-12]
    878c:	e51b3008 	ldr	r3, [fp, #-8]
    8790:	e3530001 	cmp	r3, #1
    8794:	1a000005 	bne	87b0 <_Z41__static_initialization_and_destruction_0ii+0x38>
/home/cf/ZCU/OS/practical/ex2/04_kernel/kernel/src/drivers/lcg.cpp:21 (discriminator 1)
    8798:	e51b300c 	ldr	r3, [fp, #-12]
    879c:	e59f2018 	ldr	r2, [pc, #24]	; 87bc <_Z41__static_initialization_and_destruction_0ii+0x44>
    87a0:	e1530002 	cmp	r3, r2
    87a4:	1a000001 	bne	87b0 <_Z41__static_initialization_and_destruction_0ii+0x38>
/home/cf/ZCU/OS/practical/ex2/04_kernel/kernel/src/drivers/lcg.cpp:3
LCG lcgInstance;
    87a8:	e59f0010 	ldr	r0, [pc, #16]	; 87c0 <_Z41__static_initialization_and_destruction_0ii+0x48>
    87ac:	ebffff93 	bl	8600 <_ZN3LCGC1Ev>
/home/cf/ZCU/OS/practical/ex2/04_kernel/kernel/src/drivers/lcg.cpp:21
    87b0:	e320f000 	nop	{0}
    87b4:	e24bd004 	sub	sp, fp, #4
    87b8:	e8bd8800 	pop	{fp, pc}
    87bc:	0000ffff 	strdeq	pc, [r0], -pc	; <UNPREDICTABLE>
    87c0:	00008ce0 	andeq	r8, r0, r0, ror #25

000087c4 <_GLOBAL__sub_I_lcgInstance>:
_GLOBAL__sub_I_lcgInstance():
/home/cf/ZCU/OS/practical/ex2/04_kernel/kernel/src/drivers/lcg.cpp:21
    87c4:	e92d4800 	push	{fp, lr}
    87c8:	e28db004 	add	fp, sp, #4
    87cc:	e59f1008 	ldr	r1, [pc, #8]	; 87dc <_GLOBAL__sub_I_lcgInstance+0x18>
    87d0:	e3a00001 	mov	r0, #1
    87d4:	ebffffe7 	bl	8778 <_Z41__static_initialization_and_destruction_0ii>
    87d8:	e8bd8800 	pop	{fp, pc}
    87dc:	0000ffff 	strdeq	pc, [r0], -pc	; <UNPREDICTABLE>

000087e0 <_Z11wait_activei>:
_Z11wait_activei():
/home/cf/ZCU/OS/practical/ex2/04_kernel/kernel/src/main.cpp:7
#include <drivers/lcg.h>

// GPIO pin 47 je pripojeny na LED na desce (tzv. ACT LED)
constexpr uint32_t ACT_Pin = 47;

void wait_active(int ticks) {
    87e0:	e52db004 	push	{fp}		; (str fp, [sp, #-4]!)
    87e4:	e28db000 	add	fp, sp, #0
    87e8:	e24dd014 	sub	sp, sp, #20
    87ec:	e50b0010 	str	r0, [fp, #-16]
/home/cf/ZCU/OS/practical/ex2/04_kernel/kernel/src/main.cpp:10
	volatile unsigned int tim;

	for(tim = 0; tim < ticks; tim++)
    87f0:	e3a03000 	mov	r3, #0
    87f4:	e50b3008 	str	r3, [fp, #-8]
    87f8:	ea000002 	b	8808 <_Z11wait_activei+0x28>
/home/cf/ZCU/OS/practical/ex2/04_kernel/kernel/src/main.cpp:10 (discriminator 3)
    87fc:	e51b3008 	ldr	r3, [fp, #-8]
    8800:	e2833001 	add	r3, r3, #1
    8804:	e50b3008 	str	r3, [fp, #-8]
/home/cf/ZCU/OS/practical/ex2/04_kernel/kernel/src/main.cpp:10 (discriminator 1)
    8808:	e51b2008 	ldr	r2, [fp, #-8]
    880c:	e51b3010 	ldr	r3, [fp, #-16]
    8810:	e1520003 	cmp	r2, r3
    8814:	33a03001 	movcc	r3, #1
    8818:	23a03000 	movcs	r3, #0
    881c:	e6ef3073 	uxtb	r3, r3
    8820:	e3530000 	cmp	r3, #0
    8824:	1afffff4 	bne	87fc <_Z11wait_activei+0x1c>
/home/cf/ZCU/OS/practical/ex2/04_kernel/kernel/src/main.cpp:12
		;
}
    8828:	e320f000 	nop	{0}
    882c:	e320f000 	nop	{0}
    8830:	e28bd000 	add	sp, fp, #0
    8834:	e49db004 	pop	{fp}		; (ldr fp, [sp], #4)
    8838:	e12fff1e 	bx	lr

0000883c <_kernel_main>:
_kernel_main():
/home/cf/ZCU/OS/practical/ex2/04_kernel/kernel/src/main.cpp:15

extern "C" int _kernel_main(void)
{
    883c:	e92d4800 	push	{fp, lr}
    8840:	e28db004 	add	fp, sp, #4
    8844:	e24dd018 	sub	sp, sp, #24
/home/cf/ZCU/OS/practical/ex2/04_kernel/kernel/src/main.cpp:17
	// nastavime ACT LED pin na vystupni
	sGPIO.Set_GPIO_Function(ACT_Pin, NGPIO_Function::Output);
    8848:	e3a02001 	mov	r2, #1
    884c:	e3a0102f 	mov	r1, #47	; 0x2f
    8850:	e59f00ac 	ldr	r0, [pc, #172]	; 8904 <_kernel_main+0xc8>
    8854:	ebfffece 	bl	8394 <_ZN13CGPIO_Handler17Set_GPIO_FunctionEj14NGPIO_Function>
/home/cf/ZCU/OS/practical/ex2/04_kernel/kernel/src/main.cpp:19

	LCG lcg;
    8858:	e24b3018 	sub	r3, fp, #24
    885c:	e1a00003 	mov	r0, r3
    8860:	ebffff66 	bl	8600 <_ZN3LCGC1Ev>
/home/cf/ZCU/OS/practical/ex2/04_kernel/kernel/src/main.cpp:26
	
    while (1)
    {
		// for a range use: lower + lcg.get_next() % (upper - lower) - eg: 5000 + lcg.get_next % 5000; (<5000, 10000))
		// gen_number = lcg.get_next();
		gen_number = lcgInstance.get_next(); // testing lcgInstance
    8864:	e59f009c 	ldr	r0, [pc, #156]	; 8908 <_kernel_main+0xcc>
    8868:	ebffffa8 	bl	8710 <_ZN3LCG8get_nextEv>
    886c:	e1a03000 	mov	r3, r0
    8870:	e50b3008 	str	r3, [fp, #-8]
/home/cf/ZCU/OS/practical/ex2/04_kernel/kernel/src/main.cpp:27
		if (gen_number < 0) gen_number = -gen_number; // make sure sleep number is positive - to prevent active sleep for "0"
    8874:	e51b3008 	ldr	r3, [fp, #-8]
    8878:	e3530000 	cmp	r3, #0
    887c:	aa000002 	bge	888c <_kernel_main+0x50>
/home/cf/ZCU/OS/practical/ex2/04_kernel/kernel/src/main.cpp:27 (discriminator 1)
    8880:	e51b3008 	ldr	r3, [fp, #-8]
    8884:	e2633000 	rsb	r3, r3, #0
    8888:	e50b3008 	str	r3, [fp, #-8]
/home/cf/ZCU/OS/practical/ex2/04_kernel/kernel/src/main.cpp:28
		wait_active(gen_number % 10000000); // limit the number to 10 mil max
    888c:	e51b0008 	ldr	r0, [fp, #-8]
    8890:	e59f3074 	ldr	r3, [pc, #116]	; 890c <_kernel_main+0xd0>
    8894:	e0c32093 	smull	r2, r3, r3, r0
    8898:	e1a02b43 	asr	r2, r3, #22
    889c:	e1a03fc0 	asr	r3, r0, #31
    88a0:	e0421003 	sub	r1, r2, r3
    88a4:	e1a02001 	mov	r2, r1
    88a8:	e1a02282 	lsl	r2, r2, #5
    88ac:	e0422001 	sub	r2, r2, r1
    88b0:	e1a03302 	lsl	r3, r2, #6
    88b4:	e0433002 	sub	r3, r3, r2
    88b8:	e1a03183 	lsl	r3, r3, #3
    88bc:	e0833001 	add	r3, r3, r1
    88c0:	e1a02103 	lsl	r2, r3, #2
    88c4:	e0833002 	add	r3, r3, r2
    88c8:	e1a03383 	lsl	r3, r3, #7
    88cc:	e0401003 	sub	r1, r0, r3
    88d0:	e1a00001 	mov	r0, r1
    88d4:	ebffffc1 	bl	87e0 <_Z11wait_activei>
/home/cf/ZCU/OS/practical/ex2/04_kernel/kernel/src/main.cpp:31
		
		// zhasneme LED
		sGPIO.Set_Output(ACT_Pin, true);
    88d8:	e3a02001 	mov	r2, #1
    88dc:	e3a0102f 	mov	r1, #47	; 0x2f
    88e0:	e59f001c 	ldr	r0, [pc, #28]	; 8904 <_kernel_main+0xc8>
    88e4:	ebfffef3 	bl	84b8 <_ZN13CGPIO_Handler10Set_OutputEjb>
/home/cf/ZCU/OS/practical/ex2/04_kernel/kernel/src/main.cpp:33

		wait_active(2000000);
    88e8:	e59f0020 	ldr	r0, [pc, #32]	; 8910 <_kernel_main+0xd4>
    88ec:	ebffffbb 	bl	87e0 <_Z11wait_activei>
/home/cf/ZCU/OS/practical/ex2/04_kernel/kernel/src/main.cpp:36

		// rozsvitime LED
		sGPIO.Set_Output(ACT_Pin, false);
    88f0:	e3a02000 	mov	r2, #0
    88f4:	e3a0102f 	mov	r1, #47	; 0x2f
    88f8:	e59f0004 	ldr	r0, [pc, #4]	; 8904 <_kernel_main+0xc8>
    88fc:	ebfffeed 	bl	84b8 <_ZN13CGPIO_Handler10Set_OutputEjb>
/home/cf/ZCU/OS/practical/ex2/04_kernel/kernel/src/main.cpp:26
		gen_number = lcgInstance.get_next(); // testing lcgInstance
    8900:	eaffffd7 	b	8864 <_kernel_main+0x28>
    8904:	00008cdc 	ldrdeq	r8, [r0], -ip
    8908:	00008ce0 	andeq	r8, r0, r0, ror #25
    890c:	6b5fca6b 	blvs	17fb2c0 <_bss_end+0x17f25c0>
    8910:	001e8480 	andseq	r8, lr, r0, lsl #9

00008914 <_c_startup>:
_c_startup():
/home/cf/ZCU/OS/practical/ex2/04_kernel/kernel/src/startup.cpp:21
extern "C" dtor_ptr __DTOR_LIST__[0];
// konec pole destruktoru
extern "C" dtor_ptr __DTOR_END__[0];

extern "C" int _c_startup(void)
{
    8914:	e52db004 	push	{fp}		; (str fp, [sp, #-4]!)
    8918:	e28db000 	add	fp, sp, #0
    891c:	e24dd00c 	sub	sp, sp, #12
/home/cf/ZCU/OS/practical/ex2/04_kernel/kernel/src/startup.cpp:25
	int* i;
	
	// vynulujeme .bss sekci
	for (i = (int*)_bss_start; i < (int*)_bss_end; i++)
    8920:	e59f304c 	ldr	r3, [pc, #76]	; 8974 <_c_startup+0x60>
    8924:	e5933000 	ldr	r3, [r3]
    8928:	e50b3008 	str	r3, [fp, #-8]
    892c:	ea000005 	b	8948 <_c_startup+0x34>
/home/cf/ZCU/OS/practical/ex2/04_kernel/kernel/src/startup.cpp:26 (discriminator 3)
		*i = 0;
    8930:	e51b3008 	ldr	r3, [fp, #-8]
    8934:	e3a02000 	mov	r2, #0
    8938:	e5832000 	str	r2, [r3]
/home/cf/ZCU/OS/practical/ex2/04_kernel/kernel/src/startup.cpp:25 (discriminator 3)
	for (i = (int*)_bss_start; i < (int*)_bss_end; i++)
    893c:	e51b3008 	ldr	r3, [fp, #-8]
    8940:	e2833004 	add	r3, r3, #4
    8944:	e50b3008 	str	r3, [fp, #-8]
/home/cf/ZCU/OS/practical/ex2/04_kernel/kernel/src/startup.cpp:25 (discriminator 1)
    8948:	e59f3028 	ldr	r3, [pc, #40]	; 8978 <_c_startup+0x64>
    894c:	e5933000 	ldr	r3, [r3]
    8950:	e1a02003 	mov	r2, r3
    8954:	e51b3008 	ldr	r3, [fp, #-8]
    8958:	e1530002 	cmp	r3, r2
    895c:	3afffff3 	bcc	8930 <_c_startup+0x1c>
/home/cf/ZCU/OS/practical/ex2/04_kernel/kernel/src/startup.cpp:28
	
	return 0;
    8960:	e3a03000 	mov	r3, #0
/home/cf/ZCU/OS/practical/ex2/04_kernel/kernel/src/startup.cpp:29
}
    8964:	e1a00003 	mov	r0, r3
    8968:	e28bd000 	add	sp, fp, #0
    896c:	e49db004 	pop	{fp}		; (ldr fp, [sp], #4)
    8970:	e12fff1e 	bx	lr
    8974:	00008cdc 	ldrdeq	r8, [r0], -ip
    8978:	00008d00 	andeq	r8, r0, r0, lsl #26

0000897c <_cpp_startup>:
_cpp_startup():
/home/cf/ZCU/OS/practical/ex2/04_kernel/kernel/src/startup.cpp:32

extern "C" int _cpp_startup(void)
{
    897c:	e92d4800 	push	{fp, lr}
    8980:	e28db004 	add	fp, sp, #4
    8984:	e24dd008 	sub	sp, sp, #8
/home/cf/ZCU/OS/practical/ex2/04_kernel/kernel/src/startup.cpp:37
	ctor_ptr* fnptr;
	
	// zavolame konstruktory globalnich C++ trid
	// v poli __CTOR_LIST__ jsou ukazatele na vygenerovane stuby volani konstruktoru
	for (fnptr = __CTOR_LIST__; fnptr < __CTOR_END__; fnptr++)
    8988:	e59f303c 	ldr	r3, [pc, #60]	; 89cc <_cpp_startup+0x50>
    898c:	e50b3008 	str	r3, [fp, #-8]
    8990:	ea000005 	b	89ac <_cpp_startup+0x30>
/home/cf/ZCU/OS/practical/ex2/04_kernel/kernel/src/startup.cpp:38 (discriminator 3)
		(*fnptr)();
    8994:	e51b3008 	ldr	r3, [fp, #-8]
    8998:	e5933000 	ldr	r3, [r3]
    899c:	e12fff33 	blx	r3
/home/cf/ZCU/OS/practical/ex2/04_kernel/kernel/src/startup.cpp:37 (discriminator 3)
	for (fnptr = __CTOR_LIST__; fnptr < __CTOR_END__; fnptr++)
    89a0:	e51b3008 	ldr	r3, [fp, #-8]
    89a4:	e2833004 	add	r3, r3, #4
    89a8:	e50b3008 	str	r3, [fp, #-8]
/home/cf/ZCU/OS/practical/ex2/04_kernel/kernel/src/startup.cpp:37 (discriminator 1)
    89ac:	e51b3008 	ldr	r3, [fp, #-8]
    89b0:	e59f2018 	ldr	r2, [pc, #24]	; 89d0 <_cpp_startup+0x54>
    89b4:	e1530002 	cmp	r3, r2
    89b8:	3afffff5 	bcc	8994 <_cpp_startup+0x18>
/home/cf/ZCU/OS/practical/ex2/04_kernel/kernel/src/startup.cpp:40
	
	return 0;
    89bc:	e3a03000 	mov	r3, #0
/home/cf/ZCU/OS/practical/ex2/04_kernel/kernel/src/startup.cpp:41
}
    89c0:	e1a00003 	mov	r0, r3
    89c4:	e24bd004 	sub	sp, fp, #4
    89c8:	e8bd8800 	pop	{fp, pc}
    89cc:	00008cd4 	ldrdeq	r8, [r0], -r4
    89d0:	00008cdc 	ldrdeq	r8, [r0], -ip

000089d4 <_cpp_shutdown>:
_cpp_shutdown():
/home/cf/ZCU/OS/practical/ex2/04_kernel/kernel/src/startup.cpp:44

extern "C" int _cpp_shutdown(void)
{
    89d4:	e92d4800 	push	{fp, lr}
    89d8:	e28db004 	add	fp, sp, #4
    89dc:	e24dd008 	sub	sp, sp, #8
/home/cf/ZCU/OS/practical/ex2/04_kernel/kernel/src/startup.cpp:48
	dtor_ptr* fnptr;
	
	// zavolame destruktory globalnich C++ trid
	for (fnptr = __DTOR_LIST__; fnptr < __DTOR_END__; fnptr++)
    89e0:	e59f303c 	ldr	r3, [pc, #60]	; 8a24 <_cpp_shutdown+0x50>
    89e4:	e50b3008 	str	r3, [fp, #-8]
    89e8:	ea000005 	b	8a04 <_cpp_shutdown+0x30>
/home/cf/ZCU/OS/practical/ex2/04_kernel/kernel/src/startup.cpp:49 (discriminator 3)
		(*fnptr)();
    89ec:	e51b3008 	ldr	r3, [fp, #-8]
    89f0:	e5933000 	ldr	r3, [r3]
    89f4:	e12fff33 	blx	r3
/home/cf/ZCU/OS/practical/ex2/04_kernel/kernel/src/startup.cpp:48 (discriminator 3)
	for (fnptr = __DTOR_LIST__; fnptr < __DTOR_END__; fnptr++)
    89f8:	e51b3008 	ldr	r3, [fp, #-8]
    89fc:	e2833004 	add	r3, r3, #4
    8a00:	e50b3008 	str	r3, [fp, #-8]
/home/cf/ZCU/OS/practical/ex2/04_kernel/kernel/src/startup.cpp:48 (discriminator 1)
    8a04:	e51b3008 	ldr	r3, [fp, #-8]
    8a08:	e59f2018 	ldr	r2, [pc, #24]	; 8a28 <_cpp_shutdown+0x54>
    8a0c:	e1530002 	cmp	r3, r2
    8a10:	3afffff5 	bcc	89ec <_cpp_shutdown+0x18>
/home/cf/ZCU/OS/practical/ex2/04_kernel/kernel/src/startup.cpp:51
	
	return 0;
    8a14:	e3a03000 	mov	r3, #0
/home/cf/ZCU/OS/practical/ex2/04_kernel/kernel/src/startup.cpp:52
}
    8a18:	e1a00003 	mov	r0, r3
    8a1c:	e24bd004 	sub	sp, fp, #4
    8a20:	e8bd8800 	pop	{fp, pc}
    8a24:	00008cdc 	ldrdeq	r8, [r0], -ip
    8a28:	00008cdc 	ldrdeq	r8, [r0], -ip

00008a2c <__divsi3>:
__divsi3():
/builddir/build/BUILD/arm-none-eabi-gcc-cs-12.2.0/gcc-arm-none-eabi/arm-none-eabi/arm/v5te/hard/libgcc/../../../../../../gcc-12.2.0/libgcc/config/arm/lib1funcs.S:1297
    8a2c:	e3510000 	cmp	r1, #0
/builddir/build/BUILD/arm-none-eabi-gcc-cs-12.2.0/gcc-arm-none-eabi/arm-none-eabi/arm/v5te/hard/libgcc/../../../../../../gcc-12.2.0/libgcc/config/arm/lib1funcs.S:1298
    8a30:	0a000081 	beq	8c3c <.divsi3_skip_div0_test+0x208>

00008a34 <.divsi3_skip_div0_test>:
/builddir/build/BUILD/arm-none-eabi-gcc-cs-12.2.0/gcc-arm-none-eabi/arm-none-eabi/arm/v5te/hard/libgcc/../../../../../../gcc-12.2.0/libgcc/config/arm/lib1funcs.S:1300
    8a34:	e020c001 	eor	ip, r0, r1
/builddir/build/BUILD/arm-none-eabi-gcc-cs-12.2.0/gcc-arm-none-eabi/arm-none-eabi/arm/v5te/hard/libgcc/../../../../../../gcc-12.2.0/libgcc/config/arm/lib1funcs.S:1302
    8a38:	42611000 	rsbmi	r1, r1, #0
/builddir/build/BUILD/arm-none-eabi-gcc-cs-12.2.0/gcc-arm-none-eabi/arm-none-eabi/arm/v5te/hard/libgcc/../../../../../../gcc-12.2.0/libgcc/config/arm/lib1funcs.S:1303
    8a3c:	e2512001 	subs	r2, r1, #1
/builddir/build/BUILD/arm-none-eabi-gcc-cs-12.2.0/gcc-arm-none-eabi/arm-none-eabi/arm/v5te/hard/libgcc/../../../../../../gcc-12.2.0/libgcc/config/arm/lib1funcs.S:1304
    8a40:	0a000070 	beq	8c08 <.divsi3_skip_div0_test+0x1d4>
/builddir/build/BUILD/arm-none-eabi-gcc-cs-12.2.0/gcc-arm-none-eabi/arm-none-eabi/arm/v5te/hard/libgcc/../../../../../../gcc-12.2.0/libgcc/config/arm/lib1funcs.S:1305
    8a44:	e1b03000 	movs	r3, r0
/builddir/build/BUILD/arm-none-eabi-gcc-cs-12.2.0/gcc-arm-none-eabi/arm-none-eabi/arm/v5te/hard/libgcc/../../../../../../gcc-12.2.0/libgcc/config/arm/lib1funcs.S:1307
    8a48:	42603000 	rsbmi	r3, r0, #0
/builddir/build/BUILD/arm-none-eabi-gcc-cs-12.2.0/gcc-arm-none-eabi/arm-none-eabi/arm/v5te/hard/libgcc/../../../../../../gcc-12.2.0/libgcc/config/arm/lib1funcs.S:1308
    8a4c:	e1530001 	cmp	r3, r1
/builddir/build/BUILD/arm-none-eabi-gcc-cs-12.2.0/gcc-arm-none-eabi/arm-none-eabi/arm/v5te/hard/libgcc/../../../../../../gcc-12.2.0/libgcc/config/arm/lib1funcs.S:1309
    8a50:	9a00006f 	bls	8c14 <.divsi3_skip_div0_test+0x1e0>
/builddir/build/BUILD/arm-none-eabi-gcc-cs-12.2.0/gcc-arm-none-eabi/arm-none-eabi/arm/v5te/hard/libgcc/../../../../../../gcc-12.2.0/libgcc/config/arm/lib1funcs.S:1310
    8a54:	e1110002 	tst	r1, r2
/builddir/build/BUILD/arm-none-eabi-gcc-cs-12.2.0/gcc-arm-none-eabi/arm-none-eabi/arm/v5te/hard/libgcc/../../../../../../gcc-12.2.0/libgcc/config/arm/lib1funcs.S:1311
    8a58:	0a000071 	beq	8c24 <.divsi3_skip_div0_test+0x1f0>
/builddir/build/BUILD/arm-none-eabi-gcc-cs-12.2.0/gcc-arm-none-eabi/arm-none-eabi/arm/v5te/hard/libgcc/../../../../../../gcc-12.2.0/libgcc/config/arm/lib1funcs.S:1313
    8a5c:	e16f2f13 	clz	r2, r3
    8a60:	e16f0f11 	clz	r0, r1
    8a64:	e0402002 	sub	r2, r0, r2
    8a68:	e272201f 	rsbs	r2, r2, #31
    8a6c:	10822082 	addne	r2, r2, r2, lsl #1
    8a70:	e3a00000 	mov	r0, #0
    8a74:	108ff102 	addne	pc, pc, r2, lsl #2
    8a78:	e1a00000 	nop			; (mov r0, r0)
    8a7c:	e1530f81 	cmp	r3, r1, lsl #31
    8a80:	e0a00000 	adc	r0, r0, r0
    8a84:	20433f81 	subcs	r3, r3, r1, lsl #31
    8a88:	e1530f01 	cmp	r3, r1, lsl #30
    8a8c:	e0a00000 	adc	r0, r0, r0
    8a90:	20433f01 	subcs	r3, r3, r1, lsl #30
    8a94:	e1530e81 	cmp	r3, r1, lsl #29
    8a98:	e0a00000 	adc	r0, r0, r0
    8a9c:	20433e81 	subcs	r3, r3, r1, lsl #29
    8aa0:	e1530e01 	cmp	r3, r1, lsl #28
    8aa4:	e0a00000 	adc	r0, r0, r0
    8aa8:	20433e01 	subcs	r3, r3, r1, lsl #28
    8aac:	e1530d81 	cmp	r3, r1, lsl #27
    8ab0:	e0a00000 	adc	r0, r0, r0
    8ab4:	20433d81 	subcs	r3, r3, r1, lsl #27
    8ab8:	e1530d01 	cmp	r3, r1, lsl #26
    8abc:	e0a00000 	adc	r0, r0, r0
    8ac0:	20433d01 	subcs	r3, r3, r1, lsl #26
    8ac4:	e1530c81 	cmp	r3, r1, lsl #25
    8ac8:	e0a00000 	adc	r0, r0, r0
    8acc:	20433c81 	subcs	r3, r3, r1, lsl #25
    8ad0:	e1530c01 	cmp	r3, r1, lsl #24
    8ad4:	e0a00000 	adc	r0, r0, r0
    8ad8:	20433c01 	subcs	r3, r3, r1, lsl #24
    8adc:	e1530b81 	cmp	r3, r1, lsl #23
    8ae0:	e0a00000 	adc	r0, r0, r0
    8ae4:	20433b81 	subcs	r3, r3, r1, lsl #23
    8ae8:	e1530b01 	cmp	r3, r1, lsl #22
    8aec:	e0a00000 	adc	r0, r0, r0
    8af0:	20433b01 	subcs	r3, r3, r1, lsl #22
    8af4:	e1530a81 	cmp	r3, r1, lsl #21
    8af8:	e0a00000 	adc	r0, r0, r0
    8afc:	20433a81 	subcs	r3, r3, r1, lsl #21
    8b00:	e1530a01 	cmp	r3, r1, lsl #20
    8b04:	e0a00000 	adc	r0, r0, r0
    8b08:	20433a01 	subcs	r3, r3, r1, lsl #20
    8b0c:	e1530981 	cmp	r3, r1, lsl #19
    8b10:	e0a00000 	adc	r0, r0, r0
    8b14:	20433981 	subcs	r3, r3, r1, lsl #19
    8b18:	e1530901 	cmp	r3, r1, lsl #18
    8b1c:	e0a00000 	adc	r0, r0, r0
    8b20:	20433901 	subcs	r3, r3, r1, lsl #18
    8b24:	e1530881 	cmp	r3, r1, lsl #17
    8b28:	e0a00000 	adc	r0, r0, r0
    8b2c:	20433881 	subcs	r3, r3, r1, lsl #17
    8b30:	e1530801 	cmp	r3, r1, lsl #16
    8b34:	e0a00000 	adc	r0, r0, r0
    8b38:	20433801 	subcs	r3, r3, r1, lsl #16
    8b3c:	e1530781 	cmp	r3, r1, lsl #15
    8b40:	e0a00000 	adc	r0, r0, r0
    8b44:	20433781 	subcs	r3, r3, r1, lsl #15
    8b48:	e1530701 	cmp	r3, r1, lsl #14
    8b4c:	e0a00000 	adc	r0, r0, r0
    8b50:	20433701 	subcs	r3, r3, r1, lsl #14
    8b54:	e1530681 	cmp	r3, r1, lsl #13
    8b58:	e0a00000 	adc	r0, r0, r0
    8b5c:	20433681 	subcs	r3, r3, r1, lsl #13
    8b60:	e1530601 	cmp	r3, r1, lsl #12
    8b64:	e0a00000 	adc	r0, r0, r0
    8b68:	20433601 	subcs	r3, r3, r1, lsl #12
    8b6c:	e1530581 	cmp	r3, r1, lsl #11
    8b70:	e0a00000 	adc	r0, r0, r0
    8b74:	20433581 	subcs	r3, r3, r1, lsl #11
    8b78:	e1530501 	cmp	r3, r1, lsl #10
    8b7c:	e0a00000 	adc	r0, r0, r0
    8b80:	20433501 	subcs	r3, r3, r1, lsl #10
    8b84:	e1530481 	cmp	r3, r1, lsl #9
    8b88:	e0a00000 	adc	r0, r0, r0
    8b8c:	20433481 	subcs	r3, r3, r1, lsl #9
    8b90:	e1530401 	cmp	r3, r1, lsl #8
    8b94:	e0a00000 	adc	r0, r0, r0
    8b98:	20433401 	subcs	r3, r3, r1, lsl #8
    8b9c:	e1530381 	cmp	r3, r1, lsl #7
    8ba0:	e0a00000 	adc	r0, r0, r0
    8ba4:	20433381 	subcs	r3, r3, r1, lsl #7
    8ba8:	e1530301 	cmp	r3, r1, lsl #6
    8bac:	e0a00000 	adc	r0, r0, r0
    8bb0:	20433301 	subcs	r3, r3, r1, lsl #6
    8bb4:	e1530281 	cmp	r3, r1, lsl #5
    8bb8:	e0a00000 	adc	r0, r0, r0
    8bbc:	20433281 	subcs	r3, r3, r1, lsl #5
    8bc0:	e1530201 	cmp	r3, r1, lsl #4
    8bc4:	e0a00000 	adc	r0, r0, r0
    8bc8:	20433201 	subcs	r3, r3, r1, lsl #4
    8bcc:	e1530181 	cmp	r3, r1, lsl #3
    8bd0:	e0a00000 	adc	r0, r0, r0
    8bd4:	20433181 	subcs	r3, r3, r1, lsl #3
    8bd8:	e1530101 	cmp	r3, r1, lsl #2
    8bdc:	e0a00000 	adc	r0, r0, r0
    8be0:	20433101 	subcs	r3, r3, r1, lsl #2
    8be4:	e1530081 	cmp	r3, r1, lsl #1
    8be8:	e0a00000 	adc	r0, r0, r0
    8bec:	20433081 	subcs	r3, r3, r1, lsl #1
    8bf0:	e1530001 	cmp	r3, r1
    8bf4:	e0a00000 	adc	r0, r0, r0
    8bf8:	20433001 	subcs	r3, r3, r1
/builddir/build/BUILD/arm-none-eabi-gcc-cs-12.2.0/gcc-arm-none-eabi/arm-none-eabi/arm/v5te/hard/libgcc/../../../../../../gcc-12.2.0/libgcc/config/arm/lib1funcs.S:1315
    8bfc:	e35c0000 	cmp	ip, #0
/builddir/build/BUILD/arm-none-eabi-gcc-cs-12.2.0/gcc-arm-none-eabi/arm-none-eabi/arm/v5te/hard/libgcc/../../../../../../gcc-12.2.0/libgcc/config/arm/lib1funcs.S:1317
    8c00:	42600000 	rsbmi	r0, r0, #0
/builddir/build/BUILD/arm-none-eabi-gcc-cs-12.2.0/gcc-arm-none-eabi/arm-none-eabi/arm/v5te/hard/libgcc/../../../../../../gcc-12.2.0/libgcc/config/arm/lib1funcs.S:1318
    8c04:	e12fff1e 	bx	lr
/builddir/build/BUILD/arm-none-eabi-gcc-cs-12.2.0/gcc-arm-none-eabi/arm-none-eabi/arm/v5te/hard/libgcc/../../../../../../gcc-12.2.0/libgcc/config/arm/lib1funcs.S:1320
    8c08:	e13c0000 	teq	ip, r0
/builddir/build/BUILD/arm-none-eabi-gcc-cs-12.2.0/gcc-arm-none-eabi/arm-none-eabi/arm/v5te/hard/libgcc/../../../../../../gcc-12.2.0/libgcc/config/arm/lib1funcs.S:1322
    8c0c:	42600000 	rsbmi	r0, r0, #0
/builddir/build/BUILD/arm-none-eabi-gcc-cs-12.2.0/gcc-arm-none-eabi/arm-none-eabi/arm/v5te/hard/libgcc/../../../../../../gcc-12.2.0/libgcc/config/arm/lib1funcs.S:1323
    8c10:	e12fff1e 	bx	lr
/builddir/build/BUILD/arm-none-eabi-gcc-cs-12.2.0/gcc-arm-none-eabi/arm-none-eabi/arm/v5te/hard/libgcc/../../../../../../gcc-12.2.0/libgcc/config/arm/lib1funcs.S:1326
    8c14:	33a00000 	movcc	r0, #0
/builddir/build/BUILD/arm-none-eabi-gcc-cs-12.2.0/gcc-arm-none-eabi/arm-none-eabi/arm/v5te/hard/libgcc/../../../../../../gcc-12.2.0/libgcc/config/arm/lib1funcs.S:1328
    8c18:	01a00fcc 	asreq	r0, ip, #31
/builddir/build/BUILD/arm-none-eabi-gcc-cs-12.2.0/gcc-arm-none-eabi/arm-none-eabi/arm/v5te/hard/libgcc/../../../../../../gcc-12.2.0/libgcc/config/arm/lib1funcs.S:1329
    8c1c:	03800001 	orreq	r0, r0, #1
/builddir/build/BUILD/arm-none-eabi-gcc-cs-12.2.0/gcc-arm-none-eabi/arm-none-eabi/arm/v5te/hard/libgcc/../../../../../../gcc-12.2.0/libgcc/config/arm/lib1funcs.S:1330
    8c20:	e12fff1e 	bx	lr
/builddir/build/BUILD/arm-none-eabi-gcc-cs-12.2.0/gcc-arm-none-eabi/arm-none-eabi/arm/v5te/hard/libgcc/../../../../../../gcc-12.2.0/libgcc/config/arm/lib1funcs.S:1332
    8c24:	e16f2f11 	clz	r2, r1
    8c28:	e262201f 	rsb	r2, r2, #31
/builddir/build/BUILD/arm-none-eabi-gcc-cs-12.2.0/gcc-arm-none-eabi/arm-none-eabi/arm/v5te/hard/libgcc/../../../../../../gcc-12.2.0/libgcc/config/arm/lib1funcs.S:1334
    8c2c:	e35c0000 	cmp	ip, #0
/builddir/build/BUILD/arm-none-eabi-gcc-cs-12.2.0/gcc-arm-none-eabi/arm-none-eabi/arm/v5te/hard/libgcc/../../../../../../gcc-12.2.0/libgcc/config/arm/lib1funcs.S:1335
    8c30:	e1a00233 	lsr	r0, r3, r2
/builddir/build/BUILD/arm-none-eabi-gcc-cs-12.2.0/gcc-arm-none-eabi/arm-none-eabi/arm/v5te/hard/libgcc/../../../../../../gcc-12.2.0/libgcc/config/arm/lib1funcs.S:1337
    8c34:	42600000 	rsbmi	r0, r0, #0
/builddir/build/BUILD/arm-none-eabi-gcc-cs-12.2.0/gcc-arm-none-eabi/arm-none-eabi/arm/v5te/hard/libgcc/../../../../../../gcc-12.2.0/libgcc/config/arm/lib1funcs.S:1338
    8c38:	e12fff1e 	bx	lr
/builddir/build/BUILD/arm-none-eabi-gcc-cs-12.2.0/gcc-arm-none-eabi/arm-none-eabi/arm/v5te/hard/libgcc/../../../../../../gcc-12.2.0/libgcc/config/arm/lib1funcs.S:1342
    8c3c:	e3500000 	cmp	r0, #0
    8c40:	c3e00102 	mvngt	r0, #-2147483648	; 0x80000000
    8c44:	b3a00102 	movlt	r0, #-2147483648	; 0x80000000
    8c48:	ea000007 	b	8c6c <__aeabi_idiv0>

00008c4c <__aeabi_idivmod>:
__aeabi_idivmod():
/builddir/build/BUILD/arm-none-eabi-gcc-cs-12.2.0/gcc-arm-none-eabi/arm-none-eabi/arm/v5te/hard/libgcc/../../../../../../gcc-12.2.0/libgcc/config/arm/lib1funcs.S:1373
    8c4c:	e3510000 	cmp	r1, #0
/builddir/build/BUILD/arm-none-eabi-gcc-cs-12.2.0/gcc-arm-none-eabi/arm-none-eabi/arm/v5te/hard/libgcc/../../../../../../gcc-12.2.0/libgcc/config/arm/lib1funcs.S:1374
    8c50:	0afffff9 	beq	8c3c <.divsi3_skip_div0_test+0x208>
/builddir/build/BUILD/arm-none-eabi-gcc-cs-12.2.0/gcc-arm-none-eabi/arm-none-eabi/arm/v5te/hard/libgcc/../../../../../../gcc-12.2.0/libgcc/config/arm/lib1funcs.S:1375
    8c54:	e92d4003 	push	{r0, r1, lr}
/builddir/build/BUILD/arm-none-eabi-gcc-cs-12.2.0/gcc-arm-none-eabi/arm-none-eabi/arm/v5te/hard/libgcc/../../../../../../gcc-12.2.0/libgcc/config/arm/lib1funcs.S:1376
    8c58:	ebffff75 	bl	8a34 <.divsi3_skip_div0_test>
/builddir/build/BUILD/arm-none-eabi-gcc-cs-12.2.0/gcc-arm-none-eabi/arm-none-eabi/arm/v5te/hard/libgcc/../../../../../../gcc-12.2.0/libgcc/config/arm/lib1funcs.S:1377
    8c5c:	e8bd4006 	pop	{r1, r2, lr}
/builddir/build/BUILD/arm-none-eabi-gcc-cs-12.2.0/gcc-arm-none-eabi/arm-none-eabi/arm/v5te/hard/libgcc/../../../../../../gcc-12.2.0/libgcc/config/arm/lib1funcs.S:1378
    8c60:	e0030092 	mul	r3, r2, r0
/builddir/build/BUILD/arm-none-eabi-gcc-cs-12.2.0/gcc-arm-none-eabi/arm-none-eabi/arm/v5te/hard/libgcc/../../../../../../gcc-12.2.0/libgcc/config/arm/lib1funcs.S:1379
    8c64:	e0411003 	sub	r1, r1, r3
/builddir/build/BUILD/arm-none-eabi-gcc-cs-12.2.0/gcc-arm-none-eabi/arm-none-eabi/arm/v5te/hard/libgcc/../../../../../../gcc-12.2.0/libgcc/config/arm/lib1funcs.S:1380
    8c68:	e12fff1e 	bx	lr

00008c6c <__aeabi_idiv0>:
__aeabi_ldiv0():
/builddir/build/BUILD/arm-none-eabi-gcc-cs-12.2.0/gcc-arm-none-eabi/arm-none-eabi/arm/v5te/hard/libgcc/../../../../../../gcc-12.2.0/libgcc/config/arm/lib1funcs.S:1466
    8c6c:	e12fff1e 	bx	lr

Disassembly of section .ARM.extab:

00008c70 <.ARM.extab>:
    8c70:	81019b40 	tsthi	r1, r0, asr #22
    8c74:	8480b0b0 	strhi	fp, [r0], #176	; 0xb0
    8c78:	00000000 	andeq	r0, r0, r0
    8c7c:	81019b40 	tsthi	r1, r0, asr #22
    8c80:	8480b0b0 	strhi	fp, [r0], #176	; 0xb0
    8c84:	00000000 	andeq	r0, r0, r0
    8c88:	81019b40 	tsthi	r1, r0, asr #22
    8c8c:	8480b0b0 	strhi	fp, [r0], #176	; 0xb0
    8c90:	00000000 	andeq	r0, r0, r0

Disassembly of section .ARM.exidx:

00008c94 <.ARM.exidx>:
    8c94:	7ffff384 	svcvc	0x00fff384
    8c98:	00000001 	andeq	r0, r0, r1
    8c9c:	7ffffba0 	svcvc	0x00fffba0
    8ca0:	7fffffd0 	svcvc	0x00ffffd0
    8ca4:	7ffffc70 	svcvc	0x00fffc70
    8ca8:	00000001 	andeq	r0, r0, r1
    8cac:	7ffffcd0 	svcvc	0x00fffcd0
    8cb0:	7fffffcc 	svcvc	0x00ffffcc
    8cb4:	7ffffd20 	svcvc	0x00fffd20
    8cb8:	7fffffd0 	svcvc	0x00ffffd0
    8cbc:	7ffffd70 	svcvc	0x00fffd70
    8cc0:	00000001 	andeq	r0, r0, r1

Disassembly of section .rodata:

00008cc4 <_ZN3halL15Peripheral_BaseE>:
    8cc4:	20000000 	andcs	r0, r0, r0

00008cc8 <_ZN3halL9GPIO_BaseE>:
    8cc8:	20200000 	eorcs	r0, r0, r0

00008ccc <_ZN3halL14GPIO_Pin_CountE>:
    8ccc:	00000036 	andeq	r0, r0, r6, lsr r0

00008cd0 <_ZL7ACT_Pin>:
    8cd0:	0000002f 	andeq	r0, r0, pc, lsr #32

Disassembly of section .data:

00008cd4 <__CTOR_LIST__>:
/builddir/build/BUILD/arm-none-eabi-gcc-cs-12.2.0/gcc-arm-none-eabi/arm-none-eabi/arm/v5te/hard/libgcc/../../../../../../gcc-12.2.0/libgcc/libgcc2.c:2448
    8cd4:	000085e4 	andeq	r8, r0, r4, ror #11
    8cd8:	000087c4 	andeq	r8, r0, r4, asr #15

Disassembly of section .bss:

00008cdc <sGPIO>:
/home/cf/ZCU/OS/practical/ex2/04_kernel/kernel/src/drivers/gpio.cpp:4
CGPIO_Handler sGPIO(hal::GPIO_Base);
    8cdc:	00000000 	andeq	r0, r0, r0

00008ce0 <lcgInstance>:
	...

Disassembly of section .debug_info:

00000000 <.debug_info>:
       0:	0000011a 	andeq	r0, r0, sl, lsl r1
       4:	04010005 	streq	r0, [r1], #-5
       8:	00000000 	andeq	r0, r0, r0
       c:	00006e06 	andeq	r6, r0, r6, lsl #28
      10:	014e2100 	mrseq	r2, (UNDEF: 94)
      14:	00400000 	subeq	r0, r0, r0
      18:	80180000 	andshi	r0, r8, r0
      1c:	00d80000 	sbcseq	r0, r8, r0
      20:	00000000 	andeq	r0, r0, r0
      24:	2f010000 	svccs	0x00010000
      28:	29000001 	stmdbcs	r0, {r0}
      2c:	000080e4 	andeq	r8, r0, r4, ror #1
      30:	0000000c 	andeq	r0, r0, ip
      34:	1c019c01 	stcne	12, cr9, [r1], {1}
      38:	24000001 	strcs	r0, [r0], #-1
      3c:	000080cc 	andeq	r8, r0, ip, asr #1
      40:	00000018 	andeq	r0, r0, r8, lsl r0
      44:	33019c01 	movwcc	r9, #7169	; 0x1c01
      48:	1f000000 	svcne	0x00000000
      4c:	000080b4 	strheq	r8, [r0], -r4
      50:	00000018 	andeq	r0, r0, r8, lsl r0
      54:	26019c01 	strcs	r9, [r1], -r1, lsl #24
      58:	1a000000 	bne	60 <shift+0x60>
      5c:	0000809c 	muleq	r0, ip, r0
      60:	00000018 	andeq	r0, r0, r8, lsl r0
      64:	03079c01 	movweq	r9, #31745	; 0x7c01
      68:	01000001 	tsteq	r0, r1
      6c:	00b10b02 	adcseq	r0, r1, r2, lsl #22
      70:	14030000 	strne	r0, [r3], #-0
      74:	14000000 	strne	r0, [r0], #-0
      78:	00000082 	andeq	r0, r0, r2, lsl #1
      7c:	0000b102 	andeq	fp, r0, r2, lsl #2
      80:	46080000 	strmi	r0, [r8], -r0
      84:	01000001 	tsteq	r0, r1
      88:	00b71c04 	adcseq	r1, r7, r4, lsl #24
      8c:	00030000 	andeq	r0, r3, r0
      90:	0f000000 	svceq	0x00000000
      94:	0000009e 	muleq	r0, lr, r0
      98:	0000b102 	andeq	fp, r0, r2, lsl #2
      9c:	ef090000 	svc	0x00090000
      a0:	01000000 	mrseq	r0, (UNDEF: 0)
      a4:	00fa110a 	rscseq	r1, sl, sl, lsl #2
      a8:	b1020000 	mrslt	r0, (UNDEF: 2)
      ac:	00000000 	andeq	r0, r0, r0
      b0:	82040a00 	andhi	r0, r4, #0, 20
      b4:	0b000000 	bleq	bc <shift+0xbc>
      b8:	010e0508 	tsteq	lr, r8, lsl #10
      bc:	72040000 	andvc	r0, r4, #0
      c0:	7c000000 	stcvc	0, cr0, [r0], {-0}
      c4:	20000080 	andcs	r0, r0, r0, lsl #1
      c8:	01000000 	mrseq	r0, (UNDEF: 0)
      cc:	0000da9c 	muleq	r0, ip, sl
      d0:	00b10c00 	adcseq	r0, r1, r0, lsl #24
      d4:	91020000 	mrsls	r0, (UNDEF: 2)
      d8:	8e040074 	mcrhi	0, 0, r0, cr4, cr4, {3}
      dc:	50000000 	andpl	r0, r0, r0
      e0:	2c000080 	stccs	0, cr0, [r0], {128}	; 0x80
      e4:	01000000 	mrseq	r0, (UNDEF: 0)
      e8:	0000fa9c 	muleq	r0, ip, sl
      ec:	00670500 	rsbeq	r0, r7, r0, lsl #10
      f0:	00b1300f 	adcseq	r3, r1, pc
      f4:	91020000 	mrsls	r0, (UNDEF: 2)
      f8:	040d0074 	streq	r0, [sp], #-116	; 0xffffff8c
      fc:	746e6905 	strbtvc	r6, [lr], #-2309	; 0xfffff6fb
     100:	009e0e00 	addseq	r0, lr, r0, lsl #28
     104:	80180000 	andshi	r0, r8, r0
     108:	00380000 	eorseq	r0, r8, r0
     10c:	9c010000 	stcls	0, cr0, [r1], {-0}
     110:	0a006705 	beq	19d2c <_bss_end+0x1102c>
     114:	0000b12f 	andeq	fp, r0, pc, lsr #2
     118:	74910200 	ldrvc	r0, [r1], #512	; 0x200
     11c:	06380000 	ldrteq	r0, [r8], -r0
     120:	00050000 	andeq	r0, r5, r0
     124:	00d40401 	sbcseq	r0, r4, r1, lsl #8
     128:	6e120000 	cdpvs	0, 1, cr0, cr2, cr0, {0}
     12c:	21000000 	mrscs	r0, (UNDEF: 0)
     130:	00000456 	andeq	r0, r0, r6, asr r4
     134:	00000040 	andeq	r0, r0, r0, asr #32
     138:	000080f0 	strdeq	r8, [r0], -r0
     13c:	00000510 	andeq	r0, r0, r0, lsl r5
     140:	0000008e 	andeq	r0, r0, lr, lsl #1
     144:	25080105 	strcs	r0, [r8, #-261]	; 0xfffffefb
     148:	05000003 	streq	r0, [r0, #-3]
     14c:	050d0502 	streq	r0, [sp, #-1282]	; 0xfffffafe
     150:	04130000 	ldreq	r0, [r3], #-0
     154:	746e6905 	strbtvc	r6, [lr], #-2309	; 0xfffff6fb
     158:	04200f00 	strteq	r0, [r0], #-3840	; 0xfffff100
     15c:	45090000 	strmi	r0, [r9, #-0]
     160:	05000000 	streq	r0, [r0, #-0]
     164:	031c0801 	tsteq	ip, #65536	; 0x10000
     168:	02050000 	andeq	r0, r5, #0
     16c:	00035607 	andeq	r5, r3, r7, lsl #12
     170:	05170f00 	ldreq	r0, [r7, #-3840]	; 0xfffff100
     174:	620b0000 	andvs	r0, fp, #0
     178:	08000000 	stmdaeq	r0, {}	; <UNPREDICTABLE>
     17c:	00000053 	andeq	r0, r0, r3, asr r0
     180:	4f070405 	svcmi	0x00070405
     184:	1400000b 	strne	r0, [r0], #-11
     188:	006c6168 	rsbeq	r6, ip, r8, ror #2
     18c:	5c0b0703 	stcpl	7, cr0, [fp], {3}
     190:	10000001 	andne	r0, r0, r1
     194:	000003e1 	andeq	r0, r0, r1, ror #7
     198:	0001630a 	andeq	r6, r1, sl, lsl #6
     19c:	00000000 	andeq	r0, r0, r0
     1a0:	05b61020 	ldreq	r1, [r6, #32]!
     1a4:	630d0000 	movwvs	r0, #53248	; 0xd000
     1a8:	00000001 	andeq	r0, r0, r1
     1ac:	15202000 	strne	r2, [r0, #-0]!
     1b0:	00000369 	andeq	r0, r0, r9, ror #6
     1b4:	5d151003 	ldcpl	0, cr1, [r5, #-12]
     1b8:	36000000 	strcc	r0, [r0], -r0
     1bc:	0002ef16 	andeq	lr, r2, r6, lsl pc
     1c0:	34040500 	strcc	r0, [r4], #-1280	; 0xfffffb00
     1c4:	03000000 	movweq	r0, #0
     1c8:	96010d13 			; <UNDEFINED> instruction: 0x96010d13
     1cc:	00000005 	andeq	r0, r0, r5
     1d0:	00059e01 	andeq	r9, r5, r1, lsl #28
     1d4:	a6010100 	strge	r0, [r1], -r0, lsl #2
     1d8:	02000005 	andeq	r0, r0, #5
     1dc:	0005ae01 	andeq	sl, r5, r1, lsl #28
     1e0:	d9010300 	stmdble	r1, {r8, r9}
     1e4:	04000003 	streq	r0, [r0], #-3
     1e8:	0005c001 	andeq	ip, r5, r1
     1ec:	78010500 	stmdavc	r1, {r8, sl}
     1f0:	07000003 	streq	r0, [r0, -r3]
     1f4:	00037f01 	andeq	r7, r3, r1, lsl #30
     1f8:	4f010800 	svcmi	0x00010800
     1fc:	0a000003 	beq	210 <shift+0x210>
     200:	00027201 	andeq	r7, r2, r1, lsl #4
     204:	f8010b00 			; <UNDEFINED> instruction: 0xf8010b00
     208:	0d000002 	stceq	0, cr0, [r0, #-8]
     20c:	0002ff01 	andeq	pc, r2, r1, lsl #30
     210:	02010e00 	andeq	r0, r1, #0, 28
     214:	10000004 	andne	r0, r0, r4
     218:	00040901 	andeq	r0, r4, r1, lsl #18
     21c:	89011100 	stmdbhi	r1, {r8, ip}
     220:	13000001 	movwne	r0, #1
     224:	00019001 	andeq	r9, r1, r1
     228:	c6011400 	strgt	r1, [r1], -r0, lsl #8
     22c:	16000003 	strne	r0, [r0], -r3
     230:	0003cd01 	andeq	ip, r3, r1, lsl #26
     234:	25011700 	strcs	r1, [r1, #-1792]	; 0xfffff900
     238:	19000005 	stmdbne	r0, {r0, r2}
     23c:	00052c01 	andeq	r2, r5, r1, lsl #24
     240:	f7011a00 			; <UNDEFINED> instruction: 0xf7011a00
     244:	1c000004 	stcne	0, cr0, [r0], {4}
     248:	0004fe01 	andeq	pc, r4, r1, lsl #28
     24c:	10011d00 	andne	r1, r1, r0, lsl #26
     250:	1f000004 	svcne	0x00000004
     254:	00041801 	andeq	r1, r4, r1, lsl #16
     258:	ef012000 	svc	0x00012000
     25c:	22000004 	andcs	r0, r0, #4
     260:	00019701 	andeq	r9, r1, r1, lsl #14
     264:	16012300 	strne	r2, [r1], -r0, lsl #6
     268:	25000003 	strcs	r0, [r0, #-3]
     26c:	0002e501 	andeq	lr, r2, r1, lsl #10
     270:	0c012600 	stceq	6, cr2, [r1], {-0}
     274:	27000003 	strcs	r0, [r0, -r3]
     278:	04050000 	streq	r0, [r5], #-0
     27c:	000b4a07 	andeq	r4, fp, r7, lsl #20
     280:	015c0800 	cmpeq	ip, r0, lsl #16
     284:	750c0000 	strvc	r0, [ip, #-0]
     288:	0c000000 	stceq	0, cr0, [r0], {-0}
     28c:	00000083 	andeq	r0, r0, r3, lsl #1
     290:	0000910c 	andeq	r9, r0, ip, lsl #2
     294:	04e01700 	strbteq	r1, [r0], #1792	; 0x700
     298:	01070000 	mrseq	r0, (UNDEF: 7)
     29c:	0000003b 	andeq	r0, r0, fp, lsr r0
     2a0:	c00c0604 	andgt	r0, ip, r4, lsl #12
     2a4:	01000001 	tsteq	r0, r1
     2a8:	000003f1 	strdeq	r0, [r0], -r1
     2ac:	01b10100 			; <UNDEFINED> instruction: 0x01b10100
     2b0:	01010000 	mrseq	r0, (UNDEF: 1)
     2b4:	0000038c 	andeq	r0, r0, ip, lsl #7
     2b8:	03860102 	orreq	r0, r6, #-2147483648	; 0x80000000
     2bc:	01030000 	mrseq	r0, (UNDEF: 3)
     2c0:	00000330 	andeq	r0, r0, r0, lsr r3
     2c4:	03490104 	movteq	r0, #37124	; 0x9104
     2c8:	01050000 	mrseq	r0, (UNDEF: 5)
     2cc:	0000032a 	andeq	r0, r0, sl, lsr #6
     2d0:	03060106 	movweq	r0, #24838	; 0x6106
     2d4:	01070000 	mrseq	r0, (UNDEF: 7)
     2d8:	000001b8 			; <UNDEFINED> instruction: 0x000001b8
     2dc:	9f180008 	svcls	0x00180008
     2e0:	04000001 	streq	r0, [r0], #-1
     2e4:	1b071a04 	blne	1c6afc <_bss_end+0x1bddfc>
     2e8:	19000003 	stmdbne	r0, {r0, r1}
     2ec:	000004b1 			; <UNDEFINED> instruction: 0x000004b1
     2f0:	25171e04 	ldrcs	r1, [r7, #-3588]	; 0xfffff1fc
     2f4:	00000003 	andeq	r0, r0, r3
     2f8:	00028e09 	andeq	r8, r2, r9, lsl #28
     2fc:	a2082200 	andge	r2, r8, #0, 4
     300:	2a000002 	bcs	310 <shift+0x310>
     304:	02000003 	andeq	r0, r0, #3
     308:	000001f2 	strdeq	r0, [r0], -r2
     30c:	00000207 	andeq	r0, r0, r7, lsl #4
     310:	00033104 	andeq	r3, r3, r4, lsl #2
     314:	00530200 	subseq	r0, r3, r0, lsl #4
     318:	3b020000 	blcc	80320 <_bss_end+0x77620>
     31c:	02000003 	andeq	r0, r0, #3
     320:	0000033b 	andeq	r0, r0, fp, lsr r3
     324:	03360900 	teqeq	r6, #0, 18
     328:	08240000 	stmdaeq	r4!, {}	; <UNPREDICTABLE>
     32c:	00000243 	andeq	r0, r0, r3, asr #4
     330:	0000032a 	andeq	r0, r0, sl, lsr #6
     334:	00021f02 	andeq	r1, r2, r2, lsl #30
     338:	00023400 	andeq	r3, r2, r0, lsl #8
     33c:	03310400 	teqeq	r1, #0, 8
     340:	53020000 	movwpl	r0, #8192	; 0x2000
     344:	02000000 	andeq	r0, r0, #0
     348:	0000033b 	andeq	r0, r0, fp, lsr r3
     34c:	00033b02 	andeq	r3, r3, r2, lsl #22
     350:	d2090000 	andle	r0, r9, #0
     354:	26000002 	strcs	r0, [r0], -r2
     358:	00021408 	andeq	r1, r2, r8, lsl #8
     35c:	00032a00 	andeq	r2, r3, r0, lsl #20
     360:	024c0200 	subeq	r0, ip, #0, 4
     364:	02610000 	rsbeq	r0, r1, #0
     368:	31040000 	mrscc	r0, (UNDEF: 4)
     36c:	02000003 	andeq	r0, r0, #3
     370:	00000053 	andeq	r0, r0, r3, asr r0
     374:	00033b02 	andeq	r3, r3, r2, lsl #22
     378:	033b0200 	teqeq	fp, #0, 4
     37c:	09000000 	stmdbeq	r0, {}	; <UNPREDICTABLE>
     380:	00000559 	andeq	r0, r0, r9, asr r5
     384:	01d30828 	bicseq	r0, r3, r8, lsr #16
     388:	032a0000 			; <UNDEFINED> instruction: 0x032a0000
     38c:	79020000 	stmdbvc	r2, {}	; <UNPREDICTABLE>
     390:	8e000002 	cdphi	0, 0, cr0, cr0, cr2, {0}
     394:	04000002 	streq	r0, [r0], #-2
     398:	00000331 	andeq	r0, r0, r1, lsr r3
     39c:	00005302 	andeq	r5, r0, r2, lsl #6
     3a0:	033b0200 	teqeq	fp, #0, 4
     3a4:	3b020000 	blcc	803ac <_bss_end+0x776ac>
     3a8:	00000003 	andeq	r0, r0, r3
     3ac:	00019f09 	andeq	r9, r1, r9, lsl #30
     3b0:	42032b00 	andmi	r2, r3, #0, 22
     3b4:	41000005 	tstmi	r0, r5
     3b8:	01000003 	tsteq	r0, r3
     3bc:	000002a6 	andeq	r0, r0, r6, lsr #5
     3c0:	000002b1 			; <UNDEFINED> instruction: 0x000002b1
     3c4:	00034104 	andeq	r4, r3, r4, lsl #2
     3c8:	00620200 	rsbeq	r0, r2, r0, lsl #4
     3cc:	1a000000 	bne	3d4 <shift+0x3d4>
     3d0:	000003b4 			; <UNDEFINED> instruction: 0x000003b4
     3d4:	b7082e04 	strlt	r2, [r8, -r4, lsl #28]
     3d8:	01000004 	tsteq	r0, r4
     3dc:	000002c6 	andeq	r0, r0, r6, asr #5
     3e0:	000002d6 	ldrdeq	r0, [r0], -r6
     3e4:	00034104 	andeq	r4, r3, r4, lsl #2
     3e8:	00530200 	subseq	r0, r3, r0, lsl #4
     3ec:	77020000 	strvc	r0, [r2, -r0]
     3f0:	00000001 	andeq	r0, r0, r1
     3f4:	00020209 	andeq	r0, r2, r9, lsl #4
     3f8:	2d123000 	ldccs	0, cr3, [r2, #-0]
     3fc:	77000004 	strvc	r0, [r0, -r4]
     400:	01000001 	tsteq	r0, r1
     404:	000002ee 	andeq	r0, r0, lr, ror #5
     408:	000002f9 	strdeq	r0, [r0], -r9
     40c:	00033104 	andeq	r3, r3, r4, lsl #2
     410:	00530200 	subseq	r0, r3, r0, lsl #4
     414:	1b000000 	blne	41c <shift+0x41c>
     418:	000001ad 	andeq	r0, r0, sp, lsr #3
     41c:	92083304 	andls	r3, r8, #4, 6	; 0x10000000
     420:	01000003 	tsteq	r0, r3
     424:	0000030a 	andeq	r0, r0, sl, lsl #6
     428:	00034104 	andeq	r4, r3, r4, lsl #2
     42c:	00530200 	subseq	r0, r3, r0, lsl #4
     430:	2a020000 	bcs	80438 <_bss_end+0x77738>
     434:	00000003 	andeq	r0, r0, r3
     438:	01c00800 	biceq	r0, r0, r0, lsl #16
     43c:	620d0000 	andvs	r0, sp, #0
     440:	08000000 	stmdaeq	r0, {}	; <UNPREDICTABLE>
     444:	00000320 	andeq	r0, r0, r0, lsr #6
     448:	20020105 	andcs	r0, r2, r5, lsl #2
     44c:	0d000005 	stceq	0, cr0, [r0, #-20]	; 0xffffffec
     450:	0000031b 	andeq	r0, r0, fp, lsl r3
     454:	00033108 	andeq	r3, r3, r8, lsl #2
     458:	53041c00 	movwpl	r1, #19456	; 0x4c00
     45c:	0d000000 	stceq	0, cr0, [r0, #-0]
     460:	000001c0 	andeq	r0, r0, r0, asr #3
     464:	00034108 	andeq	r4, r3, r8, lsl #2
     468:	02881d00 	addeq	r1, r8, #0, 26
     46c:	37040000 	strcc	r0, [r4, -r0]
     470:	0001c016 	andeq	ip, r1, r6, lsl r0
     474:	034b1e00 	movteq	r1, #48640	; 0xbe00
     478:	04010000 	streq	r0, [r1], #-0
     47c:	dc03050f 	cfstr32le	mvfx0, [r3], {15}
     480:	1f00008c 	svcne	0x0000008c
     484:	00000279 	andeq	r0, r0, r9, ror r2
     488:	000085e4 	andeq	r8, r0, r4, ror #11
     48c:	0000001c 	andeq	r0, r0, ip, lsl r0
     490:	6c209c01 	stcvs	12, cr9, [r0], #-4
     494:	90000005 	andls	r0, r0, r5
     498:	54000085 	strpl	r0, [r0], #-133	; 0xffffff7b
     49c:	01000000 	mrseq	r0, (UNDEF: 0)
     4a0:	0003a49c 	muleq	r3, ip, r4
     4a4:	05330600 	ldreq	r0, [r3, #-1536]!	; 0xfffffa00
     4a8:	015b0000 	cmpeq	fp, r0
     4ac:	00000034 	andeq	r0, r0, r4, lsr r0
     4b0:	06749102 	ldrbteq	r9, [r4], -r2, lsl #2
     4b4:	000003f7 	strdeq	r0, [r0], -r7
     4b8:	0034015b 	eorseq	r0, r4, fp, asr r1
     4bc:	91020000 	mrsls	r0, (UNDEF: 2)
     4c0:	f90e0070 			; <UNDEFINED> instruction: 0xf90e0070
     4c4:	54000002 	strpl	r0, [r0], #-2
     4c8:	0003bd06 	andeq	fp, r3, r6, lsl #26
     4cc:	0084b800 	addeq	fp, r4, r0, lsl #16
     4d0:	0000d800 	andeq	sp, r0, r0, lsl #16
     4d4:	029c0100 	addseq	r0, ip, #0, 2
     4d8:	07000004 	streq	r0, [r0, -r4]
     4dc:	00000428 	andeq	r0, r0, r8, lsr #8
     4e0:	00000346 	andeq	r0, r0, r6, asr #6
     4e4:	036c9102 	cmneq	ip, #-2147483648	; 0x80000000
     4e8:	006e6970 	rsbeq	r6, lr, r0, ror r9
     4ec:	00532954 	subseq	r2, r3, r4, asr r9
     4f0:	91020000 	mrsls	r0, (UNDEF: 2)
     4f4:	65730368 	ldrbvs	r0, [r3, #-872]!	; 0xfffffc98
     4f8:	33540074 	cmpcc	r4, #116	; 0x74
     4fc:	0000032a 	andeq	r0, r0, sl, lsr #6
     500:	0a679102 	beq	19e4910 <_bss_end+0x19dbc10>
     504:	00676572 	rsbeq	r6, r7, r2, ror r5
     508:	00530b56 	subseq	r0, r3, r6, asr fp
     50c:	91020000 	mrsls	r0, (UNDEF: 2)
     510:	69620a74 	stmdbvs	r2!, {r2, r4, r5, r6, r9, fp}^
     514:	10560074 	subsne	r0, r6, r4, ror r0
     518:	00000053 	andeq	r0, r0, r3, asr r0
     51c:	00709102 	rsbseq	r9, r0, r2, lsl #2
     520:	0002d60e 	andeq	sp, r2, lr, lsl #12
     524:	1b104b00 	blne	41312c <_bss_end+0x40a42c>
     528:	3c000004 	stccc	0, cr0, [r0], {4}
     52c:	7c000084 	stcvc	0, cr0, [r0], {132}	; 0x84
     530:	01000000 	mrseq	r0, (UNDEF: 0)
     534:	0004529c 	muleq	r4, ip, r2
     538:	04280700 	strteq	r0, [r8], #-1792	; 0xfffff900
     53c:	03360000 	teqeq	r6, #0
     540:	91020000 	mrsls	r0, (UNDEF: 2)
     544:	6970036c 	ldmdbvs	r0!, {r2, r3, r5, r6, r8, r9}^
     548:	3a4b006e 	bcc	12c0708 <_bss_end+0x12b7a08>
     54c:	00000053 	andeq	r0, r0, r3, asr r0
     550:	0a689102 	beq	1a24960 <_bss_end+0x1a1bc60>
     554:	00676572 	rsbeq	r6, r7, r2, ror r5
     558:	00530b4d 	subseq	r0, r3, sp, asr #22
     55c:	91020000 	mrsls	r0, (UNDEF: 2)
     560:	69620a74 	stmdbvs	r2!, {r2, r4, r5, r6, r9, fp}^
     564:	104d0074 	subne	r0, sp, r4, ror r0
     568:	00000053 	andeq	r0, r0, r3, asr r0
     56c:	00709102 	rsbseq	r9, r0, r2, lsl #2
     570:	0002b10e 	andeq	fp, r2, lr, lsl #2
     574:	6b064100 	blvs	19097c <_bss_end+0x187c7c>
     578:	94000004 	strls	r0, [r0], #-4
     57c:	a8000083 	stmdage	r0, {r0, r1, r7}
     580:	01000000 	mrseq	r0, (UNDEF: 0)
     584:	0004b09c 	muleq	r4, ip, r0
     588:	04280700 	strteq	r0, [r8], #-1792	; 0xfffff900
     58c:	03460000 	movteq	r0, #24576	; 0x6000
     590:	91020000 	mrsls	r0, (UNDEF: 2)
     594:	6970036c 	ldmdbvs	r0!, {r2, r3, r5, r6, r8, r9}^
     598:	3041006e 	subcc	r0, r1, lr, rrx
     59c:	00000053 	andeq	r0, r0, r3, asr r0
     5a0:	06689102 	strbteq	r9, [r8], -r2, lsl #2
     5a4:	000003d4 	ldrdeq	r0, [r0], -r4
     5a8:	01774441 	cmneq	r7, r1, asr #8
     5ac:	91020000 	mrsls	r0, (UNDEF: 2)
     5b0:	65720a67 	ldrbvs	r0, [r2, #-2663]!	; 0xfffff599
     5b4:	0b430067 	bleq	10c0758 <_bss_end+0x10b7a58>
     5b8:	00000053 	andeq	r0, r0, r3, asr r0
     5bc:	0a749102 	beq	1d249cc <_bss_end+0x1d1bccc>
     5c0:	00746962 	rsbseq	r6, r4, r2, ror #18
     5c4:	00531043 	subseq	r1, r3, r3, asr #32
     5c8:	91020000 	mrsls	r0, (UNDEF: 2)
     5cc:	610b0070 	tstvs	fp, r0, ror r0
     5d0:	36000002 	strcc	r0, [r0], -r2
     5d4:	000004c8 	andeq	r0, r0, r8, asr #9
     5d8:	00008320 	andeq	r8, r0, r0, lsr #6
     5dc:	00000074 	andeq	r0, r0, r4, ror r0
     5e0:	04ff9c01 	ldrbteq	r9, [pc], #3073	; 5e8 <shift+0x5e8>
     5e4:	28070000 	stmdacs	r7, {}	; <UNPREDICTABLE>
     5e8:	36000004 	strcc	r0, [r0], -r4
     5ec:	02000003 	andeq	r0, r0, #3
     5f0:	70037491 	mulvc	r3, r1, r4
     5f4:	36006e69 	strcc	r6, [r0], -r9, ror #28
     5f8:	00005331 	andeq	r5, r0, r1, lsr r3
     5fc:	70910200 	addsvc	r0, r1, r0, lsl #4
     600:	67657203 	strbvs	r7, [r5, -r3, lsl #4]!
     604:	3b403600 	blcc	100de0c <_bss_end+0x100510c>
     608:	02000003 	andeq	r0, r0, #3
     60c:	05066c91 	streq	r6, [r6, #-3217]	; 0xfffff36f
     610:	36000005 	strcc	r0, [r0], -r5
     614:	00033b4f 	andeq	r3, r3, pc, asr #22
     618:	68910200 	ldmvs	r1, {r9}
     61c:	02340b00 	eorseq	r0, r4, #0, 22
     620:	172b0000 	strne	r0, [fp, -r0]!
     624:	ac000005 	stcge	0, cr0, [r0], {5}
     628:	74000082 	strvc	r0, [r0], #-130	; 0xffffff7e
     62c:	01000000 	mrseq	r0, (UNDEF: 0)
     630:	00054e9c 	muleq	r5, ip, lr
     634:	04280700 	strteq	r0, [r8], #-1792	; 0xfffff900
     638:	03360000 	teqeq	r6, #0
     63c:	91020000 	mrsls	r0, (UNDEF: 2)
     640:	69700374 	ldmdbvs	r0!, {r2, r4, r5, r6, r8, r9}^
     644:	312b006e 			; <UNDEFINED> instruction: 0x312b006e
     648:	00000053 	andeq	r0, r0, r3, asr r0
     64c:	03709102 	cmneq	r0, #-2147483648	; 0x80000000
     650:	00676572 	rsbeq	r6, r7, r2, ror r5
     654:	033b402b 	teqeq	fp, #43	; 0x2b
     658:	91020000 	mrsls	r0, (UNDEF: 2)
     65c:	0505066c 	streq	r0, [r5, #-1644]	; 0xfffff994
     660:	4f2b0000 	svcmi	0x002b0000
     664:	0000033b 	andeq	r0, r0, fp, lsr r3
     668:	00689102 	rsbeq	r9, r8, r2, lsl #2
     66c:	0002070b 	andeq	r0, r2, fp, lsl #14
     670:	05662000 	strbeq	r2, [r6, #-0]!
     674:	82380000 	eorshi	r0, r8, #0
     678:	00740000 	rsbseq	r0, r4, r0
     67c:	9c010000 	stcls	0, cr0, [r1], {-0}
     680:	0000059d 	muleq	r0, sp, r5
     684:	00042807 	andeq	r2, r4, r7, lsl #16
     688:	00033600 	andeq	r3, r3, r0, lsl #12
     68c:	74910200 	ldrvc	r0, [r1], #512	; 0x200
     690:	6e697003 	cdpvs	0, 6, cr7, cr9, cr3, {0}
     694:	53312000 	teqpl	r1, #0
     698:	02000000 	andeq	r0, r0, #0
     69c:	72037091 	andvc	r7, r3, #145	; 0x91
     6a0:	20006765 	andcs	r6, r0, r5, ror #14
     6a4:	00033b40 	andeq	r3, r3, r0, asr #22
     6a8:	6c910200 	lfmvs	f0, 4, [r1], {0}
     6ac:	00050506 	andeq	r0, r5, r6, lsl #10
     6b0:	3b4f2000 	blcc	13c86b8 <_bss_end+0x13bf9b8>
     6b4:	02000003 	andeq	r0, r0, #3
     6b8:	0b006891 	bleq	1a904 <_bss_end+0x11c04>
     6bc:	000001da 	ldrdeq	r0, [r0], -sl
     6c0:	0005b50c 	andeq	fp, r5, ip, lsl #10
     6c4:	00812400 	addeq	r2, r1, r0, lsl #8
     6c8:	00011400 	andeq	r1, r1, r0, lsl #8
     6cc:	ec9c0100 	ldfs	f0, [ip], {0}
     6d0:	07000005 	streq	r0, [r0, -r5]
     6d4:	00000428 	andeq	r0, r0, r8, lsr #8
     6d8:	00000336 	andeq	r0, r0, r6, lsr r3
     6dc:	03749102 	cmneq	r4, #-2147483648	; 0x80000000
     6e0:	006e6970 	rsbeq	r6, lr, r0, ror r9
     6e4:	0053320c 	subseq	r3, r3, ip, lsl #4
     6e8:	91020000 	mrsls	r0, (UNDEF: 2)
     6ec:	65720370 	ldrbvs	r0, [r2, #-880]!	; 0xfffffc90
     6f0:	410c0067 	tstmi	ip, r7, rrx
     6f4:	0000033b 	andeq	r0, r0, fp, lsr r3
     6f8:	066c9102 	strbteq	r9, [ip], -r2, lsl #2
     6fc:	00000505 	andeq	r0, r0, r5, lsl #10
     700:	033b500c 	teqeq	fp, #12
     704:	91020000 	mrsls	r0, (UNDEF: 2)
     708:	8e210068 	cdphi	0, 2, cr0, cr1, cr8, {3}
     70c:	01000002 	tsteq	r0, r2
     710:	05fd0106 	ldrbeq	r0, [sp, #262]!	; 0x106
     714:	13000000 	movwne	r0, #0
     718:	22000006 	andcs	r0, r0, #6
     71c:	00000428 	andeq	r0, r0, r8, lsr #8
     720:	00000346 	andeq	r0, r0, r6, asr #6
     724:	0001c423 	andeq	ip, r1, r3, lsr #8
     728:	2b060100 	blcs	180b30 <_bss_end+0x177e30>
     72c:	00000062 	andeq	r0, r0, r2, rrx
     730:	05ec2400 	strbeq	r2, [ip, #1024]!	; 0x400
     734:	049a0000 	ldreq	r0, [sl], #0
     738:	062a0000 	strteq	r0, [sl], -r0
     73c:	80f00000 	rscshi	r0, r0, r0
     740:	00340000 	eorseq	r0, r4, r0
     744:	9c010000 	stcls	0, cr0, [r1], {-0}
     748:	0005fd11 	andeq	pc, r5, r1, lsl sp	; <UNPREDICTABLE>
     74c:	74910200 	ldrvc	r0, [r1], #512	; 0x200
     750:	00060611 	andeq	r0, r6, r1, lsl r6
     754:	70910200 	addsvc	r0, r1, r0, lsl #4
     758:	028d0000 	addeq	r0, sp, #0
     75c:	00050000 	andeq	r0, r5, r0
     760:	03250401 			; <UNDEFINED> instruction: 0x03250401
     764:	6e0d0000 	cdpvs	0, 0, cr0, cr13, cr0, {0}
     768:	21000000 	mrscs	r0, (UNDEF: 0)
     76c:	00000636 	andeq	r0, r0, r6, lsr r6
     770:	00000040 	andeq	r0, r0, r0, asr #32
     774:	00008600 	andeq	r8, r0, r0, lsl #12
     778:	000001e0 	andeq	r0, r0, r0, ror #3
     77c:	00000353 	andeq	r0, r0, r3, asr r3
     780:	25080101 	strcs	r0, [r8, #-257]	; 0xfffffeff
     784:	01000003 	tsteq	r0, r3
     788:	050d0502 	streq	r0, [sp, #-1282]	; 0xfffffafe
     78c:	040e0000 	streq	r0, [lr], #-0
     790:	746e6905 	strbtvc	r6, [lr], #-2309	; 0xfffff6fb
     794:	00340700 	eorseq	r0, r4, r0, lsl #14
     798:	01010000 	mrseq	r0, (UNDEF: 1)
     79c:	00031c08 	andeq	r1, r3, r8, lsl #24
     7a0:	07020100 	streq	r0, [r2, -r0, lsl #2]
     7a4:	00000356 	andeq	r0, r0, r6, asr r3
     7a8:	4f070401 	svcmi	0x00070401
     7ac:	0f00000b 	svceq	0x0000000b
     7b0:	0047434c 	subeq	r4, r7, ip, asr #6
     7b4:	07060210 	smladeq	r6, r0, r2, r0
     7b8:	00000124 	andeq	r0, r0, r4, lsr #2
     7bc:	13006103 	movwne	r6, #259	; 0x103
     7c0:	0000003b 	andeq	r0, r0, fp, lsr r0
     7c4:	00630300 	rsbeq	r0, r3, r0, lsl #6
     7c8:	00003b20 	andeq	r3, r0, r0, lsr #22
     7cc:	6d030400 	cfstrsvs	mvf0, [r3, #-0]
     7d0:	2e00646f 	cdpcs	4, 0, cr6, cr0, cr15, {3}
     7d4:	0000003b 	andeq	r0, r0, fp, lsr r0
     7d8:	067b1008 	ldrbteq	r1, [fp], -r8
     7dc:	0a020000 	beq	807e4 <_bss_end+0x77ae4>
     7e0:	0000340d 	andeq	r3, r0, sp, lsl #8
     7e4:	4c080c00 	stcmi	12, cr0, [r8], {-0}
     7e8:	0d004743 	stceq	7, cr4, [r0, #-268]	; 0xfffffef4
     7ec:	00000680 	andeq	r0, r0, r0, lsl #13
     7f0:	00000124 	andeq	r0, r0, r4, lsr #2
     7f4:	000000a2 	andeq	r0, r0, r2, lsr #1
     7f8:	000000a8 	andeq	r0, r0, r8, lsr #1
     7fc:	00012402 	andeq	r2, r1, r2, lsl #8
     800:	4c080000 	stcmi	0, cr0, [r8], {-0}
     804:	0e004743 	cdpeq	7, 0, cr4, cr0, cr3, {2}
     808:	0000062a 	andeq	r0, r0, sl, lsr #12
     80c:	00000124 	andeq	r0, r0, r4, lsr #2
     810:	000000be 	strheq	r0, [r0], -lr
     814:	000000c9 	andeq	r0, r0, r9, asr #1
     818:	00012402 	andeq	r2, r1, r2, lsl #8
     81c:	00340900 	eorseq	r0, r4, r0, lsl #18
     820:	11000000 	mrsne	r0, (UNDEF: 0)
     824:	00000602 	andeq	r0, r0, r2, lsl #12
     828:	0b0e1002 	bleq	384838 <_bss_end+0x37bb38>
     82c:	01000006 	tsteq	r0, r6
     830:	000000de 	ldrdeq	r0, [r0], -lr
     834:	000000e9 	andeq	r0, r0, r9, ror #1
     838:	00012402 	andeq	r2, r1, r2, lsl #8
     83c:	00340900 	eorseq	r0, r4, r0, lsl #18
     840:	12000000 	andne	r0, r0, #0
     844:	000006a8 	andeq	r0, r0, r8, lsr #13
     848:	c80d1102 	stmdagt	sp, {r1, r8, ip}
     84c:	34000005 	strcc	r0, [r0], #-5
     850:	01000000 	mrseq	r0, (UNDEF: 0)
     854:	00000102 	andeq	r0, r0, r2, lsl #2
     858:	00000108 	andeq	r0, r0, r8, lsl #2
     85c:	00012402 	andeq	r2, r1, r2, lsl #8
     860:	8c130000 	ldchi	0, cr0, [r3], {-0}
     864:	02000006 	andeq	r0, r0, #6
     868:	06950d12 			; <UNDEFINED> instruction: 0x06950d12
     86c:	00340000 	eorseq	r0, r4, r0
     870:	1d010000 	stcne	0, cr0, [r1, #-0]
     874:	02000001 	andeq	r0, r0, #1
     878:	00000124 	andeq	r0, r0, r4, lsr #2
     87c:	04140000 	ldreq	r0, [r4], #-0
     880:	00000055 	andeq	r0, r0, r5, asr r0
     884:	00012407 	andeq	r2, r1, r7, lsl #8
     888:	05ea1500 	strbeq	r1, [sl, #1280]!	; 0x500
     88c:	15020000 	strne	r0, [r2, #-0]
     890:	0000550c 	andeq	r5, r0, ip, lsl #10
     894:	012f1600 			; <UNDEFINED> instruction: 0x012f1600
     898:	03010000 	movweq	r0, #4096	; 0x1000
     89c:	e0030505 	and	r0, r3, r5, lsl #10
     8a0:	1700008c 	strne	r0, [r0, -ip, lsl #1]
     8a4:	000005db 	ldrdeq	r0, [r0], -fp
     8a8:	000087c4 	andeq	r8, r0, r4, asr #15
     8ac:	0000001c 	andeq	r0, r0, ip, lsl r0
     8b0:	6c189c01 	ldcvs	12, cr9, [r8], {1}
     8b4:	78000005 	stmdavc	r0, {r0, r2}
     8b8:	4c000087 	stcmi	0, cr0, [r0], {135}	; 0x87
     8bc:	01000000 	mrseq	r0, (UNDEF: 0)
     8c0:	0001889c 	muleq	r1, ip, r8
     8c4:	05330400 	ldreq	r0, [r3, #-1024]!	; 0xfffffc00
     8c8:	01150000 	tsteq	r5, r0
     8cc:	00000034 	andeq	r0, r0, r4, lsr r0
     8d0:	04749102 	ldrbteq	r9, [r4], #-258	; 0xfffffefe
     8d4:	000003f7 	strdeq	r0, [r0], -r7
     8d8:	00340115 	eorseq	r0, r4, r5, lsl r1
     8dc:	91020000 	mrsls	r0, (UNDEF: 2)
     8e0:	08190070 	ldmdaeq	r9, {r4, r5, r6}
     8e4:	01000001 	tsteq	r0, r1
     8e8:	0001a105 	andeq	sl, r1, r5, lsl #2
     8ec:	00871000 	addeq	r1, r7, r0
     8f0:	00006800 	andeq	r6, r0, r0, lsl #16
     8f4:	ae9c0100 	fmlgee	f0, f4, f0
     8f8:	05000001 	streq	r0, [r0, #-1]
     8fc:	00000428 	andeq	r0, r0, r8, lsr #8
     900:	0000012a 	andeq	r0, r0, sl, lsr #2
     904:	00749102 	rsbseq	r9, r4, r2, lsl #2
     908:	0000e90a 	andeq	lr, r0, sl, lsl #18
     90c:	c7050e00 	strgt	r0, [r5, -r0, lsl #28]
     910:	e8000001 	stmda	r0, {r0}
     914:	28000086 	stmdacs	r0, {r1, r2, r7}
     918:	01000000 	mrseq	r0, (UNDEF: 0)
     91c:	0001d49c 	muleq	r1, ip, r4
     920:	04280500 	strteq	r0, [r8], #-1280	; 0xfffffb00
     924:	012a0000 			; <UNDEFINED> instruction: 0x012a0000
     928:	91020000 	mrsls	r0, (UNDEF: 2)
     92c:	c90a0074 	stmdbgt	sl, {r2, r4, r5, r6}
     930:	0a000000 	beq	938 <shift+0x938>
     934:	0001ed06 	andeq	lr, r1, r6, lsl #26
     938:	0086b800 	addeq	fp, r6, r0, lsl #16
     93c:	00003000 	andeq	r3, r0, r0
     940:	089c0100 	ldmeq	ip, {r8}
     944:	05000002 	streq	r0, [r0, #-2]
     948:	00000428 	andeq	r0, r0, r8, lsr #8
     94c:	0000012a 	andeq	r0, r0, sl, lsr #2
     950:	04749102 	ldrbteq	r9, [r4], #-258	; 0xfffffefe
     954:	00000679 	andeq	r0, r0, r9, ror r6
     958:	0034180a 	eorseq	r1, r4, sl, lsl #16
     95c:	91020000 	mrsls	r0, (UNDEF: 2)
     960:	a80b0070 	stmdage	fp, {r4, r5, r6}
     964:	06000000 	streq	r0, [r0], -r0
     968:	00000216 	andeq	r0, r0, r6, lsl r2
     96c:	0000022c 	andeq	r0, r0, ip, lsr #4
     970:	0004280c 	andeq	r2, r4, ip, lsl #16
     974:	00012a00 	andeq	r2, r1, r0, lsl #20
     978:	06791a00 	ldrbteq	r1, [r9], -r0, lsl #20
     97c:	06010000 	streq	r0, [r1], -r0
     980:	0000340e 	andeq	r3, r0, lr, lsl #8
     984:	081b0000 	ldmdaeq	fp, {}	; <UNPREDICTABLE>
     988:	1e000002 	cdpne	0, 0, cr0, cr0, cr2, {0}
     98c:	47000006 	strmi	r0, [r0, -r6]
     990:	54000002 	strpl	r0, [r0], #-2
     994:	64000086 	strvs	r0, [r0], #-134	; 0xffffff7a
     998:	01000000 	mrseq	r0, (UNDEF: 0)
     99c:	0002589c 	muleq	r2, ip, r8
     9a0:	02160600 	andseq	r0, r6, #0, 12
     9a4:	91020000 	mrsls	r0, (UNDEF: 2)
     9a8:	021f0674 	andseq	r0, pc, #116, 12	; 0x7400000
     9ac:	91020000 	mrsls	r0, (UNDEF: 2)
     9b0:	8c0b0070 	stchi	0, cr0, [fp], {112}	; 0x70
     9b4:	05000000 	streq	r0, [r0, #-0]
     9b8:	00000266 	andeq	r0, r0, r6, ror #4
     9bc:	00000270 	andeq	r0, r0, r0, ror r2
     9c0:	0004280c 	andeq	r2, r4, ip, lsl #16
     9c4:	00012a00 	andeq	r2, r1, r0, lsl #20
     9c8:	581c0000 	ldmdapl	ip, {}	; <UNPREDICTABLE>
     9cc:	f6000002 			; <UNDEFINED> instruction: 0xf6000002
     9d0:	87000005 	strhi	r0, [r0, -r5]
     9d4:	00000002 	andeq	r0, r0, r2
     9d8:	54000086 	strpl	r0, [r0], #-134	; 0xffffff7a
     9dc:	01000000 	mrseq	r0, (UNDEF: 0)
     9e0:	0266069c 	rsbeq	r0, r6, #156, 12	; 0x9c00000
     9e4:	91020000 	mrsls	r0, (UNDEF: 2)
     9e8:	cf000074 	svcgt	0x00000074
     9ec:	05000003 	streq	r0, [r0, #-3]
     9f0:	06040100 	streq	r0, [r4], -r0, lsl #2
     9f4:	0e000005 	cdpeq	0, 0, cr0, cr0, cr5, {0}
     9f8:	0000006e 	andeq	r0, r0, lr, rrx
     9fc:	0006da21 	andeq	sp, r6, r1, lsr #20
     a00:	00004000 	andeq	r4, r0, r0
     a04:	0087e000 	addeq	lr, r7, r0
     a08:	00013400 	andeq	r3, r1, r0, lsl #8
     a0c:	00046900 	andeq	r6, r4, r0, lsl #18
     a10:	08010500 	stmdaeq	r1, {r8, sl}
     a14:	00000325 	andeq	r0, r0, r5, lsr #6
     a18:	0d050205 	sfmeq	f0, 4, [r5, #-20]	; 0xffffffec
     a1c:	0f000005 	svceq	0x00000005
     a20:	6e690504 	cdpvs	5, 6, cr0, cr9, cr4, {0}
     a24:	34060074 	strcc	r0, [r6], #-116	; 0xffffff8c
     a28:	09000000 	stmdbeq	r0, {}	; <UNPREDICTABLE>
     a2c:	00000420 	andeq	r0, r0, r0, lsr #8
     a30:	00004a09 	andeq	r4, r0, r9, lsl #20
     a34:	08010500 	stmdaeq	r1, {r8, sl}
     a38:	0000031c 	andeq	r0, r0, ip, lsl r3
     a3c:	56070205 	strpl	r0, [r7], -r5, lsl #4
     a40:	09000003 	stmdbeq	r0, {r0, r1}
     a44:	00000517 	andeq	r0, r0, r7, lsl r5
     a48:	0000670b 	andeq	r6, r0, fp, lsl #14
     a4c:	00580600 	subseq	r0, r8, r0, lsl #12
     a50:	04050000 	streq	r0, [r5], #-0
     a54:	000b4f07 	andeq	r4, fp, r7, lsl #30
     a58:	00671000 	rsbeq	r1, r7, r0
     a5c:	e0110000 	ands	r0, r1, r0
     a60:	07000004 	streq	r0, [r0, -r4]
     a64:	00004001 	andeq	r4, r0, r1
     a68:	0c060300 	stceq	3, cr0, [r6], {-0}
     a6c:	000000bc 	strheq	r0, [r0], -ip
     a70:	0003f103 	andeq	pc, r3, r3, lsl #2
     a74:	b1030000 	mrslt	r0, (UNDEF: 3)
     a78:	01000001 	tsteq	r0, r1
     a7c:	00038c03 	andeq	r8, r3, r3, lsl #24
     a80:	86030200 	strhi	r0, [r3], -r0, lsl #4
     a84:	03000003 	movweq	r0, #3
     a88:	00033003 	andeq	r3, r3, r3
     a8c:	49030400 	stmdbmi	r3, {sl}
     a90:	05000003 	streq	r0, [r0, #-3]
     a94:	00032a03 	andeq	r2, r3, r3, lsl #20
     a98:	06030600 	streq	r0, [r3], -r0, lsl #12
     a9c:	07000003 	streq	r0, [r0, -r3]
     aa0:	0001b803 	andeq	fp, r1, r3, lsl #16
     aa4:	12000800 	andne	r0, r0, #0, 16
     aa8:	0000019f 	muleq	r0, pc, r1	; <UNPREDICTABLE>
     aac:	071a0304 	ldreq	r0, [sl, -r4, lsl #6]
     ab0:	0000021c 	andeq	r0, r0, ip, lsl r2
     ab4:	0004b10a 	andeq	fp, r4, sl, lsl #2
     ab8:	171e0300 	ldrne	r0, [lr, -r0, lsl #6]
     abc:	00000226 	andeq	r0, r0, r6, lsr #4
     ac0:	028e0400 	addeq	r0, lr, #0, 8
     ac4:	22030000 	andcs	r0, r3, #0
     ac8:	0002a208 	andeq	sl, r2, r8, lsl #4
     acc:	00022b00 	andeq	r2, r2, r0, lsl #22
     ad0:	00ef0200 	rsceq	r0, pc, r0, lsl #4
     ad4:	01040000 	mrseq	r0, (UNDEF: 4)
     ad8:	32020000 	andcc	r0, r2, #0
     adc:	01000002 	tsteq	r0, r2
     ae0:	00000058 	andeq	r0, r0, r8, asr r0
     ae4:	00023701 	andeq	r3, r2, r1, lsl #14
     ae8:	02370100 	eorseq	r0, r7, #0, 2
     aec:	04000000 	streq	r0, [r0], #-0
     af0:	00000336 	andeq	r0, r0, r6, lsr r3
     af4:	43082403 	movwmi	r2, #33795	; 0x8403
     af8:	2b000002 	blcs	b08 <shift+0xb08>
     afc:	02000002 	andeq	r0, r0, #2
     b00:	0000011d 	andeq	r0, r0, sp, lsl r1
     b04:	00000132 	andeq	r0, r0, r2, lsr r1
     b08:	00023202 	andeq	r3, r2, r2, lsl #4
     b0c:	00580100 	subseq	r0, r8, r0, lsl #2
     b10:	37010000 	strcc	r0, [r1, -r0]
     b14:	01000002 	tsteq	r0, r2
     b18:	00000237 	andeq	r0, r0, r7, lsr r2
     b1c:	02d20400 	sbcseq	r0, r2, #0, 8
     b20:	26030000 	strcs	r0, [r3], -r0
     b24:	00021408 	andeq	r1, r2, r8, lsl #8
     b28:	00022b00 	andeq	r2, r2, r0, lsl #22
     b2c:	014b0200 	mrseq	r0, (UNDEF: 107)
     b30:	01600000 	cmneq	r0, r0
     b34:	32020000 	andcc	r0, r2, #0
     b38:	01000002 	tsteq	r0, r2
     b3c:	00000058 	andeq	r0, r0, r8, asr r0
     b40:	00023701 	andeq	r3, r2, r1, lsl #14
     b44:	02370100 	eorseq	r0, r7, #0, 2
     b48:	04000000 	streq	r0, [r0], #-0
     b4c:	00000559 	andeq	r0, r0, r9, asr r5
     b50:	d3082803 	movwle	r2, #34819	; 0x8803
     b54:	2b000001 	blcs	b60 <shift+0xb60>
     b58:	02000002 	andeq	r0, r0, #2
     b5c:	00000179 	andeq	r0, r0, r9, ror r1
     b60:	0000018e 	andeq	r0, r0, lr, lsl #3
     b64:	00023202 	andeq	r3, r2, r2, lsl #4
     b68:	00580100 	subseq	r0, r8, r0, lsl #2
     b6c:	37010000 	strcc	r0, [r1, -r0]
     b70:	01000002 	tsteq	r0, r2
     b74:	00000237 	andeq	r0, r0, r7, lsr r2
     b78:	019f0400 	orrseq	r0, pc, r0, lsl #8
     b7c:	2b030000 	blcs	c0b84 <_bss_end+0xb7e84>
     b80:	00054203 	andeq	r4, r5, r3, lsl #4
     b84:	00023d00 	andeq	r3, r2, r0, lsl #26
     b88:	01a70100 			; <UNDEFINED> instruction: 0x01a70100
     b8c:	01b20000 			; <UNDEFINED> instruction: 0x01b20000
     b90:	3d020000 	stccc	0, cr0, [r2, #-0]
     b94:	01000002 	tsteq	r0, r2
     b98:	00000067 	andeq	r0, r0, r7, rrx
     b9c:	03b40b00 			; <UNDEFINED> instruction: 0x03b40b00
     ba0:	2e030000 	cdpcs	0, 0, cr0, cr3, cr0, {0}
     ba4:	0004b708 	andeq	fp, r4, r8, lsl #14
     ba8:	0001c600 	andeq	ip, r1, r0, lsl #12
     bac:	0001d600 	andeq	sp, r1, r0, lsl #12
     bb0:	023d0200 	eorseq	r0, sp, #0, 4
     bb4:	58010000 	stmdapl	r1, {}	; <UNPREDICTABLE>
     bb8:	01000000 	mrseq	r0, (UNDEF: 0)
     bbc:	00000073 	andeq	r0, r0, r3, ror r0
     bc0:	02020400 	andeq	r0, r2, #0, 8
     bc4:	30030000 	andcc	r0, r3, r0
     bc8:	00042d12 	andeq	r2, r4, r2, lsl sp
     bcc:	00007300 	andeq	r7, r0, r0, lsl #6
     bd0:	01ef0100 	mvneq	r0, r0, lsl #2
     bd4:	01fa0000 	mvnseq	r0, r0
     bd8:	32020000 	andcc	r0, r2, #0
     bdc:	01000002 	tsteq	r0, r2
     be0:	00000058 	andeq	r0, r0, r8, asr r0
     be4:	01ad1300 			; <UNDEFINED> instruction: 0x01ad1300
     be8:	33030000 	movwcc	r0, #12288	; 0x3000
     bec:	00039208 	andeq	r9, r3, r8, lsl #4
     bf0:	020b0100 	andeq	r0, fp, #0, 2
     bf4:	3d020000 	stccc	0, cr0, [r2, #-0]
     bf8:	01000002 	tsteq	r0, r2
     bfc:	00000058 	andeq	r0, r0, r8, asr r0
     c00:	00022b01 	andeq	r2, r2, r1, lsl #22
     c04:	06000000 	streq	r0, [r0], -r0
     c08:	000000bc 	strheq	r0, [r0], -ip
     c0c:	00006707 	andeq	r6, r0, r7, lsl #14
     c10:	02210600 	eoreq	r0, r1, #0, 12
     c14:	01050000 	mrseq	r0, (UNDEF: 5)
     c18:	00052002 	andeq	r2, r5, r2
     c1c:	021c0700 	andseq	r0, ip, #0, 14
     c20:	04140000 	ldreq	r0, [r4], #-0
     c24:	00000058 	andeq	r0, r0, r8, asr r0
     c28:	0000bc07 	andeq	fp, r0, r7, lsl #24
     c2c:	02880c00 	addeq	r0, r8, #0, 24
     c30:	37030000 	strcc	r0, [r3, -r0]
     c34:	0000bc16 	andeq	fp, r0, r6, lsl ip
     c38:	434c1500 	movtmi	r1, #50432	; 0xc500
     c3c:	04100047 	ldreq	r0, [r0], #-71	; 0xffffffb9
     c40:	03230706 			; <UNDEFINED> instruction: 0x03230706
     c44:	61080000 	mrsvs	r0, (UNDEF: 8)
     c48:	003b1300 	eorseq	r1, fp, r0, lsl #6
     c4c:	08000000 	stmdaeq	r0, {}	; <UNPREDICTABLE>
     c50:	3b200063 	blcc	800de4 <_bss_end+0x7f80e4>
     c54:	04000000 	streq	r0, [r0], #-0
     c58:	646f6d08 	strbtvs	r6, [pc], #-3336	; c60 <shift+0xc60>
     c5c:	003b2e00 	eorseq	r2, fp, r0, lsl #28
     c60:	0a080000 	beq	200c68 <_bss_end+0x1f7f68>
     c64:	0000067b 	andeq	r0, r0, fp, ror r6
     c68:	340d0a04 	strcc	r0, [sp], #-2564	; 0xfffff5fc
     c6c:	0c000000 	stceq	0, cr0, [r0], {-0}
     c70:	47434c16 	smlaldmi	r4, r3, r6, ip
     c74:	090d0400 	stmdbeq	sp, {sl}
     c78:	00000680 	andeq	r0, r0, r0, lsl #13
     c7c:	00000323 	andeq	r0, r0, r3, lsr #6
     c80:	00029f01 	andeq	r9, r2, r1, lsl #30
     c84:	02a50000 	adceq	r0, r5, #0
     c88:	23020000 	movwcs	r0, #8192	; 0x2000
     c8c:	00000003 	andeq	r0, r0, r3
     c90:	47434c17 	smlaldmi	r4, r3, r7, ip
     c94:	090e0400 	stmdbeq	lr, {sl}
     c98:	0000062a 	andeq	r0, r0, sl, lsr #12
     c9c:	00000323 	andeq	r0, r0, r3, lsr #6
     ca0:	0002be01 	andeq	fp, r2, r1, lsl #28
     ca4:	0002c900 	andeq	ip, r2, r0, lsl #18
     ca8:	03230200 			; <UNDEFINED> instruction: 0x03230200
     cac:	34010000 	strcc	r0, [r1], #-0
     cb0:	00000000 	andeq	r0, r0, r0
     cb4:	0006020b 	andeq	r0, r6, fp, lsl #4
     cb8:	0e100400 	cfmulseq	mvf0, mvf0, mvf0
     cbc:	0000060b 	andeq	r0, r0, fp, lsl #12
     cc0:	000002dd 	ldrdeq	r0, [r0], -sp
     cc4:	000002e8 	andeq	r0, r0, r8, ror #5
     cc8:	00032302 	andeq	r2, r3, r2, lsl #6
     ccc:	00340100 	eorseq	r0, r4, r0, lsl #2
     cd0:	04000000 	streq	r0, [r0], #-0
     cd4:	000006a8 	andeq	r0, r0, r8, lsr #13
     cd8:	c80d1104 	stmdagt	sp, {r2, r8, ip}
     cdc:	34000005 	strcc	r0, [r0], #-5
     ce0:	01000000 	mrseq	r0, (UNDEF: 0)
     ce4:	00000301 	andeq	r0, r0, r1, lsl #6
     ce8:	00000307 	andeq	r0, r0, r7, lsl #6
     cec:	00032302 	andeq	r2, r3, r2, lsl #6
     cf0:	8c180000 	ldchi	0, cr0, [r8], {-0}
     cf4:	04000006 	streq	r0, [r0], #-6
     cf8:	06950d12 			; <UNDEFINED> instruction: 0x06950d12
     cfc:	00340000 	eorseq	r0, r4, r0
     d00:	1c010000 	stcne	0, cr0, [r1], {-0}
     d04:	02000003 	andeq	r0, r0, #3
     d08:	00000323 	andeq	r0, r0, r3, lsr #6
     d0c:	4e070000 	cdpmi	0, 0, cr0, cr7, cr0, {0}
     d10:	06000002 	streq	r0, [r0], -r2
     d14:	00000323 	andeq	r0, r0, r3, lsr #6
     d18:	0005ea0c 	andeq	lr, r5, ip, lsl #20
     d1c:	0c150400 	cfldrseq	mvf0, [r5], {-0}
     d20:	0000024e 	andeq	r0, r0, lr, asr #4
     d24:	00072719 	andeq	r2, r7, r9, lsl r7
     d28:	14050100 	strne	r0, [r5], #-256	; 0xffffff00
     d2c:	00000062 	andeq	r0, r0, r2, rrx
     d30:	8cd00305 	ldclhi	3, cr0, [r0], {5}
     d34:	851a0000 	ldrhi	r0, [sl, #-0]
     d38:	ce000002 	cdpgt	0, 0, cr0, cr0, cr2, {0}
     d3c:	5c000006 	stcpl	0, cr0, [r0], {6}
     d40:	66000003 	strvs	r0, [r0], -r3
     d44:	1b000003 	blne	d58 <shift+0xd58>
     d48:	00000428 	andeq	r0, r0, r8, lsr #8
     d4c:	00000328 	andeq	r0, r0, r8, lsr #6
     d50:	072f1c00 	streq	r1, [pc, -r0, lsl #24]!
     d54:	0e010000 	cdpeq	0, 0, cr0, cr1, cr0, {0}
     d58:	00003410 	andeq	r3, r0, r0, lsl r4
     d5c:	00883c00 	addeq	r3, r8, r0, lsl #24
     d60:	0000d800 	andeq	sp, r0, r0, lsl #16
     d64:	9e9c0100 	fmllse	f0, f4, f0
     d68:	0d000003 	stceq	0, cr0, [r0, #-12]
     d6c:	0067636c 	rsbeq	r6, r7, ip, ror #6
     d70:	024e0613 	subeq	r0, lr, #19922944	; 0x1300000
     d74:	91020000 	mrsls	r0, (UNDEF: 2)
     d78:	06c31d64 	strbeq	r1, [r3], r4, ror #26
     d7c:	14010000 	strne	r0, [r1], #-0
     d80:	00003406 	andeq	r3, r0, r6, lsl #8
     d84:	74910200 	ldrvc	r0, [r1], #512	; 0x200
     d88:	06b71e00 	ldrteq	r1, [r7], r0, lsl #28
     d8c:	07010000 	streq	r0, [r1, -r0]
     d90:	00071606 	andeq	r1, r7, r6, lsl #12
     d94:	0087e000 	addeq	lr, r7, r0
     d98:	00005c00 	andeq	r5, r0, r0, lsl #24
     d9c:	1f9c0100 	svcne	0x009c0100
     da0:	000006b1 			; <UNDEFINED> instruction: 0x000006b1
     da4:	34160701 	ldrcc	r0, [r6], #-1793	; 0xfffff8ff
     da8:	02000000 	andeq	r0, r0, #0
     dac:	740d6c91 	strvc	r6, [sp], #-3217	; 0xfffff36f
     db0:	08006d69 	stmdaeq	r0, {r0, r3, r5, r6, r8, sl, fp, sp, lr}
     db4:	00006e18 	andeq	r6, r0, r8, lsl lr
     db8:	74910200 	ldrvc	r0, [r1], #512	; 0x200
     dbc:	00200000 	eoreq	r0, r0, r0
     dc0:	00050000 	andeq	r0, r5, r0
     dc4:	071b0401 	ldreq	r0, [fp, -r1, lsl #8]
     dc8:	b6010000 	strlt	r0, [r1], -r0
     dcc:	00000005 	andeq	r0, r0, r5
     dd0:	18000080 	stmdane	r0, {r7}
     dd4:	0000073c 	andeq	r0, r0, ip, lsr r7
     dd8:	00000040 	andeq	r0, r0, r0, asr #32
     ddc:	00000777 	andeq	r0, r0, r7, ror r7
     de0:	012e8001 			; <UNDEFINED> instruction: 0x012e8001
     de4:	00050000 	andeq	r0, r5, r0
     de8:	072f0401 	streq	r0, [pc, -r1, lsl #8]!
     dec:	6e080000 	cdpvs	0, 0, cr0, cr8, cr0, {0}
     df0:	21000000 	mrscs	r0, (UNDEF: 0)
     df4:	000007d3 	ldrdeq	r0, [r0], -r3
     df8:	00000040 	andeq	r0, r0, r0, asr #32
     dfc:	00008914 	andeq	r8, r0, r4, lsl r9
     e00:	00000118 	andeq	r0, r0, r8, lsl r1
     e04:	00000602 	andeq	r0, r0, r2, lsl #12
     e08:	00078303 	andeq	r8, r7, r3, lsl #6
     e0c:	00300200 	eorseq	r0, r0, r0, lsl #4
     e10:	35020000 	strcc	r0, [r2, #-0]
     e14:	09000000 	stmdbeq	r0, {}	; <UNPREDICTABLE>
     e18:	00084103 	andeq	r4, r8, r3, lsl #2
     e1c:	00300300 	eorseq	r0, r0, r0, lsl #6
     e20:	8c010000 	stchi	0, cr0, [r1], {-0}
     e24:	06000007 	streq	r0, [r0], -r7
     e28:	00004b10 	andeq	r4, r0, r0, lsl fp
     e2c:	05040a00 	streq	r0, [r4, #-2560]	; 0xfffff600
     e30:	00746e69 	rsbseq	r6, r4, r9, ror #28
     e34:	00081201 	andeq	r1, r8, r1, lsl #4
     e38:	4b100800 	blmi	402e40 <_bss_end+0x3fa140>
     e3c:	04000000 	streq	r0, [r0], #-0
     e40:	00000026 	andeq	r0, r0, r6, lsr #32
     e44:	0000006c 	andeq	r0, r0, ip, rrx
     e48:	00006c05 	andeq	r6, r0, r5, lsl #24
     e4c:	040b0000 	streq	r0, [fp], #-0
     e50:	000b4f07 	andeq	r4, fp, r7, lsl #30
     e54:	07aa0100 	streq	r0, [sl, r0, lsl #2]!
     e58:	150b0000 	strne	r0, [fp, #-0]
     e5c:	0000005d 	andeq	r0, r0, sp, asr r0
     e60:	00079d01 	andeq	r9, r7, r1, lsl #26
     e64:	5d150d00 	ldcpl	13, cr0, [r5, #-0]
     e68:	04000000 	streq	r0, [r0], #-0
     e6c:	00000036 	andeq	r0, r0, r6, lsr r0
     e70:	00000098 	muleq	r0, r8, r0
     e74:	00006c05 	andeq	r6, r0, r5, lsl #24
     e78:	1b010000 	blne	40e80 <_bss_end+0x38180>
     e7c:	10000008 	andne	r0, r0, r8
     e80:	00008915 	andeq	r8, r0, r5, lsl r9
     e84:	07b80100 	ldreq	r0, [r8, r0, lsl #2]!
     e88:	15120000 	ldrne	r0, [r2, #-0]
     e8c:	00000089 	andeq	r0, r0, r9, lsl #1
     e90:	0007c506 	andeq	ip, r7, r6, lsl #10
     e94:	004b2b00 	subeq	r2, fp, r0, lsl #22
     e98:	89d40000 	ldmibhi	r4, {}^	; <UNPREDICTABLE>
     e9c:	00580000 	subseq	r0, r8, r0
     ea0:	9c010000 	stcls	0, cr0, [r1], {-0}
     ea4:	000000d4 	ldrdeq	r0, [r0], -r4
     ea8:	00079707 	andeq	r9, r7, r7, lsl #14
     eac:	00d42d00 	sbcseq	r2, r4, r0, lsl #26
     eb0:	91020000 	mrsls	r0, (UNDEF: 2)
     eb4:	36020074 			; <UNDEFINED> instruction: 0x36020074
     eb8:	06000000 	streq	r0, [r0], -r0
     ebc:	00000834 	andeq	r0, r0, r4, lsr r8
     ec0:	00004b1f 	andeq	r4, r0, pc, lsl fp
     ec4:	00897c00 	addeq	r7, r9, r0, lsl #24
     ec8:	00005800 	andeq	r5, r0, r0, lsl #16
     ecc:	ff9c0100 			; <UNDEFINED> instruction: 0xff9c0100
     ed0:	07000000 	streq	r0, [r0, -r0]
     ed4:	00000797 	muleq	r0, r7, r7
     ed8:	0000ff21 	andeq	pc, r0, r1, lsr #30
     edc:	74910200 	ldrvc	r0, [r1], #512	; 0x200
     ee0:	00260200 	eoreq	r0, r6, r0, lsl #4
     ee4:	290c0000 	stmdbcs	ip, {}	; <UNPREDICTABLE>
     ee8:	01000008 	tsteq	r0, r8
     eec:	004b1014 	subeq	r1, fp, r4, lsl r0
     ef0:	89140000 	ldmdbhi	r4, {}	; <UNPREDICTABLE>
     ef4:	00680000 	rsbeq	r0, r8, r0
     ef8:	9c010000 	stcls	0, cr0, [r1], {-0}
     efc:	0000012c 	andeq	r0, r0, ip, lsr #2
     f00:	0100690d 	tsteq	r0, sp, lsl #18
     f04:	012c0716 			; <UNDEFINED> instruction: 0x012c0716
     f08:	91020000 	mrsls	r0, (UNDEF: 2)
     f0c:	4b020074 	blmi	810e4 <_bss_end+0x783e4>
     f10:	00000000 	andeq	r0, r0, r0
     f14:	00000021 	andeq	r0, r0, r1, lsr #32
     f18:	04010005 	streq	r0, [r1], #-5
     f1c:	00000800 	andeq	r0, r0, r0, lsl #16
     f20:	0006e501 	andeq	lr, r6, r1, lsl #10
     f24:	008a2c00 	addeq	r2, sl, r0, lsl #24
     f28:	4a04c000 	bmi	130f30 <_bss_end+0x128230>
     f2c:	56000008 	strpl	r0, [r0], -r8
     f30:	bd000008 	stclt	0, cr0, [r0, #-32]	; 0xffffffe0
     f34:	01000008 	tsteq	r0, r8
     f38:	00002080 	andeq	r2, r0, r0, lsl #1
     f3c:	01000500 	tsteq	r0, r0, lsl #10
     f40:	00081404 	andeq	r1, r8, r4, lsl #8
     f44:	07580100 	ldrbeq	r0, [r8, -r0, lsl #2]
     f48:	8c6c0000 	stclhi	0, cr0, [ip], #-0
     f4c:	4a040000 	bmi	100f54 <_bss_end+0xf8254>
     f50:	56000008 	strpl	r0, [r0], -r8
     f54:	bd000008 	stclt	0, cr0, [r0, #-32]	; 0xffffffe0
     f58:	01000008 	tsteq	r0, r8
     f5c:	00033180 	andeq	r3, r3, r0, lsl #3
     f60:	01000500 	tsteq	r0, r0, lsl #10
     f64:	00082804 	andeq	r2, r8, r4, lsl #16
     f68:	0db30900 			; <UNDEFINED> instruction: 0x0db30900
     f6c:	9b1d0000 	blls	740f74 <_bss_end+0x738274>
     f70:	56000009 	strpl	r0, [r0], -r9
     f74:	a2000008 	andge	r0, r0, #8
     f78:	0a000007 	beq	f9c <shift+0xf9c>
     f7c:	6e690504 	cdpvs	5, 6, cr0, cr9, cr4, {0}
     f80:	04020074 	streq	r0, [r2], #-116	; 0xffffff8c
     f84:	000b4f07 	andeq	r4, fp, r7, lsl #30
     f88:	05080200 	streq	r0, [r8, #-512]	; 0xfffffe00
     f8c:	0000010e 	andeq	r0, r0, lr, lsl #2
     f90:	1d040802 	stcne	8, cr0, [r4, #-8]
     f94:	0200000b 	andeq	r0, r0, #11
     f98:	031c0801 	tsteq	ip, #65536	; 0x10000
     f9c:	01020000 	mrseq	r0, (UNDEF: 2)
     fa0:	00031e06 	andeq	r1, r3, r6, lsl #28
     fa4:	0ce60b00 	vstmiaeq	r6!, {d16-d15}
     fa8:	01070000 	mrseq	r0, (UNDEF: 7)
     fac:	0000003a 	andeq	r0, r0, sl, lsr r0
     fb0:	e7061702 	str	r1, [r6, -r2, lsl #14]
     fb4:	01000001 	tsteq	r0, r1
     fb8:	000008f8 	strdeq	r0, [r0], -r8
     fbc:	0c6d0100 	stfeqe	f0, [sp], #-0
     fc0:	01010000 	mrseq	r0, (UNDEF: 1)
     fc4:	00000da3 	andeq	r0, r0, r3, lsr #27
     fc8:	0a520102 	beq	14813d8 <_bss_end+0x14786d8>
     fcc:	01030000 	mrseq	r0, (UNDEF: 3)
     fd0:	00000b10 	andeq	r0, r0, r0, lsl fp
     fd4:	0cff0104 	ldfeqe	f0, [pc], #16	; fec <shift+0xfec>
     fd8:	01050000 	mrseq	r0, (UNDEF: 5)
     fdc:	00000e61 	andeq	r0, r0, r1, ror #28
     fe0:	0d150106 	ldfeqs	f0, [r5, #-24]	; 0xffffffe8
     fe4:	01070000 	mrseq	r0, (UNDEF: 7)
     fe8:	00000b36 	andeq	r0, r0, r6, lsr fp
     fec:	0c900108 	ldfeqs	f0, [r0], {8}
     ff0:	01090000 	mrseq	r0, (UNDEF: 9)
     ff4:	00000c9e 	muleq	r0, lr, ip
     ff8:	0cac010a 	stfeqs	f0, [ip], #40	; 0x28
     ffc:	010b0000 	mrseq	r0, (UNDEF: 11)
    1000:	00000b9f 	muleq	r0, pc, fp	; <UNPREDICTABLE>
    1004:	0b8f010c 	bleq	fe3c143c <_bss_end+0xfe3b873c>
    1008:	010d0000 	mrseq	r0, (UNDEF: 13)
    100c:	00000914 	andeq	r0, r0, r4, lsl r9
    1010:	092d010e 	pusheq	{r1, r2, r3, r8}
    1014:	010f0000 	mrseq	r0, CPSR
    1018:	00000b80 	andeq	r0, r0, r0, lsl #23
    101c:	0d660110 	stfeqe	f0, [r6, #-64]!	; 0xffffffc0
    1020:	01110000 	tsteq	r1, r0
    1024:	00000cd5 	ldrdeq	r0, [r0], -r5
    1028:	0d570112 	ldfeqe	f0, [r7, #-72]	; 0xffffffb8
    102c:	01130000 	tsteq	r3, r0
    1030:	00000a08 	andeq	r0, r0, r8, lsl #20
    1034:	09570114 	ldmdbeq	r7, {r2, r4, r8}^
    1038:	01150000 	tsteq	r5, r0
    103c:	00000921 	andeq	r0, r0, r1, lsr #18
    1040:	0c1e0116 	ldfeqs	f0, [lr], {22}
    1044:	01170000 	tsteq	r7, r0
    1048:	0000098e 	andeq	r0, r0, lr, lsl #19
    104c:	08c90118 	stmiaeq	r9, {r3, r4, r8}^
    1050:	01190000 	tsteq	r9, r0
    1054:	00000d49 	andeq	r0, r0, r9, asr #26
    1058:	0b5c011a 	bleq	17014c8 <_bss_end+0x16f87c8>
    105c:	011b0000 	tsteq	fp, r0
    1060:	00000c36 	andeq	r0, r0, r6, lsr ip
    1064:	0962011c 	stmdbeq	r2!, {r2, r3, r4, r8}^
    1068:	011d0000 	tsteq	sp, r0
    106c:	00000af5 	strdeq	r0, [r0], -r5
    1070:	0a44011e 	beq	11014f0 <_bss_end+0x10f87f0>
    1074:	011f0000 	tsteq	pc, r0
    1078:	00000cc7 	andeq	r0, r0, r7, asr #25
    107c:	0d310120 	ldfeqs	f0, [r1, #-128]!	; 0xffffff80
    1080:	01210000 			; <UNDEFINED> instruction: 0x01210000
    1084:	00000d72 	andeq	r0, r0, r2, ror sp
    1088:	0d800122 	stfeqs	f0, [r0, #136]	; 0x88
    108c:	01230000 			; <UNDEFINED> instruction: 0x01230000
    1090:	00000d23 	andeq	r0, r0, r3, lsr #26
    1094:	0b730124 	bleq	1cc152c <_bss_end+0x1cb882c>
    1098:	01250000 			; <UNDEFINED> instruction: 0x01250000
    109c:	00000ab9 			; <UNDEFINED> instruction: 0x00000ab9
    10a0:	09710126 	ldmdbeq	r1!, {r1, r2, r5, r8}^
    10a4:	01270000 			; <UNDEFINED> instruction: 0x01270000
    10a8:	00000b29 	andeq	r0, r0, r9, lsr #22
    10ac:	0a5e0128 	beq	1781554 <_bss_end+0x1778854>
    10b0:	01290000 			; <UNDEFINED> instruction: 0x01290000
    10b4:	00000e47 	andeq	r0, r0, r7, asr #28
    10b8:	0cf2012a 	ldfeqe	f0, [r2], #168	; 0xa8
    10bc:	012b0000 			; <UNDEFINED> instruction: 0x012b0000
    10c0:	00000a6e 	andeq	r0, r0, lr, ror #20
    10c4:	0a7d012c 	beq	1f4157c <_bss_end+0x1f3887c>
    10c8:	012d0000 			; <UNDEFINED> instruction: 0x012d0000
    10cc:	00000a8c 	andeq	r0, r0, ip, lsl #21
    10d0:	0a9b012e 	beq	fe6c1590 <_bss_end+0xfe6b8890>
    10d4:	012f0000 			; <UNDEFINED> instruction: 0x012f0000
    10d8:	00000a29 	andeq	r0, r0, r9, lsr #20
    10dc:	0aaa0130 	beq	fea815a4 <_bss_end+0xfea788a4>
    10e0:	01310000 	teqeq	r1, r0
    10e4:	00000c81 	andeq	r0, r0, r1, lsl #25
    10e8:	0ac80132 	beq	ff2015b8 <_bss_end+0xff1f88b8>
    10ec:	01330000 	teqeq	r3, r0
    10f0:	00000ad7 	ldrdeq	r0, [r0], -r7
    10f4:	09020134 	stmdbeq	r2, {r2, r4, r5, r8}
    10f8:	01350000 	teqeq	r5, r0
    10fc:	00000bbe 			; <UNDEFINED> instruction: 0x00000bbe
    1100:	0bce0136 	bleq	ff3815e0 <_bss_end+0xff3788e0>
    1104:	01370000 	teqeq	r7, r0
    1108:	00000bde 	ldrdeq	r0, [r0], -lr
    110c:	0a170138 	beq	5c15f4 <_bss_end+0x5b88f4>
    1110:	01390000 	teqeq	r9, r0
    1114:	00000bee 	andeq	r0, r0, lr, ror #23
    1118:	0bfe013a 	bleq	fff81608 <_bss_end+0xfff78908>
    111c:	013b0000 	teqeq	fp, r0
    1120:	00000c0e 	andeq	r0, r0, lr, lsl #24
    1124:	0981013c 	stmibeq	r1, {r2, r3, r4, r5, r8}
    1128:	013d0000 	teqeq	sp, r0
    112c:	0000093a 	andeq	r0, r0, sl, lsr r9
    1130:	0ae6013e 	beq	ff981630 <_bss_end+0xff978930>
    1134:	013f0000 	teqeq	pc, r0
    1138:	000008d9 	ldrdeq	r0, [r0], -r9
    113c:	0c290140 	stfeqs	f0, [r9], #-256	; 0xffffff00
    1140:	00410000 	subeq	r0, r1, r0
    1144:	0009ef0c 	andeq	lr, r9, ip, lsl #30
    1148:	8b020200 	blhi	81950 <_bss_end+0x78c50>
    114c:	020e0802 	andeq	r0, lr, #131072	; 0x20000
    1150:	0b040000 	bleq	101158 <_bss_end+0xf8458>
    1154:	9000000b 	andls	r0, r0, fp
    1158:	00004802 	andeq	r4, r0, r2, lsl #16
    115c:	24040000 	strcs	r0, [r4], #-0
    1160:	9100000a 	tstls	r0, sl
    1164:	00004802 	andeq	r4, r0, r2, lsl #16
    1168:	05000100 	streq	r0, [r0, #-256]	; 0xffffff00
    116c:	000001e7 	andeq	r0, r0, r7, ror #3
    1170:	00020e03 	andeq	r0, r2, r3, lsl #28
    1174:	00022300 	andeq	r2, r2, r0, lsl #6
    1178:	00250600 	eoreq	r0, r5, r0, lsl #12
    117c:	00110000 	andseq	r0, r1, r0
    1180:	00021305 	andeq	r1, r2, r5, lsl #6
    1184:	0bac0d00 	bleq	feb0458c <_bss_end+0xfeafb88c>
    1188:	94020000 	strls	r0, [r2], #-0
    118c:	02232602 	eoreq	r2, r3, #2097152	; 0x200000
    1190:	3d240000 	stccc	0, cr0, [r4, #-0]
    1194:	10400b40 	subne	r0, r0, r0, asr #22
    1198:	35402640 	strbcc	r2, [r0, #-1600]	; 0xfffff9c0
    119c:	06400340 	strbeq	r0, [r0], -r0, asr #6
    11a0:	0e401440 	cdpeq	4, 4, cr1, cr0, cr0, {2}
    11a4:	25400d40 	strbcs	r0, [r0, #-3392]	; 0xfffff2c0
    11a8:	28401240 	stmdacs	r0, {r6, r9, ip}^
    11ac:	18400240 	stmdane	r0, {r6, r9}^
    11b0:	0a400940 	beq	10036b8 <_bss_end+0xffa9b8>
    11b4:	02000040 	andeq	r0, r0, #64	; 0x40
    11b8:	03560702 	cmpeq	r6, #524288	; 0x80000
    11bc:	01020000 	mrseq	r0, (UNDEF: 2)
    11c0:	00032508 	andeq	r2, r3, r8, lsl #10
    11c4:	040f0e00 	streq	r0, [pc], #-3584	; 11cc <shift+0x11cc>
    11c8:	00000268 	andeq	r0, r0, r8, ror #4
    11cc:	000d8e10 	andeq	r8, sp, r0, lsl lr
    11d0:	3a010700 	bcc	42dd8 <_bss_end+0x3a0d8>
    11d4:	03000000 	movweq	r0, #0
    11d8:	ad060556 	cfstr32ge	mvfx0, [r6, #-344]	; 0xfffffea8
    11dc:	01000002 	tsteq	r0, r2
    11e0:	000009c9 	andeq	r0, r0, r9, asr #19
    11e4:	09d40100 	ldmibeq	r4, {r8}^
    11e8:	01010000 	mrseq	r0, (UNDEF: 1)
    11ec:	000009e6 	andeq	r0, r0, r6, ror #19
    11f0:	0a000102 	beq	1600 <shift+0x1600>
    11f4:	01030000 	mrseq	r0, (UNDEF: 3)
    11f8:	00000cba 			; <UNDEFINED> instruction: 0x00000cba
    11fc:	0a380104 	beq	e01614 <_bss_end+0xdf8914>
    1200:	01050000 	mrseq	r0, (UNDEF: 5)
    1204:	00000c5f 	andeq	r0, r0, pc, asr ip
    1208:	02020006 	andeq	r0, r2, #6
    120c:	00050d05 	andeq	r0, r5, r5, lsl #26
    1210:	07080200 	streq	r0, [r8, -r0, lsl #4]
    1214:	00000b45 	andeq	r0, r0, r5, asr #22
    1218:	f2040402 	vshl.s8	d0, d2, d4
    121c:	02000008 	andeq	r0, r0, #8
    1220:	08ea0308 	stmiaeq	sl!, {r3, r8, r9}^
    1224:	08020000 	stmdaeq	r2, {}	; <UNPREDICTABLE>
    1228:	000b2204 	andeq	r2, fp, r4, lsl #4
    122c:	03100200 	tsteq	r0, #0, 4
    1230:	00000c50 	andeq	r0, r0, r0, asr ip
    1234:	000c4711 	andeq	r4, ip, r1, lsl r7
    1238:	102a0400 	eorne	r0, sl, r0, lsl #8
    123c:	00000269 	andeq	r0, r0, r9, ror #4
    1240:	0002d703 	andeq	sp, r2, r3, lsl #14
    1244:	0002ee00 	andeq	lr, r2, r0, lsl #28
    1248:	07001200 	streq	r1, [r0, -r0, lsl #4]
    124c:	000007aa 	andeq	r0, r0, sl, lsr #15
    1250:	0002e32f 	andeq	lr, r2, pc, lsr #6
    1254:	081b0700 	ldmdaeq	fp, {r8, r9, sl}
    1258:	e3300000 	teq	r0, #0
    125c:	03000002 	movweq	r0, #2
    1260:	000002d7 	ldrdeq	r0, [r0], -r7
    1264:	00000312 	andeq	r0, r0, r2, lsl r3
    1268:	00002506 	andeq	r2, r0, r6, lsl #10
    126c:	08000100 	stmdaeq	r0, {r8}
    1270:	000002ee 	andeq	r0, r0, lr, ror #5
    1274:	03020990 	movweq	r0, #10640	; 0x2990
    1278:	03050000 	movweq	r0, #20480	; 0x5000
    127c:	00008cd4 	ldrdeq	r8, [r0], -r4
    1280:	0002f808 	andeq	pc, r2, r8, lsl #16
    1284:	02099100 	andeq	r9, r9, #0, 2
    1288:	05000003 	streq	r0, [r0, #-3]
    128c:	008cdc03 	addeq	sp, ip, r3, lsl #24
	...

Disassembly of section .debug_abbrev:

00000000 <.debug_abbrev>:
   0:	3f002e01 	svccc	0x00002e01
   4:	3a0e0319 	bcc	380c70 <_bss_end+0x377f70>
   8:	0b3b0121 	bleq	ec0494 <_bss_end+0xeb7794>
   c:	11112139 	tstne	r1, r9, lsr r1
  10:	40061201 	andmi	r1, r6, r1, lsl #4
  14:	00197a18 	andseq	r7, r9, r8, lsl sl
  18:	00050200 	andeq	r0, r5, r0, lsl #4
  1c:	00001349 	andeq	r1, r0, r9, asr #6
  20:	3f012e03 	svccc	0x00012e03
  24:	3a0e0319 	bcc	380c90 <_bss_end+0x377f90>
  28:	0b3b0121 	bleq	ec04b4 <_bss_end+0xeb77b4>
  2c:	3c122139 	ldfccs	f2, [r2], {57}	; 0x39
  30:	00130119 	andseq	r0, r3, r9, lsl r1
  34:	012e0400 			; <UNDEFINED> instruction: 0x012e0400
  38:	01111347 	tsteq	r1, r7, asr #6
  3c:	18400612 	stmdane	r0, {r1, r4, r9, sl}^
  40:	1301197a 	movwne	r1, #6522	; 0x197a
  44:	05050000 	streq	r0, [r5, #-0]
  48:	3a080300 	bcc	200c50 <_bss_end+0x1f7f50>
  4c:	0b3b0121 	bleq	ec04d8 <_bss_end+0xeb77d8>
  50:	13490b39 	movtne	r0, #39737	; 0x9b39
  54:	00001802 	andeq	r1, r0, r2, lsl #16
  58:	25011106 	strcs	r1, [r1, #-262]	; 0xfffffefa
  5c:	030b130e 	movweq	r1, #45838	; 0xb30e
  60:	110e1b0e 	tstne	lr, lr, lsl #22
  64:	10061201 	andne	r1, r6, r1, lsl #4
  68:	07000017 	smladeq	r0, r7, r0, r0
  6c:	0e030139 	mcreq	1, 0, r0, cr3, cr9, {1}
  70:	0b3b0b3a 	bleq	ec2d60 <_bss_end+0xeba060>
  74:	13010b39 	movwne	r0, #6969	; 0x1b39
  78:	16080000 	strne	r0, [r8], -r0
  7c:	3a0e0300 	bcc	380c84 <_bss_end+0x377f84>
  80:	390b3b0b 	stmdbcc	fp, {r0, r1, r3, r8, r9, fp, ip, sp}
  84:	0013490b 	andseq	r4, r3, fp, lsl #18
  88:	012e0900 			; <UNDEFINED> instruction: 0x012e0900
  8c:	0e03193f 			; <UNDEFINED> instruction: 0x0e03193f
  90:	0b3b0b3a 	bleq	ec2d80 <_bss_end+0xeba080>
  94:	13490b39 	movtne	r0, #39737	; 0x9b39
  98:	0000193c 	andeq	r1, r0, ip, lsr r9
  9c:	0b000f0a 	bleq	3ccc <shift+0x3ccc>
  a0:	0013490b 	andseq	r4, r3, fp, lsl #18
  a4:	00240b00 	eoreq	r0, r4, r0, lsl #22
  a8:	0b3e0b0b 	bleq	f82cdc <_bss_end+0xf79fdc>
  ac:	00000e03 	andeq	r0, r0, r3, lsl #28
  b0:	4900050c 	stmdbmi	r0, {r2, r3, r8, sl}
  b4:	00180213 	andseq	r0, r8, r3, lsl r2
  b8:	00240d00 	eoreq	r0, r4, r0, lsl #26
  bc:	0b3e0b0b 	bleq	f82cf0 <_bss_end+0xf79ff0>
  c0:	00000803 	andeq	r0, r0, r3, lsl #16
  c4:	47012e0e 	strmi	r2, [r1, -lr, lsl #28]
  c8:	12011113 	andne	r1, r1, #-1073741820	; 0xc0000004
  cc:	7a184006 	bvc	6100ec <_bss_end+0x6073ec>
  d0:	00000019 	andeq	r0, r0, r9, lsl r0
  d4:	03002801 	movweq	r2, #2049	; 0x801
  d8:	000b1c0e 	andeq	r1, fp, lr, lsl #24
  dc:	00050200 	andeq	r0, r5, r0, lsl #4
  e0:	00001349 	andeq	r1, r0, r9, asr #6
  e4:	03000503 	movweq	r0, #1283	; 0x503
  e8:	01213a08 			; <UNDEFINED> instruction: 0x01213a08
  ec:	0b390b3b 	bleq	e42de0 <_bss_end+0xe3a0e0>
  f0:	18021349 	stmdane	r2, {r0, r3, r6, r8, r9, ip}
  f4:	05040000 	streq	r0, [r4, #-0]
  f8:	34134900 	ldrcc	r4, [r3], #-2304	; 0xfffff700
  fc:	05000019 	streq	r0, [r0, #-25]	; 0xffffffe7
 100:	0b0b0024 	bleq	2c0198 <_bss_end+0x2b7498>
 104:	0e030b3e 	vmoveq.16	d3[0], r0
 108:	05060000 	streq	r0, [r6, #-0]
 10c:	3a0e0300 	bcc	380d14 <_bss_end+0x378014>
 110:	0b3b0121 	bleq	ec059c <_bss_end+0xeb789c>
 114:	13490b39 	movtne	r0, #39737	; 0x9b39
 118:	00001802 	andeq	r1, r0, r2, lsl #16
 11c:	03000507 	movweq	r0, #1287	; 0x507
 120:	3413490e 	ldrcc	r4, [r3], #-2318	; 0xfffff6f2
 124:	00180219 	andseq	r0, r8, r9, lsl r2
 128:	00260800 	eoreq	r0, r6, r0, lsl #16
 12c:	00001349 	andeq	r1, r0, r9, asr #6
 130:	3f012e09 	svccc	0x00012e09
 134:	3a0e0319 	bcc	380da0 <_bss_end+0x3780a0>
 138:	0b3b0421 	bleq	ec11c4 <_bss_end+0xeb84c4>
 13c:	0e6e0b39 	vmoveq.8	d14[5], r0
 140:	0b321349 	bleq	c84e6c <_bss_end+0xc7c16c>
 144:	1364193c 	cmnne	r4, #60, 18	; 0xf0000
 148:	00001301 	andeq	r1, r0, r1, lsl #6
 14c:	0300340a 	movweq	r3, #1034	; 0x40a
 150:	01213a08 			; <UNDEFINED> instruction: 0x01213a08
 154:	0b390b3b 	bleq	e42e48 <_bss_end+0xe3a148>
 158:	18021349 	stmdane	r2, {r0, r3, r6, r8, r9, ip}
 15c:	2e0b0000 	cdpcs	0, 0, cr0, cr11, cr0, {0}
 160:	3a134701 	bcc	4d1d6c <_bss_end+0x4c906c>
 164:	0b3b0121 	bleq	ec05f0 <_bss_end+0xeb78f0>
 168:	64062139 	strvs	r2, [r6], #-313	; 0xfffffec7
 16c:	12011113 	andne	r1, r1, #-1073741820	; 0xc0000004
 170:	7a184006 	bvc	610190 <_bss_end+0x607490>
 174:	00130119 	andseq	r0, r3, r9, lsl r1
 178:	00340c00 	eorseq	r0, r4, r0, lsl #24
 17c:	00001347 	andeq	r1, r0, r7, asr #6
 180:	0b000f0d 	bleq	3dbc <shift+0x3dbc>
 184:	13490421 	movtne	r0, #37921	; 0x9421
 188:	2e0e0000 	cdpcs	0, 0, cr0, cr14, cr0, {0}
 18c:	3a134701 	bcc	4d1d98 <_bss_end+0x4c9098>
 190:	0b3b0121 	bleq	ec061c <_bss_end+0xeb791c>
 194:	13640b39 	cmnne	r4, #58368	; 0xe400
 198:	06120111 			; <UNDEFINED> instruction: 0x06120111
 19c:	197c1840 	ldmdbne	ip!, {r6, fp, ip}^
 1a0:	00001301 	andeq	r1, r0, r1, lsl #6
 1a4:	0300160f 	movweq	r1, #1551	; 0x60f
 1a8:	02213a0e 	eoreq	r3, r1, #57344	; 0xe000
 1ac:	21390b3b 	teqcs	r9, fp, lsr fp
 1b0:	00134907 	andseq	r4, r3, r7, lsl #18
 1b4:	00341000 	eorseq	r1, r4, r0
 1b8:	213a0e03 	teqcs	sl, r3, lsl #28
 1bc:	390b3b03 	stmdbcc	fp, {r0, r1, r8, r9, fp, ip, sp}
 1c0:	13491a21 	movtne	r1, #39457	; 0x9a21
 1c4:	061c193c 			; <UNDEFINED> instruction: 0x061c193c
 1c8:	0000196c 	andeq	r1, r0, ip, ror #18
 1cc:	31000511 	tstcc	r0, r1, lsl r5
 1d0:	00180213 	andseq	r0, r8, r3, lsl r2
 1d4:	01111200 	tsteq	r1, r0, lsl #4
 1d8:	0b130e25 	bleq	4c3a74 <_bss_end+0x4bad74>
 1dc:	0e1b0e03 	cdpeq	14, 1, cr0, cr11, cr3, {0}
 1e0:	06120111 			; <UNDEFINED> instruction: 0x06120111
 1e4:	00001710 	andeq	r1, r0, r0, lsl r7
 1e8:	0b002413 	bleq	923c <_bss_end+0x53c>
 1ec:	030b3e0b 	movweq	r3, #48651	; 0xbe0b
 1f0:	14000008 	strne	r0, [r0], #-8
 1f4:	08030139 	stmdaeq	r3, {r0, r3, r4, r5, r8}
 1f8:	0b3b0b3a 	bleq	ec2ee8 <_bss_end+0xeba1e8>
 1fc:	13010b39 	movwne	r0, #6969	; 0x1b39
 200:	34150000 	ldrcc	r0, [r5], #-0
 204:	3a0e0300 	bcc	380e0c <_bss_end+0x37810c>
 208:	390b3b0b 	stmdbcc	fp, {r0, r1, r3, r8, r9, fp, ip, sp}
 20c:	3c13490b 			; <UNDEFINED> instruction: 0x3c13490b
 210:	6c0b1c19 	stcvs	12, cr1, [fp], {25}
 214:	16000019 			; <UNDEFINED> instruction: 0x16000019
 218:	0e030104 	adfeqs	f0, f3, f4
 21c:	0b3e196d 	bleq	f867d8 <_bss_end+0xf7dad8>
 220:	13490b0b 	movtne	r0, #39691	; 0x9b0b
 224:	0b3b0b3a 	bleq	ec2f14 <_bss_end+0xeba214>
 228:	00000b39 	andeq	r0, r0, r9, lsr fp
 22c:	03010417 	movweq	r0, #5143	; 0x1417
 230:	3e196d0e 	cdpcc	13, 1, cr6, cr9, cr14, {0}
 234:	490b0b0b 	stmdbmi	fp, {r0, r1, r3, r8, r9, fp}
 238:	3b0b3a13 	blcc	2cea8c <_bss_end+0x2c5d8c>
 23c:	010b390b 	tsteq	fp, fp, lsl #18
 240:	18000013 	stmdane	r0, {r0, r1, r4}
 244:	0e030102 	adfeqs	f0, f3, f2
 248:	0b3a0b0b 	bleq	e82e7c <_bss_end+0xe7a17c>
 24c:	0b390b3b 	bleq	e42f40 <_bss_end+0xe3a240>
 250:	00001301 	andeq	r1, r0, r1, lsl #6
 254:	03000d19 	movweq	r0, #3353	; 0xd19
 258:	3b0b3a0e 	blcc	2cea98 <_bss_end+0x2c5d98>
 25c:	490b390b 	stmdbmi	fp, {r0, r1, r3, r8, fp, ip, sp}
 260:	000b3813 	andeq	r3, fp, r3, lsl r8
 264:	012e1a00 			; <UNDEFINED> instruction: 0x012e1a00
 268:	0e03193f 			; <UNDEFINED> instruction: 0x0e03193f
 26c:	0b3b0b3a 	bleq	ec2f5c <_bss_end+0xeba25c>
 270:	0e6e0b39 	vmoveq.8	d14[5], r0
 274:	193c0b32 	ldmdbne	ip!, {r1, r4, r5, r8, r9, fp}
 278:	13011364 	movwne	r1, #4964	; 0x1364
 27c:	2e1b0000 	cdpcs	0, 1, cr0, cr11, cr0, {0}
 280:	03193f01 	tsteq	r9, #1, 30
 284:	3b0b3a0e 	blcc	2ceac4 <_bss_end+0x2c5dc4>
 288:	6e0b390b 	vmlavs.f16	s6, s22, s22	; <UNPREDICTABLE>
 28c:	3c0b320e 	sfmcc	f3, 4, [fp], {14}
 290:	00136419 	andseq	r6, r3, r9, lsl r4
 294:	00101c00 	andseq	r1, r0, r0, lsl #24
 298:	13490b0b 	movtne	r0, #39691	; 0x9b0b
 29c:	341d0000 	ldrcc	r0, [sp], #-0
 2a0:	3a0e0300 	bcc	380ea8 <_bss_end+0x3781a8>
 2a4:	390b3b0b 	stmdbcc	fp, {r0, r1, r3, r8, r9, fp, ip, sp}
 2a8:	3f13490b 	svccc	0x0013490b
 2ac:	00193c19 	andseq	r3, r9, r9, lsl ip
 2b0:	00341e00 	eorseq	r1, r4, r0, lsl #28
 2b4:	0b3a1347 	bleq	e84fd8 <_bss_end+0xe7c2d8>
 2b8:	0b390b3b 	bleq	e42fac <_bss_end+0xe3a2ac>
 2bc:	00001802 	andeq	r1, r0, r2, lsl #16
 2c0:	03002e1f 	movweq	r2, #3615	; 0xe1f
 2c4:	1119340e 	tstne	r9, lr, lsl #8
 2c8:	40061201 	andmi	r1, r6, r1, lsl #4
 2cc:	00197c18 	andseq	r7, r9, r8, lsl ip
 2d0:	012e2000 			; <UNDEFINED> instruction: 0x012e2000
 2d4:	19340e03 	ldmdbne	r4!, {r0, r1, r9, sl, fp}
 2d8:	06120111 			; <UNDEFINED> instruction: 0x06120111
 2dc:	197c1840 	ldmdbne	ip!, {r6, fp, ip}^
 2e0:	00001301 	andeq	r1, r0, r1, lsl #6
 2e4:	47012e21 	strmi	r2, [r1, -r1, lsr #28]
 2e8:	3b0b3a13 	blcc	2ceb3c <_bss_end+0x2c5e3c>
 2ec:	640b390b 	strvs	r3, [fp], #-2315	; 0xfffff6f5
 2f0:	010b2013 	tsteq	fp, r3, lsl r0
 2f4:	22000013 	andcs	r0, r0, #19
 2f8:	0e030005 	cdpeq	0, 0, cr0, cr3, cr5, {0}
 2fc:	19341349 	ldmdbne	r4!, {r0, r3, r6, r8, r9, ip}
 300:	05230000 	streq	r0, [r3, #-0]!
 304:	3a0e0300 	bcc	380f0c <_bss_end+0x37820c>
 308:	390b3b0b 	stmdbcc	fp, {r0, r1, r3, r8, r9, fp, ip, sp}
 30c:	0013490b 	andseq	r4, r3, fp, lsl #18
 310:	012e2400 			; <UNDEFINED> instruction: 0x012e2400
 314:	0e6e1331 	mcreq	3, 3, r1, cr14, cr1, {1}
 318:	01111364 	tsteq	r1, r4, ror #6
 31c:	18400612 	stmdane	r0, {r1, r4, r9, sl}^
 320:	0000197a 	andeq	r1, r0, sl, ror r9
 324:	00240100 	eoreq	r0, r4, r0, lsl #2
 328:	0b3e0b0b 	bleq	f82f5c <_bss_end+0xf7a25c>
 32c:	00000e03 	andeq	r0, r0, r3, lsl #28
 330:	49000502 	stmdbmi	r0, {r1, r8, sl}
 334:	00193413 	andseq	r3, r9, r3, lsl r4
 338:	000d0300 	andeq	r0, sp, r0, lsl #6
 33c:	213a0803 	teqcs	sl, r3, lsl #16
 340:	09213b02 	stmdbeq	r1!, {r1, r8, r9, fp, ip, sp}
 344:	13490b39 	movtne	r0, #39737	; 0x9b39
 348:	00000b38 	andeq	r0, r0, r8, lsr fp
 34c:	03000504 	movweq	r0, #1284	; 0x504
 350:	01213a0e 			; <UNDEFINED> instruction: 0x01213a0e
 354:	0b390b3b 	bleq	e43048 <_bss_end+0xe3a348>
 358:	18021349 	stmdane	r2, {r0, r3, r6, r8, r9, ip}
 35c:	05050000 	streq	r0, [r5, #-0]
 360:	490e0300 	stmdbmi	lr, {r8, r9}
 364:	02193413 	andseq	r3, r9, #318767104	; 0x13000000
 368:	06000018 			; <UNDEFINED> instruction: 0x06000018
 36c:	13310005 	teqne	r1, #5
 370:	00001802 	andeq	r1, r0, r2, lsl #16
 374:	49002607 	stmdbmi	r0, {r0, r1, r2, r9, sl, sp}
 378:	08000013 	stmdaeq	r0, {r0, r1, r4}
 37c:	193f012e 	ldmdbne	pc!, {r1, r2, r3, r5, r8}	; <UNPREDICTABLE>
 380:	213a0803 	teqcs	sl, r3, lsl #16
 384:	390b3b02 	stmdbcc	fp, {r1, r8, r9, fp, ip, sp}
 388:	0e6e0921 	vmuleq.f16	s1, s28, s3	; <UNPREDICTABLE>
 38c:	21321349 	teqcs	r2, r9, asr #6
 390:	64193c01 	ldrvs	r3, [r9], #-3073	; 0xfffff3ff
 394:	00130113 	andseq	r0, r3, r3, lsl r1
 398:	00050900 	andeq	r0, r5, r0, lsl #18
 39c:	00001349 	andeq	r1, r0, r9, asr #6
 3a0:	47012e0a 	strmi	r2, [r1, -sl, lsl #28]
 3a4:	01213a13 			; <UNDEFINED> instruction: 0x01213a13
 3a8:	0b390b3b 	bleq	e4309c <_bss_end+0xe3a39c>
 3ac:	01111364 	tsteq	r1, r4, ror #6
 3b0:	18400612 	stmdane	r0, {r1, r4, r9, sl}^
 3b4:	1301197a 	movwne	r1, #6522	; 0x197a
 3b8:	2e0b0000 	cdpcs	0, 0, cr0, cr11, cr0, {0}
 3bc:	3a134701 	bcc	4d1fc8 <_bss_end+0x4c92c8>
 3c0:	0b3b0121 	bleq	ec084c <_bss_end+0xeb7b4c>
 3c4:	64012139 	strvs	r2, [r1], #-313	; 0xfffffec7
 3c8:	00212013 	eoreq	r2, r1, r3, lsl r0
 3cc:	00001301 	andeq	r1, r0, r1, lsl #6
 3d0:	0300050c 	movweq	r0, #1292	; 0x50c
 3d4:	3413490e 	ldrcc	r4, [r3], #-2318	; 0xfffff6f2
 3d8:	0d000019 	stceq	0, cr0, [r0, #-100]	; 0xffffff9c
 3dc:	0e250111 	mcreq	1, 1, r0, cr5, cr1, {0}
 3e0:	0e030b13 	vmoveq.32	d3[0], r0
 3e4:	01110e1b 	tsteq	r1, fp, lsl lr
 3e8:	17100612 			; <UNDEFINED> instruction: 0x17100612
 3ec:	240e0000 	strcs	r0, [lr], #-0
 3f0:	3e0b0b00 	vmlacc.f64	d0, d11, d0
 3f4:	0008030b 	andeq	r0, r8, fp, lsl #6
 3f8:	01020f00 	tsteq	r2, r0, lsl #30
 3fc:	0b0b0803 	bleq	2c2410 <_bss_end+0x2b9710>
 400:	0b3b0b3a 	bleq	ec30f0 <_bss_end+0xeba3f0>
 404:	13010b39 	movwne	r0, #6969	; 0x1b39
 408:	0d100000 	ldceq	0, cr0, [r0, #-0]
 40c:	3a0e0300 	bcc	381014 <_bss_end+0x378314>
 410:	390b3b0b 	stmdbcc	fp, {r0, r1, r3, r8, r9, fp, ip, sp}
 414:	3813490b 	ldmdacc	r3, {r0, r1, r3, r8, fp, lr}
 418:	1100000b 	tstne	r0, fp
 41c:	193f012e 	ldmdbne	pc!, {r1, r2, r3, r5, r8}	; <UNPREDICTABLE>
 420:	0b3a0e03 	bleq	e83c34 <_bss_end+0xe7af34>
 424:	0b390b3b 	bleq	e43118 <_bss_end+0xe3a418>
 428:	0b320e6e 	bleq	c83de8 <_bss_end+0xc7b0e8>
 42c:	1364193c 	cmnne	r4, #60, 18	; 0xf0000
 430:	00001301 	andeq	r1, r0, r1, lsl #6
 434:	3f012e12 	svccc	0x00012e12
 438:	3a0e0319 	bcc	3810a4 <_bss_end+0x3783a4>
 43c:	390b3b0b 	stmdbcc	fp, {r0, r1, r3, r8, r9, fp, ip, sp}
 440:	490e6e0b 	stmdbmi	lr, {r0, r1, r3, r9, sl, fp, sp, lr}
 444:	3c0b3213 	sfmcc	f3, 4, [fp], {19}
 448:	01136419 	tsteq	r3, r9, lsl r4
 44c:	13000013 	movwne	r0, #19
 450:	193f012e 	ldmdbne	pc!, {r1, r2, r3, r5, r8}	; <UNPREDICTABLE>
 454:	0b3a0e03 	bleq	e83c68 <_bss_end+0xe7af68>
 458:	0b390b3b 	bleq	e4314c <_bss_end+0xe3a44c>
 45c:	13490e6e 	movtne	r0, #40558	; 0x9e6e
 460:	193c0b32 	ldmdbne	ip!, {r1, r4, r5, r8, r9, fp}
 464:	00001364 	andeq	r1, r0, r4, ror #6
 468:	0b000f14 	bleq	40c0 <shift+0x40c0>
 46c:	0013490b 	andseq	r4, r3, fp, lsl #18
 470:	00341500 	eorseq	r1, r4, r0, lsl #10
 474:	0b3a0e03 	bleq	e83c88 <_bss_end+0xe7af88>
 478:	0b390b3b 	bleq	e4316c <_bss_end+0xe3a46c>
 47c:	193f1349 	ldmdbne	pc!, {r0, r3, r6, r8, r9, ip}	; <UNPREDICTABLE>
 480:	0000193c 	andeq	r1, r0, ip, lsr r9
 484:	47003416 	smladmi	r0, r6, r4, r3
 488:	3b0b3a13 	blcc	2cecdc <_bss_end+0x2c5fdc>
 48c:	020b390b 	andeq	r3, fp, #180224	; 0x2c000
 490:	17000018 	smladne	r0, r8, r0, r0
 494:	0e03002e 	cdpeq	0, 0, cr0, cr3, cr14, {1}
 498:	01111934 	tsteq	r1, r4, lsr r9
 49c:	18400612 	stmdane	r0, {r1, r4, r9, sl}^
 4a0:	0000197c 	andeq	r1, r0, ip, ror r9
 4a4:	03012e18 	movweq	r2, #7704	; 0x1e18
 4a8:	1119340e 	tstne	r9, lr, lsl #8
 4ac:	40061201 	andmi	r1, r6, r1, lsl #4
 4b0:	01197c18 	tsteq	r9, r8, lsl ip
 4b4:	19000013 	stmdbne	r0, {r0, r1, r4}
 4b8:	1347012e 	movtne	r0, #28974	; 0x712e
 4bc:	0b390b3a 	bleq	e431ac <_bss_end+0xe3a4ac>
 4c0:	01111364 	tsteq	r1, r4, ror #6
 4c4:	18400612 	stmdane	r0, {r1, r4, r9, sl}^
 4c8:	1301197c 	movwne	r1, #6524	; 0x197c
 4cc:	051a0000 	ldreq	r0, [sl, #-0]
 4d0:	3a0e0300 	bcc	3810d8 <_bss_end+0x3783d8>
 4d4:	390b3b0b 	stmdbcc	fp, {r0, r1, r3, r8, r9, fp, ip, sp}
 4d8:	0013490b 	andseq	r4, r3, fp, lsl #18
 4dc:	012e1b00 			; <UNDEFINED> instruction: 0x012e1b00
 4e0:	0e6e1331 	mcreq	3, 3, r1, cr14, cr1, {1}
 4e4:	01111364 	tsteq	r1, r4, ror #6
 4e8:	18400612 	stmdane	r0, {r1, r4, r9, sl}^
 4ec:	1301197a 	movwne	r1, #6522	; 0x197a
 4f0:	2e1c0000 	cdpcs	0, 1, cr0, cr12, cr0, {0}
 4f4:	6e133101 	mufvss	f3, f3, f1
 4f8:	1113640e 	tstne	r3, lr, lsl #8
 4fc:	40061201 	andmi	r1, r6, r1, lsl #4
 500:	00197a18 	andseq	r7, r9, r8, lsl sl
 504:	05010000 	streq	r0, [r1, #-0]
 508:	00134900 	andseq	r4, r3, r0, lsl #18
 50c:	00050200 	andeq	r0, r5, r0, lsl #4
 510:	19341349 	ldmdbne	r4!, {r0, r3, r6, r8, r9, ip}
 514:	28030000 	stmdacs	r3, {}	; <UNPREDICTABLE>
 518:	1c0e0300 	stcne	3, cr0, [lr], {-0}
 51c:	0400000b 	streq	r0, [r0], #-11
 520:	193f012e 	ldmdbne	pc!, {r1, r2, r3, r5, r8}	; <UNPREDICTABLE>
 524:	0b3a0e03 	bleq	e83d38 <_bss_end+0xe7b038>
 528:	0b390b3b 	bleq	e4321c <_bss_end+0xe3a51c>
 52c:	13490e6e 	movtne	r0, #40558	; 0x9e6e
 530:	193c0b32 	ldmdbne	ip!, {r1, r4, r5, r8, r9, fp}
 534:	13011364 	movwne	r1, #4964	; 0x1364
 538:	24050000 	strcs	r0, [r5], #-0
 53c:	3e0b0b00 	vmlacc.f64	d0, d11, d0
 540:	000e030b 	andeq	r0, lr, fp, lsl #6
 544:	00260600 	eoreq	r0, r6, r0, lsl #12
 548:	00001349 	andeq	r1, r0, r9, asr #6
 54c:	0b000f07 	bleq	4170 <shift+0x4170>
 550:	13490421 	movtne	r0, #37921	; 0x9421
 554:	0d080000 	stceq	0, cr0, [r8, #-0]
 558:	3a080300 	bcc	201160 <_bss_end+0x1f8460>
 55c:	213b0421 	teqcs	fp, r1, lsr #8
 560:	490b3909 	stmdbmi	fp, {r0, r3, r8, fp, ip, sp}
 564:	000b3813 	andeq	r3, fp, r3, lsl r8
 568:	00160900 	andseq	r0, r6, r0, lsl #18
 56c:	213a0e03 	teqcs	sl, r3, lsl #28
 570:	390b3b02 	stmdbcc	fp, {r1, r8, r9, fp, ip, sp}
 574:	13490721 	movtne	r0, #38689	; 0x9721
 578:	0d0a0000 	stceq	0, cr0, [sl, #-0]
 57c:	3a0e0300 	bcc	381184 <_bss_end+0x378484>
 580:	390b3b0b 	stmdbcc	fp, {r0, r1, r3, r8, r9, fp, ip, sp}
 584:	3813490b 	ldmdacc	r3, {r0, r1, r3, r8, fp, lr}
 588:	0b00000b 	bleq	5bc <shift+0x5bc>
 58c:	193f012e 	ldmdbne	pc!, {r1, r2, r3, r5, r8}	; <UNPREDICTABLE>
 590:	0b3a0e03 	bleq	e83da4 <_bss_end+0xe7b0a4>
 594:	0b390b3b 	bleq	e43288 <_bss_end+0xe3a588>
 598:	21320e6e 	teqcs	r2, lr, ror #28
 59c:	64193c01 	ldrvs	r3, [r9], #-3073	; 0xfffff3ff
 5a0:	00130113 	andseq	r0, r3, r3, lsl r1
 5a4:	00340c00 	eorseq	r0, r4, r0, lsl #24
 5a8:	0b3a0e03 	bleq	e83dbc <_bss_end+0xe7b0bc>
 5ac:	0b390b3b 	bleq	e432a0 <_bss_end+0xe3a5a0>
 5b0:	193f1349 	ldmdbne	pc!, {r0, r3, r6, r8, r9, ip}	; <UNPREDICTABLE>
 5b4:	0000193c 	andeq	r1, r0, ip, lsr r9
 5b8:	0300340d 	movweq	r3, #1037	; 0x40d
 5bc:	01213a08 			; <UNDEFINED> instruction: 0x01213a08
 5c0:	0b390b3b 	bleq	e432b4 <_bss_end+0xe3a5b4>
 5c4:	18021349 	stmdane	r2, {r0, r3, r6, r8, r9, ip}
 5c8:	110e0000 	mrsne	r0, (UNDEF: 14)
 5cc:	130e2501 	movwne	r2, #58625	; 0xe501
 5d0:	1b0e030b 	blne	381204 <_bss_end+0x378504>
 5d4:	1201110e 	andne	r1, r1, #-2147483645	; 0x80000003
 5d8:	00171006 	andseq	r1, r7, r6
 5dc:	00240f00 	eoreq	r0, r4, r0, lsl #30
 5e0:	0b3e0b0b 	bleq	f83214 <_bss_end+0xf7a514>
 5e4:	00000803 	andeq	r0, r0, r3, lsl #16
 5e8:	49003510 	stmdbmi	r0, {r4, r8, sl, ip, sp}
 5ec:	11000013 	tstne	r0, r3, lsl r0
 5f0:	0e030104 	adfeqs	f0, f3, f4
 5f4:	0b3e196d 	bleq	f86bb0 <_bss_end+0xf7deb0>
 5f8:	13490b0b 	movtne	r0, #39691	; 0x9b0b
 5fc:	0b3b0b3a 	bleq	ec32ec <_bss_end+0xeba5ec>
 600:	13010b39 	movwne	r0, #6969	; 0x1b39
 604:	02120000 	andseq	r0, r2, #0
 608:	0b0e0301 	bleq	381214 <_bss_end+0x378514>
 60c:	3b0b3a0b 	blcc	2cee40 <_bss_end+0x2c6140>
 610:	010b390b 	tsteq	fp, fp, lsl #18
 614:	13000013 	movwne	r0, #19
 618:	193f012e 	ldmdbne	pc!, {r1, r2, r3, r5, r8}	; <UNPREDICTABLE>
 61c:	0b3a0e03 	bleq	e83e30 <_bss_end+0xe7b130>
 620:	0b390b3b 	bleq	e43314 <_bss_end+0xe3a614>
 624:	0b320e6e 	bleq	c83fe4 <_bss_end+0xc7b2e4>
 628:	1364193c 	cmnne	r4, #60, 18	; 0xf0000
 62c:	10140000 	andsne	r0, r4, r0
 630:	490b0b00 	stmdbmi	fp, {r8, r9, fp}
 634:	15000013 	strne	r0, [r0, #-19]	; 0xffffffed
 638:	08030102 	stmdaeq	r3, {r1, r8}
 63c:	0b3a0b0b 	bleq	e83270 <_bss_end+0xe7a570>
 640:	0b390b3b 	bleq	e43334 <_bss_end+0xe3a634>
 644:	00001301 	andeq	r1, r0, r1, lsl #6
 648:	3f012e16 	svccc	0x00012e16
 64c:	3a080319 	bcc	2012b8 <_bss_end+0x1f85b8>
 650:	390b3b0b 	stmdbcc	fp, {r0, r1, r3, r8, r9, fp, ip, sp}
 654:	490e6e0b 	stmdbmi	lr, {r0, r1, r3, r9, sl, fp, sp, lr}
 658:	3c0b3213 	sfmcc	f3, 4, [fp], {19}
 65c:	20136419 	andscs	r6, r3, r9, lsl r4
 660:	0013010b 	andseq	r0, r3, fp, lsl #2
 664:	012e1700 			; <UNDEFINED> instruction: 0x012e1700
 668:	0803193f 	stmdaeq	r3, {r0, r1, r2, r3, r4, r5, r8, fp, ip}
 66c:	0b3b0b3a 	bleq	ec335c <_bss_end+0xeba65c>
 670:	0e6e0b39 	vmoveq.8	d14[5], r0
 674:	0b321349 	bleq	c853a0 <_bss_end+0xc7c6a0>
 678:	1364193c 	cmnne	r4, #60, 18	; 0xf0000
 67c:	00001301 	andeq	r1, r0, r1, lsl #6
 680:	3f012e18 	svccc	0x00012e18
 684:	3a0e0319 	bcc	3812f0 <_bss_end+0x3785f0>
 688:	390b3b0b 	stmdbcc	fp, {r0, r1, r3, r8, r9, fp, ip, sp}
 68c:	490e6e0b 	stmdbmi	lr, {r0, r1, r3, r9, sl, fp, sp, lr}
 690:	3c0b3213 	sfmcc	f3, 4, [fp], {19}
 694:	00136419 	andseq	r6, r3, r9, lsl r4
 698:	00341900 	eorseq	r1, r4, r0, lsl #18
 69c:	0b3a0e03 	bleq	e83eb0 <_bss_end+0xe7b1b0>
 6a0:	0b390b3b 	bleq	e43394 <_bss_end+0xe3a694>
 6a4:	196c1349 	stmdbne	ip!, {r0, r3, r6, r8, r9, ip}^
 6a8:	00001802 	andeq	r1, r0, r2, lsl #16
 6ac:	31012e1a 	tstcc	r1, sl, lsl lr
 6b0:	640e6e13 	strvs	r6, [lr], #-3603	; 0xfffff1ed
 6b4:	00130113 	andseq	r0, r3, r3, lsl r1
 6b8:	00051b00 	andeq	r1, r5, r0, lsl #22
 6bc:	13490e03 	movtne	r0, #40451	; 0x9e03
 6c0:	00001934 	andeq	r1, r0, r4, lsr r9
 6c4:	3f012e1c 	svccc	0x00012e1c
 6c8:	3a0e0319 	bcc	381334 <_bss_end+0x378634>
 6cc:	390b3b0b 	stmdbcc	fp, {r0, r1, r3, r8, r9, fp, ip, sp}
 6d0:	1113490b 	tstne	r3, fp, lsl #18
 6d4:	40061201 	andmi	r1, r6, r1, lsl #4
 6d8:	01197c18 	tsteq	r9, r8, lsl ip
 6dc:	1d000013 	stcne	0, cr0, [r0, #-76]	; 0xffffffb4
 6e0:	0e030034 	mcreq	0, 0, r0, cr3, cr4, {1}
 6e4:	0b3b0b3a 	bleq	ec33d4 <_bss_end+0xeba6d4>
 6e8:	13490b39 	movtne	r0, #39737	; 0x9b39
 6ec:	00001802 	andeq	r1, r0, r2, lsl #16
 6f0:	3f012e1e 	svccc	0x00012e1e
 6f4:	3a0e0319 	bcc	381360 <_bss_end+0x378660>
 6f8:	390b3b0b 	stmdbcc	fp, {r0, r1, r3, r8, r9, fp, ip, sp}
 6fc:	110e6e0b 	tstne	lr, fp, lsl #28
 700:	40061201 	andmi	r1, r6, r1, lsl #4
 704:	00197a18 	andseq	r7, r9, r8, lsl sl
 708:	00051f00 	andeq	r1, r5, r0, lsl #30
 70c:	0b3a0e03 	bleq	e83f20 <_bss_end+0xe7b220>
 710:	0b390b3b 	bleq	e43404 <_bss_end+0xe3a704>
 714:	18021349 	stmdane	r2, {r0, r3, r6, r8, r9, ip}
 718:	01000000 	mrseq	r0, (UNDEF: 0)
 71c:	17100011 			; <UNDEFINED> instruction: 0x17100011
 720:	0f120111 	svceq	0x00120111
 724:	0e1b0e03 	cdpeq	14, 1, cr0, cr11, cr3, {0}
 728:	05130e25 	ldreq	r0, [r3, #-3621]	; 0xfffff1db
 72c:	01000000 	mrseq	r0, (UNDEF: 0)
 730:	0e030034 	mcreq	0, 0, r0, cr3, cr4, {1}
 734:	3b01213a 	blcc	48c24 <_bss_end+0x3ff24>
 738:	490b390b 	stmdbmi	fp, {r0, r1, r3, r8, fp, ip, sp}
 73c:	3c193f13 	ldccc	15, cr3, [r9], {19}
 740:	02000019 	andeq	r0, r0, #25
 744:	210b000f 	tstcs	fp, pc
 748:	00134904 	andseq	r4, r3, r4, lsl #18
 74c:	00160300 	andseq	r0, r6, r0, lsl #6
 750:	213a0e03 	teqcs	sl, r3, lsl #28
 754:	390b3b01 	stmdbcc	fp, {r0, r8, r9, fp, ip, sp}
 758:	13490721 	movtne	r0, #38689	; 0x9721
 75c:	01040000 	mrseq	r0, (UNDEF: 4)
 760:	01134901 	tsteq	r3, r1, lsl #18
 764:	05000013 	streq	r0, [r0, #-19]	; 0xffffffed
 768:	13490021 	movtne	r0, #36897	; 0x9021
 76c:	ffff212f 			; <UNDEFINED> instruction: 0xffff212f
 770:	000fffff 	strdeq	pc, [pc], -pc	; <UNPREDICTABLE>
 774:	012e0600 			; <UNDEFINED> instruction: 0x012e0600
 778:	0e03193f 			; <UNDEFINED> instruction: 0x0e03193f
 77c:	3b01213a 	blcc	48c6c <_bss_end+0x3ff6c>
 780:	1021390b 	eorne	r3, r1, fp, lsl #18
 784:	01111349 	tsteq	r1, r9, asr #6
 788:	18400612 	stmdane	r0, {r1, r4, r9, sl}^
 78c:	1301197c 	movwne	r1, #6524	; 0x197c
 790:	34070000 	strcc	r0, [r7], #-0
 794:	3a0e0300 	bcc	38139c <_bss_end+0x37869c>
 798:	0b3b0121 	bleq	ec0c24 <_bss_end+0xeb7f24>
 79c:	490c2139 	stmdbmi	ip, {r0, r3, r4, r5, r8, sp}
 7a0:	00180213 	andseq	r0, r8, r3, lsl r2
 7a4:	01110800 	tsteq	r1, r0, lsl #16
 7a8:	0b130e25 	bleq	4c4044 <_bss_end+0x4bb344>
 7ac:	0e1b0e03 	cdpeq	14, 1, cr0, cr11, cr3, {0}
 7b0:	06120111 			; <UNDEFINED> instruction: 0x06120111
 7b4:	00001710 	andeq	r1, r0, r0, lsl r7
 7b8:	00001509 	andeq	r1, r0, r9, lsl #10
 7bc:	00240a00 	eoreq	r0, r4, r0, lsl #20
 7c0:	0b3e0b0b 	bleq	f833f4 <_bss_end+0xf7a6f4>
 7c4:	00000803 	andeq	r0, r0, r3, lsl #16
 7c8:	0b00240b 	bleq	97fc <_bss_end+0xafc>
 7cc:	030b3e0b 	movweq	r3, #48651	; 0xbe0b
 7d0:	0c00000e 	stceq	0, cr0, [r0], {14}
 7d4:	193f012e 	ldmdbne	pc!, {r1, r2, r3, r5, r8}	; <UNPREDICTABLE>
 7d8:	0b3a0e03 	bleq	e83fec <_bss_end+0xe7b2ec>
 7dc:	0b390b3b 	bleq	e434d0 <_bss_end+0xe3a7d0>
 7e0:	01111349 	tsteq	r1, r9, asr #6
 7e4:	18400612 	stmdane	r0, {r1, r4, r9, sl}^
 7e8:	1301197a 	movwne	r1, #6522	; 0x197a
 7ec:	340d0000 	strcc	r0, [sp], #-0
 7f0:	3a080300 	bcc	2013f8 <_bss_end+0x1f86f8>
 7f4:	390b3b0b 	stmdbcc	fp, {r0, r1, r3, r8, r9, fp, ip, sp}
 7f8:	0213490b 	andseq	r4, r3, #180224	; 0x2c000
 7fc:	00000018 	andeq	r0, r0, r8, lsl r0
 800:	10001101 	andne	r1, r0, r1, lsl #2
 804:	12011117 	andne	r1, r1, #-1073741819	; 0xc0000005
 808:	1b0e030f 	blne	38144c <_bss_end+0x37874c>
 80c:	130e250e 	movwne	r2, #58638	; 0xe50e
 810:	00000005 	andeq	r0, r0, r5
 814:	10001101 	andne	r1, r0, r1, lsl #2
 818:	12011117 	andne	r1, r1, #-1073741819	; 0xc0000005
 81c:	1b0e030f 	blne	381460 <_bss_end+0x378760>
 820:	130e250e 	movwne	r2, #58638	; 0xe50e
 824:	00000005 	andeq	r0, r0, r5
 828:	03002801 	movweq	r2, #2049	; 0x801
 82c:	000b1c0e 	andeq	r1, fp, lr, lsl #24
 830:	00240200 	eoreq	r0, r4, r0, lsl #4
 834:	0b3e0b0b 	bleq	f83468 <_bss_end+0xf7a768>
 838:	00000e03 	andeq	r0, r0, r3, lsl #28
 83c:	49010103 	stmdbmi	r1, {r0, r1, r8}
 840:	00130113 	andseq	r0, r3, r3, lsl r1
 844:	000d0400 	andeq	r0, sp, r0, lsl #8
 848:	213a0e03 	teqcs	sl, r3, lsl #28
 84c:	39053b02 	stmdbcc	r5, {r1, r8, r9, fp, ip, sp}
 850:	13491421 	movtne	r1, #37921	; 0x9421
 854:	00000b38 	andeq	r0, r0, r8, lsr fp
 858:	49002605 	stmdbmi	r0, {r0, r2, r9, sl, sp}
 85c:	06000013 			; <UNDEFINED> instruction: 0x06000013
 860:	13490021 	movtne	r0, #36897	; 0x9021
 864:	00000b2f 	andeq	r0, r0, pc, lsr #22
 868:	03003407 	movweq	r3, #1031	; 0x407
 86c:	04213a0e 	strteq	r3, [r1], #-2574	; 0xfffff5f2
 870:	21390b3b 	teqcs	r9, fp, lsr fp
 874:	3f134911 	svccc	0x00134911
 878:	00193c19 	andseq	r3, r9, r9, lsl ip
 87c:	00340800 	eorseq	r0, r4, r0, lsl #16
 880:	213a1347 	teqcs	sl, r7, asr #6
 884:	39053b01 	stmdbcc	r5, {r0, r8, r9, fp, ip, sp}
 888:	13490a21 	movtne	r0, #39457	; 0x9a21
 88c:	00001802 	andeq	r1, r0, r2, lsl #16
 890:	25011109 	strcs	r1, [r1, #-265]	; 0xfffffef7
 894:	030b130e 	movweq	r1, #45838	; 0xb30e
 898:	100e1b0e 	andne	r1, lr, lr, lsl #22
 89c:	0a000017 	beq	900 <shift+0x900>
 8a0:	0b0b0024 	bleq	2c0938 <_bss_end+0x2b7c38>
 8a4:	08030b3e 	stmdaeq	r3, {r1, r2, r3, r4, r5, r8, r9, fp}
 8a8:	040b0000 	streq	r0, [fp], #-0
 8ac:	3e0e0301 	cdpcc	3, 0, cr0, cr14, cr1, {0}
 8b0:	490b0b0b 	stmdbmi	fp, {r0, r1, r3, r8, r9, fp}
 8b4:	3b0b3a13 	blcc	2cf108 <_bss_end+0x2c6408>
 8b8:	010b390b 	tsteq	fp, fp, lsl #18
 8bc:	0c000013 	stceq	0, cr0, [r0], {19}
 8c0:	0e030113 	mcreq	1, 0, r0, cr3, cr3, {0}
 8c4:	0b3a0b0b 	bleq	e834f8 <_bss_end+0xe7a7f8>
 8c8:	0b39053b 	bleq	e41dbc <_bss_end+0xe390bc>
 8cc:	00001301 	andeq	r1, r0, r1, lsl #6
 8d0:	0300340d 	movweq	r3, #1037	; 0x40d
 8d4:	3b0b3a0e 	blcc	2cf114 <_bss_end+0x2c6414>
 8d8:	490b3905 	stmdbmi	fp, {r0, r2, r8, fp, ip, sp}
 8dc:	000a1c13 	andeq	r1, sl, r3, lsl ip
 8e0:	00150e00 	andseq	r0, r5, r0, lsl #28
 8e4:	00001927 	andeq	r1, r0, r7, lsr #18
 8e8:	0b000f0f 	bleq	452c <shift+0x452c>
 8ec:	0013490b 	andseq	r4, r3, fp, lsl #18
 8f0:	01041000 	mrseq	r1, (UNDEF: 4)
 8f4:	0b3e0e03 	bleq	f84108 <_bss_end+0xf7b408>
 8f8:	13490b0b 	movtne	r0, #39691	; 0x9b0b
 8fc:	053b0b3a 	ldreq	r0, [fp, #-2874]!	; 0xfffff4c6
 900:	13010b39 	movwne	r0, #6969	; 0x1b39
 904:	16110000 	ldrne	r0, [r1], -r0
 908:	3a0e0300 	bcc	381510 <_bss_end+0x378810>
 90c:	390b3b0b 	stmdbcc	fp, {r0, r1, r3, r8, r9, fp, ip, sp}
 910:	0013490b 	andseq	r4, r3, fp, lsl #18
 914:	00211200 	eoreq	r1, r1, r0, lsl #4
 918:	Address 0x0000000000000918 is out of bounds.


Disassembly of section .debug_aranges:

00000000 <.debug_aranges>:
   0:	0000001c 	andeq	r0, r0, ip, lsl r0
   4:	00000002 	andeq	r0, r0, r2
   8:	00040000 	andeq	r0, r4, r0
   c:	00000000 	andeq	r0, r0, r0
  10:	00008018 	andeq	r8, r0, r8, lsl r0
  14:	000000d8 	ldrdeq	r0, [r0], -r8
	...
  20:	0000001c 	andeq	r0, r0, ip, lsl r0
  24:	011e0002 	tsteq	lr, r2
  28:	00040000 	andeq	r0, r4, r0
  2c:	00000000 	andeq	r0, r0, r0
  30:	000080f0 	strdeq	r8, [r0], -r0
  34:	00000510 	andeq	r0, r0, r0, lsl r5
	...
  40:	0000001c 	andeq	r0, r0, ip, lsl r0
  44:	075a0002 	ldrbeq	r0, [sl, -r2]
  48:	00040000 	andeq	r0, r4, r0
  4c:	00000000 	andeq	r0, r0, r0
  50:	00008600 	andeq	r8, r0, r0, lsl #12
  54:	000001e0 	andeq	r0, r0, r0, ror #3
	...
  60:	0000001c 	andeq	r0, r0, ip, lsl r0
  64:	09eb0002 	stmibeq	fp!, {r1}^
  68:	00040000 	andeq	r0, r4, r0
  6c:	00000000 	andeq	r0, r0, r0
  70:	000087e0 	andeq	r8, r0, r0, ror #15
  74:	00000134 	andeq	r0, r0, r4, lsr r1
	...
  80:	0000001c 	andeq	r0, r0, ip, lsl r0
  84:	0dbe0002 	ldceq	0, cr0, [lr, #8]!
  88:	00040000 	andeq	r0, r4, r0
  8c:	00000000 	andeq	r0, r0, r0
  90:	00008000 	andeq	r8, r0, r0
  94:	00000018 	andeq	r0, r0, r8, lsl r0
	...
  a0:	0000001c 	andeq	r0, r0, ip, lsl r0
  a4:	0de20002 	stcleq	0, cr0, [r2, #8]!
  a8:	00040000 	andeq	r0, r4, r0
  ac:	00000000 	andeq	r0, r0, r0
  b0:	00008914 	andeq	r8, r0, r4, lsl r9
  b4:	00000118 	andeq	r0, r0, r8, lsl r1
	...
  c0:	0000001c 	andeq	r0, r0, ip, lsl r0
  c4:	0f140002 	svceq	0x00140002
  c8:	00040000 	andeq	r0, r4, r0
  cc:	00000000 	andeq	r0, r0, r0
  d0:	00008a2c 	andeq	r8, r0, ip, lsr #20
  d4:	00000240 	andeq	r0, r0, r0, asr #4
	...
  e0:	0000001c 	andeq	r0, r0, ip, lsl r0
  e4:	0f390002 	svceq	0x00390002
  e8:	00040000 	andeq	r0, r4, r0
  ec:	00000000 	andeq	r0, r0, r0
  f0:	00008c6c 	andeq	r8, r0, ip, ror #24
  f4:	00000004 	andeq	r0, r0, r4
	...
 100:	00000014 	andeq	r0, r0, r4, lsl r0
 104:	0f5d0002 	svceq	0x005d0002
 108:	00040000 	andeq	r0, r4, r0
	...

Disassembly of section .debug_line:

00000000 <.debug_line>:
   0:	0000008a 	andeq	r0, r0, sl, lsl #1
   4:	00510003 	subseq	r0, r1, r3
   8:	01020000 	mrseq	r0, (UNDEF: 2)
   c:	000d0efb 	strdeq	r0, [sp], -fp
  10:	01010101 	tsteq	r1, r1, lsl #2
  14:	01000000 	mrseq	r0, (UNDEF: 0)
  18:	2f010000 	svccs	0x00010000
  1c:	656d6f68 	strbvs	r6, [sp, #-3944]!	; 0xfffff098
  20:	2f66632f 	svccs	0x0066632f
  24:	2f55435a 	svccs	0x0055435a
  28:	702f534f 	eorvc	r5, pc, pc, asr #6
  2c:	74636172 	strbtvc	r6, [r3], #-370	; 0xfffffe8e
  30:	6c616369 	stclvs	3, cr6, [r1], #-420	; 0xfffffe5c
  34:	3278652f 	rsbscc	r6, r8, #197132288	; 0xbc00000
  38:	5f34302f 	svcpl	0x0034302f
  3c:	6e72656b 	cdpvs	5, 7, cr6, cr2, cr11, {3}
  40:	6b2f6c65 	blvs	bdb1dc <_bss_end+0xbd24dc>
  44:	656e7265 	strbvs	r7, [lr, #-613]!	; 0xfffffd9b
  48:	72732f6c 	rsbsvc	r2, r3, #108, 30	; 0x1b0
  4c:	63000063 	movwvs	r0, #99	; 0x63
  50:	632e7878 			; <UNDEFINED> instruction: 0x632e7878
  54:	01007070 	tsteq	r0, r0, ror r0
  58:	05000000 	streq	r0, [r0, #-0]
  5c:	02050002 	andeq	r0, r5, #2
  60:	00008018 	andeq	r8, r0, r8, lsl r0
  64:	05010a03 	streq	r0, [r1, #-2563]	; 0xfffff5fd
  68:	0a05830b 	beq	160c9c <_bss_end+0x157f9c>
  6c:	8302054a 	movwhi	r0, #9546	; 0x254a
  70:	830e0585 	movwhi	r0, #58757	; 0xe585
  74:	85670205 	strbhi	r0, [r7, #-517]!	; 0xfffffdfb
  78:	86010584 	strhi	r0, [r1], -r4, lsl #11
  7c:	854c854c 	strbhi	r8, [ip, #-1356]	; 0xfffffab4
  80:	0205854c 	andeq	r8, r5, #76, 10	; 0x13000000
  84:	01040200 	mrseq	r0, R12_usr
  88:	0002024b 	andeq	r0, r2, fp, asr #4
  8c:	02c10101 	sbceq	r0, r1, #1073741824	; 0x40000000
  90:	00030000 	andeq	r0, r3, r0
  94:	00000106 	andeq	r0, r0, r6, lsl #2
  98:	0efb0102 	cdpeq	1, 15, cr0, cr11, cr2, {0}
  9c:	0101000d 	tsteq	r1, sp
  a0:	00000101 	andeq	r0, r0, r1, lsl #2
  a4:	00000100 	andeq	r0, r0, r0, lsl #2
  a8:	6f682f01 	svcvs	0x00682f01
  ac:	632f656d 			; <UNDEFINED> instruction: 0x632f656d
  b0:	435a2f66 	cmpmi	sl, #408	; 0x198
  b4:	534f2f55 	movtpl	r2, #65365	; 0xff55
  b8:	6172702f 	cmnvs	r2, pc, lsr #32
  bc:	63697463 	cmnvs	r9, #1660944384	; 0x63000000
  c0:	652f6c61 	strvs	r6, [pc, #-3169]!	; fffff467 <_bss_end+0xffff6767>
  c4:	302f3278 	eorcc	r3, pc, r8, ror r2	; <UNPREDICTABLE>
  c8:	656b5f34 	strbvs	r5, [fp, #-3892]!	; 0xfffff0cc
  cc:	6c656e72 	stclvs	14, cr6, [r5], #-456	; 0xfffffe38
  d0:	72656b2f 	rsbvc	r6, r5, #48128	; 0xbc00
  d4:	2f6c656e 	svccs	0x006c656e
  d8:	2f637273 	svccs	0x00637273
  dc:	76697264 	strbtvc	r7, [r9], -r4, ror #4
  e0:	00737265 	rsbseq	r7, r3, r5, ror #4
  e4:	6d6f682f 	stclvs	8, cr6, [pc, #-188]!	; 30 <shift+0x30>
  e8:	66632f65 	strbtvs	r2, [r3], -r5, ror #30
  ec:	55435a2f 	strbpl	r5, [r3, #-2607]	; 0xfffff5d1
  f0:	2f534f2f 	svccs	0x00534f2f
  f4:	63617270 	cmnvs	r1, #112, 4
  f8:	61636974 	smcvs	13972	; 0x3694
  fc:	78652f6c 	stmdavc	r5!, {r2, r3, r5, r6, r8, r9, sl, fp, sp}^
 100:	34302f32 	ldrtcc	r2, [r0], #-3890	; 0xfffff0ce
 104:	72656b5f 	rsbvc	r6, r5, #97280	; 0x17c00
 108:	2f6c656e 	svccs	0x006c656e
 10c:	6e72656b 	cdpvs	5, 7, cr6, cr2, cr11, {3}
 110:	692f6c65 	stmdbvs	pc!, {r0, r2, r5, r6, sl, fp, sp, lr}	; <UNPREDICTABLE>
 114:	756c636e 	strbvc	r6, [ip, #-878]!	; 0xfffffc92
 118:	622f6564 	eorvs	r6, pc, #100, 10	; 0x19000000
 11c:	6472616f 	ldrbtvs	r6, [r2], #-367	; 0xfffffe91
 120:	6970722f 	ldmdbvs	r0!, {r0, r1, r2, r3, r5, r9, ip, sp, lr}^
 124:	61682f30 	cmnvs	r8, r0, lsr pc
 128:	682f006c 	stmdavs	pc!, {r2, r3, r5, r6}	; <UNPREDICTABLE>
 12c:	2f656d6f 	svccs	0x00656d6f
 130:	5a2f6663 	bpl	bd9ac4 <_bss_end+0xbd0dc4>
 134:	4f2f5543 	svcmi	0x002f5543
 138:	72702f53 	rsbsvc	r2, r0, #332	; 0x14c
 13c:	69746361 	ldmdbvs	r4!, {r0, r5, r6, r8, r9, sp, lr}^
 140:	2f6c6163 	svccs	0x006c6163
 144:	2f327865 	svccs	0x00327865
 148:	6b5f3430 	blvs	17cd210 <_bss_end+0x17c4510>
 14c:	656e7265 	strbvs	r7, [lr, #-613]!	; 0xfffffd9b
 150:	656b2f6c 	strbvs	r2, [fp, #-3948]!	; 0xfffff094
 154:	6c656e72 	stclvs	14, cr6, [r5], #-456	; 0xfffffe38
 158:	636e692f 	cmnvs	lr, #770048	; 0xbc000
 15c:	6564756c 	strbvs	r7, [r4, #-1388]!	; 0xfffffa94
 160:	6972642f 	ldmdbvs	r2!, {r0, r1, r2, r3, r5, sl, sp, lr}^
 164:	73726576 	cmnvc	r2, #494927872	; 0x1d800000
 168:	70670000 	rsbvc	r0, r7, r0
 16c:	632e6f69 			; <UNDEFINED> instruction: 0x632e6f69
 170:	01007070 	tsteq	r0, r0, ror r0
 174:	6e690000 	cdpvs	0, 6, cr0, cr9, cr0, {0}
 178:	66656474 			; <UNDEFINED> instruction: 0x66656474
 17c:	0200682e 	andeq	r6, r0, #3014656	; 0x2e0000
 180:	65700000 	ldrbvs	r0, [r0, #-0]!
 184:	68706972 	ldmdavs	r0!, {r1, r4, r5, r6, r8, fp, sp, lr}^
 188:	6c617265 	sfmvs	f7, 2, [r1], #-404	; 0xfffffe6c
 18c:	00682e73 	rsbeq	r2, r8, r3, ror lr
 190:	67000002 	strvs	r0, [r0, -r2]
 194:	2e6f6970 			; <UNDEFINED> instruction: 0x2e6f6970
 198:	00030068 	andeq	r0, r3, r8, rrx
 19c:	01050000 	mrseq	r0, (UNDEF: 5)
 1a0:	f0020500 			; <UNDEFINED> instruction: 0xf0020500
 1a4:	17000080 	strne	r0, [r0, -r0, lsl #1]
 1a8:	059f0405 	ldreq	r0, [pc, #1029]	; 5b5 <shift+0x5b5>
 1ac:	05a16901 	streq	r6, [r1, #2305]!	; 0x901
 1b0:	0a05d702 	beq	175dc0 <_bss_end+0x16d0c0>
 1b4:	4c0e0567 	cfstr32mi	mvfx0, [lr], {103}	; 0x67
 1b8:	05820205 	streq	r0, [r2, #517]	; 0x205
 1bc:	0522080f 	streq	r0, [r2, #-2063]!	; 0xfffff7f1
 1c0:	0f056640 	svceq	0x00056640
 1c4:	6640052f 	strbvs	r0, [r0], -pc, lsr #10
 1c8:	052f0f05 	streq	r0, [pc, #-3845]!	; fffff2cb <_bss_end+0xffff65cb>
 1cc:	0f056640 	svceq	0x00056640
 1d0:	6640052f 	strbvs	r0, [r0], -pc, lsr #10
 1d4:	052f0f05 	streq	r0, [pc, #-3845]!	; fffff2d7 <_bss_end+0xffff65d7>
 1d8:	0f056640 	svceq	0x00056640
 1dc:	6640052f 	strbvs	r0, [r0], -pc, lsr #10
 1e0:	05311105 	ldreq	r1, [r1, #-261]!	; 0xfffffefb
 1e4:	05200817 	streq	r0, [r0, #-2071]!	; 0xfffff7e9
 1e8:	0905660a 	stmdbeq	r5, {r1, r3, r9, sl, sp, lr}
 1ec:	2f01054c 	svccs	0x0001054c
 1f0:	d70205a1 	strle	r0, [r2, -r1, lsr #11]
 1f4:	05670a05 	strbeq	r0, [r7, #-2565]!	; 0xfffff5fb
 1f8:	02004c08 	andeq	r4, r0, #8, 24	; 0x800
 1fc:	66060104 	strvs	r0, [r6], -r4, lsl #2
 200:	02040200 	andeq	r0, r4, #0, 4
 204:	0006054a 	andeq	r0, r6, sl, asr #10
 208:	06040402 	streq	r0, [r4], -r2, lsl #8
 20c:	0010052e 	andseq	r0, r0, lr, lsr #10
 210:	4b040402 	blmi	101220 <_bss_end+0xf8520>
 214:	02000a05 	andeq	r0, r0, #20480	; 0x5000
 218:	054a0404 	strbeq	r0, [sl, #-1028]	; 0xfffffbfc
 21c:	04020009 	streq	r0, [r2], #-9
 220:	01054c04 	tsteq	r5, r4, lsl #24
 224:	0205852f 	andeq	r8, r5, #197132288	; 0xbc00000
 228:	670a05d7 			; <UNDEFINED> instruction: 0x670a05d7
 22c:	004c0805 	subeq	r0, ip, r5, lsl #16
 230:	06010402 	streq	r0, [r1], -r2, lsl #8
 234:	04020066 	streq	r0, [r2], #-102	; 0xffffff9a
 238:	06054a02 	streq	r4, [r5], -r2, lsl #20
 23c:	04040200 	streq	r0, [r4], #-512	; 0xfffffe00
 240:	10052e06 	andne	r2, r5, r6, lsl #28
 244:	04040200 	streq	r0, [r4], #-512	; 0xfffffe00
 248:	000a054b 	andeq	r0, sl, fp, asr #10
 24c:	4a040402 	bmi	10125c <_bss_end+0xf855c>
 250:	02000905 	andeq	r0, r0, #81920	; 0x14000
 254:	054c0404 	strbeq	r0, [ip, #-1028]	; 0xfffffbfc
 258:	05852f01 	streq	r2, [r5, #3841]	; 0xf01
 25c:	0a05d702 	beq	175e6c <_bss_end+0x16d16c>
 260:	4c080567 	cfstr32mi	mvfx0, [r8], {103}	; 0x67
 264:	01040200 	mrseq	r0, R12_usr
 268:	02006606 	andeq	r6, r0, #6291456	; 0x600000
 26c:	054a0204 	strbeq	r0, [sl, #-516]	; 0xfffffdfc
 270:	04020006 	streq	r0, [r2], #-6
 274:	052e0604 	streq	r0, [lr, #-1540]!	; 0xfffff9fc
 278:	04020010 	streq	r0, [r2], #-16
 27c:	0a054b04 	beq	152e94 <_bss_end+0x14a194>
 280:	04040200 	streq	r0, [r4], #-512	; 0xfffffe00
 284:	0009054a 	andeq	r0, r9, sl, asr #10
 288:	4c040402 	cfstrsmi	mvf0, [r4], {2}
 28c:	852f0105 	strhi	r0, [pc, #-261]!	; 18f <shift+0x18f>
 290:	05d81a05 	ldrbeq	r1, [r8, #2565]	; 0xa05
 294:	0205ba06 	andeq	fp, r5, #24576	; 0x6000
 298:	4d10054a 	cfldr32mi	mvfx0, [r0, #-296]	; 0xfffffed8
 29c:	054a1905 	strbeq	r1, [sl, #-2309]	; 0xfffff6fb
 2a0:	1e05823b 	mcrne	2, 0, r8, cr5, cr11, {1}
 2a4:	2e1b0566 	cfmsc32cs	mvfx0, mvfx11, mvfx6
 2a8:	052f0805 	streq	r0, [pc, #-2053]!	; fffffaab <_bss_end+0xffff6dab>
 2ac:	02052e28 	andeq	r2, r5, #40, 28	; 0x280
 2b0:	4a0b0549 	bmi	2c17dc <_bss_end+0x2b8adc>
 2b4:	05670505 	strbeq	r0, [r7, #-1285]!	; 0xfffffafb
 2b8:	03052d0d 	movweq	r2, #23821	; 0x5d0d
 2bc:	32010548 	andcc	r0, r1, #72, 10	; 0x12000000
 2c0:	a01a054d 	andsge	r0, sl, sp, asr #10
 2c4:	05ba0605 	ldreq	r0, [sl, #1541]!	; 0x605
 2c8:	1a054a02 	bne	152ad8 <_bss_end+0x149dd8>
 2cc:	4c26054b 	cfstr32mi	mvfx0, [r6], #-300	; 0xfffffed4
 2d0:	054a2f05 	strbeq	r2, [sl, #-3845]	; 0xfffff0fb
 2d4:	09058231 	stmdbeq	r5, {r0, r4, r5, r9, pc}
 2d8:	2e3c054a 	cdpcs	5, 3, cr0, cr12, cr10, {2}
 2dc:	02000105 	andeq	r0, r0, #1073741825	; 0x40000001
 2e0:	694b0104 	stmdbvs	fp, {r2, r8}^
 2e4:	05d80805 	ldrbeq	r0, [r8, #2053]	; 0x805
 2e8:	21056632 	tstcs	r5, r2, lsr r6
 2ec:	02040200 	andeq	r0, r4, #0, 4
 2f0:	0006054a 	andeq	r0, r6, sl, asr #10
 2f4:	f2020402 	vshl.s8	d0, d2, d2
 2f8:	02003205 	andeq	r3, r0, #1342177280	; 0x50000000
 2fc:	054a0304 	strbeq	r0, [sl, #-772]	; 0xfffffcfc
 300:	04020051 	streq	r0, [r2], #-81	; 0xffffffaf
 304:	35056606 	strcc	r6, [r5, #-1542]	; 0xfffff9fa
 308:	06040200 	streq	r0, [r4], -r0, lsl #4
 30c:	003205f2 	ldrshteq	r0, [r2], -r2
 310:	4a070402 	bmi	1c1320 <_bss_end+0x1b8620>
 314:	08040200 	stmdaeq	r4, {r9}
 318:	02054a06 	andeq	r4, r5, #24576	; 0x6000
 31c:	0a040200 	beq	100b24 <_bss_end+0xf7e24>
 320:	12052e06 	andne	r2, r5, #6, 28	; 0x60
 324:	6602054d 	strvs	r0, [r2], -sp, asr #10
 328:	054a0b05 	strbeq	r0, [sl, #-2821]	; 0xfffff4fb
 32c:	0d056612 	stceq	6, cr6, [r5, #-72]	; 0xffffffb8
 330:	4803052e 	stmdami	r3, {r1, r2, r3, r5, r8, sl}
 334:	4a310105 	bmi	c40750 <_bss_end+0xc37a50>
 338:	0402009e 	streq	r0, [r2], #-158	; 0xffffff62
 33c:	05660601 	strbeq	r0, [r6, #-1537]!	; 0xfffff9ff
 340:	a9030623 	stmdbge	r3, {r0, r1, r5, r9, sl}
 344:	0105827f 	tsteq	r5, pc, ror r2
 348:	6600d703 	strvs	sp, [r0], -r3, lsl #14
 34c:	0a024aba 	beq	92e3c <_bss_end+0x8a13c>
 350:	12010100 	andne	r0, r1, #0, 2
 354:	03000001 	movweq	r0, #1
 358:	0000a100 	andeq	sl, r0, r0, lsl #2
 35c:	fb010200 	blx	40b66 <_bss_end+0x37e66>
 360:	01000d0e 	tsteq	r0, lr, lsl #26
 364:	00010101 	andeq	r0, r1, r1, lsl #2
 368:	00010000 	andeq	r0, r1, r0
 36c:	682f0100 	stmdavs	pc!, {r8}	; <UNPREDICTABLE>
 370:	2f656d6f 	svccs	0x00656d6f
 374:	5a2f6663 	bpl	bd9d08 <_bss_end+0xbd1008>
 378:	4f2f5543 	svcmi	0x002f5543
 37c:	72702f53 	rsbsvc	r2, r0, #332	; 0x14c
 380:	69746361 	ldmdbvs	r4!, {r0, r5, r6, r8, r9, sp, lr}^
 384:	2f6c6163 	svccs	0x006c6163
 388:	2f327865 	svccs	0x00327865
 38c:	6b5f3430 	blvs	17cd454 <_bss_end+0x17c4754>
 390:	656e7265 	strbvs	r7, [lr, #-613]!	; 0xfffffd9b
 394:	656b2f6c 	strbvs	r2, [fp, #-3948]!	; 0xfffff094
 398:	6c656e72 	stclvs	14, cr6, [r5], #-456	; 0xfffffe38
 39c:	6372732f 	cmnvs	r2, #-1140850688	; 0xbc000000
 3a0:	6972642f 	ldmdbvs	r2!, {r0, r1, r2, r3, r5, sl, sp, lr}^
 3a4:	73726576 	cmnvc	r2, #494927872	; 0x1d800000
 3a8:	6f682f00 	svcvs	0x00682f00
 3ac:	632f656d 			; <UNDEFINED> instruction: 0x632f656d
 3b0:	435a2f66 	cmpmi	sl, #408	; 0x198
 3b4:	534f2f55 	movtpl	r2, #65365	; 0xff55
 3b8:	6172702f 	cmnvs	r2, pc, lsr #32
 3bc:	63697463 	cmnvs	r9, #1660944384	; 0x63000000
 3c0:	652f6c61 	strvs	r6, [pc, #-3169]!	; fffff767 <_bss_end+0xffff6a67>
 3c4:	302f3278 	eorcc	r3, pc, r8, ror r2	; <UNPREDICTABLE>
 3c8:	656b5f34 	strbvs	r5, [fp, #-3892]!	; 0xfffff0cc
 3cc:	6c656e72 	stclvs	14, cr6, [r5], #-456	; 0xfffffe38
 3d0:	72656b2f 	rsbvc	r6, r5, #48128	; 0xbc00
 3d4:	2f6c656e 	svccs	0x006c656e
 3d8:	6c636e69 	stclvs	14, cr6, [r3], #-420	; 0xfffffe5c
 3dc:	2f656475 	svccs	0x00656475
 3e0:	76697264 	strbtvc	r7, [r9], -r4, ror #4
 3e4:	00737265 	rsbseq	r7, r3, r5, ror #4
 3e8:	67636c00 	strbvs	r6, [r3, -r0, lsl #24]!
 3ec:	7070632e 	rsbsvc	r6, r0, lr, lsr #6
 3f0:	00000100 	andeq	r0, r0, r0, lsl #2
 3f4:	2e67636c 	cdpcs	3, 6, cr6, cr7, cr12, {3}
 3f8:	00020068 	andeq	r0, r2, r8, rrx
 3fc:	01050000 	mrseq	r0, (UNDEF: 5)
 400:	00020500 	andeq	r0, r2, r0, lsl #10
 404:	16000086 	strne	r0, [r0], -r6, lsl #1
 408:	05820a05 	streq	r0, [r2, #2565]	; 0xa05
 40c:	0520080d 	streq	r0, [r0, #-2061]!	; 0xfffff7f3
 410:	1205f301 	andne	pc, r5, #67108864	; 0x4000000
 414:	0807059f 	stmdaeq	r7, {r0, r1, r2, r3, r4, r7, r8, sl}
 418:	66150520 	ldrvs	r0, [r5], -r0, lsr #10
 41c:	05f52005 	ldrbeq	r2, [r5, #5]!
 420:	01059f0a 	tsteq	r5, sl, lsl #30
 424:	84150567 	ldrhi	r0, [r5], #-1383	; 0xfffffa99
 428:	05830c05 	streq	r0, [r3, #3077]	; 0xc05
 42c:	15054b01 	strne	r4, [r5, #-2817]	; 0xfffff4ff
 430:	830d0584 	movwhi	r0, #54660	; 0xd584
 434:	054a1105 	strbeq	r1, [sl, #-261]	; 0xfffffefb
 438:	18054a0f 	stmdane	r5, {r0, r1, r2, r3, r9, fp, lr}
 43c:	4a16052e 	bmi	5818fc <_bss_end+0x578bfc>
 440:	052e1d05 	streq	r1, [lr, #-3333]!	; 0xfffff2fb
 444:	0a054a1b 	beq	152cb8 <_bss_end+0x149fb8>
 448:	4b0c059e 	blmi	301ac8 <_bss_end+0x2f8dc8>
 44c:	664b0105 	strbvs	r0, [fp], -r5, lsl #2
 450:	0402009e 	streq	r0, [r2], #-158	; 0xffffff62
 454:	05660601 	strbeq	r0, [r6, #-1537]!	; 0xfffff9ff
 458:	6e030605 	cfmadd32vs	mvax0, mvfx0, mvfx3, mvfx5
 45c:	03010582 	movweq	r0, #5506	; 0x1582
 460:	4a9e4a12 	bmi	fe792cb0 <_bss_end+0xfe789fb0>
 464:	01000a02 	tsteq	r0, r2, lsl #20
 468:	00014901 	andeq	r4, r1, r1, lsl #18
 46c:	f6000300 			; <UNDEFINED> instruction: 0xf6000300
 470:	02000000 	andeq	r0, r0, #0
 474:	0d0efb01 	vstreq	d15, [lr, #-4]
 478:	01010100 	mrseq	r0, (UNDEF: 17)
 47c:	00000001 	andeq	r0, r0, r1
 480:	01000001 	tsteq	r0, r1
 484:	6d6f682f 	stclvs	8, cr6, [pc, #-188]!	; 3d0 <shift+0x3d0>
 488:	66632f65 	strbtvs	r2, [r3], -r5, ror #30
 48c:	55435a2f 	strbpl	r5, [r3, #-2607]	; 0xfffff5d1
 490:	2f534f2f 	svccs	0x00534f2f
 494:	63617270 	cmnvs	r1, #112, 4
 498:	61636974 	smcvs	13972	; 0x3694
 49c:	78652f6c 	stmdavc	r5!, {r2, r3, r5, r6, r8, r9, sl, fp, sp}^
 4a0:	34302f32 	ldrtcc	r2, [r0], #-3890	; 0xfffff0ce
 4a4:	72656b5f 	rsbvc	r6, r5, #97280	; 0x17c00
 4a8:	2f6c656e 	svccs	0x006c656e
 4ac:	6e72656b 	cdpvs	5, 7, cr6, cr2, cr11, {3}
 4b0:	732f6c65 			; <UNDEFINED> instruction: 0x732f6c65
 4b4:	2f006372 	svccs	0x00006372
 4b8:	656d6f68 	strbvs	r6, [sp, #-3944]!	; 0xfffff098
 4bc:	2f66632f 	svccs	0x0066632f
 4c0:	2f55435a 	svccs	0x0055435a
 4c4:	702f534f 	eorvc	r5, pc, pc, asr #6
 4c8:	74636172 	strbtvc	r6, [r3], #-370	; 0xfffffe8e
 4cc:	6c616369 	stclvs	3, cr6, [r1], #-420	; 0xfffffe5c
 4d0:	3278652f 	rsbscc	r6, r8, #197132288	; 0xbc00000
 4d4:	5f34302f 	svcpl	0x0034302f
 4d8:	6e72656b 	cdpvs	5, 7, cr6, cr2, cr11, {3}
 4dc:	6b2f6c65 	blvs	bdb678 <_bss_end+0xbd2978>
 4e0:	656e7265 	strbvs	r7, [lr, #-613]!	; 0xfffffd9b
 4e4:	6e692f6c 	cdpvs	15, 6, cr2, cr9, cr12, {3}
 4e8:	64756c63 	ldrbtvs	r6, [r5], #-3171	; 0xfffff39d
 4ec:	6f622f65 	svcvs	0x00622f65
 4f0:	2f647261 	svccs	0x00647261
 4f4:	30697072 	rsbcc	r7, r9, r2, ror r0
 4f8:	6c61682f 	stclvs	8, cr6, [r1], #-188	; 0xffffff44
 4fc:	6f682f00 	svcvs	0x00682f00
 500:	632f656d 			; <UNDEFINED> instruction: 0x632f656d
 504:	435a2f66 	cmpmi	sl, #408	; 0x198
 508:	534f2f55 	movtpl	r2, #65365	; 0xff55
 50c:	6172702f 	cmnvs	r2, pc, lsr #32
 510:	63697463 	cmnvs	r9, #1660944384	; 0x63000000
 514:	652f6c61 	strvs	r6, [pc, #-3169]!	; fffff8bb <_bss_end+0xffff6bbb>
 518:	302f3278 	eorcc	r3, pc, r8, ror r2	; <UNPREDICTABLE>
 51c:	656b5f34 	strbvs	r5, [fp, #-3892]!	; 0xfffff0cc
 520:	6c656e72 	stclvs	14, cr6, [r5], #-456	; 0xfffffe38
 524:	72656b2f 	rsbvc	r6, r5, #48128	; 0xbc00
 528:	2f6c656e 	svccs	0x006c656e
 52c:	6c636e69 	stclvs	14, cr6, [r3], #-420	; 0xfffffe5c
 530:	2f656475 	svccs	0x00656475
 534:	76697264 	strbtvc	r7, [r9], -r4, ror #4
 538:	00737265 	rsbseq	r7, r3, r5, ror #4
 53c:	69616d00 	stmdbvs	r1!, {r8, sl, fp, sp, lr}^
 540:	70632e6e 	rsbvc	r2, r3, lr, ror #28
 544:	00010070 	andeq	r0, r1, r0, ror r0
 548:	746e6900 	strbtvc	r6, [lr], #-2304	; 0xfffff700
 54c:	2e666564 	cdpcs	5, 6, cr6, cr6, cr4, {3}
 550:	00020068 	andeq	r0, r2, r8, rrx
 554:	69706700 	ldmdbvs	r0!, {r8, r9, sl, sp, lr}^
 558:	00682e6f 	rsbeq	r2, r8, pc, ror #28
 55c:	6c000003 	stcvs	0, cr0, [r0], {3}
 560:	682e6763 	stmdavs	lr!, {r0, r1, r5, r6, r8, r9, sl, sp, lr}
 564:	00000300 	andeq	r0, r0, r0, lsl #6
 568:	001d0500 	andseq	r0, sp, r0, lsl #10
 56c:	87e00205 	strbhi	r0, [r0, r5, lsl #4]!
 570:	05180000 	ldreq	r0, [r8, #-0]
 574:	0205850a 	andeq	r8, r5, #41943040	; 0x2800000
 578:	0402004a 	streq	r0, [r2], #-74	; 0xffffffb6
 57c:	052e0603 	streq	r0, [lr, #-1539]!	; 0xfffff9fd
 580:	04020013 	streq	r0, [r2], #-19	; 0xffffffed
 584:	05660601 	strbeq	r0, [r6, #-1537]!	; 0xfffff9ff
 588:	05a1f401 	streq	pc, [r1, #1025]!	; 0x401
 58c:	06056819 			; <UNDEFINED> instruction: 0x06056819
 590:	6d240584 	cfstr32vs	mvfx0, [r4, #-528]!	; 0xfffffdf0
 594:	05830305 	streq	r0, [r3, #773]	; 0x305
 598:	04020022 	streq	r0, [r2], #-34	; 0xffffffde
 59c:	0e056601 	cfmadd32eq	mvax0, mvfx6, mvfx5, mvfx1
 5a0:	02130567 	andseq	r0, r3, #432013312	; 0x19c00000
 5a4:	0e051526 	cfsh32eq	mvfx1, mvfx5, #22
 5a8:	4d130584 	cfldr32mi	mvfx0, [r3, #-528]	; 0xfffffdf0
 5ac:	76030e05 	strvc	r0, [r3], -r5, lsl #28
 5b0:	000a0282 	andeq	r0, sl, r2, lsl #5
 5b4:	00480101 	subeq	r0, r8, r1, lsl #2
 5b8:	00050000 	andeq	r0, r5, r0
 5bc:	002e0004 	eoreq	r0, lr, r4
 5c0:	01020000 	mrseq	r0, (UNDEF: 2)
 5c4:	0d0efb01 	vstreq	d15, [lr, #-4]
 5c8:	01010100 	mrseq	r0, (UNDEF: 17)
 5cc:	00000001 	andeq	r0, r0, r1
 5d0:	01000001 	tsteq	r0, r1
 5d4:	021f0101 	andseq	r0, pc, #1073741824	; 0x40000000
 5d8:	00000000 	andeq	r0, r0, r0
 5dc:	0000002e 	andeq	r0, r0, lr, lsr #32
 5e0:	021f0102 	andseq	r0, pc, #-2147483648	; 0x80000000
 5e4:	0061020f 	rsbeq	r0, r1, pc, lsl #4
 5e8:	61010000 	mrsvs	r0, (UNDEF: 1)
 5ec:	01000000 	mrseq	r0, (UNDEF: 0)
 5f0:	00020500 	andeq	r0, r2, r0, lsl #10
 5f4:	19000080 	stmdbne	r0, {r7}
 5f8:	2f2f2f2f 	svccs	0x002f2f2f
 5fc:	00020230 	andeq	r0, r2, r0, lsr r2
 600:	00df0101 	sbcseq	r0, pc, r1, lsl #2
 604:	00030000 	andeq	r0, r3, r0
 608:	00000055 	andeq	r0, r0, r5, asr r0
 60c:	0efb0102 	cdpeq	1, 15, cr0, cr11, cr2, {0}
 610:	0101000d 	tsteq	r1, sp
 614:	00000101 	andeq	r0, r0, r1, lsl #2
 618:	00000100 	andeq	r0, r0, r0, lsl #2
 61c:	6f682f01 	svcvs	0x00682f01
 620:	632f656d 			; <UNDEFINED> instruction: 0x632f656d
 624:	435a2f66 	cmpmi	sl, #408	; 0x198
 628:	534f2f55 	movtpl	r2, #65365	; 0xff55
 62c:	6172702f 	cmnvs	r2, pc, lsr #32
 630:	63697463 	cmnvs	r9, #1660944384	; 0x63000000
 634:	652f6c61 	strvs	r6, [pc, #-3169]!	; fffff9db <_bss_end+0xffff6cdb>
 638:	302f3278 	eorcc	r3, pc, r8, ror r2	; <UNPREDICTABLE>
 63c:	656b5f34 	strbvs	r5, [fp, #-3892]!	; 0xfffff0cc
 640:	6c656e72 	stclvs	14, cr6, [r5], #-456	; 0xfffffe38
 644:	72656b2f 	rsbvc	r6, r5, #48128	; 0xbc00
 648:	2f6c656e 	svccs	0x006c656e
 64c:	00637273 	rsbeq	r7, r3, r3, ror r2
 650:	61747300 	cmnvs	r4, r0, lsl #6
 654:	70757472 	rsbsvc	r7, r5, r2, ror r4
 658:	7070632e 	rsbsvc	r6, r0, lr, lsr #6
 65c:	00000100 	andeq	r0, r0, r0, lsl #2
 660:	00010500 	andeq	r0, r1, r0, lsl #10
 664:	89140205 	ldmdbhi	r4, {r0, r2, r9}
 668:	14030000 	strne	r0, [r3], #-0
 66c:	6a090501 	bvs	241a78 <_bss_end+0x238d78>
 670:	05660205 	strbeq	r0, [r6, #-517]!	; 0xfffffdfb
 674:	04020006 	streq	r0, [r2], #-6
 678:	02052f03 	andeq	r2, r5, #3, 30
 67c:	03040200 	movweq	r0, #16896	; 0x4200
 680:	001f0565 	andseq	r0, pc, r5, ror #10
 684:	66010402 	strvs	r0, [r1], -r2, lsl #8
 688:	05bd0905 	ldreq	r0, [sp, #2309]!	; 0x905
 68c:	05bd2f01 	ldreq	r2, [sp, #3841]!	; 0xf01
 690:	02056b0d 	andeq	r6, r5, #13312	; 0x3400
 694:	0004054a 	andeq	r0, r4, sl, asr #10
 698:	2f030402 	svccs	0x00030402
 69c:	02000b05 	andeq	r0, r0, #5120	; 0x1400
 6a0:	054a0304 	strbeq	r0, [sl, #-772]	; 0xfffffcfc
 6a4:	04020002 	streq	r0, [r2], #-2
 6a8:	24052d03 	strcs	r2, [r5], #-3331	; 0xfffff2fd
 6ac:	01040200 	mrseq	r0, R12_usr
 6b0:	85090566 	strhi	r0, [r9, #-1382]	; 0xfffffa9a
 6b4:	a12f0105 			; <UNDEFINED> instruction: 0xa12f0105
 6b8:	056a0d05 	strbeq	r0, [sl, #-3333]!	; 0xfffff2fb
 6bc:	04054a02 	streq	r4, [r5], #-2562	; 0xfffff5fe
 6c0:	03040200 	movweq	r0, #16896	; 0x4200
 6c4:	000b052f 	andeq	r0, fp, pc, lsr #10
 6c8:	4a030402 	bmi	c16d8 <_bss_end+0xb89d8>
 6cc:	02000205 	andeq	r0, r0, #1342177280	; 0x50000000
 6d0:	052d0304 	streq	r0, [sp, #-772]!	; 0xfffffcfc
 6d4:	04020024 	streq	r0, [r2], #-36	; 0xffffffdc
 6d8:	09056601 	stmdbeq	r5, {r0, r9, sl, sp, lr}
 6dc:	2f010585 	svccs	0x00010585
 6e0:	01000a02 	tsteq	r0, r2, lsl #20
 6e4:	00006f01 	andeq	r6, r0, r1, lsl #30
 6e8:	04000500 	streq	r0, [r0], #-1280	; 0xfffffb00
 6ec:	00002e00 	andeq	r2, r0, r0, lsl #28
 6f0:	01010200 	mrseq	r0, R9_usr
 6f4:	000d0efb 	strdeq	r0, [sp], -fp
 6f8:	01010101 	tsteq	r1, r1, lsl #2
 6fc:	01000000 	mrseq	r0, (UNDEF: 0)
 700:	01010000 	mrseq	r0, (UNDEF: 1)
 704:	69021f01 	stmdbvs	r2, {r0, r8, r9, sl, fp, ip}
 708:	69000000 	stmdbvs	r0, {}	; <UNPREDICTABLE>
 70c:	02000000 	andeq	r0, r0, #0
 710:	0f021f01 	svceq	0x00021f01
 714:	00009802 	andeq	r9, r0, r2, lsl #16
 718:	00980000 	addseq	r0, r8, r0
 71c:	00010000 	andeq	r0, r1, r0
 720:	8a2c0205 	bhi	b00f3c <_bss_end+0xaf823c>
 724:	90030000 	andls	r0, r3, r0
 728:	302f010a 	eorcc	r0, pc, sl, lsl #2
 72c:	2f2f2f30 	svccs	0x002f2f30
 730:	2f2f2f30 	svccs	0x002f2f30
 734:	d002302f 	andle	r3, r2, pc, lsr #32
 738:	2f301401 	svccs	0x00301401
 73c:	312f3030 			; <UNDEFINED> instruction: 0x312f3030
 740:	302f2f30 	eorcc	r2, pc, r0, lsr pc	; <UNPREDICTABLE>
 744:	2f302f4c 	svccs	0x00302f4c
 748:	821f0332 	andshi	r0, pc, #-939524096	; 0xc8000000
 74c:	2f2f2f2f 	svccs	0x002f2f2f
 750:	022f2f2f 	eoreq	r2, pc, #47, 30	; 0xbc
 754:	01010002 	tsteq	r1, r2
 758:	00000046 	andeq	r0, r0, r6, asr #32
 75c:	00040005 	andeq	r0, r4, r5
 760:	0000002e 	andeq	r0, r0, lr, lsr #32
 764:	fb010102 	blx	40b76 <_bss_end+0x37e76>
 768:	01000d0e 	tsteq	r0, lr, lsl #26
 76c:	00010101 	andeq	r0, r1, r1, lsl #2
 770:	00010000 	andeq	r0, r1, r0
 774:	01010100 	mrseq	r0, (UNDEF: 17)
 778:	0069021f 	rsbeq	r0, r9, pc, lsl r2
 77c:	00690000 	rsbeq	r0, r9, r0
 780:	01020000 	mrseq	r0, (UNDEF: 2)
 784:	020f021f 	andeq	r0, pc, #-268435455	; 0xf0000001
 788:	00000098 	muleq	r0, r8, r0
 78c:	00009800 	andeq	r9, r0, r0, lsl #16
 790:	05000100 	streq	r0, [r0, #-256]	; 0xffffff00
 794:	008c6c02 	addeq	r6, ip, r2, lsl #24
 798:	0bb90300 	bleq	fee413a0 <_bss_end+0xfee386a0>
 79c:	00020201 	andeq	r0, r2, r1, lsl #4
 7a0:	00ba0101 	adcseq	r0, sl, r1, lsl #2
 7a4:	00030000 	andeq	r0, r3, r0
 7a8:	000000b4 	strheq	r0, [r0], -r4
 7ac:	0efb0102 	cdpeq	1, 15, cr0, cr11, cr2, {0}
 7b0:	0101000d 	tsteq	r1, sp
 7b4:	00000101 	andeq	r0, r0, r1, lsl #2
 7b8:	00000100 	andeq	r0, r0, r0, lsl #2
 7bc:	2f2e2e01 	svccs	0x002e2e01
 7c0:	2e2f2e2e 	cdpcs	14, 2, cr2, cr15, cr14, {1}
 7c4:	2e2e2f2e 	cdpcs	15, 2, cr2, cr14, cr14, {1}
 7c8:	2f2e2e2f 	svccs	0x002e2e2f
 7cc:	672f2e2e 	strvs	r2, [pc, -lr, lsr #28]!
 7d0:	312d6363 			; <UNDEFINED> instruction: 0x312d6363
 7d4:	2e322e32 	mrccs	14, 1, r2, cr2, cr2, {1}
 7d8:	696c2f30 	stmdbvs	ip!, {r4, r5, r8, r9, sl, fp, sp}^
 7dc:	63636762 	cmnvs	r3, #25690112	; 0x1880000
 7e0:	2f2e2e00 	svccs	0x002e2e00
 7e4:	2e2f2e2e 	cdpcs	14, 2, cr2, cr15, cr14, {1}
 7e8:	2e2e2f2e 	cdpcs	15, 2, cr2, cr14, cr14, {1}
 7ec:	2f2e2e2f 	svccs	0x002e2e2f
 7f0:	63672f2e 	cmnvs	r7, #46, 30	; 0xb8
 7f4:	2e2e0063 	cdpcs	0, 2, cr0, cr14, cr3, {3}
 7f8:	2f2e2e2f 	svccs	0x002e2e2f
 7fc:	2e2f2e2e 	cdpcs	14, 2, cr2, cr15, cr14, {1}
 800:	2e2e2f2e 	cdpcs	15, 2, cr2, cr14, cr14, {1}
 804:	2f2e2e2f 	svccs	0x002e2e2f
 808:	2d636367 	stclcs	3, cr6, [r3, #-412]!	; 0xfffffe64
 80c:	322e3231 	eorcc	r3, lr, #268435459	; 0x10000003
 810:	6c2f302e 	stcvs	0, cr3, [pc], #-184	; 760 <shift+0x760>
 814:	63676269 	cmnvs	r7, #-1879048186	; 0x90000006
 818:	2e2e2f63 	cdpcs	15, 2, cr2, cr14, cr3, {3}
 81c:	6363672f 	cmnvs	r3, #12320768	; 0xbc0000
 820:	6e6f632f 	cdpvs	3, 6, cr6, cr15, cr15, {1}
 824:	2f676966 	svccs	0x00676966
 828:	006d7261 	rsbeq	r7, sp, r1, ror #4
 82c:	62696c00 	rsbvs	r6, r9, #0, 24
 830:	32636367 	rsbcc	r6, r3, #-1677721599	; 0x9c000001
 834:	0100632e 	tsteq	r0, lr, lsr #6
 838:	72610000 	rsbvc	r0, r1, #0
 83c:	73692d6d 	cmnvc	r9, #6976	; 0x1b40
 840:	00682e61 	rsbeq	r2, r8, r1, ror #28
 844:	61000002 	tstvs	r0, r2
 848:	682e6d72 	stmdavs	lr!, {r1, r4, r5, r6, r8, sl, fp, sp, lr}
 84c:	00000300 	andeq	r0, r0, r0, lsl #6
 850:	2d6c6267 	sfmcs	f6, 2, [ip, #-412]!	; 0xfffffe64
 854:	726f7463 	rsbvc	r7, pc, #1660944384	; 0x63000000
 858:	00682e73 	rsbeq	r2, r8, r3, ror lr
 85c:	00000001 	andeq	r0, r0, r1

Disassembly of section .debug_str:

00000000 <.debug_str>:
   0:	78635f5f 	stmdavc	r3!, {r0, r1, r2, r3, r4, r6, r8, r9, sl, fp, ip, lr}^
   4:	75675f61 	strbvc	r5, [r7, #-3937]!	; 0xfffff09f
   8:	5f647261 	svcpl	0x00647261
   c:	656c6572 	strbvs	r6, [ip, #-1394]!	; 0xfffffa8e
  10:	00657361 	rsbeq	r7, r5, r1, ror #6
  14:	78635f5f 	stmdavc	r3!, {r0, r1, r2, r3, r4, r6, r8, r9, sl, fp, ip, lr}^
  18:	75675f61 	strbvc	r5, [r7, #-3937]!	; 0xfffff09f
  1c:	5f647261 	svcpl	0x00647261
  20:	726f6261 	rsbvc	r6, pc, #268435462	; 0x10000006
  24:	5f5f0074 	svcpl	0x005f0074
  28:	5f6f7364 	svcpl	0x006f7364
  2c:	646e6168 	strbtvs	r6, [lr], #-360	; 0xfffffe98
  30:	5f00656c 	svcpl	0x0000656c
  34:	6178635f 	cmnvs	r8, pc, asr r3
  38:	6574615f 	ldrbvs	r6, [r4, #-351]!	; 0xfffffea1
  3c:	00746978 	rsbseq	r6, r4, r8, ror r9
  40:	6d6f682f 	stclvs	8, cr6, [pc, #-188]!	; ffffff8c <_bss_end+0xffff728c>
  44:	66632f65 	strbtvs	r2, [r3], -r5, ror #30
  48:	55435a2f 	strbpl	r5, [r3, #-2607]	; 0xfffff5d1
  4c:	2f534f2f 	svccs	0x00534f2f
  50:	63617270 	cmnvs	r1, #112, 4
  54:	61636974 	smcvs	13972	; 0x3694
  58:	78652f6c 	stmdavc	r5!, {r2, r3, r5, r6, r8, r9, sl, fp, sp}^
  5c:	34302f32 	ldrtcc	r2, [r0], #-3890	; 0xfffff0ce
  60:	72656b5f 	rsbvc	r6, r5, #97280	; 0x17c00
  64:	2f6c656e 	svccs	0x006c656e
  68:	6c697562 	cfstr64vs	mvdx7, [r9], #-392	; 0xfffffe78
  6c:	4e470064 	cdpmi	0, 4, cr0, cr7, cr4, {3}
  70:	2b432055 	blcs	10c81cc <_bss_end+0x10bf4cc>
  74:	2037312b 	eorscs	r3, r7, fp, lsr #2
  78:	322e3231 	eorcc	r3, lr, #268435459	; 0x10000003
  7c:	2d20302e 	stccs	0, cr3, [r0, #-184]!	; 0xffffff48
  80:	6f6c666d 	svcvs	0x006c666d
  84:	612d7461 			; <UNDEFINED> instruction: 0x612d7461
  88:	683d6962 	ldmdavs	sp!, {r1, r5, r6, r8, fp, sp, lr}
  8c:	20647261 	rsbcs	r7, r4, r1, ror #4
  90:	70666d2d 	rsbvc	r6, r6, sp, lsr #26
  94:	66763d75 			; <UNDEFINED> instruction: 0x66763d75
  98:	6d2d2070 	stcvs	0, cr2, [sp, #-448]!	; 0xfffffe40
  9c:	616f6c66 	cmnvs	pc, r6, ror #24
  a0:	62612d74 	rsbvs	r2, r1, #116, 26	; 0x1d00
  a4:	61683d69 	cmnvs	r8, r9, ror #26
  a8:	2d206472 	cfstrscs	mvf6, [r0, #-456]!	; 0xfffffe38
  ac:	7570666d 	ldrbvc	r6, [r0, #-1645]!	; 0xfffff993
  b0:	7066763d 	rsbvc	r7, r6, sp, lsr r6
  b4:	746d2d20 	strbtvc	r2, [sp], #-3360	; 0xfffff2e0
  b8:	3d656e75 	stclcc	14, cr6, [r5, #-468]!	; 0xfffffe2c
  bc:	316d7261 	cmncc	sp, r1, ror #4
  c0:	6a363731 	bvs	d8dd8c <_bss_end+0xd8508c>
  c4:	732d667a 			; <UNDEFINED> instruction: 0x732d667a
  c8:	616d2d20 	cmnvs	sp, r0, lsr #26
  cc:	2d206d72 	stccs	13, cr6, [r0, #-456]!	; 0xfffffe38
  d0:	6372616d 	cmnvs	r2, #1073741851	; 0x4000001b
  d4:	72613d68 	rsbvc	r3, r1, #104, 26	; 0x1a00
  d8:	7a36766d 	bvc	d9da94 <_bss_end+0xd94d94>
  dc:	70662b6b 	rsbvc	r2, r6, fp, ror #22
  e0:	20672d20 	rsbcs	r2, r7, r0, lsr #26
  e4:	2d20672d 	stccs	7, cr6, [r0, #-180]!	; 0xffffff4c
  e8:	2d20304f 	stccs	0, cr3, [r0, #-316]!	; 0xfffffec4
  ec:	5f00304f 	svcpl	0x0000304f
  f0:	6178635f 	cmnvs	r8, pc, asr r3
  f4:	6175675f 	cmnvs	r5, pc, asr r7
  f8:	615f6472 	cmpvs	pc, r2, ror r4	; <UNPREDICTABLE>
  fc:	69757163 	ldmdbvs	r5!, {r0, r1, r5, r6, r8, ip, sp, lr}^
 100:	5f006572 	svcpl	0x00006572
 104:	7878635f 	ldmdavc	r8!, {r0, r1, r2, r3, r4, r6, r8, r9, sp, lr}^
 108:	76696261 	strbtvc	r6, [r9], -r1, ror #4
 10c:	6f6c0031 	svcvs	0x006c0031
 110:	6c20676e 	stcvs	7, cr6, [r0], #-440	; 0xfffffe48
 114:	20676e6f 	rsbcs	r6, r7, pc, ror #28
 118:	00746e69 	rsbseq	r6, r4, r9, ror #28
 11c:	78635f5f 	stmdavc	r3!, {r0, r1, r2, r3, r4, r6, r8, r9, sl, fp, ip, lr}^
 120:	75705f61 	ldrbvc	r5, [r0, #-3937]!	; 0xfffff09f
 124:	765f6572 			; <UNDEFINED> instruction: 0x765f6572
 128:	75747269 	ldrbvc	r7, [r4, #-617]!	; 0xfffffd97
 12c:	5f006c61 	svcpl	0x00006c61
 130:	6165615f 	cmnvs	r5, pc, asr r1
 134:	755f6962 	ldrbvc	r6, [pc, #-2402]	; fffff7da <_bss_end+0xffff6ada>
 138:	6e69776e 	cdpvs	7, 6, cr7, cr9, cr14, {3}
 13c:	70635f64 	rsbvc	r5, r3, r4, ror #30
 140:	72705f70 	rsbsvc	r5, r0, #112, 30	; 0x1c0
 144:	5f5f0031 	svcpl	0x005f0031
 148:	72617567 	rsbvc	r7, r1, #432013312	; 0x19c00000
 14c:	682f0064 	stmdavs	pc!, {r2, r5, r6}	; <UNPREDICTABLE>
 150:	2f656d6f 	svccs	0x00656d6f
 154:	5a2f6663 	bpl	bd9ae8 <_bss_end+0xbd0de8>
 158:	4f2f5543 	svcmi	0x002f5543
 15c:	72702f53 	rsbsvc	r2, r0, #332	; 0x14c
 160:	69746361 	ldmdbvs	r4!, {r0, r5, r6, r8, r9, sp, lr}^
 164:	2f6c6163 	svccs	0x006c6163
 168:	2f327865 	svccs	0x00327865
 16c:	6b5f3430 	blvs	17cd234 <_bss_end+0x17c4534>
 170:	656e7265 	strbvs	r7, [lr, #-613]!	; 0xfffffd9b
 174:	656b2f6c 	strbvs	r2, [fp, #-3948]!	; 0xfffff094
 178:	6c656e72 	stclvs	14, cr6, [r5], #-456	; 0xfffffe38
 17c:	6372732f 	cmnvs	r2, #-1140850688	; 0xbc000000
 180:	7878632f 	ldmdavc	r8!, {r0, r1, r2, r3, r5, r8, r9, sp, lr}^
 184:	7070632e 	rsbsvc	r6, r0, lr, lsr #6
 188:	52504700 	subspl	r4, r0, #0, 14
 18c:	00304e45 	eorseq	r4, r0, r5, asr #28
 190:	45525047 	ldrbmi	r5, [r2, #-71]	; 0xffffffb9
 194:	4700314e 	strmi	r3, [r0, -lr, asr #2]
 198:	45464150 	strbmi	r4, [r6, #-336]	; 0xfffffeb0
 19c:	4300314e 	movwmi	r3, #334	; 0x14e
 1a0:	4f495047 	svcmi	0x00495047
 1a4:	6e61485f 	mcrvs	8, 3, r4, cr1, cr15, {2}
 1a8:	72656c64 	rsbvc	r6, r5, #100, 24	; 0x6400
 1ac:	74655300 	strbtvc	r5, [r5], #-768	; 0xfffffd00
 1b0:	74754f5f 	ldrbtvc	r4, [r5], #-3935	; 0xfffff0a1
 1b4:	00747570 	rsbseq	r7, r4, r0, ror r5
 1b8:	70736e55 	rsbsvc	r6, r3, r5, asr lr
 1bc:	66696365 	strbtvs	r6, [r9], -r5, ror #6
 1c0:	00646569 	rsbeq	r6, r4, r9, ror #10
 1c4:	6f697067 	svcvs	0x00697067
 1c8:	7361625f 	cmnvc	r1, #-268435451	; 0xf0000005
 1cc:	64615f65 	strbtvs	r5, [r1], #-3941	; 0xfffff09b
 1d0:	5f007264 	svcpl	0x00007264
 1d4:	314b4e5a 	cmpcc	fp, sl, asr lr
 1d8:	50474333 	subpl	r4, r7, r3, lsr r3
 1dc:	485f4f49 	ldmdami	pc, {r0, r3, r6, r8, r9, sl, fp, lr}^	; <UNPREDICTABLE>
 1e0:	6c646e61 	stclvs	14, cr6, [r4], #-388	; 0xfffffe7c
 1e4:	38317265 	ldmdacc	r1!, {r0, r2, r5, r6, r9, ip, sp, lr}
 1e8:	5f746547 	svcpl	0x00746547
 1ec:	454c5047 	strbmi	r5, [ip, #-71]	; 0xffffffb9
 1f0:	6f4c5f56 	svcvs	0x004c5f56
 1f4:	69746163 	ldmdbvs	r4!, {r0, r1, r5, r6, r8, sp, lr}^
 1f8:	6a456e6f 	bvs	115bbbc <_bss_end+0x1152ebc>
 1fc:	30536a52 	subscc	r6, r3, r2, asr sl
 200:	6547005f 	strbvs	r0, [r7, #-95]	; 0xffffffa1
 204:	50475f74 	subpl	r5, r7, r4, ror pc
 208:	465f4f49 	ldrbmi	r4, [pc], -r9, asr #30
 20c:	74636e75 	strbtvc	r6, [r3], #-3701	; 0xfffff18b
 210:	006e6f69 	rsbeq	r6, lr, r9, ror #30
 214:	4b4e5a5f 	blmi	1396b98 <_bss_end+0x138de98>
 218:	47433331 	smlaldxmi	r3, r3, r1, r3	; <UNPREDICTABLE>
 21c:	5f4f4950 	svcpl	0x004f4950
 220:	646e6148 	strbtvs	r6, [lr], #-328	; 0xfffffeb8
 224:	3172656c 	cmncc	r2, ip, ror #10
 228:	74654738 	strbtvc	r4, [r5], #-1848	; 0xfffff8c8
 22c:	5350475f 	cmppl	r0, #24903680	; 0x17c0000
 230:	4c5f5445 	cfldrdmi	mvd5, [pc], {69}	; 0x45
 234:	7461636f 	strbtvc	r6, [r1], #-879	; 0xfffffc91
 238:	456e6f69 	strbmi	r6, [lr, #-3945]!	; 0xfffff097
 23c:	536a526a 	cmnpl	sl, #-1610612730	; 0xa0000006
 240:	5f005f30 	svcpl	0x00005f30
 244:	314b4e5a 	cmpcc	fp, sl, asr lr
 248:	50474333 	subpl	r4, r7, r3, lsr r3
 24c:	485f4f49 	ldmdami	pc, {r0, r3, r6, r8, r9, sl, fp, lr}^	; <UNPREDICTABLE>
 250:	6c646e61 	stclvs	14, cr6, [r4], #-388	; 0xfffffe7c
 254:	38317265 	ldmdacc	r1!, {r0, r2, r5, r6, r9, ip, sp, lr}
 258:	5f746547 	svcpl	0x00746547
 25c:	4c435047 	mcrrmi	0, 4, r5, r3, cr7
 260:	6f4c5f52 	svcvs	0x004c5f52
 264:	69746163 	ldmdbvs	r4!, {r0, r1, r5, r6, r8, sp, lr}^
 268:	6a456e6f 	bvs	115bc2c <_bss_end+0x1152f2c>
 26c:	30536a52 	subscc	r6, r3, r2, asr sl
 270:	5047005f 	subpl	r0, r7, pc, asr r0
 274:	31524c43 	cmpcc	r2, r3, asr #24
 278:	4c475f00 	mcrrmi	15, 0, r5, r7, cr0
 27c:	4c41424f 	sfmmi	f4, 2, [r1], {79}	; 0x4f
 280:	75735f5f 	ldrbvc	r5, [r3, #-3935]!	; 0xfffff0a1
 284:	5f495f62 	svcpl	0x00495f62
 288:	49504773 	ldmdbmi	r0, {r0, r1, r4, r5, r6, r8, r9, sl, lr}^
 28c:	6547004f 	strbvs	r0, [r7, #-79]	; 0xffffffb1
 290:	50475f74 	subpl	r5, r7, r4, ror pc
 294:	4c455346 	mcrrmi	3, 4, r5, r5, cr6
 298:	636f4c5f 	cmnvs	pc, #24320	; 0x5f00
 29c:	6f697461 	svcvs	0x00697461
 2a0:	5a5f006e 	bpl	17c0460 <_bss_end+0x17b7760>
 2a4:	33314b4e 	teqcc	r1, #79872	; 0x13800
 2a8:	49504743 	ldmdbmi	r0, {r0, r1, r6, r8, r9, sl, lr}^
 2ac:	61485f4f 	cmpvs	r8, pc, asr #30
 2b0:	656c646e 	strbvs	r6, [ip, #-1134]!	; 0xfffffb92
 2b4:	47393172 			; <UNDEFINED> instruction: 0x47393172
 2b8:	475f7465 	ldrbmi	r7, [pc, -r5, ror #8]
 2bc:	45534650 	ldrbmi	r4, [r3, #-1616]	; 0xfffff9b0
 2c0:	6f4c5f4c 	svcvs	0x004c5f4c
 2c4:	69746163 	ldmdbvs	r4!, {r0, r1, r5, r6, r8, sp, lr}^
 2c8:	6a456e6f 	bvs	115bc8c <_bss_end+0x1152f8c>
 2cc:	30536a52 	subscc	r6, r3, r2, asr sl
 2d0:	6547005f 	strbvs	r0, [r7, #-95]	; 0xffffffa1
 2d4:	50475f74 	subpl	r5, r7, r4, ror pc
 2d8:	5f544553 	svcpl	0x00544553
 2dc:	61636f4c 	cmnvs	r3, ip, asr #30
 2e0:	6e6f6974 			; <UNDEFINED> instruction: 0x6e6f6974
 2e4:	50504700 	subspl	r4, r0, r0, lsl #14
 2e8:	4c434455 	cfstrdmi	mvd4, [r3], {85}	; 0x55
 2ec:	4700304b 	strmi	r3, [r0, -fp, asr #32]
 2f0:	5f4f4950 	svcpl	0x004f4950
 2f4:	00676552 	rsbeq	r6, r7, r2, asr r5
 2f8:	454c5047 	strbmi	r5, [ip, #-71]	; 0xffffffb9
 2fc:	47003056 	smlsdmi	r0, r6, r0, r3
 300:	56454c50 			; <UNDEFINED> instruction: 0x56454c50
 304:	6c410031 	mcrrvs	0, 3, r0, r1, cr1
 308:	00335f74 	eorseq	r5, r3, r4, ror pc
 30c:	55505047 	ldrbpl	r5, [r0, #-71]	; 0xffffffb9
 310:	4b4c4344 	blmi	1311028 <_bss_end+0x1308328>
 314:	50470031 	subpl	r0, r7, r1, lsr r0
 318:	00445550 	subeq	r5, r4, r0, asr r5
 31c:	69736e75 	ldmdbvs	r3!, {r0, r2, r4, r5, r6, r9, sl, fp, sp, lr}^
 320:	64656e67 	strbtvs	r6, [r5], #-3687	; 0xfffff199
 324:	61686320 	cmnvs	r8, r0, lsr #6
 328:	6c410072 	mcrrvs	0, 7, r0, r1, cr2
 32c:	00325f74 	eorseq	r5, r2, r4, ror pc
 330:	5f746c41 	svcpl	0x00746c41
 334:	65470030 	strbvs	r0, [r7, #-48]	; 0xffffffd0
 338:	50475f74 	subpl	r5, r7, r4, ror pc
 33c:	5f524c43 	svcpl	0x00524c43
 340:	61636f4c 	cmnvs	r3, ip, asr #30
 344:	6e6f6974 			; <UNDEFINED> instruction: 0x6e6f6974
 348:	746c4100 	strbtvc	r4, [ip], #-256	; 0xffffff00
 34c:	4700315f 	smlsdmi	r0, pc, r1, r3	; <UNPREDICTABLE>
 350:	524c4350 	subpl	r4, ip, #80, 6	; 0x40000001
 354:	68730030 	ldmdavs	r3!, {r4, r5}^
 358:	2074726f 	rsbscs	r7, r4, pc, ror #4
 35c:	69736e75 	ldmdbvs	r3!, {r0, r2, r4, r5, r6, r9, sl, fp, sp, lr}^
 360:	64656e67 	strbtvs	r6, [r5], #-3687	; 0xfffff199
 364:	746e6920 	strbtvc	r6, [lr], #-2336	; 0xfffff6e0
 368:	49504700 	ldmdbmi	r0, {r8, r9, sl, lr}^
 36c:	69505f4f 	ldmdbvs	r0, {r0, r1, r2, r3, r6, r8, r9, sl, fp, ip, lr}^
 370:	6f435f6e 	svcvs	0x00435f6e
 374:	00746e75 	rsbseq	r6, r4, r5, ror lr
 378:	45535047 	ldrbmi	r5, [r3, #-71]	; 0xffffffb9
 37c:	47003054 	smlsdmi	r0, r4, r0, r3
 380:	54455350 	strbpl	r5, [r5], #-848	; 0xfffffcb0
 384:	6c410031 	mcrrvs	0, 3, r0, r1, cr1
 388:	00345f74 	eorseq	r5, r4, r4, ror pc
 38c:	5f746c41 	svcpl	0x00746c41
 390:	5a5f0035 	bpl	17c046c <_bss_end+0x17b776c>
 394:	4333314e 	teqmi	r3, #-2147483629	; 0x80000013
 398:	4f495047 	svcmi	0x00495047
 39c:	6e61485f 	mcrvs	8, 3, r4, cr1, cr15, {2}
 3a0:	72656c64 	rsbvc	r6, r5, #100, 24	; 0x6400
 3a4:	65533031 	ldrbvs	r3, [r3, #-49]	; 0xffffffcf
 3a8:	754f5f74 	strbvc	r5, [pc, #-3956]	; fffff43c <_bss_end+0xffff673c>
 3ac:	74757074 	ldrbtvc	r7, [r5], #-116	; 0xffffff8c
 3b0:	00626a45 	rsbeq	r6, r2, r5, asr #20
 3b4:	5f746553 	svcpl	0x00746553
 3b8:	4f495047 	svcmi	0x00495047
 3bc:	6e75465f 	mrcvs	6, 3, r4, cr5, cr15, {2}
 3c0:	6f697463 	svcvs	0x00697463
 3c4:	5047006e 	subpl	r0, r7, lr, rrx
 3c8:	304e4546 	subcc	r4, lr, r6, asr #10
 3cc:	46504700 	ldrbmi	r4, [r0], -r0, lsl #14
 3d0:	00314e45 	eorseq	r4, r1, r5, asr #28
 3d4:	636e7566 	cmnvs	lr, #427819008	; 0x19800000
 3d8:	46504700 	ldrbmi	r4, [r0], -r0, lsl #14
 3dc:	344c4553 	strbcc	r4, [ip], #-1363	; 0xfffffaad
 3e0:	72655000 	rsbvc	r5, r5, #0
 3e4:	65687069 	strbvs	r7, [r8, #-105]!	; 0xffffff97
 3e8:	5f6c6172 	svcpl	0x006c6172
 3ec:	65736142 	ldrbvs	r6, [r3, #-322]!	; 0xfffffebe
 3f0:	706e4900 	rsbvc	r4, lr, r0, lsl #18
 3f4:	5f007475 	svcpl	0x00007475
 3f8:	6972705f 	ldmdbvs	r2!, {r0, r1, r2, r3, r4, r6, ip, sp, lr}^
 3fc:	7469726f 	strbtvc	r7, [r9], #-623	; 0xfffffd91
 400:	50470079 	subpl	r0, r7, r9, ror r0
 404:	30534445 	subscc	r4, r3, r5, asr #8
 408:	45504700 	ldrbmi	r4, [r0, #-1792]	; 0xfffff900
 40c:	00315344 	eorseq	r5, r1, r4, asr #6
 410:	52415047 	subpl	r5, r1, #71	; 0x47
 414:	00304e45 	eorseq	r4, r0, r5, asr #28
 418:	52415047 	subpl	r5, r1, #71	; 0x47
 41c:	00314e45 	eorseq	r4, r1, r5, asr #28
 420:	746e6975 	strbtvc	r6, [lr], #-2421	; 0xfffff68b
 424:	00745f38 	rsbseq	r5, r4, r8, lsr pc
 428:	73696874 	cmnvc	r9, #116, 16	; 0x740000
 42c:	4e5a5f00 	cdpmi	15, 5, cr5, cr10, cr0, {0}
 430:	4333314b 	teqmi	r3, #-1073741806	; 0xc0000012
 434:	4f495047 	svcmi	0x00495047
 438:	6e61485f 	mcrvs	8, 3, r4, cr1, cr15, {2}
 43c:	72656c64 	rsbvc	r6, r5, #100, 24	; 0x6400
 440:	65473731 	strbvs	r3, [r7, #-1841]	; 0xfffff8cf
 444:	50475f74 	subpl	r5, r7, r4, ror pc
 448:	465f4f49 	ldrbmi	r4, [pc], -r9, asr #30
 44c:	74636e75 	strbtvc	r6, [r3], #-3701	; 0xfffff18b
 450:	456e6f69 	strbmi	r6, [lr, #-3945]!	; 0xfffff097
 454:	682f006a 	stmdavs	pc!, {r1, r3, r5, r6}	; <UNPREDICTABLE>
 458:	2f656d6f 	svccs	0x00656d6f
 45c:	5a2f6663 	bpl	bd9df0 <_bss_end+0xbd10f0>
 460:	4f2f5543 	svcmi	0x002f5543
 464:	72702f53 	rsbsvc	r2, r0, #332	; 0x14c
 468:	69746361 	ldmdbvs	r4!, {r0, r5, r6, r8, r9, sp, lr}^
 46c:	2f6c6163 	svccs	0x006c6163
 470:	2f327865 	svccs	0x00327865
 474:	6b5f3430 	blvs	17cd53c <_bss_end+0x17c483c>
 478:	656e7265 	strbvs	r7, [lr, #-613]!	; 0xfffffd9b
 47c:	656b2f6c 	strbvs	r2, [fp, #-3948]!	; 0xfffff094
 480:	6c656e72 	stclvs	14, cr6, [r5], #-456	; 0xfffffe38
 484:	6372732f 	cmnvs	r2, #-1140850688	; 0xbc000000
 488:	6972642f 	ldmdbvs	r2!, {r0, r1, r2, r3, r5, sl, sp, lr}^
 48c:	73726576 	cmnvc	r2, #494927872	; 0x1d800000
 490:	6970672f 	ldmdbvs	r0!, {r0, r1, r2, r3, r5, r8, r9, sl, sp, lr}^
 494:	70632e6f 	rsbvc	r2, r3, pc, ror #28
 498:	5a5f0070 	bpl	17c0660 <_bss_end+0x17b7960>
 49c:	4333314e 	teqmi	r3, #-2147483629	; 0x80000013
 4a0:	4f495047 	svcmi	0x00495047
 4a4:	6e61485f 	mcrvs	8, 3, r4, cr1, cr15, {2}
 4a8:	72656c64 	rsbvc	r6, r5, #100, 24	; 0x6400
 4ac:	6a453243 	bvs	114cdc0 <_bss_end+0x11440c0>
 4b0:	50476d00 	subpl	r6, r7, r0, lsl #26
 4b4:	5f004f49 	svcpl	0x00004f49
 4b8:	33314e5a 	teqcc	r1, #1440	; 0x5a0
 4bc:	49504743 	ldmdbmi	r0, {r0, r1, r6, r8, r9, sl, lr}^
 4c0:	61485f4f 	cmpvs	r8, pc, asr #30
 4c4:	656c646e 	strbvs	r6, [ip, #-1134]!	; 0xfffffb92
 4c8:	53373172 	teqpl	r7, #-2147483620	; 0x8000001c
 4cc:	475f7465 	ldrbmi	r7, [pc, -r5, ror #8]
 4d0:	5f4f4950 	svcpl	0x004f4950
 4d4:	636e7546 	cmnvs	lr, #293601280	; 0x11800000
 4d8:	6e6f6974 			; <UNDEFINED> instruction: 0x6e6f6974
 4dc:	34316a45 	ldrtcc	r6, [r1], #-2629	; 0xfffff5bb
 4e0:	4950474e 	ldmdbmi	r0, {r1, r2, r3, r6, r8, r9, sl, lr}^
 4e4:	75465f4f 	strbvc	r5, [r6, #-3919]	; 0xfffff0b1
 4e8:	6974636e 	ldmdbvs	r4!, {r1, r2, r3, r5, r6, r8, r9, sp, lr}^
 4ec:	47006e6f 	strmi	r6, [r0, -pc, ror #28]
 4f0:	45464150 	strbmi	r4, [r6, #-336]	; 0xfffffeb0
 4f4:	4700304e 	strmi	r3, [r0, -lr, asr #32]
 4f8:	4e454c50 	mcrmi	12, 2, r4, cr5, cr0, {2}
 4fc:	50470030 	subpl	r0, r7, r0, lsr r0
 500:	314e454c 	cmpcc	lr, ip, asr #10
 504:	74696200 	strbtvc	r6, [r9], #-512	; 0xfffffe00
 508:	7864695f 	stmdavc	r4!, {r0, r1, r2, r3, r4, r6, r8, fp, sp, lr}^
 50c:	6f687300 	svcvs	0x00687300
 510:	69207472 	stmdbvs	r0!, {r1, r4, r5, r6, sl, ip, sp, lr}
 514:	7500746e 	strvc	r7, [r0, #-1134]	; 0xfffffb92
 518:	33746e69 	cmncc	r4, #1680	; 0x690
 51c:	00745f32 	rsbseq	r5, r4, r2, lsr pc
 520:	6c6f6f62 	stclvs	15, cr6, [pc], #-392	; 3a0 <shift+0x3a0>
 524:	48504700 	ldmdami	r0, {r8, r9, sl, lr}^
 528:	00304e45 	eorseq	r4, r0, r5, asr #28
 52c:	45485047 	strbmi	r5, [r8, #-71]	; 0xffffffb9
 530:	5f00314e 	svcpl	0x0000314e
 534:	696e695f 	stmdbvs	lr!, {r0, r1, r2, r3, r4, r6, r8, fp, sp, lr}^
 538:	6c616974 			; <UNDEFINED> instruction: 0x6c616974
 53c:	5f657a69 	svcpl	0x00657a69
 540:	5a5f0070 	bpl	17c0708 <_bss_end+0x17b7a08>
 544:	4333314e 	teqmi	r3, #-2147483629	; 0x80000013
 548:	4f495047 	svcmi	0x00495047
 54c:	6e61485f 	mcrvs	8, 3, r4, cr1, cr15, {2}
 550:	72656c64 	rsbvc	r6, r5, #100, 24	; 0x6400
 554:	6a453443 	bvs	114d668 <_bss_end+0x1144968>
 558:	74654700 	strbtvc	r4, [r5], #-1792	; 0xfffff900
 55c:	4c50475f 	mrrcmi	7, 5, r4, r0, cr15
 560:	4c5f5645 	mrrcmi	6, 4, r5, pc, cr5	; <UNPREDICTABLE>
 564:	7461636f 	strbtvc	r6, [r1], #-879	; 0xfffffc91
 568:	006e6f69 	rsbeq	r6, lr, r9, ror #30
 56c:	74735f5f 	ldrbtvc	r5, [r3], #-3935	; 0xfffff0a1
 570:	63697461 	cmnvs	r9, #1627389952	; 0x61000000
 574:	696e695f 	stmdbvs	lr!, {r0, r1, r2, r3, r4, r6, r8, fp, sp, lr}^
 578:	6c616974 			; <UNDEFINED> instruction: 0x6c616974
 57c:	74617a69 	strbtvc	r7, [r1], #-2665	; 0xfffff597
 580:	5f6e6f69 	svcpl	0x006e6f69
 584:	5f646e61 	svcpl	0x00646e61
 588:	74736564 	ldrbtvc	r6, [r3], #-1380	; 0xfffffa9c
 58c:	74637572 	strbtvc	r7, [r3], #-1394	; 0xfffffa8e
 590:	5f6e6f69 	svcpl	0x006e6f69
 594:	50470030 	subpl	r0, r7, r0, lsr r0
 598:	4c455346 	mcrrmi	3, 4, r5, r5, cr6
 59c:	50470030 	subpl	r0, r7, r0, lsr r0
 5a0:	4c455346 	mcrrmi	3, 4, r5, r5, cr6
 5a4:	50470031 	subpl	r0, r7, r1, lsr r0
 5a8:	4c455346 	mcrrmi	3, 4, r5, r5, cr6
 5ac:	50470032 	subpl	r0, r7, r2, lsr r0
 5b0:	4c455346 	mcrrmi	3, 4, r5, r5, cr6
 5b4:	50470033 	subpl	r0, r7, r3, lsr r0
 5b8:	425f4f49 	subsmi	r4, pc, #292	; 0x124
 5bc:	00657361 	rsbeq	r7, r5, r1, ror #6
 5c0:	53465047 	movtpl	r5, #24647	; 0x6047
 5c4:	00354c45 	eorseq	r4, r5, r5, asr #24
 5c8:	334e5a5f 	movtcc	r5, #59999	; 0xea5f
 5cc:	3847434c 	stmdacc	r7, {r2, r3, r6, r8, r9, lr}^
 5d0:	5f746567 	svcpl	0x00746567
 5d4:	64656573 	strbtvs	r6, [r5], #-1395	; 0xfffffa8d
 5d8:	5f007645 	svcpl	0x00007645
 5dc:	424f4c47 	submi	r4, pc, #18176	; 0x4700
 5e0:	5f5f4c41 	svcpl	0x005f4c41
 5e4:	5f627573 	svcpl	0x00627573
 5e8:	636c5f49 	cmnvs	ip, #292	; 0x124
 5ec:	736e4967 	cmnvc	lr, #1687552	; 0x19c000
 5f0:	636e6174 	cmnvs	lr, #116, 2
 5f4:	5a5f0065 	bpl	17c0790 <_bss_end+0x17b7a90>
 5f8:	434c334e 	movtmi	r3, #49998	; 0xc34e
 5fc:	45324347 	ldrmi	r4, [r2, #-839]!	; 0xfffffcb9
 600:	65730076 	ldrbvs	r0, [r3, #-118]!	; 0xffffff8a
 604:	65735f74 	ldrbvs	r5, [r3, #-3956]!	; 0xfffff08c
 608:	5f006465 	svcpl	0x00006465
 60c:	4c334e5a 	ldcmi	14, cr4, [r3], #-360	; 0xfffffe98
 610:	73384743 	teqvc	r8, #17563648	; 0x10c0000
 614:	735f7465 	cmpvc	pc, #1694498816	; 0x65000000
 618:	45646565 	strbmi	r6, [r4, #-1381]!	; 0xfffffa9b
 61c:	5a5f0069 	bpl	17c07c8 <_bss_end+0x17b7ac8>
 620:	434c334e 	movtmi	r3, #49998	; 0xc34e
 624:	45324347 	ldrmi	r4, [r2, #-839]!	; 0xfffffcb9
 628:	5a5f0069 	bpl	17c07d4 <_bss_end+0x17b7ad4>
 62c:	434c334e 	movtmi	r3, #49998	; 0xc34e
 630:	45344347 	ldrmi	r4, [r4, #-839]!	; 0xfffffcb9
 634:	682f0069 	stmdavs	pc!, {r0, r3, r5, r6}	; <UNPREDICTABLE>
 638:	2f656d6f 	svccs	0x00656d6f
 63c:	5a2f6663 	bpl	bd9fd0 <_bss_end+0xbd12d0>
 640:	4f2f5543 	svcmi	0x002f5543
 644:	72702f53 	rsbsvc	r2, r0, #332	; 0x14c
 648:	69746361 	ldmdbvs	r4!, {r0, r5, r6, r8, r9, sp, lr}^
 64c:	2f6c6163 	svccs	0x006c6163
 650:	2f327865 	svccs	0x00327865
 654:	6b5f3430 	blvs	17cd71c <_bss_end+0x17c4a1c>
 658:	656e7265 	strbvs	r7, [lr, #-613]!	; 0xfffffd9b
 65c:	656b2f6c 	strbvs	r2, [fp, #-3948]!	; 0xfffff094
 660:	6c656e72 	stclvs	14, cr6, [r5], #-456	; 0xfffffe38
 664:	6372732f 	cmnvs	r2, #-1140850688	; 0xbc000000
 668:	6972642f 	ldmdbvs	r2!, {r0, r1, r2, r3, r5, sl, sp, lr}^
 66c:	73726576 	cmnvc	r2, #494927872	; 0x1d800000
 670:	67636c2f 	strbvs	r6, [r3, -pc, lsr #24]!
 674:	7070632e 	rsbsvc	r6, r0, lr, lsr #6
 678:	735f7000 	cmpvc	pc, #0
 67c:	00646565 	rsbeq	r6, r4, r5, ror #10
 680:	334e5a5f 	movtcc	r5, #59999	; 0xea5f
 684:	4347434c 	movtmi	r4, #29516	; 0x734c
 688:	00764534 	rsbseq	r4, r6, r4, lsr r5
 68c:	5f746567 	svcpl	0x00746567
 690:	7478656e 	ldrbtvc	r6, [r8], #-1390	; 0xfffffa92
 694:	4e5a5f00 	cdpmi	15, 5, cr5, cr10, cr0, {0}
 698:	47434c33 	smlaldxmi	r4, r3, r3, ip
 69c:	74656738 	strbtvc	r6, [r5], #-1848	; 0xfffff8c8
 6a0:	78656e5f 	stmdavc	r5!, {r0, r1, r2, r3, r4, r6, r9, sl, fp, sp, lr}^
 6a4:	00764574 	rsbseq	r4, r6, r4, ror r5
 6a8:	5f746567 	svcpl	0x00746567
 6ac:	64656573 	strbtvs	r6, [r5], #-1395	; 0xfffffa8d
 6b0:	63697400 	cmnvs	r9, #0, 8
 6b4:	7700736b 	strvc	r7, [r0, -fp, ror #6]
 6b8:	5f746961 	svcpl	0x00746961
 6bc:	69746361 	ldmdbvs	r4!, {r0, r5, r6, r8, r9, sp, lr}^
 6c0:	67006576 	smlsdxvs	r0, r6, r5, r6
 6c4:	6e5f6e65 	cdpvs	14, 5, cr6, cr15, cr5, {3}
 6c8:	65626d75 	strbvs	r6, [r2, #-3445]!	; 0xfffff28b
 6cc:	5a5f0072 	bpl	17c089c <_bss_end+0x17b7b9c>
 6d0:	434c334e 	movtmi	r3, #49998	; 0xc34e
 6d4:	45314347 	ldrmi	r4, [r1, #-839]!	; 0xfffffcb9
 6d8:	682f0076 	stmdavs	pc!, {r1, r2, r4, r5, r6}	; <UNPREDICTABLE>
 6dc:	2f656d6f 	svccs	0x00656d6f
 6e0:	5a2f6663 	bpl	bda074 <_bss_end+0xbd1374>
 6e4:	4f2f5543 	svcmi	0x002f5543
 6e8:	72702f53 	rsbsvc	r2, r0, #332	; 0x14c
 6ec:	69746361 	ldmdbvs	r4!, {r0, r5, r6, r8, r9, sp, lr}^
 6f0:	2f6c6163 	svccs	0x006c6163
 6f4:	2f327865 	svccs	0x00327865
 6f8:	6b5f3430 	blvs	17cd7c0 <_bss_end+0x17c4ac0>
 6fc:	656e7265 	strbvs	r7, [lr, #-613]!	; 0xfffffd9b
 700:	656b2f6c 	strbvs	r2, [fp, #-3948]!	; 0xfffff094
 704:	6c656e72 	stclvs	14, cr6, [r5], #-456	; 0xfffffe38
 708:	6372732f 	cmnvs	r2, #-1140850688	; 0xbc000000
 70c:	69616d2f 	stmdbvs	r1!, {r0, r1, r2, r3, r5, r8, sl, fp, sp, lr}^
 710:	70632e6e 	rsbvc	r2, r3, lr, ror #28
 714:	5a5f0070 	bpl	17c08dc <_bss_end+0x17b7bdc>
 718:	61773131 	cmnvs	r7, r1, lsr r1
 71c:	615f7469 	cmpvs	pc, r9, ror #8
 720:	76697463 	strbtvc	r7, [r9], -r3, ror #8
 724:	41006965 	tstmi	r0, r5, ror #18
 728:	505f5443 	subspl	r5, pc, r3, asr #8
 72c:	5f006e69 	svcpl	0x00006e69
 730:	6e72656b 	cdpvs	5, 7, cr6, cr2, cr11, {3}
 734:	6d5f6c65 	ldclvs	12, cr6, [pc, #-404]	; 5a8 <shift+0x5a8>
 738:	006e6961 	rsbeq	r6, lr, r1, ror #18
 73c:	6d6f682f 	stclvs	8, cr6, [pc, #-188]!	; 688 <shift+0x688>
 740:	66632f65 	strbtvs	r2, [r3], -r5, ror #30
 744:	55435a2f 	strbpl	r5, [r3, #-2607]	; 0xfffff5d1
 748:	2f534f2f 	svccs	0x00534f2f
 74c:	63617270 	cmnvs	r1, #112, 4
 750:	61636974 	smcvs	13972	; 0x3694
 754:	78652f6c 	stmdavc	r5!, {r2, r3, r5, r6, r8, r9, sl, fp, sp}^
 758:	34302f32 	ldrtcc	r2, [r0], #-3890	; 0xfffff0ce
 75c:	72656b5f 	rsbvc	r6, r5, #97280	; 0x17c00
 760:	2f6c656e 	svccs	0x006c656e
 764:	6e72656b 	cdpvs	5, 7, cr6, cr2, cr11, {3}
 768:	732f6c65 			; <UNDEFINED> instruction: 0x732f6c65
 76c:	732f6372 			; <UNDEFINED> instruction: 0x732f6372
 770:	74726174 	ldrbtvc	r6, [r2], #-372	; 0xfffffe8c
 774:	4700732e 	strmi	r7, [r0, -lr, lsr #6]
 778:	4120554e 			; <UNDEFINED> instruction: 0x4120554e
 77c:	2e322053 	mrccs	0, 1, r2, cr2, cr3, {2}
 780:	63003933 	movwvs	r3, #2355	; 0x933
 784:	5f726f74 	svcpl	0x00726f74
 788:	00727470 	rsbseq	r7, r2, r0, ror r4
 78c:	7373625f 	cmnvc	r3, #-268435451	; 0xf0000005
 790:	6174735f 	cmnvs	r4, pc, asr r3
 794:	66007472 			; <UNDEFINED> instruction: 0x66007472
 798:	7274706e 	rsbsvc	r7, r4, #110	; 0x6e
 79c:	435f5f00 	cmpmi	pc, #0, 30
 7a0:	5f524f54 	svcpl	0x00524f54
 7a4:	5f444e45 	svcpl	0x00444e45
 7a8:	5f5f005f 	svcpl	0x005f005f
 7ac:	524f5443 	subpl	r5, pc, #1124073472	; 0x43000000
 7b0:	53494c5f 	movtpl	r4, #40031	; 0x9c5f
 7b4:	005f5f54 	subseq	r5, pc, r4, asr pc	; <UNPREDICTABLE>
 7b8:	54445f5f 	strbpl	r5, [r4], #-3935	; 0xfffff0a1
 7bc:	455f524f 	ldrbmi	r5, [pc, #-591]	; 575 <shift+0x575>
 7c0:	5f5f444e 	svcpl	0x005f444e
 7c4:	70635f00 	rsbvc	r5, r3, r0, lsl #30
 7c8:	68735f70 	ldmdavs	r3!, {r4, r5, r6, r8, r9, sl, fp, ip, lr}^
 7cc:	6f647475 	svcvs	0x00647475
 7d0:	2f006e77 	svccs	0x00006e77
 7d4:	656d6f68 	strbvs	r6, [sp, #-3944]!	; 0xfffff098
 7d8:	2f66632f 	svccs	0x0066632f
 7dc:	2f55435a 	svccs	0x0055435a
 7e0:	702f534f 	eorvc	r5, pc, pc, asr #6
 7e4:	74636172 	strbtvc	r6, [r3], #-370	; 0xfffffe8e
 7e8:	6c616369 	stclvs	3, cr6, [r1], #-420	; 0xfffffe5c
 7ec:	3278652f 	rsbscc	r6, r8, #197132288	; 0xbc00000
 7f0:	5f34302f 	svcpl	0x0034302f
 7f4:	6e72656b 	cdpvs	5, 7, cr6, cr2, cr11, {3}
 7f8:	6b2f6c65 	blvs	bdb994 <_bss_end+0xbd2c94>
 7fc:	656e7265 	strbvs	r7, [lr, #-613]!	; 0xfffffd9b
 800:	72732f6c 	rsbsvc	r2, r3, #108, 30	; 0x1b0
 804:	74732f63 	ldrbtvc	r2, [r3], #-3939	; 0xfffff09d
 808:	75747261 	ldrbvc	r7, [r4, #-609]!	; 0xfffffd9f
 80c:	70632e70 	rsbvc	r2, r3, r0, ror lr
 810:	625f0070 	subsvs	r0, pc, #112	; 0x70
 814:	655f7373 	ldrbvs	r7, [pc, #-883]	; 4a9 <shift+0x4a9>
 818:	5f00646e 	svcpl	0x0000646e
 81c:	4f54445f 	svcmi	0x0054445f
 820:	494c5f52 	stmdbmi	ip, {r1, r4, r6, r8, r9, sl, fp, ip, lr}^
 824:	5f5f5453 	svcpl	0x005f5453
 828:	5f635f00 	svcpl	0x00635f00
 82c:	72617473 	rsbvc	r7, r1, #1929379840	; 0x73000000
 830:	00707574 	rsbseq	r7, r0, r4, ror r5
 834:	7070635f 	rsbsvc	r6, r0, pc, asr r3
 838:	6174735f 	cmnvs	r4, pc, asr r3
 83c:	70757472 	rsbsvc	r7, r5, r2, ror r4
 840:	6f746400 	svcvs	0x00746400
 844:	74705f72 	ldrbtvc	r5, [r0], #-3954	; 0xfffff08e
 848:	696c0072 	stmdbvs	ip!, {r1, r4, r5, r6}^
 84c:	75663162 	strbvc	r3, [r6, #-354]!	; 0xfffffe9e
 850:	2e73636e 	cdpcs	3, 7, cr6, cr3, cr14, {3}
 854:	622f0053 	eorvs	r0, pc, #83	; 0x53
 858:	646c6975 	strbtvs	r6, [ip], #-2421	; 0xfffff68b
 85c:	2f726964 	svccs	0x00726964
 860:	6c697562 	cfstr64vs	mvdx7, [r9], #-392	; 0xfffffe78
 864:	55422f64 	strbpl	r2, [r2, #-3940]	; 0xfffff09c
 868:	2f444c49 	svccs	0x00444c49
 86c:	2d6d7261 	sfmcs	f7, 2, [sp, #-388]!	; 0xfffffe7c
 870:	656e6f6e 	strbvs	r6, [lr, #-3950]!	; 0xfffff092
 874:	6261652d 	rsbvs	r6, r1, #188743680	; 0xb400000
 878:	63672d69 	cmnvs	r7, #6720	; 0x1a40
 87c:	73632d63 	cmnvc	r3, #6336	; 0x18c0
 880:	2e32312d 	rsfcssp	f3, f2, #5.0
 884:	2f302e32 	svccs	0x00302e32
 888:	2d636367 	stclcs	3, cr6, [r3, #-412]!	; 0xfffffe64
 88c:	2d6d7261 	sfmcs	f7, 2, [sp, #-388]!	; 0xfffffe7c
 890:	656e6f6e 	strbvs	r6, [lr, #-3950]!	; 0xfffff092
 894:	6261652d 	rsbvs	r6, r1, #188743680	; 0xb400000
 898:	72612f69 	rsbvc	r2, r1, #420	; 0x1a4
 89c:	6f6e2d6d 	svcvs	0x006e2d6d
 8a0:	652d656e 	strvs	r6, [sp, #-1390]!	; 0xfffffa92
 8a4:	2f696261 	svccs	0x00696261
 8a8:	2f6d7261 	svccs	0x006d7261
 8ac:	65743576 	ldrbvs	r3, [r4, #-1398]!	; 0xfffffa8a
 8b0:	7261682f 	rsbvc	r6, r1, #3080192	; 0x2f0000
 8b4:	696c2f64 	stmdbvs	ip!, {r2, r5, r6, r8, r9, sl, fp, sp}^
 8b8:	63636762 	cmnvs	r3, #25690112	; 0x1880000
 8bc:	554e4700 	strbpl	r4, [lr, #-1792]	; 0xfffff900
 8c0:	20534120 	subscs	r4, r3, r0, lsr #2
 8c4:	37332e32 			; <UNDEFINED> instruction: 0x37332e32
 8c8:	61736900 	cmnvs	r3, r0, lsl #18
 8cc:	7469625f 	strbtvc	r6, [r9], #-607	; 0xfffffda1
 8d0:	6572705f 	ldrbvs	r7, [r2, #-95]!	; 0xffffffa1
 8d4:	73657264 	cmnvc	r5, #100, 4	; 0x40000006
 8d8:	61736900 	cmnvs	r3, r0, lsl #18
 8dc:	7469625f 	strbtvc	r6, [r9], #-607	; 0xfffffda1
 8e0:	7066765f 	rsbvc	r7, r6, pc, asr r6
 8e4:	7361625f 	cmnvc	r1, #-268435451	; 0xf0000005
 8e8:	6f630065 	svcvs	0x00630065
 8ec:	656c706d 	strbvs	r7, [ip, #-109]!	; 0xffffff93
 8f0:	6c662078 	stclvs	0, cr2, [r6], #-480	; 0xfffffe20
 8f4:	0074616f 	rsbseq	r6, r4, pc, ror #2
 8f8:	5f617369 	svcpl	0x00617369
 8fc:	69626f6e 	stmdbvs	r2!, {r1, r2, r3, r5, r6, r8, r9, sl, fp, sp, lr}^
 900:	73690074 	cmnvc	r9, #116	; 0x74
 904:	69625f61 	stmdbvs	r2!, {r0, r5, r6, r8, r9, sl, fp, ip, lr}^
 908:	766d5f74 	uqsub16vc	r5, sp, r4
 90c:	6c665f65 	stclvs	15, cr5, [r6], #-404	; 0xfffffe6c
 910:	0074616f 	rsbseq	r6, r4, pc, ror #2
 914:	5f617369 	svcpl	0x00617369
 918:	5f746962 	svcpl	0x00746962
 91c:	36317066 	ldrtcc	r7, [r1], -r6, rrx
 920:	61736900 	cmnvs	r3, r0, lsl #18
 924:	7469625f 	strbtvc	r6, [r9], #-607	; 0xfffffda1
 928:	6365735f 	cmnvs	r5, #2080374785	; 0x7c000001
 92c:	61736900 	cmnvs	r3, r0, lsl #18
 930:	7469625f 	strbtvc	r6, [r9], #-607	; 0xfffffda1
 934:	6964615f 	stmdbvs	r4!, {r0, r1, r2, r3, r4, r6, r8, sp, lr}^
 938:	73690076 	cmnvc	r9, #118	; 0x76
 93c:	69625f61 	stmdbvs	r2!, {r0, r5, r6, r8, r9, sl, fp, ip, lr}^
 940:	75715f74 	ldrbvc	r5, [r1, #-3956]!	; 0xfffff08c
 944:	5f6b7269 	svcpl	0x006b7269
 948:	765f6f6e 	ldrbvc	r6, [pc], -lr, ror #30
 94c:	74616c6f 	strbtvc	r6, [r1], #-3183	; 0xfffff391
 950:	5f656c69 	svcpl	0x00656c69
 954:	69006563 	stmdbvs	r0, {r0, r1, r5, r6, r8, sl, sp, lr}
 958:	625f6173 	subsvs	r6, pc, #-1073741796	; 0xc000001c
 95c:	6d5f7469 	cfldrdvs	mvd7, [pc, #-420]	; 7c0 <shift+0x7c0>
 960:	73690070 	cmnvc	r9, #112	; 0x70
 964:	69625f61 	stmdbvs	r2!, {r0, r5, r6, r8, r9, sl, fp, ip, lr}^
 968:	72615f74 	rsbvc	r5, r1, #116, 30	; 0x1d0
 96c:	7435766d 	ldrtvc	r7, [r5], #-1645	; 0xfffff993
 970:	61736900 	cmnvs	r3, r0, lsl #18
 974:	7469625f 	strbtvc	r6, [r9], #-607	; 0xfffffda1
 978:	6d72615f 	ldfvse	f6, [r2, #-380]!	; 0xfffffe84
 97c:	65743576 	ldrbvs	r3, [r4, #-1398]!	; 0xfffffa8a
 980:	61736900 	cmnvs	r3, r0, lsl #18
 984:	7469625f 	strbtvc	r6, [r9], #-607	; 0xfffffda1
 988:	6f656e5f 	svcvs	0x00656e5f
 98c:	7369006e 	cmnvc	r9, #110	; 0x6e
 990:	69625f61 	stmdbvs	r2!, {r0, r5, r6, r8, r9, sl, fp, ip, lr}^
 994:	66625f74 	uqsub16vs	r5, r2, r4
 998:	2e003631 	mcrcs	6, 0, r3, cr0, cr1, {1}
 99c:	2e2e2f2e 	cdpcs	15, 2, cr2, cr14, cr14, {1}
 9a0:	2f2e2e2f 	svccs	0x002e2e2f
 9a4:	2e2f2e2e 	cdpcs	14, 2, cr2, cr15, cr14, {1}
 9a8:	2e2e2f2e 	cdpcs	15, 2, cr2, cr14, cr14, {1}
 9ac:	6363672f 	cmnvs	r3, #12320768	; 0xbc0000
 9b0:	2e32312d 	rsfcssp	f3, f2, #5.0
 9b4:	2f302e32 	svccs	0x00302e32
 9b8:	6762696c 	strbvs	r6, [r2, -ip, ror #18]!
 9bc:	6c2f6363 	stcvs	3, cr6, [pc], #-396	; 838 <shift+0x838>
 9c0:	63676269 	cmnvs	r7, #-1879048186	; 0x90000006
 9c4:	632e3263 			; <UNDEFINED> instruction: 0x632e3263
 9c8:	53504600 	cmppl	r0, #0, 12
 9cc:	455f5243 	ldrbmi	r5, [pc, #-579]	; 791 <shift+0x791>
 9d0:	004d554e 	subeq	r5, sp, lr, asr #10
 9d4:	43535046 	cmpmi	r3, #70	; 0x46
 9d8:	7a6e5f52 	bvc	1b98728 <_bss_end+0x1b8fa28>
 9dc:	63717663 	cmnvs	r1, #103809024	; 0x6300000
 9e0:	554e455f 	strbpl	r4, [lr, #-1375]	; 0xfffffaa1
 9e4:	5056004d 	subspl	r0, r6, sp, asr #32
 9e8:	4e455f52 	mcrmi	15, 2, r5, cr5, cr2, {2}
 9ec:	66004d55 			; <UNDEFINED> instruction: 0x66004d55
 9f0:	5f746962 	svcpl	0x00746962
 9f4:	6c706d69 	ldclvs	13, cr6, [r0], #-420	; 0xfffffe5c
 9f8:	74616369 	strbtvc	r6, [r1], #-873	; 0xfffffc97
 9fc:	006e6f69 	rsbeq	r6, lr, r9, ror #30
 a00:	455f3050 	ldrbmi	r3, [pc, #-80]	; 9b8 <shift+0x9b8>
 a04:	004d554e 	subeq	r5, sp, lr, asr #10
 a08:	5f617369 	svcpl	0x00617369
 a0c:	5f746962 	svcpl	0x00746962
 a10:	70797263 	rsbsvc	r7, r9, r3, ror #4
 a14:	69006f74 	stmdbvs	r0, {r2, r4, r5, r6, r8, r9, sl, fp, sp, lr}
 a18:	625f6173 	subsvs	r6, pc, #-1073741796	; 0xc000001c
 a1c:	745f7469 	ldrbvc	r7, [pc], #-1129	; a24 <shift+0xa24>
 a20:	00766964 	rsbseq	r6, r6, r4, ror #18
 a24:	736e6f63 	cmnvc	lr, #396	; 0x18c
 a28:	61736900 	cmnvs	r3, r0, lsl #18
 a2c:	7469625f 	strbtvc	r6, [r9], #-607	; 0xfffffda1
 a30:	6d77695f 			; <UNDEFINED> instruction: 0x6d77695f
 a34:	0074786d 	rsbseq	r7, r4, sp, ror #16
 a38:	58435046 	stmdapl	r3, {r1, r2, r6, ip, lr}^
 a3c:	455f5354 	ldrbmi	r5, [pc, #-852]	; 6f0 <shift+0x6f0>
 a40:	004d554e 	subeq	r5, sp, lr, asr #10
 a44:	5f617369 	svcpl	0x00617369
 a48:	5f746962 	svcpl	0x00746962
 a4c:	766d7261 	strbtvc	r7, [sp], -r1, ror #4
 a50:	73690036 	cmnvc	r9, #54	; 0x36
 a54:	69625f61 	stmdbvs	r2!, {r0, r5, r6, r8, r9, sl, fp, ip, lr}^
 a58:	766d5f74 	uqsub16vc	r5, sp, r4
 a5c:	73690065 	cmnvc	r9, #101	; 0x65
 a60:	69625f61 	stmdbvs	r2!, {r0, r5, r6, r8, r9, sl, fp, ip, lr}^
 a64:	77695f74 			; <UNDEFINED> instruction: 0x77695f74
 a68:	74786d6d 	ldrbtvc	r6, [r8], #-3437	; 0xfffff293
 a6c:	73690032 	cmnvc	r9, #50	; 0x32
 a70:	69625f61 	stmdbvs	r2!, {r0, r5, r6, r8, r9, sl, fp, ip, lr}^
 a74:	64635f74 	strbtvs	r5, [r3], #-3956	; 0xfffff08c
 a78:	30706365 	rsbscc	r6, r0, r5, ror #6
 a7c:	61736900 	cmnvs	r3, r0, lsl #18
 a80:	7469625f 	strbtvc	r6, [r9], #-607	; 0xfffffda1
 a84:	6564635f 	strbvs	r6, [r4, #-863]!	; 0xfffffca1
 a88:	00317063 	eorseq	r7, r1, r3, rrx
 a8c:	5f617369 	svcpl	0x00617369
 a90:	5f746962 	svcpl	0x00746962
 a94:	63656463 	cmnvs	r5, #1660944384	; 0x63000000
 a98:	69003270 	stmdbvs	r0, {r4, r5, r6, r9, ip, sp}
 a9c:	625f6173 	subsvs	r6, pc, #-1073741796	; 0xc000001c
 aa0:	635f7469 	cmpvs	pc, #1761607680	; 0x69000000
 aa4:	70636564 	rsbvc	r6, r3, r4, ror #10
 aa8:	73690033 	cmnvc	r9, #51	; 0x33
 aac:	69625f61 	stmdbvs	r2!, {r0, r5, r6, r8, r9, sl, fp, ip, lr}^
 ab0:	64635f74 	strbtvs	r5, [r3], #-3956	; 0xfffff08c
 ab4:	34706365 	ldrbtcc	r6, [r0], #-869	; 0xfffffc9b
 ab8:	61736900 	cmnvs	r3, r0, lsl #18
 abc:	7469625f 	strbtvc	r6, [r9], #-607	; 0xfffffda1
 ac0:	5f70665f 	svcpl	0x0070665f
 ac4:	006c6264 	rsbeq	r6, ip, r4, ror #4
 ac8:	5f617369 	svcpl	0x00617369
 acc:	5f746962 	svcpl	0x00746962
 ad0:	63656463 	cmnvs	r5, #1660944384	; 0x63000000
 ad4:	69003670 	stmdbvs	r0, {r4, r5, r6, r9, sl, ip, sp}
 ad8:	625f6173 	subsvs	r6, pc, #-1073741796	; 0xc000001c
 adc:	635f7469 	cmpvs	pc, #1761607680	; 0x69000000
 ae0:	70636564 	rsbvc	r6, r3, r4, ror #10
 ae4:	73690037 	cmnvc	r9, #55	; 0x37
 ae8:	69625f61 	stmdbvs	r2!, {r0, r5, r6, r8, r9, sl, fp, ip, lr}^
 aec:	72615f74 	rsbvc	r5, r1, #116, 30	; 0x1d0
 af0:	6b36766d 	blvs	d9e4ac <_bss_end+0xd957ac>
 af4:	61736900 	cmnvs	r3, r0, lsl #18
 af8:	7469625f 	strbtvc	r6, [r9], #-607	; 0xfffffda1
 afc:	6d72615f 	ldfvse	f6, [r2, #-380]!	; 0xfffffe84
 b00:	315f3876 	cmpcc	pc, r6, ror r8	; <UNPREDICTABLE>
 b04:	616d5f6d 	cmnvs	sp, sp, ror #30
 b08:	61006e69 	tstvs	r0, r9, ror #28
 b0c:	0065746e 	rsbeq	r7, r5, lr, ror #8
 b10:	5f617369 	svcpl	0x00617369
 b14:	5f746962 	svcpl	0x00746962
 b18:	65736d63 	ldrbvs	r6, [r3, #-3427]!	; 0xfffff29d
 b1c:	6e6f6c00 	cdpvs	12, 6, cr6, cr15, cr0, {0}
 b20:	6f642067 	svcvs	0x00642067
 b24:	656c6275 	strbvs	r6, [ip, #-629]!	; 0xfffffd8b
 b28:	61736900 	cmnvs	r3, r0, lsl #18
 b2c:	7469625f 	strbtvc	r6, [r9], #-607	; 0xfffffda1
 b30:	7670665f 			; <UNDEFINED> instruction: 0x7670665f
 b34:	73690035 	cmnvc	r9, #53	; 0x35
 b38:	69625f61 	stmdbvs	r2!, {r0, r5, r6, r8, r9, sl, fp, ip, lr}^
 b3c:	73785f74 	cmnvc	r8, #116, 30	; 0x1d0
 b40:	656c6163 	strbvs	r6, [ip, #-355]!	; 0xfffffe9d
 b44:	6e6f6c00 	cdpvs	12, 6, cr6, cr15, cr0, {0}
 b48:	6f6c2067 	svcvs	0x006c2067
 b4c:	7520676e 	strvc	r6, [r0, #-1902]!	; 0xfffff892
 b50:	6769736e 	strbvs	r7, [r9, -lr, ror #6]!
 b54:	2064656e 	rsbcs	r6, r4, lr, ror #10
 b58:	00746e69 	rsbseq	r6, r4, r9, ror #28
 b5c:	5f617369 	svcpl	0x00617369
 b60:	5f746962 	svcpl	0x00746962
 b64:	72697571 	rsbvc	r7, r9, #473956352	; 0x1c400000
 b68:	6d635f6b 	stclvs	15, cr5, [r3, #-428]!	; 0xfffffe54
 b6c:	646c5f33 	strbtvs	r5, [ip], #-3891	; 0xfffff0cd
 b70:	69006472 	stmdbvs	r0, {r1, r4, r5, r6, sl, sp, lr}
 b74:	625f6173 	subsvs	r6, pc, #-1073741796	; 0xc000001c
 b78:	695f7469 	ldmdbvs	pc, {r0, r3, r5, r6, sl, ip, sp, lr}^	; <UNPREDICTABLE>
 b7c:	006d6d38 	rsbeq	r6, sp, r8, lsr sp
 b80:	5f617369 	svcpl	0x00617369
 b84:	5f746962 	svcpl	0x00746962
 b88:	645f7066 	ldrbvs	r7, [pc], #-102	; b90 <shift+0xb90>
 b8c:	69003233 	stmdbvs	r0, {r0, r1, r4, r5, r9, ip, sp}
 b90:	625f6173 	subsvs	r6, pc, #-1073741796	; 0xc000001c
 b94:	615f7469 	cmpvs	pc, r9, ror #8
 b98:	37766d72 			; <UNDEFINED> instruction: 0x37766d72
 b9c:	69006d65 	stmdbvs	r0, {r0, r2, r5, r6, r8, sl, fp, sp, lr}
 ba0:	625f6173 	subsvs	r6, pc, #-1073741796	; 0xc000001c
 ba4:	6c5f7469 	cfldrdvs	mvd7, [pc], {105}	; 0x69
 ba8:	00656170 	rsbeq	r6, r5, r0, ror r1
 bac:	5f6c6c61 	svcpl	0x006c6c61
 bb0:	6c706d69 	ldclvs	13, cr6, [r0], #-420	; 0xfffffe5c
 bb4:	5f646569 	svcpl	0x00646569
 bb8:	74696266 	strbtvc	r6, [r9], #-614	; 0xfffffd9a
 bbc:	73690073 	cmnvc	r9, #115	; 0x73
 bc0:	69625f61 	stmdbvs	r2!, {r0, r5, r6, r8, r9, sl, fp, ip, lr}^
 bc4:	72615f74 	rsbvc	r5, r1, #116, 30	; 0x1d0
 bc8:	5f38766d 	svcpl	0x0038766d
 bcc:	73690031 	cmnvc	r9, #49	; 0x31
 bd0:	69625f61 	stmdbvs	r2!, {r0, r5, r6, r8, r9, sl, fp, ip, lr}^
 bd4:	72615f74 	rsbvc	r5, r1, #116, 30	; 0x1d0
 bd8:	5f38766d 	svcpl	0x0038766d
 bdc:	73690032 	cmnvc	r9, #50	; 0x32
 be0:	69625f61 	stmdbvs	r2!, {r0, r5, r6, r8, r9, sl, fp, ip, lr}^
 be4:	72615f74 	rsbvc	r5, r1, #116, 30	; 0x1d0
 be8:	5f38766d 	svcpl	0x0038766d
 bec:	73690033 	cmnvc	r9, #51	; 0x33
 bf0:	69625f61 	stmdbvs	r2!, {r0, r5, r6, r8, r9, sl, fp, ip, lr}^
 bf4:	72615f74 	rsbvc	r5, r1, #116, 30	; 0x1d0
 bf8:	5f38766d 	svcpl	0x0038766d
 bfc:	73690034 	cmnvc	r9, #52	; 0x34
 c00:	69625f61 	stmdbvs	r2!, {r0, r5, r6, r8, r9, sl, fp, ip, lr}^
 c04:	72615f74 	rsbvc	r5, r1, #116, 30	; 0x1d0
 c08:	5f38766d 	svcpl	0x0038766d
 c0c:	73690035 	cmnvc	r9, #53	; 0x35
 c10:	69625f61 	stmdbvs	r2!, {r0, r5, r6, r8, r9, sl, fp, ip, lr}^
 c14:	72615f74 	rsbvc	r5, r1, #116, 30	; 0x1d0
 c18:	5f38766d 	svcpl	0x0038766d
 c1c:	73690036 	cmnvc	r9, #54	; 0x36
 c20:	69625f61 	stmdbvs	r2!, {r0, r5, r6, r8, r9, sl, fp, ip, lr}^
 c24:	62735f74 	rsbsvs	r5, r3, #116, 30	; 0x1d0
 c28:	61736900 	cmnvs	r3, r0, lsl #18
 c2c:	6d756e5f 	ldclvs	14, cr6, [r5, #-380]!	; 0xfffffe84
 c30:	7469625f 	strbtvc	r6, [r9], #-607	; 0xfffffda1
 c34:	73690073 	cmnvc	r9, #115	; 0x73
 c38:	69625f61 	stmdbvs	r2!, {r0, r5, r6, r8, r9, sl, fp, ip, lr}^
 c3c:	6d735f74 	ldclvs	15, cr5, [r3, #-464]!	; 0xfffffe30
 c40:	6d6c6c61 	stclvs	12, cr6, [ip, #-388]!	; 0xfffffe7c
 c44:	66006c75 			; <UNDEFINED> instruction: 0x66006c75
 c48:	5f636e75 	svcpl	0x00636e75
 c4c:	00727470 	rsbseq	r7, r2, r0, ror r4
 c50:	706d6f63 	rsbvc	r6, sp, r3, ror #30
 c54:	2078656c 	rsbscs	r6, r8, ip, ror #10
 c58:	62756f64 	rsbsvs	r6, r5, #100, 30	; 0x190
 c5c:	4e00656c 	cfsh32mi	mvfx6, mvfx0, #60
 c60:	50465f42 	subpl	r5, r6, r2, asr #30
 c64:	5359535f 	cmppl	r9, #2080374785	; 0x7c000001
 c68:	53474552 	movtpl	r4, #30034	; 0x7552
 c6c:	61736900 	cmnvs	r3, r0, lsl #18
 c70:	7469625f 	strbtvc	r6, [r9], #-607	; 0xfffffda1
 c74:	6975715f 	ldmdbvs	r5!, {r0, r1, r2, r3, r4, r6, r8, ip, sp, lr}^
 c78:	765f6b72 			; <UNDEFINED> instruction: 0x765f6b72
 c7c:	6d646c6c 	stclvs	12, cr6, [r4, #-432]!	; 0xfffffe50
 c80:	61736900 	cmnvs	r3, r0, lsl #18
 c84:	7469625f 	strbtvc	r6, [r9], #-607	; 0xfffffda1
 c88:	6564635f 	strbvs	r6, [r4, #-863]!	; 0xfffffca1
 c8c:	00357063 	eorseq	r7, r5, r3, rrx
 c90:	5f617369 	svcpl	0x00617369
 c94:	5f746962 	svcpl	0x00746962
 c98:	76706676 			; <UNDEFINED> instruction: 0x76706676
 c9c:	73690032 	cmnvc	r9, #50	; 0x32
 ca0:	69625f61 	stmdbvs	r2!, {r0, r5, r6, r8, r9, sl, fp, ip, lr}^
 ca4:	66765f74 	uhsub16vs	r5, r6, r4
 ca8:	00337670 	eorseq	r7, r3, r0, ror r6
 cac:	5f617369 	svcpl	0x00617369
 cb0:	5f746962 	svcpl	0x00746962
 cb4:	76706676 			; <UNDEFINED> instruction: 0x76706676
 cb8:	50460034 	subpl	r0, r6, r4, lsr r0
 cbc:	4e545843 	cdpmi	8, 5, cr5, cr4, cr3, {2}
 cc0:	4e455f53 	mcrmi	15, 2, r5, cr5, cr3, {2}
 cc4:	69004d55 	stmdbvs	r0, {r0, r2, r4, r6, r8, sl, fp, lr}
 cc8:	625f6173 	subsvs	r6, pc, #-1073741796	; 0xc000001c
 ccc:	745f7469 	ldrbvc	r7, [pc], #-1129	; cd4 <shift+0xcd4>
 cd0:	626d7568 	rsbvs	r7, sp, #104, 10	; 0x1a000000
 cd4:	61736900 	cmnvs	r3, r0, lsl #18
 cd8:	7469625f 	strbtvc	r6, [r9], #-607	; 0xfffffda1
 cdc:	3170665f 	cmncc	r0, pc, asr r6
 ce0:	6e6f6336 	mcrvs	3, 3, r6, cr15, cr6, {1}
 ce4:	73690076 	cmnvc	r9, #118	; 0x76
 ce8:	65665f61 	strbvs	r5, [r6, #-3937]!	; 0xfffff09f
 cec:	72757461 	rsbsvc	r7, r5, #1627389952	; 0x61000000
 cf0:	73690065 	cmnvc	r9, #101	; 0x65
 cf4:	69625f61 	stmdbvs	r2!, {r0, r5, r6, r8, r9, sl, fp, ip, lr}^
 cf8:	6f6e5f74 	svcvs	0x006e5f74
 cfc:	69006d74 	stmdbvs	r0, {r2, r4, r5, r6, r8, sl, fp, sp, lr}
 d00:	625f6173 	subsvs	r6, pc, #-1073741796	; 0xc000001c
 d04:	715f7469 	cmpvc	pc, r9, ror #8
 d08:	6b726975 	blvs	1c9b2e4 <_bss_end+0x1c925e4>
 d0c:	6d72615f 	ldfvse	f6, [r2, #-380]!	; 0xfffffe84
 d10:	7a6b3676 	bvc	1ace6f0 <_bss_end+0x1ac59f0>
 d14:	61736900 	cmnvs	r3, r0, lsl #18
 d18:	7469625f 	strbtvc	r6, [r9], #-607	; 0xfffffda1
 d1c:	6372635f 	cmnvs	r2, #2080374785	; 0x7c000001
 d20:	69003233 	stmdbvs	r0, {r0, r1, r4, r5, r9, ip, sp}
 d24:	625f6173 	subsvs	r6, pc, #-1073741796	; 0xc000001c
 d28:	615f7469 	cmpvs	pc, r9, ror #8
 d2c:	39766d72 	ldmdbcc	r6!, {r1, r4, r5, r6, r8, sl, fp, sp, lr}^
 d30:	61736900 	cmnvs	r3, r0, lsl #18
 d34:	7469625f 	strbtvc	r6, [r9], #-607	; 0xfffffda1
 d38:	6975715f 	ldmdbvs	r5!, {r0, r1, r2, r3, r4, r6, r8, ip, sp, lr}^
 d3c:	6e5f6b72 	vmovvs.s8	r6, d15[3]
 d40:	73615f6f 	cmnvc	r1, #444	; 0x1bc
 d44:	7570636d 	ldrbvc	r6, [r0, #-877]!	; 0xfffffc93
 d48:	61736900 	cmnvs	r3, r0, lsl #18
 d4c:	7469625f 	strbtvc	r6, [r9], #-607	; 0xfffffda1
 d50:	6d72615f 	ldfvse	f6, [r2, #-380]!	; 0xfffffe84
 d54:	69003476 	stmdbvs	r0, {r1, r2, r4, r5, r6, sl, ip, sp}
 d58:	625f6173 	subsvs	r6, pc, #-1073741796	; 0xc000001c
 d5c:	745f7469 	ldrbvc	r7, [pc], #-1129	; d64 <shift+0xd64>
 d60:	626d7568 	rsbvs	r7, sp, #104, 10	; 0x1a000000
 d64:	73690032 	cmnvc	r9, #50	; 0x32
 d68:	69625f61 	stmdbvs	r2!, {r0, r5, r6, r8, r9, sl, fp, ip, lr}^
 d6c:	65625f74 	strbvs	r5, [r2, #-3956]!	; 0xfffff08c
 d70:	73690038 	cmnvc	r9, #56	; 0x38
 d74:	69625f61 	stmdbvs	r2!, {r0, r5, r6, r8, r9, sl, fp, ip, lr}^
 d78:	72615f74 	rsbvc	r5, r1, #116, 30	; 0x1d0
 d7c:	0037766d 	eorseq	r7, r7, sp, ror #12
 d80:	5f617369 	svcpl	0x00617369
 d84:	5f746962 	svcpl	0x00746962
 d88:	766d7261 	strbtvc	r7, [sp], -r1, ror #4
 d8c:	66760038 			; <UNDEFINED> instruction: 0x66760038
 d90:	79735f70 	ldmdbvc	r3!, {r4, r5, r6, r8, r9, sl, fp, ip, lr}^
 d94:	67657273 			; <UNDEFINED> instruction: 0x67657273
 d98:	6e655f73 	mcrvs	15, 3, r5, cr5, cr3, {3}
 d9c:	69646f63 	stmdbvs	r4!, {r0, r1, r5, r6, r8, r9, sl, fp, sp, lr}^
 da0:	6900676e 	stmdbvs	r0, {r1, r2, r3, r5, r6, r8, r9, sl, sp, lr}
 da4:	625f6173 	subsvs	r6, pc, #-1073741796	; 0xc000001c
 da8:	665f7469 	ldrbvs	r7, [pc], -r9, ror #8
 dac:	66363170 			; <UNDEFINED> instruction: 0x66363170
 db0:	47006c6d 	strmi	r6, [r0, -sp, ror #24]
 db4:	4320554e 			; <UNDEFINED> instruction: 0x4320554e
 db8:	31203731 			; <UNDEFINED> instruction: 0x31203731
 dbc:	2e322e32 	mrccs	14, 1, r2, cr2, cr2, {1}
 dc0:	6d2d2030 	stcvs	0, cr2, [sp, #-192]!	; 0xffffff40
 dc4:	206d7261 	rsbcs	r7, sp, r1, ror #4
 dc8:	6c666d2d 	stclvs	13, cr6, [r6], #-180	; 0xffffff4c
 dcc:	2d74616f 	ldfcse	f6, [r4, #-444]!	; 0xfffffe44
 dd0:	3d696261 	sfmcc	f6, 2, [r9, #-388]!	; 0xfffffe7c
 dd4:	64726168 	ldrbtvs	r6, [r2], #-360	; 0xfffffe98
 dd8:	616d2d20 	cmnvs	sp, r0, lsr #26
 ddc:	3d686372 	stclcc	3, cr6, [r8, #-456]!	; 0xfffffe38
 de0:	766d7261 	strbtvc	r7, [sp], -r1, ror #4
 de4:	2b657435 	blcs	195dec0 <_bss_end+0x19551c0>
 de8:	2d207066 	stccs	0, cr7, [r0, #-408]!	; 0xfffffe68
 dec:	672d2067 	strvs	r2, [sp, -r7, rrx]!
 df0:	20672d20 	rsbcs	r2, r7, r0, lsr #26
 df4:	20324f2d 	eorscs	r4, r2, sp, lsr #30
 df8:	20324f2d 	eorscs	r4, r2, sp, lsr #30
 dfc:	20324f2d 	eorscs	r4, r2, sp, lsr #30
 e00:	7562662d 	strbvc	r6, [r2, #-1581]!	; 0xfffff9d3
 e04:	69646c69 	stmdbvs	r4!, {r0, r3, r5, r6, sl, fp, sp, lr}^
 e08:	6c2d676e 	stcvs	7, cr6, [sp], #-440	; 0xfffffe48
 e0c:	63676269 	cmnvs	r7, #-1879048186	; 0x90000006
 e10:	662d2063 	strtvs	r2, [sp], -r3, rrx
 e14:	732d6f6e 			; <UNDEFINED> instruction: 0x732d6f6e
 e18:	6b636174 	blvs	18d93f0 <_bss_end+0x18d06f0>
 e1c:	6f72702d 	svcvs	0x0072702d
 e20:	74636574 	strbtvc	r6, [r3], #-1396	; 0xfffffa8c
 e24:	2d20726f 	sfmcs	f7, 4, [r0, #-444]!	; 0xfffffe44
 e28:	2d6f6e66 	stclcs	14, cr6, [pc, #-408]!	; c98 <shift+0xc98>
 e2c:	696c6e69 	stmdbvs	ip!, {r0, r3, r5, r6, r9, sl, fp, sp, lr}^
 e30:	2d20656e 	cfstr32cs	mvfx6, [r0, #-440]!	; 0xfffffe48
 e34:	73697666 	cmnvc	r9, #106954752	; 0x6600000
 e38:	6c696269 	sfmvs	f6, 2, [r9], #-420	; 0xfffffe5c
 e3c:	3d797469 	cfldrdcc	mvd7, [r9, #-420]!	; 0xfffffe5c
 e40:	64646968 	strbtvs	r6, [r4], #-2408	; 0xfffff698
 e44:	69006e65 	stmdbvs	r0, {r0, r2, r5, r6, r9, sl, fp, sp, lr}
 e48:	625f6173 	subsvs	r6, pc, #-1073741796	; 0xc000001c
 e4c:	715f7469 	cmpvc	pc, r9, ror #8
 e50:	6b726975 	blvs	1c9b42c <_bss_end+0x1c9272c>
 e54:	7365615f 	cmnvc	r5, #-1073741801	; 0xc0000017
 e58:	3437315f 	ldrtcc	r3, [r7], #-351	; 0xfffffea1
 e5c:	38393032 	ldmdacc	r9!, {r1, r4, r5, ip, sp}
 e60:	61736900 	cmnvs	r3, r0, lsl #18
 e64:	7469625f 	strbtvc	r6, [r9], #-607	; 0xfffffda1
 e68:	746f645f 	strbtvc	r6, [pc], #-1119	; e70 <shift+0xe70>
 e6c:	646f7270 	strbtvs	r7, [pc], #-624	; e74 <shift+0xe74>
	...

Disassembly of section .comment:

00000000 <.comment>:
   0:	3a434347 	bcc	10d0d24 <_bss_end+0x10c8024>
   4:	65462820 	strbvs	r2, [r6, #-2080]	; 0xfffff7e0
   8:	61726f64 	cmnvs	r2, r4, ror #30
   c:	2e323120 	rsfcssp	f3, f2, f0
  10:	2d302e32 	ldccs	14, cr2, [r0, #-200]!	; 0xffffff38
  14:	63662e31 	cmnvs	r6, #784	; 0x310
  18:	20293633 	eorcs	r3, r9, r3, lsr r6
  1c:	322e3231 	eorcc	r3, lr, #268435459	; 0x10000003
  20:	Address 0x0000000000000020 is out of bounds.


Disassembly of section .ARM.attributes:

00000000 <.ARM.attributes>:
   0:	00003041 	andeq	r3, r0, r1, asr #32
   4:	61656100 	cmnvs	r5, r0, lsl #2
   8:	01006962 	tsteq	r0, r2, ror #18
   c:	00000026 	andeq	r0, r0, r6, lsr #32
  10:	4b5a3605 	blmi	168d82c <_bss_end+0x1684b2c>
  14:	08070600 	stmdaeq	r7, {r9, sl}
  18:	0a010901 	beq	42424 <_bss_end+0x39724>
  1c:	14041202 	strne	r1, [r4], #-514	; 0xfffffdfe
  20:	17011501 	strne	r1, [r1, -r1, lsl #10]
  24:	1a011803 	bne	46038 <_bss_end+0x3d338>
  28:	1e011c01 	cdpne	12, 0, cr1, cr1, cr1, {0}
  2c:	44012206 	strmi	r2, [r1], #-518	; 0xfffffdfa
  30:	Address 0x0000000000000030 is out of bounds.


Disassembly of section .debug_frame:

00000000 <.debug_frame>:
   0:	0000000c 	andeq	r0, r0, ip
   4:	ffffffff 			; <UNDEFINED> instruction: 0xffffffff
   8:	7c020001 	stcvc	0, cr0, [r2], {1}
   c:	000d0c0e 	andeq	r0, sp, lr, lsl #24
  10:	0000001c 	andeq	r0, r0, ip, lsl r0
  14:	00000000 	andeq	r0, r0, r0
  18:	00008018 	andeq	r8, r0, r8, lsl r0
  1c:	00000038 	andeq	r0, r0, r8, lsr r0
  20:	8b040e42 	blhi	103930 <_bss_end+0xfac30>
  24:	0b0d4201 	bleq	350830 <_bss_end+0x347b30>
  28:	420d0d54 	andmi	r0, sp, #84, 26	; 0x1500
  2c:	00000ecb 	andeq	r0, r0, fp, asr #29
  30:	0000001c 	andeq	r0, r0, ip, lsl r0
  34:	00000000 	andeq	r0, r0, r0
  38:	00008050 	andeq	r8, r0, r0, asr r0
  3c:	0000002c 	andeq	r0, r0, ip, lsr #32
  40:	8b040e42 	blhi	103950 <_bss_end+0xfac50>
  44:	0b0d4201 	bleq	350850 <_bss_end+0x347b50>
  48:	420d0d4e 	andmi	r0, sp, #4992	; 0x1380
  4c:	00000ecb 	andeq	r0, r0, fp, asr #29
  50:	0000001c 	andeq	r0, r0, ip, lsl r0
  54:	00000000 	andeq	r0, r0, r0
  58:	0000807c 	andeq	r8, r0, ip, ror r0
  5c:	00000020 	andeq	r0, r0, r0, lsr #32
  60:	8b040e42 	blhi	103970 <_bss_end+0xfac70>
  64:	0b0d4201 	bleq	350870 <_bss_end+0x347b70>
  68:	420d0d48 	andmi	r0, sp, #72, 26	; 0x1200
  6c:	00000ecb 	andeq	r0, r0, fp, asr #29
  70:	0000001c 	andeq	r0, r0, ip, lsl r0
  74:	00000000 	andeq	r0, r0, r0
  78:	0000809c 	muleq	r0, ip, r0
  7c:	00000018 	andeq	r0, r0, r8, lsl r0
  80:	8b040e42 	blhi	103990 <_bss_end+0xfac90>
  84:	0b0d4201 	bleq	350890 <_bss_end+0x347b90>
  88:	420d0d44 	andmi	r0, sp, #68, 26	; 0x1100
  8c:	00000ecb 	andeq	r0, r0, fp, asr #29
  90:	0000001c 	andeq	r0, r0, ip, lsl r0
  94:	00000000 	andeq	r0, r0, r0
  98:	000080b4 	strheq	r8, [r0], -r4
  9c:	00000018 	andeq	r0, r0, r8, lsl r0
  a0:	8b040e42 	blhi	1039b0 <_bss_end+0xfacb0>
  a4:	0b0d4201 	bleq	3508b0 <_bss_end+0x347bb0>
  a8:	420d0d44 	andmi	r0, sp, #68, 26	; 0x1100
  ac:	00000ecb 	andeq	r0, r0, fp, asr #29
  b0:	0000001c 	andeq	r0, r0, ip, lsl r0
  b4:	00000000 	andeq	r0, r0, r0
  b8:	000080cc 	andeq	r8, r0, ip, asr #1
  bc:	00000018 	andeq	r0, r0, r8, lsl r0
  c0:	8b040e42 	blhi	1039d0 <_bss_end+0xfacd0>
  c4:	0b0d4201 	bleq	3508d0 <_bss_end+0x347bd0>
  c8:	420d0d44 	andmi	r0, sp, #68, 26	; 0x1100
  cc:	00000ecb 	andeq	r0, r0, fp, asr #29
  d0:	00000014 	andeq	r0, r0, r4, lsl r0
  d4:	00000000 	andeq	r0, r0, r0
  d8:	000080e4 	andeq	r8, r0, r4, ror #1
  dc:	0000000c 	andeq	r0, r0, ip
  e0:	8b040e42 	blhi	1039f0 <_bss_end+0xfacf0>
  e4:	0b0d4201 	bleq	3508f0 <_bss_end+0x347bf0>
  e8:	0000000c 	andeq	r0, r0, ip
  ec:	ffffffff 			; <UNDEFINED> instruction: 0xffffffff
  f0:	7c020001 	stcvc	0, cr0, [r2], {1}
  f4:	000d0c0e 	andeq	r0, sp, lr, lsl #24
  f8:	0000001c 	andeq	r0, r0, ip, lsl r0
  fc:	000000e8 	andeq	r0, r0, r8, ror #1
 100:	000080f0 	strdeq	r8, [r0], -r0
 104:	00000034 	andeq	r0, r0, r4, lsr r0
 108:	8b040e42 	blhi	103a18 <_bss_end+0xfad18>
 10c:	0b0d4201 	bleq	350918 <_bss_end+0x347c18>
 110:	420d0d52 	andmi	r0, sp, #5248	; 0x1480
 114:	00000ecb 	andeq	r0, r0, fp, asr #29
 118:	0000001c 	andeq	r0, r0, ip, lsl r0
 11c:	000000e8 	andeq	r0, r0, r8, ror #1
 120:	00008124 	andeq	r8, r0, r4, lsr #2
 124:	00000114 	andeq	r0, r0, r4, lsl r1
 128:	8b040e42 	blhi	103a38 <_bss_end+0xfad38>
 12c:	0b0d4201 	bleq	350938 <_bss_end+0x347c38>
 130:	0d0d8002 	stceq	0, cr8, [sp, #-8]
 134:	000ecb42 	andeq	ip, lr, r2, asr #22
 138:	0000001c 	andeq	r0, r0, ip, lsl r0
 13c:	000000e8 	andeq	r0, r0, r8, ror #1
 140:	00008238 	andeq	r8, r0, r8, lsr r2
 144:	00000074 	andeq	r0, r0, r4, ror r0
 148:	8b040e42 	blhi	103a58 <_bss_end+0xfad58>
 14c:	0b0d4201 	bleq	350958 <_bss_end+0x347c58>
 150:	420d0d72 	andmi	r0, sp, #7296	; 0x1c80
 154:	00000ecb 	andeq	r0, r0, fp, asr #29
 158:	0000001c 	andeq	r0, r0, ip, lsl r0
 15c:	000000e8 	andeq	r0, r0, r8, ror #1
 160:	000082ac 	andeq	r8, r0, ip, lsr #5
 164:	00000074 	andeq	r0, r0, r4, ror r0
 168:	8b040e42 	blhi	103a78 <_bss_end+0xfad78>
 16c:	0b0d4201 	bleq	350978 <_bss_end+0x347c78>
 170:	420d0d72 	andmi	r0, sp, #7296	; 0x1c80
 174:	00000ecb 	andeq	r0, r0, fp, asr #29
 178:	0000001c 	andeq	r0, r0, ip, lsl r0
 17c:	000000e8 	andeq	r0, r0, r8, ror #1
 180:	00008320 	andeq	r8, r0, r0, lsr #6
 184:	00000074 	andeq	r0, r0, r4, ror r0
 188:	8b040e42 	blhi	103a98 <_bss_end+0xfad98>
 18c:	0b0d4201 	bleq	350998 <_bss_end+0x347c98>
 190:	420d0d72 	andmi	r0, sp, #7296	; 0x1c80
 194:	00000ecb 	andeq	r0, r0, fp, asr #29
 198:	0000001c 	andeq	r0, r0, ip, lsl r0
 19c:	000000e8 	andeq	r0, r0, r8, ror #1
 1a0:	00008394 	muleq	r0, r4, r3
 1a4:	000000a8 	andeq	r0, r0, r8, lsr #1
 1a8:	8b080e42 	blhi	203ab8 <_bss_end+0x1fadb8>
 1ac:	42018e02 	andmi	r8, r1, #2, 28
 1b0:	02040b0c 	andeq	r0, r4, #12, 22	; 0x3000
 1b4:	080d0c4e 	stmdaeq	sp, {r1, r2, r3, r6, sl, fp}
 1b8:	0000001c 	andeq	r0, r0, ip, lsl r0
 1bc:	000000e8 	andeq	r0, r0, r8, ror #1
 1c0:	0000843c 	andeq	r8, r0, ip, lsr r4
 1c4:	0000007c 	andeq	r0, r0, ip, ror r0
 1c8:	8b080e42 	blhi	203ad8 <_bss_end+0x1fadd8>
 1cc:	42018e02 	andmi	r8, r1, #2, 28
 1d0:	78040b0c 	stmdavc	r4, {r2, r3, r8, r9, fp}
 1d4:	00080d0c 	andeq	r0, r8, ip, lsl #26
 1d8:	0000001c 	andeq	r0, r0, ip, lsl r0
 1dc:	000000e8 	andeq	r0, r0, r8, ror #1
 1e0:	000084b8 			; <UNDEFINED> instruction: 0x000084b8
 1e4:	000000d8 	ldrdeq	r0, [r0], -r8
 1e8:	8b080e42 	blhi	203af8 <_bss_end+0x1fadf8>
 1ec:	42018e02 	andmi	r8, r1, #2, 28
 1f0:	02040b0c 	andeq	r0, r4, #12, 22	; 0x3000
 1f4:	080d0c66 	stmdaeq	sp, {r1, r2, r5, r6, sl, fp}
 1f8:	0000001c 	andeq	r0, r0, ip, lsl r0
 1fc:	000000e8 	andeq	r0, r0, r8, ror #1
 200:	00008590 	muleq	r0, r0, r5
 204:	00000054 	andeq	r0, r0, r4, asr r0
 208:	8b080e42 	blhi	203b18 <_bss_end+0x1fae18>
 20c:	42018e02 	andmi	r8, r1, #2, 28
 210:	5e040b0c 	vmlapl.f64	d0, d4, d12
 214:	00080d0c 	andeq	r0, r8, ip, lsl #26
 218:	00000018 	andeq	r0, r0, r8, lsl r0
 21c:	000000e8 	andeq	r0, r0, r8, ror #1
 220:	000085e4 	andeq	r8, r0, r4, ror #11
 224:	0000001c 	andeq	r0, r0, ip, lsl r0
 228:	8b080e42 	blhi	203b38 <_bss_end+0x1fae38>
 22c:	42018e02 	andmi	r8, r1, #2, 28
 230:	00040b0c 	andeq	r0, r4, ip, lsl #22
 234:	0000000c 	andeq	r0, r0, ip
 238:	ffffffff 			; <UNDEFINED> instruction: 0xffffffff
 23c:	7c020001 	stcvc	0, cr0, [r2], {1}
 240:	000d0c0e 	andeq	r0, sp, lr, lsl #24
 244:	0000001c 	andeq	r0, r0, ip, lsl r0
 248:	00000234 	andeq	r0, r0, r4, lsr r2
 24c:	00008600 	andeq	r8, r0, r0, lsl #12
 250:	00000054 	andeq	r0, r0, r4, asr r0
 254:	8b040e42 	blhi	103b64 <_bss_end+0xfae64>
 258:	0b0d4201 	bleq	350a64 <_bss_end+0x347d64>
 25c:	420d0d5c 	andmi	r0, sp, #92, 26	; 0x1700
 260:	00000ecb 	andeq	r0, r0, fp, asr #29
 264:	0000001c 	andeq	r0, r0, ip, lsl r0
 268:	00000234 	andeq	r0, r0, r4, lsr r2
 26c:	00008654 	andeq	r8, r0, r4, asr r6
 270:	00000064 	andeq	r0, r0, r4, rrx
 274:	8b040e42 	blhi	103b84 <_bss_end+0xfae84>
 278:	0b0d4201 	bleq	350a84 <_bss_end+0x347d84>
 27c:	420d0d64 	andmi	r0, sp, #100, 26	; 0x1900
 280:	00000ecb 	andeq	r0, r0, fp, asr #29
 284:	0000001c 	andeq	r0, r0, ip, lsl r0
 288:	00000234 	andeq	r0, r0, r4, lsr r2
 28c:	000086b8 			; <UNDEFINED> instruction: 0x000086b8
 290:	00000030 	andeq	r0, r0, r0, lsr r0
 294:	8b040e42 	blhi	103ba4 <_bss_end+0xfaea4>
 298:	0b0d4201 	bleq	350aa4 <_bss_end+0x347da4>
 29c:	420d0d50 	andmi	r0, sp, #80, 26	; 0x1400
 2a0:	00000ecb 	andeq	r0, r0, fp, asr #29
 2a4:	0000001c 	andeq	r0, r0, ip, lsl r0
 2a8:	00000234 	andeq	r0, r0, r4, lsr r2
 2ac:	000086e8 	andeq	r8, r0, r8, ror #13
 2b0:	00000028 	andeq	r0, r0, r8, lsr #32
 2b4:	8b040e42 	blhi	103bc4 <_bss_end+0xfaec4>
 2b8:	0b0d4201 	bleq	350ac4 <_bss_end+0x347dc4>
 2bc:	420d0d4c 	andmi	r0, sp, #76, 26	; 0x1300
 2c0:	00000ecb 	andeq	r0, r0, fp, asr #29
 2c4:	0000001c 	andeq	r0, r0, ip, lsl r0
 2c8:	00000234 	andeq	r0, r0, r4, lsr r2
 2cc:	00008710 	andeq	r8, r0, r0, lsl r7
 2d0:	00000068 	andeq	r0, r0, r8, rrx
 2d4:	8b080e42 	blhi	203be4 <_bss_end+0x1faee4>
 2d8:	42018e02 	andmi	r8, r1, #2, 28
 2dc:	6e040b0c 	vmlavs.f64	d0, d4, d12
 2e0:	00080d0c 	andeq	r0, r8, ip, lsl #26
 2e4:	0000001c 	andeq	r0, r0, ip, lsl r0
 2e8:	00000234 	andeq	r0, r0, r4, lsr r2
 2ec:	00008778 	andeq	r8, r0, r8, ror r7
 2f0:	0000004c 	andeq	r0, r0, ip, asr #32
 2f4:	8b080e42 	blhi	203c04 <_bss_end+0x1faf04>
 2f8:	42018e02 	andmi	r8, r1, #2, 28
 2fc:	5c040b0c 			; <UNDEFINED> instruction: 0x5c040b0c
 300:	00080d0c 	andeq	r0, r8, ip, lsl #26
 304:	00000018 	andeq	r0, r0, r8, lsl r0
 308:	00000234 	andeq	r0, r0, r4, lsr r2
 30c:	000087c4 	andeq	r8, r0, r4, asr #15
 310:	0000001c 	andeq	r0, r0, ip, lsl r0
 314:	8b080e42 	blhi	203c24 <_bss_end+0x1faf24>
 318:	42018e02 	andmi	r8, r1, #2, 28
 31c:	00040b0c 	andeq	r0, r4, ip, lsl #22
 320:	0000000c 	andeq	r0, r0, ip
 324:	ffffffff 			; <UNDEFINED> instruction: 0xffffffff
 328:	7c020001 	stcvc	0, cr0, [r2], {1}
 32c:	000d0c0e 	andeq	r0, sp, lr, lsl #24
 330:	0000001c 	andeq	r0, r0, ip, lsl r0
 334:	00000320 	andeq	r0, r0, r0, lsr #6
 338:	000087e0 	andeq	r8, r0, r0, ror #15
 33c:	0000005c 	andeq	r0, r0, ip, asr r0
 340:	8b040e42 	blhi	103c50 <_bss_end+0xfaf50>
 344:	0b0d4201 	bleq	350b50 <_bss_end+0x347e50>
 348:	420d0d66 	andmi	r0, sp, #6528	; 0x1980
 34c:	00000ecb 	andeq	r0, r0, fp, asr #29
 350:	00000018 	andeq	r0, r0, r8, lsl r0
 354:	00000320 	andeq	r0, r0, r0, lsr #6
 358:	0000883c 	andeq	r8, r0, ip, lsr r8
 35c:	000000d8 	ldrdeq	r0, [r0], -r8
 360:	8b080e42 	blhi	203c70 <_bss_end+0x1faf70>
 364:	42018e02 	andmi	r8, r1, #2, 28
 368:	00040b0c 	andeq	r0, r4, ip, lsl #22
 36c:	0000000c 	andeq	r0, r0, ip
 370:	ffffffff 			; <UNDEFINED> instruction: 0xffffffff
 374:	7c020001 	stcvc	0, cr0, [r2], {1}
 378:	000d0c0e 	andeq	r0, sp, lr, lsl #24
 37c:	0000001c 	andeq	r0, r0, ip, lsl r0
 380:	0000036c 	andeq	r0, r0, ip, ror #6
 384:	00008914 	andeq	r8, r0, r4, lsl r9
 388:	00000068 	andeq	r0, r0, r8, rrx
 38c:	8b040e42 	blhi	103c9c <_bss_end+0xfaf9c>
 390:	0b0d4201 	bleq	350b9c <_bss_end+0x347e9c>
 394:	420d0d68 	andmi	r0, sp, #104, 26	; 0x1a00
 398:	00000ecb 	andeq	r0, r0, fp, asr #29
 39c:	0000001c 	andeq	r0, r0, ip, lsl r0
 3a0:	0000036c 	andeq	r0, r0, ip, ror #6
 3a4:	0000897c 	andeq	r8, r0, ip, ror r9
 3a8:	00000058 	andeq	r0, r0, r8, asr r0
 3ac:	8b080e42 	blhi	203cbc <_bss_end+0x1fafbc>
 3b0:	42018e02 	andmi	r8, r1, #2, 28
 3b4:	62040b0c 	andvs	r0, r4, #12, 22	; 0x3000
 3b8:	00080d0c 	andeq	r0, r8, ip, lsl #26
 3bc:	0000001c 	andeq	r0, r0, ip, lsl r0
 3c0:	0000036c 	andeq	r0, r0, ip, ror #6
 3c4:	000089d4 	ldrdeq	r8, [r0], -r4
 3c8:	00000058 	andeq	r0, r0, r8, asr r0
 3cc:	8b080e42 	blhi	203cdc <_bss_end+0x1fafdc>
 3d0:	42018e02 	andmi	r8, r1, #2, 28
 3d4:	62040b0c 	andvs	r0, r4, #12, 22	; 0x3000
 3d8:	00080d0c 	andeq	r0, r8, ip, lsl #26
 3dc:	0000000c 	andeq	r0, r0, ip
 3e0:	ffffffff 			; <UNDEFINED> instruction: 0xffffffff
 3e4:	7c010001 	stcvc	0, cr0, [r1], {1}
 3e8:	000d0c0e 	andeq	r0, sp, lr, lsl #24
 3ec:	0000000c 	andeq	r0, r0, ip
 3f0:	000003dc 	ldrdeq	r0, [r0], -ip
 3f4:	00008a2c 	andeq	r8, r0, ip, lsr #20
 3f8:	00000220 	andeq	r0, r0, r0, lsr #4

Disassembly of section .debug_line_str:

00000000 <.debug_line_str>:
   0:	6d6f682f 	stclvs	8, cr6, [pc, #-188]!	; ffffff4c <_bss_end+0xffff724c>
   4:	66632f65 	strbtvs	r2, [r3], -r5, ror #30
   8:	55435a2f 	strbpl	r5, [r3, #-2607]	; 0xfffff5d1
   c:	2f534f2f 	svccs	0x00534f2f
  10:	63617270 	cmnvs	r1, #112, 4
  14:	61636974 	smcvs	13972	; 0x3694
  18:	78652f6c 	stmdavc	r5!, {r2, r3, r5, r6, r8, r9, sl, fp, sp}^
  1c:	34302f32 	ldrtcc	r2, [r0], #-3890	; 0xfffff0ce
  20:	72656b5f 	rsbvc	r6, r5, #97280	; 0x17c00
  24:	2f6c656e 	svccs	0x006c656e
  28:	6c697562 	cfstr64vs	mvdx7, [r9], #-392	; 0xfffffe78
  2c:	682f0064 	stmdavs	pc!, {r2, r5, r6}	; <UNPREDICTABLE>
  30:	2f656d6f 	svccs	0x00656d6f
  34:	5a2f6663 	bpl	bd99c8 <_bss_end+0xbd0cc8>
  38:	4f2f5543 	svcmi	0x002f5543
  3c:	72702f53 	rsbsvc	r2, r0, #332	; 0x14c
  40:	69746361 	ldmdbvs	r4!, {r0, r5, r6, r8, r9, sp, lr}^
  44:	2f6c6163 	svccs	0x006c6163
  48:	2f327865 	svccs	0x00327865
  4c:	6b5f3430 	blvs	17cd114 <_bss_end+0x17c4414>
  50:	656e7265 	strbvs	r7, [lr, #-613]!	; 0xfffffd9b
  54:	656b2f6c 	strbvs	r2, [fp, #-3948]!	; 0xfffff094
  58:	6c656e72 	stclvs	14, cr6, [r5], #-456	; 0xfffffe38
  5c:	6372732f 	cmnvs	r2, #-1140850688	; 0xbc000000
  60:	61747300 	cmnvs	r4, r0, lsl #6
  64:	732e7472 			; <UNDEFINED> instruction: 0x732e7472
  68:	2f2e2e00 	svccs	0x002e2e00
  6c:	2e2f2e2e 	cdpcs	14, 2, cr2, cr15, cr14, {1}
  70:	2e2e2f2e 	cdpcs	15, 2, cr2, cr14, cr14, {1}
  74:	2f2e2e2f 	svccs	0x002e2e2f
  78:	672f2e2e 	strvs	r2, [pc, -lr, lsr #28]!
  7c:	312d6363 			; <UNDEFINED> instruction: 0x312d6363
  80:	2e322e32 	mrccs	14, 1, r2, cr2, cr2, {1}
  84:	696c2f30 	stmdbvs	ip!, {r4, r5, r8, r9, sl, fp, sp}^
  88:	63636762 	cmnvs	r3, #25690112	; 0x1880000
  8c:	6e6f632f 	cdpvs	3, 6, cr6, cr15, cr15, {1}
  90:	2f676966 	svccs	0x00676966
  94:	006d7261 	rsbeq	r7, sp, r1, ror #4
  98:	3162696c 	cmncc	r2, ip, ror #18
  9c:	636e7566 	cmnvs	lr, #427819008	; 0x19800000
  a0:	00532e73 	subseq	r2, r3, r3, ror lr
