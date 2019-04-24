; DISK-S0.ASM
;
; DOS 2.31 kernel bank 0
;
; Source re-created by Z80DIS 2.2
; Z80DIS was written by Kenneth Gielow, Palo Alto, CA
;
; Code Copyrighted by ASCII and maybe others
; Source comments by Arjen Zeilemaker
;
; Sourcecode supplied for STUDY ONLY
; Recreation NOT permitted without authorisation of the copyrightholders
;

DOS2	EQU	1		; DOS2 flag for diskdriver

        .Z80
        ASEG
        ORG	04000H

;	EXTRN	INIHRD
;	EXTRN	DRIVES
;	EXTRN	INIENV
;	EXTRN	DSKIO
;	EXTRN	DSKCHG
;	EXTRN	GETDPB
;	EXTRN	CHOICE
;	EXTRN	DSKFMT
;	EXTRN	MTOFF
;	EXTRN	OEMSTA
;	EXTRN	MYSIZE
;	EXTRN	SECLEN
;	EXTRN	DEFDPB			; WARNING: NOW SUBROUTINE

;	PUBLIC	PROMPT
;	PUBLIC	SETINT
;	PUBLIC	PRVINT
;	PUBLIC	GETSLT
;	PUBLIC	GETWRK
;	PUBLIC	DIV16
;	PUBLIC	ENASLT
;	PUBLIC	XFER

RDSLT	EQU	0000CH
WRSLT	EQU	00014H
CALSLT	EQU	0001CH
CALLF	EQU	00030H
OUTDO	EQU	00018H
DCOMPR	EQU	00020H
ENASLT	EQU	00024H
IDBYT0	EQU	0002BH
IDBYT2	EQU	0002DH
L0034	EQU	00034H			; double byte header char table
CHGET	EQU	0009FH
CHPUT	EQU	000A2H
CALBAS	EQU	00159H
LDIRMV	EQU	00059H
LDIRVM	EQU	0005CH
TOTEXT	EQU	000D2H
ERAFNK	EQU	000CCH
CKCNTC	EQU	000BDH
SNSMAT	EQU	00141H
KILBUF	EQU	00156H
CHGCPU	EQU	00180H

L0080	EQU	00080H
LBC00	EQU	0BC00H			; ramdisk bootsector
LBE00	EQU	0BE00H			; number of ramdisksegments
LBE02	EQU	0BE02H			; ramdisk segmenttable

LF1C9	EQU	0F1C9H			; BDOS _STROUT
LF1D3	EQU	0F1D3H			; transfer to/from page 1
LF1DF	EQU	0F1DFH			; interslot call with prompt handler
LF1E2	EQU	0F1E2H			; start DOS1 style handler
LF1E5	EQU	0F1E5H			; KEYINT handler
LF1E8	EQU	0F1E8H			; RDSLT handler
LF1EB	EQU	0F1EBH			; WRSLT handler
LF1EE	EQU	0F1EEH			; CALSLT handler
LF1F1	EQU	0F1F1H			; ENASLT handler
LF1F4	EQU	0F1F4H			; CALLF handler
LF1FD	EQU	0F1FDH			; enable DOS RAM on page 0
LF206	EQU	0F206H			; RD_SEG handler
LF218	EQU	0F218H			; PUT_P0 handler
LF21B	EQU	0F21BH			; GET_P0 handler
LF21E	EQU	0F21EH			; PUT_P1 handler
LF221	EQU	0F221H			; GET_P1 handler
LF224	EQU	0F224H			; PUT_P2 handler
LF227	EQU	0F227H			; GET_P2 handler
LF23C	EQU	0F23CH			; default drive
LF24F	EQU	0F24FH			; PROMPT hook, also start of DSK hooks
LF2B8	EQU	0F2B8H			; number of interrupts per 100 ms
LF2B9	EQU	0F2B9H			; interrupt counter
LF2BA	EQU	0F2BAH			; random number, used for compose a random diskserial
LF2BD	EQU	0F2BDH			; no keyboard check counter
LF2BE	EQU	0F2BEH			; screenoutput buffer counter
LF2BF	EQU	0F2BFH			; disk unchanged counter
LF2C0	EQU	0F2C0H			; saved H.TIMI hook
LF2CF	EQU	0F2CFH			; BDOS data segment
LF2D0	EQU	0F2D0H			; BDOS code segment
LF2D5	EQU	0F2D5H			; saved EXTBIO hook
LF2DA	EQU	0F2DAH			; adres message handler
LF2DC	EQU	0F2DCH			; adres prompt handler
LF2DE	EQU	0F2DEH			; adres BDOS handler
LF2E1	EQU	0F2E1H			; temporary save for transferadres ramdisk DSKIO
LF2E3	EQU	0F2E3H			; temporary save for sectornumber ramdisk DSKIO
LF2E5	EQU	0F2E5H			; temporary save for number of sectors ramdisk DSKIO
LF2E6	EQU	0F2E6H			; temporary save for IX parameter BDOS
LF2E8	EQU	0F2E8H			; temporary save for SP BDOS
LF2F1	EQU	0F2F1H			; adres BLOAD handler
LF2F3	EQU	0F2F3H			; adres BSAVE handler
LF2F5	EQU	0F2F5H			; pointer to buffer for transfering BDOS structures
LF2F7	EQU	0F2F7H			; pointer to buffer for transfering BDOS FIB
LF2F9	EQU	0F2F9H			; pointer to buffer for transfering BDOS FIB or Path
LF2FB	EQU	0F2FBH			; pointer to buffer for transfering BDOS errorstrings
LF2FD	EQU	0F2FDH			; bootdrive
LF2FE	EQU	0F2FEH			; pointer to temporary stack for BDOS
LF300	EQU	0F300H			; pointer to diskerror handler
LF302	EQU	0F302H			; pointer to abort handler
LF306	EQU	0F306H			; ?
RAWFLG	EQU	0F30DH			; verify flag
LF30E	EQU	0F30EH			; date format
LF30F	EQU	0F30FH			; double byte header table
LF313	EQU	0F313H			; DOS2 version
LF314	EQU	0F314H			; TPA segment page 0
LF315	EQU	0F315H			; TPA segment page 1
LF316	EQU	0F316H			; TPA segment page 2
LF323	EQU	0F323H			; DOS1 style diskerror handler pointer
LF325	EQU	0F325H			; DOS1 style abort handler pointer
LF327	EQU	0F327H			; AUX input hook
LF333	EQU	0F333H			; pointer to BDOS handler
LF338	EQU	0F338H			; clockchip available flag (always 0FFH with DOS2)
LF33B	EQU	0F33BH			; pointer to pathbuffer
LF33D	EQU	0F33DH			; recordsize random filemode basic
LF33F	EQU	0F33FH			; driveid (used in PROMPT), CTRL key status in DISK init
LF340	EQU	0F340H			; first start DiskBASIC flag
LF341	EQU	0F341H			; slotid DOS ram page 0
RAMAD1	equ	0F342H			; slotid DOS ram page 1
RAMAD2	equ	0F343H			; slotid DOS ram page 2
LF343	EQU	0F343H
LF344	EQU	0F344H			; slotid DOS ram page 3
LF346	EQU	0F346H			; MSXDOS started flag
LF347	EQU	0F347H			; number of drives
LF348	EQU	0F348H			; slotid disksystem ROM
LF349	EQU	0F349H			; bottom of basic disksystem
LF34B	EQU	0F34BH			; bottom of msxdos disksystem
LF34D	EQU	0F34DH			; pointer to sector buffer for diskdriver
_SECBUF equ	0F34DH
LF34F	EQU	0F34FH			; biggest sectorsize in disksystem
LF351	EQU	0F351H			; pointer to sector buffer for BASIC
LF353	EQU	0F353H			; pointer to DPB for RAMDISK
LF355	EQU	0F355H			; DPB pointertable
LF365	EQU	0F365H			; read primary slotregister
XF368	EQU	0F368H			; enable disksystem ROM on page 1
XF36B	EQU	0F36BH			; enable TPA RAM on page 2
XFER	EQU	0F36EH			; transfer to/fram TPA RAM on page 2
XF36E	EQU	0F36EH
LF377	EQU	0F377H			; interslot call to BDOS code segment
LF37A	EQU	0F37AH			; interslot call to BDOS handler in BDOS code segment
LF37D	EQU	0F37DH			; BDOS entry

M268C	EQU	0268CH			; subtract double
M269A	EQU	0269AH			; add double
M289F	EQU	0289FH			; divide double
M2EF3	EQU	02EF3H			; copy to HL
M2F08	EQU	02F08H			; copy DAC to HL
M2F10	EQU	02F10H			; copy HL to DAC
M2F99	EQU	02F99H			; copy HL in DAC
M3042	EQU	03042H			; convert DAC from single to double
M30D1	EQU	030D1H			; INT
M325C	EQU	0325CH			; multiply single
M3FD6	EQU	03FD6H			; pointer to zero byte
M406F	EQU	0406FH			; error
M409B	EQU	0409BH			; start basic
M475A	EQU	0475AH			; illegal function call
M4173	EQU	04173H			; execute statement
M4253	EQU	04253H			; convert linenumbers to pointers
M4601	EQU	04601H			; execute
M4666	EQU	04666H			; CHRGTR
M46FF	EQU	046FFH			; convert unsigned integer to single
M4756	EQU	04756H			; evaluate word operand
M4AFF	EQU	04AFFH			; return interpreter output to screen
M4C5F	EQU	04C5FH			; evaluate =expression
M4C64	EQU	04C64H			; evaluate expression
M517A	EQU	0517AH			; convert DAC to other type
M520F	EQU	0520FH			; evaluate experssion and convert to positive integer
M521B	EQU	0521BH			; evaluate next byte operand
M521C	EQU	0521CH			; evaluate byte operand
M521F	EQU	0521FH			; convert to byte
M537B	EQU	0537BH			; convert DAC to text, unformatted
M542F	EQU	0542FH			; evaluate adres operand
M5432	EQU	05432H			; convert to adres
M54F7	EQU	054F7H			; convert pointers to linenumbers
M5597	EQU	05597H			; GETYPR
M6627	EQU	06627H			; allocate temp string
M668E	EQU	0668EH			; allocate stringspace
M67D0	EQU	067D0H			; free temporary stringdescriptor
M6A0E	EQU	06A0EH			; evaluate filename
M6A6D	EQU	06A6DH			; get I/O channel pointer
M6AFA	EQU	06AFAH			; open I/O channel
M6B24	EQU	06B24H			; close I/O channel
M6C1C	EQU	06C1CH			; close all I/O channels
M6E41	EQU	06E41H			; resume point character putback routine
M6E92	EQU	06E92H			; start of BSAVE statement
M6EC6	EQU	06EC6H			; start of BLOAD statement
M6EF4	EQU	06EF4H			; BLOAD endcode
M6F0B	EQU	06F0BH			; evaluate BLOAD/BSAVE adres operand
M6F1D	EQU	06F1DH			; devicename parser, less restrictive
M7323	EQU	07323H			; newline to OUTDO if not at start of line
M7328	EQU	07328H			; newline to OUTDO
M739A	EQU	0739AH			; quit loading and start
M7D2F	EQU	07D2FH			; initialize basic screen
M7D31	EQU	07D31H			; continue initializing basic screen
M7D17	EQU	07D17H			; continue after starting basic program in extension rom
M7DE9	EQU	07DE9H			; start basic program in extension rom

A58A8	EQU	058A8H			; continue to disksystem 1.x init


VARWRK	EQU	0F380H
LF38B	EQU	0F38BH			; on this adres is a simple RET instruction
USRTAB	EQU	0F39AH
LINLEN	EQU	0F3B0H
CNSDFG	EQU	0F3DEH
LPTPOS	EQU	0F415H
PRTFLG	EQU	0F416H
CURLIN	EQU	0F41CH
KBUF	EQU	0F41FH
BUF	EQU	0F55EH
TTYPOS	EQU	0F661H
VALTYP	EQU	0F663H
MEMSIZ	EQU	0F672H
STKTOP	EQU	0F674H
TXTTAB	EQU	0F676H
TEMPPT	EQU	0F678H
DSCTMP	EQU	0F698H
FRETOP	EQU	0F69BH
AUTLIN	EQU	0F6ABH			; used for bigest sectorsize during disksystem init
SAVSTK	EQU	0F6B1H
VARTAB	EQU	0F6C2H
STREND	EQU	0F6C6H
DAC	EQU	0F7F6H
ARG	EQU	0F847H
MAXFIL	EQU	0F85FH
FILTAB	EQU	0F860H
NULBUF	EQU	0F862H
PTRFIL	EQU	0F864H
FILNAM	EQU	0F866H
NLONLY	EQU	0F87CH
SAVEND	EQU	0F87DH
HOKVLD	EQU	0FB20H			; EXTBIO valid flag (b0)
DRVTBL	EQU	0FB21H			; diskdriver table
DRVINT	EQU	0FB29H			; diskdriver interrupt table
BASROM	EQU	0FBB1H
BOTTOM	EQU	0FC48H
HIMEM	EQU	0FC4AH
FLBMEM	EQU	0FCAEH
RUNBNF	EQU	0FCBEH
SAVENT	EQU	0FCBFH
EXPTBL	EQU	0FCC1H
SLTTBL	EQU	0FCC5H
SLTWRK	EQU	0FD09H
PROCNM	EQU	0FD89H
DEVICE	EQU	0FD99H			; used temp for diskdriver count
H.TIMI	EQU	0FD9FH
H.DSKO	EQU	0FDEFH
H.NAME	EQU	0FDF9H
H.KILL	EQU	0FDFEH
H.COPY	EQU	0FE08H
H.DSKF	EQU	0FE12H
H.DSKI	EQU	0FE17H
H.LSET	EQU	0FE21H
H.RSET	EQU	0FE26H
H.FIEL	EQU	0FE2BH
H.MKI$	EQU	0FE30H
H.MKS$	EQU	0FE35H
H.MKD$	EQU	0FE3AH
H.CVI	EQU	0FE3FH
H.CVS	EQU	0FE44H
H.CVD	EQU	0FE49H
H.GETP	EQU	0FE4EH
H.NOFO	EQU	0FE58H
H.NULO	EQU	0FE5DH
H.NTFL	EQU	0FE62H
H.BINS	EQU	0FE71H
H.BINL	EQU	0FE76H
H.FILE	EQU	0FE7BH
H.DGET	EQU	0FE80H
H.FILO	EQU	0FE85H
H.INDS	EQU	0FE8AH
H.LOC	EQU	0FE99H
H.LOF	EQU	0FE9EH
H.EOF	EQU	0FEA3H
H.BAKU	EQU	0FEADH
H.PARD	EQU	0FEB2H
H.NODE	EQU	0FEB7H
H.POSD	EQU	0FEBCH
H.RUNC	EQU	0FECBH
H.CLEA	EQU	0FED0H
H.LOPD	EQU	0FED5H
H.STKE	EQU	0FEDAH
H.ERRP	EQU	0FEFDH
H.PHYD	EQU	0FFA7H
H.FORM	EQU	0FFACH
EXTBIO	EQU	0FFCAH		; extended BIOS entry
DISINT	equ	0FFCFH
ENAINT	equ	0FFD4H
LFFFF	EQU	0FFFFH


        INCLUDE	DISK.INC


        DEFB	"AB"
        DEFW	L403C		; Init routine
        DEFW	L575C		; Call routine
        DEFW	0
        DEFW	0
        DEFW	0
        DEFW	0
        DEFW	0

L4010:	JP	DSKIO		; DRIVER: DSKIO
L4013:	JP	DSKCHG		; DRIVER: DSKCHG
L4016:	JP	GETDPB		; DRIVER: GETDPB
L4019:	JP	CHOICE		; DRIVER: CHOICE
L401C:	JP	DSKFMT		; DRIVER: DSKFMT
L401F:	JP	MTOFF		; DRIVER: MTOFF

; The following routine are used by MSXDOS1

L4022:	JP	L4B1B		; SYSTEM: Start DiskBASIC
L4025:	SCF			; SYSTEM: Format disk
        JP	L4E67
L4029:	JP	L4CD3		; SYSTEM: Stop drives
        NOP
GETSLT:
L402D:	JP	L4E05		; SYSTEM: Get own slotid
L4030:	LD	HL,(LF34B)	; SYSTEM: Get system boundary
        RET

; 04034H
; DOS1 kernel compatible: CP/M BIOS CONST entry
; This entry is supported, to use MSXDOS.SYS

L4034:	JP	L4177

        DEFS	04038H-$,0

; 04038H
; DOS2: pointer to kernel version ASCIIZ string

L4038:	DEFW	L411E

        DEFS	0403CH-$,0

L403C:	XOR	A
        CALL	L40A3
        JP	L47D6

L4043:	CALL	L410C		; EXTBIO for DOS2 mapperfunctions
        JP	LF2D5		; cont EXTBIO

L4049:	PUSH	AF
        LD	A,(L40FF)
        PUSH	AF
        XOR	A
        CALL	L40A3
        CALL	L4CF3		; timi routine DOS2
        POP	AF
        CALL	L40A3
        POP	AF
        RET

L405B:	CALL	L40A3
        EX	AF,AF'
        CALL	L4069
        EX	AF,AF'
        XOR	A
        CALL	L40A3
        EX	AF,AF'
        RET

L4069:	JP	(IX)

        DEFS	04078H-$,0

; 04078H
; DOS1 kernel compatible: CP/M BIOS CONIN entry
; This entry is supported, to use MSXDOS.SYS

L4078:	JP	L417C

        DEFS	04080H-$,0

; DOS2: RAMDISK driver jumpentries

L4080:	JP	R_DSKIO		; RAMDISK: DSKIO routine
L4083:	JP	R_DSKCHG	; RAMDISK: DSKCHG routine
L4086:	JP	R_GETDPB	; RAMDISK: GETDPB routine
L4089:	JP	R_CHOICE	; RAMDISK: CHOICE routine
L408C:	JP	R_DSKFMT	; RAMDISK: DSKFMT routine

        DEFS	0408FH-$,0

; 0408F
; DOS1 kernel compatible: CP/M BIOS CONOUT entry
; This entry is supported, to use MSXDOS.SYS

L408F:	JP	L4181

        DEFS	040A6H-$-3,0

; This one must start at #40A3, because there must be a RET
; instruction at end for switching to DOS1 kernel.
; At #40A6 is at RET instruction in DOS1 kernel

L40A3:
        BNKCHG

L40A6:	RET

        DEFS	040FFH-$,0

L40FF:	DEFB	0		; present bank number register

; The following routines call a routine in ROM bank 1
; the routine called depens from the call adress
; for example L4100 calls L4100 on bank 1, so add 00h to the caller

L4100:	CALL	L410F		; Check and invoke memorymapper of 6 or more segments
L4103:	CALL	L410F		; install disksystem routines
L4106:	CALL	L410F		; copy message to buffer
L4109:	CALL	L410F		; copy errorstring to buffer
L410C:	CALL	L410F		; EXTBIO handler memorymapper

L410F:	POP	IX		; Returnaddress
        PUSH	BC
        LD	BC,-3		; Offset adjust
        EX	AF,AF'
        LD	A,1		; ROM bank 1
        ADD	IX,BC		; Routine address
        POP	BC
        JP	L405B		; Invoke routine

L411E:	DEFB	"MSX-DOS kernel version 2.31"
        DEFB	0

L413A:	DEFB	"Disk BASIC version 2.01"
        DEFB	0
        DEFB	"Copyright (C) 1991 ASCII Corporation"
        DEFB	0

        DEFB	"0618"
        DEFB	0

L4177:	LD	HL,0086H
        JR	L4185

L417C:	LD	HL,0080H
        JR	L4185

L4181:	LD	C,A
        LD	HL,0083H
L4185:	JP	LF377

        DEFS	041EFH-$,201
;
; BDOS 00CH ENTRY
;
L41EF:	LD	C,00CH
        JP	L4F54

        DEFS	0436CH-$,201
;
; BDOS 013H ENTRY
;
L436C:	LD	C,013H
        JP	L4F54

        DEFS	04392H-$,201
;
; BDOS 017H ENTRY
;
L4392:	LD	C,017H
        JP	L4F54

        DEFS	04462H-$,201
;
; BDOS 00FH ENTRY
;
L4462:	LD	C,00FH
        JP	L4F54

        DEFS	0456FH-$,201
;
; BDOS 010H ENTRY
;
L456F:	LD	C,010H
        JP	L4F54

        DEFS	0461DH-$,201
;
; BDOS 016H ENTRY
;
L461D:	LD	C,016H
        JP	L4F54

        DEFS	046BAH-$,201
;
; BDOS 02FH ENTRY
;
L46BA:	LD	C,02FH
        JP	L4F54

        DEFS	04720H-$,201
;
; BDOS 030H ENTRY
;
L4720:	LD	C,030H
        JP	L4F54

        DEFS	04775H-$,201
;
; BDOS 014H ENTRY
;
L4775:	LD	C,014H
        JP	L4F54

        DEFS	0477DH-$,201
;
; BDOS 015H ENTRY
;
L477D:	LD	C,015H
        JP	L4F54

        DEFS	04788H-$,201
;
; BDOS 021H ENTRY
;
L4788:	LD	C,021H
        JP	L4F54

        DEFS	04793H-$,201
;
; BDOS 022H ENTRY
;
L4793:	LD	C,022H
        JP	L4F54

        DEFS	047B2H-$,201
;
; BDOS 027H ENTRY
;
L47B2:	LD	C,027H
        JP	L4F54

        DEFS	047BEH-$,201
