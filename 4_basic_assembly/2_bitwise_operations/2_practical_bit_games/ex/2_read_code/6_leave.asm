; Basic Assembly
; ==============
; 
; Bitwise operations - Practical bit games
; ----------------------------------------
;
; Leave
; @@@@@
;
; 0.    Assemble and run this program.
; 
; 1.    How many inputs does this program expect?
;       2

; 2.    Try to give different inputs to this program, and check the results.
;       Particularly, try the following input pair: (ffffffff,00000000).
;       

; 3.    Read the program's code below, and try to understand what does it do. 
;       Try to describe it as simply as you can. Add comments if needed.
;       
; 4.    Pick some random inputs and verify your predictions about what this
;       program does.
;

format PE console
entry start

include 'win32a.inc' 

; ===============================================
section '.text' code readable executable

start:
    call    read_hex
    mov     edx,eax     ; EDX = EAX
    call    read_hex
    mov     esi,eax     ; ESI = EAX

    mov     eax,edx     ; EAX = EDX, first input is back in EAX
    call    print_eax_binary    ; Print first input
    mov     eax,esi
    call    print_eax_binary    ; Print second input

    ; Note that we only use the lower part of edx and esi.
    ; The upper part is ignored.

    mov     ecx,16d

two_bits_iter:  ; Loop 16 times
    rol     dx,1        ; <- DX rotate 1
    movzx   edi,dx      ; Lower 16 bits get moved to EDI
    and     edi,1       ; Keep only lowest bit of DX
    shl     eax,1       ; <- shift EAX 1
    or      eax,edi     ; If low bit of first input or newly rotated in low bit of EAX is 1 then low bit if EAX is 1

    rol     si,1        ; <- SI rotate 1
    movzx   edi,si      ; lower 16 bits of SI get moved to EDI
    and     edi,1       ; Keep low bit of SI
    shl     eax,1       ; <- shift EAX 1
    or      eax,edi     ; If low bit of second input or newly rotated in low bit of EAX is 1, low bit of EAX is 1

    loop    two_bits_iter

    call    print_eax_binary

    ; Exit the process:
	push	0
	call	[ExitProcess]


include 'training.inc'
