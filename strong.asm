.MODEL SMALL
.STACK 100H

.DATA
    msg1    DB 0Ah,0Dh,'Enter a 3-digit number (100-999):$'
    msg2    DB 0Ah,0Dh,'Result: Is a Strong Number.$'
    msg3    DB 0Ah,0Dh,'Result: Is NOT a Strong Number.$'

    num  DW ?           ; Stores the input number
    sum  DW 0           ; Stores sum of factorials
    buf  DB 3 DUP(?)    ; To store input digits

    ; Factorial lookup table for digits 0–9
    FACT_TABLE DW 1, 1, 2, 6, 24, 120, 720, 5040

.CODE
MAIN PROC
    MOV AX, @DATA
    MOV DS, AX

; -----------------------------------------------------------------
; 1. INPUT NUMBER (Read 3 Digits and Store them)
; -----------------------------------------------------------------
    LEA DX, msg1
    MOV AH, 09H
    INT 21H

    LEA SI, buf
    MOV CX, 3

read_loop:
    MOV AH, 01H
    INT 21H
    MOV [SI], AL
    INC SI
    LOOP read_loop

; -----------------------------------------------------------------
; 2. CONVERT INPUT DIGITS TO ACTUAL NUMBER
; -----------------------------------------------------------------
    LEA SI, buf
    MOV AX, 0

    ; 100s digit
    MOV AL, [SI]
    SUB AL, '0'
    MOV AH, 0
    MOV BL, 100
    MUL BL
    PUSH AX

    ; 10s digit
    INC SI
    MOV AL, [SI]
    SUB AL, '0'
    MOV AH, 0
    MOV BL, 10
    MUL BL
    POP BX
    ADD AX, BX
    PUSH AX

    ; 1s digit
    INC SI
    MOV AL, [SI]
    SUB AL, '0'
    MOV AH, 0
    POP BX
    ADD AX, BX

    MOV num, AX      ; Store original number

; -----------------------------------------------------------------
; 3. CALCULATE SUM OF FACTORIALS OF DIGITS
; -----------------------------------------------------------------
    LEA SI, buf
    MOV CX, 3
    MOV sum, 0

factorial_loop:
    MOV AL, [SI]
    SUB AL, '0'        ; Convert char to number 0–9
    MOV BL, AL
    MOV BH, 0
    SHL BX, 1           ; Multiply BX by 2 (word offset)
    MOV AX, FACT_TABLE[BX]
    ADD sum, AX
    INC SI
    LOOP factorial_loop

; -----------------------------------------------------------------
; 4. CHECK STRONG NUMBER
; -----------------------------------------------------------------
    MOV AX, sum
    CMP AX, num
    JE strong_num

not_strong:
    LEA DX, msg3
    MOV AH, 09H
    INT 21H
    JMP exit_prog

strong_num:
    LEA DX, msg2
    MOV AH, 09H
    INT 21H

; -----------------------------------------------------------------
; 5. EXIT PROGRAM
; -----------------------------------------------------------------
exit_prog:
    MOV AH, 4CH
    INT 21H

MAIN ENDP
END MAIN
