; 1.  Palindrome

    ; A palindrome is a sequence of symbols which is interpreted the same if read in
    ; the usual order, or in reverse order.
    
    ; Examples:

      ; 1234k4321   is a palindrome.
      ; 5665        is a palindrome.

      ; za1221at    is not a palindrome.


    ; Write a program that takes a string as input, and decides whether it is a
    ; palindrome or not. It then prints an appropriate message to the user.
    
format PE console
entry start

include 'win32a.inc' 

MAX_USER_TEXT = 40h

; ===============================================
section '.data' data readable writeable
    enter_text  db      'Please enter text:',13,10,0
    negative    db      'Text is not palindrome',13,10,0
    positive    db      'Text is palindrome',13,10,0

; ===============================================
section '.bss' readable writeable
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

    mov esi, user_text      ; begin location
    lea edi, [esi + ecx - 1]    ; end location
    
    shr ecx, 1  ; Get number of characters to check by dividing ECX by 2
    
check_character:
    mov al, byte [esi]
    cmp al, byte [edi]
    jne not_palindrome
    
    ; Adjust indices in ESI and EDI
    inc esi
    dec edi
    
    loop check_character
    
    ; Loop finishes so palindrome
    mov esi, positive
    call print_str
    jmp exit

not_palindrome:
    mov esi, negative
    call print_str
    
exit:
    ; Exit the process:
	push	0
	call	[ExitProcess]


include 'training.inc'
