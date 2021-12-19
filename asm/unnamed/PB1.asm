; PB1: BINARY SEARCH FOR 'N' 8-BIT NUMBERS

DATA SEGMENT
    ARR DB 12H,24H,36H,48H,60H,72H
    LEN DB $-ARR
    
    MID DB ? ;VARIABLE TO STORE THE POSITION "MID" 
    
    MSG1 DB 10,13,"SEARCH SUCCESS, FOUND AT POSITION $"
    MSG2 DB 10,13,"SEARCH UNSUCCESSFUL $"    
DATA ENDS

CODE SEGMENT
ASSUME CS:CODE,DS:DATA
START:
        MOV AX,DATA
        MOV DS,AX 
        
        MOV CL,48H ;KEY ELEMENT
        
        MOV DL,00H ;LOWER LIMIT IN ARRAY
        MOV DH,LEN ;HIGHER LIMIT IN ARRAY
        
        DEC DH
        MOV BX,0000H
        
    UP: CMP DL,DH ;WHILE LOW<=HIGH
        JG NF
        
        MOV BL,DL
        ADD BL,DH  ;LOW+HIGH
        SHR BL,01H ;(LOW+HIGH)/2
        MOV MID,BL
        
        CMP CL,ARR[BX]
        JZ FF
        JB PART1    ; IF KEY<MID PART1
        INC MID
        MOV DL,MID  ;ELSE PART2
        JMP UP
        
 PART1: DEC MID
        MOV DH,MID ;HIGH = MID-1
        JMP UP
        
    NF: LEA DX,MSG2     ;SEARCH UNSUCESSFUL
        MOV AH,09H
        INT 21H
        JMP EXIT
        
    FF: LEA DX,MSG1     ;SEARCH SUCCESS
        MOV AH,09H
        INT 21H
        MOV BL,MID
        INC BL          ;MID = MID+1
        CALL DISPHEXA   ;FLASH THE RESULT ON THE SCREE
        
  EXIT: MOV AH,4CH ;DOS (21H) FUNCTION NUMBER
        INT 21H    ;TERMINATES THE PROGRAM WITH RETURN CODE
        
        DISPHEXA PROC NEAR
            ;=====1ST DIGIT TO DISPLAY
            MOV DL,MID
                
            MOV CL,04H
            SHR DL,CL
                
            CMP DL,09H
            JBE L1
            ADD DL,07H
                       
            L1: ADD DL,30H
                MOV AH,02H
                INT 21H
                
            ;=====2ND DIGIT TO DISPLAY
                
            MOV DL,MID
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