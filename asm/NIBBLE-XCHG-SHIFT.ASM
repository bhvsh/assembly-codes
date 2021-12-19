;Exchange the upper and lower nibbles of a register using Shift instructions

DATA SEGMENT
    
DATA ENDS

CODE SEGMENT
ASSUME CS:CODE,DS:DATA
START:
        MOV AX,DATA
        MOV DS,AX 
        
        MOV AL,34H     ;LOAD 34H TO AL
        MOV BL,AL      ;LOAD 34H TO BL
        MOV CL,04H     ;LOAD THE COUNTER VALUE TO CL
        
        SHL BL,CL      ;SHL PERFORMED ON BL 4 TIMES (SIZE OF NIBBLE)
                       ;BL: 34H -> 40H
        SHR AL,CL      ;SHR PERFORMED ON BL 4 TIMES (SIZE OF NIBBLE)
                       ;BL: 34H -> 03H
        
        ADD AL,BL      ;AL <- AL+BL (40H+03H = 43H)                           
        
        MOV AH,4CH ;DOS (21H) FUNCTION NUMBER
        INT 21H    ;TERMINATES THE PROGRAM WITH RETURN CODE
    
CODE ENDS   
END START