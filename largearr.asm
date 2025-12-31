.model small
.stack 100h
.data
msg1 db 'enter n: $'
msg2 db 0dh,0ah,'elements : $'
msg3 db 0dh,0ah,'largest: $'
arr db 21 dup(?)
.code
main proc
mov ax,@data
mov ds,ax

lea dx,msg1
mov ah,09h
int 21h
mov ah,01h
int 21h
sub al,'0'
mov cl,al
mov bl,al

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

; reset parameters
mov si,0
mov cl,bl
mov al,arr[si]
inc si
dec cl

largest:
cmp al,arr[si]
jge skip          ; jle skip wouls give u smallest no
mov al,arr[si]

skip:
inc si 
loop largest

lea dx,msg3
mov ah,09h
int 21h

add al,'0'
mov dl,al
mov ah,02h
int 21h

mov ah,4ch
int 21h
main endp
end main
