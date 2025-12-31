.MODEL SMALL
.STACK 100H

.DATA
    msg1    DB 0Ah,0Dh,'Enter a 3-digit number (100-999):$'
    msg2   DB 0Ah,0Dh,'Result: Is an Armstrong Number.$'
    msg3    DB 0Ah,0Dh,'Result: Is NOT an Armstrong Number.$'
    
    ; Variables for calculation
    num  DW ?           ; Stores the original input number (16-bit)
    sum  DW 0           ; Stores the calculated sum (16-bit)
    buf  DB 3 DUP(?)    ; Stores the three input digits
    CUBE_TABLE   DW 0, 1, 8, 27, 64, 125, 216, 343, 512, 729
    
.CODE
MAIN PROC
    MOV AX, @DATA
    MOV DS, AX

; -----------------------------------------------------------------
; 1. INPUT NUMBER (Read 3 Digits and Store them)
; -----------------------------------------------------------------
    LEA DX, msg1
    MOV AH, 09H
    INT 21H

    lea si,buf
    mov cx,3

    read_loop:
    mov ah,01H
    int 21h 
    mov [si],al
    inc si
    loop read_loop
    

    lea si,buf
    mov ax,0

    ;100
    mov al,[si]
    sub al,'0'
    mov ah,0
    mov bl,100
    mul bl
    push ax
    ;10

    inc si 
    mov al,[si]
    sub al,'0'
    mov ah,0
    mov bl,10
    mul bl 
    pop bx
    add ax,bx
    push ax

    ;once
    inc si 
    mov al,[si]
    sub al,'0'
    mov ah,0
    pop bx
    add ax,bx

    mov num,ax

    arm_loop:
    cmp ax,0
    je display_result
    
    mov dx,0  ; store R
    mov bx,10
    div bx
    push ax  ; quotient 153/10=15 , r=3

    mov bl,dl  ; r=3
    mov bh,0
    shl bx,1
    mov si,bx
    mov ax ,CUBE_TABLE[si]; get CUBE_TABLE

    add sum,ax
    pop ax
    jmp arm_loop

    display_result:
    mov ax,sum
    cmp ax,num
    jne not_arm

    LEA DX, msg2
    MOV AH, 09H
    INT 21H
    jmp exit
    not_arm:
    LEA DX, msg3
    MOV AH, 09H
    INT 21H
    
    exit:
    MOV AH, 4CH
    INT 21H
MAIN ENDP
END MAIN