  
   SVI738 -> Source re-created by Z80DIS 2.2
      Z80DIS was written by Kenneth Gielow
                            Palo Alto, CA


C.0000	EQU	0000H	 -C--I
I.0001	EQU	0001H	 ----I
I.0008	EQU	0008H	 ----I
I$0012	EQU	0012H	 ----I
I$001E	EQU	001EH	 ----I
C.0024	EQU	0024H	 -C---
C$0038	EQU	0038H	 -C---
J.004A	EQU	004AH	 J----
I$0056	EQU	0056H	 ----I
J$005E	EQU	005EH	 J----
J.0064	EQU	0064H	 J----
J$006A	EQU	006AH	 J----
I$0070	EQU	0070H	 ----I
J$00A2	EQU	00A2H	 J----
J$00A5	EQU	00A5H	 J----
J$00A6	EQU	00A6H	 J----
J$00B3	EQU	00B3H	 J----
D$00B6	EQU	00B6H	 --S--
J$00B7	EQU	00B7H	 J----
J$00B9	EQU	00B9H	 J----
C$00C2	EQU	00C2H	 -C---
I$00C3	EQU	00C3H	 ----I
D$00CA	EQU	00CAH	 --S--
C$00D6	EQU	00D6H	 -C---
C$00FF	EQU	00FFH	 -C---
J.0100	EQU	0100H	 J---I
C.0112	EQU	0112H	 -C---
C$0113	EQU	0113H	 -C---
I$0116	EQU	0116H	 ----I
C.0119	EQU	0119H	 -C--I
I$0120	EQU	0120H	 ----I
C.0126	EQU	0126H	 -C---
C$012D	EQU	012DH	 -C---
I$0134	EQU	0134H	 ----I
I.0200	EQU	0200H	 ----I
I$0206	EQU	0206H	 ----I
J$022E	EQU	022EH	 J----
I$1200	EQU	1200H	 ----I
I$17FF	EQU	17FFH	 ----I
I$1964	EQU	1964H	 ----I
I$1BFF	EQU	1BFFH	 ----I
D.2D20	EQU	2D20H	 --S-I
I$3F00	EQU	3F00H	 ----I
J$4022	EQU	4022H	 J----

D.7FB8	EQU	7FB8H
D.7FB9	EQU	D.7FB8+1
D.7FBA	EQU	D.7FB8+2
D.7FBB	EQU	D.7FB8+3
D.7FBC	EQU	7FBCH

; b0	select drive 0
; b1	select drive 1
; b2	side select
; b3	motor on/off


D.BFB8	EQU	0BFB8H
D.BFBA	EQU	D.BFB8+2
D.BFBB	EQU	D.BFB8+3
D.BFBC	EQU	0BFBCH

D$C059	EQU	0C059H	 ---L-
J$C063	EQU	0C063H	 J----
J$C06A	EQU	0C06AH	 J----
I$C079	EQU	0C079H	 ----I
I.C09F	EQU	0C09FH	 ----I
D$C0AD	EQU	0C0ADH	 --S--
D.C0C4	EQU	0C0C4H	 --SL-
J$F300	EQU	0F300H	 J----
D.F342	EQU	0F342H	 ---L-
D.F343	EQU	0F343H	 ---L-
D.F34D	EQU	0F34DH	 --SL-
C.F368	EQU	0F368H	 -C---
C.F36E	EQU	0F36EH	 -C---
C.F37D	EQU	0F37DH	 -C---
I$F51F	EQU	0F51FH	 ----I
C.FFCF	EQU	0FFCFH	 -C---
C.FFD4	EQU	0FFD4H	 -C---



MYSIZE	EQU	8

; +0	motor off counter (0 = motor off, 255 = motor stays on)
; +1	disk change counter drive 0
; +2	disk change counter drive 1
; +3	last drive
; +4	current track drive 0
; +5	current track drive 1
; +7	number of physical drives


; 3.5" single sided, 80 tracks, 9 sectors, 360 Kb

I7405:	DEFB	0F8H
        DEFW	512
        DEFB	0FH
        DEFB	04H
        DEFB	01H
        DEFB	02H
        DEFW	1
        DEFB	2
        DEFB	112
        DEFW	12
        DEFW	355
        DEFB	2
        DEFW	5

; 3.5" double sided, 80 tracks, 9 sectors, 720 Kb

I7417:	DEFB	0F9H
        DEFW	512
        DEFB	0FH
        DEFB	04H
        DEFB	01H
        DEFB	02H
        DEFW	1
        DEFB	2
        DEFB	112
        DEFW	14
        DEFW	715
        DEFB	3
        DEFW	7

; 5.25" single sided, 40 tracks, 9 sectors, 180 Kb

I7429:	DEFB	0FCH
        DEFW	512
        DEFB	0FH
        DEFB	04H
        DEFB	00H
        DEFB	01H
        DEFW	1
        DEFB	2
        DEFB	64
        DEFW	9
        DEFW	352
        DEFB	2
        DEFW	5

; 5.25" double sided, 40 tracks, 9 sectors, 360 Kb

I743B:	DEFB	0FDH
        DEFW	512
        DEFB	0FH
        DEFB	04H
        DEFB	01H
        DEFB	02H
        DEFW	1
        DEFB	2
        DEFB	112
        DEFW	12
        DEFW	355
        DEFB	2
        DEFW	5

; 5.25" double sided, 40 tracks, 8 sectors, 320 Kb

I744D:	DEFB	0FFH
        DEFW	512
        DEFB	0FH
        DEFB	04H
        DEFB	01H
        DEFB	02H
        DEFW	1
        DEFB	2
        DEFB	112
        DEFW	10
        DEFW	316
        DEFB	1
        DEFW	3

DEFDPB	EQU	I7429-1

          Subroutine DSKIO
             Inputs  ________________________
             Outputs ________________________

C745F:	EI	
        PUSH	AF
        JP	NC,J7557
        CALL	C7490
J7467:	POP	DE
        PUSH	AF
        LD	C,2*60		; disk unchanged for 2 seconds
        JR	NC,J746F
        LD	C,0		; disk not unchanged
J746F:	LD	A,0D0H
        LD	(D.7FB8),A
        EX	(SP),HL
        EX	(SP),HL
        EX	(SP),HL
        EX	(SP),HL
        LD	A,(D.7FBB)
        LD	A,(D.7FB8)
        LD	(IX+0),4*60	; keep motor on for 4 seconds
        LD	A,D
        AND	A
        JR	NZ,J748B
        LD	(IX+1),C
        POP	AF
        RET	

