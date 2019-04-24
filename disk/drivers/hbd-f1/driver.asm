; Diskdriver 2.05 Sony HBD-F1 (external floppydisk controller)
; Diskdriver 2.05 Sony HB-F500P,Sony HB-F700P,Sony HB-F900P
; Diskdriver 2.06 Sony HB-F1XDJ
; Diskdriver 2.07 Sony HB-F1XV
;
; FDC	WD2793
; extra	SONY hardware (CXD1032Q) for Disk Change

; Source re-created by Z80DIS 2.2
; Z80DIS was written by Kenneth Gielow, Palo Alto, CA

; Code Copyrighted by Panasonic and maybe others
; Source comments by Arjen Zeilemaker

; Sourcecode supplied for STUDY ONLY
; Recreation NOT permitted without authorisation of the copyrightholders

MYSIZE		equ	9
SECLEN		equ	512

; driver version
; 205,206 or 207

DRVVER		equ	205

;
I7405:
                .PHASE	0C000H

                db	0EBh,0FEh	; JMP 0100h (i8088)
                db	090h		; NOP (i8088)

                db	"SNYJX"

                IF	DRVVER EQ 205
                db	"205"
                ENDIF
                IF	DRVVER EQ 206
                db	"206"
                ENDIF
                IF	DRVVER EQ 207
                db	"207"
                ENDIF

                dw	512
                db	2
                dw	1
                db	2
                dw	112
                dw	05A0H
                db	0F9H
                dw	3
                dw	9
                dw	2
                dw	0

BootTrap:	ret	nc
                ld	(SetRomPage+1),de
                ld	(StartFlag),a
                ld	(hl),LOW ErrorHand
                inc	hl
                ld	(hl),HIGH ErrorHand
BootAgain:	ld	sp,0F51Fh
                ld	de,MsxDosFcb
                ld	c,0Fh
                call	0F37Dh
                inc	a
                jp	z,OpenDosError
                ld	de,0100h
                ld	c,01Ah
                call	0F37Dh
                ld	hl,1
                ld	(MsxDosFcb+0Eh),hl
                ld	hl,04000h-0100h
                ld	de,MsxDosFcb
                ld	c,027h
                call	0F37Dh
                jp	0100h

ErrorHand:	dw	SetRomPage

SetRomPage:	call	0
                ld	a,c
                and	0FEh
                cp	02h
                jp	nz,DiskBootError
OpenDosError:	ld	a,(StartFlag)
                and	a			; Startup ?
                jp	z,04022h		; yep, jump direct
DiskBootError:	ld	de,BootErrorTxt
                call	PrintMessage
                ld	c,07h
                call	0F37Dh
                jr	BootAgain		; nop, boot again

PrintMessage:	ld	a,(de)
                or	a
                ret	z
                push	de
                ld	e,a
                ld	c,6
                call	0F37DH
                pop	de
                inc	de
                jr	PrintMessage

BootErrorTxt:	db	"Boot error",13,10
                db	"Press any key for retry",13,10
                db	0

MsxDosFcb:	db	0
                db	"MSXDOS  SYS"
                dw 	0
                dw	0
                db	0,0,0,0
                dw	0
                dw	0
                db	0
                db	0
                dw	0
                dw	0
                dw	0
                db	0
                db	0,0,0,0

StartFlag:	db	0

                .DEPHASE

I74D6:

; Only supports 3.5 media

                db	0F8h		; Media F8
                dw	512		; 80 Tracks
                db	0Fh		; 9 sectors
                db	04h		; 1 side
                db	01h		; 3.5" 360 Kb
                db	02h
                dw	1
                db	2
                db	112
                dw	12
                dw	355
                db	2
                dw	5

DEFDPB	EQU	$-1

		db	0F9h		; Media F9
                dw	512		; 80 Tracks
                db	0Fh		; 9 sectors
                db	04h		; 2 sides
                db	01h		; 3.5" 720 Kb
                db	02h
                dw	1
                db	2
                db	112
                dw	14
                dw	714
                db	3
                dw	7

                db	0FAh		; Media FA
                dw	512		; 80 Tracks
                db	0Fh		; 8 sectors
                db	04h		; 1 side
                db	01h		; 3.5" 320 Kb
                db	02h
                dw	1
                db	2
                db	112
                dw	10
                dw	316
                db	1
                dw	3

                db	0FBh		; Media FB
                dw	512		; 80 Tracks
                db	0Fh		; 8 sectors
                db	04h		; 2 sides
                db	01h		; 3.5" 640 Kb
                db	02h
                dw	1
                db	2
                db	112
                dw	10
                dw	635
                db	2
                dw	5


;	  Subroutine DSKIO
;	     Inputs  ________________________
;	     Outputs ________________________

DSKIO:
C751E:	PUSH	AF
        JP	NC,J75D2		; read operation
        CALL	C7691			; validate and select drive and track
        JP	C,J7811			; error, reset controller and stop motor drive(s) and quit
        CALL	DISINT			; accounce interrupts are disabled
        DI
J752C:	LD	A,H
        AND	A			; transfer from 8000H-FFFFH ?
        JP	M,J755F			; yep, direct sector transfer
        CP	3EH			; transfer from 0000H-3DFFH ?
        JP	C,J755F			; yep, direct sector transfer
        PUSH	HL
        PUSH	DE
        PUSH	BC
        LD	DE,(_SECBUF)
        PUSH	DE
        LD	BC,512
        CALL	XFER			; first transfer to SECBUF
        POP	HL
        POP	BC
        POP	DE
        CALL	C756F			; write sector
        POP	HL
        JP	C,J7558			; error, finish
        DEC	B
        JP	Z,J7558			; done, finish
        CALL	C7793			; setup for next sector
        JP	J752C			; next sector

J7558:	EI
        CALL	ENAINT			; annouce interrupts are enabled
        JP	J7811			; reset controller and stop motor drive(s) and quit

