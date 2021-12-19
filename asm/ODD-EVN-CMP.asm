DATA SEGMENT
    ARRAY1 DB 11H,22H,33H,44H,50H,60H
    LEN DB $-ARRAY1
    ODD DB ?
    EVN DB ?
DATA ENDS

CODE SEGMENT
ASSUME CS:CODE,DS:DATA
START:
        MOV AX,DATA
        MOV DS,AX 
        
        MOV CL,00       ; COUNT
        LEA SI,ARRAY1   ; i=SI
        
        MOV BH,00
        MOV CH,00
        MOV BL,2
        
        L1: CMP CL,LEN      ;0 < 6
            JE BRU         ;CL = LEN  
            
            MOV AL,[SI]
            MOV AH,00
            
            DIV BL
            
            CMP AH,1
            JE MA
        
            INC BH
            JMP RES
           
        MA: INC CH
        
       RES: INC SI
            INC CL
            
            JMP L1
        
   BRU: MOV ODD,CH
        MOV EVN,BH
        
        MOV AH,4CH
        INT 21H
    
CODE ENDS   
END START