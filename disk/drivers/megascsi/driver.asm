; A driver section for MEGASCSI
;
;
;
                .Z80


; Used externals from system kernel (permited)
;
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
;
;		PUBLIC	MYSIZE
;		PUBLIC	SECLEN
;		PUBLIC	DEFDPB		; UltraSoft DRIVER routine

MYSIZE		equ	4		; Size of environment
SECLEN		equ	512		; Size of biggest sector

SCSIIC		equ	0
SCSIADR		equ	05FF0H
SCSIDAT		equ	04000H

SEL4000		equ	06000H
SEL6000		equ	06800H
SEL8000		equ	07000H
SELA000		equ	07800H

BNKSRAM		equ	32
BNK4000		equ	0
BNKNDRV		equ	1

                IF	DOS2 EQ 1

BNKADRV		equ	7

                ELSE

BNKADRV		equ	1

                ENDIF


YF33F		equ	0F33FH
DEVICE		equ	0FD99H
DRVINF		equ	0FB21H
DRVINT		equ	0FB29H
D$F2FD		equ	0F2FDH
H.RUNC		equ	0FECBH

;RAWFLG		equ	0F30Dh
;_SECBUF		equ	0F34Dh
;XFER		equ	0F36Eh
;DISINT		equ	0FFCFh
;ENAINT		equ	0FFD4h

;PROCNM		equ	0FD89H

I$7405:	DEFB	0F9H
        DEFW	512
        defb	00FH
        defb	004H
        defb	001H
        defb	002H
        defw	1
        defb	2
        defb	112
        defw	14
        defw	714
        defb	3
        defw	7

DEFDPB		equ	I$7405-1

;	  Subroutine get partitioninfo
;	     Inputs  ________________________
;	     Outputs ________________________

C.7417:	CALL	C$7460

;	  Subroutine get partitioninfo
;	     Inputs  ________________________
;	     Outputs ________________________

C.741A:	EXX
        LD	L,A			; driveid
        EX	AF,AF'
        ADD	HL,HL
        ADD	HL,HL
        ADD	HL,HL
        ADD	HL,HL			; * 16
        BIT	2,H			; DOS driveid (0-7) ?
        LD	H,HIGH I$7F00
        JR	Z,J$7428		; yep, use DOS partitions
        DEC	H			; driveid b6 set, use extended partitions
J$7428:	LD	A,(HL)
        PUSH	HL
        POP	IX			; pointer to partitionentry
        EXX
        SUB	0FFH
        RET	NC			; deviceid 0FFH, Cx reset, Zx set
        DEC	A			; deviceid 000H, Cx set, Zx set
        RET

C$7432:	EXX
        LD	C,A			; driveid
        EX	AF,AF'
        DI
        LD	A,2
        OUT	(99H),A
        LD	A,8FH
        OUT	(99H),A			; select status register 2
J$743E:	IN	A,(99H)			; read vdp status register 2
        AND	81H
        DEC	A
        JR	Z,J$743E
        XOR	A
        OUT	(99H),A
        LD	A,8FH
        OUT	(99H),A			; select status register 0
        LD	A,C
        ADD	A,LOW 07F8CH
        LD	C,A
J$7450:	LD	HL,(D$7FAA)
        CALL	C.74DD			; check if key combination pressed
        JR	Z,J$7461		; key pressed,
        EX	AF,AF'
        LD	B,HIGH 07F8CH
        LD	A,(BC)
        SET	6,A			; b6 set
        EXX
        EI
C$7460:	RET

J$7461:	IN	A,(0AAH)
        LD	L,A
J$7464:	CALL	C.7473
        JR	Z,J$7464
J$7469:	CALL	C.7473
        JR	NZ,J$7469
        LD	A,L
        OUT	(0AAH),A
        JR	J$7450

;	  Subroutine __________________________
;	     Inputs  ________________________
;	     Outputs ________________________

C.7473:	PUSH	HL
        LD	H,16			; 16 extended partitions
        LD	DE,I$7FB0
J$7479:	DJNZ	J$7479
J$747B:	PUSH	HL
        LD	A,(DE)
        LD	L,A
        CALL	C.74FE			; check if key pressed, wait until released
        JR	NZ,J$7499		; not pressed, next
        CALL	C.757E			; driver bank on 4000-5FFF
        LD	A,50H
        SUB	H
        LD	B,HIGH (I$7F00-2000H)
        LD	(BC),A
        ADD	A,A
        ADD	A,A
        ADD	A,A
        ADD	A,A
        LD	L,A
        LD	H,HIGH (I$7E00-2000H)
        INC	HL
        RES	7,(HL)			; disk changed
        CALL	C.79CB			; synch driver banks
J$7499:	POP	HL
        INC	DE
        DEC	H
        JR	NZ,J$747B		; next partition
        LD	L,74H			; 'R' key
        CALL	C.74B3			; change to R800 if key pressed
        LD	L,75H			; 'Z' key
        CALL	C.74B3			; change to Z80 if key pressed
        POP	HL
        INC	H
        LD	A,H
        AND	40H
        XOR	L
        OUT	(0AAH),A
        BIT	6,B
        RET

;	  Subroutine __________________________
;	     Inputs  ________________________
;	     Outputs ________________________

C.74B3:	CALL	C.74FE			; check if key pressed, wait until released
        RET	NZ			; not pressed, quit
        EX	AF,AF'
        PUSH	AF
        PUSH	BC
        LD	A,L
        CPL
        AND	81H
        EXX
        RST	30H
        DEFB	080H
        DEFW	0180H
        DI
        EXX
        POP	BC
        POP	AF
        EX	AF,AF'
        LD	B,HIGH (I$7F00-2000H)
        RET

;	  Subroutine lock/unlock bank
;	     Inputs  ________________________
;	     Outputs ________________________

C.74CB:	PUSH	HL
I$74CC:	LD	HL,I$7CDE		; workarea
        JR	C,J$74D5
        LD	(HL),1
        POP	HL
        RET

J$74D5:	SRA	(HL)
        POP	HL
        CCF
        RET	NC
        LD	A,6			; error
        RET

;	  Subroutine check if key combination pressed
;	     Inputs  ________________________
;	     Outputs ________________________

C.74DD:	CALL	C.74E2			; check if key1 pressed
        RET	NZ			; not pressed, quit
        LD	L,H			; check if key2 pressed

;	  Subroutine check if key pressed
;	     Inputs  L b3-b0=row, L b7-b4=col
;	     Outputs ________________________

C.74E2:	PUSH	HL
        LD	A,L
        AND	0FH
        LD	H,A
        IN	A,(0AAH)
        AND	0F0H
        OR	H
        OUT	(0AAH),A
        IN	A,(0A9H)
        LD	H,A
        LD	A,L
        RLCA
J$74F3:	RLC	H
        ADD	A,20H
        JR	NC,J$74F3
        XOR	H
        RRA
        SBC	A,A
        POP	HL
        RET

;	  Subroutine check if key pressed, wait until released
;	     Inputs  L b3-b0=row, L b7-b4=col
;	     Outputs ________________________

C.74FE:	CALL	C.74E2			; check if key pressed
        RET	NZ			; not pressed, quit
J$7502:	CALL	C.74E2
        JR	Z,J$7502		; wait util key is released
        XOR	A
        RET

;	  Subroutine select scsi device
;	     Inputs  ________________________
;	     Outputs ________________________

