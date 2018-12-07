; Diskdriver Sanyo MFD-001 (external floppydisk controller)
; FDC	MB8877A

; Source re-created by Z80DIS 2.2
; Z80DIS was written by Kenneth Gielow, Palo Alto, CA

; Code Copyrighted by SANYO and maybe others
; Source comments by Arjen Zeilemaker

; Sourcecode supplied for STUDY ONLY
; Recreation NOT permitted without authorisation of the copyrightholders
; Driver

MYSIZE		equ	8
SECLEN		equ	512

C.0000	EQU	0000H	; -C--I
I.0001	EQU	0001H	; ----I
I$0008	EQU	0008H	; ----I
I$0012	EQU	0012H	; ----I
I$00A2	EQU	00A2H	; ----I
I$00A3	EQU	00A3H	; ----I
I$00A4	EQU	00A4H	; ----I
I$00C5	EQU	00C5H	; ----I
J.0100	EQU	0100H	; J---I
I.0200	EQU	0200H	; ----I
J$022E	EQU	022EH	; J----
I.0290	EQU	0290H	; ----I
I$1800	EQU	1800H	; ----I
I$3F00	EQU	3F00H	; ----I
J$4022	EQU	4022H	; J----

D$C059	EQU	0C059H	; ---L-
J$C063	EQU	0C063H	; J----
J$C06A	EQU	0C06AH	; J----
I$C079	EQU	0C079H	; ----I
I.C09F	EQU	0C09FH	; ----I
D$C0AD	EQU	0C0ADH	; --S--
D.C0C4	EQU	0C0C4H	; --SL-
C.F37D	EQU	0F37DH	; -C---
I$F51F	EQU	0F51FH	; ----I


I7405:

; Only supports 5.25 single sided media
; DEFDPB should point to the largest media, which should be 0FDH instead of 0FCH

DEFDPB	EQU	$-1

        DB	0FCh
        DW	512
        DB	00Fh
        DB	004h
        DB	000h
        DB	001h
        DW	1
        DB	2
        DB	64
        DW	9
        DW	352
        DB	2
        DW	5

        DB	0FDh
        DW	512
        DB	00Fh
        DB	004h
        DB	001h
        DB	002h
        DW	1
        DB	2
        DB	112
        DW	12
        DW	355
        DB	2
        DW	5

        DB	0FEh
        DW	512
        DB	00Fh
        DB	004h
        DB	000h
        DB	001h
        DW	1
        DB	2
        DB	64
        DW	7
        DW	314
        DB	1
        DW	3

        DB	0FFh
        DW	512
        DB	00Fh
        DB	004h
        DB	001h
        DB	002h
        DW	1
        DB	2
        DB	112
        DW	10
        DW	316
        DB	1
        DW	3


;	  Subroutine __________________________
;	     Inputs  ________________________
;	     Outputs ________________________

DSKIO:	JP	NC,C753A
        CALL	C747D
J7453:	PUSH	AF
        LD	C,120
        JR	NC,J745A
        LD	C,0
J745A:	LD	A,0D0H
        LD	(D7FF8),A
        EX	(SP),HL
        EX	(SP),HL
        EX	(SP),HL
        EX	(SP),HL
        LD	A,(D7FFB)
        LD	A,(D7FF8)
        LD	(IX),240
        LD	A,(IX+3)
        AND	A
        JR	NZ,J7478
        LD	(IX+1),C
        POP	AF
        RET	
J7478:	LD	(IX+2),C
        POP	AF
        RET	

;	  Subroutine __________________________
;	     Inputs  ________________________
;	     Outputs ________________________

C747D:	CALL	C75EC
        RET	C
J7481:	LD	A,L
        ADD	A,0FFH
        LD	A,H
        ADC	A,01H	; 1 
        CP	40H	; "@"
        JP	C,J74A9
        LD	A,H
        AND	A
        JP	M,J74A9
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
        CALL	C74B5
        POP	HL
        JP	J74AC
J74A9:	CALL	C74B5
J74AC:	RET	C
        DEC	B
        RET	Z
        CALL	C76A5
        JP	J7481
;	  Subroutine __________________________
;	     Inputs  ________________________
;	     Outputs ________________________
C74B5:	LD	E,15H
J74B7:	CALL	C76F5			; wait for command ready
        LD	A,0A0H
        BIT	6,D
        JR	Z,J74C8
        OR	02H	; 2 
        BIT	2,D
        JR	Z,J74C8
        OR	08H	; 8 
J74C8:	PUSH	HL
        PUSH	DE
        PUSH	BC
        LD	DE,I74E5
        PUSH	DE
        DI	
        LD	(D7FF8),A
        LD	BC,D7FFC
        LD	DE,D7FFB
J74D9:	LD	A,(BC)
        ADD	A,A
        RET	C
        JP	P,J74D9
        LD	A,(HL)
        LD	(DE),A
        INC	HL
        JP	J74D9
I74E5:	POP	BC
        POP	DE
        POP	HL
        EI	
        LD	A,(D7FF8)
        AND	0FCH
        RET	Z
        JP	M,J7533
        BIT	6,A
        JR	NZ,J7512
        PUSH	AF
        CALL	C76E2
        POP	AF
        DEC	E
        JR	NZ,J74B7
J74FE:	SCF	
        LD	E,A
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
J7512:	LD	A,0D0H
        LD	(D7FF8),A
        EX	(SP),HL
        EX	(SP),HL
        LD	A,80H
        LD	(D7FF8),A
        EX	(SP),HL
        EX	(SP),HL
        LD	HL,D7FFC
        LD	DE,C.0000
J7526:	LD	A,(HL)
        ADD	A,A
        JR	C,J7537
        JP	P,J7537
        DEC	DE
        LD	A,E
        OR	D
        JP	NZ,J7526
J7533:	LD	A,02H	; 2 
        SCF	
        RET	
J7537:	XOR	A
        SCF	
        RET	
