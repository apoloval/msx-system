; Diskdriver Panasonic FS-A1GT/FS-A1ST
; Alternate version without SROM/SRAM drive support
;
; FDC	TC8566AF
; extra	S1990 hardware for Disk Change

; Source re-created by Z80DIS 2.2
; Z80DIS was written by Kenneth Gielow, Palo Alto, CA

; Code Copyrighted by Panasonic and maybe others
; Source comments by Arjen Zeilemaker

; Sourcecode supplied for STUDY ONLY
; Recreation NOT permitted without authorisation of the copyrightholders

A1GT    EQU     1               ; FS-A1GT version

MYSIZE	EQU	26		; size of environment
SECLEN	EQU	512		; size of biggest supported sector

ENAKRN	EQU	0F368H
BDOS	EQU	0F37DH
DSKBAS	EQU	04022H


L73C9:	DB	0F8h
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

DEFDPB	EQU	$-1		; default DPB is 720 Kb 3.5"

	DB	0F9h
        DW	512
        DB	00Fh
        DB	004h
        DB	001h
        DB	002h
        DW	1
        DB	2
        DB	112
        DW	14
        DW	714
        DB	3
        DW	7

        DB	0FAh
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

        DB	0FBh
        DW	512
        DB	00Fh
        DB	004h
        DB	001h
        DB	002h
        DW	1
        DB	2
        DB	112
        DW	12
        DW	635
        DB	2
        DW	5

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



; DSKIO
;
; Reads or writes sectors

DSKIO:	EI
        PUSH	AF
        JP	NC,L7550	; read sectors
        PUSH	AF
        PUSH	BC
        PUSH	DE
        PUSH	HL
        CALL	L749B		; do the write operation
        POP	HL
        POP	DE
        POP	BC
        JR	C,L7480		; error, finish dskio
        LD	(IX+5),02H	; only verify
        POP	AF
        AND	A		; read/verify operation
        CALL	L7556		; execute operation
        RES	1,(IX+5)	; reset verify
        PUSH	DE
L7480:	POP	DE
L7481:	EI
        POP	DE
        PUSH	AF
        LD	C,60		; 1 sec
        JR	NC,L748A
        LD	C,0		; 0 sec
L748A:	LD	A,D
        AND	A
        CALL	L7867		; motor off
        JR	NZ,L7496	; drive 1
        LD	(IX+1),C
        POP	AF
        RET
L7496:	LD	(IX+2),C
        POP	AF
        RET

L749B:	CALL	L75EB		; init dskio
        RET	C		; error, quit
        CALL	DISINT
        DI			; disable ints
        PUSH	HL
        LD	HL,ENAINT
        EX	(SP),HL		; after this, enable ints
        LD	A,H
        AND	A		; 8000-FFFF ?
        JP	M,L74DA		; direct transport
        SCF			; write operation
        CALL	L79FC		; copy routine in SECBUF and execute this
        RET	C		; error, quit
        INC	B
        DEC	B
        RET	Z		; 0 sectors, all done, quit
        LD	A,H
        AND	A
        JP	M,L74DA		; now in the page 2 area, direct transport
        PUSH	HL
        PUSH	DE
        PUSH	BC
        LD	DE,(_SECBUF)
        PUSH	DE
        LD	BC,512
        CALL	XFER		; transport sector data to SECBUF
        POP	HL
        POP	BC
        POP	DE
        CALL	L74D1		; write sector (with ready signal)
        POP	HL
        JR	L74DD

L74D1:	CALL	L785F		; normal ready
        CALL	L74E5		; write sector
        JP	L75AA		; force ready

L74DA:	CALL	L74D1		; write sector (with ready signal)
L74DD:	RET	C		; error, quit
        DEC	B
        RET	Z		; all done, quit
        CALL	L78AE		; init for next sector
        JR	L74DA		; again

L74E5:	LD	E,11
L74E7:	PUSH	HL
        PUSH	DE
        PUSH	BC
        LD	DE,L751E	; cont routine
        PUSH	DE
        LD	DE,L7993	; wait 16.5 ms routine
        PUSH	DE
        LD	(IX+10),045H	; WRITE DATA
        LD	B,9
        CALL	L7921		; write bytes to controller
        LD	DE,L7FF4
        LD	B,0		; 256 bytes
L7500:	LD	A,(DE)
        ADD	A,A
        JP	NC,L7500	; wait for Request
        ADD	A,A
        RET	P		; end of Execution
        LD	A,(HL)
        LD	(L7FF5),A
        INC	HL
        DJNZ	L7500
L750E:	LD	A,(DE)
        ADD	A,A
        JP	NC,L750E
        ADD	A,A
        RET	P
        LD	A,(HL)
        LD	(L7FF5),A
        INC	HL
        DJNZ	L750E
        POP	BC
        POP	BC
L751E:	CALL	L799C		; Terminal Count
        CALL	L797B		; read bytes from controller
        POP	BC
        POP	DE
        POP	HL
        LD	A,(IX+19)	; ST0
        AND	0C8H
        RET	Z		; No error AND ready, quit
        AND	008H
        JP	NZ,L754C	; Not ready, quit
        BIT	1,(IX+20)
        JR	NZ,L7549	; Write protect, quit
        CALL	L78DF		; Reposition
        DEC	E
        JR	NZ,L74E7	; next try
        SCF
        BIT	4,(IX+19)
        LD	A,00AH
        RET	NZ		; Equipment Check, quit with Other error
        JP	L79AB		; error from ST1

L7549:	XOR	A
        SCF
        RET

L754C:	LD	A,2
        SCF
        RET

L7550:	CALL	L7556		; execute operation
        JP	L7481		; finish dskio

L7556:	CALL	L75EB		; init dskio
        RET	C
        CALL	DISINT
        DI			; disable ints
        PUSH	HL
        LD	HL,ENAINT
        EX	(SP),HL		; ret to enable ints
        LD	A,H
        AND	A
        JP	M,L75B0		; direct access
        CALL	L79FC		; copy routine in SECBUF and execute this
        RET	C		; error, quit
        INC	B
        DEC	B
        RET	Z		; 0 sectors, all done, quit
        LD	A,H
        AND	A
        JP	M,L75B0		; now in the page 2 area, direct transport
        BIT	1,(IX+5)
        JR	NZ,L7596	; it's a verify,
        PUSH	HL
        LD	HL,(_SECBUF)
        CALL	L75A4		; read sector (with ready) in SECBUF
        POP	HL
        RET	C		; error, quit
        PUSH	HL
        PUSH	DE
        PUSH	BC
        LD	DE,(_SECBUF)
        EX	DE,HL
        LD	BC,512
        CALL	XFER		; transfer SECBUF to transfer adres
        POP	BC
        POP	DE
        POP	HL
        JR	L75BF		; next ?
