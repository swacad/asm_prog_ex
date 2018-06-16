; 3.  Common sense

    ; Write a program that reads a string from the user, and then finds out the
    ; most common character in the string. (Don't count spaces).
    
    ; Finally the program prints that character back to the user, together with
    ; its number of occurrences in the string.
    
    ; Example:

      ; Input:  The summer is the place where all things find their winter

      ; Output: The character e is the most common character on the string.
              ; Amount of occurrences: 8

    
format PE console
entry start

include 'win32a.inc' 

MAX_USER_TEXT = 40h

; ===============================================
section '.data' data readable writeable
    enter_text  db      'Please enter text:',13,10,0
    common_char db 'The character a is the most common character on the string.',13,10,0
    ;          14th character ----^
    occurrences db 'Amount of occurrences: 0',13,10,0
    ;                   24th character ----^
    debug_text   db 'debug',13,10,0
    counts      db 128 dup (0)  ; Array to count characters. Increment by one with each match
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
    ; Repeat while not zero or ECX != 0; scan string; cmp al, [edi], edi += 1
    repnz scasb

    neg     ecx
    add     ecx,MAX_USER_TEXT
    dec     ecx ; Compute string length from user

    mov     dword [slen],ecx    ; Store length in slen

    mov esi, user_text
    mov edi, counts
    
check_character:
    movzx eax, byte [esi]
    
    lea ebx, [edi + eax]  ; Load location to increment in counts array
    inc byte [ebx];
    
    ; Adjust indices in ESI
    inc esi
    
    loop check_character

; Get max value index from counts
    mov ecx, 128  ; counts array size
    xor eax, eax  ; initialize EAX
    mov esi, counts
    mov byte [esi + 20h], 0 ; Remove spaces from being counted
find_max_idx:
    dec ecx
    ;movzx eax, byte [edi]
    ;call print_eax
    scasb   ; cmp al, [edi], edi += 1
    jb more_common_found    ; If the current max in AL < byte [EDI]
    
    test ecx, ecx   ; Test for end of loop
    jnz find_max_idx    ; Jump if not finished iterating
    jmp exit

more_common_found:
    mov al, byte [edi - 1]  ; Store new high count in AL
    mov ebx, edi
    sub ebx, esi
    dec ebx  ; Store index of high count in EBX
    jmp find_max_idx
    
exit:
    mov esi, common_char
    mov [esi + 14], bl  ; Change the 14th character to the correct most frequent char
    call print_str  ; Print the adjusted most common character string
    
    mov esi, occurrences
    add eax, 30h    ; Add 0x30 to align on ASCII table digits
    mov [esi + 23], al  ; Change the 23rd character to be the count of the most frequent char
    call print_str

    ; Exit the process:
	push	0
	call	[ExitProcess]


include 'training.inc'

              