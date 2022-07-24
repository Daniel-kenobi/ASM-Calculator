nasm -f elf64 Calculator.asm 
ld -s -o Calculator Calculator.o
./Calculator