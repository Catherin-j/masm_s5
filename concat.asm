.MODEL SMALL
.STACK 100H

.DATA
    MSG1       DB 'ENTER STR1: $'
    MSG2       DB 'ENTER STR2: $'
    MSG3       DB 'FINAL_STR: $'
    NEWLINE    DB 0DH,0AH,'$'

    BUF1       DB 20
               DB ?
               DB 20 DUP(?)

    BUF2       DB 20
               DB ?
               DB 20 DUP(?)

    FINAL_STR  DB 50 DUP('$')

.CODE
MAIN PROC
    MOV AX, @DATA
    MOV DS, AX

    ; Prompt STR1
    LEA DX, MSG1
    MOV AH, 09h
    INT 21h

    ; Input STR1
    LEA DX, BUF1
    MOV AH, 0Ah
    INT 21h

    ; Newline
    LEA DX, NEWLINE
    MOV AH, 09h
    INT 21h

    ; Prompt STR2
    LEA DX, MSG2
    MOV AH, 09h
    INT 21h

    ; Input STR2
    LEA DX, BUF2
    MOV AH, 0Ah
    INT 21h

    ; Newline
    LEA DX, NEWLINE
    MOV AH, 09h
    INT 21h

    ; Print FINAL_STR label
    LEA DX, MSG3
    MOV AH, 09h
    INT 21h

    ; Copy BUF1 manually
    LEA SI, BUF1
    MOV CL, [SI+1]
    XOR CH, CH
    ADD SI, 2
    LEA DI, FINAL_STR

COPY1:
    MOV AL, [SI]
    MOV [DI], AL
    INC SI
    INC DI
    LOOP COPY1

    ; Copy BUF2 manually
    LEA SI, BUF2
    MOV CL, [SI+1]
    XOR CH, CH
    ADD SI, 2

COPY2:
    MOV AL, [SI]
    MOV [DI], AL
    INC SI
    INC DI
    LOOP COPY2

    ; Add string terminator
    MOV BYTE PTR [DI], '$'

    ; Print FINAL_STR
    LEA DX, FINAL_STR
    MOV AH, 09h
    INT 21h

    ; Exit
    MOV AH, 4Ch
    INT 21h
MAIN ENDP
END MAIN
