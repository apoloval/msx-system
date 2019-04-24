; Diskdriver Sony HBK-30 (external floppydisk controller)
; FDC	WD2793
; extra	SONY hardware (CXD1032Q) for Disk Change

; Source re-created by Z80DIS 2.2
; Z80DIS was written by Kenneth Gielow, Palo Alto, CA

; Code Copyrighted by SONY and maybe others
; Source comments by Arjen Zeilemaker

; Sourcecode supplied for STUDY ONLY
; Recreation NOT permitted without authorisation of the copyrightholders

MYSIZE		equ	9
SECLEN		equ	512

J4022	EQU	4022H	; J----
BDOS	EQU	0F37DH	; -C---

I7405:
        .PHASE	0C000H

        DEFB	0EBH			; x86 JMP +0100H
        DEFB	0FEH
        DEFB	090H			; x86 NOP
        DEFB	"SNYJX101"
        DEFW	512
        DEFB	2
        DEFW	1
        DEFB	2
        DEFW	112
        DEFW	05A0H
        DEFB	0F9H
        DEFW	3
        DEFW	9
        DEFW	2
        DEFW	0

        RET	NC
        LD	(DC058+1),DE
        LD	(DC0C4),A
        LD	(HL),LOW DC056
        INC	HL
        LD	(HL),HIGH DC056
J7430:	LD	SP,KBUF+256
        LD	DE,DC09F
        LD	C,0FH
        CALL	BDOS
        INC	A
        JP	Z,DC063
        LD	DE,0100H
        LD	C,1AH
        CALL	BDOS
        LD	HL,1
        LD	(DC09F+14),HL
        LD	HL,04000H-0100H
        LD	DE,DC09F
        LD	C,27H
        CALL	BDOS
        JP	0100H

DC056:	DEFW	DC058

DC058:	CALL	0
        LD	A,C
        AND	0FEH
        CP	02H
        JP	NZ,DC06A
DC063:	LD	A,(DC0C4)
        AND	A
        JP	Z,J4022
DC06A:	LD	DE,DC079
        LD	C,09H
        CALL	BDOS
        LD	C,07H
        CALL	BDOS
        JR	J7430

DC079:	DEFB	"Boot error",13,10
        DEFB	"Press any key for retry",13,10
        DEFB	"$"

DC09F:	DEFB	0
        DEFB	"MSXDOS  SYS"
        DEFW	0
        DEFW	0
        DEFB	0,0,0,0
        DEFW	0
        DEFW	0
        DEFB	0
        DEFB	0
        DEFW	0
        DEFW	0
        DEFW	0
        DEFB	0
        DEFB	0,0,0,0

DC0C4:	DEFB	0

        .DEPHASE

L7405	EQU	$-I7405

I74CA:

; Only supports 3.5 media

	DEFB	0F8H
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

DEFDPB	EQU	$-1

        DEFB	0F9H
        DEFW	512
        DEFB	0FH
        DEFB	04H
        DEFB	01H
        DEFB	02H
        DEFW	1
        DEFB	2
        DEFB	112
        DEFW	14
        DEFW	714
        DEFB	3
        DEFW	7

        DEFB	0FAH
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

        DEFB	0FBH
        DEFW	512
        DEFB	0FH
        DEFB	04H
        DEFB	01H
        DEFB	02H
        DEFW	1
        DEFB	2
        DEFB	112
        DEFW	10
        DEFW	635
        DEFB	2
        DEFW	5

DSKIO:	JP	J7530
INIHRD:	JP	J7875
DRIVES:	JP	J78B4
INIENV:	JP	J78E9
DSKCHG:	JP	J790D
GETDPB:	JP	J798C
CHOICE:	JP	J79A6
DSKFMT:	JP	J79F7
OEMSTA:	JP	J7E53
MTOFF:	JP	J7E55

J7530:	PUSH	AF
        JP	NC,J7633		; read DSKIO
        CALL	C756D			; do write DSKIO
J7537:	POP	DE
        PUSH	AF
        LD	C,1
        JR	NC,J753F
        LD	C,0
J753F:	LD	A,0D0H
        LD	(D7FF8),A		; execute terminate without interrupt command
        EX	(SP),HL
        EX	(SP),HL
        EX	(SP),HL
        EX	(SP),HL
        LD	A,(D7FFB)		; reset DRQ
        LD	A,D
        AND	A			; drive 0 ?
        JR	NZ,J755E		; nope, drive 1
        LD	A,3CH
        LD	(D7FFD),A		; motor off, not in use, leave disk change, select drive 0
        LD	A,03H
        LD	(D7FFD),A		; motor off, not in use, unselect drive
        LD	(IX+1),C
        POP	AF
        RET

J755E:	LD	A,3DH
        LD	(D7FFD),A		; motor off, not in use, leave disk change, select drive 1
        LD	A,03H
        LD	(D7FFD),A		; motor off, not in use, unselect drive
        LD	(IX+2),C
        POP	AF
        RET

;	  Subroutine do write DSKIO
;	     Inputs  ________________________
;	     Outputs ________________________

C756D:	CALL	C76F8			; initialise for disk i/o
        RET	C
J7571:	LD	A,H
        AND	A			; transfer from page 0/1 ?
        JP	M,J7593			; nope, use disk i/o routines directly
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
        CALL	C759E			; write sector
        POP	HL
        RET	C			; error, quit
        DEC	B			; sectors left ?
        RET	Z			; nope, quit
        CALL	C77ED			; setup for next sector
        JR	J7571

