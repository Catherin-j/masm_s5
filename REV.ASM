.MODEL SMALL
.STACK 100h
.DATA
MSG1 DB 'Enter a number: $'
MSG2 DB 0DH,0AH,'Reversed number: $'

.CODE
MAIN PROC
    MOV AX, @DATA
    MOV DS, AX

    ;----------------------------------------
    ; Display message to enter number
    ;----------------------------------------
    LEA DX, MSG1
    MOV AH, 09H
    INT 21H

    ;----------------------------------------
    ; Read first digit
    ;----------------------------------------
    MOV AH, 01H
    INT 21H
    SUB AL, '0'
    MOV BL, AL         ; store first digit

    ;----------------------------------------
    ; Read second digit
    ;----------------------------------------
    MOV AH, 01H
    INT 21H
    SUB AL, '0'
    MOV BH, AL         ; store second digit

    ;----------------------------------------
    ; Check if third digit is entered (for 3-digit number)
    ;----------------------------------------
    MOV AH, 01H
    INT 21H
    CMP AL, 0DH        ; check if Enter pressed (Carriage Return)
    JE TWO_DIGIT

    SUB AL, '0'
    MOV CL, AL         ; third digit
    JMP THREE_DIGIT

;----------------------------------------
; For 2-digit number
;----------------------------------------
TWO_DIGIT:
    ; display reversed order (BH BL)
    LEA DX, MSG2
    MOV AH, 09H
    INT 21H


    MOV DL, BH
    ADD DL, '0'
    MOV AH, 02H
    INT 21H

    MOV DL, BL
    ADD DL, '0'
    MOV AH, 02H
    INT 21H
    JMP EXIT

;----------------------------------------
; For 3-digit number
;----------------------------------------
THREE_DIGIT:
    LEA DX, MSG2
    MOV AH, 09H
    INT 21H

    MOV DL, CL
    ADD DL, '0'
    MOV AH, 02H
    INT 21H

    MOV DL, BH
    ADD DL, '0'
    MOV AH, 02H
    INT 21H

    MOV DL, BL
    ADD DL, '0'
    MOV AH, 02H
    INT 21H

EXIT:
    MOV AH, 4CH
    INT 21H
MAIN ENDP
END MAIN
