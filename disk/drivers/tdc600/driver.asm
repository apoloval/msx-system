; Diskdriver Talent TDC600
;
; FDC	WD37C65

; Main Status Register A0=0+RD
; DATA A0=1+RD
; DATA A0=1+WR
; Operations Register LDOR+WR
; Control Register LDCR+WR

X.0000	EQU	0000H	; Main Status Register
D.0001	EQU	0001H	; Data Register
D.1000	EQU	1000H	; Operations Register

; -LDCR looks like it is connected to local high, so no way to change Control Register
; -CS combi of SLOTSEL,A14=0,A13=0,A12=0
; A0 = A0
; -LDOR combi of SLOTSEL,A14=0,A13=0,A12=1
; combination of SLOTSEL,A14=0,A13=1,A12=0 could be used for future expansion
; combination of SLOTSEL,A14=0,A13=1,A12=1 could be used for future expansion

;  
;   TDC600 -> Source re-created by Z80DIS 2.2
;      Z80DIS was written by Kenneth Gielow
;                            Palo Alto, CA
;
        .Z80
        ORG	7405H
;
I$0007	EQU	0007H	; ----I
WRSLT	EQU	0014H	; -C---
ENASLT	EQU	0024H	; -C---
J$00A7	EQU	00A7H	; J----
J$00AF	EQU	00AFH	; J----
I$00DB	EQU	00DBH	; ----I
C$00DD	EQU	00DDH	; -C---
J.0100	EQU	0100H	; J---I
D$0101	EQU	0101H	; ---L-
I.0102	EQU	0102H	; ----I
C.011F	EQU	011FH	; -C---
C$0147	EQU	0147H	; -C---
I$0156	EQU	0156H	; ----I
C.0160	EQU	0160H	; -C---
C$0165	EQU	0165H	; -C---
I$017A	EQU	017AH	; ----I
C.0184	EQU	0184H	; -C---
C$0193	EQU	0193H	; -C---
I$01A6	EQU	01A6H	; ----I
I$01B5	EQU	01B5H	; ----I
C.0200	EQU	0200H	; JC--I
I.0301	EQU	0301H	; ----I
J$0302	EQU	0302H	; J----
I.0502	EQU	0502H	; ----I
D.2020	EQU	2020H	; --S--
D.2029	EQU	2029H	; --S-I
D$2030	EQU	2030H	; --S--
J$4022	EQU	4022H	; J----
D$4420	EQU	4420H	; --S--
D.8000	EQU	8000H	; ---LI
D.8001	EQU	8001H	; --SL-
D.9000	EQU	9000H	; --S--
D$C059	EQU	0C059H	; ---L-
J$C063	EQU	0C063H	; J----
J$C06A	EQU	0C06AH	; J----
C$C081	EQU	0C081H	; -C---
I$C08F	EQU	0C08FH	; ----I
I.C0B5	EQU	0C0B5H	; ----I
D$C0C3	EQU	0C0C3H	; --S--
D.C0DA	EQU	0C0DAH	; --SL-
C$F2F6	EQU	0F2F6H	; -C---
D.F342	EQU	0F342H	; ---L-
D.F34D	EQU	0F34DH	; --SL-
C$F368	EQU	0F368H	; -C---
C.F37D	EQU	0F37DH	; -C---
I$F51F	EQU	0F51FH	; ----I
C$F8FD	EQU	0F8FDH	; -C---
I$FCC1	EQU	0FCC1H	; ----I
C.FFCF	EQU	0FFCFH	; -C---
C$FFD4	EQU	0FFD4H	; -C---
D.FFFF	EQU	0FFFFH	; --SL-

MYSIZE	EQU	25


;	  Subroutine Get current slotid on page
;	     Inputs  B = page
;	     Outputs ________________________

C.7405:	PUSH	BC
        PUSH	DE
        LD	A,B
        OR	A			; page 0 ?
        IN	A,(0A8H)
        JR	Z,J$7413
        PUSH	BC
J$740E:	RRCA	
        RRCA	
        DJNZ	J$740E
        POP	BC
J$7413:	AND	03H			; primary slot
        LD	E,A
        LD	D,00H
        LD	HL,I$FCC1
        ADD	HL,DE
        LD	E,A
        LD	A,(HL)
        AND	80H
        OR	E
        LD	E,A
        INC	HL
        INC	HL
        INC	HL
        INC	HL
        LD	A,B
        OR	A			; page 0 ?
        LD	A,(HL)
        RLCA	
        RLCA	
        JR	Z,J$7431
J$742D:	RRCA	
        RRCA	
        DJNZ	J$742D
J$7431:	AND	0CH
        OR	E
        POP	DE
        POP	BC
        RET	

;	  Subroutine Set slotid on page 0
;	     Inputs  B = slotid
;	     Outputs ________________________

C.7437:	DI	
        PUSH	BC
        LD	B,A
        AND	03H
        LD	C,A
        LD	A,B
        BIT	7,A
        JR	NZ,J$744B
        IN	A,(0A8H)
        AND	0FCH
        OR	C
        OUT	(0A8H),A
        POP	BC
        RET	

J$744B:	PUSH	DE
        IN	A,(0A8H)
        AND	0FCH
        OR	C
        LD	D,A
        RRCA	
        RRCA	
        AND	0C0H
        LD	E,A
        LD	A,D
        AND	3FH
        OR	E
        OUT	(0A8H),A
        LD	A,B
        AND	0CH
        RRCA	
        RRCA	
        LD	C,A
        LD	A,(D.FFFF)
        CPL	
        AND	0FCH
        OR	C
        LD	(D.FFFF),A
        LD	A,D
        OUT	(0A8H),A
        POP	DE
        POP	BC
        RET	

;	  Subroutine Enable FDC on page 0
;	     Inputs  ________________________
;	     Outputs ________________________

C.7473:	PUSH	AF
        PUSH	BC
        PUSH	DE
        PUSH	HL
        CALL	GETWRK
        LD	B,0			; page 0
        CALL	C.7405			; Get current slotid on page
        LD	(IX+24),A
        LD	B,1			; page 1
        CALL	C.7405			; Get current slotid on page
        LD	(IX+23),A
        LD	B,2			; page 2
        CALL	C.7405			; Get current slotid on page
        LD	(IX+22),A
        DI	
        LD	A,(IX+23)
        CALL	C.7437			; Set slotid on page 0
        POP	HL
        POP	DE
        POP	BC
        POP	AF
        RET	

I$749E:	RET	M
        NOP	
        LD	(BC),A
        RRCA	
        INC	B
        LD	BC,I.0102
        NOP	
        LD	(BC),A
        LD	(HL),B
        INC	C
        NOP	
        LD	H,E
        LD	BC,I.0502
        NOP	

