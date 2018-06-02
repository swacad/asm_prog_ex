; 0.  Find closest number.
    
    ; Add the following into the data section:

    ; nums  dd  23h,75h,111h,0abch,443h,1000h,5h,2213h,433a34h,0deadbeafh

    ; This is an array of numbers. 
    
    ; Write a program that receives a number x as input, and finds the dword
    ; inside the array nums, which is the closest to x. (We define the distance
    ; between two numbers to be the absolute value of the difference: |a-b|).

    ; Example:

    ; For the input of 100h, the result will be 111h, because 111h is closer to
    ; 100h than any other number in the nums array. (|100h - 111h| = 11h).

format PE console
entry start

include 'win32a.inc' 


; This is the data section:
; ===============================================
section '.data' data readable writeable
    ; some initalized data.
    nums  dd  23h,75h,111h,0abch,443h,1000h,5h,2213h,433a34h,0deadbeafh
    input dd 0h
    nearest dd 0h

; This is the text section:
; ===============================================
section '.text' code readable executable

start:
    ; Program begins here.
    call read_hex
    mov [input], eax            ; Store input in EDX
    mov ecx, 10                 ; Store loop counter
    mov esi, nums               ; Initialize ESI with nums array
    mov ebx, 8fffffffh          ; Initialize EBX with max positive value

find_nearest:
    mov eax, dword [esi]
    sub eax, [input]            ; Take difference between input and current array number
    
    ; Take absolute value of difference
    cdq                 ; Sign extend EAX to EDX:EAX
    xor     eax,edx     ; If EAX positive then EAX stays same, else flip bits in EAX
    sub     eax,edx     ; if EAX positive then EAX stays same, else subtract EDX <=> to add 1
    
    call print_eax
    
    add esi, 4
    
    cmp eax, ebx
    jb update_nearest
    
    sub ecx, 1
    jnz find_nearest
    jmp exit

update_nearest:
    mov ebx, eax
    mov edx, dword [esi - 4]
    mov [nearest], edx
    sub ecx, 1
    jnz find_nearest

exit:
    mov eax, [nearest]
    call print_eax
    ; Exit the process:
	push	0
	call	[ExitProcess]


include 'training.inc'
