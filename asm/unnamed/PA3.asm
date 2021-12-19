; PA3: Reading an alphanumeric character and displaying its 
; eq. ASCII Code at the center of a screen  

INCLUDE PA3_M1.MAC ; CLEAR SCREEN
INCLUDE PA3_M2.MAC ; SETCURSOR TO ROW,COLUMN

DATA SEGMENT
    MSG1 DB 10,13,"ENTER A CHARACTER: $"
    N DB ? 
DATA ENDS

CODE SEGMENT
ASSUME CS:CODE,DS:DATA
START:
    MOV AX,DATA
    MOV DS,AX
    
    LEA DX,MSG1
    MOV AH,09H
    INT 21H
    
    MOV AH,01H  ;READ A CHARACTER
    INT 21H
    MOV N,AL
    
    CLRSCR      ;INVOKE MACRO TO CLRSCR
    SETCURSOR 12,40 ; SETS THE CURSOR AT POS 12,40
    
    MOV BL,N
    CALL DISPHEXA
    
    MOV AH,01H ; Press a Key to proceed..
    INT 21H
    
    MOV AH,4CH ;DOS (21H) FUNCTION NUMBER
    INT 21H    ;TERMINATES THE PROGRAM WITH RETURN CODE
    
    DISPHEXA    PROC
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
                RET
     DISPHEXA    ENDP
    
CODE ENDS
END START