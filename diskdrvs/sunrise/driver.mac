;  
;   MSXIDE -> Source re-created by Z80DIS 2.2
;      Z80DIS was written by Kenneth Gielow
;                            Palo Alto, CA
;

MYSIZE	EQU	48+6		; size of environment
SECLEN	EQU	512		; size of biggest supported sector


; Sunrise IDE interface
;
; segment switching is a bit different:
;
; b0	IDE register enable
; b7	segment select b0
; b6	segment select b1
; b5	segment select b2

; normally, the following values are thus used
;
; main segment			0000 0001
; message and help segment	1000 0001
; bdos segment			0100 0000
; kanji segment			1100 0000


        .Z80
;
INITXT		EQU	006CH
OUTDO		EQU	0018H
SNSMAT		EQU	0141H
EXTROM		EQU	015FH
S.SDFSCR	EQU	0185H
D.C000		EQU	0C000H
TEMP8		EQU	0F69FH
EXBRSA		EQU	0FAF8H
TRPTBL		EQU	0FC4CH
TMPWRK		EQU	TRPTBL+72


; parititiontable entry
;
; +0	b0	partition is writeprotected when set
;	b1	partition is disabled when set
;	b2-b6	unused
;	b7	partition is bootable when set


;	  Subroutine __________________________
;	     Inputs  ________________________
;	     Outputs ________________________

C.6B03:	POP	HL
        LD	A,(HL)
        INC	HL
        PUSH	HL
        OR	A
        RET	Z
        RST	18H
        JR	C.6B03

;	  Subroutine INIHRD
;	     Inputs  ________________________
;	     Outputs ________________________

INIHRD:
        LD	A,(D$7F4A+0)
        CALL	SNSMAT
        LD	HL,(D$7F4A+1)
        AND	L
        XOR	H			; skip IDE interface key pressed ?
        POP	IX
        RET	Z
        PUSH	IX
        LD	A,1
        LD	(04104H),A		; enable IDE registers
J$69BA:	LD	A,(EXBRSA)
        OR	A
        PUSH	AF
        CALL	Z,INITXT
        POP	AF
        LD	IX,S.SDFSCR
        CALL	NZ,EXTROM
J$6B31:	CALL	C.6B03

        DEFB	"Sunrise MSX ATA/IDE interface",13,10
        DEFB	"IDE bios version #2.40 - 23.03.2005",13,10
        DEFB	"(C)1995 Henrik Gilvad",13,10
        DEFB	"(C)2005 Jon De Schrijder (jon@msx.ch)",13,10,10
        DEFB	"Please wait ---"
        DEFB	0

        LD	IX,TMPWRK		; use 6 last bytes of TRPTBL temporary
        XOR	A
        LD	(IX+4),A
J$6BCF:	LD	(IX+5),A
        CALL	C.6CB7			; wait for device 0 to become ready
        JR	NC,J.6BF2		; no timeout, continue
        CALL	C.6B03

        DEFB	13
        DEFB	"Resetting IDE ---"
        DEFB	0

        CALL	C.6CA7			; reset controler and wait for device 0 to become ready
        JR	C,J.6C20		; timeout, ide master failure
J.6BF2:	LD	A,90H			; EXECUTE DEVICE DIAGNOSTIC
        LD	(D.7E07),A
        XOR	A
        CALL	C.6CB7			; wait for device 0 to become ready
        LD	HL,(D.7E04)
        LD	DE,0EB14H
        OR	A
        SBC	HL,DE
        JR	NZ,J$6C14		; device does not support PACKET commands
        LD	A,10H
        LD	(D.7E06),A		; select device 1
        EI	
        HALT	
        HALT	
        LD	A,(D.7E07)
        RRCA
        JR	C,J$6C1B		; ERR bit set, no slave device!
J$6C14:	LD	A,10H
        CALL	C.6CB7			; wait for device 1 to become ready
        JR	C,J$6C6C		; time out, ide slave failure
J$6C1B:	CALL	C.6CA7			; reset controler and wait for device 0 to become ready
        JR	NC,J$6C3C		; no timeout, continue
J.6C20:	CALL	C.6B03

        DEFB	"IDE Master failure!",13,10
        DEFB	0

J$6C3A:	POP	AF
        RET	

J$6C3C:	LD	A,(D.7E01)
        CP	01H			; device 0 passed, device 1 passed or not present ?
        JR	Z,J$6C47		; ok
        CP	81H			; device 0 passed, device 1 failed ?
        JR	NZ,J.6C20		; no, something wrong with device 0, ide master failure
J$6C47:	PUSH	AF
        CALL	C.6B03

        DEFB	8,8,8,8,13
        DEFB	"IDE Master:"
        DEFB	0

        LD	L,0
        CALL	C.6CDE			; indentify device 0
        POP	DE
        JR	C,J$6C3A		; error, quit
        LD	(IX+4),A		; save devicecode (1,5,6,14)
        LD	A,D
        CP	01H
        JR	Z,J$6C87
J$6C6C:	CALL	C.6B03

        DEFB	13
        DEFB	"IDE Slave failure!",13,10
        DEFB	0

J$6C85:	POP	AF
        RET	

J$6C87:	CALL	C.6B03

        DEFB	"IDE Slave :"
        DEFB	0

J$6C96:	LD	L,10H
        INC	IX
        CALL	C.6CDE			; identify device 1
        JR	C,J$6C85		; error, quit
        LD	(IX+4),A
J$6CA2:	XOR	A
        LD	(D.7E06),A		; select device 0
        RET	

;	  Subroutine reset controler and wait for device 0 to become ready
;	     Inputs  ________________________
;	     Outputs ________________________

C.6CA7:	LD	A,06H
        LD	(D.7E0E),A		; assert host reset
        EI	
        HALT	
        HALT	
        LD	A,02H			; dessert host reset
        LD	(D.7E0E),A
        HALT	
        HALT	
        XOR	A

;	  Subroutine wait for device to become ready
;	     Inputs  A = device (in b4)
;	     Outputs ________________________

C.6CB7:	LD	B,0F0H
        LD	E,A
J$6CBA:	EI	
        LD	A,E
        LD	(D.7E06),A		; select device
        HALT	
        HALT	
        LD	A,(D.7E07)
        AND	80H
        RET	Z			; BSY reset, quit
        HALT	
        HALT	
        HALT	
        HALT	
        HALT	
        HALT	
        PUSH	BC
        CALL	C$7364
        LD	A,7
        CALL	SNSMAT
        AND	80H			; RET key pressed ?
        POP	BC
        SCF	
        RET	Z			; yep, quit
        DJNZ	J$6CBA
        RET	

;	  Subroutine __________________________
;	     Inputs  ________________________
;	     Outputs ________________________

C.6CDE:	CALL	C.7652			; wait for ready
J$6CE1:	JR	C,J.6D27		; timeout,
        LD	A,L
        LD	(D.7E06),A		; select device
        EX	(SP),HL
        EX	(SP),HL
        LD	A,02H
        LD	(D.7E0E),A		; no host reset, enable device interrupt
        EX	(SP),HL
        EX	(SP),HL
        LD	A,(D.7E07)
        RRCA	
        CCF	
        CALL	C,C.7652		; ERR bit reset, wait for ready
        JR	C,J.6D27		; timeout,
        LD	HL,(D.7E04)
        LD	DE,0EB14H
        SBC	HL,DE
        JR	Z,J$6D71		; device has PACKET support, use that
        LD	A,(D.7E07)
        RRCA	
        JR	C,J$6D10		; ERR set, device not detected
        AND	68H			; BSY set, DRDY set (not ready), b4 set (no PACKET support) ?
        LD	A,0ECH			; IDENTIFY DEVICE
        JR	NZ,J$6D7B		; yep, normal condition
