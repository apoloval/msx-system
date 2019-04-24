; Diskdriver Panasonic FS-FD1A
;
; FDC	TC8566AF

; Source re-created by Z80DIS 2.2
; Z80DIS was written by Kenneth Gielow, Palo Alto, CA

; Code Copyrighted by Panasonic and maybe others
; Source comments by Arjen Zeilemaker

; Sourcecode supplied for STUDY ONLY
; Recreation NOT permitted without authorisation of the copyrightholders


MYSIZE	EQU	26		; workspace for disk driver
                                ; +0 motor off timer
                                ; +1 disk change timer drive 0
                                ; +2 disk change timer drive 1
                                ; +3 current phantom drive
                                ; +4 not used
                                ; +5 b0 = read/write, b1 = verify
                                ; +6 b5 = motor on status drive 1, b4 = motor on status drive 0
                                ; +7 number of physical drives
                                ; +8 not used
                                ; +9 not used
                                ; +10 FDC command
                                ; +19 FDC command status

SECLEN	EQU	512


BDOS	EQU	0F37DH
DSKBAS	EQU	04022H
DOSLOD	EQU	00100H
ENAKRN	EQU	0F368H

        ORG	7405H

I$7405:
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

DEFDPB	EQU	$-1

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

        DEFB	0FCH
        DEFW	512
        DEFB	0FH
        DEFB	04H
        DEFB	00H
        DEFB	01H
        DEFW	1
        DEFB	2
        DEFB	64
        DEFW	9
        DEFW	0160H
        DEFB	2
        DEFW	5

        DEFB	0FDH
        DEFW	512
        DEFB	0FH
        DEFB	04H
        DEFB	01H
        DEFB	02H
        DEFW	1
        DEFB	2
        DEFB	112
        DEFW	12
        DEFW	0163H
        DEFB	2
        DEFW	5

        DEFB	0FEH
        DEFW	512
        DEFB	0FH
        DEFB	04H
        DEFB	00H
        DEFB	01H
        DEFW	1
        DEFB	2
        DEFB	64
        DEFW	7
        DEFW	013AH
        DEFB	1
        DEFW	3

        DEFB	0FFH
        DEFW	512
        DEFB	0FH
        DEFB	04H
        DEFB	01H
        DEFB	02H
        DEFW	1
        DEFB	2
        DEFB	112
        DEFW	10
        DEFW	013CH
        DEFB	1
        DEFW	3

;	  Subroutine DSKIO
;	     Inputs  ________________________
;	     Outputs ________________________

DSKIO:	EI
        PUSH	AF
        JP	NC,J$758C			; read dskio,
        PUSH	AF
        PUSH	BC
        PUSH	DE
        PUSH	HL
        CALL	C$74D7				; do write dskio
        POP	HL
        POP	DE
        POP	BC
        JR	C,J$74AD			; error,
        LD	A,2
        LD	(IX+5),A			; set verify flag
        JR	J$74CC

J$74AD:	POP	DE
J.74AE:	EI
        POP	DE
        PUSH	AF
        LD	C,60				; 1 second (NTSC)
        JR	NC,J$74B7
        LD	C,0
J$74B7:	LD	(IX+0),240			; 4 seconds (NTSC)
        LD	A,D
        AND	A
        CALL	C.78B4				; C6=1 (?? In Use LED off)
        JR	NZ,J$74C7
        LD	(IX+1),C
        POP	AF
        RET

J$74C7:	LD	(IX+2),C
        POP	AF
        RET

J$74CC:	POP	AF
        AND	A				; read
        CALL	C.7592				; do read dskio
        RES	1,(IX+5)			; reset verify flag
        JR	J.74AE

;	  Subroutine __________________________
;	     Inputs  ________________________
;	     Outputs ________________________

C$74D7:	CALL	C.7627				; initialise for disk i/o
        RET	C
        CALL	DISINT
        DI
        PUSH	HL
        LD	HL,ENAINT
        EX	(SP),HL
        LD	A,H
        AND	A				; transfer page 2/3 ?
        JP	M,J.7516			; yep,
        SCF					; dskio write
        CALL	C.7A2F				; dskio page 0/1
        RET	C
        INC	B
        DEC	B
        RET	Z
        LD	A,H
        AND	A
        JP	M,J.7516
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
        CALL	C.750D				; write sector (READY from drive)
        POP	HL
        JR	J$7519

;	  Subroutine __________________________
;	     Inputs  ________________________
;	     Outputs ________________________

C.750D:	CALL	C.78A2				; READY input from diskdrive
        CALL	C$7521				; write sector
        JP	J.75E6

J.7516:	CALL	C.750D				; write sector (READY from drive)
J$7519:	RET	C
        DEC	B
        RET	Z
        CALL	C.78F7				; setup for next sector
        JR	J.7516

;	  Subroutine write sector
;	     Inputs  ________________________
;	     Outputs ________________________

C$7521:	LD	E,11
J$7523:	PUSH	HL
        PUSH	DE
        PUSH	BC
        LD	DE,I$755A
        PUSH	DE
        LD	DE,I.79C6
        PUSH	DE				; wait 16.5 ms
        LD	(IX+10),45H			; WRITE DATA, MFM, no multi track
        LD	B,9
        CALL	C.7954				; start FDC command
        LD	DE,L7FFA
        LD	B,00H
J.753C:	LD	A,(DE)
        ADD	A,A				; ready to receive data ?
        JP	NC,J.753C			; nope, wait
        ADD	A,A
        RET	P				; no more data, quit
        LD	A,(HL)
        LD	(L7FFB),A
        INC	HL
        DJNZ	J.753C
J.754A:	LD	A,(DE)
        ADD	A,A				; ready to receive data ?
        JP	NC,J.754A			; nope, wait
        ADD	A,A
        RET	P				; no more data, quit
        LD	A,(HL)
        LD	(L7FFB),A
        INC	HL
        DJNZ	J.754A
        POP	BC
        POP	BC
I$755A:	CALL	C.79CF				; terminate FDC transfer
        CALL	C.79AE				; get command status
        POP	BC
        POP	DE
        POP	HL
        LD	A,(IX+19)
        AND	0C8H				; interrupt code + not ready
        RET	Z				; normal termination + ready, quit without error
        AND	08H
        JP	NZ,J.7588			; not ready,
        BIT	1,(IX+20)
        JR	NZ,J$7585			; write protect,
        CALL	C.7928				; reseek every 2nd try
        DEC	E
        JR	NZ,J$7523			; next try
        SCF
        BIT	4,(IX+19)
        LD	A,10
        RET	NZ				; equipment check, quit with
        JP	J.79DE				; return error based uppon ST1

