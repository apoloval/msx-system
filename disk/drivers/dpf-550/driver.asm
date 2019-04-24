; Diskdriver AVT DPF-550
; FDC	WD179x

; Source re-created by Z80DIS 2.2
; Z80DIS was written by Kenneth Gielow, Palo Alto, CA

; Code Copyrighted by AVT and maybe others
; Source comments by Arjen Zeilemaker

; Sourcecode supplied for STUDY ONLY
; Recreation NOT permitted without authorisation of the copyrightholders

MYSIZE	EQU	9
SECLEN	EQU	512
J.0037	EQU	0037H	; J----
J.003C	EQU	003CH	; J----
I$0045	EQU	0045H	; ----I
J$0054	EQU	0054H	; J----
J.0057	EQU	0057H	; J----
J$005E	EQU	005EH	; J----
I$0065	EQU	0065H	; ----I
J$0089	EQU	0089H	; J----
J$0096	EQU	0096H	; J----
J$0097	EQU	0097H	; J----
J$0099	EQU	0099H	; J----
J$009B	EQU	009BH	; J----
J$009D	EQU	009DH	; J----
D$00A7	EQU	00A7H	; --S--
D$00AB	EQU	00ABH	; --S--
C$00B3	EQU	00B3H	; -C---
C$00B7	EQU	00B7H	; -C---
I$00C5	EQU	00C5H	; ----I
I.00C8	EQU	00C8H	; ----I
C$00EA	EQU	00EAH	; -C---
C$00EE	EQU	00EEH	; -C---
C.00FB	EQU	00FBH	; -C---
C.00FF	EQU	00FFH	; -C---
J.0100	EQU	0100H	; J---I
C$0101	EQU	0101H	; -C---
C$0105	EQU	0105H	; -C---
I$0108	EQU	0108H	; ----I
I$010C	EQU	010CH	; ----I
I$013B	EQU	013BH	; ----I
I.01FC	EQU	01FCH	; ----I
J$022E	EQU	022EH	; J----
I$02FC	EQU	02FCH	; ----I

J$4022	EQU	4022H	; J----

D$C059	EQU	0C059H	; ---L-
J$C063	EQU	0C063H	; J----
J$C06A	EQU	0C06AH	; J----
I$C079	EQU	0C079H	; ----I
I.C09F	EQU	0C09FH	; ----I
D$C0AD	EQU	0C0ADH	; --S--
D.C0C4	EQU	0C0C4H	; --SL-


I$7405:

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

DSKIO:
C744D:	EI
        JP	NC,C7527
        CALL	C747B
J7454:	PUSH	AF
        LD	C,120
        JR	NC,J745B
        LD	C,0
J745B:	LD	A,0D0H
        OUT	(WDPD0),A
        EX	(SP),HL
        EX	(SP),HL
        EX	(SP),HL
        EX	(SP),HL
        IN	A,(WDPD3)
        IN	A,(WDPD0)
        LD	(IX+0),240
        LD	A,(IX+3)
        AND	A
        JR	NZ,J7476
        LD	(IX+1),C
        POP	AF
        RET

J7476:	LD	(IX+2),C
        POP	AF
        RET

;	  Subroutine __________________________
;	     Inputs  ________________________
;	     Outputs ________________________

C747B:	CALL	C75DB
        RET	C
        LD	A,H
        AND	A
        JP	M,J74AB
        CALL	C7BA0
        CALL	C7C17
        RET	C
        INC	B
        DEC	B
        RET	Z
        LD	A,H
        AND	A
        JP	M,J74AB
        PUSH	HL
        PUSH	DE
        PUSH	BC
        LD	DE,(_SECBUF)
        PUSH	DE
        LD	BC,512
        CALL	XFER
        POP	HL
        POP	BC
        POP	DE
        CALL	C74B7
        POP	HL
        JP	J74AE

J74AB:	CALL	C74B7
J74AE:	RET	C
        DEC	B
        RET	Z
        CALL	C7683
        JP	J74AB

;	  Subroutine __________________________
;	     Inputs  ________________________
;	     Outputs ________________________
C74B7:	LD	E,15H
J74B9:	CALL	C76CB
        LD	A,0A8H
        PUSH	HL
        PUSH	DE
        PUSH	BC
        LD	DE,I$74D9
        PUSH	DE
        CALL	DISINT
        DI
        OUT	(WDPD0),A
J74CB:	IN	A,(WDPD4)
        ADD	A,A			; IRQ ?
        RET	C			; yep,
        JP	M,J74CB			; no DRQ, wait
        LD	A,(HL)
        OUT	(WDPD3),A
        INC	HL
        JP	J74CB

I$74D9:	POP	BC
        POP	DE
        POP	HL
        EI
        CALL	ENAINT
        IN	A,(WDPD0)
        AND	5CH	; "\"
        RET	Z
        JP	M,J7520
        BIT	6,A
        JR	NZ,J7503
        PUSH	AF
        CALL	C76BA
        POP	AF
        DEC	E
        JR	NZ,J74B9
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

