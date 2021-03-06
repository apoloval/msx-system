;  
;   M -> Source re-created by Z80DIS 2.2
;      Z80DIS was written by Kenneth Gielow
;                            Palo Alto, CA
;
        .Z80
        ORG	7405H
;
;

?.7405:	DEFB	7

I$7406:	DEFB	0F8h		; Media F8
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

C.744E:	EI	
        PUSH	AF
        JP	NC,J$75B2		; read
        PUSH	AF
        LD	A,(D.F30D)
        OR	A			; verify on ?
        JR	Z,J$7474		; nope, just write
        POP	AF
        PUSH	AF
        PUSH	BC
        PUSH	DE
        PUSH	HL
        CALL	C.7499			; write sectors
        POP	HL
        POP	DE
        POP	BC
        JR	C,J$7470		; error, finish
        CALL	C.7851			; reset FDC
        POP	AF
        CALL	C$756A			; verify sectors
        JR	J.7478			; finish DKSIO

J$7470:	POP	IY			; clearup stack
        JR	J.7478			; finish DSKIO

J$7474:	POP	AF
        CALL	C.7499			; write sectors
J.7478:	EI	
        CALL	C.FFD4			; enable interrupts
        POP	DE			; discard stack
J.747D:	PUSH	AF
        LD	C,50
        JR	NC,J$7484		; no error, no diskchange for 1 second
        LD	C,0			; error, diskchange unknown
J$7484:	CALL	C.7851			; reset FDC
        LD	(IX+0),150		; leave motor on for 3 seconds
        LD	A,D
        AND	A			; drive 0 ?
        JR	NZ,J$7494		; nope, set diskchange counter for drive 1
        LD	(IX+1),C		; set diskchange counter for drive 0
        POP	AF
        RET

J$7494:	LD	(IX+2),C		; set diskchange counter for drive 1
        POP	AF
        RET

;	  Subroutine write sectors
;	     Inputs  ________________________
;	     Outputs ________________________

C.7499:	CALL	C.76BE			; select drive and track
        RET	C
        CALL	C.FFCF
        DI				; disable interrupts
J$74A1:	BIT	7,H			; transfer from page 2 or 3 ?
        JR	NZ,J.74CE		; yep, direct transfer
        CALL	C$7DB1			; install write sector code in SECBUF
        CALL	C.7D4C			; start routine in SECBUF
        RET	C
        INC	B
        DEC	B			; all done ?
        RET	Z			; yep, quit
        CALL	C.FFCF
        DI				; disable interrupts
        BIT	7,H			; rest of the transfer from page 2 or 3 ?
        JR	NZ,J.74CE		; yep, direct transfer
        PUSH	HL
        PUSH	DE
        PUSH	BC
        LD	DE,(D.F34D)
        PUSH	DE
        LD	BC,512
        CALL	C.F36E			; transfer to SECBUF
        POP	HL
        POP	BC
        POP	DE
        CALL	C.74D9			; write sector from SECBUF
        POP	HL
        JR	J$74D1

J.74CE:	CALL	C.74D9			; write sector
J$74D1:	RET	C
        DEC	B			; all done ?
        RET	Z			; yep, quit
        CALL	C.77AD			; setup for next sector
        JR	J$74A1			; next

;	  Subroutine write sector
;	     Inputs  ________________________
;	     Outputs ________________________

C.74D9:	LD	E,11
J$74DB:	CALL	C.7801			; wait for FDC
        LD	A,0A0H
        BIT	6,D
        JR	Z,J.74EC
        OR	02H
        BIT	0,D
        JR	Z,J.74EC
        OR	08H
J.74EC:	PUSH	HL
        PUSH	DE
        PUSH	BC
        LD	DE,I$7505
        PUSH	DE			; resume here after INT
        LD	BC,I.7FFF
        LD	(D.7FF8),A		; start write command
J.74F9:	LD	A,(BC)
        ADD	A,A			; INT ?
        RET	P			; yep, quit
        JR	C,J.74F9		; no DRQ, wait
        LD	A,(HL)
        LD	(D.7FFB),A		; write data
        INC	HL
        JR	J.74F9			; next

I$7505:	POP	BC
        POP	DE
        POP	HL
        LD	A,(D.7FF8)
        AND	0FCH			; read status bits
        CALL	C$7808			; wait 1.2 ms
        JR	NZ,J$751F		; error,
        BIT	7,H			; next transfer from page 2 or 3 ?
        JR	NZ,J.7567		; yep, quit
        DEC	B			; all done ?
        JR	Z,J.7567		; yep, quit
        CALL	C.77AD			; setup for next sector
        JP	0			; ?

J$751F:	BIT	6,A			; WP bit set ?
        JR	NZ,J.7549		; yep, check if WP set from write proctected disk
        PUSH	AF
        CALL	C.77E8			; reseek every two tries
        POP	AF
        DEC	E
        JR	NZ,J$74DB		; next try
        SCF	
        LD	E,A
        BIT	7,E
        LD	A,2
        JR	NZ,J.7567		; not ready, return NOT READY
J$7533:	BIT	5,E
        LD	A,10
        JR	NZ,J.7567
        BIT	4,E
        LD	A,8
        JR	NZ,J.7567
        BIT	3,E
        LD	A,4
        JR	NZ,J.7567
        LD	A,12
        JR	J.7567

J.7549:	LD	A,80H
        LD	(D.7FF8),A		; start read command
        LD	HL,I.7FFF
        LD	DE,0			; wait max. 1172 ms for INT or DRQ
J$7554:	LD	A,(HL)
        RLCA				; DRQ ?
        JR	C,J.7565		; nope, WP valid, return WRITE PROTECT
        RLCA				; INT ?
        JR	NC,J.7565		; yep, WP valid, return WRITE PROTECT
        DEC	DE
        LD	A,E
        OR	D
        JR	NZ,J$7554		; wait
        LD	A,2
        SCF
        JR	J.7567			; return NOT READY

J.7565:	XOR	A
        SCF	
J.7567:	RET	

?.7568:	DEFB	0,0

;	  Subroutine verify sectors
;	     Inputs  ________________________
;	     Outputs ________________________

C$756A:	CALL	C.76BE			; select drive and track
        RET	C
        CALL	C.FFCF
        DI				; disable interrupts
