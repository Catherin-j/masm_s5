.MODEL SMALL
.STACK 100h
.DATA
STR  DB 'hello world$',0
MSG1 DB 0DH,0AH,'Uppercase String: $'

.CODE
MAIN PROC
    MOV AX, @DATA
    MOV DS, AX

    LEA SI, STR

NEXT_CHAR:
    MOV AL, [SI]
    CMP AL, '$'
    JE DONE

    CMP AL, 'a'
    JB SKIP       ; skip if before 'a'
    CMP AL, 'z'
    JA SKIP       ; skip if after 'z'
    SUB AL, 32    ; convert to uppercase (ASCII)

    MOV [SI], AL

SKIP:
    INC SI
    JMP NEXT_CHAR

DONE:
    LEA DX, MSG1
    MOV AH, 09H
    INT 21H

    LEA DX, STR
    MOV AH, 09H
    INT 21H

    MOV AH, 4CH
    INT 21H
MAIN ENDP
END MAIN