;	  Subroutine __________________________
;	     Inputs  ________________________
;	     Outputs ________________________
C753A:	CALL	C7540
        JP	J7453
;	  Subroutine __________________________
;	     Inputs  ________________________
;	     Outputs ________________________
C7540:	CALL	C75EC
        RET	C
J7544:	LD	A,L
        ADD	A,0FFH
        LD	A,H
        ADC	A,01H	; 1 
        CP	40H	; "@"
        JP	C,J7571
        LD	A,H
        AND	A
        JP	M,J7571
        PUSH	HL
        LD	HL,($SECBUF)
        CALL	C757D
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
        JP	J7575
J7571:	CALL	C757D
        RET	C
J7575:	DEC	B
        RET	Z
        CALL	C76A5
        JP	J7544
;	  Subroutine __________________________
;	     Inputs  ________________________
;	     Outputs ________________________
C757D:	LD	E,15H
J757F:	CALL	C76F5			; wait for command ready
        LD	A,80H
        BIT	6,D
        JR	Z,J7590
        OR	02H	; 2 
        BIT	2,D
        JR	Z,J7590
        OR	08H	; 8 
J7590:	PUSH	HL
        PUSH	DE
        PUSH	BC
        LD	BC,D7FFC
        LD	DE,I75C4
        PUSH	DE
        DI	
        LD	(D7FF8),A
        LD	DE,C.0000
J75A1:	LD	A,(BC)
        ADD	A,A
        JP	P,J75B5
        RET	C
        DEC	E
        JP	NZ,J75A1
        DEC	D
        JP	NZ,J75A1
        POP	BC
        POP	BC
        POP	DE
        POP	HL
        JR	J75E8
J75B5:	LD	DE,D7FFB
J75B8:	LD	A,(BC)
        ADD	A,A
        RET	C
        JP	P,J75B8
        LD	A,(DE)
        LD	(HL),A
        INC	HL
        JP	J75B8
I75C4:	POP	BC
        POP	DE
        POP	HL
        EI	
        LD	A,(D7FF8)
        AND	9CH
        RET	Z
        JP	M,J75E8
        PUSH	AF
        CALL	C76E2
        POP	AF
        DEC	E
        JR	NZ,J757F
        SCF	
        LD	E,A
        BIT	4,E
        LD	A,08H	; 8 
        RET	NZ
        BIT	3,E
        LD	A,04H	; 4 
        RET	NZ
        LD	A,0CH	; 12 
        RET	
J75E8:	LD	A,02H	; 2 
        SCF	
        RET	
;	  Subroutine __________________________
;	     Inputs  ________________________
;	     Outputs ________________________

C75EC:	PUSH	AF
        PUSH	BC
        PUSH	HL
        CALL	GETWRK
        POP	HL
        POP	BC
        POP	AF
        CP	02H	; 2 
        JR	C,J75FD
J75F9:	LD	A,0CH	; 12 
        SCF	
        RET	
J75FD:	PUSH	AF
        LD	A,C
        CP	0FCH
        JR	NC,J7606
        POP	AF
        JR	J75F9
J7606:	EX	(SP),HL
        PUSH	HL
        PUSH	BC
        CALL	C76F5			; wait for command ready
        BIT	1,C			; 8 sectors per track ?
        LD	C,E
        LD	B,D
        LD	DE,8
        JR	NZ,J7616
        INC	DE
J7616:	CALL	DIV16
        LD	A,L
        INC	A
        LD	(D7FFA),A
        LD	L,C
        POP	BC
        POP	AF
        LD	H,A
        LD	A,(IX+7)
        DEC	A
        JR	Z,J7629
        LD	A,H
J7629:	ADD	A,09H
        BIT	0,C
        JR	Z,J7635
        SRL	L
        JR	NC,J7635
        OR	04H	; 4 
J7635:	LD	D,A
        LD	A,C
        RRCA	
        RRCA	
        AND	0C0H
        OR	D
        LD	D,A
        DI	
        LD	(D7FFC),A
        LD	A,(IX)
        AND	A
        LD	(IX),0FFH
        EI	
        JR	NZ,J765C
        PUSH	HL
        PUSH	BC
        LD	B,02H	; 2 
J7650:	LD	HL,C.0000
J7653:	DEC	HL
        LD	A,L
        OR	H
        JR	NZ,J7653
        DJNZ	J7650
        POP	BC
        POP	HL
J765C:	LD	C,L
        LD	A,(IX+7)
        DEC	A
        JR	Z,J7688
        LD	A,(IX+3)
        CP	H
        JR	Z,J769C
        XOR	01H	; 1 
        LD	(IX+3),A
        LD	A,(D7FF9)
        JR	Z,J767B
        LD	(IX+4),A
        LD	A,(IX+5)
        JR	J7681
J767B:	LD	(IX+5),A
        LD	A,(IX+4)
J7681:	LD	(D7FF9),A
        EX	(SP),HL
        EX	(SP),HL
        JR	J769F
J7688:	LD	A,H
        CP	(IX+6)
        LD	(IX+6),A
        JR	Z,J769C
        PUSH	IX
        PUSH	DE
        PUSH	BC
        CALL	PROMPT
        POP	BC
        POP	DE
        POP	IX
J769C:	LD	A,(D7FF9)
J769F:	CP	C
        CALL	NZ,C76E8		; select track
        POP	HL
        RET	
;	  Subroutine __________________________
;	     Inputs  ________________________
;	     Outputs ________________________
C76A5:	CALL	C76F5			; wait for command ready
        INC	H
        INC	H
        LD	A,(D7FFA)
        INC	A
        LD	(D7FFA),A
        BIT	7,D
        JR	NZ,J76B8
        CP	0AH	; 10 
        RET	C
J76B8:	CP	09H	; 9 
        RET	C
        LD	A,01H	; 1 
        LD	(D7FFA),A
        BIT	6,D
        JR	Z,J76CF
        BIT	2,D
        JR	NZ,J76CF
        SET	2,D
        LD	A,D
        LD	(D7FFC),A
        RET	
