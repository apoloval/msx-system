; Diskdriver Microsol CDX-2
; FDC	WD279x

; Source re-created by Z80DIS 2.2
; Z80DIS was written by Kenneth Gielow, Palo Alto, CA

; Code Copyrighted by Microsol and maybe others
; Source comments by Arjen Zeilemaker

; Sourcecode supplied for STUDY ONLY
; Recreation NOT permitted without authorisation of the copyrightholders

MYSIZE	EQU	10

I$7405:	DEFB	0F8H,00H,02H,0FH,04H,01H,02H,01H
        DEFB	00H,02H,70H,0CH,00H,63H,01H,02H
        DEFB	05H,00H
GETDPB:	EQU	$-1
        DEFB	0F9H,00H,02H,0FH,04H,01H
        DEFB	02H,01H,00H,02H,70H,0EH,00H,0CAH
        DEFB	02H,03H,07H,00H
        DEFB	0FAH,00H,02H,0FH
        DEFB	04H,01H,02H,01H,00H,02H,70H,0AH
        DEFB	00H,3CH,01H,01H,03H,00H
        DEFB	0FBH,00H
        DEFB	02H,0FH,04H,01H,02H,01H,00H,02H
        DEFB	70H,0CH,00H,7BH,02H,02H,05H,00H
        DEFB	0FCH,00H,02H,0FH,04H,00H,01H,01H
        DEFB	00H,02H,40H,09H,00H,60H,01H,02H
        DEFB	05H,00H
        DEFB	0FDH,00H,02H,0FH,04H,01H
        DEFB	02H,01H,00H,02H,70H,0CH,00H,63H
        DEFB	01H,02H,05H,00H
        DEFB	0FEH,00H,02H,0FH
        DEFB	04H,00H,01H,01H,00H,02H,40H,07H
        DEFB	00H,3AH,01H,01H,03H,00H
        DEFB	0FFH,00H
        DEFB	02H,0FH,04H,01H,02H,01H,00H,02H
        DEFB	70H,0AH,00H,3CH,01H,01H,03H,00H

DSKIO:
?.7495:	JP	C.74BF

DSKCHG:
?.7498:	JP	J$7831

GETDPB:
?.749B:	JP	C.7871

CHOICE:
?.749E:	JP	J$788C

DSKFMT:
?.74A1:	JP	J$7960

MTOFF:
?.74A4:	JP	J$77C0

INIHRD:
?.74A7:	JP	C.77B0

DRIVES:
?.74AA:	JP	J$77DD

INIENV:
?.74AD:	JP	J$77FA

OEMSTA:
?.74B0:	JP	J$7922
?.74B3:	JP	C.760A
?.74B6:	JP	C.7526
?.74B9:	JP	J$7784
?.74BC:	JP	C.77C4

;	  Subroutine DSKIO
;	     Inputs  ________________________
;	     Outputs ________________________

C.74BF:	PUSH	AF
        JP	NC,J$75C5
        CALL	C$74EA
J.74C6:	POP	DE
        PUSH	AF
        LD	C,60
        JR	NC,J$74CE
        LD	C,0
J$74CE:	LD	A,0D0H
        OUT	(0D0H),A
        EX	(SP),IY
        EX	(SP),IY
        IN	A,(0D0H)
        LD	(IX),120
        LD	A,D
        AND	A
        JR	NZ,J$74E5
        LD	(IX+1),C
        POP	AF
        RET

J$74E5:	LD	(IX+2),C
        POP	AF
        RET

;	  Subroutine __________________________
;	     Inputs  ________________________
;	     Outputs ________________________
C$74EA:	CALL	C.766B
        RET	C
        SET	0,(IX+8)
J$74F2:	LD	A,H
        AND	A
        JP	M,J.7518
        LD	A,LOW (512-1)
        ADD	A,L
        LD	A,H
        ADC	A,HIGH (512-1)
        CP	40H
        JR	C,J.7518
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
        CALL	C.7526			; write sector
        POP	HL
        JR	J$751E

J.7518:	CALL	C.7526			; write sector
        CALL	C$75A7			; verify after write if enabled
J$751E:	RET	C
        DEC	B
        RET	Z
        CALL	C.7742
        JR	J$74F2

;	  Subroutine write sector
;	     Inputs  ________________________
;	     Outputs ________________________

C.7526:	LD	E,11
J$7528:	CALL	C.77AA			; wait for FDC ready
        LD	A,0A0H
        BIT	6,D
        JR	Z,J.7539
        OR	02H	; 2
        BIT	4,D
        JR	Z,J.7539
        OR	08H	; 8
