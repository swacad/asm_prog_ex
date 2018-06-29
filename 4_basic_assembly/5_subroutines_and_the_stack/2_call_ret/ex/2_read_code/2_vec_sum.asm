; Basic Assembly
; ==============
; 
; Subroutines and the stack - CALL and RET
; ----------------------------------------
;
; Vec Sum
; @@@@@@@
;    
; 0.    Assemble and run this program.
;
; 1.    Try to give the program different inputs, and observe the output.
;           The program does not take user inputs.
;
; 2.    Skim the code. Take a look at the functions and their descriptions.
;       Understand the dependencies between the functions (Which function calls
;       which function), and what is the special purpose of every function.
;
; 3.    Read the program's code below, and try to understand what does it do. 
;       Try to describe it as simply as you can. Add comments if needed.
;
;       Fill in the descriptions for the functions in this code.
;
; 4.    Explain the program's output.
;           Sums the list of VEC values (x, y) to sum_vec and prints the result.
;
; 5.    Question for thought: How can you check that this program works right,
;       without verifying the full calculation yourself?
;           Use a geometric sum with an easily computable formula in vec_list.
;       
;       HINT: How could you acheive it by a small change to the program?
;

format PE console
entry start

include 'win32a.inc' 

struct VEC
    x   dd  ?
    y   dd  ?
ends

; ===============================================
section '.data' data readable writeable
; List of VEC structs which are 2 dwords each.
vec_list    VEC     58 , -125
            VEC     158 , -17
            VEC     17 , 22
            VEC     8 , 34
            VEC     56 , 149
            VEC     -125 , 226
            VEC     -93 , -111
            VEC     173 , 54
            VEC     -228 , 151
            VEC     68 , 255
            VEC     194 , 23
            VEC     50 , -165
            VEC     188 , 113
            VEC     -214 , 15
            VEC     59 , 254
            VEC     -154 , -57
            VEC     83 , 239
            VEC     74 , 56
            VEC     77 , 79
            VEC     -57 , 201
            VEC     -4 , 191
            VEC     96 , 163
            VEC     108 , 215
            VEC     204 , 137
            VEC     128 , 116
            VEC     232 , -88
            VEC     -171 , 245
            VEC     32 , -19
            VEC     -108 , 96
            VEC     13 , -111
            VEC     152 , -69
            VEC     8 , -63
            VEC     13 , 96
            VEC     28 , -125
            VEC     -96 , -13
            VEC     5 , -83
            VEC     -172 , 204
LIST_LEN = ($ - vec_list) / sizeof.VEC

sum_vec     VEC     0,0

; ===============================================
section '.text' code readable executable

start:

    mov     edi,sum_vec
    mov     esi,vec_list
    xor     ecx,ecx

.next_vec:  ; loop thru all VECs
    call    add_vecs
    add     esi,sizeof.VEC  ; mov ESI to point to next VEC
    inc     ecx ; increment loop counter
    cmp     ecx,LIST_LEN
    jnz     .next_vec   ; If not done looping through entire list, repeat

    mov     esi,sum_vec
    call    print_vec

    ; Exit the process:
	push	0
	call	[ExitProcess]

; ===============================================
; Input: ESI: pointer to current VEC; EDI: pointer to sum_vec to accumulate sum
; Operation: Add x and y from VEC to sum_vec
; Output: EDI updated with adding current VEC
;
add_vecs:
    push    eax ; Save eax to the stack.

    mov     eax,dword [esi + VEC.x] ; Get current x value from list
    add     dword [edi + VEC.x],eax ; Add to sum_vec.x

    mov     eax,dword [esi + VEC.y] ; get current y value from list
    add     dword [edi + VEC.y],eax ; Add to sum_vec.y

    pop     eax ; Restore eax from the stack.
    ret

; ===============================================
; Input: ESI: sum_vec
; Operation: prints the sum in sum_vec.x and sum_vec.y
; Output: ?
;
print_vec:
    push    eax     ; Keep eax to stack.
    mov     eax,dword [esi + VEC.x]
    call    print_eax
    mov     eax,dword [esi + VEC.y]
    call    print_eax
    pop     eax     ; Restore eax.
    ret

include 'training.inc'