C.7509:	LD	A,(IX+0)
J$750C:	LD	(IY+4),0FFH		; interrupt reset
        LD	(IY+8),00H		; phase control
        OR	(IY+0)			; scsi id controller
        LD	(IY+11),A		; temporary
        LD	(IY+12),0FH
        LD	(IY+13),43H
        LD	(IY+14),04H		; transfer counter
        LD	(IY+2),20H		; command SELECT
J$752A:	LD	A,(IY+4)		; interrupt sense
        AND	14H
        JR	Z,J$752A		; not DONE or TIMEOUT, wait
        LD	(IY+4),0FFH		; interrupt reset
        CP	10H
        JR	NZ,J$7543		; not DONE without TIMEOUT,
J$7539:	LD	A,(IY+5)		; phase sense
        RLA
        JR	NC,J$7539		; wait for BUSREQ
        RRA
        AND	07H			; BUSMSG,BUSCD,BUSIO
        RET

J$7543:	XOR	A
        LD	(IY+2),A		; command BUS release
        LD	(IY+11),A
        LD	A,2
        SCF
        RET

;	  Subroutine __________________________
;	     Inputs  ________________________
;	     Outputs ________________________

C.754E:	XOR	A
J$754F:	BIT	3,(IY+5)
        JR	NZ,J$754F		; wait until BUSBSY reset
        BIT	5,(IY+4)
        LD	(IY+4),0FFH		; interrupt reset
        RET	NZ			; INTDISC, quit
        LD	(IY+11),A		; temporary
        LD	(IY+2),A		; command BUS release
        LD	A,0CH
        SCF
        RET

;	  Subroutine scsi bank on 4000-5FFF with lock
;	     Inputs  ________________________
;	     Outputs ________________________

C.7568:	SCF
        CALL	C.74CB			; lock bank
        RET	C			; already locked, quit

;	  Subroutine scsi bank on 4000-5FFF
;	     Inputs  ________________________
;	     Outputs ________________________

C.756D:	PUSH	AF
        LD	A,7FH
        LD	(SEL4000),A
        POP	AF
        LD	IY,SCSIADR
        RET

;	  Subroutine driver bank on 4000-5FFF with lock
;	     Inputs  ________________________
;	     Outputs ________________________

C.7579:	SCF
        CALL	C.74CB			; lock bank
        RET	C			; already locked, quit

;	  Subroutine driver bank on 4000-5FFF
;	     Inputs  ________________________
;	     Outputs ________________________

C.757E:	PUSH	AF
        LD	A,128+BNKNDRV
        LD	(SEL4000),A		; driver bank 4000-5FFF (write)
        POP	AF
        RET

;	  Subroutine adjust for sectorsize
;	     Inputs  ________________________
;	     Outputs ________________________

C.7586:	LD	A,B
        EXX
        LD	E,A			; number of sectors
        LD	B,(IX+8)
        LD	C,(IX+9)		; sectorsize
        LD	A,B
        SUB	02H
        OR	C
        LD	D,A
        EXX
        RET	Z			; sectorsize 512, quit
        EXX
        LD	A,B
        OR	C
        EXX
        LD	A,2
        SCF
        RET	Z			; sectorsize 0, quit with NOT READY error
        EXX
        LD	D,0
        LD	A,B
        DEC	A
        OR	C
        EXX
        LD	A,0AH
        SCF
        RET	NZ			; not 256, quit with UNSUPPORTED MEDIA error
        SLA	E
        RL	D
        RL	C			; sectornumber*2
        EXX
        SLA	E			; number of sectors*2
        XOR	A			; ok
        EXX
        RET

;	  Subroutine __________________________
;	     Inputs  ________________________
;	     Outputs ________________________

C$75B5:	LD	A,C
        PUSH	DE
        EXX
        POP	HL
        ADD	HL,DE
        ADC	A,D
        LD	D,A
        LD	A,(IX+7)
        SUB	L
        LD	A,(IX+6)
        SBC	A,H
        LD	A,(IX+5)
        SBC	A,D
        EXX
        LD	A,0CH	; 12
        RET	C
        LD	A,E
        ADD	A,(IX+4)
        LD	E,A
        LD	A,D
        ADC	A,(IX+3)
        LD	D,A
        LD	A,C
        ADC	A,(IX+2)
        LD	C,A
        XOR	A
        RET

;	  Subroutine reset scsi bus
;	     Inputs  ________________________
;	     Outputs ________________________

C.75DD:	XOR	A
        LD	(IY+4),0FFH		; interrupt sense
        LD	(IY+1),A		;
        LD	(IY+2),10H		; command BUS reset
J$75E9:	EX	(SP),HL
        EX	(SP),HL
        DEC	A
        JR	NZ,J$75E9		; wait
        LD	(IY+2),A		; command BUS release

;	  Subroutine reset scsi controller
;	     Inputs  ________________________
;	     Outputs ________________________

C$75F1:	LD	(IY+1),0D8H		; disable+reset+arb_ebl+par_ebl
        LD	A,(D$7F90)
        LD	(IY+0),A		; scsi id MEGASCSI
        XOR	A
        LD	(IY+2),A		; command BUS release
        LD	(IY+3),A		; clear transmit mode
        LD	(IY+8),A		; clear phase control
        LD	(IY+11),A		; clear temporary reg
        LD	(IY+12),A
        LD	(IY+13),A
        LD	(IY+14),A		; clear transmit counter
        LD	(IY+5),A		; clear diagnose control
        LD	(IY+1),18H		; enable+arb_ebl+par_ebl
        RET

;	  Subroutine read ramdisk sectors
;	     Inputs  ________________________
;	     Outputs ________________________

C.7619:	BIT	7,D
        JR	NZ,C.764C		; transfer to 8000-FFFF, read ramdisk sectors non switched
        EX	AF,AF'
        DEC	DE
        LD	A,D
        INC	DE
        CP	HIGH 3E00H
        PUSH	BC
        LD	B,1			; 1 sector
        JR	NC,J$7630		; transfer to 3E01-7FFF, switched
        EX	AF,AF'
        CALL	C.764C			; read ramdisk sector non switched
J$762C:	POP	BC
        DJNZ	C.7619			; next sector
        RET

J$7630:	EX	AF,AF'
        PUSH	DE
        LD	DE,(_SECBUF)
        CALL	C.764C			; read ramdisk sector in _SECBUF
        POP	DE
        PUSH	HL
        LD	B,HIGH 512		; 512 bytes
        LD	HL,(_SECBUF)
        CALL	C.79BE			; normal kernel bank on 4000-5FFF
        CALL	XFER			; transfer from _SECBUF
        LD	(SEL4000),A		; restore bank on 4000-5FFF
        POP	HL
        JR	J$762C			; continue

;	  Subroutine read ramdisk sectors non switched
;	     Inputs  ________________________
;	     Outputs ________________________

C.764C:	EX	AF,AF'
        LD	A,B
        LD	B,HIGH 512		; 512 bytes
I$7650:	CALL	C.7DC0			; copy
        LD	B,A
        EX	AF,AF'
        BIT	5,H			; end of bank reached ?
        JR	Z,J$765F
        LD	H,HIGH 4000H
        INC	A
        LD	(SEL4000),A		; yep, select next bank 4000-5FFF
J$765F:	DJNZ	C.764C
        RET

;	  Subroutine write ramdisk sectors
;	     Inputs  ________________________
;	     Outputs ________________________

