; 0.  Prime counting

    ; We want to calculate the amount of prime numbers between 1 and n.

    ; Recall that a prime number is a positive integer which is only divisible by
    ; 1 and by itself. The first prime numbers are 2,3,5,7,11,13. (1 is not
    ; considered to be prime).

    ; We break down this task into a few subtasks:

    ; 0.  Write a function that takes a number x as input. It then returns 
        ; eax = 1 if the number x is prime, and eax = 0 otherwise.

    ; 1.  Write a function that takes a number n as input, and then calculates the
        ; amount of prime numbers between 1 and n. Use the previous function that
        ; you have written for this task.

    ; Finally ask for an input number from the user, and use the last function you
    ; have written to calculate the amount of prime numbers between 1 and n.

    ; Bonus Question: After running your program for some different inputs, Can
    ; you formulate a general rough estimation of how many primes are there
    ; between 1 and n for some positive integer n?

format PE console
entry start

include 'win32a.inc' 

; ===============================================
section '.data' data readable writeable
    enter_n     db  'Enter n: ',0
    prime       db  'Prime',0
    not_prime   db  'Not Prime', 0

; ===============================================
section '.text' code readable executable

start:
    mov     esi,enter_n
    call    print_str   ; print 'Enter n: '
    call    read_hex
    mov     ecx,eax ; Store n in ECX
    xor edi, edi    ; Counter for number of primes found
    
    test ecx, ecx
    jz exit
    
count_primes_loop:
    call    is_prime
    add edi, eax
    loop count_primes_loop
    
exit: ; Exit the process:
    mov eax, edi
    call print_eax
	push	0
	call	[ExitProcess]

is_prime:
    push ecx    ; Save ECX
    cmp ecx, 1
    jbe .not_prime
    mov ebx, ecx 
.divide_loop:
    dec ecx
    cmp ecx, 1
    je .prime ; if ecx == 1: jump to .prime
    
    mov eax, ebx    ; Move n to EAX
    cdq
    div ecx ; Divide by current divisor
    test edx, edx  
    jz .not_prime   ; if remainder == 0: jump to .not_prime
    jmp .divide_loop
.prime:
    mov eax, 1
    jmp .end
.not_prime:
    xor eax, eax
.end:
    pop ecx ; Restore ECX
    ret
    

include 'training.inc'