J$7572:	BIT	7,H			; transfer from page 2 or 3 ?
        JR	NZ,J.75A5		; yep, verify direct
        CALL	C$7DC9			; install verify code in SECBUF
        LD	E,80H
        CALL	C.7D4C			; start routine in SECBUF
        RET	C
        INC	B
        DEC	B			; all done ?
        RET	Z			; yep, quit
        CALL	C.FFCF
        DI				; disable interrupts
        BIT	7,H			; rest of verify in page 2 or 3 ?
        JR	NZ,J.75A5		; yep, verify direct
        PUSH	HL
        PUSH	DE
        PUSH	BC
        LD	DE,(D.F34D)
        LD	BC,512
        CALL	C.F36E			; transfer to SECBUF
        POP	BC
        POP	DE
        LD	HL,(D.F34D)
        LD	E,80H			; verify
        CALL	C.7603			; read/verify sector
        POP	HL
        RET	C
        JR	J$75AB

J.75A5:	LD	E,80H			; verify
        CALL	C.7603			; read/verify sector
        RET	C
J$75AB:	DEC	B			; all done ?
        RET	Z			; yep, quit
        CALL	C.77AD			; setup for next sector
        JR	J$7572			; next

;	  Subroutine DSKIO read
;	     Inputs  ________________________
;	     Outputs ________________________

J$75B2:	CALL	C$75B8			; read sectors
        JP	J.7478			; finish DSKIO

;	  Subroutine read sectors
;	     Inputs  ________________________
;	     Outputs ________________________

C$75B8:	CALL	C.76BE			; select drive and track
        RET	C

;	  Subroutine read sectors (without selecting drive and track)
;	     Inputs  ________________________
;	     Outputs ________________________

C$75BC:	CALL	C.FFCF
        DI	
J$75C0:	BIT	7,H			; transfer to page 2 or 3 ?
        JR	NZ,J.75F6		; yep, read direct
        CALL	C.7DEC			; install read/verify routine in SECBUF
        LD	E,11			; read, 11 tries
        CALL	C.7D4C			; start routine in SECBUF
        RET	C
        INC	B
        DEC	B			; all done ?
        RET	Z			; yep, quit
        CALL	C.FFCF
        DI				; disable interrupts
        BIT	7,H			; rest of the read to page 2 or 3 ?
        JR	NZ,J.75F6		; yep, read direct
        PUSH	HL
        LD	HL,(D.F34D)
        LD	E,11			; read, 11 tries
        CALL	C.7603			; read/verify sector
        POP	HL
        RET	C
        PUSH	HL
        PUSH	DE
        PUSH	BC
        EX	DE,HL
        LD	HL,(D.F34D)
        LD	BC,512
        CALL	C.F36E			; copy from SECBUF to transfer
        POP	BC
        POP	DE
        POP	HL
        AND	A			; no error (??????)
        JR	J$75FC

J.75F6:	LD	E,11			; read, 11 tries
        CALL	C.7603			; read/verify sector
        RET	C
J$75FC:	DEC	B			; all done ?
        RET	Z			; yep, quit
        CALL	C.77AD			; setup for next sector
        JR	J$75C0			; next

;	  Subroutine read/verify sector
;	     Inputs  ________________________
;	     Outputs ________________________

C.7603:	CALL	C.7801			; wait for FDC
        LD	A,80H
        BIT	6,D
        JR	Z,J.7614
        OR	02H
        BIT	0,D
        JR	Z,J.7614
        OR	08H
J.7614:	PUSH	HL
        PUSH	DE
        PUSH	BC
        LD	BC,I$7652
        PUSH	BC			; resume here after INT
        LD	BC,I.7FFF
        BIT	7,E			; read or verify ?
        JR	NZ,J$768E		; verify,
        LD	(D.7FF8),A		; start read command
        LD	DE,05D00H		; wait max. 300 ms for DRQ
J.7628:	LD	A,(BC)
        ADD	A,A			; DRQ ?
        JR	NC,J.7647		; yep, go!
        RET	P			; INT, finish
        DEC	E
        JR	NZ,J.7628
        LD	A,(BC)
        ADD	A,A			; DRQ ?
        JR	NC,J.7647		; yep, go!
        RET	P			; INT, finish
        DEC	D
        JR	NZ,J.7628
        LD	A,2			; NOT READY
        POP	BC
        POP	BC
        POP	DE
        POP	HL
        SCF	
        JP	J.768B			; quit

J.7642:	LD	A,(BC)
        ADD	A,A			; INT ?
        RET	P			; yep, quit
        JR	C,J.7642		; no DRQ, wait
J.7647:	LD	A,(D.7FFB)
        LD	(HL),A			; write data
        INC	HL
        JR	J.7642			; next

?.764E:	DEFB	0,0,0,0

I$7652:	POP	BC
        POP	DE
        POP	HL
        LD	A,(D.7FF8)
        AND	9CH			; read status bits
        JR	NZ,J$7669		; error,
        BIT	7,H			; next transfer to page 2 or 3 ?
        JR	NZ,J.768B		; yep, quit
        DEC	B			; all done ?
        JR	Z,J.768B		; yep, quit
        CALL	C.77AD			; setup for next sector
        JP	0

J$7669:	BIT	7,E			; verify ?
        JR	NZ,J$7675		; yep, no retry
        PUSH	AF
        CALL	C.77E8			; reseek every two tries
        POP	AF
        DEC	E
        JR	NZ,C.7603		; next try
J$7675:	SCF	
        LD	E,A
        BIT	7,E			; drive not ready ?
        LD	A,2
        JR	NZ,J.768B		; yep, NOT READY
        BIT	4,E
        LD	A,8
        JR	NZ,J.768B
        BIT	3,E
        LD	A,4
        JR	NZ,J.768B
        LD	A,12
J.768B:	RET	

?.768C:	DEFB	0,0

J$768E:	LD	(D.7FF8),A		; start read command
        LD	DE,5D00H		; wait max. 300 ms for DRQ
J.7694:	LD	A,(BC)
        ADD	A,A			; DRQ ?
        JR	NC,J.76B3		; yep, go!
        RET	P			; INT, quit
        DEC	E
        JR	NZ,J.7694
        LD	A,(BC)
        ADD	A,A			; DRQ ?
        JR	NC,J.76B3		; yep, go!
        RET	P			; INT, quit
        DEC	D
        JR	NZ,J.7694
        LD	A,2			; NOT READY
J$76A6:	POP	BC
        POP	BC
        POP	DE
        POP	HL
        SCF	
        JP	J.768B			; quit

J.76AE:	LD	A,(BC)
        ADD	A,A			; INT ?
        RET	P			; yep, quit
        JR	C,J.76AE		; no DRQ, wait
J.76B3:	LD	A,(D.7FFB)
I$76B6:	CP	(HL)			; compare data
        INC	HL
        JR	Z,J.76AE		; equal, continue
        LD	A,10
        JR	J$76A6			; VERIFY ERROR

;	  Subroutine select drive and track
;	     Inputs  ________________________
;	     Outputs ________________________