I74B0:	LD	SP,HL
        NOP	
        LD	(BC),A
        RRCA	
        INC	B
        LD	BC,I.0102
        NOP	
        LD	(BC),A
        LD	(HL),B
        LD	C,00H
        JP	Z,J$0302
        RLCA	
        NOP	
        JP	M,C.0200
;
        RRCA	
        INC	B
        LD	BC,I.0102
        NOP	
        LD	(BC),A
        LD	(HL),B
        LD	A,(BC)
        NOP	
        INC	A
        LD	BC,I.0301
        NOP	
        EI	
        NOP	
        LD	(BC),A
        RRCA	
        INC	B
        LD	BC,I.0102
        NOP	
        LD	(BC),A
        LD	(HL),B
        INC	C
        NOP	
        LD	A,E
        LD	(BC),A
        LD	(BC),A
        DEC	B
        NOP	
        CALL	M,C.0200
;
        RRCA	
        INC	B
        NOP	
        LD	BC,1
        LD	(BC),A
        LD	B,B
        ADD	HL,BC
        NOP	
        LD	H,B
        LD	BC,I.0502
        NOP	
        DEFB	0FDH		; << Illegal Op Code Byte >>
;	-----------------
;
        NOP	
        LD	(BC),A
        RRCA	
        INC	B
        LD	BC,I.0102
        NOP	
        LD	(BC),A
        LD	(HL),B
        INC	C
        NOP	
        LD	H,E
        LD	BC,I.0502
        NOP	
        CP	00H
        LD	(BC),A
        RRCA	
        INC	B
        NOP	
        LD	BC,1
        LD	(BC),A
        LD	B,B
        RLCA	
        NOP	
        LD	A,(D$0101)
        INC	BC
        NOP	
        RST	38H
        NOP	
        LD	(BC),A
        RRCA	
        INC	B
        LD	BC,I.0102
        NOP	
        LD	(BC),A
        LD	(HL),B
        LD	A,(BC)
        NOP	
        INC	A
        LD	BC,I.0301
        NOP	

DEFDPB	EQU	I74B0-1


;	  Subroutine DSKIO
;	     Inputs  ________________________
;	     Outputs ________________________

DSKIO:
C.752E:	JP	NC,J$761F
;
        CALL	C.FFCF
        DI	
        CALL	C.7473			; Enable FDC on page 0
        CALL	C$7563
J.753B:	PUSH	AF
        LD	C,100
        JR	NC,J$7542
        LD	C,0
J$7542:	CALL	C.781E
        LD	(IX+0),200
        LD	A,(IX+12)
        AND	A
        JR	NZ,J$7554
        LD	(IX+1),C
        JR	J$7557
;
;	-----------------
J$7554:	LD	(IX+2),C
J$7557:	LD	A,(IX+24)		; saved slotid on page 0
        CALL	C.7437			; Set slotid on page 0
        POP	AF
        EI	
        CALL	C$FFD4
        RET	
;
;	-----------------
;
;	  Subroutine __________________________
;	     Inputs  ________________________
;	     Outputs ________________________
;
C$7563:	CALL	C.76E4
;
        RET	C
;
        LD	A,H
        AND	A
        JP	M,J.759E
;
        CALL	C.79F0
;
        CALL	C.7A48
;
        RET	C
;
        INC	B
        DEC	B
        RET	Z
;
        LD	A,H
        AND	A
        JP	M,J.759E
;
        PUSH	HL
        PUSH	DE
        PUSH	BC
        LD	A,(IX+24)		; saved slotid on page 0
        CALL	C.7437			; Set slotid on page 0
        LD	DE,(D.F34D)
        PUSH	DE
        LD	BC,512
        CALL	XFER
        LD	A,(IX+23)
        CALL	C.7437			; Set slotid on page 0
;
        POP	HL
        POP	BC
        POP	DE
        CALL	C.75A9
;
        POP	HL
        JR	J$75A1
;
;	-----------------
J.759E:	CALL	C.75A9
;
J$75A1:	RET	C
;
        DEC	B
        RET	Z
;
        CALL	C.77A0
;
        JR	J.759E
;
;	-----------------
;
;	  Subroutine __________________________
;	     Inputs  ________________________
;	     Outputs ________________________
;
C.75A9:	LD	E,07H	; 7 
J$75AB:	CALL	C.781E
;
        PUSH	HL
        PUSH	DE
        PUSH	BC
        LD	BC,0
        LD	DE,0
        LD	A,45H	; "E"
        CALL	C.783C
;
J.75BC:	LD	A,(DE)
        RLA	
        JR	C,J.75D0
;
        DJNZ	J.75BC
;
        DEC	C
        LD	A,(DE)
        RLA	
        JR	C,J.75D0
;
        JR	NZ,J.75BC
;
        SCF	
        JR	J$75DE
;
;	-----------------
J.75CC:	LD	A,(DE)
        RLA	
        JR	NC,J.75CC
;
J.75D0:	AND	40H	; "@"
        JR	Z,J$75DB
;
        INC	E
        LD	A,(HL)
        LD	(DE),A
        DEC	E
        INC	HL
        JR	J.75CC
;
;	-----------------
J$75DB:	CALL	C.786A
;
J$75DE:	POP	BC
        POP	DE
        POP	HL
        JP	C,J$7618
;
        LD	A,(IX+15)
        AND	7FH
        RET	Z
;
        BIT	1,A
        JR	NZ,J$761C
;
        PUSH	AF
        LD	A,(IX+6)
        AND	01H	; 1 
        INC	A
        CPL	
        AND	(IX+11)
        LD	(IX+11),A
        CALL	C.77E2
;
        POP	AF
        DEC	E
        JP	NZ,J$75AB
;
        SCF	
        LD	E,A
        BIT	4,E
        LD	A,0AH	; 10 
        RET	NZ
;
        BIT	2,E
        LD	A,08H	; 8 
        RET	NZ
;
        BIT	5,E
        LD	A,04H	; 4 
        RET	NZ
;
        LD	A,0CH	; 12 
        RET	
;
;	-----------------
J$7618:	LD	A,02H	; 2 
        SCF	
        RET	
;
;	-----------------
J$761C:	XOR	A
        SCF	
        RET	
;
;	-----------------
J$761F:	CALL	C.FFCF
        DI	
        CALL	C.7473			; Enable FDC on page 0
        CALL	C$762C
        JP	J.753B
;
;	-----------------
;
;	  Subroutine __________________________
;	     Inputs  ________________________
;	     Outputs ________________________
;
C$762C:	CALL	C.76E4
;
        RET	C
