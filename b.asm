.MODEL SMALL
.STACK 100H
.DATA
    msg1 db 'Enter a string: $'
    msg2 db 0Dh,0Ah,'PALINDROME$',0
    msg3 db 0Dh,0Ah,'NOT PALINDROME$',0
    buf db 21, ?, 21 dup(?)
.CODE
MAIN PROC
    mov ax, @data
    mov ds, ax

    ; Prompt
    lea dx, msg1
    mov ah, 09h
    int 21h

    ; Read string using DOS buffered input
    lea dx, buf
    mov ah, 0Ah 
    int 21h

    ; Get length of string from [buf+1]
    mov cl, [buf+1]
    cmp cl, 0
    je exit_pg          ; if empty, just exit

     xor ax, ax          ; clear AX so high byte = 0
    ; Set SI to first char, DI to last char
    lea si, [buf+2]
    mov di, si
    mov al, cl
    dec al
    add di, ax          ; di = start + (len - 1)

compare_loop:
    cmp si, di
    jge true_cond        ; if crossed, palindrome

    mov al, [si]
    mov bl, [di]
    cmp al, bl
    jne not_equal        ; if mismatch → not palindrome

    inc si
    dec di
    jmp compare_loop

not_equal:
    lea dx, msg3
    mov ah, 09h
    int 21h
    jmp exit_pg

true_cond:
    lea dx, msg2
    mov ah, 09h
    int 21h

exit_pg:
    mov ah, 4Ch
    int 21h
MAIN ENDP
END MAIN
