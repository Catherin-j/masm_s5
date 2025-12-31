.MODEL SMALL
.STACK 100h
.DATA
MSG1   DB 'ENTER A NO (0-5): $'
MSG2   DB 0DH,0AH,'FACT: $'
NUM    DB ?
RESULT DW ?

.CODE
MAIN PROC
    MOV AX,@DATA
    MOV DS,AX

    ; Prompt
    LEA DX, MSG1
    MOV AH,09H
    INT 21H

    ; Read single-digit number
    MOV AH,01H
    INT 21H
    SUB AL,'0'       ; convert ASCII -> number

    CMP AL,0
    JB EXIT

    CMP AL,5
    JA EXIT
    
    MOV NUM,AL

    ; Compute factorial
    MOV CL,NUM
    MOV AX,1
    MOV RESULT,AX

FACT_LOOP:
    CMP CL,0
    JE DONE
    MOV AX,RESULT
    MOV BL,CL
    MUL BL
    MOV RESULT,AX
    DEC CL
    JMP FACT_LOOP

DONE:
    ; Print message
    LEA DX, MSG2
    MOV AH,09H
    INT 21H

    ; Print RESULT as decimal
    MOV AX,RESULT
    CALL PRINT_NUMBER

    ; Exit
EXIT:
    MOV AH,4CH
    INT 21H

MAIN ENDP

; --- Subroutine: Print 16-bit number in AX as decimal ---
PRINT_NUMBER PROC
    PUSH AX
    PUSH BX
    PUSH CX
    PUSH DX

    XOR CX,CX        ; digit counter
    MOV BX,10

CONVERT_LOOP:
    XOR DX,DX
    DIV BX           ; AX / 10 → quotient=AX, remainder=DX
    PUSH DX          ; remainder = digit
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
