;  Diskdriver Philips VG-8230
;   VG8230 -> Source re-created by Z80DIS 2.2
;      Z80DIS was written by Kenneth Gielow
;                            Palo Alto, CA
        .Z80
        ORG	7405H

MYSIZE  EQU     8

C.0000	EQU	0000H	; -C--I
I.0001	EQU	0001H	; ----I
I$0008	EQU	0008H	; ----I
I$000A	EQU	000AH	; ----I
I$0012	EQU	0012H	; ----I
I$0021	EQU	0021H	; ----I
I$0022	EQU	0022H	; ----I
C.0030	EQU	0030H	; -C---
C.0038	EQU	0038H	; -C---
I$007D	EQU	007DH	; ----I
I$007F	EQU	007FH	; ----I
I$00C5	EQU	00C5H	; ----I
I$00E5	EQU	00E5H	; ----I
I.00FF	EQU	00FFH	; ----I
J.0100	EQU	0100H	; J---I
I$0101	EQU	0101H	; ----I
I.0102	EQU	0102H	; ----I
I$012C	EQU	012CH	; ----I
I$01F7	EQU	01F7H	; ----I
I.01FF	EQU	01FFH	; ----I
J.0200	EQU	0200H	; J---I
I$0201	EQU	0201H	; ----I
J$022E	EQU	022EH	; J----
I$02FF	EQU	02FFH	; ----I
I$0301	EQU	0301H	; ----I
J$0302	EQU	0302H	; J----
I$0400	EQU	0400H	; ----I
I$0502	EQU	0502H	; ----I
I$09F8	EQU	09F8H	; ----I
I$09F9	EQU	09F9H	; ----I
I$0BA6	EQU	0BA6H	; ----I
I.10FF	EQU	10FFH	; ----I
I$117B	EQU	117BH	; ----I
I$1D23	EQU	1D23H	; ----I
D.2D20	EQU	2D20H	; --S-I
I.31FF	EQU	31FFH	; ----I
D$322E	EQU	322EH	; --S--
I$364E	EQU	364EH	; ----I
I$3F00	EQU	3F00H	; ----I
J$4022	EQU	4022H	; J----
C$408F	EQU	408FH	; -C---
C$4E01	EQU	4E01H	; -C---
I$61FF	EQU	61FFH	; ----I
J$800F	EQU	800FH	; J----
I$91FF	EQU	91FFH	; ----I
I$99E1	EQU	99E1H	; ----I
D$C059	EQU	0C059H	; ---L-
J$C063	EQU	0C063H	; J----
J$C06A	EQU	0C06AH	; J----
C$C077	EQU	0C077H	; -C---
I$C085	EQU	0C085H	; ----I
I.C0AB	EQU	0C0ABH	; ----I
D$C0B9	EQU	0C0B9H	; --S--
D.C0D0	EQU	0C0D0H	; --SL-
I$E2B4	EQU	0E2B4H	; ----I
I$F51F	EQU	0F51FH	; ----I
I.FF00	EQU	0FF00H	; ----I
I$FFDE	EQU	0FFDEH	; ----I
I$FFDF	EQU	0FFDFH	; ----I

I$7405:

; Only supports 3.5 media

        DEFB	0F8h		; Media F8
        DEFW	512		; 80 Tracks
        DEFB	0Fh		; 9 sectors
        DEFB	04h		; 1 side
        DEFB	01h		; 3.5" 360 Kb
        DEFB	02h
        DEFW	1
        DEFB	2
        DEFB	112
        DEFW	12
        DEFW	355
        DEFB	2
        DEFW	5

DEFDPB  EQU     $-1

	DEFB	0F9h		; Media F9
        DEFW	512		; 80 Tracks
        DEFB	0Fh		; 9 sectors
        DEFB	04h		; 2 sides
        DEFB	01h		; 3.5" 720 Kb
        DEFB	02h
        DEFW	1
        DEFB	2
        DEFB	112
        DEFW	14
        DEFW	714
        DEFB	3
        DEFW	7

        DEFB	0FAh		; Media FA
        DEFW	512		; 80 Tracks
        DEFB	0Fh		; 8 sectors
        DEFB	04h		; 1 side
        DEFB	01h		; 3.5" 320 Kb
        DEFB	02h
        DEFW	1
        DEFB	2
        DEFB	112
        DEFW	10
        DEFW	316
        DEFB	1
        DEFW	3

        DEFB	0FBh		; Media FB
        DEFW	512		; 80 Tracks
        DEFB	0Fh		; 8 sectors
        DEFB	04h		; 2 sides
        DEFB	01h		; 3.5" 640 Kb
        DEFB	02h
        DEFW	1
        DEFB	2
        DEFB	112
        DEFW	12
        DEFW	635
        DEFB	2
        DEFW	5

;	  Subroutine DSKIO
;	     Inputs  ________________________
;	     Outputs ________________________

C.744D:	JP	NC,C.75A3
        CALL	C$7481
J.7453:	EI
        CALL	ENAINT
        PUSH	AF
        LD	C,60
        JR	NC,J$745E
        LD	C,0
J$745E:	LD	A,0D0H
        LD	(D.7FF8),A
        EX	(SP),HL
        EX	(SP),HL
        EX	(SP),HL
        EX	(SP),HL
        LD	A,(D.7FFB)
        LD	A,(D.7FF8)
        LD	(IX+0),120
        LD	A,(IX+3)
        AND	A
        JR	NZ,J$747C
        LD	(IX+1),C
        POP	AF
        RET

J$747C:	LD	(IX+2),C
        POP	AF
        RET


;	  Subroutine DSKIO write
;	     Inputs  ________________________
;	     Outputs ________________________

C$7481:	CALL	C$7D0F
        RET	C
        CALL	C.766A
        RET	C
        CALL	DISINT
        DI
J$748D:	LD	A,L
        ADD	A,0FFH
        LD	A,H
        ADC	A,01H	; 1 
        CP	40H	; "@"
        JP	C,J.74B8
        LD	A,H
        AND	A
        JP	M,J.74B8
        PUSH	HL
        PUSH	DE
        PUSH	BC
        LD	DE,($SECBUF)
        PUSH	DE
        LD	BC,512
        CALL	XFER
        POP	HL
        POP	BC
        POP	DE
        CALL	C.74C7		; write sector
        CALL	C.7B4B
        POP	HL
        JP	J$74BE

J.74B8:	CALL	C.74C7		; write sector
        CALL	C.7B4B
J$74BE:	RET	C
        DEC	B
        RET	Z
        CALL	C.7744
        JP	J$748D


;	  Subroutine write sector
;	     Inputs  ________________________
;	     Outputs ________________________