J755F:	CALL	C756F			; write sector
        JP	C,J7558			; error, finish
        DEC	B
        JP	Z,J7558			; done, finish
        CALL	C7793			; setup for next sector
        JP	J752C			; next sector

;	  Subroutine write sector
;	     Inputs  ________________________
;	     Outputs ________________________

C756F:	LD	E,10
J7571:	CALL	C77F5			; wait for command ready
        LD	A,0A0H			; write sector command
        BIT	6,D			; double sided ?
        JP	Z,J7584			; nope,
        OR	02H			; enable side compare
        BIT	0,D			; side 0 ?
        JP	Z,J7584			; yep, compare for side 0
        OR	08H			; nope, compare for side 1
J7584:	PUSH	HL
        PUSH	DE
        PUSH	BC
        LD	DE,I75A2
        PUSH	DE
        LD	(D7FF8),A		; start command
        EX	(SP),HL
        EX	(SP),HL			; wait
        LD	BC,D7FFF
        LD	DE,D7FFB
J7596:	LD	A,(BC)
        ADD	A,A
        RET	P			; IRQ (end of command), quit
        JP	C,J7596			; wait for DRQ
        LD	A,(HL)
        LD	(DE),A
        INC	HL
        JP	J7596

I75A2:	POP	BC
        POP	DE
        POP	HL
        LD	A,(D7FF8)
        AND	0DCH			; ignore record type,DRQ and busy flags
        RET	Z			; no error, quit
        JP	M,J75CB			; not ready, return NOT READY error
        BIT	6,A
        JP	NZ,J75CF		; write protect, return WRITE PROTECT error
        PUSH	AF
        CALL	C77D8			; repostion every 2 times
        POP	AF
        DEC	E
        JP	NZ,J7571		; next try
        SCF
        LD	E,A
        BIT	4,E
        LD	A,8
        RET	NZ			; record not found, return RECORD NOT FOUND error
        BIT	3,E
        LD	A,4
        RET	NZ			; CRC, return CRC error
        LD	A,12			; Lost data, return OTHER error
        RET

J75CB:	LD	A,2
        SCF
        RET

J75CF:	XOR	A
        SCF
        RET

;	  Subroutine DSKIO read
;	     Inputs  ________________________
;	     Outputs ________________________

J75D2:	CALL	C7691			; validate and select drive and track
        JP	C,J7811			; error, reset controller and stop motor drive(s) and quit
        CALL	DISINT			; annouce interrupts are disabled
        DI
J75DC:	LD	A,H
        AND	A
        JP	M,J7612			; transfer to 8000H-FFFFH, direct sector read
        CP	3EH
        JP	C,J7612			; transfer to 0000H-3DFFH, direct sector read
        PUSH	HL
        LD	HL,(_SECBUF)
        CALL	C7622			; read sector in SECBUF
        POP	HL
        JP	C,J760B			; error, finish
        PUSH	HL
        PUSH	DE
        PUSH	BC
        EX	DE,HL
        LD	HL,(_SECBUF)
        LD	BC,512
        CALL	XFER			; transfer from SECBUF
        POP	BC
        POP	DE
        POP	HL
        DEC	B
        JP	Z,J760B			; all done, finish
        CALL	C7793			; setup for next sector
        JP	J75DC			; next sector

J760B:	EI
        CALL	ENAINT			; annouce interrupts are enabled
        JP	J7811			; reset controller and stop motor drive(s)

J7612:	CALL	C7622			; read sector
        JP	C,J760B			; error, finish
        DEC	B
        JP	Z,J760B			; all done, finish
        CALL	C7793			; setup for next sector
        JP	J75DC			; next sector

;	  Subroutine read sector
;	     Inputs  ________________________
;	     Outputs ________________________

C7622:	LD	E,10
J7624:	CALL	C77F5			; wait for command ready
        LD	A,80H			; read sector command
        BIT	6,D			; double sided ?
        JP	Z,J7637
        OR	02H			; yep, enable side compare
        BIT	0,D			; side 0 ?
        JP	Z,J7637			; yep, compare for side 0
        OR	08H			; nope, compare for side 1
J7637:	PUSH	HL
        PUSH	DE
        PUSH	BC
        LD	BC,D7FFF
        LD	DE,I7669
        PUSH	DE
        LD	(D7FF8),A		; execute command
        EX	(SP),HL
        EX	(SP),HL			; wait
        LD	DE,0			; 65536
J7649:	LD	A,(BC)
        ADD	A,A
        JP	NC,J7657		; DRQ, let�s go
        RET	P			; IRQ (end of command), quit
        DEC	E
        JP	NZ,J7649
        DEC	D
        JP	NZ,J7649		; wait
J7657:	LD	DE,D7FFB
        JP	J7663			; start reading

J765D:	LD	A,(BC)
        ADD	A,A
        RET	P
        JP	C,J765D
J7663:	LD	A,(DE)
        LD	(HL),A
        INC	HL
        JP	J765D

I7669:	POP	BC
        POP	DE
        POP	HL
        LD	A,(D7FF8)
        AND	9CH			; ignore write protect,record type,DRQ and busy flags
        RET	Z			; no errors, quit
        JP	M,J768D			; not ready, return NOT READY error
        PUSH	AF
        CALL	C77D8			; repostion every 2 times
        POP	AF
        DEC	E
        JP	NZ,J7624		; next try
        SCF
        LD	E,A
        BIT	4,E
        LD	A,8
        RET	NZ			; record not found, return RECORD NOT FOUND error
        BIT	3,E
        LD	A,4
        RET	NZ			; CRC, return CRC error
        LD	A,12			; Lost data, return OTHER error
        RET

J768D:	LD	A,2
        SCF
        RET

;	  Subroutine validate and select drive and track
;	     Inputs  ________________________
;	     Outputs ________________________

