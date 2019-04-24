; Diskdriver Sony HBD-50 (external floppydisk controller)
;
; FDC	WD2793

; Source re-created by Z80DIS 2.2
; Z80DIS was written by Kenneth Gielow, Palo Alto, CA

; Code Copyrighted by SONY and maybe others
; Source comments by Arjen Zeilemaker

; Sourcecode supplied for STUDY ONLY
; Recreation NOT permitted without authorisation of the copyrightholders
;
; Driver

MYSIZE		equ	9
SECLEN		equ	512

J4022	EQU	4022H	; J----
BDOS	EQU	0F37DH	; -C---

I7405:
        .PHASE	0C000H

        DEFB	0EBH				; x86 JMP +0100H
        DEFB	0FEH
        DEFB	090H				; x86 NOP
        DEFB	"SNYJX130"
        DEFW	512
        DEFB	2
        DEFW	1
        DEFB	2
        DEFW	112
        DEFW	02D0H
        DEFB	0F8H
        DEFW	2
        DEFW	9
        DEFW	1
        DEFW	0

        RET	NC
        LD	(DC058+1),DE
        LD	(DC0C4),A
        LD	(HL),LOW DC056
        INC	HL
        LD	(HL),HIGH DC056
J7430:	LD	SP,KBUF+256
        LD	DE,DC09F
        LD	C,0FH	; 15
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
        LD	C,27H	; "'"
        CALL	BDOS
        JP	0100H

DC056:	DEFW	DC058

DC058:	CALL	0
        LD	A,C
        AND	0FEH
        CP	02H	; 2
        JP	NZ,DC06A
DC063:	LD	A,(DC0C4)
        AND	A
        JP	Z,J4022
DC06A:	LD	DE,DC079
        LD	C,09H	; 9
        CALL	BDOS
        LD	C,07H	; 7
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

; Only supports 3.5 single sided media
; DEFDPB should point to the largest media, which should be 0F9H instead of 0F8H

DEFDPB	EQU	$-1

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
        DEFW	715
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
        DEFW	315
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

DSKIO:	JP	J752D				; DSKIO:
INIHRD:	JP	J7855
DRIVES:	JP	J788A
INIENV:	JP	J78BF
DSKCHG:	JP	J78F4
GETDPB:	JP	J7947
CHOICE:	JP	J7975
DSKFMT:	JP	J7979
OEMSTA:	JP	J7CC1

;	  Subroutine DSKIO
;	     Inputs  ________________________
;	     Outputs ________________________

J752D:	JP	NC,C762C			; read DSKIO
        CALL	C755D				; do write DSKIO

C7533:	PUSH	AF
        LD	C,120				; 2 seconds (NTSC)/2.4 seconds (PAL) disk unchanged
        JR	NC,J753A
        LD	C,0				; error, 0 seconds disk unchanged
J753A:	LD	A,0D0H
        LD	(D7FF8),A			; execute terminate without interrupt command
        EX	(SP),HL
        EX	(SP),HL
        EX	(SP),HL
        EX	(SP),HL
        LD	A,(D7FFB)
        LD	A,(D7FF8)
        LD	(IX+0),240			; keep motor on for 4 seconds (NTSC)
        LD	A,(IX+3)
        AND	A
        JR	NZ,J7558
        LD	(IX+1),C			; drive 0 disk unchanged
        POP	AF
        RET

J7558:	LD	(IX+2),C			; drive 1 disk unchanged
        POP	AF
        RET

;	  Subroutine __________________________
;	     Inputs  ________________________
;	     Outputs ________________________

C755D:	CALL	C76F9				; initialise for disk i/o
        RET	C
        LD	A,H
        AND	A				; transfer from page 0/1 ?
        JP	M,C758C				; nope, use ROM disk i/o routines
        CALL	C7CD7				; install write disk i/o routines in SECBUF
        CALL	C7D5C				; start disk i/o routine in SECBUF
        RET	C
        INC	B
        DEC	B
        RET	Z
        LD	A,H
        AND	A				; transfer still from page 0/1 ?
        JP	M,C758C				; nope, use ROM disk i/o routines
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
        CALL	C7597				; write sector
        POP	HL
        JR	J758F

C758C:	CALL	C7597				; write sector
J758F:	RET	C
        DEC	B
        RET	Z
        CALL	C77D5				; setup for next sector
        JR	C758C

;	  Subroutine __________________________
;	     Inputs  ________________________
;	     Outputs ________________________

C7597:	LD	E,10
J7599:	CALL	C782F				; wait for command ready
        LD	A,0A0H				; WRITE SECTOR
        BIT	6,D
        JR	Z,C75AA
        OR	02H
        BIT	0,D
        JR	Z,C75AA
        OR	08H
C75AA:	PUSH	HL
        PUSH	DE
        PUSH	BC
        LD	DE,I75CC
        PUSH	DE
        CALL	DISINT
        DI
        LD	(D7FF8),A
        EX	(SP),HL
        EX	(SP),HL
        LD	BC,D7FFF
        LD	DE,D7FFB
C75C0:	LD	A,(BC)
        ADD	A,A
        RET	P
        JP	C,C75C0
        LD	A,(HL)
        LD	(DE),A
        INC	HL
        JP	C75C0

I75CC:	POP	BC
        POP	DE
        POP	HL
        EI
        CALL	ENAINT
        LD	A,(D7FF8)
        AND	0FCH
        RET	Z
        JP	M,J7625
        BIT	6,A
        JR	NZ,J7604
        PUSH	AF
        LD	A,(IX+3)
        OR	0C4H			; motor on, in use on, keep disk change
        LD	(D7FFD),A
        CALL	C7815			; reseek every 2nd try
        POP	AF
        DEC	E
        JR	NZ,J7599
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