J$7585:	XOR	A
        SCF
        RET

J.7588:	LD	A,2
        SCF
        RET

J$758C:	CALL	C.7592				; do dskio
        JP	J.74AE

;	  Subroutine __________________________
;	     Inputs  ________________________
;	     Outputs ________________________

C.7592:	CALL	C.7627				; initialise for disk i/o
        RET	C
        CALL	DISINT
        DI
        PUSH	HL
        LD	HL,ENAINT
        EX	(SP),HL
        LD	A,H
        AND	A
        JP	M,J.75EC
                                                ; dskio read (Cx was already reset)
        CALL	C.7A2F				; dskio page 0/1
        RET	C
        INC	B
        DEC	B
        RET	Z
        LD	A,H
        AND	A
        JP	M,J.75EC
        BIT	1,(IX+5)			; verify ?
        JR	NZ,J$75D2			; yep, no need for $SEBUF trick, just verify
        PUSH	HL
        LD	HL,(_SECBUF)
        CALL	C.75E0				; read sector (READY from drive)
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
        JR	J.75FB

J$75D2:	CALL	C.75D8				; verify sector (READY from drive)
        RET	C
        JR	J.75FB

;	  Subroutine verify sector
;	     Inputs  ________________________
;	     Outputs ________________________

C.75D8:	CALL	C.78A2				; READY input from diskdrive
        CALL	C.7602				; read or verify sector
        JR	J.75E6

;	  Subroutine read sector
;	     Inputs  ________________________
;	     Outputs ________________________

C.75E0:	CALL	C.78A2				; READY input from diskdrive
        CALL	C.7602				; read or verify sector
J.75E6:	PUSH	AF
        CALL	C.78A8				; READY input high (not from diskdrive)
        POP	AF
        RET

J.75EC:	BIT	1,(IX+5)			; verify ?
        JR	Z,J$75F7			; nope,
        CALL	C.75D8				; verify sector (READY from drive)
        JR	J$75FA

J$75F7:	CALL	C.75E0				; read sector (READY from drive)
J$75FA:	RET	C
J.75FB:	DEC	B
        RET	Z
        CALL	C.78F7				; setup for next sector
        JR	J.75EC

;	  Subroutine read or verify sector
;	     Inputs  ________________________
;	     Outputs ________________________

C.7602:	LD	E,11
J$7604:	BIT	1,(IX+5)			; verify ?
        JR	Z,J$760F			; nope,
        CALL	C.78BA				; verify sector
        JR	J$7612

J$760F:	CALL	C$79EE				; read sector
J$7612:	LD	A,(IX+19)
        AND	0C8H				; interrupt code + not ready
        RET	Z				; normal termination + ready, quit without error
        AND	08H
        JP	NZ,J.7588			; not ready,
        CALL	C.7928				; reseek every 2nd try
        DEC	E
        JR	NZ,J$7604			; next try
        SCF
        JP	J.79DE				; return error based uppon ST1

;	  Subroutine __________________________
;	     Inputs  ________________________
;	     Outputs ________________________

C.7627:	PUSH	AF
        PUSH	BC
        PUSH	HL
        CALL	GETWRK
        POP	HL
        POP	BC
        POP	AF
        RES	0,(IX+5)
        JR	NC,J$763A
        SET	0,(IX+5)			; write operation
J$763A:	CP	2
        JR	C,J$7642
J$763E:	LD	A,0CH
        SCF
        RET

J$7642:	PUSH	AF
        LD	A,C
        CP	0F8H
        JR	NC,J$764B
        POP	AF
        JR	J$763E

J$764B:	POP	AF
        PUSH	IX
        PUSH	BC
        PUSH	DE
        PUSH	AF
        LD	A,(IX+7)
        DEC	A				; 1 physical drive ?
        JR	NZ,J.7671			; nope,
        POP	AF
        LD	B,0				; physical drive 0
        PUSH	BC
        CP	(IX+3)
        JR	Z,J.7671
        LD	(IX+3),A
        XOR	A
        LD	(IX+0),A
        LD	A,04H
        LD	(L7FF8),A			; motor off both drives, enable FDC
        PUSH	HL
        CALL	PROMPT
        POP	HL
J.7671:	POP	AF
        POP	DE
        POP	BC
        POP	IX
        LD	(IX+15),02H			; sector length 512 bytes
        LD	(IX+16),09H
        LD	(IX+17),50H
        LD	(IX+18),0FFH
        PUSH	HL
        PUSH	AF
        PUSH	BC
        BIT	1,C
        LD	C,E
        LD	B,D
        LD	DE,8
        JR	NZ,J$7693
        INC	DE
J$7693:	CALL	DIV16
        INC	L
        LD	(IX+14),L			; sector
        LD	L,C
        POP	BC
        POP	AF
        LD	(IX+11),A			; physical drive
        AND	A
        LD	A,14H				; motor on drive 0, disable INTRQ/DRQ, enable FDC, drive 0
        JR	Z,J$76A7
        LD	A,25H				; motor on drive 1, disable INTRQ/DRQ, enable FDC, drive 1
J$76A7:	LD	H,A
        LD	D,A
        BIT	0,C				; double sided ?
        JR	Z,J.76BB			; nope,
        SRL	L
        JR	NC,J.76BB
        SET	2,(IX+11)			; head 1 (physical head)
        LD	(IX+13),1			; head 1 (head in sector id)
        JR	J$76C3

J.76BB:	RES	2,(IX+11)			; head 0 (physical head)
        LD	(IX+13),0			; head 0 (head in sector id)
J$76C3:	LD	A,C
        RRCA
        RRCA
        AND	0C0H
        OR	D
        LD	D,A
        DI
        LD	A,(IX+6)			; current motor on status
        OR	H
        LD	(L7FF8),A
        AND	30H
        LD	(IX+6),A			; new motor on status
        CALL	C.78AE				; C6=0 (?? In Use LED on)
        LD	(IX+0),0FFH
        EI
        LD	C,L
        CALL	C.78A2				; READY input from diskdrive
        CALL	C.7711				; sense device
        PUSH	AF
        CALL	C.78A8				; READY input high (not from diskdrive)
        POP	AF
        JR	C,J$770D
        BIT	6,A
        JR	Z,J.76FB
        BIT	0,(IX+5)			; read operation ?
        JR	Z,J.76FB			; yep,
        POP	HL
        XOR	A
        SCF
        RET

