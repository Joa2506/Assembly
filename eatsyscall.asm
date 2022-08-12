;Executable name : EATSYSCALL
;
; Build using this commangd
; nasm -f elf -g -F stabs eatsyscall.asm
; ld -p eatsyscall eatsyscall.o
; for running in 32 bits use ld ld -m elf_i386 -o eatsyscall eatsyscall.o


SECTION .data ;Section containing initialised data

EatMsg: db "Eat at Joe's", 10
EatLen: equ $-EatMsg

SECTION .bss ;Section containing uninitialised data
SECTION .text ; Section containing code

global _start ;Linked needs this for entry point

_start:
    nop ; This is no-op, keeps gdb happy
    mov eax, 4 ;4 is syscall to write (sys_write)
    mov ebx, 1 ;Specify File Descriptor 1: Standard output
    mov ecx, EatMsg ; Pass offset of the message
    mov edx, EatLen ; Pass length of message
    int 80h ; Make the syscall to output the text to stdout

    mov eax, 1 ; Specify Exit syscall
    mov ebx, 0 ; Return code zero
    int 80h