J7604:	LD	A,0D0H
        LD	(D7FF8),A			; execute terminate without interrupt command
        EX	(SP),HL
        EX	(SP),HL
        LD	A,80H				; READ SECTOR
        LD	(D7FF8),A
        EX	(SP),HL
        EX	(SP),HL
        LD	HL,D7FFF
        LD	DE,0
J7618:	LD	A,(HL)
        ADD	A,A
        JP	P,C7629
        JR	NC,C7629
        DEC	DE
        LD	A,E
        OR	D
        JP	NZ,J7618
J7625:	LD	A,02H
        SCF
        RET

C7629:	XOR	A
        SCF
        RET

;	  Subroutine __________________________
;	     Inputs  ________________________
;	     Outputs ________________________

C762C:	CALL	C7632				; do read DSKIO
        JP	C7533				; finish disk i/o

;	  Subroutine __________________________
;	     Inputs  ________________________
;	     Outputs ________________________
C7632:	CALL	C76F9				; initialise for disk i/o
        RET	C
        LD	A,H
        AND	A
        JP	M,C7666
        CALL	C7CC3				; install read disk i/o routines in SECBUF
        CALL	C7D5C				; start disk i/o routine in SECBUF
        RET	C
        INC	B
        DEC	B
        RET	Z
        LD	A,H
        AND	A
        JP	M,C7666
        PUSH	HL
        LD	HL,(_SECBUF)
        CALL	C7671				; read sector
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
        JR	J766A

C7666:	CALL	C7671				; read sector
        RET	C
J766A:	DEC	B
        RET	Z
        CALL	C77D5				; setup for next sector
        JR	C7666

;	  Subroutine __________________________
;	     Inputs  ________________________
;	     Outputs ________________________

C7671:	LD	E,10
J7673:	CALL	C782F				; wait for command ready
        LD	A,80H				; READ SECTOR
        BIT	6,D
        JR	Z,C7684
        OR	02H
        BIT	0,D
        JR	Z,C7684
        OR	08H
C7684:	PUSH	HL
        PUSH	DE
        PUSH	BC
        LD	BC,D7FFF
        LD	DE,I76C6
        PUSH	DE
        CALL	DISINT
        DI
        LD	(D7FF8),A
        EX	(SP),HL
        EX	(SP),HL
        LD	DE,0
C769A:	LD	A,(BC)
        ADD	A,A
        JP	NC,C76B4
        RET	P
        LD	A,(BC)
        ADD	A,A
        JP	NC,C76B4
        RET	P
        DEC	E
        JP	NZ,C769A
        DEC	D
        JP	NZ,C769A
        POP	BC
        POP	BC
        POP	DE
        POP	HL
        JR	C76F5

C76B4:	LD	DE,D7FFB
        JP	J76C0

C76BA:	LD	A,(BC)
        ADD	A,A
        RET	P
        JP	C,C76BA
J76C0:	LD	A,(DE)
        LD	(HL),A
        INC	HL
        JP	C76BA

I76C6:	POP	BC
        POP	DE
        POP	HL
        EI
        CALL	ENAINT
        LD	A,(D7FF8)
        AND	9CH
        RET	Z
        JP	M,C76F5
        PUSH	AF
        LD	A,(IX+3)
        OR	0C4H			; motor on, in use on, keep disk change
        LD	(D7FFD),A
        CALL	C7815			; reseek every 2nd try
        POP	AF
        DEC	E
        JR	NZ,J7673
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

C76F5:	LD	A,02H
        SCF
        RET

;	  Subroutine __________________________
;	     Inputs  ________________________
;	     Outputs ________________________

C76F9:	PUSH	AF
        PUSH	BC
        PUSH	HL
        CALL	GETWRK
        POP	HL
        POP	BC
        POP	AF
        CP	2
        JR	C,J770A
J7706:	LD	A,0CH
        SCF
        RET

J770A:	PUSH	AF
        LD	A,C
        CP	0F8H
        JR	NC,J7713
        POP	AF
        JR	J7706

J7713:	EX	(SP),HL
        PUSH	HL
        PUSH	BC
        CALL	C782F				; wait for command ready
        BIT	1,C
        LD	C,E
        LD	B,D
        LD	DE,8
        JR	NZ,J7723
        INC	DE
J7723:	CALL	DIV16
        LD	A,L
        INC	A
        LD	(D7FFA),A
        LD	L,C
        POP	BC
        POP	AF
        LD	H,A
        LD	A,(IX+8)
        DEC	A				; 1 physical drive ?
        JR	Z,J7736			        ; yep, select drive 0
        LD	A,H                             ; select physical drive
J7736:	OR	0C4H				; motor on, in use on, keep disk change
        CALL	DISINT
        DI
        LD	(D7FFD),A
        LD	A,(IX+0)
        AND	A				; motor off timer
        LD	(IX+0),0FFH			; leave motor on
        EI
        CALL	ENAINT
        JR	NZ,J7759			; motor still on,
        CALL	C7849				; wait 660 ms
        CALL	C7849				; wait 660 ms
        CALL	C7849				; wait 660 ms
        CALL	C7849				; wait 660 ms (motor spin up)
J7759:	LD	A,C
        RRCA
        RRCA
        AND	0C0H
        LD	D,A
        LD	C,L
        LD	A,(IX+8)
        DEC	A				; 1 physical drive ?
        JR	Z,J778B			; yep,
        LD	A,(IX+3)
        CP	H
        JR	Z,C77CC
        XOR	01H	; 1
        LD	(IX+3),A
        LD	A,(D7FF9)
        JR	Z,J777E
        LD	(IX+4),A			; current track drive 0
        LD	A,(IX+5)			; current track drive 1
        JR	J7784