J.76FB:	PUSH	BC
        INC	C
        LD	A,80-1
        CP	C
        JR	NC,J$7704
        DEC	C
        DEC	C
J$7704:	CALL	C.7939				; select track
        POP	BC
        CALL	C.7939				; select track
        POP	HL
        RET

J$770D:	POP	HL
        LD	A,2
        RET

;	  Subroutine __________________________
;	     Inputs  ________________________
;	     Outputs ________________________

C.7711:	LD	(IX+10),04H			; SENSE DEVICE STATUS
        PUSH	BC
        LD	HL,01388H
J$7719:	DEC	HL
        LD	A,L
        OR	H
        JR	Z,J$7730
        LD	B,2
        CALL	C.7954				; start FDC command
        CALL	C.79AE				; get command status
        LD	A,(IX+19)
        BIT	5,A				; FDD ready ?
        JR	Z,J$7719			; nope, wait
        POP	BC
        AND	A
        RET

J$7730:	POP	BC
        SCF
        RET

INIHRD:	LD	HL,0
        ADD	HL,SP
        PUSH	HL
        POP	IY
        LD	DE,16
        XOR	A
        SBC	HL,DE
        LD	SP,HL
        INC	HL
        LD	DE,10
        XOR	A
        SBC	HL,DE
        PUSH	HL
        POP	IX
        LD	(L7FF8),A			; motor off, disable INTRQ/DRQ, reset FDC, drive 0
        LD	A,0FAH
        LD	(L7FF9),A			; enable C6, C6=1 (?? In Use LED off), enable C4, C4=1 (force READY HIGH), enable C2, not in standby, enable C0, no TC
        LD	A,04H
        LD	(L7FF8),A			; motor off, disable INTRQ/DRQ, enable FDC, drive 0
        LD	(IX+10),03H			; SPECIFY
        LD	(IX+11),0DFH			; SRT=13, HUT=15 (step rate=3 ms, head unload time=240 ms)
        LD	(IX+12),09H			; HLT=2,ND=1 (head load time=4 ms, non DMA mode)
        LD	B,3
        CALL	C.7954				; start FDC command
        LD	A,04H				; motor off, disable INTRQ/DRQ, enable FDC, drive 0
        CALL	C.777C				; initialize drive
        LD	SP,IY

MTOFF:	CALL	C.78B4				; C6=1 (?? In Use LED off)
        LD	A,04H				; motor off, disable INTRQ/DRQ, enable FDC, drive 0
        LD	(L7FF8),A
        LD	(IX+6),A			; motor on status = all off
        RET

;	  Subroutine __________________________
;	     Inputs  ________________________
;	     Outputs ________________________

C.777C:	LD	(L7FF8),A
        AND	0FBH
        LD	(IX+11),A			; physical drive
        LD	(IX+10),0FH			; SEEK
        LD	(IX+12),05H			; cylinder 5
        LD	B,3
        CALL	C.7954				; start FDC command
        CALL	C.7988				; wait for command and sense interrupt status
        RET	C				; seek failed, quit with error
        LD	(IX+10),07H			; RECALIBRATE
        LD	B,2
        CALL	C.7954				; start FDC command
        JP	C.7988				; wait for command and sense interrupt status

DRIVES:	PUSH	BC
        PUSH	AF
        CALL	GETWRK
        LD	A,05H				; motor off, disable INTRQ/DRQ, enable FDC, drive 1
        CALL	C.777C				; initalize drive
        LD	L,1
        JR	NC,J$77BD
        LD	(IX+7),L
        LD	A,04H
        LD	(L7FF8),A			; motor off, disable INTRQ/DRQ, enable FDC, drive 0
        POP	AF
        JR	Z,J.77BB
        INC	L
J.77BB:	POP	BC
        RET

J$77BD:	INC	L
        LD	(IX+7),L
        LD	A,04H
        LD	(L7FF8),A			; motor off, disable INTRQ/DRQ, enable FDC, drive 0
        POP	AF
        JR	NZ,J.77BB
        DEC	L
        JR	J.77BB

INIENV:	LD	A,1
        LD	(RAWFLG),A
        CALL	GETWRK
        XOR	A
        LD	B,7
J$77D7:	LD	(HL),A
        INC	HL
        DJNZ	J$77D7
        LD	HL,I$77E1
        JP	SETINT

I$77E1:	PUSH	AF
        CALL	GETWRK
        LD	A,(HL)
        AND	A
        JR	Z,J.77F9
        CP	0FFH
        JR	Z,J.77F9
        DEC	A
        LD	(HL),A
        JR	NZ,J.77F9
        LD	A,04H
        LD	(L7FF8),A			; motor off, disable INTRQ/DRQ, enable FDC, drive 0
        LD	(IX+6),A			; motor on status = all off
J.77F9:	INC	HL
        LD	A,(HL)
        AND	A
        JR	Z,J$77FF
        DEC	(HL)
J$77FF:	INC	HL
        LD	A,(HL)
        AND	A
        JR	Z,J$7805
        DEC	(HL)
J$7805:	POP	AF
        JP	PRVINT

DSKCHG:	EI
        PUSH	HL
        PUSH	BC
        PUSH	AF
        CALL	GETWRK
        POP	AF
        POP	BC
        POP	HL
        AND	A
        LD	B,(IX+2)
        JR	NZ,J$781C
        LD	B,(IX+1)
J$781C:	INC	B
        DEC	B
        LD	B,01H	; 1
        RET	NZ
        PUSH	BC
        PUSH	HL
        LD	DE,1
        LD	HL,(_SECBUF)
        AND	A
        CALL	DSKIO
        JR	C,J.7845
        LD	HL,(_SECBUF)
        LD	B,(HL)
        POP	HL
        PUSH	BC
        CALL	GETDPB
        LD	A,0CH	; 12
        JR	C,J.7845
        POP	AF
        POP	BC
        CP	C
        SCF
        CCF
        LD	B,0FFH
        RET	NZ
        INC	B
J.7845:	POP	DE
        POP	DE
        RET

;	  Subroutine __________________________
;	     Inputs  ________________________
;	     Outputs ________________________

GETDPB:	EI
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
        ADD	HL,BC				; *18
        LD	BC,I$7405
        ADD	HL,BC
        LD	BC,18
        LDIR
        RET

CHOICE:	LD	HL,I$7867
        RET

