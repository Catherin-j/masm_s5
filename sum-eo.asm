.MODEL SMALL
.STACK 100h
.DATA
    msg1 DB 'Enter a 2-digit number: $'
    msg2 DB 13,10,'Sum of even digits: $'
    msg3 DB 13,10,'Sum of odd digits: $'
    tens DB ?
    ones DB ?
    sumEven DB 0
    sumOdd DB 0
.CODE
MAIN PROC
    MOV AX,@DATA
    MOV DS,AX

    ; Prompt for input
    LEA DX,msg1
    MOV AH,09
    INT 21h

    ; Read first digit (tens)
    MOV AH,01
    INT 21h
    SUB AL,30h
    MOV tens,AL

    ; Read second digit (ones)
    MOV AH,01
    INT 21h
    SUB AL,30h
    MOV ones,AL

    ; Initialize sums
    MOV sumEven,0
    MOV sumOdd,0

    ; Check tens digit
    MOV AL,tens
    MOV BL,AL        ; store original digit
    AND AL,1         ; check LSB
    CMP AL,0
    JE TEN_EVEN
    ; Odd
    ADD sumOdd,BL
    JMP CHECK_ONES

TEN_EVEN:
    ADD sumEven,BL

CHECK_ONES:
    MOV AL,ones
    MOV BL,AL        ; store original digit
    AND AL,1
    CMP AL,0
    JE ONE_EVEN
    ; Odd
    ADD sumOdd,BL
    JMP PRINT_RESULT

ONE_EVEN:
    ADD sumEven,BL

PRINT_RESULT:
    ; Print sum of even digits
    LEA DX,msg2
    MOV AH,09
    INT 21h
    MOV AL,sumEven
    ADD AL,30h
    MOV DL,AL
    MOV AH,02
    INT 21h

    ; Print sum of odd digits
    LEA DX,msg3
    MOV AH,09
    INT 21h
    MOV AL,sumOdd
    ADD AL,30h
    MOV DL,AL
    MOV AH,02
    INT 21h

    ; Exit program
    MOV AH,4Ch
    INT 21h
MAIN ENDP
END MAIN