C.76BE:	PUSH	AF
        PUSH	BC
        PUSH	HL
        CALL	C.5FC2			; GETWRK
        POP	HL
        POP	BC
        POP	AF
        CP	2			; driveid valid ?
        JR	C,J$76CF		; yep, continue
J$76CB:	LD	A,12			; nope, OTHER ERROR
        SCF	
        RET	

J$76CF:	PUSH	AF
        LD	A,C
        CP	0F8H			; mediadescriptor 0F8H-0FFH ?
        JR	C,J$76D9		; nope, quit
        CP	0FCH			; mediadescriptor 0F8H-0FBH ?
        JR	C,J$76DC		; yep, continue
J$76D9:	POP	AF
        JR	J$76CB

J$76DC:	EX	(SP),HL
        PUSH	HL
        PUSH	BC
        CALL	C.7801			; wait for FDC
        BIT	1,C			; 9 sectors per track ?
        LD	C,E
        LD	B,D
        LD	DE,8
        JR	NZ,J$76EC		; nope, 8 sectors per track
        INC	E			; yep, 9 sectors per track
J$76EC:	CALL	C$492F			; sector/sectors per track
        LD	A,L
        INC	A			; records are 1 based
        LD	(D.7FFA),A		; select record
        LD	L,C
        POP	BC
        POP	AF
        LD	H,A
        XOR	A
        BIT	0,C			; double sided media ?
        JR	Z,J.7702		; nope, cylinder = track, side 0
        SRL	L			; cylinder = track/2
        JR	NC,J.7702		; even track, side 0
        INC	A			; odd track, side 1
J.7702:	LD	(D.7FFC),A		; select side
        LD	D,A
        LD	A,(IX+7)
        DEC	A			; 1 physical drive ?
        JR	Z,J$770D		; yep, use drive 0
        LD	A,H
J$770D:	OR	0C4H			; motor on, in use, set b2
        PUSH	AF
        LD	A,C
        RRCA	
        RRCA	
        AND	0C0H			; media bit in b7,b6
        OR	D
        LD	D,A			; current side in b0
        LD	C,L			; current cylinder
        LD	A,(IX+7)
        DEC	A			; 1 physical drive ?
        JR	Z,J$7741		; yep, phantom check
        LD	A,(IX+3)
        CP	H			; same drive as last ?
        JR	Z,J.7758		; yep, no need to update the cylinder register
        XOR	01H
        LD	(IX+3),A		; new last drive
        LD	A,(D.7FF9)		; cylinder register
        JR	Z,J$7736		; new last drive = drive 0, save cylinder drive 1
        LD	(IX+4),A		; save cylinder drive 0
        LD	A,(IX+5)
        JR	J$773C			; set cylinder register with cylinder drive 1

J$7736:	LD	(IX+5),A		; save cylinder drive 1
        LD	A,(IX+4)		; set cylinder register with cylinder drive 0
J$773C:	LD	(D.7FF9),A
        JR	J.7758			; skip prompt

J$7741:	LD	A,(IX+6)
        CP	H			; same logical drive as last ?
        LD	(IX+6),H		; new last drive
        JR	Z,J.7758		; yep, skip prompt
        PUSH	IX
        PUSH	DE
        PUSH	BC
        CALL	C$7847			; motor off (and reset counter)
        CALL	C$625A			; prompt
        POP	BC
        POP	DE
        POP	IX
J.7758:	POP	AF
        PUSH	BC
        PUSH	AF
        DI	
        LD	A,(D.7FF8)
        AND	80H
        LD	B,A			; READY signal from drive
        XOR	A
        CP	(IX+0)
        RLA				; motor off counter<>0 ?
        OR	B
        LD	B,A
        POP	AF
        LD	(D.7FFD),A		; motor on, in use, set b2, select drive
        LD	(IX+0),0FFH		; disable motor off counter
        EI	
        LD	A,(D.7FF9)
        CP	C			; drive on requested cylinder ?
        CALL	NZ,C$77EE		; nope, seek to cylinder
        BIT	0,B			; motor off counter<>0 ?
        JR	NZ,J$7785		; yep, check if drive is ready in 10 ms
        BIT	7,B			; READY signal from drive ?
        JR	Z,J$7798		; yep, wait 1000 ms and quit
        LD	B,100
        JR	J.778C			; check if drive is ready in 1000 ms

J$7785:	LD	B,1
        JR	J.778C			; wait 10 ms for READY

J$7789:	CALL	C.77A2			; wait 10 ms
J.778C:	LD	A,(D.7FF8)
        RLA	
        JR	NC,J.779F
        DJNZ	J$7789
        LD	A,2			; NOT READY
        JR	J.779F

J$7798:	LD	B,100
J$779A:	CALL	C.77A2			; wait 10 ms
        DJNZ	J$779A
J.779F:	POP	BC
        POP	HL
        RET	

;	  Subroutine wait 10 ms
;	     Inputs  ________________________
;	     Outputs ________________________

C.77A2:	PUSH	HL
        LD	HL,1190
J$77A6:	DEC	HL
        LD	A,H
        OR	L
        JR	NZ,J$77A6
        POP	HL
        RET	

;	  Subroutine setup for next sector
;	     Inputs  ________________________
;	     Outputs ________________________

C.77AD:	CALL	C.7801			; wait for FDC
        INC	H
        INC	H			; update transferaddress
        LD	A,(D.7FFA)
        INC	A
        LD	(D.7FFA),A		; next record
        BIT	7,D			; 9 sectors per track ?
        JR	NZ,J$77C0		; nope, check if on record 9
        CP	9+1			; end of track ?
        RET	C			; nope, quit
J$77C0:	CP	8+1			; end of track ?
        RET	C			; nope, quit
        LD	A,1
        LD	(D.7FFA),A		; record 1
        BIT	6,D			; double sided media ?
        JR	Z,J.77D7		; nope, select side 0 and seek to next cylinder
        BIT	0,D			; currently on side 1 ?
        JR	NZ,J.77D7		; yep, select side 0 and seek to next cylinder
        SET	0,D			; nope, select side 1
        LD	(D.7FFC),A
        JR	J$77E6			; wait 18 ms (head settle)

J.77D7:	RES	0,D
        XOR	A
        LD	(D.7FFC),A
        INC	C

;	  Subroutine seek to next cylinder
;	     Inputs  ________________________
;	     Outputs ________________________

C.77DE:	CALL	C.7801			; wait for FDC
        LD	A,50H
        LD	(D.7FF8),A		; start step-in command
J$77E6:	JR	C.780E			; wait 18 ms (head settle)

;	  Subroutine reseek every 2 tries
;	     Inputs  ________________________
;	     Outputs ________________________

