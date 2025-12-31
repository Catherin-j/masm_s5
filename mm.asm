;-------------------------------------------
; 10. Read and Display Total Conventional Memory in KB
; INT 12h → Returns memory size in KB in AX
;-------------------------------------------.Using int 21h read system memory size and display
.model small
.stack 100h
.data
    msg db 'Total conventional memory: $'
    newline db 13,10,'$'
.code
main proc
    mov ax,@data
    mov ds,ax

    mov ah,09h
    lea dx,msg
    int 21h
; 1.get m/m size
    int 12h              ; get memory size in KB → AX
    call print_number    ; print AX as decimal


;2. to clear screen
mov ah,00h       ; set video mode
mov al,02h       ; text mode 80x25 color
int 10h


    lea dx,newline
    mov ah,09h
    int 21h

    mov ah,4Ch
    int 21h

;--------------------------
; Decimal Print Procedure
;--------------------------
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
    mov ah,02h
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
