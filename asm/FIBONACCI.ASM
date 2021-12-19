; DISPLAY FIBONACCI NUMBERS UPTO 'N'

DATA SEGMENT
    F0 DB 00H   ;F0 = 0 (INITIAL CONDITION)
    F1 DB 01H   ;F1 = 1 (INITIAL CONDITION)
    F2 DB ?
    N DB 0AH    ;NUMBER OF VALUES TO DISPLAY (SET TO 10)
    MSG DB 10,13,'FIBONACCI SERIES: $'
DATA ENDS   

CODE SEGMENT
ASSUME CS:CODE,DS:DATA
START:
        MOV AX,DATA
        MOV DS,AX     
        
        SPC MACRO         ;(MACRO) LEAVE A SPACE AFTER PRINTING VALUE
            MOV DL,' '
            MOV AH,02H
            INT 21H
        ENDM 
        
        LEA DX,MSG        ;STARTING MESSAGE
        MOV AH,09H
        INT 21H   
        
        MOV CL,02H        ;INITIALIZE COUNTER TO 02 BECAUSE OF F0 AND F1
        MOV BL,F0
        CALL DISPHEXA     ;PRINT F0
        SPC 
                          
        MOV BL,F1
        CALL DISPHEXA     ;PRINT F1
        SPC
        
      UP:                 ;PRINT F2, F3, F4........ VALUES
        CMP CL,N
        JE EXIT
        
        MOV AL,F0
        ADD AL,F1 
        MOV F2,AL    
        MOV BL,AL
        
        CALL DISPHEXA
        SPC
        
        MOV AL,F1
        MOV F0,AL 
        MOV AL,F2
        MOV F1,AL
         
        INC CL
        JMP UP  
        
       EXIT:
        MOV AH,4CH ;DOS (21H) FUNCTION NUMBER
        INT 21H    ;TERMINATES THE PROGRAM WITH RETURN CODE 
    
      DISPHEXA PROC NEAR
            ; PROB: CL used as counter in MAIN
            PUSH CX   ;CONFLICT RESOLUTION
            
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
                
                POP CX ;CONFLICT RESOLUTION
                RET
     DISPHEXA    ENDP   
      
CODE ENDS
END START