;
        LD	A,H
        AND	A
        JP	M,J.766F
;
        CALL	C.79F0
;
        CALL	C$7A23
;
        CALL	C.7A48
;
        RET	C
;
        INC	B
        DEC	B
        RET	Z
;
        LD	A,H
        AND	A
        JP	M,J.766F
;
        PUSH	HL
        LD	HL,(D.F34D)
        CALL	C.767A
;
        POP	HL
        RET	C
;
        PUSH	BC
        PUSH	DE
        PUSH	HL
        LD	A,(IX+24)		; saved slotid on page 0
        CALL	C.7437			; Set slotid on page 0
;
        EX	DE,HL
        LD	HL,(D.F34D)
        LD	BC,512
        CALL	XFER
;
        LD	A,(IX+23)
        CALL	C.7437			; Set slotid on page 0
;
        POP	HL
        POP	DE
        POP	BC
        AND	A
        JR	J$7673
;
;	-----------------
J.766F:	CALL	C.767A
;
        RET	C
;
J$7673:	DEC	B
        RET	Z
;
        CALL	C.77A0
;
        JR	J.766F
;
;	-----------------
;
;	  Subroutine __________________________
;	     Inputs  ________________________
;	     Outputs ________________________
;
C.767A:	LD	E,07H	; 7 
J$767C:	CALL	C.781E
;
        PUSH	HL
        PUSH	DE
        PUSH	BC
        LD	BC,0
        LD	DE,0
        LD	A,66H	; "f"
        CALL	C.783C
;
J.768D:	LD	A,(DE)
        RLA	
        JR	C,J.76A1
;
        DJNZ	J.768D
;
        DEC	C
        LD	A,(DE)
        RLA	
        JR	C,J.76A1
;
        JR	NZ,J.768D
;
        SCF	
        JR	J$76AF
;
;	-----------------
J.769D:	LD	A,(DE)
        RLA	
        JR	NC,J.769D
;
J.76A1:	AND	40H	; "@"
        JR	Z,J$76AC
;
        INC	E
        LD	A,(DE)
        LD	(HL),A
        INC	HL
        DEC	E
        JR	J.769D
;
;	-----------------
J$76AC:	CALL	C.786A
;
J$76AF:	POP	BC
        POP	DE
        POP	HL
        JP	C,J$76E0
;
        LD	A,(IX+15)
        AND	7FH
        RET	Z
;
        PUSH	AF
        LD	A,(IX+6)
        AND	01H	; 1 
        INC	A
        CPL	
        AND	(IX+11)
        LD	(IX+11),A
        CALL	C.77E2
;
        POP	AF
        DEC	E
        JP	NZ,J$767C
;
        SCF	
        LD	E,A
        BIT	2,E
        LD	A,08H	; 8 
        RET	NZ
;
        BIT	5,E
        LD	A,04H	; 4 
        RET	NZ
;
        LD	A,0CH	; 12 
        RET	
;
;	-----------------
J$76E0:	LD	A,02H	; 2 
        SCF	
        RET	
;
;	-----------------
;
;	  Subroutine __________________________
;	     Inputs  ________________________
;	     Outputs ________________________
;
C.76E4:	PUSH	AF
        PUSH	BC
        PUSH	HL
        CALL	GETWRK
;
        POP	HL
        POP	BC
        POP	AF
        CP	02H	; 2 
        JR	C,J$76F5
;
J$76F1:	LD	A,0CH	; 12 
        SCF	
        RET	
;
;	-----------------
J$76F5:	PUSH	AF
        LD	A,C
        CP	0F8H
        JR	NC,J$76FE
;
        POP	AF
        JR	J$76F1
;
;	-----------------
J$76FE:	EX	(SP),HL
        PUSH	HL
        PUSH	BC
        BIT	1,C
        LD	C,E
        LD	B,D
        LD	DE,8
        JR	NZ,J$770B
        INC	DE
J$770B:	CALL	DIV16
        LD	A,L
        INC	A
        LD	(IX+9),A
        LD	L,C
        POP	BC
        POP	AF
        LD	H,A
        LD	A,(IX+5)
        DEC	A
        JR	Z,J.7723
        LD	A,H
        OR	A
        JR	Z,J.7723
        LD	A,11H
J.7723:	ADD	A,1CH
        PUSH	AF
        AND	01H	; 1 
        BIT	0,C
        JR	Z,J.7732
        SRL	L
        JR	NC,J.7732
        OR	04H	; 4 
J.7732:	LD	(IX+6),A
        PUSH	AF
        SRL	A
        SRL	A
        AND	01H	; 1 
        LD	(IX+8),A
        POP	AF
        LD	D,A
        LD	A,C
        RRCA	
        RRCA	
        AND	0C0H
        OR	D
        LD	D,A
        POP	AF
        LD	(D.1000),A		; PC AT mode, motor on, dma enabled, select drive
        LD	(IX+12),A
        LD	A,(IX)
        AND	A
        LD	(IX),0FFH
        JR	NZ,J$7763
;
        PUSH	HL
        LD	HL,0
J$775D:	DEC	HL
        LD	A,L
        OR	H
        JR	NZ,J$775D
;
        POP	HL
J$7763:	LD	C,L
        LD	(IX+7),L
        LD	A,(IX+5)
        DEC	A
        JR	Z,J$777A
;
        LD	A,(IX+3)
        CP	H
        JR	Z,J.779B
;
        XOR	01H	; 1 
        LD	(IX+3),A
        JR	J.779B
;
;	-----------------
J$777A:	LD	A,H
        CP	(IX+4)
        LD	(IX+4),A
        JR	Z,J.779B
;
        PUSH	IX
        PUSH	DE
        PUSH	BC
        LD	A,(IX+24)		; saved slotid on page 0
        CALL	C.7437			; Set slotid on page 0
        CALL	PROMPT
        POP	BC
        POP	DE
        POP	IX
        DI	
        LD	A,(IX+23)
        CALL	C.7437			; Set slotid on page 0
;
J.779B:	CALL	C.77E2
;
        POP	HL
        RET	
;
;	-----------------
;
;	  Subroutine __________________________
;	     Inputs  ________________________
;	     Outputs ________________________
;
C.77A0:	INC	H
        INC	H
        LD	A,(IX+9)
        INC	A
        LD	(IX+9),A
        BIT	7,D
        JR	NZ,J$77B0
;
        CP	0AH	; 10 
        RET	C
;
J$77B0:	CP	09H	; 9 
        RET	C
;
        LD	A,01H	; 1 
        LD	(IX+9),A
        BIT	6,D
        JR	Z,J.77CE
;
        BIT	2,D
        JR	NZ,J.77CE