C.7662:	BIT	7,H
        JR	NZ,C.7696		; transfer from 8000-FFFF, write ramdisk sectors non switched
        EX	AF,AF'
        DEC	HL
        LD	A,H
        INC	HL
        CP	HIGH 3E00H
        PUSH	BC
        JR	NC,J$7679		; transfer from 3E01-7FFF, switched
        EX	AF,AF'
        LD	B,1			; 1 sector
        CALL	C.7696			; write ramdisk sector non switched
J$7675:	POP	BC
        DJNZ	C.7662			; next sector
        RET

J$7679:	EX	AF,AF'
        PUSH	DE
        LD	B,HIGH 512		; 512 bytes
        LD	DE,(_SECBUF)
        CALL	C.79BE			; normal kernel bank on 4000-5FFF
        CALL	XFER			; transfer to _SECBUF
        LD	(SEL4000),A		; restore bank on 4000-5FFF
        POP	DE
        PUSH	HL
        INC	B			; 1 sector
        LD	HL,(_SECBUF)
        CALL	C.7696			; write ramdisk sector non switched
        POP	HL
        JR	J$7675			; continue

;	  Subroutine write ramdisk sectors non switched
;	     Inputs  ________________________
;	     Outputs ________________________

C.7696:	EX	AF,AF'
        LD	A,B
        LD	B,HIGH 512		; 512 bytes
I$769A:	CALL	C.7DC0			; copy
        LD	B,A
        EX	AF,AF'
        BIT	5,D			; end of bank reached ?
        JR	Z,J$76A9
        LD	D,HIGH 4000H
        INC	A
        LD	(SEL4000),A		; yep, select next bank 4000-5FFF
J$76A9:	DJNZ	C.7696			; next sector
        RET

;	  Subroutine read or write controller
;	     Inputs  HL = buffer, BC = size, D = phase
;	     Outputs ________________________

C.76AC:	OR	A
J$76AD:	LD	E,(HL)
        CALL	C.76BA
        RET	NC			;
        LD	(HL),E
        INC	HL
        DEC	BC
        LD	A,B
        OR	C
        JR	NZ,J$76AD
        RET

;	  Subroutine read or write byte controller
;	     Inputs  ________________________
;	     Outputs ________________________

C.76BA:	LD	A,(IY+5)		; phase sense
        BIT	3,A
        RET	Z			; BUSBSY reset, quit
        RLA
        JR	NC,C.76BA		; wait until BUSREQ
        RRA
        AND	07H
        XOR	D
        RET	NZ
        LD	(IY+8),D		; phase control
        BIT	0,D
        JR	NZ,J$76D8		; BUSIO,
        LD	(IY+11),E		; temporary
        LD	(IY+2),0E0H		; command ACKREQ_S
        JR	J.76DF

J$76D8:	LD	(IY+2),0E0H		; command ACKREQ_S
        LD	E,(IY+11)		; temporary
J.76DF:	BIT	7,(IY+5)
        JR	NZ,J.76DF		; wait until BUSREQ
        LD	(IY+2),0C0H		; command ACKREQ_C
        SCF
        RET

;	  Subroutine sector transfer
;	     Inputs  HL=transfer,D=phase,BC=sectorsize,E=number of sectors
;	     Outputs ________________________

C.76EB:	LD	A,(IY+5)		; phase sense
        RLA
        JR	NC,C.76EB		; wait for BUSREQ
        RRA
        AND	07H
        CP	D
        RET	NZ
        LD	(IY+4),0FFH		; interrupt reset
        LD	A,B
        SUB	02H
        OR	C
        JR	Z,J$7715		; 512,
        PUSH	HL
        LD	A,E
        LD	HL,0
J$7705:	ADD	HL,BC
        DEC	A
        JR	NZ,J$7705
        LD	(IY+12),A		; b23-b16=0
        LD	(IY+13),H
        LD	(IY+14),L		; transfer counter
        POP	HL
        JR	J$7720

J$7715:	LD	(IY+12),A		; b23-b16=0
        LD	(IY+14),A		; b7-b0=0
        LD	A,E
        ADD	A,A
        LD	(IY+13),A		; transfer counter
J$7720:	LD	(IY+8),D		; phase control
        LD	(IY+2),80H		; command XFER
        BIT	0,D
        LD	D,40H
        JR	Z,J$7743		; write
        EX	DE,HL
        CALL	C.7748			; read sector
        EX	DE,HL
J$7732:	RET	C
J$7733:	BIT	4,(IY+4)
        JR	Z,J$7733
J$7739:	LD	A,(IY+5)
        RLA
        JR	NC,J$7739
        RRA
        AND	07H
        RET

J$7743:	CALL	C.77B7			; write sector
        JR	J$7732

;	  Subroutine read sector
;	     Inputs  ________________________
;	     Outputs ________________________

C.7748:	BIT	7,D
        JR	NZ,C.7798		; transfer to 8000-FFFF, read sector without switching
        PUSH	HL
        LD	L,E
        LD	H,D
        ADD	HL,BC
        DEC	HL
        LD	A,H
        CP	40H
        JR	NC,J$7762		; transfer to 4000-7FFF, use switching
        LD	HL,SCSIDAT+1
        CALL	C.7798			; read sector without switching
J$775C:	POP	HL
        DEC	L
        RET	C			; error, quit
        JR	NZ,C.7748		; next sector
        RET

J$7762:	CALL	C.7767			; read sector with switching
        JR	J$775C			; continue

;	  Subroutine read sector with switching
;	     Inputs  ________________________
;	     Outputs ________________________

C.7767:	DEC	BC
        LD	A,B
        INC	BC
        CP	02H	; 2
        JR	C,C.777E
        DEC	B
        DEC	B
        CALL	C.7767
        PUSH	BC
        LD	BC,512
        CALL	NC,C.777E
        POP	BC
        INC	B
        INC	B
        RET

;	  Subroutine __________________________
;	     Inputs  ________________________
;	     Outputs ________________________

C.777E:	PUSH	DE
        LD	DE,(_SECBUF)
        LD	HL,SCSIDAT+1
        CALL	C.7798			; read sector without switching
        POP	DE
        CALL	C.79BE			; normal kernel bank on 4000-5FFF
        PUSH	BC
        LD	HL,(_SECBUF)
        CALL	XFER
        POP	BC
        JP	C.756D			; scsi bank on 4000-5FFF

;	  Subroutine read sector without switching
;	     Inputs  ________________________
;	     Outputs ________________________

C.7798:	BIT	0,(IY+6)
        JR	Z,J$77A9
        LD	A,(IY+4)
        AND	18H
        JR	Z,C.7798
        LD	A,4
        SCF
        RET

J$77A9:	LD	A,L
        PUSH	BC
I$77AB:	CALL	C.7DC0			; copy
        POP	BC
        DEC	A
        LD	L,A
        LD	H,40H
        JR	NZ,C.7798		; next sector
        XOR	A
        RET

;	  Subroutine write sector
;	     Inputs  ________________________
;	     Outputs ________________________

C.77B7:	BIT	7,H
        JR	NZ,C.7819		; 8000-FFFF, write sector without switching
        PUSH	HL
        ADD	HL,BC
        DEC	HL
        LD	A,H
        CP	40H
        POP	HL
        PUSH	DE
        JR	NC,J$77D0
        LD	E,1			; 1 sector
        CALL	C.7819			; write sector without switching
J$77CA:	POP	DE
        DEC	E
        RET	C			; error, quit
        JR	NZ,C.77B7		; next sector
        RET

J$77D0:	CALL	C.77D5
        JR	J$77CA