;
; BDOS 026H ENTRY
;
L47BE:	LD	C,026H
        JP	L4F54

        DEFS	047D1H-$,201
;
; BDOS 028H ENTRY
;
L47D1:	LD	C,028H
        JP	L4F54
;
; SPACE 047D6H - 04FB7 USED OTHERWISE IN DOS1 ROM
;
L47D6:	CALL	INIHRD		; INIHRD routine
        DI
        LD	A,(IDBYT2)
        OR	A
        RET	Z		; Quit if MSX1
        LD	A,(DEVICE)
        OR	A		; Do not init Disksystem ?
        JP	M,L4817		; yep, quit
        JP	NZ,L4865	; Other DISKROM already started the init, no init
        LD	HL,HOKVLD
        BIT	0,(HL)		; Extended BIOS initialized ?
        JR	NZ,L47F9	; Yes, do not init
        SET	0,(HL)
        LD	HL,EXTBIO
        LD	B,3*5
L47F4:	LD	(HL),0C9H
        INC	HL
        DJNZ	L47F4		; Init EXTBIO, DISINT and ENAINT hooks
L47F9:	LD	HL,(BOTTOM)
        LD	DE,0C000H+1
        RST	DCOMPR 		; Check if there is at least 16 Kb
        JR	NC,L4817	; No, flag do not init disksystem and quit
        LD	HL,(HIMEM)
        LD	DE,VARWRK
        RST	DCOMPR 		; Check if HIMEM is still #F380
        JR	NZ,L4817	; No, flag do not init disksystem and quit
        LD	A,6
        CALL	SNSMAT
        DI
        RRCA			; Check if SHIFT is pressed
        JR	C,L481D		; No, continue
        LD	A,7
        RST	OUTDO 		; Beep
L4817:	LD	A,0FFH
        LD	(DEVICE),A	; Flag do not init disksystem

        IF	TURBOR EQ 1
        XOR	A
        CALL	SNSMAT
        BIT	1,A
        LD	A,082H
        CALL	NZ,CHGCPU	; "1" key not pressed, switch to R800 RAM cpumode
        ENDIF

        RET

L481D:	CALL	L492A		; Check and invoke Memmap with at least 6 pages
        RET	C		; Not found, no disksystem 2.x
        LD	HL,001B7H
        CALL	L5604		; Reserve #01B7 bytes
        RET	C		; Not available, no disksystem 2.x
        LD	BC,001B7H
L482B:	XOR	A
        LD	(HL),A
        INC	HL
        DEC	BC
        LD	A,C
        OR	B
        JR	NZ,L482B	; Clear this memory
        LD	(AUTLIN),BC	; Current bigest sectorsize = 0
        LD	B,4*2+4*3
        LD	HL,DRVTBL
L483C:	LD	(HL),A
        INC	HL
        DJNZ	L483C		; Clear diskROM tables
        LD	HL,LF24F
        LD	B,069H
L4845:	LD	(HL),0C9H
        INC	HL
        DJNZ	L4845		; Init diskROM hooks
        LD	HL,LF365
        LD	(HL),0DBH
        INC	HL
        LD	(HL),0A8H
        INC	HL
        LD	(HL),0C9H	; Init routine #F365
        LD	A,6
        CALL	SNSMAT
        DI
        AND	02H
        LD	(LF33F),A	; Store CTRL-status
        LD	A,7
        RST	OUTDO 		; Beep
        JR	L4870		; I am doing the init!
;
; other disksystem rom has already started disksystem init
;
L4865:	LD	A,(LF313)
        CP	023H		; Check if other disksystem rom has version 2.3 or higher
        JR	NC,L4888	; yep, I do not need to take control
        CALL	L492A		; Check and invoke Memmap with 6 or more pages
        RET	C		; Failed, I am not doing the init!
;
; I am doing the disksystem init
;
L4870:	LD	A,023H
        LD	(LF313),A	; disksystem 2.3 running !
        CALL	L402D		; Get my slot
        LD	HL,H.RUNC
        LD	(HL),0F7H
        INC	HL
        LD	(HL),A
        INC	HL
        LD	(HL),LOW L495B
        INC	HL
        LD	(HL),HIGH L495B
        INC	HL
        LD	(HL),0C9H	; Init H.RUNC for futher disksystem init
;
; intialize for drives supported by this diskrom
;
L4888:	CALL	L4906		; Check DRVTBL
        RET	Z		; all entries used or already 8 drives, quit
        LD	HL,MYSIZE
        CALL	L5604		; Reserve bytes for envirionment
        JR	C,L48FE		; Not available, quit but update number of diskdrivers sofar
        EX	DE,HL
        CALL	L4DBB		; Get address of my WORD in SLTWRK
        LD	(HL),E
        INC	HL
        LD	(HL),D		; register the start of my environment
        LD	HL,(AUTLIN)
        LD	DE,SECLEN
        RST	DCOMPR 		; is my sectorsize bigest so far ?
        JR	NC,L48A8	; No,
        LD	(AUTLIN),DE	; Now it is
L48A8:	CALL	L4906		; Check DRVTBL (gets the free entry number)
        LD	HL,DRVTBL
        LD	D,0
        ADD	HL,DE
        ADD	HL,DE
        EX	DE,HL		; First free entry in Diskrom table
        LD	A,(LF33F)
        OR	A		; Flag CTRL-pressed
        LD	A,C		; Drives so far
        CALL	DRIVES		; DRIVES routine
        ADD	A,L 		; New number of drives
        CP	8+1
        JR	C,L48C2		; Not more as 8 drives, ok
        LD	A,8		; as much as possible
L48C2:	SUB	C
        JR	Z,L48FE		; zero possible, quit but update number of diskdrivers sofar
        LD	(DE),A		; Put drives in table
        INC	DE
        CALL	L402D		; Get my slot
        LD	(DE),A		; Put slotid in table
        LD	B,0
        LD	HL,LF355	; DPB tables
        ADD	HL,BC
        ADD	HL,BC
        PUSH	HL
        DEC	DE
        LD	A,(DE)		; Number of drives
        PUSH	AF
        LD	C,A
        ADD	A,A
        ADD	A,A
        ADD	A,C
        ADD	A,A
        ADD	A,A
        ADD	A,C
        LD	L,A
        LD	H,B		; 21 bytes per DPB
        CALL	L4C50		; Allocate with error
        EX	DE,HL
        POP	AF
        POP	HL
L48E5:	LD	(HL),E
        INC	HL
        LD	(HL),D		; Address DPB in DPB table
        INC	HL
        PUSH	HL
        LD	HL,DEFDPB
        LD	BC,21
        LDIR			; Init DPB with default
        POP	HL
        DEC	A
        JR	NZ,L48E5	; Again for others
        CALL	INIENV		; INIENV routine
        LD	HL,DEVICE
        INC	(HL)		; increase number of diskdrivers sofar
        RET

; set number of diskdrivers to 1 if this is the first diskrom but memory allocation for diskdriver fails
; by this, this diskrom stays in control of the disksystem init

L48FE:	LD	HL,DEVICE
        INC	(HL)
        DEC	(HL)		; diskROM's so far zero ?
        RET	NZ		; no, quit
        INC	(HL)		; Set 1 diskROM
        RET

L4906:	LD	HL,DRVTBL	; DiskROM table
        LD	B,4		; Max 4 DiskROM's
        XOR	A		; drives sofar 0
        LD	E,A		; entry 0
L490D:	LD	C,A		; save drives sofar
        ADD	A,(HL)
        JR	C,L4927		; >255, out of memory error and stall (because DRVTBL is invalid)
        CP	C
        JR	Z,L491B		; empty entry, check if remaining entries are empty too
        INC	E
        INC	HL
        INC	HL
        DJNZ	L490D		; Next entry
        CP	A		; Quit with Zx set (table full)
        RET

L491B:	ADD	A,(HL)
        CP	C
        JR	NZ,L4927	; not an empty entry, out of memory error and stall (because DRVTBL is invalid)
        INC	HL
        INC	HL
        DJNZ	L491B		; check next entry
        CP	8
        RET	Z		; Zx set if 8 drives (no more drives)
        RET	C		; Cx set if <8 drives
                                ; more as 8 drives, out of memory error and stall (because DRVTBL is invalid)

L4927:	JP	L4C54		; Out of memory error and stall

L492A:	CALL	L4E12		; Get slot id of current page 2
        CALL	L4100		; Check and invoke Memmap of 6 or more pages
        RET	C		; Failed
        LD	HL,5
        ADD	HL,SP
        IN	A,(0A8H)
        RRD			; user current page 2 and page 3 primary slot
        LD	(HL),A		; Change previous primair slotreg on stack
        CALL	L4E05		; Get slot
        BIT	7,A
        RET	Z		; my slot is not expanded, quit
        LD	HL,12
        ADD	HL,SP
        LD	C,A
        CALL	L4E21
        XOR	C
        AND	03H
        JR	NZ,L4954
        LD	A,(LFFFF)
        CPL
        RRD
        LD	(HL),A
L4954:	DEC	HL
        IN	A,(0A8H)
        RRD
        LD	(HL),A
        RET

;	  Subroutine H.RUNC interceptor
;	     Inputs  -
;	     Outputs -
;         Remark     Control is passed to this routine when the BASIC interpreter is initialized
;                    There are two ways: a BASIC program in ROM is started OR at the start of MSX-BASIC

L495B:	LD	HL,H.RUNC
        LD	B,5
L4960:	LD	(HL),0C9H
        INC	HL
        DJNZ	L4960		; Clear H.RUNC
        LD	HL,DEVICE
        LD	A,(HL)
        LD	(HL),B		; clear DEVICE variable
        OR	A
        RET	M		; error in Diskrom init procedure, quit
        LD	D,A
        CALL	L4906		; Check DRVTBL
        LD	(LF347),A	; Store number of drives
        LD	A,D		; Number of diskdrivers done init
        SUB	E		; - number of diskdrivers in table
        JR	Z,L4986		; Equal, ok
        DEC	A		; Check if 1 extra (through DOS2 without diskdriver as first diskrom initialized)
        JP	NZ,L4C54	; No, generate out of memory error and stall (error in diskdriver tables)
        LD	DE,DRVINT
        LD	HL,DRVINT+3
        LD	BC,4*3
        LDIR			; Leave out 1st interrupt routine (is not used by DOS2 without a diskdriver)
L4986:	CALL	L402D		; Get my slot
        LD	(LF348),A	; System DiskROM
        LD	HL,L0034
        LD	DE,LF30F
        LD	BC,4
        LDIR			; initialize double byte header char table
        LD	A,(IDBYT0)
        RRCA
        RRCA
        RRCA
        RRCA
        AND	07H
        LD	(LF30E),A	; Store date format
        LD	HL,LF327
        LD	(HL),03EH
        INC	HL
        LD	(HL),01AH
        INC	HL
        LD	B,3+5
L49AE:	LD	(HL),0C9H
        INC	HL
        DJNZ	L49AE		; Init hook area AUX device
        LD	A,0CDH
        LD	HL,XF368
        LD	(LF1C9+0),A
        LD	(LF1C9+1),HL
        LD	A,0C3H
        LD	HL,L53AC
        LD	(LF1C9+3),A
        LD	(LF1C9+4),HL	; Init routine F1C9h
        LD	HL,L4109
        LD	(LF2DA),HL	; Init address message generator
        LD	HL,L4D32
        LD	(LF2DC),HL	; Init address prompt routine
        LD	HL,L6A82
        LD	(LF2DE),HL	; Init BDOS handling routine
        LD	HL,L6A86
        LD	(LF333),HL	; Init DiskBasic BDOS handling routine
        LD	A,0FFH
        LD	(LF338),A	; Set flag clockchip available ?
        LD	HL,21
        CALL	L4C50		; Allocate 21 byte with error
        LD	(LF353),HL	; DPB for RAMDISK
        LD	HL,(AUTLIN)
        LD	DE,512
        RST	DCOMPR 		; Check if biggest sectorsize < 512 bytes
        JR	NC,L49F9
        EX	DE,HL		; Yes, take 512 bytes
L49F9:	LD	(LF34F),HL
        INC	HL		; +1 (FAT valid flag DOS1)
        CALL	L4C50		; Allocate with error
        LD	(HL),0		; FAT buffer status unchanged
        INC	HL
        LD	(LF34D),HL	; Store Address media sectorbuffer
        LD	HL,LF353	; DPB table RAMDISK
        LD	BC,09FFH	; RAMDISK + 8 drives
L4A0C:	LD	E,(HL)
        INC	HL
        LD	D,(HL)
        INC	HL
        LD	A,E
        OR	D		; DPB available ?
        JR	Z,L4A24		; nop, skip
        EX	DE,HL
        LD	(HL),C		; Set drivenumber
        PUSH	BC
        LD	BC,19
        ADD	HL,BC
        LD	BC,(LF34D)
        LD	(HL),C
        INC	HL
        LD	(HL),B		; Pointer to FAT = media sectorbuffer
        POP	BC
        EX	DE,HL
L4A24:	INC	C
        DJNZ	L4A0C
        CALL	L4E12		; Get Slotid of current page 2
        CALL	L4103		; install disksystem routines
        JP	C,L4C54		; Error, generate out of memory error and stall
        LD	HL,100+64+100+64
        CALL	L4C50		; Allocate 328 bytes with error
        LD	(LF2F5),HL
        LD	DE,100
        ADD	HL,DE		; 100 bytes for
        LD	(LF2F7),HL
        LD	DE,64
        ADD	HL,DE		; 64 bytes for
        LD	(LF2F9),HL
        LD	DE,100
        ADD	HL,DE		; 100 bytes for
        LD	(LF2FB),HL
        LD	HL,(HIMEM)
        LD	(LF349),HL	; highest memory used by basic system
        LD	HL,H.TIMI
        PUSH	HL
        LD	DE,LF2C0
        LD	BC,5
        LDIR			; copy H.TIMI to #F2C0
        POP	HL
        LD	DE,L4049
        CALL	L4C73		; init H.TIMI naar routine L4049
        LD	HL,EXTBIO
        LD	DE,LF2D5
        LD	BC,5
        PUSH	HL
        LDIR			; copy H.EXTBIO to #F2D5
        POP	HL
        LD	DE,L4043
        CALL	L4C73		; init H.EXTBIO naar routine L4043
        CALL	L56A5		; init hooks
        LD	HL,M7D2F+1
        LD	A,(EXPTBL+0)
        CALL	RDSLT
        PUSH	AF
        INC	SP
        DEC	HL
        LD	A,(EXPTBL+0)
        CALL	RDSLT
        PUSH	AF
        INC	SP
        POP	IX		; Get address of SCREEN INIT
        LD	IY,(EXPTBL+0-1)
        CALL	CALSLT		; do SCREEN INIT
        CALL	L4C66		; Check H.CLEA and take action
        LD	SP,0C200H
        CALL	I_CHKKEY	; (EXTRA KERNEL 2.31)
        LD	A,(H.STKE)
        CP	0C9H		; Check if H.STKE is hooked by a ROM
        LD	IX,M7D17
        JR	NZ,L4ABB	; yes, initialize DiskBasic and start MSX-BASIC (via H.STKE, ROM takes control)
        LD	A,(BASROM)
        OR	A		; control passed when BASIC ROM program was started ?
        LD	IX,M7DE9
        JR	NZ,L4ABB	; yep, initialize DiskBasic and start BASIC ROM program
        CALL	L4C16		; routines XFER, SetRamPg1, SetRomPg1 inactive
        LD	A,(LF344)	; (EXTRA KERNEL 2.31)
        LD	(LF343),A	; (EXTRA KERNEL 2.31) TPA slotid page 2 system memorymapper
        JR	L4AC1

L4ABB:
        CALL	I_CHKDEF	; (EXTRA KERNEL 2.31) Check if DEFUSR0 defined, if not DOS1
        CALL	L4BE8		; DiskBASIC init
        JP	CALBAS		; restart

L4AC1:	LD	HL,L4B1B
        PUSH	HL 		; Return to invoke DiskBasic
        LD	A,(LF2FD)	; (EXTRA KERNEL 2.31)
        OR	A		; (EXTRA KERNEL 2.31) bootdrive specified (by driver) ?
        JR	NZ,L4AD7	; (EXTRA KERNEL 2.31) yep, start MSX-DOS2
        CALL	L694A		; Try to load bootsector from drive
        RET	Z		; Not succesfull, Basic
        CALL	I_CHKDSK	; (REPLACE CALL 4AFB KERNEL 2.31) check if volid, if not DOS1 else start bootloader with Cx reset
        LD	HL,(BOTTOM)
        LD	DE,08000H
        RST	DCOMPR 		; Check if BOTTOM = #8000
        RET	NZ		; No, invoke DiskBasic
        LD	A,(LF23C)	; default drive
L4AD7:	LD	HL,L4B18
        JR	L4ADF

L4ADC:	LD	A,(LF2FD)	; bootdrive
L4ADF:	LD	SP,0C200H
        PUSH	HL
        LD	HL,L4B1B
        EX	(SP),HL
        PUSH	AF
        LD	A,0FFH
        LD	(LF346),A	; _SYSTEM possible
        POP	AF
        CALL	L68B3		; Do DOS INIT & Try to load and start MSXDOS2.SYS
        LD	A,(LF340)	; (EXTRA KERNEL 2.31)
        OR	A		; (EXTRA KERNEL 2.31) DiskBASIC has started ?
        RET	NZ		; (EXTRA KERNEL 2.31) yep, do not boot
        CALL	L694A		; Try to load bootsector from drive
        RET	Z		; Failed, invoke DiskBasic
        CALL	I_CHKVOL	; (EXTRA KERNEL 2.31) volid on disk ?
        RET	NZ		; (EXTRA KERNEL 2.31) nop, invoke DiskBASIC
        LD	A,0C3H
        CALL	L4C18		; routines XFER, SetRamPg1, SetRomPg1 active
        SCF			; start bootloader with Cx set

L4AFB:	LD	HL,LF323	; diskerror handler pointer
        LD	DE,XF368
        LD	A,(LF340)
        JP	0C01EH

L4B07:	DEFB	'RUN"\AUTOEXEC.BAS'
L4B18:	DEFB	0

L4B19:	DEFW	L4B7B

L4B1B:	LD	SP,0C200H
        CALL	L4C16		; XFER,SetRAM1,SetROM inactive
        LD	HL,L4B07
        LD	DE,BUF+10+2
        LD	BC,18
        LDIR			; Copy RUN"\AUTOEXEC.BAS to #F56A
        LD	HL,LF340
        LD	A,(HL)
        OR	A		; Check if first start of DiskBASIC
        LD	(HL),H		; Next time it's not the first time
        JR	NZ,L4B50	; Nop, check parameters
        LD	(LF346),A	; DOS wasn't running
        LD	HL,L4B19	;  with error, just start DiskBASIC
        LD	(LF323),HL	; set diskerror handler
        LD	DE,BUF+10+6
        LD	A,1		; read only
        LD	C,043H
        CALL	LF37D		; OPEN
        JR	NZ,L4B7B	; No, quit
        LD	C,045H
        CALL	LF37D		; CLOSE
        JR	L4B7F
L4B50:	LD	A,(0)
        CP	0C3H		; Check DOS was really active
        JR	NZ,L4B7B	; No, quit
        LD	HL,L0080
        LD	B,(HL)
        INC	B
        DEC	B
        JR	Z,L4B7B		; No parameter, quit
L4B5F:	INC	HL
        LD	A,(HL)
        CALL	L4B6A
        JR	NZ,L4B70	; No space, go
        DJNZ	L4B5F		; Skip space
        JR	L4B7B

L4B6A:	CP	9
        RET	Z
        CP	" "
        RET

L4B70:	XOR	A
        LD	C,B
        LD	B,A
        LD	DE,BUF+10+6
        LDIR
        LD	(DE),A		; Copy filename to RUN"....
        JR	L4B7F		; Run it

L4B7B:	XOR	A
        LD	(BUF+10+5),A	; Zero behind RUN (only RUN executed)
L4B7F:	LD	SP,0C200H
        LD	A,(LF343)
        LD	H,080H
        CALL	ENASLT		; RAM on page 2
        LD	A,(EXPTBL+0)
        LD	H,0
        CALL	ENASLT		; Main-BIOS on page 0
        CALL	L4BE8		; DiskBASIC init
L4B95:	LD	BC,0061H	; join to root
        CALL	LF37D		; JOIN
        JR	NZ,L4B95
        LD	HL,(BOTTOM)
        XOR	A
        LD	(HL),A		; On BOTTOM a zero marker
        INC	HL
        LD	(TXTTAB),HL	; TXTTAB (basic text begins here)
        LD	(HL),A
        INC	HL
        LD	(HL),A		; Zero address (no program)
        INC	HL
        LD	(VARTAB),HL	; VARTAB (variables behind the program)
        LD	HL,0FFFFH
        LD	(CURLIN),HL	; CURLIN = #FFFF (direct mode)
        LD	SP,(STKTOP)	; Basic Stack
        LD	A,0FFH
        LD	(CNSDFG),A	; Functionkeys on
        LD	IX,M7D31
        CALL	CALBAS		; continue INIT image without screen init & keys
        CALL	L4D61		; Print CR/LF
        LD	DE,L413A
        CALL	L4D7D		; Print DiskBasic version text
        CALL	L4D61		; Print CR/LF
        LD	HL,M4173
        PUSH	HL 		; routine in BASIC to execute instruction
        LD	HL,BUF+10+2-1	; address with instruction (RUN...)
        PUSH	HL
        LD	HL,BUF+10
        PUSH	HL
        LD	(HL),0E1H
        INC	HL
        LD	(HL),0C9H	; POP HL, RET routine to start instr.
        LD	A,(EXPTBL+0)
        LD	H,040H
        JP	ENASLT		; Basic-ROM on page 1, invoke routine

