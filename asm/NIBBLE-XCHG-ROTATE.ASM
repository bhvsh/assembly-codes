;Exchange the upper and lower nibbles of a register using Rotate instructions

DATA SEGMENT
    
DATA ENDS

CODE SEGMENT
ASSUME CS:CODE,DS:DATA
START:
        MOV AX,DATA
        MOV DS,AX 
        
        MOV BL,34H     ;LOAD 34H TO BL
        ROR BL,04      ;ROR PERFORMED ON BL 4 TIMES (SIZE OF NIBBLE)
                       ;BL: 34H -> 43H
                       
        
        MOV AH,4CH ;DOS (21H) FUNCTION NUMBER
        INT 21H    ;TERMINATES THE PROGRAM WITH RETURN CODE
    
CODE ENDS   
END START