I$7867:	DEFB	13,10
        DEFB	"1 - 1 side, double track",13,10
        DEFB	"2 - 2 sides,double track",13,10
        DEFB	13,10
        DEFB	0

OEMSTA:	SCF
        RET

;	  Subroutine __________________________
;	     Inputs  ________________________
;	     Outputs ________________________

C.78A2:	LD	A,20H
        LD	(L7FF9),A			; enable C4, C4=0 (READY from drive)
        RET

;	  Subroutine __________________________
;	     Inputs  ________________________
;	     Outputs ________________________

C.78A8:	LD	A,30H
        LD	(L7FF9),A			; enable C4, C4=1 (force READY high)
        RET

;	  Subroutine __________________________
;	     Inputs  ________________________
;	     Outputs ________________________

C.78AE:	LD	A,80H
        LD	(L7FF9),A			; enable C6, C6=0 (?? In Use LED on)
        RET

;	  Subroutine __________________________
;	     Inputs  ________________________
;	     Outputs ________________________

C.78B4:	LD	A,0C0H
        LD	(L7FF9),A			; enable C6, C6=1 (?? In Use LED off)
        RET

;	  Subroutine Verify sector
;	     Inputs  ________________________
;	     Outputs ________________________

C.78BA:	PUSH	HL
        PUSH	DE
        PUSH	BC
        LD	DE,I$78ED
        PUSH	DE
        LD	DE,I.79C6
        PUSH	DE				; wait 16.5 ms
        LD	(IX+10),46H			; READ DATA, MFM, no multi track, do not skip DELETED DATA MARK
        LD	B,9
        CALL	C.7954				; start FDC command
        LD	DE,L7FFA
        LD	B,0
J.78D3:	LD	A,(DE)
        ADD	A,A				; ready to send data ?
        JP	NC,J.78D3			; nope, wait
        ADD	A,A
        RET	P				; no more data, quit
J$78DA:	LD	A,(L7FFB)
        DJNZ	J.78D3
J.78DF:	LD	A,(DE)
        ADD	A,A				; ready to send data ?
        JP	NC,J.78DF			; nope, wait
        ADD	A,A
        RET	P				; no more data, quit
        LD	A,(L7FFB)
        DJNZ	J.78DF
        POP	BC
        POP	BC
I$78ED:	CALL	C.79CF				; terminate FDC transfer
        CALL	C.79AE				; get command status
        POP	BC
        POP	DE
        POP	HL
        RET

;	  Subroutine __________________________
;	     Inputs  ________________________
;	     Outputs ________________________

C.78F7:	INC	H
        INC	H
        LD	A,(IX+14)
        INC	A
J$78FD:	LD	(IX+14),A			; next sector
        BIT	7,D				; 9 sectors per track ?
        JR	NZ,J$7907			; nope, 8 sectors per track
        CP	9+1
        RET	C
J$7907:	CP	8+1
        RET	C
        LD	(IX+14),1			; sector 1
        BIT	6,D				; single sided ?
        JR	Z,J$7925			; yep, next track
        LD	A,(IX+13)
        XOR	01H
        LD	(IX+13),A			; flip head
        JR	Z,J$7921
        SET	2,(IX+11)			; head 1
        RET

J$7921:	RES	2,(IX+11)			; head 0
J$7925:	INC	C
        JR	C.7939				; select track

;	  Subroutine __________________________
;	     Inputs  ________________________
;	     Outputs ________________________

C.7928:	BIT	0,E
        RET	NZ
        LD	(IX+10),07H			; RECALIBRATE
        PUSH	BC
        LD	B,2
        CALL	C.7954				; start FDC command
        CALL	C.7988				; wait for command and sense interrupt status
        POP	BC
                                                ; select track

;	  Subroutine select track
;	     Inputs  ________________________
;	     Outputs ________________________

C.7939:	PUSH	BC
        LD	(IX+10),0FH			; SEEK
        LD	(IX+12),C			; cylinder
        LD	B,3
        CALL	C.7954				; start FDC command
        CALL	C.7988				; wait for command and sense interrupt status
        LD	BC,1788
J$794C:	DEC	BC
        LD	A,B
        OR	C
        JR	NZ,J$794C
        POP	BC
        XOR	A
        RET

;	  Subroutine start FDC command
;	     Inputs  ________________________
;	     Outputs ________________________

C.7954:	PUSH	HL
        LD	HL,2000
J$7958:	LD	A,(L7FFA)
        AND	10H				; FDC busy ?
        JR	Z,J$7967			; nope, go
        DEC	HL
        LD	A,H
        OR	L
        JR	NZ,J$7958
        POP	HL
        SCF
        RET

J$7967:	PUSH	DE
        PUSH	IX
        LD	DE,10
        ADD	IX,DE
        PUSH	IX
        POP	HL
        POP	IX
        POP	DE
J.7975:	LD	A,(L7FFA)
        AND	0C0H
        CP	80H				; ready to receive ?
        JR	NZ,J.7975			; nope, wait
        LD	A,(HL)
        LD	(L7FFB),A
        INC	HL
        DJNZ	J.7975
        POP	HL
        XOR	A
        RET

;	  Subroutine __________________________
;	     Inputs  ________________________
;	     Outputs ________________________

C.7988:	LD	A,(L7FFA)
        AND	10H				; FDC busy ?
        JR	NZ,C.7988			; yep, wait
J$798F:	CALL	C$799E				; sense interrupt status
        LD	A,(IX+19)
        BIT	5,A				; seek completed ?
        JR	Z,J$798F			; nope, wait
        AND	0C0H				; terminated normally ?
        RET	Z				; yep, quit
        SCF					; quit with error
        RET

;	  Subroutine __________________________
;	     Inputs  ________________________
;	     Outputs ________________________

C$799E:	PUSH	BC
        LD	(IX+10),08H			; SENSE INTERRUPT STATUS
        LD	B,1
        CALL	C.7954				; start FDC command
        CALL	C.79AE				; get command status
        XOR	A
        POP	BC
        RET

;	  Subroutine get command status
;	     Inputs  ________________________
;	     Outputs ________________________

C.79AE:	PUSH	IX
J.79B0:	LD	A,(L7FFA)
        ADD	A,A				; ready to send ?
        JR	NC,J.79B0			; nope, wait
        JP	P,J$79C3			; no more data, quit
        LD	A,(L7FFB)
        LD	(IX+19),A
        INC	IX
        JR	J.79B0

J$79C3:	POP	IX
        RET

