.MODEL SMALL
.STACK 100h
.DATA
MSG DB 'Enter N: $'
MSG2 DB 0DH,0AH,'Sum of first N natural numbers: $'
SUM  DB 0

.CODE
MAIN PROC
MOV AX,@DATA
MOV DS,AX

LEA DX,MSG
MOV AH,09H
INT 21H

MOV AH,01H
INT 21H
SUB AL,'0'
MOV BL,AL

MOV CL,1
MOV SUM,0

SUMLOOP:
MOV AL,SUM
ADD AL,CL
MOV SUM,AL
INC CL
CMP CL,BL
JBE SUMLOOP

;---------------------------------------
; Display message
;---------------------------------------
    LEA DX, MSG2
    MOV AH, 09H
    INT 21H

;---------------------------------------
; Display result
;---------------------------------------
    MOV AL, SUM
    ADD AL, '0'
    MOV DL, AL
    MOV AH, 02H
    INT 21H

;---------------------------------------
; Exit to DOS

MOV AH,4CH
INT 21H
MAIN ENDP
END MAIN
