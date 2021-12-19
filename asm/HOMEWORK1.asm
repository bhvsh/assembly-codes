DATA SEGMENT

DATA ENDS

CODE SEGMENT
ASSUME CS:CODE,DS:DATA
START:         
        MOV DL,5CH    ;LOAD 5CH IN REGISTER D
        MOV CL,9EH    ;LOAD 9EH IN REGISTER C
        
        INC CL      ;INCREMENT C BY ONE
        
        ADD DL,CL   ;ADD ELEMENTS OF REGISTER C AND D
        MOV AL,DL
        
        OUT 01,AL   ;DISPLAY THE SUM AT OUTPUT PORT1 
        
        MOV AH,4CH
        INT 21H
CODE ENDS   
END START