J748B:	LD	(IX+2),C
        POP	AF
        RET	

          Subroutine DSKIO read
             Inputs  ________________________
             Outputs ________________________

C7490:	CALL	C7616		; setup for disk i/o
        RET	C
        LD	A,H
        AND	A
        JP	M,J74C0
        CALL	C7CDE
        CALL	C7D55
        RET	C
        INC	B
        DEC	B
        RET	Z
        LD	A,H
        AND	A
        JP	M,J74C0
        PUSH	HL
        PUSH	DE
        PUSH	BC
        LD	DE,(D.F34D)
        PUSH	DE
        LD	BC,512
        CALL	XFER
        POP	HL
        POP	BC
        POP	DE
        CALL	C74CC
        POP	HL
        JP	J74C3

J74C0:	CALL	C74CC
J74C3:	RET	C
        DEC	B
        RET	Z
        CALL	C76C9
        JP	J74C0

          Subroutine __________________________
             Inputs  ________________________
             Outputs ________________________

C74CC:	LD	E,15H
J74CE:	CALL	C7719		; wait for FDC
        LD	A,0A0H
        BIT	6,D
        JR	Z,J74DF
        OR	02H
        BIT	2,D
        JR	Z,J74DF
        OR	08H
J74DF:	PUSH	HL
        PUSH	DE
        PUSH	BC
        LD	DE,I74FF
        PUSH	DE
        CALL	C.FFCF
        DI	
        LD	(D.7FB8),A
        LD	BC,D.7FBC
        LD	DE,D.7FBB
J74F3:	LD	A,(BC)
        ADD	A,A
        RET	C
        JP	M,J74F3
        LD	A,(HL)
        LD	(DE),A
        INC	HL
        JP	J74F3

I74FF:	POP	BC
        POP	DE
        POP	HL
        EI	
        CALL	C.FFD4
        LD	A,(D.7FB8)
        AND	0FCH
        RET	Z
        JP	M,J7550
        BIT	6,A
        JR	NZ,J752F
        PUSH	AF
        CALL	C7706
        POP	AF
        DEC	E
        JR	NZ,J74CE
        SCF	
        LD	E,A
        BIT	5,E
        LD	A,0AH
        RET	NZ
        BIT	4,E
        LD	A,08H
        RET	NZ
        BIT	3,E
        LD	A,04H
        RET	NZ
        LD	A,0CH
        RET	

J752F:	LD	A,0D0H
        LD	(D.7FB8),A
        EX	(SP),HL
        EX	(SP),HL
        LD	A,80H
        LD	(D.7FB8),A
        EX	(SP),HL
        EX	(SP),HL
        LD	HL,D.7FBC
        LD	DE,0
J7543:	LD	A,(HL)
        ADD	A,A
        JR	C,J7554
        JP	P,J7554
        DEC	DE
        LD	A,E
        OR	D
        JP	NZ,J7543
J7550:	LD	A,02H
        SCF	
        RET	


J7554:	XOR	A
        SCF	
        RET	

J7557:	CALL	C755D
        JP	J7467

          Subroutine DSKIO write
             Inputs  ________________________
             Outputs ________________________

C755D:	CALL	C7616		; setup for disk i/o
        RET	C
        LD	A,H
        AND	A
        JP	M,J7592

        CALL	C7CCA

        CALL	C7D55

        RET	C

        INC	B
        DEC	B
        RET	Z

        LD	A,H
        AND	A
        JP	M,J7592

        PUSH	HL
        LD	HL,(D.F34D)
        CALL	C759E

        POP	HL
        RET	C

        PUSH	HL
        PUSH	DE
        PUSH	BC
        EX	DE,HL
        LD	HL,(D.F34D)
        LD	BC,I.0200
        CALL	C.F36E

        POP	BC
        POP	DE
        POP	HL
        AND	A
        JP	J7596


J7592:	CALL	C759E

        RET	C

J7596:	DEC	B
        RET	Z

        CALL	C76C9

        JP	J7592



          Subroutine __________________________
             Inputs  ________________________
             Outputs ________________________

C759E:	LD	E,15H
J75A0:	CALL	C7719		; wait for FDC
        LD	A,80H
        BIT	6,D
        JR	Z,J75B1

        OR	02H
        BIT	2,D
        JR	Z,J75B1

        OR	08H
J75B1:	PUSH	HL
        PUSH	DE
        PUSH	BC
        LD	BC,D.7FBC
        LD	DE,I75EB
        PUSH	DE
        CALL	C.FFCF
        DI	
        LD	(D.7FB8),A
        LD	DE,0
J75C5:	LD	A,(BC)
        ADD	A,A
        JP	P,J75D9

        RET	C

        DEC	E
        JP	NZ,J75C5

        DEC	D
        JP	NZ,J75C5

        POP	BC
        POP	BC
        POP	DE
        POP	HL
        JR	J7612


J75D9:	LD	DE,D.7FBB
        JP	J75E5


J75DF:	LD	A,(BC)
        ADD	A,A
        RET	C

        JP	M,J75DF

J75E5:	LD	A,(DE)
        LD	(HL),A
        INC	HL
        JP	J75DF


I75EB:	POP	BC
        POP	DE
        POP	HL
        EI	
        CALL	C.FFD4

        LD	A,(D.7FB8)
        AND	9CH
        RET	Z

        JP	M,J7612

        PUSH	AF
        CALL	C7706

        POP	AF
        DEC	E
        JR	NZ,J75A0

        SCF	
        LD	E,A
        BIT	4,E
        LD	A,08H
        RET	NZ

        BIT	3,E
        LD	A,04H
        RET	NZ

        LD	A,0CH
        RET	


J7612:	LD	A,02H
        SCF	
        RET	



          Subroutine setup for disk i/o
             Inputs  ________________________
             Outputs ________________________

C7616:	PUSH	AF
        PUSH	BC
        PUSH	HL
        CALL	GETWRK
        POP	HL
        POP	BC
        POP	AF
        CP	2
        JR	C,J7627
J7623:	LD	A,0CH
        SCF	
        RET	

J7627:	PUSH	AF
        LD	A,C
        CP	0F8H
        JR	NC,J7630
        POP	AF
        JR	J7623

