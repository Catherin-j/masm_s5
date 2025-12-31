.model small
.stack 100h
.data
msg1 db "Enter number of elements (1-20): $"
msg2 db 0dh,0ah,"Enter elements (0-9): $"
msg3 db 0dh,0ah,"Enter the digit to count (0-9): $"
msg4 db 0dh,0ah,"Frequency of the digit: $"
newline db 0dh,0ah,'$'

arr db 20 dup(?)
n db ?          ; number of elements
digit db ?      ; digit to count
count db ?      ; frequency counter

buf db 2 dup(?) ; buffer for DOS input

.code
start:
    mov ax,@data
    mov ds,ax

; -------------------------
; Input number of elements
lea dx,msg1
mov ah,09h
int 21h

mov ah,01h       ; read single digit from keyboard
int 21h
sub al,'0'       ; convert ASCII to number
mov n,al

; -------------------------
; Input array elements
lea dx,msg2
mov ah,09h
int 21h

mov cl,n         ; loop counter
lea di,arr

InputLoop:
    mov ah,01h
    int 21h
    sub al,'0'   ; convert ASCII to number
    mov [di],al
    inc di
    loop InputLoop

; Input digit to count
lea dx,msg3
mov ah,09h
int 21h

mov ah,01h
int 21h
sub al,'0'
mov digit,al

xor cx,cx
xor al,al
xor bl,bl
lea si,arr
mov cl,n

CountLoop:
mov al,[si]
cmp al,digit
jne Next
inc bl

Next:
inc si
loop CountLoop

mov count ,bl
; -------------------------
; Display result
lea dx,msg4
mov ah,09h
int 21h

mov al,count
add al,'0'       ; convert number to ASCII
mov dl,al
mov ah,02h
int 21h

; -------------------------
; Exit
mov ah,4ch
int 21h
end start