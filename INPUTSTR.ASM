        .MODEL SMALL
        .STACK 100H
        .DATA
        MSG DB 'ENTER THE INPUT$'
        NEWLINE DB 0DH,0AH,'$'
        
        BUF DB 21
            DB ?
            DB 21 DUP('$')
        .CODE
        MAIN PROC
        MOV AX,@DATA
        MOV DS,AX
        
        LEA DX,MSG
        MOV AH,09H
        INT 21H
        
        LEA DX,BUF
        MOV AH,0AH
        INT 21H
                                                
        LEA DX,NEWLINE
        MOV AH,09H
        INT 21H
        
        MOV AH,4CH
        INT 21H
        
        MAIN ENDP
        END MAIN