;	  Subroutine Wait 16.5 ms
;	     Inputs  ________________________
;	     Outputs ________________________

I.79C6:	LD	BC,1960
J$79C9:	DEC	BC
        LD	A,B
        OR	C
        JR	NZ,J$79C9
        RET

;	  Subroutine terminate FDC transfer
;	     Inputs  ________________________
;	     Outputs ________________________

C.79CF:	LD	A,02H
        LD	(L7FF9),A			; enable C0, C0=0
        INC	A
        LD	(L7FF9),A			; enable C0, C0=1
        NOP
        DEC	A
        LD	(L7FF9),A			; enable C0, C0=0
        RET

J.79DE:	LD	E,(IX+20)
        BIT	2,E
        LD	A,08H
        RET	NZ				; no data, quit with
        BIT	5,E
        LD	A,04H
        RET	NZ				; data error, quit with
        LD	A,0CH
        RET

L_WRHP	EQU	$-C.78F7

;	  Subroutine read sector
;	     Inputs  ________________________
;	     Outputs ________________________

C$79EE:	PUSH	HL
        PUSH	DE
        PUSH	BC
        LD	DE,I$7A25
        PUSH	DE
        LD	DE,I.79C6
        PUSH	DE				; wait 16.5 ms
        LD	(IX+10),46H			; READ DATA, MFM, no multi track, do not skip DELETED DATA MARK
        LD	B,9
        CALL	C.7954				; start FDC command
        LD	DE,L7FFA
        LD	B,0
J.7A07:	LD	A,(DE)
        ADD	A,A				; ready to send ?
        JP	NC,J.7A07			; nope, wait
        ADD	A,A
        RET	P				; no more data, quit
        LD	A,(L7FFB)
        LD	(HL),A
        INC	HL
        DJNZ	J.7A07
J.7A15:	LD	A,(DE)
        ADD	A,A				; ready to send ?
        JP	NC,J.7A15			; nope, wait
        ADD	A,A
        RET	P				; no more data, quit
        LD	A,(L7FFB)
        LD	(HL),A
        INC	HL
        DJNZ	J.7A15
        POP	BC
        POP	BC
I$7A25:	CALL	C.79CF				; terminate FDC transfer
        CALL	C.79AE				; get command status
        POP	BC
        POP	DE
        POP	HL
        RET

L_RDHP	EQU	$-C.78F7

;	  Subroutine dskio page 0/1
;	     Inputs  ________________________
;	     Outputs ________________________

C.7A2F:	PUSH	HL
        PUSH	IY
        PUSH	DE
        PUSH	BC
        PUSH	AF
        LD	DE,I$7AF3
        LD	HL,I$7B5B
        LD	BC,L_RDIO
        JR	NC,J$7A49
        LD	DE,I$7B01
        LD	HL,I$7BC7
        LD	BC,L_WRIO
J$7A49:	PUSH	DE
        LD	DE,(_SECBUF)
        LDIR
        POP	HL
        PUSH	DE
J$7A52:	LD	E,(HL)
        INC	HL
        LD	D,(HL)
        INC	HL
        LD	A,D
        OR	E
        JR	Z,J$7A6F
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
        JR	J$7A52

J$7A6F:	POP	DE
        POP	AF
        PUSH	AF
        PUSH	DE
        LD	HL,C.78F7
        LD	BC,L_RDHP
        JR	NC,J$7A7E
        LD	BC,L_WRHP
J$7A7E:	LDIR
        POP	IY
        PUSH	AF
        POP	AF
        LD	HL,I$7B1B
        LD	B,15
        JR	NC,J.7A8D
        LD	B,8
J.7A8D:	PUSH	BC
        LD	E,(HL)
        INC	HL
        LD	D,(HL)
        INC	HL				; offset
        PUSH	HL
        PUSH	IY
        POP	HL				; start routine (in _SECBUF)
        ADD	HL,DE
        INC	HL
        LD	C,(HL)
        INC	HL
        LD	B,(HL)				; original
        PUSH	HL
        PUSH	IY
        POP	HL
        LD	DE,C.78F7
        XOR	A
        SBC	HL,DE
        POP	DE
        ADD	HL,BC
        EX	DE,HL
        LD	(HL),D
        DEC	HL
        LD	(HL),E
        POP	HL
        POP	BC
        DJNZ	J.7A8D
        POP	AF
        PUSH	AF
        LD	HL,I$7B39
        LD	B,12
        JR	NC,J.7ABA
        LD	B,9
J.7ABA:	PUSH	BC
        LD	E,(HL)
        INC	HL
        LD	D,(HL)
        INC	HL
        PUSH	HL
        PUSH	IY
        POP	HL
        ADD	HL,DE
        INC	HL
        INC	HL
        LD	(HL),0BFH
        POP	HL
        POP	BC
        DJNZ	J.7ABA
        POP	AF
        JR	C,J.7AEA
        BIT	1,(IX+5)			; verify ?
        JR	Z,J.7AEA			; nope,
        LD	HL,I$7B51
J$7AD8:	LD	E,(HL)
        INC	HL
        LD	D,(HL)
        INC	HL
        LD	A,D
        OR	E
        JR	Z,J.7AEA
        PUSH	HL
        PUSH	IY
        POP	HL
        ADD	HL,DE
        LD	(HL),00H
        POP	HL
        JR	J$7AD8

J.7AEA:	POP	BC
        POP	DE
        POP	IY
        LD	HL,(_SECBUF)
        EX	(SP),HL
        RET

; offset table read dskio

I$7AF3:	DEFW	0006H
        DEFW	001EH
        DEFW	0028H
        DEFW	003AH
        DEFW	0043H
        DEFW	0049H
        DEFW	0

; offset table write dskio

I$7B01:	DEFW	0006H
        DEFW	001EH
        DEFW	002BH
        DEFW	0043H
        DEFW	0051H
        DEFW	002FH
        DEFW	0039H
        DEFW	005FH
        DEFW	0067H
        DEFW	0077H
        DEFW	0086H
        DEFW	0094H
        DEFW	0

; offset table support routines (78F7) CALL/JP

I$7B1B:	DEFW	003BH
        DEFW	003EH
        DEFW	004CH
        DEFW	004FH
        DEFW	0098H
        DEFW	00AEH
        DEFW	00B1H
        DEFW	00BFH
        DEFW	00FAH
        DEFW	00FEH
        DEFW	0108H
        DEFW	0112H
        DEFW	0120H
        DEFW	012EH
        DEFW	0131H

; offset table support routines (78F7) I/O

