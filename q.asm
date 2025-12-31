.MODEL SMALL
.STACK 100h

.DATA
msg1 db 'Enter a string: $'
msg2 db 0dh,0ah,'Enter character to find: $'
msg3 db 0dh,0ah,'Frequency of the character: $'
newline db 0dh,0ah,'$'

inputbuf db 20, ?, 20 dup(?)   ; buffered input format
count db 0                     ; single-digit count

.CODE
main PROC
    mov ax, @data
    mov ds, ax

;------------------------------------
; Prompt for string
    lea dx, msg1
    mov ah, 09h
    int 21h

    lea dx, inputbuf
    mov ah, 0Ah
    int 21h

;------------------------------------
; Prompt for character
    lea dx, msg2
    mov ah, 09h
    int 21h

    mov ah, 01h
    int 21h
    mov ch, al

;------------------------------------
; Count frequency
    xor bl, bl
    lea si, inputbuf+2
    mov cl, [inputbuf+1]

count_loop:
    mov al, [si]
    cmp al, ch
    jne skip
    inc bl
skip:
    inc si
    dec cl
    jnz count_loop

    mov count, bl

;------------------------------------
; Display result
    lea dx, msg3
    mov ah, 09h
    int 21h

    mov al, count
    and al, 0Fh           ; ensure it's a valid digit
    add al, '0'
    mov dl, al
    mov ah, 02h
    int 21h

    lea dx, newline
    mov ah, 09h
    int 21h

;------------------------------------
; Exit
    mov ah, 4Ch
    int 21h
main ENDP
END main