J777E:	LD	(IX+5),A			; current track drive 1
        LD	A,(IX+4)			; current track drive 0
J7784:	LD	(D7FF9),A
        EX	(SP),HL
        EX	(SP),HL
        JR	J77CF

J778B:	LD	A,H
        CP	(IX+6)
        LD	(IX+6),A
        JR	Z,C77CC
        PUSH	IX
        PUSH	DE
        PUSH	BC
        LD	A,(D7FFD)
        PUSH	AF
        OR	04H				; keep disk change
        AND	0BFH				; motor off, in use off
        LD	(D7FFD),A
        LD	A,87H				; motor on, keep disk change, drive 3 (unselect drive)
        LD	(D7FFD),A
        CALL	PROMPT
        POP	AF
        OR	04H				; keep disk change
        LD	(D7FFD),A
        PUSH	HL
        LD	HL,0
J77B5:	INC	HL
        EX	(SP),IX
        EX	(SP),IX
        EX	(SP),IX
        EX	(SP),IX
        JR	Z,J77C7
        LD	A,(D7FF8)
        BIT	7,A
        JR	NZ,J77B5
J77C7:	POP	HL
        POP	BC
        POP	DE
        POP	IX
C77CC:	LD	A,(D7FF9)
J77CF:	CP	C
        CALL	NZ,C781B			; select track
        POP	HL
        RET

;	  Subroutine __________________________
;	     Inputs  ________________________
;	     Outputs ________________________

C77D5:	CALL	C782F				; wait for command ready
        INC	H
        INC	H
        LD	A,(D7FFA)
        INC	A
        LD	(D7FFA),A
        BIT	7,D
        JR	NZ,J77E8
        CP	10
        RET	C
J77E8:	CP	9
        RET	C
        LD	A,1
        LD	(D7FFA),A
        BIT	6,D
        JR	Z,C77FF
        BIT	0,D
        JR	NZ,C77FF
        SET	0,D
        LD	A,D
        LD	(D7FFC),A			; select side 1
        RET

;	  Subroutine __________________________
;	     Inputs  ________________________
;	     Outputs ________________________

C77FF:	RES	0,D
        LD	A,D
        LD	(D7FFC),A			; select side 0
        INC	C
        CALL	C782F				; wait for command ready
        LD	A,51H				; STEP IN
        LD	(D7FF8),A
        EX	(SP),HL
        EX	(SP),HL
        CALL	C782F				; wait for command ready
        JR	C783D				; wait head settle time

;	  Subroutine __________________________
;	     Inputs  ________________________
;	     Outputs ________________________

C7815:	BIT	0,E
        RET	NZ
        CALL	C7836				; select track 0

;	  Subroutine select track
;	     Inputs  ________________________
;	     Outputs ________________________

C781B:	LD	A,C
        LD	(D7FFB),A
        EX	(SP),HL
        EX	(SP),HL
        LD	A,11H				; SEEK
J7823:	LD	(D7FF8),A
        EX	(SP),HL
        EX	(SP),HL
        CALL	C782F				; wait for command ready
        CALL	C783D				; wait head settle time
        RET

;	  Subroutine wait for command ready
;	     Inputs  ________________________
;	     Outputs ________________________

C782F:	LD	A,(D7FF8)
        RRA
        JR	C,C782F
        RET

;	  Subroutine select track 0
;	     Inputs  ________________________
;	     Outputs ________________________

C7836:	CALL	C782F				; wait for command ready
        LD	A,01H				; RESTORE
        JR	J7823

;	  Subroutine __________________________
;	     Inputs  ________________________
;	     Outputs ________________________

C783D:	PUSH	HL
        LD	HL,0117BH
J7841:	DEC	HL
        LD	A,H
        OR	L
        JR	NZ,J7841
        POP	HL
        XOR	A
        RET

;	  Subroutine wait 660 ms (1/4 motor spin up)
;	     Inputs  ________________________
;	     Outputs ________________________

C7849:	PUSH	HL
        LD	HL,099E1H
J784D:	DEC	HL
        LD	A,H
        OR	L
        JR	NZ,J784D
        POP	HL
        XOR	A
        RET

J7855:	LD	A,0D0H
        LD	(D7FF8),A			; execute terminate without interrupt command
        EX	(SP),HL
        EX	(SP),HL
        LD	A,00H				; motor off, in use off, reset disk change, select drive 0
        CALL	C786C
        LD	A,01H				; motor off, in use off, reset disk change, select drive 1
        CALL	C786C
        LD	A,03H				; motor off, in use off, reset disk change, select drive 3 (unselect drive)
        LD	(D7FFD),A
        RET

;	  Subroutine __________________________
;	     Inputs  ________________________
;	     Outputs ________________________
C786C:	LD	(D7FFD),A
        CALL	C782F				; wait for command ready
        LD	A,01H				; RESTORE
        LD	(D7FF8),A
        EX	(SP),HL
        EX	(SP),HL
        LD	HL,0
J787C:	LD	A,(D7FF8)
        RRA
        RET	NC
        DEC	HL
        LD	A,L
        OR	H
        JR	NZ,J787C
        CALL	C783D				; wait head settle time
        RET

J788A:	PUSH	BC
        PUSH	AF
        CALL	GETWRK
        LD	A,01H				; motor off, in use off, reset disk change, select drive 1
        LD	(D7FFD),A
        CALL	C782F				; wait for command ready
        LD	A,01H				; RESTORE
        LD	(D7FF8),A
        EX	(SP),HL
        EX	(SP),HL
        LD	HL,0
J78A1:	LD	A,(D7FF8)
        RRA
        JR	NC,J78AE
        DEC	HL
        LD	A,L
        OR	H
        JR	NZ,J78A1
        INC	L
        DEFB	0CAH				; JP Z,xxxx
