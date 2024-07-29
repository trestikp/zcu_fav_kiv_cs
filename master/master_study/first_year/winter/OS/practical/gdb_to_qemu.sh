#!/bin/bash

gdb -ex 'set architecture arm' -ex 'file kernel' -ex 'target remote tcp:localhost:1234' -ex 'layout regs'
