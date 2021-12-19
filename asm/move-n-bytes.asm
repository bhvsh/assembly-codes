DATA SEGMENT
    ARRAY1 DB 10H,20H,30H,40H
    LEN DB $-ARRAY1 ; (DS:0004) - (DS:0000) = (0710 * 10 + 0004) - (0710 * 10 + 0000)     
    
    ARRAY2 DB 5 DUP(?)
DATA ENDS

CODE SEGMENT
ASSUME CS:CODE,DS:DATA
START:
        MOV AX,DATA
        MOV DS,AX 
        
        MOV CL,00       ; COUNT
        LEA SI,ARRAY1   ; i=SI
        LEA DI,ARRAY2   ; j
        
    L1: CMP CL,LEN      ;0 < 4
        JE EXIT         ;CL = LEN
        
        MOV AL,[SI]     ; AL <- FIRSE ELE. i.e, 10H
        MOV [DI],AL     ; MOV TO ARRAY
        
        INC SI
        INC DI
        INC CL
        JMP L1
        
  EXIT: MOV AH,4CH
        INT 21H
    
CODE ENDS   
END START