J78AE:	LD	L,2
        LD	(IX+8),L			; number of physical drives
        LD	A,03H				; motor off, in use off, reset disk change, select drive 3 (unselect drive)
        LD	(D7FFD),A
        POP	AF
        JR	Z,J78BD
        LD	L,2
J78BD:	POP	BC
        RET

J78BF:	CALL	GETWRK
        XOR	A
        LD	B,8
J78C5:	LD	(HL),A
        INC	HL
        DJNZ	J78C5
        LD	HL,I78CF
        JP	SETINT

I78CF:	PUSH	AF
        CALL	GETWRK
        LD	A,(HL)			; timer motor off
        AND	A			; timer finished ?
        JR	Z,C78E4			; yep,
        CP	0FFH			; leave motor on ?
        JR	Z,C78E4			; yep,
        DEC	A
        LD	(HL),A
        JR	NZ,C78E4
        LD	A,03H			; motor off, in use off, reset disk change, select drive 3 (unselect drive)
        LD	(D7FFD),A
C78E4:	INC	HL
        LD	A,(HL)			; unchanged timer drive 0
        AND	A			; timer finished ?
        JR	Z,J78EA
        DEC	(HL)
J78EA:	INC	HL
        LD	A,(HL)			; unchanged timer drive 1
        AND	A			; timer finished ?
        JR	Z,J78F0
        DEC	(HL)
J78F0:	POP	AF
        JP	PRVINT

;	  Subroutine DSKCHG
;	     Inputs  ________________________
;	     Outputs ________________________

J78F4:	PUSH	HL
        PUSH	BC
        PUSH	AF
        CALL	GETWRK
        POP	AF
        POP	BC
        POP	HL
        LD	B,(IX+8)
        DEC	B			; 1 physical drive ?
        JR	Z,J7909			; yep,
        AND	A
        LD	B,(IX+2)		; unchanged timer drive 1
        JR	NZ,J790C
J7909:	LD	B,(IX+1)		; unchanged timer drive 0
J790C:	AND	A
        INC	B
        DEC	B			; timer finished ?
        LD	B,1
        RET	NZ			; nope, disk is UNCHANGED
        PUSH	BC
        PUSH	HL
        LD	DE,1
        LD	HL,(_SECBUF)
        CALL	C762C			; read 1st FAT sector
        JR	C,C7944			; error, quit with error
        LD	HL,(_SECBUF)
        LD	B,(HL)
        PUSH	AF
        LD	A,B
        CP	0F8H			; 3.5" single sided ?
        JR	NZ,J793D		; nope, quit with error
        POP	AF
        POP	HL
        PUSH	BC
        CALL	GETDPB			; get drive parameter block
        LD	A,0CH
        JR	C,C7944			; error, quit with error
        POP	AF
        POP	BC
        CP	C			; same media descriptor ?
        SCF
        CCF				; reset Cx
        LD	B,0FFH
        RET	NZ			; nope, disk is CHANGED
        INC	B			; disk change is UNKNOWN
        RET

J793D:	POP	AF
        POP	DE
        POP	DE
        LD	A,0CH
        SCF
        RET

C7944:	POP	DE
        POP	DE
        RET

J7947:	EX	DE,HL
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

?7961:	DEFB	"Sony corp. MCOA div."

J7975:	LD	HL,0
        RET

J7979:	PUSH	DE
        LD	A,D
        LD	B,00H
        LD	C,0F8H
        CALL	C76F9				; initialise for disk i/o
        LD	A,10H
        JP	C,C7AD1
        CALL	GETWRK
        LD	(IX+0),0FFH			; leave motor on
        CALL	C7836				; select track 0
        LD	A,(D7FF8)
        AND	04H
        JP	NZ,J799F
        LD	A,06H
        SCF
        JP	C7AD1

J799F:	CALL	GETWRK
        XOR	A
        LD	(IX+7),A			; current track = 0
J79A6:	CALL	C7AE5				; format track
        AND	0E5H				; mind NOT READY,WRITE PROTECT,LOST DATA,BUSY
        JP	Z,J79B4				; no errors,
        LD	A,0AH
        SCF
        JP	C7AD1

J79B4:	LD	HL,200
J79B7:	DEC	HL
        LD	A,H
        OR	L
        JP	NZ,J79B7			; wait
        LD	A,(IX+7)
        INC	A				; next track
        CP	80
        JP	Z,J79DA
        LD	(IX+7),A
        CALL	C77FF				; select next track
        LD	A,(D7FF8)
        AND	91H				; mind NOT READY,SEEK ERROR, BUSY
        JP	Z,J79A6				; no errors,
        LD	A,06H
J79D6:	SCF
        JP	C7AD1

J79DA:	CALL	C7836				; select track 0
        LD	A,(D7FF8)
        AND	04H				; mind TRACK 0
        JP	NZ,J79EB			; on track 0,
        LD	A,06H
        SCF
        JP	C7AD1

J79EB:	LD	HL,I7405
        LD	DE,(_SECBUF)
        LD	BC,L7405
        LDIR
        LD	BC,512-L7405
J79FA:	XOR	A
        LD	(DE),A
        INC	DE
        DEC	BC
        LD	A,B
        OR	C
        JR	NZ,J79FA			; construct boot sector
        POP	DE
        PUSH	DE
        LD	A,D
        LD	HL,(_SECBUF)
        LD	DE,0
        LD	BC,01F8H
        SCF
        CALL	DSKIO				; write boot sector
        JP	C,C7AD1				; error,
        POP	DE
        LD	A,D
        LD	DE,1
        LD	B,4
        PUSH	AF
        PUSH	DE
        PUSH	BC
