; Basic Assembly
; ==============
; 
; Bitwise operations - Practical bit games
; ----------------------------------------
;
; Ab
; @@
;
; 0.    Assemble and run this program.
; 
; 1.    How many inputs does this program expect?
;       1

; 2.    Try to run the program with different inputs, and check out the results
;       that you get. Make sure to check the following inputs:
;       0,3,ffffffff,-5
;       

; 2.    Read the program's code below, and try to understand what does it do. 
;       Try to describe it as simply as you can. Add comments if needed.
;       Prints absolute value of EAX

; 3.    Remember the three important lines in this program by heart :)
;
        

format PE console
entry start

include 'win32a.inc' 

; ===============================================
section '.text' code readable executable

start:

    call    read_hex

    cdq                 ; Sign extend EAX to EDX:EAX
    xor     eax,edx     ; If EAX positive then EAX stays same, else flip bits in EAX
    sub     eax,edx     ; if EAX positive then EAX stays same, else subtract EDX <=> to add 1

    call    print_eax

    ; Exit the process:
	push	0
	call	[ExitProcess]


include 'training.inc'
