.model small
.stack 100h
.data
buf db 2 dup(?)  
msg1 db 'enter  a 2 digit no: $'
msg2 db 0dh,0ah,'factorial : $'
count dw ?
fact db 1
result dw 1

.code
main proc
mov ax,@data
mov ds,ax

lea dx,msg1 
mov ah,09H
int 21H

lea si,buf
mov cx,2

Read_loop:
mov ah,01H
int 21H
mov [si],al
inc si
loop Read_loop

lea si,buf
mov ax,0

; 10th palce
mov al,[si]
sub al,'0'
mov ah,0
mov bl,10
mul bl 
push ax
; ones palce
inc si
mov al,[si]
sub al,'0'
mov ah,0
pop BX
add ax,BX
mov count,ax ; orignal num 

mov cx,count

fact_loop:
cmp cx,0
je DONE

mov ax,result
mul cx 
mov result,ax
dec cx
jmp fact_loop

DONE:
lea dx,msg2
mov ah,09H
int 21H

mov ax,result
call PRINT_NUMBER

mov ah,4Ch
int 21h

PRINT_NUMBER proc
    push ax
    push bx
    push cx 
    push dx 
    mov bx,10
    xor cx,cx

    next_digit:
    xor dx,dx
    div bx
    push dx
    inc cx
    cmp ax,0
    jne next_digit

    print_digits:
    pop dx
    add dl,'0'
    mov ah,02H
    int 21H
    loop print_digits

    pop dx
    pop cx
    pop bx 
    pop ax
    ret
    PRINT_NUMBER endp

    main endp
    end main