C7691:	PUSH	AF
        PUSH	BC
        PUSH	HL
        CALL	GETWRK
        POP	HL
        POP	BC
        POP	AF
        CP	2			; driveid valid ?
        JP	C,J76A4
J769F:	POP	AF
        LD	A,12
        SCF				; nope, return OTHER ERROR
        RET

J76A4:	PUSH	AF
        LD	A,C
        CP	0F8H			; mediadescriptor F8-FF ?
        JP	C,J769F			; nope, return OTHER ERROR
        CP	0FCH			; mediadescriptor F8-FB ?
        JP	NC,J769F		; nope, return OTHER ERROR
        EX	(SP),HL
        PUSH	HL
        PUSH	BC
        XOR	A
        BIT	0,C			; double sided media (F8,FA) ?
        JP	NZ,J76BD		; yep,
        LD	(D7FFC),A		; select side 0
        INC	A
J76BD:	DEC	A
        PUSH	AF
        CALL	C77F5			; wait for command ready
        BIT	1,C			; 8 sectors per track media (FA,FB) ?
        LD	C,E
        LD	B,D			; sector
        LD	DE,8
        JP	NZ,J76CD		; yep, 8 sectors per track
        INC	DE			; nope, 9 sectors per track
J76CD:	CALL	DIV16			; calculate track and sector on track
        LD	A,L
        INC	A			; make 1 based
        LD	(D7FFA),A		; set sector register
        POP	AF
        AND	A			; single sided media ?
        JP	Z,J76E8			; yep, side 0 already selected
        XOR	A
        LD	(D7FFC),A		; select side 0
        SRL	C			; doube sided, track/2
        JP	NC,J76E8		; track on side 0, ok
        LD	A,1
        LD	(D7FFC),A		; select side 1
J76E8:	LD	L,C
        POP	BC
        POP	AF
        LD	H,A
        LD	A,(IX+8)
        DEC	A			; 1 physical drive ?
        JP	Z,J76F4			; yep, use physical drive 0
        LD	A,H			; use specified physical drive
J76F4:	OR	0FCH
        CALL	DISINT			; annouce interrupts are disabled
        DI
        LD	(D7FFD),A		; select drive, motor on, in use, leave disk change
        LD	DE,0			; 65536
J7700:	LD	A,(D7FF8)
        AND	80H			; drive reports READY ?
        JP	Z,J770E			; yep, go!
        DEC	DE
        LD	A,D
        OR	E			; default wait time passed ? (for drives without a READY signal)
        JP	NZ,J7700		; nope, wait longer
J770E:	EI
        CALL	ENAINT			; annouce interrupts are enabled
        LD	A,C
        RRCA
        RRCA
        AND	0C0H			; media in b7 and b6
        LD	D,A
        LD	A,(D7FFC)
        AND	01H			; current side
        OR	D
        LD	D,A			; side in b0
        LD	C,L
        LD	A,(IX+8)
        DEC	A			; 1 physical drive ?
        JP	Z,J7750			; yep, may be prompt for disk
        LD	A,(IX+3)
        CP	H			; same drive as last operation ?
        JP	Z,J778A			; yep, track register contains current track of drive
        XOR	01H
        LD	(IX+3),A		; change last operation drive
        LD	A,(D7FF9)		; current track
        JP	Z,J7742			; new drive is drive 0, save current track drive 1
        LD	(IX+4),A		; new drive is drive 1, save current track drive 0
        LD	A,(IX+5)
        JP	J7748			; set track register to saved track drive 1

J7742:	LD	(IX+5),A		; save current track drive 1
        LD	A,(IX+4)
J7748:	LD	(D7FF9),A		; set track register
        EX	(SP),HL
        EX	(SP),HL			; wait
        JP	J778D			; select track

J7750:	LD	A,H
        CP	(IX+6)			; same logical drive as last operation ?
        LD	(IX+6),A
        JP	Z,J778A			; yep, skip change disk
        PUSH	IX
        PUSH	DE
        PUSH	BC
        LD	A,(D7FFD)
        PUSH	AF
        AND	3FH
        LD	(D7FFD),A		; motor off, not in use, reset disk change
        OR	03H
        LD	(D7FFD),A		; deselect drive, reset disk change
        CALL	PROMPT
        POP	AF
        LD	(D7FFD),A		; motor on, in use, select drive, reset disk change
        PUSH	HL
        LD	HL,0			; 65536
J7777:	LD	A,(D7FF8)
        AND	80H			; drive reports READY ?
        JP	Z,J7785			; yep, go
        DEC	HL
        LD	A,H
        OR	L			; default wait time passed ? (for drives without a READY signal)
        JP	NZ,J7777		; nope, wait
J7785:	POP	HL
        POP	BC
        POP	DE
        POP	IX
J778A:	LD	A,(D7FF9)		; current track
J778D:	CP	C			; same as requested ?
        CALL	NZ,C77DE		; nope, select track
        POP	HL
        RET

;	  Subroutine setup for next sector
;	     Inputs  ________________________
;	     Outputs ________________________

C7793:	CALL	C77F5			; wait for command ready
        INC	H
        INC	H			; update transferaddress (512 bytes sectors are assumed)
        LD	A,(D7FFA)
        INC	A
        LD	(D7FFA),A		; increase sector
        BIT	7,D			; 8 sectors per track ?
        JP	NZ,J77A7		; yep, check if end of track
        CP	9+1
        RET	C			; not end of track, quit
J77A7:	CP	8+1
        RET	C			; not end of track, quit
        LD	A,1
        LD	(D7FFA),A		; sector 1
        BIT	6,D			; single sided ?
        JP	Z,C77C0			; yep, select next track
        BIT	0,D			; double sided and and on side 1 ?
        JP	NZ,C77C0		; yep, select next track
        SET	0,D			; now on side 1
        LD	A,D
        LD	(D7FFC),A		; select side 1
        RET

;	  Subroutine select next track
;	     Inputs  ________________________
;	     Outputs ________________________

