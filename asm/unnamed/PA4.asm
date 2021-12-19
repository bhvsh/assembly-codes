; PA4: Reverse a given string and check whether it's a palindrome or not

DATA SEGMENT
    S1 DB 20 DUP(?)
    S2 DB 20 DUP(?)
    N DB ?
    M1 DB 10,13,"ENTER A STRING: $"
    M2 DB 10,13,"GIVEN STRING IS A PALINDROME$"
    M3 DB 10,13,"GIVEN STRING IS NOT A PALINDROME$"
DATA ENDS

CODE SEGMENT
ASSUME CS:CODE,DS:DATA
START:
        MOV AX,DATA
        MOV DS,AX 
        
        LEA SI,S1
        LEA DI,S2
        
        LEA DX,M1
        MOV AH,09H
        INT 21H
        CALL READSTRING  ;CALL PROCEDURE "READSTRING"
        
        MOV N,CL
        MOV CL,00H
        DEC SI
        
        UP1:      ;REVERSING A STRING
        CMP CL,N 
        JZ CHK
        
        MOV AL,[SI]
        MOV [DI],AL
        
        DEC SI
        INC DI
        INC CL
        JMP UP1
        
        CHK:
        LEA SI,S1
        LEA DI,S2
        MOV CL,00H 
        
        ;STRING REVERSED AND SAVED TO S2
        
        UP2:       ;COMPARING ORIGINAL AND REVERSED STRING
        CMP CL,N
        JZ PALIT      ;IT'S A MATCH, STRING IS A PALINDROME
        
        MOV AL,[SI]
        CMP AL,[DI]
        JNZ PALIF     ;IF THERE'S NO MATCH, IT'S NOT A PALINDROME
        
        INC SI
        INC DI
        INC CL
        JMP UP2
              
 PALIF: LEA DX,M3     ;DISPLAY THE MSG THAT IT'S NOT A PALINDROME
        MOV AH,09H
        INT 21H
        JMP EXIT
        
 PALIT: LEA DX,M2     ;DISPLAY THE MSG THAT IT'S A PALINDROME
        MOV AH,09H
        INT 21H
        
        EXIT:
        MOV AH,4CH ;DOS (21H) FUNCTION NUMBER
        INT 21H    ;TERMINATES THE PROGRAM WITH RETURN CODE 
        
        READSTRING PROC
            MOV CL,00
            
        UP: CMP CL,20
            JZ L1
            
            MOV AH,01H
            INT 21H
            
            CMP AL,0DH
            JZ L1
            
            MOV [SI],AL
            INC SI
            INC CL
            JMP UP
            
        L1: RET
        READSTRING ENDP
        
CODE ENDS   
END START