J$6D10:	CALL	C.6B03
        DEFB	"not detected.",13,10
        DEFB	0
        XOR	A
        RET	

J$6D25:	POP	AF
J$6D26:	POP	AF
J.6D27:	CALL	C.6B03
        DEFB	"Controller time-out!",13,10
        DEFB	0
        SCF	
        RET	

J.6D43:	POP	AF
        CALL	C.6B03
        DEFB	"WARNING! DATA CORRUPTION DETECTED!",7,7,7,13,10
        DEFB	0
        SCF	
        RET	

J$6D71:	LD	A,08H			; DEVICE RESET
        LD	(D.7E07),A
        EI	
        HALT	
        HALT	
        LD	A,0A1H			; IDENTIFY PACKET DEVICE
J$6D7B:	LD	E,A
J$6D7C:	CALL	C.7652			; wait for ready
        LD	BC,050CH		; pio flow control, mode 4
J$6D82:	LD	A,03H
        LD	(D.7E01),A		; set transfer mode subcommand
        EX	(SP),HL
        EX	(SP),HL
        LD	A,C
        LD	(D.7E02),A		; transfer mode
        PUSH	BC
        LD	A,0EFH			; SET FEATURES
        LD	(D.7E07),A
        CALL	C.7614			; get command status
        POP	BC
        JR	NC,J$6D9E		; ok, continue
J$6D99:	DEC	C
        DJNZ	J$6D82			; timeout or error, try slower pio mode
        LD	C,0			; use pio default mode
J$6D9E:	LD	A,C
        AND	07H
        ADD	A,30H			; pio mode in ASCII
        PUSH	AF
        POP	IY
        XOR	A
        LD	(D.7E01),A
        LD	A,E
        PUSH	AF
        CALL	C.6DFC			; get name of device
        JP	C,J$6D26		; error,
        JR	NZ,J.6D43		; strange data,
        LD	C,A			; save checksum
        POP	AF
        LD	B,19
J$6DB8:	PUSH	AF
        PUSH	BC
        CALL	C.6DFC			; get name of device
        JP	C,J$6D25		; error,
        POP	BC
        CP	C			; same checksum as the first identify ?
        JP	NZ,J.6D43		; nope, suspicious
        POP	AF
        DJNZ	J$6DB8
        LD	BC,(D.C000)
        LD	HL,0848AH
        OR	A
        SBC	HL,BC			; CF device ?
        JP	Z,J$6E72		; yep,
        LD	A,B
        AND	0C0H
        CP	80H
        JP	C,J$6E81		; non ATAPI device,
        CP	80H
        JR	Z,J$6E44		; ATAPI device,
        CALL	C.6B03

        DEFB	"Unsupported device!",13,10
        DEFB	0

        SCF	
        RET	

;	  Subroutine get name of device
;	     Inputs  ________________________
;	     Outputs ________________________

C.6DFC:	EX	AF,AF'
        CALL	C.7652			; wait for ready
        RET	C
        EX	AF,AF'
        EI	
        HALT	
        LD	(D.7E07),A		; command
        EX	(SP),HL
        EX	(SP),HL
J$6E09:	CALL	C.7614			; get command status
        RET	C			; error or timeout, quit
        AND	08H
        JR	Z,J$6E09
        DI	
        LD	HL,D.7C00
        LD	DE,D.C000
        LD	BC,512
        LDIR				; read 512 bytes of data
        LD	HL,D.C000+30
        LD	B,31
        XOR	A
J$6E21:	LD	D,(HL)
        ADD	A,D
        OR	A
        BIT	7,D
        RET	NZ			; bytes should have b7=0!
        INC	L
        DJNZ	J$6E21			; checksum
        LD	D,A
        XOR	A			; Zx set
        LD	A,D
        RET	

;	  Subroutine print model string
;	     Inputs  ________________________
;	     Outputs ________________________

C.6E2E:	LD	HL,D.C000+27*2+1
        LD	B,20
J$6E33:	LD	A,(HL)
        RST	18H
        DEC	L
        LD	A,(HL)
        RST	18H
        INC	L
        INC	L
        INC	L
        DJNZ	J$6E33
        LD	A,13
        RST	18H
        LD	A,10
        RST	18H
        RET


J$6E44:	LD	A,(D.C000+1)
        AND	1FH
        CP	05H			; atapi cdrom ?
        JR	Z,J$6E62		; yep,
        CALL	C.6B03
        DEFB	"ATAPI"
        DEFB	0
        CALL	C.6F2A			; print device mode
        LD	A,06H
J$6E5B:	PUSH	AF
        CALL	C.6E2E			; print model string
        POP	AF
        OR	A
        RET	

J$6E62:	CALL	C.6B03
        DEFB	"CDROM"
        DEFB	0
        CALL	C.6F2A			; print device mode
        LD	A,0EH
        JR	J$6E5B			; print model string

J$6E72:	CALL	C.6B03
        DEFB	"CF,"
        DEFB	0
        CALL	C.6F13			; print translation mode
        LD	A,":"
        RST	18H
        JR	J$6E87

J$6E81:	CALL	C.6F13			; print translation mode
        CALL	C.6F2A			; print device mode

J$6E87:	CALL	C.6E2E			; print model string
        LD	A,(D.C000+3*2+0)
        OR	A			; number of logical heads not set ?
        JR	Z,J.6EEB		; yep, no chs report
        LD	(IX+0),A
        LD	A,(D.C000+6*2+0)
        OR	A			; number of sectors per track not set ?
        JR	Z,J.6EEB		; yep, no chs report
        LD	(IX+2),A
        CALL	C.7652			; wait for ready
        LD	A,(IX+0)
        DEC	A
        AND	0FH
        LD	C,A
        LD	A,(D.7E06)
        AND	0F0H
        OR	C			; max head
        LD	(D.7E06),A
        LD	A,(IX+2)
        LD	(D.7E02),A		; logical sectors per track
        CALL	C.7652			; wait for ready
        LD	A,91H			; INITIALIZE DEVICE PARAMETERS
        LD	(D.7E07),A
        EX	(SP),HL
        EX	(SP),HL
        CALL	C.7614			; get command status
        JR	C,J$6ECD		; error or timeout,
        LD	A,(D.C000+49*2+1)
        AND	02H
        RLCA				; LBA support in b2
        OR	01H
        RET	


J$6ECD:	CALL	C.6B03
        DEFB	"CHS translation error!",13,10
        DEFB	0
        SCF	
        RET	

J.6EEB:	CALL	C.6B03
        DEFB	"No CHS report! (device too old?)",13,10
        DEFB	0
        SCF	
        RET	

;	  Subroutine print translation mode
;	     Inputs  ________________________
;	     Outputs ________________________

C.6F13:	LD	A,(D.C000+49*2+1)
        AND	02H			; LBA supported ?
        JR	Z,J$6F22		; nope, CHS
        CALL	C.6B03
        DEFB	"LBA"
        DEFB	0
        RET	