J7593:	CALL	C759E			; write sector
        RET	C
        DEC	B			; sectors left ?
        RET	Z			; nope, quit
        CALL	C77ED			; setup for next sector
        JR	J7593

;	  Subroutine write sector
;	     Inputs  ________________________
;	     Outputs ________________________

C759E:	LD	E,10
J75A0:	CALL	C7849			; wait for command ready
        LD	A,0A0H			; WRITE SECTOR
        BIT	6,D
        JR	Z,J75B1
        OR	02H
        BIT	0,D
        JR	Z,J75B1
        OR	08H
J75B1:	PUSH	HL
        PUSH	DE
        PUSH	BC
        LD	DE,I75D3
        PUSH	DE
        CALL	DISINT
        DI
        LD	(D7FF8),A
        EX	(SP),HL
        EX	(SP),HL
        LD	BC,D7FFF
        LD	DE,D7FFB
J75C7:	LD	A,(BC)
        ADD	A,A
        RET	P
        JP	C,J75C7
        LD	A,(HL)
        LD	(DE),A
        INC	HL
        JP	J75C7

I75D3:	POP	BC
        POP	DE
        POP	HL
        EI
        CALL	ENAINT
        LD	A,(D7FF8)
        AND	0FCH
        RET	Z
        JP	M,J762C
        BIT	6,A
        JR	NZ,J760B
        PUSH	AF
        LD	A,(IX+3)
        OR	0C4H
        LD	(D7FFD),A               ; motor on, in use led on, leave diskchange, select drive
        CALL	C782F			; reseek every 2nd try
        POP	AF
        DEC	E
        JR	NZ,J75A0
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

J760B:	LD	A,0D0H
        LD	(D7FF8),A		; execute FORCE INTERRUPT (IMMEDIATE) command
        EX	(SP),HL
        EX	(SP),HL
        LD	A,80H
        LD	(D7FF8),A		; execute READ SECTOR command
        EX	(SP),HL
        EX	(SP),HL
        LD	HL,D7FFF
        LD	DE,0
J761F:	LD	A,(HL)
        ADD	A,A
        JP	P,J7630
        JR	NC,J7630
        DEC	DE
        LD	A,E
        OR	D
        JP	NZ,J761F
J762C:	LD	A,02H
        SCF
        RET

J7630:	XOR	A
        SCF
        RET

J7633:	CALL	C7639			; do read DSKIO
        JP	J7537

;	  Subroutine do read DSKIO
;	     Inputs  ________________________
;	     Outputs ________________________

C7639:	CALL	C76F8			; initialise for disk i/o
        RET	C
J763D:	LD	A,H
        AND	A			; transfer to page 0/1 ?
        JP	M,J7665			; nope, use disk i/o routines directly
        PUSH	HL
        LD	HL,(_SECBUF)
        CALL	C7670			; read sector
        POP	HL
        RET	C			; error, quit
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
        RET	C			; ??
        DEC	B			; sectors left ?
        RET	Z			; nope, quit
        CALL	C77ED			; setup for next sector
        JP	J763D

J7665:	CALL	C7670			; read sector
        RET	C			; error, quit
        DEC	B			; sectors left ?
        RET	Z			; nope, quit
        CALL	C77ED			; setup for next sector
        JR	J7665

;	  Subroutine read sector
;	     Inputs  ________________________
;	     Outputs ________________________

C7670:	LD	E,10
J7672:	CALL	C7849			; wait for command ready
        LD	A,80H			; READ SECTOR
        BIT	6,D
        JR	Z,J7683
        OR	02H
        BIT	0,D
        JR	Z,J7683
        OR	08H
J7683:	PUSH	HL
        PUSH	DE
        PUSH	BC
        LD	BC,D7FFF
        LD	DE,I76C5
        PUSH	DE
        CALL	DISINT
        DI
        LD	(D7FF8),A
        EX	(SP),HL
        EX	(SP),HL
        LD	DE,0
J7699:	LD	A,(BC)
        ADD	A,A
        JP	NC,J76B3
        RET	P
        LD	A,(BC)
        ADD	A,A
        JP	NC,J76B3
        RET	P
        DEC	E
        JP	NZ,J7699
        DEC	D
        JP	NZ,J7699
        POP	BC
        POP	BC
        POP	DE
        POP	HL
        JR	J76F4
J76B3:	LD	DE,D7FFB
        JP	J76BF
J76B9:	LD	A,(BC)
        ADD	A,A
        RET	P
        JP	C,J76B9
J76BF:	LD	A,(DE)
        LD	(HL),A
        INC	HL
        JP	J76B9
I76C5:	POP	BC
        POP	DE
        POP	HL
        EI
        CALL	ENAINT
        LD	A,(D7FF8)
        AND	9CH
        RET	Z
        JP	M,J76F4
        PUSH	AF
        LD	A,(IX+3)
        OR	0C4H
        LD	(D7FFD),A               ; motor on, in use led on, leave diskchange, select drive
        CALL	C782F			; reseek every 2nd try
        POP	AF
        DEC	E
        JR	NZ,J7672
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

J76F4:	LD	A,02H
        SCF
        RET

;	  Subroutine initialise for disk i/o
;	     Inputs  ________________________
;	     Outputs ________________________

