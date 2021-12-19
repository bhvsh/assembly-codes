; Design and code in assembly languague to randomly read a decimal(BCD) number to
; generate its multiplication table. 

DATA SEGMENT
    RN DB ?                              ;REQ. NUMBER (INPUT)
    MSG1 DB 10,13,"ENTER A NUMBER: $"    ;REQ. USER FOR INPUT
    MSG2 DB 10,13,"$"                    ;FOR NEW LINE
DATA ENDS

CODE SEGMENT
ASSUME CS:CODE,DS:DATA
START:
        MOV AX,DATA
        MOV DS,AX
        
    DISPBCD MACRO     ;MACRO TO DISPLAY BCD VALUES FROM BL
        PUSH CX
	    MOV DL,BL     ;DISP BCD VAL

        MOV CL,04
        SHR DL,CL
        
        ADD DL,30H
        
        MOV AH,02H
        INT 21H	      ;PRINT NUMBER1

        MOV DL,BL
        
        AND DL,0FH
        ADD DL,30H
        
        MOV AH,02H
        INT 21H		  ;PRINT NUMBER2
	    POP CX
    ENDM              ;END OF MACRO
    
        LEA DX,MSG1
        MOV AH,09H
        INT 21H       ;DISPLAY MSG1
        
        MOV AH,01H    ;DATA INPUT
        INT 21H       
        AND AL,0FH
        MOV RN,AL
        
        MOV CL,00H    ;SETTING UP COUNTER
            
  MULT: CMP CL,0AH    ;LOOP FOR MULTIPLICATION TABLE
        JE END        ;GOTO END IF IT REACHES THE COUNT OF 10
        
        INC CL        ;INCREMENT OF CL
        
        LEA DX,MSG2   ;DISPLAY MSG2 (NEW LINE)
        MOV AH,09H
        INT 21H
        
        MOV BL,RN     ;MOVE THE INPUT NUMBER TO BL FOR THE NEXT INSTRUCTION
        DISPBCD       ;DISPLAYS BCD VALUE FROM BL (MULTIPLICAND)
        
        MOV DL,'X'    ;DISPLAYS 'X'
        MOV AH,02H
        INT 21H
        
        CMP CL,0AH
        JL L1         ;JUMP TO L1 IF THE COUNTER DOESN'T REACH 10
        
        MOV BL,10H    ;DISPLAY THE VALUE OF MULTIPLIER 10
        DISPBCD
        JMP CC
        
    L1: MOV BL,CL     ;DISPLAY THE VALUE OF MULTIPLIER 1-9
        DISPBCD
       
    CC: MOV DL,'='    ;DISPLAYS EQUALS SIGN
        MOV AH,02H
        INT 21H
        
        MOV AL,CL     ;MOVING MULTIPLIER TO AL FOR MUX INSTRUCTION
        MUL RN        ;PERFORM MUX WITH RN AS A MULTIPLICAND : AX <- RN*AL
        AAM           ;ASCII ADJUST AX AFTER MUX
        SHL AH,04
        OR AL,AH      ;PACKING RESULT FROM AX INTO AL
        
        MOV BL,AL     ;MOVE THE RESULT TO BL FOR THE NEXT INSTRUCTION
        DISPBCD       ;DISPLAYS BCD VALUE FROM BL (RESULT)
        
        JMP MULT      ;GOTO MULT
        
    END: MOV AH,4CH  ;DOS (21H) FUNCTION NUMBER
        INT 21H      ;TERMINATES THE PROGRAM WITH RETURN CODE
        
CODE ENDS   
END START