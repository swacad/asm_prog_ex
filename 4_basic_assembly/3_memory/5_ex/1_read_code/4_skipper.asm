; Basic Assembly
; ==============
; 
; Memory
; ------
;
; Skipper
; @@@@@@@
; 
; 0.    Assemble and run this program.
;
; 1.    Read the program's code below, and try to understand what does it do. 
;       Try to describe it as simply as you can. Add comments if needed.
;
; 2.    Explain the program's output.
;

format PE console
entry start

include 'win32a.inc' 
 
; ===============================================
section '.text' code readable executable

start:

    jmp     skip_data ; Skip the data. We don't want to execute data

    ; We define data in the middle of the code section!
    my_data     db      1,2,3,4,5
    my_data_end:

    ; This is a pretty dirty trick, but it should give you some insight
    ; regarding the lack of distinction between data and code.

skip_data:
    
    mov     ecx,my_data_end - my_data   ; Should put 5 in ECX used for loop counter
    mov     esi,my_data                 ; Move start of memory location for 5-byte sequence

print_byte:
    movzx   eax, byte [esi]             ; moves byte from memory location my_data to EAX
    call    print_eax
    inc     esi
    loop    print_byte

    ; Exit the process:
	push	0
	call	[ExitProcess]

; A label that marks the end of our code.
end_prog:

include 'training.inc'
