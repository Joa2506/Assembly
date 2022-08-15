SECTION .data


SECTION .bss

SECTION .text
    global _start

_start:


;Moving between binaries on 2's complement between 16 bit register and 32 bit register
16_to_32_bit:

    ;This wil result in a move of -42(11010110) in two's complement being moved from 16 bit to 32 bit. 
    ;The binaries are moved as is, but the sign bit is not active. Which means we get 1111111111010110==65494 (There are 16 0s before the binaries)
    
    mov ax, -42 ;Moving-42 into ax
    mov ebx, eax ;moving eax into ebx. ax are the lower two bytes of eax

    ;This will work
    mov ax, -42
    movsx ebx, ax ;movsx can move between 8-bit to 16-bit, 16-bit to 32-bit and 8-bit to 32-bit
                  ;sx stands for sign extension

multiply: ;Multiplies with itself
    mov eax, 42
    mul eax
divide:
    
