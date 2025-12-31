.model small
.stack 100h
.data
msg1 db 'enter n :$'
msg2 db 0dh,0ah,'elements: $'
msg3 db 0dh,0ah,'reversed: $'
arr db 21 dup(?)
.code
main proc
mov ax ,@data
mov ds,ax

lea dx,msg1
mov ah,09h
int 21h
mov ah,01h
int 21h
sub al,'0'
mov bl,al
mov cl,al

lea dx,msg2
mov ah,09h
int 21h
mov si,0

read_loop:
mov ah,01h
int 21h
sub al,'0'
mov arr[si],al
inc si 
loop read_loop

mov cl,bl
mov si,0  ; at the 1st pos
mov bh,0
mov di,bx ;at the last pos
dec di ;arr index atart at 0 so last element=n-1

lea dx,msg3
mov ah,09h
int 21h

rev:
mov dl,arr[di]
add dl,'0'
mov ah,02h
int 21h

mov dl,' '
mov ah,02h
int 21h
dec di
loop rev

mov ah,4ch
int 21h

main endp
end main