I$7B39:	DEFW	0061H
        DEFW	007EH
        DEFW	0088H
        DEFW	0091H
        DEFW	00B9H
        DEFW	00C2H
        DEFW	00DAH
        DEFW	00DEH
        DEFW	00E3H
        DEFW	010BH
        DEFW	0117H
        DEFW	0125H

; offset table support routines (78F7) verify

I$7B51:	DEFW	011AH
        DEFW	011BH
        DEFW	0128H
        DEFW	0129H
        DEFW	0

;	  Subroutine read dskio page 0/1
;	     Inputs  ________________________
;	     Outputs ________________________

I$7B5B:
        .PHASE	0

        PUSH	HL
        PUSH	DE
        PUSH	BC
        CALL	GETSLT
        LD	(R0060+1),A
        LD	H,80H
        CALL	ENASLT
        LD	A,(RAMAD1)
        LD	H,40H
        CALL	ENASLT
        POP	BC
        POP	DE
        POP	HL
J$7B74:	DEC	HL
        LD	A,H
        ADD	A,HIGH 512
        INC	HL
        JP	M,R0051
        LD	E,11
J$7B7E:	LD	A,20H
        LD	(LBFF9),A			; READY from drive
        CALL	C$79EE-C.78F7+L_RDIO		; read sector
        LD	A,30H
        LD	(LBFF9),A			; force READY high
        LD	A,(IX+19)
        AND	0C8H				; interrupt code + not ready
        JR	NZ,J$7B9A			; not terminated normally or not ready,
        DEC	B
        JR	Z,R0051
        CALL	C.78F7-C.78F7+L_RDIO		; setup for next sector
        JR	J$7B74

J$7B9A:	AND	08H				; not ready ?
        JR	NZ,J$7BA9			; yep,
        CALL	C.7928-C.78F7+L_RDIO		; reseek every 2nd try
        DEC	E
        JR	NZ,J$7B7E
        CALL	J.79DE-C.78F7+L_RDIO		; return error based uppon ST1
        JR	J$7BAB

J$7BA9:	LD	A,02H
J$7BAB:	SCF
R0051:	PUSH	HL
        PUSH	DE
        PUSH	BC
        PUSH	AF
        LD	A,(RAMAD2)
        LD	H,80H
        CALL	ENASLT
        CALL	ENAKRN
R0060:	LD	A,0
        LD	H,40H
        CALL	ENASLT
        POP	AF
        POP	BC
        POP	DE
        POP	HL
        RET

        .DEPHASE
L_RDIO	EQU	$-I$7B5B

;	  Subroutine write dskio page 0/1
;	     Inputs  ________________________
;	     Outputs ________________________

I$7BC7:
        .PHASE	0

        PUSH	HL
        PUSH	DE
        PUSH	BC
        CALL	GETSLT
        LD	(W00AE+1),A
        LD	H,80H
        CALL	ENASLT
        LD	A,(RAMAD1)
        LD	H,40H
        CALL	ENASLT
        POP	BC
        POP	DE
        POP	HL
J$7BE0:	DEC	HL
        LD	A,H
        ADD	A,02H
        INC	HL
        JP	M,W009F
        LD	E,11
J$7BEA:	PUSH	HL
        PUSH	DE
        PUSH	BC
        LD	A,20H
        LD	(LBFF9),A			; READY from drive
        LD	DE,W005F
        PUSH	DE
        LD	DE,I.79C6-C.78F7+L_WRIO		; wait 16.5 ms
        PUSH	DE
        LD	(IX+10),45H
        LD	B,09H
        CALL	C.7954-C.78F7+L_WRIO		; start FDC command
        LD	DE,LBFFA
        LD	B,0
W0041:	LD	A,(DE)
        ADD	A,A
        JP	NC,W0041
        ADD	A,A
        RET	P
        LD	A,(HL)
        LD	(LBFFB),A
        INC	HL
        DJNZ	W0041
W004F:	LD	A,(DE)
        ADD	A,A
        JP	NC,W004F
        ADD	A,A
        RET	P
        LD	A,(HL)
        LD	(LBFFB),A
        INC	HL
        DJNZ	W004F
        POP	BC
        POP	BC
W005F:	CALL	C.79CF-C.78F7+L_WRIO		; terminate FDC transfer
        LD	A,30H
        LD	(LBFF9),A			; force READY high
        CALL	C.79AE-C.78F7+L_WRIO		; get command status
        POP	BC
        POP	DE
        POP	HL
        LD	A,(IX+19)
        AND	0C8H				; interrupt code + not ready
        JR	NZ,J$7C43			; not terminated normally or not ready,
        DEC	B
        JR	Z,W009F
        CALL	C.78F7-C.78F7+L_WRIO		; setup for next sector
        JR	J$7BE0

J$7C43:	AND	08H				; not ready ?
        JR	NZ,J$7C63			; yep,
        BIT	1,(IX+20)			; not writeable ?
        JR	NZ,J$7C60			; yep,
        CALL	C.7928-C.78F7+L_WRIO		; reseek every 2nd try
        DEC	E
        JR	NZ,J$7BEA
        BIT	4,(IX+19)			; equipment check ?
        LD	A,0AH
        JR	NZ,J.7C65			; yep,
        CALL	J.79DE-C.78F7+L_WRIO		; return error based uppon ST1
        JR	J.7C65

J$7C60:	XOR	A
        JR	J.7C65

J$7C63:	LD	A,02H
J.7C65:	SCF
W009F:	PUSH	HL
        PUSH	DE
        PUSH	BC
        PUSH	AF
        LD	A,(RAMAD2)
        LD	H,80H
        CALL	ENASLT
        CALL	ENAKRN
W00AE:	LD	A,0
        LD	H,40H
        CALL	ENASLT
        POP	AF
        POP	BC
        POP	DE
        POP	HL
        RET

        .DEPHASE
L_WRIO	EQU	$-I$7BC7

DSKFMT:	PUSH	HL
        POP	IY
        DEC	A
        LD	(IY+9),A			; choice
        LD	E,A
        LD	A,01H
        CP	E
        LD	A,0CH
        RET	C				; choice invalid, quit
        LD	A,B
        CP	14H
        LD	A,0EH
        RET	C				; size of workspace to small, quit
        LD	A,D
        AND	01H
        LD	(IY+8),A			; drive
        LD	D,A
        PUSH	BC
        PUSH	HL
        PUSH	DE
        CALL	GETWRK
        POP	DE
        LD	A,(IX+7)
        DEC	A				; 1 physical drive ?
        JR	NZ,J$7CB7			; nope,
        LD	A,D
        CP	(IX+3)
        JR	Z,J$7CB5
        LD	(IX+3),A
        CALL	PROMPT