L7596:	CALL	L759C		; verify sector (with ready)
        RET	C		; error, quit
        JR	L75BF		; next

L759C:	CALL	L785F		; normal ready
        CALL	L75C6		; read/verify sector
        JR	L75AA		; normal ready

L75A4:	CALL	L785F		; normal ready
        CALL	L75C6		; read/verify sector
L75AA:	PUSH	AF
        CALL	L7863		; forced ready
        POP	AF
        RET

L75B0:	BIT	1,(IX+5)
        JR	Z,L75BB		; no verify
        CALL	L759C		; verify sector (with ready)
        JR	L75BE		; next ?

L75BB:	CALL	L75A4		; read sector (with ready)
L75BE:	RET	C		; error, quit
L75BF:	DEC	B
        RET	Z		; all done, quit
        CALL	L78AE		; init for next sector
        JR	L75B0		; again

L75C6:	LD	E,11
L75C8:	BIT	1,(IX+5)
        JR	Z,L75D3		; no verify, do read
        CALL	L7871		; verify data
        JR	L75D6

L75D3:	CALL	L79BB		; read data
L75D6:	LD	A,(IX+19)
        AND	0C8H
        RET	Z		; no error and ready, quit
        AND	008H
        JP	NZ,L754C
        CALL	L78DF		; Reposition
        DEC	E
        JR	NZ,L75C8	; next try
        SCF
        JP	L79AB		; error from ST1

L75EB:	PUSH	AF
        PUSH	BC
        PUSH	HL
        CALL	GETWRK		; GETWRK
        POP	HL
        POP	BC
        POP	AF
        RES	0,(IX+5)
        JR	NC,L75FE
        SET	0,(IX+5)	; write operation
L75FE:	CP	2		; Check driveid
        JR	C,L7606		; valid, continue
L7602:	LD	A,12
        SCF
        RET
L7606:	PUSH	AF
        LD	A,C
        CP	0F8H		; Check mediabyte
        JR	NC,L760F	; valid, continue
        POP	AF
        JR	L7602		; other error

L760F:	POP	AF
        PUSH	IX
        PUSH	BC
        PUSH	DE
        PUSH	AF
        LD	A,(IX+7)
        DEC	A
        JR	NZ,L762F	; double drive system
        POP	AF
        LD	B,0
        PUSH	BC
        CP	(IX+3)		; same logical drive
        JR	Z,L762F		; yes,
        LD	(IX+3),A
        CALL	L7867		; motor off
        PUSH	HL
        CALL	PROMPT		; PROMPT
        POP	HL
L762F:	POP	AF
        POP	DE
        POP	BC
        POP	IX
        LD	(IX+15),002H	; Sectorsize = 512
        LD	(IX+16),009H	; lastsector = 9
        LD	(IX+17),050H	; Gapsize = 80 bytes
        LD	(IX+18),0FFH	; Datalength
        PUSH	HL
        PUSH	AF
        PUSH	BC
        BIT	1,C		; 8 sectors/track ?
        LD	C,E
        LD	B,D
        LD	DE,8
        JR	NZ,L7651	; yeah
        INC	DE		; 9 sectors/track
L7651:	CALL	DIV16		; DIV16
        INC	L
        LD	(IX+14),L	; Record
        LD	L,C
        POP	BC
        POP	AF
        LD	(IX+11),A	; Unit
        AND	A
        LD	A,014H		; motor enable #0, normal operation, select drv 0
        JR	Z,L7665
        LD	A,025H		; motor enable #1, normal operation, select drv 1
L7665:	LD	H,A
        LD	D,A
        BIT	0,C		; double sided ?
        JR	Z,L7679
        SRL	L		; track on side
        JR	NC,L7679
        SET	2,(IX+11)	; Head 1
        LD	(IX+13),1	; side 1
        JR	L7681
L7679:	RES	2,(IX+11)	; Head 0
        LD	(IX+13),0	; side 0
L7681:	LD	A,C
        RRCA
        RRCA
        AND	0C0H		; double/8-9 sect
        OR	D
        LD	D,A
        DI
        LD	A,H
        LD	(L7FF2),A	; motor on
        EI
        LD	C,L		; track on side
        CALL	L785F		; normal ready
        CALL	L76CF		; Wait FDD ready
        PUSH	AF
        CALL	L7863		; force ready
        POP	AF
        JR	C,L76BD		; timeout, Not ready error
        BIT	6,A
        JR	Z,L76AA		; not write protect, select track and quit
        BIT	0,(IX+5)
        JR	Z,L76AA		; it is a read/verify operation, select track and quit
        POP	HL		; write protect + write operation!
        XOR	A
        SCF
        RET			; quit with write protect error


        IF A1GT EQ 1

L76AA:	INC	C
        DEC	C
        JR	NZ,L76B8	; not track 0
        PUSH	BC
        LD	C,6
        CALL	L7900		; Select Track 6
        CALL	L773B		; Recalibrate
        POP	BC
L76B8:	CALL	L7900		; Select Track
        POP	HL
        RET

        ELSE

L76AA:	PUSH	BC
	INC	C
	LD	A,80-1
	CP	C
	JR	NC,J76E7
	DEC	C
	DEC	C
J76E7:	CALL	L7900
	POP	BC
	CALL	L7900
	POP	HL
	RET

        ENDIF

L76BD:	POP	HL
        LD	A,2
        RET

L76C1:	PUSH	BC
        LD	BC,52709
L76C5:	EX	(SP),HL
        EX	(SP),HL
        DEC	BC
        LD	A,B
        OR	C
        JP	NZ,L76C5
        POP	BC
        RET

L76CF:	LD	(IX+10),004H	; SENSE DRIVE STATUS
        PUSH	BC
        LD	HL,5000
L76D7:	DEC	HL
        LD	A,L
        OR	H
        JR	Z,L76EE
        LD	B,2
        CALL	L7921		; write 2 bytes to controller
        CALL	L797B		; read bytes from controller
        LD	A,(IX+19)
        BIT	5,A
        JR	Z,L76D7		; FDD is not ready
        POP	BC
        AND	A
        RET
L76EE:	POP	BC
        SCF
        RET


; INIHRD
;
; Initializes diskhardware