;
        SET	2,D
        LD	A,D
        AND	0FH	; 15 
        LD	(IX+6),A
        LD	A,01H	; 1 
        LD	(IX+8),A
        RET	
;
;	-----------------
J.77CE:	RES	2,D
        LD	A,D
        AND	0FH	; 15 
        LD	(IX+6),A
        XOR	A
        LD	(IX+8),A
        INC	C
        LD	(IX+7),C
        CALL	C.77E2
;
        RET	
;
;	-----------------
;
;	  Subroutine __________________________
;	     Inputs  ________________________
;	     Outputs ________________________
;
C.77E2:	CALL	C.781E
;
        LD	A,(IX+6)
        AND	01H	; 1 
        INC	A
        AND	(IX+11)
        JR	NZ,J$780A
;
        LD	A,(IX+6)
        AND	01H	; 1 
        INC	A
        OR	(IX+11)
        LD	(IX+11),A
        LD	A,07H	; 7 
        CALL	C.785B
;
        LD	A,(IX+6)
        CALL	C.785B
;
        CALL	C.788C
;
J$780A:	LD	A,0FH	; 15 
        CALL	C.785B
;
        LD	A,(IX+6)
        CALL	C.785B
;
        LD	A,(IX+7)
        CALL	C.785B
;
        JP	C.788C
;
;	-----------------
;
;	  Subroutine __________________________
;	     Inputs  ________________________
;	     Outputs ________________________
;
C.781E:	LD	A,(X.0000)
        AND	0D0H			; RQM,DIO,CB
        XOR	80H
        RET	Z
        XOR	A
        LD	(IX+11),A
        LD	(D.1000),A		; PC AT mode, motor 2 off, motor 1 off, dma disabled, reset, select drive 1
        CALL	C.7837
        LD	A,(IX+12)
        LD	(D.1000),A
        RET	
;
;	-----------------
;
;	  Subroutine __________________________
;	     Inputs  ________________________
;	     Outputs ________________________
;
C.7837:	EX	(SP),HL
        EX	(SP),HL
        EX	(SP),HL
        EX	(SP),HL
        RET	
;
;	-----------------
;
;	  Subroutine __________________________
;	     Inputs  ________________________
;	     Outputs ________________________
;
C.783C:	PUSH	BC
        LD	B,06H	; 6 
        PUSH	IX
J$7841:	CALL	C.785B
;
        LD	A,(IX+6)
        INC	IX
        DJNZ	J$7841
;
        POP	IX
        POP	BC
        LD	A,(IX+9)
        CALL	C.785B
;
        LD	A,1BH
        CALL	C.785B
;
        LD	A,0FFH
;
;	  Subroutine __________________________
;	     Inputs  ________________________
;	     Outputs ________________________
;
C.785B:	PUSH	AF
J$785C:	LD	A,(X.0000)
        AND	0E0H			; RQM,DIO,EXM
        CP	80H			; DR ready, CPU->FDC, Execution finshed ?
        JR	NZ,J$785C		; nope, wait
        POP	AF
        LD	(D.0001),A
        RET	

;	  Subroutine __________________________
;	     Inputs  ________________________
;	     Outputs ________________________

C.786A:	PUSH	IX
J.786C:	LD	A,(X.0000)
        AND	0C0H			; RQM, DIO
        CP	0C0H
        JR	NZ,J.786C
        LD	A,(D.0001)
        LD	(IX+14),A
        INC	IX
        CALL	C.7837
        LD	A,(X.0000)
        AND	0C0H			; RQM, DIO
        CP	80H
        JR	NZ,J.786C
        POP	IX
        RET	
;
;	-----------------
;
;	  Subroutine __________________________
;	     Inputs  ________________________
;	     Outputs ________________________
;
C.788C:	PUSH	BC
        LD	B,20H	; " "
J$788F:	LD	A,08H	; 8 
        CALL	C.785B
;
        CALL	C.786A
;
        LD	A,(IX+14)
        AND	0F0H
        CP	20H	; " "
        JR	Z,J$78A9
;
        CALL	C.7837
;
        DEC	BC
        LD	A,B
        OR	C
        JR	NZ,J$788F
;
        SCF	
J$78A9:	POP	BC
        RET	

;	  Subroutine INIHRD
;	     Inputs  ________________________
;	     Outputs ________________________

INIHRD:
        LD	B,0			; page 0
        CALL	C.7405			; Get current slotid on page
        PUSH	AF
        LD	B,1			; page 1
        CALL	C.7405			; Get current slotid on page
        CALL	C.7437			; Set slotid on page 0
        XOR	A
        LD	(D.1000),A		; PC AT mode, motor 2 off, motor 1 off, dma disabled, reset, select drive 1
        CALL	C.7837
        LD	A,0CH
        LD	(D.1000),A		; PC AT mode, motor 2 off, motor 1 off, dma enabled, select drive 1
        LD	A,03H
        CALL	C.785B
        LD	A,9FH
        CALL	C.785B
        LD	A,03H	; 3 
        CALL	C.785B
        LD	A,1CH
        LD	(D.1000),A		; PC AT mode, motor 2 off, motor 1 on, dma enabled, select drive 1
        LD	A,07H	; 7 
        CALL	C.785B
        LD	A,00H
        CALL	C.785B
        LD	HL,0
J$78E6:	CALL	C.7837
        DEC	HL
        LD	A,H
        OR	L
        JR	NZ,J$78E6
        LD	A,0CH
        LD	(D.1000),A		; PC AT mode, motor 2 off, motor 1 off, dma enabled, select drive 1
        POP	AF
        CALL	C.7437			; Set slotid on page 0
        RET	

;	  Subroutine MTOFF
;	     Inputs  ________________________
;	     Outputs ________________________

MTOFF:
        PUSH	BC
        PUSH	DE
        PUSH	HL
        LD	A,0CH			; PC AT mode, motor 2 off, motor 1 off, dma enabled, select drive 1
        LD	(IX+12),A
        LD	E,A
        LD	B,1			; page 1
        CALL	C.7405			; Get current slotid on page
        LD	HL,D.1000
        CALL	WRSLT
        POP	HL
        POP	DE
        POP	BC
        RET	

;	  Subroutine DRIVES
;	     Inputs  ________________________
;	     Outputs ________________________

DRIVES:
        CALL	C.7473			; Enable FDC on page 0
        PUSH	BC
        PUSH	AF
        LD	A,2DH			; PC AT mode, motor 2 on, motor 1 off, dma enabled, select drive 2
        LD	(D.1000),A
        CALL	C.788C
        LD	A,07H	; 7 
        CALL	C.785B
        LD	A,01H	; 1 
        CALL	C.785B
        CALL	C.788C
        LD	L,1
        JR	C,J$7930
        LD	L,2