J7630:	EX	(SP),HL
        PUSH	HL
        PUSH	BC
        CALL	C7719		; wait for FDC
        BIT	1,C
        LD	C,E
        LD	B,D
        LD	DE,8
        JR	NZ,J7640
        INC	DE
J7640:	CALL	DIV16
        LD	A,L
        INC	A
        LD	(D.7FBA),A	; record
        LD	L,C
        POP	BC
        POP	AF
        LD	H,A
        LD	A,(IX+7)
        DEC	A		; 1 physical drive ?
        JR	Z,J7653		; yep, use drive 0
        LD	A,H
J7653:	ADD	A,09H		; motor on, side 0, drive 0 or drive 1
        BIT	0,C		; double sided media ?
        JR	Z,J765F
        SRL	L
        JR	NC,J765F
        OR	04H		; side 1
J765F:	LD	D,A
        LD	A,C
        RRCA	
        RRCA	
        AND	0C0H		; media bits
        OR	D
        LD	D,A
        DI	
        LD	(D.7FBC),A
        LD	A,(IX+0)
        AND	A		; motor already off ?
        LD	(IX+0),0FFH	; disable motor off timer
        EI	
        JR	NZ,J7680	; motor still on, skip spinup
        PUSH	HL
        LD	HL,0
J767A:	DEC	HL
        LD	A,L
        OR	H
        JR	NZ,J767A
        POP	HL
J7680:	LD	C,L
        LD	A,(IX+7)
        DEC	A
        JR	Z,J76AC
        LD	A,(IX+3)
        CP	H
        JR	Z,J76C0
        XOR	01H
        LD	(IX+3),A
        LD	A,(D.7FB9)
        JR	Z,J769F
        LD	(IX+4),A
        LD	A,(IX+5)
        JR	J76A5

J769F:	LD	(IX+5),A
        LD	A,(IX+4)
J76A5:	LD	(D.7FB9),A
        EX	(SP),HL
        EX	(SP),HL
        JR	J76C3


J76AC:	LD	A,H
        CP	(IX+6)
        LD	(IX+6),A
        JR	Z,J76C0
        PUSH	IX
        PUSH	DE
        PUSH	BC
        CALL	PROMPT
        POP	BC
        POP	DE
        POP	IX
J76C0:	LD	A,(D.7FB9)
J76C3:	CP	C
        CALL	NZ,C770C	; seek to track
        POP	HL
        RET	



          Subroutine __________________________
             Inputs  ________________________
             Outputs ________________________

C76C9:	CALL	C7719		; wait for FDC
        INC	H
        INC	H
        LD	A,(D.7FBA)
        INC	A
        LD	(D.7FBA),A
        BIT	7,D
        JR	NZ,J76DC

        CP	0AH
        RET	C

J76DC:	CP	09H
        RET	C

        LD	A,01H
        LD	(D.7FBA),A
        BIT	6,D
        JR	Z,J76F3
        BIT	2,D		; side 1 ?
        JR	NZ,J76F3
        SET	2,D		; side 1
        LD	A,D
        LD	(D.7FBC),A
        RET	


J76F3:	RES	2,D		; side 0
        LD	A,D
        LD	(D.7FBC),A
        INC	C
        CALL	C7719		; wait for FDC
        LD	A,55H
        LD	(D.7FB8),A
        EX	(SP),HL
        EX	(SP),HL
        JR	C7719		; wait for FDC

          Subroutine __________________________
             Inputs  ________________________
             Outputs ________________________

C7706:	BIT	0,E
        RET	NZ
        CALL	C7720		; seek to track 0

          Subroutine seek to track
             Inputs  ________________________
             Outputs ________________________

C770C:	LD	A,C
        LD	(D.7FBB),A
        EX	(SP),HL
        EX	(SP),HL
        LD	A,15H
J7714:	LD	(D.7FB8),A
        EX	(SP),HL
        EX	(SP),HL

          Subroutine wait for FDC
             Inputs  ________________________
             Outputs ________________________

C7719:	LD	A,(D.7FB8)
        RRA	
        JR	C,C7719
        RET	



          Subroutine seek to track 0
             Inputs  ________________________
             Outputs ________________________

C7720:	CALL	C7719		; wait for FDC
        LD	A,01H
        JR	J7714

          Subroutine INIHRD
             Inputs  ________________________
             Outputs ________________________

INIHRD:
C7727:	LD	A,0D0H
        LD	(D.7FB8),A
        EX	(SP),HL
        EX	(SP),HL
        LD	A,01H		; motor off, side 0, select drive 0
        CALL	C773D
        LD	A,02H		; motor off, side 1, select drive 1
        CALL	C773D

          Subroutine MTOFF
             Inputs  ________________________
             Outputs ________________________

MTOFF:
?7738:	XOR	A		; motor off, side 0, unselect drive
        LD	(D.7FBC),A
        RET	

          Subroutine initialize drive
             Inputs  ________________________
             Outputs ________________________

C773D:	LD	(D.7FBC),A
        CALL	C7719		; wait for FDC
        LD	A,01H
        LD	(D.7FB8),A
        EX	(SP),HL
        EX	(SP),HL
        LD	HL,0
J774D:	LD	A,(D.7FB8)
        RRA	
        RET	NC
        DEC	HL
        LD	A,L
        OR	H
        JR	NZ,J774D
        RET	

          Subroutine DRIVES
             Inputs  ________________________
             Outputs ________________________

DRIVES:
?7758:	PUSH	BC
        PUSH	AF
        CALL	GETWRK
        LD	A,02H		; motor off, side 0, drive 1
        LD	(D.7FBC),A
        CALL	C7719		; wait for FDC
        LD	A,01H
        LD	(D.7FB8),A
        EX	(SP),HL
        EX	(SP),HL
        LD	HL,0
J776F:	LD	A,(D.7FB8)
        RRA	
        JR	NC,J777C
        DEC	HL
        LD	A,L
        OR	H
        JR	NZ,J776F
        INC	L		; 1 drive
        DEFB	0CAH
J777C:	LD	L,2		; 2 drives
        LD	(IX+7),L	; number of physical drives
        XOR	A		; motor off, side 0, unselect drive
        LD	(D.7FBC),A
        POP	AF
        JR	Z,J778A
        LD	L,2