C76F8:	PUSH	AF
        PUSH	BC
        PUSH	HL
        CALL	GETWRK
        POP	HL
        POP	BC
        POP	AF
        CP	02H			; drive 0-1 ?
        JR	C,J7709			; yep, continue

J7705:	LD	A,0CH
        SCF
        RET

J7709:	PUSH	AF
        LD	A,C
        CP	0F8H			; mediadescriptor 0F8H-0FFH ?
        JR	NC,J7712
        POP	AF
        JR	J7705			; nope, quit with OTHER error

J7712:	EX	(SP),HL
        PUSH	HL
        PUSH	BC
        XOR	A
        BIT	0,C			; double sided media (0F9H,0FBH,0FDH or 0FFH) ?
        JR	NZ,J771E		; yep,
        LD	(D7FFC),A		; select side 0
        INC	A
J771E:	DEC	A
        PUSH	AF
        CALL	C7849			; wait for command ready
        BIT	1,C			; 8 sectors per track ?
        LD	C,E
        LD	B,D
        LD	DE,8
        JR	NZ,J772D		; yep, track = sector / 8
        INC	DE			; nope, track = sector / 9
J772D:	CALL	DIV16
        LD	A,L
        INC	A			; sector is 1 based
        LD	(D7FFA),A		; sector
        POP	AF
        AND	A			; double sided media ?
        JR	Z,J7746			; nope, side register already set
        XOR	A
        LD	(D7FFC),A		; select side 0
        SRL	C			; cylinder
        JR	NC,J7746
        LD	A,1
        LD	(D7FFC),A		; select side 1
J7746:	LD	L,C
        POP	BC
        POP	AF
        LD	H,A
        LD	A,(IX+8)
        DEC	A			; 1 physical drive ?
        JR	Z,J7751			; yep, use drive 0
        LD	A,H			; nope, use driveid
J7751:	OR	0C4H
        CALL	DISINT
        DI
        LD	(D7FFD),A		; motor on, in use led on, leave diskchange, select drive
        LD	A,(D7FF8)
        AND	80H			; drive ready ?
        EI
        CALL	ENAINT
        JR	Z,J7768			; yep, no need to wait for motor spin up
        CALL	C7863			; wait motor spin up time
J7768:	LD	A,C
        RRCA
        RRCA
        AND	0C0H
        LD	D,A
        LD	A,(D7FFC)
        AND	01H			; which side is selected ?
        OR	D
        LD	D,A
        LD	C,L
        LD	A,(IX+8)
        DEC	A			; 1 physical drive ?
        JR	Z,J77A1			; yep, no need to set the cylinder
        LD	A,(IX+3)
        CP	H
        JR	Z,J77E4
        XOR	01H
        LD	(IX+3),A
        LD	A,(D7FF9)
        JR	Z,J7794
        LD	(IX+4),A
        LD	A,(IX+5)
        JR	J779A

J7794:	LD	(IX+5),A
        LD	A,(IX+4)
J779A:	LD	(D7FF9),A
        EX	(SP),HL
        EX	(SP),HL
        JR	J77E7

J77A1:	LD	A,H
        CP	(IX+6)
        LD	(IX+6),A
        JR	Z,J77E4
        PUSH	IX
        PUSH	DE
        PUSH	BC
        LD	A,(D7FFD)
        PUSH	AF
        OR	04H			; leave diskchange
        AND	0BFH			; in use led off
        LD	(D7FFD),A
        LD	A,87H
        LD	(D7FFD),A		; motor on, in use led off, leave diskchange, unselect drive
        CALL	PROMPT
        POP	AF
        OR	04H			; leave diskchange
        LD	(D7FFD),A
        PUSH	HL
        LD	HL,0
J77CB:	INC	HL
        EX	(SP),IX
        EX	(SP),IX
        EX	(SP),IX
        EX	(SP),IX
        LD	A,H
        OR	L
        JR	Z,J77DF
        LD	A,(D7FF8)
        BIT	7,A			; drive ready ?
        JR	NZ,J77CB		; nope, wait longer
J77DF:	POP	HL
        POP	BC
        POP	DE
        POP	IX
J77E4:	LD	A,(D7FF9)
J77E7:	CP	C
        CALL	NZ,C7835		; select track
        POP	HL
        RET

;	  Subroutine setup for next sector
;	     Inputs  ________________________
;	     Outputs ________________________

C77ED:	CALL	C7849			; wait for command ready
        INC	H
        INC	H			; transfer adres + 512
        LD	A,(D7FFA)
        INC	A
        LD	(D7FFA),A		; sector + 1
        BIT	7,D
        JR	NZ,J7800
        CP	9+1
        RET	C
J7800:	CP	8+1
        RET	C
        LD	A,1
        LD	(D7FFA),A		; sector = 1
        BIT	6,D
        JR	Z,C7817			; setup for next cylinder
        BIT	0,D
        JR	NZ,C7817		; setup for next cylinder
        SET	0,D
        LD	A,D
        LD	(D7FFC),A		; select side 1
        RET

;	  Subroutine setup for next cylinder
;	     Inputs  ________________________
;	     Outputs ________________________

C7817:	RES	0,D
        LD	A,D
        LD	(D7FFC),A		; select side 0
        INC	C
        CALL	C7849			; wait for command ready
        LD	A,51H
        LD	(D7FF8),A		; execute STEP IN command
        EX	(SP),HL
        EX	(SP),HL
        CALL	C7849			; wait for command ready
        CALL	C7857			; wait head settle time
        RET