C.74C7:	LD	E,15H
J$74C9:	CALL	C.77A4
        LD	A,0A0H
        BIT	6,D
        JR	Z,J.74DA
        OR	02H	; 2 
        BIT	0,D
        JR	Z,J.74DA
        OR	08H	; 8 
J.74DA:	PUSH	HL
        PUSH	DE
        PUSH	BC
        LD	DE,I$7544
        PUSH	DE
        LD	(D.7FF8),A
        EX	(SP),IY
        EX	(SP),IY
        LD	BC,I.7FFF
        LD	DE,0
J.74EE:	LD	A,(BC)
        ADD	A,A
        JP	NC,J.753C
        RET	P
        LD	A,(BC)
        ADD	A,A
        JP	NC,J.753C
        RET	P
        DEC	E
        JP	NZ,J.74EE
        LD	A,(BC)
        ADD	A,A
        JP	NC,J.753C
        RET	P
        LD	A,(BC)
        ADD	A,A
        JP	NC,J.753C
        RET	P
        DEC	D
        JP	NZ,J.74EE
J$750E:	POP	BC
        POP	BC
        POP	DE
        POP	HL
        LD	A,2		; not ready
        RET

J$7515:	LD	D,00H
J$7517:	LD	A,(BC)
        ADD	A,A
        RET	P
        JP	NC,J.753C
        LD	A,(BC)
        ADD	A,A
        RET	P
        JP	NC,J.753C
        LD	A,(BC)
        ADD	A,A
        RET	P
        JP	NC,J.753C
        LD	A,(BC)
        ADD	A,A
        RET	P
        JP	NC,J.753C
        LD	A,(BC)
        ADD	A,A
        RET	P
        JP	NC,J.753C
        DEC	D
        JP	NZ,J$7517
        JP	J$750E

J.753C:	LD	A,(HL)
        LD	(D.7FFB),A
        INC	HL
        JP	J$7515

I$7544:	POP	BC
        POP	DE
        POP	HL
        LD	A,(D.7FF8)
        AND	0FCH
        RET	Z
        BIT	6,A
        JR	NZ,J$757B
        PUSH	AF
        LD	A,(IX+3)
        OR	0C4H
        LD	(D.7FFD),A
        CALL	C.7789
        POP	AF
        DEC	E
        JP	NZ,J$74C9
        SCF
        LD	E,A
        BIT	7,E
        LD	A,02H	; 2 
        RET	NZ
        BIT	5,E
        LD	A,0AH	; 10 
        RET	NZ
        BIT	4,E
        LD	A,08H	; 8 
        RET	NZ
        BIT	3,E
        LD	A,04H	; 4 
        RET	NZ
        LD	A,0CH	; 12 
        RET

J$757B:	LD	A,0D0H
        LD	(D.7FF8),A
        EX	(SP),HL
        EX	(SP),HL
        LD	A,80H
        LD	(D.7FF8),A
        EX	(SP),HL
        EX	(SP),HL
        LD	HL,I.7FFF
        LD	DE,C.0000
J$758F:	LD	A,(HL)
        ADD	A,A
        JR	C,J.75A0
        JP	P,J.75A0
        DEC	DE
        LD	A,E
        OR	D
        JP	NZ,J$758F
        LD	A,02H	; 2 
        SCF
        RET

J.75A0:	XOR	A
        SCF
        RET


;	  Subroutine DSKIO read
;	     Inputs  ________________________
;	     Outputs ________________________

C.75A3:	CALL	C$75A9
        JP	J.7453


;	  Subroutine __________________________
;	     Inputs  ________________________
;	     Outputs ________________________

C$75A9:	CALL	C.766A
        RET	C

;	  Subroutine __________________________
;	     Inputs  ________________________
;	     Outputs ________________________

C$75AD:	CALL	DISINT
        DI
J$75B1:	LD	A,L
        ADD	A,0FFH
        LD	A,H
        ADC	A,01H	; 1 
        CP	40H	; "@"
        JP	C,J.75DE
        LD	A,H
        AND	A
        JP	M,J.75DE
        PUSH	HL
        LD	HL,($SECBUF)
        CALL	C.75EA		; read sector
        POP	HL
        RET	C
        PUSH	HL
        PUSH	DE
        PUSH	BC
        EX	DE,HL
        LD	HL,($SECBUF)
        LD	BC,512
        CALL	XFER
        POP	BC
        POP	DE
        POP	HL
        AND	A
        JP	J$75E2

J.75DE:	CALL	C.75EA		; read sector
        RET	C
J$75E2:	DEC	B
        RET	Z
        CALL	C.7744
        JP	J$75B1


;	  Subroutine read sector
;	     Inputs  ________________________
;	     Outputs ________________________

C.75EA:	LD	E,15H
J$75EC:	CALL	C.77A4
        LD	A,80H
        BIT	6,D
        JR	Z,J.75FD
        OR	02H	; 2 
        BIT	0,D
        JR	Z,J.75FD
        OR	08H	; 8 
J.75FD:	PUSH	HL
        PUSH	DE
        PUSH	BC
        LD	BC,I.7FFF
        LD	DE,I$7639
        PUSH	DE
        LD	(D.7FF8),A
        LD	DE,0
J.760D:	LD	A,(BC)
        ADD	A,A
        JP	NC,J.7627
        RET	P
        DEC	E
        JP	NZ,J.760D
        LD	A,(BC)
        ADD	A,A
        JP	NC,J.7627
        RET	P
        DEC	D
        JP	NZ,J.760D
        POP	BC
        POP	BC
        POP	DE
        POP	HL
        JR	J.7666

J.7627:	LD	DE,D.7FFB
        JP	J$7633

J.762D:	LD	A,(BC)
        ADD	A,A
        RET	P
        JP	C,J.762D
J$7633:	LD	A,(DE)
        LD	(HL),A
        INC	HL
        JP	J.762D

I$7639:	POP	BC
        POP	DE
        POP	HL
        LD	A,(D.7FF8)
        AND	9CH
        RET	Z
        PUSH	AF
        LD	A,(IX+3)
        OR	0C4H
        LD	(D.7FFD),A
        CALL	C.7789
        POP	AF
        DEC	E
        JR	NZ,J$75EC
        SCF
        LD	E,A
        BIT	7,E
        LD	A,02H	; 2 
        RET	NZ
        BIT	4,E
        LD	A,08H	; 8 
        RET	NZ
        BIT	3,E
        LD	A,04H	; 4 
        RET	NZ
        LD	A,0CH	; 12 
        RET

J.7666:	LD	A,2
        SCF
        RET