C.77E8:	BIT	0,E
        RET	NZ
        CALL	C.7814			; recalibrate

;	  Subroutine seek to cylinder
;	     Inputs  ________________________
;	     Outputs ________________________

C$77EE:	CALL	C.7801			; wait for FDC
        LD	A,C
        OR	A
        JR	Z,C.781B		; seek to cylinder 0
        LD	(D.7FFB),A
        EX	(SP),HL
        EX	(SP),HL
        LD	A,10H
        LD	(D.7FF8),A		; start seek command
        JR	J$7823			; wait for FDC and wait 14 ms (head settle)

;	  Subroutine wait for FDC
;	     Inputs  ________________________
;	     Outputs ________________________

C.7801:	LD	A,(D.7FF8)
        RRA	
        JR	C,C.7801
        RET	

;	  Subroutine wait 1.2 ms
;	     Inputs  ________________________
;	     Outputs ________________________

C$7808:	PUSH	HL
        LD	HL,143
        JR	J.782C

;	  Subroutine wait 18 ms (head settle)
;	     Inputs  ________________________
;	     Outputs ________________________

C.780E:	PUSH	HL
        LD	HL,2142
        JR	J.782C

;	  Subroutine recalibrate
;	     Inputs  ________________________
;	     Outputs ________________________

C.7814:	LD	A,(D.7FF9)
        OR	A			; on cylinder 0 ?
        CALL	Z,C.7835		; yep, move to 5 cylinders futher

;	  Subroutine seek to cylinder 0
;	     Inputs  ________________________
;	     Outputs ________________________

C.781B:	CALL	C.7801			; wait for FDC
        LD	A,0
        LD	(D.7FF8),A		; start restore command
J$7823:	EX	(SP),HL
        EX	(SP),HL
        CALL	C.7801			; wait for FDC
        PUSH	HL
        LD	HL,1666			; wait 14 ms (head settle)
J.782C:	PUSH	AF
J$782D:	DEC	HL
        LD	A,H
        OR	L
        JR	NZ,J$782D
        POP	AF
        POP	HL
        RET	

;	  Subroutine move to 5 cylinders futher
;	     Inputs  ________________________
;	     Outputs ________________________

C.7835:	PUSH	BC
        LD	B,5
J$7838:	CALL	C.77DE
        DJNZ	J$7838			; seek to 5 cylinders futher
        POP	BC
        RET	

;	  Subroutine INIHRD
;	     Inputs  ________________________
;	     Outputs ________________________

?.783F:	CALL	C.7851			; reset FDC
        JR	C.784B			; stop motor

;	  Subroutine MTOFF
;	     Inputs  ________________________
;	     Outputs ________________________

MTOFF:	CALL	C.5FC2			; GETWRK

;	  Subroutine motor off (and reset counter)
;	     Inputs  ________________________
;	     Outputs ________________________

C$7847:	LD	(IX+0),0

;	  Subroutine motor off
;	     Inputs  ________________________
;	     Outputs ________________________

C.784B:	LD	A,3
        LD	(D.7FFD),A		; motor off, in use off, reset b2, unselect drive
        RET	

;	  Subroutine reset FDC
;	     Inputs  ________________________
;	     Outputs ________________________

C.7851:	LD	A,0D0H
        LD	(D.7FF8),A		; start command
        EX	(SP),HL
        EX	(SP),HL
        EX	(SP),HL
        EX	(SP),HL
        LD	A,(D.7FFB)
        LD	A,(D.7FF8)
        RET	

;	  Subroutine DRIVES
;	     Inputs  ________________________
;	     Outputs ________________________

?.7861:	PUSH	BC
        PUSH	DE
        PUSH	AF
        CALL	C.5FC2			; GETWRK
        POP	AF
        PUSH	AF
        JR	Z,J$7887		; CTRL pressed, skip drive 1 check
        LD	A,0C5H
        LD	(D.7FFD),A		; motor on, in use, set b2, select drive 1
        RES	5,D
        CALL	C.7835			; seek to 5 cylinders futher
        CALL	C.781B			; seek to cylinder 0
        LD	HL,076CAH		; wait max. 0.5 s (loop is 60T cycles)
J$787B:	LD	A,(D.7FF8)
        AND	04H
        JR	NZ,J$788B
        DEC	HL
        LD	A,H
        OR	L
        JR	NZ,J$787B
J$7887:	LD	L,1
        JR	J$7893

J$788B:	LD	L,2
        CALL	C.78B4			; recalibrate two times
        CALL	C.780E			; wait 18 ms (head settle)
J$7893:	LD	A,0C4H
        LD	(D.7FFD),A		; motor on, in use, set b2, select drive 0
        RES	5,D
        CALL	C.7835			; seek to 5 cylinders futher
        CALL	C.781B			; seek to cylinder 0
        CALL	C.78B4			; recalibrate two times
        LD	(IX+7),L
        CALL	C.780E			; wait 18 ms (head settle)
        CALL	C.784B			; stop motor
        POP	AF
        JR	Z,J$78B1		; CTRL pressed, do not use phantom drives
        LD	L,2			; 2 drives
J$78B1:	POP	DE
        POP	BC
        RET	

;	  Subroutine __________________________
;	     Inputs  ________________________
;	     Outputs ________________________

C.78B4:	PUSH	DE
        RES	5,D
        CALL	C.7814			; recalibrate
        CALL	C.7814			; recalibrate
        POP	DE
        RET	

;	  Subroutine INIENV
;	     Inputs  ________________________
;	     Outputs ________________________

?.78BF:	CALL	C.5FC2			; GETWRK
        LD	B,7
        XOR	A
J$78C5:	LD	(HL),A
        INC	HL
        DJNZ	J$78C5
        LD	HL,I$78CF
        JP	J$5FF6			; SETINT

;	  Subroutine driver interrupt handler
;	     Inputs  ________________________
;	     Outputs ________________________

I$78CF:	PUSH	AF
        CALL	C.5FC2			; GETWRK
        LD	A,(HL)
        AND	A
        JR	Z,J$78DF
        CP	0FFH
        JR	Z,J.78E2
        DEC	A
        LD	(HL),A
        JR	NZ,J.78E2
J$78DF:	CALL	C.784B			; stop motor
J.78E2:	INC	HL
        LD	A,(HL)
        AND	A
        JR	Z,J$78E8
        DEC	(HL)
J$78E8:	INC	HL
        LD	A,(HL)
        AND	A
        JR	Z,J$78EE
        DEC	(HL)
J$78EE:	POP	AF
        JP	J$6027			; PRVINT

;	  Subroutine DSKCHG
;	     Inputs  ________________________
;	     Outputs ________________________