;	  Subroutine reseek every 2nd try
;	     Inputs  ________________________
;	     Outputs ________________________

C782F:	BIT	0,E
        RET	NZ
        CALL	C7850			; select track 0

;	  Subroutine select track
;	     Inputs  ________________________
;	     Outputs ________________________

C7835:	LD	A,C
        LD	(D7FFB),A
        EX	(SP),HL
        EX	(SP),HL
        LD	A,11H			; SEEK
J783D:	LD	(D7FF8),A
        EX	(SP),HL
        EX	(SP),HL
        CALL	C7849			; wait for command ready
        CALL	C7857			; wait head settle time
        RET

;	  Subroutine wait for command ready
;	     Inputs  ________________________
;	     Outputs ________________________

C7849:	LD	A,(D7FF8)
        RRA
        JR	C,C7849
        RET

;	  Subroutine select track 0
;	     Inputs  ________________________
;	     Outputs ________________________

C7850:	CALL	C7849			; wait for command ready
        LD	A,01H			; RESTORE
        JR	J783D

;	  Subroutine wait head settle time
;	     Inputs  ________________________
;	     Outputs ________________________

C7857:	PUSH	HL
        LD	HL,0DF9H
J785B:	DEC	HL
        LD	A,H
        OR	L
        JR	NZ,J785B
        POP	HL
        XOR	A
        RET

;	  Subroutine wait motor spin up time
;	     Inputs  ________________________
;	     Outputs ________________________

C7863:	PUSH	HL
        PUSH	BC
        LD	B,4
J7867:	LD	HL,07484H
J786A:	DEC	HL
        LD	A,H
        OR	L
        JR	NZ,J786A
        DJNZ	J7867
        POP	BC
        POP	HL
        XOR	A
        RET

J7875:	LD	A,0D0H
        LD	(D7FF8),A		; execute FORCE INTERRUPT (IMMEDIATE) command
        EX	(SP),HL
        EX	(SP),HL
        LD	A,00H			; motor off, in use off, reset diskchange, drive 0
        CALL	C788C
        LD	A,01H			; motor off, in use off, reset diskchange, drive 1
        CALL	C788C
        LD	A,03H
        LD	(D7FFD),A		; motor off, in use off, unselect drive
        RET

;	  Subroutine initialize drive
;	     Inputs  ________________________
;	     Outputs ________________________

C788C:	LD	(D7FFD),A
J788F:	CALL	C7817			; setup for next cylinder
        LD	A,(D7FF8)
        AND	04H			; still on track 0 ?
        JR	NZ,J788F		; yep, next cylinder
        CALL	C7849			; wait for command ready
        LD	A,01H
        LD	(D7FF8),A		; execute RESTORE command
        EX	(SP),HL
        EX	(SP),HL
        LD	HL,0
J78A6:	LD	A,(D7FF8)
        RRA				; command still busy ?
        RET	NC			; nope, quit
        DEC	HL
        LD	A,L
        OR	H
        JR	NZ,J78A6
        CALL	C7857			; wait head settle time
        RET

;	  Subroutine DRIVES
;	     Inputs  ________________________
;	     Outputs ________________________

J78B4:	PUSH	BC
        PUSH	AF
        CALL	GETWRK
        LD	A,01H
        LD	(D7FFD),A		; motor off, in use off, reset disk change, select drive 1
        CALL	C7849			; wait for command ready
        LD	A,01H
        LD	(D7FF8),A		; execute RESTORE command
        EX	(SP),HL
        EX	(SP),HL
        LD	HL,0
J78CB:	LD	A,(D7FF8)
        RRA				; command still busy ?
        JR	NC,J78D8		; nope,
        DEC	HL
        LD	A,L
        OR	H
        JR	NZ,J78CB
        INC	L
        DEFB	0CAH			; JP Z,xxxx
J78D8:	LD	L,2
        LD	(IX+8),L
        LD	A,03H
        LD	(D7FFD),A               ; motor off, in use off, leave disk change, unselect drive
        POP	AF
        JR	Z,J78E7
        LD	L,2
J78E7:	POP	BC
        RET

;	  Subroutine INIENV
;	     Inputs  ________________________
;	     Outputs ________________________

J78E9:	CALL	GETWRK
        XOR	A
        LD	B,8
J78EF:	LD	(HL),A
        INC	HL
        DJNZ	J78EF
        LD	HL,I78F9
        JP	SETINT

;	  Subroutine interrupt handler
;	     Inputs  ________________________
;	     Outputs ________________________

I78F9:	PUSH	AF
        CALL	GETWRK
        INC	HL
        LD	A,(HL)
        AND	A
        JR	Z,J7903
        DEC	(HL)
J7903:	INC	HL
        LD	A,(HL)
        AND	A
        JR	Z,J7909
        DEC	(HL)
J7909:	POP	AF
        JP	PRVINT

;	  Subroutine DSKCHG
;	     Inputs  ________________________
;	     Outputs ________________________

J790D:	PUSH	HL
        PUSH	BC
        PUSH	AF
        CALL	GETWRK
        POP	AF
        POP	BC
        POP	HL
        LD	D,A
        PUSH	DE
        AND	A
        JR	NZ,J7932
        LD	A,(D7FFD)
        LD	B,A
        PUSH	BC
        AND	0FCH
        LD	(D7FFD),A               ; leave motor, leave use led, reset diskchange, drive 0
        LD	A,(D7FFD)
        BIT	2,A                     ; disk change status drive 0
        POP	BC
        LD	A,B
        LD	(D7FFD),A
        JP	J7948