J.7539:	PUSH	HL
        PUSH	DE
        PUSH	BC
        LD	DE,I$7570
        PUSH	DE
        CALL	DISINT
        DI
        OUT	(0D0H),A
        EX	(SP),IY
        EX	(SP),IY
        EX	(SP),IY
        EX	(SP),IY
        EX	(SP),IY
        EX	(SP),IY
        LD	C,0D3H
J$7554:	IN	A,(0D0H)
        RRCA
        RET	NC
        RRCA
        JP	NC,J$7554
        OUTI
        LD	A,1DH
J$7560:	DEC	A
        JR	NZ,J$7560
J.7563:	IN	A,(0D0H)
        RRCA
        RET	NC
        RRCA
        JP	NC,J.7563
        OUTI
        JP	J.7563

I$7570:	LD	B,6AH	; "j"
J$7572:	EX	(SP),HL
        EX	(SP),HL
        DJNZ	J$7572
        POP	BC
        POP	DE
        POP	HL
        EI
        CALL	ENAINT
        IN	A,(0D0H)
        AND	0FCH
        RET	Z
        JP	M,J.75A3
        BIT	6,A
        JR	NZ,J$75A0
        PUSH	AF
        CALL	C.7781
        POP	AF
        DEC	E
        JR	NZ,J$7528
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

J$75A0:	XOR	A
        SCF
        RET

J.75A3:	LD	A,02H	; 2
        SCF
        RET

;	  Subroutine __________________________
;	     Inputs  ________________________
;	     Outputs ________________________

C$75A7:	RET	C
        LD	A,(RAWFLG)
        OR	A			; verify after write ?
        RET	Z			; nope, quit
        SET	0,(IX+7)		; set verify flag
        CALL	C.760A			; read/verify sector
        RES	0,(IX+7)		; reset verify flag
        RET

J.75B9:	IN	A,(0D0H)
        RRCA
        RET	NC
        RRCA
        JR	NC,J.75B9
        IN	A,(C)
        JP	J.75B9

J$75C5:	CALL	C$75CB
        JP	J.74C6

;	  Subroutine __________________________
;	     Inputs  ________________________
;	     Outputs ________________________

C$75CB:	CALL	C.766B
        RET	C
        RES	0,(IX+8)
J$75D3:	LD	A,H
        AND	A
        JP	M,J.75FF
        LD	A,0FFH
        ADD	A,L
        LD	A,H
        ADC	A,01H	; 1
        CP	40H	; "@"
        JR	C,J.75FF
        PUSH	HL
        LD	HL,(_SECBUF)
        CALL	C.760A			; read/verify sector
        POP	HL
        RET	C
        PUSH	HL
        PUSH	DE
        PUSH	BC
        LD	DE,(_SECBUF)
        EX	DE,HL
        LD	BC,512
        CALL	XFER
        POP	BC
        POP	DE
        POP	HL
        AND	A
        JR	J$7603

J.75FF:	CALL	C.760A			; read/verify sector
        RET	C
J$7603:	DEC	B
        RET	Z
        CALL	C.7742
        JR	J$75D3

;	  Subroutine read/verify sector
;	     Inputs  ________________________
;	     Outputs ________________________

C.760A:	LD	E,11
J$760C:	CALL	C.77AA			; wait for FDC ready
        LD	A,80H
        BIT	6,D
        JR	Z,J.761D
        OR	02H	; 2
        BIT	4,D
        JR	Z,J.761D
        OR	08H	; 8
J.761D:	PUSH	HL
        PUSH	DE
        PUSH	BC
        LD	DE,I$7645
        PUSH	DE
        CALL	DISINT
        DI
        OUT	(0D0H),A
        LD	C,0D3H
        LD	B,03H	; 3
        EX	(SP),IY
        EX	(SP),IY
        BIT	0,(IX+7)
        JP	NZ,J.75B9
J.7639:	IN	A,(0D0H)
        RRCA
        RET	NC
        RRCA
        JR	NC,J.7639
        INI
        JP	J.7639

I$7645:	POP	BC
        POP	DE
        POP	HL
        EI
        CALL	ENAINT
        IN	A,(0D0H)
        AND	9CH
        RET	Z
        JP	M,J.75A3
        PUSH	AF
        CALL	C.7781
        POP	AF
        DEC	E
        JR	NZ,J$760C
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

;	  Subroutine __________________________
;	     Inputs  ________________________
;	     Outputs ________________________

