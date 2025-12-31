.model small
.stack 100h
.data
    msg1 db 'Press any key: $'
    newline db 13,10,'$'
.code
main proc
    mov ax,@data
    mov ds,ax

    ; -------------------------------
    ; Display message
    lea dx,msg1
    mov ah,09h       ; DOS print string
    int 21h

    ; -------------------------------
    ; Read a character from keyboard
    mov ah,00h       ; INT 16h function 00h - read key
    int 16h          ; waits for key press
    ; AL = ASCII code of key pressed
    ; AH = scan code (ignored here)

    ; -------------------------------
    ; Print the character
    mov dl,al        ; put ASCII code into DL
    mov ah,02h       ; DOS function 02h - print character
    int 21h

    ; -------------------------------
    ; Print newline
    lea dx,newline
    mov ah,09h
    int 21h

    ; -------------------------------
    ; Terminate program
    mov ah,4Ch
    mov al,00h
    int 21h

main endp
end main
