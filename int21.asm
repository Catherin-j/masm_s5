.model small
.stack 100h
.data
    msg1 db 'Current System Date: $'
    msg2 db 13,10,'Current System Time: $'
    msg3 db 13,10,'Beep sound now...$'
    newline db 13,10,'$'

    hour db ?
    min db ?
    sec db ?
    hundreds db ?

    year dw ?
    month db ?
    day db ?
    wekday db ?
.code 
main proc
mov ax,@data
mov ds,ax

mov ah,2Ah
int 21H
mov year,cx
mov month,dh
mov day,dl
mov wekday,al

mov ax,year
call print_number

    mov dl,'-'
    mov ah,02h
    int 21h

xor ax,ax
mov al,month
call print_number

    mov dl,'-'
    mov ah,02h
    int 21h

xor ax,ax
mov al,day
call print_number

    lea dx,newline
    mov ah,09h
    int 21h
;.....................time.....................................
mov ah,2Ch
int 21H
mov hour,ch
mov min,cl
mov sec,dh 
mov hundreds,dl

 ; Print message for Time
    lea dx,msg2
    mov ah,09h
    int 21h

xor ax,ax
mov al,hour
call print_number

    mov dl,':'
    mov ah,02h
    int 21h

xor ax,ax
mov al,min
call print_number

    mov dl,':'
    mov ah,02h
    int 21h

xor ax,ax
mov al,sec
call print_number

    mov dl,':'
    mov ah,02h
    int 21h


    mov ah,4Ch
    int 21h
print_number proc
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

    print_loop:
    pop dx
    add dl,'0'
    mov ah,02H
    int 21h
    loop print_loop

    pop dx
    pop cx
    pop bx
    pop ax
    ret
    print_number endp

    main endp
    end main