C.766B:	PUSH	AF
        PUSH	BC
        PUSH	HL
        CALL	GETWRK
        POP	HL
        POP	BC
        POP	AF
        CP	02H	; 2
        JR	C,J$767C
J$7678:	SCF
        LD	A,0CH	; 12
        RET

J$767C:	PUSH	AF
        LD	A,C
        RES	7,(IX+7)
        CP	0F8H
        JR	NC,J.7695
        CP	7CH	; "|"
        SET	7,(IX+7)
        JR	Z,J.7695
        CP	7DH	; "}"
        JR	Z,J.7695
        POP	AF
        JR	J$7678

J.7695:	POP	AF
        PUSH	IX
        PUSH	BC
        PUSH	DE
        PUSH	AF
        LD	A,(IX+9)
        DEC	A
        JR	NZ,J.76B8
        POP	AF
        LD	B,00H
        PUSH	BC
        CP	(IX+6)
        JR	Z,J.76B8
        LD	(IX+6),A
        XOR	A
        OUT	(0D4H),A		; unselect diskdrive, side 0, motor off
        LD	(IX),A
        PUSH	HL
        CALL	PROMPT
        POP	HL
J.76B8:	POP	AF
        POP	DE
        POP	BC
        POP	IX
        PUSH	HL
        PUSH	AF
        PUSH	BC
        CALL	C.77AA			; wait for FDC ready
        LD	A,C
        LD	C,E
        LD	B,D
        LD	DE,10
        BIT	7,(IX+7)
        JR	NZ,J.76D7
        BIT	1,A
        LD	DE,8
        JR	NZ,J.76D7
        INC	DE
J.76D7:	CALL	DIV16
        LD	A,L
        INC	A
        OUT	(0D2H),A
        LD	L,C
        POP	BC
        POP	AF
        LD	H,A
        PUSH	HL
        LD	A,0
        SCF
        INC	H
J$76E7:	RLA
        DEC	H
        JR	NZ,J$76E7		; set the right diskdrive bit
        OR	20H			; motor on
        POP	HL
        BIT	0,C
        JR	Z,J.76F8
        SRL	L
        JR	NC,J.76F8
        OR	10H			; side 1
J.76F8:	LD	D,A
        LD	A,C
        RRCA
        RRCA
        AND	0C0H
        OR	D
        LD	D,A
        DI
        OUT	(0D4H),A		; select diskdrive, side, motor on
        LD	A,(IX)
        AND	A
        LD	(IX),0FFH
        EI
        JR	NZ,J$7718
        PUSH	HL
        LD	HL,0
J$7712:	DEC	HL
        LD	A,L
        OR	H
        JR	NZ,J$7712
        POP	HL
J$7718:	LD	C,L
        LD	A,(IX+3)
        CP	H
        JR	Z,J$773A
        XOR	01H	; 1
        LD	(IX+3),A
        IN	A,(0D1H)
        JR	Z,J$7730
        LD	(IX+4),A
        LD	A,(IX+5)
        JR	J$7736

J$7730:	LD	(IX+5),A
        LD	A,(IX+4)
J$7736:	OUT	(0D1H),A
        EX	(SP),HL
        EX	(SP),HL
J$773A:	IN	A,(0D1H)
        CP	C
        CALL	NZ,C$7787
        POP	HL
        RET

;	  Subroutine __________________________
;	     Inputs  ________________________
;	     Outputs ________________________

C.7742:	CALL	C.77AA			; wait for FDC ready
        INC	H
        INC	H
        IN	A,(0D2H)
        INC	A
        OUT	(0D2H),A
        BIT	7,D
        JR	NZ,J$7753
        CP	0AH	; 10
        RET	C
J$7753:	CP	09H	; 9
        RET	C
        LD	A,00H
        BIT	7,(IX+7)
        JR	NZ,J$7760
        LD	A,01H	; 1
J$7760:	OUT	(0D2H),A
        BIT	6,D
        JR	Z,J.7770
        BIT	4,D			; side 1 ?
        JR	NZ,J.7770		; yep,
        SET	4,D			; side 1
        LD	A,D
        OUT	(0D4H),A		; select diskdrive, side, motor on
        RET

J.7770:	RES	4,D
        LD	A,D
        OUT	(0D4H),A		; select diskdrive, side, motor on
        INC	C
        CALL	C.77AA			; wait for FDC ready
        LD	A,51H	; "Q"
        OUT	(0D0H),A
        EX	(SP),HL
        EX	(SP),HL
        JR	J$7797

;	  Subroutine __________________________
;	     Inputs  ________________________
;	     Outputs ________________________

C.7781:	BIT	0,E
        RET	NZ