J7A1F:	LD	DE,(_SECBUF)
        LD	A,0F8H
        LD	(DE),A
        INC	DE
        LD	A,0FFH
        LD	(DE),A
        INC	DE
        LD	(DE),A
        INC	DE
        XOR	A
        LD	B,0FDH
J7A30:	LD	(DE),A
        INC	DE
        DJNZ	J7A30				; construct first fat sector
        POP	BC
        POP	DE
        POP	AF
        PUSH	AF
        PUSH	DE
        PUSH	BC
        LD	HL,(_SECBUF)
        LD	BC,01F8H
        SCF
        CALL	DSKIO				; write fat sector
        JP	C,C7ACF				; error,
        POP	BC
        POP	DE
        POP	AF
        INC	DE
        DEC	BC				; should be DEC B
        PUSH	AF
        PUSH	DE
        PUSH	BC
        LD	B,3
        LD	DE,(_SECBUF)
        XOR	A
J7A56:	LD	(DE),A
        INC	DE
        DJNZ	J7A56
        POP	BC
        POP	DE
        POP	AF				; construct next fat sector
        PUSH	AF
        PUSH	DE
        PUSH	BC
        LD	HL,(_SECBUF)
        LD	BC,01F8H
        SCF
        CALL	DSKIO				; write fat sector
        JP	C,C7ACF				; error,
        POP	BC
        POP	DE
        POP	AF
        INC	DE
        DEC	BC				; should be DEC B
        PUSH	AF
        PUSH	DE
        PUSH	BC
        LD	A,B
        JR	NZ,J7A1F
        POP	BC
        POP	DE
        POP	AF
        LD	DE,5
        LD	B,7
J7A80:	PUSH	AF
        PUSH	DE
        PUSH	BC
        LD	HL,(_SECBUF)
        LD	BC,01F8H
        SCF
        CALL	DSKIO
        JP	C,C7ACF
        POP	BC
        POP	DE
        POP	AF
        INC	DE
        DJNZ	J7A80
        PUSH	AF
        CALL	C7836				; select track 0
        POP	AF
        LD	BC,12
        LD	DE,0
J7AA1:	PUSH	AF
        PUSH	DE
        PUSH	BC
        LD	HL,(_SECBUF)
        LD	BC,01F8H
        SCF
        CCF
        CALL	DSKIO
        JP	C,J7ADA
        POP	BC
        POP	DE
        INC	DE
        DEC	BC
        LD	A,B
        OR	C
        JR	Z,J7ABD
        POP	AF
        JR	J7AA1

J7ABD:	CALL	C7836				; select track 0
        POP	AF
        LD	A,(D7FF8)
        AND	04H				; mind TRACK 0
        JP	NZ,C7533			; on track 0, finish disk i/o (with no error)
        LD	A,06H
        SCF
        JP	C7533				; finish disk i/o

C7ACF:	POP	DE
        POP	DE
C7AD1:	POP	DE
        PUSH	AF
        CALL	C7836				; select track 0
        POP	AF
        JP	C7533				; finish disk i/o

J7ADA:	POP	DE
        POP	DE
        POP	DE
        CALL	C7836				; select track 0
        LD	A,08H
        JP	C7533				; finish disk i/o

;	  Subroutine Format track
;	     Inputs  ________________________
;	     Outputs ________________________

C7AE5:	CALL	C7CB8				; wait for end of BUSY
        LD	A,0F4H				; FORMAT
        LD	D,1				; Sector 1
        LD	HL,I7C9E
        PUSH	HL
        CALL	DISINT
        DI
        LD	(D7FF8),A
        EX	(SP),HL
        EX	(SP),HL
        LD	C,4EH
        LD	B,80
C7AFD:	LD	A,(D7FFF)
        ADD	A,A
        RET	P
        JP	C,C7AFD
        LD	A,C
        LD	(D7FFB),A
        DJNZ	C7AFD				; PRE INDEX GAP
        LD	C,00H
        LD	B,12
C7B0F:	LD	A,(D7FFF)
        ADD	A,A
        RET	P
        JP	C,C7B0F
        LD	A,C
        LD	(D7FFB),A
        DJNZ	C7B0F				; PRE INDEX GAP
        LD	C,0F6H
        LD	B,3
C7B21:	LD	A,(D7FFF)
        ADD	A,A
        RET	P
        JP	C,C7B21
        LD	A,C
        LD	(D7FFB),A
        DJNZ	C7B21				; special
        LD	C,0FCH
        INC	B
C7B32:	LD	A,(D7FFF)
        ADD	A,A
        RET	P
        JP	C,C7B32
        LD	A,C
        LD	(D7FFB),A
        DJNZ	C7B32				; INDEX ADDRESS MARK
        LD	C,4EH
        LD	B,26
C7B44:	LD	A,(D7FFF)
        ADD	A,A
        RET	P
        JP	C,C7B44
        LD	A,C
        LD	(D7FFB),A
        DJNZ	C7B44				; POST INDEX GAP
J7B52:	LD	C,00H
        LD	B,12
C7B56:	LD	A,(D7FFF)
        ADD	A,A
        RET	P
        JP	C,C7B56
        LD	A,C
        LD	(D7FFB),A
        DJNZ	C7B56				; POST INDEX GAP
        LD	C,0F5H
        LD	B,3
C7B68:	LD	A,(D7FFF)
        ADD	A,A
        RET	P
        JP	C,C7B68
        LD	A,C
        LD	(D7FFB),A
        DJNZ	C7B68				; special
        LD	C,0FEH
        INC	B
C7B79:	LD	A,(D7FFF)
        ADD	A,A
        RET	P
        JP	C,C7B79
        LD	A,C
        LD	(D7FFB),A
        DJNZ	C7B79				; ID ADDRESS MARK
        LD	A,(IX+7)
        LD	C,A
        INC	B
