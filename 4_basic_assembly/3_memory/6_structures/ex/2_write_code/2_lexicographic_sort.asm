;2.  Lexicographic sort.
;
;    We define the lexicographic order as follows:
;    For every two points (a,b), (c,d), we say that (a,b) < (c,d) if:
;
;    (a < c) or (a = c and b < d)
;
;    This order is similar to the one you use when you look up words in the
;    dictionary. The first letter has bigger significance than the second one,
;    and so on.
;
;    Examples:
;
;      (1,3) < (2,5)
;      (3,7) < (3,9)
;      (5,6) = (5,6)
;
;    Write a program that takes 6 points as input (Two coordinates for each
;    point), and prints a sorted list of the points, with respect to the
;    lexicographic order.

format PE console
entry start

include 'win32a.inc'

; Coordinate structure:
struct COORD
    x   db  ?   ; 0
    y   db  ?   ; 1
ends

; ===============================================
section '.bss' readable writable
p1      COORD  ?
p2      COORD  ?
p3      COORD  ?

s1      dd      ?
s2      dd      ?
s3      dd      ?


; ===============================================
section '.text' code readable executable

start:

    ; Read p1:
    call    read_hex
    mov     byte [p1.x], al
    call    read_hex
    mov     byte [p1.y], al

    ; read p2
    call    read_hex
    mov     byte [p2.x], al
    call    read_hex
    mov     byte [p2.y], al

    ; read p3
    call    read_hex
    mov     byte [p3.x], al
    call    read_hex
    mov     byte [p3.y], al

    ; initialize sort indices
    mov [s1], p1
    mov [s2], p2
    mov [s3], p3
    
    ; prints
    mov eax, p1
    call print_eax
    mov eax, p2
    call print_eax
    mov eax, p3
    call print_eax
    call print_delimiter

first_pass:     ; Compare p1 and p2
    movzx eax, byte [p1.x]
    cmp al, byte [p2.x]     ; compare p1.x to p2.x
    jg p1_greater_p2
    je first_pass_check_second
    jmp second_pass

first_pass_check_second:
    movzx eax, byte [p1.y]
    cmp al, byte [p2.y]     ; compare p1.y to p2.y
    jg p1_greater_p2
    jmp second_pass

p1_greater_p2:
    mov [s2], p1
    mov [s1], p2
    
    mov eax, [s1]
    call print_eax
    mov eax, [s2]
    call print_eax
    mov eax, [s3]
    call print_eax
    call print_delimiter

second_pass:    ; compare [s1] and p3
    mov esi, [s1]
    movzx eax, byte [esi]
    cmp al, byte [p3.x]
    jg s1_greater_p3    ; point in s1 is greater than p3
    je second_pass_check_second
    jmp third_pass
    mov eax, 11h
    call print_eax

second_pass_check_second:
    movzx eax, byte [esi + 1]
    cmp al, byte [p3.y]
    jg s1_greater_p3    
    jmp third_pass
    
s1_greater_p3:
    mov eax, 21h
    call print_eax
    mov eax, [s1]   ; Store previous lowest point in EAX
    mov ebx, [s2]   ; store current middle point in EBX
    
    mov [s1], p3    ; store p3 in the first position as the lowest point
    
    mov [s2], eax
    mov [s3], ebx
    
    mov eax, [s1]
    call print_eax
    mov eax, [s2]
    call print_eax
    mov eax, [s3]
    call print_eax
    call print_delimiter

third_pass: ; compare p2 and p3
    movzx eax, byte [p2.x]
    cmp al, byte [p3.x]     ; compare p2.x to p3.x
    jg p2_greater_p3
    je third_pass_check_second
    jmp exit

third_pass_check_second:
    movzx eax, byte [p2.y]
    cmp al, byte [p3.y]     ; compare p1.y to p2.y
    jg p2_greater_p3
    jmp exit

p2_greater_p3:
    mov [s3], p2
    mov [s2], p3
    
    mov eax, [s1]
    call print_eax
    mov eax, [s2]
    call print_eax
    mov eax, [s3]
    call print_eax
    call print_delimiter

exit:
    ; Exit the program:
        push    0
        call    [ExitProcess]


include 'training.inc'