;	  Subroutine __________________________
;	     Inputs  ________________________
;	     Outputs ________________________

C.77D5:	DEC	BC
        LD	A,B
        INC	BC
        CP	02H
        JR	C,C.77EC		; size<512,
        DEC	B
        DEC	B			; size-512
        CALL	C.77D5
        PUSH	BC
        LD	BC,512
        CALL	NC,C.77EC
        POP	BC
        INC	B
        INC	B
        RET

;	  Subroutine __________________________
;	     Inputs  ________________________
;	     Outputs ________________________

C.77EC:	CALL	C.79BE			; normal kernel bank on 4000-5FFF
        PUSH	BC
        LD	DE,(_SECBUF)
        CALL	XFER			; transfer to _SECBUF
        POP	BC
        CALL	C.756D			; scsi bank on 4000-5FFF
        PUSH	HL
        LD	HL,-9
        ADD	HL,BC
        LD	DE,SCSIDAT+1
        LD	HL,(_SECBUF)
        JR	NC,J.780D
        CALL	C.7819			; write sector without switching
        POP	HL
        RET

J.780D:	BIT	1,(IY+6)
        JR	NZ,J.780D
        LD	A,C
        LDIR
        LD	C,A
        POP	HL
        RET

;	  Subroutine write sector without switching
;	     Inputs  ________________________
;	     Outputs ________________________

C.7819:	BIT	1,(IY+6)
        JR	Z,J$782A
        LD	A,(IY+4)
        AND	18H
        JR	Z,C.7819
        LD	A,4
        SCF
        RET

J$782A:	LD	A,E
        PUSH	BC
        LDI
        LDI
        LDI
        LDI
        LDI
        LDI
        LDI
        LDI
J$783C:	BIT	1,(IY+6)
        JR	Z,J$784F
        LD	E,A
        LD	A,(IY+4)
        AND	18H
        LD	A,E
        JR	Z,J$783C
        LD	A,4
        SCF
        RET

J$784F:	CALL	C.7DC0
        POP	BC
        DEC	A
        LD	E,A
        LD	D,40H
        JR	NZ,C.7819
        XOR	A
        RET


;	  Subroutine MEGASCSI DSKIO
;	     Inputs  ________________________
;	     Outputs ________________________

DSKIO:
        EI
        CALL	C.7417			; get partitioninfo

;
;	  Subroutine __________________________
;	     Inputs  ________________________
;	     Outputs ________________________
;
C$785F:	JR	NZ,J$78B7		; deviceid not 0 or 255, SCSI
        JR	NC,J.7886		; deviceid 255, ramdisk
        EX	AF,AF'
        LD	IX,4010H		; DSKIO of real FD
J$7868:	EX	AF,AF'
        PUSH	AF
        LD	A,(D$7F88)
        DEC	A
        CP	8FH			; valid slotid ?
        JR	C,J$7878		; yep, call that DSKIO
        POP	AF
        EX	AF,AF'
        LD	A,2			; not ready error
        SCF
        RET

J$7878:	EX	AF,AF'
        LD	A,0
        LD	IY,(D$7F88-1)
        CALL	001CH
        EX	AF,AF'
        POP	AF
        EX	AF,AF'
        RET

;	  Subroutine MEGASCSI RAMDISK DSKIO
;	     Inputs  ________________________
;	     Outputs ________________________

J.7886:	SCF
        CALL	C.74CB			; lock bank
        RET	C			; already locked, quit with error
        PUSH	HL
        EX	DE,HL
        ADD	HL,HL			; sectors are 512 bytes
        LD	A,L
        OR	40H
        AND	5FH
        LD	E,00H
        LD	D,A
        ADD	HL,HL
        ADD	HL,HL
        ADD	HL,HL
        LD	A,(D$7F9A)		; first RAMDISK bank
        OR	128			; write bit
        ADD	A,H			; banknummer
        LD	C,E
        LD	(SEL4000),A		; select bank 4000-5FFF
        POP	HL
        EX	AF,AF'
        JR	NC,J$78AD		; read
        EX	AF,AF'
        CALL	C.7662			; ramdisk sector write
        JR	J$78B3			; quit with ok

J$78AD:	EX	AF,AF'
        EX	DE,HL
        CALL	C.7619			; ramdisk sector read
        EX	DE,HL
J$78B3:	XOR	A
        JP	C.79B2			; normal kernel bank on 4000-5FFF and unlock

;	  Subroutine MEGASCSI SCSI DSKIO
;	     Inputs  ________________________
;	     Outputs ________________________

J$78B7:	BIT	7,C			; mediadescriptor ?
        JR	Z,J$78BD
        LD	C,0			; yep, b23-b16 sectornumber=0
J$78BD:	CALL	C.7586			; adjust for sectorsize
        RET	C			; invalid sectorsize, quit
J$78C1:	CALL	C$75B5			; validate sectornumber
        RET	C			; invalid, quit
        CALL	C.7568			; scsi bank on 4000-5FFF with lock
        RET	C			; locking error, quit
        EX	AF,AF'
        LD	A,(D$7F91)		; target scsi-id
        EXX
        LD	D,1			; phase DATA IN
        JR	NC,J.78DF		; read
        DEC	D			; phase DATA OUT
        BIT	6,(IX+1)		; write protected partition ?
        JR	Z,J.78DF		; nope, continue
        EXX
        LD	A,0			; write protect error
J$78DC:	JP	C.79B2			; normal kernel bank on 4000-5FFF and unlock

J.78DF:	EXX
J$78E0:	EX	AF,AF'
        CALL	C.7509			; select scsi device
        JR	C,J$78DC		; error, quit
        XOR	A
        XOR	A
        LD	(IY+12),A
        LD	(IY+13),A
        LD	(IY+14),10		; 10 bytes
        LD	(IY+8),02H		; phase control
        LD	(IY+2),84H
        EX	AF,AF'
        JR	NC,J$7903		; read
        LD	(IY+10),2AH		; SCSI command WRITE(10)
        JR	J$7907

J$7903:	LD	(IY+10),28H		; SCSI command READ(10)
J$7907:	EX	AF,AF'
        LD	(IY+10),A		; logical unit 0
        LD	(IY+10),A		; b31-b24 LBA = 0
        LD	(IY+10),C		; b23-b16 LBA
        LD	(IY+10),D		; b15-b8 LBA
        LD	(IY+10),E		; b7-b0 LBA
        LD	(IY+10),A		; reserved = 0
        PUSH	HL
        EXX
        POP	HL
        PUSH	DE
        LD	(IY+10),A		; b15-b8 length = 0
J$7921:	BIT	0,(IY+6)
        JR	Z,J$7921
        LD	(IY+10),E		; b7-b0 length = number of sectors
        LD	(IY+10),A		; control = 0
J$792D:	BIT	4,(IY+4)
        JR	Z,J$792D
        CALL	C.76EB			; sector transfer
        LD	D,3			; phase STATUS
        CALL	C.76BA			; read byte controller
        LD	L,E
        LD	D,7			; phase MESSAGE IN
        CALL	C.76BA			; read byte controller
        CALL	C.754E			; scsi bus release
        POP	DE
        LD	A,L
        OR	A
        EXX
        JR	NZ,J$794D		; status <> GOOD,
        LD	B,A
        JR	C.79B2			; normal kernel bank on 4000-5FFF and unlock

