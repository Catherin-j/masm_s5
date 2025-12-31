.model small
.stack 100h
.data
msg1 db 'enter n: $'
msg2 db 0dh,0ah,'elements: $'
msg3 db 0dh,0ah,'sorted array: $'
arr db 21 dup(?)
.code
main proc 
mov  ax,@data
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

mov cl,bl
outer:
mov si,0
mov ch,bl
dec ch

inner:
mov al,arr[si]
mov dl,arr[si+1]
cmp al,dl
jle noswap

mov arr[si],dl
mov arr[si+1],al

noswap:
inc si 
dec ch
jnz inner

dec cl
jnz outer

lea dx,msg3
mov ah,09h
int 21h

mov si,0
mov cl,bl

display:
mov dl,arr[si]
add dl,'0'
mov ah,02h
int 21h

mov dl,' '
mov ah,02h
int 21h
inc si 
loop display

mov ah ,4ch
int 21h

main endp
end main