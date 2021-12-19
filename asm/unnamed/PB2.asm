; PB2: SORT A GIVEN SET OF N NUMBERS IN ASCENDING AND DESCENDING ORDER
; USING THE BUBBLE SORT ALGORITHM

DATA SEGMENT
    A DB 34H,67H,11H,43H,88H,23H
    LEN DB $-A
    FLG DB 00H 
    MSG1 DB 10,13,'SORTED IN ASCENDING...$'
    MSG2 DB 10,13,'SORTED IN DESCENDING...$'   
DATA ENDS

CODE SEGMENT
ASSUME CS:CODE,DS:DATA
START:
        MOV AX,DATA
        MOV DS,AX 
        
        DEC LEN         ;N-1
   RST: MOV CL,00H      ;INDEX i / iTH ELEMENT (COUNTER)
        
   UP2: CMP CL,LEN      ;OUTER LOOP i < N-1
        JZ DISP
        ;JZ DISPLAY      ;BUBBLE SORT COMPLETE, DISPLAY THE OUTPUT
        
        MOV BX,0000H
        MOV DL,LEN
        SUB DL,CL       ;N-i-1 
        
   UP1: CMP BL,DL       ;INNER LOOP
        JZ D1
        
        MOV AL,A[BX] 
        CMP FLG,00H
        JE ASC
        JG DSC
        
           ASC: CMP AL,A[BX+1]
                JBE NOSWAP      ;JBE FOR ASCENDING ORDER
                JMP CT
                
           DSC: CMP AL,A[BX+1]
                JAE NOSWAP      ;JAE FOR DESCENDING ORDER
                     
    CT: MOV AH,A[BX+1] 
        MOV A[BX],AH
        MOV A[BX+1],AL  ;SWAPPING ARR. ELEMENT OF INDEX BX AND BX+1
        
    NOSWAP:
        INC BL
        JMP UP1
        
    D1: INC CL
        JMP UP2
        
        MOV AH,4CH
        INT 21H
        
    DISP:
        CMP FLG,00H
        JE DISPLAY1
        JG DISPLAY2
    
    DISPLAY1:
        INC FLG
        LEA DX,MSG1 ;DISPLAY THE MESSAGE "SORTING IN ASCENDING..."
        MOV AH,09H
        INT 21H
        JMP C1
        
    DISPLAY2:
        DEC FLG
        LEA DX,MSG2 ;DISPLAY THE MESSAGE "SORTING IN DESCENDING..."
        MOV AH,09H
        INT 21H
        
    C1: MOV CL,00H
        LEA SI,A
        
  UP3: CMP CL,LEN
       JA EXIT
       MOV BL,[SI]
       
       CALL DISPHEXA
       
       MOV DL,' ' ;LEAVE A SPACE AFTER OMITTING EVERY ARRAY ELEMENT
       MOV AH,02H
       INT 21H
       
       INC SI
       INC CL
       JMP UP3
       
   EXIT:
       CMP FLG,00H ;THIS WILL DECIDE THE ORDER TYPE FOR BUBBLE SORT
       JG RST 
       
       MOV AH,4CH ;DOS (21H) FUNCTION NUMBER
       INT 21H    ;TERMINATES THE PROGRAM WITH RETURN CODE
       
       DISPHEXA PROC NEAR
            ; PROB: CL used as counter in MAIN
            PUSH CX   ;CONFLICT RESOLUTION
            
            ;=====1ST DIGIT TO DISPLAY
            MOV DL,BL
                
            MOV CL,04H
            SHR DL,CL
                
            CMP DL,09H
            JBE L1
            ADD DL,07H
                       
            L1: ADD DL,30H
                MOV AH,02H
                INT 21H
                
            ;=====2ND DIGIT TO DISPLAY
                
            MOV DL,BL
            AND DL,0FH
                
            CMP DL,09H
            JBE L2
            ADD DL,07H
                
            L2: ADD DL,30H
                MOV AH,02H
                INT 21H 
                
            ;=========================
                
                POP CX ;CONFLICT RESOLUTION
                RET
     DISPHEXA    ENDP
      
CODE ENDS   
END START