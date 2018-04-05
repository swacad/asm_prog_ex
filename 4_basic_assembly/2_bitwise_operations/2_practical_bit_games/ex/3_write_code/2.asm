; Basic Assembly
; ==============
; 
; Bitwise operations - Practical bit games
; ----------------------------------------
; 2.  Bit reverse:

    ; Write a program that takes a number (of size 4 bytes) x as input, and then
    ; reverses all the bits of x, and outputs the result. By reversing all bits we
    ; mean that the bit with original location i will move to location 31-i.

    ; Small example (for the 8 bit case):

      ; if x == {01001111}_2, then the output is {11110010}_2.

      ; In this example we reversed only 8 bits. Your program will be able to
; reverse 32 bits.

format PE console
entry start

include 'win32a.inc' 

; ===============================================
section '.text' code readable executable

start:
    call    read_hex
    call    print_eax_binary
    mov ebx, eax    ; Store original in EBX
    mov ecx, 31d    ; Initialize loop counter ECX with 32
    xor eax, eax    ; Zero EAX
    
reverse_bits:
    ;call    print_eax_binary
    mov edx, ebx
    and edx, 1      ; Keep low bit from EBX in EDX
    
    jz bit_0       ; Jump to bit_0 if carry bit is 0 from rotation else continue with carry flag set
    add eax, 1

bit_0:
    rol eax, 1
    ror ebx, 1
    loop reverse_bits

exit: ; Print binary representation of EAX and exit the process:
    call    print_eax_binary
	push	0
	call	[ExitProcess]

include 'training.inc'