J$6F22:	CALL	C.6B03
        DEFB	"CHS"
        DEFB	0
        RET	

;	  Subroutine print device mode
;	     Inputs  ________________________
;	     Outputs ________________________

C.6F2A:	CALL	C.6B03
        DEFB	",Mode "
        DEFB	0
J$6F34:	PUSH	IY
        POP	AF
        RST	18H
        LD	A,":"
        JP	OUTDO

;	  Subroutine DRIVES
;	     Inputs  ________________________
;	     Outputs ________________________

DRIVES:
C.6F3D:	PUSH	AF
        PUSH	BC
        PUSH	DE
        CALL	GETWRK		; get workarea pointer
        LD	(HL),0FFH
        LD	D,H
J$6F46:	LD	E,L
        INC	DE
        LD	BC,48-1
        LDIR			; clear
        INC	HL
        EX	DE,HL
        LD	HL,TMPWRK
        LD	C,6
        LDIR			; drives info
        LD	A,(D$7F50+0)
        PUSH	IX
        CALL	SNSMAT
        POP	IX

        IFDEF	DOS2

        LD	HL,(D$7F50+1)
        AND	L
        XOR	H		; no IDE drive assigment key pressed ?
        JR	Z,J$6F7F	; yep, return zero drives

        ENDIF

        LD	A,(TMPWRK+4)	; devicecode device 0
        LD	E,0		; ide master
        PUSH	IX
        CALL	C.6F84
        POP	IX
        LD	H,C
        PUSH	HL
        LD	A,(TMPWRK+5)	; devicecode device 1
        LD	E,1		; ide slave
J$6F7A:	CALL	C.6F84
        POP	AF
        ADD	A,C
J$6F7F:	LD	L,A
        POP	DE
        POP	BC
        POP	AF
        RET	

;	  Subroutine __________________________
;	     Inputs  ________________________
;	     Outputs ________________________

INIENV:
        RET


;	  Subroutine __________________________
;	     Inputs  ________________________
;	     Outputs ________________________

CHOICE:
        LD	HL,NOCHOI
        RET

NOCHOI:	DEFB	0


;	  Subroutine __________________________
;	     Inputs  ________________________
;	     Outputs ________________________

DSKFMT:
        LD	A,12
        SCF
        RET


;	  Subroutine __________________________
;	     Inputs  ________________________
;	     Outputs ________________________

MTOFF:
        RET


;	  Subroutine __________________________
;	     Inputs  ________________________
;	     Outputs ________________________

OEMSTA:
        SCF
        RET


DMYDPB:
        db	0F0h		; Mediadescriptor
        dw	512		; sectorsize
        db	(512/32)-1	; dirmask
        db	32/8		; dirshift
        db	16-1		; clustermask
        db	5		; clustershift
        dw	1		; first FAT sector
        db	2		; number of FATs
        db	224		; number of direntries
        dw	1+2*12+224/16	; first data sector
        dw	4079		; number of clusters+1
        dw	12		; sectors per FAT
        dw	1+2*12		; first directory sector

DEFDPB	EQU	DMYDPB-1

;	  Subroutine __________________________
;	     Inputs  ________________________
;	     Outputs ________________________

C.6F84:	LD	C,00H
        RRCA	
        JR	C,J$6F9A	; ATA device
        AND	0FH
        CP	03H		; non CDROM ATAPI device ?
        JR	NZ,J$6F93	; nope,
        LD	A,0CH		; ATAPI direct access device
        JR	J.6F9C

J$6F93:	CP	07H		; ATAPI CDROM ?
        RET	NZ		; nope, quit
        LD	A,0EH		; ATAPI CDROM device
        JR	J.6F9C

J$6F9A:	LD	A,08H		; ATA device
J.6F9C:	OR	E
        LD	HL,D.C000
        LD	C,07H

;	  Subroutine __________________________
;	     Inputs  ________________________
;	     Outputs ________________________

C$6FA2:	LD	B,A		; devicecode
        LD	A,C
        AND	07H
        LD	C,A		; 0-7
        PUSH	IX
J$6FA9:	PUSH	BC
        PUSH	HL
        LD	C,00H
        LD	(HL),C		; no BPB indicator
        LD	DE,512-2
        ADD	HL,DE
        LD	(HL),C		; no bootmarker
        OR	A
        SBC	HL,DE
        LD	D,C
        LD	E,C		; sector 0
        LD	A,B		; devicecode
        LD	B,1		; 1 sector
        CALL	C.7535		; absolute sector read
        POP	HL
        POP	BC
        JR	NC,J$6FC6	; no error
        CP	18H
        JR	Z,J$6FA9	; try again
J$6FC6:	LD	A,B
        EXX	
        LD	B,A
        LD	C,00H
        POP	HL
        PUSH	HL
        LD	DE,48
        ADD	HL,DE		; workarea offset 0030H
        LD	A,L
        EXX	
        LD	B,A
        PUSH	HL
        POP	IY		; bootsector offset 0
        EX	(SP),HL		; workarea offset 0
        LD	DE,512-2
        ADD	IY,DE
        LD	A,(IY+0)
        CP	55H
        JR	NZ,J.701C	; no valid bootmarker
        LD	A,(IY+1)
        CP	0AAH
        JR	NZ,J.701C	; no valid bootmarker
        PUSH	IY
        CALL	C$70CB		; to the last partitionentry
        LD	A,31
J$6FF2:	EX	AF,AF'
        LD	A,(IY+0)
        AND	7CH		; b6-b2 has info ?
        JR	NZ,J$7001	; yep, this is not a partition table
        LD	E,80H		; look for bootable partitions which are enabled
        CALL	C.7075
        JR	NZ,J$6FF2	; table not full and entries left, try next
J$7001:	EX	(SP),IY
        CALL	C.70D0		; to the last partitionentry
        LD	A,31
J$7008:	EX	AF,AF'
        LD	A,(IY+0)
        AND	7CH		; b6-b2 has info ?
        JR	NZ,J$7019	; yep, this is not a partition table
        LD	E,00H		; look for non-bootable partitions which are enabled
        CALL	C.7075
        JR	NZ,J$7008	; table not full and entries left, try next
        JR	J$7071		; quit

J$7019:	POP	HL
        JR	J$7021

J.701C:	CALL	C.70D8		; search space in workarea
        JR	C,J$7072	; nopes, quit
J$7021:	EXX	
        POP	HL
        LD	A,C
        OR	A
        RET	NZ
        LD	A,(HL)
        CP	0EBH		; BPB indicator ?
        JR	Z,J$702F	; yep
        SET	4,B		; partition not in use
        RES	3,B		; media has been changed
J$702F:	LD	(IX),B
        INC	C
        XOR	A
        LD	(IX+1),A
        LD	(IX+2),A
        LD	(IX+3),A	; start of �partition� at sector 0
        LD	B,A
        LD	DE,17
        ADD	HL,DE
        LD	A,(HL)
        INC	HL
        OR	A
        JR	NZ,J.7054
        LD	A,(HL)
        CP	02H
        JR	NZ,J.7054
        LD	DE,16
        ADD	HL,DE
        LD	B,(HL)
        DEC	HL
        DEC	HL
        DEC	HL