J$7930:	LD	(IX+5),L
        LD	A,0CH			; PC AT mode, motor 2 off, motor 1 off, dma enabled, select drive 1
        LD	(D.1000),A
        POP	AF
        JR	Z,J$793D
        LD	L,2
J$793D:	PUSH	HL
        PUSH	AF
        CALL	GETWRK
        LD	A,(IX+24)		; saved slotid on page 0
        CALL	C.7437			; Set slotid on page 0
        POP	AF
        POP	HL
        POP	BC
        RET	

;	  Subroutine INIENV
;	     Inputs  ________________________
;	     Outputs ________________________

INIENV:
        CALL	GETWRK
        LD	D,(IX+5)
        XOR	A
        LD	B,19H
J$7955:	LD	(HL),A
        INC	HL
        DJNZ	J$7955
        LD	(IX+5),D
        LD	(IX+10),02H	; 2 
        LD	HL,I$7966
        JP	SETINT

I$7966:	PUSH	AF
        CALL	GETWRK
        LD	A,(HL)
        AND	A
        JR	Z,J.7986
        CP	0FFH
        JR	Z,J.7986
        DEC	A
        LD	(HL),A
        JR	NZ,J.7986
        LD	A,0CH			; PC AT mode, motor 2 off, motor 1 off, dma enabled, select drive 1
        LD	E,A
        LD	B,1			; page 1
        CALL	C.7405			; Get current slotid on page
        PUSH	HL
        LD	HL,D.1000
        CALL	WRSLT
        POP	HL
J.7986:	INC	HL
        LD	A,(HL)
        AND	A
        JR	Z,J$798C
        DEC	(HL)
J$798C:	INC	HL
        LD	A,(HL)
        AND	A
        JR	Z,J$7992
        DEC	(HL)
J$7992:	POP	AF
        JP	PRVINT

;	  Subroutine DSKCHG
;	     Inputs  ________________________
;	     Outputs ________________________

DSKCHG:
        EI	
        PUSH	HL
        PUSH	BC
        PUSH	AF
        CALL	GETWRK
        POP	AF
        POP	BC
        POP	HL
        AND	A
        LD	B,(IX+2)
        JR	NZ,J$79A9
        LD	B,(IX+1)
J$79A9:	INC	B
        DEC	B
        LD	B,01H	; 1 
        RET	NZ
        PUSH	BC
        PUSH	HL
        LD	DE,1
        LD	HL,(D.F34D)
        CALL	C.752E
        JR	C,J.79D2
        LD	HL,(D.F34D)
        LD	B,(HL)
        POP	HL
        PUSH	BC
        CALL	C$79D5
        LD	A,0CH	; 12 
        JR	C,J.79D2
        POP	AF
        POP	BC
        CP	C
        SCF	
        CCF	
        LD	B,0FFH
        RET	NZ
        INC	B
        RET	
;
;	-----------------
J.79D2:	POP	DE
        POP	DE
        RET	

;	  Subroutine GETDPB
;	     Inputs  ________________________
;	     Outputs ________________________

GETDPB:
C$79D5:	EI	
        EX	DE,HL
        INC	DE
        LD	A,B
        SUB	0F8H
        RET	C
;
        LD	L,A
        LD	H,00H
        ADD	HL,HL
        LD	C,L
        LD	B,H
        ADD	HL,HL
        ADD	HL,HL
        ADD	HL,HL
        ADD	HL,BC
        LD	BC,I$749E
        ADD	HL,BC
        LD	BC,18
        LDIR	
        RET	
;
;	-----------------
;
;	  Subroutine __________________________
;	     Inputs  ________________________
;	     Outputs ________________________
;
C.79F0:	PUSH	HL
        PUSH	DE
        PUSH	BC
        LD	HL,I$7A84
        LD	DE,(D.F34D)
        LD	BC,I$01B5
        LDIR	
        LD	HL,I$7A4E
J$7A02:	LD	E,(HL)
        INC	HL
        LD	D,(HL)
        INC	HL
        LD	A,E
        OR	D
        JR	Z,J$7A1F
;
        PUSH	HL
        LD	HL,(D.F34D)
        ADD	HL,DE
        INC	HL
        LD	C,(HL)
        INC	HL
        LD	B,(HL)
        EX	DE,HL
        LD	HL,(D.F34D)
        ADD	HL,BC
        EX	DE,HL
        LD	(HL),D
        DEC	HL
        LD	(HL),E
        POP	HL
        JR	J$7A02
;
;	-----------------
J$7A1F:	POP	BC
        POP	DE
        POP	HL
        RET	
;
;	-----------------
;
;	  Subroutine __________________________
;	     Inputs  ________________________
;	     Outputs ________________________
;
C$7A23:	PUSH	HL
        PUSH	DE
        PUSH	BC
        LD	HL,I$7A6A
J$7A29:	LD	E,(HL)
        INC	HL
        LD	D,(HL)
        LD	A,E
        OR	D
        JR	Z,J$7A44
;
        PUSH	HL
        LD	HL,(D.F34D)
        ADD	HL,DE
        EX	DE,HL
        POP	HL
        INC	HL
        LD	C,(HL)
        INC	HL
        LD	B,(HL)
        INC	HL
        PUSH	HL
        EX	DE,HL
        LD	(HL),C
        INC	HL
        LD	(HL),B
        POP	HL
        JR	J$7A29
;
;	-----------------
J$7A44:	POP	BC
        POP	DE
        POP	HL
        RET	
;
;	-----------------
;
;	  Subroutine __________________________
;	     Inputs  ________________________
;	     Outputs ________________________
;
C.7A48:	PUSH	HL
        LD	HL,(D.F34D)
        EX	(SP),HL
        RET	
;
;	-----------------
I$7A4E:	ADD	HL,HL
        NOP	
        LD	L,00H
        INC	A
        NOP	
        LD	E,(HL)
        NOP	
        LD	H,H
        NOP	
        LD	(HL),C
        NOP	
        ADC	A,B
        NOP	
        DEC	DE
        LD	BC,I$0156
        LD	L,D
        LD	BC,I$017A
        LD	A,A
        LD	BC,I$01A6
        DEFB	0,0
I$7A6A:	LD	A,(D$3E00)
        LD	H,(HL)
        LD	E,B
        NOP	
        LD	A,(DE)
        LD	(HL),A
        HALT	
;
;	-----------------
?.7A73:	DEFB	0,0,0
        LD	A,B
        DEFB	0,0,0
        SUB	C
        DEFB	0,0,0
        SUB	E
        DEFB	0,0,0,0,0