;	  Subroutine wait for FDC and seek to track
;	     Inputs  ________________________
;	     Outputs ________________________

J$7784:	CALL	C$778E
;
;	  Subroutine seek to track
;	     Inputs  ________________________
;	     Outputs ________________________

C$7787:	LD	A,C
        OUT	(0D3H),A
        LD	A,11H	; 17
        JR	J$7793

;	  Subroutine __________________________
;	     Inputs  ________________________
;	     Outputs ________________________

C$778E:	CALL	C.77AA			; wait for FDC ready
        LD	A,01H	; 1
J$7793:	OUT	(0D0H),A
        EX	(SP),HL
        EX	(SP),HL
J$7797:	CALL	C.77AA			; wait for FDC ready
        BIT	0,(IX+8)
        RET	Z
        PUSH	BC
        LD	BC,0DFCH
J$77A3:	DEC	BC
        LD	A,B
        OR	C
        JR	NZ,J$77A3
        POP	BC
        RET

;	  Subroutine wait for FDC ready
;	     Inputs  ________________________
;	     Outputs ________________________

C.77AA:	IN	A,(0D0H)
        RRA
        JR	C,C.77AA
        RET

;	  Subroutine INIHRD
;	     Inputs  ________________________
;	     Outputs ________________________

C.77B0:	LD	A,0D0H
        OUT	(0D0H),A
        EX	(SP),HL
        EX	(SP),HL
        LD	A,2			; first diskdrive 1, then diskdrive 0
J$77B8:	PUSH	AF
        CALL	C.77C4			; initialize diskdrive
        POP	AF
        DEC	A
        JR	NZ,J$77B8

;	  Subroutine MTOFF
;	     Inputs  ________________________
;	     Outputs ________________________

J$77C0:	XOR	A
        OUT	(0D4H),A		; unselect diskdrive, side 0, motor off
        RET

;	  Subroutine initialize diskdrive
;	     Inputs  ________________________
;	     Outputs ________________________

C.77C4:	OUT	(0D4H),A		; select diskdrive, side 0, motor off
        CALL	C.77AA			; wait for FDC ready
        LD	A,1
        OUT	(0D0H),A		; execute FDC RESTORE cmd
        EX	(SP),HL
        EX	(SP),HL
        LD	HL,0
J$77D2:	IN	A,(0D0H)
        CPL
        RRA				; FDC ready ?
        RET	C			; yep, quit
        DEC	HL
        LD	A,L
        OR	H
        JR	NZ,J$77D2
        RET

;	  Subroutine DRIVES
;	     Inputs  ________________________
;	     Outputs ________________________

J$77DD:	PUSH	BC
        PUSH	AF
        CALL	GETWRK
        LD	A,2			; diskdrive 1
        CALL	C.77C4			; initialize diskdrive
        LD	L,2
        JR	C,J$77ED		; diskdrive 1 found, logical drives = 2
        LD	L,1			; diskdrive 1 not found, assume diskdrive 0 is there, logical drives = 1
J$77ED:	LD	(IX+9),L
        XOR	A
        OUT	(0D4H),A		; unselect diskdrive, side 0, motor off
        POP	AF
        JR	Z,J$77F8
        LD	L,2
J$77F8:	POP	BC
        RET

;	  Subroutine INIENV
;	     Inputs  ________________________
;	     Outputs ________________________

J$77FA:	LD	A,1
        LD	(RAWFLG),A		; verify after write on
        CALL	GETWRK
        XOR	A
        LD	B,9
J$7805:	LD	(HL),A
        INC	HL
        DJNZ	J$7805
        LD	HL,I$780F
        JP	SETINT

I$780F:	PUSH	AF
        CALL	GETWRK
        LD	A,(HL)			; diskdrive motor timer
        AND	A			; already finished ?
        JR	Z,J.7821		; yep, skip motor off
        CP	0FFH			; timer disabled ?
        JR	Z,J.7821		; yep, skip motor off
        DEC	A
        LD	(HL),A			; decrease timer
        JR	NZ,J.7821		; timer not finished, skip motor off
        OUT	(0D4H),A		; unselect diskdrive, side 0, motor off
J.7821:	INC	HL
        LD	A,(HL)			; disk change timer logical disk 0
        AND	A			; already finished ?
        JR	Z,J$7827		; yep,
        DEC	(HL)
J$7827:	INC	HL
        LD	A,(HL)			; disk change timer logical disk 1
        AND	A			; already finished ?
        JR	Z,J$782D		; yep,
        DEC	(HL)
