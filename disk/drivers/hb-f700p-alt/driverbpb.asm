; A new driver section for SONY diskrom.
; (C) 1992-1995 by Ultrasoft
;
; By:	Arjen Zeilemaker
;
; Last revision:	Tuesday 18-04-1995
; Version:		2.03 (BPB version)


; Old driver has following problems:
;
; 1. Slow trackmovment
; 2. Slow sector read/write operation
; 3. No optimal use of hardware in DSKCHG routine
;
; A number of problems exits with all MSX diskdrives:
;
; 4. Bad support of non standard MS-DOS disk i.e. physical and boot
; 5. No support of bad sectors mark in FAT by DSKFMT


; Problem 1
;
; This "problem" is corrected by using the highest speed for trackmovment.
; In Philips' Diskroms the highest speed for track movement is always used!
; Therefore, there semes no problem for using the higest speed with the Sony
; diskdrive. Testing result in a real fast trackaccess and no problems where
; found during testing.

; Problem 2
;
; This "problem" is corrected by not allowing interrupt while doing dskio.
; Although there seems no real problem for disabling the interrupts while
; i/o-ing sectors, there are some subeffects! Because the keyboard is scanned
; via the interrupt, keys pressed during diskaccess are not noticed.

; Problem 3
;
; This "problem" is corrected by a hardware change. Using PC-drives, which
; (can) have DC (Disk Changed) signal on pin 34. This means that there is no
; READY signal on pin 34. Solution is to connect READY pin of the TMS 2793
; to a HIGH. This is done by disconnecting pin 11 of IC 33. Because there is
; already a pullup resitor, READY is always TRUE. The problem now is to detect
; if the drive is ready, but it can be done with the INDEX signal.
; Disconnect the +5V from pin 16 CXD 1032, this the DC input pin. Now connect
; pin 18 of IC 35 to pin with this pin.
; Now we can read DC from bit 2 of DrvStsPrt. If it is 0 there was a DC
; detect. To reset we have to do a (valid) trackmovment. Recommended is a
; restore, but others are also useable


; Problem 4
;
; This problem can be corrected by using the BPB if available.


; Problem 5
;
; This problem can be corrected. By this, disks with bad sectors can still be
; used correctly. Note that the new routine first check if track 0 is useable,
; if not the disk cannot be used. Then all system sectors are checked for bad
; sectors, if any the disk cannot be used.
; Finally, when verify = on, the data sectors are checked and the FAT is marked
; when finding a bad sector/track.

; Environment
;
; 0	number of physical drives	either 1 or 2
; 1	init flag physical drv 0	0 = init
; 2	init flag physical drv 1	0 = init
; 3	trackptr save physical drv 0
; 4	trackptr save physical drv 1
; 5	last drv used



; Used externals from system kernel (permited)

;		EXTRN	GETSLT
;		EXTRN	DIV16
;		EXTRN	GETWRK
;		EXTRN	SETINT
;		EXTRN	PRVINT
;		EXTRN	PROMPT


; Publics for DOS1 or DOS2 kernel

;		PUBLIC	INIHRD
;		PUBLIC	DRIVES
;		PUBLIC	INIENV
;		PUBLIC	DSKIO
;		PUBLIC	DSKCHG
;		PUBLIC	GETDPB
;		PUBLIC	CHOICE
;		PUBLIC	DSKFMT
;		PUBLIC	MTOFF
;		PUBLIC	OEMSTA

;		PUBLIC	MYSIZE
;		PUBLIC	SECLEN
;		PUBLIC	DEFDPB


MYSIZE		equ	6		; Size of environment
SECLEN		equ	512		; Size of biggest sector



; TMS 2793 NL	FDCS I/O addresses

ComStsPrt	equ	07FF8h
TrkPtrPrt	equ	07FF9h
SecPtrPrt	equ	07FFAh
DataPrt		equ	07FFBh

; CXD 1032 Q	FLOPPY DISK CONTROL

SidePrt		equ	07FFCh
DrivePrt	equ	07FFDh
IoStsPrt	equ	07FFFh


; INIHRD
;
; Input:	None
; Output:	None
; Changed:	AF,BC,DE,HL,IX,IY may be affected

INIHRD:
                ld	a,0D0h			; TERMINATE
                ld	(ComStsPrt),a		; reset controller
                ex	(sp),hl
                ex	(sp),hl
                ex	(sp),hl
                ex	(sp),hl			; Wait 20 microsec.
                ld	a,03Ch			; motor off/not in use/drv 0
                call	InitDrive		; Initialize drive 0
                ld	a,03Dh			; motor off/not in use/drv 1
                call	InitDrive		; Initialize drive 1
                ld	a,03Fh			; motor off/not in use/drv 3 (unselect)
                ld	(DrivePrt),a
                ret

InitDrive:	ld	(DrivePrt),a		; select drive
                call	SetTrk0			; track 0
NextSeek:	call	SetNxtTrk
                ld	a,(ComStsPrt)
                and	04h
                jr	nz,NextSeek		; Repeat until not Track 00
                call	WaitIoReady
                ld	a,00h			; RESTORE
                ld	(ComStsPrt),a
                ex	(sp),hl
                ex	(sp),hl			; Wait 10 microsec.
                ld	hl,0
WaitOnDrive:	ld	a,(ComStsPrt)
                rra
                ret	nc
                dec	hl
                ld	a,h
                or	l
                jr	nz,WaitOnDrive
                ret

; DRIVES
;
; Input: 	F	Zx set if to return physical drives
;			Zx reset if to return at least 2 drives, if only one
;			  physical drive it becomes a phantom drive
; Output:	L	number of drives
; Changed:	F,HL,IX,IY may be affected

