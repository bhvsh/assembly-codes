DATA SEGMENT
    ARRAY1 DB 10H,20H,30H,40H
    LEN DB $-ARRAY1 ; (DS:0004) - (DS:0000) = (0710 * 10 + 0004) - (0710 * 10 + 0000)
    AVG DB ?
DATA ENDS

CODE SEGMENT
ASSUME CS:CODE,DS:DATA
START:
        MOV AX,DATA
        MOV DS,AX 
        
        MOV CL,00       ; COUNT
        LEA SI,ARRAY1   ; i=SI
        
        MOV AL,[SI]     ; AL <- FIRSE ELE. i.e, 10H
        INC SI
        INC CL
        
    L1: CMP CL,LEN      ;0 < 4
        JE BRU         ;CL = LEN  
        
        ADD AL,[SI]
        
        INC SI
        INC CL
        JMP L1
        
   BRU: MOV AH,00
        ADC AH,00
   
        MOV BL,LEN
        DIV BL
        
        MOV AVG,AL
        MOV AH,4CH
        INT 21H
    
CODE ENDS   
END START