INIHRD:	LD	HL,0
        ADD	HL,SP
        PUSH	HL
        POP	IY
        LD	DE,16
        XOR	A
        SBC	HL,DE
        LD	SP,HL		; Make workarea (16 bytes) on stack
        INC	HL
        LD	DE,10
        XOR	A
        SBC	HL,DE
        PUSH	HL
        POP	IX
        CALL	L7716		; init FDC
        LD	A,14H		; motor enable drv 0, normal operation, select drv 0
        CALL	L7732		; init drive
        LD	SP,IY		; Restore stack


; MTOFF
;
; Motor off

MTOFF:	JP	L7867

L7716:	LD	(L7FF2),A	; reset FDC
        LD	A,0FAH		; 11111010 (enable C6, C6=1, enable C4, C4=1 (force ready), enable C2, no standby, enable C0, no TC)
        LD	(L7FF3),A
        CALL	L7867		; motor off
        LD	(IX+10),003H	; SPECIFY
        LD	(IX+11),0DFH	; HUT 240 ms, SRT 3 ms
        LD	(IX+12),003H	; Non-DMA, HLT 2 ms
        LD	B,3
        JP	L7921		; write 3 bytes to controller

L7732:	LD	(L7FF2),A	; motor on
        LD	(IX+11),A
        CALL	L76C1		; wait 1 second (motor spin up ?)
L773B:	LD	(IX+10),007H	; RECALIBRATE
        LD	B,2
        CALL	L7921		; write 2 bytes to controller
        JP	L7955		; wait for end of seek


; DRIVES
;
; Count the drives connected

DRIVES:	PUSH	BC
        PUSH	AF
        CALL	GETWRK		; GETWRK
        LD	A,025H		; motor enable drv 1, normal operation, select drv 1
        CALL	L7732		; init drive
        LD	L,1
        JR	NC,L7764	; 2 drives connected
        LD	(IX+7),L	; set 1 physical drive
        CALL	L7867		; motor off
        POP	AF
        JR	Z,L775F
        INC	L		; 1 physical must act as 2 logical drives
L775F:	POP	BC
        RET
L7764:	INC	L
        LD	(IX+7),L	; set 2 physical drives
        CALL	L7867		; motor off
        POP	AF
        JR	NZ,L775F
        DEC	L		; only 1 allowed
        JR	L775F


; INIENV
;
; Initializes workarea

; +0	not used
; +1	diskchange down counter drive 0 (used in DOS1)
; +2	diskchange down counter drive 1 (used in DOS1)
; +3	logical drive last diskoperation
; +4	not used
; +5	b0 write operation, b1 verify operation, b2-b7 not used
; +6	not used
; +7	number of physical drives
; +8	not used
; +9	not used
; +10	FDC command string
; +19	FDC result string

INIENV:	LD	A,1
        LD	(RAWFLG),A	; Verify on
        CALL	GETWRK		; GETWRK
        XOR	A
        LD	B,7
L777C:	LD	(HL),A
        INC	HL
        DJNZ	L777C		; Clear environment area
        LD	HL,L7FD4
        JP	SETINT		; SETINT

L7789:	PUSH	AF
        CALL	GETWRK		; GETWRK
        INC	HL
        LD	A,(HL)
        AND	A		; drive 0 counter 0 ?
        JR	Z,L7793
        DEC	(HL)		; nope, decrease
L7793:	INC	HL
        LD	A,(HL)
        AND	A		; drive 1 counter 0 ?
        JR	Z,L7799
        DEC	(HL)		; nope, decrease
L7799:	POP	AF
        JP	PRVINT		; PRVINT


; DSKCHG
;
; Checks if disk was changed

	IFNDEF	DOS2
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
	JR	NZ,J$77DE
	LD	B,(IX+1)
J$77DE:	INC	B
	DEC	B
	LD	B,01H
	RET	NZ
	PUSH	BC
	PUSH	HL
	LD	DE,1
	LD	HL,(_SECBUF)
	AND	A
	CALL	DSKIO
	JR	C,J7808
	LD	HL,(_SECBUF)
	LD	B,(HL)
	POP	HL
	PUSH	BC
	CALL	GETDPB
	LD	A,0CH
	JR	C,J7808
	POP	AF
	POP	BC
	CP	C
	SCF
	CCF
	LD	B,0FFH
	RET	NZ
	INC	B
	RET
J7808:	POP	DE
	POP	DE
	RET

	ELSE

DSKCHG:	EI
        PUSH	HL
        PUSH	BC
        PUSH	AF
        CALL	GETWRK		; GETWRK
        POP	AF
        POP	BC
        POP	HL
        LD	B,(IX+7)
        DEC	B
        JR	NZ,L77BD	; double drive system
        CP	(IX+3)		; logical drive same as last ?
        JR	Z,L77BC		; yep,
        LD	B,0		; disk change unknown
        AND	A
        RET
L77BC:	XOR	A		; physical drive 0
L77BD:	AND	A
        LD	B,010H		; use -DC0
        JR	Z,L77C4		; drive 0
        LD	B,020H		; use -DC1
L77C4:	LD	(IX+11),A
        LD	(IX+10),004H	; SENSE DRIVE STATUS
        CALL	L785F		; normal ready
        PUSH	BC
        LD	B,2
        CALL	L7921		; write 2 bytes to controller
        POP	BC
        JR	C,L77F0		; time out, disk change unknown
L77D7:	LD	A,(L7FF4)
        ADD	A,A
        JR	NC,L77D7	; wait until Request
        LD	A,(L7FF1)
        AND	B		; mask off -DC
        LD	B,A
        CALL	L797B		; read bytes from controller
        LD	A,B
        AND	A
        LD	B,0FFH
        JR	Z,L77ED		; bit was reset, disk changed
        LD	B,1		; disk unchanged
L77ED:	XOR	A
        JR	L77F3		; normal ready
L77F0:	LD	B,0
        AND	A
L77F3:	PUSH	AF
        CALL	L7863		; force ready
        POP	AF
        RET

	ENDIF

; GETDPB
;
; Fills in a Drive Parameter Block

GETDPB:	EI
        EX	DE,HL
        INC	DE
        LD	A,B
        SUB	0F8H
        RET	C
        LD	L,A
        LD	H,0
        ADD	HL,HL
        LD	C,L
        LD	B,H
        ADD	HL,HL
        ADD	HL,HL
        ADD	HL,HL
        ADD	HL,BC
        LD	BC,L73C9
        ADD	HL,BC
        LD	BC,18
        LDIR
        RET


; CHOICE
;
; Returns pointer to formatoption string

CHOICE:	LD	HL,L7824
        RET

L7824:	DEFB	13,10
        DEFB	"1 - 1 side, double track"
        DEFB	13,10
        DEFB	"2 - 2 sides,double track"
        DEFB	13,10
        DEFB	13,10
        DEFB	0

