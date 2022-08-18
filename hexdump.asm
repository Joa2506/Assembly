;---------------------------------------------------
; TITLE: uppercase.asm 
; DATE: 16th og Augusut 2022
; AUTHOR: Joakim Foss Johansen
;---------------------------------------------------
;Demonstrates the conversion of binary values to a hexadecimal string
;
;---------------------------------------------------
; INSTRUCTIONS
; For make file
;   hexdump: hexdump.o
;	    ld -m elf_i386 -o hexdump hexdump.o
;   hexdump.o: hexdump.asm
;	    nasm -f elf -g -F stabs hexdump.asm -l hexdump.lst
; Execute
;    ./hexdump
;
;---------------------------------------------------
section .bss
    BUFFLEN: equ 16 ;16 bytes buffer length
    Buff: resb BUFFLEN ;The text buffer
section .data
    HexStr: db "  00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00", 10
    HEXLEN: equ $-HexStr

    Digits: db '0123456789ABCDEF'

section .text
global _start
_start:
    nop
; Reads a buffer full of text from stdin
; Read
; Read from stdin similar to uppercase.asm
;
Read:
    mov eax, 3 ;Define syscall_read
    mov ebx, 0 ;0 Is stdout
    mov ecx, Buff ;Pass offset of the buffer to read to
    mov edx, BUFFLEN; Pass number of bytes to read at one pass through
    int 80h ;Call sys_read to fill buffer
    mov ebp, eax; Save number of bytes read from file to later
    cmp eax, 0;If eax = 0, we have reache EOF on stdin
    je Exit

;Set up registers for the process buffer step.
    mov esi, Buff ;Place address of file buffer into source index register: used as a pointer to a source in stream operations
    mov edi, HexStr ;Place address of line string into destination index register: used as a pointer to destination in stream operations
    xor ecx, ecx ;Clear line string pointer

;Go through the buffer to convert the binary values to hex digit
Scan:
    xor eax, eax ;Clear eax
;Calculate value of the offset into HexStr, which is the value in ecx x 3
    mov edx, ecx ;Copy character counter into edx (Data register)
    shl edx, 1 ;Multiply pointer by 2 using left shift operator
    add edx, ecx ;Complete multiplication x3

;Get character from buffer and put it in both eax and ebx
    mov al, byte [esi+ecx] ;Put a byte from input buffer into al 
    mov ebx, eax ;Duplicate byte in bl for second nyble

;Look up low nyble character and insert it into string
    and al, 0Fh ;Mask out al low nyble
    mov al, byte [Digits + eax] ;Look up the char equivalent of a nyble
    mov byte [HexStr+edx+2], al ;Write LSB char digit to string 

;Look up high nyble character and insert it into string
    shr bl,4 ;Shift high 4 bits of characters into low 4 bits
    mov bl, byte [Digits+ebx] ;Look up the char equivalent of the nyble
    mov byte [HexStr+edx+1], bl ;Write MSB char digit to line string

;Bump the buffer pointer to the next character and insert it into the string
    inc ecx ;Increment line index by 1 (Line string pointer)
    cmp ecx, ebp ;Compare to the number of chars in the buffer
    jna Scan ;Loop back if ecx <= number of chars in buffer

;Write the number of hexadecimal values to stdout
    mov eax, 4 ;Specify sys_write syscall
    mov ebx, 1 ;Specify File descriptor 1 stdoutput
    mov ecx, HexStr ;Pass offset of line string
    mov edx, HEXLEN ;Pass number of bytes of the line string
    int 80h ;Make kernel call to display string
    jmp Read

;Exit
Exit:
    mov eax, 1 ;Specify syscall exit
    mov ebx, 0 ;Exit code 0
    int 80h ;Call sys_exit