C77C0:	RES	0,D			; side 0
        LD	A,D
        LD	(D7FFC),A		; select side 0
        INC	C
        CALL	C77F5			; wait for command ready
        LD	A,50H
        LD	(D7FF8),A		; STEP IN
        EX	(SP),HL
        EX	(SP),HL
        CALL	C77F5			; wait for command ready
        CALL	C7805			; wait for head to settle
        RET

;	  Subroutine repostion every 2 times
;	     Inputs  ________________________
;	     Outputs ________________________

C77D8:	BIT	0,E
        RET	NZ
        CALL	C77FD			; select track 0

;	  Subroutine select track
;	     Inputs  C = track
;	     Outputs ________________________

C77DE:	LD	A,C
        LD	(D7FFB),A		; set data register with track
        EX	(SP),HL
        EX	(SP),HL			; wait
        CALL	C77F5			; wait for command ready
        LD	A,10H			; SEEK command
J77E9:	LD	(D7FF8),A		; execute track command
        EX	(SP),HL
        EX	(SP),HL			; wait
        CALL	C77F5			; wait for command ready
        CALL	C7805			; wait for head to settle
        RET

;	  Subroutine wait for command ready
;	     Inputs  ________________________
;	     Outputs ________________________

C77F5:	LD	A,(D7FF8)
        RRA
        JP	C,C77F5
        RET

;	  Subroutine select track 0
;	     Inputs  ________________________
;	     Outputs ________________________

C77FD:	CALL	C77F5			; wait for command ready
        LD	A,0			; RESTORE command
        JP	J77E9			; execute track command

;	  Subroutine wait for head to settle
;	     Inputs  ________________________
;	     Outputs ________________________

C7805:	PUSH	HL
        LD	HL,1987
J7809:	DEC	HL
        LD	A,H
        OR	L
        JP	NZ,J7809
        POP	HL
        RET

;	  Subroutine reset controller and stop motor drive(s)
;	     Inputs  ________________________
;	     Outputs ________________________

J7811:	POP	DE
        PUSH	AF
        LD	A,0D0H
        LD	(D7FF8),A		; execute terminate without interrupt command
        EX	(SP),HL
        EX	(SP),HL
        EX	(SP),HL
        EX	(SP),HL			; wait
        LD	A,(D7FFB)		; read data register (reset DRQ)
        LD	A,(D7FF8)		; read status register (reset INT)
        CALL	C7DE2			; deselect drive, motor off, not in use
        POP	AF
        RET

INIHRD:
        LD	A,0D0H
        LD	(D7FF8),A		; execute terminate without interrupt command
        EX	(SP),HL
        EX	(SP),HL
        EX	(SP),HL
        EX	(SP),HL			; wait
        LD	A,3CH			; motor off, not in use, leave disk change, select drive 0
        CALL	C7840
        LD	A,3DH			; motor off, not in use, leave disk change, select drive 1
        CALL	C7840
        LD	A,3FH
        LD	(D7FFD),A		; motor off, not in use, leave disk change, deselect drive
        RET

;	  Subroutine reset drive
;	     Inputs  A = drive select
;	     Outputs ________________________

C7840:	LD	(D7FFD),A		; select drive
J7843:	CALL	C77C0			; select next track
        LD	A,(D7FF8)
        AND	04H			; still on track 0 ?
        JP	NZ,J7843		; yep, try again
        CALL	C77F5			; wait for command ready
        LD	A,0
        LD	(D7FF8),A		; RESTORE command
        EX	(SP),HL
        EX	(SP),HL			; wait
        LD	HL,0			; 65536
J785B:	LD	A,(D7FF8)
        RRA
        RET	NC			; ready, quit
        DEC	HL
        LD	A,L
        OR	H
        JP	NZ,J785B		; wait
        RET


DRIVES:
        PUSH	BC
        PUSH	AF
        CALL	GETWRK
        LD	A,3DH
        LD	(D7FFD),A		; motor off, not in use, leave disk change, select drive 1
        CALL	C77F5			; wait for command ready
        LD	A,0
        LD	(D7FF8),A		; RESTORE command
        EX	(SP),HL
        EX	(SP),HL			; wait
        LD	HL,0			; 65536
J787E:	LD	A,(D7FF8)
        RRA
        JP	NC,J788D		; command ready, drive 1 found -> 2 physical drives
        DEC	HL
        LD	A,L
        OR	H
        JP	NZ,J787E		; wait
        INC	L			; 1 physical drive
        DEFB	0CAH
J788D:	LD	L,2
        LD	A,3FH
        LD	(D7FFD),A		; motor off, not in use, leave disk change, deselect drive
        POP	AF
        JP	Z,J78A0			; SHIFT pressed, 1 physical drive and return 1 drive
        LD	(IX+8),L		; number of physical drives
        LD	L,2			; return 2 drives
        JP	J78A5

J78A0:	LD	L,1
        LD	(IX+8),L		; 1 physical drive
J78A5:	POP	BC
        RET


INIENV:
        CALL	GETWRK
        XOR	A
        LD	B,8
J78AD:	LD	(HL),A
        INC	HL
        DJNZ	J78AD			; clear workarea driver
        LD	HL,I78B7
        JP	SETINT			; setup interrupt handler driver

;	  Subroutine interrupt handler driver
;	     Inputs
;	     Outputs ________________________

I78B7:	JP	PRVINT			; continue with interrupt handlers of other drivers

DSKCHG:
        PUSH	HL
        PUSH	BC
        PUSH	AF
        CALL	GETWRK
        POP	AF
        POP	BC
        POP	HL
        LD	D,A
        PUSH	DE
        AND	A
        JP	NZ,J78E0		; drive 0
        LD	A,(D7FFD)
        LD	B,A
        PUSH	BC
        AND	0FCH
        LD	(D7FFD),A		; select drive 0, leave disk change
        LD	A,(D7FFD)
        BIT	2,A			; disk changed ?
        POP	BC
        LD	A,B
        LD	(D7FFD),A		; restore, reset disk change
        JP	J78F6