DRIVES:
                push	bc
                push	af
                call	GETWRK
                ld	a,03Dh			; motor off/not in use/drv 1
                ld	(DrivePrt),a
                call	WaitIoReady
                ld	a,00h			; RESTORE
                ld	(ComStsPrt),a		; Track 00 seek
                ex	(sp),hl
                ex	(sp),hl			; Wait 10 microsec.
                ld	hl,0
WaitOnDrive1:	ld	a,(ComStsPrt)
                rra
                jr	nc,LegalDrive1
                dec	hl
                ld	a,h
                or	l
                jp	nz,WaitOnDrive1		; Wait max. 880 msec.
                inc	l
                db	0CAh			; pseudo jp z,nnnn
LegalDrive1:	ld	l,2
                ld	a,03Fh			; motor off/not in use/drv 3 (unselect)
                ld	(DrivePrt),a
                pop	af
                pop	bc
                ld	(ix+0),l		; physical drives
                ld	l,1
                ret	z			; CTRL, use 1 drive
                inc	l			; 2 drives
                ret

; INIENV
;
; Input: 	None
; Output:	None
; Changed:	AF,BC,DE,HL,IX,IY may be affected
;
; REMARK
; Most drivers use interrupt handler to stop drive motor after a amount of
; time when no actions occure. SONY hardware include a hardware solution to
; this problem.
; There no interrupt handler is used, and valuable time is saved!
; Note that the kernel supports this.

INIENV:
                call	GETWRK
                xor	a
                ld	b,5
NextEnv:	inc	hl
                ld	(hl),a
                djnz	NextEnv
                ret

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
                jr	c,no_rd
                call	dskio_inst
                ret	c
                call	DISINT
                di
                call	dskio_rd
                jr	end_dskio

no_rd:		call	dskio_inst
                ret	c
                call	DISINT
                di
                call	dskio_wrt
end_dskio:	ei
                call	ENAINT
                push	af
                call	c,dskio_err
                ld	a,0D0h
                ld	(ComStsPrt),a		; TERMINATE
                ex	(sp),hl
                ex	(sp),hl
                ex	(sp),hl
                ex	(sp),hl			; wait 20 microsec.
                ld	a,(DataPrt)		; reset DRQ
                ld	a,(ComStsPrt)		; reset INTRQ
                ld	a,03Fh
                ld	(DrivePrt),a		; motor off/not in use/drive 3 (unselect)
                pop	af
                ret

dskio_err:	ld	a,(ix+0)
                dec	a
                jr	z,dskio_err_0
                ld	a,(ix+5)
                or	a
                jr	z,dskio_err_0
dskio_err_1:	ld	(ix+2),0
                ret
dskio_err_0:	ld	(ix+1),0
                ret

dskio_wrt:	call	dskio_track
                ret	c
dskio_nwrt:	ld	a,h
                and	a			; #8000-#FFFF no problem
                jp	m,wrt_trns_norm
                dec	hl
                ld	a,h
                inc	hl
                cp	03Eh			; #0000-#3E00 no problem
                jr	c,wrt_trns_norm
                push	hl
                push	de
                push	bc
                ld	de,(_SECBUF)
                push	de
                ld	bc,512
                call	XFER
                pop	hl
                pop	bc
                pop	de
                call	wrt_io
                pop	hl
                ret	c
                dec	b
                ret	z
                call	nextsec_io
                jr	dskio_nwrt

wrt_trns_norm:	call	wrt_io
                ret	c
                dec	b
                ret	z
                call	nextsec_io
                jr	dskio_nwrt

wrt_io:		ld	e,10
WrtNextTry:	call	WaitIoReady
                ld	a,0A0h			; WRITE SECTOR
                bit	6,d
                jr	z,WrtSet
                or	00000010b
                bit	0,d
                jr	z,WrtSet
                or	00001000b
WrtSet:		push	hl
                push	de
                push	bc
                ld	de,WrtReturn
                push	de
                ld	(ComStsPrt),a
                ex	(sp),hl
                ex	(sp),hl			; wait 10 microsec.
                ld	bc,IoStsPrt
                ld	de,DataPrt
WrtWait:	ld	a,(bc)
                add	a,a			; IRQ (ready/terminate)
                ret	p			; yes, quit
                jp	c,WrtWait		; no DRQ, wait
                ld	a,(hl)
                ld	(de),a
                inc	hl
                jp	WrtWait

WrtReturn:	pop	bc
                pop	de
                pop	hl
                ld	a,(ComStsPrt)
                and	11011100b
                ret	z
                jp	m,WrtNotReady
                bit	6,a
                jr	nz,WrtProtect
                bit	4,a
                jr	nz,WrtRNF
                push	af
                call	TrackIni
                pop	af
                dec	e
                jr	nz,WrtNextTry
                bit	3,e
                jr	nz,WrtCRC
                ld	a,0Ch			; OTHER ERROR
                db	011H			; skip next

WrtCRC:		ld	a,04h			; CRC ERROR
                db	011H			; skip next

WrtRNF:		ld	a,08h			; RECORD NOT FOUND ERROR
                db	011H			; skip next

WrtNotReady:	ld	a,02h			; NOT READY ERROR
                db	01EH			; skip next

WrtProtect:	xor	a			; WRITE PROTECT ERROR
                scf
                ret


dskio_rd:	call	dskio_track
                ret	c
dskio_nrd:	ld	a,h
                and	a
                jp	m,rd_trns_norm
                dec	hl
                ld	a,h
                inc	hl
                cp	03Eh
                jr	c,rd_trns_norm
                push	hl
                ld	hl,(_SECBUF)
                call	rd_io
                pop	hl
                ret	c
                push	hl
                push	de
                push	bc
                ex	de,hl
                ld	hl,(_SECBUF)
                ld	bc,512
                call	XFER
                pop	bc
                pop	de
                pop	hl
                dec	b
                ret	z
                call	nextsec_io
                jr	dskio_nrd

