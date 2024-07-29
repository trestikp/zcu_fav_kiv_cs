
./kernel:     file format elf32-littlearm


Disassembly of section .text:

00008000 <_start>:
_start():
/home/cf/ZCU/OS/practical/ex3/original/kernel/src/start.s:8
;@ tady budou symboly, ktere chceme na zacatek kodove sekce
.section .text.start

;@ vstupni bod do kernelu - nechame ho vlozit na zacatek kodu
_start:
    mov sp,#0x8000			;@ nastavime stack pointer na spodek zasobniku
    8000:	e3a0d902 	mov	sp, #32768	; 0x8000
/home/cf/ZCU/OS/practical/ex3/original/kernel/src/start.s:9
	bl _c_startup			;@ C startup kod (inicializace prostredi)
    8004:	eb0002e2 	bl	8b94 <_c_startup>
/home/cf/ZCU/OS/practical/ex3/original/kernel/src/start.s:10
	bl _cpp_startup			;@ C++ startup kod (volani globalnich konstruktoru, ...)
    8008:	eb0002fb 	bl	8bfc <_cpp_startup>
/home/cf/ZCU/OS/practical/ex3/original/kernel/src/start.s:11
    bl _kernel_main			;@ skocime do hlavniho kodu jadra (v C)
    800c:	eb0002a3 	bl	8aa0 <_kernel_main>
/home/cf/ZCU/OS/practical/ex3/original/kernel/src/start.s:12
	bl _cpp_shutdown		;@ C++ shutdown kod (volani globalnich destruktoru, ...)
    8010:	eb00030f 	bl	8c54 <_cpp_shutdown>

00008014 <hang>:
hang():
/home/cf/ZCU/OS/practical/ex3/original/kernel/src/start.s:14
hang:
    b hang
    8014:	eafffffe 	b	8014 <hang>

00008018 <__cxa_guard_acquire>:
__cxa_guard_acquire():
/home/cf/ZCU/OS/practical/ex3/original/kernel/src/cxx.cpp:11
	extern "C" int __cxa_guard_acquire (__guard *);
	extern "C" void __cxa_guard_release (__guard *);
	extern "C" void __cxa_guard_abort (__guard *);

	extern "C" int __cxa_guard_acquire (__guard *g)
	{
    8018:	e52db004 	push	{fp}		; (str fp, [sp, #-4]!)
    801c:	e28db000 	add	fp, sp, #0
    8020:	e24dd00c 	sub	sp, sp, #12
    8024:	e50b0008 	str	r0, [fp, #-8]
/home/cf/ZCU/OS/practical/ex3/original/kernel/src/cxx.cpp:12
		return !*(char *)(g);
    8028:	e51b3008 	ldr	r3, [fp, #-8]
    802c:	e5d33000 	ldrb	r3, [r3]
    8030:	e3530000 	cmp	r3, #0
    8034:	03a03001 	moveq	r3, #1
    8038:	13a03000 	movne	r3, #0
    803c:	e6ef3073 	uxtb	r3, r3
/home/cf/ZCU/OS/practical/ex3/original/kernel/src/cxx.cpp:13
	}
    8040:	e1a00003 	mov	r0, r3
    8044:	e28bd000 	add	sp, fp, #0
    8048:	e49db004 	pop	{fp}		; (ldr fp, [sp], #4)
    804c:	e12fff1e 	bx	lr

00008050 <__cxa_guard_release>:
__cxa_guard_release():
/home/cf/ZCU/OS/practical/ex3/original/kernel/src/cxx.cpp:16

	extern "C" void __cxa_guard_release (__guard *g)
	{
    8050:	e52db004 	push	{fp}		; (str fp, [sp, #-4]!)
    8054:	e28db000 	add	fp, sp, #0
    8058:	e24dd00c 	sub	sp, sp, #12
    805c:	e50b0008 	str	r0, [fp, #-8]
/home/cf/ZCU/OS/practical/ex3/original/kernel/src/cxx.cpp:17
		*(char *)g = 1;
    8060:	e51b3008 	ldr	r3, [fp, #-8]
    8064:	e3a02001 	mov	r2, #1
    8068:	e5c32000 	strb	r2, [r3]
/home/cf/ZCU/OS/practical/ex3/original/kernel/src/cxx.cpp:18
	}
    806c:	e320f000 	nop	{0}
    8070:	e28bd000 	add	sp, fp, #0
    8074:	e49db004 	pop	{fp}		; (ldr fp, [sp], #4)
    8078:	e12fff1e 	bx	lr

0000807c <__cxa_guard_abort>:
__cxa_guard_abort():
/home/cf/ZCU/OS/practical/ex3/original/kernel/src/cxx.cpp:21

	extern "C" void __cxa_guard_abort (__guard *)
	{
    807c:	e52db004 	push	{fp}		; (str fp, [sp, #-4]!)
    8080:	e28db000 	add	fp, sp, #0
    8084:	e24dd00c 	sub	sp, sp, #12
    8088:	e50b0008 	str	r0, [fp, #-8]
/home/cf/ZCU/OS/practical/ex3/original/kernel/src/cxx.cpp:23

	}
    808c:	e320f000 	nop	{0}
    8090:	e28bd000 	add	sp, fp, #0
    8094:	e49db004 	pop	{fp}		; (ldr fp, [sp], #4)
    8098:	e12fff1e 	bx	lr

0000809c <__dso_handle>:
__dso_handle():
/home/cf/ZCU/OS/practical/ex3/original/kernel/src/cxx.cpp:27
}

extern "C" void __dso_handle()
{
    809c:	e52db004 	push	{fp}		; (str fp, [sp, #-4]!)
    80a0:	e28db000 	add	fp, sp, #0
/home/cf/ZCU/OS/practical/ex3/original/kernel/src/cxx.cpp:29
    // ignore dtors for now
}
    80a4:	e320f000 	nop	{0}
    80a8:	e28bd000 	add	sp, fp, #0
    80ac:	e49db004 	pop	{fp}		; (ldr fp, [sp], #4)
    80b0:	e12fff1e 	bx	lr

000080b4 <__cxa_atexit>:
__cxa_atexit():
/home/cf/ZCU/OS/practical/ex3/original/kernel/src/cxx.cpp:32

extern "C" void __cxa_atexit()
{
    80b4:	e52db004 	push	{fp}		; (str fp, [sp, #-4]!)
    80b8:	e28db000 	add	fp, sp, #0
/home/cf/ZCU/OS/practical/ex3/original/kernel/src/cxx.cpp:34
    // ignore dtors for now
}
    80bc:	e320f000 	nop	{0}
    80c0:	e28bd000 	add	sp, fp, #0
    80c4:	e49db004 	pop	{fp}		; (ldr fp, [sp], #4)
    80c8:	e12fff1e 	bx	lr

000080cc <__cxa_pure_virtual>:
__cxa_pure_virtual():
/home/cf/ZCU/OS/practical/ex3/original/kernel/src/cxx.cpp:37

extern "C" void __cxa_pure_virtual()
{
    80cc:	e52db004 	push	{fp}		; (str fp, [sp, #-4]!)
    80d0:	e28db000 	add	fp, sp, #0
/home/cf/ZCU/OS/practical/ex3/original/kernel/src/cxx.cpp:39
    // pure virtual method called
}
    80d4:	e320f000 	nop	{0}
    80d8:	e28bd000 	add	sp, fp, #0
    80dc:	e49db004 	pop	{fp}		; (ldr fp, [sp], #4)
    80e0:	e12fff1e 	bx	lr

000080e4 <__aeabi_unwind_cpp_pr1>:
__aeabi_unwind_cpp_pr1():
/home/cf/ZCU/OS/practical/ex3/original/kernel/src/cxx.cpp:42

extern "C" void __aeabi_unwind_cpp_pr1()
{
    80e4:	e52db004 	push	{fp}		; (str fp, [sp, #-4]!)
    80e8:	e28db000 	add	fp, sp, #0
/home/cf/ZCU/OS/practical/ex3/original/kernel/src/cxx.cpp:43 (discriminator 1)
	while (true)
    80ec:	eafffffe 	b	80ec <__aeabi_unwind_cpp_pr1+0x8>

000080f0 <_ZN4CAUXC1Ej>:
_ZN4CAUXC2Ej():
/home/cf/ZCU/OS/practical/ex3/original/kernel/src/drivers/bcm_aux.cpp:5
#include <drivers/bcm_aux.h>

CAUX sAUX(hal::AUX_Base);

CAUX::CAUX(unsigned int aux_base)
    80f0:	e52db004 	push	{fp}		; (str fp, [sp, #-4]!)
    80f4:	e28db000 	add	fp, sp, #0
    80f8:	e24dd00c 	sub	sp, sp, #12
    80fc:	e50b0008 	str	r0, [fp, #-8]
    8100:	e50b100c 	str	r1, [fp, #-12]
/home/cf/ZCU/OS/practical/ex3/original/kernel/src/drivers/bcm_aux.cpp:6
    : mAUX_Reg(reinterpret_cast<unsigned int*>(aux_base))
    8104:	e51b200c 	ldr	r2, [fp, #-12]
    8108:	e51b3008 	ldr	r3, [fp, #-8]
    810c:	e5832000 	str	r2, [r3]
/home/cf/ZCU/OS/practical/ex3/original/kernel/src/drivers/bcm_aux.cpp:9
{
    //
}
    8110:	e51b3008 	ldr	r3, [fp, #-8]
    8114:	e1a00003 	mov	r0, r3
    8118:	e28bd000 	add	sp, fp, #0
    811c:	e49db004 	pop	{fp}		; (ldr fp, [sp], #4)
    8120:	e12fff1e 	bx	lr

00008124 <_ZN4CAUX6EnableEN3hal15AUX_PeripheralsE>:
_ZN4CAUX6EnableEN3hal15AUX_PeripheralsE():
/home/cf/ZCU/OS/practical/ex3/original/kernel/src/drivers/bcm_aux.cpp:12

void CAUX::Enable(hal::AUX_Peripherals aux_peripheral)
{
    8124:	e92d4800 	push	{fp, lr}
    8128:	e28db004 	add	fp, sp, #4
    812c:	e24dd008 	sub	sp, sp, #8
    8130:	e50b0008 	str	r0, [fp, #-8]
    8134:	e50b100c 	str	r1, [fp, #-12]
/home/cf/ZCU/OS/practical/ex3/original/kernel/src/drivers/bcm_aux.cpp:13
    Set_Register(hal::AUX_Reg::ENABLES, Get_Register(hal::AUX_Reg::ENABLES) | (1 << static_cast<uint32_t>(aux_peripheral)));
    8138:	e3a01001 	mov	r1, #1
    813c:	e51b0008 	ldr	r0, [fp, #-8]
    8140:	eb000031 	bl	820c <_ZN4CAUX12Get_RegisterEN3hal7AUX_RegE>
    8144:	e1a02000 	mov	r2, r0
    8148:	e51b300c 	ldr	r3, [fp, #-12]
    814c:	e3a01001 	mov	r1, #1
    8150:	e1a03311 	lsl	r3, r1, r3
    8154:	e1823003 	orr	r3, r2, r3
    8158:	e1a02003 	mov	r2, r3
    815c:	e3a01001 	mov	r1, #1
    8160:	e51b0008 	ldr	r0, [fp, #-8]
    8164:	eb000017 	bl	81c8 <_ZN4CAUX12Set_RegisterEN3hal7AUX_RegEj>
/home/cf/ZCU/OS/practical/ex3/original/kernel/src/drivers/bcm_aux.cpp:14
}
    8168:	e320f000 	nop	{0}
    816c:	e24bd004 	sub	sp, fp, #4
    8170:	e8bd8800 	pop	{fp, pc}

00008174 <_ZN4CAUX7DisableEN3hal15AUX_PeripheralsE>:
_ZN4CAUX7DisableEN3hal15AUX_PeripheralsE():
/home/cf/ZCU/OS/practical/ex3/original/kernel/src/drivers/bcm_aux.cpp:17

void CAUX::Disable(hal::AUX_Peripherals aux_peripheral)
{
    8174:	e92d4800 	push	{fp, lr}
    8178:	e28db004 	add	fp, sp, #4
    817c:	e24dd008 	sub	sp, sp, #8
    8180:	e50b0008 	str	r0, [fp, #-8]
    8184:	e50b100c 	str	r1, [fp, #-12]
/home/cf/ZCU/OS/practical/ex3/original/kernel/src/drivers/bcm_aux.cpp:18
    Set_Register(hal::AUX_Reg::ENABLES, Get_Register(hal::AUX_Reg::ENABLES) & ~(1 << static_cast<uint32_t>(aux_peripheral)));
    8188:	e3a01001 	mov	r1, #1
    818c:	e51b0008 	ldr	r0, [fp, #-8]
    8190:	eb00001d 	bl	820c <_ZN4CAUX12Get_RegisterEN3hal7AUX_RegE>
    8194:	e1a02000 	mov	r2, r0
    8198:	e51b300c 	ldr	r3, [fp, #-12]
    819c:	e3a01001 	mov	r1, #1
    81a0:	e1a03311 	lsl	r3, r1, r3
    81a4:	e1e03003 	mvn	r3, r3
    81a8:	e0033002 	and	r3, r3, r2
    81ac:	e1a02003 	mov	r2, r3
    81b0:	e3a01001 	mov	r1, #1
    81b4:	e51b0008 	ldr	r0, [fp, #-8]
    81b8:	eb000002 	bl	81c8 <_ZN4CAUX12Set_RegisterEN3hal7AUX_RegEj>
/home/cf/ZCU/OS/practical/ex3/original/kernel/src/drivers/bcm_aux.cpp:19
}
    81bc:	e320f000 	nop	{0}
    81c0:	e24bd004 	sub	sp, fp, #4
    81c4:	e8bd8800 	pop	{fp, pc}

000081c8 <_ZN4CAUX12Set_RegisterEN3hal7AUX_RegEj>:
_ZN4CAUX12Set_RegisterEN3hal7AUX_RegEj():
/home/cf/ZCU/OS/practical/ex3/original/kernel/src/drivers/bcm_aux.cpp:22

void CAUX::Set_Register(hal::AUX_Reg reg_idx, uint32_t value)
{
    81c8:	e52db004 	push	{fp}		; (str fp, [sp, #-4]!)
    81cc:	e28db000 	add	fp, sp, #0
    81d0:	e24dd014 	sub	sp, sp, #20
    81d4:	e50b0008 	str	r0, [fp, #-8]
    81d8:	e50b100c 	str	r1, [fp, #-12]
    81dc:	e50b2010 	str	r2, [fp, #-16]
/home/cf/ZCU/OS/practical/ex3/original/kernel/src/drivers/bcm_aux.cpp:23
    mAUX_Reg[static_cast<unsigned int>(reg_idx)] = value;
    81e0:	e51b3008 	ldr	r3, [fp, #-8]
    81e4:	e5932000 	ldr	r2, [r3]
    81e8:	e51b300c 	ldr	r3, [fp, #-12]
    81ec:	e1a03103 	lsl	r3, r3, #2
    81f0:	e0823003 	add	r3, r2, r3
    81f4:	e51b2010 	ldr	r2, [fp, #-16]
    81f8:	e5832000 	str	r2, [r3]
/home/cf/ZCU/OS/practical/ex3/original/kernel/src/drivers/bcm_aux.cpp:24
}
    81fc:	e320f000 	nop	{0}
    8200:	e28bd000 	add	sp, fp, #0
    8204:	e49db004 	pop	{fp}		; (ldr fp, [sp], #4)
    8208:	e12fff1e 	bx	lr

0000820c <_ZN4CAUX12Get_RegisterEN3hal7AUX_RegE>:
_ZN4CAUX12Get_RegisterEN3hal7AUX_RegE():
/home/cf/ZCU/OS/practical/ex3/original/kernel/src/drivers/bcm_aux.cpp:27

uint32_t CAUX::Get_Register(hal::AUX_Reg reg_idx)
{
    820c:	e52db004 	push	{fp}		; (str fp, [sp, #-4]!)
    8210:	e28db000 	add	fp, sp, #0
    8214:	e24dd00c 	sub	sp, sp, #12
    8218:	e50b0008 	str	r0, [fp, #-8]
    821c:	e50b100c 	str	r1, [fp, #-12]
/home/cf/ZCU/OS/practical/ex3/original/kernel/src/drivers/bcm_aux.cpp:28
    return mAUX_Reg[static_cast<unsigned int>(reg_idx)];
    8220:	e51b3008 	ldr	r3, [fp, #-8]
    8224:	e5932000 	ldr	r2, [r3]
    8228:	e51b300c 	ldr	r3, [fp, #-12]
    822c:	e1a03103 	lsl	r3, r3, #2
    8230:	e0823003 	add	r3, r2, r3
    8234:	e5933000 	ldr	r3, [r3]
/home/cf/ZCU/OS/practical/ex3/original/kernel/src/drivers/bcm_aux.cpp:29
}
    8238:	e1a00003 	mov	r0, r3
    823c:	e28bd000 	add	sp, fp, #0
    8240:	e49db004 	pop	{fp}		; (ldr fp, [sp], #4)
    8244:	e12fff1e 	bx	lr

00008248 <_Z41__static_initialization_and_destruction_0ii>:
_Z41__static_initialization_and_destruction_0ii():
/home/cf/ZCU/OS/practical/ex3/original/kernel/src/drivers/bcm_aux.cpp:29
    8248:	e92d4800 	push	{fp, lr}
    824c:	e28db004 	add	fp, sp, #4
    8250:	e24dd008 	sub	sp, sp, #8
    8254:	e50b0008 	str	r0, [fp, #-8]
    8258:	e50b100c 	str	r1, [fp, #-12]
    825c:	e51b3008 	ldr	r3, [fp, #-8]
    8260:	e3530001 	cmp	r3, #1
    8264:	1a000006 	bne	8284 <_Z41__static_initialization_and_destruction_0ii+0x3c>
/home/cf/ZCU/OS/practical/ex3/original/kernel/src/drivers/bcm_aux.cpp:29 (discriminator 1)
    8268:	e51b300c 	ldr	r3, [fp, #-12]
    826c:	e59f201c 	ldr	r2, [pc, #28]	; 8290 <_Z41__static_initialization_and_destruction_0ii+0x48>
    8270:	e1530002 	cmp	r3, r2
    8274:	1a000002 	bne	8284 <_Z41__static_initialization_and_destruction_0ii+0x3c>
/home/cf/ZCU/OS/practical/ex3/original/kernel/src/drivers/bcm_aux.cpp:3
CAUX sAUX(hal::AUX_Base);
    8278:	e59f1014 	ldr	r1, [pc, #20]	; 8294 <_Z41__static_initialization_and_destruction_0ii+0x4c>
    827c:	e59f0014 	ldr	r0, [pc, #20]	; 8298 <_Z41__static_initialization_and_destruction_0ii+0x50>
    8280:	ebffff9a 	bl	80f0 <_ZN4CAUXC1Ej>
/home/cf/ZCU/OS/practical/ex3/original/kernel/src/drivers/bcm_aux.cpp:29
}
    8284:	e320f000 	nop	{0}
    8288:	e24bd004 	sub	sp, fp, #4
    828c:	e8bd8800 	pop	{fp, pc}
    8290:	0000ffff 	strdeq	pc, [r0], -pc	; <UNPREDICTABLE>
    8294:	20215000 	eorcs	r5, r1, r0
    8298:	00008ff0 	strdeq	r8, [r0], -r0

0000829c <_GLOBAL__sub_I_sAUX>:
_GLOBAL__sub_I_sAUX():
/home/cf/ZCU/OS/practical/ex3/original/kernel/src/drivers/bcm_aux.cpp:29
    829c:	e92d4800 	push	{fp, lr}
    82a0:	e28db004 	add	fp, sp, #4
    82a4:	e59f1008 	ldr	r1, [pc, #8]	; 82b4 <_GLOBAL__sub_I_sAUX+0x18>
    82a8:	e3a00001 	mov	r0, #1
    82ac:	ebffffe5 	bl	8248 <_Z41__static_initialization_and_destruction_0ii>
    82b0:	e8bd8800 	pop	{fp, pc}
    82b4:	0000ffff 	strdeq	pc, [r0], -pc	; <UNPREDICTABLE>

000082b8 <_ZN13CGPIO_HandlerC1Ej>:
_ZN13CGPIO_HandlerC2Ej():
/home/cf/ZCU/OS/practical/ex3/original/kernel/src/drivers/gpio.cpp:6
#include <hal/peripherals.h>
#include <drivers/gpio.h>

CGPIO_Handler sGPIO(hal::GPIO_Base);

CGPIO_Handler::CGPIO_Handler(unsigned int gpio_base_addr)
    82b8:	e52db004 	push	{fp}		; (str fp, [sp, #-4]!)
    82bc:	e28db000 	add	fp, sp, #0
    82c0:	e24dd00c 	sub	sp, sp, #12
    82c4:	e50b0008 	str	r0, [fp, #-8]
    82c8:	e50b100c 	str	r1, [fp, #-12]
/home/cf/ZCU/OS/practical/ex3/original/kernel/src/drivers/gpio.cpp:7
	: mGPIO(reinterpret_cast<unsigned int*>(gpio_base_addr))
    82cc:	e51b200c 	ldr	r2, [fp, #-12]
    82d0:	e51b3008 	ldr	r3, [fp, #-8]
    82d4:	e5832000 	str	r2, [r3]
/home/cf/ZCU/OS/practical/ex3/original/kernel/src/drivers/gpio.cpp:10
{
	//
}
    82d8:	e51b3008 	ldr	r3, [fp, #-8]
    82dc:	e1a00003 	mov	r0, r3
    82e0:	e28bd000 	add	sp, fp, #0
    82e4:	e49db004 	pop	{fp}		; (ldr fp, [sp], #4)
    82e8:	e12fff1e 	bx	lr

000082ec <_ZNK13CGPIO_Handler19Get_GPFSEL_LocationEjRjS0_>:
_ZNK13CGPIO_Handler19Get_GPFSEL_LocationEjRjS0_():
/home/cf/ZCU/OS/practical/ex3/original/kernel/src/drivers/gpio.cpp:13

bool CGPIO_Handler::Get_GPFSEL_Location(uint32_t pin, uint32_t& reg, uint32_t& bit_idx) const
{
    82ec:	e52db004 	push	{fp}		; (str fp, [sp, #-4]!)
    82f0:	e28db000 	add	fp, sp, #0
    82f4:	e24dd014 	sub	sp, sp, #20
    82f8:	e50b0008 	str	r0, [fp, #-8]
    82fc:	e50b100c 	str	r1, [fp, #-12]
    8300:	e50b2010 	str	r2, [fp, #-16]
    8304:	e50b3014 	str	r3, [fp, #-20]	; 0xffffffec
/home/cf/ZCU/OS/practical/ex3/original/kernel/src/drivers/gpio.cpp:14
	if (pin > hal::GPIO_Pin_Count)
    8308:	e51b300c 	ldr	r3, [fp, #-12]
    830c:	e3530036 	cmp	r3, #54	; 0x36
    8310:	9a000001 	bls	831c <_ZNK13CGPIO_Handler19Get_GPFSEL_LocationEjRjS0_+0x30>
/home/cf/ZCU/OS/practical/ex3/original/kernel/src/drivers/gpio.cpp:15
		return false;
    8314:	e3a03000 	mov	r3, #0
    8318:	ea000033 	b	83ec <_ZNK13CGPIO_Handler19Get_GPFSEL_LocationEjRjS0_+0x100>
/home/cf/ZCU/OS/practical/ex3/original/kernel/src/drivers/gpio.cpp:17
	
	switch (pin / 10)
    831c:	e51b300c 	ldr	r3, [fp, #-12]
    8320:	e59f20d4 	ldr	r2, [pc, #212]	; 83fc <_ZNK13CGPIO_Handler19Get_GPFSEL_LocationEjRjS0_+0x110>
    8324:	e0832392 	umull	r2, r3, r2, r3
    8328:	e1a031a3 	lsr	r3, r3, #3
    832c:	e3530005 	cmp	r3, #5
    8330:	979ff103 	ldrls	pc, [pc, r3, lsl #2]
    8334:	ea00001d 	b	83b0 <_ZNK13CGPIO_Handler19Get_GPFSEL_LocationEjRjS0_+0xc4>
    8338:	00008350 	andeq	r8, r0, r0, asr r3
    833c:	00008360 	andeq	r8, r0, r0, ror #6
    8340:	00008370 	andeq	r8, r0, r0, ror r3
    8344:	00008380 	andeq	r8, r0, r0, lsl #7
    8348:	00008390 	muleq	r0, r0, r3
    834c:	000083a0 	andeq	r8, r0, r0, lsr #7
/home/cf/ZCU/OS/practical/ex3/original/kernel/src/drivers/gpio.cpp:19
	{
		case 0: reg = static_cast<uint32_t>(hal::GPIO_Reg::GPFSEL0); break;
    8350:	e51b3010 	ldr	r3, [fp, #-16]
    8354:	e3a02000 	mov	r2, #0
    8358:	e5832000 	str	r2, [r3]
    835c:	ea000013 	b	83b0 <_ZNK13CGPIO_Handler19Get_GPFSEL_LocationEjRjS0_+0xc4>
/home/cf/ZCU/OS/practical/ex3/original/kernel/src/drivers/gpio.cpp:20
		case 1: reg = static_cast<uint32_t>(hal::GPIO_Reg::GPFSEL1); break;
    8360:	e51b3010 	ldr	r3, [fp, #-16]
    8364:	e3a02001 	mov	r2, #1
    8368:	e5832000 	str	r2, [r3]
    836c:	ea00000f 	b	83b0 <_ZNK13CGPIO_Handler19Get_GPFSEL_LocationEjRjS0_+0xc4>
/home/cf/ZCU/OS/practical/ex3/original/kernel/src/drivers/gpio.cpp:21
		case 2: reg = static_cast<uint32_t>(hal::GPIO_Reg::GPFSEL2); break;
    8370:	e51b3010 	ldr	r3, [fp, #-16]
    8374:	e3a02002 	mov	r2, #2
    8378:	e5832000 	str	r2, [r3]
    837c:	ea00000b 	b	83b0 <_ZNK13CGPIO_Handler19Get_GPFSEL_LocationEjRjS0_+0xc4>
/home/cf/ZCU/OS/practical/ex3/original/kernel/src/drivers/gpio.cpp:22
		case 3: reg = static_cast<uint32_t>(hal::GPIO_Reg::GPFSEL3); break;
    8380:	e51b3010 	ldr	r3, [fp, #-16]
    8384:	e3a02003 	mov	r2, #3
    8388:	e5832000 	str	r2, [r3]
    838c:	ea000007 	b	83b0 <_ZNK13CGPIO_Handler19Get_GPFSEL_LocationEjRjS0_+0xc4>
/home/cf/ZCU/OS/practical/ex3/original/kernel/src/drivers/gpio.cpp:23
		case 4: reg = static_cast<uint32_t>(hal::GPIO_Reg::GPFSEL4); break;
    8390:	e51b3010 	ldr	r3, [fp, #-16]
    8394:	e3a02004 	mov	r2, #4
    8398:	e5832000 	str	r2, [r3]
    839c:	ea000003 	b	83b0 <_ZNK13CGPIO_Handler19Get_GPFSEL_LocationEjRjS0_+0xc4>
/home/cf/ZCU/OS/practical/ex3/original/kernel/src/drivers/gpio.cpp:24
		case 5: reg = static_cast<uint32_t>(hal::GPIO_Reg::GPFSEL5); break;
    83a0:	e51b3010 	ldr	r3, [fp, #-16]
    83a4:	e3a02005 	mov	r2, #5
    83a8:	e5832000 	str	r2, [r3]
    83ac:	e320f000 	nop	{0}
/home/cf/ZCU/OS/practical/ex3/original/kernel/src/drivers/gpio.cpp:27
	}
	
	bit_idx = (pin % 10) * 3;
    83b0:	e51b100c 	ldr	r1, [fp, #-12]
    83b4:	e59f3040 	ldr	r3, [pc, #64]	; 83fc <_ZNK13CGPIO_Handler19Get_GPFSEL_LocationEjRjS0_+0x110>
    83b8:	e0832193 	umull	r2, r3, r3, r1
    83bc:	e1a021a3 	lsr	r2, r3, #3
    83c0:	e1a03002 	mov	r3, r2
    83c4:	e1a03103 	lsl	r3, r3, #2
    83c8:	e0833002 	add	r3, r3, r2
    83cc:	e1a03083 	lsl	r3, r3, #1
    83d0:	e0412003 	sub	r2, r1, r3
    83d4:	e1a03002 	mov	r3, r2
    83d8:	e1a03083 	lsl	r3, r3, #1
    83dc:	e0832002 	add	r2, r3, r2
    83e0:	e51b3014 	ldr	r3, [fp, #-20]	; 0xffffffec
    83e4:	e5832000 	str	r2, [r3]
/home/cf/ZCU/OS/practical/ex3/original/kernel/src/drivers/gpio.cpp:29
	
	return true;
    83e8:	e3a03001 	mov	r3, #1
/home/cf/ZCU/OS/practical/ex3/original/kernel/src/drivers/gpio.cpp:30
}
    83ec:	e1a00003 	mov	r0, r3
    83f0:	e28bd000 	add	sp, fp, #0
    83f4:	e49db004 	pop	{fp}		; (ldr fp, [sp], #4)
    83f8:	e12fff1e 	bx	lr
    83fc:	cccccccd 	stclgt	12, cr12, [ip], {205}	; 0xcd

00008400 <_ZNK13CGPIO_Handler18Get_GPCLR_LocationEjRjS0_>:
_ZNK13CGPIO_Handler18Get_GPCLR_LocationEjRjS0_():
/home/cf/ZCU/OS/practical/ex3/original/kernel/src/drivers/gpio.cpp:33

bool CGPIO_Handler::Get_GPCLR_Location(uint32_t pin, uint32_t& reg, uint32_t& bit_idx) const
{
    8400:	e52db004 	push	{fp}		; (str fp, [sp, #-4]!)
    8404:	e28db000 	add	fp, sp, #0
    8408:	e24dd014 	sub	sp, sp, #20
    840c:	e50b0008 	str	r0, [fp, #-8]
    8410:	e50b100c 	str	r1, [fp, #-12]
    8414:	e50b2010 	str	r2, [fp, #-16]
    8418:	e50b3014 	str	r3, [fp, #-20]	; 0xffffffec
/home/cf/ZCU/OS/practical/ex3/original/kernel/src/drivers/gpio.cpp:34
	if (pin > hal::GPIO_Pin_Count)
    841c:	e51b300c 	ldr	r3, [fp, #-12]
    8420:	e3530036 	cmp	r3, #54	; 0x36
    8424:	9a000001 	bls	8430 <_ZNK13CGPIO_Handler18Get_GPCLR_LocationEjRjS0_+0x30>
/home/cf/ZCU/OS/practical/ex3/original/kernel/src/drivers/gpio.cpp:35
		return false;
    8428:	e3a03000 	mov	r3, #0
    842c:	ea00000c 	b	8464 <_ZNK13CGPIO_Handler18Get_GPCLR_LocationEjRjS0_+0x64>
/home/cf/ZCU/OS/practical/ex3/original/kernel/src/drivers/gpio.cpp:37
	
	reg = static_cast<uint32_t>((pin < 32) ? hal::GPIO_Reg::GPCLR0 : hal::GPIO_Reg::GPCLR1);
    8430:	e51b300c 	ldr	r3, [fp, #-12]
    8434:	e353001f 	cmp	r3, #31
    8438:	8a000001 	bhi	8444 <_ZNK13CGPIO_Handler18Get_GPCLR_LocationEjRjS0_+0x44>
/home/cf/ZCU/OS/practical/ex3/original/kernel/src/drivers/gpio.cpp:37 (discriminator 1)
    843c:	e3a0200a 	mov	r2, #10
    8440:	ea000000 	b	8448 <_ZNK13CGPIO_Handler18Get_GPCLR_LocationEjRjS0_+0x48>
/home/cf/ZCU/OS/practical/ex3/original/kernel/src/drivers/gpio.cpp:37 (discriminator 2)
    8444:	e3a0200b 	mov	r2, #11
/home/cf/ZCU/OS/practical/ex3/original/kernel/src/drivers/gpio.cpp:37 (discriminator 4)
    8448:	e51b3010 	ldr	r3, [fp, #-16]
    844c:	e5832000 	str	r2, [r3]
/home/cf/ZCU/OS/practical/ex3/original/kernel/src/drivers/gpio.cpp:38 (discriminator 4)
	bit_idx = pin % 32;
    8450:	e51b300c 	ldr	r3, [fp, #-12]
    8454:	e203201f 	and	r2, r3, #31
    8458:	e51b3014 	ldr	r3, [fp, #-20]	; 0xffffffec
    845c:	e5832000 	str	r2, [r3]
/home/cf/ZCU/OS/practical/ex3/original/kernel/src/drivers/gpio.cpp:40 (discriminator 4)
	
	return true;
    8460:	e3a03001 	mov	r3, #1
/home/cf/ZCU/OS/practical/ex3/original/kernel/src/drivers/gpio.cpp:41
}
    8464:	e1a00003 	mov	r0, r3
    8468:	e28bd000 	add	sp, fp, #0
    846c:	e49db004 	pop	{fp}		; (ldr fp, [sp], #4)
    8470:	e12fff1e 	bx	lr

00008474 <_ZNK13CGPIO_Handler18Get_GPSET_LocationEjRjS0_>:
_ZNK13CGPIO_Handler18Get_GPSET_LocationEjRjS0_():
/home/cf/ZCU/OS/practical/ex3/original/kernel/src/drivers/gpio.cpp:44

bool CGPIO_Handler::Get_GPSET_Location(uint32_t pin, uint32_t& reg, uint32_t& bit_idx) const
{
    8474:	e52db004 	push	{fp}		; (str fp, [sp, #-4]!)
    8478:	e28db000 	add	fp, sp, #0
    847c:	e24dd014 	sub	sp, sp, #20
    8480:	e50b0008 	str	r0, [fp, #-8]
    8484:	e50b100c 	str	r1, [fp, #-12]
    8488:	e50b2010 	str	r2, [fp, #-16]
    848c:	e50b3014 	str	r3, [fp, #-20]	; 0xffffffec
/home/cf/ZCU/OS/practical/ex3/original/kernel/src/drivers/gpio.cpp:45
	if (pin > hal::GPIO_Pin_Count)
    8490:	e51b300c 	ldr	r3, [fp, #-12]
    8494:	e3530036 	cmp	r3, #54	; 0x36
    8498:	9a000001 	bls	84a4 <_ZNK13CGPIO_Handler18Get_GPSET_LocationEjRjS0_+0x30>
/home/cf/ZCU/OS/practical/ex3/original/kernel/src/drivers/gpio.cpp:46
		return false;
    849c:	e3a03000 	mov	r3, #0
    84a0:	ea00000c 	b	84d8 <_ZNK13CGPIO_Handler18Get_GPSET_LocationEjRjS0_+0x64>
/home/cf/ZCU/OS/practical/ex3/original/kernel/src/drivers/gpio.cpp:48
	
	reg = static_cast<uint32_t>((pin < 32) ? hal::GPIO_Reg::GPSET0 : hal::GPIO_Reg::GPSET1);
    84a4:	e51b300c 	ldr	r3, [fp, #-12]
    84a8:	e353001f 	cmp	r3, #31
    84ac:	8a000001 	bhi	84b8 <_ZNK13CGPIO_Handler18Get_GPSET_LocationEjRjS0_+0x44>
/home/cf/ZCU/OS/practical/ex3/original/kernel/src/drivers/gpio.cpp:48 (discriminator 1)
    84b0:	e3a02007 	mov	r2, #7
    84b4:	ea000000 	b	84bc <_ZNK13CGPIO_Handler18Get_GPSET_LocationEjRjS0_+0x48>
/home/cf/ZCU/OS/practical/ex3/original/kernel/src/drivers/gpio.cpp:48 (discriminator 2)
    84b8:	e3a02008 	mov	r2, #8
/home/cf/ZCU/OS/practical/ex3/original/kernel/src/drivers/gpio.cpp:48 (discriminator 4)
    84bc:	e51b3010 	ldr	r3, [fp, #-16]
    84c0:	e5832000 	str	r2, [r3]
/home/cf/ZCU/OS/practical/ex3/original/kernel/src/drivers/gpio.cpp:49 (discriminator 4)
	bit_idx = pin % 32;
    84c4:	e51b300c 	ldr	r3, [fp, #-12]
    84c8:	e203201f 	and	r2, r3, #31
    84cc:	e51b3014 	ldr	r3, [fp, #-20]	; 0xffffffec
    84d0:	e5832000 	str	r2, [r3]
/home/cf/ZCU/OS/practical/ex3/original/kernel/src/drivers/gpio.cpp:51 (discriminator 4)
	
	return true;
    84d4:	e3a03001 	mov	r3, #1
/home/cf/ZCU/OS/practical/ex3/original/kernel/src/drivers/gpio.cpp:52
}
    84d8:	e1a00003 	mov	r0, r3
    84dc:	e28bd000 	add	sp, fp, #0
    84e0:	e49db004 	pop	{fp}		; (ldr fp, [sp], #4)
    84e4:	e12fff1e 	bx	lr

000084e8 <_ZNK13CGPIO_Handler18Get_GPLEV_LocationEjRjS0_>:
_ZNK13CGPIO_Handler18Get_GPLEV_LocationEjRjS0_():
/home/cf/ZCU/OS/practical/ex3/original/kernel/src/drivers/gpio.cpp:55

bool CGPIO_Handler::Get_GPLEV_Location(uint32_t pin, uint32_t& reg, uint32_t& bit_idx) const
{
    84e8:	e52db004 	push	{fp}		; (str fp, [sp, #-4]!)
    84ec:	e28db000 	add	fp, sp, #0
    84f0:	e24dd014 	sub	sp, sp, #20
    84f4:	e50b0008 	str	r0, [fp, #-8]
    84f8:	e50b100c 	str	r1, [fp, #-12]
    84fc:	e50b2010 	str	r2, [fp, #-16]
    8500:	e50b3014 	str	r3, [fp, #-20]	; 0xffffffec
/home/cf/ZCU/OS/practical/ex3/original/kernel/src/drivers/gpio.cpp:56
	if (pin > hal::GPIO_Pin_Count)
    8504:	e51b300c 	ldr	r3, [fp, #-12]
    8508:	e3530036 	cmp	r3, #54	; 0x36
    850c:	9a000001 	bls	8518 <_ZNK13CGPIO_Handler18Get_GPLEV_LocationEjRjS0_+0x30>
/home/cf/ZCU/OS/practical/ex3/original/kernel/src/drivers/gpio.cpp:57
		return false;
    8510:	e3a03000 	mov	r3, #0
    8514:	ea00000c 	b	854c <_ZNK13CGPIO_Handler18Get_GPLEV_LocationEjRjS0_+0x64>
/home/cf/ZCU/OS/practical/ex3/original/kernel/src/drivers/gpio.cpp:59
	
	reg = static_cast<uint32_t>((pin < 32) ? hal::GPIO_Reg::GPLEV0 : hal::GPIO_Reg::GPLEV1);
    8518:	e51b300c 	ldr	r3, [fp, #-12]
    851c:	e353001f 	cmp	r3, #31
    8520:	8a000001 	bhi	852c <_ZNK13CGPIO_Handler18Get_GPLEV_LocationEjRjS0_+0x44>
/home/cf/ZCU/OS/practical/ex3/original/kernel/src/drivers/gpio.cpp:59 (discriminator 1)
    8524:	e3a0200d 	mov	r2, #13
    8528:	ea000000 	b	8530 <_ZNK13CGPIO_Handler18Get_GPLEV_LocationEjRjS0_+0x48>
/home/cf/ZCU/OS/practical/ex3/original/kernel/src/drivers/gpio.cpp:59 (discriminator 2)
    852c:	e3a0200e 	mov	r2, #14
/home/cf/ZCU/OS/practical/ex3/original/kernel/src/drivers/gpio.cpp:59 (discriminator 4)
    8530:	e51b3010 	ldr	r3, [fp, #-16]
    8534:	e5832000 	str	r2, [r3]
/home/cf/ZCU/OS/practical/ex3/original/kernel/src/drivers/gpio.cpp:60 (discriminator 4)
	bit_idx = pin % 32;
    8538:	e51b300c 	ldr	r3, [fp, #-12]
    853c:	e203201f 	and	r2, r3, #31
    8540:	e51b3014 	ldr	r3, [fp, #-20]	; 0xffffffec
    8544:	e5832000 	str	r2, [r3]
/home/cf/ZCU/OS/practical/ex3/original/kernel/src/drivers/gpio.cpp:62 (discriminator 4)
	
	return true;
    8548:	e3a03001 	mov	r3, #1
/home/cf/ZCU/OS/practical/ex3/original/kernel/src/drivers/gpio.cpp:63
}
    854c:	e1a00003 	mov	r0, r3
    8550:	e28bd000 	add	sp, fp, #0
    8554:	e49db004 	pop	{fp}		; (ldr fp, [sp], #4)
    8558:	e12fff1e 	bx	lr

0000855c <_ZN13CGPIO_Handler17Set_GPIO_FunctionEj14NGPIO_Function>:
_ZN13CGPIO_Handler17Set_GPIO_FunctionEj14NGPIO_Function():
/home/cf/ZCU/OS/practical/ex3/original/kernel/src/drivers/gpio.cpp:66
		
void CGPIO_Handler::Set_GPIO_Function(uint32_t pin, NGPIO_Function func)
{
    855c:	e92d4800 	push	{fp, lr}
    8560:	e28db004 	add	fp, sp, #4
    8564:	e24dd018 	sub	sp, sp, #24
    8568:	e50b0010 	str	r0, [fp, #-16]
    856c:	e50b1014 	str	r1, [fp, #-20]	; 0xffffffec
    8570:	e1a03002 	mov	r3, r2
    8574:	e54b3015 	strb	r3, [fp, #-21]	; 0xffffffeb
/home/cf/ZCU/OS/practical/ex3/original/kernel/src/drivers/gpio.cpp:68
	uint32_t reg, bit;
	if (Get_GPFSEL_Location(pin, reg, bit))
    8578:	e24b300c 	sub	r3, fp, #12
    857c:	e24b2008 	sub	r2, fp, #8
    8580:	e51b1014 	ldr	r1, [fp, #-20]	; 0xffffffec
    8584:	e51b0010 	ldr	r0, [fp, #-16]
    8588:	ebffff57 	bl	82ec <_ZNK13CGPIO_Handler19Get_GPFSEL_LocationEjRjS0_>
    858c:	e1a03000 	mov	r3, r0
    8590:	e3530000 	cmp	r3, #0
    8594:	1a000015 	bne	85f0 <_ZN13CGPIO_Handler17Set_GPIO_FunctionEj14NGPIO_Function+0x94>
/home/cf/ZCU/OS/practical/ex3/original/kernel/src/drivers/gpio.cpp:71
		return;
	
	mGPIO[reg] = (mGPIO[reg] & (~static_cast<unsigned int>(7 << bit)) )
    8598:	e51b3010 	ldr	r3, [fp, #-16]
    859c:	e5932000 	ldr	r2, [r3]
    85a0:	e51b3008 	ldr	r3, [fp, #-8]
    85a4:	e1a03103 	lsl	r3, r3, #2
    85a8:	e0823003 	add	r3, r2, r3
    85ac:	e5932000 	ldr	r2, [r3]
    85b0:	e51b300c 	ldr	r3, [fp, #-12]
    85b4:	e3a01007 	mov	r1, #7
    85b8:	e1a03311 	lsl	r3, r1, r3
    85bc:	e1e03003 	mvn	r3, r3
    85c0:	e0021003 	and	r1, r2, r3
/home/cf/ZCU/OS/practical/ex3/original/kernel/src/drivers/gpio.cpp:72
				| (static_cast<unsigned int>(func) << bit);
    85c4:	e55b2015 	ldrb	r2, [fp, #-21]	; 0xffffffeb
    85c8:	e51b300c 	ldr	r3, [fp, #-12]
    85cc:	e1a02312 	lsl	r2, r2, r3
/home/cf/ZCU/OS/practical/ex3/original/kernel/src/drivers/gpio.cpp:71
	mGPIO[reg] = (mGPIO[reg] & (~static_cast<unsigned int>(7 << bit)) )
    85d0:	e51b3010 	ldr	r3, [fp, #-16]
    85d4:	e5930000 	ldr	r0, [r3]
    85d8:	e51b3008 	ldr	r3, [fp, #-8]
    85dc:	e1a03103 	lsl	r3, r3, #2
    85e0:	e0803003 	add	r3, r0, r3
/home/cf/ZCU/OS/practical/ex3/original/kernel/src/drivers/gpio.cpp:72
				| (static_cast<unsigned int>(func) << bit);
    85e4:	e1812002 	orr	r2, r1, r2
/home/cf/ZCU/OS/practical/ex3/original/kernel/src/drivers/gpio.cpp:71
	mGPIO[reg] = (mGPIO[reg] & (~static_cast<unsigned int>(7 << bit)) )
    85e8:	e5832000 	str	r2, [r3]
    85ec:	ea000000 	b	85f4 <_ZN13CGPIO_Handler17Set_GPIO_FunctionEj14NGPIO_Function+0x98>
/home/cf/ZCU/OS/practical/ex3/original/kernel/src/drivers/gpio.cpp:69
		return;
    85f0:	e320f000 	nop	{0}
/home/cf/ZCU/OS/practical/ex3/original/kernel/src/drivers/gpio.cpp:73
}
    85f4:	e24bd004 	sub	sp, fp, #4
    85f8:	e8bd8800 	pop	{fp, pc}

000085fc <_ZNK13CGPIO_Handler17Get_GPIO_FunctionEj>:
_ZNK13CGPIO_Handler17Get_GPIO_FunctionEj():
/home/cf/ZCU/OS/practical/ex3/original/kernel/src/drivers/gpio.cpp:76

NGPIO_Function CGPIO_Handler::Get_GPIO_Function(uint32_t pin) const
{
    85fc:	e92d4800 	push	{fp, lr}
    8600:	e28db004 	add	fp, sp, #4
    8604:	e24dd010 	sub	sp, sp, #16
    8608:	e50b0010 	str	r0, [fp, #-16]
    860c:	e50b1014 	str	r1, [fp, #-20]	; 0xffffffec
/home/cf/ZCU/OS/practical/ex3/original/kernel/src/drivers/gpio.cpp:78
	uint32_t reg, bit;
	if (Get_GPFSEL_Location(pin, reg, bit))
    8610:	e24b300c 	sub	r3, fp, #12
    8614:	e24b2008 	sub	r2, fp, #8
    8618:	e51b1014 	ldr	r1, [fp, #-20]	; 0xffffffec
    861c:	e51b0010 	ldr	r0, [fp, #-16]
    8620:	ebffff31 	bl	82ec <_ZNK13CGPIO_Handler19Get_GPFSEL_LocationEjRjS0_>
    8624:	e1a03000 	mov	r3, r0
    8628:	e3530000 	cmp	r3, #0
    862c:	0a000001 	beq	8638 <_ZNK13CGPIO_Handler17Get_GPIO_FunctionEj+0x3c>
/home/cf/ZCU/OS/practical/ex3/original/kernel/src/drivers/gpio.cpp:79
		return NGPIO_Function::Unspecified;
    8630:	e3a03008 	mov	r3, #8
    8634:	ea00000a 	b	8664 <_ZNK13CGPIO_Handler17Get_GPIO_FunctionEj+0x68>
/home/cf/ZCU/OS/practical/ex3/original/kernel/src/drivers/gpio.cpp:81
	
	return static_cast<NGPIO_Function>((mGPIO[reg] >> bit) & 7);
    8638:	e51b3010 	ldr	r3, [fp, #-16]
    863c:	e5932000 	ldr	r2, [r3]
    8640:	e51b3008 	ldr	r3, [fp, #-8]
    8644:	e1a03103 	lsl	r3, r3, #2
    8648:	e0823003 	add	r3, r2, r3
    864c:	e5932000 	ldr	r2, [r3]
    8650:	e51b300c 	ldr	r3, [fp, #-12]
    8654:	e1a03332 	lsr	r3, r2, r3
    8658:	e6ef3073 	uxtb	r3, r3
    865c:	e2033007 	and	r3, r3, #7
    8660:	e6ef3073 	uxtb	r3, r3
/home/cf/ZCU/OS/practical/ex3/original/kernel/src/drivers/gpio.cpp:82 (discriminator 1)
}
    8664:	e1a00003 	mov	r0, r3
    8668:	e24bd004 	sub	sp, fp, #4
    866c:	e8bd8800 	pop	{fp, pc}

00008670 <_ZN13CGPIO_Handler10Set_OutputEjb>:
_ZN13CGPIO_Handler10Set_OutputEjb():
/home/cf/ZCU/OS/practical/ex3/original/kernel/src/drivers/gpio.cpp:85

void CGPIO_Handler::Set_Output(uint32_t pin, bool set)
{
    8670:	e92d4800 	push	{fp, lr}
    8674:	e28db004 	add	fp, sp, #4
    8678:	e24dd018 	sub	sp, sp, #24
    867c:	e50b0010 	str	r0, [fp, #-16]
    8680:	e50b1014 	str	r1, [fp, #-20]	; 0xffffffec
    8684:	e1a03002 	mov	r3, r2
    8688:	e54b3015 	strb	r3, [fp, #-21]	; 0xffffffeb
/home/cf/ZCU/OS/practical/ex3/original/kernel/src/drivers/gpio.cpp:87
	uint32_t reg, bit;
	if (!(set && Get_GPSET_Location(pin, reg, bit)) && !(!set && Get_GPCLR_Location(pin, reg, bit)))
    868c:	e55b3015 	ldrb	r3, [fp, #-21]	; 0xffffffeb
    8690:	e2233001 	eor	r3, r3, #1
    8694:	e6ef3073 	uxtb	r3, r3
    8698:	e3530000 	cmp	r3, #0
    869c:	1a000009 	bne	86c8 <_ZN13CGPIO_Handler10Set_OutputEjb+0x58>
/home/cf/ZCU/OS/practical/ex3/original/kernel/src/drivers/gpio.cpp:87 (discriminator 2)
    86a0:	e24b300c 	sub	r3, fp, #12
    86a4:	e24b2008 	sub	r2, fp, #8
    86a8:	e51b1014 	ldr	r1, [fp, #-20]	; 0xffffffec
    86ac:	e51b0010 	ldr	r0, [fp, #-16]
    86b0:	ebffff6f 	bl	8474 <_ZNK13CGPIO_Handler18Get_GPSET_LocationEjRjS0_>
    86b4:	e1a03000 	mov	r3, r0
    86b8:	e2233001 	eor	r3, r3, #1
    86bc:	e6ef3073 	uxtb	r3, r3
    86c0:	e3530000 	cmp	r3, #0
    86c4:	0a00000e 	beq	8704 <_ZN13CGPIO_Handler10Set_OutputEjb+0x94>
/home/cf/ZCU/OS/practical/ex3/original/kernel/src/drivers/gpio.cpp:87 (discriminator 3)
    86c8:	e55b3015 	ldrb	r3, [fp, #-21]	; 0xffffffeb
    86cc:	e3530000 	cmp	r3, #0
    86d0:	1a000009 	bne	86fc <_ZN13CGPIO_Handler10Set_OutputEjb+0x8c>
/home/cf/ZCU/OS/practical/ex3/original/kernel/src/drivers/gpio.cpp:87 (discriminator 6)
    86d4:	e24b300c 	sub	r3, fp, #12
    86d8:	e24b2008 	sub	r2, fp, #8
    86dc:	e51b1014 	ldr	r1, [fp, #-20]	; 0xffffffec
    86e0:	e51b0010 	ldr	r0, [fp, #-16]
    86e4:	ebffff45 	bl	8400 <_ZNK13CGPIO_Handler18Get_GPCLR_LocationEjRjS0_>
    86e8:	e1a03000 	mov	r3, r0
    86ec:	e2233001 	eor	r3, r3, #1
    86f0:	e6ef3073 	uxtb	r3, r3
    86f4:	e3530000 	cmp	r3, #0
    86f8:	0a000001 	beq	8704 <_ZN13CGPIO_Handler10Set_OutputEjb+0x94>
/home/cf/ZCU/OS/practical/ex3/original/kernel/src/drivers/gpio.cpp:87 (discriminator 7)
    86fc:	e3a03001 	mov	r3, #1
    8700:	ea000000 	b	8708 <_ZN13CGPIO_Handler10Set_OutputEjb+0x98>
/home/cf/ZCU/OS/practical/ex3/original/kernel/src/drivers/gpio.cpp:87 (discriminator 8)
    8704:	e3a03000 	mov	r3, #0
/home/cf/ZCU/OS/practical/ex3/original/kernel/src/drivers/gpio.cpp:87 (discriminator 10)
    8708:	e3530000 	cmp	r3, #0
    870c:	1a00000a 	bne	873c <_ZN13CGPIO_Handler10Set_OutputEjb+0xcc>
/home/cf/ZCU/OS/practical/ex3/original/kernel/src/drivers/gpio.cpp:90
		return;
	
	mGPIO[reg] = (1 << bit);
    8710:	e51b300c 	ldr	r3, [fp, #-12]
    8714:	e3a02001 	mov	r2, #1
    8718:	e1a01312 	lsl	r1, r2, r3
    871c:	e51b3010 	ldr	r3, [fp, #-16]
    8720:	e5932000 	ldr	r2, [r3]
    8724:	e51b3008 	ldr	r3, [fp, #-8]
    8728:	e1a03103 	lsl	r3, r3, #2
    872c:	e0823003 	add	r3, r2, r3
    8730:	e1a02001 	mov	r2, r1
    8734:	e5832000 	str	r2, [r3]
    8738:	ea000000 	b	8740 <_ZN13CGPIO_Handler10Set_OutputEjb+0xd0>
/home/cf/ZCU/OS/practical/ex3/original/kernel/src/drivers/gpio.cpp:88
		return;
    873c:	e320f000 	nop	{0}
/home/cf/ZCU/OS/practical/ex3/original/kernel/src/drivers/gpio.cpp:91
}
    8740:	e24bd004 	sub	sp, fp, #4
    8744:	e8bd8800 	pop	{fp, pc}

00008748 <_Z41__static_initialization_and_destruction_0ii>:
_Z41__static_initialization_and_destruction_0ii():
/home/cf/ZCU/OS/practical/ex3/original/kernel/src/drivers/gpio.cpp:91
    8748:	e92d4800 	push	{fp, lr}
    874c:	e28db004 	add	fp, sp, #4
    8750:	e24dd008 	sub	sp, sp, #8
    8754:	e50b0008 	str	r0, [fp, #-8]
    8758:	e50b100c 	str	r1, [fp, #-12]
    875c:	e51b3008 	ldr	r3, [fp, #-8]
    8760:	e3530001 	cmp	r3, #1
    8764:	1a000006 	bne	8784 <_Z41__static_initialization_and_destruction_0ii+0x3c>
/home/cf/ZCU/OS/practical/ex3/original/kernel/src/drivers/gpio.cpp:91 (discriminator 1)
    8768:	e51b300c 	ldr	r3, [fp, #-12]
    876c:	e59f201c 	ldr	r2, [pc, #28]	; 8790 <_Z41__static_initialization_and_destruction_0ii+0x48>
    8770:	e1530002 	cmp	r3, r2
    8774:	1a000002 	bne	8784 <_Z41__static_initialization_and_destruction_0ii+0x3c>
/home/cf/ZCU/OS/practical/ex3/original/kernel/src/drivers/gpio.cpp:4
CGPIO_Handler sGPIO(hal::GPIO_Base);
    8778:	e59f1014 	ldr	r1, [pc, #20]	; 8794 <_Z41__static_initialization_and_destruction_0ii+0x4c>
    877c:	e59f0014 	ldr	r0, [pc, #20]	; 8798 <_Z41__static_initialization_and_destruction_0ii+0x50>
    8780:	ebfffecc 	bl	82b8 <_ZN13CGPIO_HandlerC1Ej>
/home/cf/ZCU/OS/practical/ex3/original/kernel/src/drivers/gpio.cpp:91
}
    8784:	e320f000 	nop	{0}
    8788:	e24bd004 	sub	sp, fp, #4
    878c:	e8bd8800 	pop	{fp, pc}
    8790:	0000ffff 	strdeq	pc, [r0], -pc	; <UNPREDICTABLE>
    8794:	20200000 	eorcs	r0, r0, r0
    8798:	00008ff4 	strdeq	r8, [r0], -r4

0000879c <_GLOBAL__sub_I_sGPIO>:
_GLOBAL__sub_I_sGPIO():
/home/cf/ZCU/OS/practical/ex3/original/kernel/src/drivers/gpio.cpp:91
    879c:	e92d4800 	push	{fp, lr}
    87a0:	e28db004 	add	fp, sp, #4
    87a4:	e59f1008 	ldr	r1, [pc, #8]	; 87b4 <_GLOBAL__sub_I_sGPIO+0x18>
    87a8:	e3a00001 	mov	r0, #1
    87ac:	ebffffe5 	bl	8748 <_Z41__static_initialization_and_destruction_0ii>
    87b0:	e8bd8800 	pop	{fp, pc}
    87b4:	0000ffff 	strdeq	pc, [r0], -pc	; <UNPREDICTABLE>

000087b8 <_ZN5CUARTC1ER4CAUX>:
_ZN5CUARTC2ER4CAUX():
/home/cf/ZCU/OS/practical/ex3/original/kernel/src/drivers/uart.cpp:6
#include <drivers/uart.h>
#include <drivers/bcm_aux.h>

CUART sUART0(sAUX);

CUART::CUART(CAUX& aux)
    87b8:	e92d4800 	push	{fp, lr}
    87bc:	e28db004 	add	fp, sp, #4
    87c0:	e24dd008 	sub	sp, sp, #8
    87c4:	e50b0008 	str	r0, [fp, #-8]
    87c8:	e50b100c 	str	r1, [fp, #-12]
/home/cf/ZCU/OS/practical/ex3/original/kernel/src/drivers/uart.cpp:7
    : mAUX(aux)
    87cc:	e51b3008 	ldr	r3, [fp, #-8]
    87d0:	e51b200c 	ldr	r2, [fp, #-12]
    87d4:	e5832000 	str	r2, [r3]
/home/cf/ZCU/OS/practical/ex3/original/kernel/src/drivers/uart.cpp:9
{
    mAUX.Enable(hal::AUX_Peripherals::MiniUART);
    87d8:	e51b3008 	ldr	r3, [fp, #-8]
    87dc:	e5933000 	ldr	r3, [r3]
    87e0:	e3a01000 	mov	r1, #0
    87e4:	e1a00003 	mov	r0, r3
    87e8:	ebfffe4d 	bl	8124 <_ZN4CAUX6EnableEN3hal15AUX_PeripheralsE>
/home/cf/ZCU/OS/practical/ex3/original/kernel/src/drivers/uart.cpp:11
    //mAUX.Set_Register(hal::AUX_Reg::ENABLES, mAUX.Get_Register(hal::AUX_Reg::ENABLES) | 0x01);
    mAUX.Set_Register(hal::AUX_Reg::MU_IIR, 0);
    87ec:	e51b3008 	ldr	r3, [fp, #-8]
    87f0:	e5933000 	ldr	r3, [r3]
    87f4:	e3a02000 	mov	r2, #0
    87f8:	e3a01012 	mov	r1, #18
    87fc:	e1a00003 	mov	r0, r3
    8800:	ebfffe70 	bl	81c8 <_ZN4CAUX12Set_RegisterEN3hal7AUX_RegEj>
/home/cf/ZCU/OS/practical/ex3/original/kernel/src/drivers/uart.cpp:12
    mAUX.Set_Register(hal::AUX_Reg::MU_IER, 0);
    8804:	e51b3008 	ldr	r3, [fp, #-8]
    8808:	e5933000 	ldr	r3, [r3]
    880c:	e3a02000 	mov	r2, #0
    8810:	e3a01011 	mov	r1, #17
    8814:	e1a00003 	mov	r0, r3
    8818:	ebfffe6a 	bl	81c8 <_ZN4CAUX12Set_RegisterEN3hal7AUX_RegEj>
/home/cf/ZCU/OS/practical/ex3/original/kernel/src/drivers/uart.cpp:13
    mAUX.Set_Register(hal::AUX_Reg::MU_MCR, 0);
    881c:	e51b3008 	ldr	r3, [fp, #-8]
    8820:	e5933000 	ldr	r3, [r3]
    8824:	e3a02000 	mov	r2, #0
    8828:	e3a01014 	mov	r1, #20
    882c:	e1a00003 	mov	r0, r3
    8830:	ebfffe64 	bl	81c8 <_ZN4CAUX12Set_RegisterEN3hal7AUX_RegEj>
/home/cf/ZCU/OS/practical/ex3/original/kernel/src/drivers/uart.cpp:14
    mAUX.Set_Register(hal::AUX_Reg::MU_CNTL, 3); // RX and TX enabled
    8834:	e51b3008 	ldr	r3, [fp, #-8]
    8838:	e5933000 	ldr	r3, [r3]
    883c:	e3a02003 	mov	r2, #3
    8840:	e3a01018 	mov	r1, #24
    8844:	e1a00003 	mov	r0, r3
    8848:	ebfffe5e 	bl	81c8 <_ZN4CAUX12Set_RegisterEN3hal7AUX_RegEj>
/home/cf/ZCU/OS/practical/ex3/original/kernel/src/drivers/uart.cpp:15
}
    884c:	e51b3008 	ldr	r3, [fp, #-8]
    8850:	e1a00003 	mov	r0, r3
    8854:	e24bd004 	sub	sp, fp, #4
    8858:	e8bd8800 	pop	{fp, pc}

0000885c <_ZN5CUART15Set_Char_LengthE17NUART_Char_Length>:
_ZN5CUART15Set_Char_LengthE17NUART_Char_Length():
/home/cf/ZCU/OS/practical/ex3/original/kernel/src/drivers/uart.cpp:18

void CUART::Set_Char_Length(NUART_Char_Length len)
{
    885c:	e92d4810 	push	{r4, fp, lr}
    8860:	e28db008 	add	fp, sp, #8
    8864:	e24dd00c 	sub	sp, sp, #12
    8868:	e50b0010 	str	r0, [fp, #-16]
    886c:	e50b1014 	str	r1, [fp, #-20]	; 0xffffffec
/home/cf/ZCU/OS/practical/ex3/original/kernel/src/drivers/uart.cpp:19
    mAUX.Set_Register(hal::AUX_Reg::MU_LCR, (mAUX.Get_Register(hal::AUX_Reg::MU_LCR) & 0xFFFFFFFE) | static_cast<unsigned int>(len));
    8870:	e51b3010 	ldr	r3, [fp, #-16]
    8874:	e5934000 	ldr	r4, [r3]
    8878:	e51b3010 	ldr	r3, [fp, #-16]
    887c:	e5933000 	ldr	r3, [r3]
    8880:	e3a01013 	mov	r1, #19
    8884:	e1a00003 	mov	r0, r3
    8888:	ebfffe5f 	bl	820c <_ZN4CAUX12Get_RegisterEN3hal7AUX_RegE>
    888c:	e1a03000 	mov	r3, r0
    8890:	e3c32001 	bic	r2, r3, #1
    8894:	e51b3014 	ldr	r3, [fp, #-20]	; 0xffffffec
    8898:	e1823003 	orr	r3, r2, r3
    889c:	e1a02003 	mov	r2, r3
    88a0:	e3a01013 	mov	r1, #19
    88a4:	e1a00004 	mov	r0, r4
    88a8:	ebfffe46 	bl	81c8 <_ZN4CAUX12Set_RegisterEN3hal7AUX_RegEj>
/home/cf/ZCU/OS/practical/ex3/original/kernel/src/drivers/uart.cpp:20
}
    88ac:	e320f000 	nop	{0}
    88b0:	e24bd008 	sub	sp, fp, #8
    88b4:	e8bd8810 	pop	{r4, fp, pc}

000088b8 <_ZN5CUART13Set_Baud_RateE15NUART_Baud_Rate>:
_ZN5CUART13Set_Baud_RateE15NUART_Baud_Rate():
/home/cf/ZCU/OS/practical/ex3/original/kernel/src/drivers/uart.cpp:23

void CUART::Set_Baud_Rate(NUART_Baud_Rate rate)
{
    88b8:	e92d4800 	push	{fp, lr}
    88bc:	e28db004 	add	fp, sp, #4
    88c0:	e24dd010 	sub	sp, sp, #16
    88c4:	e50b0010 	str	r0, [fp, #-16]
    88c8:	e50b1014 	str	r1, [fp, #-20]	; 0xffffffec
/home/cf/ZCU/OS/practical/ex3/original/kernel/src/drivers/uart.cpp:24
    constexpr unsigned int Clock_Rate = 250000000; // taktovaci frekvence hlavniho jadra
    88cc:	e59f3070 	ldr	r3, [pc, #112]	; 8944 <_ZN5CUART13Set_Baud_RateE15NUART_Baud_Rate+0x8c>
    88d0:	e50b3008 	str	r3, [fp, #-8]
/home/cf/ZCU/OS/practical/ex3/original/kernel/src/drivers/uart.cpp:25
    const unsigned int val = ((Clock_Rate / static_cast<unsigned int>(rate)) / 8) - 1;
    88d4:	e51b3014 	ldr	r3, [fp, #-20]	; 0xffffffec
    88d8:	e1a01003 	mov	r1, r3
    88dc:	e59f0064 	ldr	r0, [pc, #100]	; 8948 <_ZN5CUART13Set_Baud_RateE15NUART_Baud_Rate+0x90>
    88e0:	eb0000f1 	bl	8cac <__udivsi3>
    88e4:	e1a03000 	mov	r3, r0
    88e8:	e2433001 	sub	r3, r3, #1
    88ec:	e50b300c 	str	r3, [fp, #-12]
/home/cf/ZCU/OS/practical/ex3/original/kernel/src/drivers/uart.cpp:27

    mAUX.Set_Register(hal::AUX_Reg::MU_CNTL, 0);
    88f0:	e51b3010 	ldr	r3, [fp, #-16]
    88f4:	e5933000 	ldr	r3, [r3]
    88f8:	e3a02000 	mov	r2, #0
    88fc:	e3a01018 	mov	r1, #24
    8900:	e1a00003 	mov	r0, r3
    8904:	ebfffe2f 	bl	81c8 <_ZN4CAUX12Set_RegisterEN3hal7AUX_RegEj>
/home/cf/ZCU/OS/practical/ex3/original/kernel/src/drivers/uart.cpp:29

    mAUX.Set_Register(hal::AUX_Reg::MU_BAUD, val);
    8908:	e51b3010 	ldr	r3, [fp, #-16]
    890c:	e5933000 	ldr	r3, [r3]
    8910:	e51b200c 	ldr	r2, [fp, #-12]
    8914:	e3a0101a 	mov	r1, #26
    8918:	e1a00003 	mov	r0, r3
    891c:	ebfffe29 	bl	81c8 <_ZN4CAUX12Set_RegisterEN3hal7AUX_RegEj>
/home/cf/ZCU/OS/practical/ex3/original/kernel/src/drivers/uart.cpp:31

    mAUX.Set_Register(hal::AUX_Reg::MU_CNTL, 3);
    8920:	e51b3010 	ldr	r3, [fp, #-16]
    8924:	e5933000 	ldr	r3, [r3]
    8928:	e3a02003 	mov	r2, #3
    892c:	e3a01018 	mov	r1, #24
    8930:	e1a00003 	mov	r0, r3
    8934:	ebfffe23 	bl	81c8 <_ZN4CAUX12Set_RegisterEN3hal7AUX_RegEj>
/home/cf/ZCU/OS/practical/ex3/original/kernel/src/drivers/uart.cpp:32
}
    8938:	e320f000 	nop	{0}
    893c:	e24bd004 	sub	sp, fp, #4
    8940:	e8bd8800 	pop	{fp, pc}
    8944:	0ee6b280 	cdpeq	2, 14, cr11, cr6, cr0, {4}
    8948:	01dcd650 	bicseq	sp, ip, r0, asr r6

0000894c <_ZN5CUART5WriteEc>:
_ZN5CUART5WriteEc():
/home/cf/ZCU/OS/practical/ex3/original/kernel/src/drivers/uart.cpp:35

void CUART::Write(char c)
{
    894c:	e92d4800 	push	{fp, lr}
    8950:	e28db004 	add	fp, sp, #4
    8954:	e24dd008 	sub	sp, sp, #8
    8958:	e50b0008 	str	r0, [fp, #-8]
    895c:	e1a03001 	mov	r3, r1
    8960:	e54b3009 	strb	r3, [fp, #-9]
/home/cf/ZCU/OS/practical/ex3/original/kernel/src/drivers/uart.cpp:37
    // dokud ma status registr priznak "vystupni fronta plna", nelze prenaset dalsi bit
    while (!(mAUX.Get_Register(hal::AUX_Reg::MU_LSR) & (1 << 5)))
    8964:	e320f000 	nop	{0}
/home/cf/ZCU/OS/practical/ex3/original/kernel/src/drivers/uart.cpp:37 (discriminator 1)
    8968:	e51b3008 	ldr	r3, [fp, #-8]
    896c:	e5933000 	ldr	r3, [r3]
    8970:	e3a01015 	mov	r1, #21
    8974:	e1a00003 	mov	r0, r3
    8978:	ebfffe23 	bl	820c <_ZN4CAUX12Get_RegisterEN3hal7AUX_RegE>
    897c:	e1a03000 	mov	r3, r0
    8980:	e2033020 	and	r3, r3, #32
    8984:	e3530000 	cmp	r3, #0
    8988:	03a03001 	moveq	r3, #1
    898c:	13a03000 	movne	r3, #0
    8990:	e6ef3073 	uxtb	r3, r3
    8994:	e3530000 	cmp	r3, #0
    8998:	1afffff2 	bne	8968 <_ZN5CUART5WriteEc+0x1c>
/home/cf/ZCU/OS/practical/ex3/original/kernel/src/drivers/uart.cpp:40
        ;

    mAUX.Set_Register(hal::AUX_Reg::MU_IO, c);
    899c:	e51b3008 	ldr	r3, [fp, #-8]
    89a0:	e5933000 	ldr	r3, [r3]
    89a4:	e55b2009 	ldrb	r2, [fp, #-9]
    89a8:	e3a01010 	mov	r1, #16
    89ac:	e1a00003 	mov	r0, r3
    89b0:	ebfffe04 	bl	81c8 <_ZN4CAUX12Set_RegisterEN3hal7AUX_RegEj>
/home/cf/ZCU/OS/practical/ex3/original/kernel/src/drivers/uart.cpp:41
}
    89b4:	e320f000 	nop	{0}
    89b8:	e24bd004 	sub	sp, fp, #4
    89bc:	e8bd8800 	pop	{fp, pc}

000089c0 <_ZN5CUART5WriteEPKc>:
_ZN5CUART5WriteEPKc():
/home/cf/ZCU/OS/practical/ex3/original/kernel/src/drivers/uart.cpp:44

void CUART::Write(const char* str)
{
    89c0:	e92d4800 	push	{fp, lr}
    89c4:	e28db004 	add	fp, sp, #4
    89c8:	e24dd010 	sub	sp, sp, #16
    89cc:	e50b0010 	str	r0, [fp, #-16]
    89d0:	e50b1014 	str	r1, [fp, #-20]	; 0xffffffec
/home/cf/ZCU/OS/practical/ex3/original/kernel/src/drivers/uart.cpp:47
    int i;

    for (i = 0; str[i] != '\0'; i++)
    89d4:	e3a03000 	mov	r3, #0
    89d8:	e50b3008 	str	r3, [fp, #-8]
    89dc:	ea000009 	b	8a08 <_ZN5CUART5WriteEPKc+0x48>
/home/cf/ZCU/OS/practical/ex3/original/kernel/src/drivers/uart.cpp:48 (discriminator 3)
        Write(str[i]);
    89e0:	e51b3008 	ldr	r3, [fp, #-8]
    89e4:	e51b2014 	ldr	r2, [fp, #-20]	; 0xffffffec
    89e8:	e0823003 	add	r3, r2, r3
    89ec:	e5d33000 	ldrb	r3, [r3]
    89f0:	e1a01003 	mov	r1, r3
    89f4:	e51b0010 	ldr	r0, [fp, #-16]
    89f8:	ebffffd3 	bl	894c <_ZN5CUART5WriteEc>
/home/cf/ZCU/OS/practical/ex3/original/kernel/src/drivers/uart.cpp:47 (discriminator 3)
    for (i = 0; str[i] != '\0'; i++)
    89fc:	e51b3008 	ldr	r3, [fp, #-8]
    8a00:	e2833001 	add	r3, r3, #1
    8a04:	e50b3008 	str	r3, [fp, #-8]
/home/cf/ZCU/OS/practical/ex3/original/kernel/src/drivers/uart.cpp:47 (discriminator 1)
    8a08:	e51b3008 	ldr	r3, [fp, #-8]
    8a0c:	e51b2014 	ldr	r2, [fp, #-20]	; 0xffffffec
    8a10:	e0823003 	add	r3, r2, r3
    8a14:	e5d33000 	ldrb	r3, [r3]
    8a18:	e3530000 	cmp	r3, #0
    8a1c:	1affffef 	bne	89e0 <_ZN5CUART5WriteEPKc+0x20>
/home/cf/ZCU/OS/practical/ex3/original/kernel/src/drivers/uart.cpp:49
    8a20:	e320f000 	nop	{0}
    8a24:	e320f000 	nop	{0}
    8a28:	e24bd004 	sub	sp, fp, #4
    8a2c:	e8bd8800 	pop	{fp, pc}

00008a30 <_Z41__static_initialization_and_destruction_0ii>:
_Z41__static_initialization_and_destruction_0ii():
/home/cf/ZCU/OS/practical/ex3/original/kernel/src/drivers/uart.cpp:49
    8a30:	e92d4800 	push	{fp, lr}
    8a34:	e28db004 	add	fp, sp, #4
    8a38:	e24dd008 	sub	sp, sp, #8
    8a3c:	e50b0008 	str	r0, [fp, #-8]
    8a40:	e50b100c 	str	r1, [fp, #-12]
    8a44:	e51b3008 	ldr	r3, [fp, #-8]
    8a48:	e3530001 	cmp	r3, #1
    8a4c:	1a000006 	bne	8a6c <_Z41__static_initialization_and_destruction_0ii+0x3c>
/home/cf/ZCU/OS/practical/ex3/original/kernel/src/drivers/uart.cpp:49 (discriminator 1)
    8a50:	e51b300c 	ldr	r3, [fp, #-12]
    8a54:	e59f201c 	ldr	r2, [pc, #28]	; 8a78 <_Z41__static_initialization_and_destruction_0ii+0x48>
    8a58:	e1530002 	cmp	r3, r2
    8a5c:	1a000002 	bne	8a6c <_Z41__static_initialization_and_destruction_0ii+0x3c>
/home/cf/ZCU/OS/practical/ex3/original/kernel/src/drivers/uart.cpp:4
CUART sUART0(sAUX);
    8a60:	e59f1014 	ldr	r1, [pc, #20]	; 8a7c <_Z41__static_initialization_and_destruction_0ii+0x4c>
    8a64:	e59f0014 	ldr	r0, [pc, #20]	; 8a80 <_Z41__static_initialization_and_destruction_0ii+0x50>
    8a68:	ebffff52 	bl	87b8 <_ZN5CUARTC1ER4CAUX>
/home/cf/ZCU/OS/practical/ex3/original/kernel/src/drivers/uart.cpp:49
    8a6c:	e320f000 	nop	{0}
    8a70:	e24bd004 	sub	sp, fp, #4
    8a74:	e8bd8800 	pop	{fp, pc}
    8a78:	0000ffff 	strdeq	pc, [r0], -pc	; <UNPREDICTABLE>
    8a7c:	00008ff0 	strdeq	r8, [r0], -r0
    8a80:	00008ff8 	strdeq	r8, [r0], -r8	; <UNPREDICTABLE>

00008a84 <_GLOBAL__sub_I_sUART0>:
_GLOBAL__sub_I_sUART0():
/home/cf/ZCU/OS/practical/ex3/original/kernel/src/drivers/uart.cpp:49
    8a84:	e92d4800 	push	{fp, lr}
    8a88:	e28db004 	add	fp, sp, #4
    8a8c:	e59f1008 	ldr	r1, [pc, #8]	; 8a9c <_GLOBAL__sub_I_sUART0+0x18>
    8a90:	e3a00001 	mov	r0, #1
    8a94:	ebffffe5 	bl	8a30 <_Z41__static_initialization_and_destruction_0ii>
    8a98:	e8bd8800 	pop	{fp, pc}
    8a9c:	0000ffff 	strdeq	pc, [r0], -pc	; <UNPREDICTABLE>

00008aa0 <_kernel_main>:
_kernel_main():
/home/cf/ZCU/OS/practical/ex3/original/kernel/src/main.cpp:8

// GPIO pin 47 je pripojeny na LED na desce (tzv. ACT LED)
constexpr uint32_t ACT_Pin = 47;

extern "C" int _kernel_main(void)
{
    8aa0:	e92d4800 	push	{fp, lr}
    8aa4:	e28db004 	add	fp, sp, #4
    8aa8:	e24dd008 	sub	sp, sp, #8
/home/cf/ZCU/OS/practical/ex3/original/kernel/src/main.cpp:10
	// nastavime ACT LED pin na vystupni
	sGPIO.Set_GPIO_Function(ACT_Pin, NGPIO_Function::Output);
    8aac:	e3a02001 	mov	r2, #1
    8ab0:	e3a0102f 	mov	r1, #47	; 0x2f
    8ab4:	e59f00c4 	ldr	r0, [pc, #196]	; 8b80 <_kernel_main+0xe0>
    8ab8:	ebfffea7 	bl	855c <_ZN13CGPIO_Handler17Set_GPIO_FunctionEj14NGPIO_Function>
/home/cf/ZCU/OS/practical/ex3/original/kernel/src/main.cpp:13

	// inicializujeme UART kanal 0
	sUART0.Set_Baud_Rate(NUART_Baud_Rate::BR_115200);
    8abc:	e59f10c0 	ldr	r1, [pc, #192]	; 8b84 <_kernel_main+0xe4>
    8ac0:	e59f00c0 	ldr	r0, [pc, #192]	; 8b88 <_kernel_main+0xe8>
    8ac4:	ebffff7b 	bl	88b8 <_ZN5CUART13Set_Baud_RateE15NUART_Baud_Rate>
/home/cf/ZCU/OS/practical/ex3/original/kernel/src/main.cpp:14
	sUART0.Set_Char_Length(NUART_Char_Length::Char_8);
    8ac8:	e3a01001 	mov	r1, #1
    8acc:	e59f00b4 	ldr	r0, [pc, #180]	; 8b88 <_kernel_main+0xe8>
    8ad0:	ebffff61 	bl	885c <_ZN5CUART15Set_Char_LengthE17NUART_Char_Length>
/home/cf/ZCU/OS/practical/ex3/original/kernel/src/main.cpp:17

	// vypiseme ladici hlasku
	sUART0.Write("Welcome to KIV/OS RPiOS kernel\r\n");
    8ad4:	e59f10b0 	ldr	r1, [pc, #176]	; 8b8c <_kernel_main+0xec>
    8ad8:	e59f00a8 	ldr	r0, [pc, #168]	; 8b88 <_kernel_main+0xe8>
    8adc:	ebffffb7 	bl	89c0 <_ZN5CUART5WriteEPKc>
/home/cf/ZCU/OS/practical/ex3/original/kernel/src/main.cpp:24
	volatile unsigned int tim;
	
    while (1)
    {
		// spalime 500000 taktu (cekani par milisekund)
        for(tim = 0; tim < 500000; tim++)
    8ae0:	e3a03000 	mov	r3, #0
    8ae4:	e50b3008 	str	r3, [fp, #-8]
    8ae8:	ea000002 	b	8af8 <_kernel_main+0x58>
/home/cf/ZCU/OS/practical/ex3/original/kernel/src/main.cpp:24 (discriminator 3)
    8aec:	e51b3008 	ldr	r3, [fp, #-8]
    8af0:	e2833001 	add	r3, r3, #1
    8af4:	e50b3008 	str	r3, [fp, #-8]
/home/cf/ZCU/OS/practical/ex3/original/kernel/src/main.cpp:24 (discriminator 1)
    8af8:	e51b3008 	ldr	r3, [fp, #-8]
    8afc:	e59f208c 	ldr	r2, [pc, #140]	; 8b90 <_kernel_main+0xf0>
    8b00:	e1530002 	cmp	r3, r2
    8b04:	33a03001 	movcc	r3, #1
    8b08:	23a03000 	movcs	r3, #0
    8b0c:	e6ef3073 	uxtb	r3, r3
    8b10:	e3530000 	cmp	r3, #0
    8b14:	1afffff4 	bne	8aec <_kernel_main+0x4c>
/home/cf/ZCU/OS/practical/ex3/original/kernel/src/main.cpp:28
            ;
		
		// zhasneme LED
		sGPIO.Set_Output(ACT_Pin, true);
    8b18:	e3a02001 	mov	r2, #1
    8b1c:	e3a0102f 	mov	r1, #47	; 0x2f
    8b20:	e59f0058 	ldr	r0, [pc, #88]	; 8b80 <_kernel_main+0xe0>
    8b24:	ebfffed1 	bl	8670 <_ZN13CGPIO_Handler10Set_OutputEjb>
/home/cf/ZCU/OS/practical/ex3/original/kernel/src/main.cpp:31

		// vypis neceho na UART
		sUART0.Write('A');
    8b28:	e3a01041 	mov	r1, #65	; 0x41
    8b2c:	e59f0054 	ldr	r0, [pc, #84]	; 8b88 <_kernel_main+0xe8>
    8b30:	ebffff85 	bl	894c <_ZN5CUART5WriteEc>
/home/cf/ZCU/OS/practical/ex3/original/kernel/src/main.cpp:34

		// opet cekani
        for(tim = 0; tim < 500000; tim++)
    8b34:	e3a03000 	mov	r3, #0
    8b38:	e50b3008 	str	r3, [fp, #-8]
    8b3c:	ea000002 	b	8b4c <_kernel_main+0xac>
/home/cf/ZCU/OS/practical/ex3/original/kernel/src/main.cpp:34 (discriminator 3)
    8b40:	e51b3008 	ldr	r3, [fp, #-8]
    8b44:	e2833001 	add	r3, r3, #1
    8b48:	e50b3008 	str	r3, [fp, #-8]
/home/cf/ZCU/OS/practical/ex3/original/kernel/src/main.cpp:34 (discriminator 1)
    8b4c:	e51b3008 	ldr	r3, [fp, #-8]
    8b50:	e59f2038 	ldr	r2, [pc, #56]	; 8b90 <_kernel_main+0xf0>
    8b54:	e1530002 	cmp	r3, r2
    8b58:	33a03001 	movcc	r3, #1
    8b5c:	23a03000 	movcs	r3, #0
    8b60:	e6ef3073 	uxtb	r3, r3
    8b64:	e3530000 	cmp	r3, #0
    8b68:	1afffff4 	bne	8b40 <_kernel_main+0xa0>
/home/cf/ZCU/OS/practical/ex3/original/kernel/src/main.cpp:38
            ;

		// rozsvitime LED
		sGPIO.Set_Output(ACT_Pin, false);
    8b6c:	e3a02000 	mov	r2, #0
    8b70:	e3a0102f 	mov	r1, #47	; 0x2f
    8b74:	e59f0004 	ldr	r0, [pc, #4]	; 8b80 <_kernel_main+0xe0>
    8b78:	ebfffebc 	bl	8670 <_ZN13CGPIO_Handler10Set_OutputEjb>
/home/cf/ZCU/OS/practical/ex3/original/kernel/src/main.cpp:24
        for(tim = 0; tim < 500000; tim++)
    8b7c:	eaffffd7 	b	8ae0 <_kernel_main+0x40>
    8b80:	00008ff4 	strdeq	r8, [r0], -r4
    8b84:	0001c200 	andeq	ip, r1, r0, lsl #4
    8b88:	00008ff8 	strdeq	r8, [r0], -r8	; <UNPREDICTABLE>
    8b8c:	00008fc0 	andeq	r8, r0, r0, asr #31
    8b90:	0007a120 	andeq	sl, r7, r0, lsr #2

00008b94 <_c_startup>:
_c_startup():
/home/cf/ZCU/OS/practical/ex3/original/kernel/src/startup.cpp:21
extern "C" dtor_ptr __DTOR_LIST__[0];
// konec pole destruktoru
extern "C" dtor_ptr __DTOR_END__[0];

extern "C" int _c_startup(void)
{
    8b94:	e52db004 	push	{fp}		; (str fp, [sp, #-4]!)
    8b98:	e28db000 	add	fp, sp, #0
    8b9c:	e24dd00c 	sub	sp, sp, #12
/home/cf/ZCU/OS/practical/ex3/original/kernel/src/startup.cpp:25
	int* i;
	
	// vynulujeme .bss sekci
	for (i = (int*)_bss_start; i < (int*)_bss_end; i++)
    8ba0:	e59f304c 	ldr	r3, [pc, #76]	; 8bf4 <_c_startup+0x60>
    8ba4:	e5933000 	ldr	r3, [r3]
    8ba8:	e50b3008 	str	r3, [fp, #-8]
    8bac:	ea000005 	b	8bc8 <_c_startup+0x34>
/home/cf/ZCU/OS/practical/ex3/original/kernel/src/startup.cpp:26 (discriminator 3)
		*i = 0;
    8bb0:	e51b3008 	ldr	r3, [fp, #-8]
    8bb4:	e3a02000 	mov	r2, #0
    8bb8:	e5832000 	str	r2, [r3]
/home/cf/ZCU/OS/practical/ex3/original/kernel/src/startup.cpp:25 (discriminator 3)
	for (i = (int*)_bss_start; i < (int*)_bss_end; i++)
    8bbc:	e51b3008 	ldr	r3, [fp, #-8]
    8bc0:	e2833004 	add	r3, r3, #4
    8bc4:	e50b3008 	str	r3, [fp, #-8]
/home/cf/ZCU/OS/practical/ex3/original/kernel/src/startup.cpp:25 (discriminator 1)
    8bc8:	e59f3028 	ldr	r3, [pc, #40]	; 8bf8 <_c_startup+0x64>
    8bcc:	e5933000 	ldr	r3, [r3]
    8bd0:	e1a02003 	mov	r2, r3
    8bd4:	e51b3008 	ldr	r3, [fp, #-8]
    8bd8:	e1530002 	cmp	r3, r2
    8bdc:	3afffff3 	bcc	8bb0 <_c_startup+0x1c>
/home/cf/ZCU/OS/practical/ex3/original/kernel/src/startup.cpp:28
	
	return 0;
    8be0:	e3a03000 	mov	r3, #0
/home/cf/ZCU/OS/practical/ex3/original/kernel/src/startup.cpp:29
}
    8be4:	e1a00003 	mov	r0, r3
    8be8:	e28bd000 	add	sp, fp, #0
    8bec:	e49db004 	pop	{fp}		; (ldr fp, [sp], #4)
    8bf0:	e12fff1e 	bx	lr
    8bf4:	00008ff0 	strdeq	r8, [r0], -r0
    8bf8:	0000900c 	andeq	r9, r0, ip

00008bfc <_cpp_startup>:
_cpp_startup():
/home/cf/ZCU/OS/practical/ex3/original/kernel/src/startup.cpp:32

extern "C" int _cpp_startup(void)
{
    8bfc:	e92d4800 	push	{fp, lr}
    8c00:	e28db004 	add	fp, sp, #4
    8c04:	e24dd008 	sub	sp, sp, #8
/home/cf/ZCU/OS/practical/ex3/original/kernel/src/startup.cpp:37
	ctor_ptr* fnptr;
	
	// zavolame konstruktory globalnich C++ trid
	// v poli __CTOR_LIST__ jsou ukazatele na vygenerovane stuby volani konstruktoru
	for (fnptr = __CTOR_LIST__; fnptr < __CTOR_END__; fnptr++)
    8c08:	e59f303c 	ldr	r3, [pc, #60]	; 8c4c <_cpp_startup+0x50>
    8c0c:	e50b3008 	str	r3, [fp, #-8]
    8c10:	ea000005 	b	8c2c <_cpp_startup+0x30>
/home/cf/ZCU/OS/practical/ex3/original/kernel/src/startup.cpp:38 (discriminator 3)
		(*fnptr)();
    8c14:	e51b3008 	ldr	r3, [fp, #-8]
    8c18:	e5933000 	ldr	r3, [r3]
    8c1c:	e12fff33 	blx	r3
/home/cf/ZCU/OS/practical/ex3/original/kernel/src/startup.cpp:37 (discriminator 3)
	for (fnptr = __CTOR_LIST__; fnptr < __CTOR_END__; fnptr++)
    8c20:	e51b3008 	ldr	r3, [fp, #-8]
    8c24:	e2833004 	add	r3, r3, #4
    8c28:	e50b3008 	str	r3, [fp, #-8]
/home/cf/ZCU/OS/practical/ex3/original/kernel/src/startup.cpp:37 (discriminator 1)
    8c2c:	e51b3008 	ldr	r3, [fp, #-8]
    8c30:	e59f2018 	ldr	r2, [pc, #24]	; 8c50 <_cpp_startup+0x54>
    8c34:	e1530002 	cmp	r3, r2
    8c38:	3afffff5 	bcc	8c14 <_cpp_startup+0x18>
/home/cf/ZCU/OS/practical/ex3/original/kernel/src/startup.cpp:40
	
	return 0;
    8c3c:	e3a03000 	mov	r3, #0
/home/cf/ZCU/OS/practical/ex3/original/kernel/src/startup.cpp:41
}
    8c40:	e1a00003 	mov	r0, r3
    8c44:	e24bd004 	sub	sp, fp, #4
    8c48:	e8bd8800 	pop	{fp, pc}
    8c4c:	00008fe4 	andeq	r8, r0, r4, ror #31
    8c50:	00008ff0 	strdeq	r8, [r0], -r0

00008c54 <_cpp_shutdown>:
_cpp_shutdown():
/home/cf/ZCU/OS/practical/ex3/original/kernel/src/startup.cpp:44

extern "C" int _cpp_shutdown(void)
{
    8c54:	e92d4800 	push	{fp, lr}
    8c58:	e28db004 	add	fp, sp, #4
    8c5c:	e24dd008 	sub	sp, sp, #8
/home/cf/ZCU/OS/practical/ex3/original/kernel/src/startup.cpp:48
	dtor_ptr* fnptr;
	
	// zavolame destruktory globalnich C++ trid
	for (fnptr = __DTOR_LIST__; fnptr < __DTOR_END__; fnptr++)
    8c60:	e59f303c 	ldr	r3, [pc, #60]	; 8ca4 <_cpp_shutdown+0x50>
    8c64:	e50b3008 	str	r3, [fp, #-8]
    8c68:	ea000005 	b	8c84 <_cpp_shutdown+0x30>
/home/cf/ZCU/OS/practical/ex3/original/kernel/src/startup.cpp:49 (discriminator 3)
		(*fnptr)();
    8c6c:	e51b3008 	ldr	r3, [fp, #-8]
    8c70:	e5933000 	ldr	r3, [r3]
    8c74:	e12fff33 	blx	r3
/home/cf/ZCU/OS/practical/ex3/original/kernel/src/startup.cpp:48 (discriminator 3)
	for (fnptr = __DTOR_LIST__; fnptr < __DTOR_END__; fnptr++)
    8c78:	e51b3008 	ldr	r3, [fp, #-8]
    8c7c:	e2833004 	add	r3, r3, #4
    8c80:	e50b3008 	str	r3, [fp, #-8]
/home/cf/ZCU/OS/practical/ex3/original/kernel/src/startup.cpp:48 (discriminator 1)
    8c84:	e51b3008 	ldr	r3, [fp, #-8]
    8c88:	e59f2018 	ldr	r2, [pc, #24]	; 8ca8 <_cpp_shutdown+0x54>
    8c8c:	e1530002 	cmp	r3, r2
    8c90:	3afffff5 	bcc	8c6c <_cpp_shutdown+0x18>
/home/cf/ZCU/OS/practical/ex3/original/kernel/src/startup.cpp:51
	
	return 0;
    8c94:	e3a03000 	mov	r3, #0
/home/cf/ZCU/OS/practical/ex3/original/kernel/src/startup.cpp:52
}
    8c98:	e1a00003 	mov	r0, r3
    8c9c:	e24bd004 	sub	sp, fp, #4
    8ca0:	e8bd8800 	pop	{fp, pc}
    8ca4:	00008ff0 	strdeq	r8, [r0], -r0
    8ca8:	00008ff0 	strdeq	r8, [r0], -r0

00008cac <__udivsi3>:
__udivsi3():
/builddir/build/BUILD/arm-none-eabi-gcc-cs-12.2.0/gcc-arm-none-eabi/arm-none-eabi/arm/v5te/hard/libgcc/../../../../../../gcc-12.2.0/libgcc/config/arm/lib1funcs.S:1104
    8cac:	e2512001 	subs	r2, r1, #1
/builddir/build/BUILD/arm-none-eabi-gcc-cs-12.2.0/gcc-arm-none-eabi/arm-none-eabi/arm/v5te/hard/libgcc/../../../../../../gcc-12.2.0/libgcc/config/arm/lib1funcs.S:1106
    8cb0:	012fff1e 	bxeq	lr
/builddir/build/BUILD/arm-none-eabi-gcc-cs-12.2.0/gcc-arm-none-eabi/arm-none-eabi/arm/v5te/hard/libgcc/../../../../../../gcc-12.2.0/libgcc/config/arm/lib1funcs.S:1107
    8cb4:	3a000074 	bcc	8e8c <__udivsi3+0x1e0>
/builddir/build/BUILD/arm-none-eabi-gcc-cs-12.2.0/gcc-arm-none-eabi/arm-none-eabi/arm/v5te/hard/libgcc/../../../../../../gcc-12.2.0/libgcc/config/arm/lib1funcs.S:1108
    8cb8:	e1500001 	cmp	r0, r1
/builddir/build/BUILD/arm-none-eabi-gcc-cs-12.2.0/gcc-arm-none-eabi/arm-none-eabi/arm/v5te/hard/libgcc/../../../../../../gcc-12.2.0/libgcc/config/arm/lib1funcs.S:1109
    8cbc:	9a00006b 	bls	8e70 <__udivsi3+0x1c4>
/builddir/build/BUILD/arm-none-eabi-gcc-cs-12.2.0/gcc-arm-none-eabi/arm-none-eabi/arm/v5te/hard/libgcc/../../../../../../gcc-12.2.0/libgcc/config/arm/lib1funcs.S:1110
    8cc0:	e1110002 	tst	r1, r2
/builddir/build/BUILD/arm-none-eabi-gcc-cs-12.2.0/gcc-arm-none-eabi/arm-none-eabi/arm/v5te/hard/libgcc/../../../../../../gcc-12.2.0/libgcc/config/arm/lib1funcs.S:1111
    8cc4:	0a00006c 	beq	8e7c <__udivsi3+0x1d0>
/builddir/build/BUILD/arm-none-eabi-gcc-cs-12.2.0/gcc-arm-none-eabi/arm-none-eabi/arm/v5te/hard/libgcc/../../../../../../gcc-12.2.0/libgcc/config/arm/lib1funcs.S:1113
    8cc8:	e16f3f10 	clz	r3, r0
    8ccc:	e16f2f11 	clz	r2, r1
    8cd0:	e0423003 	sub	r3, r2, r3
    8cd4:	e273301f 	rsbs	r3, r3, #31
    8cd8:	10833083 	addne	r3, r3, r3, lsl #1
    8cdc:	e3a02000 	mov	r2, #0
    8ce0:	108ff103 	addne	pc, pc, r3, lsl #2
    8ce4:	e1a00000 	nop			; (mov r0, r0)
    8ce8:	e1500f81 	cmp	r0, r1, lsl #31
    8cec:	e0a22002 	adc	r2, r2, r2
    8cf0:	20400f81 	subcs	r0, r0, r1, lsl #31
    8cf4:	e1500f01 	cmp	r0, r1, lsl #30
    8cf8:	e0a22002 	adc	r2, r2, r2
    8cfc:	20400f01 	subcs	r0, r0, r1, lsl #30
    8d00:	e1500e81 	cmp	r0, r1, lsl #29
    8d04:	e0a22002 	adc	r2, r2, r2
    8d08:	20400e81 	subcs	r0, r0, r1, lsl #29
    8d0c:	e1500e01 	cmp	r0, r1, lsl #28
    8d10:	e0a22002 	adc	r2, r2, r2
    8d14:	20400e01 	subcs	r0, r0, r1, lsl #28
    8d18:	e1500d81 	cmp	r0, r1, lsl #27
    8d1c:	e0a22002 	adc	r2, r2, r2
    8d20:	20400d81 	subcs	r0, r0, r1, lsl #27
    8d24:	e1500d01 	cmp	r0, r1, lsl #26
    8d28:	e0a22002 	adc	r2, r2, r2
    8d2c:	20400d01 	subcs	r0, r0, r1, lsl #26
    8d30:	e1500c81 	cmp	r0, r1, lsl #25
    8d34:	e0a22002 	adc	r2, r2, r2
    8d38:	20400c81 	subcs	r0, r0, r1, lsl #25
    8d3c:	e1500c01 	cmp	r0, r1, lsl #24
    8d40:	e0a22002 	adc	r2, r2, r2
    8d44:	20400c01 	subcs	r0, r0, r1, lsl #24
    8d48:	e1500b81 	cmp	r0, r1, lsl #23
    8d4c:	e0a22002 	adc	r2, r2, r2
    8d50:	20400b81 	subcs	r0, r0, r1, lsl #23
    8d54:	e1500b01 	cmp	r0, r1, lsl #22
    8d58:	e0a22002 	adc	r2, r2, r2
    8d5c:	20400b01 	subcs	r0, r0, r1, lsl #22
    8d60:	e1500a81 	cmp	r0, r1, lsl #21
    8d64:	e0a22002 	adc	r2, r2, r2
    8d68:	20400a81 	subcs	r0, r0, r1, lsl #21
    8d6c:	e1500a01 	cmp	r0, r1, lsl #20
    8d70:	e0a22002 	adc	r2, r2, r2
    8d74:	20400a01 	subcs	r0, r0, r1, lsl #20
    8d78:	e1500981 	cmp	r0, r1, lsl #19
    8d7c:	e0a22002 	adc	r2, r2, r2
    8d80:	20400981 	subcs	r0, r0, r1, lsl #19
    8d84:	e1500901 	cmp	r0, r1, lsl #18
    8d88:	e0a22002 	adc	r2, r2, r2
    8d8c:	20400901 	subcs	r0, r0, r1, lsl #18
    8d90:	e1500881 	cmp	r0, r1, lsl #17
    8d94:	e0a22002 	adc	r2, r2, r2
    8d98:	20400881 	subcs	r0, r0, r1, lsl #17
    8d9c:	e1500801 	cmp	r0, r1, lsl #16
    8da0:	e0a22002 	adc	r2, r2, r2
    8da4:	20400801 	subcs	r0, r0, r1, lsl #16
    8da8:	e1500781 	cmp	r0, r1, lsl #15
    8dac:	e0a22002 	adc	r2, r2, r2
    8db0:	20400781 	subcs	r0, r0, r1, lsl #15
    8db4:	e1500701 	cmp	r0, r1, lsl #14
    8db8:	e0a22002 	adc	r2, r2, r2
    8dbc:	20400701 	subcs	r0, r0, r1, lsl #14
    8dc0:	e1500681 	cmp	r0, r1, lsl #13
    8dc4:	e0a22002 	adc	r2, r2, r2
    8dc8:	20400681 	subcs	r0, r0, r1, lsl #13
    8dcc:	e1500601 	cmp	r0, r1, lsl #12
    8dd0:	e0a22002 	adc	r2, r2, r2
    8dd4:	20400601 	subcs	r0, r0, r1, lsl #12
    8dd8:	e1500581 	cmp	r0, r1, lsl #11
    8ddc:	e0a22002 	adc	r2, r2, r2
    8de0:	20400581 	subcs	r0, r0, r1, lsl #11
    8de4:	e1500501 	cmp	r0, r1, lsl #10
    8de8:	e0a22002 	adc	r2, r2, r2
    8dec:	20400501 	subcs	r0, r0, r1, lsl #10
    8df0:	e1500481 	cmp	r0, r1, lsl #9
    8df4:	e0a22002 	adc	r2, r2, r2
    8df8:	20400481 	subcs	r0, r0, r1, lsl #9
    8dfc:	e1500401 	cmp	r0, r1, lsl #8
    8e00:	e0a22002 	adc	r2, r2, r2
    8e04:	20400401 	subcs	r0, r0, r1, lsl #8
    8e08:	e1500381 	cmp	r0, r1, lsl #7
    8e0c:	e0a22002 	adc	r2, r2, r2
    8e10:	20400381 	subcs	r0, r0, r1, lsl #7
    8e14:	e1500301 	cmp	r0, r1, lsl #6
    8e18:	e0a22002 	adc	r2, r2, r2
    8e1c:	20400301 	subcs	r0, r0, r1, lsl #6
    8e20:	e1500281 	cmp	r0, r1, lsl #5
    8e24:	e0a22002 	adc	r2, r2, r2
    8e28:	20400281 	subcs	r0, r0, r1, lsl #5
    8e2c:	e1500201 	cmp	r0, r1, lsl #4
    8e30:	e0a22002 	adc	r2, r2, r2
    8e34:	20400201 	subcs	r0, r0, r1, lsl #4
    8e38:	e1500181 	cmp	r0, r1, lsl #3
    8e3c:	e0a22002 	adc	r2, r2, r2
    8e40:	20400181 	subcs	r0, r0, r1, lsl #3
    8e44:	e1500101 	cmp	r0, r1, lsl #2
    8e48:	e0a22002 	adc	r2, r2, r2
    8e4c:	20400101 	subcs	r0, r0, r1, lsl #2
    8e50:	e1500081 	cmp	r0, r1, lsl #1
    8e54:	e0a22002 	adc	r2, r2, r2
    8e58:	20400081 	subcs	r0, r0, r1, lsl #1
    8e5c:	e1500001 	cmp	r0, r1
    8e60:	e0a22002 	adc	r2, r2, r2
    8e64:	20400001 	subcs	r0, r0, r1
/builddir/build/BUILD/arm-none-eabi-gcc-cs-12.2.0/gcc-arm-none-eabi/arm-none-eabi/arm/v5te/hard/libgcc/../../../../../../gcc-12.2.0/libgcc/config/arm/lib1funcs.S:1115
    8e68:	e1a00002 	mov	r0, r2
/builddir/build/BUILD/arm-none-eabi-gcc-cs-12.2.0/gcc-arm-none-eabi/arm-none-eabi/arm/v5te/hard/libgcc/../../../../../../gcc-12.2.0/libgcc/config/arm/lib1funcs.S:1116
    8e6c:	e12fff1e 	bx	lr
/builddir/build/BUILD/arm-none-eabi-gcc-cs-12.2.0/gcc-arm-none-eabi/arm-none-eabi/arm/v5te/hard/libgcc/../../../../../../gcc-12.2.0/libgcc/config/arm/lib1funcs.S:1119
    8e70:	03a00001 	moveq	r0, #1
/builddir/build/BUILD/arm-none-eabi-gcc-cs-12.2.0/gcc-arm-none-eabi/arm-none-eabi/arm/v5te/hard/libgcc/../../../../../../gcc-12.2.0/libgcc/config/arm/lib1funcs.S:1120
    8e74:	13a00000 	movne	r0, #0
/builddir/build/BUILD/arm-none-eabi-gcc-cs-12.2.0/gcc-arm-none-eabi/arm-none-eabi/arm/v5te/hard/libgcc/../../../../../../gcc-12.2.0/libgcc/config/arm/lib1funcs.S:1121
    8e78:	e12fff1e 	bx	lr
/builddir/build/BUILD/arm-none-eabi-gcc-cs-12.2.0/gcc-arm-none-eabi/arm-none-eabi/arm/v5te/hard/libgcc/../../../../../../gcc-12.2.0/libgcc/config/arm/lib1funcs.S:1123
    8e7c:	e16f2f11 	clz	r2, r1
    8e80:	e262201f 	rsb	r2, r2, #31
/builddir/build/BUILD/arm-none-eabi-gcc-cs-12.2.0/gcc-arm-none-eabi/arm-none-eabi/arm/v5te/hard/libgcc/../../../../../../gcc-12.2.0/libgcc/config/arm/lib1funcs.S:1125
    8e84:	e1a00230 	lsr	r0, r0, r2
/builddir/build/BUILD/arm-none-eabi-gcc-cs-12.2.0/gcc-arm-none-eabi/arm-none-eabi/arm/v5te/hard/libgcc/../../../../../../gcc-12.2.0/libgcc/config/arm/lib1funcs.S:1126
    8e88:	e12fff1e 	bx	lr
/builddir/build/BUILD/arm-none-eabi-gcc-cs-12.2.0/gcc-arm-none-eabi/arm-none-eabi/arm/v5te/hard/libgcc/../../../../../../gcc-12.2.0/libgcc/config/arm/lib1funcs.S:1130
    8e8c:	e3500000 	cmp	r0, #0
    8e90:	13e00000 	mvnne	r0, #0
    8e94:	ea000007 	b	8eb8 <__aeabi_idiv0>

00008e98 <__aeabi_uidivmod>:
__aeabi_uidivmod():
/builddir/build/BUILD/arm-none-eabi-gcc-cs-12.2.0/gcc-arm-none-eabi/arm-none-eabi/arm/v5te/hard/libgcc/../../../../../../gcc-12.2.0/libgcc/config/arm/lib1funcs.S:1161
    8e98:	e3510000 	cmp	r1, #0
/builddir/build/BUILD/arm-none-eabi-gcc-cs-12.2.0/gcc-arm-none-eabi/arm-none-eabi/arm/v5te/hard/libgcc/../../../../../../gcc-12.2.0/libgcc/config/arm/lib1funcs.S:1162
    8e9c:	0afffffa 	beq	8e8c <__udivsi3+0x1e0>
/builddir/build/BUILD/arm-none-eabi-gcc-cs-12.2.0/gcc-arm-none-eabi/arm-none-eabi/arm/v5te/hard/libgcc/../../../../../../gcc-12.2.0/libgcc/config/arm/lib1funcs.S:1163
    8ea0:	e92d4003 	push	{r0, r1, lr}
/builddir/build/BUILD/arm-none-eabi-gcc-cs-12.2.0/gcc-arm-none-eabi/arm-none-eabi/arm/v5te/hard/libgcc/../../../../../../gcc-12.2.0/libgcc/config/arm/lib1funcs.S:1164
    8ea4:	ebffff80 	bl	8cac <__udivsi3>
/builddir/build/BUILD/arm-none-eabi-gcc-cs-12.2.0/gcc-arm-none-eabi/arm-none-eabi/arm/v5te/hard/libgcc/../../../../../../gcc-12.2.0/libgcc/config/arm/lib1funcs.S:1165
    8ea8:	e8bd4006 	pop	{r1, r2, lr}
/builddir/build/BUILD/arm-none-eabi-gcc-cs-12.2.0/gcc-arm-none-eabi/arm-none-eabi/arm/v5te/hard/libgcc/../../../../../../gcc-12.2.0/libgcc/config/arm/lib1funcs.S:1166
    8eac:	e0030092 	mul	r3, r2, r0
/builddir/build/BUILD/arm-none-eabi-gcc-cs-12.2.0/gcc-arm-none-eabi/arm-none-eabi/arm/v5te/hard/libgcc/../../../../../../gcc-12.2.0/libgcc/config/arm/lib1funcs.S:1167
    8eb0:	e0411003 	sub	r1, r1, r3
/builddir/build/BUILD/arm-none-eabi-gcc-cs-12.2.0/gcc-arm-none-eabi/arm-none-eabi/arm/v5te/hard/libgcc/../../../../../../gcc-12.2.0/libgcc/config/arm/lib1funcs.S:1168
    8eb4:	e12fff1e 	bx	lr

00008eb8 <__aeabi_idiv0>:
__aeabi_ldiv0():
/builddir/build/BUILD/arm-none-eabi-gcc-cs-12.2.0/gcc-arm-none-eabi/arm-none-eabi/arm/v5te/hard/libgcc/../../../../../../gcc-12.2.0/libgcc/config/arm/lib1funcs.S:1466
    8eb8:	e12fff1e 	bx	lr

Disassembly of section .ARM.extab:

00008ebc <.ARM.extab>:
    8ebc:	81019b40 	tsthi	r1, r0, asr #22
    8ec0:	8480b0b0 	strhi	fp, [r0], #176	; 0xb0
    8ec4:	00000000 	andeq	r0, r0, r0
    8ec8:	81019b41 	tsthi	r1, r1, asr #22
    8ecc:	8481b0b0 	strhi	fp, [r1], #176	; 0xb0
    8ed0:	00000000 	andeq	r0, r0, r0
    8ed4:	81019b40 	tsthi	r1, r0, asr #22
    8ed8:	8480b0b0 	strhi	fp, [r0], #176	; 0xb0
    8edc:	00000000 	andeq	r0, r0, r0
    8ee0:	81019b40 	tsthi	r1, r0, asr #22
    8ee4:	8480b0b0 	strhi	fp, [r0], #176	; 0xb0
    8ee8:	00000000 	andeq	r0, r0, r0
    8eec:	81019b40 	tsthi	r1, r0, asr #22
    8ef0:	8480b0b0 	strhi	fp, [r0], #176	; 0xb0
    8ef4:	00000000 	andeq	r0, r0, r0
    8ef8:	81019b40 	tsthi	r1, r0, asr #22
    8efc:	8480b0b0 	strhi	fp, [r0], #176	; 0xb0
    8f00:	00000000 	andeq	r0, r0, r0
    8f04:	81019b40 	tsthi	r1, r0, asr #22
    8f08:	8480b0b0 	strhi	fp, [r0], #176	; 0xb0
    8f0c:	00000000 	andeq	r0, r0, r0
    8f10:	81019b40 	tsthi	r1, r0, asr #22
    8f14:	8480b0b0 	strhi	fp, [r0], #176	; 0xb0
    8f18:	00000000 	andeq	r0, r0, r0

Disassembly of section .ARM.exidx:

00008f1c <.ARM.exidx>:
    8f1c:	7ffff0fc 	svcvc	0x00fff0fc
    8f20:	00000001 	andeq	r0, r0, r1
    8f24:	7ffff894 	svcvc	0x00fff894
    8f28:	7fffff94 	svcvc	0x00ffff94
    8f2c:	7ffff930 	svcvc	0x00fff930
    8f30:	7fffff98 	svcvc	0x00ffff98
    8f34:	7ffff984 	svcvc	0x00fff984
    8f38:	7fffff9c 	svcvc	0x00ffff9c
    8f3c:	7ffffa10 	svcvc	0x00fffa10
    8f40:	7fffffa0 	svcvc	0x00ffffa0
    8f44:	7ffffa7c 	svcvc	0x00fffa7c
    8f48:	7fffffa4 	svcvc	0x00ffffa4
    8f4c:	7ffffae4 	svcvc	0x00fffae4
    8f50:	00000001 	andeq	r0, r0, r1
    8f54:	7ffffb4c 	svcvc	0x00fffb4c
    8f58:	7fffffa0 	svcvc	0x00ffffa0
    8f5c:	7ffffc38 	svcvc	0x00fffc38
    8f60:	00000001 	andeq	r0, r0, r1
    8f64:	7ffffc98 	svcvc	0x00fffc98
    8f68:	7fffff9c 	svcvc	0x00ffff9c
    8f6c:	7ffffce8 	svcvc	0x00fffce8
    8f70:	7fffffa0 	svcvc	0x00ffffa0
    8f74:	7ffffd38 	svcvc	0x00fffd38
    8f78:	00000001 	andeq	r0, r0, r1

Disassembly of section .rodata:

00008f7c <_ZN3halL15Peripheral_BaseE>:
    8f7c:	20000000 	andcs	r0, r0, r0

00008f80 <_ZN3halL9GPIO_BaseE>:
    8f80:	20200000 	eorcs	r0, r0, r0

00008f84 <_ZN3halL14GPIO_Pin_CountE>:
    8f84:	00000036 	andeq	r0, r0, r6, lsr r0

00008f88 <_ZN3halL8AUX_BaseE>:
    8f88:	20215000 	eorcs	r5, r1, r0

00008f8c <_ZN3halL15Peripheral_BaseE>:
    8f8c:	20000000 	andcs	r0, r0, r0

00008f90 <_ZN3halL9GPIO_BaseE>:
    8f90:	20200000 	eorcs	r0, r0, r0

00008f94 <_ZN3halL14GPIO_Pin_CountE>:
    8f94:	00000036 	andeq	r0, r0, r6, lsr r0

00008f98 <_ZN3halL8AUX_BaseE>:
    8f98:	20215000 	eorcs	r5, r1, r0

00008f9c <_ZN3halL15Peripheral_BaseE>:
    8f9c:	20000000 	andcs	r0, r0, r0

00008fa0 <_ZN3halL9GPIO_BaseE>:
    8fa0:	20200000 	eorcs	r0, r0, r0

00008fa4 <_ZN3halL14GPIO_Pin_CountE>:
    8fa4:	00000036 	andeq	r0, r0, r6, lsr r0

00008fa8 <_ZN3halL8AUX_BaseE>:
    8fa8:	20215000 	eorcs	r5, r1, r0

00008fac <_ZN3halL15Peripheral_BaseE>:
    8fac:	20000000 	andcs	r0, r0, r0

00008fb0 <_ZN3halL9GPIO_BaseE>:
    8fb0:	20200000 	eorcs	r0, r0, r0

00008fb4 <_ZN3halL14GPIO_Pin_CountE>:
    8fb4:	00000036 	andeq	r0, r0, r6, lsr r0

00008fb8 <_ZN3halL8AUX_BaseE>:
    8fb8:	20215000 	eorcs	r5, r1, r0

00008fbc <_ZL7ACT_Pin>:
    8fbc:	0000002f 	andeq	r0, r0, pc, lsr #32
    8fc0:	636c6557 	cmnvs	ip, #364904448	; 0x15c00000
    8fc4:	20656d6f 	rsbcs	r6, r5, pc, ror #26
    8fc8:	4b206f74 	blmi	824da0 <_bss_end+0x81bd94>
    8fcc:	4f2f5649 	svcmi	0x002f5649
    8fd0:	50522053 	subspl	r2, r2, r3, asr r0
    8fd4:	20534f69 	subscs	r4, r3, r9, ror #30
    8fd8:	6e72656b 	cdpvs	5, 7, cr6, cr2, cr11, {3}
    8fdc:	0a0d6c65 	beq	364178 <_bss_end+0x35b16c>
	...

Disassembly of section .data:

00008fe4 <__CTOR_LIST__>:
/builddir/build/BUILD/arm-none-eabi-gcc-cs-12.2.0/gcc-arm-none-eabi/arm-none-eabi/arm/v5te/hard/libgcc/../../../../../../gcc-12.2.0/libgcc/libgcc2.c:2448
    8fe4:	0000829c 	muleq	r0, ip, r2
    8fe8:	0000879c 	muleq	r0, ip, r7
    8fec:	00008a84 	andeq	r8, r0, r4, lsl #21

Disassembly of section .bss:

00008ff0 <sAUX>:
/home/cf/ZCU/OS/practical/ex3/original/kernel/src/drivers/bcm_aux.cpp:3
CAUX sAUX(hal::AUX_Base);
    8ff0:	00000000 	andeq	r0, r0, r0

00008ff4 <sGPIO>:
/home/cf/ZCU/OS/practical/ex3/original/kernel/src/drivers/gpio.cpp:4
CGPIO_Handler sGPIO(hal::GPIO_Base);
    8ff4:	00000000 	andeq	r0, r0, r0

00008ff8 <sUART0>:
	...

Disassembly of section .debug_info:

00000000 <.debug_info>:
       0:	0000011a 	andeq	r0, r0, sl, lsl r1
       4:	04010005 	streq	r0, [r1], #-5
       8:	00000000 	andeq	r0, r0, r0
       c:	0000a706 	andeq	sl, r0, r6, lsl #14
      10:	00262100 	eoreq	r2, r6, r0, lsl #2
      14:	007a0000 	rsbseq	r0, sl, r0
      18:	80180000 	andshi	r0, r8, r0
      1c:	00d80000 	sbcseq	r0, r8, r0
      20:	00000000 	andeq	r0, r0, r0
      24:	5a010000 	bpl	4002c <_bss_end+0x37020>
      28:	29000001 	stmdbcs	r0, {r0}
      2c:	000080e4 	andeq	r8, r0, r4, ror #1
      30:	0000000c 	andeq	r0, r0, ip
      34:	47019c01 	strmi	r9, [r1, -r1, lsl #24]
      38:	24000001 	strcs	r0, [r0], #-1
      3c:	000080cc 	andeq	r8, r0, ip, asr #1
      40:	00000018 	andeq	r0, r0, r8, lsl r0
      44:	6d019c01 	stcvs	12, cr9, [r1, #-4]
      48:	1f000000 	svcne	0x00000000
      4c:	000080b4 	strheq	r8, [r0], -r4
      50:	00000018 	andeq	r0, r0, r8, lsl r0
      54:	60019c01 	andvs	r9, r1, r1, lsl #24
      58:	1a000000 	bne	60 <shift+0x60>
      5c:	0000809c 	muleq	r0, ip, r0
      60:	00000018 	andeq	r0, r0, r8, lsl r0
      64:	3c079c01 	stccc	12, cr9, [r7], {1}
      68:	01000001 	tsteq	r0, r1
      6c:	00b10b02 	adcseq	r0, r1, r2, lsl #22
      70:	14030000 	strne	r0, [r3], #-0
      74:	14000000 	strne	r0, [r0], #-0
      78:	00000082 	andeq	r0, r0, r2, lsl #1
      7c:	0000b102 	andeq	fp, r0, r2, lsl #2
      80:	71080000 	mrsvc	r0, (UNDEF: 8)
      84:	01000001 	tsteq	r0, r1
      88:	00b71c04 	adcseq	r1, r7, r4, lsl #24
      8c:	00030000 	andeq	r0, r3, r0
      90:	0f000000 	svceq	0x00000000
      94:	0000009e 	muleq	r0, lr, r0
      98:	0000b102 	andeq	fp, r0, r2, lsl #2
      9c:	28090000 	stmdacs	r9, {}	; <UNPREDICTABLE>
      a0:	01000001 	tsteq	r0, r1
      a4:	00fa110a 	rscseq	r1, sl, sl, lsl #2
      a8:	b1020000 	mrslt	r0, (UNDEF: 2)
      ac:	00000000 	andeq	r0, r0, r0
      b0:	82040a00 	andhi	r0, r4, #0, 20
      b4:	0b000000 	bleq	bc <shift+0xbc>
      b8:	01790508 	cmneq	r9, r8, lsl #10
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
     110:	0a006705 	beq	19d2c <_bss_end+0x10d20>
     114:	0000b12f 	andeq	fp, r0, pc, lsr #2
     118:	74910200 	ldrvc	r0, [r1], #512	; 0x200
     11c:	03d40000 	bicseq	r0, r4, #0
     120:	00050000 	andeq	r0, r5, r0
     124:	00d40401 	sbcseq	r0, r4, r1, lsl #8
     128:	a70e0000 	strge	r0, [lr, -r0]
     12c:	21000000 	mrscs	r0, (UNDEF: 0)
     130:	00000191 	muleq	r0, r1, r1
     134:	0000007a 	andeq	r0, r0, sl, ror r0
     138:	000080f0 	strdeq	r8, [r0], -r0
     13c:	000001c8 	andeq	r0, r0, r8, asr #3
     140:	0000008d 	andeq	r0, r0, sp, lsl #1
     144:	14080103 	strne	r0, [r8], #-259	; 0xfffffefd
     148:	03000003 	movweq	r0, #3
     14c:	01870502 	orreq	r0, r7, r2, lsl #10
     150:	040f0000 	streq	r0, [pc], #-0	; 158 <shift+0x158>
     154:	746e6905 	strbtvc	r6, [lr], #-2309	; 0xfffff6fb
     158:	08010300 	stmdaeq	r1, {r8, r9}
     15c:	0000030b 	andeq	r0, r0, fp, lsl #6
     160:	75070203 	strvc	r0, [r7, #-515]	; 0xfffffdfd
     164:	10000003 	andne	r0, r0, r3
     168:	0000033e 	andeq	r0, r0, lr, lsr r3
     16c:	5a070b04 	bpl	1c2d84 <_bss_end+0x1b9d78>
     170:	06000000 	streq	r0, [r0], -r0
     174:	00000049 	andeq	r0, r0, r9, asr #32
     178:	0c070403 	cfstrseq	mvf0, [r7], {3}
     17c:	1100000e 	tstne	r0, lr
     180:	006c6168 	rsbeq	r6, ip, r8, ror #2
     184:	630b0702 	movwvs	r0, #46850	; 0xb702
     188:	09000001 	stmdbeq	r0, {r0}
     18c:	000002cf 	andeq	r0, r0, pc, asr #5
     190:	00016a0a 	andeq	r6, r1, sl, lsl #20
     194:	00000000 	andeq	r0, r0, r0
     198:	03270920 			; <UNDEFINED> instruction: 0x03270920
     19c:	6a0d0000 	bvs	3401a4 <_bss_end+0x337198>
     1a0:	00000001 	andeq	r0, r0, r1
     1a4:	12202000 	eorne	r2, r0, #0
     1a8:	000003b3 			; <UNDEFINED> instruction: 0x000003b3
     1ac:	55151002 	ldrpl	r1, [r5, #-2]
     1b0:	36000000 	strcc	r0, [r0], -r0
     1b4:	00041009 	andeq	r1, r4, r9
     1b8:	016a4200 	cmneq	sl, r0, lsl #4
     1bc:	50000000 	andpl	r0, r0, r0
     1c0:	ec132021 	ldc	0, cr2, [r3], {33}	; 0x21
     1c4:	05000001 	streq	r0, [r0, #-1]
     1c8:	00003404 	andeq	r3, r0, r4, lsl #8
     1cc:	0d440200 	sfmeq	f0, 2, [r4, #-0]
     1d0:	00000141 	andeq	r0, r0, r1, asr #2
     1d4:	51524914 	cmppl	r2, r4, lsl r9
     1d8:	29010000 	stmdbcs	r1, {}	; <UNPREDICTABLE>
     1dc:	01000002 	tsteq	r0, r2
     1e0:	00043001 	andeq	r3, r4, r1
     1e4:	19011000 	stmdbne	r1, {ip}
     1e8:	11000003 	tstne	r0, r3
     1ec:	00035c01 	andeq	r5, r3, r1, lsl #24
     1f0:	90011200 	andls	r1, r1, r0, lsl #4
     1f4:	13000003 	movwne	r0, #3
     1f8:	00032001 	andeq	r2, r3, r1
     1fc:	3f011400 	svccc	0x00011400
     200:	15000004 	strne	r0, [r0, #-4]
     204:	00040901 	andeq	r0, r4, r1, lsl #18
     208:	77011600 	strvc	r1, [r1, -r0, lsl #12]
     20c:	17000004 	strne	r0, [r0, -r4]
     210:	00036301 	andeq	r6, r3, r1, lsl #6
     214:	19011800 	stmdbne	r1, {fp, ip}
     218:	19000004 	stmdbne	r0, {r2}
     21c:	0003a101 	andeq	sl, r3, r1, lsl #2
     220:	b9011a00 	stmdblt	r1, {r9, fp, ip}
     224:	20000002 	andcs	r0, r0, r2
     228:	0002c401 	andeq	ip, r2, r1, lsl #8
     22c:	a9012100 	stmdbge	r1, {r8, sp}
     230:	22000003 	andcs	r0, r0, #3
     234:	00029d01 	andeq	r9, r2, r1, lsl #26
     238:	97012400 	strls	r2, [r1, -r0, lsl #8]
     23c:	25000003 	strcs	r0, [r0, #-3]
     240:	0002ee01 	andeq	lr, r2, r1, lsl #28
     244:	f9013000 			; <UNDEFINED> instruction: 0xf9013000
     248:	31000002 	tstcc	r0, r2
     24c:	0001e101 	andeq	lr, r1, r1, lsl #2
     250:	88013200 	stmdahi	r1, {r9, ip, sp}
     254:	34000003 	strcc	r0, [r0], #-3
     258:	0001d701 	andeq	sp, r1, r1, lsl #14
     25c:	15003500 	strne	r3, [r0, #-1280]	; 0xfffffb00
     260:	00000259 	andeq	r0, r0, r9, asr r2
     264:	00340405 	eorseq	r0, r4, r5, lsl #8
     268:	6a020000 	bvs	80270 <_bss_end+0x77264>
     26c:	0436010d 	ldrteq	r0, [r6], #-269	; 0xfffffef3
     270:	01000000 	mrseq	r0, (UNDEF: 0)
     274:	0000036b 	andeq	r0, r0, fp, ror #6
     278:	03700101 	cmneq	r0, #1073741824	; 0x40000000
     27c:	00020000 	andeq	r0, r2, r0
     280:	07040300 	streq	r0, [r4, -r0, lsl #6]
     284:	00000e07 	andeq	r0, r0, r7, lsl #28
     288:	00016306 	andeq	r6, r1, r6, lsl #6
     28c:	006d0700 	rsbeq	r0, sp, r0, lsl #14
     290:	7b070000 	blvc	1c0298 <_bss_end+0x1b728c>
     294:	07000000 	streq	r0, [r0, -r0]
     298:	00000089 	andeq	r0, r0, r9, lsl #1
     29c:	00009607 	andeq	r9, r0, r7, lsl #12
     2a0:	083b1600 	ldmdaeq	fp!, {r9, sl, ip}
     2a4:	03040000 	movweq	r0, #16384	; 0x4000
     2a8:	023e0706 	eorseq	r0, lr, #1572864	; 0x180000
     2ac:	eb170000 	bl	5c02b4 <_bss_end+0x5b72a8>
     2b0:	03000001 	movweq	r0, #1
     2b4:	02431d0a 	subeq	r1, r3, #640	; 0x280
     2b8:	18000000 	stmdane	r0, {}	; <UNPREDICTABLE>
     2bc:	0000083b 	andeq	r0, r0, fp, lsr r8
     2c0:	69090d03 	stmdbvs	r9, {r0, r1, r8, sl, fp}
     2c4:	48000002 	stmdami	r0, {r1}
     2c8:	01000002 	tsteq	r0, r2
     2cc:	000001b6 			; <UNDEFINED> instruction: 0x000001b6
     2d0:	000001c1 	andeq	r0, r0, r1, asr #3
     2d4:	00024805 	andeq	r4, r2, r5, lsl #16
     2d8:	005a0400 	subseq	r0, sl, r0, lsl #8
     2dc:	0a000000 	beq	2e4 <shift+0x2e4>
     2e0:	00000304 	andeq	r0, r0, r4, lsl #6
     2e4:	00023110 	andeq	r3, r2, r0, lsl r1
     2e8:	0001d300 	andeq	sp, r1, r0, lsl #6
     2ec:	0001de00 	andeq	sp, r1, r0, lsl #28
     2f0:	02480500 	subeq	r0, r8, #0, 10
     2f4:	41040000 	mrsmi	r0, (UNDEF: 4)
     2f8:	00000001 	andeq	r0, r0, r1
     2fc:	0003470a 	andeq	r4, r3, sl, lsl #14
     300:	044e1200 	strbeq	r1, [lr], #-512	; 0xfffffe00
     304:	01f00000 	mvnseq	r0, r0
     308:	01fb0000 	mvnseq	r0, r0
     30c:	48050000 	stmdami	r5, {}	; <UNPREDICTABLE>
     310:	04000002 	streq	r0, [r0], #-2
     314:	00000141 	andeq	r0, r0, r1, asr #2
     318:	03fc0a00 	mvnseq	r0, #0, 20
     31c:	76150000 	ldrvc	r0, [r5], -r0
     320:	0d000002 	stceq	0, cr0, [r0, #-8]
     324:	1d000002 	stcne	0, cr0, [r0, #-8]
     328:	05000002 	streq	r0, [r0, #-2]
     32c:	00000248 	andeq	r0, r0, r8, asr #4
     330:	0000a404 	andeq	sl, r0, r4, lsl #8
     334:	00490400 	subeq	r0, r9, r0, lsl #8
     338:	19000000 	stmdbne	r0, {}	; <UNPREDICTABLE>
     33c:	0000034f 	andeq	r0, r0, pc, asr #6
     340:	f4121703 			; <UNDEFINED> instruction: 0xf4121703
     344:	49000001 	stmdbmi	r0, {r0}
     348:	01000000 	mrseq	r0, (UNDEF: 0)
     34c:	00000232 	andeq	r0, r0, r2, lsr r2
     350:	00024805 	andeq	r4, r2, r5, lsl #16
     354:	00a40400 	adceq	r0, r4, r0, lsl #8
     358:	00000000 	andeq	r0, r0, r0
     35c:	00005a0b 	andeq	r5, r0, fp, lsl #20
     360:	023e0600 	eorseq	r0, lr, #0, 12
     364:	830b0000 	movwhi	r0, #45056	; 0xb000
     368:	06000001 	streq	r0, [r0], -r1
     36c:	00000248 	andeq	r0, r0, r8, asr #4
     370:	0002b41a 	andeq	fp, r2, sl, lsl r4
     374:	0d1a0300 	ldceq	3, cr0, [sl, #-0]
     378:	00000183 	andeq	r0, r0, r3, lsl #3
     37c:	0002521b 	andeq	r5, r2, fp, lsl r2
     380:	06030100 	streq	r0, [r3], -r0, lsl #2
     384:	8ff00305 	svchi	0x00f00305
     388:	a51c0000 	ldrge	r0, [ip, #-0]
     38c:	9c000002 	stcls	0, cr0, [r0], {2}
     390:	1c000082 	stcne	0, cr0, [r0], {130}	; 0x82
     394:	01000000 	mrseq	r0, (UNDEF: 0)
     398:	03c21d9c 	biceq	r1, r2, #156, 26	; 0x2700
     39c:	82480000 	subhi	r0, r8, #0
     3a0:	00540000 	subseq	r0, r4, r0
     3a4:	9c010000 	stcls	0, cr0, [r1], {-0}
     3a8:	000002ab 	andeq	r0, r0, fp, lsr #5
     3ac:	0002df02 	andeq	sp, r2, r2, lsl #30
     3b0:	34011d00 	strcc	r1, [r1], #-3328	; 0xfffff300
     3b4:	02000000 	andeq	r0, r0, #0
     3b8:	ec027491 	cfstrs	mvf7, [r2], {145}	; 0x91
     3bc:	1d000003 	stcne	0, cr0, [r0, #-12]
     3c0:	00003401 	andeq	r3, r0, r1, lsl #8
     3c4:	70910200 	addsvc	r0, r1, r0, lsl #4
     3c8:	021d1e00 	andseq	r1, sp, #0, 28
     3cc:	1a010000 	bne	403d4 <_bss_end+0x373c8>
     3d0:	0002c50a 	andeq	ip, r2, sl, lsl #10
     3d4:	00820c00 	addeq	r0, r2, r0, lsl #24
     3d8:	00003c00 	andeq	r3, r0, r0, lsl #24
     3dc:	e09c0100 	adds	r0, ip, r0, lsl #2
     3e0:	08000002 	stmdaeq	r0, {r1}
     3e4:	000003f7 	strdeq	r0, [r0], -r7
     3e8:	0000024d 	andeq	r0, r0, sp, asr #4
     3ec:	02749102 	rsbseq	r9, r4, #-2147483648	; 0x80000000
     3f0:	00000446 	andeq	r0, r0, r6, asr #8
     3f4:	00a42a1a 	adceq	r2, r4, sl, lsl sl
     3f8:	91020000 	mrsls	r0, (UNDEF: 2)
     3fc:	fb1f0070 	blx	7c05c6 <_bss_end+0x7b75ba>
     400:	01000001 	tsteq	r0, r1
     404:	0002f906 	andeq	pc, r2, r6, lsl #18
     408:	0081c800 	addeq	ip, r1, r0, lsl #16
     40c:	00004400 	andeq	r4, r0, r0, lsl #8
     410:	229c0100 	addscs	r0, ip, #0, 2
     414:	08000003 	stmdaeq	r0, {r0, r1}
     418:	000003f7 	strdeq	r0, [r0], -r7
     41c:	0000024d 	andeq	r0, r0, sp, asr #4
     420:	02749102 	rsbseq	r9, r4, #-2147483648	; 0x80000000
     424:	00000446 	andeq	r0, r0, r6, asr #8
     428:	00a42615 	adceq	r2, r4, r5, lsl r6
     42c:	91020000 	mrsls	r0, (UNDEF: 2)
     430:	021a0270 	andseq	r0, sl, #112, 4
     434:	38150000 	ldmdacc	r5, {}	; <UNPREDICTABLE>
     438:	00000049 	andeq	r0, r0, r9, asr #32
     43c:	006c9102 	rsbeq	r9, ip, r2, lsl #2
     440:	0001de0c 	andeq	sp, r1, ip, lsl #28
     444:	033a1000 	teqeq	sl, #0
     448:	81740000 	cmnhi	r4, r0
     44c:	00540000 	subseq	r0, r4, r0
     450:	9c010000 	stcls	0, cr0, [r1], {-0}
     454:	00000355 	andeq	r0, r0, r5, asr r3
     458:	0003f708 	andeq	pc, r3, r8, lsl #14
     45c:	00024d00 	andeq	r4, r2, r0, lsl #26
     460:	74910200 	ldrvc	r0, [r1], #512	; 0x200
     464:	00042102 	andeq	r2, r4, r2, lsl #2
     468:	41291000 			; <UNDEFINED> instruction: 0x41291000
     46c:	02000001 	andeq	r0, r0, #1
     470:	0c007091 	stceq	0, cr7, [r0], {145}	; 0x91
     474:	000001c1 	andeq	r0, r0, r1, asr #3
     478:	00036d0b 	andeq	r6, r3, fp, lsl #26
     47c:	00812400 	addeq	r2, r1, r0, lsl #8
     480:	00005000 	andeq	r5, r0, r0
     484:	889c0100 	ldmhi	ip, {r8}
     488:	08000003 	stmdaeq	r0, {r0, r1}
     48c:	000003f7 	strdeq	r0, [r0], -r7
     490:	0000024d 	andeq	r0, r0, sp, asr #4
     494:	02749102 	rsbseq	r9, r4, #-2147483648	; 0x80000000
     498:	00000421 	andeq	r0, r0, r1, lsr #8
     49c:	0141280b 	cmpeq	r1, fp, lsl #16
     4a0:	91020000 	mrsls	r0, (UNDEF: 2)
     4a4:	9d200070 	stcls	0, cr0, [r0, #-448]!	; 0xfffffe40
     4a8:	01000001 	tsteq	r0, r1
     4ac:	03990105 	orrseq	r0, r9, #1073741825	; 0x40000001
     4b0:	af000000 	svcge	0x00000000
     4b4:	21000003 	tstcs	r0, r3
     4b8:	000003f7 	strdeq	r0, [r0], -r7
     4bc:	0000024d 	andeq	r0, r0, sp, asr #4
     4c0:	00022022 	andeq	r2, r2, r2, lsr #32
     4c4:	19050100 	stmdbne	r5, {r8}
     4c8:	0000005a 	andeq	r0, r0, sl, asr r0
     4cc:	03882300 	orreq	r2, r8, #0, 6
     4d0:	03310000 	teqeq	r1, #0
     4d4:	03c60000 	biceq	r0, r6, #0
     4d8:	80f00000 	rscshi	r0, r0, r0
     4dc:	00340000 	eorseq	r0, r4, r0
     4e0:	9c010000 	stcls	0, cr0, [r1], {-0}
     4e4:	0003990d 	andeq	r9, r3, sp, lsl #18
     4e8:	74910200 	ldrvc	r0, [r1], #512	; 0x200
     4ec:	0003a20d 	andeq	sl, r3, sp, lsl #4
     4f0:	70910200 	addsvc	r0, r1, r0, lsl #4
     4f4:	064f0000 	strbeq	r0, [pc], -r0
     4f8:	00050000 	andeq	r0, r5, r0
     4fc:	03190401 	tsteq	r9, #16777216	; 0x1000000
     500:	a7130000 	ldrge	r0, [r3, -r0]
     504:	21000000 	mrscs	r0, (UNDEF: 0)
     508:	00000656 	andeq	r0, r0, r6, asr r6
     50c:	0000007a 	andeq	r0, r0, sl, ror r0
     510:	000082b8 			; <UNDEFINED> instruction: 0x000082b8
     514:	00000500 	andeq	r0, r0, r0, lsl #10
     518:	0000020a 	andeq	r0, r0, sl, lsl #4
     51c:	14080105 	strne	r0, [r8], #-261	; 0xfffffefb
     520:	05000003 	streq	r0, [r0, #-3]
     524:	01870502 	orreq	r0, r7, r2, lsl #10
     528:	04140000 	ldreq	r0, [r4], #-0
     52c:	746e6905 	strbtvc	r6, [lr], #-2309	; 0xfffff6fb
     530:	05871000 	streq	r1, [r7]
     534:	45090000 	strmi	r0, [r9, #-0]
     538:	05000000 	streq	r0, [r0, #-0]
     53c:	030b0801 	movweq	r0, #47105	; 0xb801
     540:	02050000 	andeq	r0, r5, #0
     544:	00037507 	andeq	r7, r3, r7, lsl #10
     548:	033e1000 	teqeq	lr, #0
     54c:	620b0000 	andvs	r0, fp, #0
     550:	08000000 	stmdaeq	r0, {}	; <UNPREDICTABLE>
     554:	00000053 	andeq	r0, r0, r3, asr r0
     558:	0c070405 	cfstrseq	mvf0, [r7], {5}
     55c:	1500000e 	strne	r0, [r0, #-14]
     560:	006c6168 	rsbeq	r6, ip, r8, ror #2
     564:	6e0b0703 	cdpvs	7, 0, cr0, cr11, cr3, {0}
     568:	0d000001 	stceq	0, cr0, [r0, #-4]
     56c:	000002cf 	andeq	r0, r0, pc, asr #5
     570:	0001750a 	andeq	r7, r1, sl, lsl #10
     574:	00000000 	andeq	r0, r0, r0
     578:	03270d20 			; <UNDEFINED> instruction: 0x03270d20
     57c:	750d0000 	strvc	r0, [sp, #-0]
     580:	00000001 	andeq	r0, r0, r1
     584:	16202000 	strtne	r2, [r0], -r0
     588:	000003b3 			; <UNDEFINED> instruction: 0x000003b3
     58c:	5d151003 	ldcpl	0, cr1, [r5, #-12]
     590:	36000000 	strcc	r0, [r0], -r0
     594:	00072c11 	andeq	r2, r7, r1, lsl ip
     598:	34040500 	strcc	r0, [r4], #-1280	; 0xfffffb00
     59c:	03000000 	movweq	r0, #0
     5a0:	015f0d13 	cmpeq	pc, r3, lsl sp	; <UNPREDICTABLE>
     5a4:	bf010000 	svclt	0x00010000
     5a8:	00000004 	andeq	r0, r0, r4
     5ac:	0004c701 	andeq	ip, r4, r1, lsl #14
     5b0:	cf010100 	svcgt	0x00010100
     5b4:	02000004 	andeq	r0, r0, #4
     5b8:	0004d701 	andeq	sp, r4, r1, lsl #14
     5bc:	df010300 	svcle	0x00010300
     5c0:	04000004 	streq	r0, [r0], #-4
     5c4:	0004e701 	andeq	lr, r4, r1, lsl #14
     5c8:	b1010500 	tstlt	r1, r0, lsl #10
     5cc:	07000004 	streq	r0, [r0, -r4]
     5d0:	0004b801 	andeq	fp, r4, r1, lsl #16
     5d4:	13010800 	movwne	r0, #6144	; 0x1800
     5d8:	0a000008 	beq	600 <shift+0x600>
     5dc:	0006dd01 	andeq	sp, r6, r1, lsl #26
     5e0:	6d010b00 	vstrvs	d0, [r1, #-0]
     5e4:	0d000007 	stceq	0, cr0, [r0, #-28]	; 0xffffffe4
     5e8:	00077401 	andeq	r7, r7, r1, lsl #8
     5ec:	8f010e00 	svchi	0x00010e00
     5f0:	10000005 	andne	r0, r0, r5
     5f4:	00059601 	andeq	r9, r5, r1, lsl #12
     5f8:	0a011100 	beq	44a00 <_bss_end+0x3b9f4>
     5fc:	13000005 	movwne	r0, #5
     600:	00051101 	andeq	r1, r5, r1, lsl #2
     604:	dd011400 	cfstrsle	mvf1, [r1, #-0]
     608:	16000007 	strne	r0, [r0], -r7
     60c:	0004ef01 	andeq	lr, r4, r1, lsl #30
     610:	f4011700 	vst1.8	{d1}, [r1], r0
     614:	19000006 	stmdbne	r0, {r1, r2}
     618:	0006fb01 	andeq	pc, r6, r1, lsl #22
     61c:	ae011a00 	vmlage.f32	s2, s2, s0
     620:	1c000005 	stcne	0, cr0, [r0], {5}
     624:	00071101 	andeq	r1, r7, r1, lsl #2
     628:	e4011d00 	str	r1, [r1], #-3328	; 0xfffff300
     62c:	1f000006 	svcne	0x00000006
     630:	0006ec01 	andeq	lr, r6, r1, lsl #24
     634:	46012000 	strmi	r2, [r1], -r0
     638:	22000006 	andcs	r0, r0, #6
     63c:	00064e01 	andeq	r4, r6, r1, lsl #28
     640:	ed012300 	stc	3, cr2, [r1, #-0]
     644:	25000005 	strcs	r0, [r0, #-5]
     648:	0004f601 	andeq	pc, r4, r1, lsl #12
     64c:	00012600 	andeq	r2, r1, r0, lsl #12
     650:	27000005 	strcs	r0, [r0, -r5]
     654:	04100d00 	ldreq	r0, [r0], #-3328	; 0xfffff300
     658:	75420000 	strbvc	r0, [r2, #-0]
     65c:	00000001 	andeq	r0, r0, r1
     660:	00202150 	eoreq	r2, r0, r0, asr r1
     664:	07070405 	streq	r0, [r7, -r5, lsl #8]
     668:	0800000e 	stmdaeq	r0, {r1, r2, r3}
     66c:	0000016e 	andeq	r0, r0, lr, ror #2
     670:	0000750b 	andeq	r7, r0, fp, lsl #10
     674:	00830b00 	addeq	r0, r3, r0, lsl #22
     678:	910b0000 	mrsls	r0, (UNDEF: 11)
     67c:	0b000000 	bleq	684 <shift+0x684>
     680:	0000015f 	andeq	r0, r0, pc, asr r1
     684:	00075e11 	andeq	r5, r7, r1, lsl lr
     688:	3b010700 	blcc	42290 <_bss_end+0x39284>
     68c:	04000000 	streq	r0, [r0], #-0
     690:	01d70c06 	bicseq	r0, r7, r6, lsl #24
     694:	d7010000 	strle	r0, [r1, -r0]
     698:	00000007 	andeq	r0, r0, r7
     69c:	0007e801 	andeq	lr, r7, r1, lsl #16
     6a0:	0d010100 	stfeqs	f0, [r1, #-0]
     6a4:	02000008 	andeq	r0, r0, #8
     6a8:	00080701 	andeq	r0, r8, r1, lsl #14
     6ac:	ef010300 	svc	0x00010300
     6b0:	04000007 	streq	r0, [r0], #-7
     6b4:	0007f501 	andeq	pc, r7, r1, lsl #10
     6b8:	fb010500 	blx	41ac2 <_bss_end+0x38ab6>
     6bc:	06000007 	streq	r0, [r0], -r7
     6c0:	00080101 	andeq	r0, r8, r1, lsl #2
     6c4:	a2010700 	andge	r0, r1, #0, 14
     6c8:	08000005 	stmdaeq	r0, {r0, r2}
     6cc:	05cc1700 	strbeq	r1, [ip, #1792]	; 0x700
     6d0:	04040000 	streq	r0, [r4], #-0
     6d4:	0332071a 	teqeq	r2, #6815744	; 0x680000
     6d8:	6a180000 	bvs	6006e0 <_bss_end+0x5f76d4>
     6dc:	04000005 	streq	r0, [r0], #-5
     6e0:	033c171e 	teqeq	ip, #7864320	; 0x780000
     6e4:	09000000 	stmdbeq	r0, {}	; <UNPREDICTABLE>
     6e8:	00000718 	andeq	r0, r0, r8, lsl r7
     6ec:	053a0822 	ldreq	r0, [sl, #-2082]!	; 0xfffff7de
     6f0:	03410000 	movteq	r0, #4096	; 0x1000
     6f4:	09020000 	stmdbeq	r2, {}	; <UNPREDICTABLE>
     6f8:	1e000002 	cdpne	0, 0, cr0, cr0, cr2, {0}
     6fc:	04000002 	streq	r0, [r0], #-2
     700:	00000348 	andeq	r0, r0, r8, asr #6
     704:	00005302 	andeq	r5, r0, r2, lsl #6
     708:	03520200 	cmpeq	r2, #0, 4
     70c:	52020000 	andpl	r0, r2, #0
     710:	00000003 	andeq	r0, r0, r3
     714:	0007c409 	andeq	ip, r7, r9, lsl #8
     718:	99082400 	stmdbls	r8, {sl, sp}
     71c:	41000006 	tstmi	r0, r6
     720:	02000003 	andeq	r0, r0, #3
     724:	00000236 	andeq	r0, r0, r6, lsr r2
     728:	0000024b 	andeq	r0, r0, fp, asr #4
     72c:	00034804 	andeq	r4, r3, r4, lsl #16
     730:	00530200 	subseq	r0, r3, r0, lsl #4
     734:	52020000 	andpl	r0, r2, #0
     738:	02000003 	andeq	r0, r0, #3
     73c:	00000352 	andeq	r0, r0, r2, asr r3
     740:	05da0900 	ldrbeq	r0, [sl, #2304]	; 0x900
     744:	08260000 	stmdaeq	r6!, {}	; <UNPREDICTABLE>
     748:	00000795 	muleq	r0, r5, r7
     74c:	00000341 	andeq	r0, r0, r1, asr #6
     750:	00026302 	andeq	r6, r2, r2, lsl #6
     754:	00027800 	andeq	r7, r2, r0, lsl #16
     758:	03480400 	movteq	r0, #33792	; 0x8400
     75c:	53020000 	movwpl	r0, #8192	; 0x2000
     760:	02000000 	andeq	r0, r0, #0
     764:	00000352 	andeq	r0, r0, r2, asr r3
     768:	00035202 	andeq	r5, r3, r2, lsl #4
     76c:	f3090000 	vhadd.u8	d0, d9, d0
     770:	28000005 	stmdacs	r0, {r0, r2}
     774:	00048208 	andeq	r8, r4, r8, lsl #4
     778:	00034100 	andeq	r4, r3, r0, lsl #2
     77c:	02900200 	addseq	r0, r0, #0, 4
     780:	02a50000 	adceq	r0, r5, #0
     784:	48040000 	stmdami	r4, {}	; <UNPREDICTABLE>
     788:	02000003 	andeq	r0, r0, #3
     78c:	00000053 	andeq	r0, r0, r3, asr r0
     790:	00035202 	andeq	r5, r3, r2, lsl #4
     794:	03520200 	cmpeq	r2, #0, 4
     798:	09000000 	stmdbeq	r0, {}	; <UNPREDICTABLE>
     79c:	000005cc 	andeq	r0, r0, ip, asr #11
     7a0:	0570032b 	ldrbeq	r0, [r0, #-811]!	; 0xfffffcd5
     7a4:	03580000 	cmpeq	r8, #0
     7a8:	bd010000 	stclt	0, cr0, [r1, #-0]
     7ac:	c8000002 	stmdagt	r0, {r1}
     7b0:	04000002 	streq	r0, [r0], #-2
     7b4:	00000358 	andeq	r0, r0, r8, asr r3
     7b8:	00006202 	andeq	r6, r0, r2, lsl #4
     7bc:	7b190000 	blvc	6407c4 <_bss_end+0x6377b8>
     7c0:	04000007 	streq	r0, [r0], #-7
     7c4:	0735082e 	ldreq	r0, [r5, -lr, lsr #16]!
     7c8:	dd010000 	stcle	0, cr0, [r1, #-0]
     7cc:	ed000002 	stc	0, cr0, [r0, #-8]
     7d0:	04000002 	streq	r0, [r0], #-2
     7d4:	00000358 	andeq	r0, r0, r8, asr r3
     7d8:	00005302 	andeq	r5, r0, r2, lsl #6
     7dc:	018e0200 	orreq	r0, lr, r0, lsl #4
     7e0:	09000000 	stmdbeq	r0, {}	; <UNPREDICTABLE>
     7e4:	000005ba 			; <UNDEFINED> instruction: 0x000005ba
     7e8:	06061230 			; <UNDEFINED> instruction: 0x06061230
     7ec:	018e0000 	orreq	r0, lr, r0
     7f0:	05010000 	streq	r0, [r1, #-0]
     7f4:	10000003 	andne	r0, r0, r3
     7f8:	04000003 	streq	r0, [r0], #-3
     7fc:	00000348 	andeq	r0, r0, r8, asr #6
     800:	00005302 	andeq	r5, r0, r2, lsl #6
     804:	e41a0000 	ldr	r0, [sl], #-0
     808:	04000007 	streq	r0, [r0], #-7
     80c:	05180833 	ldreq	r0, [r8, #-2099]	; 0xfffff7cd
     810:	21010000 	mrscs	r0, (UNDEF: 1)
     814:	04000003 	streq	r0, [r0], #-3
     818:	00000358 	andeq	r0, r0, r8, asr r3
     81c:	00005302 	andeq	r5, r0, r2, lsl #6
     820:	03410200 	movteq	r0, #4608	; 0x1200
     824:	00000000 	andeq	r0, r0, r0
     828:	0001d708 	andeq	sp, r1, r8, lsl #14
     82c:	00620e00 	rsbeq	r0, r2, r0, lsl #28
     830:	37080000 	strcc	r0, [r8, -r0]
     834:	05000003 	streq	r0, [r0, #-3]
     838:	059d0201 	ldreq	r0, [sp, #513]	; 0x201
     83c:	320e0000 	andcc	r0, lr, #0
     840:	08000003 	stmdaeq	r0, {r0, r1}
     844:	00000348 	andeq	r0, r0, r8, asr #6
     848:	0053041b 	subseq	r0, r3, fp, lsl r4
     84c:	d70e0000 	strle	r0, [lr, -r0]
     850:	08000001 	stmdaeq	r0, {r0}
     854:	00000358 	andeq	r0, r0, r8, asr r3
     858:	0006d71c 	andeq	sp, r6, ip, lsl r7
     85c:	16370400 	ldrtne	r0, [r7], -r0, lsl #8
     860:	000001d7 	ldrdeq	r0, [r0], -r7
     864:	0003621d 	andeq	r6, r3, sp, lsl r2
     868:	0f040100 	svceq	0x00040100
     86c:	8ff40305 	svchi	0x00f40305
     870:	c81e0000 	ldmdagt	lr, {}	; <UNPREDICTABLE>
     874:	9c000006 	stcls	0, cr0, [r0], {6}
     878:	1c000087 	stcne	0, cr0, [r0], {135}	; 0x87
     87c:	01000000 	mrseq	r0, (UNDEF: 0)
     880:	03c21f9c 	biceq	r1, r2, #156, 30	; 0x270
     884:	87480000 	strbhi	r0, [r8, -r0]
     888:	00540000 	subseq	r0, r4, r0
     88c:	9c010000 	stcls	0, cr0, [r1], {-0}
     890:	000003bb 			; <UNDEFINED> instruction: 0x000003bb
     894:	0002df06 	andeq	sp, r2, r6, lsl #30
     898:	34015b00 	strcc	r5, [r1], #-2816	; 0xfffff500
     89c:	02000000 	andeq	r0, r0, #0
     8a0:	ec067491 	cfstrs	mvf7, [r6], {145}	; 0x91
     8a4:	5b000003 	blpl	8b8 <shift+0x8b8>
     8a8:	00003401 	andeq	r3, r0, r1, lsl #8
     8ac:	70910200 	addsvc	r0, r1, r0, lsl #4
     8b0:	03100f00 	tsteq	r0, #0, 30
     8b4:	06540000 	ldrbeq	r0, [r4], -r0
     8b8:	000003d4 	ldrdeq	r0, [r0], -r4
     8bc:	00008670 	andeq	r8, r0, r0, ror r6
     8c0:	000000d8 	ldrdeq	r0, [r0], -r8
     8c4:	04199c01 	ldreq	r9, [r9], #-3073	; 0xfffff3ff
     8c8:	f7070000 			; <UNDEFINED> instruction: 0xf7070000
     8cc:	5d000003 	stcpl	0, cr0, [r0, #-12]
     8d0:	02000003 	andeq	r0, r0, #3
     8d4:	70036c91 	mulvc	r3, r1, ip
     8d8:	54006e69 	strpl	r6, [r0], #-3689	; 0xfffff197
     8dc:	00005329 	andeq	r5, r0, r9, lsr #6
     8e0:	68910200 	ldmvs	r1, {r9}
     8e4:	74657303 	strbtvc	r7, [r5], #-771	; 0xfffffcfd
     8e8:	41335400 	teqmi	r3, r0, lsl #8
     8ec:	02000003 	andeq	r0, r0, #3
     8f0:	720a6791 	andvc	r6, sl, #38010880	; 0x2440000
     8f4:	56006765 	strpl	r6, [r0], -r5, ror #14
     8f8:	0000530b 	andeq	r5, r0, fp, lsl #6
     8fc:	74910200 	ldrvc	r0, [r1], #512	; 0x200
     900:	7469620a 	strbtvc	r6, [r9], #-522	; 0xfffffdf6
     904:	53105600 	tstpl	r0, #0, 12
     908:	02000000 	andeq	r0, r0, #0
     90c:	0f007091 	svceq	0x00007091
     910:	000002ed 	andeq	r0, r0, sp, ror #5
     914:	0432104b 	ldrteq	r1, [r2], #-75	; 0xffffffb5
     918:	85fc0000 	ldrbhi	r0, [ip, #0]!
     91c:	00740000 	rsbseq	r0, r4, r0
     920:	9c010000 	stcls	0, cr0, [r1], {-0}
     924:	00000469 	andeq	r0, r0, r9, ror #8
     928:	0003f707 	andeq	pc, r3, r7, lsl #14
     92c:	00034d00 	andeq	r4, r3, r0, lsl #26
     930:	6c910200 	lfmvs	f0, 4, [r1], {0}
     934:	6e697003 	cdpvs	0, 6, cr7, cr9, cr3, {0}
     938:	533a4b00 	teqpl	sl, #0, 22
     93c:	02000000 	andeq	r0, r0, #0
     940:	720a6891 	andvc	r6, sl, #9502720	; 0x910000
     944:	4d006765 	stcmi	7, cr6, [r0, #-404]	; 0xfffffe6c
     948:	0000530b 	andeq	r5, r0, fp, lsl #6
     94c:	74910200 	ldrvc	r0, [r1], #512	; 0x200
     950:	7469620a 	strbtvc	r6, [r9], #-522	; 0xfffffdf6
     954:	53104d00 	tstpl	r0, #0, 26
     958:	02000000 	andeq	r0, r0, #0
     95c:	0f007091 	svceq	0x00007091
     960:	000002c8 	andeq	r0, r0, r8, asr #5
     964:	04820641 	streq	r0, [r2], #1601	; 0x641
     968:	855c0000 	ldrbhi	r0, [ip, #-0]
     96c:	00a00000 	adceq	r0, r0, r0
     970:	9c010000 	stcls	0, cr0, [r1], {-0}
     974:	000004c7 	andeq	r0, r0, r7, asr #9
     978:	0003f707 	andeq	pc, r3, r7, lsl #14
     97c:	00035d00 	andeq	r5, r3, r0, lsl #26
     980:	6c910200 	lfmvs	f0, 4, [r1], {0}
     984:	6e697003 	cdpvs	0, 6, cr7, cr9, cr3, {0}
     988:	53304100 	teqpl	r0, #0, 2
     98c:	02000000 	andeq	r0, r0, #0
     990:	b5066891 	strlt	r6, [r6, #-2193]	; 0xfffff76f
     994:	41000005 	tstmi	r0, r5
     998:	00018e44 	andeq	r8, r1, r4, asr #28
     99c:	67910200 	ldrvs	r0, [r1, r0, lsl #4]
     9a0:	6765720a 	strbvs	r7, [r5, -sl, lsl #4]!
     9a4:	530b4300 	movwpl	r4, #45824	; 0xb300
     9a8:	02000000 	andeq	r0, r0, #0
     9ac:	620a7491 	andvs	r7, sl, #-1862270976	; 0x91000000
     9b0:	43007469 	movwmi	r7, #1129	; 0x469
     9b4:	00005310 	andeq	r5, r0, r0, lsl r3
     9b8:	70910200 	addsvc	r0, r1, r0, lsl #4
     9bc:	02780c00 	rsbseq	r0, r8, #0, 24
     9c0:	df360000 	svcle	0x00360000
     9c4:	e8000004 	stmda	r0, {r2}
     9c8:	74000084 	strvc	r0, [r0], #-132	; 0xffffff7c
     9cc:	01000000 	mrseq	r0, (UNDEF: 0)
     9d0:	0005169c 	muleq	r5, ip, r6
     9d4:	03f70700 	mvnseq	r0, #0, 14
     9d8:	034d0000 	movteq	r0, #53248	; 0xd000
     9dc:	91020000 	mrsls	r0, (UNDEF: 2)
     9e0:	69700374 	ldmdbvs	r0!, {r2, r4, r5, r6, r8, r9}^
     9e4:	3136006e 	teqcc	r6, lr, rrx
     9e8:	00000053 	andeq	r0, r0, r3, asr r0
     9ec:	03709102 	cmneq	r0, #-2147483648	; 0x80000000
     9f0:	00676572 	rsbeq	r6, r7, r2, ror r5
     9f4:	03524036 	cmpeq	r2, #54	; 0x36
     9f8:	91020000 	mrsls	r0, (UNDEF: 2)
     9fc:	078d066c 	streq	r0, [sp, ip, ror #12]
     a00:	4f360000 	svcmi	0x00360000
     a04:	00000352 	andeq	r0, r0, r2, asr r3
     a08:	00689102 	rsbeq	r9, r8, r2, lsl #2
     a0c:	00024b0c 	andeq	r4, r2, ip, lsl #22
     a10:	052e2b00 	streq	r2, [lr, #-2816]!	; 0xfffff500
     a14:	84740000 	ldrbthi	r0, [r4], #-0
     a18:	00740000 	rsbseq	r0, r4, r0
     a1c:	9c010000 	stcls	0, cr0, [r1], {-0}
     a20:	00000565 	andeq	r0, r0, r5, ror #10
     a24:	0003f707 	andeq	pc, r3, r7, lsl #14
     a28:	00034d00 	andeq	r4, r3, r0, lsl #26
     a2c:	74910200 	ldrvc	r0, [r1], #512	; 0x200
     a30:	6e697003 	cdpvs	0, 6, cr7, cr9, cr3, {0}
     a34:	53312b00 	teqpl	r1, #0, 22
     a38:	02000000 	andeq	r0, r0, #0
     a3c:	72037091 	andvc	r7, r3, #145	; 0x91
     a40:	2b006765 	blcs	1a7dc <_bss_end+0x117d0>
     a44:	00035240 	andeq	r5, r3, r0, asr #4
     a48:	6c910200 	lfmvs	f0, 4, [r1], {0}
     a4c:	00078d06 	andeq	r8, r7, r6, lsl #26
     a50:	524f2b00 	subpl	r2, pc, #0, 22
     a54:	02000003 	andeq	r0, r0, #3
     a58:	0c006891 	stceq	8, cr6, [r0], {145}	; 0x91
     a5c:	0000021e 	andeq	r0, r0, lr, lsl r2
     a60:	00057d20 	andeq	r7, r5, r0, lsr #26
     a64:	00840000 	addeq	r0, r4, r0
     a68:	00007400 	andeq	r7, r0, r0, lsl #8
     a6c:	b49c0100 	ldrlt	r0, [ip], #256	; 0x100
     a70:	07000005 	streq	r0, [r0, -r5]
     a74:	000003f7 	strdeq	r0, [r0], -r7
     a78:	0000034d 	andeq	r0, r0, sp, asr #6
     a7c:	03749102 	cmneq	r4, #-2147483648	; 0x80000000
     a80:	006e6970 	rsbeq	r6, lr, r0, ror r9
     a84:	00533120 	subseq	r3, r3, r0, lsr #2
     a88:	91020000 	mrsls	r0, (UNDEF: 2)
     a8c:	65720370 	ldrbvs	r0, [r2, #-880]!	; 0xfffffc90
     a90:	40200067 	eormi	r0, r0, r7, rrx
     a94:	00000352 	andeq	r0, r0, r2, asr r3
     a98:	066c9102 	strbteq	r9, [ip], -r2, lsl #2
     a9c:	0000078d 	andeq	r0, r0, sp, lsl #15
     aa0:	03524f20 	cmpeq	r2, #32, 30	; 0x80
     aa4:	91020000 	mrsls	r0, (UNDEF: 2)
     aa8:	f10c0068 			; <UNDEFINED> instruction: 0xf10c0068
     aac:	0c000001 	stceq	0, cr0, [r0], {1}
     ab0:	000005cc 	andeq	r0, r0, ip, asr #11
     ab4:	000082ec 	andeq	r8, r0, ip, ror #5
     ab8:	00000114 	andeq	r0, r0, r4, lsl r1
     abc:	06039c01 	streq	r9, [r3], -r1, lsl #24
     ac0:	f7070000 			; <UNDEFINED> instruction: 0xf7070000
     ac4:	4d000003 	stcmi	0, cr0, [r0, #-12]
     ac8:	02000003 	andeq	r0, r0, #3
     acc:	70037491 	mulvc	r3, r1, r4
     ad0:	0c006e69 	stceq	14, cr6, [r0], {105}	; 0x69
     ad4:	00005332 	andeq	r5, r0, r2, lsr r3
     ad8:	70910200 	addsvc	r0, r1, r0, lsl #4
     adc:	67657203 	strbvs	r7, [r5, -r3, lsl #4]!
     ae0:	52410c00 	subpl	r0, r1, #0, 24
     ae4:	02000003 	andeq	r0, r0, #3
     ae8:	8d066c91 	stchi	12, cr6, [r6, #-580]	; 0xfffffdbc
     aec:	0c000007 	stceq	0, cr0, [r0], {7}
     af0:	00035250 	andeq	r5, r3, r0, asr r2
     af4:	68910200 	ldmvs	r1, {r9}
     af8:	02a52000 	adceq	r2, r5, #0
     afc:	06010000 	streq	r0, [r1], -r0
     b00:	00061401 	andeq	r1, r6, r1, lsl #8
     b04:	062a0000 	strteq	r0, [sl], -r0
     b08:	f7210000 			; <UNDEFINED> instruction: 0xf7210000
     b0c:	5d000003 	stcpl	0, cr0, [r0, #-12]
     b10:	22000003 	andcs	r0, r0, #3
     b14:	00000702 	andeq	r0, r0, r2, lsl #14
     b18:	622b0601 	eorvs	r0, fp, #1048576	; 0x100000
     b1c:	00000000 	andeq	r0, r0, r0
     b20:	00060323 	andeq	r0, r6, r3, lsr #6
     b24:	00062f00 	andeq	r2, r6, r0, lsl #30
     b28:	00064100 	andeq	r4, r6, r0, lsl #2
     b2c:	0082b800 	addeq	fp, r2, r0, lsl #16
     b30:	00003400 	andeq	r3, r0, r0, lsl #8
     b34:	129c0100 	addsne	r0, ip, #0, 2
     b38:	00000614 	andeq	r0, r0, r4, lsl r6
     b3c:	12749102 	rsbsne	r9, r4, #-2147483648	; 0x80000000
     b40:	0000061d 	andeq	r0, r0, sp, lsl r6
     b44:	00709102 	rsbseq	r9, r0, r2, lsl #2
     b48:	00052400 	andeq	r2, r5, r0, lsl #8
     b4c:	01000500 	tsteq	r0, r0, lsl #10
     b50:	00055504 	andeq	r5, r5, r4, lsl #10
     b54:	00a71600 	adceq	r1, r7, r0, lsl #12
     b58:	68210000 	stmdavs	r1!, {}	; <UNPREDICTABLE>
     b5c:	7a000008 	bvc	b84 <shift+0xb84>
     b60:	b8000000 	stmdalt	r0, {}	; <UNPREDICTABLE>
     b64:	e8000087 	stmda	r0, {r0, r1, r2, r7}
     b68:	c6000002 	strgt	r0, [r0], -r2
     b6c:	05000004 	streq	r0, [r0, #-4]
     b70:	03140801 	tsteq	r4, #65536	; 0x10000
     b74:	26060000 	strcs	r0, [r6], -r0
     b78:	05000000 	streq	r0, [r0, #-0]
     b7c:	01870502 	orreq	r0, r7, r2, lsl #10
     b80:	04170000 	ldreq	r0, [r7], #-0
     b84:	746e6905 	strbtvc	r6, [lr], #-2309	; 0xfffff6fb
     b88:	08010500 	stmdaeq	r1, {r8, sl}
     b8c:	0000030b 	andeq	r0, r0, fp, lsl #6
     b90:	75070205 	strvc	r0, [r7, #-517]	; 0xfffffdfb
     b94:	18000003 	stmdane	r0, {r0, r1}
     b98:	0000033e 	andeq	r0, r0, lr, lsr r3
     b9c:	5f070b05 	svcpl	0x00070b05
     ba0:	06000000 	streq	r0, [r0], -r0
     ba4:	0000004e 	andeq	r0, r0, lr, asr #32
     ba8:	0c070405 	cfstrseq	mvf0, [r7], {5}
     bac:	0600000e 	streq	r0, [r0], -lr
     bb0:	0000005f 	andeq	r0, r0, pc, asr r0
     bb4:	6c616819 	stclvs	8, cr6, [r1], #-100	; 0xffffff9c
     bb8:	0b070200 	bleq	1c13c0 <_bss_end+0x1b83b4>
     bbc:	0000016b 	andeq	r0, r0, fp, ror #2
     bc0:	0002cf0c 	andeq	ip, r2, ip, lsl #30
     bc4:	01720a00 	cmneq	r2, r0, lsl #20
     bc8:	00000000 	andeq	r0, r0, r0
     bcc:	270c2000 	strcs	r2, [ip, -r0]
     bd0:	0d000003 	stceq	0, cr0, [r0, #-12]
     bd4:	00000172 	andeq	r0, r0, r2, ror r1
     bd8:	20200000 	eorcs	r0, r0, r0
     bdc:	0003b31a 	andeq	fp, r3, sl, lsl r3
     be0:	15100200 	ldrne	r0, [r0, #-512]	; 0xfffffe00
     be4:	0000005a 	andeq	r0, r0, sl, asr r0
     be8:	04100c36 	ldreq	r0, [r0], #-3126	; 0xfffff3ca
     bec:	72420000 	subvc	r0, r2, #0
     bf0:	00000001 	andeq	r0, r0, r1
     bf4:	0d202150 	stfeqs	f2, [r0, #-320]!	; 0xfffffec0
     bf8:	000001ec 	andeq	r0, r0, ip, ror #3
     bfc:	00000039 	andeq	r0, r0, r9, lsr r0
     c00:	490d4402 	stmdbmi	sp, {r1, sl, lr}
     c04:	1b000001 	blne	c10 <shift+0xc10>
     c08:	00515249 	subseq	r5, r1, r9, asr #4
     c0c:	02290100 	eoreq	r0, r9, #0, 2
     c10:	01010000 	mrseq	r0, (UNDEF: 1)
     c14:	00000430 	andeq	r0, r0, r0, lsr r4
     c18:	03190110 	tsteq	r9, #16, 2
     c1c:	01110000 	tsteq	r1, r0
     c20:	0000035c 	andeq	r0, r0, ip, asr r3
     c24:	03900112 	orrseq	r0, r0, #-2147483644	; 0x80000004
     c28:	01130000 	tsteq	r3, r0
     c2c:	00000320 	andeq	r0, r0, r0, lsr #6
     c30:	043f0114 	ldrteq	r0, [pc], #-276	; c38 <shift+0xc38>
     c34:	01150000 	tsteq	r5, r0
     c38:	00000409 	andeq	r0, r0, r9, lsl #8
     c3c:	04770116 	ldrbteq	r0, [r7], #-278	; 0xfffffeea
     c40:	01170000 	tsteq	r7, r0
     c44:	00000363 	andeq	r0, r0, r3, ror #6
     c48:	04190118 	ldreq	r0, [r9], #-280	; 0xfffffee8
     c4c:	01190000 	tsteq	r9, r0
     c50:	000003a1 	andeq	r0, r0, r1, lsr #7
     c54:	02b9011a 	adcseq	r0, r9, #-2147483642	; 0x80000006
     c58:	01200000 			; <UNDEFINED> instruction: 0x01200000
     c5c:	000002c4 	andeq	r0, r0, r4, asr #5
     c60:	03a90121 			; <UNDEFINED> instruction: 0x03a90121
     c64:	01220000 			; <UNDEFINED> instruction: 0x01220000
     c68:	0000029d 	muleq	r0, sp, r2
     c6c:	03970124 	orrseq	r0, r7, #36, 2
     c70:	01250000 			; <UNDEFINED> instruction: 0x01250000
     c74:	000002ee 	andeq	r0, r0, lr, ror #5
     c78:	02f90130 	rscseq	r0, r9, #48, 2
     c7c:	01310000 	teqeq	r1, r0
     c80:	000001e1 	andeq	r0, r0, r1, ror #3
     c84:	03880132 	orreq	r0, r8, #-2147483636	; 0x8000000c
     c88:	01340000 	teqeq	r4, r0
     c8c:	000001d7 	ldrdeq	r0, [r0], -r7
     c90:	591c0035 	ldmdbpl	ip, {r0, r2, r4, r5}
     c94:	05000002 	streq	r0, [r0, #-2]
     c98:	00003904 	andeq	r3, r0, r4, lsl #18
     c9c:	0d6a0200 	sfmeq	f0, 2, [sl, #-0]
     ca0:	00043601 	andeq	r3, r4, r1, lsl #12
     ca4:	6b010000 	blvs	40cac <_bss_end+0x37ca0>
     ca8:	01000003 	tsteq	r0, r3
     cac:	00037001 	andeq	r7, r3, r1
     cb0:	00000200 	andeq	r0, r0, r0, lsl #4
     cb4:	07070405 	streq	r0, [r7, -r5, lsl #8]
     cb8:	0600000e 	streq	r0, [r0], -lr
     cbc:	0000016b 	andeq	r0, r0, fp, ror #2
     cc0:	00007708 	andeq	r7, r0, r8, lsl #14
     cc4:	00850800 	addeq	r0, r5, r0, lsl #16
     cc8:	93080000 	movwls	r0, #32768	; 0x8000
     ccc:	08000000 	stmdaeq	r0, {}	; <UNPREDICTABLE>
     cd0:	000000a0 	andeq	r0, r0, r0, lsr #1
     cd4:	00083b10 	andeq	r3, r8, r0, lsl fp
     cd8:	44060300 	strmi	r0, [r6], #-768	; 0xfffffd00
     cdc:	11000002 	tstne	r0, r2
     ce0:	000001eb 	andeq	r0, r0, fp, ror #3
     ce4:	491d0a03 	ldmdbmi	sp, {r0, r1, r9, fp}
     ce8:	12000002 	andne	r0, r0, #2
     cec:	0000083b 	andeq	r0, r0, fp, lsr r8
     cf0:	02690d03 	rsbeq	r0, r9, #3, 26	; 0xc0
     cf4:	024e0000 	subeq	r0, lr, #0
     cf8:	01b90000 			; <UNDEFINED> instruction: 0x01b90000
     cfc:	01c40000 	biceq	r0, r4, r0
     d00:	4e030000 	cdpmi	0, 0, cr0, cr3, cr0, {0}
     d04:	02000002 	andeq	r0, r0, #2
     d08:	0000005f 	andeq	r0, r0, pc, asr r0
     d0c:	03040700 	movweq	r0, #18176	; 0x4700
     d10:	10030000 	andne	r0, r3, r0
     d14:	00000231 	andeq	r0, r0, r1, lsr r2
     d18:	000001d7 	ldrdeq	r0, [r0], -r7
     d1c:	000001e2 	andeq	r0, r0, r2, ror #3
     d20:	00024e03 	andeq	r4, r2, r3, lsl #28
     d24:	01490200 	mrseq	r0, (UNDEF: 105)
     d28:	07000000 	streq	r0, [r0, -r0]
     d2c:	00000347 	andeq	r0, r0, r7, asr #6
     d30:	044e1203 	strbeq	r1, [lr], #-515	; 0xfffffdfd
     d34:	01f50000 	mvnseq	r0, r0
     d38:	02000000 	andeq	r0, r0, #0
     d3c:	4e030000 	cdpmi	0, 0, cr0, cr3, cr0, {0}
     d40:	02000002 	andeq	r0, r0, #2
     d44:	00000149 	andeq	r0, r0, r9, asr #2
     d48:	03fc0700 	mvnseq	r0, #0, 14
     d4c:	15030000 	strne	r0, [r3, #-0]
     d50:	00000276 	andeq	r0, r0, r6, ror r2
     d54:	00000213 	andeq	r0, r0, r3, lsl r2
     d58:	00000223 	andeq	r0, r0, r3, lsr #4
     d5c:	00024e03 	andeq	r4, r2, r3, lsl #28
     d60:	00ae0200 	adceq	r0, lr, r0, lsl #4
     d64:	4e020000 	cdpmi	0, 0, cr0, cr2, cr0, {0}
     d68:	00000000 	andeq	r0, r0, r0
     d6c:	00034f1d 	andeq	r4, r3, sp, lsl pc
     d70:	12170300 	andsne	r0, r7, #0, 6
     d74:	000001f4 	strdeq	r0, [r0], -r4
     d78:	0000004e 	andeq	r0, r0, lr, asr #32
     d7c:	00023801 	andeq	r3, r2, r1, lsl #16
     d80:	024e0300 	subeq	r0, lr, #0, 6
     d84:	ae020000 	cdpge	0, 0, cr0, cr2, cr0, {0}
     d88:	00000000 	andeq	r0, r0, r0
     d8c:	005f0900 	subseq	r0, pc, r0, lsl #18
     d90:	44060000 	strmi	r0, [r6], #-0
     d94:	09000002 	stmdbeq	r0, {r1}
     d98:	0000018b 	andeq	r0, r0, fp, lsl #3
     d9c:	0002b413 	andeq	fp, r2, r3, lsl r4
     da0:	0d1a0300 	ldceq	3, cr0, [sl, #-0]
     da4:	0000018b 	andeq	r0, r0, fp, lsl #3
     da8:	0009320d 	andeq	r3, r9, sp, lsl #4
     dac:	00003900 	andeq	r3, r0, r0, lsl #18
     db0:	0c060400 	cfstrseq	mvf0, [r6], {-0}
     db4:	0000027c 	andeq	r0, r0, ip, ror r2
     db8:	0008ab01 	andeq	sl, r8, r1, lsl #22
     dbc:	b2010000 	andlt	r0, r1, #0
     dc0:	01000008 	tsteq	r0, r8
     dc4:	09930d00 	ldmibeq	r3, {r8, sl, fp}
     dc8:	00390000 	eorseq	r0, r9, r0
     dcc:	0c040000 	stceq	0, cr0, [r4], {-0}
     dd0:	0002c70c 	andeq	ip, r2, ip, lsl #14
     dd4:	08e80400 	stmiaeq	r8!, {sl}^
     dd8:	04b00000 	ldrteq	r0, [r0], #0
     ddc:	0009a304 	andeq	sl, r9, r4, lsl #6
     de0:	04096000 	streq	r6, [r9], #-0
     de4:	00000962 	andeq	r0, r0, r2, ror #18
     de8:	400412c0 	andmi	r1, r4, r0, asr #5
     dec:	80000008 	andhi	r0, r0, r8
     df0:	09590425 	ldmdbeq	r9, {r0, r2, r5, sl}^
     df4:	4b000000 	blmi	dfc <shift+0xdfc>
     df8:	00082404 	andeq	r2, r8, r4, lsl #8
     dfc:	04960000 	ldreq	r0, [r6], #0
     e00:	0000084e 	andeq	r0, r0, lr, asr #16
     e04:	1a1ee100 	bne	7b920c <_bss_end+0x7b0200>
     e08:	00000008 	andeq	r0, r0, r8
     e0c:	000001c2 	andeq	r0, r0, r2, asr #3
     e10:	00084810 	andeq	r4, r8, r0, lsl r8
     e14:	77180400 	ldrvc	r0, [r8, -r0, lsl #8]
     e18:	11000003 	tstne	r0, r3
     e1c:	000008b9 			; <UNDEFINED> instruction: 0x000008b9
     e20:	770f1b04 	strvc	r1, [pc, -r4, lsl #22]
     e24:	12000003 	andne	r0, r0, #3
     e28:	00000848 	andeq	r0, r0, r8, asr #16
     e2c:	09021e04 	stmdbeq	r2, {r2, r9, sl, fp, ip}
     e30:	037d0000 	cmneq	sp, #0
     e34:	02f50000 	rscseq	r0, r5, #0
     e38:	03000000 	movweq	r0, #0
     e3c:	7d030000 	stcvc	0, cr0, [r3, #-0]
     e40:	02000003 	andeq	r0, r0, #3
     e44:	00000377 	andeq	r0, r0, r7, ror r3
     e48:	09440700 	stmdbeq	r4, {r8, r9, sl}^
     e4c:	20040000 	andcs	r0, r4, r0
     e50:	00000915 	andeq	r0, r0, r5, lsl r9
     e54:	00000313 	andeq	r0, r0, r3, lsl r3
     e58:	0000031e 	andeq	r0, r0, lr, lsl r3
     e5c:	00037d03 	andeq	r7, r3, r3, lsl #26
     e60:	025f0200 	subseq	r0, pc, #0, 4
     e64:	07000000 	streq	r0, [r0, -r0]
     e68:	0000096a 	andeq	r0, r0, sl, ror #18
     e6c:	09782104 	ldmdbeq	r8!, {r2, r8, sp}^
     e70:	03310000 	teqeq	r1, #0
     e74:	033c0000 	teqeq	ip, #0
     e78:	7d030000 	stcvc	0, cr0, [r3, #-0]
     e7c:	02000003 	andeq	r0, r0, #3
     e80:	0000027c 	andeq	r0, r0, ip, ror r2
     e84:	08620700 	stmdaeq	r2!, {r8, r9, sl}^
     e88:	25040000 	strcs	r0, [r4, #-0]
     e8c:	000008f0 	strdeq	r0, [r0], -r0	; <UNPREDICTABLE>
     e90:	0000034f 	andeq	r0, r0, pc, asr #6
     e94:	0000035a 	andeq	r0, r0, sl, asr r3
     e98:	00037d03 	andeq	r7, r3, r3, lsl #26
     e9c:	00260200 	eoreq	r0, r6, r0, lsl #4
     ea0:	1f000000 	svcne	0x00000000
     ea4:	00000862 	andeq	r0, r0, r2, ror #16
     ea8:	d40e2604 	strle	r2, [lr], #-1540	; 0xfffff9fc
     eac:	01000008 	tsteq	r0, r8
     eb0:	0000036b 	andeq	r0, r0, fp, ror #6
     eb4:	00037d03 	andeq	r7, r3, r3, lsl #26
     eb8:	03870200 	orreq	r0, r7, #0, 4
     ebc:	00000000 	andeq	r0, r0, r0
     ec0:	018b0420 	orreq	r0, fp, r0, lsr #8
     ec4:	c7090000 	strgt	r0, [r9, -r0]
     ec8:	06000002 	streq	r0, [r0], -r2
     ecc:	0000037d 	andeq	r0, r0, sp, ror r3
     ed0:	00002d09 	andeq	r2, r0, r9, lsl #26
     ed4:	08cd1300 	stmiaeq	sp, {r8, r9, ip}^
     ed8:	29040000 	stmdbcs	r4, {}	; <UNPREDICTABLE>
     edc:	0002c70e 	andeq	ip, r2, lr, lsl #14
     ee0:	038c2100 	orreq	r2, ip, #0, 2
     ee4:	04010000 	streq	r0, [r1], #-0
     ee8:	f8030507 			; <UNDEFINED> instruction: 0xf8030507
     eec:	2200008f 	andcs	r0, r0, #143	; 0x8f
     ef0:	000008be 			; <UNDEFINED> instruction: 0x000008be
     ef4:	00008a84 	andeq	r8, r0, r4, lsl #21
     ef8:	0000001c 	andeq	r0, r0, ip, lsl r0
     efc:	c2239c01 	eorgt	r9, r3, #256	; 0x100
     f00:	30000003 	andcc	r0, r0, r3
     f04:	5400008a 	strpl	r0, [r0], #-138	; 0xffffff76
     f08:	01000000 	mrseq	r0, (UNDEF: 0)
     f0c:	0003e59c 	muleq	r3, ip, r5
     f10:	02df0e00 	sbcseq	r0, pc, #0, 28
     f14:	01310000 	teqeq	r1, r0
     f18:	00000039 	andeq	r0, r0, r9, lsr r0
     f1c:	0e749102 	expeqs	f1, f2
     f20:	000003ec 	andeq	r0, r0, ip, ror #7
     f24:	00390131 	eorseq	r0, r9, r1, lsr r1
     f28:	91020000 	mrsls	r0, (UNDEF: 2)
     f2c:	5a0a0070 	bpl	2810f4 <_bss_end+0x2780e8>
     f30:	2b000003 	blcs	f44 <shift+0xf44>
     f34:	000003fd 	strdeq	r0, [r0], -sp
     f38:	000089c0 	andeq	r8, r0, r0, asr #19
     f3c:	00000070 	andeq	r0, r0, r0, ror r0
     f40:	04249c01 	strteq	r9, [r4], #-3073	; 0xfffff3ff
     f44:	f70b0000 			; <UNDEFINED> instruction: 0xf70b0000
     f48:	82000003 	andhi	r0, r0, #3
     f4c:	02000003 	andeq	r0, r0, #3
     f50:	730f6c91 	movwvc	r6, #64657	; 0xfc91
     f54:	2b007274 	blcs	1d92c <_bss_end+0x14920>
     f58:	0003871f 	andeq	r8, r3, pc, lsl r7
     f5c:	68910200 	ldmvs	r1, {r9}
     f60:	2d006914 	vstrcs.16	s12, [r0, #-40]	; 0xffffffd8	; <UNPREDICTABLE>
     f64:	00003909 	andeq	r3, r0, r9, lsl #18
     f68:	74910200 	ldrvc	r0, [r1], #512	; 0x200
     f6c:	033c0a00 	teqeq	ip, #0, 20
     f70:	3c220000 	stccc	0, cr0, [r2], #-0
     f74:	4c000004 	stcmi	0, cr0, [r0], {4}
     f78:	74000089 	strvc	r0, [r0], #-137	; 0xffffff77
     f7c:	01000000 	mrseq	r0, (UNDEF: 0)
     f80:	0004559c 	muleq	r4, ip, r5
     f84:	03f70b00 	mvnseq	r0, #0, 22
     f88:	03820000 	orreq	r0, r2, #0
     f8c:	91020000 	mrsls	r0, (UNDEF: 2)
     f90:	00630f74 	rsbeq	r0, r3, r4, ror pc
     f94:	00261822 	eoreq	r1, r6, r2, lsr #16
     f98:	91020000 	mrsls	r0, (UNDEF: 2)
     f9c:	1e0a0073 	mcrne	0, 0, r0, cr10, cr3, {3}
     fa0:	16000003 	strne	r0, [r0], -r3
     fa4:	0000046d 	andeq	r0, r0, sp, ror #8
     fa8:	000088b8 			; <UNDEFINED> instruction: 0x000088b8
     fac:	00000094 	muleq	r0, r4, r0
     fb0:	04a59c01 	strteq	r9, [r5], #3073	; 0xc01
     fb4:	f70b0000 			; <UNDEFINED> instruction: 0xf70b0000
     fb8:	82000003 	andhi	r0, r0, #3
     fbc:	02000003 	andeq	r0, r0, #3
     fc0:	540e6c91 	strpl	r6, [lr], #-3217	; 0xfffff36f
     fc4:	16000009 	strne	r0, [r0], -r9
     fc8:	00027c2b 	andeq	r7, r2, fp, lsr #24
     fcc:	68910200 	ldmvs	r1, {r9}
     fd0:	00085724 	andeq	r5, r8, r4, lsr #14
     fd4:	1c180100 	ldfnes	f0, [r8], {-0}
     fd8:	00000066 	andeq	r0, r0, r6, rrx
     fdc:	14749102 	ldrbtne	r9, [r4], #-258	; 0xfffffefe
     fe0:	006c6176 	rsbeq	r6, ip, r6, ror r1
     fe4:	00661819 	rsbeq	r1, r6, r9, lsl r8
     fe8:	91020000 	mrsls	r0, (UNDEF: 2)
     fec:	000a0070 	andeq	r0, sl, r0, ror r0
     ff0:	11000003 	tstne	r0, r3
     ff4:	000004bd 			; <UNDEFINED> instruction: 0x000004bd
     ff8:	0000885c 	andeq	r8, r0, ip, asr r8
     ffc:	0000005c 	andeq	r0, r0, ip, asr r0
    1000:	04d89c01 	ldrbeq	r9, [r8], #3073	; 0xc01
    1004:	f70b0000 			; <UNDEFINED> instruction: 0xf70b0000
    1008:	82000003 	andhi	r0, r0, #3
    100c:	02000003 	andeq	r0, r0, #3
    1010:	6c0f6c91 	stcvs	12, cr6, [pc], {145}	; 0x91
    1014:	11006e65 	tstne	r0, r5, ror #28
    1018:	00025f2f 	andeq	r5, r2, pc, lsr #30
    101c:	68910200 	ldmvs	r1, {r9}
    1020:	02de2500 	sbcseq	r2, lr, #0, 10
    1024:	06010000 	streq	r0, [r1], -r0
    1028:	0004e901 	andeq	lr, r4, r1, lsl #18
    102c:	04ff0000 	ldrbteq	r0, [pc], #0	; 1034 <shift+0x1034>
    1030:	f7260000 			; <UNDEFINED> instruction: 0xf7260000
    1034:	82000003 	andhi	r0, r0, #3
    1038:	27000003 	strcs	r0, [r0, -r3]
    103c:	00787561 	rsbseq	r7, r8, r1, ror #10
    1040:	77140601 	ldrvc	r0, [r4, -r1, lsl #12]
    1044:	00000003 	andeq	r0, r0, r3
    1048:	0004d828 	andeq	sp, r4, r8, lsr #16
    104c:	00082d00 	andeq	r2, r8, r0, lsl #26
    1050:	00051600 	andeq	r1, r5, r0, lsl #12
    1054:	0087b800 	addeq	fp, r7, r0, lsl #16
    1058:	0000a400 	andeq	sl, r0, r0, lsl #8
    105c:	159c0100 	ldrne	r0, [ip, #256]	; 0x100
    1060:	000004e9 	andeq	r0, r0, r9, ror #9
    1064:	15749102 	ldrbne	r9, [r4, #-258]!	; 0xfffffefe
    1068:	000004f2 	strdeq	r0, [r0], -r2
    106c:	00709102 	rsbseq	r9, r0, r2, lsl #2
    1070:	00059e00 	andeq	r9, r5, r0, lsl #28
    1074:	01000500 	tsteq	r0, r0, lsl #10
    1078:	0007d904 	andeq	sp, r7, r4, lsl #18
    107c:	00a71300 	adceq	r1, r7, r0, lsl #6
    1080:	c0210000 	eorgt	r0, r1, r0
    1084:	7a000009 	bvc	10b0 <shift+0x10b0>
    1088:	a0000000 	andge	r0, r0, r0
    108c:	f400008a 	vst4.32	{d0-d3}, [r0], sl
    1090:	c4000000 	strgt	r0, [r0], #-0
    1094:	05000006 	streq	r0, [r0, #-6]
    1098:	03140801 	tsteq	r4, #65536	; 0x10000
    109c:	26090000 	strcs	r0, [r9], -r0
    10a0:	05000000 	streq	r0, [r0, #-0]
    10a4:	01870502 	orreq	r0, r7, r2, lsl #10
    10a8:	04140000 	ldreq	r0, [r4], #-0
    10ac:	746e6905 	strbtvc	r6, [lr], #-2309	; 0xfffff6fb
    10b0:	05870f00 	streq	r0, [r7, #3840]	; 0xf00
    10b4:	4a090000 	bmi	2410bc <_bss_end+0x2380b0>
    10b8:	05000000 	streq	r0, [r0, #-0]
    10bc:	030b0801 	movweq	r0, #47105	; 0xb801
    10c0:	02050000 	andeq	r0, r5, #0
    10c4:	00037507 	andeq	r7, r3, r7, lsl #10
    10c8:	033e0f00 	teqeq	lr, #0, 30
    10cc:	670b0000 	strvs	r0, [fp, -r0]
    10d0:	09000000 	stmdbeq	r0, {}	; <UNPREDICTABLE>
    10d4:	00000058 	andeq	r0, r0, r8, asr r0
    10d8:	0c070405 	cfstrseq	mvf0, [r7], {5}
    10dc:	1500000e 	strne	r0, [r0, #-14]
    10e0:	00000067 	andeq	r0, r0, r7, rrx
    10e4:	00075e0a 	andeq	r5, r7, sl, lsl #28
    10e8:	40010700 	andmi	r0, r1, r0, lsl #14
    10ec:	03000000 	movweq	r0, #0
    10f0:	00bc0c06 	adcseq	r0, ip, r6, lsl #24
    10f4:	d7010000 	strle	r0, [r1, -r0]
    10f8:	00000007 	andeq	r0, r0, r7
    10fc:	0007e801 	andeq	lr, r7, r1, lsl #16
    1100:	0d010100 	stfeqs	f0, [r1, #-0]
    1104:	02000008 	andeq	r0, r0, #8
    1108:	00080701 	andeq	r0, r8, r1, lsl #14
    110c:	ef010300 	svc	0x00010300
    1110:	04000007 	streq	r0, [r0], #-7
    1114:	0007f501 	andeq	pc, r7, r1, lsl #10
    1118:	fb010500 	blx	42522 <_bss_end+0x39516>
    111c:	06000007 	streq	r0, [r0], -r7
    1120:	00080101 	andeq	r0, r8, r1, lsl #2
    1124:	a2010700 	andge	r0, r1, #0, 14
    1128:	08000005 	stmdaeq	r0, {r0, r2}
    112c:	05cc0c00 	strbeq	r0, [ip, #3072]	; 0xc00
    1130:	1a030000 	bne	c1138 <_bss_end+0xb812c>
    1134:	00000218 	andeq	r0, r0, r8, lsl r2
    1138:	00056a0d 	andeq	r6, r5, sp, lsl #20
    113c:	171e0300 	ldrne	r0, [lr, -r0, lsl #6]
    1140:	00000222 	andeq	r0, r0, r2, lsr #4
    1144:	00071804 	andeq	r1, r7, r4, lsl #16
    1148:	08220300 	stmdaeq	r2!, {r8, r9}
    114c:	0000053a 	andeq	r0, r0, sl, lsr r5
    1150:	00000227 	andeq	r0, r0, r7, lsr #4
    1154:	0000ec02 	andeq	lr, r0, r2, lsl #24
    1158:	00010100 	andeq	r0, r1, r0, lsl #2
    115c:	022e0300 	eoreq	r0, lr, #0, 6
    1160:	58020000 	stmdapl	r2, {}	; <UNPREDICTABLE>
    1164:	02000000 	andeq	r0, r0, #0
    1168:	00000233 	andeq	r0, r0, r3, lsr r2
    116c:	00023302 	andeq	r3, r2, r2, lsl #6
    1170:	c4040000 	strgt	r0, [r4], #-0
    1174:	03000007 	movweq	r0, #7
    1178:	06990824 	ldreq	r0, [r9], r4, lsr #16
    117c:	02270000 	eoreq	r0, r7, #0
    1180:	1a020000 	bne	81188 <_bss_end+0x7817c>
    1184:	2f000001 	svccs	0x00000001
    1188:	03000001 	movweq	r0, #1
    118c:	0000022e 	andeq	r0, r0, lr, lsr #4
    1190:	00005802 	andeq	r5, r0, r2, lsl #16
    1194:	02330200 	eorseq	r0, r3, #0, 4
    1198:	33020000 	movwcc	r0, #8192	; 0x2000
    119c:	00000002 	andeq	r0, r0, r2
    11a0:	0005da04 	andeq	sp, r5, r4, lsl #20
    11a4:	08260300 	stmdaeq	r6!, {r8, r9}
    11a8:	00000795 	muleq	r0, r5, r7
    11ac:	00000227 	andeq	r0, r0, r7, lsr #4
    11b0:	00014802 	andeq	r4, r1, r2, lsl #16
    11b4:	00015d00 	andeq	r5, r1, r0, lsl #26
    11b8:	022e0300 	eoreq	r0, lr, #0, 6
    11bc:	58020000 	stmdapl	r2, {}	; <UNPREDICTABLE>
    11c0:	02000000 	andeq	r0, r0, #0
    11c4:	00000233 	andeq	r0, r0, r3, lsr r2
    11c8:	00023302 	andeq	r3, r2, r2, lsl #6
    11cc:	f3040000 	vhadd.u8	d0, d4, d0
    11d0:	03000005 	movweq	r0, #5
    11d4:	04820828 	streq	r0, [r2], #2088	; 0x828
    11d8:	02270000 	eoreq	r0, r7, #0
    11dc:	76020000 	strvc	r0, [r2], -r0
    11e0:	8b000001 	blhi	11ec <shift+0x11ec>
    11e4:	03000001 	movweq	r0, #1
    11e8:	0000022e 	andeq	r0, r0, lr, lsr #4
    11ec:	00005802 	andeq	r5, r0, r2, lsl #16
    11f0:	02330200 	eorseq	r0, r3, #0, 4
    11f4:	33020000 	movwcc	r0, #8192	; 0x2000
    11f8:	00000002 	andeq	r0, r0, r2
    11fc:	0005cc04 	andeq	ip, r5, r4, lsl #24
    1200:	032b0300 			; <UNDEFINED> instruction: 0x032b0300
    1204:	00000570 	andeq	r0, r0, r0, ror r5
    1208:	00000238 	andeq	r0, r0, r8, lsr r2
    120c:	0001a401 	andeq	sl, r1, r1, lsl #8
    1210:	0001af00 	andeq	sl, r1, r0, lsl #30
    1214:	02380300 	eorseq	r0, r8, #0, 6
    1218:	67020000 	strvs	r0, [r2, -r0]
    121c:	00000000 	andeq	r0, r0, r0
    1220:	00077b06 	andeq	r7, r7, r6, lsl #22
    1224:	082e0300 	stmdaeq	lr!, {r8, r9}
    1228:	00000735 	andeq	r0, r0, r5, lsr r7
    122c:	000001c3 	andeq	r0, r0, r3, asr #3
    1230:	000001d3 	ldrdeq	r0, [r0], -r3
    1234:	00023803 	andeq	r3, r2, r3, lsl #16
    1238:	00580200 	subseq	r0, r8, r0, lsl #4
    123c:	73020000 	movwvc	r0, #8192	; 0x2000
    1240:	00000000 	andeq	r0, r0, r0
    1244:	0005ba04 	andeq	fp, r5, r4, lsl #20
    1248:	12300300 	eorsne	r0, r0, #0, 6
    124c:	00000606 	andeq	r0, r0, r6, lsl #12
    1250:	00000073 	andeq	r0, r0, r3, ror r0
    1254:	0001ec01 	andeq	lr, r1, r1, lsl #24
    1258:	0001f700 	andeq	pc, r1, r0, lsl #14
    125c:	022e0300 	eoreq	r0, lr, #0, 6
    1260:	58020000 	stmdapl	r2, {}	; <UNPREDICTABLE>
    1264:	00000000 	andeq	r0, r0, r0
    1268:	0007e410 	andeq	lr, r7, r0, lsl r4
    126c:	08330300 	ldmdaeq	r3!, {r8, r9}
    1270:	00000518 	andeq	r0, r0, r8, lsl r5
    1274:	00000207 	andeq	r0, r0, r7, lsl #4
    1278:	00023803 	andeq	r3, r2, r3, lsl #16
    127c:	00580200 	subseq	r0, r8, r0, lsl #4
    1280:	27020000 	strcs	r0, [r2, -r0]
    1284:	00000002 	andeq	r0, r0, r2
    1288:	00bc0900 	adcseq	r0, ip, r0, lsl #18
    128c:	67080000 	strvs	r0, [r8, -r0]
    1290:	09000000 	stmdbeq	r0, {}	; <UNPREDICTABLE>
    1294:	0000021d 	andeq	r0, r0, sp, lsl r2
    1298:	9d020105 	stflss	f0, [r2, #-20]	; 0xffffffec
    129c:	08000005 	stmdaeq	r0, {r0, r2}
    12a0:	00000218 	andeq	r0, r0, r8, lsl r2
    12a4:	00005811 	andeq	r5, r0, r1, lsl r8
    12a8:	00bc0800 	adcseq	r0, ip, r0, lsl #16
    12ac:	d7120000 	ldrle	r0, [r2, -r0]
    12b0:	03000006 	movweq	r0, #6
    12b4:	00bc1637 	adcseq	r1, ip, r7, lsr r6
    12b8:	68160000 	ldmdavs	r6, {}	; <UNPREDICTABLE>
    12bc:	04006c61 	streq	r6, [r0], #-3169	; 0xfffff39f
    12c0:	034b0b07 	movteq	r0, #47879	; 0xbb07
    12c4:	cf0e0000 	svcgt	0x000e0000
    12c8:	0a000002 	beq	12d8 <shift+0x12d8>
    12cc:	00000352 	andeq	r0, r0, r2, asr r3
    12d0:	20000000 	andcs	r0, r0, r0
    12d4:	0003270e 	andeq	r2, r3, lr, lsl #14
    12d8:	03520d00 	cmpeq	r2, #0, 26
    12dc:	00000000 	andeq	r0, r0, r0
    12e0:	b3172020 	tstlt	r7, #32
    12e4:	04000003 	streq	r0, [r0], #-3
    12e8:	00621510 	rsbeq	r1, r2, r0, lsl r5
    12ec:	0e360000 	cdpeq	0, 3, cr0, cr6, cr0, {0}
    12f0:	00000410 	andeq	r0, r0, r0, lsl r4
    12f4:	00035242 	andeq	r5, r3, r2, asr #4
    12f8:	21500000 	cmpcs	r0, r0
    12fc:	01ec0a20 	mvneq	r0, r0, lsr #20
    1300:	04050000 	streq	r0, [r5], #-0
    1304:	00000039 	andeq	r0, r0, r9, lsr r0
    1308:	290d4404 	stmdbcs	sp, {r2, sl, lr}
    130c:	18000003 	stmdane	r0, {r0, r1}
    1310:	00515249 	subseq	r5, r1, r9, asr #4
    1314:	02290100 	eoreq	r0, r9, #0, 2
    1318:	01010000 	mrseq	r0, (UNDEF: 1)
    131c:	00000430 	andeq	r0, r0, r0, lsr r4
    1320:	03190110 	tsteq	r9, #16, 2
    1324:	01110000 	tsteq	r1, r0
    1328:	0000035c 	andeq	r0, r0, ip, asr r3
    132c:	03900112 	orrseq	r0, r0, #-2147483644	; 0x80000004
    1330:	01130000 	tsteq	r3, r0
    1334:	00000320 	andeq	r0, r0, r0, lsr #6
    1338:	043f0114 	ldrteq	r0, [pc], #-276	; 1340 <shift+0x1340>
    133c:	01150000 	tsteq	r5, r0
    1340:	00000409 	andeq	r0, r0, r9, lsl #8
    1344:	04770116 	ldrbteq	r0, [r7], #-278	; 0xfffffeea
    1348:	01170000 	tsteq	r7, r0
    134c:	00000363 	andeq	r0, r0, r3, ror #6
    1350:	04190118 	ldreq	r0, [r9], #-280	; 0xfffffee8
    1354:	01190000 	tsteq	r9, r0
    1358:	000003a1 	andeq	r0, r0, r1, lsr #7
    135c:	02b9011a 	adcseq	r0, r9, #-2147483642	; 0x80000006
    1360:	01200000 			; <UNDEFINED> instruction: 0x01200000
    1364:	000002c4 	andeq	r0, r0, r4, asr #5
    1368:	03a90121 			; <UNDEFINED> instruction: 0x03a90121
    136c:	01220000 			; <UNDEFINED> instruction: 0x01220000
    1370:	0000029d 	muleq	r0, sp, r2
    1374:	03970124 	orrseq	r0, r7, #36, 2
    1378:	01250000 			; <UNDEFINED> instruction: 0x01250000
    137c:	000002ee 	andeq	r0, r0, lr, ror #5
    1380:	02f90130 	rscseq	r0, r9, #48, 2
    1384:	01310000 	teqeq	r1, r0
    1388:	000001e1 	andeq	r0, r0, r1, ror #3
    138c:	03880132 	orreq	r0, r8, #-2147483636	; 0x8000000c
    1390:	01340000 	teqeq	r4, r0
    1394:	000001d7 	ldrdeq	r0, [r0], -r7
    1398:	59190035 	ldmdbpl	r9, {r0, r2, r4, r5}
    139c:	05000002 	streq	r0, [r0, #-2]
    13a0:	00003904 	andeq	r3, r0, r4, lsl #18
    13a4:	0d6a0400 	cfstrdeq	mvd0, [sl, #-0]
    13a8:	00043601 	andeq	r3, r4, r1, lsl #12
    13ac:	6b010000 	blvs	413b4 <_bss_end+0x383a8>
    13b0:	01000003 	tsteq	r0, r3
    13b4:	00037001 	andeq	r7, r3, r1
    13b8:	00000200 	andeq	r0, r0, r0, lsl #4
    13bc:	07070405 	streq	r0, [r7, -r5, lsl #8]
    13c0:	0900000e 	stmdbeq	r0, {r1, r2, r3}
    13c4:	0000034b 	andeq	r0, r0, fp, asr #6
    13c8:	0002550b 	andeq	r5, r2, fp, lsl #10
    13cc:	02630b00 	rsbeq	r0, r3, #0, 22
    13d0:	710b0000 	mrsvc	r0, (UNDEF: 11)
    13d4:	0b000002 	bleq	13e4 <shift+0x13e4>
    13d8:	0000027e 	andeq	r0, r0, lr, ror r2
    13dc:	00083b0c 	andeq	r3, r8, ip, lsl #22
    13e0:	29060500 	stmdbcs	r6, {r8, sl}
    13e4:	0d000004 	stceq	0, cr0, [r0, #-16]
    13e8:	000001eb 	andeq	r0, r0, fp, ror #3
    13ec:	221d0a05 	andscs	r0, sp, #20480	; 0x5000
    13f0:	04000002 	streq	r0, [r0], #-2
    13f4:	0000083b 	andeq	r0, r0, fp, lsr r8
    13f8:	69090d05 	stmdbvs	r9, {r0, r2, r8, sl, fp}
    13fc:	29000002 	stmdbcs	r0, {r1}
    1400:	01000004 	tsteq	r0, r4
    1404:	0000039b 	muleq	r0, fp, r3
    1408:	000003a6 	andeq	r0, r0, r6, lsr #7
    140c:	00042903 	andeq	r2, r4, r3, lsl #18
    1410:	00670200 	rsbeq	r0, r7, r0, lsl #4
    1414:	06000000 	streq	r0, [r0], -r0
    1418:	00000304 	andeq	r0, r0, r4, lsl #6
    141c:	310e1005 	tstcc	lr, r5
    1420:	ba000002 	blt	1430 <shift+0x1430>
    1424:	c5000003 	strgt	r0, [r0, #-3]
    1428:	03000003 	movweq	r0, #3
    142c:	00000429 	andeq	r0, r0, r9, lsr #8
    1430:	00032902 	andeq	r2, r3, r2, lsl #18
    1434:	47060000 	strmi	r0, [r6, -r0]
    1438:	05000003 	streq	r0, [r0, #-3]
    143c:	044e0e12 	strbeq	r0, [lr], #-3602	; 0xfffff1ee
    1440:	03d90000 	bicseq	r0, r9, #0
    1444:	03e40000 	mvneq	r0, #0
    1448:	29030000 	stmdbcs	r3, {}	; <UNPREDICTABLE>
    144c:	02000004 	andeq	r0, r0, #4
    1450:	00000329 	andeq	r0, r0, r9, lsr #6
    1454:	03fc0600 	mvnseq	r0, #0, 12
    1458:	15050000 	strne	r0, [r5, #-0]
    145c:	0002760e 	andeq	r7, r2, lr, lsl #12
    1460:	0003f800 	andeq	pc, r3, r0, lsl #16
    1464:	00040800 	andeq	r0, r4, r0, lsl #16
    1468:	04290300 	strteq	r0, [r9], #-768	; 0xfffffd00
    146c:	8c020000 	stchi	0, cr0, [r2], {-0}
    1470:	02000002 	andeq	r0, r0, #2
    1474:	00000058 	andeq	r0, r0, r8, asr r0
    1478:	034f1a00 	movteq	r1, #64000	; 0xfa00
    147c:	17050000 	strne	r0, [r5, -r0]
    1480:	0001f412 	andeq	pc, r1, r2, lsl r4	; <UNPREDICTABLE>
    1484:	00005800 	andeq	r5, r0, r0, lsl #16
    1488:	041d0100 	ldreq	r0, [sp], #-256	; 0xffffff00
    148c:	29030000 	stmdbcs	r3, {}	; <UNPREDICTABLE>
    1490:	02000004 	andeq	r0, r0, #4
    1494:	0000028c 	andeq	r0, r0, ip, lsl #5
    1498:	6b080000 	blvs	2014a0 <_bss_end+0x1f8494>
    149c:	0a000003 	beq	14b0 <shift+0x14b0>
    14a0:	00000932 	andeq	r0, r0, r2, lsr r9
    14a4:	00390405 	eorseq	r0, r9, r5, lsl #8
    14a8:	06060000 	streq	r0, [r6], -r0
    14ac:	00044d0c 	andeq	r4, r4, ip, lsl #26
    14b0:	08ab0100 	stmiaeq	fp!, {r8}
    14b4:	01000000 	mrseq	r0, (UNDEF: 0)
    14b8:	000008b2 			; <UNDEFINED> instruction: 0x000008b2
    14bc:	930a0001 	movwls	r0, #40961	; 0xa001
    14c0:	05000009 	streq	r0, [r0, #-9]
    14c4:	00003904 	andeq	r3, r0, r4, lsl #18
    14c8:	0c0c0600 	stceq	6, cr0, [ip], {-0}
    14cc:	0000049a 	muleq	r0, sl, r4
    14d0:	0008e807 	andeq	lr, r8, r7, lsl #16
    14d4:	0704b000 	streq	fp, [r4, -r0]
    14d8:	000009a3 	andeq	r0, r0, r3, lsr #19
    14dc:	62070960 	andvs	r0, r7, #96, 18	; 0x180000
    14e0:	c0000009 	andgt	r0, r0, r9
    14e4:	08400712 	stmdaeq	r0, {r1, r4, r8, r9, sl}^
    14e8:	25800000 	strcs	r0, [r0]
    14ec:	00095907 	andeq	r5, r9, r7, lsl #18
    14f0:	074b0000 	strbeq	r0, [fp, -r0]
    14f4:	00000824 	andeq	r0, r0, r4, lsr #16
    14f8:	4e079600 	cfmadd32mi	mvax0, mvfx9, mvfx7, mvfx0
    14fc:	00000008 	andeq	r0, r0, r8
    1500:	081a1be1 	ldmdaeq	sl, {r0, r5, r6, r7, r8, r9, fp, ip}
    1504:	c2000000 	andgt	r0, r0, #0
    1508:	0c000001 	stceq	0, cr0, [r0], {1}
    150c:	00000848 	andeq	r0, r0, r8, asr #16
    1510:	054e1806 	strbeq	r1, [lr, #-2054]	; 0xfffff7fa
    1514:	b90d0000 	stmdblt	sp, {}	; <UNPREDICTABLE>
    1518:	06000008 	streq	r0, [r0], -r8
    151c:	054e0f1b 	strbeq	r0, [lr, #-3867]	; 0xfffff0e5
    1520:	48040000 	stmdami	r4, {}	; <UNPREDICTABLE>
    1524:	06000008 	streq	r0, [r0], -r8
    1528:	0902091e 	stmdbeq	r2, {r1, r2, r3, r4, r8, fp}
    152c:	05530000 	ldrbeq	r0, [r3, #-0]
    1530:	ca010000 	bgt	41538 <_bss_end+0x3852c>
    1534:	d5000004 	strle	r0, [r0, #-4]
    1538:	03000004 	movweq	r0, #4
    153c:	00000553 	andeq	r0, r0, r3, asr r5
    1540:	00054e02 	andeq	r4, r5, r2, lsl #28
    1544:	44060000 	strmi	r0, [r6], #-0
    1548:	06000009 	streq	r0, [r0], -r9
    154c:	09150e20 	ldmdbeq	r5, {r5, r9, sl, fp}
    1550:	04e90000 	strbteq	r0, [r9], #0
    1554:	04f40000 	ldrbteq	r0, [r4], #0
    1558:	53030000 	movwpl	r0, #12288	; 0x3000
    155c:	02000005 	andeq	r0, r0, #5
    1560:	0000042e 	andeq	r0, r0, lr, lsr #8
    1564:	096a0600 	stmdbeq	sl!, {r9, sl}^
    1568:	21060000 	mrscs	r0, (UNDEF: 6)
    156c:	0009780e 	andeq	r7, r9, lr, lsl #16
    1570:	00050800 	andeq	r0, r5, r0, lsl #16
    1574:	00051300 	andeq	r1, r5, r0, lsl #6
    1578:	05530300 	ldrbeq	r0, [r3, #-768]	; 0xfffffd00
    157c:	4d020000 	stcmi	0, cr0, [r2, #-0]
    1580:	00000004 	andeq	r0, r0, r4
    1584:	00086206 	andeq	r6, r8, r6, lsl #4
    1588:	0e250600 	cfmadda32eq	mvax0, mvax0, mvfx5, mvfx0
    158c:	000008f0 	strdeq	r0, [r0], -r0	; <UNPREDICTABLE>
    1590:	00000527 	andeq	r0, r0, r7, lsr #10
    1594:	00000532 	andeq	r0, r0, r2, lsr r5
    1598:	00055303 	andeq	r5, r5, r3, lsl #6
    159c:	00260200 	eoreq	r0, r6, r0, lsl #4
    15a0:	10000000 	andne	r0, r0, r0
    15a4:	00000862 	andeq	r0, r0, r2, ror #16
    15a8:	d40e2606 	strle	r2, [lr], #-1542	; 0xfffff9fa
    15ac:	42000008 	andmi	r0, r0, #8
    15b0:	03000005 	movweq	r0, #5
    15b4:	00000553 	andeq	r0, r0, r3, asr r5
    15b8:	00055802 	andeq	r5, r5, r2, lsl #16
    15bc:	11000000 	mrsne	r0, (UNDEF: 0)
    15c0:	0000036b 	andeq	r0, r0, fp, ror #6
    15c4:	00049a08 	andeq	r9, r4, r8, lsl #20
    15c8:	002d0800 	eoreq	r0, sp, r0, lsl #16
    15cc:	cd120000 	ldcgt	0, cr0, [r2, #-0]
    15d0:	06000008 	streq	r0, [r0], -r8
    15d4:	049a0e29 	ldreq	r0, [sl], #3625	; 0xe29
    15d8:	ab1c0000 	blge	7015e0 <_bss_end+0x6f85d4>
    15dc:	01000009 	tsteq	r0, r9
    15e0:	00621405 	rsbeq	r1, r2, r5, lsl #8
    15e4:	03050000 	movweq	r0, #20480	; 0x5000
    15e8:	00008fbc 			; <UNDEFINED> instruction: 0x00008fbc
    15ec:	0009b31d 	andeq	fp, r9, sp, lsl r3
    15f0:	10070100 	andne	r0, r7, r0, lsl #2
    15f4:	00000039 	andeq	r0, r0, r9, lsr r0
    15f8:	00008aa0 	andeq	r8, r0, r0, lsr #21
    15fc:	000000f4 	strdeq	r0, [r0], -r4
    1600:	741e9c01 	ldrvc	r9, [lr], #-3073	; 0xfffff3ff
    1604:	01006d69 	tsteq	r0, r9, ror #26
    1608:	006e1813 	rsbeq	r1, lr, r3, lsl r8
    160c:	91020000 	mrsls	r0, (UNDEF: 2)
    1610:	20000074 	andcs	r0, r0, r4, ror r0
    1614:	05000000 	streq	r0, [r0, #-0]
    1618:	b3040100 	movwlt	r0, #16640	; 0x4100
    161c:	01000009 	tsteq	r0, r9
    1620:	00000831 	andeq	r0, r0, r1, lsr r8
    1624:	00008000 	andeq	r8, r0, r0
    1628:	0009fb18 	andeq	pc, r9, r8, lsl fp	; <UNPREDICTABLE>
    162c:	00007a00 	andeq	r7, r0, r0, lsl #20
    1630:	000a3500 	andeq	r3, sl, r0, lsl #10
    1634:	2e800100 	rmfcss	f0, f0, f0
    1638:	05000001 	streq	r0, [r0, #-1]
    163c:	c7040100 	strgt	r0, [r4, -r0, lsl #2]
    1640:	08000009 	stmdaeq	r0, {r0, r3}
    1644:	000000a7 	andeq	r0, r0, r7, lsr #1
    1648:	000aa821 	andeq	sl, sl, r1, lsr #16
    164c:	00007a00 	andeq	r7, r0, r0, lsl #20
    1650:	008b9400 	addeq	r9, fp, r0, lsl #8
    1654:	00011800 	andeq	r1, r1, r0, lsl #16
    1658:	00087d00 	andeq	r7, r8, r0, lsl #26
    165c:	0a410300 	beq	1042264 <_bss_end+0x1039258>
    1660:	30020000 	andcc	r0, r2, r0
    1664:	02000000 	andeq	r0, r0, #0
    1668:	00000035 	andeq	r0, r0, r5, lsr r0
    166c:	0afe0309 	beq	fff82298 <_bss_end+0xfff7928c>
    1670:	30030000 	andcc	r0, r3, r0
    1674:	01000000 	mrseq	r0, (UNDEF: 0)
    1678:	00000a4a 	andeq	r0, r0, sl, asr #20
    167c:	004b1006 	subeq	r1, fp, r6
    1680:	040a0000 	streq	r0, [sl], #-0
    1684:	746e6905 	strbtvc	r6, [lr], #-2309	; 0xfffff6fb
    1688:	0a910100 	beq	fe441a90 <_bss_end+0xfe438a84>
    168c:	10080000 	andne	r0, r8, r0
    1690:	0000004b 	andeq	r0, r0, fp, asr #32
    1694:	00002604 	andeq	r2, r0, r4, lsl #12
    1698:	00006c00 	andeq	r6, r0, r0, lsl #24
    169c:	006c0500 	rsbeq	r0, ip, r0, lsl #10
    16a0:	0b000000 	bleq	16a8 <shift+0x16a8>
    16a4:	0e0c0704 	cdpeq	7, 0, cr0, cr12, cr4, {0}
    16a8:	68010000 	stmdavs	r1, {}	; <UNPREDICTABLE>
    16ac:	0b00000a 	bleq	16dc <shift+0x16dc>
    16b0:	00005d15 	andeq	r5, r0, r5, lsl sp
    16b4:	0a5b0100 	beq	16c1abc <_bss_end+0x16b8ab0>
    16b8:	150d0000 	strne	r0, [sp, #-0]
    16bc:	0000005d 	andeq	r0, r0, sp, asr r0
    16c0:	00003604 	andeq	r3, r0, r4, lsl #12
    16c4:	00009800 	andeq	r9, r0, r0, lsl #16
    16c8:	006c0500 	rsbeq	r0, ip, r0, lsl #10
    16cc:	01000000 	mrseq	r0, (UNDEF: 0)
    16d0:	00000a9a 	muleq	r0, sl, sl
    16d4:	00891510 	addeq	r1, r9, r0, lsl r5
    16d8:	76010000 	strvc	r0, [r1], -r0
    16dc:	1200000a 	andne	r0, r0, #10
    16e0:	00008915 	andeq	r8, r0, r5, lsl r9
    16e4:	0a830600 	beq	fe0c2eec <_bss_end+0xfe0b9ee0>
    16e8:	4b2b0000 	blmi	ac16f0 <_bss_end+0xab86e4>
    16ec:	54000000 	strpl	r0, [r0], #-0
    16f0:	5800008c 	stmdapl	r0, {r2, r3, r7}
    16f4:	01000000 	mrseq	r0, (UNDEF: 0)
    16f8:	0000d49c 	muleq	r0, ip, r4
    16fc:	0a550700 	beq	1543304 <_bss_end+0x153a2f8>
    1700:	d42d0000 	strtle	r0, [sp], #-0
    1704:	02000000 	andeq	r0, r0, #0
    1708:	02007491 	andeq	r7, r0, #-1862270976	; 0x91000000
    170c:	00000036 	andeq	r0, r0, r6, lsr r0
    1710:	000af106 	andeq	pc, sl, r6, lsl #2
    1714:	004b1f00 	subeq	r1, fp, r0, lsl #30
    1718:	8bfc0000 	blhi	fff01720 <_bss_end+0xffef8714>
    171c:	00580000 	subseq	r0, r8, r0
    1720:	9c010000 	stcls	0, cr0, [r1], {-0}
    1724:	000000ff 	strdeq	r0, [r0], -pc	; <UNPREDICTABLE>
    1728:	000a5507 	andeq	r5, sl, r7, lsl #10
    172c:	00ff2100 	rscseq	r2, pc, r0, lsl #2
    1730:	91020000 	mrsls	r0, (UNDEF: 2)
    1734:	26020074 			; <UNDEFINED> instruction: 0x26020074
    1738:	0c000000 	stceq	0, cr0, [r0], {-0}
    173c:	00000ae6 	andeq	r0, r0, r6, ror #21
    1740:	4b101401 	blmi	40674c <_bss_end+0x3fd740>
    1744:	94000000 	strls	r0, [r0], #-0
    1748:	6800008b 	stmdavs	r0, {r0, r1, r3, r7}
    174c:	01000000 	mrseq	r0, (UNDEF: 0)
    1750:	00012c9c 	muleq	r1, ip, ip
    1754:	00690d00 	rsbeq	r0, r9, r0, lsl #26
    1758:	2c071601 	stccs	6, cr1, [r7], {1}
    175c:	02000001 	andeq	r0, r0, #1
    1760:	02007491 	andeq	r7, r0, #-1862270976	; 0x91000000
    1764:	0000004b 	andeq	r0, r0, fp, asr #32
    1768:	00002100 	andeq	r2, r0, r0, lsl #2
    176c:	01000500 	tsteq	r0, r0, lsl #10
    1770:	000a9804 	andeq	r9, sl, r4, lsl #16
    1774:	095f0100 	ldmdbeq	pc, {r8}^	; <UNPREDICTABLE>
    1778:	8cac0000 	stchi	0, cr0, [ip]
    177c:	048c0000 	streq	r0, [ip], #0
    1780:	00000b07 	andeq	r0, r0, r7, lsl #22
    1784:	00000b13 	andeq	r0, r0, r3, lsl fp
    1788:	00000b7a 	andeq	r0, r0, sl, ror fp
    178c:	00208001 	eoreq	r8, r0, r1
    1790:	00050000 	andeq	r0, r5, r0
    1794:	0aac0401 	beq	feb027a0 <_bss_end+0xfeaf9794>
    1798:	c6010000 	strgt	r0, [r1], -r0
    179c:	b8000009 	stmdalt	r0, {r0, r3}
    17a0:	0400008e 	streq	r0, [r0], #-142	; 0xffffff72
    17a4:	00000b07 	andeq	r0, r0, r7, lsl #22
    17a8:	00000b13 	andeq	r0, r0, r3, lsl fp
    17ac:	00000b7a 	andeq	r0, r0, sl, ror fp
    17b0:	03318001 	teqeq	r1, #1
    17b4:	00050000 	andeq	r0, r5, r0
    17b8:	0ac00401 	beq	ff0027c4 <_bss_end+0xfeff97b8>
    17bc:	70090000 	andvc	r0, r9, r0
    17c0:	1d000010 	stcne	0, cr0, [r0, #-64]	; 0xffffffc0
    17c4:	00000c58 	andeq	r0, r0, r8, asr ip
    17c8:	00000b13 	andeq	r0, r0, r3, lsl fp
    17cc:	00000a10 	andeq	r0, r0, r0, lsl sl
    17d0:	6905040a 	stmdbvs	r5, {r1, r3, sl}
    17d4:	0200746e 	andeq	r7, r0, #1845493760	; 0x6e000000
    17d8:	0e0c0704 	cdpeq	7, 0, cr0, cr12, cr4, {0}
    17dc:	08020000 	stmdaeq	r2, {}	; <UNPREDICTABLE>
    17e0:	00017905 	andeq	r7, r1, r5, lsl #18
    17e4:	04080200 	streq	r0, [r8], #-512	; 0xfffffe00
    17e8:	00000dda 	ldrdeq	r0, [r0], -sl
    17ec:	0b080102 	bleq	201bfc <_bss_end+0x1f8bf0>
    17f0:	02000003 	andeq	r0, r0, #3
    17f4:	030d0601 	movweq	r0, #54785	; 0xd601
    17f8:	a30b0000 	movwge	r0, #45056	; 0xb000
    17fc:	0700000f 	streq	r0, [r0, -pc]
    1800:	00003a01 	andeq	r3, r0, r1, lsl #20
    1804:	06170200 	ldreq	r0, [r7], -r0, lsl #4
    1808:	000001e7 	andeq	r0, r0, r7, ror #3
    180c:	000bb501 	andeq	fp, fp, r1, lsl #10
    1810:	2a010000 	bcs	41818 <_bss_end+0x3880c>
    1814:	0100000f 	tsteq	r0, pc
    1818:	00106001 	andseq	r6, r0, r1
    181c:	0f010200 	svceq	0x00010200
    1820:	0300000d 	movweq	r0, #13
    1824:	000dcd01 	andeq	ip, sp, r1, lsl #26
    1828:	bc010400 	cfstrslt	mvf0, [r1], {-0}
    182c:	0500000f 	streq	r0, [r0, #-15]
    1830:	00111e01 	andseq	r1, r1, r1, lsl #28
    1834:	d2010600 	andle	r0, r1, #0, 12
    1838:	0700000f 	streq	r0, [r0, -pc]
    183c:	000df301 	andeq	pc, sp, r1, lsl #6
    1840:	4d010800 	stcmi	8, cr0, [r1, #-0]
    1844:	0900000f 	stmdbeq	r0, {r0, r1, r2, r3}
    1848:	000f5b01 	andeq	r5, pc, r1, lsl #22
    184c:	69010a00 	stmdbvs	r1, {r9, fp}
    1850:	0b00000f 	bleq	1894 <shift+0x1894>
    1854:	000e5c01 	andeq	r5, lr, r1, lsl #24
    1858:	4c010c00 	stcmi	12, cr0, [r1], {-0}
    185c:	0d00000e 	stceq	0, cr0, [r0, #-56]	; 0xffffffc8
    1860:	000bd101 	andeq	sp, fp, r1, lsl #2
    1864:	ea010e00 	b	4506c <_bss_end+0x3c060>
    1868:	0f00000b 	svceq	0x0000000b
    186c:	000e3d01 	andeq	r3, lr, r1, lsl #26
    1870:	23011000 	movwcs	r1, #4096	; 0x1000
    1874:	11000010 	tstne	r0, r0, lsl r0
    1878:	000f9201 	andeq	r9, pc, r1, lsl #4
    187c:	14011200 	strne	r1, [r1], #-512	; 0xfffffe00
    1880:	13000010 	movwne	r0, #16
    1884:	000cc501 	andeq	ip, ip, r1, lsl #10
    1888:	14011400 	strne	r1, [r1], #-1024	; 0xfffffc00
    188c:	1500000c 	strne	r0, [r0, #-12]
    1890:	000bde01 	andeq	sp, fp, r1, lsl #28
    1894:	db011600 	blle	4709c <_bss_end+0x3e090>
    1898:	1700000e 	strne	r0, [r0, -lr]
    189c:	000c4b01 	andeq	r4, ip, r1, lsl #22
    18a0:	86011800 	strhi	r1, [r1], -r0, lsl #16
    18a4:	1900000b 	stmdbne	r0, {r0, r1, r3}
    18a8:	00100601 	andseq	r0, r0, r1, lsl #12
    18ac:	19011a00 	stmdbne	r1, {r9, fp, ip}
    18b0:	1b00000e 	blne	18f0 <shift+0x18f0>
    18b4:	000ef301 	andeq	pc, lr, r1, lsl #6
    18b8:	1f011c00 	svcne	0x00011c00
    18bc:	1d00000c 	stcne	0, cr0, [r0, #-48]	; 0xffffffd0
    18c0:	000db201 	andeq	fp, sp, r1, lsl #4
    18c4:	01011e00 	tsteq	r1, r0, lsl #28
    18c8:	1f00000d 	svcne	0x0000000d
    18cc:	000f8401 	andeq	r8, pc, r1, lsl #8
    18d0:	ee012000 	cdp	0, 0, cr2, cr1, cr0, {0}
    18d4:	2100000f 	tstcs	r0, pc
    18d8:	00102f01 	andseq	r2, r0, r1, lsl #30
    18dc:	3d012200 	sfmcc	f2, 4, [r1, #-0]
    18e0:	23000010 	movwcs	r0, #16
    18e4:	000fe001 	andeq	lr, pc, r1
    18e8:	30012400 	andcc	r2, r1, r0, lsl #8
    18ec:	2500000e 	strcs	r0, [r0, #-14]
    18f0:	000d7601 	andeq	r7, sp, r1, lsl #12
    18f4:	2e012600 	cfmadd32cs	mvax0, mvfx2, mvfx1, mvfx0
    18f8:	2700000c 	strcs	r0, [r0, -ip]
    18fc:	000de601 	andeq	lr, sp, r1, lsl #12
    1900:	1b012800 	blne	4b908 <_bss_end+0x428fc>
    1904:	2900000d 	stmdbcs	r0, {r0, r2, r3}
    1908:	00110401 	andseq	r0, r1, r1, lsl #8
    190c:	af012a00 	svcge	0x00012a00
    1910:	2b00000f 	blcs	1954 <shift+0x1954>
    1914:	000d2b01 	andeq	r2, sp, r1, lsl #22
    1918:	3a012c00 	bcc	4c920 <_bss_end+0x43914>
    191c:	2d00000d 	stccs	0, cr0, [r0, #-52]	; 0xffffffcc
    1920:	000d4901 	andeq	r4, sp, r1, lsl #18
    1924:	58012e00 	stmdapl	r1, {r9, sl, fp, sp}
    1928:	2f00000d 	svccs	0x0000000d
    192c:	000ce601 	andeq	lr, ip, r1, lsl #12
    1930:	67013000 	strvs	r3, [r1, -r0]
    1934:	3100000d 	tstcc	r0, sp
    1938:	000f3e01 	andeq	r3, pc, r1, lsl #28
    193c:	85013200 	strhi	r3, [r1, #-512]	; 0xfffffe00
    1940:	3300000d 	movwcc	r0, #13
    1944:	000d9401 	andeq	r9, sp, r1, lsl #8
    1948:	bf013400 	svclt	0x00013400
    194c:	3500000b 	strcc	r0, [r0, #-11]
    1950:	000e7b01 	andeq	r7, lr, r1, lsl #22
    1954:	8b013600 	blhi	4f15c <_bss_end+0x46150>
    1958:	3700000e 	strcc	r0, [r0, -lr]
    195c:	000e9b01 	andeq	r9, lr, r1, lsl #22
    1960:	d4013800 	strle	r3, [r1], #-2048	; 0xfffff800
    1964:	3900000c 	stmdbcc	r0, {r2, r3}
    1968:	000eab01 	andeq	sl, lr, r1, lsl #22
    196c:	bb013a00 	bllt	50174 <_bss_end+0x47168>
    1970:	3b00000e 	blcc	19b0 <shift+0x19b0>
    1974:	000ecb01 	andeq	ip, lr, r1, lsl #22
    1978:	3e013c00 	cdpcc	12, 0, cr3, cr1, cr0, {0}
    197c:	3d00000c 	stccc	0, cr0, [r0, #-48]	; 0xffffffd0
    1980:	000bf701 	andeq	pc, fp, r1, lsl #14
    1984:	a3013e00 	movwge	r3, #7680	; 0x1e00
    1988:	3f00000d 	svccc	0x0000000d
    198c:	000b9601 	andeq	r9, fp, r1, lsl #12
    1990:	e6014000 	str	r4, [r1], -r0
    1994:	4100000e 	tstmi	r0, lr
    1998:	0cac0c00 	stceq	12, cr0, [ip]
    199c:	02020000 	andeq	r0, r2, #0
    19a0:	0e08028b 	cdpeq	2, 0, cr0, cr8, cr11, {4}
    19a4:	04000002 	streq	r0, [r0], #-2
    19a8:	00000dc8 	andeq	r0, r0, r8, asr #27
    19ac:	00480290 	umaaleq	r0, r8, r0, r2
    19b0:	04000000 	streq	r0, [r0], #-0
    19b4:	00000ce1 	andeq	r0, r0, r1, ror #25
    19b8:	00480291 	umaaleq	r0, r8, r1, r2
    19bc:	00010000 	andeq	r0, r1, r0
    19c0:	0001e705 	andeq	lr, r1, r5, lsl #14
    19c4:	020e0300 	andeq	r0, lr, #0, 6
    19c8:	02230000 	eoreq	r0, r3, #0
    19cc:	25060000 	strcs	r0, [r6, #-0]
    19d0:	11000000 	mrsne	r0, (UNDEF: 0)
    19d4:	02130500 	andseq	r0, r3, #0, 10
    19d8:	690d0000 	stmdbvs	sp, {}	; <UNPREDICTABLE>
    19dc:	0200000e 	andeq	r0, r0, #14
    19e0:	23260294 			; <UNDEFINED> instruction: 0x23260294
    19e4:	24000002 	strcs	r0, [r0], #-2
    19e8:	400b403d 	andmi	r4, fp, sp, lsr r0
    19ec:	40264010 	eormi	r4, r6, r0, lsl r0
    19f0:	40034035 	andmi	r4, r3, r5, lsr r0
    19f4:	40144006 	andsmi	r4, r4, r6
    19f8:	400d400e 	andmi	r4, sp, lr
    19fc:	40124025 	andsmi	r4, r2, r5, lsr #32
    1a00:	40024028 	andmi	r4, r2, r8, lsr #32
    1a04:	40094018 	andmi	r4, r9, r8, lsl r0
    1a08:	0000400a 	andeq	r4, r0, sl
    1a0c:	75070202 	strvc	r0, [r7, #-514]	; 0xfffffdfe
    1a10:	02000003 	andeq	r0, r0, #3
    1a14:	03140801 	tsteq	r4, #65536	; 0x10000
    1a18:	0f0e0000 	svceq	0x000e0000
    1a1c:	00026804 	andeq	r6, r2, r4, lsl #16
    1a20:	104b1000 	subne	r1, fp, r0
    1a24:	01070000 	mrseq	r0, (UNDEF: 7)
    1a28:	0000003a 	andeq	r0, r0, sl, lsr r0
    1a2c:	06055603 	streq	r5, [r5], -r3, lsl #12
    1a30:	000002ad 	andeq	r0, r0, sp, lsr #5
    1a34:	000c8601 	andeq	r8, ip, r1, lsl #12
    1a38:	91010000 	mrsls	r0, (UNDEF: 1)
    1a3c:	0100000c 	tsteq	r0, ip
    1a40:	000ca301 	andeq	sl, ip, r1, lsl #6
    1a44:	bd010200 	sfmlt	f0, 4, [r1, #-0]
    1a48:	0300000c 	movweq	r0, #12
    1a4c:	000f7701 	andeq	r7, pc, r1, lsl #14
    1a50:	f5010400 			; <UNDEFINED> instruction: 0xf5010400
    1a54:	0500000c 	streq	r0, [r0, #-12]
    1a58:	000f1c01 	andeq	r1, pc, r1, lsl #24
    1a5c:	02000600 	andeq	r0, r0, #0, 12
    1a60:	01870502 	orreq	r0, r7, r2, lsl #10
    1a64:	08020000 	stmdaeq	r2, {}	; <UNPREDICTABLE>
    1a68:	000e0207 	andeq	r0, lr, r7, lsl #4
    1a6c:	04040200 	streq	r0, [r4], #-512	; 0xfffffe00
    1a70:	00000baf 	andeq	r0, r0, pc, lsr #23
    1a74:	a7030802 	strge	r0, [r3, -r2, lsl #16]
    1a78:	0200000b 	andeq	r0, r0, #11
    1a7c:	0ddf0408 	cfldrdeq	mvd0, [pc, #32]	; 1aa4 <shift+0x1aa4>
    1a80:	10020000 	andne	r0, r2, r0
    1a84:	000f0d03 	andeq	r0, pc, r3, lsl #26
    1a88:	0f041100 	svceq	0x00041100
    1a8c:	2a040000 	bcs	101a94 <_bss_end+0xf8a88>
    1a90:	00026910 	andeq	r6, r2, r0, lsl r9
    1a94:	02d70300 	sbcseq	r0, r7, #0, 6
    1a98:	02ee0000 	rsceq	r0, lr, #0
    1a9c:	00120000 	andseq	r0, r2, r0
    1aa0:	000a6807 	andeq	r6, sl, r7, lsl #16
    1aa4:	02e32f00 	rsceq	r2, r3, #0, 30
    1aa8:	9a070000 	bls	1c1ab0 <_bss_end+0x1b8aa4>
    1aac:	3000000a 	andcc	r0, r0, sl
    1ab0:	000002e3 	andeq	r0, r0, r3, ror #5
    1ab4:	0002d703 	andeq	sp, r2, r3, lsl #14
    1ab8:	00031200 	andeq	r1, r3, r0, lsl #4
    1abc:	00250600 	eoreq	r0, r5, r0, lsl #12
    1ac0:	00010000 	andeq	r0, r1, r0
    1ac4:	0002ee08 	andeq	lr, r2, r8, lsl #28
    1ac8:	02099000 	andeq	r9, r9, #0
    1acc:	05000003 	streq	r0, [r0, #-3]
    1ad0:	008fe403 	addeq	lr, pc, r3, lsl #8
    1ad4:	02f80800 	rscseq	r0, r8, #0, 16
    1ad8:	09910000 	ldmibeq	r1, {}	; <UNPREDICTABLE>
    1adc:	00000302 	andeq	r0, r0, r2, lsl #6
    1ae0:	8ff00305 	svchi	0x00f00305
    1ae4:	Address 0x0000000000001ae4 is out of bounds.


Disassembly of section .debug_abbrev:

00000000 <.debug_abbrev>:
   0:	3f002e01 	svccc	0x00002e01
   4:	3a0e0319 	bcc	380c70 <_bss_end+0x377c64>
   8:	0b3b0121 	bleq	ec0494 <_bss_end+0xeb7488>
   c:	11112139 	tstne	r1, r9, lsr r1
  10:	40061201 	andmi	r1, r6, r1, lsl #4
  14:	00197a18 	andseq	r7, r9, r8, lsl sl
  18:	00050200 	andeq	r0, r5, r0, lsl #4
  1c:	00001349 	andeq	r1, r0, r9, asr #6
  20:	3f012e03 	svccc	0x00012e03
  24:	3a0e0319 	bcc	380c90 <_bss_end+0x377c84>
  28:	0b3b0121 	bleq	ec04b4 <_bss_end+0xeb74a8>
  2c:	3c122139 	ldfccs	f2, [r2], {57}	; 0x39
  30:	00130119 	andseq	r0, r3, r9, lsl r1
  34:	012e0400 			; <UNDEFINED> instruction: 0x012e0400
  38:	01111347 	tsteq	r1, r7, asr #6
  3c:	18400612 	stmdane	r0, {r1, r4, r9, sl}^
  40:	1301197a 	movwne	r1, #6522	; 0x197a
  44:	05050000 	streq	r0, [r5, #-0]
  48:	3a080300 	bcc	200c50 <_bss_end+0x1f7c44>
  4c:	0b3b0121 	bleq	ec04d8 <_bss_end+0xeb74cc>
  50:	13490b39 	movtne	r0, #39737	; 0x9b39
  54:	00001802 	andeq	r1, r0, r2, lsl #16
  58:	25011106 	strcs	r1, [r1, #-262]	; 0xfffffefa
  5c:	030b130e 	movweq	r1, #45838	; 0xb30e
  60:	110e1b0e 	tstne	lr, lr, lsl #22
  64:	10061201 	andne	r1, r6, r1, lsl #4
  68:	07000017 	smladeq	r0, r7, r0, r0
  6c:	0e030139 	mcreq	1, 0, r0, cr3, cr9, {1}
  70:	0b3b0b3a 	bleq	ec2d60 <_bss_end+0xeb9d54>
  74:	13010b39 	movwne	r0, #6969	; 0x1b39
  78:	16080000 	strne	r0, [r8], -r0
  7c:	3a0e0300 	bcc	380c84 <_bss_end+0x377c78>
  80:	390b3b0b 	stmdbcc	fp, {r0, r1, r3, r8, r9, fp, ip, sp}
  84:	0013490b 	andseq	r4, r3, fp, lsl #18
  88:	012e0900 			; <UNDEFINED> instruction: 0x012e0900
  8c:	0e03193f 			; <UNDEFINED> instruction: 0x0e03193f
  90:	0b3b0b3a 	bleq	ec2d80 <_bss_end+0xeb9d74>
  94:	13490b39 	movtne	r0, #39737	; 0x9b39
  98:	0000193c 	andeq	r1, r0, ip, lsr r9
  9c:	0b000f0a 	bleq	3ccc <shift+0x3ccc>
  a0:	0013490b 	andseq	r4, r3, fp, lsl #18
  a4:	00240b00 	eoreq	r0, r4, r0, lsl #22
  a8:	0b3e0b0b 	bleq	f82cdc <_bss_end+0xf79cd0>
  ac:	00000e03 	andeq	r0, r0, r3, lsl #28
  b0:	4900050c 	stmdbmi	r0, {r2, r3, r8, sl}
  b4:	00180213 	andseq	r0, r8, r3, lsl r2
  b8:	00240d00 	eoreq	r0, r4, r0, lsl #26
  bc:	0b3e0b0b 	bleq	f82cf0 <_bss_end+0xf79ce4>
  c0:	00000803 	andeq	r0, r0, r3, lsl #16
  c4:	47012e0e 	strmi	r2, [r1, -lr, lsl #28]
  c8:	12011113 	andne	r1, r1, #-1073741820	; 0xc0000004
  cc:	7a184006 	bvc	6100ec <_bss_end+0x6070e0>
  d0:	00000019 	andeq	r0, r0, r9, lsl r0
  d4:	03002801 	movweq	r2, #2049	; 0x801
  d8:	000b1c0e 	andeq	r1, fp, lr, lsl #24
  dc:	00050200 	andeq	r0, r5, r0, lsl #4
  e0:	213a0e03 	teqcs	sl, r3, lsl #28
  e4:	390b3b01 	stmdbcc	fp, {r0, r8, r9, fp, ip, sp}
  e8:	0213490b 	andseq	r4, r3, #180224	; 0x2c000
  ec:	03000018 	movweq	r0, #24
  f0:	0b0b0024 	bleq	2c0188 <_bss_end+0x2b717c>
  f4:	0e030b3e 	vmoveq.16	d3[0], r0
  f8:	05040000 	streq	r0, [r4, #-0]
  fc:	00134900 	andseq	r4, r3, r0, lsl #18
 100:	00050500 	andeq	r0, r5, r0, lsl #10
 104:	19341349 	ldmdbne	r4!, {r0, r3, r6, r8, r9, ip}
 108:	26060000 	strcs	r0, [r6], -r0
 10c:	00134900 	andseq	r4, r3, r0, lsl #18
 110:	00340700 	eorseq	r0, r4, r0, lsl #14
 114:	00001347 	andeq	r1, r0, r7, asr #6
 118:	03000508 	movweq	r0, #1288	; 0x508
 11c:	3413490e 	ldrcc	r4, [r3], #-2318	; 0xfffff6f2
 120:	00180219 	andseq	r0, r8, r9, lsl r2
 124:	00340900 	eorseq	r0, r4, r0, lsl #18
 128:	213a0e03 	teqcs	sl, r3, lsl #28
 12c:	390b3b02 	stmdbcc	fp, {r1, r8, r9, fp, ip, sp}
 130:	13491a21 	movtne	r1, #39457	; 0x9a21
 134:	061c193c 			; <UNDEFINED> instruction: 0x061c193c
 138:	0000196c 	andeq	r1, r0, ip, ror #18
 13c:	3f012e0a 	svccc	0x00012e0a
 140:	3a0e0319 	bcc	380dac <_bss_end+0x377da0>
 144:	0b3b0321 	bleq	ec0dd0 <_bss_end+0xeb7dc4>
 148:	6e0e2139 	mcrvs	1, 0, r2, cr14, cr9, {1}
 14c:	0121320e 			; <UNDEFINED> instruction: 0x0121320e
 150:	1364193c 	cmnne	r4, #60, 18	; 0xf0000
 154:	00001301 	andeq	r1, r0, r1, lsl #6
 158:	0b000f0b 	bleq	3d8c <shift+0x3d8c>
 15c:	13490421 	movtne	r0, #37921	; 0x9421
 160:	2e0c0000 	cdpcs	0, 0, cr0, cr12, cr0, {0}
 164:	3a134701 	bcc	4d1d70 <_bss_end+0x4c8d64>
 168:	0b3b0121 	bleq	ec05f4 <_bss_end+0xeb75e8>
 16c:	64062139 	strvs	r2, [r6], #-313	; 0xfffffec7
 170:	12011113 	andne	r1, r1, #-1073741820	; 0xc0000004
 174:	7c184006 	ldcvc	0, cr4, [r8], {6}
 178:	00130119 	andseq	r0, r3, r9, lsl r1
 17c:	00050d00 	andeq	r0, r5, r0, lsl #26
 180:	18021331 	stmdane	r2, {r0, r4, r5, r8, r9, ip}
 184:	110e0000 	mrsne	r0, (UNDEF: 14)
 188:	130e2501 	movwne	r2, #58625	; 0xe501
 18c:	1b0e030b 	blne	380dc0 <_bss_end+0x377db4>
 190:	1201110e 	andne	r1, r1, #-2147483645	; 0x80000003
 194:	00171006 	andseq	r1, r7, r6
 198:	00240f00 	eoreq	r0, r4, r0, lsl #30
 19c:	0b3e0b0b 	bleq	f82dd0 <_bss_end+0xf79dc4>
 1a0:	00000803 	andeq	r0, r0, r3, lsl #16
 1a4:	03001610 	movweq	r1, #1552	; 0x610
 1a8:	3b0b3a0e 	blcc	2ce9e8 <_bss_end+0x2c59dc>
 1ac:	490b390b 	stmdbmi	fp, {r0, r1, r3, r8, fp, ip, sp}
 1b0:	11000013 	tstne	r0, r3, lsl r0
 1b4:	08030139 	stmdaeq	r3, {r0, r3, r4, r5, r8}
 1b8:	0b3b0b3a 	bleq	ec2ea8 <_bss_end+0xeb9e9c>
 1bc:	13010b39 	movwne	r0, #6969	; 0x1b39
 1c0:	34120000 	ldrcc	r0, [r2], #-0
 1c4:	3a0e0300 	bcc	380dcc <_bss_end+0x377dc0>
 1c8:	390b3b0b 	stmdbcc	fp, {r0, r1, r3, r8, r9, fp, ip, sp}
 1cc:	3c13490b 			; <UNDEFINED> instruction: 0x3c13490b
 1d0:	6c0b1c19 	stcvs	12, cr1, [fp], {25}
 1d4:	13000019 	movwne	r0, #25
 1d8:	0e030104 	adfeqs	f0, f3, f4
 1dc:	0b3e196d 	bleq	f86798 <_bss_end+0xf7d78c>
 1e0:	13490b0b 	movtne	r0, #39691	; 0x9b0b
 1e4:	0b3b0b3a 	bleq	ec2ed4 <_bss_end+0xeb9ec8>
 1e8:	13010b39 	movwne	r0, #6969	; 0x1b39
 1ec:	28140000 	ldmdacs	r4, {}	; <UNPREDICTABLE>
 1f0:	1c080300 	stcne	3, cr0, [r8], {-0}
 1f4:	1500000b 	strne	r0, [r0, #-11]
 1f8:	0e030104 	adfeqs	f0, f3, f4
 1fc:	0b3e196d 	bleq	f867b8 <_bss_end+0xf7d7ac>
 200:	13490b0b 	movtne	r0, #39691	; 0x9b0b
 204:	0b3b0b3a 	bleq	ec2ef4 <_bss_end+0xeb9ee8>
 208:	00000b39 	andeq	r0, r0, r9, lsr fp
 20c:	03010216 	movweq	r0, #4630	; 0x1216
 210:	3a0b0b0e 	bcc	2c2e50 <_bss_end+0x2b9e44>
 214:	390b3b0b 	stmdbcc	fp, {r0, r1, r3, r8, r9, fp, ip, sp}
 218:	0013010b 	andseq	r0, r3, fp, lsl #2
 21c:	000d1700 	andeq	r1, sp, r0, lsl #14
 220:	0b3a0e03 	bleq	e83a34 <_bss_end+0xe7aa28>
 224:	0b390b3b 	bleq	e42f18 <_bss_end+0xe39f0c>
 228:	0b381349 	bleq	e04f54 <_bss_end+0xdfbf48>
 22c:	2e180000 	cdpcs	0, 1, cr0, cr8, cr0, {0}
 230:	03193f01 	tsteq	r9, #1, 30
 234:	3b0b3a0e 	blcc	2cea74 <_bss_end+0x2c5a68>
 238:	6e0b390b 	vmlavs.f16	s6, s22, s22	; <UNPREDICTABLE>
 23c:	3213490e 	andscc	r4, r3, #229376	; 0x38000
 240:	64193c0b 	ldrvs	r3, [r9], #-3083	; 0xfffff3f5
 244:	00130113 	andseq	r0, r3, r3, lsl r1
 248:	012e1900 			; <UNDEFINED> instruction: 0x012e1900
 24c:	0e03193f 			; <UNDEFINED> instruction: 0x0e03193f
 250:	0b3b0b3a 	bleq	ec2f40 <_bss_end+0xeb9f34>
 254:	0e6e0b39 	vmoveq.8	d14[5], r0
 258:	0b321349 	bleq	c84f84 <_bss_end+0xc7bf78>
 25c:	1364193c 	cmnne	r4, #60, 18	; 0xf0000
 260:	341a0000 	ldrcc	r0, [sl], #-0
 264:	3a0e0300 	bcc	380e6c <_bss_end+0x377e60>
 268:	390b3b0b 	stmdbcc	fp, {r0, r1, r3, r8, r9, fp, ip, sp}
 26c:	3f13490b 	svccc	0x0013490b
 270:	00193c19 	andseq	r3, r9, r9, lsl ip
 274:	00341b00 	eorseq	r1, r4, r0, lsl #22
 278:	0b3a1347 	bleq	e84f9c <_bss_end+0xe7bf90>
 27c:	0b390b3b 	bleq	e42f70 <_bss_end+0xe39f64>
 280:	00001802 	andeq	r1, r0, r2, lsl #16
 284:	03002e1c 	movweq	r2, #3612	; 0xe1c
 288:	1119340e 	tstne	r9, lr, lsl #8
 28c:	40061201 	andmi	r1, r6, r1, lsl #4
 290:	00197c18 	andseq	r7, r9, r8, lsl ip
 294:	012e1d00 			; <UNDEFINED> instruction: 0x012e1d00
 298:	19340e03 	ldmdbne	r4!, {r0, r1, r9, sl, fp}
 29c:	06120111 			; <UNDEFINED> instruction: 0x06120111
 2a0:	197c1840 	ldmdbne	ip!, {r6, fp, ip}^
 2a4:	00001301 	andeq	r1, r0, r1, lsl #6
 2a8:	47012e1e 	smladmi	r1, lr, lr, r2
 2ac:	3b0b3a13 	blcc	2ceb00 <_bss_end+0x2c5af4>
 2b0:	640b390b 	strvs	r3, [fp], #-2315	; 0xfffff6f5
 2b4:	12011113 	andne	r1, r1, #-1073741820	; 0xc0000004
 2b8:	7a184006 	bvc	6102d8 <_bss_end+0x6072cc>
 2bc:	00130119 	andseq	r0, r3, r9, lsl r1
 2c0:	012e1f00 			; <UNDEFINED> instruction: 0x012e1f00
 2c4:	0b3a1347 	bleq	e84fe8 <_bss_end+0xe7bfdc>
 2c8:	13640b39 	cmnne	r4, #58368	; 0xe400
 2cc:	06120111 			; <UNDEFINED> instruction: 0x06120111
 2d0:	197a1840 	ldmdbne	sl!, {r6, fp, ip}^
 2d4:	00001301 	andeq	r1, r0, r1, lsl #6
 2d8:	47012e20 	strmi	r2, [r1, -r0, lsr #28]
 2dc:	3b0b3a13 	blcc	2ceb30 <_bss_end+0x2c5b24>
 2e0:	640b390b 	strvs	r3, [fp], #-2315	; 0xfffff6f5
 2e4:	010b2013 	tsteq	fp, r3, lsl r0
 2e8:	21000013 	tstcs	r0, r3, lsl r0
 2ec:	0e030005 	cdpeq	0, 0, cr0, cr3, cr5, {0}
 2f0:	19341349 	ldmdbne	r4!, {r0, r3, r6, r8, r9, ip}
 2f4:	05220000 	streq	r0, [r2, #-0]!
 2f8:	3a0e0300 	bcc	380f00 <_bss_end+0x377ef4>
 2fc:	390b3b0b 	stmdbcc	fp, {r0, r1, r3, r8, r9, fp, ip, sp}
 300:	0013490b 	andseq	r4, r3, fp, lsl #18
 304:	012e2300 			; <UNDEFINED> instruction: 0x012e2300
 308:	0e6e1331 	mcreq	3, 3, r1, cr14, cr1, {1}
 30c:	01111364 	tsteq	r1, r4, ror #6
 310:	18400612 	stmdane	r0, {r1, r4, r9, sl}^
 314:	0000197a 	andeq	r1, r0, sl, ror r9
 318:	00280100 	eoreq	r0, r8, r0, lsl #2
 31c:	0b1c0e03 	bleq	703b30 <_bss_end+0x6fab24>
 320:	05020000 	streq	r0, [r2, #-0]
 324:	00134900 	andseq	r4, r3, r0, lsl #18
 328:	00050300 	andeq	r0, r5, r0, lsl #6
 32c:	213a0803 	teqcs	sl, r3, lsl #16
 330:	390b3b01 	stmdbcc	fp, {r0, r8, r9, fp, ip, sp}
 334:	0213490b 	andseq	r4, r3, #180224	; 0x2c000
 338:	04000018 	streq	r0, [r0], #-24	; 0xffffffe8
 33c:	13490005 	movtne	r0, #36869	; 0x9005
 340:	00001934 	andeq	r1, r0, r4, lsr r9
 344:	0b002405 	bleq	9360 <_bss_end+0x354>
 348:	030b3e0b 	movweq	r3, #48651	; 0xbe0b
 34c:	0600000e 	streq	r0, [r0], -lr
 350:	0e030005 	cdpeq	0, 0, cr0, cr3, cr5, {0}
 354:	3b01213a 	blcc	48844 <_bss_end+0x3f838>
 358:	490b390b 	stmdbmi	fp, {r0, r1, r3, r8, fp, ip, sp}
 35c:	00180213 	andseq	r0, r8, r3, lsl r2
 360:	00050700 	andeq	r0, r5, r0, lsl #14
 364:	13490e03 	movtne	r0, #40451	; 0x9e03
 368:	18021934 	stmdane	r2, {r2, r4, r5, r8, fp, ip}
 36c:	26080000 	strcs	r0, [r8], -r0
 370:	00134900 	andseq	r4, r3, r0, lsl #18
 374:	012e0900 			; <UNDEFINED> instruction: 0x012e0900
 378:	0e03193f 			; <UNDEFINED> instruction: 0x0e03193f
 37c:	3b04213a 	blcc	10886c <_bss_end+0xff860>
 380:	6e0b390b 	vmlavs.f16	s6, s22, s22	; <UNPREDICTABLE>
 384:	3213490e 	andscc	r4, r3, #229376	; 0x38000
 388:	64193c0b 	ldrvs	r3, [r9], #-3083	; 0xfffff3f5
 38c:	00130113 	andseq	r0, r3, r3, lsl r1
 390:	00340a00 	eorseq	r0, r4, r0, lsl #20
 394:	213a0803 	teqcs	sl, r3, lsl #16
 398:	390b3b01 	stmdbcc	fp, {r0, r8, r9, fp, ip, sp}
 39c:	0213490b 	andseq	r4, r3, #180224	; 0x2c000
 3a0:	0b000018 	bleq	408 <shift+0x408>
 3a4:	13470034 	movtne	r0, #28724	; 0x7034
 3a8:	2e0c0000 	cdpcs	0, 0, cr0, cr12, cr0, {0}
 3ac:	3a134701 	bcc	4d1fb8 <_bss_end+0x4c8fac>
 3b0:	0b3b0121 	bleq	ec083c <_bss_end+0xeb7830>
 3b4:	64062139 	strvs	r2, [r6], #-313	; 0xfffffec7
 3b8:	12011113 	andne	r1, r1, #-1073741820	; 0xc0000004
 3bc:	7a184006 	bvc	6103dc <_bss_end+0x6073d0>
 3c0:	00130119 	andseq	r0, r3, r9, lsl r1
 3c4:	00340d00 	eorseq	r0, r4, r0, lsl #26
 3c8:	213a0e03 	teqcs	sl, r3, lsl #28
 3cc:	390b3b03 	stmdbcc	fp, {r0, r1, r8, r9, fp, ip, sp}
 3d0:	13491a21 	movtne	r1, #39457	; 0x9a21
 3d4:	061c193c 			; <UNDEFINED> instruction: 0x061c193c
 3d8:	0000196c 	andeq	r1, r0, ip, ror #18
 3dc:	0b000f0e 	bleq	401c <shift+0x401c>
 3e0:	13490421 	movtne	r0, #37921	; 0x9421
 3e4:	2e0f0000 	cdpcs	0, 0, cr0, cr15, cr0, {0}
 3e8:	3a134701 	bcc	4d1ff4 <_bss_end+0x4c8fe8>
 3ec:	0b3b0121 	bleq	ec0878 <_bss_end+0xeb786c>
 3f0:	13640b39 	cmnne	r4, #58368	; 0xe400
 3f4:	06120111 			; <UNDEFINED> instruction: 0x06120111
 3f8:	197c1840 	ldmdbne	ip!, {r6, fp, ip}^
 3fc:	00001301 	andeq	r1, r0, r1, lsl #6
 400:	03001610 	movweq	r1, #1552	; 0x610
 404:	02213a0e 	eoreq	r3, r1, #57344	; 0xe000
 408:	21390b3b 	teqcs	r9, fp, lsr fp
 40c:	00134907 	andseq	r4, r3, r7, lsl #18
 410:	01041100 	mrseq	r1, (UNDEF: 20)
 414:	196d0e03 	stmdbne	sp!, {r0, r1, r9, sl, fp}^
 418:	0b0b0b3e 	bleq	2c3118 <_bss_end+0x2ba10c>
 41c:	0b3a1349 	bleq	e85148 <_bss_end+0xe7c13c>
 420:	0b390b3b 	bleq	e43114 <_bss_end+0xe3a108>
 424:	00001301 	andeq	r1, r0, r1, lsl #6
 428:	31000512 	tstcc	r0, r2, lsl r5
 42c:	00180213 	andseq	r0, r8, r3, lsl r2
 430:	01111300 	tsteq	r1, r0, lsl #6
 434:	0b130e25 	bleq	4c3cd0 <_bss_end+0x4bacc4>
 438:	0e1b0e03 	cdpeq	14, 1, cr0, cr11, cr3, {0}
 43c:	06120111 			; <UNDEFINED> instruction: 0x06120111
 440:	00001710 	andeq	r1, r0, r0, lsl r7
 444:	0b002414 	bleq	949c <_bss_end+0x490>
 448:	030b3e0b 	movweq	r3, #48651	; 0xbe0b
 44c:	15000008 	strne	r0, [r0, #-8]
 450:	08030139 	stmdaeq	r3, {r0, r3, r4, r5, r8}
 454:	0b3b0b3a 	bleq	ec3144 <_bss_end+0xeba138>
 458:	13010b39 	movwne	r0, #6969	; 0x1b39
 45c:	34160000 	ldrcc	r0, [r6], #-0
 460:	3a0e0300 	bcc	381068 <_bss_end+0x37805c>
 464:	390b3b0b 	stmdbcc	fp, {r0, r1, r3, r8, r9, fp, ip, sp}
 468:	3c13490b 			; <UNDEFINED> instruction: 0x3c13490b
 46c:	6c0b1c19 	stcvs	12, cr1, [fp], {25}
 470:	17000019 	smladne	r0, r9, r0, r0
 474:	0e030102 	adfeqs	f0, f3, f2
 478:	0b3a0b0b 	bleq	e830ac <_bss_end+0xe7a0a0>
 47c:	0b390b3b 	bleq	e43170 <_bss_end+0xe3a164>
 480:	00001301 	andeq	r1, r0, r1, lsl #6
 484:	03000d18 	movweq	r0, #3352	; 0xd18
 488:	3b0b3a0e 	blcc	2cecc8 <_bss_end+0x2c5cbc>
 48c:	490b390b 	stmdbmi	fp, {r0, r1, r3, r8, fp, ip, sp}
 490:	000b3813 	andeq	r3, fp, r3, lsl r8
 494:	012e1900 			; <UNDEFINED> instruction: 0x012e1900
 498:	0e03193f 			; <UNDEFINED> instruction: 0x0e03193f
 49c:	0b3b0b3a 	bleq	ec318c <_bss_end+0xeba180>
 4a0:	0e6e0b39 	vmoveq.8	d14[5], r0
 4a4:	193c0b32 	ldmdbne	ip!, {r1, r4, r5, r8, r9, fp}
 4a8:	13011364 	movwne	r1, #4964	; 0x1364
 4ac:	2e1a0000 	cdpcs	0, 1, cr0, cr10, cr0, {0}
 4b0:	03193f01 	tsteq	r9, #1, 30
 4b4:	3b0b3a0e 	blcc	2cecf4 <_bss_end+0x2c5ce8>
 4b8:	6e0b390b 	vmlavs.f16	s6, s22, s22	; <UNPREDICTABLE>
 4bc:	3c0b320e 	sfmcc	f3, 4, [fp], {14}
 4c0:	00136419 	andseq	r6, r3, r9, lsl r4
 4c4:	00101b00 	andseq	r1, r0, r0, lsl #22
 4c8:	13490b0b 	movtne	r0, #39691	; 0x9b0b
 4cc:	341c0000 	ldrcc	r0, [ip], #-0
 4d0:	3a0e0300 	bcc	3810d8 <_bss_end+0x3780cc>
 4d4:	390b3b0b 	stmdbcc	fp, {r0, r1, r3, r8, r9, fp, ip, sp}
 4d8:	3f13490b 	svccc	0x0013490b
 4dc:	00193c19 	andseq	r3, r9, r9, lsl ip
 4e0:	00341d00 	eorseq	r1, r4, r0, lsl #26
 4e4:	0b3a1347 	bleq	e85208 <_bss_end+0xe7c1fc>
 4e8:	0b390b3b 	bleq	e431dc <_bss_end+0xe3a1d0>
 4ec:	00001802 	andeq	r1, r0, r2, lsl #16
 4f0:	03002e1e 	movweq	r2, #3614	; 0xe1e
 4f4:	1119340e 	tstne	r9, lr, lsl #8
 4f8:	40061201 	andmi	r1, r6, r1, lsl #4
 4fc:	00197c18 	andseq	r7, r9, r8, lsl ip
 500:	012e1f00 			; <UNDEFINED> instruction: 0x012e1f00
 504:	19340e03 	ldmdbne	r4!, {r0, r1, r9, sl, fp}
 508:	06120111 			; <UNDEFINED> instruction: 0x06120111
 50c:	197c1840 	ldmdbne	ip!, {r6, fp, ip}^
 510:	00001301 	andeq	r1, r0, r1, lsl #6
 514:	47012e20 	strmi	r2, [r1, -r0, lsr #28]
 518:	3b0b3a13 	blcc	2ced6c <_bss_end+0x2c5d60>
 51c:	640b390b 	strvs	r3, [fp], #-2315	; 0xfffff6f5
 520:	010b2013 	tsteq	fp, r3, lsl r0
 524:	21000013 	tstcs	r0, r3, lsl r0
 528:	0e030005 	cdpeq	0, 0, cr0, cr3, cr5, {0}
 52c:	19341349 	ldmdbne	r4!, {r0, r3, r6, r8, r9, ip}
 530:	05220000 	streq	r0, [r2, #-0]!
 534:	3a0e0300 	bcc	38113c <_bss_end+0x378130>
 538:	390b3b0b 	stmdbcc	fp, {r0, r1, r3, r8, r9, fp, ip, sp}
 53c:	0013490b 	andseq	r4, r3, fp, lsl #18
 540:	012e2300 			; <UNDEFINED> instruction: 0x012e2300
 544:	0e6e1331 	mcreq	3, 3, r1, cr14, cr1, {1}
 548:	01111364 	tsteq	r1, r4, ror #6
 54c:	18400612 	stmdane	r0, {r1, r4, r9, sl}^
 550:	0000197a 	andeq	r1, r0, sl, ror r9
 554:	00280100 	eoreq	r0, r8, r0, lsl #2
 558:	0b1c0e03 	bleq	703d6c <_bss_end+0x6fad60>
 55c:	05020000 	streq	r0, [r2, #-0]
 560:	00134900 	andseq	r4, r3, r0, lsl #18
 564:	00050300 	andeq	r0, r5, r0, lsl #6
 568:	19341349 	ldmdbne	r4!, {r0, r3, r6, r8, r9, ip}
 56c:	28040000 	stmdacs	r4, {}	; <UNPREDICTABLE>
 570:	1c0e0300 	stcne	3, cr0, [lr], {-0}
 574:	05000005 	streq	r0, [r0, #-5]
 578:	0b0b0024 	bleq	2c0610 <_bss_end+0x2b7604>
 57c:	0e030b3e 	vmoveq.16	d3[0], r0
 580:	26060000 	strcs	r0, [r6], -r0
 584:	00134900 	andseq	r4, r3, r0, lsl #18
 588:	012e0700 			; <UNDEFINED> instruction: 0x012e0700
 58c:	0e03193f 			; <UNDEFINED> instruction: 0x0e03193f
 590:	0b3b0b3a 	bleq	ec3280 <_bss_end+0xeba274>
 594:	6e0e2139 	mcrvs	1, 0, r2, cr14, cr9, {1}
 598:	0121320e 			; <UNDEFINED> instruction: 0x0121320e
 59c:	1364193c 	cmnne	r4, #60, 18	; 0xf0000
 5a0:	00001301 	andeq	r1, r0, r1, lsl #6
 5a4:	47003408 	strmi	r3, [r0, -r8, lsl #8]
 5a8:	09000013 	stmdbeq	r0, {r0, r1, r4}
 5ac:	210b000f 	tstcs	fp, pc
 5b0:	00134904 	andseq	r4, r3, r4, lsl #18
 5b4:	012e0a00 			; <UNDEFINED> instruction: 0x012e0a00
 5b8:	213a1347 	teqcs	sl, r7, asr #6
 5bc:	390b3b01 	stmdbcc	fp, {r0, r8, r9, fp, ip, sp}
 5c0:	13640621 	cmnne	r4, #34603008	; 0x2100000
 5c4:	06120111 			; <UNDEFINED> instruction: 0x06120111
 5c8:	197c1840 	ldmdbne	ip!, {r6, fp, ip}^
 5cc:	00001301 	andeq	r1, r0, r1, lsl #6
 5d0:	0300050b 	movweq	r0, #1291	; 0x50b
 5d4:	3413490e 	ldrcc	r4, [r3], #-2318	; 0xfffff6f2
 5d8:	00180219 	andseq	r0, r8, r9, lsl r2
 5dc:	00340c00 	eorseq	r0, r4, r0, lsl #24
 5e0:	213a0e03 	teqcs	sl, r3, lsl #28
 5e4:	390b3b02 	stmdbcc	fp, {r1, r8, r9, fp, ip, sp}
 5e8:	13491a21 	movtne	r1, #39457	; 0x9a21
 5ec:	061c193c 			; <UNDEFINED> instruction: 0x061c193c
 5f0:	0000196c 	andeq	r1, r0, ip, ror #18
 5f4:	0301040d 	movweq	r0, #5133	; 0x140d
 5f8:	3e196d0e 	cdpcc	13, 1, cr6, cr9, cr14, {0}
 5fc:	210b0521 	tstcs	fp, r1, lsr #10
 600:	3a134904 	bcc	4d2a18 <_bss_end+0x4c9a0c>
 604:	390b3b0b 	stmdbcc	fp, {r0, r1, r3, r8, r9, fp, ip, sp}
 608:	0013010b 	andseq	r0, r3, fp, lsl #2
 60c:	00050e00 	andeq	r0, r5, r0, lsl #28
 610:	213a0e03 	teqcs	sl, r3, lsl #28
 614:	390b3b01 	stmdbcc	fp, {r0, r8, r9, fp, ip, sp}
 618:	0213490b 	andseq	r4, r3, #180224	; 0x2c000
 61c:	0f000018 	svceq	0x00000018
 620:	08030005 	stmdaeq	r3, {r0, r2}
 624:	3b01213a 	blcc	48b14 <_bss_end+0x3fb08>
 628:	490b390b 	stmdbmi	fp, {r0, r1, r3, r8, fp, ip, sp}
 62c:	00180213 	andseq	r0, r8, r3, lsl r2
 630:	01021000 	mrseq	r1, (UNDEF: 2)
 634:	210b0e03 	tstcs	fp, r3, lsl #28
 638:	3b0b3a04 	blcc	2cee50 <_bss_end+0x2c5e44>
 63c:	0721390b 	streq	r3, [r1, -fp, lsl #18]!
 640:	00001301 	andeq	r1, r0, r1, lsl #6
 644:	03000d11 	movweq	r0, #3345	; 0xd11
 648:	3b0b3a0e 	blcc	2cee88 <_bss_end+0x2c5e7c>
 64c:	490b390b 	stmdbmi	fp, {r0, r1, r3, r8, fp, ip, sp}
 650:	00213813 	eoreq	r3, r1, r3, lsl r8
 654:	2e120000 	cdpcs	0, 1, cr0, cr2, cr0, {0}
 658:	03193f01 	tsteq	r9, #1, 30
 65c:	3b0b3a0e 	blcc	2cee9c <_bss_end+0x2c5e90>
 660:	0921390b 	stmdbeq	r1!, {r0, r1, r3, r8, fp, ip, sp}
 664:	13490e6e 	movtne	r0, #40558	; 0x9e6e
 668:	3c012132 	stfccs	f2, [r1], {50}	; 0x32
 66c:	01136419 	tsteq	r3, r9, lsl r4
 670:	13000013 	movwne	r0, #19
 674:	0e030034 	mcreq	0, 0, r0, cr3, cr4, {1}
 678:	0b3b0b3a 	bleq	ec3368 <_bss_end+0xeba35c>
 67c:	13490b39 	movtne	r0, #39737	; 0x9b39
 680:	193c193f 	ldmdbne	ip!, {r0, r1, r2, r3, r4, r5, r8, fp, ip}
 684:	34140000 	ldrcc	r0, [r4], #-0
 688:	3a080300 	bcc	201290 <_bss_end+0x1f8284>
 68c:	0b3b0121 	bleq	ec0b18 <_bss_end+0xeb7b0c>
 690:	13490b39 	movtne	r0, #39737	; 0x9b39
 694:	00001802 	andeq	r1, r0, r2, lsl #16
 698:	31000515 	tstcc	r0, r5, lsl r5
 69c:	00180213 	andseq	r0, r8, r3, lsl r2
 6a0:	01111600 	tsteq	r1, r0, lsl #12
 6a4:	0b130e25 	bleq	4c3f40 <_bss_end+0x4baf34>
 6a8:	0e1b0e03 	cdpeq	14, 1, cr0, cr11, cr3, {0}
 6ac:	06120111 			; <UNDEFINED> instruction: 0x06120111
 6b0:	00001710 	andeq	r1, r0, r0, lsl r7
 6b4:	0b002417 	bleq	9718 <_bss_end+0x70c>
 6b8:	030b3e0b 	movweq	r3, #48651	; 0xbe0b
 6bc:	18000008 	stmdane	r0, {r3}
 6c0:	0e030016 	mcreq	0, 0, r0, cr3, cr6, {0}
 6c4:	0b3b0b3a 	bleq	ec33b4 <_bss_end+0xeba3a8>
 6c8:	13490b39 	movtne	r0, #39737	; 0x9b39
 6cc:	39190000 	ldmdbcc	r9, {}	; <UNPREDICTABLE>
 6d0:	3a080301 	bcc	2012dc <_bss_end+0x1f82d0>
 6d4:	390b3b0b 	stmdbcc	fp, {r0, r1, r3, r8, r9, fp, ip, sp}
 6d8:	0013010b 	andseq	r0, r3, fp, lsl #2
 6dc:	00341a00 	eorseq	r1, r4, r0, lsl #20
 6e0:	0b3a0e03 	bleq	e83ef4 <_bss_end+0xe7aee8>
 6e4:	0b390b3b 	bleq	e433d8 <_bss_end+0xe3a3cc>
 6e8:	193c1349 	ldmdbne	ip!, {r0, r3, r6, r8, r9, ip}
 6ec:	196c0b1c 	stmdbne	ip!, {r2, r3, r4, r8, r9, fp}^
 6f0:	281b0000 	ldmdacs	fp, {}	; <UNPREDICTABLE>
 6f4:	1c080300 	stcne	3, cr0, [r8], {-0}
 6f8:	1c00000b 	stcne	0, cr0, [r0], {11}
 6fc:	0e030104 	adfeqs	f0, f3, f4
 700:	0b3e196d 	bleq	f86cbc <_bss_end+0xf7dcb0>
 704:	13490b0b 	movtne	r0, #39691	; 0x9b0b
 708:	0b3b0b3a 	bleq	ec33f8 <_bss_end+0xeba3ec>
 70c:	00000b39 	andeq	r0, r0, r9, lsr fp
 710:	3f012e1d 	svccc	0x00012e1d
 714:	3a0e0319 	bcc	381380 <_bss_end+0x378374>
 718:	390b3b0b 	stmdbcc	fp, {r0, r1, r3, r8, r9, fp, ip, sp}
 71c:	490e6e0b 	stmdbmi	lr, {r0, r1, r3, r9, sl, fp, sp, lr}
 720:	3c0b3213 	sfmcc	f3, 4, [fp], {19}
 724:	00136419 	andseq	r6, r3, r9, lsl r4
 728:	00281e00 	eoreq	r1, r8, r0, lsl #28
 72c:	061c0e03 	ldreq	r0, [ip], -r3, lsl #28
 730:	2e1f0000 	cdpcs	0, 1, cr0, cr15, cr0, {0}
 734:	03193f01 	tsteq	r9, #1, 30
 738:	3b0b3a0e 	blcc	2cef78 <_bss_end+0x2c5f6c>
 73c:	6e0b390b 	vmlavs.f16	s6, s22, s22	; <UNPREDICTABLE>
 740:	3c0b320e 	sfmcc	f3, 4, [fp], {14}
 744:	00136419 	andseq	r6, r3, r9, lsl r4
 748:	00102000 	andseq	r2, r0, r0
 74c:	13490b0b 	movtne	r0, #39691	; 0x9b0b
 750:	34210000 	strtcc	r0, [r1], #-0
 754:	3a134700 	bcc	4d235c <_bss_end+0x4c9350>
 758:	390b3b0b 	stmdbcc	fp, {r0, r1, r3, r8, r9, fp, ip, sp}
 75c:	0018020b 	andseq	r0, r8, fp, lsl #4
 760:	002e2200 	eoreq	r2, lr, r0, lsl #4
 764:	19340e03 	ldmdbne	r4!, {r0, r1, r9, sl, fp}
 768:	06120111 			; <UNDEFINED> instruction: 0x06120111
 76c:	197c1840 	ldmdbne	ip!, {r6, fp, ip}^
 770:	2e230000 	cdpcs	0, 2, cr0, cr3, cr0, {0}
 774:	340e0301 	strcc	r0, [lr], #-769	; 0xfffffcff
 778:	12011119 	andne	r1, r1, #1073741830	; 0x40000006
 77c:	7c184006 	ldcvc	0, cr4, [r8], {6}
 780:	00130119 	andseq	r0, r3, r9, lsl r1
 784:	00342400 	eorseq	r2, r4, r0, lsl #8
 788:	0b3a0e03 	bleq	e83f9c <_bss_end+0xe7af90>
 78c:	0b390b3b 	bleq	e43480 <_bss_end+0xe3a474>
 790:	196c1349 	stmdbne	ip!, {r0, r3, r6, r8, r9, ip}^
 794:	00001802 	andeq	r1, r0, r2, lsl #16
 798:	47012e25 	strmi	r2, [r1, -r5, lsr #28]
 79c:	3b0b3a13 	blcc	2ceff0 <_bss_end+0x2c5fe4>
 7a0:	640b390b 	strvs	r3, [fp], #-2315	; 0xfffff6f5
 7a4:	010b2013 	tsteq	fp, r3, lsl r0
 7a8:	26000013 			; <UNDEFINED> instruction: 0x26000013
 7ac:	0e030005 	cdpeq	0, 0, cr0, cr3, cr5, {0}
 7b0:	19341349 	ldmdbne	r4!, {r0, r3, r6, r8, r9, ip}
 7b4:	05270000 	streq	r0, [r7, #-0]!
 7b8:	3a080300 	bcc	2013c0 <_bss_end+0x1f83b4>
 7bc:	390b3b0b 	stmdbcc	fp, {r0, r1, r3, r8, r9, fp, ip, sp}
 7c0:	0013490b 	andseq	r4, r3, fp, lsl #18
 7c4:	012e2800 			; <UNDEFINED> instruction: 0x012e2800
 7c8:	0e6e1331 	mcreq	3, 3, r1, cr14, cr1, {1}
 7cc:	01111364 	tsteq	r1, r4, ror #6
 7d0:	18400612 	stmdane	r0, {r1, r4, r9, sl}^
 7d4:	0000197c 	andeq	r1, r0, ip, ror r9
 7d8:	00280100 	eoreq	r0, r8, r0, lsl #2
 7dc:	0b1c0e03 	bleq	703ff0 <_bss_end+0x6fafe4>
 7e0:	05020000 	streq	r0, [r2, #-0]
 7e4:	00134900 	andseq	r4, r3, r0, lsl #18
 7e8:	00050300 	andeq	r0, r5, r0, lsl #6
 7ec:	19341349 	ldmdbne	r4!, {r0, r3, r6, r8, r9, ip}
 7f0:	2e040000 	cdpcs	0, 0, cr0, cr4, cr0, {0}
 7f4:	03193f01 	tsteq	r9, #1, 30
 7f8:	3b0b3a0e 	blcc	2cf038 <_bss_end+0x2c602c>
 7fc:	6e0b390b 	vmlavs.f16	s6, s22, s22	; <UNPREDICTABLE>
 800:	3213490e 	andscc	r4, r3, #229376	; 0x38000
 804:	64193c0b 	ldrvs	r3, [r9], #-3083	; 0xfffff3f5
 808:	00130113 	andseq	r0, r3, r3, lsl r1
 80c:	00240500 	eoreq	r0, r4, r0, lsl #10
 810:	0b3e0b0b 	bleq	f83444 <_bss_end+0xf7a438>
 814:	00000e03 	andeq	r0, r0, r3, lsl #28
 818:	3f012e06 	svccc	0x00012e06
 81c:	3a0e0319 	bcc	381488 <_bss_end+0x37847c>
 820:	390b3b0b 	stmdbcc	fp, {r0, r1, r3, r8, r9, fp, ip, sp}
 824:	320e6e0b 	andcc	r6, lr, #11, 28	; 0xb0
 828:	193c0121 	ldmdbne	ip!, {r0, r5, r8}
 82c:	13011364 	movwne	r1, #4964	; 0x1364
 830:	28070000 	stmdacs	r7, {}	; <UNPREDICTABLE>
 834:	1c0e0300 	stcne	3, cr0, [lr], {-0}
 838:	08000005 	stmdaeq	r0, {r0, r2}
 83c:	210b000f 	tstcs	fp, pc
 840:	00134904 	andseq	r4, r3, r4, lsl #18
 844:	00260900 	eoreq	r0, r6, r0, lsl #18
 848:	00001349 	andeq	r1, r0, r9, asr #6
 84c:	0301040a 	movweq	r0, #5130	; 0x140a
 850:	3e196d0e 	cdpcc	13, 1, cr6, cr9, cr14, {0}
 854:	490b0b0b 	stmdbmi	fp, {r0, r1, r3, r8, r9, fp}
 858:	3b0b3a13 	blcc	2cf0ac <_bss_end+0x2c60a0>
 85c:	010b390b 	tsteq	fp, fp, lsl #18
 860:	0b000013 	bleq	8b4 <shift+0x8b4>
 864:	13470034 	movtne	r0, #28724	; 0x7034
 868:	020c0000 	andeq	r0, ip, #0
 86c:	0b0e0301 	bleq	381478 <_bss_end+0x37846c>
 870:	0b3a0421 	bleq	e818fc <_bss_end+0xe788f0>
 874:	21390b3b 	teqcs	r9, fp, lsr fp
 878:	00130107 	andseq	r0, r3, r7, lsl #2
 87c:	000d0d00 	andeq	r0, sp, r0, lsl #26
 880:	0b3a0e03 	bleq	e84094 <_bss_end+0xe7b088>
 884:	0b390b3b 	bleq	e43578 <_bss_end+0xe3a56c>
 888:	21381349 	teqcs	r8, r9, asr #6
 88c:	0e000000 	cdpeq	0, 0, cr0, cr0, cr0, {0}
 890:	0e030034 	mcreq	0, 0, r0, cr3, cr4, {1}
 894:	3b04213a 	blcc	108d84 <_bss_end+0xffd78>
 898:	1a21390b 	bne	84eccc <_bss_end+0x845cc0>
 89c:	193c1349 	ldmdbne	ip!, {r0, r3, r6, r8, r9, ip}
 8a0:	196c061c 	stmdbne	ip!, {r2, r3, r4, r9, sl}^
 8a4:	160f0000 	strne	r0, [pc], -r0
 8a8:	3a0e0300 	bcc	3814b0 <_bss_end+0x3784a4>
 8ac:	0b3b0221 	bleq	ec1138 <_bss_end+0xeb812c>
 8b0:	49072139 	stmdbmi	r7, {r0, r3, r4, r5, r8, sp}
 8b4:	10000013 	andne	r0, r0, r3, lsl r0
 8b8:	193f012e 	ldmdbne	pc!, {r1, r2, r3, r5, r8}	; <UNPREDICTABLE>
 8bc:	0b3a0e03 	bleq	e840d0 <_bss_end+0xe7b0c4>
 8c0:	0b390b3b 	bleq	e435b4 <_bss_end+0xe3a5a8>
 8c4:	21320e6e 	teqcs	r2, lr, ror #28
 8c8:	64193c01 	ldrvs	r3, [r9], #-3073	; 0xfffff3ff
 8cc:	11000013 	tstne	r0, r3, lsl r0
 8d0:	210b0010 	tstcs	fp, r0, lsl r0
 8d4:	00134904 	andseq	r4, r3, r4, lsl #18
 8d8:	00341200 	eorseq	r1, r4, r0, lsl #4
 8dc:	0b3a0e03 	bleq	e840f0 <_bss_end+0xe7b0e4>
 8e0:	0b390b3b 	bleq	e435d4 <_bss_end+0xe3a5c8>
 8e4:	193f1349 	ldmdbne	pc!, {r0, r3, r6, r8, r9, ip}	; <UNPREDICTABLE>
 8e8:	0000193c 	andeq	r1, r0, ip, lsr r9
 8ec:	25011113 	strcs	r1, [r1, #-275]	; 0xfffffeed
 8f0:	030b130e 	movweq	r1, #45838	; 0xb30e
 8f4:	110e1b0e 	tstne	lr, lr, lsl #22
 8f8:	10061201 	andne	r1, r6, r1, lsl #4
 8fc:	14000017 	strne	r0, [r0], #-23	; 0xffffffe9
 900:	0b0b0024 	bleq	2c0998 <_bss_end+0x2b798c>
 904:	08030b3e 	stmdaeq	r3, {r1, r2, r3, r4, r5, r8, r9, fp}
 908:	35150000 	ldrcc	r0, [r5, #-0]
 90c:	00134900 	andseq	r4, r3, r0, lsl #18
 910:	01391600 	teqeq	r9, r0, lsl #12
 914:	0b3a0803 	bleq	e82928 <_bss_end+0xe7991c>
 918:	0b390b3b 	bleq	e4360c <_bss_end+0xe3a600>
 91c:	00001301 	andeq	r1, r0, r1, lsl #6
 920:	03003417 	movweq	r3, #1047	; 0x417
 924:	3b0b3a0e 	blcc	2cf164 <_bss_end+0x2c6158>
 928:	490b390b 	stmdbmi	fp, {r0, r1, r3, r8, fp, ip, sp}
 92c:	1c193c13 	ldcne	12, cr3, [r9], {19}
 930:	00196c0b 	andseq	r6, r9, fp, lsl #24
 934:	00281800 	eoreq	r1, r8, r0, lsl #16
 938:	0b1c0803 	bleq	70294c <_bss_end+0x6f9940>
 93c:	04190000 	ldreq	r0, [r9], #-0
 940:	6d0e0301 	stcvs	3, cr0, [lr, #-4]
 944:	0b0b3e19 	bleq	2d01b0 <_bss_end+0x2c71a4>
 948:	3a13490b 	bcc	4d2d7c <_bss_end+0x4c9d70>
 94c:	390b3b0b 	stmdbcc	fp, {r0, r1, r3, r8, r9, fp, ip, sp}
 950:	1a00000b 	bne	984 <shift+0x984>
 954:	193f012e 	ldmdbne	pc!, {r1, r2, r3, r5, r8}	; <UNPREDICTABLE>
 958:	0b3a0e03 	bleq	e8416c <_bss_end+0xe7b160>
 95c:	0b390b3b 	bleq	e43650 <_bss_end+0xe3a644>
 960:	13490e6e 	movtne	r0, #40558	; 0x9e6e
 964:	193c0b32 	ldmdbne	ip!, {r1, r4, r5, r8, r9, fp}
 968:	00001364 	andeq	r1, r0, r4, ror #6
 96c:	0300281b 	movweq	r2, #2075	; 0x81b
 970:	00061c0e 	andeq	r1, r6, lr, lsl #24
 974:	00341c00 	eorseq	r1, r4, r0, lsl #24
 978:	0b3a0e03 	bleq	e8418c <_bss_end+0xe7b180>
 97c:	0b390b3b 	bleq	e43670 <_bss_end+0xe3a664>
 980:	196c1349 	stmdbne	ip!, {r0, r3, r6, r8, r9, ip}^
 984:	00001802 	andeq	r1, r0, r2, lsl #16
 988:	3f012e1d 	svccc	0x00012e1d
 98c:	3a0e0319 	bcc	3815f8 <_bss_end+0x3785ec>
 990:	390b3b0b 	stmdbcc	fp, {r0, r1, r3, r8, r9, fp, ip, sp}
 994:	1113490b 	tstne	r3, fp, lsl #18
 998:	40061201 	andmi	r1, r6, r1, lsl #4
 99c:	00197c18 	andseq	r7, r9, r8, lsl ip
 9a0:	00341e00 	eorseq	r1, r4, r0, lsl #28
 9a4:	0b3a0803 	bleq	e829b8 <_bss_end+0xe799ac>
 9a8:	0b390b3b 	bleq	e4369c <_bss_end+0xe3a690>
 9ac:	18021349 	stmdane	r2, {r0, r3, r6, r8, r9, ip}
 9b0:	01000000 	mrseq	r0, (UNDEF: 0)
 9b4:	17100011 			; <UNDEFINED> instruction: 0x17100011
 9b8:	0f120111 	svceq	0x00120111
 9bc:	0e1b0e03 	cdpeq	14, 1, cr0, cr11, cr3, {0}
 9c0:	05130e25 	ldreq	r0, [r3, #-3621]	; 0xfffff1db
 9c4:	01000000 	mrseq	r0, (UNDEF: 0)
 9c8:	0e030034 	mcreq	0, 0, r0, cr3, cr4, {1}
 9cc:	3b01213a 	blcc	48ebc <_bss_end+0x3feb0>
 9d0:	490b390b 	stmdbmi	fp, {r0, r1, r3, r8, fp, ip, sp}
 9d4:	3c193f13 	ldccc	15, cr3, [r9], {19}
 9d8:	02000019 	andeq	r0, r0, #25
 9dc:	210b000f 	tstcs	fp, pc
 9e0:	00134904 	andseq	r4, r3, r4, lsl #18
 9e4:	00160300 	andseq	r0, r6, r0, lsl #6
 9e8:	213a0e03 	teqcs	sl, r3, lsl #28
 9ec:	390b3b01 	stmdbcc	fp, {r0, r8, r9, fp, ip, sp}
 9f0:	13490721 	movtne	r0, #38689	; 0x9721
 9f4:	01040000 	mrseq	r0, (UNDEF: 4)
 9f8:	01134901 	tsteq	r3, r1, lsl #18
 9fc:	05000013 	streq	r0, [r0, #-19]	; 0xffffffed
 a00:	13490021 	movtne	r0, #36897	; 0x9021
 a04:	ffff212f 			; <UNDEFINED> instruction: 0xffff212f
 a08:	000fffff 	strdeq	pc, [pc], -pc	; <UNPREDICTABLE>
 a0c:	012e0600 			; <UNDEFINED> instruction: 0x012e0600
 a10:	0e03193f 			; <UNDEFINED> instruction: 0x0e03193f
 a14:	3b01213a 	blcc	48f04 <_bss_end+0x3fef8>
 a18:	1021390b 	eorne	r3, r1, fp, lsl #18
 a1c:	01111349 	tsteq	r1, r9, asr #6
 a20:	18400612 	stmdane	r0, {r1, r4, r9, sl}^
 a24:	1301197c 	movwne	r1, #6524	; 0x197c
 a28:	34070000 	strcc	r0, [r7], #-0
 a2c:	3a0e0300 	bcc	381634 <_bss_end+0x378628>
 a30:	0b3b0121 	bleq	ec0ebc <_bss_end+0xeb7eb0>
 a34:	490c2139 	stmdbmi	ip, {r0, r3, r4, r5, r8, sp}
 a38:	00180213 	andseq	r0, r8, r3, lsl r2
 a3c:	01110800 	tsteq	r1, r0, lsl #16
 a40:	0b130e25 	bleq	4c42dc <_bss_end+0x4bb2d0>
 a44:	0e1b0e03 	cdpeq	14, 1, cr0, cr11, cr3, {0}
 a48:	06120111 			; <UNDEFINED> instruction: 0x06120111
 a4c:	00001710 	andeq	r1, r0, r0, lsl r7
 a50:	00001509 	andeq	r1, r0, r9, lsl #10
 a54:	00240a00 	eoreq	r0, r4, r0, lsl #20
 a58:	0b3e0b0b 	bleq	f8368c <_bss_end+0xf7a680>
 a5c:	00000803 	andeq	r0, r0, r3, lsl #16
 a60:	0b00240b 	bleq	9a94 <_bss_end+0xa88>
 a64:	030b3e0b 	movweq	r3, #48651	; 0xbe0b
 a68:	0c00000e 	stceq	0, cr0, [r0], {14}
 a6c:	193f012e 	ldmdbne	pc!, {r1, r2, r3, r5, r8}	; <UNPREDICTABLE>
 a70:	0b3a0e03 	bleq	e84284 <_bss_end+0xe7b278>
 a74:	0b390b3b 	bleq	e43768 <_bss_end+0xe3a75c>
 a78:	01111349 	tsteq	r1, r9, asr #6
 a7c:	18400612 	stmdane	r0, {r1, r4, r9, sl}^
 a80:	1301197a 	movwne	r1, #6522	; 0x197a
 a84:	340d0000 	strcc	r0, [sp], #-0
 a88:	3a080300 	bcc	201690 <_bss_end+0x1f8684>
 a8c:	390b3b0b 	stmdbcc	fp, {r0, r1, r3, r8, r9, fp, ip, sp}
 a90:	0213490b 	andseq	r4, r3, #180224	; 0x2c000
 a94:	00000018 	andeq	r0, r0, r8, lsl r0
 a98:	10001101 	andne	r1, r0, r1, lsl #2
 a9c:	12011117 	andne	r1, r1, #-1073741819	; 0xc0000005
 aa0:	1b0e030f 	blne	3816e4 <_bss_end+0x3786d8>
 aa4:	130e250e 	movwne	r2, #58638	; 0xe50e
 aa8:	00000005 	andeq	r0, r0, r5
 aac:	10001101 	andne	r1, r0, r1, lsl #2
 ab0:	12011117 	andne	r1, r1, #-1073741819	; 0xc0000005
 ab4:	1b0e030f 	blne	3816f8 <_bss_end+0x3786ec>
 ab8:	130e250e 	movwne	r2, #58638	; 0xe50e
 abc:	00000005 	andeq	r0, r0, r5
 ac0:	03002801 	movweq	r2, #2049	; 0x801
 ac4:	000b1c0e 	andeq	r1, fp, lr, lsl #24
 ac8:	00240200 	eoreq	r0, r4, r0, lsl #4
 acc:	0b3e0b0b 	bleq	f83700 <_bss_end+0xf7a6f4>
 ad0:	00000e03 	andeq	r0, r0, r3, lsl #28
 ad4:	49010103 	stmdbmi	r1, {r0, r1, r8}
 ad8:	00130113 	andseq	r0, r3, r3, lsl r1
 adc:	000d0400 	andeq	r0, sp, r0, lsl #8
 ae0:	213a0e03 	teqcs	sl, r3, lsl #28
 ae4:	39053b02 	stmdbcc	r5, {r1, r8, r9, fp, ip, sp}
 ae8:	13491421 	movtne	r1, #37921	; 0x9421
 aec:	00000b38 	andeq	r0, r0, r8, lsr fp
 af0:	49002605 	stmdbmi	r0, {r0, r2, r9, sl, sp}
 af4:	06000013 			; <UNDEFINED> instruction: 0x06000013
 af8:	13490021 	movtne	r0, #36897	; 0x9021
 afc:	00000b2f 	andeq	r0, r0, pc, lsr #22
 b00:	03003407 	movweq	r3, #1031	; 0x407
 b04:	04213a0e 	strteq	r3, [r1], #-2574	; 0xfffff5f2
 b08:	21390b3b 	teqcs	r9, fp, lsr fp
 b0c:	3f134911 	svccc	0x00134911
 b10:	00193c19 	andseq	r3, r9, r9, lsl ip
 b14:	00340800 	eorseq	r0, r4, r0, lsl #16
 b18:	213a1347 	teqcs	sl, r7, asr #6
 b1c:	39053b01 	stmdbcc	r5, {r0, r8, r9, fp, ip, sp}
 b20:	13490a21 	movtne	r0, #39457	; 0x9a21
 b24:	00001802 	andeq	r1, r0, r2, lsl #16
 b28:	25011109 	strcs	r1, [r1, #-265]	; 0xfffffef7
 b2c:	030b130e 	movweq	r1, #45838	; 0xb30e
 b30:	100e1b0e 	andne	r1, lr, lr, lsl #22
 b34:	0a000017 	beq	b98 <shift+0xb98>
 b38:	0b0b0024 	bleq	2c0bd0 <_bss_end+0x2b7bc4>
 b3c:	08030b3e 	stmdaeq	r3, {r1, r2, r3, r4, r5, r8, r9, fp}
 b40:	040b0000 	streq	r0, [fp], #-0
 b44:	3e0e0301 	cdpcc	3, 0, cr0, cr14, cr1, {0}
 b48:	490b0b0b 	stmdbmi	fp, {r0, r1, r3, r8, r9, fp}
 b4c:	3b0b3a13 	blcc	2cf3a0 <_bss_end+0x2c6394>
 b50:	010b390b 	tsteq	fp, fp, lsl #18
 b54:	0c000013 	stceq	0, cr0, [r0], {19}
 b58:	0e030113 	mcreq	1, 0, r0, cr3, cr3, {0}
 b5c:	0b3a0b0b 	bleq	e83790 <_bss_end+0xe7a784>
 b60:	0b39053b 	bleq	e42054 <_bss_end+0xe39048>
 b64:	00001301 	andeq	r1, r0, r1, lsl #6
 b68:	0300340d 	movweq	r3, #1037	; 0x40d
 b6c:	3b0b3a0e 	blcc	2cf3ac <_bss_end+0x2c63a0>
 b70:	490b3905 	stmdbmi	fp, {r0, r2, r8, fp, ip, sp}
 b74:	000a1c13 	andeq	r1, sl, r3, lsl ip
 b78:	00150e00 	andseq	r0, r5, r0, lsl #28
 b7c:	00001927 	andeq	r1, r0, r7, lsr #18
 b80:	0b000f0f 	bleq	47c4 <shift+0x47c4>
 b84:	0013490b 	andseq	r4, r3, fp, lsl #18
 b88:	01041000 	mrseq	r1, (UNDEF: 4)
 b8c:	0b3e0e03 	bleq	f843a0 <_bss_end+0xf7b394>
 b90:	13490b0b 	movtne	r0, #39691	; 0x9b0b
 b94:	053b0b3a 	ldreq	r0, [fp, #-2874]!	; 0xfffff4c6
 b98:	13010b39 	movwne	r0, #6969	; 0x1b39
 b9c:	16110000 	ldrne	r0, [r1], -r0
 ba0:	3a0e0300 	bcc	3817a8 <_bss_end+0x37879c>
 ba4:	390b3b0b 	stmdbcc	fp, {r0, r1, r3, r8, r9, fp, ip, sp}
 ba8:	0013490b 	andseq	r4, r3, fp, lsl #18
 bac:	00211200 	eoreq	r1, r1, r0, lsl #4
 bb0:	Address 0x0000000000000bb0 is out of bounds.


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
  34:	000001c8 	andeq	r0, r0, r8, asr #3
	...
  40:	0000001c 	andeq	r0, r0, ip, lsl r0
  44:	04f60002 	ldrbteq	r0, [r6], #2
  48:	00040000 	andeq	r0, r4, r0
  4c:	00000000 	andeq	r0, r0, r0
  50:	000082b8 			; <UNDEFINED> instruction: 0x000082b8
  54:	00000500 	andeq	r0, r0, r0, lsl #10
	...
  60:	0000001c 	andeq	r0, r0, ip, lsl r0
  64:	0b490002 	bleq	1240074 <_bss_end+0x1237068>
  68:	00040000 	andeq	r0, r4, r0
  6c:	00000000 	andeq	r0, r0, r0
  70:	000087b8 			; <UNDEFINED> instruction: 0x000087b8
  74:	000002e8 	andeq	r0, r0, r8, ror #5
	...
  80:	0000001c 	andeq	r0, r0, ip, lsl r0
  84:	10710002 	rsbsne	r0, r1, r2
  88:	00040000 	andeq	r0, r4, r0
  8c:	00000000 	andeq	r0, r0, r0
  90:	00008aa0 	andeq	r8, r0, r0, lsr #21
  94:	000000f4 	strdeq	r0, [r0], -r4
	...
  a0:	0000001c 	andeq	r0, r0, ip, lsl r0
  a4:	16130002 	ldrne	r0, [r3], -r2
  a8:	00040000 	andeq	r0, r4, r0
  ac:	00000000 	andeq	r0, r0, r0
  b0:	00008000 	andeq	r8, r0, r0
  b4:	00000018 	andeq	r0, r0, r8, lsl r0
	...
  c0:	0000001c 	andeq	r0, r0, ip, lsl r0
  c4:	16370002 	ldrtne	r0, [r7], -r2
  c8:	00040000 	andeq	r0, r4, r0
  cc:	00000000 	andeq	r0, r0, r0
  d0:	00008b94 	muleq	r0, r4, fp
  d4:	00000118 	andeq	r0, r0, r8, lsl r1
	...
  e0:	0000001c 	andeq	r0, r0, ip, lsl r0
  e4:	17690002 	strbne	r0, [r9, -r2]!
  e8:	00040000 	andeq	r0, r4, r0
  ec:	00000000 	andeq	r0, r0, r0
  f0:	00008cac 	andeq	r8, r0, ip, lsr #25
  f4:	0000020c 	andeq	r0, r0, ip, lsl #4
	...
 100:	0000001c 	andeq	r0, r0, ip, lsl r0
 104:	178e0002 	strne	r0, [lr, r2]
 108:	00040000 	andeq	r0, r4, r0
 10c:	00000000 	andeq	r0, r0, r0
 110:	00008eb8 			; <UNDEFINED> instruction: 0x00008eb8
 114:	00000004 	andeq	r0, r0, r4
	...
 120:	00000014 	andeq	r0, r0, r4, lsl r0
 124:	17b20002 	ldrne	r0, [r2, r2]!
 128:	00040000 	andeq	r0, r4, r0
	...

Disassembly of section .debug_line:

00000000 <.debug_line>:
   0:	00000089 	andeq	r0, r0, r9, lsl #1
   4:	00500003 	subseq	r0, r0, r3
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
  34:	3378652f 	cmncc	r8, #197132288	; 0xbc00000
  38:	69726f2f 	ldmdbvs	r2!, {r0, r1, r2, r3, r5, r8, r9, sl, fp, sp, lr}^
  3c:	616e6967 	cmnvs	lr, r7, ror #18
  40:	656b2f6c 	strbvs	r2, [fp, #-3948]!	; 0xfffff094
  44:	6c656e72 	stclvs	14, cr6, [r5], #-456	; 0xfffffe38
  48:	6372732f 	cmnvs	r2, #-1140850688	; 0xbc000000
  4c:	78630000 	stmdavc	r3!, {}^	; <UNPREDICTABLE>
  50:	70632e78 	rsbvc	r2, r3, r8, ror lr
  54:	00010070 	andeq	r0, r1, r0, ror r0
  58:	02050000 	andeq	r0, r5, #0
  5c:	18020500 	stmdane	r2, {r8, sl}
  60:	03000080 	movweq	r0, #128	; 0x80
  64:	0b05010a 	bleq	140494 <_bss_end+0x137488>
  68:	4a0a0583 	bmi	28167c <_bss_end+0x278670>
  6c:	85830205 	strhi	r0, [r3, #517]	; 0x205
  70:	05830e05 	streq	r0, [r3, #3589]	; 0xe05
  74:	84856702 	strhi	r6, [r5], #1794	; 0x702
  78:	4c860105 	stfmis	f0, [r6], {5}
  7c:	4c854c85 	stcmi	12, cr4, [r5], {133}	; 0x85
  80:	00020585 	andeq	r0, r2, r5, lsl #11
  84:	4b010402 	blmi	41094 <_bss_end+0x38088>
  88:	01000202 	tsteq	r0, r2, lsl #4
  8c:	00017901 	andeq	r7, r1, r1, lsl #18
  90:	09000300 	stmdbeq	r0, {r8, r9}
  94:	02000001 	andeq	r0, r0, #1
  98:	0d0efb01 	vstreq	d15, [lr, #-4]
  9c:	01010100 	mrseq	r0, (UNDEF: 17)
  a0:	00000001 	andeq	r0, r0, r1
  a4:	01000001 	tsteq	r0, r1
  a8:	6d6f682f 	stclvs	8, cr6, [pc, #-188]!	; fffffff4 <_bss_end+0xffff6fe8>
  ac:	66632f65 	strbtvs	r2, [r3], -r5, ror #30
  b0:	55435a2f 	strbpl	r5, [r3, #-2607]	; 0xfffff5d1
  b4:	2f534f2f 	svccs	0x00534f2f
  b8:	63617270 	cmnvs	r1, #112, 4
  bc:	61636974 	smcvs	13972	; 0x3694
  c0:	78652f6c 	stmdavc	r5!, {r2, r3, r5, r6, r8, r9, sl, fp, sp}^
  c4:	726f2f33 	rsbvc	r2, pc, #51, 30	; 0xcc
  c8:	6e696769 	cdpvs	7, 6, cr6, cr9, cr9, {3}
  cc:	6b2f6c61 	blvs	bdb258 <_bss_end+0xbd224c>
  d0:	656e7265 	strbvs	r7, [lr, #-613]!	; 0xfffffd9b
  d4:	72732f6c 	rsbsvc	r2, r3, #108, 30	; 0x1b0
  d8:	72642f63 	rsbvc	r2, r4, #396	; 0x18c
  dc:	72657669 	rsbvc	r7, r5, #110100480	; 0x6900000
  e0:	682f0073 	stmdavs	pc!, {r0, r1, r4, r5, r6}	; <UNPREDICTABLE>
  e4:	2f656d6f 	svccs	0x00656d6f
  e8:	5a2f6663 	bpl	bd9a7c <_bss_end+0xbd0a70>
  ec:	4f2f5543 	svcmi	0x002f5543
  f0:	72702f53 	rsbsvc	r2, r0, #332	; 0x14c
  f4:	69746361 	ldmdbvs	r4!, {r0, r5, r6, r8, r9, sp, lr}^
  f8:	2f6c6163 	svccs	0x006c6163
  fc:	2f337865 	svccs	0x00337865
 100:	6769726f 	strbvs	r7, [r9, -pc, ror #4]!
 104:	6c616e69 	stclvs	14, cr6, [r1], #-420	; 0xfffffe5c
 108:	72656b2f 	rsbvc	r6, r5, #48128	; 0xbc00
 10c:	2f6c656e 	svccs	0x006c656e
 110:	6c636e69 	stclvs	14, cr6, [r3], #-420	; 0xfffffe5c
 114:	2f656475 	svccs	0x00656475
 118:	72616f62 	rsbvc	r6, r1, #392	; 0x188
 11c:	70722f64 	rsbsvc	r2, r2, r4, ror #30
 120:	682f3069 	stmdavs	pc!, {r0, r3, r5, r6, ip, sp}	; <UNPREDICTABLE>
 124:	2f006c61 	svccs	0x00006c61
 128:	656d6f68 	strbvs	r6, [sp, #-3944]!	; 0xfffff098
 12c:	2f66632f 	svccs	0x0066632f
 130:	2f55435a 	svccs	0x0055435a
 134:	702f534f 	eorvc	r5, pc, pc, asr #6
 138:	74636172 	strbtvc	r6, [r3], #-370	; 0xfffffe8e
 13c:	6c616369 	stclvs	3, cr6, [r1], #-420	; 0xfffffe5c
 140:	3378652f 	cmncc	r8, #197132288	; 0xbc00000
 144:	69726f2f 	ldmdbvs	r2!, {r0, r1, r2, r3, r5, r8, r9, sl, fp, sp, lr}^
 148:	616e6967 	cmnvs	lr, r7, ror #18
 14c:	656b2f6c 	strbvs	r2, [fp, #-3948]!	; 0xfffff094
 150:	6c656e72 	stclvs	14, cr6, [r5], #-456	; 0xfffffe38
 154:	636e692f 	cmnvs	lr, #770048	; 0xbc000
 158:	6564756c 	strbvs	r7, [r4, #-1388]!	; 0xfffffa94
 15c:	6972642f 	ldmdbvs	r2!, {r0, r1, r2, r3, r5, sl, sp, lr}^
 160:	73726576 	cmnvc	r2, #494927872	; 0x1d800000
 164:	63620000 	cmnvs	r2, #0
 168:	75615f6d 	strbvc	r5, [r1, #-3949]!	; 0xfffff093
 16c:	70632e78 	rsbvc	r2, r3, r8, ror lr
 170:	00010070 	andeq	r0, r1, r0, ror r0
 174:	72657000 	rsbvc	r7, r5, #0
 178:	65687069 	strbvs	r7, [r8, #-105]!	; 0xffffff97
 17c:	736c6172 	cmnvc	ip, #-2147483620	; 0x8000001c
 180:	0200682e 	andeq	r6, r0, #3014656	; 0x2e0000
 184:	63620000 	cmnvs	r2, #0
 188:	75615f6d 	strbvc	r5, [r1, #-3949]!	; 0xfffff093
 18c:	00682e78 	rsbeq	r2, r8, r8, ror lr
 190:	69000003 	stmdbvs	r0, {r0, r1}
 194:	6564746e 	strbvs	r7, [r4, #-1134]!	; 0xfffffb92
 198:	00682e66 	rsbeq	r2, r8, r6, ror #28
 19c:	00000002 	andeq	r0, r0, r2
 1a0:	05000105 	streq	r0, [r0, #-261]	; 0xfffffefb
 1a4:	0080f002 	addeq	pc, r0, r2
 1a8:	07051600 	streq	r1, [r5, -r0, lsl #12]
 1ac:	6901059f 	stmdbvs	r1, {r0, r1, r2, r3, r4, r7, r8, sl}
 1b0:	9f3505a1 	svcls	0x003505a1
 1b4:	05825505 	streq	r5, [r2, #1285]	; 0x505
 1b8:	11052e52 	tstne	r5, r2, asr lr
 1bc:	9f01054a 	svcls	0x0001054a
 1c0:	9f350569 	svcls	0x00350569
 1c4:	05825605 	streq	r5, [r2, #1541]	; 0x605
 1c8:	4f052e53 	svcmi	0x00052e53
 1cc:	2e11054a 	cfmac32cs	mvfx0, mvfx1, mvfx10
 1d0:	699f0105 	ldmibvs	pc, {r0, r2, r8}	; <UNPREDICTABLE>
 1d4:	05bb0505 	ldreq	r0, [fp, #1285]!	; 0x505
 1d8:	30054a0e 	andcc	r4, r5, lr, lsl #20
 1dc:	4a32052e 	bmi	c8169c <_bss_end+0xc78690>
 1e0:	854b0105 	strbhi	r0, [fp, #-261]	; 0xfffffefb
 1e4:	059f0c05 	ldreq	r0, [pc, #3077]	; df1 <shift+0xdf1>
 1e8:	37054a15 	smladcc	r5, r5, sl, r4
 1ec:	6701052e 	strvs	r0, [r1, -lr, lsr #10]
 1f0:	02009e82 	andeq	r9, r0, #2080	; 0x820
 1f4:	66060104 	strvs	r0, [r6], -r4, lsl #2
 1f8:	03061805 	movweq	r1, #26629	; 0x6805
 1fc:	01058266 	tsteq	r5, r6, ror #4
 200:	ba661a03 	blt	1986a14 <_bss_end+0x197da08>
 204:	000a024a 	andeq	r0, sl, sl, asr #4
 208:	02b80101 	adcseq	r0, r8, #1073741824	; 0x40000000
 20c:	00030000 	andeq	r0, r3, r0
 210:	00000103 	andeq	r0, r0, r3, lsl #2
 214:	0efb0102 	cdpeq	1, 15, cr0, cr11, cr2, {0}
 218:	0101000d 	tsteq	r1, sp
 21c:	00000101 	andeq	r0, r0, r1, lsl #2
 220:	00000100 	andeq	r0, r0, r0, lsl #2
 224:	6f682f01 	svcvs	0x00682f01
 228:	632f656d 			; <UNDEFINED> instruction: 0x632f656d
 22c:	435a2f66 	cmpmi	sl, #408	; 0x198
 230:	534f2f55 	movtpl	r2, #65365	; 0xff55
 234:	6172702f 	cmnvs	r2, pc, lsr #32
 238:	63697463 	cmnvs	r9, #1660944384	; 0x63000000
 23c:	652f6c61 	strvs	r6, [pc, #-3169]!	; fffff5e3 <_bss_end+0xffff65d7>
 240:	6f2f3378 	svcvs	0x002f3378
 244:	69676972 	stmdbvs	r7!, {r1, r4, r5, r6, r8, fp, sp, lr}^
 248:	2f6c616e 	svccs	0x006c616e
 24c:	6e72656b 	cdpvs	5, 7, cr6, cr2, cr11, {3}
 250:	732f6c65 			; <UNDEFINED> instruction: 0x732f6c65
 254:	642f6372 	strtvs	r6, [pc], #-882	; 25c <shift+0x25c>
 258:	65766972 	ldrbvs	r6, [r6, #-2418]!	; 0xfffff68e
 25c:	2f007372 	svccs	0x00007372
 260:	656d6f68 	strbvs	r6, [sp, #-3944]!	; 0xfffff098
 264:	2f66632f 	svccs	0x0066632f
 268:	2f55435a 	svccs	0x0055435a
 26c:	702f534f 	eorvc	r5, pc, pc, asr #6
 270:	74636172 	strbtvc	r6, [r3], #-370	; 0xfffffe8e
 274:	6c616369 	stclvs	3, cr6, [r1], #-420	; 0xfffffe5c
 278:	3378652f 	cmncc	r8, #197132288	; 0xbc00000
 27c:	69726f2f 	ldmdbvs	r2!, {r0, r1, r2, r3, r5, r8, r9, sl, fp, sp, lr}^
 280:	616e6967 	cmnvs	lr, r7, ror #18
 284:	656b2f6c 	strbvs	r2, [fp, #-3948]!	; 0xfffff094
 288:	6c656e72 	stclvs	14, cr6, [r5], #-456	; 0xfffffe38
 28c:	636e692f 	cmnvs	lr, #770048	; 0xbc000
 290:	6564756c 	strbvs	r7, [r4, #-1388]!	; 0xfffffa94
 294:	616f622f 	cmnvs	pc, pc, lsr #4
 298:	722f6472 	eorvc	r6, pc, #1912602624	; 0x72000000
 29c:	2f306970 	svccs	0x00306970
 2a0:	006c6168 	rsbeq	r6, ip, r8, ror #2
 2a4:	6d6f682f 	stclvs	8, cr6, [pc, #-188]!	; 1f0 <shift+0x1f0>
 2a8:	66632f65 	strbtvs	r2, [r3], -r5, ror #30
 2ac:	55435a2f 	strbpl	r5, [r3, #-2607]	; 0xfffff5d1
 2b0:	2f534f2f 	svccs	0x00534f2f
 2b4:	63617270 	cmnvs	r1, #112, 4
 2b8:	61636974 	smcvs	13972	; 0x3694
 2bc:	78652f6c 	stmdavc	r5!, {r2, r3, r5, r6, r8, r9, sl, fp, sp}^
 2c0:	726f2f33 	rsbvc	r2, pc, #51, 30	; 0xcc
 2c4:	6e696769 	cdpvs	7, 6, cr6, cr9, cr9, {3}
 2c8:	6b2f6c61 	blvs	bdb454 <_bss_end+0xbd2448>
 2cc:	656e7265 	strbvs	r7, [lr, #-613]!	; 0xfffffd9b
 2d0:	6e692f6c 	cdpvs	15, 6, cr2, cr9, cr12, {3}
 2d4:	64756c63 	ldrbtvs	r6, [r5], #-3171	; 0xfffff39d
 2d8:	72642f65 	rsbvc	r2, r4, #404	; 0x194
 2dc:	72657669 	rsbvc	r7, r5, #110100480	; 0x6900000
 2e0:	67000073 	smlsdxvs	r0, r3, r0, r0
 2e4:	2e6f6970 			; <UNDEFINED> instruction: 0x2e6f6970
 2e8:	00707063 	rsbseq	r7, r0, r3, rrx
 2ec:	69000001 	stmdbvs	r0, {r0}
 2f0:	6564746e 	strbvs	r7, [r4, #-1134]!	; 0xfffffb92
 2f4:	00682e66 	rsbeq	r2, r8, r6, ror #28
 2f8:	70000002 	andvc	r0, r0, r2
 2fc:	70697265 	rsbvc	r7, r9, r5, ror #4
 300:	61726568 	cmnvs	r2, r8, ror #10
 304:	682e736c 	stmdavs	lr!, {r2, r3, r5, r6, r8, r9, ip, sp, lr}
 308:	00000200 	andeq	r0, r0, r0, lsl #4
 30c:	6f697067 	svcvs	0x00697067
 310:	0300682e 	movweq	r6, #2094	; 0x82e
 314:	05000000 	streq	r0, [r0, #-0]
 318:	02050001 	andeq	r0, r5, #1
 31c:	000082b8 			; <UNDEFINED> instruction: 0x000082b8
 320:	9f040517 	svcls	0x00040517
 324:	a1690105 	cmnge	r9, r5, lsl #2
 328:	05d70205 	ldrbeq	r0, [r7, #517]	; 0x205
 32c:	0e05670a 	cdpeq	7, 0, cr6, cr5, cr10, {0}
 330:	8202054c 	andhi	r0, r2, #76, 10	; 0x13000000
 334:	22080f05 	andcs	r0, r8, #5, 30
 338:	05664005 	strbeq	r4, [r6, #-5]!
 33c:	40052f0f 	andmi	r2, r5, pc, lsl #30
 340:	2f0f0566 	svccs	0x000f0566
 344:	05664005 	strbeq	r4, [r6, #-5]!
 348:	40052f0f 	andmi	r2, r5, pc, lsl #30
 34c:	2f0f0566 	svccs	0x000f0566
 350:	05664005 	strbeq	r4, [r6, #-5]!
 354:	40052f0f 	andmi	r2, r5, pc, lsl #30
 358:	31110566 	tstcc	r1, r6, ror #10
 35c:	20081705 	andcs	r1, r8, r5, lsl #14
 360:	05660a05 	strbeq	r0, [r6, #-2565]!	; 0xfffff5fb
 364:	01054c09 	tsteq	r5, r9, lsl #24
 368:	0205a12f 	andeq	sl, r5, #-1073741813	; 0xc000000b
 36c:	670a05d7 			; <UNDEFINED> instruction: 0x670a05d7
 370:	004c0805 	subeq	r0, ip, r5, lsl #16
 374:	06010402 	streq	r0, [r1], -r2, lsl #8
 378:	04020066 	streq	r0, [r2], #-102	; 0xffffff9a
 37c:	06054a02 	streq	r4, [r5], -r2, lsl #20
 380:	04040200 	streq	r0, [r4], #-512	; 0xfffffe00
 384:	10052e06 	andne	r2, r5, r6, lsl #28
 388:	04040200 	streq	r0, [r4], #-512	; 0xfffffe00
 38c:	000a054b 	andeq	r0, sl, fp, asr #10
 390:	4a040402 	bmi	1013a0 <_bss_end+0xf8394>
 394:	02000905 	andeq	r0, r0, #81920	; 0x14000
 398:	054c0404 	strbeq	r0, [ip, #-1028]	; 0xfffffbfc
 39c:	05852f01 	streq	r2, [r5, #3841]	; 0xf01
 3a0:	0a05d702 	beq	175fb0 <_bss_end+0x16cfa4>
 3a4:	4c080567 	cfstr32mi	mvfx0, [r8], {103}	; 0x67
 3a8:	01040200 	mrseq	r0, R12_usr
 3ac:	02006606 	andeq	r6, r0, #6291456	; 0x600000
 3b0:	054a0204 	strbeq	r0, [sl, #-516]	; 0xfffffdfc
 3b4:	04020006 	streq	r0, [r2], #-6
 3b8:	052e0604 	streq	r0, [lr, #-1540]!	; 0xfffff9fc
 3bc:	04020010 	streq	r0, [r2], #-16
 3c0:	0a054b04 	beq	152fd8 <_bss_end+0x149fcc>
 3c4:	04040200 	streq	r0, [r4], #-512	; 0xfffffe00
 3c8:	0009054a 	andeq	r0, r9, sl, asr #10
 3cc:	4c040402 	cfstrsmi	mvf0, [r4], {2}
 3d0:	852f0105 	strhi	r0, [pc, #-261]!	; 2d3 <shift+0x2d3>
 3d4:	05d70205 	ldrbeq	r0, [r7, #517]	; 0x205
 3d8:	0805670a 	stmdaeq	r5, {r1, r3, r8, r9, sl, sp, lr}
 3dc:	0402004c 	streq	r0, [r2], #-76	; 0xffffffb4
 3e0:	00660601 	rsbeq	r0, r6, r1, lsl #12
 3e4:	4a020402 	bmi	813f4 <_bss_end+0x783e8>
 3e8:	02000605 	andeq	r0, r0, #5242880	; 0x500000
 3ec:	2e060404 	cdpcs	4, 0, cr0, cr6, cr4, {0}
 3f0:	02001005 	andeq	r1, r0, #5
 3f4:	054b0404 	strbeq	r0, [fp, #-1028]	; 0xfffffbfc
 3f8:	0402000a 	streq	r0, [r2], #-10
 3fc:	09054a04 	stmdbeq	r5, {r2, r9, fp, lr}
 400:	04040200 	streq	r0, [r4], #-512	; 0xfffffe00
 404:	2f01054c 	svccs	0x0001054c
 408:	d8190585 	ldmdale	r9, {r0, r2, r7, r8, sl}
 40c:	05ba0205 	ldreq	r0, [sl, #517]!	; 0x205
 410:	19054d10 	stmdbne	r5, {r4, r8, sl, fp, lr}
 414:	823b054a 	eorshi	r0, fp, #310378496	; 0x12800000
 418:	05661e05 	strbeq	r1, [r6, #-3589]!	; 0xfffff1fb
 41c:	08052e1b 	stmdaeq	r5, {r0, r1, r3, r4, r9, sl, fp, sp}
 420:	2e28052f 	cfsh64cs	mvdx0, mvdx8, #31
 424:	05490205 	strbeq	r0, [r9, #-517]	; 0xfffffdfb
 428:	05054a0b 	streq	r4, [r5, #-2571]	; 0xfffff5f5
 42c:	2d0d0567 	cfstr32cs	mvfx0, [sp, #-412]	; 0xfffffe64
 430:	05480305 	strbeq	r0, [r8, #-773]	; 0xfffffcfb
 434:	054d3201 	strbeq	r3, [sp, #-513]	; 0xfffffdff
 438:	0205a019 	andeq	sl, r5, #25
 43c:	4b1a05ba 	blmi	681b2c <_bss_end+0x678b20>
 440:	054c2605 	strbeq	r2, [ip, #-1541]	; 0xfffff9fb
 444:	31054a2f 	tstcc	r5, pc, lsr #20
 448:	4a090582 	bmi	241a58 <_bss_end+0x238a4c>
 44c:	052e3c05 	streq	r3, [lr, #-3077]!	; 0xfffff3fb
 450:	04020001 	streq	r0, [r2], #-1
 454:	05694b01 	strbeq	r4, [r9, #-2817]!	; 0xfffff4ff
 458:	3205d808 	andcc	sp, r5, #8, 16	; 0x80000
 45c:	00210566 	eoreq	r0, r1, r6, ror #10
 460:	4a020402 	bmi	81470 <_bss_end+0x78464>
 464:	02000605 	andeq	r0, r0, #5242880	; 0x500000
 468:	05f20204 	ldrbeq	r0, [r2, #516]!	; 0x204
 46c:	04020032 	streq	r0, [r2], #-50	; 0xffffffce
 470:	51054a03 	tstpl	r5, r3, lsl #20
 474:	06040200 	streq	r0, [r4], -r0, lsl #4
 478:	00350566 	eorseq	r0, r5, r6, ror #10
 47c:	f2060402 	vshl.s8	d0, d2, d6
 480:	02003205 	andeq	r3, r0, #1342177280	; 0x50000000
 484:	004a0704 	subeq	r0, sl, r4, lsl #14
 488:	06080402 	streq	r0, [r8], -r2, lsl #8
 48c:	0002054a 	andeq	r0, r2, sl, asr #10
 490:	060a0402 	streq	r0, [sl], -r2, lsl #8
 494:	4d12052e 	cfldr32mi	mvfx0, [r2, #-184]	; 0xffffff48
 498:	05660205 	strbeq	r0, [r6, #-517]!	; 0xfffffdfb
 49c:	12054a0b 	andne	r4, r5, #45056	; 0xb000
 4a0:	2e0d0566 	cfsh32cs	mvfx0, mvfx13, #54
 4a4:	05480305 	strbeq	r0, [r8, #-773]	; 0xfffffcfb
 4a8:	9e4a3101 	dvflse	f3, f2, f1
 4ac:	01040200 	mrseq	r0, R12_usr
 4b0:	23056606 	movwcs	r6, #22022	; 0x5606
 4b4:	7fa90306 	svcvc	0x00a90306
 4b8:	03010582 	movweq	r0, #5506	; 0x1582
 4bc:	ba6600d7 	blt	1980820 <_bss_end+0x1977814>
 4c0:	000a024a 	andeq	r0, sl, sl, asr #4
 4c4:	01fa0101 	mvnseq	r0, r1, lsl #2
 4c8:	00030000 	andeq	r0, r3, r0
 4cc:	00000110 	andeq	r0, r0, r0, lsl r1
 4d0:	0efb0102 	cdpeq	1, 15, cr0, cr11, cr2, {0}
 4d4:	0101000d 	tsteq	r1, sp
 4d8:	00000101 	andeq	r0, r0, r1, lsl #2
 4dc:	00000100 	andeq	r0, r0, r0, lsl #2
 4e0:	6f682f01 	svcvs	0x00682f01
 4e4:	632f656d 			; <UNDEFINED> instruction: 0x632f656d
 4e8:	435a2f66 	cmpmi	sl, #408	; 0x198
 4ec:	534f2f55 	movtpl	r2, #65365	; 0xff55
 4f0:	6172702f 	cmnvs	r2, pc, lsr #32
 4f4:	63697463 	cmnvs	r9, #1660944384	; 0x63000000
 4f8:	652f6c61 	strvs	r6, [pc, #-3169]!	; fffff89f <_bss_end+0xffff6893>
 4fc:	6f2f3378 	svcvs	0x002f3378
 500:	69676972 	stmdbvs	r7!, {r1, r4, r5, r6, r8, fp, sp, lr}^
 504:	2f6c616e 	svccs	0x006c616e
 508:	6e72656b 	cdpvs	5, 7, cr6, cr2, cr11, {3}
 50c:	732f6c65 			; <UNDEFINED> instruction: 0x732f6c65
 510:	642f6372 	strtvs	r6, [pc], #-882	; 518 <shift+0x518>
 514:	65766972 	ldrbvs	r6, [r6, #-2418]!	; 0xfffff68e
 518:	2f007372 	svccs	0x00007372
 51c:	656d6f68 	strbvs	r6, [sp, #-3944]!	; 0xfffff098
 520:	2f66632f 	svccs	0x0066632f
 524:	2f55435a 	svccs	0x0055435a
 528:	702f534f 	eorvc	r5, pc, pc, asr #6
 52c:	74636172 	strbtvc	r6, [r3], #-370	; 0xfffffe8e
 530:	6c616369 	stclvs	3, cr6, [r1], #-420	; 0xfffffe5c
 534:	3378652f 	cmncc	r8, #197132288	; 0xbc00000
 538:	69726f2f 	ldmdbvs	r2!, {r0, r1, r2, r3, r5, r8, r9, sl, fp, sp, lr}^
 53c:	616e6967 	cmnvs	lr, r7, ror #18
 540:	656b2f6c 	strbvs	r2, [fp, #-3948]!	; 0xfffff094
 544:	6c656e72 	stclvs	14, cr6, [r5], #-456	; 0xfffffe38
 548:	636e692f 	cmnvs	lr, #770048	; 0xbc000
 54c:	6564756c 	strbvs	r7, [r4, #-1388]!	; 0xfffffa94
 550:	616f622f 	cmnvs	pc, pc, lsr #4
 554:	722f6472 	eorvc	r6, pc, #1912602624	; 0x72000000
 558:	2f306970 	svccs	0x00306970
 55c:	006c6168 	rsbeq	r6, ip, r8, ror #2
 560:	6d6f682f 	stclvs	8, cr6, [pc, #-188]!	; 4ac <shift+0x4ac>
 564:	66632f65 	strbtvs	r2, [r3], -r5, ror #30
 568:	55435a2f 	strbpl	r5, [r3, #-2607]	; 0xfffff5d1
 56c:	2f534f2f 	svccs	0x00534f2f
 570:	63617270 	cmnvs	r1, #112, 4
 574:	61636974 	smcvs	13972	; 0x3694
 578:	78652f6c 	stmdavc	r5!, {r2, r3, r5, r6, r8, r9, sl, fp, sp}^
 57c:	726f2f33 	rsbvc	r2, pc, #51, 30	; 0xcc
 580:	6e696769 	cdpvs	7, 6, cr6, cr9, cr9, {3}
 584:	6b2f6c61 	blvs	bdb710 <_bss_end+0xbd2704>
 588:	656e7265 	strbvs	r7, [lr, #-613]!	; 0xfffffd9b
 58c:	6e692f6c 	cdpvs	15, 6, cr2, cr9, cr12, {3}
 590:	64756c63 	ldrbtvs	r6, [r5], #-3171	; 0xfffff39d
 594:	72642f65 	rsbvc	r2, r4, #404	; 0x194
 598:	72657669 	rsbvc	r7, r5, #110100480	; 0x6900000
 59c:	75000073 	strvc	r0, [r0, #-115]	; 0xffffff8d
 5a0:	2e747261 	cdpcs	2, 7, cr7, cr4, cr1, {3}
 5a4:	00707063 	rsbseq	r7, r0, r3, rrx
 5a8:	70000001 	andvc	r0, r0, r1
 5ac:	70697265 	rsbvc	r7, r9, r5, ror #4
 5b0:	61726568 	cmnvs	r2, r8, ror #10
 5b4:	682e736c 	stmdavs	lr!, {r2, r3, r5, r6, r8, r9, ip, sp, lr}
 5b8:	00000200 	andeq	r0, r0, r0, lsl #4
 5bc:	5f6d6362 	svcpl	0x006d6362
 5c0:	2e787561 	cdpcs	5, 7, cr7, cr8, cr1, {3}
 5c4:	00030068 	andeq	r0, r3, r8, rrx
 5c8:	72617500 	rsbvc	r7, r1, #0, 10
 5cc:	00682e74 	rsbeq	r2, r8, r4, ror lr
 5d0:	69000003 	stmdbvs	r0, {r0, r1}
 5d4:	6564746e 	strbvs	r7, [r4, #-1134]!	; 0xfffffb92
 5d8:	00682e66 	rsbeq	r2, r8, r6, ror #28
 5dc:	00000002 	andeq	r0, r0, r2
 5e0:	05000105 	streq	r0, [r0, #-261]	; 0xfffffefb
 5e4:	0087b802 	addeq	fp, r7, r2, lsl #16
 5e8:	07051700 	streq	r1, [r5, -r0, lsl #14]
 5ec:	6805059f 	stmdavs	r5, {r0, r1, r2, r3, r4, r7, r8, sl}
 5f0:	054a1005 	strbeq	r1, [sl, #-5]
 5f4:	16056805 	strne	r6, [r5], -r5, lsl #16
 5f8:	8305054a 	movwhi	r0, #21834	; 0x554a
 5fc:	054a1605 	strbeq	r1, [sl, #-1541]	; 0xfffff9fb
 600:	16058305 	strne	r8, [r5], -r5, lsl #6
 604:	8305054a 	movwhi	r0, #21834	; 0x554a
 608:	054a1605 	strbeq	r1, [sl, #-1541]	; 0xfffff9fb
 60c:	05858301 	streq	r8, [r5, #769]	; 0x301
 610:	2e059f05 	cdpcs	15, 0, cr9, cr5, cr5, {0}
 614:	4a3f054a 	bmi	fc1b44 <_bss_end+0xfb8b38>
 618:	05825605 	streq	r5, [r2, #1541]	; 0x605
 61c:	16052e66 	strne	r2, [r5], -r6, ror #28
 620:	9f01052e 	svcls	0x0001052e
 624:	9f1c0569 	svcls	0x001c0569
 628:	054b2d05 	strbeq	r2, [fp, #-3333]	; 0xfffff2fb
 62c:	18052e53 	stmdane	r5, {r0, r1, r4, r6, r9, sl, fp, sp}
 630:	4c050582 	cfstr32mi	mvfx0, [r5], {130}	; 0x82
 634:	054a1605 	strbeq	r1, [sl, #-1541]	; 0xfffff9fb
 638:	16058405 	strne	r8, [r5], -r5, lsl #8
 63c:	8405054a 	strhi	r0, [r5], #-1354	; 0xfffffab6
 640:	054a1605 	strbeq	r1, [sl, #-1541]	; 0xfffff9fb
 644:	05a18301 	streq	r8, [r1, #769]!	; 0x301
 648:	0e05bc05 	cdpeq	12, 0, cr11, cr5, cr5, {0}
 64c:	01040200 	mrseq	r0, R12_usr
 650:	001f052e 	andseq	r0, pc, lr, lsr #10
 654:	4a010402 	bmi	41664 <_bss_end+0x38658>
 658:	02003605 	andeq	r3, r0, #5242880	; 0x500000
 65c:	05820104 	streq	r0, [r2, #260]	; 0x104
 660:	0402000c 	streq	r0, [r2], #-12
 664:	05052e01 	streq	r2, [r5, #-3585]	; 0xfffff1ff
 668:	4a1605bd 	bmi	581d64 <_bss_end+0x578d58>
 66c:	69830105 	stmibvs	r3, {r0, r2, r8}
 670:	05a10c05 	streq	r0, [r1, #3077]!	; 0xc05
 674:	13054a05 	movwne	r4, #23045	; 0x5a05
 678:	03040200 	movweq	r0, #16896	; 0x4200
 67c:	0014052f 	andseq	r0, r4, pc, lsr #10
 680:	2e030402 	cdpcs	4, 0, cr0, cr3, cr2, {0}
 684:	02000e05 	andeq	r0, r0, #5, 28	; 0x50
 688:	054a0304 	strbeq	r0, [sl, #-772]	; 0xfffffcfc
 68c:	04020005 	streq	r0, [r2], #-5
 690:	15058103 	strne	r8, [r5, #-259]	; 0xfffffefd
 694:	01040200 	mrseq	r0, R12_usr
 698:	00160566 	andseq	r0, r6, r6, ror #10
 69c:	2e010402 	cdpcs	4, 0, cr0, cr1, cr2, {0}
 6a0:	02001805 	andeq	r1, r0, #327680	; 0x50000
 6a4:	05660104 	strbeq	r0, [r6, #-260]!	; 0xfffffefc
 6a8:	9e824c01 	cdpls	12, 8, cr4, cr2, cr1, {0}
 6ac:	01040200 	mrseq	r0, R12_usr
 6b0:	12056606 	andne	r6, r5, #6291456	; 0x600000
 6b4:	82530306 	subshi	r0, r3, #402653184	; 0x18000000
 6b8:	2d030105 	stfcss	f0, [r3, #-20]	; 0xffffffec
 6bc:	024aba66 	subeq	fp, sl, #417792	; 0x66000
 6c0:	0101000a 	tsteq	r1, sl
 6c4:	00000169 	andeq	r0, r0, r9, ror #2
 6c8:	01120003 	tsteq	r2, r3
 6cc:	01020000 	mrseq	r0, (UNDEF: 2)
 6d0:	000d0efb 	strdeq	r0, [sp], -fp
 6d4:	01010101 	tsteq	r1, r1, lsl #2
 6d8:	01000000 	mrseq	r0, (UNDEF: 0)
 6dc:	2f010000 	svccs	0x00010000
 6e0:	656d6f68 	strbvs	r6, [sp, #-3944]!	; 0xfffff098
 6e4:	2f66632f 	svccs	0x0066632f
 6e8:	2f55435a 	svccs	0x0055435a
 6ec:	702f534f 	eorvc	r5, pc, pc, asr #6
 6f0:	74636172 	strbtvc	r6, [r3], #-370	; 0xfffffe8e
 6f4:	6c616369 	stclvs	3, cr6, [r1], #-420	; 0xfffffe5c
 6f8:	3378652f 	cmncc	r8, #197132288	; 0xbc00000
 6fc:	69726f2f 	ldmdbvs	r2!, {r0, r1, r2, r3, r5, r8, r9, sl, fp, sp, lr}^
 700:	616e6967 	cmnvs	lr, r7, ror #18
 704:	656b2f6c 	strbvs	r2, [fp, #-3948]!	; 0xfffff094
 708:	6c656e72 	stclvs	14, cr6, [r5], #-456	; 0xfffffe38
 70c:	6372732f 	cmnvs	r2, #-1140850688	; 0xbc000000
 710:	6f682f00 	svcvs	0x00682f00
 714:	632f656d 			; <UNDEFINED> instruction: 0x632f656d
 718:	435a2f66 	cmpmi	sl, #408	; 0x198
 71c:	534f2f55 	movtpl	r2, #65365	; 0xff55
 720:	6172702f 	cmnvs	r2, pc, lsr #32
 724:	63697463 	cmnvs	r9, #1660944384	; 0x63000000
 728:	652f6c61 	strvs	r6, [pc, #-3169]!	; fffffacf <_bss_end+0xffff6ac3>
 72c:	6f2f3378 	svcvs	0x002f3378
 730:	69676972 	stmdbvs	r7!, {r1, r4, r5, r6, r8, fp, sp, lr}^
 734:	2f6c616e 	svccs	0x006c616e
 738:	6e72656b 	cdpvs	5, 7, cr6, cr2, cr11, {3}
 73c:	692f6c65 	stmdbvs	pc!, {r0, r2, r5, r6, sl, fp, sp, lr}	; <UNPREDICTABLE>
 740:	756c636e 	strbvc	r6, [ip, #-878]!	; 0xfffffc92
 744:	622f6564 	eorvs	r6, pc, #100, 10	; 0x19000000
 748:	6472616f 	ldrbtvs	r6, [r2], #-367	; 0xfffffe91
 74c:	6970722f 	ldmdbvs	r0!, {r0, r1, r2, r3, r5, r9, ip, sp, lr}^
 750:	61682f30 	cmnvs	r8, r0, lsr pc
 754:	682f006c 	stmdavs	pc!, {r2, r3, r5, r6}	; <UNPREDICTABLE>
 758:	2f656d6f 	svccs	0x00656d6f
 75c:	5a2f6663 	bpl	bda0f0 <_bss_end+0xbd10e4>
 760:	4f2f5543 	svcmi	0x002f5543
 764:	72702f53 	rsbsvc	r2, r0, #332	; 0x14c
 768:	69746361 	ldmdbvs	r4!, {r0, r5, r6, r8, r9, sp, lr}^
 76c:	2f6c6163 	svccs	0x006c6163
 770:	2f337865 	svccs	0x00337865
 774:	6769726f 	strbvs	r7, [r9, -pc, ror #4]!
 778:	6c616e69 	stclvs	14, cr6, [r1], #-420	; 0xfffffe5c
 77c:	72656b2f 	rsbvc	r6, r5, #48128	; 0xbc00
 780:	2f6c656e 	svccs	0x006c656e
 784:	6c636e69 	stclvs	14, cr6, [r3], #-420	; 0xfffffe5c
 788:	2f656475 	svccs	0x00656475
 78c:	76697264 	strbtvc	r7, [r9], -r4, ror #4
 790:	00737265 	rsbseq	r7, r3, r5, ror #4
 794:	69616d00 	stmdbvs	r1!, {r8, sl, fp, sp, lr}^
 798:	70632e6e 	rsbvc	r2, r3, lr, ror #28
 79c:	00010070 	andeq	r0, r1, r0, ror r0
 7a0:	746e6900 	strbtvc	r6, [lr], #-2304	; 0xfffff700
 7a4:	2e666564 	cdpcs	5, 6, cr6, cr6, cr4, {3}
 7a8:	00020068 	andeq	r0, r2, r8, rrx
 7ac:	69706700 	ldmdbvs	r0!, {r8, r9, sl, sp, lr}^
 7b0:	00682e6f 	rsbeq	r2, r8, pc, ror #28
 7b4:	70000003 	andvc	r0, r0, r3
 7b8:	70697265 	rsbvc	r7, r9, r5, ror #4
 7bc:	61726568 	cmnvs	r2, r8, ror #10
 7c0:	682e736c 	stmdavs	lr!, {r2, r3, r5, r6, r8, r9, ip, sp, lr}
 7c4:	00000200 	andeq	r0, r0, r0, lsl #4
 7c8:	5f6d6362 	svcpl	0x006d6362
 7cc:	2e787561 	cdpcs	5, 7, cr7, cr8, cr1, {3}
 7d0:	00030068 	andeq	r0, r3, r8, rrx
 7d4:	72617500 	rsbvc	r7, r1, #0, 10
 7d8:	00682e74 	rsbeq	r2, r8, r4, ror lr
 7dc:	00000003 	andeq	r0, r0, r3
 7e0:	05000105 	streq	r0, [r0, #-261]	; 0xfffffefb
 7e4:	008aa002 	addeq	sl, sl, r2
 7e8:	19051900 	stmdbne	r5, {r8, fp, ip}
 7ec:	85160568 	ldrhi	r0, [r6, #-1384]	; 0xfffffa98
 7f0:	05671805 	strbeq	r1, [r7, #-2053]!	; 0xfffff7fb
 7f4:	1105690e 	tstne	r5, lr, lsl #18
 7f8:	4a09056d 	bmi	241db4 <_bss_end+0x238da8>
 7fc:	03040200 	movweq	r0, #16896	; 0x4200
 800:	1a052e06 	bne	14c020 <_bss_end+0x143014>
 804:	01040200 	mrseq	r0, R12_usr
 808:	13056606 	movwne	r6, #22022	; 0x5606
 80c:	850f05f6 	strhi	r0, [pc, #-1526]	; 21e <shift+0x21e>
 810:	05691105 	strbeq	r1, [r9, #-261]!	; 0xfffffefb
 814:	02004a09 	andeq	r4, r0, #36864	; 0x9000
 818:	2e060304 	cdpcs	3, 0, cr0, cr6, cr4, {0}
 81c:	02001a05 	andeq	r1, r0, #20480	; 0x5000
 820:	66060104 	strvs	r0, [r6], -r4, lsl #2
 824:	05f61305 	ldrbeq	r1, [r6, #773]!	; 0x305
 828:	82720311 	rsbshi	r0, r2, #1140850688	; 0x44000000
 82c:	01000c02 	tsteq	r0, r2, lsl #24
 830:	00004801 	andeq	r4, r0, r1, lsl #16
 834:	04000500 	streq	r0, [r0], #-1280	; 0xfffffb00
 838:	00002e00 	andeq	r2, r0, r0, lsl #28
 83c:	01010200 	mrseq	r0, R9_usr
 840:	000d0efb 	strdeq	r0, [sp], -fp
 844:	01010101 	tsteq	r1, r1, lsl #2
 848:	01000000 	mrseq	r0, (UNDEF: 0)
 84c:	01010000 	mrseq	r0, (UNDEF: 1)
 850:	00021f01 	andeq	r1, r2, r1, lsl #30
 854:	2d000000 	stccs	0, cr0, [r0, #-0]
 858:	02000000 	andeq	r0, r0, #0
 85c:	0f021f01 	svceq	0x00021f01
 860:	00005f02 	andeq	r5, r0, r2, lsl #30
 864:	005f0100 	subseq	r0, pc, r0, lsl #2
 868:	00010000 	andeq	r0, r1, r0
 86c:	80000205 	andhi	r0, r0, r5, lsl #4
 870:	2f190000 	svccs	0x00190000
 874:	302f2f2f 	eorcc	r2, pc, pc, lsr #30
 878:	01000202 	tsteq	r0, r2, lsl #4
 87c:	0000de01 	andeq	sp, r0, r1, lsl #28
 880:	54000300 	strpl	r0, [r0], #-768	; 0xfffffd00
 884:	02000000 	andeq	r0, r0, #0
 888:	0d0efb01 	vstreq	d15, [lr, #-4]
 88c:	01010100 	mrseq	r0, (UNDEF: 17)
 890:	00000001 	andeq	r0, r0, r1
 894:	01000001 	tsteq	r0, r1
 898:	6d6f682f 	stclvs	8, cr6, [pc, #-188]!	; 7e4 <shift+0x7e4>
 89c:	66632f65 	strbtvs	r2, [r3], -r5, ror #30
 8a0:	55435a2f 	strbpl	r5, [r3, #-2607]	; 0xfffff5d1
 8a4:	2f534f2f 	svccs	0x00534f2f
 8a8:	63617270 	cmnvs	r1, #112, 4
 8ac:	61636974 	smcvs	13972	; 0x3694
 8b0:	78652f6c 	stmdavc	r5!, {r2, r3, r5, r6, r8, r9, sl, fp, sp}^
 8b4:	726f2f33 	rsbvc	r2, pc, #51, 30	; 0xcc
 8b8:	6e696769 	cdpvs	7, 6, cr6, cr9, cr9, {3}
 8bc:	6b2f6c61 	blvs	bdba48 <_bss_end+0xbd2a3c>
 8c0:	656e7265 	strbvs	r7, [lr, #-613]!	; 0xfffffd9b
 8c4:	72732f6c 	rsbsvc	r2, r3, #108, 30	; 0x1b0
 8c8:	73000063 	movwvc	r0, #99	; 0x63
 8cc:	74726174 	ldrbtvc	r6, [r2], #-372	; 0xfffffe8c
 8d0:	632e7075 			; <UNDEFINED> instruction: 0x632e7075
 8d4:	01007070 	tsteq	r0, r0, ror r0
 8d8:	05000000 	streq	r0, [r0, #-0]
 8dc:	02050001 	andeq	r0, r5, #1
 8e0:	00008b94 	muleq	r0, r4, fp
 8e4:	05011403 	streq	r1, [r1, #-1027]	; 0xfffffbfd
 8e8:	02056a09 	andeq	r6, r5, #36864	; 0x9000
 8ec:	00060566 	andeq	r0, r6, r6, ror #10
 8f0:	2f030402 	svccs	0x00030402
 8f4:	02000205 	andeq	r0, r0, #1342177280	; 0x50000000
 8f8:	05650304 	strbeq	r0, [r5, #-772]!	; 0xfffffcfc
 8fc:	0402001f 	streq	r0, [r2], #-31	; 0xffffffe1
 900:	09056601 	stmdbeq	r5, {r0, r9, sl, sp, lr}
 904:	2f0105bd 	svccs	0x000105bd
 908:	6b0d05bd 	blvs	342004 <_bss_end+0x338ff8>
 90c:	054a0205 	strbeq	r0, [sl, #-517]	; 0xfffffdfb
 910:	04020004 	streq	r0, [r2], #-4
 914:	0b052f03 	bleq	14c528 <_bss_end+0x14351c>
 918:	03040200 	movweq	r0, #16896	; 0x4200
 91c:	0002054a 	andeq	r0, r2, sl, asr #10
 920:	2d030402 	cfstrscs	mvf0, [r3, #-8]
 924:	02002405 	andeq	r2, r0, #83886080	; 0x5000000
 928:	05660104 	strbeq	r0, [r6, #-260]!	; 0xfffffefc
 92c:	01058509 	tsteq	r5, r9, lsl #10
 930:	0d05a12f 	stfeqd	f2, [r5, #-188]	; 0xffffff44
 934:	4a02056a 	bmi	81ee4 <_bss_end+0x78ed8>
 938:	02000405 	andeq	r0, r0, #83886080	; 0x5000000
 93c:	052f0304 	streq	r0, [pc, #-772]!	; 640 <shift+0x640>
 940:	0402000b 	streq	r0, [r2], #-11
 944:	02054a03 	andeq	r4, r5, #12288	; 0x3000
 948:	03040200 	movweq	r0, #16896	; 0x4200
 94c:	0024052d 	eoreq	r0, r4, sp, lsr #10
 950:	66010402 	strvs	r0, [r1], -r2, lsl #8
 954:	05850905 	streq	r0, [r5, #2309]	; 0x905
 958:	0a022f01 	beq	8c564 <_bss_end+0x83558>
 95c:	63010100 	movwvs	r0, #4352	; 0x1100
 960:	05000000 	streq	r0, [r0, #-0]
 964:	2e000400 	cfcpyscs	mvf0, mvf0
 968:	02000000 	andeq	r0, r0, #0
 96c:	0efb0101 	cdpeq	1, 15, cr0, cr11, cr1, {0}
 970:	0101000d 	tsteq	r1, sp
 974:	00000101 	andeq	r0, r0, r1, lsl #2
 978:	00000100 	andeq	r0, r0, r0, lsl #2
 97c:	1f010101 	svcne	0x00010101
 980:	00006702 	andeq	r6, r0, r2, lsl #14
 984:	00006700 	andeq	r6, r0, r0, lsl #14
 988:	1f010200 	svcne	0x00010200
 98c:	96020f02 	strls	r0, [r2], -r2, lsl #30
 990:	00000000 	andeq	r0, r0, r0
 994:	00000096 	muleq	r0, r6, r0
 998:	02050001 	andeq	r0, r5, #1
 99c:	00008cac 	andeq	r8, r0, ip, lsr #25
 9a0:	0108cf03 	tsteq	r8, r3, lsl #30
 9a4:	2f2f2f30 	svccs	0x002f2f30
 9a8:	02302f2f 	eorseq	r2, r0, #47, 30	; 0xbc
 9ac:	2f1401d0 	svccs	0x001401d0
 9b0:	302f2f31 	eorcc	r2, pc, r1, lsr pc	; <UNPREDICTABLE>
 9b4:	03322f4c 	teqeq	r2, #76, 30	; 0x130
 9b8:	2f2f661f 	svccs	0x002f661f
 9bc:	2f2f2f2f 	svccs	0x002f2f2f
 9c0:	0002022f 	andeq	r0, r2, pc, lsr #4
 9c4:	00460101 	subeq	r0, r6, r1, lsl #2
 9c8:	00050000 	andeq	r0, r5, r0
 9cc:	002e0004 	eoreq	r0, lr, r4
 9d0:	01020000 	mrseq	r0, (UNDEF: 2)
 9d4:	0d0efb01 	vstreq	d15, [lr, #-4]
 9d8:	01010100 	mrseq	r0, (UNDEF: 17)
 9dc:	00000001 	andeq	r0, r0, r1
 9e0:	01000001 	tsteq	r0, r1
 9e4:	021f0101 	andseq	r0, pc, #1073741824	; 0x40000000
 9e8:	00000067 	andeq	r0, r0, r7, rrx
 9ec:	00000067 	andeq	r0, r0, r7, rrx
 9f0:	021f0102 	andseq	r0, pc, #-2147483648	; 0x80000000
 9f4:	0096020f 	addseq	r0, r6, pc, lsl #4
 9f8:	96000000 	strls	r0, [r0], -r0
 9fc:	01000000 	mrseq	r0, (UNDEF: 0)
 a00:	b8020500 	stmdalt	r2, {r8, sl}
 a04:	0300008e 	movweq	r0, #142	; 0x8e
 a08:	02010bb9 	andeq	r0, r1, #189440	; 0x2e400
 a0c:	01010002 	tsteq	r1, r2
 a10:	000000ba 	strheq	r0, [r0], -sl
 a14:	00b40003 	adcseq	r0, r4, r3
 a18:	01020000 	mrseq	r0, (UNDEF: 2)
 a1c:	000d0efb 	strdeq	r0, [sp], -fp
 a20:	01010101 	tsteq	r1, r1, lsl #2
 a24:	01000000 	mrseq	r0, (UNDEF: 0)
 a28:	2e010000 	cdpcs	0, 0, cr0, cr1, cr0, {0}
 a2c:	2e2e2f2e 	cdpcs	15, 2, cr2, cr14, cr14, {1}
 a30:	2f2e2e2f 	svccs	0x002e2e2f
 a34:	2e2f2e2e 	cdpcs	14, 2, cr2, cr15, cr14, {1}
 a38:	2e2e2f2e 	cdpcs	15, 2, cr2, cr14, cr14, {1}
 a3c:	6363672f 	cmnvs	r3, #12320768	; 0xbc0000
 a40:	2e32312d 	rsfcssp	f3, f2, #5.0
 a44:	2f302e32 	svccs	0x00302e32
 a48:	6762696c 	strbvs	r6, [r2, -ip, ror #18]!
 a4c:	2e006363 	cdpcs	3, 0, cr6, cr0, cr3, {3}
 a50:	2e2e2f2e 	cdpcs	15, 2, cr2, cr14, cr14, {1}
 a54:	2f2e2e2f 	svccs	0x002e2e2f
 a58:	2e2f2e2e 	cdpcs	14, 2, cr2, cr15, cr14, {1}
 a5c:	2f2e2f2e 	svccs	0x002e2f2e
 a60:	00636367 	rsbeq	r6, r3, r7, ror #6
 a64:	2e2f2e2e 	cdpcs	14, 2, cr2, cr15, cr14, {1}
 a68:	2e2e2f2e 	cdpcs	15, 2, cr2, cr14, cr14, {1}
 a6c:	2f2e2e2f 	svccs	0x002e2e2f
 a70:	2e2f2e2e 	cdpcs	14, 2, cr2, cr15, cr14, {1}
 a74:	63672f2e 	cmnvs	r7, #46, 30	; 0xb8
 a78:	32312d63 	eorscc	r2, r1, #6336	; 0x18c0
 a7c:	302e322e 	eorcc	r3, lr, lr, lsr #4
 a80:	62696c2f 	rsbvs	r6, r9, #12032	; 0x2f00
 a84:	2f636367 	svccs	0x00636367
 a88:	672f2e2e 	strvs	r2, [pc, -lr, lsr #28]!
 a8c:	632f6363 			; <UNDEFINED> instruction: 0x632f6363
 a90:	69666e6f 	stmdbvs	r6!, {r0, r1, r2, r3, r5, r6, r9, sl, fp, sp, lr}^
 a94:	72612f67 	rsbvc	r2, r1, #412	; 0x19c
 a98:	6c00006d 	stcvs	0, cr0, [r0], {109}	; 0x6d
 a9c:	63676269 	cmnvs	r7, #-1879048186	; 0x90000006
 aa0:	632e3263 			; <UNDEFINED> instruction: 0x632e3263
 aa4:	00000100 	andeq	r0, r0, r0, lsl #2
 aa8:	2d6d7261 	sfmcs	f7, 2, [sp, #-388]!	; 0xfffffe7c
 aac:	2e617369 	cdpcs	3, 6, cr7, cr1, cr9, {3}
 ab0:	00020068 	andeq	r0, r2, r8, rrx
 ab4:	6d726100 	ldfvse	f6, [r2, #-0]
 ab8:	0300682e 	movweq	r6, #2094	; 0x82e
 abc:	62670000 	rsbvs	r0, r7, #0
 ac0:	74632d6c 	strbtvc	r2, [r3], #-3436	; 0xfffff294
 ac4:	2e73726f 	cdpcs	2, 7, cr7, cr3, cr15, {3}
 ac8:	00010068 	andeq	r0, r1, r8, rrx
	...

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
      24:	682f0074 	stmdavs	pc!, {r2, r4, r5, r6}	; <UNPREDICTABLE>
      28:	2f656d6f 	svccs	0x00656d6f
      2c:	5a2f6663 	bpl	bd99c0 <_bss_end+0xbd09b4>
      30:	4f2f5543 	svcmi	0x002f5543
      34:	72702f53 	rsbsvc	r2, r0, #332	; 0x14c
      38:	69746361 	ldmdbvs	r4!, {r0, r5, r6, r8, r9, sp, lr}^
      3c:	2f6c6163 	svccs	0x006c6163
      40:	2f337865 	svccs	0x00337865
      44:	6769726f 	strbvs	r7, [r9, -pc, ror #4]!
      48:	6c616e69 	stclvs	14, cr6, [r1], #-420	; 0xfffffe5c
      4c:	72656b2f 	rsbvc	r6, r5, #48128	; 0xbc00
      50:	2f6c656e 	svccs	0x006c656e
      54:	2f637273 	svccs	0x00637273
      58:	2e787863 	cdpcs	8, 7, cr7, cr8, cr3, {3}
      5c:	00707063 	rsbseq	r7, r0, r3, rrx
      60:	73645f5f 	cmnvc	r4, #380	; 0x17c
      64:	61685f6f 	cmnvs	r8, pc, ror #30
      68:	656c646e 	strbvs	r6, [ip, #-1134]!	; 0xfffffb92
      6c:	635f5f00 	cmpvs	pc, #0, 30
      70:	615f6178 	cmpvs	pc, r8, ror r1	; <UNPREDICTABLE>
      74:	69786574 	ldmdbvs	r8!, {r2, r4, r5, r6, r8, sl, sp, lr}^
      78:	682f0074 	stmdavs	pc!, {r2, r4, r5, r6}	; <UNPREDICTABLE>
      7c:	2f656d6f 	svccs	0x00656d6f
      80:	5a2f6663 	bpl	bd9a14 <_bss_end+0xbd0a08>
      84:	4f2f5543 	svcmi	0x002f5543
      88:	72702f53 	rsbsvc	r2, r0, #332	; 0x14c
      8c:	69746361 	ldmdbvs	r4!, {r0, r5, r6, r8, r9, sp, lr}^
      90:	2f6c6163 	svccs	0x006c6163
      94:	2f337865 	svccs	0x00337865
      98:	6769726f 	strbvs	r7, [r9, -pc, ror #4]!
      9c:	6c616e69 	stclvs	14, cr6, [r1], #-420	; 0xfffffe5c
      a0:	6975622f 	ldmdbvs	r5!, {r0, r1, r2, r3, r5, r9, sp, lr}^
      a4:	4700646c 	strmi	r6, [r0, -ip, ror #8]
      a8:	4320554e 			; <UNDEFINED> instruction: 0x4320554e
      ac:	37312b2b 	ldrcc	r2, [r1, -fp, lsr #22]!
      b0:	2e323120 	rsfcssp	f3, f2, f0
      b4:	20302e32 	eorscs	r2, r0, r2, lsr lr
      b8:	6c666d2d 	stclvs	13, cr6, [r6], #-180	; 0xffffff4c
      bc:	2d74616f 	ldfcse	f6, [r4, #-444]!	; 0xfffffe44
      c0:	3d696261 	sfmcc	f6, 2, [r9, #-388]!	; 0xfffffe7c
      c4:	64726168 	ldrbtvs	r6, [r2], #-360	; 0xfffffe98
      c8:	666d2d20 	strbtvs	r2, [sp], -r0, lsr #26
      cc:	763d7570 			; <UNDEFINED> instruction: 0x763d7570
      d0:	2d207066 	stccs	0, cr7, [r0, #-408]!	; 0xfffffe68
      d4:	6f6c666d 	svcvs	0x006c666d
      d8:	612d7461 			; <UNDEFINED> instruction: 0x612d7461
      dc:	683d6962 	ldmdavs	sp!, {r1, r5, r6, r8, fp, sp, lr}
      e0:	20647261 	rsbcs	r7, r4, r1, ror #4
      e4:	70666d2d 	rsbvc	r6, r6, sp, lsr #26
      e8:	66763d75 			; <UNDEFINED> instruction: 0x66763d75
      ec:	6d2d2070 	stcvs	0, cr2, [sp, #-448]!	; 0xfffffe40
      f0:	656e7574 	strbvs	r7, [lr, #-1396]!	; 0xfffffa8c
      f4:	6d72613d 	ldfvse	f6, [r2, #-244]!	; 0xffffff0c
      f8:	36373131 			; <UNDEFINED> instruction: 0x36373131
      fc:	2d667a6a 	vstmdbcs	r6!, {s15-s120}
     100:	6d2d2073 	stcvs	0, cr2, [sp, #-460]!	; 0xfffffe34
     104:	206d7261 	rsbcs	r7, sp, r1, ror #4
     108:	72616d2d 	rsbvc	r6, r1, #2880	; 0xb40
     10c:	613d6863 	teqvs	sp, r3, ror #16
     110:	36766d72 			; <UNDEFINED> instruction: 0x36766d72
     114:	662b6b7a 			; <UNDEFINED> instruction: 0x662b6b7a
     118:	672d2070 			; <UNDEFINED> instruction: 0x672d2070
     11c:	20672d20 	rsbcs	r2, r7, r0, lsr #26
     120:	20304f2d 	eorscs	r4, r0, sp, lsr #30
     124:	00304f2d 	eorseq	r4, r0, sp, lsr #30
     128:	78635f5f 	stmdavc	r3!, {r0, r1, r2, r3, r4, r6, r8, r9, sl, fp, ip, lr}^
     12c:	75675f61 	strbvc	r5, [r7, #-3937]!	; 0xfffff09f
     130:	5f647261 	svcpl	0x00647261
     134:	75716361 	ldrbvc	r6, [r1, #-865]!	; 0xfffffc9f
     138:	00657269 	rsbeq	r7, r5, r9, ror #4
     13c:	78635f5f 	stmdavc	r3!, {r0, r1, r2, r3, r4, r6, r8, r9, sl, fp, ip, lr}^
     140:	69626178 	stmdbvs	r2!, {r3, r4, r5, r6, r8, sp, lr}^
     144:	5f003176 	svcpl	0x00003176
     148:	6178635f 	cmnvs	r8, pc, asr r3
     14c:	7275705f 	rsbsvc	r7, r5, #95	; 0x5f
     150:	69765f65 	ldmdbvs	r6!, {r0, r2, r5, r6, r8, r9, sl, fp, ip, lr}^
     154:	61757472 	cmnvs	r5, r2, ror r4
     158:	5f5f006c 	svcpl	0x005f006c
     15c:	62616561 	rsbvs	r6, r1, #406847488	; 0x18400000
     160:	6e755f69 	cdpvs	15, 7, cr5, cr5, cr9, {3}
     164:	646e6977 	strbtvs	r6, [lr], #-2423	; 0xfffff689
     168:	7070635f 	rsbsvc	r6, r0, pc, asr r3
     16c:	3172705f 	cmncc	r2, pc, asr r0
     170:	675f5f00 	ldrbvs	r5, [pc, -r0, lsl #30]
     174:	64726175 	ldrbtvs	r6, [r2], #-373	; 0xfffffe8b
     178:	6e6f6c00 	cdpvs	12, 6, cr6, cr15, cr0, {0}
     17c:	6f6c2067 	svcvs	0x006c2067
     180:	6920676e 	stmdbvs	r0!, {r1, r2, r3, r5, r6, r8, r9, sl, sp, lr}
     184:	7300746e 	movwvc	r7, #1134	; 0x46e
     188:	74726f68 	ldrbtvc	r6, [r2], #-3944	; 0xfffff098
     18c:	746e6920 	strbtvc	r6, [lr], #-2336	; 0xfffff6e0
     190:	6f682f00 	svcvs	0x00682f00
     194:	632f656d 			; <UNDEFINED> instruction: 0x632f656d
     198:	435a2f66 	cmpmi	sl, #408	; 0x198
     19c:	534f2f55 	movtpl	r2, #65365	; 0xff55
     1a0:	6172702f 	cmnvs	r2, pc, lsr #32
     1a4:	63697463 	cmnvs	r9, #1660944384	; 0x63000000
     1a8:	652f6c61 	strvs	r6, [pc, #-3169]!	; fffff54f <_bss_end+0xffff6543>
     1ac:	6f2f3378 	svcvs	0x002f3378
     1b0:	69676972 	stmdbvs	r7!, {r1, r4, r5, r6, r8, fp, sp, lr}^
     1b4:	2f6c616e 	svccs	0x006c616e
     1b8:	6e72656b 	cdpvs	5, 7, cr6, cr2, cr11, {3}
     1bc:	732f6c65 			; <UNDEFINED> instruction: 0x732f6c65
     1c0:	642f6372 	strtvs	r6, [pc], #-882	; 1c8 <shift+0x1c8>
     1c4:	65766972 	ldrbvs	r6, [r6, #-2418]!	; 0xfffff68e
     1c8:	622f7372 	eorvs	r7, pc, #-939524095	; 0xc8000001
     1cc:	615f6d63 	cmpvs	pc, r3, ror #26
     1d0:	632e7875 			; <UNDEFINED> instruction: 0x632e7875
     1d4:	53007070 	movwpl	r7, #112	; 0x70
     1d8:	5f314950 	svcpl	0x00314950
     1dc:	4b454550 	blmi	1151724 <_bss_end+0x1148718>
     1e0:	49505300 	ldmdbmi	r0, {r8, r9, ip, lr}^
     1e4:	54535f31 	ldrbpl	r5, [r3], #-3889	; 0xfffff0cf
     1e8:	6d005441 	cfstrsvs	mvf5, [r0, #-260]	; 0xfffffefc
     1ec:	5f585541 	svcpl	0x00585541
     1f0:	00676552 	rsbeq	r6, r7, r2, asr r5
     1f4:	344e5a5f 	strbcc	r5, [lr], #-2655	; 0xfffff5a1
     1f8:	58554143 	ldmdapl	r5, {r0, r1, r6, r8, lr}^
     1fc:	65473231 	strbvs	r3, [r7, #-561]	; 0xfffffdcf
     200:	65525f74 	ldrbvs	r5, [r2, #-3956]	; 0xfffff08c
     204:	74736967 	ldrbtvc	r6, [r3], #-2407	; 0xfffff699
     208:	4e457265 	cdpmi	2, 4, cr7, cr5, cr5, {3}
     20c:	6c616833 	stclvs	8, cr6, [r1], #-204	; 0xffffff34
     210:	58554137 	ldmdapl	r5, {r0, r1, r2, r4, r5, r8, lr}^
     214:	6765525f 			; <UNDEFINED> instruction: 0x6765525f
     218:	61760045 	cmnvs	r6, r5, asr #32
     21c:	0065756c 	rsbeq	r7, r5, ip, ror #10
     220:	5f787561 	svcpl	0x00787561
     224:	65736162 	ldrbvs	r6, [r3, #-354]!	; 0xfffffe9e
     228:	414e4500 	cmpmi	lr, r0, lsl #10
     22c:	53454c42 	movtpl	r4, #23618	; 0x5c42
     230:	4e5a5f00 	cdpmi	15, 5, cr5, cr10, cr0, {0}
     234:	55414334 	strbpl	r4, [r1, #-820]	; 0xfffffccc
     238:	6e453658 	mcrvs	6, 2, r3, cr5, cr8, {2}
     23c:	656c6261 	strbvs	r6, [ip, #-609]!	; 0xfffffd9f
     240:	68334e45 	ldmdavs	r3!, {r0, r2, r6, r9, sl, fp, lr}
     244:	35316c61 	ldrcc	r6, [r1, #-3169]!	; 0xfffff39f
     248:	5f585541 	svcpl	0x00585541
     24c:	69726550 	ldmdbvs	r2!, {r4, r6, r8, sl, sp, lr}^
     250:	72656870 	rsbvc	r6, r5, #112, 16	; 0x700000
     254:	45736c61 	ldrbmi	r6, [r3, #-3169]!	; 0xfffff39f
     258:	58554100 	ldmdapl	r5, {r8, lr}^
     25c:	7265505f 	rsbvc	r5, r5, #95	; 0x5f
     260:	65687069 	strbvs	r7, [r8, #-105]!	; 0xffffff97
     264:	736c6172 	cmnvc	ip, #-2147483620	; 0x8000001c
     268:	4e5a5f00 	cdpmi	15, 5, cr5, cr10, cr0, {0}
     26c:	55414334 	strbpl	r4, [r1, #-820]	; 0xfffffccc
     270:	45344358 	ldrmi	r4, [r4, #-856]!	; 0xfffffca8
     274:	5a5f006a 	bpl	17c0424 <_bss_end+0x17b7418>
     278:	4143344e 	cmpmi	r3, lr, asr #8
     27c:	32315855 	eorscc	r5, r1, #5570560	; 0x550000
     280:	5f746553 	svcpl	0x00746553
     284:	69676552 	stmdbvs	r7!, {r1, r4, r6, r8, sl, sp, lr}^
     288:	72657473 	rsbvc	r7, r5, #1929379840	; 0x73000000
     28c:	68334e45 	ldmdavs	r3!, {r0, r2, r6, r9, sl, fp, lr}
     290:	41376c61 	teqmi	r7, r1, ror #24
     294:	525f5855 	subspl	r5, pc, #5570560	; 0x550000
     298:	6a456765 	bvs	115a034 <_bss_end+0x1151028>
     29c:	49505300 	ldmdbmi	r0, {r8, r9, ip, lr}^
     2a0:	4f495f30 	svcmi	0x00495f30
     2a4:	4c475f00 	mcrrmi	15, 0, r5, r7, cr0
     2a8:	4c41424f 	sfmmi	f4, 2, [r1], {79}	; 0x4f
     2ac:	75735f5f 	ldrbvc	r5, [r3, #-3935]!	; 0xfffff0a1
     2b0:	5f495f62 	svcpl	0x00495f62
     2b4:	58554173 	ldmdapl	r5, {r0, r1, r4, r5, r6, r8, lr}^
     2b8:	49505300 	ldmdbmi	r0, {r8, r9, ip, lr}^
     2bc:	4e435f30 	mcrmi	15, 2, r5, cr3, cr0, {1}
     2c0:	00304c54 	eorseq	r4, r0, r4, asr ip
     2c4:	30495053 	subcc	r5, r9, r3, asr r0
     2c8:	544e435f 	strbpl	r4, [lr], #-863	; 0xfffffca1
     2cc:	5000314c 	andpl	r3, r0, ip, asr #2
     2d0:	70697265 	rsbvc	r7, r9, r5, ror #4
     2d4:	61726568 	cmnvs	r2, r8, ror #10
     2d8:	61425f6c 	cmpvs	r2, ip, ror #30
     2dc:	5f006573 	svcpl	0x00006573
     2e0:	696e695f 	stmdbvs	lr!, {r0, r1, r2, r3, r4, r6, r8, fp, sp, lr}^
     2e4:	6c616974 			; <UNDEFINED> instruction: 0x6c616974
     2e8:	5f657a69 	svcpl	0x00657a69
     2ec:	50530070 	subspl	r0, r3, r0, ror r0
     2f0:	435f3149 	cmpmi	pc, #1073741842	; 0x40000012
     2f4:	304c544e 	subcc	r5, ip, lr, asr #8
     2f8:	49505300 	ldmdbmi	r0, {r8, r9, ip, lr}^
     2fc:	4e435f31 	mcrmi	15, 2, r5, cr3, cr1, {1}
     300:	00314c54 	eorseq	r4, r1, r4, asr ip
     304:	62616e45 	rsbvs	r6, r1, #1104	; 0x450
     308:	7500656c 	strvc	r6, [r0, #-1388]	; 0xfffffa94
     30c:	6769736e 	strbvs	r7, [r9, -lr, ror #6]!
     310:	2064656e 	rsbcs	r6, r4, lr, ror #10
     314:	72616863 	rsbvc	r6, r1, #6488064	; 0x630000
     318:	5f554d00 	svcpl	0x00554d00
     31c:	00524549 	subseq	r4, r2, r9, asr #10
     320:	4d5f554d 	cfldr64mi	mvdx5, [pc, #-308]	; 1f4 <shift+0x1f4>
     324:	47005243 	strmi	r5, [r0, -r3, asr #4]
     328:	5f4f4950 	svcpl	0x004f4950
     32c:	65736142 	ldrbvs	r6, [r3, #-322]!	; 0xfffffebe
     330:	4e5a5f00 	cdpmi	15, 5, cr5, cr10, cr0, {0}
     334:	55414334 	strbpl	r4, [r1, #-820]	; 0xfffffccc
     338:	45324358 	ldrmi	r4, [r2, #-856]!	; 0xfffffca8
     33c:	6975006a 	ldmdbvs	r5!, {r1, r3, r5, r6}^
     340:	3233746e 	eorscc	r7, r3, #1845493760	; 0x6e000000
     344:	4400745f 	strmi	r7, [r0], #-1119	; 0xfffffba1
     348:	62617369 	rsbvs	r7, r1, #-1543503871	; 0xa4000001
     34c:	4700656c 	strmi	r6, [r0, -ip, ror #10]
     350:	525f7465 	subspl	r7, pc, #1694498816	; 0x65000000
     354:	73696765 	cmnvc	r9, #26476544	; 0x1940000
     358:	00726574 	rsbseq	r6, r2, r4, ror r5
     35c:	495f554d 	ldmdbmi	pc, {r0, r2, r3, r6, r8, sl, ip, lr}^	; <UNPREDICTABLE>
     360:	4d005249 	sfmmi	f5, 4, [r0, #-292]	; 0xfffffedc
     364:	4e435f55 	mcrmi	15, 2, r5, cr3, cr5, {2}
     368:	53004c54 	movwpl	r4, #3156	; 0xc54
     36c:	00314950 	eorseq	r4, r1, r0, asr r9
     370:	32495053 	subcc	r5, r9, #83	; 0x53
     374:	6f687300 	svcvs	0x00687300
     378:	75207472 	strvc	r7, [r0, #-1138]!	; 0xfffffb8e
     37c:	6769736e 	strbvs	r7, [r9, -lr, ror #6]!
     380:	2064656e 	rsbcs	r6, r4, lr, ror #10
     384:	00746e69 	rsbseq	r6, r4, r9, ror #28
     388:	31495053 	qdaddcc	r5, r3, r9
     38c:	004f495f 	subeq	r4, pc, pc, asr r9	; <UNPREDICTABLE>
     390:	4c5f554d 	cfldr64mi	mvdx5, [pc], {77}	; 0x4d
     394:	53005243 	movwpl	r5, #579	; 0x243
     398:	5f304950 	svcpl	0x00304950
     39c:	4b454550 	blmi	11518e4 <_bss_end+0x11488d8>
     3a0:	5f554d00 	svcpl	0x00554d00
     3a4:	44554142 	ldrbmi	r4, [r5], #-322	; 0xfffffebe
     3a8:	49505300 	ldmdbmi	r0, {r8, r9, ip, lr}^
     3ac:	54535f30 	ldrbpl	r5, [r3], #-3888	; 0xfffff0d0
     3b0:	47005441 	strmi	r5, [r0, -r1, asr #8]
     3b4:	5f4f4950 	svcpl	0x004f4950
     3b8:	5f6e6950 	svcpl	0x006e6950
     3bc:	6e756f43 	cdpvs	15, 7, cr6, cr5, cr3, {2}
     3c0:	5f5f0074 	svcpl	0x005f0074
     3c4:	74617473 	strbtvc	r7, [r1], #-1139	; 0xfffffb8d
     3c8:	695f6369 	ldmdbvs	pc, {r0, r3, r5, r6, r8, r9, sp, lr}^	; <UNPREDICTABLE>
     3cc:	6974696e 	ldmdbvs	r4!, {r1, r2, r3, r5, r6, r8, fp, sp, lr}^
     3d0:	7a696c61 	bvc	1a5b55c <_bss_end+0x1a52550>
     3d4:	6f697461 	svcvs	0x00697461
     3d8:	6e615f6e 	cdpvs	15, 6, cr5, cr1, cr14, {3}
     3dc:	65645f64 	strbvs	r5, [r4, #-3940]!	; 0xfffff09c
     3e0:	75727473 	ldrbvc	r7, [r2, #-1139]!	; 0xfffffb8d
     3e4:	6f697463 	svcvs	0x00697463
     3e8:	00305f6e 	eorseq	r5, r0, lr, ror #30
     3ec:	72705f5f 	rsbsvc	r5, r0, #380	; 0x17c
     3f0:	69726f69 	ldmdbvs	r2!, {r0, r3, r5, r6, r8, r9, sl, fp, sp, lr}^
     3f4:	74007974 	strvc	r7, [r0], #-2420	; 0xfffff68c
     3f8:	00736968 	rsbseq	r6, r3, r8, ror #18
     3fc:	5f746553 	svcpl	0x00746553
     400:	69676552 	stmdbvs	r7!, {r1, r4, r6, r8, sl, sp, lr}^
     404:	72657473 	rsbvc	r7, r5, #1929379840	; 0x73000000
     408:	5f554d00 	svcpl	0x00554d00
     40c:	0052534d 	subseq	r5, r2, sp, asr #6
     410:	5f585541 	svcpl	0x00585541
     414:	65736142 	ldrbvs	r6, [r3, #-322]!	; 0xfffffebe
     418:	5f554d00 	svcpl	0x00554d00
     41c:	54415453 	strbpl	r5, [r1], #-1107	; 0xfffffbad
     420:	78756100 	ldmdavc	r5!, {r8, sp, lr}^
     424:	7265705f 	rsbvc	r7, r5, #95	; 0x5f
     428:	65687069 	strbvs	r7, [r8, #-105]!	; 0xffffff97
     42c:	006c6172 	rsbeq	r6, ip, r2, ror r1
     430:	495f554d 	ldmdbmi	pc, {r0, r2, r3, r6, r8, sl, ip, lr}^	; <UNPREDICTABLE>
     434:	694d004f 	stmdbvs	sp, {r0, r1, r2, r3, r6}^
     438:	4155696e 	cmpmi	r5, lr, ror #18
     43c:	4d005452 	cfstrsmi	mvf5, [r0, #-328]	; 0xfffffeb8
     440:	534c5f55 	movtpl	r5, #53077	; 0xcf55
     444:	65720052 	ldrbvs	r0, [r2, #-82]!	; 0xffffffae
     448:	64695f67 	strbtvs	r5, [r9], #-3943	; 0xfffff099
     44c:	5a5f0078 	bpl	17c0634 <_bss_end+0x17b7628>
     450:	4143344e 	cmpmi	r3, lr, asr #8
     454:	44375855 	ldrtmi	r5, [r7], #-2133	; 0xfffff7ab
     458:	62617369 	rsbvs	r7, r1, #-1543503871	; 0xa4000001
     45c:	4e45656c 	cdpmi	5, 4, cr6, cr5, cr12, {3}
     460:	6c616833 	stclvs	8, cr6, [r1], #-204	; 0xffffff34
     464:	55413531 	strbpl	r3, [r1, #-1329]	; 0xfffffacf
     468:	65505f58 	ldrbvs	r5, [r0, #-3928]	; 0xfffff0a8
     46c:	68706972 	ldmdavs	r0!, {r1, r4, r5, r6, r8, fp, sp, lr}^
     470:	6c617265 	sfmvs	f7, 2, [r1], #-404	; 0xfffffe6c
     474:	4d004573 	cfstr32mi	mvfx4, [r0, #-460]	; 0xfffffe34
     478:	43535f55 	cmpmi	r3, #340	; 0x154
     47c:	43544152 	cmpmi	r4, #-2147483628	; 0x80000014
     480:	5a5f0048 	bpl	17c05a8 <_bss_end+0x17b759c>
     484:	33314b4e 	teqcc	r1, #79872	; 0x13800
     488:	49504743 	ldmdbmi	r0, {r0, r1, r6, r8, r9, sl, lr}^
     48c:	61485f4f 	cmpvs	r8, pc, asr #30
     490:	656c646e 	strbvs	r6, [ip, #-1134]!	; 0xfffffb92
     494:	47383172 			; <UNDEFINED> instruction: 0x47383172
     498:	475f7465 	ldrbmi	r7, [pc, -r5, ror #8]
     49c:	56454c50 			; <UNDEFINED> instruction: 0x56454c50
     4a0:	636f4c5f 	cmnvs	pc, #24320	; 0x5f00
     4a4:	6f697461 	svcvs	0x00697461
     4a8:	526a456e 	rsbpl	r4, sl, #461373440	; 0x1b800000
     4ac:	5f30536a 	svcpl	0x0030536a
     4b0:	53504700 	cmppl	r0, #0, 14
     4b4:	00305445 	eorseq	r5, r0, r5, asr #8
     4b8:	45535047 	ldrbmi	r5, [r3, #-71]	; 0xffffffb9
     4bc:	47003154 	smlsdmi	r0, r4, r1, r3
     4c0:	45534650 	ldrbmi	r4, [r3, #-1616]	; 0xfffff9b0
     4c4:	4700304c 	strmi	r3, [r0, -ip, asr #32]
     4c8:	45534650 	ldrbmi	r4, [r3, #-1616]	; 0xfffff9b0
     4cc:	4700314c 	strmi	r3, [r0, -ip, asr #2]
     4d0:	45534650 	ldrbmi	r4, [r3, #-1616]	; 0xfffff9b0
     4d4:	4700324c 	strmi	r3, [r0, -ip, asr #4]
     4d8:	45534650 	ldrbmi	r4, [r3, #-1616]	; 0xfffff9b0
     4dc:	4700334c 	strmi	r3, [r0, -ip, asr #6]
     4e0:	45534650 	ldrbmi	r4, [r3, #-1616]	; 0xfffff9b0
     4e4:	4700344c 	strmi	r3, [r0, -ip, asr #8]
     4e8:	45534650 	ldrbmi	r4, [r3, #-1616]	; 0xfffff9b0
     4ec:	4700354c 	strmi	r3, [r0, -ip, asr #10]
     4f0:	4e454650 	mcrmi	6, 2, r4, cr5, cr0, {2}
     4f4:	50470031 	subpl	r0, r7, r1, lsr r0
     4f8:	43445550 	movtmi	r5, #17744	; 0x4550
     4fc:	00304b4c 	eorseq	r4, r0, ip, asr #22
     500:	55505047 	ldrbpl	r5, [r0, #-71]	; 0xffffffb9
     504:	4b4c4344 	blmi	131121c <_bss_end+0x1308210>
     508:	50470031 	subpl	r0, r7, r1, lsr r0
     50c:	304e4552 	subcc	r4, lr, r2, asr r5
     510:	52504700 	subspl	r4, r0, #0, 14
     514:	00314e45 	eorseq	r4, r1, r5, asr #28
     518:	314e5a5f 	cmpcc	lr, pc, asr sl
     51c:	50474333 	subpl	r4, r7, r3, lsr r3
     520:	485f4f49 	ldmdami	pc, {r0, r3, r6, r8, r9, sl, fp, lr}^	; <UNPREDICTABLE>
     524:	6c646e61 	stclvs	14, cr6, [r4], #-388	; 0xfffffe7c
     528:	30317265 	eorscc	r7, r1, r5, ror #4
     52c:	5f746553 	svcpl	0x00746553
     530:	7074754f 	rsbsvc	r7, r4, pc, asr #10
     534:	6a457475 	bvs	115d710 <_bss_end+0x1154704>
     538:	5a5f0062 	bpl	17c06c8 <_bss_end+0x17b76bc>
     53c:	33314b4e 	teqcc	r1, #79872	; 0x13800
     540:	49504743 	ldmdbmi	r0, {r0, r1, r6, r8, r9, sl, lr}^
     544:	61485f4f 	cmpvs	r8, pc, asr #30
     548:	656c646e 	strbvs	r6, [ip, #-1134]!	; 0xfffffb92
     54c:	47393172 			; <UNDEFINED> instruction: 0x47393172
     550:	475f7465 	ldrbmi	r7, [pc, -r5, ror #8]
     554:	45534650 	ldrbmi	r4, [r3, #-1616]	; 0xfffff9b0
     558:	6f4c5f4c 	svcvs	0x004c5f4c
     55c:	69746163 	ldmdbvs	r4!, {r0, r1, r5, r6, r8, sp, lr}^
     560:	6a456e6f 	bvs	115bf24 <_bss_end+0x1152f18>
     564:	30536a52 	subscc	r6, r3, r2, asr sl
     568:	476d005f 			; <UNDEFINED> instruction: 0x476d005f
     56c:	004f4950 	subeq	r4, pc, r0, asr r9	; <UNPREDICTABLE>
     570:	314e5a5f 	cmpcc	lr, pc, asr sl
     574:	50474333 	subpl	r4, r7, r3, lsr r3
     578:	485f4f49 	ldmdami	pc, {r0, r3, r6, r8, r9, sl, fp, lr}^	; <UNPREDICTABLE>
     57c:	6c646e61 	stclvs	14, cr6, [r4], #-388	; 0xfffffe7c
     580:	34437265 	strbcc	r7, [r3], #-613	; 0xfffffd9b
     584:	75006a45 	strvc	r6, [r0, #-2629]	; 0xfffff5bb
     588:	38746e69 	ldmdacc	r4!, {r0, r3, r5, r6, r9, sl, fp, sp, lr}^
     58c:	4700745f 	smlsdmi	r0, pc, r4, r7	; <UNPREDICTABLE>
     590:	53444550 	movtpl	r4, #17744	; 0x4550
     594:	50470030 	subpl	r0, r7, r0, lsr r0
     598:	31534445 	cmpcc	r3, r5, asr #8
     59c:	6f6f6200 	svcvs	0x006f6200
     5a0:	6e55006c 	cdpvs	0, 5, cr0, cr5, cr12, {3}
     5a4:	63657073 	cmnvs	r5, #115	; 0x73
     5a8:	65696669 	strbvs	r6, [r9, #-1641]!	; 0xfffff997
     5ac:	50470064 	subpl	r0, r7, r4, rrx
     5b0:	304e454c 	subcc	r4, lr, ip, asr #10
     5b4:	6e756600 	cdpvs	6, 7, cr6, cr5, cr0, {0}
     5b8:	65470063 	strbvs	r0, [r7, #-99]	; 0xffffff9d
     5bc:	50475f74 	subpl	r5, r7, r4, ror pc
     5c0:	465f4f49 	ldrbmi	r4, [pc], -r9, asr #30
     5c4:	74636e75 	strbtvc	r6, [r3], #-3701	; 0xfffff18b
     5c8:	006e6f69 	rsbeq	r6, lr, r9, ror #30
     5cc:	49504743 	ldmdbmi	r0, {r0, r1, r6, r8, r9, sl, lr}^
     5d0:	61485f4f 	cmpvs	r8, pc, asr #30
     5d4:	656c646e 	strbvs	r6, [ip, #-1134]!	; 0xfffffb92
     5d8:	65470072 	strbvs	r0, [r7, #-114]	; 0xffffff8e
     5dc:	50475f74 	subpl	r5, r7, r4, ror pc
     5e0:	5f544553 	svcpl	0x00544553
     5e4:	61636f4c 	cmnvs	r3, ip, asr #30
     5e8:	6e6f6974 			; <UNDEFINED> instruction: 0x6e6f6974
     5ec:	50504700 	subspl	r4, r0, r0, lsl #14
     5f0:	47004455 	smlsdmi	r0, r5, r4, r4
     5f4:	475f7465 	ldrbmi	r7, [pc, -r5, ror #8]
     5f8:	56454c50 			; <UNDEFINED> instruction: 0x56454c50
     5fc:	636f4c5f 	cmnvs	pc, #24320	; 0x5f00
     600:	6f697461 	svcvs	0x00697461
     604:	5a5f006e 	bpl	17c07c4 <_bss_end+0x17b77b8>
     608:	33314b4e 	teqcc	r1, #79872	; 0x13800
     60c:	49504743 	ldmdbmi	r0, {r0, r1, r6, r8, r9, sl, lr}^
     610:	61485f4f 	cmpvs	r8, pc, asr #30
     614:	656c646e 	strbvs	r6, [ip, #-1134]!	; 0xfffffb92
     618:	47373172 			; <UNDEFINED> instruction: 0x47373172
     61c:	475f7465 	ldrbmi	r7, [pc, -r5, ror #8]
     620:	5f4f4950 	svcpl	0x004f4950
     624:	636e7546 	cmnvs	lr, #293601280	; 0x11800000
     628:	6e6f6974 			; <UNDEFINED> instruction: 0x6e6f6974
     62c:	5f006a45 	svcpl	0x00006a45
     630:	33314e5a 	teqcc	r1, #1440	; 0x5a0
     634:	49504743 	ldmdbmi	r0, {r0, r1, r6, r8, r9, sl, lr}^
     638:	61485f4f 	cmpvs	r8, pc, asr #30
     63c:	656c646e 	strbvs	r6, [ip, #-1134]!	; 0xfffffb92
     640:	45324372 	ldrmi	r4, [r2, #-882]!	; 0xfffffc8e
     644:	5047006a 	subpl	r0, r7, sl, rrx
     648:	4e454641 	cdpmi	6, 4, cr4, cr5, cr1, {2}
     64c:	50470030 	subpl	r0, r7, r0, lsr r0
     650:	4e454641 	cdpmi	6, 4, cr4, cr5, cr1, {2}
     654:	682f0031 	stmdavs	pc!, {r0, r4, r5}	; <UNPREDICTABLE>
     658:	2f656d6f 	svccs	0x00656d6f
     65c:	5a2f6663 	bpl	bd9ff0 <_bss_end+0xbd0fe4>
     660:	4f2f5543 	svcmi	0x002f5543
     664:	72702f53 	rsbsvc	r2, r0, #332	; 0x14c
     668:	69746361 	ldmdbvs	r4!, {r0, r5, r6, r8, r9, sp, lr}^
     66c:	2f6c6163 	svccs	0x006c6163
     670:	2f337865 	svccs	0x00337865
     674:	6769726f 	strbvs	r7, [r9, -pc, ror #4]!
     678:	6c616e69 	stclvs	14, cr6, [r1], #-420	; 0xfffffe5c
     67c:	72656b2f 	rsbvc	r6, r5, #48128	; 0xbc00
     680:	2f6c656e 	svccs	0x006c656e
     684:	2f637273 	svccs	0x00637273
     688:	76697264 	strbtvc	r7, [r9], -r4, ror #4
     68c:	2f737265 	svccs	0x00737265
     690:	6f697067 	svcvs	0x00697067
     694:	7070632e 	rsbsvc	r6, r0, lr, lsr #6
     698:	4e5a5f00 	cdpmi	15, 5, cr5, cr10, cr0, {0}
     69c:	4333314b 	teqmi	r3, #-1073741806	; 0xc0000012
     6a0:	4f495047 	svcmi	0x00495047
     6a4:	6e61485f 	mcrvs	8, 3, r4, cr1, cr15, {2}
     6a8:	72656c64 	rsbvc	r6, r5, #100, 24	; 0x6400
     6ac:	65473831 	strbvs	r3, [r7, #-2097]	; 0xfffff7cf
     6b0:	50475f74 	subpl	r5, r7, r4, ror pc
     6b4:	5f524c43 	svcpl	0x00524c43
     6b8:	61636f4c 	cmnvs	r3, ip, asr #30
     6bc:	6e6f6974 			; <UNDEFINED> instruction: 0x6e6f6974
     6c0:	6a526a45 	bvs	149afdc <_bss_end+0x1491fd0>
     6c4:	005f3053 	subseq	r3, pc, r3, asr r0	; <UNPREDICTABLE>
     6c8:	4f4c475f 	svcmi	0x004c475f
     6cc:	5f4c4142 	svcpl	0x004c4142
     6d0:	6275735f 	rsbsvs	r7, r5, #2080374785	; 0x7c000001
     6d4:	735f495f 	cmpvc	pc, #1556480	; 0x17c000
     6d8:	4f495047 	svcmi	0x00495047
     6dc:	43504700 	cmpmi	r0, #0, 14
     6e0:	0031524c 	eorseq	r5, r1, ip, asr #4
     6e4:	52415047 	subpl	r5, r1, #71	; 0x47
     6e8:	00304e45 	eorseq	r4, r0, r5, asr #28
     6ec:	52415047 	subpl	r5, r1, #71	; 0x47
     6f0:	00314e45 	eorseq	r4, r1, r5, asr #28
     6f4:	45485047 	strbmi	r5, [r8, #-71]	; 0xffffffb9
     6f8:	4700304e 	strmi	r3, [r0, -lr, asr #32]
     6fc:	4e454850 	mcrmi	8, 2, r4, cr5, cr0, {2}
     700:	70670031 	rsbvc	r0, r7, r1, lsr r0
     704:	625f6f69 	subsvs	r6, pc, #420	; 0x1a4
     708:	5f657361 	svcpl	0x00657361
     70c:	72646461 	rsbvc	r6, r4, #1627389952	; 0x61000000
     710:	4c504700 	mrrcmi	7, 0, r4, r0, cr0
     714:	00314e45 	eorseq	r4, r1, r5, asr #28
     718:	5f746547 	svcpl	0x00746547
     71c:	53465047 	movtpl	r5, #24647	; 0x6047
     720:	4c5f4c45 	mrrcmi	12, 4, r4, pc, cr5	; <UNPREDICTABLE>
     724:	7461636f 	strbtvc	r6, [r1], #-879	; 0xfffffc91
     728:	006e6f69 	rsbeq	r6, lr, r9, ror #30
     72c:	4f495047 	svcmi	0x00495047
     730:	6765525f 			; <UNDEFINED> instruction: 0x6765525f
     734:	4e5a5f00 	cdpmi	15, 5, cr5, cr10, cr0, {0}
     738:	47433331 	smlaldxmi	r3, r3, r1, r3	; <UNPREDICTABLE>
     73c:	5f4f4950 	svcpl	0x004f4950
     740:	646e6148 	strbtvs	r6, [lr], #-328	; 0xfffffeb8
     744:	3172656c 	cmncc	r2, ip, ror #10
     748:	74655337 	strbtvc	r5, [r5], #-823	; 0xfffffcc9
     74c:	4950475f 	ldmdbmi	r0, {r0, r1, r2, r3, r4, r6, r8, r9, sl, lr}^
     750:	75465f4f 	strbvc	r5, [r6, #-3919]	; 0xfffff0b1
     754:	6974636e 	ldmdbvs	r4!, {r1, r2, r3, r5, r6, r8, r9, sp, lr}^
     758:	6a456e6f 	bvs	115c11c <_bss_end+0x1153110>
     75c:	474e3431 	smlaldxmi	r3, lr, r1, r4
     760:	5f4f4950 	svcpl	0x004f4950
     764:	636e7546 	cmnvs	lr, #293601280	; 0x11800000
     768:	6e6f6974 			; <UNDEFINED> instruction: 0x6e6f6974
     76c:	4c504700 	mrrcmi	7, 0, r4, r0, cr0
     770:	00305645 	eorseq	r5, r0, r5, asr #12
     774:	454c5047 	strbmi	r5, [ip, #-71]	; 0xffffffb9
     778:	53003156 	movwpl	r3, #342	; 0x156
     77c:	475f7465 	ldrbmi	r7, [pc, -r5, ror #8]
     780:	5f4f4950 	svcpl	0x004f4950
     784:	636e7546 	cmnvs	lr, #293601280	; 0x11800000
     788:	6e6f6974 			; <UNDEFINED> instruction: 0x6e6f6974
     78c:	74696200 	strbtvc	r6, [r9], #-512	; 0xfffffe00
     790:	7864695f 	stmdavc	r4!, {r0, r1, r2, r3, r4, r6, r8, fp, sp, lr}^
     794:	4e5a5f00 	cdpmi	15, 5, cr5, cr10, cr0, {0}
     798:	4333314b 	teqmi	r3, #-1073741806	; 0xc0000012
     79c:	4f495047 	svcmi	0x00495047
     7a0:	6e61485f 	mcrvs	8, 3, r4, cr1, cr15, {2}
     7a4:	72656c64 	rsbvc	r6, r5, #100, 24	; 0x6400
     7a8:	65473831 	strbvs	r3, [r7, #-2097]	; 0xfffff7cf
     7ac:	50475f74 	subpl	r5, r7, r4, ror pc
     7b0:	5f544553 	svcpl	0x00544553
     7b4:	61636f4c 	cmnvs	r3, ip, asr #30
     7b8:	6e6f6974 			; <UNDEFINED> instruction: 0x6e6f6974
     7bc:	6a526a45 	bvs	149b0d8 <_bss_end+0x14920cc>
     7c0:	005f3053 	subseq	r3, pc, r3, asr r0	; <UNPREDICTABLE>
     7c4:	5f746547 	svcpl	0x00746547
     7c8:	4c435047 	mcrrmi	0, 4, r5, r3, cr7
     7cc:	6f4c5f52 	svcvs	0x004c5f52
     7d0:	69746163 	ldmdbvs	r4!, {r0, r1, r5, r6, r8, sp, lr}^
     7d4:	49006e6f 	stmdbmi	r0, {r0, r1, r2, r3, r5, r6, r9, sl, fp, sp, lr}
     7d8:	7475706e 	ldrbtvc	r7, [r5], #-110	; 0xffffff92
     7dc:	46504700 	ldrbmi	r4, [r0], -r0, lsl #14
     7e0:	00304e45 	eorseq	r4, r0, r5, asr #28
     7e4:	5f746553 	svcpl	0x00746553
     7e8:	7074754f 	rsbsvc	r7, r4, pc, asr #10
     7ec:	41007475 	tstmi	r0, r5, ror r4
     7f0:	305f746c 	subscc	r7, pc, ip, ror #8
     7f4:	746c4100 	strbtvc	r4, [ip], #-256	; 0xffffff00
     7f8:	4100315f 	tstmi	r0, pc, asr r1
     7fc:	325f746c 	subscc	r7, pc, #108, 8	; 0x6c000000
     800:	746c4100 	strbtvc	r4, [ip], #-256	; 0xffffff00
     804:	4100335f 	tstmi	r0, pc, asr r3
     808:	345f746c 	ldrbcc	r7, [pc], #-1132	; 810 <shift+0x810>
     80c:	746c4100 	strbtvc	r4, [ip], #-256	; 0xffffff00
     810:	4700355f 	smlsdmi	r0, pc, r5, r3	; <UNPREDICTABLE>
     814:	524c4350 	subpl	r4, ip, #80, 6	; 0x40000001
     818:	52420030 	subpl	r0, r2, #48	; 0x30
     81c:	3531315f 	ldrcc	r3, [r1, #-351]!	; 0xfffffea1
     820:	00303032 	eorseq	r3, r0, r2, lsr r0
     824:	335f5242 	cmpcc	pc, #536870916	; 0x20000004
     828:	30303438 	eorscc	r3, r0, r8, lsr r4
     82c:	4e5a5f00 	cdpmi	15, 5, cr5, cr10, cr0, {0}
     830:	41554335 	cmpmi	r5, r5, lsr r3
     834:	32435452 	subcc	r5, r3, #1375731712	; 0x52000000
     838:	43345245 	teqmi	r4, #1342177284	; 0x50000004
     83c:	00585541 	subseq	r5, r8, r1, asr #10
     840:	395f5242 	ldmdbcc	pc, {r1, r6, r9, ip, lr}^	; <UNPREDICTABLE>
     844:	00303036 	eorseq	r3, r0, r6, lsr r0
     848:	52415543 	subpl	r5, r1, #281018368	; 0x10c00000
     84c:	52420054 	subpl	r0, r2, #84	; 0x54
     850:	3637355f 			; <UNDEFINED> instruction: 0x3637355f
     854:	43003030 	movwmi	r3, #48	; 0x30
     858:	6b636f6c 	blvs	18dc610 <_bss_end+0x18d3604>
     85c:	7461525f 	strbtvc	r5, [r1], #-607	; 0xfffffda1
     860:	72570065 	subsvc	r0, r7, #101	; 0x65
     864:	00657469 	rsbeq	r7, r5, r9, ror #8
     868:	6d6f682f 	stclvs	8, cr6, [pc, #-188]!	; 7b4 <shift+0x7b4>
     86c:	66632f65 	strbtvs	r2, [r3], -r5, ror #30
     870:	55435a2f 	strbpl	r5, [r3, #-2607]	; 0xfffff5d1
     874:	2f534f2f 	svccs	0x00534f2f
     878:	63617270 	cmnvs	r1, #112, 4
     87c:	61636974 	smcvs	13972	; 0x3694
     880:	78652f6c 	stmdavc	r5!, {r2, r3, r5, r6, r8, r9, sl, fp, sp}^
     884:	726f2f33 	rsbvc	r2, pc, #51, 30	; 0xcc
     888:	6e696769 	cdpvs	7, 6, cr6, cr9, cr9, {3}
     88c:	6b2f6c61 	blvs	bdba18 <_bss_end+0xbd2a0c>
     890:	656e7265 	strbvs	r7, [lr, #-613]!	; 0xfffffd9b
     894:	72732f6c 	rsbsvc	r2, r3, #108, 30	; 0x1b0
     898:	72642f63 	rsbvc	r2, r4, #396	; 0x18c
     89c:	72657669 	rsbvc	r7, r5, #110100480	; 0x6900000
     8a0:	61752f73 	cmnvs	r5, r3, ror pc
     8a4:	632e7472 			; <UNDEFINED> instruction: 0x632e7472
     8a8:	43007070 	movwmi	r7, #112	; 0x70
     8ac:	5f726168 	svcpl	0x00726168
     8b0:	68430037 	stmdavs	r3, {r0, r1, r2, r4, r5}^
     8b4:	385f7261 	ldmdacc	pc, {r0, r5, r6, r9, ip, sp, lr}^	; <UNPREDICTABLE>
     8b8:	55416d00 	strbpl	r6, [r1, #-3328]	; 0xfffff300
     8bc:	475f0058 			; <UNDEFINED> instruction: 0x475f0058
     8c0:	41424f4c 	cmpmi	r2, ip, asr #30
     8c4:	735f5f4c 	cmpvc	pc, #76, 30	; 0x130
     8c8:	495f6275 	ldmdbmi	pc, {r0, r2, r4, r5, r6, r9, sp, lr}^	; <UNPREDICTABLE>
     8cc:	4155735f 	cmpmi	r5, pc, asr r3
     8d0:	00305452 	eorseq	r5, r0, r2, asr r4
     8d4:	354e5a5f 	strbcc	r5, [lr, #-2655]	; 0xfffff5a1
     8d8:	52415543 	subpl	r5, r1, #281018368	; 0x10c00000
     8dc:	72573554 	subsvc	r3, r7, #84, 10	; 0x15000000
     8e0:	45657469 	strbmi	r7, [r5, #-1129]!	; 0xfffffb97
     8e4:	00634b50 	rsbeq	r4, r3, r0, asr fp
     8e8:	315f5242 	cmpcc	pc, r2, asr #4
     8ec:	00303032 	eorseq	r3, r0, r2, lsr r0
     8f0:	354e5a5f 	strbcc	r5, [lr, #-2655]	; 0xfffff5a1
     8f4:	52415543 	subpl	r5, r1, #281018368	; 0x10c00000
     8f8:	72573554 	subsvc	r3, r7, #84, 10	; 0x15000000
     8fc:	45657469 	strbmi	r7, [r5, #-1129]!	; 0xfffffb97
     900:	5a5f0063 	bpl	17c0a94 <_bss_end+0x17b7a88>
     904:	5543354e 	strbpl	r3, [r3, #-1358]	; 0xfffffab2
     908:	43545241 	cmpmi	r4, #268435460	; 0x10000004
     90c:	34524534 	ldrbcc	r4, [r2], #-1332	; 0xfffffacc
     910:	58554143 	ldmdapl	r5, {r0, r1, r6, r8, lr}^
     914:	4e5a5f00 	cdpmi	15, 5, cr5, cr10, cr0, {0}
     918:	41554335 	cmpmi	r5, r5, lsr r3
     91c:	35315452 	ldrcc	r5, [r1, #-1106]!	; 0xfffffbae
     920:	5f746553 	svcpl	0x00746553
     924:	72616843 	rsbvc	r6, r1, #4390912	; 0x430000
     928:	6e654c5f 	mcrvs	12, 3, r4, cr5, cr15, {2}
     92c:	45687467 	strbmi	r7, [r8, #-1127]!	; 0xfffffb99
     930:	554e3731 	strbpl	r3, [lr, #-1841]	; 0xfffff8cf
     934:	5f545241 	svcpl	0x00545241
     938:	72616843 	rsbvc	r6, r1, #4390912	; 0x430000
     93c:	6e654c5f 	mcrvs	12, 3, r4, cr5, cr15, {2}
     940:	00687467 	rsbeq	r7, r8, r7, ror #8
     944:	5f746553 	svcpl	0x00746553
     948:	72616843 	rsbvc	r6, r1, #4390912	; 0x430000
     94c:	6e654c5f 	mcrvs	12, 3, r4, cr5, cr15, {2}
     950:	00687467 	rsbeq	r7, r8, r7, ror #8
     954:	65746172 	ldrbvs	r6, [r4, #-370]!	; 0xfffffe8e
     958:	5f524200 	svcpl	0x00524200
     95c:	30323931 	eorscc	r3, r2, r1, lsr r9
     960:	52420030 	subpl	r0, r2, #48	; 0x30
     964:	3038345f 	eorscc	r3, r8, pc, asr r4
     968:	65530030 	ldrbvs	r0, [r3, #-48]	; 0xffffffd0
     96c:	61425f74 	hvcvs	9716	; 0x25f4
     970:	525f6475 	subspl	r6, pc, #1962934272	; 0x75000000
     974:	00657461 	rsbeq	r7, r5, r1, ror #8
     978:	354e5a5f 	strbcc	r5, [lr, #-2655]	; 0xfffff5a1
     97c:	52415543 	subpl	r5, r1, #281018368	; 0x10c00000
     980:	53333154 	teqpl	r3, #84, 2
     984:	425f7465 	subsmi	r7, pc, #1694498816	; 0x65000000
     988:	5f647561 	svcpl	0x00647561
     98c:	65746152 	ldrbvs	r6, [r4, #-338]!	; 0xfffffeae
     990:	4e353145 	rsfmism	f3, f5, f5
     994:	54524155 	ldrbpl	r4, [r2], #-341	; 0xfffffeab
     998:	7561425f 	strbvc	r4, [r1, #-607]!	; 0xfffffda1
     99c:	61525f64 	cmpvs	r2, r4, ror #30
     9a0:	42006574 	andmi	r6, r0, #116, 10	; 0x1d000000
     9a4:	34325f52 	ldrtcc	r5, [r2], #-3922	; 0xfffff0ae
     9a8:	41003030 	tstmi	r0, r0, lsr r0
     9ac:	505f5443 	subspl	r5, pc, r3, asr #8
     9b0:	5f006e69 	svcpl	0x00006e69
     9b4:	6e72656b 	cdpvs	5, 7, cr6, cr2, cr11, {3}
     9b8:	6d5f6c65 	ldclvs	12, cr6, [pc, #-404]	; 82c <shift+0x82c>
     9bc:	006e6961 	rsbeq	r6, lr, r1, ror #18
     9c0:	6d6f682f 	stclvs	8, cr6, [pc, #-188]!	; 90c <shift+0x90c>
     9c4:	66632f65 	strbtvs	r2, [r3], -r5, ror #30
     9c8:	55435a2f 	strbpl	r5, [r3, #-2607]	; 0xfffff5d1
     9cc:	2f534f2f 	svccs	0x00534f2f
     9d0:	63617270 	cmnvs	r1, #112, 4
     9d4:	61636974 	smcvs	13972	; 0x3694
     9d8:	78652f6c 	stmdavc	r5!, {r2, r3, r5, r6, r8, r9, sl, fp, sp}^
     9dc:	726f2f33 	rsbvc	r2, pc, #51, 30	; 0xcc
     9e0:	6e696769 	cdpvs	7, 6, cr6, cr9, cr9, {3}
     9e4:	6b2f6c61 	blvs	bdbb70 <_bss_end+0xbd2b64>
     9e8:	656e7265 	strbvs	r7, [lr, #-613]!	; 0xfffffd9b
     9ec:	72732f6c 	rsbsvc	r2, r3, #108, 30	; 0x1b0
     9f0:	616d2f63 	cmnvs	sp, r3, ror #30
     9f4:	632e6e69 			; <UNDEFINED> instruction: 0x632e6e69
     9f8:	2f007070 	svccs	0x00007070
     9fc:	656d6f68 	strbvs	r6, [sp, #-3944]!	; 0xfffff098
     a00:	2f66632f 	svccs	0x0066632f
     a04:	2f55435a 	svccs	0x0055435a
     a08:	702f534f 	eorvc	r5, pc, pc, asr #6
     a0c:	74636172 	strbtvc	r6, [r3], #-370	; 0xfffffe8e
     a10:	6c616369 	stclvs	3, cr6, [r1], #-420	; 0xfffffe5c
     a14:	3378652f 	cmncc	r8, #197132288	; 0xbc00000
     a18:	69726f2f 	ldmdbvs	r2!, {r0, r1, r2, r3, r5, r8, r9, sl, fp, sp, lr}^
     a1c:	616e6967 	cmnvs	lr, r7, ror #18
     a20:	656b2f6c 	strbvs	r2, [fp, #-3948]!	; 0xfffff094
     a24:	6c656e72 	stclvs	14, cr6, [r5], #-456	; 0xfffffe38
     a28:	6372732f 	cmnvs	r2, #-1140850688	; 0xbc000000
     a2c:	6174732f 	cmnvs	r4, pc, lsr #6
     a30:	732e7472 			; <UNDEFINED> instruction: 0x732e7472
     a34:	554e4700 	strbpl	r4, [lr, #-1792]	; 0xfffff900
     a38:	20534120 	subscs	r4, r3, r0, lsr #2
     a3c:	39332e32 	ldmdbcc	r3!, {r1, r4, r5, r9, sl, fp, sp}
     a40:	6f746300 	svcvs	0x00746300
     a44:	74705f72 	ldrbtvc	r5, [r0], #-3954	; 0xfffff08e
     a48:	625f0072 	subsvs	r0, pc, #114	; 0x72
     a4c:	735f7373 	cmpvc	pc, #-872415231	; 0xcc000001
     a50:	74726174 	ldrbtvc	r6, [r2], #-372	; 0xfffffe8c
     a54:	706e6600 	rsbvc	r6, lr, r0, lsl #12
     a58:	5f007274 	svcpl	0x00007274
     a5c:	4f54435f 	svcmi	0x0054435f
     a60:	4e455f52 	mcrmi	15, 2, r5, cr5, cr2, {2}
     a64:	005f5f44 	subseq	r5, pc, r4, asr #30
     a68:	54435f5f 	strbpl	r5, [r3], #-3935	; 0xfffff0a1
     a6c:	4c5f524f 	lfmmi	f5, 2, [pc], {79}	; 0x4f
     a70:	5f545349 	svcpl	0x00545349
     a74:	5f5f005f 	svcpl	0x005f005f
     a78:	524f5444 	subpl	r5, pc, #68, 8	; 0x44000000
     a7c:	444e455f 	strbmi	r4, [lr], #-1375	; 0xfffffaa1
     a80:	5f005f5f 	svcpl	0x00005f5f
     a84:	5f707063 	svcpl	0x00707063
     a88:	74756873 	ldrbtvc	r6, [r5], #-2163	; 0xfffff78d
     a8c:	6e776f64 	cdpvs	15, 7, cr6, cr7, cr4, {3}
     a90:	73625f00 	cmnvc	r2, #0, 30
     a94:	6e655f73 	mcrvs	15, 3, r5, cr5, cr3, {3}
     a98:	5f5f0064 	svcpl	0x005f0064
     a9c:	524f5444 	subpl	r5, pc, #68, 8	; 0x44000000
     aa0:	53494c5f 	movtpl	r4, #40031	; 0x9c5f
     aa4:	005f5f54 	subseq	r5, pc, r4, asr pc	; <UNPREDICTABLE>
     aa8:	6d6f682f 	stclvs	8, cr6, [pc, #-188]!	; 9f4 <shift+0x9f4>
     aac:	66632f65 	strbtvs	r2, [r3], -r5, ror #30
     ab0:	55435a2f 	strbpl	r5, [r3, #-2607]	; 0xfffff5d1
     ab4:	2f534f2f 	svccs	0x00534f2f
     ab8:	63617270 	cmnvs	r1, #112, 4
     abc:	61636974 	smcvs	13972	; 0x3694
     ac0:	78652f6c 	stmdavc	r5!, {r2, r3, r5, r6, r8, r9, sl, fp, sp}^
     ac4:	726f2f33 	rsbvc	r2, pc, #51, 30	; 0xcc
     ac8:	6e696769 	cdpvs	7, 6, cr6, cr9, cr9, {3}
     acc:	6b2f6c61 	blvs	bdbc58 <_bss_end+0xbd2c4c>
     ad0:	656e7265 	strbvs	r7, [lr, #-613]!	; 0xfffffd9b
     ad4:	72732f6c 	rsbsvc	r2, r3, #108, 30	; 0x1b0
     ad8:	74732f63 	ldrbtvc	r2, [r3], #-3939	; 0xfffff09d
     adc:	75747261 	ldrbvc	r7, [r4, #-609]!	; 0xfffffd9f
     ae0:	70632e70 	rsbvc	r2, r3, r0, ror lr
     ae4:	635f0070 	cmpvs	pc, #112	; 0x70
     ae8:	6174735f 	cmnvs	r4, pc, asr r3
     aec:	70757472 	rsbsvc	r7, r5, r2, ror r4
     af0:	70635f00 	rsbvc	r5, r3, r0, lsl #30
     af4:	74735f70 	ldrbtvc	r5, [r3], #-3952	; 0xfffff090
     af8:	75747261 	ldrbvc	r7, [r4, #-609]!	; 0xfffffd9f
     afc:	74640070 	strbtvc	r0, [r4], #-112	; 0xffffff90
     b00:	705f726f 	subsvc	r7, pc, pc, ror #4
     b04:	6c007274 	sfmvs	f7, 4, [r0], {116}	; 0x74
     b08:	66316269 	ldrtvs	r6, [r1], -r9, ror #4
     b0c:	73636e75 	cmnvc	r3, #1872	; 0x750
     b10:	2f00532e 	svccs	0x0000532e
     b14:	6c697562 	cfstr64vs	mvdx7, [r9], #-392	; 0xfffffe78
     b18:	72696464 	rsbvc	r6, r9, #100, 8	; 0x64000000
     b1c:	6975622f 	ldmdbvs	r5!, {r0, r1, r2, r3, r5, r9, sp, lr}^
     b20:	422f646c 	eormi	r6, pc, #108, 8	; 0x6c000000
     b24:	444c4955 	strbmi	r4, [ip], #-2389	; 0xfffff6ab
     b28:	6d72612f 	ldfvse	f6, [r2, #-188]!	; 0xffffff44
     b2c:	6e6f6e2d 	cdpvs	14, 6, cr6, cr15, cr13, {1}
     b30:	61652d65 	cmnvs	r5, r5, ror #26
     b34:	672d6962 	strvs	r6, [sp, -r2, ror #18]!
     b38:	632d6363 			; <UNDEFINED> instruction: 0x632d6363
     b3c:	32312d73 	eorscc	r2, r1, #7360	; 0x1cc0
     b40:	302e322e 	eorcc	r3, lr, lr, lsr #4
     b44:	6363672f 	cmnvs	r3, #12320768	; 0xbc0000
     b48:	6d72612d 	ldfvse	f6, [r2, #-180]!	; 0xffffff4c
     b4c:	6e6f6e2d 	cdpvs	14, 6, cr6, cr15, cr13, {1}
     b50:	61652d65 	cmnvs	r5, r5, ror #26
     b54:	612f6962 			; <UNDEFINED> instruction: 0x612f6962
     b58:	6e2d6d72 	mcrvs	13, 1, r6, cr13, cr2, {3}
     b5c:	2d656e6f 	stclcs	14, cr6, [r5, #-444]!	; 0xfffffe44
     b60:	69626165 	stmdbvs	r2!, {r0, r2, r5, r6, r8, sp, lr}^
     b64:	6d72612f 	ldfvse	f6, [r2, #-188]!	; 0xffffff44
     b68:	7435762f 	ldrtvc	r7, [r5], #-1583	; 0xfffff9d1
     b6c:	61682f65 	cmnvs	r8, r5, ror #30
     b70:	6c2f6472 	cfstrsvs	mvf6, [pc], #-456	; 9b0 <shift+0x9b0>
     b74:	63676269 	cmnvs	r7, #-1879048186	; 0x90000006
     b78:	4e470063 	cdpmi	0, 4, cr0, cr7, cr3, {3}
     b7c:	53412055 	movtpl	r2, #4181	; 0x1055
     b80:	332e3220 			; <UNDEFINED> instruction: 0x332e3220
     b84:	73690037 	cmnvc	r9, #55	; 0x37
     b88:	69625f61 	stmdbvs	r2!, {r0, r5, r6, r8, r9, sl, fp, ip, lr}^
     b8c:	72705f74 	rsbsvc	r5, r0, #116, 30	; 0x1d0
     b90:	65726465 	ldrbvs	r6, [r2, #-1125]!	; 0xfffffb9b
     b94:	73690073 	cmnvc	r9, #115	; 0x73
     b98:	69625f61 	stmdbvs	r2!, {r0, r5, r6, r8, r9, sl, fp, ip, lr}^
     b9c:	66765f74 	uhsub16vs	r5, r6, r4
     ba0:	61625f70 	smcvs	9712	; 0x25f0
     ba4:	63006573 	movwvs	r6, #1395	; 0x573
     ba8:	6c706d6f 	ldclvs	13, cr6, [r0], #-444	; 0xfffffe44
     bac:	66207865 	strtvs	r7, [r0], -r5, ror #16
     bb0:	74616f6c 	strbtvc	r6, [r1], #-3948	; 0xfffff094
     bb4:	61736900 	cmnvs	r3, r0, lsl #18
     bb8:	626f6e5f 	rsbvs	r6, pc, #1520	; 0x5f0
     bbc:	69007469 	stmdbvs	r0, {r0, r3, r5, r6, sl, ip, sp, lr}
     bc0:	625f6173 	subsvs	r6, pc, #-1073741796	; 0xc000001c
     bc4:	6d5f7469 	cfldrdvs	mvd7, [pc, #-420]	; a28 <shift+0xa28>
     bc8:	665f6576 			; <UNDEFINED> instruction: 0x665f6576
     bcc:	74616f6c 	strbtvc	r6, [r1], #-3948	; 0xfffff094
     bd0:	61736900 	cmnvs	r3, r0, lsl #18
     bd4:	7469625f 	strbtvc	r6, [r9], #-607	; 0xfffffda1
     bd8:	3170665f 	cmncc	r0, pc, asr r6
     bdc:	73690036 	cmnvc	r9, #54	; 0x36
     be0:	69625f61 	stmdbvs	r2!, {r0, r5, r6, r8, r9, sl, fp, ip, lr}^
     be4:	65735f74 	ldrbvs	r5, [r3, #-3956]!	; 0xfffff08c
     be8:	73690063 	cmnvc	r9, #99	; 0x63
     bec:	69625f61 	stmdbvs	r2!, {r0, r5, r6, r8, r9, sl, fp, ip, lr}^
     bf0:	64615f74 	strbtvs	r5, [r1], #-3956	; 0xfffff08c
     bf4:	69007669 	stmdbvs	r0, {r0, r3, r5, r6, r9, sl, ip, sp, lr}
     bf8:	625f6173 	subsvs	r6, pc, #-1073741796	; 0xc000001c
     bfc:	715f7469 	cmpvc	pc, r9, ror #8
     c00:	6b726975 	blvs	1c9b1dc <_bss_end+0x1c921d0>
     c04:	5f6f6e5f 	svcpl	0x006f6e5f
     c08:	616c6f76 	smcvs	50934	; 0xc6f6
     c0c:	656c6974 	strbvs	r6, [ip, #-2420]!	; 0xfffff68c
     c10:	0065635f 	rsbeq	r6, r5, pc, asr r3
     c14:	5f617369 	svcpl	0x00617369
     c18:	5f746962 	svcpl	0x00746962
     c1c:	6900706d 	stmdbvs	r0, {r0, r2, r3, r5, r6, ip, sp, lr}
     c20:	625f6173 	subsvs	r6, pc, #-1073741796	; 0xc000001c
     c24:	615f7469 	cmpvs	pc, r9, ror #8
     c28:	35766d72 	ldrbcc	r6, [r6, #-3442]!	; 0xfffff28e
     c2c:	73690074 	cmnvc	r9, #116	; 0x74
     c30:	69625f61 	stmdbvs	r2!, {r0, r5, r6, r8, r9, sl, fp, ip, lr}^
     c34:	72615f74 	rsbvc	r5, r1, #116, 30	; 0x1d0
     c38:	7435766d 	ldrtvc	r7, [r5], #-1645	; 0xfffff993
     c3c:	73690065 	cmnvc	r9, #101	; 0x65
     c40:	69625f61 	stmdbvs	r2!, {r0, r5, r6, r8, r9, sl, fp, ip, lr}^
     c44:	656e5f74 	strbvs	r5, [lr, #-3956]!	; 0xfffff08c
     c48:	69006e6f 	stmdbvs	r0, {r0, r1, r2, r3, r5, r6, r9, sl, fp, sp, lr}
     c4c:	625f6173 	subsvs	r6, pc, #-1073741796	; 0xc000001c
     c50:	625f7469 	subsvs	r7, pc, #1761607680	; 0x69000000
     c54:	00363166 	eorseq	r3, r6, r6, ror #2
     c58:	2e2f2e2e 	cdpcs	14, 2, cr2, cr15, cr14, {1}
     c5c:	2e2e2f2e 	cdpcs	15, 2, cr2, cr14, cr14, {1}
     c60:	2f2e2e2f 	svccs	0x002e2e2f
     c64:	2e2f2e2e 	cdpcs	14, 2, cr2, cr15, cr14, {1}
     c68:	63672f2e 	cmnvs	r7, #46, 30	; 0xb8
     c6c:	32312d63 	eorscc	r2, r1, #6336	; 0x18c0
     c70:	302e322e 	eorcc	r3, lr, lr, lsr #4
     c74:	62696c2f 	rsbvs	r6, r9, #12032	; 0x2f00
     c78:	2f636367 	svccs	0x00636367
     c7c:	6762696c 	strbvs	r6, [r2, -ip, ror #18]!
     c80:	2e326363 	cdpcs	3, 3, cr6, cr2, cr3, {3}
     c84:	50460063 	subpl	r0, r6, r3, rrx
     c88:	5f524353 	svcpl	0x00524353
     c8c:	4d554e45 	ldclmi	14, cr4, [r5, #-276]	; 0xfffffeec
     c90:	53504600 	cmppl	r0, #0, 12
     c94:	6e5f5243 	cdpvs	2, 5, cr5, cr15, cr3, {2}
     c98:	7176637a 	cmnvc	r6, sl, ror r3
     c9c:	4e455f63 	cdpmi	15, 4, cr5, cr5, cr3, {3}
     ca0:	56004d55 			; <UNDEFINED> instruction: 0x56004d55
     ca4:	455f5250 	ldrbmi	r5, [pc, #-592]	; a5c <shift+0xa5c>
     ca8:	004d554e 	subeq	r5, sp, lr, asr #10
     cac:	74696266 	strbtvc	r6, [r9], #-614	; 0xfffffd9a
     cb0:	706d695f 	rsbvc	r6, sp, pc, asr r9
     cb4:	6163696c 	cmnvs	r3, ip, ror #18
     cb8:	6e6f6974 			; <UNDEFINED> instruction: 0x6e6f6974
     cbc:	5f305000 	svcpl	0x00305000
     cc0:	4d554e45 	ldclmi	14, cr4, [r5, #-276]	; 0xfffffeec
     cc4:	61736900 	cmnvs	r3, r0, lsl #18
     cc8:	7469625f 	strbtvc	r6, [r9], #-607	; 0xfffffda1
     ccc:	7972635f 	ldmdbvc	r2!, {r0, r1, r2, r3, r4, r6, r8, r9, sp, lr}^
     cd0:	006f7470 	rsbeq	r7, pc, r0, ror r4	; <UNPREDICTABLE>
     cd4:	5f617369 	svcpl	0x00617369
     cd8:	5f746962 	svcpl	0x00746962
     cdc:	76696474 			; <UNDEFINED> instruction: 0x76696474
     ce0:	6e6f6300 	cdpvs	3, 6, cr6, cr15, cr0, {0}
     ce4:	73690073 	cmnvc	r9, #115	; 0x73
     ce8:	69625f61 	stmdbvs	r2!, {r0, r5, r6, r8, r9, sl, fp, ip, lr}^
     cec:	77695f74 			; <UNDEFINED> instruction: 0x77695f74
     cf0:	74786d6d 	ldrbtvc	r6, [r8], #-3437	; 0xfffff293
     cf4:	43504600 	cmpmi	r0, #0, 12
     cf8:	5f535458 	svcpl	0x00535458
     cfc:	4d554e45 	ldclmi	14, cr4, [r5, #-276]	; 0xfffffeec
     d00:	61736900 	cmnvs	r3, r0, lsl #18
     d04:	7469625f 	strbtvc	r6, [r9], #-607	; 0xfffffda1
     d08:	6d72615f 	ldfvse	f6, [r2, #-380]!	; 0xfffffe84
     d0c:	69003676 	stmdbvs	r0, {r1, r2, r4, r5, r6, r9, sl, ip, sp}
     d10:	625f6173 	subsvs	r6, pc, #-1073741796	; 0xc000001c
     d14:	6d5f7469 	cfldrdvs	mvd7, [pc, #-420]	; b78 <shift+0xb78>
     d18:	69006576 	stmdbvs	r0, {r1, r2, r4, r5, r6, r8, sl, sp, lr}
     d1c:	625f6173 	subsvs	r6, pc, #-1073741796	; 0xc000001c
     d20:	695f7469 	ldmdbvs	pc, {r0, r3, r5, r6, sl, ip, sp, lr}^	; <UNPREDICTABLE>
     d24:	786d6d77 	stmdavc	sp!, {r0, r1, r2, r4, r5, r6, r8, sl, fp, sp, lr}^
     d28:	69003274 	stmdbvs	r0, {r2, r4, r5, r6, r9, ip, sp}
     d2c:	625f6173 	subsvs	r6, pc, #-1073741796	; 0xc000001c
     d30:	635f7469 	cmpvs	pc, #1761607680	; 0x69000000
     d34:	70636564 	rsbvc	r6, r3, r4, ror #10
     d38:	73690030 	cmnvc	r9, #48	; 0x30
     d3c:	69625f61 	stmdbvs	r2!, {r0, r5, r6, r8, r9, sl, fp, ip, lr}^
     d40:	64635f74 	strbtvs	r5, [r3], #-3956	; 0xfffff08c
     d44:	31706365 	cmncc	r0, r5, ror #6
     d48:	61736900 	cmnvs	r3, r0, lsl #18
     d4c:	7469625f 	strbtvc	r6, [r9], #-607	; 0xfffffda1
     d50:	6564635f 	strbvs	r6, [r4, #-863]!	; 0xfffffca1
     d54:	00327063 	eorseq	r7, r2, r3, rrx
     d58:	5f617369 	svcpl	0x00617369
     d5c:	5f746962 	svcpl	0x00746962
     d60:	63656463 	cmnvs	r5, #1660944384	; 0x63000000
     d64:	69003370 	stmdbvs	r0, {r4, r5, r6, r8, r9, ip, sp}
     d68:	625f6173 	subsvs	r6, pc, #-1073741796	; 0xc000001c
     d6c:	635f7469 	cmpvs	pc, #1761607680	; 0x69000000
     d70:	70636564 	rsbvc	r6, r3, r4, ror #10
     d74:	73690034 	cmnvc	r9, #52	; 0x34
     d78:	69625f61 	stmdbvs	r2!, {r0, r5, r6, r8, r9, sl, fp, ip, lr}^
     d7c:	70665f74 	rsbvc	r5, r6, r4, ror pc
     d80:	6c62645f 	cfstrdvs	mvd6, [r2], #-380	; 0xfffffe84
     d84:	61736900 	cmnvs	r3, r0, lsl #18
     d88:	7469625f 	strbtvc	r6, [r9], #-607	; 0xfffffda1
     d8c:	6564635f 	strbvs	r6, [r4, #-863]!	; 0xfffffca1
     d90:	00367063 	eorseq	r7, r6, r3, rrx
     d94:	5f617369 	svcpl	0x00617369
     d98:	5f746962 	svcpl	0x00746962
     d9c:	63656463 	cmnvs	r5, #1660944384	; 0x63000000
     da0:	69003770 	stmdbvs	r0, {r4, r5, r6, r8, r9, sl, ip, sp}
     da4:	625f6173 	subsvs	r6, pc, #-1073741796	; 0xc000001c
     da8:	615f7469 	cmpvs	pc, r9, ror #8
     dac:	36766d72 			; <UNDEFINED> instruction: 0x36766d72
     db0:	7369006b 	cmnvc	r9, #107	; 0x6b
     db4:	69625f61 	stmdbvs	r2!, {r0, r5, r6, r8, r9, sl, fp, ip, lr}^
     db8:	72615f74 	rsbvc	r5, r1, #116, 30	; 0x1d0
     dbc:	5f38766d 	svcpl	0x0038766d
     dc0:	6d5f6d31 	ldclvs	13, cr6, [pc, #-196]	; d04 <shift+0xd04>
     dc4:	006e6961 	rsbeq	r6, lr, r1, ror #18
     dc8:	65746e61 	ldrbvs	r6, [r4, #-3681]!	; 0xfffff19f
     dcc:	61736900 	cmnvs	r3, r0, lsl #18
     dd0:	7469625f 	strbtvc	r6, [r9], #-607	; 0xfffffda1
     dd4:	736d635f 	cmnvc	sp, #2080374785	; 0x7c000001
     dd8:	6f6c0065 	svcvs	0x006c0065
     ddc:	6420676e 	strtvs	r6, [r0], #-1902	; 0xfffff892
     de0:	6c62756f 	cfstr64vs	mvdx7, [r2], #-444	; 0xfffffe44
     de4:	73690065 	cmnvc	r9, #101	; 0x65
     de8:	69625f61 	stmdbvs	r2!, {r0, r5, r6, r8, r9, sl, fp, ip, lr}^
     dec:	70665f74 	rsbvc	r5, r6, r4, ror pc
     df0:	69003576 	stmdbvs	r0, {r1, r2, r4, r5, r6, r8, sl, ip, sp}
     df4:	625f6173 	subsvs	r6, pc, #-1073741796	; 0xc000001c
     df8:	785f7469 	ldmdavc	pc, {r0, r3, r5, r6, sl, ip, sp, lr}^	; <UNPREDICTABLE>
     dfc:	6c616373 	stclvs	3, cr6, [r1], #-460	; 0xfffffe34
     e00:	6f6c0065 	svcvs	0x006c0065
     e04:	6c20676e 	stcvs	7, cr6, [r0], #-440	; 0xfffffe48
     e08:	20676e6f 	rsbcs	r6, r7, pc, ror #28
     e0c:	69736e75 	ldmdbvs	r3!, {r0, r2, r4, r5, r6, r9, sl, fp, sp, lr}^
     e10:	64656e67 	strbtvs	r6, [r5], #-3687	; 0xfffff199
     e14:	746e6920 	strbtvc	r6, [lr], #-2336	; 0xfffff6e0
     e18:	61736900 	cmnvs	r3, r0, lsl #18
     e1c:	7469625f 	strbtvc	r6, [r9], #-607	; 0xfffffda1
     e20:	6975715f 	ldmdbvs	r5!, {r0, r1, r2, r3, r4, r6, r8, ip, sp, lr}^
     e24:	635f6b72 	cmpvs	pc, #116736	; 0x1c800
     e28:	6c5f336d 	mrrcvs	3, 6, r3, pc, cr13	; <UNPREDICTABLE>
     e2c:	00647264 	rsbeq	r7, r4, r4, ror #4
     e30:	5f617369 	svcpl	0x00617369
     e34:	5f746962 	svcpl	0x00746962
     e38:	6d6d3869 	stclvs	8, cr3, [sp, #-420]!	; 0xfffffe5c
     e3c:	61736900 	cmnvs	r3, r0, lsl #18
     e40:	7469625f 	strbtvc	r6, [r9], #-607	; 0xfffffda1
     e44:	5f70665f 	svcpl	0x0070665f
     e48:	00323364 	eorseq	r3, r2, r4, ror #6
     e4c:	5f617369 	svcpl	0x00617369
     e50:	5f746962 	svcpl	0x00746962
     e54:	766d7261 	strbtvc	r7, [sp], -r1, ror #4
     e58:	006d6537 	rsbeq	r6, sp, r7, lsr r5
     e5c:	5f617369 	svcpl	0x00617369
     e60:	5f746962 	svcpl	0x00746962
     e64:	6561706c 	strbvs	r7, [r1, #-108]!	; 0xffffff94
     e68:	6c6c6100 	stfvse	f6, [ip], #-0
     e6c:	706d695f 	rsbvc	r6, sp, pc, asr r9
     e70:	6465696c 	strbtvs	r6, [r5], #-2412	; 0xfffff694
     e74:	6962665f 	stmdbvs	r2!, {r0, r1, r2, r3, r4, r6, r9, sl, sp, lr}^
     e78:	69007374 	stmdbvs	r0, {r2, r4, r5, r6, r8, r9, ip, sp, lr}
     e7c:	625f6173 	subsvs	r6, pc, #-1073741796	; 0xc000001c
     e80:	615f7469 	cmpvs	pc, r9, ror #8
     e84:	38766d72 	ldmdacc	r6!, {r1, r4, r5, r6, r8, sl, fp, sp, lr}^
     e88:	6900315f 	stmdbvs	r0, {r0, r1, r2, r3, r4, r6, r8, ip, sp}
     e8c:	625f6173 	subsvs	r6, pc, #-1073741796	; 0xc000001c
     e90:	615f7469 	cmpvs	pc, r9, ror #8
     e94:	38766d72 	ldmdacc	r6!, {r1, r4, r5, r6, r8, sl, fp, sp, lr}^
     e98:	6900325f 	stmdbvs	r0, {r0, r1, r2, r3, r4, r6, r9, ip, sp}
     e9c:	625f6173 	subsvs	r6, pc, #-1073741796	; 0xc000001c
     ea0:	615f7469 	cmpvs	pc, r9, ror #8
     ea4:	38766d72 	ldmdacc	r6!, {r1, r4, r5, r6, r8, sl, fp, sp, lr}^
     ea8:	6900335f 	stmdbvs	r0, {r0, r1, r2, r3, r4, r6, r8, r9, ip, sp}
     eac:	625f6173 	subsvs	r6, pc, #-1073741796	; 0xc000001c
     eb0:	615f7469 	cmpvs	pc, r9, ror #8
     eb4:	38766d72 	ldmdacc	r6!, {r1, r4, r5, r6, r8, sl, fp, sp, lr}^
     eb8:	6900345f 	stmdbvs	r0, {r0, r1, r2, r3, r4, r6, sl, ip, sp}
     ebc:	625f6173 	subsvs	r6, pc, #-1073741796	; 0xc000001c
     ec0:	615f7469 	cmpvs	pc, r9, ror #8
     ec4:	38766d72 	ldmdacc	r6!, {r1, r4, r5, r6, r8, sl, fp, sp, lr}^
     ec8:	6900355f 	stmdbvs	r0, {r0, r1, r2, r3, r4, r6, r8, sl, ip, sp}
     ecc:	625f6173 	subsvs	r6, pc, #-1073741796	; 0xc000001c
     ed0:	615f7469 	cmpvs	pc, r9, ror #8
     ed4:	38766d72 	ldmdacc	r6!, {r1, r4, r5, r6, r8, sl, fp, sp, lr}^
     ed8:	6900365f 	stmdbvs	r0, {r0, r1, r2, r3, r4, r6, r9, sl, ip, sp}
     edc:	625f6173 	subsvs	r6, pc, #-1073741796	; 0xc000001c
     ee0:	735f7469 	cmpvc	pc, #1761607680	; 0x69000000
     ee4:	73690062 	cmnvc	r9, #98	; 0x62
     ee8:	756e5f61 	strbvc	r5, [lr, #-3937]!	; 0xfffff09f
     eec:	69625f6d 	stmdbvs	r2!, {r0, r2, r3, r5, r6, r8, r9, sl, fp, ip, lr}^
     ef0:	69007374 	stmdbvs	r0, {r2, r4, r5, r6, r8, r9, ip, sp, lr}
     ef4:	625f6173 	subsvs	r6, pc, #-1073741796	; 0xc000001c
     ef8:	735f7469 	cmpvc	pc, #1761607680	; 0x69000000
     efc:	6c6c616d 	stfvse	f6, [ip], #-436	; 0xfffffe4c
     f00:	006c756d 	rsbeq	r7, ip, sp, ror #10
     f04:	636e7566 	cmnvs	lr, #427819008	; 0x19800000
     f08:	7274705f 	rsbsvc	r7, r4, #95	; 0x5f
     f0c:	6d6f6300 	stclvs	3, cr6, [pc, #-0]	; f14 <shift+0xf14>
     f10:	78656c70 	stmdavc	r5!, {r4, r5, r6, sl, fp, sp, lr}^
     f14:	756f6420 	strbvc	r6, [pc, #-1056]!	; afc <shift+0xafc>
     f18:	00656c62 	rsbeq	r6, r5, r2, ror #24
     f1c:	465f424e 	ldrbmi	r4, [pc], -lr, asr #4
     f20:	59535f50 	ldmdbpl	r3, {r4, r6, r8, r9, sl, fp, ip, lr}^
     f24:	47455253 	smlsldmi	r5, r5, r3, r2	; <UNPREDICTABLE>
     f28:	73690053 	cmnvc	r9, #83	; 0x53
     f2c:	69625f61 	stmdbvs	r2!, {r0, r5, r6, r8, r9, sl, fp, ip, lr}^
     f30:	75715f74 	ldrbvc	r5, [r1, #-3956]!	; 0xfffff08c
     f34:	5f6b7269 	svcpl	0x006b7269
     f38:	646c6c76 	strbtvs	r6, [ip], #-3190	; 0xfffff38a
     f3c:	7369006d 	cmnvc	r9, #109	; 0x6d
     f40:	69625f61 	stmdbvs	r2!, {r0, r5, r6, r8, r9, sl, fp, ip, lr}^
     f44:	64635f74 	strbtvs	r5, [r3], #-3956	; 0xfffff08c
     f48:	35706365 	ldrbcc	r6, [r0, #-869]!	; 0xfffffc9b
     f4c:	61736900 	cmnvs	r3, r0, lsl #18
     f50:	7469625f 	strbtvc	r6, [r9], #-607	; 0xfffffda1
     f54:	7066765f 	rsbvc	r7, r6, pc, asr r6
     f58:	69003276 	stmdbvs	r0, {r1, r2, r4, r5, r6, r9, ip, sp}
     f5c:	625f6173 	subsvs	r6, pc, #-1073741796	; 0xc000001c
     f60:	765f7469 	ldrbvc	r7, [pc], -r9, ror #8
     f64:	33767066 	cmncc	r6, #102	; 0x66
     f68:	61736900 	cmnvs	r3, r0, lsl #18
     f6c:	7469625f 	strbtvc	r6, [r9], #-607	; 0xfffffda1
     f70:	7066765f 	rsbvc	r7, r6, pc, asr r6
     f74:	46003476 			; <UNDEFINED> instruction: 0x46003476
     f78:	54584350 	ldrbpl	r4, [r8], #-848	; 0xfffffcb0
     f7c:	455f534e 	ldrbmi	r5, [pc, #-846]	; c36 <shift+0xc36>
     f80:	004d554e 	subeq	r5, sp, lr, asr #10
     f84:	5f617369 	svcpl	0x00617369
     f88:	5f746962 	svcpl	0x00746962
     f8c:	6d756874 	ldclvs	8, cr6, [r5, #-464]!	; 0xfffffe30
     f90:	73690062 	cmnvc	r9, #98	; 0x62
     f94:	69625f61 	stmdbvs	r2!, {r0, r5, r6, r8, r9, sl, fp, ip, lr}^
     f98:	70665f74 	rsbvc	r5, r6, r4, ror pc
     f9c:	6f633631 	svcvs	0x00633631
     fa0:	6900766e 	stmdbvs	r0, {r1, r2, r3, r5, r6, r9, sl, ip, sp, lr}
     fa4:	665f6173 			; <UNDEFINED> instruction: 0x665f6173
     fa8:	75746165 	ldrbvc	r6, [r4, #-357]!	; 0xfffffe9b
     fac:	69006572 	stmdbvs	r0, {r1, r4, r5, r6, r8, sl, sp, lr}
     fb0:	625f6173 	subsvs	r6, pc, #-1073741796	; 0xc000001c
     fb4:	6e5f7469 	cdpvs	4, 5, cr7, cr15, cr9, {3}
     fb8:	006d746f 	rsbeq	r7, sp, pc, ror #8
     fbc:	5f617369 	svcpl	0x00617369
     fc0:	5f746962 	svcpl	0x00746962
     fc4:	72697571 	rsbvc	r7, r9, #473956352	; 0x1c400000
     fc8:	72615f6b 	rsbvc	r5, r1, #428	; 0x1ac
     fcc:	6b36766d 	blvs	d9e988 <_bss_end+0xd9597c>
     fd0:	7369007a 	cmnvc	r9, #122	; 0x7a
     fd4:	69625f61 	stmdbvs	r2!, {r0, r5, r6, r8, r9, sl, fp, ip, lr}^
     fd8:	72635f74 	rsbvc	r5, r3, #116, 30	; 0x1d0
     fdc:	00323363 	eorseq	r3, r2, r3, ror #6
     fe0:	5f617369 	svcpl	0x00617369
     fe4:	5f746962 	svcpl	0x00746962
     fe8:	766d7261 	strbtvc	r7, [sp], -r1, ror #4
     fec:	73690039 	cmnvc	r9, #57	; 0x39
     ff0:	69625f61 	stmdbvs	r2!, {r0, r5, r6, r8, r9, sl, fp, ip, lr}^
     ff4:	75715f74 	ldrbvc	r5, [r1, #-3956]!	; 0xfffff08c
     ff8:	5f6b7269 	svcpl	0x006b7269
     ffc:	615f6f6e 	cmpvs	pc, lr, ror #30
    1000:	70636d73 	rsbvc	r6, r3, r3, ror sp
    1004:	73690075 	cmnvc	r9, #117	; 0x75
    1008:	69625f61 	stmdbvs	r2!, {r0, r5, r6, r8, r9, sl, fp, ip, lr}^
    100c:	72615f74 	rsbvc	r5, r1, #116, 30	; 0x1d0
    1010:	0034766d 	eorseq	r7, r4, sp, ror #12
    1014:	5f617369 	svcpl	0x00617369
    1018:	5f746962 	svcpl	0x00746962
    101c:	6d756874 	ldclvs	8, cr6, [r5, #-464]!	; 0xfffffe30
    1020:	69003262 	stmdbvs	r0, {r1, r5, r6, r9, ip, sp}
    1024:	625f6173 	subsvs	r6, pc, #-1073741796	; 0xc000001c
    1028:	625f7469 	subsvs	r7, pc, #1761607680	; 0x69000000
    102c:	69003865 	stmdbvs	r0, {r0, r2, r5, r6, fp, ip, sp}
    1030:	625f6173 	subsvs	r6, pc, #-1073741796	; 0xc000001c
    1034:	615f7469 	cmpvs	pc, r9, ror #8
    1038:	37766d72 			; <UNDEFINED> instruction: 0x37766d72
    103c:	61736900 	cmnvs	r3, r0, lsl #18
    1040:	7469625f 	strbtvc	r6, [r9], #-607	; 0xfffffda1
    1044:	6d72615f 	ldfvse	f6, [r2, #-380]!	; 0xfffffe84
    1048:	76003876 			; <UNDEFINED> instruction: 0x76003876
    104c:	735f7066 	cmpvc	pc, #102	; 0x66
    1050:	65727379 	ldrbvs	r7, [r2, #-889]!	; 0xfffffc87
    1054:	655f7367 	ldrbvs	r7, [pc, #-871]	; cf5 <shift+0xcf5>
    1058:	646f636e 	strbtvs	r6, [pc], #-878	; 1060 <shift+0x1060>
    105c:	00676e69 	rsbeq	r6, r7, r9, ror #28
    1060:	5f617369 	svcpl	0x00617369
    1064:	5f746962 	svcpl	0x00746962
    1068:	36317066 	ldrtcc	r7, [r1], -r6, rrx
    106c:	006c6d66 	rsbeq	r6, ip, r6, ror #26
    1070:	20554e47 	subscs	r4, r5, r7, asr #28
    1074:	20373143 	eorscs	r3, r7, r3, asr #2
    1078:	322e3231 	eorcc	r3, lr, #268435459	; 0x10000003
    107c:	2d20302e 	stccs	0, cr3, [r0, #-184]!	; 0xffffff48
    1080:	6d72616d 	ldfvse	f6, [r2, #-436]!	; 0xfffffe4c
    1084:	666d2d20 	strbtvs	r2, [sp], -r0, lsr #26
    1088:	74616f6c 	strbtvc	r6, [r1], #-3948	; 0xfffff094
    108c:	6962612d 	stmdbvs	r2!, {r0, r2, r3, r5, r8, sp, lr}^
    1090:	7261683d 	rsbvc	r6, r1, #3997696	; 0x3d0000
    1094:	6d2d2064 	stcvs	0, cr2, [sp, #-400]!	; 0xfffffe70
    1098:	68637261 	stmdavs	r3!, {r0, r5, r6, r9, ip, sp, lr}^
    109c:	6d72613d 	ldfvse	f6, [r2, #-244]!	; 0xffffff0c
    10a0:	65743576 	ldrbvs	r3, [r4, #-1398]!	; 0xfffffa8a
    10a4:	2070662b 	rsbscs	r6, r0, fp, lsr #12
    10a8:	2d20672d 	stccs	7, cr6, [r0, #-180]!	; 0xffffff4c
    10ac:	672d2067 	strvs	r2, [sp, -r7, rrx]!
    10b0:	324f2d20 	subcc	r2, pc, #32, 26	; 0x800
    10b4:	324f2d20 	subcc	r2, pc, #32, 26	; 0x800
    10b8:	324f2d20 	subcc	r2, pc, #32, 26	; 0x800
    10bc:	62662d20 	rsbvs	r2, r6, #32, 26	; 0x800
    10c0:	646c6975 	strbtvs	r6, [ip], #-2421	; 0xfffff68b
    10c4:	2d676e69 	stclcs	14, cr6, [r7, #-420]!	; 0xfffffe5c
    10c8:	6762696c 	strbvs	r6, [r2, -ip, ror #18]!
    10cc:	2d206363 	stccs	3, cr6, [r0, #-396]!	; 0xfffffe74
    10d0:	2d6f6e66 	stclcs	14, cr6, [pc, #-408]!	; f40 <shift+0xf40>
    10d4:	63617473 	cmnvs	r1, #1929379840	; 0x73000000
    10d8:	72702d6b 	rsbsvc	r2, r0, #6848	; 0x1ac0
    10dc:	6365746f 	cmnvs	r5, #1862270976	; 0x6f000000
    10e0:	20726f74 	rsbscs	r6, r2, r4, ror pc
    10e4:	6f6e662d 	svcvs	0x006e662d
    10e8:	6c6e692d 			; <UNDEFINED> instruction: 0x6c6e692d
    10ec:	20656e69 	rsbcs	r6, r5, r9, ror #28
    10f0:	6976662d 	ldmdbvs	r6!, {r0, r2, r3, r5, r9, sl, sp, lr}^
    10f4:	69626973 	stmdbvs	r2!, {r0, r1, r4, r5, r6, r8, fp, sp, lr}^
    10f8:	7974696c 	ldmdbvc	r4!, {r2, r3, r5, r6, r8, fp, sp, lr}^
    10fc:	6469683d 	strbtvs	r6, [r9], #-2109	; 0xfffff7c3
    1100:	006e6564 	rsbeq	r6, lr, r4, ror #10
    1104:	5f617369 	svcpl	0x00617369
    1108:	5f746962 	svcpl	0x00746962
    110c:	72697571 	rsbvc	r7, r9, #473956352	; 0x1c400000
    1110:	65615f6b 	strbvs	r5, [r1, #-3947]!	; 0xfffff095
    1114:	37315f73 			; <UNDEFINED> instruction: 0x37315f73
    1118:	39303234 	ldmdbcc	r0!, {r2, r4, r5, r9, ip, sp}
    111c:	73690038 	cmnvc	r9, #56	; 0x38
    1120:	69625f61 	stmdbvs	r2!, {r0, r5, r6, r8, r9, sl, fp, ip, lr}^
    1124:	6f645f74 	svcvs	0x00645f74
    1128:	6f727074 	svcvs	0x00727074
    112c:	Address 0x000000000000112c is out of bounds.


Disassembly of section .comment:

00000000 <.comment>:
   0:	3a434347 	bcc	10d0d24 <_bss_end+0x10c7d18>
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
  10:	4b5a3605 	blmi	168d82c <_bss_end+0x1684820>
  14:	08070600 	stmdaeq	r7, {r9, sl}
  18:	0a010901 	beq	42424 <_bss_end+0x39418>
  1c:	14041202 	strne	r1, [r4], #-514	; 0xfffffdfe
  20:	17011501 	strne	r1, [r1, -r1, lsl #10]
  24:	1a011803 	bne	46038 <_bss_end+0x3d02c>
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
  20:	8b040e42 	blhi	103930 <_bss_end+0xfa924>
  24:	0b0d4201 	bleq	350830 <_bss_end+0x347824>
  28:	420d0d54 	andmi	r0, sp, #84, 26	; 0x1500
  2c:	00000ecb 	andeq	r0, r0, fp, asr #29
  30:	0000001c 	andeq	r0, r0, ip, lsl r0
  34:	00000000 	andeq	r0, r0, r0
  38:	00008050 	andeq	r8, r0, r0, asr r0
  3c:	0000002c 	andeq	r0, r0, ip, lsr #32
  40:	8b040e42 	blhi	103950 <_bss_end+0xfa944>
  44:	0b0d4201 	bleq	350850 <_bss_end+0x347844>
  48:	420d0d4e 	andmi	r0, sp, #4992	; 0x1380
  4c:	00000ecb 	andeq	r0, r0, fp, asr #29
  50:	0000001c 	andeq	r0, r0, ip, lsl r0
  54:	00000000 	andeq	r0, r0, r0
  58:	0000807c 	andeq	r8, r0, ip, ror r0
  5c:	00000020 	andeq	r0, r0, r0, lsr #32
  60:	8b040e42 	blhi	103970 <_bss_end+0xfa964>
  64:	0b0d4201 	bleq	350870 <_bss_end+0x347864>
  68:	420d0d48 	andmi	r0, sp, #72, 26	; 0x1200
  6c:	00000ecb 	andeq	r0, r0, fp, asr #29
  70:	0000001c 	andeq	r0, r0, ip, lsl r0
  74:	00000000 	andeq	r0, r0, r0
  78:	0000809c 	muleq	r0, ip, r0
  7c:	00000018 	andeq	r0, r0, r8, lsl r0
  80:	8b040e42 	blhi	103990 <_bss_end+0xfa984>
  84:	0b0d4201 	bleq	350890 <_bss_end+0x347884>
  88:	420d0d44 	andmi	r0, sp, #68, 26	; 0x1100
  8c:	00000ecb 	andeq	r0, r0, fp, asr #29
  90:	0000001c 	andeq	r0, r0, ip, lsl r0
  94:	00000000 	andeq	r0, r0, r0
  98:	000080b4 	strheq	r8, [r0], -r4
  9c:	00000018 	andeq	r0, r0, r8, lsl r0
  a0:	8b040e42 	blhi	1039b0 <_bss_end+0xfa9a4>
  a4:	0b0d4201 	bleq	3508b0 <_bss_end+0x3478a4>
  a8:	420d0d44 	andmi	r0, sp, #68, 26	; 0x1100
  ac:	00000ecb 	andeq	r0, r0, fp, asr #29
  b0:	0000001c 	andeq	r0, r0, ip, lsl r0
  b4:	00000000 	andeq	r0, r0, r0
  b8:	000080cc 	andeq	r8, r0, ip, asr #1
  bc:	00000018 	andeq	r0, r0, r8, lsl r0
  c0:	8b040e42 	blhi	1039d0 <_bss_end+0xfa9c4>
  c4:	0b0d4201 	bleq	3508d0 <_bss_end+0x3478c4>
  c8:	420d0d44 	andmi	r0, sp, #68, 26	; 0x1100
  cc:	00000ecb 	andeq	r0, r0, fp, asr #29
  d0:	00000014 	andeq	r0, r0, r4, lsl r0
  d4:	00000000 	andeq	r0, r0, r0
  d8:	000080e4 	andeq	r8, r0, r4, ror #1
  dc:	0000000c 	andeq	r0, r0, ip
  e0:	8b040e42 	blhi	1039f0 <_bss_end+0xfa9e4>
  e4:	0b0d4201 	bleq	3508f0 <_bss_end+0x3478e4>
  e8:	0000000c 	andeq	r0, r0, ip
  ec:	ffffffff 			; <UNDEFINED> instruction: 0xffffffff
  f0:	7c020001 	stcvc	0, cr0, [r2], {1}
  f4:	000d0c0e 	andeq	r0, sp, lr, lsl #24
  f8:	0000001c 	andeq	r0, r0, ip, lsl r0
  fc:	000000e8 	andeq	r0, r0, r8, ror #1
 100:	000080f0 	strdeq	r8, [r0], -r0
 104:	00000034 	andeq	r0, r0, r4, lsr r0
 108:	8b040e42 	blhi	103a18 <_bss_end+0xfaa0c>
 10c:	0b0d4201 	bleq	350918 <_bss_end+0x34790c>
 110:	420d0d52 	andmi	r0, sp, #5248	; 0x1480
 114:	00000ecb 	andeq	r0, r0, fp, asr #29
 118:	0000001c 	andeq	r0, r0, ip, lsl r0
 11c:	000000e8 	andeq	r0, r0, r8, ror #1
 120:	00008124 	andeq	r8, r0, r4, lsr #2
 124:	00000050 	andeq	r0, r0, r0, asr r0
 128:	8b080e42 	blhi	203a38 <_bss_end+0x1faa2c>
 12c:	42018e02 	andmi	r8, r1, #2, 28
 130:	62040b0c 	andvs	r0, r4, #12, 22	; 0x3000
 134:	00080d0c 	andeq	r0, r8, ip, lsl #26
 138:	0000001c 	andeq	r0, r0, ip, lsl r0
 13c:	000000e8 	andeq	r0, r0, r8, ror #1
 140:	00008174 	andeq	r8, r0, r4, ror r1
 144:	00000054 	andeq	r0, r0, r4, asr r0
 148:	8b080e42 	blhi	203a58 <_bss_end+0x1faa4c>
 14c:	42018e02 	andmi	r8, r1, #2, 28
 150:	64040b0c 	strvs	r0, [r4], #-2828	; 0xfffff4f4
 154:	00080d0c 	andeq	r0, r8, ip, lsl #26
 158:	0000001c 	andeq	r0, r0, ip, lsl r0
 15c:	000000e8 	andeq	r0, r0, r8, ror #1
 160:	000081c8 	andeq	r8, r0, r8, asr #3
 164:	00000044 	andeq	r0, r0, r4, asr #32
 168:	8b040e42 	blhi	103a78 <_bss_end+0xfaa6c>
 16c:	0b0d4201 	bleq	350978 <_bss_end+0x34796c>
 170:	420d0d5a 	andmi	r0, sp, #5760	; 0x1680
 174:	00000ecb 	andeq	r0, r0, fp, asr #29
 178:	0000001c 	andeq	r0, r0, ip, lsl r0
 17c:	000000e8 	andeq	r0, r0, r8, ror #1
 180:	0000820c 	andeq	r8, r0, ip, lsl #4
 184:	0000003c 	andeq	r0, r0, ip, lsr r0
 188:	8b040e42 	blhi	103a98 <_bss_end+0xfaa8c>
 18c:	0b0d4201 	bleq	350998 <_bss_end+0x34798c>
 190:	420d0d56 	andmi	r0, sp, #5504	; 0x1580
 194:	00000ecb 	andeq	r0, r0, fp, asr #29
 198:	0000001c 	andeq	r0, r0, ip, lsl r0
 19c:	000000e8 	andeq	r0, r0, r8, ror #1
 1a0:	00008248 	andeq	r8, r0, r8, asr #4
 1a4:	00000054 	andeq	r0, r0, r4, asr r0
 1a8:	8b080e42 	blhi	203ab8 <_bss_end+0x1faaac>
 1ac:	42018e02 	andmi	r8, r1, #2, 28
 1b0:	5e040b0c 	vmlapl.f64	d0, d4, d12
 1b4:	00080d0c 	andeq	r0, r8, ip, lsl #26
 1b8:	00000018 	andeq	r0, r0, r8, lsl r0
 1bc:	000000e8 	andeq	r0, r0, r8, ror #1
 1c0:	0000829c 	muleq	r0, ip, r2
 1c4:	0000001c 	andeq	r0, r0, ip, lsl r0
 1c8:	8b080e42 	blhi	203ad8 <_bss_end+0x1faacc>
 1cc:	42018e02 	andmi	r8, r1, #2, 28
 1d0:	00040b0c 	andeq	r0, r4, ip, lsl #22
 1d4:	0000000c 	andeq	r0, r0, ip
 1d8:	ffffffff 			; <UNDEFINED> instruction: 0xffffffff
 1dc:	7c020001 	stcvc	0, cr0, [r2], {1}
 1e0:	000d0c0e 	andeq	r0, sp, lr, lsl #24
 1e4:	0000001c 	andeq	r0, r0, ip, lsl r0
 1e8:	000001d4 	ldrdeq	r0, [r0], -r4
 1ec:	000082b8 			; <UNDEFINED> instruction: 0x000082b8
 1f0:	00000034 	andeq	r0, r0, r4, lsr r0
 1f4:	8b040e42 	blhi	103b04 <_bss_end+0xfaaf8>
 1f8:	0b0d4201 	bleq	350a04 <_bss_end+0x3479f8>
 1fc:	420d0d52 	andmi	r0, sp, #5248	; 0x1480
 200:	00000ecb 	andeq	r0, r0, fp, asr #29
 204:	0000001c 	andeq	r0, r0, ip, lsl r0
 208:	000001d4 	ldrdeq	r0, [r0], -r4
 20c:	000082ec 	andeq	r8, r0, ip, ror #5
 210:	00000114 	andeq	r0, r0, r4, lsl r1
 214:	8b040e42 	blhi	103b24 <_bss_end+0xfab18>
 218:	0b0d4201 	bleq	350a24 <_bss_end+0x347a18>
 21c:	0d0d8002 	stceq	0, cr8, [sp, #-8]
 220:	000ecb42 	andeq	ip, lr, r2, asr #22
 224:	0000001c 	andeq	r0, r0, ip, lsl r0
 228:	000001d4 	ldrdeq	r0, [r0], -r4
 22c:	00008400 	andeq	r8, r0, r0, lsl #8
 230:	00000074 	andeq	r0, r0, r4, ror r0
 234:	8b040e42 	blhi	103b44 <_bss_end+0xfab38>
 238:	0b0d4201 	bleq	350a44 <_bss_end+0x347a38>
 23c:	420d0d72 	andmi	r0, sp, #7296	; 0x1c80
 240:	00000ecb 	andeq	r0, r0, fp, asr #29
 244:	0000001c 	andeq	r0, r0, ip, lsl r0
 248:	000001d4 	ldrdeq	r0, [r0], -r4
 24c:	00008474 	andeq	r8, r0, r4, ror r4
 250:	00000074 	andeq	r0, r0, r4, ror r0
 254:	8b040e42 	blhi	103b64 <_bss_end+0xfab58>
 258:	0b0d4201 	bleq	350a64 <_bss_end+0x347a58>
 25c:	420d0d72 	andmi	r0, sp, #7296	; 0x1c80
 260:	00000ecb 	andeq	r0, r0, fp, asr #29
 264:	0000001c 	andeq	r0, r0, ip, lsl r0
 268:	000001d4 	ldrdeq	r0, [r0], -r4
 26c:	000084e8 	andeq	r8, r0, r8, ror #9
 270:	00000074 	andeq	r0, r0, r4, ror r0
 274:	8b040e42 	blhi	103b84 <_bss_end+0xfab78>
 278:	0b0d4201 	bleq	350a84 <_bss_end+0x347a78>
 27c:	420d0d72 	andmi	r0, sp, #7296	; 0x1c80
 280:	00000ecb 	andeq	r0, r0, fp, asr #29
 284:	0000001c 	andeq	r0, r0, ip, lsl r0
 288:	000001d4 	ldrdeq	r0, [r0], -r4
 28c:	0000855c 	andeq	r8, r0, ip, asr r5
 290:	000000a0 	andeq	r0, r0, r0, lsr #1
 294:	8b080e42 	blhi	203ba4 <_bss_end+0x1fab98>
 298:	42018e02 	andmi	r8, r1, #2, 28
 29c:	02040b0c 	andeq	r0, r4, #12, 22	; 0x3000
 2a0:	080d0c4a 	stmdaeq	sp, {r1, r3, r6, sl, fp}
 2a4:	0000001c 	andeq	r0, r0, ip, lsl r0
 2a8:	000001d4 	ldrdeq	r0, [r0], -r4
 2ac:	000085fc 	strdeq	r8, [r0], -ip
 2b0:	00000074 	andeq	r0, r0, r4, ror r0
 2b4:	8b080e42 	blhi	203bc4 <_bss_end+0x1fabb8>
 2b8:	42018e02 	andmi	r8, r1, #2, 28
 2bc:	74040b0c 	strvc	r0, [r4], #-2828	; 0xfffff4f4
 2c0:	00080d0c 	andeq	r0, r8, ip, lsl #26
 2c4:	0000001c 	andeq	r0, r0, ip, lsl r0
 2c8:	000001d4 	ldrdeq	r0, [r0], -r4
 2cc:	00008670 	andeq	r8, r0, r0, ror r6
 2d0:	000000d8 	ldrdeq	r0, [r0], -r8
 2d4:	8b080e42 	blhi	203be4 <_bss_end+0x1fabd8>
 2d8:	42018e02 	andmi	r8, r1, #2, 28
 2dc:	02040b0c 	andeq	r0, r4, #12, 22	; 0x3000
 2e0:	080d0c66 	stmdaeq	sp, {r1, r2, r5, r6, sl, fp}
 2e4:	0000001c 	andeq	r0, r0, ip, lsl r0
 2e8:	000001d4 	ldrdeq	r0, [r0], -r4
 2ec:	00008748 	andeq	r8, r0, r8, asr #14
 2f0:	00000054 	andeq	r0, r0, r4, asr r0
 2f4:	8b080e42 	blhi	203c04 <_bss_end+0x1fabf8>
 2f8:	42018e02 	andmi	r8, r1, #2, 28
 2fc:	5e040b0c 	vmlapl.f64	d0, d4, d12
 300:	00080d0c 	andeq	r0, r8, ip, lsl #26
 304:	00000018 	andeq	r0, r0, r8, lsl r0
 308:	000001d4 	ldrdeq	r0, [r0], -r4
 30c:	0000879c 	muleq	r0, ip, r7
 310:	0000001c 	andeq	r0, r0, ip, lsl r0
 314:	8b080e42 	blhi	203c24 <_bss_end+0x1fac18>
 318:	42018e02 	andmi	r8, r1, #2, 28
 31c:	00040b0c 	andeq	r0, r4, ip, lsl #22
 320:	0000000c 	andeq	r0, r0, ip
 324:	ffffffff 			; <UNDEFINED> instruction: 0xffffffff
 328:	7c020001 	stcvc	0, cr0, [r2], {1}
 32c:	000d0c0e 	andeq	r0, sp, lr, lsl #24
 330:	0000001c 	andeq	r0, r0, ip, lsl r0
 334:	00000320 	andeq	r0, r0, r0, lsr #6
 338:	000087b8 			; <UNDEFINED> instruction: 0x000087b8
 33c:	000000a4 	andeq	r0, r0, r4, lsr #1
 340:	8b080e42 	blhi	203c50 <_bss_end+0x1fac44>
 344:	42018e02 	andmi	r8, r1, #2, 28
 348:	02040b0c 	andeq	r0, r4, #12, 22	; 0x3000
 34c:	080d0c4c 	stmdaeq	sp, {r2, r3, r6, sl, fp}
 350:	00000020 	andeq	r0, r0, r0, lsr #32
 354:	00000320 	andeq	r0, r0, r0, lsr #6
 358:	0000885c 	andeq	r8, r0, ip, asr r8
 35c:	0000005c 	andeq	r0, r0, ip, asr r0
 360:	840c0e42 	strhi	r0, [ip], #-3650	; 0xfffff1be
 364:	8e028b03 	vmlahi.f64	d8, d2, d3
 368:	0b0c4201 	bleq	310b74 <_bss_end+0x307b68>
 36c:	0d0c6804 	stceq	8, cr6, [ip, #-16]
 370:	0000000c 	andeq	r0, r0, ip
 374:	0000001c 	andeq	r0, r0, ip, lsl r0
 378:	00000320 	andeq	r0, r0, r0, lsr #6
 37c:	000088b8 			; <UNDEFINED> instruction: 0x000088b8
 380:	00000094 	muleq	r0, r4, r0
 384:	8b080e42 	blhi	203c94 <_bss_end+0x1fac88>
 388:	42018e02 	andmi	r8, r1, #2, 28
 38c:	02040b0c 	andeq	r0, r4, #12, 22	; 0x3000
 390:	080d0c40 	stmdaeq	sp, {r6, sl, fp}
 394:	0000001c 	andeq	r0, r0, ip, lsl r0
 398:	00000320 	andeq	r0, r0, r0, lsr #6
 39c:	0000894c 	andeq	r8, r0, ip, asr #18
 3a0:	00000074 	andeq	r0, r0, r4, ror r0
 3a4:	8b080e42 	blhi	203cb4 <_bss_end+0x1faca8>
 3a8:	42018e02 	andmi	r8, r1, #2, 28
 3ac:	74040b0c 	strvc	r0, [r4], #-2828	; 0xfffff4f4
 3b0:	00080d0c 	andeq	r0, r8, ip, lsl #26
 3b4:	0000001c 	andeq	r0, r0, ip, lsl r0
 3b8:	00000320 	andeq	r0, r0, r0, lsr #6
 3bc:	000089c0 	andeq	r8, r0, r0, asr #19
 3c0:	00000070 	andeq	r0, r0, r0, ror r0
 3c4:	8b080e42 	blhi	203cd4 <_bss_end+0x1facc8>
 3c8:	42018e02 	andmi	r8, r1, #2, 28
 3cc:	72040b0c 	andvc	r0, r4, #12, 22	; 0x3000
 3d0:	00080d0c 	andeq	r0, r8, ip, lsl #26
 3d4:	0000001c 	andeq	r0, r0, ip, lsl r0
 3d8:	00000320 	andeq	r0, r0, r0, lsr #6
 3dc:	00008a30 	andeq	r8, r0, r0, lsr sl
 3e0:	00000054 	andeq	r0, r0, r4, asr r0
 3e4:	8b080e42 	blhi	203cf4 <_bss_end+0x1face8>
 3e8:	42018e02 	andmi	r8, r1, #2, 28
 3ec:	5e040b0c 	vmlapl.f64	d0, d4, d12
 3f0:	00080d0c 	andeq	r0, r8, ip, lsl #26
 3f4:	00000018 	andeq	r0, r0, r8, lsl r0
 3f8:	00000320 	andeq	r0, r0, r0, lsr #6
 3fc:	00008a84 	andeq	r8, r0, r4, lsl #21
 400:	0000001c 	andeq	r0, r0, ip, lsl r0
 404:	8b080e42 	blhi	203d14 <_bss_end+0x1fad08>
 408:	42018e02 	andmi	r8, r1, #2, 28
 40c:	00040b0c 	andeq	r0, r4, ip, lsl #22
 410:	0000000c 	andeq	r0, r0, ip
 414:	ffffffff 			; <UNDEFINED> instruction: 0xffffffff
 418:	7c020001 	stcvc	0, cr0, [r2], {1}
 41c:	000d0c0e 	andeq	r0, sp, lr, lsl #24
 420:	00000018 	andeq	r0, r0, r8, lsl r0
 424:	00000410 	andeq	r0, r0, r0, lsl r4
 428:	00008aa0 	andeq	r8, r0, r0, lsr #21
 42c:	000000f4 	strdeq	r0, [r0], -r4
 430:	8b080e42 	blhi	203d40 <_bss_end+0x1fad34>
 434:	42018e02 	andmi	r8, r1, #2, 28
 438:	00040b0c 	andeq	r0, r4, ip, lsl #22
 43c:	0000000c 	andeq	r0, r0, ip
 440:	ffffffff 			; <UNDEFINED> instruction: 0xffffffff
 444:	7c020001 	stcvc	0, cr0, [r2], {1}
 448:	000d0c0e 	andeq	r0, sp, lr, lsl #24
 44c:	0000001c 	andeq	r0, r0, ip, lsl r0
 450:	0000043c 	andeq	r0, r0, ip, lsr r4
 454:	00008b94 	muleq	r0, r4, fp
 458:	00000068 	andeq	r0, r0, r8, rrx
 45c:	8b040e42 	blhi	103d6c <_bss_end+0xfad60>
 460:	0b0d4201 	bleq	350c6c <_bss_end+0x347c60>
 464:	420d0d68 	andmi	r0, sp, #104, 26	; 0x1a00
 468:	00000ecb 	andeq	r0, r0, fp, asr #29
 46c:	0000001c 	andeq	r0, r0, ip, lsl r0
 470:	0000043c 	andeq	r0, r0, ip, lsr r4
 474:	00008bfc 	strdeq	r8, [r0], -ip
 478:	00000058 	andeq	r0, r0, r8, asr r0
 47c:	8b080e42 	blhi	203d8c <_bss_end+0x1fad80>
 480:	42018e02 	andmi	r8, r1, #2, 28
 484:	62040b0c 	andvs	r0, r4, #12, 22	; 0x3000
 488:	00080d0c 	andeq	r0, r8, ip, lsl #26
 48c:	0000001c 	andeq	r0, r0, ip, lsl r0
 490:	0000043c 	andeq	r0, r0, ip, lsr r4
 494:	00008c54 	andeq	r8, r0, r4, asr ip
 498:	00000058 	andeq	r0, r0, r8, asr r0
 49c:	8b080e42 	blhi	203dac <_bss_end+0x1fada0>
 4a0:	42018e02 	andmi	r8, r1, #2, 28
 4a4:	62040b0c 	andvs	r0, r4, #12, 22	; 0x3000
 4a8:	00080d0c 	andeq	r0, r8, ip, lsl #26
 4ac:	0000000c 	andeq	r0, r0, ip
 4b0:	ffffffff 			; <UNDEFINED> instruction: 0xffffffff
 4b4:	7c010001 	stcvc	0, cr0, [r1], {1}
 4b8:	000d0c0e 	andeq	r0, sp, lr, lsl #24
 4bc:	0000000c 	andeq	r0, r0, ip
 4c0:	000004ac 	andeq	r0, r0, ip, lsr #9
 4c4:	00008cac 	andeq	r8, r0, ip, lsr #25
 4c8:	000001ec 	andeq	r0, r0, ip, ror #3

Disassembly of section .debug_line_str:

00000000 <.debug_line_str>:
   0:	6d6f682f 	stclvs	8, cr6, [pc, #-188]!	; ffffff4c <_bss_end+0xffff6f40>
   4:	66632f65 	strbtvs	r2, [r3], -r5, ror #30
   8:	55435a2f 	strbpl	r5, [r3, #-2607]	; 0xfffff5d1
   c:	2f534f2f 	svccs	0x00534f2f
  10:	63617270 	cmnvs	r1, #112, 4
  14:	61636974 	smcvs	13972	; 0x3694
  18:	78652f6c 	stmdavc	r5!, {r2, r3, r5, r6, r8, r9, sl, fp, sp}^
  1c:	726f2f33 	rsbvc	r2, pc, #51, 30	; 0xcc
  20:	6e696769 	cdpvs	7, 6, cr6, cr9, cr9, {3}
  24:	622f6c61 	eorvs	r6, pc, #24832	; 0x6100
  28:	646c6975 	strbtvs	r6, [ip], #-2421	; 0xfffff68b
  2c:	6f682f00 	svcvs	0x00682f00
  30:	632f656d 			; <UNDEFINED> instruction: 0x632f656d
  34:	435a2f66 	cmpmi	sl, #408	; 0x198
  38:	534f2f55 	movtpl	r2, #65365	; 0xff55
  3c:	6172702f 	cmnvs	r2, pc, lsr #32
  40:	63697463 	cmnvs	r9, #1660944384	; 0x63000000
  44:	652f6c61 	strvs	r6, [pc, #-3169]!	; fffff3eb <_bss_end+0xffff63df>
  48:	6f2f3378 	svcvs	0x002f3378
  4c:	69676972 	stmdbvs	r7!, {r1, r4, r5, r6, r8, fp, sp, lr}^
  50:	2f6c616e 	svccs	0x006c616e
  54:	6e72656b 	cdpvs	5, 7, cr6, cr2, cr11, {3}
  58:	732f6c65 			; <UNDEFINED> instruction: 0x732f6c65
  5c:	73006372 	movwvc	r6, #882	; 0x372
  60:	74726174 	ldrbtvc	r6, [r2], #-372	; 0xfffffe8c
  64:	2e00732e 	cdpcs	3, 0, cr7, cr0, cr14, {1}
  68:	2e2e2f2e 	cdpcs	15, 2, cr2, cr14, cr14, {1}
  6c:	2f2e2e2f 	svccs	0x002e2e2f
  70:	2e2f2e2e 	cdpcs	14, 2, cr2, cr15, cr14, {1}
  74:	2e2e2f2e 	cdpcs	15, 2, cr2, cr14, cr14, {1}
  78:	6363672f 	cmnvs	r3, #12320768	; 0xbc0000
  7c:	2e32312d 	rsfcssp	f3, f2, #5.0
  80:	2f302e32 	svccs	0x00302e32
  84:	6762696c 	strbvs	r6, [r2, -ip, ror #18]!
  88:	632f6363 			; <UNDEFINED> instruction: 0x632f6363
  8c:	69666e6f 	stmdbvs	r6!, {r0, r1, r2, r3, r5, r6, r9, sl, fp, sp, lr}^
  90:	72612f67 	rsbvc	r2, r1, #412	; 0x19c
  94:	696c006d 	stmdbvs	ip!, {r0, r2, r3, r5, r6}^
  98:	75663162 	strbvc	r3, [r6, #-354]!	; 0xfffffe9e
  9c:	2e73636e 	cdpcs	3, 7, cr6, cr3, cr14, {3}
  a0:	Address 0x00000000000000a0 is out of bounds.