J7932:	LD	A,(D7FFD)
        LD	B,A
        PUSH	BC
        AND	0FCH
        OR	01H
        LD	(D7FFD),A               ; leave motor, leave use led, reset diskchange, drive 1
        LD	A,(D7FFD)
        BIT	2,A                     ; disk change status drive 1
        POP	BC
        LD	A,B
        LD	(D7FFD),A
J7948:	POP	DE
        LD	A,D
        LD	B,1
        PUSH	BC
        PUSH	HL
        PUSH	AF
        XOR	A
        LD	(D7FFC),A		; select side 0
        POP	AF
        PUSH	AF
        LD	DE,1
        LD	HL,(_SECBUF)
        SCF
        CCF
        CALL	DSKIO
        JR	C,J7988
        LD	HL,(_SECBUF)
        LD	B,(HL)
        LD	A,B
        CP	0F8H
        JR	C,J7981
        POP	AF
        POP	HL
        PUSH	BC
        CALL	GETDPB
        PUSH	DE
        LD	A,12
        JR	C,J7988
        POP	DE
        POP	AF
        POP	BC
        CP	C
        SCF
        CCF
        LD	B,0FFH
        RET	NZ
        INC	B
        RET

J7981:	POP	DE
        POP	DE
        POP	DE
        LD	A,10
        SCF
        RET

J7988:	POP	DE
        POP	DE
        POP	DE
        RET

;	  Subroutine GETDPB
;	     Inputs  ________________________
;	     Outputs ________________________

J798C:	EX	DE,HL
        INC	DE
        LD	A,B
        SUB	0F8H
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
        LD	BC,I74CA
        ADD	HL,BC
        LD	BC,18
        LDIR
        RET

;	  Subroutine CHOICE
;	     Inputs  ________________________
;	     Outputs ________________________

J79A6:	LD	HL,0
        LD	A,1
        LD	(D7FFC),A		; select side 1
        LD	A,(D7FFC)
        BIT	0,A			; side 1 still selected (controller in double sided mode) ?
        RET	Z			; nope, no choice string (only one format, single side)
        LD	HL,I79B8
        RET

I79B8:	DEFB	13,10
        DEFB	"1 - Single sided, 9 sectors"
        DEFB	13,10
        DEFB	"2 - Double sided, 9 sectors"
        DEFB	13,10
        DEFB	13,10
        DEFB	0

;	  Subroutine DSKFMT
;	     Inputs  ________________________
;	     Outputs ________________________

J79F7:	PUSH	DE
        LD	D,A
        LD	A,1
        LD	(D7FFC),A		; select side 1
        LD	A,(D7FFC)
        BIT	0,A			; side 1 still selected (controller in double sided mode) ?
        LD	A,D
        POP	DE
        JP	Z,J7A17			; nope, format single sided
        CP	3			; format parameter valid ?
        JP	NC,J7C8B		; nope, quit with BAD PARAMETER error
        CP	1
        JP	Z,J7A17			; choice 1, format single sided
J7A12:	CP	2
        JP	Z,J7A1A			; choice 2, format double sided
J7A17:	JP	J7A23			; choice 0, format single sided

J7A1A:	JP	J7B00
?7A1D:	JP	J7C8B			; BAD PARAMETER error
J7A20:	JP	J7C8B			; BAD PARAMETER error

J7A23:	PUSH	DE
        LD	C,0F8H
        CALL	C7BCD			; initalize for disk i/o
        POP	DE
        PUSH	DE
        CALL	C7BDC			; select drive and track 0
        CALL	C7C08			; select side 0
J7A31:	CALL	C7C8F			; format track
        AND	0E5H
        JR	Z,J7A3D
        LD	A,0AH			; WRITE FAULT error
        JP	J7C78			; error, select track 0 and quit with error

J7A3D:	CALL	C7C25			; wait and update cylinder
        CP	80
J7A42:	JP	Z,J7A4B
        CALL	C7C36			; select next cyclinder
        JP	J7A31

J7A4B:	POP	DE
        PUSH	DE
        CALL	C7BDC			; select drive and track 0
        CALL	C7C44			; setup bootsector with bootloader
        LD	B,3BH
        XOR	A
J7A56:	CALL	C7C51			; clear
        CALL	C7C51			; clear
        LD	HL,19
J7A5F:	LD	DE,(_SECBUF)
        ADD	HL,DE
        EX	DE,HL
        LD	HL,I7AF7
        LD	BC,9
        LDIR
        POP	DE
        LD	A,D
        PUSH	AF
        LD	C,0F8H
        LD	DE,0
        CALL	C7C62			; write sector
        JP	C,J7C78			; select track 0 and quit with error
        LD	DE,(_SECBUF)
        LD	B,0
        XOR	A
        CALL	C7C51			; clear
        LD	DE,1
        PUSH	DE
