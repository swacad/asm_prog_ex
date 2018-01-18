; Basic Assembly
; ==============
; 
; Signed Operations
; -----------------
;
; Higher Window
; @@@@@@@@@@@@@@
; 
; 0.    Assemble and run this program.
; 
; 1.    How many inputs does this program expect?
;       Answer: 1

; 2.    Try to give different inputs to this program, and check the results.
;       Seems to always output 0

; 3.    Read the program's code below, and try to understand what does it do. Try
;       to describe it as simply as you can.
;       Reads a number input then prints "1" if negative and "0" if positive

; 4.    Pick some random inputs and verify your predictions about what this
;       program does.
;
; 5.    How could you implement this program without the cdq instruction? Write
;       your implementation as a new program, and make sure that it has the same
;       results.
;

format PE console
entry start

include 'win32a.inc' 

; ===============================================
section '.text' code readable executable

start:

    call    read_hex
    ;cdq
    cmp eax, 0
    jns edx_is_zero;
    mov     eax,1
    call    print_eax
    jmp     end_if
edx_is_zero:
    mov     eax,0
    call    print_eax
end_if:

    ; Exit the process:
	push	0
	call	[ExitProcess]

include 'training.inc'