J.7054:	INC	HL
        LD	E,(HL)
        INC	HL
        LD	D,(HL)
        LD	A,E
        SUB	01H	; 1 
        LD	(IX+4),A
        LD	A,D
        SBC	A,00H
        LD	(IX+5),A
        LD	A,B
        SBC	A,00H
        LD	(IX+6),A
        LD	A,0C1H
        LD	(IX+7),A
        RET	

J$7070:	POP	HL
J$7071:	POP	HL
J$7072:	EXX	
        POP	HL
        RET	

;	  Subroutine __________________________
;	     Inputs  ________________________
;	     Outputs ________________________

C.7075:	LD	A,(IY+0)
        AND	82H			; only b7 (1=bootable) and b1 (1=disabled partition)
        XOR	E
        JR	NZ,C.70D0
        LD	A,(IY+4)
        CP	01H
        JR	Z,J.708C		; FAT12 partition
        CP	06H
        JR	Z,J.708C		; BIGDOS (FAT16 > 32 MB) partition
        CP	04H
        JR	NZ,C.70D0		; not a FAT16 partition
J.708C:	LD	A,(IY+0)
        RRCA	
        XOR	0C1H
        LD	(IX+7),A		; special MSX partitionflags
        LD	A,(IY+8)
        LD	(IX+1),A
        LD	A,(IY+9)
        LD	(IX+2),A
        LD	A,(IY+10)
        LD	(IX+3),A		; start of partition
        LD	A,(IY+12)
        SUB	01H
        LD	(IX+4),A
        LD	A,(IY+13)
        SBC	A,00H
        LD	(IX+5),A
        LD	A,(IY+14)
        SBC	A,00H
        LD	(IX+6),A		; partitionlength
        LD	A,(IY+15)
        OR	A			; 4th size byte should be zero
        JR	NZ,C.70D0		; it is not, do not use partition!
        EXX	
        INC	C
        LD	(IX),B			; device codebyte
        EXX	

;	  Subroutine __________________________
;	     Inputs  ________________________
;	     Outputs ________________________

C$70CB:	CALL	C.70D8			; search partinfo entry
        JR	C,J$7070		; not found, quit

;	  Subroutine __________________________
;	     Inputs  ________________________
;	     Outputs ________________________

C.70D0:	LD	DE,-16
        ADD	IY,DE
        EX	AF,AF'
        DEC	A
        RET	

;	  Subroutine __________________________
;	     Inputs  ________________________
;	     Outputs ________________________

C.70D8:	LD	DE,8
J$70DB:	LD	A,L
        CP	B		; end of partinfo workarea ?
        SCF	
        RET	Z		; yep, quit
        LD	A,(HL)
        AND	07H
        CP	C
        JR	Z,J$70E8
        ADD	HL,DE
        JR	J$70DB		; next entry

J$70E8:	PUSH	HL
        POP	IX
        ADD	HL,DE
        RET	

;	  Subroutine __________________________
;	     Inputs  ________________________
;	     Outputs ________________________

C.70ED:	CALL	C.6B03
        DEFB	13
        DEFB	27,"K"
        DEFB	0
        RET	

;	  Subroutine __________________________
;	     Inputs  ________________________
;	     Outputs ________________________

C.70F5:	ADD	A,A
        ADD	A,A
        ADD	A,A
        LD	E,A
        LD	D,00H
        CALL	GETWRK		; get workarea pointer
        ADD	IX,DE
        RET	

;	  Subroutine __________________________
;	     Inputs  ________________________
;	     Outputs ________________________

C$7101:	BIT	1,(IX)
        RET	NZ
        BIT	3,(IX)
        RET	NZ

;	  Subroutine __________________________
;	     Inputs  ________________________
;	     Outputs ________________________

C$710B:	PUSH	AF
        PUSH	BC
        PUSH	DE
        PUSH	HL
        PUSH	IX
        LD	A,(IX+0)
        EX	AF,AF'
        CALL	GETWRK		; get workarea pointer
        EX	AF,AF'
        LD	C,A
        AND	0E7H
        LD	HL,($SECBUF)
        CALL	C$6FA2
        POP	IX
        POP	HL
        POP	DE
        POP	BC
        POP	AF
        BIT	4,(IX)
        RET	

J$712D:	CALL	C$7101
        JR	Z,J$7147
        JP	J.71DD

;	  Subroutine __________________________
;	     Inputs  ________________________
;	     Outputs ________________________

DSKIO:
J$7135:	PUSH	AF
        CP	6
        JP	NC,J.71D8		; driveid must be 0-5, error
        EXX	
        CALL	C.70F5			; get partitioninfo pointer in workarea
        EXX	
        POP	AF

;	  Subroutine __________________________
;	     Inputs  ________________________
;	     Outputs ________________________

C$7141:	BIT	4,(IX+0)
        JR	NZ,J$712D
J$7147:	PUSH	AF
        BIT	7,C		; mediadescriptor in C ?
        JR	Z,J$7154	; nope, C has b22-b16 of sectornumber
        LD	A,C
        SUB	0F0H		; mediadescriptor valid ?
        JP	C,J.71D8	; nope, error
        LD	C,0		; b22-b16 sectornumber = 0
J$7154:	PUSH	DE
        PUSH	BC
        LD	A,B
        DEC	A
        ADD	A,E
        LD	E,A
        LD	A,0
        ADC	A,D
        LD	D,A
        LD	A,0
        ADC	A,C
        LD	C,A		; last sector of transfer
        LD	A,(IX+4)
        SUB	E
        LD	A,(IX+5)
        SBC	A,D
        LD	A,(IX+6)
        SBC	A,C
        POP	BC
        POP	DE
        JP	C,J$71A7	; not valid,
        LD	A,E
        ADD	A,(IX+1)
        LD	E,A
        LD	A,D
        ADC	A,(IX+2)
        LD	D,A
        LD	A,C
        ADC	A,(IX+3)
        LD	C,A		; first absolute sector
        POP	AF
        PUSH	DE
        PUSH	BC
        PUSH	IX
        JR	C,J$7192	; sector write
        LD	A,(IX+0)	; device code
        CALL	C.7535		; absolute sector read
J$718D:	POP	IX
        POP	BC
        POP	HL
        RET	

J$7192:	LD	A,(IX+7)
        BIT	7,A		; partition writeprotected ?
        JR	Z,J$71A1	; yep, error
        LD	A,(IX+0)	; device code
        CALL	C.74D2		; absolute sector write
        JR	J$718D		; quit

J$71A1:	POP	AF
        POP	BC
        POP	AF
        XOR	A
        SCF	
        RET	

J$71A7:	LD	A,(IX+4)
        SUB	E
        LD	A,(IX+5)
        SBC	A,D
        LD	A,(IX+6)
        SBC	A,C
        JR	C,J$71CB
        LD	A,B
        ADD	A,E
        SUB	(IX+4)
        DEC	A
        LD	B,A
        PUSH	BC
        LD	A,(IX+4)
        SUB	E
        LD	B,A
        INC	B
        POP	AF
        CALL	C$7141
        JR	C,J$71D0
        POP	BC
        DEFB	03EH			; LD A,xx, skip next POP
J$71CB:	POP	AF
        LD	A,08H	; 8 
        SCF	
        RET	

