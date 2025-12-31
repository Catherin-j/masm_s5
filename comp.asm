.MODEL SMALL
.STACK 100H
.DATA
MSG1 DB 'ENTER FIRST NUMBER (0-9): $'
MSG2 DB 0DH,0AH,'ENTER SECOND NUMBER (0-9): $'
MSG3 DB 0DH,0AH,'LARGER NUMBER: $'

.CODE
MAIN PROC
    MOV AX,@DATA
    MOV DS,AX

    ; --- Input first number ---
    LEA DX, MSG1
    MOV AH, 09H
    INT 21H

    MOV AH, 01H         ; Read char
    INT 21H
    SUB AL, '0'         ; Convert ASCII to number
    MOV BL, AL          ; Store first number in BL

    ; --- Input second number ---
    LEA DX, MSG2
    MOV AH, 09H
    INT 21H

    MOV AH, 01H         ; Read char
    INT 21H
    SUB AL, '0'
    MOV BH, AL          ; Store second number in BH

    ; --- Compare the numbers ---
    LEA DX, MSG3
    MOV AH, 09H
    INT 21H

    CMP BL, BH
    JGE FIRST_IS_LARGER

SECOND_IS_LARGER:
    MOV DL, BH
    ADD DL, '0'
    MOV AH, 02H
    INT 21H
    JMP EXIT

FIRST_IS_LARGER:
    MOV DL, BL
    ADD DL, '0'
    MOV AH, 02H
    INT 21H

EXIT:
    MOV AH, 4CH
    INT 21H
MAIN ENDP
END MAIN