?.78F2:	EI	
        PUSH	HL
        PUSH	BC
        PUSH	AF
        CALL	C.5FC2			; GETWRK
        POP	AF
        POP	BC
        POP	HL
        AND	A			; drive 0 ?
        LD	B,(IX+2)
        JR	NZ,J$7905		; nope, use diskchange counter drive 1
        LD	B,(IX+1)		; diskchange counter drive 0
J$7905:	INC	B
        DEC	B			; diskchange counter zero ?
        LD	B,1
        RET	NZ			; nope, return DISK UNCHANGED
        PUSH	BC
        PUSH	HL
        LD	DE,1
        LD	HL,(D.F34D)
        PUSH	AF
        CALL	C.744E			; DSKIO (read first FAT sector)
        JR	C,J$7930		; error, quit with error
        POP	AF
        LD	HL,(D.F34D)
        LD	B,(HL)			; mediadescriptor
        POP	HL
        PUSH	BC
        CALL	C$7934			; GETDPB (update DPB)
        LD	A,10
        JR	C,J$7931		; bad mediadescriptor, return WRITE FAULT error
        POP	AF
        POP	BC
        CP	C			; mediadescriptor changed ?
        SCF
        CCF				; reset Cx
        LD	B,0FFH
        RET	NZ			; yep, return DISK CHANGED
        INC	B
        RET				; nope, return DISK CHANGE UNKNOWN

J$7930:	POP	DE
J$7931:	POP	DE
        POP	DE
        RET	

;	  Subroutine GETDPB
;	     Inputs  ________________________
;	     Outputs ________________________

C$7934:	EX	DE,HL
        INC	DE
        LD	A,B
        SUB	0F8H			; mediadescriptor 0F8H-0FFH ?
        RET	C			; nope, quit with error
        CP	4			; mediadescriptor 0F8H-0FBH ?
        JR	NC,J$7952		; nope, quit with WRITE FAULT error
        RLCA	
        LD	C,A
        LD	B,0
        LD	L,A
        LD	H,B
        ADD	HL,HL
        ADD	HL,HL
        ADD	HL,HL
        ADD	HL,BC
        LD	BC,I$7406
        ADD	HL,BC
        LD	BC,18
        LDIR	
        RET	

J$7952:	LD	A,10
        SCF	
        RET	

I$7956:	DEFB	13,10
        DEFB	"1 - Single sided, 80 tracks",13,10
        DEFB	"2 - Double sided, 80 tracks",13,10
        DEFB	0

;	  Subroutine CHOICE
;	     Inputs  ________________________
;	     Outputs ________________________

?.7993:	LD	HL,I$7956
        RET	

;	  Subroutine DSKFMT
;	     Inputs  ________________________
;	     Outputs ________________________

?.7997:	PUSH	HL
        LD	HL,-7000
        ADD	HL,BC
        POP	HL
        JR	C,J$79B2
        SCF	
        LD	A,14			; return INSUFFICIENT MEMORY error
        RET	

J.79A3:	POP	HL
J.79A4:	SCF	
        LD	A,12			; return BAD PARAMETER error
        RET	

J.79A8:	POP	DE
        POP	BC
J$79AA:	POP	HL
        JP	J.747D

J.79AE:	POP	BC
J$79AF:	JP	J.747D

J$79B2:	PUSH	AF
        PUSH	HL
        CALL	C.5FC2			; GETWRK
        POP	HL
        POP	AF
        OR	A			; choice 0 ?
        JR	Z,J.79A4		; yep, bad parameter
        CP	2+1			; choice 1-2 ?
        JR	NC,J.79A4		; nope, bad parameter
        DEC	A
        JR	Z,J$79C8
        LD	BC,050F9H		; double sided, 80 tracks
        JR	J$79CB

J$79C8:	LD	BC,050F8H		; single sided, 80 tracks
J$79CB:	PUSH	HL
        BIT	0,C			; single sided ?
        JR	Z,J$7A16		; yep, skip side check
        PUSH	BC
        PUSH	DE
        LD	A,D
        LD	DE,0
        PUSH	BC
J$79D7:	CALL	C.76BE			; select drive and track
        POP	BC
        JR	C,J.79A8		; error,
        RES	7,C			; side 0
        CALL	C.7A60			; construct track data
        CALL	C.7BEE			; format track
        JR	C,J.79A8		; error, quit
        POP	DE
        PUSH	DE
        SET	7,C			; side 1
        LD	A,D
        LD	DE,9
        PUSH	BC
        CALL	C.76BE			; select drive and track
        POP	BC
J$79F4:	JR	C,J.79A8		; error, quit
        CALL	C.7A60			; construct track data
        CALL	C.7BEE			; format track
        JR	C,J.79A8		; error,
        CALL	C.7851			; reset FDC
        LD	HL,(D.F34D)
        LD	BC,001F9H		; 1 sector, double sided media
        POP	DE
        LD	A,D
        PUSH	DE
        LD	DE,0			; sector 0
        OR	A			; read
        CALL	C.744E			; DSKIO (this fails if drive was single sided)
        POP	DE
        POP	BC
        JP	C,J.79A3		; error, bad parameter
J$7A16:	POP	HL
        PUSH	BC
        LD	A,D
        PUSH	DE
        LD	DE,0
        CALL	C.76BE			; select drive and track
        POP	DE
        POP	BC
        JP	C,J$79AF		; error, quit
        LD	A,D
        CALL	C$7AC3			; construct GAP POST DATA
        PUSH	AF
        LD	D,A
J$7A2B:	RES	7,C			; side 0
        CALL	C.7A60			; construct track data
        CALL	C.7BEE			; format track
        JP	C,J.79AE		; error,
        BIT	0,C			; double sided media ?
        JR	Z,J$7A48		; nope, skip side 1
        CALL	C.7A60			; construct track data
        SET	7,C			; side 1
        CALL	C$7AA2			; adjust track data for side
        CALL	C.7BEE			; format track
        JP	C,J.79AE		; error,
J$7A48:	RES	5,D
        CALL	C.77DE			; seek to next cylinder
        DJNZ	J$7A2B			; next
        CALL	C.7814			; recalibrate
        SET	7,C			; mediadescriptor
        POP	AF
        JP	J$7AD6			; write system sectors

;	  Subroutine __________________________
;	     Inputs  ________________________
;	     Outputs ________________________

C.7A58:	LD	A,C
        RLCA	
        AND	01H
        LD	(D.7FFC),A
        RET	

;	  Subroutine construct track data
;	     Inputs  ________________________
;	     Outputs ________________________

C.7A60:	PUSH	BC
        PUSH	DE
        PUSH	HL
        EX	DE,HL
        LD	HL,I$7BC2
        CALL	C.7B8F
        LD	B,9