L4BE8:	LD	HL,(LF349)
        LD	(HIMEM),HL
        CALL	L6A06		; restore default segment setting
        LD	HL,L6563	;  just abort
        LD	(LF323),HL	; set diskerror handler
        LD	HL,L6568
        LD	(LF325),HL	; set CTRL-STOP handler
        LD	BC,(LF34F)	; sectorsize
        CALL	L4C40		; allocate sectorbuffer
        LD	(LF351),HL	; basic temp sectorbuffer
        LD	(LF33B),HL	; basic temp pathname buffer
        LD	BC,13
        CALL	L4C40		; allocate
        CALL	L4C22		; install BSAVE/BLOAD 'hooks'
        CALL	L565C		; init variable part of BASIC
L4C16:	LD	A,0C9H
L4C18:	LD	(XF368+0),A
        LD	(XF36B+0),A
        LD	(XF36E+0),A
        RET

L4C22:	LD	(LF2F1),HL
        EX	DE,HL
        LD	HL,L4C90
        LDIR
        LD	HL,-5
        ADD	HL,DE
        LD	(LF2F3),HL
        LD	A,(LF348)
        LD	HL,-12
        ADD	HL,DE
        LD	(HL),A
        LD	HL,-4
        ADD	HL,DE
        LD	(HL),A
        RET

L4C40:	LD	HL,(HIMEM)
        OR	A
        SBC	HL,BC
        LD	(HIMEM),HL
        JR	C,L4C54		; out of memory error and stall
        LD	A,H
        CP	HIGH 0C200H
        JR	L4C53

L4C50:	CALL	L5604
L4C53:	RET	NC
L4C54:	LD	A,12
        CALL	L4D97		; Clear Screen
        LD	A,1		; #01 (Not enough memory)
        LD	DE,BUF
        CALL	L4106		; copy message to buffer
        CALL	L4D7D		; Print error
        DI
        HALT			; Go into halt state

L4C66:	LD	HL,H.CLEA
        LD	A,(HL)
        CP	0C9H		; Check if H.CLEA is hooked
        RET	Z		; no, stop
        LD	HL,H.LOPD
        LD	DE,L4C82	; Init H.LOPD to routine L4C82

L4C73:	LD	(HL),0F7H
        INC	HL
        LD	A,(LF348)
        LD	(HL),A
        INC	HL
        LD	(HL),E
        INC	HL
        LD	(HL),D
        INC	HL
        LD	(HL),0C9H
        RET

L4C82:	LD	A,0C9H
        LD	(H.LOPD+0),A
        LD	DE,(HIMEM)
        LD	(LF349),DE
        RET

L4C90:	RST	CALLF
        DEFB	0
        DEFW	L5DB6
        PUSH	HL
        JP	M6EF4		; BLOAD endcode

        RST	CALLF
        DEFB	0
        DEFW	L5CF2
        RET

L4C9D:	EI
        PUSH	HL
        PUSH	AF
        CALL	L4CB9		; Search ROM with the drive
        JR	C,L4CAB		; Found, go
        SCF
        LD	A,12		; Other error (drive not found)
        POP	HL
        POP	HL
        RET
L4CAB:	LD	L,A
        POP	AF
        LD	A,L
        POP	HL
        PUSH	HL
        LD	IX,L4010
        CALL	LF1DF		; Call the DSKIO routine of drive
        POP	HL
        RET

L4CB9:	PUSH	BC
        LD	(LF33F),A	; Store requested driveid (0 = A:)
        LD	HL,DRVTBL	; DiskROM table
        LD	B,4		; Max. 4 ROM's
L4CC2:	SUB	(HL)
        JR	NC,L4CCD	; Not found the right ROM yet
        ADD	A,(HL)		; Back to driveid (ROM based)
        INC	HL
        LD	H,(HL)
        PUSH	HL
        POP	IY		; Slotid of ROM
        POP	BC
        RET
L4CCD:	INC	HL
        INC	HL
        DJNZ	L4CC2		; Next entry
        POP	BC
        RET

L4CD3:	LD	HL,DRVTBL
        LD	B,4
L4CD8:	INC	HL
        LD	A,(HL)
        PUSH	AF
        POP	IY
        INC	HL
        PUSH	HL
        PUSH	BC
        LD	HL,L401F
        PUSH	HL
        POP	IX
        OR	A
        CALL	NZ,RDSLT	; check if MTOFF entry
        OR	A
        CALL	NZ,LF1DF	; call MTOFF
        POP	BC
        POP	HL
        DJNZ	L4CD8
        RET

L4CF3:	PUSH	AF
        CALL	L6A44		; system interrupt routine
        CALL	L4CFE		; invoke interrupt routines of drivers
        POP	AF
        JP	LF2C0		; Orginal H.TIMI hook routine

L4CFE:	LD	DE,DRVTBL	; DiskROM table
        LD	HL,DRVINT	; DiskROM interrupt table
        LD	B,4
L4D06:	LD	A,(DE)
        AND	A
        RET	Z		; End of table, quit
        INC	DE
        LD	A,(DE)		; Slotid
        INC	DE
        CP	(HL)	 	; Same as in interrupt table
        JR	NZ,L4D27	; No, check next entry
        LD	A,(LF348)
        CP	(HL) 		; Same as ROM Disksystem
        LD	A,(HL)
        PUSH	BC
        PUSH	DE
        PUSH	HL
        INC	HL
        LD	E,(HL)
        INC	HL
        LD	D,(HL)		; Interrupt routine
        PUSH	AF
        POP	IY
        PUSH	DE
        POP	IX
        CALL	L4D2D		; Invoke routine
        POP	HL
        POP	DE
        POP	BC
L4D27:	INC	HL
        INC	HL
        INC	HL
        DJNZ	L4D06		; Next entry
        RET

L4D2D:	JP	NZ,CALSLT
        JP	(IX)

;
; PROMPT
;

PROMPT:
L4D32:	LD	A,(LF33F)
        ADD	A,"A"		; Driveletter
        CALL	LF24F		; Hook
        PUSH	AF
        CALL	L4D61		; Print CR/LF
        LD	A,7
        CALL	L4D6E		; Print "Insert diskette.."
        POP	AF
        CALL	L4D97		; Print Driveletter
        LD	A,8
        CALL	L4D6E		; Print ":"
        CALL	L4D61		; Print CR/LF
        LD	A,9
        CALL	L4D6E		; Print "and press.."
L4D54:	CALL	L4D5B		; Ask for fresh key
        JR	Z,L4D54		; Ctrl-C, ask again
        JR	L4D61		; Print CR/LF and quit

L4D5B:	CALL	L4D86
        CP	3
        RET

L4D61:	PUSH	AF
        LD	A,13
        CALL	L4D97		; Print CR
        LD	A,10
        CALL	L4D97		; Print LF
        POP	AF
        RET

L4D6E:	PUSH	HL
        PUSH	DE
        LD	DE,(LF34D)
        CALL	L4106		; copy message to buffer
        CALL	L4D7D		; Print string
        POP	DE
        POP	HL
        RET

L4D7D:	LD	A,(DE)
        INC	DE
        OR	A
        RET	Z		; nul, quit
        CALL	L4D97	; Print char
        JR	L4D7D	; Next char

L4D86:	PUSH	IX
        PUSH	HL
        LD	IX,KILBUF
        CALL	L4DA3	; Clear keyboard buffer
        POP	HL
        LD	IX,CHGET
        JR	L4D9D	; Get keyboardchar

L4D97:	PUSH	IX
        LD	IX,CHPUT	; Print char
L4D9D:	CALL	L4DA3
        POP	IX
        RET

L4DA3:	PUSH	IY
        LD	IY,(EXPTBL+0-1)
        CALL	CALSLT	; Interslot call to MAIN-ROM
        EI
        POP	IY
        RET

;
; GETWRK
;
GETWRK:
L4DB0:	CALL	L4DBB
        LD	A,(HL)
        INC	HL
        LD	H,(HL)
        LD	L,A
        PUSH	HL
        POP	IX
        RET

L4DBB:	IN	A,(0A8H)
        AND	0CH
        RRCA
        RRCA
        LD	HL,EXPTBL
        CALL	L4DDC
        ADD	A,A
        ADD	A,A
        ADD	A,A
        ADD	A,A
        INC	A
        LD	C,A
        LD	A,(HL)
        ADD	A,A
        SBC	A,A
        AND	0CH
        INC	HL
        INC	HL
        INC	HL
        INC	HL
        AND	(HL)
        OR	C
        ADD	A,A
        LD	HL,SLTWRK
L4DDC:	LD	C,A
        LD	B,0
        ADD	HL,BC
        RET

;
; SETINT
;
SETINT:
L4DE1:	EX	DE,HL
        CALL	L402D			; Get my slot
        PUSH	AF
        LD	A,(DEVICE)		; diskdriver number
        LD	HL,DRVINT
        CALL	L4DDC
        ADD	HL,BC
        ADD	HL,BC			; get diskinterrupt entry pointer
        POP	AF
        LD	(HL),A			; slotid
        INC	HL
        LD	(HL),E
        INC	HL
        LD	(HL),D			; adres
PRVINT:
L4DF7:	RET

; GETSLT_P0

L4DF8:	PUSH	HL
        PUSH	BC
        IN	A,(0A8H)
        CALL	L4E38
        JR	Z,L4E35
        RLCA
        RLCA
        JR	L4E30

; GETSLT_P1

L4E05:	PUSH	HL
        PUSH	BC
        IN	A,(0A8H)
        RRCA
        RRCA
        CALL	L4E38
        JR	Z,L4E35
        JR	L4E30

; GETSLT_P2

L4E12:	PUSH	HL
        PUSH	BC
        IN	A,(0A8H)
        RRCA
        RRCA
        RRCA
        RRCA
        CALL	L4E38
        JR	Z,L4E35
        JR	L4E2E

; GETSLT_P3

L4E21:	PUSH	HL
        PUSH	BC
        IN	A,(0A8H)
        RLCA
        RLCA
        CALL	L4E38
        JR	Z,L4E35
        RRCA
        RRCA
L4E2E:	RRCA
        RRCA
L4E30:	AND	00CH
        OR	080H
        OR	C
L4E35:	POP	BC
        POP	HL
        RET

L4E38:	AND	03H
        LD	C,A
        LD	B,0
        LD	HL,EXPTBL
        ADD	HL,BC
        BIT	7,(HL)
        RET	Z
        INC	HL
        INC	HL
        INC	HL
        INC	HL
        LD	A,(HL)
        RET

;
; DIV16
;
DIV16:
L4E4A:	LD	HL,0
        LD	A,17
L4E4F:	RL	C
        RL	B
        DEC	A
        RET	Z
        ADC	HL,HL
        JR	NC,L4E5E
        OR	A
        SBC	HL,DE
        JR	L4E4F
L4E5E:	SBC	HL,DE
        JR	NC,L4E63
        ADD	HL,DE
L4E63:	CCF
        JR	L4E4F

L4E66:	OR	A		; Reset Cx flag
L4E67:	EI
        JR	C,L4E7C
        LD	HL,-256
        ADD	HL,SP	; 256 bytes for the stack
        LD	DE,(STREND)
        XOR	A
        SBC	HL,DE	; - end of basic program
        LD	C,L
        LD	B,H		; Amount of memory
        EX	DE,HL	; Begin memory
        JR	NC,L4E7C	; Enough memory, go
        LD	C,A
        LD	B,A		; memory available = 0
L4E7C:	PUSH	HL
        PUSH	BC
        LD	L,0
        LD	BC,0867H	; Max 8 drives
L4E83:	ADD	HL,HL	; Shift left
        PUSH	HL
        PUSH	BC
        XOR	A		; Get format choice string
        CALL	LF37D	; FORMAT
        POP	BC
        POP	HL
        JR	NZ,L4E8F	; Not formatable, reset bit
        INC	HL		; set bit
L4E8F:	DJNZ	L4E83	; Next drive
        LD	A,L
        OR	A		; Check if any formatable
        JP	Z,L4F47	; No,
        DEC	A
        AND	L
        LD	A,L		; Check if only one drive
        JR	Z,L4EDE	; Yes,
        PUSH	HL
        LD	A,2
        CALL	L4D6E	; Print drivename
        POP	HL
        PUSH	HL
        LD	A,"A"-1
L4EA5:	INC	A		; Driveletter
        SRL L		; Check drive is possible
        JR	NC,L4EB4	; No, dont print
        CALL	L4D97	; Print driveletter
        PUSH	AF
        LD	A,","
        CALL	NZ,L4D97	; Print "," if not the last
        POP	AF
L4EB4:	JR	NZ,L4EA5	; Not the last, next
        LD	A,3
        CALL	L4D6E	; Print
        POP	HL
L4EBC:	CALL	L4D5B	; Get fresh key
        JP	Z,L4F47	; Ctrl-C,
        AND	0DFH 	; Upcase
        LD	C,A
        SUB	"A"         ; To driveid
        CP	8
        JR	NC,L4EBC	; Illegal drive, ask again
        LD	B,A
        INC	B
        XOR	A
        SCF
L4ECF:	RLA
        DJNZ	L4ECF
        AND	L		; Check if legal drive
        JR	Z,L4EBC	; No, ask again
        PUSH	AF
        LD	A,C
        CALL	L4D97	; Print the input
        CALL	L4D61	; Print CR/LF
        POP	AF
L4EDE:	INC	B
        RRCA
        JR	NC,L4EDE
        LD	C,067H
        PUSH	BC
        XOR	A
        CALL	LF37D	; BDOS #67 (get formattext)
        LD	A,L
        OR	H
        JR	Z,L4F1C	; No such text, go
        LD	A,B
L4EEE:	PUSH	AF
        CALL	RDSLT	; Get char
        OR	A
        JR	Z,L4EFC	; nul, end of text
        CALL	L4D97	; Print it
        POP	AF
        INC	HL
        JR	L4EEE	; Again
L4EFC:	POP	AF
        LD	A,"?"
        CALL	L4D97
        LD	A," "
        CALL	L4D97	; Print "? "
L4F07:	CALL	L4D5B	; Get fresh key
        JR	Z,L4F46	; Ctrl-C pressed,
        SUB	"1"         ; dec. based
        CP	8+1
        JR	NC,L4F07	; > 8, ask again
        ADD	A,"1"
        CALL	L4D97	; Print choice
        CALL	L4D61	; Print CR/LF
        SUB	"1"
L4F1C:	INC	A		; back to dec. based
        PUSH	AF
        LD	A,4
        CALL	L4D6E	; Print
        CALL	L4D5B	; Get fresh key
        JR	Z,L4F45	; Ctrl-C pressed,
        CALL	L4D61	; Print CR/LF
        POP	AF
        POP	BC
        POP	DE
        POP	HL
        CALL	LF37D	; BDOS #67
        JR	Z,L4F41
        LD	B,A
        LD	DE,(LF34D)
        LD	C,066H
        CALL	LF37D	; EXPLAIN
        JP	L4D7D
L4F41:	LD	A,6
        JR	L4F4E
L4F45:	POP	AF
L4F46:	POP	AF
L4F47:	POP	AF
        POP	AF
        CALL	L4D61
        LD	A,5
L4F4E:	CALL	L4D6E
        JP	L4D61

L4F54:	XOR	A
        LD	(LF306),A
        JP	L6A86

        DEFS	04FB8H-$,201
;
; BDOS 011H ENTRY
;
L4FB8:	LD	C,011H
        JP	L4F54

        DEFS	05006H-$,201
;
; BDOS 012H ENTRY
;
L5006:	LD	C,012H
        JP	L4F54

        DEFS	0501EH-$,201
;
; BDOS 023H ENTRY
;
L501E:	LD	C,023H
        JP	L4F54

        DEFS	0504EH-$,201
;
; BDOS 018H ENTRY
;
L504E:	LD	C,018H
        JP	L4F54

        DEFS	05058H-$,201
;
; BDOS 01AH ENTRY
;
L5058:	LD	C,01AH
        JP	L4F54

        DEFS	0505DH-$,201
;
; BDOS 01BH ENTRY
;
L505D:	LD	C,01BH
        JP	L4F54

        DEFS	0509FH-$,201
;
; BDOS 00DH ENTRY
;
L509F:	LD	C,00DH
        JP	L4F54

        DEFS	050A9H-$,201
;
; DOS1 kernel compatible: flush buffers
; This entry is supported, to use MSXDOS.SYS
;
L50A9:	LD	BC,0FF5FH
        LD	D,0
        JP	L4F54

        DEFS	050C4H-$,201
;
; BDOS 019H ENTRY
;
L50C4:	LD	C,019H
        JR	L50CA

        DEFS	050C8H-$,201
;
; BDOS 024H ENTRY
;
L50C8:	LD	C,024H
L50CA:	JP	L4F54

        DEFS	050D5H-$,201
;
; BDOS 00EH ENTRY
;
L50D5:	LD	C,00EH
        JP	L4F54

        DEFS	050E0H-$,201
;
; BDOS 00AH ENTRY
;
L50E0:	LD	C,00AH
        JP	L4F54

        DEFS	05183H-$,201
;
; DOS1 kernel compatible: newline to console
; This entry is supported, to use MSXDOS.SYS
;
L5183:	LD	E,13
        CALL	L53A7
        LD	E,10
        JP	L53A7
;
; 0518DH - 053A7H USED OTHERWISE IN DOS1 ROM
;
L518D:
I_CHKKEY:
        XOR	A
        CALL	SNSMAT
        BIT	1,A

        IF	TURBOR EQ 1
        LD	A,082H
        JP	NZ,CHGCPU		; "1" key not pressed, switch to R800 RAM cpumode and quit
        ELSE
        RET	NZ
        ENDIF

        JR	I_GODOS1		; "1" key pressed, start DOS 1.x

I_CHKDEF:
        LD	HL,USRTAB+2*0
        LD	A,(HL)
        CP	LOW M475A
        RET	NZ
        INC	HL
        LD	A,(HL)
        CP	HIGH M475A
        RET	NZ			; DEFUSR0 not at default, quit
        POP	HL
        JR	I_GODOS1		; start DOS 1.x

I_CHKDSK:
        CALL	I_CHKVOL		; check if disk has a volumeid
        JP	Z,L4AFB			; start bootloader with Cx reset

I_GODOS1:

        IF	TURBOR EQ 1
        LD	A,080H			; Z80 mode
        CALL	CHGCPU			; change cpu mode
        ENDIF

        LD	A,(LF343)
        LD	H,080H
        CALL	ENASLT			; enable ram on page 2
        DI
        LD	HL,LF2C0
        LD	DE,H.TIMI
        LD	BC,5
        LDIR				; restore orginal H.TIMI
        LD	HL,LF2D5
        LD	DE,EXTBIO
        LD	BC,5
        LDIR				; restore orginal EXTBIO
        LD	HL,(LF34F)
        LD	(AUTLIN),HL		; set bigest sectorsize
        LD	HL,(LF353)
        LD	DE,21
        ADD	HL,DE
        LD	(HIMEM),HL		; HIMEM is BASIC DISKSYSTEM
        CALL	L565C			; init variable part of BASIC
        LD	SP,(STKTOP)
        XOR	A
        LD	(LF23C),A		; default drive A: (DOS1)
        LD	HL,LF2B8
        LD	(HL),A
        LD	D,H
        LD	E,L
        INC	DE
        LD	BC,0006EH
        LDIR				; clear #F2B8-#F326
        LD	DE,DRVTBL
        LD	HL,DRVINT
        LD	B,4
L5202:	LD	A,(DE)
        OR	A
        JR	Z,L523A			; end of drivetable
        INC	DE
        LD	A,(DE)
        INC	DE
        CP	(HL)		 	; does this ROM use interrupts ?
        JR	NZ,L5235		; nop, next
        PUSH	HL
        LD	HL,H.TIMI+0
        LD	A,(HL)
        SUB	0C9H		 	; interrupt hook already set ?
        JR	NZ,L5220		; yep, patch
        LD	(HL),0F7H
        INC	HL
        LD	(HL),A
        INC	HL
        LD	(HL),A
        INC	HL
        LD	(HL),A			; not filled in yet
        INC	HL
        LD	(HL),0C9H
L5220:	POP	HL
        PUSH	HL
        PUSH	DE
        PUSH	BC
        LD	B,3
        LD	DE,H.TIMI+1
L5229:	LD	A,(DE)
        LD	C,(HL)
        LD	(HL),A
        LD	A,C
        LD	(DE),A
        INC	DE
        INC	HL
        DJNZ	L5229			; exchange
        POP	BC
        POP	DE
        POP	HL
L5235:	INC	HL
        INC	HL
        INC	HL
        DJNZ	L5202			; next entry
L523A:	LD	HL,A58A8
        PUSH	HL 			; start DOS1 kernel
        LD	A,3
        JP	L40A3			; invoke DOS1 segment

I_CHKVOL:
        LD	HL,0C020H
        LD	DE,L5253
        LD	B,6
L524B:	LD	A,(DE)
        CP	(HL)
        RET	NZ
        INC	HL
        INC	DE
        DJNZ	L524B
        RET

L5253:	DEFB	"VOL_ID"

; end of patch area

        DEFS	0535DH-$,201