J76CF:	RES	2,D
        LD	A,D
        LD	(D7FFC),A
        INC	C
        CALL	C76F5			; wait for command ready
        LD	A,50H	; "P"
        LD	(D7FF8),A
        EX	(SP),HL
        EX	(SP),HL
        JR	C76F5			; wait for command ready
;	  Subroutine __________________________
;	     Inputs  ________________________
;	     Outputs ________________________
C76E2:	BIT	0,E
        RET	NZ
        CALL	C76FC
;	  Subroutine __________________________
;	     Inputs  ________________________
;	     Outputs ________________________

C76E8:	LD	A,C
        LD	(D7FFB),A
        EX	(SP),HL
        EX	(SP),HL
        LD	A,10H	; 16 
J76F0:	LD	(D7FF8),A
        EX	(SP),HL
        EX	(SP),HL

;	  Subroutine __________________________
;	     Inputs  ________________________
;	     Outputs ________________________

C76F5:	LD	A,(D7FF8)
        RRA	
        JR	C,C76F5
        RET	

;	  Subroutine __________________________
;	     Inputs  ________________________
;	     Outputs ________________________
C76FC:	CALL	C76F5			; wait for command ready
        LD	A,00H
        JR	J76F0

INIHRD:	LD	A,0D0H
        LD	(D7FF8),A
        EX	(SP),HL
        EX	(SP),HL
        LD	A,01H
        CALL	C7719
        LD	A,02H
        CALL	C7719
        XOR	A
        LD	(D7FFC),A
        RET	

;	  Subroutine __________________________
;	     Inputs  ________________________
;	     Outputs ________________________

C7719:	LD	(D7FFC),A
        CALL	C76F5			; wait for command ready
        LD	A,00H
        LD	(D7FF8),A
        EX	(SP),HL
        EX	(SP),HL
        LD	HL,0
J7729:	LD	A,(D7FF8)
        RRA	
        RET	NC
        DEC	HL
        LD	A,L
        OR	H
        JR	NZ,J7729
        RET

DRIVES:	PUSH	BC
        PUSH	AF
        CALL	GETWRK
        LD	A,02H
        LD	(D7FFC),A
        CALL	C76F5			; wait for command ready
        LD	A,00H
        LD	(D7FF8),A
        EX	(SP),HL
        EX	(SP),HL
        LD	HL,0
J774B:	LD	A,(D7FF8)
        RRA	
        JR	NC,J7758
        DEC	HL
        LD	A,L
        OR	H
        JR	NZ,J774B
        INC	L
        DEFB	0CAH
J7758:	LD	L,2
        LD	(IX+7),L
        XOR	A
        LD	(D7FFC),A
        POP	AF
        JR	Z,J7766
        LD	L,2
J7766:	POP	BC
        RET	

INIENV:	CALL	GETWRK
        XOR	A
        LD	B,7
J776E:	LD	(HL),A
        INC	HL
        DJNZ	J776E
        LD	HL,I7778
        JP	SETINT

I7778:	PUSH	AF
        CALL	GETWRK
        LD	A,(HL)
        AND	A
        JR	Z,J778B
        CP	0FFH
        JR	Z,J778B
        DEC	A
        LD	(HL),A
        JR	NZ,J778B
        LD	(D7FFC),A
J778B:	INC	HL
        LD	A,(HL)
        AND	A
        JR	Z,J7791
        DEC	(HL)
J7791:	INC	HL
        LD	A,(HL)
        AND	A
        JR	Z,J7797
        DEC	(HL)
J7797:	POP	AF
        JP	PRVINT

DSKCHG:	PUSH	HL
        PUSH	BC
        PUSH	AF
        CALL	GETWRK
        POP	AF
        POP	BC
        POP	HL
        LD	B,(IX+7)
        DEC	B
        JR	Z,J77B0
        AND	A
        LD	B,(IX+2)
        JR	NZ,J77B3
J77B0:	LD	B,(IX+1)
J77B3:	AND	A
        INC	B
        DEC	B
        LD	B,01H	; 1 
        RET	NZ
        PUSH	BC
        PUSH	HL
        LD	DE,I.0001
        LD	HL,($SECBUF)
        CALL	C753A
        JR	C,J77DD
        LD	HL,($SECBUF)
        LD	B,(HL)
        POP	HL
        PUSH	BC
        CALL	GETDPB
        LD	A,0CH	; 12 
        JR	C,J77DD
        POP	AF
        POP	BC
        CP	C
        SCF	
        CCF	
        LD	B,0FFH
        RET	NZ
        INC	B
        RET	
J77DD:	POP	DE
        POP	DE
        RET	

;	  Subroutine __________________________
;	     Inputs  ________________________
;	     Outputs ________________________

GETDPB:	EX	DE,HL
        INC	DE
        LD	A,B
        SUB	0FCH
        RET	C
        LD	L,A
        LD	H,00H
        ADD	HL,HL
        LD	C,L
        LD	B,H
        ADD	HL,HL
        ADD	HL,HL
        ADD	HL,HL
        ADD	HL,BC
        LD	BC,I7405
        ADD	HL,BC
        LD	BC,I$0012
        LDIR	
        RET	

CHOICE:	LD	HL,0
        RET	

DSKFMT:	LD	A,D
        PUSH	AF
        PUSH	HL
        LD	C,0FDH
        LD	DE,0
        LD	B,1
        CALL	C75EC
        POP	HL
        JR	C,J783F
        POP	AF
        PUSH	AF
        OR	A
        LD	A,09H			; motor on, side 0, select drive 0
        JR	Z,J7817
        LD	A,0AH			; motor on, side 0, select drive 1
