.MODEL SMALL
.STACK 100h

.DATA
buffer DB 20           ; Max input length (excluding Enter)
       DB ?            ; Actual length entered (filled by DOS)
       DB 20 DUP(?)    ; Input characters
msg    DB 'Vowel count: $'
newline DB 13, 10, '$'

.CODE
MAIN PROC
    MOV AX, @DATA
    MOV DS, AX

    ; Prompt user to enter a string
    MOV AH, 09h
    LEA DX, newline
    INT 21h
    MOV AH, 09h
    LEA DX, msg
    INT 21h
    MOV AH, 09h
    LEA DX, newline
    INT 21h

    ; Read string from user
    MOV AH, 0Ah
    LEA DX, buffer
    INT 21h

    ; Initialize
    LEA SI, buffer + 2   ; Start of input
    MOV CL, buffer[1]           ; Number of characters entered
    MOV CH, 0                   ; Vowel count

NEXT_CHAR:
    MOV AL, [SI]
    CMP AL, 'A'
    JE COUNT
    CMP AL, 'E'
    JE COUNT
    CMP AL, 'I'
    JE COUNT
    CMP AL, 'O'
    JE COUNT
    CMP AL, 'U'
    JE COUNT
    CMP AL, 'a'
    JE COUNT
    CMP AL, 'e'
    JE COUNT
    CMP AL, 'i'
    JE COUNT
    CMP AL, 'o'
    JE COUNT
    CMP AL, 'u'
    JE COUNT
    JMP SKIP

COUNT:
    INC CH

SKIP:
    INC SI
    DEC CL
    JNZ NEXT_CHAR

    ; Print result
    MOV AH, 09h
    LEA DX, newline
    INT 21h
    MOV AH, 09h
    LEA DX, msg
    INT 21h
    MOV DL, CH
    ADD DL, '0'
    MOV AH, 02h
    INT 21h

    ; Exit
    MOV AH, 4Ch
    INT 21h
MAIN ENDP
END MAIN