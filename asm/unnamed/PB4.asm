; PB4. Read a pair of 16-bit  numbers and compute their GCD

DATA SEGMENT
    A DW ?
    B DW ?
    TMP DW ?
    GCD DW ?
    N1 DB 10,13,"FIRST NUMBER: $"
    N2 DB 10,13,"SECOND NUMBER: $"
    MSG DB 10,13,"GCD: $" 
DATA ENDS

CODE SEGMENT
ASSUME CS:CODE,DS:DATA
START:
        MOV AX,DATA
        MOV DS,AX 
        
        LEA DX,N1
        MOV AH,09H
        INT 21H
        
        ;ENTER 1ST NUMBER
        LEA SI,A
        CALL READHEXA
        MOV [SI+1],AL
        CALL READHEXA
        MOV [SI], AL
        
        LEA DX,N2
        MOV AH,09H
        INT 21H  
        
        ; ENTER 2ND NUMBER
        LEA SI,B
        CALL READHEXA
        MOV [SI+1], AL
        CALL READHEXA
        MOV [SI], AL
       
       
       MOV AX,A
       MOV BX,B
        
   CHK: CMP AX,BX
        JE BRU
        JG S1
        
        MOV TMP,BX
        MOV BX,AX
        MOV AX,TMP
        
    S1: MOV DX,0000H
        DIV BX
        
        CMP AH,00H
        JE BRU
        
        MOV AL,AH
        MOV AH,00H
        MOV AX,CX
        JMP CHK    
        
   BRU: MOV GCD,BX
        
        LEA DX,MSG
        MOV AH,09H
        INT 21H
        
        LEA SI, GCD
        INC SI
        CALL DISPHEXA
        DEC SI
        CALL DISPHEXA
        MOV AH,4CH
        INT 21H
        
PROC READHEXA
    PUSH CX 
    
    MOV AH, 01H
    INT 21H             
    
    SUB AL, 30H
    CMP AL, 09H
    JLE I1
    SUB AL, 07H
    
    I1: MOV CL, 04H
        ROL AL, CL
        MOV CH, AL
        
    MOV AH, 01H
    INT 21H             
    
    SUB AL, 30H
    CMP AL, 09H
    JLE I2 
    SUB AL, 07H
    
    I2: ADD AL,CH
    
    POP CX
    
    RET
ENDP READHEXA

PROC DISPHEXA
    PUSH CX
    
    MOV AL, [SI]
    
    AND AL, 0F0H
    MOV CL, 04H
    ROL AL, CL
    
    ADD AL, 30H
    CMP AL, 39H
    JLE B1
    ADD AL, 07H
    
    B1: MOV AH, 02H
        MOV DL, AL
        INT 21H
        
    MOV AL, [SI]
    
    AND AL, 0FH
    
    ADD AL, 30H
    CMP AL, 39H
    JLE B2
    ADD AL, 07H
    
    B2: MOV AH, 02H
        MOV DL, AL
        INT 21H
        
    POP CX
    RET
ENDP DISPHEXA
    
CODE ENDS   
END START