J7503:	LD	A,0D0H
        OUT	(WDPD0,A
        EX	(SP),HL
        EX	(SP),HL
        LD	A,88H
        OUT	(WDPD0),A
        EX	(SP),HL
        EX	(SP),HL
        LD	DE,0
J7512:	IN	A,(WDPD4)
        ADD	A,A			; IRQ ?
        JR	C,J7524			; yep,
        JP	P,J7524			; DRQ,
        DEC	DE
        LD	A,E
        OR	D
        JP	NZ,J7512
J7520:	LD	A,02H	; 2
        SCF
        RET

J7524:	XOR	A
        SCF
        RET

;	  Subroutine __________________________
;	     Inputs  ________________________
;	     Outputs ________________________
C7527:	CALL	C752D
        JP	J7454

;	  Subroutine __________________________
;	     Inputs  ________________________
;	     Outputs ________________________
C752D:	CALL	C75DB
        RET	C
        LD	A,H
        AND	A
        JP	M,J7562
        CALL	C7B8C
        CALL	C7C17
        RET	C
        INC	B
        DEC	B
        RET	Z
        LD	A,H
        AND	A
        JP	M,J7562
        PUSH	HL
        LD	HL,(_SECBUF)
        CALL	C756E
        POP	HL
        RET	C
        PUSH	HL
        PUSH	DE
        PUSH	BC
        EX	DE,HL
        LD	HL,(_SECBUF)
        LD	BC,512
        CALL	XFER
        POP	BC
        POP	DE
        POP	HL
        AND	A
        JP	J7566

J7562:	CALL	C756E
        RET	C
J7566:	DEC	B
        RET	Z
        CALL	C7683
        JP	J7562

;	  Subroutine __________________________
;	     Inputs  ________________________
;	     Outputs ________________________
C756E:	LD	E,15H
J7570:	CALL	C76CB
        LD	A,88H
        PUSH	HL
        PUSH	DE
        PUSH	BC
        LD	DE,I$75B1
        PUSH	DE
        CALL	DISINT
        DI
        OUT	(WDPD0),A
        LD	B,03H	; 3
        LD	DE,0
J7587:	IN	A,(WDPD4)
        ADD	A,A			; DRQ ?
        JP	P,J75A0			; yep,
        RET	C
        DEC	E
        JP	NZ,J7587
        DEC	D
        JP	NZ,J7587
        DEC	B
        JP	NZ,J7587
        POP	BC
        POP	BC
        POP	DE
        POP	HL
        JR	J75D7

J75A0:	JP	J75AA

J75A3:	IN	A,(WDPD4)
        ADD	A,A			; IRQ ?
        RET	C			; yep,
        JP	M,J75A3			; no DRQ,
J75AA:	IN	A,(WDPD3)
        LD	(HL),A
        INC	HL
        JP	J75A3

I$75B1:	POP	BC
        POP	DE
        POP	HL
        EI
        CALL	ENAINT
        IN	A,(WDPD0)
        AND	1CH
        RET	Z
        JP	M,J75D7
        PUSH	AF
        CALL	C76BA
        POP	AF
        DEC	E
        JR	NZ,J7570
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

J75D7:	LD	A,02H	; 2
        SCF
        RET

;	  Subroutine __________________________
;	     Inputs  ________________________
;	     Outputs ________________________
C75DB:	PUSH	AF
        PUSH	BC
        PUSH	HL
        CALL	GETWRK
        POP	HL
        POP	BC
        POP	AF
        CP	02H	; 2
        JR	C,J75EC
J75E8:	LD	A,0CH	; 12
        SCF
        RET

J75EC:	PUSH	AF
        LD	A,C
        CP	0FCH
        JR	NC,J75F5
        POP	AF
        JR	J75E8

J75F5:	EX	(SP),HL
        PUSH	HL
        PUSH	BC
        CALL	C76CB
        BIT	1,C
        LD	C,E
        LD	B,D
        LD	DE,8
        JR	NZ,J7605
        INC	DE
J7605:	CALL	DIV16
        LD	A,L
        INC	A
        OUT	(WDPD2),A
        LD	L,C
        POP	BC
        POP	AF
        LD	H,A
        LD	A,(IX+7)
        DEC	A			; single drive ?
        JR	Z,J7617			; yep, use drive 0
        LD	A,H
J7617:	ADD	A,1			; drive 0 -> b1=0,b0=1  drive 1 -> b1=1,b0=0
        BIT	0,C			; double sided media ?
        JR	Z,J7623			; nope, side 0
        SRL	L
        JR	NC,J7623
        OR	04H			; side 1
J7623:	LD	D,A
        LD	A,C
        RRCA
        RRCA
        AND	0C0H
        OR	D
        LD	D,A
        CALL	DISINT
        DI
        OUT	(WDPD5),A		; select drive and side (motor on)
        LD	A,(IX+0)
        AND	A
        LD	(IX+0),0FFH
        EI
        CALL	ENAINT
        LD	C,L
        LD	A,(IX+7)
        DEC	A			; single drive ?
        JR	Z,J7667			; yep,
        LD	A,(IX+3)
        CP	H			; same drive as last ?
        JR	Z,J767B			; yep, skip setting the track register
        XOR	01H
        LD	(IX+3),A
        IN	A,(WDPD1)
        JR	Z,J765B
        LD	(IX+4),A
        LD	A,(IX+5)
        JR	J7661

J765B:	LD	(IX+5),A
        LD	A,(IX+4)
J7661:	OUT	(WDPD1),A
        EX	(SP),HL
        EX	(SP),HL
        JR	J767D

J7667:	LD	A,H
        CP	(IX+6)			; same phantom drive as last ?
        LD	(IX+6),A
        JR	Z,J767B			; yep, no need to prompt
        PUSH	IX
        PUSH	DE
        PUSH	BC
        CALL	PROMPT
        POP	BC
        POP	DE
        POP	IX
J767B:	IN	A,(WDPD1)
J767D:	CP	C			; head on the right track ?
        CALL	NZ,C76C0		; nope, seek to track
        POP	HL
        RET

;	  Subroutine __________________________
;	     Inputs  ________________________
;	     Outputs ________________________
C7683:	CALL	C76CB
        INC	H
        INC	H
        IN	A,(WDPD2)
        INC	A
        OUT	(WDPD2),A
        BIT	7,D
        JR	NZ,J7694
        CP	0AH	; 10
        RET	C
J7694:	CP	09H	; 9
        RET	C
        LD	A,01H	; 1
        OUT	(WDPD2),A
        BIT	6,D
        JR	Z,J76A9
        BIT	2,D
        JR	NZ,J76A9
        SET	2,D
        LD	A,D
        OUT	(WDPD5),A
        RET

J76A9:	RES	2,D
        LD	A,D
        OUT	(WDPD5),A
        INC	C
        CALL	C76CB
        LD	A,59H	; "Y"
        OUT	(WDPD0),A
        EX	(SP),HL
        EX	(SP),HL
        JR	C76CB

;	  Subroutine __________________________
;	     Inputs  ________________________
;	     Outputs ________________________
C76BA:	BIT	0,E
        RET	NZ
        CALL	C76D1
;
;	  Subroutine __________________________
;	     Inputs  ________________________
;	     Outputs ________________________
C76C0:	LD	A,C
        OUT	(WDPD3),A
        EX	(SP),HL
        EX	(SP),HL
        LD	A,19H
J76C7:	OUT	(WDPD0),A
        EX	(SP),HL
        EX	(SP),HL
;	  Subroutine __________________________
;	     Inputs  ________________________
;	     Outputs ________________________
C76CB:	IN	A,(WDPD0)
        RRA
        JR	C,C76CB
        RET

;	  Subroutine __________________________
;	     Inputs  ________________________
;	     Outputs ________________________
C76D1:	CALL	C76CB
        LD	A,09H	; 9
        JR	J76C7

INIHRD:
C76D8:	LD	A,0D0H
        OUT	(WDPD0),A
        EX	(SP),HL
        EX	(SP),HL
        LD	A,01H	; 1
        CALL	C76EC
        LD	A,02H	; 2
        CALL	C76EC
        XOR	A
        OUT	(WDPD5),A
        RET

;	  Subroutine __________________________
;	     Inputs  ________________________
;	     Outputs ________________________
C76EC:	OUT	(WDPD5),A
        CALL	C76CB
        LD	A,09H	; 9
        OUT	(WDPD0),A
        EX	(SP),HL
        EX	(SP),HL
        LD	HL,0
J76FA:	IN	A,(WDPD0)
        RRA
        RET	NC
        DEC	HL
        LD	A,L
        OR	H
        JR	NZ,J76FA
        RET

DRIVES:
C7704:	PUSH	BC
        PUSH	AF
        CALL	GETWRK
        LD	A,02H	; 2
        OUT	(WDPD5),A
        CALL	C76CB
        LD	A,09H	; 9
        OUT	(WDPD0),A
        EX	(SP),HL
        EX	(SP),HL
        LD	HL,0
J7719:	IN	A,(WDPD0)
        RRA
        JR	NC,J7725
        DEC	HL
        LD	A,L
        OR	H
        JR	NZ,J7719
        INC	L
        JP	Z,J$022E
J7725	EQU	$-2
        LD	(IX+7),L
        XOR	A
        OUT	(WDPD5),A
        POP	AF
        JR	Z,J7732
        LD	L,02H	; 2
J7732:	POP	BC
        RET

INIENV:
C7734:	CALL	GETWRK
        XOR	A
        LD	B,7
J773A:	LD	(HL),A
        INC	HL
        DJNZ	J773A
        LD	HL,I$7744
        JP	SETINT

I$7744:	PUSH	AF
        CALL	GETWRK
        LD	A,(HL)
        AND	A
        JR	Z,J7756
        CP	0FFH
        JR	Z,J7756
        DEC	A
        LD	(HL),A
        JR	NZ,J7756
        OUT	(WDPD5),A
J7756:	INC	HL
        LD	A,(HL)
        AND	A
        JR	Z,J775C
        DEC	(HL)
J775C:	INC	HL
        LD	A,(HL)
        AND	A
        JR	Z,J7762
        DEC	(HL)
J7762:	POP	AF
        JP	PRVINT

DSKCHG:
C7766:	NOP
        PUSH	HL
        PUSH	BC
        PUSH	AF
        CALL	GETWRK
        POP	AF
        POP	BC
        POP	HL
        LD	B,(IX+7)
        DEC	B
        JR	NZ,J7781
        LD	B,(IX+6)
        CP	B
        JR	Z,J7787
        SCF
        LD	B,01H	; 1
        JR	J7790

J7781:	AND	A
        LD	B,(IX+2)
        JR	NZ,J778A
J7787:	LD	B,(IX+1)
J778A:	AND	A
        INC	B
        DEC	B
        LD	B,01H	; 1
        RET	NZ
J7790:	PUSH	AF
        PUSH	BC
        PUSH	HL
        LD	DE,1
        LD	HL,(_SECBUF)
        CALL	C7527
        JR	C,J77BD
        LD	HL,(_SECBUF)
        LD	B,(HL)
        POP	HL
        PUSH	BC
        CALL	C77C1
        LD	A,0CH	; 12
        JR	C,J77BD
        POP	DE
        POP	BC
        POP	AF
        JR	NC,J77B4
        AND	A
        LD	B,0FFH
        RET

J77B4:	LD	A,D
        CP	C
        SCF
        CCF
        LD	B,0FFH
        RET	NZ
        INC	B
        RET

J77BD:	POP	DE
        POP	DE
        POP	DE
        RET

;	  Subroutine __________________________
;	     Inputs  ________________________
;	     Outputs ________________________

GETDPB:
C77C1:	NOP
        EX	DE,HL
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
        LD	BC,I$7405
        ADD	HL,BC
        LD	BC,18
        LDIR
        RET

CHOICE:
C77DC:	LD	HL,0
        RET

DSKFMT:
C77E0:	PUSH	DE
        LD	A,D
        CP	02H	; 2
        JP	NC,J783B
        LD	DE,0
        LD	C,0FCH
        CALL	C75DB
        PUSH	DE
        CALL	DISINT
        DI
        CALL	C76D1
        IN	A,(WDPD0)
        AND	04H	; 4
        JP	Z,J7840
        CALL	GETWRK
        XOR	A
        LD	(IX+8),A
        LD	E,A
        LD	A,04H	; 4
J7808:	PUSH	AF
        CALL	C7959
        POP	AF
        DEC	A
        JP	NZ,J7808
J7811:	LD	B,03H	; 3
        PUSH	BC
J7814:	CALL	C7959
        IN	A,(WDPD0)
        AND	5CH	; "\"
        POP	BC
        JP	Z,J7851
        DEC	B
        PUSH	BC
        JP	NZ,J7814
        POP	BC
        POP	DE
J7826:	POP	DE
        SCF
        LD	B,A
        BIT	6,B
        LD	A,00H
        RET	NZ
        BIT	4,B
        LD	A,08H	; 8
        RET	NZ
        BIT	3,B
        LD	A,04H	; 4
        RET	NZ
        LD	A,10H	; 16
        RET

J783B:	POP	DE
        SCF
        LD	A,0CH	; 12
        RET

J7840:	POP	DE
J7841:	POP	DE
        SCF
        LD	A,06H	; 6
        RET

J7846:	POP	DE
J7847:	POP	DE
        POP	DE
J7849:	POP	DE
        CP	0CH	; 12
        RET	NZ
        LD	A,10H	; 16
        SCF
        RET

J7851:	LD	HL,I.00C8
J7854:	DEC	HL
        LD	A,H
        OR	L
        JP	NZ,J7854
        LD	A,(IX+8)
        INC	A
        CP	28H	; "("
        JP	Z,J7875
        LD	(IX+8),A
        CALL	C76CB
        LD	A,59H	; "Y"
        OUT	(WDPD0),A
        EX	(SP),HL
        EX	(SP),HL
        CALL	C76CB
        JP	J7811

J7875:	POP	DE
        JP	J78C9

?.7879:	LD	A,D
        OR	04H	; 4
        OUT	(WDPD5),A
        CALL	C76D1
        IN	A,(WDPD0)
        AND	04H	; 4
        JP	Z,J7841
        XOR	A
        LD	(IX+8),A
        LD	E,01H	; 1
J788E:	LD	B,03H	; 3
        PUSH	BC
J7891:	CALL	C7959
        IN	A,(WDPD0)
        AND	5CH	; "\"
        POP	BC
        JP	Z,J78A5
        DEC	B
        PUSH	BC
        JP	NZ,J7891
        POP	BC
        JP	J7826

J78A5:	LD	HL,I.00C8
J78A8:	DEC	HL
        LD	A,H
        OR	L
        JP	NZ,J78A8
        LD	A,(IX+8)
        INC	A
        CP	28H	; "("
        JP	Z,J78C9
        LD	(IX+8),A
        CALL	C76CB
        LD	A,59H	; "Y"
        OUT	(WDPD0),A
        EX	(SP),HL
        EX	(SP),HL
        CALL	C76CB
        JP	J788E

J78C9:	CALL	C76D1
        IN	A,(WDPD0)
        AND	04H	; 4
        JP	Z,J7841
        LD	HL,I$7AC5
        LD	DE,(_SECBUF)
        LD	BC,I$00C5
        LDIR
        LD	BC,I$013B
J78E2:	XOR	A
        LD	(DE),A
        INC	DE
        DEC	BC
        LD	A,B
        OR	C
        JR	NZ,J78E2
        POP	DE
        PUSH	DE
        LD	A,D
        LD	HL,(_SECBUF)
        LD	DE,0
        LD	BC,I.01FC
        SCF
        CALL	C744D
        JP	C,J7849
        LD	B,00H
        LD	DE,(_SECBUF)
        LD	A,00H
J7905:	LD	(DE),A
        INC	DE
        DJNZ	J7905
J7909:	LD	(DE),A
        INC	DE
        DJNZ	J7909
        POP	DE
        PUSH	DE
        LD	A,D
        LD	B,08H	; 8
        LD	DE,2
J7915:	PUSH	AF
        PUSH	DE
        PUSH	BC
        LD	HL,(_SECBUF)
        LD	BC,I.01FC
        SCF
        CALL	C744D
        JP	C,J7846
        POP	BC
        POP	DE
        POP	AF
        INC	DE
        DJNZ	J7915
        LD	DE,(_SECBUF)
        LD	A,0FCH
        LD	(DE),A
        INC	DE
        LD	A,0FFH
        LD	(DE),A
        INC	DE
        LD	(DE),A
        POP	DE
        LD	A,D
        LD	B,02H	; 2
        LD	DE,1
J793F:	PUSH	AF
        PUSH	DE
        PUSH	BC
        LD	HL,(_SECBUF)
        LD	BC,I.01FC
        SCF
        CALL	C744D
        JP	C,J7847
        POP	BC
        POP	DE
        POP	AF
        INC	DE
        INC	DE
        DJNZ	J793F
        JP	J7454

;	  Subroutine __________________________
;	     Inputs  ________________________
;	     Outputs ________________________
C7959:	CALL	DISINT
        DI
        CALL	C7ABD
        LD	A,0FCH
        LD	D,01H	; 1
        OUT	(WDPD0),A
        EX	(SP),HL
        EX	(SP),HL
        LD	C,4EH	; "N"
        LD	B,60H	; "`"
J796C:	IN	A,(WDPD4)
        ADD	A,A			; IRQ ?
        RET	C			; yep,
        JP	M,J796C
        LD	A,C
        OUT	(WDPD3),A
        DJNZ	J796C
        LD	C,00H
        LD	B,0CH	; 12
J797C:	IN	A,(WDPD4)
        ADD	A,A
        RET	C
        JP	M,J797C
        LD	A,C
        OUT	(WDPD3),A
        DJNZ	J797C
        LD	C,0F6H
        LD	B,03H	; 3
J798C:	IN	A,(WDPD4)
        ADD	A,A
        RET	C
        JP	M,J798C
        LD	A,C
        OUT	(WDPD3),A
        DJNZ	J798C
        LD	C,0FCH
        LD	B,01H	; 1
J799C:	IN	A,(WDPD4)
        ADD	A,A
        RET	C
        JP	M,J799C
        LD	A,C
        OUT	(WDPD3),A
        DJNZ	J799C
        LD	C,4EH	; "N"
        LD	B,32H	; "2"
J79AC:	IN	A,(WDPD4)
        ADD	A,A
        RET	C
        JP	M,J79AC
        LD	A,C
        OUT	(WDPD3),A
        DJNZ	J79AC
J79B8:	LD	C,00H
        LD	B,0CH	; 12
J79BC:	IN	A,(WDPD4)
        ADD	A,A
        RET	C
        JP	M,J79BC
        LD	A,C
        OUT	(WDPD3),A
        DJNZ	J79BC
        LD	C,0F5H
        LD	B,03H	; 3
J79CC:	IN	A,(WDPD4)
        ADD	A,A
        RET	C
        JP	M,J79CC
        LD	A,C
        OUT	(WDPD3),A
        DJNZ	J79CC
        LD	C,0FEH
        INC	B
J79DB:	IN	A,(WDPD4)
        ADD	A,A
        RET	C
        JP	M,J79DB
        LD	A,C
        OUT	(WDPD3),A
        DJNZ	J79DB
        LD	A,(IX+8)
        LD	C,A
        INC	B
J79EC:	IN	A,(WDPD4)
        ADD	A,A
        RET	C
        JP	M,J79EC
        LD	A,C
        OUT	(WDPD3),A
        DJNZ	J79EC
        LD	C,E
        INC	B
J79FA:	IN	A,(WDPD4)
        ADD	A,A
        RET	C
        JP	M,J79FA
        LD	A,C
        OUT	(WDPD3),A
        DJNZ	J79FA
        LD	C,D
        INC	B
J7A08:	IN	A,(WDPD4)
        ADD	A,A
        RET	C
        JP	M,J7A08
        LD	A,C
        OUT	(WDPD3),A
        DJNZ	J7A08
        LD	C,02H	; 2
        INC	B
J7A17:	IN	A,(WDPD4)
        ADD	A,A
        RET	C
        JP	M,J7A17
        LD	A,C
        OUT	(WDPD3),A
        DJNZ	J7A17
        LD	C,0F7H
        INC	B
J7A26:	IN	A,(WDPD4)
        ADD	A,A
        RET	C
        JP	M,J7A26
        LD	A,C
        OUT	(WDPD3),A
        DJNZ	J7A26
        LD	C,4EH	; "N"
        LD	B,16H
J7A36:	IN	A,(WDPD4)
        ADD	A,A
        RET	C
        JP	M,J7A36
        LD	A,C
        OUT	(WDPD3),A
        DJNZ	J7A36
        LD	C,00H
        LD	B,0CH	; 12
J7A46:	IN	A,(WDPD4)
        ADD	A,A
        RET	C
        JP	M,J7A46
        LD	A,C
        OUT	(WDPD3),A
        DJNZ	J7A46
        LD	C,0F5H
        LD	B,03H	; 3
J7A56:	IN	A,(WDPD4)
        ADD	A,A
        RET	C
        JP	M,J7A56
        LD	A,C
        OUT	(WDPD3),A
        DJNZ	J7A56
        LD	C,0FBH
        INC	B
J7A65:	IN	A,(WDPD4)
        ADD	A,A
        RET	C
        JP	M,J7A65
        LD	A,C
        OUT	(WDPD3),A
        DJNZ	J7A65
        LD	C,0E5H
J7A73:	IN	A,(WDPD4)
        ADD	A,A
        RET	C
        JP	M,J7A73
        LD	A,C
        OUT	(WDPD3),A
        DJNZ	J7A73
J7A7F:	IN	A,(WDPD4)
        ADD	A,A
        RET	C
        JP	M,J7A7F
        LD	A,C
        OUT	(WDPD3),A
        DJNZ	J7A7F
        LD	C,0F7H
        INC	B
J7A8E:	IN	A,(WDPD4)
        ADD	A,A
        RET	C
        JP	M,J7A8E
        LD	A,C
        OUT	(WDPD3),A
        DJNZ	J7A8E
        LD	C,4EH	; "N"
        LD	B,40H	; "@"
J7A9E:	IN	A,(WDPD4)
        ADD	A,A
        RET	C
        JP	M,J7A9E
        LD	A,C
        OUT	(WDPD3),A
        DJNZ	J7A9E
        INC	D
        LD	A,D
        CP	0AH	; 10
        JP	NZ,J79B8
J7AB1:	IN	A,(WDPD4)
        ADD	A,A
        RET	C
        JP	M,J7AB1
        LD	A,C
        OUT	(WDPD3),A
        JR	J7AB1

;	  Subroutine __________________________
;	     Inputs  ________________________
;	     Outputs ________________________
C7ABD:	IN	A,(WDPD0)
        AND	01H	; 1
        JP	NZ,C7ABD
        RET

I$7AC5:	EX	DE,HL
        CP	90H
        LD	B,H
        LD	D,A
        LD	B,H
        LD	D,B
        LD	B,(HL)
        DEC	(HL)
        LD	SP,0030H
        LD	(BC),A
        LD	BC,1
        LD	(BC),A
        LD	B,B
        NOP
        LD	L,B
        LD	BC,I$02FC
        NOP
        ADD	HL,BC
        NOP
        LD	BC,0
        NOP
        RET	NC
        LD	(D$C059),DE
        LD	(D.C0C4),A
        LD	(HL),56H	; "V"
        INC	HL
        LD	(HL),0C0H
J7AF0:	LD	SP,KBUF+256
        LD	DE,I.C09F
        LD	C,0FH	; 15
        CALL	BDOS
        INC	A
        JP	Z,J$C063
        LD	DE,J.0100
        LD	C,1AH
        CALL	BDOS
        LD	HL,1
        LD	(D$C0AD),HL
        LD	HL,04000H-00100H
        LD	DE,I.C09F
        LD	C,27H	; "'"
        CALL	BDOS
        JP	J.0100

?.7B1B:	LD	E,B
        RET	NZ
        CALL	0
        LD	A,C
        AND	0FEH
        CP	02H	; 2
        JP	NZ,J$C06A
        LD	A,(D.C0C4)
        AND	A
        JP	Z,J$4022
        LD	DE,I$C079
        LD	C,09H	; 9
        CALL	BDOS
        LD	C,07H	; 7
        CALL	BDOS
        JR	J7AF0

?.7B3E:	LD	B,D
        LD	L,A
        LD	L,A
        LD	(HL),H
        JR	NZ,J7BA9
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
        JR	NZ,J7BB2
        LD	L,(HL)
        LD	A,C
        JR	NZ,J7BC0
        LD	H,L
        LD	A,C
        JR	NZ,J7BBF
        LD	L,A
        LD	(HL),D
        JR	NZ,J7BCF
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
        JR	NZ,J7B8D
        LD	D,E
        LD	E,C
        LD	D,E
        DEFB	0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0
        DEFB	0,0,0,0,0,0

OEMSTA:
C7B8A:	SCF
        RET

;	  Subroutine __________________________
;	     Inputs  ________________________
;	     Outputs ________________________
C7B8C:	PUSH	HL
J7B8D:	PUSH	DE
        PUSH	BC
        LD	HL,I$7C1D
        LD	DE,(_SECBUF)
        LD	BC,I$0108
        LDIR
        LD	HL,I$7BF3
        JR	J7BB2

;	  Subroutine __________________________
;	     Inputs  ________________________
;	     Outputs ________________________
C7BA0:	PUSH	HL
        PUSH	DE
        PUSH	BC
        LD	HL,I$7D25
        LD	DE,(_SECBUF)
J7BA9	EQU	$-1
        LD	BC,I$010C
        LDIR
        LD	HL,I$7BD3
J7BB2:	LD	E,(HL)
        INC	HL
        LD	D,(HL)
        INC	HL
        LD	A,E
        OR	D
        JR	Z,J7BCF
        PUSH	HL
        LD	HL,(_SECBUF)
        ADD	HL,DE
J7BBF:	INC	HL
J7BC0:	LD	C,(HL)
        INC	HL
        LD	B,(HL)
        EX	DE,HL
        LD	HL,(_SECBUF)
        ADD	HL,BC
        EX	DE,HL
        LD	(HL),D
        DEC	HL
        LD	(HL),E
        POP	HL
        JR	J7BB2

J7BCF:	POP	BC
        POP	DE
        POP	HL
        RET

I$7BD3:	LD	B,00H
        JR	NZ,J7BD7
J7BD7:	DEC	H
        NOP
        DEC	L
        NOP
        DEC	SP
        NOP
        LD	B,D
        NOP
        LD	D,L
        NOP
        LD	E,D
        NOP
        LD	H,D
        NOP
        ADC	A,(HL)
        NOP
        SUB	H
        NOP
        OR	A
        NOP
        EX	(SP),HL
        NOP
        POP	AF
        NOP
        DEC	B
        LD	BC,0
I$7BF3:	LD	B,00H
        JR	NZ,J7BF7
J7BF7:	DEC	H
        NOP
        DEC	L
        NOP
        CCF
        NOP
        LD	B,H
        NOP
        LD	C,B
        NOP
        LD	D,H
        NOP
        LD	E,E
        NOP
        LD	H,D
        NOP
        LD	(HL),L
        NOP
        LD	A,D
        NOP
        LD	A,(HL)
        NOP
        OR	E
        NOP
        RST	18H
        NOP
        DEFB	0EDH		; << Illegal Op Code Byte >>

        NOP
        LD	BC,1
        NOP
;	  Subroutine __________________________
;	     Inputs  ________________________
;	     Outputs ________________________
C7C17:	PUSH	HL
        LD	HL,(_SECBUF)
        EX	(SP),HL
        RET

I$7C1D:	PUSH	HL
        PUSH	DE
        PUSH	BC
        CALL	GETSLT
        LD	(D$00A7),A
        LD	H,80H
        CALL	ENASLT
        NOP
        LD	A,(RAMAD1)
        LD	H,40H	; "@"
        CALL	ENASLT
        NOP
        POP	BC
        POP	DE
        POP	HL
J7C38:	DEC	HL
        LD	A,H
        ADD	A,02H	; 2
        INC	HL
        JP	M,J$0099
        LD	E,15H
J7C42:	CALL	C.00FB
        LD	A,88H
        PUSH	HL
        PUSH	DE
        PUSH	BC
        LD	DE,I$0065
        PUSH	DE
        CALL	DISINT
        DI
        OUT	(WDPD0),A
        LD	DE,0
        LD	B,03H	; 3
J7C59:	IN	A,(WDPD4)
        ADD	A,A
        JP	P,J$0054
        RET	C
        DEC	E
        JP	NZ,J.003C
        DEC	D
        JP	NZ,J.003C
        DEC	B
        JR	NZ,J7C59
        POP	BC
        POP	BC
        POP	DE
        POP	HL
        JR	J7CB3

?.7C71:	JP	J$005E

?.7C74:	IN	A,(WDPD4)
        ADD	A,A
        RET	C
        JP	M,J.0057
        IN	A,(WDPD3)
        LD	(HL),A
        INC	HL
        JP	J.0057

?.7C82:	POP	BC
        POP	DE
        POP	HL
        EI
        CALL	ENAINT
        IN	A,(WDPD0)
        AND	1CH
        JR	NZ,J7C97
        DEC	B
        JR	Z,J7CB6
        CALL	C$00B3
        JR	J7C38

J7C97:	JP	M,J$0096
        PUSH	AF
        CALL	C$00EA
        POP	AF
        DEC	E
        JR	NZ,J7C42
        LD	E,A
        BIT	4,E
        LD	A,08H	; 8
        JR	NZ,J7CB5
        BIT	3,E
        LD	A,04H	; 4
        JR	NZ,J7CB5
        LD	A,0CH	; 12
        JR	J7CB5

J7CB3:	LD	A,02H	; 2
J7CB5:	SCF
J7CB6:	PUSH	HL
        PUSH	DE
        PUSH	BC
        PUSH	AF
        LD	A,(RAMAD2)
        LD	H,80H
        CALL	ENASLT
        NOP
        LD	A,00H
        LD	H,40H	; "@"
        CALL	ENASLT
        NOP
        POP	AF
        POP	BC
        POP	DE
        POP	HL
        RET

?.7CD0:	CALL	C.00FB
        INC	H
        INC	H
        IN	A,(WDPD2)
        INC	A
        OUT	(WDPD2),A
        BIT	7,D
        JR	NZ,J7CE1
        CP	0AH	; 10
        RET	C
J7CE1:	CP	09H	; 9
        RET	C
        LD	A,01H	; 1
        OUT	(WDPD2),A
        BIT	6,D
        JR	Z,J7CF6
        BIT	2,D
        JR	NZ,J7CF6
        SET	2,D
        LD	A,D
        OUT	(WDPD5),A
        RET

J7CF6:	RES	2,D
        LD	A,D
        OUT	(WDPD5),A
        INC	C
        CALL	C.00FB
        LD	A,59H	; "Y"
        OUT	(WDPD0),A
        EX	(SP),HL
        EX	(SP),HL
        JR	J7D18

?.7D07:	BIT	0,E
        RET	NZ
        CALL	C$0101
        LD	A,C
        OUT	(WDPD3),A
        EX	(SP),HL
        EX	(SP),HL
        LD	A,19H
J7D14:	OUT	(WDPD0),A
        EX	(SP),HL
        EX	(SP),HL
J7D18:	IN	A,(WDPD0)
        RRA
        JR	C,J7D18
        RET

?.7D1E:	CALL	C.00FB
        LD	A,09H	; 9
        JR	J7D14

I$7D25:	PUSH	HL
        PUSH	DE
        PUSH	BC
        CALL	GETSLT
        LD	(D$00AB),A
        LD	H,80H
        CALL	ENASLT
        NOP
        LD	A,(RAMAD1)
        LD	H,40H	; "@"
        CALL	ENASLT
        NOP
        POP	BC
        POP	DE
        POP	HL
J7D40:	DEC	HL
        LD	A,H
        ADD	A,02H	; 2
        INC	HL
        JP	M,J$009D
        LD	E,15H
J7D4A:	CALL	C.00FF
        LD	A,0A8H
        PUSH	HL
        PUSH	DE
        PUSH	BC
        LD	DE,I$0045
        PUSH	DE
        CALL	DISINT
        DI
        OUT	(WDPD0),A
        IN	A,(WDPD4)
        ADD	A,A
        RET	C
        JP	M,J.0037
        LD	A,(HL)
        OUT	(WDPD3),A
        INC	HL
        JP	J.0037

?.7D6A:	POP	BC
        POP	DE
        POP	HL
        EI
        CALL	ENAINT
        IN	A,(WDPD0)
        AND	5CH	; "\"
        JR	NZ,J7D7F
        DEC	B
        JR	Z,J7DC2
        CALL	C$00B7
        JR	J7D40

J7D7F:	JP	M,J$0097
        BIT	6,A
        JR	NZ,J7D9F
        PUSH	AF
        CALL	C$00EE
        POP	AF
        DEC	E
        JR	NZ,J7D4A
        LD	E,A
        BIT	4,E
        LD	A,08H	; 8
        JR	NZ,J7DC1
        BIT	3,E
        LD	A,04H	; 4
        JR	NZ,J7DC1
        LD	A,0CH	; 12
        JR	J7DC1

J7D9F:	LD	A,0D0H
        OUT	(WDPD0),A
        EX	(SP),HL
        EX	(SP),HL
        LD	A,88H
        OUT	(WDPD0),A
        EX	(SP),HL
        EX	(SP),HL
        LD	DE,0
        IN	A,(WDPD4)
        ADD	A,A
        JR	C,J7DC0
        JP	P,J$009B
        DEC	DE
        LD	A,E
        OR	D
        JP	NZ,J$0089
        LD	A,02H	; 2
        JR	J7DC1

J7DC0:	XOR	A
J7DC1:	SCF
J7DC2:	PUSH	HL
        PUSH	DE
        PUSH	BC
        PUSH	AF
        LD	A,(RAMAD2)
        LD	H,80H
        CALL	ENASLT
        NOP
        LD	A,00H
        LD	H,40H	; "@"
        CALL	ENASLT
        NOP
        POP	AF
        POP	BC
        POP	DE
        POP	HL
        RET

?.7DDC:	CALL	C.00FF
        INC	H
        INC	H
        IN	A,(WDPD2)
        INC	A
        OUT	(WDPD2),A
        BIT	7,D
        JR	NZ,J7DED
        CP	0AH	; 10
        RET	C
J7DED:	CP	09H	; 9
        RET	C
        LD	A,01H	; 1
        OUT	(WDPD2),A
        BIT	6,D
        JR	Z,J7E02
        BIT	2,D
        JR	NZ,J7E02
        SET	2,D
        LD	A,D
        OUT	(WDPD5),A
        RET

J7E02:	RES	2,D
        LD	A,D
        OUT	(WDPD5),A
        INC	C
        CALL	C.00FF
        LD	A,59H	; "Y"
        OUT	(WDPD0),A
        EX	(SP),HL
        EX	(SP),HL
        JR	J7E24

?.7E13:	BIT	0,E
        RET	NZ
        CALL	C$0105
        LD	A,C
        OUT	(WDPD3),A
        EX	(SP),HL
        EX	(SP),HL
        LD	A,19H
J7E20:	OUT	(WDPD0),A
        EX	(SP),HL
        EX	(SP),HL
J7E24:	IN	A,(WDPD0)
        RRA
        JR	C,J7E24
        RET

?.7E2A:	CALL	C.00FF
        LD	A,09H	; 9
        JR	J7E20

        DEFS	08000H-$,0

WDPD0	EQU	0D0H			; WD179x
WDPD1	EQU	0D1H			; WD179x
WDPD2	EQU	0D2H			; WD179x
WDPD3	EQU	0D3H			; WD179x
WDPD4	EQU	0D4H			; R b7 = IRQ (1 = IRQ)
                                        ; R b6 = DRQ (0 = DRQ)
WDPD5	EQU	0D5H			; W b2 = side select
                                        ; W b1 = drive select B
                                        ; W b0 = drive select A
        END
