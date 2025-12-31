.MODEL SMALL
.STACK 100h
.DATA
STR  DB 'HELLO WORLD$',0
MSG1 DB 0DH,0AH,'Vowel Count: $'
COUNT DB 0

.CODE
MAIN PROC
    MOV AX, @DATA
    MOV DS, AX

    LEA SI,STR
    MOV COUNT ,0

    NEXT_CHAR:
    MOV AL,[SI]
    CMP AL,'$'
    JE DONE

    CMP AL,'A'
    JE Vowel
    CMP AL,'E'
    JE Vowel
    CMP AL,'I'
    JE Vowel
    CMP AL,'O'
    JE Vowel
    CMP AL,'U'
    JE Vowel
    JMP CONTINUE


    Vowel:
     inc COUNT
    CONTINUE:
    INC SI
    JMP NEXT_CHAR
    
    DONE:
    LEA DX, MSG1
    MOV AH, 09H
    INT 21H

    MOV AL, COUNT
    ADD AL, '0'
    MOV DL, AL
    MOV AH, 02H
    INT 21H

    MOV AH, 4CH
    INT 21H
MAIN ENDP
END MAIN