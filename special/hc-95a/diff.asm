J0000:	DI
        JP	J01A7			; first initalize some HD64180 register

; ....


J0180:	PUSH	AF
J0181:	IN	A,(C)
        LD	(HL),A
        INC	HL
        DEC	B
        JP	NZ,J0181
        POP	AF
        DEC	A
        RET	

        DEFS	0190H-$,0

J0190:	PUSH	AF
J0191:	LD	A,(HL)
        OUT	(C),A
        INC	HL
        DEC	B
        JP	NZ,J0191
        POP	AF
        DEC	A
        RET	

        DEFS	01A0H-$,0

J01A0:	OUT	(98H),A
        NOP	
        DEC	C
        JP	J084D

J01A7:	LD	A,0A0H			; Memory wait=2, I/O wait=2, DREQ1 level, DREQ0 level, DMA1 mode 2
        DEFB	0EDH
        DEFB	039H
        DEFB	032H			; OUT0 (032H),A
        LD	A,0BFH			; refresh enable, no refresh wait, interval 80 states
        DEFB	0EDH
        DEFB	039H
        DEFB	036H			; OUT0 (036H),A
        JP	J0416

; ....

J0762:	CALL	J0180			; replace INIR and DEC A

; ....

J07A4:	CALL	J0190			; replace OTIR and DEC A

; ....

J084A:	CALL	J01A0			; replace OUT (98H),A and DEC C



;  
;   SUBROM -> Source re-created by Z80DIS 2.2
;      Z80DIS was written by Kenneth Gielow
;                            Palo Alto, CA
;

J07BD:	CALL	J3FD4			; replace INIR and DEC A

; ....

J07D2:	CALL	J3FC0			; replace OTIR and DEC A

; ....

J0981:	CALL	J3FB0			; replace OUT (98H),A and DEC C

; ....

J0A5E:	CALL	J3FB8			; replace OUT (98H),A and INC A

; ....

J0AC5:	CALL	J3FB8			; replace OUT (98H),A and INC A

; ....

J0F28:	JP	J3FE0			; replace INIR and RET

; ....

J0F32:	JP	J3FF0			; replace OTIR and RET

; ....

J0F77:	EX	(SP),HL			; replace NOP
        EX	(SP),HL			; replace NOP

; ....

?11A3:	PUSH	BC
        PUSH	AF
        LD	A,02H
        OUT	(99H),A
        LD	A,8FH
        OUT	(99H),A
        POP	AF
        LD	B,7
J11B0:	PUSH	AF
J11B1:	IN	A,(99H)
        RRCA	
        JR	C,J11C5
        LD	A,00H
        OUT	(99H),A
        LD	A,8FH
        OUT	(99H),A
        POP	AF
        POP	BC
        LD	B,1
        JP	J11E9

J11C5:	RLCA	
        RLCA	
        JR	NC,J11B1
        POP	AF
        RLCA	
        JR	NC,J11D1
        OUT	(C),L
        JR	J11D3

J11D1:	OUT	(C),H
J11D3:	DJNZ	J11B0
        PUSH	AF
        LD	A,00H
        OUT	(99H),A
        LD	A,8FH
        OUT	(99H),A
        POP	AF
        POP	BC
        JP	J11E9

?11E3:	DEFB	0,0,0,0,0,0

; ....


J35AA:	CALL	J3FCC
        NOP				; replace 4x EX (SP),HL

; ....

?3F90:	PUSH	AF
        LD	C,98H
J3F93:	LD	A,(HL)
        OUT	(C),A
        EX	(SP),HL
        EX	(SP),HL
        INC	HL
        DEC	B
        JP	NZ,J3F93
        POP	AF
        DEC	A
        RET	

?3FA0:	PUSH	AF
        LD	C,98H
J3FA3:	IN	A,(C)
        LD	(HL),A
        EX	(SP),HL
        EX	(SP),HL
        INC	HL
        DEC	B
        JP	NZ,J3FA3
        POP	AF
        DEC	A
        RET	

J3FB0:	OUT	(98H),A
        NOP	
        DEC	C
        JP	J0984

        DEFS	03FB8H-$,0

J3FB8:	OUT	(98H),A
        PUSH	AF
        POP	AF
        INC	A
        RET	

        DEFS	03FC0H-$,0

J3FC0:	PUSH	AF
J3FC1:	LD	A,(HL)
        OUT	(C),A
        INC	HL
        DEC	B
        JP	NZ,J3FC1
        POP	AF
        DEC	A
        RET	

J3FCC:	PUSH	BC
        LD	B,12
J3FCF:	DJNZ	J3FCF
        POP	BC
        RET	

        DEFS	03FD4H-$,0

J3FD4:	PUSH	AF
J3FD5:	IN	A,(C)
        LD	(HL),A
        INC	HL
        DEC	B
        JP	NZ,J3FD5
        POP	AF
        DEC	A
        RET	

J3FE0:	PUSH	AF
J3FE1:	IN	A,(C)
        LD	(HL),A
        INC	HL
        DEC	B
        PUSH	AF
        POP	AF
        JP	NZ,J3FE1
        POP	AF
        INC	B
        DEC	B
        RET	

        DEFS	03FF0H-$,0

J3FF0:	PUSH	AF
J3FF1:	LD	A,(HL)
        OUT	(C),A
        INC	HL
        DEC	B
        PUSH	AF
        POP	AF
        JP	NZ,J$3FF1
        POP	AF
        INC	B
        DEC	B
        RET	

        DEFS	04000H-$,0