;	  Subroutine __________________________
;	     Inputs  ________________________
;	     Outputs ________________________

C.766A:	PUSH	AF
        PUSH	BC
        PUSH	DE
        PUSH	HL
        CALL	GETWRK
        POP	HL
        POP	DE
        POP	BC
        POP	AF

;	  Subroutine __________________________
;	     Inputs  ________________________
;	     Outputs ________________________

C.7675:	CP	2
        JR	C,J$767D
J$7679:	LD	A,0CH	; 12 
        SCF
        RET

J$767D:	PUSH	AF
        LD	A,C
        CP	0F8H
        JR	C,J$7687
        CP	0FCH
        JR	C,J$768A
J$7687:	POP	AF
        JR	J$7679

J$768A:	EX	(SP),HL
        PUSH	HL
        PUSH	BC
        CALL	C.77A4
        BIT	1,C
        LD	C,E
        LD	B,D
        LD	DE,8
        JR	NZ,J$769A
        INC	DE
J$769A:	CALL	DIV16
        LD	A,L
        INC	A
        LD	(D.7FFA),A
        LD	L,C
        POP	BC
        POP	AF
        LD	H,A
        XOR	A
        BIT	0,C
        JR	Z,J.76B0
        SRL	L
        JR	NC,J.76B0
        INC	A
J.76B0:	LD	(D.7FFC),A
        LD	D,A
        LD	A,(IX+7)
        DEC	A
        JR	Z,J$76BF
        LD	A,H
        NOP
        NOP
        NOP
J$76BF:	OR	0C4H
        CALL	DISINT
        DI
        LD	(D.7FFD),A
        LD	A,(IX)
        AND	A		; motor still turning ?
        LD	(IX),0FFH	; disable motor off
        EI
        CALL	ENAINT
        JR	NZ,J$76E2	; yep, skip motor startup
        CALL	C.77BC
        CALL	C.77BC
        CALL	C.77BC
        CALL	C.77BC
J$76E2:	LD	A,C
        RRCA
        RRCA
        AND	0C0H
        OR	D
        LD	D,A
        LD	C,L
        LD	A,(IX+7)
        DEC	A
        JR	Z,J$7715
        LD	A,(IX+3)
        CP	H
        JR	Z,J.7735
        XOR	01H	; 1 
        LD	(IX+3),A
        LD	A,(D.7FF9)
        JR	Z,J$7708
        LD	(IX+4),A
        LD	A,(IX+5)
        JR	J$770E

J$7708:	LD	(IX+5),A
        LD	A,(IX+4)
J$770E:	LD	(D.7FF9),A
        EX	(SP),HL
        EX	(SP),HL
        JR	J$7738

J$7715:	LD	A,(IX+6)
        AND	03H	; 3 
        CP	H
        JR	Z,J.7735
        LD	A,(IX+6)
        AND	0FCH
        OR	H
        LD	(IX+6),A
        PUSH	IX
        PUSH	HL
        PUSH	DE
        PUSH	BC
        PUSH	AF
        CALL	PROMPT
        POP	AF
        POP	BC
        POP	DE
        POP	HL
        POP	IX
J.7735:	LD	A,(D.7FF9)
J$7738:	CP	C
        CALL	C$778F
        POP	HL
        RET


;	  Subroutine __________________________
;	     Inputs  ________________________
;	     Outputs ________________________

C.773E:	CALL	C.77A4
        JP	J$775A


;	  Subroutine __________________________
;	     Inputs  ________________________
;	     Outputs ________________________

C.7744:	CALL	C.77A4
        INC	H
        INC	H
        LD	A,(D.7FFA)
        INC	A
        LD	(D.7FFA),A
        BIT	7,D
        JR	NZ,J$7757
        CP	0AH	; 10 
        RET	C
J$7757:	CP	09H	; 9 
        RET	C
J$775A:	LD	A,01H	; 1 
        LD	(D.7FFA),A
        BIT	6,D
        JR	Z,J.7770
        BIT	0,D
        JR	NZ,J.7770
        SET	0,D
        LD	A,01H	; 1 
        LD	(D.7FFC),A
        JR	J$7785

J.7770:	RES	0,D
        LD	A,00H
        LD	(D.7FFC),A
        INC	C
        CALL	C.77A4
        LD	A,50H	; "P"
        LD	(D.7FF8),A
        EX	(SP),HL
        EX	(SP),HL
        CALL	C.77A4
J$7785:	SCF
        CCF
        JR	J.77C8


;	  Subroutine __________________________
;	     Inputs  ________________________
;	     Outputs ________________________

C.7789:	BIT	0,E
        RET	NZ
        CALL	C.77B5

;	  Subroutine __________________________
;	     Inputs  ________________________
;	     Outputs ________________________

C$778F:	CALL	C.77A4
        LD	A,C
        LD	(D.7FFB),A
        EX	(SP),HL
        EX	(SP),HL
        LD	A,10H	; 16 
J$779A:	LD	(D.7FF8),A
        EX	(SP),HL
        EX	(SP),HL
        CALL	C.77A4
        JR	J.77C8


;	  Subroutine __________________________
;	     Inputs  ________________________
;	     Outputs ________________________

C.77A4:	PUSH	DE
J$77A5:	LD	DE,C.0000
        LD	A,(D.7FF8)
        RRA
        JR	NC,J$77B3
        DEC	DE
        LD	A,D
        OR	E
        JR	NZ,J$77A5
J$77B3:	POP	DE
        RET


;	  Subroutine __________________________
;	     Inputs  ________________________
;	     Outputs ________________________

C.77B5:	CALL	C.77A4
        LD	A,02H	; 2 
        JR	J$779A


;	  Subroutine __________________________
;	     Inputs  ________________________
;	     Outputs ________________________

C.77BC:	PUSH	HL
        LD	HL,I$99E1
        JR	J.77D8

?.77C2:	PUSH	HL
        LD	HL,I$1D23
        JR	J.77D8

J.77C8:	PUSH	HL
        LD	HL,I$117B
        JR	J.77D8

?.77CE:	PUSH	HL
        LD	HL,I$0BA6
        JR	J.77D8

?.77D4:	PUSH	HL
        LD	HL,I$012C
J.77D8:	DEC	HL
        LD	A,H
        OR	L
        JR	NZ,J.77D8
        POP	HL
        XOR	A
        RET

INIHRD:
	LD	A,0D0H
        LD	(D.7FF8),A
        EX	(SP),HL
        EX	(SP),HL
        LD	A,0C0H
        CALL	C.77F7
        LD	A,0C1H
        CALL	C.77F7

MTOFF:
        LD	A,03H	; 3 
        LD	(D.7FFD),A
        RET


