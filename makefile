all: sandbox uppercase hexdump
sandbox: sandbox.o
	ld -m elf_i386 -o sandbox sandbox.o
sandbox.o: sandbox.asm
	nasm -f elf -g -F stabs sandbox.asm -l sandbox.lst
clean:
	rm -f *.o sandbox hexdump uppercase *.lst
uppercase: uppercase.o
	ld -m elf_i386 -o uppercase uppercase.o
uppercase.o: uppercase.asm
	nasm -f elf -g -F stabs uppercase.asm -l uppercase.lst
hexdump: hexdump.o
	ld -m elf_i386 -o hexdump hexdump.o
hexdump.o: hexdump.asm
	nasm -f elf -g -F stabs hexdump.asm -l hexdump.lst