rd_trns_norm:	call	rd_io
                ret	c
                dec	b
                ret	z
                call	nextsec_io
                jr	dskio_nrd

rd_io:		ld	e,10
RdNextTry:	call	WaitIoReady
                ld	a,080h			; READ SECTOR
                bit	6,d
                jr	z,RdSet
                or	00000010b
                bit	0,d
                jr	z,RdSet
                or	00001000b
RdSet:		push	hl
                push	de
                push	bc
                ld	de,RdReturn
                push	de
                ld	(ComStsPrt),a
                ex	(sp),hl
                ex	(sp),hl			; wait 10 microsec.
                ld	bc,IoStsPrt
                ld	de,DataPrt
RdWait:		ld	a,(bc)
                add	a,a			; IRQ (ready/terminate)
                ret	p			; yes, quit
                jp	c,RdWait		; no DRQ, wait
                ld	a,(de)
                ld	(hl),a
                inc	hl
                jp	RdWait

RdReturn:	pop	bc
                pop	de
                pop	hl
                ld	a,(ComStsPrt)
                and	10011100b
                ret	z
                jp	m,RdNotReady
                bit	4,a
                jr	nz,RdRNF
                push	af
                call	TrackIni
                pop	af
                dec	e
                jr	nz,RdNextTry
                bit	3,a
                jr	nz,RdCRC
                ld	a,0Ch			; OTHER ERROR
                db	011H			; skip next

RdCRC:		ld	a,04h			; CRC ERROR
                db	011H			; skip next

RdRNF:		ld	a,08h			; RECORD NOT FOUND ERROR
                db	011H			; skip next

RdNotReady:	ld	a,02h			; NOT READY ERROR
                scf
                ret


MediaByteErr:	pop	af
FalseDrvErr:	ld	a,0Ch			; OTHER ERROR
                scf
                ret

dskio_inst:	push	af
                push	bc
                push	hl
                call	GETWRK
                pop	hl
                pop	bc
                pop	af
                cp	2
                jr	nc,FalseDrvErr
                push	af
                ld	a,c
                cp	0F8h
                jr	c,MediaByteErr
                ex	(sp),hl
                push	hl
                push	bc
                call	WaitIoReady
                bit	1,c
                ld	c,e
                ld	b,d
                ld	de,8
                jr	nz,Calculate
                inc	de
Calculate:	call	DIV16
                ld	a,l
                inc	a
                ld	(SecPtrPrt),a
                ld	l,c
                pop	bc
                pop	af
                ld	h,a
                xor	a
                bit	0,c
                jr	z,SetSide
                srl	l
                jr	nc,SetSide
                inc	a
SetSide:	ld	(SidePrt),a
                ld	a,c
                rrca
                rrca
                and	0C0h
                ld	d,a
                ld	a,(SidePrt)
                and	01h
                or	d
                ld	d,a
                ld	c,l
                ld	a,h
                cp	(ix+5)
                ld	(ix+5),a
                jr	z,quit_dskio
                ld	a,(ix+0)
                dec	a
                jr	z,SnglDrv
                inc	h
                dec	h
                ld	a,(TrkPtrPrt)
                jr	z,SaveDrive1
                ld	(ix+3),a
                ld	a,(ix+4)
                jr	SetTrackPtr
SaveDrive1:	ld	(ix+4),a
                ld	a,(ix+3)
SetTrackPtr:	ld	(TrkPtrPrt),a
                ex	(sp),hl
                ex	(sp),hl			; Wait 10 microsec.
quit_dskio:	pop	hl
                or	a
                ret

SnglDrv:	push	ix
                push	de
                push	bc
                call	PROMPT
                pop	bc
                pop	de
                pop	ix
                pop	hl
                or	a
                ret

dskio_track:	push	hl
                ld	a,(ix+0)
                dec	a
                jr	z,SetDrive
                ld	a,(ix+5)
SetDrive:	or	0FCh			; motor on/in use
                ld	(DrivePrt),a
                ld	hl,41762		; 700 msec (to spin up)
                ld	a,0D0h			; TERMINATE
                ld	(ComStsPrt),a
                ex	(sp),hl
                ex	(sp),hl
                ex	(sp),hl
                ex	(sp),hl
WaitForIP:	ld	a,(ComStsPrt)
                and	00000010b
                jr	nz,DriveReady
                dec	hl
                ld	a,h
                or	l
                jr	nz,WaitForIP
                ld	a,002H			; not ready
                scf
                pop	hl
                ret
DriveReady:	ld	a,(TrkPtrPrt)
                cp	c
                call	nz,SetTrk
                pop	hl
                ret


nextsec_io:	call	WaitIoReady
                inc	h
                inc	h
                ld	a,(SecPtrPrt)
                inc	a
                ld	(SecPtrPrt),a
                bit	7,d
                jr	nz,Sector8Track
                cp	9+1
                ret	c
Sector8Track:	cp	8+1
                ret	c
                ld	a,1
                ld	(SecPtrPrt),a
                bit	6,d
                jr	z,SelSetNxtTrk
                bit	0,d
                jr	nz,SelSetNxtTrk
                set	0,d
                ld	(SidePrt),a
                ret

SelSetNxtTrk:	res	0,d
                xor	a
                ld	(SidePrt),a
                inc	c
SetNxtTrk:	call	WaitIoReady
                ld	a,050h			; STEP IN
                jr	ExeCommand

TrackIni:	bit	0,e
                ret	nz
                call	SetTrk0
SetTrk:		ld	a,c
                ld	(DataPrt),a
                ex	(sp),hl
                ex	(sp),hl			; Wait 10 microsec.
                ld	a,010h			; SEEK
ExeCommand:	ld	(ComStsPrt),a
                ex	(sp),hl
                ex	(sp),hl			; Wait 10 microsec.
                call	WaitIoReady
                call	WaitHead
                ret

