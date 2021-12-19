;PB3. Sort a given set of ‘n’ numbers in ascending 
;     and descending orders using the Selection Sort algorithm.

DATA SEGMENT 
    ARR DB 64H,62H,18H,43H,22H,53H
    LEN DB $-A
    FLG DB 00H 
    MSG1 DB 10,13,'SORTED IN ASCENDING...$'
    MSG2 DB 10,13,'SORTED IN DESCENDING...$' 
DATA ENDS      


CODE SEGMENT 
    ASSUME CS: CODE, DS: DATA 
START: 
    MOV AX, DATA 
    MOV DS, AX 

    DEC LEN                   ;N-1
    RST:MOV DX, 0000H 
        MOV BX, 0000H 
       
    
    UP2:CMP DL,LEN               ;I<N-1
        JZ DISP 
        
        MOV BL, DL              ;SMALLEST_IDX=I
        MOV CX,DX               ;CX SET AS IDX FOR ARR
        INC CL                  ;J=J+1
                                                  
                                                  
    UP1:CMP CL,LEN                ;J<N-1
        JA SWAP   
         
        LEA SI,ARR 
        ADD SI,CX 
        MOV AL, [SI]            ;MOVING TO NEXT ELEMENT TO COMPARE
        CMP FLG,00H
        JE ASC
        JG DSC
        
           ASC: CMP ARR[BX], AL         
                JBE SKIP                ;JBE FOR ASCENDING ORDER
                JMP CT
                
           DSC: CMP ARR[BX],AL          
                JAE SKIP                ;JAE FOR DESCENDING ORDER
    
    CT:MOV BX, SI              ;[SI] < [BX]
    
    SKIP: 
        INC CL 
        JMP UP1 
   
    SWAP: 
        LEA SI,ARR
        ADD SI,DX                   
        MOV AL,[SI]  
        
        XCHG AL,ARR[BX]            
        MOV [SI], AL 
        INC DL 
        JMP UP2 
   
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
        LEA SI,ARR

    UP3:CMP CL,LEN 
        JA EXIT 
        MOV BL, [SI] 
        CALL DISPHEXA  
        
        MOV DL,' '    ;LEAVE A SPACE AFTER OMITTING EVERY ARRAY ELEMENT
        MOV AH,02H
        INT 21H
        
        
        INC CL 
        INC SI 
        JMP UP3    
    
       
   EXIT:
       CMP FLG,00H ;THIS WILL DECIDE THE ORDER TYPE FOR SELECT SORT
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
