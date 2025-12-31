.model small
.stack 100h

.data
    prompt1 db 'Enter number of elements (1-9): $'
    prompt2 db 13,10,'Enter elements (0-9):',13,10,'$'
    ;resultMsg db 13,10,'Sum of array elements = $'
    resultMsg db 13,10,'avg of array elements = $'
    newline db 13,10,'$'
    array db 10 dup(?)      ; Array to hold up to 10 elements
    count db ?              ; Number of elements
    sum dw 0                ; 16-bit sum
    avg dw 0
.code
main proc
    mov ax, @data
    mov ds, ax

    ; Prompt for number of elements
    lea dx, prompt1
    mov ah, 09h
    int 21h

    mov ah, 01h         ; Read character
    int 21h
    sub al, '0'         ; Convert ASCII to number
    mov count, al
    mov cl, al          ; Save count in CL

    ; Prompt for elements
    lea dx, prompt2
    mov ah, 09h
    int 21h

    mov si, 0
read_loop:
    mov ah, 01h         ; Read character
    int 21h
    sub al, '0'         ; Convert ASCII to number
    mov array[si], al
    inc si
    
    loop read_loop

    ; Calculate sum
    xor ax, ax
    xor si, si
    mov ch, 0
    mov cl, count         ; Restore count to CX
sum_loop:
    mov al, array[si]
    cbw
    add sum,ax
    inc si
    loop sum_loop
  

mov ax,sum
mov bl,count
xor ah,ah
div bl
mov avg,ax

show_result:
    lea dx, resultMsg
    mov ah, 09h
    int 21h

    mov ax, sum
    call print_number

    lea dx, newline
    mov ah, 09h
    int 21h

    mov ah, 4Ch
    int 21h

; ----------------------------
; Print AX as decimal number
; ----------------------------
print_number:
    mov bx, 10
    xor cx, cx
next_digit:
    xor dx, dx
    div bx
    push dx
    inc cx
    cmp ax, 0
    jne next_digit
print_digits:
    pop dx
    add dl, '0'
    mov ah, 02h
    int 21h
    loop print_digits
    ret

main endp
end main