SetTrk0:	call	WaitIoReady
                ld	a,000h			; RESTORE
                jr	ExeCommand


WaitIoReady:	ld	a,(ComStsPrt)
                rra
                jp	c,WaitIoReady
                ret

WaitHead:	push	hl
                ld	hl,2148			; 18 msec
Wait:		dec	hl
                ld	a,h
                or	l
                jr	nz,Wait
                pop	hl
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

; REMARK
; Uses DC hardware!
;
; DOS1 expect that DSKCHG updates the DPB if the disk changed or unknown
; status is been return
;
; DOS2 does not! expect that DSKCHG updates the DPB. Updating the DPB is no
; error, but not recomended. This is very important when using disks with non
; default DPB in the bootsector.


DSKCHG:
                IFNDEF	DOS2

                push	hl
                push	bc
                push	af
                call	GETWRK
                pop	af
                pop	bc
                pop	hl
                ld	d,a
                ld	e,a
                ld	a,(ix+0)
                dec	a
                jr	nz,CheckHrdDrv		; 2 drives, so always a physical drive!
                ld	a,d
                xor	(ix+5)			; an other logical drive ?
                jr	nz,GetMedia		; yep, disk change unknown
                ld	e,0
CheckHrdDrv:	inc	e
                dec	e
                jr	z,CheckDrv0		; driveid 0
                ld	a,(ix+2)		; DC driveid 1 already initialized ?
                ld	(ix+2),0FFH		; DC driveid 1 is initialized after this
                jr	CheckIni
CheckDrv0:	ld	a,(ix+1)		; DC driveid 0 already initialized ?
                ld	(ix+1),0FFH		; DC driveid 0 is initialized after this
CheckIni:	or	a
                jr	z,GetMedia		; DC not initialized, change status is unknown
                inc	b			; disk unchanged
                ld	a,e
                or	038h			; motor off/not in use
                ld	(DrivePrt),a		; Select drive
                ld	(DrivePrt),a		; Select drive
                ld	a,(DrivePrt)
                and	00000100b		; DC bit
                jr	z,CheckChange
                ld	a,03Fh
                ld	(DrivePrt),a		; unselect drive
                ret				; quit with disk unchanged
CheckChange:	dec	b
                dec	b			; disk changed
                ld	a,(ComStsPrt)
                and	00000100b		; drive currently on Track 0 ?
                call	nz,SetNxtTrk		; yep, Seek to 1 (otherwise seek to track 0 does not reset DC bit)
                call	SetTrk0			; Seek to track 0 to reset DC bit
GetMedia:	push	bc
                push	hl
                ld	a,d
                call	GETDPB
                pop	hl
                pop	bc
                ret	c
                inc	b
                dec	b
                ret	nz			; disk changed,  done
                inc	hl
                ld	a,c			; old mediadescriptor
                xor	(hl)			; new mediadescriptor
                ret	z			; same, disk change unknown
                dec	b
                ret

                ELSE

                push	hl
                push	bc
                push	af
                call	GETWRK
                pop	af
                pop	bc
                pop	hl
                ld	d,a
                ld	a,(ix+0)
                dec	a
                jr	nz,CheckHrdDrv
                ld	a,d
                xor	(ix+5)			; an other logical drive ?
                ret	nz			; yep, disk change unknown
                ld	d,0
CheckHrdDrv:	inc	d
                dec	d
                jr	z,CheckDrv0
                ld	a,(ix+2)
                ld	(ix+2),0FFH
                jr	CheckIni
CheckDrv0:	ld	a,(ix+1)
                ld	(ix+1),0FFH
CheckIni:	or	a
                ret	z			; not initialized, unknown
                inc	b			; unchanged
                ld	a,d
                or	038h
                ld	(DrivePrt),a		; Select drive
                ld	(DrivePrt),a
                ld	a,(DrivePrt)
                and	00000100b		; DC bit
                jr	nz,CheckQuit		; disk not changed
                dec	b
                dec	b			; changed
                ld	a,(ComStsPrt)
                and	00000100b		; Track 0 ?
                call	nz,SetNxtTrk		; yep, Seek to 1
                call	SetTrk0			; Seek to reset DC bit
CheckQuit:	ld	a,03Fh
                ld	(DrivePrt),a		; unselect drive
                ret

                ENDIF


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
                push	af
                push	hl
                or	a			; read
                ld	bc,001F9H		; 1 sector, a mediadescriptor
                ld	de,0			; sector 0, the bootsector
                ld	hl,(_SECBUF)
                push	hl
                call	DSKIO			; get sector
                pop	iy			; _SECBUF
                pop	hl
                pop	bc			; B= driveid
                jr	c,prebpb		; error reading the bootsector, try the old method
                ld	a,(iy+0)
                or	2
                cp	0EBH
                jr	nz,prebpb		; no BPB indicator, use the old method
                ld	a,(iy+12)
                sub	2
                or	(iy+11)
                jr	nz,prebpb		; sectorsize not 512, use the old method (a bit of a hack)
                or	(iy+13)
                jr	z,prebpb		; clustersize 0, use the old method (bpb invalid)
                neg
                and	(iy+13)
                cp	(iy+13)
                jr	nz,prebpb		; clustersize not a power of 2, use the old method (bpb invalid)
                ld	a,(iy+16)
                dec	a
                cp	7
                jr	nc,prebpb		; number of FAT copies not 1-7, use the old method
                ld	a,(iy+22)
                dec	a
                cp	12
                jr	nc,prebpb		; number of FAT sectors not 1-12, use the old method
                ld	a,(iy+23)
                or	a
                jr	nz,prebpb

                inc	hl
                ld	a,(iy+21)
                ld	(hl),a
                inc	hl
                ld	(hl),LOW 512
                inc	hl
                ld	(hl),HIGH 512
                inc	hl
                ld	(hl),00FH
                inc	hl
                ld	(hl),004H
                inc	hl
                ld	a,(iy+13)		; sectors per cluster
                dec	a
                ld	(hl),a			; clustermask
                inc	hl
                inc	a
                ld	c,0
