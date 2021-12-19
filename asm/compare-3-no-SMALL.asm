DATA SEGMENT
    MSG1 DB 10,13,'SMALLEST NUMBER IS A$'
    MSG2 DB 10,13,'SMALLEST NUMBER IS B$'
    MSG3 DB 10,13,'SMALLEST NUMBER IS C$'
    ;IGNORING CASE A=B=C WHICH IS A RARE CASE
    
    A DB 10H
    B DB 05H
    C DB 09H
DATA ENDS

CODE SEGMENT
ASSUME CS:CODE,DS:DATA
START:
    MOV AX,DATA
    MOV DS,AX
    
    MOV AL,A
    CMP AL,B ; RR/RM/MR
    JG L2 ;AL>B...JUMP IF GREATER TO LABEL L1
    JL L1 ;AL<B...JUMP IF LESS TO LABEL L2
        
    L2: MOV AL,B
        CMP AL,C
        JG M4
        JL M3
        
        M4: LEA DX,MSG3
            MOV AH,09H
            INT 21H
            JMP EXIT
        
        M3: LEA DX,MSG2
            MOV AH,09H
            INT 21H
            JMP EXIT
                  
    L1: CMP AL,C
        JG M2
        JL M1
        
        M2: LEA DX,MSG3
            MOV AH,09H
            INT 21H
            JMP EXIT
        
        M1: LEA DX,MSG1
            MOV AH,09H
            INT 21H
            JMP EXIT 
        
    EXIT: MOV AH,4CH
          INT 21H
    
CODE ENDS   
END START