.model small
.stack 100h
.data
msg1 db 'enter a 4 digit no: $'
msg2 db 'palindrome$'
msg3 db 'not palindrome$'

DIGITS_BUF  DB 4 DUP(?)    ; Stores the three input digits
num dw ?
.code 
main proc
mov ax,@data
mov ds,ax

lea dx,msg1
mov ah,09h
int 21h

lea si,DIGITS_BUF
mov cx,4

Read_loop:
mov ah,01h
int 21h
mov [si],al
inc si
loop Read_loop

lea si,DIGITS_BUF
mov al,[si]  ; 1st digit
mov bl,[si+3] ; last digit
cmp al,bl
jne NOT_EQUAL

mov al,[si+1]
mov bl,[si+2]
cmp al,bl
jne NOT_EQUAL

lea dx,msg2
mov ah,09h
int 21h
jmp EXIT_PG

NOT_EQUAL:
lea dx,msg3
mov ah,09h
int 21h
jmp EXIT_PG

EXIT_PG:
mov ah,4Ch
int 21h

main ENDP
end main