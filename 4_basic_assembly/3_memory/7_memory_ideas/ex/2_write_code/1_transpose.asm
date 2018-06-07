; 1.  Transpose.
    
    ; 1.0   Create a new program. Add a two dimensional table A (of dwords) in the
          ; bss section of your program, of sizes: HEIGHT X WIDTH. Initialize cell
          ; number A(i,j) (Row number i, column number j) with the number i+j.

          ; Print some cells of the table A to make sure that your code works
          ; correctly.

    ; 1.1   Add another table B to your bss section, with dimensions WIDTH X
          ; HEIGHT. (Note that this table has different dimensions!)

          ; Then add a piece of code that for every pair i,j: Stores A(i,j) into
          ; B(j,i). 

          ; In another formulation:
          ; B(j,i) <-- A(i,j) for every i,j.

          ; Example:

            ; Original A table:
            
              ; 0 1 2 3
              ; 1 2 3 4

            ; Resulting B table:

              ; 0 1
              ; 1 2
              ; 2 3
              ; 3 4

    ; 1.2   Print some cells of table A and table B to make sure that your code
          ; works correctly.
          
format PE console
entry start

include 'win32a.inc' 

WIDTH = 3h
HEIGHT = 2h

section '.data' data readable writeable
    four db 4

; ===============================================
section '.bss' readable writeable
    ; Declare the uninitialized table in memory:
    A     dd      WIDTH*HEIGHT dup (?)
    B     dd      WIDTH*HEIGHT dup (?)
    

; ===============================================
section '.text' code readable executable

start:
    ; Fill in the table:
    mov     esi,A ; Cell ptr.
    mov     ecx,0   ; row counter.

next_row:
    mov     ebx,0   ; Column counter.
    
next_column:
    mov     eax,ecx
    
    add eax, ebx
    call print_eax
    
    mov     dword [esi],eax

    add     esi,4
    inc     ebx
    cmp     ebx,WIDTH
    jnz     next_column ; Loop until all columns completed in row

    inc     ecx
    cmp     ecx,HEIGHT
    jnz     next_row    ; Loop until all rows completed
    

transpose:  ; Transpose A into B
    mov esi, A
    mov edi, B
    mov ecx, 0  ; row counter
    
transpose_next_row:
    mov     ebx,0   ; Column counter.

transpose_next_col:
    mov edx, dword [esi]  ; Store entry in A in EDX
    mov eax, edx
    
    ; Compute offset for entry into B
    mov eax, HEIGHT
    mul bl
    add eax, ecx
    mul [four]  ; Formula for new offset: 4(row + HEIGHT * col)

    mov edi, B
    add edi, eax
    mov eax, edx
    mov dword [edi], edx
    
    ;call print_eax
    
    add     esi,4
    inc     ebx
    cmp     ebx,WIDTH
    jnz transpose_next_col
    
    inc     ecx
    cmp     ecx,HEIGHT
    jnz transpose_next_row
    

print_B_init:
    mov eax, WIDTH
    mov ebx, HEIGHT
    mul ebx
    mov ecx, eax    ; loop counter
    
    mov esi, B

print_B_loop:
    mov eax, [esi]
    call print_eax
    add esi, 4
    loop print_B_loop


    ; Exit the process:
    push    0
    call    [ExitProcess]

include 'training.inc'
