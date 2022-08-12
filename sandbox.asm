;Continue pdf page 273 (237 book page) 
section .data

    EatMsg: db "Eat at Joe's", 10 ;10 is new line 0Ah
    EatLen: equ $-EatMsg
    Snippet: db "KANGAROO", 0Ah
    magicNumber: dw 42 ;The Answer to the Ultimate Question of Life, the Universe, and Everything
    magicLen: equ $-magicNumber; This is 2 bytes in length
section .text

    global _start

_start:
    nop
    ;Sandbox code between here

    ;And here
   ;Safe exit
   mov eax, [magicNumber]
   mul eax

   nop

section .bss
