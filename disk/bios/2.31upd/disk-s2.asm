; DOS22-NEW.ASM
;
; DOS 2.31 kernel bank 2 with FAT16 support (patches based on FAT16 v0.12 by OKEI)
;
; Source re-created by Z80DIS 2.2
; Z80DIS was written by Kenneth Gielow, Palo Alto, CA
;
; Code Copyrighted by ASCII,OKEI and maybe others
; Source comments and updates by Arjen Zeilemaker
;
; Sourcecode supplied for STUDY ONLY
; Recreation NOT permitted without authorisation of the copyrightholders
;


        .Z80
        ASEG
        ORG	4000H


;
CHSNS	equ	0009CH
CHGET	equ	0009FH
CHPUT	equ	000A2H
LPTOUT	equ	000A5H
LPTSTT	equ	000A8H
KILBUF	equ	00156H

B.BDOS	equ	0F37DH

J$4022	EQU	04022H	; Start diskbasic

.NCOMP	equ	0FFH
.WRERR	equ	0FEH
.DISK	equ	0FDH
.NRDY	equ	0FCH
.VERFY	equ	0FBH
.DATA	equ	0FAH
.RNF	equ	0F9H
.WPROT	equ	0F8H
.UFORM	equ	0F7H
.NDOS	equ	0F6H
.WDISK	equ	0F5H
.WFILE	equ	0F4H
.SEEK	equ	0F3H
.IFAT	equ	0F2H
.NOUPB	equ	0F1H
.IFORM	equ	0F0H

.INTER	equ	0DFH
.NORAM	equ	0DEH
.IBDOS	equ	0DCH
.IDRV	equ	0DBH
.IFNM	equ	0DAH
.IPATH	equ	0D9H
.PLONG	equ	0D8H
.NOFIL	equ	0D7H
.NODIR	equ	0D6H
.DRFUL	equ	0D5H
.DKFUL	equ	0D4H
.DUPF	equ	0D3H
.DIRE	equ	0D2H
.FILRO	equ	0D1H
.DIRNE	equ	0D0H
.IATTR	equ	0CFH
.DOT	equ	0CEH
.SYSX	equ	0CDH
.DIRX	equ	0CCH
.FILEX	equ	0CBH
.FOPEN	equ	0CAH
.OV64K	equ	0C9H
.FILE	equ	0C8H
.EOF	equ	0C7H
.ACCV	equ	0C6H
.IPROC	equ	0C5H
.NHAND	equ	0C4H
.IHAND	equ	0C3H
.NOPEN	equ	0C2H
.IDEV	equ	0C1H
.IENV	equ	0C0H
.ELONG	equ	0BFH
.IDATE	equ	0BEH
.ITIME	equ	0BDH
.RAMDX	equ	0BCH
.NRAMD	equ	0BBH
.HDEAD	equ	0BAH
.EOL	equ	0B9H
.ISBFN	equ	0B8H
.IFCB	equ	0B7H

.STOP	equ	09FH
.CTRLC	equ	09EH
.ABORT	equ	09DH
.OUTERR equ	09CH
.INERR	equ	09BH

.OKCMD	equ	08CH
.IPARM	equ	08BH
.INP	equ	08AH
.NOPAR	equ	089H
.IOPT	equ	088H
.BADNO	equ	087H
.NOHELP	equ	086H
.BADVER	equ	085H


DB064	EQU	0B064H	; 2, start of BDOS data block chain
IB066	EQU	0B066H	; 3, cursor on string
IB069	EQU	0B069H	; 3, cursor off string
DB06C	EQU	0B06CH	; 100, screen output buffer
IB0D0	EQU	0B0D0H	; 256, buffered input linebuffer
IB1D0	EQU	0B1D0H	; 260, con input line buffer
IB2D4	EQU	0B2D4H	; 1024, record buffer for CP/M sequential read
IB6D4	EQU	0B6D4H	; 512, bootsector buffer
IB8D4	EQU	0B8D4H	; 32, temporary directoryentry save (used to move directory entry)
IB8F4	EQU	0B8F4H	; 13, ASCIIZ filename of FCB (used by C3A59)
IB901	EQU	0B901H	; 14, pathitem buffer (B901=1, B902=pathitem asciiz)
                        ; 1, UNUSED
IB910	EQU	0B910H	; 11, filename buffer for
IB91B	EQU	0B91BH	; 11,
IB926	EQU	0B926H	; 11, filename buffer
IB931	EQU	0B931H	; 67,
                        ; 1, UNUSED
IB975	EQU	0B975H	; 37, temporary FCB, or other temporary store for FCB functions
IB99A	EQU	0B99AH	; 64, saved FIB for search next
IB9DA	EQU	0B9DAH	; 64, FIB
IBA1A	EQU	0BA1AH	; 9, drive assign table
IBA23	EQU	0BA23H	; 18, drivetable pointer table
IBA35	EQU	0BA35H	; 64, pointers for memorymapper segments (2 pointers per slot, 1 for info table and 1 for allocation table)
IBA75	EQU	0BA75H	; 256, upcase table
                        ; 1, UNUSED
DBB76	EQU	0BB76H	; 1, screen output buffer in double byte char flag
DBB77	EQU	0BB77H	; 1, screen output buffer position (0-99)
DBB78	EQU	0BB78H	; 2, pointer in line input buffer console input (used in ASCII mode)
DBB7A	EQU	0BB7AH	; 1, buffered line input redirection support flag
DBB7B	EQU	0BB7BH	; 1, buffered line input insert mode
DBB7C	EQU	0BB7CH	; 1,
DBB7D	EQU	0BB7DH	; 2,
DBB7F	EQU	0BB7FH	; 1,
DBB80	EQU	0BB80H	; 2,
DBB82	EQU	0BB82H	; 2,
DBB84	EQU	0BB84H	; 2,
DBB86	EQU	0BB86H	; 1,
DBB87	EQU	0BB87H	; 2,
DBB89	EQU	0BB89H	; 1, console redirection status, b0 console input, b1 console output
DBB8A	EQU	0BB8AH	; 1, console output also to list output flag
DBB8B	EQU	0BB8BH	; 2,
DBB8D	EQU	0BB8DH	; 1, saved keyboard input
DBB8E	EQU	0BB8EH	; 2, start cluster of file in sequential read buffer
DBB90	EQU	0BB90H	; 1, driveid in sequential read buffer (0FFH means invalid)
DBB91	EQU	0BB91H	; 1, number of random records in sequential read buffer
DBB92	EQU	0BB92H	; 3, start random record number in sequential read buffer
DBB95	EQU	0BB95H	; 1, saved requested extend _SFIRST (for _SNEXT)
DBB96	EQU	0BB96H	; 2, saved pointer to FCB
DBB98	EQU	0BB98H	; 1, APPEND used flag
DBB99	EQU	0BB99H	; 1, pathnamebuffer flag
DBB9A	EQU	0BB9AH	; 2, pathnamebuffer pointer
DBB9C	EQU	0BB9CH	; 2, pointer to last item of parse string
DBB9E	EQU	0BB9EH	; 2, current parse string pointer
DBBA0	EQU	0BBA0H  ; 1, parse flags
DBBA1	EQU	0BBA1H	; 1, parse string charflags
DBBA2	EQU	0BBA2H	; 1, number of FAT copies get sector (2B88,2B96)
DBBA3	EQU	0BBA3H	; 2, first allocated cluster
DBBA5	EQU	0BBA5H	; 2, fatentry content if fatentry spans two FAT sectors
DBBA7	EQU	0BBA7H	; 2, sectornumber fatentry spans two FAT sectors
DBBA9	EQU	0BBA9H	; 1, flag (b1 = 1 fat entry spans two FAT sectors, b0 = 1 actually read)
DBBAA	EQU	0BBAAH	; 1, clear allocated clusters flag
DBBAB	EQU	0BBABH	; 2, start cluster of directoryentry to move
DBBAD	EQU	0BBADH	; 2,
                        ; 1, UNUSED
DBBAF	EQU	0BBAFH	; 1, flag
                        ; 2, UNUSED
DBBB2	EQU	0BBB2H	; 2, ? for sectoroperations
DBBB4	EQU	0BBB4H	; 2, sectornumber for sectoroperations
DBBB6	EQU	0BBB6H	; 2, clusternumber
DBBB8	EQU	0BBB8H	; 1,
DBBB9	EQU	0BBB9H	; 2,
DBBBB	EQU	0BBBBH	; 1,
DBBBC	EQU	0BBBCH	; 2,
DBBBE	EQU	0BBBEH	; 2,
DBBC0	EQU	0BBC0H	; 2,
DBBC2	EQU	0BBC2H	; 2, transferadres for sectoroperations
DBBC4	EQU	0BBC4H	; 1, diskoperation flags
IBBC5	EQU	0BBC5H	; 1, temporary store for single byte read/write operation on filehandles
IBBC6	EQU	0BBC6H	; 12, registered directoryentry (move directory entry)
IBBD2	EQU	0BBD2H	; 12, registered directoryentry
DBBDE	EQU	0BBDEH	; 1, number of directoryentries in partly directory sector (0 if no partly directory sector)
DBBDF	EQU	0BBDFH	; 1, number of directoryentries in current directory sector
DBBE0	EQU	0BBE0H	; 1, directoryentries left in current directory sector
DBBE1	EQU	0BBE1H	; 1, sectors left in current directory sector
DBBE2	EQU	0BBE2H	; 2, current directory sector
DBBE4	EQU	0BBE4H	; 2, next directory cluster (used by directoryentry routines)
DBBE6	EQU	0BBE6H	; 2, current directory cluster (used by directoryentry routines)
DBBE8	EQU	0BBE8H	; 2, start cluster of the directory to operate on
DBBEA	EQU	0BBEAH	; 1, diskoperation flag
DBBEB	EQU	0BBEBH	; 1, saved driveid (31AB)
                        ; 1, UNUSED
DBBED	EQU	0BBEDH	; 1, use current (BDOS) segments for environments
DBBEE	EQU	0BBEEH	; 2, start of environment chain
DBBF0	EQU	0BBF0H	; 2, start of the filehandle per proces chain
DBBF2	EQU	0BBF2H	; 2, start of the FIB chain
DBBF4	EQU	0BBF4H	; 2, start of device chain
DBBF6	EQU	0BBF6H	; 2, pointer to last FAT buffer read
DBBF8	EQU	0BBF8H	; 2, start of the buffer chain
IBBFA	EQU	0BBFAH	; 1, number of buffers
DBBFB	EQU	0BBFBH	; 2, pointer to drivetable of ramdisk
DBBFD	EQU	0BBFDH	; 1, errorstatus last BDOS call (used for _ERROR)
DBBFE	EQU	0BBFEH	; 1, current procesnumber
                        ; 1, UNUSED
IBC00	EQU	0BC00H	; 512, ramdisk bootsector
DBE00	EQU	0BE00H	; 1, number of ramdisk segments
                        ; 1, UNUSED
IBE02	EQU	0BE02H	; 510, ramdisk segmenttable

JC206	EQU	0C206H	; ?? debug adres ??

CF1D6	EQU	0F1D6H	; transfer with page 0
CF1D9	EQU	0F1D9H	; call main-bios
CF1DC	EQU	0F1DCH	; print string via chput
CF1DF	EQU	0F1DFH	; interslot call with prompt handler
JF1E5	EQU	0F1E5H	; interrupt handler
JF1E8	EQU	0F1E8H	; RDSLT
JF1EB	EQU	0F1EBH	; WRSLT
JF1EE	EQU	0F1EEH	; CALSLT
JF1F1	EQU	0F1F1H	; ENASLT
JF1F4	EQU	0F1F4H	; CALLF
IF1F7	EQU	0F1F7H	; enable BDOS segments
JF1FA	EQU	0F1FAH	; enable DOS segements
CF206	EQU	0F206H	; RD_SEG
CF209	EQU	0F209H	; WR_SEG
CF224	EQU	0F224H	; PUT_P2
DF23C	EQU	0F23CH	; default drive
DF23D	EQU	0F23DH	; transfer adres

; DOS Hooks

CF252	EQU	0F252H	; BDOS handler
CF255	EQU	0F255H	; Upcase routine
CF258	EQU	0F258H	; check if double byte char
CF25B	EQU	0F25BH	; low level keyboard input
CF25E	EQU	0F25EH	; low level screen output
CF261	EQU	0F261H	; low level check keyboard
CF264	EQU	0F264H	; low level screenbuffer
CF267	EQU	0F267H	; low level printer output
CF26A	EQU	0F26AH	; low level check printer

DF2BA	EQU	0F2BAH	; random number, changed by interrupt
DF2BD	EQU	0F2BDH	; no keyboard buffer check counter, also reset by interrupt
DF2BE	EQU	0F2BEH	; down counter (to 1), every 100 ms
IF2BF	EQU	0F2BFH	; up counter (to 7), every 100 ms
IF2C7	EQU	0F2C7H	; current page 0 segment
IF2CB	EQU	0F2CBH	; saved DOS page 0 segment
DF2CD	EQU	0F2CDH	; saved DOS page 2 segment
DF2CF	EQU	0F2CFH	; BDOS datasegement
DF2DA	EQU	0F2DAH	; address message generator
DF2EC	EQU	0F2ECH	; disk check level
DF300	EQU	0F300H	; pointer to diskerror handler
DF302	EQU	0F302H	; pointer to abort handler
DF30D	EQU	0F30DH	; verify flag diskdriver
IF30F	EQU	0F30FH	; double byte header table
DF33F	EQU	0F33FH	; driveid for prompt routine
DF344	EQU	0F344H	; slotid RAM page 3 (= system mapper)
DF347	EQU	0F347H	; number of logical drives
DF348	EQU	0F348H	; slotid of disksystem rom
DF34D	EQU	0F34DH	; pointer to diskdriver sectorbuffer
IF353	EQU	0F353H	; pointer to ramdisk DPB
IF355	EQU	0F355H	; DPB pointer table (A: - G:)
IF371	EQU	0F371H	; AUX input jump
IF374	EQU	0F374H	; AUX output jump

LINLEN	EQU	0F3B0H	; current screenwidth
CRTCNT	EQU	0F3B1H	; current screenheight
CNSDFG	EQU	0F3DEH	; functionkey display on/off
KBUF	EQU	0F41FH	; keyboard buffer, used for temporary stack
DRVTBL	EQU	0FB21H	; table with disksystem roms
INTFLG	EQU	0FC9BH	; used to detect CTRL-STOP
ESCCNT	EQU	0FCA7H	; used to detect a ESC sequence
EXPTBL	EQU	0FCC1H	; slot expansion table
DFFFF	EQU	0FFFFH
;

; FCB structure (size=37)

; +0	DR	drive			drive
; +1,8	F1-F8	filename		filename
; +9,3	T1-T3	filetype		filetype
; +12	EX	extent			extent
; +13	S1	reserved		fileattribute
; +14	S2	reserved		extent high byte / recordsize low byte (block)
; +15	RC	record count in extent	record count in extent / recordsize high byte (block)
; +16,4	AL	allocation		Filesize
; +20,4	AL	allocation		volume-id
; +24,2	AL	allocation		start cluster of parent directory
; +26,2	AL	allocation		start cluster
; +28,2	AL	allocation		current cluster
; +30,2	AL	allocation		current relative cluster (b15-b12 are used as flags)
; +32	CR	record in extent	record in extent
; +33,3	R0-R2	random access record	random access record
; +36	R4	not used		random access record when recordsize <64, otherwise not used


; FIB structure (size=50)

; +0		fibindicator (0FFH)
; +1,13		Filename as an ASCIIZ string
; +14		File attributes byte
; +15,2		Time of last modification
; +17,2		Date of last modification
; +19,2		Start cluster
; +21,4		File size
; +25		Logical drive
; +26,4		diskserial (if on disk)
; +26,2		pointer to device entry (if device)
; +28,2		pointer to device jumptable (if device)
; +30		deviceflags (b7=device, b6=eof, b5=ascii, b1=con input,b0=con output)
; +31		UNUSED
; +32,2		pointer to drivetable
; +34,2		current directorysector of directoryentry
; +36		directoryentry number in sector
; +37,2		cluster of parent directory
; +39,2		start cluster
; +41,2		current cluster
; +43,2		current relative cluster
; +45,4		current filepos
; +49		open mode (b7 = file changed, b3 = file deleted, b2 = inheritable, b1 = no read, b0 = no write)


; drivetable structure (size=96)

; +0		Slotid of the drive's basic diskroutines ROM
; +1		Offset (relative to #4000) of jumptable of basic diskroutines
; +2,2		Pointer to Drive Parameter Block (DPB) of drive
; +4
; +5
; +6		Driveid used internaly with basic diskroutines
; +7
; +8		Drivename
; +9		1/10 seconds+2 that disk cannot be changed (0 = init, 1 = error)
; +10		Cluster mask
; +11		Cluster shift
; +12,2		Number of reserved sectors (bootarea)
; +14		Number of FAT's
; +15		Remainder of directoryentries (no whole sector)
; +16		Number of directorysectors (whole sectors)
; +17		Number of sectors per FAT
; +18,2		First sector of rootdirectory
; +20,2		First sector of data area
; +22,2		Number of clusters+1 on disk
; +24		Bit 0 = 1, when on a DOS2 disk file(s) have been deleted
; +25,4		Volume serialnumber (#FFFFFFFF if none)
; +29		Media descriptor of disk
; +30,2		Starting cluster of current directory (bit 15 = 1 means root)
; +32,64	Current directory (ASCIIZ) without "drive:\" prefix



; deviceentry (size=41)
;
; +0,2		jumptable pointer
; +2...
; +8		deviceflags
;
; The following is exactly a directoryentry
;
; +9,8		devicename (main)
; +17,3		devicename (extension)
; +20		entryattribute (always 080H)
; +21,10	Not used
; +31,2		Time (no time)
; +33,2		Date (no date)
; +35,2		Start cluster (no start cluster)
; +37,4		Filesize (filesize 0)


; directoryentry (size=32)
;
; +0,8		Filename (main)
; +8,3		Filename (extension)
; +11		Entryattribute
; +12,10	Not used
; +22,2		Time
; +24,2		Date
; +26,2		Start cluster
; +28,4		Filesize


; memorymapper infotable (size=8)
;
; +0		slotid
; +1		number of segments
; +2		number of free segments
; +3		number of allocated system segments
; +4		number of allocated user segments
; +5,3		not used


; memorymapper allocationtable (size=number of segments)
;
; allocation flag per segment
;		000H		segment is free
;		0FFH		system segment
;		001H-0FEH	user segment (also indicates procesnumber)



        INCLUDE	DISK.INC


        DEFB	"AB"
        DEFW	L403C			; Init routine (only switches back to bank 0)
        DEFW	0
        DEFW	0
        DEFW	0
        DEFW	0
        DEFW	0
        DEFW	0

        DEFS	0403CH-$,0

;	  Subroutine initialize routine DOS2
;	     Inputs  -
;	     Outputs -
;	     Remark  initialize routine is in segment 0, this is provided in case segment 2 is still active

L403C:	XOR	A
        CALL	L40A3			; pass control to segment 0
        RET				; should never execute here
        RET
        RET

;	  Subroutine EXTBIO handler DOS2
;	     Inputs  -
;	     Outputs -
;	     Remark  should not occure in this segment

L4043:	RET
        RET
        RET
        RET
        RET
        RET

;	  Subroutine HTIMI handler DOS2
;	     Inputs  -
;	     Outputs -
;	     Remark  should not occure in this segment, but is handled to avoid crash

L4049:	PUSH	AF
        LD	A,(L40FF)
        PUSH	AF			; save current segmentnumber
        XOR	A
        CALL	L40A3			; pass control to segment 0
        NOP				; should never execute here
        NOP
        NOP
        POP	AF
        CALL	L40A3
        POP	AF			; here control is given back
        RET

;	  Subroutine invoke routine in other DOS2 rom segment
;	     Inputs  A = segmentnumber, IX = routine
;	     Outputs -
;	     Remark  only the call routine part is executed


L405B:	CALL	L40A3			; select segment
        EX	AF,AF'
        CALL	L4069			; call routine
        EX	AF,AF'
        XOR	A
        CALL	L40A3			; restore segment 0
        EX	AF,AF'
        RET

L4069:	JP	(IX)

        DEFS	040A6H-$-3,0

; This one must start at #40A3, because there must be a RET
; instruction at end for switching to DOS1 kernel.
; At #40A6 is at RET instruction in DOS1 kernel

L40A3:
        BNKCHG

L40A6:	RET


        DEFS	040FFH-$,0

L40FF:	DEFB	2			; present bank number register


        .PHASE	0

C0000:	JP	J0095			; init BDOS

        DEFS	00005H-$,0

C0005:	JP	J026D			; BDOS handler

        DEFS	0000CH-$,0

C000C:	JP	JF1E8			; RDSLT

        DEFS	00014H-$,0

C0014:	JP	JF1EB			; WRSLT

        DEFS	0001CH-$,0

C001C:	JP	JF1EE			; CALSLT

        DEFS	00024H-$,0

C0024:	JP	JF1F1			; ENASLT

        DEFS	00028H-$,0

C0028:	JP	JC206			; ?? debug ??

        DEFS	00030H-$,0

C0030:	JP	JF1F4			; CALLF

        DEFS	00038H-$,0

C0038:	JP	JF1E5			; KEYINT


?003B:	OUT	(0A8H),A
        LD	A,(DFFFF)
        CPL
        LD	L,A
        AND	H
        OR	D
        JR	J004E

?0046:	OUT	(0A8H),A
        LD	A,L
        JR	J004E

?004B:	OUT	(0A8H),A
        LD	A,E
J004E:	LD	(DFFFF),A
        LD	A,B
        OUT	(0A8H),A
        RET

        DEFS	0005CH-$,0

        JP	C11A6			; allocate segment
?005F:	JP	C1256			; free segment

        DEFS	00080H-$,0

?0080:	JP	C0A2D			; keyboard input (low level)
?0083:	JP	J0A6B			; screen output (low level)
?0086:	JP	C0A42			; check if keyboard input ready (low level)
?0089:	JP	C0B25			; printer output (low level)
?008C:	JP	C0B37			; check printer output ready (low level)
?008F:	JP	J0B50			; aux output (low level)
?0092:	JP	C0B46			; aux input (low level)

;	  Subroutine initialize BDOS
;	     Inputs  ________________________
;	     Outputs Cx set if failed, Cx reset if successfull

J0095:	LD	IY,DBB80
        LD	DE,IF353		; pointer to ramdisk DPB
        LD	A,(DF348)
        LD	C,A			; slotid of DOS systemrom
        LD	L,80H			; offset for ramdisk driver jumptable
        LD	B,1			; 1 drive
        CALL	C017E			; allocate and initialize drivetables of ramdisk
        SCF
        RET	NZ			; error, quit
        LD	HL,DRVTBL		; diskdriver table
        LD	DE,IF355		; pointer to drive 0 DPB
        LD	B,4			; max. 4 diskdrivers
J00B1:	LD	A,(HL)			; number of drives for this driver
        INC	HL
        LD	C,(HL)			; slotid
        INC	HL
        OR	A			; entry used ?
        PUSH	HL
        PUSH	BC
        LD	B,A
        LD	L,10H			; offset for disk driver jumptable
        CALL	NZ,C017E		; entry used, allocate and initialize drivetables
        POP	BC
        POP	HL
        SCF
        RET	NZ			; setup failed, quit with error
        DJNZ	J00B1
        LD	D,B
        CALL	A0E8B			; cancel assignments (to initialize assignmenttable)
        LD	HL,I012C		; DOS devicename table
J00CB:	LD	A,(HL)
        OR	A
        JR	Z,J0101			; end of table, quit
        INC	HL
        PUSH	HL
        LD	HL,43
        CALL	C01CB			; allocate BDOS data block
        POP	DE
        SCF
        RET	NZ			; out of memory, quit with error
        LD	BC,(DBBF4)
        LD	(DBBF4),HL		; update start of device chain
        LD	(HL),C
        INC	HL
        LD	(HL),B			; next device block is previous first block
        INC	HL
        EX	DE,HL
        LDI
        LDI				; adres jumptable
        EX	DE,HL
        LD	BC,6
        ADD	HL,BC
        EX	DE,HL
        LD	BC,12
        LDIR				; deviceflags and devicename
        LD	A,80H
        LD	(DE),A
        LD	B,20
        XOR	A
J00FB:	INC	DE
        LD	(DE),A
        DJNZ	J00FB
        JR	J00CB

J0101:	LD	B,5
        CALL	A0E44			; allocate 5 buffers
        LD	B,0
        CALL	A2070			; join 0
        CALL	C0E35			; clear ramdisk bootsector and ramdisk segmenttable
        CALL	C0384			; initialize buffered input history buffer
        LD	HL,I0178
        LD	DE,IB066
        LD	BC,6
        LDIR				; initialize cursor on/off strings
        LD	A,1
        LD	(DF2BD),A		; do check keyboardbuffer
        LD	(IY+DBB90-DBB80),0FFH	; invalidate sequential read buffer
        CALL	C10CA			; setup clockchip
        OR	A
        RET				; quit with no error

I012C:	defb	0FFH
        defw	A0932
        defb	0A3H			; device, ascii mode, console input device, console output device
        defb	"CON        "

        defb	0FFH
        defw	A09E2
        defb	0A0H			; device, ascii mode
        defb	"LST        "

        defb	0FFH
        defw	A09E2
        defb	0A0H			; device, ascii mode
        defb	"PRN        "

        defb	0FFH
        defw	A0A03
        defb	0A0H			; device, ascii mode
        defb	"NUL        "

        defb	0FFH
        defw	A09BF
        defb	0A0H			; device, ascii mode
        defb	"AUX        "

        defb	0


I0178:	defb	27,"y5"
        defb	27,"x5"

;	  Subroutine allocate and initialize drivetables
;	     Inputs  DE = pointer to DPB entry, L = driver jumptable offset, B = number of drives, C = slotid
;	     Outputs ________________________

C017E:	XOR	A
J017F:	EX	AF,AF'
        PUSH	HL
        LD	HL,96
J0184:	CALL	C01CB			; allocate BDOS data block (drivetable)
        JR	NZ,J01C9		; error, quit
        EX	DE,HL
        PUSH	DE
        POP	IX			; pointer to drivetable
        PUSH	BC
        LD	C,(HL)
        INC	HL
        LD	B,(HL)			; pointer to DPB
J0191:	INC	HL
        PUSH	HL
J0193:	LD	(IX+2),C
        LD	(IX+3),B		; save pointer to DPB
        LD	A,(BC)
        INC	A
        LD	(IX+8),A		; driveid for PROMPT routine (1 based)
        LD	L,A
        LD	H,0
        INC	BC
        LD	A,(BC)
        LD	(IX+29),A		; mediadescriptor
        LD	BC,DBBFB
        JR	Z,J01AE			; ramdisk, use special ramdisk drivetable entry
        LD	BC,IBA23		; use appropiate drivetable entry
J01AE:	ADD	HL,HL
        ADD	HL,BC
        LD	(HL),E
        INC	HL
        LD	(HL),D			; pointer to drivetable
        POP	DE
        POP	BC
        POP	HL
        LD	(IX+0),C		; slotid of driver rom
        LD	(IX+1),L		; diskdriver jumptable offset (relative to 04000H)
        EX	AF,AF'
        LD	(IX+6),A		; driver driveid
        INC	A
        LD	(IX+31),0FFH		; current directory is rootdirectory
        DJNZ	J017F			; next drive of driver
        XOR	A
        RET

J01C9:	POP	HL
        RET

;	  Subroutine allocate BDOS data block
;	     Inputs  HL=size
;	     Outputs ________________________

C01CB:	PUSH	DE
        PUSH	BC
        INC	HL
        RES	0,L
        LD	B,H
        LD	C,L
        LD	HL,(DB064)
J01D5:	LD	E,(HL)
        INC	HL
        LD	D,(HL)
        INC	HL
        LD	A,D
        OR	E
        JR	Z,J0203
        BIT	0,E
        JR	NZ,J01E8
        EX	DE,HL
        SBC	HL,BC
        JR	NC,J01ED
        ADD	HL,BC
        EX	DE,HL
J01E8:	RES	0,E
        ADD	HL,DE
        JR	J01D5

J01ED:	EX	DE,HL
        DEC	HL
        DEC	HL
        JR	Z,J0217
        DEC	DE
        DEC	DE
        LD	A,D
        OR	E
        JR	Z,J01FF
        LD	(HL),E
        INC	HL
        LD	(HL),D
        INC	HL
        ADD	HL,DE
        JR	J0217

J01FF:	INC	BC
        INC	BC
        JR	J0217

J0203:	LD	A,.NORAM
        INC	BC
        INC	BC
        LD	HL,(DB064)
        OR	A
        SBC	HL,BC
        JR	C,J0227
        JP	P,J0227
        LD	(DB064),HL
        DEC	BC
        DEC	BC
J0217:	LD	(HL),C
        SET	0,(HL)
        INC	HL
        LD	(HL),B
        INC	HL
        PUSH	HL
J021E:	LD	(HL),00H
        INC	HL
        DEC	BC
        LD	A,B
        OR	C
        JR	NZ,J021E
        POP	HL
J0227:	POP	BC
        POP	DE
        OR	A
        RET

;	  Subroutine free BDOS data block
;	     Inputs  HL=adres of block
;	     Outputs ________________________

C022B:	DEC	HL
        DEC	HL
        RES	0,(HL)
        PUSH	DE
        PUSH	BC
        LD	HL,(DB064)
J0234:	LD	C,(HL)
        BIT	0,C
        JR	NZ,J023F
        INC	HL
        LD	B,(HL)
        INC	HL
        ADD	HL,BC
        JR	J0234

J023F:	LD	(DB064),HL
J0242:	LD	E,(HL)
        INC	HL
        LD	D,(HL)
        INC	HL
        LD	A,D
        OR	E
        JR	Z,J026A
        BIT	0,E
        JR	NZ,J0265
J024E:	PUSH	HL
        ADD	HL,DE
        LD	C,(HL)
        INC	HL
        LD	B,(HL)
        POP	HL
        BIT	0,C
        JR	NZ,J025F
        INC	BC
        INC	BC
        EX	DE,HL
        ADD	HL,BC
        EX	DE,HL
        JR	J024E

J025F:	DEC	HL
J0260:	LD	(HL),D
        DEC	HL
        LD	(HL),E
        INC	HL
        INC	HL
J0265:	RES	0,E
        ADD	HL,DE
        JR	J0242

J026A:	POP	BC
        POP	DE
        RET

;	  Subroutine BDOS handler
;	     Inputs  ________________________
;	     Outputs ________________________

J026D:	EI
        CALL	CF252
        CALL	C0278
        LD	(DBBFD),A		; save error
        RET

;	  Subroutine __________________________
;	     Inputs  ________________________
;	     Outputs ________________________

C0278:	PUSH	HL
        PUSH	BC
        EX	AF,AF'

        IF	USESBF EQ 1

        LD	A,(DF2BE)
        DEC	A			; screenoutput timer finished ?
        CALL	Z,C0AB9			; yep, empty screenoutput buffer

        ENDIF

        LD	A,C
        CP	71H
        JR	C,J0289
        LD	C,09H
J0289:	EX	AF,AF'
        LD	B,0
        LD	HL,I02A2
        ADD	HL,BC
        ADD	HL,BC
        LD	C,(HL)
        INC	HL
        LD	H,(HL)
        LD	L,C
        LD	IY,DBB80
        POP	BC
        EX	(SP),HL
        RET

;	  Subroutine illegal BDOS function
;	     Inputs  ________________________
;	     Outputs ________________________

A029C:	LD	A,.IBDOS
J029E:	LD	HL,0
        RET

I02A2:	defw	A0CFB,A03A8,A03B6,A042E,A043D,A0441,A03D4,A03FE
        defw	A03BE,A029C,A0456,A03CD,A0B90,A0B95,A0BAB,A3771
        defw	A37B5,A37CF,A37E9,A38E6,A384C,A3893,A38CE,A3913
        defw	A0BC6,A0BDC,A0BE4,A0BEC,A029C,A029C,A029C,A029C
        defw	A029C,A3953,A3967,A3981,A39BA,A029C,A3D3F,A3D3B
        defw	A3969,A029C,A1024,A1059,A10A3,A10AD,A0C48,A2576
        defw	A2579,A0C50,A029C,A029C,A029C,A029C,A029C,A029C
        defw	A029C,A029C,A029C,A029C,A029C,A029C,A029C,A029C
        defw	A18C6,A1979,A18CA,A1DA6,A1D94,A1DEB,A1DF8,A1E08
        defw	A1E1D,A1E2D,A1E3D,A1E81,A200D,A1F14,A1F3B,A1F60
        defw	A1F85,A1FBE,A1F1E,A1F45,A1F6A,A1F9D,A1FE0,A0CCF
        defw	A0CD5,A1836,A184D,A186D,A1882,A1894,A189D,A0CE0
        defw	A2029,A2070,A0CFD,A029C,A029C,A0D05,A0D0A,A029C
        defw	A029C,A0E44,A0E8B,A0EDE,A0EFF,A0F55,A0EB6,A0EC8
        defw	A0ED2

C0384:	LD	HL,IB0D0
        LD	(DBB82),HL
        LD	(DBB80),HL
        LD	DE,IB0D0+256
        EX	DE,HL
        OR	A
        SBC	HL,DE
        EX	DE,HL
J0395:	LD	(HL),0DH
        INC	HL
        DEC	DE
        LD	A,D
        OR	E
        JR	NZ,J0395
        LD	(DBB7F),A

;	  Subroutine __________________________
;	     Inputs  ________________________
;	     Outputs ________________________

C03A0:	XOR	A
        LD	(DBB8D),A			; no saved keyboard input
J03A4:	LD	(DBB8A),A			; console output not duplicated to list output
        RET

;	  Subroutine _CONIN
;	     Inputs  ________________________
;	     Outputs ________________________

A03A8:	CALL	A03BE
        PUSH	HL
        LD	A,L
        CALL	C085A
        CALL	NC,C0871			; char to console (with redirection)
        POP	HL
        XOR	A
        RET

;	  Subroutine _CONOUT
;	     Inputs  ________________________
;	     Outputs ________________________

A03B6:	LD	A,E
        CALL	C086C
        XOR	A
        LD	H,A
        LD	L,A
        RET

;	  Subroutine _INNOE
;	     Inputs  ________________________
;	     Outputs ________________________

A03BE:	BIT	0,(IY+DBB89-DBB80)	; console input redirected ?
        LD	C,0FFH			; flag do check for CTRL-C
        JR	NZ,C0414		; yep, use the filehandle method for con input
J03C6:	CALL	C08B2			; keyboard input with special controlkeys handler
        LD	L,A
        XOR	A
        LD	H,A
        RET

;	  Subroutine _CONST
;	     Inputs  ________________________
;	     Outputs ________________________

A03CD:	CALL	C0897			; check keyboard status with special controlkeys handler
        LD	L,A			; status in L
        XOR	A
        LD	H,A
        RET

;	  Subroutine _DIRIO
;	     Inputs  ________________________
;	     Outputs ________________________

A03D4:	LD	A,E
J03D5:	INC	A			; do input or output ?
        JR	Z,J03E8			; input
        BIT	1,(IY+DBB89-DBB80)	; console output redirected ?
        LD	A,E
        LD	C,00H			; binary mode
        JR	NZ,J042A		; yep, use filehandle method for con output
        CALL	C0A6C			; char to screen (low level)
        XOR	A
        LD	H,A
        LD	L,A			; A = 0, HL = 0
        RET

J03E8:	BIT	0,(IY+DBB89-DBB80)	; console input redirected ?
        LD	C,0			; do not check for CTRL-C
        JR	NZ,C0414		; yep, use filehandle method for con input
        LD	HL,DBB8D
        CP	(HL)			; saved keyboard input ?
        JR	NZ,J0406		; get it
        CALL	C0A42			; check if keyboard input ready (low level)
        JR	NZ,J0406		; ready,
        LD	L,A
        LD	H,A			; A = 0, HL = 0
        RET

;	  Subroutine _DIRIN
;	     Inputs  ________________________
;	     Outputs ________________________

A03FE:	BIT	0,(IY+DBB89-DBB80)	; console input redirected ?
        LD	C,0			; do not check for CTRL-C
        JR	NZ,C0414		; yep, use the filehandle method for con input
J0406:	LD	A,(DBB8D)
        OR	A
        CALL	Z,C0A2D			; no saved keyboard input, keyboard input (low level)
        LD	L,A
        XOR	A			; no error
        LD	H,A
        LD	(DBB8D),A		; no saved keyboard input
        RET

;	  Subroutine con input (filehandle method)
;	     Inputs  C = 0 binary mode, C = FF ASCII mode
;	     Outputs ________________________

C0414:	LD	B,0			; filehandle con input
        PUSH	BC
        CALL	C1D51			; read from filehandle
        POP	DE
        OR	A
        JR	NZ,J0439		; error, handle "input error"
        OR	E			; check for CTRL-C ?
        JR	Z,J0426			; no, skip CTRL-C check

;	  Subroutine __________________________
;	     Inputs  ________________________
;	     Outputs ________________________

C0421:	LD	A,B
        SUB	03H
        JR	Z,J0439			; CTRL-C, handle "input error"
J0426:	LD	L,B
        XOR	A
        LD	H,A
        RET

;	  Subroutine con output (filehandle method)
;	     Inputs  C = 0 for binary mode, C = FF for ASCII mode
;	     Outputs ________________________

J042A:	LD	B,1			; filehandle con output
        JR	J0446

;	  Subroutine _AUXIN
;	     Inputs  ________________________
;	     Outputs ________________________

A042E:	LD	B,3			; filehandle aux
        LD	C,0FFH			; ASCII mode
        CALL	C1D51			; read from filehandle
        OR	A
        LD	L,B
        LD	H,A
        RET	Z			; no error, quit
J0439:	LD	C,.INERR
        JR	J044F

;	  Subroutine _AUXOUT
;	     Inputs  ________________________
;	     Outputs ________________________

A043D:	LD	B,3			; filehandle aux
        JR	J0443

;	  Subroutine _LSTOUT
;	     Inputs  ________________________
;	     Outputs ________________________

A0441:	LD	B,4			; filehandle lst
J0443:	LD	C,0FFH
        LD	A,E
J0446:	CALL	C1D2C			; write to filehandle
        OR	A
        LD	L,A
        LD	H,A
        RET	Z			; no error, quit
        LD	C,.OUTERR		; handle "output error"
J044F:	LD	B,A
        LD	A,C
        CALL	C3749			; call program abort routine with DOS segments active
J0454:	JR	J0454			; loop to infinety

;	  Subroutine _BUFIN
;	     Inputs  ________________________
;	     Outputs ________________________

A0456:	PUSH	DE
        BIT	0,(IY+DBB89-DBB80)	; console input redirected ?
        JR	NZ,J0463		; yes,
        XOR	A			; console output redirection supported
        CALL	C04B1			; buffered line input
        JR	J049E

J0463:	EX	DE,HL
        LD	B,(HL)
        LD	C,00H
        INC	HL
        PUSH	HL
J0469:	PUSH	HL
        PUSH	BC
        LD	C,0FFH			; do check for CTRL-C
        CALL	C0414			; use filehandle method
        LD	A,L
        POP	BC
        POP	HL
        OR	A
        JR	Z,J0469
        CP	0AH	; 10
        JR	Z,J0469
        CP	0DH	; 13
        JR	Z,J0499
        LD	E,A
        LD	A,B
        CP	C
        JR	Z,J048E
        INC	C
        INC	HL
        LD	(HL),E
        LD	A,E
        PUSH	HL
        PUSH	BC
        CALL	C086C
        JR	J0495

J048E:	PUSH	HL
        PUSH	BC
        LD	A,07H
        CALL	C0A6C			; beep
J0495:	POP	BC
        POP	HL
        JR	J0469

J0499:	POP	HL
        LD	(HL),C
        CALL	C086C
J049E:	POP	HL
        PUSH	HL
        LD	A,(HL)
        INC	HL
        CP	(HL)
        JR	Z,J04AC
        LD	E,(HL)
        LD	D,00H
        ADD	HL,DE
        INC	HL
        LD	(HL),0DH	; 13
J04AC:	POP	DE
        XOR	A
        LD	L,A
        LD	H,A
        RET

;	  Subroutine buffered line input
;	     Inputs  A = redirection support flag, DE = pointer to buffer
;	     Outputs ________________________

C04B1:	LD	(DBB7A),A		; save redirection support
        INC	DE
        XOR	A
        LD	(DE),A			; current length of line = 0
        DEC	DE
        LD	(DBB7C),A
J04BB:	PUSH	DE
        CALL	C058B
        POP	DE
        DEC	A
        JR	Z,J050C
        DEC	A
        JR	Z,J052A
        INC	DE
        LD	A,(DE)
        OR	A
        RET	Z
        LD	B,A
        LD	(DBB7F),A
        LD	A,(DBB7C)
        OR	A
        JR	Z,J04EA
        PUSH	DE
        PUSH	BC
        LD	HL,(DBB82)
J04D9:	INC	DE
        LD	A,(DE)
        CP	(HL)
        JR	NZ,J04E6
        CALL	C0567			; next position in buffered input linebuffer
        DJNZ	J04D9
        LD	A,(HL)
        CP	0DH
J04E6:	POP	BC
        POP	DE
        JR	Z,J04FE
J04EA:	LD	HL,(DBB80)
J04ED:	INC	DE
        LD	A,(DE)
        LD	(HL),A
        CALL	C0567			; next position in buffered input linebuffer
        DJNZ	J04ED
        LD	A,(HL)
        LD	(HL),0DH
        CALL	C0567			; next position in buffered input linebuffer
        LD	(DBB80),HL
J04FE:	LD	(DBB82),HL
J0501:	CP	0DH
        RET	Z
        LD	A,(HL)
        LD	(HL),0DH
        CALL	C0567			; next position in buffered input linebuffer
        JR	J0501

J050C:	LD	A,(DBB7F)
        OR	A
        JR	Z,J04BB
        LD	HL,(DBB82)
J0515:	CALL	C0579			; previous position in buffered input linebuffer
        LD	A,(HL)
        CP	0DH
        JR	Z,J0515
J051D:	CALL	C0579			; previous position in buffered input linebuffer
        LD	A,(HL)

;	  Subroutine __________________________
;	     Inputs  ________________________
;	     Outputs ________________________

C0521:	CP	0DH
        JR	NZ,J051D
        CALL	C0567			; next position in buffered input linebuffer
        JR	J0544

J052A:	LD	A,(DBB7F)
        OR	A
        JR	Z,J04BB
        LD	HL,(DBB82)
J0533:	LD	A,(HL)
        CP	0DH
        CALL	C0567			; next position in buffered input linebuffer
        JR	NZ,J0533
        SCF
J053C:	CALL	NC,C0567		; next position in buffered input linebuffer
        LD	A,(HL)
        CP	0DH
        JR	Z,J053C
J0544:	LD	(DBB82),HL
        PUSH	DE
        LD	A,(DE)
        LD	B,A
        INC	DE
        INC	DE
        LD	C,0FFH
J054E:	LD	A,(HL)
        LD	(DE),A
        INC	C
        CALL	C0567			; next position in buffered input linebuffer
        CP	0DH
        INC	DE
        JR	Z,J055C
        DJNZ	J054E
        INC	C
J055C:	POP	DE
        INC	DE
        LD	A,C
        LD	(DE),A
        DEC	DE
        LD	(DBB7C),A
        JP	J04BB

;	  Subroutine next position in buffered input linebuffer
;	     Inputs  ________________________
;	     Outputs ________________________

C0567:	PUSH	AF
        PUSH	DE
        LD	DE,IB0D0+255
        OR	A
        SBC	HL,DE
        ADD	HL,DE
        INC	HL
        JR	NZ,J0576
        LD	HL,IB0D0
J0576:	POP	DE
        POP	AF
        RET

;	  Subroutine previous position in buffered input linebuffer
;	     Inputs  ________________________
;	     Outputs ________________________

C0579:	PUSH	AF
        PUSH	DE
        LD	DE,IB0D0
        OR	A
        SBC	HL,DE
        ADD	HL,DE
        DEC	HL
        JR	NZ,J0588
        LD	HL,IB0D0+255
J0588:	POP	DE
        POP	AF
        RET

;	  Subroutine __________________________
;	     Inputs  ________________________
;	     Outputs ________________________

C058B:	LD	HL,(DBB8B)
        LD	(DBB87),HL
        LD	(DBB7D),HL
        EX	DE,HL
J0595:	LD	C,(HL)
        INC	HL
        LD	(DBB84),HL
        LD	A,(HL)
        OR	A
        LD	B,A
        JR	Z,J05A5
        INC	HL
        CALL	C0811
        DEC	HL
        LD	A,B
J05A5:	LD	(DBB86),A
        XOR	A
        CALL	C06BC			; overwrite mode
I05AC:	LD	DE,I05AC
        PUSH	DE
        PUSH	HL
        LD	HL,DBB86
        LD	A,(HL)
        CP	B
        JR	NC,J05B9
        LD	(HL),B
J05B9:	POP	HL
        CALL	C08B2			; keyboard input with special controlkeys handler
        OR	A
        RET	Z
        CP	0AH
        RET	Z
        CP	0DH
        JP	Z,J07A8			; RET,
        CP	1DH
        JP	Z,J06F9
        CP	1CH
        JP	Z,J06DB
        CP	7FH
        JP	Z,J0748			; DEL,
        CP	08H
        JP	Z,J0741			; BS,
        CP	12H
        JP	Z,J06B8			; INS, toggle insert mode and change cursor style
        CP	1BH
        JR	Z,J05EA			; ESC,
        CP	18H
        JR	Z,J05EA			; SEL,
        CP	15H
J05EA:	JP	Z,J07A1
        CP	1EH
        JP	Z,J07BF
        CP	1FH
        JP	Z,J07C6
        CP	0BH
        JP	Z,J06F2
        LD	E,A
        LD	A,(DBB7B)
        OR	A			; overwrite mode ?
        JP	NZ,J0653		; nope, insert mode
        LD	A,(DBB86)
        CP	B
        JR	Z,J063F
        INC	HL
        LD	A,E
        CALL	C17E0			; check for double byte header char if enabled
        JR	NC,J062E
        LD	A,(DBB86)
        DEC	A
        CP	B
        JR	NZ,J0623
        INC	A
        CP	C
        DEC	HL
        JP	NC,J06AB
        INC	HL
        INC	A
        LD	(DBB86),A
J0623:	LD	A,(HL)
        CALL	C17E0			; check for double byte header char if enabled
        INC	HL
        CALL	NC,C07CD
        DEC	HL
        JR	J0678

J062E:	CALL	C07CD
        JR	C,J06A3
        LD	A,(HL)
        CP	20H	; " "
        JR	C,J06A3
        LD	A,E
        CP	20H	; " "
        JR	C,J06A3
        JR	J0649

J063F:	CP	C
        JR	NC,J06AE
        LD	A,E
        CALL	C17E0			; check for double byte header char if enabled
        JR	C,J0659
        INC	HL
J0649:	LD	(HL),E
        LD	A,E
        INC	B
        CALL	C0836
        JP	C0821

J0653:	LD	A,E
        CALL	C17E0			; check for double byte header char if enabled
        JR	NC,J0687
J0659:	LD	A,(DBB86)
        INC	A
        CP	C
        JR	NC,J06AB
        INC	A
        LD	(DBB86),A
        DEC	A
        DEC	A
        SUB	B
        JR	Z,J0677
        PUSH	DE
        PUSH	BC
        LD	C,A
        LD	B,00H
        ADD	HL,BC
        LD	D,H
        LD	E,L
        INC	DE
        INC	DE
        LDDR
        POP	BC
        POP	DE
J0677:	INC	HL
J0678:	LD	(HL),E
        INC	HL
        CALL	C08B2			; keyboard input with special controlkeys handler
        LD	(HL),A
        DEC	HL
        CALL	C07DC
        INC	B
        INC	B
        JP	C06FD

J0687:	LD	A,(DBB86)
        CP	C
        JR	NC,J06AE
        INC	A
        LD	(DBB86),A
        DEC	A
        SUB	B
        JR	Z,J06A2
        PUSH	DE
        PUSH	BC
        LD	C,A
        LD	B,00H
        ADD	HL,BC
        LD	D,H
        LD	E,L
        INC	DE
        LDDR
        POP	BC
        POP	DE
J06A2:	INC	HL
J06A3:	LD	(HL),E
        CALL	C07DC
        INC	B
        JP	C06FD

J06AB:	CALL	C08B2			; keyboard input with special controlkeys handler
J06AE:	LD	A,07H
        PUSH	BC
        PUSH	HL
        CALL	C0A6C			; beep
        POP	HL
        POP	BC
        RET

;	  Subroutine toggle insert mode and change cursor style
;	     Inputs  -
;	     Outputs ________________________

J06B8:	LD	A,(DBB7B)
        CPL

;	  Subroutine set insert mode and cursor style
;	     Inputs  A = 0 overwrite mode, block cursor, A =  FF insert mode, insert cursor
;	     Outputs ________________________

C06BC:	LD	(DBB7B),A
        OR	A
        LD	A,"y"
        JR	NZ,J06C5
        DEC	A			; "x"
J06C5:	PUSH	BC
        PUSH	HL
        PUSH	DE
        PUSH	AF
        LD	A,1BH
        CALL	C0A6C
        POP	AF
        CALL	C0A6C
        LD	A,"4"
        CALL	C0A6C			; chars to screen low level
        POP	DE
        POP	HL
        POP	BC
        RET

J06DB:	LD	A,(DBB86)
        CP	B
        RET	Z
        INC	HL
        INC	B
        LD	A,(HL)
        CALL	C17E0			; check for double byte header char if enabled
        JP	NC,C0836
        CALL	C0836
        INC	HL
        INC	B
        LD	A,(HL)
        JP	C0836

J06F2:	LD	A,B
        OR	A
        RET	Z
        LD	B,00H
        JR	C06FD

J06F9:	LD	A,B
        OR	A
        RET	Z
        DEC	B
;
;	  Subroutine __________________________
;	     Inputs  ________________________
;	     Outputs ________________________
;
C06FD:	LD	HL,(DBB84)
        LD	DE,(DBB87)
        PUSH	BC
        INC	B
        JR	J0729

J0708:	INC	HL
        LD	A,(HL)
        CALL	C17E0			; check for double byte header char if enabled
        JR	NC,J0719
        INC	HL
        DJNZ	J0727
        DEC	HL
        DEC	HL
        POP	BC
        DEC	B
        PUSH	BC
        JR	J072B

J0719:	CP	09H	; 9
        JR	NZ,J0723
        LD	A,E
        OR	07H	; 7
        LD	E,A
        JR	J0728

J0723:	CP	20H	; " "
        JR	NC,J0728
J0727:	INC	DE
J0728:	INC	DE
J0729:	DJNZ	J0708
J072B:	PUSH	HL
        LD	HL,(DBB8B)
        OR	A
        SBC	HL,DE
        JR	Z,J073E
J0734:	LD	A,08H	; 8
        CALL	C0836
        DEC	HL
        LD	A,H
        OR	L
        JR	NZ,J0734
J073E:	POP	HL
        POP	BC
        RET

J0741:	LD	A,B
        OR	A
        RET	Z
        DEC	B
        CALL	C06FD
J0748:	LD	A,(DBB86)
        CP	B
        RET	Z
        DEC	A
        LD	(DBB86),A
        SUB	B
        JR	Z,J0784
        LD	E,A
        INC	HL
        LD	A,(HL)
        DEC	HL
        CALL	C17E0			; check for double byte header char if enabled
        LD	A,E
        JR	NC,J0777
        PUSH	HL
        LD	HL,DBB86
        DEC	(HL)
        POP	HL
        DEC	A
        JR	Z,J0784
        PUSH	BC
        PUSH	HL
        LD	C,A
        LD	B,00H
        INC	HL
        LD	D,H
        LD	E,L
        INC	HL
        INC	HL
        LDIR
        POP	HL
        POP	BC
        JR	J0784

J0777:	PUSH	BC
        PUSH	HL
        LD	C,A
        LD	B,00H
        INC	HL
        LD	D,H
        LD	E,L
        INC	HL
        LDIR
        POP	HL
        POP	BC
J0784:	INC	HL
        CALL	C07DC
        DEC	HL
        JP	C06FD

;
;	  Subroutine __________________________
;	     Inputs  ________________________
;	     Outputs ________________________
;
C078C:	XOR	A
        CP	B
        LD	B,A
        CALL	NZ,C06FD
        CALL	C07D7
        LD	B,00H
        CALL	C06FD
        LD	HL,(DBB84)
        LD	(HL),00H
        DEC	HL
        RET

J07A1:	CALL	C078C
        POP	DE
        JP	J0595

J07A8:	INC	HL
        CALL	C07DC
        LD	HL,(DBB84)
        LD	A,(DBB86)
        LD	(HL),A
        XOR	A
        CALL	C06BC			; overwrite mode
        LD	A,0DH
        CALL	C0836
        POP	HL
        XOR	A
        RET

J07BF:	POP	HL
        CALL	C078C
        LD	A,01H	; 1
        RET

J07C6:	POP	HL
        CALL	C078C
        LD	A,02H	; 2
        RET

;
;	  Subroutine __________________________
;	     Inputs  ________________________
;	     Outputs ________________________
;
C07CD:	LD	A,(HL)
        CALL	C17E0			; check for double byte header char if enabled
        RET	NC
        INC	HL
        LD	(HL),20H	; " "
        DEC	HL
        RET

;	  Subroutine __________________________
;	     Inputs  ________________________
;	     Outputs ________________________
;
C07D7:	PUSH	BC
        PUSH	DE
        PUSH	HL
        JR	J07E7
;

;
;	  Subroutine __________________________
;	     Inputs  ________________________
;	     Outputs ________________________
C07DC:	PUSH	BC
        PUSH	DE
        PUSH	HL
        LD	A,(DBB86)
        SUB	B
        LD	B,A
        CALL	C0811
J07E7:	LD	DE,(DBB8B)
        LD	HL,(DBB7D)
        OR	A
        SBC	HL,DE
        JR	Z,J0803
        JR	C,J0803
J07F5:	LD	A,20H	; " "
        CALL	C0836
        DEC	HL
        LD	A,H
        OR	L
        JR	NZ,J07F5
        LD	(DBB7D),DE
J0803:	LD	A,1BH
        CALL	C0A6C
        LD	A,"K"
        CALL	C0A6C			; chars to screen (low level)
        POP	HL
        POP	DE
        POP	BC
        RET

;	  Subroutine __________________________
;	     Inputs  ________________________
;	     Outputs ________________________

C0811:	PUSH	BC
        INC	B
        JR	J081D

J0815:	LD	A,(HL)
        CALL	C0836
        CALL	C0821
        INC	HL
J081D:	DJNZ	J0815
        POP	BC
        RET

;
;	  Subroutine __________________________
;	     Inputs  ________________________
;	     Outputs ________________________
;
C0821:	PUSH	HL
        PUSH	BC
        LD	HL,(DBB7D)
        LD	BC,(DBB8B)
        OR	A
        SBC	HL,BC
        JR	NC,J0833
        LD	(DBB7D),BC
J0833:	POP	BC
        POP	HL
        RET
;

;
;	  Subroutine __________________________
;	     Inputs  ________________________
;	     Outputs ________________________
;
C0836:	PUSH	BC
        PUSH	DE
        PUSH	HL
        CALL	C085A
        JR	NC,J0847
        PUSH	AF
        LD	A,"^"
        CALL	C084E
        POP	AF
        ADD	A,40H
J0847:	CALL	C084E
        POP	HL
        POP	DE
        POP	BC
        RET

;	  Subroutine __________________________
;	     Inputs  ________________________
;	     Outputs ________________________

C084E:	LD	B,A
        LD	A,(DBB7A)		; buffered input with redirection support ?
        OR	A
        LD	A,B
        JP	Z,C0871			; yep, char to console (with redirection)
        JP	C08EE			; nope, char to screen (with list output)

;	  Subroutine __________________________
;	     Inputs  ________________________
;	     Outputs ________________________

C085A:	CP	0DH
        RET	Z
        CP	0AH
        RET	Z
        CP	09H
        RET	Z
        CP	08H
        RET	Z
        CP	7FH
        RET	Z
        CP	20H
        RET

;	  Subroutine __________________________
;	     Inputs  ________________________
;	     Outputs ________________________

C086C:	PUSH	AF
        CALL	C0897			; check keyboard status with special controlkeys handler
        POP	AF

;	  Subroutine char to console (with redirection)
;	     Inputs  ________________________
;	     Outputs ________________________

C0871:	CP	09H
        JR	NZ,C0882
J0875:	LD	A," "
        CALL	C0882
        LD	A,(DBB8B)
        AND	07H
        JR	NZ,J0875
        RET

;	  Subroutine __________________________
;	     Inputs  ________________________
;	     Outputs ________________________

C0882:	LD	HL,(DBB8B)
        CALL	C0915			; update pos
        LD	(DBB8B),HL
        BIT	1,(IY+DBB89-DBB80)	; console output redirected ?
        JP	Z,J0908			; no, char to screen (with list output)
        LD	C,0FFH			; ASCII mode
        JP	J042A			; filehandle methode con output

;	  Subroutine check keyboard status with special controlkeys handler
;	     Inputs  ________________________
;	     Outputs ________________________

C0897:	CALL	C0A42			; check if keyboard input ready (low level)
        LD	B,A
        LD	A,(DBB8D)
        OR	A			; saved keyboard input ?
        JR	NZ,J08AF		; yep, flag keyboard input ready
        LD	A,B
        OR	A
        RET	Z			; keyboard input not ready, quit
        CALL	C0A2D			; keyboard input (low level)
        CALL	C08C5			; handle special controlkeys
        OR	A
        RET	Z			; special controlkey, quit
        LD	(DBB8D),A		; save keyboard input for next status or get
J08AF:	XOR	A
        DEC	A
        RET

;	  Subroutine keyboard input with special controlkeys handler
;	     Inputs  ________________________
;	     Outputs ________________________

C08B2:	LD	A,(DBB8D)
        LD	(IY+DBB8D-DBB80),00H	; no saved keyboard input
        OR	A
        RET	NZ			; there was saved keyboard input, quit
J08BB:	CALL	C0A2D			; keyboard input (low level)
        CALL	C08C5			; handle special controlkeys
        OR	A
        JR	Z,J08BB			; special controlkey, get next
        RET

;	  Subroutine handle special controlkeys
;	     Inputs  ________________________
;	     Outputs ________________________

C08C5:	CP	10H
        JR	Z,J08E5			; CTRL-P, start list output
        CP	0EH
        JR	Z,J08E8			; CTRL-N, stop list output
        CP	03H
        JR	Z,J08DC			; CTRL-C, abort
        CP	13H
        RET	NZ			; not CTRL-S, quit
        CALL	C0A2D			; keyboard input (low level)
        CP	03H
        LD	A,00H
        RET	NZ			; not CTRL-C, quit
J08DC:	LD	A,.CTRLC
        LD	B,00H
        CALL	C3749			; call program abort routine with DOS segments active
J08E3:	JR	J08E3			; loop to infinety

J08E5:	LD	A,0FFH			; console output duplicated to list output
        DEFB	0FEH
J08E8:	XOR	A			; console output not duplicated to list output
        LD	(DBB8A),A
        XOR	A
        RET

;	  Subroutine char to screen (with list output)
;	     Inputs  ________________________
;	     Outputs ________________________

C08EE:	CP	09H
        JR	NZ,C08FF
J08F2:	LD	A,20H
        CALL	C08FF
        LD	A,(DBB8B)
        AND	07H
        JR	NZ,J08F2
        RET

;	  Subroutine __________________________
;	     Inputs  ________________________
;	     Outputs ________________________

C08FF:	LD	HL,(DBB8B)
        CALL	C0915			; update pos
        LD	(DBB8B),HL
J0908:	CALL	C0A6C			; char to screen (low level)
        LD	HL,DBB8A
        BIT	0,(HL)			; console output duplicated to list output ?
        RET	Z			; nope, quit
        LD	E,A
        JP	A0441			; _LSTOUT

;	  Subroutine update pos
;	     Inputs  HL = pos, A = char
;	     Outputs HL = updated pos

C0915:	INC	HL
        CP	7FH
        JR	Z,J091D			; DEL, not a normal char
        CP	20H
        RET	NC			; normal char, pos+1 and quit
J091D:	DEC	HL			; back to orginal pos
        LD	B,A
        LD	A,H
        OR	L			; at pos 0 ?
        LD	A,B
        RET	Z			; yep, ignore controlcodes for 'back'
        DEC	HL			; pos-1
        CP	08H
        RET	Z			; BS, quit
        CP	7FH
        RET	Z			; DEL, quit
        INC	HL			; back to orginal pos
        CP	0DH
        RET	NZ			; other controlcodes, leave pos alone
        LD	HL,0			; CR, pos 0
        RET

; con device jumptable

A0932:	JP	J0941			; input
        JP	J098E			; output
        JP	J09A1			; check if input ready
        JP	J0A1C			; check if output ready (always ready)
        JP	J09B1			; get screensize

J0941:	BIT	5,C
        JR	NZ,J094B		; ASCII mode, use buffered line method
        CALL	C0A2D			; binary mode, use keyboard input (low level)
        LD	B,A
        XOR	A
        RET

J094B:	LD	HL,(DBB78)		; pointer in line input buffer
        LD	A,(HL)
        OR	A			; chars left in buffer ?
        JR	NZ,J0979		; yep, return char
        LD	DE,IB1D0
        LD	A,0FFH
        LD	(DE),A			; size of buffer=255
        LD	A,0FFH			; directly to screen (ignores console output redirection)
        CALL	C04B1			; buffered line input
        LD	A,0AH
        CALL	C08EE			; LF to screen (with list output)
        LD	HL,IB1D0+1
        LD	E,(HL)
        LD	D,00H			; size of inputline
        INC	HL
        EX	DE,HL
        ADD	HL,DE
        LD	(HL),0DH
        INC	HL
        LD	(HL),0AH		; add a CR/LF at the end of the inputline
        INC	HL
        LD	(HL),00H		; and a inputline terminator
        EX	DE,HL
        LD	A,(HL)
        CP	1AH			; line input start with a CTRL-Z ?
        JR	Z,J0985			; yep, return EOF 'error'
J0979:	INC	HL
        LD	(DBB78),HL		; update pointer in line input buffer
        LD	B,A
        CP	0AH			; LF ?
        LD	A,.EOL
        RET	Z			; yep, return EOL 'error'
        XOR	A			; no error
        RET

J0985:	LD	B,A
        LD	(HL),00H
        LD	(DBB78),HL		; empty line input buffer
        LD	A,.EOF
        RET

J098E:	BIT	5,C
        JR	NZ,J0997		; ASCII mode,
        CALL	C0A6C			; binary mode, char to screen (low level)
        XOR	A			; no error
        RET

J0997:	PUSH	AF
        CALL	C0897			; check keyboard status with special controlkeys handler
        POP	AF
        CALL	C08EE			; char to screen (with list output)
        XOR	A			; no error
        RET

J09A1:	BIT	5,C
        JR	NZ,J09AB		; ASCII mode,
        CALL	C0A42			; binary mode, check if keyboard input ready (low level)
        LD	E,A
        XOR	A
        RET

J09AB:	CALL	C0897			; check keyboard status with special controlkeys handler
        LD	E,A
        XOR	A
        RET

J09B1:	CALL	C0A20			; get screensize
        XOR	A			; no error
        RET

;	  Subroutine __________________________
;	     Inputs  ________________________
;	     Outputs ________________________

C09B6:	LD	HL,IB1D0+2
        LD	(DBB78),HL
        LD	(HL),00H		; empty line input buffer
        RET

; aux device jumptable

A09BF:	JP	J09CE			; input
        JP	J09DD			; output
        JP	J0A1C			; check if input ready (always ready)
        JP	J0A1C			; check if output ready (always ready)
        JP	J0A17			; get screensize

J09CE:	CALL	C0B46			; aux input (low level)
        LD	B,A
        CP	1AH
        JR	Z,J0A14			; CTRL-Z, EOF 'error'
        CP	0DH
        LD	A,.EOL
        RET	Z			; CR, EOL 'error'
        XOR	A			; no error
        RET

J09DD:	CALL	C0B51			; aux output (low level)
        XOR	A			; no error
        RET

; lst/prn device jumptable

A09E2:	JP	J0A12			; input (always EOF)
        JP	J09F1			; output
        JP	J0A1C			; check if input ready (always ready)
        JP	J09FD			; check if output ready
        JP	J0A17			; get screensize

J09F1:	CALL	C0B25			; printer output (low level)
        JR	NC,J0A1A		; not aborted, quit
        RES	0,(IY+DBB8A-DBB80)	; stop console output to list output
        LD	A,.STOP
        RET

J09FD:	CALL	C0B37			; check printer output ready (low level)
        LD	E,A
        XOR	A
        RET

; nul device jumptable

A0A03:	JP	J0A12			; input (always EOF)
        JP	J0A1A			; output
        JP	J0A1C			; check if input ready (always ready)
        JP	J0A1C			; check if output ready (always ready)
        JP	J0A17			; get screensize

J0A12:	LD	B,1AH
J0A14:	LD	A,.EOF
        RET

J0A17:	LD	DE,0
J0A1A:	XOR	A
        RET

J0A1C:	LD	E,0FFH
        XOR	A
        RET

;	  Subroutine get screensize
;	     Inputs  ________________________
;	     Outputs ________________________

C0A20:	LD	A,(LINLEN)
        LD	E,A
        LD	A,(CRTCNT)
        LD	HL,CNSDFG
        ADD	A,(HL)
        LD	D,A
        RET

;	  Subroutine keyboard input (low level)
;	     Inputs  ________________________
;	     Outputs ________________________

C0A2D:	CALL	CF25B

        IF	USESBF EQ 1

        CALL	C0AB9			; empty screenoutput buffer

        ENDIF

        PUSH	IX
        LD	IX,CHGET
        CALL	C0B78			; main-bios call CHGET
        CALL	C0B5B			; check and handle CTRL-STOP
        POP	IX
        RET

;	  Subroutine check if keyboard input (low level)
;	     Inputs  ________________________
;	     Outputs ________________________

C0A42:	CALL	CF261
        LD	HL,DF2BD
        DEC	(HL)			; should keyboardbuffer be checked ?
        JR	NZ,J0A69		; not yet, quit
        INC	(HL)

        IF	USESBF EQ 1

        LD	A,(DF2BE)
        DEC	A			; timer finished ?
        CALL	Z,C0AB9			; yep, empty screenoutput buffer

        ENDIF

        PUSH	IX
        LD	IX,CHSNS
        CALL	C0B78			; main-bios call CHSNS
        CALL	C0B5B			; check and handle CTRL-STOP
        POP	IX
        LD	A,0FFH
        RET	NZ
        LD	A,100+1
        LD	(DF2BD),A		; 100 times no keyboardbuffer check or when vdp interrupt occures
J0A69:	XOR	A
        RET

;	  Subroutine screen output (low level)
;	     Inputs  ________________________
;	     Outputs ________________________

J0A6B:	LD	A,C

;	  Subroutine char to screen (low level)
;	     Inputs  ________________________
;	     Outputs ________________________
;	     Remark  normal version, normally used

C0A6C:
        IF	USESBF NE 1

        CALL	CF25E
        PUSH	IX
        LD	IX,CHPUT
        CALL	C0B78			; main-bios call CHPUT
        POP	IX
        RET

        ELSE

;	  Subroutine char to screen (low level)
;	     Inputs  ________________________
;	     Outputs ________________________
;	     Remark  outputbuffering version, normally not used

?0A7B:	LD	E,A
        CP	1BH
        CALL	Z,C0AB9			; begin of an ESC sequence, empty screenoutput buffer
        LD	HL,DBB76
        BIT	0,(HL)			; in double byte char ?
        RES	0,(HL)			; not anymore
        JR	NZ,J0A91		; 2nd byte of double byte char
        CALL	C17E0			; check for double byte header char if enabled
        JR	NC,J0A91
        SET	0,(HL)			; is header char, flag it
J0A91:	LD	A,2
        LD	(DF2BE),A		; wait at least 100 ms for actual screenoutput
        LD	A,(DBB77)
        LD	C,A
        LD	B,0
        LD	HL,DB06C
        ADD	HL,BC			; screen output buffer pointer
        LD	(HL),E			; put in buffer
        INC	A
        LD	(DBB77),A
        CP	100
        JR	Z,C0ACE			; buffer full, empty screenoutput buffer and quit
        LD	A,(ESCCNT)
        OR	A
        JR	NZ,C0ACE		; screenouput in ESC sequence, empty screenoutput buffer and quit
        LD	A,E
        CP	0AH
        JR	Z,C0ACE			; linefeed char, empty screenoutput buffer and quit
        CP	07H
        JR	Z,C0ACE			; bell char, empty screenoutput buffer and quit
        RET

;	  Subroutine empty screenoutput buffer (if anything)
;	     Inputs  ________________________
;	     Outputs ________________________

C0AB9:	CALL	CF264
        PUSH	AF
        LD	A,(DBB77)
        OR	A
        JR	Z,J0ACC			; nothing in buffer, quit
        PUSH	BC
        PUSH	DE
        PUSH	HL
        CALL	C0ACE			; empty screenoutput buffer
        POP	HL
        POP	DE
        POP	BC
J0ACC:	POP	AF
        RET

;	  Subroutine empty screenoutput buffer
;	     Inputs  ________________________
;	     Outputs ________________________

C0ACE:	EX	AF,AF'
        EXX
        PUSH	AF
        PUSH	BC
        PUSH	DE
        PUSH	HL
        PUSH	IX
        PUSH	IY
        LD	HL,DB06C
        LD	A,(DBB76)
        BIT	0,A			; buffer in double byte char sequence ?
        PUSH	AF
        LD	A,(DBB77)
        JR	Z,J0AE9			; nope, empty complete buffer
        DEC	A			; do not include the double byte char header (save it for later)
        JR	Z,J0B07			; only 1 char in buffer (not the complete double byte char), keep this in buffer and quit
J0AE9:	LD	B,A
        LD	A,(ESCCNT)
        OR	A
        JR	NZ,J0AF6		; in ESC sequence, skip cursor off
        LD	HL,IB069
        INC	B
        INC	B
        INC	B			; include cursor off string
J0AF6:	CALL	CF1DC			; print string via chput
        PUSH	HL
        LD	HL,IB066
        LD	B,3
        LD	A,(ESCCNT)
        OR	A
        CALL	Z,CF1DC			; not in ESC sequence, print cursor on string via chput
        POP	HL
J0B07:	XOR	A
        LD	(DBB77),A		; empty screen output buffer
        LD	(DF2BE),A		; disable timer screenout buffer timer
        POP	AF
        JR	Z,J0B1A			; not in a double byte char sequence, quit
        LD	A,(HL)
        LD	(DB06C),A		; last char of buffer now the only char
        LD	A,1
        LD	(DBB77),A		; 1 char in screenoutput buffer
J0B1A:	POP	IY
        POP	IX
        POP	HL
        POP	DE
        POP	BC
        POP	AF
        EXX
        EX	AF,AF'
        RET


        ENDIF


;	  Subroutine printer output (low level)
;	     Inputs  ________________________
;	     Outputs ________________________

C0B25:	CALL	CF267

        IF	USESBF EQ 1

        CALL	C0AB9			; empty screenoutput buffer

        ENDIF

        PUSH	IX
        LD	IX,LPTOUT
        CALL	C0B78			; main-bios call LPTOUT
        POP	IX
        RET

;	  Subroutine check printer output ready (low level)
;	     Inputs  ________________________
;	     Outputs A = 0FFH (ready) or A = 0 (not ready)

C0B37:	CALL	CF26A
        PUSH	IX
        LD	IX,LPTSTT
        CALL	C0B78			; main-bios call LPTSTT
        POP	IX
        RET

;	  Subroutine aux input (low level)
;	     Inputs  ________________________
;	     Outputs ________________________

C0B46:
        IF	USESBF EQ 1

        CALL	C0AB9			; empty screenoutput buffer

        ENDIF

        LD	HL,IF371
        JP	C374C			; call AUX-input with DOS segments active

;	  Subroutine aux output (low level)
;	     Inputs  ________________________
;	     Outputs ________________________

J0B50:	LD	A,C

;	  Subroutine aux output (low level)
;	     Inputs  ________________________
;	     Outputs ________________________

C0B51:
        IF	USESBF EQ 1

        CALL	C0AB9			; empty screenoutput buffer

        ENDIF

        LD	HL,IF374
        JP	C374C			; call AUX-output with DOS segments active

;	  Subroutine check and handle CTRL-STOP
;	     Inputs  ________________________
;	     Outputs ________________________

C0B5B:	PUSH	AF
        LD	A,(INTFLG)
        SUB	03H
        JR	Z,J0B65
        POP	AF
        RET

J0B65:	LD	(INTFLG),A
        LD	IX,KILBUF
        CALL	C0B78			; main-bios call KILBUF
        LD	A,.STOP
        LD	B,00H
        CALL	C3749			; call program abort routine with DOS segments active
J0B76:	JR	J0B76			; loop to infinety

;	  Subroutine call main-bios
;	     Inputs  ________________________
;	     Outputs ________________________

C0B78:	EX	AF,AF'
        EXX
        PUSH	AF
        PUSH	BC
        PUSH	DE
        PUSH	HL
        PUSH	IY
        EXX
        EX	AF,AF'
        CALL	CF1D9
        EX	AF,AF'
        EXX
        POP	IY
        POP	HL
        POP	DE
        POP	BC
        POP	AF
        EXX
        EX	AF,AF'
        RET

;	  Subroutine _CPMVER
;	     Inputs  ________________________
;	     Outputs ________________________

A0B90:	LD	HL,0022H
        XOR	A
        RET

;	  Subroutine _DSKRST
;	     Inputs  ________________________
;	     Outputs ________________________

A0B95:	LD	B,0FFH			; all drives
        LD	D,0			; flush only
        CALL	A0CE0			; flush buffers
        LD	A,1
        LD	(DF23C),A
        LD	HL,0080H
        LD	(DF23D),HL		; transfer adres to 00080H
        XOR	A
        LD	H,A
        LD	L,A
        RET

;	  Subroutine _SELDSK
;	     Inputs  ________________________
;	     Outputs ________________________

A0BAB:	INC	E
        LD	A,E
        LD	C,.IDRV
        CALL	NZ,C362C		; get drivetable entry pointer
        JR	Z,J0BBF
        LD	A,(HL)
        INC	HL
        OR	(HL)			; entry in use ?
        JR	Z,J0BBF			; nope, quit with invalid drive error
        LD	A,E
        LD	(DF23C),A
        LD	C,0			; no error
J0BBF:	LD	HL,(DF347)
        LD	H,0
        LD	A,C
        RET

;	  Subroutine _LOGIN
;	     Inputs  ________________________
;	     Outputs ________________________

A0BC6:	LD	B,8
        LD	HL,0
J0BCB:	ADD	HL,HL
        PUSH	HL
        LD	A,B
        CALL	C362C			; get drivetable entry pointer
        LD	A,(HL)
        INC	HL
        OR	(HL)			; entry in use ?
        POP	HL
        JR	Z,J0BD8
        INC	HL			; yep, set bit
J0BD8:	DJNZ	J0BCB
        XOR	A
        RET

;	  Subroutine _CURDRV
;	     Inputs  ________________________
;	     Outputs ________________________

A0BDC:	LD	A,(DF23C)
        DEC	A
        LD	L,A
        XOR	A
        LD	H,A
        RET

;	  Subroutine _SETDTA
;	     Inputs  DE = transferadres
;	     Outputs ________________________

A0BE4:	LD	(DF23D),DE
        XOR	A
        LD	H,A
        LD	L,A
        RET

;	  Subroutine _ALLOC
;	     Inputs  ________________________
;	     Outputs ________________________

A0BEC:	LD	C,E
        LD	B,0			; for disk
        LD	IX,IB9DA
        CALL	C31AB			; check diskchange
        OR	A
        LD	C,0FFH
        RET	NZ			; error, quit
        PUSH	HL
        POP	IX
        LD	E,(IX+22)
        LD	D,(IX+23)
        PUSH	DE
        JP	ALLOC

J0C07:	LD	B,D
        LD	C,D			; free = 0
J0C09:	PUSH	DE
        CALL	FATRED			; get FAT entry content
        LD	A,D
        OR	E			; free cluster ?
        JR	NZ,J0C12
        INC	BC			; yep, free+1
J0C12:	POP	DE
        EX	(SP),HL
        SBC	HL,DE
        ADD	HL,DE			; last FAT entry ?
        EX	(SP),HL
        INC	DE
        JR	NZ,J0C09		; nope, continue with the next
        PUSH	BC
        LD	E,(IX+12)
        LD	D,(IX+13)		; first FAT sector
        CALL	BUF_1
        LD	DE,11
        ADD	HL,DE			; the buffer itself
        LD	DE,(DF34D)		; pointer to diskdriver sectorbuffer
        PUSH	DE
        LD	BC,512
        LDIR				; copy first FAT sector in the diskdriver sectorbuffer
        POP	IY
        POP	HL
        POP	DE
        DEC	DE
        NOP
        LD	C,(IX+2)
        LD	B,(IX+3)
        PUSH	BC			; pointer to DPB
        LD	C,(IX+10)
        INC	C
        POP	IX
        XOR	A
        RET

;	  Subroutine _VERIFY
;	     Inputs  ________________________
;	     Outputs ________________________

A0C48:	LD	A,E
        LD	(DF30D),A
        XOR	A
        LD	H,A
        LD	L,A
        RET

;	  Subroutine _DPARM
;	     Inputs  ________________________
;	     Outputs ________________________

A0C50:	LD	IX,IB9DA
        LD	B,0			; for disk
        LD	C,L
        PUSH	DE
        CALL	C31AB			; check diskchange
        POP	DE
        OR	A
        RET	NZ
        PUSH	HL
        POP	IX
        PUSH	DE
        LD	BC,8
        ADD	HL,BC
        LDI
        LD	BC,512
        LD	A,C
        LD	(DE),A
        INC	DE
        LD	A,B
        LD	(DE),A
        INC	DE
        INC	HL
        LD	A,(HL)
        INC	HL
        INC	A
        LD	(DE),A
        INC	DE
        INC	HL
        LDI
        LDI
        LDI
        LD	A,(HL)
        INC	HL
        PUSH	HL
        LD	L,(HL)
        LD	H,00H
        ADD	HL,HL
        ADD	HL,HL
        ADD	HL,HL
        ADD	HL,HL
        ADD	A,L
        LD	(DE),A
        INC	DE
        LD	A,H
        LD	(DE),A
        INC	DE
        POP	HL
        INC	HL
        INC	DE
        INC	DE
        PUSH	DE
        INC	DE
        LD	BC,12
        LDIR
        PUSH	DE
        EX	DE,HL
        LD	BC,-7
        ADD	HL,BC
        INC	(HL)
        JR	NZ,J0CA4
        INC	HL
        INC	(HL)
J0CA4:	EX	DE,HL
        POP	DE
        LD	B,08H	; 8
        XOR	A
J0CA9:	LD	(DE),A
        INC	DE
        DJNZ	J0CA9
        POP	DE
        LDI
        LD	L,(IX+22)
        LD	H,(IX+23)
        DEC	HL
        LD	B,(IX+11)
        DEFB	0EH			; LD C,xx
J0CBB:	ADD	HL,HL
        ADC	A,A
        DJNZ	J0CBB
        LD	C,(IX+20)
        LD	B,(IX+21)
        ADD	HL,BC
        CALL	ALLSEC
        LD	(HL),D
        DEC	HL
        LD	(HL),E
        POP	DE
        XOR	A
        RET

;	  Subroutine _GETDTA
;	     Inputs  ________________________
;	     Outputs DE = transferadres

A0CCF:	LD	DE,(DF23D)
        XOR	A
        RET

;	  Subroutine _GETVFY
;	     Inputs  ________________________
;	     Outputs ________________________

A0CD5:	LD	A,(DF30D)
        OR	A
        JR	Z,J0CDD
        LD	A,0FFH
J0CDD:	LD	B,A
        XOR	A
        RET

;	  Subroutine _FLUSH
;	     Inputs  ________________________
;	     Outputs ________________________

A0CE0:	LD	A,B
        CP	0FFH
        JR	Z,J0CEB			; all drives
        CALL	C362C			; get drivetable entry pointer
        LD	B,A
        LD	A,C
        RET	Z
J0CEB:	LD	A,B
        CALL	C2C68			; write dirty sectorbuffers of drive
        LD	A,D
        OR	A
        RET	Z			; flush only, quit
        LD	A,B			; driveid
        CALL	C2C78			; mark all sectorbuffers of drive unused
        CALL	C3611			; diskchange status of all drives to flushed
        XOR	A
        RET

;	  Subroutine _TERM0
;	     Inputs  ________________________
;	     Outputs ________________________

A0CFB:	LD	B,0

;	  Subroutine _TERM
;	     Inputs  ________________________
;	     Outputs ________________________

A0CFD:	LD	A,B
        LD	B,00H
        CALL	C3749			; call program abort routine with DOS segments active
J0D03:	JR	J0D03			; loop to infinety

;	  Subroutine _ERROR
;	     Inputs  ________________________
;	     Outputs ________________________

A0D05:	LD	B,(IY+DBBFD-DBB80)	; errorstatus of last BDOS call
        XOR	A
        RET

;	  Subroutine _EXPLAIN
;	     Inputs  ________________________
;	     Outputs ________________________

A0D0A:	LD	A,B
        PUSH	DE
        PUSH	IY
        LD	IY,(DF348-1)
        LD	IX,(DF2DA)
        CALL	C001C
        EI
        POP	IY
        LD	B,A
        OR	A
        DEC	HL
        CALL	NZ,C0D26
        XOR	A
        LD	(HL),A
        POP	DE
        RET

;
;	  Subroutine __________________________
;	     Inputs  ________________________
;	     Outputs ________________________
;
C0D26:	LD	C,0FFH
J0D28:	INC	C
        SUB	0AH	; 10
        JR	NC,J0D28
        ADD	A,3AH	; ":"
        PUSH	AF
        LD	A,C
        OR	A
        CALL	NZ,C0D26
        POP	AF
        LD	(HL),A
        INC	HL
        RET

        IF	1 EQ 0

;	  Subroutine _FORMAT
;	     Inputs  A = subfunction, B = drivenumber, HL = start of buffer, DE = size of buffer
;	     Outputs ________________________

A0D39:	EX	AF,AF'
        PUSH	HL
        POP	IX
        LD	A,B
        CALL	C362C			; get drivetable entry pointer
        LD	A,(HL)
        INC	HL
        LD	H,(HL)
        LD	L,A
        OR	H
        LD	A,C
        RET	Z			; entry not used, quit with error
        EX	AF,AF'
        OR	A			; get choicestring subfunction ?
        JR	NZ,J0D58		; nope, other subfunction
        CALL	C3031			; get choicestring pointer
        PUSH	HL
        POP	IX
        LD	B,(IX+0)		; slotid diskdriver
        EX	DE,HL			; pointer to choicestring in HL
        OR	A
        RET

J0D58:	EX	AF,AF'
        CALL	C2C67			; write dirty sectorbuffers of drivetable
        CALL	C2C77			; mark all sectorbuffers of drivetable unused
        PUSH	HL
J0D60:	PUSH	DE
        PUSH	IX
        POP	DE
        XOR	A			; use DOS segments
        CALL	C274F			; get segmentnumber of buffer start
        LD	HL,04000H
        OR	A
        SBC	HL,DE			; number of bytes usable of segment
        EX	(SP),HL			; size of buffer in HL
        POP	BC
        SBC	HL,BC
        JR	C,J0D7E			; usable > size of buffer, buffersize is specified size
        SBC	HL,BC
        JR	C,J0D81			; rest of buffer < usable in this segment, buffersize is useable size
        ADD	HL,BC
        EX	DE,HL			; adjust size of buffer
        ADD	IX,BC			; adjust start of buffer to next page
        JR	J0D60			; take next page

J0D7E:	ADD	HL,BC
        LD	B,H
        LD	C,L
J0D81:	SET	7,D			; page 2 based
        PUSH	DE
        POP	IX
        LD	D,A
        EX	AF,AF'
        POP	HL			; pointer to drivetable
        CALL	C304E			; format
        LD	BC,9
        ADD	HL,BC
        LD	(HL),0			; drivetable status = init please
        RET

        ENDIF

        IF	1 EQ 0

;	  Subroutine _RAMD
;	     Inputs  ________________________
;	     Outputs ________________________

A0D93:	PUSH	BC
        LD	B,08H	; 8
        LD	D,B
        CALL	A0E8B
        POP	BC
        INC	B
        JP	Z,J0E2D			; requested segments 255, return info
        DEC	B
        JP	Z,J0E04			; requested segments 0, kill ramdisk
        LD	HL,(IBA23+8*2)
        LD	A,H
        OR	L			; ramdisk already in use ?
        LD	C,.RAMDX
        JP	NZ,J0E2F		; yep, quit with . error
        CALL	C0E35			; clear ramdisk bootsector and ramdisk segmenttable
        LD	DE,IBE02		; ramdisk segmenttable
        LD	HL,DBE00
J0DB6:	EXX
        LD	A,1			; non system
        LD	B,30H			; first other mappers, then DOS mapper
        CALL	C11A6			; allocate segment
        JR	C,J0DCA			; failed, stop allocating
        PUSH	BC
        EXX
        INC	(HL)			; increase number of ramdisk segments
        LD	(DE),A			; segmentnumber
        INC	DE
        POP	AF
        LD	(DE),A			; slotid mapper
        INC	DE
        DJNZ	J0DB6			; next segment
J0DCA:	LD	A,(DBE00)
        OR	A			; no ramdisk segments ?
        LD	A,C
        LD	C,.NORAM
        JP	Z,J0E2F			; yep, quit with . error
        LD	HL,(DBBFB)		; pointer to drivetable ramdisk
        LD	(IBA23+8*2),HL		; fill in H: drivetable pointer
        LD	A,8
        PUSH	HL
        POP	IX
        LD	(IX+8),A		; prompt driveid
        LD	(IX+9),0		; driver driveid
        LD	(IX+31),0FFH
        LD	C,A
        LD	IX,IB9DA
        LD	B,0			; for disk
        CALL	C31AB			; check diskchange
        LD	A,0FFH			; mediadescriptor for ramdisk is 0FFH
        CALL	C2F38			; clear FAT
        LD	DE,0			; whole rootdirectory
        CALL	C2FC7			; clear directory
        CALL	C2C67			; write dirty sectorbuffers of drivetable
        JR	J0E2D			; finish

J0E04:	LD	HL,(IBA23+8*2)
        LD	A,H
        OR	L			; was ramdisk in use ?
        JR	Z,J0E2D			; nope, finish
        LD	A,8			; driveid ramdisk
        CALL	C2C78			; mark all sectorbuffers of drive unused
        LD	HL,0
        LD	(IBA23+8*2),HL		; drive H: not in use
        XOR	A
        LD	(DBE00),A		; no ramdisk segments
        LD	HL,IBE02		; ramdisk segmenttable
J0E1D:	LD	C,(HL)			; segment
        INC	HL
        LD	B,(HL)			; slotid mapper
        INC	HL
        LD	A,B
        OR	A			; end of table ?
        JR	Z,J0E2D			; yep, finish
        PUSH	HL
        LD	A,C
        CALL	C1256			; free segment
        POP	HL
        JR	J0E1D			; next segment

J0E2D:	LD	C,0
J0E2F:	LD	A,(DBE00)
        LD	B,A
        LD	A,C
        RET

        ENDIF

;	  Subroutine clear ramdisk bootsector and ramdisk segmenttable
;	     Inputs  ________________________
;	     Outputs ________________________

C0E35:	LD	HL,IBC00
        LD	DE,512+2+255*2
J0E3B:	LD	(HL),0
        INC	HL
        DEC	DE
        LD	A,D
        OR	E
        JR	NZ,J0E3B
        RET

;	  Subroutine _BUFFER
;	     Inputs  ________________________
;	     Outputs ________________________

A0E44:	LD	A,B
        CP	2
        JR	C,J0E86
J0E49:	LD	A,B
        CP	(IY+IBBFA-DBB80)	; same as current number of buffers ?
        JR	Z,J0E86			; yep, quit
        JR	NC,J0E6E		; more as current, allocate extra buffer
        LD	HL,(DBBF8)
        CALL	C2D2D			; write sectorbuffer if dirty
        LD	E,(HL)
        INC	HL
        LD	D,(HL)
        DEC	HL
        LD	(DBBF8),DE
        CALL	C022B			; free BDOS data block
        LD	HL,0
        LD	(DBBF6),HL		; no last FAT buffer read
        LD	HL,IBBFA
        DEC	(HL)
        JR	J0E49

J0E6E:	LD	HL,512+11
        CALL	C01CB			; allocate BDOS data block
        JR	NZ,J0E86
        LD	DE,(DBBF8)
        LD	(DBBF8),HL
        LD	(HL),E
        INC	HL
        LD	(HL),D
        LD	HL,IBBFA
        INC	(HL)
        JR	J0E49

J0E86:	LD	B,(IY+IBBFA-DBB80)	; number of buffers
        XOR	A
        RET

;	  Subroutine _ASSIGN
;	     Inputs  ________________________
;	     Outputs ________________________

A0E8B:	LD	HL,IBA1A
        LD	A,B
        OR	A
        JR	Z,J0EAC
        CP	09H	; 9
        LD	A,.IDRV
        RET	NC
        LD	C,B
        LD	B,00H
        ADD	HL,BC
        LD	A,D
        INC	A
        JR	Z,J0EA9
        DEC	A
        JR	Z,J0EA8
        CP	09H	; 9
        LD	A,.IDRV
        RET	NC
        LD	C,D
J0EA8:	LD	(HL),C
J0EA9:	LD	D,(HL)
        XOR	A
        RET

J0EAC:	LD	(HL),A
        INC	HL
        INC	A
        CP	09H	; 9
        JR	NZ,J0EAC
        XOR	A
        LD	D,A
        RET

;	  Subroutine _DSKCHK
;	     Inputs  ________________________
;	     Outputs ________________________

A0EB6:	OR	A
        JR	Z,J0EC2
        LD	A,B
        OR	A
        JR	Z,J0EBF
        LD	A,0FFH
J0EBF:	LD	(DF2EC),A		; set disk check level
J0EC2:	LD	A,(DF2EC)
        LD	B,A			; return disk check level
        XOR	A
        RET

;	  Subroutine _DOSVER
;	     Inputs  none
;	     Outputs ________________________

A0EC8:	LD	B,02H
        LD	C,31H			; version 2.31
        XOR	A
        LD	H,A
        LD	L,A			; ?
        LD	D,A
        LD	E,A			; MSXDOS system file version (set by MSXDOS BDOS handler)
        RET

;	  Subroutine _REDIR
;	     Inputs  ________________________
;	     Outputs ________________________

A0ED2:	LD	C,(IY+DBB89-DBB80)	; console redirection status
        OR	A
        JR	Z,J0EDB
        LD	(IY+DBB89-DBB80),B
J0EDB:	LD	B,C
        XOR	A
        RET

;	  Subroutine _GENV (get environment)
;	     Inputs  HL = pointer to environmentname, DE = pointer to buffer, B = size of buffer
;	     Outputs ________________________

A0EDE:	XOR	A			; use DOS segments

;	  Subroutine get environment
;	     Inputs  A=0 for DOS segments, A<>0 for current segments
;	     Outputs ________________________

C0EDF:	LD	(DBBED),A
        XOR	A			; do upcasing
        PUSH	BC
        CALL	C0FA2			; validate environmentname
        POP	BC
        RET	NZ			; error, quit
        PUSH	DE
        PUSH	BC
        LD	DE,DBBEE		; start of environmentchain
        CALL	C0F8B			; search for environment
        LD	DE,I0F76
        JR	NC,J0EF8		; not found, use empty string as value
        LD	D,B
        LD	E,C
J0EF8:	POP	BC
        POP	HL
        CALL	C0FC8			; copy environmentvalue to buffer
        EX	DE,HL
        RET

;	  Subroutine _SENV (set environment)
;	     Inputs  HL = pointer to environmentname, DE = pointer to value
;	     Outputs ________________________

A0EFF:	XOR	A
        LD	(DBBED),A		; use DOS segments
        XOR	A			; do upcasing
        CALL	C0FA2			; validate environmentname
        RET	NZ			; error, quit
        LD	A,B
        OR	A
        RET	Z			; empty string, quit
        EX	AF,AF'
        EX	DE,HL
        LD	A,0FFH			; no upcasing
        CALL	C0FA2			; validate environmentvalue
        RET	NZ			; error, quit
        LD	A,B
        OR	A
        JR	Z,J0F46			; empty value, kill environment
        EX	AF,AF'
        ADD	A,B
        LD	C,A
        LD	A,0
        ADC	A,A
        LD	B,A			; bc = totalsize (name+value)
        PUSH	HL
        LD	HL,4
        ADD	HL,BC			; 2 extra bytes for pointer, 2 extra bytes for 2 endmarkers
        CALL	C01CB			; allocate BDOS data block
        POP	BC
        RET	NZ			; failed, quit
        PUSH	BC
        LD	BC,(DBBEE)
        LD	(DBBEE),HL		; new element in chain
        LD	(HL),C
        INC	HL
        LD	(HL),B			; which points to rest of the chain
        INC	HL
        EX	DE,HL
        XOR	A			; do upcasing
        CALL	C0FDF			; copy environmentname to environment
        EX	(SP),HL
        LD	A,0FFH			; no upcasing
        CALL	C0FDF			; copy environmentvalue to environment
        POP	HL
        LD	DE,(DBBEE)
        JR	J0F4A			; kill old version of environment if exists

J0F46:	EX	DE,HL
        LD	DE,DBBEE		; start of environmentchain
J0F4A:	CALL	C0F8B			; search for environment
        LD	HL,DBBEE		; start or environmentchain
        CALL	C,C2192			; found, remove element from chain
        XOR	A
        RET

;	  Subroutine _FENV
;	     Inputs  DE = environmentnumber, HL = pointer to buffer, B = size of buffer
;	     Outputs ________________________

A0F55:	XOR	A
        LD	(DBBED),A		; use DOS segments
        PUSH	HL
        PUSH	BC
        LD	B,D
        LD	C,E
        LD	HL,(DBBEE)		; start of environment chain
J0F60:	LD	A,H
        OR	L			; end of chain ?
        LD	DE,I0F76
        JR	Z,J0F71			; yep, use empty string
        LD	E,(HL)
        INC	HL
        LD	D,(HL)
        INC	HL
        EX	DE,HL			; pointer to next item in chain
        DEC	BC
        LD	A,B
        OR	C			; requested environmentnumber found ?
        JR	NZ,J0F60		; nope, continue
J0F71:	POP	BC
        POP	HL
        JP	C0FC8			; copy environmentname to buffer

I0F76:	DEFW	0

;	  Subroutine search for environment
;	     Inputs  ________________________
;	     Outputs Cx set if found

C0F8B:	EX	DE,HL
        LD	A,(HL)
        INC	HL
        LD	H,(HL)
        LD	L,A
        OR	H
        EX	DE,HL
        RET	Z
        PUSH	DE
        PUSH	HL
        INC	DE
        INC	DE
        CALL	C0FF1			; compare with environment
        LD	B,D
        LD	C,E
        POP	HL
        POP	DE
        JR	NZ,C0F8B		; not equal, try next
        SCF
        RET

;	  Subroutine validate environmentstring
;	     Inputs  ________________________
;	     Outputs ________________________

C0FA2:	PUSH	HL
        AND	01H
        LD	C,A			; upcasing flag
        LD	B,0FFH
J0FA8:	CALL	C1003			; read byte (environment)
        INC	HL
        CALL	C17AE			; check character
        JR	Z,J0FC1			; endmarker,
        BIT	0,C
        JR	NZ,J0FBB		; supress upcasing, no check on illegal chars
        BIT	4,C
        LD	A,.IENV
        JR	NZ,J0FC5		; illegal char, quit with ? error
J0FBB:	DJNZ	J0FA8
        LD	A,.ELONG
        JR	J0FC5			; more as 255 chars, quit with ? error

J0FC1:	DEC	A			; 255
        SUB	B
        LD	B,A			; size of string
        XOR	A
J0FC5:	POP	HL
        OR	A			; Zx set (no error)
        RET

;	  Subroutine copy from environment to buffer
;	     Inputs  B = size of buffer, DE = pointer to environment, HL = pointer to buffer
;	     Outputs ________________________

C0FC8:	PUSH	HL
        PUSH	DE
J0FCA:	LD	A,B
        DEC	B
        OR	A
        LD	A,.ELONG
        JR	Z,J0FDB
        LD	A,(DE)
        CALL	C1012			; write byte (environment)
        INC	HL
        LD	A,(DE)
        INC	DE
        OR	A
        JR	NZ,J0FCA
J0FDB:	POP	DE
        POP	HL
        OR	A
        RET

;	  Subroutine copy from buffer to environment
;	     Inputs  A(b0) = no upcasing flag, HL = pointer to environment, DE = pointer to buffer
;	     Outputs ________________________

C0FDF:	PUSH	HL
        AND	01H
        LD	C,A
J0FE3:	CALL	C1003			; read byte (environment)
        INC	HL
        CALL	C17AE			; check character
        LD	(DE),A
        INC	DE
        OR	A
        JR	NZ,J0FE3
        POP	HL
        RET

;	  Subroutine compare with environment
;	     Inputs  HL = pointer to environment, DE = pointer to comparename
;	     Outputs A = 0 and Zx set if equal, A<>0 and Zx reset if not equal

C0FF1:	LD	C,0			; do upcasing
J0FF3:	CALL	C1003			; read byte (environment)
        INC	HL
        CALL	C17AE			; check character
        LD	B,A
        LD	A,(DE)
        INC	DE
        CP	B
        RET	NZ
        OR	A
        JR	NZ,J0FF3
        RET

;	  Subroutine read byte (environment)
;	     Inputs  ________________________
;	     Outputs ________________________

C1003:	PUSH	HL
        EX	DE,HL
        LD	A,(DBBED)		; DOS segments/current segments
        CALL	C274F			; get segmentnumber
        EX	DE,HL
        CALL	CF206			; RD_SEG
        EI
        POP	HL
        RET

;	  Subroutine write byte (environment)
;	     Inputs  ________________________
;	     Outputs ________________________

C1012:	PUSH	HL
        PUSH	DE
        LD	E,A
        EX	DE,HL
        LD	A,(DBBED)		; DOS segments/current segments
        CALL	C274F			; get segmentnumber
        EX	DE,HL
        CALL	CF209			; WR_SEG
        EI
        POP	DE
        POP	HL
        RET

;	  Subroutine _GDATE
;	     Inputs  ________________________
;	     Outputs ________________________

A1024:	CALL	C111B			; get time and date from clockchip
        LD	C,D
        LD	B,00H			; year (offset)
        LD	E,L
        LD	D,H			; month and day
        LD	HL,1980
        ADD	HL,BC			; year
        LD	A,D
        CP	3			; january or februari ?
        LD	A,C
        SBC	A,0FCH
        AND	0FCH
        RRCA
        RRCA
        ADD	A,C			; year (offset)
        PUSH	HL
        LD	HL,I104D-1
        LD	C,D
        ADD	HL,BC
        ADD	A,(HL)
        POP	HL
        ADD	A,E
J1044:	SUB	7
        JR	NC,J1044
        ADD	A,7
        LD	C,A			; daynumber
        XOR	A
        RET

I104D:	defb	1,4,4,7,9,12,14,17,20,22,25,27

;	  Subroutine _SDATE
;	     Inputs  ________________________
;	     Outputs ________________________

A1059:	LD	BC,-1980
        ADD	HL,BC
        JR	NC,J1091		; year < 1980, quit with "invalid date" error
        LD	A,H
        OR	A
        JR	NZ,J1091
        LD	A,L
        CP	99+1
        JR	NC,J1091		; year > 2079, quit with "invalid date" error
        LD	B,A
        LD	A,D
        DEC	A
        CP	11+1
        JR	NC,J1091		; month <1 or >12, quit with "invalid date" error
        LD	HL,I1096
        ADD	A,L
        LD	L,A
        JR	NC,J1077
        INC	H
J1077:	CP	LOW (I1096+1)		; februari ?
        JR	NZ,J1083		; nope, days per month solid
        LD	A,B
        AND	03H			; leap year ?
        JR	NZ,J1083		; nope, use 28 days
        LD	HL,I10A2		; use 29 days
J1083:	LD	A,E
        DEC	A
        CP	(HL)
        JR	NC,J1091		; day invalid, quit with "invalid date" error
        LD	L,E
        LD	H,D
        LD	D,B
        CALL	C1167			; write date to clockchip
        XOR	A
        LD	C,A			; no error
        RET

J1091:	LD	C,0FFH
        LD	A,.IDATE
        RET

I1096:	defb	31,28,31,30,31,30,31,31,30,31,30,31
I10A2:	defb	29

;	  Subroutine _GTIME
;	     Inputs  ________________________
;	     Outputs ________________________

A10A3:	CALL	C111B			; get time and date from clockchip
        LD	H,B			; hours
        LD	L,C			; minutes
        LD	D,E			; seconds
        LD	E,0
        XOR	A
        RET

;	  Subroutine _STIME
;	     Inputs  ________________________
;	     Outputs ________________________

A10AD:	LD	A,H
        CP	23+1
        JR	NC,J10C5		; hours >23, quit with "invalid time" error
        LD	A,L
        CP	59+1
        JR	NC,J10C5		; minutes >59, quit with "invalid time" error
        LD	A,D
        CP	59+1
        JR	NC,J10C5		; seconds >59, quit with "invalid time" error
        LD	B,H
        LD	C,L
        LD	E,D
        CALL	C1155			; write time to clockchip
        XOR	A
        LD	C,A			; no error
        RET

J10C5:	LD	C,0FFH
        LD	A,.ITIME
        RET

;	  Subroutine setup clockchip
;	     Inputs  ________________________
;	     Outputs ________________________

C10CA:	LD	A,13
        OUT	(0B4H),A
        IN	A,(0B5H)
        AND	04H
        LD	B,A
        INC	A
        OUT	(0B5H),A	; pause clockchip and select bank 1
        LD	A,10
        OUT	(0B4H),A
        LD	A,1
        OUT	(0B5H),A	; select 24 hour mode
        LD	A,13
        OUT	(0B4H),A
        LD	A,B
        OUT	(0B5H),A	; pause clockchip and select bank 0
        LD	BC,0D00H
J10E8:	LD	A,C
        OUT	(0B4H),A
        IN	A,(0B5H)
        PUSH	AF
        INC	C
        DJNZ	J10E8		; push all bank 0 nibbles
        LD	A,14
        OUT	(0B4H),A
        LD	A,0
        OUT	(0B5H),A	; select normal running modes
        LD	B,0DH
J10FB:	DEC	C
        POP	DE
        LD	A,C
        OUT	(0B4H),A
        LD	A,D
        OUT	(0B5H),A
        DJNZ	J10FB		; pop all bank 0 nibbles
J1105:	LD	A,13
        OUT	(0B4H),A
        IN	A,(0B5H)
        OR	08H
        OUT	(0B5H),A	; clockchip back in running mode
        RET

;	  Subroutine pause clockchip and select bank 0
;	     Inputs  ________________________
;	     Outputs ________________________

C1110:	LD	A,13
        OUT	(0B4H),A
        IN	A,(0B5H)
        AND	04H
        OUT	(0B5H),A
        RET

;	  Subroutine get time and date from clockchip
;	     Inputs  ________________________
;	     Outputs D = year, H = month, L = day, B = hours, C = minutes, E = seconds

C111B:	CALL	C1110		; pause clockchip and select bank 0
        LD	E,12
        CALL	C113C
        LD	D,A		; year (offset)
        CALL	C113C
        LD	H,A		; month
        CALL	C113C
        LD	L,A		; day
        DEC	E
        CALL	C113C
        LD	B,A		; hours
        CALL	C113C
        LD	C,A		; minutes
        CALL	C113C
        LD	E,A		; seconds
        JP	J1105		; put clockchip in runing mode

;	  Subroutine read byte from clockchip
;	     Inputs  E = nibblenumber
;	     Outputs E = nibblenumber (-2), A = data

C113C:	PUSH	BC
        CALL	C114C
        LD	B,A
        ADD	A,A
        ADD	A,A
        ADD	A,B
        ADD	A,A
        LD	B,A
        CALL	C114C
        ADD	A,B
        POP	BC
        RET

;	  Subroutine read nibble from clockchip
;	     Inputs  E = nibblenumber
;	     Outputs E = nibblenumber (-1), A = data

C114C:	LD	A,E
        OUT	(0B4H),A
        IN	A,(0B5H)
        AND	0FH
        DEC	E
        RET

;	  Subroutine write time to clockchip
;	     Inputs  ________________________
;	     Outputs ________________________

C1155:	LD	L,E
        LD	H,C
        LD	D,B
        CALL	C1110		; pause clockchip and select bank 0
        LD	A,15
        OUT	(0B4H),A
        LD	A,2
        OUT	(0B5H),A
        LD	E,0
        JR	J117D

;	  Subroutine write date to clockchip
;	     Inputs  ________________________
;	     Outputs ________________________

C1167:	CALL	C1110		; pause clockchip and select bank 0
        OR	01H
        OUT	(0B5H),A	; select bank 1
        LD	A,11
        OUT	(0B4H),A
        LD	A,D
        OUT	(0B5H),A	; leapyear offset
        CALL	C1110		; pause clockchip and select bank 0
        LD	E,7
J117D:	LD	A,L
        CALL	C118C
        LD	A,H
        CALL	C118C
        LD	A,D
        CALL	C118C
        JP	J1105		; put clockchip in runing mode

;	  Subroutine convert to BCD and write byte to clockchip
;	     Inputs  ________________________
;	     Outputs ________________________

C118C:	LD	C,A
        XOR	A
        LD	B,8
J1190:	RLC	C
        ADC	A,A
        DAA
        DJNZ	J1190
        CALL	C119D
        RRCA
        RRCA
        RRCA
        RRCA

;	  Subroutine write nibble to clockchip
;	     Inputs  A = data, E = nibblenumber
;	     Outputs E = nibblenumer (+1)

C119D:	LD	B,A
        LD	A,E
        OUT	(0B4H),A
        LD	A,B
        OUT	(0B5H),A
        INC	E
        RET

;	  Subroutine ALLSEG (allocate segment)
;	     Inputs  ________________________
;	     Outputs ________________________

C11A6:	OR	A			; user segment ?
        LD	A,(DBBFE)
        JR	Z,J11AE			; yep, use taskid as owner
        LD	A,0FFH			; owner is system
J11AE:	EX	AF,AF'
        LD	C,B
        LD	A,C
        AND	8FH			; slotid mapper specified ?
        JR	NZ,J11BA
        LD	A,(DF344)		; no, use disksystem (primary) mapper
        OR	C
        LD	C,A			; combine with allocation strategy
J11BA:	LD	A,C
        AND	70H
        JR	NZ,J11C1
        JR	C1206			; allocate segment of the specfied slot and quit

J11C1:	LD	B,C
        CP	20H
        JR	NZ,J11CB
        CALL	C1206			; allocate segment of the specfied slot
        JR	NC,J11FF		; succeeded, finish
J11CB:	XOR	A
        LD	HL,EXPTBL
J11CF:	BIT	7,(HL)
        JR	Z,J11D5
        SET	7,A
J11D5:	LD	C,A
        XOR	B
        AND	8FH
        JR	Z,J11E2			; skip the slot if it is the specified slot
        PUSH	HL
        CALL	C1206			; allocate segment of current slot
        POP	HL
        JR	NC,J11FF		; succeeded, finish
J11E2:	LD	A,C
        BIT	7,A
        JR	Z,J11ED
        ADD	A,04H
        BIT	4,A
        JR	Z,J11D5			; next secundary slot
J11ED:	INC	HL
        INC	A
        AND	03H
        JR	NZ,J11CF		; next primary slot
        LD	A,B
        AND	70H
        CP	30H			; first others, next specified strategy ?
        SCF
        JR	NZ,J11FF		; no, quit with error
        LD	C,B
        CALL	C1206			; allocate segment of the specfied slot
J11FF:	PUSH	AF
        LD	A,C
        AND	8FH
        LD	B,A
        POP	AF
        RET

;	  Subroutine allocate segment of the specified slot
;	     Inputs  ________________________
;	     Outputs ________________________

C1206:	PUSH	BC
        LD	A,C
        AND	0FH			; slot
        ADD	A,A
        ADD	A,A
        LD	E,A
        LD	D,0
        LD	HL,IBA35
        ADD	HL,DE
        LD	E,(HL)
        INC	HL
        LD	D,(HL)			; pointer to memorymapper info table
        INC	HL
        LD	A,(HL)
        INC	HL
        LD	H,(HL)			; pointer to segment allocation table
        LD	L,A
        OR	H			; memorymapper segment table available (memorymapper in specified slot) ?
        JR	Z,J1253			; no, quit with error
        LD	A,(DE)
        INC	DE
        LD	C,A			; number of segments in mapper
        EX	AF,AF'
        LD	B,A			; owner
        EX	AF,AF'
        INC	B
        JR	Z,J123B			; system, allocate from high to low
        LD	B,0			; current segmentnumber
J1229:	LD	A,(HL)
        OR	A			; free segment ?
        JR	Z,J1234			; yep, allocate
        INC	B
        INC	HL
        DEC	C
        JR	NZ,J1229		; try next
        JR	J1253			; none left, quit with error

J1234:	EX	DE,HL
        DEC	(HL)			; decrease number of free segments
        INC	HL
        INC	HL
        INC	(HL)			; increase number of allocated user segments
        JR	J124C			; flag allocated

J123B:	ADD	HL,BC			; to the end of the segmenttable
J123C:	DEC	HL
        LD	A,(HL)
        OR	A			; free segment ?
        JR	Z,J1246			; yep, allocate
        DEC	C
        JR	NZ,J123C		; try next
        JR	J1253			; none left, quit with error

J1246:	LD	B,C
        DEC	B
        EX	DE,HL
        DEC	(HL)			; decrease number of free segments
        INC	HL
        INC	(HL)			; increase number of allocated system segments
J124C:	EX	AF,AF'
        LD	(DE),A			; owner (also flags allocated)
        EX	AF,AF'
        LD	A,B
        POP	BC
        OR	A
        RET

J1253:	POP	BC
        SCF
        RET

;	  Subroutine FRESEG (free segment)
;	     Inputs  ________________________
;	     Outputs ________________________

C1256:	LD	C,A
        LD	A,B
        AND	8FH
        JR	NZ,J125F
        LD	A,(DF344)
J125F:	AND	0FH
        ADD	A,A
        ADD	A,A
        LD	E,A
        LD	D,00H
        LD	HL,IBA35
        ADD	HL,DE
        LD	E,(HL)
        INC	HL
        LD	D,(HL)
        INC	HL
        LD	A,(HL)
        INC	HL
        LD	H,(HL)
        LD	L,A
        OR	H
        JR	Z,J128E
        LD	A,(DE)
        CP	C
        JR	C,J128E
        JR	Z,J128E
        LD	B,00H
        ADD	HL,BC
        LD	A,(HL)
        OR	A
        JR	Z,J128E
        LD	(HL),B
        EX	DE,HL
        INC	HL
        INC	(HL)
        INC	HL
        INC	A
        JR	Z,J128B
        INC	HL
J128B:	DEC	(HL)
        OR	A
        RET

J128E:	SCF
        RET

;	  Subroutine free user segments of proces (and all childs)
;	     Inputs  ________________________
;	     Outputs ________________________

C1290:	LD	C,16		; 16 slots
        LD	HL,IBA35	; memorymapper info table
J1295:	LD	E,(HL)
        INC	HL
        LD	D,(HL)
        PUSH	DE		; pointer to memorymapper info
        INC	HL
        LD	E,(HL)
        INC	HL
        LD	D,(HL)		; pointer to memorymapper segment allocation table
        INC	HL
        EX	(SP),HL
        LD	A,H
        OR	L		; slot has memorymapper ?
        JR	Z,J12BE		; nope, next slot
        PUSH	BC
        LD	C,(HL)		; number of segments
J12A5:	LD	A,(DE)
        INC	A
        JR	Z,J12B9		; system segment, skip
        DEC	A
        JR	Z,J12B9		; free segment, skip
        DEC	A
        CP	B
        JR	C,J12B9		; user segment of a higher proces, skip
        PUSH	HL
        XOR	A
        LD	(DE),A		; mark segment as free
        INC	HL
        INC	(HL)		; increase number of free segments
        INC	HL
        INC	HL
        DEC	(HL)		; decrease number of allocated user segments
        POP	HL
J12B9:	INC	DE
        DEC	C
        JR	NZ,J12A5	; next segment
        POP	BC
J12BE:	POP	HL
        DEC	C
        JR	NZ,J1295	; next slot
        RET

;	  Subroutine parse path (with drive indicator)
;	     Inputs  A = driveid, C b0 no check for devicenames, b1 empty last item implies *.*, b2, b3, b4, b5, b6, b7 no other driveindicator, B = entry attribute, DE = pointer to parse string, IX = pointer to FIB
;	     Outputs ________________________

C12C3:	LD	(IX+0),0FFH		; FIB ID
        LD	(IX+31),B		; directory entry attribute
        LD	(IY+DBBA0-DBB80),C	; parse flags
        LD	(DBB9E),DE		; current parse string pointer to start of parse string
        OR	A			; current drive ?
        JR	NZ,J12D7
        LD	A,(DF23C)		; yep, use driveid current drive
J12D7:	LD	D,A
        CALL	C13BC			; try to parse driveindicator
        OR	A
        JR	Z,J12E9			; no drive specfied, use parameter
        CP	D
        JR	Z,J12E9			; same as parameter,
        LD	D,A
        BIT	7,(IY+DBBA0-DBB80)	; other driveindicator allowed ?
        LD	A,.IDRV
        RET	NZ			; no, quit with invalid drive error
J12E9:	LD	(IX+25),D
        BIT	3,(IX+31)		; parse a volumename ?
        JR	NZ,J12FF		; yep, skip absolutepath check
        CALL	C1782			; get parse string char
        JR	Z,J1304			; end of parse string,
        CP	"\"
        JR	NZ,J1304		; no absolute path, undo get and continue
        SET	0,B			; flag characters parsed other than drive name
        SET	1,B			; flag directorypath specified
J12FF:	SET	5,(IY+DBBA0-DBB80)	; flag proces from root
        XOR	A			; no undo
J1304:	CALL	NZ,C179C		; undo, undo get parse string char
        LD	DE,(DBB9E)
        LD	(DBB9C),DE		; last item pointer = current parsestring pointer
        CALL	C16BC			; initialize pathbuffer
        BIT	3,(IX+31)		; parse a volumename ?
        JR	Z,J1320			; nope,
        LD	DE,IB926
        CALL	C13E9
        JR	J1391

J1320:	LD	DE,IB926
        CALL	C13FF			; parse filename
        CP	"\"			; item terminated by a pathitem seperator ?
        JR	NZ,J1366		; nope, this is the filename item
        SET	1,B			; flag any directory path specified
        CALL	C1782			; get parse string char (skip over "\" char)
        LD	DE,(DBB9E)
        LD	(DBB9C),DE		; last item pointer = current parsestring pointer
        LD	DE,IB926
        CALL	C14CB
        JR	NZ,J13A6		; error,
        LD	DE,IB926
        CALL	C16E7			; evaluate pathitem and update pathbuffer
        JR	Z,J1320			; no error, next item
        JR	J13A6			; error, quit

;	  Subroutine parse filename (without driveindicator)
;	     Inputs  A = driveid, C b0 no check for devicenames, b1 empty last item implies *.*, B = entry attribute, DE = pointer to parse string, IX = pointer to FIB
;	     Outputs ________________________

C1349:	LD	(IX+0),0FFH		; FIB ID
        LD	(IX+31),B		; directory entry attribute
        LD	(IX+25),A		; driveid
        LD	(IY+DBBA0-DBB80),C	; flags
        LD	(DBB9E),DE		; current parse string pointer to start of parse string
        LD	(DBB9C),DE		; last item pointer = start of parse string
        LD	B,0			; reset parse flags
        LD	DE,IB926
        CALL	C13FF			; parse filename
J1366:	LD	A,B
        AND	18H
        JR	NZ,J1383		; filename or fileextension specified,
        BIT	1,(IY+DBBA0-DBB80)	; empty last item implies *.* ?
        JR	Z,J1383			; nope, leave last item empty
        PUSH	HL
        PUSH	BC
        LD	HL,I13B1
        LD	DE,IB926
        LD	BC,11
        LDIR				; use *.* as filename/extension
        POP	AF
        OR	39H
        LD	B,A			; flag filename specfied, extension specfied, last item ambiguous
        POP	HL
J1383:	XOR	A			; deviceflags for a file
        BIT	0,(IY+DBBA0-DBB80)	; check for devicenames ?
        LD	DE,IB926
        CALL	Z,C14F4			; yep, check if device and get deviceflags
        OR	A
        JR	NZ,J139D		; it is a device, skip
J1391:	SET	4,(IY+DBBA0-DBB80)	; flag b4
        LD	DE,IB926
        CALL	C14CB
        JR	NZ,J13A6		; error, quit
J139D:	LD	(IX+30),A		; deviceflags
        LD	DE,IB926
        CALL	C16E7			; evaluate pathitem and update pathbuffer
J13A6:	PUSH	AF
        CALL	C1782			; get parse string char
        CALL	NZ,C179C		; not end of parse string, undo get parse string char
        LD	C,A			; terminator char
        POP	AF
        OR	A
        RET

I13B1:	defb	"???????????"

;	  Subroutine __________________________
;	     Inputs  ________________________
;	     Outputs ________________________

C13BC:	LD	(IY+DBBA1-DBB80),00H	; reset parse string charflags
        CALL	C1782			; get parse string char
        JR	Z,J13E6			; end of parse string, quit
        BIT	1,(IY+DBBA1-DBB80)
        JR	NZ,J13E3		; 1st double byte char, undo get and quit
        SUB	"A"
        JR	C,J13E3			; not a driveletter, undo get and quit
        CP	1AH
        JR	NC,J13E3		; not a driveletter, undo get and quit
        INC	A
        LD	B,A
        CALL	C1782			; get parse string char
        JR	Z,J13E3			; end of parse string, no drive specifier
        CP	":"			; driveletter seperator ?
        LD	A,B			; driveid
        LD	B,04H
        RET	Z			; yep, flag driveindicator found
        CALL	C179C			; undo get parse string char
J13E3:	CALL	C179C			; undo get parse string char
J13E6:	XOR	A
        LD	B,A
        RET

;	  Subroutine __________________________
;	     Inputs  ________________________
;	     Outputs ________________________

C13E9:	PUSH	HL
        EX	DE,HL
        LD	A,B
        AND	07H
        LD	B,A
        LD	(IY+DBBA1-DBB80),09H	; supress upcasing, volumename
        LD	C,0BH
        CALL	C146C
        DEC	D
        JR	NZ,J13FD
        SET	3,B
J13FD:	POP	HL
        RET

;	  Subroutine parse filename
;	     Inputs  DE = pointer to buffer, B = parse flags
;	     Outputs ________________________

C13FF:	PUSH	HL
        EX	DE,HL
        LD	A,B
        AND	07H			; reset parse flags
        LD	B,A
        LD	(IY+DBBA1-DBB80),00H	; reset parse string charflags
        LD	C,8
        CALL	C1782			; get parse string char
        JR	Z,J1454
        CP	"."
        JR	NZ,J1451
        LD	D,1			; D=1
        CALL	C1782			; get parse string char
        JR	Z,J143A			; end of string,
        BIT	4,(IY+DBBA1-DBB80)
        JR	Z,J144E			; not a invalid char,
        CP	"."
        JR	NZ,J1437
        SET	7,B			; flag last item is ..
        INC	D			; D=2
        CALL	C1782			; get parse string char
        JR	Z,J143A			; end of string
        BIT	4,(IY+DBBA1-DBB80)
        JR	Z,J1449			; not a invalid char,
        CP	"."
        JR	Z,J1449			; ..., not a relative path
J1437:	CALL	C179C			; undo get parse string char
J143A:	LD	(HL),"."
        INC	HL
        DEC	C
        DEC	D
        JR	NZ,J143A
        SET	6,B			; flag last item is . or ..
        SET	3,B			; flag main filename is specified
        SET	0,B			; flag parse any other chat than drive specifier
        JR	J1454

J1449:	RES	7,B
        CALL	C179C			; undo get parse string char
J144E:	CALL	C179C			; undo get parse string char
J1451:	CALL	C179C			; undo get parse string char
J1454:	CALL	C146C
        DEC	D
        JR	NZ,J145C
        SET	3,B			; flag main filename is specified
J145C:	CP	"."
        JR	NZ,J1465
        SET	4,B			; flag extention filename is specified
        CALL	C1782			; get parse string char
J1465:	LD	C,3
        CALL	C146C
        POP	HL
        RET

;	  Subroutine __________________________
;	     Inputs  ________________________
;	     Outputs ________________________

C146C:	LD	D,0
        INC	C
        CALL	C1782			; get parse string char
        JR	Z,J14C4
        CALL	C179C			; undo get parse string char
        CP	" "
        JR	Z,J14C4
        DEC	C
J147C:	INC	C
J147D:	CALL	C1782			; get parse string char
        JR	Z,J14C4
        BIT	1,(IY+DBBA1-DBB80)
        JR	Z,J1490			; not the 1st double byte char
        DEC	C
        DEC	C
        JR	NZ,J148E
        LD	A," "
J148E:	INC	C
        INC	C
J1490:	BIT	4,(IY+DBBA1-DBB80)
        JR	NZ,J14C1		; invalid char,
        BIT	3,(IY+DBBA1-DBB80)
        JR	NZ,J14AC		; volumename,
        BIT	2,(IY+DBBA1-DBB80)
        JR	NZ,J14AC		; 2nd double byte char,
        CP	"*"
        JR	Z,J14B7
        CP	"?"
        JR	NZ,J14AC
J14AA:	SET	5,B			; flag last item ambiguous
J14AC:	SET	0,B			; flag parse any other chat than drive specifier
        LD	D,1
        DEC	C
        JR	Z,J147C
        LD	(HL),A
        INC	HL
        JR	J147D

J14B7:	LD	A,C
J14B8:	LD	C,A
        DEC	A
        JR	Z,J14AA
        LD	(HL),"?"
        INC	HL
        JR	J14B8

J14C1:	CALL	C179C			; undo get parse string char
J14C4:	DEC	C
        RET	Z
        LD	(HL)," "
        INC	HL
        JR	J14C4

;	  Subroutine __________________________
;	     Inputs  ________________________
;	     Outputs ________________________

C14CB:	XOR	A
        BIT	3,(IY+DBBA0-DBB80)
        RET	Z			; b3 reset, quit
        PUSH	DE
        BIT	6,(IY+DBBA0-DBB80)
        SET	6,(IY+DBBA0-DBB80)	; b6 set
        CALL	Z,C151A			; b6 was reset, register directory operating on
        POP	DE
        OR	A
        RET	NZ			; error, quit
        BIT	4,(IY+DBBA0-DBB80)
        JR	Z,J14EF			; b4 reset, find directory
        BIT	0,(IY+DBBA0-DBB80)
        RET	Z			; b0 reset, quit
        LD	A,B
        AND	18H
        RET	Z			; no main filename or extension filename, quit
J14EF:	CALL	C15A6			; find directory
        OR	A
        RET

;	  Subroutine __________________________
;	     Inputs  DE = pointer to name
;	     Outputs A = deviceflags, HL = pointer to deviceentry if device, else unchanged, BC = unchanged

C14F4:	PUSH	BC
        PUSH	HL
        CALL	C1698			; check if devicename
        LD	A,0			; no deviceflags
        JR	NC,J1517		; not a device, quit
        POP	AF			; discharge HL
        LD	(IX+26),L
        LD	(IX+27),H		; device entry pointer
        PUSH	HL
        LD	C,(HL)
        INC	HL
        LD	B,(HL)
        LD	(IX+28),C
        LD	(IX+29),B		; device jumptable pointer
        LD	BC,7
        ADD	HL,BC
        LD	A,(HL)			; deviceflags
J1517:	POP	HL
        POP	BC
        RET

;	  Subroutine register directory operating on
;	     Inputs  IX = pointer to drivetable
;	     Outputs ________________________

C151A:	PUSH	BC
        LD	C,(IX+25)
        LD	B,0			; for disk
        CALL	C31AB			; check diskchange
        POP	BC
        OR	A
        RET	NZ			; error, quit
        PUSH	BC
        PUSH	HL
        BIT	5,(IY+DBBA0-DBB80)
        JR	NZ,J1597		; b5 set, register rootdir as directory operating on
        LD	DE,30
        ADD	HL,DE
        LD	E,(HL)
        INC	HL
        CALL	CLST_1
        JR	NZ,J1597		; rootdir, register rootdir as directory operating on
        LD	BC,(DBB9E)
        PUSH	BC			; save current parsestring pointer
        PUSH	HL
        LD	A,D
        OR	E
        JR	Z,J1547			; cluster 0, leave b3
        RES	3,(IY+DBBA0-DBB80)	; b3 reset
J1547:	INC	HL
        LD	(DBB9E),HL		; current parsestring pointer = current directorypath in drivetable
        LD	BC,-32
        ADD	HL,BC			; drivetable pointer
        PUSH	DE
        CALL	C159F			; initialize
        POP	DE
        LD	B,0			; reset parse flags
J1556:	PUSH	DE
        LD	DE,IB910
        CALL	C13FF			; parse filename
        BIT	3,(IY+DBBA0-DBB80)
        JR	Z,J156E			; b3 reset,
        LD	DE,IB910
        CALL	C15A6			; find directory
        OR	A
        JR	NZ,J157E		; error, current directory is rootdir and quit
        POP	AF
        PUSH	DE
J156E:	LD	DE,IB910
        CALL	C16E7			; evaluate pathitem and update pathbuffer
        JR	NZ,J157E		; error, current directory is rootdir and quit
        POP	DE
        CALL	C1782			; get parse string char
        JR	NZ,J1556		; not the end of the parse string, continue
        JR	J1582			; set current directory

J157E:	POP	DE
        LD	DE,0FFFFH		; rootdir
J1582:	POP	HL
        LD	(HL),D
        DEC	HL
        LD	(HL),E
        POP	BC
        LD	(DBB9E),BC		; restore parsestring pointer
        CALL	CLST_2
        NOP
        NOP
        NOP
        JR	Z,J1597
        INC	HL
        INC	HL
        LD	(HL),00H		; rootdir, nul string for current directorypath
J1597:	POP	HL
        POP	BC
        JR	NZ,C159F
        JP	C1C4A			; register cluster as directory operating on

;	  Subroutine __________________________
;	     Inputs  ________________________
;	     Outputs ________________________

C159F:	CALL	C16BC			; initialize pathbuffer
        JP	C1C47			; register rootdir as directory operating on

;	  Subroutine find directory
;	     Inputs  ________________________
;	     Outputs ________________________

C15A6:	LD	A,.IPATH
        BIT	3,B
        RET	Z			; item has no main filename, quit with "invalid path" error
        BIT	5,B
        RET	NZ			; item is ambiguous, quit with "invalid path" error
        PUSH	DE
        CALL	C1C5D			; get first directory entry
J15B2:	JR	Z,J15C9			; unused directory entry found, quit with "directory not found" error
        EX	(SP),HL
        PUSH	HL
        PUSH	BC
        XOR	A			; do not search volumename directoryentry
        CALL	C15D2			; does directoryentry match the search ?
        POP	BC
        POP	HL
        EX	(SP),HL
        JR	NC,J15C4		; nope, next
        BIT	4,A
        JR	NZ,J15CD		; directory, bingo
J15C4:	CALL	C1C94			; get next directory entry
        JR	NC,J15B2		; there is, try that one
J15C9:	POP	DE
        LD	A,.NODIR		; quit with "directory not found" error
        RET

J15CD:	POP	AF			; discharge from stack
        JP	C1C3A			; register startcluster of directoryentry as directory operating on

;	  Subroutine does directory entry match the search
;	     Inputs  DE = pointer to directoryentry, HL = pointer to searchstring, A(b3) = volume
;	     Outputs Cx set if match, Zx set if free entry or matched

C15D2:	AND	08H
        LD	C,A			; set volume bit of character flag
        LD	A,(DE)
        OR	A
        RET	Z			; unused directoryentry, quit
        CP	0E5H
        RET	Z			; deleted file directoryentry, quit
        PUSH	DE
        LD	B,11
        CP	05H
        JR	NZ,J15E4
        LD	A,0E5H			; replacement char
J15E4:	PUSH	AF
        LD	A,(HL)
        CALL	C17AE			; check character
        POP	AF
        BIT	3,C
        JR	NZ,J15FA		; volume, no check on name
        SUB	(HL)			; matches the one to find ?
        JR	Z,J15FA			; yep, next char
        BIT	2,C
        JR	NZ,J1609		; 2nd byte of double byte char, no match and quit
        LD	A,(HL)
        SUB	"?"			; wildcard char ?
        JR	NZ,J1609		; nope, flag no match and quit
J15FA:	INC	HL
        INC	DE
        LD	A,(DE)
        DJNZ	J15E4			; next
        EX	DE,HL
        LD	A,C
        XOR	(HL)
        AND	08H			; is volume attribute bit of correct value ?
        JR	NZ,J1609		; nope, flag no match and quit
        LD	A,(HL)			; directoryentry attribute
        SCF				; flag match
        DEFB	006H			; ld b,xx
J1609:	OR	A
        POP	DE
        RET

;	  Subroutine copy name and expand wildcard
;	     Inputs  HL = source, DE = current directory entry, BC = destination
;	     Outputs ________________________

C160C:	PUSH	BC
        EX	(SP),IX
        LD	BC,0B00H		; 11 chars, reset all charflags
        LD	A,(DE)
        CP	05H
        JR	NZ,J1619
        LD	A,0E5H
J1619:	PUSH	DE
        LD	D,A
        LD	A,(HL)
        CALL	C17AE			; check character
        BIT	2,C
        JR	NZ,J1628		; 2nd char of double byte char, copy
        CP	"?"
        JR	NZ,J1628		; no wildcard char, copy
        LD	A,D			; wildcard, use the one from the directoryentry
J1628:	LD	(IX+0),A
        POP	DE
        INC	DE
        INC	HL
        INC	IX
        LD	A,(DE)
        DJNZ	J1619			; next char
        EX	(SP),IX
        POP	BC
        RET

;	  Subroutine __________________________
;	     Inputs  ________________________
;	     Outputs ________________________

C1637:	PUSH	AF
        CALL	C2553			; check if special subdir directory entry
        POP	BC
        JR	NC,J1640		; not a special subdir directory entry,
        XOR	A
        RET

J1640:	PUSH	HL
        PUSH	DE
        LD	A,B
        OR	A
        CALL	NZ,C1698		; check if devicename
        POP	HL
        LD	A,.IDEV
        JR	C,J1666			; devicename, quit with "illegal device" error
        LD	BC,0B09H		; 11 chars, supress upcasing, volumename
        BIT	3,(IX+31)		; volumename ?
        JR	NZ,J1662		; yep,
        LD	BC,0800H		; 8 chars, clear charflags
        LD	A," "			; endmarker is space
        CALL	C1669			; validate name
        JR	NZ,J1666		; error, quit
        LD	BC,0300H		; 3 chars, clear charflags
J1662:	XOR	A			; endmarker is end of string
        CALL	C1669			; validate name
J1666:	POP	HL
        OR	A
        RET

;	  Subroutine validate name
;	     Inputs  HL = pointer, A = endmarker, B = maximium length, C = charflags
;	     Outputs ________________________

C1669:	CP	(HL)
        JR	Z,J1694			; begins with end marker, quit with error
J166C:	LD	A,(HL)
        CALL	C17AE			; check character
        LD	(HL),A
        INC	HL
        BIT	4,C
        JR	NZ,J168C		; invalid char,
        BIT	2,C
        JR	NZ,J1686		; 2nd char of double byte char, copy ok
        BIT	3,C
        JR	NZ,J1686		; volumename, copy ok
        CP	"?"
        JR	Z,J1694
        CP	"*"
        JR	Z,J1694			; wildcard chars, quit with error
J1686:	DJNZ	J166C			; next
        JR	J1692			; all ok

J168A:	LD	A,(HL)
        INC	HL
J168C:	CP	" "
        JR	NZ,J1694		; other invalid char, quit with error
        DJNZ	J168A			; spaces are ignored
J1692:	XOR	A
        RET

J1694:	LD	A,.IFNM
        OR	A
        RET

;	  Subroutine check if devicename
;	     Inputs  DE = pointer to string
;	     Outputs Cx set if devicename, Cx reset if no devicename, HL = pointer to deviceentry, DE = unchanged

C1698:	LD	HL,(DBBF4)		; start of device chain
        PUSH	HL
J169C:	POP	HL
        LD	A,H
        OR	L
        RET	Z			; end of chain, quit
        LD	C,(HL)
        INC	HL
        LD	B,(HL)			; pointer to next device block
        INC	HL
        PUSH	BC
        PUSH	HL
        PUSH	DE
        LD	BC,9
        ADD	HL,BC
        LD	B,8
J16AD:	LD	A,(DE)
        CP	(HL)
        JR	NZ,J16B5
        INC	DE
        INC	HL
        DJNZ	J16AD
J16B5:	POP	DE
        POP	HL
        JR	NZ,J169C		; next device block
        POP	BC
        SCF
        RET

;	  Subroutine initialize pathbuffer
;	     Inputs  ________________________
;	     Outputs ________________________

C16BC:	PUSH	HL
        LD	HL,IB931+66
        LD	(HL),2			; mark end of pathbuffer
        LD	HL,IB931
        LD	(HL),0			; mark start of pathbuffer
        INC	HL
        LD	(DBB9A),HL		; pathbuffer pointer at start of buffer
        POP	HL
        LD	(IY+DBB99-DBB80),0	; no error in pathbuffer

;	  Subroutine make endmarker in pathbuffer
;	     Inputs  ________________________
;	     Outputs ________________________

C16D0:	PUSH	HL
        LD	A,2
        LD	HL,(DBB9A)
        CP	(HL)			; end of pathbuffer ?
        JR	Z,J16E3			; yep, NODIR error
        LD	(HL),0			; path endmarker
        INC	HL
        CP	(HL)			; end of pathbuffer ?
        JR	Z,J16E1
        LD	(HL),0			; extra path endmarker
J16E1:	LD	A,2AH
J16E3:	ADD	A,0D6H
        POP	HL
        RET

;	  Subroutine evaluate pathitem and update pathbuffer
;	     Inputs  DE = pointer to pathitem, B = parseflags
;	     Outputs ________________________

C16E7:	PUSH	BC
        PUSH	HL
        LD	HL,(DBB9A)
        LD	A,B
        AND	18H			; filename or filetype specified ?
        JR	Z,J172F			; nope (end of path), quit
        BIT	6,B			; last item "." or ".." ?
        JR	Z,J1706			; nope, pathitem
        BIT	7,B			; last item ".." ?
        JR	Z,J1723			; nope, do "." action
                                        ; ".." action
J16F9:	DEC	HL
        LD	A,(HL)
        CP	1			; start of pathitem reached ?
        JR	Z,J1723			; yep,
        OR	A			; start of buffer reached ?
        JR	NZ,J16F9		; nope, continue
        LD	A,.IPATH
        JR	J172B			; invalid path error

J1706:	PUSH	HL
        LD	HL,IB901
        PUSH	HL
        LD	(HL),1			; start of pathitem indicator
        INC	HL
        LD	A,(DE)
        CALL	C173A			; make ASCIIZ string of name
        POP	DE			; start of pathitem buffer
        POP	HL
J1714:	LD	A,(HL)
        CP	2			; end of buffer reached ?
        LD	A,.PLONG
        JR	Z,J172B			; yep, path too long error
        LD	A,(DE)
        LD	(HL),A
        INC	HL
        INC	DE
        OR	A
        JR	NZ,J1714		; copy pathitem buffer
        DEC	HL
J1723:	LD	(DBB9A),HL
        CALL	C16D0			; make endmarker in pathbuffer
        JR	Z,J172F			; no error, skip flag error
J172B:	LD	(IY+DBB99-DBB80),0FFH	; flag error in path
J172F:	POP	HL
        POP	BC
        BIT	2,(IY+DBBA0-DBB80)
        JR	Z,J1738			; keep error
        XOR	A			; b2 set, no error
J1738:	OR	A
        RET

;	  Subroutine make ASCIIZ string of name
;	     Inputs  A = first char, HL = pointer to buffer
;	     Outputs ________________________

C173A:	PUSH	BC
        PUSH	HL
        LD	B,13
J173E:	LD	(HL),00H
        INC	HL
        DJNZ	J173E			; clear buffer
        POP	HL
        LD	BC,0B09H		; 11 chars, supress upcasing, volumename
        BIT	3,(IX+31)		; volumename ?
        JR	NZ,J175A		; yep,
        LD	BC,0800H		; 8 chars, clear char flags
        CALL	C176A			; copy name without spaces
        LD	(HL),"."
        INC	HL
        LD	A,(DE)			; first char of fileextension
        LD	BC,0300H		; 3 chars, clear char flags
J175A:	CALL	C176A
        BIT	7,C
        JR	NZ,J1768		; something was copied (file has extensionname), ok
        BIT	0,C
        JR	NZ,J1768		; volumename, ok
        DEC	HL
        LD	(HL),00H		; replace the "." with the endmarker
J1768:	POP	BC
        RET

;	  Subroutine copy name without spaces
;	     Inputs  DE = pointer to directoryentry+1, HL = buffer, B = maximium length, C = charflags
;	     Outputs ________________________

C176A:	INC	DE
        CALL	C17AE			; check character
        BIT	2,C
        JR	NZ,J177A		; 2nd char of double byte char, copy
        BIT	3,C
        JR	NZ,J177A		; volumename, copy
        CP	" "
        JR	Z,J177E			; spaces are skipped
J177A:	SET	7,C			; flag something copied
        LD	(HL),A
        INC	HL
J177E:	LD	A,(DE)
        DJNZ	C176A			; next
        RET

;	  Subroutine get parse string char
;	     Inputs  ________________________
;	     Outputs ________________________

C1782:	PUSH	HL
        LD	HL,(DBB9E)		; current parse string pointer
        LD	A,(HL)
        OR	A
        JR	Z,J178E			; endmarker, do not update pointer (so endmarker is read again)
        INC	HL
        LD	(DBB9E),HL		; update current parse string pointer
J178E:	POP	HL
        PUSH	BC
        LD	C,(IY+DBBA1-DBB80)	; char flags
        CALL	C17AE			; check character
        LD	(IY+DBBA1-DBB80),C	; save char flags
        POP	BC
        OR	A
        RET

;	  Subroutine undo get parse string char
;	     Inputs  ________________________
;	     Outputs ________________________

C179C:	PUSH	HL
        LD	HL,(DBB9E)
        DEC	HL
        LD	(DBB9E),HL		; update current parse string pointer
        RES	1,(IY+DBBA1-DBB80)
        RES	2,(IY+DBBA1-DBB80)	; reset parse string double byte flags
        POP	HL
        RET

;	  Subroutine check character
;	     Inputs  C = charflags (b0 set, suppress upcasing, b1 set 1st double byte char, b2 set 2nd double byte char, b3 set volumename)
;	     Outputs ________________________

C17AE:	RES	4,C			; not a endmarker
        SET	2,C			; assume 2nd double byte char
        BIT	1,C			; previous was double byte header char ?
        RES	1,C			; not in a double byte char sequence
        JR	NZ,J17D1		; yep, this is the 2nd byte, quit
        RES	2,C			; not a 2nd double byte char
        SET	1,C			; assume 1st double byte char
        CALL	C17D6			; check for double byte header char
        JR	C,J17D1			; yep, quit
        RES	1,C			; not a 1st double byte char
        BIT	0,C			; upcase flag ?
        CALL	Z,C17FD			; yep, make upcase
        BIT	3,C			; volumename flag
        CALL	C180D			; check for illegal chars
        JR	NC,J17D1		; ok,
        SET	4,C
J17D1:	OR	A
        RET	NZ
        SET	4,C			; flag endmarker
        RET

;	  Subroutine check for double byte header char
;	     Inputs  ________________________
;	     Outputs ________________________
;	     Remark  extra routine in dos 2.31

C17D6:	PUSH	HL
        LD	HL,I17DC
        JR	J17E7

I17DC:	DEFB	080H,0A0H
        DEFB	0E0H,0FDH

;	  Subroutine check for double byte header char if enabled
;	     Inputs  ________________________
;	     Outputs ________________________

C17E0:	CALL	CF258
        PUSH	HL
        LD	HL,IF30F
J17E7:	CP	(HL)
        INC	HL
        JR	C,J17EE
        CP	(HL)
        JR	C,J17F6
J17EE:	INC	HL
        CP	(HL)
        JR	C,J17FA
        INC	HL
        CP	(HL)
        JR	NC,J17FA
J17F6:	OR	A
        SCF
        POP	HL
        RET

J17FA:	OR	A
        POP	HL
        RET

;	  Subroutine make upcase
;	     Inputs  ________________________
;	     Outputs ________________________

C17FD:	PUSH	HL
        LD	HL,IBA75
        CALL	CF255
        PUSH	BC
        LD	B,0
        LD	C,A
        ADD	HL,BC
        LD	A,(HL)
        POP	BC
        POP	HL
        RET

;	  Subroutine check for illegal chars
;	     Inputs  Zx set = filename, Zx reset = volumename
;	     Outputs ________________________

C180D:	PUSH	HL
        PUSH	BC
        LD	BC,17
        LD	HL,I1826
        JR	Z,J181A
        LD	BC,6
J181A:	CP	20H
        JR	C,J1822
        CPIR
        JR	NZ,J1823
J1822:	SCF
J1823:	POP	BC
        POP	HL
        RET

I1826:	defb	07FH,'|<>/',0FFH,' :;.,=+\"[]'

;	  Subroutine _GETCD
;	     Inputs  ________________________
;	     Outputs ________________________

A1836:	LD	A,B			; driveid
        LD	B,0			; normal file
        LD	IX,IB9DA
        LD	C,09H			; no devicename check, empty last item does not imply *.*, report path errors, b3=1, other driveindicator allowed
        PUSH	DE
        LD	DE,I184C
        CALL	C12C3			; parse (with driveindicator)
        POP	DE
        RET	NZ			; error, quit
        JP	A189D

I184C:	defb	0

;	  Subroutine _CHDIR
;	     Inputs  ________________________
;	     Outputs ________________________

A184D:	XOR	A			; default driveid
        LD	B,A			; normal file
        LD	IX,IB9DA
        LD	C,09H			; no devicename check, empty last item does not imply *.*, report path errors, b3=1, other driveindicator allowed
        CALL	C12C3			; parse (with driveindicator)
        RET	NZ			; error, quit
        OR	C
        LD	A,.IPATH
        RET	NZ			; not at end of string, quit with "illegal path" error
        LD	BC,30
        ADD	HL,BC
        LD	DE,(DBBE8)
        LD	(HL),E
        INC	HL
        LD	(HL),D			; start cluster current directory = start cluster directory operating on
        INC	HL
        EX	DE,HL
        JP	A189D

;	  Subroutine _PARSE
;	     Inputs  ________________________
;	     Outputs ________________________

A186D:	LD	C,04H			; devicename check, empty last item does not imply *.*, report no path errors, b3=0, other driveindicator allowed
        LD	IX,IB9DA
        XOR	A			; default driveid
        CALL	C12C3			; parse (with driveindicator)
        LD	C,(IX+25)		; logical drive
        LD	DE,(DBB9E)		; pointer to terminator char = current parse string pointer
        LD	HL,(DBB9C)		; pointer to last item
        RET

;	  Subroutine _PFILE
;	     Inputs  ________________________
;	     Outputs ________________________

A1882:	PUSH	HL
        LD	(DBB9E),DE		; current parse string pointer = pointer to parse string
        EX	DE,HL
        LD	B,0			; reset parse flags
        CALL	C13FF			; parse filename
        LD	DE,(DBB9E)		; pointer to terminator char = current parse string pointer
        POP	HL
        XOR	A
        RET

;	  Subroutine _CHKCHR
;	     Inputs  ________________________
;	     Outputs ________________________

A1894:	LD	A,E
        LD	C,D
        CALL	C17AE			; check character
        LD	D,C
        LD	E,A
        XOR	A
        RET

;	  Subroutine _WPATH
;	     Inputs  ________________________
;	     Outputs ________________________

A189D:	PUSH	DE
        LD	HL,IB931+2		; pointer to first pathitem
        LD	C,0
        PUSH	DE
        LD	A,(DBB99)
        OR	A			; error in path ?
        JR	NZ,J18C1		; yep, return path too long error
J18AA:	LD	A,(HL)
        INC	HL
        CP	2			; end of pathbuffer reached (without a endmarker) ?
        JR	Z,J18C1			; yep, return path too long error
        CP	1			; start of a next pathitem ?
        JR	NZ,J18BA		; nope, copy
        POP	AF			; discharge last item pointer
        LD	A,"\"			; pathitem seperator
        INC	DE
        PUSH	DE			; save new last item pointer
        DEC	DE
J18BA:	LD	(DE),A
        INC	DE
        OR	A			; end of path ?
        JR	NZ,J18AA		; copy next
        JR	J18C3			; quit without error

J18C1:	LD	A,.PLONG
J18C3:	POP	HL
        POP	DE
        RET

;	  Subroutine _FFIRST
;	     Inputs  DE = pointer to drive/path/file string or FIB, HL = pointer to filename string (if DE points to a FIB), IX = pointer to new FIB, B = search attributes
;	     Outputs ________________________

A18C6:	LD	A,4			; search directory entry
        JR	J18CB

;	  Subroutine _FNEW
;	     Inputs  DE = pointer to drive/path/file string or FIB, HL = pointer to filename string (if DE points to a FIB), IX = pointer to new FIB, B(b7) create new, B(b6-b0) = attributes
;	     Outputs ________________________

A18CA:	XOR	A			; create directory entry
J18CB:	LD	(DBBAF),A
        LD	A,(DE)
        INC	A
        JR	Z,J18DF			; parameter is a FIB,
        XOR	A			; default driveid
        LD	C,0AH			; devicename check, empty last item implies *.*, report path errors, b3=1, other driveindicator allowed
        CALL	C12C3			; parse (with driveindicator)
        RET	NZ			; error, quit
        OR	C
        LD	A,.IPATH
        RET	NZ			; not terminated by a NUL, quit with invalid path error
        JR	J1929

J18DF:	PUSH	HL
        PUSH	DE
        EX	(SP),IX			; IX = pointer to source FIB
        CALL	C1A02			; get directoryentry from FIB info with diskchange check
        LD	C,(IX+25)		; driveid
        POP	IX			; IX = pointer to new FIB
        JP	NZ,J1977		; error,
        LD	A,.IDEV
        JP	C,J1977			; device, quit with invalid device operation error
        PUSH	HL
        LD	HL,11
        ADD	HL,DE
        LD	A,(HL)
        POP	HL
        BIT	4,A			; directoryentry a subdirectory ?
        LD	A,.IATTR
        JR	Z,J1977			; nope, quit with invalid attribute error
        BIT	3,B			; volumename requested ?
        JR	NZ,J1977		; yep, quit with invalid attribute error (volumename can only exists in the rootdirectory)
        CALL	C1C3A			; register startcluster of directoryentry as directory operating on
        PUSH	BC
        PUSH	HL
        LD	BC,25
        ADD	HL,BC			; pointer to diskserial of drivetable
        PUSH	IX
        POP	DE
        EX	DE,HL
        LD	BC,26
        ADD	HL,BC
        EX	DE,HL			; pointer to diskserial of FIB
        LD	BC,4
        LDIR				; update diskerial of FIB
        POP	HL			; drivetable
        POP	BC			; attribute
        POP	DE			; pointer to filename string
        LD	A,C
        LD	C,4EH			; devicename check, empty last item implies *.*, report no path errors, b3=1, b6=1, other driveindicator allowed
        CALL	C1349			; parse file (without driveindicator)
        RET	NZ			; error, quit
        OR	C
        LD	A,.IPATH
        RET	NZ			; terminator char not a NUL, quit with "invalid path" error

J1929:	BIT	2,(IY+DBBAF-DBB80)
        JR	NZ,J195F		; search only flag,
        BIT	5,B			; filename ambiguous ?
        JR	Z,J195F			; nope,
        INC	IX
        LD	(DBB9E),IX		; current parse string pointer = filename of FIB
        DEC	IX
        LD	B,0
        LD	DE,IB91B
        CALL	C13FF			; parse filename
        OR	A
        LD	A,.IFNM
        RET	NZ			; error, quit with "invalid filename" error
        PUSH	HL
        LD	HL,IB926
        LD	DE,IB91B
        LD	BC,IB926
        CALL	C160C			; copy name and expand wildcard
        POP	HL
        LD	DE,IB926
        CALL	C14F4			; check if device and get deviceflags
        LD	(IX+30),A		; deviceflags
J195F:	LD	DE,IB926
        PUSH	IX
        EX	(SP),HL
        LD	BC,32
        ADD	HL,BC
        EX	DE,HL
        PUSH	DE
        LD	BC,11
        LDIR
        POP	DE
        POP	HL
        CALL	C1A53			; get directory entry
        JR	J198D

J1977:	POP	DE
        RET

;	  Subroutine _FNEXT
;	     Inputs  ________________________
;	     Outputs ________________________

A1979:	LD	(IY+DBBAF-DBB80),4	; search directory entry
        CALL	C1A02			; get directoryentry from FIB info with diskchange check
        RET	NZ			; error, quit
        PUSH	IX
        EX	(SP),HL
        LD	DE,32
        ADD	HL,DE
        EX	DE,HL
        POP	HL			; pointer to directory entry locator
        CALL	C1A91			; get next directory entry
J198D:	PUSH	AF
        CALL	Z,C1999			; if no error, update FIB with directory entry info
        POP	AF
        CALL	C1A45
        CALL	STOR_7
        RET

;	  Subroutine update FIB with directory entry info
;	     Inputs  IX = pointer to FIB, DE = pointer to directory entry
;	     Outputs ________________________

C1999:	PUSH	IX
        EX	(SP),HL
        PUSH	HL
        INC	HL			; FIB+1
        LD	A,(DE)
        CP	05H
        JR	NZ,J19A5
        LD	A,0E5H
J19A5:	CALL	C173A			; make ASCIIZ string of name
        POP	HL
        LD	BC,14
        ADD	HL,BC
        LD	A,(DE)
        LD	(HL),A			; fileattribute
        EX	DE,HL
        INC	DE
        LD	BC,11
        ADD	HL,BC
        LD	BC,10
        LDIR				; filetime, filedate, filestartcluster and filesize
        POP	HL
        RET

;	  Subroutine search directoryentry
;	     Inputs  ________________________
;	     Outputs ________________________

C19BC:	LD	(IY+DBBAF-DBB80),4	; search directory entry
        LD	B,16H			; directory, system, hidden
        LD	A,(DE)
        INC	A
        JR	Z,J19E8			; parameter is a FIB,
        JR	J19CC			; parameter is a ASCIIZ string

;	  Subroutine create directoryentry
;	     Inputs  ________________________
;	     Outputs ________________________

C19C8:	LD	(IY+DBBAF-DBB80),0	; create directory entry
J19CC:	XOR	A			; default driveid
        LD	IX,IB9DA
        LD	C,08H			; devicename check, empty last item does not imply *.*, report path errors, b3=1, other driveindicator allowed
        CALL	C12C3			; parse (with driveindicator)
        RET	NZ			; error, quit
        OR	C
        LD	A,.IPATH
        RET	NZ			; "illegal path" error
        BIT	5,B
        LD	A,.IFNM
        RET	NZ			; "illegal filename" error
        LD	DE,IB926
        CALL	C1A53			; get directory entry
        JR	J19F7

J19E8:	PUSH	DE
        POP	IX
        CALL	C1A02			; get directoryentry from FIB info with diskchange check
        RET	NZ			; error, quit
        BIT	3,(IX+31)
        LD	A,.IATTR
        RET	NZ			; volumename, quit with "invalid attribute" error
        XOR	A
J19F7:	OR	A
        RET	NZ			; error, quit
        PUSH	HL
        LD	HL,11
        ADD	HL,DE
        LD	A,(HL)			; directoryentry attribute
        POP	HL
        CP	A			; Zx set
        RET

;	  Subroutine get directoryentry from FIB info with diskchange check
;	     Inputs  ________________________
;	     Outputs Zx reset if error, Cx set if device, DE = pointer to directoryentry

C1A02:	PUSH	BC
        BIT	7,(IX+30)		; device ?
        JR	Z,J1A10			; nope,
        CALL	C1A25			; setup fake directoryentry for device
        POP	BC
        XOR	A
        SCF
        RET

J1A10:	CALL	C1A45
        LDIR				; setup directory entry locator with info from FIB
        CALL	STOR_8
        LD	B,1			; for file
        CALL	C31AB			; check diskchange
        POP	BC
        OR	A
        RET	NZ			; error, quit
        CALL	C1C7A			; get current directory entry
        XOR	A
        RET

;	  Subroutine setup fake directoryentry for devices
;	     Inputs  ________________________
;	     Outputs HL = pointer to device entry, DE = pointer to fake direntry device

C1A25:	LD	L,(IX+26)
        LD	H,(IX+27)		; pointer to device entry
        PUSH	HL
        LD	DE,9
        ADD	HL,DE
        PUSH	HL			; pointer to fake direntry for device
        LD	DE,22
        ADD	HL,DE
        EX	DE,HL			; pointer to time field of fake direntry
        PUSH	IX
        POP	HL
        LD	BC,15
        ADD	HL,BC			; modify time/date of FIB
        LD	BC,4
        LDIR				; copy to time/date field of fake direntry
        POP	DE
        POP	HL
        RET

;	  Subroutine get pointer to directoryentry locators
;	     Inputs  IX = pointer to FIB
;	     Outputs HL = pointer to FIB directoryentry locators, DE = pointer to directoryentry locators

C1A45:	LD	DE,DBBDE
        PUSH	IX
        POP	HL
        LD	BC,43
        ADD	HL,BC
        LD	BC,12
        RET

;	  Subroutine get directory entry
;	     Inputs  ________________________
;	     Outputs ________________________

C1A53:	BIT	2,(IY+DBBAF-DBB80)
        JR	NZ,J1A6E		; search only flag,
        PUSH	DE
        LD	A,(IX+31)
        AND	10H			; file (no devicename check) or directory (do devicename check)
        CALL	C1637
        POP	DE
        RET	NZ			; error, quit
        BIT	7,(IX+31)
        JR	Z,J1A6E
        SET	3,(IY+DBBAF-DBB80)	; create new flag
J1A6E:	RES	7,(IX+31)
        LD	(DBBAD),DE
        BIT	7,(IX+30)		; device ?
        JR	NZ,J1A84		; yep,
        CALL	C1C5D			; get first directory entry
        CALL	C1BD2			; search for matching directoryentry
        JR	J1AA3

J1A84:	PUSH	HL
        LD	DE,9
        ADD	HL,DE
        EX	DE,HL
        CALL	C1BA0			; change time and date directoryentry
        POP	HL
        JP	J1B2E

;	  Subroutine get next directory entry
;	     Inputs  ________________________
;	     Outputs ________________________

C1A91:	BIT	7,(IX+30)		; device ?
        LD	A,.NOFIL
        RET	NZ			; yep, quit with "File not found" error
        SET	1,(IY+DBBA9-DBB80)	; actually read sector
        LD	(DBBAD),DE
J1AA0:	CALL	C1BCF			; search next matching directory entry
J1AA3:	JR	C,J1AB1			; match,
        BIT	2,(IY+DBBAF-DBB80)
        LD	A,.NOFIL		; search only, "File not found" error
        CALL	Z,C1C04			; create flag, get free directory entry
        RET	NZ			; error, quit
        JR	J1AF0

J1AB1:	BIT	2,(IY+DBBAF-DBB80)
        JR	Z,J1AC6			; create,
        BIT	3,A
        JR	NZ,J1B2E		; volumename,
        AND	16H
        CPL				; only directory, system or hidden cares
        OR	(IX+31)
        INC	A
        JR	NZ,J1AA0
        JR	J1B2E

J1AC6:	LD	B,A
        BIT	3,(IY+DBBAF-DBB80)	; create new ?
        JR	NZ,J1ADD		; quit with "file exists" error
        BIT	2,B
        LD	A,.SYSX
        JR	NZ,J1B2F		; system attribute, "system file exists" error
        BIT	4,B
        LD	A,.DIRX
        JR	NZ,J1B2F		; directory attribute, "directory exists" error
        BIT	4,(IX+31)
J1ADD:	LD	A,.FILEX
        JR	NZ,J1B2F		; want to create directory but file with same name exists, "file exists" error
        CALL	C1C7A			; get current directory entry
        XOR	A			; delete is not recoverable by UNDEL
        CALL	C2350			; mark current directory entry deleted and remove FAT chain
        PUSH	AF
        CALL	C1C7A			; get current directory entry
        POP	AF
        OR	A
        JR	NZ,J1B2F		; error,
J1AF0:	LD	DE,(DBBAD)
        CALL	C2553			; check if special subdir directory entry
        JR	NC,J1AFB		; not a special subdir directory entry,
        OR	A
        RET

J1AFB:	LD	BC,0
        BIT	4,(IX+31)
        JR	Z,J1B0E			; not a directory, skip subdirectory cluster creation
        LD	A,0FFH			; clear directorycluster
        INC	BC			; 1 cluster
        CALL	C2F5E			; allocate clusters
        RET	NZ			; error, quit
        CALL	C1B31			; setup the first two direntries
J1B0E:	CALL	C1C7A			; get current directory entry
        LD	A,28H			; archive + volume
        BIT	3,(IX+31)
        JR	NZ,J1B26		; volumename,
        LD	A,(IX+31)
        SET	5,A
        BIT	4,A
        JR	Z,J1B24			; file, set archive
        AND	0DAH			; directory, reset archive, system and read-only
J1B24:	AND	3FH			; clear unused bits
J1B26:	PUSH	HL
        LD	HL,(DBBAD)		; filename
        CALL	C1B73			; setup directory entry
        POP	HL
J1B2E:	XOR	A
J1B2F:	CP	A
        RET

;	  Subroutine __________________________
;	     Inputs  ________________________
;	     Outputs ________________________

C1B31:	PUSH	DE
        LD	D,B
        LD	E,C
        XOR	A			; sectoroffset 0
        CALL	C2DD4			; convert clusternumber to sectornumber
        PUSH	HL
        EX	(SP),IX
        PUSH	BC
        LD	B,1			; real read, ignore not recommended
        CALL	BUF_2
        POP	BC
        PUSH	BC
        LD	DE,11
        ADD	HL,DE
        EX	DE,HL
        LD	HL,I1B68		; .
        LD	A,10H			; directory attribute
        CALL	C1B73			; setup directory entry
        LD	HL,32
        ADD	HL,DE
        EX	DE,HL
        LD	HL,I1B67		; ..
        LD	BC,(DBBE8)		; start cluster of directory operating on
        LD	A,10H			; directory attribute
        CALL	C1B73			; setup directory entry
        POP	BC
        EX	(SP),IX
        POP	HL
        POP	DE
        RET

I1B67:	defb	"."
I1B68:	defb	".          "

;	  Subroutine setup directoryentry
;	     Inputs  HL = pointer to filename, DE = pointer to directory entry, BC = cluster, A = attribute
;	     Outputs ________________________

C1B73:	PUSH	DE
        PUSH	BC
        LD	B,A
        LD	A,(HL)
        CP	0E5H			; special char which is used in direntries as deleted file marker ?
        JR	NZ,J1B7D
        LD	A,05H			; yep, use replacement char
J1B7D:	LD	(DE),A
        LD	A,B
        INC	HL
        INC	DE
        LD	BC,10
        LDIR				; copy reset of filename to direntry
        CALL	C2C56			; mark buffer last read as changed
        LD	(DE),A			; fileattribute
        EX	DE,HL
        LD	B,20
J1B8D:	INC	HL
        LD	(HL),C
        DJNZ	J1B8D			; rest of direntry fields clear
        CALL	CLST_8
        JR	Z,J1B98			; subdirectory, use given clusternumber for first cluster
        LD	D,B
        LD	E,B			; rootdirectory, use 0 for first cluster
J1B98:	LD	BC,-4
        ADD	HL,BC
        LD	(HL),D
        DEC	HL
        LD	(HL),E
        POP	DE

;	  Subroutine change time and date directoryentry
;	     Inputs  DE = pointer to directoryentry
;	     Outputs ________________________

C1BA0:	PUSH	HL
        PUSH	BC
        PUSH	DE
        LD	HL,22
        ADD	HL,DE			; time field of directoryentry
        PUSH	HL
        CALL	C111B			; get time and date from clockchip
        EX	(SP),HL
        LD	A,C
        ADD	A,A
        ADD	A,A
        LD	C,3
J1BB1:	ADD	A,A
        RL	B
        DEC	C
        JR	NZ,J1BB1
        SRL	E
        ADD	A,E
        LD	(HL),A
        INC	HL
        LD	(HL),B
        INC	HL
        POP	BC
        LD	A,B
        OR	A
        RRA
        RRA
        RRA
        RRA
        RL	D
        ADD	A,C
        LD	(HL),A
        INC	HL
        LD	(HL),D
        POP	DE
        POP	BC
        POP	HL
        RET

;	  Subroutine search for next matching directoryentry
;	     Inputs  ________________________
;	     Outputs ________________________

C1BCF:	CALL	C1C94			; get next directory entry

;	  Subroutine search for matching directoryentry
;	     Inputs  ________________________
;	     Outputs ________________________

C1BD2:	JR	C,J1BEE			; no more entries, quit
        PUSH	IX
        EX	(SP),HL
        LD	HL,(DBBAD)
        LD	A,(IX+31)		; volumename or filename flag
        CALL	C15D2			; does directoryentry match the search ?
        POP	HL
        RET	C			; yep, quit
        JR	NZ,C1BCF		; not a free entry, next
        BIT	0,(IY+DBBAF-DBB80)
        CALL	Z,C1BF0			; no free entry found yet, register free entry
        OR	A
        JR	NZ,C1BCF
J1BEE:	XOR	A			; Cx reset
        RET

;	  Subroutine register directory entry
;	     Inputs  ________________________
;	     Outputs ________________________

C1BF0:	PUSH	HL
        PUSH	DE
        PUSH	BC
        CALL	C1A45
        EX	DE,HL
        CALL	STOR_1
        LDIR				; save directory entry locator info free entry
        SET	0,(IY+DBBAF-DBB80)	; flag free entry found
        POP	BC
        POP	DE
        POP	HL
        RET

;	  Subroutine get free or registered directory entry
;	     Inputs  ________________________
;	     Outputs ________________________

C1C04:	PUSH	BC
        BIT	0,(IY+DBBAF-DBB80)
        JR	Z,J1C17			; no free directory entry found, try to expand directory
        PUSH	HL
        CALL	C1A45
        CALL	STOR_2
        LDIR				; restore directory entry locator info free entry
        POP	HL
        JR	J1C37			; ok

J1C17:	CALL	CLST_3
        NOP
        NOP
        NOP
        LD	A,.DRFUL
        JR	NZ,J1C38		; current directory is the rootdirectory, quit with "directory full" error
        LD	A,0FFH			; clear directorycluster
        LD	BC,1			; 1 cluster
        CALL	C2F5E			; allocate clusters
        JR	NZ,J1C38		; error, quit
        PUSH	BC
        CALL	C2DF1			; reset deleted files status disk and set FAT entry
        POP	BC
        LD	(DBBE4),BC		; new next directory cluster
        CALL	C1C94			; get next directory entry
J1C37:	XOR	A
J1C38:	POP	BC
        RET

;	  Subroutine register startcluster of directoryentry as directory operating on
;	     Inputs  HL = pointer to directoryentry
;	     Outputs ________________________

C1C3A:	PUSH	HL
        LD	HL,26
        ADD	HL,DE
        LD	E,(HL)
        INC	HL
        LD	D,(HL)			; startcluster
        POP	HL
        LD	A,D
        OR	E
        JR	NZ,C1C4A		; has a startcluster, use it

;	  Subroutine register rootdir as directory operating on
;	     Inputs  ________________________
;	     Outputs ________________________

C1C47:	LD	DE,0FFFFH		; special cluster indicating the rootdir

;	  Subroutine register cluster as directory operating on
;	     Inputs  ________________________
;	     Outputs ________________________

C1C4A:	LD	(DBBE8),DE		; start cluster of directory operating on
        PUSH	HL
        LD	HL,(DBBAB)
        XOR	A
        SBC	HL,DE			; same as start cluster of directoryentry to move ?
        JR	NZ,J1C5B
        SET	1,(IY+DBBAF-DBB80)	; yep, flag move to one of its own descendants
J1C5B:	POP	HL
        RET

;	  Subroutine get first directory entry
;	     Inputs  HL = pointer to drivetable
;	     Outputs ________________________

C1C5D:	CALL	CLST_4
        NOP
        NOP
        NOP
        JR	Z,J1CC4			; subdir, these have no fixed size, handled per cluster
        PUSH	BC
        PUSH	HL
        LD	BC,15
        ADD	HL,BC
        LD	C,(HL)			; Number of direntries of partly rootdirectorysector
        INC	HL
        LD	A,(HL)			; Number of whole rootdirectorysectors
        INC	HL
        INC	HL
        LD	E,(HL)
        INC	HL
        LD	D,(HL)			; first rootdirectory sector
        POP	HL
        LD	B,0FFH
        PUSH	BC			; no next directory cluster
        PUSH	BC			; current directory "cluster" is the rootdirectory
        JR	J1CDE

;	  Subroutine get current directory entry
;	     Inputs  HL = pointer to drivetable
;	     Outputs HL = pointer to drivetable, DE = pointer to directory entry

C1C7A:	PUSH	HL
        LD	DE,8
        ADD	HL,DE
        BIT	7,(HL)
        EX	DE,HL
        INC	DE
        POP	HL
        JP	NZ,J1D29		; b7 driveid set,
        SET	1,(IY+DBBA9-DBB80)	; actually read sector
        INC	(IY+DBBE0-DBB80)
        PUSH	BC
        LD	BC,0
        JR	J1C98

;	  Subroutine get next directory entry
;	     Inputs  HL = pointer to drivetable, DE = pointer to current directory entry
;	     Outputs ________________________

C1C94:	PUSH	BC
        LD	BC,32
J1C98:	PUSH	HL
        EX	DE,HL
        ADD	HL,BC
        LD	DE,(DBBE2)		; current directory sector
        LD	A,(DBBE0)
        DEC	A			; entries left ?
        JR	Z,J1CAE			; nope, try next sector
        BIT	1,(IY+DBBA9-DBB80)
        JP	Z,J1D23			; use the buffer
        JR	J1D03			; actually read the sector in buffer and return

J1CAE:	POP	HL
        CALL	SUB_16
        NOP
        DEC	A			; still sectors left ?
        JR	NZ,J1CEB		; yep, next sector
        CP	(IY+DBBDE-DBB80)	; partly dirsector ?
        JR	NZ,J1CED		; yep, partly (=last) sector
        CALL	CLST_9
        NOP
        NOP
        NOP
        SCF
        POP	BC
        RET	NZ			; nop, then is the end of directory, quit
J1CC4:	PUSH	BC
        PUSH	DE			; cluster
        CALL	FATRED			; get FAT entry content
        LD	B,D
        LD	C,E			; cluster content
        POP	DE			; cluster
        PUSH	DE
        XOR	A			; sectoroffset 0
        CALL	GETSUB
        PUSH	DE
        EX	DE,HL
        LD	HL,10
        ADD	HL,DE
        LD	A,(HL)
        INC	A			; number of whole directorysectors (in this cluster)
        EX	DE,HL
        POP	DE			; sectornumber
        PUSH	BC
        LD	C,0			; no partly direntries
J1CDE:	LD	(IY+DBBDE-DBB80),C
        POP	BC
        LD	(DBBE4),BC		; next directory cluster
        POP	BC
        LD	(DBBE6),BC		; current directory cluster
J1CEB:	LD	B,16
J1CED:	OR	A
        JR	NZ,J1CF7		; not a partly directory sector, 16 entries in sector
        LD	B,(IY+DBBDE-DBB80)	; number of directory entries in partly sector
        LD	(DBBDE),A
        INC	A			; 1 sector
J1CF7:	LD	(DBBE1),A		; number of sectors left
        LD	(DBBE2),DE		; current sector
        LD	(IY+DBBDF-DBB80),B	; number of entries left
        LD	A,B
        PUSH	HL
J1D03:	EX	(SP),IX
        PUSH	AF
        LD	B,1			; real read, ignore not recommended
        CALL	BUF_4
        POP	BC
        EX	(SP),IX
        LD	DE,11-32
        ADD	HL,DE			; to the buffer itself
        LD	A,(DBBDF)
        INC	A
        SUB	B
        LD	DE,32
J1D1A:	ADD	HL,DE
        DEC	A
        JR	NZ,J1D1A
        LD	A,B
        RES	1,(IY+DBBA9-DBB80)	; use the buffer for next get
J1D23:	LD	(DBBE0),A
        EX	DE,HL
        POP	HL
        POP	BC
J1D29:	LD	A,(DE)
        OR	A
        RET

;	  Subroutine write to filehandle
;	     Inputs  ________________________
;	     Outputs ________________________

C1D2C:	EX	AF,AF'
        CALL	C2140			; get fib pointer of filehandle
        RET	NC			; invalid filehandle, quit
        RET	Z			; filehandle not in use, quit
        BIT	7,(IX+30)		; device ?
        JR	Z,J1D43			; nope,
        LD	L,(IX+28)
        LD	H,(IX+29)		; device jumptable
        INC	HL
        INC	HL
        INC	HL			; output entry
        EX	AF,AF'

;	  Subroutine start routine
;	     Inputs  HL = adres routine
;	     Outputs -

C1D42:	JP	(HL)

J1D43:	EX	AF,AF'
        LD	DE,IBBC5
        LD	(DE),A
        LD	BC,1			; recordsize = 1
        LD	A,0FFH			; BDOS segments
        JP	C2771			; write to file

;	  Subroutine read from filehandle
;	     Inputs  ________________________
;	     Outputs ________________________

C1D51:	CALL	C2140			; get fib pointer of filehandle
        RET	NC			; invalid filehandle, quit
        RET	Z			; filehandle not in use, quit
        BIT	7,(IX+30)		; device ?
        JR	Z,J1D77			; nope,
        RES	6,(IX+30)		; reset EOF flag
        LD	L,(IX+28)
        LD	H,(IX+29)		; device jumptable
        PUSH	BC
        CALL	C1D42			; call input routine of device
        POP	DE
        CP	.EOL
        JR	Z,J1D75			; eol, return no error
        BIT	5,E
        RET	NZ			; in ascii mode, quit
        CP	.EOF			; EOF error ?
        RET	NZ			; nope, quit
J1D75:	XOR	A			; no error
        RET

J1D77:	PUSH	BC
        LD	DE,IBBC5
        LD	BC,1			; recordsize = 1
        LD	A,0FFH			; BDOS segments
        CALL	C2775			; read from file
        LD	HL,IBBC5
        LD	B,(HL)
        POP	DE
        OR	A
        RET	NZ			; error, quit
        OR	E
        RET	Z
        LD	A,B
        CP	1AH
        LD	A,.EOF
        RET	Z
        XOR	A
        RET

;	  Subroutine _CREATE
;	     Inputs  ________________________
;	     Outputs ________________________

A1D94:	EX	AF,AF'
        BIT	3,B
        LD	A,.IATTR
        RET	NZ			; volumename, quit with "invalid attribute" error
        CALL	C19C8			; create directoryentry
        RET	NZ			; error, quit
        LD	B,0FFH
        BIT	4,A
        JR	NZ,J1DE6		; subdirectory, do not open and return filehandle 255 (which is invalid)
        JR	J1DB0			; open

;	  Subroutine _OPEN
;	     Inputs  ________________________
;	     Outputs ________________________

A1DA6:	EX	AF,AF'
        CALL	C19BC			; search directoryentry
        RET	NZ			; error, quit
        BIT	4,A			; subdirectory entry
        LD	A,.DIRX
        RET	NZ			; yep, quit with "directory exists" error
J1DB0:	PUSH	HL
        CALL	C212B			; find free filehandle
        JR	NZ,J1DE9		; not found, quit with error
        PUSH	HL
        CALL	C21AD			; create FIB element
        JR	NZ,J1DE8		; error,
        EX	DE,HL
        EX	(SP),HL
        LD	(HL),E
        INC	HL
        LD	(HL),D			; setup filehandle entry with pointer to FIB
        PUSH	BC
        PUSH	DE
        EX	(SP),IX
        POP	HL
        LD	BC,32
        LDIR
        POP	BC
        POP	DE
        LD	(IX+31),06H
        XOR	A
        LD	(IX+45),A
        LD	(IX+46),A
        LD	(IX+47),A
        LD	(IX+48),A		; filepos = 0
        POP	HL
        EX	AF,AF'			; open mode
        CALL	C228E			; setup FIB for open
        CALL	C20F2			; update redirect status
J1DE6:	XOR	A
        RET

J1DE8:	POP	HL
J1DE9:	POP	HL
        RET

;	  Subroutine _CLOSE
;	     Inputs  ________________________
;	     Outputs ________________________

A1DEB:	CALL	C2140			; get fib pointer of filehandle
        RET	NC			; invalid filehandle, quit
        RET	Z			; filehandle not in use, quit
        CALL	C22D7			; free filehandle
        CALL	C20F2			; update redirect status
        JR	J1DFD

;	  Subroutine _ENSURE
;	     Inputs  ________________________
;	     Outputs ________________________

A1DF8:	CALL	C2140			; get fib pointer of filehandle
        RET	NC			; invalid filehandle, quit
        RET	Z			; filehandle not in use, quit
J1DFD:	CALL	C2244			; if file is changed get directory entry and change time/date
        LD	A,(IX+25)
        CALL	C2C5F			; write dirty sectorbuffers of assigned drive
        XOR	A
        RET

;	  Subroutine _DUP
;	     Inputs  ________________________
;	     Outputs ________________________

A1E08:	CALL	C2140			; get fib pointer of filehandle
        RET	NC			; invalid filehandle, quit
        RET	Z			; filehandle not in use, quit
        CALL	C212B			; find free filehandle
        RET	NZ			; not found, quit with error
        CALL	C2166			; increase filehandle count of FIB
        RET	NZ			; error, quit
        LD	(HL),E
        INC	HL
        LD	(HL),D			; pointer to FIB
        CALL	C20F2			; update redirect status
        XOR	A
        RET

;	  Subroutine _READ
;	     Inputs  ________________________
;	     Outputs ________________________

A1E1D:	PUSH	DE
        PUSH	HL
        CALL	C2140			; get fib pointer of filehandle
        POP	BC
        POP	DE
        RET	NC			; invalid filehandle, quit
        RET	Z			; filehandle not in use, quit
        XOR	A			; DOS segments
        CALL	C2775			; read from file
        PUSH	BC
        POP	HL
        RET

;	  Subroutine _WRITE
;	     Inputs  ________________________
;	     Outputs ________________________

A1E2D:	PUSH	DE
        PUSH	HL
        CALL	C2140			; get fib pointer of filehandle
        POP	BC
        POP	DE
        RET	NC			; invalid filehandle, quit
        RET	Z			; filehandle not in use, quit
        XOR	A			; DOS segments
        CALL	C2771			; write to file
        PUSH	BC
        POP	HL
        RET

;	  Subroutine _SEEK
;	     Inputs  ________________________
;	     Outputs ________________________

A1E3D:	EX	AF,AF'
        PUSH	DE
        PUSH	HL
        CALL	C2140			; get fib pointer of filehandle
        POP	DE
        POP	HL
        RET	NC			; invalid filehandle, quit
        RET	Z			; filehandle not in use, quit
        EX	AF,AF'
        PUSH	HL
        LD	HL,0
        LD	BC,0
        OR	A
        JR	Z,J1E6D			; relative to beginning, use pos 0
        LD	L,(IX+45)
        LD	H,(IX+46)
        LD	C,(IX+47)
        LD	B,(IX+48)
        DEC	A
        JR	Z,J1E6D			; relative to current pos, use current filepos
        LD	L,(IX+21)
        LD	H,(IX+22)
        LD	C,(IX+23)
        LD	B,(IX+24)		; relative to end, use pos filesize
J1E6D:	ADD	HL,DE
        EX	(SP),HL
        POP	DE
        ADC	HL,BC
        EX	DE,HL
        LD	(IX+45),L
        LD	(IX+46),H
        LD	(IX+47),E
        LD	(IX+48),D
        XOR	A
        RET

;	  Subroutine _IOCTL
;	     Inputs  ________________________
;	     Outputs ________________________

A1E81:	EX	AF,AF'
        PUSH	DE
        CALL	C2140			; get fib pointer of filehandle
        POP	DE
        RET	NC			; invalid filehandle, quit
        RET	Z			; filehandle not in use, quit
        EX	AF,AF'
        LD	L,(IX+28)
        LD	H,(IX+29)		; device jumptable
        OR	A
        JR	Z,J1EB4			; get filehandle status
        DEC	A
        JR	Z,J1EA2			; set filemode (ascii/binary)
        DEC	A
        JR	Z,J1ED5			; test input ready
        DEC	A
        JR	Z,J1EEB			; test output ready
        DEC	A
        JR	Z,J1F05			; find screensize
J1E9F:	LD	A,.ISBFN
        RET

;	  Subroutine IOCTL set filemode
;	     Inputs  ________________________
;	     Outputs ________________________

J1EA2:	BIT	7,(IX+30)		; device ?
        JR	Z,J1E9F			; nope, return error
        LD	A,(IX+30)
        XOR	E
        AND	0DFH
        XOR	E			; only change the ASCII flag
        RES	6,A			; reset EOF flag
        LD	(IX+30),A

;	  Subroutine IOCTL get status
;	     Inputs  ________________________
;	     Outputs ________________________

J1EB4:	LD	E,(IX+30)		; deviceflags
        XOR	A
        LD	D,A
        BIT	7,E			; device ?
        RET	NZ			; yep, quit

;	  Subroutine get driveid and eof status (file)
;	     Inputs  ________________________
;	     Outputs ________________________

C1EBC:	LD	E,(IX+25)
        DEC	E			; driveid (0 based)
        LD	B,4			; 32 bits
J1EC2:	LD	A,(IX+48)
        CP	(IX+24)
        JR	C,J1ED2			; filesize byte > filepos byte, not eof for sure!
        JR	NZ,J1ED0		; filesize byte < filepos byte, eof for sure!
        DEC	IX
        DJNZ	J1EC2			; next byte
                                        ; filesize = filepos, eof!
J1ED0:	SET	6,E
J1ED2:	XOR	A
        LD	D,A
        RET

;	  Subroutine IOCTL test input ready
;	     Inputs  ________________________
;	     Outputs ________________________

J1ED5:	BIT	1,(IX+49)
        JR	NZ,J1EFA		; file mode no read, return ready
        BIT	7,(IX+30)		; device ?
        JR	NZ,J1EFD		; yep, call test input ready handler of device
        CALL	C1EBC			; get eof status
        BIT	6,E
        JR	NZ,J1EFA		; eof, return ready (????)
        LD	E,00H			; return not ready
        RET

;	  Subroutine IOCTL test output ready
;	     Inputs  ________________________
;	     Outputs ________________________

J1EEB:	BIT	0,(IX+49)
        JR	NZ,J1EFA		; file mode no write, return ready
        INC	HL
        INC	HL
        INC	HL
        BIT	7,(IX+30)		; device ?
        JR	NZ,J1EFD		; yep, call test output ready handler of device
J1EFA:	LD	E,0FFH			; return ready
        RET

J1EFD:	LD	BC,6
        ADD	HL,BC
        LD	C,(IX+30)		; deviceflags
        JP	(HL)

;	  Subroutine IOCTL find screensize
;	     Inputs  ________________________
;	     Outputs ________________________

J1F05:	BIT	7,(IX+30)		; device ?
        JR	NZ,J1F0F		; yep, call find screensize handler of device
        XOR	A
        LD	E,A
        LD	D,A			; size 0*0 for files
        RET

J1F0F:	LD	BC,12
        ADD	HL,BC
        JP	(HL)

;	  Subroutine _DELETE
;	     Inputs  ________________________
;	     Outputs ________________________

A1F14:	CALL	C19BC			; search directoryentry
        RET	NZ			; error, quit
        LD	A,0FFH			; delete is recoverable by UNDEL
        JP	C2350			; mark current directory entry deleted and remove FAT chain

;	  Subroutine _HDELETE
;	     Inputs  ________________________
;	     Outputs ________________________

A1F1E:	CALL	C2140			; get fib pointer of filehandle
        RET	NC			; invalid filehandle, quit
        RET	Z			; filehandle not in use, quit
        CALL	C22D7			; free filehandle
        CALL	C20F2			; update redirect status
        CALL	C224A			; get directory entry and change time/date if file is changed
        SET	3,(IX+49)		; flag FIB invalid because file is deleted
        OR	A
        RET	NZ			; error, quit
        CALL	C1C7A			; get current directory entry
        LD	A,0FFH			; delete is recoverable by UNDEL
        JP	C2350			; mark current directory entry deleted and remove FAT chain

;	  Subroutine _RENAME
;	     Inputs  ________________________
;	     Outputs ________________________

A1F3B:	PUSH	HL
        CALL	C19BC			; search directoryentry
        POP	BC
        RET	NZ			; error, quit
        JP	C23B6			; rename current directory entry

;	  Subroutine _HRENAME
;	     Inputs  ________________________
;	     Outputs ________________________

A1F45:	PUSH	HL
        CALL	C2140			; get fib pointer of filehandle
        POP	BC
        RET	NC			; invalid filehandle, quit
        RET	Z			; filehandle not in use, quit
        PUSH	BC
        CALL	C224A			; get directory entry and change time/date if file is changed
        POP	BC
        OR	A
        RET	NZ			; error, quit
        CALL	C1C7A			; get current directory entry
        CALL	C23B6			; rename current directory entry
        OR	A
        RET	NZ			; error, quit
        CALL	C2288			; update FIB (directory entry changed)
        XOR	A			; no error
        RET

;	  Subroutine _MOVE
;	     Inputs  ________________________
;	     Outputs ________________________

A1F60:	PUSH	HL
        CALL	C19BC			; search directoryentry
        POP	BC
        RET	NZ			; error, quit
        JP	C241B			; move current directory entry

;	  Subroutine _HMOVE
;	     Inputs  ________________________
;	     Outputs ________________________

A1F6A:	PUSH	HL
        CALL	C2140			; get fib pointer of filehandle
        POP	BC
        RET	NC			; invalid filehandle, quit
        RET	Z			; filehandle not in use, quit
        PUSH	BC
        CALL	C224A			; get directory entry and change time/date if file is changed
        POP	BC
        OR	A
        RET	NZ			; error, quit
        CALL	C1C7A			; get current directory entry
        CALL	C241B			; move current directory entry
        OR	A
        RET	NZ			; error, quit
        CALL	C2288			; update FIB (directory entry changed)
        XOR	A
        RET

;	  Subroutine _ATTR
;	     Inputs  ________________________
;	     Outputs ________________________

A1F85:	EX	AF,AF'
        PUSH	HL
        CALL	C19BC			; search directoryentry
        POP	BC
        RET	NZ			; error, quit
        EX	AF,AF'
        OR	A
        CALL	NZ,C24FD
        OR	A
        RET	NZ
        CALL	C1C7A			; get current directory entry
        LD	HL,11
        ADD	HL,DE
        LD	L,(HL)			; attribute of directory entry
        XOR	A
        RET

;	  Subroutine _HATTR
;	     Inputs  ________________________
;	     Outputs ________________________

A1F9D:	EX	AF,AF'
        LD	C,L
        CALL	C2140			; get fib pointer of filehandle
        RET	NC			; invalid filehandle, quit
        RET	Z			; filehandle not in use, quit
        EX	AF,AF'
        OR	A
        JR	Z,J1FB9
        PUSH	BC
        CALL	C224A			; get directory entry and change time/date if file is changed
        POP	BC
        OR	A
        RET	NZ
        CALL	C1C7A			; get current directory entry
        CALL	C24FD
        RET	NZ
        CALL	C2288			; update FIB (directory entry changed)
J1FB9:	LD	L,(IX+14)
        XOR	A
        RET

;	  Subroutine _FTIME
;	     Inputs  ________________________
;	     Outputs ________________________

A1FBE:	EX	AF,AF'
        PUSH	IX
        PUSH	HL
        CALL	C19BC			; search directoryentry
        POP	BC
        POP	DE
        RET	NZ			; error, quit
        EX	AF,AF'
        OR	A			; set time/date ?
        CALL	NZ,C2522		; yep, update time/date directory entry
        OR	A
        RET	NZ			; error, quit
        CALL	C1C7A			; get current directory entry
        LD	HL,22
        ADD	HL,DE
        LD	E,(HL)
        INC	HL
        LD	D,(HL)			; time directory entry
        INC	HL
        LD	A,(HL)
        INC	HL
        LD	H,(HL)
        LD	L,A			; date directory entry
        XOR	A
        RET

;	  Subroutine _HFTIME
;	     Inputs  ________________________
;	     Outputs ________________________

A1FE0:	EX	AF,AF'
        PUSH	IX
        PUSH	HL
        CALL	C2140			; get fib pointer of filehandle
        POP	BC
        POP	DE
        RET	NC			; invalid filehandle, quit
        RET	Z			; filehandle not in use, quit
        EX	AF,AF'
        OR	A
        JR	Z,J1FFF			; get time/date, skip set time/date
        PUSH	BC
        PUSH	DE
        CALL	C224A			; get directory entry and change time/date if file is changed
        POP	DE
        POP	BC
        OR	A
        RET	NZ			; error, quit
        CALL	C2522			; update time/date directory entry
        RET	NZ			; error, quit
        CALL	C2288			; update FIB (directory entry changed)
J1FFF:	LD	E,(IX+15)
        LD	D,(IX+16)		; time
        LD	L,(IX+17)
        LD	H,(IX+18)		; date
        XOR	A
        RET
;	  Subroutine _HTEST
;	     Inputs  ________________________
;	     Outputs ________________________

A200D:	PUSH	BC
        CALL	C19BC			; search directoryentry
        POP	BC
        RET	NZ			; error, quit
        BIT	7,(IX+30)		; device ?
        JR	NZ,J2026		; yep,
        PUSH	HL
        CALL	C2140			; get fib pointer of filehandle
        POP	HL
        RET	NC			; invalid filehandle, quit
        RET	Z			; filehandle not in use, quit
        LD	B,0FFH
        CALL	C2312			; check if FIB matches the current directoryentry
        RET	Z			; equal, quit
J2026:	XOR	A
        LD	B,A
        RET

;	  Subroutine _FORK
;	     Inputs  ________________________
;	     Outputs ________________________

A2029:	LD	HL,2*64
        CALL	C01CB			; allocate BDOS data block
        RET	NZ			; error, quit
        LD	DE,(DBBF0)
        LD	(DBBF0),HL
        LD	(HL),E
        INC	HL
        LD	(HL),D
        LD	A,D
        OR	E
        JR	Z,J2063
        INC	DE
        LD	B,63			; 63 filehandles
J2042:	PUSH	BC
        INC	HL
        INC	DE
        LD	A,(DE)
        LD	C,A
        INC	DE
        LD	A,(DE)
        LD	B,A
        OR	C			; is filehandle open ?
        JR	Z,J205F			; no, skip
        PUSH	BC
        POP	IX
        BIT	2,(IX+49)
        JR	Z,J205F			; file not inheritable, skip this filehandle
        CALL	C2166			; increase filehandle count of FIB
        JR	NZ,J205F		; error, continue with next filehandle
        LD	(HL),C
        INC	HL
        LD	(HL),B			; pointer to FIB
        DEC	HL
J205F:	INC	HL
        POP	BC
        DJNZ	J2042			; next filehandle
J2063:	LD	A,(DBBFE)
        LD	B,A
        INC	A
        LD	(DBBFE),A		; increase procesnumber
        CALL	C20F2			; update redirect status
        XOR	A
        RET

;	  Subroutine _JOIN
;	     Inputs  ________________________
;	     Outputs ________________________

A2070:	LD	A,B
        OR	A
        JR	Z,J207B			; join 0, skip procesnumber check
        LD	HL,DBBFE
        CP	(HL)
        LD	A,.IPROC
        RET	NC
J207B:	CALL	C1290			; free user segments of proces (and all childs)
        LD	HL,(DBBF0)
        PUSH	HL
J2082:	LD	A,H
        OR	L			; no (more) filehandle tables ?
        JR	Z,J20B3			; yep, quit freeing filehandles
        PUSH	BC
        PUSH	HL
        CALL	C022B			; free BDOS data block
        LD	B,-1
J208D:	INC	B
        CALL	C2140			; get fib pointer of filehandle
        JR	NC,J2098		; invalid filehandle, no more filehandles
        CALL	NZ,C2175		; filehandle in use, decrease filehandle count of FIB and remove FIB if zero count
        JR	J208D			; next filehandle

J2098:	POP	HL
        POP	BC
        LD	E,(HL)
        INC	HL
        LD	D,(HL)
        EX	DE,HL
        LD	(DBBF0),HL		; remove filehandle table from chain
        LD	A,(DBBFE)
        DEC	A
        LD	(DBBFE),A		; decrease procesnumber
        INC	B
        DEC	B			; join 0 ?
        JR	Z,J2082			; yep, continue until all filehandle tables are freed
        CP	B
        JR	NZ,J2082		; not at the requested procesnumber, next proces
        XOR	A
        LD	(DE),A
        DEC	DE
        LD	(DE),A			; endmarker for filehandle table chain
J20B3:	LD	A,B
        LD	(DBBFE),A		; new procesnumber
J20B7:	POP	HL
        LD	A,H
        OR	L			; any filehandle tables ?
        JR	Z,J20D6			; nope, skip
        LD	E,(HL)
        INC	HL
        LD	D,(HL)
        PUSH	DE			; save pointer to the next filehandle table
        LD	B,63			; 63 filehandles
J20C2:	INC	HL
        LD	E,(HL)
        INC	HL
        LD	D,(HL)			; pointer to FIB
        PUSH	DE
        POP	IX
        LD	A,D
        OR	E			; is filehandle open ?
        PUSH	HL
        PUSH	BC
        CALL	NZ,C2244		; yep, if file is changed get directory entry and change time/date
        POP	BC
        POP	HL
        DJNZ	J20C2			; next filehandle
        JR	J20B7			; next filehandle table

J20D6:	LD	A,0FFH			; all drives
        CALL	C2C68			; write dirty sectorbuffers of drive
        LD	A,(DBBFE)
        OR	A
        JR	NZ,J20EA
        CALL	A2029
        CALL	C21C5			; create standard filehandles
        CALL	C03A0
J20EA:	CALL	C20F2			; update redirect status
        CALL	C09B6			; clear con input line buffer
        XOR	A
        RET

;	  Subroutine update redirect status
;	     Inputs  ________________________
;	     Outputs ________________________

C20F2:	PUSH	BC
        PUSH	DE
        PUSH	HL
        PUSH	IX
        LD	C,0
        LD	B,0			; console input filehandle
        CALL	C2140			; get fib pointer of filehandle
        JR	NC,J210D		; invalid filehandle,
        JR	Z,J210D			; filehandle not in use,
        LD	A,(IX+30)		; deviceflags
        AND	81H
        CP	81H			; is this the console input device ?
        JR	Z,J210D
        SET	0,C			; nope, flag console input redirected
J210D:	LD	B,1			; console output filehandle
        CALL	C2140			; get fib pointer of filehandle
        JR	NC,J2121		; invalid filehandle,
        JR	Z,J2121			; filehandle not in use,
        LD	A,(IX+30)		; deviceflags
        AND	82H
        CP	82H			; is this the console output device ?
        JR	Z,J2121
        SET	1,C			; nope, flag console output redirected
J2121:	LD	A,C
        LD	(DBB89),A		; update redirect status
        POP	IX
        POP	HL
        POP	DE
        POP	BC
        RET

;	  Subroutine __________________________
;	     Inputs  ________________________
;	     Outputs ________________________

C212B:	PUSH	DE
        PUSH	IX
        LD	B,-1
J2130:	INC	B
        CALL	C2140			; get fib pointer of filehandle
        LD	A,.NHAND
        JR	NC,J213B		; invalid filehandle -> no free filehandles, quit
        JR	NZ,J2130		; in use, try next filehandle
        XOR	A
J213B:	POP	IX
        POP	DE
        OR	A
        RET

;	  Subroutine get fib of filehandle
;	     Inputs  B = filehandle
;	     Outputs Cx reset if invalid filehandle, Cx set if valid. Zx reset if filehandle is open

C2140:	LD	A,B
        CP	63
        JR	NC,J2162		; filehandle must be 0-62, quit with error
        LD	HL,(DBBF0)
        LD	A,H
        OR	L			; is a filehandle table available ?
        JR	Z,J2162			; nope, quit with error
        PUSH	BC
        INC	HL
        INC	HL
        LD	C,B
        LD	B,0
        ADD	HL,BC
        ADD	HL,BC
        LD	E,(HL)
        INC	HL
        LD	D,(HL)			; pointer to FIB
        DEC	HL
        POP	BC
        PUSH	DE
        POP	IX
        LD	A,D
        OR	E			; is pointer to FIB valid ?
        SCF
        LD	A,.NOPEN
        RET

J2162:	LD	A,.IHAND
        OR	A
        RET

;	  Subroutine __________________________
;	     Inputs  ________________________
;	     Outputs ________________________

C2166:	LD	A,(IX-1)
        INC	A
        JR	Z,J2171
        LD	(IX-1),A
        XOR	A
        RET

J2171:	LD	A,.NHAND
        OR	A
        RET

;	  Subroutine decrease filehandle count of FIB and remove FIB if zero count
;	     Inputs  IX = pointer to FIB
;	     Outputs ________________________

C2175:	LD	A,(IX-1)
        DEC	A
        LD	(IX-1),A
        RET	NZ
        PUSH	DE
        PUSH	BC
        PUSH	IX
        EX	(SP),HL
        LD	BC,-3
        ADD	HL,BC
        EX	DE,HL
        LD	HL,DBBF2		; start of FIB chain
        CALL	C2192			; remove element from chain
        POP	HL
        POP	BC
        POP	DE
        XOR	A
        RET

;	  Subroutine remove element from chain
;	     Inputs  HL = start of chain, DE = adres of element
;	     Outputs ________________________

C2192:	EX	DE,HL
        LD	B,H
        LD	C,L
        CALL	C022B			; free BDOS data block
        EX	DE,HL
J2199:	LD	E,(HL)
        INC	HL
        LD	D,(HL)
        LD	A,D
        OR	E			; end of chain ?
        RET	Z			; yep, then I am done
        EX	DE,HL
        SBC	HL,BC
        ADD	HL,BC
        JR	NZ,J2199		; not the element we are searching, continue in chain
        DEC	DE
        LD	A,(HL)
        LD	(DE),A
        INC	HL
        INC	DE
        LD	A,(HL)
        LD	(DE),A			; link chain past removed element
        RET

;	  Subroutine create FIB element
;	     Inputs  ________________________
;	     Outputs ________________________

C21AD:	LD	HL,50+3+3
        CALL	C01CB			; allocate BDOS data block
        RET	NZ			; error, quit
        PUSH	DE
        LD	DE,(DBBF2)		; current start of the FIB chain
        LD	(DBBF2),HL
        LD	(HL),E
        INC	HL
        LD	(HL),D			; link the new FIB element in front of the chain
        INC	HL
        LD	(HL),1			; use count=1
        INC	HL
        POP	DE
        RET

;	  Subroutine create standard filehandles
;	     Inputs  -
;	     Outputs -

C21C5:	LD	B,5			; 5 standard filehandles
        LD	HL,I21E5		; table with standard filehandles
J21CA:	PUSH	BC
        LD	E,(HL)
        INC	HL
        LD	D,(HL)			; pointer to name of device
        INC	HL
        LD	B,(HL)			; filemode
        INC	HL
        PUSH	HL
        PUSH	BC
        LD	A,B
        CALL	A1DA6			; open device
        POP	BC
        OR	A
        LD	DE,T2200
        LD	A,B
        CALL	NZ,A1DA6		; error, open as NUL device
        POP	HL
        POP	BC
        DJNZ	J21CA
        RET

I21E5:	defw	T21F4			; filehandle 0, STDIN = device CON
        defb	101b			; and is read only
        defw	T21F4			; filehandle 1, STDOUT = device CON
        defb	110b			; and is write only
        defw	T21F4			; filehandle 2, STDERR = device CON
        defb	100b			; and is read & write
        defw	T21F8			; filehandle 3, STDAUX = device AUX
        defb	100b			; and is read & write
        defw	T21FC			; filehandle 4, STDPRN = device PRN
        defb	110b			; and is write only

T21F4:	defb	"CON",0
T21F8:	defb	"AUX",0
T21FC:	defb	"PRN",0
T2200:	defb	"NUL",0

;	  Subroutine __________________________
;	     Inputs  ________________________
;	     Outputs ________________________

C2204:	BIT	7,(IX+30)		; device ?
        JR	Z,J220F			; nope,
        CALL	C1A25			; setup fake directoryentry for device
        XOR	A
        RET

J220F:	LD	C,(IX+25)
        LD	B,1			; for file
        CALL	C31AB			; check diskchange
        OR	A
        RET	NZ			; error, quit
        LD	E,(IX+37)
        LD	D,(IX+38)
        LD	(DBBE8),DE		; start cluster of directory operating on
        INC	IX
        LD	(DBB9E),IX		; current parse string pointer = filename of FIB
        DEC	IX
        LD	B,0
        LD	DE,IB926
        CALL	C13FF			; parse filename
        OR	A
        LD	A,.IFNM
        RET	NZ
        LD	DE,IB926
        LD	(IY+DBBAF-DBB80),4	; search directory entry
        CALL	C1A53			; get directory entry
        OR	A
        RET

;	  Subroutine if file is changed get directory entry and change time/date
;	     Inputs  IX = pointer to FIB
;	     Outputs ________________________

C2244:	XOR	A
        BIT	7,(IX+49)		; file changed ?
        RET	Z			; nope, quit

;	  Subroutine get directory entry and change time/date if file is changed
;	     Inputs  IX = pointer to FIB
;	     Outputs ________________________

C224A:	BIT	3,(IX+49)		; file deleted ?
        LD	A,.HDEAD
        RET	NZ			; yep, quit with "filehandle dead" error
        CALL	C2204
        RET	NZ
        BIT	7,(IX+30)		; device ?
        RET	NZ			; yep, quit
        BIT	7,(IX+49)
        RET	Z			; file not changed, quit
        CALL	C1BA0			; change time and date directoryentry
        PUSH	IX
        EX	(SP),HL
        LD	BC,21
        ADD	HL,BC
        EX	DE,HL			; pointer to filesize FIB
        LD	BC,11
        ADD	HL,BC
        SET	5,(HL)			; set archive bit directoryentry
        LD	BC,15
        ADD	HL,BC
        LD	C,(IX+39)
        LD	B,(IX+40)
        LD	(HL),C
        INC	HL
        LD	(HL),B			; set start cluster directoryentry
        INC	HL
        EX	DE,HL
        LD	BC,4
        LDIR				; set filesize directoryentry
        CALL	C2C56			; mark buffer last read as changed
        POP	HL

;	  Subroutine update FIB (directory entry changed)
;	     Inputs  ________________________
;	     Outputs ________________________

C2288:	CALL	C1C7A			; get current directory entry
        LD	A,(IX+49)		; current open mode

;	  Subroutine setup FIB for open
;	     Inputs  ________________________
;	     Outputs ________________________

C228E:	PUSH	BC
        EX	AF,AF'
        CALL	C1999			; update FIB with directory entry info
        EX	AF,AF'
        AND	07H			; clear unused open mode bits
        LD	(IX+49),A		; open mode
        LD	(IX+32),L
        LD	(IX+33),H		; pointer to drivetable
        LD	BC,(DBBE2)
        LD	(IX+34),C
        CALL	STOR_3
        LD	A,(DBBDF)
        SUB	(IY+DBBE0-DBB80)
        LD	(IX+36),A		; current directory entry in sector
        LD	BC,(DBBE8)		; start cluster of directory operating on
        LD	(IX+37),C
        LD	(IX+38),B		; clusternumber of parent directory
        LD	C,(IX+19)
        LD	B,(IX+20)
        LD	(IX+39),C
        LD	(IX+40),B		; start cluster of file
        LD	(IX+41),C
        LD	(IX+42),B		; current cluster of file = start cluster
        XOR	A
        LD	(IX+43),A
        LD	(IX+44),A		; current relative cluster of file = 0
        POP	BC
        RET

;	  Subroutine free filehandle
;	     Inputs  ________________________
;	     Outputs ________________________

C22D7:	CALL	C2175			; decrease filehandle count of FIB and remove FIB if zero count
        XOR	A
        LD	(HL),A
        INC	HL
        LD	(HL),A
        RET

;	  Subroutine check if file is opened by some other FIB
;	     Inputs  ________________________
;	     Outputs ________________________

C22DF:	PUSH	DE
        PUSH	BC
        EX	DE,HL
        PUSH	IX
        POP	BC
        LD	IX,DBBF2+3		; start with begin of the FIB chain
J22E9:	LD	L,(IX-3)
        LD	H,(IX-2)
        LD	A,H
        OR	L
        JR	Z,J230A			; end of chain, quit
        PUSH	DE
        LD	DE,3
        ADD	HL,DE
        POP	DE
        PUSH	HL
        POP	IX			; next FIB block
        OR	A
        SBC	HL,BC
        JR	Z,J22E9			; same as requested, next
        EX	DE,HL
        CALL	C2312			; check if FIB matches the current directoryentry
        EX	DE,HL
        JR	NZ,J22E9		; no match, check next FIB
        LD	A,.FOPEN		; file is open
J230A:	PUSH	BC
        POP	IX
        EX	DE,HL
        POP	BC
        POP	DE
        OR	A
        RET

;	  Subroutine check if FIB matches the current directoryentry
;	     Inputs  IX = pointer to FIB, HL = pointer to drivetable
;	     Outputs ________________________

C2312:	BIT	7,(IX+30)		; device ?
        RET	NZ			; yep, quit
        LD	A,(DBBDF)
        SUB	(IY+DBBE0-DBB80)	; current directoryentry in sector
        CP	(IX+36)			; same as directoryentry in FIB ?
        RET	NZ			; nope, quit
        PUSH	HL
        LD	DE,(DBBE2)		; current directory sector
        LD	L,(IX+34)
        LD	H,(IX+35)
        CALL	STOR_4
        POP	HL
        RET	NZ			; nope, quit
        LD	E,(IX+32)
        LD	D,(IX+33)		; drivetable pointer in FIB
        XOR	A
        SBC	HL,DE			; same as current drivetable pointer ?
        ADD	HL,DE
        RET	NZ			; nope, quit
        PUSH	HL
        PUSH	BC
        LD	HL,25
        ADD	HL,DE
        EX	DE,HL
        PUSH	IX
        POP	HL
        LD	BC,26
        ADD	HL,BC
        CALL	C3311			; compare diskserials
        POP	BC
        POP	HL
        RET

;	  Subroutine mark current directory entry deleted and remove FAT chain
;	     Inputs  A = 0 (deleted is not recoverable), <> 0 (delete is recoverable)
;	     Outputs ________________________

C2350:	LD	C,A
        XOR	A
        BIT	7,(IX+30)		; device ?
        RET	NZ			; yep, quit
        CALL	C22DF			; check if file is opened by some other FIB
        RET	NZ			; yep, quit with error
        PUSH	HL
        LD	HL,11
        ADD	HL,DE
        LD	B,(HL)			; directory entry attribute
        POP	HL
        BIT	0,B
        LD	A,.FILRO
        RET	NZ			; read only file, quit with error
        BIT	4,B
        JR	Z,J2388			; no directory, skip empty directory check
        CALL	C2553			; check if special subdir directory entry
        RET	C			; it is, quit with "invalid operation" error
        CALL	C1BF0			; register directory entry
        CALL	C1C3A			; register startcluster of directoryentry as directory operating on
        CALL	C1C5D			; get first directory entry
J2378:	JR	Z,J2385			; unused directory entry, not need to search futher
        CALL	C2553			; check if special subdir directory entry
        LD	A,.DIRNE
        RET	NZ			; not a free or special subdir entry, quit with "subdirectory not empty" error
        CALL	C1C94			; get next directory entry
        JR	NC,J2378		; there is, try that one
J2385:	CALL	C1C04			; get registered directory entry
J2388:	CALL	C1C7A			; get current directory entry
        LD	A,C
        PUSH	HL
        LD	HL,26
        ADD	HL,DE
        LD	C,(HL)
        INC	HL
        LD	B,(HL)			; start cluster
        POP	HL
        OR	A
        CALL	NZ,C2ECC		; flag set, set deleted files status disk
        LD	D,B
        LD	E,C
        LD	A,D
        OR	E			; does file/directory have a startcluster ?
        CALL	NZ,C301A		; yes, delete cluster chain
        CALL	C1C7A			; get current directory entry
        PUSH	HL
        LD	HL,12
        ADD	HL,DE
        LD	A,(DE)
        LD	(HL),A			; save 1st char of name
        LD	A,0E5H
        LD	(DE),A			; mark directoryentry as deleted
        POP	HL
J23AE:	CALL	C2541
        CALL	NZ,C34E9
        XOR	A
        RET

;	  Subroutine rename current directory entry
;	     Inputs  BC = pointer to new name
;	     Outputs ________________________

C23B6:	XOR	A
        BIT	7,(IX+30)		; device ?
        RET	NZ			; yep, quit
        CALL	C22DF			; check if file is opened by some other FIB
        RET	NZ			; yep, quit with error
        CALL	C2553			; check if special subdir directory entry
        RET	C			; it is, quit with error
        LD	(DBB9E),BC		; current parse string pointer = pointer to new name
        PUSH	DE
        LD	DE,IB91B
        CALL	C13FF			; parse filename
        POP	DE
        OR	A
        LD	A,.IFNM
        RET	NZ
        PUSH	HL
        LD	HL,IB91B
        LD	BC,IB91B
        CALL	C160C			; copy name and expand wildcard
        POP	HL
        LD	DE,IB91B
        LD	(DBBAD),DE
        LD	A,0FFH			; devicename check
        CALL	C1637
        RET	NZ
        CALL	C2553			; check if special subdir directory entry
        RET	C			; it is, quit with error
        CALL	C1BF0			; register directory entry
        CALL	C1C5D			; get first directory entry
        CALL	C1BD2			; search for matching directoryentry
        LD	A,.DUPF
        RET	C			; found, "Duplicate filename" error and quit
        CALL	C1C04			; get registered directory entry
        CALL	C1C7A			; get current directory entry
        PUSH	HL
        PUSH	DE
        LD	HL,IB91B
        LD	B,11
        LD	A,(HL)
        CP	0E5H
        JR	NZ,J2410
        LD	A,05H			; replace char
J2410:	LD	(DE),A
        INC	HL
        INC	DE
        LD	A,(HL)
        DJNZ	J2410
        POP	DE
        POP	HL
        JP	J23AE

;	  Subroutine move current directory entry
;	     Inputs  ________________________
;	     Outputs ________________________

C241B:	XOR	A
        BIT	7,(IX+30)		; device ?
        RET	NZ			; yep, quit (without error)
        CALL	C22DF			; check if file is opened by some other FIB
        RET	NZ			; yep, quit with error
        CALL	C2553			; check if special subdir directory entry
        RET	C			; it is, quit with error
        PUSH	HL
        LD	HL,26
        ADD	HL,DE
        LD	A,(HL)
        INC	HL
        LD	H,(HL)
        LD	L,A
        LD	(DBBAB),HL		; save startcluster of directoryentry
        LD	HL,11
        ADD	HL,DE
        LD	A,(HL)			; directoryentry attribute
        POP	HL
        BIT	4,A
        CALL	NZ,C34E9		; it is a subdirectory,
        PUSH	BC
        PUSH	HL
        LD	HL,IB91B
        LD	B,11
        LD	A,(DE)
        CP	05H
        JR	NZ,J244E
        LD	A,0E5H
J244E:	LD	(HL),A
        INC	HL
        INC	DE
        LD	A,(DE)
        DJNZ	J244E
        CALL	STOR_5
        LD	DE,IBBC6
        LD	BC,12
        LDIR				; save directoryentry locators
        POP	HL
        POP	DE
        LD	C,89H			; no devicename check, empty last item does not imply *.*, report path errors, b3=1, other driveindicator not allowed
        LD	B,(IX+31)		; FIB directory entry attribute
        LD	A,(IX+25)		; driveid
        LD	(IY+DBBAF-DBB80),0	; create directory entry
        CALL	C12C3			; parse (with driveindicator)
        RET	NZ			; error, quit
        OR	C
        LD	A,.IPATH
        RET	NZ
        BIT	1,(IY+DBBAF-DBB80)
        LD	A,.DIRE
        RET	NZ
        CALL	C1C5D			; get first directory entry
        LD	BC,IB91B
        LD	(DBBAD),BC
        CALL	C1BD2			; search for matching directoryentry
        LD	A,.DUPF
        RET	C
        CALL	C1C04			; get free directory entry
        RET	NZ
        CALL	C1BF0			; register directory entry
        PUSH	HL
        CALL	STOR_6
        LD	DE,DBBDE
        LD	BC,12
        LDIR				; restore directoryentry locators
        POP	HL
        CALL	C1C7A			; get current directory entry
        PUSH	HL
        LD	HL,IB8D4
        PUSH	DE
        EX	DE,HL
        LD	BC,32
        LDIR				; save directoryentry
        POP	HL
        LD	(HL),0E5H		; mark directoryentry as deleted
        CALL	C2C56			; mark buffer last read as changed
        POP	HL
        CALL	C1C04			; get registered directory entry
        CALL	C1C7A			; get current directory entry
        PUSH	HL
        LD	HL,IB8D4
        LD	BC,32
        PUSH	DE
        LDIR				; restore orginal directoryentry
        POP	DE
        POP	HL
        CALL	C2541
        RET	Z
        CALL	C34E9
        LD	BC,(DBBE8)		; start cluster of directory operating on
        PUSH	BC
        CALL	C1C3A			; register startcluster of directoryentry as directory operating on
        CALL	C1C5D			; get first directory entry
        LD	BC,I256A
        LD	(DBBAD),BC
        CALL	C1BD2			; search for matching directoryentry
        POP	BC
        RET	NC
        AND	10H
        RET	Z
        BIT	7,B
        JR	Z,J24EF
        LD	BC,0
J24EF:	PUSH	HL
        LD	HL,26
        ADD	HL,DE
        LD	(HL),C
        INC	HL
        LD	(HL),B
        CALL	C2C56			; mark buffer last read as changed
        XOR	A
        POP	HL
        RET

;	  Subroutine __________________________
;	     Inputs  ________________________
;	     Outputs ________________________

C24FD:	XOR	A
        BIT	7,(IX+30)		; device ?
        RET	NZ			; yep, quit
        CALL	C22DF			; check if file is opened by some other FIB
        RET	NZ			; yep, quit with error
        PUSH	HL
        LD	HL,11
        ADD	HL,DE
        LD	A,(HL)
        LD	B,0DDH
        BIT	4,A
        JR	NZ,J2515
        LD	B,0D8H
J2515:	XOR	C
        AND	B
        LD	A,.IATTR
        JR	NZ,J2520
        LD	(HL),C
        CALL	C2C56			; mark buffer last read as changed
        XOR	A
J2520:	POP	HL
        RET

;	  Subroutine update time/date directory entry
;	     Inputs  IX = pointer to FIB, DE = time, BC = date
;	     Outputs ________________________

C2522:	XOR	A
        BIT	7,(IX+30)		; device ?
        RET	NZ			; yep, quit
        CALL	C22DF			; check if file is opened by some other FIB
        RET	NZ			; yep, quit with error
        PUSH	HL
        PUSH	DE
        CALL	C1C7A			; get current directory entry
        LD	HL,22
        ADD	HL,DE
        EX	DE,HL
        EX	(SP),HL
        EX	DE,HL
        LD	(HL),E
        INC	HL
        LD	(HL),D			; update time directory entry
        INC	HL
        LD	(HL),C
        INC	HL
        LD	(HL),B			; update date directory entry
        POP	DE
        POP	HL

;	  Subroutine __________________________
;	     Inputs  ________________________
;	     Outputs ________________________

C2541:	PUSH	HL
        LD	HL,11
        ADD	HL,DE
        BIT	4,(HL)
        JR	NZ,J254C
        SET	5,(HL)
J254C:	CALL	C2C56			; mark buffer last read as changed
        POP	HL
        LD	A,00H
        RET

;	  Subroutine check if special subdir directory entry
;	     Inputs  ________________________
;	     Outputs Cx set if special directory entry, Zx set if free or special directory entry

C2553:	PUSH	HL
        PUSH	BC
        LD	HL,I256B		; special "this directory" entry
        XOR	A			; no volume directoryentry
        CALL	C15D2			; does directoryentry match the search ?
        JR	Z,J2565			; free entry or match, quit
        LD	HL,I256A		; special "root directory" entry
        XOR	A			; no volume directoryentry
        CALL	C15D2			; does directoryentry match the search ?
J2565:	POP	BC
        POP	HL
        LD	A,.DOT
        RET

I256A:	defb	"."
I256B:	defb	".          "

;	  Subroutine _RDABS
;	     Inputs  ________________________
;	     Outputs ________________________

A2576:	LD	A,1			; read operation, DOS segments
        defb	0FEH			; CP xx

;	  Subroutine _WRABS
;	     Inputs  ________________________
;	     Outputs ________________________

A2579:	XOR	A			; write operation, DOS segments
        LD	(DBBC4),A
        LD	(DBBB4),DE		; sectornumber
        LD	BC,(DF23D)		; transfer adres
        LD	(DBBC2),BC
        LD	A,B
        ADD	A,H
        JR	C,J258E
        ADD	A,H
J258E:	LD	A,.OV64K		; check for warparound page3 - page0
        RET	C			; yep, quit
        PUSH	HL
        LD	IX,IB9DA
        LD	B,2			; only write dirty sectorbuffers
        LD	C,L
        INC	C
        CALL	C31AB			; check diskchange
        POP	BC
        OR	A
        RET	NZ			; error, quit
        CALL	C2C67			; write dirty sectorbuffers of drivetable
        CALL	C2C77			; mark all sectorbuffers of drivetable unused
        CALL	ABSSEC
        CALL	C2C67			; write dirty sectorbuffers of drivetable
        CALL	C2C77			; mark all sectorbuffers of drivetable unused
        LD	DE,9
        ADD	HL,DE
        LD	(HL),1
        XOR	A
        RET

;	  Subroutine __________________________
;	     Inputs  ________________________
;	     Outputs ________________________

C25B7:	XOR	A
        CP	B
        RET	Z			; number of sector zero, quit
        LD	A,(DBBC4)
        AND	04H			; use DOS or BDOS segments
        LD	DE,(DBBC2)
        CALL	C274F			; get segmentnumber
        SET	7,D			; page 2 based
        EX	AF,AF'
        PUSH	HL
        LD	HL,0C000H-0200H
        OR	A
        SBC	HL,DE
        JR	C,J263A			; first sector transfer over page boundary, take special actions
        LD	A,H
        SRL	A
        INC	A
        CP	B
        JR	C,J25DA			; complete transfer over page boundary, do all sectors you can
        LD	A,B			; do all sectors in one time
J25DA:	LD	C,A
        POP	HL
        SUB	B
        NEG
        LD	B,A
        PUSH	BC
        LD	B,C
        EX	AF,AF'
        LD	C,A
        PUSH	BC
        XOR	A
J25E6:	PUSH	BC
        PUSH	DE
        PUSH	DE
        EX	(SP),IX
        CALL	RAMRED
        PUSH	DE
        DEC	A
        JR	Z,J2602
        LD	A,0			; DSKIO read
        BIT	0,(IY+DBBC4-DBB80)
        JR	NZ,J25FD		; read operation
        LD	A,1			; DSKIO write
J25FD:	CALL	C326D			; diskdriver
        JR	J2604

J2602:	LD	B,1
J2604:	EX	AF,AF'
        POP	DE
        POP	IX
        PUSH	HL
        LD	L,B
        LD	H,0
        ADD	HL,DE
        CALL	NUM_1
        POP	HL
        POP	DE
        LD	A,D
        ADD	A,B
        ADD	A,B
        LD	D,A
        LD	A,B
        POP	BC
        SUB	B
        NEG
        LD	B,A
        EX	AF,AF'
        PUSH	DE
        LD	DE,(DBBB4)		; sectornumber
        CALL	NZ,C36AC		; error occured, handle error (ignore no problem)
        POP	DE
        INC	B
        DEC	B
        JR	NZ,J25E6
        POP	BC
        CALL	C2651
        POP	BC
        LD	A,(IY+DBBC2+1-DBB80)
        ADD	A,C
        ADD	A,C
        LD	(IY+DBBC2+1-DBB80),A
        JP	C25B7

J263A:	POP	HL
        DEC	B
        PUSH	BC
        LD	DE,512
        LD	B,E
        LD	C,E
        CALL	C26A6
        POP	BC
        INC	(IY+DBBB4-DBB80+0)
        JR	NZ,J264E
        CALL	NUM_2
J264E:	JP	C25B7

;	  Subroutine __________________________
;	     Inputs  ________________________
;	     Outputs ________________________

C2651:	CALL	C2C8D
J2654:	PUSH	BC
        EXX
        CALL	C2CBD			; find marked sectorbuffer
        JR	Z,J26A3			; no more,
        LD	BC,4
        ADD	HL,BC
        LD	E,(HL)
        INC	HL
        LD	D,(HL)
        EX	DE,HL
        LD	BC,(DBBB4)		; sectornumber
        JP	DSKBUF

J266A:	LD	A,H
        INC	A
        JR	NZ,J2683
        LD	A,L
        ADD	A,B
J2670:	JR	NC,J2683
        DEC	DE
        DEC	DE
        EX	DE,HL
        BIT	0,(IY+DBBC4-DBB80)
        JR	NZ,J2686		; read operation
        DEC	HL
        LD	(HL),00H
        DEC	HL
        DEC	HL
        CALL	C2CD5			; make buffer the first buffer
J2683:	EXX
        JR	J2654

J2686:	BIT	7,(HL)
        JR	Z,J2683
        LD	A,C
        EXX
        PUSH	DE
        EXX
        LD	BC,8
        ADD	HL,BC
        EX	(SP),HL
        LD	D,E
        LD	E,B
        ADD	HL,DE
        ADD	HL,DE
        EX	DE,HL
        RES	7,D
        POP	HL
        LD	BC,512
        CALL	CF1D6			; transfer with page 0
        JR	J2683

J26A3:	EXX
        POP	BC
        RET

;	  Subroutine __________________________
;	     Inputs  ________________________
;	     Outputs ________________________

C26A6:	PUSH	HL
        EX	(SP),IX
        PUSH	DE
        PUSH	BC
        BIT	0,(IY+DBBC4-DBB80)
        JR	NZ,J26D6		; read operation
        BIT	1,D
        JR	NZ,J26D9
        BIT	1,(IY+DBBC4-DBB80)
        JR	NZ,J26D6
        PUSH	DE
        LD	HL,(DBBC0)
        LD	DE,(DBBB2)
        OR	A
        SBC	HL,DE
        POP	DE
        JR	C,J26D3
        LD	A,B
        OR	C
        JR	NZ,J26D6
        SBC	HL,DE
        JR	C,J26D9
        JR	J26D6

J26D3:	ADD	HL,BC
        JR	NC,J26D9
J26D6:	LD	B,3			; real read, ignore not problem
        defb	021H			; LD HL,xxxx
J26D9:	LD	B,2			; no real read, ignore not problem
        LD	DE,(DBBB4)		; sectornumber
        CALL	BUF_2
        POP	DE
        ADD	HL,DE
        LD	BC,11
        ADD	HL,BC
        POP	BC
        PUSH	DE
        PUSH	BC
        LD	DE,(DBBC2)
        PUSH	DE
        LD	A,(DBBC4)		; to/from, DOS or BDOS segements
        CALL	C2711			; transfer
        POP	HL
        POP	BC
        ADD	HL,BC
        LD	(DBBC2),HL
        BIT	0,(IY+DBBC4-DBB80)
        CALL	Z,C2C56			; write operation, mark buffer last read as changed
        POP	HL
        ADD	HL,BC
        BIT	1,H
        LD	HL,(DBBF6)		; last buffer read
        CALL	NZ,C2CD2
        EX	(SP),IX
        POP	HL
        RET

;	  Subroutine __________________________
;	     Inputs  DE = adres, BC = size, A (b0=to/from),(b2=dos/bdos segements)
;	     Outputs ________________________

C2711:	PUSH	DE
        PUSH	BC
        PUSH	AF
        PUSH	HL
        AND	04H
        CALL	C274F			; get segmentnumber
        LD	HL,04000H
        OR	A
        SBC	HL,DE
        SBC	HL,BC
        JR	NC,J2727		; does fit in one page, do all
        ADD	HL,BC
        LD	C,L
        LD	B,H			; only do transfer of first page
J2727:	POP	HL
        EX	(SP),HL
        BIT	0,H
        EX	(SP),HL
        PUSH	BC
        JR	NZ,J2730
        EX	DE,HL
J2730:	CALL	CF1D6			; transfer with page 0
        JR	NZ,J2736
        EX	DE,HL
J2736:	POP	BC
        POP	AF
        EX	(SP),HL
        OR	A
        SBC	HL,BC
        LD	B,H
        LD	C,L
        POP	HL
        JR	Z,J274D			; all done, quit
        LD	E,A
        POP	AF
        AND	0C0H
        ADD	A,40H
        LD	D,A
        LD	A,E
        LD	E,00H
        JR	C2711			; do the leftover

J274D:	POP	DE
        RET

;	  Subroutine get segmentnumber
;	     Inputs  DE = adres, A=0 for DOS segments, A<>0 for current segments
;	     Outputs DE = page 0 based adres, A = segmentnumber

C274F:	PUSH	DE
        PUSH	HL
        LD	HL,IF2CB		; saved DOS page 0 segment
        OR	A
        JR	Z,J275A
        LD	HL,IF2C7		; current segment
J275A:	LD	A,D
        AND	0C0H
        RLCA
        RLCA
        LD	E,A
        LD	D,0
        ADD	HL,DE
        LD	A,(HL)
        POP	HL
        POP	DE
        RES	6,D
        RES	7,D
        RET

;	  Subroutine __________________________
;	     Inputs  ________________________
;	     Outputs ________________________
;	     Remark  not used

?276B:	AND	04H
        OR	02H
        JR	C2779

;	  Subroutine write to file
;	     Inputs  BC = size, DE = transferadres, A(b2) DOS/BDOS segments
;	     Outputs ________________________

C2771:	AND	04H			; DOS or BDOS segments, flag write
        JR	C2779

;	  Subroutine read from file
;	     Inputs  BC = size, DE = transferadres, A(b2) DOS/BDOS segments
;	     Outputs ________________________

C2775:	AND	04H			; DOS or BDOS segments
        OR	01H			; flag read

;	  Subroutine __________________________
;	     Inputs  IX=pointer to FIB, DE=transfer, BC=size, A(b0) read/write flag, A(b1) zero fill gap, A(b2) use dos/bdos segments, A(b3) ?, A(b4) alter filesize
;	     Outputs BC=bytes done, DE=updated transfer

C2779:	BIT	7,(IX+30)		; device ?
        JR	NZ,J27C8		; yep,
        LD	(DBBC4),A		; save flags
        AND	10H
        OR	B
        OR	C
        RET	Z
        XOR	A
        LD	(DBBBE+0),A
        LD	(DBBBE+1),A
        LD	(DBBC0),BC
        LD	(DBBC2),DE
        CALL	C2881
        LD	BC,(DBBBE)
        LD	DE,(DBBC2)
J27A1:	LD	L,(IX+45)
        LD	H,(IX+46)
        ADD	HL,BC
        LD	(IX+45),L
        LD	(IX+46),H
        JR	NC,J27B8
        INC	(IX+47)
        JR	NZ,J27B8
        INC	(IX+48)
J27B8:	OR	A
        RET	NZ
        BIT	4,(IY+DBBC4-DBB80)	; alter filesize ?
        JR	NZ,J27C6		; yep, quit without error
        LD	A,B
        OR	C
        LD	A,.EOF
        JR	Z,J27B8
J27C6:	XOR	A
        RET

J27C8:	LD	H,A
        AND	04H
        LD	(DBBC4),A		; save DOS or BDOS segments flag
        LD	A,B
        OR	C
        RET	Z			; zero bytes, quit
        BIT	0,H
        JR	NZ,J281A		; read
        LD	L,(IX+28)
        LD	H,(IX+29)
        INC	HL
        INC	HL
        INC	HL			; device handler for write
        PUSH	BC			; save size for later
J27DF:	PUSH	DE
        LD	A,(DBBC4)		; DOS or BDOS segments flag
        CALL	C274F			; get segmentnumber
        EX	DE,HL
        CALL	CF206			; RD_SEG
        EI
        EX	DE,HL
        POP	DE
        BIT	5,(IX+30)		; binary filemode ?
        JR	Z,J27F7			; yep, writes any char (including EOF)
        CP	1AH
        JR	Z,J280F			; EOF in ascii filemode, quit without error
J27F7:	PUSH	IX
        PUSH	BC
        PUSH	DE
        PUSH	HL
        CALL	C287D			; call device write handler
        POP	HL
        POP	DE
        POP	BC
        POP	IX
        OR	A
        JR	NZ,J2812		; error, quit
        INC	DE
        DEC	BC
        LD	A,B
        OR	C
        JR	NZ,J27DF		; next byte
        JR	J2812			; all done, quit without error

J280F:	XOR	A			; no error
        INC	DE
        DEC	BC			; adjust like EOF was written
J2812:	POP	HL			; orginal size
        OR	A
        SBC	HL,BC			; - left
        LD	B,H
        LD	C,L			; = bytes written
J2818:	JR	J27A1

J281A:	LD	L,(IX+28)
        LD	H,(IX+29)		; device handler for read
        PUSH	BC
        RES	6,(IX+30)		; reset EOF flag
J2825:	PUSH	BC
        PUSH	IX
        PUSH	DE
        PUSH	HL
        CALL	C287D			; call device read handler
        POP	HL
        POP	DE
        POP	IX
        LD	C,00H
        OR	A
        JR	Z,J284E
        CP	.EOF
        JR	Z,J2845
        CP	.EOL
        JR	NZ,J286E
        BIT	2,(IX+30)
        JR	NZ,J284E
        INC	C
J2845:	INC	C
        BIT	5,(IX+30)		; ascii filemode ?
        JR	NZ,J284E		; yep,
        LD	C,00H
J284E:	PUSH	DE
        PUSH	HL
        LD	A,(DBBC4)		; DOS or BDOS segments flag
        CALL	C274F			; get segmentnumber
        EX	DE,HL
        LD	E,B
        CALL	CF209			; WR_SEG
        EI
        POP	HL
        POP	DE
        LD	A,C
        POP	BC
        DEC	A
        JR	Z,J2871
        INC	DE
        DEC	BC
        DEC	A
        JR	Z,J2875
        LD	A,B
        OR	C
        JR	NZ,J2825
        JR	J2875

J286E:	POP	BC
        JR	J2875

J2871:	SET	6,(IX+30)		; set EOF flag
J2875:	POP	HL
        OR	A
        SBC	HL,BC
        LD	B,H
        LD	C,L
        JR	J2818

;	  Subroutine __________________________
;	     Inputs  ________________________
;	     Outputs ________________________

C287D:	LD	C,(IX+30)		; device flags
        JP	(HL)

;	  Subroutine __________________________
;	     Inputs  ________________________
;	     Outputs ________________________

C2881:	LD	A,.HDEAD
        BIT	3,(IX+49)
        RET	NZ			; file is deleted, quit with "filehandle dead" error
        LD	A,.ACCV
        BIT	0,(IY+DBBC4-DBB80)
        JR	Z,J2897			; write operation
        BIT	1,(IX+49)
        RET	NZ			; file mode no read, quit with error
        JR	J28A3

J2897:	BIT	0,(IX+49)
        RET	NZ			; file mode no write, quit with error
        LD	A,.FILRO
        BIT	0,(IX+14)		; read-only file ?
        RET	NZ			; yep, quit with "file read-only" error
J28A3:	LD	HL,(DBBC2)
        ADD	HL,BC
        LD	A,.OV64K
        RET	C
        LD	C,(IX+25)
        LD	B,1			; for file
        CALL	C31AB			; check diskchange
        OR	A
        RET	NZ			; error, quit
        CALL	C29D4
        RET	NZ
        LD	BC,(DBBC0)
        LD	A,B
        OR	C
        RET	Z
        LD	DE,(DBBBC)
        CALL	C2B58
        LD	(DBBB6),DE
        RET	NZ
        LD	BC,(DBBB9)
        LD	A,B
        OR	C
        CALL	NZ,C2954
        RET	NZ
J28DB:	LD	C,(IY+DBBC0+1-DBB80)
        SRL	C
        JR	Z,J2938
        CALL	C297D
        RET	NZ
        SUB	(IY+DBBBB-DBB80)
        LD	B,A
        LD	DE,(DBBB6)
        CALL	C29B1			; clusternumber and offset to sectornumber
J28F1:	LD	A,B
        ADD	A,(IY+DBBB8-DBB80)
        LD	B,A
        CP	C
        JR	NC,J2918
        PUSH	DE
        CALL	FATRED			; get FAT entry content
        EX	(SP),HL
        OR	A
        INC	HL
        SBC	HL,DE
        JR	NZ,J290F
        INC	(IY+DBBBC-DBB80+0)
        JR	NZ,J290C
        INC	(IY+DBBBC-DBB80+1)
J290C:	POP	HL
        JR	J28F1

J290F:	ADD	HL,DE
        EX	DE,HL
        DEC	DE
        POP	HL
        LD	A,(DBBB8)
        JR	J291E

J2918:	LD	A,(DBBB8)
        SUB	B
        ADD	A,C
        LD	B,C
J291E:	DEC	A
        LD	(DBBBB),A
        LD	(DBBB6),DE
        PUSH	BC
        CALL	C25B7
        POP	BC
        SLA	B
        LD	C,00H
        CALL	C29C2
        SET	3,(IY+DBBC4-DBB80)
        JR	J28DB

J2938:	LD	BC,0
        CALL	C2954
        RET	NZ
        LD	DE,(DBBB6)
        LD	(IX+41),E
        LD	(IX+42),D
        LD	DE,(DBBBC)
        LD	(IX+43),E
        LD	(IX+44),D
        RET

;	  Subroutine __________________________
;	     Inputs  ________________________
;	     Outputs ________________________

C2954:	PUSH	HL
        LD	HL,512
        OR	A
        SBC	HL,BC
        EX	DE,HL
        LD	HL,(DBBC0)
        SBC	HL,DE
        JR	NC,J2966
        ADD	HL,DE
        LD	E,L
        LD	D,H
J2966:	LD	A,D
        OR	E
        POP	HL
        RET	Z
        CALL	C297D
        RET	NZ
        CALL	C29B1			; clusternumber and offset to sectornumber
        CALL	C26A6
        SET	3,(IY+DBBC4-DBB80)
        CALL	C29C2
        XOR	A
        RET

;	  Subroutine __________________________
;	     Inputs  ________________________
;	     Outputs ________________________

C297D:	XOR	A
        BIT	3,(IY+DBBC4-DBB80)
        RET	Z
        RES	3,(IY+DBBC4-DBB80)
        LD	A,(DBBBB)
        INC	A
        CP	(IY+DBBB8-DBB80)
        JR	NZ,J29AC
        PUSH	DE
        LD	DE,(DBBBC)
        INC	DE
        LD	(DBBBC),DE
        LD	DE,(DBBB6)
        CALL	FATRED			; get FAT entry content
        LD	(DBBB6),DE
        BIT	7,D			; end of file cluster ?
        POP	DE
        LD	A,.FILE
        RET	NZ			; yep,
        XOR	A
J29AC:	LD	(DBBBB),A
        XOR	A
        RET

;	  Subroutine __________________________
;	     Inputs  ________________________
;	     Outputs ________________________

C29B1:	PUSH	DE
        LD	A,(DBBBB)		; sectoroffset
        LD	DE,(DBBB6)
        CALL	C2DD4			; convert clusternumber to sectornumber
        LD	(DBBB4),DE		; sectornumber
        POP	DE
        RET

;	  Subroutine __________________________
;	     Inputs  ________________________
;	     Outputs ________________________

C29C2:	PUSH	HL
        LD	HL,(DBBBE)
        ADD	HL,BC
        LD	(DBBBE),HL
        LD	HL,(DBBC0)
        SBC	HL,BC
        LD	(DBBC0),HL
        POP	HL
        RET

;	  Subroutine __________________________
;	     Inputs  ________________________
;	     Outputs ________________________

C29D4:	PUSH	HL
        LD	C,(IX+45)
        LD	B,(IX+46)
        LD	E,(IX+47)
        LD	D,(IX+48)
        PUSH	DE
        PUSH	BC
        CALL	C2B23
        JR	NZ,J2A37
        LD	(DBBBC),DE
        LD	(DBBBB),A
        LD	(DBBB9),BC
        POP	HL
        LD	DE,(DBBC0)
        DEC	DE
        ADD	HL,DE
        EX	(SP),HL
        POP	BC
        EX	DE,HL
        EX	(SP),HL
        PUSH	HL
        LD	HL,0
        BIT	4,(IY+DBBC4-DBB80)
        JR	Z,J2A09
        DEC	HL
J2A09:	ADC	HL,DE
        EX	DE,HL
        BIT	7,D
        JR	NZ,J2A80
        POP	HL
        PUSH	DE
        PUSH	BC
        CALL	C2B23
        JR	NZ,J2A37
        PUSH	DE
        LD	C,(IX+21)
        LD	B,(IX+22)
        LD	E,(IX+23)
        LD	D,(IX+24)
        LD	A,B
        OR	C
        DEC	BC
        JR	NZ,J2A2D
        OR	D
        OR	E
        DEC	DE
J2A2D:	PUSH	DE
        PUSH	BC
        CALL	NZ,C2B23
        EXX
        POP	HL
        POP	DE
        EXX
        POP	BC
J2A37:	JR	NZ,J2AB0
        EXX
        POP	BC
        XOR	A
        SBC	HL,BC
        EX	(SP),HL
        EX	DE,HL
        SBC	HL,DE
        EXX
        BIT	7,D
        EX	AF,AF'
        BIT	0,(IY+DBBC4-DBB80)
        JP	NZ,J2B08		; read operation
        PUSH	HL
        LD	H,B
        LD	L,C
        INC	DE
        OR	A
        SBC	HL,DE
        LD	C,L
        LD	B,H
        INC	BC
        JR	NC,J2A94
        ADD	HL,DE
        EX	DE,HL
        POP	HL
        BIT	4,(IY+DBBC4-DBB80)
        JR	Z,J2AC7
        CALL	C2B58
        JR	NZ,J2AB2
        PUSH	DE
        CALL	FATRED
        CALL	Z,C301A			;#3010
        POP	DE
        LD	BC,0FFFFh
        NOP
        CALL	C2DF1			; reset deleted files status disk and set FAT entry
        LD	C,(IX+39)
        LD	B,(IX+40)
        SCF
        EX	AF,AF'
        JR	J2AB4

J2A80:	EXX
        EX	AF,AF'
        POP	HL
        LD	E,(IX+39)
        LD	D,(IX+40)
        LD	A,D
        OR	E
        CALL	NZ,C301A		; , delete cluster chain
        PUSH	DE
        LD	BC,0
        JR	J2AB4

J2A94:	POP	HL
        LD	A,(IY+DBBC4-DBB80)
        AND	02H			; directory cluster clear ?
        CALL	C2F5E			; allocate clusters
        JR	NZ,J2AB1		; error, quit
        DEC	DE
        BIT	7,D
        JR	NZ,J2AB4
        PUSH	BC
        CALL	C2B58
        POP	BC
        JR	NZ,J2AB1
        CALL	C2DF4			; set FAT entry
        JR	J2AC7

J2AB0:	POP	DE
J2AB1:	POP	DE
J2AB2:	POP	DE
        RET

J2AB4:	LD	(IX+39),C
        LD	(IX+40),B
        XOR	A
        LD	(IX+41),C
        LD	(IX+42),B
        LD	(IX+43),A
        LD	(IX+44),A
J2AC7:	SET	7,(IX+49)		; flag file is changed
        EXX
        EX	AF,AF'
        JR	NZ,J2AD1
        JR	NC,J2AE3
J2AD1:	INC	BC
        LD	A,B
        OR	C
        JR	NZ,J2AD7
        INC	DE
J2AD7:	LD	(IX+21),C
        LD	(IX+22),B
        LD	(IX+23),E
        LD	(IX+24),D
J2AE3:	POP	BC
        POP	DE
        LD	A,B
        OR	C
        DEC	BC
        JR	NZ,J2AEB
        DEC	HL
J2AEB:	BIT	7,H
        JR	Z,J2AFF
        LD	A,H
        AND	L
        INC	A
        LD	HL,0FFFFH
        JR	NZ,J2B02
        INC	HL
        SBC	HL,BC
        JR	NZ,J2B02
        DEC	HL
        JR	J2B02

J2AFF:	LD	HL,0
J2B02:	LD	(DBBB2),HL
        EXX
        XOR	A
        RET

J2B08:	EX	AF,AF'
        POP	DE
        EX	(SP),HL
        JR	NZ,J2B19
        JR	NC,J2B20
        EXX
        LD	A,H
        AND	L
        INC	A
        EXX
        JR	NZ,J2B19
        ADD	HL,DE
        JR	C,J2B1C
J2B19:	LD	HL,0FFFFH
J2B1C:	INC	HL
        LD	(DBBC0),HL
J2B20:	XOR	A
        POP	HL
        RET

;	  Subroutine __________________________
;	     Inputs  ________________________
;	     Outputs ________________________

C2B23:	PUSH	HL
        LD	A,B
        SRL	D
        RR	E
        RRA
        LD	B,00H
        RL	B
        PUSH	BC
        LD	BC,10
        ADD	HL,BC
        PUSH	AF
        AND	(HL)
        LD	C,A
        LD	A,(HL)
        INC	A
        LD	(DBBB8),A
        POP	AF
        INC	HL
        LD	B,(HL)
        JR	J2B45

J2B40:	SRL	D
        RR	E
        RRA
J2B45:	DJNZ	J2B40
        INC	D
        DEC	D
        JR	NZ,J2B53
        BIT	7,E
        JR	NZ,J2B53
        LD	D,E
        LD	E,A
        LD	A,C
        DEFB	021H			; LD HL,xxxx
J2B53:	LD	A,.FILE
        POP	BC
        POP	HL
        RET

;	  Subroutine __________________________
;	     Inputs  ________________________
;	     Outputs ________________________

C2B58:	PUSH	HL
        EX	DE,HL
        LD	E,(IX+41)
        LD	D,(IX+42)
        LD	A,D
        OR	E
        JR	Z,J2B83
        LD	C,(IX+43)
        LD	B,(IX+44)
        SBC	HL,BC
        JR	NC,J2B75
        ADD	HL,BC
        LD	E,(IX+39)
        LD	D,(IX+40)
J2B75:	EX	(SP),HL
        POP	BC
J2B77:	LD	A,B
        OR	C
        RET	Z
        DEC	BC
        CALL	FATRED			; get FAT entry content
        NOP
        NOP
        JR	Z,J2B77			; nope,
        DEFB	03EH			; LD A,xx
J2B83:	POP	HL
        LD	A,.FILE
        OR	A
        RET

;	  Subroutine get FAT sector
;	     Inputs  ________________________
;	     Outputs ________________________

C2B88:	LD	B,1			; real read, ignore not recommended
        LD	A,(IX+14)		; number of FAT copies
        BIT	0,(IX+24)
        JR	Z,J2B98			; no DOS2 deleted files, all FAT copies
        DEC	A			; more as 1 FAT copy ?
        JR	NZ,J2B98		; yes, do not use the last FAT copy
                                        ; no, there is only 1 to use, use it

;	  Subroutine get sector
;	     Inputs  B = flag (b0 reset do not real read, b1 reset ignore not recommended), IX = pointer to drivetable, DE = sectornumber
;	     Outputs ________________________

C2B96:	LD	A,1			; only one time
J2B98:	LD	(DBBA2),A
        LD	C,(IX+8)
        LD	HL,(DBBF6)		; last buffer read
        LD	A,H
        SUB	01H
        CALL	NC,C2C44		; buffer contains sector of drive ?
        RET	Z			; yep, quit
        LD	HL,(DBBF8)		; start of the bufferchain
        PUSH	HL
J2BAC:	CALL	C2C44			; buffer contains sector of drive ?
        JP	Z,J2C37			; yep,
        LD	A,(HL)
        INC	HL
        LD	H,(HL)
        LD	L,A
        OR	H			; end of bufferchain ?
        JR	NZ,J2BAC		; nope, continue
        POP	HL			; last buffer
        INC	HL
        INC	HL
        BIT	7,(HL)
        DEC	HL
        LD	A,(HL)
        DEC	HL
        JR	Z,J2BC5
        LD	L,(HL)
        LD	H,A
J2BC5:	CALL	C2D2D			; write buffer if dirty
        PUSH	HL
        INC	HL
        INC	HL
        LD	(HL),C			; driveid
        INC	HL
        LD	A,B
        AND	02H
        LD	(HL),A			; flag
        INC	HL
        LD	(HL),E
        INC	HL
        LD	(HL),D			; sectornumber
        INC	HL
        LD	A,(IY+DBBA2-DBB80)
        LD	(HL),A			; times
        INC	HL
        CALL	SECNUM
        INC	HL
        LD	(HL),A
        PUSH	DE
        INC	HL
        INC	HL
        INC	HL			; the buffer itself
        PUSH	HL
        LD	E,L
        LD	D,H
        INC	DE
        LD	(HL),0
        PUSH	BC
        LD	BC,512-1
        LDIR				; clear buffer
        POP	BC
        EX	(SP),IX
        POP	HL
        LD	(IX-2),L
        LD	(IX-1),H
        POP	DE
        BIT	0,B			; actually read the sector ?
        JR	Z,J2C33			; nope, then finish
J2BFF:	PUSH	BC
        PUSH	DE
        LD	B,(IY+DBBA2-DBB80)	; times
        JR	J2C0C

J2C06:	LD	A,E
        ADD	A,C
        LD	E,A
        JR	NC,J2C0C
        INC	D
J2C0C:	PUSH	DE
        PUSH	BC
        LD	B,1			; 1 sector
        LD	A,(DF2CF)
        LD	C,A			; BDOS datasegment
        LD	A,0			; DSKIO read
        CALL	REDBUF
        POP	BC
        POP	DE
        JR	Z,J2C31			; no error,
        CP	.NOUPB
        JR	Z,J2C23			; disk changed,
        DJNZ	J2C06			; try the next copy (for FAT)
J2C23:	POP	DE
        POP	BC
        OR	A			; reset Cx
        BIT	1,B
        JR	NZ,J2C2B
        SCF				; ignore not recommended
J2C2B:	CALL	C36B0			; handle error
        JR	Z,J2BFF			; retry, do it again
        DEFB	0CAH			; JP Z,xxxx (ignore, skip next 2 instructions)
J2C31:	POP	DE
        POP	BC
J2C33:	EX	(SP),HL
        POP	IX
        DEFB	0FEH			; CP xx (skip next instruction)
J2C37:	POP	BC
        SET	1,(IY+DBBA9-DBB80)	; actually read sector
        LD	(DBBF6),HL		; last buffer read
        CALL	C2CF5			; make buffer the last buffer
        XOR	A
        RET

;	  Subroutine __________________________
;	     Inputs  ________________________
;	     Outputs ________________________

C2C44:	PUSH	HL
        INC	HL
        INC	HL
        LD	A,(HL)
        SUB	C
        JR	NZ,J2C54
        INC	HL
        INC	HL
        LD	A,(HL)
        SUB	E
        JR	NZ,J2C54
        CALL	CMPSEC
J2C54:	POP	HL
        RET

;	  Subroutine mark buffer last read as changed
;	     Inputs  ________________________
;	     Outputs ________________________

C2C56:	LD	HL,(DBBF6)		; last FAT buffer read
        INC	HL
        INC	HL
        INC	HL
        SET	7,(HL)			; buffer changed flag
        RET

;	  Subroutine __________________________
;	     Inputs  ________________________
;	     Outputs ________________________

C2C5F:	PUSH	BC
        PUSH	HL
        CALL	C362C			; get drivetable entry pointer
        POP	HL
        POP	BC
        DEFB	0FEH			; CP xx, continue at 2C68



C2C67:	DEFB	0F6H			; OR xx, use drivetable pointer

;	  Subroutine __________________________
;	     Inputs  ________________________
;	     Outputs ________________________

C2C68:	SCF				; use driveid
        CALL	C2C8B			; mark sectorbuffers of drive
        PUSH	HL
J2C6D:	CALL	C2CBD			; find marked sectorbuffer
        JR	Z,J2CBB		; no more,
        CALL	C2D2D			; write buffer if dirty
        JR	J2C6D			; next

;	  Subroutine __________________________
;	     Inputs  ________________________
;	     Outputs ________________________

C2C77:	DEFB	0F6H			; OR xx, use drivetable pointer

C2C78:	SCF				; use driveid
        CALL	C2C8B			; mark sectorbuffers of drive
        PUSH	HL
J2C7D:	CALL	C2CBD			; find marked sectorbuffer
        JR	Z,J2CBB		; no more,
        CALL	C2CD5			; make buffer the first buffer
        INC	HL
        INC	HL
        LD	(HL),00H		; sectorbuffer unused
        JR	J2C7D

;	  Subroutine __________________________
;	     Inputs  ________________________
;	     Outputs ________________________

C2C8B:	JR	C,J2C96

;	  Subroutine __________________________
;	     Inputs  ________________________
;	     Outputs ________________________

C2C8D:	PUSH	HL
        PUSH	BC
        LD	BC,8
        ADD	HL,BC
        LD	A,(HL)
        POP	BC
        POP	HL
J2C96:	PUSH	HL
        PUSH	DE
        PUSH	BC
        LD	B,A
        LD	HL,(DBBF8)		; start of bufferchain
J2C9D:	LD	E,(HL)
        INC	HL
        LD	D,(HL)
        INC	HL
        LD	A,(HL)
        INC	HL
        RES	0,(HL)
        OR	A
        JR	Z,J2CB4
        CP	B
        JR	Z,J2CB2
        RLCA
        JR	C,J2CB4
        LD	A,B
        INC	A
        JR	NZ,J2CB4
J2CB2:	SET	0,(HL)
J2CB4:	LD	A,D
        OR	E			; end of bufferchain ?
        EX	DE,HL
        JR	NZ,J2C9D		; nope, continue
        POP	BC
        POP	DE
J2CBB:	POP	HL
        RET

;	  Subroutine __________________________
;	     Inputs  ________________________
;	     Outputs ________________________

C2CBD:	LD	HL,(DBBF8)		; start of bufferchain
J2CC0:	PUSH	HL
        INC	HL
        INC	HL
        INC	HL
        BIT	0,(HL)
        RES	0,(HL)
        POP	HL
        RET	NZ
        LD	A,(HL)
        INC	HL
        LD	H,(HL)
        LD	L,A
        OR	H			; end of bufferchain ?
        JR	NZ,J2CC0		; nope, continue
        RET

;	  Subroutine __________________________
;	     Inputs  ________________________
;	     Outputs ________________________

C2CD2:	CALL	C2D2D			; write buffer if dirty

;	  Subroutine make buffer the first buffer
;	     Inputs  ________________________
;	     Outputs ________________________

C2CD5:	PUSH	DE
        LD	DE,(DBBF8)		; start of bufferchain
        OR	A
        SBC	HL,DE
        ADD	HL,DE
        JR	Z,J2D1C
        PUSH	BC
        PUSH	HL
        LD	(DBBF8),HL
        LD	C,(HL)
        INC	HL
        LD	B,(HL)
        PUSH	BC
        LD	(HL),D
        DEC	HL
        LD	(HL),E
        EX	DE,HL
        LD	B,D
        LD	C,E
        CALL	C2D1E
        POP	BC
        JR	J2D16

;	  Subroutine make buffer the last buffer
;	     Inputs  ________________________
;	     Outputs ________________________

C2CF5:	LD	A,(HL)
        INC	HL
        OR	(HL)
        DEC	HL
        RET	Z
        PUSH	DE
        PUSH	BC
        PUSH	HL
        LD	E,(HL)
        INC	HL
        LD	D,(HL)
        PUSH	DE
        XOR	A
        LD	(HL),A
        DEC	HL
        LD	(HL),A
        LD	B,H
        LD	C,L
        LD	HL,DBBF8
        CALL	C2D1E
        EX	DE,HL
        POP	DE
        LD	(HL),E
        INC	HL
        LD	(HL),D
        DEC	HL
        CALL	C2D1E
J2D16:	EX	DE,HL
        LD	(HL),C
        INC	HL
        LD	(HL),B
        POP	HL
        POP	BC
J2D1C:	POP	DE
        RET

;	  Subroutine __________________________
;	     Inputs  ________________________
;	     Outputs ________________________

C2D1E:	LD	E,(HL)
        INC	HL
        LD	D,(HL)
        DEC	HL
        EX	DE,HL
        LD	A,H
        OR	L
        RET	Z
        SBC	HL,BC
        ADD	HL,BC
        JR	NZ,C2D1E
        OR	A
        RET

;	  Subroutine __________________________
;	     Inputs  ________________________
;	     Outputs ________________________

C2D2D:	SET	1,(IY+DBBA9-DBB80)	; actually read sector
        PUSH	HL
        INC	HL
        INC	HL
        LD	A,(HL)
        OR	A
        JR	Z,J2DA2			; buffer not used, quit
        INC	HL
        BIT	7,(HL)			; buffer changed ?
        JR	Z,J2DA2			; nope, quit
        RES	7,(HL)			; sectorbuffer unchanged
        PUSH	DE
        PUSH	BC
        PUSH	IX
J2D43:	PUSH	HL
        BIT	6,(HL)			; update last FAT only ?
        INC	HL
        LD	E,(HL)
        INC	HL
        LD	D,(HL)			; sectornumber
        INC	HL
        LD	B,(HL)			; times
        INC	HL
        JR	Z,J2D59			; update all FATs
        LD	A,E
J2D50:	ADD	A,(HL)			; number of sectors per FAT
        CALL	FSIZE1
J2D54:	DJNZ	J2D50
        LD	E,A			; to the last FAT
        LD	B,1			; 1 FAT
J2D59:	PUSH	DE
        INC	HL
        INC	HL
        LD	E,(HL)
        INC	HL
        LD	D,(HL)			; drivetable of drive
        INC	HL
        EX	DE,HL
        PUSH	DE
        POP	IX			; IX = sectorbuffer
        LD	C,1
        POP	DE
        PUSH	DE
J2D68:	PUSH	DE
        PUSH	BC
        LD	B,1			; 1 sector
        LD	A,(DF2CF)
        LD	C,A			; BDOS datasegment
        LD	A,1			; DSKIO write
        CALL	WRTBUF
        POP	BC
        POP	DE
        JR	NZ,J2D7A		; error,
        INC	C
J2D7A:	CP	.NOUPB
        JR	NZ,J2D81
        LD	BC,0101H		; disk changed, quit writing FAT (flag no FAT copy writen)
J2D81:	PUSH	AF
        LD	A,E
        CALL	FSIZE2
        LD	E,A
        JR	NC,J2D8A
        INC	D
J2D8A:	POP	AF
        DJNZ	J2D68			; next FAT
        POP	DE
        DEC	C			; writen a copy of the FAT without error ?
        JR	NZ,J2D9B		; yep,
        BIT	1,(IX-8)
        JR	NZ,J2D98
        SCF				; ignore not recommended
J2D98:	CALL	C36B0			; handle error
J2D9B:	POP	HL
        JR	Z,J2D43			; retry, do it again
        POP	IX			; ignore, quit
        POP	BC
        POP	DE
J2DA2:	POP	HL
        RET

;	  Subroutine get FAT entry content
;	     Inputs  ________________________
;	     Outputs ________________________

C2DA4:	CALL	C2E55			; get pointer to FAT entry
        JR	Z,J2DB9			; no error, continue
J2DA9:	XOR	A
        LD	(DBBEA),A		; a read diskoperation
        LD	A,.IFAT
        LD	DE,0FFFFH
        CALL	C36AC			; handle error (ignore no problem)
        JR	Z,J2DA9			; retry, again
        JR	J2DD0			; ignore,

J2DB9:	PUSH	HL
        LD	A,(DE)
        LD	L,A
        INC	DE
        LD	A,(DE)
        JR	NC,J2DC5		; even FAT entry
        LD	H,A
        CALL	C2EB6			; shift
        LD	L,H
J2DC5:	AND	0FH
        LD	H,A
        EX	DE,HL
        LD	HL,0FF7H
        SBC	HL,DE			; last cluster in file ?
        POP	HL
        RET	NC			; nope, quit
J2DD0:	LD	DE,0FFFFH		; yep,
        RET

;	  Subroutine convert clusternumber to sectornumber
;	     Inputs  HL=drivetable, DE=clusternumber, A=sectoroffset in cluster
;	     Outputs ________________________

C2DD4:	PUSH	HL
        PUSH	BC
        LD	BC,11
        ADD	HL,BC
        LD	B,(HL)			; clustershift
        EX	DE,HL
        DEC	HL
        DEC	HL
        LD	C,A
        XOR	A
        JR	Z0022
Z0023:	ADD	HL,HL			;bit 0-15 of sector number
        ADC	A,A			;bit16-23 of sector number
Z0022:	DJNZ	Z0023
        LD	B,A			;bit16-23
        LD	A,C
        ADD	A,L
        LD	L,A
        EX	DE,HL			;BDE=sector number
        LD	A,B
        JP	GETSEC
        NOP
        NOP


;	  Subroutine reset deleted files status disk and set FAT entry
;	     Inputs  ________________________
;	     Outputs ________________________

C2DF1:	CALL	C2EC0			; reset deleted files status disk

;	  Subroutine set FAT entry
;	     Inputs  BC = clusternumber
;	     Outputs ________________________

C2DF4:	PUSH	DE
        JP	FATWRT

J2DF8:	JR	C,J2DFD
        LD	BC,0FFFH		; cluster 0F00-FFFF, use endmarker
J2DFD:	CALL	C2E55			; get pointer to FAT entry
        JR	Z,J2E13			; no error,
J2E02:	LD	A,0FFH
        LD	(DBBEA),A		; a write diskoperation
        LD	A,.IFAT
        LD	DE,0FFFFH
        CALL	C36AC			; handle error (ignore no problem)
        JR	Z,J2E02			; retry, loop again
        POP	DE
        RET				; ignore, quit

J2E13:	PUSH	HL
        JR	C,J2E20
        LD	A,C
        LD	(DE),A
        INC	DE
        LD	A,(DE)
        AND	0F0H
        OR	B
        LD	(DE),A
        JR	J2E2D

J2E20:	LD	H,B
        LD	L,C
        CALL	C2EB6
        LD	A,(DE)
        AND	0FH
        OR	L
        LD	(DE),A
        INC	DE
        LD	A,H
        LD	(DE),A
J2E2D:	CALL	C2C56			; mark buffer last read as changed
        BIT	0,(IY+DBBA9-DBB80)	; FAT entry content spans two FAT sectors ?
        JR	Z,J2E52			; nope, quit
        LD	BC,8
        ADD	HL,BC
        LD	(HL),A			; second FAT byte
        DEC	DE
        LD	A,(DE)
        LD	DE,(DBBA7)		; sectornumber of spaned FAT entry
        EX	(SP),IX
        PUSH	AF
        CALL	BUF_1
        CALL	C2C56			; mark buffer last read as changed
        LD	BC,8+511
        ADD	HL,BC
        POP	AF
        LD	(HL),A			; first FAT byte
        EX	(SP),IX
J2E52:	POP	HL
J2E53:	POP	DE
        RET

;	  Subroutine get pointer to FAT entry
;	     Inputs  DE = clusternumber, HL = pointer to drivetable
;	     Outputs ________________________

C2E55:	PUSH	IX
        PUSH	BC
        PUSH	HL
        PUSH	HL
        POP	IX
        RES	0,(IY+DBBA9-DBB80)	; clear FAT entry spans two sectors flag
        LD	L,(IX+22)
        LD	H,(IX+23)		; max cluster
        XOR	A
        SBC	HL,DE
        JR	C,J2EB1			; invalid cluster, quit
        LD	H,D
        LD	L,E
        ADD	HL,HL
        ADD	HL,DE			; cluster * 3
        SRL	H
        RR	L			; cluster * 1.5
        PUSH	AF
        PUSH	HL
        LD	E,H
        SRL	E
        LD	D,A			; FAT sector (offset)
        LD	L,(IX+12)
        LD	H,(IX+13)		; first FAT sector
        ADD	HL,DE			; FAT sector
        EX	DE,HL
        CALL	BUF_1
        LD	BC,11
        ADD	HL,BC			; to sectorbuffer
        POP	BC
        LD	A,B
        AND	01H
        LD	B,A			; offset in sector
        ADD	HL,BC			; pointer to cluster content
        ADD	A,C			; offset 01FF ?
        JR	NC,J2EAC		; nope, content in one FAT sector
        LD	A,(HL)
        SET	0,(IY+DBBA9-DBB80)	; flag double fat sector fatentry
        LD	(DBBA7),DE		; register sector
        LD	(DBBA5+0),A		; register first byte fatentry content
        INC	DE
        CALL	BUF_1
        LD	BC,11
        ADD	HL,BC			; to sectorbuffer
        LD	A,(HL)
        LD	(DBBA5+1),A		; register second byte fatentry content
        LD	HL,DBBA5		; use temporary buffer
J2EAC:	EX	DE,HL
        POP	AF
        SBC	A,A
        CP	A			; clear Cx
        RRCA
J2EB1:	POP	HL
        POP	BC
        POP	IX
        RET

;	  Subroutine __________________________
;	     Inputs  ________________________
;	     Outputs ________________________

C2EB6:	XOR	A
        ADD	HL,HL
        RLA
        ADD	HL,HL
        RLA
        ADD	HL,HL
        RLA
        ADD	HL,HL
        RLA
        RET

;	  Subroutine reset deleted files status disk
;	     Inputs  ________________________
;	     Outputs ________________________

C2EC0:	PUSH	HL
        EX	(SP),IX
        BIT	0,(IX+24)
        JR	Z,J2F34		; disk was not in deleted files mode, quit
        XOR	A
        JR	J2EDD

;	  Subroutine set deleted files status disk
;	     Inputs  ________________________
;	     Outputs ________________________

C2ECC:	PUSH	HL
        EX	(SP),IX
        BIT	7,(IX+25)
        NOP
        NOP
        BIT	0,(IX+24)
        JR	NZ,J2F34		; disk is already in deleted files mode, quit
        LD	A,1
J2EDD:	PUSH	BC
        PUSH	DE
        LD	B,(IX+14)
        DEC	B
        JR	Z,J2F14			; disk has only 1 FAT,
        LD	E,(IX+12)
        LD	D,(IX+13)		; first FAT sector
        LD	B,(IX+17)		; number of sectors per FAT
J2EEE:	PUSH	BC
        PUSH	AF
        DEC	A
        LD	B,00H			; no real read, ignore not recommended
        JR	NZ,J2EFA		; disk currently in delete file mode,
        CALL	BUF_3
        JR	J2F07

J2EFA:	CALL	BUF_1
        CALL	C2D2D			; write buffer if dirty
        PUSH	HL
        CALL	C2C56			; mark buffer last read as changed
        SET	6,(HL)
        POP	HL
J2F07:	CALL	C2CD2
        INC	HL
        INC	HL
        LD	(HL),00H		; buffer not used
        POP	AF
        POP	BC
        INC	DE
        DJNZ	J2EEE			; next FAT sector
        LD	B,A
J2F14:	LD	A,B
        CP	(IX+24)
        JR	Z,J2F32
        PUSH	BC
        LD	DE,0
        LD	B,1			; real read, ignore not recommended
        CALL	BUF_3
        CALL	C2CD5			; make buffer the first buffer
        CALL	C2C56			; mark buffer last read as changed
        CALL	CHKVOL
        POP	BC
        LD	(HL),B
        LD	(IX+24),B
J2F32:	POP	DE
        POP	BC
J2F34:	EX	(SP),IX
        POP	HL
        RET

;	  Subroutine clear FAT
;	     Inputs  A = mediadescriptor
;	     Outputs ________________________

C2F38:	LD	DE,0
        LD	C,A
        LD	B,0FH			; cluster 0 is 0FxxH, xx= mediadescriptor
        CALL	C2DF1			; reset deleted files status disk and set FAT entry
        INC	DE
        LD	BC,0FFFFH		; cluster 1 is 0FFFH
        CALL	C2DF1			; reset deleted files status disk and set FAT entry
J2F48:	INC	DE
        LD	BC,0			; free entry
        CALL	C2DF1			; reset deleted files status disk and set FAT entry
        PUSH	HL
        LD	BC,22
        ADD	HL,BC
        LD	A,(HL)
        INC	HL
        LD	H,(HL)
        LD	L,A
        SBC	HL,DE			; done all clusters ?
        POP	HL
        JR	NZ,J2F48		; nope, next
        RET

;	  Subroutine allocate clusters
;	     Inputs  HL = drivetable, BC = number of clusters, DE = previous cluster in chain (0FFFF if none), A <>0 clears directory
;	     Outputs ________________________

C2F5E:	LD	(DBBAA),A
        PUSH	DE
        PUSH	BC
        LD	DE,0FFFFH
        LD	(DBBA3),DE		; no free cluster found
        PUSH	DE
        LD	DE,2-1			; start with cluster 2 (first cluster)
        JR	J2F72

J2F70:	PUSH	BC
        PUSH	DE
J2F72:	INC	DE
        PUSH	HL
        LD	BC,22
        ADD	HL,BC
        LD	A,(HL)
        INC	HL
        LD	H,(HL)
        LD	L,A			; maximium cluster
        SBC	HL,DE
        POP	HL
        JR	C,J2FB7			; all clusters done,
        PUSH	DE
        CALL	FATRED			; get FAT entry content
        LD	A,D
        OR	E			; free cluster ?
        POP	DE
        JR	NZ,J2F72		; nope, next cluster
        LD	B,D
        LD	C,E
        POP	DE
        CALL	CLST_5
        JR	Z,J2F96			; yep, set FAT entry
        LD	(DBBA3),BC		; no, register free cluster found, do not set FAT entry
J2F96:	CALL	Z,C2DF4			; set FAT entry
        POP	DE
        LD	A,(DBBAA)
        OR	A
        CALL	NZ,C2FC7		; clear directory cluster
        POP	BC
        DEC	BC
        LD	A,B
        OR	C
        JR	NZ,J2F70
        LD	BC,0FFFFH		; end cluster
        CALL	C2DF4			; set FAT entry
        CALL	C2EC0			; reset deleted files status disk
        LD	BC,(DBBA3)		; first cluster of allocated chain
        POP	DE
        XOR	A
        RET

J2FB7:	POP	DE
        POP	DE
        CALL	CLST_6
        NOP
        NOP
        NOP
        CALL	Z,C301A			; yep, delete cluster chain
        POP	DE
        LD	A,.DKFUL
        OR	A			; return with "disk full" error
        RET

;	  Subroutine __________________________
;	     Inputs  ________________________
;	     Outputs ________________________

C2FC7:	PUSH	DE
        LD	A,D
        OR	E
        JR	NZ,J2FE2
        PUSH	HL
        LD	BC,18
        ADD	HL,BC
        LD	C,(HL)
        INC	HL
        LD	B,(HL)			; first sector of rootdirectory
        INC	HL
        LD	E,(HL)
        INC	HL
        LD	D,(HL)			; first data sector
        LD	H,D
        LD	L,E
        SBC	HL,BC			; number of sectors rootdirectory
        CALL	BUF_5
        POP	HL
        JR	J2FED

J2FE2:	PUSH	HL
        LD	BC,10
        ADD	HL,BC
        LD	B,(HL)			; clustermask
        POP	HL
        LD	A,B
        CALL	C2DD4			; convert clusternumber to sectornumber
J2FED:	LD	A,B
        INC	A
        POP	BC
        PUSH	HL
        EX	(SP),IX
        PUSH	BC
        LD	B,A
J2FF5:	PUSH	BC
        JR	NZ,J2FFB
        CALL	C2CD5			; make buffer the first buffer
J2FFB:	LD	B,0			; no real read, ignore not recommended
        CALL	BUF_2
        PUSH	HL
        LD	BC,11
        ADD	HL,BC			; the buffer itself
        XOR	A
J3006:	LD	(HL),A
        INC	HL
        LD	(HL),A
        INC	HL
        DJNZ	J3006
        CALL	C2C56			; mark buffer last read as changed
        POP	HL
        POP	BC
        DEC	DE
        XOR	A
        DJNZ	J2FF5
        POP	DE
        EX	(SP),IX
        POP	HL
        RET

;	  Subroutine delete cluster chain
;	     Inputs  DE = start cluster
;	     Outputs ________________________

C301A:	PUSH	DE
        CALL	FATRED			; get FAT entry content
        POP	BC
        PUSH	DE			; save content (next cluster)
        LD	D,B
        LD	E,C
        LD	BC,0			; free cluster
        CALL	C2DF4			; set FAT entry
        POP	DE
        LD	A,D
        OR	E			; no next cluster (cluster 0) ?
        CALL	CLST_7
        JR	Z,C301A			; nope, next in chain
        RET

        IF	1 EQ 0

;	  Subroutine get choicestring pointer
;	     Inputs  HL = pointer to drivetable
;	     Outputs DE = adres of choicestring

C3031:	LD	A,4			; CHOICE
        CALL	C34FA			; call diskdriver
        RET	NZ			; error, quit
        LD	A,E
        OR	D			; choicestring a zero pointer ?
        RET	Z			; yep, quit
        PUSH	HL
        EX	(SP),IX
        EX	DE,HL
        LD	A,(IX+0)		; slotid diskdriver
        CALL	C000C			; read first byte of choicestring
        EX	DE,HL
        EX	(SP),IX
        POP	HL
        OR	A			; is choicestring a empty string ?
        LD	A,.IFORM
        RET	Z			; yep, return "cannot format this drive" error
        XOR	A
        RET

;	  Subroutine format
;	     Inputs  A(b7)=0 format disk A(b6-b0)=formatid, A(b7)=1 update bootsector A(b0)=0 update only BPB A(b0)=1 replace complete bootsector, IX = start of format workarea, D = segment, BC = size of format workarea, HL = pointer to drivetable
;	     Outputs ________________________

C304E:	BIT	7,A
        JR	NZ,J305D		; b7 set, only update the bootsector
        LD	E,C
        LD	C,D
        LD	D,B
        LD	B,A
        LD	A,5			; DSKFMT
        CALL	C34FA			; call diskdriver
        RET	NZ			; error, quit
        INC	A			; A=1, flag update bootloader
J305D:	PUSH	AF
        LD	IX,IB6D4
        LD	DE,0
        LD	B,1			; only sector 0
        LD	A,(DF2CF)
        LD	C,A			; BDOS datasegment
        LD	A,0			; DSKIO read
        CALL	C34FA			; call diskdriver
        POP	BC
        RET	NZ			; error, quit
        PUSH	BC
        CALL	C336C			; validate bootsector and update DPB
        LD	DE,1
        JR	NZ,J3081		; bootsector not valid, use sector 1 as first FAT sector
        LD	E,(IX+14)
        LD	D,(IX+15)		; first FAT sector
J3081:	LD	B,1
        LD	A,(DF2CF)
        LD	C,A			; BDOS datasegment
        LD	A,0			; DSKIO read
        CALL	C34FA			; call diskdriver
        POP	BC
        RET	NZ			; error, quit
        LD	A,(IX+1)
        AND	(IX+2)
        INC	A			; byte 1 and 2 0FFH ?
        JR	NZ,J3104		; nope, quit with a "not a dos disk" error
        LD	A,(IX+0)
        CP	0F8H			; mediadescriptor 0F8H-0FFH ?
        JR	C,J3104			; nope, quit with a "not a dos disk" error
        LD	C,A
        PUSH	BC
        LD	DE,0
        LD	B,1			; only sector 0
        LD	A,(DF2CF)
        LD	C,A			; BDOS datasegment
        LD	A,0			; DSKIO read
        CALL	C34FA			; call diskdriver
        POP	BC
        RET	NZ			; error, quit
        PUSH	BC
        LD	A,C
        CALL	C33A8			; create bootsector BPB
        POP	BC
        RET	NZ			; error, quit
        BIT	0,B
        JR	Z,J30F5			; b0 not set, write bootsector and quit
        PUSH	HL
        CALL	C32E9			; get pointer to diskserial of bootsector
        JR	Z,J30D7			; has diskserial, skip update bootloader
        LD	HL,I3112
        LD	DE,IB6D4+0001EH
        LD	BC,0099H
        LDIR				; copy DOS2 bootloader
        EX	DE,HL
        LD	DE,0FFB7H
J30D0:	LD	(HL),B
        INC	HL
        INC	DE
        LD	A,D
        OR	E
        JR	NZ,J30D0		; and clear the remainer
J30D7:	LD	HL,(DF2BA+0)
        LD	A,(DF2BA+2)
        LD	B,A
        XOR	A
        SRL	L
        RLA
        SRL	H
        RLA
        SRL	B
        RLA
        LD	C,A
        LD	(IB6D4+00027H+0),HL
        LD	(IB6D4+00027H+2),BC	; serial number disk
        XOR	A
        LD	(IB6D4+00026H),A
        POP	HL
J30F5:	LD	DE,0
        LD	B,1			; only sector 0
        LD	A,(DF2CF)
        LD	C,A			; BDOS datasegment
        LD	A,1			; DSKIO write
        JP	C34FA			; call diskdriver

J3104:	LD	A,.NDOS
        RET

I3107:	defb	0EBH,0FEH,090H
        defb	"MSXDOS23"

I3112:
        .DEPHASE
        .PHASE	0C01EH

RC01E:	jr	RC030
        defb	"VOL_ID"
        defb	0
        defw	0FFFFH,0FFFFH
        defs	5
RC030:	ret	nc
        ld	(RC069+1),de
        ld	(RC071+1),a
        ld	(hl),LOW RC067
        inc	hl
        ld	(hl),HIGH RC067
RC03D:	ld	sp,KBUF+256
        ld	de,RC0AB
        ld	c,00FH
        call	B.BDOS
        inc	a
        jr	z,RC071
        ld	de,00100H
        ld	c,01AH
        call	B.BDOS
        ld	hl,1
        ld	(RC0AB+14),hl
        ld	hl,04000H-00100H
        ld	de,RC0AB
        ld	c,027H
        call	B.BDOS
        jp	00100H
;
RC067:	defw	RC069

RC069:	call	0
        ld	a,c
        and	0FEH
        sub	002H
RC071:	or	000H
        jp	z,J$4022
        ld	de,RC085
        ld	c,009H
        call	B.BDOS
        ld	c,007H
        call	B.BDOS
        jr	RC03D
;
RC085:	defb	"Boot error",13,10
        defb	"Press any key for retry",13,10
        defb	"$"

RC0AB:	defb	0,"MSXDOS  SYS"

RC0B7:
        .DEPHASE
        .PHASE	I3112+RC0B7-RC01E

        ENDIF

;	  Subroutine check diskchange
;	     Inputs  C = drive, B = type (0 = for disk, 1 = for file ,2 = only write dirty sectorbuffers), IX = pointer to FIB
;	     Outputs ________________________

C31AB:	LD	A,C
        CALL	C362C			; get drivetable entry pointer
        LD	(DBBEB),A		; save driveid
        LD	E,(HL)
        INC	HL
        LD	D,(HL)
        LD	A,D
        OR	E			; entry in use ?
        LD	A,C
        RET	Z			; nope, quit
        PUSH	DE
        DEC	B
        JR	NZ,J3229		; check is not for file, skip

J31BD:	PUSH	IX			; check for file
        POP	HL			; pointer to FIB
        LD	BC,26
        ADD	HL,BC
        EX	DE,HL			; DE = pointer diskserial of FIB
        POP	HL			; pointer to drivetable
        CALL	C364D			; update counter of all drives
        PUSH	IX
        PUSH	HL
        LD	C,9
        ADD	HL,BC
        LD	A,(HL)
        OR	A
        JR	Z,J31E4			; special value 0 (INIT), do not write dirty sectorbuffers of drive
        LD	C,10H
        ADD	HL,BC			; diskserial of drivetable
        LD	C,A
        PUSH	DE
        CALL	C3311			; compare diskserials drivetable and FIB
        POP	DE
        JR	Z,J31ED			; equal,
        LD	A,(DBBEB)		; saved driveid
        CALL	C2C68			; write dirty sectorbuffers of drive
J31E4:	POP	HL
        CALL	C331B			; read bootsector and make valid
        PUSH	HL
        LD	C,1			; flag update drivetable
        JR	J31FF

J31ED:	POP	HL
        PUSH	HL
        DEC	C
        JR	Z,J31FA			; special value 1 (ERROR), skip disk change check (as if disk is changed)
        DEC	C
        JR	NZ,J3217		; within 0.5 seconds of last diskoperation of drive, assume disk is unchanged, quit
        CALL	C32B2			; get disk change status
        JR	Z,J3217			; unchanged,
J31FA:	CALL	C331B			; read bootsector and make valid
        LD	C,0			; flag do not update drivetable
J31FF:	CALL	C3273			; next 0.5 seconds no disk change
        PUSH	DE
        CALL	C32E9			; get pointer to diskserial of bootsector
        POP	DE
        CALL	C3311			; compare diskserials
J320A:	POP	HL
        PUSH	HL
        JR	NZ,J3219		; not equal, error!
        DEC	C
        JR	NZ,J3217		; do not update drivetable, quit
        CALL	C3427			; update drivetable with bootsector BPB
        CALL	C2C77			; mark all sectorbuffers of drivetable unused
J3217:	JR	J3268			; quit

J3219:	LD	A,.WFILE		; "wrong disk for file" error
        LD	DE,0FFFFH
        CALL	C36AF			; handle error (ignore not recommended)
        POP	HL
        JR	NZ,J324F		; ignore, update drivetable and serials
        POP	IX
        PUSH	HL
        JR	J31BD			; retry, check again

J3229:	POP	HL
        CALL	C2C67			; write dirty sectorbuffers of drivetable
        CALL	C364D			; update counter of all drives
        PUSH	IX
        PUSH	HL
        LD	DE,9
        ADD	HL,DE
        LD	A,(HL)
        POP	HL
        DEC	B
        JR	Z,J3255			; type=2,
        OR	A
        JR	Z,J324C			; special value 0 (INIT), treat as disk changed
        DEC	A
        JR	Z,J324C			; special value 1 (ERROR), treat as disk changed
        DEC	A
        JR	NZ,J3258		; within 0.5 seconds of last diskoperation of drive, skip
        CALL	C32B2			; get disk change status
        JR	C,J324C			; diskdriver does not know, treat this as disk changed
        JR	Z,J3258			; unchanged,
J324C:	CALL	C331B			; read bootsector and make valid
J324F:	CALL	C3427			; update drivetable with bootsector BPB
        CALL	C2C77			; mark all sectorbuffers of drivetable unused
J3255:	CALL	C3273			; next 0.5 seconds no disk change
J3258:	POP	DE
        PUSH	DE
        PUSH	HL
        LD	BC,25
        ADD	HL,BC			; diskserial of drivetable
        EX	DE,HL
        LD	C,26
        ADD	HL,BC			; diskserial of FIB
        EX	DE,HL
        LD	C,4
        LDIR				; copy drivetable diskserial to FIB diskserial
J3268:	POP	HL
        POP	IX
        XOR	A
        RET

;	  Subroutine diskdriver
;	     Inputs  A=function
;	     Outputs ________________________

C326D:	CALL	C3282
        CALL	J34FE

;	  Subroutine __________________________
;	     Inputs  ________________________
;	     Outputs ________________________

C3273:	PUSH	HL
        CALL	C364D			; update counter of all drives
        EX	(SP),IX
        LD	(IX+9),2+5		; next 0.5 seconds no disk change
        EX	(SP),IX
        POP	HL
        OR	A
        RET

;	  Subroutine __________________________
;	     Inputs  ________________________
;	     Outputs ________________________

C3282:	CALL	C364D			; update counter of all drives
        PUSH	AF
        PUSH	DE
        PUSH	HL
        LD	DE,9
        ADD	HL,DE
        LD	A,2
        CP	(HL)
        POP	HL
        JR	C,J32AF			; special values, quit
        PUSH	BC
        CALL	Z,C32B2			; get disk change status
        JR	Z,J32AE			; unchanged,
        PUSH	IX
J329A:	CALL	C331B			; read bootsector and make valid
        CALL	C32D3			; compare diskserial bootsector and drivetable
        JR	Z,J32AC			; equal, quit
        LD	A,.WDISK		; "Wrong disk" error
        LD	DE,0FFFFH
        CALL	C36AF			; handle error (ignore not recommended)
        JR	J329A			; check again

J32AC:	POP	IX
J32AE:	POP	BC
J32AF:	POP	DE
        POP	AF
        RET

;	  Subroutine get disk change status
;	     Inputs  ________________________
;	     Outputs Zx set = unchanged, Zx reset = changed, Cx set = diskdriver does not know

C32B2:	PUSH	BC
        PUSH	DE
        LD	A,2			; DSKCHG
        CALL	C34FA			; call diskdriver
        JR	Z,J32C5			; no error,
        CP	.NRDY
        LD	DE,0FFFFH
        CALL	Z,C36AF			; handle error (ignore not recommended)
        LD	B,0FFH			; "disk changed"
J32C5:	DEC	B
        JR	Z,J32D0			; disk unchanged, quit
        INC	B
        JR	NZ,J32D0		; disk changed, quit
        LD	A,(DF2EC)
        INC	A			; if disk check level weak, return unchanged status
        SCF				; if disk check level strong, return changed status
J32D0:	POP	DE
        POP	BC
        RET

;	  Subroutine compare diskserial bootsector and drivetable
;	     Inputs  IX = pointer to bootsector, HL = pointer to drivetable
;	     Outputs ________________________

C32D3:	PUSH	HL
        CALL	C32E9			; get pointer to diskserial of bootsector
        EX	DE,HL
        POP	HL
        PUSH	HL
        LD	BC,25
        ADD	HL,BC
        CALL	C3311			; compare diskserials
        JR	NZ,J32E7
        LD	A,(HL)
        CP	(IX+21)
J32E7:	POP	HL
        RET

;	  Subroutine get pointer to diskserial
;	     Inputs  IX = pointer to bootsector
;	     Outputs HL = pointer to diskserial

C32E9:	PUSH	IX
        POP	HL
        LD	DE,32
        ADD	HL,DE
        LD	DE,I3306
        LD	B,6
J32F5:	LD	A,(DE)
        CP	(HL)
        JR	NZ,GETVOL
        INC	HL
        INC	DE
        DJNZ	J32F5
        INC	HL
        XOR	A
        RET

J3300:	LD	HL,I330D
        XOR	A
        DEC	A
        RET

I3306:	defb	"VOL_ID",0

I330D:	defw	0FFFFH,0FFFFH

;	  Subroutine compare diskserials
;	     Inputs  ________________________
;	     Outputs ________________________

C3311:	LD	B,4
J3313:	LD	A,(DE)
        SUB	(HL)
        RET	NZ
        INC	DE
        INC	HL
        DJNZ	J3313
        RET

;	  Subroutine read bootsector and make valid
;	     Inputs  ________________________
;	     Outputs ________________________

C331B:	PUSH	BC
        PUSH	DE
        LD	IX,IB6D4
J3321:	LD	DE,0
        LD	B,1			; only sector 0
        LD	A,(DF2CF)
        LD	C,A			; BDOS datasegment
        LD	A,0			; DSKIO read
        CALL	C34FA			; call diskdriver
        JR	NZ,J3364		; error,
        CALL	C336C			; validate bootsector and update BPB
        JR	Z,J335F			; valid, quit
        JR	J3362

GETVOL:
        PUSH	IX
        POP	HL
        LD	DE,000Ah
        ADD	HL,DE
        LD	A,(HL)			;UNDEL FLG (DOS1,FAT16)
        CP	01h
        JR	Z,GETV_1
        XOR	A
GETV_1:	LD	HL,I3306+6
        LD	(HL),A
        INC	HL
        XOR	A
        DEC	A
        RET

CHKVOL:
        PUSH	AF
        LD	A,(IX+19h)		;check VOL
        CP	0FFh
        LD	DE,002Eh
        JR	NZ,VOL_1
        LD	DE,0012h
VOL_1:	POP	AF
        RET

        NOP
        NOP

J335F:	POP	DE
        POP	BC
        RET

J3362:	LD	A,.NDOS
J3364:	LD	DE,0FFFFH
        CALL	C36AF			; handle error (ignore not recommended)
        JR	J3321			; try again

;	  Subroutine validate bootsector and update DPB
;	     Inputs  IX = pointer to bootsector, HL = pointer to DPB
;	     Outputs ________________________

C336C:	PUSH	IX
        EX	(SP),HL

; Start of Change

        LD	A,(HL)
        CP	0E9H
        JR	Z,BPBFND
        CP	0EBH
        JR	NZ,J33A5
        LD	A,(IX+2)
        CP	090H
        JR	NZ,J33A5		; check if BPB indicator
BPBFND:

; End of Change

        LD	DE,11
        ADD	HL,DE
        LD	D,(HL)
        INC	HL
        LD	A,(HL)
        INC	HL
        SUB	02H
        OR	D			; sectorsize 512 ?
        JR	NZ,J33A5		; nope, quit with error
        OR	(HL)
        JR	Z,J33A5			; clustersize 0, quit with error
        NEG
        AND	(HL)
        CP	(HL)			; clustersize a power of 2 ?
        INC	HL
        JR	NZ,J33A5		; nope, quit with error
        INC	HL
        INC	HL
        LD	A,(HL)			; number of FAT copies
        DEC	A
        CP	7
        JR	NC,J33A5		; not 1-7, quit with error
        LD	DE,6
        ADD	HL,DE
        LD	A,(HL)			; number of FAT sectors
        POP	HL
        LD	B,(IX+21)		; mediadescriptor
        LD	A,3			; GETDPB
        CALL	C34FA			; call diskdriver
        RET

        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP

J33A5:	POP	HL
        OR	H
        RET


        IF	1 EQ 0

;	  Subroutine create bootsector BPB
;	     Inputs  ________________________
;	     Outputs ________________________

C33A8:	LD	B,A
        LD	A,3			; GETDPB
        CALL	C34FA			; call diskdriver
        RET	NZ			; error, quit
        PUSH	HL
        LD	DE,2
        ADD	HL,DE
        LD	E,(HL)
        INC	HL
        LD	D,(HL)
        PUSH	DE
        EX	(SP),IX			; IX = pointer to DPB
        POP	HL
        PUSH	HL
        LD	DE,11
        ADD	HL,DE
        LD	C,(IX+2)
        LD	B,(IX+3)		; sectorsize (DPB)
        LD	(HL),C
        INC	HL
        LD	(HL),B
        INC	HL
        LD	A,(IX+6)		; clustermask (DPB)
        INC	A
        LD	(HL),A
        INC	HL
        LD	C,(IX+8)
        LD	B,(IX+9)		; first FAT sector (DPB)
        LD	(HL),C
        INC	HL
        LD	(HL),B
        INC	HL
        LD	A,(IX+10)		; number of FAT copies (DPB)
        LD	(HL),A
        INC	HL
        EX	DE,HL
        LD	L,(IX+12)
        LD	H,(IX+13)		; first data sector (DPB)
        PUSH	HL
        LD	C,(IX+17)
        LD	B,(IX+18)		; first rootdirectory sector (DPB)
        OR	A
        SBC	HL,BC
        LD	B,(IX+5)
J33F3:	ADD	HL,HL
        DJNZ	J33F3
        DEC	HL
        LD	L,(IX+11)		; number of rootdirectory entries (DPB)
        DEC	L
        INC	HL
        EX	DE,HL
        LD	(HL),E
        INC	HL
        LD	(HL),D
        INC	HL
        EX	DE,HL
        LD	L,(IX+14)
        LD	H,(IX+15)		; maximium cluster (DPB)
        DEC	HL
        LD	B,(IX+7)		; clustershift (DPB)
        DEFB	00EH			; LD C,xx
J340D:	ADD	HL,HL
        DJNZ	J340D
        POP	BC
        ADD	HL,BC
        EX	DE,HL
        LD	(HL),E
        INC	HL
        LD	(HL),D
        INC	HL
        LD	A,(IX+1)		; mediadescriptor (DPB)
        LD	(HL),A
        INC	HL
        LD	A,(IX+16)		; number of sectors per FAT (DPB)
        LD	(HL),A
        INC	HL
        XOR	A
        LD	(HL),A
        POP	IX
        POP	HL
        RET

        ENDIF



;	  Subroutine update drivetable with bootsector BPB info
;	     Inputs  HL = pointer to drivetable, IX = pointer to bootsector
;	     Outputs ________________________

C3427:	PUSH	HL
        LD	BC,10
        ADD	HL,BC
        LD	A,(IX+13)
        DEC	A
        LD	(HL),A
        INC	HL
        LD	C,00H
J3434:	INC	C
        RRCA
        JR	C,J3434
        LD	(HL),C
        INC	HL
        LD	E,(IX+14)
        LD	(HL),E
        INC	HL
        LD	D,(IX+15)
        LD	(HL),D
        INC	HL
        PUSH	DE
        LD	B,(IX+16)
        LD	(HL),B
        INC	HL
        LD	E,(IX+17)
        LD	D,(IX+18)
        LD	A,E
        AND	0FH
        LD	(HL),A
        LD	A,04H
J3456:	SRL	D
        RR	E
        DEC	A
        JR	NZ,J3456
        NOP
        INC	HL
        LD	(HL),E
        INC	HL
        JR	NC,J3464
        INC	DE
J3464:	LD	A,(IX+22)
        LD	(HL),A
        INC	HL
        EX	(SP),HL
        PUSH	DE
        LD	E,A
        XOR	A
        LD	D,A
J346E:	ADD	A,E
        CALL	FSIZE3
J3472:	DJNZ	J346E
        LD	E,A
        ADD	HL,DE
        EX	DE,HL
        POP	HL
        ADD	HL,DE
        EX	(SP),HL
        LD	(HL),E
        INC	HL
        LD	(HL),D
        INC	HL
        POP	DE
        LD	(HL),E
        INC	HL
        LD	(HL),D
        INC	HL
        PUSH	HL
        LD	L,(IX+19)
        LD	H,(IX+20)
        JP	TALCLS

J348D:	DEC	C
        JR	Z,J3496
        SRL	H
        RR	L
        JR	J348D
J3496:	INC	HL
        EX	DE,HL
        POP	HL
        LD	(HL),E
        INC	HL
        LD	(HL),D
        INC	HL
        PUSH	HL
        CALL	C32E9			; get pointer to diskserial of bootsector
        POP	DE
        DEC	HL
        LD	BC,5
        LDIR
        EX	DE,HL
        CALL	DPBSET
        NOP
        POP	HL
        PUSH	HL
        INC	HL
        INC	HL
        LD	E,(HL)
        INC	HL
        LD	D,(HL)
        EX	DE,HL
        INC	HL
        LD	(HL),A
        INC	HL
        LD	(HL),00H
        INC	HL
        LD	(HL),02H
        INC	HL
        LD	(HL),0FH
        INC	HL
        LD	(HL),04H
        INC	HL
        EX	DE,HL
        LD	BC,7
        ADD	HL,BC
        LD	BC,5
        LDIR
        LD	C,(HL)
        INC	HL
        LD	A,(HL)
        INC	HL
        ADD	A,A
        ADD	A,A
        ADD	A,A
        ADD	A,A
        OR	C
        LD	(DE),A
        INC	DE
        PUSH	HL
        INC	HL
        INC	HL
        INC	HL
        LD	BC,4
        LDIR
        POP	HL
        LD	BC,3
        LDIR
        POP	HL

;	  Subroutine __________________________
;	     Inputs  ________________________
;	     Outputs ________________________

C34E9:	PUSH	HL
        PUSH	BC
        LD	BC,31
        ADD	HL,BC
        POP	BC
        CALL	CLST_A
        JR	NZ,J34F8
        LD	(HL),A
        DEC	HL
        LD	(HL),A
J34F8:	POP	HL
        RET

;	  Subroutine call diskdriver
;	     Inputs  A=function, HL=drivetable, BC=, DE=, IX=diskdriver HL
;	     Outputs ________________________

C34FA:	JP	DSKROM
        NOP
J34FE:	PUSH	IY
        PUSH	HL
        PUSH	HL
        EX	(SP),IX
        POP	HL
        PUSH	HL
        EXX
        PUSH	HL
        PUSH	DE
        PUSH	BC
        EX	AF,AF'
        PUSH	AF
        LD	A,(IX+8)
        DEC	A
        LD	(DF33F),A		; setup driveid for prompt routine
        LD	A,(IX+6)		; driveid for diskdriver
        EX	AF,AF'
        LD	C,A
        CP	1
        LD	A,0FFH
        JR	Z,J351F			; DSKIO write, flag write operation
        INC	A
J351F:	LD	(DBBEA),A		; disk operation
        LD	HL,I3548
        LD	B,0
        ADD	HL,BC
        ADD	HL,BC
        LD	A,(HL)
        INC	HL
        LD	H,(HL)
        LD	L,A
        LD	A,(DF2CD)		; saved DOS page 2 segment
        EX	AF,AF'
        CALL	C3547			; call diskdriver function
        EX	AF,AF'
        POP	AF
        EX	AF,AF'
        EXX
        POP	BC
        POP	DE
        POP	HL
        EXX
        POP	IX
        POP	HL
        POP	IY
        OR	A
        RET
J3543:	LD	A,.INTER
        OR	A
        RET

;	  Subroutine call routine
;	     Inputs  HL = adres of routine
;	     Outputs -

C3547:	JP	(HL)

I3548:	defw	A3554
        defw	A3557
        defw	A3571
        defw	A358C
        defw	A35A2
        defw	A35AD

A3554:	OR	A
        JR	J3558

A3557:	SCF

J3558:	EX	AF,AF'
        LD	HL,04000H		; DSKIO
        EXX
        LD	A,C
        CALL	SETNUM
        PUSH	BC
        CALL	C35EC
        JR	C,J356A
        POP	BC
        XOR	A
        RET
J356A:	EX	AF,AF'
        POP	AF
        SUB	B
        LD	B,A
        EX	AF,AF'
        JR	J35C3

A3571:	EX	AF,AF'
        LD	HL,04003H		; DSKCHG
        EXX
        LD	B,00H
        LD	C,(IX+29)		; mediadescriptor
        LD	L,(IX+2)
        LD	H,(IX+3)		; pointer to DPB
        CALL	C35EC
        JR	C,J3588
        XOR	A
        RET
J3588:	LD	B,00H
        JR	J35C3

A358C:	EX	AF,AF'
        LD	HL,04006H		; GETDPB
        EXX
        LD	C,(IX+29)		; mediadescriptor
        LD	L,(IX+2)
        LD	H,(IX+3)		; pointer to DPB
        CALL	C35EC
        LD	A,0FFH
        RET	C
        XOR	A
        RET

A35A2:	EX	AF,AF'
        LD	HL,04009H		; CHOICE
        EXX
        CALL	C35EC
        EX	DE,HL
        XOR	A
        RET

A35AD:	LD	HL,0400CH		; DSKFMT
        EXX
        PUSH	DE
        LD	D,A
        LD	A,B
        EX	AF,AF'
        LD	A,C
        POP	BC
        CALL	C35EC
        JR	C,J35BE
        XOR	A
        RET
J35BE:	LD	HL,I35E2
        JR	J35C6

J35C3:	LD	HL,I35D4
J35C6:	RRCA
        CP	(HL)
        JR	NC,J35D1
        INC	HL
        LD	E,A
        LD	D,00H
        ADD	HL,DE
        LD	A,(HL)
        RET

J35D1:	LD	A,.DISK
        RET


; errorcodes for all diskdriver routines, except DSKFMT

I35D4:	defb	13+1
        defb	.WPROT			; 0 = write protect
        defb	.NRDY			; 2 = not ready
        defb	.DATA			; 4 = crc error
        defb	.SEEK			; 6 = seek error
        defb	.RNF			; 8 = record not found
        defb	.WRERR			; 10 = write fault
        defb	.DISK			; 12 = other errors
        defb	.DISK			; 14 = unused (?)
        defb	.DISK			; 16 = unused (?)
        defb	.NDOS			; 18 = not a dos disk
        defb	.NCOMP			; 20 = incompatible disk
        defb	.UFORM			; 22 = unformatted disk
        defb	.NOUPB			; 24 = changed disk (used internally)

; errorcodes for DSKFMT diskdriver routine

I35E2:	defb	9+1
        defb	.WPROT			; 0 = write protect
        defb	.NRDY			; 2 = not ready
        defb	.DATA			; 4 = crc error
        defb	.SEEK			; 6 = seek error
        defb	.RNF			; 8 = record not found
        defb	.WRERR			; 10 = write fault
        defb	.IPARM			; 12 = bad parameter
        defb	.NORAM			; 14 = insufficient memory
        defb	.DISK			; 16 = other errors
;
;	  Subroutine __________________________
;	     Inputs  ________________________
;	     Outputs ________________________
;
C35EC:
        IF	USESBF EQ 1

        CALL	C0AB9			; empty screenoutput buffer

        ENDIF

        EXX
        LD	E,(IX+1)		; diskdriver jumptable offset
        LD	D,0
        ADD	HL,DE			; + base adres
        LD	B,(IX+0)
        CALL	CF224			; PUT_P2
        PUSH	BC
        POP	IY
        PUSH	HL
        POP	IX
        EXX
        EX	AF,AF'
        CALL	CF1DF			; interslot call with prompt handler
        EI
        EX	AF,AF'
        LD	A,(DF2CF)		; BDOS datasegement
        CALL	CF224			; PUT_P2
        EX	AF,AF'
        RET

;	  Subroutine __________________________
;	     Inputs  ________________________
;	     Outputs ________________________

C3611:	LD	B,8
J3613:	LD	A,B
        CALL	C362C			; get drivetable entry pointer
        LD	E,(HL)
        INC	HL
        LD	D,(HL)
        LD	A,D
        OR	E
        JR	Z,J3628
        LD	HL,9
        ADD	HL,DE
        LD	A,(HL)
        OR	A
        JR	Z,J3628			; special value 0 (INIT), leave it alone
        LD	(HL),1			; special value 1 (ERROR)
J3628:	DJNZ	J3613
        XOR	A
        RET

;	  Subroutine __________________________
;	     Inputs  ________________________
;	     Outputs ________________________

C362C:	PUSH	DE
        OR	A
        JR	NZ,J3633
        LD	A,(DF23C)
J3633:	LD	C,.IDRV
        CP	09H
        JR	C,J363A
        XOR	A
J363A:	LD	HL,IBA1A
        LD	E,A
        LD	D,0
        ADD	HL,DE
        LD	A,(HL)
        LD	E,A
        LD	D,0
        LD	HL,IBA23
        ADD	HL,DE
        ADD	HL,DE
        POP	DE
        OR	A
        RET

;	  Subroutine update counter of all drives
;	     Inputs  ________________________
;	     Outputs ________________________

C364D:	PUSH	AF
        PUSH	HL
        LD	HL,(DF34D)		; pointer to diskdriver sectorbuffer
        DEC	HL
        LD	A,(HL)			; FAT buffer status flag
        INC	A
        JR	NZ,J3673		; FAT buffer unchanged or FAT buffer changed,
        LD	(HL),0			; FAT buffer invalid, now FAT unchanged
        LD	A,(DF33F)
        PUSH	DE
        LD	E,A
        LD	D,0
        LD	HL,IBA23+2
        ADD	HL,DE
        ADD	HL,DE
        LD	E,(HL)
        INC	HL
        LD	D,(HL)			; pointer to drivetable
        LD	HL,9
        ADD	HL,DE
        POP	DE
        LD	A,(HL)			; counter of drive
        OR	A
        JR	Z,J3673			; special value 0 (INIT), leave this unchanged
        LD	(HL),1			; special value 1 (ERROR)
J3673:	LD	HL,IF2BF
        DI
        LD	A,(HL)			; counter already reset ?
        EI
        LD	(HL),0			; reset counter
        OR	A
        JR	Z,J36A9			; was already reset, quit
        PUSH	BC
        PUSH	DE
        PUSH	IX
        LD	C,A			; counter value
        LD	HL,IBA23+2
        LD	B,8			; all 8 possible drives
J3688:	LD	E,(HL)
        INC	HL
        LD	D,(HL)			; drivetable
        INC	HL
        LD	A,D
        OR	E
        JR	Z,J36A3			; drive does not exists, next
        PUSH	DE
        POP	IX
        LD	A,(IX+9)		; counter of drive
        SUB	2
        JR	C,J36A3			; special values (0 and 1), leave the counter unchanged, next
        SUB	C			; adjust counter
        JR	NC,J369E
        XOR	A			; bottom value counter of drive
J369E:	ADD	A,2
        LD	(IX+9),A
J36A3:	DJNZ	J3688
        POP	IX
        POP	DE
        POP	BC
J36A9:	POP	HL
        POP	AF
        RET

;	  Subroutine handle error (ignore no problem)
;	     Inputs  ________________________
;	     Outputs ________________________

C36AC:	OR	A
        JR	C36B0

;	  Subroutine handle error (ignore not recommended)
;	     Inputs  ________________________
;	     Outputs ________________________

C36AF:	SCF

;	  Subroutine handle error
;	     Inputs  HL = pointer to drivetable
;	     Outputs A = result (0=retry,1=ignore), Zx set if retry

C36B0:	PUSH	BC
        PUSH	DE
        PUSH	HL
        EXX
        PUSH	HL
        PUSH	DE
        PUSH	BC
        EXX
        EX	AF,AF'
        PUSH	AF
        EX	AF,AF'
        PUSH	IX
        PUSH	AF
        LD	C,0			; no flags set
        JR	NC,J36C4
        SET	1,C			; flag ignore not recommended
J36C4:	LD	A,(DBBEA)
        OR	A
        JR	Z,J36CC			; read operation,
        SET	0,C			; write operation, flag a write diskoperation
J36CC:	LD	A,D
        AND	E
        INC	A
        JR	Z,J36D3			; sectornumber 0FFFFH, no sectornumber
        SET	3,C			; flag sectornumber valid
J36D3:	PUSH	HL
        PUSH	BC
        LD	BC,8
        ADD	HL,BC
        POP	BC
        LD	B,(HL)			; physical driveid
        INC	HL
        LD	A,(HL)
        OR	A
        JR	Z,J36E2			; special value 0 (INIT), leave it alone
        LD	(HL),1			; special value 1 (ERROR)
J36E2:	POP	HL
        POP	AF
        CP	.STOP
        JR	Z,J3744			; CTRL-STOP, go to abort handler
        CP	.NOUPB
        JR	Z,J372E			; disk changed "error", fake a abort
        CP	.IFAT
        JR	NZ,J36F2
        SET	2,C			; invalid FAT, flag auto-abort suggested
J36F2:	PUSH	AF
        LD	HL,I3755-1		; error table
J36F6:	INC	HL
        CP	(HL)
        INC	HL
        JR	Z,J36FF
        BIT	7,(HL)
        JR	Z,J36F6			; not end of table, next entry
J36FF:	LD	A,(HL)
        ADD	A,A			; remove b7
        BIT	0,C
        JR	Z,J3706
        INC	A			; b0 = 1 for write operation, 0 for read operation
J3706:	BIT	2,C
        JR	Z,J370C
        SET	7,A			; b7 = 1 for auto-abort suggested, 0 if not
J370C:	EX	AF,AF'
        POP	AF
        LD	H,(IY+DBB89-DBB80)	; save current console redirection status
        PUSH	HL
        LD	(IY+DBB89-DBB80),0	; temperarly no console redirection
        PUSH	AF
        PUSH	IY
        LD	HL,(DF300)
        CALL	C374C			; call diskerror handler with DOS segments active
        POP	IY
        POP	BC
        POP	HL
        LD	(IY+DBB89-DBB80),H	; restore console redirection status
        DEC	A
        CP	3
        JR	C,J3730			; resultcode 1-3
        XOR	A
        JR	J3730			; resultcode 0 or 4-255, call system error routine

J372E:	LD	A,1			; abort
J3730:	POP	IX
        EX	AF,AF'
        POP	AF
        EX	AF,AF'
        EXX
        POP	BC
        POP	DE
        POP	HL
        EXX
        POP	HL
        OR	A
        JR	Z,J3742			; call system error routine (abort program)
        POP	DE
        POP	BC
        DEC	A			; result
        RET

J3742:	LD	A,.ABORT
J3744:	PUSH	AF
        CALL	C2C77			; mark all sectorbuffers of drivetable unused
        POP	AF

;	  Subroutine call program abort routine with DOS segments active
;	     Inputs  ________________________
;	     Outputs ________________________

C3749:	LD	HL,(DF302)

;	  Subroutine call routine with DOS segments active
;	     Inputs  ________________________
;	     Outputs ________________________

C374C:	PUSH	HL
        LD	HL,IF1F7
        EX	(SP),HL			; enable BDOS segments afterwards
        PUSH	HL			; call HL
        JP	JF1FA			; enable DOS segments

I3755:	defb	.WPROT,0
        defb	.NRDY,1
        defb	.DATA,2
        defb	.SEEK,3
        defb	.RNF,4
        defb	.WRERR,5
        defb	.DISK,6
        defb	.DISK,7
        defb	.DISK,8
        defb	.NDOS,9
        defb	.NCOMP,10
        defb	.UFORM,11
        defb	.NOUPB,12
        defb	0,6+128

;	  Subroutine _FOPEN (BDOS 0FH)
;	     Inputs  ________________________
;	     Outputs ________________________

A3771:	LD	(IY+DBBAF-DBB80),4	; search directory entry
        LD	A,02H			; normal and hidden files
        LD	C,1			; use APPEND
J3779:	CALL	C3A59			; get directory entry and setup FIB
        JR	NZ,J37B1		; error, quit with error
        XOR	A
        PUSH	DE
        CALL	C228E			; setup FIB for open
        POP	DE
        LD	HL,(DBB96)		; saved pointer to FCB
        PUSH	HL
        LD	A,(DBB98)
        OR	A			; APPEND used ?
        JR	Z,J3792
        LD	A,(IB9DA+25)
        LD	(HL),A			; yep, update DR byte FCB
J3792:	CALL	C3D28			; copy filename back to FCB
        INC	HL
        LD	A,(DE)			; fileattribute
        LD	(HL),A			; in S1 byte FCB
        INC	HL
        LD	(HL),0			; reset high byte extent FCB
        POP	IX
        CALL	C3CDA			; setup dos2 specific FCB fields
        XOR	A			; record 0 in extent
        CALL	C3CAE			; setup random record from current extent FCB
        CALL	C3C74			; setup recordcount in current extent FCB
        LD	A,(IB9DA+25)
        CALL	C2C5F			; write dirty sectorbuffers of assigned drive
J37AD:	XOR	A
        LD	L,A
        LD	H,A			; quit with ok
        RET

J37B1:	LD	HL,00FFH
        RET

;	  Subroutine _FCLOSE
;	     Inputs  ________________________
;	     Outputs ________________________

A37B5:	CALL	C39C3			; rebuild FIB from FCB
        JR	NZ,J37B1		; error, quit with error
        LD	DE,(DBB96)		; saved pointer to FCB
        CALL	C3A3B
        CALL	C2244			; if file is changed get directory entry and change time/date
        OR	A
        JR	NZ,J37B1
        LD	A,(IX+25)
        CALL	C2C5F			; write dirty sectorbuffers of assigned drive
        JR	J37AD			; quit with ok

;	  Subroutine _SFIRST
;	     Inputs  ________________________
;	     Outputs ________________________

A37CF:	LD	HL,12
        ADD	HL,DE
        LD	A,(HL)
        LD	(DBB95),A		; save requested extent
        LD	(IY+DBBAF-DBB80),4	; search directory entry
        LD	A,(DE)
        ADD	A,A
        SBC	A,A
        AND	10H			; search for normal files, but if b7 of DR is set also for subdirs
        LD	C,0			; do not use APPEND
        CALL	C3A59			; get directory entry and setup FIB
        JR	NZ,J37B1		; error, quit with error
        JR	J3802

;	  Subroutine _SNEXT
;	     Inputs  ________________________
;	     Outputs ________________________

A37E9:	LD	DE,IB9DA
        LD	HL,IB99A
        LD	BC,64
        LD	A,(HL)
        CP	0FFH
        LD	A,.NOFIL
        JP	NZ,J37B1		; no saved FIB, quit with "File not found" error
        LDIR				; copy saved FIB back
        CALL	C3B1D			; try to get next directory entry
        JP	NZ,J37B1		; error, quit with error
J3802:	PUSH	DE
        LD	HL,IB9DA
        LD	DE,IB99A
        LD	BC,64
        LDIR				; save FIB for search next
        POP	DE
        LD	HL,IB975
        LD	A,(IB9DA+25)
        LD	(HL),A			; DR byte FCB = driveid
        CALL	C3D28			; copy filename back to FCB
        LD	A,(DBB95)
        LD	(HL),A			; EX byte FCB = requested extent
        INC	HL
        LD	A,(DE)
        LD	(HL),A			; S1 byte FCB = fileattribute
        INC	HL
        INC	DE
        INC	DE
        LD	(HL),0			; clear S2 byte FCB
        INC	HL
        INC	DE
        EX	DE,HL
        LD	BC,18
        LDIR				; setup RC, AL and CR bytes
        LD	IX,IB975
        XOR	A			; record 0 in extent
        CALL	C3CAE			; setup random record from current extent FCB
        CALL	C3C74			; setup recordcount of current extent FCB
        JR	C,A37E9			; file does not have the requested extent, search for next
        LD	HL,IB975
        LD	DE,(DF23D)		; transfer adres
        LD	BC,33
        LD	A,1			; dos segements, transfer to
        CALL	C2711			; transfer
        JP	J37AD			; quit with ok

;	  Subroutine _RDSEQ (BDOS 14H)
;	     Inputs  ________________________
;	     Outputs ________________________

A384C:	CALL	C39C3			; rebuild FIB from FCB
        JR	NZ,J388F		; error, quit with error
        LD	IX,(DBB96)		; saved pointer to FCB
        CALL	C3CAB			; setup random record from current recordnumber FCB
        LD	A,(IB9DA+30)
        BIT	7,A
        JR	Z,J3876			; not a device,
        LD	BC,128			; size = 128
        LD	DE,(DF23D)		; transfer adres
        LD	IX,IB9DA
        XOR	A			; DOS segments
        CALL	C2775			; read from file
        JR	NZ,J388F		; error, quit with error
        LD	IX,(DBB96)		; saved pointer to FCB
        JR	J3886

J3876:	CALL	C3B74			; get pointer to record if it is in the sequential read buffer
        JR	Z,J3883			; record is in buffer, no need to read it
        CALL	C3BC1			; fill sequential read buffer
        JR	NZ,J388F		; error, quit with error
        LD	HL,IB2D4
J3883:	CALL	C3A4C			; transfer record from sequential read buffer
J3886:	CALL	C3C56			; increase recordnumber FCB
        CALL	C3CDA			; setup dos2 specific FCB fields
        JP	J37AD			; quit with ok

J388F:	LD	HL,1
        RET

;	  Subroutine _WRSEQ (BDOS 15H)
;	     Inputs  ________________________
;	     Outputs ________________________

A3893:	CALL	C39C3			; rebuild FIB from FCB
        JR	NZ,J388F		; error, quit with error
        LD	IX,(DBB96)		; saved pointer to FCB
        CALL	C3CAB			; setup random record from current recordnumber FCB
        CALL	C3BA1			; if random record is in sequential read buffer then invalidate sequential read buffer
        LD	IX,IB9DA
        LD	BC,128			; recordsize = 128
        LD	DE,(DF23D)		; transfer adres
        XOR	A			; DOS segments
        CALL	C2771			; write to file
        JR	NZ,J388F		; error, quit with error
        LD	IX,(DBB96)		; saved pointer to FCB
        CALL	C3C56			; increase recordnumber FCB
        CALL	C3CDA			; setup dos2 specific FCB fields
        LD	A,(IX+32)
        LD	HL,(DBB96)		; saved pointer to FCB
        LD	BC,15
        ADD	HL,BC
        CP	(HL)
        JR	C,J38CB
        LD	(HL),A
J38CB:	JP	J37AD			; quit with ok

;	  Subroutine _FMAKE
;	     Inputs  ________________________
;	     Outputs ________________________

A38CE:	LD	HL,12
        ADD	HL,DE
        LD	A,(HL)
        OR	A
        JR	Z,J38DD			; extent is zero, create file
        CALL	A3771			; try to open file
        OR	A
        JP	Z,J37AD			; no error, quit with ok
J38DD:	LD	(IY+DBBAF-DBB80),0	; create directory entry
        XOR	A			; normal file
        LD	C,A			; do not use APPEND
        JP	J3779			; create file

;	  Subroutine _FDEL
;	     Inputs  ________________________
;	     Outputs ________________________

A38E6:	LD	A,0FFH
        LD	(DBB90),A		; invalidate sequential read buffer
        LD	BC,00FFH		; flag no files deleted
        PUSH	BC
        LD	(IY+DBBAF-DBB80),4	; search directory entry
        XOR	A			; search for normal files
        LD	C,A			; do not use APPEND
        CALL	C3A59			; get directory entry and setup FIB
        JR	J3901

J38FA:	POP	BC
        LD	C,0			; flag file(s) deleted
        PUSH	BC
J38FE:	CALL	C3B1D			; try to get next directory entry
J3901:	JR	NZ,J3946		; error or not found,
        BIT	0,(IX+14)
        JR	NZ,J38FE		; read-only file, skip it
        LD	A,1			; delete is recoverable by UNDEL
        CALL	C2350			; mark current directory entry deleted and remove FAT chain
        OR	A
        JR	Z,J38FA			; no error, try next
        JR	J3946			; finish

;	  Subroutine _FREN
;	     Inputs  ________________________
;	     Outputs ________________________

A3913:	LD	BC,00FFH
        PUSH	BC			; flag no files renamed
        PUSH	DE
        LD	IX,IB9DA
        LD	(IX+31),00H
        LD	HL,17
        ADD	HL,DE
        LD	DE,IB975
        EX	DE,HL
        LD	A,(DE)
        CALL	C173A			; make ASCIIZ string of name
        POP	DE
        XOR	A			; search for normal files
        LD	C,A			; do not use APPEND
        CALL	C3A59			; get directory entry and setup FIB
        JR	J393B

J3934:	POP	BC
        LD	C,0			; flag file(s) renamed
        PUSH	BC
        CALL	C3B1D			; try to get next directory entry
J393B:	JR	NZ,J3946		; error or not found, finish
        LD	BC,IB975
        CALL	C23B6			; rename current directory entry
        OR	A
        JR	Z,J3934			; no error, try next
J3946:	LD	B,A
        LD	A,(IB9DA+25)
        CALL	C2C5F			; write dirty sectorbuffers of assigned drive
        POP	HL
        LD	A,L
        OR	A			; done something ?
        RET	Z			; yep, quit without error
        LD	A,B			; errorcode
        RET

;	  Subroutine _RDRND
;	     Inputs  ________________________
;	     Outputs ________________________

A3953:	LD	A,1			; read operation
        CALL	C3B35			; do random record operation
        JR	NZ,J397D
        LD	A,C
        NEG
        AND	7FH
        LD	C,A
        LD	A,0			; DOS segments
        CALL	NZ,C3C2B		; clear record leftover
        JR	J3970

;	  Subroutine _WRRND
;	     Inputs  ________________________
;	     Outputs ________________________

A3967:	XOR	A			; write operation
        DEFB	021H			; LD HL,xxxx (skip next instruction)

;	  Subroutine _WRZER
;	     Inputs  ________________________
;	     Outputs ________________________

A3969:	LD	A,2			; write operation with zero fill
        CALL	C3B35			; do random record operation
        JR	NZ,J397D		; error, quit with error
J3970:	LD	IX,(DBB96)		; saved pointer to FCB
        CALL	C3C74			; setup recordcount in current extent FCB
        CALL	C3CDA			; setup dos2 specific FCB fields
        JP	J37AD			; quit with ok

J397D:	LD	HL,1
        RET

;	  Subroutine _FSIZE
;	     Inputs  ________________________
;	     Outputs ________________________

A3981:	LD	(IY+DBBAF-DBB80),4	; search directory entry
        LD	A,02H			; search for normal and hidden files
        LD	C,00H			; do not use APPEND
        CALL	C3A59			; get directory entry and setup FIB
        JP	NZ,J37B1
        LD	C,(IX+21)
        LD	B,(IX+22)
        LD	E,(IX+23)
        LD	D,(IX+24)
        XOR	A
        LD	H,A
        SUB	C
        AND	7FH
        LD	L,A
        ADD	HL,BC
        JR	NC,J39A5
        INC	DE
J39A5:	ADD	HL,HL
        LD	A,H
        EX	DE,HL
        ADC	HL,HL
        LD	IX,(DBB96)		; saved pointer to FCB
        LD	(IX+33),A
        LD	(IX+34),L
        LD	(IX+35),H
        JP	J37AD			; quit with ok

;	  Subroutine _SETRND
;	     Inputs  ________________________
;	     Outputs Zx set if no error, Zx reset if error
A39BA:	PUSH	DE
        POP	IX
        CALL	C3CAB			; setup random record from current record FCB
        JP	J37AD			; quit with ok

;	  Subroutine rebuild FIB from FCB
;	     Inputs  DE = pointer to FCB
;	     Outputs ________________________

C39C3:	EX	DE,HL
        LD	(DBB96),HL		; save pointer to FCB
        LD	IX,IB9DA
        LD	(IX+0),0FFH		; FIB ID
        LD	A,(HL)
        AND	0FH			; only B3-B0 of DR byte FCB
        LD	(IX+25),A		; FIB drive ID
        LD	DE,IB9DA+21
        LD	BC,16
        ADD	HL,BC
        LD	BC,4
        LDIR				; FIB filesize
        LD	DE,IB9DA+26
        LD	BC,4
        LDIR				; FIB serialnumber disk (disk) OR pointer to deviceentry/jumptable (device)
        LD	DE,IB9DA+37
        LD	BC,8
        LDIR				; FIB start cluster parent directory, start cluster, current cluster and current relative cluster
        JP	CLUST
J39F4:	LD	B,0
        BIT	6,A			; b14 of FCB current relative cluster has read only flag
        JR	Z,J39FC
        LD	B,1
J39FC:	LD	(IX+14),B		; FIB fileattribute
        LD	B,0
        BIT	5,A			; b13 of FCB current relative cluster has device flag
        JR	Z,J3A07
        LD	B,0A4H
J3A07:	BIT	4,A			; b12 of FCB current relative cluster has eof flag
        JR	Z,J3A0D
        SET	6,B			; set EOF flag
J3A0D:	LD	(IX+30),B		; FIB deviceflags
        LD	B,0			; file unchanged, read and write, not inheritable
        BIT	7,A			; b15 of FCB current relative cluster has filemode flag
        JR	Z,J3A18
        LD	B,80H			; file is changed, read and write, not inheritable
J3A18:	LD	(IX+49),B		; FIB filemode
        AND	0FH
        LD	(IX+42),A		; clear b15-b12 bit of current relative cluster
        XOR	A
        BIT	7,(IX+30)		; device ?
        RET	Z			; nope, quit
        LD	L,(IX+26)
        LD	H,(IX+27)		; pointer to deviceentry
        LD	E,(HL)
        INC	HL
        LD	D,(HL)			; get pointer to jumptable
        LD	L,(IX+28)
        LD	H,(IX+29)
        SBC	HL,DE			; same as stored pointer to jumptable ?
        RET	Z			; yep, quit
        LD	A,.IFCB			; invalid FCB error
        RET

;	  Subroutine __________________________
;	     Inputs  ________________________
;	     Outputs ________________________

C3A3B:	LD	IX,IB9DA		; FIB
        LD	HL,IB9DA+1		; filename FIB
        INC	DE
        LD	A,(DE)			; filename FCB
        LD	(IX+31),02H
        JP	C173A			; make ASCIIZ string of name

;	  Subroutine __________________________
;	     Inputs  ________________________
;	     Outputs ________________________

C3A4C:	LD	DE,(DF23D)		; transfer adres
        LD	BC,128
        LD	A,1			; dos segments, transfer to
        JP	C2711			; transfer

;	  Subroutine get directory entry and setup FIB
;	     Inputs  ________________________
;	     Outputs ________________________

C3A59:	PUSH	AF
        XOR	A
        LD	(DBB98),A		; flag APPEND not used
        POP	AF
        LD	B,A			; attribute
        PUSH	BC
        LD	(DBB96),DE		; save pointer to FCB
        LD	IX,IB9DA		; pointer to FIB
        LD	(IX+31),A		; attribute
        PUSH	AF
        PUSH	DE
        INC	DE
        LD	HL,IB8F4
        LD	A,(DE)
        CALL	C173A			; make ASCIIZ string of name
        POP	DE
        POP	AF
        LD	B,A			; directory entry attribute
        LD	A,(DE)
        AND	0FH			; b3-b0 of DR byte (driveid)
        LD	DE,IB8F4
J3A7F:	LD	C,08H			; devicename check, empty last item does not imply *.*, report path errors, b3=1, other driveindicator allowed
        CALL	C12C3			; parse (with driveindicator)
        JR	NZ,J3AB0		; error, try append
        OR	C
        LD	A,.IPATH
        JR	NZ,J3AB0		; not end of parse string, try append
        PUSH	HL
        LD	HL,IB926
        LD	DE,IB9DA+32
        LD	BC,11
        PUSH	DE
        LDIR
        POP	DE
        POP	HL
        CALL	C1A53			; get directory entry
J3A9D:	OR	A
        JR	NZ,J3AB0		; error, try append
        PUSH	DE
        PUSH	HL
        CALL	C1999			; update FIB with directory entry info
        CALL	C1A45
        CALL	STOR_7
        POP	HL
        POP	DE
        POP	BC
        XOR	A			; ok
        RET

J3AB0:	POP	BC
        BIT	0,C
        JR	NZ,J3ABD
        PUSH	AF
        XOR	A
        LD	(DBB98),A		; flag APPEND not used
        POP	AF
        OR	A
        RET

J3ABD:	LD	(IB2D4+300),A		; save error
        PUSH	BC
        LD	HL,I3B16		; APPEND
        LD	DE,IB2D4
        LD	A,0FFH
        LD	(DBB90),A		; invalidate sequential read buffer
        LD	B,0FFH
        LD	A,1			; use current segments
        CALL	C0EDF			; get environment
        OR	A
        POP	BC
        RET	NZ
        PUSH	BC
        LD	C,04H			; devicename check, empty last item does not imply *.*, report no path errors, b3=0, other driveindicator allowed
        LD	DE,IB2D4
        LD	IX,IB9DA
        XOR	A			; default driveid
        CALL	C12C3			; parse (with driveindicator)
        POP	DE
        RET	NZ
        LD	A,B
        AND	05H			; drive specified or any other chars ?
        JR	Z,J3B11			; nope, quit with error of first attempt
        LD	A,0FFH
        LD	(DBB98),A		; flag APPEND used
        PUSH	DE
        LD	HL,(DBB9E)		; pointer to terminator char APPEND string
        LD	A,B
        AND	18H			; last item no main filename and extension filename ?
        JR	Z,J3AFC			; yep, then APPEND string already ends with "\", skip
        LD	(HL),"\"
        INC	HL
J3AFC:	LD	DE,IB8F4
J3AFF:	LD	A,(DE)
        LD	(HL),A
        INC	HL
        INC	DE
        OR	A
        JR	NZ,J3AFF		; glue filename behind the APPEND string
        POP	BC
        XOR	A
        LD	C,0
        PUSH	BC			; do not try append again
        LD	DE,IB2D4
        JP	J3A7F

J3B11:	LD	A,(IB2D4+300)		; error of previous attempt
        OR	A
        RET

I3B16:	defb	"APPEND",0

;	  Subroutine try to get next directory entry
;	     Inputs  ________________________
;	     Outputs ________________________

C3B1D:	LD	IX,IB9DA
        LD	(IY+DBBAF-DBB80),4	; search directory entry
        CALL	C1A02			; get directoryentry from FIB info with diskchange check
        RET	NZ			; error, quit
        LD	DE,IB9DA+32		; pointer to directory entry locator
        CALL	C1A91			; get next directory entry
        LD	C,0			; do not use append
        PUSH	BC
        JP	J3A9D			; update FIB directory entry info if no error

;	  Subroutine do random record operation
;	     Inputs  A = operationcode
;	     Outputs ________________________

C3B35:	EX	AF,AF'
        CALL	C39C3			; rebuild FIB from FCB
        RET	NZ
        LD	IX,(DBB96)		; saved pointer to FCB
        LD	A,(IX+33)
        LD	C,(IX+34)
        LD	B,(IX+35)		; random record
        PUSH	AF
        PUSH	BC
        CALL	C3CC7			; set filepos from random record (FIB)
        CALL	C3BA1			; if random record is in sequential read buffer then invalidate sequential read buffer
        POP	HL
        POP	AF
        LD	B,A
        ADD	A,A
        ADC	HL,HL
        LD	A,L
        LD	(IX+12),A		; extent
        LD	A,H
        LD	(IX+14),A		; extent high byte
        LD	A,B
        AND	7FH
        LD	(IX+32),A		; record
        XOR	A
        EX	AF,AF'
        LD	BC,128			; 128 bytes
        LD	IX,IB9DA
        LD	DE,(DF23D)		; transfer adres
        JP	C2779			; write/read to file

;	  Subroutine get pointer to record if it is in the sequential read buffer
;	     Inputs  ________________________
;	     Outputs ________________________

C3B74:	CALL	C3BAB			; check sequential read buffer has drive and startcluster of file
        RET	NZ			; nope, quit
        LD	A,(DBB92+0)
        LD	B,A
        LD	DE,(DBB92+1)
        LD	A,(IX+33)
        LD	L,(IX+34)
        LD	H,(IX+35)		; random record
        SUB	B
        SBC	HL,DE
        RET	NZ			; not this record, quit
        LD	B,A
        LD	A,(DBB91)
        SUB	01H
        RET	C
        CP	B
        RET	C
        XOR	A
        SRL	B
        RRA
        LD	C,A
        LD	HL,IB2D4
        ADD	HL,BC
        XOR	A
        RET

;	  Subroutine if random record is in sequential read buffer then invalidate sequential read buffer
;	     Inputs  ________________________
;	     Outputs ________________________

C3BA1:	CALL	C3BAB			; check sequential read buffer has drive and startcluster of file
        RET	NZ
        LD	A,0FFH
        LD	(DBB90),A		; invalidate sequential read buffer
        RET

;	  Subroutine check sequential read buffer has drive and startcluster of file
;	     Inputs  ________________________
;	     Outputs ________________________

C3BAB:	LD	A,(IX+0)
        LD	B,A			; driveid FCB
        LD	A,(DBB90)
        CP	B
        RET	NZ
        LD	L,(IX+26)
        LD	H,(IX+27)		; start cluster of file in FCB
        LD	DE,(DBB8E)
        SBC	HL,DE
        RET

;	  Subroutine fill sequential read buffer
;	     Inputs  ________________________
;	     Outputs ________________________

C3BC1:	LD	A,0FFH
        LD	(DBB90),A		; invalidate sequential read buffer
        LD	A,(IX+33)
        AND	03H			; record mod 3
        LD	B,A
        LD	A,8
        SUB	B
        LD	B,A
        XOR	A
        SRL	B
        RR	A
        LD	C,A			; /2
        PUSH	IX
        LD	IX,IB9DA
        LD	DE,IB2D4
        LD	A,0FFH			; BDOS segments
        CALL	C2775			; read from file
        POP	IX
        JR	Z,J3BEC			; no error,
        CP	.EOF			; end of file ?
        JR	NZ,J3C27		; other error,
J3BEC:	LD	A,B
        OR	C
        JR	Z,J3C27			; nothing read,
        LD	HL,127
        ADD	HL,BC
        ADD	HL,HL
        LD	A,H
        LD	(DBB91),A		; number of records read
        XOR	A
        LD	B,A
        SUB	C
        AND	7FH
        LD	C,A
        LD	A,0FFH			; BDOS segments
        CALL	NZ,C3C2B		; clear record remainer
        PUSH	IX
        POP	HL
        LD	BC,33
        ADD	HL,BC
        LD	DE,DBB92
        LD	BC,3
        LDIR				; save current random record FCB
        LD	A,(IX+26)
        LD	(DBB8E+0),A
        LD	A,(IX+27)
        LD	(DBB8E+1),A		; save start cluster of file FCB
        LD	A,(IX+0)
        LD	(DBB90),A		; save driveid FCB
        XOR	A
        RET

J3C27:	XOR	A
        LD	B,A
        INC	A
        RET

;	  Subroutine clear space
;	     Inputs  A = segment type (b2 set BDOS, b2 reset DOS), DE = adres, BC = size
;	     Outputs ________________________

C3C2B:	PUSH	AF
        PUSH	DE
        AND	04H
        CALL	C274F			; get segmentnumber
        SET	7,D			; make adres page 2 based
        CALL	CF224			; PUT_P2
J3C37:	XOR	A
        LD	(DE),A
        INC	DE
        DEC	BC
        LD	A,B
        OR	C
        JR	Z,J3C4E			; restore BDOS datasegement and quit
        BIT	6,D
        JR	Z,J3C37
        POP	AF
        AND	0C0H
        ADD	A,40H
        LD	D,A
        LD	E,00H
        POP	AF
        JR	C3C2B

J3C4E:	POP	AF
        POP	AF
        LD	A,(DF2CF)		; BDOS datasegment
        JP	CF224			; PUT_P2

;	  Subroutine increase recordnumber FCB
;	     Inputs  ________________________
;	     Outputs ________________________

C3C56:	LD	A,(IX+12)
        LD	L,A			; extent
        LD	A,(IX+14)
        LD	H,A			; extent high byte
        LD	A,(IX+32)		; current record in extent
        INC	A			; increase record
        JP	P,J3C68
        INC	HL			; increase extent
        LD	A,0			; record 0
J3C68:	LD	(IX+32),A
        LD	A,L
        LD	(IX+12),A
        LD	A,H
        LD	(IX+14),A
        RET	P

;	  Subroutine setup recordcount in current extent FCB
;	     Inputs  ________________________
;	     Outputs ________________________

C3C74:	LD	HL,(IB9DA+21+0)
        XOR	A
        LD	B,A
        SUB	L
        AND	7FH
        LD	C,A
        ADD	HL,BC
        LD	BC,(IB9DA+21+2)
        JR	NC,J3C85
        INC	BC			; BCHL = filesize, rounded up to 128 multiply (FIB)
J3C85:	LD	A,(IB9DA+45+1)
        AND	0C0H
        LD	D,A
        XOR	A
        LD	E,A
        SBC	HL,DE
        PUSH	BC
        EX	(SP),HL
        LD	BC,(IB9DA+45+2)
        SBC	HL,BC			; check if filepos (FIB) is in last extent
        POP	HL
        LD	B,A
        JR	C,J3CA6			; past last extent, record 0
        LD	B,80H
        JR	NZ,J3CA6		; before last extent, special record 128 (extent is full)
        LD	A,H
        AND	0C0H
        JR	NZ,J3CA6
        ADD	HL,HL
        LD	B,H
J3CA6:	LD	A,B
        LD	(IX+15),A
        RET

;	  Subroutine setup random record from current extent FCB
;	     Inputs  ________________________
;	     Outputs ________________________

C3CAB:	LD	A,(IX+32)		; record in extent

;	  Subroutine setup random record from current extent FCB
;	     Inputs  ________________________
;	     Outputs ________________________

C3CAE:	PUSH	AF
        LD	A,(IX+14)
        LD	B,A			; extent high byte
        LD	A,(IX+12)
        LD	C,A			; extent
        POP	AF
        ADD	A,A
        SRL	B
        RR	C
        RRA
        LD	(IX+33),A
        LD	(IX+34),C
        LD	(IX+35),B

;	  Subroutine __________________________
;	     Inputs  ________________________
;	     Outputs ________________________

C3CC7:	LD	HL,IB9DA+45
        LD	(HL),0
        SRL	B
        RR	C
        RRA
        RR	(HL)
        INC	HL
        LD	(HL),A
        INC	HL
        LD	(HL),C
        INC	HL
        LD	(HL),B
        RET

;	  Subroutine setup dos2 specific FCB fields from FIB
;	     Inputs  ________________________
;	     Outputs ________________________

C3CDA:	PUSH	IX
        POP	HL
        LD	BC,16
        ADD	HL,BC
        EX	DE,HL
        LD	HL,IB9DA+21
        LD	BC,4
        LDIR				; filesize
        LD	HL,IB9DA+26
        LD	BC,4
        LDIR				; volume-id
        LD	HL,IB9DA+37
        LD	BC,8
        LDIR
        JP	CLUST2
J3CFD:	AND	0FH
        LD	B,A
        LD	A,(IB9DA+14)		; attribute
        BIT	0,A			; read only bit
        JR	Z,J3D09
        SET	6,B			; flag read-only file
J3D09:	LD	A,(IB9DA+30)
        BIT	7,A			; device flag
        JR	Z,J3D12
        SET	5,B			; flag device
J3D12:	LD	A,(IB9DA+30)
        BIT	6,A
        JR	Z,J3D1B
        SET	4,B
J3D1B:	LD	A,(IB9DA+49)
        BIT	7,A
        JR	Z,J3D24
        SET	7,B
J3D24:	LD	(IX+29),B
        RET

;	  Subroutine __________________________
;	     Inputs  ________________________
;	     Outputs ________________________

C3D28:	INC	HL
        LD	A,(DE)
        CP	05H
        JR	NZ,J3D30
        LD	A,0E5H
J3D30:	LD	(HL),A
        INC	HL
        INC	DE
        LD	BC,10
        EX	DE,HL
        LDIR
        EX	DE,HL
        RET

;	  Subroutine _RDBLK
;	     Inputs  DE = pointer to FCB, HL = number of records
;	     Outputs ________________________

A3D3B:	LD	A,1			; read, DOS segments
        JR	J3D40

;	  Subroutine _WRBLK
;	     Inputs  DE = pointer to FCB, HL = number of records
;	     Outputs ________________________

A3D3F:	XOR	A			; write, DOS segments
J3D40:	EX	AF,AF'
        PUSH	HL
        CALL	C39C3			; rebuild FIB from FCB
        JP	NZ,J3E13		; error, quit with returned error
        LD	IX,(DBB96)		; saved pointer to FCB
        CALL	C3BA1			; if random record is in sequential read buffer then invalidate sequential read buffer
        LD	C,(IX+14)
        LD	B,(IX+15)		; user recordsize
        LD	HL,63
        XOR	A
        SBC	HL,BC
        LD	E,(IX+35)
        LD	D,(IX+36)
        JR	NC,J3D69		; <64, use 32 bits random record
        LD	D,A			; >63, use 24 bits random record
J3D69:	CALL	C3E3A			; multiply (random record * recordsize, highword part)
        LD	A,H
        OR	L
        JP	NZ,J3E16		; filepos larger then 4 Gb, quit with "Cannot transfer above 64K" error
        PUSH	DE
        LD	E,(IX+33)
        LD	D,(IX+34)
        CALL	C3E3A			; multiply (random record * recordsize, lowword part)
        POP	BC
        ADD	HL,BC
        JP	C,J3E16			; filepos larger then 4 Gb, quit with "Cannot transfer above 64K" error
        LD	(IB9DA+45),DE
        LD	(IB9DA+47),HL		; setup filepos (FIB)
        POP	DE
        PUSH	DE			; number of records
        LD	C,(IX+14)
        LD	B,(IX+15)		; user recordsize
        CALL	C3E3A			; multiply
        LD	A,H
        OR	L
        JP	NZ,J3E16		; datasize larger then 64 Kb, quit with "Cannot transfer above 64K" error
        LD	C,E
        LD	B,D			; datasize in bytes
        PUSH	BC
        EX	AF,AF'
        PUSH	AF
        LD	IX,IB9DA
        LD	DE,(DF23D)		; transfer adres
        BIT	0,A
        JR	NZ,J3DB0		; read, go reading
        LD	A,B
        OR	C
        LD	A,0
        JR	NZ,J3DB0		; datasize<>0, go writing
        SET	4,A			; datasize=0, alter filesize
J3DB0:	CALL	C2779			; read/write to file
        LD	(IB975+1),A		; save errorcode
        LD	IX,(DBB96)		; pointer to FCB
        POP	AF
        EX	AF,AF'
        XOR	A
        POP	HL			; datasize requested
        SBC	HL,BC			; - datasize done
        JR	Z,J3DEF			; all done, finish without error
        LD	(IB975+2),DE		; current transfer adres
        LD	E,(IX+14)
        LD	D,(IX+15)		; user recordsize
        CALL	C3E24			; datasize still left / recordsize
        LD	A,H
        OR	L			; incomplete record ?
        JR	Z,J3DE6			; nope, skip clear
        INC	BC
        PUSH	BC			; records left+1
        EX	DE,HL
        SBC	HL,DE
        LD	B,H
        LD	C,L			; bytes left in incomplete record
        LD	DE,(IB975+2)		; current transfer adres
        EX	AF,AF'
        BIT	0,A
        CALL	NZ,C3C2B		; read operation, clear record leftover
        POP	BC
J3DE6:	POP	HL			; number of records requested
        PUSH	BC
        XOR	A
        SBC	HL,BC			; - number of records left
        JR	Z,J3DEF
        INC	A			; flag error
J3DEF:	EX	AF,AF'
        CALL	C3CDA			; setup dos2 specific FCB fields
        POP	DE
        LD	L,(IX+33)
        LD	H,(IX+34)
        ADD	HL,DE
        LD	(IX+33),L
        LD	(IX+34),H
        JR	NC,J3E10
        LD	L,(IX+35)
        LD	H,(IX+36)
        INC	HL
        LD	(IX+35),L
        LD	(IX+36),H		; update random record
J3E10:	EX	AF,AF'
        JR	J3E1B

J3E16:	LD	A,.OV64K
J3E13:	LD	(IB975+1),A
        POP	HL
        XOR	A
        LD	D,A
        LD	E,A
        INC	A			; flag error
J3E1B:	LD	L,A
        LD	H,00H
        OR	A
        RET	Z
        LD	A,(IB975+1)
        RET

;	  Subroutine divide
;	     Inputs  BC = para1, DE = para2
;	     Outputs HL = rest, BC = result

C3E24:	XOR	A
        LD	H,A
        LD	L,A
        LD	A,16
J3E29:	CCF
J3E2A:	RL	C
        RL	B
        DEC	A
        RET	M
        ADC	HL,HL
        SBC	HL,DE
        JR	NC,J3E29
        ADD	HL,DE
        OR	A
        JR	J3E2A

;	  Subroutine multiply
;	     Inputs  BC = para1, DE = para2
;	     Outputs HLDE = result

C3E3A:	PUSH	BC
        LD	A,B
        LD	HL,0
        LD	B,16
J3E41:	ADD	HL,HL
        RL	C
        RLA
        JR	NC,J3E4E
        ADD	HL,DE
        JR	NC,J3E4E
        INC	C
        JR	NZ,J3E4E
        INC	A
J3E4E:	DJNZ	J3E41
        EX	DE,HL
        LD	L,C
        LD	H,A
        POP	BC
        RET

; FAT16 extra routines

GETSEC:
        LD	BC,9
        ADD	HL,BC		;DPB+14h start sector of data area
        LD	C,(HL)
        INC	HL
        LD	H,(HL)
        LD	L,C
        ADD	HL,DE
        JR	NC,Z0024;
        INC	A
Z0024:	EX	DE,HL		;BDE=sector number
        LD	(BIT16),A	;save bit16-23
        POP	BC
        POP	HL
        RET
;----------------------------------------
FSIZE1:
        JR	NC,FSIZ_1
        INC	D
FSIZ_1:	INC	(HL)
        DEC	(HL)
        RET	NZ
        INC	D
        RET

FSIZE2:
        LD	A,(IX-4)
        OR	A
        JR	NZ,FSIZ_2
        INC	D
FSIZ_2:	ADD	A,E
        RET

FSIZE3:
        JR	NC,FSIZ_3
        INC	D
FSIZ_3:	INC	E
        DEC	E
        RET	NZ
        INC	D
        RET


;------------------------------------
;#1Bh PATCH
ALLOC:
        LD	DE,0002h
        CALL	CHKDRV
        JP	J0C07			;Not use buffer


;--------------------------------------
;349Fh FAT12,16�̔���
;FAT16�̓f�[�^�Z�O�����g�̃h���C�u���@MEDIA ID bit7=0�ɂ���
DPBSET:
        LD	A,(IX+15h)
        LD	(HL),A
@DPBST:	PUSH	HL
        PUSH	IX
        POP	HL
        LD	BC,0200h
DPB_1:	LD	A,'F'
        CPIR
        JR	Z,DPB_2
        OR	A
        JR	DPB_3

DPB_2:	PUSH	HL
        PUSH	BC
        LD	B,04h
        LD	DE,MOJI	;'AT16'
DPB_4:	LD	A,(DE)
        XOR	(HL)
        JR	NZ,DPB_5
        INC	HL
        INC	DE
        DJNZ	DPB_4
        SCF
DPB_5:	POP	BC
        POP	HL
        JR	NC,DPB_1

DPB_3:	POP	HL
        LD	A,(HL)
        RET	NC
        RES	7,(HL)
        RET

MOJI:	DB	'AT16'
;-------------------------------------

BIT16:	DB	0		;bit16-23 for caluclation of sector
DSKEX:	DB	0		;bit16-23 for Disk buffer
SDIR_1:	DB	0		;BBE2h   bit16-23
SDIR_2:	DB	0		;BBD2h+4 bit16-23
SDIR_3:	DB	0		;BBC6h+4 bit16-23
RW_16:	DB	0		;bit16-23 for DISKIO






SECNUM:
        DB	0DDh,0CBh,1Dh,7Eh	;BIT	7,(IX+1Dh)
        LD	A,0
        JR	NZ,SECN_1	;FAT12
        LD	A,(DSKEX)	;FAT16
SECN_1:	LD	C,(IX+11h)
        LD	(HL),C
        RET


;-----------------------------------------------
;Compare sector number at buffer
CMPSEC:				;#6C33 (#6C47)
        INC	HL
        LD	A,(HL)
        SUB	D
        RET	NZ		;Z=0 different sector
        DB	0DDh,0CBh,1Dh,7Eh	;BIT	7,(IX+1Dh)
        JR	Z,CMPS_1	;Z=1 FAT16
        XOR	A
        RET			;
CMPS_1:	LD	A,(DSKEX)	;
        INC	HL
        INC	HL
        INC	HL
        CP	(HL)		;bit16-23 of sector number
        RET


;------------------------------------------------------
;Set to bit16-23 of sector number at registerC
;
SETNUM:
        PUSH	AF		;#3540 (#3554)
        LD	A,(IX+1Dh)
        BIT	7,A
        JR	NZ,MED_ID	;FAT12
        LD	A,(RW_16)
        LD	C,A		;FAT16 C=bit16-23
        POP	AF
        RET
MED_ID:	LD	C,A		;C=MEDIA ID
        POP	AF
        RET

;-------------------------------------------------------
;Total of cluster
TALCLS:
        LD	A,L		;HL=BOOT +13h,14h
        OR	H
        JR	Z,WINFMT	;Format with Windows95
        SBC	HL,DE
        JP	J348D		;12bitFAT

WINFMT:	LD	L,(IX+20h)	;Cluster size
        LD	H,(IX+21h)
        LD	A,(IX+22h)
        OR	A
        SBC	HL,DE
        SBC	A,0
WINFM_:	DEC	C
        JP	Z,J3496
        SRL	A
        RR	H
        RR	L
        JR	WINFM_

;-----------------------------
;DISK BUFFER
DSKBUF:
        SBC	HL,BC
        PUSH	AF
        PUSH	DE
        DEC	DE
        DEC	DE
        DEC	DE
        EX	DE,HL
        LD	A,(HL)		;Drive number of buffer
        DEC	A
        ADD	A,A
        LD	HL,0BA25h	;(DRIVE-1)*2+BA25h=(DPB address)
        ADD	A,L
        LD	L,A
        LD	A,(HL)
        INC	HL
        LD	H,(HL)
        ADD	A,1Dh
        LD	L,A
        LD	A,0
        ADC	A,H		;HL=DPB+1Dh
        BIT	7,(HL)		;Z=1 FAT16  Z=0 FAT12
        EX	DE,HL
        POP	DE
        JR	Z,CALUC		;FAT16
        POP	AF
        POP	BC
        JP	J266A

CALUC:
        POP	AF
        PUSH	DE
        INC	DE
        INC	DE
        INC	DE
        LD	A,(DE)
        LD	BC,(BIT16)
        SBC	A,C
        POP	DE
        POP	BC
        INC	A
        JP	NZ,J2683
        LD	A,L
        ADD	A,B
        JR	NC,CALU_1
        LD	A,0
        ADC	A,H
CALU_1:	JP	J2670

;-------------------------------------
;1CC4h
GETSUB:
        CALL	C2DD4			;�Z�N�^���Z
        LD	A,(BIT16)
        LD	(SDIR_1),A
        RET

;1CA5h
SUB_16:
        INC	DE			;[ver0.11]
        LD	A,D
        OR	E
        JR	NZ,SUB_
        LD	A,(SDIR_1)
        INC	A
        LD	(SDIR_1),A
SUB_:	LD	A,(0BBE1h)
        RET

;-------------------------------------
;SECTER READ/WRITE
;2588
ABSSEC:
        XOR	A
        LD	(BIT16),A
        JP	C25B7


;-----------------------------------------------------------
;FAT WRITE
FATWRT:
        CALL	CHKDRV
        JR	Z,FATWR2		;16bit FAT
        LD	A,B
        CP	10h
        JP	J2DF8			;12bit FAT

FATWR2:
        CALL	FATADR			;Get address
        JR	Z,FATWR3		;Right routine
        LD	A,0FFh
        LD	(0BBEAh),A
FATWR4:	LD	A,0F2h
        LD	DE,0FFFFh
        CALL	C36AC
        JR	Z,FATWR4
        JP	J2E53			;Error

FATWR3:	PUSH	HL
        LD	A,C
        LD	(DE),A			;FAT write
        INC	DE
        LD	A,B
        LD	(DE),A
        JP	J2E2D			;Return



;----------------------------------------------------------
;Set sector number at #BBB4
NUM_1:
        LD	(0BBB4h),HL
        RET	NC
SECINC:	LD	A,(BIT16)
        INC	A
        LD	(BIT16),A
        RET

NUM_2:
        INC	(IY+35h)
        RET	NZ
        JR	SECINC

;-----------------------------------------------
;2B7Eh
BUF_1:	XOR	A
        LD	(DSKEX),A		;FAT
        JP	C2B88

BUF_5:	XOR	A			;#2FD2
        LD	(BIT16),A
        LD	B,L
        DEC	B
        DEC	DE
        RET

BUF_4:	LD	BC,(0BBE8h)		;SUB DIR? ROOT?
        INC	BC
        LD	A,B
        OR	C
        LD	B,01h
        JR	Z,BUF_3			;(BBE8)=FFFF
        LD	A,(SDIR_1)
        JR	BUF_

BUF_2:	LD	A,(BIT16)
        JR	BUF_

BUF_3:	XOR	A
BUF_:	LD	(DSKEX),A	;FAT
        JP	C2B96

;--------------------------------------------------------------
;Read a sector for Random block access

RAMRED:
        PUSH	AF
        LD	A,(BIT16)
        LD	(RW_16),A	;write bit16-23 of sector number
        LD	DE,(0BBB4h)
        POP	AF
        RET


;------------------------------------------------------------
;Read/write a sector for buffer
REDBUF:
        PUSH	AF
        LD	A,(DSKEX)
        JR	REDB_1
WRTBUF:
        PUSH	AF
        LD	A,(IX+0FDh)		;bit16-23
REDB_1:	LD	(RW_16),A		;use bit16-23 of sector number
        POP	AF
        JP	C326D

;---------------------------------
;34F0h  JP DSKROM
DSKROM:
        CP	06h
        JP	NC,J3543
        CP	02h
        JR	NC,DSKR_1
        PUSH	AF
        XOR	A
        LD	(RW_16),A
        POP	AF
DSKR_1:	JP	J34FE



CLST_1:
        LD	D,(HL)			;#1534
        JR	CHK_C			;Check data 'FFFFh'

CLST_2:	DB	0FDh,0CBh,20h,0DEh	;SET  3,(IY+20h)	;#158B
        JR	CHK_C


CLST_4:	LD	DE,(0BBE8h)		;#1C53
        JR	CHK_C

CLST_8:	POP	AF			;#1B87
        POP	DE
        JR	CHK_D

CLST_5:	POP	AF			;#2F83
        PUSH	BC
CHK_D:	PUSH	AF
        JR	CHK_C

CLST_6:	LD	DE,(0BBA3h)		;#2FAF
CHK_C:
        LD	A,D			;DE=FFFFh Z=0
        AND	E
        JR	CHK_A

CLST_7:	JR	NZ,CHK_C		;#3021
        INC	SP
        INC	SP
        RET



CLST_9:	LD	DE,(0BBE8h)		;#1CB1
        CALL	CHK_C
        LD	DE,(0BBE4h)
        RET	NZ			;�J�����g��ROOT
        JR	CHK_C

CLST_3:	LD	DE,(0BBE6h)		;#1C0D

CHECK:	LD	A,D
CHK_A:	INC	A
        JR	Z,CHK_B
        XOR	A
        RET			;z=1
CHK_B:	DEC	A
        RET			;z=0

CLST_A:	LD	A,(HL)
        JR	CHK_A


;---------------------------------

CLUST:
        LD	HL,(0B9FAh)		;FCB+20h DPB address
        CALL	CHKDRV
        RET	Z			;FAT16
        LD	A,(IX+2Ah)
        JP	J39F4

CLUST2:
        LD	HL,(0B9FAh)
        CALL	CHKDRV
        RET	Z			;FAT16
        LD	A,(IX+1Dh)
        JP	J3CFD

;-------------------------------------------------------------------
RAMDSK:


;Get FAT address
FATRED:
        PUSH	AF
        CALL	CHKDRV
        JR	Z,Z0018		;use FAT16
        POP	AF
        CALL	C2DA4		;FAT12 routine
        BIT	7,D
        RET

;Read 16bitFAT

Z0018:
        POP	AF
        CALL	FATADR		;get address & sector set
        JR	Z,Z0019		;no error
Z0020:	XOR	A
        LD	(0BBEAh),A
        LD	A,0F2h
        LD	DE,0FFFFh
        CALL	C36AC
        JR	Z,Z0020
        JR	Z0021		;error

Z0019:	PUSH	HL
        LD	A,(DE)		;DE=FAT address
        LD	L,A
        INC	DE
        LD	A,(DE)
        LD	H,A
        EX	DE,HL		;DE=next cluster number
        LD	HL,0FFF7h	;HL=wrong cluster number
        OR	A
        SBC	HL,DE
        POP	HL
        JR	NC,Z1021	;not end of cluster
Z0021:	LD	DE,0FFFFh	;End of cluster
        OR	D		;Z=0
        SCF			;Cy=1
        RET
Z1021:	XOR	A		;Cy=0 Z=1
        RET


;-----------------------------------------------------------
;Get sector number of FAT & read FAT sector in disk buffer
;Get address of FAT

FATADR:
        PUSH	IX		;IX=#B9DA
        PUSH	BC
        PUSH	HL		;HL=DPB address
        PUSH	HL
        POP	IX
        DB	0FDh,0CBh,29h,86h	;RES	0,(IY+29h)
        LD	L,(IX+16h)
        LD	H,(IX+17h)
        XOR	A
        SBC	HL,DE
        JR	C,FATAD_	;ERROR
        LD	H,D		;DE=cluster number
        LD	L,E
        ADD	HL,HL		;cluster number * 2(16bit)
        PUSH	HL
        LD	E,D		;cluster * 2 / 200hbytes = sector
        LD	D,0
        LD	L,(IX+0Ch)	;sector number of FAT top
        LD	H,(IX+0Dh)	;
        ADD	HL,DE		;get sector number of FAT
        EX	DE,HL
        CALL	BUF_1		;get address of disk buffer
        LD	BC,0Bh
        ADD	HL,BC		;start address of FAT in disk buffer
        POP	BC
        LD	A,B
        AND	01h		;get leave from FATaddress/200h
        LD	B,A
        ADD	HL,BC		;get address
        EX	DE,HL
        CP	A		;Z=1 right
FATAD_:	POP	HL
        POP	BC
        POP	IX
        RET

;-------------------------------
;Z=1  FAT16 drive   Z=0  FAT12 drive
CHKDRV:
        PUSH	HL
        PUSH	DE
        LD	DE,001Dh
        ADD	HL,DE
        BIT	7,(HL)
        POP	DE
        POP	HL
        RET



STOR_1:	PUSH	AF
        LD	A,(SDIR_1)		;BBE2h-3h
        LD	(SDIR_2),A		;BBD6h-7h
        POP	AF
        LD	DE,0BBD2h
        RET

STOR_2:	PUSH	AF
        LD	A,(SDIR_2)
        LD	(SDIR_1),A
        POP	AF
        LD	HL,0BBD2h
        RET

STOR_3:	LD	(IX+23h),B		;bit7-15 of sector
        LD	A,(SDIR_1)
        LD	(IX+32h),A		;File handle
        RET

STOR_4:	OR	A
        SBC	HL,DE
        RET	NZ
        LD	A,(SDIR_1)
        SUB	(IX+32h)
        RET

STOR_5:	PUSH	AF
        LD	A,(SDIR_1)
        LD	(SDIR_3),A
        POP	AF
        LD	HL,0BBDEh
        RET

STOR_6:	PUSH	AF
        LD	A,(SDIR_3)
        LD	(SDIR_1),A
        POP	AF
        LD	HL,0BBC6h
        RET

STOR_7:	PUSH	AF
        LD	A,(SDIR_1)
        ld	(ix+38h),a			;[ver0.12]
        POP	AF
        EX	DE,HL
        LDIR
        RET

STOR_8:	PUSH	AF
        ld	a,(ix+38h)			;[ver0.12]
        LD	(SDIR_1),A
        POP	AF
        LD	C,(IX+19h)
        RET

ALLSEC:
        EX	DE,HL
        DEC	HL
        DEC	HL
        OR	A
        RET	Z		;FAT12
        LD	(HL),0
        DEC	HL
        LD	(HL),0
        LD	BC,0011h
        ADD	HL,BC
        LD	(HL),A
        DEC	HL
        RET


        .DEPHASE

        DEFS	08000H-$,0

        END