cluslp:		inc	c
                rra
                jr	nc,cluslp
                ld	(hl),c			; clustershift
                inc	hl
                ld	a,(iy+14)
                ld	(hl),a
                inc	hl
                ld	d,(iy+15)
                ld	(hl),d
                inc	hl			; first FAT sector
                ld	b,(iy+16)
                ld	(hl),b
                inc	hl			; number of FATs
fatlp:		add	a,(iy+22)
                jr	nc,fatjr1
                inc	d
fatjr1:		djnz	fatlp
                ld	e,a			; first dir sector
                ld	b,(iy+18)
                inc	b
                dec	b
                jr	nz,dir254
                ld	c,(iy+17)
                ld	a,c
                inc	c
                jr	nz,dirent
dir254:		ld	a,254
dirent:		dec	c
                ld	(hl),a
                inc	hl
                dec	bc
                srl	b
                rr	c
                srl	b
                rr	c
                srl	b
                rr	c
                srl	b
                rr	c
                inc	bc			; number of directory sectors
                ld	a,e
                add	a,c
                ld	c,a
                ld	a,d
                adc	a,b
                ld	b,a			; + first dir sector
                ld	(hl),c
                inc	hl
                id	(hl),b
                inc	hl			; = first data sector
                ld	a,(iy+19)
                sub	c
                ld	c,a
                ld	a,(iy+20)
                sbc	a,b
                ld	b,a			; total number of sectors - first data sector = number of data sectors
                ld	a,(iy+13)
totcls:		rra
                jr	c,totcls2
                srl	b
                rr	c
                jr	totcls
totcls2:	inc	bc
                ld	(hl),c
                inc	hl
                ld	(hl),b			; number of clusters+1
                inc	hl
                ld	(hl),e			; first dir sector
                xor	a
                ret

prebpb:		push	bc
                push	hl
                ld	a,b			; driveid
                or	a
                ld	bc,001F9H
                ld	de,1
                ld	hl,(_SECBUF)
                call	DSKIO
                pop	de
                pop	bc
                ret	c			; error, quit

                inc	de
                ld	hl,(_SECBUF)
                ld	a,(hl)
                sub	0F8H
                ld	a,12
                ret	c
                ld	l,a
                ld	h,0
                add	hl,hl			; *2
                ld	c,l
                ld	b,h
                add	hl,hl
                add	hl,hl
                add	hl,hl			; *16
                add	hl,bc			; *18
                ld	bc,DpbTable
                add	hl,bc
                ld	bc,18
                ldir
                ret

DpbTable:	db	0F8h		; Media F8
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

                db	0FCh		; Media FC
                dw	512		; 40 Tracks
                db	0Fh		; 9 sectors
                db	04h		; 1 side
                db	00h		; 5.25" 180 Kb
                db	01h
                dw	1
                db	2
                db	64
                dw	9
                dw	352
                db	2
                dw	5

                db	0FDh		; Media FD
                dw	512		; 40 Tracks
                db	0Fh		; 9 sectors
                db	04h		; 2 sides
                db	01h		; 5.25" 360 Kb
                db	02h
                dw	1
                db	2
                db	112
                dw	12
                dw	355
                db	2
                dw	5

                db	0FEh		; Media FE
                dw	512		; 40 Tracks
                db	0Fh		; 8 sectors
                db	04h		; 1 side
                db	00h		; 5.25" 160 Kb
                db	01h
                dw	1
                db	2
                db	64
                dw	7
                dw	314
                db	1
                dw	3

                db	0FFh		; Media FF
                dw	512		; 40 Tracks
                db	0Fh		; 8 sectors
                db	04h		; 2 sides
                db	01h		; 5.25" 320 Kb
                db	02h
                dw	1
                db	2
                db	112
                dw	10
                dw	316
                db	1
                dw	3

DEFDPB		equ	DpbTable+18-1



; CHOICE
;
; Input: 	None
; Output:	HL	pointer to choice string, 0 if no choice
; Changed:	AF,BC,DE,HL,IX,IY may be affected

CHOICE:
                ld	hl,ChoiceStr
                ret

ChoiceStr:	db	13,10
                db	"1 - Single sided, 9 sectors, 80 Tracks",13,10
                db	"2 - Double sided, 9 sectors, 80 Tracks",13,10
                db	"3 - Single sided, 9 sectors, 40 Tracks",13,10
                db	"4 - Double sided, 9 sectors, 40 Tracks",13,10
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
;
; REMARK
; Need space for:
; - fmtbadlen	bad sector flags
; - fmtdatlen	bytes formatdata

DSKFMT:
                push	hl
                pop	iy
                ld	hl,-(fmtbadlen+fmtdatlen)
                add	hl,bc
                jp	nc,MemErrorFmt
                ld	c,0F8h
                cp	1
                jr	z,Format
                inc	c
                cp	2
                jr	z,Format
                ld	c,0FCh
                cp	3
                jr	z,Format
                inc	c
                cp	4
                jp	nz,OptErrorFmt

Format:		push	bc
                ld	a,d
                ld	de,0
                call	Dskio_inst
                pop	de
                ret	c
                push	de
                call	DISINT
                di
                call	dskio_track
                pop	bc
                jp	c,GenErrorFmt
                push	bc
                call	fmtinidat
                pop	bc
                xor	a
                ld	(ix+1),a
                push	iy
                pop	hl
                ld	b,080H