OEMSTA:	SCF
        RET

L785F:	LD	A,020H
        JR	L786D

L7863:	LD	A,030H
        JR	L786D

L7867:	LD	A,004H
        LD	(L7FF2),A	; all motors off, normal operation, drv 0
        RET

L786D:	LD	(L7FF3),A
        RET

L7871:	PUSH	HL
        PUSH	DE
        PUSH	BC
        LD	DE,L78A4
L7877:	PUSH	DE
        LD	DE,L7993	; wait 16.5 ms routine
        PUSH	DE
        LD	(IX+10),046H	; READ DATA, 1 track, MFM, no skip
        LD	B,9
        CALL	L7921		; write 9 bytes to controller
        LD	DE,L7FF4
        LD	B,0
L788A:	LD	A,(DE)
        ADD	A,A
        JP	NC,L788A
        ADD	A,A
        RET	P
        LD	A,(L7FF5)
        DJNZ	L788A
L7896:	LD	A,(DE)
L7897:	ADD	A,A
        JP	NC,L7896
        ADD	A,A
        RET	P
        LD	A,(L7FF5)
L78A0:	DJNZ	L7896
        POP	BC
        POP	BC
L78A4:	CALL	L799C		; Terminal Count
        CALL	L797B		; read bytes from controller
        POP	BC
        POP	DE
        POP	HL
        RET

S_SUPP:

L78AE:	INC	H
        INC	H		; +512
        LD	A,(IX+14)
        INC	A
        LD	(IX+14),A	; R+1
        BIT	7,D
        JR	NZ,L78BE
        CP	9+1
        RET	C
L78BE:	CP	8+1
        RET	C		; still on this cylinder, quit
        LD	(IX+14),1	; R=1
        BIT	6,D
        JR	Z,L78DC		; SS, next track
        LD	A,(IX+13)
        XOR	001H
        LD	(IX+13),A	; other head
        JR	Z,L78D8		; now head 0, next track
        SET	2,(IX+11)
        RET
L78D8:	RES	2,(IX+11)
L78DC:	INC	C
        JR	L7900

L78DF:	BIT	0,E
        RET	NZ
        PUSH	BC
        LD	(IX+10),00FH	; SEEK
        LD	(IX+12),6	; Track 6
        LD	B,3
Q003F:	CALL	L7921		; write 3 bytes to controller
Q0042:	CALL	L7955		; wait for end of seek
        LD	(IX+10),007H	; RECALIBRATE
        LD	B,2
Q004B:	CALL	L7921		; write 2 bytes to controller
Q004E:	CALL	L7955		; wait for end of seek
        POP	BC

L7900:	PUSH	BC
        LD	B,077H
L7903:	EX	(SP),HL
        EX	(SP),HL
        DJNZ	L7903		; wait
        LD 	(IX+10),00FH	; SEEK
        LD	(IX+12),C	; track
        LD	B,3
Q0062:	CALL	L7921		; write 3 bytes to controller
Q0065:	CALL	L7955		; wait on end of seek
        LD	BC,00773H
L7919:	DEC	BC
        LD	A,B
        OR	C
        JR	NZ,L7919	; wait
        POP	BC
        XOR	A
        RET

L7921:	PUSH	HL
        LD	HL,07D0H
Q0077:
L7925:	LD	A,(L7FF4)
        AND	010H
        JR	Z,L7934		; FDC ready,
        DEC	HL
        LD	A,H
        OR	L
        JR	NZ,L7925	; wait until FDC ready
        POP	HL
        SCF			; error flag (takes to much time)
        RET
L7934:	PUSH	DE
        PUSH	IX
        LD	DE,10
        ADD	IX,DE
        PUSH	IX
        POP	HL
        POP	IX
        POP	DE
Q0094:
L7942:	LD	A,(L7FF4)
        AND	0C0H
        CP	080H
        JR	NZ,L7942	; wait until Output Request
        LD	A,(HL)
Q009E:	LD	(L7FF5),A
        INC	HL
        DJNZ	L7942
        POP	HL
        XOR	A
        RET

Q00A7:
L7955:	LD	A,(L7FF4)
        AND	010H
        JR	NZ,L7955	; FDC is busy
Q00AE:
L795C:	CALL	L796B		; get status
        LD	A,(IX+19)
        BIT	5,A
        JR	Z,L795C		; Seek not completed, wait
        AND	0C0H
        RET	Z
        SCF			; Seek error
        RET

L796B:	PUSH	BC
        LD	(IX+10),008H	; SENSE INTERRUPT STATUS
        LD	B,1
Q00C4:	CALL	L7921		; write bytes to controller
Q00C7:	CALL	L797B		; read bytes from controller
        XOR	A
        POP	BC
        RET

L797B:	PUSH	IX
Q00CF:
L797D:	LD	A,(L7FF4)
        ADD	A,A
        JR	NC,L797D	; wait on Request
Q00D5:	JP	P,L7990		; Output Request, quit
Q00D8:	LD	A,(L7FF5)
        LD	(IX+19),A
        INC	IX
        JR	L797D
L7990:	POP	IX
        RET

L7993:	LD	BC,007A8H
L7996:	DEC	BC
        LD	A,B
        OR	C
        JR	NZ,L7996
        RET

L799C:	LD	A,002H
Q00F0:	LD	(L7FF3),A	; enable C0, TC=0
        INC	A
Q00F4:	LD	(L7FF3),A	; enable C0, TC=1
        NOP
        DEC	A
Q00F9:	LD	(L7FF3),A	; enable C0, TC=0
        RET

L79AB:	LD	E,(IX+20)
        BIT	2,E
        LD	A,8		; Record not found
        RET	NZ
        BIT	5,E
        LD	A,4		; Data error
        RET	NZ
        LD	A,12
        RET

L_SUPP	EQU	$-S_SUPP

L79BB:	PUSH	HL
        PUSH	DE
        PUSH	BC
Q0110:	LD	DE,L79F2
        PUSH	DE
Q0114:	LD	DE,L7993
        PUSH	DE
        LD	(IX+10),046H	; READ DATA, 1 Track, MFM, No skip
        LD	B,9
Q011E:	CALL	L7921		; write bytes to controller
Q0121:	LD	DE,L7FF4
        LD	B,0
L79D4:	LD	A,(DE)
        ADD	A,A
Q0128:	JP	NC,L79D4	; wait on Request
        ADD	A,A
        RET	P		; Output Request, quit
Q012D:	LD	A,(L7FF5)
R79DE:	LD	(HL),A
        INC	HL
        DJNZ	L79D4