J778A:	POP	BC
        RET	

          Subroutine INIENV
             Inputs  ________________________
             Outputs ________________________

INIENV:
?778C:	CALL	GETWRK
        XOR	A
        LD	B,7
J7792:	LD	(HL),A
        INC	HL
        DJNZ	J7792
        LD	HL,I779C
        JP	SETINT

I779C:	PUSH	AF
        CALL	GETWRK
        LD	A,(HL)
        AND	A
        JR	Z,J77AF
        CP	0FFH
        JR	Z,J77AF
        DEC	A
        LD	(HL),A
        JR	NZ,J77AF
        LD	(D.7FBC),A	; motor off, side 0, unselect drive
J77AF:	INC	HL
        LD	A,(HL)
        AND	A
        JR	Z,J77B5
        DEC	(HL)
J77B5:	INC	HL
        LD	A,(HL)
        AND	A
        JR	Z,J77BB
        DEC	(HL)
J77BB:	POP	AF
        JP	PRVINT

          Subroutine DSKCHG
             Inputs  ________________________
             Outputs ________________________

?77BF:	EI	
        PUSH	HL
        PUSH	BC
        PUSH	AF
        CALL	GETWRK
        POP	AF
        POP	BC
        POP	HL
        AND	A
        LD	B,(IX+2)
        JR	NZ,J77D2
        LD	B,(IX+1)
J77D2:	INC	B
        DEC	B
        LD	B,1		; disk unchanged
        RET	NZ
        PUSH	BC
        PUSH	HL
        LD	DE,I.0001
        LD	HL,(D.F34D)
        CALL	C745F		; read sector 1
        JR	C,J77FB		; error, quit
        LD	HL,(D.F34D)
        LD	B,(HL)		; mediadescriptor
        POP	HL
        PUSH	BC
        CALL	C77FE		; GETDPB
        LD	A,12
        JR	C,J77FB	 	; invalid mediadescriptor, quit
        POP	AF
        POP	BC
        CP	C
        SCF	
        CCF	
        LD	B,0FFH		; disk changed
        RET	NZ
        INC	B		; disk change unknown
        RET	

J77FB:	POP	DE
        POP	DE
        RET	

          Subroutine GETDPB
             Inputs  ________________________
             Outputs ________________________

C77FE:	EI	
        EX	DE,HL
        INC	DE
        LD	A,B
        CP	0F8H
        LD	HL,I7405
        JR	Z,J7825
        CP	0F9H
        LD	HL,I7417
        JR	Z,J7825
        CP	0FCH
        LD	HL,I7429
        JR	Z,J7825
        CP	0FDH
        LD	HL,I743B
        JR	Z,J7825
        CP	0FFH
        LD	HL,I744D
        JR	NZ,J782C
J7825:	LD	BC,18
        LDIR	
        JR	J782D

J782C:	SCF	
J782D:	RET	

          Subroutine CHOICE
             Inputs  ________________________
             Outputs ________________________

?782E:	LD	HL,I7832
        RET	


I7832:	DEC	C
        LD	A,(BC)
        LD	SP,D.2D20
        JR	NZ,J788C

        LD	L,C
        LD	L,(HL)
        LD	H,A
        LD	L,H
        LD	H,L
        JR	NZ,J7893

        LD	L,C
        LD	H,H
        LD	H,L
        INC	L
        JR	C,J7876

        JR	NZ,J789C

        LD	(HL),D
        LD	H,C
        LD	H,E
        LD	L,E
        LD	(HL),E
        DEC	C
        LD	A,(BC)
        LD	(D.2D20),A
        JR	NZ,J7898

        LD	L,A
        LD	(HL),L
        LD	H,D
        LD	L,H
        LD	H,L
        JR	NZ,J78AE

        LD	L,C
        LD	H,H
        LD	H,L
        INC	L
        JR	C,J7891

        JR	NZ,J78B7

        LD	(HL),D
        LD	H,C
        LD	H,E
        LD	L,E
        LD	(HL),E
        DEC	C
        LD	A,(BC)
        DEC	C
        LD	A,(BC)
        NOP

          Subroutine OEMSTA
             Inputs  ________________________
             Outputs ________________________

OEMSTA:
?786D:	SCF	
        RET	

          Subroutine DSKFMT
             Inputs  ________________________
             Outputs ________________________

DSKFMT:
?786F:	CALL	C7890
        PUSH	AF
        CALL	C7727		; INIHRD
J7876:	POP	AF
        EI	
        RET	



          Subroutine __________________________
             Inputs  ________________________
             Outputs ________________________

C7879:	AND	0FCH
        LD	B,A
        LD	A,(IX+7)
        DEC	A
        JR	Z,J788C
        LD	A,(IX+6)
        OR	A
        JR	Z,J788C
        LD	A,02H
        JR	J788E
J788C:	LD	A,01H
J788E:	OR	B
        RET	

          Subroutine __________________________
             Inputs  ________________________
             Outputs ________________________

C7890:	PUSH	AF
J7891:	PUSH	BC
        PUSH	DE
J7893:	PUSH	HL
        CALL	GETWRK
        POP	IY		; workarea in IY
        LD	A,(IX+7)
        LD	(IY+7),A
        PUSH	IY
        POP	HL
        POP	DE
        POP	BC
        POP	AF
        CP	3
        JR	NC,J790F	; invalid choice
        DI	
        EX	AF,AF'
        LD	A,D
        CP	02H
J78AE:	JR	NC,J790F	; invalid drive
        PUSH	HL
        LD	HL,01964H
        SBC	HL,BC
        POP	HL
J78B7:	JR	NC,J7913	; workarea to small
        PUSH	HL
        LD	A,0D0H
        LD	(D.7FB8),A
        EX	(SP),HL
        EX	(SP),HL
        LD	A,09H		; motor on, side 0, drive 1
        POP	IX
        LD	(IX+6),D
        CALL	C7879
        PUSH	IX
        LD	(D.7FBC),A	;
        CALL	C7719		; wait for FDC
        LD	A,01H
        LD	(D.7FB8),A
        EX	(SP),HL
        EX	(SP),HL
        LD	HL,0
J78DD:	LD	A,(D.7FB8)
        RRA	
        JR	NC,J78EA

        DEC	HL
        LD	A,H
        OR	L
        JR	NZ,J78DD

        JR	J790A


