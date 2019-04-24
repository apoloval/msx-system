; Diskdriver Panasonic FS-A1F
;
; FDC	TC8566AF

; Source re-created by Z80DIS 2.2
; Z80DIS was written by Kenneth Gielow, Palo Alto, CA

; Code Copyrighted by Panasonic and maybe others
; Source comments by Arjen Zeilemaker

; Sourcecode supplied for STUDY ONLY
; Recreation NOT permitted without authorisation of the copyrightholders


MYSIZE	EQU	26
SECLEN	EQU	512

ENAKRN	EQU	0F368H
BDOS	EQU	0F37DH
DSKBAS	EQU	04022H

;
I7405:
        DB	0F8h
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

;	  Subroutine DSKIO
;	     Inputs  ________________________
;	     Outputs ________________________

DSKIO:
C7495:	EI
        PUSH	AF
        JP	NC,J7588		; DSKIO read
        PUSH	AF
        PUSH	BC
        PUSH	DE
        PUSH	HL
        CALL	C74D3			; DSKIO write
        POP	HL
        POP	DE
        POP	BC
        JR	C,J74B4			; error, quit
        LD	(IX+5),02H		; set verify
        POP	AF
        AND	A
        CALL	C758E			; read sectors
        RES	1,(IX+5)		; reset verify
        PUSH	DE
J74B4:	POP	DE
J74B5:	EI
        POP	DE
        PUSH	AF
        LD	C,60			; diskchange counter, 1 second not diskchange
        JR	NC,J74BE		; no error,
        LD	C,0			; diskchange counter, disk change
J74BE:	LD	(IX+0),240		; diskmotor counter, 4 seconds
        LD	A,D
        AND	A
        CALL	C7885			; Motor off both drives
        JR	NZ,J74CE
        LD	(IX+1),C		; diskchange counter drive 0
        POP	AF
        RET

J74CE:	LD	(IX+2),C		; diskchange counter drive 1
        POP	AF
        RET

;	  Subroutine DSKIO write
;	     Inputs  ________________________
;	     Outputs ________________________

C74D3:	CALL	C7623			; select drive and cylinder
        RET	C			; error, quit
        CALL	DISINT
        DI				; disable interrupts
        PUSH	HL
        LD	HL,ENAINT
        EX	(SP),HL			; enable interrupts at end
        LD	A,H
        AND	A			; transfer from 08000H-0FFFFH ?
        JP	M,J7512			; yep, direct write
        SCF				; write
        CALL	C7A0A			; install DSKIO routine in SECBUF and write
        RET	C			; error, quit
        INC	B
        DEC	B			; all sectors done ?
        RET	Z			; yep, quit
        LD	A,H
        AND	A			; transfer from 08000H-0FFFFH ?
        JP	M,J7512			; yep, direct write
        PUSH	HL
        PUSH	DE
        PUSH	BC
        LD	DE,(_SECBUF)
        PUSH	DE
        LD	BC,512
        CALL	XFER			; XFER
        POP	HL
        POP	BC
        POP	DE
        CALL	C7509			; write sector
        POP	HL
        JR	J7515			; continue

;	  Subroutine write sector with normal ready
;	     Inputs  ________________________
;	     Outputs ________________________

C7509:	CALL	C787D			; Normal READY
        CALL	C751D			; write sector
        JP	J75E2			; Force READY and quit

J7512:	CALL	C7509			; write sector with normal ready
J7515:	RET	C			; error, quit
        DEC	B
        RET	Z			; all done, quit
        CALL	C78CC			; update for next sector
        JR	J7512			; next

;	  Subroutine write sector
;	     Inputs  ________________________
;	     Outputs ________________________

C751D:	LD	E,11			; 11 tries
J751F:	PUSH	HL
        PUSH	DE
        PUSH	BC
        LD	DE,I7556
        PUSH	DE			; finish here
        LD	DE,C79A1
        PUSH	DE			; wait 16.5 ms after command execution
        LD	(IX+10),45H		; WRITE DATA, no MT, MFM mode
        LD	B,9
        CALL	C792F			; start FDC command
        LD	DE,D7FFA
        LD	B,0			; 256 bytes
J7538:	LD	A,(DE)
        ADD	A,A
        JP	NC,J7538
        ADD	A,A
        RET	P
        LD	A,(HL)
        LD	(D7FFB),A
        INC	HL
        DJNZ	J7538
J7546:	LD	A,(DE)
        ADD	A,A
        JP	NC,J7546
        ADD	A,A
        RET	P
        LD	A,(HL)
        LD	(D7FFB),A
        INC	HL
        DJNZ	J7546
        POP	BC
        POP	BC
I7556:	CALL	C79AA			; Terminate transfer
        CALL	C7989			; get result
        POP	BC
        POP	DE
        POP	HL
        LD	A,(IX+19)
        AND	0C8H			; interrupt code, ready flag
        RET	Z			; READY and normal termination, quit without error
        AND	08H			; drive READY ?
        JP	NZ,J7584		; nope, return NOT READY
        BIT	1,(IX+20)		; disk write protected ?
        JR	NZ,J7581		; yep, return WRITE PROTECT
        CALL	C78FD			; reseek every 2nd try
        DEC	E
        JR	NZ,J751F		; next try
        SCF
        BIT	4,(IX+19)		; EC bit set ?
        LD	A,10
        RET	NZ			; yep, return
        JP	C79B9			; return error from ST2

J7581:	XOR	A
        SCF
        RET

J7584:	LD	A,2
        SCF
        RET

;	  Subroutine DSKIO read
;	     Inputs  ________________________
;	     Outputs ________________________

J7588:	CALL	C758E			; read sectors
        JP	J74B5			; finish DSKIO

;	  Subroutine read/verify sectors
;	     Inputs  ________________________
;	     Outputs ________________________

C758E:	CALL	C7623			; select drive and cylinder
        RET	C
        CALL	DISINT
        DI
        PUSH	HL
        LD	HL,ENAINT
        EX	(SP),HL
        LD	A,H
        AND	A
        JP	M,J75E8
        CALL	C7A0A			; install DSKIO routine in SECBUF and read/verify
        RET	C
        INC	B
        DEC	B
        RET	Z
        LD	A,H
        AND	A
        JP	M,J75E8
        BIT	1,(IX+5)		; verify operation ?
        JR	NZ,J75CE		; yep,
        PUSH	HL
        LD	HL,(_SECBUF)
        CALL	C75DC
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
        JR	J75F7

J75CE:	CALL	C75D4
        RET	C
        JR	J75F7

;	  Subroutine verify sector
;	     Inputs  ________________________
;	     Outputs ________________________

