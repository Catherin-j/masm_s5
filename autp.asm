.MODEL SMALL
.STACK 100H

.DATA
    msg1 db 0Dh,0Ah,"Enter a 2-digit number (10-99): $"
    msg2 db 0Dh,0Ah,"The number is Automorphic.$"
    msg3 db 0Dh,0Ah,"The number is NOT Automorphic.$"

    buf db 2 dup(?)      ; to store tens and units
    num db ?             ; final number
    sq dw ?              ; square

.CODE
start:
    mov ax,@data
    mov ds,ax

; -------------------------
; Display prompt
    lea dx,msg1
    mov ah,09h
    int 21h

; -------------------------
; Read 2 digits separately
    lea si,buf
    mov cx,2

read_loop:
    mov ah,01h          ; read one character
    int 21h
    mov [si],al
    inc si
    loop read_loop

; -------------------------
; Convert digits to number
    lea si,buf

    ; tens digit
    mov al,[si]
    sub al,'0'
    mov ah,0
    mov bl,10
    mul bl               ; AL*10 → AX
    push ax

    ; units digit
    inc si
    mov al,[si]
    sub al,'0'
    mov ah,0
    pop bx
    add ax,bx            ; AX = tens*10 + units
    mov num,al           ; store final number

; -------------------------
; Compute square
    mov al,num
    cbw
    mul al               ; AX = num*num
    mov sq,ax

; -------------------------
; Check last 2 digits
    mov ax,sq
    mov dx,100
    div dx               ; remainder in DX = last 2 digits
    mov al,dl
    cmp al,num
    je Auto
    jmp NotAuto

Auto:
    lea dx,msg2
    mov ah,09h
    int 21h
    jmp Done

NotAuto:
    lea dx,msg3
    mov ah,09h
    int 21h

Done:
    mov ah,4Ch
    int 21h
end start
