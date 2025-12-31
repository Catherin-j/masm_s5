.model small
.stack 100h
.data
    msg_reset db 'Resetting disk system...$'
    msg_status db 13,10,'Disk status: $'
    msg_ok db 'No error detected.$'
    msg_err db 'Error occurred!$'
    newline db 13,10,'$'

.code
main proc
    mov ax,@data
    mov ds,ax

    ; -------------------------------
    ; 22. Reset Disk System (AH=00h)
    lea dx,msg_reset
    mov ah,09h
    int 21h

    mov ah,00h     ; Reset disk system
    mov dl,0       ; Drive A:
    int 13h

    ; Check Carry Flag
    jc reset_error ; if CF=1 → error

    ; Print newline after reset
    lea dx,newline
    mov ah,09h
    int 21h

    ; -------------------------------
    ; 23. Read Disk Status (AH=01h)
    lea dx,msg_status
    mov ah,09h
    int 21h

    mov ah,01h     ; Read disk status
    mov dl,0       ; Drive A:
    int 13h

    jc disk_error  ; if CF=1 → error

    ; No error
    lea dx,msg_ok
    mov ah,09h
    int 21h
    jmp terminate

reset_error:
    lea dx,msg_err
    mov ah,09h
    int 21h
    jmp terminate

disk_error:
    lea dx,msg_err
    mov ah,09h
    int 21h

terminate:
    ; -------------------------------
    ; Terminate program
    mov ah,4Ch
    mov al,00h
    int 21h

main endp
end main