J7A89:	POP	DE
        POP	AF
        PUSH	AF
        PUSH	DE
        LD	C,0F8H
        CALL	C7C62			; write sector
        JP	C,J7C77			; error, select track 0 and quit with error
        POP	DE
        INC	E
        PUSH	DE
        LD	A,E
        CP	0CH
        JP	NZ,J7A89
        POP	DE
        POP	AF
        PUSH	AF
        LD	D,A
        CALL	C7BDC			; select drive and track 0
        LD	A,0F8H
        CALL	C7C56			; setup fat sector with special entries
        POP	AF
        PUSH	AF
        LD	C,0F8H
        LD	DE,1
        CALL	C7C62			; write sector
        JP	C,J7C78			; error, select track 0 and quit with error
        POP	AF
        PUSH	AF
        LD	C,0F8H
        LD	DE,3
        CALL	C7C62			; write sector
        JP	C,J7C78			; error, select track 0 and quit with error
        POP	AF
        PUSH	AF
        LD	D,A
        CALL	C7BDC			; select drive and track 0
        LD	DE,0
        PUSH	DE
J7ACE:	POP	DE
        POP	AF
        PUSH	AF
        PUSH	DE
        LD	C,0F8H
        CALL	C7C6C			; read sector
        JP	C,J7C81			; error, select track 0 and quit with RECORD NOT FOUND error
        POP	DE
        LD	HL,8
        ADD	HL,DE
        EX	DE,HL
        PUSH	DE
        LD	A,D
        CP	02H
        JP	NZ,J7ACE
        LD	A,E
        CP	0C8H
        JP	NZ,J7ACE
        POP	DE
        POP	AF
        PUSH	AF
        LD	D,A
        CALL	C7BDC			; select drive and track 0
        JP	J7537

I7AF7:	DEFW	002D0H
        DEFB	0F8H
        DEFW	2
        DEFW	9
        DEFW	1

J7B00:	PUSH	DE
        LD	C,0F9H
        CALL	C7BCD			; initalize for disk i/o
        POP	DE
        PUSH	DE
        CALL	C7BDC			; select drive and track 0
        CALL	C7C08			; select side 0
J7B0E:	CALL	C7C8F			; format track
        AND	0E5H
        JR	Z,J7B1A
        LD	A,0AH			; WRITE FAULT error
        JP	J7C78			; select track 0 and quit with error

J7B1A:	CALL	C7C13			; select other side
        AND	A			; now side 1 ?
        JP	NZ,J7B0E		; yep, format side 1
        CALL	C7C25			; wait and update cylinder
        CP	80
        JP	Z,J7B2F
        CALL	C7C36			; select next cylinder
        JP	J7B0E

J7B2F:	POP	DE
        PUSH	DE
        CALL	C7BDC			; select drive and track 0
        CALL	C7C44			; setup bootsector with bootloader
        LD	B,3BH
        XOR	A
        CALL	C7C51			; clear
        CALL	C7C51			; clear
        POP	DE
        LD	A,D
        PUSH	AF
        LD	C,0F9H
        LD	DE,0
        CALL	C7C62			; write sector
        JP	C,J7C78			; error, select track 0 and quit with error
        LD	DE,(_SECBUF)
        LD	B,0
        XOR	A
        CALL	C7C51			; clear
        LD	DE,1
        PUSH	DE
J7B5C:	POP	DE
        POP	AF
        PUSH	AF
        PUSH	DE
        LD	C,0F9H
        CALL	C7C62			; write sector
        JP	C,J7C77			; error, select track 0 and quit with error
        POP	DE
        INC	E
        PUSH	DE
        LD	A,E
        CP	0EH	; 14
        JP	NZ,J7B5C
        CALL	C7C20			; select side 0
        POP	DE
        POP	AF
        PUSH	AF
        LD	D,A
        CALL	C7BDC			; select drive and track 0
        LD	A,0F9H
        CALL	C7C56			; setup fat sector with special entries
        POP	AF
        PUSH	AF
        LD	C,0F9H
        LD	DE,1
        CALL	C7C62			; write sector
        JP	C,J7C78			; error, select track 0 and quit with error
        POP	AF
        PUSH	AF
        LD	C,0F9H
        LD	DE,4
        CALL	C7C62			; write sector
        JP	C,J7C78			; error, select track 0 and quit with error
        POP	AF
        PUSH	AF
        LD	D,A
        CALL	C7BDC			; select drive and track 0
        LD	DE,0
        PUSH	DE
J7BA4:	POP	DE
        POP	AF
        PUSH	AF
        PUSH	DE
        LD	C,0F9H
        CALL	C7C6C			; read sector
        JP	C,J7C81			; error, select track 0 and quit with RECORD NOT FOUND error
        POP	DE
        LD	HL,8
        ADD	HL,DE
        EX	DE,HL
        PUSH	DE
        LD	A,D
        CP	05H
        JP	NZ,J7BA4
        LD	A,E
        CP	98H
        JP	NZ,J7BA4
        POP	DE
        POP	AF
        PUSH	AF
        LD	D,A
        CALL	C7BDC			; select drive and track 0
        JP	J7537

;	  Subroutine __________________________
;	     Inputs  ________________________
;	     Outputs ________________________

C7BCD:	LD	A,D
        LD	B,0
        CALL	C76F8			; initialise for disk i/o
        LD	A,10H			; OTHER error
        JP	C,J7C77			; select track 0 and quit with error
        CALL	GETWRK
        RET

;	  Subroutine __________________________
;	     Inputs  ________________________
;	     Outputs ________________________

C7BDC:	LD	A,D
        AND	A
        PUSH	AF
        JP	NZ,J7BF4
        LD	A,(D7FFD)
        PUSH	AF
        AND	0FCH                    ; leave motor, leave in use led, reset disk change, select drive 0
        LD	(D7FFD),A
        CALL	C7850			; select track 0
        POP	AF
        LD	(D7FFD),A
        POP	AF
        RET

