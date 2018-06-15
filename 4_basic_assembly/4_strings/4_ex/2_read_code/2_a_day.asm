; Basic Assembly
; ==============
; 
; Strings
; -------
;
; A-day
; @@@@@
;
; 0.    Assemble and run this program.
;
; 1.    Try to give the program different inputs, and observe the output.
;
; 2.    Read the program's code below, and try to understand what does it do. 
;       Try to describe it as simply as you can. Add comments if needed.
;           Take user input and output a grade score
;
; 3.    Explain the program's output.
;           Grade is computed by adding 1 for 'a' and 2 for 'A' to a running sum.
;
; 4.    What is the highest grade that could be obtained using this program?
;       Which input gives it?
;           Max grade is 0x40 * 2 given by 0x40 'A's

format PE console
entry start

include 'win32a.inc' 

MAX_USER_TEXT = 40h

; ===============================================
section '.data' data readable writeable

    enter_text  db      'Welcome to the celebrations of the A-day!',13,10
                db      'Please enter text:',13,10,0

    grade       dd      0
    your_grade  db      'Your grade is: ',0

; ===============================================
section '.bss' readable writeable
    user_text   db      MAX_USER_TEXT  dup (?)

; ===============================================
section '.text' code readable executable

start:
    mov     esi,enter_text
    call    print_str   ; Print 'Welcome to the celebrations of the A-day!'

    mov     ecx,MAX_USER_TEXT
    mov     edi,user_text
    call    read_line

    mov     esi,user_text

read_byte:
    lodsb   ; Load string (byte); al <- [esi], esi += 1
    cmp     al,'a'
    jnz     not_little_a
    ; We have an 'a':
    inc     dword [grade]   ; Add 2 for lower case a
not_little_a:
    cmp     al,'A'
    jnz     not_capital_a
    ; We have an 'A':
    add     dword [grade],2 ; Add 2 for capital A
not_capital_a:
    test    al,al   ; Check for null terminator
    jnz     read_byte   ; If not null terminator jump back to read_byte

    mov     esi,your_grade
    call    print_str

    mov     eax,dword [grade]
    call    print_eax


    ; Exit the process:
	push	0
	call	[ExitProcess]

include 'training.inc'