;	  Subroutine __________________________
;	     Inputs  ________________________
;	     Outputs ________________________

C.77F7:	LD	(D.7FFD),A
        CALL	C.77A4
        LD	A,02H	; 2 
        LD	(D.7FF8),A
        EX	(SP),HL
        EX	(SP),HL
        LD	HL,C.0000
J$7807:	LD	A,(D.7FF8)
        RRA
        JR	NC,J$7812
        DEC	HL
        LD	A,L
        OR	H
        JR	NZ,J$7807
J$7812:	LD	A,05H	; 5 
        LD	(D.7FFB),A
        EX	(SP),HL
        EX	(SP),HL
        CALL	C.77A4
        LD	A,10H	; 16 
        LD	(D.7FF8),A
        CALL	C.77A4
        LD	A,02H	; 2 
        LD	(D.7FF8),A
        CALL	C.77A4
        RET

DRIVES:
	PUSH	BC
        PUSH	AF
        CALL	GETWRK
        LD	A,0C1H
        LD	(D.7FFD),A
        CALL	C.77A4
        LD	A,02H	; 2 
        LD	(D.7FF8),A
        EX	(SP),HL
        EX	(SP),HL
        LD	HL,C.0000
J$7844:	LD	A,(D.7FF8)
        RRA
        JR	NC,J$7851
        DEC	HL
        LD	A,L
        OR	H
        JR	NZ,J$7844
        INC	L
        DEFB    0CAH
J$7851:	LD      L,2
        LD	(IX+7),L
        LD	A,03H	; 3 
        LD	(D.7FFD),A
        POP	AF
        JR	Z,J$7860
        LD	L,2
J$7860:	POP	BC
        RET

INIENV:
	CALL	GETWRK
        XOR	A
        LD	B,07H	; 7 
J$7868:	LD	(HL),A
        INC	HL
        DJNZ	J$7868
        LD	HL,I$7872
        JP	SETINT

I$7872:	PUSH	AF
        CALL	GETWRK
        LD	A,(HL)
        AND	A
        JR	Z,J.7887
        CP	0FFH
        JR	Z,J.7887
        DEC	A
        LD	(HL),A
        JR	NZ,J.7887
        LD	A,03H	; 3 
        LD	(D.7FFD),A
J.7887:	INC	HL
        LD	A,(HL)
        AND	A
        JR	Z,J$788D
        DEC	(HL)
J$788D:	INC	HL
        LD	A,(HL)
        AND	A
        JR	Z,J$7893
        DEC	(HL)
J$7893:	POP	AF
        JP	PRVINT

DSKCHG:
	EI
        PUSH	HL
        PUSH	BC
        PUSH	AF
        CALL	GETWRK
        POP	AF
        POP	BC
        POP	HL
        LD	B,(IX+7)
        DEC	B
        JP	Z,J.78BD
        CP	(IX+3)
        JP	NZ,J.78BD
        AND	A
        LD	B,(IX+2)
        JR	NZ,J$78B7
        LD	B,(IX+1)
J$78B7:	AND	A
        INC	B
        DEC	B
        LD	B,1
        RET	NZ
J.78BD:	PUSH	BC
        PUSH	HL
        LD	B,1
        LD	DE,1
        LD	HL,($SECBUF)
        CALL	C.75A3		; DSKIO read
        JR	C,J.78E3
        LD	HL,($SECBUF)
        LD	B,(HL)
        POP	HL
        PUSH	BC
        CALL	C$78EB
        LD	A,0CH	; 12 
        JR	C,J.78E3
        POP	AF
        POP	BC
        CP	C
        SCF
        CCF
        LD	B,0FFH
        RET	NZ
        INC	B
        RET

J.78E3:	PUSH	AF
        CALL	C.77B5
        POP	AF
        POP	DE
        POP	DE
        RET


;	  Subroutine __________________________
;	     Inputs  ________________________
;	     Outputs ________________________

GETDPB:
C$78EB:	EX	DE,HL
        INC	DE
        LD	A,B
        SUB	0F8H
        RET	C
        CP	04H	; 4 
        JR	NC,J$7909
        LD	L,A
        LD	H,00H
        ADD	HL,HL
        LD	C,L
        LD	B,H
        ADD	HL,HL
        ADD	HL,HL
        ADD	HL,HL
        ADD	HL,BC
        LD	BC,I$7405
        ADD	HL,BC
        LD	BC,I$0012
        LDIR
        RET

J$7909:	SCF
        RET

CHOICE:
	DEC	A                       ; drive 1 ?
        JR	Z,J$7954                ; yep, offer format choices
        LD	HL,I$7918
        CALL	C.7C97                  ; print message
        LD	HL,0                    ; no format choices
        RET

I$7918:	DEFB	13,10
        DEFB	"Single Sided ...",13,10
        DEFB	"( Use another drive for Double Side )",13,10
        DEFB	0

J$7954:	LD	HL,I$7958
        RET

I$7958:	DEFB	"1 - Single Side ...",13,10
        DEFB	"2 - Double Side ...",13,10
        DEFB	0

DSKFMT:
        EI
        LD	(HL),D
        PUSH	BC
        LD	BC,I$0022
J$7989:	ADD	HL,BC
        POP	BC
        PUSH	DE
        PUSH	HL
        LD	DE,I$E2B4
        PUSH	BC
        POP	HL
        ADD	HL,DE
        POP	HL
J$7994:	POP	DE
        JR	C,J.799F
J$7997:	CCF
        LD	A,0EH	; 14 
        RET

J$799B:	CCF
J.799C:	LD	A,0CH	; 12 
        RET

J.799F:	PUSH	AF
        PUSH	HL
        PUSH	DE
        PUSH	BC
        CALL	GETWRK
        POP	BC
J$79A7:	POP	DE
        POP	HL
        POP	AF
        DEC	D
        JR	NZ,J$79BB
J$79AC	EQU	$-1
        SUB	01H	; 1 
        JR	C,J.799C
J$79B0	EQU	$-1
        CP	02H	; 2 
        JR	NC,J$799B
        LD	BC,I$09F9
J$79B6	EQU	$-2
J$79B7	EQU	$-1
        DEC	A
        JR	Z,J$79C1
J$79BB:	LD	BC,I$09F8
        LD	A,D
        JR	J$79C8

J$79C1:	LD	A,(IX+7)
        CP	02H	; 2 
        JR	C,J.799C
J$79C8:	INC	D
        LD	A,D
        PUSH	BC
        LD	B,50H	; "P"
J$79CC	EQU	$-1
        BIT	0,C
        JR	Z,J$79D3
        LD	B,0A0H
