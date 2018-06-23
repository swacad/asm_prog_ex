; 5.  Number to String

    ; We are going to write a program that converts a number into its base 10
    ; representation, as a string.

    ; The program will read a number as input (Using the read_hex helper
    ; subroutine). It will then print back the number, in base 10.

    ; Example:
      
      ; Input:  1f23
      ; output: 7971 (Decimal representation).

    ; HINTS:
      ; - Recall that the input number could be imagined to be in the form:
        ; input = (10^0)*a_0 + (10^1)*a_1 + ... + (10^t)*a_t

      ; - Use repeated division method to calculate the decimal digits
        ; a_0,a_1,...,a_t.

      ; - Find out how to translate each decimal digit into the corresponding
        ; ASCII symbol. (Recall the codes for the digits '0'-'9').

      ; - Build a string and print it. Remember the null terminator!

format PE console
entry start

include 'win32a.inc' 

MAX_TEXT = 40h

; ===============================================
section '.data' data readable writeable
    enter_text  db      'Please enter number:',13,10,0
    single_digit db 0,0
   
; ===============================================
section '.bss' readable writeable
    input       dd      ?
    base_10     db      MAX_TEXT dup (?)

; ===============================================
section '.text' code readable executable

start:
    mov esi, enter_text
    call print_str
    
    call read_hex
    
    mov edi, base_10
    mov ebx, 10 ; Store base 10 in EBX
    
    ; save number to input
    mov esi, input
    mov [esi], eax
    
    ; Compute first hex digit
    cdq
    div ebx
    mov eax, edx    ; move remainder to EAX
    add eax, 30h    ; Add 0x30 to remainder in EAX to get ASCII code point for digit
    stosb   ; Store the ASCII digit character in base_10 and advance EDI
    mov eax, edx

    mov ecx, 1
compute_next_digit:
    ; Compute next hex digit
    mov eax, dword [esi]
    sub eax, edx    ; subtract remainder from input
    jz null_terminator
    cdq
    div ebx     ; divide by base 10
    
    ; Store updated number in base_10
    mov [esi], eax

    cdq
    div ebx
    mov eax, edx    ; move remainder to EAX
    add eax, 30h    ; Add 0x30 to remainder in EAX to get ASCII code point for digit
    stosb   ; Store the ASCII digit character in base_10 and advance EDI
    mov eax, edx
    inc ecx
    jmp compute_next_digit
    
    
null_terminator:
    ; Add null terminator
    xor eax, eax
    stosb

    mov edi, single_digit
print_base_10:  ; print one character time string in reverse order.
    lea esi, [base_10 + ecx]
    lodsb
    mov byte [edi], al
    mov esi, edi
    call print_str
    dec ecx
    cmp ecx, 0
    jge print_base_10

exit:
    ; Exit the process:
	push	0
	call	[ExitProcess]


include 'training.inc'

      