J7817:	PUSH	AF
        CALL	C7899
        CALL	C78DF
        CALL	C76FC			; select track 0
        CALL	C7842			; format all tracks (side 0)
        JR	C,J783F
        CALL	C76FC			; select track 0
        POP	AF
        OR	04H
        LD	(D7FFC),A		; side 1
        LD	A,1
        CALL	C78C4
        CALL	C7842			; format all tracks (side 1)
        JR	C,J7840
        POP	AF
        CALL	C78F8			; write boot sector, FATs and directory
        OR	A
        RET	
J783F:	POP	HL
J7840:	POP	HL
        RET	

;	  Subroutine __________________________
;	     Inputs  ________________________
;	     Outputs ________________________

C7842:	XOR	A
J7843:	PUSH	AF
        LD	C,A
        CALL	C76E8			; select track
        POP	AF
        PUSH	HL
        CALL	C7855			; format track
        POP	HL
        RET	C
        INC	A
        CP	40
        JR	NZ,J7843
        RET	

;	  Subroutine __________________________
;	     Inputs  ________________________
;	     Outputs ________________________

C7855:	PUSH	HL
        CALL	C78CC
        CALL	C76F5			; wait for command ready
        LD	B,4
        POP	HL
J785F:	PUSH	HL
        PUSH	BC
        LD	A,0F0H
        LD	DE,I787D
        PUSH	DE
        LD	BC,D7FFC
        LD	DE,D7FFB
        DI	
        LD	(D7FF8),A
J7871:	LD	A,(BC)
        ADD	A,A
        RET	C
        JP	P,J7871
        LD	A,(HL)
        LD	(DE),A
        INC	HL
        JP	J7871
I787D:	POP	BC
        POP	HL
        LD	A,(D7FF8)
        EI	
        AND	0E4H
        JR	J7894
?.7887:	JP	M,J7533
        BIT	6,A
        JP	NZ,J7512
        DJNZ	J785F
        JP	J74FE
J7894:	LD	A,(D7FF9)
        OR	A
        RET	

;	  Subroutine __________________________
;	     Inputs  ________________________
;	     Outputs ________________________

C7899:	PUSH	HL
        LD	DE,I7A06
        CALL	C78B2
        LD	B,09H	; 9 
J78A2:	LD	DE,I7A11
        CALL	C78B2
        DJNZ	J78A2
        LD	DE,I7A32
        CALL	C78B2
        POP	HL
        RET	
;	  Subroutine __________________________
;	     Inputs  ________________________
;	     Outputs ________________________
C78B2:	PUSH	BC
J78B3:	LD	A,(DE)
        CP	37H
        JR	Z,J78C2
        LD	B,A
        INC	DE
        LD	A,(DE)
J78BB:	LD	(HL),A
        INC	HL
        DJNZ	J78BB
        INC	DE
        JR	J78B3
J78C2:	POP	BC
        RET	
;	  Subroutine __________________________
;	     Inputs  ________________________
;	     Outputs ________________________
C78C4:	LD	A,01H	; 1 
        LD	DE,I$00A3
        JP	J78D2
;	  Subroutine __________________________
;	     Inputs  ________________________
;	     Outputs ________________________
C78CC:	LD	DE,I$00A2
        JP	J78D2

J78D2:	PUSH	HL
        ADD	HL,DE
        LD	DE,I.0290
        LD	B,09H	; 9 
J78D9:	LD	(HL),A
        ADD	HL,DE
        DJNZ	J78D9
        POP	HL
        RET	
;	  Subroutine __________________________
;	     Inputs  ________________________
;	     Outputs ________________________
C78DF:	PUSH	HL
        LD	IX,I7A3B
        LD	DE,I$00A4
        ADD	HL,DE
        LD	DE,I.0290
        LD	B,09H	; 9 
J78ED:	LD	A,(IX)
        INC	IX
        LD	(HL),A
        ADD	HL,DE
        DJNZ	J78ED
        POP	HL
        RET	

;	  Subroutine __________________________
;	     Inputs  ________________________
;	     Outputs ________________________

C78F8:	PUSH	AF
        PUSH	HL
        CALL	C7931			; clear buffer
        PUSH	HL
        EX	DE,HL
        LD	HL,I7941
        LD	BC,I$00C5
        LDIR	
        POP	HL
        LD	DE,1*512
        ADD	HL,DE
        CALL	C7925			; 1st FAT sector 1st FAT
        ADD	HL,DE
        ADD	HL,DE
        CALL	C7925			; 1st FAT sector 2nd FAT
        POP	HL
        POP	AF
        LD	B,12
        LD	C,0FDH
        LD	DE,0
        SCF	
        CALL	DSKIO
        RET	NC
        JP	J7840

;	  Subroutine __________________________
;	     Inputs  ________________________
;	     Outputs ________________________

C7925:	PUSH	HL
        LD	A,0FDH
        LD	(HL),A
        INC	HL
        LD	A,0FFH
        LD	(HL),A
        INC	HL
        LD	(HL),A
        POP	HL
        RET	

;	  Subroutine __________________________
;	     Inputs  ________________________
;	     Outputs ________________________

C7931:	PUSH	AF
        PUSH	HL
        LD	BC,12*512
J7936:	XOR	A
        LD	(HL),A
        INC	HL
        DEC	BC
        LD	A,B
        OR	C
        JR	NZ,J7936
        POP	HL
        POP	AF
        RET

I7941:	DEFB	0EBH,0FEH,90H,4DH,53H,58H,5FH,30H
        DEFB	32H,20H,20H,00H,02H,02H,01H,00H
        DEFB	02H,70H,00H,0D0H,02H,0FDH,02H,00H
        DEFB	09H,00H,02H,00H,00H,00H
?.795F:	RET	NC
        LD	(D$C059),DE
        LD	(D.C0C4),A
        LD	(HL),56H	; "V"
        INC	HL
        LD	(HL),0C0H
J796C:	LD	SP,I$F51F
        LD	DE,I.C09F
        LD	C,0FH	; 15 
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
        LD	C,27H	; "'"
        CALL	C.F37D
        JP	J.0100