J$782D:	POP	AF
        JP	PRVINT			; rest of H.TIMI chain

;	  Subroutine DSKCHG
;	     Inputs  ________________________
;	     Outputs ________________________

J$7831:	EI
        PUSH	HL
        PUSH	BC
        PUSH	AF
        CALL	GETWRK
        POP	AF
        POP	BC
        POP	HL
        AND	A			; logical drive
        LD	B,(IX+2)
        JR	NZ,J$7844		; logical drive 1,use disk change timer logical disk 1
        LD	B,(IX+1)		; logical drive 0 use disk change timer logical disk 0
J$7844:	INC	B
        DEC	B			; timer finished ?
        LD	B,1
        RET	NZ			; nope, quit with disk unchanged
        PUSH	BC
        PUSH	HL
        LD	DE,1			; first FAT sector
        LD	HL,(_SECBUF)
        AND	A			; read operation
        CALL	C.74BF			; DSKIO
        JR	C,J.786E		; error, quit with error
        LD	HL,(_SECBUF)
        LD	B,(HL)			; mediabyte (first byte of first FAT sector)
        POP	HL
        PUSH	BC
        CALL	C.7871			; GETDPB
        LD	A,0CH
        JR	C,J.786E		; error, quit with OTHER error
        POP	AF
        POP	BC
        CP	C			; same mediabyte ?
        SCF
        CCF
        LD	B,0FFH
        RET	NZ			; nope, quit with disk changed
        INC	B
        RET				; quit with disk change unknown

J.786E:	POP	DE
        POP	DE
        RET

;	  Subroutine GETDPB
;	     Inputs  ________________________
;	     Outputs ________________________

C.7871:	EI
        EX	DE,HL
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
        LD	BC,I$7405
        ADD	HL,BC
        LD	BC,18
        LDIR
        RET

;	  Subroutine CHOICE
;	     Inputs  ________________________
;	     Outputs ________________________

J$788C:	LD	HL,I$7890
        RET

I$7890:	DEFB	13,10
        DEFB	"Escolha uma das alternativas:",13,10
        DEFB	"1 - 40 trilhas simples face",13,10
        DEFB	"2 - 40 trilhas dupla face",13,10
        DEFB	"3 - 80 trilhas simples face",13,10
        DEFB	"4 - 80 trilhas dupla face",13,10
        DEFB	0

;	  Subroutine OEMSTA
;	     Inputs  ________________________
;	     Outputs ________________________

J$7922:	PUSH	HL
        PUSH	BC
        LD	DE,I$7959
        LD	HL,PROCNM
J$792A:	LD	A,(DE)
        OR	A
        JR	Z,J.7935
        CP	(HL)
J$792F:	JR	NZ,J.7955
        INC	HL
        INC	DE
        JR	J$792A
J$7934	EQU	$-1

J.7935:	LD	A,(HL)
J$7936:	AND	A
        JR	Z,J.7955
        CP	" "
        INC	HL
        JR	Z,J.7935
        LD	C,(HL)
        DEC	HL
        LD	B,(HL)
        LD	HL,I$4F4E
        XOR	A
        SBC	HL,BC
        LD	E,01H	; 1
        JR	Z,J.7956
        LD	HL,I$4F46
        XOR	A
        SBC	HL,BC
        LD	E,00H
        JR	Z,J.7956
J.7955:	SCF
J.7956:	POP	BC
        POP	HL
        RET

I$7959:	DEFB	"VERIFY"
        DEFB	0

;	  Subroutine DSKFMT
;	     Inputs  ________________________
;	     Outputs ________________________

J$7960:	PUSH	HL
        POP	IY
        DEC	A
        LD	E,A
        LD	A,03H	; 3
J$7967:	CP	E
        LD	A,0CH	; 12
        RET	C
        LD	A,B
J$796C:	CP	18H
        LD	A,0EH	; 14
        RET	C
        LD	A,D
        AND	01H	; 1
        LD	(IY+9),A
        PUSH	HL
        LD	BC,32
J$797A	EQU	$-1
        ADD	HL,BC
        LD	(IY+5),L
        LD	(IY+6),H
J$7982:	LD	D,00H
        LD	B,05H	; 5
        LD	HL,I$7BA2
J$7989:	ADD	HL,DE
        DJNZ	J$7989
        POP	DE
        LD	BC,5
        LDIR
        CALL	C.77B0			; INIHRD
        XOR	A
        LD	(IX+4),A
        LD	(IX+5),A
        LD	A,(IY+9)
        LD	DE,0
        LD	BC,000FFH
        CALL	C.766B
        RET	C
        CALL	DISINT
        DI
        LD	E,02H	; 2
        CALL	C.7B88
        RET	C
        LD	E,00H
        CALL	C.7B88
        RET	C
        LD	C,(IY+2)
        LD	B,09H	; 9
        LD	DE,0