J$71D0:	POP	DE
        PUSH	AF
        LD	A,B
        ADD	A,D
        LD	B,A
        POP	AF
        RET	

J.71D7:	POP	HL
J.71D8:	POP	AF
        LD	A,0CH	; 12 
        SCF	
        RET	

J.71DD:	LD	A,02H	; 2 
        SCF	
        RET	

;	  Subroutine DSKCHG
;	     Inputs  ________________________
;	     Outputs ________________________

DSKCHG:
J$71E1:	CP	06H
        JR	NC,J.71DD		; invalid driveid, quit
        PUSH	AF
        PUSH	HL
        CALL	C.70F5			; get partitioninfo pointer in workarea
        LD	E,(IX)
        LD	A,E
        CALL	C.75D7			; select device for atapi packet
        JR	C,J.71D7		; error, quit
        BIT	2,E
        JR	Z,J$723F		; ATA device,
        LD	A,0DAH
        LD	(D.7E07),A		; GET MEDIA STATUS
        CALL	C.75CF			; wait for ready
        LD	A,(D.7E01)
        AND	02H
        JR	Z,J$720C		; media in drive, continue
        POP	HL
        POP	AF
        LD	A,02H
        SCF	
        RET	

J$720C:	PUSH	IX
        LD	DE,0036H
        ADD	HL,DE
        CALL	C.749D			; request sense
        POP	IX
        JR	C,J.71D7		; error, quit
        AND	0FH			; sense code
        BIT	1,(IX)
        JR	NZ,J$724F		; ATAPI CDROM,
        CP	06H
        JR	Z,J.7246		; UNIT ATTENTION,
J$7225:	BIT	4,(IX)
        JR	NZ,J.7246		; partition not in use,
        POP	HL
        POP	AF
        OR	A			; reset Cx
        LD	B,01H			; disk unchanged
        BIT	3,(IX)
        RET	NZ
J$7235:	SET	3,(IX)
        CALL	C.7269			; GETDPB
        LD	B,0FFH			; disk change unknown
        RET	

J$723F:	LD	A,(D.7E01)
        AND	28H
        JR	Z,J$7225
J.7246:	POP	HL
        POP	AF
        CALL	C$710B
        JR	Z,J$7235		; disk change unknown
        JR	J.71DD

J$724F:	POP	HL
        POP	BC
        CP	06H	; 6 
        JR	Z,J$725D
        OR	A
        LD	B,01H	; 1 
        BIT	3,(IX)
        RET	NZ
J$725D:	SET	3,(IX)
        LD	B,0FFH
        OR	A
        RET	

J$7265:	LD	A,02H	; 2 
        SCF	
        RET	

;	  Subroutine GETDPB
;	     Inputs  ________________________
;	     Outputs ________________________

GETDPB:
C.7269:	CP	06H
        JP	NC,J.71DD		; invalid driveid
        PUSH	AF
        PUSH	HL
        CALL	C.70F5			; get partitioninfo pointer in workarea
        POP	HL
        POP	AF
        BIT	4,(IX+0)
        JR	NZ,J$7265		; partition not in use, quit
        PUSH	HL
        LD	HL,($SECBUF)		; $SECBUF
        PUSH	HL
        LD	A,(IX+0)		; devicecode
        LD	B,1			; 1 sector
        LD	C,(IX+3)
        LD	D,(IX+2)
        LD	E,(IX+1)		; first sector of partition
        CALL	C.7535			; absolute sector read
        POP	IY
        POP	IX
        RET	C			; error, quit
        LD	A,(IY+21)
        LD	(IX+1),A
        CP	0F0H
        LD	A,12H
        RET	C			; mediadescriptor must be 0F0H-0FFH, quit
        LD	L,(IY+14)
        LD	H,(IY+15)		; first FAT sector
        LD	(IX+8),L
        LD	(IX+9),H
        LD	A,(IY+16)		; number of FATs
        LD	(IX+10),A
        LD	E,(IY+22)
        LD	D,(IY+23)		; number of sectors per FAT
        LD	(IX+16),E
        LD	B,A
J$72BD:	ADD	HL,DE
        DJNZ	J$72BD
        LD	(IX+17),L
        LD	(IX+18),H
        LD	E,(IY+17)
        LD	D,(IY+18)		; number of rootdirectory entries

        LD	A,D
        OR	A
        JR	NZ,JRT254
        LD	A,E
        CP	255
        JR	C,JRTOK
JRT254:	LD	A,254
JRTOK:	LD	(IX+11),A

        LD	C,(IY+11)
        LD	B,(IY+12)		; bytes per sector
        LD	(IX+2),C
        LD	(IX+3),B
        SRL	B
        RR	C
        SRL	B
        RR	C
        SRL	B
        RR	C
        SRL	B
        RR	C
        SRL	B
        RR	C
        DEC	C
        LD	(IX+4),C
J$72F3:	INC	B
        RR	C
        JR	C,J$72F3
        DEC	B
        LD	(IX+5),B
J$72FC:	SRL	D
        RR	E
        DJNZ	J$72FC
        ADD	HL,DE
        LD	(IX+12),L
        LD	(IX+13),H
        EX	DE,HL
        LD	C,B
        LD	L,(IY+19)
        LD	H,(IY+20)		; total number of sectors on disk
        LD	A,H
        OR	L
        JR	NZ,J$7321
        LD	L,(IY+32)
        LD	H,(IY+33)
        LD	C,(IY+34)
        LD	B,(IY+35)
J$7321:	SBC	HL,DE
        JR	NC,J$7326
        DEC	BC
J$7326:	LD	D,B
        LD	E,C
        LD	A,(IY+13)
        DEC	A
        LD	(IX+6),A		; sectors per cluster
        LD	B,0
J$7331:	INC	B
        RRCA	
        JR	C,J$7331
        LD	(IX+7),B
        DEC	B
        JR	Z,J$7345
J$733B:	SRL	D
        RR	E
        RR	H
        RR	L
        DJNZ	J$733B
J$7345:	INC	HL
        LD	(IX+14),L
        LD	(IX+15),H
        OR	A
        RET	

; SCSI-BIOS 7F86 (TermAct)


J$734E:	LD	D,0			; target status = GOOD
        AND	A
        RET

; SCSI-BIOS 7F83 (SetWD3393)

J$7352:	RET	


J$7353:	RET	

J$7354:	JR	J$7356

J$7356:	LD	D,00H
        RET	

J$7359:	RET	

J$735A:	RET	

J$735B:	RET	

J$735C:	RET	

J$735D:	LD	A,00H
        AND	A
        RET	

J$7361:	RET	

J$7362:	RET	

J$7363:	RET	

;	  Subroutine __________________________
;	     Inputs  ________________________
;	     Outputs ________________________

C$7364:	PUSH	AF
        PUSH	HL
        LD	A,(TEMP8)
        INC	A
        AND	01H	; 1 
        LD	(TEMP8),A
        LD	HL,I$737C
        ADD	A,L
        LD	L,A
        LD	A,08H	; 8 
        RST	18H
        LD	A,(HL)
        RST	18H
        POP	HL
        POP	AF
        RET	

I$737C:	DEC	L
        DAA	

;	  Subroutine __________________________
;	     Inputs  ________________________
;	     Outputs ________________________