C7B8C:	LD	A,(D7FFF)
        ADD	A,A
        RET	P
        JP	C,C7B8C
        LD	A,C
        LD	(D7FFB),A
        DJNZ	C7B8C				; Track number
        LD	A,00H
        LD	C,A
        INC	B
C7B9E:	LD	A,(D7FFF)
        ADD	A,A
        RET	P
        JP	C,C7B9E
        LD	A,C
        LD	(D7FFB),A
        DJNZ	C7B9E				; Side number (=0)
        LD	C,D
        INC	B
C7BAE:	LD	A,(D7FFF)
        ADD	A,A
        RET	P
        JP	C,C7BAE
        LD	A,C
        LD	(D7FFB),A
        DJNZ	C7BAE				; Sector number
        LD	C,02H
        INC	B
C7BBF:	LD	A,(D7FFF)
        ADD	A,A
        RET	P
        JP	C,C7BBF
        LD	A,C
        LD	(D7FFB),A
        DJNZ	C7BBF				; Sector length (=2, 512 bytes)
        LD	C,0F7H
        INC	B
C7BD0:	LD	A,(D7FFF)
        ADD	A,A
        RET	P
        JP	C,C7BD0
        LD	A,C
        LD	(D7FFB),A
        DJNZ	C7BD0				; CRC
        LD	C,4EH
        LD	B,24
C7BE2:	LD	A,(D7FFF)
        ADD	A,A
        RET	P
        JP	C,C7BE2
        LD	A,C
        LD	(D7FFB),A
        DJNZ	C7BE2				; GAP 2
        LD	C,00H
        LD	B,12
C7BF4:	LD	A,(D7FFF)
        ADD	A,A
        RET	P
        JP	C,C7BF4
        LD	A,C
        LD	(D7FFB),A
        DJNZ	C7BF4				; GAP 2
        LD	C,0F5H
        LD	B,3
C7C06:	LD	A,(D7FFF)
        ADD	A,A
        RET	P
        JP	C,C7C06
        LD	A,C
        LD	(D7FFB),A
        DJNZ	C7C06				; special
        LD	C,0FBH
        INC	B
C7C17:	LD	A,(D7FFF)
        ADD	A,A
        RET	P
        JP	C,C7C17
        LD	A,C
        LD	(D7FFB),A
        DJNZ	C7C17				; DATA ADDRESS MARK
        LD	C,0E5H
C7C27:	LD	A,(D7FFF)
        ADD	A,A
        RET	P
        JP	C,C7C27
        LD	A,C
        LD	(D7FFB),A
        DJNZ	C7C27				; 256x data
        LD	C,0E5H
C7C37:	LD	A,(D7FFF)
        ADD	A,A
        RET	P
        JP	C,C7C37
        LD	A,C
        LD	(D7FFB),A
        DJNZ	C7C37				; 256x data
        LD	C,0F7H
        INC	B
C7C48:	LD	A,(D7FFF)
        ADD	A,A
        RET	P
        JP	C,C7C48
        LD	A,C
        LD	(D7FFB),A
        DJNZ	C7C48				; CRC
        LD	C,4EH
        LD	B,54
C7C5A:	LD	A,(D7FFF)
        ADD	A,A
        RET	P
        JP	C,C7C5A
        LD	A,C
        LD	(D7FFB),A
        DJNZ	C7C5A				; GAP 3
        INC	D				; next sector
        LD	A,D
        CP	9+1
        JP	NZ,J7B52
        LD	C,4EH
        LD	B,0
C7C73:	LD	A,(D7FFF)
        ADD	A,A
        RET	P
        JP	C,C7C73
        LD	A,C
        LD	(D7FFB),A
        DJNZ	C7C73
C7C81:	LD	A,(D7FFF)
        ADD	A,A
        RET	P
        JP	C,C7C81
        LD	A,C
        LD	(D7FFB),A
        DJNZ	C7C81
C7C8F:	LD	A,(D7FFF)
        ADD	A,A
        RET	P
        JP	C,C7C8F
        LD	A,C
        LD	(D7FFB),A
        DJNZ	C7C8F
        POP	HL
I7C9E:	EI
        CALL	ENAINT
        LD	A,(D7FF8)
        RET

;	  Subroutine __________________________
;	     Inputs  ________________________
;	     Outputs ________________________
;         Remark	NOT USED

?7CA6:	LD	HL,0
J7CA9:	LD	A,(D7FF8)
        AND	80H
        RET	Z
        EX	(SP),HL
        EX	(SP),HL
        DEC	HL
        LD	A,H
        OR	L
        JR	NZ,J7CA9
        DEC	A
        RET

;	  Subroutine __________________________
;	     Inputs  ________________________
;	     Outputs ________________________

C7CB8:	LD	A,(D7FF8)
        AND	01H				; mind BUSY
        JP	NZ,C7CB8			; BUSY, wait
        RET

J7CC1:	SCF
        RET

;	  Subroutine __________________________
;	     Inputs  ________________________
;	     Outputs ________________________
C7CC3:	PUSH	HL
        PUSH	DE
        PUSH	BC
        LD	HL,I7D62
        LD	DE,(_SECBUF)
        LD	BC,L7D62
        LDIR
        LD	HL,I7D0A
        JR	C7CE9

;	  Subroutine __________________________
;	     Inputs  ________________________
;	     Outputs ________________________
C7CD7:	PUSH	HL
        PUSH	DE
        PUSH	BC
        LD	HL,I7E9F
        LD	DE,(_SECBUF)
        LD	BC,L7E9F
        LDIR
        LD	HL,I7D36
