.MODEL SMALL
.STACK 100h
.DATA
BUF      DB 100          ; Maximum buffer size
LEN      DB ?            ; DOS stores actual length here
STR      DB 100 DUP(?)   ; Input buffer
MSG1     DB 'Enter a string: $'
MSG2     DB 13,10,'Vowels: $'
MSG3     DB 13,10,'Consonants: $'
MSG4     DB 13,10,'Digits: $'
MSG5     DB 13,10,'Spaces: $'
MSG6     DB 13,10,'Special characters: $'

VOWEL    DB 0
CONS     DB 0
DIGIT    DB 0
SPACE    DB 0
SPEC     DB 0

.CODE
MAIN PROC
    MOV AX,@DATA
    MOV DS,AX

    ; Prompt user
    LEA DX,MSG1
    MOV AH,09H
    INT 21H

    ; Read string
    LEA DX,BUF
    MOV AH,0AH
    INT 21H

    ; Initialize counters
    XOR SI,SI
    XOR VOWEL, VOWEL
    XOR CONS, CONS
    XOR DIGIT, DIGIT
    XOR SPACE, SPACE
    XOR SPEC, SPEC

    MOV CL,[BUF+1]       ; Length of input
    MOV CH,0
    MOV BH,0             ; index

PROCESS_LOOP:
    CMP BH,CL
    JAE PRINT_RESULTS    ; All characters processed
    MOV AL,[BUF+2+BH]    ; Get character

    ; Check space
    CMP AL,' '
    JE IS_SPACE

    ; Check digit
    CMP AL,'0'
    JB CHECK_ALPHA
    CMP AL,'9'
    JA CHECK_ALPHA
    INC DIGIT
    JMP NEXT_CHAR

CHECK_ALPHA:
    ; Check uppercase vowel
    CMP AL,'A'
    JB CHECK_LOW_VOWEL
    CMP AL,'Z'
    JA CHECK_LOW_VOWEL
    ; It's uppercase letter
    CMP AL,'A'
    JE IS_VOWEL
    CMP AL,'E'
    JE IS_VOWEL
    CMP AL,'I'
    JE IS_VOWEL
    CMP AL,'O'
    JE IS_VOWEL
    CMP AL,'U'
    JE IS_VOWEL
    INC CONS
    JMP NEXT_CHAR

CHECK_LOW_VOWEL:
    ; Check lowercase letter
    CMP AL,'a'
    JB IS_SPECIAL
    CMP AL,'z'
    JA IS_SPECIAL
    CMP AL,'a'
    JE IS_VOWEL
    CMP AL,'e'
    JE IS_VOWEL
    CMP AL,'i'
    JE IS_VOWEL
    CMP AL,'o'
    JE IS_VOWEL
    CMP AL,'u'
    JE IS_VOWEL
    INC CONS
    JMP NEXT_CHAR

IS_VOWEL:
    INC VOWEL
    JMP NEXT_CHAR

IS_SPACE:
    INC SPACE
    JMP NEXT_CHAR

IS_SPECIAL:
    INC SPEC

NEXT_CHAR:
    INC BH
    JMP PROCESS_LOOP

PRINT_RESULTS:
    ; Display vowel count
    LEA DX,MSG2
    MOV AH,09H
    INT 21H
    MOV AL,VOWEL
    ADD AL,'0'
    MOV DL,AL
    MOV AH,02H
    INT 21H

    ; Display consonant count
    LEA DX,MSG3
    MOV AH,09H
    INT 21H
    MOV AL,CONS
    ADD AL,'0'
    MOV DL,AL
    MOV AH,02H
    INT 21H

    ; Display digit count
    LEA DX,MSG4
    MOV AH,09H
    INT 21H
    MOV AL,DIGIT
    ADD AL,'0'
    MOV DL,AL
    MOV AH,02H
    INT 21H

    ; Display space count
    LEA DX,MSG5
    MOV AH,09H
    INT 21H
    MOV AL,SPACE
    ADD AL,'0'
    MOV DL,AL
    MOV AH,02H
    INT 21H

    ; Display special character count
    LEA DX,MSG6
    MOV AH,09H
    INT 21H
    MOV AL,SPEC
    ADD AL,'0'
    MOV DL,AL
    MOV AH,02H
    INT 21H

    ; Exit
    MOV AH,4CH
    INT 21H

MAIN ENDP
END MAIN
