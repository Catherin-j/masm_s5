.model small
.stack 100h
.data
    header db 'Digital Clock (80x25 color mode): $'
.code
main proc
    mov ax,@data
    mov ds,ax

    ; -------------------------------
    ; 1. Set video mode 80x25 color text
    mov ah,00h
    mov al,03h       ; 03h = 80x25 color text
    int 10h

    ; -------------------------------
    ; 2. Print header
    lea dx,header
    mov ah,09h
    int 21h

start:
    ; -------------------------------
    ; 3. Move cursor to row 1, column 0
    mov ah,02h
    mov bh,0        ; page number
    mov dh,1        ; row (0 = top)
    mov dl,0        ; column
    int 10h

    ; -------------------------------
    ; 4. Read system time
    mov ah,2Ch
    int 21h
    ; CH = hour, CL = minute, DH = second

    ; -------------------------------
    ; 5. Print hour
    xor ax,ax
    mov al,ch
    call print_number
    mov dl,':'
    mov ah,02h
    int 21h

    ; Print minute
    xor ax,ax
    mov al,cl
    call print_number
    mov dl,':'
    mov ah,02h
    int 21h

    ; Print second
    xor ax,ax
    mov al,dh
    call print_number

    ; -------------------------------
    ; 6. Simple delay
    mov cx,0FFFFh
delay1:
    loop delay1

    ; -------------------------------
    jmp start

; -------------------------------
; Procedure: print_number
; Prints 0–255 in decimal
print_number proc
    push ax
    push bx
    push cx
    push dx

    cmp ax,0
    jne conv
    ; If zero, print '0'
    mov dl,'0'
    mov ah,02h
    int 21h
    jmp done

conv:
    mov bx,10
    xor cx,cx
next_digit:
    xor dx,dx
    div bx
    push dx
    inc cx
    cmp ax,0
    jne next_digit

print_loop:
    pop dx
    add dl,'0'
    mov ah,02h
    int 21h
    loop print_loop

done:
    pop dx
    pop cx
    pop bx
    pop ax
    ret
print_number endp

main endp
end main
