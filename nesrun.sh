#! /usr/bin/bash
echo "compiling "$1
ca65 "src/"$1".asm"
echo "compiling reset"
ca65 src/reset.asm
echo "compiling assembly ok"
echo "linking .nes file..."
ld65 src/reset.o "src/"$1".o" -C nes.cfg -o $1".nes"
echo ".nes file ok"
echo "running emulator..."
/c/cc65/fceux/fceux.exe $1".nes"