J$79D3:	LD	A,D
        PUSH	AF
        PUSH	DE
        PUSH	HL
        PUSH	BC
        PUSH	AF
        LD	B,02H	; 2 
        LD	DE,C.0000
        CALL	C.7675
        JP	C,J.7A5A
        CALL	C.77B5
        POP	AF
        PUSH	AF
J$79E9:	CALL	C.7BE4
        PUSH	HL
        CALL	C.7A9D
        POP	HL
        JP	C,J.7A5A
        DEC	B
        JP	Z,J$79FE
        CALL	C.773E
        JP	J$79E9

J$79FE:	POP	AF
        POP	BC
        PUSH	BC
        PUSH	AF
        LD	B,1
        LD	DE,0
        CALL	C.75A3		; DSKIO read
        JP	C,J$7A63
        POP	AF
        POP	BC
        POP	HL
        POP	DE
        LD	DE,C.0000
        CALL	C.7675
        JP	C,J.7A6C
        PUSH	AF
        PUSH	HL
        LD	HL,I$7CA2
        CALL	C.7C97
        POP	HL
        CALL	C.77B5
        POP	AF
J$7A27:	CALL	C.7BE4
        PUSH	HL
        CALL	C.7A9D
        CALL	C$7A7B
        POP	HL
        JP	C,J.7A6C
        DEC	B
        JP	Z,J$7A3F
        CALL	C.773E
        JP	J$7A27

J$7A3F:	CALL	C.77B5
        POP	AF
        POP	BC
        PUSH	AF
        LD	DE,I.0001
        CALL	C$7BB5
        POP	AF
        PUSH	AF
        CALL	C$7A72
        JP	C,J$7A6D
        POP	AF
        CALL	C$7CB3
        JP	J.7453

J.7A5A:	POP	HL
        POP	DE
        POP	BC
        POP	BC
        POP	BC
        POP	BC
        JP	J.7453

J$7A63:	POP	HL
        POP	DE
        POP	BC
        POP	BC
        POP	BC
        POP	BC
        JP	J.799C

J.7A6C:	POP	BC
J$7A6D:	POP	BC
        SCF
        JP	J.7453


;	  Subroutine __________________________
;	     Inputs  ________________________
;	     Outputs ________________________

C$7A72:	PUSH	BC
        PUSH	HL
        SCF
        CALL	C.744D
        POP	HL
        POP	BC
        RET


;	  Subroutine __________________________
;	     Inputs  ________________________
;	     Outputs ________________________

C$7A7B:	RET	C
        LD	A,(RAWFLG)
        OR	A
        RET	Z
        PUSH	BC
        PUSH	DE
        PUSH	HL
        PUSH	AF
        BIT	7,D
        LD	B,09H	; 9 
        JR	NZ,J$7A8D
        LD	B,08H	; 8 
J$7A8D:	LD	A,01H	; 1 
        LD	(D.7FFA),A
        CALL	C.77A4
        CALL	C$75AD
        POP	HL
        POP	HL
        POP	DE
        POP	BC
        RET


;	  Subroutine __________________________
;	     Inputs  ________________________
;	     Outputs ________________________

C.7A9D:	LD	E,15H
J$7A9F:	CALL	C.77A4
        LD	A,0F0H
        PUSH	HL
        PUSH	DE
        PUSH	BC
        LD	DE,I$7AE6
        PUSH	DE
        CALL	DISINT
        DI
        EX	(SP),IY
        EX	(SP),IY
        LD	BC,I.7FFF
        LD	DE,C.0000
        LD	(D.7FF8),A
J.7ABC:	LD	A,(BC)
        ADD	A,A
        JP	NC,J.7ADE
        RET	P
        DEC	E
        JP	NZ,J.7ABC
        LD	A,(BC)
        ADD	A,A
        JP	NC,J.7ADE
        RET	P
        DEC	D
        JP	NZ,J.7ABC
        POP	BC
        POP	BC
        POP	DE
        POP	HL
        LD	A,02H	; 2 
        SCF
        RET

J.7AD8:	LD	A,(BC)
        ADD	A,A
        RET	P
        JP	C,J.7AD8
J.7ADE:	LD	A,(HL)
        LD	(D.7FFB),A
        INC	HL
        JP	J.7AD8

I$7AE6:	POP	BC
        POP	DE
        POP	HL
        EI
        CALL	ENAINT
        LD	A,(D.7FF8)
        AND	0FCH
        RET	Z
        BIT	6,A
        JR	NZ,J$7B21
        PUSH	AF
        LD	A,(IX+3)
        OR	0C4H
        LD	(D.7FFD),A
        CALL	C.7789
        POP	AF
        DEC	E
        JP	NZ,J$7A9F
        SCF
        LD	E,A
        BIT	7,E
        LD	A,02H	; 2 
        RET	NZ
        BIT	5,E
        LD	A,0AH	; 10 
        RET	NZ
        BIT	4,E
        LD	A,08H	; 8 
        RET	NZ
        BIT	3,E
        LD	A,04H	; 4 
        RET	NZ
        LD	A,0CH	; 12 
        RET

J$7B21:	LD	A,0D0H
        LD	(D.7FF8),A
        EX	(SP),IY
        EX	(SP),IY
        LD	A,80H
        LD	(D.7FF8),A
        EX	(SP),IY
        EX	(SP),IY
        LD	HL,I.7FFF
        LD	DE,C.0000
J$7B39:	LD	A,(HL)
        ADD	A,A
        JP	P,J.75A0
        JP	NC,J.75A0
        DEC	DE
        LD	A,E
        OR	D
        JP	NZ,J$7B39
        LD	A,02H	; 2 
        SCF
        RET


;	  Subroutine __________________________
;	     Inputs  ________________________
;	     Outputs ________________________

C.7B4B:	RET	C
        LD	A,(RAWFLG)
        OR	A
        RET	Z
        PUSH	HL
        PUSH	DE
        PUSH	BC
        CALL	C.77A4
        LD	A,80H
        BIT	6,D
        JR	Z,J.7B65
        OR	02H	; 2 
        BIT	0,D
        JR	Z,J.7B65
        OR	08H	; 8 
J.7B65:	LD	DE,I$7BA8
        PUSH	DE
        LD	(D.7FF8),A
        EX	(SP),IY
        EX	(SP),IY
        LD	DE,C.0000
        LD	BC,I.7FFF
J.7B76:	LD	A,(BC)
        ADD	A,A
        JP	NC,J.7B8F
        RET	P
        DEC	E
        JR	NZ,J.7B76
        LD	A,(BC)
        ADD	A,A
        JP	NC,J.7B8F
        RET	P
        DEC	D
        JR	NZ,J.7B76
        POP	BC
        POP	BC
        POP	DE
        POP	HL
        JP	J.7666