C75D4:	CALL	C787D			; Normal READY
        CALL	C75FE			; read/verify sector
        JR	J75E2			; Force READY

;	  Subroutine read sector
;	     Inputs  ________________________
;	     Outputs ________________________

C75DC:	CALL	C787D			; Normal READY
        CALL	C75FE			; read/verify sector
J75E2:	PUSH	AF
        CALL	C7881			; Force READY
        POP	AF
        RET

J75E8:	BIT	1,(IX+5)		; read operation ?
        JR	Z,J75F3			; yep,
        CALL	C75D4			; verify sector with normal ready
        JR	J75F6

J75F3:	CALL	C75DC			; read sector with normal ready
J75F6:	RET	C			; error, quit
J75F7:	DEC	B
        RET	Z			; all done, quit
        CALL	C78CC			; update for next sector
        JR	J75E8

;	  Subroutine read/verify sector
;	     Inputs  ________________________
;	     Outputs ________________________

C75FE:	LD	E,11
J7600:	BIT	1,(IX+5)		; read sector ?
        JR	Z,J760B			; yep,
        CALL	C788F			; verify sector
        JR	J760E

J760B:	CALL	C79C9			; read sector
J760E:	LD	A,(IX+19)
        AND	0C8H
        RET	Z
        AND	08H
        JP	NZ,J7584
        CALL	C78FD			; reseek every 2nd try
        DEC	E
        JR	NZ,J7600
        SCF
        JP	C79B9			; return error from ST2

;	  Subroutine select drive and cylinder
;	     Inputs  ________________________
;	     Outputs ________________________

C7623:	PUSH	AF
        PUSH	BC
        PUSH	HL
        CALL	GETWRK
        POP	HL
        POP	BC
        POP	AF
        RES	0,(IX+5)		; read operation
        JR	NC,J7636
        SET	0,(IX+5)		; write operation
J7636:	CP	2			; driveid valid ?
        JR	C,J763E			; yep, continue
J763A:	LD	A,12			; quit with OTHER ERROR
        SCF
        RET

J763E:	PUSH	AF
        LD	A,C
        CP	0F8H			; mediadescriptor valid ?
        JR	NC,J7647		; yep, continue
        POP	AF
        JR	J763A			; nope, quit with OTHER ERROR

J7647:	POP	AF
        PUSH	IX
        PUSH	BC
        PUSH	DE
        PUSH	AF
        LD	A,(IX+7)
        DEC	A			; 2 physical drives ?
        JR	NZ,J766B		; yep, skip phantom
        POP	AF
        LD	B,0
        PUSH	BC			; physical drive 0
        CP	(IX+3)			; same logical drive as last ?
        JR	Z,J766B			; yep, no need to prompt for disk
        LD	(IX+3),A		; new last logical drive
        XOR	A
        LD	(IX+0),A		; diskmotor counter = 0
        CALL	C7885			; Motor off both drives
        PUSH	HL
        CALL	PROMPT			; PROMPT
        POP	HL
J766B:	POP	AF
        POP	DE
        POP	BC
        POP	IX
        LD	(IX+15),2		; sectorlen 2 (512 bytes)
        LD	(IX+16),9		; last record on track = 9
        LD	(IX+17),50H		; GAP3
        LD	(IX+18),0FFH		; DTL, unused
        PUSH	HL
        PUSH	AF
        PUSH	BC
        BIT	1,C			; 8 sector per track media ?
        LD	C,E
        LD	B,D
        LD	DE,8
        JR	NZ,J768D		; yep, divide sectornumber by 8
        INC	DE			; nope, divide sectornummer by 9
J768D:	CALL	DIV16			; DIV16
        INC	L
        LD	(IX+14),L		; recordnumber (1 based)
        LD	L,C
        POP	BC
        POP	AF
        LD	(IX+11),A		; driveid
        AND	A
        LD	A,14H			; motor on drive 0, enable FDC, select drive 0
        JR	Z,J76A1
        LD	A,25H			; motor on drive 1, enable FDC, select drive 1
J76A1:	LD	H,A
        LD	D,A
        BIT	0,C			; double sided media ?
        JR	Z,J76B5			; nope, use tracknumber as cylindernumber, side 0
        SRL	L			; to cylinder number
        JR	NC,J76B5		; side 0
        SET	2,(IX+11)		; HDS = 1 (head select)
        LD	(IX+13),1		; H = 1 (head)
        JR	J76BD

J76B5:	RES	2,(IX+11)		; HDS = 0 (head select)
        LD	(IX+13),0		; H = 0 (head)
J76BD:	LD	A,C
        RRCA
        RRCA
        AND	0C0H			; mediatype in b7,b6
        OR	D
        LD	D,A			; combine with DOR byte
        DI
        LD	A,(IX+6)		; last current motor on status both drives
        OR	H
        LD	(D7FF8),A		; enable motor, select drive
        AND	30H
        LD	(IX+6),A		; save current motor on status both drives
        LD	(IX+0),0FFH		; diskmotor counter stopped
        EI
        LD	C,L			; cylinder
        CALL	C787D			; Normal READY
        CALL	C7708			; wait for READY from drive
        PUSH	AF
        CALL	C7881			; Force READY
        POP	AF
        JR	C,J7704			; timeout, return NOT READY
        BIT	6,A			; WP set ? (write protected disk)
        JR	Z,J76F2			; nope, continue
        BIT	0,(IX+5)		; write operation ?
        JR	Z,J76F2			; nope, continue
        POP	HL
        XOR	A
        SCF				; return WRITE PROTECT
        RET

J76F2:	PUSH	BC
        INC	C
        LD	A,79
        CP	C			; cylindernumber <79 ?
        JR	NC,J76FB		; yep, seek to cylinder+1
        DEC	C
        DEC	C			; nope, seek to cylinder-1
J76FB:	CALL	C790E			; seek to cylinder
        POP	BC
        CALL	C790E			; seek to cylinder
        POP	HL
        RET

J7704:	POP	HL
        LD	A,2
        RET

;	  Subroutine wait for READY from drive
;	     Inputs  ________________________
;	     Outputs ________________________

C7708:	LD	(IX+10),04H		; SENSE DRIVE STATUS
        PUSH	BC
        LD	HL,5000
J7710:	DEC	HL
        LD	A,L
        OR	H
        JR	Z,J7727			; quit with TIME-OUT
        LD	B,2
        CALL	C792F			; start FDC command
        CALL	C7989			; get result
        LD	A,(IX+19)
        BIT	5,A			; READY signal from drive ?
        JR	Z,J7710			; nope, wait
        POP	BC
        AND	A
        RET

