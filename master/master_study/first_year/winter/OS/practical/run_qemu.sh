#!/bin/bash

/home/cf/ZCU/OS/practical/qemu/build/qemu-system-arm -machine raspi0 -serial null -serial mon:stdio -kernel ~/ZCU/OS/practical/ex4_5/build/kernel.img -nographic -gdb tcp::1234 -S
#./qemu-system-arm -machine raspi0 -serial null -serial mon:stdio -kernel ~/ZCU/OS/practical/ex3/build/kernel.img -nographic -gdb tcp::1234 -S