J7BF4:	LD	A,(D7FFD)
        PUSH	AF
        AND	0FCH
        OR	01H                     ; leave motor, leave in use led, reset disk change, select drive 1
        LD	(D7FFD),A
        CALL	C7850			; select track 0
        POP	AF
        LD	(D7FFD),A
        POP	AF
        RET

;	  Subroutine select side 0
;	     Inputs  ________________________
;	     Outputs ________________________

C7C08:	CALL	GETWRK
        XOR	A
        LD	(IX+7),A
        LD	(D7FFC),A		; select side 0
        RET

;	  Subroutine select other side
;	     Inputs  ________________________
;	     Outputs ________________________

C7C13:	LD	A,(D7FFC)
        RRA				; side 1 selected ?
        JP	C,C7C20			; yep, select side 0
        LD	A,1
        LD	(D7FFC),A		; select side 1
        RET

;	  Subroutine __________________________
;	     Inputs  ________________________
;	     Outputs ________________________

C7C20:	XOR	A
        LD	(D7FFC),A		; select side 0
        RET

;	  Subroutine __________________________
;	     Inputs  ________________________
;	     Outputs ________________________

C7C25:	LD	HL,00C8H
J7C28:	DEC	HL
        LD	A,H
        OR	L
        JP	NZ,J7C28
        LD	A,(IX+7)
        INC	A
        LD	(IX+7),A
        RET

;	  Subroutine select next cylinder
;	     Inputs  ________________________
;	     Outputs ________________________

C7C36:	CALL	C7817			; setup for next cylinder
        LD	A,(D7FF8)
        AND	91H			; drive ready and command ready ?
        RET	Z			; yep, quit
        LD	A,06H			; SEEK ERROR error
        JP	J7C77			; select track 0 and quit with error

;	  Subroutine __________________________
;	     Inputs  ________________________
;	     Outputs ________________________

C7C44:	LD	HL,I7405
        LD	DE,(_SECBUF)
        LD	BC,L7405
        LDIR
        RET

;	  Subroutine __________________________
;	     Inputs  ________________________
;	     Outputs ________________________

C7C51:	LD	(DE),A
        INC	DE
        DJNZ	C7C51
        RET

;	  Subroutine __________________________
;	     Inputs  ________________________
;	     Outputs ________________________

C7C56:	LD	DE,(_SECBUF)
        LD	(DE),A
        INC	DE
        LD	A,0FFH
        LD	(DE),A
        INC	DE
        LD	(DE),A
        RET

;	  Subroutine write sector (format)
;	     Inputs  ________________________
;	     Outputs ________________________

C7C62:	LD	B,1
        LD	HL,(_SECBUF)
        SCF
        CALL	DSKIO
        RET

;	  Subroutine read sector (format)
;	     Inputs  ________________________
;	     Outputs ________________________

C7C6C:	LD	B,1
        LD	HL,(_SECBUF)
        SCF
        CCF
        CALL	DSKIO
        RET

J7C77:	POP	DE
J7C78:	PUSH	AF
        CALL	C7850			; select track 0
        POP	AF
        SCF
        JP	J7537

J7C81:	POP	DE
        CALL	C7850			; select track 0
        LD	A,08H			; RECORD NOT FOUND error
        SCF
        JP	J7537

J7C8B:	LD	A,0CH			; BAD PARAMETER error
        SCF
        RET

;	  Subroutine format track
;	     Inputs  ________________________
;	     Outputs ________________________

C7C8F:	CALL	C7849			; wait for command ready
        LD	A,0F4H			; WRITE TRACK
        LD	D,1
        LD	HL,I7E4B
        PUSH	HL
        CALL	DISINT
        DI
        LD	(D7FF8),A
        EX	(SP),HL
        EX	(SP),HL
        LD	C,4EH	; "N"
        LD	B,50H	; "P"
J7CA7:	LD	A,(D7FFF)
        ADD	A,A
        RET	P
        JP	C,J7CA7
        LD	A,C
        LD	(D7FFB),A
        DJNZ	J7CA7
        LD	C,00H
        LD	B,0CH	; 12
J7CB9:	LD	A,(D7FFF)
        ADD	A,A
        RET	P
        JP	C,J7CB9
        LD	A,C
        LD	(D7FFB),A
        DJNZ	J7CB9
        LD	C,0F6H
        LD	B,03H	; 3
J7CCB:	LD	A,(D7FFF)
        ADD	A,A
        RET	P
        JP	C,J7CCB
        LD	A,C
        LD	(D7FFB),A
        DJNZ	J7CCB
        LD	C,0FCH
        INC	B
J7CDC:	LD	A,(D7FFF)
        ADD	A,A
        RET	P
        JP	C,J7CDC
        LD	A,C
        LD	(D7FFB),A
        DJNZ	J7CDC
        LD	C,4EH	; "N"
        LD	B,1AH
J7CEE:	LD	A,(D7FFF)
        ADD	A,A
        RET	P
        JP	C,J7CEE
        LD	A,C
        LD	(D7FFB),A
        DJNZ	J7CEE
J7CFC:	LD	C,00H
        LD	B,0CH	; 12
J7D00:	LD	A,(D7FFF)
        ADD	A,A
        RET	P
        JP	C,J7D00
        LD	A,C
        LD	(D7FFB),A
        DJNZ	J7D00
        LD	C,0F5H
        LD	B,03H	; 3