J7727:	POP	BC
        SCF
        RET

;	  Subroutine INIHRD
;	     Inputs  ________________________
;	     Outputs ________________________


INIHRD:	LD	HL,0
        ADD	HL,SP
        PUSH	HL
        POP	IY			; save stackpointer
        LD	DE,16
        XOR	A
        SBC	HL,DE
        LD	SP,HL			; workarea of 16 bytes on stack
        INC	HL
        LD	DE,10
        XOR	A
        SBC	HL,DE
        PUSH	HL
        POP	IX			; FDC command at offset 10
        CALL	C7753			; initialize FDC
        LD	A,4
        CALL	C776F			; recalibrate drive 0
        LD	SP,IY			; restore stackpointer

;	  Subroutine MTOFF
;	     Inputs  ________________________
;	     Outputs ________________________

MTOFF:	CALL	C7885			; Motor off both drives
        LD	(IX+6),A		; last current motor on status both drives = OFF
        RET

;	  Subroutine initialize FDC
;	     Inputs  ________________________
;	     Outputs ________________________

C7753:	LD	(D7FF8),A
        LD	A,0FAH
        LD	(D7FF9),A		; normal READY, disable TC
        CALL	C7885			; Motor off both drives
        LD	(IX+10),03H		; SPECIFY
        LD	(IX+11),0DFH		; SRT=13, HUT=15 (step rate=3 ms, head unload time=240 ms)
        LD	(IX+12),09H		; HLT=4,ND=1 (head load time=8 ms, non DMA mode)
        LD	B,3
        JP	C792F			; start FDC command

;	  Subroutine recalibrate drive
;	     Inputs  ________________________
;	     Outputs ________________________

C776F:	LD	(D7FF8),A
        AND	0FBH
        LD	(IX+11),A		; drive
        LD	(IX+10),07H		; RECALIBRATE
        LD	B,2
        CALL	C792F			; start FDC command
        JP	C7963			; wait for seek complete

;	  Subroutine DRIVES
;	     Inputs  ________________________
;	     Outputs ________________________

DRIVES:	PUSH	BC
        PUSH	AF
        CALL	GETWRK
        LD	A,5
        CALL	C776F			; recalibrate drive 1
        LD	L,1
        JR	NC,J779D		; no error, 2 physical drives!
        LD	(IX+7),L
        CALL	C7885			; Motor off both drives
        POP	AF
        JR	Z,J779B			; SHIFT pressed, return 1 drive
        INC	L			; 2 drives (phantomed)
J779B:	POP	BC
        RET

J779D:	INC	L
        LD	(IX+7),L
        CALL	C7885			; Motor off both drives
        POP	AF
        JR	NZ,J779B		; SHIFT not pressed, return 2 drives
        DEC	L
        JR	J779B			; 1 drive

;	  Subroutine INIENV
;	     Inputs  ________________________
;	     Outputs ________________________

INIENV:	LD	A,1
        LD	(RAWFLG),A		; verify flag
        CALL	GETWRK
        XOR	A
        LD	B,7
J77B5:	LD	(HL),A
        INC	HL
        DJNZ	J77B5			; clear variables
        LD	HL,I77BF
        JP	SETINT			; install driver interrupt handler

I77BF:	PUSH	AF
        CALL	GETWRK
        LD	A,(HL)
        AND	A			; motor downcounter already zero ?
        JR	Z,J77D4			; yep, skip downcount
        CP	0FFH			; motor downcounter stopped ?
        JR	Z,J77D4			; yep, skip downcount
        DEC	A
        LD	(HL),A			; downcount
        JR	NZ,J77D4
        LD	A,4
        LD	(IX+6),A		; counter reached zero, last current motor on status both drives = OFF
J77D4:	INC	HL
        LD	A,(HL)
        AND	A			; drive 0 diskchange downcounter already zero ?
        JR	Z,J77DA			; yep, skip downcount
        DEC	(HL)			; nope, downcount
J77DA:	INC	HL
        LD	A,(HL)
        AND	A			; drive 1 diskchange downcounter already zero ?
        JR	Z,J77E0
        DEC	(HL)			; nope, downcount
J77E0:	POP	AF
        JP	PRVINT

;	  Subroutine DSKCHG
;	     Inputs  ________________________
;	     Outputs ________________________

DSKCHG:	EI
        PUSH	HL
        PUSH	BC
        PUSH	AF
        CALL	GETWRK
        POP	AF
        POP	BC
        POP	HL
        AND	A			; drive 0 ?
        LD	B,(IX+2)
        JR	NZ,J77F7		; nope, use diskchange counter drive 1
        LD	B,(IX+1)		; yep, use diskchange counter drive 0
J77F7:	INC	B
        DEC	B			; diskchange counter reached zero ?
        LD	B,1
        RET	NZ			; nope, return DISK UNCHANGED
        PUSH	BC
        PUSH	HL
        LD	DE,1
        LD	HL,(_SECBUF)
        AND	A
        CALL	C7495			; read 1st sector 1st FAT
        JR	C,J7820			; error, quit with error
        LD	HL,(_SECBUF)
        LD	B,(HL)			; mediadescriptor
        POP	HL
        PUSH	BC
        CALL	C7823			; GETDPB (get drive parameter block)
        LD	A,12
        JR	C,J7820			; error, quit with OTHER ERROR
        POP	AF
        POP	BC
        CP	C			; new mediadescriptor same as old one ?
        SCF
        CCF				; reset Cx
        LD	B,0FFH
        RET	NZ			; nope, return DISK CHANGED
        INC	B			; return DISK CHANGE UNKNOWN
J7820:	POP	DE
        POP	DE
        RET

;	  Subroutine GETDPB
;	     Inputs  ________________________
;	     Outputs ________________________

GETDPB:
C7823:	EI
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
        LD	BC,I7405
        ADD	HL,BC
        LD	BC,18
        LDIR
        RET

;	  Subroutine CHOICE
;	     Inputs  ________________________
;	     Outputs ________________________

CHOICE:	LD	HL,I7842
        RET

I7842:	DEFB	13,10
        DEFB	"1 - 1 side, double track",13,10
        DEFB	"2 - 2 sides,double track",13,10
        DEFB	13,10
        DEFB	0

;	  Subroutine OEMSTA
;	     Inputs  ________________________
;	     Outputs ________________________

OEMSTA:	SCF
        RET

;	  Subroutine Normal READY
;	     Inputs  ________________________
;	     Outputs ________________________

C787D:	LD	A,20H
        JR	J788B

