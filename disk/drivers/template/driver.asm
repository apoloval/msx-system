; A template driver section
; (C) 1992-2005 by Ultrasoft
;
; By:	Arjen Zeilemaker
;
; Version:		0.90




; symbols which can be used from the kernel

; GETSLT	get my slotid
; DIV16		divide
; GETWRK	get my workarea
; SETINT	install my interrupt handler
; PRVINT	call orginal interrupt handler
; PROMPT	prompt for phantom drive
; RAWFLG	verify flag
; _SECBUF	temporary sectorbuffer
; XFER		transfer to TPA
; DISINT	inform interrupts are being disabled
; ENAINT	inform interrupts are being enabled
; PROCNM	CALL statement name

; symbols which must be defined by the driver

; INIHRD	initialize diskdriver hardware
; DRIVES	how many drives are connected
; INIENV	initialize diskdriver workarea
; DSKIO		diskdriver sector i/o
; DSKCHG	diskdriver diskchange status
; GETDPB	build Drive Parameter Block
; CHOICE	get format choice string
; DSKFMT	format disk
; MTOFF		stop diskmotor
; OEMSTA	diskdriver special call statements

; MYSIZE	size of diskdriver workarea
; SECLEN	size of biggest sector supported by the diskdriver
; DEFDPB	pointer to a default Drive Parameter Block


; errorcodes used by DSKIO, DSKCHG and GETDPB
;
; 0	write protect error
; 2	not ready error
; 4	data (crc) error
; 6	seek error
; 8	record not found error
; 10	write fault error
; 12	other error

; errorcodes used by DSKFMT
;
; 0	write protect error
; 2	not ready error
; 4	data (crc) error
; 6	seek error
; 8	record not found error
; 10	write fault error
; 12	bad parameter
; 14	insufficient memory
; 16	other error



MYSIZE		equ	1		; Size of environment
SECLEN		equ	512		; Size of biggest sector

; INIHRD
;
; Input:	None
; Output:	None
; Changed:	AF,BC,DE,HL,IX,IY may be affected

INIHRD:
                ret



; DRIVES
;
; Input: 	F	Zx set if to return physical drives
;			Zx reset if to return at least 2 drives, if only one
;			  physical drive it becomes a phantom drive
; Output:	L	number of drives
; Changed:	F,HL,IX,IY may be affected
;
; Remark:	DOS1 does not handle L=0 correctly

DRIVES:
                ld	l,1
                ret



; INIENV
;
; Input: 	None
; Output:	None
; Changed:	AF,BC,DE,HL,IX,IY may be affected
;
; Remark:	examples installs own interrupt handler, but this is NOT required.
;		depends on the hardware if this is needed.

INIENV:
                call	GETWRK
                ld	(hl),1
                ld	hl,INTHAND
                jp	SETINT

INTHAND:
                push	af
                push	bc
                push	de
                push	hl
                push	ix
                push	iy
                call	GETWRK
                inc	(hl)
                pop	iy
                pop	ix
                pop	hl
                pop	de
                pop	bc
                pop	af
                jp	PRVINT



;
; DSKIO
;
; Input: 	A	Drivenumber
;		F	Cx reset for read
;			Cx set for write
; 		B	number of sectors
; 		C	Media descriptor
;		DE	logical sectornumber
; 		HL	transferaddress
; Output:	F	Cx set for error
;			Cx reset for ok
;		A	if error, errorcode
;		B	if error, remaining sectors
; Changed:	AF,BC,DE,HL,IX,IY may be affected

DSKIO:
                ld	a,12
                scf
                ret



; DSKCHG
;
; Input: 	A	Drivenumber
; 		B	0
; 		C	Media descriptor
; 		HL	pointer to DPB
; Output:	F	Cx set for error
;			Cx reset for ok
;		A	if error, errorcode
;		B	if no error, disk change status
;			01 disk unchanged
;			00 unknown
;			FF disk changed
; Changed:	AF,BC,DE,HL,IX,IY may be affected
; Remark:	DOS1 kernel expects the DPB updated when disk change status is unknown or changed
;		DOS2 kernel does not care if the DPB is updated or not

DSKCHG:
                or	a
                ld	b,1
                ret



; GETDPB
;
; Input: 	A	Drivenumber
; 		B	first byte of FAT
; 		C	Media descriptor
; 		HL	pointer to DPB
; Output:	[HL+1]
;		..
;		[HL+18]	updated
; Changed:	AF,BC,DE,HL,IX,IY may be affected

GETDPB:
                or	a
                ex	de,hl
                inc	de
                ld	hl,DpbTable
                ld	bc,18
                ldir
                ret

DpbTable:	db	0F8h
                dw	512
                db	0Fh
                db	04h
                db	01h
                db	02h
                dw	1
                db	2
                db	112
                dw	12
                dw	355
                db	2
                dw	5

DEFDPB		equ	DpbTable-1



; CHOICE
;
; Input: 	None
; Output:	HL	pointer to choice string, 0 if no choice
; Changed:	AF,BC,DE,HL,IX,IY may be affected

CHOICE:
                ld	hl,ChoiceStr
                ret

ChoiceStr:	db	13,10
                db	"1 - Choice A",13,10
                db	"2 - Choice B",13,10
                db	13,10
                db	0



; DSKFMT
;
; Input: 	A	choicecode (1-9)
;		D	drivenumber
;		HL	begin of workarea
;		BC	length of workarea
; Output:	F	Cx set for error
;			Cx reset for ok
;		A	if error, errorcode
; Changed:	AF,BC,DE,HL,IX,IY may be affected

DSKFMT:
                ld	a,16
                scf
                ret



; OEMSTATEMENT
;
; Input:	HL	basicpointer
; Output:	F	Cx set if statement not recognized
;			Cx reset if statement is recognized
;		HL	basicpointer,	updated if recognized
;					unchanged if not recognized
; Changed:	AF,BC,DE,HL,IX,IY may be affected

OEMSTA:
                scf
                ret



; MTOFF
;
; Input:	None
; Output:	None
; Changed:	AF,BC,DE,HL,IX,IY may be affected

MTOFF:
                ret


