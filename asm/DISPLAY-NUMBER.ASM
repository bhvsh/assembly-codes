;DISPLAY 2 DIGIT NUMBER ON THE SCREEN

DATA SEGMENT
    
DATA ENDS

CODE SEGMENT
ASSUME CS:CODE,DS:DATA
START:
        MOV AX,DATA
        MOV DS,AX 
        
        MOV BL,0A9H    ;number to display
        CALL DISPHEXA       
        
        MOV AH,4CH
        INT 21H
        
      DISPHEXA PROC NEAR
            
            ;=====1ST DIGIT TO DISPLAY
            MOV DL,BL
                
            MOV CL,04H
            SHR DL,CL
                
            CMP DL,09H
            JBE L1
            ADD DL,07H
                       
            L1: ADD DL,30H
                MOV AH,02H
                INT 21H
                
            ;=====2ND DIGIT TO DISPLAY
                
            MOV DL,BL
            AND DL,0FH
                
            CMP DL,09H
            JBE L2
            ADD DL,07H
                
            L2: ADD DL,30H
                MOV AH,02H
                INT 21H 
                
            ;=========================
                
                RET
     DISPHEXA    ENDP
    
CODE ENDS   
END START