;	  Subroutine Force READY
;	     Inputs  ________________________
;	     Outputs ________________________

C7881:	LD	A,30H
        JR	J788B

;	  Subroutine motor off both drives
;	     Inputs  ________________________
;	     Outputs ________________________

C7885:	LD	A,4
        LD	(D7FF8),A		; motor off both drives, enable FDC
        RET

J788B:	LD	(D7FF9),A
        RET

;	  Subroutine verify sector
;	     Inputs  ________________________
;	     Outputs ________________________

C788F:	PUSH	HL
        PUSH	DE
        PUSH	BC
        LD	DE,I78C2
J7895:	PUSH	DE
        LD	DE,C79A1
        PUSH	DE			; wait 16.5 ms after command execution
        LD	(IX+10),46H		; READ DATA, no MT, MFM mode
        LD	B,9
        CALL	C792F			; start FDC command
        LD	DE,D7FFA
        LD	B,00H
J78A8:	LD	A,(DE)
        ADD	A,A
        JP	NC,J78A8
        ADD	A,A
        RET	P
        LD	A,(D7FFB)
        DJNZ	J78A8
J78B4:	LD	A,(DE)
J78B5:	ADD	A,A
        JP	NC,J78B4
        ADD	A,A
        RET	P
        LD	A,(D7FFB)
J78BE:	DJNZ	J78B4
        POP	BC
        POP	BC
I78C2:	CALL	C79AA			; Terminate transfer
        CALL	C7989			; get result
        POP	BC
        POP	DE
        POP	HL
        RET



S_SUPP:

;	  Subroutine update for next sector
;	     Inputs  ________________________
;	     Outputs ________________________

C78CC:	INC	H
        INC	H			; update transferaddress
        LD	A,(IX+14)
        INC	A
        LD	(IX+14),A		; update recordnumber
        BIT	7,D			; 8 sectors per track media ?
        JR	NZ,J78DC		; yep, check if end of track
        CP	9+1
        RET	C
J78DC:	CP	8+1
        RET	C
        LD	(IX+14),1		; record = 1
        BIT	6,D			; double sided media ?
        JR	Z,J78FA			; nope, to next cylinder
        LD	A,(IX+13)
        XOR	01H
        LD	(IX+13),A		; flip side
        JR	Z,J78F6			; was at side 1, to next cylinder, head 0
        SET	2,(IX+11)		; head 1
        RET

J78F6:	RES	2,(IX+11)		; head 0
J78FA:	INC	C			; next cylinder
        JR	C790E			; seek to cylinder

;	  Subroutine reseek every 2nd try
;	     Inputs  ________________________
;	     Outputs ________________________

C78FD:	BIT	0,E
        RET	NZ
        LD	(IX+10),07H		; RECALIBRATE
        PUSH	BC
        LD	B,2
R7907:	CALL	C792F			; start FDC command
R790A:	CALL	C7963			; wait for seek complete
        POP	BC

;	  Subroutine seek to cylinder
;	     Inputs  ________________________
;	     Outputs ________________________

C790E:	PUSH	BC
        LD	B,106
J7911:	EX	(SP),HL
        EX	(SP),HL
        DJNZ	J7911			; wait 1.6 ms
        LD	(IX+10),0FH		; SEEK
        LD	(IX+12),C		; cylinder
        LD	B,3
R791E:	CALL	C792F			; start FDC command
R7921:	CALL	C7963			; wait for seek complete
        LD	BC,006FCH
J7927:	DEC	BC
        LD	A,B
        OR	C
        JR	NZ,J7927		; wait
        POP	BC
        XOR	A
        RET

;	  Subroutine start FDC command
;	     Inputs  ________________________
;	     Outputs ________________________

C792F:	PUSH	HL
        LD	HL,2000
J7933:	LD	A,(D7FFA)
        AND	10H
        JR	Z,J7942
        DEC	HL
        LD	A,H
        OR	L
        JR	NZ,J7933		; wait for 33.5 ms
        POP	HL
        SCF
        RET

J7942:	PUSH	DE
        PUSH	IX
        LD	DE,10
        ADD	IX,DE
        PUSH	IX
        POP	HL
        POP	IX
        POP	DE
J7950:	LD	A,(D7FFA)
        AND	0C0H
        CP	80H
        JR	NZ,J7950
        LD	A,(HL)
R795A:	LD	(D7FFB),A
        INC	HL
        DJNZ	J7950
        POP	HL
        XOR	A
        RET

;	  Subroutine wait for seek to complete
;	     Inputs  ________________________
;	     Outputs ________________________

C7963:	LD	A,(D7FFA)
        AND	10H
        JR	NZ,C7963		; wait if FDC is busy
J796A:	CALL	C7979			; get interrupt status
        LD	A,(IX+19)
        BIT	5,A			; SEEK COMPLETED ?
        JR	Z,J796A			; nope, wait
        AND	0C0H			; interrupt code
        RET	Z			; no error, quit
        SCF
        RET				; flag error and quit

;	  Subroutine get interrupt status
;	     Inputs  ________________________
;	     Outputs ________________________

C7979:	PUSH	BC
        LD	(IX+10),08H		; SENSE INTERRUPT STATUS
        LD	B,1
R7980:	CALL	C792F			; start FDC command
R7983:	CALL	C7989			; get result
        XOR	A
        POP	BC
        RET

;	  Subroutine get result
;	     Inputs  ________________________
;	     Outputs ________________________

C7989:	PUSH	IX
J798B:	LD	A,(D7FFA)
        ADD	A,A
        JR	NC,J798B
R7991:	JP	P,J799E
R7994:	LD	A,(D7FFB)
        LD	(IX+19),A
        INC	IX
        JR	J798B

J799E:	POP	IX
        RET

;	  Subroutine wait 16.5 ms
;	     Inputs  ________________________
;	     Outputs ________________________

C79A1:	LD	BC,1960
J79A4:	DEC	BC
        LD	A,B
        OR	C
        JR	NZ,J79A4
        RET

;	  Subroutine terminate transfer
;	     Inputs  ________________________
;	     Outputs ________________________

C79AA:	LD	A,2
R79AC:	LD	(D7FF9),A		; TC=0
        INC	A
R79B0:	LD	(D7FF9),A		; TC=1
        NOP
        DEC	A
R79B5:	LD	(D7FF9),A		; TC=0
        RET

;	  Subroutine return error from ST2
;	     Inputs  ________________________
;	     Outputs ________________________

C79B9:	LD	E,(IX+20)
        BIT	2,E			; scan not satisfied ?
        LD	A,8
        RET	NZ			; yep,
        BIT	5,E			; data error ?
        LD	A,4
        RET	NZ			; yep,
        LD	A,12			; OTHER ERROR
        RET