L79E2:	LD	A,(DE)
        ADD	A,A
Q0136:	JP	NC,L79E2
        ADD	A,A
        RET	P
Q013B:	LD	A,(L7FF5)
R79EC:	LD	(HL),A
        INC	HL
        DJNZ	L79E2
        POP	BC
        POP	BC
Q0144:
L79F2:	CALL	L799C		; terminate transfer
Q0147:	CALL	L797B		; read bytes from controller
        POP	BC
        POP	DE
        POP	HL
        RET

L_SCLP	EQU	$-L79BB


L79FC:	PUSH	HL
        PUSH	IY
        PUSH	DE
        PUSH	BC
        PUSH	AF
        LD	DE,L7AC0
        LD	HL,L7B2C
        LD	BC,L_SCRD
        JR	NC,L7A16	; read/verify, install read/verify sector routine
        LD	DE,L7ACE
        LD	HL,L7B98
        LD	BC,L_SCWR	; write, install write sector routine
L7A16:	PUSH	DE
        LD	DE,(_SECBUF)
        LDIR			; copy routine to secbuf
        POP	HL
        PUSH	DE
L7A1F:	LD	E,(HL)
        INC	HL
        LD	D,(HL)
        INC	HL
        LD	A,D
        OR	E
        JR	Z,L7A3C
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
        JR	L7A1F		; relocate code
L7A3C:	POP	DE
        POP	AF
        PUSH	AF
        PUSH	DE
        LD	HL,L78AE
        LD	BC,L_SUPP+L_SCLP
        JR	NC,L7A4B	; read/verify, install support routines with read/verify routine
        LD	BC,L_SUPP	; write, install support routines without read routine
L7A4B:	LDIR
        POP	IY
        PUSH	AF
        POP	AF
        LD	HL,L7AE8
        LD	B,L_RLRD
        JR	NC,L7A5A	; read/verify, relocate support+read routines
        LD	B,L_RLWR	; write, relocate support routines
L7A5A:	PUSH	BC
        LD	E,(HL)
        INC	HL
        LD	D,(HL)
        INC	HL
        PUSH	HL
        PUSH	IY
        POP	HL
        ADD	HL,DE
        INC	HL
        LD	C,(HL)
        INC	HL
        LD	B,(HL)
        PUSH	HL
        PUSH	IY
        POP	HL
        LD	DE,L78AE
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
        DJNZ	L7A5A
        POP	AF
        PUSH	AF
        LD	HL,L7B0A
        LD	B,L_CTRD
        JR	NC,L7A87	; read/verify, change support+read/verify routines
        LD	B,L_CTWR	; write, change support routines
L7A87:	PUSH	BC
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
        DJNZ	L7A87
        POP	AF
        JR	C,L7AB7
        BIT	1,(IX+5)
        JR	Z,L7AB7		; no verify
        LD	HL,L7B22
L7AA5:	LD	E,(HL)
        INC	HL
        LD	D,(HL)
        INC	HL
        LD	A,D
        OR	E
        JR	Z,L7AB7
        PUSH	HL
        PUSH	IY
        POP	HL
        ADD	HL,DE
        LD	(HL),0
        POP	HL
        JR	L7AA5
L7AB7:	POP	BC
        POP	DE
        POP	IY
        LD	HL,(_SECBUF)
        EX	(SP),HL
        RET


L7AC0:	DEFW	R7B32
        DEFW	R7B4A
        DEFW	R7B54
        DEFW	R7B66
        DEFW	R7B6F
        DEFW	R7B75
        DEFW	0

L7ACE:	DEFW	R7B9E
        DEFW	R7BB6
        DEFW	R7BC3
        DEFW	R7BDB
        DEFW	R7BE9
        DEFW	R7BC7
        DEFW	R7BD1
        DEFW	R7BF7
        DEFW	R7BFF
        DEFW	R7C0F
        DEFW	R7C1E
        DEFW	R7C2C
        DEFW	0

L7AE8:	DEFW	Q003F-S_SUPP
        DEFW	Q0042-S_SUPP
        DEFW	Q004B-S_SUPP
        DEFW	Q004E-S_SUPP
        DEFW	Q0062-S_SUPP
        DEFW	Q0065-S_SUPP
        DEFW	Q00AE-S_SUPP
        DEFW	Q00C4-S_SUPP
        DEFW	Q00C7-S_SUPP
        DEFW	Q00D5-S_SUPP

L_RLWR	EQU	($-L7AE8)/2

        DEFW	Q0110-S_SUPP
        DEFW	Q0114-S_SUPP
        DEFW	Q011E-S_SUPP
        DEFW	Q0128-S_SUPP
        DEFW	Q0136-S_SUPP
        DEFW	Q0144-S_SUPP
        DEFW	Q0147-S_SUPP

L_RLRD	EQU	($-L7AE8)/2


L7B0A:	DEFW	Q0077-S_SUPP
        DEFW	Q0094-S_SUPP
        DEFW	Q009E-S_SUPP
        DEFW	Q00A7-S_SUPP
        DEFW	Q00CF-S_SUPP
        DEFW	Q00D8-S_SUPP
        DEFW	Q00F0-S_SUPP
        DEFW	Q00F4-S_SUPP
        DEFW	Q00F9-S_SUPP

L_CTWR	EQU	($-L7B0A)/2

        DEFW	Q0121-S_SUPP
        DEFW	Q012D-S_SUPP
        DEFW	Q013B-S_SUPP

L_CTRD	EQU	($-L7B0A)/2


L7B22:	DEFW	R79DE-S_SUPP+0
        DEFW	R79DE-S_SUPP+1
        DEFW	R79EC-S_SUPP+0
        DEFW	R79EC-S_SUPP+1
        DEFW	0

L7B2C:

        .PHASE	0

S_SCRD:
        PUSH	HL
        PUSH	DE
        PUSH	BC
        CALL	GETSLT
R7B32:	LD	(L7B8C+1),A
        LD	H,080H
        CALL	ENASLT
        LD	A,(RAMAD1)
        LD	H,040H
        CALL	ENASLT
        POP	BC
        POP	DE
        POP	HL
L7B45:	DEC	HL
        LD	A,H
        ADD	A,HIGH 512
        INC	HL
R7B4A:	JP	M,L7B7D
        LD	E,11
L7B4F:	LD	A,020H
        LD	(LBFF3),A		; READY input from drive
R7B54:	CALL	L79BB-S_SUPP+L_SCRD	; read sector
        LD	A,030H
        LD	(LBFF3),A		; READY input true
        LD	A,(IX+19)
        AND	0C8H
        JR	NZ,L7B6B
        DEC	B
        JR	Z,L7B7D
