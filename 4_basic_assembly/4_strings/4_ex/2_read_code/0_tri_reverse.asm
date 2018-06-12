; Basic Assembly
; ==============
; 
; Strings
; -------
;
; Tri
; @@@
;
; 0.    Assemble and run this program.
;
; 1.    Try to give the program different inputs, and observe the output.
;
; 2.    Read the program's code below, and try to understand what does it do. 
;       Try to describe it as simply as you can. Add comments if needed.
;           Asks user for number input. Prints that number of lines with the * character
;           First line has the number of *s equal to the user input and decreases by
;           by one * each line until all lines are printed. Final line has 1 *.
;
; 3.    Explain the program's output.
;
; 4.    Make a modification to the program, to reverse the picture that is being
;       drawn. (Reverse it vertically).
;

format PE console
entry start

include 'win32a.inc' 


; ===============================================
section '.data' data readable writeable
    enter_size  db  'Enter wanted size: ',0
    star        db  '*',0
    newline     db  13,10,0 ; carriage return, new line

; ===============================================
section '.text' code readable executable

start:
    ; Show a message to the user:
    mov     esi,enter_size
    call    print_str       ; Prints string to console

    ; Read size from user:
    call    read_hex
    xor edx, edx

draw_line:
    inc edx
    mov ecx, edx

one_star:
    ; Print one star:
    mov     esi,star
    call    print_str
    loop one_star
    
    ; Print a new line:
    mov     esi,newline
    call    print_str

    dec     eax
    jnz     draw_line
    

    ; Exit the process:
	push	0
	call	[ExitProcess]

include 'training.inc'
