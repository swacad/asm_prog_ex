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

WIDTH = 4h
HEIGHT = 2h
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

; Transpose A into B
transpose:
    mov     esi,A ; Cell ptr.
    mov edi, B
    mov     ebx,0   ; column counter

transpose_next_column:
    mov     ecx,0   ; row counter
transpose_next_row:
    mov     eax, dword [esi]
    
    mov dword [edi],eax
    call print_eax
    add edi, 4
    
    add     esi,4
    
    inc     ecx
    cmp     ecx,HEIGHT
    jnz     transpose_next_row    ; Loop until all rows completed
    
    inc     ebx
    cmp     ebx,WIDTH
    jnz     transpose_next_column ; Loop until all columns completed in row
    

    ; Exit the process:
    push    0
    call    [ExitProcess]

include 'training.inc'
