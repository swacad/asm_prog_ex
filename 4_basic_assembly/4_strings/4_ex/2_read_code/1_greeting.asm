; Basic Assembly
; ==============
; 
; Strings
; -------
;
; Greeting
; @@@@@@@@
;
; 0.    Assemble and run this program.
;
; 1.    Try to give the program different inputs, and observe the output.
;
; 2.    Read the program's code below, and try to understand what does it do. 
;       Try to describe it as simply as you can. Add comments if needed.
;
; 3.    Explain the program's output.
;

format PE console
entry start

include 'win32a.inc' 

MAX_NAME_LEN = 10
GREETING_MAX = HELLO_SIZE + MAX_NAME_LEN + HOW_ARE_SIZE + 1

; ===============================================
section '.data' data readable writeable
    please_enter    db  'Please enter your name:',13,10,0
    hello           db  'Hello ',0
    HELLO_SIZE = $ - hello - 1
    how_are         db  ', how are you today?',13,10,0
    HOW_ARE_SIZE = $ - how_are - 1

; ===============================================
section '.bss' readable writeable
    greeting        db  GREETING_MAX dup (?)
    user_name       db  MAX_NAME_LEN+1 dup (?)

; ===============================================
section '.text' code readable executable

start:
    ; Show a message to the user:
    mov     esi,please_enter
    call    print_str

    ; Read user's name (location at EDI which is user_name):
    mov     ecx,MAX_NAME_LEN+1
    mov     edi,user_name
    
    ; Read string from console into EDI.ECX is size of buffer w/ null terminator
    call    read_line

    ; Now we build the greeting:
    mov     edi,greeting    ; greeting is uninitialized

    ; Copy the hello part into the greeting:
    mov     esi,hello   ; Use hello_copy_byte and copy_hello_done for flow control
hello_copy_byte:    ; Copy one byte at a time from hello to greeting until null terminator
    lodsb   ; AL <- [ESI], ESI += 1; ESI is 'Hello \0'
    test    al,al   ; bitwise & of AL to check for null terminator
    jz      copy_hello_done ; jump if null terminator found
    stosb   ; [EDI] <- AL, EDI += 1; EDI is greeting memory buffer
    jmp hello_copy_byte ; Repeat loop until null terminator found
copy_hello_done:

    ; Copy the name part into the greeting:
    mov     esi,user_name
name_copy_byte: ; Copy name one byte at a time until null terminator
    lodsb
    test    al,al
    jz      copy_name_done
    stosb
    jmp name_copy_byte
copy_name_done:

    ; Copy the how are you part into the greeting:
    mov     esi,how_are
hay_copy_byte:  ; Copy ', how are you today?' one byte at a time until null terminator
    lodsb
    test    al,al
    jz      copy_hay_done
    stosb
    jmp hay_copy_byte
copy_hay_done:
    
    ; Set null terminator for the gretting.
    xor     al,al
    stosb

    mov     esi,greeting
    call    print_str


    ; Exit the process:
    push    0
    call    [ExitProcess]

include 'training.inc'
