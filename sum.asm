.model small
.stack 100h
.data
    msg1 db 'Enter a 2-digit number: $'
    msg2 db 0Dh,0Ah,'Sum: $'
    buf db 2 dup(?)
    num dw ?
    sum dw 0
    newline db 0Dh,0Ah,'$'

.code
main proc
    mov ax, @data
    mov ds, ax

    ; Prompt
    lea dx, msg1
    mov ah, 09h
    int 21h

    ; Read 2 digits
    lea si, buf
    mov cx, 2
read_loop:
    mov ah, 01h
    int 21h
    mov [si], al
    inc si
    loop read_loop

    ; Convert ASCII to binary
    lea si, buf
    mov al, [si]
    sub al, '0'
    mov ah, 0
    mov bl, 10
    mul bl
    mov bx, ax
    inc si
    mov al, [si]
    sub al, '0'
    mov ah, 0
    add bx, ax
    mov num, bx

    ; Sum from 1 to num
    mov cx, num
    xor ax, ax
sum_loop:
    add ax, cx
    dec cx
    jnz sum_loop
    mov sum, ax

    ; Print result
    lea dx, msg2
    mov ah, 09h
    int 21h
    lea dx, newline
    mov ah, 09h
    int 21h

    mov ax, sum
    call print_number

    ; Exit
    mov ah, 4Ch
    int 21h
main endp

; Print AX as decimal
print_number proc
    push ax
    xor cx, cx
    mov bx, 10
convert:
    xor dx, dx
    div bx
    push dx
    inc cx
    cmp ax, 0
    jne convert
print_digits:
    pop dx
    add dl, '0'
    mov ah, 02h
    int 21h
    loop print_digits
    pop ax
    ret
print_number endp
end main