I$7A84:	PUSH	IX
        PUSH	HL
        PUSH	DE
        PUSH	BC
        LD	A,(IX+24)		; saved slotid on page 0
        CALL	C.7437			; Set slotid on page 0
;
        PUSH	IX
        LD	A,(D.F342)
        LD	H,40H	; "@"
        CALL	ENASLT
;
        POP	IX
        LD	A,(IX+23)
        LD	H,80H
        CALL	ENASLT
;
        POP	BC
        POP	DE
        POP	HL
        POP	IX
J$7AA8:	DEC	HL
        LD	A,H
        ADD	A,02H	; 2 
        INC	HL
        JP	M,J$00AF
;
        LD	E,07H	; 7 
J$7AB2:	CALL	C$0147
;
        PUSH	HL
        PUSH	DE
        PUSH	BC
        LD	BC,0
        LD	DE,D.8000
        LD	A,45H	; "E"
        CALL	C$0165
;
J.7AC3:	LD	A,(DE)
        RLA	
        JR	C,J.7AD7
;
        DJNZ	J.7AC3
;
        DEC	C
        LD	A,(DE)
        RLA	
        JR	C,J.7AD7
;
        JR	NZ,J.7AC3
;
        SCF	
        JR	J$7AE5
;
;	-----------------
J.7AD3:	LD	A,(DE)
        RLA	
        JR	NC,J.7AD3
;
J.7AD7:	AND	40H	; "@"
        JR	Z,J$7AE2
;
        INC	E
        LD	A,(HL)
        LD	(DE),A
        DEC	E
        INC	HL
        JR	J.7AD3
;
;	-----------------
J$7AE2:	CALL	C$0193
;
J$7AE5:	POP	BC
        POP	DE
        POP	HL
        JP	C,J$00A7
;
        LD	A,(IX+15)
        AND	7FH
        JR	NZ,J$7AFA
;
        DEC	B
        JR	Z,J$7B33
;
        CALL	C$00DD
;
        JR	J$7AA8
;
;	-----------------
J$7AFA:	BIT	1,A
        JR	NZ,J$7B30
;
        PUSH	AF
        LD	A,(IX+6)
        AND	01H	; 1 
        INC	A
        CPL	
        AND	(IX+11)
        LD	(IX+11),A
        CALL	C.011F
;
        POP	AF
        DEC	E
        JR	NZ,J$7AB2
;
        SCF	
        LD	E,A
        BIT	4,E
        LD	A,0AH	; 10 
        JR	NZ,J.7B32
;
        BIT	2,E
        LD	A,08H	; 8 
        JR	NZ,J.7B32
;
        BIT	5,E
        LD	A,04H	; 4 
        JR	NZ,J.7B32
;
        LD	A,0CH	; 12 
        JR	J.7B32
;
;	-----------------
?.7B2B:	LD	A,02H	; 2 
        SCF	
        JR	J.7B32
;
;	-----------------
J$7B30:	XOR	A
        SCF	
J.7B32:	SCF	
J$7B33:	PUSH	IX
        PUSH	HL
        PUSH	DE
        PUSH	BC
        PUSH	AF
        PUSH	IX
        LD	A,(IX+22)
        LD	H,80H
        CALL	ENASLT
;
        CALL	C$F368
;
        POP	IX
        PUSH	IX
        LD	A,(IX+23)
        LD	H,40H	; "@"
        CALL	ENASLT
;
        POP	IX
        LD	A,(IX+23)
        CALL	C.7437			; Set slotid on page 0
;
        POP	AF
        POP	BC
        POP	DE
        POP	HL
        POP	IX
        RET	
;
;	-----------------
?.7B61:	INC	H
        INC	H
        LD	A,(IX+9)
        INC	A
        LD	(IX+9),A
        BIT	7,D
        JR	NZ,J$7B71
;
        CP	0AH	; 10 
        RET	C
;
J$7B71:	CP	09H	; 9 
        RET	C
;
        LD	A,01H	; 1 
        LD	(IX+9),A
        BIT	6,D
        JR	Z,J.7B8F
;
        BIT	2,D
        JR	NZ,J.7B8F
;
        SET	2,D
        LD	A,D
        AND	0FH	; 15 
        LD	(IX+6),A
        LD	A,01H	; 1 
        LD	(IX+8),A
        RET	
;
;	-----------------
J.7B8F:	RES	2,D
        LD	A,D
        AND	0FH	; 15 
        LD	(IX+6),A
        XOR	A
        LD	(IX+8),A
        INC	C
        LD	(IX+7),C
        CALL	C.011F
;
        RET	
;
;	-----------------
?.7BA3:	PUSH	BC
        PUSH	DE
        PUSH	HL
        LD	A,(IX+23)
        LD	H,40H	; "@"
        CALL	ENASLT
        LD	A,(IX+23)
        CALL	C.7437			; Set slotid on page 0
        POP	HL
        CALL	C.77E2
        PUSH	HL
        LD	A,(IX+24)		; saved slotid on page 0
        CALL	C.7437			; Set slotid on page 0
        LD	A,(D.F342)
        LD	H,40H	; "@"
        CALL	ENASLT
        POP	HL
        POP	DE
        POP	BC
        RET	
;
;	-----------------
?.7BCB:	LD	A,(D.8000)
        AND	0D0H
        XOR	80H
        RET	Z
;
        XOR	A
        LD	(IX+11),A
        LD	(D.9000),A
        CALL	C.0160
;
        LD	A,(IX+12)
        LD	(D.9000),A
        RET	
;
;	-----------------
?.7BE4:	EX	(SP),HL
        EX	(SP),HL
        EX	(SP),HL
        EX	(SP),HL
        RET	
;
;	-----------------
?.7BE9:	PUSH	BC
        LD	B,06H	; 6 
        PUSH	IX
J$7BEE:	CALL	C.0184
;
        LD	A,(IX+6)
        INC	IX
        DJNZ	J$7BEE
;
        POP	IX
        POP	BC
        LD	A,(IX+9)
        CALL	C.0184
;
        LD	A,1BH
        CALL	C.0184
;
        LD	A,0FFH
        PUSH	AF
J$7C09:	LD	A,(D.8000)
        AND	0E0H
        CP	80H
        JR	NZ,J$7C09
;
        POP	AF
        LD	(D.8001),A
        RET	
;
;	-----------------
?.7C17:	PUSH	IX
J.7C19:	LD	A,(D.8000)
        AND	0C0H
        CP	0C0H
        JR	NZ,J.7C19
;
        LD	A,(D.8001)
        LD	(IX+14),A
        INC	IX
        CALL	C.0160
;
        LD	A,(D.8000)
        AND	0C0H
        CP	80H
        JR	NZ,J.7C19
