; Basic Assembly
; ==============
; 
; Subroutines and the stack - CALL and RET
; ----------------------------------------
;
; Catapult
; @@@@@@@@
;
; -----------------------------------------------------------------------------
; 
;  )(:;;..                                                           :
;  ::::::::;.                                                    `.  :  .'
;   ):(;;;;`;;                                                     `m$$m
;  '|:|:::::"_                                                   ''$$$$$$''
;   /_| ::::'                                                    .' `$$'`.
;  :/  ::.;'          mdQQQb                                    '     :   `
;  :|__/::'        ---- 4SSEO                                         :
;  :(__/           \    \SSQ'                 __        ___   __
;  ::               \ \Y \Sp                 (\\)______(\|/)_(//)
;  :L                \;\\_\                   |\\\\\\\\\\|/////|
;  :|              .;'  \\               mmNmmmNNmmm\\\\\|/////|
;  :|            .;'     \\            4OOOOOOOOOOOOOO\\\|///mm|
;  :|          .;'        \\          dVVVVVVOOOOOOOOOOOOOOOOOVVV   mmmOOOOm
;  :|  ____  .;'____       \\   ____ mmm ____ mOOOOVVVVVVVVVVVSSSSSSSSmmmOOOOm
;  :| / / _\_L / /  \ ______\\_/_/__\__ / /  \ qVVVVVVVVVVVVVVVSSSSSSSSSmmmOOOM
;  :|| | |____| | ++ |_________________| | ++ | VVVVVVVVVVVVVVVVSSSSSSSSSOOOOOOO
;  _| \_\__/   \_\__/          \_\__/   \_\__/ dOOOOOOOOOOOOOVVVSSSSSSSSSOOOOOOO
;
; ASCII art by MasterMind: http://ascii.co.uk/art/catapult.
;
; -----------------------------------------------------------------------------
;    
; 0.    Assemble and run this program.
;
; 1.    Read the program's code below, and try to understand what does it do. 
;       Try to describe it as simply as you can. Add comments if needed.
;
;       Pay special attention to the strange use of the RET instruction.
;       Try to understand exactly what happens.
;           The push of the .print_visible function onto the stack followed by a
;           RET instruction always causes an immediate jump to .print_visible.
;
; 2.    Explain the program's output.
;           Will always only print 'I can be seen!'. The code to print invisible
;           is unreachable and hence will never execute.
;

format PE console
entry start

include 'win32a.inc' 


; ===============================================
section '.data' data readable writeable
    welcome         db  'Welcome to the Catapult program.',13,10,0
    invisible       db  'I can not be seen!',13,10,0
    visible         db  'I can be seen!',13,10,0

; ===============================================
section '.text' code readable executable

start:

    mov     esi,welcome
    call    print_str   ; print 'Welcome to the Catapult program.'

    push    .print_visible  ; push .print_visible subroutine onto stack
    ret ; return to location at top of stack, .print_visible. Similar to jmp .print_visible

    mov     esi,invisible   ; Will never execute
    call    print_str

.print_visible:
    mov     esi,visible
    call    print_str

    ; Exit the process:
	push	0
	call	[ExitProcess]

include 'training.inc'