C7CE9:	LD	E,(HL)
        INC	HL
        LD	D,(HL)
        INC	HL
        LD	A,E
        OR	D
        JR	Z,J7D06
        PUSH	HL
        LD	HL,(_SECBUF)
        ADD	HL,DE
        INC	HL
        LD	C,(HL)
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
        JR	C7CE9

J7D06:	POP	BC
        POP	DE
        POP	HL
        RET


I7D0A:	DEFW	X0006
        DEFW	X0019
        DEFW	X003A
        DEFW	X0040
        DEFW	X0047
        DEFW	X005E
        DEFW	X0070
        DEFW	X0076
        DEFW	X007B
        DEFW	X007F
        DEFW	X008B
        DEFW	X0091
        DEFW	X0097
        DEFW	X00A7
        DEFW	X00B3
        DEFW	X00CD
        DEFW	X00FE
        DEFW	X0108
        DEFW	X0110
        DEFW	X0120
        DEFW	X0136
        DEFW	0

I7D36:	DEFW	Y0006
        DEFW	Y0019
        DEFW	Y003A
        DEFW	Y0040
        DEFW	Y0047
        DEFW	Y005B
        DEFW	Y0071
        DEFW	Y0077
        DEFW	Y0087
        DEFW	Y0097
        DEFW	Y00C8
        DEFW	Y00D0
        DEFW	Y00DA
        DEFW	Y010B
        DEFW	Y0115
        DEFW	Y011D
        DEFW	Y012D
        DEFW	Y0143
        DEFW	D

;	  Subroutine __________________________
;	     Inputs  ________________________
;	     Outputs ________________________

C7D5C:	PUSH	HL
        LD	HL,(_SECBUF)
        EX	(SP),HL
        RET

I7D62:
        .PHASE	0

        PUSH	HL
        PUSH	DE
        PUSH	BC
        CALL	GETSLT
X0006:	LD	(X0028+1),A
        LD	H,80H
        CALL	ENASLT
        LD	A,(RAMAD1)
        LD	H,40H	; "@"
        CALL	ENASLT
        POP	BC
        POP	DE
        POP	HL
X0019:	CALL	C0034
        PUSH	HL
        PUSH	DE
        PUSH	BC
        PUSH	AF
        LD	A,(RAMAD2)
        LD	H,80H
        CALL	ENASLT
X0028:	LD	A,0
        LD	H,40H	; "@"
        CALL	ENASLT
        POP	AF
        POP	BC
        POP	DE
        POP	HL
        RET

C0034:	DEC	HL
        LD	A,H
        ADD	A,HIGH 512
        INC	HL
        RET	M
X003A:	CALL	C0045
        RET	C
        DEC	B
        RET	Z
X0040:	CALL	X00CD
        JR	C0034

C0045:	LD	E,0AH	; 10
X0047:	CALL	C012F
        LD	A,80H
        BIT	6,D
        JR	Z,C7DBA
        OR	02H	; 2
        BIT	0,D
        JR	Z,C7DBA
        OR	08H	; 8
C7DBA:	PUSH	HL
        PUSH	DE
        PUSH	BC
        LD	BC,DBFFF
X005E:	LD	DE,I009A
        PUSH	DE
        CALL	DISINT
        DI
        LD	(DBFF8),A
        EX	(SP),HL
        EX	(SP),HL
        LD	DE,0
J006E:	LD	A,(BC)
        ADD	A,A
X0070:	JP	NC,J0088
        RET	P
        LD	A,(BC)
        ADD	A,A
X0076:	JP	NC,J0088
        RET	P
        DEC	E
X007B:	JP	NZ,J006E
        DEC	D
X007F:	JP	NZ,J006E
        POP	BC
        POP	BC
        POP	DE
        POP	HL
        JR	J00C9

J0088:	LD	DE,DBFFB
X008B:	JP	J0094

J008E:	LD	A,(BC)
        ADD	A,A
        RET	P
X0091:	JP	C,J008E
J0094:	LD	A,(DE)
        LD	(HL),A
        INC	HL
X0097:	JP	J008E

I009A:	POP	BC
        POP	DE
        POP	HL
        EI
        CALL	ENAINT
        LD	A,(DBFF8)
        AND	9CH
        RET	Z
X00A7:	JP	M,J00C9
        PUSH	AF
        LD	A,(IX+3)
        OR	0C4H
        LD	(DBFFD),A
X00B3:	CALL	C010D
        POP	AF
        DEC	E
        JR	NZ,X0047
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

J00C9:	LD	A,02H	; 2
        SCF
        RET

X00CD:	CALL	C012F
        INC	H
        INC	H
        LD	A,(DBFFA)
        INC	A
        LD	(DBFFA),A
        BIT	7,D
        JR	NZ,J7E42
        CP	0AH	; 10
        RET	C
J7E42:	CP	09H	; 9
        RET	C
        LD	A,01H	; 1
        LD	(DBFFA),A
        BIT	6,D
        JR	Z,C7E59
        BIT	0,D
        JR	NZ,C7E59
        SET	0,D
        LD	A,D
        LD	(DBFFC),A
        RET

C7E59:	RES	0,D
        LD	A,D
        LD	(DBFFC),A
        INC	C
X00FE:	CALL	C012F
        LD	A,51H	; "Q"
        LD	(DBFF8),A
        EX	(SP),HL
        EX	(SP),HL
X0108:	CALL	C012F
        JR	J7E85

C010D:	BIT	0,E
        RET	NZ
X0110:	CALL	X0136
        LD	A,C
        LD	(DBFFB),A
        EX	(SP),HL
        EX	(SP),HL
        LD	A,11H	; 17
J7E7D:	LD	(DBFF8),A
        EX	(SP),HL
        EX	(SP),HL
X0120:	CALL	C012F

;	  Subroutine wait head settle time
;	     Inputs  ________________________
;	     Outputs ________________________

