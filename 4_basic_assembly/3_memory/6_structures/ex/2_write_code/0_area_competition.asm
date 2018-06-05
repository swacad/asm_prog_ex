; 0.  Area competition.

    ; For every rectangle R which is parallel to the X and Y axes, we can
    ; represent R using two points.

    ; Example:
  
      ; A------------B
      ; |     R      |
      ; |            |
      ; D------------C

      ; We could represent the rectangle in the drawing using the points A(x,y)
      ; and C(x,y) for example. Basically, we need 4 numbers to represent this
      ; kind of rectangle: 2 coordinates for A, and 2 coordinates for C.

      ; I remind you that the area of a rectangle is computed as the
      ; multiplication of its height by its width.


    ; Write a program that takes the coordinates of two rectangles (2 points or 4
    ; dwords for each rectangle), and then finds out which rectangle has the
    ; larger area.

    ; The program then outputs 0 if the first rectangle had the largest area, or 1
    ; if the second rectangle had the largest area. 

    ; In addition, the program prints the area of the rectangle that won the area
    ; competition.

format PE console
entry start

include 'win32a.inc' 

; Coordinate structure:
struct COORD
    x   db  ?   ; 0
    y   db  ?   ; 1
ends

struct RECT
    top_left        COORD ?
    bottom_right    COORD ?
ends

; ===============================================
section '.bss' readable writable

    r1  RECT    ?
    r2  RECT    ?
    
; ===============================================
section '.text' code readable executable

start:
    
    ; Read first rectangle:
    call    read_hex    ; read r1.top_left.x
    mov     byte [r1.top_left.x], al
    call    read_hex    ; read r1.top_left.y
    mov     byte [r1.top_left.y], al
    call    read_hex    ; read r1.bottom_right.x
    mov     byte [r1.bottom_right.x], al
    call    read_hex    ; read r1.bottom_right.x
    mov     byte [r1.bottom_right.y], al
    
    ; Read second rectangle:
    call    read_hex    ; read r2.top_left.x
    mov     byte [r2.top_left.x], al
    call    read_hex    ; read r2.top_left.y
    mov     byte [r2.top_left.y], al
    call    read_hex    ; read r2.bottom_right.x
    mov     byte [r2.bottom_right.x], al
    call    read_hex    ; read r2.bottom_right.x
    mov     byte [r2.bottom_right.y], al
    
    ; Compute r1 area
    movzx eax, byte [r1.top_left.x]
    mov ebx, eax
    movzx eax, byte [r1.bottom_right.x]
    sub eax, ebx    ; get rectangle width
    mov edx, eax    ; store width in EDX
    
    movzx eax, byte [r1.bottom_right.y]
    mov ebx, eax
    movzx eax, byte [r1.top_left.y]
    sub eax, ebx    ; get rectangle height
    
    imul edx        ; compute rectangle area
    
    mov ecx, eax    ; store r1 area in ECX
    call print_eax  ; Area for r1
    
    ; Compute r2 area
    movzx eax, byte [r2.top_left.x]
    mov ebx, eax
    movzx eax, byte [r2.bottom_right.x]
    sub eax, ebx    ; get rectangle width
    mov edx, eax    ; store width in EDX
    
    movzx eax, byte [r2.bottom_right.y]
    mov ebx, eax
    movzx eax, byte [r2.top_left.y]
    sub eax, ebx    ; get rectangle height
    
    imul edx        ; compute rectangle area
    call print_eax  ; Area for r2
    
    ; Compare r1 and r2 areas
    cmp eax, ecx
    jb r1_larger
    
r2_larger:
    mov ecx, eax    ; store r2 area in ECX
    mov eax, 1
    call print_eax
    mov eax, ecx
    call print_eax
    jmp exit

r1_larger:
    mov eax, 0
    call print_eax
    mov eax, ecx
    call print_eax

exit:
    ; Exit the program:
	push	0
	call	[ExitProcess]


include 'training.inc'

