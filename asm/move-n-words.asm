DATA SEGMENT
    ARRAY1 DW 1122H,2233H,3344H,4455H
    LEN DB $-ARRAY1 ; (DS:0004) - (DS:0000) = (0710 * 10 + 0004) - (0710 * 10 + 0000)     
    
    ARRAY2 DW 4 DUP(?)
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
        
        MOV DX,[SI]     ; AL <- FIRST ELE. i.e, 10H
        MOV [DI],DX     ; MOV TO ARRAY
        
        INC SI
        INC DI
        INC CL
        JMP L1
        
  EXIT: MOV AH,4CH
        INT 21H
    
CODE ENDS   
END START