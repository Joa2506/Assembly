;Continue pdf page 315 (279 book page) 
section .data

    EatMsg: db "Eat at Joe's", 10 ;10 is new line 0Ah
    EatLen: equ $-EatMsg ;$ means here
    Snippet: db "KANGAROO", 0Ah
    SnippetLen: equ $-Snippet ;This expression means to equate from the end address referenced by $ and subtract the start address reference by Snippet (End-Beginning) which gives the string length
    magicNumber: equ 42 ;The Answer to the Ultimate Question of Life, the Universe, and Everything
    magicLen: equ $-magicNumber; This is 2 bytes in length
section .text

    global _start

_start:
    nop
    ;Sandbox code between here
    
    mov eax, magicNumber
    mul eax


    ;And here
;--------------------------------------------
    ;Safe exit
;--------------------------------------------
    mov eax, 1 ; Specify Exit syscall
    mov ebx, 0 ; Return code zero
    int 80h
;--------------------------------------------

   nop

section .bss
