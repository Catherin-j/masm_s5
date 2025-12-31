.MODEL SMALL
.STACK 100H
.DATA
STR  DB 'HELLO$',0
MSG1 DB 'ORIGINAL STRING: $'
MSG2 DB 0DH,0AH,'REVERSED STRING: $'

.CODE
MAIN PROC
    MOV AX, @DATA
    MOV DS, AX

    ; Display original string
    LEA DX, MSG1
    MOV AH, 09H
    INT 21H

    LEA DX, STR
    MOV AH, 09H
    INT 21H

    ; Display reversed string message
    LEA DX, MSG2
    MOV AH, 09H
    INT 21H

    ; Find length of STR (till '$')
    LEA SI, STR
    MOV CX, 0

FIND_LEN:
    MOV AL, [SI]
    CMP AL, '$'
    JE PRINT_REVERSE
    INC SI
    INC CX
    JMP FIND_LEN

; Now SI points at '$', CX = length, start printing backward
PRINT_REVERSE:
    DEC SI

REVERSE_LOOP:
    CMP CX, 0
    JE EXIT
    MOV DL, [SI]
    MOV AH, 02H
    INT 21H
    DEC SI
    DEC CX
    JMP REVERSE_LOOP

EXIT:
    MOV AH, 4CH
    INT 21H
MAIN ENDP
END MAIN