J$7CB5:	LD	D,0				; physical drive 0
J$7CB7:	POP	HL
        POP	BC
        LD	(IY+7),D			; physical drive
        PUSH	HL
        LD	BC,10
        ADD	HL,BC
        LD	(IY+5),L
        LD	(IY+6),H			; start of workspace
        LD	D,00H
        LD	B,5
        LD	HL,I$7E24
J$7CCE:	ADD	HL,DE
        DJNZ	J$7CCE
        POP	DE
        LD	C,5
        LDIR
        BIT	0,(IY+7)
        LD	A,14H				; motor on drive 0, disable INTRQ/DRQ, enable FDC, drive 0
        JR	Z,J$7CE0
        LD	A,25H				; motor on drive 1, disable INTRQ/DRQ, enable FDC, drive 1
J$7CE0:	LD	(L7FF8),A
        CALL	C.78AE				; C6=0 (?? In Use LED on)
        PUSH	IY
        POP	HL
        LD	DE,10
        ADD	HL,DE
        LD	(HL),00H
        INC	HL
        LD	D,1				; sector 1
        LD	BC,0902H
J$7CF5:	XOR	A
        LD	(HL),A				; cyclinder (set later)
        INC	HL
        LD	(HL),A				; head (set later)
        INC	HL
        LD	(HL),D				; sector
        INC	D
        INC	HL
        LD	(HL),C				; N=2 (sectorsize 512 bytes)
        INC	HL
        DJNZ	J$7CF5
        PUSH	IY
        POP	HL
        LD	DE,002FH
        ADD	HL,DE
        PUSH	HL
        POP	IX
        CALL	DISINT
        DI
J$7D0F:	LD	C,(IY+10)
        LD	A,(IY+7)
        LD	(IX+11),A			; physical drive + head
        CALL	C.7939				; select track
        LD	A,06H
        JR	C,J.7D57			; error,
        LD	B,0				; head 0
        CALL	C.7E79				; format cylinder
        JR	C,J.7D57
        BIT	0,(IY+2)			; double sided ?
        JR	Z,J$7D36			; nope, skip side 1
        CALL	C$7EF7				; change to head 1
        LD	B,04H				; head 1
        CALL	C.7E79				; format cylinder
        JR	C,J.7D57
J$7D36:	LD	A,(IY+10)
        INC	A				; next cylinder
        CP	80				; 80 cylinder done ?
        JR	NC,J$7D68			; yep,
        LD	(IY+10),A
        PUSH	IY
        POP	HL
        LD	BC,11
        ADD	HL,BC
        LD	B,09H
J$7D4A:	LD	(HL),A				; update cylinder
        INC	HL
        LD	(HL),0				; head 0
        INC	HL
        INC	HL
        INC	HL
        DJNZ	J$7D4A
        JR	J$7D0F

J$7D55:	POP	BC
        POP	HL
J.7D57:	PUSH	AF
        EI
        CALL	ENAINT
        LD	A,04H
        LD	(L7FF8),A			; motor off, disable INTRQ/DRQ, enable FDC, drive 0
        CALL	C.78B4				; C6=1 (?? In Use LED off)
        POP	AF
        JP	J.7E0E

J$7D68:	PUSH	IY
        POP	HL
        INC	H
        INC	H
        LD	DE,0				; sectornumber = 0
        LD	BC,050F8H
        BIT	0,(IY+9)			; double sided ?
        JR	Z,J.7D7C			; nope, 80 tracks, mediaid 0F8
        LD	B,0A0H
        INC	C				; yep, 160 tracks, mediaid 0F9
J.7D7C:	PUSH	HL
        PUSH	BC
        PUSH	DE
        LD	B,09H				; 9 sectors (hole track)
        LD	A,(IY+8)
        AND	A				; read
        CALL	DSKIO
        POP	DE
        JR	C,J$7D55			; error,
        LD	HL,9
        ADD	HL,DE
        EX	DE,HL				; update sectornumber
        POP	BC
        POP	HL
        DJNZ	J.7D7C				; next track
        CALL	C.7E16				; clear trackbuffer
        PUSH	HL
        EX	DE,HL
        LD	L,(IY+0)
        LD	H,(IY+1)
        LD	BC,30
        LDIR					; setup BPB in sector 0
        LD	HL,I$7F09
        LD	BC,L7F09
        LDIR					; bootloader in sector 0
        POP	HL
        PUSH	HL
        INC	H
        INC	H
        LD	A,(IY+2)
        LD	(HL),A
        INC	HL
        DEC	(HL)
        INC	HL
        DEC	(HL)				; reserved FAT entries 1st FAT (sector 1)
        INC	H
        INC	H
        INC	H
        INC	H
        CP	0F9H				; single sided ?
        JR	NZ,J$7DC2			; yep, 2nd FAT at sector 3
        INC	H
        INC	H				; double sided, 2nd FAT at sector 4
J$7DC2:	DEC	(HL)
        DEC	HL
        DEC	(HL)
        DEC	HL
        LD	(HL),A				; reserved FAT entries 2nd FAT
        POP	HL
        LD	C,A
        LD	B,9				; track
        LD	DE,0				; sector 0
        LD	A,(IY+8)
        PUSH	DE
        PUSH	AF
        PUSH	BC
        PUSH	HL
        SCF
        CALL	DSKIO				; write track
        JR	C,J.7E0A			; error,
        POP	HL
        POP	BC
        POP	AF
        POP	DE
        PUSH	DE
        PUSH	AF
        PUSH	BC
        PUSH	HL
        AND	A
        CALL	DSKIO				; read track
        JR	C,J.7E0A			; error,
        POP	HL
        CALL	C.7E16				; clear trackbuffer
        POP	BC
        POP	AF
        POP	DE
        LD	B,5
        LD	DE,9
        PUSH	DE
        PUSH	AF
        PUSH	BC
        PUSH	HL
        SCF
        CALL	DSKIO				; write track
        JR	C,J.7E0A			; error,
        POP	HL
        POP	BC
        POP	AF
        POP	DE
        AND	A
        CALL	DSKIO				; read track
        JR	C,J.7E0E			; error,
        RET

J.7E0A:	POP	HL
        POP	BC
        POP	DE
        POP	DE