J7E85:	PUSH	HL
        LD	HL,0117BH
J7E89:	DEC	HL
        LD	A,H
        OR	L
        JR	NZ,J7E89
        POP	HL
        XOR	A
        RET

C012F:	LD	A,(DBFF8)
        RRA
        JR	C,C012F
        RET

X0136:	CALL	C012F
        LD	A,01H
        JR	J7E7D

        .DEPHASE

L7D62	EQU	$-I7D62

I7E9F:
        .PHASE	0

        PUSH	HL
        PUSH	DE
        PUSH	BC
        CALL	GETSLT
Y0006:	LD	(Y0028+1),A
        LD	H,80H
        CALL	ENASLT
        LD	A,(RAMAD1)
        LD	H,40H
        CALL	ENASLT
        POP	BC
        POP	DE
        POP	HL
Y0019:	CALL	C0034
        PUSH	HL
        PUSH	DE
        PUSH	BC
        PUSH	AF
        LD	A,(RAMAD2)
        LD	H,80H
        CALL	ENASLT
Y0028:	LD	A,0
        LD	H,40H
        CALL	ENASLT
        POP	AF
        POP	BC
        POP	DE
        POP	HL
        RET

Y0034:	DEC	HL
        LD	A,H
        ADD	A,HIGH 512
        INC	HL
        RET	M
Y003A:	CALL	C0045
        RET	C
        DEC	B
        RET	Z
Y0040:	CALL	Y00DA
        JR	C0034

C0045:	LD	E,10
Y0047:	CALL	C013C
        LD	A,0A0H
        BIT	6,D
        JR	Z,C7EF7
        OR	02H
        BIT	0,D
        JR	Z,C7EF7
        OR	08H
C7EF7:	PUSH	HL
        PUSH	DE
        PUSH	BC
Y005B:	LD	DE,I007A
        PUSH	DE
        CALL	DISINT
        DI
        LD	(DBFF8),A
        EX	(SP),HL
        EX	(SP),HL
        LD	BC,DBFFF
        LD	DE,DBFFB
J006E:	LD	A,(BC)
        ADD	A,A
        RET	P
Y0071:	JP	C,J006E
        LD	A,(HL)
        LD	(DE),A
        INC	HL
Y0077:	JP	J006E

I007A:	POP	BC
        POP	DE
        POP	HL
        EI
        CALL	ENAINT
        LD	A,(DBFF8)
        AND	0FCH
        RET	Z
Y0087:	JP	M,J00D3
        BIT	6,A
        JR	NZ,J7F51
        PUSH	AF
        LD	A,(IX+3)
        OR	0C4H
        LD	(DBFFD),A
Y0097:	CALL	C011A
        POP	AF
        DEC	E
        JR	NZ,Y0047
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

J7F51:	LD	A,0D0H
        LD	(DBFF8),A
        EX	(SP),HL
        EX	(SP),HL
        LD	A,80H
        LD	(DBFF8),A
        EX	(SP),HL
        EX	(SP),HL
        LD	HL,DBFFF
        LD	DE,0
J00C6:	LD	A,(HL)
        ADD	A,A
Y00C8:	JP	P,J00D7
        JR	NC,J00D7
        DEC	DE
        LD	A,E
        OR	D
Y00D0:	JP	NZ,J00C6
J00D3:	LD	A,02H
        SCF
        RET

J00D7:	XOR	A
        SCF
        RET

Y00DA:	CALL	C013C
        INC	H
        INC	H
        LD	A,(DBFFA)
        INC	A
        LD	(DBFFA),A
        BIT	7,D
        JR	NZ,J7F8C
        CP	9+1
        RET	C
J7F8C:	CP	8+1
        RET	C
        LD	A,1
        LD	(DBFFA),A
        BIT	6,D
        JR	Z,C7FA3
        BIT	0,D
        JR	NZ,C7FA3
        SET	0,D
        LD	A,D
        LD	(DBFFC),A
        RET

C7FA3:	RES	0,D
        LD	A,D
        LD	(DBFFC),A
        INC	C
Y010B:	CALL	C013C
        LD	A,51H
        LD	(DBFF8),A
        EX	(SP),HL
        EX	(SP),HL
Y0115:	CALL	C013C
        JR	J7FCF

C011A:	BIT	0,E
        RET	NZ
Y011D:	CALL	Y0143
        LD	A,C
        LD	(DBFFB),A
        EX	(SP),HL
        EX	(SP),HL
        LD	A,11H
J7FC7:	LD	(DBFF8),A
        EX	(SP),HL
        EX	(SP),HL
Y012D:	CALL	C013C

;	  Subroutine wait head settle time
;	     Inputs  ________________________
;	     Outputs ________________________

J7FCF:	PUSH	HL
        LD	HL,0117BH
J7FD3:	DEC	HL
        LD	A,H
        OR	L
        JR	NZ,J7FD3
        POP	HL
        XOR	A
        RET

C013C:	LD	A,(DBFF8)
        RRA
        JR	C,C013C
        RET

Y0143:	CALL	C013C
        LD	A,01H
        JR	J7FC7

        .DEPHASE

L7E9F	EQU	$-I7E9F

D7FF8	EQU	07FF8H
D7FF9	EQU	07FF9H
D7FFA	EQU	07FFAH
D7FFB	EQU	07FFBH
D7FFC	EQU	07FFCH
D7FFD	EQU	07FFDH
D7FFF	EQU	07FFFH

DBFF8	EQU	D7FF8+04000H
DBFFA	EQU	D7FFA+04000H
DBFFB	EQU	D7FFB+04000H
DBFFC	EQU	D7FFC+04000H
DBFFD	EQU	D7FFD+04000H
DBFFF	EQU	D7FFF+04000H

        END