J.79C1:	PUSH	DE
        PUSH	BC
        LD	A,(IY+9)
        CALL	C.766B
        LD	A,06H	; 6
        JR	C,J$79DB
        LD	(IY+7),D
        LD	L,(IY+5)
        LD	H,(IY+6)
        PUSH	HL
        CALL	C$7AAC
        POP	HL
J$79DB:	POP	BC
        POP	DE
        JR	NC,J$79E7
        PUSH	AF
        LD	A,(IY+9)
        LD	D,A
        JP	J.74C6

J$79E7:	PUSH	DE
        PUSH	BC
        LD	A,D
        OR	E
        JR	Z,J.79F8
        PUSH	HL
        LD	HL,27
        SBC	HL,DE
        POP	HL
        JR	C,J.79F8
        DEC	DE
        INC	B
J.79F8:	XOR	A
        LD	A,(IY+9)
        CALL	C.74BF			; DSKIO
        LD	A,04H	; 4
        POP	BC
        POP	DE
        RET	C
        PUSH	HL
        LD	HL,013BH
        BIT	0,C
        JR	Z,J$7A0D
        ADD	HL,HL
J$7A0D:	AND	A
        SBC	HL,DE
        POP	HL
        JR	NC,J$7A34
        PUSH	DE
        PUSH	BC
        PUSH	HL
        LD	B,01H	; 1
        LD	HL,7
        BIT	0,C
        JR	Z,J$7A22
        LD	HL,16
J$7A22:	AND	A
        EX	DE,HL
        SBC	HL,DE
        EX	DE,HL
        POP	HL
        XOR	A
        LD	A,(IY+9)
        CALL	C.74BF			; DSKIO
        LD	A,04H	; 4
        POP	BC
        POP	DE
        RET	C
J$7A34:	LD	H,00H
        LD	L,B
        ADD	HL,DE
        EX	DE,HL
        LD	A,(IY+4)
        SUB	D
        JR	NZ,J.79C1
        LD	A,(IY+3)
        SUB	E
        JP	NZ,J.79C1
        LD	L,(IY+5)
        LD	H,(IY+6)
        PUSH	HL
        LD	BC,12*512
J$7A50:	LD	(HL),00H
        INC	HL
        DEC	BC
        LD	A,B
        OR	C
        JR	NZ,J$7A50
        LD	L,(IY)
        LD	H,(IY+1)
        POP	DE
        PUSH	DE
        LD	BC,30
        LDIR
        LD	HL,I$7C45
        LD	BC,00D6H
        LDIR
        POP	HL
        PUSH	HL
        LD	A,(IY+2)
        INC	H
        INC	H
        LD	(HL),A
        INC	HL
        DEC	(HL)
        INC	HL
        DEC	(HL)
        INC	H
        INC	H
        INC	H
        INC	H
        CP	0F9H
        JR	NZ,J$7A83
        INC	H
        INC	H
J$7A83:	DEC	(HL)
        DEC	HL
        DEC	(HL)
        DEC	HL
        LD	(HL),A
        POP	HL
        PUSH	HL
        LD	B,0CH	; 12
        LD	C,A
        LD	A,(IY+9)
        LD	DE,0
        SCF
        CALL	C.74BF			; DSKIO
        POP	HL
        RET	C
        LD	BC,7*512
        ADD	HL,BC
        LD	B,02H	; 2
        LD	C,(IY+2)
        LD	DE,12
        LD	A,(IY+9)
        SCF
        JP	C.74BF			; DSKIO

;	  Subroutine __________________________
;	     Inputs  ________________________
;	     Outputs ________________________
C$7AAC:	LD	D,01H	; 1
        LD	A,4EH	; "N"
        LD	B,50H	; "P"
        CALL	C.7B9D
        CALL	C.7B9A
        LD	A,0F6H
        LD	B,03H	; 3
        CALL	C.7B9D
        LD	(HL),0FCH
        INC	HL
        LD	A,4EH	; "N"
        LD	B,32H	; "2"
        CALL	C.7B9D
