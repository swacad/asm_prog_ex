; Basic Assembly
; ==============
; 
; Memory ideas
; ------------
;
; Popcorn
; @@@@@@@
;
; 0.    Assemble and run this program.
;
; 1.    How many inputs does this program require? 1
;       Try to give the program some inputs, and check out the results. 
;
; 2.    Read the program's code below, and try to understand what does it do. 
;       Try to describe it as simply as you can. Add comments if needed.
;
; 3.    Note the instruction: "add  dl,byte [esi + edi]". Is there a danger
;       of wraparound in dl? Why? 
;           Yes. DL is 8 bits and can overflow the when adding two 8 bit 
;           numbers that sum greater than 255.

format PE console
entry start

include 'win32a.inc' 

; ===============================================
section '.data' data readable writeable
    popcorn     db  0, 1, 1, 2, 1, 2, 2, 3, 1, 2, 2, 3, 2, 3, 3, 4
                db  1, 2, 2, 3, 2, 3, 3, 4, 2, 3, 3, 4, 3, 4, 4, 5
                db  1, 2, 2, 3, 2, 3, 3, 4, 2, 3, 3, 4, 3, 4, 4, 5
                db  2, 3, 3, 4, 3, 4, 4, 5, 3, 4, 4, 5, 4, 5, 5, 6
                db  1, 2, 2, 3, 2, 3, 3, 4, 2, 3, 3, 4, 3, 4, 4, 5
                db  2, 3, 3, 4, 3, 4, 4, 5, 3, 4, 4, 5, 4, 5, 5, 6
                db  2, 3, 3, 4, 3, 4, 4, 5, 3, 4, 4, 5, 4, 5, 5, 6
                db  3, 4, 4, 5, 4, 5, 5, 6, 4, 5, 5, 6, 5, 6, 6, 7
                db  1, 2, 2, 3, 2, 3, 3, 4, 2, 3, 3, 4, 3, 4, 4, 5
                db  2, 3, 3, 4, 3, 4, 4, 5, 3, 4, 4, 5, 4, 5, 5, 6
                db  2, 3, 3, 4, 3, 4, 4, 5, 3, 4, 4, 5, 4, 5, 5, 6
                db  3, 4, 4, 5, 4, 5, 5, 6, 4, 5, 5, 6, 5, 6, 6, 7
                db  2, 3, 3, 4, 3, 4, 4, 5, 3, 4, 4, 5, 4, 5, 5, 6
                db  3, 4, 4, 5, 4, 5, 5, 6, 4, 5, 5, 6, 5, 6, 6, 7
                db  3, 4, 4, 5, 4, 5, 5, 6, 4, 5, 5, 6, 5, 6, 6, 7
                db  4, 5, 5, 6, 5, 6, 6, 7, 5, 6, 6, 7, 6, 7, 7, 8

; ===============================================
section '.text' code readable executable

start:
    call    read_hex
    xor     edx,edx
    mov     ecx,4
    mov     esi,popcorn

one_iter:
    call print_eax
    movzx   edi,al  ; Move low 8 bits from AL to EDI
    add     dl,byte [esi + edi] ; Get the EDI byte from popcorn into DL
    ror     eax,8   ; Rotate EAX right by 8 bits
    loop    one_iter    ; Loop 4 times (ECX = 4)

    mov     eax,edx
    call    print_eax

    ; Exit the process:
	push	0
	call	[ExitProcess]

include 'training.inc'
