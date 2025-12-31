
.model small
.stack 100H
.data 
msg1 db "enter the string: $"
msg2 db 0dh,0ah,"sorted string : $"
str db 20 
    db ? 
    db 20 dup('$')
newline db 0dh,0ah,'$'    
.code
start:
mov ax,@data 
mov ds,ax

lea dx,msg1
mov ah,09H
int 21H

lea dx,str
mov ah,0ah
int 21H

lea si,str+2
mov cl,[str+1]
dec cl

check:
mov di,si
mov bl,cl

inner:
mov al,[di]
cmp al,[di+1]
jbe noswap
xchg al,[di+1]
mov [di],al

noswap:
inc di
dec bl
jnz inner

inc si
dec cl
jnz check

lea si, str+2
mov cl, [str+1]
add si, cx
mov al, '$'
mov  [si], al




done:
lea dx,msg2
mov ah,09H
int 21H

lea dx,newline
mov ah,09H
int 21H

lea dx,str+2
mov ah,09H
int 21H

mov ah,4ch
int 21H
end start