C.737E:	RLA	
        RLA	
        RLA	
        RLA	
        AND	10H
        LD	(D.7E06),A		; select device
        EX	(SP),HL
        EX	(SP),HL
        EX	AF,AF'
        CALL	C.75CF			; wait for ready
        LD	A,B
        LD	(D.7E02),A		; number of sectors
        EXX	
        CALL	GETWRK			; get workarea pointer
        EXX	
        EX	AF,AF'
        JR	Z,J$739B		; master
        INC	IX			; slave
J$739B:	BIT	2,(IX+52)
        JR	Z,J$73AF
        OR	40H
        LD	(D.7E06),A		; select device
        LD	A,C
        LD	(D.7E03),DE
        LD	(D.7E05),A		; sectornumber
        RET	

J$73AF:	LD	L,C
        LD	C,(IX+50)
        CALL	C.73CF
        LD	A,H
        INC	A
        LD	(D.7E03),A
        LD	C,(IX+48)
        CALL	C.73CF
        LD	A,(D.7E06)
        AND	0F0H
        LD	(D.7E04),DE
        OR	H
        LD	(D.7E06),A		; select device
        RET	

;	  Subroutine __________________________
;	     Inputs  ________________________
;	     Outputs ________________________

C.73CF:	XOR	A
        LD	H,A
        LD	B,18H
J$73D3:	EX	DE,HL
        ADD	HL,HL
        EX	DE,HL
        ADC	HL,HL
        LD	A,H
        SUB	C
        JR	C,J$73DE
        LD	H,A
        INC	E
J$73DE:	DJNZ	J$73D3
        RET	

J$73E1:	CALL	C.7446
        RET	C
        JR	NZ,J$73F3
        LD	(IX),28H		; READ(10)
        CALL	C.746D			; issue 10 byte atapi command
        JR	C,J.7414
        LD	B,00H
        RET	

J$73F3:	LD	(IX),0A8H		; READ(12)
        CALL	C$7463			; issue 12 byte atapi command
        JR	C,J.7414
        LD	B,00H
        RET	

;	  Subroutine ATAPI WRITE
;	     Inputs  ________________________
;	     Outputs ________________________

J$73FF:	CALL	C.7446
        RET	C
        JR	NZ,J$7411
        LD	(IX),2AH		; WRITE(10)
        CALL	C.746D			; issue 10 byte atapi command
        JR	C,J.7414
        LD	B,00H
        RET	

J$7411:	XOR	A
        SCF	
        RET	

J.7414:	JR	Z,J.745E
        LD	E,C
        LD	C,08H	; 8 
        RRCA	
        JR	C,J.7460
        RRCA	
        JR	C,J.7460
        CALL	C.749D			; request sense
        JR	C,J.745E
        AND	0FH	; 15 
        LD	C,02H	; 2 
        CP	02H	; 2 
        JR	Z,J.7460
        LD	C,04H	; 4 
        CP	03H	; 3 
        JR	Z,J.7460
        LD	C,00H
        CP	07H	; 7 
        JR	Z,J.7460
        CP	06H	; 6 
        JR	NZ,J.745E
        LD	A,E
        LD	DE,0FFCAH
        ADD	HL,DE
        CALL	C.75B7
        JR	J.7460

;	  Subroutine __________________________
;	     Inputs  ________________________
;	     Outputs ________________________

C.7446:	PUSH	AF
        PUSH	BC
        CALL	C.75D7			; select device for atapi packet
        POP	BC
        JR	C,J$745D
        EXX	
        CALL	GETWRK			; get workarea pointer
        LD	DE,0036H
        ADD	IX,DE
        EXX	
        POP	AF
        OR	A
        BIT	1,A
        RET	

J$745D:	POP	AF
J.745E:	LD	C,0CH	; 12 
J.7460:	LD	A,C
        SCF	
        RET	

;	  Subroutine __________________________
;	     Inputs  ________________________
;	     Outputs ________________________

C$7463:	LD	(IX+8),00H
        LD	(IX+9),B		; transferlength
        JP	J$7474

;	  Subroutine __________________________
;	     Inputs  ________________________
;	     Outputs ________________________

C.746D:	LD	(IX+8),B		; transferlength
        LD	(IX+9),00H		; control
J$7474:	LD	(IX+3),C
        LD	(IX+4),D
        LD	(IX+5),E		; logical block address
        LD	C,A
        XOR	A
        LD	(IX+1),A		; logical unit 0
        LD	(IX+2),A		; MSB logical block address
        LD	(IX+6),A		; reserved
        LD	(IX+7),A		; MSB transferlength
        LD	(IX+10),A		; reserved (12 byte)
        LD	(IX+11),A		; control (12 byte)
        EX	DE,HL
        PUSH	IX
        POP	HL
        PUSH	HL
        PUSH	BC
        CALL	C.7674			; issue atapi packet
        POP	BC
        POP	HL
        RET	

;	  Subroutine request sense
;	     Inputs  ________________________
;	     Outputs ________________________

C.749D:	PUSH	HL
        PUSH	HL
        EXX	
        POP	IX
        POP	HL
        LD	D,H
        LD	E,L
        XOR	A
        LD	(HL),03H		; REQUEST SENSE
        LD	(IX+1),A		; logical unit 0
        LD	(IX+2),A		; reserved
        LD	(IX+3),A		; reserved
        LD	(IX+4),12H		; 18 bytes
        LD	(IX+5),A		; control
        LD	(IX+6),A
        LD	(IX+7),A
        LD	(IX+8),A
        LD	(IX+9),A
        LD	(IX+10),A
        LD	(IX+11),A
        CALL	C.7674			; issue atapi packet
        LD	A,(IX+2)
        EXX	
        RET	

;	  Subroutine __________________________
;	     Inputs  ________________________
;	     Outputs ________________________

C.74D2:	BIT	2,A
        JP	NZ,J$73FF		; atapi write
        PUSH	AF
        PUSH	BC
        PUSH	HL
        CALL	C.737E
        POP	HL
        LD	A,30H
        LD	(D.7E07),A		; WRITE SECTOR(S)
        POP	AF
        LD	C,0
        LD	E,C
J$74E7:	EX	AF,AF'
        LD	D,HIGH D.7C00
        LD	B,HIGH 512
J$74EC:	LD	A,(D.7E07)
        BIT	7,A
        JR	NZ,J$74EC
        BIT	6,A
        JR	Z,J.7528
        BIT	7,H
        JR	Z,J$7510
        LDIR				; write 512 bytes of data
J$74FE:	CALL	C.75CF			; wait for ready
        LD	A,(D.7E07)
        BIT	0,A
        JR	NZ,J.7528
        EX	AF,AF'
        DEC	A
        JR	NZ,J$74E7
        POP	AF
        XOR	A
        LD	D,A
        RET	

J$7510:	EX	AF,AF'
        LD	DE,($SECBUF)
        CALL	XFER
        PUSH	HL
        LD	HL,($SECBUF)
        LD	DE,D.7C00
        LD	B,HIGH 512
        LDIR				; write 512 bytes of data
        POP	HL
        EX	AF,AF'
        JR	J$74FE

J.7528:	BIT	5,A
        LD	A,(D.7E01)
        LD	C,0AH	; 10 
        JR	NZ,J.759D
        LD	C,00H
        JR	J.759D

;	  Subroutine absolute sector read
;	     Inputs  ________________________
;	     Outputs ________________________

