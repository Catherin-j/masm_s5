.model small
.stack 100h
.data
    msg1 db 'Original cursor position: $'
    msg2 db 'Text moved to new position!$'
.code
main proc
    mov ax,@data
    mov ds,ax

    ; -------------------------------
    ; 1. Print original message at current cursor position
    mov ah,09h         ; write character & attribute
    mov al,' '         ; placeholder, will print loop for string
    mov bh,0           ; page number
    mov bl,07h         ; attribute (light gray on black)

    lea si,msg1        ; point to string
print_msg1:
    lodsb
    cmp al,'$'
    je done_msg1
    mov ah,09h
    int 10h
    jmp print_msg1
done_msg1:

    ; -------------------------------
    ; 2. Move cursor to row 5, column 10
    mov ah,02h
    mov bh,0
    mov dh,5           ; row
    mov dl,10          ; column
    int 10h

    ; -------------------------------
    ; 3. Print message at new position
    lea si,msg2
print_msg2:
    lodsb
    cmp al,'$'
    je done_msg2
    mov ah,09h
    mov bl,0Ah         ; light green text
    mov bh,0
    int 10h
    jmp print_msg2
done_msg2:

    ; -------------------------------
    ; 4. Terminate program
    mov ah,4Ch
    mov al,0
    int 21h

main endp
end main
