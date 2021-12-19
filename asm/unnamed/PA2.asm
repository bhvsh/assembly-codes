; PA2: Read and display a string

INCLUDE PA2_M1.MAC     ;INCLUDE MACRO READCHAR
INCLUDE PA2_M2.MAC     ;INCLUDE MACRO DISPCHAR

DATA SEGMENT
    S DB 50 DUP(?)
    LEN DB ?
    MSG1 DB 10,13,"ENTER A STRING: ",10,13,'$'
    MSG2 DB 10,13,"ENTERED STRING IS: ",10,13,'$'
DATA ENDS

CODE SEGMENT
ASSUME CS:CODE,DS:DATA
START:
    MOV AX,DATA
    MOV DS,AX
    
    LEA DX,MSG1
    MOV AH,09H
    INT 21H
    
    CALL READSTRING ; PROCTO READ A STRING
    
    LEA DX,MSG2
    MOV AH,09H
    INT 21H
    
    CALL DISPSTRING ; PROCTO READ A STRING
    
    MOV AH,4CH 	;DOS (21H) FUNCTION NUMBER
    INT 21H    ;TERMINATES THE PROGRAM WITH RETURN CODE
    
    ;=====================================================================
    
    DISPSTRING PROC NEAR   ; "NEAR" IS OPTIONAL 
        MOV CL,00
        LEA SI,S
        
       UP2: CMP CL,LEN
            JZ L2
            
            MOV DL,[SI]
            DISPCHAR ; INVOKE MACRO TO DISP A CHAR
            
            INC SI
            INC CL
            JMP UP2
            
        L2: RET
        
    DISPSTRING ENDP
    
    ;=====================================================================
    
    READSTRING PROC ;PROC TO READ A STRING
        MOV CL,00
        LEA SI,S
    
    UP1:CMP CL,50 ; CHAR LIMIT SET TO 50
        JZ L1
        
        READCHAR ;MACRO TO READ A CHAR
        CMP AL,0DH ;0DH = ASCII ENTER; AL=ASCII VALUE OF CHAR
        JZ L1
        
        MOV [SI],AL
        
        INC SI
        INC CL
        JMP UP1
        
    L1: MOV LEN,CL
        RET
    READSTRING ENDP
    
CODE ENDS
END START