J$7AC9:	CALL	C.7B9A
        LD	A,0F5H
        LD	B,03H	; 3
        CALL	C.7B9D
        LD	(HL),0FEH
        INC	HL
        CALL	C.77AA			; wait for FDC ready
        IN	A,(0D1H)
        LD	(HL),A
        INC	HL
        LD	A,(IY+7)
        AND	10H	; 16
        RRCA
        RRCA
        RRCA
        RRCA
        LD	(HL),A
        INC	HL
        LD	(HL),D
        INC	HL
        LD	(HL),02H	; 2
        INC	HL
        LD	(HL),0F7H
        INC	HL
        LD	A,4EH	; "N"
        LD	B,16H
        CALL	C.7B9D
        CALL	C.7B9A
        LD	A,0F5H
        LD	B,03H	; 3
        CALL	C.7B9D
        LD	(HL),0FBH
        INC	HL
        LD	BC,512
J$7B07:	LD	(HL),40H	; "@"
        INC	HL
        DEC	BC
        LD	A,B
        OR	C
        JR	NZ,J$7B07
        LD	(HL),0F7H
        INC	HL
        LD	B,54H	; "T"
        LD	A,4EH	; "N"
        CALL	C.7B9D
        INC	D
        LD	A,09H	; 9
        CP	D
        JR	NC,J$7AC9
        LD	(HL),0FFH
        LD	(IY+8),05H	; 5
J$7B25:	CALL	C.77AA			; wait for FDC ready
        LD	HL,I$7B62
        PUSH	HL
        LD	L,(IY+5)
        LD	H,(IY+6)
        CALL	DISINT
        DI
        LD	C,0D3H
        LD	E,03H	; 3
        LD	D,4EH	; "N"
        LD	A,0F4H
        OUT	(0D0H),A
        EX	(SP),IY
        EX	(SP),IY
J$7B44:	LD	A,(HL)
        INC	A
        JP	Z,J.7B55
J$7B49:	IN	A,(0D0H)
        RRCA
        RET	NC
        RRCA
        JR	NC,J$7B49
        OUTI
        JP	J$7B44

J.7B55:	IN	A,(0D0H)
        RRCA
        RET	NC
        RRCA
        JR	NC,J.7B55
        LD	A,D
        OUT	(0D3H),A
        JP	J.7B55

I$7B62:	IN	A,(0D0H)
        AND	7CH	; "|"
        PUSH	AF
        JR	NZ,J$7B6D
        EI
        CALL	ENAINT
J$7B6D:	POP	AF
        RET	Z
        LD	B,A
        BIT	6,B
        LD	A,00H
        JR	NZ,J$7B78
        LD	A,10H	; 16
J$7B78:	DEC	(IY+8)
        JR	NZ,J$7B25
J$7B7D:	PUSH	AF
        EI
        CALL	ENAINT
        XOR	A
        OUT	(0D4H),A		; unselect diskdrive, side 0, motor off
        POP	AF
        SCF
        RET

;	  Subroutine __________________________
;	     Inputs  ________________________
;	     Outputs ________________________

C.7B88:	LD	BC,0FFFFH
J$7B8B:	IN	A,(0D0H)
        AND	02H	; 2
        CP	E
        RET	Z
        DEC	BC
        LD	A,B
        OR	C
        JR	NZ,J$7B8B
        LD	A,02H	; 2
        JR	J$7B7D

;	  Subroutine __________________________
;	     Inputs  ________________________
;	     Outputs ________________________

C.7B9A:	XOR	A
        LD	B,0CH	; 12

;	  Subroutine __________________________
;	     Inputs  ________________________
;	     Outputs ________________________

C.7B9D:	LD	(HL),A
        INC	HL
        DJNZ	C.7B9D
        RET

I$7BA2:	DEFB	0B6H,07BH,0FCH,068H,001H
        DEFB	0D4H,07BH,0FDH,0D0H,002H
        DEFB	0F2H,07BH,0F8H,0D0H,002H
        DEFB	010H,07CH,0F9H,0A0H,005H

        DEFB	0EBH,0FEH,090H
        DEFB	"MSX-01  "
        DEFW	512
        DEFB	1
        DEFW	1
        DEFB	2
        DEFW	64
        DEFW	0168H
        DEFB	0FCH
        DEFW	2
        DEFW	9
        DEFW	1
        DEFW	0

        DEFB	0EBH,0FEH,090H
        DEFB	"MSX-02  "
        DEFW	512
        DEFB	2
        DEFW	1
        DEFB	2
        DEFW	112
        DEFW	02D0H
        DEFB	0FDH
        DEFW	2
        DEFW	9
        DEFW	2
        DEFW	0

        DEFB	0EBH,0FEH,090H
        DEFB	"MSX-03  "
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

        DEFB	0EBH,0FEH,090H
        DEFB	"MSX-04  "
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