J$7A6C:	PUSH	BC
        LD	HL,I$7BCD
        CALL	C.7B8F
        POP	BC
        DJNZ	J$7A6C
        POP	HL
        PUSH	HL
        LD	BC,122+16
        ADD	HL,BC
        LD	DE,628
        LD	B,9
        LD	A,(D.7FF9)
J$7A84:	LD	(HL),A			; cylinder
        ADD	HL,DE
        DJNZ	J$7A84
        LD	BC,122+18
        POP	HL
        PUSH	HL
        ADD	HL,BC
        PUSH	HL
        POP	IY
        LD	HL,I$7ABA
        LD	B,9
J$7A96:	LD	A,(HL)
        LD	(IY+0),A		; record
        ADD	IY,DE
        INC	HL
        DJNZ	J$7A96
        POP	HL
        POP	DE
        POP	BC

;	  Subroutine adjust track data for side
;	     Inputs  ________________________
;	     Outputs ________________________

C$7AA2:	PUSH	BC
        PUSH	DE
        PUSH	HL
        LD	DE,122+17
        ADD	HL,DE
        LD	DE,628
        LD	B,9
        LD	A,C
        RLCA	
        AND	01H
J$7AB2:	LD	(HL),A
        ADD	HL,DE
        DJNZ	J$7AB2
        POP	HL
        POP	DE
        POP	BC
        RET	

I$7ABA:	DEFB	1,2,3,4,5,6,7,8,9

;	  Subroutine __________________________
;	     Inputs  ________________________
;	     Outputs ________________________

C$7AC3:	PUSH	HL
        PUSH	BC
        LD	DE,5774
        ADD	HL,DE
        LD	D,H
        LD	E,L
        INC	DE
        LD	(HL),4EH
        LD	BC,2*512-1
        LDIR	
        POP	BC
        POP	HL
        RET	

;	  Subroutine write system sectors
;	     Inputs  ________________________
;	     Outputs ________________________

J$7AD6:	CALL	C.7B7B			; clear SECBUF
        PUSH	BC
        LD	HL,I$7E56
        LD	DE,(D.F34D)
        LD	BC,I$00C4
        LDIR				; copy BPB + bootloader
        POP	BC
        CALL	C$7B9C			; adjust BPB if double sided
        PUSH	BC
        LD	B,1
        LD	DE,0
        LD	H,A
        PUSH	HL
        LD	HL,(D.F34D)
        SCF				; write
        CALL	C.744E			; DSKIO (write bootsector)
        POP	HL
        POP	BC
        RET	C			; error, quit
        CALL	C$7B32			; write FATs
        RET	C			; error, quit
        LD	A,9
        SUB	E
        LD	B,A			; rest of the track
J$7B04:	PUSH	BC
        PUSH	DE
        LD	B,1
        LD	A,H
        PUSH	HL
        LD	HL,(D.F34D)
        SCF				; write
        CALL	C.744E			; DSKIO
        POP	HL
        POP	DE
        INC	DE
        POP	BC
        RET	C			; error, quit
        DJNZ	J$7B04			; next
        BIT	0,C			; single sided ?
        RET	Z			; yep, done
        LD	B,5			; 5 sectors
J$7B1D:	PUSH	BC
        PUSH	DE
        LD	A,H
        PUSH	HL
        LD	HL,(D.F34D)
        LD	B,1
        SCF				; write
        CALL	C.744E			; DSKIO
        POP	HL
        POP	DE
        INC	DE
        POP	BC
        RET	C
        DJNZ	J$7B1D			; next
        RET	

;	  Subroutine write FATs
;	     Inputs  ________________________
;	     Outputs ________________________

C$7B32:	LD	B,2			; 2 FATs
        LD	DE,1
        CALL	C.7B7B			; clear SECBUF
J$7B3A:	PUSH	BC
        PUSH	DE
        LD	A,H
        PUSH	HL
        LD	HL,(D.F34D)
        LD	(HL),C
        INC	HL
        LD	(HL),0FFH
        INC	HL
        LD	(HL),0FFH
        LD	B,1
        DEC	HL
        DEC	HL
        SCF	
        CALL	C.744E			; DSKIO
        POP	HL
        CALL	C.7B7B			; clear SECBUF
        POP	DE
        INC	DE
        POP	BC
        RET	C			; error, quit
        PUSH	BC
        LD	B,1
        BIT	0,C			; single sided ?
        JR	Z,J.7B60		; yep, only 2 sectors per FAT
        INC	B			; nope, 3 sectors per FAT
J.7B60:	PUSH	BC
        LD	B,1
        PUSH	DE
        LD	A,H
        PUSH	HL
        LD	HL,(D.F34D)
        SCF				; write
        CALL	C.744E			; DSKIO
        POP	HL
        POP	DE
        INC	DE
        POP	BC
        JR	C,J$7B79		; error, quit
        DJNZ	J.7B60			; next
        POP	BC
        DJNZ	J$7B3A			; next FAT
        RET	

J$7B79:	POP	BC
        RET	

;	  Subroutine __________________________
;	     Inputs  ________________________
;	     Outputs ________________________

C.7B7B:	PUSH	BC
        PUSH	DE
        PUSH	HL
        LD	HL,(D.F34D)
        LD	D,H
        LD	E,L
        INC	DE
        LD	BC,512-1
        LD	(HL),0
        LDIR	
        POP	HL
        POP	DE
        POP	BC
        RET	

;	  Subroutine __________________________
;	     Inputs  ________________________
;	     Outputs ________________________

C.7B8F:	LD	A,(HL)
        INC	HL
        CP	0FFH
        RET	Z
        LD	B,(HL)
        INC	HL
J$7B96:	LD	(DE),A
        INC	DE
        DJNZ	J$7B96
        JR	C.7B8F

;	  Subroutine __________________________
;	     Inputs  ________________________
;	     Outputs ________________________

C$7B9C:	BIT	0,C
        RET	Z
        PUSH	BC
        LD	DE,I$7BB2
        LD	HL,(D.F34D)
        LD	BC,13
        ADD	HL,BC
        EX	DE,HL
        LD	BC,16
        LDIR	
        POP	BC
        RET	

I$7BB2:
        DEFB	2
        DEFW	1
        DEFB	2
        DEFW	112
        DEFW	1440
        DEFB	0F9H
        DEFW	3
        DEFW	9
        DEFW	2
        DEFW	0

I$7BC2:	DEFB	04EH,80		; GAP PRE INDEX
        DEFB	000H,12		; GAP PRE INDEX
        DEFB	0F6H,3		; special bytes
        DEFB	0FCH,1		; INDEX MARK
        DEFB	04EH,26		; GAP POST INDEX
        DEFB	0FFH

