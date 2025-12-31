.model small
.stack 100h
.data
    buf db 2 dup(?)                     ; Input buffer
    msg1 db 0Ah,0Dh,'Enter a 2-digit number (10-99):$'
    msg2 db 0Ah,0Dh,'Sum of Prime Numbers:$'
    newline db 0Ah,0Dh,'$'
    num dw ?
    sum dw 0

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
    mov ax, 0
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

    ; Validate range
   ; cmp bx, 10
    ;jl exit_program
    ;cmp bx, 99
    ;jg exit_program

    ; Sum primes from 2 to num
    mov si, 2
    mov sum, 0

next_num:
    mov ax, si
    mov cx, 2
    mov dx, 0
    div cx
    mov cx, ax         ; CX = si / 2
    mov bx, 2
    mov dx, 0          ; flag = 0 (assume prime)

check_prime:
    cmp bx, cx
    jg add_prime
    mov ax, si
    mov dx, 0
    div bx
    cmp dx, 0
    je not_prime
    inc bx
    jmp check_prime

not_prime:
    inc si
    cmp si, num
    jle next_num
    jmp show_sum

add_prime:
    mov ax, sum
    add ax, si
    mov sum, ax
    inc si
    cmp si, num
    jle next_num

show_sum:
    lea dx, msg2
    mov ah, 09h
    int 21h
    lea dx, newline
    mov ah, 09h
    int 21h
    mov ax, sum
    call print_number
    jmp exit_program

; Print AX as decimal
print_number proc
    mov cx, 0
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
    ret
print_number endp

exit_program:
    mov ah, 4Ch
    int 21h
main endp
end main