.model small
.stack 100h
.data
msg1 db 'enter the no of array elements: $'
msg2 db 0dh,0ah,'enter the array elements:$'
msg3 db 0dh,0ah,'array elements are :$'
arr db 21 dup(?)
.code 
main proc
mov ax,@data
mov ds,ax

  ;read n and store in cl
lea dx,msg1
mov ah,09h
int 21h
mov ah,01h
int 21h
sub al,'0'
mov bl,al
mov cl,al ;count
mov ch,0
   ; promt for elements
lea dx,msg2
mov ah,09h
int 21h
   ; si==0 pointer
mov si,0

read_loop:
mov ah,01h
int 21h
sub al,'0'
mov arr[si],al
inc si
loop read_loop ;dec cx and continue and exit when cx=0

lea dx,msg3
mov ah,09h
int 21h
 ; store count to bl for display
mov cl,bl
mov si,0
mov ch,0

display:
mov dl,arr[si]
add dl,'0'
mov ah,02h
int 21h
mov dl, ' '
mov ah,02h
int 21h
inc si
loop display

exit:
mov ah,4ch
int 21h

main endp
end main