FmtSetNxtTrk:	push	bc
                push	hl
                call	fmtchgdat
                pop	hl
                pop	bc
                call	FormatTrack
                call	nc,VerifyTrack
                jp	c,GenErrorFmt
                bit	0,c			; single sided ?
                jr	z,ToSetNxtTrk		; yep,
                ld	a,(SidePrt)
                xor	01h
                ld	(SidePrt),a		; other side
                and	01h			; move track ?
                jr	nz,FmtSetNxtTrk		; nop,
ToSetNxtTrk:	ld	a,(ix+1)
                inc	a
                ld	(ix+1),a		; next track
                bit	2,c
                jr	z,Fmt80tracks
                cp	40
                jr	z,FmtEndTrack
Fmt80tracks:	cp	80
                jr	z,FmtEndTrack
                call	SetNxtTrk
                jr	FmtSetNxtTrk

FmtEndTrack:	ei
                call	ENAINT
                call	ClearBuffer
                push	bc
                ld	hl,BootSector		; Make Bootsector
                ld	de,(_SECBUF)
                ld	bc,BootLength
                ldir				; Make boot for double sided
                pop	bc
                push	bc
                ld	hl,(_SECBUF)
                ld	de,00Dh
                add	hl,de
                ex	de,hl
                ld	a,c
                sub	0F8h
                ld	c,a
                add	a,a
                add	a,a
                add	a,a
                add	a,a			; *16
                sub	c			; *15
                ld	c,a
                ld	b,0
                ld	hl,BootChgTbl
                add	hl,bc
                ld	bc,15
                ldir				; Make DPB bootsector
                pop	bc
NoBootChg:	ld	de,0
                call	FormatWrite		; Write bootsector
                jp	c,DskioErr
                inc	de
                ld	b,2			; Make 2 FAT's
FormatNxtFat:	push	iy
                call	WriteFat
                pop	iy
                djnz	FormatNxtFat
                call	ClearBuffer
                ld	b,7
                ld	a,c
                cp	0FCH
                jr	nz,FormatNxtDir
                ld	b,4			; FC, 64 entries
FormatNxtDir:	call	FormatWrite
                jp	c,DskioErr
                inc	de
                djnz	FormatNxtDir
                ret

GenErrorFmt:	call	DskioErr
                jp	end_dskio

DskioErr:	cp	00Ch
                ret	c
                ld	a,010h
                db	011H
OptErrorFmt:	ld	a,00Ch
                db	011H
MemErrorFmt:	ld	a,00Eh
                scf
                ret


ClearBuffer:	push	hl
                push	bc
                ld	hl,(_SECBUF)
                ld	b,0
FillBuffer:	ld	(hl),0
                inc	hl
                ld	(hl),0
                inc	hl
                djnz	FillBuffer
                pop	bc
                pop	hl
                ret

FormatWrite:	push	hl
                push	de
                push	bc
                push	af
                scf
                ld	a,(ix+5)
                ld	b,1
                ld	hl,(_SECBUF)
                call	DSKIO
                pop	bc
                jr	c,KeepError
                ld	a,b
KeepError:	pop	bc
                pop	de
                pop	hl
                ret

WriteFat:	push	bc
                ld	(ix+1),c		; media
                ld	(ix+2),e		; sectornumber
                call	ClearBuffer
                ld	hl,(_SECBUF)
                ld	(hl),c
                inc	hl
                ld	(hl),0FFh
                inc	hl
                ld	(hl),0FFh
                inc	hl
                ld	a,c
                cp	0FCH
                ld	de,351
                ld	c,9
                jr	z,WrtFatGo
                ld	de,354
                ld	c,12
                cp	0F9H
                jr	nz,WrtFatGo
                ld	de,713
                ld	c,14
WrtFatGo:	ld	b,1
WrtFatNxt:	call	GetSectorMrk
                dec	c
                jr	nz,WrtFatNxt
                ld	c,0
WrtFatClus:	res	0,c
                call	GetSectorMrk
                or	c
                ld	c,a
                ld	a,(ix+1)
                sub	0FCH
                call	nz,GetSectorMrk
                or	c
                call	MarkCluster
                dec	de
                ld	a,d
                or	e
                jr	nz,WrtFatClus
                call	WrtFatSector
                ld	e,(ix+2)
                ld	d,0
                pop	bc
                ret

GetSectorMrk:	xor	a
                rrc	(iy+0)
                adc	a,0
                rl	b
                ret	nc
                inc	iy
                ld	b,1
                ret

MarkCluster:	push	de
                ld	de,00000H
                and	1
                jr	z,MarkSkip
                ld	de,00FF7H
MarkSkip:	bit	1,c
                jr	z,MarkEven
                ex	de,hl
                add	hl,hl
                add	hl,hl
                add	hl,hl
                add	hl,hl
                ex	de,hl
                ld	a,(hl)
                or	e
                ld	(hl),a
                inc	hl
                call	CheckWrt
                ld	(hl),d
                inc	hl
                call	CheckWrt
                res	1,c
                pop	de
                ret
MarkEven:	ld	(hl),e
                inc	hl
                call	CheckWrt
                ld	a,(hl)
                or	d
                ld	(hl),a
                set	1,c
                pop	de
                ret

CheckWrt:	push	de
                ex	de,hl
                ld	hl,(_SECBUF)
                inc	h
                inc	h
                or	a
                sbc	hl,de
                ex	de,hl
                pop	de
                ret	nz
WrtFatSector:	push	de
                push	bc
                ld	e,(ix+2)
                ld	d,0
                ld	c,(ix+1)
                call	FormatWrite
                call	ClearBuffer
                pop	bc
                pop	de
                ld	hl,(_SECBUF)
                inc	(ix+2)
                ret

FormatTrack:
                ld	e,10
