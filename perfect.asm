.model small
.stack 100h
.data
    buf db 2 dup(?)                     ; Input buffer for 2 digits
    msg1 db 0Ah,0Dh,'Enter a 2-digit number (10-99):$'
    msg2 db 0Ah,0Dh,'Result: Is a Perfect Number.$'
    msg3 db 0Ah,0Dh,'Result: Is NOT Perfect Number.$'

    num dw ?                            ; Stores the input number
    sum dw 0                            ; Sum of divisors

.code
main proc
    mov ax, @data
    mov ds, ax

    ; Prompt user
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

    ; Reject leading zero
    lea si, buf


    ; Convert ASCII to binary
    mov ax, 0

    ; Tens digit
    mov al, [si]
    sub al, '0'
    mov ah, 0
    mov bl, 10
    mul bl
    mov bx, ax
    inc si

    ; Units digit
    mov al, [si]
    sub al, '0'
    mov ah, 0
    add bx, ax

    mov ax, bx
    mov num, ax

    ; Validate range: 10–99
    cmp ax, 10
    jl notperfect
    cmp ax, 99
    jg notperfect

    ; Calculate loop limit: num / 2
    mov dx, 0
    mov cx, 2
    div cx                             ; AX = num / 2
    mov cx, ax                         ; CX = loop limit

    ; Sum divisors from 1 to num/2
    mov si, 1
    mov sum, 0

divisor_loop:
    cmp si, cx
    jg end_divisor

    push cx
    mov ax, num
    mov dx, 0
    mov bx, si
    div bx                             ; AX = num / si, DX = num % si

    cmp dx, 0
    jne skip_add

    add sum, si

skip_add:
    pop cx
    inc si
    jmp divisor_loop

end_divisor:
    mov ax, sum
    cmp ax, num
    jne notperfect

    ; Display perfect message
    lea dx, msg2
    mov ah, 09h
    int 21h
    jmp exit_program

notperfect:
    lea dx, msg3
    mov ah, 09h
    int 21h

exit_program:
    mov ah, 4Ch
    int 21h
main endp
end main