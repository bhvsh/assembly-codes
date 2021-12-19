DATA SEGMENT
    ARRAY1 DB 10H,20H,30H,40H
    LEN DB $-ARRAY1 ; (DS:0004) - (DS:0000) = (0710 * 10 + 0004) - (0710 * 10 + 0000)   
    LOC DB ?
DATA ENDS

CODE SEGMENT
ASSUME CS:CODE,DS:DATA
START:
        MOV AX,DATA
        MOV DS,AX 
        
        MOV AL,30H      ;ELEMENT YOU WANT TO SEARCH
        
        MOV CL,00       ; COUNT
        LEA SI,ARRAY1   ; i=SI
        
    L1: CMP CL,LEN      ;0 < 4
        JE EXIT         ;CL = LEN
        
        CMP AL,[SI]     ; AL <- FIRSE ELE. i.e, 10H
        JE EXIT
        
        INC SI
        INC CL
        JMP L1
        
  EXIT: MOV LOC,CL ;ARRAY STARTS FROM 0 (LOC:10H = 0)
                   ;LOC WILL BE NULL IF NO ELE. FOUND
        
        MOV AH,4CH
        INT 21H
    
CODE ENDS   
END START