C.7535:	BIT	2,A
        JP	NZ,J$73E1		; atapi read
        PUSH	AF
        PUSH	BC
        PUSH	HL
        CALL	C.737E
        LD	A,20H
        LD	(D.7E07),A		; READ SECTOR(S)
        POP	DE
        POP	AF
        LD	C,0
        LD	L,C
J$754A:	EX	AF,AF'
        LD	H,HIGH D.7C00
        LD	B,HIGH 512
J$754F:	LD	A,(D.7E07)
        AND	88H
        CP	08H	; 8 
        JR	NZ,J$754F
        LD	A,(D.7E07)
        RRCA	
        JR	C,J$7581
        EX	AF,AF'
        BIT	7,D
        JR	Z,J$756E		; transfer to 0000-7FFF,
        LDIR				; read 512 bytes of data
J$7566:	DEC	A
        JP	NZ,J$754A		; next sector
        POP	AF
        XOR	A
        LD	D,A
        RET	

J$756E:	PUSH	DE
        LD	DE,($SECBUF)
        LDIR				; read 512 bytes of data
        POP	DE
        LD	HL,($SECBUF)
        LD	B,HIGH 512
        CALL	XFER
        JR	J$7566

J$7581:	LD	A,(D.7E01)
        LD	C,08H	; 8 
        RRCA	
        JR	C,J.759D
        RRCA	
        JR	C,J.759D
        RRCA	
        LD	C,08H	; 8 
        RRCA	
        RRCA	
        JR	C,J.759D
        RRCA	
        JR	C,J$75A3
        LD	C,04H	; 4 
        RRCA	
        JR	C,J.759D
        LD	C,02H	; 2 
J.759D:	POP	AF
J$759E:	EX	AF,AF'
        LD	B,A
        LD	A,C
        SCF	
        RET	

J$75A3:	CALL	C.75CF			; wait for ready
        LD	A,0DBH
        LD	(D.7E07),A		; ?
        CALL	GETWRK			; get workarea pointer
        CALL	C.75CF			; wait for ready
        POP	AF
        CALL	C.75B7
        JR	J$759E

;	  Subroutine __________________________
;	     Inputs  ________________________
;	     Outputs ________________________

C.75B7:	AND	07H	; 7 
        LD	C,A
        LD	DE,8
        LD	B,06H	; 6 
J$75BF:	LD	A,(HL)
        AND	07H	; 7 
        CP	C
        JR	NZ,J$75C9
        RES	3,(HL)
        SET	4,(HL)
J$75C9:	ADD	HL,DE
        DJNZ	J$75BF
        LD	C,18H
        RET	

;	  Subroutine __________________________
;	     Inputs  ________________________
;	     Outputs ________________________

C.75CF:	LD	A,(D.7E07)
        AND	80H
        RET	Z
        JR	C.75CF

;	  Subroutine select device for atapi packet
;	     Inputs  ________________________
;	     Outputs ________________________

C.75D7:	PUSH	AF
        CALL	C.75E9
        POP	BC
        RET	C
        LD	A,B
        AND	01H	; 1 
        RLCA	
        RLCA	
        RLCA	
        RLCA	
        LD	(D.7E06),A		; select device
        EX	(SP),HL
        EX	(SP),HL

;	  Subroutine __________________________
;	     Inputs  ________________________
;	     Outputs ________________________

C.75E9:	LD	BC,0
J$75EC:	LD	A,(D.7E07)
        AND	88H
        RET	Z
        DEC	BC
        LD	A,B
        OR	C
        JR	NZ,J$75EC
        LD	BC,0780H
J$75FA:	LD	A,(D.7E07)
        AND	88H
        RET	Z
        PUSH	BC
        LD	BC,0960H
J$7604:	EX	(SP),HL
        EX	(SP),HL
        DEC	BC
        LD	A,B
        OR	C
        JR	NZ,J$7604
        POP	BC
        DEC	BC
        LD	A,B
        OR	C
        JR	NZ,J$75FA
        XOR	A
        SCF	
        RET	

;	  Subroutine __________________________
;	     Inputs  ________________________
;	     Outputs ________________________

C.7614:	LD	BC,0
J$7617:	LD	A,(D.7E07)
        BIT	7,A
        JR	NZ,J$7627		; still busy, wait
        OR	A
        BIT	0,A
        RET	Z			; ERR not set, quit
        LD	A,(D.7E01)
        SCF	
        RET	

J$7627:	DEC	BC
        LD	A,B
        OR	C
        JR	NZ,J$7617		; keep trying
        LD	BC,0780H
J$762F:	LD	A,(D.7E07)
        BIT	7,A
        JR	NZ,J$763F		; still busy, wait a while and try again
        OR	A
        BIT	0,A
        RET	Z			; ERR not set, quit
        LD	A,(D.7E01)
        SCF	
        RET	

J$763F:	PUSH	BC
        LD	BC,0960H
J$7643:	EX	(SP),HL
        EX	(SP),HL
        DEC	BC
        LD	A,B
        OR	C
        JR	NZ,J$7643
        POP	BC
        DEC	BC
        LD	A,B
        OR	C
        JR	NZ,J$762F
        SCF	
        RET	

;	  Subroutine wait for ready
;	     Inputs  ________________________
;	     Outputs ________________________

C.7652:	LD	BC,0
J$7655:	LD	A,(D.7E07)
        OR	A
        BIT	7,A
        RET	Z			; ready, quit
        DEC	BC
        LD	A,B
        OR	C
        JR	NZ,J$7655
        LD	BC,0780H
        EI	
J$7665:	LD	A,(D.7E07)
        OR	A
        BIT	7,A			; ready, quit
        RET	Z
        HALT	
        DEC	BC
        LD	A,B
        OR	C
        JR	NZ,J$7665
        SCF	
        RET	

;	  Subroutine issue atapi packet
;	     Inputs  ________________________
;	     Outputs ________________________

C.7674:	CALL	C.75E9
        RET	C
        DI	
        LD	(D.7E01),A		; non DMA, non overlapped
        EX	(SP),HL
        EX	(SP),HL
        LD	(D.7E04),A
        LD	A,0FFH
        LD	(D.7E05),A		; byte count limit = 0FF00H
        LD	A,0A0H
        LD	(D.7E07),A		; PACKET
        EX	(SP),HL
        EX	(SP),HL
J$768D:	CALL	C.7614			; get command status
        RET	C			; error or timeout, quit
        AND	08H
        JR	Z,J$768D
        PUSH	DE
        LD	DE,D.7C00
        LDI	
        LDI	
        LDI	
        LDI	
        LDI	
        LDI	
        LDI	
        LDI	
        LDI	
        LDI	
        LDI	
        LDI	
        POP	DE
J$76B2:	CALL	C.7614			; get command status
        RET	C			; error or timeout, quit
        LD	A,(D.7E02)		; ATAPI interrupt reason
        AND	03H
        CP	01H			; read to accept command ?
        JR	Z,J$76B2		; yep, wait
J$76BF:	CALL	C.7614			; get command status
        RET	C			; error or timeout, quit
        LD	A,(D.7E02)		; ATAPI interrupt reason
        AND	03H
        CP	01H			; read to accept command ?
        JR	Z,J$76BF		; yep, wait
        LD	IY,03E8H