J$794D:	CP	18H			; status RESERVATION CONFLICT ?
        LD	A,8
        SCF
        JR	Z,C.79B2		; yep, normal kernel bank on 4000-5FFF and unlock
        EX	AF,AF'
        DEC	A
        JP	P,J$78E0
        CALL	C.7509			; select scsi device
        JR	C,C.79B2		; normal kernel bank on 4000-5FFF and unlock
        XOR	A
        LD	(IY+12),A
        LD	(IY+13),A
        LD	(IY+14),6		; 6 bytes
        LD	(IY+8),02H		; phase control
        LD	(IY+2),84H
        LD	(IY+10),3		; SCSI command REQUEST SENSE
        LD	(IY+10),A		; logical unit 0
        LD	(IY+10),A		; b15-b8 LBA = 0
        LD	(IY+10),A		; b7-b0 LBA = 0
        LD	(IY+10),4		; length = 4
        LD	(IY+10),A		; control = 0
J$7985:	BIT	4,(IY+4)
        JR	Z,J$7985
        LD	D,1			; phase DATA IN
        CALL	C.76BA			; read byte controller
        CALL	C.76BA			; read byte controller
        CALL	C.76BA			; read byte controller
        LD	A,E
        PUSH	AF
        CALL	C.76BA			; read byte controller
        LD	D,3			; phase STATUS
        CALL	C.76BA			; read byte controller
        LD	D,7			; phase MESSAGE IN
        CALL	C.76BA			; read byte controller
        CALL	C.754E			; scsi bus release
        POP	AF
        CP	07H			; sense key DATA PROTECT ?
        LD	A,0
        SCF
        JR	Z,C.79B2		; yep, normal kernel bank on 4000-5FFF and unlock
        LD	A,2
;
;	  Subroutine normal kernel bank on 4000-5FFF and unlock
;	     Inputs  ________________________
;	     Outputs ________________________
;
C.79B2:	PUSH	AF
        LD	A,BNK4000
        LD	(SEL4000),A		; normal kernel bank 4000-5FFF (read)
        XOR	A
        CALL	C.74CB			; free bank
        POP	AF
        RET

;	  Subroutine normal kernel bank on 4000-5FFF
;	     Inputs  ________________________
;	     Outputs ________________________

C.79BE:	PUSH	AF
?.79BF:	LD	A,BNK4000
        LD	(SEL4000),A		; normal kernel bank 4000-5FFF (read)
        POP	AF
        RET

;	  Subroutine synch driver banks and unlock
;	     Inputs  ________________________
;	     Outputs ________________________

C.79C6:	CALL	C.79CB			; synch driver banks
        JR	C.79B2			; normal kernel bank on 4000-5FFF and unlock

;	  Subroutine synch driver banks
;	     Inputs  ________________________
;	     Outputs ________________________

C.79CB:	PUSH	AF
        PUSH	BC
        PUSH	DE
        PUSH	HL
?.79CF:	LD	A,128+BNKADRV
        LD	(SEL4000),A		; alternate driver bank 4000-5FFF (write)
        LD	BC,01CDH
        LD	DE,I$7E00-2000H
        LD	HL,I$7E00
        LDIR				; synch 07E00-07FCC
        POP	HL
        POP	DE
        POP	BC
        POP	AF
        JR	C.79BE			; normal kernel bank on 4000-5FFF

;	  Subroutine MEGASCSI DSKCHG
;	     Inputs  ________________________
;	     Outputs ________________________

DSKCHG:
?.79E5:	EI
        CALL	C.7417			; get partitioninfo
J$79E9:	PUSH	HL
        CALL	C,C$7A28		; SCSI or FD emulation, update diskchange flag
        POP	DE
        LD	B,0
        RET	C			; error, quit (diskchange unknown)
        INC	B
        BIT	7,(IX+1)		; disk changed flag ?
        RET	NZ			; no, quit with disk unchanged status
        LD	A,(IX+0)
        DEC	A
        CP	0FEH
        JR	NC,J$7A06		; ramdisk or FD emulation, skip id check
        INC	A
J$7A00:	RRCA
        JR	NC,J$7A00
        ADD	A,A			; a valid scsi id has only 1 bit set!
        JR	NZ,J$7A16		; invalid scsi id,leave disk change flag on
J$7A06:	CALL	C.7579			; driver bank on 4000-5FFF with lock
        DEC	B
        RET	C			; error, quit (diskchange unknown)
        PUSH	IX
        POP	HL
        INC	HL
        RES	5,H			; pointer to 4000-5FFF area
        SET	7,(HL)			; reset flag disk changed
        CALL	C.79C6			; synch driver banks and unlock
J$7A16:	EX	AF,AF'
        EX	DE,HL
        OR	A
        CALL	C.741A			; get partitioninfo
        CALL	C$7A97			; GETDPB
        LD	B,0FFH
        RET	NC			; no error, quit with disk changed status
        CP	0AH
        RET	Z			; UNSUPPORTED MEDIA error, quit with disk changed status
        SCF
        INC	B			; error, quit with error and (diskchange unknown)
        RET

;	  Subroutine __________________________
;	     Inputs  ________________________
;	     Outputs ________________________

C$7A28:	JR	NZ,J$7A31		; SCSI,
        LD	IX,4013H
        JP	J$7868			; DSKCHG of real FD

J$7A31:	CALL	C.7568			; scsi bank on 4000-5FFF with lock
        RET	C			; locking error, quit
        CALL	C.7509			; select scsi device
        JP	C,C.79B2		; error, normal kernel bank on 4000-5FFF and unlock
        LD	HL,SCSIDAT
        LD	(IY+12),L
        LD	(IY+13),L
        LD	(IY+14),6		; 6 bytes
        LD	(IY+8),02H		; phase control
        LD	(IY+2),80H		; command XFER
        LD	(HL),L			; SCSI command TEST UNIT READY
        LD	(HL),L			; logical unit = 0
        LD	(HL),L			; reserved = 0
        LD	(HL),L			; reserved = 0
        LD	(HL),L			; reserved = 0
        LD	(HL),L			; control = 0
J$7A56:	BIT	4,(IY+4)
        JR	Z,J$7A56
        LD	D,3			; phase STATUS
        CALL	C.76BA			; read or write byte controller
        LD	H,E			; save status byte
        LD	D,7			; phase MESSAGE IN
        CALL	C.76BA			; read or write byte controller
        CALL	C.754E			; scsi bus release
        CALL	C.79B2			; normal kernel bank on 4000-5FFF and unlock
        LD	A,H
        OR	A			; status GOOD ?
        RET	Z			; yep, quit with no error
        CP	18H			; status RESERVATION CONFLICT ?
        LD	A,8
        SCF
        RET	Z			; yep, return RESERVATION CONFLICT error
        CALL	C.7579			; driver bank on 4000-5FFF with lock
        RET	C			; locking error, quit
        LD	B,16+8
        LD	DE,16-1
        LD	HL,I$7E00-2000H
        LD	A,(IX)
J$7A85:	CP	(HL)			; partition on this scsi device ?
        INC	HL
        JR	NZ,J$7A8B		; nope, skip
        RES	7,(HL)			; disk changed
J$7A8B:	ADD	HL,DE
        DJNZ	J$7A85			; next partition
        XOR	A
        JP	C.79C6			; synch driver banks and unlock

;	  Subroutine MEGASCSI GETDPB
;	     Inputs  ________________________
;	     Outputs ________________________

GETDPB:
?.7A92:	EI
        OR	A
        CALL	C.7417			; get partitioninfo

