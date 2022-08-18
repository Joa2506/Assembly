;Continue pdf page 343 (279 book page) 
section .bss
    Count: equ 0
section .data

    EatMsg: db "Eat at Joe's", 10 ;10 is new line 0Ah
    EatLen: equ $-EatMsg ;$ means here
    Snippet: db "KANGAROO\n", 0Ah
    SnippetLen: equ $-Snippet ;This expression means to equate from the end address referenced by $ and subtract the start address reference by Snippet (End-Beginning) which gives the string length
    magicNumber: equ 42 ;The Answer to the Ultimate Question of Life, the Universe, and Everything
section .text

    global _start

_start:
    nop
    ;Sandbox code between here
    
    mov eax, SnippetLen
    mov r8, 0
Print:
    mov esi, eax
    mov eax, 4
    mov ebx, 1
    mov ecx, Snippet + Count
    mov edx, 1

    int 80h
    dec esi
    mov eax, esi
    jnz Print
    jz Exit

    ;And here
;--------------------------------------------
    ;Safe exit
;--------------------------------------------
Exit:
    mov eax, 1 ; Specify Exit syscall
    mov ebx, 0 ; Return code zero
    int 80h
;--------------------------------------------

   nop

section .bss