?.7997:	LD	E,B
        RET	NZ
        CALL	C.0000
        LD	A,C
        AND	0FEH
        CP	02H	; 2 
        JP	NZ,J$C06A
        LD	A,(D.C0C4)
        AND	A
        JP	Z,J$4022
        LD	DE,I$C079
        LD	C,09H	; 9 
        CALL	C.F37D
        LD	C,07H	; 7 
        CALL	C.F37D
        JR	J796C
?.79BA:	DEFB	42H,6FH,6FH,74H,20H,65H,72H,72H
        DEFB	6FH,72H,0DH,0AH,50H,72H,65H,73H
        DEFB	73H,20H,61H,6EH,79H,20H,6BH,65H
        DEFB	79H,20H,66H,6FH,72H,20H,72H,65H
        DEFB	74H,72H,79H,0DH,0AH,24H,00H,4DH
        DEFB	53H,58H,44H,4FH,53H,20H,20H,53H
        DEFB	59H,53H,00H,00H,00H,00H,00H,00H
        DEFB	00H,00H,00H,00H,00H,00H,00H,00H
        DEFB	00H,00H,00H,00H,00H,00H,00H,00H
        DEFB	00H,00H,00H,00H
I7A06:	DEFB	50H,4EH,0CH,00H,03H,0F6H,01H,0FCH
        DEFB	32H,4EH,37H
I7A11:	DEFB	0CH,00H,03H,0F5H,01H,0FEH,01H,00H
        DEFB	01H
        DEFB	00H,01H,01H,01H,02H,01H,0F7H,16H
        DEFB	4EH,0CH,00H,03H,0F5H,01H,0FBH,00H
        DEFB	0E5H,00H,0E5H,01H,0F7H,54H,4EH,37H
I7A32:	DEFB	00H,4EH,00H,4EH,00H,4EH,00H,4EH
        DEFB	37H