FormatNXT:	push	hl
                push	de
                push	bc
                push	iy
                pop	hl
                ld	de,fmtbadlen
                add	hl,de
                call	WaitIoReady
                ld	de,FormatEnd
                push	de
                ld	de,IoStsPrt
                ld	a,0F0h			; WRITE TRACK
                ld	(ComStsPrt),a
                ex	(sp),hl
                ex	(sp),hl

fmtloop:	ld	b,(hl)
                inc	hl
                ld	c,(hl)
                inc	hl
fmtwaitDRQ:	ld	a,(de)
                add	a,a
                ret	p
                jp	c,fmtwaitDRQ
                ld	a,c
                ld	(DataPrt),a
                djnz	fmtwaitDRQ
                jp	fmtloop

FormatEnd:	pop	bc
                pop	de
                pop	hl
                ld	a,(ComStsPrt)
                and	11000100B
                ret	z
                jp	m,FmtNRDY
                bit	6,a
                jr	nz,FmtWPRT
                dec	e
                jr	nz,FormatNXT
                ld	a,010h
                db	011H
FmtNRDY:	ld	a,002h
                db	01EH
FmtWPRT:	xor	a
                scf
                ret


; HL = pointer
; B  = databyte (so far)

VerifyTrack:	ld	a,(ix+1)
                bit	0,c
                jr	nz,VrfDouble
                cp	2
                jr	c,VrfStart		; always verify system
                jr	nz,VrfCheck
                ld	e,00Fh			; F8 -> 00001111 11111111 (12)
                bit	2,c
                jr	z,VrfSystem
                ld	e,001h			; FC -> 00000001 11111111 (9)
                jr	VrfSystem
VrfDouble:	cp	1
                jr	c,VrfStart		; always verify system
                jr	nz,VrfCheck
                ld	e,03Fh			; F9 -> 00111111 11111111 (14)
                bit	2,c
                jr	z,VrfSystem
                ld	e,00Fh			; FD -> 00001111 11111111 (12)
VrfSystem:	ld	a,(iy+1)
                and	e
                or	(iy+0)			; Verify error in system area ?
                ld	a,00Ah
                scf				; yep, then abort format
                ret	nz
VrfCheck:	ld	a,(RAWFLG)
                or	a
                ret	z
VrfStart:	ld	a,1
                ld	e,a
                ld	(SecPtrPrt),a		; start at sector 1
VrfNext:	call	WaitIoReady
                ld	a,10010000b		; READ SECTOR, multiple
                bit	6,d
                jr	z,VrfSet
                or	00000010b		; Side compare
                bit	0,d
                jr	z,VrfSet
                or	00001000b		; Side 1
VrfSet:		push	hl
                push	de
                push	bc
                ld	de,VrfReturn
                push	de
                ld	(ComStsPrt),a
                ex	(sp),hl
                ex	(sp),hl			; Wait 10 microsec.
                ld	bc,IoStsPrt
                ld	de,DataPrt
VrfWait:	ld	a,(bc)
                add	a,a			; IRQ (ready/terminate)
                ret	p			; yes, quit
                jp	c,VrfWait		; no DRQ, wait
                ld	a,(de)
                jp	VrfWait

VrfReturn:	pop	bc
                pop	de
                pop	hl
                ld	a,(SecPtrPrt)
                cp	10			; Error on sector 10 ?
                jr	nc,VrfEndTrack
                ld	a,(ComStsPrt)
                bit	2,a
                jr	nz,VrfNext		; lost data, again
                add	a,a
                ld	a,002h
                ret	c
                ld	a,(SecPtrPrt)
                sub	e
ShiftGoodNxt:	jr	z,ShiftGoodEnd
                or	a
                call	ShiftBitIn
                dec	a
                jr	ShiftGoodNxt
ShiftGoodEnd:	scf
                call	ShiftBitIn
                ld	a,(SecPtrPrt)
                inc	a
                ld	(SecPtrPrt),a		; try next sector
                ld	e,a
                cp	10
                jr	c,VrfNext
VrfEndTrack:	sub	e
VrfShiftNxt:	ret	z
                or	a
                call	ShiftBitIn
                dec	a
                jr	VrfShiftNxt

ShiftBitIn:	rr	b
                ret	nc
                ccf
                ld	(hl),b
                inc	hl
                ld	b,080H
                ret


fmtchgdat:	push	iy
                pop	hl
                ld	de,fmtbadlen+bgndatlen+6+1
                add	hl,de

                ld	b,9			; 9 sectors per track
                ld	de,secdatlen-4
fmtchgnxt:	ld	a,(ix+1)		; cylinder
                ld	(hl),a
                inc	hl
                inc	hl
                ld	a,(SidePrt)
                and	001h
                ld	(hl),a			; side
                inc	hl
                inc	hl
                ld	a,1+9
                sub	b
                ld	(hl),a			; sector
                add	hl,de
                djnz	fmtchgnxt
                ret

fmtinidat:	push	iy
                pop	hl
                ld	d,h
                ld	e,l
                inc	de
                ld	bc,fmtbadlen-1
                ld	(hl),0
                ldir				; init fmtbad area
                ld	hl,fmtdatbgn		; start of fmtdat area
                ld	bc,bgndatlen
                ldir

                ld	b,9
fmtininxt:	push	bc
                ld	hl,fmtdatsec
                ld	bc,secdatlen
                ldir
                pop	bc
                djnz	fmtininxt

                ld	hl,fmtdatend
                ld	bc,enddatlen
                ldir

                ret

fmtdatbgn:
                db	80	,04EH	; gap
                db	12	,000H	; gap
                db	3	,0F6H	; synchro
                db	1	,0FCH	; index id
                db	50	,04EH	; gap

bgndatlen	equ	$-fmtdatbgn