J.7B8F:	LD	DE,D.7FFB
        JP	J$7B9B

J.7B95:	LD	A,(BC)
        ADD	A,A
        RET	P
        JP	C,J.7B95
J$7B9B:	LD	A,(DE)
        INC	C
        CPI
        JP	Z,J.7B95
J$7BA2:	LD	A,(BC)
        ADD	A,A
        RET	P
        JP	J$7BA2

I$7BA8:	POP	BC
        POP	DE
        POP	HL
        LD	A,(D.7FF8)
        AND	9CH
        RET	Z
        LD	A,0AH	; 10 
        SCF
        RET


;	  Subroutine __________________________
;	     Inputs  ________________________
;	     Outputs ________________________

C$7BB5:	PUSH	HL
        PUSH	DE
        LD	B,01H	; 1 
        BIT	1,C
        JR	NZ,J$7BBE
        INC	B
J$7BBE:	BIT	0,C
        JR	Z,J$7BC3
        INC	B
J$7BC3:	SLA	B
        LD	A,07H	; 7 
        ADD	A,B
        LD	B,A
        PUSH	BC
J$7BCA:	LD	DE,512
J$7BCD:	LD	(HL),00H
        INC	HL
        DEC	DE
        LD	A,D
        OR	E
        JR	NZ,J$7BCD
        DJNZ	J$7BCA
        POP	BC
        POP	DE
        POP	HL
        LD	(HL),C
        INC	HL
        LD	(HL),0FFH
        INC	HL
        LD	(HL),0FFH
        DEC	HL
        DEC	HL
        RET


;	  Subroutine __________________________
;	     Inputs  ________________________
;	     Outputs ________________________

C.7BE4:	PUSH	BC
        LD	BC,I$FFDF
        ADD	HL,BC
        POP	BC
        PUSH	IY
        PUSH	HL
        PUSH	IX
        PUSH	BC
        PUSH	DE
        PUSH	HL
        POP	IX
        LD	DE,I$7C76
        LD	B,21H	; "!"
J$7BF9:	LD	A,(DE)
        LD	(HL),A
        INC	HL
        INC	DE
        DJNZ	J$7BF9
        LD	DE,I$7C6B
        CALL	C.7C57
        CALL	C$7C36
        POP	DE
        PUSH	DE
        BIT	7,D
        LD	B,09H	; 9 
        JR	Z,J.7C12
        LD	B,08H	; 8 
J.7C12:	PUSH	IX
        POP	DE
        CALL	C.7C57
        INC	(IX+10)
        DJNZ	J.7C12
        LD	DE,I$0400
J$7C20:	LD	(HL),4EH	; "N"
        INC	HL
        DEC	DE
        LD	A,D
        OR	E
        JR	NZ,J$7C20
        POP	DE
        POP	BC
        POP	IX
        POP	HL
        POP	IY
        PUSH	BC
        LD	BC,I$0021
        ADD	HL,BC
        POP	BC
        RET


;	  Subroutine __________________________
;	     Inputs  ________________________
;	     Outputs ________________________

C$7C36:	POP	IY
        POP	DE
        POP	BC
        PUSH	BC
        PUSH	DE
        PUSH	IY
        BIT	6,D
        JR	Z,J$7C46
        BIT	0,D
        JR	NZ,J$7C4A
J$7C46:	LD	D,00H
        JR	J$7C4C

J$7C4A:	LD	D,01H	; 1 
J$7C4C:	LD	(IX+6),C
        LD	(IX+8),D
        LD	(IX+10),01H	; 1 
        RET


;	  Subroutine __________________________
;	     Inputs  ________________________
;	     Outputs ________________________

C.7C57:	PUSH	BC
        PUSH	DE
J$7C59:	LD	A,(DE)
        LD	C,A
        INC	A
        JR	Z,J$7C68
        INC	DE
        LD	A,(DE)
        LD	B,A
        INC	DE
J$7C62:	LD	(HL),C
        INC	HL
        DJNZ	J$7C62
        JR	J$7C59

J$7C68:	POP	DE
        POP	BC
        RET

I$7C6B:	LD	C,(HL)
        LD	D,B
        NOP
        INC	C
        OR	03H	; 3 
        CALL	M,C$4E01
        LD	A,(DE)
        RST	38H
I$7C76:	NOP
        INC	C
        PUSH	AF
        INC	BC
        CP	01H	; 1 
        NOP
        LD	BC,J.0100
        LD	BC,I$0201
        LD	BC,I$01F7
        LD	C,(HL)
        JR	J$7C89

J$7C89:	INC	C
        PUSH	AF
        INC	BC
        EI
        LD	BC,I$00E5
        PUSH	HL
        NOP
        RST	30H
        LD	BC,I$364E
        RST	38H

;	  Subroutine __________________________
;	     Inputs  ________________________
;	     Outputs ________________________

C.7C97:	LD	A,(HL)
        AND	A
        JR	Z,J$7CA1
        CALL	C$408F
        INC	HL
        JR	C.7C97

J$7CA1:	RET

I$7CA2:	DEFB	13,10
        DEFB	"Formatting...."
        DEFB	0

;	  Subroutine __________________________
;	     Inputs  ________________________
;	     Outputs ________________________

C$7CB3:	PUSH	BC
        PUSH	DE
        PUSH	HL
        PUSH	IX
        PUSH	HL
        POP	IX
        SCF
        PUSH	AF
        PUSH	HL
        PUSH	BC
        LD	BC,I$00C5
        PUSH	HL
        POP	DE
        LD	HL,I$7D6E
        LDIR
        POP	BC
        BIT	0,C
        JR	Z,J$7CE2
        LD	(IX+19),0A0H
        LD	(IX+20),05H	; 5 
        LD	(IX+21),0F9H
        LD	(IX+22),03H	; 3 
        LD	(IX+26),02H	; 2 
J$7CE2:	LD	B,01H	; 1 
        POP	HL
        POP	AF
        PUSH	HL
        LD	DE,C.0000
        CALL	C.744D
        POP	HL
        LD	BC,I$FFDE
        ADD	HL,BC
        LD	BC,I$0101
J$7CF5:	PUSH	BC
J$7CF6:	LD	DE,512
J$7CF9:	LD	(HL),00H
        INC	HL
        DEC	DE
        LD	A,D
        OR	E
        JR	NZ,J$7CF9
        DJNZ	J$7CF6
        POP	BC
        DEC	C
        JR	NZ,J$7CF5
        POP	IX
        POP	HL
        POP	DE
        POP	BC
        RET

