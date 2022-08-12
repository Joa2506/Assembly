SECTION .data

    kangaroo: db "KANGAROO", 0Ah ;Is 10 in decimal and new line
    kangarooLen: equ $-kangaroo ;Length of kangaroo 
SECTION .bss

SECTION .text

global _start

_start:

    mov ebx, kangaroo ;Move kangaroo to ebx
    mov eax, 8 ;Add counter value to eax
lowercase:
    add byte [ebx], 32 ;Putting ebx in bracket means to work on the content rather then the address. Adding 32 to an upper case ASCII will give the same letter in lowercase
    inc ebx ;Inc ebx
    dec eax ;decrement counter
    jnz lowercase ;Jump back as long as zero

    mov ecx, kangaroo ;snippet moved to ECX
    mov edx, kangarooLen ;move 0 bytes to EDX
    mov eax, 4 ;Syscall 4 is write
    mov ebx, 1 ;Filedescriptor 1 is stdout
    int 80h ;Interrupt to do syscall


    ;Exit with code 1
    mov eax, 1 
    mov ebx, 0
    int 80h

