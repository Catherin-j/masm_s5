.model small
.stack 100h
.data
    ARR DB 20 DUP(?)               ; array space for 20 numbers
    MSG1 DB 'Enter number of elements: $'
    MSG2 DB 0DH,0AH,'Enter elements: $'
    MSG3 DB 0DH,0AH,'Even count: $'
    MSG4 DB 0DH,0AH,'Odd count: $'
    odd db 0
    eve db 0
.code
main proc
mov ax,@data
mov ds,ax

lea dx,MSG1 
mov ah,09h
int 21h
mov ah,01h
int 21h
sub al,'0'
mov cl,al
mov bl,al

lea dx,MSG2
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

count:
mov al,arr[si]
test al,1
jz even_count

mov al,odd
inc al 
mov odd,al
jmp next

even_count:
mov al,eve
inc al
mov eve,al

next:
inc si 
loop count

lea dx,MSG3
mov ah,09h
int 21h
mov dl,eve
add dl,'0'
mov ah,02h
int 21h

lea dx,MSG4
mov ah,09h
int 21h
mov dl,odd
add dl,'0'
mov ah,02h
int 21h

mov ah,4ch
int 21h
main endp
end main