J78EA:	LD	HL,0
J78ED:	LD	A,(D.7FB8)
        AND	02H
        JR	Z,J78FB

        DEC	HL
        LD	A,H
        OR	L
        JR	NZ,J78ED

        JR	J790A


J78FB:	LD	HL,0
J78FE:	LD	A,(D.7FB8)
        AND	02H
        JR	NZ,J7917

        DEC	HL
        LD	A,H
        OR	L
        JR	NZ,J78FE

J790A:	SCF	
        POP	HL
        LD	A,02H
        RET	


J790F:	SCF	
        LD	A,0CH
        RET	


J7913:	SCF	
        LD	A,0EH
        RET	


J7917:	POP	HL
        PUSH	IX
        PUSH	HL
        EX	(SP),HL
        EX	(SP),IX
        EX	(SP),HL
        POP	HL
        LD	BC,I.0008
        ADD	HL,BC
        EX	AF,AF'
        LD	(IX+4),A
        DEC	A
        LD	A,0F8H
        JR	Z,J792F

        LD	A,0F9H
J792F:	LD	(IX+5),A
        XOR	A
        LD	(IX+0),A
        DEC	A
        LD	(IX+3),A
        LD	(IX+1),A
J793D:	INC	(IX+1)
J7940:	INC	(IX+3)
        CALL	C7A3B

        CALL	C7AB8

        CALL	C7B01

        JR	NC,J795B

        LD	A,15H
        CP	(IX+3)
        JR	NZ,J7940

        LD	A,10H
        SCF	
        POP	IX
        RET	


J795B:	LD	A,(IX+4)
        DEC	A
        JR	Z,J798F

        LD	A,0FFH
        LD	(IX+3),A
        LD	A,0DH		; motor on, side 1
        CALL	C7879
        LD	(D.7FBC),A
        INC	(IX+0)
J7971:	INC	(IX+3)
        CALL	C7A3B

        CALL	C7AB8

        CALL	C7B01

        JR	NC,J798C

        LD	A,15H
        CP	(IX+3)
        JR	NZ,J7971

        LD	A,10H
        SCF	
        POP	IX
        RET	


J798C:	DEC	(IX+0)
J798F:	LD	A,4FH
        CP	(IX+1)
        JR	Z,J79A8
        CALL	C7A16
        LD	A,09H
        CALL	C7879
        LD	(D.7FBC),A
        LD	A,0FFH
        LD	(IX+3),A
        JR	J793D


J79A8:	CALL	C7720		; seek to track 0
        PUSH	HL
        EX	DE,HL
        POP	HL
        PUSH	HL
        INC	DE
        XOR	A
        LD	(HL),A
        LD	BC,01BFFH
        LD	A,(IX+4)
        DEC	A
        JR	NZ,J79BE
        LD	BC,017FFH
J79BE:	LDIR	
        POP	HL
        PUSH	HL
        EX	DE,HL
        LD	HL,I7C05
        LD	BC,000C3H
        LDIR			; initialize bootsector
        POP	HL
        PUSH	HL
        LD	BC,I.0200
        ADD	HL,BC		; first FAT at sector 1
        LD	A,(IX+5)
        LD	(HL),A
        INC	HL
        LD	A,0FFH
        LD	(HL),A
        INC	HL
        LD	(HL),A
        DEC	HL
        DEC	HL		; initialize FAT entries 0 and 1
        LD	B,04H
        LD	A,(IX+4)
        DEC	A
        JR	Z,J79E7		; single sided, second FAT at sector 3
        LD	B,06H		; double sided, second FAT at sector 4
J79E7:	ADD	HL,BC
        LD	A,(IX+5)
        LD	(HL),A
        INC	HL
        LD	A,0FFH
        LD	(HL),A
        INC	HL
        LD	(HL),A		; initialize FAT entries 0 and 1
        LD	B,0CH
        LD	A,(IX+4)
        DEC	A
        JR	Z,J7A07		; single sided, first data sector = 12
        POP	HL
        PUSH	HL
        EX	DE,HL
        LD	HL,I7BE7
        LD	BC,0001EH
        LDIR			; adjust BPB for double sided
        LD	B,0EH		; double sided, first data sector = 14
J7A07:	LD	C,(IX+5)
        XOR	A
        LD	DE,0
        POP	HL
        SCF	
        CALL	C7B67		; write sectors
        POP	IX
        RET	



          Subroutine __________________________
             Inputs  ________________________
             Outputs ________________________

C7A16:	LD	A,55H
        PUSH	AF
        CALL	C7719		; wait for FDC
        POP	AF
        LD	(D.7FB8),A
        CALL	C7A2D
J7A23:	LD	A,(D.7FBC)
        ADD	A,A
        JR	NC,J7A23
        CALL	C7719		; wait for FDC
        RET	



          Subroutine __________________________
             Inputs  ________________________
             Outputs ________________________

C7A2D:	EX	(SP),HL
        EX	(SP),HL
        EX	(SP),HL
        EX	(SP),HL
I7A31:	RET	


?7A32:	LD	BC,00206H
        RLCA	
        INC	BC
        EX	AF,AF'
        INC	B
        ADD	HL,BC
        DEC	B

          Subroutine __________________________
             Inputs  ________________________
             Outputs ________________________

C7A3B:	LD	C,01H
        LD	D,H
        LD	E,L
        LD	A,4EH
        LD	B,32H
        CALL	C7AB2

J7A46:	XOR	A
        LD	B,0CH
        CALL	C7AB2

        LD	A,0F5H
        LD	B,03H
        CALL	C7AB2

        LD	A,0FEH
        LD	(DE),A
        INC	DE
        LD	A,(IX+1)
        LD	(DE),A
        INC	DE
        LD	A,(IX+0)
        LD	(DE),A
        INC	DE
        PUSH	HL
        LD	HL,I7A31
        LD	B,00H
        ADD	HL,BC
        LD	A,(HL)
        POP	HL
        LD	(DE),A
        INC	DE
        LD	A,02H
        LD	(DE),A
        INC	DE
        LD	A,0F7H
        LD	(DE),A
        INC	DE
        LD	A,4EH
        LD	B,16H
        CALL	C7AB2

        XOR	A
        LD	B,0CH
        CALL	C7AB2

        LD	A,0F5H
        LD	B,03H
        CALL	C7AB2

        LD	A,0FBH
        LD	(DE),A
        INC	DE
        LD	A,0E5H
        LD	B,00H
        CALL	C7AB2

        CALL	C7AB2

        LD	A,0F7H
        LD	(DE),A
        INC	DE
        LD	A,4EH
        LD	B,20H
        CALL	C7AB2

        INC	C
        LD	A,C
        CP	0AH
        JR	NZ,J7A46

        LD	A,4EH
        LD	B,00H
        CALL	C7AB2

        CALL	C7AB2

        RET	



          Subroutine __________________________
             Inputs  ________________________
             Outputs ________________________

