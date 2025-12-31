.model small
.stack 100h

.data
    msg1 db 'Enter number of elements (1-9): $'
    msg2 db 13,10,'Enter elements (0-9):',13,10,'$'
    msg3 db 13,10,'avg of array elements = $'
    newline db 13,10,'$'
    arr db 10 dup(?)      ; Array to hold up to 10 elements
    count db ?            ; Number of elements
    sum dw 0              ; 16-bit sum
    avg dw 0

.code
main proc
    mov ax, @data
    mov ds, ax

    ; Prompt for number of elements
    lea dx, msg1
    mov ah, 09h
    int 21h

    mov ah, 01h
    int 21h
    sub al, '0'
    mov count, al         ; Save original count
    mov cl, al            ; Use CL for loop
    mov si, 0

    ; Prompt for elements
    lea dx, msg2
    mov ah, 09h
    int 21h

read_loop:
    mov ah, 01h
    int 21h
    sub al, '0'
    mov arr[si], al
    inc si
    loop read_loop

    ; Calculate sum
    xor ax, ax
    xor si, si
    mov ch,0
    mov cl, count

sum_loop:
    mov al, arr[si]
    cbw                 ; Convert AL to AX
    add sum, ax
    inc si
    loop sum_loop

    ; Calculate average
    mov ax, sum
    mov bl, count
    xor ah, ah          ; Clear AH before division
    div bl              ; AX / BL → AL = quotient
    mov avg, ax

    ; Display result
    lea dx, msg3
    mov ah, 09h
    int 21h

    mov ax, avg
    call print_NO

    mov ah, 4Ch
    int 21h

; Print number in AX
print_NO:
    mov bx, 10
    xor cx, cx

next_digits:
    xor dx, dx
    div bx
    push dx
    inc cx
    cmp ax, 0
    jne next_digits

print_loop:
    pop dx
    add dl, '0'
    mov ah, 02h
    int 21h
    loop print_loop
    ret

main endp
end main