J$7C2E:	PUSH	HL
        PUSH	DE
        LD	E,D
        LD	D,00H
        LD	HL,I7C3C-1
        ADD	HL,DE
        LD	A,(HL)
        POP	DE
        POP	HL
        LD	(HL),A
        RET

I7C3C:	DEFB	001H,004H,007H,002H,005H,008H,003H,006H,009H

I$7C45:	RET	NC
        LD	(D$C06B),DE
        LD	(D.C0F3),A
J$7C4D:	LD	(HL),68H	; "h"
        INC	HL
        LD	(HL),0C0H
J$7C52:	LD	SP,KBUF+256
        LD	DE,I$C0CD
        PUSH	DE
        LD	C,0FH	; 15
        CALL	BDOS
        OR	A
        JP	Z,J$C04B
        POP	DE
        LD	DE,I.C0A7
        LD	C,0FH	; 15
        CALL	BDOS
        INC	A
        JR	Z,J$7C9C
        LD	DE,I.C0A7
        PUSH	DE
        LD	DE,0100H
        LD	C,1AH
        CALL	BDOS
        LD	HL,1
        LD	(D$C0B5),HL
        LD	(D$C0DB),HL
        POP	DE
        LD	HL,04000H-0100H
        LD	C,27H	; "'"
        CALL	BDOS
        JP	0100H

?.7C8F:	LD	E,B
        RET	NZ
        CALL	0
        LD	A,C
        AND	0FEH
        CP	02H	; 2
        JP	NZ,J$C06A
J$7C9C:	LD	A,(D.C0F3)
        AND	A
        JP	Z,A4022
        LD	DE,I.C08B
        LD	C,09H	; 9
        CALL	BDOS
        LD	C,07H	; 7
        CALL	BDOS
        JR	J$7C52

?.7CB2:	DEFB	"Erro na carga",13,10
        DEFB	"Tecle algo",13,10
        DEFB	"$"

        DEFB	0
        DEFB	"MSXDOS  SYS"
        DEFW 	0
        DEFW	0
        DEFB	0,0,0,0
        DEFW	0
        DEFW	0
        DEFB	0
        DEFB	0
        DEFW	0
        DEFW	0
        DEFW	0
        DEFB	0,0,0,0,0

        DEFB	0
        DEFB	"SOLXDOS SIS"
        DEFW 	0
        DEFW	0
        DEFB	0,0,0,0
        DEFW	0
        DEFW	0
        DEFB	0
        DEFB	0
        DEFW	0
        DEFW	0
        DEFW	0
        DEFB	0,0,0,0,0

        DEFB	0


I7D1B:	RET	NZ
        LD	A,(D.C0F3)
        AND	A
        JP	Z,A4022
        LD	DE,I.C08B
J$7D26:	LD	C,09H	; 9
        CALL	BDOS
        LD	C,07H	; 7
        CALL	BDOS
        JR	J$7CD2

DEFB	"Erro na carga",13,10
        DEFB	"Tecle algo",13,10
        DEFB	"$"

        DEFB	0
        DEFB	"MSXDOS  SYS"
        DEFW 	0
        DEFW	0
        DEFB	0,0,0,0
        DEFW	0
        DEFW	0
        DEFB	0
        DEFB	0
        DEFW	0
        DEFW	0
        DEFW	0
        DEFB	0,0,0,0,0

        DEFB	0
        DEFB	"SOLXDOS SIS"
        DEFW 	0
        DEFW	0
        DEFB	0,0,0,0
        DEFW	0
        DEFW	0
        DEFB	0
        DEFB	0
        DEFW	0
        DEFW	0
        DEFW	0
        DEFB	0,0,0,0,0

        DEFB	0

        DEFS	07F00H-$,0FFH

        DEFB	0
        DEFB	"Erro na FAT"
        DEFB	0
        DEFB	"Acesso incorreto"
        DEFB	0
        DEFB	"Drive invalido"
        DEFB	0
        DEFB	"Setor invalido"
        DEFB	0
        DEFB	"Arquivo ja aberto"
        DEFB	0
        DEFB	"Arquivo existente"
        DEFB	0
        DEFB	"Disco cheio"
        DEFB	0
        DEFB	"Diretorio cheio"
        DEFB	0
        DEFB	"Disco protegido"
        DEFB	0
        DEFB	"Erro de E/S"
        DEFB	0
        DEFB	"Disco desconectado"
        DEFB	0
        DEFB	"Erro ao renomear"
        DEFB	0

        DEFS	08000H-$,0FFH

        END
