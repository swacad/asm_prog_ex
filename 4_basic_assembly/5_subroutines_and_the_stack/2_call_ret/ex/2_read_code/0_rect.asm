; Basic Assembly
; ==============
; 
; Subroutines and the stack - CALL and RET
; ----------------------------------------
;
; Fair and Square
; @@@@@@@@@@@@@@@
;    
; 0.    Assemble and run this program.
;
; 1.    Try to give the program different inputs, and observe the output.
;
; 2.    Skim the code. Take a look at the functions and their descriptions.
;       Understand the dependencies between the functions (Which function calls
;       which function), and what is the special purpose of every function.
;
; 3.    Read the program's code below, and try to understand what does it do. 
;       Try to describe it as simply as you can. Add comments if needed.
;           The program takes a user input as the size of a square to print consisting
;           of * characters. One main function, print_square, accomplishes this
;           with two helper functions print_full_line and print_hollow_line.
;
; 4.    Explain the program's output.
;           prints a square for 2x2 and hollow square for 3x3 or larger.
; 
; 5.    - Create a new function called print_rect. This function will take as
;       arguments: ecx as height, and edx and width. It will then print a
;       rectangle of ecx rows and edx columns to the console.
;       
;       You may call the print_hollow_line and print_full_line functions to
;       create the rectangle.
;       
;       - Add a proper description of Input, Operation and Output for your
;       function. 
;
;       - Make sure to leave the registers unchanged.
;
;       - Assemble and run your new program. Make sure that it has the expected
;       behaviour. Verify that your function leaves the stack balanced.
;

format PE console
entry start

include 'win32a.inc' 


; ===============================================
section '.data' data readable writeable
    space           db  ' ',0
    star            db  '*',0
    newline         db  13,10,0

    enter_wanted    db  'Enter wanted height then width of rectangle: ',0

; ===============================================
section '.text' code readable executable

start:
    mov     esi,enter_wanted
    call    print_str   ; print 'Enter wanted width then height of rectangle: '

    call    read_hex
    mov     ecx,eax ; store size in ECX
    
    call read_hex
    mov eDx, eAx
    
    mov eAx, eSp
    call print_eax
    
    call    print_rect
    
    mov eAx, eSp
    call print_eax

    ; Exit the process:
	push	0
	call	[ExitProcess]


; ======================================================
; Input:
;   ecx -- height. (ecx >= 2)
;   eDx -- width
; Operation:
;   Prints a square made of stars of size ecx to the console.
;
print_rect:
    push    edi         ; Keep edi.
    cmp     ecx,2
    jb      .end_func   ; End if ECX < 2
    cmp eDx, 2
    jb .end_func

    mov     edi,ecx     ; Save a copy of ecx.

    ; Print first full line:
    call    print_full_line

    sub     edi,2   ; Size -= 2
    test    edi,edi
    jz      .after_hollows  ; if EDI == 0: jump to .after_hollows else go to .hollows
.hollows:
    ; Print hollow lines:
    call    print_hollow_line
    dec     edi
    jnz     .hollows
.after_hollows:

    ; Print last full line:
    call    print_full_line
    
.end_func:
    pop     edi         ; Restore edi.
    ret

; ========================================================
; Input:
;   ecx -- size of line.
; Operation:
;   Prints a line of stars of size ecx to the console.
; 
print_full_line:
    push    ecx     ; Keep registers.
    push eDx
    push    esi

    ; Print a line of stars:
    mov eCx, eDx
.next_star: ; Loop to print line of stars where number of stars equals input size, EDX
    mov     esi,star
    call    print_str
    loop    .next_star

    ; Print a new line:
    mov     esi,newline
    call    print_str

    pop     esi     ; Restore registers.
    pop eDx
    pop     ecx
    ret
    
; ==========================================================
; Input: 
;   ecx -- size of line. (ecx >= 2)
; Operation:
;   Prints a hollow line of stars of size ecx to the console.
; 
print_hollow_line:  ; Can't get here unless ECX > 2
    push    ecx     ; Keep registers.
    push eDx
    push    esi

    mov eCx, eDx
    
    cmp     ecx,2
    jb     .end_func
    ; If we are here, ecx >= 2:
    ; Print one star:
    mov     esi,star
    call    print_str

    ; Print spaces:
    sub     ecx,2
    jecxz   .after_spaces
.next_space:
    mov     esi,space
    call    print_str
    loop    .next_space
.after_spaces:

    ; Print another star:
    mov     esi,star
    call    print_str

    ; Print a new line:
    mov     esi,newline
    call    print_str

.end_func:
    pop     esi     ; Restore registers.
    pop eDx
    pop     ecx
    ret

include 'training.inc'
