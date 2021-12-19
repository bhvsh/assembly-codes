; FIND MAX AND MIN. ELEMENT IN AN ARRAY

DATA SEGMENT
    ARR DB 10H,19H,13H,24H,15H,16H
    LEN DB $-ARR
    SML DB ?
    LRG DB ?
DATA ENDS

CODE SEGMENT
ASSUME CS:CODE,DS:DATA
START:
        MOV AX,DATA
        MOV DS,AX 
        
        MOV CL,00H       ; COUNT
        LEA SI,ARR       ; i=SI
        
        MOV AL,[SI]      ; AL <- FIRSE ELE. i.e, 10H
        MOV LRG,AL       ; STORING BASE ELE. ON "LRG"
        MOV SML,AL       ; STORING BASE ELE. ON "SML"
        
        M1: CMP CL,LEN      ;0 < 6
            JE BRU          ;CL = LEN  
        
            MOV AL,[SI]
            CMP AL,LRG      ;CHECKING FOR LARGEST ELEMENT W/ CURRENT ELEMENT
            JL L1
            MOV LRG,AL
            
            L1: CMP AL,SML  ;CHECKING FOR LARGEST ELEMENT W/ CURRENT ELEMENT
                JG L2
                MOV SML,AL
                
            L2: INC CL       
                INC SI
                JMP M1
        
   BRU: MOV AH,4CH
        INT 21H
    
CODE ENDS   
END START