;
        POP	IX
        RET	

;	  Subroutine CHOICE
;	     Inputs  ________________________
;	     Outputs ________________________

CHOICE:
        LD	HL,I$7C3D
        RET	
;
;	-----------------
I$7C3D:	DEC	C
        LD	A,(BC)
        LD	SP,D.2029
        INC	SP
        LD	L,35H	; "5"
        LD	(D.2020),HL
        LD	D,E
        LD	L,C
        LD	L,L
        LD	(HL),B
        LD	L,H
        LD	H,L
        JR	NZ,J$7CBC
;
        LD	H,C
        LD	H,H
        LD	L,A
        JR	NZ,J$7C7D
;
        INC	SP
        LD	(HL),30H	; "0"
        JR	NZ,J$7CA5
;
        LD	H,D
        ADD	HL,HL
        DEC	C
        LD	A,(BC)
        LD	(D.2029),A
        INC	SP
        LD	L,35H	; "5"
        LD	(D.2020),HL
        LD	B,H
        LD	L,A
        LD	H,D
        LD	L,H
        LD	H,L
        JR	NZ,J$7CDA
;
        LD	H,C
        LD	H,H
        LD	L,A
        JR	NZ,J$7C93
;
        JR	Z,J$7CAC
;
        LD	(D$2030),A
        LD	C,E
        LD	H,D
        ADD	HL,HL
        DEC	C
        LD	A,(BC)
J$7C7D:	INC	SP
        ADD	HL,HL
        JR	NZ,J$7CB6
;
        LD	L,32H	; "2"
        DEC	(HL)
        LD	(D$4420),HL
        LD	L,A
        LD	H,D
        LD	L,H
        LD	H,L
        JR	NZ,J$7CF9
;
        LD	H,C
        LD	H,H
        LD	L,A
        JR	NZ,J$7CB2
;
        JR	Z,J$7CC7
J$7C93	EQU	$-1
;
        LD	(HL),30H	; "0"
        JR	NZ,J$7CE3
;
        LD	H,D
        ADD	HL,HL
        DEC	C
        LD	A,(BC)
        DEC	C
        LD	A,(BC)
        NOP

;	  Subroutine DSKFMT
;	     Inputs  ________________________
;	     Outputs ________________________

DSKFMT:	
        CALL	C.FFCF
        DI	
        CALL	C.7473			; Enable FDC on page 0
J$7CA5	EQU	$-1
        DEC	A
        JR	Z,J.7CAF
        BIT	0,A
        JR	NZ,J.7CAF
J$7CAC	EQU	$-1
        LD	A,05H	; 5 
J.7CAF:	ADD	A,0F8H
        LD	C,A
J$7CB2:	PUSH	AF
        LD	A,D
        CP	02H	; 2 
J$7CB6:	JR	C,J$7CBE
;
        POP	AF
        LD	A,0CH	; 12 
        JP	J.7D8D
J$7CBC	EQU	$-2
;
;	-----------------
J$7CBE:	LD	DE,0
        CALL	C.76E4
;
        POP	BC
        LD	A,06H	; 6 
J$7CC7:	JP	C,J.7D8D
;
        LD	A,B
        LD	(IX+13),A
        LD	A,01H	; 1 
        EX	AF,AF'
J.7CD1:	PUSH	DE
        PUSH	IX
        POP	HL
        LD	BC,I$0007
        ADD	HL,BC
        PUSH	HL
J$7CDA:	LD	C,01H	; 1 
        LD	A,4DH	; "M"
        CALL	C.785B
;
        LD	A,D
        CALL	C.785B
J$7CE3	EQU	$-2
;
        LD	A,02H	; 2 
        CALL	C.785B
;
        LD	A,09H	; 9 
        CALL	C.785B
;
        LD	A,52H	; "R"
        CALL	C.785B
;
        LD	A,0E5H
        LD	DE,0
J$7CF9:	CALL	C.785B
;
J$7CFC:	LD	B,04H	; 4 
        EX	AF,AF'
        LD	(IX+9),A
        INC	A
        EX	AF,AF'
        POP	HL
        PUSH	HL
J.7D06:	LD	A,(DE)
        RLA	
        JR	NC,J.7D06
;
        AND	40H	; "@"
        JR	Z,J$7D17
;
        LD	A,(HL)
        INC	E
        LD	(DE),A
        DEC	E
        INC	HL
        DJNZ	J.7D06
;
        JR	J$7CFC
;
;	-----------------
J$7D17:	POP	HL
        POP	DE
        CALL	C.786A
;
        BIT	1,(IX+15)
        JR	NZ,J$7D8B
;
        BIT	2,D
        JR	NZ,J.7D3F
;
        LD	A,(IX+13)
        CP	0F8H
        JR	Z,J.7D3F
;
        SET	2,D
        LD	(IX+6),D
        LD	(IX+8),01H	; 1 
        LD	(IX+9),01H	; 1 
        LD	A,01H	; 1 
        EX	AF,AF'
        JR	J.7CD1
;
;	-----------------
J.7D3F:	LD	C,27H	; "'"
        LD	A,(IX+13)
        CP	0FDH
        JR	Z,J$7D4A
;
        LD	C,4FH	; "O"
J$7D4A:	LD	A,(IX+7)
        CP	C
        JR	Z,J$7D91
;
        INC	A
        LD	(IX+7),A
        IN	A,(0AAH)
        AND	0F0H
        ADD	A,07H	; 7 
        OUT	(0AAH),A
        IN	A,(0A9H)
        AND	10H	; 16 
        JR	NZ,J$7D6D
;
        IN	A,(0AAH)
        DEC	A
        OUT	(0AAH),A
        IN	A,(0A9H)
        AND	02H	; 2 
        JR	Z,J$7D87
;
J$7D6D:	RES	2,D
        LD	(IX+6),D
        LD	(IX+8),00H
        LD	(IX+9),01H	; 1 
        CALL	C.77E2
;
        LD	A,01H	; 1 
        EX	AF,AF'
        JP	NC,J.7CD1
;
J$7D83:	LD	A,06H	; 6 
        JR	J.7D8D
;
;	-----------------
J$7D87:	LD	A,0AH	; 10 
        JR	J.7D8D
;
;	-----------------
J$7D8B:	LD	A,00H
J.7D8D:	SCF	
        JP	J.753B
