 .model small
 .stack 100h
 .datA
 msg db 'hello from cathy $'
 .code
 main proc
 mov ax,@data
 mov ds,ax

 mov dx,offset msg
 mov ah,09h
 int 21h

 mov ah,4ch
 int 21h

 main endp
 end main
