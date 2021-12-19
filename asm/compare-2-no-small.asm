DATA SEGMENT
    MSG1 DB 10,13,'SMALLEST NUMBER IS B$'
    MSG2 DB 10,13,'SMALLEST NUMBER IS A$'
    MSG3 DB 10,13,'BOTH ARE EQUAL$'
    
    A DB 13H
    B DB 15H
DATA ENDS

CODE SEGMENT
ASSUME CS:CODE,DS:DATA
START:
        MOV AX,DATA
        MOV DS,AX
    
        MOV AL,A
        CMP AL,B ; RR/RM/MR
        JG L1 ;AL>B...JUMP IF GREATER TO LABEL L1
        JL L2 ;AL<B...JUMP IF LESS TO LABEL L2
        
        LEA DX,MSG3 ; A AND B ARE EQUAL / JE
        MOV AH,09H
        INT 21H
        JMP EXIT ; UNCONDITIONAL JUMP TO LABEL EXIT
        
    L2: LEA DX,MSG2
        MOV AH,09H
        INT 21H
        JMP EXIT ; UNCONDITIONAL JUMP TO LABEL EXIT
                  
    L1: LEA DX,MSG1
        MOV AH,09H
        INT 21H 
        
    EXIT: MOV AH,4CH
          INT 21H
    
CODE ENDS   
END START