J78E0:	LD	A,(D7FFD)
        LD	B,A
        PUSH	BC
        AND	0FCH
        OR	01H
        LD	(D7FFD),A		; select drive 1, leave disk change
        LD	A,(D7FFD)
        BIT	2,A			; disk changed ?
        POP	BC
        LD	A,B
        LD	(D7FFD),A		; restore, reset disk change
J78F6:	POP	DE
        LD	A,D
        LD	B,1
        RET	NZ			; disk not changed, return DISK UNCHANGED
        PUSH	BC
        PUSH	HL
        PUSH	AF
        XOR	A
        LD	(D7FFC),A		; select side 0
        POP	AF			; driveid
        PUSH	AF
        LD	DE,1
        LD	HL,(_SECBUF)
        SCF
        CCF
        CALL	C751E			; read sector 1
        JP	C,J793F			; error, quit with error
        LD	HL,(_SECBUF)
        LD	B,(HL)			; mediadescriptor
        LD	A,B
        CP	0F8H			; mediadescriptor F8-FF ?
        JP	C,J7938			; nope, return WRITE FAULT error
        CP	0FCH			; mediadescriptor F8-FB ?
        JP	NC,J7938		; nope, return WRITE FAULT error
        POP	AF
        POP	HL
        PUSH	BC
        CALL	C7943			; GETDPB
        PUSH	DE
        LD	A,12
        JP	C,J793F			; error, return with OTHER ERROR
        POP	DE
        POP	AF
        POP	BC
        CP	C			; mediadescriptor changed ?
        SCF
        CCF				; reset Cx
        LD	B,0FFH
        RET	NZ			; yep, return DISK CHANGED
        INC	B			; nope, return DISK CHANGE UNKNOWN
        RET

J7938:	POP	DE
        POP	DE
        POP	DE
        LD	A,10
        SCF
        RET

J793F:	POP	DE
        POP	DE
        POP	DE
        RET

;	  Subroutine __________________________
;	     Inputs  ________________________
;	     Outputs ________________________

GETDPB:
C7943:	EX	DE,HL
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
        LD	BC,I74D6
        ADD	HL,BC
        LD	BC,18
        LDIR
        RET

CHOICE:
        LD	HL,I7961
        RET

I7961:	DEFB	13,10
        DEFB	"1 - Single sided, 9 sectors",13,10
        DEFB	"2 - Double sided, 9 sectors",13,10
        DEFB	13,10
        DEFB	0


DSKFMT:
        CP	1
        JP	Z,J79AE
        CP	2
        JP	Z,J7A8A
        SCF
        LD	A,12
        RET

;	  Subroutine disk format single sided
;	     Inputs  ________________________
;	     Outputs ________________________

J79AE:	PUSH	DE
J79AF:	LD	C,0F8H
        CALL	C7B56			; validate drive, quit if invalid
        POP	DE
        PUSH	DE
        CALL	C7B62			; select track 0 of drive
        CALL	C7B95			; track 0, side 0
        CALL	DISINT			; annouce interrupts are disabled
        DI
J79C0:	CALL	C7C0F			; format track
        CALL	C7BB2			; next track
        CP	80			; done all 80 tracks ?
        JP	Z,J79D1			; yep, write special sectors
        CALL	C7BC0			; select next track
        JP	J79C0			; next

J79D1:	EI
        CALL	ENAINT			; annouce interrupts are enabled
        POP	DE
        PUSH	DE
        CALL	C7B62			; select track 0 of drive
        CALL	C7BD4			; setup BPB and bootloader
        LD	B,2FH
        XOR	A
        CALL	C7BE1			; clear remainer of bootloader
        CALL	C7BE1			; clear remainer of sector (256 bytes)
        LD	HL,19
        LD	DE,(_SECBUF)
        ADD	HL,DE
        EX	DE,HL
        LD	HL,I7A81
        LD	BC,9
        LDIR				; change BPB for single sided media
        POP	DE
        LD	A,D
        PUSH	AF
        LD	C,0F8H			; single sided, 9 sectors per track
        LD	DE,0			; sector 0 (bootsector)
J79FF:	CALL	C7BF2			; write sector from SECBUF
        JP	C,J7C08			; error, quit with error
        LD	DE,(_SECBUF)
        LD	B,0
        XOR	A
        CALL	C7BE1			; clear 256 bytes (was bootloader)
        LD	DE,1			; 1st FAT sector
        PUSH	DE
J7A13:	POP	DE
        POP	AF
        PUSH	AF
        PUSH	DE
        LD	C,0F8H
        CALL	C7BF2			; write sector from SECBUF
        JP	C,J7C07			; error, quit with error
        POP	DE
        INC	E
        PUSH	DE
        LD	A,E
        CP	12			; done all FAT sectors ?
        JP	NZ,J7A13		; nope, next
        POP	DE
        POP	AF
        PUSH	AF
        LD	D,A
        CALL	C7B62			; select track 0 of drive
        LD	A,0F8H
        CALL	C7BE6			; make special FAT entries 0 and 1
        POP	AF
        PUSH	AF
        LD	C,0F8H
        LD	DE,1			; 1st sector of 1st FAT
        CALL	C7BF2			; write sector from SECBUF
        JP	C,J7C08			; error, quit with error
        POP	AF
        PUSH	AF
        LD	C,0F8H
        LD	DE,3			; 1st sector of 2nd FAT
        CALL	C7BF2			; write sector from SECBUF
        JP	C,J7C08			; error, quit with error
        POP	AF
        PUSH	AF
        LD	D,A
        CALL	C7B62			; select track 0 of drive
        LD	DE,0			; sector 0
        PUSH	DE