OEMSTA:
	SCF
        RET


;	  Subroutine __________________________
;	     Inputs  ________________________
;	     Outputs ________________________

C$7D0F:	PUSH	HL
        PUSH	DE
        PUSH	BC
        PUSH	AF
        CALL	GETWRK
        POP	AF
        POP	BC
        PUSH	BC
        PUSH	AF
        BIT	0,C		; single sided media ?
        JR	Z,J.7D67	; yep, skip check
        LD	B,1
        LD	DE,10
        LD	HL,($SECBUF)
        OR	A		; drive 0 ?
        JR	NZ,J$7D46	; no, drive 1
        BIT	6,(IX+6)
        SET	6,(IX+6)
        JR	Z,J$7D3B
        BIT	4,(IX+6)
        JR	NZ,J.7D67
        JR	J.7D61

J$7D3B:	CALL	C.75A3		; DSKIO read
        JR	C,J.7D61	; error,
        SET	4,(IX+6)
        JR	J.7D67

J$7D46:	BIT	7,(IX+6)
        SET	7,(IX+6)
        JR	Z,J$7D58
        BIT	5,(IX+6)
        JR	NZ,J.7D67
        JR	J.7D61

J$7D58:	CALL	C.75A3		; DSKIO read
        SET	5,(IX+6)
        JR	NC,J.7D67
J.7D61:	POP	AF
        LD	A,8		; record not found
        SCF
        JR	J$7D6A

J.7D67:	POP	AF
        SCF
        CCF
J$7D6A:	POP	BC
        POP	DE
        POP	HL
        RET

I$7D6E:	EX	DE,HL
        CP	90H
        LD	B,C
        LD	D,E
        LD	B,E
        JR	NZ,J$7D96
        LD	(D$322E),A
        NOP
        LD	(BC),A
        LD	(BC),A
        LD	BC,J.0200
        LD	(HL),B
        NOP
        RET	NC
        LD	(BC),A
        RET	M
        LD	(BC),A
        NOP
        ADD	HL,BC
        NOP
        LD	BC,C.0000
        NOP
        RET	NC
        LD	(D$C059),DE
        LD	(D.C0D0),A
        LD	(HL),56H	; "V"
J$7D96:	INC	HL
        LD	(HL),0C0H
J$7D99:	LD	SP,I$F51F
        LD	DE,I.C0AB
        LD	C,0FH	; 15 
        CALL	BDOS
        INC	A
        JP	Z,J$C063
        LD	DE,J.0100
        LD	C,1AH
        CALL	BDOS
        LD	HL,I.0001
        LD	(D$C0B9),HL
        LD	HL,I$3F00
        LD	DE,I.C0AB
        LD	C,27H	; "'"
        CALL	BDOS
        JP	J.0100

?.7DC4:	LD	E,B
        RET	NZ
        CALL	C.0000
        LD	A,C
        AND	0FEH
        CP	02H	; 2 
        JP	NZ,J$C06A
        LD	A,(D.C0D0)
        AND	A
        JP	Z,J$4022
        LD	DE,I$C085
        CALL	C$C077
        LD	C,07H	; 7 
        CALL	BDOS
        JR	J$7D99

J$7DE5:	LD	A,(DE)
        INC	DE
        OR	A
        RET	Z
        PUSH	DE
        LD	E,A
        LD	C,06H	; 6 
        CALL	BDOS
        POP	DE
        JR	J$7DE5

?.7DF3:	LD	B,D
        LD	L,A
        LD	L,A
        LD	(HL),H
        JR	NZ,J$7E5E
        LD	(HL),D
        LD	(HL),D
        LD	L,A
        LD	(HL),D
I$7DFD:	DEC	C
        LD	A,(BC)
        LD	D,B
        LD	(HL),D
        LD	H,L
        LD	(HL),E
        LD	(HL),E
        JR	NZ,J$7E67
        LD	L,(HL)
        LD	A,C
        JR	NZ,J$7E75
        LD	H,L
        LD	A,C
        JR	NZ,J$7E74
        LD	L,A
        LD	(HL),D
        JR	NZ,J$7E84
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
        JR	NZ,J$7E42
        LD	D,E
        LD	E,C
        LD	D,E
        DEFB	0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0
        DEFB	0,0,0,0,0
        DEFB	0FDH		; << Illegal Op Code Byte >>

        DEFB	0,0
        RST	38H
J$7E42:	DJNZ	J$7E43
J$7E43	EQU	$-1
        NOP
        RST	38H
        NOP
        RST	38H
        NOP
        RST	38H
        NOP
        RST	38H
        NOP
        RST	38H
        NOP
        RST	38H
        DEFB	0FDH		; << Illegal Op Code Byte >>

        NOP
        RST	38H
        NOP
        RST	38H
        NOP
        RST	38H
        NOP
        RST	38H
        NOP
        RST	38H
        NOP
        DEFB	0FDH		; << Illegal Op Code Byte >>

        NOP
J$7E5E:	DEFB	0DDH		; << Illegal Op Code Byte >>

        DEFB	0,0
        RST	38H
        LD	DE,I$007F
        RST	38H
        LD	BC,I.01FF
J$7E67	EQU	$-2
        RST	38H
        LD	DE,I.00FF
        RST	38H
        DJNZ	J$7E6F
J$7E6F	EQU	$-1
        RST	38H
        NOP
        RST	38H
        NOP
J$7E74:	RST	38H
J$7E75:	JR	NZ,J$7E76
J$7E76	EQU	$-1
        LD	B,B
        RST	38H
        LD	BC,I.00FF
        RST	38H
        NOP
        RST	38H
        LD	BC,I.FF00
        NOP
        RST	38H
J$7E84:	NOP
        RST	38H
        NOP
        RST	38H
        NOP
        RST	38H
        NOP
        RST	38H
        NOP
        RST	38H
        NOP
        RST	38H
        RST	38H
        NOP
        DEFB	0FDH		; << Illegal Op Code Byte >>

        NOP
        RST	38H
        NOP
        RST	38H
        NOP
        RST	38H
        NOP
        RST	38H
        NOP
        RST	38H
        NOP
        RST	38H
        NOP
        JR	J$7EA1
J$7EA1	EQU	$-1

?.7EA2:	SUB	B
        RST	38H
        ADD	HL,BC
        RST	38H
        LD	DE,I$02FF
        RST	38H
        LD	DE,I.31FF
        RST	38H
        OR	B
        LD	A,E
        RST	38H
        SUB	D
        RST	38H
        SUB	C
        RST	38H
        ADD	A,C
        RST	38H
        LD	C,C
        RST	38H
        EX	AF,AF'
        RST	38H
        JR	NC,J$7EBC
