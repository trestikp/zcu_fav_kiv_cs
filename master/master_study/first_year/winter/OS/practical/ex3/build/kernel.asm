
./kernel:     file format elf32-littlearm


Disassembly of section .text:

00008000 <_start>:
_start():
/home/cf/ZCU/first_year/winter/OS/practical/ex3/kernel/src/start.s:8
;@ tady budou symboly, ktere chceme na zacatek kodove sekce
.section .text.start

;@ vstupni bod do kernelu - nechame ho vlozit na zacatek kodu
_start:
    mov sp,#0x8000			;@ nastavime stack pointer na spodek zasobniku
    8000:	e3a0d902 	mov	sp, #32768	; 0x8000
/home/cf/ZCU/first_year/winter/OS/practical/ex3/kernel/src/start.s:9
	bl _c_startup			;@ C startup kod (inicializace prostredi)
    8004:	eb0003eb 	bl	8fb8 <_c_startup>
/home/cf/ZCU/first_year/winter/OS/practical/ex3/kernel/src/start.s:10
	bl _cpp_startup			;@ C++ startup kod (volani globalnich konstruktoru, ...)
    8008:	eb000404 	bl	9020 <_cpp_startup>
/home/cf/ZCU/first_year/winter/OS/practical/ex3/kernel/src/start.s:11
    bl _kernel_main			;@ skocime do hlavniho kodu jadra (v C)
    800c:	eb0003a3 	bl	8ea0 <_kernel_main>
/home/cf/ZCU/first_year/winter/OS/practical/ex3/kernel/src/start.s:12
	bl _cpp_shutdown		;@ C++ shutdown kod (volani globalnich destruktoru, ...)
    8010:	eb000418 	bl	9078 <_cpp_shutdown>

00008014 <hang>:
hang():
/home/cf/ZCU/first_year/winter/OS/practical/ex3/kernel/src/start.s:14
hang:
    b hang
    8014:	eafffffe 	b	8014 <hang>

00008018 <__cxa_guard_acquire>:
__cxa_guard_acquire():
/home/cf/ZCU/first_year/winter/OS/practical/ex3/kernel/src/cxx.cpp:11
	extern "C" int __cxa_guard_acquire (__guard *);
	extern "C" void __cxa_guard_release (__guard *);
	extern "C" void __cxa_guard_abort (__guard *);

	extern "C" int __cxa_guard_acquire (__guard *g)
	{
    8018:	e52db004 	push	{fp}		; (str fp, [sp, #-4]!)
    801c:	e28db000 	add	fp, sp, #0
    8020:	e24dd00c 	sub	sp, sp, #12
    8024:	e50b0008 	str	r0, [fp, #-8]
/home/cf/ZCU/first_year/winter/OS/practical/ex3/kernel/src/cxx.cpp:12
		return !*(char *)(g);
    8028:	e51b3008 	ldr	r3, [fp, #-8]
    802c:	e5d33000 	ldrb	r3, [r3]
    8030:	e3530000 	cmp	r3, #0
    8034:	03a03001 	moveq	r3, #1
    8038:	13a03000 	movne	r3, #0
    803c:	e6ef3073 	uxtb	r3, r3
/home/cf/ZCU/first_year/winter/OS/practical/ex3/kernel/src/cxx.cpp:13
	}
    8040:	e1a00003 	mov	r0, r3
    8044:	e28bd000 	add	sp, fp, #0
    8048:	e49db004 	pop	{fp}		; (ldr fp, [sp], #4)
    804c:	e12fff1e 	bx	lr

00008050 <__cxa_guard_release>:
__cxa_guard_release():
/home/cf/ZCU/first_year/winter/OS/practical/ex3/kernel/src/cxx.cpp:16

	extern "C" void __cxa_guard_release (__guard *g)
	{
    8050:	e52db004 	push	{fp}		; (str fp, [sp, #-4]!)
    8054:	e28db000 	add	fp, sp, #0
    8058:	e24dd00c 	sub	sp, sp, #12
    805c:	e50b0008 	str	r0, [fp, #-8]
/home/cf/ZCU/first_year/winter/OS/practical/ex3/kernel/src/cxx.cpp:17
		*(char *)g = 1;
    8060:	e51b3008 	ldr	r3, [fp, #-8]
    8064:	e3a02001 	mov	r2, #1
    8068:	e5c32000 	strb	r2, [r3]
/home/cf/ZCU/first_year/winter/OS/practical/ex3/kernel/src/cxx.cpp:18
	}
    806c:	e320f000 	nop	{0}
    8070:	e28bd000 	add	sp, fp, #0
    8074:	e49db004 	pop	{fp}		; (ldr fp, [sp], #4)
    8078:	e12fff1e 	bx	lr

0000807c <__cxa_guard_abort>:
__cxa_guard_abort():
/home/cf/ZCU/first_year/winter/OS/practical/ex3/kernel/src/cxx.cpp:21

	extern "C" void __cxa_guard_abort (__guard *)
	{
    807c:	e52db004 	push	{fp}		; (str fp, [sp, #-4]!)
    8080:	e28db000 	add	fp, sp, #0
    8084:	e24dd00c 	sub	sp, sp, #12
    8088:	e50b0008 	str	r0, [fp, #-8]
/home/cf/ZCU/first_year/winter/OS/practical/ex3/kernel/src/cxx.cpp:23

	}
    808c:	e320f000 	nop	{0}
    8090:	e28bd000 	add	sp, fp, #0
    8094:	e49db004 	pop	{fp}		; (ldr fp, [sp], #4)
    8098:	e12fff1e 	bx	lr

0000809c <__dso_handle>:
__dso_handle():
/home/cf/ZCU/first_year/winter/OS/practical/ex3/kernel/src/cxx.cpp:27
}

extern "C" void __dso_handle()
{
    809c:	e52db004 	push	{fp}		; (str fp, [sp, #-4]!)
    80a0:	e28db000 	add	fp, sp, #0
/home/cf/ZCU/first_year/winter/OS/practical/ex3/kernel/src/cxx.cpp:29
    // ignore dtors for now
}
    80a4:	e320f000 	nop	{0}
    80a8:	e28bd000 	add	sp, fp, #0
    80ac:	e49db004 	pop	{fp}		; (ldr fp, [sp], #4)
    80b0:	e12fff1e 	bx	lr

000080b4 <__cxa_atexit>:
__cxa_atexit():
/home/cf/ZCU/first_year/winter/OS/practical/ex3/kernel/src/cxx.cpp:32

extern "C" void __cxa_atexit()
{
    80b4:	e52db004 	push	{fp}		; (str fp, [sp, #-4]!)
    80b8:	e28db000 	add	fp, sp, #0
/home/cf/ZCU/first_year/winter/OS/practical/ex3/kernel/src/cxx.cpp:34
    // ignore dtors for now
}
    80bc:	e320f000 	nop	{0}
    80c0:	e28bd000 	add	sp, fp, #0
    80c4:	e49db004 	pop	{fp}		; (ldr fp, [sp], #4)
    80c8:	e12fff1e 	bx	lr

000080cc <__cxa_pure_virtual>:
__cxa_pure_virtual():
/home/cf/ZCU/first_year/winter/OS/practical/ex3/kernel/src/cxx.cpp:37

extern "C" void __cxa_pure_virtual()
{
    80cc:	e52db004 	push	{fp}		; (str fp, [sp, #-4]!)
    80d0:	e28db000 	add	fp, sp, #0
/home/cf/ZCU/first_year/winter/OS/practical/ex3/kernel/src/cxx.cpp:39
    // pure virtual method called
}
    80d4:	e320f000 	nop	{0}
    80d8:	e28bd000 	add	sp, fp, #0
    80dc:	e49db004 	pop	{fp}		; (ldr fp, [sp], #4)
    80e0:	e12fff1e 	bx	lr

000080e4 <__aeabi_unwind_cpp_pr1>:
__aeabi_unwind_cpp_pr1():
/home/cf/ZCU/first_year/winter/OS/practical/ex3/kernel/src/cxx.cpp:42

extern "C" void __aeabi_unwind_cpp_pr1()
{
    80e4:	e52db004 	push	{fp}		; (str fp, [sp, #-4]!)
    80e8:	e28db000 	add	fp, sp, #0
/home/cf/ZCU/first_year/winter/OS/practical/ex3/kernel/src/cxx.cpp:43 (discriminator 1)
	while (true)
    80ec:	eafffffe 	b	80ec <__aeabi_unwind_cpp_pr1+0x8>

000080f0 <_ZN4CAUXC1Ej>:
_ZN4CAUXC2Ej():
/home/cf/ZCU/first_year/winter/OS/practical/ex3/kernel/src/drivers/bcm_aux.cpp:5
#include <drivers/bcm_aux.h>

CAUX sAUX(hal::AUX_Base);

CAUX::CAUX(unsigned int aux_base)
    80f0:	e52db004 	push	{fp}		; (str fp, [sp, #-4]!)
    80f4:	e28db000 	add	fp, sp, #0
    80f8:	e24dd00c 	sub	sp, sp, #12
    80fc:	e50b0008 	str	r0, [fp, #-8]
    8100:	e50b100c 	str	r1, [fp, #-12]
/home/cf/ZCU/first_year/winter/OS/practical/ex3/kernel/src/drivers/bcm_aux.cpp:6
    : mAUX_Reg(reinterpret_cast<unsigned int*>(aux_base))
    8104:	e51b200c 	ldr	r2, [fp, #-12]
    8108:	e51b3008 	ldr	r3, [fp, #-8]
    810c:	e5832000 	str	r2, [r3]
/home/cf/ZCU/first_year/winter/OS/practical/ex3/kernel/src/drivers/bcm_aux.cpp:9
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
/home/cf/ZCU/first_year/winter/OS/practical/ex3/kernel/src/drivers/bcm_aux.cpp:12

void CAUX::Enable(hal::AUX_Peripherals aux_peripheral)
{
    8124:	e92d4800 	push	{fp, lr}
    8128:	e28db004 	add	fp, sp, #4
    812c:	e24dd008 	sub	sp, sp, #8
    8130:	e50b0008 	str	r0, [fp, #-8]
    8134:	e50b100c 	str	r1, [fp, #-12]
/home/cf/ZCU/first_year/winter/OS/practical/ex3/kernel/src/drivers/bcm_aux.cpp:13
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
/home/cf/ZCU/first_year/winter/OS/practical/ex3/kernel/src/drivers/bcm_aux.cpp:14
}
    8168:	e320f000 	nop	{0}
    816c:	e24bd004 	sub	sp, fp, #4
    8170:	e8bd8800 	pop	{fp, pc}

00008174 <_ZN4CAUX7DisableEN3hal15AUX_PeripheralsE>:
_ZN4CAUX7DisableEN3hal15AUX_PeripheralsE():
/home/cf/ZCU/first_year/winter/OS/practical/ex3/kernel/src/drivers/bcm_aux.cpp:17

void CAUX::Disable(hal::AUX_Peripherals aux_peripheral)
{
    8174:	e92d4800 	push	{fp, lr}
    8178:	e28db004 	add	fp, sp, #4
    817c:	e24dd008 	sub	sp, sp, #8
    8180:	e50b0008 	str	r0, [fp, #-8]
    8184:	e50b100c 	str	r1, [fp, #-12]
/home/cf/ZCU/first_year/winter/OS/practical/ex3/kernel/src/drivers/bcm_aux.cpp:18
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
/home/cf/ZCU/first_year/winter/OS/practical/ex3/kernel/src/drivers/bcm_aux.cpp:19
}
    81bc:	e320f000 	nop	{0}
    81c0:	e24bd004 	sub	sp, fp, #4
    81c4:	e8bd8800 	pop	{fp, pc}

000081c8 <_ZN4CAUX12Set_RegisterEN3hal7AUX_RegEj>:
_ZN4CAUX12Set_RegisterEN3hal7AUX_RegEj():
/home/cf/ZCU/first_year/winter/OS/practical/ex3/kernel/src/drivers/bcm_aux.cpp:22

void CAUX::Set_Register(hal::AUX_Reg reg_idx, uint32_t value)
{
    81c8:	e52db004 	push	{fp}		; (str fp, [sp, #-4]!)
    81cc:	e28db000 	add	fp, sp, #0
    81d0:	e24dd014 	sub	sp, sp, #20
    81d4:	e50b0008 	str	r0, [fp, #-8]
    81d8:	e50b100c 	str	r1, [fp, #-12]
    81dc:	e50b2010 	str	r2, [fp, #-16]
/home/cf/ZCU/first_year/winter/OS/practical/ex3/kernel/src/drivers/bcm_aux.cpp:23
    mAUX_Reg[static_cast<unsigned int>(reg_idx)] = value;
    81e0:	e51b3008 	ldr	r3, [fp, #-8]
    81e4:	e5932000 	ldr	r2, [r3]
    81e8:	e51b300c 	ldr	r3, [fp, #-12]
    81ec:	e1a03103 	lsl	r3, r3, #2
    81f0:	e0823003 	add	r3, r2, r3
    81f4:	e51b2010 	ldr	r2, [fp, #-16]
    81f8:	e5832000 	str	r2, [r3]
/home/cf/ZCU/first_year/winter/OS/practical/ex3/kernel/src/drivers/bcm_aux.cpp:24
}
    81fc:	e320f000 	nop	{0}
    8200:	e28bd000 	add	sp, fp, #0
    8204:	e49db004 	pop	{fp}		; (ldr fp, [sp], #4)
    8208:	e12fff1e 	bx	lr

0000820c <_ZN4CAUX12Get_RegisterEN3hal7AUX_RegE>:
_ZN4CAUX12Get_RegisterEN3hal7AUX_RegE():
/home/cf/ZCU/first_year/winter/OS/practical/ex3/kernel/src/drivers/bcm_aux.cpp:27

uint32_t CAUX::Get_Register(hal::AUX_Reg reg_idx)
{
    820c:	e52db004 	push	{fp}		; (str fp, [sp, #-4]!)
    8210:	e28db000 	add	fp, sp, #0
    8214:	e24dd00c 	sub	sp, sp, #12
    8218:	e50b0008 	str	r0, [fp, #-8]
    821c:	e50b100c 	str	r1, [fp, #-12]
/home/cf/ZCU/first_year/winter/OS/practical/ex3/kernel/src/drivers/bcm_aux.cpp:28
    return mAUX_Reg[static_cast<unsigned int>(reg_idx)];
    8220:	e51b3008 	ldr	r3, [fp, #-8]
    8224:	e5932000 	ldr	r2, [r3]
    8228:	e51b300c 	ldr	r3, [fp, #-12]
    822c:	e1a03103 	lsl	r3, r3, #2
    8230:	e0823003 	add	r3, r2, r3
    8234:	e5933000 	ldr	r3, [r3]
/home/cf/ZCU/first_year/winter/OS/practical/ex3/kernel/src/drivers/bcm_aux.cpp:29
}
    8238:	e1a00003 	mov	r0, r3
    823c:	e28bd000 	add	sp, fp, #0
    8240:	e49db004 	pop	{fp}		; (ldr fp, [sp], #4)
    8244:	e12fff1e 	bx	lr

00008248 <_Z41__static_initialization_and_destruction_0ii>:
_Z41__static_initialization_and_destruction_0ii():
/home/cf/ZCU/first_year/winter/OS/practical/ex3/kernel/src/drivers/bcm_aux.cpp:29
    8248:	e92d4800 	push	{fp, lr}
    824c:	e28db004 	add	fp, sp, #4
    8250:	e24dd008 	sub	sp, sp, #8
    8254:	e50b0008 	str	r0, [fp, #-8]
    8258:	e50b100c 	str	r1, [fp, #-12]
    825c:	e51b3008 	ldr	r3, [fp, #-8]
    8260:	e3530001 	cmp	r3, #1
    8264:	1a000006 	bne	8284 <_Z41__static_initialization_and_destruction_0ii+0x3c>
/home/cf/ZCU/first_year/winter/OS/practical/ex3/kernel/src/drivers/bcm_aux.cpp:29 (discriminator 1)
    8268:	e51b300c 	ldr	r3, [fp, #-12]
    826c:	e59f201c 	ldr	r2, [pc, #28]	; 8290 <_Z41__static_initialization_and_destruction_0ii+0x48>
    8270:	e1530002 	cmp	r3, r2
    8274:	1a000002 	bne	8284 <_Z41__static_initialization_and_destruction_0ii+0x3c>
/home/cf/ZCU/first_year/winter/OS/practical/ex3/kernel/src/drivers/bcm_aux.cpp:3
CAUX sAUX(hal::AUX_Base);
    8278:	e59f1014 	ldr	r1, [pc, #20]	; 8294 <_Z41__static_initialization_and_destruction_0ii+0x4c>
    827c:	e59f0014 	ldr	r0, [pc, #20]	; 8298 <_Z41__static_initialization_and_destruction_0ii+0x50>
    8280:	ebffff9a 	bl	80f0 <_ZN4CAUXC1Ej>
/home/cf/ZCU/first_year/winter/OS/practical/ex3/kernel/src/drivers/bcm_aux.cpp:29
}
    8284:	e320f000 	nop	{0}
    8288:	e24bd004 	sub	sp, fp, #4
    828c:	e8bd8800 	pop	{fp, pc}
    8290:	0000ffff 	strdeq	pc, [r0], -pc	; <UNPREDICTABLE>
    8294:	20215000 	eorcs	r5, r1, r0
    8298:	000097c8 	andeq	r9, r0, r8, asr #15

0000829c <_GLOBAL__sub_I_sAUX>:
_GLOBAL__sub_I_sAUX():
/home/cf/ZCU/first_year/winter/OS/practical/ex3/kernel/src/drivers/bcm_aux.cpp:29
    829c:	e92d4800 	push	{fp, lr}
    82a0:	e28db004 	add	fp, sp, #4
    82a4:	e59f1008 	ldr	r1, [pc, #8]	; 82b4 <_GLOBAL__sub_I_sAUX+0x18>
    82a8:	e3a00001 	mov	r0, #1
    82ac:	ebffffe5 	bl	8248 <_Z41__static_initialization_and_destruction_0ii>
    82b0:	e8bd8800 	pop	{fp, pc}
    82b4:	0000ffff 	strdeq	pc, [r0], -pc	; <UNPREDICTABLE>

000082b8 <_ZN13CGPIO_HandlerC1Ej>:
_ZN13CGPIO_HandlerC2Ej():
/home/cf/ZCU/first_year/winter/OS/practical/ex3/kernel/src/drivers/gpio.cpp:6
#include <hal/peripherals.h>
#include <drivers/gpio.h>

CGPIO_Handler sGPIO(hal::GPIO_Base);

CGPIO_Handler::CGPIO_Handler(unsigned int gpio_base_addr)
    82b8:	e52db004 	push	{fp}		; (str fp, [sp, #-4]!)
    82bc:	e28db000 	add	fp, sp, #0
    82c0:	e24dd00c 	sub	sp, sp, #12
    82c4:	e50b0008 	str	r0, [fp, #-8]
    82c8:	e50b100c 	str	r1, [fp, #-12]
/home/cf/ZCU/first_year/winter/OS/practical/ex3/kernel/src/drivers/gpio.cpp:7
	: mGPIO(reinterpret_cast<unsigned int*>(gpio_base_addr))
    82cc:	e51b200c 	ldr	r2, [fp, #-12]
    82d0:	e51b3008 	ldr	r3, [fp, #-8]
    82d4:	e5832000 	str	r2, [r3]
/home/cf/ZCU/first_year/winter/OS/practical/ex3/kernel/src/drivers/gpio.cpp:10
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
/home/cf/ZCU/first_year/winter/OS/practical/ex3/kernel/src/drivers/gpio.cpp:13

bool CGPIO_Handler::Get_GPFSEL_Location(uint32_t pin, uint32_t& reg, uint32_t& bit_idx) const
{
    82ec:	e52db004 	push	{fp}		; (str fp, [sp, #-4]!)
    82f0:	e28db000 	add	fp, sp, #0
    82f4:	e24dd014 	sub	sp, sp, #20
    82f8:	e50b0008 	str	r0, [fp, #-8]
    82fc:	e50b100c 	str	r1, [fp, #-12]
    8300:	e50b2010 	str	r2, [fp, #-16]
    8304:	e50b3014 	str	r3, [fp, #-20]	; 0xffffffec
/home/cf/ZCU/first_year/winter/OS/practical/ex3/kernel/src/drivers/gpio.cpp:14
	if (pin > hal::GPIO_Pin_Count)
    8308:	e51b300c 	ldr	r3, [fp, #-12]
    830c:	e3530036 	cmp	r3, #54	; 0x36
    8310:	9a000001 	bls	831c <_ZNK13CGPIO_Handler19Get_GPFSEL_LocationEjRjS0_+0x30>
/home/cf/ZCU/first_year/winter/OS/practical/ex3/kernel/src/drivers/gpio.cpp:15
		return false;
    8314:	e3a03000 	mov	r3, #0
    8318:	ea000033 	b	83ec <_ZNK13CGPIO_Handler19Get_GPFSEL_LocationEjRjS0_+0x100>
/home/cf/ZCU/first_year/winter/OS/practical/ex3/kernel/src/drivers/gpio.cpp:17
	
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
/home/cf/ZCU/first_year/winter/OS/practical/ex3/kernel/src/drivers/gpio.cpp:19
	{
		case 0: reg = static_cast<uint32_t>(hal::GPIO_Reg::GPFSEL0); break;
    8350:	e51b3010 	ldr	r3, [fp, #-16]
    8354:	e3a02000 	mov	r2, #0
    8358:	e5832000 	str	r2, [r3]
    835c:	ea000013 	b	83b0 <_ZNK13CGPIO_Handler19Get_GPFSEL_LocationEjRjS0_+0xc4>
/home/cf/ZCU/first_year/winter/OS/practical/ex3/kernel/src/drivers/gpio.cpp:20
		case 1: reg = static_cast<uint32_t>(hal::GPIO_Reg::GPFSEL1); break;
    8360:	e51b3010 	ldr	r3, [fp, #-16]
    8364:	e3a02001 	mov	r2, #1
    8368:	e5832000 	str	r2, [r3]
    836c:	ea00000f 	b	83b0 <_ZNK13CGPIO_Handler19Get_GPFSEL_LocationEjRjS0_+0xc4>
/home/cf/ZCU/first_year/winter/OS/practical/ex3/kernel/src/drivers/gpio.cpp:21
		case 2: reg = static_cast<uint32_t>(hal::GPIO_Reg::GPFSEL2); break;
    8370:	e51b3010 	ldr	r3, [fp, #-16]
    8374:	e3a02002 	mov	r2, #2
    8378:	e5832000 	str	r2, [r3]
    837c:	ea00000b 	b	83b0 <_ZNK13CGPIO_Handler19Get_GPFSEL_LocationEjRjS0_+0xc4>
/home/cf/ZCU/first_year/winter/OS/practical/ex3/kernel/src/drivers/gpio.cpp:22
		case 3: reg = static_cast<uint32_t>(hal::GPIO_Reg::GPFSEL3); break;
    8380:	e51b3010 	ldr	r3, [fp, #-16]
    8384:	e3a02003 	mov	r2, #3
    8388:	e5832000 	str	r2, [r3]
    838c:	ea000007 	b	83b0 <_ZNK13CGPIO_Handler19Get_GPFSEL_LocationEjRjS0_+0xc4>
/home/cf/ZCU/first_year/winter/OS/practical/ex3/kernel/src/drivers/gpio.cpp:23
		case 4: reg = static_cast<uint32_t>(hal::GPIO_Reg::GPFSEL4); break;
    8390:	e51b3010 	ldr	r3, [fp, #-16]
    8394:	e3a02004 	mov	r2, #4
    8398:	e5832000 	str	r2, [r3]
    839c:	ea000003 	b	83b0 <_ZNK13CGPIO_Handler19Get_GPFSEL_LocationEjRjS0_+0xc4>
/home/cf/ZCU/first_year/winter/OS/practical/ex3/kernel/src/drivers/gpio.cpp:24
		case 5: reg = static_cast<uint32_t>(hal::GPIO_Reg::GPFSEL5); break;
    83a0:	e51b3010 	ldr	r3, [fp, #-16]
    83a4:	e3a02005 	mov	r2, #5
    83a8:	e5832000 	str	r2, [r3]
    83ac:	e320f000 	nop	{0}
/home/cf/ZCU/first_year/winter/OS/practical/ex3/kernel/src/drivers/gpio.cpp:27
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
/home/cf/ZCU/first_year/winter/OS/practical/ex3/kernel/src/drivers/gpio.cpp:29
	
	return true;
    83e8:	e3a03001 	mov	r3, #1
/home/cf/ZCU/first_year/winter/OS/practical/ex3/kernel/src/drivers/gpio.cpp:30
}
    83ec:	e1a00003 	mov	r0, r3
    83f0:	e28bd000 	add	sp, fp, #0
    83f4:	e49db004 	pop	{fp}		; (ldr fp, [sp], #4)
    83f8:	e12fff1e 	bx	lr
    83fc:	cccccccd 	stclgt	12, cr12, [ip], {205}	; 0xcd

00008400 <_ZNK13CGPIO_Handler18Get_GPCLR_LocationEjRjS0_>:
_ZNK13CGPIO_Handler18Get_GPCLR_LocationEjRjS0_():
/home/cf/ZCU/first_year/winter/OS/practical/ex3/kernel/src/drivers/gpio.cpp:33

bool CGPIO_Handler::Get_GPCLR_Location(uint32_t pin, uint32_t& reg, uint32_t& bit_idx) const
{
    8400:	e52db004 	push	{fp}		; (str fp, [sp, #-4]!)
    8404:	e28db000 	add	fp, sp, #0
    8408:	e24dd014 	sub	sp, sp, #20
    840c:	e50b0008 	str	r0, [fp, #-8]
    8410:	e50b100c 	str	r1, [fp, #-12]
    8414:	e50b2010 	str	r2, [fp, #-16]
    8418:	e50b3014 	str	r3, [fp, #-20]	; 0xffffffec
/home/cf/ZCU/first_year/winter/OS/practical/ex3/kernel/src/drivers/gpio.cpp:34
	if (pin > hal::GPIO_Pin_Count)
    841c:	e51b300c 	ldr	r3, [fp, #-12]
    8420:	e3530036 	cmp	r3, #54	; 0x36
    8424:	9a000001 	bls	8430 <_ZNK13CGPIO_Handler18Get_GPCLR_LocationEjRjS0_+0x30>
/home/cf/ZCU/first_year/winter/OS/practical/ex3/kernel/src/drivers/gpio.cpp:35
		return false;
    8428:	e3a03000 	mov	r3, #0
    842c:	ea00000c 	b	8464 <_ZNK13CGPIO_Handler18Get_GPCLR_LocationEjRjS0_+0x64>
/home/cf/ZCU/first_year/winter/OS/practical/ex3/kernel/src/drivers/gpio.cpp:37
	
	reg = static_cast<uint32_t>((pin < 32) ? hal::GPIO_Reg::GPCLR0 : hal::GPIO_Reg::GPCLR1);
    8430:	e51b300c 	ldr	r3, [fp, #-12]
    8434:	e353001f 	cmp	r3, #31
    8438:	8a000001 	bhi	8444 <_ZNK13CGPIO_Handler18Get_GPCLR_LocationEjRjS0_+0x44>
/home/cf/ZCU/first_year/winter/OS/practical/ex3/kernel/src/drivers/gpio.cpp:37 (discriminator 1)
    843c:	e3a0200a 	mov	r2, #10
    8440:	ea000000 	b	8448 <_ZNK13CGPIO_Handler18Get_GPCLR_LocationEjRjS0_+0x48>
/home/cf/ZCU/first_year/winter/OS/practical/ex3/kernel/src/drivers/gpio.cpp:37 (discriminator 2)
    8444:	e3a0200b 	mov	r2, #11
/home/cf/ZCU/first_year/winter/OS/practical/ex3/kernel/src/drivers/gpio.cpp:37 (discriminator 4)
    8448:	e51b3010 	ldr	r3, [fp, #-16]
    844c:	e5832000 	str	r2, [r3]
/home/cf/ZCU/first_year/winter/OS/practical/ex3/kernel/src/drivers/gpio.cpp:38 (discriminator 4)
	bit_idx = pin % 32;
    8450:	e51b300c 	ldr	r3, [fp, #-12]
    8454:	e203201f 	and	r2, r3, #31
    8458:	e51b3014 	ldr	r3, [fp, #-20]	; 0xffffffec
    845c:	e5832000 	str	r2, [r3]
/home/cf/ZCU/first_year/winter/OS/practical/ex3/kernel/src/drivers/gpio.cpp:40 (discriminator 4)
	
	return true;
    8460:	e3a03001 	mov	r3, #1
/home/cf/ZCU/first_year/winter/OS/practical/ex3/kernel/src/drivers/gpio.cpp:41
}
    8464:	e1a00003 	mov	r0, r3
    8468:	e28bd000 	add	sp, fp, #0
    846c:	e49db004 	pop	{fp}		; (ldr fp, [sp], #4)
    8470:	e12fff1e 	bx	lr

00008474 <_ZNK13CGPIO_Handler18Get_GPSET_LocationEjRjS0_>:
_ZNK13CGPIO_Handler18Get_GPSET_LocationEjRjS0_():
/home/cf/ZCU/first_year/winter/OS/practical/ex3/kernel/src/drivers/gpio.cpp:44

bool CGPIO_Handler::Get_GPSET_Location(uint32_t pin, uint32_t& reg, uint32_t& bit_idx) const
{
    8474:	e52db004 	push	{fp}		; (str fp, [sp, #-4]!)
    8478:	e28db000 	add	fp, sp, #0
    847c:	e24dd014 	sub	sp, sp, #20
    8480:	e50b0008 	str	r0, [fp, #-8]
    8484:	e50b100c 	str	r1, [fp, #-12]
    8488:	e50b2010 	str	r2, [fp, #-16]
    848c:	e50b3014 	str	r3, [fp, #-20]	; 0xffffffec
/home/cf/ZCU/first_year/winter/OS/practical/ex3/kernel/src/drivers/gpio.cpp:45
	if (pin > hal::GPIO_Pin_Count)
    8490:	e51b300c 	ldr	r3, [fp, #-12]
    8494:	e3530036 	cmp	r3, #54	; 0x36
    8498:	9a000001 	bls	84a4 <_ZNK13CGPIO_Handler18Get_GPSET_LocationEjRjS0_+0x30>
/home/cf/ZCU/first_year/winter/OS/practical/ex3/kernel/src/drivers/gpio.cpp:46
		return false;
    849c:	e3a03000 	mov	r3, #0
    84a0:	ea00000c 	b	84d8 <_ZNK13CGPIO_Handler18Get_GPSET_LocationEjRjS0_+0x64>
/home/cf/ZCU/first_year/winter/OS/practical/ex3/kernel/src/drivers/gpio.cpp:48
	
	reg = static_cast<uint32_t>((pin < 32) ? hal::GPIO_Reg::GPSET0 : hal::GPIO_Reg::GPSET1);
    84a4:	e51b300c 	ldr	r3, [fp, #-12]
    84a8:	e353001f 	cmp	r3, #31
    84ac:	8a000001 	bhi	84b8 <_ZNK13CGPIO_Handler18Get_GPSET_LocationEjRjS0_+0x44>
/home/cf/ZCU/first_year/winter/OS/practical/ex3/kernel/src/drivers/gpio.cpp:48 (discriminator 1)
    84b0:	e3a02007 	mov	r2, #7
    84b4:	ea000000 	b	84bc <_ZNK13CGPIO_Handler18Get_GPSET_LocationEjRjS0_+0x48>
/home/cf/ZCU/first_year/winter/OS/practical/ex3/kernel/src/drivers/gpio.cpp:48 (discriminator 2)
    84b8:	e3a02008 	mov	r2, #8
/home/cf/ZCU/first_year/winter/OS/practical/ex3/kernel/src/drivers/gpio.cpp:48 (discriminator 4)
    84bc:	e51b3010 	ldr	r3, [fp, #-16]
    84c0:	e5832000 	str	r2, [r3]
/home/cf/ZCU/first_year/winter/OS/practical/ex3/kernel/src/drivers/gpio.cpp:49 (discriminator 4)
	bit_idx = pin % 32;
    84c4:	e51b300c 	ldr	r3, [fp, #-12]
    84c8:	e203201f 	and	r2, r3, #31
    84cc:	e51b3014 	ldr	r3, [fp, #-20]	; 0xffffffec
    84d0:	e5832000 	str	r2, [r3]
/home/cf/ZCU/first_year/winter/OS/practical/ex3/kernel/src/drivers/gpio.cpp:51 (discriminator 4)
	
	return true;
    84d4:	e3a03001 	mov	r3, #1
/home/cf/ZCU/first_year/winter/OS/practical/ex3/kernel/src/drivers/gpio.cpp:52
}
    84d8:	e1a00003 	mov	r0, r3
    84dc:	e28bd000 	add	sp, fp, #0
    84e0:	e49db004 	pop	{fp}		; (ldr fp, [sp], #4)
    84e4:	e12fff1e 	bx	lr

000084e8 <_ZNK13CGPIO_Handler18Get_GPLEV_LocationEjRjS0_>:
_ZNK13CGPIO_Handler18Get_GPLEV_LocationEjRjS0_():
/home/cf/ZCU/first_year/winter/OS/practical/ex3/kernel/src/drivers/gpio.cpp:55

bool CGPIO_Handler::Get_GPLEV_Location(uint32_t pin, uint32_t& reg, uint32_t& bit_idx) const
{
    84e8:	e52db004 	push	{fp}		; (str fp, [sp, #-4]!)
    84ec:	e28db000 	add	fp, sp, #0
    84f0:	e24dd014 	sub	sp, sp, #20
    84f4:	e50b0008 	str	r0, [fp, #-8]
    84f8:	e50b100c 	str	r1, [fp, #-12]
    84fc:	e50b2010 	str	r2, [fp, #-16]
    8500:	e50b3014 	str	r3, [fp, #-20]	; 0xffffffec
/home/cf/ZCU/first_year/winter/OS/practical/ex3/kernel/src/drivers/gpio.cpp:56
	if (pin > hal::GPIO_Pin_Count)
    8504:	e51b300c 	ldr	r3, [fp, #-12]
    8508:	e3530036 	cmp	r3, #54	; 0x36
    850c:	9a000001 	bls	8518 <_ZNK13CGPIO_Handler18Get_GPLEV_LocationEjRjS0_+0x30>
/home/cf/ZCU/first_year/winter/OS/practical/ex3/kernel/src/drivers/gpio.cpp:57
		return false;
    8510:	e3a03000 	mov	r3, #0
    8514:	ea00000c 	b	854c <_ZNK13CGPIO_Handler18Get_GPLEV_LocationEjRjS0_+0x64>
/home/cf/ZCU/first_year/winter/OS/practical/ex3/kernel/src/drivers/gpio.cpp:59
	
	reg = static_cast<uint32_t>((pin < 32) ? hal::GPIO_Reg::GPLEV0 : hal::GPIO_Reg::GPLEV1);
    8518:	e51b300c 	ldr	r3, [fp, #-12]
    851c:	e353001f 	cmp	r3, #31
    8520:	8a000001 	bhi	852c <_ZNK13CGPIO_Handler18Get_GPLEV_LocationEjRjS0_+0x44>
/home/cf/ZCU/first_year/winter/OS/practical/ex3/kernel/src/drivers/gpio.cpp:59 (discriminator 1)
    8524:	e3a0200d 	mov	r2, #13
    8528:	ea000000 	b	8530 <_ZNK13CGPIO_Handler18Get_GPLEV_LocationEjRjS0_+0x48>
/home/cf/ZCU/first_year/winter/OS/practical/ex3/kernel/src/drivers/gpio.cpp:59 (discriminator 2)
    852c:	e3a0200e 	mov	r2, #14
/home/cf/ZCU/first_year/winter/OS/practical/ex3/kernel/src/drivers/gpio.cpp:59 (discriminator 4)
    8530:	e51b3010 	ldr	r3, [fp, #-16]
    8534:	e5832000 	str	r2, [r3]
/home/cf/ZCU/first_year/winter/OS/practical/ex3/kernel/src/drivers/gpio.cpp:60 (discriminator 4)
	bit_idx = pin % 32;
    8538:	e51b300c 	ldr	r3, [fp, #-12]
    853c:	e203201f 	and	r2, r3, #31
    8540:	e51b3014 	ldr	r3, [fp, #-20]	; 0xffffffec
    8544:	e5832000 	str	r2, [r3]
/home/cf/ZCU/first_year/winter/OS/practical/ex3/kernel/src/drivers/gpio.cpp:62 (discriminator 4)
	
	return true;
    8548:	e3a03001 	mov	r3, #1
/home/cf/ZCU/first_year/winter/OS/practical/ex3/kernel/src/drivers/gpio.cpp:63
}
    854c:	e1a00003 	mov	r0, r3
    8550:	e28bd000 	add	sp, fp, #0
    8554:	e49db004 	pop	{fp}		; (ldr fp, [sp], #4)
    8558:	e12fff1e 	bx	lr

0000855c <_ZN13CGPIO_Handler17Set_GPIO_FunctionEj14NGPIO_Function>:
_ZN13CGPIO_Handler17Set_GPIO_FunctionEj14NGPIO_Function():
/home/cf/ZCU/first_year/winter/OS/practical/ex3/kernel/src/drivers/gpio.cpp:66
		
void CGPIO_Handler::Set_GPIO_Function(uint32_t pin, NGPIO_Function func)
{
    855c:	e92d4800 	push	{fp, lr}
    8560:	e28db004 	add	fp, sp, #4
    8564:	e24dd018 	sub	sp, sp, #24
    8568:	e50b0010 	str	r0, [fp, #-16]
    856c:	e50b1014 	str	r1, [fp, #-20]	; 0xffffffec
    8570:	e1a03002 	mov	r3, r2
    8574:	e54b3015 	strb	r3, [fp, #-21]	; 0xffffffeb
/home/cf/ZCU/first_year/winter/OS/practical/ex3/kernel/src/drivers/gpio.cpp:68
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
/home/cf/ZCU/first_year/winter/OS/practical/ex3/kernel/src/drivers/gpio.cpp:71
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
/home/cf/ZCU/first_year/winter/OS/practical/ex3/kernel/src/drivers/gpio.cpp:72
				| (static_cast<unsigned int>(func) << bit);
    85c4:	e55b2015 	ldrb	r2, [fp, #-21]	; 0xffffffeb
    85c8:	e51b300c 	ldr	r3, [fp, #-12]
    85cc:	e1a02312 	lsl	r2, r2, r3
/home/cf/ZCU/first_year/winter/OS/practical/ex3/kernel/src/drivers/gpio.cpp:71
	mGPIO[reg] = (mGPIO[reg] & (~static_cast<unsigned int>(7 << bit)) )
    85d0:	e51b3010 	ldr	r3, [fp, #-16]
    85d4:	e5930000 	ldr	r0, [r3]
    85d8:	e51b3008 	ldr	r3, [fp, #-8]
    85dc:	e1a03103 	lsl	r3, r3, #2
    85e0:	e0803003 	add	r3, r0, r3
/home/cf/ZCU/first_year/winter/OS/practical/ex3/kernel/src/drivers/gpio.cpp:72
				| (static_cast<unsigned int>(func) << bit);
    85e4:	e1812002 	orr	r2, r1, r2
/home/cf/ZCU/first_year/winter/OS/practical/ex3/kernel/src/drivers/gpio.cpp:71
	mGPIO[reg] = (mGPIO[reg] & (~static_cast<unsigned int>(7 << bit)) )
    85e8:	e5832000 	str	r2, [r3]
    85ec:	ea000000 	b	85f4 <_ZN13CGPIO_Handler17Set_GPIO_FunctionEj14NGPIO_Function+0x98>
/home/cf/ZCU/first_year/winter/OS/practical/ex3/kernel/src/drivers/gpio.cpp:69
		return;
    85f0:	e320f000 	nop	{0}
/home/cf/ZCU/first_year/winter/OS/practical/ex3/kernel/src/drivers/gpio.cpp:73
}
    85f4:	e24bd004 	sub	sp, fp, #4
    85f8:	e8bd8800 	pop	{fp, pc}

000085fc <_ZNK13CGPIO_Handler17Get_GPIO_FunctionEj>:
_ZNK13CGPIO_Handler17Get_GPIO_FunctionEj():
/home/cf/ZCU/first_year/winter/OS/practical/ex3/kernel/src/drivers/gpio.cpp:76

NGPIO_Function CGPIO_Handler::Get_GPIO_Function(uint32_t pin) const
{
    85fc:	e92d4800 	push	{fp, lr}
    8600:	e28db004 	add	fp, sp, #4
    8604:	e24dd010 	sub	sp, sp, #16
    8608:	e50b0010 	str	r0, [fp, #-16]
    860c:	e50b1014 	str	r1, [fp, #-20]	; 0xffffffec
/home/cf/ZCU/first_year/winter/OS/practical/ex3/kernel/src/drivers/gpio.cpp:78
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
/home/cf/ZCU/first_year/winter/OS/practical/ex3/kernel/src/drivers/gpio.cpp:79
		return NGPIO_Function::Unspecified;
    8630:	e3a03008 	mov	r3, #8
    8634:	ea00000a 	b	8664 <_ZNK13CGPIO_Handler17Get_GPIO_FunctionEj+0x68>
/home/cf/ZCU/first_year/winter/OS/practical/ex3/kernel/src/drivers/gpio.cpp:81
	
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
/home/cf/ZCU/first_year/winter/OS/practical/ex3/kernel/src/drivers/gpio.cpp:82 (discriminator 1)
}
    8664:	e1a00003 	mov	r0, r3
    8668:	e24bd004 	sub	sp, fp, #4
    866c:	e8bd8800 	pop	{fp, pc}

00008670 <_ZN13CGPIO_Handler10Set_OutputEjb>:
_ZN13CGPIO_Handler10Set_OutputEjb():
/home/cf/ZCU/first_year/winter/OS/practical/ex3/kernel/src/drivers/gpio.cpp:85

void CGPIO_Handler::Set_Output(uint32_t pin, bool set)
{
    8670:	e92d4800 	push	{fp, lr}
    8674:	e28db004 	add	fp, sp, #4
    8678:	e24dd018 	sub	sp, sp, #24
    867c:	e50b0010 	str	r0, [fp, #-16]
    8680:	e50b1014 	str	r1, [fp, #-20]	; 0xffffffec
    8684:	e1a03002 	mov	r3, r2
    8688:	e54b3015 	strb	r3, [fp, #-21]	; 0xffffffeb
/home/cf/ZCU/first_year/winter/OS/practical/ex3/kernel/src/drivers/gpio.cpp:87
	uint32_t reg, bit;
	if (!(set && Get_GPSET_Location(pin, reg, bit)) && !(!set && Get_GPCLR_Location(pin, reg, bit)))
    868c:	e55b3015 	ldrb	r3, [fp, #-21]	; 0xffffffeb
    8690:	e2233001 	eor	r3, r3, #1
    8694:	e6ef3073 	uxtb	r3, r3
    8698:	e3530000 	cmp	r3, #0
    869c:	1a000009 	bne	86c8 <_ZN13CGPIO_Handler10Set_OutputEjb+0x58>
/home/cf/ZCU/first_year/winter/OS/practical/ex3/kernel/src/drivers/gpio.cpp:87 (discriminator 2)
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
/home/cf/ZCU/first_year/winter/OS/practical/ex3/kernel/src/drivers/gpio.cpp:87 (discriminator 3)
    86c8:	e55b3015 	ldrb	r3, [fp, #-21]	; 0xffffffeb
    86cc:	e3530000 	cmp	r3, #0
    86d0:	1a000009 	bne	86fc <_ZN13CGPIO_Handler10Set_OutputEjb+0x8c>
/home/cf/ZCU/first_year/winter/OS/practical/ex3/kernel/src/drivers/gpio.cpp:87 (discriminator 6)
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
/home/cf/ZCU/first_year/winter/OS/practical/ex3/kernel/src/drivers/gpio.cpp:87 (discriminator 7)
    86fc:	e3a03001 	mov	r3, #1
    8700:	ea000000 	b	8708 <_ZN13CGPIO_Handler10Set_OutputEjb+0x98>
/home/cf/ZCU/first_year/winter/OS/practical/ex3/kernel/src/drivers/gpio.cpp:87 (discriminator 8)
    8704:	e3a03000 	mov	r3, #0
/home/cf/ZCU/first_year/winter/OS/practical/ex3/kernel/src/drivers/gpio.cpp:87 (discriminator 10)
    8708:	e3530000 	cmp	r3, #0
    870c:	1a00000a 	bne	873c <_ZN13CGPIO_Handler10Set_OutputEjb+0xcc>
/home/cf/ZCU/first_year/winter/OS/practical/ex3/kernel/src/drivers/gpio.cpp:90
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
/home/cf/ZCU/first_year/winter/OS/practical/ex3/kernel/src/drivers/gpio.cpp:88
		return;
    873c:	e320f000 	nop	{0}
/home/cf/ZCU/first_year/winter/OS/practical/ex3/kernel/src/drivers/gpio.cpp:91
}
    8740:	e24bd004 	sub	sp, fp, #4
    8744:	e8bd8800 	pop	{fp, pc}

00008748 <_Z41__static_initialization_and_destruction_0ii>:
_Z41__static_initialization_and_destruction_0ii():
/home/cf/ZCU/first_year/winter/OS/practical/ex3/kernel/src/drivers/gpio.cpp:91
    8748:	e92d4800 	push	{fp, lr}
    874c:	e28db004 	add	fp, sp, #4
    8750:	e24dd008 	sub	sp, sp, #8
    8754:	e50b0008 	str	r0, [fp, #-8]
    8758:	e50b100c 	str	r1, [fp, #-12]
    875c:	e51b3008 	ldr	r3, [fp, #-8]
    8760:	e3530001 	cmp	r3, #1
    8764:	1a000006 	bne	8784 <_Z41__static_initialization_and_destruction_0ii+0x3c>
/home/cf/ZCU/first_year/winter/OS/practical/ex3/kernel/src/drivers/gpio.cpp:91 (discriminator 1)
    8768:	e51b300c 	ldr	r3, [fp, #-12]
    876c:	e59f201c 	ldr	r2, [pc, #28]	; 8790 <_Z41__static_initialization_and_destruction_0ii+0x48>
    8770:	e1530002 	cmp	r3, r2
    8774:	1a000002 	bne	8784 <_Z41__static_initialization_and_destruction_0ii+0x3c>
/home/cf/ZCU/first_year/winter/OS/practical/ex3/kernel/src/drivers/gpio.cpp:4
CGPIO_Handler sGPIO(hal::GPIO_Base);
    8778:	e59f1014 	ldr	r1, [pc, #20]	; 8794 <_Z41__static_initialization_and_destruction_0ii+0x4c>
    877c:	e59f0014 	ldr	r0, [pc, #20]	; 8798 <_Z41__static_initialization_and_destruction_0ii+0x50>
    8780:	ebfffecc 	bl	82b8 <_ZN13CGPIO_HandlerC1Ej>
/home/cf/ZCU/first_year/winter/OS/practical/ex3/kernel/src/drivers/gpio.cpp:91
}
    8784:	e320f000 	nop	{0}
    8788:	e24bd004 	sub	sp, fp, #4
    878c:	e8bd8800 	pop	{fp, pc}
    8790:	0000ffff 	strdeq	pc, [r0], -pc	; <UNPREDICTABLE>
    8794:	20200000 	eorcs	r0, r0, r0
    8798:	000097cc 	andeq	r9, r0, ip, asr #15

0000879c <_GLOBAL__sub_I_sGPIO>:
_GLOBAL__sub_I_sGPIO():
/home/cf/ZCU/first_year/winter/OS/practical/ex3/kernel/src/drivers/gpio.cpp:91
    879c:	e92d4800 	push	{fp, lr}
    87a0:	e28db004 	add	fp, sp, #4
    87a4:	e59f1008 	ldr	r1, [pc, #8]	; 87b4 <_GLOBAL__sub_I_sGPIO+0x18>
    87a8:	e3a00001 	mov	r0, #1
    87ac:	ebffffe5 	bl	8748 <_Z41__static_initialization_and_destruction_0ii>
    87b0:	e8bd8800 	pop	{fp, pc}
    87b4:	0000ffff 	strdeq	pc, [r0], -pc	; <UNPREDICTABLE>

000087b8 <_ZN5CUARTC1ER4CAUX>:
_ZN5CUARTC2ER4CAUX():
/home/cf/ZCU/first_year/winter/OS/practical/ex3/kernel/src/drivers/uart.cpp:7
#include <drivers/uart.h>
#include <drivers/bcm_aux.h>

CUART sUART0(sAUX);

CUART::CUART(CAUX& aux)
    87b8:	e92d4800 	push	{fp, lr}
    87bc:	e28db004 	add	fp, sp, #4
    87c0:	e24dd008 	sub	sp, sp, #8
    87c4:	e50b0008 	str	r0, [fp, #-8]
    87c8:	e50b100c 	str	r1, [fp, #-12]
/home/cf/ZCU/first_year/winter/OS/practical/ex3/kernel/src/drivers/uart.cpp:8
    : mAUX(aux)
    87cc:	e51b3008 	ldr	r3, [fp, #-8]
    87d0:	e51b200c 	ldr	r2, [fp, #-12]
    87d4:	e5832000 	str	r2, [r3]
/home/cf/ZCU/first_year/winter/OS/practical/ex3/kernel/src/drivers/uart.cpp:10
{
    mAUX.Enable(hal::AUX_Peripherals::MiniUART);
    87d8:	e51b3008 	ldr	r3, [fp, #-8]
    87dc:	e5933000 	ldr	r3, [r3]
    87e0:	e3a01000 	mov	r1, #0
    87e4:	e1a00003 	mov	r0, r3
    87e8:	ebfffe4d 	bl	8124 <_ZN4CAUX6EnableEN3hal15AUX_PeripheralsE>
/home/cf/ZCU/first_year/winter/OS/practical/ex3/kernel/src/drivers/uart.cpp:12
    //mAUX.Set_Register(hal::AUX_Reg::ENABLES, mAUX.Get_Register(hal::AUX_Reg::ENABLES) | 0x01);
    mAUX.Set_Register(hal::AUX_Reg::MU_IIR, 0);
    87ec:	e51b3008 	ldr	r3, [fp, #-8]
    87f0:	e5933000 	ldr	r3, [r3]
    87f4:	e3a02000 	mov	r2, #0
    87f8:	e3a01012 	mov	r1, #18
    87fc:	e1a00003 	mov	r0, r3
    8800:	ebfffe70 	bl	81c8 <_ZN4CAUX12Set_RegisterEN3hal7AUX_RegEj>
/home/cf/ZCU/first_year/winter/OS/practical/ex3/kernel/src/drivers/uart.cpp:13
    mAUX.Set_Register(hal::AUX_Reg::MU_IER, 0);
    8804:	e51b3008 	ldr	r3, [fp, #-8]
    8808:	e5933000 	ldr	r3, [r3]
    880c:	e3a02000 	mov	r2, #0
    8810:	e3a01011 	mov	r1, #17
    8814:	e1a00003 	mov	r0, r3
    8818:	ebfffe6a 	bl	81c8 <_ZN4CAUX12Set_RegisterEN3hal7AUX_RegEj>
/home/cf/ZCU/first_year/winter/OS/practical/ex3/kernel/src/drivers/uart.cpp:14
    mAUX.Set_Register(hal::AUX_Reg::MU_MCR, 0);
    881c:	e51b3008 	ldr	r3, [fp, #-8]
    8820:	e5933000 	ldr	r3, [r3]
    8824:	e3a02000 	mov	r2, #0
    8828:	e3a01014 	mov	r1, #20
    882c:	e1a00003 	mov	r0, r3
    8830:	ebfffe64 	bl	81c8 <_ZN4CAUX12Set_RegisterEN3hal7AUX_RegEj>
/home/cf/ZCU/first_year/winter/OS/practical/ex3/kernel/src/drivers/uart.cpp:15
    mAUX.Set_Register(hal::AUX_Reg::MU_CNTL, 3); // RX and TX enabled
    8834:	e51b3008 	ldr	r3, [fp, #-8]
    8838:	e5933000 	ldr	r3, [r3]
    883c:	e3a02003 	mov	r2, #3
    8840:	e3a01018 	mov	r1, #24
    8844:	e1a00003 	mov	r0, r3
    8848:	ebfffe5e 	bl	81c8 <_ZN4CAUX12Set_RegisterEN3hal7AUX_RegEj>
/home/cf/ZCU/first_year/winter/OS/practical/ex3/kernel/src/drivers/uart.cpp:16
}
    884c:	e51b3008 	ldr	r3, [fp, #-8]
    8850:	e1a00003 	mov	r0, r3
    8854:	e24bd004 	sub	sp, fp, #4
    8858:	e8bd8800 	pop	{fp, pc}

0000885c <_ZN5CUART15Set_Char_LengthE17NUART_Char_Length>:
_ZN5CUART15Set_Char_LengthE17NUART_Char_Length():
/home/cf/ZCU/first_year/winter/OS/practical/ex3/kernel/src/drivers/uart.cpp:19

void CUART::Set_Char_Length(NUART_Char_Length len)
{
    885c:	e92d4810 	push	{r4, fp, lr}
    8860:	e28db008 	add	fp, sp, #8
    8864:	e24dd00c 	sub	sp, sp, #12
    8868:	e50b0010 	str	r0, [fp, #-16]
    886c:	e50b1014 	str	r1, [fp, #-20]	; 0xffffffec
/home/cf/ZCU/first_year/winter/OS/practical/ex3/kernel/src/drivers/uart.cpp:20
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
/home/cf/ZCU/first_year/winter/OS/practical/ex3/kernel/src/drivers/uart.cpp:21
}
    88ac:	e320f000 	nop	{0}
    88b0:	e24bd008 	sub	sp, fp, #8
    88b4:	e8bd8810 	pop	{r4, fp, pc}

000088b8 <_ZN5CUART13Set_Baud_RateE15NUART_Baud_Rate>:
_ZN5CUART13Set_Baud_RateE15NUART_Baud_Rate():
/home/cf/ZCU/first_year/winter/OS/practical/ex3/kernel/src/drivers/uart.cpp:24

void CUART::Set_Baud_Rate(NUART_Baud_Rate rate)
{
    88b8:	e92d4800 	push	{fp, lr}
    88bc:	e28db004 	add	fp, sp, #4
    88c0:	e24dd010 	sub	sp, sp, #16
    88c4:	e50b0010 	str	r0, [fp, #-16]
    88c8:	e50b1014 	str	r1, [fp, #-20]	; 0xffffffec
/home/cf/ZCU/first_year/winter/OS/practical/ex3/kernel/src/drivers/uart.cpp:25
    constexpr unsigned int Clock_Rate = 250000000; // taktovaci frekvence hlavniho jadra
    88cc:	e59f3070 	ldr	r3, [pc, #112]	; 8944 <_ZN5CUART13Set_Baud_RateE15NUART_Baud_Rate+0x8c>
    88d0:	e50b3008 	str	r3, [fp, #-8]
/home/cf/ZCU/first_year/winter/OS/practical/ex3/kernel/src/drivers/uart.cpp:26
    const unsigned int val = ((Clock_Rate / static_cast<unsigned int>(rate)) / 8) - 1;
    88d4:	e51b3014 	ldr	r3, [fp, #-20]	; 0xffffffec
    88d8:	e1a01003 	mov	r1, r3
    88dc:	e59f0064 	ldr	r0, [pc, #100]	; 8948 <_ZN5CUART13Set_Baud_RateE15NUART_Baud_Rate+0x90>
    88e0:	eb0001fa 	bl	90d0 <__udivsi3>
    88e4:	e1a03000 	mov	r3, r0
    88e8:	e2433001 	sub	r3, r3, #1
    88ec:	e50b300c 	str	r3, [fp, #-12]
/home/cf/ZCU/first_year/winter/OS/practical/ex3/kernel/src/drivers/uart.cpp:28

    mAUX.Set_Register(hal::AUX_Reg::MU_CNTL, 0);
    88f0:	e51b3010 	ldr	r3, [fp, #-16]
    88f4:	e5933000 	ldr	r3, [r3]
    88f8:	e3a02000 	mov	r2, #0
    88fc:	e3a01018 	mov	r1, #24
    8900:	e1a00003 	mov	r0, r3
    8904:	ebfffe2f 	bl	81c8 <_ZN4CAUX12Set_RegisterEN3hal7AUX_RegEj>
/home/cf/ZCU/first_year/winter/OS/practical/ex3/kernel/src/drivers/uart.cpp:30

    mAUX.Set_Register(hal::AUX_Reg::MU_BAUD, val);
    8908:	e51b3010 	ldr	r3, [fp, #-16]
    890c:	e5933000 	ldr	r3, [r3]
    8910:	e51b200c 	ldr	r2, [fp, #-12]
    8914:	e3a0101a 	mov	r1, #26
    8918:	e1a00003 	mov	r0, r3
    891c:	ebfffe29 	bl	81c8 <_ZN4CAUX12Set_RegisterEN3hal7AUX_RegEj>
/home/cf/ZCU/first_year/winter/OS/practical/ex3/kernel/src/drivers/uart.cpp:32

    mAUX.Set_Register(hal::AUX_Reg::MU_CNTL, 3);
    8920:	e51b3010 	ldr	r3, [fp, #-16]
    8924:	e5933000 	ldr	r3, [r3]
    8928:	e3a02003 	mov	r2, #3
    892c:	e3a01018 	mov	r1, #24
    8930:	e1a00003 	mov	r0, r3
    8934:	ebfffe23 	bl	81c8 <_ZN4CAUX12Set_RegisterEN3hal7AUX_RegEj>
/home/cf/ZCU/first_year/winter/OS/practical/ex3/kernel/src/drivers/uart.cpp:33
}
    8938:	e320f000 	nop	{0}
    893c:	e24bd004 	sub	sp, fp, #4
    8940:	e8bd8800 	pop	{fp, pc}
    8944:	0ee6b280 	cdpeq	2, 14, cr11, cr6, cr0, {4}
    8948:	01dcd650 	bicseq	sp, ip, r0, asr r6

0000894c <_ZN5CUART5WriteEc>:
_ZN5CUART5WriteEc():
/home/cf/ZCU/first_year/winter/OS/practical/ex3/kernel/src/drivers/uart.cpp:36

void CUART::Write(char c)
{
    894c:	e92d4800 	push	{fp, lr}
    8950:	e28db004 	add	fp, sp, #4
    8954:	e24dd008 	sub	sp, sp, #8
    8958:	e50b0008 	str	r0, [fp, #-8]
    895c:	e1a03001 	mov	r3, r1
    8960:	e54b3009 	strb	r3, [fp, #-9]
/home/cf/ZCU/first_year/winter/OS/practical/ex3/kernel/src/drivers/uart.cpp:38
    // dokud ma status registr priznak "vystupni fronta plna", nelze prenaset dalsi bit
    while (!(mAUX.Get_Register(hal::AUX_Reg::MU_LSR) & (1 << 5)))
    8964:	e320f000 	nop	{0}
/home/cf/ZCU/first_year/winter/OS/practical/ex3/kernel/src/drivers/uart.cpp:38 (discriminator 1)
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
/home/cf/ZCU/first_year/winter/OS/practical/ex3/kernel/src/drivers/uart.cpp:41
        ;

    mAUX.Set_Register(hal::AUX_Reg::MU_IO, c);
    899c:	e51b3008 	ldr	r3, [fp, #-8]
    89a0:	e5933000 	ldr	r3, [r3]
    89a4:	e55b2009 	ldrb	r2, [fp, #-9]
    89a8:	e3a01010 	mov	r1, #16
    89ac:	e1a00003 	mov	r0, r3
    89b0:	ebfffe04 	bl	81c8 <_ZN4CAUX12Set_RegisterEN3hal7AUX_RegEj>
/home/cf/ZCU/first_year/winter/OS/practical/ex3/kernel/src/drivers/uart.cpp:42
}
    89b4:	e320f000 	nop	{0}
    89b8:	e24bd004 	sub	sp, fp, #4
    89bc:	e8bd8800 	pop	{fp, pc}

000089c0 <_ZN5CUART5WriteEPKc>:
_ZN5CUART5WriteEPKc():
/home/cf/ZCU/first_year/winter/OS/practical/ex3/kernel/src/drivers/uart.cpp:45

void CUART::Write(const char* str)
{
    89c0:	e92d4800 	push	{fp, lr}
    89c4:	e28db004 	add	fp, sp, #4
    89c8:	e24dd010 	sub	sp, sp, #16
    89cc:	e50b0010 	str	r0, [fp, #-16]
    89d0:	e50b1014 	str	r1, [fp, #-20]	; 0xffffffec
/home/cf/ZCU/first_year/winter/OS/practical/ex3/kernel/src/drivers/uart.cpp:48
    int i;

    for (i = 0; str[i] != '\0'; i++)
    89d4:	e3a03000 	mov	r3, #0
    89d8:	e50b3008 	str	r3, [fp, #-8]
    89dc:	ea000009 	b	8a08 <_ZN5CUART5WriteEPKc+0x48>
/home/cf/ZCU/first_year/winter/OS/practical/ex3/kernel/src/drivers/uart.cpp:49 (discriminator 3)
        Write(str[i]);
    89e0:	e51b3008 	ldr	r3, [fp, #-8]
    89e4:	e51b2014 	ldr	r2, [fp, #-20]	; 0xffffffec
    89e8:	e0823003 	add	r3, r2, r3
    89ec:	e5d33000 	ldrb	r3, [r3]
    89f0:	e1a01003 	mov	r1, r3
    89f4:	e51b0010 	ldr	r0, [fp, #-16]
    89f8:	ebffffd3 	bl	894c <_ZN5CUART5WriteEc>
/home/cf/ZCU/first_year/winter/OS/practical/ex3/kernel/src/drivers/uart.cpp:48 (discriminator 3)
    for (i = 0; str[i] != '\0'; i++)
    89fc:	e51b3008 	ldr	r3, [fp, #-8]
    8a00:	e2833001 	add	r3, r3, #1
    8a04:	e50b3008 	str	r3, [fp, #-8]
/home/cf/ZCU/first_year/winter/OS/practical/ex3/kernel/src/drivers/uart.cpp:48 (discriminator 1)
    8a08:	e51b3008 	ldr	r3, [fp, #-8]
    8a0c:	e51b2014 	ldr	r2, [fp, #-20]	; 0xffffffec
    8a10:	e0823003 	add	r3, r2, r3
    8a14:	e5d33000 	ldrb	r3, [r3]
    8a18:	e3530000 	cmp	r3, #0
    8a1c:	1affffef 	bne	89e0 <_ZN5CUART5WriteEPKc+0x20>
/home/cf/ZCU/first_year/winter/OS/practical/ex3/kernel/src/drivers/uart.cpp:50
}
    8a20:	e320f000 	nop	{0}
    8a24:	e320f000 	nop	{0}
    8a28:	e24bd004 	sub	sp, fp, #4
    8a2c:	e8bd8800 	pop	{fp, pc}

00008a30 <_ZN5CUART5StartEv>:
_ZN5CUART5StartEv():
/home/cf/ZCU/first_year/winter/OS/practical/ex3/kernel/src/drivers/uart.cpp:52

void CUART::Start() {
    8a30:	e92d4800 	push	{fp, lr}
    8a34:	e28db004 	add	fp, sp, #4
    8a38:	e24dd008 	sub	sp, sp, #8
    8a3c:	e50b0008 	str	r0, [fp, #-8]
/home/cf/ZCU/first_year/winter/OS/practical/ex3/kernel/src/drivers/uart.cpp:54
    // enable mini UART on AUX coprocessor
    mAUX.Enable(hal::AUX_Peripherals::MiniUART);
    8a40:	e51b3008 	ldr	r3, [fp, #-8]
    8a44:	e5933000 	ldr	r3, [r3]
    8a48:	e3a01000 	mov	r1, #0
    8a4c:	e1a00003 	mov	r0, r3
    8a50:	ebfffdb3 	bl	8124 <_ZN4CAUX6EnableEN3hal15AUX_PeripheralsE>
/home/cf/ZCU/first_year/winter/OS/practical/ex3/kernel/src/drivers/uart.cpp:57
    
    // UART1 is on pins 14 and 15, alternative 5
    sGPIO.Set_GPIO_Function(14, NGPIO_Function::Alt_5);
    8a54:	e3a02002 	mov	r2, #2
    8a58:	e3a0100e 	mov	r1, #14
    8a5c:	e59f0094 	ldr	r0, [pc, #148]	; 8af8 <_ZN5CUART5StartEv+0xc8>
    8a60:	ebfffebd 	bl	855c <_ZN13CGPIO_Handler17Set_GPIO_FunctionEj14NGPIO_Function>
/home/cf/ZCU/first_year/winter/OS/practical/ex3/kernel/src/drivers/uart.cpp:58
    sGPIO.Set_GPIO_Function(15, NGPIO_Function::Alt_5);
    8a64:	e3a02002 	mov	r2, #2
    8a68:	e3a0100f 	mov	r1, #15
    8a6c:	e59f0084 	ldr	r0, [pc, #132]	; 8af8 <_ZN5CUART5StartEv+0xc8>
    8a70:	ebfffeb9 	bl	855c <_ZN13CGPIO_Handler17Set_GPIO_FunctionEj14NGPIO_Function>
/home/cf/ZCU/first_year/winter/OS/practical/ex3/kernel/src/drivers/uart.cpp:61

    // setting UART parameters
    mAUX.Set_Register(hal::AUX_Reg::MU_IIR, 0);
    8a74:	e51b3008 	ldr	r3, [fp, #-8]
    8a78:	e5933000 	ldr	r3, [r3]
    8a7c:	e3a02000 	mov	r2, #0
    8a80:	e3a01012 	mov	r1, #18
    8a84:	e1a00003 	mov	r0, r3
    8a88:	ebfffdce 	bl	81c8 <_ZN4CAUX12Set_RegisterEN3hal7AUX_RegEj>
/home/cf/ZCU/first_year/winter/OS/practical/ex3/kernel/src/drivers/uart.cpp:62
    mAUX.Set_Register(hal::AUX_Reg::MU_IER, 0);
    8a8c:	e51b3008 	ldr	r3, [fp, #-8]
    8a90:	e5933000 	ldr	r3, [r3]
    8a94:	e3a02000 	mov	r2, #0
    8a98:	e3a01011 	mov	r1, #17
    8a9c:	e1a00003 	mov	r0, r3
    8aa0:	ebfffdc8 	bl	81c8 <_ZN4CAUX12Set_RegisterEN3hal7AUX_RegEj>
/home/cf/ZCU/first_year/winter/OS/practical/ex3/kernel/src/drivers/uart.cpp:63
    mAUX.Set_Register(hal::AUX_Reg::MU_MCR, 0);
    8aa4:	e51b3008 	ldr	r3, [fp, #-8]
    8aa8:	e5933000 	ldr	r3, [r3]
    8aac:	e3a02000 	mov	r2, #0
    8ab0:	e3a01014 	mov	r1, #20
    8ab4:	e1a00003 	mov	r0, r3
    8ab8:	ebfffdc2 	bl	81c8 <_ZN4CAUX12Set_RegisterEN3hal7AUX_RegEj>
/home/cf/ZCU/first_year/winter/OS/practical/ex3/kernel/src/drivers/uart.cpp:64
    mAUX.Set_Register(hal::AUX_Reg::MU_CNTL, 3); // RX and TX enabled
    8abc:	e51b3008 	ldr	r3, [fp, #-8]
    8ac0:	e5933000 	ldr	r3, [r3]
    8ac4:	e3a02003 	mov	r2, #3
    8ac8:	e3a01018 	mov	r1, #24
    8acc:	e1a00003 	mov	r0, r3
    8ad0:	ebfffdbc 	bl	81c8 <_ZN4CAUX12Set_RegisterEN3hal7AUX_RegEj>
/home/cf/ZCU/first_year/winter/OS/practical/ex3/kernel/src/drivers/uart.cpp:65
    sUART0.Set_Baud_Rate(NUART_Baud_Rate::BR_115200);
    8ad4:	e59f1020 	ldr	r1, [pc, #32]	; 8afc <_ZN5CUART5StartEv+0xcc>
    8ad8:	e59f0020 	ldr	r0, [pc, #32]	; 8b00 <_ZN5CUART5StartEv+0xd0>
    8adc:	ebffff75 	bl	88b8 <_ZN5CUART13Set_Baud_RateE15NUART_Baud_Rate>
/home/cf/ZCU/first_year/winter/OS/practical/ex3/kernel/src/drivers/uart.cpp:66
	sUART0.Set_Char_Length(NUART_Char_Length::Char_8);
    8ae0:	e3a01001 	mov	r1, #1
    8ae4:	e59f0014 	ldr	r0, [pc, #20]	; 8b00 <_ZN5CUART5StartEv+0xd0>
    8ae8:	ebffff5b 	bl	885c <_ZN5CUART15Set_Char_LengthE17NUART_Char_Length>
/home/cf/ZCU/first_year/winter/OS/practical/ex3/kernel/src/drivers/uart.cpp:71
    // nastavit parametery uart
    // data lenth - LCR, modulacni rychlost - spocitat podle vzorecku (asi Vmod = f / (8 * B + 1), kde B je velikost registru (asi IO?))
    // transmitter enable CTL
    // reciever enable
}
    8aec:	e320f000 	nop	{0}
    8af0:	e24bd004 	sub	sp, fp, #4
    8af4:	e8bd8800 	pop	{fp, pc}
    8af8:	000097cc 	andeq	r9, r0, ip, asr #15
    8afc:	0001c200 	andeq	ip, r1, r0, lsl #4
    8b00:	000097d0 	ldrdeq	r9, [r0], -r0

00008b04 <_ZN5CUART4StopEv>:
_ZN5CUART4StopEv():
/home/cf/ZCU/first_year/winter/OS/practical/ex3/kernel/src/drivers/uart.cpp:73

void CUART::Stop() {
    8b04:	e92d4800 	push	{fp, lr}
    8b08:	e28db004 	add	fp, sp, #4
    8b0c:	e24dd008 	sub	sp, sp, #8
    8b10:	e50b0008 	str	r0, [fp, #-8]
/home/cf/ZCU/first_year/winter/OS/practical/ex3/kernel/src/drivers/uart.cpp:74
    mAUX.Disable(hal::AUX_Peripherals::MiniUART);
    8b14:	e51b3008 	ldr	r3, [fp, #-8]
    8b18:	e5933000 	ldr	r3, [r3]
    8b1c:	e3a01000 	mov	r1, #0
    8b20:	e1a00003 	mov	r0, r3
    8b24:	ebfffd92 	bl	8174 <_ZN4CAUX7DisableEN3hal15AUX_PeripheralsE>
/home/cf/ZCU/first_year/winter/OS/practical/ex3/kernel/src/drivers/uart.cpp:75
}
    8b28:	e320f000 	nop	{0}
    8b2c:	e24bd004 	sub	sp, fp, #4
    8b30:	e8bd8800 	pop	{fp, pc}

00008b34 <_ZN5CUART4ReadEv>:
_ZN5CUART4ReadEv():
/home/cf/ZCU/first_year/winter/OS/practical/ex3/kernel/src/drivers/uart.cpp:78

// impl. write_string(const char *str) -- pozor, nemame std knihovny - tedy zadny strlen ani prevody
char CUART::Read() {
    8b34:	e92d4800 	push	{fp, lr}
    8b38:	e28db004 	add	fp, sp, #4
    8b3c:	e24dd010 	sub	sp, sp, #16
    8b40:	e50b0010 	str	r0, [fp, #-16]
/home/cf/ZCU/first_year/winter/OS/practical/ex3/kernel/src/drivers/uart.cpp:79
    while (!(mAUX.Get_Register(hal::AUX_Reg::MU_LSR) & 0x01))
    8b44:	e320f000 	nop	{0}
/home/cf/ZCU/first_year/winter/OS/practical/ex3/kernel/src/drivers/uart.cpp:79 (discriminator 1)
    8b48:	e51b3010 	ldr	r3, [fp, #-16]
    8b4c:	e5933000 	ldr	r3, [r3]
    8b50:	e3a01015 	mov	r1, #21
    8b54:	e1a00003 	mov	r0, r3
    8b58:	ebfffdab 	bl	820c <_ZN4CAUX12Get_RegisterEN3hal7AUX_RegE>
    8b5c:	e1a03000 	mov	r3, r0
    8b60:	e2033001 	and	r3, r3, #1
    8b64:	e3530000 	cmp	r3, #0
    8b68:	03a03001 	moveq	r3, #1
    8b6c:	13a03000 	movne	r3, #0
    8b70:	e6ef3073 	uxtb	r3, r3
    8b74:	e3530000 	cmp	r3, #0
    8b78:	1afffff2 	bne	8b48 <_ZN5CUART4ReadEv+0x14>
/home/cf/ZCU/first_year/winter/OS/practical/ex3/kernel/src/drivers/uart.cpp:82
        ;

    uint32_t c = mAUX.Get_Register(hal::AUX_Reg::MU_IO);
    8b7c:	e51b3010 	ldr	r3, [fp, #-16]
    8b80:	e5933000 	ldr	r3, [r3]
    8b84:	e3a01010 	mov	r1, #16
    8b88:	e1a00003 	mov	r0, r3
    8b8c:	ebfffd9e 	bl	820c <_ZN4CAUX12Get_RegisterEN3hal7AUX_RegE>
    8b90:	e1a03000 	mov	r3, r0
    8b94:	e50b3008 	str	r3, [fp, #-8]
/home/cf/ZCU/first_year/winter/OS/practical/ex3/kernel/src/drivers/uart.cpp:83
    return (char) c; // this should take LS 8 bits (only LS 8 bits carry value)
    8b98:	e51b3008 	ldr	r3, [fp, #-8]
    8b9c:	e6ef3073 	uxtb	r3, r3
/home/cf/ZCU/first_year/winter/OS/practical/ex3/kernel/src/drivers/uart.cpp:84
    8ba0:	e1a00003 	mov	r0, r3
    8ba4:	e24bd004 	sub	sp, fp, #4
    8ba8:	e8bd8800 	pop	{fp, pc}

00008bac <_Z41__static_initialization_and_destruction_0ii>:
_Z41__static_initialization_and_destruction_0ii():
/home/cf/ZCU/first_year/winter/OS/practical/ex3/kernel/src/drivers/uart.cpp:84
    8bac:	e92d4800 	push	{fp, lr}
    8bb0:	e28db004 	add	fp, sp, #4
    8bb4:	e24dd008 	sub	sp, sp, #8
    8bb8:	e50b0008 	str	r0, [fp, #-8]
    8bbc:	e50b100c 	str	r1, [fp, #-12]
    8bc0:	e51b3008 	ldr	r3, [fp, #-8]
    8bc4:	e3530001 	cmp	r3, #1
    8bc8:	1a000006 	bne	8be8 <_Z41__static_initialization_and_destruction_0ii+0x3c>
/home/cf/ZCU/first_year/winter/OS/practical/ex3/kernel/src/drivers/uart.cpp:84 (discriminator 1)
    8bcc:	e51b300c 	ldr	r3, [fp, #-12]
    8bd0:	e59f201c 	ldr	r2, [pc, #28]	; 8bf4 <_Z41__static_initialization_and_destruction_0ii+0x48>
    8bd4:	e1530002 	cmp	r3, r2
    8bd8:	1a000002 	bne	8be8 <_Z41__static_initialization_and_destruction_0ii+0x3c>
/home/cf/ZCU/first_year/winter/OS/practical/ex3/kernel/src/drivers/uart.cpp:5
CUART sUART0(sAUX);
    8bdc:	e59f1014 	ldr	r1, [pc, #20]	; 8bf8 <_Z41__static_initialization_and_destruction_0ii+0x4c>
    8be0:	e59f0014 	ldr	r0, [pc, #20]	; 8bfc <_Z41__static_initialization_and_destruction_0ii+0x50>
    8be4:	ebfffef3 	bl	87b8 <_ZN5CUARTC1ER4CAUX>
/home/cf/ZCU/first_year/winter/OS/practical/ex3/kernel/src/drivers/uart.cpp:84
    8be8:	e320f000 	nop	{0}
    8bec:	e24bd004 	sub	sp, fp, #4
    8bf0:	e8bd8800 	pop	{fp, pc}
    8bf4:	0000ffff 	strdeq	pc, [r0], -pc	; <UNPREDICTABLE>
    8bf8:	000097c8 	andeq	r9, r0, r8, asr #15
    8bfc:	000097d0 	ldrdeq	r9, [r0], -r0

00008c00 <_GLOBAL__sub_I_sUART0>:
_GLOBAL__sub_I_sUART0():
/home/cf/ZCU/first_year/winter/OS/practical/ex3/kernel/src/drivers/uart.cpp:84
    8c00:	e92d4800 	push	{fp, lr}
    8c04:	e28db004 	add	fp, sp, #4
    8c08:	e59f1008 	ldr	r1, [pc, #8]	; 8c18 <_GLOBAL__sub_I_sUART0+0x18>
    8c0c:	e3a00001 	mov	r0, #1
    8c10:	ebffffe5 	bl	8bac <_Z41__static_initialization_and_destruction_0ii>
    8c14:	e8bd8800 	pop	{fp, pc}
    8c18:	0000ffff 	strdeq	pc, [r0], -pc	; <UNPREDICTABLE>

00008c1c <_Z9burn_timei>:
_Z9burn_timei():
/home/cf/ZCU/first_year/winter/OS/practical/ex3/kernel/src/main.cpp:7
#include <drivers/uart.h>

// GPIO pin 47 je pripojeny na LED na desce (tzv. ACT LED)
constexpr uint32_t ACT_Pin = 47;

void burn_time(int time) {
    8c1c:	e52db004 	push	{fp}		; (str fp, [sp, #-4]!)
    8c20:	e28db000 	add	fp, sp, #0
    8c24:	e24dd014 	sub	sp, sp, #20
    8c28:	e50b0010 	str	r0, [fp, #-16]
/home/cf/ZCU/first_year/winter/OS/practical/ex3/kernel/src/main.cpp:9
	volatile unsigned int tim;
	for(tim = 0; tim < time; tim++)
    8c2c:	e3a03000 	mov	r3, #0
    8c30:	e50b3008 	str	r3, [fp, #-8]
    8c34:	ea000002 	b	8c44 <_Z9burn_timei+0x28>
/home/cf/ZCU/first_year/winter/OS/practical/ex3/kernel/src/main.cpp:9 (discriminator 3)
    8c38:	e51b3008 	ldr	r3, [fp, #-8]
    8c3c:	e2833001 	add	r3, r3, #1
    8c40:	e50b3008 	str	r3, [fp, #-8]
/home/cf/ZCU/first_year/winter/OS/practical/ex3/kernel/src/main.cpp:9 (discriminator 1)
    8c44:	e51b2008 	ldr	r2, [fp, #-8]
    8c48:	e51b3010 	ldr	r3, [fp, #-16]
    8c4c:	e1520003 	cmp	r2, r3
    8c50:	33a03001 	movcc	r3, #1
    8c54:	23a03000 	movcs	r3, #0
    8c58:	e6ef3073 	uxtb	r3, r3
    8c5c:	e3530000 	cmp	r3, #0
    8c60:	1afffff4 	bne	8c38 <_Z9burn_timei+0x1c>
/home/cf/ZCU/first_year/winter/OS/practical/ex3/kernel/src/main.cpp:11
		;
}
    8c64:	e320f000 	nop	{0}
    8c68:	e320f000 	nop	{0}
    8c6c:	e28bd000 	add	sp, fp, #0
    8c70:	e49db004 	pop	{fp}		; (ldr fp, [sp], #4)
    8c74:	e12fff1e 	bx	lr

00008c78 <_Z7reversePci>:
_Z7reversePci():
/home/cf/ZCU/first_year/winter/OS/practical/ex3/kernel/src/main.cpp:15

/* A utility function to reverse a string  */
void reverse(char str[], int length)
{
    8c78:	e52db004 	push	{fp}		; (str fp, [sp, #-4]!)
    8c7c:	e28db000 	add	fp, sp, #0
    8c80:	e24dd01c 	sub	sp, sp, #28
    8c84:	e50b0018 	str	r0, [fp, #-24]	; 0xffffffe8
    8c88:	e50b101c 	str	r1, [fp, #-28]	; 0xffffffe4
/home/cf/ZCU/first_year/winter/OS/practical/ex3/kernel/src/main.cpp:16
    int start = 0;
    8c8c:	e3a03000 	mov	r3, #0
    8c90:	e50b3008 	str	r3, [fp, #-8]
/home/cf/ZCU/first_year/winter/OS/practical/ex3/kernel/src/main.cpp:17
    int end = length -1;
    8c94:	e51b301c 	ldr	r3, [fp, #-28]	; 0xffffffe4
    8c98:	e2433001 	sub	r3, r3, #1
    8c9c:	e50b300c 	str	r3, [fp, #-12]
/home/cf/ZCU/first_year/winter/OS/practical/ex3/kernel/src/main.cpp:18
    while (start < end)
    8ca0:	ea000018 	b	8d08 <_Z7reversePci+0x90>
/home/cf/ZCU/first_year/winter/OS/practical/ex3/kernel/src/main.cpp:21
    {
        // swap(*(str+start), *(str+end));
		int tmp = *(str+start);
    8ca4:	e51b3008 	ldr	r3, [fp, #-8]
    8ca8:	e51b2018 	ldr	r2, [fp, #-24]	; 0xffffffe8
    8cac:	e0823003 	add	r3, r2, r3
    8cb0:	e5d33000 	ldrb	r3, [r3]
    8cb4:	e50b3010 	str	r3, [fp, #-16]
/home/cf/ZCU/first_year/winter/OS/practical/ex3/kernel/src/main.cpp:22
		*(str+start) = *(str+end);
    8cb8:	e51b300c 	ldr	r3, [fp, #-12]
    8cbc:	e51b2018 	ldr	r2, [fp, #-24]	; 0xffffffe8
    8cc0:	e0822003 	add	r2, r2, r3
    8cc4:	e51b3008 	ldr	r3, [fp, #-8]
    8cc8:	e51b1018 	ldr	r1, [fp, #-24]	; 0xffffffe8
    8ccc:	e0813003 	add	r3, r1, r3
    8cd0:	e5d22000 	ldrb	r2, [r2]
    8cd4:	e5c32000 	strb	r2, [r3]
/home/cf/ZCU/first_year/winter/OS/practical/ex3/kernel/src/main.cpp:23
		*(str+end) = tmp;
    8cd8:	e51b300c 	ldr	r3, [fp, #-12]
    8cdc:	e51b2018 	ldr	r2, [fp, #-24]	; 0xffffffe8
    8ce0:	e0823003 	add	r3, r2, r3
    8ce4:	e51b2010 	ldr	r2, [fp, #-16]
    8ce8:	e6ef2072 	uxtb	r2, r2
    8cec:	e5c32000 	strb	r2, [r3]
/home/cf/ZCU/first_year/winter/OS/practical/ex3/kernel/src/main.cpp:24
        start++;
    8cf0:	e51b3008 	ldr	r3, [fp, #-8]
    8cf4:	e2833001 	add	r3, r3, #1
    8cf8:	e50b3008 	str	r3, [fp, #-8]
/home/cf/ZCU/first_year/winter/OS/practical/ex3/kernel/src/main.cpp:25
        end--;
    8cfc:	e51b300c 	ldr	r3, [fp, #-12]
    8d00:	e2433001 	sub	r3, r3, #1
    8d04:	e50b300c 	str	r3, [fp, #-12]
/home/cf/ZCU/first_year/winter/OS/practical/ex3/kernel/src/main.cpp:18
    while (start < end)
    8d08:	e51b2008 	ldr	r2, [fp, #-8]
    8d0c:	e51b300c 	ldr	r3, [fp, #-12]
    8d10:	e1520003 	cmp	r2, r3
    8d14:	baffffe2 	blt	8ca4 <_Z7reversePci+0x2c>
/home/cf/ZCU/first_year/winter/OS/practical/ex3/kernel/src/main.cpp:27
    }
}
    8d18:	e320f000 	nop	{0}
    8d1c:	e320f000 	nop	{0}
    8d20:	e28bd000 	add	sp, fp, #0
    8d24:	e49db004 	pop	{fp}		; (ldr fp, [sp], #4)
    8d28:	e12fff1e 	bx	lr

00008d2c <_Z4itoaiPci>:
_Z4itoaiPci():
/home/cf/ZCU/first_year/winter/OS/practical/ex3/kernel/src/main.cpp:31
 
// Implementation of itoa()
char* itoa(int num, char* str, int base)
{
    8d2c:	e92d4800 	push	{fp, lr}
    8d30:	e28db004 	add	fp, sp, #4
    8d34:	e24dd020 	sub	sp, sp, #32
    8d38:	e50b0018 	str	r0, [fp, #-24]	; 0xffffffe8
    8d3c:	e50b101c 	str	r1, [fp, #-28]	; 0xffffffe4
    8d40:	e50b2020 	str	r2, [fp, #-32]	; 0xffffffe0
/home/cf/ZCU/first_year/winter/OS/practical/ex3/kernel/src/main.cpp:32
    int i = 0;
    8d44:	e3a03000 	mov	r3, #0
    8d48:	e50b3008 	str	r3, [fp, #-8]
/home/cf/ZCU/first_year/winter/OS/practical/ex3/kernel/src/main.cpp:33
    bool isNegative = false;
    8d4c:	e3a03000 	mov	r3, #0
    8d50:	e54b3009 	strb	r3, [fp, #-9]
/home/cf/ZCU/first_year/winter/OS/practical/ex3/kernel/src/main.cpp:36
 
    /* Handle 0 explicitly, otherwise empty string is printed for 0 */
    if (num == 0)
    8d54:	e51b3018 	ldr	r3, [fp, #-24]	; 0xffffffe8
    8d58:	e3530000 	cmp	r3, #0
    8d5c:	1a00000d 	bne	8d98 <_Z4itoaiPci+0x6c>
/home/cf/ZCU/first_year/winter/OS/practical/ex3/kernel/src/main.cpp:38
    {
        str[i++] = '0';
    8d60:	e51b201c 	ldr	r2, [fp, #-28]	; 0xffffffe4
    8d64:	e51b3008 	ldr	r3, [fp, #-8]
    8d68:	e2831001 	add	r1, r3, #1
    8d6c:	e50b1008 	str	r1, [fp, #-8]
    8d70:	e0823003 	add	r3, r2, r3
    8d74:	e3a02030 	mov	r2, #48	; 0x30
    8d78:	e5c32000 	strb	r2, [r3]
/home/cf/ZCU/first_year/winter/OS/practical/ex3/kernel/src/main.cpp:39
        str[i] = '\0';
    8d7c:	e51b3008 	ldr	r3, [fp, #-8]
    8d80:	e51b201c 	ldr	r2, [fp, #-28]	; 0xffffffe4
    8d84:	e0823003 	add	r3, r2, r3
    8d88:	e3a02000 	mov	r2, #0
    8d8c:	e5c32000 	strb	r2, [r3]
/home/cf/ZCU/first_year/winter/OS/practical/ex3/kernel/src/main.cpp:40
        return str;
    8d90:	e51b301c 	ldr	r3, [fp, #-28]	; 0xffffffe4
    8d94:	ea00003e 	b	8e94 <_Z4itoaiPci+0x168>
/home/cf/ZCU/first_year/winter/OS/practical/ex3/kernel/src/main.cpp:45
    }
 
    // In standard itoa(), negative numbers are handled only with
    // base 10. Otherwise numbers are considered unsigned.
    if (num < 0 && base == 10)
    8d98:	e51b3018 	ldr	r3, [fp, #-24]	; 0xffffffe8
    8d9c:	e3530000 	cmp	r3, #0
    8da0:	aa000025 	bge	8e3c <_Z4itoaiPci+0x110>
/home/cf/ZCU/first_year/winter/OS/practical/ex3/kernel/src/main.cpp:45 (discriminator 1)
    8da4:	e51b3020 	ldr	r3, [fp, #-32]	; 0xffffffe0
    8da8:	e353000a 	cmp	r3, #10
    8dac:	1a000022 	bne	8e3c <_Z4itoaiPci+0x110>
/home/cf/ZCU/first_year/winter/OS/practical/ex3/kernel/src/main.cpp:47
    {
        isNegative = true;
    8db0:	e3a03001 	mov	r3, #1
    8db4:	e54b3009 	strb	r3, [fp, #-9]
/home/cf/ZCU/first_year/winter/OS/practical/ex3/kernel/src/main.cpp:48
        num = -num;
    8db8:	e51b3018 	ldr	r3, [fp, #-24]	; 0xffffffe8
    8dbc:	e2633000 	rsb	r3, r3, #0
    8dc0:	e50b3018 	str	r3, [fp, #-24]	; 0xffffffe8
/home/cf/ZCU/first_year/winter/OS/practical/ex3/kernel/src/main.cpp:52
    }
 
    // Process individual digits
    while (num != 0)
    8dc4:	ea00001c 	b	8e3c <_Z4itoaiPci+0x110>
/home/cf/ZCU/first_year/winter/OS/practical/ex3/kernel/src/main.cpp:54
    {
        int rem = num % base;
    8dc8:	e51b3018 	ldr	r3, [fp, #-24]	; 0xffffffe8
    8dcc:	e51b1020 	ldr	r1, [fp, #-32]	; 0xffffffe0
    8dd0:	e1a00003 	mov	r0, r3
    8dd4:	eb0001c8 	bl	94fc <__aeabi_idivmod>
    8dd8:	e1a03001 	mov	r3, r1
    8ddc:	e50b3010 	str	r3, [fp, #-16]
/home/cf/ZCU/first_year/winter/OS/practical/ex3/kernel/src/main.cpp:55
        str[i++] = (rem > 9)? (rem-10) + 'a' : rem + '0';
    8de0:	e51b3010 	ldr	r3, [fp, #-16]
    8de4:	e3530009 	cmp	r3, #9
    8de8:	da000004 	ble	8e00 <_Z4itoaiPci+0xd4>
/home/cf/ZCU/first_year/winter/OS/practical/ex3/kernel/src/main.cpp:55 (discriminator 1)
    8dec:	e51b3010 	ldr	r3, [fp, #-16]
    8df0:	e6ef3073 	uxtb	r3, r3
    8df4:	e2833057 	add	r3, r3, #87	; 0x57
    8df8:	e6ef3073 	uxtb	r3, r3
    8dfc:	ea000003 	b	8e10 <_Z4itoaiPci+0xe4>
/home/cf/ZCU/first_year/winter/OS/practical/ex3/kernel/src/main.cpp:55 (discriminator 2)
    8e00:	e51b3010 	ldr	r3, [fp, #-16]
    8e04:	e6ef3073 	uxtb	r3, r3
    8e08:	e2833030 	add	r3, r3, #48	; 0x30
    8e0c:	e6ef3073 	uxtb	r3, r3
/home/cf/ZCU/first_year/winter/OS/practical/ex3/kernel/src/main.cpp:55 (discriminator 4)
    8e10:	e51b101c 	ldr	r1, [fp, #-28]	; 0xffffffe4
    8e14:	e51b2008 	ldr	r2, [fp, #-8]
    8e18:	e2820001 	add	r0, r2, #1
    8e1c:	e50b0008 	str	r0, [fp, #-8]
    8e20:	e0812002 	add	r2, r1, r2
    8e24:	e5c23000 	strb	r3, [r2]
/home/cf/ZCU/first_year/winter/OS/practical/ex3/kernel/src/main.cpp:56 (discriminator 4)
        num = num/base;
    8e28:	e51b1020 	ldr	r1, [fp, #-32]	; 0xffffffe0
    8e2c:	e51b0018 	ldr	r0, [fp, #-24]	; 0xffffffe8
    8e30:	eb000129 	bl	92dc <__divsi3>
    8e34:	e1a03000 	mov	r3, r0
    8e38:	e50b3018 	str	r3, [fp, #-24]	; 0xffffffe8
/home/cf/ZCU/first_year/winter/OS/practical/ex3/kernel/src/main.cpp:52
    while (num != 0)
    8e3c:	e51b3018 	ldr	r3, [fp, #-24]	; 0xffffffe8
    8e40:	e3530000 	cmp	r3, #0
    8e44:	1affffdf 	bne	8dc8 <_Z4itoaiPci+0x9c>
/home/cf/ZCU/first_year/winter/OS/practical/ex3/kernel/src/main.cpp:60
    }
 
    // If number is negative, append '-'
    if (isNegative)
    8e48:	e55b3009 	ldrb	r3, [fp, #-9]
    8e4c:	e3530000 	cmp	r3, #0
    8e50:	0a000006 	beq	8e70 <_Z4itoaiPci+0x144>
/home/cf/ZCU/first_year/winter/OS/practical/ex3/kernel/src/main.cpp:61
        str[i++] = '-';
    8e54:	e51b201c 	ldr	r2, [fp, #-28]	; 0xffffffe4
    8e58:	e51b3008 	ldr	r3, [fp, #-8]
    8e5c:	e2831001 	add	r1, r3, #1
    8e60:	e50b1008 	str	r1, [fp, #-8]
    8e64:	e0823003 	add	r3, r2, r3
    8e68:	e3a0202d 	mov	r2, #45	; 0x2d
    8e6c:	e5c32000 	strb	r2, [r3]
/home/cf/ZCU/first_year/winter/OS/practical/ex3/kernel/src/main.cpp:63
 
    str[i] = '\0'; // Append string terminator
    8e70:	e51b3008 	ldr	r3, [fp, #-8]
    8e74:	e51b201c 	ldr	r2, [fp, #-28]	; 0xffffffe4
    8e78:	e0823003 	add	r3, r2, r3
    8e7c:	e3a02000 	mov	r2, #0
    8e80:	e5c32000 	strb	r2, [r3]
/home/cf/ZCU/first_year/winter/OS/practical/ex3/kernel/src/main.cpp:66
 
    // Reverse the string
    reverse(str, i);
    8e84:	e51b1008 	ldr	r1, [fp, #-8]
    8e88:	e51b001c 	ldr	r0, [fp, #-28]	; 0xffffffe4
    8e8c:	ebffff79 	bl	8c78 <_Z7reversePci>
/home/cf/ZCU/first_year/winter/OS/practical/ex3/kernel/src/main.cpp:68
 
    return str;
    8e90:	e51b301c 	ldr	r3, [fp, #-28]	; 0xffffffe4
/home/cf/ZCU/first_year/winter/OS/practical/ex3/kernel/src/main.cpp:69
}
    8e94:	e1a00003 	mov	r0, r3
    8e98:	e24bd004 	sub	sp, fp, #4
    8e9c:	e8bd8800 	pop	{fp, pc}

00008ea0 <_kernel_main>:
_kernel_main():
/home/cf/ZCU/first_year/winter/OS/practical/ex3/kernel/src/main.cpp:72

extern "C" int _kernel_main(void)
{
    8ea0:	e92d4800 	push	{fp, lr}
    8ea4:	e28db004 	add	fp, sp, #4
    8ea8:	e24dd048 	sub	sp, sp, #72	; 0x48
/home/cf/ZCU/first_year/winter/OS/practical/ex3/kernel/src/main.cpp:74
	// nastavime ACT LED pin na vystupni
	sGPIO.Set_GPIO_Function(ACT_Pin, NGPIO_Function::Output);
    8eac:	e3a02001 	mov	r2, #1
    8eb0:	e3a0102f 	mov	r1, #47	; 0x2f
    8eb4:	e59f00dc 	ldr	r0, [pc, #220]	; 8f98 <_kernel_main+0xf8>
    8eb8:	ebfffda7 	bl	855c <_ZN13CGPIO_Handler17Set_GPIO_FunctionEj14NGPIO_Function>
/home/cf/ZCU/first_year/winter/OS/practical/ex3/kernel/src/main.cpp:77

	// inicializujeme UART kanal 0
	sUART0.Set_Baud_Rate(NUART_Baud_Rate::BR_115200);
    8ebc:	e59f10d8 	ldr	r1, [pc, #216]	; 8f9c <_kernel_main+0xfc>
    8ec0:	e59f00d8 	ldr	r0, [pc, #216]	; 8fa0 <_kernel_main+0x100>
    8ec4:	ebfffe7b 	bl	88b8 <_ZN5CUART13Set_Baud_RateE15NUART_Baud_Rate>
/home/cf/ZCU/first_year/winter/OS/practical/ex3/kernel/src/main.cpp:78
	sUART0.Set_Char_Length(NUART_Char_Length::Char_8);
    8ec8:	e3a01001 	mov	r1, #1
    8ecc:	e59f00cc 	ldr	r0, [pc, #204]	; 8fa0 <_kernel_main+0x100>
    8ed0:	ebfffe61 	bl	885c <_ZN5CUART15Set_Char_LengthE17NUART_Char_Length>
/home/cf/ZCU/first_year/winter/OS/practical/ex3/kernel/src/main.cpp:79
	sUART0.Start();
    8ed4:	e59f00c4 	ldr	r0, [pc, #196]	; 8fa0 <_kernel_main+0x100>
    8ed8:	ebfffed4 	bl	8a30 <_ZN5CUART5StartEv>
/home/cf/ZCU/first_year/winter/OS/practical/ex3/kernel/src/main.cpp:82

	// vypiseme ladici hlasku
	sUART0.Write("Welcome to KIV/OS RPiOS kernel\r\n");
    8edc:	e59f10c0 	ldr	r1, [pc, #192]	; 8fa4 <_kernel_main+0x104>
    8ee0:	e59f00b8 	ldr	r0, [pc, #184]	; 8fa0 <_kernel_main+0x100>
    8ee4:	ebfffeb5 	bl	89c0 <_ZN5CUART5WriteEPKc>
/home/cf/ZCU/first_year/winter/OS/practical/ex3/kernel/src/main.cpp:86
	
    while (1)
    {
		burn_time(500000);
    8ee8:	e59f00b8 	ldr	r0, [pc, #184]	; 8fa8 <_kernel_main+0x108>
    8eec:	ebffff4a 	bl	8c1c <_Z9burn_timei>
/home/cf/ZCU/first_year/winter/OS/practical/ex3/kernel/src/main.cpp:87
		sUART0.Write("Cislo je: ");
    8ef0:	e59f10b4 	ldr	r1, [pc, #180]	; 8fac <_kernel_main+0x10c>
    8ef4:	e59f00a4 	ldr	r0, [pc, #164]	; 8fa0 <_kernel_main+0x100>
    8ef8:	ebfffeb0 	bl	89c0 <_ZN5CUART5WriteEPKc>
/home/cf/ZCU/first_year/winter/OS/practical/ex3/kernel/src/main.cpp:89

		int a = 15;
    8efc:	e3a0300f 	mov	r3, #15
    8f00:	e50b3008 	str	r3, [fp, #-8]
/home/cf/ZCU/first_year/winter/OS/practical/ex3/kernel/src/main.cpp:90
		char buf[64] = {0};
    8f04:	e3a03000 	mov	r3, #0
    8f08:	e50b304c 	str	r3, [fp, #-76]	; 0xffffffb4
    8f0c:	e24b3048 	sub	r3, fp, #72	; 0x48
    8f10:	e3a0203c 	mov	r2, #60	; 0x3c
    8f14:	e3a01000 	mov	r1, #0
    8f18:	e1a00003 	mov	r0, r3
    8f1c:	eb00017f 	bl	9520 <memset>
/home/cf/ZCU/first_year/winter/OS/practical/ex3/kernel/src/main.cpp:91
		itoa(a, buf, 10);
    8f20:	e24b304c 	sub	r3, fp, #76	; 0x4c
    8f24:	e3a0200a 	mov	r2, #10
    8f28:	e1a01003 	mov	r1, r3
    8f2c:	e51b0008 	ldr	r0, [fp, #-8]
    8f30:	ebffff7d 	bl	8d2c <_Z4itoaiPci>
/home/cf/ZCU/first_year/winter/OS/practical/ex3/kernel/src/main.cpp:92
		sUART0.Write(buf);
    8f34:	e24b304c 	sub	r3, fp, #76	; 0x4c
    8f38:	e1a01003 	mov	r1, r3
    8f3c:	e59f005c 	ldr	r0, [pc, #92]	; 8fa0 <_kernel_main+0x100>
    8f40:	ebfffe9e 	bl	89c0 <_ZN5CUART5WriteEPKc>
/home/cf/ZCU/first_year/winter/OS/practical/ex3/kernel/src/main.cpp:93
		sUART0.Write("\r\n");
    8f44:	e59f1064 	ldr	r1, [pc, #100]	; 8fb0 <_kernel_main+0x110>
    8f48:	e59f0050 	ldr	r0, [pc, #80]	; 8fa0 <_kernel_main+0x100>
    8f4c:	ebfffe9b 	bl	89c0 <_ZN5CUART5WriteEPKc>
/home/cf/ZCU/first_year/winter/OS/practical/ex3/kernel/src/main.cpp:94
		sUART0.Write("Zadej znak: ");
    8f50:	e59f105c 	ldr	r1, [pc, #92]	; 8fb4 <_kernel_main+0x114>
    8f54:	e59f0044 	ldr	r0, [pc, #68]	; 8fa0 <_kernel_main+0x100>
    8f58:	ebfffe98 	bl	89c0 <_ZN5CUART5WriteEPKc>
/home/cf/ZCU/first_year/winter/OS/practical/ex3/kernel/src/main.cpp:97
		
		char c;
		c = sUART0.Read();
    8f5c:	e59f003c 	ldr	r0, [pc, #60]	; 8fa0 <_kernel_main+0x100>
    8f60:	ebfffef3 	bl	8b34 <_ZN5CUART4ReadEv>
    8f64:	e1a03000 	mov	r3, r0
    8f68:	e54b3009 	strb	r3, [fp, #-9]
/home/cf/ZCU/first_year/winter/OS/practical/ex3/kernel/src/main.cpp:99

		sUART0.Write(++c);
    8f6c:	e55b3009 	ldrb	r3, [fp, #-9]
    8f70:	e2833001 	add	r3, r3, #1
    8f74:	e54b3009 	strb	r3, [fp, #-9]
    8f78:	e55b3009 	ldrb	r3, [fp, #-9]
    8f7c:	e1a01003 	mov	r1, r3
    8f80:	e59f0018 	ldr	r0, [pc, #24]	; 8fa0 <_kernel_main+0x100>
    8f84:	ebfffe70 	bl	894c <_ZN5CUART5WriteEc>
/home/cf/ZCU/first_year/winter/OS/practical/ex3/kernel/src/main.cpp:100
		sUART0.Write("\r\n");
    8f88:	e59f1020 	ldr	r1, [pc, #32]	; 8fb0 <_kernel_main+0x110>
    8f8c:	e59f000c 	ldr	r0, [pc, #12]	; 8fa0 <_kernel_main+0x100>
    8f90:	ebfffe8a 	bl	89c0 <_ZN5CUART5WriteEPKc>
/home/cf/ZCU/first_year/winter/OS/practical/ex3/kernel/src/main.cpp:117
        // for(tim = 0; tim < 500000; tim++)
        //     ;

		// // rozsvitime LED
		// sGPIO.Set_Output(ACT_Pin, false);
    }
    8f94:	eaffffd3 	b	8ee8 <_kernel_main+0x48>
    8f98:	000097cc 	andeq	r9, r0, ip, asr #15
    8f9c:	0001c200 	andeq	ip, r1, r0, lsl #4
    8fa0:	000097d0 	ldrdeq	r9, [r0], -r0
    8fa4:	00009778 	andeq	r9, r0, r8, ror r7
    8fa8:	0007a120 	andeq	sl, r7, r0, lsr #2
    8fac:	0000979c 	muleq	r0, ip, r7
    8fb0:	000097a8 	andeq	r9, r0, r8, lsr #15
    8fb4:	000097ac 	andeq	r9, r0, ip, lsr #15

00008fb8 <_c_startup>:
_c_startup():
/home/cf/ZCU/first_year/winter/OS/practical/ex3/kernel/src/startup.cpp:21
extern "C" dtor_ptr __DTOR_LIST__[0];
// konec pole destruktoru
extern "C" dtor_ptr __DTOR_END__[0];

extern "C" int _c_startup(void)
{
    8fb8:	e52db004 	push	{fp}		; (str fp, [sp, #-4]!)
    8fbc:	e28db000 	add	fp, sp, #0
    8fc0:	e24dd00c 	sub	sp, sp, #12
/home/cf/ZCU/first_year/winter/OS/practical/ex3/kernel/src/startup.cpp:25
	int* i;
	
	// vynulujeme .bss sekci
	for (i = (int*)_bss_start; i < (int*)_bss_end; i++)
    8fc4:	e59f304c 	ldr	r3, [pc, #76]	; 9018 <_c_startup+0x60>
    8fc8:	e5933000 	ldr	r3, [r3]
    8fcc:	e50b3008 	str	r3, [fp, #-8]
    8fd0:	ea000005 	b	8fec <_c_startup+0x34>
/home/cf/ZCU/first_year/winter/OS/practical/ex3/kernel/src/startup.cpp:26 (discriminator 3)
		*i = 0;
    8fd4:	e51b3008 	ldr	r3, [fp, #-8]
    8fd8:	e3a02000 	mov	r2, #0
    8fdc:	e5832000 	str	r2, [r3]
/home/cf/ZCU/first_year/winter/OS/practical/ex3/kernel/src/startup.cpp:25 (discriminator 3)
	for (i = (int*)_bss_start; i < (int*)_bss_end; i++)
    8fe0:	e51b3008 	ldr	r3, [fp, #-8]
    8fe4:	e2833004 	add	r3, r3, #4
    8fe8:	e50b3008 	str	r3, [fp, #-8]
/home/cf/ZCU/first_year/winter/OS/practical/ex3/kernel/src/startup.cpp:25 (discriminator 1)
    8fec:	e59f3028 	ldr	r3, [pc, #40]	; 901c <_c_startup+0x64>
    8ff0:	e5933000 	ldr	r3, [r3]
    8ff4:	e1a02003 	mov	r2, r3
    8ff8:	e51b3008 	ldr	r3, [fp, #-8]
    8ffc:	e1530002 	cmp	r3, r2
    9000:	3afffff3 	bcc	8fd4 <_c_startup+0x1c>
/home/cf/ZCU/first_year/winter/OS/practical/ex3/kernel/src/startup.cpp:28
	
	return 0;
    9004:	e3a03000 	mov	r3, #0
/home/cf/ZCU/first_year/winter/OS/practical/ex3/kernel/src/startup.cpp:29
}
    9008:	e1a00003 	mov	r0, r3
    900c:	e28bd000 	add	sp, fp, #0
    9010:	e49db004 	pop	{fp}		; (ldr fp, [sp], #4)
    9014:	e12fff1e 	bx	lr
    9018:	000097c8 	andeq	r9, r0, r8, asr #15
    901c:	000097e4 	andeq	r9, r0, r4, ror #15

00009020 <_cpp_startup>:
_cpp_startup():
/home/cf/ZCU/first_year/winter/OS/practical/ex3/kernel/src/startup.cpp:32

extern "C" int _cpp_startup(void)
{
    9020:	e92d4800 	push	{fp, lr}
    9024:	e28db004 	add	fp, sp, #4
    9028:	e24dd008 	sub	sp, sp, #8
/home/cf/ZCU/first_year/winter/OS/practical/ex3/kernel/src/startup.cpp:37
	ctor_ptr* fnptr;
	
	// zavolame konstruktory globalnich C++ trid
	// v poli __CTOR_LIST__ jsou ukazatele na vygenerovane stuby volani konstruktoru
	for (fnptr = __CTOR_LIST__; fnptr < __CTOR_END__; fnptr++)
    902c:	e59f303c 	ldr	r3, [pc, #60]	; 9070 <_cpp_startup+0x50>
    9030:	e50b3008 	str	r3, [fp, #-8]
    9034:	ea000005 	b	9050 <_cpp_startup+0x30>
/home/cf/ZCU/first_year/winter/OS/practical/ex3/kernel/src/startup.cpp:38 (discriminator 3)
		(*fnptr)();
    9038:	e51b3008 	ldr	r3, [fp, #-8]
    903c:	e5933000 	ldr	r3, [r3]
    9040:	e12fff33 	blx	r3
/home/cf/ZCU/first_year/winter/OS/practical/ex3/kernel/src/startup.cpp:37 (discriminator 3)
	for (fnptr = __CTOR_LIST__; fnptr < __CTOR_END__; fnptr++)
    9044:	e51b3008 	ldr	r3, [fp, #-8]
    9048:	e2833004 	add	r3, r3, #4
    904c:	e50b3008 	str	r3, [fp, #-8]
/home/cf/ZCU/first_year/winter/OS/practical/ex3/kernel/src/startup.cpp:37 (discriminator 1)
    9050:	e51b3008 	ldr	r3, [fp, #-8]
    9054:	e59f2018 	ldr	r2, [pc, #24]	; 9074 <_cpp_startup+0x54>
    9058:	e1530002 	cmp	r3, r2
    905c:	3afffff5 	bcc	9038 <_cpp_startup+0x18>
/home/cf/ZCU/first_year/winter/OS/practical/ex3/kernel/src/startup.cpp:40
	
	return 0;
    9060:	e3a03000 	mov	r3, #0
/home/cf/ZCU/first_year/winter/OS/practical/ex3/kernel/src/startup.cpp:41
}
    9064:	e1a00003 	mov	r0, r3
    9068:	e24bd004 	sub	sp, fp, #4
    906c:	e8bd8800 	pop	{fp, pc}
    9070:	000097bc 			; <UNDEFINED> instruction: 0x000097bc
    9074:	000097c8 	andeq	r9, r0, r8, asr #15

00009078 <_cpp_shutdown>:
_cpp_shutdown():
/home/cf/ZCU/first_year/winter/OS/practical/ex3/kernel/src/startup.cpp:44

extern "C" int _cpp_shutdown(void)
{
    9078:	e92d4800 	push	{fp, lr}
    907c:	e28db004 	add	fp, sp, #4
    9080:	e24dd008 	sub	sp, sp, #8
/home/cf/ZCU/first_year/winter/OS/practical/ex3/kernel/src/startup.cpp:48
	dtor_ptr* fnptr;
	
	// zavolame destruktory globalnich C++ trid
	for (fnptr = __DTOR_LIST__; fnptr < __DTOR_END__; fnptr++)
    9084:	e59f303c 	ldr	r3, [pc, #60]	; 90c8 <_cpp_shutdown+0x50>
    9088:	e50b3008 	str	r3, [fp, #-8]
    908c:	ea000005 	b	90a8 <_cpp_shutdown+0x30>
/home/cf/ZCU/first_year/winter/OS/practical/ex3/kernel/src/startup.cpp:49 (discriminator 3)
		(*fnptr)();
    9090:	e51b3008 	ldr	r3, [fp, #-8]
    9094:	e5933000 	ldr	r3, [r3]
    9098:	e12fff33 	blx	r3
/home/cf/ZCU/first_year/winter/OS/practical/ex3/kernel/src/startup.cpp:48 (discriminator 3)
	for (fnptr = __DTOR_LIST__; fnptr < __DTOR_END__; fnptr++)
    909c:	e51b3008 	ldr	r3, [fp, #-8]
    90a0:	e2833004 	add	r3, r3, #4
    90a4:	e50b3008 	str	r3, [fp, #-8]
/home/cf/ZCU/first_year/winter/OS/practical/ex3/kernel/src/startup.cpp:48 (discriminator 1)
    90a8:	e51b3008 	ldr	r3, [fp, #-8]
    90ac:	e59f2018 	ldr	r2, [pc, #24]	; 90cc <_cpp_shutdown+0x54>
    90b0:	e1530002 	cmp	r3, r2
    90b4:	3afffff5 	bcc	9090 <_cpp_shutdown+0x18>
/home/cf/ZCU/first_year/winter/OS/practical/ex3/kernel/src/startup.cpp:51
	
	return 0;
    90b8:	e3a03000 	mov	r3, #0
/home/cf/ZCU/first_year/winter/OS/practical/ex3/kernel/src/startup.cpp:52
}
    90bc:	e1a00003 	mov	r0, r3
    90c0:	e24bd004 	sub	sp, fp, #4
    90c4:	e8bd8800 	pop	{fp, pc}
    90c8:	000097c8 	andeq	r9, r0, r8, asr #15
    90cc:	000097c8 	andeq	r9, r0, r8, asr #15

000090d0 <__udivsi3>:
__udivsi3():
/builddir/build/BUILD/arm-none-eabi-gcc-cs-12.2.0/gcc-arm-none-eabi/arm-none-eabi/arm/v5te/hard/libgcc/../../../../../../gcc-12.2.0/libgcc/config/arm/lib1funcs.S:1104
    90d0:	e2512001 	subs	r2, r1, #1
/builddir/build/BUILD/arm-none-eabi-gcc-cs-12.2.0/gcc-arm-none-eabi/arm-none-eabi/arm/v5te/hard/libgcc/../../../../../../gcc-12.2.0/libgcc/config/arm/lib1funcs.S:1106
    90d4:	012fff1e 	bxeq	lr
/builddir/build/BUILD/arm-none-eabi-gcc-cs-12.2.0/gcc-arm-none-eabi/arm-none-eabi/arm/v5te/hard/libgcc/../../../../../../gcc-12.2.0/libgcc/config/arm/lib1funcs.S:1107
    90d8:	3a000074 	bcc	92b0 <__udivsi3+0x1e0>
/builddir/build/BUILD/arm-none-eabi-gcc-cs-12.2.0/gcc-arm-none-eabi/arm-none-eabi/arm/v5te/hard/libgcc/../../../../../../gcc-12.2.0/libgcc/config/arm/lib1funcs.S:1108
    90dc:	e1500001 	cmp	r0, r1
/builddir/build/BUILD/arm-none-eabi-gcc-cs-12.2.0/gcc-arm-none-eabi/arm-none-eabi/arm/v5te/hard/libgcc/../../../../../../gcc-12.2.0/libgcc/config/arm/lib1funcs.S:1109
    90e0:	9a00006b 	bls	9294 <__udivsi3+0x1c4>
/builddir/build/BUILD/arm-none-eabi-gcc-cs-12.2.0/gcc-arm-none-eabi/arm-none-eabi/arm/v5te/hard/libgcc/../../../../../../gcc-12.2.0/libgcc/config/arm/lib1funcs.S:1110
    90e4:	e1110002 	tst	r1, r2
/builddir/build/BUILD/arm-none-eabi-gcc-cs-12.2.0/gcc-arm-none-eabi/arm-none-eabi/arm/v5te/hard/libgcc/../../../../../../gcc-12.2.0/libgcc/config/arm/lib1funcs.S:1111
    90e8:	0a00006c 	beq	92a0 <__udivsi3+0x1d0>
/builddir/build/BUILD/arm-none-eabi-gcc-cs-12.2.0/gcc-arm-none-eabi/arm-none-eabi/arm/v5te/hard/libgcc/../../../../../../gcc-12.2.0/libgcc/config/arm/lib1funcs.S:1113
    90ec:	e16f3f10 	clz	r3, r0
    90f0:	e16f2f11 	clz	r2, r1
    90f4:	e0423003 	sub	r3, r2, r3
    90f8:	e273301f 	rsbs	r3, r3, #31
    90fc:	10833083 	addne	r3, r3, r3, lsl #1
    9100:	e3a02000 	mov	r2, #0
    9104:	108ff103 	addne	pc, pc, r3, lsl #2
    9108:	e1a00000 	nop			; (mov r0, r0)
    910c:	e1500f81 	cmp	r0, r1, lsl #31
    9110:	e0a22002 	adc	r2, r2, r2
    9114:	20400f81 	subcs	r0, r0, r1, lsl #31
    9118:	e1500f01 	cmp	r0, r1, lsl #30
    911c:	e0a22002 	adc	r2, r2, r2
    9120:	20400f01 	subcs	r0, r0, r1, lsl #30
    9124:	e1500e81 	cmp	r0, r1, lsl #29
    9128:	e0a22002 	adc	r2, r2, r2
    912c:	20400e81 	subcs	r0, r0, r1, lsl #29
    9130:	e1500e01 	cmp	r0, r1, lsl #28
    9134:	e0a22002 	adc	r2, r2, r2
    9138:	20400e01 	subcs	r0, r0, r1, lsl #28
    913c:	e1500d81 	cmp	r0, r1, lsl #27
    9140:	e0a22002 	adc	r2, r2, r2
    9144:	20400d81 	subcs	r0, r0, r1, lsl #27
    9148:	e1500d01 	cmp	r0, r1, lsl #26
    914c:	e0a22002 	adc	r2, r2, r2
    9150:	20400d01 	subcs	r0, r0, r1, lsl #26
    9154:	e1500c81 	cmp	r0, r1, lsl #25
    9158:	e0a22002 	adc	r2, r2, r2
    915c:	20400c81 	subcs	r0, r0, r1, lsl #25
    9160:	e1500c01 	cmp	r0, r1, lsl #24
    9164:	e0a22002 	adc	r2, r2, r2
    9168:	20400c01 	subcs	r0, r0, r1, lsl #24
    916c:	e1500b81 	cmp	r0, r1, lsl #23
    9170:	e0a22002 	adc	r2, r2, r2
    9174:	20400b81 	subcs	r0, r0, r1, lsl #23
    9178:	e1500b01 	cmp	r0, r1, lsl #22
    917c:	e0a22002 	adc	r2, r2, r2
    9180:	20400b01 	subcs	r0, r0, r1, lsl #22
    9184:	e1500a81 	cmp	r0, r1, lsl #21
    9188:	e0a22002 	adc	r2, r2, r2
    918c:	20400a81 	subcs	r0, r0, r1, lsl #21
    9190:	e1500a01 	cmp	r0, r1, lsl #20
    9194:	e0a22002 	adc	r2, r2, r2
    9198:	20400a01 	subcs	r0, r0, r1, lsl #20
    919c:	e1500981 	cmp	r0, r1, lsl #19
    91a0:	e0a22002 	adc	r2, r2, r2
    91a4:	20400981 	subcs	r0, r0, r1, lsl #19
    91a8:	e1500901 	cmp	r0, r1, lsl #18
    91ac:	e0a22002 	adc	r2, r2, r2
    91b0:	20400901 	subcs	r0, r0, r1, lsl #18
    91b4:	e1500881 	cmp	r0, r1, lsl #17
    91b8:	e0a22002 	adc	r2, r2, r2
    91bc:	20400881 	subcs	r0, r0, r1, lsl #17
    91c0:	e1500801 	cmp	r0, r1, lsl #16
    91c4:	e0a22002 	adc	r2, r2, r2
    91c8:	20400801 	subcs	r0, r0, r1, lsl #16
    91cc:	e1500781 	cmp	r0, r1, lsl #15
    91d0:	e0a22002 	adc	r2, r2, r2
    91d4:	20400781 	subcs	r0, r0, r1, lsl #15
    91d8:	e1500701 	cmp	r0, r1, lsl #14
    91dc:	e0a22002 	adc	r2, r2, r2
    91e0:	20400701 	subcs	r0, r0, r1, lsl #14
    91e4:	e1500681 	cmp	r0, r1, lsl #13
    91e8:	e0a22002 	adc	r2, r2, r2
    91ec:	20400681 	subcs	r0, r0, r1, lsl #13
    91f0:	e1500601 	cmp	r0, r1, lsl #12
    91f4:	e0a22002 	adc	r2, r2, r2
    91f8:	20400601 	subcs	r0, r0, r1, lsl #12
    91fc:	e1500581 	cmp	r0, r1, lsl #11
    9200:	e0a22002 	adc	r2, r2, r2
    9204:	20400581 	subcs	r0, r0, r1, lsl #11
    9208:	e1500501 	cmp	r0, r1, lsl #10
    920c:	e0a22002 	adc	r2, r2, r2
    9210:	20400501 	subcs	r0, r0, r1, lsl #10
    9214:	e1500481 	cmp	r0, r1, lsl #9
    9218:	e0a22002 	adc	r2, r2, r2
    921c:	20400481 	subcs	r0, r0, r1, lsl #9
    9220:	e1500401 	cmp	r0, r1, lsl #8
    9224:	e0a22002 	adc	r2, r2, r2
    9228:	20400401 	subcs	r0, r0, r1, lsl #8
    922c:	e1500381 	cmp	r0, r1, lsl #7
    9230:	e0a22002 	adc	r2, r2, r2
    9234:	20400381 	subcs	r0, r0, r1, lsl #7
    9238:	e1500301 	cmp	r0, r1, lsl #6
    923c:	e0a22002 	adc	r2, r2, r2
    9240:	20400301 	subcs	r0, r0, r1, lsl #6
    9244:	e1500281 	cmp	r0, r1, lsl #5
    9248:	e0a22002 	adc	r2, r2, r2
    924c:	20400281 	subcs	r0, r0, r1, lsl #5
    9250:	e1500201 	cmp	r0, r1, lsl #4
    9254:	e0a22002 	adc	r2, r2, r2
    9258:	20400201 	subcs	r0, r0, r1, lsl #4
    925c:	e1500181 	cmp	r0, r1, lsl #3
    9260:	e0a22002 	adc	r2, r2, r2
    9264:	20400181 	subcs	r0, r0, r1, lsl #3
    9268:	e1500101 	cmp	r0, r1, lsl #2
    926c:	e0a22002 	adc	r2, r2, r2
    9270:	20400101 	subcs	r0, r0, r1, lsl #2
    9274:	e1500081 	cmp	r0, r1, lsl #1
    9278:	e0a22002 	adc	r2, r2, r2
    927c:	20400081 	subcs	r0, r0, r1, lsl #1
    9280:	e1500001 	cmp	r0, r1
    9284:	e0a22002 	adc	r2, r2, r2
    9288:	20400001 	subcs	r0, r0, r1
/builddir/build/BUILD/arm-none-eabi-gcc-cs-12.2.0/gcc-arm-none-eabi/arm-none-eabi/arm/v5te/hard/libgcc/../../../../../../gcc-12.2.0/libgcc/config/arm/lib1funcs.S:1115
    928c:	e1a00002 	mov	r0, r2
/builddir/build/BUILD/arm-none-eabi-gcc-cs-12.2.0/gcc-arm-none-eabi/arm-none-eabi/arm/v5te/hard/libgcc/../../../../../../gcc-12.2.0/libgcc/config/arm/lib1funcs.S:1116
    9290:	e12fff1e 	bx	lr
/builddir/build/BUILD/arm-none-eabi-gcc-cs-12.2.0/gcc-arm-none-eabi/arm-none-eabi/arm/v5te/hard/libgcc/../../../../../../gcc-12.2.0/libgcc/config/arm/lib1funcs.S:1119
    9294:	03a00001 	moveq	r0, #1
/builddir/build/BUILD/arm-none-eabi-gcc-cs-12.2.0/gcc-arm-none-eabi/arm-none-eabi/arm/v5te/hard/libgcc/../../../../../../gcc-12.2.0/libgcc/config/arm/lib1funcs.S:1120
    9298:	13a00000 	movne	r0, #0
/builddir/build/BUILD/arm-none-eabi-gcc-cs-12.2.0/gcc-arm-none-eabi/arm-none-eabi/arm/v5te/hard/libgcc/../../../../../../gcc-12.2.0/libgcc/config/arm/lib1funcs.S:1121
    929c:	e12fff1e 	bx	lr
/builddir/build/BUILD/arm-none-eabi-gcc-cs-12.2.0/gcc-arm-none-eabi/arm-none-eabi/arm/v5te/hard/libgcc/../../../../../../gcc-12.2.0/libgcc/config/arm/lib1funcs.S:1123
    92a0:	e16f2f11 	clz	r2, r1
    92a4:	e262201f 	rsb	r2, r2, #31
/builddir/build/BUILD/arm-none-eabi-gcc-cs-12.2.0/gcc-arm-none-eabi/arm-none-eabi/arm/v5te/hard/libgcc/../../../../../../gcc-12.2.0/libgcc/config/arm/lib1funcs.S:1125
    92a8:	e1a00230 	lsr	r0, r0, r2
/builddir/build/BUILD/arm-none-eabi-gcc-cs-12.2.0/gcc-arm-none-eabi/arm-none-eabi/arm/v5te/hard/libgcc/../../../../../../gcc-12.2.0/libgcc/config/arm/lib1funcs.S:1126
    92ac:	e12fff1e 	bx	lr
/builddir/build/BUILD/arm-none-eabi-gcc-cs-12.2.0/gcc-arm-none-eabi/arm-none-eabi/arm/v5te/hard/libgcc/../../../../../../gcc-12.2.0/libgcc/config/arm/lib1funcs.S:1130
    92b0:	e3500000 	cmp	r0, #0
    92b4:	13e00000 	mvnne	r0, #0
    92b8:	ea000097 	b	951c <__aeabi_idiv0>

000092bc <__aeabi_uidivmod>:
__aeabi_uidivmod():
/builddir/build/BUILD/arm-none-eabi-gcc-cs-12.2.0/gcc-arm-none-eabi/arm-none-eabi/arm/v5te/hard/libgcc/../../../../../../gcc-12.2.0/libgcc/config/arm/lib1funcs.S:1161
    92bc:	e3510000 	cmp	r1, #0
/builddir/build/BUILD/arm-none-eabi-gcc-cs-12.2.0/gcc-arm-none-eabi/arm-none-eabi/arm/v5te/hard/libgcc/../../../../../../gcc-12.2.0/libgcc/config/arm/lib1funcs.S:1162
    92c0:	0afffffa 	beq	92b0 <__udivsi3+0x1e0>
/builddir/build/BUILD/arm-none-eabi-gcc-cs-12.2.0/gcc-arm-none-eabi/arm-none-eabi/arm/v5te/hard/libgcc/../../../../../../gcc-12.2.0/libgcc/config/arm/lib1funcs.S:1163
    92c4:	e92d4003 	push	{r0, r1, lr}
/builddir/build/BUILD/arm-none-eabi-gcc-cs-12.2.0/gcc-arm-none-eabi/arm-none-eabi/arm/v5te/hard/libgcc/../../../../../../gcc-12.2.0/libgcc/config/arm/lib1funcs.S:1164
    92c8:	ebffff80 	bl	90d0 <__udivsi3>
/builddir/build/BUILD/arm-none-eabi-gcc-cs-12.2.0/gcc-arm-none-eabi/arm-none-eabi/arm/v5te/hard/libgcc/../../../../../../gcc-12.2.0/libgcc/config/arm/lib1funcs.S:1165
    92cc:	e8bd4006 	pop	{r1, r2, lr}
/builddir/build/BUILD/arm-none-eabi-gcc-cs-12.2.0/gcc-arm-none-eabi/arm-none-eabi/arm/v5te/hard/libgcc/../../../../../../gcc-12.2.0/libgcc/config/arm/lib1funcs.S:1166
    92d0:	e0030092 	mul	r3, r2, r0
/builddir/build/BUILD/arm-none-eabi-gcc-cs-12.2.0/gcc-arm-none-eabi/arm-none-eabi/arm/v5te/hard/libgcc/../../../../../../gcc-12.2.0/libgcc/config/arm/lib1funcs.S:1167
    92d4:	e0411003 	sub	r1, r1, r3
/builddir/build/BUILD/arm-none-eabi-gcc-cs-12.2.0/gcc-arm-none-eabi/arm-none-eabi/arm/v5te/hard/libgcc/../../../../../../gcc-12.2.0/libgcc/config/arm/lib1funcs.S:1168
    92d8:	e12fff1e 	bx	lr

000092dc <__divsi3>:
__divsi3():
/builddir/build/BUILD/arm-none-eabi-gcc-cs-12.2.0/gcc-arm-none-eabi/arm-none-eabi/arm/v5te/hard/libgcc/../../../../../../gcc-12.2.0/libgcc/config/arm/lib1funcs.S:1297
    92dc:	e3510000 	cmp	r1, #0
/builddir/build/BUILD/arm-none-eabi-gcc-cs-12.2.0/gcc-arm-none-eabi/arm-none-eabi/arm/v5te/hard/libgcc/../../../../../../gcc-12.2.0/libgcc/config/arm/lib1funcs.S:1298
    92e0:	0a000081 	beq	94ec <.divsi3_skip_div0_test+0x208>

000092e4 <.divsi3_skip_div0_test>:
/builddir/build/BUILD/arm-none-eabi-gcc-cs-12.2.0/gcc-arm-none-eabi/arm-none-eabi/arm/v5te/hard/libgcc/../../../../../../gcc-12.2.0/libgcc/config/arm/lib1funcs.S:1300
    92e4:	e020c001 	eor	ip, r0, r1
/builddir/build/BUILD/arm-none-eabi-gcc-cs-12.2.0/gcc-arm-none-eabi/arm-none-eabi/arm/v5te/hard/libgcc/../../../../../../gcc-12.2.0/libgcc/config/arm/lib1funcs.S:1302
    92e8:	42611000 	rsbmi	r1, r1, #0
/builddir/build/BUILD/arm-none-eabi-gcc-cs-12.2.0/gcc-arm-none-eabi/arm-none-eabi/arm/v5te/hard/libgcc/../../../../../../gcc-12.2.0/libgcc/config/arm/lib1funcs.S:1303
    92ec:	e2512001 	subs	r2, r1, #1
/builddir/build/BUILD/arm-none-eabi-gcc-cs-12.2.0/gcc-arm-none-eabi/arm-none-eabi/arm/v5te/hard/libgcc/../../../../../../gcc-12.2.0/libgcc/config/arm/lib1funcs.S:1304
    92f0:	0a000070 	beq	94b8 <.divsi3_skip_div0_test+0x1d4>
/builddir/build/BUILD/arm-none-eabi-gcc-cs-12.2.0/gcc-arm-none-eabi/arm-none-eabi/arm/v5te/hard/libgcc/../../../../../../gcc-12.2.0/libgcc/config/arm/lib1funcs.S:1305
    92f4:	e1b03000 	movs	r3, r0
/builddir/build/BUILD/arm-none-eabi-gcc-cs-12.2.0/gcc-arm-none-eabi/arm-none-eabi/arm/v5te/hard/libgcc/../../../../../../gcc-12.2.0/libgcc/config/arm/lib1funcs.S:1307
    92f8:	42603000 	rsbmi	r3, r0, #0
/builddir/build/BUILD/arm-none-eabi-gcc-cs-12.2.0/gcc-arm-none-eabi/arm-none-eabi/arm/v5te/hard/libgcc/../../../../../../gcc-12.2.0/libgcc/config/arm/lib1funcs.S:1308
    92fc:	e1530001 	cmp	r3, r1
/builddir/build/BUILD/arm-none-eabi-gcc-cs-12.2.0/gcc-arm-none-eabi/arm-none-eabi/arm/v5te/hard/libgcc/../../../../../../gcc-12.2.0/libgcc/config/arm/lib1funcs.S:1309
    9300:	9a00006f 	bls	94c4 <.divsi3_skip_div0_test+0x1e0>
/builddir/build/BUILD/arm-none-eabi-gcc-cs-12.2.0/gcc-arm-none-eabi/arm-none-eabi/arm/v5te/hard/libgcc/../../../../../../gcc-12.2.0/libgcc/config/arm/lib1funcs.S:1310
    9304:	e1110002 	tst	r1, r2
/builddir/build/BUILD/arm-none-eabi-gcc-cs-12.2.0/gcc-arm-none-eabi/arm-none-eabi/arm/v5te/hard/libgcc/../../../../../../gcc-12.2.0/libgcc/config/arm/lib1funcs.S:1311
    9308:	0a000071 	beq	94d4 <.divsi3_skip_div0_test+0x1f0>
/builddir/build/BUILD/arm-none-eabi-gcc-cs-12.2.0/gcc-arm-none-eabi/arm-none-eabi/arm/v5te/hard/libgcc/../../../../../../gcc-12.2.0/libgcc/config/arm/lib1funcs.S:1313
    930c:	e16f2f13 	clz	r2, r3
    9310:	e16f0f11 	clz	r0, r1
    9314:	e0402002 	sub	r2, r0, r2
    9318:	e272201f 	rsbs	r2, r2, #31
    931c:	10822082 	addne	r2, r2, r2, lsl #1
    9320:	e3a00000 	mov	r0, #0
    9324:	108ff102 	addne	pc, pc, r2, lsl #2
    9328:	e1a00000 	nop			; (mov r0, r0)
    932c:	e1530f81 	cmp	r3, r1, lsl #31
    9330:	e0a00000 	adc	r0, r0, r0
    9334:	20433f81 	subcs	r3, r3, r1, lsl #31
    9338:	e1530f01 	cmp	r3, r1, lsl #30
    933c:	e0a00000 	adc	r0, r0, r0
    9340:	20433f01 	subcs	r3, r3, r1, lsl #30
    9344:	e1530e81 	cmp	r3, r1, lsl #29
    9348:	e0a00000 	adc	r0, r0, r0
    934c:	20433e81 	subcs	r3, r3, r1, lsl #29
    9350:	e1530e01 	cmp	r3, r1, lsl #28
    9354:	e0a00000 	adc	r0, r0, r0
    9358:	20433e01 	subcs	r3, r3, r1, lsl #28
    935c:	e1530d81 	cmp	r3, r1, lsl #27
    9360:	e0a00000 	adc	r0, r0, r0
    9364:	20433d81 	subcs	r3, r3, r1, lsl #27
    9368:	e1530d01 	cmp	r3, r1, lsl #26
    936c:	e0a00000 	adc	r0, r0, r0
    9370:	20433d01 	subcs	r3, r3, r1, lsl #26
    9374:	e1530c81 	cmp	r3, r1, lsl #25
    9378:	e0a00000 	adc	r0, r0, r0
    937c:	20433c81 	subcs	r3, r3, r1, lsl #25
    9380:	e1530c01 	cmp	r3, r1, lsl #24
    9384:	e0a00000 	adc	r0, r0, r0
    9388:	20433c01 	subcs	r3, r3, r1, lsl #24
    938c:	e1530b81 	cmp	r3, r1, lsl #23
    9390:	e0a00000 	adc	r0, r0, r0
    9394:	20433b81 	subcs	r3, r3, r1, lsl #23
    9398:	e1530b01 	cmp	r3, r1, lsl #22
    939c:	e0a00000 	adc	r0, r0, r0
    93a0:	20433b01 	subcs	r3, r3, r1, lsl #22
    93a4:	e1530a81 	cmp	r3, r1, lsl #21
    93a8:	e0a00000 	adc	r0, r0, r0
    93ac:	20433a81 	subcs	r3, r3, r1, lsl #21
    93b0:	e1530a01 	cmp	r3, r1, lsl #20
    93b4:	e0a00000 	adc	r0, r0, r0
    93b8:	20433a01 	subcs	r3, r3, r1, lsl #20
    93bc:	e1530981 	cmp	r3, r1, lsl #19
    93c0:	e0a00000 	adc	r0, r0, r0
    93c4:	20433981 	subcs	r3, r3, r1, lsl #19
    93c8:	e1530901 	cmp	r3, r1, lsl #18
    93cc:	e0a00000 	adc	r0, r0, r0
    93d0:	20433901 	subcs	r3, r3, r1, lsl #18
    93d4:	e1530881 	cmp	r3, r1, lsl #17
    93d8:	e0a00000 	adc	r0, r0, r0
    93dc:	20433881 	subcs	r3, r3, r1, lsl #17
    93e0:	e1530801 	cmp	r3, r1, lsl #16
    93e4:	e0a00000 	adc	r0, r0, r0
    93e8:	20433801 	subcs	r3, r3, r1, lsl #16
    93ec:	e1530781 	cmp	r3, r1, lsl #15
    93f0:	e0a00000 	adc	r0, r0, r0
    93f4:	20433781 	subcs	r3, r3, r1, lsl #15
    93f8:	e1530701 	cmp	r3, r1, lsl #14
    93fc:	e0a00000 	adc	r0, r0, r0
    9400:	20433701 	subcs	r3, r3, r1, lsl #14
    9404:	e1530681 	cmp	r3, r1, lsl #13
    9408:	e0a00000 	adc	r0, r0, r0
    940c:	20433681 	subcs	r3, r3, r1, lsl #13
    9410:	e1530601 	cmp	r3, r1, lsl #12
    9414:	e0a00000 	adc	r0, r0, r0
    9418:	20433601 	subcs	r3, r3, r1, lsl #12
    941c:	e1530581 	cmp	r3, r1, lsl #11
    9420:	e0a00000 	adc	r0, r0, r0
    9424:	20433581 	subcs	r3, r3, r1, lsl #11
    9428:	e1530501 	cmp	r3, r1, lsl #10
    942c:	e0a00000 	adc	r0, r0, r0
    9430:	20433501 	subcs	r3, r3, r1, lsl #10
    9434:	e1530481 	cmp	r3, r1, lsl #9
    9438:	e0a00000 	adc	r0, r0, r0
    943c:	20433481 	subcs	r3, r3, r1, lsl #9
    9440:	e1530401 	cmp	r3, r1, lsl #8
    9444:	e0a00000 	adc	r0, r0, r0
    9448:	20433401 	subcs	r3, r3, r1, lsl #8
    944c:	e1530381 	cmp	r3, r1, lsl #7
    9450:	e0a00000 	adc	r0, r0, r0
    9454:	20433381 	subcs	r3, r3, r1, lsl #7
    9458:	e1530301 	cmp	r3, r1, lsl #6
    945c:	e0a00000 	adc	r0, r0, r0
    9460:	20433301 	subcs	r3, r3, r1, lsl #6
    9464:	e1530281 	cmp	r3, r1, lsl #5
    9468:	e0a00000 	adc	r0, r0, r0
    946c:	20433281 	subcs	r3, r3, r1, lsl #5
    9470:	e1530201 	cmp	r3, r1, lsl #4
    9474:	e0a00000 	adc	r0, r0, r0
    9478:	20433201 	subcs	r3, r3, r1, lsl #4
    947c:	e1530181 	cmp	r3, r1, lsl #3
    9480:	e0a00000 	adc	r0, r0, r0
    9484:	20433181 	subcs	r3, r3, r1, lsl #3
    9488:	e1530101 	cmp	r3, r1, lsl #2
    948c:	e0a00000 	adc	r0, r0, r0
    9490:	20433101 	subcs	r3, r3, r1, lsl #2
    9494:	e1530081 	cmp	r3, r1, lsl #1
    9498:	e0a00000 	adc	r0, r0, r0
    949c:	20433081 	subcs	r3, r3, r1, lsl #1
    94a0:	e1530001 	cmp	r3, r1
    94a4:	e0a00000 	adc	r0, r0, r0
    94a8:	20433001 	subcs	r3, r3, r1
/builddir/build/BUILD/arm-none-eabi-gcc-cs-12.2.0/gcc-arm-none-eabi/arm-none-eabi/arm/v5te/hard/libgcc/../../../../../../gcc-12.2.0/libgcc/config/arm/lib1funcs.S:1315
    94ac:	e35c0000 	cmp	ip, #0
/builddir/build/BUILD/arm-none-eabi-gcc-cs-12.2.0/gcc-arm-none-eabi/arm-none-eabi/arm/v5te/hard/libgcc/../../../../../../gcc-12.2.0/libgcc/config/arm/lib1funcs.S:1317
    94b0:	42600000 	rsbmi	r0, r0, #0
/builddir/build/BUILD/arm-none-eabi-gcc-cs-12.2.0/gcc-arm-none-eabi/arm-none-eabi/arm/v5te/hard/libgcc/../../../../../../gcc-12.2.0/libgcc/config/arm/lib1funcs.S:1318
    94b4:	e12fff1e 	bx	lr
/builddir/build/BUILD/arm-none-eabi-gcc-cs-12.2.0/gcc-arm-none-eabi/arm-none-eabi/arm/v5te/hard/libgcc/../../../../../../gcc-12.2.0/libgcc/config/arm/lib1funcs.S:1320
    94b8:	e13c0000 	teq	ip, r0
/builddir/build/BUILD/arm-none-eabi-gcc-cs-12.2.0/gcc-arm-none-eabi/arm-none-eabi/arm/v5te/hard/libgcc/../../../../../../gcc-12.2.0/libgcc/config/arm/lib1funcs.S:1322
    94bc:	42600000 	rsbmi	r0, r0, #0
/builddir/build/BUILD/arm-none-eabi-gcc-cs-12.2.0/gcc-arm-none-eabi/arm-none-eabi/arm/v5te/hard/libgcc/../../../../../../gcc-12.2.0/libgcc/config/arm/lib1funcs.S:1323
    94c0:	e12fff1e 	bx	lr
/builddir/build/BUILD/arm-none-eabi-gcc-cs-12.2.0/gcc-arm-none-eabi/arm-none-eabi/arm/v5te/hard/libgcc/../../../../../../gcc-12.2.0/libgcc/config/arm/lib1funcs.S:1326
    94c4:	33a00000 	movcc	r0, #0
/builddir/build/BUILD/arm-none-eabi-gcc-cs-12.2.0/gcc-arm-none-eabi/arm-none-eabi/arm/v5te/hard/libgcc/../../../../../../gcc-12.2.0/libgcc/config/arm/lib1funcs.S:1328
    94c8:	01a00fcc 	asreq	r0, ip, #31
/builddir/build/BUILD/arm-none-eabi-gcc-cs-12.2.0/gcc-arm-none-eabi/arm-none-eabi/arm/v5te/hard/libgcc/../../../../../../gcc-12.2.0/libgcc/config/arm/lib1funcs.S:1329
    94cc:	03800001 	orreq	r0, r0, #1
/builddir/build/BUILD/arm-none-eabi-gcc-cs-12.2.0/gcc-arm-none-eabi/arm-none-eabi/arm/v5te/hard/libgcc/../../../../../../gcc-12.2.0/libgcc/config/arm/lib1funcs.S:1330
    94d0:	e12fff1e 	bx	lr
/builddir/build/BUILD/arm-none-eabi-gcc-cs-12.2.0/gcc-arm-none-eabi/arm-none-eabi/arm/v5te/hard/libgcc/../../../../../../gcc-12.2.0/libgcc/config/arm/lib1funcs.S:1332
    94d4:	e16f2f11 	clz	r2, r1
    94d8:	e262201f 	rsb	r2, r2, #31
/builddir/build/BUILD/arm-none-eabi-gcc-cs-12.2.0/gcc-arm-none-eabi/arm-none-eabi/arm/v5te/hard/libgcc/../../../../../../gcc-12.2.0/libgcc/config/arm/lib1funcs.S:1334
    94dc:	e35c0000 	cmp	ip, #0
/builddir/build/BUILD/arm-none-eabi-gcc-cs-12.2.0/gcc-arm-none-eabi/arm-none-eabi/arm/v5te/hard/libgcc/../../../../../../gcc-12.2.0/libgcc/config/arm/lib1funcs.S:1335
    94e0:	e1a00233 	lsr	r0, r3, r2
/builddir/build/BUILD/arm-none-eabi-gcc-cs-12.2.0/gcc-arm-none-eabi/arm-none-eabi/arm/v5te/hard/libgcc/../../../../../../gcc-12.2.0/libgcc/config/arm/lib1funcs.S:1337
    94e4:	42600000 	rsbmi	r0, r0, #0
/builddir/build/BUILD/arm-none-eabi-gcc-cs-12.2.0/gcc-arm-none-eabi/arm-none-eabi/arm/v5te/hard/libgcc/../../../../../../gcc-12.2.0/libgcc/config/arm/lib1funcs.S:1338
    94e8:	e12fff1e 	bx	lr
/builddir/build/BUILD/arm-none-eabi-gcc-cs-12.2.0/gcc-arm-none-eabi/arm-none-eabi/arm/v5te/hard/libgcc/../../../../../../gcc-12.2.0/libgcc/config/arm/lib1funcs.S:1342
    94ec:	e3500000 	cmp	r0, #0
    94f0:	c3e00102 	mvngt	r0, #-2147483648	; 0x80000000
    94f4:	b3a00102 	movlt	r0, #-2147483648	; 0x80000000
    94f8:	ea000007 	b	951c <__aeabi_idiv0>

000094fc <__aeabi_idivmod>:
__aeabi_idivmod():
/builddir/build/BUILD/arm-none-eabi-gcc-cs-12.2.0/gcc-arm-none-eabi/arm-none-eabi/arm/v5te/hard/libgcc/../../../../../../gcc-12.2.0/libgcc/config/arm/lib1funcs.S:1373
    94fc:	e3510000 	cmp	r1, #0
/builddir/build/BUILD/arm-none-eabi-gcc-cs-12.2.0/gcc-arm-none-eabi/arm-none-eabi/arm/v5te/hard/libgcc/../../../../../../gcc-12.2.0/libgcc/config/arm/lib1funcs.S:1374
    9500:	0afffff9 	beq	94ec <.divsi3_skip_div0_test+0x208>
/builddir/build/BUILD/arm-none-eabi-gcc-cs-12.2.0/gcc-arm-none-eabi/arm-none-eabi/arm/v5te/hard/libgcc/../../../../../../gcc-12.2.0/libgcc/config/arm/lib1funcs.S:1375
    9504:	e92d4003 	push	{r0, r1, lr}
/builddir/build/BUILD/arm-none-eabi-gcc-cs-12.2.0/gcc-arm-none-eabi/arm-none-eabi/arm/v5te/hard/libgcc/../../../../../../gcc-12.2.0/libgcc/config/arm/lib1funcs.S:1376
    9508:	ebffff75 	bl	92e4 <.divsi3_skip_div0_test>
/builddir/build/BUILD/arm-none-eabi-gcc-cs-12.2.0/gcc-arm-none-eabi/arm-none-eabi/arm/v5te/hard/libgcc/../../../../../../gcc-12.2.0/libgcc/config/arm/lib1funcs.S:1377
    950c:	e8bd4006 	pop	{r1, r2, lr}
/builddir/build/BUILD/arm-none-eabi-gcc-cs-12.2.0/gcc-arm-none-eabi/arm-none-eabi/arm/v5te/hard/libgcc/../../../../../../gcc-12.2.0/libgcc/config/arm/lib1funcs.S:1378
    9510:	e0030092 	mul	r3, r2, r0
/builddir/build/BUILD/arm-none-eabi-gcc-cs-12.2.0/gcc-arm-none-eabi/arm-none-eabi/arm/v5te/hard/libgcc/../../../../../../gcc-12.2.0/libgcc/config/arm/lib1funcs.S:1379
    9514:	e0411003 	sub	r1, r1, r3
/builddir/build/BUILD/arm-none-eabi-gcc-cs-12.2.0/gcc-arm-none-eabi/arm-none-eabi/arm/v5te/hard/libgcc/../../../../../../gcc-12.2.0/libgcc/config/arm/lib1funcs.S:1380
    9518:	e12fff1e 	bx	lr

0000951c <__aeabi_idiv0>:
__aeabi_ldiv0():
/builddir/build/BUILD/arm-none-eabi-gcc-cs-12.2.0/gcc-arm-none-eabi/arm-none-eabi/arm/v5te/hard/libgcc/../../../../../../gcc-12.2.0/libgcc/config/arm/lib1funcs.S:1466
    951c:	e12fff1e 	bx	lr

00009520 <memset>:
memset():
/builddir/build/BUILD/newlib-4.1.0/build-newlib/arm-none-eabi/arm/v5te/hard/newlib/libc/string/../../../../../../../../newlib/libc/string/memset.c:51
    9520:	e3100003 	tst	r0, #3
    9524:	0a00003f 	beq	9628 <memset+0x108>
/builddir/build/BUILD/newlib-4.1.0/build-newlib/arm-none-eabi/arm/v5te/hard/newlib/libc/string/../../../../../../../../newlib/libc/string/memset.c:53
    9528:	e3520000 	cmp	r2, #0
    952c:	e2422001 	sub	r2, r2, #1
    9530:	012fff1e 	bxeq	lr
/builddir/build/BUILD/newlib-4.1.0/build-newlib/arm-none-eabi/arm/v5te/hard/newlib/libc/string/../../../../../../../../newlib/libc/string/memset.c:54
    9534:	e201c0ff 	and	ip, r1, #255	; 0xff
/builddir/build/BUILD/newlib-4.1.0/build-newlib/arm-none-eabi/arm/v5te/hard/newlib/libc/string/../../../../../../../../newlib/libc/string/memset.c:42
    9538:	e1a03000 	mov	r3, r0
    953c:	ea000002 	b	954c <memset+0x2c>
/builddir/build/BUILD/newlib-4.1.0/build-newlib/arm-none-eabi/arm/v5te/hard/newlib/libc/string/../../../../../../../../newlib/libc/string/memset.c:53
    9540:	e2422001 	sub	r2, r2, #1
    9544:	e3720001 	cmn	r2, #1
    9548:	012fff1e 	bxeq	lr
/builddir/build/BUILD/newlib-4.1.0/build-newlib/arm-none-eabi/arm/v5te/hard/newlib/libc/string/../../../../../../../../newlib/libc/string/memset.c:54
    954c:	e4c3c001 	strb	ip, [r3], #1
/builddir/build/BUILD/newlib-4.1.0/build-newlib/arm-none-eabi/arm/v5te/hard/newlib/libc/string/../../../../../../../../newlib/libc/string/memset.c:51
    9550:	e3130003 	tst	r3, #3
    9554:	1afffff9 	bne	9540 <memset+0x20>
/builddir/build/BUILD/newlib-4.1.0/build-newlib/arm-none-eabi/arm/v5te/hard/newlib/libc/string/../../../../../../../../newlib/libc/string/memset.c:59
    9558:	e3520003 	cmp	r2, #3
    955c:	9a000027 	bls	9600 <memset+0xe0>
/builddir/build/BUILD/newlib-4.1.0/build-newlib/arm-none-eabi/arm/v5te/hard/newlib/libc/string/../../../../../../../../newlib/libc/string/memset.c:41
    9560:	e92d4030 	push	{r4, r5, lr}
/builddir/build/BUILD/newlib-4.1.0/build-newlib/arm-none-eabi/arm/v5te/hard/newlib/libc/string/../../../../../../../../newlib/libc/string/memset.c:48
    9564:	e201e0ff 	and	lr, r1, #255	; 0xff
/builddir/build/BUILD/newlib-4.1.0/build-newlib/arm-none-eabi/arm/v5te/hard/newlib/libc/string/../../../../../../../../newlib/libc/string/memset.c:66
    9568:	e18ee40e 	orr	lr, lr, lr, lsl #8
/builddir/build/BUILD/newlib-4.1.0/build-newlib/arm-none-eabi/arm/v5te/hard/newlib/libc/string/../../../../../../../../newlib/libc/string/memset.c:72
    956c:	e352000f 	cmp	r2, #15
/builddir/build/BUILD/newlib-4.1.0/build-newlib/arm-none-eabi/arm/v5te/hard/newlib/libc/string/../../../../../../../../newlib/libc/string/memset.c:67
    9570:	e18ee80e 	orr	lr, lr, lr, lsl #16
/builddir/build/BUILD/newlib-4.1.0/build-newlib/arm-none-eabi/arm/v5te/hard/newlib/libc/string/../../../../../../../../newlib/libc/string/memset.c:72
    9574:	9a00002d 	bls	9630 <memset+0x110>
    9578:	e242c010 	sub	ip, r2, #16
    957c:	e3cc400f 	bic	r4, ip, #15
    9580:	e2835020 	add	r5, r3, #32
    9584:	e0855004 	add	r5, r5, r4
    9588:	e1a0422c 	lsr	r4, ip, #4
    958c:	e283c010 	add	ip, r3, #16
/builddir/build/BUILD/newlib-4.1.0/build-newlib/arm-none-eabi/arm/v5te/hard/newlib/libc/string/../../../../../../../../newlib/libc/string/memset.c:74
    9590:	e50ce010 	str	lr, [ip, #-16]
/builddir/build/BUILD/newlib-4.1.0/build-newlib/arm-none-eabi/arm/v5te/hard/newlib/libc/string/../../../../../../../../newlib/libc/string/memset.c:75
    9594:	e50ce00c 	str	lr, [ip, #-12]
/builddir/build/BUILD/newlib-4.1.0/build-newlib/arm-none-eabi/arm/v5te/hard/newlib/libc/string/../../../../../../../../newlib/libc/string/memset.c:76
    9598:	e50ce008 	str	lr, [ip, #-8]
/builddir/build/BUILD/newlib-4.1.0/build-newlib/arm-none-eabi/arm/v5te/hard/newlib/libc/string/../../../../../../../../newlib/libc/string/memset.c:77
    959c:	e50ce004 	str	lr, [ip, #-4]
/builddir/build/BUILD/newlib-4.1.0/build-newlib/arm-none-eabi/arm/v5te/hard/newlib/libc/string/../../../../../../../../newlib/libc/string/memset.c:72
    95a0:	e28cc010 	add	ip, ip, #16
    95a4:	e15c0005 	cmp	ip, r5
    95a8:	1afffff8 	bne	9590 <memset+0x70>
/builddir/build/BUILD/newlib-4.1.0/build-newlib/arm-none-eabi/arm/v5te/hard/newlib/libc/string/../../../../../../../../newlib/libc/string/memset.c:77
    95ac:	e284c001 	add	ip, r4, #1
/builddir/build/BUILD/newlib-4.1.0/build-newlib/arm-none-eabi/arm/v5te/hard/newlib/libc/string/../../../../../../../../newlib/libc/string/memset.c:81
    95b0:	e312000c 	tst	r2, #12
/builddir/build/BUILD/newlib-4.1.0/build-newlib/arm-none-eabi/arm/v5te/hard/newlib/libc/string/../../../../../../../../newlib/libc/string/memset.c:77
    95b4:	e083c20c 	add	ip, r3, ip, lsl #4
/builddir/build/BUILD/newlib-4.1.0/build-newlib/arm-none-eabi/arm/v5te/hard/newlib/libc/string/../../../../../../../../newlib/libc/string/memset.c:78
    95b8:	e202200f 	and	r2, r2, #15
/builddir/build/BUILD/newlib-4.1.0/build-newlib/arm-none-eabi/arm/v5te/hard/newlib/libc/string/../../../../../../../../newlib/libc/string/memset.c:81
    95bc:	0a000017 	beq	9620 <memset+0x100>
    95c0:	e2423004 	sub	r3, r2, #4
    95c4:	e3c33003 	bic	r3, r3, #3
    95c8:	e2833004 	add	r3, r3, #4
    95cc:	e08c3003 	add	r3, ip, r3
/builddir/build/BUILD/newlib-4.1.0/build-newlib/arm-none-eabi/arm/v5te/hard/newlib/libc/string/../../../../../../../../newlib/libc/string/memset.c:83
    95d0:	e48ce004 	str	lr, [ip], #4
/builddir/build/BUILD/newlib-4.1.0/build-newlib/arm-none-eabi/arm/v5te/hard/newlib/libc/string/../../../../../../../../newlib/libc/string/memset.c:81
    95d4:	e153000c 	cmp	r3, ip
    95d8:	1afffffc 	bne	95d0 <memset+0xb0>
/builddir/build/BUILD/newlib-4.1.0/build-newlib/arm-none-eabi/arm/v5te/hard/newlib/libc/string/../../../../../../../../newlib/libc/string/memset.c:84
    95dc:	e2022003 	and	r2, r2, #3
/builddir/build/BUILD/newlib-4.1.0/build-newlib/arm-none-eabi/arm/v5te/hard/newlib/libc/string/../../../../../../../../newlib/libc/string/memset.c:92
    95e0:	e3520000 	cmp	r2, #0
    95e4:	08bd8030 	popeq	{r4, r5, pc}
/builddir/build/BUILD/newlib-4.1.0/build-newlib/arm-none-eabi/arm/v5te/hard/newlib/libc/string/../../../../../../../../newlib/libc/string/memset.c:54
    95e8:	e20110ff 	and	r1, r1, #255	; 0xff
    95ec:	e0832002 	add	r2, r3, r2
/builddir/build/BUILD/newlib-4.1.0/build-newlib/arm-none-eabi/arm/v5te/hard/newlib/libc/string/../../../../../../../../newlib/libc/string/memset.c:93
    95f0:	e4c31001 	strb	r1, [r3], #1
/builddir/build/BUILD/newlib-4.1.0/build-newlib/arm-none-eabi/arm/v5te/hard/newlib/libc/string/../../../../../../../../newlib/libc/string/memset.c:92
    95f4:	e1520003 	cmp	r2, r3
    95f8:	1afffffc 	bne	95f0 <memset+0xd0>
    95fc:	e8bd8030 	pop	{r4, r5, pc}
    9600:	e3520000 	cmp	r2, #0
    9604:	012fff1e 	bxeq	lr
/builddir/build/BUILD/newlib-4.1.0/build-newlib/arm-none-eabi/arm/v5te/hard/newlib/libc/string/../../../../../../../../newlib/libc/string/memset.c:54
    9608:	e20110ff 	and	r1, r1, #255	; 0xff
    960c:	e0832002 	add	r2, r3, r2
/builddir/build/BUILD/newlib-4.1.0/build-newlib/arm-none-eabi/arm/v5te/hard/newlib/libc/string/../../../../../../../../newlib/libc/string/memset.c:93
    9610:	e4c31001 	strb	r1, [r3], #1
/builddir/build/BUILD/newlib-4.1.0/build-newlib/arm-none-eabi/arm/v5te/hard/newlib/libc/string/../../../../../../../../newlib/libc/string/memset.c:92
    9614:	e1520003 	cmp	r2, r3
    9618:	1afffffc 	bne	9610 <memset+0xf0>
    961c:	e12fff1e 	bx	lr
/builddir/build/BUILD/newlib-4.1.0/build-newlib/arm-none-eabi/arm/v5te/hard/newlib/libc/string/../../../../../../../../newlib/libc/string/memset.c:77
    9620:	e1a0300c 	mov	r3, ip
    9624:	eaffffed 	b	95e0 <memset+0xc0>
/builddir/build/BUILD/newlib-4.1.0/build-newlib/arm-none-eabi/arm/v5te/hard/newlib/libc/string/../../../../../../../../newlib/libc/string/memset.c:42
    9628:	e1a03000 	mov	r3, r0
    962c:	eaffffc9 	b	9558 <memset+0x38>
/builddir/build/BUILD/newlib-4.1.0/build-newlib/arm-none-eabi/arm/v5te/hard/newlib/libc/string/../../../../../../../../newlib/libc/string/memset.c:72
    9630:	e1a0c003 	mov	ip, r3
    9634:	eaffffe1 	b	95c0 <memset+0xa0>

Disassembly of section .ARM.extab:

00009638 <.ARM.extab>:
    9638:	81019b40 	tsthi	r1, r0, asr #22
    963c:	8480b0b0 	strhi	fp, [r0], #176	; 0xb0
    9640:	00000000 	andeq	r0, r0, r0
    9644:	81019b41 	tsthi	r1, r1, asr #22
    9648:	8481b0b0 	strhi	fp, [r1], #176	; 0xb0
    964c:	00000000 	andeq	r0, r0, r0
    9650:	81019b40 	tsthi	r1, r0, asr #22
    9654:	8480b0b0 	strhi	fp, [r0], #176	; 0xb0
    9658:	00000000 	andeq	r0, r0, r0
    965c:	81019b40 	tsthi	r1, r0, asr #22
    9660:	8480b0b0 	strhi	fp, [r0], #176	; 0xb0
    9664:	00000000 	andeq	r0, r0, r0
    9668:	81019b40 	tsthi	r1, r0, asr #22
    966c:	8480b0b0 	strhi	fp, [r0], #176	; 0xb0
    9670:	00000000 	andeq	r0, r0, r0
    9674:	81019b40 	tsthi	r1, r0, asr #22
    9678:	8480b0b0 	strhi	fp, [r0], #176	; 0xb0
    967c:	00000000 	andeq	r0, r0, r0
    9680:	81019b40 	tsthi	r1, r0, asr #22
    9684:	8480b0b0 	strhi	fp, [r0], #176	; 0xb0
    9688:	00000000 	andeq	r0, r0, r0
    968c:	81019b40 	tsthi	r1, r0, asr #22
    9690:	8480b0b0 	strhi	fp, [r0], #176	; 0xb0
    9694:	00000000 	andeq	r0, r0, r0
    9698:	81019b40 	tsthi	r1, r0, asr #22
    969c:	8480b0b0 	strhi	fp, [r0], #176	; 0xb0
    96a0:	00000000 	andeq	r0, r0, r0
    96a4:	81019b40 	tsthi	r1, r0, asr #22
    96a8:	8480b0b0 	strhi	fp, [r0], #176	; 0xb0
    96ac:	00000000 	andeq	r0, r0, r0
    96b0:	81019b40 	tsthi	r1, r0, asr #22
    96b4:	8480b0b0 	strhi	fp, [r0], #176	; 0xb0
    96b8:	00000000 	andeq	r0, r0, r0

Disassembly of section .ARM.exidx:

000096bc <.ARM.exidx>:
    96bc:	7fffe95c 	svcvc	0x00ffe95c
    96c0:	00000001 	andeq	r0, r0, r1
    96c4:	7ffff0f4 	svcvc	0x00fff0f4
    96c8:	7fffff70 	svcvc	0x00ffff70
    96cc:	7ffff190 	svcvc	0x00fff190
    96d0:	7fffff74 	svcvc	0x00ffff74
    96d4:	7ffff1e4 	svcvc	0x00fff1e4
    96d8:	7fffff78 	svcvc	0x00ffff78
    96dc:	7ffff270 	svcvc	0x00fff270
    96e0:	7fffff7c 	svcvc	0x00ffff7c
    96e4:	7ffff2dc 	svcvc	0x00fff2dc
    96e8:	7fffff80 	svcvc	0x00ffff80
    96ec:	7ffff344 	svcvc	0x00fff344
    96f0:	7fffff84 	svcvc	0x00ffff84
    96f4:	7ffff410 	svcvc	0x00fff410
    96f8:	7fffff88 	svcvc	0x00ffff88
    96fc:	7ffff438 	svcvc	0x00fff438
    9700:	7fffff8c 	svcvc	0x00ffff8c
    9704:	7ffff4a8 	svcvc	0x00fff4a8
    9708:	00000001 	andeq	r0, r0, r1
    970c:	7ffff794 	svcvc	0x00fff794
    9710:	7fffff88 	svcvc	0x00ffff88
    9714:	7ffff8a4 	svcvc	0x00fff8a4
    9718:	00000001 	andeq	r0, r0, r1
    971c:	7ffff904 	svcvc	0x00fff904
    9720:	7fffff84 	svcvc	0x00ffff84
    9724:	7ffff954 	svcvc	0x00fff954
    9728:	7fffff88 	svcvc	0x00ffff88
    972c:	7ffff9a4 	svcvc	0x00fff9a4
    9730:	00000001 	andeq	r0, r0, r1

Disassembly of section .rodata:

00009734 <_ZN3halL15Peripheral_BaseE>:
    9734:	20000000 	andcs	r0, r0, r0

00009738 <_ZN3halL9GPIO_BaseE>:
    9738:	20200000 	eorcs	r0, r0, r0

0000973c <_ZN3halL14GPIO_Pin_CountE>:
    973c:	00000036 	andeq	r0, r0, r6, lsr r0

00009740 <_ZN3halL8AUX_BaseE>:
    9740:	20215000 	eorcs	r5, r1, r0

00009744 <_ZN3halL15Peripheral_BaseE>:
    9744:	20000000 	andcs	r0, r0, r0

00009748 <_ZN3halL9GPIO_BaseE>:
    9748:	20200000 	eorcs	r0, r0, r0

0000974c <_ZN3halL14GPIO_Pin_CountE>:
    974c:	00000036 	andeq	r0, r0, r6, lsr r0

00009750 <_ZN3halL8AUX_BaseE>:
    9750:	20215000 	eorcs	r5, r1, r0

00009754 <_ZN3halL15Peripheral_BaseE>:
    9754:	20000000 	andcs	r0, r0, r0

00009758 <_ZN3halL9GPIO_BaseE>:
    9758:	20200000 	eorcs	r0, r0, r0

0000975c <_ZN3halL14GPIO_Pin_CountE>:
    975c:	00000036 	andeq	r0, r0, r6, lsr r0

00009760 <_ZN3halL8AUX_BaseE>:
    9760:	20215000 	eorcs	r5, r1, r0

00009764 <_ZN3halL15Peripheral_BaseE>:
    9764:	20000000 	andcs	r0, r0, r0

00009768 <_ZN3halL9GPIO_BaseE>:
    9768:	20200000 	eorcs	r0, r0, r0

0000976c <_ZN3halL14GPIO_Pin_CountE>:
    976c:	00000036 	andeq	r0, r0, r6, lsr r0

00009770 <_ZN3halL8AUX_BaseE>:
    9770:	20215000 	eorcs	r5, r1, r0

00009774 <_ZL7ACT_Pin>:
    9774:	0000002f 	andeq	r0, r0, pc, lsr #32
    9778:	636c6557 	cmnvs	ip, #364904448	; 0x15c00000
    977c:	20656d6f 	rsbcs	r6, r5, pc, ror #26
    9780:	4b206f74 	blmi	825558 <_bss_end+0x81bd74>
    9784:	4f2f5649 	svcmi	0x002f5649
    9788:	50522053 	subspl	r2, r2, r3, asr r0
    978c:	20534f69 	subscs	r4, r3, r9, ror #30
    9790:	6e72656b 	cdpvs	5, 7, cr6, cr2, cr11, {3}
    9794:	0a0d6c65 	beq	364930 <_bss_end+0x35b14c>
    9798:	00000000 	andeq	r0, r0, r0
    979c:	6c736943 			; <UNDEFINED> instruction: 0x6c736943
    97a0:	656a206f 	strbvs	r2, [sl, #-111]!	; 0xffffff91
    97a4:	0000203a 	andeq	r2, r0, sl, lsr r0
    97a8:	00000a0d 	andeq	r0, r0, sp, lsl #20
    97ac:	6564615a 	strbvs	r6, [r4, #-346]!	; 0xfffffea6
    97b0:	6e7a206a 	cdpvs	0, 7, cr2, cr10, cr10, {3}
    97b4:	203a6b61 	eorscs	r6, sl, r1, ror #22
	...

Disassembly of section .data:

000097bc <__CTOR_LIST__>:
/builddir/build/BUILD/arm-none-eabi-gcc-cs-12.2.0/gcc-arm-none-eabi/arm-none-eabi/arm/v5te/hard/libgcc/../../../../../../gcc-12.2.0/libgcc/libgcc2.c:2448
    97bc:	0000829c 	muleq	r0, ip, r2
    97c0:	0000879c 	muleq	r0, ip, r7
    97c4:	00008c00 	andeq	r8, r0, r0, lsl #24

Disassembly of section .bss:

000097c8 <sAUX>:
/home/cf/ZCU/first_year/winter/OS/practical/ex3/kernel/src/drivers/bcm_aux.cpp:3
CAUX sAUX(hal::AUX_Base);
    97c8:	00000000 	andeq	r0, r0, r0

000097cc <sGPIO>:
/home/cf/ZCU/first_year/winter/OS/practical/ex3/kernel/src/drivers/gpio.cpp:4
CGPIO_Handler sGPIO(hal::GPIO_Base);
    97cc:	00000000 	andeq	r0, r0, r0

000097d0 <sUART0>:
	...

Disassembly of section .debug_info:

00000000 <.debug_info>:
       0:	0000011a 	andeq	r0, r0, sl, lsl r1
       4:	04010005 	streq	r0, [r1], #-5
       8:	00000000 	andeq	r0, r0, r0
       c:	00007606 	andeq	r7, r0, r6, lsl #12
      10:	01562100 	cmpeq	r6, r0, lsl #2
      14:	00000000 	andeq	r0, r0, r0
      18:	80180000 	andshi	r0, r8, r0
      1c:	00d80000 	sbcseq	r0, r8, r0
      20:	00000000 	andeq	r0, r0, r0
      24:	37010000 	strcc	r0, [r1, -r0]
      28:	29000001 	stmdbcs	r0, {r0}
      2c:	000080e4 	andeq	r8, r0, r4, ror #1
      30:	0000000c 	andeq	r0, r0, ip
      34:	24019c01 	strcs	r9, [r1], #-3073	; 0xfffff3ff
      38:	24000001 	strcs	r0, [r0], #-1
      3c:	000080cc 	andeq	r8, r0, ip, asr #1
      40:	00000018 	andeq	r0, r0, r8, lsl r0
      44:	69019c01 	stmdbvs	r1, {r0, sl, fp, ip, pc}
      48:	1f000000 	svcne	0x00000000
      4c:	000080b4 	strheq	r8, [r0], -r4
      50:	00000018 	andeq	r0, r0, r8, lsl r0
      54:	5c019c01 	stcpl	12, cr9, [r1], {1}
      58:	1a000000 	bne	60 <shift+0x60>
      5c:	0000809c 	muleq	r0, ip, r0
      60:	00000018 	andeq	r0, r0, r8, lsl r0
      64:	0b079c01 	bleq	1e7070 <_bss_end+0x1dd88c>
      68:	01000001 	tsteq	r0, r1
      6c:	00b10b02 	adcseq	r0, r1, r2, lsl #22
      70:	4a030000 	bmi	c0078 <_bss_end+0xb6894>
      74:	14000000 	strne	r0, [r0], #-0
      78:	00000082 	andeq	r0, r0, r2, lsl #1
      7c:	0000b102 	andeq	fp, r0, r2, lsl #2
      80:	4e080000 	cdpmi	0, 0, cr0, cr8, cr0, {0}
      84:	01000001 	tsteq	r0, r1
      88:	00b71c04 	adcseq	r1, r7, r4, lsl #24
      8c:	36030000 	strcc	r0, [r3], -r0
      90:	0f000000 	svceq	0x00000000
      94:	0000009e 	muleq	r0, lr, r0
      98:	0000b102 	andeq	fp, r0, r2, lsl #2
      9c:	f7090000 			; <UNDEFINED> instruction: 0xf7090000
      a0:	01000000 	mrseq	r0, (UNDEF: 0)
      a4:	00fa110a 	rscseq	r1, sl, sl, lsl #2
      a8:	b1020000 	mrslt	r0, (UNDEF: 2)
      ac:	00000000 	andeq	r0, r0, r0
      b0:	82040a00 	andhi	r0, r4, #0, 20
      b4:	0b000000 	bleq	bc <shift+0xbc>
      b8:	01160508 	tsteq	r6, r8, lsl #10
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
     110:	0a006705 	beq	19d2c <_bss_end+0x10548>
     114:	0000b12f 	andeq	fp, r0, pc, lsr #2
     118:	74910200 	ldrvc	r0, [r1], #512	; 0x200
     11c:	03d40000 	bicseq	r0, r4, #0
     120:	00050000 	andeq	r0, r5, r0
     124:	00d40401 	sbcseq	r0, r4, r1, lsl #8
     128:	760e0000 	strvc	r0, [lr], -r0
     12c:	21000000 	mrscs	r0, (UNDEF: 0)
     130:	000002eb 	andeq	r0, r0, fp, ror #5
     134:	00000000 	andeq	r0, r0, r0
     138:	000080f0 	strdeq	r8, [r0], -r0
     13c:	000001c8 	andeq	r0, r0, r8, asr #3
     140:	00000096 	muleq	r0, r6, r0
     144:	e6080103 	str	r0, [r8], -r3, lsl #2
     148:	03000002 	movweq	r0, #2
     14c:	01990502 	orrseq	r0, r9, r2, lsl #10
     150:	040f0000 	streq	r0, [pc], #-0	; 158 <shift+0x158>
     154:	746e6905 	strbtvc	r6, [lr], #-2309	; 0xfffff6fb
     158:	08010300 	stmdaeq	r1, {r8, r9}
     15c:	000002dd 	ldrdeq	r0, [r0], -sp
     160:	96070203 	strls	r0, [r7], -r3, lsl #4
     164:	10000003 	andne	r0, r0, r3
     168:	0000035f 	andeq	r0, r0, pc, asr r3
     16c:	5a070b04 	bpl	1c2d84 <_bss_end+0x1b95a0>
     170:	06000000 	streq	r0, [r0], -r0
     174:	00000049 	andeq	r0, r0, r9, asr #32
     178:	12070403 	andne	r0, r7, #50331648	; 0x3000000
     17c:	1100000f 	tstne	r0, pc
     180:	006c6168 	rsbeq	r6, ip, r8, ror #2
     184:	630b0702 	movwvs	r0, #46850	; 0xb702
     188:	09000001 	stmdbeq	r0, {r0}
     18c:	000002a1 	andeq	r0, r0, r1, lsr #5
     190:	00016a0a 	andeq	r6, r1, sl, lsl #20
     194:	00000000 	andeq	r0, r0, r0
     198:	03480920 	movteq	r0, #35104	; 0x8920
     19c:	6a0d0000 	bvs	3401a4 <_bss_end+0x3369c0>
     1a0:	00000001 	andeq	r0, r0, r1
     1a4:	12202000 	eorne	r2, r0, #0
     1a8:	000003d4 	ldrdeq	r0, [r0], -r4
     1ac:	55151002 	ldrpl	r1, [r5, #-2]
     1b0:	36000000 	strcc	r0, [r0], -r0
     1b4:	00043109 	andeq	r3, r4, r9, lsl #2
     1b8:	016a4200 	cmneq	sl, r0, lsl #4
     1bc:	50000000 	andpl	r0, r0, r0
     1c0:	b8132021 	ldmdalt	r3, {r0, r5, sp}
     1c4:	05000001 	streq	r0, [r0, #-1]
     1c8:	00003404 	andeq	r3, r0, r4, lsl #8
     1cc:	0d440200 	sfmeq	f0, 2, [r4, #-0]
     1d0:	00000141 	andeq	r0, r0, r1, asr #2
     1d4:	51524914 	cmppl	r2, r4, lsl r9
     1d8:	f5010000 			; <UNDEFINED> instruction: 0xf5010000
     1dc:	01000001 	tsteq	r0, r1
     1e0:	00023501 	andeq	r3, r2, r1, lsl #10
     1e4:	3a011000 	bcc	441ec <_bss_end+0x3aa08>
     1e8:	11000003 	tstne	r0, r3
     1ec:	00037d01 	andeq	r7, r3, r1, lsl #26
     1f0:	b1011200 	mrslt	r1, R9_usr
     1f4:	13000003 	movwne	r0, #3
     1f8:	00034101 	andeq	r4, r3, r1, lsl #2
     1fc:	5a011400 	bpl	45204 <_bss_end+0x3ba20>
     200:	15000004 	strne	r0, [r0, #-4]
     204:	00042a01 	andeq	r2, r4, r1, lsl #20
     208:	92011600 	andls	r1, r1, #0, 12
     20c:	17000004 	strne	r0, [r0, -r4]
     210:	00038401 	andeq	r8, r3, r1, lsl #8
     214:	3a011800 	bcc	4621c <_bss_end+0x3ca38>
     218:	19000004 	stmdbne	r0, {r2}
     21c:	0003c201 	andeq	ip, r3, r1, lsl #4
     220:	8b011a00 	blhi	46a28 <_bss_end+0x3d244>
     224:	20000002 	andcs	r0, r0, r2
     228:	00029601 	andeq	r9, r2, r1, lsl #12
     22c:	ca012100 	bgt	48634 <_bss_end+0x3ee50>
     230:	22000003 	andcs	r0, r0, #3
     234:	00026f01 	andeq	r6, r2, r1, lsl #30
     238:	b8012400 	stmdalt	r1, {sl, sp}
     23c:	25000003 	strcs	r0, [r0, #-3]
     240:	0002c001 	andeq	ip, r2, r1
     244:	cb013000 	blgt	4c24c <_bss_end+0x42a68>
     248:	31000002 	tstcc	r0, r2
     24c:	0001ad01 	andeq	sl, r1, r1, lsl #26
     250:	a9013200 	stmdbge	r1, {r9, ip, sp}
     254:	34000003 	strcc	r0, [r0], #-3
     258:	0001a301 	andeq	sl, r1, r1, lsl #6
     25c:	15003500 	strne	r3, [r0, #-1280]	; 0xfffffb00
     260:	00000225 	andeq	r0, r0, r5, lsr #4
     264:	00340405 	eorseq	r0, r4, r5, lsl #8
     268:	6a020000 	bvs	80270 <_bss_end+0x76a8c>
     26c:	0451010d 	ldrbeq	r0, [r1], #-269	; 0xfffffef3
     270:	01000000 	mrseq	r0, (UNDEF: 0)
     274:	0000038c 	andeq	r0, r0, ip, lsl #7
     278:	03910101 	orrseq	r0, r1, #1073741824	; 0x40000000
     27c:	00020000 	andeq	r0, r2, r0
     280:	07040300 	streq	r0, [r4, -r0, lsl #6]
     284:	00000f0d 	andeq	r0, r0, sp, lsl #30
     288:	00016306 	andeq	r6, r1, r6, lsl #6
     28c:	006d0700 	rsbeq	r0, sp, r0, lsl #14
     290:	7b070000 	blvc	1c0298 <_bss_end+0x1b6ab4>
     294:	07000000 	streq	r0, [r0, -r0]
     298:	00000089 	andeq	r0, r0, r9, lsl #1
     29c:	00009607 	andeq	r9, r0, r7, lsl #12
     2a0:	08911600 	ldmeq	r1, {r9, sl, ip}
     2a4:	03040000 	movweq	r0, #16384	; 0x4000
     2a8:	023e0706 	eorseq	r0, lr, #1572864	; 0x180000
     2ac:	b7170000 	ldrlt	r0, [r7, -r0]
     2b0:	03000001 	movweq	r0, #1
     2b4:	02431d0a 	subeq	r1, r3, #640	; 0x280
     2b8:	18000000 	stmdane	r0, {}	; <UNPREDICTABLE>
     2bc:	00000891 	muleq	r0, r1, r8
     2c0:	3b090d03 	blcc	2436d4 <_bss_end+0x239ef0>
     2c4:	48000002 	stmdami	r0, {r1}
     2c8:	01000002 	tsteq	r0, r2
     2cc:	000001b6 			; <UNDEFINED> instruction: 0x000001b6
     2d0:	000001c1 	andeq	r0, r0, r1, asr #3
     2d4:	00024805 	andeq	r4, r2, r5, lsl #16
     2d8:	005a0400 	subseq	r0, sl, r0, lsl #8
     2dc:	0a000000 	beq	2e4 <shift+0x2e4>
     2e0:	000002d6 	ldrdeq	r0, [r0], -r6
     2e4:	0001fd10 	andeq	pc, r1, r0, lsl sp	; <UNPREDICTABLE>
     2e8:	0001d300 	andeq	sp, r1, r0, lsl #6
     2ec:	0001de00 	andeq	sp, r1, r0, lsl #28
     2f0:	02480500 	subeq	r0, r8, #0, 10
     2f4:	41040000 	mrsmi	r0, (UNDEF: 4)
     2f8:	00000001 	andeq	r0, r0, r1
     2fc:	0003680a 	andeq	r6, r3, sl, lsl #16
     300:	04691200 	strbteq	r1, [r9], #-512	; 0xfffffe00
     304:	01f00000 	mvnseq	r0, r0
     308:	01fb0000 	mvnseq	r0, r0
     30c:	48050000 	stmdami	r5, {}	; <UNPREDICTABLE>
     310:	04000002 	streq	r0, [r0], #-2
     314:	00000141 	andeq	r0, r0, r1, asr #2
     318:	041d0a00 	ldreq	r0, [sp], #-2560	; 0xfffff600
     31c:	48150000 	ldmdami	r5, {}	; <UNPREDICTABLE>
     320:	0d000002 	stceq	0, cr0, [r0, #-8]
     324:	1d000002 	stcne	0, cr0, [r0, #-8]
     328:	05000002 	streq	r0, [r0, #-2]
     32c:	00000248 	andeq	r0, r0, r8, asr #4
     330:	0000a404 	andeq	sl, r0, r4, lsl #8
     334:	00490400 	subeq	r0, r9, r0, lsl #8
     338:	19000000 	stmdbne	r0, {}	; <UNPREDICTABLE>
     33c:	00000370 	andeq	r0, r0, r0, ror r3
     340:	c0121703 	andsgt	r1, r2, r3, lsl #14
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
     370:	0002861a 	andeq	r8, r2, sl, lsl r6
     374:	0d1a0300 	ldceq	3, cr0, [sl, #-0]
     378:	00000183 	andeq	r0, r0, r3, lsl #3
     37c:	0002521b 	andeq	r5, r2, fp, lsl r2
     380:	06030100 	streq	r0, [r3], -r0, lsl #2
     384:	97c80305 	strbls	r0, [r8, r5, lsl #6]
     388:	771c0000 	ldrvc	r0, [ip, -r0]
     38c:	9c000002 	stcls	0, cr0, [r0], {2}
     390:	1c000082 	stcne	0, cr0, [r0], {130}	; 0x82
     394:	01000000 	mrseq	r0, (UNDEF: 0)
     398:	03e31d9c 	mvneq	r1, #156, 26	; 0x2700
     39c:	82480000 	subhi	r0, r8, #0
     3a0:	00540000 	subseq	r0, r4, r0
     3a4:	9c010000 	stcls	0, cr0, [r1], {-0}
     3a8:	000002ab 	andeq	r0, r0, fp, lsr #5
     3ac:	0002b102 	andeq	fp, r2, r2, lsl #2
     3b0:	34011d00 	strcc	r1, [r1], #-3328	; 0xfffff300
     3b4:	02000000 	andeq	r0, r0, #0
     3b8:	0d027491 	cfstrseq	mvf7, [r2, #-580]	; 0xfffffdbc
     3bc:	1d000004 	stcne	0, cr0, [r0, #-16]
     3c0:	00003401 	andeq	r3, r0, r1, lsl #8
     3c4:	70910200 	addsvc	r0, r1, r0, lsl #4
     3c8:	021d1e00 	andseq	r1, sp, #0, 28
     3cc:	1a010000 	bne	403d4 <_bss_end+0x36bf0>
     3d0:	0002c50a 	andeq	ip, r2, sl, lsl #10
     3d4:	00820c00 	addeq	r0, r2, r0, lsl #24
     3d8:	00003c00 	andeq	r3, r0, r0, lsl #24
     3dc:	e09c0100 	adds	r0, ip, r0, lsl #2
     3e0:	08000002 	stmdaeq	r0, {r1}
     3e4:	00000418 	andeq	r0, r0, r8, lsl r4
     3e8:	0000024d 	andeq	r0, r0, sp, asr #4
     3ec:	02749102 	rsbseq	r9, r4, #-2147483648	; 0x80000000
     3f0:	00000461 	andeq	r0, r0, r1, ror #8
     3f4:	00a42a1a 	adceq	r2, r4, sl, lsl sl
     3f8:	91020000 	mrsls	r0, (UNDEF: 2)
     3fc:	fb1f0070 	blx	7c05c6 <_bss_end+0x7b6de2>
     400:	01000001 	tsteq	r0, r1
     404:	0002f906 	andeq	pc, r2, r6, lsl #18
     408:	0081c800 	addeq	ip, r1, r0, lsl #16
     40c:	00004400 	andeq	r4, r0, r0, lsl #8
     410:	229c0100 	addscs	r0, ip, #0, 2
     414:	08000003 	stmdaeq	r0, {r0, r1}
     418:	00000418 	andeq	r0, r0, r8, lsl r4
     41c:	0000024d 	andeq	r0, r0, sp, asr #4
     420:	02749102 	rsbseq	r9, r4, #-2147483648	; 0x80000000
     424:	00000461 	andeq	r0, r0, r1, ror #8
     428:	00a42615 	adceq	r2, r4, r5, lsl r6
     42c:	91020000 	mrsls	r0, (UNDEF: 2)
     430:	01e60270 	mvneq	r0, r0, ror r2
     434:	38150000 	ldmdacc	r5, {}	; <UNPREDICTABLE>
     438:	00000049 	andeq	r0, r0, r9, asr #32
     43c:	006c9102 	rsbeq	r9, ip, r2, lsl #2
     440:	0001de0c 	andeq	sp, r1, ip, lsl #28
     444:	033a1000 	teqeq	sl, #0
     448:	81740000 	cmnhi	r4, r0
     44c:	00540000 	subseq	r0, r4, r0
     450:	9c010000 	stcls	0, cr0, [r1], {-0}
     454:	00000355 	andeq	r0, r0, r5, asr r3
     458:	00041808 	andeq	r1, r4, r8, lsl #16
     45c:	00024d00 	andeq	r4, r2, r0, lsl #26
     460:	74910200 	ldrvc	r0, [r1], #512	; 0x200
     464:	00044202 	andeq	r4, r4, r2, lsl #4
     468:	41291000 			; <UNDEFINED> instruction: 0x41291000
     46c:	02000001 	andeq	r0, r0, #1
     470:	0c007091 	stceq	0, cr7, [r0], {145}	; 0x91
     474:	000001c1 	andeq	r0, r0, r1, asr #3
     478:	00036d0b 	andeq	r6, r3, fp, lsl #26
     47c:	00812400 	addeq	r2, r1, r0, lsl #8
     480:	00005000 	andeq	r5, r0, r0
     484:	889c0100 	ldmhi	ip, {r8}
     488:	08000003 	stmdaeq	r0, {r0, r1}
     48c:	00000418 	andeq	r0, r0, r8, lsl r4
     490:	0000024d 	andeq	r0, r0, sp, asr #4
     494:	02749102 	rsbseq	r9, r4, #-2147483648	; 0x80000000
     498:	00000442 	andeq	r0, r0, r2, asr #8
     49c:	0141280b 	cmpeq	r1, fp, lsl #16
     4a0:	91020000 	mrsls	r0, (UNDEF: 2)
     4a4:	9d200070 	stcls	0, cr0, [r0, #-448]!	; 0xfffffe40
     4a8:	01000001 	tsteq	r0, r1
     4ac:	03990105 	orrseq	r0, r9, #1073741825	; 0x40000001
     4b0:	af000000 	svcge	0x00000000
     4b4:	21000003 	tstcs	r0, r3
     4b8:	00000418 	andeq	r0, r0, r8, lsl r4
     4bc:	0000024d 	andeq	r0, r0, sp, asr #4
     4c0:	0001ec22 	andeq	lr, r1, r2, lsr #24
     4c4:	19050100 	stmdbne	r5, {r8}
     4c8:	0000005a 	andeq	r0, r0, sl, asr r0
     4cc:	03882300 	orreq	r2, r8, #0, 6
     4d0:	03520000 	cmpeq	r2, #0
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
     500:	76130000 	ldrvc	r0, [r3], -r0
     504:	21000000 	mrscs	r0, (UNDEF: 0)
     508:	00000677 	andeq	r0, r0, r7, ror r6
     50c:	00000000 	andeq	r0, r0, r0
     510:	000082b8 			; <UNDEFINED> instruction: 0x000082b8
     514:	00000500 	andeq	r0, r0, r0, lsl #10
     518:	0000022e 	andeq	r0, r0, lr, lsr #4
     51c:	e6080105 	str	r0, [r8], -r5, lsl #2
     520:	05000002 	streq	r0, [r0, #-2]
     524:	01990502 	orrseq	r0, r9, r2, lsl #10
     528:	04140000 	ldreq	r0, [r4], #-0
     52c:	746e6905 	strbtvc	r6, [lr], #-2309	; 0xfffff6fb
     530:	05a81000 	streq	r1, [r8, #0]!
     534:	45090000 	strmi	r0, [r9, #-0]
     538:	05000000 	streq	r0, [r0, #-0]
     53c:	02dd0801 	sbcseq	r0, sp, #65536	; 0x10000
     540:	02050000 	andeq	r0, r5, #0
     544:	00039607 	andeq	r9, r3, r7, lsl #12
     548:	035f1000 	cmpeq	pc, #0
     54c:	620b0000 	andvs	r0, fp, #0
     550:	08000000 	stmdaeq	r0, {}	; <UNPREDICTABLE>
     554:	00000053 	andeq	r0, r0, r3, asr r0
     558:	12070405 	andne	r0, r7, #83886080	; 0x5000000
     55c:	1500000f 	strne	r0, [r0, #-15]
     560:	006c6168 	rsbeq	r6, ip, r8, ror #2
     564:	6e0b0703 	cdpvs	7, 0, cr0, cr11, cr3, {0}
     568:	0d000001 	stceq	0, cr0, [r0, #-4]
     56c:	000002a1 	andeq	r0, r0, r1, lsr #5
     570:	0001750a 	andeq	r7, r1, sl, lsl #10
     574:	00000000 	andeq	r0, r0, r0
     578:	03480d20 	movteq	r0, #36128	; 0x8d20
     57c:	750d0000 	strvc	r0, [sp, #-0]
     580:	00000001 	andeq	r0, r0, r1
     584:	16202000 	strtne	r2, [r0], -r0
     588:	000003d4 	ldrdeq	r0, [r0], -r4
     58c:	5d151003 	ldcpl	0, cr1, [r5, #-12]
     590:	36000000 	strcc	r0, [r0], -r0
     594:	00075611 	andeq	r5, r7, r1, lsl r6
     598:	34040500 	strcc	r0, [r4], #-1280	; 0xfffffb00
     59c:	03000000 	movweq	r0, #0
     5a0:	015f0d13 	cmpeq	pc, r3, lsl sp	; <UNPREDICTABLE>
     5a4:	da010000 	ble	405ac <_bss_end+0x36dc8>
     5a8:	00000004 	andeq	r0, r0, r4
     5ac:	0004e201 	andeq	lr, r4, r1, lsl #4
     5b0:	ea010100 	b	409b8 <_bss_end+0x371d4>
     5b4:	02000004 	andeq	r0, r0, #4
     5b8:	0004f201 	andeq	pc, r4, r1, lsl #4
     5bc:	fa010300 	blx	411c4 <_bss_end+0x379e0>
     5c0:	04000004 	streq	r0, [r0], #-4
     5c4:	00050201 	andeq	r0, r5, r1, lsl #4
     5c8:	cc010500 	cfstr32gt	mvfx0, [r1], {-0}
     5cc:	07000004 	streq	r0, [r0, -r4]
     5d0:	0004d301 	andeq	sp, r4, r1, lsl #6
     5d4:	37010800 	strcc	r0, [r1, -r0, lsl #16]
     5d8:	0a000008 	beq	600 <shift+0x600>
     5dc:	00070701 	andeq	r0, r7, r1, lsl #14
     5e0:	97010b00 	strls	r0, [r1, -r0, lsl #22]
     5e4:	0d000007 	stceq	0, cr0, [r0, #-28]	; 0xffffffe4
     5e8:	00079e01 	andeq	r9, r7, r1, lsl #28
     5ec:	b0010e00 	andlt	r0, r1, r0, lsl #28
     5f0:	10000005 	andne	r0, r0, r5
     5f4:	0005b701 	andeq	fp, r5, r1, lsl #14
     5f8:	2b011100 	blcs	44a00 <_bss_end+0x3b21c>
     5fc:	13000005 	movwne	r0, #5
     600:	00053201 	andeq	r3, r5, r1, lsl #4
     604:	01011400 	tsteq	r1, r0, lsl #8
     608:	16000008 	strne	r0, [r0], -r8
     60c:	00050a01 	andeq	r0, r5, r1, lsl #20
     610:	1e011700 	cdpne	7, 0, cr1, cr1, cr0, {0}
     614:	19000007 	stmdbne	r0, {r0, r1, r2}
     618:	00072501 	andeq	r2, r7, r1, lsl #10
     61c:	cf011a00 	svcgt	0x00011a00
     620:	1c000005 	stcne	0, cr0, [r0], {5}
     624:	00073b01 	andeq	r3, r7, r1, lsl #22
     628:	0e011d00 	cdpeq	13, 0, cr1, cr1, cr0, {0}
     62c:	1f000007 	svcne	0x00000007
     630:	00071601 	andeq	r1, r7, r1, lsl #12
     634:	67012000 	strvs	r2, [r1, -r0]
     638:	22000006 	andcs	r0, r0, #6
     63c:	00066f01 	andeq	r6, r6, r1, lsl #30
     640:	0e012300 	cdpeq	3, 0, cr2, cr1, cr0, {0}
     644:	25000006 	strcs	r0, [r0, #-6]
     648:	00051701 	andeq	r1, r5, r1, lsl #14
     64c:	21012600 	tstcs	r1, r0, lsl #12
     650:	27000005 	strcs	r0, [r0, -r5]
     654:	04310d00 	ldrteq	r0, [r1], #-3328	; 0xfffff300
     658:	75420000 	strbvc	r0, [r2, #-0]
     65c:	00000001 	andeq	r0, r0, r1
     660:	00202150 	eoreq	r2, r0, r0, asr r1
     664:	0d070405 	cfstrseq	mvf0, [r7, #-20]	; 0xffffffec
     668:	0800000f 	stmdaeq	r0, {r0, r1, r2, r3}
     66c:	0000016e 	andeq	r0, r0, lr, ror #2
     670:	0000750b 	andeq	r7, r0, fp, lsl #10
     674:	00830b00 	addeq	r0, r3, r0, lsl #22
     678:	910b0000 	mrsls	r0, (UNDEF: 11)
     67c:	0b000000 	bleq	684 <shift+0x684>
     680:	0000015f 	andeq	r0, r0, pc, asr r1
     684:	00078811 	andeq	r8, r7, r1, lsl r8
     688:	3b010700 	blcc	42290 <_bss_end+0x38aac>
     68c:	04000000 	streq	r0, [r0], #-0
     690:	01d70c06 	bicseq	r0, r7, r6, lsl #24
     694:	11010000 	mrsne	r0, (UNDEF: 1)
     698:	00000005 	andeq	r0, r0, r5
     69c:	00080c01 	andeq	r0, r8, r1, lsl #24
     6a0:	31010100 	mrscc	r0, (UNDEF: 17)
     6a4:	02000008 	andeq	r0, r0, #8
     6a8:	00082b01 	andeq	r2, r8, r1, lsl #22
     6ac:	13010300 	movwne	r0, #4864	; 0x1300
     6b0:	04000008 	streq	r0, [r0], #-8
     6b4:	00081901 	andeq	r1, r8, r1, lsl #18
     6b8:	1f010500 	svcne	0x00010500
     6bc:	06000008 	streq	r0, [r0], -r8
     6c0:	00082501 	andeq	r2, r8, r1, lsl #10
     6c4:	c3010700 	movwgt	r0, #5888	; 0x1700
     6c8:	08000005 	stmdaeq	r0, {r0, r2}
     6cc:	05ed1700 	strbeq	r1, [sp, #1792]!	; 0x700
     6d0:	04040000 	streq	r0, [r4], #-0
     6d4:	0332071a 	teqeq	r2, #6815744	; 0x680000
     6d8:	8b180000 	blhi	6006e0 <_bss_end+0x5f6efc>
     6dc:	04000005 	streq	r0, [r0], #-5
     6e0:	033c171e 	teqeq	ip, #7864320	; 0x780000
     6e4:	09000000 	stmdbeq	r0, {}	; <UNPREDICTABLE>
     6e8:	00000742 	andeq	r0, r0, r2, asr #14
     6ec:	055b0822 	ldrbeq	r0, [fp, #-2082]	; 0xfffff7de
     6f0:	03410000 	movteq	r0, #4096	; 0x1000
     6f4:	09020000 	stmdbeq	r2, {}	; <UNPREDICTABLE>
     6f8:	1e000002 	cdpne	0, 0, cr0, cr0, cr2, {0}
     6fc:	04000002 	streq	r0, [r0], #-2
     700:	00000348 	andeq	r0, r0, r8, asr #6
     704:	00005302 	andeq	r5, r0, r2, lsl #6
     708:	03520200 	cmpeq	r2, #0, 4
     70c:	52020000 	andpl	r0, r2, #0
     710:	00000003 	andeq	r0, r0, r3
     714:	0007ee09 	andeq	lr, r7, r9, lsl #28
     718:	c3082400 	movwgt	r2, #33792	; 0x8400
     71c:	41000006 	tstmi	r0, r6
     720:	02000003 	andeq	r0, r0, #3
     724:	00000236 	andeq	r0, r0, r6, lsr r2
     728:	0000024b 	andeq	r0, r0, fp, asr #4
     72c:	00034804 	andeq	r4, r3, r4, lsl #16
     730:	00530200 	subseq	r0, r3, r0, lsl #4
     734:	52020000 	andpl	r0, r2, #0
     738:	02000003 	andeq	r0, r0, #3
     73c:	00000352 	andeq	r0, r0, r2, asr r3
     740:	05fb0900 	ldrbeq	r0, [fp, #2304]!	; 0x900
     744:	08260000 	stmdaeq	r6!, {}	; <UNPREDICTABLE>
     748:	000007bf 			; <UNDEFINED> instruction: 0x000007bf
     74c:	00000341 	andeq	r0, r0, r1, asr #6
     750:	00026302 	andeq	r6, r2, r2, lsl #6
     754:	00027800 	andeq	r7, r2, r0, lsl #16
     758:	03480400 	movteq	r0, #33792	; 0x8400
     75c:	53020000 	movwpl	r0, #8192	; 0x2000
     760:	02000000 	andeq	r0, r0, #0
     764:	00000352 	andeq	r0, r0, r2, asr r3
     768:	00035202 	andeq	r5, r3, r2, lsl #4
     76c:	14090000 	strne	r0, [r9], #-0
     770:	28000006 	stmdacs	r0, {r1, r2}
     774:	00049d08 	andeq	r9, r4, r8, lsl #26
     778:	00034100 	andeq	r4, r3, r0, lsl #2
     77c:	02900200 	addseq	r0, r0, #0, 4
     780:	02a50000 	adceq	r0, r5, #0
     784:	48040000 	stmdami	r4, {}	; <UNPREDICTABLE>
     788:	02000003 	andeq	r0, r0, #3
     78c:	00000053 	andeq	r0, r0, r3, asr r0
     790:	00035202 	andeq	r5, r3, r2, lsl #4
     794:	03520200 	cmpeq	r2, #0, 4
     798:	09000000 	stmdbeq	r0, {}	; <UNPREDICTABLE>
     79c:	000005ed 	andeq	r0, r0, sp, ror #11
     7a0:	0591032b 	ldreq	r0, [r1, #811]	; 0x32b
     7a4:	03580000 	cmpeq	r8, #0
     7a8:	bd010000 	stclt	0, cr0, [r1, #-0]
     7ac:	c8000002 	stmdagt	r0, {r1}
     7b0:	04000002 	streq	r0, [r0], #-2
     7b4:	00000358 	andeq	r0, r0, r8, asr r3
     7b8:	00006202 	andeq	r6, r0, r2, lsl #4
     7bc:	a5190000 	ldrge	r0, [r9, #-0]
     7c0:	04000007 	streq	r0, [r0], #-7
     7c4:	075f082e 	ldrbeq	r0, [pc, -lr, lsr #16]
     7c8:	dd010000 	stcle	0, cr0, [r1, #-0]
     7cc:	ed000002 	stc	0, cr0, [r0, #-8]
     7d0:	04000002 	streq	r0, [r0], #-2
     7d4:	00000358 	andeq	r0, r0, r8, asr r3
     7d8:	00005302 	andeq	r5, r0, r2, lsl #6
     7dc:	018e0200 	orreq	r0, lr, r0, lsl #4
     7e0:	09000000 	stmdbeq	r0, {}	; <UNPREDICTABLE>
     7e4:	000005db 	ldrdeq	r0, [r0], -fp
     7e8:	06271230 			; <UNDEFINED> instruction: 0x06271230
     7ec:	018e0000 	orreq	r0, lr, r0
     7f0:	05010000 	streq	r0, [r1, #-0]
     7f4:	10000003 	andne	r0, r0, r3
     7f8:	04000003 	streq	r0, [r0], #-3
     7fc:	00000348 	andeq	r0, r0, r8, asr #6
     800:	00005302 	andeq	r5, r0, r2, lsl #6
     804:	081a0000 	ldmdaeq	sl, {}	; <UNPREDICTABLE>
     808:	04000008 	streq	r0, [r0], #-8
     80c:	05390833 	ldreq	r0, [r9, #-2099]!	; 0xfffff7cd
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
     838:	05be0201 	ldreq	r0, [lr, #513]!	; 0x201
     83c:	320e0000 	andcc	r0, lr, #0
     840:	08000003 	stmdaeq	r0, {r0, r1}
     844:	00000348 	andeq	r0, r0, r8, asr #6
     848:	0053041b 	subseq	r0, r3, fp, lsl r4
     84c:	d70e0000 	strle	r0, [lr, -r0]
     850:	08000001 	stmdaeq	r0, {r0}
     854:	00000358 	andeq	r0, r0, r8, asr r3
     858:	0007011c 	andeq	r0, r7, ip, lsl r1
     85c:	16370400 	ldrtne	r0, [r7], -r0, lsl #8
     860:	000001d7 	ldrdeq	r0, [r0], -r7
     864:	0003621d 	andeq	r6, r3, sp, lsl r2
     868:	0f040100 	svceq	0x00040100
     86c:	97cc0305 	strbls	r0, [ip, r5, lsl #6]
     870:	f21e0000 	vhadd.s16	d0, d14, d0
     874:	9c000006 	stcls	0, cr0, [r0], {6}
     878:	1c000087 	stcne	0, cr0, [r0], {135}	; 0x87
     87c:	01000000 	mrseq	r0, (UNDEF: 0)
     880:	03e31f9c 	mvneq	r1, #156, 30	; 0x270
     884:	87480000 	strbhi	r0, [r8, -r0]
     888:	00540000 	subseq	r0, r4, r0
     88c:	9c010000 	stcls	0, cr0, [r1], {-0}
     890:	000003bb 			; <UNDEFINED> instruction: 0x000003bb
     894:	0002b106 	andeq	fp, r2, r6, lsl #2
     898:	34015b00 	strcc	r5, [r1], #-2816	; 0xfffff500
     89c:	02000000 	andeq	r0, r0, #0
     8a0:	0d067491 	cfstrseq	mvf7, [r6, #-580]	; 0xfffffdbc
     8a4:	5b000004 	blpl	8bc <shift+0x8bc>
     8a8:	00003401 	andeq	r3, r0, r1, lsl #8
     8ac:	70910200 	addsvc	r0, r1, r0, lsl #4
     8b0:	03100f00 	tsteq	r0, #0, 30
     8b4:	06540000 	ldrbeq	r0, [r4], -r0
     8b8:	000003d4 	ldrdeq	r0, [r0], -r4
     8bc:	00008670 	andeq	r8, r0, r0, ror r6
     8c0:	000000d8 	ldrdeq	r0, [r0], -r8
     8c4:	04199c01 	ldreq	r9, [r9], #-3073	; 0xfffff3ff
     8c8:	18070000 	stmdane	r7, {}	; <UNPREDICTABLE>
     8cc:	5d000004 	stcpl	0, cr0, [r0, #-16]
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
     928:	00041807 	andeq	r1, r4, r7, lsl #16
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
     978:	00041807 	andeq	r1, r4, r7, lsl #16
     97c:	00035d00 	andeq	r5, r3, r0, lsl #26
     980:	6c910200 	lfmvs	f0, 4, [r1], {0}
     984:	6e697003 	cdpvs	0, 6, cr7, cr9, cr3, {0}
     988:	53304100 	teqpl	r0, #0, 2
     98c:	02000000 	andeq	r0, r0, #0
     990:	d6066891 			; <UNDEFINED> instruction: 0xd6066891
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
     9d4:	04180700 	ldreq	r0, [r8], #-1792	; 0xfffff900
     9d8:	034d0000 	movteq	r0, #53248	; 0xd000
     9dc:	91020000 	mrsls	r0, (UNDEF: 2)
     9e0:	69700374 	ldmdbvs	r0!, {r2, r4, r5, r6, r8, r9}^
     9e4:	3136006e 	teqcc	r6, lr, rrx
     9e8:	00000053 	andeq	r0, r0, r3, asr r0
     9ec:	03709102 	cmneq	r0, #-2147483648	; 0x80000000
     9f0:	00676572 	rsbeq	r6, r7, r2, ror r5
     9f4:	03524036 	cmpeq	r2, #54	; 0x36
     9f8:	91020000 	mrsls	r0, (UNDEF: 2)
     9fc:	07b7066c 	ldreq	r0, [r7, ip, ror #12]!
     a00:	4f360000 	svcmi	0x00360000
     a04:	00000352 	andeq	r0, r0, r2, asr r3
     a08:	00689102 	rsbeq	r9, r8, r2, lsl #2
     a0c:	00024b0c 	andeq	r4, r2, ip, lsl #22
     a10:	052e2b00 	streq	r2, [lr, #-2816]!	; 0xfffff500
     a14:	84740000 	ldrbthi	r0, [r4], #-0
     a18:	00740000 	rsbseq	r0, r4, r0
     a1c:	9c010000 	stcls	0, cr0, [r1], {-0}
     a20:	00000565 	andeq	r0, r0, r5, ror #10
     a24:	00041807 	andeq	r1, r4, r7, lsl #16
     a28:	00034d00 	andeq	r4, r3, r0, lsl #26
     a2c:	74910200 	ldrvc	r0, [r1], #512	; 0x200
     a30:	6e697003 	cdpvs	0, 6, cr7, cr9, cr3, {0}
     a34:	53312b00 	teqpl	r1, #0, 22
     a38:	02000000 	andeq	r0, r0, #0
     a3c:	72037091 	andvc	r7, r3, #145	; 0x91
     a40:	2b006765 	blcs	1a7dc <_bss_end+0x10ff8>
     a44:	00035240 	andeq	r5, r3, r0, asr #4
     a48:	6c910200 	lfmvs	f0, 4, [r1], {0}
     a4c:	0007b706 	andeq	fp, r7, r6, lsl #14
     a50:	524f2b00 	subpl	r2, pc, #0, 22
     a54:	02000003 	andeq	r0, r0, #3
     a58:	0c006891 	stceq	8, cr6, [r0], {145}	; 0x91
     a5c:	0000021e 	andeq	r0, r0, lr, lsl r2
     a60:	00057d20 	andeq	r7, r5, r0, lsr #26
     a64:	00840000 	addeq	r0, r4, r0
     a68:	00007400 	andeq	r7, r0, r0, lsl #8
     a6c:	b49c0100 	ldrlt	r0, [ip], #256	; 0x100
     a70:	07000005 	streq	r0, [r0, -r5]
     a74:	00000418 	andeq	r0, r0, r8, lsl r4
     a78:	0000034d 	andeq	r0, r0, sp, asr #6
     a7c:	03749102 	cmneq	r4, #-2147483648	; 0x80000000
     a80:	006e6970 	rsbeq	r6, lr, r0, ror r9
     a84:	00533120 	subseq	r3, r3, r0, lsr #2
     a88:	91020000 	mrsls	r0, (UNDEF: 2)
     a8c:	65720370 	ldrbvs	r0, [r2, #-880]!	; 0xfffffc90
     a90:	40200067 	eormi	r0, r0, r7, rrx
     a94:	00000352 	andeq	r0, r0, r2, asr r3
     a98:	066c9102 	strbteq	r9, [ip], -r2, lsl #2
     a9c:	000007b7 			; <UNDEFINED> instruction: 0x000007b7
     aa0:	03524f20 	cmpeq	r2, #32, 30	; 0x80
     aa4:	91020000 	mrsls	r0, (UNDEF: 2)
     aa8:	f10c0068 			; <UNDEFINED> instruction: 0xf10c0068
     aac:	0c000001 	stceq	0, cr0, [r0], {1}
     ab0:	000005cc 	andeq	r0, r0, ip, asr #11
     ab4:	000082ec 	andeq	r8, r0, ip, ror #5
     ab8:	00000114 	andeq	r0, r0, r4, lsl r1
     abc:	06039c01 	streq	r9, [r3], -r1, lsl #24
     ac0:	18070000 	stmdane	r7, {}	; <UNPREDICTABLE>
     ac4:	4d000004 	stcmi	0, cr0, [r0, #-16]
     ac8:	02000003 	andeq	r0, r0, #3
     acc:	70037491 	mulvc	r3, r1, r4
     ad0:	0c006e69 	stceq	14, cr6, [r0], {105}	; 0x69
     ad4:	00005332 	andeq	r5, r0, r2, lsr r3
     ad8:	70910200 	addsvc	r0, r1, r0, lsl #4
     adc:	67657203 	strbvs	r7, [r5, -r3, lsl #4]!
     ae0:	52410c00 	subpl	r0, r1, #0, 24
     ae4:	02000003 	andeq	r0, r0, #3
     ae8:	b7066c91 			; <UNDEFINED> instruction: 0xb7066c91
     aec:	0c000007 	stceq	0, cr0, [r0], {7}
     af0:	00035250 	andeq	r5, r3, r0, asr r2
     af4:	68910200 	ldmvs	r1, {r9}
     af8:	02a52000 	adceq	r2, r5, #0
     afc:	06010000 	streq	r0, [r1], -r0
     b00:	00061401 	andeq	r1, r6, r1, lsl #8
     b04:	062a0000 	strteq	r0, [sl], -r0
     b08:	18210000 	stmdane	r1!, {}	; <UNPREDICTABLE>
     b0c:	5d000004 	stcpl	0, cr0, [r0, #-16]
     b10:	22000003 	andcs	r0, r0, #3
     b14:	0000072c 	andeq	r0, r0, ip, lsr #14
     b18:	622b0601 	eorvs	r0, fp, #1048576	; 0x100000
     b1c:	00000000 	andeq	r0, r0, r0
     b20:	00060323 	andeq	r0, r6, r3, lsr #6
     b24:	00065000 	andeq	r5, r6, r0
     b28:	00064100 	andeq	r4, r6, r0, lsl #2
     b2c:	0082b800 	addeq	fp, r2, r0, lsl #16
     b30:	00003400 	andeq	r3, r0, r0, lsl #8
     b34:	129c0100 	addsne	r0, ip, #0, 2
     b38:	00000614 	andeq	r0, r0, r4, lsl r6
     b3c:	12749102 	rsbsne	r9, r4, #-2147483648	; 0x80000000
     b40:	0000061d 	andeq	r0, r0, sp, lsl r6
     b44:	00709102 	rsbseq	r9, r0, r2, lsl #2
     b48:	0007f200 	andeq	pc, r7, r0, lsl #4
     b4c:	01000500 	tsteq	r0, r0, lsl #10
     b50:	00055504 	andeq	r5, r5, r4, lsl #10
     b54:	00761900 	rsbseq	r1, r6, r0, lsl #18
     b58:	c3210000 			; <UNDEFINED> instruction: 0xc3210000
     b5c:	00000008 	andeq	r0, r0, r8
     b60:	b8000000 	stmdalt	r0, {}	; <UNPREDICTABLE>
     b64:	64000087 	strvs	r0, [r0], #-135	; 0xffffff79
     b68:	05000004 	streq	r0, [r0, #-4]
     b6c:	06000005 	streq	r0, [r0], -r5
     b70:	02e60801 	rsceq	r0, r6, #65536	; 0x10000
     b74:	26070000 	strcs	r0, [r7], -r0
     b78:	06000000 	streq	r0, [r0], -r0
     b7c:	01990502 	orrseq	r0, r9, r2, lsl #10
     b80:	041a0000 	ldreq	r0, [sl], #-0
     b84:	746e6905 	strbtvc	r6, [lr], #-2309	; 0xfffff6fb
     b88:	05a81500 	streq	r1, [r8, #1280]!	; 0x500
     b8c:	4a090000 	bmi	240b94 <_bss_end+0x2373b0>
     b90:	06000000 	streq	r0, [r0], -r0
     b94:	02dd0801 	sbcseq	r0, sp, #65536	; 0x10000
     b98:	02060000 	andeq	r0, r6, #0
     b9c:	00039607 	andeq	r9, r3, r7, lsl #12
     ba0:	035f1500 	cmpeq	pc, #0, 10
     ba4:	670b0000 	strvs	r0, [fp, -r0]
     ba8:	07000000 	streq	r0, [r0, -r0]
     bac:	00000058 	andeq	r0, r0, r8, asr r0
     bb0:	12070406 	andne	r0, r7, #100663296	; 0x6000000
     bb4:	0700000f 	streq	r0, [r0, -pc]
     bb8:	00000067 	andeq	r0, r0, r7, rrx
     bbc:	0007880c 	andeq	r8, r7, ip, lsl #16
     bc0:	40010700 	andmi	r0, r1, r0, lsl #14
     bc4:	03000000 	movweq	r0, #0
     bc8:	00bc0c06 	adcseq	r0, ip, r6, lsl #24
     bcc:	11010000 	mrsne	r0, (UNDEF: 1)
     bd0:	00000005 	andeq	r0, r0, r5
     bd4:	00080c01 	andeq	r0, r8, r1, lsl #24
     bd8:	31010100 	mrscc	r0, (UNDEF: 17)
     bdc:	02000008 	andeq	r0, r0, #8
     be0:	00082b01 	andeq	r2, r8, r1, lsl #22
     be4:	13010300 	movwne	r0, #4864	; 0x1300
     be8:	04000008 	streq	r0, [r0], #-8
     bec:	00081901 	andeq	r1, r8, r1, lsl #18
     bf0:	1f010500 	svcne	0x00010500
     bf4:	06000008 	streq	r0, [r0], -r8
     bf8:	00082501 	andeq	r2, r8, r1, lsl #10
     bfc:	c3010700 	movwgt	r0, #5888	; 0x1700
     c00:	08000005 	stmdaeq	r0, {r0, r2}
     c04:	05ed0e00 	strbeq	r0, [sp, #3584]!	; 0xe00
     c08:	1a030000 	bne	c0c10 <_bss_end+0xb742c>
     c0c:	00000219 	andeq	r0, r0, r9, lsl r2
     c10:	00058b0f 	andeq	r8, r5, pc, lsl #22
     c14:	171e0300 	ldrne	r0, [lr, -r0, lsl #6]
     c18:	00000223 	andeq	r0, r0, r3, lsr #4
     c1c:	00074205 	andeq	r4, r7, r5, lsl #4
     c20:	08220300 	stmdaeq	r2!, {r8, r9}
     c24:	0000055b 	andeq	r0, r0, fp, asr r5
     c28:	00000228 	andeq	r0, r0, r8, lsr #4
     c2c:	0000ec02 	andeq	lr, r0, r2, lsl #24
     c30:	00010100 	andeq	r0, r1, r0, lsl #2
     c34:	022f0300 	eoreq	r0, pc, #0, 6
     c38:	58020000 	stmdapl	r2, {}	; <UNPREDICTABLE>
     c3c:	02000000 	andeq	r0, r0, #0
     c40:	00000234 	andeq	r0, r0, r4, lsr r2
     c44:	00023402 	andeq	r3, r2, r2, lsl #8
     c48:	ee050000 	cdp	0, 0, cr0, cr5, cr0, {0}
     c4c:	03000007 	movweq	r0, #7
     c50:	06c30824 	strbeq	r0, [r3], r4, lsr #16
     c54:	02280000 	eoreq	r0, r8, #0
     c58:	1a020000 	bne	80c60 <_bss_end+0x7747c>
     c5c:	2f000001 	svccs	0x00000001
     c60:	03000001 	movweq	r0, #1
     c64:	0000022f 	andeq	r0, r0, pc, lsr #4
     c68:	00005802 	andeq	r5, r0, r2, lsl #16
     c6c:	02340200 	eorseq	r0, r4, #0, 4
     c70:	34020000 	strcc	r0, [r2], #-0
     c74:	00000002 	andeq	r0, r0, r2
     c78:	0005fb05 	andeq	pc, r5, r5, lsl #22
     c7c:	08260300 	stmdaeq	r6!, {r8, r9}
     c80:	000007bf 			; <UNDEFINED> instruction: 0x000007bf
     c84:	00000228 	andeq	r0, r0, r8, lsr #4
     c88:	00014802 	andeq	r4, r1, r2, lsl #16
     c8c:	00015d00 	andeq	r5, r1, r0, lsl #26
     c90:	022f0300 	eoreq	r0, pc, #0, 6
     c94:	58020000 	stmdapl	r2, {}	; <UNPREDICTABLE>
     c98:	02000000 	andeq	r0, r0, #0
     c9c:	00000234 	andeq	r0, r0, r4, lsr r2
     ca0:	00023402 	andeq	r3, r2, r2, lsl #8
     ca4:	14050000 	strne	r0, [r5], #-0
     ca8:	03000006 	movweq	r0, #6
     cac:	049d0828 	ldreq	r0, [sp], #2088	; 0x828
     cb0:	02280000 	eoreq	r0, r8, #0
     cb4:	76020000 	strvc	r0, [r2], -r0
     cb8:	8b000001 	blhi	cc4 <shift+0xcc4>
     cbc:	03000001 	movweq	r0, #1
     cc0:	0000022f 	andeq	r0, r0, pc, lsr #4
     cc4:	00005802 	andeq	r5, r0, r2, lsl #16
     cc8:	02340200 	eorseq	r0, r4, #0, 4
     ccc:	34020000 	strcc	r0, [r2], #-0
     cd0:	00000002 	andeq	r0, r0, r2
     cd4:	0005ed05 	andeq	lr, r5, r5, lsl #26
     cd8:	032b0300 			; <UNDEFINED> instruction: 0x032b0300
     cdc:	00000591 	muleq	r0, r1, r5
     ce0:	00000239 	andeq	r0, r0, r9, lsr r2
     ce4:	0001a401 	andeq	sl, r1, r1, lsl #8
     ce8:	0001af00 	andeq	sl, r1, r0, lsl #30
     cec:	02390300 	eorseq	r0, r9, #0, 6
     cf0:	67020000 	strvs	r0, [r2, -r0]
     cf4:	00000000 	andeq	r0, r0, r0
     cf8:	0007a504 	andeq	sl, r7, r4, lsl #10
     cfc:	082e0300 	stmdaeq	lr!, {r8, r9}
     d00:	0000075f 	andeq	r0, r0, pc, asr r7
     d04:	000001c3 	andeq	r0, r0, r3, asr #3
     d08:	000001d3 	ldrdeq	r0, [r0], -r3
     d0c:	00023903 	andeq	r3, r2, r3, lsl #18
     d10:	00580200 	subseq	r0, r8, r0, lsl #4
     d14:	73020000 	movwvc	r0, #8192	; 0x2000
     d18:	00000000 	andeq	r0, r0, r0
     d1c:	0005db05 	andeq	sp, r5, r5, lsl #22
     d20:	12300300 	eorsne	r0, r0, #0, 6
     d24:	00000627 	andeq	r0, r0, r7, lsr #12
     d28:	00000073 	andeq	r0, r0, r3, ror r0
     d2c:	0001ec01 	andeq	lr, r1, r1, lsl #24
     d30:	0001f700 	andeq	pc, r1, r0, lsl #14
     d34:	022f0300 	eoreq	r0, pc, #0, 6
     d38:	58020000 	stmdapl	r2, {}	; <UNPREDICTABLE>
     d3c:	00000000 	andeq	r0, r0, r0
     d40:	0008081b 	andeq	r0, r8, fp, lsl r8
     d44:	08330300 	ldmdaeq	r3!, {r8, r9}
     d48:	00000539 	andeq	r0, r0, r9, lsr r5
     d4c:	00020801 	andeq	r0, r2, r1, lsl #16
     d50:	02390300 	eorseq	r0, r9, #0, 6
     d54:	58020000 	stmdapl	r2, {}	; <UNPREDICTABLE>
     d58:	02000000 	andeq	r0, r0, #0
     d5c:	00000228 	andeq	r0, r0, r8, lsr #4
     d60:	bc070000 	stclt	0, cr0, [r7], {-0}
     d64:	0b000000 	bleq	d6c <shift+0xd6c>
     d68:	00000067 	andeq	r0, r0, r7, rrx
     d6c:	00021e07 	andeq	r1, r2, r7, lsl #28
     d70:	02010600 	andeq	r0, r1, #0, 12
     d74:	000005be 			; <UNDEFINED> instruction: 0x000005be
     d78:	0002190b 	andeq	r1, r2, fp, lsl #18
     d7c:	00581600 	subseq	r1, r8, r0, lsl #12
     d80:	bc0b0000 	stclt	0, cr0, [fp], {-0}
     d84:	10000000 	andne	r0, r0, r0
     d88:	00000701 	andeq	r0, r0, r1, lsl #14
     d8c:	bc163703 	ldclt	7, cr3, [r6], {3}
     d90:	1c000000 	stcne	0, cr0, [r0], {-0}
     d94:	006c6168 	rsbeq	r6, ip, r8, ror #2
     d98:	4c0b0704 	stcmi	7, cr0, [fp], {4}
     d9c:	11000003 	tstne	r0, r3
     da0:	000002a1 	andeq	r0, r0, r1, lsr #5
     da4:	0003530a 	andeq	r5, r3, sl, lsl #6
     da8:	00000000 	andeq	r0, r0, r0
     dac:	03481120 	movteq	r1, #33056	; 0x8120
     db0:	530d0000 	movwpl	r0, #53248	; 0xd000
     db4:	00000003 	andeq	r0, r0, r3
     db8:	1d202000 	stcne	0, cr2, [r0, #-0]
     dbc:	000003d4 	ldrdeq	r0, [r0], -r4
     dc0:	62151004 	andsvs	r1, r5, #4
     dc4:	36000000 	strcc	r0, [r0], -r0
     dc8:	00043111 	andeq	r3, r4, r1, lsl r1
     dcc:	03534200 	cmpeq	r3, #0, 4
     dd0:	50000000 	andpl	r0, r0, r0
     dd4:	b80c2021 	stmdalt	ip, {r0, r5, sp}
     dd8:	05000001 	streq	r0, [r0, #-1]
     ddc:	00003904 	andeq	r3, r0, r4, lsl #18
     de0:	0d440400 	cfstrdeq	mvd0, [r4, #-0]
     de4:	0000032a 	andeq	r0, r0, sl, lsr #6
     de8:	5152491e 	cmppl	r2, lr, lsl r9
     dec:	f5010000 			; <UNDEFINED> instruction: 0xf5010000
     df0:	01000001 	tsteq	r0, r1
     df4:	00023501 	andeq	r3, r2, r1, lsl #10
     df8:	3a011000 	bcc	44e00 <_bss_end+0x3b61c>
     dfc:	11000003 	tstne	r0, r3
     e00:	00037d01 	andeq	r7, r3, r1, lsl #26
     e04:	b1011200 	mrslt	r1, R9_usr
     e08:	13000003 	movwne	r0, #3
     e0c:	00034101 	andeq	r4, r3, r1, lsl #2
     e10:	5a011400 	bpl	45e18 <_bss_end+0x3c634>
     e14:	15000004 	strne	r0, [r0, #-4]
     e18:	00042a01 	andeq	r2, r4, r1, lsl #20
     e1c:	92011600 	andls	r1, r1, #0, 12
     e20:	17000004 	strne	r0, [r0, -r4]
     e24:	00038401 	andeq	r8, r3, r1, lsl #8
     e28:	3a011800 	bcc	46e30 <_bss_end+0x3d64c>
     e2c:	19000004 	stmdbne	r0, {r2}
     e30:	0003c201 	andeq	ip, r3, r1, lsl #4
     e34:	8b011a00 	blhi	4763c <_bss_end+0x3de58>
     e38:	20000002 	andcs	r0, r0, r2
     e3c:	00029601 	andeq	r9, r2, r1, lsl #12
     e40:	ca012100 	bgt	49248 <_bss_end+0x3fa64>
     e44:	22000003 	andcs	r0, r0, #3
     e48:	00026f01 	andeq	r6, r2, r1, lsl #30
     e4c:	b8012400 	stmdalt	r1, {sl, sp}
     e50:	25000003 	strcs	r0, [r0, #-3]
     e54:	0002c001 	andeq	ip, r2, r1
     e58:	cb013000 	blgt	4ce60 <_bss_end+0x4367c>
     e5c:	31000002 	tstcc	r0, r2
     e60:	0001ad01 	andeq	sl, r1, r1, lsl #26
     e64:	a9013200 	stmdbge	r1, {r9, ip, sp}
     e68:	34000003 	strcc	r0, [r0], #-3
     e6c:	0001a301 	andeq	sl, r1, r1, lsl #6
     e70:	1f003500 	svcne	0x00003500
     e74:	00000225 	andeq	r0, r0, r5, lsr #4
     e78:	00390405 	eorseq	r0, r9, r5, lsl #8
     e7c:	6a040000 	bvs	100e84 <_bss_end+0xf76a0>
     e80:	0451010d 	ldrbeq	r0, [r1], #-269	; 0xfffffef3
     e84:	01000000 	mrseq	r0, (UNDEF: 0)
     e88:	0000038c 	andeq	r0, r0, ip, lsl #7
     e8c:	03910101 	orrseq	r0, r1, #1073741824	; 0x40000000
     e90:	00020000 	andeq	r0, r2, r0
     e94:	07040600 	streq	r0, [r4, -r0, lsl #12]
     e98:	00000f0d 	andeq	r0, r0, sp, lsl #30
     e9c:	00034c07 	andeq	r4, r3, r7, lsl #24
     ea0:	02560d00 	subseq	r0, r6, #0, 26
     ea4:	640d0000 	strvs	r0, [sp], #-0
     ea8:	0d000002 	stceq	0, cr0, [r0, #-8]
     eac:	00000272 	andeq	r0, r0, r2, ror r2
     eb0:	00027f0d 	andeq	r7, r2, sp, lsl #30
     eb4:	08910e00 	ldmeq	r1, {r9, sl, fp}
     eb8:	06050000 	streq	r0, [r5], -r0
     ebc:	00000429 	andeq	r0, r0, r9, lsr #8
     ec0:	0001b70f 	andeq	fp, r1, pc, lsl #14
     ec4:	1d0a0500 	cfstr32ne	mvfx0, [sl, #-0]
     ec8:	00000223 	andeq	r0, r0, r3, lsr #4
     ecc:	00089105 	andeq	r9, r8, r5, lsl #2
     ed0:	090d0500 	stmdbeq	sp, {r8, sl}
     ed4:	0000023b 	andeq	r0, r0, fp, lsr r2
     ed8:	00000429 	andeq	r0, r0, r9, lsr #8
     edc:	00039c01 	andeq	r9, r3, r1, lsl #24
     ee0:	0003a700 	andeq	sl, r3, r0, lsl #14
     ee4:	04290300 	strteq	r0, [r9], #-768	; 0xfffffd00
     ee8:	67020000 	strvs	r0, [r2, -r0]
     eec:	00000000 	andeq	r0, r0, r0
     ef0:	0002d604 	andeq	sp, r2, r4, lsl #12
     ef4:	0e100500 	cfmul32eq	mvfx0, mvfx0, mvfx0
     ef8:	000001fd 	strdeq	r0, [r0], -sp
     efc:	000003bb 			; <UNDEFINED> instruction: 0x000003bb
     f00:	000003c6 	andeq	r0, r0, r6, asr #7
     f04:	00042903 	andeq	r2, r4, r3, lsl #18
     f08:	032a0200 			; <UNDEFINED> instruction: 0x032a0200
     f0c:	04000000 	streq	r0, [r0], #-0
     f10:	00000368 	andeq	r0, r0, r8, ror #6
     f14:	690e1205 	stmdbvs	lr, {r0, r2, r9, ip}
     f18:	da000004 	ble	f30 <shift+0xf30>
     f1c:	e5000003 	str	r0, [r0, #-3]
     f20:	03000003 	movweq	r0, #3
     f24:	00000429 	andeq	r0, r0, r9, lsr #8
     f28:	00032a02 	andeq	r2, r3, r2, lsl #20
     f2c:	1d040000 	stcne	0, cr0, [r4, #-0]
     f30:	05000004 	streq	r0, [r0, #-4]
     f34:	02480e15 	subeq	r0, r8, #336	; 0x150
     f38:	03f90000 	mvnseq	r0, #0
     f3c:	04090000 	streq	r0, [r9], #-0
     f40:	29030000 	stmdbcs	r3, {}	; <UNPREDICTABLE>
     f44:	02000004 	andeq	r0, r0, #4
     f48:	0000028d 	andeq	r0, r0, sp, lsl #5
     f4c:	00005802 	andeq	r5, r0, r2, lsl #16
     f50:	70170000 	andsvc	r0, r7, r0
     f54:	05000003 	streq	r0, [r0, #-3]
     f58:	01c01217 	biceq	r1, r0, r7, lsl r2
     f5c:	00580000 	subseq	r0, r8, r0
     f60:	041d0000 	ldreq	r0, [sp], #-0
     f64:	29030000 	stmdbcs	r3, {}	; <UNPREDICTABLE>
     f68:	02000004 	andeq	r0, r0, #4
     f6c:	0000028d 	andeq	r0, r0, sp, lsl #5
     f70:	6c0b0000 	stcvs	0, cr0, [fp], {-0}
     f74:	10000003 	andne	r0, r0, r3
     f78:	00000286 	andeq	r0, r0, r6, lsl #5
     f7c:	6c0d1a05 			; <UNDEFINED> instruction: 0x6c0d1a05
     f80:	0c000003 	stceq	0, cr0, [r0], {3}
     f84:	000009ac 	andeq	r0, r0, ip, lsr #19
     f88:	00390405 	eorseq	r0, r9, r5, lsl #8
     f8c:	06060000 	streq	r0, [r6], -r0
     f90:	0004590c 	andeq	r5, r4, ip, lsl #18
     f94:	09750100 	ldmdbeq	r5!, {r8}^
     f98:	01000000 	mrseq	r0, (UNDEF: 0)
     f9c:	00000969 	andeq	r0, r0, r9, ror #18
     fa0:	350c0001 	strcc	r0, [ip, #-1]
     fa4:	0500000a 	streq	r0, [r0, #-10]
     fa8:	00003904 	andeq	r3, r0, r4, lsl #18
     fac:	0c0c0600 	stceq	6, cr0, [ip], {-0}
     fb0:	000004a6 	andeq	r0, r0, r6, lsr #9
     fb4:	00096108 	andeq	r6, r9, r8, lsl #2
     fb8:	0804b000 	stmdaeq	r4, {ip, sp, pc}
     fbc:	00000920 	andeq	r0, r0, r0, lsr #18
     fc0:	04080960 	streq	r0, [r8], #-2400	; 0xfffff6a0
     fc4:	c000000a 	andgt	r0, r0, sl
     fc8:	08960812 	ldmeq	r6, {r1, r4, fp}
     fcc:	25800000 	strcs	r0, [r0]
     fd0:	0009e108 	andeq	lr, r9, r8, lsl #2
     fd4:	084b0000 	stmdaeq	fp, {}^	; <UNPREDICTABLE>
     fd8:	00000875 	andeq	r0, r0, r5, ror r8
     fdc:	a9089600 	stmdbge	r8, {r9, sl, ip, pc}
     fe0:	00000008 	andeq	r0, r0, r8
     fe4:	085920e1 	ldmdaeq	r9, {r0, r5, r6, r7, sp}^
     fe8:	c2000000 	andgt	r0, r0, #0
     fec:	0e000001 	cdpeq	0, 0, cr0, cr0, cr1, {0}
     ff0:	000008a3 	andeq	r0, r0, r3, lsr #17
     ff4:	05cb1806 	strbeq	r1, [fp, #2054]	; 0x806
     ff8:	700f0000 	andvc	r0, pc, r0
     ffc:	06000009 	streq	r0, [r0], -r9
    1000:	05cb0f1b 	strbeq	r0, [fp, #3867]	; 0xf1b
    1004:	a3050000 	movwge	r0, #20480	; 0x5000
    1008:	06000008 	streq	r0, [r0], -r8
    100c:	097c091e 	ldmdbeq	ip!, {r1, r2, r3, r4, r8, fp}^
    1010:	05d00000 	ldrbeq	r0, [r0]
    1014:	d6010000 	strle	r0, [r1], -r0
    1018:	e1000004 	tst	r0, r4
    101c:	03000004 	movweq	r0, #4
    1020:	000005d0 	ldrdeq	r0, [r0], -r0	; <UNPREDICTABLE>
    1024:	0005cb02 	andeq	ip, r5, r2, lsl #22
    1028:	be040000 	cdplt	0, 0, cr0, cr4, cr0, {0}
    102c:	06000009 	streq	r0, [r0], -r9
    1030:	098f0e20 	stmibeq	pc, {r5, r9, sl, fp}	; <UNPREDICTABLE>
    1034:	04f50000 	ldrbteq	r0, [r5], #0
    1038:	05000000 	streq	r0, [r0, #-0]
    103c:	d0030000 	andle	r0, r3, r0
    1040:	02000005 	andeq	r0, r0, #5
    1044:	0000043a 	andeq	r0, r0, sl, lsr r4
    1048:	0a0c0400 	beq	302050 <_bss_end+0x2f886c>
    104c:	21060000 	mrscs	r0, (UNDEF: 6)
    1050:	000a1a0e 	andeq	r1, sl, lr, lsl #20
    1054:	00051400 	andeq	r1, r5, r0, lsl #8
    1058:	00051f00 	andeq	r1, r5, r0, lsl #30
    105c:	05d00300 	ldrbeq	r0, [r0, #768]	; 0x300
    1060:	59020000 	stmdbpl	r2, {}	; <UNPREDICTABLE>
    1064:	00000004 	andeq	r0, r0, r4
    1068:	0008bd04 	andeq	fp, r8, r4, lsl #26
    106c:	0e250600 	cfmadda32eq	mvax0, mvax0, mvfx5, mvfx0
    1070:	0000094f 	andeq	r0, r0, pc, asr #18
    1074:	00000533 	andeq	r0, r0, r3, lsr r5
    1078:	0000053e 	andeq	r0, r0, lr, lsr r5
    107c:	0005d003 	andeq	sp, r5, r3
    1080:	00260200 	eoreq	r0, r6, r0, lsl #4
    1084:	04000000 	streq	r0, [r0], #-0
    1088:	000008bd 			; <UNDEFINED> instruction: 0x000008bd
    108c:	f00e2606 			; <UNDEFINED> instruction: 0xf00e2606
    1090:	52000009 	andpl	r0, r0, #9
    1094:	5d000005 	stcpl	0, cr0, [r0, #-20]	; 0xffffffec
    1098:	03000005 	movweq	r0, #5
    109c:	000005d0 	ldrdeq	r0, [r0], -r0	; <UNPREDICTABLE>
    10a0:	0005da02 	andeq	sp, r5, r2, lsl #20
    10a4:	ea040000 	b	1010ac <_bss_end+0xf78c8>
    10a8:	06000009 	streq	r0, [r0], -r9
    10ac:	08630e28 	stmdaeq	r3!, {r3, r5, r9, sl, fp}^
    10b0:	05710000 	ldrbeq	r0, [r1, #-0]!
    10b4:	05770000 	ldrbeq	r0, [r7, #-0]!
    10b8:	d0030000 	andle	r0, r3, r0
    10bc:	00000005 	andeq	r0, r0, r5
    10c0:	00089e04 	andeq	r9, r8, r4, lsl #28
    10c4:	0e290600 	cfmadda32eq	mvax0, mvax0, mvfx9, mvfx0
    10c8:	0000093e 	andeq	r0, r0, lr, lsr r9
    10cc:	0000058b 	andeq	r0, r0, fp, lsl #11
    10d0:	00000591 	muleq	r0, r1, r5
    10d4:	0005d003 	andeq	sp, r5, r3
    10d8:	7e050000 	cdpvc	0, 0, cr0, cr5, cr0, {0}
    10dc:	06000008 	streq	r0, [r0], -r8
    10e0:	090f0e2a 	stmdbeq	pc, {r1, r3, r5, r9, sl, fp}	; <UNPREDICTABLE>
    10e4:	00260000 	eoreq	r0, r6, r0
    10e8:	aa010000 	bge	410f0 <_bss_end+0x3790c>
    10ec:	b0000005 	andlt	r0, r0, r5
    10f0:	03000005 	movweq	r0, #5
    10f4:	000005d0 	ldrdeq	r0, [r0], -r0	; <UNPREDICTABLE>
    10f8:	09d31700 	ldmibeq	r3, {r8, r9, sl, ip}^
    10fc:	2b060000 	blcs	181104 <_bss_end+0x177920>
    1100:	00083e0e 	andeq	r3, r8, lr, lsl #28
    1104:	00002600 	andeq	r2, r0, r0, lsl #12
    1108:	0005c400 	andeq	ip, r5, r0, lsl #8
    110c:	05d00300 	ldrbeq	r0, [r0, #768]	; 0x300
    1110:	00000000 	andeq	r0, r0, r0
    1114:	00036c16 	andeq	r6, r3, r6, lsl ip
    1118:	04a60b00 	strteq	r0, [r6], #2816	; 0xb00
    111c:	d0070000 	andle	r0, r7, r0
    1120:	0b000005 	bleq	113c <shift+0x113c>
    1124:	0000002d 	andeq	r0, r0, sp, lsr #32
    1128:	00093710 	andeq	r3, r9, r0, lsl r7
    112c:	0e2e0600 	cfmadda32eq	mvax0, mvax0, mvfx14, mvfx0
    1130:	000004a6 	andeq	r0, r0, r6, lsr #9
    1134:	0005df21 	andeq	sp, r5, r1, lsr #30
    1138:	07050100 	streq	r0, [r5, -r0, lsl #2]
    113c:	97d00305 	ldrbls	r0, [r0, r5, lsl #6]
    1140:	28220000 	stmdacs	r2!, {}	; <UNPREDICTABLE>
    1144:	00000009 	andeq	r0, r0, r9
    1148:	1c00008c 	stcne	0, cr0, [r0], {140}	; 0x8c
    114c:	01000000 	mrseq	r0, (UNDEF: 0)
    1150:	03e3239c 	mvneq	r2, #156, 6	; 0x70000002
    1154:	8bac0000 	blhi	feb0115c <_bss_end+0xfeaf7978>
    1158:	00540000 	subseq	r0, r4, r0
    115c:	9c010000 	stcls	0, cr0, [r1], {-0}
    1160:	00000638 	andeq	r0, r0, r8, lsr r6
    1164:	0002b112 	andeq	fp, r2, r2, lsl r1
    1168:	39015400 	stmdbcc	r1, {sl, ip, lr}
    116c:	02000000 	andeq	r0, r0, #0
    1170:	0d127491 	cfldrseq	mvf7, [r2, #-580]	; 0xfffffdbc
    1174:	54000004 	strpl	r0, [r0], #-4
    1178:	00003901 	andeq	r3, r0, r1, lsl #18
    117c:	70910200 	addsvc	r0, r1, r0, lsl #4
    1180:	05910900 	ldreq	r0, [r1, #2304]	; 0x900
    1184:	504e0000 	subpl	r0, lr, r0
    1188:	34000006 	strcc	r0, [r0], #-6
    118c:	7800008b 	stmdavc	r0, {r0, r1, r3, r7}
    1190:	01000000 	mrseq	r0, (UNDEF: 0)
    1194:	0006699c 	muleq	r6, ip, r9
    1198:	04180a00 	ldreq	r0, [r8], #-2560	; 0xfffff600
    119c:	05d50000 	ldrbeq	r0, [r5]
    11a0:	91020000 	mrsls	r0, (UNDEF: 2)
    11a4:	0063136c 	rsbeq	r1, r3, ip, ror #6
    11a8:	00580e52 	subseq	r0, r8, r2, asr lr
    11ac:	91020000 	mrsls	r0, (UNDEF: 2)
    11b0:	77090074 	smlsdxvc	r9, r4, r0, r0
    11b4:	49000005 	stmdbmi	r0, {r0, r2}
    11b8:	00000681 	andeq	r0, r0, r1, lsl #13
    11bc:	00008b04 	andeq	r8, r0, r4, lsl #22
    11c0:	00000030 	andeq	r0, r0, r0, lsr r0
    11c4:	068e9c01 	streq	r9, [lr], r1, lsl #24
    11c8:	180a0000 	stmdane	sl, {}	; <UNPREDICTABLE>
    11cc:	d5000004 	strle	r0, [r0, #-4]
    11d0:	02000005 	andeq	r0, r0, #5
    11d4:	09007491 	stmdbeq	r0, {r0, r4, r7, sl, ip, sp, lr}
    11d8:	0000055d 	andeq	r0, r0, sp, asr r5
    11dc:	0006a634 	andeq	sl, r6, r4, lsr r6
    11e0:	008a3000 	addeq	r3, sl, r0
    11e4:	0000d400 	andeq	sp, r0, r0, lsl #8
    11e8:	b39c0100 	orrslt	r0, ip, #0, 2
    11ec:	0a000006 	beq	120c <shift+0x120c>
    11f0:	00000418 	andeq	r0, r0, r8, lsl r4
    11f4:	000005d5 	ldrdeq	r0, [r0], -r5
    11f8:	00749102 	rsbseq	r9, r4, r2, lsl #2
    11fc:	00053e09 	andeq	r3, r5, r9, lsl #28
    1200:	06cb2c00 	strbeq	r2, [fp], r0, lsl #24
    1204:	89c00000 	stmibhi	r0, {}^	; <UNPREDICTABLE>
    1208:	00700000 	rsbseq	r0, r0, r0
    120c:	9c010000 	stcls	0, cr0, [r1], {-0}
    1210:	000006f2 	strdeq	r0, [r0], -r2
    1214:	0004180a 	andeq	r1, r4, sl, lsl #16
    1218:	0005d500 	andeq	sp, r5, r0, lsl #10
    121c:	6c910200 	lfmvs	f0, 4, [r1], {0}
    1220:	72747314 	rsbsvc	r7, r4, #20, 6	; 0x50000000
    1224:	da1f2c00 	ble	7cc22c <_bss_end+0x7c2a48>
    1228:	02000005 	andeq	r0, r0, #5
    122c:	69136891 	ldmdbvs	r3, {r0, r4, r7, fp, sp, lr}
    1230:	39092e00 	stmdbcc	r9, {r9, sl, fp, sp}
    1234:	02000000 	andeq	r0, r0, #0
    1238:	09007491 	stmdbeq	r0, {r0, r4, r7, sl, ip, sp, lr}
    123c:	0000051f 	andeq	r0, r0, pc, lsl r5
    1240:	00070a23 	andeq	r0, r7, r3, lsr #20
    1244:	00894c00 	addeq	r4, r9, r0, lsl #24
    1248:	00007400 	andeq	r7, r0, r0, lsl #8
    124c:	239c0100 	orrscs	r0, ip, #0, 2
    1250:	0a000007 	beq	1274 <shift+0x1274>
    1254:	00000418 	andeq	r0, r0, r8, lsl r4
    1258:	000005d5 	ldrdeq	r0, [r0], -r5
    125c:	14749102 	ldrbtne	r9, [r4], #-258	; 0xfffffefe
    1260:	18230063 	stmdane	r3!, {r0, r1, r5, r6}
    1264:	00000026 	andeq	r0, r0, r6, lsr #32
    1268:	00739102 	rsbseq	r9, r3, r2, lsl #2
    126c:	00050009 	andeq	r0, r5, r9
    1270:	073b1700 	ldreq	r1, [fp, -r0, lsl #14]!
    1274:	88b80000 	ldmhi	r8!, {}	; <UNPREDICTABLE>
    1278:	00940000 	addseq	r0, r4, r0
    127c:	9c010000 	stcls	0, cr0, [r1], {-0}
    1280:	00000773 	andeq	r0, r0, r3, ror r7
    1284:	0004180a 	andeq	r1, r4, sl, lsl #16
    1288:	0005d500 	andeq	sp, r5, r0, lsl #10
    128c:	6c910200 	lfmvs	f0, 4, [r1], {0}
    1290:	0009ce12 	andeq	ip, r9, r2, lsl lr
    1294:	592b1700 	stmdbpl	fp!, {r8, r9, sl, ip}
    1298:	02000004 	andeq	r0, r0, #4
    129c:	b2246891 	eorlt	r6, r4, #9502720	; 0x910000
    12a0:	01000008 	tsteq	r0, r8
    12a4:	006e1c19 	rsbeq	r1, lr, r9, lsl ip
    12a8:	91020000 	mrsls	r0, (UNDEF: 2)
    12ac:	61761374 	cmnvs	r6, r4, ror r3
    12b0:	181a006c 	ldmdane	sl, {r2, r3, r5, r6}
    12b4:	0000006e 	andeq	r0, r0, lr, rrx
    12b8:	00709102 	rsbseq	r9, r0, r2, lsl #2
    12bc:	0004e109 	andeq	lr, r4, r9, lsl #2
    12c0:	078b1200 	streq	r1, [fp, r0, lsl #4]
    12c4:	885c0000 	ldmdahi	ip, {}^	; <UNPREDICTABLE>
    12c8:	005c0000 	subseq	r0, ip, r0
    12cc:	9c010000 	stcls	0, cr0, [r1], {-0}
    12d0:	000007a6 	andeq	r0, r0, r6, lsr #15
    12d4:	0004180a 	andeq	r1, r4, sl, lsl #16
    12d8:	0005d500 	andeq	sp, r5, r0, lsl #10
    12dc:	6c910200 	lfmvs	f0, 4, [r1], {0}
    12e0:	6e656c14 	mcrvs	12, 3, r6, cr5, cr4, {0}
    12e4:	3a2f1200 	bcc	bc5aec <_bss_end+0xbbc308>
    12e8:	02000004 	andeq	r0, r0, #4
    12ec:	25006891 	strcs	r6, [r0, #-2193]	; 0xfffff76f
    12f0:	000004bd 			; <UNDEFINED> instruction: 0x000004bd
    12f4:	b7010701 	strlt	r0, [r1, -r1, lsl #14]
    12f8:	00000007 	andeq	r0, r0, r7
    12fc:	000007cd 	andeq	r0, r0, sp, asr #15
    1300:	00041826 	andeq	r1, r4, r6, lsr #16
    1304:	0005d500 	andeq	sp, r5, r0, lsl #10
    1308:	75612700 	strbvc	r2, [r1, #-1792]!	; 0xfffff900
    130c:	07010078 	smlsdxeq	r1, r8, r0, r0
    1310:	0005cb14 	andeq	ip, r5, r4, lsl fp
    1314:	a6280000 	strtge	r0, [r8], -r0
    1318:	83000007 	movwhi	r0, #7
    131c:	e4000008 	str	r0, [r0], #-8
    1320:	b8000007 	stmdalt	r0, {r0, r1, r2}
    1324:	a4000087 	strge	r0, [r0], #-135	; 0xffffff79
    1328:	01000000 	mrseq	r0, (UNDEF: 0)
    132c:	07b7189c 			; <UNDEFINED> instruction: 0x07b7189c
    1330:	91020000 	mrsls	r0, (UNDEF: 2)
    1334:	07c01874 			; <UNDEFINED> instruction: 0x07c01874
    1338:	91020000 	mrsls	r0, (UNDEF: 2)
    133c:	63000070 	movwvs	r0, #112	; 0x70
    1340:	05000007 	streq	r0, [r0, #-7]
    1344:	d8040100 	stmdale	r4, {r8}
    1348:	18000007 	stmdane	r0, {r0, r1, r2}
    134c:	00000076 	andeq	r0, r0, r6, ror r0
    1350:	000a9821 	andeq	r9, sl, r1, lsr #16
    1354:	00000000 	andeq	r0, r0, r0
    1358:	008c1c00 	addeq	r1, ip, r0, lsl #24
    135c:	00039c00 	andeq	r9, r3, r0, lsl #24
    1360:	00079200 	andeq	r9, r7, r0, lsl #4
    1364:	08010700 	stmdaeq	r1, {r8, r9, sl}
    1368:	000002e6 	andeq	r0, r0, r6, ror #5
    136c:	0000260a 	andeq	r2, r0, sl, lsl #12
    1370:	05020700 	streq	r0, [r2, #-1792]	; 0xfffff900
    1374:	00000199 	muleq	r0, r9, r1
    1378:	69050419 	stmdbvs	r5, {r0, r3, r4, sl}
    137c:	1300746e 	movwne	r7, #1134	; 0x46e
    1380:	000005a8 	andeq	r0, r0, r8, lsr #11
    1384:	00004a09 	andeq	r4, r0, r9, lsl #20
    1388:	08010700 	stmdaeq	r1, {r8, r9, sl}
    138c:	000002dd 	ldrdeq	r0, [r0], -sp
    1390:	96070207 	strls	r0, [r7], -r7, lsl #4
    1394:	13000003 	movwne	r0, #3
    1398:	0000035f 	andeq	r0, r0, pc, asr r3
    139c:	0000670b 	andeq	r6, r0, fp, lsl #14
    13a0:	00580a00 	subseq	r0, r8, r0, lsl #20
    13a4:	04070000 	streq	r0, [r7], #-0
    13a8:	000f1207 	andeq	r1, pc, r7, lsl #4
    13ac:	00671a00 	rsbeq	r1, r7, r0, lsl #20
    13b0:	880b0000 	stmdahi	fp, {}	; <UNPREDICTABLE>
    13b4:	07000007 	streq	r0, [r0, -r7]
    13b8:	00004001 	andeq	r4, r0, r1
    13bc:	0c060300 	stceq	3, cr0, [r6], {-0}
    13c0:	000000bc 	strheq	r0, [r0], -ip
    13c4:	00051101 	andeq	r1, r5, r1, lsl #2
    13c8:	0c010000 	stceq	0, cr0, [r1], {-0}
    13cc:	01000008 	tsteq	r0, r8
    13d0:	00083101 	andeq	r3, r8, r1, lsl #2
    13d4:	2b010200 	blcs	41bdc <_bss_end+0x383f8>
    13d8:	03000008 	movweq	r0, #8
    13dc:	00081301 	andeq	r1, r8, r1, lsl #6
    13e0:	19010400 	stmdbne	r1, {sl}
    13e4:	05000008 	streq	r0, [r0, #-8]
    13e8:	00081f01 	andeq	r1, r8, r1, lsl #30
    13ec:	25010600 	strcs	r0, [r1, #-1536]	; 0xfffffa00
    13f0:	07000008 	streq	r0, [r0, -r8]
    13f4:	0005c301 	andeq	ip, r5, r1, lsl #6
    13f8:	0d000800 	stceq	8, cr0, [r0, #-0]
    13fc:	000005ed 	andeq	r0, r0, sp, ror #11
    1400:	02191a03 	andseq	r1, r9, #12288	; 0x3000
    1404:	8b0e0000 	blhi	38140c <_bss_end+0x377c28>
    1408:	03000005 	movweq	r0, #5
    140c:	0223171e 	eoreq	r1, r3, #7864320	; 0x780000
    1410:	42050000 	andmi	r0, r5, #0
    1414:	03000007 	movweq	r0, #7
    1418:	055b0822 	ldrbeq	r0, [fp, #-2082]	; 0xfffff7de
    141c:	02280000 	eoreq	r0, r8, #0
    1420:	ec020000 	stc	0, cr0, [r2], {-0}
    1424:	01000000 	mrseq	r0, (UNDEF: 0)
    1428:	03000001 	movweq	r0, #1
    142c:	0000022f 	andeq	r0, r0, pc, lsr #4
    1430:	00005802 	andeq	r5, r0, r2, lsl #16
    1434:	02340200 	eorseq	r0, r4, #0, 4
    1438:	34020000 	strcc	r0, [r2], #-0
    143c:	00000002 	andeq	r0, r0, r2
    1440:	0007ee05 	andeq	lr, r7, r5, lsl #28
    1444:	08240300 	stmdaeq	r4!, {r8, r9}
    1448:	000006c3 	andeq	r0, r0, r3, asr #13
    144c:	00000228 	andeq	r0, r0, r8, lsr #4
    1450:	00011a02 	andeq	r1, r1, r2, lsl #20
    1454:	00012f00 	andeq	r2, r1, r0, lsl #30
    1458:	022f0300 	eoreq	r0, pc, #0, 6
    145c:	58020000 	stmdapl	r2, {}	; <UNPREDICTABLE>
    1460:	02000000 	andeq	r0, r0, #0
    1464:	00000234 	andeq	r0, r0, r4, lsr r2
    1468:	00023402 	andeq	r3, r2, r2, lsl #8
    146c:	fb050000 	blx	141476 <_bss_end+0x137c92>
    1470:	03000005 	movweq	r0, #5
    1474:	07bf0826 	ldreq	r0, [pc, r6, lsr #16]!
    1478:	02280000 	eoreq	r0, r8, #0
    147c:	48020000 	stmdami	r2, {}	; <UNPREDICTABLE>
    1480:	5d000001 	stcpl	0, cr0, [r0, #-4]
    1484:	03000001 	movweq	r0, #1
    1488:	0000022f 	andeq	r0, r0, pc, lsr #4
    148c:	00005802 	andeq	r5, r0, r2, lsl #16
    1490:	02340200 	eorseq	r0, r4, #0, 4
    1494:	34020000 	strcc	r0, [r2], #-0
    1498:	00000002 	andeq	r0, r0, r2
    149c:	00061405 	andeq	r1, r6, r5, lsl #8
    14a0:	08280300 	stmdaeq	r8!, {r8, r9}
    14a4:	0000049d 	muleq	r0, sp, r4
    14a8:	00000228 	andeq	r0, r0, r8, lsr #4
    14ac:	00017602 	andeq	r7, r1, r2, lsl #12
    14b0:	00018b00 	andeq	r8, r1, r0, lsl #22
    14b4:	022f0300 	eoreq	r0, pc, #0, 6
    14b8:	58020000 	stmdapl	r2, {}	; <UNPREDICTABLE>
    14bc:	02000000 	andeq	r0, r0, #0
    14c0:	00000234 	andeq	r0, r0, r4, lsr r2
    14c4:	00023402 	andeq	r3, r2, r2, lsl #8
    14c8:	ed050000 	stc	0, cr0, [r5, #-0]
    14cc:	03000005 	movweq	r0, #5
    14d0:	0591032b 	ldreq	r0, [r1, #811]	; 0x32b
    14d4:	02390000 	eorseq	r0, r9, #0
    14d8:	a4010000 	strge	r0, [r1], #-0
    14dc:	af000001 	svcge	0x00000001
    14e0:	03000001 	movweq	r0, #1
    14e4:	00000239 	andeq	r0, r0, r9, lsr r2
    14e8:	00006702 	andeq	r6, r0, r2, lsl #14
    14ec:	a5040000 	strge	r0, [r4, #-0]
    14f0:	03000007 	movweq	r0, #7
    14f4:	075f082e 	ldrbeq	r0, [pc, -lr, lsr #16]
    14f8:	01c30000 	biceq	r0, r3, r0
    14fc:	01d30000 	bicseq	r0, r3, r0
    1500:	39030000 	stmdbcc	r3, {}	; <UNPREDICTABLE>
    1504:	02000002 	andeq	r0, r0, #2
    1508:	00000058 	andeq	r0, r0, r8, asr r0
    150c:	00007302 	andeq	r7, r0, r2, lsl #6
    1510:	db050000 	blle	141518 <_bss_end+0x137d34>
    1514:	03000005 	movweq	r0, #5
    1518:	06271230 			; <UNDEFINED> instruction: 0x06271230
    151c:	00730000 	rsbseq	r0, r3, r0
    1520:	ec010000 	stc	0, cr0, [r1], {-0}
    1524:	f7000001 			; <UNDEFINED> instruction: 0xf7000001
    1528:	03000001 	movweq	r0, #1
    152c:	0000022f 	andeq	r0, r0, pc, lsr #4
    1530:	00005802 	andeq	r5, r0, r2, lsl #16
    1534:	081b0000 	ldmdaeq	fp, {}	; <UNPREDICTABLE>
    1538:	03000008 	movweq	r0, #8
    153c:	05390833 	ldreq	r0, [r9, #-2099]!	; 0xfffff7cd
    1540:	08010000 	stmdaeq	r1, {}	; <UNPREDICTABLE>
    1544:	03000002 	movweq	r0, #2
    1548:	00000239 	andeq	r0, r0, r9, lsr r2
    154c:	00005802 	andeq	r5, r0, r2, lsl #16
    1550:	02280200 	eoreq	r0, r8, #0, 4
    1554:	00000000 	andeq	r0, r0, r0
    1558:	0000bc0a 	andeq	fp, r0, sl, lsl #24
    155c:	00670800 	rsbeq	r0, r7, r0, lsl #16
    1560:	1e0a0000 	cdpne	0, 0, cr0, cr10, cr0, {0}
    1564:	07000002 	streq	r0, [r0, -r2]
    1568:	05be0201 	ldreq	r0, [lr, #513]!	; 0x201
    156c:	19080000 	stmdbne	r8, {}	; <UNPREDICTABLE>
    1570:	14000002 	strne	r0, [r0], #-2
    1574:	00000058 	andeq	r0, r0, r8, asr r0
    1578:	0000bc08 	andeq	fp, r0, r8, lsl #24
    157c:	07011500 	streq	r1, [r1, -r0, lsl #10]
    1580:	37030000 	strcc	r0, [r3, -r0]
    1584:	0000bc16 	andeq	fp, r0, r6, lsl ip
    1588:	61681c00 	cmnvs	r8, r0, lsl #24
    158c:	0704006c 	streq	r0, [r4, -ip, rrx]
    1590:	00034c0b 	andeq	r4, r3, fp, lsl #24
    1594:	02a10f00 	adceq	r0, r1, #0, 30
    1598:	530a0000 	movwpl	r0, #40960	; 0xa000
    159c:	00000003 	andeq	r0, r0, r3
    15a0:	0f200000 	svceq	0x00200000
    15a4:	00000348 	andeq	r0, r0, r8, asr #6
    15a8:	0003530d 	andeq	r5, r3, sp, lsl #6
    15ac:	20000000 	andcs	r0, r0, r0
    15b0:	03d41d20 	bicseq	r1, r4, #32, 26	; 0x800
    15b4:	10040000 	andne	r0, r4, r0
    15b8:	00006215 	andeq	r6, r0, r5, lsl r2
    15bc:	310f3600 	tstcc	pc, r0, lsl #12
    15c0:	42000004 	andmi	r0, r0, #4
    15c4:	00000353 	andeq	r0, r0, r3, asr r3
    15c8:	20215000 	eorcs	r5, r1, r0
    15cc:	0001b80b 	andeq	fp, r1, fp, lsl #16
    15d0:	39040500 	stmdbcc	r4, {r8, sl}
    15d4:	04000000 	streq	r0, [r0], #-0
    15d8:	032a0d44 			; <UNDEFINED> instruction: 0x032a0d44
    15dc:	491e0000 	ldmdbmi	lr, {}	; <UNPREDICTABLE>
    15e0:	00005152 	andeq	r5, r0, r2, asr r1
    15e4:	0001f501 	andeq	pc, r1, r1, lsl #10
    15e8:	35010100 	strcc	r0, [r1, #-256]	; 0xffffff00
    15ec:	10000002 	andne	r0, r0, r2
    15f0:	00033a01 	andeq	r3, r3, r1, lsl #20
    15f4:	7d011100 	stfvcs	f1, [r1, #-0]
    15f8:	12000003 	andne	r0, r0, #3
    15fc:	0003b101 	andeq	fp, r3, r1, lsl #2
    1600:	41011300 	mrsmi	r1, SP_irq
    1604:	14000003 	strne	r0, [r0], #-3
    1608:	00045a01 	andeq	r5, r4, r1, lsl #20
    160c:	2a011500 	bcs	46a14 <_bss_end+0x3d230>
    1610:	16000004 	strne	r0, [r0], -r4
    1614:	00049201 	andeq	r9, r4, r1, lsl #4
    1618:	84011700 	strhi	r1, [r1], #-1792	; 0xfffff900
    161c:	18000003 	stmdane	r0, {r0, r1}
    1620:	00043a01 	andeq	r3, r4, r1, lsl #20
    1624:	c2011900 	andgt	r1, r1, #0, 18
    1628:	1a000003 	bne	163c <shift+0x163c>
    162c:	00028b01 	andeq	r8, r2, r1, lsl #22
    1630:	96012000 	strls	r2, [r1], -r0
    1634:	21000002 	tstcs	r0, r2
    1638:	0003ca01 	andeq	ip, r3, r1, lsl #20
    163c:	6f012200 	svcvs	0x00012200
    1640:	24000002 	strcs	r0, [r0], #-2
    1644:	0003b801 	andeq	fp, r3, r1, lsl #16
    1648:	c0012500 	andgt	r2, r1, r0, lsl #10
    164c:	30000002 	andcc	r0, r0, r2
    1650:	0002cb01 	andeq	ip, r2, r1, lsl #22
    1654:	ad013100 	stfges	f3, [r1, #-0]
    1658:	32000001 	andcc	r0, r0, #1
    165c:	0003a901 	andeq	sl, r3, r1, lsl #18
    1660:	a3013400 	movwge	r3, #5120	; 0x1400
    1664:	35000001 	strcc	r0, [r0, #-1]
    1668:	02251f00 	eoreq	r1, r5, #0, 30
    166c:	04050000 	streq	r0, [r5], #-0
    1670:	00000039 	andeq	r0, r0, r9, lsr r0
    1674:	010d6a04 	tsteq	sp, r4, lsl #20
    1678:	00000451 	andeq	r0, r0, r1, asr r4
    167c:	038c0100 	orreq	r0, ip, #0, 2
    1680:	01010000 	mrseq	r0, (UNDEF: 1)
    1684:	00000391 	muleq	r0, r1, r3
    1688:	07000002 	streq	r0, [r0, -r2]
    168c:	0f0d0704 	svceq	0x000d0704
    1690:	4c0a0000 	stcmi	0, cr0, [sl], {-0}
    1694:	0c000003 	stceq	0, cr0, [r0], {3}
    1698:	00000256 	andeq	r0, r0, r6, asr r2
    169c:	0002640c 	andeq	r6, r2, ip, lsl #8
    16a0:	02720c00 	rsbseq	r0, r2, #0, 24
    16a4:	7f0c0000 	svcvc	0x000c0000
    16a8:	0d000002 	stceq	0, cr0, [r0, #-8]
    16ac:	00000891 	muleq	r0, r1, r8
    16b0:	04290605 	strteq	r0, [r9], #-1541	; 0xfffff9fb
    16b4:	b70e0000 	strlt	r0, [lr, -r0]
    16b8:	05000001 	streq	r0, [r0, #-1]
    16bc:	02231d0a 	eoreq	r1, r3, #640	; 0x280
    16c0:	91050000 	mrsls	r0, (UNDEF: 5)
    16c4:	05000008 	streq	r0, [r0, #-8]
    16c8:	023b090d 	eorseq	r0, fp, #212992	; 0x34000
    16cc:	04290000 	strteq	r0, [r9], #-0
    16d0:	9c010000 	stcls	0, cr0, [r1], {-0}
    16d4:	a7000003 	strge	r0, [r0, -r3]
    16d8:	03000003 	movweq	r0, #3
    16dc:	00000429 	andeq	r0, r0, r9, lsr #8
    16e0:	00006702 	andeq	r6, r0, r2, lsl #14
    16e4:	d6040000 	strle	r0, [r4], -r0
    16e8:	05000002 	streq	r0, [r0, #-2]
    16ec:	01fd0e10 	mvnseq	r0, r0, lsl lr
    16f0:	03bb0000 			; <UNDEFINED> instruction: 0x03bb0000
    16f4:	03c60000 	biceq	r0, r6, #0
    16f8:	29030000 	stmdbcs	r3, {}	; <UNPREDICTABLE>
    16fc:	02000004 	andeq	r0, r0, #4
    1700:	0000032a 	andeq	r0, r0, sl, lsr #6
    1704:	03680400 	cmneq	r8, #0, 8
    1708:	12050000 	andne	r0, r5, #0
    170c:	0004690e 	andeq	r6, r4, lr, lsl #18
    1710:	0003da00 	andeq	sp, r3, r0, lsl #20
    1714:	0003e500 	andeq	lr, r3, r0, lsl #10
    1718:	04290300 	strteq	r0, [r9], #-768	; 0xfffffd00
    171c:	2a020000 	bcs	81724 <_bss_end+0x77f40>
    1720:	00000003 	andeq	r0, r0, r3
    1724:	00041d04 	andeq	r1, r4, r4, lsl #26
    1728:	0e150500 	cfmul32eq	mvfx0, mvfx5, mvfx0
    172c:	00000248 	andeq	r0, r0, r8, asr #4
    1730:	000003f9 	strdeq	r0, [r0], -r9
    1734:	00000409 	andeq	r0, r0, r9, lsl #8
    1738:	00042903 	andeq	r2, r4, r3, lsl #18
    173c:	028d0200 	addeq	r0, sp, #0, 4
    1740:	58020000 	stmdapl	r2, {}	; <UNPREDICTABLE>
    1744:	00000000 	andeq	r0, r0, r0
    1748:	00037016 	andeq	r7, r3, r6, lsl r0
    174c:	12170500 	andsne	r0, r7, #0, 10
    1750:	000001c0 	andeq	r0, r0, r0, asr #3
    1754:	00000058 	andeq	r0, r0, r8, asr r0
    1758:	0000041d 	andeq	r0, r0, sp, lsl r4
    175c:	00042903 	andeq	r2, r4, r3, lsl #18
    1760:	028d0200 	addeq	r0, sp, #0, 4
    1764:	00000000 	andeq	r0, r0, r0
    1768:	00036c08 	andeq	r6, r3, r8, lsl #24
    176c:	09ac0b00 	stmibeq	ip!, {r8, r9, fp}
    1770:	04050000 	streq	r0, [r5], #-0
    1774:	00000039 	andeq	r0, r0, r9, lsr r0
    1778:	4d0c0606 	stcmi	6, cr0, [ip, #-24]	; 0xffffffe8
    177c:	01000004 	tsteq	r0, r4
    1780:	00000975 	andeq	r0, r0, r5, ror r9
    1784:	09690100 	stmdbeq	r9!, {r8}^
    1788:	00010000 	andeq	r0, r1, r0
    178c:	000a350b 	andeq	r3, sl, fp, lsl #10
    1790:	39040500 	stmdbcc	r4, {r8, sl}
    1794:	06000000 	streq	r0, [r0], -r0
    1798:	049a0c0c 	ldreq	r0, [sl], #3084	; 0xc0c
    179c:	61090000 	mrsvs	r0, (UNDEF: 9)
    17a0:	b0000009 	andlt	r0, r0, r9
    17a4:	09200904 	stmdbeq	r0!, {r2, r8, fp}
    17a8:	09600000 	stmdbeq	r0!, {}^	; <UNPREDICTABLE>
    17ac:	000a0409 	andeq	r0, sl, r9, lsl #8
    17b0:	0912c000 	ldmdbeq	r2, {lr, pc}
    17b4:	00000896 	muleq	r0, r6, r8
    17b8:	e1092580 	smlabb	r9, r0, r5, r2
    17bc:	00000009 	andeq	r0, r0, r9
    17c0:	0875094b 	ldmdaeq	r5!, {r0, r1, r3, r6, r8, fp}^
    17c4:	96000000 	strls	r0, [r0], -r0
    17c8:	0008a909 	andeq	sl, r8, r9, lsl #18
    17cc:	20e10000 	rsccs	r0, r1, r0
    17d0:	00000859 	andeq	r0, r0, r9, asr r8
    17d4:	0001c200 	andeq	ip, r1, r0, lsl #4
    17d8:	08a30d00 	stmiaeq	r3!, {r8, sl, fp}
    17dc:	18060000 	stmdane	r6, {}	; <UNPREDICTABLE>
    17e0:	000005bf 			; <UNDEFINED> instruction: 0x000005bf
    17e4:	0009700e 	andeq	r7, r9, lr
    17e8:	0f1b0600 	svceq	0x001b0600
    17ec:	000005bf 			; <UNDEFINED> instruction: 0x000005bf
    17f0:	0008a305 	andeq	sl, r8, r5, lsl #6
    17f4:	091e0600 	ldmdbeq	lr, {r9, sl}
    17f8:	0000097c 	andeq	r0, r0, ip, ror r9
    17fc:	000005c4 	andeq	r0, r0, r4, asr #11
    1800:	0004ca01 	andeq	ip, r4, r1, lsl #20
    1804:	0004d500 	andeq	sp, r4, r0, lsl #10
    1808:	05c40300 	strbeq	r0, [r4, #768]	; 0x300
    180c:	bf020000 	svclt	0x00020000
    1810:	00000005 	andeq	r0, r0, r5
    1814:	0009be04 	andeq	fp, r9, r4, lsl #28
    1818:	0e200600 	cfmadda32eq	mvax0, mvax0, mvfx0, mvfx0
    181c:	0000098f 	andeq	r0, r0, pc, lsl #19
    1820:	000004e9 	andeq	r0, r0, r9, ror #9
    1824:	000004f4 	strdeq	r0, [r0], -r4
    1828:	0005c403 	andeq	ip, r5, r3, lsl #8
    182c:	042e0200 	strteq	r0, [lr], #-512	; 0xfffffe00
    1830:	04000000 	streq	r0, [r0], #-0
    1834:	00000a0c 	andeq	r0, r0, ip, lsl #20
    1838:	1a0e2106 	bne	389c58 <_bss_end+0x380474>
    183c:	0800000a 	stmdaeq	r0, {r1, r3}
    1840:	13000005 	movwne	r0, #5
    1844:	03000005 	movweq	r0, #5
    1848:	000005c4 	andeq	r0, r0, r4, asr #11
    184c:	00044d02 	andeq	r4, r4, r2, lsl #26
    1850:	bd040000 	stclt	0, cr0, [r4, #-0]
    1854:	06000008 	streq	r0, [r0], -r8
    1858:	094f0e25 	stmdbeq	pc, {r0, r2, r5, r9, sl, fp}^	; <UNPREDICTABLE>
    185c:	05270000 	streq	r0, [r7, #-0]!
    1860:	05320000 	ldreq	r0, [r2, #-0]!
    1864:	c4030000 	strgt	r0, [r3], #-0
    1868:	02000005 	andeq	r0, r0, #5
    186c:	00000026 	andeq	r0, r0, r6, lsr #32
    1870:	08bd0400 	ldmfdeq	sp!, {sl}
    1874:	26060000 	strcs	r0, [r6], -r0
    1878:	0009f00e 	andeq	pc, r9, lr
    187c:	00054600 	andeq	r4, r5, r0, lsl #12
    1880:	00055100 	andeq	r5, r5, r0, lsl #2
    1884:	05c40300 	strbeq	r0, [r4, #768]	; 0x300
    1888:	c9020000 	stmdbgt	r2, {}	; <UNPREDICTABLE>
    188c:	00000005 	andeq	r0, r0, r5
    1890:	0009ea04 	andeq	lr, r9, r4, lsl #20
    1894:	0e280600 	cfmadda32eq	mvax0, mvax0, mvfx8, mvfx0
    1898:	00000863 	andeq	r0, r0, r3, ror #16
    189c:	00000565 	andeq	r0, r0, r5, ror #10
    18a0:	0000056b 	andeq	r0, r0, fp, ror #10
    18a4:	0005c403 	andeq	ip, r5, r3, lsl #8
    18a8:	9e040000 	cdpls	0, 0, cr0, cr4, cr0, {0}
    18ac:	06000008 	streq	r0, [r0], -r8
    18b0:	093e0e29 	ldmdbeq	lr!, {r0, r3, r5, r9, sl, fp}
    18b4:	057f0000 	ldrbeq	r0, [pc, #-0]!	; 18bc <shift+0x18bc>
    18b8:	05850000 	streq	r0, [r5]
    18bc:	c4030000 	strgt	r0, [r3], #-0
    18c0:	00000005 	andeq	r0, r0, r5
    18c4:	00087e05 	andeq	r7, r8, r5, lsl #28
    18c8:	0e2a0600 	cfmadda32eq	mvax0, mvax0, mvfx10, mvfx0
    18cc:	0000090f 	andeq	r0, r0, pc, lsl #18
    18d0:	00000026 	andeq	r0, r0, r6, lsr #32
    18d4:	00059e01 	andeq	r9, r5, r1, lsl #28
    18d8:	0005a400 	andeq	sl, r5, r0, lsl #8
    18dc:	05c40300 	strbeq	r0, [r4, #768]	; 0x300
    18e0:	16000000 	strne	r0, [r0], -r0
    18e4:	000009d3 	ldrdeq	r0, [r0], -r3
    18e8:	3e0e2b06 	vmlacc.f64	d2, d14, d6
    18ec:	26000008 	strcs	r0, [r0], -r8
    18f0:	b8000000 	stmdalt	r0, {}	; <UNPREDICTABLE>
    18f4:	03000005 	movweq	r0, #5
    18f8:	000005c4 	andeq	r0, r0, r4, asr #11
    18fc:	6c140000 	ldcvs	0, cr0, [r4], {-0}
    1900:	08000003 	stmdaeq	r0, {r0, r1}
    1904:	0000049a 	muleq	r0, sl, r4
    1908:	00002d08 	andeq	r2, r0, r8, lsl #26
    190c:	09371500 	ldmdbeq	r7!, {r8, sl, ip}
    1910:	2e060000 	cdpcs	0, 0, cr0, cr6, cr0, {0}
    1914:	00049a0e 	andeq	r9, r4, lr, lsl #20
    1918:	0a452100 	beq	1149d20 <_bss_end+0x114053c>
    191c:	05010000 	streq	r0, [r1, #-0]
    1920:	00006214 	andeq	r6, r0, r4, lsl r2
    1924:	74030500 	strvc	r0, [r3], #-1280	; 0xfffffb00
    1928:	22000097 	andcs	r0, r0, #151	; 0x97
    192c:	00000a7a 	andeq	r0, r0, sl, ror sl
    1930:	39104701 	ldmdbcc	r0, {r0, r8, r9, sl, lr}
    1934:	a0000000 	andge	r0, r0, r0
    1938:	1800008e 	stmdane	r0, {r1, r2, r3, r7}
    193c:	01000001 	tsteq	r0, r1
    1940:	0006389c 	muleq	r6, ip, r8
    1944:	8ee81000 	cdphi	0, 14, cr1, cr8, cr0, {0}
    1948:	00ac0000 	adceq	r0, ip, r0
    194c:	61060000 	mrsvs	r0, (UNDEF: 6)
    1950:	39075900 	stmdbcc	r7, {r8, fp, ip, lr}
    1954:	02000000 	andeq	r0, r0, #0
    1958:	62067491 	andvs	r7, r6, #-1862270976	; 0x91000000
    195c:	5a006675 	bpl	1b338 <_bss_end+0x11b54>
    1960:	00063808 	andeq	r3, r6, r8, lsl #16
    1964:	b0910300 	addslt	r0, r1, r0, lsl #6
    1968:	0063067f 	rsbeq	r0, r3, pc, ror r6
    196c:	00260860 	eoreq	r0, r6, r0, ror #16
    1970:	91020000 	mrsls	r0, (UNDEF: 2)
    1974:	23000073 	movwcs	r0, #115	; 0x73
    1978:	00000026 	andeq	r0, r0, r6, lsr #32
    197c:	00000648 	andeq	r0, r0, r8, asr #12
    1980:	00006724 	andeq	r6, r0, r4, lsr #14
    1984:	25003f00 	strcs	r3, [r0, #-3840]	; 0xfffff100
    1988:	00000a93 	muleq	r0, r3, sl
    198c:	87071e01 	strhi	r1, [r7, -r1, lsl #28]
    1990:	c300000a 	movwgt	r0, #10
    1994:	2c000006 	stccs	0, cr0, [r0], {6}
    1998:	7400008d 	strvc	r0, [r0], #-141	; 0xffffff73
    199c:	01000001 	tsteq	r0, r1
    19a0:	0006c39c 	muleq	r6, ip, r3
    19a4:	756e1100 	strbvc	r1, [lr, #-256]!	; 0xffffff00
    19a8:	101e006d 	andsne	r0, lr, sp, rrx
    19ac:	00000039 	andeq	r0, r0, r9, lsr r0
    19b0:	11649102 	cmnne	r4, r2, lsl #2
    19b4:	00727473 	rsbseq	r7, r2, r3, ror r4
    19b8:	06c31b1e 			; <UNDEFINED> instruction: 0x06c31b1e
    19bc:	91020000 	mrsls	r0, (UNDEF: 2)
    19c0:	0ca81260 	sfmeq	f1, 4, [r8], #384	; 0x180
    19c4:	241e0000 	ldrcs	r0, [lr], #-0
    19c8:	00000039 	andeq	r0, r0, r9, lsr r0
    19cc:	065c9102 	ldrbeq	r9, [ip], -r2, lsl #2
    19d0:	09200069 	stmdbeq	r0!, {r0, r3, r5, r6}
    19d4:	00000039 	andeq	r0, r0, r9, lsr r0
    19d8:	17749102 	ldrbne	r9, [r4, -r2, lsl #2]!
    19dc:	00000adc 	ldrdeq	r0, [r0], -ip
    19e0:	02280a21 	eoreq	r0, r8, #135168	; 0x21000
    19e4:	91020000 	mrsls	r0, (UNDEF: 2)
    19e8:	8dc81073 	stclhi	0, cr1, [r8, #460]	; 0x1cc
    19ec:	00740000 	rsbseq	r0, r4, r0
    19f0:	72060000 	andvc	r0, r6, #0
    19f4:	36006d65 	strcc	r6, [r0], -r5, ror #26
    19f8:	0000390d 	andeq	r3, r0, sp, lsl #18
    19fc:	6c910200 	lfmvs	f0, 4, [r1], {0}
    1a00:	26080000 	strcs	r0, [r8], -r0
    1a04:	26000000 	strcs	r0, [r0], -r0
    1a08:	00000ae7 	andeq	r0, r0, r7, ror #21
    1a0c:	5b060e01 	blpl	185218 <_bss_end+0x17ba34>
    1a10:	7800000a 	stmdavc	r0, {r1, r3}
    1a14:	b400008c 	strlt	r0, [r0], #-140	; 0xffffff74
    1a18:	01000000 	mrseq	r0, (UNDEF: 0)
    1a1c:	0007339c 	muleq	r7, ip, r3
    1a20:	74731100 	ldrbtvc	r1, [r3], #-256	; 0xffffff00
    1a24:	130e0072 	movwne	r0, #57458	; 0xe072
    1a28:	000006c3 	andeq	r0, r0, r3, asr #13
    1a2c:	12649102 	rsbne	r9, r4, #-2147483648	; 0x80000000
    1a30:	00000a73 	andeq	r0, r0, r3, ror sl
    1a34:	00391e0e 	eorseq	r1, r9, lr, lsl #28
    1a38:	91020000 	mrsls	r0, (UNDEF: 2)
    1a3c:	0b4c1760 	bleq	13077c4 <_bss_end+0x12fdfe0>
    1a40:	09100000 	ldmdbeq	r0, {}	; <UNPREDICTABLE>
    1a44:	00000039 	andeq	r0, r0, r9, lsr r0
    1a48:	06749102 	ldrbteq	r9, [r4], -r2, lsl #2
    1a4c:	00646e65 	rsbeq	r6, r4, r5, ror #28
    1a50:	00390911 	eorseq	r0, r9, r1, lsl r9
    1a54:	91020000 	mrsls	r0, (UNDEF: 2)
    1a58:	8ca41070 	stchi	0, cr1, [r4], #448	; 0x1c0
    1a5c:	00640000 	rsbeq	r0, r4, r0
    1a60:	74060000 	strvc	r0, [r6], #-0
    1a64:	1500706d 	strne	r7, [r0, #-109]	; 0xffffff93
    1a68:	00003907 	andeq	r3, r0, r7, lsl #18
    1a6c:	6c910200 	lfmvs	f0, 4, [r1], {0}
    1a70:	69270000 	stmdbvs	r7!, {}	; <UNPREDICTABLE>
    1a74:	0100000a 	tsteq	r0, sl
    1a78:	0a4d0607 	beq	134329c <_bss_end+0x1339ab8>
    1a7c:	8c1c0000 	ldchi	0, cr0, [ip], {-0}
    1a80:	005c0000 	subseq	r0, ip, r0
    1a84:	9c010000 	stcls	0, cr0, [r1], {-0}
    1a88:	000a6e12 	andeq	r6, sl, r2, lsl lr
    1a8c:	39140700 	ldmdbcc	r4, {r8, r9, sl}
    1a90:	02000000 	andeq	r0, r0, #0
    1a94:	74066c91 	strvc	r6, [r6], #-3217	; 0xfffff36f
    1a98:	08006d69 	stmdaeq	r0, {r0, r3, r5, r6, r8, sl, fp, sp, lr}
    1a9c:	00006e18 	andeq	r6, r0, r8, lsl lr
    1aa0:	74910200 	ldrvc	r0, [r1], #512	; 0x200
    1aa4:	00200000 	eoreq	r0, r0, r0
    1aa8:	00050000 	andeq	r0, r5, r0
    1aac:	0a570401 	beq	15c2ab8 <_bss_end+0x15b92d4>
    1ab0:	f2010000 	vhadd.s8	d0, d1, d0
    1ab4:	00000009 	andeq	r0, r0, r9
    1ab8:	18000080 	stmdane	r0, {r7}
    1abc:	00000aef 	andeq	r0, r0, pc, ror #21
    1ac0:	00000000 	andeq	r0, r0, r0
    1ac4:	00000b32 	andeq	r0, r0, r2, lsr fp
    1ac8:	012e8001 			; <UNDEFINED> instruction: 0x012e8001
    1acc:	00050000 	andeq	r0, r5, r0
    1ad0:	0a6b0401 	beq	1ac2adc <_bss_end+0x1ab92f8>
    1ad4:	76080000 	strvc	r0, [r8], -r0
    1ad8:	21000000 	mrscs	r0, (UNDEF: 0)
    1adc:	00000b7a 	andeq	r0, r0, sl, ror fp
    1ae0:	00000000 	andeq	r0, r0, r0
    1ae4:	00008fb8 			; <UNDEFINED> instruction: 0x00008fb8
    1ae8:	00000118 	andeq	r0, r0, r8, lsl r1
    1aec:	00000a3e 	andeq	r0, r0, lr, lsr sl
    1af0:	000b3e03 	andeq	r3, fp, r3, lsl #28
    1af4:	00300200 	eorseq	r0, r0, r0, lsl #4
    1af8:	35020000 	strcc	r0, [r2, #-0]
    1afc:	09000000 	stmdbeq	r0, {}	; <UNPREDICTABLE>
    1b00:	000be603 	andeq	lr, fp, r3, lsl #12
    1b04:	00300300 	eorseq	r0, r0, r0, lsl #6
    1b08:	47010000 	strmi	r0, [r1, -r0]
    1b0c:	0600000b 	streq	r0, [r0], -fp
    1b10:	00004b10 	andeq	r4, r0, r0, lsl fp
    1b14:	05040a00 	streq	r0, [r4, #-2560]	; 0xfffff600
    1b18:	00746e69 	rsbseq	r6, r4, r9, ror #28
    1b1c:	000bcf01 	andeq	ip, fp, r1, lsl #30
    1b20:	4b100800 	blmi	403b28 <_bss_end+0x3fa344>
    1b24:	04000000 	streq	r0, [r0], #-0
    1b28:	00000026 	andeq	r0, r0, r6, lsr #32
    1b2c:	0000006c 	andeq	r0, r0, ip, rrx
    1b30:	00006c05 	andeq	r6, r0, r5, lsl #24
    1b34:	040b0000 	streq	r0, [fp], #-0
    1b38:	000f1207 	andeq	r1, pc, r7, lsl #4
    1b3c:	0b5f0100 	bleq	17c1f44 <_bss_end+0x17b8760>
    1b40:	150b0000 	strne	r0, [fp, #-0]
    1b44:	0000005d 	andeq	r0, r0, sp, asr r0
    1b48:	000b5201 	andeq	r5, fp, r1, lsl #4
    1b4c:	5d150d00 	ldcpl	13, cr0, [r5, #-0]
    1b50:	04000000 	streq	r0, [r0], #-0
    1b54:	00000036 	andeq	r0, r0, r6, lsr r0
    1b58:	00000098 	muleq	r0, r8, r0
    1b5c:	00006c05 	andeq	r6, r0, r5, lsl #24
    1b60:	d8010000 	stmdale	r1, {}	; <UNPREDICTABLE>
    1b64:	1000000b 	andne	r0, r0, fp
    1b68:	00008915 	andeq	r8, r0, r5, lsl r9
    1b6c:	0b6d0100 	bleq	1b41f74 <_bss_end+0x1b38790>
    1b70:	15120000 	ldrne	r0, [r2, #-0]
    1b74:	00000089 	andeq	r0, r0, r9, lsl #1
    1b78:	000bc106 	andeq	ip, fp, r6, lsl #2
    1b7c:	004b2b00 	subeq	r2, fp, r0, lsl #22
    1b80:	90780000 	rsbsls	r0, r8, r0
    1b84:	00580000 	subseq	r0, r8, r0
    1b88:	9c010000 	stcls	0, cr0, [r1], {-0}
    1b8c:	000000d4 	ldrdeq	r0, [r0], -r4
    1b90:	000c0707 	andeq	r0, ip, r7, lsl #14
    1b94:	00d42d00 	sbcseq	r2, r4, r0, lsl #26
    1b98:	91020000 	mrsls	r0, (UNDEF: 2)
    1b9c:	36020074 			; <UNDEFINED> instruction: 0x36020074
    1ba0:	06000000 	streq	r0, [r0], -r0
    1ba4:	00000bfa 	strdeq	r0, [r0], -sl
    1ba8:	00004b1f 	andeq	r4, r0, pc, lsl fp
    1bac:	00902000 	addseq	r2, r0, r0
    1bb0:	00005800 	andeq	r5, r0, r0, lsl #16
    1bb4:	ff9c0100 			; <UNDEFINED> instruction: 0xff9c0100
    1bb8:	07000000 	streq	r0, [r0, -r0]
    1bbc:	00000c07 	andeq	r0, r0, r7, lsl #24
    1bc0:	0000ff21 	andeq	pc, r0, r1, lsr #30
    1bc4:	74910200 	ldrvc	r0, [r1], #512	; 0x200
    1bc8:	00260200 	eoreq	r0, r6, r0, lsl #4
    1bcc:	ef0c0000 	svc	0x000c0000
    1bd0:	0100000b 	tsteq	r0, fp
    1bd4:	004b1014 	subeq	r1, fp, r4, lsl r0
    1bd8:	8fb80000 	svchi	0x00b80000
    1bdc:	00680000 	rsbeq	r0, r8, r0
    1be0:	9c010000 	stcls	0, cr0, [r1], {-0}
    1be4:	0000012c 	andeq	r0, r0, ip, lsr #2
    1be8:	0100690d 	tsteq	r0, sp, lsl #18
    1bec:	012c0716 			; <UNDEFINED> instruction: 0x012c0716
    1bf0:	91020000 	mrsls	r0, (UNDEF: 2)
    1bf4:	4b020074 	blmi	81dcc <_bss_end+0x785e8>
    1bf8:	00000000 	andeq	r0, r0, r0
    1bfc:	00000021 	andeq	r0, r0, r1, lsr #32
    1c00:	04010005 	streq	r0, [r1], #-5
    1c04:	00000b3c 	andeq	r0, r0, ip, lsr fp
    1c08:	000b2901 	andeq	r2, fp, r1, lsl #18
    1c0c:	0090d000 	addseq	sp, r0, r0
    1c10:	0d048c00 	stceq	12, cr8, [r4, #-0]
    1c14:	1900000c 	stmdbne	r0, {r2, r3}
    1c18:	8000000c 	andhi	r0, r0, ip
    1c1c:	0100000c 	tsteq	r0, ip
    1c20:	00002180 	andeq	r2, r0, r0, lsl #3
    1c24:	01000500 	tsteq	r0, r0, lsl #10
    1c28:	000b5004 	andeq	r5, fp, r4
    1c2c:	0b900100 	bleq	fe402034 <_bss_end+0xfe3f8850>
    1c30:	92dc0000 	sbcsls	r0, ip, #0
    1c34:	04c00000 	strbeq	r0, [r0], #0
    1c38:	00000c0d 	andeq	r0, r0, sp, lsl #24
    1c3c:	00000c19 	andeq	r0, r0, r9, lsl ip
    1c40:	00000c80 	andeq	r0, r0, r0, lsl #25
    1c44:	00208001 	eoreq	r8, r0, r1
    1c48:	00050000 	andeq	r0, r5, r0
    1c4c:	0b640401 	bleq	1902c58 <_bss_end+0x18f9474>
    1c50:	03010000 	movweq	r0, #4096	; 0x1000
    1c54:	1c00000c 	stcne	0, cr0, [r0], {12}
    1c58:	04000095 	streq	r0, [r0], #-149	; 0xffffff6b
    1c5c:	00000c0d 	andeq	r0, r0, sp, lsl #24
    1c60:	00000c19 	andeq	r0, r0, r9, lsl ip
    1c64:	00000c80 	andeq	r0, r0, r0, lsl #25
    1c68:	03318001 	teqeq	r1, #1
    1c6c:	00050000 	andeq	r0, r5, r0
    1c70:	0b780401 	bleq	1e02c7c <_bss_end+0x1df9498>
    1c74:	76090000 	strvc	r0, [r9], -r0
    1c78:	1d000011 	stcne	0, cr0, [r0, #-68]	; 0xffffffbc
    1c7c:	00000d5e 	andeq	r0, r0, lr, asr sp
    1c80:	00000c19 	andeq	r0, r0, r9, lsl ip
    1c84:	00000c4d 	andeq	r0, r0, sp, asr #24
    1c88:	6905040a 	stmdbvs	r5, {r1, r3, sl}
    1c8c:	0200746e 	andeq	r7, r0, #1845493760	; 0x6e000000
    1c90:	0f120704 	svceq	0x00120704
    1c94:	08020000 	stmdaeq	r2, {}	; <UNPREDICTABLE>
    1c98:	00011605 	andeq	r1, r1, r5, lsl #12
    1c9c:	04080200 	streq	r0, [r8], #-512	; 0xfffffe00
    1ca0:	00000ee0 	andeq	r0, r0, r0, ror #29
    1ca4:	dd080102 	stfles	f0, [r8, #-8]
    1ca8:	02000002 	andeq	r0, r0, #2
    1cac:	02df0601 	sbcseq	r0, pc, #1048576	; 0x100000
    1cb0:	a90b0000 	stmdbge	fp, {}	; <UNPREDICTABLE>
    1cb4:	07000010 	smladeq	r0, r0, r0, r0
    1cb8:	00003a01 	andeq	r3, r0, r1, lsl #20
    1cbc:	06170200 	ldreq	r0, [r7], -r0, lsl #4
    1cc0:	000001e7 	andeq	r0, r0, r7, ror #3
    1cc4:	000cbb01 	andeq	fp, ip, r1, lsl #22
    1cc8:	30010000 	andcc	r0, r1, r0
    1ccc:	01000010 	tsteq	r0, r0, lsl r0
    1cd0:	00116601 	andseq	r6, r1, r1, lsl #12
    1cd4:	15010200 	strne	r0, [r1, #-512]	; 0xfffffe00
    1cd8:	0300000e 	movweq	r0, #14
    1cdc:	000ed301 	andeq	sp, lr, r1, lsl #6
    1ce0:	c2010400 	andgt	r0, r1, #0, 8
    1ce4:	05000010 	streq	r0, [r0, #-16]
    1ce8:	00122401 	andseq	r2, r2, r1, lsl #8
    1cec:	d8010600 	stmdale	r1, {r9, sl}
    1cf0:	07000010 	smladeq	r0, r0, r0, r0
    1cf4:	000ef901 	andeq	pc, lr, r1, lsl #18
    1cf8:	53010800 	movwpl	r0, #6144	; 0x1800
    1cfc:	09000010 	stmdbeq	r0, {r4}
    1d00:	00106101 	andseq	r6, r0, r1, lsl #2
    1d04:	6f010a00 	svcvs	0x00010a00
    1d08:	0b000010 	bleq	1d50 <shift+0x1d50>
    1d0c:	000f6201 	andeq	r6, pc, r1, lsl #4
    1d10:	52010c00 	andpl	r0, r1, #0, 24
    1d14:	0d00000f 	stceq	0, cr0, [r0, #-60]	; 0xffffffc4
    1d18:	000cd701 	andeq	sp, ip, r1, lsl #14
    1d1c:	f0010e00 			; <UNDEFINED> instruction: 0xf0010e00
    1d20:	0f00000c 	svceq	0x0000000c
    1d24:	000f4301 	andeq	r4, pc, r1, lsl #6
    1d28:	29011000 	stmdbcs	r1, {ip}
    1d2c:	11000011 	tstne	r0, r1, lsl r0
    1d30:	00109801 	andseq	r9, r0, r1, lsl #16
    1d34:	1a011200 	bne	4653c <_bss_end+0x3cd58>
    1d38:	13000011 	movwne	r0, #17
    1d3c:	000dcb01 	andeq	ip, sp, r1, lsl #22
    1d40:	1a011400 	bne	46d48 <_bss_end+0x3d564>
    1d44:	1500000d 	strne	r0, [r0, #-13]
    1d48:	000ce401 	andeq	lr, ip, r1, lsl #8
    1d4c:	e1011600 	tst	r1, r0, lsl #12
    1d50:	1700000f 	strne	r0, [r0, -pc]
    1d54:	000d5101 	andeq	r5, sp, r1, lsl #2
    1d58:	8c011800 	stchi	8, cr1, [r1], {-0}
    1d5c:	1900000c 	stmdbne	r0, {r2, r3}
    1d60:	00110c01 	andseq	r0, r1, r1, lsl #24
    1d64:	1f011a00 	svcne	0x00011a00
    1d68:	1b00000f 	blne	1dac <shift+0x1dac>
    1d6c:	000ff901 	andeq	pc, pc, r1, lsl #18
    1d70:	25011c00 	strcs	r1, [r1, #-3072]	; 0xfffff400
    1d74:	1d00000d 	stcne	0, cr0, [r0, #-52]	; 0xffffffcc
    1d78:	000eb801 	andeq	fp, lr, r1, lsl #16
    1d7c:	07011e00 	streq	r1, [r1, -r0, lsl #28]
    1d80:	1f00000e 	svcne	0x0000000e
    1d84:	00108a01 	andseq	r8, r0, r1, lsl #20
    1d88:	f4012000 	vst4.8	{d2-d5}, [r1], r0
    1d8c:	21000010 	tstcs	r0, r0, lsl r0
    1d90:	00113501 	andseq	r3, r1, r1, lsl #10
    1d94:	43012200 	movwmi	r2, #4608	; 0x1200
    1d98:	23000011 	movwcs	r0, #17
    1d9c:	0010e601 	andseq	lr, r0, r1, lsl #12
    1da0:	36012400 	strcc	r2, [r1], -r0, lsl #8
    1da4:	2500000f 	strcs	r0, [r0, #-15]
    1da8:	000e7c01 	andeq	r7, lr, r1, lsl #24
    1dac:	34012600 	strcc	r2, [r1], #-1536	; 0xfffffa00
    1db0:	2700000d 	strcs	r0, [r0, -sp]
    1db4:	000eec01 	andeq	lr, lr, r1, lsl #24
    1db8:	21012800 	tstcs	r1, r0, lsl #16
    1dbc:	2900000e 	stmdbcs	r0, {r1, r2, r3}
    1dc0:	00120a01 	andseq	r0, r2, r1, lsl #20
    1dc4:	b5012a00 	strlt	r2, [r1, #-2560]	; 0xfffff600
    1dc8:	2b000010 	blcs	1e10 <shift+0x1e10>
    1dcc:	000e3101 	andeq	r3, lr, r1, lsl #2
    1dd0:	40012c00 	andmi	r2, r1, r0, lsl #24
    1dd4:	2d00000e 	stccs	0, cr0, [r0, #-56]	; 0xffffffc8
    1dd8:	000e4f01 	andeq	r4, lr, r1, lsl #30
    1ddc:	5e012e00 	cdppl	14, 0, cr2, cr1, cr0, {0}
    1de0:	2f00000e 	svccs	0x0000000e
    1de4:	000dec01 	andeq	lr, sp, r1, lsl #24
    1de8:	6d013000 	stcvs	0, cr3, [r1, #-0]
    1dec:	3100000e 	tstcc	r0, lr
    1df0:	00104401 	andseq	r4, r0, r1, lsl #8
    1df4:	8b013200 	blhi	4e5fc <_bss_end+0x44e18>
    1df8:	3300000e 	movwcc	r0, #14
    1dfc:	000e9a01 	andeq	r9, lr, r1, lsl #20
    1e00:	c5013400 	strgt	r3, [r1, #-1024]	; 0xfffffc00
    1e04:	3500000c 	strcc	r0, [r0, #-12]
    1e08:	000f8101 	andeq	r8, pc, r1, lsl #2
    1e0c:	91013600 	tstls	r1, r0, lsl #12
    1e10:	3700000f 	strcc	r0, [r0, -pc]
    1e14:	000fa101 	andeq	sl, pc, r1, lsl #2
    1e18:	da013800 	ble	4fe20 <_bss_end+0x4663c>
    1e1c:	3900000d 	stmdbcc	r0, {r0, r2, r3}
    1e20:	000fb101 	andeq	fp, pc, r1, lsl #2
    1e24:	c1013a00 	tstgt	r1, r0, lsl #20
    1e28:	3b00000f 	blcc	1e6c <shift+0x1e6c>
    1e2c:	000fd101 	andeq	sp, pc, r1, lsl #2
    1e30:	44013c00 	strmi	r3, [r1], #-3072	; 0xfffff400
    1e34:	3d00000d 	stccc	0, cr0, [r0, #-52]	; 0xffffffcc
    1e38:	000cfd01 	andeq	pc, ip, r1, lsl #26
    1e3c:	a9013e00 	stmdbge	r1, {r9, sl, fp, ip, sp}
    1e40:	3f00000e 	svccc	0x0000000e
    1e44:	000c9c01 	andeq	r9, ip, r1, lsl #24
    1e48:	ec014000 	stc	0, cr4, [r1], {-0}
    1e4c:	4100000f 	tstmi	r0, pc
    1e50:	0db20c00 	ldceq	12, cr0, [r2]
    1e54:	02020000 	andeq	r0, r2, #0
    1e58:	0e08028b 	cdpeq	2, 0, cr0, cr8, cr11, {4}
    1e5c:	04000002 	streq	r0, [r0], #-2
    1e60:	00000ece 	andeq	r0, r0, lr, asr #29
    1e64:	00480290 	umaaleq	r0, r8, r0, r2
    1e68:	04000000 	streq	r0, [r0], #-0
    1e6c:	00000de7 	andeq	r0, r0, r7, ror #27
    1e70:	00480291 	umaaleq	r0, r8, r1, r2
    1e74:	00010000 	andeq	r0, r1, r0
    1e78:	0001e705 	andeq	lr, r1, r5, lsl #14
    1e7c:	020e0300 	andeq	r0, lr, #0, 6
    1e80:	02230000 	eoreq	r0, r3, #0
    1e84:	25060000 	strcs	r0, [r6, #-0]
    1e88:	11000000 	mrsne	r0, (UNDEF: 0)
    1e8c:	02130500 	andseq	r0, r3, #0, 10
    1e90:	6f0d0000 	svcvs	0x000d0000
    1e94:	0200000f 	andeq	r0, r0, #15
    1e98:	23260294 			; <UNDEFINED> instruction: 0x23260294
    1e9c:	24000002 	strcs	r0, [r0], #-2
    1ea0:	400b403d 	andmi	r4, fp, sp, lsr r0
    1ea4:	40264010 	eormi	r4, r6, r0, lsl r0
    1ea8:	40034035 	andmi	r4, r3, r5, lsr r0
    1eac:	40144006 	andsmi	r4, r4, r6
    1eb0:	400d400e 	andmi	r4, sp, lr
    1eb4:	40124025 	andsmi	r4, r2, r5, lsr #32
    1eb8:	40024028 	andmi	r4, r2, r8, lsr #32
    1ebc:	40094018 	andmi	r4, r9, r8, lsl r0
    1ec0:	0000400a 	andeq	r4, r0, sl
    1ec4:	96070202 	strls	r0, [r7], -r2, lsl #4
    1ec8:	02000003 	andeq	r0, r0, #3
    1ecc:	02e60801 	rsceq	r0, r6, #65536	; 0x10000
    1ed0:	0f0e0000 	svceq	0x000e0000
    1ed4:	00026804 	andeq	r6, r2, r4, lsl #16
    1ed8:	11511000 	cmpne	r1, r0
    1edc:	01070000 	mrseq	r0, (UNDEF: 7)
    1ee0:	0000003a 	andeq	r0, r0, sl, lsr r0
    1ee4:	06055603 	streq	r5, [r5], -r3, lsl #12
    1ee8:	000002ad 	andeq	r0, r0, sp, lsr #5
    1eec:	000d8c01 	andeq	r8, sp, r1, lsl #24
    1ef0:	97010000 	strls	r0, [r1, -r0]
    1ef4:	0100000d 	tsteq	r0, sp
    1ef8:	000da901 	andeq	sl, sp, r1, lsl #18
    1efc:	c3010200 	movwgt	r0, #4608	; 0x1200
    1f00:	0300000d 	movweq	r0, #13
    1f04:	00107d01 	andseq	r7, r0, r1, lsl #26
    1f08:	fb010400 	blx	42f12 <_bss_end+0x3972e>
    1f0c:	0500000d 	streq	r0, [r0, #-13]
    1f10:	00102201 	andseq	r2, r0, r1, lsl #4
    1f14:	02000600 	andeq	r0, r0, #0, 12
    1f18:	01990502 	orrseq	r0, r9, r2, lsl #10
    1f1c:	08020000 	stmdaeq	r2, {}	; <UNPREDICTABLE>
    1f20:	000f0807 	andeq	r0, pc, r7, lsl #16
    1f24:	04040200 	streq	r0, [r4], #-512	; 0xfffffe00
    1f28:	00000cb5 			; <UNDEFINED> instruction: 0x00000cb5
    1f2c:	ad030802 	stcge	8, cr0, [r3, #-8]
    1f30:	0200000c 	andeq	r0, r0, #12
    1f34:	0ee50408 	cdpeq	4, 14, cr0, cr5, cr8, {0}
    1f38:	10020000 	andne	r0, r2, r0
    1f3c:	00101303 	andseq	r1, r0, r3, lsl #6
    1f40:	100a1100 	andne	r1, sl, r0, lsl #2
    1f44:	2a040000 	bcs	101f4c <_bss_end+0xf8768>
    1f48:	00026910 	andeq	r6, r2, r0, lsl r9
    1f4c:	02d70300 	sbcseq	r0, r7, #0, 6
    1f50:	02ee0000 	rsceq	r0, lr, #0
    1f54:	00120000 	andseq	r0, r2, r0
    1f58:	000b5f07 	andeq	r5, fp, r7, lsl #30
    1f5c:	02e32f00 	rsceq	r2, r3, #0, 30
    1f60:	d8070000 	stmdale	r7, {}	; <UNPREDICTABLE>
    1f64:	3000000b 	andcc	r0, r0, fp
    1f68:	000002e3 	andeq	r0, r0, r3, ror #5
    1f6c:	0002d703 	andeq	sp, r2, r3, lsl #14
    1f70:	00031200 	andeq	r1, r3, r0, lsl #4
    1f74:	00250600 	eoreq	r0, r5, r0, lsl #12
    1f78:	00010000 	andeq	r0, r1, r0
    1f7c:	0002ee08 	andeq	lr, r2, r8, lsl #28
    1f80:	02099000 	andeq	r9, r9, #0
    1f84:	05000003 	streq	r0, [r0, #-3]
    1f88:	0097bc03 	addseq	fp, r7, r3, lsl #24
    1f8c:	02f80800 	rscseq	r0, r8, #0, 16
    1f90:	09910000 	ldmibeq	r1, {}	; <UNPREDICTABLE>
    1f94:	00000302 	andeq	r0, r0, r2, lsl #6
    1f98:	97c80305 	strbls	r0, [r8, r5, lsl #6]
    1f9c:	31000000 	mrscc	r0, (UNDEF: 0)
    1fa0:	05000001 	streq	r0, [r0, #-1]
    1fa4:	6b040100 	blvs	1023ac <_bss_end+0xf8bc8>
    1fa8:	0600000c 	streq	r0, [r0], -ip
    1fac:	00001234 	andeq	r1, r0, r4, lsr r2
    1fb0:	0012c91d 	andseq	ip, r2, sp, lsl r9
    1fb4:	0012fd00 	andseq	pc, r2, r0, lsl #26
    1fb8:	00000c00 	andeq	r0, r0, r0, lsl #24
    1fbc:	00000000 	andeq	r0, r0, r0
    1fc0:	000d0b00 	andeq	r0, sp, r0, lsl #22
    1fc4:	05040700 	streq	r0, [r4, #-1792]	; 0xfffff900
    1fc8:	00746e69 	rsbseq	r6, r4, r9, ror #28
    1fcc:	0012b508 	andseq	fp, r2, r8, lsl #10
    1fd0:	17d10200 	ldrbne	r0, [r1, r0, lsl #4]
    1fd4:	00000039 	andeq	r0, r0, r9, lsr r0
    1fd8:	12070401 	andne	r0, r7, #16777216	; 0x1000000
    1fdc:	0100000f 	tsteq	r0, pc
    1fe0:	01160508 	tsteq	r6, r8, lsl #10
    1fe4:	08010000 	stmdaeq	r1, {}	; <UNPREDICTABLE>
    1fe8:	000ee004 	andeq	lr, lr, r4
    1fec:	06010100 	streq	r0, [r1], -r0, lsl #2
    1ff0:	000002df 	ldrdeq	r0, [r0], -pc	; <UNPREDICTABLE>
    1ff4:	dd080101 	stfles	f0, [r8, #-4]
    1ff8:	01000002 	tsteq	r0, r2
    1ffc:	01990502 	orrseq	r0, r9, r2, lsl #10
    2000:	02010000 	andeq	r0, r1, #0
    2004:	00039607 	andeq	r9, r3, r7, lsl #12
    2008:	05040100 	streq	r0, [r4, #-256]	; 0xffffff00
    200c:	0000011b 	andeq	r0, r0, fp, lsl r1
    2010:	0d070401 	cfstrseq	mvf0, [r7, #-4]
    2014:	0100000f 	tsteq	r0, pc
    2018:	0f080708 	svceq	0x00080708
    201c:	04090000 	streq	r0, [r9], #-0
    2020:	00008603 	andeq	r8, r0, r3, lsl #12
    2024:	08010100 	stmdaeq	r1, {r8}
    2028:	000002e6 	andeq	r0, r0, r6, ror #5
    202c:	00135c0a 	andseq	r5, r3, sl, lsl #24
    2030:	09210300 	stmdbeq	r1!, {r8, r9}
    2034:	0000007f 	andeq	r0, r0, pc, ror r0
    2038:	00009520 	andeq	r9, r0, r0, lsr #10
    203c:	00000118 	andeq	r0, r0, r8, lsl r1
    2040:	012f9c01 			; <UNDEFINED> instruction: 0x012f9c01
    2044:	6d0b0000 	stcvs	0, cr0, [fp, #-0]
    2048:	0f260100 	svceq	0x00260100
    204c:	0000007f 	andeq	r0, r0, pc, ror r0
    2050:	63045001 	movwvs	r5, #16385	; 0x4001
    2054:	26062700 	strcs	r2, [r6], -r0, lsl #14
    2058:	16000000 	strne	r0, [r0], -r0
    205c:	0c000000 	stceq	0, cr0, [r0], {-0}
    2060:	04000000 	streq	r0, [r0], #-0
    2064:	0928006e 	stmdbeq	r8!, {r1, r2, r3, r5, r6}
    2068:	0000002d 	andeq	r0, r0, sp, lsr #32
    206c:	00000056 	andeq	r0, r0, r6, asr r0
    2070:	00000044 	andeq	r0, r0, r4, asr #32
    2074:	2a007302 	bcs	1ec84 <_bss_end+0x154a0>
    2078:	00008109 	andeq	r8, r0, r9, lsl #2
    207c:	0000ad00 	andeq	sl, r0, r0, lsl #26
    2080:	00009700 	andeq	r9, r0, r0, lsl #14
    2084:	00690200 	rsbeq	r0, r9, r0, lsl #4
    2088:	0039102d 	eorseq	r1, r9, sp, lsr #32
    208c:	01050000 	mrseq	r0, (UNDEF: 5)
    2090:	00ff0000 	rscseq	r0, pc, r0
    2094:	63050000 	movwvs	r0, #20480	; 0x5000
    2098:	2e000013 	mcrcs	0, 0, r0, cr0, cr3, {0}
    209c:	00007111 	andeq	r7, r0, r1, lsl r1
    20a0:	00012b00 	andeq	r2, r1, r0, lsl #22
    20a4:	00012500 	andeq	r2, r1, r0, lsl #10
    20a8:	12bc0500 	adcsne	r0, ip, #0, 10
    20ac:	122f0000 	eorne	r0, pc, #0
    20b0:	0000012f 	andeq	r0, r0, pc, lsr #2
    20b4:	0000015d 	andeq	r0, r0, sp, asr r1
    20b8:	00000145 	andeq	r0, r0, r5, asr #2
    20bc:	30006402 	andcc	r6, r0, r2, lsl #8
    20c0:	00003910 	andeq	r3, r0, r0, lsl r9
    20c4:	0001b800 	andeq	fp, r1, r0, lsl #16
    20c8:	0001ae00 	andeq	sl, r1, r0, lsl #28
    20cc:	71030000 	mrsvc	r0, (UNDEF: 3)
    20d0:	00000000 	andeq	r0, r0, r0

Disassembly of section .debug_abbrev:

00000000 <.debug_abbrev>:
   0:	3f002e01 	svccc	0x00002e01
   4:	3a0e0319 	bcc	380c70 <_bss_end+0x37748c>
   8:	0b3b0121 	bleq	ec0494 <_bss_end+0xeb6cb0>
   c:	11112139 	tstne	r1, r9, lsr r1
  10:	40061201 	andmi	r1, r6, r1, lsl #4
  14:	00197a18 	andseq	r7, r9, r8, lsl sl
  18:	00050200 	andeq	r0, r5, r0, lsl #4
  1c:	00001349 	andeq	r1, r0, r9, asr #6
  20:	3f012e03 	svccc	0x00012e03
  24:	3a0e0319 	bcc	380c90 <_bss_end+0x3774ac>
  28:	0b3b0121 	bleq	ec04b4 <_bss_end+0xeb6cd0>
  2c:	3c122139 	ldfccs	f2, [r2], {57}	; 0x39
  30:	00130119 	andseq	r0, r3, r9, lsl r1
  34:	012e0400 			; <UNDEFINED> instruction: 0x012e0400
  38:	01111347 	tsteq	r1, r7, asr #6
  3c:	18400612 	stmdane	r0, {r1, r4, r9, sl}^
  40:	1301197a 	movwne	r1, #6522	; 0x197a
  44:	05050000 	streq	r0, [r5, #-0]
  48:	3a080300 	bcc	200c50 <_bss_end+0x1f746c>
  4c:	0b3b0121 	bleq	ec04d8 <_bss_end+0xeb6cf4>
  50:	13490b39 	movtne	r0, #39737	; 0x9b39
  54:	00001802 	andeq	r1, r0, r2, lsl #16
  58:	25011106 	strcs	r1, [r1, #-262]	; 0xfffffefa
  5c:	030b130e 	movweq	r1, #45838	; 0xb30e
  60:	110e1b0e 	tstne	lr, lr, lsl #22
  64:	10061201 	andne	r1, r6, r1, lsl #4
  68:	07000017 	smladeq	r0, r7, r0, r0
  6c:	0e030139 	mcreq	1, 0, r0, cr3, cr9, {1}
  70:	0b3b0b3a 	bleq	ec2d60 <_bss_end+0xeb957c>
  74:	13010b39 	movwne	r0, #6969	; 0x1b39
  78:	16080000 	strne	r0, [r8], -r0
  7c:	3a0e0300 	bcc	380c84 <_bss_end+0x3774a0>
  80:	390b3b0b 	stmdbcc	fp, {r0, r1, r3, r8, r9, fp, ip, sp}
  84:	0013490b 	andseq	r4, r3, fp, lsl #18
  88:	012e0900 			; <UNDEFINED> instruction: 0x012e0900
  8c:	0e03193f 			; <UNDEFINED> instruction: 0x0e03193f
  90:	0b3b0b3a 	bleq	ec2d80 <_bss_end+0xeb959c>
  94:	13490b39 	movtne	r0, #39737	; 0x9b39
  98:	0000193c 	andeq	r1, r0, ip, lsr r9
  9c:	0b000f0a 	bleq	3ccc <shift+0x3ccc>
  a0:	0013490b 	andseq	r4, r3, fp, lsl #18
  a4:	00240b00 	eoreq	r0, r4, r0, lsl #22
  a8:	0b3e0b0b 	bleq	f82cdc <_bss_end+0xf794f8>
  ac:	00000e03 	andeq	r0, r0, r3, lsl #28
  b0:	4900050c 	stmdbmi	r0, {r2, r3, r8, sl}
  b4:	00180213 	andseq	r0, r8, r3, lsl r2
  b8:	00240d00 	eoreq	r0, r4, r0, lsl #26
  bc:	0b3e0b0b 	bleq	f82cf0 <_bss_end+0xf7950c>
  c0:	00000803 	andeq	r0, r0, r3, lsl #16
  c4:	47012e0e 	strmi	r2, [r1, -lr, lsl #28]
  c8:	12011113 	andne	r1, r1, #-1073741820	; 0xc0000004
  cc:	7a184006 	bvc	6100ec <_bss_end+0x606908>
  d0:	00000019 	andeq	r0, r0, r9, lsl r0
  d4:	03002801 	movweq	r2, #2049	; 0x801
  d8:	000b1c0e 	andeq	r1, fp, lr, lsl #24
  dc:	00050200 	andeq	r0, r5, r0, lsl #4
  e0:	213a0e03 	teqcs	sl, r3, lsl #28
  e4:	390b3b01 	stmdbcc	fp, {r0, r8, r9, fp, ip, sp}
  e8:	0213490b 	andseq	r4, r3, #180224	; 0x2c000
  ec:	03000018 	movweq	r0, #24
  f0:	0b0b0024 	bleq	2c0188 <_bss_end+0x2b69a4>
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
 140:	3a0e0319 	bcc	380dac <_bss_end+0x3775c8>
 144:	0b3b0321 	bleq	ec0dd0 <_bss_end+0xeb75ec>
 148:	6e0e2139 	mcrvs	1, 0, r2, cr14, cr9, {1}
 14c:	0121320e 			; <UNDEFINED> instruction: 0x0121320e
 150:	1364193c 	cmnne	r4, #60, 18	; 0xf0000
 154:	00001301 	andeq	r1, r0, r1, lsl #6
 158:	0b000f0b 	bleq	3d8c <shift+0x3d8c>
 15c:	13490421 	movtne	r0, #37921	; 0x9421
 160:	2e0c0000 	cdpcs	0, 0, cr0, cr12, cr0, {0}
 164:	3a134701 	bcc	4d1d70 <_bss_end+0x4c858c>
 168:	0b3b0121 	bleq	ec05f4 <_bss_end+0xeb6e10>
 16c:	64062139 	strvs	r2, [r6], #-313	; 0xfffffec7
 170:	12011113 	andne	r1, r1, #-1073741820	; 0xc0000004
 174:	7c184006 	ldcvc	0, cr4, [r8], {6}
 178:	00130119 	andseq	r0, r3, r9, lsl r1
 17c:	00050d00 	andeq	r0, r5, r0, lsl #26
 180:	18021331 	stmdane	r2, {r0, r4, r5, r8, r9, ip}
 184:	110e0000 	mrsne	r0, (UNDEF: 14)
 188:	130e2501 	movwne	r2, #58625	; 0xe501
 18c:	1b0e030b 	blne	380dc0 <_bss_end+0x3775dc>
 190:	1201110e 	andne	r1, r1, #-2147483645	; 0x80000003
 194:	00171006 	andseq	r1, r7, r6
 198:	00240f00 	eoreq	r0, r4, r0, lsl #30
 19c:	0b3e0b0b 	bleq	f82dd0 <_bss_end+0xf795ec>
 1a0:	00000803 	andeq	r0, r0, r3, lsl #16
 1a4:	03001610 	movweq	r1, #1552	; 0x610
 1a8:	3b0b3a0e 	blcc	2ce9e8 <_bss_end+0x2c5204>
 1ac:	490b390b 	stmdbmi	fp, {r0, r1, r3, r8, fp, ip, sp}
 1b0:	11000013 	tstne	r0, r3, lsl r0
 1b4:	08030139 	stmdaeq	r3, {r0, r3, r4, r5, r8}
 1b8:	0b3b0b3a 	bleq	ec2ea8 <_bss_end+0xeb96c4>
 1bc:	13010b39 	movwne	r0, #6969	; 0x1b39
 1c0:	34120000 	ldrcc	r0, [r2], #-0
 1c4:	3a0e0300 	bcc	380dcc <_bss_end+0x3775e8>
 1c8:	390b3b0b 	stmdbcc	fp, {r0, r1, r3, r8, r9, fp, ip, sp}
 1cc:	3c13490b 			; <UNDEFINED> instruction: 0x3c13490b
 1d0:	6c0b1c19 	stcvs	12, cr1, [fp], {25}
 1d4:	13000019 	movwne	r0, #25
 1d8:	0e030104 	adfeqs	f0, f3, f4
 1dc:	0b3e196d 	bleq	f86798 <_bss_end+0xf7cfb4>
 1e0:	13490b0b 	movtne	r0, #39691	; 0x9b0b
 1e4:	0b3b0b3a 	bleq	ec2ed4 <_bss_end+0xeb96f0>
 1e8:	13010b39 	movwne	r0, #6969	; 0x1b39
 1ec:	28140000 	ldmdacs	r4, {}	; <UNPREDICTABLE>
 1f0:	1c080300 	stcne	3, cr0, [r8], {-0}
 1f4:	1500000b 	strne	r0, [r0, #-11]
 1f8:	0e030104 	adfeqs	f0, f3, f4
 1fc:	0b3e196d 	bleq	f867b8 <_bss_end+0xf7cfd4>
 200:	13490b0b 	movtne	r0, #39691	; 0x9b0b
 204:	0b3b0b3a 	bleq	ec2ef4 <_bss_end+0xeb9710>
 208:	00000b39 	andeq	r0, r0, r9, lsr fp
 20c:	03010216 	movweq	r0, #4630	; 0x1216
 210:	3a0b0b0e 	bcc	2c2e50 <_bss_end+0x2b966c>
 214:	390b3b0b 	stmdbcc	fp, {r0, r1, r3, r8, r9, fp, ip, sp}
 218:	0013010b 	andseq	r0, r3, fp, lsl #2
 21c:	000d1700 	andeq	r1, sp, r0, lsl #14
 220:	0b3a0e03 	bleq	e83a34 <_bss_end+0xe7a250>
 224:	0b390b3b 	bleq	e42f18 <_bss_end+0xe39734>
 228:	0b381349 	bleq	e04f54 <_bss_end+0xdfb770>
 22c:	2e180000 	cdpcs	0, 1, cr0, cr8, cr0, {0}
 230:	03193f01 	tsteq	r9, #1, 30
 234:	3b0b3a0e 	blcc	2cea74 <_bss_end+0x2c5290>
 238:	6e0b390b 	vmlavs.f16	s6, s22, s22	; <UNPREDICTABLE>
 23c:	3213490e 	andscc	r4, r3, #229376	; 0x38000
 240:	64193c0b 	ldrvs	r3, [r9], #-3083	; 0xfffff3f5
 244:	00130113 	andseq	r0, r3, r3, lsl r1
 248:	012e1900 			; <UNDEFINED> instruction: 0x012e1900
 24c:	0e03193f 			; <UNDEFINED> instruction: 0x0e03193f
 250:	0b3b0b3a 	bleq	ec2f40 <_bss_end+0xeb975c>
 254:	0e6e0b39 	vmoveq.8	d14[5], r0
 258:	0b321349 	bleq	c84f84 <_bss_end+0xc7b7a0>
 25c:	1364193c 	cmnne	r4, #60, 18	; 0xf0000
 260:	341a0000 	ldrcc	r0, [sl], #-0
 264:	3a0e0300 	bcc	380e6c <_bss_end+0x377688>
 268:	390b3b0b 	stmdbcc	fp, {r0, r1, r3, r8, r9, fp, ip, sp}
 26c:	3f13490b 	svccc	0x0013490b
 270:	00193c19 	andseq	r3, r9, r9, lsl ip
 274:	00341b00 	eorseq	r1, r4, r0, lsl #22
 278:	0b3a1347 	bleq	e84f9c <_bss_end+0xe7b7b8>
 27c:	0b390b3b 	bleq	e42f70 <_bss_end+0xe3978c>
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
 2ac:	3b0b3a13 	blcc	2ceb00 <_bss_end+0x2c531c>
 2b0:	640b390b 	strvs	r3, [fp], #-2315	; 0xfffff6f5
 2b4:	12011113 	andne	r1, r1, #-1073741820	; 0xc0000004
 2b8:	7a184006 	bvc	6102d8 <_bss_end+0x606af4>
 2bc:	00130119 	andseq	r0, r3, r9, lsl r1
 2c0:	012e1f00 			; <UNDEFINED> instruction: 0x012e1f00
 2c4:	0b3a1347 	bleq	e84fe8 <_bss_end+0xe7b804>
 2c8:	13640b39 	cmnne	r4, #58368	; 0xe400
 2cc:	06120111 			; <UNDEFINED> instruction: 0x06120111
 2d0:	197a1840 	ldmdbne	sl!, {r6, fp, ip}^
 2d4:	00001301 	andeq	r1, r0, r1, lsl #6
 2d8:	47012e20 	strmi	r2, [r1, -r0, lsr #28]
 2dc:	3b0b3a13 	blcc	2ceb30 <_bss_end+0x2c534c>
 2e0:	640b390b 	strvs	r3, [fp], #-2315	; 0xfffff6f5
 2e4:	010b2013 	tsteq	fp, r3, lsl r0
 2e8:	21000013 	tstcs	r0, r3, lsl r0
 2ec:	0e030005 	cdpeq	0, 0, cr0, cr3, cr5, {0}
 2f0:	19341349 	ldmdbne	r4!, {r0, r3, r6, r8, r9, ip}
 2f4:	05220000 	streq	r0, [r2, #-0]!
 2f8:	3a0e0300 	bcc	380f00 <_bss_end+0x37771c>
 2fc:	390b3b0b 	stmdbcc	fp, {r0, r1, r3, r8, r9, fp, ip, sp}
 300:	0013490b 	andseq	r4, r3, fp, lsl #18
 304:	012e2300 			; <UNDEFINED> instruction: 0x012e2300
 308:	0e6e1331 	mcreq	3, 3, r1, cr14, cr1, {1}
 30c:	01111364 	tsteq	r1, r4, ror #6
 310:	18400612 	stmdane	r0, {r1, r4, r9, sl}^
 314:	0000197a 	andeq	r1, r0, sl, ror r9
 318:	00280100 	eoreq	r0, r8, r0, lsl #2
 31c:	0b1c0e03 	bleq	703b30 <_bss_end+0x6fa34c>
 320:	05020000 	streq	r0, [r2, #-0]
 324:	00134900 	andseq	r4, r3, r0, lsl #18
 328:	00050300 	andeq	r0, r5, r0, lsl #6
 32c:	213a0803 	teqcs	sl, r3, lsl #16
 330:	390b3b01 	stmdbcc	fp, {r0, r8, r9, fp, ip, sp}
 334:	0213490b 	andseq	r4, r3, #180224	; 0x2c000
 338:	04000018 	streq	r0, [r0], #-24	; 0xffffffe8
 33c:	13490005 	movtne	r0, #36869	; 0x9005
 340:	00001934 	andeq	r1, r0, r4, lsr r9
 344:	0b002405 	bleq	9360 <.divsi3_skip_div0_test+0x7c>
 348:	030b3e0b 	movweq	r3, #48651	; 0xbe0b
 34c:	0600000e 	streq	r0, [r0], -lr
 350:	0e030005 	cdpeq	0, 0, cr0, cr3, cr5, {0}
 354:	3b01213a 	blcc	48844 <_bss_end+0x3f060>
 358:	490b390b 	stmdbmi	fp, {r0, r1, r3, r8, fp, ip, sp}
 35c:	00180213 	andseq	r0, r8, r3, lsl r2
 360:	00050700 	andeq	r0, r5, r0, lsl #14
 364:	13490e03 	movtne	r0, #40451	; 0x9e03
 368:	18021934 	stmdane	r2, {r2, r4, r5, r8, fp, ip}
 36c:	26080000 	strcs	r0, [r8], -r0
 370:	00134900 	andseq	r4, r3, r0, lsl #18
 374:	012e0900 			; <UNDEFINED> instruction: 0x012e0900
 378:	0e03193f 			; <UNDEFINED> instruction: 0x0e03193f
 37c:	3b04213a 	blcc	10886c <_bss_end+0xff088>
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
 3ac:	3a134701 	bcc	4d1fb8 <_bss_end+0x4c87d4>
 3b0:	0b3b0121 	bleq	ec083c <_bss_end+0xeb7058>
 3b4:	64062139 	strvs	r2, [r6], #-313	; 0xfffffec7
 3b8:	12011113 	andne	r1, r1, #-1073741820	; 0xc0000004
 3bc:	7a184006 	bvc	6103dc <_bss_end+0x606bf8>
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
 3e8:	3a134701 	bcc	4d1ff4 <_bss_end+0x4c8810>
 3ec:	0b3b0121 	bleq	ec0878 <_bss_end+0xeb7094>
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
 418:	0b0b0b3e 	bleq	2c3118 <_bss_end+0x2b9934>
 41c:	0b3a1349 	bleq	e85148 <_bss_end+0xe7b964>
 420:	0b390b3b 	bleq	e43114 <_bss_end+0xe39930>
 424:	00001301 	andeq	r1, r0, r1, lsl #6
 428:	31000512 	tstcc	r0, r2, lsl r5
 42c:	00180213 	andseq	r0, r8, r3, lsl r2
 430:	01111300 	tsteq	r1, r0, lsl #6
 434:	0b130e25 	bleq	4c3cd0 <_bss_end+0x4ba4ec>
 438:	0e1b0e03 	cdpeq	14, 1, cr0, cr11, cr3, {0}
 43c:	06120111 			; <UNDEFINED> instruction: 0x06120111
 440:	00001710 	andeq	r1, r0, r0, lsl r7
 444:	0b002414 	bleq	949c <.divsi3_skip_div0_test+0x1b8>
 448:	030b3e0b 	movweq	r3, #48651	; 0xbe0b
 44c:	15000008 	strne	r0, [r0, #-8]
 450:	08030139 	stmdaeq	r3, {r0, r3, r4, r5, r8}
 454:	0b3b0b3a 	bleq	ec3144 <_bss_end+0xeb9960>
 458:	13010b39 	movwne	r0, #6969	; 0x1b39
 45c:	34160000 	ldrcc	r0, [r6], #-0
 460:	3a0e0300 	bcc	381068 <_bss_end+0x377884>
 464:	390b3b0b 	stmdbcc	fp, {r0, r1, r3, r8, r9, fp, ip, sp}
 468:	3c13490b 			; <UNDEFINED> instruction: 0x3c13490b
 46c:	6c0b1c19 	stcvs	12, cr1, [fp], {25}
 470:	17000019 	smladne	r0, r9, r0, r0
 474:	0e030102 	adfeqs	f0, f3, f2
 478:	0b3a0b0b 	bleq	e830ac <_bss_end+0xe798c8>
 47c:	0b390b3b 	bleq	e43170 <_bss_end+0xe3998c>
 480:	00001301 	andeq	r1, r0, r1, lsl #6
 484:	03000d18 	movweq	r0, #3352	; 0xd18
 488:	3b0b3a0e 	blcc	2cecc8 <_bss_end+0x2c54e4>
 48c:	490b390b 	stmdbmi	fp, {r0, r1, r3, r8, fp, ip, sp}
 490:	000b3813 	andeq	r3, fp, r3, lsl r8
 494:	012e1900 			; <UNDEFINED> instruction: 0x012e1900
 498:	0e03193f 			; <UNDEFINED> instruction: 0x0e03193f
 49c:	0b3b0b3a 	bleq	ec318c <_bss_end+0xeb99a8>
 4a0:	0e6e0b39 	vmoveq.8	d14[5], r0
 4a4:	193c0b32 	ldmdbne	ip!, {r1, r4, r5, r8, r9, fp}
 4a8:	13011364 	movwne	r1, #4964	; 0x1364
 4ac:	2e1a0000 	cdpcs	0, 1, cr0, cr10, cr0, {0}
 4b0:	03193f01 	tsteq	r9, #1, 30
 4b4:	3b0b3a0e 	blcc	2cecf4 <_bss_end+0x2c5510>
 4b8:	6e0b390b 	vmlavs.f16	s6, s22, s22	; <UNPREDICTABLE>
 4bc:	3c0b320e 	sfmcc	f3, 4, [fp], {14}
 4c0:	00136419 	andseq	r6, r3, r9, lsl r4
 4c4:	00101b00 	andseq	r1, r0, r0, lsl #22
 4c8:	13490b0b 	movtne	r0, #39691	; 0x9b0b
 4cc:	341c0000 	ldrcc	r0, [ip], #-0
 4d0:	3a0e0300 	bcc	3810d8 <_bss_end+0x3778f4>
 4d4:	390b3b0b 	stmdbcc	fp, {r0, r1, r3, r8, r9, fp, ip, sp}
 4d8:	3f13490b 	svccc	0x0013490b
 4dc:	00193c19 	andseq	r3, r9, r9, lsl ip
 4e0:	00341d00 	eorseq	r1, r4, r0, lsl #26
 4e4:	0b3a1347 	bleq	e85208 <_bss_end+0xe7ba24>
 4e8:	0b390b3b 	bleq	e431dc <_bss_end+0xe399f8>
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
 518:	3b0b3a13 	blcc	2ced6c <_bss_end+0x2c5588>
 51c:	640b390b 	strvs	r3, [fp], #-2315	; 0xfffff6f5
 520:	010b2013 	tsteq	fp, r3, lsl r0
 524:	21000013 	tstcs	r0, r3, lsl r0
 528:	0e030005 	cdpeq	0, 0, cr0, cr3, cr5, {0}
 52c:	19341349 	ldmdbne	r4!, {r0, r3, r6, r8, r9, ip}
 530:	05220000 	streq	r0, [r2, #-0]!
 534:	3a0e0300 	bcc	38113c <_bss_end+0x377958>
 538:	390b3b0b 	stmdbcc	fp, {r0, r1, r3, r8, r9, fp, ip, sp}
 53c:	0013490b 	andseq	r4, r3, fp, lsl #18
 540:	012e2300 			; <UNDEFINED> instruction: 0x012e2300
 544:	0e6e1331 	mcreq	3, 3, r1, cr14, cr1, {1}
 548:	01111364 	tsteq	r1, r4, ror #6
 54c:	18400612 	stmdane	r0, {r1, r4, r9, sl}^
 550:	0000197a 	andeq	r1, r0, sl, ror r9
 554:	00280100 	eoreq	r0, r8, r0, lsl #2
 558:	0b1c0e03 	bleq	703d6c <_bss_end+0x6fa588>
 55c:	05020000 	streq	r0, [r2, #-0]
 560:	00134900 	andseq	r4, r3, r0, lsl #18
 564:	00050300 	andeq	r0, r5, r0, lsl #6
 568:	19341349 	ldmdbne	r4!, {r0, r3, r6, r8, r9, ip}
 56c:	2e040000 	cdpcs	0, 0, cr0, cr4, cr0, {0}
 570:	03193f01 	tsteq	r9, #1, 30
 574:	3b0b3a0e 	blcc	2cedb4 <_bss_end+0x2c55d0>
 578:	6e0b390b 	vmlavs.f16	s6, s22, s22	; <UNPREDICTABLE>
 57c:	0121320e 			; <UNDEFINED> instruction: 0x0121320e
 580:	1364193c 	cmnne	r4, #60, 18	; 0xf0000
 584:	00001301 	andeq	r1, r0, r1, lsl #6
 588:	3f012e05 	svccc	0x00012e05
 58c:	3a0e0319 	bcc	3811f8 <_bss_end+0x377a14>
 590:	390b3b0b 	stmdbcc	fp, {r0, r1, r3, r8, r9, fp, ip, sp}
 594:	490e6e0b 	stmdbmi	lr, {r0, r1, r3, r9, sl, fp, sp, lr}
 598:	3c0b3213 	sfmcc	f3, 4, [fp], {19}
 59c:	01136419 	tsteq	r3, r9, lsl r4
 5a0:	06000013 			; <UNDEFINED> instruction: 0x06000013
 5a4:	0b0b0024 	bleq	2c063c <_bss_end+0x2b6e58>
 5a8:	0e030b3e 	vmoveq.16	d3[0], r0
 5ac:	26070000 	strcs	r0, [r7], -r0
 5b0:	00134900 	andseq	r4, r3, r0, lsl #18
 5b4:	00280800 	eoreq	r0, r8, r0, lsl #16
 5b8:	051c0e03 	ldreq	r0, [ip, #-3587]	; 0xfffff1fd
 5bc:	2e090000 	cdpcs	0, 0, cr0, cr9, cr0, {0}
 5c0:	3a134701 	bcc	4d21cc <_bss_end+0x4c89e8>
 5c4:	0b3b0121 	bleq	ec0a50 <_bss_end+0xeb726c>
 5c8:	64062139 	strvs	r2, [r6], #-313	; 0xfffffec7
 5cc:	12011113 	andne	r1, r1, #-1073741820	; 0xc0000004
 5d0:	7c184006 	ldcvc	0, cr4, [r8], {6}
 5d4:	00130119 	andseq	r0, r3, r9, lsl r1
 5d8:	00050a00 	andeq	r0, r5, r0, lsl #20
 5dc:	13490e03 	movtne	r0, #40451	; 0x9e03
 5e0:	18021934 	stmdane	r2, {r2, r4, r5, r8, fp, ip}
 5e4:	0f0b0000 	svceq	0x000b0000
 5e8:	04210b00 	strteq	r0, [r1], #-2816	; 0xfffff500
 5ec:	00001349 	andeq	r1, r0, r9, asr #6
 5f0:	0301040c 	movweq	r0, #5132	; 0x140c
 5f4:	3e196d0e 	cdpcc	13, 1, cr6, cr9, cr14, {0}
 5f8:	490b0b0b 	stmdbmi	fp, {r0, r1, r3, r8, r9, fp}
 5fc:	3b0b3a13 	blcc	2cee50 <_bss_end+0x2c566c>
 600:	010b390b 	tsteq	fp, fp, lsl #18
 604:	0d000013 	stceq	0, cr0, [r0, #-76]	; 0xffffffb4
 608:	13470034 	movtne	r0, #28724	; 0x7034
 60c:	020e0000 	andeq	r0, lr, #0
 610:	0b0e0301 	bleq	38121c <_bss_end+0x377a38>
 614:	0b3a0421 	bleq	e816a0 <_bss_end+0xe77ebc>
 618:	21390b3b 	teqcs	r9, fp, lsr fp
 61c:	00130107 	andseq	r0, r3, r7, lsl #2
 620:	000d0f00 	andeq	r0, sp, r0, lsl #30
 624:	0b3a0e03 	bleq	e83e38 <_bss_end+0xe7a654>
 628:	0b390b3b 	bleq	e4331c <_bss_end+0xe39b38>
 62c:	21381349 	teqcs	r8, r9, asr #6
 630:	10000000 	andne	r0, r0, r0
 634:	0e030034 	mcreq	0, 0, r0, cr3, cr4, {1}
 638:	0b3b0b3a 	bleq	ec3328 <_bss_end+0xeb9b44>
 63c:	13490b39 	movtne	r0, #39737	; 0x9b39
 640:	193c193f 	ldmdbne	ip!, {r0, r1, r2, r3, r4, r5, r8, fp, ip}
 644:	34110000 	ldrcc	r0, [r1], #-0
 648:	3a0e0300 	bcc	381250 <_bss_end+0x377a6c>
 64c:	0b3b0421 	bleq	ec16d8 <_bss_end+0xeb7ef4>
 650:	491a2139 	ldmdbmi	sl, {r0, r3, r4, r5, r8, sp}
 654:	1c193c13 	ldcne	12, cr3, [r9], {19}
 658:	00196c06 	andseq	r6, r9, r6, lsl #24
 65c:	00051200 	andeq	r1, r5, r0, lsl #4
 660:	213a0e03 	teqcs	sl, r3, lsl #28
 664:	390b3b01 	stmdbcc	fp, {r0, r8, r9, fp, ip, sp}
 668:	0213490b 	andseq	r4, r3, #180224	; 0x2c000
 66c:	13000018 	movwne	r0, #24
 670:	08030034 	stmdaeq	r3, {r2, r4, r5}
 674:	3b01213a 	blcc	48b64 <_bss_end+0x3f380>
 678:	490b390b 	stmdbmi	fp, {r0, r1, r3, r8, fp, ip, sp}
 67c:	00180213 	andseq	r0, r8, r3, lsl r2
 680:	00051400 	andeq	r1, r5, r0, lsl #8
 684:	213a0803 	teqcs	sl, r3, lsl #16
 688:	390b3b01 	stmdbcc	fp, {r0, r8, r9, fp, ip, sp}
 68c:	0213490b 	andseq	r4, r3, #180224	; 0x2c000
 690:	15000018 	strne	r0, [r0, #-24]	; 0xffffffe8
 694:	0e030016 	mcreq	0, 0, r0, cr3, cr6, {0}
 698:	3b02213a 	blcc	88b88 <_bss_end+0x7f3a4>
 69c:	0721390b 	streq	r3, [r1, -fp, lsl #18]!
 6a0:	00001349 	andeq	r1, r0, r9, asr #6
 6a4:	0b001016 	bleq	4704 <shift+0x4704>
 6a8:	13490421 	movtne	r0, #37921	; 0x9421
 6ac:	2e170000 	cdpcs	0, 1, cr0, cr7, cr0, {0}
 6b0:	03193f01 	tsteq	r9, #1, 30
 6b4:	3b0b3a0e 	blcc	2ceef4 <_bss_end+0x2c5710>
 6b8:	6e0b390b 	vmlavs.f16	s6, s22, s22	; <UNPREDICTABLE>
 6bc:	3213490e 	andscc	r4, r3, #229376	; 0x38000
 6c0:	193c0121 	ldmdbne	ip!, {r0, r5, r8}
 6c4:	00001364 	andeq	r1, r0, r4, ror #6
 6c8:	31000518 	tstcc	r0, r8, lsl r5
 6cc:	00180213 	andseq	r0, r8, r3, lsl r2
 6d0:	01111900 	tsteq	r1, r0, lsl #18
 6d4:	0b130e25 	bleq	4c3f70 <_bss_end+0x4ba78c>
 6d8:	0e1b0e03 	cdpeq	14, 1, cr0, cr11, cr3, {0}
 6dc:	06120111 			; <UNDEFINED> instruction: 0x06120111
 6e0:	00001710 	andeq	r1, r0, r0, lsl r7
 6e4:	0b00241a 	bleq	9754 <_ZN3halL15Peripheral_BaseE>
 6e8:	030b3e0b 	movweq	r3, #48651	; 0xbe0b
 6ec:	1b000008 	blne	714 <shift+0x714>
 6f0:	193f012e 	ldmdbne	pc!, {r1, r2, r3, r5, r8}	; <UNPREDICTABLE>
 6f4:	0b3a0e03 	bleq	e83f08 <_bss_end+0xe7a724>
 6f8:	0b390b3b 	bleq	e433ec <_bss_end+0xe39c08>
 6fc:	0b320e6e 	bleq	c840bc <_bss_end+0xc7a8d8>
 700:	1364193c 	cmnne	r4, #60, 18	; 0xf0000
 704:	391c0000 	ldmdbcc	ip, {}	; <UNPREDICTABLE>
 708:	3a080301 	bcc	201314 <_bss_end+0x1f7b30>
 70c:	390b3b0b 	stmdbcc	fp, {r0, r1, r3, r8, r9, fp, ip, sp}
 710:	0013010b 	andseq	r0, r3, fp, lsl #2
 714:	00341d00 	eorseq	r1, r4, r0, lsl #26
 718:	0b3a0e03 	bleq	e83f2c <_bss_end+0xe7a748>
 71c:	0b390b3b 	bleq	e43410 <_bss_end+0xe39c2c>
 720:	193c1349 	ldmdbne	ip!, {r0, r3, r6, r8, r9, ip}
 724:	196c0b1c 	stmdbne	ip!, {r2, r3, r4, r8, r9, fp}^
 728:	281e0000 	ldmdacs	lr, {}	; <UNPREDICTABLE>
 72c:	1c080300 	stcne	3, cr0, [r8], {-0}
 730:	1f00000b 	svcne	0x0000000b
 734:	0e030104 	adfeqs	f0, f3, f4
 738:	0b3e196d 	bleq	f86cf4 <_bss_end+0xf7d510>
 73c:	13490b0b 	movtne	r0, #39691	; 0x9b0b
 740:	0b3b0b3a 	bleq	ec3430 <_bss_end+0xeb9c4c>
 744:	00000b39 	andeq	r0, r0, r9, lsr fp
 748:	03002820 	movweq	r2, #2080	; 0x820
 74c:	00061c0e 	andeq	r1, r6, lr, lsl #24
 750:	00342100 	eorseq	r2, r4, r0, lsl #2
 754:	0b3a1347 	bleq	e85478 <_bss_end+0xe7bc94>
 758:	0b390b3b 	bleq	e4344c <_bss_end+0xe39c68>
 75c:	00001802 	andeq	r1, r0, r2, lsl #16
 760:	03002e22 	movweq	r2, #3618	; 0xe22
 764:	1119340e 	tstne	r9, lr, lsl #8
 768:	40061201 	andmi	r1, r6, r1, lsl #4
 76c:	00197c18 	andseq	r7, r9, r8, lsl ip
 770:	012e2300 			; <UNDEFINED> instruction: 0x012e2300
 774:	19340e03 	ldmdbne	r4!, {r0, r1, r9, sl, fp}
 778:	06120111 			; <UNDEFINED> instruction: 0x06120111
 77c:	197c1840 	ldmdbne	ip!, {r6, fp, ip}^
 780:	00001301 	andeq	r1, r0, r1, lsl #6
 784:	03003424 	movweq	r3, #1060	; 0x424
 788:	3b0b3a0e 	blcc	2cefc8 <_bss_end+0x2c57e4>
 78c:	490b390b 	stmdbmi	fp, {r0, r1, r3, r8, fp, ip, sp}
 790:	02196c13 	andseq	r6, r9, #4864	; 0x1300
 794:	25000018 	strcs	r0, [r0, #-24]	; 0xffffffe8
 798:	1347012e 	movtne	r0, #28974	; 0x712e
 79c:	0b3b0b3a 	bleq	ec348c <_bss_end+0xeb9ca8>
 7a0:	13640b39 	cmnne	r4, #58368	; 0xe400
 7a4:	13010b20 	movwne	r0, #6944	; 0x1b20
 7a8:	05260000 	streq	r0, [r6, #-0]!
 7ac:	490e0300 	stmdbmi	lr, {r8, r9}
 7b0:	00193413 	andseq	r3, r9, r3, lsl r4
 7b4:	00052700 	andeq	r2, r5, r0, lsl #14
 7b8:	0b3a0803 	bleq	e827cc <_bss_end+0xe78fe8>
 7bc:	0b390b3b 	bleq	e434b0 <_bss_end+0xe39ccc>
 7c0:	00001349 	andeq	r1, r0, r9, asr #6
 7c4:	31012e28 	tstcc	r1, r8, lsr #28
 7c8:	640e6e13 	strvs	r6, [lr], #-3603	; 0xfffff1ed
 7cc:	12011113 	andne	r1, r1, #-1073741820	; 0xc0000004
 7d0:	7c184006 	ldcvc	0, cr4, [r8], {6}
 7d4:	00000019 	andeq	r0, r0, r9, lsl r0
 7d8:	03002801 	movweq	r2, #2049	; 0x801
 7dc:	000b1c0e 	andeq	r1, fp, lr, lsl #24
 7e0:	00050200 	andeq	r0, r5, r0, lsl #4
 7e4:	00001349 	andeq	r1, r0, r9, asr #6
 7e8:	49000503 	stmdbmi	r0, {r0, r1, r8, sl}
 7ec:	00193413 	andseq	r3, r9, r3, lsl r4
 7f0:	012e0400 			; <UNDEFINED> instruction: 0x012e0400
 7f4:	0e03193f 			; <UNDEFINED> instruction: 0x0e03193f
 7f8:	0b3b0b3a 	bleq	ec34e8 <_bss_end+0xeb9d04>
 7fc:	0e6e0b39 	vmoveq.8	d14[5], r0
 800:	3c012132 	stfccs	f2, [r1], {50}	; 0x32
 804:	01136419 	tsteq	r3, r9, lsl r4
 808:	05000013 	streq	r0, [r0, #-19]	; 0xffffffed
 80c:	193f012e 	ldmdbne	pc!, {r1, r2, r3, r5, r8}	; <UNPREDICTABLE>
 810:	0b3a0e03 	bleq	e84024 <_bss_end+0xe7a840>
 814:	0b390b3b 	bleq	e43508 <_bss_end+0xe39d24>
 818:	13490e6e 	movtne	r0, #40558	; 0x9e6e
 81c:	193c0b32 	ldmdbne	ip!, {r1, r4, r5, r8, r9, fp}
 820:	13011364 	movwne	r1, #4964	; 0x1364
 824:	34060000 	strcc	r0, [r6], #-0
 828:	3a080300 	bcc	201430 <_bss_end+0x1f7c4c>
 82c:	0b3b0121 	bleq	ec0cb8 <_bss_end+0xeb74d4>
 830:	13490b39 	movtne	r0, #39737	; 0x9b39
 834:	00001802 	andeq	r1, r0, r2, lsl #16
 838:	0b002407 	bleq	985c <_bss_end+0x78>
 83c:	030b3e0b 	movweq	r3, #48651	; 0xbe0b
 840:	0800000e 	stmdaeq	r0, {r1, r2, r3}
 844:	210b000f 	tstcs	fp, pc
 848:	00134904 	andseq	r4, r3, r4, lsl #18
 84c:	00280900 	eoreq	r0, r8, r0, lsl #18
 850:	051c0e03 	ldreq	r0, [ip, #-3587]	; 0xfffff1fd
 854:	260a0000 	strcs	r0, [sl], -r0
 858:	00134900 	andseq	r4, r3, r0, lsl #18
 85c:	01040b00 	tsteq	r4, r0, lsl #22
 860:	196d0e03 	stmdbne	sp!, {r0, r1, r9, sl, fp}^
 864:	0b0b0b3e 	bleq	2c3564 <_bss_end+0x2b9d80>
 868:	0b3a1349 	bleq	e85594 <_bss_end+0xe7bdb0>
 86c:	0b390b3b 	bleq	e43560 <_bss_end+0xe39d7c>
 870:	00001301 	andeq	r1, r0, r1, lsl #6
 874:	4700340c 	strmi	r3, [r0, -ip, lsl #8]
 878:	0d000013 	stceq	0, cr0, [r0, #-76]	; 0xffffffb4
 87c:	0e030102 	adfeqs	f0, f3, f2
 880:	3a04210b 	bcc	108cb4 <_bss_end+0xff4d0>
 884:	390b3b0b 	stmdbcc	fp, {r0, r1, r3, r8, r9, fp, ip, sp}
 888:	13010721 	movwne	r0, #5921	; 0x1721
 88c:	0d0e0000 	stceq	0, cr0, [lr, #-0]
 890:	3a0e0300 	bcc	381498 <_bss_end+0x377cb4>
 894:	390b3b0b 	stmdbcc	fp, {r0, r1, r3, r8, r9, fp, ip, sp}
 898:	3813490b 	ldmdacc	r3, {r0, r1, r3, r8, fp, lr}
 89c:	00000021 	andeq	r0, r0, r1, lsr #32
 8a0:	0300340f 	movweq	r3, #1039	; 0x40f
 8a4:	04213a0e 	strteq	r3, [r1], #-2574	; 0xfffff5f2
 8a8:	21390b3b 	teqcs	r9, fp, lsr fp
 8ac:	3c13491a 			; <UNDEFINED> instruction: 0x3c13491a
 8b0:	6c061c19 	stcvs	12, cr1, [r6], {25}
 8b4:	10000019 	andne	r0, r0, r9, lsl r0
 8b8:	0111010b 	tsteq	r1, fp, lsl #2
 8bc:	00000612 	andeq	r0, r0, r2, lsl r6
 8c0:	03000511 	movweq	r0, #1297	; 0x511
 8c4:	01213a08 			; <UNDEFINED> instruction: 0x01213a08
 8c8:	0b390b3b 	bleq	e435bc <_bss_end+0xe39dd8>
 8cc:	18021349 	stmdane	r2, {r0, r3, r6, r8, r9, ip}
 8d0:	05120000 	ldreq	r0, [r2, #-0]
 8d4:	3a0e0300 	bcc	3814dc <_bss_end+0x377cf8>
 8d8:	0b3b0121 	bleq	ec0d64 <_bss_end+0xeb7580>
 8dc:	13490b39 	movtne	r0, #39737	; 0x9b39
 8e0:	00001802 	andeq	r1, r0, r2, lsl #16
 8e4:	03001613 	movweq	r1, #1555	; 0x613
 8e8:	02213a0e 	eoreq	r3, r1, #57344	; 0xe000
 8ec:	21390b3b 	teqcs	r9, fp, lsr fp
 8f0:	00134907 	andseq	r4, r3, r7, lsl #18
 8f4:	00101400 	andseq	r1, r0, r0, lsl #8
 8f8:	4904210b 	stmdbmi	r4, {r0, r1, r3, r8, sp}
 8fc:	15000013 	strne	r0, [r0, #-19]	; 0xffffffed
 900:	0e030034 	mcreq	0, 0, r0, cr3, cr4, {1}
 904:	0b3b0b3a 	bleq	ec35f4 <_bss_end+0xeb9e10>
 908:	13490b39 	movtne	r0, #39737	; 0x9b39
 90c:	193c193f 	ldmdbne	ip!, {r0, r1, r2, r3, r4, r5, r8, fp, ip}
 910:	2e160000 	cdpcs	0, 1, cr0, cr6, cr0, {0}
 914:	03193f01 	tsteq	r9, #1, 30
 918:	3b0b3a0e 	blcc	2cf158 <_bss_end+0x2c5974>
 91c:	6e0b390b 	vmlavs.f16	s6, s22, s22	; <UNPREDICTABLE>
 920:	3213490e 	andscc	r4, r3, #229376	; 0x38000
 924:	193c0121 	ldmdbne	ip!, {r0, r5, r8}
 928:	00001364 	andeq	r1, r0, r4, ror #6
 92c:	03003417 	movweq	r3, #1047	; 0x417
 930:	01213a0e 			; <UNDEFINED> instruction: 0x01213a0e
 934:	0b390b3b 	bleq	e43628 <_bss_end+0xe39e44>
 938:	18021349 	stmdane	r2, {r0, r3, r6, r8, r9, ip}
 93c:	11180000 	tstne	r8, r0
 940:	130e2501 	movwne	r2, #58625	; 0xe501
 944:	1b0e030b 	blne	381578 <_bss_end+0x377d94>
 948:	1201110e 	andne	r1, r1, #-2147483645	; 0x80000003
 94c:	00171006 	andseq	r1, r7, r6
 950:	00241900 	eoreq	r1, r4, r0, lsl #18
 954:	0b3e0b0b 	bleq	f83588 <_bss_end+0xf79da4>
 958:	00000803 	andeq	r0, r0, r3, lsl #16
 95c:	4900351a 	stmdbmi	r0, {r1, r3, r4, r8, sl, ip, sp}
 960:	1b000013 	blne	9b4 <shift+0x9b4>
 964:	193f012e 	ldmdbne	pc!, {r1, r2, r3, r5, r8}	; <UNPREDICTABLE>
 968:	0b3a0e03 	bleq	e8417c <_bss_end+0xe7a998>
 96c:	0b390b3b 	bleq	e43660 <_bss_end+0xe39e7c>
 970:	0b320e6e 	bleq	c84330 <_bss_end+0xc7ab4c>
 974:	1364193c 	cmnne	r4, #60, 18	; 0xf0000
 978:	391c0000 	ldmdbcc	ip, {}	; <UNPREDICTABLE>
 97c:	3a080301 	bcc	201588 <_bss_end+0x1f7da4>
 980:	390b3b0b 	stmdbcc	fp, {r0, r1, r3, r8, r9, fp, ip, sp}
 984:	0013010b 	andseq	r0, r3, fp, lsl #2
 988:	00341d00 	eorseq	r1, r4, r0, lsl #26
 98c:	0b3a0e03 	bleq	e841a0 <_bss_end+0xe7a9bc>
 990:	0b390b3b 	bleq	e43684 <_bss_end+0xe39ea0>
 994:	193c1349 	ldmdbne	ip!, {r0, r3, r6, r8, r9, ip}
 998:	196c0b1c 	stmdbne	ip!, {r2, r3, r4, r8, r9, fp}^
 99c:	281e0000 	ldmdacs	lr, {}	; <UNPREDICTABLE>
 9a0:	1c080300 	stcne	3, cr0, [r8], {-0}
 9a4:	1f00000b 	svcne	0x0000000b
 9a8:	0e030104 	adfeqs	f0, f3, f4
 9ac:	0b3e196d 	bleq	f86f68 <_bss_end+0xf7d784>
 9b0:	13490b0b 	movtne	r0, #39691	; 0x9b0b
 9b4:	0b3b0b3a 	bleq	ec36a4 <_bss_end+0xeb9ec0>
 9b8:	00000b39 	andeq	r0, r0, r9, lsr fp
 9bc:	03002820 	movweq	r2, #2080	; 0x820
 9c0:	00061c0e 	andeq	r1, r6, lr, lsl #24
 9c4:	00342100 	eorseq	r2, r4, r0, lsl #2
 9c8:	0b3a0e03 	bleq	e841dc <_bss_end+0xe7a9f8>
 9cc:	0b390b3b 	bleq	e436c0 <_bss_end+0xe39edc>
 9d0:	196c1349 	stmdbne	ip!, {r0, r3, r6, r8, r9, ip}^
 9d4:	00001802 	andeq	r1, r0, r2, lsl #16
 9d8:	3f012e22 	svccc	0x00012e22
 9dc:	3a0e0319 	bcc	381648 <_bss_end+0x377e64>
 9e0:	390b3b0b 	stmdbcc	fp, {r0, r1, r3, r8, r9, fp, ip, sp}
 9e4:	1113490b 	tstne	r3, fp, lsl #18
 9e8:	40061201 	andmi	r1, r6, r1, lsl #4
 9ec:	01197c18 	tsteq	r9, r8, lsl ip
 9f0:	23000013 	movwcs	r0, #19
 9f4:	13490101 	movtne	r0, #37121	; 0x9101
 9f8:	00001301 	andeq	r1, r0, r1, lsl #6
 9fc:	49002124 	stmdbmi	r0, {r2, r5, r8, sp}
 a00:	000b2f13 	andeq	r2, fp, r3, lsl pc
 a04:	012e2500 			; <UNDEFINED> instruction: 0x012e2500
 a08:	0e03193f 			; <UNDEFINED> instruction: 0x0e03193f
 a0c:	0b3b0b3a 	bleq	ec36fc <_bss_end+0xeb9f18>
 a10:	0e6e0b39 	vmoveq.8	d14[5], r0
 a14:	01111349 	tsteq	r1, r9, asr #6
 a18:	18400612 	stmdane	r0, {r1, r4, r9, sl}^
 a1c:	1301197c 	movwne	r1, #6524	; 0x197c
 a20:	2e260000 	cdpcs	0, 2, cr0, cr6, cr0, {0}
 a24:	03193f01 	tsteq	r9, #1, 30
 a28:	3b0b3a0e 	blcc	2cf268 <_bss_end+0x2c5a84>
 a2c:	6e0b390b 	vmlavs.f16	s6, s22, s22	; <UNPREDICTABLE>
 a30:	1201110e 	andne	r1, r1, #-2147483645	; 0x80000003
 a34:	7a184006 	bvc	610a54 <_bss_end+0x607270>
 a38:	00130119 	andseq	r0, r3, r9, lsl r1
 a3c:	012e2700 			; <UNDEFINED> instruction: 0x012e2700
 a40:	0e03193f 			; <UNDEFINED> instruction: 0x0e03193f
 a44:	0b3b0b3a 	bleq	ec3734 <_bss_end+0xeb9f50>
 a48:	0e6e0b39 	vmoveq.8	d14[5], r0
 a4c:	06120111 			; <UNDEFINED> instruction: 0x06120111
 a50:	197a1840 	ldmdbne	sl!, {r6, fp, ip}^
 a54:	01000000 	mrseq	r0, (UNDEF: 0)
 a58:	17100011 			; <UNDEFINED> instruction: 0x17100011
 a5c:	0f120111 	svceq	0x00120111
 a60:	0e1b0e03 	cdpeq	14, 1, cr0, cr11, cr3, {0}
 a64:	05130e25 	ldreq	r0, [r3, #-3621]	; 0xfffff1db
 a68:	01000000 	mrseq	r0, (UNDEF: 0)
 a6c:	0e030034 	mcreq	0, 0, r0, cr3, cr4, {1}
 a70:	3b01213a 	blcc	48f60 <_bss_end+0x3f77c>
 a74:	490b390b 	stmdbmi	fp, {r0, r1, r3, r8, fp, ip, sp}
 a78:	3c193f13 	ldccc	15, cr3, [r9], {19}
 a7c:	02000019 	andeq	r0, r0, #25
 a80:	210b000f 	tstcs	fp, pc
 a84:	00134904 	andseq	r4, r3, r4, lsl #18
 a88:	00160300 	andseq	r0, r6, r0, lsl #6
 a8c:	213a0e03 	teqcs	sl, r3, lsl #28
 a90:	390b3b01 	stmdbcc	fp, {r0, r8, r9, fp, ip, sp}
 a94:	13490721 	movtne	r0, #38689	; 0x9721
 a98:	01040000 	mrseq	r0, (UNDEF: 4)
 a9c:	01134901 	tsteq	r3, r1, lsl #18
 aa0:	05000013 	streq	r0, [r0, #-19]	; 0xffffffed
 aa4:	13490021 	movtne	r0, #36897	; 0x9021
 aa8:	ffff212f 			; <UNDEFINED> instruction: 0xffff212f
 aac:	000fffff 	strdeq	pc, [pc], -pc	; <UNPREDICTABLE>
 ab0:	012e0600 			; <UNDEFINED> instruction: 0x012e0600
 ab4:	0e03193f 			; <UNDEFINED> instruction: 0x0e03193f
 ab8:	3b01213a 	blcc	48fa8 <_bss_end+0x3f7c4>
 abc:	1021390b 	eorne	r3, r1, fp, lsl #18
 ac0:	01111349 	tsteq	r1, r9, asr #6
 ac4:	18400612 	stmdane	r0, {r1, r4, r9, sl}^
 ac8:	1301197c 	movwne	r1, #6524	; 0x197c
 acc:	34070000 	strcc	r0, [r7], #-0
 ad0:	3a0e0300 	bcc	3816d8 <_bss_end+0x377ef4>
 ad4:	0b3b0121 	bleq	ec0f60 <_bss_end+0xeb777c>
 ad8:	490c2139 	stmdbmi	ip, {r0, r3, r4, r5, r8, sp}
 adc:	00180213 	andseq	r0, r8, r3, lsl r2
 ae0:	01110800 	tsteq	r1, r0, lsl #16
 ae4:	0b130e25 	bleq	4c4380 <_bss_end+0x4bab9c>
 ae8:	0e1b0e03 	cdpeq	14, 1, cr0, cr11, cr3, {0}
 aec:	06120111 			; <UNDEFINED> instruction: 0x06120111
 af0:	00001710 	andeq	r1, r0, r0, lsl r7
 af4:	00001509 	andeq	r1, r0, r9, lsl #10
 af8:	00240a00 	eoreq	r0, r4, r0, lsl #20
 afc:	0b3e0b0b 	bleq	f83730 <_bss_end+0xf79f4c>
 b00:	00000803 	andeq	r0, r0, r3, lsl #16
 b04:	0b00240b 	bleq	9b38 <_bss_end+0x354>
 b08:	030b3e0b 	movweq	r3, #48651	; 0xbe0b
 b0c:	0c00000e 	stceq	0, cr0, [r0], {14}
 b10:	193f012e 	ldmdbne	pc!, {r1, r2, r3, r5, r8}	; <UNPREDICTABLE>
 b14:	0b3a0e03 	bleq	e84328 <_bss_end+0xe7ab44>
 b18:	0b390b3b 	bleq	e4380c <_bss_end+0xe3a028>
 b1c:	01111349 	tsteq	r1, r9, asr #6
 b20:	18400612 	stmdane	r0, {r1, r4, r9, sl}^
 b24:	1301197a 	movwne	r1, #6522	; 0x197a
 b28:	340d0000 	strcc	r0, [sp], #-0
 b2c:	3a080300 	bcc	201734 <_bss_end+0x1f7f50>
 b30:	390b3b0b 	stmdbcc	fp, {r0, r1, r3, r8, r9, fp, ip, sp}
 b34:	0213490b 	andseq	r4, r3, #180224	; 0x2c000
 b38:	00000018 	andeq	r0, r0, r8, lsl r0
 b3c:	10001101 	andne	r1, r0, r1, lsl #2
 b40:	12011117 	andne	r1, r1, #-1073741819	; 0xc0000005
 b44:	1b0e030f 	blne	381788 <_bss_end+0x377fa4>
 b48:	130e250e 	movwne	r2, #58638	; 0xe50e
 b4c:	00000005 	andeq	r0, r0, r5
 b50:	10001101 	andne	r1, r0, r1, lsl #2
 b54:	12011117 	andne	r1, r1, #-1073741819	; 0xc0000005
 b58:	1b0e030f 	blne	38179c <_bss_end+0x377fb8>
 b5c:	130e250e 	movwne	r2, #58638	; 0xe50e
 b60:	00000005 	andeq	r0, r0, r5
 b64:	10001101 	andne	r1, r0, r1, lsl #2
 b68:	12011117 	andne	r1, r1, #-1073741819	; 0xc0000005
 b6c:	1b0e030f 	blne	3817b0 <_bss_end+0x377fcc>
 b70:	130e250e 	movwne	r2, #58638	; 0xe50e
 b74:	00000005 	andeq	r0, r0, r5
 b78:	03002801 	movweq	r2, #2049	; 0x801
 b7c:	000b1c0e 	andeq	r1, fp, lr, lsl #24
 b80:	00240200 	eoreq	r0, r4, r0, lsl #4
 b84:	0b3e0b0b 	bleq	f837b8 <_bss_end+0xf79fd4>
 b88:	00000e03 	andeq	r0, r0, r3, lsl #28
 b8c:	49010103 	stmdbmi	r1, {r0, r1, r8}
 b90:	00130113 	andseq	r0, r3, r3, lsl r1
 b94:	000d0400 	andeq	r0, sp, r0, lsl #8
 b98:	213a0e03 	teqcs	sl, r3, lsl #28
 b9c:	39053b02 	stmdbcc	r5, {r1, r8, r9, fp, ip, sp}
 ba0:	13491421 	movtne	r1, #37921	; 0x9421
 ba4:	00000b38 	andeq	r0, r0, r8, lsr fp
 ba8:	49002605 	stmdbmi	r0, {r0, r2, r9, sl, sp}
 bac:	06000013 			; <UNDEFINED> instruction: 0x06000013
 bb0:	13490021 	movtne	r0, #36897	; 0x9021
 bb4:	00000b2f 	andeq	r0, r0, pc, lsr #22
 bb8:	03003407 	movweq	r3, #1031	; 0x407
 bbc:	04213a0e 	strteq	r3, [r1], #-2574	; 0xfffff5f2
 bc0:	21390b3b 	teqcs	r9, fp, lsr fp
 bc4:	3f134911 	svccc	0x00134911
 bc8:	00193c19 	andseq	r3, r9, r9, lsl ip
 bcc:	00340800 	eorseq	r0, r4, r0, lsl #16
 bd0:	213a1347 	teqcs	sl, r7, asr #6
 bd4:	39053b01 	stmdbcc	r5, {r0, r8, r9, fp, ip, sp}
 bd8:	13490a21 	movtne	r0, #39457	; 0x9a21
 bdc:	00001802 	andeq	r1, r0, r2, lsl #16
 be0:	25011109 	strcs	r1, [r1, #-265]	; 0xfffffef7
 be4:	030b130e 	movweq	r1, #45838	; 0xb30e
 be8:	100e1b0e 	andne	r1, lr, lr, lsl #22
 bec:	0a000017 	beq	c50 <shift+0xc50>
 bf0:	0b0b0024 	bleq	2c0c88 <_bss_end+0x2b74a4>
 bf4:	08030b3e 	stmdaeq	r3, {r1, r2, r3, r4, r5, r8, r9, fp}
 bf8:	040b0000 	streq	r0, [fp], #-0
 bfc:	3e0e0301 	cdpcc	3, 0, cr0, cr14, cr1, {0}
 c00:	490b0b0b 	stmdbmi	fp, {r0, r1, r3, r8, r9, fp}
 c04:	3b0b3a13 	blcc	2cf458 <_bss_end+0x2c5c74>
 c08:	010b390b 	tsteq	fp, fp, lsl #18
 c0c:	0c000013 	stceq	0, cr0, [r0], {19}
 c10:	0e030113 	mcreq	1, 0, r0, cr3, cr3, {0}
 c14:	0b3a0b0b 	bleq	e83848 <_bss_end+0xe7a064>
 c18:	0b39053b 	bleq	e4210c <_bss_end+0xe38928>
 c1c:	00001301 	andeq	r1, r0, r1, lsl #6
 c20:	0300340d 	movweq	r3, #1037	; 0x40d
 c24:	3b0b3a0e 	blcc	2cf464 <_bss_end+0x2c5c80>
 c28:	490b3905 	stmdbmi	fp, {r0, r2, r8, fp, ip, sp}
 c2c:	000a1c13 	andeq	r1, sl, r3, lsl ip
 c30:	00150e00 	andseq	r0, r5, r0, lsl #28
 c34:	00001927 	andeq	r1, r0, r7, lsr #18
 c38:	0b000f0f 	bleq	487c <shift+0x487c>
 c3c:	0013490b 	andseq	r4, r3, fp, lsl #18
 c40:	01041000 	mrseq	r1, (UNDEF: 4)
 c44:	0b3e0e03 	bleq	f84458 <_bss_end+0xf7ac74>
 c48:	13490b0b 	movtne	r0, #39691	; 0x9b0b
 c4c:	053b0b3a 	ldreq	r0, [fp, #-2874]!	; 0xfffff4c6
 c50:	13010b39 	movwne	r0, #6969	; 0x1b39
 c54:	16110000 	ldrne	r0, [r1], -r0
 c58:	3a0e0300 	bcc	381860 <_bss_end+0x37807c>
 c5c:	390b3b0b 	stmdbcc	fp, {r0, r1, r3, r8, r9, fp, ip, sp}
 c60:	0013490b 	andseq	r4, r3, fp, lsl #18
 c64:	00211200 	eoreq	r1, r1, r0, lsl #4
 c68:	01000000 	mrseq	r0, (UNDEF: 0)
 c6c:	0b0b0024 	bleq	2c0d04 <_bss_end+0x2b7520>
 c70:	0e030b3e 	vmoveq.16	d3[0], r0
 c74:	34020000 	strcc	r0, [r2], #-0
 c78:	3a080300 	bcc	201880 <_bss_end+0x1f809c>
 c7c:	0b3b0121 	bleq	ec1108 <_bss_end+0xeb7924>
 c80:	13490b39 	movtne	r0, #39737	; 0x9b39
 c84:	42b71702 	adcsmi	r1, r7, #524288	; 0x80000
 c88:	03000017 	movweq	r0, #23
 c8c:	210b000f 	tstcs	fp, pc
 c90:	00134904 	andseq	r4, r3, r4, lsl #18
 c94:	00050400 	andeq	r0, r5, r0, lsl #8
 c98:	213a0803 	teqcs	sl, r3, lsl #16
 c9c:	390b3b01 	stmdbcc	fp, {r0, r8, r9, fp, ip, sp}
 ca0:	0213490b 	andseq	r4, r3, #180224	; 0x2c000
 ca4:	1742b717 	smlaldne	fp, r2, r7, r7
 ca8:	34050000 	strcc	r0, [r5], #-0
 cac:	3a0e0300 	bcc	3818b4 <_bss_end+0x3780d0>
 cb0:	0b3b0121 	bleq	ec113c <_bss_end+0xeb7958>
 cb4:	13490b39 	movtne	r0, #39737	; 0x9b39
 cb8:	42b71702 	adcsmi	r1, r7, #524288	; 0x80000
 cbc:	06000017 			; <UNDEFINED> instruction: 0x06000017
 cc0:	0e250111 	mcreq	1, 1, r0, cr5, cr1, {0}
 cc4:	0e030b13 	vmoveq.32	d3[0], r0
 cc8:	17550e1b 	smmlane	r5, fp, lr, r0
 ccc:	17100111 			; <UNDEFINED> instruction: 0x17100111
 cd0:	24070000 	strcs	r0, [r7], #-0
 cd4:	3e0b0b00 	vmlacc.f64	d0, d11, d0
 cd8:	0008030b 	andeq	r0, r8, fp, lsl #6
 cdc:	00160800 	andseq	r0, r6, r0, lsl #16
 ce0:	0b3a0e03 	bleq	e844f4 <_bss_end+0xe7ad10>
 ce4:	0b390b3b 	bleq	e439d8 <_bss_end+0xe3a1f4>
 ce8:	00001349 	andeq	r1, r0, r9, asr #6
 cec:	0b000f09 	bleq	4918 <shift+0x4918>
 cf0:	0a00000b 	beq	d24 <shift+0xd24>
 cf4:	193f012e 	ldmdbne	pc!, {r1, r2, r3, r5, r8}	; <UNPREDICTABLE>
 cf8:	0b3a0e03 	bleq	e8450c <_bss_end+0xe7ad28>
 cfc:	0b390b3b 	bleq	e439f0 <_bss_end+0xe3a20c>
 d00:	13491927 	movtne	r1, #39207	; 0x9927
 d04:	06120111 			; <UNDEFINED> instruction: 0x06120111
 d08:	197a1840 	ldmdbne	sl!, {r6, fp, ip}^
 d0c:	00001301 	andeq	r1, r0, r1, lsl #6
 d10:	0300050b 	movweq	r0, #1291	; 0x50b
 d14:	3b0b3a08 	blcc	2cf53c <_bss_end+0x2c5d58>
 d18:	490b390b 	stmdbmi	fp, {r0, r1, r3, r8, fp, ip, sp}
 d1c:	00180213 	andseq	r0, r8, r3, lsl r2
	...

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
  64:	0b490002 	bleq	1240074 <_bss_end+0x1236890>
  68:	00040000 	andeq	r0, r4, r0
  6c:	00000000 	andeq	r0, r0, r0
  70:	000087b8 			; <UNDEFINED> instruction: 0x000087b8
  74:	00000464 	andeq	r0, r0, r4, ror #8
	...
  80:	0000001c 	andeq	r0, r0, ip, lsl r0
  84:	133f0002 	teqne	pc, #2
  88:	00040000 	andeq	r0, r4, r0
  8c:	00000000 	andeq	r0, r0, r0
  90:	00008c1c 	andeq	r8, r0, ip, lsl ip
  94:	0000039c 	muleq	r0, ip, r3
	...
  a0:	0000001c 	andeq	r0, r0, ip, lsl r0
  a4:	1aa60002 	bne	fe9800b4 <_bss_end+0xfe9768d0>
  a8:	00040000 	andeq	r0, r4, r0
  ac:	00000000 	andeq	r0, r0, r0
  b0:	00008000 	andeq	r8, r0, r0
  b4:	00000018 	andeq	r0, r0, r8, lsl r0
	...
  c0:	0000001c 	andeq	r0, r0, ip, lsl r0
  c4:	1aca0002 	bne	ff2800d4 <_bss_end+0xff2768f0>
  c8:	00040000 	andeq	r0, r4, r0
  cc:	00000000 	andeq	r0, r0, r0
  d0:	00008fb8 			; <UNDEFINED> instruction: 0x00008fb8
  d4:	00000118 	andeq	r0, r0, r8, lsl r1
	...
  e0:	0000001c 	andeq	r0, r0, ip, lsl r0
  e4:	1bfc0002 	blne	fff000f4 <_bss_end+0xffef6910>
  e8:	00040000 	andeq	r0, r4, r0
  ec:	00000000 	andeq	r0, r0, r0
  f0:	000090d0 	ldrdeq	r9, [r0], -r0
  f4:	0000020c 	andeq	r0, r0, ip, lsl #4
	...
 100:	0000001c 	andeq	r0, r0, ip, lsl r0
 104:	1c210002 	stcne	0, cr0, [r1], #-8
 108:	00040000 	andeq	r0, r4, r0
 10c:	00000000 	andeq	r0, r0, r0
 110:	000092dc 	ldrdeq	r9, [r0], -ip
 114:	00000240 	andeq	r0, r0, r0, asr #4
	...
 120:	0000001c 	andeq	r0, r0, ip, lsl r0
 124:	1c460002 	mcrrne	0, 0, r0, r6, cr2
 128:	00040000 	andeq	r0, r4, r0
 12c:	00000000 	andeq	r0, r0, r0
 130:	0000951c 	andeq	r9, r0, ip, lsl r5
 134:	00000004 	andeq	r0, r0, r4
	...
 140:	00000014 	andeq	r0, r0, r4, lsl r0
 144:	1c6a0002 	stclne	0, cr0, [sl], #-8
 148:	00040000 	andeq	r0, r4, r0
	...
 158:	0000001c 	andeq	r0, r0, ip, lsl r0
 15c:	1f9f0002 	svcne	0x009f0002
 160:	00040000 	andeq	r0, r4, r0
 164:	00000000 	andeq	r0, r0, r0
 168:	00009520 	andeq	r9, r0, r0, lsr #10
 16c:	00000118 	andeq	r0, r0, r8, lsl r1
	...

Disassembly of section .debug_line:

00000000 <.debug_line>:
   0:	00000092 	muleq	r0, r2, r0
   4:	00590003 	subseq	r0, r9, r3
   8:	01020000 	mrseq	r0, (UNDEF: 2)
   c:	000d0efb 	strdeq	r0, [sp], -fp
  10:	01010101 	tsteq	r1, r1, lsl #2
  14:	01000000 	mrseq	r0, (UNDEF: 0)
  18:	2f010000 	svccs	0x00010000
  1c:	656d6f68 	strbvs	r6, [sp, #-3944]!	; 0xfffff098
  20:	2f66632f 	svccs	0x0066632f
  24:	2f55435a 	svccs	0x0055435a
  28:	73726966 	cmnvc	r2, #1671168	; 0x198000
  2c:	65795f74 	ldrbvs	r5, [r9, #-3956]!	; 0xfffff08c
  30:	772f7261 	strvc	r7, [pc, -r1, ror #4]!
  34:	65746e69 	ldrbvs	r6, [r4, #-3689]!	; 0xfffff197
  38:	534f2f72 	movtpl	r2, #65394	; 0xff72
  3c:	6172702f 	cmnvs	r2, pc, lsr #32
  40:	63697463 	cmnvs	r9, #1660944384	; 0x63000000
  44:	652f6c61 	strvs	r6, [pc, #-3169]!	; fffff3eb <_bss_end+0xffff5c07>
  48:	6b2f3378 	blvs	bcce30 <_bss_end+0xbc364c>
  4c:	656e7265 	strbvs	r7, [lr, #-613]!	; 0xfffffd9b
  50:	72732f6c 	rsbsvc	r2, r3, #108, 30	; 0x1b0
  54:	63000063 	movwvs	r0, #99	; 0x63
  58:	632e7878 			; <UNDEFINED> instruction: 0x632e7878
  5c:	01007070 	tsteq	r0, r0, ror r0
  60:	05000000 	streq	r0, [r0, #-0]
  64:	02050002 	andeq	r0, r5, #2
  68:	00008018 	andeq	r8, r0, r8, lsl r0
  6c:	05010a03 	streq	r0, [r1, #-2563]	; 0xfffff5fd
  70:	0a05830b 	beq	160ca4 <_bss_end+0x1574c0>
  74:	8302054a 	movwhi	r0, #9546	; 0x254a
  78:	830e0585 	movwhi	r0, #58757	; 0xe585
  7c:	85670205 	strbhi	r0, [r7, #-517]!	; 0xfffffdfb
  80:	86010584 	strhi	r0, [r1], -r4, lsl #11
  84:	854c854c 	strbhi	r8, [ip, #-1356]	; 0xfffffab4
  88:	0205854c 	andeq	r8, r5, #76, 10	; 0x13000000
  8c:	01040200 	mrseq	r0, R12_usr
  90:	0002024b 	andeq	r0, r2, fp, asr #4
  94:	01940101 	orrseq	r0, r4, r1, lsl #2
  98:	00030000 	andeq	r0, r3, r0
  9c:	00000124 	andeq	r0, r0, r4, lsr #2
  a0:	0efb0102 	cdpeq	1, 15, cr0, cr11, cr2, {0}
  a4:	0101000d 	tsteq	r1, sp
  a8:	00000101 	andeq	r0, r0, r1, lsl #2
  ac:	00000100 	andeq	r0, r0, r0, lsl #2
  b0:	6f682f01 	svcvs	0x00682f01
  b4:	632f656d 			; <UNDEFINED> instruction: 0x632f656d
  b8:	435a2f66 	cmpmi	sl, #408	; 0x198
  bc:	69662f55 	stmdbvs	r6!, {r0, r2, r4, r6, r8, r9, sl, fp, sp}^
  c0:	5f747372 	svcpl	0x00747372
  c4:	72616579 	rsbvc	r6, r1, #507510784	; 0x1e400000
  c8:	6e69772f 	cdpvs	7, 6, cr7, cr9, cr15, {1}
  cc:	2f726574 	svccs	0x00726574
  d0:	702f534f 	eorvc	r5, pc, pc, asr #6
  d4:	74636172 	strbtvc	r6, [r3], #-370	; 0xfffffe8e
  d8:	6c616369 	stclvs	3, cr6, [r1], #-420	; 0xfffffe5c
  dc:	3378652f 	cmncc	r8, #197132288	; 0xbc00000
  e0:	72656b2f 	rsbvc	r6, r5, #48128	; 0xbc00
  e4:	2f6c656e 	svccs	0x006c656e
  e8:	2f637273 	svccs	0x00637273
  ec:	76697264 	strbtvc	r7, [r9], -r4, ror #4
  f0:	00737265 	rsbseq	r7, r3, r5, ror #4
  f4:	6d6f682f 	stclvs	8, cr6, [pc, #-188]!	; 40 <shift+0x40>
  f8:	66632f65 	strbtvs	r2, [r3], -r5, ror #30
  fc:	55435a2f 	strbpl	r5, [r3, #-2607]	; 0xfffff5d1
 100:	7269662f 	rsbvc	r6, r9, #49283072	; 0x2f00000
 104:	795f7473 	ldmdbvc	pc, {r0, r1, r4, r5, r6, sl, ip, sp, lr}^	; <UNPREDICTABLE>
 108:	2f726165 	svccs	0x00726165
 10c:	746e6977 	strbtvc	r6, [lr], #-2423	; 0xfffff689
 110:	4f2f7265 	svcmi	0x002f7265
 114:	72702f53 	rsbsvc	r2, r0, #332	; 0x14c
 118:	69746361 	ldmdbvs	r4!, {r0, r5, r6, r8, r9, sp, lr}^
 11c:	2f6c6163 	svccs	0x006c6163
 120:	2f337865 	svccs	0x00337865
 124:	6e72656b 	cdpvs	5, 7, cr6, cr2, cr11, {3}
 128:	692f6c65 	stmdbvs	pc!, {r0, r2, r5, r6, sl, fp, sp, lr}	; <UNPREDICTABLE>
 12c:	756c636e 	strbvc	r6, [ip, #-878]!	; 0xfffffc92
 130:	622f6564 	eorvs	r6, pc, #100, 10	; 0x19000000
 134:	6472616f 	ldrbtvs	r6, [r2], #-367	; 0xfffffe91
 138:	6970722f 	ldmdbvs	r0!, {r0, r1, r2, r3, r5, r9, ip, sp, lr}^
 13c:	61682f30 	cmnvs	r8, r0, lsr pc
 140:	682f006c 	stmdavs	pc!, {r2, r3, r5, r6}	; <UNPREDICTABLE>
 144:	2f656d6f 	svccs	0x00656d6f
 148:	5a2f6663 	bpl	bd9adc <_bss_end+0xbd02f8>
 14c:	662f5543 	strtvs	r5, [pc], -r3, asr #10
 150:	74737269 	ldrbtvc	r7, [r3], #-617	; 0xfffffd97
 154:	6165795f 	cmnvs	r5, pc, asr r9
 158:	69772f72 	ldmdbvs	r7!, {r1, r4, r5, r6, r8, r9, sl, fp, sp}^
 15c:	7265746e 	rsbvc	r7, r5, #1845493760	; 0x6e000000
 160:	2f534f2f 	svccs	0x00534f2f
 164:	63617270 	cmnvs	r1, #112, 4
 168:	61636974 	smcvs	13972	; 0x3694
 16c:	78652f6c 	stmdavc	r5!, {r2, r3, r5, r6, r8, r9, sl, fp, sp}^
 170:	656b2f33 	strbvs	r2, [fp, #-3891]!	; 0xfffff0cd
 174:	6c656e72 	stclvs	14, cr6, [r5], #-456	; 0xfffffe38
 178:	636e692f 	cmnvs	lr, #770048	; 0xbc000
 17c:	6564756c 	strbvs	r7, [r4, #-1388]!	; 0xfffffa94
 180:	6972642f 	ldmdbvs	r2!, {r0, r1, r2, r3, r5, sl, sp, lr}^
 184:	73726576 	cmnvc	r2, #494927872	; 0x1d800000
 188:	63620000 	cmnvs	r2, #0
 18c:	75615f6d 	strbvc	r5, [r1, #-3949]!	; 0xfffff093
 190:	70632e78 	rsbvc	r2, r3, r8, ror lr
 194:	00010070 	andeq	r0, r1, r0, ror r0
 198:	72657000 	rsbvc	r7, r5, #0
 19c:	65687069 	strbvs	r7, [r8, #-105]!	; 0xffffff97
 1a0:	736c6172 	cmnvc	ip, #-2147483620	; 0x8000001c
 1a4:	0200682e 	andeq	r6, r0, #3014656	; 0x2e0000
 1a8:	63620000 	cmnvs	r2, #0
 1ac:	75615f6d 	strbvc	r5, [r1, #-3949]!	; 0xfffff093
 1b0:	00682e78 	rsbeq	r2, r8, r8, ror lr
 1b4:	69000003 	stmdbvs	r0, {r0, r1}
 1b8:	6564746e 	strbvs	r7, [r4, #-1134]!	; 0xfffffb92
 1bc:	00682e66 	rsbeq	r2, r8, r6, ror #28
 1c0:	00000002 	andeq	r0, r0, r2
 1c4:	05000105 	streq	r0, [r0, #-261]	; 0xfffffefb
 1c8:	0080f002 	addeq	pc, r0, r2
 1cc:	07051600 	streq	r1, [r5, -r0, lsl #12]
 1d0:	6901059f 	stmdbvs	r1, {r0, r1, r2, r3, r4, r7, r8, sl}
 1d4:	9f3505a1 	svcls	0x003505a1
 1d8:	05825505 	streq	r5, [r2, #1285]	; 0x505
 1dc:	11052e52 	tstne	r5, r2, asr lr
 1e0:	9f01054a 	svcls	0x0001054a
 1e4:	9f350569 	svcls	0x00350569
 1e8:	05825605 	streq	r5, [r2, #1541]	; 0x605
 1ec:	4f052e53 	svcmi	0x00052e53
 1f0:	2e11054a 	cfmac32cs	mvfx0, mvfx1, mvfx10
 1f4:	699f0105 	ldmibvs	pc, {r0, r2, r8}	; <UNPREDICTABLE>
 1f8:	05bb0505 	ldreq	r0, [fp, #1285]!	; 0x505
 1fc:	30054a0e 	andcc	r4, r5, lr, lsl #20
 200:	4a32052e 	bmi	c816c0 <_bss_end+0xc77edc>
 204:	854b0105 	strbhi	r0, [fp, #-261]	; 0xfffffefb
 208:	059f0c05 	ldreq	r0, [pc, #3077]	; e15 <shift+0xe15>
 20c:	37054a15 	smladcc	r5, r5, sl, r4
 210:	6701052e 	strvs	r0, [r1, -lr, lsr #10]
 214:	02009e82 	andeq	r9, r0, #2080	; 0x820
 218:	66060104 	strvs	r0, [r6], -r4, lsl #2
 21c:	03061805 	movweq	r1, #26629	; 0x6805
 220:	01058266 	tsteq	r5, r6, ror #4
 224:	ba661a03 	blt	1986a38 <_bss_end+0x197d254>
 228:	000a024a 	andeq	r0, sl, sl, asr #4
 22c:	02d30101 	sbcseq	r0, r3, #1073741824	; 0x40000000
 230:	00030000 	andeq	r0, r3, r0
 234:	0000011e 	andeq	r0, r0, lr, lsl r1
 238:	0efb0102 	cdpeq	1, 15, cr0, cr11, cr2, {0}
 23c:	0101000d 	tsteq	r1, sp
 240:	00000101 	andeq	r0, r0, r1, lsl #2
 244:	00000100 	andeq	r0, r0, r0, lsl #2
 248:	6f682f01 	svcvs	0x00682f01
 24c:	632f656d 			; <UNDEFINED> instruction: 0x632f656d
 250:	435a2f66 	cmpmi	sl, #408	; 0x198
 254:	69662f55 	stmdbvs	r6!, {r0, r2, r4, r6, r8, r9, sl, fp, sp}^
 258:	5f747372 	svcpl	0x00747372
 25c:	72616579 	rsbvc	r6, r1, #507510784	; 0x1e400000
 260:	6e69772f 	cdpvs	7, 6, cr7, cr9, cr15, {1}
 264:	2f726574 	svccs	0x00726574
 268:	702f534f 	eorvc	r5, pc, pc, asr #6
 26c:	74636172 	strbtvc	r6, [r3], #-370	; 0xfffffe8e
 270:	6c616369 	stclvs	3, cr6, [r1], #-420	; 0xfffffe5c
 274:	3378652f 	cmncc	r8, #197132288	; 0xbc00000
 278:	72656b2f 	rsbvc	r6, r5, #48128	; 0xbc00
 27c:	2f6c656e 	svccs	0x006c656e
 280:	2f637273 	svccs	0x00637273
 284:	76697264 	strbtvc	r7, [r9], -r4, ror #4
 288:	00737265 	rsbseq	r7, r3, r5, ror #4
 28c:	6d6f682f 	stclvs	8, cr6, [pc, #-188]!	; 1d8 <shift+0x1d8>
 290:	66632f65 	strbtvs	r2, [r3], -r5, ror #30
 294:	55435a2f 	strbpl	r5, [r3, #-2607]	; 0xfffff5d1
 298:	7269662f 	rsbvc	r6, r9, #49283072	; 0x2f00000
 29c:	795f7473 	ldmdbvc	pc, {r0, r1, r4, r5, r6, sl, ip, sp, lr}^	; <UNPREDICTABLE>
 2a0:	2f726165 	svccs	0x00726165
 2a4:	746e6977 	strbtvc	r6, [lr], #-2423	; 0xfffff689
 2a8:	4f2f7265 	svcmi	0x002f7265
 2ac:	72702f53 	rsbsvc	r2, r0, #332	; 0x14c
 2b0:	69746361 	ldmdbvs	r4!, {r0, r5, r6, r8, r9, sp, lr}^
 2b4:	2f6c6163 	svccs	0x006c6163
 2b8:	2f337865 	svccs	0x00337865
 2bc:	6e72656b 	cdpvs	5, 7, cr6, cr2, cr11, {3}
 2c0:	692f6c65 	stmdbvs	pc!, {r0, r2, r5, r6, sl, fp, sp, lr}	; <UNPREDICTABLE>
 2c4:	756c636e 	strbvc	r6, [ip, #-878]!	; 0xfffffc92
 2c8:	622f6564 	eorvs	r6, pc, #100, 10	; 0x19000000
 2cc:	6472616f 	ldrbtvs	r6, [r2], #-367	; 0xfffffe91
 2d0:	6970722f 	ldmdbvs	r0!, {r0, r1, r2, r3, r5, r9, ip, sp, lr}^
 2d4:	61682f30 	cmnvs	r8, r0, lsr pc
 2d8:	682f006c 	stmdavs	pc!, {r2, r3, r5, r6}	; <UNPREDICTABLE>
 2dc:	2f656d6f 	svccs	0x00656d6f
 2e0:	5a2f6663 	bpl	bd9c74 <_bss_end+0xbd0490>
 2e4:	662f5543 	strtvs	r5, [pc], -r3, asr #10
 2e8:	74737269 	ldrbtvc	r7, [r3], #-617	; 0xfffffd97
 2ec:	6165795f 	cmnvs	r5, pc, asr r9
 2f0:	69772f72 	ldmdbvs	r7!, {r1, r4, r5, r6, r8, r9, sl, fp, sp}^
 2f4:	7265746e 	rsbvc	r7, r5, #1845493760	; 0x6e000000
 2f8:	2f534f2f 	svccs	0x00534f2f
 2fc:	63617270 	cmnvs	r1, #112, 4
 300:	61636974 	smcvs	13972	; 0x3694
 304:	78652f6c 	stmdavc	r5!, {r2, r3, r5, r6, r8, r9, sl, fp, sp}^
 308:	656b2f33 	strbvs	r2, [fp, #-3891]!	; 0xfffff0cd
 30c:	6c656e72 	stclvs	14, cr6, [r5], #-456	; 0xfffffe38
 310:	636e692f 	cmnvs	lr, #770048	; 0xbc000
 314:	6564756c 	strbvs	r7, [r4, #-1388]!	; 0xfffffa94
 318:	6972642f 	ldmdbvs	r2!, {r0, r1, r2, r3, r5, sl, sp, lr}^
 31c:	73726576 	cmnvc	r2, #494927872	; 0x1d800000
 320:	70670000 	rsbvc	r0, r7, r0
 324:	632e6f69 			; <UNDEFINED> instruction: 0x632e6f69
 328:	01007070 	tsteq	r0, r0, ror r0
 32c:	6e690000 	cdpvs	0, 6, cr0, cr9, cr0, {0}
 330:	66656474 			; <UNDEFINED> instruction: 0x66656474
 334:	0200682e 	andeq	r6, r0, #3014656	; 0x2e0000
 338:	65700000 	ldrbvs	r0, [r0, #-0]!
 33c:	68706972 	ldmdavs	r0!, {r1, r4, r5, r6, r8, fp, sp, lr}^
 340:	6c617265 	sfmvs	f7, 2, [r1], #-404	; 0xfffffe6c
 344:	00682e73 	rsbeq	r2, r8, r3, ror lr
 348:	67000002 	strvs	r0, [r0, -r2]
 34c:	2e6f6970 			; <UNDEFINED> instruction: 0x2e6f6970
 350:	00030068 	andeq	r0, r3, r8, rrx
 354:	01050000 	mrseq	r0, (UNDEF: 5)
 358:	b8020500 	stmdalt	r2, {r8, sl}
 35c:	17000082 	strne	r0, [r0, -r2, lsl #1]
 360:	059f0405 	ldreq	r0, [pc, #1029]	; 76d <shift+0x76d>
 364:	05a16901 	streq	r6, [r1, #2305]!	; 0x901
 368:	0a05d702 	beq	175f78 <_bss_end+0x16c794>
 36c:	4c0e0567 	cfstr32mi	mvfx0, [lr], {103}	; 0x67
 370:	05820205 	streq	r0, [r2, #517]	; 0x205
 374:	0522080f 	streq	r0, [r2, #-2063]!	; 0xfffff7f1
 378:	0f056640 	svceq	0x00056640
 37c:	6640052f 	strbvs	r0, [r0], -pc, lsr #10
 380:	052f0f05 	streq	r0, [pc, #-3845]!	; fffff483 <_bss_end+0xffff5c9f>
 384:	0f056640 	svceq	0x00056640
 388:	6640052f 	strbvs	r0, [r0], -pc, lsr #10
 38c:	052f0f05 	streq	r0, [pc, #-3845]!	; fffff48f <_bss_end+0xffff5cab>
 390:	0f056640 	svceq	0x00056640
 394:	6640052f 	strbvs	r0, [r0], -pc, lsr #10
 398:	05311105 	ldreq	r1, [r1, #-261]!	; 0xfffffefb
 39c:	05200817 	streq	r0, [r0, #-2071]!	; 0xfffff7e9
 3a0:	0905660a 	stmdbeq	r5, {r1, r3, r9, sl, sp, lr}
 3a4:	2f01054c 	svccs	0x0001054c
 3a8:	d70205a1 	strle	r0, [r2, -r1, lsr #11]
 3ac:	05670a05 	strbeq	r0, [r7, #-2565]!	; 0xfffff5fb
 3b0:	02004c08 	andeq	r4, r0, #8, 24	; 0x800
 3b4:	66060104 	strvs	r0, [r6], -r4, lsl #2
 3b8:	02040200 	andeq	r0, r4, #0, 4
 3bc:	0006054a 	andeq	r0, r6, sl, asr #10
 3c0:	06040402 	streq	r0, [r4], -r2, lsl #8
 3c4:	0010052e 	andseq	r0, r0, lr, lsr #10
 3c8:	4b040402 	blmi	1013d8 <_bss_end+0xf7bf4>
 3cc:	02000a05 	andeq	r0, r0, #20480	; 0x5000
 3d0:	054a0404 	strbeq	r0, [sl, #-1028]	; 0xfffffbfc
 3d4:	04020009 	streq	r0, [r2], #-9
 3d8:	01054c04 	tsteq	r5, r4, lsl #24
 3dc:	0205852f 	andeq	r8, r5, #197132288	; 0xbc00000
 3e0:	670a05d7 			; <UNDEFINED> instruction: 0x670a05d7
 3e4:	004c0805 	subeq	r0, ip, r5, lsl #16
 3e8:	06010402 	streq	r0, [r1], -r2, lsl #8
 3ec:	04020066 	streq	r0, [r2], #-102	; 0xffffff9a
 3f0:	06054a02 	streq	r4, [r5], -r2, lsl #20
 3f4:	04040200 	streq	r0, [r4], #-512	; 0xfffffe00
 3f8:	10052e06 	andne	r2, r5, r6, lsl #28
 3fc:	04040200 	streq	r0, [r4], #-512	; 0xfffffe00
 400:	000a054b 	andeq	r0, sl, fp, asr #10
 404:	4a040402 	bmi	101414 <_bss_end+0xf7c30>
 408:	02000905 	andeq	r0, r0, #81920	; 0x14000
 40c:	054c0404 	strbeq	r0, [ip, #-1028]	; 0xfffffbfc
 410:	05852f01 	streq	r2, [r5, #3841]	; 0xf01
 414:	0a05d702 	beq	176024 <_bss_end+0x16c840>
 418:	4c080567 	cfstr32mi	mvfx0, [r8], {103}	; 0x67
 41c:	01040200 	mrseq	r0, R12_usr
 420:	02006606 	andeq	r6, r0, #6291456	; 0x600000
 424:	054a0204 	strbeq	r0, [sl, #-516]	; 0xfffffdfc
 428:	04020006 	streq	r0, [r2], #-6
 42c:	052e0604 	streq	r0, [lr, #-1540]!	; 0xfffff9fc
 430:	04020010 	streq	r0, [r2], #-16
 434:	0a054b04 	beq	15304c <_bss_end+0x149868>
 438:	04040200 	streq	r0, [r4], #-512	; 0xfffffe00
 43c:	0009054a 	andeq	r0, r9, sl, asr #10
 440:	4c040402 	cfstrsmi	mvf0, [r4], {2}
 444:	852f0105 	strhi	r0, [pc, #-261]!	; 347 <shift+0x347>
 448:	05d81905 	ldrbeq	r1, [r8, #2309]	; 0x905
 44c:	1005ba02 	andne	fp, r5, r2, lsl #20
 450:	4a19054d 	bmi	64198c <_bss_end+0x6381a8>
 454:	05823b05 	streq	r3, [r2, #2821]	; 0xb05
 458:	1b05661e 	blne	159cd8 <_bss_end+0x1504f4>
 45c:	2f08052e 	svccs	0x0008052e
 460:	052e2805 	streq	r2, [lr, #-2053]!	; 0xfffff7fb
 464:	0b054902 	bleq	152874 <_bss_end+0x149090>
 468:	6705054a 	strvs	r0, [r5, -sl, asr #10]
 46c:	052d0d05 	streq	r0, [sp, #-3333]!	; 0xfffff2fb
 470:	01054803 	tsteq	r5, r3, lsl #16
 474:	19054d32 	stmdbne	r5, {r1, r4, r5, r8, sl, fp, lr}
 478:	ba0205a0 	blt	81b00 <_bss_end+0x7831c>
 47c:	054b1a05 	strbeq	r1, [fp, #-2565]	; 0xfffff5fb
 480:	2f054c26 	svccs	0x00054c26
 484:	8231054a 	eorshi	r0, r1, #310378496	; 0x12800000
 488:	054a0905 	strbeq	r0, [sl, #-2309]	; 0xfffff6fb
 48c:	01052e3c 	tsteq	r5, ip, lsr lr
 490:	01040200 	mrseq	r0, R12_usr
 494:	0805694b 	stmdaeq	r5, {r0, r1, r3, r6, r8, fp, sp, lr}
 498:	663205d8 			; <UNDEFINED> instruction: 0x663205d8
 49c:	02002105 	andeq	r2, r0, #1073741825	; 0x40000001
 4a0:	054a0204 	strbeq	r0, [sl, #-516]	; 0xfffffdfc
 4a4:	04020006 	streq	r0, [r2], #-6
 4a8:	3205f202 	andcc	pc, r5, #536870912	; 0x20000000
 4ac:	03040200 	movweq	r0, #16896	; 0x4200
 4b0:	0051054a 	subseq	r0, r1, sl, asr #10
 4b4:	66060402 	strvs	r0, [r6], -r2, lsl #8
 4b8:	02003505 	andeq	r3, r0, #20971520	; 0x1400000
 4bc:	05f20604 	ldrbeq	r0, [r2, #1540]!	; 0x604
 4c0:	04020032 	streq	r0, [r2], #-50	; 0xffffffce
 4c4:	02004a07 	andeq	r4, r0, #28672	; 0x7000
 4c8:	4a060804 	bmi	1824e0 <_bss_end+0x178cfc>
 4cc:	02000205 	andeq	r0, r0, #1342177280	; 0x50000000
 4d0:	2e060a04 	vmlacs.f32	s0, s12, s8
 4d4:	054d1205 	strbeq	r1, [sp, #-517]	; 0xfffffdfb
 4d8:	0b056602 	bleq	159ce8 <_bss_end+0x150504>
 4dc:	6612054a 	ldrvs	r0, [r2], -sl, asr #10
 4e0:	052e0d05 	streq	r0, [lr, #-3333]!	; 0xfffff2fb
 4e4:	01054803 	tsteq	r5, r3, lsl #16
 4e8:	009e4a31 	addseq	r4, lr, r1, lsr sl
 4ec:	06010402 	streq	r0, [r1], -r2, lsl #8
 4f0:	06230566 	strteq	r0, [r3], -r6, ror #10
 4f4:	827fa903 	rsbshi	sl, pc, #49152	; 0xc000
 4f8:	d7030105 	strle	r0, [r3, -r5, lsl #2]
 4fc:	4aba6600 	bmi	fee99d04 <_bss_end+0xfee90520>
 500:	01000a02 	tsteq	r0, r2, lsl #20
 504:	00028901 	andeq	r8, r2, r1, lsl #18
 508:	35000300 	strcc	r0, [r0, #-768]	; 0xfffffd00
 50c:	02000001 	andeq	r0, r0, #1
 510:	0d0efb01 	vstreq	d15, [lr, #-4]
 514:	01010100 	mrseq	r0, (UNDEF: 17)
 518:	00000001 	andeq	r0, r0, r1
 51c:	01000001 	tsteq	r0, r1
 520:	6d6f682f 	stclvs	8, cr6, [pc, #-188]!	; 46c <shift+0x46c>
 524:	66632f65 	strbtvs	r2, [r3], -r5, ror #30
 528:	55435a2f 	strbpl	r5, [r3, #-2607]	; 0xfffff5d1
 52c:	7269662f 	rsbvc	r6, r9, #49283072	; 0x2f00000
 530:	795f7473 	ldmdbvc	pc, {r0, r1, r4, r5, r6, sl, ip, sp, lr}^	; <UNPREDICTABLE>
 534:	2f726165 	svccs	0x00726165
 538:	746e6977 	strbtvc	r6, [lr], #-2423	; 0xfffff689
 53c:	4f2f7265 	svcmi	0x002f7265
 540:	72702f53 	rsbsvc	r2, r0, #332	; 0x14c
 544:	69746361 	ldmdbvs	r4!, {r0, r5, r6, r8, r9, sp, lr}^
 548:	2f6c6163 	svccs	0x006c6163
 54c:	2f337865 	svccs	0x00337865
 550:	6e72656b 	cdpvs	5, 7, cr6, cr2, cr11, {3}
 554:	732f6c65 			; <UNDEFINED> instruction: 0x732f6c65
 558:	642f6372 	strtvs	r6, [pc], #-882	; 560 <shift+0x560>
 55c:	65766972 	ldrbvs	r6, [r6, #-2418]!	; 0xfffff68e
 560:	2f007372 	svccs	0x00007372
 564:	656d6f68 	strbvs	r6, [sp, #-3944]!	; 0xfffff098
 568:	2f66632f 	svccs	0x0066632f
 56c:	2f55435a 	svccs	0x0055435a
 570:	73726966 	cmnvc	r2, #1671168	; 0x198000
 574:	65795f74 	ldrbvs	r5, [r9, #-3956]!	; 0xfffff08c
 578:	772f7261 	strvc	r7, [pc, -r1, ror #4]!
 57c:	65746e69 	ldrbvs	r6, [r4, #-3689]!	; 0xfffff197
 580:	534f2f72 	movtpl	r2, #65394	; 0xff72
 584:	6172702f 	cmnvs	r2, pc, lsr #32
 588:	63697463 	cmnvs	r9, #1660944384	; 0x63000000
 58c:	652f6c61 	strvs	r6, [pc, #-3169]!	; fffff933 <_bss_end+0xffff614f>
 590:	6b2f3378 	blvs	bcd378 <_bss_end+0xbc3b94>
 594:	656e7265 	strbvs	r7, [lr, #-613]!	; 0xfffffd9b
 598:	6e692f6c 	cdpvs	15, 6, cr2, cr9, cr12, {3}
 59c:	64756c63 	ldrbtvs	r6, [r5], #-3171	; 0xfffff39d
 5a0:	6f622f65 	svcvs	0x00622f65
 5a4:	2f647261 	svccs	0x00647261
 5a8:	30697072 	rsbcc	r7, r9, r2, ror r0
 5ac:	6c61682f 	stclvs	8, cr6, [r1], #-188	; 0xffffff44
 5b0:	6f682f00 	svcvs	0x00682f00
 5b4:	632f656d 			; <UNDEFINED> instruction: 0x632f656d
 5b8:	435a2f66 	cmpmi	sl, #408	; 0x198
 5bc:	69662f55 	stmdbvs	r6!, {r0, r2, r4, r6, r8, r9, sl, fp, sp}^
 5c0:	5f747372 	svcpl	0x00747372
 5c4:	72616579 	rsbvc	r6, r1, #507510784	; 0x1e400000
 5c8:	6e69772f 	cdpvs	7, 6, cr7, cr9, cr15, {1}
 5cc:	2f726574 	svccs	0x00726574
 5d0:	702f534f 	eorvc	r5, pc, pc, asr #6
 5d4:	74636172 	strbtvc	r6, [r3], #-370	; 0xfffffe8e
 5d8:	6c616369 	stclvs	3, cr6, [r1], #-420	; 0xfffffe5c
 5dc:	3378652f 	cmncc	r8, #197132288	; 0xbc00000
 5e0:	72656b2f 	rsbvc	r6, r5, #48128	; 0xbc00
 5e4:	2f6c656e 	svccs	0x006c656e
 5e8:	6c636e69 	stclvs	14, cr6, [r3], #-420	; 0xfffffe5c
 5ec:	2f656475 	svccs	0x00656475
 5f0:	76697264 	strbtvc	r7, [r9], -r4, ror #4
 5f4:	00737265 	rsbseq	r7, r3, r5, ror #4
 5f8:	72617500 	rsbvc	r7, r1, #0, 10
 5fc:	70632e74 	rsbvc	r2, r3, r4, ror lr
 600:	00010070 	andeq	r0, r1, r0, ror r0
 604:	746e6900 	strbtvc	r6, [lr], #-2304	; 0xfffff700
 608:	2e666564 	cdpcs	5, 6, cr6, cr6, cr4, {3}
 60c:	00020068 	andeq	r0, r2, r8, rrx
 610:	69706700 	ldmdbvs	r0!, {r8, r9, sl, sp, lr}^
 614:	00682e6f 	rsbeq	r2, r8, pc, ror #28
 618:	70000003 	andvc	r0, r0, r3
 61c:	70697265 	rsbvc	r7, r9, r5, ror #4
 620:	61726568 	cmnvs	r2, r8, ror #10
 624:	682e736c 	stmdavs	lr!, {r2, r3, r5, r6, r8, r9, ip, sp, lr}
 628:	00000200 	andeq	r0, r0, r0, lsl #4
 62c:	5f6d6362 	svcpl	0x006d6362
 630:	2e787561 	cdpcs	5, 7, cr7, cr8, cr1, {3}
 634:	00030068 	andeq	r0, r3, r8, rrx
 638:	72617500 	rsbvc	r7, r1, #0, 10
 63c:	00682e74 	rsbeq	r2, r8, r4, ror lr
 640:	00000003 	andeq	r0, r0, r3
 644:	05000105 	streq	r0, [r0, #-261]	; 0xfffffefb
 648:	0087b802 	addeq	fp, r7, r2, lsl #16
 64c:	07051800 	streq	r1, [r5, -r0, lsl #16]
 650:	6805059f 	stmdavs	r5, {r0, r1, r2, r3, r4, r7, r8, sl}
 654:	054a1005 	strbeq	r1, [sl, #-5]
 658:	16056805 	strne	r6, [r5], -r5, lsl #16
 65c:	8305054a 	movwhi	r0, #21834	; 0x554a
 660:	054a1605 	strbeq	r1, [sl, #-1541]	; 0xfffff9fb
 664:	16058305 	strne	r8, [r5], -r5, lsl #6
 668:	8305054a 	movwhi	r0, #21834	; 0x554a
 66c:	054a1605 	strbeq	r1, [sl, #-1541]	; 0xfffff9fb
 670:	05858301 	streq	r8, [r5, #769]	; 0x301
 674:	2e059f05 	cdpcs	15, 0, cr9, cr5, cr5, {0}
 678:	4a3f054a 	bmi	fc1ba8 <_bss_end+0xfb83c4>
 67c:	05825605 	streq	r5, [r2, #1541]	; 0x605
 680:	16052e66 	strne	r2, [r5], -r6, ror #28
 684:	9f01052e 	svcls	0x0001052e
 688:	9f1c0569 	svcls	0x001c0569
 68c:	054b2d05 	strbeq	r2, [fp, #-3333]	; 0xfffff2fb
 690:	18052e53 	stmdane	r5, {r0, r1, r4, r6, r9, sl, fp, sp}
 694:	4c050582 	cfstr32mi	mvfx0, [r5], {130}	; 0x82
 698:	054a1605 	strbeq	r1, [sl, #-1541]	; 0xfffff9fb
 69c:	16058405 	strne	r8, [r5], -r5, lsl #8
 6a0:	8405054a 	strhi	r0, [r5], #-1354	; 0xfffffab6
 6a4:	054a1605 	strbeq	r1, [sl, #-1541]	; 0xfffff9fb
 6a8:	05a18301 	streq	r8, [r1, #769]!	; 0x301
 6ac:	0e05bc05 	cdpeq	12, 0, cr11, cr5, cr5, {0}
 6b0:	01040200 	mrseq	r0, R12_usr
 6b4:	001f052e 	andseq	r0, pc, lr, lsr #10
 6b8:	4a010402 	bmi	416c8 <_bss_end+0x37ee4>
 6bc:	02003605 	andeq	r3, r0, #5242880	; 0x500000
 6c0:	05820104 	streq	r0, [r2, #260]	; 0x104
 6c4:	0402000c 	streq	r0, [r2], #-12
 6c8:	05052e01 	streq	r2, [r5, #-3585]	; 0xfffff1ff
 6cc:	4a1605bd 	bmi	581dc8 <_bss_end+0x5785e4>
 6d0:	69830105 	stmibvs	r3, {r0, r2, r8}
 6d4:	05a10c05 	streq	r0, [r1, #3077]!	; 0xc05
 6d8:	13054a05 	movwne	r4, #23045	; 0x5a05
 6dc:	03040200 	movweq	r0, #16896	; 0x4200
 6e0:	0014052f 	andseq	r0, r4, pc, lsr #10
 6e4:	2e030402 	cdpcs	4, 0, cr0, cr3, cr2, {0}
 6e8:	02000e05 	andeq	r0, r0, #5, 28	; 0x50
 6ec:	054a0304 	strbeq	r0, [sl, #-772]	; 0xfffffcfc
 6f0:	04020005 	streq	r0, [r2], #-5
 6f4:	15058103 	strne	r8, [r5, #-259]	; 0xfffffefd
 6f8:	01040200 	mrseq	r0, R12_usr
 6fc:	00160566 	andseq	r0, r6, r6, ror #10
 700:	2e010402 	cdpcs	4, 0, cr0, cr1, cr2, {0}
 704:	02001805 	andeq	r1, r0, #327680	; 0x50000
 708:	05660104 	strbeq	r0, [r6, #-260]!	; 0xfffffefc
 70c:	15054c01 	strne	r4, [r5, #-3073]	; 0xfffff3ff
 710:	84050584 	strhi	r0, [r5], #-1412	; 0xfffffa7c
 714:	054a1005 	strbeq	r1, [sl, #-5]
 718:	0583691c 	streq	r6, [r3, #2332]	; 0x91c
 71c:	16058505 	strne	r8, [r5], -r5, lsl #10
 720:	8305054a 	movwhi	r0, #21834	; 0x554a
 724:	054a1605 	strbeq	r1, [sl, #-1541]	; 0xfffff9fb
 728:	16058305 	strne	r8, [r5], -r5, lsl #6
 72c:	8305054a 	movwhi	r0, #21834	; 0x554a
 730:	054a1605 	strbeq	r1, [sl, #-1541]	; 0xfffff9fb
 734:	18058319 	stmdane	r5, {r0, r3, r4, r8, r9, pc}
 738:	6b010567 	blvs	41cdc <_bss_end+0x384f8>
 73c:	05bc1405 	ldreq	r1, [ip, #1029]!	; 0x405
 740:	11058305 	tstne	r5, r5, lsl #6
 744:	6701054a 	strvs	r0, [r1, -sl, asr #10]
 748:	05691405 	strbeq	r1, [r9, #-1029]!	; 0xfffffbfb
 74c:	0e058305 	cdpeq	3, 0, cr8, cr5, cr5, {0}
 750:	01040200 	mrseq	r0, R12_usr
 754:	001f052e 	andseq	r0, pc, lr, lsr #10
 758:	4a010402 	bmi	41768 <_bss_end+0x37f84>
 75c:	02003605 	andeq	r3, r0, #5242880	; 0x500000
 760:	05820104 	streq	r0, [r2, #260]	; 0x104
 764:	0402000c 	streq	r0, [r2], #-12
 768:	12052e01 	andne	r2, r5, #1, 28
 76c:	4a2305bd 	bmi	8c1e68 <_bss_end+0x8b8684>
 770:	059f1305 	ldreq	r1, [pc, #773]	; a7d <shift+0xa7d>
 774:	9e664b01 	vmulls.f64	d20, d6, d1
 778:	01040200 	mrseq	r0, R12_usr
 77c:	12056606 	andne	r6, r5, #6291456	; 0x600000
 780:	7fb10306 	svcvc	0x00b10306
 784:	03010582 	movweq	r0, #5506	; 0x1582
 788:	ba6600cf 	blt	1980acc <_bss_end+0x19772e8>
 78c:	000a024a 	andeq	r0, sl, sl, asr #4
 790:	025c0101 	subseq	r0, ip, #1073741824	; 0x40000000
 794:	00030000 	andeq	r0, r3, r0
 798:	0000012d 	andeq	r0, r0, sp, lsr #2
 79c:	0efb0102 	cdpeq	1, 15, cr0, cr11, cr2, {0}
 7a0:	0101000d 	tsteq	r1, sp
 7a4:	00000101 	andeq	r0, r0, r1, lsl #2
 7a8:	00000100 	andeq	r0, r0, r0, lsl #2
 7ac:	6f682f01 	svcvs	0x00682f01
 7b0:	632f656d 			; <UNDEFINED> instruction: 0x632f656d
 7b4:	435a2f66 	cmpmi	sl, #408	; 0x198
 7b8:	69662f55 	stmdbvs	r6!, {r0, r2, r4, r6, r8, r9, sl, fp, sp}^
 7bc:	5f747372 	svcpl	0x00747372
 7c0:	72616579 	rsbvc	r6, r1, #507510784	; 0x1e400000
 7c4:	6e69772f 	cdpvs	7, 6, cr7, cr9, cr15, {1}
 7c8:	2f726574 	svccs	0x00726574
 7cc:	702f534f 	eorvc	r5, pc, pc, asr #6
 7d0:	74636172 	strbtvc	r6, [r3], #-370	; 0xfffffe8e
 7d4:	6c616369 	stclvs	3, cr6, [r1], #-420	; 0xfffffe5c
 7d8:	3378652f 	cmncc	r8, #197132288	; 0xbc00000
 7dc:	72656b2f 	rsbvc	r6, r5, #48128	; 0xbc00
 7e0:	2f6c656e 	svccs	0x006c656e
 7e4:	00637273 	rsbeq	r7, r3, r3, ror r2
 7e8:	6d6f682f 	stclvs	8, cr6, [pc, #-188]!	; 734 <shift+0x734>
 7ec:	66632f65 	strbtvs	r2, [r3], -r5, ror #30
 7f0:	55435a2f 	strbpl	r5, [r3, #-2607]	; 0xfffff5d1
 7f4:	7269662f 	rsbvc	r6, r9, #49283072	; 0x2f00000
 7f8:	795f7473 	ldmdbvc	pc, {r0, r1, r4, r5, r6, sl, ip, sp, lr}^	; <UNPREDICTABLE>
 7fc:	2f726165 	svccs	0x00726165
 800:	746e6977 	strbtvc	r6, [lr], #-2423	; 0xfffff689
 804:	4f2f7265 	svcmi	0x002f7265
 808:	72702f53 	rsbsvc	r2, r0, #332	; 0x14c
 80c:	69746361 	ldmdbvs	r4!, {r0, r5, r6, r8, r9, sp, lr}^
 810:	2f6c6163 	svccs	0x006c6163
 814:	2f337865 	svccs	0x00337865
 818:	6e72656b 	cdpvs	5, 7, cr6, cr2, cr11, {3}
 81c:	692f6c65 	stmdbvs	pc!, {r0, r2, r5, r6, sl, fp, sp, lr}	; <UNPREDICTABLE>
 820:	756c636e 	strbvc	r6, [ip, #-878]!	; 0xfffffc92
 824:	622f6564 	eorvs	r6, pc, #100, 10	; 0x19000000
 828:	6472616f 	ldrbtvs	r6, [r2], #-367	; 0xfffffe91
 82c:	6970722f 	ldmdbvs	r0!, {r0, r1, r2, r3, r5, r9, ip, sp, lr}^
 830:	61682f30 	cmnvs	r8, r0, lsr pc
 834:	682f006c 	stmdavs	pc!, {r2, r3, r5, r6}	; <UNPREDICTABLE>
 838:	2f656d6f 	svccs	0x00656d6f
 83c:	5a2f6663 	bpl	bda1d0 <_bss_end+0xbd09ec>
 840:	662f5543 	strtvs	r5, [pc], -r3, asr #10
 844:	74737269 	ldrbtvc	r7, [r3], #-617	; 0xfffffd97
 848:	6165795f 	cmnvs	r5, pc, asr r9
 84c:	69772f72 	ldmdbvs	r7!, {r1, r4, r5, r6, r8, r9, sl, fp, sp}^
 850:	7265746e 	rsbvc	r7, r5, #1845493760	; 0x6e000000
 854:	2f534f2f 	svccs	0x00534f2f
 858:	63617270 	cmnvs	r1, #112, 4
 85c:	61636974 	smcvs	13972	; 0x3694
 860:	78652f6c 	stmdavc	r5!, {r2, r3, r5, r6, r8, r9, sl, fp, sp}^
 864:	656b2f33 	strbvs	r2, [fp, #-3891]!	; 0xfffff0cd
 868:	6c656e72 	stclvs	14, cr6, [r5], #-456	; 0xfffffe38
 86c:	636e692f 	cmnvs	lr, #770048	; 0xbc000
 870:	6564756c 	strbvs	r7, [r4, #-1388]!	; 0xfffffa94
 874:	6972642f 	ldmdbvs	r2!, {r0, r1, r2, r3, r5, sl, sp, lr}^
 878:	73726576 	cmnvc	r2, #494927872	; 0x1d800000
 87c:	616d0000 	cmnvs	sp, r0
 880:	632e6e69 			; <UNDEFINED> instruction: 0x632e6e69
 884:	01007070 	tsteq	r0, r0, ror r0
 888:	6e690000 	cdpvs	0, 6, cr0, cr9, cr0, {0}
 88c:	66656474 			; <UNDEFINED> instruction: 0x66656474
 890:	0200682e 	andeq	r6, r0, #3014656	; 0x2e0000
 894:	70670000 	rsbvc	r0, r7, r0
 898:	682e6f69 	stmdavs	lr!, {r0, r3, r5, r6, r8, r9, sl, fp, sp, lr}
 89c:	00000300 	andeq	r0, r0, r0, lsl #6
 8a0:	69726570 	ldmdbvs	r2!, {r4, r5, r6, r8, sl, sp, lr}^
 8a4:	72656870 	rsbvc	r6, r5, #112, 16	; 0x700000
 8a8:	2e736c61 	cdpcs	12, 7, cr6, cr3, cr1, {3}
 8ac:	00020068 	andeq	r0, r2, r8, rrx
 8b0:	6d636200 	sfmvs	f6, 2, [r3, #-0]
 8b4:	7875615f 	ldmdavc	r5!, {r0, r1, r2, r3, r4, r6, r8, sp, lr}^
 8b8:	0300682e 	movweq	r6, #2094	; 0x82e
 8bc:	61750000 	cmnvs	r5, r0
 8c0:	682e7472 	stmdavs	lr!, {r1, r4, r5, r6, sl, ip, sp, lr}
 8c4:	00000300 	andeq	r0, r0, r0, lsl #6
 8c8:	001a0500 	andseq	r0, sl, r0, lsl #10
 8cc:	8c1c0205 	lfmhi	f0, 4, [ip], {5}
 8d0:	05180000 	ldreq	r0, [r8, #-0]
 8d4:	0205840a 	andeq	r8, r5, #167772160	; 0xa000000
 8d8:	0402004a 	streq	r0, [r2], #-74	; 0xffffffb6
 8dc:	052e0603 	streq	r0, [lr, #-1539]!	; 0xfffff9fd
 8e0:	04020013 	streq	r0, [r2], #-19	; 0xffffffed
 8e4:	05660601 	strbeq	r0, [r6, #-1537]!	; 0xfffff9ff
 8e8:	05a2f401 	streq	pc, [r2, #1025]!	; 0x401
 8ec:	054b9f09 	strbeq	r9, [fp, #-3849]	; 0xfffff0f7
 8f0:	13056705 	movwne	r6, #22277	; 0x5705
 8f4:	2e120531 	mrccs	5, 0, r0, cr2, cr1, {1}
 8f8:	054a0d05 	strbeq	r0, [sl, #-3333]	; 0xfffff2fb
 8fc:	18052e07 	stmdane	r5, {r0, r1, r2, r9, sl, fp, sp}
 900:	2e17052f 	cfmul64cs	mvdx0, mvdx7, mvdx15
 904:	054a0905 	strbeq	r0, [sl, #-2309]	; 0xfffff6fb
 908:	12052e08 	andne	r2, r5, #8, 28	; 0x80
 90c:	2e10054a 	cfmac32cs	mvfx0, mvfx0, mvfx10
 910:	052f0905 	streq	r0, [pc, #-2309]!	; 13 <shift+0x13>
 914:	0e052e08 	cdpeq	14, 0, cr2, cr5, cr8, {0}
 918:	0c05674a 	stceq	7, cr6, [r5], {74}	; 0x4a
 91c:	03120567 	tsteq	r2, #432013312	; 0x19c00000
 920:	01056679 	tsteq	r5, r9, ror r6
 924:	a2820903 	addge	r0, r2, #49152	; 0xc000
 928:	05bb0905 	ldreq	r0, [fp, #2309]!	; 0x905
 92c:	05054b0a 	streq	r4, [r5, #-2826]	; 0xfffff4f6
 930:	6809054d 	stmdavs	r9, {r0, r2, r3, r6, r8, sl}
 934:	052e0e05 	streq	r0, [lr, #-3589]!	; 0xfffff1fb
 938:	12056610 	andne	r6, r5, #16, 12	; 0x1000000
 93c:	4b0d052e 	blmi	341dfc <_bss_end+0x338618>
 940:	052e0e05 	streq	r0, [lr, #-3589]!	; 0xfffff1fb
 944:	054b4a10 	strbeq	r4, [fp, #-2576]	; 0xfffff5f0
 948:	11054f05 	tstne	r5, r5, lsl #30
 94c:	01040200 	mrseq	r0, R12_usr
 950:	68140566 	ldmdavs	r4, {r1, r2, r5, r6, r8, sl}
 954:	054b0d05 	strbeq	r0, [fp, #-3333]	; 0xfffff2fb
 958:	0d056a05 	vstreq	s12, [r5, #-20]	; 0xffffffec
 95c:	bb120530 	bllt	481e24 <_bss_end+0x478640>
 960:	02002805 	andeq	r2, r0, #327680	; 0x50000
 964:	05660104 	strbeq	r0, [r6, #-260]!	; 0xfffffefc
 968:	04020012 	streq	r0, [r2], #-18	; 0xffffffee
 96c:	34054a01 	strcc	r4, [r5], #-2561	; 0xfffff5ff
 970:	02040200 	andeq	r0, r4, #0, 4
 974:	00120566 	andseq	r0, r2, r6, ror #10
 978:	4a020402 	bmi	81988 <_bss_end+0x781a4>
 97c:	02000905 	andeq	r0, r0, #81920	; 0x14000
 980:	054a0404 	strbeq	r0, [sl, #-1028]	; 0xfffffbfc
 984:	0402000e 	streq	r0, [r2], #-14
 988:	10052e04 	andne	r2, r5, r4, lsl #28
 98c:	04040200 	streq	r0, [r4], #-512	; 0xfffffe00
 990:	00120566 	andseq	r0, r2, r6, ror #10
 994:	2e040402 	cdpcs	4, 0, cr0, cr4, cr2, {0}
 998:	02000d05 	andeq	r0, r0, #320	; 0x140
 99c:	052f0404 	streq	r0, [pc, #-1028]!	; 5a0 <shift+0x5a0>
 9a0:	05059a10 	streq	r9, [r5, #-2576]	; 0xfffff5f0
 9a4:	6709056e 	strvs	r0, [r9, -lr, ror #10]
 9a8:	052e0e05 	streq	r0, [lr, #-3589]!	; 0xfffff1fb
 9ac:	12056610 	andne	r6, r5, #16, 12	; 0x1000000
 9b0:	4c09052e 	cfstr32mi	mvfx0, [r9], {46}	; 0x2e
 9b4:	052e0a05 	streq	r0, [lr, #-2565]!	; 0xfffff5fb
 9b8:	684d4a0c 	stmdavs	sp, {r2, r3, r9, fp, lr}^
 9bc:	692f0105 	stmdbvs	pc!, {r0, r2, r8}	; <UNPREDICTABLE>
 9c0:	05681905 	strbeq	r1, [r8, #-2309]!	; 0xfffff6fb
 9c4:	18058516 	stmdane	r5, {r1, r2, r4, r8, sl, pc}
 9c8:	670e0567 	strvs	r0, [lr, -r7, ror #10]
 9cc:	6a0c054d 	bvs	301f08 <_bss_end+0x2f8724>
 9d0:	054b0f05 	strbeq	r0, [fp, #-3845]	; 0xfffff0fb
 9d4:	08056807 	stmdaeq	r5, {r0, r1, r2, fp, sp, lr}
 9d8:	d707054b 	strle	r0, [r7, -fp, asr #10]
 9dc:	839f0f05 	orrshi	r0, pc, #5, 30
 9e0:	69120567 	ldmdbvs	r2, {r0, r1, r2, r5, r6, r8, sl}
 9e4:	d7840f05 	strle	r0, [r4, r5, lsl #30]
 9e8:	11030505 	tstne	r3, r5, lsl #10
 9ec:	00120266 	andseq	r0, r2, r6, ror #4
 9f0:	00480101 	subeq	r0, r8, r1, lsl #2
 9f4:	00050000 	andeq	r0, r5, r0
 9f8:	002e0004 	eoreq	r0, lr, r4
 9fc:	01020000 	mrseq	r0, (UNDEF: 2)
 a00:	0d0efb01 	vstreq	d15, [lr, #-4]
 a04:	01010100 	mrseq	r0, (UNDEF: 17)
 a08:	00000001 	andeq	r0, r0, r1
 a0c:	01000001 	tsteq	r0, r1
 a10:	021f0101 	andseq	r0, pc, #1073741824	; 0x40000000
 a14:	00000000 	andeq	r0, r0, r0
 a18:	00000036 	andeq	r0, r0, r6, lsr r0
 a1c:	021f0102 	andseq	r0, pc, #-2147483648	; 0x80000000
 a20:	0071020f 	rsbseq	r0, r1, pc, lsl #4
 a24:	71010000 	mrsvc	r0, (UNDEF: 1)
 a28:	01000000 	mrseq	r0, (UNDEF: 0)
 a2c:	00020500 	andeq	r0, r2, r0, lsl #10
 a30:	19000080 	stmdbne	r0, {r7}
 a34:	2f2f2f2f 	svccs	0x002f2f2f
 a38:	00020230 	andeq	r0, r2, r0, lsr r2
 a3c:	00e70101 	rsceq	r0, r7, r1, lsl #2
 a40:	00030000 	andeq	r0, r3, r0
 a44:	0000005d 	andeq	r0, r0, sp, asr r0
 a48:	0efb0102 	cdpeq	1, 15, cr0, cr11, cr2, {0}
 a4c:	0101000d 	tsteq	r1, sp
 a50:	00000101 	andeq	r0, r0, r1, lsl #2
 a54:	00000100 	andeq	r0, r0, r0, lsl #2
 a58:	6f682f01 	svcvs	0x00682f01
 a5c:	632f656d 			; <UNDEFINED> instruction: 0x632f656d
 a60:	435a2f66 	cmpmi	sl, #408	; 0x198
 a64:	69662f55 	stmdbvs	r6!, {r0, r2, r4, r6, r8, r9, sl, fp, sp}^
 a68:	5f747372 	svcpl	0x00747372
 a6c:	72616579 	rsbvc	r6, r1, #507510784	; 0x1e400000
 a70:	6e69772f 	cdpvs	7, 6, cr7, cr9, cr15, {1}
 a74:	2f726574 	svccs	0x00726574
 a78:	702f534f 	eorvc	r5, pc, pc, asr #6
 a7c:	74636172 	strbtvc	r6, [r3], #-370	; 0xfffffe8e
 a80:	6c616369 	stclvs	3, cr6, [r1], #-420	; 0xfffffe5c
 a84:	3378652f 	cmncc	r8, #197132288	; 0xbc00000
 a88:	72656b2f 	rsbvc	r6, r5, #48128	; 0xbc00
 a8c:	2f6c656e 	svccs	0x006c656e
 a90:	00637273 	rsbeq	r7, r3, r3, ror r2
 a94:	61747300 	cmnvs	r4, r0, lsl #6
 a98:	70757472 	rsbsvc	r7, r5, r2, ror r4
 a9c:	7070632e 	rsbsvc	r6, r0, lr, lsr #6
 aa0:	00000100 	andeq	r0, r0, r0, lsl #2
 aa4:	00010500 	andeq	r0, r1, r0, lsl #10
 aa8:	8fb80205 	svchi	0x00b80205
 aac:	14030000 	strne	r0, [r3], #-0
 ab0:	6a090501 	bvs	241ebc <_bss_end+0x2386d8>
 ab4:	05660205 	strbeq	r0, [r6, #-517]!	; 0xfffffdfb
 ab8:	04020006 	streq	r0, [r2], #-6
 abc:	02052f03 	andeq	r2, r5, #3, 30
 ac0:	03040200 	movweq	r0, #16896	; 0x4200
 ac4:	001f0565 	andseq	r0, pc, r5, ror #10
 ac8:	66010402 	strvs	r0, [r1], -r2, lsl #8
 acc:	05bd0905 	ldreq	r0, [sp, #2309]!	; 0x905
 ad0:	05bd2f01 	ldreq	r2, [sp, #3841]!	; 0xf01
 ad4:	02056b0d 	andeq	r6, r5, #13312	; 0x3400
 ad8:	0004054a 	andeq	r0, r4, sl, asr #10
 adc:	2f030402 	svccs	0x00030402
 ae0:	02000b05 	andeq	r0, r0, #5120	; 0x1400
 ae4:	054a0304 	strbeq	r0, [sl, #-772]	; 0xfffffcfc
 ae8:	04020002 	streq	r0, [r2], #-2
 aec:	24052d03 	strcs	r2, [r5], #-3331	; 0xfffff2fd
 af0:	01040200 	mrseq	r0, R12_usr
 af4:	85090566 	strhi	r0, [r9, #-1382]	; 0xfffffa9a
 af8:	a12f0105 			; <UNDEFINED> instruction: 0xa12f0105
 afc:	056a0d05 	strbeq	r0, [sl, #-3333]!	; 0xfffff2fb
 b00:	04054a02 	streq	r4, [r5], #-2562	; 0xfffff5fe
 b04:	03040200 	movweq	r0, #16896	; 0x4200
 b08:	000b052f 	andeq	r0, fp, pc, lsr #10
 b0c:	4a030402 	bmi	c1b1c <_bss_end+0xb8338>
 b10:	02000205 	andeq	r0, r0, #1342177280	; 0x50000000
 b14:	052d0304 	streq	r0, [sp, #-772]!	; 0xfffffcfc
 b18:	04020024 	streq	r0, [r2], #-36	; 0xffffffdc
 b1c:	09056601 	stmdbeq	r5, {r0, r9, sl, sp, lr}
 b20:	2f010585 	svccs	0x00010585
 b24:	01000a02 	tsteq	r0, r2, lsl #20
 b28:	00006301 	andeq	r6, r0, r1, lsl #6
 b2c:	04000500 	streq	r0, [r0], #-1280	; 0xfffffb00
 b30:	00002e00 	andeq	r2, r0, r0, lsl #28
 b34:	01010200 	mrseq	r0, R9_usr
 b38:	000d0efb 	strdeq	r0, [sp], -fp
 b3c:	01010101 	tsteq	r1, r1, lsl #2
 b40:	01000000 	mrseq	r0, (UNDEF: 0)
 b44:	01010000 	mrseq	r0, (UNDEF: 1)
 b48:	79021f01 	stmdbvc	r2, {r0, r8, r9, sl, fp, ip}
 b4c:	79000000 	stmdbvc	r0, {}	; <UNPREDICTABLE>
 b50:	02000000 	andeq	r0, r0, #0
 b54:	0f021f01 	svceq	0x00021f01
 b58:	0000a802 	andeq	sl, r0, r2, lsl #16
 b5c:	00a80000 	adceq	r0, r8, r0
 b60:	00010000 	andeq	r0, r1, r0
 b64:	90d00205 	sbcsls	r0, r0, r5, lsl #4
 b68:	cf030000 	svcgt	0x00030000
 b6c:	2f300108 	svccs	0x00300108
 b70:	2f2f2f2f 	svccs	0x002f2f2f
 b74:	01d00230 	bicseq	r0, r0, r0, lsr r2
 b78:	2f312f14 	svccs	0x00312f14
 b7c:	2f4c302f 	svccs	0x004c302f
 b80:	661f0332 			; <UNDEFINED> instruction: 0x661f0332
 b84:	2f2f2f2f 	svccs	0x002f2f2f
 b88:	022f2f2f 	eoreq	r2, pc, #47, 30	; 0xbc
 b8c:	01010002 	tsteq	r1, r2
 b90:	0000006f 	andeq	r0, r0, pc, rrx
 b94:	00040005 	andeq	r0, r4, r5
 b98:	0000002e 	andeq	r0, r0, lr, lsr #32
 b9c:	fb010102 	blx	40fae <_bss_end+0x377ca>
 ba0:	01000d0e 	tsteq	r0, lr, lsl #26
 ba4:	00010101 	andeq	r0, r1, r1, lsl #2
 ba8:	00010000 	andeq	r0, r1, r0
 bac:	01010100 	mrseq	r0, (UNDEF: 17)
 bb0:	0079021f 	rsbseq	r0, r9, pc, lsl r2
 bb4:	00790000 	rsbseq	r0, r9, r0
 bb8:	01020000 	mrseq	r0, (UNDEF: 2)
 bbc:	020f021f 	andeq	r0, pc, #-268435455	; 0xf0000001
 bc0:	000000a8 	andeq	r0, r0, r8, lsr #1
 bc4:	0000a800 	andeq	sl, r0, r0, lsl #16
 bc8:	05000100 	streq	r0, [r0, #-256]	; 0xffffff00
 bcc:	0092dc02 	addseq	sp, r2, r2, lsl #24
 bd0:	0a900300 	beq	fe4017d8 <_bss_end+0xfe3f7ff4>
 bd4:	30302f01 	eorscc	r2, r0, r1, lsl #30
 bd8:	302f2f2f 	eorcc	r2, pc, pc, lsr #30
 bdc:	2f2f2f2f 	svccs	0x002f2f2f
 be0:	01d00230 	bicseq	r0, r0, r0, lsr r2
 be4:	302f3014 	eorcc	r3, pc, r4, lsl r0	; <UNPREDICTABLE>
 be8:	30312f30 	eorscc	r2, r1, r0, lsr pc
 bec:	4c302f2f 	ldcmi	15, cr2, [r0], #-188	; 0xffffff44
 bf0:	322f302f 	eorcc	r3, pc, #47	; 0x2f
 bf4:	2f821f03 	svccs	0x00821f03
 bf8:	2f2f2f2f 	svccs	0x002f2f2f
 bfc:	02022f2f 	andeq	r2, r2, #47, 30	; 0xbc
 c00:	46010100 	strmi	r0, [r1], -r0, lsl #2
 c04:	05000000 	streq	r0, [r0, #-0]
 c08:	2e000400 	cfcpyscs	mvf0, mvf0
 c0c:	02000000 	andeq	r0, r0, #0
 c10:	0efb0101 	cdpeq	1, 15, cr0, cr11, cr1, {0}
 c14:	0101000d 	tsteq	r1, sp
 c18:	00000101 	andeq	r0, r0, r1, lsl #2
 c1c:	00000100 	andeq	r0, r0, r0, lsl #2
 c20:	1f010101 	svcne	0x00010101
 c24:	00007902 	andeq	r7, r0, r2, lsl #18
 c28:	00007900 	andeq	r7, r0, r0, lsl #18
 c2c:	1f010200 	svcne	0x00010200
 c30:	a8020f02 	stmdage	r2, {r1, r8, r9, sl, fp}
 c34:	00000000 	andeq	r0, r0, r0
 c38:	000000a8 	andeq	r0, r0, r8, lsr #1
 c3c:	02050001 	andeq	r0, r5, #1
 c40:	0000951c 	andeq	r9, r0, ip, lsl r5
 c44:	010bb903 	tsteq	fp, r3, lsl #18
 c48:	01000202 	tsteq	r0, r2, lsl #4
 c4c:	0000ba01 	andeq	fp, r0, r1, lsl #20
 c50:	b4000300 	strlt	r0, [r0], #-768	; 0xfffffd00
 c54:	02000000 	andeq	r0, r0, #0
 c58:	0d0efb01 	vstreq	d15, [lr, #-4]
 c5c:	01010100 	mrseq	r0, (UNDEF: 17)
 c60:	00000001 	andeq	r0, r0, r1
 c64:	01000001 	tsteq	r0, r1
 c68:	2e2f2e2e 	cdpcs	14, 2, cr2, cr15, cr14, {1}
 c6c:	2e2e2f2e 	cdpcs	15, 2, cr2, cr14, cr14, {1}
 c70:	2f2e2e2f 	svccs	0x002e2e2f
 c74:	2e2f2e2e 	cdpcs	14, 2, cr2, cr15, cr14, {1}
 c78:	63672f2e 	cmnvs	r7, #46, 30	; 0xb8
 c7c:	32312d63 	eorscc	r2, r1, #6336	; 0x18c0
 c80:	302e322e 	eorcc	r3, lr, lr, lsr #4
 c84:	62696c2f 	rsbvs	r6, r9, #12032	; 0x2f00
 c88:	00636367 	rsbeq	r6, r3, r7, ror #6
 c8c:	2e2f2e2e 	cdpcs	14, 2, cr2, cr15, cr14, {1}
 c90:	2e2e2f2e 	cdpcs	15, 2, cr2, cr14, cr14, {1}
 c94:	2f2e2e2f 	svccs	0x002e2e2f
 c98:	2e2f2e2e 	cdpcs	14, 2, cr2, cr15, cr14, {1}
 c9c:	6363672f 	cmnvs	r3, #12320768	; 0xbc0000
 ca0:	2f2e2e00 	svccs	0x002e2e00
 ca4:	2e2f2e2e 	cdpcs	14, 2, cr2, cr15, cr14, {1}
 ca8:	2e2e2f2e 	cdpcs	15, 2, cr2, cr14, cr14, {1}
 cac:	2f2e2e2f 	svccs	0x002e2e2f
 cb0:	672f2e2e 	strvs	r2, [pc, -lr, lsr #28]!
 cb4:	312d6363 			; <UNDEFINED> instruction: 0x312d6363
 cb8:	2e322e32 	mrccs	14, 1, r2, cr2, cr2, {1}
 cbc:	696c2f30 	stmdbvs	ip!, {r4, r5, r8, r9, sl, fp, sp}^
 cc0:	63636762 	cmnvs	r3, #25690112	; 0x1880000
 cc4:	2f2e2e2f 	svccs	0x002e2e2f
 cc8:	2f636367 	svccs	0x00636367
 ccc:	666e6f63 	strbtvs	r6, [lr], -r3, ror #30
 cd0:	612f6769 			; <UNDEFINED> instruction: 0x612f6769
 cd4:	00006d72 	andeq	r6, r0, r2, ror sp
 cd8:	6762696c 	strbvs	r6, [r2, -ip, ror #18]!
 cdc:	2e326363 	cdpcs	3, 3, cr6, cr2, cr3, {3}
 ce0:	00010063 	andeq	r0, r1, r3, rrx
 ce4:	6d726100 	ldfvse	f6, [r2, #-0]
 ce8:	6173692d 	cmnvs	r3, sp, lsr #18
 cec:	0200682e 	andeq	r6, r0, #3014656	; 0x2e0000
 cf0:	72610000 	rsbvc	r0, r1, #0
 cf4:	00682e6d 	rsbeq	r2, r8, sp, ror #28
 cf8:	67000003 	strvs	r0, [r0, -r3]
 cfc:	632d6c62 			; <UNDEFINED> instruction: 0x632d6c62
 d00:	73726f74 	cmnvc	r2, #116, 30	; 0x1d0
 d04:	0100682e 	tsteq	r0, lr, lsr #16
 d08:	dc000000 	stcle	0, cr0, [r0], {-0}
 d0c:	03000001 	movweq	r0, #1
 d10:	0000c300 	andeq	ip, r0, r0, lsl #6
 d14:	fb010200 	blx	4151e <_bss_end+0x37d3a>
 d18:	01000d0e 	tsteq	r0, lr, lsl #26
 d1c:	00010101 	andeq	r0, r1, r1, lsl #2
 d20:	00010000 	andeq	r0, r1, r0
 d24:	2e2e0100 	sufcse	f0, f6, f0
 d28:	2f2e2e2f 	svccs	0x002e2e2f
 d2c:	2e2f2e2e 	cdpcs	14, 2, cr2, cr15, cr14, {1}
 d30:	2e2e2f2e 	cdpcs	15, 2, cr2, cr14, cr14, {1}
 d34:	2f2e2e2f 	svccs	0x002e2e2f
 d38:	2e2f2e2e 	cdpcs	14, 2, cr2, cr15, cr14, {1}
 d3c:	656e2f2e 	strbvs	r2, [lr, #-3886]!	; 0xfffff0d2
 d40:	62696c77 	rsbvs	r6, r9, #30464	; 0x7700
 d44:	62696c2f 	rsbvs	r6, r9, #12032	; 0x2f00
 d48:	74732f63 	ldrbtvc	r2, [r3], #-3939	; 0xfffff09d
 d4c:	676e6972 			; <UNDEFINED> instruction: 0x676e6972
 d50:	73752f00 	cmnvc	r5, #0, 30
 d54:	696c2f72 	stmdbvs	ip!, {r1, r4, r5, r6, r8, r9, sl, fp, sp}^
 d58:	63672f62 	cmnvs	r7, #392	; 0x188
 d5c:	72612f63 	rsbvc	r2, r1, #396	; 0x18c
 d60:	6f6e2d6d 	svcvs	0x006e2d6d
 d64:	652d656e 	strvs	r6, [sp, #-1390]!	; 0xfffffa92
 d68:	2f696261 	svccs	0x00696261
 d6c:	312e3131 			; <UNDEFINED> instruction: 0x312e3131
 d70:	692f302e 	stmdbvs	pc!, {r1, r2, r3, r5, ip, sp}	; <UNPREDICTABLE>
 d74:	756c636e 	strbvc	r6, [ip, #-878]!	; 0xfffffc92
 d78:	2f006564 	svccs	0x00006564
 d7c:	6c697562 	cfstr64vs	mvdx7, [r9], #-392	; 0xfffffe78
 d80:	72696464 	rsbvc	r6, r9, #100, 8	; 0x64000000
 d84:	6975622f 	ldmdbvs	r5!, {r0, r1, r2, r3, r5, r9, sp, lr}^
 d88:	422f646c 	eormi	r6, pc, #108, 8	; 0x6c000000
 d8c:	444c4955 	strbmi	r4, [ip], #-2389	; 0xfffff6ab
 d90:	77656e2f 	strbvc	r6, [r5, -pc, lsr #28]!
 d94:	2d62696c 			; <UNDEFINED> instruction: 0x2d62696c
 d98:	2e312e34 	mrccs	14, 1, r2, cr1, cr4, {1}
 d9c:	656e2f30 	strbvs	r2, [lr, #-3888]!	; 0xfffff0d0
 da0:	62696c77 	rsbvs	r6, r9, #30464	; 0x7700
 da4:	62696c2f 	rsbvs	r6, r9, #12032	; 0x2f00
 da8:	6e692f63 	cdpvs	15, 6, cr2, cr9, cr3, {3}
 dac:	64756c63 	ldrbtvs	r6, [r5], #-3171	; 0xfffff39d
 db0:	6d000065 	stcvs	0, cr0, [r0, #-404]	; 0xfffffe6c
 db4:	65736d65 	ldrbvs	r6, [r3, #-3429]!	; 0xfffff29b
 db8:	00632e74 	rsbeq	r2, r3, r4, ror lr
 dbc:	73000001 	movwvc	r0, #1
 dc0:	65646474 	strbvs	r6, [r4, #-1140]!	; 0xfffffb8c
 dc4:	00682e66 	rsbeq	r2, r8, r6, ror #28
 dc8:	73000002 	movwvc	r0, #2
 dcc:	6e697274 	mcrvs	2, 3, r7, cr9, cr4, {3}
 dd0:	00682e67 	rsbeq	r2, r8, r7, ror #28
 dd4:	00000003 	andeq	r0, r0, r3
 dd8:	05000105 	streq	r0, [r0, #-261]	; 0xfffffefb
 ddc:	00952002 	addseq	r2, r5, r2
 de0:	01280300 			; <UNDEFINED> instruction: 0x01280300
 de4:	15130305 	ldrne	r0, [r3, #-773]	; 0xfffffcfb
 de8:	05131313 	ldreq	r1, [r3, #-787]	; 0xfffffced
 dec:	0515060a 	ldreq	r0, [r5, #-1546]	; 0xfffff9f6
 df0:	052e0603 	streq	r0, [lr, #-1539]!	; 0xfffff9fd
 df4:	0705010a 	streq	r0, [r5, -sl, lsl #2]
 df8:	060a0530 			; <UNDEFINED> instruction: 0x060a0530
 dfc:	2e0c0501 	cfsh32cs	mvfx0, mvfx12, #1
 e00:	052e0a05 	streq	r0, [lr, #-2565]!	; 0xfffff5fb
 e04:	09052f10 	stmdbeq	r5, {r4, r8, r9, sl, fp, sp}
 e08:	052e7403 	streq	r7, [lr, #-1027]!	; 0xfffffbfd
 e0c:	4a0b030c 	bmi	2c1a44 <_bss_end+0x2b8260>
 e10:	052e0a05 	streq	r0, [lr, #-2565]!	; 0xfffff5fb
 e14:	054a0607 	strbeq	r0, [sl, #-1543]	; 0xfffff9f9
 e18:	0e051309 	cdpeq	3, 0, cr1, cr5, cr9, {0}
 e1c:	0a050106 	beq	14123c <_bss_end+0x137a58>
 e20:	03052b06 	movweq	r2, #23302	; 0x5b06
 e24:	06060552 			; <UNDEFINED> instruction: 0x06060552
 e28:	03010501 	movweq	r0, #5377	; 0x1501
 e2c:	10054a6e 	andne	r4, r5, lr, ror #20
 e30:	06070535 			; <UNDEFINED> instruction: 0x06070535
 e34:	162e0e03 	strtne	r0, [lr], -r3, lsl #28
 e38:	01060e05 	tsteq	r6, r5, lsl #28
 e3c:	2f060705 	svccs	0x00060705
 e40:	17061005 	strne	r1, [r6, -r5]
 e44:	05290e05 	streq	r0, [r9, #-3589]!	; 0xfffff1fb
 e48:	052f0607 	streq	r0, [pc, #-1543]!	; 849 <shift+0x849>
 e4c:	10050116 	andne	r0, r5, r6, lsl r1
 e50:	052e0616 	streq	r0, [lr, #-1558]!	; 0xfffff9ea
 e54:	05bc060b 	ldreq	r0, [ip, #1547]!	; 0x60b
 e58:	0501061b 	streq	r0, [r1, #-1563]	; 0xfffff9e5
 e5c:	052f060b 	streq	r0, [pc, #-1547]!	; 859 <shift+0x859>
 e60:	0501061b 	streq	r0, [r1, #-1563]	; 0xfffff9e5
 e64:	052f060b 	streq	r0, [pc, #-1547]!	; 861 <shift+0x861>
 e68:	0501061b 	streq	r0, [r1, #-1563]	; 0xfffff9e5
 e6c:	052f060b 	streq	r0, [pc, #-1547]!	; 869 <shift+0x869>
 e70:	0501061b 	streq	r0, [r1, #-1563]	; 0xfffff9e5
 e74:	052f060b 	streq	r0, [pc, #-1547]!	; 871 <shift+0x871>
 e78:	017a0310 	cmneq	sl, r0, lsl r3
 e7c:	18052e06 	stmdane	r5, {r1, r2, r9, sl, fp, sp}
 e80:	3210054f 	andscc	r0, r0, #331350016	; 0x13c00000
 e84:	052a1805 	streq	r1, [sl, #-2053]!	; 0xfffff7fb
 e88:	10052f0d 	andne	r2, r5, sp, lsl #30
 e8c:	2e063106 	adfcss	f3, f6, f6
 e90:	060b052e 	streq	r0, [fp], -lr, lsr #10
 e94:	061b0568 	ldreq	r0, [fp], -r8, ror #10
 e98:	060b0501 	streq	r0, [fp], -r1, lsl #10
 e9c:	0f10052f 	svceq	0x0010052f
 ea0:	4d060d05 	stcmi	13, cr0, [r6, #-20]	; 0xffffffec
 ea4:	36060a05 	strcc	r0, [r6], -r5, lsl #20
 ea8:	10050106 	andne	r0, r5, r6, lsl #2
 eac:	2e4a5a03 	vmlacs.f32	s11, s20, s6
 eb0:	03060505 	movweq	r0, #25861	; 0x6505
 eb4:	0a052e27 	beq	14c758 <_bss_end+0x142f74>
 eb8:	2d060106 	stfcss	f0, [r6, #-24]	; 0xffffffe8
 ebc:	66060106 	strvs	r0, [r6], -r6, lsl #2
 ec0:	10050106 	andne	r0, r5, r6, lsl #2
 ec4:	2e4a5a03 	vmlacs.f32	s11, s20, s6
 ec8:	03060505 	movweq	r0, #25861	; 0x6505
 ecc:	0a052e27 	beq	14c770 <_bss_end+0x142f8c>
 ed0:	2d060106 	stfcss	f0, [r6, #-24]	; 0xffffffe8
 ed4:	18050106 	stmdane	r5, {r1, r2, r8}
 ed8:	2e667103 	powcss	f7, f6, f3
 edc:	5d030905 	vstrpl.16	s0, [r3, #-10]	; <UNPREDICTABLE>
 ee0:	0310052e 	tsteq	r0, #192937984	; 0xb800000
 ee4:	04024a1e 	streq	r4, [r2], #-2590	; 0xfffff5e2
 ee8:	Address 0x0000000000000ee8 is out of bounds.


Disassembly of section .debug_str:

00000000 <.debug_str>:
       0:	6d6f682f 	stclvs	8, cr6, [pc, #-188]!	; ffffff4c <_bss_end+0xffff6768>
       4:	66632f65 	strbtvs	r2, [r3], -r5, ror #30
       8:	55435a2f 	strbpl	r5, [r3, #-2607]	; 0xfffff5d1
       c:	7269662f 	rsbvc	r6, r9, #49283072	; 0x2f00000
      10:	795f7473 	ldmdbvc	pc, {r0, r1, r4, r5, r6, sl, ip, sp, lr}^	; <UNPREDICTABLE>
      14:	2f726165 	svccs	0x00726165
      18:	746e6977 	strbtvc	r6, [lr], #-2423	; 0xfffff689
      1c:	4f2f7265 	svcmi	0x002f7265
      20:	72702f53 	rsbsvc	r2, r0, #332	; 0x14c
      24:	69746361 	ldmdbvs	r4!, {r0, r5, r6, r8, r9, sp, lr}^
      28:	2f6c6163 	svccs	0x006c6163
      2c:	2f337865 	svccs	0x00337865
      30:	6c697562 	cfstr64vs	mvdx7, [r9], #-392	; 0xfffffe78
      34:	5f5f0064 	svcpl	0x005f0064
      38:	5f617863 	svcpl	0x00617863
      3c:	72617567 	rsbvc	r7, r1, #432013312	; 0x19c00000
      40:	65725f64 	ldrbvs	r5, [r2, #-3940]!	; 0xfffff09c
      44:	7361656c 	cmnvc	r1, #108, 10	; 0x1b000000
      48:	5f5f0065 	svcpl	0x005f0065
      4c:	5f617863 	svcpl	0x00617863
      50:	72617567 	rsbvc	r7, r1, #432013312	; 0x19c00000
      54:	62615f64 	rsbvs	r5, r1, #100, 30	; 0x190
      58:	0074726f 	rsbseq	r7, r4, pc, ror #4
      5c:	73645f5f 	cmnvc	r4, #380	; 0x17c
      60:	61685f6f 	cmnvs	r8, pc, ror #30
      64:	656c646e 	strbvs	r6, [ip, #-1134]!	; 0xfffffb92
      68:	635f5f00 	cmpvs	pc, #0, 30
      6c:	615f6178 	cmpvs	pc, r8, ror r1	; <UNPREDICTABLE>
      70:	69786574 	ldmdbvs	r8!, {r2, r4, r5, r6, r8, sl, sp, lr}^
      74:	4e470074 	mcrmi	0, 2, r0, cr7, cr4, {3}
      78:	2b432055 	blcs	10c81d4 <_bss_end+0x10be9f0>
      7c:	2037312b 	eorscs	r3, r7, fp, lsr #2
      80:	322e3231 	eorcc	r3, lr, #268435459	; 0x10000003
      84:	2d20302e 	stccs	0, cr3, [r0, #-184]!	; 0xffffff48
      88:	6f6c666d 	svcvs	0x006c666d
      8c:	612d7461 			; <UNDEFINED> instruction: 0x612d7461
      90:	683d6962 	ldmdavs	sp!, {r1, r5, r6, r8, fp, sp, lr}
      94:	20647261 	rsbcs	r7, r4, r1, ror #4
      98:	70666d2d 	rsbvc	r6, r6, sp, lsr #26
      9c:	66763d75 			; <UNDEFINED> instruction: 0x66763d75
      a0:	6d2d2070 	stcvs	0, cr2, [sp, #-448]!	; 0xfffffe40
      a4:	616f6c66 	cmnvs	pc, r6, ror #24
      a8:	62612d74 	rsbvs	r2, r1, #116, 26	; 0x1d00
      ac:	61683d69 	cmnvs	r8, r9, ror #26
      b0:	2d206472 	cfstrscs	mvf6, [r0, #-456]!	; 0xfffffe38
      b4:	7570666d 	ldrbvc	r6, [r0, #-1645]!	; 0xfffff993
      b8:	7066763d 	rsbvc	r7, r6, sp, lsr r6
      bc:	746d2d20 	strbtvc	r2, [sp], #-3360	; 0xfffff2e0
      c0:	3d656e75 	stclcc	14, cr6, [r5, #-468]!	; 0xfffffe2c
      c4:	316d7261 	cmncc	sp, r1, ror #4
      c8:	6a363731 	bvs	d8dd94 <_bss_end+0xd845b0>
      cc:	732d667a 			; <UNDEFINED> instruction: 0x732d667a
      d0:	616d2d20 	cmnvs	sp, r0, lsr #26
      d4:	2d206d72 	stccs	13, cr6, [r0, #-456]!	; 0xfffffe38
      d8:	6372616d 	cmnvs	r2, #1073741851	; 0x4000001b
      dc:	72613d68 	rsbvc	r3, r1, #104, 26	; 0x1a00
      e0:	7a36766d 	bvc	d9da9c <_bss_end+0xd942b8>
      e4:	70662b6b 	rsbvc	r2, r6, fp, ror #22
      e8:	20672d20 	rsbcs	r2, r7, r0, lsr #26
      ec:	2d20672d 	stccs	7, cr6, [r0, #-180]!	; 0xffffff4c
      f0:	2d20304f 	stccs	0, cr3, [r0, #-316]!	; 0xfffffec4
      f4:	5f00304f 	svcpl	0x0000304f
      f8:	6178635f 	cmnvs	r8, pc, asr r3
      fc:	6175675f 	cmnvs	r5, pc, asr r7
     100:	615f6472 	cmpvs	pc, r2, ror r4	; <UNPREDICTABLE>
     104:	69757163 	ldmdbvs	r5!, {r0, r1, r5, r6, r8, ip, sp, lr}^
     108:	5f006572 	svcpl	0x00006572
     10c:	7878635f 	ldmdavc	r8!, {r0, r1, r2, r3, r4, r6, r8, r9, sp, lr}^
     110:	76696261 	strbtvc	r6, [r9], -r1, ror #4
     114:	6f6c0031 	svcvs	0x006c0031
     118:	6c20676e 	stcvs	7, cr6, [r0], #-440	; 0xfffffe48
     11c:	20676e6f 	rsbcs	r6, r7, pc, ror #28
     120:	00746e69 	rsbseq	r6, r4, r9, ror #28
     124:	78635f5f 	stmdavc	r3!, {r0, r1, r2, r3, r4, r6, r8, r9, sl, fp, ip, lr}^
     128:	75705f61 	ldrbvc	r5, [r0, #-3937]!	; 0xfffff09f
     12c:	765f6572 			; <UNDEFINED> instruction: 0x765f6572
     130:	75747269 	ldrbvc	r7, [r4, #-617]!	; 0xfffffd97
     134:	5f006c61 	svcpl	0x00006c61
     138:	6165615f 	cmnvs	r5, pc, asr r1
     13c:	755f6962 	ldrbvc	r6, [pc, #-2402]	; fffff7e2 <_bss_end+0xffff5ffe>
     140:	6e69776e 	cdpvs	7, 6, cr7, cr9, cr14, {3}
     144:	70635f64 	rsbvc	r5, r3, r4, ror #30
     148:	72705f70 	rsbsvc	r5, r0, #112, 30	; 0x1c0
     14c:	5f5f0031 	svcpl	0x005f0031
     150:	72617567 	rsbvc	r7, r1, #432013312	; 0x19c00000
     154:	682f0064 	stmdavs	pc!, {r2, r5, r6}	; <UNPREDICTABLE>
     158:	2f656d6f 	svccs	0x00656d6f
     15c:	5a2f6663 	bpl	bd9af0 <_bss_end+0xbd030c>
     160:	662f5543 	strtvs	r5, [pc], -r3, asr #10
     164:	74737269 	ldrbtvc	r7, [r3], #-617	; 0xfffffd97
     168:	6165795f 	cmnvs	r5, pc, asr r9
     16c:	69772f72 	ldmdbvs	r7!, {r1, r4, r5, r6, r8, r9, sl, fp, sp}^
     170:	7265746e 	rsbvc	r7, r5, #1845493760	; 0x6e000000
     174:	2f534f2f 	svccs	0x00534f2f
     178:	63617270 	cmnvs	r1, #112, 4
     17c:	61636974 	smcvs	13972	; 0x3694
     180:	78652f6c 	stmdavc	r5!, {r2, r3, r5, r6, r8, r9, sl, fp, sp}^
     184:	656b2f33 	strbvs	r2, [fp, #-3891]!	; 0xfffff0cd
     188:	6c656e72 	stclvs	14, cr6, [r5], #-456	; 0xfffffe38
     18c:	6372732f 	cmnvs	r2, #-1140850688	; 0xbc000000
     190:	7878632f 	ldmdavc	r8!, {r0, r1, r2, r3, r5, r8, r9, sp, lr}^
     194:	7070632e 	rsbsvc	r6, r0, lr, lsr #6
     198:	6f687300 	svcvs	0x00687300
     19c:	69207472 	stmdbvs	r0!, {r1, r4, r5, r6, sl, ip, sp, lr}
     1a0:	5300746e 	movwpl	r7, #1134	; 0x46e
     1a4:	5f314950 	svcpl	0x00314950
     1a8:	4b454550 	blmi	11516f0 <_bss_end+0x1147f0c>
     1ac:	49505300 	ldmdbmi	r0, {r8, r9, ip, lr}^
     1b0:	54535f31 	ldrbpl	r5, [r3], #-3889	; 0xfffff0cf
     1b4:	6d005441 	cfstrsvs	mvf5, [r0, #-260]	; 0xfffffefc
     1b8:	5f585541 	svcpl	0x00585541
     1bc:	00676552 	rsbeq	r6, r7, r2, asr r5
     1c0:	344e5a5f 	strbcc	r5, [lr], #-2655	; 0xfffff5a1
     1c4:	58554143 	ldmdapl	r5, {r0, r1, r6, r8, lr}^
     1c8:	65473231 	strbvs	r3, [r7, #-561]	; 0xfffffdcf
     1cc:	65525f74 	ldrbvs	r5, [r2, #-3956]	; 0xfffff08c
     1d0:	74736967 	ldrbtvc	r6, [r3], #-2407	; 0xfffff699
     1d4:	4e457265 	cdpmi	2, 4, cr7, cr5, cr5, {3}
     1d8:	6c616833 	stclvs	8, cr6, [r1], #-204	; 0xffffff34
     1dc:	58554137 	ldmdapl	r5, {r0, r1, r2, r4, r5, r8, lr}^
     1e0:	6765525f 			; <UNDEFINED> instruction: 0x6765525f
     1e4:	61760045 	cmnvs	r6, r5, asr #32
     1e8:	0065756c 	rsbeq	r7, r5, ip, ror #10
     1ec:	5f787561 	svcpl	0x00787561
     1f0:	65736162 	ldrbvs	r6, [r3, #-354]!	; 0xfffffe9e
     1f4:	414e4500 	cmpmi	lr, r0, lsl #10
     1f8:	53454c42 	movtpl	r4, #23618	; 0x5c42
     1fc:	4e5a5f00 	cdpmi	15, 5, cr5, cr10, cr0, {0}
     200:	55414334 	strbpl	r4, [r1, #-820]	; 0xfffffccc
     204:	6e453658 	mcrvs	6, 2, r3, cr5, cr8, {2}
     208:	656c6261 	strbvs	r6, [ip, #-609]!	; 0xfffffd9f
     20c:	68334e45 	ldmdavs	r3!, {r0, r2, r6, r9, sl, fp, lr}
     210:	35316c61 	ldrcc	r6, [r1, #-3169]!	; 0xfffff39f
     214:	5f585541 	svcpl	0x00585541
     218:	69726550 	ldmdbvs	r2!, {r4, r6, r8, sl, sp, lr}^
     21c:	72656870 	rsbvc	r6, r5, #112, 16	; 0x700000
     220:	45736c61 	ldrbmi	r6, [r3, #-3169]!	; 0xfffff39f
     224:	58554100 	ldmdapl	r5, {r8, lr}^
     228:	7265505f 	rsbvc	r5, r5, #95	; 0x5f
     22c:	65687069 	strbvs	r7, [r8, #-105]!	; 0xffffff97
     230:	736c6172 	cmnvc	ip, #-2147483620	; 0x8000001c
     234:	5f554d00 	svcpl	0x00554d00
     238:	5f004f49 	svcpl	0x00004f49
     23c:	43344e5a 	teqmi	r4, #1440	; 0x5a0
     240:	43585541 	cmpmi	r8, #272629760	; 0x10400000
     244:	006a4534 	rsbeq	r4, sl, r4, lsr r5
     248:	344e5a5f 	strbcc	r5, [lr], #-2655	; 0xfffff5a1
     24c:	58554143 	ldmdapl	r5, {r0, r1, r6, r8, lr}^
     250:	65533231 	ldrbvs	r3, [r3, #-561]	; 0xfffffdcf
     254:	65525f74 	ldrbvs	r5, [r2, #-3956]	; 0xfffff08c
     258:	74736967 	ldrbtvc	r6, [r3], #-2407	; 0xfffff699
     25c:	4e457265 	cdpmi	2, 4, cr7, cr5, cr5, {3}
     260:	6c616833 	stclvs	8, cr6, [r1], #-204	; 0xffffff34
     264:	58554137 	ldmdapl	r5, {r0, r1, r2, r4, r5, r8, lr}^
     268:	6765525f 			; <UNDEFINED> instruction: 0x6765525f
     26c:	53006a45 	movwpl	r6, #2629	; 0xa45
     270:	5f304950 	svcpl	0x00304950
     274:	5f004f49 	svcpl	0x00004f49
     278:	424f4c47 	submi	r4, pc, #18176	; 0x4700
     27c:	5f5f4c41 	svcpl	0x005f4c41
     280:	5f627573 	svcpl	0x00627573
     284:	41735f49 	cmnmi	r3, r9, asr #30
     288:	53005855 	movwpl	r5, #2133	; 0x855
     28c:	5f304950 	svcpl	0x00304950
     290:	4c544e43 	mrrcmi	14, 4, r4, r4, cr3	; <UNPREDICTABLE>
     294:	50530030 	subspl	r0, r3, r0, lsr r0
     298:	435f3049 	cmpmi	pc, #73	; 0x49
     29c:	314c544e 	cmpcc	ip, lr, asr #8
     2a0:	72655000 	rsbvc	r5, r5, #0
     2a4:	65687069 	strbvs	r7, [r8, #-105]!	; 0xffffff97
     2a8:	5f6c6172 	svcpl	0x006c6172
     2ac:	65736142 	ldrbvs	r6, [r3, #-322]!	; 0xfffffebe
     2b0:	695f5f00 	ldmdbvs	pc, {r8, r9, sl, fp, ip, lr}^	; <UNPREDICTABLE>
     2b4:	6974696e 	ldmdbvs	r4!, {r1, r2, r3, r5, r6, r8, fp, sp, lr}^
     2b8:	7a696c61 	bvc	1a5b444 <_bss_end+0x1a51c60>
     2bc:	00705f65 	rsbseq	r5, r0, r5, ror #30
     2c0:	31495053 	qdaddcc	r5, r3, r9
     2c4:	544e435f 	strbpl	r4, [lr], #-863	; 0xfffffca1
     2c8:	5300304c 	movwpl	r3, #76	; 0x4c
     2cc:	5f314950 	svcpl	0x00314950
     2d0:	4c544e43 	mrrcmi	14, 4, r4, r4, cr3	; <UNPREDICTABLE>
     2d4:	6e450031 	mcrvs	0, 2, r0, cr5, cr1, {1}
     2d8:	656c6261 	strbvs	r6, [ip, #-609]!	; 0xfffffd9f
     2dc:	736e7500 	cmnvc	lr, #0, 10
     2e0:	656e6769 	strbvs	r6, [lr, #-1897]!	; 0xfffff897
     2e4:	68632064 	stmdavs	r3!, {r2, r5, r6, sp}^
     2e8:	2f007261 	svccs	0x00007261
     2ec:	656d6f68 	strbvs	r6, [sp, #-3944]!	; 0xfffff098
     2f0:	2f66632f 	svccs	0x0066632f
     2f4:	2f55435a 	svccs	0x0055435a
     2f8:	73726966 	cmnvc	r2, #1671168	; 0x198000
     2fc:	65795f74 	ldrbvs	r5, [r9, #-3956]!	; 0xfffff08c
     300:	772f7261 	strvc	r7, [pc, -r1, ror #4]!
     304:	65746e69 	ldrbvs	r6, [r4, #-3689]!	; 0xfffff197
     308:	534f2f72 	movtpl	r2, #65394	; 0xff72
     30c:	6172702f 	cmnvs	r2, pc, lsr #32
     310:	63697463 	cmnvs	r9, #1660944384	; 0x63000000
     314:	652f6c61 	strvs	r6, [pc, #-3169]!	; fffff6bb <_bss_end+0xffff5ed7>
     318:	6b2f3378 	blvs	bcd100 <_bss_end+0xbc391c>
     31c:	656e7265 	strbvs	r7, [lr, #-613]!	; 0xfffffd9b
     320:	72732f6c 	rsbsvc	r2, r3, #108, 30	; 0x1b0
     324:	72642f63 	rsbvc	r2, r4, #396	; 0x18c
     328:	72657669 	rsbvc	r7, r5, #110100480	; 0x6900000
     32c:	63622f73 	cmnvs	r2, #460	; 0x1cc
     330:	75615f6d 	strbvc	r5, [r1, #-3949]!	; 0xfffff093
     334:	70632e78 	rsbvc	r2, r3, r8, ror lr
     338:	554d0070 	strbpl	r0, [sp, #-112]	; 0xffffff90
     33c:	5245495f 	subpl	r4, r5, #1556480	; 0x17c000
     340:	5f554d00 	svcpl	0x00554d00
     344:	0052434d 	subseq	r4, r2, sp, asr #6
     348:	4f495047 	svcmi	0x00495047
     34c:	7361425f 	cmnvc	r1, #-268435451	; 0xf0000005
     350:	5a5f0065 	bpl	17c04ec <_bss_end+0x17b6d08>
     354:	4143344e 	cmpmi	r3, lr, asr #8
     358:	32435855 	subcc	r5, r3, #5570560	; 0x550000
     35c:	75006a45 	strvc	r6, [r0, #-2629]	; 0xfffff5bb
     360:	33746e69 	cmncc	r4, #1680	; 0x690
     364:	00745f32 	rsbseq	r5, r4, r2, lsr pc
     368:	61736944 	cmnvs	r3, r4, asr #18
     36c:	00656c62 	rsbeq	r6, r5, r2, ror #24
     370:	5f746547 	svcpl	0x00746547
     374:	69676552 	stmdbvs	r7!, {r1, r4, r6, r8, sl, sp, lr}^
     378:	72657473 	rsbvc	r7, r5, #1929379840	; 0x73000000
     37c:	5f554d00 	svcpl	0x00554d00
     380:	00524949 	subseq	r4, r2, r9, asr #18
     384:	435f554d 	cmpmi	pc, #322961408	; 0x13400000
     388:	004c544e 	subeq	r5, ip, lr, asr #8
     38c:	31495053 	qdaddcc	r5, r3, r9
     390:	49505300 	ldmdbmi	r0, {r8, r9, ip, lr}^
     394:	68730032 	ldmdavs	r3!, {r1, r4, r5}^
     398:	2074726f 	rsbscs	r7, r4, pc, ror #4
     39c:	69736e75 	ldmdbvs	r3!, {r0, r2, r4, r5, r6, r9, sl, fp, sp, lr}^
     3a0:	64656e67 	strbtvs	r6, [r5], #-3687	; 0xfffff199
     3a4:	746e6920 	strbtvc	r6, [lr], #-2336	; 0xfffff6e0
     3a8:	49505300 	ldmdbmi	r0, {r8, r9, ip, lr}^
     3ac:	4f495f31 	svcmi	0x00495f31
     3b0:	5f554d00 	svcpl	0x00554d00
     3b4:	0052434c 	subseq	r4, r2, ip, asr #6
     3b8:	30495053 	subcc	r5, r9, r3, asr r0
     3bc:	4545505f 	strbmi	r5, [r5, #-95]	; 0xffffffa1
     3c0:	554d004b 	strbpl	r0, [sp, #-75]	; 0xffffffb5
     3c4:	5541425f 	strbpl	r4, [r1, #-607]	; 0xfffffda1
     3c8:	50530044 	subspl	r0, r3, r4, asr #32
     3cc:	535f3049 	cmppl	pc, #73	; 0x49
     3d0:	00544154 	subseq	r4, r4, r4, asr r1
     3d4:	4f495047 	svcmi	0x00495047
     3d8:	6e69505f 	mcrvs	0, 3, r5, cr9, cr15, {2}
     3dc:	756f435f 	strbvc	r4, [pc, #-863]!	; 85 <shift+0x85>
     3e0:	5f00746e 	svcpl	0x0000746e
     3e4:	6174735f 	cmnvs	r4, pc, asr r3
     3e8:	5f636974 	svcpl	0x00636974
     3ec:	74696e69 	strbtvc	r6, [r9], #-3689	; 0xfffff197
     3f0:	696c6169 	stmdbvs	ip!, {r0, r3, r5, r6, r8, sp, lr}^
     3f4:	6974617a 	ldmdbvs	r4!, {r1, r3, r4, r5, r6, r8, sp, lr}^
     3f8:	615f6e6f 	cmpvs	pc, pc, ror #28
     3fc:	645f646e 	ldrbvs	r6, [pc], #-1134	; 404 <shift+0x404>
     400:	72747365 	rsbsvc	r7, r4, #-1811939327	; 0x94000001
     404:	69746375 	ldmdbvs	r4!, {r0, r2, r4, r5, r6, r8, r9, sp, lr}^
     408:	305f6e6f 	subscc	r6, pc, pc, ror #28
     40c:	705f5f00 	subsvc	r5, pc, r0, lsl #30
     410:	726f6972 	rsbvc	r6, pc, #1867776	; 0x1c8000
     414:	00797469 	rsbseq	r7, r9, r9, ror #8
     418:	73696874 	cmnvc	r9, #116, 16	; 0x740000
     41c:	74655300 	strbtvc	r5, [r5], #-768	; 0xfffffd00
     420:	6765525f 			; <UNDEFINED> instruction: 0x6765525f
     424:	65747369 	ldrbvs	r7, [r4, #-873]!	; 0xfffffc97
     428:	554d0072 	strbpl	r0, [sp, #-114]	; 0xffffff8e
     42c:	52534d5f 	subspl	r4, r3, #6080	; 0x17c0
     430:	58554100 	ldmdapl	r5, {r8, lr}^
     434:	7361425f 	cmnvc	r1, #-268435451	; 0xf0000005
     438:	554d0065 	strbpl	r0, [sp, #-101]	; 0xffffff9b
     43c:	4154535f 	cmpmi	r4, pc, asr r3
     440:	75610054 	strbvc	r0, [r1, #-84]!	; 0xffffffac
     444:	65705f78 	ldrbvs	r5, [r0, #-3960]!	; 0xfffff088
     448:	68706972 	ldmdavs	r0!, {r1, r4, r5, r6, r8, fp, sp, lr}^
     44c:	6c617265 	sfmvs	f7, 2, [r1], #-404	; 0xfffffe6c
     450:	6e694d00 	cdpvs	13, 6, cr4, cr9, cr0, {0}
     454:	52415569 	subpl	r5, r1, #440401920	; 0x1a400000
     458:	554d0054 	strbpl	r0, [sp, #-84]	; 0xffffffac
     45c:	52534c5f 	subspl	r4, r3, #24320	; 0x5f00
     460:	67657200 	strbvs	r7, [r5, -r0, lsl #4]!
     464:	7864695f 	stmdavc	r4!, {r0, r1, r2, r3, r4, r6, r8, fp, sp, lr}^
     468:	4e5a5f00 	cdpmi	15, 5, cr5, cr10, cr0, {0}
     46c:	55414334 	strbpl	r4, [r1, #-820]	; 0xfffffccc
     470:	69443758 	stmdbvs	r4, {r3, r4, r6, r8, r9, sl, ip, sp}^
     474:	6c626173 	stfvse	f6, [r2], #-460	; 0xfffffe34
     478:	334e4565 	movtcc	r4, #58725	; 0xe565
     47c:	316c6168 	cmncc	ip, r8, ror #2
     480:	58554135 	ldmdapl	r5, {r0, r2, r4, r5, r8, lr}^
     484:	7265505f 	rsbvc	r5, r5, #95	; 0x5f
     488:	65687069 	strbvs	r7, [r8, #-105]!	; 0xffffff97
     48c:	736c6172 	cmnvc	ip, #-2147483620	; 0x8000001c
     490:	554d0045 	strbpl	r0, [sp, #-69]	; 0xffffffbb
     494:	5243535f 	subpl	r5, r3, #2080374785	; 0x7c000001
     498:	48435441 	stmdami	r3, {r0, r6, sl, ip, lr}^
     49c:	4e5a5f00 	cdpmi	15, 5, cr5, cr10, cr0, {0}
     4a0:	4333314b 	teqmi	r3, #-1073741806	; 0xc0000012
     4a4:	4f495047 	svcmi	0x00495047
     4a8:	6e61485f 	mcrvs	8, 3, r4, cr1, cr15, {2}
     4ac:	72656c64 	rsbvc	r6, r5, #100, 24	; 0x6400
     4b0:	65473831 	strbvs	r3, [r7, #-2097]	; 0xfffff7cf
     4b4:	50475f74 	subpl	r5, r7, r4, ror pc
     4b8:	5f56454c 	svcpl	0x0056454c
     4bc:	61636f4c 	cmnvs	r3, ip, asr #30
     4c0:	6e6f6974 			; <UNDEFINED> instruction: 0x6e6f6974
     4c4:	6a526a45 	bvs	149ade0 <_bss_end+0x14915fc>
     4c8:	005f3053 	subseq	r3, pc, r3, asr r0	; <UNPREDICTABLE>
     4cc:	45535047 	ldrbmi	r5, [r3, #-71]	; 0xffffffb9
     4d0:	47003054 	smlsdmi	r0, r4, r0, r3
     4d4:	54455350 	strbpl	r5, [r5], #-848	; 0xfffffcb0
     4d8:	50470031 	subpl	r0, r7, r1, lsr r0
     4dc:	4c455346 	mcrrmi	3, 4, r5, r5, cr6
     4e0:	50470030 	subpl	r0, r7, r0, lsr r0
     4e4:	4c455346 	mcrrmi	3, 4, r5, r5, cr6
     4e8:	50470031 	subpl	r0, r7, r1, lsr r0
     4ec:	4c455346 	mcrrmi	3, 4, r5, r5, cr6
     4f0:	50470032 	subpl	r0, r7, r2, lsr r0
     4f4:	4c455346 	mcrrmi	3, 4, r5, r5, cr6
     4f8:	50470033 	subpl	r0, r7, r3, lsr r0
     4fc:	4c455346 	mcrrmi	3, 4, r5, r5, cr6
     500:	50470034 	subpl	r0, r7, r4, lsr r0
     504:	4c455346 	mcrrmi	3, 4, r5, r5, cr6
     508:	50470035 	subpl	r0, r7, r5, lsr r0
     50c:	314e4546 	cmpcc	lr, r6, asr #10
     510:	706e4900 	rsbvc	r4, lr, r0, lsl #18
     514:	47007475 	smlsdxmi	r0, r5, r4, r7
     518:	44555050 	ldrbmi	r5, [r5], #-80	; 0xffffffb0
     51c:	304b4c43 	subcc	r4, fp, r3, asr #24
     520:	50504700 	subspl	r4, r0, r0, lsl #14
     524:	4c434455 	cfstrdmi	mvd4, [r3], {85}	; 0x55
     528:	4700314b 	strmi	r3, [r0, -fp, asr #2]
     52c:	4e455250 	mcrmi	2, 2, r5, cr5, cr0, {2}
     530:	50470030 	subpl	r0, r7, r0, lsr r0
     534:	314e4552 	cmpcc	lr, r2, asr r5
     538:	4e5a5f00 	cdpmi	15, 5, cr5, cr10, cr0, {0}
     53c:	47433331 	smlaldxmi	r3, r3, r1, r3	; <UNPREDICTABLE>
     540:	5f4f4950 	svcpl	0x004f4950
     544:	646e6148 	strbtvs	r6, [lr], #-328	; 0xfffffeb8
     548:	3172656c 	cmncc	r2, ip, ror #10
     54c:	74655330 	strbtvc	r5, [r5], #-816	; 0xfffffcd0
     550:	74754f5f 	ldrbtvc	r4, [r5], #-3935	; 0xfffff0a1
     554:	45747570 	ldrbmi	r7, [r4, #-1392]!	; 0xfffffa90
     558:	5f00626a 	svcpl	0x0000626a
     55c:	314b4e5a 	cmpcc	fp, sl, asr lr
     560:	50474333 	subpl	r4, r7, r3, lsr r3
     564:	485f4f49 	ldmdami	pc, {r0, r3, r6, r8, r9, sl, fp, lr}^	; <UNPREDICTABLE>
     568:	6c646e61 	stclvs	14, cr6, [r4], #-388	; 0xfffffe7c
     56c:	39317265 	ldmdbcc	r1!, {r0, r2, r5, r6, r9, ip, sp, lr}
     570:	5f746547 	svcpl	0x00746547
     574:	53465047 	movtpl	r5, #24647	; 0x6047
     578:	4c5f4c45 	mrrcmi	12, 4, r4, pc, cr5	; <UNPREDICTABLE>
     57c:	7461636f 	strbtvc	r6, [r1], #-879	; 0xfffffc91
     580:	456e6f69 	strbmi	r6, [lr, #-3945]!	; 0xfffff097
     584:	536a526a 	cmnpl	sl, #-1610612730	; 0xa0000006
     588:	6d005f30 	stcvs	15, cr5, [r0, #-192]	; 0xffffff40
     58c:	4f495047 	svcmi	0x00495047
     590:	4e5a5f00 	cdpmi	15, 5, cr5, cr10, cr0, {0}
     594:	47433331 	smlaldxmi	r3, r3, r1, r3	; <UNPREDICTABLE>
     598:	5f4f4950 	svcpl	0x004f4950
     59c:	646e6148 	strbtvs	r6, [lr], #-328	; 0xfffffeb8
     5a0:	4372656c 	cmnmi	r2, #108, 10	; 0x1b000000
     5a4:	006a4534 	rsbeq	r4, sl, r4, lsr r5
     5a8:	746e6975 	strbtvc	r6, [lr], #-2421	; 0xfffff68b
     5ac:	00745f38 	rsbseq	r5, r4, r8, lsr pc
     5b0:	44455047 	strbmi	r5, [r5], #-71	; 0xffffffb9
     5b4:	47003053 	smlsdmi	r0, r3, r0, r3
     5b8:	53444550 	movtpl	r4, #17744	; 0x4550
     5bc:	6f620031 	svcvs	0x00620031
     5c0:	55006c6f 	strpl	r6, [r0, #-3183]	; 0xfffff391
     5c4:	6570736e 	ldrbvs	r7, [r0, #-878]!	; 0xfffffc92
     5c8:	69666963 	stmdbvs	r6!, {r0, r1, r5, r6, r8, fp, sp, lr}^
     5cc:	47006465 	strmi	r6, [r0, -r5, ror #8]
     5d0:	4e454c50 	mcrmi	12, 2, r4, cr5, cr0, {2}
     5d4:	75660030 	strbvc	r0, [r6, #-48]!	; 0xffffffd0
     5d8:	4700636e 	strmi	r6, [r0, -lr, ror #6]
     5dc:	475f7465 	ldrbmi	r7, [pc, -r5, ror #8]
     5e0:	5f4f4950 	svcpl	0x004f4950
     5e4:	636e7546 	cmnvs	lr, #293601280	; 0x11800000
     5e8:	6e6f6974 			; <UNDEFINED> instruction: 0x6e6f6974
     5ec:	50474300 	subpl	r4, r7, r0, lsl #6
     5f0:	485f4f49 	ldmdami	pc, {r0, r3, r6, r8, r9, sl, fp, lr}^	; <UNPREDICTABLE>
     5f4:	6c646e61 	stclvs	14, cr6, [r4], #-388	; 0xfffffe7c
     5f8:	47007265 	strmi	r7, [r0, -r5, ror #4]
     5fc:	475f7465 	ldrbmi	r7, [pc, -r5, ror #8]
     600:	54455350 	strbpl	r5, [r5], #-848	; 0xfffffcb0
     604:	636f4c5f 	cmnvs	pc, #24320	; 0x5f00
     608:	6f697461 	svcvs	0x00697461
     60c:	5047006e 	subpl	r0, r7, lr, rrx
     610:	00445550 	subeq	r5, r4, r0, asr r5
     614:	5f746547 	svcpl	0x00746547
     618:	454c5047 	strbmi	r5, [ip, #-71]	; 0xffffffb9
     61c:	6f4c5f56 	svcvs	0x004c5f56
     620:	69746163 	ldmdbvs	r4!, {r0, r1, r5, r6, r8, sp, lr}^
     624:	5f006e6f 	svcpl	0x00006e6f
     628:	314b4e5a 	cmpcc	fp, sl, asr lr
     62c:	50474333 	subpl	r4, r7, r3, lsr r3
     630:	485f4f49 	ldmdami	pc, {r0, r3, r6, r8, r9, sl, fp, lr}^	; <UNPREDICTABLE>
     634:	6c646e61 	stclvs	14, cr6, [r4], #-388	; 0xfffffe7c
     638:	37317265 	ldrcc	r7, [r1, -r5, ror #4]!
     63c:	5f746547 	svcpl	0x00746547
     640:	4f495047 	svcmi	0x00495047
     644:	6e75465f 	mrcvs	6, 3, r4, cr5, cr15, {2}
     648:	6f697463 	svcvs	0x00697463
     64c:	006a456e 	rsbeq	r4, sl, lr, ror #10
     650:	314e5a5f 	cmpcc	lr, pc, asr sl
     654:	50474333 	subpl	r4, r7, r3, lsr r3
     658:	485f4f49 	ldmdami	pc, {r0, r3, r6, r8, r9, sl, fp, lr}^	; <UNPREDICTABLE>
     65c:	6c646e61 	stclvs	14, cr6, [r4], #-388	; 0xfffffe7c
     660:	32437265 	subcc	r7, r3, #1342177286	; 0x50000006
     664:	47006a45 	strmi	r6, [r0, -r5, asr #20]
     668:	45464150 	strbmi	r4, [r6, #-336]	; 0xfffffeb0
     66c:	4700304e 	strmi	r3, [r0, -lr, asr #32]
     670:	45464150 	strbmi	r4, [r6, #-336]	; 0xfffffeb0
     674:	2f00314e 	svccs	0x0000314e
     678:	656d6f68 	strbvs	r6, [sp, #-3944]!	; 0xfffff098
     67c:	2f66632f 	svccs	0x0066632f
     680:	2f55435a 	svccs	0x0055435a
     684:	73726966 	cmnvc	r2, #1671168	; 0x198000
     688:	65795f74 	ldrbvs	r5, [r9, #-3956]!	; 0xfffff08c
     68c:	772f7261 	strvc	r7, [pc, -r1, ror #4]!
     690:	65746e69 	ldrbvs	r6, [r4, #-3689]!	; 0xfffff197
     694:	534f2f72 	movtpl	r2, #65394	; 0xff72
     698:	6172702f 	cmnvs	r2, pc, lsr #32
     69c:	63697463 	cmnvs	r9, #1660944384	; 0x63000000
     6a0:	652f6c61 	strvs	r6, [pc, #-3169]!	; fffffa47 <_bss_end+0xffff6263>
     6a4:	6b2f3378 	blvs	bcd48c <_bss_end+0xbc3ca8>
     6a8:	656e7265 	strbvs	r7, [lr, #-613]!	; 0xfffffd9b
     6ac:	72732f6c 	rsbsvc	r2, r3, #108, 30	; 0x1b0
     6b0:	72642f63 	rsbvc	r2, r4, #396	; 0x18c
     6b4:	72657669 	rsbvc	r7, r5, #110100480	; 0x6900000
     6b8:	70672f73 	rsbvc	r2, r7, r3, ror pc
     6bc:	632e6f69 			; <UNDEFINED> instruction: 0x632e6f69
     6c0:	5f007070 	svcpl	0x00007070
     6c4:	314b4e5a 	cmpcc	fp, sl, asr lr
     6c8:	50474333 	subpl	r4, r7, r3, lsr r3
     6cc:	485f4f49 	ldmdami	pc, {r0, r3, r6, r8, r9, sl, fp, lr}^	; <UNPREDICTABLE>
     6d0:	6c646e61 	stclvs	14, cr6, [r4], #-388	; 0xfffffe7c
     6d4:	38317265 	ldmdacc	r1!, {r0, r2, r5, r6, r9, ip, sp, lr}
     6d8:	5f746547 	svcpl	0x00746547
     6dc:	4c435047 	mcrrmi	0, 4, r5, r3, cr7
     6e0:	6f4c5f52 	svcvs	0x004c5f52
     6e4:	69746163 	ldmdbvs	r4!, {r0, r1, r5, r6, r8, sp, lr}^
     6e8:	6a456e6f 	bvs	115c0ac <_bss_end+0x11528c8>
     6ec:	30536a52 	subscc	r6, r3, r2, asr sl
     6f0:	475f005f 			; <UNDEFINED> instruction: 0x475f005f
     6f4:	41424f4c 	cmpmi	r2, ip, asr #30
     6f8:	735f5f4c 	cmpvc	pc, #76, 30	; 0x130
     6fc:	495f6275 	ldmdbmi	pc, {r0, r2, r4, r5, r6, r9, sp, lr}^	; <UNPREDICTABLE>
     700:	5047735f 	subpl	r7, r7, pc, asr r3
     704:	47004f49 	strmi	r4, [r0, -r9, asr #30]
     708:	524c4350 	subpl	r4, ip, #80, 6	; 0x40000001
     70c:	50470031 	subpl	r0, r7, r1, lsr r0
     710:	4e455241 	cdpmi	2, 4, cr5, cr5, cr1, {2}
     714:	50470030 	subpl	r0, r7, r0, lsr r0
     718:	4e455241 	cdpmi	2, 4, cr5, cr5, cr1, {2}
     71c:	50470031 	subpl	r0, r7, r1, lsr r0
     720:	304e4548 	subcc	r4, lr, r8, asr #10
     724:	48504700 	ldmdami	r0, {r8, r9, sl, lr}^
     728:	00314e45 	eorseq	r4, r1, r5, asr #28
     72c:	6f697067 	svcvs	0x00697067
     730:	7361625f 	cmnvc	r1, #-268435451	; 0xf0000005
     734:	64615f65 	strbtvs	r5, [r1], #-3941	; 0xfffff09b
     738:	47007264 	strmi	r7, [r0, -r4, ror #4]
     73c:	4e454c50 	mcrmi	12, 2, r4, cr5, cr0, {2}
     740:	65470031 	strbvs	r0, [r7, #-49]	; 0xffffffcf
     744:	50475f74 	subpl	r5, r7, r4, ror pc
     748:	4c455346 	mcrrmi	3, 4, r5, r5, cr6
     74c:	636f4c5f 	cmnvs	pc, #24320	; 0x5f00
     750:	6f697461 	svcvs	0x00697461
     754:	5047006e 	subpl	r0, r7, lr, rrx
     758:	525f4f49 	subspl	r4, pc, #292	; 0x124
     75c:	5f006765 	svcpl	0x00006765
     760:	33314e5a 	teqcc	r1, #1440	; 0x5a0
     764:	49504743 	ldmdbmi	r0, {r0, r1, r6, r8, r9, sl, lr}^
     768:	61485f4f 	cmpvs	r8, pc, asr #30
     76c:	656c646e 	strbvs	r6, [ip, #-1134]!	; 0xfffffb92
     770:	53373172 	teqpl	r7, #-2147483620	; 0x8000001c
     774:	475f7465 	ldrbmi	r7, [pc, -r5, ror #8]
     778:	5f4f4950 	svcpl	0x004f4950
     77c:	636e7546 	cmnvs	lr, #293601280	; 0x11800000
     780:	6e6f6974 			; <UNDEFINED> instruction: 0x6e6f6974
     784:	34316a45 	ldrtcc	r6, [r1], #-2629	; 0xfffff5bb
     788:	4950474e 	ldmdbmi	r0, {r1, r2, r3, r6, r8, r9, sl, lr}^
     78c:	75465f4f 	strbvc	r5, [r6, #-3919]	; 0xfffff0b1
     790:	6974636e 	ldmdbvs	r4!, {r1, r2, r3, r5, r6, r8, r9, sp, lr}^
     794:	47006e6f 	strmi	r6, [r0, -pc, ror #28]
     798:	56454c50 			; <UNDEFINED> instruction: 0x56454c50
     79c:	50470030 	subpl	r0, r7, r0, lsr r0
     7a0:	3156454c 	cmpcc	r6, ip, asr #10
     7a4:	74655300 	strbtvc	r5, [r5], #-768	; 0xfffffd00
     7a8:	4950475f 	ldmdbmi	r0, {r0, r1, r2, r3, r4, r6, r8, r9, sl, lr}^
     7ac:	75465f4f 	strbvc	r5, [r6, #-3919]	; 0xfffff0b1
     7b0:	6974636e 	ldmdbvs	r4!, {r1, r2, r3, r5, r6, r8, r9, sp, lr}^
     7b4:	62006e6f 	andvs	r6, r0, #1776	; 0x6f0
     7b8:	695f7469 	ldmdbvs	pc, {r0, r3, r5, r6, sl, ip, sp, lr}^	; <UNPREDICTABLE>
     7bc:	5f007864 	svcpl	0x00007864
     7c0:	314b4e5a 	cmpcc	fp, sl, asr lr
     7c4:	50474333 	subpl	r4, r7, r3, lsr r3
     7c8:	485f4f49 	ldmdami	pc, {r0, r3, r6, r8, r9, sl, fp, lr}^	; <UNPREDICTABLE>
     7cc:	6c646e61 	stclvs	14, cr6, [r4], #-388	; 0xfffffe7c
     7d0:	38317265 	ldmdacc	r1!, {r0, r2, r5, r6, r9, ip, sp, lr}
     7d4:	5f746547 	svcpl	0x00746547
     7d8:	45535047 	ldrbmi	r5, [r3, #-71]	; 0xffffffb9
     7dc:	6f4c5f54 	svcvs	0x004c5f54
     7e0:	69746163 	ldmdbvs	r4!, {r0, r1, r5, r6, r8, sp, lr}^
     7e4:	6a456e6f 	bvs	115c1a8 <_bss_end+0x11529c4>
     7e8:	30536a52 	subscc	r6, r3, r2, asr sl
     7ec:	6547005f 	strbvs	r0, [r7, #-95]	; 0xffffffa1
     7f0:	50475f74 	subpl	r5, r7, r4, ror pc
     7f4:	5f524c43 	svcpl	0x00524c43
     7f8:	61636f4c 	cmnvs	r3, ip, asr #30
     7fc:	6e6f6974 			; <UNDEFINED> instruction: 0x6e6f6974
     800:	46504700 	ldrbmi	r4, [r0], -r0, lsl #14
     804:	00304e45 	eorseq	r4, r0, r5, asr #28
     808:	5f746553 	svcpl	0x00746553
     80c:	7074754f 	rsbsvc	r7, r4, pc, asr #10
     810:	41007475 	tstmi	r0, r5, ror r4
     814:	305f746c 	subscc	r7, pc, ip, ror #8
     818:	746c4100 	strbtvc	r4, [ip], #-256	; 0xffffff00
     81c:	4100315f 	tstmi	r0, pc, asr r1
     820:	325f746c 	subscc	r7, pc, #108, 8	; 0x6c000000
     824:	746c4100 	strbtvc	r4, [ip], #-256	; 0xffffff00
     828:	4100335f 	tstmi	r0, pc, asr r3
     82c:	345f746c 	ldrbcc	r7, [pc], #-1132	; 834 <shift+0x834>
     830:	746c4100 	strbtvc	r4, [ip], #-256	; 0xffffff00
     834:	4700355f 	smlsdmi	r0, pc, r5, r3	; <UNPREDICTABLE>
     838:	524c4350 	subpl	r4, ip, #80, 6	; 0x40000001
     83c:	5a5f0030 	bpl	17c0904 <_bss_end+0x17b7120>
     840:	5543354e 	strbpl	r3, [r3, #-1358]	; 0xfffffab2
     844:	31545241 	cmpcc	r4, r1, asr #4
     848:	61655233 	cmnvs	r5, r3, lsr r2
     84c:	6c425f64 	mcrrvs	15, 6, r5, r2, cr4
     850:	696b636f 	stmdbvs	fp!, {r0, r1, r2, r3, r5, r6, r8, r9, sp, lr}^
     854:	7645676e 	strbvc	r6, [r5], -lr, ror #14
     858:	5f524200 	svcpl	0x00524200
     85c:	32353131 	eorscc	r3, r5, #1073741836	; 0x4000000c
     860:	5f003030 	svcpl	0x00003030
     864:	43354e5a 	teqmi	r5, #1440	; 0x5a0
     868:	54524155 	ldrbpl	r4, [r2], #-341	; 0xfffffeab
     86c:	61745335 	cmnvs	r4, r5, lsr r3
     870:	76457472 			; <UNDEFINED> instruction: 0x76457472
     874:	5f524200 	svcpl	0x00524200
     878:	30343833 	eorscc	r3, r4, r3, lsr r8
     87c:	65520030 	ldrbvs	r0, [r2, #-48]	; 0xffffffd0
     880:	5f006461 	svcpl	0x00006461
     884:	43354e5a 	teqmi	r5, #1440	; 0x5a0
     888:	54524155 	ldrbpl	r4, [r2], #-341	; 0xfffffeab
     88c:	52453243 	subpl	r3, r5, #805306372	; 0x30000004
     890:	55414334 	strbpl	r4, [r1, #-820]	; 0xfffffccc
     894:	52420058 	subpl	r0, r2, #88	; 0x58
     898:	3036395f 	eorscc	r3, r6, pc, asr r9
     89c:	74530030 	ldrbvc	r0, [r3], #-48	; 0xffffffd0
     8a0:	4300706f 	movwmi	r7, #111	; 0x6f
     8a4:	54524155 	ldrbpl	r4, [r2], #-341	; 0xfffffeab
     8a8:	5f524200 	svcpl	0x00524200
     8ac:	30363735 	eorscc	r3, r6, r5, lsr r7
     8b0:	6c430030 	mcrrvs	0, 3, r0, r3, cr0
     8b4:	5f6b636f 	svcpl	0x006b636f
     8b8:	65746152 	ldrbvs	r6, [r4, #-338]!	; 0xfffffeae
     8bc:	69725700 	ldmdbvs	r2!, {r8, r9, sl, ip, lr}^
     8c0:	2f006574 	svccs	0x00006574
     8c4:	656d6f68 	strbvs	r6, [sp, #-3944]!	; 0xfffff098
     8c8:	2f66632f 	svccs	0x0066632f
     8cc:	2f55435a 	svccs	0x0055435a
     8d0:	73726966 	cmnvc	r2, #1671168	; 0x198000
     8d4:	65795f74 	ldrbvs	r5, [r9, #-3956]!	; 0xfffff08c
     8d8:	772f7261 	strvc	r7, [pc, -r1, ror #4]!
     8dc:	65746e69 	ldrbvs	r6, [r4, #-3689]!	; 0xfffff197
     8e0:	534f2f72 	movtpl	r2, #65394	; 0xff72
     8e4:	6172702f 	cmnvs	r2, pc, lsr #32
     8e8:	63697463 	cmnvs	r9, #1660944384	; 0x63000000
     8ec:	652f6c61 	strvs	r6, [pc, #-3169]!	; fffffc93 <_bss_end+0xffff64af>
     8f0:	6b2f3378 	blvs	bcd6d8 <_bss_end+0xbc3ef4>
     8f4:	656e7265 	strbvs	r7, [lr, #-613]!	; 0xfffffd9b
     8f8:	72732f6c 	rsbsvc	r2, r3, #108, 30	; 0x1b0
     8fc:	72642f63 	rsbvc	r2, r4, #396	; 0x18c
     900:	72657669 	rsbvc	r7, r5, #110100480	; 0x6900000
     904:	61752f73 	cmnvs	r5, r3, ror pc
     908:	632e7472 			; <UNDEFINED> instruction: 0x632e7472
     90c:	5f007070 	svcpl	0x00007070
     910:	43354e5a 	teqmi	r5, #1440	; 0x5a0
     914:	54524155 	ldrbpl	r4, [r2], #-341	; 0xfffffeab
     918:	61655234 	cmnvs	r5, r4, lsr r2
     91c:	00764564 	rsbseq	r4, r6, r4, ror #10
     920:	325f5242 	subscc	r5, pc, #536870916	; 0x20000004
     924:	00303034 	eorseq	r3, r0, r4, lsr r0
     928:	4f4c475f 	svcmi	0x004c475f
     92c:	5f4c4142 	svcpl	0x004c4142
     930:	6275735f 	rsbsvs	r7, r5, #2080374785	; 0x7c000001
     934:	735f495f 	cmpvc	pc, #1556480	; 0x17c000
     938:	54524155 	ldrbpl	r4, [r2], #-341	; 0xfffffeab
     93c:	5a5f0030 	bpl	17c0a04 <_bss_end+0x17b7220>
     940:	5543354e 	strbpl	r3, [r3, #-1358]	; 0xfffffab2
     944:	34545241 	ldrbcc	r5, [r4], #-577	; 0xfffffdbf
     948:	706f7453 	rsbvc	r7, pc, r3, asr r4	; <UNPREDICTABLE>
     94c:	5f007645 	svcpl	0x00007645
     950:	43354e5a 	teqmi	r5, #1440	; 0x5a0
     954:	54524155 	ldrbpl	r4, [r2], #-341	; 0xfffffeab
     958:	69725735 	ldmdbvs	r2!, {r0, r2, r4, r5, r8, r9, sl, ip, lr}^
     95c:	63456574 	movtvs	r6, #21876	; 0x5574
     960:	5f524200 	svcpl	0x00524200
     964:	30303231 	eorscc	r3, r0, r1, lsr r2
     968:	61684300 	cmnvs	r8, r0, lsl #6
     96c:	00385f72 	eorseq	r5, r8, r2, ror pc
     970:	5855416d 	ldmdapl	r5, {r0, r2, r3, r5, r6, r8, lr}^
     974:	61684300 	cmnvs	r8, r0, lsl #6
     978:	00375f72 	eorseq	r5, r7, r2, ror pc
     97c:	354e5a5f 	strbcc	r5, [lr, #-2655]	; 0xfffff5a1
     980:	52415543 	subpl	r5, r1, #281018368	; 0x10c00000
     984:	45344354 	ldrmi	r4, [r4, #-852]!	; 0xfffffcac
     988:	41433452 	cmpmi	r3, r2, asr r4
     98c:	5f005855 	svcpl	0x00005855
     990:	43354e5a 	teqmi	r5, #1440	; 0x5a0
     994:	54524155 	ldrbpl	r4, [r2], #-341	; 0xfffffeab
     998:	65533531 	ldrbvs	r3, [r3, #-1329]	; 0xfffffacf
     99c:	68435f74 	stmdavs	r3, {r2, r4, r5, r6, r8, r9, sl, fp, ip, lr}^
     9a0:	4c5f7261 	lfmmi	f7, 2, [pc], {97}	; 0x61
     9a4:	74676e65 	strbtvc	r6, [r7], #-3685	; 0xfffff19b
     9a8:	37314568 	ldrcc	r4, [r1, -r8, ror #10]!
     9ac:	5241554e 	subpl	r5, r1, #327155712	; 0x13800000
     9b0:	68435f54 	stmdavs	r3, {r2, r4, r6, r8, r9, sl, fp, ip, lr}^
     9b4:	4c5f7261 	lfmmi	f7, 2, [pc], {97}	; 0x61
     9b8:	74676e65 	strbtvc	r6, [r7], #-3685	; 0xfffff19b
     9bc:	65530068 	ldrbvs	r0, [r3, #-104]	; 0xffffff98
     9c0:	68435f74 	stmdavs	r3, {r2, r4, r5, r6, r8, r9, sl, fp, ip, lr}^
     9c4:	4c5f7261 	lfmmi	f7, 2, [pc], {97}	; 0x61
     9c8:	74676e65 	strbtvc	r6, [r7], #-3685	; 0xfffff19b
     9cc:	61720068 	cmnvs	r2, r8, rrx
     9d0:	52006574 	andpl	r6, r0, #116, 10	; 0x1d000000
     9d4:	5f646165 	svcpl	0x00646165
     9d8:	636f6c42 	cmnvs	pc, #16896	; 0x4200
     9dc:	676e696b 	strbvs	r6, [lr, -fp, ror #18]!
     9e0:	5f524200 	svcpl	0x00524200
     9e4:	30323931 	eorscc	r3, r2, r1, lsr r9
     9e8:	74530030 	ldrbvc	r0, [r3], #-48	; 0xffffffd0
     9ec:	00747261 	rsbseq	r7, r4, r1, ror #4
     9f0:	354e5a5f 	strbcc	r5, [lr, #-2655]	; 0xfffff5a1
     9f4:	52415543 	subpl	r5, r1, #281018368	; 0x10c00000
     9f8:	72573554 	subsvc	r3, r7, #84, 10	; 0x15000000
     9fc:	45657469 	strbmi	r7, [r5, #-1129]!	; 0xfffffb97
     a00:	00634b50 	rsbeq	r4, r3, r0, asr fp
     a04:	345f5242 	ldrbcc	r5, [pc], #-578	; a0c <shift+0xa0c>
     a08:	00303038 	eorseq	r3, r0, r8, lsr r0
     a0c:	5f746553 	svcpl	0x00746553
     a10:	64756142 	ldrbtvs	r6, [r5], #-322	; 0xfffffebe
     a14:	7461525f 	strbtvc	r5, [r1], #-607	; 0xfffffda1
     a18:	5a5f0065 	bpl	17c0bb4 <_bss_end+0x17b73d0>
     a1c:	5543354e 	strbpl	r3, [r3, #-1358]	; 0xfffffab2
     a20:	31545241 	cmpcc	r4, r1, asr #4
     a24:	74655333 	strbtvc	r5, [r5], #-819	; 0xfffffccd
     a28:	7561425f 	strbvc	r4, [r1, #-607]!	; 0xfffffda1
     a2c:	61525f64 	cmpvs	r2, r4, ror #30
     a30:	31456574 	hvccc	22100	; 0x5654
     a34:	41554e35 	cmpmi	r5, r5, lsr lr
     a38:	425f5452 	subsmi	r5, pc, #1375731712	; 0x52000000
     a3c:	5f647561 	svcpl	0x00647561
     a40:	65746152 	ldrbvs	r6, [r4, #-338]!	; 0xfffffeae
     a44:	54434100 	strbpl	r4, [r3], #-256	; 0xffffff00
     a48:	6e69505f 	mcrvs	0, 3, r5, cr9, cr15, {2}
     a4c:	395a5f00 	ldmdbcc	sl, {r8, r9, sl, fp, ip, lr}^
     a50:	6e727562 	cdpvs	5, 7, cr7, cr2, cr2, {3}
     a54:	6d69745f 	cfstrdvs	mvd7, [r9, #-380]!	; 0xfffffe84
     a58:	5f006965 	svcpl	0x00006965
     a5c:	6572375a 	ldrbvs	r3, [r2, #-1882]!	; 0xfffff8a6
     a60:	73726576 	cmnvc	r2, #494927872	; 0x1d800000
     a64:	69635065 	stmdbvs	r3!, {r0, r2, r5, r6, ip, lr}^
     a68:	72756200 	rsbsvc	r6, r5, #0, 4
     a6c:	69745f6e 	ldmdbvs	r4!, {r1, r2, r3, r5, r6, r8, r9, sl, fp, ip, lr}^
     a70:	6c00656d 	cfstr32vs	mvfx6, [r0], {109}	; 0x6d
     a74:	74676e65 	strbtvc	r6, [r7], #-3685	; 0xfffff19b
     a78:	6b5f0068 	blvs	17c0c20 <_bss_end+0x17b743c>
     a7c:	656e7265 	strbvs	r7, [lr, #-613]!	; 0xfffffd9b
     a80:	616d5f6c 	cmnvs	sp, ip, ror #30
     a84:	5f006e69 	svcpl	0x00006e69
     a88:	7469345a 	strbtvc	r3, [r9], #-1114	; 0xfffffba6
     a8c:	5069616f 	rsbpl	r6, r9, pc, ror #2
     a90:	69006963 	stmdbvs	r0, {r0, r1, r5, r6, r8, fp, sp, lr}
     a94:	00616f74 	rsbeq	r6, r1, r4, ror pc
     a98:	6d6f682f 	stclvs	8, cr6, [pc, #-188]!	; 9e4 <shift+0x9e4>
     a9c:	66632f65 	strbtvs	r2, [r3], -r5, ror #30
     aa0:	55435a2f 	strbpl	r5, [r3, #-2607]	; 0xfffff5d1
     aa4:	7269662f 	rsbvc	r6, r9, #49283072	; 0x2f00000
     aa8:	795f7473 	ldmdbvc	pc, {r0, r1, r4, r5, r6, sl, ip, sp, lr}^	; <UNPREDICTABLE>
     aac:	2f726165 	svccs	0x00726165
     ab0:	746e6977 	strbtvc	r6, [lr], #-2423	; 0xfffff689
     ab4:	4f2f7265 	svcmi	0x002f7265
     ab8:	72702f53 	rsbsvc	r2, r0, #332	; 0x14c
     abc:	69746361 	ldmdbvs	r4!, {r0, r5, r6, r8, r9, sp, lr}^
     ac0:	2f6c6163 	svccs	0x006c6163
     ac4:	2f337865 	svccs	0x00337865
     ac8:	6e72656b 	cdpvs	5, 7, cr6, cr2, cr11, {3}
     acc:	732f6c65 			; <UNDEFINED> instruction: 0x732f6c65
     ad0:	6d2f6372 	stcvs	3, cr6, [pc, #-456]!	; 910 <shift+0x910>
     ad4:	2e6e6961 	vnmulcs.f16	s13, s28, s3	; <UNPREDICTABLE>
     ad8:	00707063 	rsbseq	r7, r0, r3, rrx
     adc:	654e7369 	strbvs	r7, [lr, #-873]	; 0xfffffc97
     ae0:	69746167 	ldmdbvs	r4!, {r0, r1, r2, r5, r6, r8, sp, lr}^
     ae4:	72006576 	andvc	r6, r0, #494927872	; 0x1d800000
     ae8:	72657665 	rsbvc	r7, r5, #105906176	; 0x6500000
     aec:	2f006573 	svccs	0x00006573
     af0:	656d6f68 	strbvs	r6, [sp, #-3944]!	; 0xfffff098
     af4:	2f66632f 	svccs	0x0066632f
     af8:	2f55435a 	svccs	0x0055435a
     afc:	73726966 	cmnvc	r2, #1671168	; 0x198000
     b00:	65795f74 	ldrbvs	r5, [r9, #-3956]!	; 0xfffff08c
     b04:	772f7261 	strvc	r7, [pc, -r1, ror #4]!
     b08:	65746e69 	ldrbvs	r6, [r4, #-3689]!	; 0xfffff197
     b0c:	534f2f72 	movtpl	r2, #65394	; 0xff72
     b10:	6172702f 	cmnvs	r2, pc, lsr #32
     b14:	63697463 	cmnvs	r9, #1660944384	; 0x63000000
     b18:	652f6c61 	strvs	r6, [pc, #-3169]!	; fffffebf <_bss_end+0xffff66db>
     b1c:	6b2f3378 	blvs	bcd904 <_bss_end+0xbc4120>
     b20:	656e7265 	strbvs	r7, [lr, #-613]!	; 0xfffffd9b
     b24:	72732f6c 	rsbsvc	r2, r3, #108, 30	; 0x1b0
     b28:	74732f63 	ldrbtvc	r2, [r3], #-3939	; 0xfffff09d
     b2c:	2e747261 	cdpcs	2, 7, cr7, cr4, cr1, {3}
     b30:	4e470073 	mcrmi	0, 2, r0, cr7, cr3, {3}
     b34:	53412055 	movtpl	r2, #4181	; 0x1055
     b38:	332e3220 			; <UNDEFINED> instruction: 0x332e3220
     b3c:	74630039 	strbtvc	r0, [r3], #-57	; 0xffffffc7
     b40:	705f726f 	subsvc	r7, pc, pc, ror #4
     b44:	5f007274 	svcpl	0x00007274
     b48:	5f737362 	svcpl	0x00737362
     b4c:	72617473 	rsbvc	r7, r1, #1929379840	; 0x73000000
     b50:	5f5f0074 	svcpl	0x005f0074
     b54:	524f5443 	subpl	r5, pc, #1124073472	; 0x43000000
     b58:	444e455f 	strbmi	r4, [lr], #-1375	; 0xfffffaa1
     b5c:	5f005f5f 	svcpl	0x00005f5f
     b60:	4f54435f 	svcmi	0x0054435f
     b64:	494c5f52 	stmdbmi	ip, {r1, r4, r6, r8, r9, sl, fp, ip, lr}^
     b68:	5f5f5453 	svcpl	0x005f5453
     b6c:	445f5f00 	ldrbmi	r5, [pc], #-3840	; b74 <shift+0xb74>
     b70:	5f524f54 	svcpl	0x00524f54
     b74:	5f444e45 	svcpl	0x00444e45
     b78:	682f005f 	stmdavs	pc!, {r0, r1, r2, r3, r4, r6}	; <UNPREDICTABLE>
     b7c:	2f656d6f 	svccs	0x00656d6f
     b80:	5a2f6663 	bpl	bda514 <_bss_end+0xbd0d30>
     b84:	662f5543 	strtvs	r5, [pc], -r3, asr #10
     b88:	74737269 	ldrbtvc	r7, [r3], #-617	; 0xfffffd97
     b8c:	6165795f 	cmnvs	r5, pc, asr r9
     b90:	69772f72 	ldmdbvs	r7!, {r1, r4, r5, r6, r8, r9, sl, fp, sp}^
     b94:	7265746e 	rsbvc	r7, r5, #1845493760	; 0x6e000000
     b98:	2f534f2f 	svccs	0x00534f2f
     b9c:	63617270 	cmnvs	r1, #112, 4
     ba0:	61636974 	smcvs	13972	; 0x3694
     ba4:	78652f6c 	stmdavc	r5!, {r2, r3, r5, r6, r8, r9, sl, fp, sp}^
     ba8:	656b2f33 	strbvs	r2, [fp, #-3891]!	; 0xfffff0cd
     bac:	6c656e72 	stclvs	14, cr6, [r5], #-456	; 0xfffffe38
     bb0:	6372732f 	cmnvs	r2, #-1140850688	; 0xbc000000
     bb4:	6174732f 	cmnvs	r4, pc, lsr #6
     bb8:	70757472 	rsbsvc	r7, r5, r2, ror r4
     bbc:	7070632e 	rsbsvc	r6, r0, lr, lsr #6
     bc0:	70635f00 	rsbvc	r5, r3, r0, lsl #30
     bc4:	68735f70 	ldmdavs	r3!, {r4, r5, r6, r8, r9, sl, fp, ip, lr}^
     bc8:	6f647475 	svcvs	0x00647475
     bcc:	5f006e77 	svcpl	0x00006e77
     bd0:	5f737362 	svcpl	0x00737362
     bd4:	00646e65 	rsbeq	r6, r4, r5, ror #28
     bd8:	54445f5f 	strbpl	r5, [r4], #-3935	; 0xfffff0a1
     bdc:	4c5f524f 	lfmmi	f5, 2, [pc], {79}	; 0x4f
     be0:	5f545349 	svcpl	0x00545349
     be4:	7464005f 	strbtvc	r0, [r4], #-95	; 0xffffffa1
     be8:	705f726f 	subsvc	r7, pc, pc, ror #4
     bec:	5f007274 	svcpl	0x00007274
     bf0:	74735f63 	ldrbtvc	r5, [r3], #-3939	; 0xfffff09d
     bf4:	75747261 	ldrbvc	r7, [r4, #-609]!	; 0xfffffd9f
     bf8:	635f0070 	cmpvs	pc, #112	; 0x70
     bfc:	735f7070 	cmpvc	pc, #112	; 0x70
     c00:	74726174 	ldrbtvc	r6, [r2], #-372	; 0xfffffe8c
     c04:	66007075 			; <UNDEFINED> instruction: 0x66007075
     c08:	7274706e 	rsbsvc	r7, r4, #110	; 0x6e
     c0c:	62696c00 	rsbvs	r6, r9, #0, 24
     c10:	6e756631 	mrcvs	6, 3, r6, cr5, cr1, {1}
     c14:	532e7363 			; <UNDEFINED> instruction: 0x532e7363
     c18:	75622f00 	strbvc	r2, [r2, #-3840]!	; 0xfffff100
     c1c:	64646c69 	strbtvs	r6, [r4], #-3177	; 0xfffff397
     c20:	622f7269 	eorvs	r7, pc, #-1879048186	; 0x90000006
     c24:	646c6975 	strbtvs	r6, [ip], #-2421	; 0xfffff68b
     c28:	4955422f 	ldmdbmi	r5, {r0, r1, r2, r3, r5, r9, lr}^
     c2c:	612f444c 			; <UNDEFINED> instruction: 0x612f444c
     c30:	6e2d6d72 	mcrvs	13, 1, r6, cr13, cr2, {3}
     c34:	2d656e6f 	stclcs	14, cr6, [r5, #-444]!	; 0xfffffe44
     c38:	69626165 	stmdbvs	r2!, {r0, r2, r5, r6, r8, sp, lr}^
     c3c:	6363672d 	cmnvs	r3, #11796480	; 0xb40000
     c40:	2d73632d 	ldclcs	3, cr6, [r3, #-180]!	; 0xffffff4c
     c44:	322e3231 	eorcc	r3, lr, #268435459	; 0x10000003
     c48:	672f302e 	strvs	r3, [pc, -lr, lsr #32]!
     c4c:	612d6363 			; <UNDEFINED> instruction: 0x612d6363
     c50:	6e2d6d72 	mcrvs	13, 1, r6, cr13, cr2, {3}
     c54:	2d656e6f 	stclcs	14, cr6, [r5, #-444]!	; 0xfffffe44
     c58:	69626165 	stmdbvs	r2!, {r0, r2, r5, r6, r8, sp, lr}^
     c5c:	6d72612f 	ldfvse	f6, [r2, #-188]!	; 0xffffff44
     c60:	6e6f6e2d 	cdpvs	14, 6, cr6, cr15, cr13, {1}
     c64:	61652d65 	cmnvs	r5, r5, ror #26
     c68:	612f6962 			; <UNDEFINED> instruction: 0x612f6962
     c6c:	762f6d72 			; <UNDEFINED> instruction: 0x762f6d72
     c70:	2f657435 	svccs	0x00657435
     c74:	64726168 	ldrbtvs	r6, [r2], #-360	; 0xfffffe98
     c78:	62696c2f 	rsbvs	r6, r9, #12032	; 0x2f00
     c7c:	00636367 	rsbeq	r6, r3, r7, ror #6
     c80:	20554e47 	subscs	r4, r5, r7, asr #28
     c84:	32205341 	eorcc	r5, r0, #67108865	; 0x4000001
     c88:	0037332e 	eorseq	r3, r7, lr, lsr #6
     c8c:	5f617369 	svcpl	0x00617369
     c90:	5f746962 	svcpl	0x00746962
     c94:	64657270 	strbtvs	r7, [r5], #-624	; 0xfffffd90
     c98:	00736572 	rsbseq	r6, r3, r2, ror r5
     c9c:	5f617369 	svcpl	0x00617369
     ca0:	5f746962 	svcpl	0x00746962
     ca4:	5f706676 	svcpl	0x00706676
     ca8:	65736162 	ldrbvs	r6, [r3, #-354]!	; 0xfffffe9e
     cac:	6d6f6300 	stclvs	3, cr6, [pc, #-0]	; cb4 <shift+0xcb4>
     cb0:	78656c70 	stmdavc	r5!, {r4, r5, r6, sl, fp, sp, lr}^
     cb4:	6f6c6620 	svcvs	0x006c6620
     cb8:	69007461 	stmdbvs	r0, {r0, r5, r6, sl, ip, sp, lr}
     cbc:	6e5f6173 	mrcvs	1, 2, r6, cr15, cr3, {3}
     cc0:	7469626f 	strbtvc	r6, [r9], #-623	; 0xfffffd91
     cc4:	61736900 	cmnvs	r3, r0, lsl #18
     cc8:	7469625f 	strbtvc	r6, [r9], #-607	; 0xfffffda1
     ccc:	65766d5f 	ldrbvs	r6, [r6, #-3423]!	; 0xfffff2a1
     cd0:	6f6c665f 	svcvs	0x006c665f
     cd4:	69007461 	stmdbvs	r0, {r0, r5, r6, sl, ip, sp, lr}
     cd8:	625f6173 	subsvs	r6, pc, #-1073741796	; 0xc000001c
     cdc:	665f7469 	ldrbvs	r7, [pc], -r9, ror #8
     ce0:	00363170 	eorseq	r3, r6, r0, ror r1
     ce4:	5f617369 	svcpl	0x00617369
     ce8:	5f746962 	svcpl	0x00746962
     cec:	00636573 	rsbeq	r6, r3, r3, ror r5
     cf0:	5f617369 	svcpl	0x00617369
     cf4:	5f746962 	svcpl	0x00746962
     cf8:	76696461 	strbtvc	r6, [r9], -r1, ror #8
     cfc:	61736900 	cmnvs	r3, r0, lsl #18
     d00:	7469625f 	strbtvc	r6, [r9], #-607	; 0xfffffda1
     d04:	6975715f 	ldmdbvs	r5!, {r0, r1, r2, r3, r4, r6, r8, ip, sp, lr}^
     d08:	6e5f6b72 	vmovvs.s8	r6, d15[3]
     d0c:	6f765f6f 	svcvs	0x00765f6f
     d10:	6974616c 	ldmdbvs	r4!, {r2, r3, r5, r6, r8, sp, lr}^
     d14:	635f656c 	cmpvs	pc, #108, 10	; 0x1b000000
     d18:	73690065 	cmnvc	r9, #101	; 0x65
     d1c:	69625f61 	stmdbvs	r2!, {r0, r5, r6, r8, r9, sl, fp, ip, lr}^
     d20:	706d5f74 	rsbvc	r5, sp, r4, ror pc
     d24:	61736900 	cmnvs	r3, r0, lsl #18
     d28:	7469625f 	strbtvc	r6, [r9], #-607	; 0xfffffda1
     d2c:	6d72615f 	ldfvse	f6, [r2, #-380]!	; 0xfffffe84
     d30:	00743576 	rsbseq	r3, r4, r6, ror r5
     d34:	5f617369 	svcpl	0x00617369
     d38:	5f746962 	svcpl	0x00746962
     d3c:	766d7261 	strbtvc	r7, [sp], -r1, ror #4
     d40:	00657435 	rsbeq	r7, r5, r5, lsr r4
     d44:	5f617369 	svcpl	0x00617369
     d48:	5f746962 	svcpl	0x00746962
     d4c:	6e6f656e 	cdpvs	5, 6, cr6, cr15, cr14, {3}
     d50:	61736900 	cmnvs	r3, r0, lsl #18
     d54:	7469625f 	strbtvc	r6, [r9], #-607	; 0xfffffda1
     d58:	3166625f 	cmncc	r6, pc, asr r2
     d5c:	2e2e0036 	mcrcs	0, 1, r0, cr14, cr6, {1}
     d60:	2f2e2e2f 	svccs	0x002e2e2f
     d64:	2e2f2e2e 	cdpcs	14, 2, cr2, cr15, cr14, {1}
     d68:	2e2e2f2e 	cdpcs	15, 2, cr2, cr14, cr14, {1}
     d6c:	2f2e2e2f 	svccs	0x002e2e2f
     d70:	2d636367 	stclcs	3, cr6, [r3, #-412]!	; 0xfffffe64
     d74:	322e3231 	eorcc	r3, lr, #268435459	; 0x10000003
     d78:	6c2f302e 	stcvs	0, cr3, [pc], #-184	; cc8 <shift+0xcc8>
     d7c:	63676269 	cmnvs	r7, #-1879048186	; 0x90000006
     d80:	696c2f63 	stmdbvs	ip!, {r0, r1, r5, r6, r8, r9, sl, fp, sp}^
     d84:	63636762 	cmnvs	r3, #25690112	; 0x1880000
     d88:	00632e32 	rsbeq	r2, r3, r2, lsr lr
     d8c:	43535046 	cmpmi	r3, #70	; 0x46
     d90:	4e455f52 	mcrmi	15, 2, r5, cr5, cr2, {2}
     d94:	46004d55 			; <UNDEFINED> instruction: 0x46004d55
     d98:	52435350 	subpl	r5, r3, #80, 6	; 0x40000001
     d9c:	637a6e5f 	cmnvs	sl, #1520	; 0x5f0
     da0:	5f637176 	svcpl	0x00637176
     da4:	4d554e45 	ldclmi	14, cr4, [r5, #-276]	; 0xfffffeec
     da8:	52505600 	subspl	r5, r0, #0, 12
     dac:	554e455f 	strbpl	r4, [lr, #-1375]	; 0xfffffaa1
     db0:	6266004d 	rsbvs	r0, r6, #77	; 0x4d
     db4:	695f7469 	ldmdbvs	pc, {r0, r3, r5, r6, sl, ip, sp, lr}^	; <UNPREDICTABLE>
     db8:	696c706d 	stmdbvs	ip!, {r0, r2, r3, r5, r6, ip, sp, lr}^
     dbc:	69746163 	ldmdbvs	r4!, {r0, r1, r5, r6, r8, sp, lr}^
     dc0:	50006e6f 	andpl	r6, r0, pc, ror #28
     dc4:	4e455f30 	mcrmi	15, 2, r5, cr5, cr0, {1}
     dc8:	69004d55 	stmdbvs	r0, {r0, r2, r4, r6, r8, sl, fp, lr}
     dcc:	625f6173 	subsvs	r6, pc, #-1073741796	; 0xc000001c
     dd0:	635f7469 	cmpvs	pc, #1761607680	; 0x69000000
     dd4:	74707972 	ldrbtvc	r7, [r0], #-2418	; 0xfffff68e
     dd8:	7369006f 	cmnvc	r9, #111	; 0x6f
     ddc:	69625f61 	stmdbvs	r2!, {r0, r5, r6, r8, r9, sl, fp, ip, lr}^
     de0:	64745f74 	ldrbtvs	r5, [r4], #-3956	; 0xfffff08c
     de4:	63007669 	movwvs	r7, #1641	; 0x669
     de8:	00736e6f 	rsbseq	r6, r3, pc, ror #28
     dec:	5f617369 	svcpl	0x00617369
     df0:	5f746962 	svcpl	0x00746962
     df4:	6d6d7769 	stclvs	7, cr7, [sp, #-420]!	; 0xfffffe5c
     df8:	46007478 			; <UNDEFINED> instruction: 0x46007478
     dfc:	54584350 	ldrbpl	r4, [r8], #-848	; 0xfffffcb0
     e00:	4e455f53 	mcrmi	15, 2, r5, cr5, cr3, {2}
     e04:	69004d55 	stmdbvs	r0, {r0, r2, r4, r6, r8, sl, fp, lr}
     e08:	625f6173 	subsvs	r6, pc, #-1073741796	; 0xc000001c
     e0c:	615f7469 	cmpvs	pc, r9, ror #8
     e10:	36766d72 			; <UNDEFINED> instruction: 0x36766d72
     e14:	61736900 	cmnvs	r3, r0, lsl #18
     e18:	7469625f 	strbtvc	r6, [r9], #-607	; 0xfffffda1
     e1c:	65766d5f 	ldrbvs	r6, [r6, #-3423]!	; 0xfffff2a1
     e20:	61736900 	cmnvs	r3, r0, lsl #18
     e24:	7469625f 	strbtvc	r6, [r9], #-607	; 0xfffffda1
     e28:	6d77695f 			; <UNDEFINED> instruction: 0x6d77695f
     e2c:	3274786d 	rsbscc	r7, r4, #7143424	; 0x6d0000
     e30:	61736900 	cmnvs	r3, r0, lsl #18
     e34:	7469625f 	strbtvc	r6, [r9], #-607	; 0xfffffda1
     e38:	6564635f 	strbvs	r6, [r4, #-863]!	; 0xfffffca1
     e3c:	00307063 	eorseq	r7, r0, r3, rrx
     e40:	5f617369 	svcpl	0x00617369
     e44:	5f746962 	svcpl	0x00746962
     e48:	63656463 	cmnvs	r5, #1660944384	; 0x63000000
     e4c:	69003170 	stmdbvs	r0, {r4, r5, r6, r8, ip, sp}
     e50:	625f6173 	subsvs	r6, pc, #-1073741796	; 0xc000001c
     e54:	635f7469 	cmpvs	pc, #1761607680	; 0x69000000
     e58:	70636564 	rsbvc	r6, r3, r4, ror #10
     e5c:	73690032 	cmnvc	r9, #50	; 0x32
     e60:	69625f61 	stmdbvs	r2!, {r0, r5, r6, r8, r9, sl, fp, ip, lr}^
     e64:	64635f74 	strbtvs	r5, [r3], #-3956	; 0xfffff08c
     e68:	33706365 	cmncc	r0, #-1811939327	; 0x94000001
     e6c:	61736900 	cmnvs	r3, r0, lsl #18
     e70:	7469625f 	strbtvc	r6, [r9], #-607	; 0xfffffda1
     e74:	6564635f 	strbvs	r6, [r4, #-863]!	; 0xfffffca1
     e78:	00347063 	eorseq	r7, r4, r3, rrx
     e7c:	5f617369 	svcpl	0x00617369
     e80:	5f746962 	svcpl	0x00746962
     e84:	645f7066 	ldrbvs	r7, [pc], #-102	; e8c <shift+0xe8c>
     e88:	69006c62 	stmdbvs	r0, {r1, r5, r6, sl, fp, sp, lr}
     e8c:	625f6173 	subsvs	r6, pc, #-1073741796	; 0xc000001c
     e90:	635f7469 	cmpvs	pc, #1761607680	; 0x69000000
     e94:	70636564 	rsbvc	r6, r3, r4, ror #10
     e98:	73690036 	cmnvc	r9, #54	; 0x36
     e9c:	69625f61 	stmdbvs	r2!, {r0, r5, r6, r8, r9, sl, fp, ip, lr}^
     ea0:	64635f74 	strbtvs	r5, [r3], #-3956	; 0xfffff08c
     ea4:	37706365 	ldrbcc	r6, [r0, -r5, ror #6]!
     ea8:	61736900 	cmnvs	r3, r0, lsl #18
     eac:	7469625f 	strbtvc	r6, [r9], #-607	; 0xfffffda1
     eb0:	6d72615f 	ldfvse	f6, [r2, #-380]!	; 0xfffffe84
     eb4:	006b3676 	rsbeq	r3, fp, r6, ror r6
     eb8:	5f617369 	svcpl	0x00617369
     ebc:	5f746962 	svcpl	0x00746962
     ec0:	766d7261 	strbtvc	r7, [sp], -r1, ror #4
     ec4:	6d315f38 	ldcvs	15, cr5, [r1, #-224]!	; 0xffffff20
     ec8:	69616d5f 	stmdbvs	r1!, {r0, r1, r2, r3, r4, r6, r8, sl, fp, sp, lr}^
     ecc:	6e61006e 	cdpvs	0, 6, cr0, cr1, cr14, {3}
     ed0:	69006574 	stmdbvs	r0, {r2, r4, r5, r6, r8, sl, sp, lr}
     ed4:	625f6173 	subsvs	r6, pc, #-1073741796	; 0xc000001c
     ed8:	635f7469 	cmpvs	pc, #1761607680	; 0x69000000
     edc:	0065736d 	rsbeq	r7, r5, sp, ror #6
     ee0:	676e6f6c 	strbvs	r6, [lr, -ip, ror #30]!
     ee4:	756f6420 	strbvc	r6, [pc, #-1056]!	; acc <shift+0xacc>
     ee8:	00656c62 	rsbeq	r6, r5, r2, ror #24
     eec:	5f617369 	svcpl	0x00617369
     ef0:	5f746962 	svcpl	0x00746962
     ef4:	35767066 	ldrbcc	r7, [r6, #-102]!	; 0xffffff9a
     ef8:	61736900 	cmnvs	r3, r0, lsl #18
     efc:	7469625f 	strbtvc	r6, [r9], #-607	; 0xfffffda1
     f00:	6373785f 	cmnvs	r3, #6225920	; 0x5f0000
     f04:	00656c61 	rsbeq	r6, r5, r1, ror #24
     f08:	676e6f6c 	strbvs	r6, [lr, -ip, ror #30]!
     f0c:	6e6f6c20 	cdpvs	12, 6, cr6, cr15, cr0, {1}
     f10:	6e752067 	cdpvs	0, 7, cr2, cr5, cr7, {3}
     f14:	6e676973 			; <UNDEFINED> instruction: 0x6e676973
     f18:	69206465 	stmdbvs	r0!, {r0, r2, r5, r6, sl, sp, lr}
     f1c:	6900746e 	stmdbvs	r0, {r1, r2, r3, r5, r6, sl, ip, sp, lr}
     f20:	625f6173 	subsvs	r6, pc, #-1073741796	; 0xc000001c
     f24:	715f7469 	cmpvc	pc, r9, ror #8
     f28:	6b726975 	blvs	1c9b504 <_bss_end+0x1c91d20>
     f2c:	336d635f 	cmncc	sp, #2080374785	; 0x7c000001
     f30:	72646c5f 	rsbvc	r6, r4, #24320	; 0x5f00
     f34:	73690064 	cmnvc	r9, #100	; 0x64
     f38:	69625f61 	stmdbvs	r2!, {r0, r5, r6, r8, r9, sl, fp, ip, lr}^
     f3c:	38695f74 	stmdacc	r9!, {r2, r4, r5, r6, r8, r9, sl, fp, ip, lr}^
     f40:	69006d6d 	stmdbvs	r0, {r0, r2, r3, r5, r6, r8, sl, fp, sp, lr}
     f44:	625f6173 	subsvs	r6, pc, #-1073741796	; 0xc000001c
     f48:	665f7469 	ldrbvs	r7, [pc], -r9, ror #8
     f4c:	33645f70 	cmncc	r4, #112, 30	; 0x1c0
     f50:	73690032 	cmnvc	r9, #50	; 0x32
     f54:	69625f61 	stmdbvs	r2!, {r0, r5, r6, r8, r9, sl, fp, ip, lr}^
     f58:	72615f74 	rsbvc	r5, r1, #116, 30	; 0x1d0
     f5c:	6537766d 	ldrvs	r7, [r7, #-1645]!	; 0xfffff993
     f60:	7369006d 	cmnvc	r9, #109	; 0x6d
     f64:	69625f61 	stmdbvs	r2!, {r0, r5, r6, r8, r9, sl, fp, ip, lr}^
     f68:	706c5f74 	rsbvc	r5, ip, r4, ror pc
     f6c:	61006561 	tstvs	r0, r1, ror #10
     f70:	695f6c6c 	ldmdbvs	pc, {r2, r3, r5, r6, sl, fp, sp, lr}^	; <UNPREDICTABLE>
     f74:	696c706d 	stmdbvs	ip!, {r0, r2, r3, r5, r6, ip, sp, lr}^
     f78:	665f6465 	ldrbvs	r6, [pc], -r5, ror #8
     f7c:	73746962 	cmnvc	r4, #1605632	; 0x188000
     f80:	61736900 	cmnvs	r3, r0, lsl #18
     f84:	7469625f 	strbtvc	r6, [r9], #-607	; 0xfffffda1
     f88:	6d72615f 	ldfvse	f6, [r2, #-380]!	; 0xfffffe84
     f8c:	315f3876 	cmpcc	pc, r6, ror r8	; <UNPREDICTABLE>
     f90:	61736900 	cmnvs	r3, r0, lsl #18
     f94:	7469625f 	strbtvc	r6, [r9], #-607	; 0xfffffda1
     f98:	6d72615f 	ldfvse	f6, [r2, #-380]!	; 0xfffffe84
     f9c:	325f3876 	subscc	r3, pc, #7733248	; 0x760000
     fa0:	61736900 	cmnvs	r3, r0, lsl #18
     fa4:	7469625f 	strbtvc	r6, [r9], #-607	; 0xfffffda1
     fa8:	6d72615f 	ldfvse	f6, [r2, #-380]!	; 0xfffffe84
     fac:	335f3876 	cmpcc	pc, #7733248	; 0x760000
     fb0:	61736900 	cmnvs	r3, r0, lsl #18
     fb4:	7469625f 	strbtvc	r6, [r9], #-607	; 0xfffffda1
     fb8:	6d72615f 	ldfvse	f6, [r2, #-380]!	; 0xfffffe84
     fbc:	345f3876 	ldrbcc	r3, [pc], #-2166	; fc4 <shift+0xfc4>
     fc0:	61736900 	cmnvs	r3, r0, lsl #18
     fc4:	7469625f 	strbtvc	r6, [r9], #-607	; 0xfffffda1
     fc8:	6d72615f 	ldfvse	f6, [r2, #-380]!	; 0xfffffe84
     fcc:	355f3876 	ldrbcc	r3, [pc, #-2166]	; 75e <shift+0x75e>
     fd0:	61736900 	cmnvs	r3, r0, lsl #18
     fd4:	7469625f 	strbtvc	r6, [r9], #-607	; 0xfffffda1
     fd8:	6d72615f 	ldfvse	f6, [r2, #-380]!	; 0xfffffe84
     fdc:	365f3876 			; <UNDEFINED> instruction: 0x365f3876
     fe0:	61736900 	cmnvs	r3, r0, lsl #18
     fe4:	7469625f 	strbtvc	r6, [r9], #-607	; 0xfffffda1
     fe8:	0062735f 	rsbeq	r7, r2, pc, asr r3
     fec:	5f617369 	svcpl	0x00617369
     ff0:	5f6d756e 	svcpl	0x006d756e
     ff4:	73746962 	cmnvc	r4, #1605632	; 0x188000
     ff8:	61736900 	cmnvs	r3, r0, lsl #18
     ffc:	7469625f 	strbtvc	r6, [r9], #-607	; 0xfffffda1
    1000:	616d735f 	cmnvs	sp, pc, asr r3
    1004:	756d6c6c 	strbvc	r6, [sp, #-3180]!	; 0xfffff394
    1008:	7566006c 	strbvc	r0, [r6, #-108]!	; 0xffffff94
    100c:	705f636e 	subsvc	r6, pc, lr, ror #6
    1010:	63007274 	movwvs	r7, #628	; 0x274
    1014:	6c706d6f 	ldclvs	13, cr6, [r0], #-444	; 0xfffffe44
    1018:	64207865 	strtvs	r7, [r0], #-2149	; 0xfffff79b
    101c:	6c62756f 	cfstr64vs	mvdx7, [r2], #-444	; 0xfffffe44
    1020:	424e0065 	submi	r0, lr, #101	; 0x65
    1024:	5f50465f 	svcpl	0x0050465f
    1028:	52535953 	subspl	r5, r3, #1359872	; 0x14c000
    102c:	00534745 	subseq	r4, r3, r5, asr #14
    1030:	5f617369 	svcpl	0x00617369
    1034:	5f746962 	svcpl	0x00746962
    1038:	72697571 	rsbvc	r7, r9, #473956352	; 0x1c400000
    103c:	6c765f6b 	ldclvs	15, cr5, [r6], #-428	; 0xfffffe54
    1040:	006d646c 	rsbeq	r6, sp, ip, ror #8
    1044:	5f617369 	svcpl	0x00617369
    1048:	5f746962 	svcpl	0x00746962
    104c:	63656463 	cmnvs	r5, #1660944384	; 0x63000000
    1050:	69003570 	stmdbvs	r0, {r4, r5, r6, r8, sl, ip, sp}
    1054:	625f6173 	subsvs	r6, pc, #-1073741796	; 0xc000001c
    1058:	765f7469 	ldrbvc	r7, [pc], -r9, ror #8
    105c:	32767066 	rsbscc	r7, r6, #102	; 0x66
    1060:	61736900 	cmnvs	r3, r0, lsl #18
    1064:	7469625f 	strbtvc	r6, [r9], #-607	; 0xfffffda1
    1068:	7066765f 	rsbvc	r7, r6, pc, asr r6
    106c:	69003376 	stmdbvs	r0, {r1, r2, r4, r5, r6, r8, r9, ip, sp}
    1070:	625f6173 	subsvs	r6, pc, #-1073741796	; 0xc000001c
    1074:	765f7469 	ldrbvc	r7, [pc], -r9, ror #8
    1078:	34767066 	ldrbtcc	r7, [r6], #-102	; 0xffffff9a
    107c:	43504600 	cmpmi	r0, #0, 12
    1080:	534e5458 	movtpl	r5, #58456	; 0xe458
    1084:	554e455f 	strbpl	r4, [lr, #-1375]	; 0xfffffaa1
    1088:	7369004d 	cmnvc	r9, #77	; 0x4d
    108c:	69625f61 	stmdbvs	r2!, {r0, r5, r6, r8, r9, sl, fp, ip, lr}^
    1090:	68745f74 	ldmdavs	r4!, {r2, r4, r5, r6, r8, r9, sl, fp, ip, lr}^
    1094:	00626d75 	rsbeq	r6, r2, r5, ror sp
    1098:	5f617369 	svcpl	0x00617369
    109c:	5f746962 	svcpl	0x00746962
    10a0:	36317066 	ldrtcc	r7, [r1], -r6, rrx
    10a4:	766e6f63 	strbtvc	r6, [lr], -r3, ror #30
    10a8:	61736900 	cmnvs	r3, r0, lsl #18
    10ac:	6165665f 	cmnvs	r5, pc, asr r6
    10b0:	65727574 	ldrbvs	r7, [r2, #-1396]!	; 0xfffffa8c
    10b4:	61736900 	cmnvs	r3, r0, lsl #18
    10b8:	7469625f 	strbtvc	r6, [r9], #-607	; 0xfffffda1
    10bc:	746f6e5f 	strbtvc	r6, [pc], #-3679	; 10c4 <shift+0x10c4>
    10c0:	7369006d 	cmnvc	r9, #109	; 0x6d
    10c4:	69625f61 	stmdbvs	r2!, {r0, r5, r6, r8, r9, sl, fp, ip, lr}^
    10c8:	75715f74 	ldrbvc	r5, [r1, #-3956]!	; 0xfffff08c
    10cc:	5f6b7269 	svcpl	0x006b7269
    10d0:	766d7261 	strbtvc	r7, [sp], -r1, ror #4
    10d4:	007a6b36 	rsbseq	r6, sl, r6, lsr fp
    10d8:	5f617369 	svcpl	0x00617369
    10dc:	5f746962 	svcpl	0x00746962
    10e0:	33637263 	cmncc	r3, #805306374	; 0x30000006
    10e4:	73690032 	cmnvc	r9, #50	; 0x32
    10e8:	69625f61 	stmdbvs	r2!, {r0, r5, r6, r8, r9, sl, fp, ip, lr}^
    10ec:	72615f74 	rsbvc	r5, r1, #116, 30	; 0x1d0
    10f0:	0039766d 	eorseq	r7, r9, sp, ror #12
    10f4:	5f617369 	svcpl	0x00617369
    10f8:	5f746962 	svcpl	0x00746962
    10fc:	72697571 	rsbvc	r7, r9, #473956352	; 0x1c400000
    1100:	6f6e5f6b 	svcvs	0x006e5f6b
    1104:	6d73615f 	ldfvse	f6, [r3, #-380]!	; 0xfffffe84
    1108:	00757063 	rsbseq	r7, r5, r3, rrx
    110c:	5f617369 	svcpl	0x00617369
    1110:	5f746962 	svcpl	0x00746962
    1114:	766d7261 	strbtvc	r7, [sp], -r1, ror #4
    1118:	73690034 	cmnvc	r9, #52	; 0x34
    111c:	69625f61 	stmdbvs	r2!, {r0, r5, r6, r8, r9, sl, fp, ip, lr}^
    1120:	68745f74 	ldmdavs	r4!, {r2, r4, r5, r6, r8, r9, sl, fp, ip, lr}^
    1124:	32626d75 	rsbcc	r6, r2, #7488	; 0x1d40
    1128:	61736900 	cmnvs	r3, r0, lsl #18
    112c:	7469625f 	strbtvc	r6, [r9], #-607	; 0xfffffda1
    1130:	3865625f 	stmdacc	r5!, {r0, r1, r2, r3, r4, r6, r9, sp, lr}^
    1134:	61736900 	cmnvs	r3, r0, lsl #18
    1138:	7469625f 	strbtvc	r6, [r9], #-607	; 0xfffffda1
    113c:	6d72615f 	ldfvse	f6, [r2, #-380]!	; 0xfffffe84
    1140:	69003776 	stmdbvs	r0, {r1, r2, r4, r5, r6, r8, r9, sl, ip, sp}
    1144:	625f6173 	subsvs	r6, pc, #-1073741796	; 0xc000001c
    1148:	615f7469 	cmpvs	pc, r9, ror #8
    114c:	38766d72 	ldmdacc	r6!, {r1, r4, r5, r6, r8, sl, fp, sp, lr}^
    1150:	70667600 	rsbvc	r7, r6, r0, lsl #12
    1154:	7379735f 	cmnvc	r9, #2080374785	; 0x7c000001
    1158:	73676572 	cmnvc	r7, #478150656	; 0x1c800000
    115c:	636e655f 	cmnvs	lr, #398458880	; 0x17c00000
    1160:	6e69646f 	cdpvs	4, 6, cr6, cr9, cr15, {3}
    1164:	73690067 	cmnvc	r9, #103	; 0x67
    1168:	69625f61 	stmdbvs	r2!, {r0, r5, r6, r8, r9, sl, fp, ip, lr}^
    116c:	70665f74 	rsbvc	r5, r6, r4, ror pc
    1170:	6d663631 	stclvs	6, cr3, [r6, #-196]!	; 0xffffff3c
    1174:	4e47006c 	cdpmi	0, 4, cr0, cr7, cr12, {3}
    1178:	31432055 	qdaddcc	r2, r5, r3
    117c:	32312037 	eorscc	r2, r1, #55	; 0x37
    1180:	302e322e 	eorcc	r3, lr, lr, lsr #4
    1184:	616d2d20 	cmnvs	sp, r0, lsr #26
    1188:	2d206d72 	stccs	13, cr6, [r0, #-456]!	; 0xfffffe38
    118c:	6f6c666d 	svcvs	0x006c666d
    1190:	612d7461 			; <UNDEFINED> instruction: 0x612d7461
    1194:	683d6962 	ldmdavs	sp!, {r1, r5, r6, r8, fp, sp, lr}
    1198:	20647261 	rsbcs	r7, r4, r1, ror #4
    119c:	72616d2d 	rsbvc	r6, r1, #2880	; 0xb40
    11a0:	613d6863 	teqvs	sp, r3, ror #16
    11a4:	35766d72 	ldrbcc	r6, [r6, #-3442]!	; 0xfffff28e
    11a8:	662b6574 			; <UNDEFINED> instruction: 0x662b6574
    11ac:	672d2070 			; <UNDEFINED> instruction: 0x672d2070
    11b0:	20672d20 	rsbcs	r2, r7, r0, lsr #26
    11b4:	2d20672d 	stccs	7, cr6, [r0, #-180]!	; 0xffffff4c
    11b8:	2d20324f 	sfmcs	f3, 4, [r0, #-316]!	; 0xfffffec4
    11bc:	2d20324f 	sfmcs	f3, 4, [r0, #-316]!	; 0xfffffec4
    11c0:	2d20324f 	sfmcs	f3, 4, [r0, #-316]!	; 0xfffffec4
    11c4:	69756266 	ldmdbvs	r5!, {r1, r2, r5, r6, r9, sp, lr}^
    11c8:	6e69646c 	cdpvs	4, 6, cr6, cr9, cr12, {3}
    11cc:	696c2d67 	stmdbvs	ip!, {r0, r1, r2, r5, r6, r8, sl, fp, sp}^
    11d0:	63636762 	cmnvs	r3, #25690112	; 0x1880000
    11d4:	6e662d20 	cdpvs	13, 6, cr2, cr6, cr0, {1}
    11d8:	74732d6f 	ldrbtvc	r2, [r3], #-3439	; 0xfffff291
    11dc:	2d6b6361 	stclcs	3, cr6, [fp, #-388]!	; 0xfffffe7c
    11e0:	746f7270 	strbtvc	r7, [pc], #-624	; 11e8 <shift+0x11e8>
    11e4:	6f746365 	svcvs	0x00746365
    11e8:	662d2072 			; <UNDEFINED> instruction: 0x662d2072
    11ec:	692d6f6e 	pushvs	{r1, r2, r3, r5, r6, r8, r9, sl, fp, sp, lr}
    11f0:	6e696c6e 	cdpvs	12, 6, cr6, cr9, cr14, {3}
    11f4:	662d2065 	strtvs	r2, [sp], -r5, rrx
    11f8:	69736976 	ldmdbvs	r3!, {r1, r2, r4, r5, r6, r8, fp, sp, lr}^
    11fc:	696c6962 	stmdbvs	ip!, {r1, r5, r6, r8, fp, sp, lr}^
    1200:	683d7974 	ldmdavs	sp!, {r2, r4, r5, r6, r8, fp, ip, sp, lr}
    1204:	65646469 	strbvs	r6, [r4, #-1129]!	; 0xfffffb97
    1208:	7369006e 	cmnvc	r9, #110	; 0x6e
    120c:	69625f61 	stmdbvs	r2!, {r0, r5, r6, r8, r9, sl, fp, ip, lr}^
    1210:	75715f74 	ldrbvc	r5, [r1, #-3956]!	; 0xfffff08c
    1214:	5f6b7269 	svcpl	0x006b7269
    1218:	5f736561 	svcpl	0x00736561
    121c:	32343731 	eorscc	r3, r4, #12845056	; 0xc40000
    1220:	00383930 	eorseq	r3, r8, r0, lsr r9
    1224:	5f617369 	svcpl	0x00617369
    1228:	5f746962 	svcpl	0x00746962
    122c:	70746f64 	rsbsvc	r6, r4, r4, ror #30
    1230:	00646f72 	rsbeq	r6, r4, r2, ror pc
    1234:	20554e47 	subscs	r4, r5, r7, asr #28
    1238:	20373143 	eorscs	r3, r7, r3, asr #2
    123c:	312e3131 			; <UNDEFINED> instruction: 0x312e3131
    1240:	2d20302e 	stccs	0, cr3, [r0, #-184]!	; 0xffffff48
    1244:	6f6c666d 	svcvs	0x006c666d
    1248:	612d7461 			; <UNDEFINED> instruction: 0x612d7461
    124c:	683d6962 	ldmdavs	sp!, {r1, r5, r6, r8, fp, sp, lr}
    1250:	20647261 	rsbcs	r7, r4, r1, ror #4
    1254:	72616d2d 	rsbvc	r6, r1, #2880	; 0xb40
    1258:	6d2d206d 	stcvs	0, cr2, [sp, #-436]!	; 0xfffffe4c
    125c:	616f6c66 	cmnvs	pc, r6, ror #24
    1260:	62612d74 	rsbvs	r2, r1, #116, 26	; 0x1d00
    1264:	61683d69 	cmnvs	r8, r9, ror #26
    1268:	2d206472 	cfstrscs	mvf6, [r0, #-456]!	; 0xfffffe38
    126c:	6372616d 	cmnvs	r2, #1073741851	; 0x4000001b
    1270:	72613d68 	rsbvc	r3, r1, #104, 26	; 0x1a00
    1274:	7435766d 	ldrtvc	r7, [r5], #-1645	; 0xfffff993
    1278:	70662b65 	rsbvc	r2, r6, r5, ror #22
    127c:	20672d20 	rsbcs	r2, r7, r0, lsr #26
    1280:	20324f2d 	eorscs	r4, r2, sp, lsr #30
    1284:	6f6e662d 	svcvs	0x006e662d
    1288:	6975622d 	ldmdbvs	r5!, {r0, r2, r3, r5, r9, sp, lr}^
    128c:	6e69746c 	cdpvs	4, 6, cr7, cr9, cr12, {3}
    1290:	66662d20 	strbtvs	r2, [r6], -r0, lsr #26
    1294:	74636e75 	strbtvc	r6, [r3], #-3701	; 0xfffff18b
    1298:	2d6e6f69 	stclcs	15, cr6, [lr, #-420]!	; 0xfffffe5c
    129c:	74636573 	strbtvc	r6, [r3], #-1395	; 0xfffffa8d
    12a0:	736e6f69 	cmnvc	lr, #420	; 0x1a4
    12a4:	64662d20 	strbtvs	r2, [r6], #-3360	; 0xfffff2e0
    12a8:	2d617461 	cfstrdcs	mvd7, [r1, #-388]!	; 0xfffffe7c
    12ac:	74636573 	strbtvc	r6, [r3], #-1395	; 0xfffffa8d
    12b0:	736e6f69 	cmnvc	lr, #420	; 0x1a4
    12b4:	7a697300 	bvc	1a5debc <_bss_end+0x1a546d8>
    12b8:	00745f65 	rsbseq	r5, r4, r5, ror #30
    12bc:	67696c61 	strbvs	r6, [r9, -r1, ror #24]!
    12c0:	5f64656e 	svcpl	0x0064656e
    12c4:	72646461 	rsbvc	r6, r4, #1627389952	; 0x61000000
    12c8:	2f2e2e00 	svccs	0x002e2e00
    12cc:	2e2f2e2e 	cdpcs	14, 2, cr2, cr15, cr14, {1}
    12d0:	2e2e2f2e 	cdpcs	15, 2, cr2, cr14, cr14, {1}
    12d4:	2f2e2e2f 	svccs	0x002e2e2f
    12d8:	2e2f2e2e 	cdpcs	14, 2, cr2, cr15, cr14, {1}
    12dc:	2e2e2f2e 	cdpcs	15, 2, cr2, cr14, cr14, {1}
    12e0:	77656e2f 	strbvc	r6, [r5, -pc, lsr #28]!
    12e4:	2f62696c 	svccs	0x0062696c
    12e8:	6362696c 	cmnvs	r2, #108, 18	; 0x1b0000
    12ec:	7274732f 	rsbsvc	r7, r4, #-1140850688	; 0xbc000000
    12f0:	2f676e69 	svccs	0x00676e69
    12f4:	736d656d 	cmnvc	sp, #457179136	; 0x1b400000
    12f8:	632e7465 			; <UNDEFINED> instruction: 0x632e7465
    12fc:	75622f00 	strbvc	r2, [r2, #-3840]!	; 0xfffff100
    1300:	64646c69 	strbtvs	r6, [r4], #-3177	; 0xfffff397
    1304:	622f7269 	eorvs	r7, pc, #-1879048186	; 0x90000006
    1308:	646c6975 	strbtvs	r6, [ip], #-2421	; 0xfffff68b
    130c:	4955422f 	ldmdbmi	r5, {r0, r1, r2, r3, r5, r9, lr}^
    1310:	6e2f444c 	cdpvs	4, 2, cr4, cr15, cr12, {2}
    1314:	696c7765 	stmdbvs	ip!, {r0, r2, r5, r6, r8, r9, sl, ip, sp, lr}^
    1318:	2e342d62 	cdpcs	13, 3, cr2, cr4, cr2, {3}
    131c:	2f302e31 	svccs	0x00302e31
    1320:	6c697562 	cfstr64vs	mvdx7, [r9], #-392	; 0xfffffe78
    1324:	656e2d64 	strbvs	r2, [lr, #-3428]!	; 0xfffff29c
    1328:	62696c77 	rsbvs	r6, r9, #30464	; 0x7700
    132c:	6d72612f 	ldfvse	f6, [r2, #-188]!	; 0xffffff44
    1330:	6e6f6e2d 	cdpvs	14, 6, cr6, cr15, cr13, {1}
    1334:	61652d65 	cmnvs	r5, r5, ror #26
    1338:	612f6962 			; <UNDEFINED> instruction: 0x612f6962
    133c:	762f6d72 			; <UNDEFINED> instruction: 0x762f6d72
    1340:	2f657435 	svccs	0x00657435
    1344:	64726168 	ldrbtvs	r6, [r2], #-360	; 0xfffffe98
    1348:	77656e2f 	strbvc	r6, [r5, -pc, lsr #28]!
    134c:	2f62696c 	svccs	0x0062696c
    1350:	6362696c 	cmnvs	r2, #108, 18	; 0x1b0000
    1354:	7274732f 	rsbsvc	r7, r4, #-1140850688	; 0xbc000000
    1358:	00676e69 	rsbeq	r6, r7, r9, ror #28
    135c:	736d656d 	cmnvc	sp, #457179136	; 0x1b400000
    1360:	62007465 	andvs	r7, r0, #1694498816	; 0x65000000
    1364:	65666675 	strbvs	r6, [r6, #-1653]!	; 0xfffff98b
    1368:	Address 0x0000000000001368 is out of bounds.


Disassembly of section .comment:

00000000 <.comment>:
   0:	3a434347 	bcc	10d0d24 <_bss_end+0x10c7540>
   4:	65462820 	strbvs	r2, [r6, #-2080]	; 0xfffff7e0
   8:	61726f64 	cmnvs	r2, r4, ror #30
   c:	2e323120 	rsfcssp	f3, f2, f0
  10:	2d302e32 	ldccs	14, cr2, [r0, #-200]!	; 0xffffff38
  14:	63662e31 	cmnvs	r6, #784	; 0x310
  18:	20293633 	eorcs	r3, r9, r3, lsr r6
  1c:	322e3231 	eorcc	r3, lr, #268435459	; 0x10000003
  20:	4700302e 	strmi	r3, [r0, -lr, lsr #32]
  24:	203a4343 	eorscs	r4, sl, r3, asr #6
  28:	64654628 	strbtvs	r4, [r5], #-1576	; 0xfffff9d8
  2c:	2061726f 	rsbcs	r7, r1, pc, ror #4
  30:	312e3131 			; <UNDEFINED> instruction: 0x312e3131
  34:	322d302e 	eorcc	r3, sp, #46	; 0x2e
  38:	3363662e 	cmncc	r3, #48234496	; 0x2e00000
  3c:	31202936 			; <UNDEFINED> instruction: 0x31202936
  40:	2e312e31 	mrccs	14, 1, r2, cr1, cr1, {1}
  44:	Address 0x0000000000000044 is out of bounds.


Disassembly of section .ARM.attributes:

00000000 <.ARM.attributes>:
   0:	00003041 	andeq	r3, r0, r1, asr #32
   4:	61656100 	cmnvs	r5, r0, lsl #2
   8:	01006962 	tsteq	r0, r2, ror #18
   c:	00000026 	andeq	r0, r0, r6, lsr #32
  10:	4b5a3605 	blmi	168d82c <_bss_end+0x1684048>
  14:	08070600 	stmdaeq	r7, {r9, sl}
  18:	0a010901 	beq	42424 <_bss_end+0x38c40>
  1c:	14041202 	strne	r1, [r4], #-514	; 0xfffffdfe
  20:	17011501 	strne	r1, [r1, -r1, lsl #10]
  24:	1a011803 	bne	46038 <_bss_end+0x3c854>
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
  20:	8b040e42 	blhi	103930 <_bss_end+0xfa14c>
  24:	0b0d4201 	bleq	350830 <_bss_end+0x34704c>
  28:	420d0d54 	andmi	r0, sp, #84, 26	; 0x1500
  2c:	00000ecb 	andeq	r0, r0, fp, asr #29
  30:	0000001c 	andeq	r0, r0, ip, lsl r0
  34:	00000000 	andeq	r0, r0, r0
  38:	00008050 	andeq	r8, r0, r0, asr r0
  3c:	0000002c 	andeq	r0, r0, ip, lsr #32
  40:	8b040e42 	blhi	103950 <_bss_end+0xfa16c>
  44:	0b0d4201 	bleq	350850 <_bss_end+0x34706c>
  48:	420d0d4e 	andmi	r0, sp, #4992	; 0x1380
  4c:	00000ecb 	andeq	r0, r0, fp, asr #29
  50:	0000001c 	andeq	r0, r0, ip, lsl r0
  54:	00000000 	andeq	r0, r0, r0
  58:	0000807c 	andeq	r8, r0, ip, ror r0
  5c:	00000020 	andeq	r0, r0, r0, lsr #32
  60:	8b040e42 	blhi	103970 <_bss_end+0xfa18c>
  64:	0b0d4201 	bleq	350870 <_bss_end+0x34708c>
  68:	420d0d48 	andmi	r0, sp, #72, 26	; 0x1200
  6c:	00000ecb 	andeq	r0, r0, fp, asr #29
  70:	0000001c 	andeq	r0, r0, ip, lsl r0
  74:	00000000 	andeq	r0, r0, r0
  78:	0000809c 	muleq	r0, ip, r0
  7c:	00000018 	andeq	r0, r0, r8, lsl r0
  80:	8b040e42 	blhi	103990 <_bss_end+0xfa1ac>
  84:	0b0d4201 	bleq	350890 <_bss_end+0x3470ac>
  88:	420d0d44 	andmi	r0, sp, #68, 26	; 0x1100
  8c:	00000ecb 	andeq	r0, r0, fp, asr #29
  90:	0000001c 	andeq	r0, r0, ip, lsl r0
  94:	00000000 	andeq	r0, r0, r0
  98:	000080b4 	strheq	r8, [r0], -r4
  9c:	00000018 	andeq	r0, r0, r8, lsl r0
  a0:	8b040e42 	blhi	1039b0 <_bss_end+0xfa1cc>
  a4:	0b0d4201 	bleq	3508b0 <_bss_end+0x3470cc>
  a8:	420d0d44 	andmi	r0, sp, #68, 26	; 0x1100
  ac:	00000ecb 	andeq	r0, r0, fp, asr #29
  b0:	0000001c 	andeq	r0, r0, ip, lsl r0
  b4:	00000000 	andeq	r0, r0, r0
  b8:	000080cc 	andeq	r8, r0, ip, asr #1
  bc:	00000018 	andeq	r0, r0, r8, lsl r0
  c0:	8b040e42 	blhi	1039d0 <_bss_end+0xfa1ec>
  c4:	0b0d4201 	bleq	3508d0 <_bss_end+0x3470ec>
  c8:	420d0d44 	andmi	r0, sp, #68, 26	; 0x1100
  cc:	00000ecb 	andeq	r0, r0, fp, asr #29
  d0:	00000014 	andeq	r0, r0, r4, lsl r0
  d4:	00000000 	andeq	r0, r0, r0
  d8:	000080e4 	andeq	r8, r0, r4, ror #1
  dc:	0000000c 	andeq	r0, r0, ip
  e0:	8b040e42 	blhi	1039f0 <_bss_end+0xfa20c>
  e4:	0b0d4201 	bleq	3508f0 <_bss_end+0x34710c>
  e8:	0000000c 	andeq	r0, r0, ip
  ec:	ffffffff 			; <UNDEFINED> instruction: 0xffffffff
  f0:	7c020001 	stcvc	0, cr0, [r2], {1}
  f4:	000d0c0e 	andeq	r0, sp, lr, lsl #24
  f8:	0000001c 	andeq	r0, r0, ip, lsl r0
  fc:	000000e8 	andeq	r0, r0, r8, ror #1
 100:	000080f0 	strdeq	r8, [r0], -r0
 104:	00000034 	andeq	r0, r0, r4, lsr r0
 108:	8b040e42 	blhi	103a18 <_bss_end+0xfa234>
 10c:	0b0d4201 	bleq	350918 <_bss_end+0x347134>
 110:	420d0d52 	andmi	r0, sp, #5248	; 0x1480
 114:	00000ecb 	andeq	r0, r0, fp, asr #29
 118:	0000001c 	andeq	r0, r0, ip, lsl r0
 11c:	000000e8 	andeq	r0, r0, r8, ror #1
 120:	00008124 	andeq	r8, r0, r4, lsr #2
 124:	00000050 	andeq	r0, r0, r0, asr r0
 128:	8b080e42 	blhi	203a38 <_bss_end+0x1fa254>
 12c:	42018e02 	andmi	r8, r1, #2, 28
 130:	62040b0c 	andvs	r0, r4, #12, 22	; 0x3000
 134:	00080d0c 	andeq	r0, r8, ip, lsl #26
 138:	0000001c 	andeq	r0, r0, ip, lsl r0
 13c:	000000e8 	andeq	r0, r0, r8, ror #1
 140:	00008174 	andeq	r8, r0, r4, ror r1
 144:	00000054 	andeq	r0, r0, r4, asr r0
 148:	8b080e42 	blhi	203a58 <_bss_end+0x1fa274>
 14c:	42018e02 	andmi	r8, r1, #2, 28
 150:	64040b0c 	strvs	r0, [r4], #-2828	; 0xfffff4f4
 154:	00080d0c 	andeq	r0, r8, ip, lsl #26
 158:	0000001c 	andeq	r0, r0, ip, lsl r0
 15c:	000000e8 	andeq	r0, r0, r8, ror #1
 160:	000081c8 	andeq	r8, r0, r8, asr #3
 164:	00000044 	andeq	r0, r0, r4, asr #32
 168:	8b040e42 	blhi	103a78 <_bss_end+0xfa294>
 16c:	0b0d4201 	bleq	350978 <_bss_end+0x347194>
 170:	420d0d5a 	andmi	r0, sp, #5760	; 0x1680
 174:	00000ecb 	andeq	r0, r0, fp, asr #29
 178:	0000001c 	andeq	r0, r0, ip, lsl r0
 17c:	000000e8 	andeq	r0, r0, r8, ror #1
 180:	0000820c 	andeq	r8, r0, ip, lsl #4
 184:	0000003c 	andeq	r0, r0, ip, lsr r0
 188:	8b040e42 	blhi	103a98 <_bss_end+0xfa2b4>
 18c:	0b0d4201 	bleq	350998 <_bss_end+0x3471b4>
 190:	420d0d56 	andmi	r0, sp, #5504	; 0x1580
 194:	00000ecb 	andeq	r0, r0, fp, asr #29
 198:	0000001c 	andeq	r0, r0, ip, lsl r0
 19c:	000000e8 	andeq	r0, r0, r8, ror #1
 1a0:	00008248 	andeq	r8, r0, r8, asr #4
 1a4:	00000054 	andeq	r0, r0, r4, asr r0
 1a8:	8b080e42 	blhi	203ab8 <_bss_end+0x1fa2d4>
 1ac:	42018e02 	andmi	r8, r1, #2, 28
 1b0:	5e040b0c 	vmlapl.f64	d0, d4, d12
 1b4:	00080d0c 	andeq	r0, r8, ip, lsl #26
 1b8:	00000018 	andeq	r0, r0, r8, lsl r0
 1bc:	000000e8 	andeq	r0, r0, r8, ror #1
 1c0:	0000829c 	muleq	r0, ip, r2
 1c4:	0000001c 	andeq	r0, r0, ip, lsl r0
 1c8:	8b080e42 	blhi	203ad8 <_bss_end+0x1fa2f4>
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
 1f4:	8b040e42 	blhi	103b04 <_bss_end+0xfa320>
 1f8:	0b0d4201 	bleq	350a04 <_bss_end+0x347220>
 1fc:	420d0d52 	andmi	r0, sp, #5248	; 0x1480
 200:	00000ecb 	andeq	r0, r0, fp, asr #29
 204:	0000001c 	andeq	r0, r0, ip, lsl r0
 208:	000001d4 	ldrdeq	r0, [r0], -r4
 20c:	000082ec 	andeq	r8, r0, ip, ror #5
 210:	00000114 	andeq	r0, r0, r4, lsl r1
 214:	8b040e42 	blhi	103b24 <_bss_end+0xfa340>
 218:	0b0d4201 	bleq	350a24 <_bss_end+0x347240>
 21c:	0d0d8002 	stceq	0, cr8, [sp, #-8]
 220:	000ecb42 	andeq	ip, lr, r2, asr #22
 224:	0000001c 	andeq	r0, r0, ip, lsl r0
 228:	000001d4 	ldrdeq	r0, [r0], -r4
 22c:	00008400 	andeq	r8, r0, r0, lsl #8
 230:	00000074 	andeq	r0, r0, r4, ror r0
 234:	8b040e42 	blhi	103b44 <_bss_end+0xfa360>
 238:	0b0d4201 	bleq	350a44 <_bss_end+0x347260>
 23c:	420d0d72 	andmi	r0, sp, #7296	; 0x1c80
 240:	00000ecb 	andeq	r0, r0, fp, asr #29
 244:	0000001c 	andeq	r0, r0, ip, lsl r0
 248:	000001d4 	ldrdeq	r0, [r0], -r4
 24c:	00008474 	andeq	r8, r0, r4, ror r4
 250:	00000074 	andeq	r0, r0, r4, ror r0
 254:	8b040e42 	blhi	103b64 <_bss_end+0xfa380>
 258:	0b0d4201 	bleq	350a64 <_bss_end+0x347280>
 25c:	420d0d72 	andmi	r0, sp, #7296	; 0x1c80
 260:	00000ecb 	andeq	r0, r0, fp, asr #29
 264:	0000001c 	andeq	r0, r0, ip, lsl r0
 268:	000001d4 	ldrdeq	r0, [r0], -r4
 26c:	000084e8 	andeq	r8, r0, r8, ror #9
 270:	00000074 	andeq	r0, r0, r4, ror r0
 274:	8b040e42 	blhi	103b84 <_bss_end+0xfa3a0>
 278:	0b0d4201 	bleq	350a84 <_bss_end+0x3472a0>
 27c:	420d0d72 	andmi	r0, sp, #7296	; 0x1c80
 280:	00000ecb 	andeq	r0, r0, fp, asr #29
 284:	0000001c 	andeq	r0, r0, ip, lsl r0
 288:	000001d4 	ldrdeq	r0, [r0], -r4
 28c:	0000855c 	andeq	r8, r0, ip, asr r5
 290:	000000a0 	andeq	r0, r0, r0, lsr #1
 294:	8b080e42 	blhi	203ba4 <_bss_end+0x1fa3c0>
 298:	42018e02 	andmi	r8, r1, #2, 28
 29c:	02040b0c 	andeq	r0, r4, #12, 22	; 0x3000
 2a0:	080d0c4a 	stmdaeq	sp, {r1, r3, r6, sl, fp}
 2a4:	0000001c 	andeq	r0, r0, ip, lsl r0
 2a8:	000001d4 	ldrdeq	r0, [r0], -r4
 2ac:	000085fc 	strdeq	r8, [r0], -ip
 2b0:	00000074 	andeq	r0, r0, r4, ror r0
 2b4:	8b080e42 	blhi	203bc4 <_bss_end+0x1fa3e0>
 2b8:	42018e02 	andmi	r8, r1, #2, 28
 2bc:	74040b0c 	strvc	r0, [r4], #-2828	; 0xfffff4f4
 2c0:	00080d0c 	andeq	r0, r8, ip, lsl #26
 2c4:	0000001c 	andeq	r0, r0, ip, lsl r0
 2c8:	000001d4 	ldrdeq	r0, [r0], -r4
 2cc:	00008670 	andeq	r8, r0, r0, ror r6
 2d0:	000000d8 	ldrdeq	r0, [r0], -r8
 2d4:	8b080e42 	blhi	203be4 <_bss_end+0x1fa400>
 2d8:	42018e02 	andmi	r8, r1, #2, 28
 2dc:	02040b0c 	andeq	r0, r4, #12, 22	; 0x3000
 2e0:	080d0c66 	stmdaeq	sp, {r1, r2, r5, r6, sl, fp}
 2e4:	0000001c 	andeq	r0, r0, ip, lsl r0
 2e8:	000001d4 	ldrdeq	r0, [r0], -r4
 2ec:	00008748 	andeq	r8, r0, r8, asr #14
 2f0:	00000054 	andeq	r0, r0, r4, asr r0
 2f4:	8b080e42 	blhi	203c04 <_bss_end+0x1fa420>
 2f8:	42018e02 	andmi	r8, r1, #2, 28
 2fc:	5e040b0c 	vmlapl.f64	d0, d4, d12
 300:	00080d0c 	andeq	r0, r8, ip, lsl #26
 304:	00000018 	andeq	r0, r0, r8, lsl r0
 308:	000001d4 	ldrdeq	r0, [r0], -r4
 30c:	0000879c 	muleq	r0, ip, r7
 310:	0000001c 	andeq	r0, r0, ip, lsl r0
 314:	8b080e42 	blhi	203c24 <_bss_end+0x1fa440>
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
 340:	8b080e42 	blhi	203c50 <_bss_end+0x1fa46c>
 344:	42018e02 	andmi	r8, r1, #2, 28
 348:	02040b0c 	andeq	r0, r4, #12, 22	; 0x3000
 34c:	080d0c4c 	stmdaeq	sp, {r2, r3, r6, sl, fp}
 350:	00000020 	andeq	r0, r0, r0, lsr #32
 354:	00000320 	andeq	r0, r0, r0, lsr #6
 358:	0000885c 	andeq	r8, r0, ip, asr r8
 35c:	0000005c 	andeq	r0, r0, ip, asr r0
 360:	840c0e42 	strhi	r0, [ip], #-3650	; 0xfffff1be
 364:	8e028b03 	vmlahi.f64	d8, d2, d3
 368:	0b0c4201 	bleq	310b74 <_bss_end+0x307390>
 36c:	0d0c6804 	stceq	8, cr6, [ip, #-16]
 370:	0000000c 	andeq	r0, r0, ip
 374:	0000001c 	andeq	r0, r0, ip, lsl r0
 378:	00000320 	andeq	r0, r0, r0, lsr #6
 37c:	000088b8 			; <UNDEFINED> instruction: 0x000088b8
 380:	00000094 	muleq	r0, r4, r0
 384:	8b080e42 	blhi	203c94 <_bss_end+0x1fa4b0>
 388:	42018e02 	andmi	r8, r1, #2, 28
 38c:	02040b0c 	andeq	r0, r4, #12, 22	; 0x3000
 390:	080d0c40 	stmdaeq	sp, {r6, sl, fp}
 394:	0000001c 	andeq	r0, r0, ip, lsl r0
 398:	00000320 	andeq	r0, r0, r0, lsr #6
 39c:	0000894c 	andeq	r8, r0, ip, asr #18
 3a0:	00000074 	andeq	r0, r0, r4, ror r0
 3a4:	8b080e42 	blhi	203cb4 <_bss_end+0x1fa4d0>
 3a8:	42018e02 	andmi	r8, r1, #2, 28
 3ac:	74040b0c 	strvc	r0, [r4], #-2828	; 0xfffff4f4
 3b0:	00080d0c 	andeq	r0, r8, ip, lsl #26
 3b4:	0000001c 	andeq	r0, r0, ip, lsl r0
 3b8:	00000320 	andeq	r0, r0, r0, lsr #6
 3bc:	000089c0 	andeq	r8, r0, r0, asr #19
 3c0:	00000070 	andeq	r0, r0, r0, ror r0
 3c4:	8b080e42 	blhi	203cd4 <_bss_end+0x1fa4f0>
 3c8:	42018e02 	andmi	r8, r1, #2, 28
 3cc:	72040b0c 	andvc	r0, r4, #12, 22	; 0x3000
 3d0:	00080d0c 	andeq	r0, r8, ip, lsl #26
 3d4:	0000001c 	andeq	r0, r0, ip, lsl r0
 3d8:	00000320 	andeq	r0, r0, r0, lsr #6
 3dc:	00008a30 	andeq	r8, r0, r0, lsr sl
 3e0:	000000d4 	ldrdeq	r0, [r0], -r4
 3e4:	8b080e42 	blhi	203cf4 <_bss_end+0x1fa510>
 3e8:	42018e02 	andmi	r8, r1, #2, 28
 3ec:	02040b0c 	andeq	r0, r4, #12, 22	; 0x3000
 3f0:	080d0c5e 	stmdaeq	sp, {r1, r2, r3, r4, r6, sl, fp}
 3f4:	0000001c 	andeq	r0, r0, ip, lsl r0
 3f8:	00000320 	andeq	r0, r0, r0, lsr #6
 3fc:	00008b04 	andeq	r8, r0, r4, lsl #22
 400:	00000030 	andeq	r0, r0, r0, lsr r0
 404:	8b080e42 	blhi	203d14 <_bss_end+0x1fa530>
 408:	42018e02 	andmi	r8, r1, #2, 28
 40c:	52040b0c 	andpl	r0, r4, #12, 22	; 0x3000
 410:	00080d0c 	andeq	r0, r8, ip, lsl #26
 414:	0000001c 	andeq	r0, r0, ip, lsl r0
 418:	00000320 	andeq	r0, r0, r0, lsr #6
 41c:	00008b34 	andeq	r8, r0, r4, lsr fp
 420:	00000078 	andeq	r0, r0, r8, ror r0
 424:	8b080e42 	blhi	203d34 <_bss_end+0x1fa550>
 428:	42018e02 	andmi	r8, r1, #2, 28
 42c:	76040b0c 	strvc	r0, [r4], -ip, lsl #22
 430:	00080d0c 	andeq	r0, r8, ip, lsl #26
 434:	0000001c 	andeq	r0, r0, ip, lsl r0
 438:	00000320 	andeq	r0, r0, r0, lsr #6
 43c:	00008bac 	andeq	r8, r0, ip, lsr #23
 440:	00000054 	andeq	r0, r0, r4, asr r0
 444:	8b080e42 	blhi	203d54 <_bss_end+0x1fa570>
 448:	42018e02 	andmi	r8, r1, #2, 28
 44c:	5e040b0c 	vmlapl.f64	d0, d4, d12
 450:	00080d0c 	andeq	r0, r8, ip, lsl #26
 454:	00000018 	andeq	r0, r0, r8, lsl r0
 458:	00000320 	andeq	r0, r0, r0, lsr #6
 45c:	00008c00 	andeq	r8, r0, r0, lsl #24
 460:	0000001c 	andeq	r0, r0, ip, lsl r0
 464:	8b080e42 	blhi	203d74 <_bss_end+0x1fa590>
 468:	42018e02 	andmi	r8, r1, #2, 28
 46c:	00040b0c 	andeq	r0, r4, ip, lsl #22
 470:	0000000c 	andeq	r0, r0, ip
 474:	ffffffff 			; <UNDEFINED> instruction: 0xffffffff
 478:	7c020001 	stcvc	0, cr0, [r2], {1}
 47c:	000d0c0e 	andeq	r0, sp, lr, lsl #24
 480:	0000001c 	andeq	r0, r0, ip, lsl r0
 484:	00000470 	andeq	r0, r0, r0, ror r4
 488:	00008c1c 	andeq	r8, r0, ip, lsl ip
 48c:	0000005c 	andeq	r0, r0, ip, asr r0
 490:	8b040e42 	blhi	103da0 <_bss_end+0xfa5bc>
 494:	0b0d4201 	bleq	350ca0 <_bss_end+0x3474bc>
 498:	420d0d66 	andmi	r0, sp, #6528	; 0x1980
 49c:	00000ecb 	andeq	r0, r0, fp, asr #29
 4a0:	0000001c 	andeq	r0, r0, ip, lsl r0
 4a4:	00000470 	andeq	r0, r0, r0, ror r4
 4a8:	00008c78 	andeq	r8, r0, r8, ror ip
 4ac:	000000b4 	strheq	r0, [r0], -r4
 4b0:	8b040e42 	blhi	103dc0 <_bss_end+0xfa5dc>
 4b4:	0b0d4201 	bleq	350cc0 <_bss_end+0x3474dc>
 4b8:	0d0d5202 	sfmeq	f5, 4, [sp, #-8]
 4bc:	000ecb42 	andeq	ip, lr, r2, asr #22
 4c0:	0000001c 	andeq	r0, r0, ip, lsl r0
 4c4:	00000470 	andeq	r0, r0, r0, ror r4
 4c8:	00008d2c 	andeq	r8, r0, ip, lsr #26
 4cc:	00000174 	andeq	r0, r0, r4, ror r1
 4d0:	8b080e42 	blhi	203de0 <_bss_end+0x1fa5fc>
 4d4:	42018e02 	andmi	r8, r1, #2, 28
 4d8:	02040b0c 	andeq	r0, r4, #12, 22	; 0x3000
 4dc:	080d0cb4 	stmdaeq	sp, {r2, r4, r5, r7, sl, fp}
 4e0:	00000018 	andeq	r0, r0, r8, lsl r0
 4e4:	00000470 	andeq	r0, r0, r0, ror r4
 4e8:	00008ea0 	andeq	r8, r0, r0, lsr #29
 4ec:	00000118 	andeq	r0, r0, r8, lsl r1
 4f0:	8b080e42 	blhi	203e00 <_bss_end+0x1fa61c>
 4f4:	42018e02 	andmi	r8, r1, #2, 28
 4f8:	00040b0c 	andeq	r0, r4, ip, lsl #22
 4fc:	0000000c 	andeq	r0, r0, ip
 500:	ffffffff 			; <UNDEFINED> instruction: 0xffffffff
 504:	7c020001 	stcvc	0, cr0, [r2], {1}
 508:	000d0c0e 	andeq	r0, sp, lr, lsl #24
 50c:	0000001c 	andeq	r0, r0, ip, lsl r0
 510:	000004fc 	strdeq	r0, [r0], -ip
 514:	00008fb8 			; <UNDEFINED> instruction: 0x00008fb8
 518:	00000068 	andeq	r0, r0, r8, rrx
 51c:	8b040e42 	blhi	103e2c <_bss_end+0xfa648>
 520:	0b0d4201 	bleq	350d2c <_bss_end+0x347548>
 524:	420d0d68 	andmi	r0, sp, #104, 26	; 0x1a00
 528:	00000ecb 	andeq	r0, r0, fp, asr #29
 52c:	0000001c 	andeq	r0, r0, ip, lsl r0
 530:	000004fc 	strdeq	r0, [r0], -ip
 534:	00009020 	andeq	r9, r0, r0, lsr #32
 538:	00000058 	andeq	r0, r0, r8, asr r0
 53c:	8b080e42 	blhi	203e4c <_bss_end+0x1fa668>
 540:	42018e02 	andmi	r8, r1, #2, 28
 544:	62040b0c 	andvs	r0, r4, #12, 22	; 0x3000
 548:	00080d0c 	andeq	r0, r8, ip, lsl #26
 54c:	0000001c 	andeq	r0, r0, ip, lsl r0
 550:	000004fc 	strdeq	r0, [r0], -ip
 554:	00009078 	andeq	r9, r0, r8, ror r0
 558:	00000058 	andeq	r0, r0, r8, asr r0
 55c:	8b080e42 	blhi	203e6c <_bss_end+0x1fa688>
 560:	42018e02 	andmi	r8, r1, #2, 28
 564:	62040b0c 	andvs	r0, r4, #12, 22	; 0x3000
 568:	00080d0c 	andeq	r0, r8, ip, lsl #26
 56c:	0000000c 	andeq	r0, r0, ip
 570:	ffffffff 			; <UNDEFINED> instruction: 0xffffffff
 574:	7c010001 	stcvc	0, cr0, [r1], {1}
 578:	000d0c0e 	andeq	r0, sp, lr, lsl #24
 57c:	0000000c 	andeq	r0, r0, ip
 580:	0000056c 	andeq	r0, r0, ip, ror #10
 584:	000090d0 	ldrdeq	r9, [r0], -r0
 588:	000001ec 	andeq	r0, r0, ip, ror #3
 58c:	0000000c 	andeq	r0, r0, ip
 590:	ffffffff 			; <UNDEFINED> instruction: 0xffffffff
 594:	7c010001 	stcvc	0, cr0, [r1], {1}
 598:	000d0c0e 	andeq	r0, sp, lr, lsl #24
 59c:	0000000c 	andeq	r0, r0, ip
 5a0:	0000058c 	andeq	r0, r0, ip, lsl #11
 5a4:	000092dc 	ldrdeq	r9, [r0], -ip
 5a8:	00000220 	andeq	r0, r0, r0, lsr #4
 5ac:	0000000c 	andeq	r0, r0, ip
 5b0:	ffffffff 			; <UNDEFINED> instruction: 0xffffffff
 5b4:	7c020001 	stcvc	0, cr0, [r2], {1}
 5b8:	000d0c0e 	andeq	r0, sp, lr, lsl #24
 5bc:	00000034 	andeq	r0, r0, r4, lsr r0
 5c0:	000005ac 	andeq	r0, r0, ip, lsr #11
 5c4:	00009520 	andeq	r9, r0, r0, lsr #10
 5c8:	00000118 	andeq	r0, r0, r8, lsl r1
 5cc:	840c0e62 	strhi	r0, [ip], #-3682	; 0xfffff19e
 5d0:	8e028503 	cfsh32hi	mvfx8, mvfx2, #3
 5d4:	0e4e0201 	cdpeq	2, 4, cr0, cr14, cr1, {0}
 5d8:	cec5c400 	cdpgt	4, 12, cr12, cr5, cr0, {0}
 5dc:	840c0e50 	strhi	r0, [ip], #-3664	; 0xfffff1b0
 5e0:	8e028503 	cfsh32hi	mvfx8, mvfx2, #3
 5e4:	000e4401 	andeq	r4, lr, r1, lsl #8
 5e8:	44cec5c4 	strbmi	ip, [lr], #1476	; 0x5c4
 5ec:	03840c0e 	orreq	r0, r4, #3584	; 0xe00
 5f0:	018e0285 	orreq	r0, lr, r5, lsl #5

Disassembly of section .debug_line_str:

00000000 <.debug_line_str>:
   0:	6d6f682f 	stclvs	8, cr6, [pc, #-188]!	; ffffff4c <_bss_end+0xffff6768>
   4:	66632f65 	strbtvs	r2, [r3], -r5, ror #30
   8:	55435a2f 	strbpl	r5, [r3, #-2607]	; 0xfffff5d1
   c:	7269662f 	rsbvc	r6, r9, #49283072	; 0x2f00000
  10:	795f7473 	ldmdbvc	pc, {r0, r1, r4, r5, r6, sl, ip, sp, lr}^	; <UNPREDICTABLE>
  14:	2f726165 	svccs	0x00726165
  18:	746e6977 	strbtvc	r6, [lr], #-2423	; 0xfffff689
  1c:	4f2f7265 	svcmi	0x002f7265
  20:	72702f53 	rsbsvc	r2, r0, #332	; 0x14c
  24:	69746361 	ldmdbvs	r4!, {r0, r5, r6, r8, r9, sp, lr}^
  28:	2f6c6163 	svccs	0x006c6163
  2c:	2f337865 	svccs	0x00337865
  30:	6c697562 	cfstr64vs	mvdx7, [r9], #-392	; 0xfffffe78
  34:	682f0064 	stmdavs	pc!, {r2, r5, r6}	; <UNPREDICTABLE>
  38:	2f656d6f 	svccs	0x00656d6f
  3c:	5a2f6663 	bpl	bd99d0 <_bss_end+0xbd01ec>
  40:	662f5543 	strtvs	r5, [pc], -r3, asr #10
  44:	74737269 	ldrbtvc	r7, [r3], #-617	; 0xfffffd97
  48:	6165795f 	cmnvs	r5, pc, asr r9
  4c:	69772f72 	ldmdbvs	r7!, {r1, r4, r5, r6, r8, r9, sl, fp, sp}^
  50:	7265746e 	rsbvc	r7, r5, #1845493760	; 0x6e000000
  54:	2f534f2f 	svccs	0x00534f2f
  58:	63617270 	cmnvs	r1, #112, 4
  5c:	61636974 	smcvs	13972	; 0x3694
  60:	78652f6c 	stmdavc	r5!, {r2, r3, r5, r6, r8, r9, sl, fp, sp}^
  64:	656b2f33 	strbvs	r2, [fp, #-3891]!	; 0xfffff0cd
  68:	6c656e72 	stclvs	14, cr6, [r5], #-456	; 0xfffffe38
  6c:	6372732f 	cmnvs	r2, #-1140850688	; 0xbc000000
  70:	61747300 	cmnvs	r4, r0, lsl #6
  74:	732e7472 			; <UNDEFINED> instruction: 0x732e7472
  78:	2f2e2e00 	svccs	0x002e2e00
  7c:	2e2f2e2e 	cdpcs	14, 2, cr2, cr15, cr14, {1}
  80:	2e2e2f2e 	cdpcs	15, 2, cr2, cr14, cr14, {1}
  84:	2f2e2e2f 	svccs	0x002e2e2f
  88:	672f2e2e 	strvs	r2, [pc, -lr, lsr #28]!
  8c:	312d6363 			; <UNDEFINED> instruction: 0x312d6363
  90:	2e322e32 	mrccs	14, 1, r2, cr2, cr2, {1}
  94:	696c2f30 	stmdbvs	ip!, {r4, r5, r8, r9, sl, fp, sp}^
  98:	63636762 	cmnvs	r3, #25690112	; 0x1880000
  9c:	6e6f632f 	cdpvs	3, 6, cr6, cr15, cr15, {1}
  a0:	2f676966 	svccs	0x00676966
  a4:	006d7261 	rsbeq	r7, sp, r1, ror #4
  a8:	3162696c 	cmncc	r2, ip, ror #18
  ac:	636e7566 	cmnvs	lr, #427819008	; 0x19800000
  b0:	00532e73 	subseq	r2, r3, r3, ror lr

Disassembly of section .debug_loclists:

00000000 <.debug_loclists>:
   0:	000001f7 	strdeq	r0, [r0], -r7
   4:	00040005 	andeq	r0, r4, r5
	...
  14:	20060000 	andcs	r0, r6, r0
  18:	04000095 	streq	r0, [r0], #-149	; 0xffffff6b
  1c:	0101cc00 	tsteq	r1, r0, lsl #24
  20:	01cc0451 	biceq	r0, ip, r1, asr r4
  24:	a30401e0 	movwge	r0, #16864	; 0x41e0
  28:	049f5101 	ldreq	r5, [pc], #257	; 30 <shift+0x30>
  2c:	01ec01e0 	mvneq	r0, r0, ror #3
  30:	ec045101 	stfs	f5, [r4], {1}
  34:	04028001 	streq	r8, [r2], #-1
  38:	9f5101a3 	svcls	0x005101a3
  3c:	98028004 	stmdals	r2, {r2, pc}
  40:	00510102 	subseq	r0, r1, r2, lsl #2
	...
  4c:	00000001 	andeq	r0, r0, r1
  50:	00010100 	andeq	r0, r1, r0, lsl #2
  54:	20060000 	andcs	r0, r6, r0
  58:	04000095 	streq	r0, [r0], #-149	; 0xffffff6b
  5c:	52011000 	andpl	r1, r1, #0
  60:	01201004 			; <UNDEFINED> instruction: 0x01201004
  64:	24200452 	strtcs	r0, [r0], #-1106	; 0xfffffbae
  68:	9f7f7203 	svcls	0x007f7203
  6c:	012c2404 			; <UNDEFINED> instruction: 0x012c2404
  70:	382c0452 	stmdacc	ip!, {r1, r4, r6, sl}
  74:	9f7f7203 	svcls	0x007f7203
  78:	a0019c04 	andge	r9, r1, r4, lsl #24
  7c:	04520101 	ldrbeq	r0, [r2], #-257	; 0xfffffeff
  80:	01c001c0 	biceq	r0, r0, r0, asr #3
  84:	c0045201 	andgt	r5, r4, r1, lsl #4
  88:	0301d001 	movweq	sp, #4097	; 0x1001
  8c:	049f7f72 	ldreq	r7, [pc], #3954	; 94 <shift+0x94>
  90:	02900280 	addseq	r0, r0, #128, 4
  94:	02005201 	andeq	r5, r0, #268435456	; 0x10000000
  98:	02020000 	andeq	r0, r2, #0
  9c:	00000000 	andeq	r0, r0, r0
  a0:	00000101 	andeq	r0, r0, r1, lsl #2
  a4:	00000101 	andeq	r0, r0, r1, lsl #2
  a8:	00000000 	andeq	r0, r0, r0
  ac:	95200600 	strls	r0, [r0, #-1536]!	; 0xfffffa00
  b0:	00040000 	andeq	r0, r4, r0
  b4:	04500120 	ldrbeq	r0, [r0], #-288	; 0xfffffee0
  b8:	53012c20 	movwpl	r2, #7200	; 0x1c20
  bc:	03302c04 	teqeq	r0, #4, 24	; 0x400
  c0:	049f0173 	ldreq	r0, [pc], #371	; c8 <shift+0xc8>
  c4:	0101a430 	tsteq	r1, r0, lsr r4
  c8:	01c00453 	biceq	r0, r0, r3, asr r4
  cc:	530101d0 	movwpl	r0, #4560	; 0x11d0
  d0:	d401d004 	strle	sp, [r1], #-4
  d4:	01730301 	cmneq	r3, r1, lsl #6
  d8:	01d4049f 			; <UNDEFINED> instruction: 0x01d4049f
  dc:	530101f0 	movwpl	r0, #4592	; 0x11f0
  e0:	f401f004 	vst4.8	{d15-d18}, [r1], r4
  e4:	01730301 	cmneq	r3, r1, lsl #6
  e8:	01f4049f 			; <UNDEFINED> instruction: 0x01f4049f
  ec:	53010284 	movwpl	r0, #4740	; 0x1284
  f0:	90028804 	andls	r8, r2, r4, lsl #16
  f4:	04500102 	ldrbeq	r0, [r0], #-258	; 0xfffffefe
  f8:	02980290 	addseq	r0, r8, #144, 4
  fc:	01005301 	tsteq	r0, r1, lsl #6
 100:	00000000 	andeq	r0, r0, r0
 104:	95740600 	ldrbls	r0, [r4, #-1536]!	; 0xfffffa00
 108:	00040000 	andeq	r0, r4, r0
 10c:	0803018c 	stmdaeq	r3, {r2, r3, r7, r8}
 110:	ac049f20 	stcge	15, cr9, [r4], {32}
 114:	0301b401 	movweq	fp, #5121	; 0x1401
 118:	049f2008 	ldreq	r2, [pc], #8	; 120 <shift+0x120>
 11c:	01c401bc 	strheq	r0, [r4, #28]
 120:	9f200803 	svcls	0x00200803
 124:	00000000 	andeq	r0, r0, r0
 128:	06000000 	streq	r0, [r0], -r0
 12c:	0000956c 	andeq	r9, r0, ip, ror #10
 130:	01940004 	orrseq	r0, r4, r4
 134:	b4045e01 	strlt	r5, [r4], #-3585	; 0xfffff1ff
 138:	0101bc01 	tsteq	r1, r1, lsl #24
 13c:	01c4045e 	biceq	r0, r4, lr, asr r4
 140:	5e0101cc 	adfpldm	f0, f1, #4.0
 144:	01000100 	mrseq	r0, (UNDEF: 16)
 148:	01010101 	tsteq	r1, r1, lsl #2
 14c:	00000101 	andeq	r0, r0, r1, lsl #2
 150:	00000000 	andeq	r0, r0, r0
 154:	00000101 	andeq	r0, r0, r1, lsl #2
 158:	00000000 	andeq	r0, r0, r0
 15c:	95680600 	strbls	r0, [r8, #-1536]!	; 0xfffffa00
 160:	00040000 	andeq	r0, r4, r0
 164:	04530128 	ldrbeq	r0, [r3], #-296	; 0xfffffed8
 168:	7c032c28 	stcvc	12, cr2, [r3], {40}	; 0x28
 16c:	2c049f74 	stccs	15, cr9, [r4], {116}	; 0x74
 170:	787c0330 	ldmdavc	ip!, {r4, r5, r8, r9}^
 174:	3430049f 	ldrtcc	r0, [r0], #-1183	; 0xfffffb61
 178:	9f7c7c03 	svcls	0x007c7c03
 17c:	013c3404 	teqeq	ip, r4, lsl #8
 180:	483c045c 	ldmdami	ip!, {r2, r3, r4, r6, sl}
 184:	9f707c03 	svcls	0x00707c03
 188:	01585404 	cmpeq	r8, r4, lsl #8
 18c:	6868045c 	stmdavs	r8!, {r2, r3, r4, r6, sl}^
 190:	68045c01 	stmdavs	r4, {r0, sl, fp, ip, lr}
 194:	047c036c 	ldrbteq	r0, [ip], #-876	; 0xfffffc94
 198:	986c049f 	stmdals	ip!, {r0, r1, r2, r3, r4, r7, sl}^
 19c:	045c0101 	ldrbeq	r0, [ip], #-257	; 0xfffffeff
 1a0:	01c001b8 	strheq	r0, [r0, #24]
 1a4:	c8045c01 	stmdagt	r4, {r0, sl, fp, ip, lr}
 1a8:	0101d001 	tsteq	r1, r1
 1ac:	00000053 	andeq	r0, r0, r3, asr r0
	...
 1b8:	00952406 	addseq	r2, r5, r6, lsl #8
 1bc:	c8000400 	stmdagt	r0, {sl}
 1c0:	00710601 	rsbseq	r0, r1, r1, lsl #12
 1c4:	9f1aff08 	svcls	0x001aff08
 1c8:	dc01c804 	stcle	8, cr12, [r1], {4}
 1cc:	01a30701 			; <UNDEFINED> instruction: 0x01a30701
 1d0:	1aff0851 	bne	fffc231c <_bss_end+0xfffb8b38>
 1d4:	01dc049f 			; <UNDEFINED> instruction: 0x01dc049f
 1d8:	710601e8 	smlattvc	r6, r8, r1, r0
 1dc:	1aff0800 	bne	fffc21e4 <_bss_end+0xfffb8a00>
 1e0:	01e8049f 			; <UNDEFINED> instruction: 0x01e8049f
 1e4:	a30701fc 	movwge	r0, #29180	; 0x71fc
 1e8:	ff085101 			; <UNDEFINED> instruction: 0xff085101
 1ec:	fc049f1a 	stc2	15, cr9, [r4], {26}
 1f0:	06029401 	streq	r9, [r2], -r1, lsl #8
 1f4:	ff080071 			; <UNDEFINED> instruction: 0xff080071
 1f8:	Address 0x00000000000001f8 is out of bounds.


Disassembly of section .debug_rnglists:

00000000 <.debug_rnglists>:
   0:	00000010 	andeq	r0, r0, r0, lsl r0
   4:	00040005 	andeq	r0, r4, r5
   8:	00000000 	andeq	r0, r0, r0
   c:	00952007 	addseq	r2, r5, r7
  10:	00029800 	andeq	r9, r2, r0, lsl #16