R7B66:	CALL	L78AE-S_SUPP+L_SCRD	; setup for next sector
        JR	L7B45
L7B6B:	AND	008H
        JR	NZ,L7B7A
R7B6F:	CALL	L78DF-S_SUPP+L_SCRD	; reposition
        DEC	E
        JR	NZ,L7B4F
R7B75:	CALL	L79AB-S_SUPP+L_SCRD	; error from ST2
        JR	L7B7C
L7B7A:	LD	A,2
L7B7C:	SCF
L7B7D:	PUSH	HL
        PUSH	DE
        PUSH	BC
        PUSH	AF
        LD	A,(RAMAD2)
        LD	H,080H
        CALL	ENASLT
        CALL	ENAKRN
L7B8C:	LD	A,0
        LD	H,040H
        CALL	ENASLT
        POP	AF
        POP	BC
        POP	DE
        POP	HL
        RET

L_SCRD	EQU	$-S_SCRD

        .DEPHASE

L7B98:

        .PHASE	0

S_SCWR:
        PUSH	HL
        PUSH	DE
        PUSH	BC
        CALL	GETSLT
R7B9E:	LD	(L7C46+1),A
        LD	H,080H
        CALL	ENASLT
        LD	A,(RAMAD1)
        LD	H,040H
        CALL	ENASLT
        POP	BC
        POP	DE
        POP	HL
L7BB1:	DEC	HL
        LD	A,H
        ADD	A,HIGH 512
        INC	HL
R7BB6:	JP	M,L7C37
        LD	E,11
L7BBB:	PUSH	HL
        PUSH	DE
        PUSH	BC
        LD	A,020H
        LD	(LBFF3),A		; READY input from drive
R7BC3:	LD	DE,L7BF7
        PUSH	DE
R7BC7:	LD	DE,L7993-S_SUPP+L_SCWR	; wait
        PUSH	DE
        LD	(IX+10),045H		; WRITE DATA
        LD	B,9
R7BD1:	CALL	L7921-S_SUPP+L_SCWR	; start FDC command
        LD	DE,LBFF4
        LD	B,0
L7BD9:	LD	A,(DE)
        ADD	A,A
R7BDB:	JP	NC,L7BD9
        ADD	A,A
        RET	P
        LD	A,(HL)
        LD	(LBFF5),A
        INC	HL
        DJNZ	L7BD9
L7BE7:	LD	A,(DE)
        ADD	A,A
R7BE9:	JP	NC,L7BE7
        ADD	A,A
        RET	P
        LD	A,(HL)
        LD	(LBFF5),A
         INC	HL
        DJNZ	L7BE7
        POP	BC
        POP	BC
R7BF7:
L7BF7:	CALL	L799C-S_SUPP+L_SCWR	; terminate transfer
        LD	A,030H
        LD	(LBFF3),A		; READY input true
R7BFF:	CALL	L797B-S_SUPP+L_SCWR	; read FDC status
        POP	BC
        POP	DE
        POP	HL
        LD	A,(IX+19)
        AND	0C8H
        JR	NZ,L7C14
        DEC	B
        JR	Z,L7C37
R7C0F:	CALL	L78AE-S_SUPP+L_SCWR	; setup for next sector
        JR	L7BB1
L7C14:	AND	008H
        JR	NZ,L7C34
        BIT	1,(IX+20)
        JR	NZ,L7C31
R7C1E:	CALL	L78DF-S_SUPP+L_SCWR	; reposition
        DEC	E
        JR	NZ,L7BBB
        BIT	4,(IX+19)
        LD	A,10
        JR	NZ,L7C36
R7C2C:	CALL	L79AB-S_SUPP+L_SCWR	; get error from ST2
        JR	L7C36
L7C31:	XOR	A
        JR	L7C36
L7C34:	LD	A,2
L7C36:	SCF
L7C37:	PUSH	HL
        PUSH	DE
        PUSH	BC
        PUSH	AF
        LD	A,(RAMAD2)
        LD	H,080H
        CALL	ENASLT
        CALL	ENAKRN
L7C46:	LD	A,0
        LD	H,040H
        CALL	ENASLT
        POP	AF
        POP	BC
        POP	DE
        POP	HL
        RET

L_SCWR	EQU	$-S_SCWR

        .DEPHASE


; DSKFMT
;
; Formats a disk

DSKFMT:	PUSH	HL
        POP	IY		; IY= ptr to workarea
        DEC	A
        LD	(IY+9),A	; choice (0=single, 1=double)
        LD	E,A
        LD	A,1
        CP	E
        LD	A,12
        RET	C		; choice <1 or >2, bad parameter
        LD	A,B
        CP	014H
        LD	A,14
        RET	C		; less then 5120 bytes, insufficient memory
        LD	A,D
        AND	001H
        LD	(IY+8),A	; driveid
        LD	D,A
        PUSH	HL
        PUSH	DE
        CALL	GETWRK		; GETWRK
        POP	DE
        LD	A,(IX+7)
        DEC	A
        JR	NZ,L7C96	; double drive system
        LD	A,D
        CP	(IX+3)
        JR	Z,L7C94		; same logical drive,
        LD	(IX+3),A

        IF A1GT EQ 1

        PUSH	DE
        PUSH	IY
        CALL	PROMPT		; PROMPT
        POP	IY
        POP	DE

        ELSE

        CALL	PROMPT		; PROMPT

        ENDIF

L7C94:	LD	D,0
L7C96:	POP	HL
        LD	(IY+7),D	; physical driveid
        PUSH	HL
        LD	BC,10
        ADD	HL,BC
        LD	(IY+5),L
        LD	(IY+6),H	; start of ?? area in workarea
        LD	D,0
        LD	B,5
        LD	HL,L7E13
L7CAC:	ADD	HL,DE
        DJNZ	L7CAC
        POP	DE		; start of workarea
        LD	C,5
        LDIR			; copy diskformat info
        BIT	0,(IY+7)
        LD	A,014H
        JR	Z,L7CBE		; physical drive 0
        LD	A,025H
L7CBE:	LD	(L7FF2),A	; motor on
        CALL	L76C1		; wait 1 second (motor spin up ?)
        PUSH	IY
        POP	HL
        LD	DE,10
        ADD	HL,DE
        LD	(HL),0
        INC	HL
        LD	D,1		; begin with sector 1
        LD	BC,00902H	; 9 sectors
