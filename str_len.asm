.MODEL SMALL
.STACK 100H
.DATA
    MSG1 DB 'ENTER THE STRING: $'
    MSG2 DB 0DH,0AH,'STRLEN: $'
    BUF DB 20          ; Max input length
        DB 0           ; Actual input length (filled by DOS)
        DB 20 DUP(?)   ; Input buffer
.CODE
MAIN PROC
    MOV AX, @DATA
    MOV DS, AX

    ; PRINT MSG1
    LEA DX, MSG1
    MOV AH, 09h
    INT 21h

    ; TAKE INPUT
    LEA DX, BUF
    MOV AH, 0Ah
    INT 21h

    ; GET LENGTH FROM BUF+1
    MOV CL, BUF+1

    ; PRINT MSG2
    LEA DX, MSG2
    MOV AH, 09h
    INT 21h

    ; CONVERT LENGTH TO ASCII AND PRINT
    MOV AL, CL
    MOV AH, 0
    MOV BL, 10
    DIV BL          ; AL = tens digit, AH = ones digit

    ADD AL, '0'
    MOV DL, AL
    MOV AH, 02h
    INT 21h

    ADD AH, '0'
    MOV DL, AH
    MOV AH, 02h
    INT 21h

    ; EXIT
    MOV AH, 4Ch
    INT 21h
MAIN ENDP
END MAIN
