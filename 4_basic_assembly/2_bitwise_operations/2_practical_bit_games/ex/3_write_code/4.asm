; Basic Assembly
; ==============
; 
; Bitwise operations - Practical bit games
; ----------------------------------------
; 4.  Rotation using shifts.

    ; Implement the ror instruction using the shift instructions. You may use any
    ; bitwise instruction for this task, except for the rotation instructions
    ; (ror,rol).

format PE console
entry start

include 'win32a.inc' 

; ===============================================
section '.text' code readable executable

start:
    call    read_hex
    call    print_eax_binary
    
    shr eax, 1
    
    jnc exit        ; If low order bit shifted off was zero, exit
    add eax, 80000000h ; Add to make highest bit 1

exit: ; Print binary representation of EAX and exit the process:
    call    print_eax_binary
	push	0
	call	[ExitProcess]

include 'training.inc'
