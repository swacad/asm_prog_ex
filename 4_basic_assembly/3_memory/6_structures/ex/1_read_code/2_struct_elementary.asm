; Basic Assembly
; ==============
; 
; Memory - Structures
; -------------------
;
; Struct Elementary
; @@@@@@@@@@@@@@@@@
; 
; 0.    Read the structures' definitions, and take a look at the code.
;
; 1.    Before running the program: Try to predict all the values that will be
;       printed to the console. Write your predictions as comments.
;
; 2.    Run the program and check your predictions.
;

format PE console
entry start

include 'win32a.inc' 

struct PNT
    x   db  ?                   ; 0
    y   db  ?                   ; 1
ends                            ; 2

struct LINE
    p_start     PNT     ?       ; 0
    p_end       PNT     ?       ; 2
ends                            ; 4

struct COLORED_LINE
    struct
        red     db      ?       ; 0
        green   db      ?       ; 1
        blue    db      ?       ; 2
                db      ?       ; 3
    ends                        
    cline   LINE    ?           ; 4
ends                            ; 8

struct UNI_COLORED_LINE
    union
        struct
            red     db      ?   ; 0
            green   db      ?   ; 1
            blue    db      ?   ; 2
                    db      ?   ; 3
        ends
        color   dd      ?       ; 0
    ends
    cline   LINE    ?           ; 4
ends                            ; 8


struct INDEXED_LINE
    index   dd  ?               ; 0
    union
        struct
            red     db      ?   ; 4
            green   db      ?   ; 5
            blue    db      ?   ; 6
                    db      ?   ; 7
        ends
        color   dd      ?       ; 4
    ends
    cline   LINE    ?           ; 8
ends                            ; 12

; ===============================================
section '.bss' readable writable
    
    my_u_line           UNI_COLORED_LINE    ?
    my_i_line           INDEXED_LINE        ?
    
; ===============================================
section '.text' code readable executable

start:
    
    
    ; UNI_COLORED_LINE structure:
    ; ---------------------------

    ; Compare the following two values:
    mov     eax,UNI_COLORED_LINE.red
    call    print_eax   ; 0

    mov     eax,UNI_COLORED_LINE.color
    call    print_eax   ; 0

    ; And also compare the following two values:
    mov     eax,my_u_line.red
    call    print_eax   ; my_u_line + 0

    mov     eax,my_u_line.color
    call    print_eax   ; my_u_line + 0


    mov     dword [my_u_line.color],11223344h
    ; Predict the following values:
    movzx   eax,byte [my_u_line.red]
    call    print_eax   ; 44
    movzx   eax,byte [my_u_line.green]
    call    print_eax   ; 33
    movzx   eax,byte [my_u_line.blue]
    call    print_eax   ; 22

    ; Print a delimiter.
    call    print_delimiter


    ; INDEXED_LINE structure:
    ; -----------------------

    ; Predict the following values:
    mov     eax,INDEXED_LINE.red
    call    print_eax   ; 4

    mov     eax,sizeof.INDEXED_LINE
    call    print_eax   ; 0xC

    mov     eax,INDEXED_LINE.cline.p_start.y
    call    print_eax   ; 9


    ; Exit the process:
	push	0
	call	[ExitProcess]

include 'training.inc'
