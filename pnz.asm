.MODEL SMALL
.STACK 100h
.DATA
MSG  DB 'Enter number (-9 to 9): $'
POS  DB 0DH,0AH,'Positive$'
NEGM DB 0DH,0AH,'Negative$'
ZER  DB 0DH,0AH,'Zero$'

.CODE
MAIN PROC
    MOV AX, @DATA
    MOV DS, AX

    ; Display prompt
    LEA DX, MSG
    MOV AH, 09H
    INT 21H

    ; ---- Read first character ----
    MOV AH, 01H
    INT 21H
    MOV BL, AL          ; store first char

    CMP BL, '-'         
    JE READ_NEG          ; if '-', read next digit

    CMP BL, '0'
    JE IS_ZERO           ; if '0'
    JG IS_POSITIVE       ; if > '0' and <= '9'
    JL EXIT              ; invalid

READ_NEG:
    ; ---- Read second character ----
    MOV AH, 01H
    INT 21H
    CMP AL, '0'
    JE IS_ZERO           ; handle -0 (still zero)
    ; anything else after '-' = negative
    LEA DX, NEGM
    MOV AH, 09H
    INT 21H
    JMP EXIT

IS_POSITIVE:
    LEA DX, POS
    MOV AH, 09H
    INT 21H
    JMP EXIT

IS_ZERO:
    LEA DX, ZER
    MOV AH, 09H
    INT 21H

EXIT:
    MOV AH, 4CH
    INT 21H
MAIN ENDP
END MAIN