;	  Subroutine __________________________
;	     Inputs  ________________________
;	     Outputs ________________________

C$7A97:	PUSH	HL
        LD	HL,(_SECBUF)
        LD	DE,0			; sector 0
        LD	BC,01FFH		; 1 sector, mediadescriptor 0FFH
        CALL	C$785F			; DSKIO
        POP	HL
        RET	C			; error, quit
        LD	IY,(_SECBUF)
        INC	HL
        PUSH	HL
        LD	BC,18
        EX	DE,HL
        LD	HL,I$7405
        LDIR
        POP	HL			; first copy default DPB
        LD	A,(IY+21)
        CP	0F9H			; mediadescriptor 0F9H ?
        RET	Z			; yep, quit ok
        LD	(HL),A			; mediadescriptor
        INC	HL
        LD	A,(IY+11)
        LD	(HL),A
        INC	HL
        LD	A,(IY+12)
        LD	(HL),A			; number of bytes per sector
        INC	HL
        LD	(HL),0FH		; dirmask (always 16 entries per sector)
        INC	HL
        LD	(HL),04H		; dirshift
        INC	HL
        LD	A,(IY+13)		; sectors per cluster
        DEC	A
        LD	(HL),A			; clustermask
        INC	HL
        ADD	A,1
        LD	B,0
J$7AD8:	INC	B
        RRA
        JR	NC,J$7AD8
        LD	(HL),B			; clustershift
        INC	HL
        PUSH	BC
        LD	A,(IY+14)
        LD	(HL),A
        INC	HL
        LD	D,(IY+15)
        LD	(HL),D			; first FAT sector
        INC	HL
        LD	B,(IY+16)
        LD	(HL),B			; number of FATs
        INC	HL
J$7AEE:	ADD	A,(IY+22)		; sectors per FAT
        JR	NC,J$7AF4
        INC	D
J$7AF4:	DJNZ	J$7AEE
        LD	C,A
        LD	B,D			; first directory sector
        LD	E,(IY+17)
        LD	D,(IY+18)		; number of rootdirectory entries
        LD	A,D
        OR	A
        LD	A,254
        JR	NZ,J$7B05		; >255, use only 254
        LD	A,E
J$7B05:	LD	(HL),A			; number of direntries
        INC	HL
        DEC	DE
        LD	A,4
J$7B0A:	SRL	D
        RR	E
        DEC	A
        JR	NZ,J$7B0A
        INC	DE			; number of dirsectors
        EX	DE,HL
        ADD	HL,BC
        EX	DE,HL
        LD	(HL),E
        INC	HL
        LD	(HL),D			; first datasector
        INC	HL
        LD	A,(IY+19)
        SUB	E
        LD	E,A
        LD	A,(IY+20)
        SBC	A,D
        LD	D,A			; number of datasectors
        POP	AF
J$7B24:	DEC	A
        JR	Z,J$7B2D
        SRL	D
        RR	E
        JR	J$7B24

J$7B2D:	INC	DE			; number of clusters+1
        LD	(HL),E
        INC	HL
        LD	(HL),D
        INC	HL
        LD	A,(IY+22)
        LD	(HL),A			; number of sectors per FAT
        INC	HL
        LD	(HL),C
        INC	HL
        LD	(HL),B			; first directorysector
        XOR	A
        RET

;	  Subroutine MEGASCSI CHOICE
;	     Inputs  ________________________
;	     Outputs ________________________

CHOICE:
?.7B3C:	CALL	C.7417			; get partitioninfo
        LD	HL,0
        RET	NC			; ramdisk, no choice string
        LD	HL,I$7B48		; empty choice string (format invalid)
        XOR	A
        RET

I$7B48:	DEFB	0
        DEFB	"SCSI5FF0"
        DEFB	0

;	  Subroutine MEGASCSI DSKFMT
;	     Inputs  ________________________
;	     Outputs ________________________

DSKFMT:
J$7B52:	LD	A,10H			; write fault error
        SCF
        RET

;	  Subroutine MEGASCSI INIHRD
;	     Inputs  ________________________
;	     Outputs ________________________

INIHRD:
?.7B56:	LD	HL,(D$7FA2)
        CALL	C.74DD			; check if key combination pressed
        JR	NZ,J$7B60		; no, continue
        POP	AF			; abort MEGASCSI interface
        RET

J$7B60:
        IF	SCSIIC EQ 1

        CALL	C.756D			; scsi bank on 4000-5FFF
        CALL	C$75F1			; reset scsi controller
        LD	HL,(D$7FA4)
        CALL	C.74DD			; check if key combination pressed
        CALL	Z,C.75DD		; yep, reset scsi bus
        CALL	C.79BE			; normal kernel bank on 4000-5FFF

        ENDIF

        CALL	C.757E			; driver bank on 4000-5FFF
        LD	HL,(D$7FA0)
        CALL	C.74DD
        JR	NZ,J$7B99		; not pressed,
        LD	HL,I$7E00-2000H
        LD	DE,I$7E00-2000H+1
        LD	BC,0197H
        LD	(HL),L
        LDIR				; clear
        LD	A,0FFH
        LD	(I$7F00-2000H),A	; only 1 partition (on the ramdisk)
        LD	A,1
        LD	(D$7F80-2000H),A	; 1 drive
        LD	HL,0307H
        LD	(D$7F90-2000H),HL	; host controller scsi id 7, default device scsi id 3
J$7B99:	LD	B,16+8
        LD	DE,16-1
        LD	HL,I$7E00-2000H
J$7BA1:	LD	A,(HL)
        INC	HL
        OR	A
        JR	Z,J$7BA8
        SET	7,(HL)			; ramdisk or SCSI partition, clear disk changed flag
J$7BA8:	ADD	HL,DE
        DJNZ	J$7BA1			; next partition
        LD	HL,(D$7FA8)
        CALL	C.74DD			; check if key combination pressed
        JR	NZ,J$7BB6		; not pressed
        LD	(D$7F88-2000H),A	; disable FD emulation
J$7BB6:	LD	A,(D$7F88)
        CP	0FEH
        JR	NZ,J$7BBE
        POP	AF			; abort MEGASCSI
J$7BBE:	JP	C.79CB			; synch driver banks

;	  Subroutine MEGASCSI DRIVES
;	     Inputs  ________________________
;	     Outputs ________________________

DRIVES:
?.7BC1:	PUSH	AF
        PUSH	BC
        PUSH	DE
        CALL	ADJRUN
        CALL	GETWRK			; GETWRK
?.7BC7:	LD	A,128+BNKNDRV
        CALL	C.7C05			; update driver bank 4000-5FFF (write)
?.7BCC:	LD	A,128+BNKADRV
        CALL	C.7C05			; update alternate driver bank 4000-5FFF (write)
        LD	(HL),1			; not locked
        INC	HL
        LD	(HL),0EDH		; LDIR RET
        INC	HL
        LD	(HL),0B0H
        INC	HL
        LD	(HL),0C9H		; initialize workarea
        LD	A,(D$7F99)		; first non kernel bank
        LD	(SEL8000),A		; select bank 8000-9FFF
        INC	A			; +1
        LD	(SELA000),A		; select bank A000-BFFF
        LD	A,(D$7F88)
        OR	A
        JR	NZ,J$7BF9		; FD emulation, do not initialize further
        LD	HL,(D$7FA6)
        CALL	C.74DD			; check if key combination pressed
        AND	02H
        LD	(YF33F),A		; set phantom drive flag
        JR	J$7BFE