fmtdatsec:	db	12	,000H	; gap
                db	3	,0F5H	; synchro
                db	1	,0FEH	; record id
                db	1	,000H	; track
                db	1	,000H	; side
                db	1	,000H	; sector
                db	1	,002H	; len (512)
                db	1	,0F7H	; crc
                db	22	,04EH	; gap
                db	12	,000H	; gap
                db	3	,0F5H	; synchro
                db	1	,0FBH	; data id
                db	0	,0E5H	; data
                db	0	,0E5H	; data
                db	1	,0F7H	; crc
                db	54	,04EH	; gap

secdatlen	equ	$-fmtdatsec

fmtdatend:	db	0	,04EH	; gap
                db	0	,04EH	; gap
                db	0	,04EH	; gap

enddatlen	equ	$-fmtdatend


fmtbadlen	equ	1440/8
fmtdatlen	equ	bgndatlen+9*secdatlen+enddatlen


BootSector:
                .PHASE 0C000h

                db	0EBh,0FEh	; JMP 0100h (i8088)
                db	090h		; NOP (i8088)
                db	"SNYJX201"
                dw	512
                db	0
                dw	0
                db	0
                dw	0
                dw	0
                db	0
                dw	0
                dw	0
                dw	0
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
                jr	z,JmpDiskBasic		; yep, jump direct
DiskBootError:	ld	de,BootErrorTxt
                ld	c,09h
                call	0F37Dh
                ld	c,07h
                call	0F37Dh
                cp	3			; Ctrl-C ?
                jr	nz,BootAgain		; nop, boot again
JmpDiskBasic:	jp	04022h			; (re)start DiskBasic

BootErrorTxt:	db	"Boot error",13,10
                db	"Press any key for retry",13,10
                db	"$"

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
                db	0,0,0,0,0

StartFlag:	db	0

                .DEPHASE

BootLength	equ	$-BootSector



BootChgTbl:
                db	2
                dw	1
                db	2
                dw	112
                dw	720
                db	0F8h
                dw	2
                dw	9
                dw	1

                db	2
                dw	1
                db	2
                dw	112
                dw	1440
                db	0F9h
                dw	3
                dw	9
                dw	2

                db	2
                dw	1
                db	2
                dw	112
                dw	640
                db	0FAh
                dw	1
                dw	9
                dw	1

                db	2
                dw	1
                db	2
                dw	112
                dw	1280
                db	0FBh
                dw	2
                dw	9
                dw	2

                db	1
                dw	1
                db	2
                dw	64
                dw	360
                db	0FCh
                dw	2
                dw	9
                dw	1

                db	2
                dw	1
                db	2
                dw	112
                dw	720
                db	0FDh
                dw	2
                dw	9
                dw	2

                db	1
                dw	1
                db	2
                dw	64
                dw	320
                db	0FEh
                dw	1
                dw	9
                dw	1

                db	1
                dw	1
                db	2
                dw	112
                dw	640
                db	0FFh
                dw	1
                dw	9
                dw	2


; OEMSTATEMENT
;
; Input:	HL	basicpointer
; Output:	F	Cx set if statement not recognized
;			Cx reset if statement is recognized
;		HL	basicpointer,	updated if recognized
;					unchanged if not recognized
; Changed:	AF,BC,DE,HL,IX,IY may be affected

OEMSTA:
                push	hl
                ld	hl,PROCNM
                ld	de,verify
                ld	b,6
nxtsta:		ld	a,(de)
                cp	(hl)
                inc	de
                inc	hl
                jr	nz,quitsta
                djnz	nxtsta
skpsta:		ld	a,(hl)
                inc	hl
                cp	" "
                jr	z,skpsta
                cp	"O"
                jr	nz,quitsta
                ld	a,(hl)
                inc	hl
                cp	"F"
                jr	z,veroff
                sub	"N"
                or	(hl)
                jr	nz,quitsta
                dec	a
                jr	verset
veroff:		ld	a,(hl)
                inc	hl
                sub	"F"
                or	(hl)
                jr	nz,quitsta
verset:		ld	(RAWFLG),a
                pop	hl
                ret

verify:		db	"VERIFY"

quitsta:	pop	hl
                scf				; statement not recognized
                ret

; MTOFF
;
; Input:	None
; Output:	None
; Changed:	AF,BC,DE,HL,IX,IY may be affected

MTOFF:
                ld	a,03Fh			; motor off/not in use/drv 3 (unselect)
                ld	(DrivePrt),a
                ret


; End New Sony Diskdrive Driver Section


; Some technical information
;
; TMS 2793 NL	FDCS I/O addresses
;
; ComStsPrt
;	Command
;	000000ss	Select Track 00
;	000100ss	Track Select (Track in DataPrt)
;	010100ss	Track Increase
;	011100ss	Track Decrease (not used)
;	1000k0c0	Read sector data
;	1010k0c0	Write sector data
;	11010000	Terminate command
;	11110x00	Format track
;	Status bit
;	0		Command ready
;	1		DRQ/Index
;	2		Lost data/Track 00 selected
;	3		CRC error
;	4		Record not found/Seek error
;	5		Record type
;	6		Write protect
;	7		Not ready (no disk)
; TrkPtrPrt
;	Current Track
; SecPtrPrt
;	Selected Sector
; DataPrt
;	Dataport


; CXD 1032 Q	FLOPPY DISK CONTROL
;
; SidePrt (R/W)
;	bit 0 = side of disk (0 = side 0)
; DrivePrt (R/W)
;	bit 0 = drv b0
;	bit 1 = drv b1 (drive select 0-3)
;	bit 2 = (W) Disk Change Reset (0 = reset) NOT USED
;	bit 2 = (R) Disk Change (0 = changed)
;	bit 6 = IN USE pin (1 = IN USE)
;	bit 7 = motor on (1 = ON)
; IoStsPrt (R)
;	bit 6 = INTRQ
;	bit 7 = DRQ