J.7E0E:	CP	0CH
        JR	NZ,J$7E14
        LD	A,10H
J$7E14:	SCF
        RET

;	  Subroutine __________________________
;	     Inputs  ________________________
;	     Outputs ________________________

C.7E16:	PUSH	HL
        LD	BC,9*512
J$7E1A:	LD	(HL),00H
        INC	HL
        DEC	BC
        LD	A,B
        OR	C
        JR	NZ,J$7E1A
        POP	HL
        RET

I$7E24:	DEFW	I$7E2E
        DEFB	0F8H
        DEFW	02D0H

        DEFW	I$7E4C
        DEFB	0F9H
        DEFW	05A0H

I$7E2E:	DEFB	0EBH
        DEFB	0FEH
        DEFB	090H
        DEFB	"MSX_03  "
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

I$7E4C:	DEFB	0EBH
        DEFB	0FEH
        DEFB	090H
        DEFB	"MSX_04  "
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

J.7E6A:	DEFB	04DH				; FORMAT MFM
        DEFB	0
        DEFB	2				; N=2, sector size 512 bytes
        DEFB	9				; 9 sectors per track
        DEFB	80				; gap length
        DEFB	040H				; filler data

; UNUSED

        DEFB	046H				; READ DATA, no MT, MFM
        DEFB	0				; HS, DS1, DS0
        DEFB	0				; C
        DEFB	0				; H
        DEFB	1				; R
        DEFB	2				; 512 bytes
        DEFB	9				; EOT
        DEFB	80				; GPL
        DEFB	0FFH				; DTL

;	  Subroutine format cyclinder
;	     Inputs  ________________________
;	     Outputs ________________________

C.7E79:	CALL	C.78A2				; READY input from diskdrive
        LD	A,(IY+7)
        LD	(IX+11),A			; physical drive + head
        CALL	C.7711				; sense device
        JR	C,J$7EF1			; error, quit
        PUSH	BC
        PUSH	IX
        POP	HL
        LD	DE,10
        ADD	HL,DE
        EX	DE,HL
        LD	HL,J.7E6A
        LD	BC,6
        LDIR					; FORMAT command
        POP	BC
        LD	A,(IY+7)
        OR	B
        LD	(IX+11),A			; physical drive + head
        LD	B,6
        CALL	C.7954				; start FDC command
        PUSH	IY
        POP	HL
        LD	BC,11
        ADD	HL,BC
        LD	BC,I$7EC9
        PUSH	BC
        LD	BC,I.79C6
        PUSH	BC				; wait 16.5 ms
        LD	B,9*4
        LD	DE,L7FFA
J.7EB9:	LD	A,(DE)
        ADD	A,A				; ready to receive data ?
        JP	NC,J.7EB9			; nope, wait
        ADD	A,A
        RET	P				; no more data, quit
        LD	A,(HL)
        LD	(L7FFB),A
        INC	HL
        DJNZ	J.7EB9
        POP	BC
        POP	BC
I$7EC9:	CALL	C.79CF				; terminate FDC transfer
        CALL	C.79AE				; get command status
        CALL	C.78A8				; READY input high (not from diskdrive)
        LD	A,(IX+19)
        AND	0C0H				; terminated normally ?
        RET	Z				; yep, quit
        SCF
        LD	B,(IX+19)
        BIT	3,B				; not ready ?
        LD	A,02H
        RET	NZ				; yep, quit with
        BIT	4,B				; equipment check ?
        LD	A,0AH
        RET	NZ				; yep, quit with
        LD	B,(IX+20)
        BIT	1,B				; not writeable ?
        LD	A,00H
        RET	NZ				; yep, quit with
        LD	A,10H
        RET

J$7EF1:	CALL	C.78A8				; READY input high (not from diskdrive)
        LD	A,02H
        RET

;	  Subroutine __________________________
;	     Inputs  ________________________
;	     Outputs ________________________

C$7EF7:	PUSH	IY
        POP	HL
        LD	DE,12
        ADD	HL,DE
        LD	B,09H
J$7F00:	LD	(HL),01H
        INC	HL
        INC	HL
        INC	HL
        INC	HL
        DJNZ	J$7F00
        RET

I$7F09:
        .PHASE	0C01EH

        RET	NC
        LD	(DC058+1),DE
        LD	(DC0C4),A
        LD	(HL),LOW DC056
        INC	HL
        LD	(HL),HIGH DC056
J$C02A:	LD	SP,KBUF+256
        LD	DE,DC09F
        LD	C,0FH
        CALL	BDOS
        INC	A
        JP	Z,DC063
        LD	DE,DOSLOD
        LD	C,1AH
        CALL	BDOS
        LD	HL,1
        LD	(DC09F+14),HL
        LD	HL,04000H-0100H
        LD	DE,DC09F
        LD	C,27H
        CALL	BDOS
        JP	DOSLOD

DC056:	DEFW	DC058

DC058:	CALL	0
        LD	A,C
        AND	0FEH
        CP	02H
        JP	NZ,DC06A
DC063:	LD	A,(DC0C4)
        AND	A
        JP	Z,DSKBAS
DC06A:	LD	DE,DC079
        LD	C,09H
        CALL	BDOS
        LD	C,07H
        CALL	BDOS
        JR	J$C02A

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

L7F09	EQU	$-I$7F09

L7FF8	EQU	07FF8H		; DOR, b0 = 0 drive 0, 1 drive 1
                                ;      b1 = not used
                                ;      b2 = 0 reset FDC, 1 enable FDC
                                ;      b3 = 0 disable INTRQ and DRQ2 pins, 1 enable INTRQ and DRQ2 pins
                                ;      b4 = 1 motor select drive 0
                                ;      b5 = 1 motor select drive 1
                                ;      b6 = not used
                                ;      b7 = not used
L7FF9	EQU	07FF9H		; TDR, b0 = Terminate Count
                                ;      b1 = enable TC
                                ;      b2 = Standby Mode
                                ;      b3 = enable SB
                                ;      b4 = C4 output (force READY high)
                                ;      b5 = enable C4
                                ;      b4 = C6 output (not connected)
                                ;      b5 = enable C6
L7FFA	EQU	07FFAH		; MSR, Statusport FDC
L7FFB	EQU	07FFBH		; DAT, Dataport FDC

LBFF8	EQU	L7FF8+04000H
LBFF9	EQU	L7FF9+04000H
LBFFA	EQU	L7FFA+04000H
LBFFB	EQU	L7FFB+04000H

        END
