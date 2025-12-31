.model small
.stack 100h
.data
msg1 db 'N: $'
msg2 db 0dh,0ah,'ELEMENTS: $'
msg3 db 0dh,0ah,'element to be searched: $'
msg4 db 0dh,0ah,'found!$'
msg5 db 0dh,0ah,'Not Found!!$'
arr db 21 dup(?)
.code
main proc 
mov ax,@data
mov ds,ax

lea dx,msg1
mov ah,09h
int 21h
mov ah ,01h
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

mov si,0
mov cl,bl
lea dx,msg3
mov ah,09h
int 21h
mov ah,01h
int 21h
sub al,'0'
mov dl,al


compare:
mov al,arr[si]
cmp al,dl
je found
inc si
loop compare
jmp not_found

found:
lea dx,msg4
mov ah,09h
int 21h
jmp exit

not_found:
lea dx,msg5
mov ah,09h
int 21h
jmp exit
exit:
mov ah,4ch
int 21h
main endp
end main