J$7EBC	EQU	$-1
        JR	NZ,J$7EBE
J$7EBE	EQU	$-1
        SBC	A,C
        NOP
        RST	38H
        NOP
        RST	38H
        NOP
        RST	38H
        NOP
        RST	38H
        NOP
        RST	38H
        NOP
        RST	38H
        NOP
        RST	38H
        NOP
        RST	38H
        RST	38H
        NOP
        RST	38H
        NOP
        RST	38H
        NOP
        RST	38H
        NOP
        DEFB	0FDH		; << Illegal Op Code Byte >>

        NOP
        RST	38H
        NOP
        RST	38H
        NOP
        RST	38H
        NOP
        JR	NZ,J.7EE1
J.7EE1	EQU	$-1
        ADC	A,C
        RST	38H
        JR	NZ,J.7EE1
        ADD	HL,DE
        DEFB	0FDH		; << Illegal Op Code Byte >>

        XOR	C
J$7EE9:	RST	38H
        JR	Z,J$7EE9
        LD	BC,I.31FF
        RST	38H
        RST	38H
        LD	BC,I$61FF
        RST	38H
        EX	AF,AF'
        RST	38H
        SBC	A,C
        RST	38H
        NOP
        RST	38H
        SUB	B
        RST	38H
        LD	BC,I.01FF
        NOP
        RST	38H
        NOP
        RST	38H
        NOP
        RST	38H
        DJNZ	J$7F07
J$7F07	EQU	$-1
        NOP
        RST	38H
        NOP
        RST	38H
        NOP
        DEFB	0FDH		; << Illegal Op Code Byte >>

        NOP
        DEFB	0FDH		; << Illegal Op Code Byte >>

        RST	38H
        NOP
        RST	38H
        NOP
        RST	38H
        NOP
        RST	38H
        NOP
        RST	38H
        NOP
        RST	38H
        NOP
        DEFB	0FDH		; << Illegal Op Code Byte >>

J$7F1D:	DJNZ	J$7F1E
J$7F1E	EQU	$-1
        DEFB	0,0
        RST	38H
        NOP
        DEFB	0FDH		; << Illegal Op Code Byte >>

J$7F24:	DJNZ	J.7F25
J.7F25	EQU	$-1
        NOP
        DEFB	0FDH		; << Illegal Op Code Byte >>

        LD	BC,I.10FF
        RST	38H
        DJNZ	J.7F25
        NOP
        RST	38H
        RST	38H
        LD	BC,I.01FF
        RST	38H
        NOP
        RST	38H
        NOP
        LD	A,A
        NOP
        RST	38H
        LD	DE,I.00FF
        RST	38H
        DEFB	0,0
        RST	38H
        NOP
        RST	38H
        NOP
        RST	38H
        NOP
        RST	38H
        NOP
        DEFB	0FDH		; << Illegal Op Code Byte >>

        NOP
        RST	38H
        NOP
        RST	38H
        NOP
        RST	38H
        RST	38H
        NOP
        RST	38H
        DJNZ	J$7F54
J$7F54	EQU	$-1
        NOP
        RST	38H
        NOP
        RST	38H
        NOP
        RST	38H
        NOP
        RST	38H
        NOP
        RST	38H
        NOP
        LD	B,B
        RST	38H
        LD	DE,I$007D
        DEFB	0FDH		; << Illegal Op Code Byte >>

        NOP
        RST	38H
        NOP
        RST	30H
        LD	DE,I.00FF
        RST	38H
        LD	DE,I$7DFD
        NOP
        RST	38H
        NOP
        RST	38H
        NOP
        RST	38H
        NOP
        RST	38H
        LD	DE,I.01FF
        RST	38H
        DJNZ	J$7F7E
J$7F7E	EQU	$-1
        DEFB	0,0
        RST	38H
        NOP
        DEFB	0FDH		; << Illegal Op Code Byte >>

        NOP
        RST	38H
        NOP
        RST	38H
        NOP
        RST	38H
        NOP
        RST	38H
        ADD	A,B
        RST	38H
        NOP
        RST	38H
        RST	38H
        NOP
        RST	38H
        DJNZ	J$7F94
J$7F94	EQU	$-1
        NOP
        RST	38H
        DJNZ	J$7F98
J$7F98	EQU	$-1
        NOP
        RST	38H
        NOP
        RST	38H
        NOP
        RST	38H
        DEFB	0,0
        RST	38H
        DJNZ	J$7FA3
J$7FA3	EQU	$-1
        DJNZ	J$7FA5
J$7FA5	EQU	$-1
        LD	DE,I.00FF
        RST	38H
        LD	D,B
        RST	38H
        NOP
        RST	38H
        SUB	L
        RST	38H
        RST	38H
        NOP
        RST	38H
        DJNZ	J$7FB4
J$7FB4	EQU	$-1
        NOP
        RST	38H
        SUB	B
        RST	38H
        NOP
        RST	38H
        SUB	B
        RST	38H
        DJNZ	J$7FBE
J$7FBE	EQU	$-1
        LD	DE,I.FF00
        NOP
        RST	38H
        NOP
        RST	38H
        NOP
        RST	38H
        NOP
        RST	38H
        NOP
        RST	38H
        NOP
        RST	38H
        NOP
        RST	38H
        DEFB	0FDH		; << Illegal Op Code Byte >>

        NOP
        RST	38H
        NOP
        RST	38H
        NOP
        RST	38H
        NOP
        RST	38H
        NOP
        RST	38H
        NOP
        RST	38H
        NOP
        RST	38H
        NOP
        DJNZ	J$7FE1
J$7FE1	EQU	$-1
        ADD	HL,BC
        LD	A,C
        DJNZ	J$7FE5
J$7FE5	EQU	$-1
        ADD	A,B
        RST	38H
        DJNZ	J$7FE9
J$7FE9	EQU	$-1
        LD	DE,I$91FF
        LD	SP,HL
        EX	AF,AF'
        RST	38H
        RST	38H
        DJNZ	J$7FF2
J$7FF2	EQU	$-1
        EX	AF,AF'
        RST	38H
        DJNZ	J$7FF6
J$7FF6	EQU	$-1
        NOP
D.7FF8:	JR	NZ,J$800F
D.7FF9	EQU	$-1
D.7FFA:	RLCA
D.7FFB:	RST	38H
D.7FFC:	RST	38H
D.7FFD:	RST	38H
        RST	38H
I.7FFF:	RST	38H
        END
J$800F
D.7FF9	EQU	$-1