;
;	-----------------
J$7D91:	XOR	A
        LD	(IX+7),A
        RES	2,D
        LD	(IX+6),D
        LD	(IX+8),00H
        LD	(IX+9),01H	; 1 
        CALL	C.77E2
        JR	C,J$7D83
        CALL	GETWRK
        LD	A,(IX+24)		; saved slotid on page 0
        CALL	C.7437			; Set slotid on page 0
        LD	HL,(D.F34D)
        PUSH	HL
        PUSH	HL
        POP	DE
        INC	DE
        LD	(HL),00H
        LD	BC,C.0200
        LDIR	
        LD	HL,I$7E92
        POP	DE
        LD	BC,I$00DB
        LDIR	
        LD	A,(IX+13)
        LD	IY,(D.F34D)
        LD	(IY+21),A
        CP	0F8H
        JR	NZ,J$7DDB
        LD	(IY+26),01H	; 1 
        JR	J.7DEB
;
;	-----------------
J$7DDB:	CP	0F9H
        JR	NZ,J.7DEB
        LD	(IY+22),03H	; 3 
        LD	(IY+19),0A0H
        LD	(IY+20),05H	; 5 
J.7DEB:	LD	HL,(D.F34D)
        LD	DE,0
        LD	B,01H	; 1 
        LD	C,A
        LD	A,(IX+6)
        AND	03H	; 3 
        SCF	
        PUSH	IX
        CALL	C.752E
;
        POP	IX
        JP	C,J.7E7B
;
        LD	HL,(D.F34D)
        PUSH	HL
        POP	IY
        LD	A,(IY+16)
        LD	B,00H
J$7E0F:	LD	(HL),00H
        INC	HL
        DJNZ	J$7E0F
;
        ADD	A,A
        ADD	A,07H	; 7 
        LD	B,A
        LD	DE,1
J$7E1B:	LD	A,(IX+13)
        PUSH	BC
        PUSH	DE
        LD	HL,(D.F34D)
        LD	B,01H	; 1 
        LD	C,A
        LD	A,(IX+6)
        AND	03H	; 3 
        SCF	
        PUSH	IX
        CALL	C.752E
;
        POP	IX
        POP	DE
        POP	BC
        JP	C,J.7E7B
;
        INC	DE
        DJNZ	J$7E1B
;
        LD	HL,(D.F34D)
        LD	A,(IX+13)
        LD	(HL),A
        INC	HL
        LD	(HL),0FFH
        INC	HL
        LD	(HL),0FFH
        LD	HL,(D.F34D)
        LD	B,01H	; 1 
        LD	C,A
        LD	DE,1
        LD	A,(IX+6)
        AND	03H	; 3 
        SCF	
        PUSH	IX
        CALL	C.752E
;
        POP	IX
        JP	C,J.7E7B
;
        LD	HL,(D.F34D)
        LD	A,(IX+13)
        LD	B,01H	; 1 
        LD	C,A
        LD	DE,2
        CP	0F9H
        JR	NZ,J$7E72
;
        INC	DE
J$7E72:	SCF	
        LD	A,(IX+6)
        AND	03H	; 3 
        JP	C.752E
;
;	-----------------
J.7E7B:	PUSH	AF
        LD	C,00H
        LD	(IX),0C8H
        LD	A,(IX+13)
        AND	A
        JR	NZ,J$7E8D
;
        LD	(IX+1),C
        POP	AF
        RET	
;
;	-----------------
J$7E8D:	LD	(IX+2),C
        POP	AF
        RET	
;
;	-----------------
I$7E92:	EX	DE,HL
        CP	90H
        LD	D,H
        LD	B,C
        LD	C,H
        LD	B,L
        LD	C,(HL)
        LD	D,H
        LD	L,31H	; "1"
        NOP	
        LD	(BC),A
        LD	(BC),A
        LD	BC,C.0200
        LD	(HL),B
        NOP	
        RET	NC
;
        LD	(BC),A
        DEFB	0FDH		; << Illegal Op Code Byte >>
;	-----------------
;
        LD	(BC),A
        NOP	
        ADD	HL,BC
        NOP	
        LD	(BC),A
        DEFB	0,0,0
        RET	NC
;
        LD	(D$C059),DE
        LD	(D.C0DA),A
        LD	(HL),56H	; "V"
        INC	HL
        LD	(HL),0C0H
J$7EBD:	LD	SP,I$F51F
        LD	DE,I.C0B5
        LD	C,0FH	; 15 
        CALL	C.F37D
        INC	A
        JP	Z,J$C063
        LD	DE,J.0100
        LD	C,1AH
        CALL	C.F37D
        LD	HL,1
        LD	(D$C0C3),HL
        LD	HL,04000H-0100H
        LD	DE,I.C0B5
        LD	C,27H	; "'"
        CALL	C.F37D
        JP	J.0100
;
;	-----------------
?.7EE8:	LD	E,B
        RET	NZ
        CALL	0
        LD	A,C
        AND	0FEH
        CP	02H	; 2 
        JP	NZ,J$C06A
;
        LD	A,(D.C0DA)
        AND	A
        JP	Z,J$4022
;
        LD	DE,I$C08F
        CALL	C$C081
;
        LD	C,07H	; 7 
        CALL	C.F37D
;
        JR	J$7EBD
;
;	-----------------
?.7F09:	CP	C
        RES	6,A
        CALL	C$F2F6
;
        CALL	PE,C$F8FD
;
        CP	C
J$7F13:	LD	A,(DE)
        OR	A
        RET	Z
;
        PUSH	DE
        LD	E,A
        LD	C,06H	; 6 
        CALL	C.F37D
;
        POP	DE
        INC	DE
        JR	J$7F13
;
;	-----------------
?.7F21:	LD	B,D
        LD	L,A
        LD	L,A
        LD	(HL),H
        JR	NZ,J$7F8C
;
        LD	(HL),D
        LD	(HL),D
        LD	L,A
        LD	(HL),D
        DEC	C
        LD	A,(BC)
        LD	D,B
        LD	(HL),D
        LD	H,L
        LD	(HL),E
        LD	(HL),E
        JR	NZ,J$7F95
;
        LD	L,(HL)
        LD	A,C
        JR	NZ,J$7FA3
;
        LD	H,L
        LD	A,C
        JR	NZ,J$7FA2
;
        LD	L,A
        LD	(HL),D
        JR	NZ,J$7FB2
;
        LD	H,L
        LD	(HL),H
        LD	(HL),D
        LD	A,C
        DEC	C
        LD	A,(BC)
        DEFB	0,0
        LD	C,L
        LD	D,E
        LD	E,B
        LD	B,H
        LD	C,A
        LD	D,E
        JR	NZ,J$7F70
;
        LD	D,E
        LD	E,C
        LD	D,E
        DEFB	0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0
        DEFB	0,0,0,0,0,0

;	  Subroutine OEMSTA
;	     Inputs  ________________________
;	     Outputs ________________________

OEMSTA:
        SCF	
        RET	