C7AB2:	LD	(DE),A
        INC	DE
        DEC	B
        JR	NZ,C7AB2

        RET	



          Subroutine __________________________
             Inputs  ________________________
             Outputs ________________________

C7AB8:	PUSH	HL
        LD	DE,I7AD6
        PUSH	DE
        LD	BC,D.7FBC
        LD	DE,D.7FBB
        CALL	C7719		; wait for FDC
        LD	A,0F4H
        LD	(D.7FB8),A
J7ACB:	LD	A,(BC)
        ADD	A,A
        RET	C

        JP	M,J7ACB

        LD	A,(HL)
        LD	(DE),A
        INC	HL
        JR	J7ACB


I7AD6:	POP	HL
        LD	A,(D.7FB8)
        LD	E,A
        AND	0E4H
        RET	Z

        POP	BC
J7ADF:	SCF	
        POP	IX
        JP	P,J7AE8

        LD	A,02H
        RET	


J7AE8:	BIT	6,A
        JR	Z,J7AEF

        LD	A,00H
        RET	


J7AEF:	BIT	5,E
        LD	A,0AH
        RET	NZ

        BIT	4,E
        LD	A,08H
        RET	NZ

        BIT	3,E
        LD	A,04H
        RET	NZ

        LD	A,10H
        RET	



          Subroutine __________________________
             Inputs  ________________________
             Outputs ________________________

C7B01:	PUSH	HL
        XOR	A
J7B03:	PUSH	AF
        CALL	C7719		; wait for FDC
        POP	AF
        INC	A
        LD	(D.7FBA),A
        PUSH	AF
        CALL	C7719		; wait for FDC
        LD	DE,I7B2A
        PUSH	DE
        LD	A,80H
        LD	(D.7FB8),A
        LD	BC,D.7FBC
        LD	DE,D.7FBB
J7B1F:	LD	A,(BC)
        ADD	A,A
        RET	C

        JP	M,J7B1F

        LD	A,(DE)
        LD	(HL),A
        INC	HL
        JR	J7B1F


I7B2A:	LD	A,(D.7FB8)
        LD	E,A
        AND	0FCH
        JR	Z,J7B4D

        POP	AF
        POP	HL
        SCF	
        JP	P,J7B3B

        LD	A,02H
        RET	


J7B3B:	BIT	5,E
        LD	A,0AH
        RET	NZ

        BIT	4,E
        LD	A,08H
        RET	NZ

        BIT	3,E
        LD	A,04H
        RET	NZ

        LD	A,10H
        RET	


J7B4D:	POP	AF
        CP	09H
        JR	C,J7B03

        POP	HL
        PUSH	HL
        LD	BC,01200H
J7B57:	LD	A,0E5H
        CP	(HL)
        JR	NZ,J7B64

        INC	HL
        DEC	BC
        LD	A,B
        OR	C
        JR	NZ,J7B57

        POP	HL
        RET	


J7B64:	SCF	
        POP	HL
        RET	



          Subroutine __________________________
             Inputs  ________________________
             Outputs ________________________

C7B67:	AND	A
        CALL	C7B7C

        PUSH	AF
        LD	A,0D0H
        LD	(D.7FB8),A
        CALL	C7A2D

        LD	A,(D.7FBB)
        LD	A,(D.7FB8)
        POP	AF
        RET	



          Subroutine __________________________
             Inputs  ________________________
             Outputs ________________________

C7B7C:	LD	A,09H
        CALL	C7879

        LD	(D.7FBC),A
        XOR	A
        LD	(IX+2),A
        LD	B,09H
J7B8A:	PUSH	BC
        INC	(IX+2)
        CALL	C7719		; wait for FDC
        LD	A,(IX+2)
        LD	(D.7FBA),A
        CALL	C7719		; wait for FDC
        LD	A,0A0H
        LD	DE,I7BB5
        PUSH	DE
        LD	(D.7FB8),A
        LD	BC,D.7FBC
        LD	DE,D.7FBB
J7BA9:	LD	A,(BC)
        ADD	A,A
        RET	C

        JP	M,J7BA9

        LD	A,(HL)
        LD	(DE),A
        INC	HL
        JP	J7BA9


I7BB5:	LD	A,(D.7FB8)
        AND	0FCH
        POP	BC
        JP	NZ,J7ADF

        LD	A,(IX+2)
        CP	09H
        JR	Z,J7BCA

        DEC	B
        JR	NZ,J7B8A

        XOR	A
        RET	


J7BCA:	LD	A,(IX+4)
        DEC	A
        JR	NZ,J7BD7

        CALL	C7A16

        LD	B,03H
        JR	J7BE1


J7BD7:	LD	A,0DH
        CALL	C7879

        LD	(D.7FBC),A
        LD	B,05H
J7BE1:	XOR	A
        LD	(IX+2),A
        JR	J7B8A


I7BE7:	EX	DE,HL
        CP	90H
        LD	D,E
        LD	D,(HL)
        LD	C,C
        DEC	L
        SCF	
        INC	SP
        JR	C,J7C36

        NOP	
        LD	(BC),A
        LD	(BC),A
        LD	BC,I.0200
        LD	(HL),B
        NOP	
        AND	D
        DEC	B
        LD	SP,HL
        INC	BC
        NOP	
        ADD	HL,BC
        NOP	
        LD	(BC),A
        DEFB	0,0,0

I7C05:	EX	DE,HL
        CP	90H
        LD	D,E
        LD	D,(HL)
        LD	C,C
        DEC	L
        SCF	
        INC	SP
        JR	C,J7C63

        NOP	
        LD	(BC),A
        LD	(BC),A
        LD	BC,I.0200
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

        LD	(DC059),DE
        LD	(DC0C4),A
        LD	(HL),56H
        INC	HL
        LD	(HL),0C0H
J7C30:	LD	SP,I$F51F
        LD	DE,I.C09F