L7CD3:	XOR	A
        LD	(HL),A		; C
        INC	HL
        LD	(HL),A		; H
        INC	HL
        LD	(HL),D		; R
        INC	D
        INC	HL
        LD	(HL),C		; N
        INC	HL
        DJNZ	L7CD3
        PUSH	IY
        POP	HL
        LD	DE,0002FH
        ADD	HL,DE
        PUSH	HL
        POP	IX

        IF A1GT EQ 1

        LD	A,(IY+7)	; physical drive
        LD	(IX+11),A
        LD	C,6
        CALL	L7900		; select track 6
        CALL	L773B		; recalibrate
        LD	A,006H
        JP	C,L7D4B		; seek error
        CALL	DISINT
        DI			; disable interrupts

        ELSE

	CALL	DISINT
	DI

        ENDIF

L7D00:	LD	C,(IY+10)
        LD	A,(IY+7)	; physical drive
        LD	(IX+11),A
        CALL	L7900		; select track
        LD	A,006H
        JR	C,L7D4B		; seek error
        LD	B,0		; side 0
        CALL	L7E68		; format track
        JR	C,L7D4B		; error, finish dskfmt
        BIT	0,(IY+2)	; single ?
        JR	Z,L7D2A		; yep, skip side 1
        CALL	L7993		; wait 16.5 ms
        CALL	L7F1B		; change side in track data
        LD	B,004H		; side 1
        CALL	L7E68		; format track
        JR	C,L7D4B		; error, finish dskfmt
L7D2A:	LD	A,(IY+10)
        INC	A
        CP	80
        JR	NC,L7D57	; track 80, done
        LD	(IY+10),A
        PUSH	IY
        POP	HL
        LD	BC,11
        ADD	HL,BC
        LD	B,9
L7D3E:	LD	(HL),A		; update track
        INC	HL
        LD	(HL),0		; side 0
        INC	HL
        INC	HL
        INC	HL
        DJNZ	L7D3E
        JR	L7D00		; next track
L7D49:	POP	BC
        POP	HL
L7D4B:	PUSH	AF
        EI
        CALL	ENAINT		; enable interrupts
        CALL	L7867		; motor off
        POP	AF
        JP	L7DFD		; adjust to dskfmt errorcodes

L7D57:	PUSH	IY
        POP	HL
        INC	H
        INC	H
        LD	DE,0		; sector 0
        LD	BC,050F8H	; 80 tracks, 0F8H media
        BIT	0,(IY+9)
        JR	Z,L7D6B
        LD	B,0A0H
        INC	C		; 160 tracks, 0F9H media
L7D6B:	PUSH	HL
        PUSH	BC
        PUSH	DE
        LD	B,9		; hole track
        LD	A,(IY+8)
        AND	A		; read
        CALL	DSKIO		; DSKIO
        POP	DE
        JR	C,L7D49		; error, finish dskfmt
        LD	HL,9
        ADD	HL,DE
        EX	DE,HL
        POP	BC
        POP	HL
        DJNZ	L7D6B		; next track
        CALL	L7E05		; clear trackbuffer
        PUSH	HL
        EX	DE,HL
        LD	L,(IY+0)
        LD	H,(IY+1)
        LD	BC,0001EH
        LDIR			; DPB
        LD	HL,L7F2D
        LD	BC,L_BOOT
        LDIR			; Boottrap loader
        POP	HL
        PUSH	HL
        INC	H
        INC	H
        LD	A,(IY+2)
        LD	(HL),A		; mediabyte
        INC	HL
        DEC	(HL)		; #FF
        INC	HL
        DEC	(HL)		; #FF
        INC	H
        INC	H
        INC	H
        INC	H
        CP	0F9H
        JR	NZ,L7DB1
        INC	H
        INC	H		; media 0F9H has 3 sectors per FAT
L7DB1:	DEC	(HL)		; #FF
        DEC	HL
        DEC	(HL)		; #FF
        DEC	HL
        LD	(HL),A		; mediabyte
        POP	HL
        LD	C,A
        LD	B,9		; 9 sectors
        LD	DE,0		; sector 0
        LD	A,(IY+8)
        PUSH	DE
        PUSH	AF
        PUSH	BC
        PUSH	HL
        SCF			; write
        CALL	DSKIO		; DSKIO
        JR	C,L7DF9		; error, adjust to dskfmt errorcodes and quit
        POP	HL
        POP	BC
        POP	AF
        POP	DE
        PUSH	DE
        PUSH	AF
        PUSH	BC
        PUSH	HL
        AND	A		; read
        CALL	DSKIO		; DSKIO
        JR	C,L7DF9		; error, adjust to dskfmt errorcodes and quit
        POP	HL
        CALL	L7E05		; clear trackbuffer
        POP	BC
        POP	AF
        POP	DE
        LD	B,5		; 5 sectors
        LD	DE,9		; sector 9
        PUSH	DE
        PUSH	AF
        PUSH	BC
        PUSH	HL
        SCF			; write
        CALL	DSKIO		; DSKIO
        JR	C,L7DF9		; error, adjust to dskfmt errorcodes and quit
        POP	HL
        POP	BC
        POP	AF
        POP	DE
        AND	A		; read
        CALL	DSKIO		; DSKIO
        JR	C,L7DFD		; error, adjust to dskfmt errorcodes and quit
        RET
L7DF9:	POP	HL
        POP	BC
        POP	DE
        POP	DE
L7DFD:	CP	12
        JR	NZ,L7E03
        LD	A,16
L7E03:	SCF
        RET

L7E05:	PUSH	HL
        LD	BC,9*512
L7E09:	LD	(HL),0
        INC	HL
        DEC	BC
        LD	A,B
        OR	C
        JR	NZ,L7E09
        POP	HL
        RET

L7E13:	DW	L7E1D
        DB	0F8h
        DW	720

        DW	L7E3B
        DB	0F9h
        DW	1440

L7E1D:	DB	0EBh,0FEh,090h
        DB	"MSX_03  "
        DW	512
        DB	2
        DW	1
        DB	2
        DW	112
        DW	720
        DB	0F8h
        DW	2
        DW	9
        DW	1
        DW	0

L7E3B:	DB	0EBh,0FEh,090h
        DB	"MSX_04  "
        DW	512
        DB	2
        DW	1
        DB	2
        DW	112
        DW	1440
        DB	0F9h
        DW	3
        DW	9
        DW	2
        DW	0

L7E59:	DEFB 	04DH		; FORMAT A TRACK
        DEFB	000H		; Unit, Head
        DEFB	2		; 512 bytes sector
        DEFB	9		; 9 sectors on a track
        DEFB	80		; GAP3= 80 bytes
        DEFB	040H		; Filler byte

