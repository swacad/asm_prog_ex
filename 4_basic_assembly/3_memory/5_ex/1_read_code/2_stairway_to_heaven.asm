; Basic Assembly
; ==============
; 
; Memory
; ------
;
; Stairway to heaven
; @@@@@@@@@@@@@@@@@@
; 
; 0.    Assemble and run this program.
;
; 1.    How many inputs does this program accept?
;   1
;
; 2.    Try to hand the program different inputs, and observe the different
;       outputs.
;
; 3.    Read the program's code below, and try to understand what does it do. 
;       Try to describe it as simply as you can. Add comments if needed.
;   Reads user input
;   Uses user input as loop counter (ECX)
;   Each time through the loop, compute (2 * EAX + 1) and move to EAX which shifts the bits
;       and fills with 1 on right.
;   finally print
;
; 4.    Choose some random inputs and try to predict the output. Verify your
;       predictions by running your program.
;
; 5.    What happens when the input is larger than 0x20 ? Why ?
;   All binary ones no matter what since you are just continuing to shift left and fill with 1
;       and there are only 0x1f bits
;

format PE console
entry start

include 'win32a.inc' 

    
; ===============================================
section '.text' code readable executable

start:

    call    read_hex
    mov     ecx,eax

    xor     eax,eax         ; Zero eax.
one_iter:
    lea     eax,[2*eax + 1]
    loop    one_iter

    call    print_eax_binary

    ; Exit the process:
	push	0
	call	[ExitProcess]


include 'training.inc'