I$7BCD:	DEFB	000H,12		; GAP PRE SECTORID
        DEFB	0F5H,3		; special bytes
        DEFB	0FEH,1		; ID ADDRESS MARK
        DEFB	000H,1		; cylinder
        DEFB	000H,1		; side
        DEFB	001H,1		; record
        DEFB	002H,1		; sectorsize id (512 bytes)
        DEFB	0F7H,1		; write CRC-16
        DEFB	04EH,24		; GAP POST SECTORID
        DEFB	000H,12		; GAP PRE SECTORDATA
        DEFB	0F5H,3		; special bytes
        DEFB	0FBH,1		; DATA ADDRESS MARK
        DEFB	0E5H,0		; 256 bytes data
        DEFB	0E5H,0		; 256 bytes data
        DEFB	0F7H,1		; write CRC-16
        DEFB	04EH,54		; GAP POST SECTORDATA
        DEFB	0FFH

;	  Subroutine format track
;	     Inputs  ________________________
;	     Outputs ________________________

C.7BEE:	CALL	C.7A58			; select side
        LD	E,11
J$7BF3:	PUSH	BC
        PUSH	DE
        PUSH	HL
        CALL	C.7801			; wait for FDC
        CALL	C.FFCF
        DI	
        LD	DE,I$7C30
        PUSH	DE
        LD	BC,I.7FFF
        LD	DE,05D00H		; wait max. 300 ms for DRQ
        LD	A,0F0H
        LD	(D.7FF8),A		; start format command
J.7C0C:	LD	A,(BC)
        ADD	A,A			; DRQ ?
        JR	NC,J.7C29		; yep, start format
        RET	P			; INT, quit
        DEC	E
        JR	NZ,J.7C0C
        LD	A,(BC)
        ADD	A,A
        JR	NC,J.7C29
        RET	P
        DEC	D
        JR	NZ,J.7C0C
        POP	BC
        LD	A,16
        SCF	
        POP	HL
        POP	DE
        POP	BC
        RET				; return OTHER ERROR

J.7C24:	LD	A,(BC)
        ADD	A,A
        RET	P
        JR	C,J.7C24
J.7C29:	LD	A,(HL)
        LD	(D.7FFB),A
        INC	HL
        JR	J.7C24

I$7C30:	POP	HL
        POP	DE
        POP	BC
        LD	A,(D.7FF8)
        AND	0FCH			; read status bits
        JR	Z,J$7C55		; no errors, verify track
        BIT	6,A			; WP bit set ?
        JP	NZ,J.7549		; yep, check if WP set from write proctected disk
        PUSH	AF
        LD	A,(D.7FF9)
        LD	C,A			; current cylinder
        CALL	C.77E8			; reseek every two tries
        POP	AF
        DEC	E
        JR	NZ,J$7BF3		; next try
        SCF	
        LD	E,A
        BIT	7,E			; NOT READY bit set ?
        LD	A,16
        RET	NZ			; yep, return OTHER ERROR
        JP	J$7533			; return error from other error bits

J$7C55:	LD	A,(D.F30D)
        OR	A			; verify on ?
        RET	Z			; nope, quit
        PUSH	HL
        PUSH	DE
        PUSH	BC
        LD	D,0
        LD	A,C
        AND	01H
        RRCA	
        RRCA	
        OR	D
        LD	D,A
        CALL	C.7A58			; select side
        OR	D
        LD	D,A			; media and side flags
        LD	B,9			; 9 sectors
        LD	A,(D.7FF9)
        LD	C,A			; current cylinder
        LD	A,1
        LD	(D.7FFA),A		; record 1
        CALL	C$75BC			; read sectors (without selecting drive and track)
        POP	BC
        POP	DE
        POP	HL
        RET	

?.7C7D:	SCF	
        RET	
;
;	-----------------
I$7C7F:	LD	H,C
        NOP	
        LD	B,H
        LD	BC,I$0075
        ADC	A,E
        NOP	
        XOR	D
        NOP	
        DEC	HL
        LD	BC,I$009F
        RET	P
;
        NOP	
        AND	D
        NOP	
        LD	H,00H
        DEFB	0EDH		; << Illegal Op Code Byte >>
;	-----------------
;
        NOP	
        INC	A
        NOP	
        SUB	E
        NOP	
        LD	C,E
        LD	BC,I$00F0
        LD	B,H
        LD	BC,I$0121
        LD	B,H
        LD	BC,I$012E
        LD	D,A
        LD	BC,I$0131
        LD	B,H
        LD	BC,I$015E
        LD	B,H
        LD	BC,I$015B
        LD	A,B
        LD	BC,I$017B
        LD	HL,I$6801
        LD	BC,I.0144
        DEFB	0,0
        LD	A,H
        NOP	
        LD	A,C
        NOP	
        ADD	A,L
        NOP	
        ADC	A,(HL)
        NOP	
        POP	DE
        NOP	
        CALL	NC,C$F500
;
        NOP	
        LD	SP,HL
        NOP	
        EX	AF,AF'
        LD	BC,I$0115
        DEC	E
        LD	BC,I$0126
        JR	C,J$7CD8
;
        CCF	
J$7CD8:	LD	BC,I.0144
        LD	H,E
        LD	BC,I$0157
        DEFB	0,0
I$7CE1:	LD	E,A
        NOP	
        LD	A,01H	; 1 
        LD	(HL),E
        NOP	
        XOR	(HL)
        NOP	
        JP	Z,J$2500
;
        LD	BC,I$00BF
        JP	PE,J$C200
;
        NOP	
        LD	H,00H
        RST	20H
;
        NOP	
        INC	A
        NOP	
        SBC	A,E
        NOP	
        RST	20H
;
        NOP	
        JP	PE,J$3E00
;
        LD	BC,I.011B
        LD	A,01H	; 1 
        JR	Z,J$7D08
;
        LD	D,C
J$7D08:	LD	BC,I$012B
        LD	A,01H	; 1 
        LD	E,B
        LD	BC,I.013E
        LD	D,L
        LD	BC,I$0172
        LD	(HL),L
        LD	BC,I.011B
        LD	H,D
        LD	BC,I.013E
        DEFB	0,0
        LD	(HL),A
        NOP	
        LD	A,(HL)
        NOP	
        AND	E
        NOP	
        OR	C
        NOP	
        RST	28H
;
        NOP	
        DI	
        NOP	
        LD	(BC),A
        LD	BC,I$010F
        RLA	
        LD	BC,I$0120
        LD	(D$3901),A
        LD	BC,I.013E
        LD	E,L
        LD	BC,I$0151
        DEFB	0,0