;
; DOS1 kernel compatible: print abort string (DOS1: ^C)
; This entry is supported, to use MSXDOS.SYS
;
L535D:	EXX
        PUSH	BC 		; errorcode
        EXX
        CALL	L5183		; CR/LF to console
        LD	A,10		; message 10 (Abort)
        LD	DE,(LF34D)
        CALL	L4106		; copy message to buffer
        CALL	L5379		; print prompt
        POP	BC
        LD	DE,(LF34D)
        LD	C,066H
        CALL	LF37D		; EXPLAIN error
                                ; print errorstring
L5379:	LD	A,(DE)
        OR	A
        RET	Z
        PUSH	DE
        LD	E,A
        CALL	L53A7		; print char
        POP	DE
        INC	DE
        JR	L5379

        DEFS 053A7H-$,201
;
; BDOS 002H ENTRY
;
L53A7:	LD	C,2
        JP	L4F54
;
; 053ACH - 0543BH USED OTHERWISE IN DOS1 ROM
;
L53AC:	LD	HL,0C91AH	; LD A,(DE)  RET
        PUSH	HL 		; on stack (routine)
        CALL	L53C0		; Get char out of memory
        POP	HL
        CP	"$"		; check "$" encountered
        RET	Z		; yes, quit
        PUSH	DE
        LD	E,A
        CALL	L53A7		; Print char (BDOS #02)
        POP	DE
        INC	DE
        JR	L53AC		; next char
L53C0:	LD	HL,XF368
        PUSH	HL 		; Routine Switch SystemDiskROM on page 1 on stack
        LD	HL,4
        ADD	HL,SP
        PUSH	HL 		; Call "routine" on stack
        JP	XF36B		; Switch RAM on page 1

        DEFS	0543CH-$,201
;
; BDOS 00BH ENTRY
;
L543C:	LD	C,00BH
        JP	L4F54

        DEFS	05445H-$,201
;
; BDOS 001H ENTRY
;
L5445:	LD	C,1
        JP	L4F54

        DEFS	0544EH-$,201
;
; BDOS 008H ENTRY
;
L544E:	LD	C,8
        JP	L4F54

        DEFS	05454H-$,201
;
; BDOS 006H ENTRY
;
L5454:	LD	C,6
        JP	L4F54

        DEFS	05462H-$,201
;
; BDOS 007H ENTRY
;
L5462:	LD	C,7
        DEFB	011H		; Pseudo LD DE,nnnn
;
; BDOS 005H ENTRY
;
L5465:	LD	C,5
        JP	L4F54

        DEFS	0546EH-$,201
;
; BDOS 003H ENTRY
;
L546E:	LD	C,3
        JP	L4F54

        DEFS	05474H-$,201
;
; BDOS 004H ENTRY
;
L5474:	LD	C,4
        JP	L4F54

        DEFS	0553CH-$,201
;
; BDOS 02AH ENTRY
;
L553C:	LD	C,02AH
        JP	L4F54

        DEFS	05552H-$,201
;
; BDOS 02BH ENTRY
;
L5552:	LD	C,02BH
        JP	L4F54

        DEFS	055DBH-$,201
;
; BDOS 02CH ENTRY
;
L55DB:	LD	C,02CH
        JP	L4F54

        DEFS	055E6H-$,201
;
; BDOS 02DH ENTRY
;
L55E6:	LD	C,02DH
        JP	L4F54

        DEFS	055FFH-$,201
;
; BDOS 02EH ENTRY
;
L55FF:	LD	C,02EH
        JP	L4F54
;
; 05604H - 07FFFH USED OTHERWISE IN DOS1 ROM
;
L5604:	LD	A,L
        OR	H		; allocate nothing ?
        RET	Z		; yep, quit
        EX	DE,HL
        LD	HL,0
        SBC	HL,DE
        LD	C,L
        LD	B,H
        ADD	HL,SP	; Stack - alloc
        CCF
        RET	C		; Stack < #0000, quit
        LD	A,H
        CP	HIGH 0C200H
        RET	C		; Stack < #C200, quit
        LD	DE,(BOTTOM)
        SBC	HL,DE
        RET	C		; Stack < BOTTOM, quit
        LD	A,H
        CP	02H
        RET	C		; Less then 512 bytes for stack
        PUSH	BC
        LD	HL,0
        ADD	HL,SP
        LD	E,L
        LD	D,H
        ADD	HL,BC	; Stack - alloc
        PUSH	HL
        LD	HL,(STKTOP)
        OR	A
        SBC	HL,DE
        LD	C,L
        LD	B,H
        INC	BC		; Bytes on stack
        POP	HL
        LD	SP,HL	; New stack
        EX	DE,HL
        LDIR		; Copy stack to new place
        POP	BC
        LD	HL,(HIMEM)
        ADD	HL,BC
        LD	(HIMEM),HL	; HIMEM - alloc
        LD	DE,0FDEAH
        ADD	HL,DE
        LD	(FILTAB),HL	; FILTAB 534 bytes beneve (2*256 + 2*9 + 2*2)
        EX	DE,HL
        LD	HL,(MEMSIZ)
        ADD	HL,BC
        LD	(MEMSIZ),HL	; MEMSIZ - alloc
        LD	HL,(NULBUF)
        ADD	HL,BC
        LD	(NULBUF),HL	; NULBUF - alloc
        LD	HL,(STKTOP)
        ADD	HL,BC
        JR	L5681	; STKTOP - alloc

L565C:	LD	A,1
        LD	(MAXFIL),A	; max. 1 file open
        LD	HL,(HIMEM)
        LD	DE,0FDEAH
        ADD	HL,DE
        LD	(FILTAB),HL	; FILTAB 534 bytes beneve (2*256 + 2*9 + 2*2)
        LD	E,L
        LD	D,H
        DEC	HL
        DEC	HL
        LD	(MEMSIZ),HL	; Top of string pool
        LD	BC,200
        OR	A
        SBC	HL,BC	; 200 bytes for string pool
        PUSH	HL
        LD	HL,13
        ADD	HL,DE
        LD	(NULBUF),HL	; NULBUF
        POP	HL
L5681:	LD	(STKTOP),HL	; Set stacktop
        DEC	HL
        DEC	HL
        LD	(SAVSTK),HL	; SAVSTK
        LD	L,E
        LD	H,D
        INC	HL
        INC	HL
        INC	HL
        INC	HL		; To FCB 0
        LD	A,2		; 2 fcb's
L5691:	EX	DE,HL
        LD	(HL),E
        INC	HL
        LD	(HL),D
        INC	HL		; Set address of FCB in FILTAB
        EX	DE,HL
        LD	BC,0007H
        LD	(HL),B	; reset MOD byte of FCB
        ADD	HL,BC
        LD	(HL),B	; reset FLG byte of FCB
        LD	BC,0102H
        ADD	HL,BC	; To next FCB
        DEC	A
        JR	NZ,L5691	; Go on
        RET

L56A5:	LD	HL,L5757
        LD	DE,H.POSD
        LD	BC,5
        LDIR			; Init hook H.POSD
        LD	HL,L56CD	; Table with hook routines
L56B3:	LD	E,(HL)
        INC	HL
        LD	D,(HL)
        INC	HL		; Hook address
        LD	A,E
        OR	D
        RET	Z		; Einde hook init
        EX	DE,HL
        LD	(HL),0F7H	; RST CALLF
        INC	HL
        LD	A,(LF348)
        LD	(HL),A		; Slotid
        INC	HL
        EX	DE,HL
        LDI
        LDI			; Routine address
        LD	A,0C9H
        LD	(DE),A		; RET
        JR	L56B3		; next hook

L56CD:	DEFW	H.DSKO,L5EDC
        DEFW	H.DSKI,L5EBB
        DEFW	H.NAME,L6315
        DEFW	H.KILL,L6303
        DEFW	H.COPY,L6424
        DEFW	H.DSKF,L640D
        DEFW	H.LSET,L6026
        DEFW	H.RSET,L6025
        DEFW	H.FIEL,L5F9F
        DEFW	H.MKI$,L60E6
        DEFW	H.MKS$,L60E9
        DEFW	H.MKD$,L60EC
        DEFW	H.CVI,L6123
        DEFW	H.CVS,L6126
        DEFW	H.CVD,L6129
        DEFW	H.GETP,L5A2A
        DEFW	H.NOFO,L5A39
        DEFW	H.NULO,L5A82
        DEFW	H.NTFL,L5BEF
        DEFW	H.BINS,L5C51
        DEFW	H.BINL,L5C69
        DEFW	H.FILE,L61E0
        DEFW	H.DGET,L5F1E
        DEFW	H.FILO,L5BD6
        DEFW	H.INDS,L5B4F
        DEFW	H.LOC,L6361
        DEFW	H.LOF,L635E
        DEFW	H.EOF,L61C8
        DEFW	H.BAKU,L5BBD
        DEFW	H.PARD,L6665
        DEFW	H.NODE,L674F
        DEFW	H.ERRP,L6753
        DEFW	H.PHYD,L4C9D
        DEFW	H.FORM,L4E66
L5755:	DEFW	0

L5757:	INC	SP
        INC	SP
        JP	M6F1D

L575C:	EI
        LD	A,(H.PHYD+0)
        CP	0C9H		; Check if Disksystem active
        SCF
        RET	Z		; No, quit
        PUSH	HL
        CALL	L402D		; Get my slot
        LD	HL,LF348
        CP	(HL)		; Me the system ROM ?
        JR	NZ,L5795	; No, do not check DOS2 statements
        LD	HL,L5799	; Table with "_" commands
L5771:	LD	DE,PROCNM
L5774:	LD	A,(DE)
        CP	(HL)
        JR	NZ,L578B	; Not equal
        INC	DE
        INC	HL
        AND	A
        JR	NZ,L5774	; No end of command name, go checking
        LD	E,(HL)
        INC	HL
        LD	D,(HL)
        POP	HL		; routine address
        CALL	L665E
        CALL	L5789		; Call routine
        AND	A
        RET
L5789:	PUSH	DE
        RET
L578B:	LD	C,0FFH
        XOR	A
        CPIR			; Skip to end of commandname
        INC	HL
        INC	HL		; Skip address
        CP	(HL)
        JR	NZ,L5771	; Not end of table, go checking
L5795:	POP	HL
        JP	OEMSTA		; Special Rom "_" command

L5799:	DEFB	"SYSTEM"
        DEFB	0
        DEFW	L57D6

        DEFB	"FORMAT"
        DEFB	0
        DEFW	L581A

        DEFB	"CHDRV"
        DEFB	0
        DEFW	L5821

        DEFB	"CHDIR"
        DEFB	0
        DEFW	L585A

        DEFB	"MKDIR"
        DEFB	0
        DEFW	L5869

        DEFB	"RMDIR"
        DEFB	0
        DEFW	L587D

        DEFB	"RAMDISK"
        DEFB	0
        DEFW	L58AF

        DEFB	0


; _SYSTEM handler

L57D6:	LD	DE,BUF+10
        JR	Z,L5805		; No parameters, start DOS
        CALL	L6654
        DEFB	"("		; Check for (
        LD	IX,M4C64
        CALL	L664F		; Evaluate expresion
        PUSH	HL
        LD	IX,M67D0
        CALL	L664F		; free temporary stringdescriptor
        LD	C,(HL)		; Length of string
        INC	HL
        LD	A,(HL)
        INC	HL
        LD	H,(HL)
        LD	L,A		; Address of string
        LD	DE,BUF+10
        INC	C
        DEC	C
        JR	Z,L57FF		; Zero string, don't copy
        LD	B,0
        LDIR			; Copy string to #F568
L57FF:	POP	HL
        CALL	L6654
        DEFB	")"		; Check for )
        RET	NZ		; Not end of statement, quit (error)
L5805:	XOR	A
        LD	(DE),A		; Nul char to end string
        LD	IX,M6C1C
        CALL	L664F		; close all I/O channels
        CALL	TOTEXT		; To text screenmode
        CALL	ERAFNK		; Erase funktionkeys from screen
        LD	HL,BUF+10
        JP	L4ADC		; start MSX-DOS

; _FORMAT handler

L581A:	RET	NZ		; not end of statement, quit
        PUSH	HL
        CALL	L4E66	; Format with prompts
        POP	HL
        RET

; _CHDRV handler

L5821:	CALL	L634C	; eval ("file"
        CALL	L6654
        DEFB	")"          ; Check for )
        PUSH	HL
        LD	BC,005BH
        CALL	L6559	; PARSE PATHNAME
        EX	DE,HL
        LD	A,B
        AND	05H 	; No other chars than drivename,
        XOR	04H 	;  drivename is specified
        OR	(HL) 	;  terminator is end of string
        JP	NZ,L65ED	; nop, error
        LD	A,C
        CALL	L5846	; Check if valid drive
        DEC	A
        LD	E,A
        LD	C,0EH
        CALL	LF37D	; SELDRV
        POP	HL
        RET

L5846:	PUSH	AF
        LD	C,018H
        CALL	LF37D	; Get login vector
        POP	AF
        PUSH	AF
L584E:	SRL	H
        RR	L		; Shift right in Cx
        DEC	A
        JR	NZ,L584E	; The drive
        JP	NC,L65ED	; Drive not active,
        POP	AF
        RET

; _CHDIR handler

L585A:	CALL	L634C	; eval ("file"
        CALL	L6654
        DEFB	")"          ; Check for )
        PUSH	HL
        LD	C,05AH
        CALL	L6559	; CHDIR
        POP	HL
        RET

; _MKDIR handler

L5869:	CALL	L634C	; eval ("file"
        CALL	L6654
        DEFB	")"          ; Check for )
        PUSH	HL
        LD	B,010H	; Directory attribute
        LD	C,044H
        CALL	L6559	; CREATE
        CALL	L6343	; flush buffers
        POP	HL
        RET

; _RMDIR

L587D:	CALL	L634C	; eval ("file"
        CALL	L6654
        DEFB	")"          ; Check for )
        RET	NZ
        PUSH	HL
        LD	B,010H	; Directory attribute
        CALL	L59D3	; find first file
        XOR	A
        PUSH	AF
L588D:	LD	A,(BUF+10+14)
        AND	010H 	; directory ?
        JR	Z,L589F	; nop, next
        LD	DE,BUF+10	; FIB
        LD	C,04DH
        CALL	L655D	; DELETE
        POP	AF
        SCF
        PUSH	AF
L589F:	CALL	L59D8	; find next file
        JR	NC,L588D	; found, delete
        POP	AF		; delete something ?
        LD	A,0D6H
        JP	NC,L65C3	; nop, error
        CALL	L6343	; flush buffers
        POP	HL
        RET

; _RAMDISK

L58AF:	CALL	L6654
        DEFB	"("		; Check for "("
        CP	","		; Is it a ","
        LD	A,0FFH		; code: ask current size
        JR	Z,L58DB		; Yes, skip
        LD	IX,M520F
        CALL	L664F		; evaluate experssion and convert to unsigned integer
        INC	D
        DEC	D
        JP	M,L662D		; > 32767 Kb, error
        LD	B,4
L58C7:	SRL	D
        RR	E
        JR	NC,L58CE
        INC	DE
L58CE:	DJNZ	L58C7	; # of segments
        LD	A,E
        INC	D
        DEC	D
        JR	NZ,L58D9	; more as 255 segments, use 254
        CP	0FFH
        JR	NZ,L58DB	; no 255, it is ok
L58D9:	LD	A,254	; use 254 segments
L58DB:	PUSH	AF
        LD	A,(HL)
        CP	","          ; Check for a komma
        LD	DE,0
        JR	NZ,L58EE	; No, skip
        CALL	L665F
        LD	IX,L5EA4
        CALL	L664F	; Search for variable
L58EE:	POP	BC		; Segments
        CALL	L6654
        DEFB	")"          ; Check for ")"
        RET	NZ		; No end of statement, quit (error)
        LD	A,(VALTYP)
        CP	3		; Check if stringvariable
        JP	Z,L6627	; Yes,
        PUSH	HL
        PUSH	DE
        PUSH	AF
        LD	C,068H
        CALL	L655D	; Set/Get RAMDISK
        LD	L,B
        LD	H,0
        ADD	HL,HL
        ADD	HL,HL
        ADD	HL,HL
        ADD	HL,HL	; segments * 16 (= size in Kb)
        LD	(DAC+2),HL	; In DAC
        POP	AF
        LD	(VALTYP),A	; Set variable type
        POP	DE
        LD	A,E
        OR	D		; Check if size give back
        CALL	NZ,L591A	; Yes, put in variable
        POP	HL
        RET

L591A:	PUSH	DE
        LD	HL,VALTYP
        LD	A,(HL)
        LD	C,A
        LD	(HL),2	; type = integer
        LD	HL,DAC+2
        CP	2		; Check if variable is integer
        JR	Z,L593E	; Yes, just copy DAC
        CP	4		; Check if single presision
        JR	Z,L5932	; Yes, convert to presision
        CP	8		; Check if double presision
        JP	NZ,L6627	; No (string),
L5932:	PUSH	BC
        LD	IX,M517A
        CALL	L664F		; convert DAC to other type (integer)
        POP	BC
        LD	HL,DAC
L593E:	LD	B,0
        POP	DE
        LDIR
        RET

L5944:	PUSH	HL
        PUSH	DE
        PUSH	BC
        XOR	A
        LD	(BUF+10),A	; FIB not made
        LD	HL,(FILTAB)	; FILTAB
        LD	A,(MAXFIL)	; # of I/O channels
L5951:	PUSH	AF
        LD	E,(HL)
        INC	HL
        LD	D,(HL)	; adres I/O channel
        INC	HL
        PUSH	HL
        EX	DE,HL
        LD	A,(HL)
        AND	A		; I/O channel open ?
        JR	Z,L598F	; nop, next
        INC	HL
        INC	HL
        INC	HL
        INC	HL
        LD	A,(HL)
        CP	8+1		; device is diskdrive ?
        JR	NC,L598F	; nop, next
        LD	A,(BUF+10)
        AND	A		; FIB made ?
        JR	NZ,L597E	; yep, skip
        PUSH	HL
        LD	DE,(LF33B)	; pathname buffer
        LD	B,06H	; also system and hidden files
        LD	IX,BUF+10
        LD	C,040H
        CALL	L59DE	; FFIRST
        POP	HL
        JR	C,L5998	; not found,
L597E:	DEC	HL
        DEC	HL
        DEC	HL
        LD	B,(HL)	; filehandle
        LD	DE,BUF+10
        LD	C,04CH
        CALL	L655D	; TEST FILEHANDLE
        LD	A,B
        AND	A		; same file ?
        JP	NZ,L663C	; yep, error
L598F:	POP	HL
        POP	AF
        DEC	A
        JP	P,L5951	; next I/O channel
        JP	L5A26
L5998:	POP	HL
        POP	HL
        JP	L5A26

L599D:	PUSH	AF
        LD	B,0
        LD	C,05BH
        CALL	L6559	; PARSE PATHNAME
        POP	AF
        PUSH	BC
        PUSH	DE
        PUSH	HL
        PUSH	AF
        LD	B,A
        CALL	L59D3	; find first file
        POP	AF
        POP	HL
        POP	DE
        POP	BC
        BIT	5,B 	; ambiguous ?
        RET	NZ		; yep, quit
        LD	D,A
        LD	A,(BUF+10+14)
        AND	010H 	; directory ?
        RET	Z		; nop, quit
        LD	A,L
        CP	E		; filename ?
        RET	Z		; nop, quit
        PUSH	BC
        LD	B,D
        LD	DE,BUF+10
        PUSH	DE
        POP	IX
        LD	HL,L5755	; null, *.*
        LD	C,040H
        CALL	L655D	; find first file
        POP	BC
        RET

L59D1:	LD	B,0	; normal files
L59D3:	LD	C,040H	; FFIRST
        JP	L6555

L59D8:	LD	IX,BUF+10
        LD	C,041H	; FNEXT
L59DE:	CALL	LF37D
        RET	Z
        CP	0D7H
        SCF
        RET	Z
        JP	L65C3

L59E9:	EI
        PUSH	HL
        PUSH	DE
        PUSH	BC
        PUSH	AF
        LD	A,(LF348)
        ADD	A,A
        LD	HL,16		; with unexpanded slot, return adres at off #10
        JR	NC,L59F9
        LD	L,24		; with expanded slot, return adres at off #18
L59F9:	ADD	HL,SP
        PUSH	IX
        POP	BC
        LD	(HL),C
        INC	HL
        LD	(HL),B		; replace return adres
        LD	HL,10
        ADD	HL,SP
        EX	DE,HL		; stack at calling routine entry
        JR	L5A13

L5A07:	PUSH	IY
        POP	BC		; size of parameter block
L5A0A:	LD	C,(HL)
        LD	A,(DE)
        LD	(HL),A
        LD	A,C
        LD	(DE),A
        INC	HL
        INC	DE
        DJNZ	L5A0A		; move parameter block
L5A13:	LD	A,(LF348)
        ADD	A,A
        LD	HL,18		; unexpanded slot, parameter block starts at off #12
        JR	NC,L5A1E
        LD	L,26		; expanded slot, parameter block starts at off #1A
L5A1E:	ADD	HL,SP
        LD	A,E
        SUB	L
        LD	A,D
        SBC	A,H 		; ready with parameter move ?
        JR	C,L5A07		; nop, lets go
L5A25:	POP	AF
L5A26:	POP	BC
        POP	DE
        POP	HL
        RET

L5A2A:	LD	IX,LF38B
        LD	IY,0200H
        CALL	L59E9	; replace orginal return
        POP	HL
        LD	A,(HL)	; MOD byte
        AND	A		; reset Cx
        RET

L5A39:	EI
        LD	BC,0100H
        LD	(LF33D),BC	; default recordsize=256
        CALL	L665E
        LD	A,E
        RET	Z		; end of statement, quit
        PUSH	AF
        PUSH	HL
        LD	A,(LF348)
        ADD	A,A
        LD	HL,12
        JR	NC,L5A53
        LD	L,20
L5A53:	ADD	HL,SP
        LD	A,(HL)
        CP	4		; random mode ?
        JP	NZ,L6630	; no,
        INC	HL
        LD	A,(HL)
        CP	8+1		; device is diskdrive ?
        JP	NC,L6630	; no,
        POP	HL
        CALL	L6654
        DEFB	0FFH
        CALL	L6654
        DEFB	092H
        CALL	L6654
        DEFB	0EFH		; eval LEN=
        LD	IX,M4756
        CALL	L664F		; evaluate word operand
        DEC	DE
        INC	D
        DEC	D		; size=0 or >255 ?
        JP	NZ,L662D	; yep,
        INC	DE
        LD	(LF33D),DE	; recordsize
        POP	AF
        RET

L5A82:	EI
        RET	NC		; not a diskdrive, quit
        LD	IX,LF38B
        LD	IY,0400H
        CALL	L59E9	; replace orginal return
        CALL	L5944	; check if already open
        LD	(PTRFIL),HL
        INC	HL
        INC	HL
        XOR	A
        LD	(HL),A	; filehandle
        INC	HL
        LD	(HL),A	; no backup
        INC	HL
        LD	(HL),D	; device
        INC	HL
        INC	HL
        LD	(HL),A	; pos = 0
        LD	A,E
        PUSH	AF
        AND	082H 	; SAVEBIN or OUTPUT ?
        JR	Z,L5AB7	; nop,
L5AA6:	XOR	A		; read/write
        LD	B,A		; normal file
        LD	C,044H
        CALL	L6559	; CREATE
L5AAD:	POP	AF
        LD	HL,(PTRFIL)
        LD	(HL),A	; mode
        INC	HL
        LD	(HL),B	; filehandle
        POP	AF
        POP	HL
        RET
L5AB7:	LD	A,E
        CP	4		; RANDOM ?
        JR	NZ,L5AD4	; nop,
        LD	HL,(PTRFIL)
        INC	HL
        INC	HL
        LD	A,(LF33D)
        DEC	A		; recordsize-1
        LD	(HL),A
        LD	DE,(LF33B)	; pathname buffer
        XOR	A		; read & write
        LD	C,043H
        CALL	L59DE	; OPEN
        JR	C,L5AA6	; not found, create
        JR	L5AAD
L5AD4:	CP	1		; INPUT ?
        JR	NZ,L5B0B	; nop,
        XOR	A		; read & write
        LD	C,043H
        CALL	L6559	; OPEN
        LD	HL,FLBMEM
        XOR	A
        CP	(HL) 	; check on BINFILE ?
        LD	(HL),A
        JR	NZ,L5AAD	; nop,
        POP	AF
        LD	HL,(PTRFIL)
        LD	(HL),A	; mode
        INC	HL
        LD	(HL),B	; filehandle
        DEC	HL
        EX	DE,HL
        LD	HL,6
        ADD	HL,DE
        LD	(HL),0FFH	; pos is end of buffer
        PUSH	HL
        EX	DE,HL
        CALL	L5B60	; read buffer
        POP	HL
        DEC	HL
        DEC	HL
        DEC	HL
        LD	(HL),A	; backup char
        INC	A		; BINFILE ?
        JR	NZ,L5B08	; nop,
        INC	HL
        INC	HL
        INC	HL
        INC	HL
        LD	(HL),080H	; set flag
L5B08:	POP	AF
        POP	HL
        RET
L5B0B:	XOR	A		; read & write
        LD	C,043H
        CALL	L6559	; OPEN
        POP	AF
        LD	HL,(PTRFIL)
        LD	(HL),1	; recordsize=1
        INC	HL
        LD	(HL),B
        DEC	HL
        EX	DE,HL
        LD	HL,6
        ADD	HL,DE
        LD	(HL),0FFH	; pos at end of buffer
        EX	DE,HL
        LD	BC,0
        LD	E,C
        LD	D,B
L5B27:	PUSH	HL
        PUSH	DE
        PUSH	BC
        CALL	L5B60	; read buffer
        POP	BC
        POP	DE
        POP	HL
        JR	C,L5B3A	; end of file,
        INC	BC
        LD	A,C
        OR	B
        JR	NZ,L5B27
        INC	DE		; adjust count
        JR	L5B27
L5B3A:	PUSH	BC
        LD	(HL),2	; OUTPUT
        INC	HL
        LD	B,(HL)	; filehandle
        INC	HL
        INC	HL
        INC	HL
        INC	HL
        INC	HL
        XOR	A
        LD	(HL),A	; pos = 0
        POP	HL
        LD	C,04AH	; SEEK
        CALL	LF37D	; seek to
        POP	AF
        POP	HL
        RET

L5B4F:	LD	IX,LF38B
        LD	IY,0600H
        CALL	L59E9	; replace orginal return
        CALL	L5B60
        JP	L5A26	; return

L5B60:	PUSH	HL
        LD	A,(HL)
        CP	1		; INPUT ?
        JP	NZ,L65EA	; no,
        LD	E,L
        LD	D,H
        INC	HL
        INC	HL
        INC	HL
        LD	A,(HL)
        AND	A		; backup char ?
        JR	NZ,L5BAF	; yep, return
        INC	HL
        INC	HL
        INC	HL
        INC	(HL)	; pos++
        LD	A,(HL)	; pos
        INC	HL
        INC	HL
        INC	HL
        JR	NZ,L5BAA	; buffer not empty, get
        PUSH	HL
        EX	DE,HL
        INC	HL
        LD	B,(HL)	; filehandle
        LD	HL,256	; 256 bytes buffer
        LD	C,048H
        CALL	LF37D	; READ
        JR	Z,L5B92	; ok,
        CP	0C7H		; end of file ?
        JP	NZ,L65C3	; no,
        POP	HL
        LD	(HL),01AH	; add ^Z
        JR	L5BAE
L5B92:	LD	C,L
        LD	B,H
        DEC	H
        LD	A,L
        OR	H
        POP	HL
        JR	Z,L5BAA	; buffer read full
        PUSH	HL
        LD	E,L
        LD	D,H
        INC	D
        DEC	DE
        ADD	HL,BC
        LD	A,C
        DEC	HL
        LDDR
        DEC	HL
        DEC	HL
        NEG
        LD	(HL),A
        POP	HL		; move part to end of buffer
L5BAA:	LD	C,A
        LD	B,0
        ADD	HL,BC
L5BAE:	LD	A,(HL)
L5BAF:	SUB	01AH
        SUB	1
        LD	A,(HL)
        POP	HL
        INC	HL
        INC	HL
        INC	HL
        LD	(HL),0	; no backup
        RET	NC		; no CTRL-Z, return
        LD	(HL),A	; CTRL-Z backed up
        RET

L5BBD:	EI
        PUSH	HL
        LD	A,(LF348)
        ADD	A,A
        LD	HL,8
        JR	NC,L5BCA
        LD	L,16
L5BCA:	ADD	HL,SP
        LD	(HL),LOW M6E41
        INC	HL
        LD	(HL),HIGH M6E41
        POP	HL
        INC	HL
        INC	HL
        INC	HL
        LD	(HL),C	; backup char
        RET

L5BD6:	LD	IX,LF38B
        LD	IY,0800H
        CALL	L59E9	; replace orginal return
        LD	A,(HL)
        CP	2		; OUTPUT ?
        JP	NZ,L65EA	; nop,
        POP	AF
        PUSH	AF
        CALL	L5C2B	;
        JP	L5A25

L5BEF:	LD	IX,LF38B
        LD	IY,0400H
        CALL	L59E9	; replace orginal return
        POP	HL
        LD	A,(HL)
        SUB	2 		; OUTPUT ?
        JR	NZ,L5C13	; nop,
        PUSH	HL
        LD	HL,FLBMEM
        CP	(HL) 	; CTRL-Z on end ?
        LD	(HL),A
        POP	HL
        JR	NZ,L5C13	; nop,
        LD	(HL),4	; RANDOM
        LD	A,01AH
        CALL	L5C2B	; write CTRL-Z
        CALL	NZ,L5C39	; write buffer
L5C13:	XOR	A
        CP	(HL) 	; closed ?
        LD	(HL),A
        PUSH	AF
        INC	HL
        LD	B,(HL)	; filehandle
        LD	DE,6
        ADD	HL,DE
        LD	(HL),A
        LD	L,A
        LD	H,A
        LD	(PTRFIL),HL	; clear
        LD	C,045H
        CALL	L655D	; CLOSE
        POP	AF
        POP	HL
        RET

L5C2B:	PUSH	HL
        LD	BC,6
        ADD	HL,BC
        LD	C,(HL)	; pos
        INC	(HL)	; pos++
        INC	HL
        INC	HL
        INC	HL
        ADD	HL,BC
        LD	(HL),A	; store in buffer
        POP	HL
        RET	NZ		; buffer not full, quit

L5C39:	PUSH	HL
        INC	HL
        LD	B,(HL)	; filehandle
        LD	DE,5
        ADD	HL,DE
        LD	A,(HL)	; pos
        INC	HL
        INC	HL
        INC	HL
        EX	DE,HL	; buffer
        DEC	A
        LD	L,A
        LD	H,0
        INC	HL		; size to write
        LD	C,049H
        CALL	L655D	; WRITE
        POP	HL
        RET

L5C51:	CALL	L6888		; remove orginal return
        PUSH	HL
        LD	IX,M54F7
        CALL	L664F		; convert pointers to linenumbers
        LD	A,0FFH
        CALL	L5E8F	; BINSAVE fileheader
        LD	DE,(TXTTAB)	; start at TXTTAB
        LD	HL,(VARTAB)
        AND	A
        SBC	HL,DE	; size of basicprogram
        CALL	L5EA7	; write
        LD	(NLONLY),A	; no channel stays open
        POP	HL
        LD	IX,M6B24
        JP	L664F		; close I/O channel

L5C69:	LD	IX,M739A	; quit loading and start
        LD	IY,0200H
        CALL	L59E9	; replace orginal return
        POP	AF
        JP	Z,L65EA	; MERGE,
        LD	IX,M6C1C
        CALL	L664F		; close all I/O channels
        LD	HL,0FF39H
        ADD	HL,SP	; 200 bytes for stack
        LD	DE,(TXTTAB)
        SBC	HL,DE	; max size of BASIC program
        JP	C,L662A	; nothing left,
        PUSH	HL
        CALL	L5EAF	; get filehandle
        PUSH	BC
        XOR	A		; rel to start
        LD	DE,0
        LD	HL,1	; pos 1 (after header)
        LD	C,04AH
        CALL	L655D	; SEEK
        POP	BC		; filehandle
        LD	DE,(TXTTAB)	; basic program starts at TXTTAB
        POP	HL		; size
        PUSH	HL
        LD	C,048H
        CALL	L655D	; read program
        POP	DE
        PUSH	HL
        AND	A
        SBC	HL,DE
        POP	HL
        JP	NC,L662A	; does not fit,
        LD	DE,(TXTTAB)
        ADD	HL,DE
        LD	(VARTAB),HL	; set VARTAB
        LD	IX,M4253
        CALL	L664F		; convert linenumbers to pointers
        LD	A,(FILNAM)
        AND	A		; RUN flag ?
        RET	NZ		; yep, quit
        LD	(NLONLY),A	; no channel stays open
        LD	HL,L5CED
        LD	DE,BUF+10
        LD	BC,5
        PUSH	DE
        LDIR			; install fini
        POP	HL
        LD	IX,M4601
        JP	L664F		; execute it

L5CED:	DEFB	03AH,092H,0
        DEFW	0

L5CF2:	PUSH	DE
        CALL	L5E7E	; eval ,startadres
        LD	(SAVENT),DE
        PUSH	DE
        CALL	L5E7E	; eval ,endadres
        LD	(SAVEND),DE
        EX	(SP),HL
        EX	DE,HL
        RST	DCOMPR 	; start > end ?
        JP	C,L662D	; yep, error
        EX	DE,HL
        EX	(SP),HL
        CALL	L665E	; end of statement ?
        SCF
        JR	Z,L5D26	; yep, RAM BSAVE
        CALL	L6654
        DEFB	","          ; eval ","
        CP	"S"
        JR	NZ,L5D1E	; nop,
        CALL	L665F	; eval "S"
        AND	A
        JR	L5D26	; VRAM BSAVE
L5D1E:	CALL	L5E82	; eval execadres
        LD	(SAVENT),DE
        SCF		; RAM BSAVE
L5D26:	POP	BC
        JR	NC,L5D2E
        INC	B
        DEC	B		; startadres >#7FFF ?
        JP	P,L662D	; nop, error
L5D2E:	POP	DE
        PUSH	HL
        PUSH	BC
        PUSH	AF
        XOR	A		; I/O channel 0
        LD	E,2		; OUTPUT
        LD	IX,M6AFA
        CALL	L664F		; open I/O channel
        LD	A,0FEH
        CALL	L5E8F	; write headerid
        POP	AF
        POP	HL
        PUSH	HL
        PUSH	AF
        CALL	L5E89	; write startadres
        LD	HL,(SAVEND)
        CALL	L5E89	; write endadres
        LD	HL,(SAVENT)
        CALL	L5E89	; write execadres
        POP	AF
        POP	BC
        PUSH	AF
        LD	HL,(SAVEND)
        AND	A
        SBC	HL,BC
        INC	HL		; # of bytes
        POP	AF
        JR	NC,L5D76	; VRAM
        LD	E,C
        LD	D,B
        CALL	L5EA7	; write memory
L5D66:	LD	A,0FFH
        LD	(FLBMEM),A	; no ^Z at end
        XOR	A
        LD	IX,M6B24
        CALL	L664F		; close I/O channel
        JP	L627A

L5D76:	CALL	L6511	; get workspace
L5D79:	PUSH	HL
        LD	DE,(SAVENT)
        RST	DCOMPR 	; can it be done once ?
        PUSH	AF
        PUSH	BC
        LD	C,L
        LD	B,H
        LD	HL,(SAVEND)
        PUSH	HL
        ADD	HL,BC
        LD	(SAVEND),HL	; adjust
        POP	HL
        POP	DE
        PUSH	DE
        CALL	LDIRMV	; copy VRAM to memory
        POP	BC
        POP	AF		; ready ?
        JR	NC,L5DAB	; yep,
        POP	HL
        PUSH	HL
        PUSH	BC
        LD	E,C
        LD	D,B
        CALL	L5EA7	; write memory
        POP	BC
        POP	DE
        LD	HL,(SAVENT)
        AND	A
        SBC	HL,DE
        LD	(SAVENT),HL	; adjust # of bytes
        EX	DE,HL
        JR	L5D79	; again
L5DAB:	POP	HL
        LD	HL,(SAVENT)
        LD	E,C
        LD	D,B
        CALL	L5EA7	; write memory
        JR	L5D66	; close

L5DB6:	PUSH	DE
        XOR	A
        LD	(RUNBNF),A	; no exec/vram
        LD	C,A
        LD	B,A		; offset = 0
        CALL	L665E	; end of statement ?
        JR	Z,L5DDF	; yep, just load
        CALL	L6654
        DEFB	","          ; eval ","
        CP	"R"
        JR	Z,L5DCE
        CP	"S"
        JR	NZ,L5DDA
L5DCE:	LD	(RUNBNF),A
        CALL	L665F	; eval "R" or "S"
        JR	Z,L5DDF	; end of statement,
        CALL	L6654
        DEFB	","          ; eval ","
L5DDA:	CALL	L5E82	; eval offset
        LD	B,D
        LD	C,E		; offset
L5DDF:	POP	DE
        PUSH	HL
        PUSH	BC
        LD	A,0FFH
        LD	(FLBMEM),A	; no BINBAS check
        XOR	A		; I/O channel 0
        LD	E,1		; INPUT
        LD	IX,M6AFA
        CALL	L664F		; open I/O channel
        CALL	L5E92	; read byte
        CP	0FEH		; BSAVE header ?
        JP	NZ,L65EA	; nop,
        POP	BC
        CALL	L5E70	; get startadres (+offset)
        PUSH	HL
        CALL	L5E70	; get endadres (+offset)
        PUSH	HL
        CALL	L5E70	; get execadres (+offset)
        LD	(SAVENT),HL
        POP	HL
        POP	BC
        AND	A
        SBC	HL,BC
        INC	HL		; # of bytes
        LD	A,(RUNBNF)
        CP	"S"          ; VRAM BLOAD ?
        JR	Z,L5E28	; yep,
        LD	E,C
        LD	D,B
        CALL	L5EAF	; get filehandle
        LD	C,048H
        CALL	L655D	; read memory
L5E1F:	LD	IX,M4AFF
        CALL	L664F		; return interpreter output to screen
        POP	HL
        RET
L5E28:	CALL	L6511	; get workspace
L5E2B:	PUSH	HL
        PUSH	BC
        LD	DE,(SAVENT)
        RST	DCOMPR 	; can it be done once ?
        PUSH	AF
        LD	E,C
        LD	D,B
        CALL	L5EAF	; get filehandle
        LD	C,048H
        CALL	LF37D	; READ
        POP	AF
        POP	HL
        POP	BC
        PUSH	BC
        PUSH	HL
        PUSH	AF
        LD	HL,(SAVEND)
        PUSH	HL
        ADD	HL,BC
        LD	(SAVEND),HL	; adjust start
        POP	DE
        POP	AF		; ready ?
        POP	HL
        JR	NC,L5E62	; yep,
        PUSH	HL
        CALL	LDIRVM
        POP	BC
        POP	DE
        LD	HL,(SAVENT)
        AND	A
        SBC	HL,DE
        LD	(SAVENT),HL	; adjust
        EX	DE,HL
        JR	L5E2B	; again
L5E62:	POP	BC
        LD	BC,(SAVENT)
        CALL	LDIRVM
        XOR	A
        LD	(RUNBNF),A	;
        JR	L5E1F

L5E70:	PUSH	BC
        CALL	L5E92	; get byte
        PUSH	AF
        CALL	L5E92	; get byte
        LD	H,A
        POP	AF
        LD	L,A		; adres
        POP	BC
        ADD	HL,BC	; + offset
        RET

L5E7E:	CALL	L6654
        DEFB	","		; eval ","

L5E82:	LD	IX,M6F0B
        JP	L664F		; evaluate BLOAD/BSAVE adres operand

L5E89:	PUSH	HL
        LD	A,L
        CALL	L5E8F	; write byte
        POP	AF		; write byte

L5E8F:	LD	C,049H	; WRITE
        DEFB	021H

L5E92:	LD	C,048H
        CALL	L5EAF	; get filehandle
        PUSH	AF 	; byte/space on stack
        LD	HL,1
        ADD	HL,SP	; pointer to byte/space
        EX	DE,HL
        LD	HL,1	; 1 byte
        PUSH	BC
        CALL	L655D	; read/write
L5EA4:	POP	BC
        POP	AF
        RET

L5EA7:	CALL	L5EAF	; get filehandle
        LD	C,049H
        JP	L655D

L5EAF:	PUSH	HL
        LD	HL,(FILTAB)
        LD	B,(HL)
        INC	HL
        LD	H,(HL)
        LD	L,B
        INC	HL
        LD	B,(HL)
        POP	HL
        RET

L5EBB:	CALL	L6888	; remove orginal return
        CALL	L665F
        CALL	L6654
        DEFB	"("          ; Check on "(" with error
        CALL	L5F09	; Get two operands (nn,nnnn)
        CALL	L6654
        DEFB	")"          ; Check on ")" with error
        PUSH	HL
        LD	HL,M3FD6
        LD	(DAC+2),HL	; Pointer to nul string
        LD	A,3
        LD	(VALTYP),A	; parameter = stringtype
        LD	L,02FH
        JR	L5EE9

L5EDC:	CALL	L6888	; remove orginal return
        CALL	L5F09	; Get two operands (nn,nnnn)
        CALL	L665E	; end of statement ?
        RET	NZ		; nop, quit
        PUSH	HL
        LD	L,030H
L5EE9:	PUSH	HL
        PUSH	DE
        PUSH	BC
        LD	DE,BUF+10
        LD	L,C		; Driveid
        LD	C,031H
        CALL	L655D	; DPARM
        LD	DE,(LF351)	; Address temp sectorbuffer
        LD	C,01AH
        CALL	LF37D	; Set as DMA address
        POP	HL
        DEC	L		; Driveid (0 = A:)
        LD	H,1	; 1 sector
        POP	DE		; sectornumber
        POP	BC		; function
        CALL	L655D	; BDOS call
        POP	HL		; Basicpointer
        RET

L5F09:	LD	IX,M521C
        CALL	L664F		; evaluate byte operand
        PUSH	DE
        CALL	L6654
        DEFB	","		; eval ","
        LD	IX,M542F
        CALL	L664F		; evaluate adres operand
        POP	BC
        RET

L5F1E:	LD	IX,LF38B
        LD	IY,0400H
        CALL	L59E9	; remove orignal return
        LD	A,(HL)
        CP	4		; random file ?
        JP	NZ,L65EA	; nop,
        EX	(SP),HL
        CALL	L665E	; end of statement ?
        JR	Z,L5F7D	; yep,
        CALL	L6654
        DEFB	","
        LD	IX,M4C64
        CALL	L664F		; evaluate expression
        PUSH	HL
        CALL	L6147	; convert to 32 bits integer
        LD	A,C
        OR	B
        OR	L
        OR	H		; record number is 0 ?
        JP	Z,L662D	; yep,
        LD	A,C
        OR	B
        DEC	BC
        JR	NZ,L5F51
        DEC	HL		; record number 0 based
L5F51:	EX	DE,HL
        POP	HL
        EX	(SP),HL
        PUSH	HL
        PUSH	DE
        INC	HL
        INC	HL
        LD	E,(HL)
        LD	D,0
        INC	DE		; record size
        CALL	L689F	; multiply
        POP	IX
        PUSH	BC
        PUSH	IX
        POP	BC
        CALL	L68A2	; multiply
        LD	A,L
        OR	H
        JP	NZ,L662D
        LD	E,C
        LD	D,B
        POP	HL
        POP	BC
        PUSH	BC
        INC	BC
        LD	A,(BC)
        LD	B,A		; filehandle
        XOR	A		; from begin
        LD	C,04AH
        CALL	LF37D	; SEEK
        POP	HL
        EX	(SP),HL
L5F7D:	EX	(SP),HL
        INC	HL
        LD	B,(HL)
        INC	HL
        LD	E,(HL)
        LD	D,0
        INC	DE		; recordsize
        INC	HL
        INC	HL
        INC	HL
        INC	HL
        INC	HL
        INC	HL
        INC	HL		; buffer
        EX	DE,HL
        POP	IX
        POP	AF
        PUSH	IX
        AND	A
        LD	C,048H	; READ
        JR	Z,L5F99
        LD	C,049H	; WRITE
L5F99:	CALL	L655D	; do BDOS
        JP	L627A

L5F9F:	CALL	L6888		; remove orginal return
        CP	"#"
        CALL	Z,L665F		; yep, eval "#"
        LD	IX,M521C
        CALL	L664F		; evaluate byte operand
        JP	Z,L6630		; end of statement,
        PUSH	HL
        LD	IX,M6A6D
        CALL	L664F		; get I/O channel pointer
        LD	E,L
        LD	D,H
        JP	Z,L6645	; not open,
        JP	C,L662D	; illegal,
        LD	A,(HL)
        CP	4		; RANDOM ?
        JP	NZ,L65EA	; nop,
        INC	HL
        INC	HL
        LD	L,(HL)
        LD	H,0
        INC	HL
        LD	(BUF+10),HL	; recordsize
        LD	HL,0
        LD	(BUF+12),HL	; field size = 0
        LD	BC,9
        POP	HL
L5FDA:	EX	DE,HL
        ADD	HL,BC	; pointer in buffer
        EX	DE,HL
        LD	A,(HL)
        CP	","
        RET	NZ		; no more fields, quit
        PUSH	DE
        LD	IX,M521B
        CALL	L664F		; evaluate next byte operand
        PUSH	AF
        CALL	L6654
        DEFB	"A"
        CALL	L6654
        DEFB	"S"		; eval "AS"
        LD	IX,L5EA4
        CALL	L664F		; find variable
        LD	IX,M5597
        CALL	L664F		; GETYPR
        JP	NZ,L6627	; no string,
        POP	AF
        EX	(SP),HL
        PUSH	DE
        PUSH	HL
        LD	HL,(BUF+12)
        LD	C,A
        LD	B,0
        ADD	HL,BC
        LD	(BUF+12),HL	; adjust field size
        EX	DE,HL
        LD	HL,(BUF+10)
        RST	DCOMPR 	; is it above the record size ?
        JP	C,L6633	; yep,
        POP	DE
        POP	HL
        LD	(HL),C
        INC	HL
        LD	(HL),E
        INC	HL
        LD	(HL),D	; string points in buffer
        LD	B,0
        POP	HL
        JR	L5FDA

L6025:	DEFB	0F6H		; OR #37

L6026:	SCF
        CALL	L6888	; remove orginal return
        PUSH	AF
        LD	IX,L5EA4
        CALL	L664F	; search for variable
        LD	IX,M5597
        CALL	L664F		; GETYPR
        JP	NZ,L6627	; non string,
        PUSH	DE
        LD	IX,M4C5F
        CALL	L664F		; evaluate =expression
        POP	BC
        EX	(SP),HL
        PUSH	HL
        PUSH	BC
        LD	IX,M67D0
        CALL	L664F		; free temporary stringdescriptor
        LD	B,(HL)	; length
        EX	(SP),HL
        LD	A,(HL)
        LD	C,A		; width of fieldvar
        PUSH	BC
        PUSH	HL
        PUSH	AF
        INC	HL
        LD	E,(HL)
        INC	HL
        LD	D,(HL)	; address fieldvar
        OR	A
        JR	Z,L60B9	; zero length ???
        LD	HL,(NULBUF)
        DEC	HL
        RST	DCOMPR 	; is string in databuffer ?
        JR	C,L6097	; yep,
        LD	HL,(VARTAB)
        RST	DCOMPR 	; is string in BASIC text ?
        JR	C,L6097	; nop,
        LD	E,C
        LD	D,0
        LD	HL,(STKTOP)
        ADD	HL,DE
        EX	DE,HL
        LD	HL,(FRETOP)
        RST	DCOMPR 	; does string fit in stringspace ?
        JR	C,L60CC	; nop,
        POP	AF
L6079:	LD	A,C
        LD	IX,M668E
        CALL	L664F		; allocate stringspace
        POP	HL
        POP	BC
        EX	(SP),HL
        PUSH	DE
        PUSH	BC
        LD	IX,M67D0
        CALL	L664F		; free temporary stringdescriptor
        POP	BC
        POP	DE
        EX	(SP),HL
        PUSH	BC
        PUSH	HL
        INC	HL
        PUSH	AF
        LD	(HL),E
        INC	HL
        LD	(HL),D
L6097:	POP	AF
        POP	HL
        INC	HL
        LD	E,(HL)
        INC	HL
        LD	D,(HL)
        POP	BC
        POP	HL
        INC	HL
        LD	A,(HL)
        INC	HL
        LD	H,(HL)
        LD	L,A
        LD	A,C
        CP	B
        JR	NC,L60A9
        LD	B,A
L60A9:	SUB	B
        LD	C,A
        POP	AF
        CALL	NC,L60C3
        INC	B
L60B0:	DEC	B
        JR	Z,L60BE
        LD	A,(HL)
        LD	(DE),A
        INC	HL
        INC	DE
        JR	L60B0
L60B9:	POP	BC
        POP	BC
        POP	BC
        POP	BC
        POP	BC
L60BE:	CALL	C,L60C3
        POP	HL
        RET

L60C3:	LD	A,020H
        INC	C
L60C6:	DEC	C
        RET	Z
        LD	(DE),A
        INC	DE
        JR	L60C6

L60CC:	POP	AF
        POP	HL
        POP	BC
        EX	(SP),HL
        EX	DE,HL
        JR	NZ,L60E0
        PUSH	BC
        LD	A,B
        LD	IX,M6627
        CALL	L664F			; allocate temp string
        CALL	L6107
        POP	BC
L60E0:	EX	(SP),HL
        PUSH	BC
        PUSH	HL
        JP	L6079

L60E6:	LD	A,2
        DEFB	1			; Pseudo LD BC,nnnn
L60E9:	LD	A,4
        DEFB	1			; Pseudo LD BC,nnnn
L60EC:	LD	A,8
        CALL	L6888			; remove orginal return
        PUSH	AF
        LD	IX,M517A
        CALL	L664F			; convert DAC to other type
        POP	AF
        LD	IX,M6627
        CALL	L664F			; allocate temp string
        LD	HL,(DSCTMP+1)
        CALL	M2F10			; copy HL to DAC
L6107:	LD	DE,DSCTMP
        LD	HL,(TEMPPT)
        LD	(DAC+2),HL
        LD	A,3
        LD	(VALTYP),A
        CALL	M2EF3			; copy to HL
        LD	DE,FRETOP
        RST	DCOMPR
        LD	(TEMPPT),HL
        JP	Z,L6624
        RET

L6123:	LD	A,1
        DEFB	1			; Pseudo LD BC,nnnn
L6126:	LD	A,3
        DEFB	1			; Pseudo LD BC,nnnn
L6129:	LD	A,7
        CALL	L6888			; remove orginal return
        PUSH	AF
        LD	IX,M67D0
        CALL	L664F			; free temporary stringdescriptor
        POP	AF
        CP	(HL)
        JP	NC,L662D
        INC	A
        INC	HL
        LD	C,(HL)
        INC	HL
        LD	H,(HL)
        LD	L,C
        LD	(VALTYP),A
        JP	M2F08			; copy DAC to HL

L6147:	LD	IX,M5597
        CALL	L664F			; GETYPR
        JP	M,L61B3
        JP	Z,L6627
        LD	HL,DAC
        LD	A,(HL)
        AND	A
        JP	M,L662D
        LD	DE,BUF+10
        LD	BC,8
        LDIR
        LD	HL,L61C0
        LD	DE,ARG
        LD	C,8
        LDIR
        CALL	M289F			; divide double
        AND	A			; Cx reset (double)
        CALL	M30D1			; INT
        LD	IX,M5432
        CALL	L664F			; convert to adres
        PUSH	DE
        EX	DE,HL
        LD	IX,M46FF
        CALL	L664F			; convert unsigned integer to single
        CALL	M3042			; convert DAC from single to double
        LD	BC,06545H
        LD	DE,06053H
        CALL	M325C			; multiply single
        LD	HL,DAC
        PUSH	HL
        LD	DE,ARG
        LD	BC,8
        LDIR
        LD	HL,BUF+10
        POP	DE
        LD	C,8
        LDIR
        CALL	M268C
        LD	IX,M5432
        CALL	L664F			; convert to adres
        LD	C,E
        LD	B,D
        POP	HL
        RET

L61B3:	LD	BC,(DAC+2)
        INC	B
        DEC	B
        JP	M,L662D
        LD	HL,0
        RET

L61C0:	DEFB	045H,065H,053H,060H,0,0,0,0

L61C8:	CALL	L6888		; remove orginal return
        PUSH	HL
        CALL	L5B60		; get char
        LD	HL,0
        JR	NC,L61D5	; no end, 0
        DEC	HL		; end, -1
L61D5:	PUSH	AF
        CALL	M2F99		; HL in DAC
        POP	AF
        POP	HL
        INC	HL
        INC	HL
        INC	HL
        LD	(HL),A		; back up char
        RET

L61E0:	CALL	L6888		; remove orginal return
        CALL	L665E		; end of statement ?
        JR	Z,L61F1		; yep, spec is *.*
        CP	","
        JR	Z,L61F1		; no spec, take *.*
        CALL	L6350
        JR	L61F7
L61F1:	XOR	A
        LD	DE,(LF33B)	; pathname buffer
        LD	(DE),A		; nul string -> *.*
L61F7:	CALL	L665E		; end of statement ?
        SCF
        JR	Z,L6206		; yep, not the long version
        CALL	L6654
        DEFB	","
        CALL	L6654
        DEFB	"L"
        AND	A
L6206:	PUSH	HL
        LD	A,(PRTFLG)
        INC	A
        DEC	A		; to printer ?
        PUSH	AF
        LD	IX,M7323
        CALL	L664F		; newline to OUTDO if not at start of line
        POP	AF
        PUSH	AF
        LD	A,016H		; normal, hidden & system files, directories
        JR	NC,L621C
        LD	A,010H		; normal files & directories
L621C:	CALL	L599D		; find file/subdirectory
        LD	A,C
        ADD	A,"A"-1
        RST	OUTDO
        LD	A,":"
        RST	OUTDO
        LD	A,"\"
        RST	OUTDO 		; drive:\
        LD	DE,BUF+75
        PUSH	DE
        LD	C,05EH
        CALL	L655D		; GET WHOLE PATH
        LD	(HL),A
        DEC	HL
        LD	(HL),A		; terminate at end of directory
        POP	HL
        CALL	L62FC		; print directory
        LD	IX,M7328
        CALL	L664F		; newline to OUTDO
L6240:	POP	AF
        PUSH	AF
        CALL	L6282		; print file
        CALL	CKCNTC		; check CTRL-STOP
        POP	AF
        PUSH	AF
        JR	NC,L6267	; the long version
        LD	A,(LINLEN)
        LD	B,A		; screen width
        LD	A,(TTYPOS)
        JR	Z,L625A		; to screen
        LD	B,80		; printer width = 80
        LD	A,(LPTPOS)
L625A:	AND	A		; at start ?
        JR	Z,L626E		; yep, no space
        ADD	A,13
        CP	B		; does a name fit ?
        JR	NC,L6267	; nop, new line
        LD	A," "
        RST	OUTDO 		; space
        JR	L626E
L6267:	LD	IX,M7328
        CALL	L664F		; newline to OUTDO
L626E:	LD	IX,BUF+10
        LD	C,041H
        CALL	LF37D		; FNEXT
        JR	Z,L6240		; found, next
        POP	AF
L627A:	POP	HL
        LD	IX,M4AFF
        JP	L664F		; return interpreter output to screen

L6282:	JR	NC,L62A4	; long output,
L6284:	LD	DE,BUF+11
        LD	HL,(LF33B)	; pathname buffer
        LD	C,"\"
        CALL	L655D		; PARSE FILENAME
        LD	B,8
        CALL	L629E		; print main name
        LD	A,(HL)
        CP	" "		; extension present ?
        JR	Z,L629B		; nop, print space
        LD	A,"."
L629B:	RST	OUTDO		; yep, print dot
        LD	B,3		; print extension name

L629E:	LD	A,(HL)
        RST	OUTDO
        INC	HL
        DJNZ	L629E
        RET

L62A4:	CALL	L6284	; print filename
        LD	A," "
        RST	OUTDO 	; space
        LD	A,(BUF+10+14)
        LD	C,A
        BIT	4,C 	; directory ?
        LD	A,"d"
        CALL	L62F6	; print if
        BIT	0,C 	; read only ?
        LD	A,"r"
        CALL	L62F6	; print if
        BIT	1,C 	; hidden ?
        LD	A,"h"
        CALL	L62F6	; print if
        BIT	2,C 	; system ?
        LD	A,"s"
        CALL	L62F6	; print if
        BIT	5,C 	; archive ?
        LD	A,"a"
        CALL	L62F6	; print if
        LD	BC,(BUF+10+21)
        LD	HL,(BUF+10+23)		; filesize
        CALL	L63BA
        LD	IX,M537B
        CALL	L664F			; convert DAC to text, unformatted
        INC	HL
        PUSH	HL
        LD	B,12
L62E6:	LD	A,(HL)
        INC	HL
        DEC	B
        AND	A
        JR	NZ,L62E6	; how many karakters
        LD	A," "
L62EE:	RST	OUTDO
        DJNZ	L62EE	; print space
        POP	HL
        CALL	L62FC
        RET

L62F6:	JR	NZ,L62FA
        LD	A,"-"
L62FA:	RST	OUTDO
        RET

L62FC:	LD	A,(HL)
        AND	A
        INC	HL
        RET	Z
        RST	OUTDO
        JR	L62FC

L6303:	CALL	L6888	; remove orginal return
        CALL	L6350	; eval diskfile spec
        CALL	L665E	; end of statement
        RET	NZ		; nop, quit
        PUSH	HL
        CALL	L59D1	; Find first normal file
        LD	C,04DH	; DELETE
        JR	L632E

L6315:	CALL	L6888	; remove orginal return
        CALL	L6350	; eval diskfile spec
        PUSH	HL
        CALL	L59D1	; Find first normal file
        POP	HL
        CALL	L6654
        DEFB	"A"
        CALL	L6654
        DEFB	"S"          ; eval "AS"
        CALL	L6350	; eval diskfile spec
        PUSH	HL
        LD	C,04EH	; RENAME
L632E:	PUSH	BC
        LD	DE,BUF+10	; FIB
        LD	HL,(LF33B)	; pathname buffer
        CALL	L655D	; BDOS
        CALL	L59D8	; Find next file
        POP	BC
        JR	NC,L632E	; found, cont
        CALL	L6343	; flush buffers
        POP	HL
        RET

L6343:	LD	B,0FFH
        LD	D,0
        LD	C,05FH
        JP	L655D

L634C:	CALL	L6654
        DEFB	"("
L6350:	LD	IX,M6A0E
        CALL	L664F		; evaluate filename expression
        LD	A,D
        CP	8+1
        RET	C		; device a diskdrive, OK
        JP	L65ED

L635E:	LD	A,2
        DEFB	011H

L6361:	LD	A,1
        CALL	L6888			; remove orginal return
        PUSH	AF
        LD	IX,M521F
        CALL	L664F			; convert to byte
        LD	IX,M6A6D
        CALL	L664F			; get I/O channel pointer
        JP	C,L662D			; illegal,
        JP	Z,L6645			; not open,
        INC	HL
        LD	B,(HL)			; filehandle
        INC	HL
        LD	C,(HL)			; record size
        LD	A,1			; rel to current
        LD	DE,0
        LD	HL,0			; offset 0
        PUSH	BC
        LD	C,04AH
        CALL	L655D			; SEEK
        POP	BC
        POP	AF
        DEC	A			; LOC ?
        JR	NZ,L6399		; nop, LOF
        PUSH	BC
        CALL	L63E4			; pos to record
        POP	BC
        JR	L63B7
L6399:	PUSH	HL
        PUSH	DE
        LD	A,2			; rel to end
        LD	DE,0
        LD	HL,0			; offset 0
        LD	C,04AH
        PUSH	BC
        CALL	L655D			; SEEK
        POP	BC
        POP	IX
        EX	(SP),HL
        PUSH	DE
        PUSH	IX
        POP	DE
        XOR	A			; seek back to old pos
        CALL	L655D			; SEEK
        POP	DE
        POP	HL
L63B7:	LD	C,L
        LD	B,H
        EX	DE,HL
L63BA:	PUSH	BC
        LD	IX,M46FF
        CALL	L664F			; convert unsigned integer to single
        LD	BC,06545H
        LD	DE,06053H		; 65536
        CALL	M325C			; multiply single
        LD	HL,DAC
        LD	DE,ARG
        LD	BC,8
        LDIR				; ARG = DAC
        POP	HL
        LD	IX,M46FF
        CALL	L664F			; convert unsigned integer to single
        CALL	M3042			; convert DAC from single to double
        JP	M269A			; add

L63E4:	INC	C
        JR	NZ,L63EF	; size not 256
        LD	A,L
        LD	L,H
        LD	H,E
        LD	E,D
        LD	D,0	; "/256"
        JR	L6403
L63EF:	XOR	A
        LD	B,021H
L63F2:	ADC	A,A
        JR	C,L63F9
        CP	C
        CCF
        JR	NC,L63FB
L63F9:	SUB	C
        SCF
L63FB:	ADC	HL,HL
        EX	DE,HL
        ADC	HL,HL
        EX	DE,HL
        DJNZ	L63F2

L6403:	OR	A
        RET	Z
        INC	L
        RET	NZ
        INC	H
        RET	NZ
        INC	E
        RET	NZ
        INC	D
        RET

L640D:	CALL	L6888		; remove orginal return
        LD	IX,M521F
        CALL	L664F		; convert to byte
        AND	A		; non default drive ?
        CALL	NZ,L5846	; yep, check if valid drive
        LD	E,A
        LD	C,01BH
        CALL	LF37D		; ALLOC (get free clusters)
        JP	M2F99		; HL in DAC

L6424:	CALL	L6888	; remove orginal return
        CALL	L6350	; eval diskfile spec
        PUSH	HL
        CALL	L59D1	; Find first normal file
        POP	HL
        CALL	L665E	; end of statement ?
        LD	A,0
        PUSH	HL
        LD	HL,(LF33B)	; pathname buffer
        LD	(HL),A	; null string
        POP	HL
        JR	Z,L6447	; yep,
        CALL	L6654
        DEFB	0D9H 	; eval TO
        CALL	L6350	; eval diskfile spec
        CALL	L665E	; end of statement ?
        RET	NZ		; nop, quit
L6447:	PUSH	HL
L6448:	CALL	CKCNTC	; check CTRL-STOP
        LD	DE,BUF+10
        XOR	A		; read & write
        LD	C,043H
        CALL	L655D	; open source file
        LD	A,B
        LD	(BUF+138),A	; filehandle
        XOR	A		; get
        LD	C,056H
        CALL	L655D	; GET FILEHANDLE TIME
        LD	(BUF+140),DE
        LD	(BUF+142),HL	; store
        LD	A,0FFH
        LD	(BUF+139),A	; destination file not open
        LD	HL,L6532
        LD	(LF325),HL	; set CTRL-STOP handler
        CALL	L6518	; get copy space
        LD	E,C
        LD	D,B		; start of space
L6475:	PUSH	HL
        PUSH	DE
L6477:	LD	A,L
        OR	H		; space left to read ?
        JR	Z,L6498	; nop, copy first
        PUSH	HL
        PUSH	DE
        LD	A,(BUF+138)
        LD	B,A		; filehandle
        LD	C,048H
        CALL	LF37D	; READ
        JR	Z,L648A
        CP	0C7H		; end of file ?
L648A:	JP	NZ,L6538	; nop,
        EX	DE,HL
        POP	HL
        ADD	HL,DE	; new buffer address
        EX	(SP),HL
        SBC	HL,DE	; bytes not read
        LD	A,E
        OR	D		; end of file reached ?
        POP	DE
        JR	NZ,L6477	; nop, again
L6498:	EX	DE,HL
        POP	DE
        PUSH	DE
        SBC	HL,DE
        LD	A,(BUF+139)
        INC	A		; destination file open ?
        JR	NZ,L64CC	; yep,
        PUSH	HL
        LD	HL,BUF+11
        LD	DE,BUF+75
        LD	BC,13
        LDIR		; copy filename
        LD	DE,(LF33B)	; pathname buffer
        LD	B,0
        LD	IX,BUF+74
        LD	C,042H
        CALL	L6534	; FIND NEW
        LD	DE,BUF+74
        XOR	A		; read & write
        LD	C,043H
        CALL	L6534	; OPEN
        LD	A,B
        LD	(BUF+139),A	; filehandle destination file
        POP	HL
L64CC:	POP	DE
        LD	A,(BUF+139)
        LD	B,A		; filehandle
        PUSH	DE
        LD	C,049H
        CALL	L6534	; WRITE
        POP	DE
        POP	BC
        SBC	HL,BC
        LD	L,C
        LD	H,B
        JR	NC,L6475
        LD	A,(BUF+139)
        LD	B,A		; filehandle
        LD	A,1	; set
        LD	IX,(BUF+140)
        LD	HL,(BUF+142)	; time
        LD	C,056H
        CALL	L6534	; SET FILEHANDLE TIME
        LD	A,(BUF+138)
        LD	B,A		; filehandle
        LD	C,045H
        CALL	L6534	; CLOSE
        LD	A,(BUF+139)
        LD	B,A		; filehandle
        LD	C,045H
        CALL	L6534	; CLOSE
        LD	HL,L6568
        LD	(LF325),HL	; set CTRL-STOP handler
        CALL	L59D8	; find next file
        JP	NC,L6448	; found, again
        POP	HL
        RET

L6511:	LD	(SAVENT),HL
        LD	(SAVEND),BC

L6518:	LD	HL,-512
        ADD	HL,SP	; reserve 512 bytes stack
        JR	NC,L652A	; no space, take NULBUF
        LD	BC,(STREND)
        AND	A
        SBC	HL,BC
        JR	C,L652A	; no space, take NULBUF
        LD	A,H
        AND	A		; less then 256 bytes ?
        RET	NZ		; nop take unused BASIC space
L652A:	LD	BC,(NULBUF)
        LD	HL,256
        RET		; use NULBUF

L6532:	LD	L,D
        LD	H,L
L6534:	CALL	LF37D
        RET	Z
L6538:	PUSH	AF
        LD	HL,L6568
        LD	(LF325),HL	; set CTRL-STOP handler
        LD	A,(BUF+138)
        LD	B,A
        LD	C,045H	; CLOSE
        CALL	LF37D
        LD	A,(BUF+139)
        LD	B,A
        INC	A
        LD	C,045H	; CLOSE
        CALL	NZ,LF37D
        POP	AF
        JR	L65C3

L6555:	LD	IX,BUF+10
L6559:	LD	DE,(LF33B)	; pathname buffer
L655D:	CALL	LF37D	; BDOS call
        RET	Z		; No error, quit
        JR	L65C3

L6563:	DEFW	L6565

L6565:	LD	C,2		; abort
        RET

L6568:	DEFW	L6571

L656A:	CP	09DH		; disk operation aborted ?
        JR	NZ,L656F
        LD	A,B		; yep, get errorcode
L656F:	OR	A		; errorcode given ?
        RET

L6571:	CALL	L656A		; errorcode ?
        JR	NZ,L65C3	; yep, handle
        LD	IX,M409B
        JP	L664F		; restart DiskBASIC

L657D:	DEFB	0BAH
        DEFB	03EH		; .NRAMD -> Bad drive name
        DEFB	04BH		; .RAMDX -> RAM disk already exists
        DEFB	0BDH
        DEFB	0BEH
        DEFB	0BFH
        DEFB	0C0H
        DEFB	0C1H
        DEFB	0C2H
        DEFB	0C3H
        DEFB	0C4H
        DEFB	0C5H
        DEFB	0C6H
        DEFB	037H		; .EOF -> Input past end
        DEFB	03CH		; .FILE -> Bad allocation table
        DEFB	0C9H
        DEFB	040H		; .FOPEN -> File still open
        DEFB	041H		; .FILEX -> File already exists
        DEFB	049H		; .DIRX -> Directory already exists
        DEFB	041H		; .SYSX -> File already exists
        DEFB	038H		; .DOT -> Bad file name
        DEFB	0CFH
        DEFB	041H		; .DIRNE -> File already exists
        DEFB	048H		; .FILRO -> File write protected
        DEFB	0D2H
        DEFB	041H		; .DUPF -> File already exists
        DEFB	042H		; .DKFUL -> Disk full
        DEFB	043H		; .DRFUL -> Too many files
        DEFB	04AH		; .NODIR -> Directory not found
        DEFB	035H		; .NOFIL -> File not found
        DEFB	038H		; .PLONG -> Bad filename
        DEFB	038H		; .IPATH -> Bad filename
        DEFB	038H		; .IFNM -> Bad filename
        DEFB	03EH		; .IDRV -> Bad drivename
        DEFB	0DCH
        DEFB	0DDH
        DEFB	0DEH
        DEFB	0DFH
        DEFB	0E0H
        DEFB	0E1H
        DEFB	0E2H
        DEFB	0E3H
        DEFB	0E4H
        DEFB	0E5H
        DEFB	0E6H
        DEFB	0E7H
        DEFB	0E8H
        DEFB	0E9H
        DEFB	0EAH
        DEFB	0EBH
        DEFB	0ECH
        DEFB	0EDH
        DEFB	0EEH
        DEFB	0EFH
        DEFB	0F0H
        DEFB	0F1H
        DEFB	03CH		; .IFAT -> Bad allocation table
        DEFB	045H		; .SEEK -> Disk I/O error
        DEFB	045H		; .WFILE -> Disk I/O error
        DEFB	045H		; .WDISK -> Disk I/O error
        DEFB	045H		; .NDOS -> Disk I/O error
        DEFB	045H		; .UFORM -> Disk I/O error
        DEFB	044H		; .WPROT -> Disk write protected
        DEFB	045H		; .RNF -> Disk I/O error
        DEFB	045H		; .DATA -> Disk I/O error
        DEFB	045H		; .VERFY -> Disk I/O error
        DEFB	046H		; .NRDY -> Disk offline
        DEFB	045H		; .DISK -> Disk I/O error
        DEFB	045H		; .WRERR -> Disk I/O error
        DEFB	045H		; .NCOMP -> Disk I/O error

L65C3:	PUSH	AF
        CALL	L6343		; flush buffers
        POP	AF
        CP	09FH		; Check Ctrl-C pressed
        JR	Z,L65CE
        CP	09EH		; Check Ctrl-Stop pressed
L65CE:	LD	IX,M409B
        JR	Z,L664F		; Yes, restart DiskBASIC
        LD	E,A
L65D5:	CP	0BAH
        JR	C,L65E6	; Errorcodes < #BA, handle normal
        LD	C,A
        LD	B,0
        LD	HL,L657D-0BAH ; Table with basic errorcodes
        ADD	HL,BC
        LD	A,(HL)	; translated code
        LD	E,A
        CP	03CH
        JR	C,L6623	; errorcodes <60, handle standard basicerror
L65E6:	DEFB	1		; Pseudo LD BC,nnnn (begin errorjump table)
        LD	E,03CH
        DEFB	1
L65EA:	LD	E,03DH
        DEFB	1
L65ED:	LD	E,03EH
        DEFB	1
        LD	E,03FH
        DEFB	1
        LD	E,040H
        DEFB	1
        LD	E,041H
        DEFB	1
        LD	E,042H
        DEFB	1
        LD	E,043H
        DEFB	1
        LD	E,044H
        DEFB	1
        LD	E,045H
        DEFB	1
        LD	E,046H
        DEFB	1
        LD	E,047H
        DEFB	1
        LD	E,048H
        DEFB	1
        LD	E,049H
        DEFB	1
        LD	E,04AH
        DEFB	1
        LD	E,04BH
        XOR	A
        LD	(NLONLY),A
        PUSH	DE
        LD	IX,M6B24
        CALL	L664F		; Close I/O buffer
        POP	DE
L6623:	DEFB	1		; Pseudo LD BC,nnnn (begin errorjump table)
L6624:	LD	E,010H
        DEFB	1
L6627:	LD	E,13
        DEFB	1
L662A:	LD	E,7
        DEFB	1
L662D:	LD	E,5
        DEFB	1
L6630:	LD	E,2
        DEFB	1
L6633:	LD	E,032H
        DEFB	1
        LD	E,034H
        DEFB	1
        LD	E,035H
        DEFB	1
L663C:	LD	E,036H
        DEFB	1
        LD	E,037H
        DEFB	1
L6642:	LD	E,038H
        DEFB	1
L6645:	LD	E,03BH
        XOR	A
        LD	(FLBMEM),A
        LD	IX,M406F	; Call the Basic error handler

L664F:	CALL	CALBAS
        EI
        RET

L6654:	CALL	L665E	; Get previous basic char
        EX	(SP),HL
        CP	(HL) 	; Check if good char with DEFB
        JR	NZ,L6630	; No, Syntax error
        INC	HL
        EX	(SP),HL
        INC	HL		; Get next basic char

L665E:	DEC	HL
L665F:	LD	IX,M4666
        JR	L664F		; Get Basic character

L6665:	EI
        LD	A,':'
        CP	(HL)
        JR	Z,L6642
        PUSH	HL
        PUSH	DE
        LD	A,E
        CP	64		; length of string <64 ?
        JR	NC,L6642	; nop, error
        LD	C,E
        LD	B,0
        LD	DE,(LF33B)	; pathname buffer
        PUSH	BC
        PUSH	DE
        LDIR		; copy string
        XOR	A
        LD	(DE),A	; make ASCIIZ
        POP	HL
        POP	BC
        CPIR		; nul char in string ?
        JR	Z,L6642	; yep, error
        LD	C,05BH
        CALL	L6559	; PARSE PATHNAME
        LD	A,(DE)
        CP	':'          ; bad diskdevice ?
        JR	NZ,L6692	; nop, cont
        POP	DE
        POP	HL
        RET		; yep, do device parse

L6692:	BIT	2,B 	; drive specified ?
        JR	NZ,L6698
        LD	C,0	; nop, take default drive
L6698:	LD	A,B
        AND	0C2H 	; path specfied OR last item . or ..
        JR	Z,L66A7	; nop,
        LD	A,(DE)
        OR	A		; parsed to end ?
        JR	NZ,L6642	; nop, error
        POP	DE
        LD	E,A		; zero length
        PUSH	DE
        PUSH	BC
        JR	L66EC
L66A7:	POP	DE
        POP	HL
        LD	IX,(LF33B)	; pathname buffer
        BIT	2,B
        JR	Z,L66B9	; no drivename specified
        INC	HL
        INC	HL
        DEC	E
        DEC	E
        INC	IX
        INC	IX		; after drive specifaction
L66B9:	PUSH	HL
        PUSH	DE
        PUSH	BC
        INC	E
        DEC	E
        JR	Z,L66EC
        LD	C,E
        LD	A,(HL)
        CP	" "
        JP	Z,L6642	; space, error
        LD	B,8
        CALL	L6729	; parse main filename
        JR	Z,L66E9	; end of string,
        BIT	1,D 	; first extended char ?
        JR	Z,L66D4
        DEC	IX		; yep, ignore
L66D4:	LD	A,"."
        LD	(IX+0),A
        INC	IX
        CP	(HL) 	; . also in specification ?
        JR	NZ,L66E2	; no parse rest as extension name
        INC	HL
        DEC	C
        JR	Z,L66E9

L66E2:	LD	B,3
        CALL	L6729
        JR	Z,L66E9
        LD	A,(HL)
        CP	" "
        JP	NZ,L6642
        LD	C,0
;
L66E9:	LD	(IX+0),C
L66EC:	LD	A,(LF348)
        ADD	A,A
        LD	HL,12
        JR	NC,L66F7
        LD	L,20
L66F7:	ADD	HL,SP
        LD	(HL),08BH
        INC	HL
        LD	(HL),0F3H
        INC	HL
        INC	HL
        INC	HL
        INC	HL
        INC	HL
        LD	E,(HL)
        INC	HL
        LD	D,(HL)
        PUSH	HL
        LD	HL,M6E92+3
        RST	DCOMPR		; was called by BSAVE
        LD	BC,(LF2F3)
        JR	Z,L671C		; yep,
        LD	HL,M6EC6+3
        RST	DCOMPR		; was called by BLOAD
        LD	BC,(LF2F1)
        JR	Z,L671C
        LD	C,E
        LD	B,D
L671C:	POP	HL
        LD	(HL),B
        DEC	HL
        LD	(HL),C
        POP	BC
        LD	A,C
        OR	A		; drive specified ?
        CALL	NZ,L5846	; yep, check if valid drive
        POP	DE
        POP	HL
        RET

L6729:	LD	D,1	; supress upcasing
L672B:	PUSH	HL
        PUSH	BC
        LD	E,(HL)
        LD	C,05DH
        CALL	L655D	; CHECK CHAR
        POP	BC
        POP	HL
        LD	A,E
        BIT	4,D 	; valid filename char ?
        JR	NZ,L6746	; nop,
        LD	(IX+0),A
        INC	IX
        INC	HL
        DEC	C
        RET	Z
        DJNZ	L672B
        RET
L6745:	LD	A,(HL)
L6746:	CP	" "          ; invalid char a space ?
        RET	NZ		; nop, quit
        INC	HL
        DEC	C
        RET	Z
        DJNZ	L6745
        RET

L674F:	EI
        LD	A,0	; no device -> default diskdrive
        RET

L6753:	EI
        LD	A,E
        SUB	03CH
        RET	C
        CP	010H
        RET	NC
        INC	A
        LD	B,A
        LD	HL,L6775
L6760:	LD	A,(HL)
        AND	A
        INC	HL
        JR	NZ,L6760
        DJNZ	L6760
        DEC	HL
        LD	DE,BUF+10
        PUSH	DE
        LD	BC,001AH
        LDIR
        LD	E,1
        POP	HL
        RET

L6775:	DEFB	0
        DEFB	"Bad FAT",0
        DEFB	"Bad file mode",0
        DEFB	"Bad drive name",0
        DEFB	"Bad sector number",0
        DEFB	"File still open",0
        DEFB	"File already exists",0
        DEFB	"Disk full",0
        DEFB	"Too many files",0
        DEFB	"Disk write protected",0
        DEFB	"Disk I/O error",0
        DEFB	"Disk offline",0
        DEFB	"Rename across disk",0
        DEFB	"File write protected",0
        DEFB	"Directory already exists",0
        DEFB	"Directory not found",0
        DEFB	"RAM disk already exists",0

L6888:	EI
        PUSH	HL
        PUSH	AF
        LD	A,(LF348)
L688E:	ADD	A,A
        LD	HL,12
        JR	NC,L6896
        LD	L,20
L6896:	ADD	HL,SP
        LD	(HL),08BH
        INC	HL
        LD	(HL),0F3H
        POP	AF
        POP	HL
        RET

L689F:	LD	HL,0
L68A2:	LD	A,17
L68A4:	RR	B
        RR	C
        DEC	A
        RET	Z
L68AA:	JR	NC,L68AD
        ADD	HL,DE
L68AD:	RR	H
L68AF:	RR	L
        JR	L68A4

L68B3:	LD	B,A
        LD	A,(LF23C)	; default drive
        PUSH	AF
        PUSH	BC
        PUSH	HL
        LD	HL,(LF349)
        LD	(LF34B),HL	; Set BOTTOM address for MSX-DOS
        DI
        LD	A,(LF314)
        CALL	LF218		; set default segment page 0
        LD	A,(LF315)
        CALL	LF21E		; set default segment page 1
        LD	A,(LF316)
        CALL	LF224		; set default segment page 2
        LD	A,(LF344)
        LD	H,080H
        CALL	ENASLT		; DOS RAM on page 2
L68DB:	CALL	LF1FD		; DOS RAM on page 0
        LD	HL,0
L68E1:	LD	(HL),H
        INC	L
        JR	NZ,L68E1	; Clear #0000-#00FF
        LD	HL,L6930	; Table with standard routines
L68E8:	LD	E,(HL)
        INC	HL
        LD	D,(HL)
        INC	HL
        LD	A,D
        OR	E
        JR	Z,L68FA		; Ready, go on
        LD	A,0C3H
        LD	(DE),A
        INC	DE
        LDI
        LDI
        JR	L68E8		; Install routines
L68FA:	CALL	LF227		; get current segment page 2
        EX	AF,AF'
        LD	A,(LF2D0)
        CALL	LF224		; invoke BDOS code segment on page 2
        LD	HL,003BH+08000H
        LD	DE,003BH
        LD	BC,001AH
        LDIR			; copy secundairy routines
        EX	AF,AF'
        CALL	LF224		; restore segment page 2
        EI
        POP	HL
        LD	DE,0081H
        LD	B,0FFH
L691A:	LD	A,(HL)
        LD	(DE),A
        INC	HL
        INC	DE
        INC	B
        OR	A
        JR	NZ,L691A	; copy parameter
        LD	A,B
        LD	(0080H),A	; commandline length
        POP	AF
        OR	A		; bootdrive specified ?
        CALL	NZ,L699B	; yep, try bootdrive
        POP	AF
        CALL	L699B	; try default drive
        RET

L6930:	DEFW	000CH,LF1E8
        DEFW	0014H,LF1EB
        DEFW	001CH,LF1EE
        DEFW	0024H,LF1F1
        DEFW	0030H,LF1F4
        DEFW	0038H,LF1E5
        DEFW	0

;
; new bootmethode, boots from any physical drive
;
L694A:	LD	HL,L6A02
        LD	(LF323),HL
        LD	HL,L6A04
        LD	(LF325),HL
        LD	DE,(LF34D)
        LD	C,01AH
        CALL	L69F5
        LD	C,1
        LD	B,8
L696B:	PUSH	BC
        LD	L,C
        DEC	L
        LD	H,1
        LD	DE,0
        LD	C,02FH
        CALL	L69A1
        CALL	L69F5
        CALL	L69B8
        POP	BC
        JR	NZ,L698B
        LD	HL,(LF34D)
        LD	A,(HL)
        OR	02H
        CP	0EBH
        JR	Z,L6990
L698B:	INC	C
        DJNZ	L696B
        XOR	A
        RET

L6990:	LD	A,C
        LD	(LF23C),A
        LD	HL,(LF34D)
        LD	DE,0C000H
        LD	BC,256
        LDIR
        OR	A
        RET

L69A1:	PUSH	HL
        LD	HL,LF24F
        LD	(HL),0C3H
        INC	HL
        LD	(HL),LOW L69B0
        INC	HL
        LD	(HL),HIGH L69B0
        INC	HL
        POP	HL
        RET

L69B0:	EX	(SP),HL
        LD	HL,LF24F
        LD	(HL),0C9H
        POP	HL
        RET

L69B8:	PUSH	AF
        PUSH	HL
        LD	HL,LF24F
        LD	A,(HL)
        CP	0C9H
        JR	NZ,L69E6
        LD	(HL),0C3H
        PUSH	HL
        PUSH	DE
        PUSH	BC
        LD	HL,DRVTBL
        LD	A,(LF33F)
        LD	B,A
        XOR	A
L69CF:	ADD	A,(HL)
        CP	B
        JR	NC,L69D7
        INC	HL
        INC	HL
        JR	L69CF

L69D7:	SUB	(HL)
        LD	L,A
        LD	H,1
        LD	DE,0
        LD	C,02FH
        CALL	L69F5
        POP	BC
        POP	DE
        POP	HL
L69E6:	LD	 (HL),0C9H
        INC	HL
        LD	 (HL),0C9H
        INC	HL
        LD	 (HL),0C9H
        POP	HL
        POP	AF
        RET
;
L699B:	LD	(LF23C),A	; Set default drive
        LD	HL,L6A02	;  just abort
        LD	(LF323),HL	; Set Diskerror handler
        LD	HL,L6A04
        LD	(LF325),HL	; Set CTRL-STOP handler
        LD	B,0
        LD	D,B
        LD	C,06AH
        CALL	L69F5		; cancel drive assignments
        LD	DE,L69E8
        XOR	A
        LD	C,043H
        CALL	L69F5		; Open the file "\MSXDOS2.SYS"
        JR	NZ,L69E7	; Fail, stop
        LD	DE,0100H
        LD	HL,04000H-0100H
        LD	C,048H
        PUSH	BC
        CALL	L69F5		; READ
        POP	BC
        PUSH	AF
        LD	C,045H
        CALL	L69F5		; CLOSE
        POP	AF
        JR	NZ,L69E7	; Failed reading, stop
        LD	A,(LF23C)	; default drive
        LD	(LF2FD),A	; set bootdrive
        LD	A,0C3H
        LD	(XF368+0),A
        LD	(XF36B+0),A
        LD	(XF36E+0),A	; Routines XFER, SetRamPg1, SetRomPg1 active
        JP	0100H		; start MSXDOS2

L69E7:	RET

L69E8:	DEFB	"\MSXDOS2.SYS"
        DEFB	0

L69F5:	CALL	LF37D	; BDOS
        CP	09DH		; Check if diskoperation aborted
        JR	NZ,L69FD
        LD	A,B
L69FD:	OR	A
        RET

L69FF:	LD	C,2		; abort
L6A01:	RET

L6A02:	DEFW	L69FF
L6A04:	DEFW	L6A01

L6A06:	LD	A,(LF314)
        CALL	LF218		; set default segment page 0
        LD	A,(LF315)
        CALL	LF21E		; set default segment page 1
        LD	A,(LF316)
        CALL	LF224		; set default segment page 2
        RET

L6A19:	EXX
        LD	B,A		; errorcode
        EXX
        LD	SP,(LF2E8)	; back to orginal stack
        LD	HL,(LF325)
        JP	L6A3C		; start DOS1 style abort handler

L6A26:	EX	AF,AF'
        LD	L,C
        LD	C,A		; flag
        LD	A,B
        DEC	A		; driveid (0 based)
        LD	B,L		; flags
        LD	HL,(LF323)
        CALL	L6A37		; start DOS1 style disk error handler
        LD	A,3
        SUB	C		; DOS2 return code
        EI
        RET

L6A37:	PUSH	HL
        LD	HL,XF368
        EX	(SP),HL		; Set System ROM on page 1
L6A3C:	PUSH	HL
        LD	HL,LF1E2
        EX	(SP),HL		; start DOS1 style handler
        JP	XF36B		; Set DOS RAM on page 1

L6A44:	DI
        LD	A,1
        LD	(LF2BD),A	; reset no keyboard check counter (because keyboard is scanned as part of this interrupt)
        LD	HL,LF2B9
        INC	(HL)		; increase interrupt count
        LD	A,(LF2B8)
        CP	(HL)		; has 100 ms passed since last ?
        JR	NZ,L6A6A	; nope, do not update counters
        LD	(HL),0		; clear interrupt count
        LD	A,(LF2BE)	; screenoutput buffer counter
        CP	2
        ADC	A,0FFH		; decrease only if >1 (counts down from any value until 1 is reached)
        LD	(LF2BE),A
        LD	A,(LF2BF)	; disk unchanged counter
        CP	7
        ADC	A,0		; increase only if <7 (counts up from 0 until 7 is reached)
        LD	(LF2BF),A
L6A6A:	LD	HL,(LF2BA+0)
        LD	A,(LF2BA+2)	; current random number
        LD	C,A
        RRCA
        RRCA
        RRCA
        XOR	C
        RLA
        RLA
        ADC	HL,HL
        LD	A,C
        ADC	A,A
        LD	(LF2BA+2),A
        LD	(LF2BA+0),HL	; update random number
        RET

L6A82:	LD	IX,(LF2E6)
L6A86:	EX	AF,AF'
        EXX
        LD	HL,L6A19
        LD	(LF302),HL	; Abort handler
        LD	HL,L6A26
        LD	(LF300),HL	; Disk error handler
        LD	HL,(LF2FE)
        OR	A
        SBC	HL,SP
        JR	C,L6AA3
        LD	BC,012CH
        SBC	HL,BC
        JR	C,L6AB4
L6AA3:	LD	(LF2E8),SP	; Save stack
        LD	SP,(LF2FE)
        CALL	L6AB9
        LD	SP,(LF2E8)	; Back to old stack
        OR	A
        RET
L6AB4:	CALL	L6AB9
        OR	A
        RET

L6AB9:	EXX
        PUSH	HL
        LD	A,C
        CP	071H		; Check BDOS call > #70
        JR	C,L6AC2
        LD	A,01CH	; Yes, illegal BDOS (#1C)
L6AC2:	LD	HL,L6AD2	; BDOS Table
        ADD	A,A
        ADD	A,L
        LD	L,A
        JR	NC,L6ACB
        INC	H
L6ACB:	LD	A,(HL)
        INC	HL
        LD	H,(HL)
        LD	L,A
        EX	(SP),HL		; Set BDOS routine address on stack
        EX	AF,AF'
        RET			; invoke BDOS routine

L6AD2:	DEFW	L6C98,L6BB4,L6BB4,L6BB4,L6BB4,L6BB4,L6BB4,L6BB4
        DEFW	L6BB4,L6BBA,L6BCA,L6BB4,L6BB4,L6BB4,L6BB4,L6BEE
        DEFW	L6BEE,L6BEE,L6BB4,L6BEE,L6BEE,L6BEE,L6BEE,L6BEE
        DEFW	L6BB4,L6BB4,L6BB4,L6BE6,L6C98,L6C98,L6C98,L6C98
        DEFW	L6C98,L6BF1,L6BF1,L6BF1,L6BF1,L6C98,L6C12,L6C12
        DEFW	L6BF1,L6C98,L6C2D,L6C2D,L6C2D,L6C2D,L6BB4,L6C98
        DEFW	L6C98,L6C32,L6C98,L6C98,L6C98,L6C98,L6C98,L6C98
        DEFW	L6C98,L6C98,L6C98,L6C98,L6C98,L6C98,L6C98,L6C98
        DEFW	L6C44,L6C4B,L6C44,L6C6D,L6C6D,L6C98,L6C98,L6C98
        DEFW	L6C98,L6C98,L6C98,L6C98,L6C6D,L6C6D,L6C67,L6C67
        DEFW	L6C6D,L6C6D,L6C98,L6C88,L6C88,L6C98,L6C98,L6C98
        DEFW	L6C98,L6CA0,L6CE3,L6C9B,L6CC0,L6C98,L6CA0,L6C98
        DEFW	L6C98,L6C98,L6C98,L6C98,L6C98,L6C98,L6CE9,L6C98
        DEFW	L6C98,L6C98,L6C98,L6C98,L6C98,L6C98,L6C98,L6C98
        DEFW	L6C98

L6BB4:	CALL	L6C98
        LD	A,L
        LD	B,H
        RET

L6BBA:	LD	A,(DE)
        INC	DE
        CP	"$"          	; end of string ?
        JR	Z,L6BE1		; yep, quit
        PUSH	DE
        LD	E,A
        LD	C,2		; CONOUT
        CALL	L6C98		; BDOS
        POP	DE
        JR	L6BBA		; next

L6BCA:	PUSH	DE
        LD	A,(DE)		; max length
        LD	DE,(LF2F5)
        LD	(DE),A		; copy to temp buf
        CALL	L6C98		; BDOS
        POP	DE
        LD	A,(DE)		; max length
        INC	DE
        LD	HL,(LF2F5)
        INC	HL
        LD	C,A
        LD	B,0
        INC	BC
        LDIR			; copy buffer
L6BE1:	XOR	A
        LD	B,A
        LD	L,A
        LD	H,A
        RET

L6BE6:	CALL	L6C98
        LD	A,C		; sectors per cluster
        LD	BC,512		; sectorsize = 512
        RET

L6BEE:	LD	A,021H
        DEFB	021H		; Pseudo LD HL,nnnn
L6BF1:	LD	A,024H
        PUSH	DE
        EXX
        POP	HL
        LD	C,A
        LD	B,0
L6BF9:	PUSH	HL
        PUSH	BC
        LD	DE,(LF2F5)
        PUSH	DE
        LDIR			; copy FCB to buffer
        EXX
        POP	DE
        PUSH	DE
        CALL	L6C98
        EXX
        POP	HL
        POP	BC
        POP	DE
        LDIR			; copy buffer to FCB
        EXX
        LD	A,L
        LD	B,H
        RET

L6C12:	PUSH	DE
        EXX
        POP	HL
        PUSH	HL
        LD	BC,15
        ADD	HL,BC
        LD	C,024H		; FCB for big records
        LD	A,(HL)
        OR	A
        JR	NZ,L6C27	; record >255, ok
        DEC	HL
        LD	A,(HL)
        CP	040H
        JR	NC,L6C27	; record >63, ok
        INC	C		; FCB for small records
L6C27:	POP	HL
        CALL	L6BF9
        EX	DE,HL
        RET

L6C2D:	CALL	L6C98
        LD	A,C
        RET

L6C32:	PUSH	DE
        LD	DE,(LF2F5)	; temp buffer
        CALL	L6C98
        EX	DE,HL
        POP	DE
        PUSH	DE
        LD	BC,32
        LDIR			; copy buffer to original buffer
        POP	DE
        RET

L6C44:	CALL	L6CFD		; copy parameter
        CALL	C,L6D20		; FIB, copy spec parameter
        RET	NZ		; error, quit
L6C4B:	PUSH	IX
        POP	HL
        PUSH	HL
        LD	DE,(LF2F7)
        PUSH	BC
        LD	BC,64
        LDIR			; copy new FIB to temp FIB buf
        POP	BC
        CALL	L6C8D		; BDOS
        POP	DE
        LD	HL,(LF2F7)
        LD	BC,64
        LDIR			; copy back filled FIB
        RET

L6C67:	CALL	L6D20		; copy spec parameter
        LD	HL,(LF2F9)
L6C6D:	EX	AF,AF'
        PUSH	DE
        CALL	L6CFD		; copy parameter
        PUSH	AF
        EX	AF,AF'
        CALL	L6C94
        EX	AF,AF'		; FIB as parameter ?
        EXX
        POP	AF
        POP	DE
        JR	NC,L6C85	; nop,
        LD	HL,(LF2F5)
        LD	BC,64
        LDIR			; update FIB
L6C85:	EX	AF,AF'
        EXX
        RET

L6C88:	EX	AF,AF'
        CALL	L6D20		; copy spec parameter
        EX	AF,AF'
L6C8D:	LD	IX,(LF2F7)
        LD	HL,(LF2F9)
L6C94:	LD	DE,(LF2F5)

L6C98:	JP	LF37A

L6C9B:	PUSH	DE
        CALL	L6D01
        POP	DE
L6CA0:	EX	DE,HL
        PUSH	HL
        LD	DE,(LF2F5)
        OR	A
        SBC	HL,DE
        PUSH	HL
        PUSH	DE
        CALL	L6C98
        EXX
        POP	HL
        POP	BC
        POP	DE
        PUSH	BC
        LD	BC,64
        LDIR
        EXX
        EX	(SP),HL
        EX	DE,HL
        ADD	HL,DE
        EX	(SP),HL
        ADD	HL,DE
        POP	DE
        RET

L6CC0:	PUSH	HL
        PUSH	HL
        LD	L,E
        LD	H,D
        CALL	L6D01
        LD	DE,(LF2F5)
        OR	A
        SBC	HL,DE
        EX	(SP),HL
        PUSH	HL
        CALL	L6C8D
        EXX
        POP	DE
        LD	BC,11
        LD	HL,(LF2F9)
        LDIR
        EXX
        POP	HL
        ADD	HL,DE
        EX	DE,HL
        POP	HL
        RET

L6CE3:	CALL	L6D01
        JP	L6C94

L6CE9:	PUSH	DE
        LD	DE,(LF2FB)
        CALL	L6C98
        EX	DE,HL
        POP	DE
        PUSH	DE
        PUSH	BC
        LD	BC,64
        LDIR
        POP	BC
        POP	DE
        RET

L6CFD:	LD	A,(DE)
        INC	A		; FIB ?
        JR	NZ,L6D11	; nop, ASCIIZ string
L6D01:	PUSH	HL
        PUSH	BC
        EX	DE,HL
        LD	DE,(LF2F5)
        LD	BC,64
        LDIR			; copy FIB to temp buffer
        POP	BC
        POP	HL
        SCF
        RET

L6D11:	PUSH	HL
        PUSH	BC
        EX	DE,HL
        LD	DE,(LF2F5)	; temp buf
        LD	B,100	; max 100 chars
        CALL	L6D2E	; copy ASCIIZ string
        POP	BC
        POP	HL
        RET

L6D20:	PUSH	DE
        PUSH	BC
        LD	DE,(LF2F9)	; 2nd temp buf
        LD	B,100	; max 100 chars
        CALL	L6D2E	; copy ASCIIZ string
        POP	BC
        POP	DE
        RET

L6D2E:	LD	A,(HL)
        INC	HL
        LD	(DE),A
        INC	DE
        OR	A
        RET	Z
        DJNZ	L6D2E
        LD	A,0D8H	; too long, PLONG
        RET


; DSKCHG routine for ramdisk

R_DSKCHG:
        LD	HL,LBC00+32	; Volume signature of ramdisk bootsector
        LD	A,(LF2CF)
        CALL	LF206		; Read from BDOS data segment
        CP	"V"		; Check if "V"
        LD	B,0
        RET	Z		; Yes, disk change unknown
        DEC	B		; Disk changed
        RET

; DSKIO routine for ramdisk

R_DSKIO:
        EI
        LD	(LF2E3),DE	; beginsector
        LD	(LF2E1),HL	; transfer address
        LD	A,B
        LD	(LF2E5),A	; number of sectors
        EX	AF,AF'
        LD	HL,LBC00+32	; Volume signature of ramdisk bootsector
        LD	A,(LF2CF)
        CALL	LF206		; Read from BDOS data segment
        EI
        SUB	"V"		; Check if "V"
        CALL	NZ,L6E5B	; No, format ramdisk
        RET	C		; error, quit
        LD	HL,(SLTTBL+0)
        PUSH	HL
        LD	HL,(SLTTBL+2)
        PUSH	HL		; Save complete SLTTBL
L6D6E:	LD	DE,(LF2E3)	; Beginsector
        CALL	L6DFF		; How many transfers from segment
        JR	C,L6DA6		; error, quit
        LD	E,A		; Can proces now
        LD	A,(LF2E5)	; Number of sectors
        SUB	E		; Check if all sectors can be done
        JR	NC,L6D81	; No, as much as possible, set remainer
        ADD	A,E
        LD	E,A		; process requested number
        XOR	A		; nul sectors to do next
L6D81:	LD	(LF2E5),A
        OR	A
        PUSH	AF
        PUSH	HL
        LD	HL,(LF2E3)
        LD	D,0
        ADD	HL,DE
        LD	(LF2E3),HL	; Adjust beginsector
        POP	HL
        LD	D,E
        SLA D
        LD	E,0	; Number of bytes
        PUSH	DE
        CALL	L6DCA	; transfer
        POP	DE
        LD	HL,(LF2E1)
        ADD	HL,DE
        LD	(LF2E1),HL	; Adjust transfer address
        POP	AF
        JR	NZ,L6D6E	; Not ready yet, again
        XOR	A
L6DA6:	EX	AF,AF'
        DI
        POP	HL
        LD	(SLTTBL+2),HL
        POP	HL
        LD	(SLTTBL+0),HL	; Restore complete SLTTBL
        LD	HL,SLTTBL
        XOR	A
L6DB4:	LD	C,A
        IN	A,(0A8H)
        LD	B,A
        AND	03FH
        OR	C		; page 3 of primairy slot
        LD	E,(HL)	; default value of secundairy slot
        PUSH	HL
        DEC	HL
        DEC	HL
        DEC	HL
        DEC	HL
        BIT	7,(HL)
        POP	HL
        INC	HL
        CALL	NZ,004BH	; set secundairy slot register
        LD	A,C
        ADD	A,040H
        JR	NZ,L6DB4	; for all slots
        EI
        EX	AF,AF'
        LD	B,0
        RET

L6DCA:	DI
        LD	A,(LF344)
        CP	B		; Check if ramdisk segment is in DOS mapper
        JR	Z,L6DE4		; Yes, direct transfer
        CALL	LF221		; Get current segment on page 1
        PUSH	AF
        LD	A,C
        CALL	LF21E		; Set ramdisk segment on page 1
        SET	6,H		; addressing to page 1
        CALL	LF1D3		; transfer from/to page 1
        POP	AF
        CALL	LF21E		; Restore segment on page 1
        EI
        RET
L6DE4:	CALL	LF21B		; Get current segment on page 0
        PUSH	AF
        LD	A,C
        CALL	LF218		; Set ramdisk segment on page 0
        LD	B,D
        LD	C,E
        LD	DE,(LF2E1)	; Transfer address
        EX	AF,AF'		; Check if reading
        JR	NC,L6DF6	; Yes, go
        EX	DE,HL
L6DF6:	EX	AF,AF'
        LDIR			; Transfer to/from memory
        POP	AF
        CALL	LF218		; Restore segment on page 0
        EI
        RET

L6DFF:	LD	A,D
        OR	E		; Check if sector 0 (bootsector)
        JR	NZ,L6E11	; No, other
        LD	A,(LF2CF)
        LD	C,A		; Segment BDOS data
        LD	A,(LF344)
        LD	B,A		; Slotid DOS mapper
        LD	HL,03C00H	; Address (page 0 based)
        LD	A,1		; 1 sector at a time
        RET
L6E11:	CALL	LF227		; Get current segment on page 2
        PUSH	AF
        LD	A,(LF2CF)
        CALL	LF224		; Set BDOS data segment on page 2
        LD	HL,(LBE00)
        LD	H,0		; number of ramdisk segments
        ADD	HL,HL
        ADD	HL,HL
        ADD	HL,HL
        ADD	HL,HL
        ADD	HL,HL		; *32 (32 sectors in a segment)
        POP	AF
        CALL	LF224		; Restore segment on page 2
        SBC	HL,DE		; Check if sector possible
        LD	A,0CH
        RET	C		; No, give "other error"
        LD	H,D
        LD	L,E
        DEC	HL		; Without bootsector
        ADD	HL,HL
        LD	A,L		; highbyte baseaddress sector
        PUSH	AF
        ADD	HL,HL
        ADD	HL,HL
        LD	E,H
        LD	D,0		; segment of sector
        LD	HL,LBE02	; ramdisk segmenttable
        ADD	HL,DE
        ADD	HL,DE
        CALL	LF227		; Get current segment on page 2
        PUSH	AF
        LD	A,(LF2CF)
        CALL	LF224		; Set BDOS data segment on page 2
        LD	C,(HL)		; segmentcode
        INC	HL
        LD	B,(HL)		; slotid mapper
        POP	AF
        CALL	LF224		; Restore segment on page 2
        POP	AF
        AND	03EH		; must be a multiply of 512
        LD	H,A
        LD	L,0		; base address
        LD	A,040H
        SUB	H
        RRCA			; How many sectors behind in segment
        OR	A
        RET

L6E5B:	CALL	LF227		; Get current segment on page 2
        PUSH	AF
        LD	A,(LF2CF)
        CALL	LF224		; Set BDOS data segment on page 2
        LD	A,(LBE00)
        OR	A		; Number of RAMDISK segments
        JR	NZ,L6E73	; <> 0, format
        POP	AF
        CALL	LF224		; Restore segment on page 2
        LD	A,0CH		; Other error
        SCF
        RET
L6E73:	EXX
        LD	HL,LBC00+11
        LD	(HL),LOW 0200H
        INC	HL
        LD	(HL),HIGH 0200H	; Bytes per sector = 512
        INC	HL
        LD	(HL),1
        CP	081H
        JR	C,L6E84		; 1 sector per cluster when <129 segments
        INC	(HL)		; 2 sectors per cluster
L6E84:	INC	HL
        LD	(HL),1
        INC	HL
        LD	(HL),0		; 1 reserved sector (boot)
        INC	HL
        LD	(HL),2		; 2 FAT's
        INC	HL
        LD	C,A
        SRL	A
        SRL	A
        ADD	A,4		; rootdir. sectors = segments\4 +4
        LD	E,A
        LD	D,0
        PUSH	DE
        EX	DE,HL
        ADD	HL,HL
        ADD	HL,HL
        ADD	HL,HL
        ADD	HL,HL		; *16 (Entries per sector)
        EX	DE,HL
        LD	(HL),E
        INC	HL
        LD	(HL),D		; Set Number of directory entries
        INC	HL
        LD	E,C
        LD	D,0		; Number of ramdisk segments
        EX	DE,HL
        ADD	HL,HL
        ADD	HL,HL
        ADD	HL,HL
        ADD	HL,HL
        ADD	HL,HL		; *32 (Sectors in segment)
        INC	HL		; + boot
        EX	DE,HL
        LD	(HL),E
        INC	HL
        LD	(HL),D		; Set Total number of sectors
        INC	HL
        LD	(HL),0FFH	; Set media descriptor (0FFH)
        INC	HL
        EX	DE,HL
        LD	A,C
        DEC	HL		; - bootsector
        POP	BC
        OR	A
        SBC	HL,BC		; - directory sectors
        CP	081H		; Check segments <129
        JR	C,L6EC4		; Yes, 1 sector per cluster
        SRL	H
        RR	L		; /2
L6EC4:	LD	B,H
        LD	C,L
        ADD	HL,BC
        ADD	HL,BC		; *3 bytes
        EX	DE,HL
        DEC	DE
        SRL	D
        SRL	D
        INC	D
        LD	(HL),D
        INC	HL
        LD	(HL),0		; Set number of sectors per FAT
        INC	HL
        LD	HL,L6EE6
        LD	DE,LBC00+32
        LD	BC,11
        LDIR			; Copy volume serial number & id
        EXX
        POP	AF
        CALL	LF224		; Restore segment on page 2
        XOR	A
        RET

L6EE6:	DEFB	"VOL_ID"
L6EEC:	DEFB	0
        DEFB	1
        DEFB	2
        DEFB	3
        DEFB	4


; GETDPB routine for ramdisk

R_GETDPB:
        OR	A
        RET			; do nothing


; CHOICE routine for ramdisk

R_CHOICE:
        LD	HL,L6EEC	; pointer to zero string
        RET


; DSKFMT routine for ramdisk

R_DSKFMT:
        LD	A,0CH		; bad parameter error
        SCF
        RET


; DRIVER section starts here

        INCLUDE	DRIVER.ASM



        DEFS	07FD0H-$,0

L7FD0:
	BNKCHG
        RET


; diskdriver interrupt handler

L7FD4:	EX	AF,AF'
        LD	A,(L40FF)
        PUSH	AF		; Save DOS2 mapper block
        XOR	A
        CALL	L7FD0		; Set block 0
        EX	AF,AF'
        CALL	L7789		; interrupt handler
        EX	AF,AF'
        POP	AF
        CALL	L7FD0		; Set old block
        EX	AF,AF'
        RET

        DEFS	08000H-$,0

        END