L_SUPP	EQU	$-S_SUPP


S_VFSC:

;	  Subroutine read sector
;	     Inputs  ________________________
;	     Outputs ________________________

C79C9:	PUSH	HL
        PUSH	DE
        PUSH	BC
R79CC:	LD	DE,I7A00
        PUSH	DE
R79D0:	LD	DE,C79A1
        PUSH	DE			; wait 16.5 ms after command execution
        LD	(IX+10),46H		; READ DATA, no MT, MFM mode
        LD	B,9
R79DA:	CALL	C792F			; start FDC command
R79DD:	LD	DE,D7FFA
        LD	B,0
J79E2:	LD	A,(DE)
        ADD	A,A
R79E4:	JP	NC,J79E2
        ADD	A,A
        RET	P
R79E9:	LD	A,(D7FFB)
R79EC:	LD	(HL),A
        INC	HL
        DJNZ	J79E2
J79F0:	LD	A,(DE)
        ADD	A,A
R79F2:	JP	NC,J79F0
        ADD	A,A
        RET	P
R79F7:	LD	A,(D7FFB)
R79FA:	LD	(HL),A
        INC	HL
        DJNZ	J79F0
        POP	BC
        POP	BC
I7A00:	CALL	C79AA			; Terminate transfer
R7A03:	CALL	C7989			; get result
        POP	BC
        POP	DE
        POP	HL
        RET

L_VFSC	EQU	$-S_VFSC

;	  Subroutine install DSKIO routine in SECBUF
;	     Inputs  ________________________
;	     Outputs ________________________

C7A0A:	PUSH	HL
        PUSH	IY
        PUSH	DE
        PUSH	BC
        PUSH	AF
        LD	DE,I7ACE		; offset table read/verify
        LD	HL,S_RDSC		; read/verify routine
        LD	BC,L_RDSC
        JR	NC,J7A24		; read/verify
        LD	DE,I7ADC		; offset table write
        LD	HL,S_WRSC		; write routine
        LD	BC,L_WRSC
J7A24:	PUSH	DE
        LD	DE,(_SECBUF)
        LDIR
        POP	HL
        PUSH	DE
J7A2D:	LD	E,(HL)
        INC	HL
        LD	D,(HL)
        INC	HL
        LD	A,D
        OR	E			; end of table ?
        JR	Z,J7A4A			; yep,
        PUSH	HL
        LD	HL,(_SECBUF)
        ADD	HL,DE
        INC	HL
        LD	C,(HL)
        INC	HL
        LD	B,(HL)			; address
        EX	DE,HL
        LD	HL,(_SECBUF)
        ADD	HL,BC			; adjust to SECBUF address
        EX	DE,HL
        LD	(HL),D
        DEC	HL
        LD	(HL),E			; update address
        POP	HL
        JR	J7A2D

J7A4A:	POP	DE
        POP	AF
        PUSH	AF
        PUSH	DE
        LD	HL,S_SUPP
        LD	BC,L_SUPP + L_VFSC
        JR	NC,J7A59		; read/verify
        LD	BC,L_SUPP
J7A59:	LDIR
        POP	IY
        PUSH	AF
        POP	AF
        LD	HL,I7AF6		; offset table support routines
        LD	B,15
        JR	NC,J7A68
        LD	B,8
J7A68:	PUSH	BC
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
        LD	DE,S_SUPP
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
        DJNZ	J7A68
        POP	AF
        PUSH	AF
        LD	HL,I7B14		; offset table support routines
        LD	B,12
        JR	NC,J7A95
        LD	B,9
J7A95:	PUSH	BC
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
        DJNZ	J7A95
        POP	AF
        JR	C,J7AC5
        BIT	1,(IX+5)
        JR	Z,J7AC5
        LD	HL,I7B2C		; offset table verify routine
J7AB3:	LD	E,(HL)
        INC	HL
        LD	D,(HL)
        INC	HL
        LD	A,D
        OR	E
        JR	Z,J7AC5
        PUSH	HL
        PUSH	IY
        POP	HL
        ADD	HL,DE
        LD	(HL),0
        POP	HL
        JR	J7AB3

J7AC5:	POP	BC
        POP	DE
        POP	IY
        LD	HL,(_SECBUF)
        EX	(SP),HL
        RET

I7ACE:	DEFW	R3006
        DEFW	R301E
        DEFW	R3028
        DEFW	R303A
        DEFW	R3043
        DEFW	R3049
        DEFW	0


I7ADC:	DEFW	R1006
        DEFW	R101E
        DEFW	R102B
        DEFW	R1043
        DEFW	R1051
        DEFW	R102F
        DEFW	R1039
        DEFW	R105F
        DEFW	R1067
        DEFW	R1077
        DEFW	R1086
        DEFW	R1094
        DEFW	0


I7AF6:	DEFW	R7907-S_SUPP
        DEFW	R790A-S_SUPP
        DEFW	R791E-S_SUPP
        DEFW	R7921-S_SUPP
        DEFW	J796A-S_SUPP
        DEFW	R7980-S_SUPP
        DEFW	R7983-S_SUPP
        DEFW	R7991-S_SUPP

        DEFW	R79CC-S_SUPP
        DEFW	R79D0-S_SUPP
        DEFW	R79DA-S_SUPP
        DEFW	R79E4-S_SUPP
        DEFW	R79F2-S_SUPP
        DEFW	I7A00-S_SUPP
        DEFW	R7A03-S_SUPP


I7B14:	DEFW	J7933-S_SUPP
        DEFW	J7950-S_SUPP
        DEFW	R795A-S_SUPP
        DEFW	C7963-S_SUPP
        DEFW	J798B-S_SUPP
        DEFW	R7994-S_SUPP
        DEFW	R79AC-S_SUPP
        DEFW	R79B0-S_SUPP
        DEFW	R79B5-S_SUPP

        DEFW	R79DD-S_SUPP
        DEFW	R79E9-S_SUPP
        DEFW	R79F7-S_SUPP


I7B2C:	DEFW	R79EC-S_SUPP
        DEFW	R79EC-S_SUPP+1
        DEFW	R79FA-S_SUPP
        DEFW	R79FA-S_SUPP+1
        DEFW	0


;	  Subroutine read sector(s)
;	     Inputs  ________________________
;	     Outputs ________________________
;	Remark	this routine in copied to (_SECBUF)+0

I7B36:
S_RDSC:
        .PHASE	0

        PUSH	HL
        PUSH	DE
        PUSH	BC
        CALL	GETSLT
