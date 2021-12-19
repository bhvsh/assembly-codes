DATA SEGMENT
    ARRAY1 DB 11H,22H,33H,44H,55H,66H
    LEN DB $-ARRAY1
    ARRAY2 DB 6 DUP(?)
DATA ENDS

CODE SEGMENT
ASSUME CS:CODE,DS:DATA
START:
        MOV AX,DATA
        MOV DS,AX 
        
        MOV CL,00       ; COUNT
        LEA SI,ARRAY1   ; i=SI
        LEA DI,ARRAY2   ; j
        
    L1: CMP CL,LEN      ;0 < 6
        JE CONT         ;CL = LEN
        
        MOV AL,[SI]     ; AL <- FIRSE ELE. i.e, 10H
        MOV [DI],AL     ; MOV TO ARRAY
        
        INC SI
        INC DI
        INC CL
        JMP L1
        
  CONT: MOV CL,00       ; COUNT        
        LEA DI,ARRAY2   ; j  

    L2: CMP CL,LEN      ;0 < 6
        JE EXIT         ;CL = LEN
        
        MOV AL,[DI]     ; AL <- FIRSE ELE. i.e, 10H
        
        INC DI
        INC CL
        
        MOV BL,[DI]
        
        DEC DI
        DEC CL
        
        MOV [DI],BL
        
        INC DI
        INC CL
        
        MOV [DI],AL
        
        INC DI
        INC CL
        JMP L2
        
  EXIT: MOV AH,4CH
        INT 21H
    
CODE ENDS   
END START