; This table is NOT USED!

        DEFB	046H		; READ DATA, 1 track, MFM, no skip
        DEFB	0		; Unit, Head
        DEFB	0		; Cylinder
        DEFB	0		; Head
        DEFB	1		; Start Record
        DEFB	2		; 512 byte sector
        DEFB	9		; End Record
        DEFB	80		; GAP3= 80 bytes
        DEFB	0FFH		; Datalength

L7E68:	CALL	L785F		; normal ready
        LD	A,(IY+7)	; physical drive
        LD	(IX+11),A
        CALL	L76CF		; wait FDD ready
        JP	C,L7F0F		; timeout, 30h to 7FF3 (force ready) and quit with not ready error
        BIT	6,A
        JP	NZ,L7F15	; 30h to 7FF3 (force ready), quit with write protect error
        PUSH	BC
        PUSH	IX
        POP	HL
        LD	DE,10
        ADD	HL,DE
        EX	DE,HL
        LD	HL,L7E59
        LD	BC,6
        LDIR
        POP	BC
        LD	A,(IY+7)
        OR	B
        LD	(IX+11),A	; Unit
        LD	B,6
        CALL	L7921		; write bytes to controller
        PUSH	IY
        POP	HL
        LD	BC,11
        ADD	HL,BC
        LD	C,9		; 9 sectors
        LD	DE,L7FF4
L7EA6:	PUSH	BC
        LD	BC,0
L7EAA:	DEC	BC
        LD	A,B
        OR	C
        JR	Z,L7EFF		; takes too long
        LD	A,(DE)
        ADD	A,A
        JP	NC,L7EAA	; wait until b7 set
        LD	A,(HL)
        LD	(L7FF5),A
        INC	HL
        POP	BC
        LD	B,3
L7EBC:	LD	A,(DE)
        ADD	A,A
        JP	NC,L7EBC	; wait until b7 set
        LD	A,(HL)
        LD	(L7FF5),A
        INC	HL
        DJNZ	L7EBC
        DEC	C
        JR	NZ,L7EA6	; next sector
        CALL	L799C		; Terminal Count
        LD	BC,0
L7ED1:	DEC	BC
        LD	A,B
        OR	C
        JR	Z,L7F00		; takes too long
        LD	A,(DE)
        AND	0C0H
        CP	0C0H
        JR	NZ,L7ED1	; wait until command ends
        CALL	L797B		; read bytes from controller
L7EE0:	CALL	L7863		; force ready
        LD	A,(IX+19)
        LD	B,A
        AND	0C0H
        RET	Z
        SCF
        BIT	3,B
        LD	A,2
        RET	NZ		; not ready
        BIT	4,B
        LD	A,10
        RET	NZ		; write fault
        BIT	1,(IX+20)
        LD	A,0
        RET	NZ		; write protect
        LD	A,16
        RET
L7EFF:	POP	BC
L7F00:	XOR	A
        CALL	L7716		; init FDC
        LD	A,004H		; motor off, normal operation, select drv 0
        CALL	L7732		; init drive
        LD	(IX+19),0C8H
        JR	L7EE0

L7F0F:	CALL	L7863		; force ready
        LD	A,2
        RET

L7F15:	CALL	L7863		; force ready
        XOR	A
        SCF
        RET

L7F1B:	PUSH	IY
        POP	HL
        LD	DE,12
        ADD	HL,DE
        LD	B,9
L7F24:	LD	(HL),1
        INC	HL
        INC	HL
        INC	HL
        INC	HL
        DJNZ	L7F24
        RET

L7F2D:
        .PHASE	0C01EH

        RET	NC
        LD	(LC058+1),DE
        LD	(LC0C4),A
        LD	(HL),LOW LC056
        INC	HL
        LD	(HL),HIGH LC056
L7F3A:	LD	SP,KBUF+256
        LD	DE,LC09F
        LD	C,00FH
        CALL	BDOS
        INC	A
        JP	Z,LC063
        LD	DE,00100H
        LD	C,01AH
        CALL	BDOS
        LD	HL,1
        LD	(LC09F+14),HL
        LD	HL,04000H-00100H
        LD	DE,LC09F
        LD	C,027H
        CALL	BDOS
        JP	00100H

LC056:	DEFW	LC058

LC058:	CALL	0
        LD	A,C
        AND	0FEH
        CP	2
        JP	NZ,LC06A
LC063:	LD	A,(LC0C4)
        AND	A
        JP	Z,DSKBAS
LC06A:	LD	DE,LC079
        LD	C,009H
        CALL	BDOS
        LD	C,007H
        CALL	BDOS
        JR	L7F3A

LC079:	DEFB	"Boot error",13,10
        DEFB	"Press any key for retry",13,10
        DEFB	"$"

LC09F:	defb	0
        defb	"MSXDOS  SYS"
        defw 	0
        defw	0
        defb	0,0,0,0
        defw	0
        defw	0
        defb	0
        defb	0
        defw	0
        defw	0
        defw	0
        defb	0
        defb	0,0,0,0

LC0C4:	defb	0

        .DEPHASE

L_BOOT	EQU	$-L7F2D

        IFNDEF	DOS2

        DEFS	07FD4H-$,0

L7FD4:	JP	L7789

        ENDIF



; S1990 FDD registers

L7FF0	EQU	07FF0H		; Diskrom 'segment' select
L7FF1	EQU	07FF1H		; ???, b4 = -DC0, b5 = -DC1, b1 = -HD1, b0 = -HD0

; TC8566 FDC registers

L7FF2	EQU	07FF2H		; DOR, b0 = 0 drive 0, 1 drive 1
                                ;      b1 = not used
                                ;      b2 = 0 reset FDC, 1 enable FDC
                                ;      b3 = 0 disable INTRQ and DRQ2 pins, 1 enable INTRQ and DRQ2 pins
                                ;      b4 = 1 motor select drive 0
                                ;      b5 = 1 motor select drive 1
                                ;      b6 = not used
                                ;      b7 = not used
L7FF3	EQU	07FF3H		; TDR, b0 = Terminate Count
                                ;      b1 = enable TC
                                ;      b2 = Standby Mode
                                ;      b3 = enable SB
                                ;      b4 = C4 output (force READY high)
                                ;      b5 = enable C4
                                ;      b4 = C6 output (not connected)
                                ;      b5 = enable C6
L7FF4	EQU	07FF4H		; MSR, Statusport FDC
L7FF5	EQU	07FF5H		; DAT, Dataport FDC

LBFF3	EQU	L7FF3+04000H
LBFF4	EQU	L7FF4+04000H
LBFF5	EQU	L7FF5+04000H