J7C36:	LD	C,0FH
        CALL	C.F37D

        INC	A
        JP	Z,J$C063

        LD	DE,J.0100
        LD	C,1AH
        CALL	C.F37D

        LD	HL,I.0001
        LD	(D$C0AD),HL
        LD	HL,I$3F00
        LD	DE,I.C09F
        LD	C,27H
        CALL	C.F37D

        JP	J.0100


?7C5B:	LD	E,B
        RET	NZ

        CALL	0

        LD	A,C
        AND	0FEH
J7C63:	CP	02H
        JP	NZ,J$C06A

        LD	A,(D.C0C4)
        AND	A
        JP	Z,J$4022

        LD	DE,I$C079
        LD	C,09H
        CALL	C.F37D

        LD	C,07H
        CALL	C.F37D

        JR	J7C30


?7C7E:	LD	B,D
        LD	L,A
        LD	L,A
        LD	(HL),H
        JR	NZ,J7CE9

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
        JR	NZ,J7CF2

        LD	L,(HL)
        LD	A,C
        JR	NZ,J7D00

        LD	H,L
        LD	A,C
        JR	NZ,J7CFF

        LD	L,A
        LD	(HL),D
        JR	NZ,J7D0F

        LD	H,L
        LD	(HL),H
        LD	(HL),D
        LD	A,C
        DEC	C
        LD	A,(BC)
        INC	H
        NOP	
        LD	C,L
        LD	D,E
        LD	E,B
        LD	B,H
        LD	C,A
        LD	D,E
        JR	NZ,J7CCD

        LD	D,E
        LD	E,C
        LD	D,E
        DEFB	0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0
        DEFB	0,0,0,0,0,0

          Subroutine __________________________
             Inputs  ________________________
             Outputs ________________________

C7CCA:	PUSH	HL
        PUSH	DE
        PUSH	BC
J7CCD:	LD	HL,I7D5B
        LD	DE,(D.F34D)
        LD	BC,00120H
        LDIR	
        LD	HL,I7D31
        JR	J7CF0



          Subroutine __________________________
             Inputs  ________________________
             Outputs ________________________

C7CDE:	PUSH	HL
        PUSH	DE
        PUSH	BC
        LD	HL,I7E7B
        LD	DE,(D.F34D)
        LD	BC,00134H
        LDIR	
        LD	HL,I7D11
J7CF0:	LD	E,(HL)
        INC	HL
J7CF2:	LD	D,(HL)
        INC	HL
        LD	A,E
        OR	D
        JR	Z,J7D0D

        PUSH	HL
        LD	HL,(D.F34D)
        ADD	HL,DE
        INC	HL
        LD	C,(HL)
J7CFF:	INC	HL
J7D00:	LD	B,(HL)
        EX	DE,HL
        LD	HL,(D.F34D)
        ADD	HL,BC
        EX	DE,HL
        LD	(HL),D
        DEC	HL
        LD	(HL),E
        POP	HL
        JR	J7CF0


J7D0D:	POP	BC
        POP	DE
J7D0F:	POP	HL
        RET	


I7D11:	LD	B,00H
        JR	NZ,J7D15

J7D15:	DEC	H
        NOP	
        ADD	HL,SP
        NOP	
        LD	C,L
        NOP	
        LD	D,E
        NOP	
        LD	H,A
        NOP	
        LD	L,H
        NOP	
        LD	(HL),H
        NOP	
        XOR	D
        NOP	
        OR	B
        NOP	
        SUB	00H
        RLCA	
        LD	BC,I$0116
        DEC	L
        LD	BC,C.0000
I7D31:	LD	B,00H
        JR	NZ,J7D35

J7D35:	DEC	H
        NOP	
        INC	A
        NOP	
        LD	C,H
        NOP	
        LD	D,C
        NOP	
        LD	D,L
        NOP	
        LD	H,C
        NOP	
        LD	H,A
        NOP	
        LD	L,L
        NOP	
        ADD	A,C
        NOP	
        ADD	A,(HL)
        NOP	
        ADC	A,D
        NOP	
        JP	NZ,J$F300

        NOP	
        LD	(BC),A
        LD	BC,C.0119
        DEFB	0,0

          Subroutine __________________________
             Inputs  ________________________
             Outputs ________________________

C7D55:	PUSH	HL
        LD	HL,(D.F34D)
        EX	(SP),HL
        RET	


I7D5B:	PUSH	HL
        PUSH	DE
        PUSH	BC
        CALL	GETSLT

        LD	(D$00B6),A
        LD	H,80H
        CALL	C.0024

        EI	
        LD	A,(D.F342)
        LD	H,40H
        CALL	C.0024

        EI	
        POP	BC
        POP	DE
        POP	HL
J7D76:	DEC	HL
        LD	A,H
        ADD	A,02H
        INC	HL
        JP	M,J$00A5

        LD	E,15H
J7D80:	CALL	C.0112

        LD	A,80H
        BIT	6,D
        JR	Z,J7D91

        OR	02H
        BIT	2,D
        JR	Z,J7D91

        OR	08H
J7D91:	PUSH	HL
        PUSH	DE
        PUSH	BC
        LD	BC,D.BFBC
        LD	DE,I$0070
        PUSH	DE
        CALL	C.FFCF

        DI	
        LD	(D.BFB8),A
        LD	DE,C.0000
        LD	A,(BC)
        ADD	A,A
        JP	P,J$005E

        RET	C

        DEC	E
        JP	NZ,J.004A

        DEC	D
        JP	NZ,J.004A

        POP	BC
        POP	BC
        POP	DE
        POP	HL
        JR	J7DFD


?7DB9:	LD	DE,D.BFBB
        JP	J$006A


?7DBF:	LD	A,(BC)
        ADD	A,A
        RET	C

        JP	M,J.0064

        LD	A,(DE)
        LD	(HL),A
        INC	HL
        JP	J.0064


?7DCB:	POP	BC
        POP	DE
        POP	HL
        EI	
        CALL	C.FFD4

        LD	A,(D.BFB8)
        AND	9CH
        JR	NZ,J7DE1

        DEC	B
        JR	Z,J7E00

        CALL	C$00C2

        JR	J7D76


