#! /usr/bin/bash
ca65 $1".asm"
echo "compiled .o file"
ld65 $1".o" -t nes -o $1".nes"
echo "compiled .nes file"
/c/cc65/fceux/fceux.exe $1".nes"
