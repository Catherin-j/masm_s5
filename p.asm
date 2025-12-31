.model small
.stack 100h
.data
    msg1 db 'Enter a 2-digit number (10-99): $'
    newline db 0Dh,0Ah,'$'
    buf db 2 dup(?)
    num dw ?
    count dw 0
    prime dw ?

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

    lea dx, newline
    mov ah, 09h
    int 21h
    
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

    ; Validate range
    cmp bx, 10
    jl exit_program
    cmp bx, 99
    jg exit_program

    ; Initialize
    mov count, 0
    mov prime, 2

find_primes:
    mov ax, prime
    mov cx, 2
    mov dx, 0
    div cx
    mov cx, ax         ; CX = prime / 2
    mov bx, 2
    mov dx, 0          ; flag = 0 (assume prime)

check_prime:
    cmp bx, cx
    jg is_prime
    mov ax, prime
    mov dx, 0
    div bx
    cmp dx, 0
    je not_prime
    inc bx
    jmp check_prime

not_prime:
    inc prime
    jmp find_primes

is_prime:
    ; Print prime
    mov ax, prime
    call print_number
    lea dx, newline
    mov ah, 09h
    int 21h

    inc count
    mov ax, count
    cmp ax, num
    jl next_prime
    jmp exit_program

next_prime:
    inc prime
    jmp find_primes

exit_program:
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