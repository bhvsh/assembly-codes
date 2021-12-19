; PA1: Linear Search (for 16-bit numbers)
DATA SEGMENT
    ARRAY1 DW 1213H,2324H,3333H,4442H
    LEN DB $-ARRAY1
    LOC DB ?
    SY DB 10,13,"SEARCH SUCCESSFUL. FOUND THE ELEMENT AT $"
    SN DB 10,13,"SEARCH UNSUCCESSFUL. ELEMENT NOT FOUND$"
DATA ENDS

CODE SEGMENT
ASSUME CS:CODE,DS:DATA
START:
        MOV AX,DATA
        MOV DS,AX 
        
        MOV AX,2324H    ;ELEMENT YOU WANT TO SEARCH
        
        MOV CL,00       ; COUNT
        LEA SI,ARRAY1   ; i=SI
        
    M1: CMP CL,LEN      ;0 < 4
        JE NF           ;CL = LEN
        
        CMP AX,[SI]     ; AL <- FIRSE ELE. i.e, 10H
        JE FF
        
        ADD SI,02H
        INC CL
        JMP M1
        
    NF: LEA DX,SN   ;ELEMENT NOT FOUND, DISPLAY MSG FROM SN
        MOV AH,09
        INT 21H
        JMP EXIT
        
    FF: LEA DX,SY   ;ELEMENT FOUND; DISPLAY MSG FROM SY
        MOV AH,09
        INT 21H
    
        MOV LOC,CL ;ARRAY STARTS FROM 0 (LOC:1213H = 0)
        CALL DISPHEXA    
        
  EXIT: MOV AH,4CH ;DOS (21H) FUNCTION NUMBER
       INT 21H     ;TERMINATES THE PROGRAM WITH RETURN CODE
        
       DISPHEXA PROC NEAR
            ;=====1ST DIGIT TO DISPLAY
            MOV DL,LOC
                
            MOV CL,04H
            SHR DL,CL
                
            CMP DL,09H
            JBE L1
            ADD DL,07H
                       
            L1: ADD DL,30H
                MOV AH,02H
                INT 21H
                
            ;=====2ND DIGIT TO DISPLAY
                
            MOV DL,LOC
            AND DL,0FH
                
            CMP DL,09H
            JBE L2
            ADD DL,07H
                
            L2: ADD DL,30H
                MOV AH,02H
                INT 21H 
                
                RET  ;RETURN CONTROL TO MAIN PROGRAM
     DISPHEXA    ENDP
    
CODE ENDS   
END START