R3006:	LD	(R3060+1),A		; save driver slot
        LD	H,80H
        CALL	ENASLT			; driver slot in page 2
        LD	A,(RAMAD1)
        LD	H,40H
        CALL	ENASLT			; RAM in page 1
        POP	BC
        POP	DE
        POP	HL
J7B4F:	DEC	HL
        LD	A,H
        ADD	A,2
        INC	HL
R301E:	JP	M,J7B87
        LD	E,11
J7B59:	LD	A,20H
        LD	(DBFF9),A		; Normal READY
R3028:	CALL	L_SUPP+L_RDSC		; read sector
        LD	A,30H
        LD	(DBFF9),A		; Force READY
        LD	A,(IX+19)
        AND	0C8H
        JR	NZ,J7B75
        DEC	B
        JR	Z,J7B87
R303A:	CALL	C78CC-S_SUPP+L_RDSC	; update for next sector
        JR	J7B4F

J7B75:	AND	08H
        JR	NZ,J7B84
R3043:	CALL	C78FD-S_SUPP+L_RDSC	; reseek every 2nd try
        DEC	E
        JR	NZ,J7B59
R3049:	CALL	C79B9-S_SUPP+L_RDSC	; return error from ST2
        JR	J7B86

J7B84:	LD	A,2
J7B86:	SCF
J7B87:	PUSH	HL
        PUSH	DE
        PUSH	BC
        PUSH	AF
        LD	A,(RAMAD2)
        LD	H,80H
        CALL	ENASLT			; restore RAM in page 2
        CALL	ENAKRN			; restore kernel ROM in page 1
R3060:	LD	A,0
        LD	H,40H
        CALL	ENASLT			; restore driver ROM in page 1
        POP	AF
        POP	BC
        POP	DE
        POP	HL
        RET

        .DEPHASE
L_RDSC	EQU	$-S_RDSC


;	  Subroutine write sector(s)
;	     Inputs  ________________________
;	     Outputs ________________________
;	Remark	this routine in copied to (_SECBUF)+0

I7BA2:
S_WRSC:
        .PHASE 0

        PUSH	HL
        PUSH	DE
        PUSH	BC
        CALL	GETSLT
R1006:	LD	(R10AE+1),A		; save driver slot
        LD	H,80H
        CALL	ENASLT			; driver slot in page 2
        LD	A,(RAMAD1)
        LD	H,40H
        CALL	ENASLT			; RAM in slot 1
        POP	BC
        POP	DE
        POP	HL
J7BBB:	DEC	HL
        LD	A,H
        ADD	A,2
        INC	HL
R101E:	JP	M,J7C41
        LD	E,11
J7BC5:	PUSH	HL
        PUSH	DE
        PUSH	BC
        LD	A,20H
        LD	(DBFF9),A		; Normal READY
R102B:	LD	DE,R105F
        PUSH	DE
R102F:	LD	DE,C79A1-S_SUPP+L_WRSC
        PUSH	DE			; wait 16.5 ms after command execution
        LD	(IX+10),45H
        LD	B,9
R1039:	CALL	C792F-S_SUPP+L_WRSC	; start FDC command
        LD	DE,DBFFA
        LD	B,0
J7BE3:	LD	A,(DE)
        ADD	A,A
R1043:	JP	NC,J7BE3
        ADD	A,A
        RET	P
        LD	A,(HL)
        LD	(DBFFB),A
        INC	HL
        DJNZ	J7BE3
J7BF1:	LD	A,(DE)
        ADD	A,A
R1051:	JP	NC,J7BF1
        ADD	A,A
        RET	P
        LD	A,(HL)
        LD	(DBFFB),A
        INC	HL
        DJNZ	J7BF1
        POP	BC
        POP	BC
R105F:	CALL	C79AA-S_SUPP+L_WRSC	; Terminate transfer
        LD	A,30H
        LD	(DBFF9),A		; Force READY
R1067:	CALL	C7989-S_SUPP+L_WRSC	; get result
        POP	BC
        POP	DE
        POP	HL
        LD	A,(IX+19)
        AND	0C8H
        JR	NZ,J7C1E
        DEC	B
        JR	Z,J7C41
R1077:	CALL	C78CC-S_SUPP+L_WRSC	; update for next sector
        JR	J7BBB

J7C1E:	AND	08H
        JR	NZ,J7C3E
        BIT	1,(IX+20)
        JR	NZ,J7C3B
R1086:	CALL	C78FD-S_SUPP+L_WRSC	; reseek every 2nd try
        DEC	E
        JR	NZ,J7BC5
        BIT	4,(IX+19)
        LD	A,0AH
        JR	NZ,J7C40
R1094:	CALL	C79B9-S_SUPP+L_WRSC	; return error from ST2
        JR	J7C40

J7C3B:	XOR	A
        JR	J7C40

J7C3E:	LD	A,2
J7C40:	SCF
J7C41:	PUSH	HL
        PUSH	DE
        PUSH	BC
        PUSH	AF
        LD	A,(RAMAD2)
        LD	H,80H
        CALL	ENASLT
        CALL	ENAKRN
R10AE:	LD	A,0
        LD	H,40H
        CALL	ENASLT
        POP	AF
        POP	BC
        POP	DE
        POP	HL
        RET

        .DEPHASE
L_WRSC	EQU	$-S_WRSC

;	  Subroutine DSKFMT
;	     Inputs  ________________________
;	     Outputs ________________________

DSKFMT:	PUSH	HL
        POP	IY			; start of the workarea for DSKFMT
        DEC	A
        LD	(IY+9),A		; save choice
        LD	E,A
        LD	A,1
        CP	E			; choice valid ?
        LD	A,12
        RET	C			; nope, return BAD OPTION
        LD	A,B
        CP	HIGH 01400H		; workarea big enough ?
        LD	A,14
        RET	C			; nope, return WORKAREA TOO SMALL
        LD	A,D
        AND	01H
        LD	(IY+8),A		; driveid
        LD	D,A
        PUSH	HL
        PUSH	DE
        CALL	GETWRK
        POP	DE
        LD	A,(IX+7)
        DEC	A			; 1 physical drive ?
        JR	NZ,J7C91		; nope, use driveid as physical drive
        LD	A,D
        CP	(IX+3)			; same logical drive as last ?
        JR	Z,J7C8F			; yep, format drive 0
        LD	(IX+3),A
        CALL	PROMPT			; PROMPT
