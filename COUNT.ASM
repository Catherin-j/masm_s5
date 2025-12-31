.MODEL SMALL
.STACK 100h
.DATA
MSG1 DB 0DH,0AH,'Count of Even numbers: $'
MSG2 DB 0DH,0AH,'Count of Odd numbers: $'
EVEN_COUNT DB 0
ODD_COUNT  DB 0
.CODE
MAIN PROC
  MOV AX, @DATA
  MOV DS, AX
  MOV CL,1
  MOV BL,10

  NEXT_NUM:
  MOV AL,CL
  MOV AH,0
  MOV DL,2
  DIV DL

  CMP AH,0
  JE EVEN_INC
  INC ODD_COUNT
  JMP CONTINUE

  EVEN_INC:
  INC EVEN_COUNT

  CONTINUE:
  INC CL 
  CMP CL,BL
  JBE NEXT_NUM

    ;------------------------------------
    ; Display even count
    ;------------------------------------
    LEA DX, MSG1
    MOV AH, 09H
    INT 21H

    MOV AL, EVEN_COUNT
    ADD AL, '0'
    MOV DL, AL
    MOV AH, 02H
    INT 21H

    ;------------------------------------
    ; Display odd count
    ;------------------------------------
    LEA DX, MSG2
    MOV AH, 09H
    INT 21H

    MOV AL, ODD_COUNT
    ADD AL, '0'
    MOV DL, AL
    MOV AH, 02H
    INT 21H

    ;------------------------------------
    ; Exit
    ;------------------------------------
    MOV AH, 4CH
    INT 21H
MAIN ENDP
END MAIN