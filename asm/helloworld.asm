DATA SEGMENT
    MSG1 DW 10,13,'Hello World!$'
    MSG2 DW 10,13,'This is an assembly-level program.$'  
DATA ENDS

CODE SEGMENT
ASSUME CS:CODE,DS:DATA
START:
    MOV AX,DATA
    MOV DS,AX
    
    LEA DX,MSG1
    MOV AH,09H
    INT 21H
    
    LEA DX,MSG2
    MOV AH,09H
    INT 21H

    MOV AH,4CH
    INT 21H
    
CODE ENDS   
END START