J7A58:	POP	DE
        POP	AF
        PUSH	AF
        PUSH	DE
        LD	C,0F8H
        CALL	C7BFC			; read sector to SECBUF
        POP	DE
        JP	C,J7811			; error, reset controller and stop motor drive(s) and quit
        LD	HL,8
        ADD	HL,DE
        EX	DE,HL			; skip next 7 sectors (for speed)
        PUSH	DE
        LD	A,D
        CP	HIGH 002C8H
        JP	NZ,J7A58
        LD	A,E
        CP	LOW 002C8H
        JP	NZ,J7A58
        POP	DE
        POP	AF
        PUSH	AF
        LD	D,A
        CALL	C7B62			; select track 0 of drive
        JP	J7811			; reset controller and stop motor drive(s) and quit

I7A81:
        DEFW	720
        DEFB	0F8H
        DEFW	2
        DEFW	9
        DEFW	1

;	  Subroutine format disk double sided
;	     Inputs  ________________________
;	     Outputs ________________________

J7A8A:	PUSH	DE
        LD	C,0F9H
        CALL	C7B56			; validate drive, quit if invalid
        POP	DE
        PUSH	DE
        CALL	C7B62			; select track 0 of drive
        CALL	C7B95			; track 0, side 0
        CALL	DISINT
        DI
J7A9C:	CALL	C7C0F			; format track
        CALL	C7BA0			; toggle side
        AND	A			; now side 1 ?
        JP	NZ,J7A9C		; yep, format side 1
        CALL	C7BB2			; next track
        CP	80
        JP	Z,J7AB4
        CALL	C7BC0			; select next track
        JP	J7A9C			; next

J7AB4:	EI
        CALL	ENAINT
        POP	DE
        PUSH	DE
        CALL	C7B62			; select track 0 of drive
        CALL	C7BD4			; setup BPB and bootloader
        LD	B,2FH
        XOR	A
        CALL	C7BE1			; clear remainer
        CALL	C7BE1			; clear 256 bytes
        POP	DE
        LD	A,D
        PUSH	AF
        LD	C,0F9H
        LD	DE,0
        CALL	C7BF2			; write sector from SECBUF
        JP	C,J7C08
        LD	DE,(_SECBUF)
        LD	B,00H
        XOR	A
        CALL	C7BE1			; clear 256 bytes
        LD	DE,1
        PUSH	DE
J7AE5:	POP	DE
        POP	AF
        PUSH	AF
        PUSH	DE
        LD	C,0F9H
        CALL	C7BF2			; write sector from SECBUF
        JP	C,J7C07
        POP	DE
        INC	E
        PUSH	DE
        LD	A,E
        CP	0EH
        JP	NZ,J7AE5
        CALL	C7BAD
        POP	DE
        POP	AF
        PUSH	AF
        LD	D,A
        CALL	C7B62			; select track 0 of drive
        LD	A,0F9H
        CALL	C7BE6
        POP	AF
        PUSH	AF
        LD	C,0F9H
        LD	DE,1
        CALL	C7BF2			; write sector from SECBUF
        JP	C,J7C08
        POP	AF
        PUSH	AF
        LD	C,0F9H
        LD	DE,4
        CALL	C7BF2			; write sector from SECBUF
        JP	C,J7C08
        POP	AF
        PUSH	AF
        LD	D,A
        CALL	C7B62			; select track 0 of drive
        LD	DE,0
        PUSH	DE
J7B2D:	POP	DE
        POP	AF
        PUSH	AF
        PUSH	DE
        LD	C,0F9H
        CALL	C7BFC			; read sector to SECBUF
        POP	DE
        JP	C,J7811			; reset controller and stop motor drive(s) and quit
        LD	HL,8
        ADD	HL,DE
        EX	DE,HL
        PUSH	DE
        LD	A,D
        CP	05H	; 5
        JP	NZ,J7B2D
        LD	A,E
        CP	98H
        JP	NZ,J7B2D
        POP	DE
        POP	AF
        PUSH	AF
        LD	D,A
        CALL	C7B62			; select track 0 of drive
        JP	J7811			; reset controller and stop motor drive(s) and quit

;	  Subroutine validate drive, quit if invalid
;	     Inputs  ________________________
;	     Outputs ________________________

C7B56:	LD	A,D
        LD	B,0
        CALL	C7691			; validate and select drive and track
        RET	NC			; no error, quit
        LD	A,16
        JP	J7C07

;	  Subroutine select track 0 of drive
;	     Inputs  ________________________
;	     Outputs ________________________

C7B62:	CALL	GETWRK
        LD	A,(IX+8)
        DEC	A			; 1 physical drive ?
        JP	Z,J7B71			; yep, always use drive 0
        LD	A,D
        AND	A			; drive 1 ?
        JP	NZ,J7B82		; yep, use drive 1
J7B71:	LD	A,(D7FFD)
        PUSH	AF
        AND	0FCH
        LD	(D7FFD),A		; select drive 0, reset disk change
        CALL	C77FD			; select track 0
        POP	AF
        LD	(D7FFD),A		; restore, reset disk change
        RET

J7B82:	LD	A,(D7FFD)
        PUSH	AF
        AND	0FCH
        OR	01H
        LD	(D7FFD),A		; select drive 1, reset disk change
        CALL	C77FD			; select track 0
        POP	AF
        LD	(D7FFD),A		; restore, reset disk change
        RET

;	  Subroutine __________________________
;	     Inputs  ________________________
;	     Outputs ________________________

C7B95:	CALL	GETWRK
        XOR	A
        LD	(IX+7),A		; track 0
        LD	(D7FFC),A		; select side 0
        RET
;
;	-----------------
;
;	  Subroutine __________________________
;	     Inputs  ________________________
;	     Outputs ________________________
;
C7BA0:	LD	A,(D7FFC)
        RRA				; current side = 1 ?
        JP	C,C7BAD			; yep, select side 0
        LD	A,1
        LD	(D7FFC),A		; select side 1
        RET