J7D12:	LD	A,(D7FFF)
        ADD	A,A
        RET	P
        JP	C,J7D12
        LD	A,C
        LD	(D7FFB),A
        DJNZ	J7D12
        LD	C,0FEH
        INC	B
J7D23:	LD	A,(D7FFF)
        ADD	A,A
        RET	P
        JP	C,J7D23
        LD	A,C
        LD	(D7FFB),A
        DJNZ	J7D23
        LD	A,(IX+7)
        LD	C,A
        INC	B
J7D36:	LD	A,(D7FFF)
        ADD	A,A
        RET	P
        JP	C,J7D36
        LD	A,C
        LD	(D7FFB),A
        DJNZ	J7D36
        LD	A,(D7FFC)
        AND	01H			; which side is selected
        LD	C,A
        INC	B
J7D4B:	LD	A,(D7FFF)
        ADD	A,A
        RET	P
        JP	C,J7D4B
        LD	A,C
        LD	(D7FFB),A
        DJNZ	J7D4B
        LD	C,D
        INC	B
J7D5B:	LD	A,(D7FFF)
        ADD	A,A
        RET	P
        JP	C,J7D5B
        LD	A,C
        LD	(D7FFB),A
        DJNZ	J7D5B
        LD	C,02H	; 2
        INC	B
J7D6C:	LD	A,(D7FFF)
        ADD	A,A
        RET	P
        JP	C,J7D6C
        LD	A,C
        LD	(D7FFB),A
        DJNZ	J7D6C
        LD	C,0F7H
        INC	B
J7D7D:	LD	A,(D7FFF)
        ADD	A,A
        RET	P
        JP	C,J7D7D
        LD	A,C
        LD	(D7FFB),A
        DJNZ	J7D7D
        LD	C,4EH	; "N"
        LD	B,18H
J7D8F:	LD	A,(D7FFF)
        ADD	A,A
        RET	P
        JP	C,J7D8F
        LD	A,C
        LD	(D7FFB),A
        DJNZ	J7D8F
        LD	C,00H
        LD	B,0CH	; 12
J7DA1:	LD	A,(D7FFF)
        ADD	A,A
        RET	P
        JP	C,J7DA1
        LD	A,C
        LD	(D7FFB),A
        DJNZ	J7DA1
        LD	C,0F5H
        LD	B,03H	; 3
J7DB3:	LD	A,(D7FFF)
        ADD	A,A
        RET	P
        JP	C,J7DB3
        LD	A,C
        LD	(D7FFB),A
        DJNZ	J7DB3
        LD	C,0FBH
        INC	B
J7DC4:	LD	A,(D7FFF)
        ADD	A,A
        RET	P
        JP	C,J7DC4
        LD	A,C
        LD	(D7FFB),A
        DJNZ	J7DC4
        LD	C,0E5H
J7DD4:	LD	A,(D7FFF)
        ADD	A,A
        RET	P
        JP	C,J7DD4
        LD	A,C
        LD	(D7FFB),A
        DJNZ	J7DD4
        LD	C,0E5H
J7DE4:	LD	A,(D7FFF)
        ADD	A,A
        RET	P
        JP	C,J7DE4
        LD	A,C
        LD	(D7FFB),A
        DJNZ	J7DE4
        LD	C,0F7H
        INC	B
J7DF5:	LD	A,(D7FFF)
        ADD	A,A
        RET	P
        JP	C,J7DF5
        LD	A,C
        LD	(D7FFB),A
        DJNZ	J7DF5
        LD	C,4EH	; "N"
        LD	B,36H	; "6"
J7E07:	LD	A,(D7FFF)
        ADD	A,A
        RET	P
        JP	C,J7E07
        LD	A,C
        LD	(D7FFB),A
        DJNZ	J7E07
        INC	D
        LD	A,D
        CP	0AH	; 10
        JP	NZ,J7CFC
        LD	C,4EH	; "N"
        LD	B,00H
J7E20:	LD	A,(D7FFF)
        ADD	A,A
        RET	P
        JP	C,J7E20
        LD	A,C
        LD	(D7FFB),A
        DJNZ	J7E20
J7E2E:	LD	A,(D7FFF)
        ADD	A,A
        RET	P
        JP	C,J7E2E
        LD	A,C
        LD	(D7FFB),A
        DJNZ	J7E2E
J7E3C:	LD	A,(D7FFF)
        ADD	A,A
        RET	P
        JP	C,J7E3C
        LD	A,C
        LD	(D7FFB),A
        DJNZ	J7E3C
        POP	HL
I7E4B:	EI
        CALL	ENAINT
        LD	A,(D7FF8)
        RET

J7E53:	SCF
        RET

J7E55:	LD	A,3CH
        LD	(D7FFD),A		; motor off, not in use, reset disk change, select drive 0
        LD	A,3DH
        LD	(D7FFD),A		; motor off, not in use, reset disk change, select drive 1
        LD	A,03H
        LD	(D7FFD),A		; motor off, not in use, unselect drive
        RET


D7FF8	EQU	07FF8H			; WD2793
D7FF9	EQU	07FF9H			; WD2793
D7FFA	EQU	07FFAH			; WD2793
D7FFB	EQU	07FFBH			; WD2793

D7FFC	EQU	07FFCH			; CXD1032Q side select
D7FFD	EQU	07FFDH			; CXD1032Q motor/in use/DC/drive select
D7FFF	EQU	07FFFH			; CXD1032Q INT,DRQ

        END