J$7BF9:	LD	HL,DEVICE
        INC	(HL)			; interface count+1
        POP	DE			; but abort the initialization of drivervars
J$7BFE:	LD	HL,(D$7F80)
        POP	DE
        POP	BC
        POP	AF
        RET

;	  Subroutine __________________________
;	     Inputs  ________________________
;	     Outputs ________________________

C.7C05:	LD	(SEL4000),A		; select bank 4000-5FFF
        PUSH	HL
        LD	(I$74CC+1-02000H),HL	; lock flag in workarea
        INC	HL
        LD	(I$7650+1-02000H),HL
        LD	(I$769A+1-02000H),HL
        LD	(I$77AB+1-02000H),HL
        LD	(J$784F+1-02000H),HL	; ldir routine in workarea
        LD	A,(D$7F88)
        OR	A
        LD	HL,C$7432		; FD emulation handler
        JR	NZ,J$7C30		; FD emulation
        LD	C,16*16-1
        LD	DE,I$7E00-02000H+1
        LD	HL,I$7E00-02000H
        LD	(HL),L
        LDIR				; clear extended partition entries
        LD	HL,C$7460		; disable FD emulation handler
J$7C30:	LD	(C.7417-02000H+1),HL
        POP	HL
        JP	C.79BE			; normal kernel bank on 4000-5FFF

INIENV:
        RET				; does nothing

OEMSTA:
        SCF				; does not have extra CALL statements
        RET

MTOFF:
        RET				; does nothing

ADJRUN:
        CALL	GETSLT
        LD	HL,H.RUNC+1
        CP	(HL)
        RET	NZ			; my kernel does not do the init, quit
        INC	HL
        LD	A,(HL)
        LD	(J.7C63+1),A
        LD	(HL),LOW C$7C37
        INC	HL
        LD	A,(HL)
        LD	(J.7C63+2),A
        LD	(HL),HIGH C$7C37
        RET


;	  Subroutine MEGASCSI H.RUNC
;	     Inputs  ________________________
;	     Outputs ________________________

C$7C37:	LD	A,(D$7F88)
        OR	A
        JR	Z,J$7C5A		; no FD emulation,
        CALL	C.757E			; driver bank on 4000-5FFF
        LD	A,(DRVTBL+0*2+1)
        LD	(D$7F88-2000H),A	; slotid first diskinterface
        CALL	C.79CB			; synch driver banks
        CALL	GETSLT			; get my slotid
        LD	(DRVTBL+0*2+1),A	; MEGASCSI the first diskinterface
        LD	(DRVINT+1*3+0),A
        LD	HL,I$7FDA
        LD	(DRVINT+1*3+1),HL	; MEGASCSI interrupt handler in second entry
        JR	J.7C63			; quit

J$7C5A:	LD	A,(D$7F81)
        OR	A
        JR	Z,J.7C63		; no bootdrive specified
        LD	(D$F2FD),A		; specify bootdrive
J.7C63:	JP	0			; orginal H.RUNC

;	  Subroutine MEGASCSI BIOS entrypoint
;	     Inputs  ________________________
;	     Outputs ________________________

J$7C66:	PUSH	HL
        PUSH	AF
        LD	HL,I$7C7E		; function table
J$7C6B:	SUB	(HL)
        INC	HL
        JR	C,J.7C73
        INC	HL
J$7C70:	INC	HL
        JR	J$7C6B

J.7C73:	LD	A,(HL)
        INC	HL
        LD	H,(HL)
        LD	L,A
        POP	AF
        EX	(SP),HL
        LD	IY,SCSIADR		; SCSI controller base adres
        RET

I$7C7E:	DEFB	8
        DEFW	?.7CE4			; 00H-07H sector read/write dos drive
        DEFB	8
        DEFW	I.7CE1			; 08H-0FH invalid function
        DEFB	8
        DEFW	?.7CF0			; 10H-17H check disk change dos drive
        DEFB	028H
        DEFW	I.7CE1			; 18H-3FH invalid function
        DEFB	16
        DEFW	?.7CE4			; 40H-4FH sector read/write extended partition
        DEFB	16
        DEFW	?.7CF0			; 50H-5FH check disk change extended partition
        DEFB	020H
        DEFW	I.7CE1			; 60H-7FH invalid function
        DEFB	4
        DEFW	?.7CF6			; 80H-83H create/free partition
        DEFB	4
        DEFW	?.7D23			; 84H-87H read/write partition table
        DEFB	018H
        DEFW	I.7CE1			; 88H-9FH invalid function
        DEFB	1
        DEFW	I$7D44			; A0H (get ESE info)
        DEFB	1
        DEFW	I.7CE1			; A1H invalid function
        DEFB	2
        DEFW	?.7D4B			; A2H-A3H (read/write ?)
        DEFB	2
        DEFW	?.7D52			; A4H-A5H read/write SRAM capacity
        DEFB	2
        DEFW	?.7D59			; A6H-A7H (read/write ?)
        DEFB	2
        DEFW	?.7D60			; A8H-A9H (read/write ?)
        DEFB	2
        DEFW	?.7D67			; AAH-ABH (read/write ?)
        DEFB	014H
        DEFW	I.7CE1			; ACH-BFH invalid function
        DEFB	1
        DEFW	I$7D6E			; C0H SCSI command handler
        DEFB	1
        DEFW	C.75DD			; C1H SCSI bus reset
        DEFB	1
        DEFW	I.7CE1			; C2H invalid function
        DEFB	1
        DEFW	C.74CB			; C3H (free/lock bank)
        DEFB	1
        DEFW	C.79B2			; C4H (normal kernel bank on 4000-5FFF and unlock)
        DEFB	1
        DEFW	C.79BE			; C5H (normal kernel bank on 4000-5FFF)
        DEFB	1
        DEFW	C.7568			; C6H (scsi bank on 4000-5FFF with lock)
        DEFB	1
        DEFW	C.756D			; C7H (scsi bank on 4000-5FFF)
        DEFB	1
        DEFW	I$7DB0			; C8H SCSI device select
        DEFB	1
        DEFW	C.754E			; C9H SCSI bus release
        DEFB	1
        DEFW	I$7DB4			; CAH SCSI ATN start
        DEFB	1
        DEFW	I$7DBA			; CBH SCSI ATN cancel
        DEFB	1
        DEFW	C.76AC			; CCH SCSI read/write controller
        DEFB	1
        DEFW	C.76EB			; CDH SCSI sector transfer
I$7CDE:	DEFB	0FFH
        DEFW	I.7CE1			; CEH-FFH invalid function

I.7CE1:	SCF
        SBC	A,A			; A=FF, Cx set
        RET

;	  Subroutine MEGASCSI sector read/write
;	     Inputs  ________________________
;	     Outputs ________________________

?.7CE4:	CALL	C.741A			; get partitioninfo
        JP	NC,J.7886		; ramdisk,
        CALL	C.7586			; adjust for sectorsize
        JP	J$78C1

;	  Subroutine MEGASCSI check diskchange
;	     Inputs  ________________________
;	     Outputs ________________________

?.7CF0:	CALL	C.741A			; get partitioninfo
        JP	J$79E9

;	  Subroutine MEGASCSI create/free partition
;	     Inputs  ________________________
;	     Outputs ________________________

