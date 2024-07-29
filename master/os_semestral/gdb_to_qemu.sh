#!/bin/bash

gdb -ex 'set architecture arm' -ex 'file sources/build/kernel' -ex 'target remote tcp:localhost:1234' -ex 'layout regs' -ex 'add-symbol-file sources/userspace/build/glucose_task'
