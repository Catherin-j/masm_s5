.MODEL SMALL
.STACK 100h
.DATA
ARR DB 5,3,1,4,2
N   DB 5
MSG DB 0DH,0AH,'Sorted Array: $'

.CODE
MAIN PROC
    MOV AX,@DATA
    MOV DS,AX

    CALL SORT_ARRAY      ; call sorting procedure

    LEA DX,MSG
    MOV AH,09H
    INT 21H

    LEA SI,ARR
    MOV CL,N
DISPLAY:
    MOV AL,[SI]
    ADD AL,'0'
    MOV DL,AL
    MOV AH,02H
    INT 21H

    MOV DL,' '
    MOV AH,02H
    INT 21H
    
    INC SI
    DEC CL
    JNZ DISPLAY

    MOV AH,4CH
    INT 21H
MAIN ENDP

;------------------------------------
; Bubble Sort Procedure
;------------------------------------
SORT_ARRAY PROC
    LEA SI,ARR
    MOV CL,N
    DEC CL
OUTER:
    MOV CH,CL
    LEA SI,ARR
INNER:
    MOV AL,[SI]
    CMP AL,[SI+1]
    JBE NOSWAP
    XCHG AL,[SI+1]
    MOV [SI],AL
NOSWAP:
    INC SI
    DEC CH
    JNZ INNER
    DEC CL
    JNZ OUTER
    RET
SORT_ARRAY ENDP
END MAIN
