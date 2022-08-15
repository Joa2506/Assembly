;---------------------------------------------------
; TITLE: uppercase.asm 
; DATE: 15th og Augusut 2022
; AUTHOR: Joakim Foss Johansen
;
;---------------------------------------------------
; INSTRUCTIONS
; For make file
;   uppercase: uppercase.o
;	    ld -m elf_i386 -o uppercase uppercase.o
;   uppercase.o: uppercase.asm
;	    nasm -f elf -g -F stabs uppercase.asm -l uppercase.lst
; Execute
;    ./uppercase > uppercase.txt < lowercase.txt
;
;---------------------------------------------------

;READ:
;   - Set up register for sys_read kernel call
;   - Call sys_read to read from stdin
;   - Test EOF
;   - If EOF jmp exit
;   - Put address of buffer into ebp
;   - Put the number of characters read into the buffer at ecx

;Scan: 
;   -Compare the byte at [ebp+ecx] against 'a'
;   -If byte is below 'a' in the ASCII table, jump to Next
;   -Compate byte at [ebp+ecx] agains 'z'
;   If the byte is above 'z' in the ASCII table, jump to Next
;   -Subtract 20h from the byte at [ebp+ecx]

;Next
;   Devcrement ecx by one
;   jump if not zero to Scan
;Write:
;   - Set up register for sys_write kernel call
;   - Call sys_call to write from stdout
;   - Jump back to read and get new character

;Exit:
;   -Set up registers for terminating via sys_exit.
;   -Cal sys_exit

section .bss
    BUFFLEN equ 1024 ;Length of buffer is 1024bytes
    Buff resb BUFFLEN

section .data

section .text
    global _start:

_start:
    nop
    
;READ FUNCTION
Read:
    mov eax, 3              ;Specify read syscall
    mov ebx, 0              ;Specify file descriptor stdin
    mov ecx, Buff           ;Pass address of buffer to read to
    mov edx, BUFFLEN        ;Tel sys_read to read one char from stdin
    int 80h                 ;Call sys_read
    mov esi, eax            ;Copy sys_read return value for safekeeping
    cmp eax, 0              ;Look for EOF in sysreads return value
    je Exit                 ;If equal jump to exit

;Set up the registers for the process buffer step
    mov ecx, esi            ;Place the number of bytes read into ecx
    mov ebp, Buff           ;Place address of buffer into ebp
    dec ebp                 ;Decrement ebp to adjust the count to offset


;Go through the buffer and convert lowercase to uppercase:
Scan:
    cmp byte [ebp+ecx], 61h    ;Test input char to lowercase 'a'
    jb Next                ;If below 'a' in ASCII chart it is not a lower case
    cmp byte [ebp+ecx], 7Ah    ;Test char agains lowercase 'z'
    ja Next                ;If above 'z' in ASCII it is an uppecarcase character
    sub byte [ebp+ecx], 20h    ;Subtract 20h from lowercase to get upercase

;NEXT FUNCTION
Next:
    dec ecx
    jnz Scan
;WRITE FUNCTION
Write:
    mov eax, 4              ;Specify write syscall
    mov ebx, 1              ;Specify file descriptor stdin
    mov ecx, Buff           ;Pass address of character to write
    mov edx, esi            ;Pass number of bytes to write
    int 80h                 ;Call sys_write
    jmp Read
;Exit safely
Exit:
    mov eax, 1              ;Specify exit syscall
    mov ebx, 0              ;Specify exit code 0
    int 80h                 ;Make kernel call