;	  Subroutine __________________________
;	     Inputs  ________________________
;	     Outputs ________________________

C7BAD:	XOR	A
        LD	(D7FFC),A		; select side 0
        RET

;	  Subroutine __________________________
;	     Inputs  ________________________
;	     Outputs ________________________

C7BB2:	LD	A,0E0H
J7BB4:	DEC	A
        JP	NZ,J7BB4		; wait
        LD	A,(IX+7)
        INC	A
        LD	(IX+7),A		; increase track
        RET

;	  Subroutine __________________________
;	     Inputs  ________________________
;	     Outputs ________________________

C7BC0:	CALL	C77C0			; select next track
        LD	A,(D7FF8)
        AND	90H
        RET	Z
        SCF
        LD	A,02H	; 2
        JP	M,J7C07
        LD	A,06H	; 6
        JP	J7C07
;
;	-----------------
;
;	  Subroutine __________________________
;	     Inputs  ________________________
;	     Outputs ________________________
;
C7BD4:	LD	HL,I7405
        LD	DE,(_SECBUF)
        LD	BC,I74D6-I7405
        LDIR
        RET

;	  Subroutine __________________________
;	     Inputs  ________________________
;	     Outputs ________________________

C7BE1:	LD	(DE),A
        INC	DE
        DJNZ	C7BE1
        RET

;	  Subroutine __________________________
;	     Inputs  ________________________
;	     Outputs ________________________

C7BE6:	LD	DE,(_SECBUF)
        LD	(DE),A
        INC	DE
        LD	A,0FFH
        LD	(DE),A
        INC	DE
        LD	(DE),A
        RET

;	  Subroutine write sector from SECBUF
;	     Inputs  ________________________
;	     Outputs ________________________

C7BF2:	LD	B,1
        LD	HL,(_SECBUF)
        SCF
        CALL	C751E
        RET

;	  Subroutine read sector to SECBUF
;	     Inputs  ________________________
;	     Outputs ________________________

C7BFC:	LD	B,1
        LD	HL,(_SECBUF)
        SCF
        CCF
        CALL	C751E
        RET

J7C07:	POP	DE
J7C08:	EI
        CALL	ENAINT
        JP	J7811		; reset controller and stop motor drive(s) and quit

;	  Subroutine __________________________
;	     Inputs  ________________________
;	     Outputs ________________________

C7C0F:	CALL	C77F5			; wait for command ready
        LD	A,0F4H
        LD	D,01H	; 1
        LD	HL,I7DC7
        PUSH	HL
        LD	(D7FF8),A
        EX	(SP),HL
        EX	(SP),HL
        LD	C,4EH	; "N"
        LD	B,50H	; "P"
J7C23:	LD	A,(D7FFF)
        ADD	A,A
        RET	P			; IRQ (end of command), quit
        JP	C,J7C23			; wait for DRQ
        LD	A,C
        LD	(D7FFB),A
        DJNZ	J7C23
        LD	C,00H
        LD	B,0CH	; 12
J7C35:	LD	A,(D7FFF)
        ADD	A,A
        RET	P			; IRQ (end of command), quit
        JP	C,J7C35			; wait for DRQ
        LD	A,C
        LD	(D7FFB),A
        DJNZ	J7C35
        LD	C,0F6H
        LD	B,03H	; 3
J7C47:	LD	A,(D7FFF)
        ADD	A,A
        RET	P			; IRQ (end of command), quit
        JP	C,J7C47			; wait for DRQ
        LD	A,C
        LD	(D7FFB),A
        DJNZ	J7C47
        LD	C,0FCH
        INC	B
J7C58:	LD	A,(D7FFF)
        ADD	A,A
        RET	P			; IRQ (end of command), quit
        JP	C,J7C58			; wait for DRQ
        LD	A,C
        LD	(D7FFB),A
        DJNZ	J7C58
        LD	C,4EH
        LD	B,1AH
J7C6A:	LD	A,(D7FFF)
        ADD	A,A
        RET	P			; IRQ (end of command), quit
        JP	C,J7C6A			; wait for DRQ
        LD	A,C
        LD	(D7FFB),A
        DJNZ	J7C6A
J7C78:	LD	C,00H
        LD	B,0CH	; 12
J7C7C:	LD	A,(D7FFF)
        ADD	A,A
        RET	P			; IRQ (end of command), quit
        JP	C,J7C7C			; wait for DRQ
        LD	A,C
        LD	(D7FFB),A
        DJNZ	J7C7C
        LD	C,0F5H
        LD	B,03H	; 3
J7C8E:	LD	A,(D7FFF)
        ADD	A,A
        RET	P			; IRQ (end of command), quit
        JP	C,J7C8E			; wait for DRQ
        LD	A,C
        LD	(D7FFB),A
        DJNZ	J7C8E
        LD	C,0FEH
        INC	B
J7C9F:	LD	A,(D7FFF)
        ADD	A,A
        RET	P			; IRQ (end of command), quit
        JP	C,J7C9F			; wait for DRQ
        LD	A,C
        LD	(D7FFB),A
        DJNZ	J7C9F
        LD	A,(IX+7)
        LD	C,A
        INC	B
J7CB2:	LD	A,(D7FFF)
        ADD	A,A
        RET	P			; IRQ (end of command), quit
        JP	C,J7CB2			; wait for DRQ
        LD	A,C
        LD	(D7FFB),A
        DJNZ	J7CB2
        LD	A,(D7FFC)
        AND	01H			; current side
        LD	C,A
        INC	B
J7CC7:	LD	A,(D7FFF)
        ADD	A,A
        RET	P			; IRQ (end of command), quit
        JP	C,J7CC7			; wait for DRQ
        LD	A,C
        LD	(D7FFB),A
        DJNZ	J7CC7
        LD	C,D
        INC	B