?.7CF6:	RRA
        JR	C,J$7D1F		; free partition,
        PUSH	HL
        RRA
        LD	BC,00800H		; 8 dos partitions
        LD	DE,16
        LD	HL,I$7F00
        JR	NC,J.7D09		; DOS partition,
        SLA	B			; 16 extended partitions
        DEC	H			; 07E00H
J.7D09:	LD	A,(HL)
        OR	A			; entry free ?
        JR	Z,J$7D16		; yep, use it
        ADD	HL,DE
        INC	C
        DJNZ	J.7D09			; next
        POP	HL
        LD	A,0CH
        SCF				; error, no partition entry free
        RET

J$7D16:	POP	DE
        RES	5,H			; 7F00->5F00,7E00->5E00
        PUSH	BC
        CALL	C$7D32			; write partition entry
        POP	BC
        RET

J$7D1F:	LD	HL,I$7FC0		; empty partition entry
        RLA				; write

;	  Subroutine MEGASCSI read/write partition
;	     Inputs  ________________________
;	     Outputs ________________________

?.7D23:	LD	D,HIGH 05F00H		; 05F00H
        BIT	1,A
        JR	Z,J$7D2A		; DOS partition,
        DEC	D			; 05E00H
J$7D2A:	LD	B,A
        LD	A,C			; partitionnumber
        ADD	A,A
        ADD	A,A
        ADD	A,A
        ADD	A,A
        LD	E,A			; 16 bytes entries
        LD	A,B

;	  Subroutine write partition entry
;	     Inputs  ________________________
;	     Outputs ________________________

C$7D32:	LD	C,16
J.7D34:	LD	B,0
        RRA
        JR	C,J$7D3A		; write
        EX	DE,HL			; read
J$7D3A:	CALL	C.7579			; driver bank on 4000-5FFF with lock
        RET	C			; locking error, quit
        LDIR				; copy
        XOR	A
        JP	C.79C6			; synch driver banks and unlock

;	  Subroutine MEGASCSI (get ESE info)
;	     Inputs  ________________________
;	     Outputs ________________________

I$7D44:	XOR	A
        LD	A,0+2*SCSIIC		; ESE type
        LD	BC,0215H		; BIOS version
        RET

;	  Subroutine MEGASCSI (read/write scsi id's)
;	     Inputs  ________________________
;	     Outputs ________________________

?.7D4B:	LD	C,2
        LD	DE,D$7F90-2000H
        JR	J.7D34

;	  Subroutine MEGASCSI (read/write SRAM capacity)
;	     Inputs  ________________________
;	     Outputs ________________________

?.7D52:	LD	C,4
        LD	DE,D$7F98-2000H
        JR	J.7D34

;	  Subroutine MEGASCSI (read/write drive config)
;	     Inputs  ________________________
;	     Outputs ________________________

?.7D59:	LD	C,8
        LD	DE,D$7F80-2000H
        JR	J.7D34

;	  Subroutine MEGASCSI (read/write fd emulator config)
;	     Inputs  ________________________
;	     Outputs ________________________

?.7D60:	LD	C,8
        LD	DE,D$7F88-2000H
        JR	J.7D34

;	  Subroutine MEGASCSI (read/write key config)
;	     Inputs  ________________________
;	     Outputs ________________________

?.7D67:	LD	C,12
        LD	DE,D$7FA0-2000H
        JR	J.7D34

;	  Subroutine MEGASCSI SCSI command handler
;	     Inputs  ________________________
;	     Outputs ________________________

I$7D6E:	PUSH	HL
        POP	IX
        CALL	C.7568			; scsi bank on 4000-5FFF with lock
        RET	C
        CALL	C.7509			; select scsi device
        JR	C,J$7DAD		; error,
        LD	BC,0
        LD	D,2			; phase COMMAND
        LD	L,(IX+2)
        LD	H,(IX+3)		; command descriptor block buffer
        CALL	C.76AC			; write controller
        AND	01H
        LD	D,A			; phase DATA OUT/DATA IN
        LD	L,(IX+4)
        LD	H,(IX+5)		; data transfer buffer
        CALL	C.76AC			; read/write controller
        LD	D,3			; phase STATUS
        LD	L,(IX+6)
        LD	H,(IX+7)		; status byte buffer
        CALL	C.76AC			; read controller
        LD	D,7			; phase MESSAGE IN
        LD	L,(IX+8)
        LD	H,(IX+9)		; message buffer
        CALL	C.76AC			; read controller
        CALL	C.754E			; scsi bus release
J$7DAD:	JP	C.79B2			; normal kernel bank on 4000-5FFF and unlock

I$7DB0:	LD	A,C
        JP	J$750C			; select scsi device

I$7DB4:	LD	(IY+2),60H		; command ATN start
        XOR	A
        RET

I$7DBA:	LD	(IY+2),40H		; command ATN cancel
        XOR	A
        RET

;	  Subroutine __________________________
;	     Inputs  ________________________
;	     Outputs ________________________

C.7DC0:	LDIR
        RET


        defs	07E00H-$,0


I$7E00:	DEFB	0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0
        DEFB	0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0
        DEFB	0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0
        DEFB	0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0
        DEFB	0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0
        DEFB	0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0
        DEFB	0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0
        DEFB	0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0
        DEFB	0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0
        DEFB	0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0
        DEFB	0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0
        DEFB	0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0
        DEFB	0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0
        DEFB	0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0
        DEFB	0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0
        DEFB	0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0

I$7F00:	DEFB	255,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0
        DEFB	0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0
        DEFB	0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0
        DEFB	0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0
        DEFB	0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0
        DEFB	0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0
        DEFB	0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0
        DEFB	0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0

D$7F80:	DEFB	1
D$7F81:	DEFB	0
        DEFB	0,0,0,0,0,0
D$7F88:	DEFB	0,0,0,0,0,0,0,0
D$7F90:	DEFB	7
D$7F91:	DEFB	3
        DEFB	0,0,0,0,0,0
D$7F98:	DEFB	BNKSRAM
D$7F99:	DEFB	BNKADRV+1
D$7F9A:	DEFB	BNKADRV+1
        DEFB	0

        DEFB	0,0,0,0

D$7FA0:	DEFB	026H,027H		; reset config  = GRAPH+ESC
D$7FA2:	DEFB	026H,038H		; skip megascsi = GRAPH+DEL
D$7FA4:	DEFB	026H,037H		; reset scsibus = GRAPH+TAB
D$7FA6:	DEFB	016H,016H		; phantom drive = CTRL
D$7FA8:	DEFB	026H,028H		; emul fd dis   = GRAPH+INS
D$7FAA:	DEFB	046H,046H		; emul fd chg   = CODE

                DEFB	0,0,0,0

I$7FB0:		DEFB	039H
                DEFB	049H
                DEFB	059H
                DEFB	069H
                DEFB	079H
                DEFB	00AH
                DEFB	01AH
                DEFB	02AH
                DEFB	03AH
                DEFB	04AH
                DEFB	07AH
                DEFB	06AH
                DEFB	019H
                DEFB	05AH
                DEFB	009H
                DEFB	029H

                defs	07FC0H-$,0

I$7FC0:		defb	0,0,0,0,0,0,0,0,0,0,0,0

?.7FCC:		EI
                JP	J$7C66

?.7FD0:		PUSH	AF
                ADD	A,A
                LD	(SEL4000),A
                INC	A
                LD	(SEL6000),A
                POP	AF
I$7FDA:		RET

?.7FDB:		RET
                RET
                RET
                RET
                RET

?.7FE0:		DEFB	"MEGASCSI ver2.15 by K.Tsujikawa."