J7DE1:	JP	M,J$00A2

        PUSH	AF
        CALL	C$00FF

        POP	AF
        DEC	E
        JR	NZ,J7D80

        LD	E,A
        BIT	4,E
        LD	A,08H
        JR	NZ,J7DFF

        BIT	3,E
        LD	A,04H
        JR	NZ,J7DFF

        LD	A,0CH
        JR	J7DFF


J7DFD:	LD	A,02H
J7DFF:	SCF	
J7E00:	PUSH	HL
        PUSH	DE
        PUSH	BC
        PUSH	AF
        LD	A,(D.F343)
        LD	H,80H
        CALL	C.0024

        CALL	C.F368

        EI	
        LD	A,00H
        LD	H,40H
        CALL	C.0024

        EI	
        POP	AF
        POP	BC
        POP	DE
        POP	HL
        RET	


?7E1D:	CALL	C.0112

        INC	H
        INC	H
        LD	A,(D.BFBA)
        INC	A
        LD	(D.BFBA),A
        BIT	7,D
        JR	NZ,J7E30

        CP	0AH
        RET	C

J7E30:	CP	09H
        RET	C

        LD	A,01H
        LD	(D.BFBA),A
        BIT	6,D
        JR	Z,J7E47

        BIT	2,D
        JR	NZ,J7E47

        SET	2,D
        LD	A,D
        LD	(D.BFBC),A
        RET	


J7E47:	RES	2,D
        LD	A,D
        LD	(D.BFBC),A
        INC	C
        CALL	C.0112

        LD	A,55H
        LD	(D.BFB8),A
        EX	(SP),HL
        EX	(SP),HL
        JR	J7E6D


?7E5A:	BIT	0,E
        RET	NZ

        CALL	C.0119

        LD	A,C
        LD	(D.BFBB),A
        EX	(SP),HL
        EX	(SP),HL
        LD	A,15H
J7E68:	LD	(D.BFB8),A
        EX	(SP),HL
        EX	(SP),HL
J7E6D:	LD	A,(D.BFB8)
        RRA	
        JR	C,J7E6D

        RET	


?7E74:	CALL	C.0112

        LD	A,01H
        JR	J7E68


I7E7B:	PUSH	HL
        PUSH	DE
        PUSH	BC
        CALL	GETSLT

        LD	(D$00CA),A
        LD	H,80H
        CALL	C.0024

        EI	
        LD	A,(D.F342)
        LD	H,40H
        CALL	C.0024

        EI	
        POP	BC
        POP	DE
        POP	HL
J7E96:	DEC	HL
        LD	A,H
        ADD	A,02H
        INC	HL
        JP	M,J$00B9

        LD	E,15H
J7EA0:	CALL	C.0126

        LD	A,0A0H
        BIT	6,D
        JR	Z,J7EB1

        OR	02H
        BIT	2,D
        JR	Z,J7EB1

        OR	08H
J7EB1:	PUSH	HL
        PUSH	DE
        PUSH	BC
        LD	DE,I$0056
        PUSH	DE
        CALL	C.FFCF

        DI	
        LD	(D.BFB8),A
        LD	BC,D.BFBC
        LD	DE,D.BFBB
        LD	A,(BC)
        ADD	A,A
        RET	C

        JP	M,J.004A

        LD	A,(HL)
        LD	(DE),A
        INC	HL
        JP	J.004A


?7ED1:	POP	BC
        POP	DE
        POP	HL
        EI	
        CALL	C.FFD4

        LD	A,(D.BFB8)
        AND	0FCH
        JR	NZ,J7EE7

        DEC	B
        JR	Z,J7F34

        CALL	C$00D6

        JR	J7E96


J7EE7:	JP	M,J$00B3

        BIT	6,A
        JR	NZ,J7F0D

        PUSH	AF
        CALL	C$0113

        POP	AF
        DEC	E
        JR	NZ,J7EA0

        LD	E,A
        BIT	5,E
        LD	A,0AH
        JR	NZ,J7F33

        BIT	4,E
        LD	A,08H
        JR	NZ,J7F33

        BIT	3,E
        LD	A,04H
        JR	NZ,J7F33

        LD	A,0CH
        JR	J7F33


J7F0D:	LD	A,0D0H
        LD	(D.BFB8),A
        EX	(SP),HL
        EX	(SP),HL
        LD	A,80H
        LD	(D.BFB8),A
        EX	(SP),HL
        EX	(SP),HL
        LD	HL,D.BFBC
        LD	DE,C.0000
        LD	A,(HL)
        ADD	A,A
        JR	C,J7F32

        JP	P,J$00B7

        DEC	DE
        LD	A,E
        OR	D
        JP	NZ,J$00A6

        LD	A,02H
        JR	J7F33


J7F32:	XOR	A
J7F33:	SCF	
J7F34:	PUSH	HL
        PUSH	DE
        PUSH	BC
        PUSH	AF
        LD	A,(D.F343)
        LD	H,80H
        CALL	C.0024

        CALL	C.F368

        EI	
        LD	A,00H
        LD	H,40H
        CALL	C.0024

        EI	
        POP	AF
        POP	BC
        POP	DE
        POP	HL
        RET	


?7F51:	CALL	C.0126

        INC	H
        INC	H
        LD	A,(D.BFBA)
        INC	A
        LD	(D.BFBA),A
        BIT	7,D
        JR	NZ,J7F64

        CP	0AH
        RET	C

J7F64:	CP	09H
        RET	C

        LD	A,01H
        LD	(D.BFBA),A
        BIT	6,D
        JR	Z,J7F7B

        BIT	2,D
        JR	NZ,J7F7B

        SET	2,D
        LD	A,D
        LD	(D.BFBC),A
        RET	


J7F7B:	RES	2,D
        LD	A,D
        LD	(D.BFBC),A
        INC	C
        CALL	C.0126

        LD	A,55H
        LD	(D.BFB8),A
        EX	(SP),HL
        EX	(SP),HL
        JR	J7FA1


?7F8E:	BIT	0,E
        RET	NZ

        CALL	C$012D

        LD	A,C
        LD	(D.BFBB),A
        EX	(SP),HL
        EX	(SP),HL
        LD	A,15H
J7F9C:	LD	(D.BFB8),A
        EX	(SP),HL
        EX	(SP),HL
J7FA1:	LD	A,(D.BFB8)
        RRA	
        JR	C,J7FA1

        RET	


?7FA8:	CALL	C.0126

        LD	A,01H
        JR	J7F9C


?7FAF:	RST	38H
        