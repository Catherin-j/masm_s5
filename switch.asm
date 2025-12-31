.MODEL small
.STACK 100h

.DATA
MSG1 db 'Case 1: You chose ONE$', 0
MSG2 db 'Case 2: You chose TWO$', 0
MSG3 db 'Case 3: You chose THREE$', 0
MSGD db 'Default: OTHER$', 0

.CODE
main PROC
    mov ax, @data    ; Initialize DS
    mov ds, ax

    mov al, 3       ; our "switch variable" = 2

    cmp al, 1
    je CASE1

    cmp al, 2
    je CASE2

    cmp al, 3
    je CASE3

    jmp DEFAULT_CASE

CASE1:
    mov dx, OFFSET MSG1
    mov ah, 9
    int 21h
    jmp END_SWITCH

CASE2:
    mov dx, OFFSET MSG2
    mov ah, 9
    int 21h
    jmp END_SWITCH

CASE3:
    mov dx, OFFSET MSG3
    mov ah, 9
    int 21h
    jmp END_SWITCH

DEFAULT_CASE:
    mov dx, OFFSET MSGD
    mov ah, 9
    int 21h

END_SWITCH:
    mov ah, 4Ch      ; exit program
    int 21h
main ENDP
END main