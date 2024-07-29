#!/bin/bash

../qemu/build/qemu-system-arm -machine raspi0 -serial null -serial mon:stdio -kernel sources/build/kernel.img -nographic -gdb tcp::1234 -S
#../qemu/build/qemu-system-arm -machine raspi0 -serial null -serial mon:stdio -kernel ~/ZCU/OS/uart_testing/sources/build/kernel.img -nographic -gdb tcp::1234 -S
