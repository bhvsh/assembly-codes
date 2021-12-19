;ADD 2 ARRAY ELEMENTS AND STORE IT ON ANOTHER ARRAY

DATA SEGMENT
    ARRAY1 DB 10H,12H,13H,14H,15H,16H
    ARRAY2 DB 20H,08H,07H,06H,05H,04H
    ARRAY3 DB 6 DUP(?)
    LEN DB $-ARRAY1
DATA ENDS

CODE SEGMENT
ASSUME CS:CODE,DS:DATA
START:
        MOV AX,DATA
        MOV DS,AX 
        
        MOV CL,00       ; COUNT
        LEA SI,ARRAY1   ; i=SI
        LEA DI,ARRAY2   ; j
        LEA BX,ARRAY3
        
    L1: CMP CL,LEN      ;0 < 6
        JE EXIT         ;CL = LEN   
        
        MOV AL,[SI]
        ADD AL,[DI]
        MOV [BX],AL
        
        INC CL
        INC SI
        INC DI
        INC BX
        JMP L1
                
  EXIT: MOV AH,4CH
        INT 21H
    
CODE ENDS   
END START