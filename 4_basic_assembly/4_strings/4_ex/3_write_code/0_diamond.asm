; 0.  Diamond

    ; Write a program that asks the user for a number n, and then prints a
    ; "diamond" of size n, made of ASCII stars.

    ; Example:
      ; For n = 1 the expected result is:

       ; *
      ; ***
       ; *

      ; For n = 2 the expected result is:

        ; *
       ; ***
      ; *****
       ; ***
        ; *

    ; HINT: You could use tri.asm exercise from the code reading section as a
    ; basis for your program.

format PE console
entry start

include 'win32a.inc' 

MAX_USER_TEXT = 40h

; ===============================================
section '.data' data readable writeable
    enter_n  db  'Enter n: ',0
    star        db  '*',0
    newline     db  13,10,0 ; carriage return, new line
    n           db  0
    len   db  0
    num_stars   db  0
    star_idx    db  0

; ===============================================

section '.bss' readable writeable
    line db MAX_USER_TEXT dup (?)

section '.text' code readable executable

start:
    ; Show a message to the user:
    mov     esi,enter_n
    call    print_str       ; Prints string to console

    ; Read size from user:
    call    read_hex
    
    ; Store n
    mov [n], al
    
    ; Compute length of star formation (height and width equal to length)
    mov ebx, 2
    mul ebx
    inc eax
    mov [len], al
    call print_eax
    shr eax, 2

draw_line:
    mov     ecx,eax
one_star:
    ; Print one star:
    mov     esi,star
    call    print_str
    loop    one_star
    
    ; Print a new line:
    mov     esi,newline
    call    print_str

    dec     eax
    jnz     draw_line
    

    ; Exit the process:
	push	0
	call	[ExitProcess]

include 'training.inc'