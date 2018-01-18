; Basic Assembly
; ==============
; 
; Signed Operations
; -----------------
;
; Two Pack
; @@@@@@@@
; 
; 0.    Assemble and run this program.
; 
; 1.    How many inputs does this program expect?
;       1

; 2.    Try to give different inputs to this program, and check the results.
;       Specifically, try the following inputs: 
;       12345, 0101, 0202, 0203, 01ff.
;       

; 3.    Read the program's code below, and try to understand what does it do. Try
;       to describe it as simply as you can.
;       Read input and compare to 0xffff.
;       if > 0xffff:
;           exit program
;       else:
;           esi = al (preserve sign)
;           eax = ah (absolute value)
;           eax = eax * esi
;           print eax

; 4.    Pick some random inputs and verify your predictions about what this
;       program does.
;
; 5.    Describe what happens for input ff01 against what happens for input
;       01ff.
;       The sign for ff in ff01 is not preserved so ff is positive number hence 1 * ff == ff
;       For 01ff the sign is preserved so ff is negative. Hence 1 * fffffff == ffffffff

format PE console
entry start

include 'win32a.inc' 

; ===============================================
section '.text' code readable executable

start:

    call    read_hex
    cmp     eax,0ffffh
    ja      exit_program

    movsx   esi,al
    movzx   eax,ah

    imul    esi
    call    print_eax

exit_program:
    ; Exit the process:
	push	0
	call	[ExitProcess]

include 'training.inc'