J7C8F:	LD	D,0			; physical drive 0
J7C91:	POP	HL
        LD	(IY+7),D		; physical drive
        PUSH	HL
        LD	BC,10
        ADD	HL,BC
        LD	(IY+5),L
        LD	(IY+6),H
        LD	D,0
        LD	B,5
        LD	HL,I7DF8
J7CA7:	ADD	HL,DE
        DJNZ	J7CA7
        POP	DE
        LD	C,5
        LDIR
        BIT	0,(IY+7)
        LD	A,14H			; motor on drive 0, select drive 0
        JR	Z,J7CB9
        LD	A,25H			; motor on drive 1, select drive 1
J7CB9:	LD	(D7FF8),A		; motor on, select drive
        PUSH	IY
        POP	HL
        LD	DE,10
        ADD	HL,DE
        LD	(HL),0			; cylinder 0
        INC	HL
        LD	D,1			; record 1
        LD	BC,00902H		; 9 records, sectorsize 512
J7CCB:	XOR	A
        LD	(HL),A			; C=0
        INC	HL
        LD	(HL),A			; H=0
        INC	HL
        LD	(HL),D			; R
        INC	D
        INC	HL
        LD	(HL),C			; N
        INC	HL
        DJNZ	J7CCB
        PUSH	IY
        POP	HL
        LD	DE,47
        ADD	HL,DE
        PUSH	HL
        POP	IX
        CALL	DISINT
        DI				; disable interrupts
J7CE5:	LD	C,(IY+10)		; cylinder
        LD	A,(IY+7)		; physical drive
        LD	(IX+11),A
        CALL	C790E			; seek to cylinder
        LD	A,6
        JR	C,J7D30			; error, return SEEK ERROR
        LD	B,0
        CALL	C7E4D			; format cylinder side 0
        JR	C,J7D30			; error, quit
        BIT	0,(IY+2)		; single sided format ?
        JR	Z,J7D0F			; yep, next cylinder
        CALL	C79A1			; wait 16.5 ms
        CALL	C7F00			; change to side 1
        LD	B,4
        CALL	C7E4D			; format cylinder side 1
        JR	C,J7D30			; error, quit
J7D0F:	LD	A,(IY+10)
        INC	A
        CP	80
        JR	NC,J7D3C
        LD	(IY+10),A		; next cylinder
        PUSH	IY
        POP	HL
        LD	BC,11
        ADD	HL,BC
        LD	B,9
J7D23:	LD	(HL),A			; new cylinder
        INC	HL
        LD	(HL),0			; H = 0
        INC	HL
        INC	HL
        INC	HL
        DJNZ	J7D23			; next record
        JR	J7CE5			; next cylinder

J7D2E:	POP	BC
        POP	HL
J7D30:	PUSH	AF
        EI
        CALL	ENAINT			; enable interrupts
        CALL	C7885			; Motor off both drives
        POP	AF
        JP	J7DE2			; adjust errorcode and quit

J7D3C:	PUSH	IY
        POP	HL
        INC	H
        INC	H
        LD	DE,0			; start with sector 0
        LD	BC,050F8H		; 80 tracks, mediadescriptor 0F8H
        BIT	0,(IY+9)
        JR	Z,J7D50
        LD	B,0A0H
        INC	C			; 160 tracks, mediadescriptor 0F9H
J7D50:	PUSH	HL
        PUSH	BC
        PUSH	DE
        LD	B,9			; 9 sectors
        LD	A,(IY+8)		; drive
        AND	A			; read operation
        CALL	C7495			; read track
        POP	DE
        JR	C,J7D2E			; error, quit
        LD	HL,9
        ADD	HL,DE
        EX	DE,HL			; adjust sectornumber
        POP	BC
        POP	HL
        DJNZ	J7D50			; next track
        CALL	C7DEA			; clear track buffer
        PUSH	HL
        EX	DE,HL
        LD	L,(IY+0)
        LD	H,(IY+1)
        LD	BC,30
        LDIR				; construct BPB
        LD	HL,I7F12
        LD	BC,00A7H
        LDIR				; copy bootloader
        POP	HL
        PUSH	HL
        INC	H
        INC	H			; to first sector of 1st FAT (sector 1)
        LD	A,(IY+2)
        LD	(HL),A			; mediadescriptor
        INC	HL
        DEC	(HL)			; 0FFH
        INC	HL
        DEC	(HL)			; 0FFH
        INC	H
        INC	H
        INC	H
        INC	H
        CP	0F9H
        JR	NZ,J7D96		; single sided, to first sector of 2nd FAT (sector 3)
        INC	H
        INC	H			; double sided, to first sector of 2nd FAT (sector 4)
J7D96:	DEC	(HL)			; 0FFH
        DEC	HL
        DEC	(HL)			; 0FFH
        DEC	HL
        LD	(HL),A			; mediadescriptor
        POP	HL
        LD	C,A			; mediadescriptor
        LD	B,9			; 9 sectors
        LD	DE,0			; sector 0
        LD	A,(IY+8)		; driveid
        PUSH	DE
        PUSH	AF
        PUSH	BC
        PUSH	HL
        SCF				; write
        CALL	C7495			; DSKIO
        JR	C,J7DDE			; error, quit
        POP	HL
        POP	BC
        POP	AF
        POP	DE
        PUSH	DE
        PUSH	AF
        PUSH	BC
        PUSH	HL
        AND	A			; read
        CALL	C7495			; DSKIO
        JR	C,J7DDE			; error, quit
        POP	HL
        CALL	C7DEA			; clear track buffer
        POP	BC
        POP	AF
        POP	DE
        LD	B,5			; 5 sectors
        LD	DE,9			; sector 9
        PUSH	DE
        PUSH	AF
        PUSH	BC
        PUSH	HL
        SCF				; write
        CALL	C7495			; DSKIO
        JR	C,J7DDE			; error, quit
        POP	HL
        POP	BC
        POP	AF
        POP	DE
        AND	A			; read
        CALL	C7495			; DSKIO
        JR	C,J7DE2			; error, quit
        RET

J7DDE:	POP	HL
        POP	BC
        POP	DE
        POP	DE
J7DE2:	CP	12
        JR	NZ,J7DE8
        LD	A,16
J7DE8:	SCF
        RET

;	  Subroutine clear track buffer
;	     Inputs  ________________________
;	     Outputs ________________________

C7DEA:	PUSH	HL
        LD	BC,9*512
J7DEE:	LD	(HL),0
        INC	HL
        DEC	BC
        LD	A,B
        OR	C
        JR	NZ,J7DEE
        POP	HL
        RET

I7DF8:	DEFW	I7E02
        DEFB	0F8H
        DEFW	02D0H

        DEFW	I7E20
        DEFB	0F9H
        DEFW	05A0H