I7A3B:	DEFB	01H,04H,07H,02H,05H,08H,03H,06H
        DEFB	09H,00H,37H,0C9H,00H,0FFH,0FFH
        DEFB	0FFH,0FFH,0FFH,0FFH,0FFH,0FFH,0FFH,0FFH
        DEFB	0FFH,0FFH,0FFH,0FFH,0FFH,0FFH,0FFH,0FFH
        DEFB	0FFH,0FFH,0FFH,0FFH,0FFH,0FFH,0FFH,0FFH
        DEFB	0FFH,0FFH,0FFH,0FFH,0FFH,0FFH,0FFH,0FFH
        DEFB	0FFH,0FFH,0FFH,0FFH,0FFH,0FFH,0FFH,0FFH
        DEFB	0FFH,0FFH,0FFH,0FFH,0FFH,0FFH,0FFH,0FFH
        DEFB	0FFH,0FFH,0FFH,0FFH,0FFH,0FFH,0FFH,0FFH
        DEFB	0FFH,0FFH,0FFH,0FFH,0FFH,0FFH,0FFH,0FFH
        DEFB	0FFH,0FFH,0FFH,0FFH,0FFH,0FFH,0FFH,0FFH
        DEFB	0FFH,0FFH,0FFH,0FFH,0FFH,0FFH,0FFH,0FFH
        DEFB	0FFH,0FFH,0FFH,0FFH,0FFH,0FFH,0FFH,0FFH
        DEFB	0FFH,0FFH,0FFH,0FFH,0FFH,0FFH,0FFH,0FFH
        DEFB	0FFH,0FFH,0FFH,0FFH,0FFH,0FFH,0FFH,0FFH
        DEFB	0FFH,0FFH,0FFH,0FFH,0FFH,0FFH,0FFH,0FFH
        DEFB	0FFH,0FFH,0FFH,0FFH,0FFH,0FFH,0FFH,0FFH
        DEFB	0FFH,0FFH,0FFH,0FFH,0FFH,0FFH,0FFH,0FFH
        DEFB	0FFH,0FFH,0FFH,0FFH,0FFH,0FFH,0FFH,0FFH
        DEFB	0FFH,0FFH,0FFH,0FFH,0FFH,0FFH,0FFH,0FFH
        DEFB	0FFH,0FFH,0FFH,0FFH,0FFH,0FFH,0FFH,0FFH
        DEFB	0FFH,0FFH,0FFH,0FFH,0FFH,0FFH,0FFH,0FFH
        DEFB	0FFH,0FFH,0FFH,0FFH,0FFH,0FFH,0FFH,0FFH
        DEFB	0FFH,0FFH,0FFH,0FFH,0FFH,0FFH,0FFH,0FFH
        DEFB	0FFH,0FFH,0FFH,0FFH,0FFH,0FFH,0FFH,0FFH
        DEFB	0FFH,0FFH,0FFH,0FFH,0FFH,0FFH,0FFH,0FFH
        DEFB	0FFH,0FFH,0FFH,0FFH,0FFH,0FFH,0FFH,0FFH
        DEFB	0FFH,0FFH,0FFH,0FFH,0FFH,0FFH,0FFH,0FFH
        DEFB	0FFH,0FFH,0FFH,0FFH,0FFH,0FFH,0FFH,0FFH
        DEFB	0FFH,0FFH,0FFH,0FFH,0FFH,0FFH,0FFH,0FFH
        DEFB	0FFH,0FFH,0FFH,0FFH,0FFH,0FFH,0FFH,0FFH
        DEFB	0FFH,0FFH,0FFH,0FFH,0FFH,0FFH,0FFH,0FFH
        DEFB	0FFH,0FFH,0FFH,0FFH,0FFH,0FFH,0FFH,0FFH
        DEFB	0FFH,0FFH,0FFH,0FFH,0FFH,0FFH,0FFH,0FFH
        DEFB	0FFH,0FFH,0FFH,0FFH,0FFH,0FFH,0FFH,0FFH
        DEFB	0FFH,0FFH,0FFH,0FFH,0FFH,0FFH,0FFH,0FFH
        DEFB	0FFH,0FFH,0FFH,0FFH,0FFH,0FFH,0FFH,0FFH
        DEFB	0FFH,0FFH,0FFH,0FFH,0FFH,0FFH,0FFH,0FFH
        DEFB	0FFH,0FFH,0FFH,0FFH,0FFH,0FFH,0FFH,0FFH
        DEFB	0FFH,0FFH,0FFH,0FFH,0FFH,0FFH,0FFH,0FFH
        DEFB	0FFH,0FFH,0FFH,0FFH,0FFH,0FFH,0FFH,0FFH
        DEFB	0FFH,0FFH,0FFH,0FFH,0FFH,0FFH,0FFH,0FFH
        DEFB	0FFH,0FFH,0FFH,0FFH,0FFH,0FFH,0FFH,0FFH
        DEFB	0FFH,0FFH,0FFH,0FFH,0FFH,0FFH,0FFH,0FFH
        DEFB	0FFH,0FFH,0FFH,0FFH,0FFH,0FFH,0FFH,0FFH
        DEFB	0FFH,0FFH,0FFH,0FFH,0FFH,0FFH,0FFH,0FFH
        DEFB	0FFH,0FFH,0FFH,0FFH,0FFH,0FFH,0FFH,0FFH
        DEFB	0FFH,0FFH,0FFH,0FFH,0FFH,0FFH,0FFH,0FFH
        DEFB	0FFH,0FFH,0FFH,0FFH,0FFH,0FFH,0FFH,0FFH
        DEFB	0FFH,0FFH,0FFH,0FFH,0FFH,0FFH,0FFH,0FFH
        DEFB	0FFH,0FFH,0FFH,0FFH,0FFH,0FFH,0FFH,0FFH
        DEFB	0FFH,0FFH,0FFH,0FFH,0FFH,0FFH,0FFH,0FFH
        DEFB	0FFH,0FFH,0FFH,0FFH,0FFH,0FFH,0FFH,0FFH
        DEFB	0FFH,0FFH,0FFH,0FFH,0FFH,0FFH,0FFH,0FFH
        DEFB	0FFH,0FFH,0FFH,0FFH,0FFH,0FFH,0FFH,0FFH
        DEFB	0FFH,0FFH,0FFH,0FFH,0FFH,0FFH,0FFH,0FFH
        DEFB	0FFH,0FFH,0FFH,0FFH,0FFH,0FFH,0FFH,0FFH
        DEFB	0FFH,0FFH,0FFH,0FFH,0FFH,0FFH,0FFH,0FFH
        DEFB	0FFH,0FFH,0FFH,0FFH,0FFH,0FFH,0FFH,0FFH
        DEFB	0FFH,0FFH,0FFH,0FFH,0FFH,0FFH,0FFH,0FFH
        DEFB	0FFH,0FFH,0FFH,0FFH,0FFH,0FFH,0FFH,0FFH
        DEFB	0FFH,0FFH,0FFH,0FFH,0FFH,0FFH,0FFH,0FFH
        DEFB	0FFH,0FFH,0FFH,0FFH,0FFH,0FFH,0FFH,0FFH
        DEFB	0FFH,0FFH,0FFH,0FFH,0FFH,0FFH,0FFH,0FFH
        DEFB	0FFH,0FFH,0FFH,0FFH,0FFH,0FFH,0FFH,0FFH
        DEFB	0FFH,0FFH,0FFH,0FFH,0FFH,0FFH,0FFH,0FFH
        DEFB	0FFH,0FFH,0FFH,0FFH,0FFH,0FFH,0FFH,0FFH
        DEFB	0FFH,0FFH,0FFH,0FFH,0FFH,0FFH,0FFH,0FFH
        DEFB	0FFH,0FFH,0FFH,0FFH,0FFH,0FFH,0FFH,0FFH
        DEFB	0FFH,0FFH,0FFH,0FFH,0FFH,0FFH,0FFH,0FFH
        DEFB	0FFH,0FFH,0FFH,0FFH,0FFH,0FFH,0FFH,0FFH
        DEFB	0FFH,0FFH,0FFH,0FFH,0FFH,0FFH,0FFH,0FFH
        DEFB	0FFH,0FFH,0FFH,0FFH,0FFH,0FFH,0FFH,0FFH
        DEFB	0FFH,0FFH,0FFH,0FFH,0FFH,0FFH,0FFH,0FFH
        DEFB	0FFH,0FFH,0FFH,0FFH,0FFH,0FFH,0FFH,0FFH
        DEFB	0FFH,0FFH,0FFH,0FFH,0FFH,0FFH,0FFH,0FFH
        DEFB	0FFH,0FFH,0FFH,0FFH,0FFH,0FFH,0FFH,0FFH
        DEFB	0FFH,0FFH,0FFH,0FFH,0FFH,0FFH,0FFH,0FFH
        DEFB	0FFH,0FFH,0FFH,0FFH,0FFH,0FFH,0FFH,0FFH
        DEFB	0FFH,0FFH,0FFH,0FFH,0FFH,0FFH,0FFH,0FFH
        DEFB	0FFH,0FFH,0FFH,0FFH,0FFH,0FFH,0FFH,0FFH
        DEFB	0FFH,0FFH,0FFH,0FFH,0FFH,0FFH,0FFH,0FFH
        DEFB	0FFH,0FFH,0FFH,0FFH,0FFH,0FFH,0FFH,0FFH
        DEFB	0FFH,0FFH,0FFH,0FFH,0FFH,0FFH,0FFH,0FFH
        DEFB	0FFH,0FFH,0FFH,0FFH,0FFH,0FFH,0FFH,0FFH
        DEFB	0FFH,0FFH,0FFH,0FFH,0FFH,0FFH,0FFH,0FFH
        DEFB	0FFH,0FFH,0FFH,0FFH,0FFH,0FFH,0FFH,0FFH
        DEFB	0FFH,0FFH,0FFH,0FFH,0FFH,0FFH,0FFH,0FFH
        DEFB	0FFH,0FFH,0FFH,0FFH,0FFH,0FFH,0FFH,0FFH
        DEFB	0FFH,0FFH,0FFH,0FFH,0FFH,0FFH,0FFH,0FFH
        DEFB	0FFH,0FFH,0FFH,0FFH,0FFH,0FFH,0FFH,0FFH
        DEFB	0FFH,0FFH,0FFH,0FFH,0FFH,0FFH,0FFH,0FFH
        DEFB	0FFH,0FFH,0FFH,0FFH,0FFH,0FFH,0FFH,0FFH
        DEFB	0FFH,0FFH,0FFH,0FFH,0FFH,0FFH,0FFH,0FFH
        DEFB	0FFH,0FFH,0FFH,0FFH,0FFH,0FFH,0FFH,0FFH
        DEFB	0FFH,0FFH,0FFH,0FFH,0FFH,0FFH,0FFH,0FFH
        DEFB	0FFH,0FFH,0FFH,0FFH,0FFH,0FFH,0FFH,0FFH
        DEFB	0FFH,0FFH,0FFH,0FFH,0FFH,0FFH,0FFH,0FFH
        DEFB	0FFH,0FFH,0FFH,0FFH,0FFH,0FFH,0FFH,0FFH
        DEFB	0FFH,0FFH,0FFH,0FFH,0FFH,0FFH,0FFH,0FFH
        DEFB	0FFH,0FFH,0FFH,0FFH,0FFH,0FFH,0FFH,0FFH
        DEFB	0FFH,0FFH,0FFH,0FFH,0FFH,0FFH,0FFH,0FFH
        DEFB	0FFH,0FFH,0FFH,0FFH,0FFH,0FFH,0FFH,0FFH
        DEFB	0FFH,0FFH,0FFH,0FFH,0FFH,0FFH,0FFH,0FFH
        DEFB	0FFH,0FFH,0FFH,0FFH,0FFH,0FFH,0FFH,0FFH
        DEFB	0FFH,0FFH,0FFH,0FFH,0FFH,0FFH,0FFH,0FFH
        DEFB	0FFH,0FFH,0FFH,0FFH,0FFH,0FFH,0FFH,0FFH
        DEFB	0FFH,0FFH,0FFH,0FFH,0FFH,0FFH,0FFH,0FFH
        DEFB	0FFH,0FFH,0FFH,0FFH,0FFH,0FFH,0FFH,0FFH
        DEFB	0FFH,0FFH,0FFH,0FFH,0FFH,0FFH,0FFH,0FFH
        DEFB	0FFH,0FFH,0FFH,0FFH,0FFH,0FFH,0FFH,0FFH
        DEFB	0FFH,0FFH,0FFH,0FFH,0FFH,0FFH,0FFH,0FFH
        DEFB	0FFH,0FFH,0FFH,0FFH,0FFH,0FFH,0FFH,0FFH
        DEFB	0FFH,0FFH,0FFH,0FFH,0FFH,0FFH,0FFH,0FFH
        DEFB	0FFH,0FFH,0FFH,0FFH,0FFH,0FFH,0FFH,0FFH
        DEFB	0FFH,0FFH,0FFH,0FFH,0FFH,0FFH,0FFH,0FFH
        DEFB	0FFH,0FFH,0FFH,0FFH,0FFH,0FFH,0FFH,0FFH
        DEFB	0FFH,0FFH,0FFH,0FFH,0FFH,0FFH,0FFH,0FFH
        DEFB	0FFH,0FFH,0FFH,0FFH,0FFH,0FFH,0FFH,0FFH
        DEFB	0FFH,0FFH,0FFH,0FFH,0FFH,0FFH,0FFH,0FFH
        DEFB	0FFH,0FFH,0FFH,0FFH,0FFH,0FFH,0FFH,0FFH
        DEFB	0FFH,0FFH,0FFH,0FFH,0FFH,0FFH,0FFH,0FFH
        DEFB	0FFH,0FFH,0FFH,0FFH,0FFH,0FFH,0FFH,0FFH
        DEFB	0FFH,0FFH,0FFH,0FFH,0FFH,0FFH,0FFH,0FFH
        DEFB	0FFH,0FFH,0FFH,0FFH,0FFH,0FFH,0FFH,0FFH
        DEFB	0FFH,0FFH,0FFH,0FFH,0FFH,0FFH,0FFH,0FFH
        DEFB	0FFH,0FFH,0FFH,0FFH,0FFH,0FFH,0FFH,0FFH
        DEFB	0FFH,0FFH,0FFH,0FFH,0FFH,0FFH,0FFH,0FFH
        DEFB	0FFH,0FFH,0FFH,0FFH,0FFH,0FFH,0FFH,0FFH
        DEFB	0FFH,0FFH,0FFH,0FFH,0FFH,0FFH,0FFH,0FFH
        DEFB	0FFH,0FFH,0FFH,0FFH,0FFH,0FFH,0FFH,0FFH
        DEFB	0FFH,0FFH,0FFH,0FFH,0FFH,0FFH,0FFH,0FFH
        DEFB	0FFH,0FFH,0FFH,0FFH,0FFH,0FFH,0FFH,0FFH
        DEFB	0FFH,0FFH,0FFH,0FFH,0FFH,0FFH,0FFH,0FFH
        DEFB	0FFH,0FFH,0FFH,0FFH,0FFH,0FFH,0FFH,0FFH
        DEFB	0FFH,0FFH,0FFH,0FFH,0FFH,0FFH,0FFH,0FFH
        DEFB	0FFH,0FFH,0FFH,0FFH,0FFH,0FFH,0FFH,0FFH
        DEFB	0FFH,0FFH,0FFH,0FFH,0FFH,0FFH,0FFH,0FFH
        DEFB	0FFH,0FFH,0FFH,0FFH,0FFH,0FFH,0FFH,0FFH
        DEFB	0FFH,0FFH,0FFH,0FFH,0FFH,0FFH,0FFH,0FFH
        DEFB	0FFH,0FFH,0FFH,0FFH,0FFH,0FFH,0FFH,0FFH
        DEFB	0FFH,0FFH,0FFH,0FFH,0FFH,0FFH,0FFH,0FFH
        DEFB	0FFH,0FFH,0FFH,0FFH,0FFH,0FFH,0FFH,0FFH
        DEFB	0FFH,0FFH,0FFH,0FFH,0FFH,0FFH,0FFH,0FFH
        DEFB	0FFH,0FFH,0FFH,0FFH,0FFH,0FFH,0FFH,0FFH
        DEFB	0FFH,0FFH,0FFH,0FFH,0FFH,0FFH,0FFH,0FFH
        DEFB	0FFH,0FFH,0FFH,0FFH,0FFH,0FFH,0FFH,0FFH
        DEFB	0FFH,0FFH,0FFH,0FFH,0FFH,0FFH,0FFH,0FFH
        DEFB	0FFH,0FFH,0FFH,0FFH,0FFH,0FFH,0FFH,0FFH
        DEFB	0FFH,0FFH,0FFH,0FFH,0FFH,0FFH,0FFH,0FFH
        DEFB	0FFH,0FFH,0FFH,0FFH,0FFH,0FFH,0FFH,0FFH
        DEFB	0FFH,0FFH,0FFH,0FFH,0FFH,0FFH,0FFH,0FFH
        DEFB	0FFH,0FFH,0FFH,0FFH,0FFH,0FFH,0FFH,0FFH
        DEFB	0FFH,0FFH,0FFH,0FFH,0FFH,0FFH,0FFH,0FFH
        DEFB	0FFH,0FFH,0FFH,0FFH,0FFH,0FFH,0FFH,0FFH
        DEFB	0FFH,0FFH,0FFH,0FFH,0FFH,0FFH,0FFH,0FFH
        DEFB	0FFH,0FFH,0FFH,0FFH,0FFH,0FFH,0FFH,0FFH
        DEFB	0FFH,0FFH,0FFH,0FFH,0FFH,0FFH,0FFH,0FFH
        DEFB	0FFH,0FFH,0FFH,0FFH,0FFH,0FFH,0FFH,0FFH
        DEFB	0FFH,0FFH,0FFH,0FFH,0FFH,0FFH,0FFH,0FFH
        DEFB	0FFH,0FFH,0FFH,0FFH,0FFH,0FFH,0FFH,0FFH
        DEFB	0FFH,0FFH,0FFH,0FFH,0FFH,0FFH,0FFH,0FFH
        DEFB	0FFH,0FFH,0FFH,0FFH,0FFH,0FFH,0FFH,0FFH
        DEFB	0FFH,0FFH,0FFH,0FFH,0FFH,0FFH,0FFH,0FFH
        DEFB	0FFH,0FFH,0FFH,0FFH,0FFH,0FFH,0FFH,0FFH
        DEFB	0FFH,0FFH,0FFH,0FFH,0FFH,0FFH,0FFH,0FFH
        DEFB	0FFH,0FFH,0FFH,0FFH,0FFH,0FFH,0FFH,0FFH
        DEFB	0FFH,0FFH,0FFH,0FFH,0FFH,0FFH,0FFH,0FFH
        DEFB	0FFH,0FFH,0FFH,0FFH,0FFH,0FFH,0FFH,0FFH
        DEFB	0FFH,0FFH,0FFH,0FFH,0FFH,0FFH,0FFH,0FFH
        DEFB	0FFH,0FFH,0FFH,0FFH,0FFH,0FFH,0FFH,0FFH
        DEFB	0FFH,0FFH,0FFH,0FFH,0FFH,0FFH,0FFH,0FFH
        DEFB	0FFH,0FFH,0FFH,0FFH,0FFH,0FFH,0FFH,0FFH
        DEFB	0FFH,0FFH,0FFH,0FFH,0FFH,0FFH,0FFH,0FFH
        DEFB	0FFH,0FFH,0FFH,0FFH,0FFH,0FFH,0FFH,0FFH
        DEFB	0FFH,0FFH,0FFH,0FFH,0FFH,0FFH,0FFH,0FFH
        DEFB	0FFH,0FFH,0FFH,0FFH,0FFH,0FFH,0FFH,0FFH
        DEFB	0FFH,0FFH,0FFH,0FFH,0FFH,0FFH,0FFH,0FFH
        DEFB	0FFH,0FFH,0FFH,0FFH,0FFH,0FFH,0FFH,0FFH
        DEFB	0FFH,0FFH,0FFH,0FFH,0FFH,0FFH,0FFH,0FFH
        DEFB	0FFH,0FFH,0FFH,0FFH,0FFH,0FFH,0FFH,0FFH
        DEFB	0FFH,0FFH,0FFH,0FFH,0FFH,0FFH,0FFH,0FFH
        DEFB	0FFH,0FFH,0FFH,0FFH,0FFH,0FFH,0FFH,0FFH
        DEFB	0FFH,0FFH,0FFH,0FFH,0FFH,0FFH

        DEFB	80H
        DEFB	00H
        DEFB	01H
        DEFB	00H
        DEFB	3FH,3FH,3FH,3FH

D7FF8	EQU	07FF8H			; MB8877A
D7FF9	EQU	07FF9H			; MB8877A
D7FFA	EQU	07FFAH			; MB8877A
D7FFB	EQU	07FFBH			; MB8877A

D7FFC	EQU	07FFCH			; b7 = INT (1 = INT)
                                        ; b6 = DRQ (1 = DRQ)
                                        ; b3 = motor on
                                        ; b2 = side select
                                        ; b1 = select drive 1
                                        ; b0 = select drive 0

        END
