#! /usr/bin/bash
echo "compiling .o file..."
ca65 $1".asm"
echo ".o file ok"
echo "compiling .nes file..."
ld65 $1".o" -t nes -o $1".nes"
echo ".nes file ok"
echo "running emulator..."
/c/cc65/fceux/fceux.exe $1".nes"