;
;	  Subroutine __________________________
;	     Inputs  ________________________
;	     Outputs ________________________
;
C.7D3F:	LD	DE,(D.F34D)
        LD	HL,I$7D52
        LD	BC,I.005F
        LDIR	
        RET	

;	  Subroutine __________________________
;	     Inputs  ________________________
;	     Outputs ________________________

C.7D4C:	PUSH	HL
        LD	HL,(D.F34D)
        EX	(SP),HL
        RET	
;
;	-----------------
I$7D52:	PUSH	HL
        PUSH	DE
        PUSH	BC
        CALL	C$402D
        LD	HL,(D.F34D)
        LD	DE,I$0050
        ADD	HL,DE
        LD	(HL),A
        LD	H,80H
        CALL	C.0024
        EI	
        CALL	C.FFD4
        LD	A,(D$F342)
        LD	H,40H	; "@"
        CALL	C.0024
        POP	BC
        POP	DE
        POP	HL
        CALL	C.FFCF
        DI	
        DEC	HL
        LD	A,H
        ADD	A,02H	; 2 
        INC	HL
        RLCA	
        CCF	
        JR	NC,J$7D8E
        LD	IY,(D.F34D)
        PUSH	DE
        LD	DE,I.005F
        ADD	IY,DE
        POP	DE
        JP	(IY)

J$7D8E:	PUSH	HL
        PUSH	DE
        PUSH	BC
        PUSH	AF
        LD	A,(D$F343)
        LD	H,80H
        CALL	C.0024
        CALL	C$F368
        EI	
        CALL	C.FFD4
        LD	A,00H
        LD	H,40H	; "@"
        CALL	C.0024
        EI	
        CALL	C.FFD4
        POP	AF
        POP	BC
        POP	DE
        POP	HL
        RET	

;	  Subroutine __________________________
;	     Inputs  ________________________
;	     Outputs ________________________

C$7DB1:	PUSH	HL
        PUSH	DE
        PUSH	BC
        CALL	C.7D3F
        LD	IY,I$7C7F
        LD	HL,C.74D9
        LD	BC,I$0091
        LDIR	
        PUSH	DE
        LD	DE,I$00ED
        JR	J$7E02

;	  Subroutine __________________________
;	     Inputs  ________________________
;	     Outputs ________________________

C$7DC9:	PUSH	HL
        PUSH	DE
        PUSH	BC
        CALL	C.7DEC			; install read/verify routine in SECBUF
        LD	HL,(D.F34D)
        LD	BC,I$00A6
        ADD	HL,BC
        LD	DE,I$76B6
        EX	DE,HL
        LD	BC,I.0008
        LDIR	
        LD	HL,(D.F34D)
        LD	BC,I$007D
        ADD	HL,BC
        LD	(HL),00H
        POP	BC
        POP	DE
        POP	HL
        RET	

;	  Subroutine __________________________
;	     Inputs  ________________________
;	     Outputs ________________________

C.7DEC:	PUSH	HL
        PUSH	DE
        PUSH	BC
        CALL	C.7D3F
        LD	IY,I$7CE1
        LD	HL,C.7603
        LD	BC,I.008B
        LDIR	
        PUSH	DE
        LD	DE,I$00E7
J$7E02:	LD	HL,(D.F34D)
        ADD	HL,DE
        LD	(HL),0C3H
        POP	DE
        LD	HL,C.77AD
        LD	BC,I$0092
        LDIR	
J$7E11:	LD	E,(IY)
        LD	D,(IY+1)
        LD	A,D
        OR	E
        JR	Z,J$7E4C
        LD	HL,(D.F34D)
        ADD	HL,DE
        INC	HL
        PUSH	HL
        LD	E,(IY+2)
        LD	D,(IY+3)
        LD	HL,(D.F34D)
        ADD	HL,DE
        EX	DE,HL
        POP	HL
        LD	(HL),E
        INC	HL
        LD	(HL),D
        INC	IY
        INC	IY
        INC	IY
        INC	IY
        JR	J$7E11

J$7E3A:	LD	E,(IY)
        LD	D,(IY+1)
        LD	A,D
        OR	E
        JR	Z,J$7E52
        LD	HL,(D.F34D)
        ADD	HL,DE
        INC	HL
        INC	HL
        LD	(HL),0BFH
J$7E4C:	INC	IY
        INC	IY
        JR	J$7E3A

J$7E52:	POP	BC
        POP	DE
        POP	HL
        RET	

I$7E56:
        .PHASE	0C000H

        DEFB	0EBH,0FEH
        DEFB	090H
        DEFB	"NMS 8250"
        DEFW	512
        DEFB	2
        DEFW	1
        DEFB	2
        DEFW	112
        DEFW	720
        DEFB	0F8H
        DEFW	2
        DEFW	9
        DEFW	1
        DEFW	0

        RET	NC
        LD	(J$C058+1),DE		; set dos kernel in page 1 routine
        LD	(D.C0C4),A		; cold boot flag
        LD	(HL),LOW J$C056
        INC	HL
        LD	(HL),HIGH J$C056	; install disk errorhandler
J$7E81:	LD	SP,I$F51F
        LD	DE,I.C079
        LD	C,0FH
        CALL	C.F37D			; open MSXDOS.SYS
        INC	A
        JP	Z,J$C063		; error,
        LD	DE,J.0100
        LD	C,1AH
        CALL	C.F37D			; transfer to 0100H
        LD	HL,1
        LD	(I.C079+14),HL		; recordsize 1
        LD	HL,04000H-0100H
        LD	DE,I.C079
        LD	C,27H
        CALL	C.F37D			; read MSXDOS.SYS
        JP	J.0100			; start MSXDOS.SYS

J$C056:	DEFW	J$C058

J$C058:	CALL	0			; dos kernel in page 1
        LD	A,C
        AND	0FEH
        CP	02H			; NOT READY error ?
        JP	NZ,J$C06A		; nope, handle as error
        LD	A,(D.C0C4)
        AND	A			; cold boot ?
        JP	Z,J$4022		; yep, start diskbasic
        LD	DE,I$C09E
        LD	C,09H
        CALL	C.F37D			; print errormessage
        LD	C,07H
        CALL	C.F37D			; get key
        JR	J$7E81			; try again

I.C079:	DEFB	0
        DEFB	"MSXDOS  SYS"
        DEFB	0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0
        DEFB	0,0,0,0,0

I$C09E:	DEFB	"Boot error",13,10
        DEFB	"Press any key for retry",13,10
        DEFB	"$"

D.C0C4:	DEFB	0

        DEFB	"v 1.08"

        END
        