J.76D0:	CALL	C.7614			; get command status
        RET	C			; error or timeout, quit
        AND	08H
        JR	Z,J$773F
        LD	BC,(D.7E04)
        DEC	BC
        DEC	BC
        PUSH	BC
        LD	A,B
        AND	01H	; 1 
        LD	B,A
        OR	C
        CALL	NZ,C.779C
        POP	BC
        SRL	B
        JR	Z,J$76F6
J$76EC:	PUSH	BC
        LD	BC,512
        CALL	C.779C
        POP	BC
        DJNZ	J$76EC
J$76F6:	LD	A,(D.7E02)
        AND	02H	; 2 
        JR	Z,J$7723
        BIT	7,D
        JR	Z,J$7718
        PUSH	IY
        POP	BC
        LD	HL,(D.7C00)
J$7707:	LD	A,(D.7E07)
        RLCA	
        CALL	NC,C.7789
        JR	NC,J$7707
        EX	DE,HL
        LD	(HL),E
        INC	HL
        LD	(HL),D
        INC	HL
        EX	DE,HL
        JR	J.76D0

J$7718:	LD	HL,D.7C00
        LD	BC,2
        CALL	C.77C3
        JR	J.76D0

J$7723:	BIT	7,D
        JR	Z,J$7759
        LD	A,(DE)
        LD	(D.7C00+0),A
        INC	DE
        LD	A,(DE)
        INC	DE
        PUSH	IY
        POP	BC
        LD	(D.7C00+1),A
J$7734:	LD	A,(D.7E07)
        RLCA	
        CALL	NC,C.7789
        JR	NC,J$7734
        JR	J.76D0

J$773F:	LD	A,(D.7E02)
        AND	03H	; 3 
        CP	03H	; 3 
        JR	NZ,J.76D0
        LD	A,(D.7E07)
        RLCA	
        JR	C,J.76D0
        LD	A,(D.7E02)
        AND	03H	; 3 
        CP	03H	; 3 
        RET	Z
        JP	J.76D0

J$7759:	EX	DE,HL
        LD	DE,($SECBUF)
        LD	BC,2
        PUSH	IX
        PUSH	IY
        CALL	XFER
        POP	IY
        POP	IX
        PUSH	HL
        LD	HL,($SECBUF)
        LD	A,(HL)
        LD	(D.7C00+0),A
        INC	HL
        LD	A,(HL)
        PUSH	IY
        POP	BC
        LD	(D.7C00+1),A
J$777C:	LD	A,(D.7E07)
        RLCA	
        CALL	NC,C.7789
        JR	NC,J$777C
        POP	DE
        JP	J.76D0

;	  Subroutine __________________________
;	     Inputs  ________________________
;	     Outputs ________________________

C.7789:	LD	A,(D.7E02)
        AND	03H	; 3 
        CP	03H	; 3 
        SCF	
        RET	Z
        DEC	BC
        LD	A,B
        OR	C
        RET	NZ
        LD	IY,1
        SCF	
        RET	

;	  Subroutine __________________________
;	     Inputs  ________________________
;	     Outputs ________________________

C.779C:	LD	HL,D.7C00
        LD	A,(D.7E02)
        AND	02H
        JR	Z,J$77B9
        BIT	7,D
        JR	Z,C.77C3

;	  Subroutine __________________________
;	     Inputs  ________________________
;	     Outputs ________________________

J$77B9:	EX	DE,HL
        BIT	7,H
        JR	Z,J$77DD		; transferadres 0000-7FFF, read via $SECBUF
        LDIR				; read
        EX	DE,HL
        RET	

;	  Subroutine __________________________
;	     Inputs  ________________________
;	     Outputs ________________________

C.77C3:	PUSH	DE
        PUSH	BC
        LD	DE,($SECBUF)
        LDIR
        POP	BC
        POP	DE
        LD	HL,($SECBUF)
        PUSH	IX
        PUSH	IY
        CALL	XFER
        POP	IY
        POP	IX
        RET	

J$77DD:	LD	DE,($SECBUF)
        PUSH	BC
        PUSH	IX
        PUSH	IY
        CALL	XFER
        POP	IY
        POP	IX
        POP	BC
        PUSH	HL
        LD	HL,($SECBUF)
        LD	DE,D.7C00
        LDIR
        POP	DE
        RET	

J$7BFB:	CALL	C.70F5			; get partitioninfo pointer in workarea
        ADD	HL,DE
        RET	

D.7C00	EQU	07C00H			; dataport (7C00-7DFF)

D.7E01	EQU	07E00H+1		; feature register (w) / error register (r)
D.7E02	EQU	07E00H+2		; sector count register
D.7E03	EQU	07E00H+3		; sector number register
D.7E04	EQU	07E00H+4		; cylinder low register
D.7E05	EQU	07E00H+5		; cylinder high register
D.7E06	EQU	07E00H+6		; device/head register
D.7E07	EQU	07E00H+7		; command register (w) / status register (r)
D.7E0E	EQU	07E00H+14		; device control (w) / alternate status register (r)



        defs	07F20H-$,0

; some sort of jumptable
; not documented anywhere


;	  Subroutine INIHRD
;	     Inputs  ________________________
;	     Outputs ________________________

        JP	J$69BA

;	  Subroutine DSKIO
;	     Inputs  ________________________
;	     Outputs ________________________

?.7F23:	JP	J$7135

;	  Subroutine DSKCHG
;	     Inputs  ________________________
;	     Outputs ________________________

?.7F26:	JP	J$71E1

;	  Subroutine GETDPB
;	     Inputs  ________________________
;	     Outputs ________________________

?.7F29:	JP	C.7269



        defs	07F4AH-$,0

D$7F4A:	DEFB	8,4,0		; INS key (disable IDE interface)
D$7F4D:	DEFB	6,4,0		; GRAPH key (disable IDE functionality)
D$7F50:	DEFB	8,8,0		; DEL key (no driveletter assignment)



        defs	07F80H-$,0

; jumptable, they tried to make this SCSI-BIOS compatible

; IDE interface indentifier
; SCSI-BIOS has "HD!" or "HD#"

        DEFB	"ID#"		; IDE-BIOS indentifier
        JP	J$7352		; initialise SCSI controller
?.7F86:	JP	J$734E		; terminate hdd actions
?.7F89:	JP	C.7535		; read logical blocks
?.7F8C:	JP	C.74D2		; write logical blocks
?.7F8F:	JP	J$735D		; request sense
?.7F92:	JP	J$7361		; inquiry
?.7F95:	JP	J$7363		; read capacity
?.7F98:	JP	J$7362		; mode sense
?.7F9B:	JP	J$735A		; mode select
?.7F9E:	JP	J$735B		; format unit
?.7FA1:	JP	J$7354		; test unit ready
?.7FA4:	JP	J$6B31		; initialise
?.7FA7:	JP	C.6F3D		; install workspace
?.7FAA:	JP	C.70ED		; clear to end of line
?.7FAD:	JP	J$735C		; verify
J$7FB0:	JP	J$7359		; start/stop unit
J$7FB3:	JP	J$7353		; send diagnostic

?.7FB6:	DEFB	002H,040H,0	; IDE-BIOS version
        JP	C.75D7		; select device for atapi packet
?.7FBC:	JP	C.7674		; issue atapi packet
?.7FBF:	JP	J$7BFB		; get partitionpointer