J7CD7:	LD	A,(D7FFF)
        ADD	A,A
        RET	P			; IRQ (end of command), quit
        JP	C,J7CD7			; wait for DRQ
        LD	A,C
        LD	(D7FFB),A
        DJNZ	J7CD7
        LD	C,02H
        INC	B
J7CE8:	LD	A,(D7FFF)
        ADD	A,A
        RET	P			; IRQ (end of command), quit
        JP	C,J7CE8			; wait for DRQ
        LD	A,C
        LD	(D7FFB),A
        DJNZ	J7CE8
        LD	C,0F7H
        INC	B
J7CF9:	LD	A,(D7FFF)
        ADD	A,A
        RET	P			; IRQ (end of command), quit
        JP	C,J7CF9			; wait for DRQ
        LD	A,C
        LD	(D7FFB),A
        DJNZ	J7CF9
        LD	C,4EH	; "N"
        LD	B,16H
J7D0B:	LD	A,(D7FFF)
        ADD	A,A
        RET	P			; IRQ (end of command), quit
        JP	C,J7D0B			; wait for DRQ
        LD	A,C
        LD	(D7FFB),A
        DJNZ	J7D0B
        LD	C,00H
        LD	B,0CH	; 12
J7D1D:	LD	A,(D7FFF)
        ADD	A,A
        RET	P			; IRQ (end of command), quit
        JP	C,J7D1D			; wait for DRQ
        LD	A,C
        LD	(D7FFB),A
        DJNZ	J7D1D
        LD	C,0F5H
        LD	B,03H	; 3
J7D2F:	LD	A,(D7FFF)
        ADD	A,A
        RET	P			; IRQ (end of command), quit
        JP	C,J7D2F			; wait for DRQ
        LD	A,C
        LD	(D7FFB),A
        DJNZ	J7D2F
        LD	C,0FBH
        INC	B
J7D40:	LD	A,(D7FFF)
        ADD	A,A
        RET	P			; IRQ (end of command), quit
        JP	C,J7D40			; wait for DRQ
        LD	A,C
        LD	(D7FFB),A
        DJNZ	J7D40
        LD	C,0E5H
J7D50:	LD	A,(D7FFF)
        ADD	A,A
        RET	P			; IRQ (end of command), quit
        JP	C,J7D50			; wait for DRQ
        LD	A,C
        LD	(D7FFB),A
        DJNZ	J7D50
        LD	C,0E5H
J7D60:	LD	A,(D7FFF)
        ADD	A,A
        RET	P			; IRQ (end of command), quit
        JP	C,J7D60			; wait for DRQ
        LD	A,C
        LD	(D7FFB),A
        DJNZ	J7D60
        LD	C,0F7H
        INC	B
J7D71:	LD	A,(D7FFF)
        ADD	A,A
        RET	P			; IRQ (end of command), quit
        JP	C,J7D71			; wait for DRQ
        LD	A,C
        LD	(D7FFB),A
        DJNZ	J7D71
        LD	C,4EH	; "N"
        LD	B,36H	; "6"
J7D83:	LD	A,(D7FFF)
        ADD	A,A
        RET	P			; IRQ (end of command), quit
        JP	C,J7D83			; wait for DRQ
        LD	A,C
        LD	(D7FFB),A
        DJNZ	J7D83
        INC	D
        LD	A,D
        CP	0AH	; 10
        JP	NZ,J7C78
        LD	C,4EH	; "N"
        LD	B,00H
J7D9C:	LD	A,(D7FFF)
        ADD	A,A
        RET	P			; IRQ (end of command), quit
        JP	C,J7D9C			; wait for DRQ
        LD	A,C
        LD	(D7FFB),A
        DJNZ	J7D9C
J7DAA:	LD	A,(D7FFF)
        ADD	A,A
        RET	P			; IRQ (end of command), quit
        JP	C,J7DAA			; wait for DRQ
        LD	A,C
        LD	(D7FFB),A
        DJNZ	J7DAA
J7DB8:	LD	A,(D7FFF)
        ADD	A,A
        RET	P			; IRQ (end of command), quit
        JP	C,J7DB8			; wait for DRQ
        LD	A,C
        LD	(D7FFB),A
        DJNZ	J7DB8
        POP	HL

I7DC7:	LD	A,(D7FF8)


        IF	DRVVER EQ 206

        BIT	1,A
        JP	Z,J7DD6
        LD	B,A
        LD	A,4EH
        LD	(D7FFB),A
        LD	A,B
J7DD6:
        ENDIF

        IF	DRVVER EQ 207

        BIT	1,A
        JP	Z,J7DD6
        LD	B,A
        LD	A,4EH
        LD	(D7FFB),A
        LD	A,B
J7DD6:
        ENDIF


        AND	0C4H
        RET	Z
        SCF
        LD	E,A
        LD	A,02H
        JP	M,J7C07
        BIT	6,E
        LD	A,00H
        JP	NZ,J7C07
        LD	A,10H
        JP	J7C07


OEMSTA:
        SCF
        RET

;	  Subroutine stop motor drive(s)
;	     Inputs  ________________________
;	     Outputs ________________________

MTOFF:
C7DE2:	LD	A,3CH
        LD	(D7FFD),A		; motor off, not in use, leave disk change, select drive 0
        LD	A,3DH
        LD	(D7FFD),A		; motor off, not in use, leave disk change, select drive 1
        LD	A,3FH
        LD	(D7FFD),A		; motor off, not in use, leave disk change, deselect drive
        RET


D7FF8	EQU	07FF8H			; WD2793
D7FF9	EQU	07FF9H			; WD2793
D7FFA	EQU	07FFAH			; WD2793
D7FFB	EQU	07FFBH			; WD2793

D7FFC	EQU	07FFCH			; side select
D7FFD	EQU	07FFDH			; motor/in use/DC/drive select
D7FFF	EQU	07FFFH			; INT,DRQ

        END
