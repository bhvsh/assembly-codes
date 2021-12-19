;PA5. Read your name from the keyboard and display it at a specified location 
;     on the screen in front of the message “What is your name?
;     You must clear the entire screen before display.

INCLUDE PA5_F3.mac   ;FOR MACRO CLRSCR
INCLUDE PA5_F4.mac   ;FOR MACRO SETCURSOR

DATA SEGMENT
    MSG1 DB "ENTER YOUR NAME: $"
    MSG2 DB "WHAT'S YOUR NAME? $"
    STR DB 30 DUP(?)
    N DB ?
DATA ENDS        

CODE SEGMENT
ASSUME CS:CODE,DS:DATA
START:
    MOV AX,DATA
    MOV DS,AX
    
    LEA DX,MSG1 
    MOV AH,09H 
    INT 21H 
    
    LEA SI,STR 
    CALL READSTRING 
    MOV N,CL 
    
    CLRSCR 
    SETCURSOR 10,30 

    LEA DX,MSG2 
    MOV AH,09H 
    INT 21H 
    
    LEA SI,STR 
    MOV CL,N 
    
    CALL DISPSTRING 
    MOV AH,01H 
    INT 21H 
    
    MOV AH,4CH 
    INT 21H
    
     
    READSTRING PROC NEAR     ;PROCEDURE TO READ STRING
        MOV CL,00H 
        UP1: CMP CL,30 
          JZ L1 
        
          MOV AH,01H 
          INT 21H 
        
          CMP AL,0DH 
          JZ L1 
        
          MOV [SI],AL 
          INC SI 
          INC CL 
        
          JMP UP1 
        L1:    RET 
    READSTRING ENDP 

    DISPSTRING PROC NEAR     ;PROCEDURE TO DISPLAY STRING
        UP2: CMP CL,00H 
          JZ L2 
        
          MOV DL,[SI] 
          MOV AH,02H 
          INT 21H 
        
          INC SI 
          DEC CL 
        
          JMP UP2 
        L2:    RET 
    DISPSTRING ENDP 

CODE ENDS 
END START 
