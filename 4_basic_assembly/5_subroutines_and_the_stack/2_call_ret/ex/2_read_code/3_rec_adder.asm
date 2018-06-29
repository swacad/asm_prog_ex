; Basic Assembly
; ==============
; 
; Subroutines and the stack - CALL and RET
; ----------------------------------------
;
; Rec Adder
; @@@@@@@@@
;    
; 0.    Assemble and run this program.
;
; 1.    Try to give the program different inputs, and observe the output.
;       Give some small numbers as input in the beginning.
;
; 2.    Read the program's code below, and try to understand what does it do. 
;       Try to describe it as simply as you can. Add comments if needed.
;
;       Take out a pen and a paper, and find out what happens to the stack
;       during this program.
;
; 3.    Explain the program's output.
;           The program sums the two inputs and prints the result.
;
; 4.    Try to give the program large numbers as input. What happens? Why?
;       Evaluate the size of the stack using this experiment.
;           The summing happens through recursion which increases the stack size
;           as the size of the first input increases. Too large of a number causes
;           the stack to grown past the allocated memory space and overflow causing
;           a crash.
;
; NOTE: 
;       The technique employed in this code where a function calls itself is
;       called Recursion.
;
;       This example is very inefficient, but serves as an example for a
;       Recursive function.
;

format PE console
entry start

include 'win32a.inc' 

; ===============================================
section '.data' data readable writeable
    enter_first     db  'Enter first number: ',0
    enter_second    db  'Enter second number: ',0
    result_is       db  'The result is: ',0

; ===============================================
section '.text' code readable executable

start:
    mov     esi,enter_first
    call    print_str   ; print 'Enter first number: '
    call    read_hex
    mov     ecx,eax ; Store 1st number in ECX

    mov     esi,enter_second
    call    print_str   ; 'Enter second number: '
    call    read_hex
    
    ; print stack pointer
    mov ebx, eax
    mov eax, esp
    call print_eax
    mov eax, ebx
    
    call    adder
    
    ; print stack pointer
    mov ebx, eax
    mov eax, esp
    call print_eax
    mov eax, ebx

    mov     esi,result_is
    call    print_str   ; print 'The result is: '
    call    print_eax

    ; Exit the process:
	push	0
	call	[ExitProcess]

; =================================================
; Input: ECX: 1st number, EAX: 2nd number
; Output: Sum in EAX where EAX += ECX
;
adder:
    ; print stack pointer
    mov ebx, eax
    mov eax, esp
    call print_eax
    mov eax, ebx
    
    jecxz   .end_func   ; if ECX == 0: return
    dec     ecx
    inc     eax
    call    adder
.end_func:
    ret

include 'training.inc'
