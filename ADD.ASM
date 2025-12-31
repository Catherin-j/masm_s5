.MODEL SMALL
.STACK 100H
.DATA
MSG1 DB 'ENTER NO 1(0-9): $'
MSG2 DB ' ENTER NO 2(0-9): $'
MSG3 DB 'SUM :$'
NEWLINE DB 0DH,0AH,'$'

.CODE
MAIN PROC
MOV AX,@DATA
MOV DS,AX

LEA DX,MSG1   ;print msg 1
MOV AH,09H
INT 21H

MOV AH,01H   
;READ THE 1ST I/P FRM KEYBOARD
INT 21H

SUB AL,'0'    ;ascii to no
MOV BL,AL    
; MOVE 1ST NO TO BL REG       

LEA DX,NEWLINE
MOV AH,09H
INT 21H 

 ;print msg2
LEA DX,MSG2
MOV AH,09H
INT 21H

;READ THE 2nd I/P FRM KEYBOARD
MOV AH,01H                                                                                                                                                                                                                             
INT 21H

SUB AL,'0'

ADD BL,AL     ;ADDITION      

LEA DX,NEWLINE
MOV AH,09H
INT 21H  
          
LEA DX,MSG3  ;print MSG3
MOV AH,09H
INT 21H

ADD BL,'0'  ;  no  to ascii
MOV DL, BL

MOV AH,02H  ;PRINT CHAR
INT 21H

LEA DX,NEWLINE
MOV AH,09H
INT 21H    

MOV AH,4CH
INT 21H

MAIN ENDP
END MAIN

                                
