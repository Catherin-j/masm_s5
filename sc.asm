.MODEL SMALL
.STACK 100h
.DATA
MSG1    DB 'Enter a number (0-9): $'
MSG2    DB 0DH,0AH,'Choose: 1=Square, 2=Cube: $'
MSG3    DB 0DH,0AH,'Result: $'
NUM     DB ?
CHOICE  DB ?
RESULT  DW ?

.CODE
MAIN PROC
    MOV AX,@DATA
    MOV DS,AX

    ; --- Input number ---
    LEA DX, MSG1
    MOV AH,09H
    INT 21H

    MOV AH,01H
    INT 21H
    SUB AL,'0'
    MOV NUM,AL

    ; --- Input choice ---
    LEA DX, MSG2
    MOV AH,09H
    INT 21H

    MOV AH,01H
    INT 21H
    SUB AL,'0'
    MOV CHOICE,AL

    ; --- Calculate square ---
    MOV AL,NUM
    MUL AL           ; AL*AL → AX
    MOV RESULT,AX

    ; --- Check choice ---
    CMP CHOICE,1
    JE PRINT_RESULT      ; if square, print RESULT

    CMP CHOICE,2
    JE CUBE_CALC         ; if cube, calculate cube

    JMP EXIT             ; invalid choice

CUBE_CALC:
    ; Cube = square * NUM
    MOV AX,RESULT       ; AX = NUM^2
    MOV BL,NUM
    MUL BL              ; AX = NUM^2 * NUM = NUM^3
    MOV RESULT,AX

PRINT_RESULT:
    LEA DX, MSG3
    MOV AH,09H
    INT 21H

    MOV AX,RESULT
    CALL PRINT_NUMBER

EXIT:
    MOV AH,4CH
    INT 21H
MAIN ENDP

; --- Print AX as decimal ---
PRINT_NUMBER PROC
    PUSH AX
    PUSH BX
    PUSH CX
    PUSH DX

    XOR CX,CX
    MOV BX,10

CONVERT_LOOP:
    XOR DX,DX
    DIV BX
    PUSH DX
    INC CX
    CMP AX,0
    JNE CONVERT_LOOP

PRINT_LOOP:
    POP DX
    ADD DL,'0'
    MOV AH,02H
    INT 21H
    LOOP PRINT_LOOP

    POP DX
    POP CX
    POP BX
    POP AX
    RET
PRINT_NUMBER ENDP

END MAIN
