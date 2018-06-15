; Basic Assembly
; ==============
; 
; Strings
; -------
;
; Inner mess
; @@@@@@@@@@
;
; 0.    Assemble and run this program.
;
; 1.    Try to give the program different inputs, and observe the output.
;       Particularly, try the input: abc[123]def
;
; 2.    Read the program's code below, and try to understand what does it do. 
;       Try to describe it as simply as you can. Add comments if needed.
;
; 3.    Explain the program's output.
;
; 4.    What happens if we give the program an input of the form 
;       1234[5678, or 789324]12345 ?
;       '1234[5678' prints '5678'
;       '789324]12345' prints ''
;
;       Modify the program to handle those cases. Think about apropriate
;       messages that should be printed to the user.
;

format PE console
entry start

include 'win32a.inc' 

MAX_USER_TEXT = 40h

; ===============================================
section '.data' data readable writeable
    string_emp  db      'Sorry, you gave me an empty string...',13,10,0

    enter_text  db      'Please enter text:',13,10,0
    inside_br   db      'The following was found inside the brackets:',13,10,0
    
    no_closing_br_str db 'No closing bracket!',13,10,0
    no_opening_br_str db 'No opening bracket!',13,10,0

; ===============================================
section '.bss' readable writeable
    first_b     dd      ?
    last_b      dd      ?
    slen        dd      ?

    user_text   db      MAX_USER_TEXT  dup (?)

; ===============================================
section '.text' code readable executable

start:
    mov     esi,enter_text
    call    print_str

    mov     ecx,MAX_USER_TEXT
    mov     edi,user_text
    call    read_line

    ; Find the string's length.
    mov     edi,user_text
    mov     ecx,MAX_USER_TEXT
    xor     al,al
    repnz scasb ; Repeat while not zero or ECX != 0; scan string; cmp al, [edi], edi += 1

    neg     ecx
    add     ecx,MAX_USER_TEXT
    dec     ecx ; Compute string length from user

    mov     dword [slen],ecx    ; Store length in slen
    test    ecx,ecx ; Test for empty string with bitwise &
    jnz     string_not_empty
    ; Tell the user that the string is empty:
    mov     esi,string_emp
    call    print_str   ; Print 'Sorry, you gave me an empty string...'
    ; Exit program:
	push	0
	call	[ExitProcess]

string_not_empty:

    ; Find the first bracket:
    mov     edi,user_text
    mov     ecx,dword [slen]
    mov     al,'['
    repnz scasb ; Scan until finding '[' or end of string

    dec     edi
    mov     dword [first_b],edi ; Store location of first bracket
    
    ; Handle no opening bracket
    mov ebx, user_text
    add ebx, dword [slen]
    dec ebx
    cmp ebx, edi
    jbe no_opening_br

    ; Find the last bracket:
    mov     edi,user_text
    add     edi,dword [slen]
    dec     edi
    std     ; Search backwards by setting direction flag
    mov     al,']'
    mov     ecx, dword [slen]
    repnz   scasb   ; Scan backwards until beginning of string or finding ']'
    cld     ; Restore the direction forward.
    
    inc     edi
    mov     dword [last_b],edi
    
    ; Handle no closing bracket
    mov ebx, user_text
    cmp ebx, edi
    jae no_closing_br
    

    ; Finally we print what's inside the brackets:
    mov     esi,inside_br
    call    print_str   ; Print 'The following was found inside the brackets:'

    ; Store zero terminator instead of the last bracket:
    mov     edi, dword [last_b]
    xor     al,al
    stosb

    ; Start printing right after the first bracket:
    mov     esi,dword [first_b]
    inc     esi
    
    call    print_str


    ; Exit the process:
	push	0
	call	[ExitProcess]

no_closing_br:
    mov esi, no_closing_br_str
    call print_str
    push 0
    call [ExitProcess]
    
no_opening_br:
    mov esi, no_opening_br_str
    call print_str
    push 0
    call [ExitProcess]

include 'training.inc'