I7E02:	DEFB	0EBH
        DEFB	0FEH
        DEFB	090H
        DEFB	"MSX_03  "
        DW	512
        DB	2
        DW	1
        DB	2
        DW	112
        DW	720
        DB	0F8H
        DW	2
        DW	9
        DW	1
        DW	0

I7E20:	DEFB	0EBH
        DEFB	0FEH
        DEFB	090H
        DEFB	"MSX_04  "
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

J7E3E:	DEFB 	04DH		; FORMAT A TRACK
        DEFB	0		; Unit, Head
        DEFB	2		; 512 bytes sector
        DEFB	9		; 9 sector on a track
        DEFB	80		; GAP3= 80 bytes
        DEFB	040H		; Filler byte

        DEFB	046H		; READ DATA, no MT, MFM
        DEFB	0		; HS, DS1, DS0
        DEFB	0		; C
        DEFB	0		; H
        DEFB	1		; R
        DEFB	2		; 512 bytes
        DEFB	9		; EOT
        DEFB	80		; GPL
        DEFB	0FFH		; DTL

;	  Subroutine __________________________
;	     Inputs  ________________________
;	     Outputs ________________________

C7E4D:	CALL	C787D			; Normal READY
        LD	A,(IY+7)
        LD	(IX+11),A
        CALL	C7708			; wait for READY from drive
        JP	C,J7EF4			; timeout,
        BIT	6,A
        JP	NZ,J7EFA
        PUSH	BC
        PUSH	IX
        POP	HL
        LD	DE,10
        ADD	HL,DE
        EX	DE,HL
        LD	HL,J7E3E
        LD	BC,6
        LDIR
        POP	BC
        LD	A,(IY+7)
        OR	B
        LD	(IX+11),A
        LD	B,6
        CALL	C792F			; start FDC command
        PUSH	IY
        POP	HL
        LD	BC,11
        ADD	HL,BC
        LD	C,9
        LD	DE,D7FFA
J7E8B:	PUSH	BC
        LD	BC,0
J7E8F:	DEC	BC
        LD	A,B
        OR	C
        JR	Z,J7EE4
        LD	A,(DE)
        ADD	A,A
        JP	NC,J7E8F
        LD	A,(HL)
        LD	(D7FFB),A
        INC	HL
        POP	BC
        LD	B,3
J7EA1:	LD	A,(DE)
        ADD	A,A
        JP	NC,J7EA1
        LD	A,(HL)
        LD	(D7FFB),A
        INC	HL
        DJNZ	J7EA1
        DEC	C
        JR	NZ,J7E8B
        CALL	C79AA			; Terminate transfer
        LD	BC,0
J7EB6:	DEC	BC
        LD	A,B
        OR	C
        JR	Z,J7EE5
        LD	A,(DE)
        AND	0C0H
        CP	0C0H
        JR	NZ,J7EB6
        CALL	C7989			; get result
J7EC5:	CALL	C7881			; Force READY
        LD	A,(IX+19)
        LD	B,A
        AND	0C0H
        RET	Z
        SCF
        BIT	3,B
        LD	A,2			; NOT READY
        RET	NZ
        BIT	4,B
        LD	A,10
        RET	NZ
        BIT	1,(IX+20)
        LD	A,0			; WRITE PROTECT
        RET	NZ
        LD	A,16
        RET

J7EE4:	POP	BC
J7EE5:	XOR	A
        CALL	C7753			; initialize FDC
        LD	A,4
        CALL	C776F			; recalibrate drive 0
        LD	(IX+19),0C8H
        JR	J7EC5

J7EF4:	CALL	C7881			; Force READY
        LD	A,2			; NOT READY
        RET

J7EFA:	CALL	C7881			; Force READY
        XOR	A			; WRITE PROTECT
        SCF
        RET

;	  Subroutine __________________________
;	     Inputs  ________________________
;	     Outputs ________________________

C7F00:	PUSH	IY
        POP	HL
        LD	DE,12
        ADD	HL,DE
        LD	B,9
J7F09:	LD	(HL),1
        INC	HL
        INC	HL
        INC	HL
        INC	HL
        DJNZ	J7F09
        RET

I7F12:
        .PHASE	0C01EH

        RET	NC
        LD	(CC058+1),DE
        LD	(DC0C4),A
        LD	(HL),LOW CC056
        INC	HL
        LD	(HL),HIGH CC056
J7F1F:	LD	SP,KBUF+256
        LD	DE,IC09F
        LD	C,0FH
        CALL	BDOS
        INC	A
        JP	Z,JC063
        LD	DE,00100H
        LD	C,1AH
        CALL	BDOS
        LD	HL,1
        LD	(IC09F+14),HL
        LD	HL,04000H-00100H
        LD	DE,IC09F
        LD	C,27H
        CALL	BDOS
        JP	00100H

CC056:	DEFW	CC058

CC058:	CALL	0
        LD	A,C
        AND	0FEH
        CP	02H
        JP	NZ,JC06A
JC063:	LD	A,(DC0C4)
        AND	A
        JP	Z,DSKBAS
JC06A:	LD	DE,IC079
        LD	C,09H
        CALL	BDOS
        LD	C,07H
        CALL	BDOS
        JR	J7F1F

IC079:	DEFB	"Boot error",13,10
        DEFB	"Press any key for retry",13,10
        DEFB	"$"

IC09F:	DEFB	0
        DEFB	"MSXDOS  "
        DEFB	"SYS"
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

D7FF8	EQU	07FF8H		; DOR, b0 = 0 drive 0, 1 drive 1
                                ;      b1 = not used
                                ;      b2 = 0 reset FDC, 1 enable FDC
                                ;      b3 = 0 disable INTRQ and DRQ2 pins, 1 enable INTRQ and DRQ2 pins
                                ;      b4 = 1 motor select drive 0
                                ;      b5 = 1 motor select drive 1
                                ;      b6 = not used
                                ;      b7 = not used
D7FF9	EQU	07FF9H		; TDR, b0 = Terminate Count
                                ;      b1 = enable TC
                                ;      b2 = Standby Mode
                                ;      b3 = enable SB
                                ;      b4 = C4 output (force READY high)
                                ;      b5 = enable C4
                                ;      b4 = C6 output (not connected)
                                ;      b5 = enable C6
D7FFA	EQU	07FFAH		; MSR, Statusport FDC
D7FFB	EQU	07FFBH		; DAT, Dataport FDC

DBFF9	EQU	D7FF9+04000H
DBFFA	EQU	D7FFA+04000H
DBFFB	EQU	D7FFB+04000H

