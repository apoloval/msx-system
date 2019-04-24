; KANJI.ASM
;
; KANJI (BASIC + Extended BIOS + japanese input frontend processor) (full version)
; as found in Panasonic Turbo-R GT/ST
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

        .Z80
        ASEG
        ORG	4000H

M0D0C	EQU	0D0CH	; bios: pop af, pop bc, pop de, pop hl, ret
D0004	EQU	0004H	; address pattern generator
D0006	EQU	0006H	; address vdp dataport (read)
CALSLT	EQU	001CH
IDBYT2	EQU	002DH
WRTVDP	EQU	0047H
RDVRM	EQU	004AH
WRTVRM	EQU	004DH
FILVRM	EQU	0056H
LDIRMV	EQU	0059H
LDIRVM	EQU	005CH
CHGMOD	EQU	005FH
GICINI	EQU	0090H
CHSNS	EQU	009CH
CHGET	EQU	009FH
CHPUT	EQU	00A2H
LPTOUT	EQU	00A5H
LPTSTT	EQU	00A8H
BREAKX	EQU	00B7H
BEEP    EQU     00C0H
CLS	EQU	00C3H
TOTEXT	EQU	00D2H
SNSMAT	EQU	0141H
KILBUF	EQU	0156H
CALBAS	EQU	0159H
EXTROM	EQU	015FH

M406F	EQU     406FH                   ; BASIC error
M409B   EQU     409BH                   ; warm start BASIC
M4601   EQU     4601H                   ; execution loop
M4666   EQU     4666H                   ; get next BASIC character
M4C64   EQU     4C64H                   ; evaluate expression
M517A   EQU     517AH                   ; convert DAC to new type
M521C   EQU     521CH                   ; evaluate byte operand
M5284   EQU     5284H                   ; decode BASIC line
M5EA4   EQU     5EA4H                   ; locate variable
M6627   EQU     6627H                   ; allocate temporary string
M67D0   EQU     67D0H                   ; free temporary string with type check
M6C1C   EQU     6C1CH                   ; close all i/o channels


CBFF0	EQU	0BFF0H

S.PUTCHR	EQU	0139H


DF30F	EQU	0F30FH	; double byte header definition used by the disksystem
DF349	EQU	0F349H	; bottom of disksystem
DF36B	EQU	0F36BH	; enable tpa (ram) on page 1

WRPRIM  EQU     0F385H
LINL40	EQU	0F3AEH
LINL32	EQU	0F3AFH
LINLEN	EQU	0F3B0H
CRTCNT	EQU	0F3B1H
CLMLST	EQU	0F3B2H
CLIKSW	EQU	0F3DBH
CSRY	EQU	0F3DCH
CSRX	EQU	0F3DDH
CNSDFG	EQU	0F3DEH
RG0SAV	EQU	0F3DFH
RG1SAV	EQU	0F3E0H
RG2SAV	EQU	0F3E1H
RG7SAV	EQU	0F3E6H
TRGFLG	EQU	0F3E8H
FORCLR	EQU	0F3E9H
BAKCLR	EQU	0F3EAH
SCNCNT	EQU	0F3F6H
REPCNT	EQU	0F3F7H
PUTPNT	EQU	0F3F8H
GETPNT	EQU	0F3FAH
RAWPRT	EQU	0F418H
CURLIN	EQU	0F41CH
BUFMIN	EQU	0F55DH
BUF	EQU	0F55EH
TTYPOS	EQU	0F661H
VALTYP	EQU	0F663H
TXTTAB	EQU	0F676H
DSCTMP	EQU	0F698H
AUTFLG	EQU	0F6AAH
OLDLIN	EQU	0F6BEH
OLDTXT	EQU	0F6C0H
FUNACT	EQU	0F7BAH
SWPTMP	EQU	0F7BCH
DECCNT	EQU	0F7F4H
DAC	EQU	0F7F6H
HOLD8	EQU	0F806H
MAXFIL	EQU	0F85FH
FILTAB	EQU	0F860H
FNKSTR	EQU	0F87FH
ACPAGE	EQU	0FAF6H
EXBRSA	EQU	0FAF8H
CHRCNT	EQU	0FAF9H
MODE	EQU	0FAFCH
NORUSE	EQU	0FAFDH
HOKVLD	EQU	0FB20H
ENSTOP	EQU	0FBB0H
BASROM	EQU	0FBB1H
LINTTB	EQU	0FBB2H
FSTPOS	EQU	0FBCAH
FNKSWI	EQU	0FBCDH
FNKFLG	EQU	0FBCEH
ONGSBF	EQU	0FBD8H
CLIKFL	EQU	0FBD9H
OLDKEY	EQU	0FBDAH
NEWKEY	EQU	0FBE5H
KEYBUF	EQU	0FBF0H
LINWRK	EQU	0FC18H
PATWRK	EQU	0FC40H
HIMEM	EQU	0FC4AH
TRPTBL	EQU	0FC4CH
INTFLG	EQU	0FC9BH
ESCCNT	EQU	0FCA7H
INSFLG	EQU	0FCA8H
CSRSW	EQU	0FCA9H
CSTYLE	EQU	0FCAAH
CAPST	EQU	0FCABH
KANAST	EQU	0FCACH
KANAMD	EQU	0FCADH
SCRMOD	EQU	0FCAFH
OLDSCR	EQU	0FCB0H
EXPTBL	EQU	0FCC1H
SLTWRK	EQU	0FD09H
PROCNM	EQU	0FD89H

H.TIMI	EQU	0FD9FH
H.CHPU	EQU	0FDA4H
H.DSPC	EQU	0FDA9H
H.ERAC	EQU	0FDAEH
H.DSPF	EQU	0FDB3H
H.ERAF	EQU	0FDB8H
H.TOTE	EQU	0FDBDH
D.FDBE	EQU	0FDBEH
H.CHGE	EQU	0FDC2h
H.KEYC	EQU	0FDCCH
H.KEYA	EQU	0FDD1H
H.PINL	EQU	0FDDBh
H.INLI	EQU	0FDE5h
H.WIDT	EQU	0FF84h
H.PHYD	EQU	0FFA7H
H.LPTO	EQU	0FFB6h
H.SCRE	EQU	0FFC0h
EXTBIO	EQU	0FFCAH
RG8SAV	EQU	0FFE7H
RG9SAV	EQU	0FFE8H
RG23SA	EQU	0FFF6H
RG25SA	EQU	0FFFAH


?4000:	DEFB	"AB"
        DEFW	0
        DEFW	A41AB
        DEFW	0
        DEFW	0
        DEFS	6,0

        DEFS	04020H-$,0

?4020:	DEFB	"TANKAN  "
?4028:	DEFB	"02IED   "

;	  Subroutine initialize hooks
;	     Inputs  ________________________
;	     Outputs ________________________

C4030:	PUSH	HL
        CALL	C44EB			; get slotid
        LD	C,A
        POP	HL
J4036:	LD	E,(HL)
        INC	HL
        LD	D,(HL)
        INC	HL
        LD	A,E
        OR	D
        RET	Z
        LD	A,0F7H
        LD	(DE),A
        INC	DE
        LD	A,C
        LD	(DE),A
        INC	DE
        LD	A,(HL)
        LD	(DE),A
        INC	HL
        INC	DE
        LD	A,(HL)
        LD	(DE),A
        INC	HL
        INC	DE
        LD	A,0C9H
        LD	(DE),A
        JR	J4036

;	  Subroutine clear hooks
;	     Inputs  ________________________
;	     Outputs ________________________

C4051:	LD	E,(HL)
        INC	HL
        LD	D,(HL)
        INC	HL
        LD	A,E
        OR	D
        RET	Z
        LD	A,0C9H
        LD	(DE),A
        INC	DE
        LD	(DE),A
        INC	DE
        LD	(DE),A
        INC	DE
        LD	(DE),A
        INC	DE
        LD	(DE),A
        INC	HL
        INC	HL
        JR	C4051

I4067:	DEFW	H.TOTE
        DEFW	A454E
        DEFW	H.CHPU
        DEFW	A4746
        DEFW	H.DSPC
        DEFW	A488C
        DEFW	H.ERAC
        DEFW	A48A4
        DEFW	H.ERAF
        DEFW	A4A79
        DEFW	H.DSPF
        DEFW	A4A9E
        DEFW	H.PINL
        DEFW	A4CDE
        DEFW	H.INLI
        DEFW	A4CF5
        DEFW	H.LPTO
        DEFW	A6B95
        DEFW	H.CHGE
        DEFW	A452E
        DEFW	H.WIDT
        DEFW	A4460
        DEFW	H.SCRE
        DEFW	A44BD
        DEFW	0

;	  Subroutine get my SLTWRK entry
;	     Inputs  ________________________
;	     Outputs ________________________

C4099:	PUSH	HL
        PUSH	BC
	PUSH	AF
        IN	A,(0A8H)
        RRCA
        RRCA
        AND	03H
        LD	C,A
        LD	B,00H
        LD	HL,EXPTBL
        ADD	HL,BC
        BIT	7,(HL)
        LD	A,0
        JR	Z,J40B6
        INC	HL
        INC	HL
        INC	HL
        INC	HL
        LD	A,(HL)
        AND	0CH
J40B6:	RLC	C
        RLC	C
        RLC	C
        RLC	C
        OR	C
        RLCA
        LD	C,A
        LD	IX,SLTWRK
        ADD	IX,BC
        POP	AF
        POP	BC
        POP	HL
        RET

;	  Subroutine __________________________
;	     Inputs  ________________________
;	     Outputs ________________________

C40CB:	LD	A,(HOKVLD)
        BIT	0,A
        JR	NZ,J40E4
        OR	01H
        LD	(HOKVLD),A
        LD	HL,EXTBIO+0
        LD	DE,EXTBIO+1
        LD	BC,3*5-1
        LD	(HL),0C9H
        LDIR
J40E4:	LD	A,(EXTBIO+1)
        LD	(SLTWRK+1),A
        LD	HL,(EXTBIO+2)
        LD	(SLTWRK+2),HL
        CALL	C44EB			; get slotid
        LD	H,A
        LD	L,0F7H
        LD	(EXTBIO+0),HL
        LD	HL,I4100
        LD	(EXTBIO+2),HL
        RET

;	  Subroutine EXTBIO handler
;	     Inputs  ________________________
;	     Outputs ________________________

I4100:	CALL	C4118			; handle MSX-KANJI bios
        PUSH	AF
        LD	A,(SLTWRK+1)
        CP	0C9H			; was orginal EXTBIO in use ?
        JR	Z,J4116			; nope, just quit
        PUSH	AF
        POP	IY
        LD	IX,(SLTWRK+2)
        POP	AF
        JP	CALSLT			; continue with orginal EXTBIO handler

J4116:	POP	AF
        RET

;	  Subroutine __________________________
;	     Inputs  ________________________
;	     Outputs ________________________

C4118:	PUSH	AF
        LD	A,D
        CP	11H			; MSX-KANJI ?
        JR	NZ,J414E		; nope, quit
        CALL	C4099			; get my SLTWRK entry
        LD	A,E
        OR	A
        JR	NZ,J4135		; not function 0
        POP	AF
        XOR	A
        BIT	5,(IX+1)
        RET	Z			; kanji driver not active, return 0 (ANK mode)
        LD	A,(IX+0)
        RLCA
        RLCA
        AND	03H
        INC	A			; return kanji mode +1
        RET

J4135:	DEC	A
        JR	NZ,J414E		; not function 1, quit
        LD	A,(IX+0)
        OR	A
        JR	Z,J414E			; quit
        POP	AF
        CP	05H			; mode must be 0-4
        RET	NC			; illegal mode, quit
        PUSH	AF
        PUSH	BC
        PUSH	DE
        PUSH	HL
        CALL	C4150			; set kanji mode
        POP	HL
        POP	DE
        POP	BC
        POP	AF
        RET

J414E:	POP	AF
        RET

;	  Subroutine __________________________
;	     Inputs  ________________________
;	     Outputs ________________________

C4150:	DEC	A
        JP	M,A43FE			; mode 0, select ANK mode
        RRCA
        RRCA
        JP	J426A

;	  Subroutine hook H.TIMI if not already done
;	     Inputs  ________________________
;	     Outputs ________________________

C4159:	LD	A,(SLTWRK+4)
        AND	A
        RET	NZ
        LD	A,(H.TIMI+1)
        LD	(SLTWRK+4),A
        LD	HL,(H.TIMI+2)
        LD	(SLTWRK+5),HL
        CALL	C44EB			; get slotid
        LD	H,A
        LD	L,0F7H
        DI
        LD	(H.TIMI+0),HL
        LD	HL,I5381
        EI
        LD	(H.TIMI+2),HL
        RET

;	  Subroutine remove myself from the H.TIMI hook
;	     Inputs  ________________________
;	     Outputs ________________________

C417C:	CALL	C44EB			; get slotid
        LD	HL,H.TIMI+1
        CP	(HL)			; H.TIMI hooked by me ?
        RET	NZ			; nope, quit
        LD	HL,(H.TIMI+2)
        LD	DE,I5381
        SBC	HL,DE			; my H.TIMI handler ?
        RET	NZ			; nope, quit
        LD	A,(SLTWRK+4)
        CP	0C9H
        JR	Z,J419D
        LD	HL,(SLTWRK+5)
        DI
        LD	(H.TIMI+1),A
        JR	J41A2

J419D:	LD	L,A
        LD	H,A
        LD	(H.TIMI+0),HL
J41A2:	EI
        LD	(H.TIMI+2),HL
        XOR	A
        LD	(SLTWRK+4),A
        RET

A41AB:	EI
        PUSH	HL
        LD	HL,I41D4
J41B0:	LD	DE,PROCNM
J41B3:	LD	A,(DE)
        CP	(HL)
        JR	NZ,J41C7
        INC	DE
        INC	HL
        AND	A
        JR	NZ,J41B3
        LD	E,(HL)
        INC	HL
        LD	D,(HL)
        POP	HL
        CALL	C41C5
        AND	A
        RET

;	  Subroutine call subroutine
;	     Inputs  DE = address of subroutine
;	     Outputs ________________________

C41C5:	PUSH	DE
        RET

J41C7:	LD	C,0FFH
        XOR	A
        CPIR
        INC	HL
        INC	HL
        CP	(HL)
        JR	NZ,J41B0
        POP	HL
        SCF
        RET

I41D4:	DEFB	"PALETTE",0
        DEFW	A7192
        DEFB	"CLS",0
        DEFW	A471F
        DEFB	"AKCNV",0
        DEFW	A6C74
        DEFB	"JIS",0
        DEFW	A6E0A
        DEFB	"SJIS",0
        DEFW	A6DF3
        DEFB	"KACNV",0
        DEFW	A6D5B
        DEFB	"KEXT",0
        DEFW	A6E49
        DEFB	"KINSTR",0
        DEFW	A6F49
        DEFB	"KLEN",0
        DEFW	A6FEB
        DEFB	"KMID",0
        DEFW	A6EA2
        DEFB	"KNJ",0
        DEFW	A6F12
        DEFB	"KTYPE",0
        DEFW	A702D
        DEFB	"KANJI",0
        DEFW	A4260
        DEFB	"KANJI0",0
        DEFW	A4260
        DEFB	"KANJI1",0
        DEFW	A4262
        DEFB	"KANJI2",0
        DEFW	A4265
        DEFB	"KANJI3",0
        DEFW	A4268
        DEFB	"ANK",0
        DEFW	A43FE
        DEFB	0

A4260:	XOR	A			; kanji mode 0, 8*16 characters
        DEFB	001H
A4262:	LD	A,040H			; kanji mode 1, 6*16 characters
        DEFB	001H
A4265:	LD	A,080H			; kanji mode 2, 8*8 characters
        DEFB	001H
A4268:	LD	A,0C0H			; kanji mode 3, 6*8 characters
J426A:	PUSH	HL
        PUSH	AF
        LD	HL,I4067
        CALL	C4030			; initialize hooks
        CALL	C4099			; get my SLTWRK entry
        SET	5,(IX+1)		; kanji driver active
        POP	BC
        LD	A,(IX+0)
        AND	A
        PUSH	AF
        LD	(IX+0),B		; kanji mode
        LD	A,24
        LD	(LINTTB),A
        XOR	A
        OUT	(0D8H),A
        LD	A,2
        OUT	(0D9H),A
        LD	HL,I43F6
        LD	B,8
J4293:	IN	A,(0D9H)
        CP	(HL)
        JR	NZ,J429F
        INC	HL
        DJNZ	J4293
        SET	3,(IX+0)		; set JIS-1 rom flag
J429F:	IN	A,(40H)
        PUSH	AF
        LD	A,0F7H
        OUT	(40H),A
        LD	B,1
        IN	A,(40H)
        CP	08H
        JR	Z,J42D7
        LD	A,01H
        OUT	(42H),A
        XOR	A
        OUT	(47H),A
        OUT	(48H),A
        LD	B,A
        IN	A,(49H)
        LD	C,A
        IN	A,(49H)
        OR	C
        JR	NZ,J42D7
        LD	A,0EH
        OUT	(47H),A
        LD	A,5FH
        OUT	(48H),A
        LD	C,00H
        LD	B,8
J42CC:	IN	A,(49H)
        ADD	A,C
        LD	C,A
        DJNZ	J42CC
        CP	4CH
        JR	NZ,J42D7
        INC	B
J42D7:	DJNZ	J42DD
        SET	4,(IX+0)		; flag Matsushita 12*12 JIS-1
J42DD:	LD	B,1
        IN	A,(41H)
        CP	08H
        JR	Z,J42FF
        LD	A,02H
        OUT	(42H),A
        LD	A,25H
        OUT	(47H),A
        LD	A,5EH
        OUT	(48H),A
        DEC	B
        IN	A,(49H)
        SUB	41H
        LD	C,A
        IN	A,(49H)
        SUB	42H
        OR	C
        JR	NZ,J42FF
        INC	B
J42FF:	DJNZ	J4305
        SET	6,(IX+1)		; flag Matsushita 12*12 JIS-2
J4305:	POP	AF
        CPL
        OUT	(40H),A
        LD	A,3EH
        OUT	(0DAH),A
        LD	A,35H
        OUT	(0DBH),A
        LD	BC,0800H
J4314:	IN	A,(0DBH)
        ADD	A,C
        LD	C,A
        DJNZ	J4314
        CP	95H
        JR	NZ,J4323
        LD	HL,MODE
        SET	6,(HL)			; set JIS-2 rom flag
J4323:	LD	A,(H.PHYD+0)
        CP	0C9H			; disk system active ?
        JR	Z,J4336
        LD	HL,0A080H
        LD	(DF30F+0),HL
        LD	HL,0FDE0H
        LD	(DF30F+2),HL		; yep, fill double byte header table disk system
J4336:	CALL	C43AD			; calculate and set kanji screenwidth
        CALL	C4159			; hook H.TIMI if not already done
        POP	AF
        POP	HL
        JR	NZ,C4398		; reset CHPUT variables and quit
        LD	(SWPTMP),HL		; save BASIC pointer
        CALL	C40CB			; hook EXTBIO
        LD	IX,M6C1C
        CALL	CALBAS			; close all i/o channels
        CALL	C67A5			; initialize MSX-JE if available
        CALL	C,C7951			; not available, own 'MSX-JE'
        PUSH	AF
        CALL	C4398			; reset CHPUT variables
        POP	AF
        LD	HL,(SWPTMP)		; restore BASIC pointer
        RET	C			; error, quit
        PUSH	HL
        LD	HL,(CURLIN)
        LD	(OLDLIN),HL		; save current linenumber
        LD	HL,I43DB
        LD	DE,HOLD8
        LD	BC,27
        LDIR				; BASIC program in HOLD8 to initialize BASIC for the new HIMEM value
        LD	A,(MAXFIL)
        LD	(HOLD8+5),A
        POP	HL
        LD	A,L
        LD	(HOLD8+13),A
        LD	A,H
        LD	(HOLD8+21),A
        XOR	A
        LD	(MAXFIL),A		; currently no i/o channels
        LD	HL,BUF
        LD	(FILTAB),HL		; i/o channel control block�s
        LD	HL,BUF+2
        LD	(BUF+0),HL		; i/o channel 0 control block
        LD	(HL),A			; i/o channel 0 is not open
        LD	HL,HOLD8
        LD	IX,M4601
        JP	CALBAS			; execute new statement

;	  Subroutine reset CHPUT variables
;	     Inputs  ________________________
;	     Outputs ________________________

C4398:	XOR	A
        LD	IX,CHPUT
        JP	C44E2

;	  Subroutine calculate and set kanji screenwidth when not in DOS environment
;	     Inputs  ________________________
;	     Outputs ________________________

C43A0:	LD	A,(H.PHYD+0)
        CP	0C9H			; disk system active ?
        JR	Z,C43AD			; nope, calculate and set kanji screenwidth and quit
        LD	A,(DF36B)
        CP	0C3H			; in DOS environment ?
        RET	Z			; yep, quit

;	  Subroutine calculate and set kanji screenwidth
;	     Inputs  ________________________
;	     Outputs ________________________

C43AD:	PUSH	HL
        CALL	C4453			; get screenwidth previous textmode
        BIT	6,(IX+0)		; character width
        JR	NC,J43C3		; previous textmode screenmode 0,
        JR	Z,J43D3			; character width = 8, use screenwidth previous textmode
        LD	E,A
        ADD	A,A
        ADD	A,A
        ADD	A,E			; *5
        RRCA
        RRCA				; /4
        AND	3FH
        JR	J43D3

J43C3:	JR	NZ,J43D3		; character width = 8, use screenwidth previous textmode
        LD	L,A
        LD	H,0
        ADD	HL,HL
        ADD	HL,HL			; *4
        LD	DE,-5
        LD	A,-1
J43CF:	ADD	HL,DE
        INC	A
        JR	C,J43CF			; /5
J43D3:	LD	(LINLEN),A		; set screenwidth
        LD	(IX+6),A
        POP	HL
        RET

I43DB:	DEFB	":"
        DEFB	0CDH			; MAX
        DEFB	0B7H			; FILES
        DEFB	0EFH			; =
        DEFB	00FH			; byte constant
        DEFB	0
        DEFB	":"
        DEFB	098H			; POKE
        DEFB	00CH			; hexadecimal constant
        DEFW	OLDTXT+0
        DEFB	","
        DEFB	00FH			; byte constant
        DEFB	0
        DEFB	":"
        DEFB	098H			; POKE
        DEFB	00CH			; hexadecimal constant
        DEFW	OLDTXT+1
        DEFB	","
        DEFB	00FH			; byte constant
        DEFB	0
        DEFB	":"
        DEFB	099H			; CONT
        DEFB	0			; end of BASIC line
        DEFW	0			; endpointer

I43F6:	DEFB	000H
        DEFB	040H
        DEFB	020H
        DEFB	010H
        DEFB	008H
        DEFB	004H
        DEFB	002H
        DEFB	001H

A43FE:	CALL	C4099			; get my SLTWRK entry
        BIT	5,(IX+1)
        RET	Z			; kanji driver already deactived, quit
        RES	5,(IX+1)		; kanji driver inactive
J440A:	PUSH	HL
        LD	HL,I4067
        CALL	C4051			; clear all hooks used by me
        CALL	C417C			; remove myself from the H.TIMI hook
        CALL	C6C38			; force end of ESC "K" mode
        CALL	C79B9			; get japanese input frontend processor area
        JR	Z,J4423			; not a MSX-JE,
        BIT	0,(IY+8)
        CALL	NZ,C6878		; restore functionkey F1-F8 definitions
J4423:	LD	(IY+8),0
        CALL	C4453			; get screenwidth previous textmode
        LD	(LINLEN),A
        LD	A,24
        LD	(CRTCNT),A
        LD	A,2
        LD	(SCRMOD),A
        LD	IX,TOTEXT
        CALL	C44E2			; to text screenmode
        CALL	C44C1			; interlace off, enable sprites
        LD	A,(H.PHYD+0)
        CP	0C9H			; disk system active ?
        JR	Z,J4451
        LD	HL,0
        LD	(DF30F+0),HL
        LD	(DF30F+2),HL		; yep, clear double byte header table
J4451:	POP	HL
        RET

;	  Subroutine get screenwidth previous textmode
;	     Inputs  ________________________
;	     Outputs ________________________

C4453:	LD	A,(OLDSCR)
        AND	A
        LD	A,(LINL40)
        RET	Z
        LD	A,(LINL32)
        SCF
        RET

;	  Subroutine H.WIDT
;	     Inputs  ________________________
;	     Outputs ________________________

A4460:	EI
        NOP
        CP	26			; screen width <26 ?
        JR	C,J4499			; yep, quit with screenwidth 0, which generates a illegal function call
        CALL	C4099			; get my SLTWRK entry
        LD	A,(SCRMOD)
        CP	2			; in graphic mode ?
        JR	NC,J4499		; yep, quit with screenwidth 0, which generates a illegal function call
        LD	A,(IDBYT2)
        AND	A			; msx2 or higher ?
        LD	A,E
        JR	NZ,J4489		; yep, check for 80 or 64
        BIT	6,(IX+0)
        JR	NZ,J4483		; character width 6, check for 40
        CP	32+1
        JR	C,J449C
        JR	J4499			; quit with screenwidth 0, which generates a illegal function call

J4483:	CP	40+1
        JR	C,J449C
        JR	J4499			; quit with screenwidth 0, which generates a illegal function call

J4489:	BIT	6,(IX+0)
        JR	NZ,J4495		; character width 6,
        CP	64+1
        JR	C,J449C
        JR	J4499			; quit with screenwidth 0, which generates a illegal function call

J4495:	CP	80+1
        JR	C,J449C
J4499:	XOR	A
        LD	E,A
        RET

J449C:	LD	(LINLEN),A
        LD	A,(RG0SAV)
        OR	08H
        LD	(RG0SAV),A
        CALL	C4568
        LD	A,(LINLEN)
J44AD:	SUB	14
        JR	NC,J44AD
        ADD	A,28
        CPL
        INC	A
        ADD	A,E
        LD	(CLMLST),A
        CALL	C4504			; replace return address with quit routine
        RET

;	  Subroutine H.SCRE handler (screen statement)
;	     Inputs  ________________________
;	     Outputs ________________________

A44BD:	RET	Z			; end of statement, execute SCREEN statement as normal
        CP	","			; screenmode not specified ?
        RET	Z			; yep, execute SCREEN statement as normal

;	  Subroutine interlace off, enable sprites
;	     Inputs  ________________________
;	     Outputs ________________________

C44C1:	PUSH	AF
        LD	A,(RG9SAV)
        AND	0F3H
        LD	C,9
        CALL	C44D8			; disabled interlace and alternate if msx2 or above
        LD	A,(RG8SAV)
        AND	0FDH
        LD	C,8
        CALL	C44D8			; enable sprites if msx2 or above
        POP	AF
        RET				; execute SCREEN statement as normal

;	  Subroutine write vdp register if msx2 or above
;	     Inputs  ________________________
;	     Outputs ________________________

C44D8:	LD	B,A
        LD	A,(EXBRSA)
        AND	A
        RET	Z
        LD	IX,WRTVDP
;
;	  Subroutine call main bios
;	     Inputs  ________________________
;	     Outputs ________________________

C44E2:	LD	IY,(EXPTBL+0-1)
        CALL	CALSLT
        EI
        RET

;	  Subroutine __________________________
;	     Inputs  ________________________
;	     Outputs ________________________

C44EB:	IN	A,(0A8H)
        RRCA
        RRCA
        AND	03H
        LD	HL,EXPTBL
        LD	B,00H
        LD	C,A
        ADD	HL,BC
        OR	(HL)
        RET	P
        LD	C,A
        INC	HL
        INC	HL
        INC	HL
        INC	HL
        LD	A,(HL)
        AND	0CH
        OR	C
        RET

;	  Subroutine replace return address with quit routine
;	     Inputs  ________________________
;	     Outputs ________________________

C4504:	PUSH	HL
        PUSH	AF
        LD	A,(D.FDBE)
        ADD	A,A
        LD	HL,12
        JR	NC,J4511
        LD	L,12+8
J4511:	ADD	HL,SP
        LD	(HL),LOW (WRPRIM+6)
        INC	HL
        LD	(HL),HIGH (WRPRIM+6)
        POP	AF
        POP	HL
        RET

;	  Subroutine replace return address with other routine
;	     Inputs  ________________________
;	     Outputs ________________________

C451A:	PUSH	HL
        PUSH	AF
        LD	A,(D.FDBE)
        ADD	A,A
        LD	HL,12
        JR	NC,J4527
        LD	L,12+8
J4527:	ADD	HL,SP
        LD	(HL),E
        INC	HL
        LD	(HL),D
        POP	AF
        POP	HL
        RET

;	  Subroutine H.CHGE handler
;	     Inputs  ________________________
;	     Outputs ________________________

A452E:	EI
        NOP
        LD	DE,M0D0C+1
        CALL	C451A			; replace return address with other routine
        CALL	C4099			; get my SLTWRK entry
        XOR	A
        CALL	C456D			; setup kanji screenmode if needed
;
;	  Subroutine __________________________
;	     Inputs  ________________________
;	     Outputs ________________________

C453D:	LD	A,0C9H
        LD	(H.CHGE+0),A
        CALL	C4099			; get my SLTWRK entry
        CALL	C6895
        LD	HL,H.CHGE+0
        LD	(HL),0F7H
        RET

;	  Subroutine H.TOTE handler
;	     Inputs  ________________________
;	     Outputs ________________________

A454E:	EI
        NOP
        CALL	C4504			; replace return address with quit routine
        CALL	C4099			; get my SLTWRK entry
        LD	A,(NORUSE)
        BIT	7,A			; b7 set ?
        RET	NZ			; quit doing nothing
        LD	A,(OLDSCR)
        LD	(SCRMOD),A
        LD	A,(IX+6)
        LD	(LINLEN),A

;	  Subroutine __________________________
;	     Inputs  ________________________
;	     Outputs ________________________

C4568:	LD	A,24
        LD	(LINTTB),A

;	  Subroutine __________________________
;	     Inputs  ________________________
;	     Outputs ________________________

C456D:	PUSH	AF
        LD	A,(RG0SAV)
        AND	0EH			; M3,M4 and M5
        JR	Z,J4589			; screenmode 0(40*24), screenmode 3 or screenmode 1(32*24)
        CP	04H			; screenmode 0(80*24) or screenmode 4 ?
        JR	NZ,J4580		; nope, in graphic mode
        LD	A,(RG1SAV)
        AND	18H			; M2 and M1
        JR	J4590			; check if screenmode 0(80)

J4580:	LD	A,(LINTTB)
        CP	24
        JR	Z,J4597
        JR	J45A4

J4589:	LD	A,(RG1SAV)
        AND	18H			; M2 and M1
        JR	Z,J4594			; screenmode 1, not in graphics mode
                                        ; check if screenmode 0(40)
J4590:	CP	10H
        JR	NZ,J4580		; nope, in graphic mode
J4594:	CALL	C43A0			; calculate and set kanji screenwidth when not in DOS environment
J4597:	LD	A,0FFH
        LD	(LINTTB),A
        LD	A,(IX+1)
        OR	0FH
        LD	(IX+1),A		; set b3-b0
J45A4:	PUSH	HL
        LD	A,(SCRMOD)
        CP	1			; currently in screenmode 1 ?
        JR	NZ,J45AD		; nope,
        XOR	A
J45AD:	LD	L,A			; current graphic screenmode (0 if in textmode)
        LD	A,(IX+1)
        LD	H,A
        AND	0F0H
        OR	L
        LD	(IX+1),A
        LD	A,H
        AND	0FH
        CP	L			; same as previous ?
        JP	Z,J46DC			; nope, quit
        PUSH	DE
        PUSH	BC
        RES	5,(IX+0)
        LD	A,L
        CP	2			; in graphic mode ?
        JR	NC,J4609		; yep,
        SET	5,(IX+0)
        LD	A,(IDBYT2)
        AND	A			; msx 1 ?
        LD	B,2
        JR	Z,J45F5			; yep, use screenmode 2
        BIT	6,(IX+0)
        LD	A,(LINLEN)
        JR	NZ,J45E3		; character width 6, 40 is the limit for 256
        CP	32+1			; character width 8, 32 is the limit for 256
        JR	J45E5

J45E3:	CP	40+1
J45E5:	LD	B,5
        JR	C,J45F5			; fits on a 256 width screen, use screenmode 5
        LD	A,(MODE)
        AND	06H
        CP	04H			; VRAM size 128 KB ?
        LD	B,7
        JR	Z,J45F5			; yep, use screenmode 7
        DEC	B			; nope, use screenmode 6
J45F5:	PUSH	BC
        LD	A,B
        CALL	CHGMOD			; change to graphic screenmode
        XOR	A
        LD	(SCRMOD),A		; fake screenmode 0
        LD	A,(IDBYT2)
        AND	A			; msx 1 ?
        LD	A,(RG8SAV)
        SET	1,A			; turn off sprites
        JR	J4622

J4609:	LD	B,A
        LD	A,(IX+1)
        AND	0F0H
        OR	B
        LD	(IX+1),A		;
        LD	A,0FFH
        LD	(LINLEN),A
        PUSH	BC
        LD	A,(IDBYT2)
        AND	A			; msx 1 ?
        LD	A,(RG8SAV)
        RES	1,A			; turn on sprites
J4622:	LD	B,A
        LD	C,8
        CALL	NZ,WRTVDP		; not msx 1, write vdp register 8 (turn sprites on/off)
        POP	AF			; graphic screenmode
        DEC	A
        LD	C,A
        LD	A,(IX+0)
        AND	0F8H
        OR	C			; b2-b0 represent the graphic mode
        LD	(IX+0),A
        RRCA
        RRCA
        AND	30H			; kanji mode
        SLA	C
        OR	C
        LD	C,A
        LD	B,00H
        LD	HL,I46DF
        ADD	HL,BC
        LD	A,(LINLEN)
        CP	26
        JR	NC,J464E
        LD	A,26
        LD	(LINLEN),A
J464E:	CP	(HL)
        JR	C,J4655
        LD	A,(HL)
        LD	(LINLEN),A		; screenwidth
J4655:	LD	B,A
        LD	A,(SCRMOD)
        CP	2
        LD	A,B
        JR	NC,J4661
        LD	(IX+6),A
J4661:	INC	HL
        LD	A,(HL)
        LD	(CRTCNT),A		; srceenlength
	LD	A,(IDBYT2)
        AND	A			; msx 1 ?
        JR	Z,J46AE			; yep, skip interlace
        LD	A,(SCRMOD)
        CP	2
        JR	C,J467A
        LD	A,(NORUSE)
        BIT	7,A
        JR	Z,J46AE
J467A:	LD	A,(IX+0)
        AND	07H			; graphic screenmode
        CP	5-1			; screenmode 2 ?
        LD	A,(RG2SAV)
        JR	C,J469B			; yep, disable interlace
        BIT	7,(IX+0)		; interlace mode ?
        JR	Z,J469B			; nope, disable interlace
        OR	20H			; set A15 pattern name table
        LD	B,A
        LD	C,2
        CALL	WRTVDP
        LD	A,(RG9SAV)
        OR	0CH			; interlace + alternate
        JR	J46A8

J469B:	AND	0DFH
        LD	B,A
        LD	C,2
        CALL	WRTVDP
        LD	A,(RG9SAV)
        AND	0F3H			; no interlace, no alternate
J46A8:	LD	B,A
        LD	C,9
        CALL	WRTVDP
J46AE:	LD	A,(RG7SAV)
        AND	0F0H
        LD	HL,BAKCLR
        OR	(HL)
        LD	B,A
        LD	C,7
        LD	A,(SCRMOD)
        CP	2
        CALL	C,WRTVDP		; yep, setup background color
        LD	HL,0101H
        LD	(CSRY),HL		; cursor at 1,1
        POP	BC
        POP	DE
        LD	A,(SCRMOD)
        CP	02H
        JR	NC,J46DC
        POP	HL
        POP	AF			; character to print
        PUSH	AF
        PUSH	HL
        CP	0CH			; CLS ?
        LD	A,0CH
        CALL	NZ,C473A		; nope, CLS character to kanji screen
J46DC:	POP	HL
        POP	AF
        RET

I46DF:  DEFB    0,0
        DEFB    32,12
        DEFB    8,3
        DEFB    32,12
        DEFB    32,13
        DEFB    64,13
        DEFB    64,13
        DEFB    32,13
        DEFB    0,0
        DEFB    40,12
        DEFB    10,3
        DEFB    40,12
        DEFB    40,13
        DEFB    80,13
        DEFB    80,13
        DEFB    40,13
        DEFB    0,0
        DEFB    32,12
        DEFB    8,3
        DEFB    32,12
        DEFB    32,24
        DEFB    64,24
        DEFB    64,24
        DEFB    32,24
        DEFB    0,0
        DEFB    40,12
        DEFB    10,3
        DEFB    40,12
        DEFB    40,24
        DEFB    80,24
        DEFB    80,24
        DEFB    40,24

A471F:  LD      A,(SCRMOD)
        CP      2                       ; graphic screen ?
        JR	NC,J4736
        CALL	C4099			; get my SLTWRK entry
        BIT	5,(IX+1)		; kanji driver active ?
        JR	Z,J4736			; nope, do CLS via bios
        LD	A,0CH
J4731:	CALL	C456D			; setup kanji screenmode if needed and clear screen
        JR	C473A			; character to kanji screen

J4736:	XOR	A
        JP	CLS

;	  Subroutine character to kanji screen
;	     Inputs  ________________________
;	     Outputs ________________________

C473A:	PUSH	HL
        PUSH	DE
        PUSH	BC
        PUSH	AF
        CALL	C4756			; character to kanji screen
        POP	AF
        POP	BC
        POP	DE
        POP	HL
        RET

;	  Subroutine H.CHPU handler (character to screen)
;	     Inputs  ________________________
;	     Outputs ________________________

A4746:	EI
        NOP
        CALL	C4099			; get my SLTWRK entry
        CALL	C456D			; setup kanji screenmode if needed
        LD	C,A
        LD	DE,M0D0C
        CALL	C451A			; replace return address with other routine
        LD	A,C

;	  Subroutine character to kanji screen
;	     Inputs  ________________________
;	     Outputs ________________________

C4756:	PUSH	AF
        CALL	C489D
J475A:	POP	AF
        CALL	C4769
        CALL	C4885
        LD	A,(CSRX)
        DEC	A
        LD	(TTYPOS),A
        RET

;	  Subroutine __________________________
;	     Inputs  ________________________
;	     Outputs ________________________

C4769:	LD	C,A
        LD	HL,ESCCNT
        LD	A,(HL)
        AND	A
        JP	NZ,J4833
        LD	A,C
        CP	20H	; " "
        JR	C,J47B4
        LD	HL,(CSRY)
        CP	7FH
        JP	Z,J49EC
        BIT	7,(IX+2)
        JR	NZ,J4798
        CALL	C4908			; double byte header character ?
        JR	C,J479B			; nope,
        LD	A,(LINLEN)
        CP	H
        PUSH	BC
        LD	A,0FFH
        CALL	Z,C4769
        POP	BC
        JP	C4C9B

J4798:	CALL	C4923
J479B:	CALL	C4C9B
        CALL	C4923
        RET	NZ
        XOR	A
        CALL	C4C6F
        LD	H,01H	; 1

C47A8:  CALL	C4954
        RET	NZ
        CALL	C495C
        LD	L,01H	; 1
        JP	C497B

J47B4:	LD	(IX+2),00H
        LD	HL,T47D3-2
        LD	C,0CH	; 12
;
;	  Subroutine __________________________
;	     Inputs  ________________________
;	     Outputs ________________________

C47BD:	INC	HL
        INC	HL
        AND	A
        DEC	C
        RET	M
        CP	(HL)
        INC	HL
        JR	NZ,C47BD
        LD	C,(HL)
        INC	HL
        LD	B,(HL)
        LD	HL,(CSRY)
        CALL	C47D1
        XOR	A
        RET

;	  Subroutine __________________________
;	     Inputs  ________________________
;	     Outputs ________________________

C47D1:	PUSH	BC
        RET

T47D3:  DEFB    7
        DEFW    BEEP
        DEFB    8
        DEFW    C492B
        DEFB    9
        DEFW    C4964
        DEFB    10
        DEFW    C47A8
        DEFB    11
        DEFW    C4972
        DEFB    12
        DEFW    C4A8E
        DEFB    13
        DEFW    C4974
        DEFB    27
        DEFW    C482D
        DEFB    28
        DEFW    C494E
        DEFB    29
        DEFW    C492B
        DEFB    30
        DEFW    C494A
        DEFB    31
        DEFW    C4954

T47F7:	DEFB    "j"
        DEFW    C4A8E
        DEFB    "E"
        DEFW    C4A8E
        DEFB    "K"
        DEFW    C49FB
        DEFB    "J"
        DEFW    C4A55
        DEFB    "l"
        DEFW    C49F9
        DEFB    "L"
        DEFW    C49B2
        DEFB    "M"
        DEFW    C4978
        DEFB    "Y"
        DEFW    C482A
        DEFB    "A"
        DEFW    C494A
        DEFB    "B"
        DEFW    C4954
        DEFB    "C"
        DEFW    C4923
        DEFB    "D"
        DEFW    C4948
        DEFB    "H"
        DEFW    C4972
        DEFB    "x"
        DEFW    C4824
        DEFB    "y"
        DEFW    C4827

C4824:  LD	A,01H
        DEFB	1
C4827:  LD	A,02H
        DEFB	1
C482A:  LD	A,04H
        DEFB	1
C482D:  LD	A,0FFH
        LD	(ESCCNT),A
        RET

J4833:	JP	P,J4841
        LD	(HL),00H
        LD	A,C
        LD	HL,T47F7-2
        LD	C,0FH
        JP	C47BD

J4841:	DEC	A
        JR	Z,J4862
        DEC	A
        JR	Z,J486C
        DEC	A
        LD	(HL),A
        LD	A,(LINLEN)
        LD	DE,CSRX
        JR	Z,J4857
        LD	(HL),03H	; 3
        CALL	C4C76
        DEC	DE
J4857:	LD	B,A
        LD	A,C
        SUB	20H	; " "
        CP	B
        INC	A
        LD	(DE),A
        RET	C
        LD	A,B
        LD	(DE),A
        RET

J4862:	LD	(HL),A
        LD	A,C
        SUB	34H	; "4"
        JR	Z,J4873
        DEC	A
        JR	Z,J487A
        RET

J486C:	LD	(HL),A
        LD	A,C
        SUB	34H	; "4"
        JR	NZ,J4877
        INC	A
J4873:	LD	(CSTYLE),A
        RET

J4877:	DEC	A
        RET	NZ
        INC	A
J487A:	LD	(CSRSW),A
        RET

;	  Subroutine __________________________
;	     Inputs  ________________________
;	     Outputs ________________________

C487E:	LD	A,(CSRSW)
        AND	A
        RET	NZ
        JR	J48AC

;	  Subroutine __________________________
;	     Inputs  ________________________
;	     Outputs ________________________

C4885:	LD	A,(CSRSW)
        AND	A
        RET	Z
        JR	J48AC

;	  Subroutine H.DSPC handler
;	     Inputs  ________________________
;	     Outputs ________________________

A488C:	EI
        NOP
        CALL	C4504			; replace return address with quit routine
        CALL	C4099			; get my SLTWRK entry
        JR	J48AC

;	  Subroutine __________________________
;	     Inputs  ________________________
;	     Outputs ________________________

C4896:	LD	A,(CSRSW)
        AND	A
        RET	NZ
        JR	J48AC

;	  Subroutine __________________________
;	     Inputs  ________________________
;	     Outputs ________________________

C489D:	LD	A,(CSRSW)
        AND	A
        RET	Z
        JR	J48AC

;	  Subroutine H.ERAC handler
;	     Inputs  ________________________
;	     Outputs ________________________

A48A4:	EI
        NOP
        CALL	C4504			; replace return address with quit routine
        CALL	C4099			; get my SLTWRK entry
J48AC:	CALL	C48CC
        RET	NC
        LD	A,(CSTYLE)
        AND	A
        LD	E,00H
        JR	Z,J48BA
        LD	E,01H	; 1
J48BA:	PUSH	DE
        CALL	C48DA
        CP	01H	; 1
        JR	NZ,J48C3
        XOR	A
J48C3:	POP	DE
        OR	E
        LD	E,A
        LD	HL,(CSRY)
        JP	C5C8E

;	  Subroutine __________________________
;	     Inputs  ________________________
;	     Outputs ________________________

C48CC:	LD	A,(SCRMOD)
        CP	02H	; 2
        RET	C
        LD	A,(NORUSE)
        BIT	7,A
        RET	Z
        SCF
        RET

;	  Subroutine __________________________
;	     Inputs  ________________________
;	     Outputs ________________________

C48DA:	LD	HL,(CSRY)
;
;	  Subroutine __________________________
;	     Inputs  ________________________
;	     Outputs ________________________

C48DD:	PUSH	HL
        LD	H,01H	; 1
        CALL	C4C80
        POP	AF
        LD	L,A
J48E5:	LD	A,L
        CP	H
        JR	Z,J48FF
        LD	A,01H	; 1
        RET	C
        LD	A,C
        CALL	C4908			; double byte header character ?
        LD	A,(D0006)
        LD	C,A
        IN	C,(C)
        INC	H
        JR	C,J48E5			; nope,
        LD	C,A
        IN	C,(C)
        INC	H
        JR	J48E5

J48FF:	LD	A,C
        CALL	C4908			; double byte header character ?
        LD	A,2
        RET	NC			; yep, quit
        XOR	A
        RET

;	  Subroutine double byte header character ?
;	     Inputs  ________________________
;	     Outputs ________________________

C4908:	CP	81H
        RET	C
        CP	0A0H
        CCF
        RET	NC
        CP	0E0H
        RET	C
        CP	0FDH
        CCF
        RET

;	  Subroutine __________________________
;	     Inputs  ________________________
;	     Outputs ________________________

C4916:	CP	40H	; "@"
        RET	C
        CP	0FDH
        CCF
        RET	C
        CP	7FH
        SCF
        RET	Z
        AND	A
        RET

;	  Subroutine __________________________
;	     Inputs  ________________________
;	     Outputs ________________________

C4923:	LD	A,(LINLEN)
        CP	H
        RET	Z
        INC	H
        JR	C495C

;	  Subroutine __________________________
;	     Inputs  ________________________
;	     Outputs ________________________

C492B:	CALL	C4948
        RET	NZ
        LD	A,(LINLEN)
        LD	H,A
        DEC	L
        RET	Z
        CALL	C4C80
        INC	A
        JR	NZ,C495C
        DEC	H
        JR	C495C

;	  Subroutine __________________________
;	     Inputs  ________________________
;	     Outputs ________________________

C493E:	CALL	C4948
        RET	NZ
        LD	A,(LINLEN)
        LD	H,A
        JR	C494A

;	  Subroutine __________________________
;	     Inputs  ________________________
;	     Outputs ________________________

C4948:	DEC	H
        DEFB	03EH

C494A:	DEC	L
        RET	Z
        JR	C495C

;	  Subroutine __________________________
;	     Inputs  ________________________
;	     Outputs ________________________

C494E:	CALL	C4923
        RET	NZ
        LD	H,01H	; 1
;
;	  Subroutine __________________________
;	     Inputs  ________________________
;	     Outputs ________________________

C4954:	CALL	C4C76
        CP	L
        RET	Z
        JR	C,J4960
        INC	L
;
;	  Subroutine __________________________
;	     Inputs  ________________________
;	     Outputs ________________________

C495C:	LD	(CSRY),HL
        RET

J4960:	DEC	L
        XOR	A
        JR	C495C

C4964:	LD	A,20H	; " "
        CALL	C4769
        LD	A,(CSRX)
        DEC	A
        AND	07H	; 7
        JR	NZ,C4964
        RET

;	  Subroutine __________________________
;	     Inputs  ________________________
;	     Outputs ________________________

C4972:	LD	L,01H	; 1
;
;	  Subroutine __________________________
;	     Inputs  ________________________
;	     Outputs ________________________

C4974:	LD	H,01H	; 1
        JR	C495C

;	  Subroutine __________________________
;	     Inputs  ________________________
;	     Outputs ________________________

C4978:	CALL	C4974
;
;
;	  Subroutine __________________________
;	     Inputs  ________________________
;	     Outputs ________________________

C497B:	CALL	C4C76
        SUB	L
        RET	C
        JP	Z,C49F9
        PUSH	HL
        PUSH	AF
        LD	C,A
        LD	B,00H
        CALL	C4C61
        LD	L,E
        LD	H,D
        INC	HL
        LDIR
        LD	HL,FSTPOS
        DEC	(HL)
        POP	AF
        POP	HL
        CALL	C5D8E
J4999:	PUSH	AF
        INC	L
        CALL	C4B56
        DEC	L
        CALL	C4BA5
        INC	L
        CALL	C4B64
        DEC	L
        CALL	C4BB3
        INC	L
        POP	AF
        DEC	A
        JR	NZ,J4999
        JP	C49F9

;	  Subroutine __________________________
;	     Inputs  ________________________
;	     Outputs ________________________

C49B2:	CALL	C4974
;
;
;	  Subroutine __________________________
;	     Inputs  ________________________
;	     Outputs ________________________

C49B5:	CALL	C4C76
        LD	H,A
        SUB	L
        RET	C
        JP	Z,C49F9
        LD	L,H
        PUSH	HL
        PUSH	AF
        LD	C,A
        LD	B,00H
        CALL	C4C61
        LD	L,E
        LD	H,D
        PUSH	HL
        DEC	HL
        LDDR
        POP	HL
        LD	(HL),H
        POP	AF
        POP	HL
        CALL	C5ECD
J49D4:	PUSH	AF
        DEC	L
        CALL	C4B56
        INC	L
        CALL	C4BA5
        DEC	L
        CALL	C4B64
        INC	L
        CALL	C4BB3
        DEC	L
        POP	AF
        DEC	A
        JR	NZ,J49D4
        JR	C49F9

J49EC:	LD	(IX+2),00H
        CALL	C492B
        RET	Z
        LD	C,20H	; " "
        JP	C4C9B

;	  Subroutine __________________________
;	     Inputs  ________________________
;	     Outputs ________________________

C49F9:	LD	H,01H	; 1
;	  Subroutine __________________________
;	     Inputs  ________________________
;	     Outputs ________________________

C49FB:	CALL	C4A04
        PUSH	HL
        CALL	C5FB0
        POP	HL
        RET

;	  Subroutine __________________________
;	     Inputs  ________________________
;	     Outputs ________________________

C4A04:	CALL	C4C6D
        PUSH	HL
        CALL	C4BF6
        POP	DE
        PUSH	DE
        LD	A,(LINLEN)
        SUB	D
        INC	A
        LD	C,A
        LD	B,00H
        LD	A,(IDBYT2)
        AND	A			; msx 1 ?
        LD	A,20H	; " "
        PUSH	AF
        CALL	Z,FILVRM		; msx 1,
        POP	AF
        CALL	NZ,C4A25
        POP	HL
        RET

;	  Subroutine __________________________
;	     Inputs  ________________________
;	     Outputs ________________________

C4A25:	LD	E,A
        LD	A,L
        NEG
        JR	Z,C4A39
        CP	C
        JR	NC,C4A39
        PUSH	HL
        PUSH	BC
        LD	C,A
        CALL	C4A39
        POP	BC
        POP	HL
        CALL	C4A44
;	  Subroutine __________________________
;	     Inputs  ________________________
;	     Outputs ________________________

C4A39:	PUSH	BC
        CALL	C4CC2
        POP	HL
        LD	B,L
J4A3F:	OUT	(C),E
        DJNZ	J4A3F
        RET

;	  Subroutine __________________________
;	     Inputs  ________________________
;	     Outputs ________________________

C4A44:	LD	A,C
        ADD	A,L
        LD	C,A
        LD	L,00H
        INC	H
        LD	A,(IX+0)
        AND	07H			; graphic screenmode
        CP	7-1
        RET	NC			; screenmode 7, quit
        RES	7,H
        RET

C4A55:	PUSH	HL
        CALL	C49FB
        POP	HL
        CALL	C4C76
        CP	L
        RET	C
        RET	Z
        LD	H,01H	; 1
        INC	L
        JR	C4A55

;	  Subroutine __________________________
;	     Inputs  ________________________
;	     Outputs ________________________

C4A65:	LD	HL,0101H
        LD	(CSRY),HL
J4A6B:	CALL	C4A04
        CALL	C4C76
        CP	L
        RET	C
        RET	Z
        LD	H,01H	; 1
        INC	L
        JR	J4A6B

;	  Subroutine H.ERAF handler
;	     Inputs  ________________________
;	     Outputs ________________________

A4A79:	EI
        NOP
        CALL	C4504			; replace return address with quit routine
        CALL	C4099			; get my SLTWRK entry
        XOR	A
        LD	(CNSDFG),A
        PUSH	HL
        LD	HL,(CRTCNT)
        CALL	C49F9
        POP	HL
        RET

C4A8E:	CALL	C60BB
        CALL	C6A65
        CALL	C4A65
;	  Subroutine __________________________
;	     Inputs  ________________________
;	     Outputs ________________________

C4A97:	LD	A,(CNSDFG)
        AND	A
        RET	Z
        JR	J4AA3

;	  Subroutine H.DSPF handler
;	     Inputs  ________________________
;	     Outputs ________________________

A4A9E:	EI
        NOP
        CALL	C4504			; replace return address with quit routine
J4AA3:	CALL	C4099			; get my SLTWRK entry
        CALL	C79B9			; get japanese input frontend processor area
        AND	A
        BIT	0,(IY+8)
        CALL	NZ,C6B21
        RET	C
        LD	A,0FFH
        LD	(CNSDFG),A
        PUSH	HL
        LD	A,(CSRY)
        LD	HL,CRTCNT
        CP	(HL)
        LD	A,0AH			; LF
        CALL	Z,C473A			; yep, character to kanji screen
        LD	A,(NEWKEY+6)
        RRCA
        LD	DE,FNKSTR+5*16
        LD	A,00H
        JR	NC,J4AD3
        LD	DE,FNKSTR+0*16
        INC	A
J4AD3:	LD	(FNKSWI),A
        LD	HL,(CRTCNT)
        LD	H,01H	; 1
        JR	NC,J4AE8
        CALL	C79B9			; get japanese input frontend processor area
        JR	Z,J4AE8			; not a MSX-JE,
        BIT	0,(IY+8)
        JR	NZ,J4B3F
J4AE8:	LD	A,(LINLEN)
        SUB	04H	; 4
        JR	C,J4B3F
        LD	B,0FFH
J4AF1:	SUB	05H	; 5
        INC	B
        JR	NC,J4AF1
        JR	Z,J4B3F
        LD	C,05H	; 5
J4AFA:	PUSH	BC
        LD	C,0FH	; 15
J4AFD:	LD	A,(DE)
        AND	A
        JR	Z,J4B20
        CP	21H	; "!"
        JR	C,J4B27
        CALL	C4908			; double byte header character ?
        JR	C,J4B29			; nope,
        LD	A,B
        DEC	A
        JR	Z,J4B27
        INC	DE
        LD	A,(DE)
        DEC	DE
        CALL	C4916
        JR	C,J4B44
        LD	A,(DE)
        CALL	C4B4E
        INC	DE
        DEC	C
        DEC	B
        LD	A,(DE)
        JR	J4B29

J4B20:	CALL	C4B4C
        DJNZ	J4B20
        JR	J4B30

J4B27:	LD	A,20H	; " "
J4B29:	CALL	C4B4E
        INC	DE
        DEC	C
        DJNZ	J4AFD
J4B30:	EX	(SP),HL
        LD	A,L
        EX	(SP),HL
        DEC	A
        CALL	NZ,C4B4C
        INC	DE
        EX	DE,HL
        ADD	HL,BC
        EX	DE,HL
        POP	BC
        DEC	C
        JR	NZ,J4AFA
J4B3F:	CALL	C5FB0
        POP	HL
        RET

J4B44:	CALL	C4B4C
        INC	DE
        DEC	C
        DEC	B
        JR	J4B27

;	  Subroutine __________________________
;	     Inputs  ________________________
;	     Outputs ________________________

C4B4C:	LD	A,20H	; " "
;	  Subroutine __________________________
;	     Inputs  ________________________
;	     Outputs ________________________

C4B4E:	PUSH	BC
        LD	C,A
        CALL	C5864
        POP	BC
        INC	H
        RET

;	  Subroutine __________________________
;	     Inputs  ________________________
;	     Outputs ________________________

C4B56:	PUSH	HL
        LD	H,01H	; 1
        LD	A,(LINLEN)
        CP	29H	; ")"
        JR	C,J4B6F
        LD	A,28H	; "("
        JR	J4B6F

;	  Subroutine __________________________
;	     Inputs  ________________________
;	     Outputs ________________________

C4B64:	LD	A,(LINLEN)
        CP	29H	; ")"
        RET	C
        PUSH	HL
        LD	H,29H	; ")"
        SUB	28H	; "("
J4B6F:	CALL	C4B74
        POP	HL
        RET

;	  Subroutine __________________________
;	     Inputs  ________________________
;	     Outputs ________________________

C4B74:	LD	C,A
        CALL	C4BF6
        LD	B,00H
        LD	DE,LINWRK
        LD	A,(IDBYT2)
        AND	A			; msx 1 ?
        JP	Z,LDIRMV		; yep,
        LD	A,L
        NEG
        JR	Z,C4B97
        CP	C
        JR	NC,C4B97
        PUSH	HL
        PUSH	BC
        LD	C,A
        CALL	C4B97
        POP	BC
        POP	HL
        CALL	C4A44
;	  Subroutine __________________________
;	     Inputs  ________________________
;	     Outputs ________________________

C4B97:	PUSH	BC
        CALL	C4CB9
        POP	HL
        LD	B,L
        EX	DE,HL
J4B9E:	INI
        JP	NZ,J4B9E
        EX	DE,HL
        RET

;	  Subroutine __________________________
;	     Inputs  ________________________
;	     Outputs ________________________

C4BA5:	PUSH	HL
        LD	H,01H	; 1
        LD	A,(LINLEN)
        CP	29H	; ")"
        JR	C,J4BBE
        LD	A,28H	; "("
        JR	J4BBE

;	  Subroutine __________________________
;	     Inputs  ________________________
;	     Outputs ________________________

C4BB3:	LD	A,(LINLEN)
        CP	29H	; ")"
        RET	C
        PUSH	HL
        LD	H,29H	; ")"
        SUB	28H	; "("
J4BBE:	CALL	C4BC3
        POP	HL
        RET

;	  Subroutine __________________________
;	     Inputs  ________________________
;	     Outputs ________________________

C4BC3:	LD	C,A
        CALL	C4BF6
        EX	DE,HL
        LD	B,00H
        LD	HL,LINWRK
        LD	A,(IDBYT2)
        AND	A			; msx 1 ?
        JP	Z,LDIRVM		; yep,
        EX	DE,HL
        LD	A,L
        NEG
        JR	Z,C4BE8
        CP	C
        JR	NC,C4BE8
        PUSH	HL
        PUSH	BC
        LD	C,A
        CALL	C4BE8
        POP	BC
        POP	HL
        CALL	C4A44
;	  Subroutine __________________________
;	     Inputs  ________________________
;	     Outputs ________________________

C4BE8:	PUSH	BC
        CALL	C4CC2
        POP	HL
        LD	B,L
        EX	DE,HL
J4BEF:	OUTI
        JP	NZ,J4BEF
        EX	DE,HL
        RET

;	  Subroutine __________________________
;	     Inputs  ________________________
;	     Outputs ________________________

C4BF6:	PUSH	BC
        LD	E,H
        LD	D,00H
        DEC	E
        LD	H,D
        DEC	L
        LD	A,L
        ADD	A,A
        ADD	A,A
        ADD	A,A
        LD	L,A
        LD	A,(IX+0)
        AND	07H			; graphic screenmode
        CP	2
        LD	BC,0B00H
        JR	Z,J4C4B
        LD	C,L
        LD	B,H
        ADD	HL,HL
        ADD	HL,HL
        ADD	HL,BC
        LD	BC,1E20H
        DEC	A
        JR	Z,J4C4C
        SUB	02H	; 2
        JR	Z,J4C50
        DEC	A
        LD	BC,06A00H
        JR	Z,J4C31
        CP	03H	; 3
        LD	BC,0D400H
        JR	Z,J4C31
        ADD	HL,HL
        DEC	A
        JR	NZ,J4C31
        LD	BC,06A00H
J4C31:	ADD	HL,DE
        ADD	HL,BC
        LD	A,(RG23SA)
        LD	C,00H
        LD	B,A
        LD	A,(IX+0)
        AND	07H			; b2-b0
        CP	6
        JR	NC,J4C4D
        SRL	B
        RR	C
        ADD	HL,BC
        RES	7,H
        POP	BC
        RET

J4C4B:	ADD	HL,HL
J4C4C:	ADD	HL,DE
J4C4D:	ADD	HL,BC
        POP	BC
        RET

J4C50:	LD	A,H
        AND	A
        LD	BC,1E08H
        JR	NZ,J4C4C
        LD	A,L
        CP	78H	; "x"
        JR	NC,J4C4C
        LD	BC,1B00H
        JR	J4C4C

;	  Subroutine __________________________
;	     Inputs  ________________________
;	     Outputs ________________________

C4C61:	PUSH	HL
        LD	DE,LINTTB-1
        LD	H,0
        ADD	HL,DE
        LD	A,(HL)
        EX	DE,HL
        POP	HL
        AND	A
        RET

;	  Subroutine __________________________
;	     Inputs  ________________________
;	     Outputs ________________________

C4C6D:	DEFB	03EH

;	  Subroutine __________________________
;	     Inputs  ________________________
;	     Outputs ________________________

C4C6E:	XOR	A

;	  Subroutine __________________________
;	     Inputs  ________________________
;	     Outputs ________________________

C4C6F:	PUSH	AF
        CALL	C4C61
        POP	AF
        LD	(DE),A
        RET

;	  Subroutine __________________________
;	     Inputs  ________________________
;	     Outputs ________________________

C4C76:	LD	A,(CNSDFG)
        PUSH	HL
        LD	HL,CRTCNT
        ADD	A,(HL)
        POP	HL
        RET

;	  Subroutine __________________________
;	     Inputs  ________________________
;	     Outputs ________________________

C4C80:	PUSH	DE
        PUSH	HL
        CALL	C4BF6
        LD	A,(IDBYT2)
        AND	A			; msx 1 ?
        JR	Z,J4C94		; yep,
        CALL	C4CB9
        IN	A,(C)
        LD	C,A
        POP	HL
        POP	DE
        RET

J4C94:	CALL	RDVRM
        LD	C,A
        POP	HL
        POP	DE
        RET

;	  Subroutine __________________________
;	     Inputs  ________________________
;	     Outputs ________________________

C4C9B:	PUSH	DE
        PUSH	HL
        CALL	C4BF6
        LD	A,(IDBYT2)
        AND	A			; msx 1 ?
        JR	Z,J4CAF			; yep,
        LD	B,C
        CALL	C4CC2
        OUT	(C),B
        LD	C,B
        JR	J4CB3

J4CAF:	LD	A,C
        CALL	WRTVRM
J4CB3:	POP	HL
        CALL	C5864
        POP	DE
        RET

;	  Subroutine __________________________
;	     Inputs  ________________________
;	     Outputs ________________________

C4CB9:	LD	A,(D0006)
        LD	C,A
        LD	A,H
        RES	6,H
        JR	J4CC9

;	  Subroutine __________________________
;	     Inputs  ________________________
;	     Outputs ________________________

C4CC2:	LD	A,(D0006)
        LD	C,A
        LD	A,H
        SET	6,H
J4CC9:	RES	7,H
        RLCA
        RLCA
        AND	03H	; 3
        INC	C
        DI
        OUT	(C),A
        LD	A,8EH
        OUT	(C),A
        OUT	(C),L
        OUT	(C),H
        EI
        DEC	C
        RET

;	  Subroutine H.PINLI handler
;	     Inputs  ________________________
;	     Outputs ________________________

A4CDE:	EI
        NOP
        CALL	C4504			; replace return address with quit routine
        CALL	C4099			; get my SLTWRK entry
        LD	A,0FFH
        LD	(DECCNT),A
        LD	A,(AUTFLG)
        AND	A
        JR	NZ,J4D01
        LD	L,00H
        JR	J4D09

;	  Subroutine H.INLI handler
;	     Inputs  ________________________
;	     Outputs ________________________

A4CF5:	EI
        NOP
        CALL	C4504			; replace return address with quit routine
        CALL	C4099			; get my SLTWRK entry
        XOR	A
        LD	(DECCNT),A
J4D01:	LD	HL,(CSRY)
        DEC	L
        CALL	NZ,C4C6D
        INC	L
J4D09:	LD	(FSTPOS),HL
        XOR	A
        LD	(INTFLG),A
J4D10:	CALL	C4D28
        LD	HL,T4E0E-2
        LD	C,0EH	; 14
        CALL	C47BD
        PUSH	AF
        CALL	NZ,C4D3B
        POP	AF
        JR	NC,J4D10
        LD	HL,BUFMIN
        RET	Z
        CCF
        RET

;	  Subroutine __________________________
;	     Inputs  ________________________
;	     Outputs ________________________

C4D28:	LD	A,(SCRMOD)
        PUSH	AF
        XOR	A
        LD	(SCRMOD),A
        CALL	C453D
        POP	BC
        PUSH	AF
        LD	A,B
        LD	(SCRMOD),A
        POP	AF
        RET

;	  Subroutine __________________________
;	     Inputs  ________________________
;	     Outputs ________________________

C4D3B:	PUSH	AF
        CP	09H	; 9
        JR	NZ,J4D4F
        POP	AF
J4D41:	LD	A,20H	; " "
        CALL	C4D3B
        LD	A,(CSRX)
        DEC	A
        AND	07H	; 7
        JR	NZ,J4D41
        RET

J4D4F:	POP	AF
        LD	HL,INSFLG
        CP	20H	; " "
        JP	C,J4DFB
        INC	(HL)
        DEC	(HL)
        JR	Z,J4D8F
        CALL	C4908			; double byte header character ?
        JR	C,J4D7E			; nope,
        PUSH	AF
        CALL	C4D28
        PUSH	AF
        CALL	C48DA
        DEC	A
        JR	NZ,J4D71
        LD	A,1DH
        CALL	C473A			; character to kanji screen
J4D71:	CALL	C4EF5
        POP	HL
        EX	(SP),HL
        LD	A,H
        CALL	C473A			; character to kanji screen
        POP	AF
        JP	C473A			; character to kanji screen

J4D7E:	PUSH	AF
        CALL	C48DA
        DEC	A
        LD	A,1DH
        CALL	Z,C473A			; character to kanji screen
        CALL	C4F0E
        POP	AF
        JP	C473A			; character to kanji screen

J4D8F:	CALL	C4908			; double byte header character ?
        JR	C,J4DD9			; nope,
        PUSH	AF
        CALL	C4D28
        POP	DE
        LD	E,A
        LD	HL,(CSRY)
        LD	A,(LINLEN)
        INC	H
        INC	A
        CP	H
        JR	NZ,J4DAE
        CALL	C4C76
        CP	L
        JR	Z,C4DC3
        INC	L
        LD	H,02H	; 2
J4DAE:	CALL	C48DD
        CP	02H	; 2
        PUSH	AF
        CALL	C4DC3
        POP	AF
        RET	NZ
        LD	A,20H	; " "
        CALL	C473A			; character to kanji screen
        LD	A,1DH
        JP	C473A			; character to kanji screen

;	  Subroutine __________________________
;	     Inputs  ________________________
;	     Outputs ________________________

C4DC3:	CALL	C48DA
        DEC	A
        LD	A,1DH
        CALL	Z,C473A			; character to kanji screen
        LD	A,20H	; " "
        CALL	Z,C473A			; character to kanji screen
        LD	A,D
        CALL	C473A			; character to kanji screen
        LD	A,E
        JP	C473A			; character to kanji screen

J4DD9:	LD	D,A
        CALL	C48DA
        PUSH	AF
        DEC	A
        LD	A,1DH
        CALL	Z,C473A			; character to kanji screen
        LD	A,20H	; " "
        CALL	Z,C473A			; character to kanji screen
        LD	A,D
        CALL	C473A			; character to kanji screen
        POP	AF
        CP	02H	; 2
        RET	NZ
        LD	A,20H	; " "
        CALL	C473A			; character to kanji screen
        LD	A,1DH
        JP	C473A			; character to kanji screen

J4DFB:	LD	(HL),00H
        CALL	C473A			; character to kanji screen
        DEFB	03EH
J4E01:	DEFB	03EH

;	  Subroutine __________________________
;	     Inputs  ________________________
;	     Outputs ________________________

C4E02:	XOR	A
        PUSH	AF
        CALL	C489D
        POP	AF
        LD	(CSTYLE),A
        JP	C4885

T4E0E:	DEFB    8
        DEFW    C4FC9
        DEFB    18
        DEFW    C4EE8
        DEFB    27
        DEFW    WRPRIM+6
        DEFB    2
        DEFW    C5130
        DEFB    6
        DEFW    C511A
        DEFB    14
        DEFW    C50F9
        DEFB    5
        DEFW    C50D0
        DEFB    3
        DEFW    C4EB4
        DEFB    13
        DEFW    C4E38
        DEFB    21
        DEFW    C50C5
        DEFB    127
        DEFW    C4FF6
        DEFB    29
        DEFW    C51B6
        DEFB    30
        DEFW    C524A
        DEFB    31
        DEFW    C51BF

C4E38:  CALL	C51A2
        LD	A,(AUTFLG)
        AND	A
        JR	Z,J4E43
        LD	H,01H	; 1
J4E43:	PUSH	HL
        CALL	C489D
        POP	HL
        LD	DE,BUF
        LD	B,0FEH
        DEC	L
J4E4E:	INC	L
J4E4F:	PUSH	BC
        CALL	C4C80
        POP	BC
        AND	A
        JR	Z,J4E66
        CP	0FFH
        JR	Z,J4E66
        CP	20H	; " "
        JR	NC,J4E61
        ADD	A,40H	; "@"
J4E61:	LD	(DE),A
        INC	DE
        DEC	B
        JR	Z,J4E76
J4E66:	INC	H
        LD	A,(LINLEN)
        CP	H
J4E6B:	JR	NC,J4E4F
        PUSH	DE
        CALL	C4C61
        POP	DE
        LD	H,01H	; 1
        JR	Z,J4E4E
J4E76:	DEC	DE
J4E77:	LD	A,(DE)
        CP	20H	; " "
        JR	Z,J4E76
        PUSH	HL
        PUSH	DE
        CALL	C4885
        POP	DE
        POP	HL
        INC	DE
        XOR	A
        LD	(DE),A
J4E86:	LD	A,0DH	; 13
        AND	A
J4E89:	PUSH	AF
        CALL	C4C6D
        CALL	C4E9D
        LD	A,0AH	; 10
        CALL	C473A			; character to kanji screen
        XOR	A
        LD	(INSFLG),A
        POP	AF
        SCF
        POP	HL
        RET

;	  Subroutine __________________________
;	     Inputs  ________________________
;	     Outputs ________________________

C4E9D:	LD	A,1BH
        CALL	C473A			; character to kanji screen
        LD	A,"Y"
        CALL	C473A			; character to kanji screen
        LD	A,L
        ADD	A,1FH
        CALL	C473A			; character to kanji screen
        LD	A,H
        ADD	A,1FH
        JP	C473A			; character to kanji screen

J4EB3:	INC	L
C4EB4:  CALL	C4C61
        JR	Z,J4EB3
        CALL	C4E02
        XOR	A
        LD	(BUF),A
        LD	H,01H	; 1
        PUSH	HL
        CALL	GICINI
        CALL	C4ED4
        POP	HL
        JR	C,J4E86
        LD	A,(BASROM)
        AND	A
        JR	NZ,J4E86
        JR	J4E89

;	  Subroutine __________________________
;	     Inputs  ________________________
;	     Outputs ________________________

C4ED4:	LD	A,(TRPTBL+3*10+0)
        RRCA
        RET	NC
        LD	HL,(TRPTBL+3*10+1)
        LD	A,H
        OR	L
        RET	Z
        LD	HL,(CURLIN)
        INC	HL
        LD	A,H
        OR	L
        RET	Z
        SCF
        RET

C4EE8:	LD	HL,INSFLG
        LD	A,(HL)
        XOR	0FFH
        LD	(HL),A
        JP	Z,C4E02
        JP	J4E01

;	  Subroutine __________________________
;	     Inputs  ________________________
;	     Outputs ________________________

C4EF5:	CALL	C489D
        CALL	C4F95
        LD	C,20H	; " "
        CALL	C4F9F
        LD	A,(CSRX)
        LD	HL,LINLEN
        CP	(HL)
        LD	C,20H	; " "
        CALL	Z,C4F9F
        JR	J4F14

;	  Subroutine __________________________
;	     Inputs  ________________________
;	     Outputs ________________________

C4F0E:	CALL	C489D
        CALL	C4F95
J4F14:	LD	C,20H	; " "
        CALL	C4F9F
        LD	HL,(CSRY)
J4F1C:	PUSH	HL
        AND	A
        PUSH	AF
J4F1F:	CALL	C4C80
        CALL	C4F9F
        CALL	C4FC2
        POP	AF
        LD	A,C
        CALL	NC,C4908		; double byte header character ?
        JR	C,J4F38
        LD	A,(LINLEN)
        CP	H
        LD	C,0FFH
        JR	Z,J4F3B
        AND	A
J4F38:	CALL	C4FB1
J4F3B:	CCF
        PUSH	AF
        CALL	C4C9B
        LD	A,(LINLEN)
        INC	H
        CP	H
        JR	NC,J4F1F
        POP	AF
        LD	HL,(BUF+2)
        LD	A,(BUF+0)
        CP	L
        POP	HL
        JP	Z,C4885
        CALL	C4C61
        JR	Z,J4F90
        CALL	C4FC2
        LD	A,C
        CP	20H	; " "
        PUSH	AF
        JR	NZ,J4F6B
        LD	A,(LINLEN)
        CP	H
        JR	Z,J4F6B
        POP	AF
        JP	C4885

J4F6B:	CALL	C4C6E
        INC	L
        PUSH	HL
        CALL	C4C76
        CP	L
        JR	C,J4F7B
        CALL	C49B5
        JR	J4F8A

J4F7B:	LD	HL,CSRY
        DEC	(HL)
        JR	NZ,J4F82
        INC	(HL)
J4F82:	LD	L,01H	; 1
        CALL	C497B
        POP	HL
        DEC	L
        PUSH	HL
J4F8A:	POP	HL
        POP	AF
        JP	Z,C4885
        DEC	L
J4F90:	INC	L
        LD	H,01H	; 1
        JR	J4F1C

;	  Subroutine __________________________
;	     Inputs  ________________________
;	     Outputs ________________________

C4F95:	LD	HL,BUF+162
        LD	(BUF+0),HL
        LD	(BUF+2),HL
        RET

;	  Subroutine __________________________
;	     Inputs  ________________________
;	     Outputs ________________________

C4F9F:	LD	A,C
        INC	A
        RET	Z
        PUSH	HL
        LD	HL,(BUF+0)
        LD	(HL),C
        INC	HL
        LD	A,L
        AND	1FH
        LD	L,A
        LD	(BUF+0),HL
        POP	HL
        RET

;	  Subroutine __________________________
;	     Inputs  ________________________
;	     Outputs ________________________

C4FB1:	PUSH	HL
        PUSH	AF
        LD	HL,(BUF+2)
        LD	C,(HL)
        INC	HL
        LD	A,L
        AND	1FH
        LD	L,A
        LD	(BUF+2),HL
        POP	AF
        POP	HL
        RET

;	  Subroutine __________________________
;	     Inputs  ________________________
;	     Outputs ________________________

C4FC2:	PUSH	HL
        LD	HL,(BUF+2)
        LD	C,(HL)
        POP	HL
        RET

C4FC9:	CALL	C489D
        CALL	C48DA
        LD	HL,(CSRY)
        DEC	A
        JR	NZ,J4FD6
        DEC	H
J4FD6:	DEC	L
        DEC	H
        JR	NZ,J4FF0
        INC	H
        LD	A,L
        AND	A
        JR	Z,J4FF0
        CALL	C4C61
        JR	NZ,J4FF0
        LD	A,(LINLEN)
        LD	H,A
        CALL	C4C80
        INC	A
        JR	NZ,J4FEF
        DEC	H
J4FEF:	DEC	L
J4FF0:	INC	L
        LD	(CSRY),HL
        JR	J4FF9

C4FF6:	CALL	C489D
J4FF9:	LD	HL,(CSRY)
        CALL	C4C80
        INC	A
        JR	NZ,J5008
        LD	H,01H	; 1
        INC	L
        LD	(CSRY),HL
J5008:	CALL	C48DA
        LD	HL,(CSRY)
        CP	01H	; 1
        JR	NZ,J5016
        DEC	H
        LD	(CSRY),HL
J5016:	AND	A
        LD	D,01H	; 1
        JR	Z,J504C
        INC	D
        LD	A,H
        DEC	A
        JR	NZ,J504C
        LD	A,L
        DEC	A
        JR	Z,J504C
        PUSH	HL
        DEC	L
        LD	A,(LINLEN)
        LD	H,A
        CALL	C4C80
        INC	A
        POP	HL
        JR	NZ,J504C
        LD	H,03H	; 3
        PUSH	HL
        CALL	C48DD
        POP	HL
        LD	H,01H	; 1
        AND	A
        JR	NZ,J504C
        DEC	L
        LD	A,(LINLEN)
        LD	H,A
        LD	(CSRY),HL
        DEC	D
        PUSH	HL
        INC	L
        LD	H,03H	; 3
        JR	J5079

J504C:	LD	E,00H
J504E:	ADD	HL,DE
        LD	A,(LINLEN)
        CP	H
        JR	C,J5061
        CALL	C4C80
        LD	A,H
        SUB	D
        LD	H,A
        CALL	C4C9B
        INC	H
        JR	J504E

J5061:	PUSH	DE
        CALL	C4C61
        POP	DE
        JR	NZ,J50BC
        LD	A,C
        ADD	A,01H	; 1
        LD	A,D
        ADC	A,00H
        LD	D,A
        LD	A,(LINLEN)
        SUB	D
        INC	A
        LD	H,A
        PUSH	HL
        INC	L
        LD	H,01H	; 1
J5079:	CALL	C4C80
        CALL	C4908			; double byte header character ?
        LD	A,2
        SBC	A,0
        CP	D
        JR	Z,J5088
        JR	NC,J50AC
J5088:	LD	E,A
        NEG
        ADD	A,D
        LD	D,A
        DEC	E
        JR	Z,J509A
        INC	H
        EX	(SP),HL
        CALL	C4C9B
        INC	H
        EX	(SP),HL
        CALL	C4C80
J509A:	INC	H
        EX	(SP),HL
        CALL	C4C9B
        INC	H
        EX	(SP),HL
        LD	A,D
        AND	A
        JR	NZ,J5079
        POP	AF
        LD	D,H
        DEC	D
        LD	H,01H	; 1
        JR	J504C

J50AC:	EX	(SP),HL
        LD	C,0FFH
        CALL	C4C9B
        POP	HL
        LD	D,H
        DEC	D
        LD	H,01H	; 1
        JR	NZ,J504C
        JP	C4885

J50BC:	LD	A,H
        SUB	D
        LD	H,A
        CALL	C49FB
        JP	C4885

C50C5:	CALL	C489D
        CALL	C51A2
        LD	(CSRY),HL
        JR	J50E0

C50D0:	CALL	C489D
        CALL	C48DA
        DEC	A
        LD	HL,(CSRY)
        JR	NZ,J50E0
        DEC	H
        LD	(CSRY),HL
J50E0:	CALL	C4C61
        PUSH	AF
        CALL	C49FB
        POP	AF
        JR	NZ,J50EF
        LD	H,01H	; 1
        INC	L
        JR	J50E0

J50EF:	CALL	C4885
        XOR	A
        LD	(INSFLG),A
        JP	C4E02

C50F9:	CALL	C489D
        LD	HL,(CSRY)
        DEC	L
J5100:	INC	L
        CALL	C4C61
        JR	Z,J5100
        LD	A,(LINLEN)
        LD	H,A
        INC	H
J510B:	DEC	H
        JR	Z,J5115
        CALL	C4C80
        CP	20H	; " "
        JR	Z,J510B
J5115:	CALL	C494E
        JR	J50EF

C511A:	CALL	C489D
        CALL	C5160
J5120:	CALL	C5146
        JR	Z,J50EF
        JR	C,J5120
J5127:	CALL	C5146
        JR	Z,J50EF
        JR	NC,J5127
        JR	J50EF

C5130:	CALL	C489D
J5133:	CALL	C5160
        JR	Z,J50EF
        JR	NC,J5133
J513A:	CALL	C5160
        JR	Z,J50EF
        JR	C,J513A
        CALL	C494E
        JR	J50EF

;	  Subroutine __________________________
;	     Inputs  ________________________
;	     Outputs ________________________

C5146:	LD	HL,(CSRY)
        CALL	C494E
        CALL	C48DA
        DEC	A
        LD	HL,(CSRY)
        CALL	Z,C494E
        CALL	C4C76
        LD	E,A
        LD	A,(LINLEN)
        LD	D,A
        JR	J5173

;	  Subroutine __________________________
;	     Inputs  ________________________
;	     Outputs ________________________

C5160:	LD	HL,(CSRY)
        CALL	C492B
        CALL	C48DA
        DEC	A
        LD	HL,(CSRY)
        CALL	Z,C492B
        LD	DE,0101H
J5173:	LD	HL,(CSRY)
        RST	20H
        RET	Z
        LD	DE,I519E
        PUSH	DE
        CALL	C4C80
        CP	30H	; "0"
        CCF
        RET	NC
        CP	3AH	; ":"
        RET	C
        CP	41H	; "A"
        CCF
        RET	NC
        CP	5BH	; "["
        RET	C
        CP	61H	; "a"
        CCF
        RET	NC
        CP	7BH	; "{"
        RET	C
        CP	81H
        CCF
        RET	NC
        CP	0A0H
        RET	C
        CP	0A6H
        CCF
I519E:	LD	A,00H
        INC	A
        RET

;	  Subroutine __________________________
;	     Inputs  ________________________
;	     Outputs ________________________

C51A2:	DEC	L
        JR	Z,J51AA
        CALL	C4C61
        JR	Z,C51A2
J51AA:	INC	L
        LD	A,(FSTPOS)
        CP	L
        LD	H,01H	; 1
        RET	NZ
        LD	HL,(FSTPOS)
        RET

C51B6:	CALL	C489D
        CALL	C493E
        JP	J50EF

C51BF:	CALL	C489D
        CALL	C51C8
        JP	J50EF

;	  Subroutine __________________________
;	     Inputs  ________________________
;	     Outputs ________________________

C51C8:	CALL	C5370
        JP	NC,C4954
        CALL	C4C76
        LD	HL,(CSRY)
        CP	L
        JP	NZ,C4954
J51D8:	LD	A,L
        DEC	A
        JR	Z,J51E3
        DEC	L
        CALL	C4C61
        JR	Z,J51D8
        INC	L
J51E3:	CALL	C52F9
        JR	C,J51EE
        DEC	L
        JR	NZ,J51D8
        LD	DE,0FFFFH
J51EE:	INC	DE
        LD	BC,(TXTTAB)
J51F3:	LD	L,C
        LD	H,B
        LD	C,(HL)
        INC	HL
        LD	B,(HL)
        LD	A,C
        OR	B
        RET	Z
        INC	HL
        LD	A,(HL)
        SUB	E
        INC	HL
        LD	A,(HL)
        SBC	A,D
        JR	C,J51F3
        DEC	HL
        CALL	C52C6
        LD	HL,(CSRY)
        PUSH	HL
        CALL	C4C76
        CP	B
        JR	C,J5222
        JR	Z,J5222
        LD	L,B
J5214:	CALL	C4C61
        JR	NZ,J5222
        PUSH	HL
        LD	L,01H	; 1
	CALL	C4978
        POP	HL
        JR	J5214

J5222:	LD	L,01H	; 1
        CALL	C4978
        POP	HL
        PUSH	HL
        LD	H,01H	; 1
        LD	(CSRY),HL
        CALL	C5236
        POP	HL
        LD	(CSRY),HL
        RET

;	  Subroutine __________________________
;	     Inputs  ________________________
;	     Outputs ________________________

C5236:	LD	HL,SWPTMP
        CALL	C523F
        LD	HL,BUF
;	  Subroutine __________________________
;	     Inputs  ________________________
;	     Outputs ________________________

C523F:	LD	A,(HL)
        AND	A
        RET	Z
        PUSH	HL
        CALL	C4769
        POP	HL
        INC	HL
        JR	C523F

C524A:	CALL	C489D
        CALL	C5253
        JP	J50EF

;	  Subroutine __________________________
;	     Inputs  ________________________
;	     Outputs ________________________

C5253:	CALL	C5370
        JP	NC,C494A
        LD	A,(CSRY)
        DEC	A
        JP	NZ,C494A
        LD	L,00H
J5262:	INC	L
        CALL	C52F9
        JR	C,J5279
J5268:	CALL	C4C76
        CP	L
        JR	Z,J5276
        CALL	C4C61
        JR	NZ,J5262
        INC	L
        JR	J5268

J5276:	LD	DE,0FFFFH
J5279:	LD	BC,0
        LD	HL,(TXTTAB)
J527F:	LD	A,(HL)
        INC	HL
        OR	(HL)
        JR	Z,J5296
	INC	HL
        LD	A,(HL)
        SUB	E
        INC	HL
        LD	A,(HL)
        SBC	A,D
        JR	NC,J5296
        DEC	HL
        LD	C,L
        LD	B,H
        DEC	HL
        LD	A,(HL)
        DEC	HL
        LD	L,(HL)
        LD	H,A
        JR	J527F

J5296:	LD	A,C
        OR	B
        RET	Z
        LD	L,C
        LD	H,B
        CALL	C52C6
        CALL	C4C76
        SUB	B
        JR	Z,J52B0
        JR	C,J52B0
        LD	L,A
J52A7:	CALL	C4C61
        JR	NZ,J52B0
        INC	B
        DEC	L
        JR	NZ,J52A7
J52B0:	LD	HL,(CSRY)
        PUSH	HL
        CALL	C4972
J52B7:	PUSH	BC
        CALL	C49B2
        POP	BC
        DJNZ	J52B7
        CALL	C5236
        POP	HL
        LD	(CSRY),HL
        RET

;	  Subroutine __________________________
;	     Inputs  ________________________
;	     Outputs ________________________

C52C6:	LD	E,(HL)
        INC	HL
        LD	D,(HL)
        INC	HL
        PUSH	HL
        EX	DE,HL
        CALL	C5334
        POP	HL
        PUSH	IX
        LD	IX,M5284
        CALL	CALBAS			; decode BASIC line
        POP	IX
        LD      HL,SWPTMP-1
        LD	C,0FEH
        XOR	A
J52E1:	INC	HL
        INC	C
        CP	(HL)
        JR	NZ,J52E1
        LD	HL,BUFMIN
J52E9:	INC	HL
        INC	C
        CP	(HL)
        JR	NZ,J52E9
        LD	B,A
        LD	A,(LINLEN)
        LD	E,A
        LD	A,C
J52F4:	INC	B
        SUB	E
        JR	NC,J52F4
        RET

;	  Subroutine __________________________
;	     Inputs  ________________________
;	     Outputs ________________________

C52F9:	LD	H,01H	; 1
        LD	A,(LINLEN)
        LD	B,A
J52FF:	CALL	C4C80
        CP	20H	; " "
        JR	NZ,J530A
        INC	H
        DJNZ	J52FF
        RET

J530A:	SUB	30H	; "0"
        CCF
        RET	NC
        CP	0AH	; 10
        RET	NC
        LD	DE,0
J5314:	CALL	C4C80
        CP	20H	; " "
        JR	Z,J532F
        SUB	30H	; "0"
        RET	C
        CP	0AH	; 10
        CCF
        RET	C
        PUSH	HL
        LD	L,E
        LD	H,D
        ADD	HL,HL
        ADD	HL,HL
        ADD	HL,DE
        ADD	HL,HL
        LD	E,A
        LD	D,00H
        ADD	HL,DE
        EX	DE,HL
        POP	HL
J532F:	INC	H
        DJNZ	J5314
        SCF
        RET

;	  Subroutine __________________________
;	     Inputs  ________________________
;	     Outputs ________________________

C5334:	LD	DE,SWPTMP
        XOR	A
        LD	BC,0D8F0H
        CALL	C535C
        LD	BC,0FC18H
        CALL	C535C
        LD	BC,0FF9CH
        CALL	C535C
        LD	BC,0FFF6H
        CALL	C535C
        LD	A,L
        OR	30H	; "0"
        LD	(DE),A
        INC	DE
        LD	A,20H	; " "
        LD	(DE),A
        INC	DE
        XOR	A
        LD	(DE),A
        RET

;	  Subroutine __________________________
;	     Inputs  ________________________
;	     Outputs ________________________

C535C:	PUSH	AF
        LD	A,0FFH
J535F:	INC	A
        ADD	HL,BC
        JR	C,J535F
        SBC	HL,BC
        POP	BC
        INC	B
        DJNZ	J536B
        AND	A
        RET	Z
J536B:	OR	30H	; "0"
        LD	(DE),A
        INC	DE
        RET

;	  Subroutine __________________________
;	     Inputs  ________________________
;	     Outputs ________________________

C5370:	LD	A,(NORUSE)
        AND	40H	; "@"
        RET	Z
        LD	A,(DECCNT)
        AND	A
        RET	Z
        LD	A,(NEWKEY+6)
        RRCA
        CCF
        RET

;	  Subroutine H.TIMI handler (vdp interrupt)
;	     Inputs  ________________________
;	     Outputs ________________________

I5381:	EI
        PUSH	AF
        LD	A,(H.TOTE+0)
        CP	0C9H			; kanji mode enabled ?
        JR	Z,J5391			; nope, use orginal keyboard handler
        CALL	C53A5			; keyboard handler
        LD	HL,SCNCNT
        INC	(HL)			; make sure orginal keyboard handler does nothing
J5391:	LD	A,(SLTWRK+4)
        CP	0C9H			; need to pass control to a other H.TIMI handler ?
        JR	Z,J53A3			; nope, quit
        PUSH	AF
        POP	IY
        LD	IX,(SLTWRK+5)
        POP	AF
        JP	CALSLT			; pass control to a other H.TIMI handler

J53A3:	POP	AF
        RET

;	  Subroutine keyboard handler
;	     Inputs  ________________________
;	     Outputs ________________________

C53A5:	LD	HL,SCNCNT
        DEC	(HL)
        RET	NZ
        LD	(HL),2
        LD	HL,TRPTBL+12*3+0
        LD	A,(HL)
        LD	HL,TRPTBL+13*3+0
        OR	(HL)
        LD	HL,TRPTBL+14*3+0
        OR	(HL)
        LD	HL,TRPTBL+15*3+0
        OR	(HL)
        LD	HL,TRPTBL+16*3+0
        OR	(HL)
        RRCA
        JR	NC,J540C
        XOR	A
        CALL	C57C8
        AND	30H	; "0"
        PUSH	AF
        LD	A,01H	; 1
        CALL	C57C8
        AND	30H	; "0"
        RLCA
        RLCA
        POP	BC
        OR	B
        PUSH	AF
        CALL	C577A
        AND	01H	; 1
        POP	BC
        OR	B
        LD	C,A
        LD	HL,TRGFLG
        XOR	(HL)
        AND	(HL)
        LD	(HL),C
        LD	C,A
        RRCA
        LD	HL,TRPTBL+12*3+0
        CALL	C,C560B
        RL	C
        LD	HL,TRPTBL+16*3+0
        CALL	C,C560B
        RL	C
        LD	HL,TRPTBL+14*3+0
        CALL	C,C560B
        RL	C
        LD	HL,TRPTBL+15*3+0
        CALL	C,C560B
        RL	C
        LD	HL,TRPTBL+13*3+0
        CALL	C,C560B
J540C:	XOR	A
        LD	(CLIKFL),A
        CALL	C542B
        RET	NZ
        LD	HL,REPCNT
        DEC	(HL)
        RET	NZ
        LD	(HL),01H	; 1
        LD	HL,OLDKEY+0
        LD	DE,OLDKEY+1
        LD	BC,11-1
        LD	(HL),0FFH
        LDIR
        JP	J5467

;	  Subroutine __________________________
;	     Inputs  ________________________
;	     Outputs ________________________

C542B:	IN	A,(0AAH)
        AND	0F0H
        LD	C,A
        LD	B,0BH	; 11
        LD	HL,NEWKEY
J5435:	LD	A,C
        OUT	(0AAH),A
        IN	A,(0A9H)
        LD	(HL),A
        INC	C
        INC	HL
        DJNZ	J5435
        LD	A,(ENSTOP)
        AND	A
        JR	Z,J5453
        LD	A,(NEWKEY+6)
        CP	0E8H
        JR	NZ,J5453
        LD	IX,M409B
        JP	CALBAS			; warm start MSX BASIC

J5453:	LD	DE,OLDKEY+11
        LD	B,11
J5458:	DEC	DE
        DEC	HL
        LD	A,(DE)
        CP	(HL)
        JR	NZ,J5462
        DJNZ	J5458
        JR	J5467

J5462:	LD	A,14H	; 20
        LD	(REPCNT),A
J5467:	LD	B,0BH	; 11
        LD	HL,OLDKEY
        LD	DE,NEWKEY
J546F:	LD	A,(DE)
        LD	C,A
        XOR	(HL)
        AND	(HL)
        LD	(HL),C
        CALL	NZ,C5483
        INC	DE
        INC	HL
        DJNZ	J546F
        LD	HL,(GETPNT)
        LD	A,(PUTPNT)
        SUB	L
        RET

;	  Subroutine __________________________
;	     Inputs  ________________________
;	     Outputs ________________________

C5483:	PUSH	HL
        PUSH	DE
        PUSH	BC
        PUSH	AF
        LD	A,0BH	; 11
        SUB	B
        ADD	A,A
        ADD	A,A
        ADD	A,A
        LD	C,A
        LD	B,08H	; 8
        POP	AF
J5491:	RRA
        PUSH	BC
        PUSH	AF
        CALL	C,C5536
        POP	AF
        POP	BC
        INC	C
        DJNZ	J5491
        POP	BC
        POP	DE
        POP	HL
        RET

I54A0:	DEFB    00AH
        DEFW    C5560
        DEFB    016H
        DEFW    C559A
        DEFB    030H
        DEFW    C5577
        DEFB    033H
        DEFW    C562A
        DEFB    034H
        DEFW    C5639
        DEFB    035H
        DEFW    C5787
        DEFB    03AH
        DEFW    C55B4
        DEFB    03CH
        DEFW    C562A
        DEFB    03DH
        DEFW    C5649
        DEFB    041H
        DEFW    C562A
        DEFB    042H
        DEFW    C5620
        DEFB    0FFH
        DEFW    C562A

I54C4:  DEFB    0FFH
        DEFB    "!",022H,"#$%&'()"

I54CE:  DEFW    C5658
        DEFW    C5658
        DEFW    C558C
        DEFW    C558E

I54D6:  DEFW    I5502-00AH
        DEFW    I54F6-00AH
        DEFW    I54EA-00AH
        DEFW    I54DE-00AH

;	Table		keycodes for keys -,^,yen,@,[,;,:,],komma,.,/,_

I54DE:  DEFB    "-^\@[;:],./",0FFH

;	Table		keycodes for keys -,^,yen,@,[,;,:,],komma,.,/,_ +SHIFT

I54EA:  DEFB    "=~|`{+*}<>?_"

;	Table		keycodes for keys -,^,yen,@,[,;,:,],komma,.,/,_ +CTRL

I54F6:  DEFB    "-",01EH,01CH,0,01BH,";:",01DH,",./",0FFH

;	Table		keycodes for keys -,^,yen,@,[,;,:,],komma,.,/,_ +CTRL+SHIFT

I5502:  DEFB    "=",01EH,01CH,0,01BH,"+*",01DH,"<>?",01FH

I550E:  DEFB	0,0,0,0,0,0,0,0
        DEFB	0,0,01BH,009H,0,008H,018H,00DH
        DEFB	" ",00CH,012H,07FH,01DH,01EH,01FH,01CH
        DEFB    "+/*0123456789-,."

C5536:  LD      A,C
        CP	0FFH
        RET	Z
        LD	HL,I54A0
        CALL	H.KEYC
        CP	30H	; "0"
        JR	NC,J5555
        LD	A,(NEWKEY+6)
        RRCA
        RRCA
        JR	NC,J5554
        RRCA
        RET	NC
        LD	A,(KANAST)
        AND	A
        JP	NZ,J5685
J5554:	LD	A,C
J5555:	CP	(HL)
        INC	HL
        LD	E,(HL)
        INC	HL
        LD	D,(HL)
        INC	HL
        PUSH	DE
J555C:	RET	C
        POP	DE
        JR	J5555

C5560:	ADD	A,30H	; "0"
        LD	B,A
        LD	A,(NEWKEY+6)
        RRCA
        LD	A,B
        JR	C,J5574
        LD	B,00H
J556C:	LD	HL,I54C4
        ADD	HL,BC
        LD	A,(HL)
        CP	0FFH
        RET	Z
J5574:	JP	C5658

C5577:	LD	A,(NEWKEY+6)
        AND	03H	; 3
        ADD	A,A
        LD	E,A
        LD	D,00H
        LD	HL,I54CE
        ADD	HL,DE
        LD	A,(HL)
        INC	HL
        LD	H,(HL)
        LD	L,A
        LD	A,C
        SUB	15H
        JP	(HL)

C558C:	ADD	A,20H	; " "
C558E:  LD	B,A
        LD	A,(CAPST)
        CPL
        AND	20H	; " "
        XOR	B
        ADD	A,40H	; "@"
        JR	J5574

C559A:	LD	HL,I54D6
        LD	A,(NEWKEY+6)
        AND	03H	; 3
        ADD	A,A
        LD	E,A
        LD	D,00H
        ADD	HL,DE
        LD	A,(HL)
        INC	HL
        LD	H,(HL)
        LD	L,A
        LD	E,C
        ADD	HL,DE
        LD	A,(HL)
        CP	0FFH
        JP	NZ,C5658
        RET

C55B4:	LD	A,(NEWKEY+6)
        RRCA
        JR	C,J55BE
        LD	A,C
        ADD	A,05H	; 5
        LD	C,A
J55BE:	LD	E,C
        LD	D,00H
        LD	HL,FNKFLG-035H
        ADD	HL,DE
        LD	A,(HL)
        AND	A
        JR	NZ,J55FD
J55C9:	EX	DE,HL
        ADD	HL,HL
        ADD	HL,HL
        ADD	HL,HL
        ADD	HL,HL
        LD	DE,FNKSTR-035H*16
        ADD	HL,DE
        EX	DE,HL
        DEC	DE
J55D4:	INC	DE
J55D5:	LD	A,(DE)
        INC	DE
        AND	A
        RET	Z
        CALL	C4908			; double byte header character ?
        JR	C,J55F4			; nope,
        LD	B,A
        LD	A,(DE)
        AND	A
        RET	Z
        CALL	C4916
        JR	C,J55D4
        LD	A,(NORUSE)
        BIT	5,A
        JR	NZ,J55D4
        LD	A,B
        CALL	C55F9
        LD	A,(DE)
        INC	DE
J55F4:	CALL	C55F9
        JR	J55D5

;	  Subroutine __________________________
;	     Inputs  ________________________
;	     Outputs ________________________

C55F9:	CALL	C5658
I55FC:	RET

J55FD:	LD	HL,(CURLIN)
        INC	HL
        LD	A,H
        OR	L
        JR	Z,J55C9
        LD	HL,TRPTBL-035H*3
        ADD	HL,DE
        ADD	HL,DE
        ADD	HL,DE
;	  Subroutine __________________________
;	     Inputs  ________________________
;	     Outputs ________________________

C560B:	LD	A,(HL)
        AND	01H	; 1
        RET	Z
        LD	A,(HL)
        OR	04H	; 4
        CP	(HL)
        RET	Z
        LD	(HL),A
        XOR	05H	; 5
        RET	NZ
        LD	A,(ONGSBF)
        INC	A
        LD	(ONGSBF),A
        RET

C5620:	LD	A,(NEWKEY+6)
        RRCA
        LD	A,0CH	; 12
        SBC	A,00H
        JR	C5658

C562A:	CALL	H.KEYA
        LD	E,A
        LD	D,00H
        LD	HL,I550E-030H
        ADD	HL,DE
        LD	A,(HL)
        AND	A
        RET	Z
        JR	C5658

C5639:	LD	HL,CAPST
        LD	A,(HL)
        CPL
        LD	(HL),A
        CPL
        AND	A
        LD	A,0CH	; 12
        JR	Z,J5646
        INC	A
J5646:	OUT	(0ABH),A
        RET

C5649:	LD	A,(NEWKEY+6)
        RRCA
        RRCA
        LD	A,03H	; 3
        JR	NC,J5653
        INC	A
J5653:	LD	(INTFLG),A
        JR	C,C5666
;	  Subroutine __________________________
;	     Inputs  ________________________
;	     Outputs ________________________

C5658:	POP	HL
        PUSH	HL
        LD	BC,I55FC
        OR	A
        SBC	HL,BC
        PUSH	DE
        CALL	C57E6
        POP	DE
        RET

;	  Subroutine __________________________
;	     Inputs  ________________________
;	     Outputs ________________________

C5666:	LD	A,(CLIKSW)
        AND	A
        RET	Z
        LD	A,(CLIKFL)
        AND	A
        RET	NZ
        LD	A,0FH	; 15
        LD	(CLIKFL),A
        OUT	(0ABH),A
        LD	A,0AH	; 10
J5679:	DEC	A
        JR	NZ,J5679
        AND	A
        LD	A,0EH	; 14
        JR	Z,J5682
        INC	A
J5682:	OUT	(0ABH),A
        RET

J5685:	LD	A,(KANAMD)
        AND	A
        LD	A,(NEWKEY+6)
        RRCA
        JR	Z,J5699
        LD	HL,I571A
        JR	C,J56A1
        LD	HL,I574A
        JR	J56A1

J5699:	LD	HL,I56BA
        JR	C,J56A1
        LD	HL,I56EA
J56A1:	LD	B,00H
        ADD	HL,BC
        LD	BC,C5658
        PUSH	BC
        LD	A,(CAPST)
        AND	A
        LD	A,(HL)
        RET	NZ
        CP	0A6H
        RET	C
        CP	0B0H
        RET	Z
        CP	0DEH
        RET	NC
        XOR	20H	; " "
        RET

;	Table		ANSI layout, without SHIFT (based on CAPS on)

I56BA:	DEFB	0C9H,0B1H,0B2H,0B3H,0B4H,0B5H,0C5H,0C6H
        DEFB	0C7H,0C8H,0D7H,0D8H,0D9H,0DAH,0DBH,0D3H
        DEFB	0DEH,0DFH,0D6H,0DCH,0A6H,0DDH,0BBH,0C4H
        DEFB	0C2H,0BDH,0B8H,0BEH,0BFH,0CFH,0CCH,0D0H
        DEFB	0D1H,0D2H,0D5H,0D4H,0CDH,0CEH,0B6H,0B9H
        DEFB	0BCH,0BAH,0CBH,0C3H,0B7H,0C1H,0CAH,0C0H

;	Table		ANSI layout, with SHIFT (based on CAPS on)

I56EA:	DEFB	0C9H,0A7H,0A8H,0A9H,0AAH,0ABH,0C5H,0C6H
        DEFB	0C7H,0C8H,0D7H,0D8H,0D9H,0DAH,0A2H,0D3H
        DEFB	0B0H,0A3H,0AEH,0A4H,0A1H,0A5H,0BBH,0C4H
        DEFB	0AFH,0BDH,0B8H,0BEH,0BFH,0CFH,0CCH,0D0H
        DEFB	0D1H,0D2H,0ADH,0ACH,0CDH,0CEH,0B6H,0B9H
        DEFB	0BCH,0BAH,0CBH,0C3H,0B7H,0C1H,0CAH,0C0H

;	Table		JIS layout, without SHIFT (based on CAPS on)

I571A:	DEFB	0DCH,0C7H,0CCH,0B1H,0B3H,0B4H,0B5H,0D4H
        DEFB	0D5H,0D6H,0CEH,0CDH,0B0H,0DEH,0DFH,0DAH
        DEFB	0B9H,0D1H,0C8H,0D9H,0D2H,0DBH,0C1H,0BAH
        DEFB	0BFH,0BCH,0B2H,0CAH,0B7H,0B8H,0C6H,0CFH
        DEFB	0C9H,0D8H,0D3H,0D0H,0D7H,0BEH,0C0H,0BDH
        DEFB	0C4H,0B6H,0C5H,0CBH,0C3H,0BBH,0DDH,0C2H

;	Table		JIS layout, with SHIFT (based on CAPS on)

I574A:	DEFB	0A6H,0C7H,0CCH,0A7H,0A9H,0AAH,0ABH,0ACH
        DEFB	0ADH,0AEH,0CEH,0CDH,0B0H,0DEH,0A2H,0DAH
        DEFB	0B9H,0A3H,0A4H,0A1H,0A5H,0DBH,0C1H,0BAH
        DEFB	0BFH,0BCH,0A8H,0CAH,0B7H,0B8H,0C6H,0CFH
        DEFB	0C9H,0D8H,0D3H,0D0H,0D7H,0BEH,0C0H,0BDH
        DEFB	0C4H,0B6H,0C5H,0CBH,0C3H,0BBH,0DDH,0AFH

;	  Subroutine __________________________
;	     Inputs  ________________________
;	     Outputs ________________________

C577A:	DI
        IN	A,(0AAH)
        AND	0F0H
        ADD	A,08H	; 8
        OUT	(0AAH),A
        IN	A,(0A9H)
        EI
        RET

C5787:	LD	HL,MODE
        BIT	0,(HL)
        JR	Z,J5793
        XOR	A
        RES	0,(HL)
        JR	J57B3

J5793:	LD	A,(KANAST)
        INC	A
        JR	Z,J57B0
        LD	A,(IDBYT2)
        AND	A			; msx 1 ?
        JR	Z,J57AE			; yep,
        LD	A,(NEWKEY+6)
        RRCA
        JR	C,J57AE
        XOR	A
        LD	(CHRCNT),A
        INC	A
        SET	0,(HL)
        JR	J57B3

J57AE:	LD	A,0FFH
J57B0:	LD	(KANAST),A
J57B3:	PUSH	AF
        LD	A,0FH	; 15
        OUT	(0A0H),A
        IN	A,(0A2H)
        AND	7FH
        LD	B,A
        POP	AF
        OR	A
        LD	A,80H
        JR	Z,J57C4
        XOR	A
J57C4:	OR	B
        OUT	(0A1H),A
        RET

;	  Subroutine __________________________
;	     Inputs  ________________________
;	     Outputs ________________________

C57C8:	LD	B,A
        LD	A,0FH	; 15
        DI
        OUT	(0A0H),A
        IN	A,(0A2H)
        DJNZ	J57D8
        AND	0DFH
        OR	4CH	; "L"
        JR	J57DC

J57D8:	AND	0AFH
        OR	03H	; 3
J57DC:	OUT	(0A1H),A
        LD	A,0EH	; 14
        OUT	(0A0H),A
        IN	A,(0A2H)
        EI
        RET

;	  Subroutine __________________________
;	     Inputs  ________________________
;	     Outputs ________________________

C57E6:	PUSH	AF
        LD	A,(MODE)
        AND	01H
        JR	Z,J582F
        POP	AF
        PUSH	AF
        LD	HL,(PUTPNT)
        PUSH	HL
        LD	IX,S.PUTCHR
        CALL	EXTROM
        POP	HL
        POP	AF
        RET	Z
        LD	B,00H
        LD	DE,(PUTPNT)
        LD	(PUTPNT),HL
J5807:	LD	A,L
        CP	E
        JR	Z,J5813
        LD	A,(HL)
        PUSH	AF
        INC	B
        CALL	C585B
        JR	J5807

J5813:	LD	A,B
        AND	A
        RET	Z
        LD	E,B
        LD	L,B
        DEC	L
        LD	H,00H
        ADD	HL,HL
        ADD	HL,SP
        INC	HL
J581E:	LD	A,(HL)
        PUSH	HL
        PUSH	BC
        CALL	C5835
        POP	BC
        POP	HL
        DEC	HL
        DEC	HL
        DJNZ	J581E
        LD	B,E
J582B:	POP	AF
        DJNZ	J582B
        RET

J582F:	CALL	C5666
        POP	AF
        JR	Z,C584B
;	  Subroutine __________________________
;	     Inputs  ________________________
;	     Outputs ________________________

C5835:	LD	HL,NORUSE
        BIT	5,(HL)
        JR	NZ,C584B
;	  Subroutine __________________________
;	     Inputs  ________________________
;	     Outputs ________________________

C583C:	CALL	C75E7
        JR	C,C584B
        LD	B,24H	; "$"
        CALL	C70AB
        LD	A,B
        CALL	C584B
        LD	A,C
;	  Subroutine __________________________
;	     Inputs  ________________________
;	     Outputs ________________________

C584B:	LD	HL,(PUTPNT)
        LD	(HL),A
        CALL	C585B
        LD	A,(GETPNT)
        CP	L
        RET	Z
        LD	(PUTPNT),HL
        RET

;	  Subroutine __________________________
;	     Inputs  ________________________
;	     Outputs ________________________

C585B:	INC	HL
        LD	A,L
        CP	LOW (KEYBUF+40)
        RET	NZ
        LD	HL,KEYBUF
        RET

;	  Subroutine __________________________
;	     Inputs  ________________________
;	     Outputs ________________________

C5864:	PUSH	HL
        PUSH	DE
        PUSH	BC
        PUSH	AF
        CALL	C5870
        POP	AF
        POP	BC
        POP	DE
        POP	HL
        RET

;	  Subroutine __________________________
;	     Inputs  ________________________
;	     Outputs ________________________

C5870:	CALL	C632B
        ADD	A,H
        LD	H,A
        LD	A,(IX+2)
        LD	(IX+2),00H
        AND	A
        LD	B,A
        JP	NZ,J5A48
        LD	A,C
        CALL	C4908			; double byte header character ?
        JR	C,J58FC			; nope,
        LD	(IX+2),A
        RET

;	  Subroutine __________________________
;	     Inputs  ________________________
;	     Outputs ________________________

C588B:	LD	A,(IDBYT2)
        CP	2			; msx 2+ or above ?
        RET	C			; nope, quit
        LD	A,(RG25SA)
        AND	18H
        CP	18H
        RET	NZ
        LD	A,(MODE)
        AND	20H
        RET

;	  Subroutine __________________________
;	     Inputs  ________________________
;	     Outputs ________________________

C589F:	CALL	C588B
        RET	NZ
        POP	IY
        LD	A,(NORUSE)
        PUSH	AF
        AND	0FH	; 15
        LD	DE,(FORCLR)
        PUSH	DE
        JR	NZ,J58DB
        LD	DE,0F0FH
        LD	(FORCLR),DE
        LD	A,(NORUSE)
        AND	0F0H
        OR	01H	; 1
        LD	(NORUSE),A
        PUSH	IY
        PUSH	BC
        PUSH	HL
        CALL	C58FA
        POP	HL
        POP	BC
        POP	IY
        LD	A,(NORUSE)
        AND	0F0H
        OR	02H	; 2
        LD	(NORUSE),A
        POP	DE
        PUSH	DE
        SCF
J58DB:	PUSH	AF
        LD	A,E
        RLA
        RLA
        RLA
        RLA
        LD	E,A
        POP	AF
        LD	A,D
        RLA
        RLA
        RLA
        RLA
        LD	D,A
        LD	(FORCLR),DE
        CALL	C58FA
        POP	DE
        LD	(FORCLR),DE
        POP	AF
        LD	(NORUSE),A
        RET

;	  Subroutine __________________________
;	     Inputs  ________________________
;	     Outputs ________________________

C58FA:	JP	(IY)

J58FC:	CALL	C589F
        LD	A,C
        CP	0FFH
        JR	NZ,J5907
        LD	C,20H	; " "
        LD	A,C
J5907:	CP	20H	; " "
        JR	NZ,J5917
        LD	A,(IX+0)
        AND	07H			; b2-b0
        CP	4
        LD	A,01H	; 1
        JP	NC,J5FC9
J5917:	LD	A,(IX+0)
        AND	50H
        CP	50H			; character width 6 + Matsushita JIS-1 rom ?
        JR	NZ,J592A		; nope,
        PUSH	HL
        LD	L,C
        LD	H,00H
        CALL	C61F5			; read Matsushita JIS rom
        POP	HL
        JR	J595D

J592A:	LD	A,(IX+0)
        AND	48H			; b6, b3
        CP	08H			; character width 8 + JIS-1 rom ?
        JR	Z,J5938			; yep, use JIS-1 rom
        CALL	C628D			; read character data from default charactergenerator
        JR	J595D

J5938:	LD	A,C
        AND	A
        JP	M,J5943
        SUB	20H
        LD	B,0
        JR	J5947

J5943:	SUB	80H
        LD	B,0DH
J5947:	CP	40H
        JR	C,J594E
        SUB	40H
        INC	B
J594E:	OUT	(0D8H),A
        LD	A,B
        OUT	(0D9H),A
        PUSH	HL
        LD	HL,HOLD8+0
        LD	BC,18D9H
        INIR				; read JIS-1 rom data
        POP	HL
J595D:	LD	A,(IX+0)
        AND	07H			; b2-b0
        CP	4
        JP	C,J6364
        LD	A,(IX+0)
        ADD	A,A			; interlace mode ?
        JR	C,J59B7			; yep,
        JP	P,J5982			; non interlace + character width 8,
        PUSH	HL
        LD	L,H
        DEC	L
        LD	H,0
        LD	E,L
        LD	D,H
        ADD	HL,HL
        ADD	HL,DE
        ADD	HL,HL
        LD	(HOLD8+36),HL
        LD	HL,6
        JR	J5990

J5982:	PUSH	HL
        LD	L,H
        DEC	L
        LD	H,00H
        ADD	HL,HL
        ADD	HL,HL
        ADD	HL,HL
        LD	(HOLD8+36),HL
        LD	HL,8
J5990:	LD	(HOLD8+40),HL
        LD	A,L
        LD	(HOLD8+45),A
        POP	HL
        DEC	L
        LD	H,00H
        ADD	HL,HL
        ADD	HL,HL
        ADD	HL,HL
        ADD	HL,HL
        LD	(HOLD8+38),HL
        LD	HL,16
        LD	(HOLD8+42),HL
        LD	A,08H	; 8
        LD	(HOLD8+46),A
        LD	A,01H	; 1
        LD	(HOLD8+47),A
        LD	DE,HOLD8
        JR	C5A09

J59B7:	JP	P,J59CC
        PUSH	HL
        LD	L,H
        DEC	L
        LD	H,00H
        LD	E,L
        LD	D,H
        ADD	HL,HL
        ADD	HL,DE
        ADD	HL,HL
        LD	(HOLD8+36),HL
        LD	HL,6
        JR	J59DA

J59CC:	PUSH	HL
        LD	L,H
        DEC	L
        LD	H,00H
        ADD	HL,HL
        ADD	HL,HL
        ADD	HL,HL
        LD	(HOLD8+36),HL
        LD	HL,8
J59DA:	LD	(HOLD8+40),HL
        LD	A,L
        LD	(HOLD8+45),A
        POP	HL
        DEC	L
        LD	H,00H
        ADD	HL,HL
        ADD	HL,HL
        ADD	HL,HL
        LD	(HOLD8+38),HL
        LD	HL,8
        LD	(HOLD8+42),HL
        LD	A,04H	; 4
        LD	(HOLD8+46),A
        LD	A,02H	; 2
        LD	(HOLD8+47),A
        LD	DE,0F806H
        CALL	C5A09
        LD	HL,HOLD8+39
        SET	0,(HL)
        LD	DE,0F807H
;	  Subroutine __________________________
;	     Inputs  ________________________
;	     Outputs ________________________

C5A09:	CALL	C6140
        CALL	C5A26
        LD	A,08H	; 8
        ADD	A,L
        LD	L,A
        CALL	C5A26
J5A16:	PUSH	AF
        PUSH	BC
        DEC	C
        DEC	C
        XOR	A
        DI
        OUT	(C),A
        LD	A,0AEH
        OUT	(C),A
        EI
        POP	BC
        POP	AF
        RET

;	  Subroutine __________________________
;	     Inputs  ________________________
;	     Outputs ________________________

C5A26:	LD	A,(HOLD8+46)
J5A29:	PUSH	AF
        LD	A,(HL)
J5A2B:	RLA
        JP	NC,J5A36
        OUT	(C),E
        DJNZ	J5A2B
        JP	J5A3A

J5A36:	OUT	(C),D
        DJNZ	J5A2B
J5A3A:	LD	A,(HOLD8+45)
        LD	B,A
        LD	A,(HOLD8+47)
        ADD	A,L
        LD	L,A
        POP	AF
        DEC	A
        JR	NZ,J5A29
        RET

J5A48:	LD	A,C
        CALL	C4916
        JR	C,J5A5C
        LD	A,B
        CP	98H
        JR	NZ,J5A5F
        LD	A,C
        CP	80H
        JR	C,J5A5F
        CP	9FH
        JR	NC,J5A5F
J5A5C:	LD	BC,8140H
J5A5F:	CALL	C589F
        DEC	H
        EX	DE,HL
        LD	HL,8140H
        AND	A
        SBC	HL,BC
        EX	DE,HL
        JR	NZ,J5A79
        LD	A,(IX+0)
        AND	07H			; b2-b0
        CP	4
        LD	A,02H	; 2
        JP	NC,J5FC9
J5A79:	PUSH	HL
        LD	HL,989EH
        AND	A
        SBC	HL,BC
        POP	HL
        BIT	6,(IX+0)
        JR	Z,J5AA5			; character width 8,
        BIT	4,(IX+0)		; Matsushita JIS-1 rom ?
        JR	NC,J5A91
        BIT	6,(IX+1)		; Matsushita JIS-2 rom ?
J5A91:	JR	Z,J5AA5			; no Matsushita JIS-2 rom, try normal JIS rom
        PUSH	HL
        LD	A,B
        AND	3FH
        ADD	A,0DH
        LD	H,A
        LD	A,C
        SUB	40H
        LD	L,A
        CALL	C61F5			; read Matsushita JIS rom
        POP	HL
        JP	J5B8C

J5AA5:	BIT	3,(IX+0)		; JIS-1 rom ?
        JR	NC,J5AB0
        LD	A,(MODE)
        AND	40H			; JIS-2 rom ?
J5AB0:	JP	NZ,J5B4F		; JIS rom available, use it
        PUSH	HL
        LD	HL,8140H
        AND	A
        SBC	HL,BC
        JR	NZ,J5ACC
        LD	HL,HOLD8+0
        LD	DE,HOLD8+1
        LD	BC,32-1
        LD	(HL),0
        LDIR
        JP	J5B4C

J5ACC:	CALL	C61C2
        CP	01H	; 1
        JR	NZ,J5AEC
        LD	A,C
        ADD	A,20H	; " "
        LD	HL,T73C9+02AH-1
        LD	BC,002AH
        CPDR
        JR	NZ,J5AE7
        LD	HL,T73F3
        ADD	HL,BC
        LD	A,(HL)
        JR	J5AF3

J5AE7:	SUB	20H	; " "
        LD	C,A
        LD	A,01H	; 1
J5AEC:	CP	03H	; 3
        JR	NZ,J5AF9
        LD	A,C
        ADD	A,20H	; " "
J5AF3:	LD	HL,I5B03
        CP	A
        JR	J5B0B

J5AF9:	CP	04H	; 4
        JR	Z,J5B01
        CP	05H	; 5
        JR	NZ,J5B40
J5B01:	CP	05H	; 5
I5B03:	LD	B,00H
        LD	HL,I731B
        ADD	HL,BC
        ADD	HL,BC
        LD	A,(HL)
J5B0B:	PUSH	AF
        JR	Z,J5B10
        XOR	20H	; " "
J5B10:	LD	C,A
        CALL	C628D			; read character data from default charactergenerator
        POP	AF
        JR	Z,J5B2F
        BIT	6,(IX+0)
        JR	Z,J5B2F			; character width 8,
        INC	HL
        LD	A,(HL)
        AND	A
        DEC	HL
        JR	NZ,J5B28
        CALL	C62FE
        JR	J5B4C

J5B28:	LD	B,24
        PUSH	HL
        CALL	C61E3
        POP	HL
J5B2F:	INC	HL
        LD	A,(HL)
        AND	A
        PUSH	AF
        CALL	Z,C62B5
        POP	AF
        LD	C,A
        LD	DE,HOLD8+8
        CALL	NZ,C6290		; read character data from default charactergenerator
        JR	J5B4C

J5B40:	PUSH	BC
        LD	DE,HOLD8
        CALL	C6271
        POP	BC
        LD	A,C
        CALL	C6271
J5B4C:	POP	HL
        JR	J5B8C

J5B4F:	PUSH	HL
        CALL	C61C2
        LD	E,C
        LD	D,00H
        LD	L,A
        LD	H,D
        LD	C,L
        LD	B,H
        ADD	HL,HL
        ADD	HL,BC
        ADD	HL,HL
        ADD	HL,HL
        ADD	HL,HL
        ADD	HL,HL
        ADD	HL,HL
        ADD	HL,DE
        CP	30H	; "0"
        JR	C,J5B6E
        LD	A,H
        SUB	12H	; 18
        LD	H,A
        LD	C,0DAH
        JR	J5B76

J5B6E:	CP	10H	; 16
        JR	C,J5B74
        DEC	H
        DEC	H
J5B74:	LD	C,0D8H
J5B76:	OUT	(C),L
        ADD	HL,HL
        ADD	HL,HL
        INC	C
        OUT	(C),H
        LD	HL,HOLD8
        LD	B,20H	; " "
        INIR
        BIT	6,(IX+0)
        CALL	NZ,C61E1		; character with 6,
        POP	HL
J5B8C:	LD	A,(IX+0)
        AND	07H			; b2-b0
        CP	4
        JP	C,J635B
        LD	A,(IX+0)
        ADD	A,A
        JR	C,J5BEC			; interlace mode,
        JP	P,J5BB6			; non interlace + character width 8,
        PUSH	HL
        LD	L,H
        DEC	L
        LD	H,00H
        LD	E,L
        LD	D,H
        ADD	HL,HL
        ADD	HL,DE
        ADD	HL,HL
        LD	(HOLD8+36),HL
        LD	HL,12
        LD	(HOLD8+40),HL
        LD	A,06H	; 6
        JR	J5BC9

J5BB6:	PUSH	HL
        LD	L,H
        DEC	L
        LD	H,00H
        ADD	HL,HL
        ADD	HL,HL
        ADD	HL,HL
        LD	(HOLD8+36),HL
        LD	HL,16
        LD	(HOLD8+40),HL
        LD	A,08H	; 8
J5BC9:	LD	(HOLD8+45),A
        POP	HL
        DEC	L
        LD	H,00H
        ADD	HL,HL
        ADD	HL,HL
        ADD	HL,HL
        ADD	HL,HL
        LD	(HOLD8+38),HL
        LD	HL,16
        LD	(HOLD8+42),HL
        LD	A,08H	; 8
        LD	(HOLD8+46),A
        LD	A,0F9H
        LD	(HOLD8+47),A
        LD	DE,HOLD8
        JR	C5C44

J5BEC:	JP	P,J5C06
        PUSH	HL
        LD	L,H
        DEC	L
        LD	H,00H
        LD	E,L
        LD	D,H
        ADD	HL,HL
        ADD	HL,DE
        ADD	HL,HL
        LD	(HOLD8+36),HL
        LD	HL,12
        LD	(HOLD8+40),HL
        LD	A,06H	; 6
        JR	J5C19

J5C06:	PUSH	HL
        LD	L,H
        DEC	L
        LD	H,00H
        ADD	HL,HL
        ADD	HL,HL
        ADD	HL,HL
        LD	(HOLD8+36),HL
        LD	HL,16
        LD	(HOLD8+40),HL
        LD	A,08H	; 8
J5C19:	LD	(HOLD8+45),A
        POP	HL
        DEC	L
        LD	H,00H
        ADD	HL,HL
        ADD	HL,HL
        ADD	HL,HL
        LD	(HOLD8+38),HL
        LD	HL,8
        LD	(HOLD8+42),HL
        LD	A,04H	; 4
        LD	(HOLD8+46),A
        LD	A,0FAH
        LD	(HOLD8+47),A
        LD	DE,0F806H
        CALL	C5C44
        LD	HL,HOLD8+39
        SET	0,(HL)
        LD	DE,0F807H
;	  Subroutine __________________________
;	     Inputs  ________________________
;	     Outputs ________________________

C5C44:	CALL	C6140
        CALL	C5C54
        LD	A,08H	; 8
        ADD	A,L
        LD	L,A
        CALL	C5C54
        JP	J5A16

;	  Subroutine __________________________
;	     Inputs  ________________________
;	     Outputs ________________________

C5C54:	LD	A,(HOLD8+46)
J5C57:	PUSH	AF
        LD	A,(HL)
J5C59:	RLA
        JP	NC,J5C64
        OUT	(C),E
        DJNZ	J5C59
        JP	J5C68

J5C64:	OUT	(C),D
        DJNZ	J5C59
J5C68:	LD	A,(HOLD8+45)
        LD	B,A
        LD	A,08H	; 8
        ADD	A,L
        LD	L,A
        LD	A,(HL)
J5C71:	RLA
        JP	NC,J5C7C
        OUT	(C),E
        DJNZ	J5C71
        JP	J5C80

J5C7C:	OUT	(C),D
        DJNZ	J5C71
J5C80:	LD	A,(HOLD8+45)
        LD	B,A
        LD	A,(HOLD8+47)
        ADD	A,L
        LD	L,A
        POP	AF
        DEC	A
        JR	NZ,J5C57
        RET

;	  Subroutine __________________________
;	     Inputs  ________________________
;	     Outputs ________________________

C5C8E:	PUSH	HL
        CALL	C5C94
        POP	HL
        RET

;	  Subroutine __________________________
;	     Inputs  ________________________
;	     Outputs ________________________

C5C94:	CALL	C632B
        ADD	A,H
        LD	H,A
        LD	A,(IX+0)
        AND	07H			; b2-b0
        CP	4
        JP	C,J6502
        LD	A,(IX+0)
        ADD	A,A
        JP	C,J5CF5			; interlace mode,
        JP	P,J5CBF			; non interlace mode + character width 8,
        PUSH	HL
        LD	L,H
        DEC	L
        LD	H,00H
        LD	C,L
        LD	B,H
        ADD	HL,HL
        ADD	HL,BC
        ADD	HL,HL
        LD	(HOLD8+36),HL
        LD	HL,6
        JR	J5CCD

J5CBF:	PUSH	HL
        LD	L,H
        DEC	L
        LD	H,00H
        ADD	HL,HL
        ADD	HL,HL
        ADD	HL,HL
        LD	(HOLD8+36),HL
        LD	HL,8
J5CCD:	BIT	1,E
        JR	Z,J5CD2
        ADD	HL,HL
J5CD2:	LD	(HOLD8+40),HL
        POP	HL
        DEC	L
        LD	H,00H
        ADD	HL,HL
        ADD	HL,HL
        ADD	HL,HL
        ADD	HL,HL
        LD	D,00H
        BIT	0,E
        LD	E,00H
        JR	Z,J5CE7
        LD	E,0AH	; 10
J5CE7:	ADD	HL,DE
        LD	(HOLD8+38),HL
        LD	HL,16
        SBC	HL,DE
        LD	(HOLD8+42),HL
        JR	C5D48

J5CF5:	BIT	6,(IX+0)
        JR	Z,J5D0D			; character width 8,
        PUSH	HL
        LD	L,H
        DEC	L
        LD	H,00H
        LD	C,L
        LD	B,H
        ADD	HL,HL
        ADD	HL,BC
        ADD	HL,HL
        LD	(HOLD8+36),HL
        LD	HL,6
        JR	J5D1B

J5D0D:	PUSH	HL
        LD	L,H
        DEC	L
        LD	H,00H
        ADD	HL,HL
        ADD	HL,HL
        ADD	HL,HL
        LD	(HOLD8+36),HL
        LD	HL,8
J5D1B:	BIT	1,E
        JR	Z,J5D20
        ADD	HL,HL
J5D20:	LD	(HOLD8+40),HL
        POP	HL
        DEC	L
        LD	H,00H
        ADD	HL,HL
        ADD	HL,HL
        ADD	HL,HL
        LD	D,00H
        BIT	0,E
        LD	E,00H
        JR	Z,J5D34
        LD	E,05H	; 5
J5D34:	ADD	HL,DE
        LD	(HOLD8+38),HL
        LD	HL,8
        SBC	HL,DE
        LD	(HOLD8+42),HL
        CALL	C5D48
        LD	HL,HOLD8+39
        SET	0,(HL)
;	  Subroutine __________________________
;	     Inputs  ________________________
;	     Outputs ________________________

C5D48:	CALL	C610E
        INC	C
        INC	C
        LD	HL,(HOLD8+36)
        OUT	(C),L
        OUT	(C),H
        LD	HL,(HOLD8+38)
        LD	A,(RG23SA)
        ADD	A,L
        OUT	(C),A
        LD	A,(ACPAGE)
        ADD	A,H
        OUT	(C),A
        LD	HL,(HOLD8+40)
        OUT	(C),L
        OUT	(C),H
        LD	HL,(HOLD8+42)
        OUT	(C),L
        OUT	(C),H
        LD	A,(FORCLR)
        LD	B,A
        LD	A,(BAKCLR)
        XOR	B
        LD	B,A
        CALL	C588B
        LD	A,B
        JR	NZ,J5D84
        ADD	A,A
        ADD	A,A
        ADD	A,A
        ADD	A,A
J5D84:	OUT	(C),A
        XOR	A
        OUT	(C),A
        LD	A,83H
        OUT	(C),A
        RET

;	  Subroutine __________________________
;	     Inputs  ________________________
;	     Outputs ________________________

C5D8E:	PUSH	HL
        PUSH	AF
        CALL	C5D96
        POP	AF
        POP	HL
        RET

;	  Subroutine __________________________
;	     Inputs  ________________________
;	     Outputs ________________________

C5D96:	LD	D,A
        LD	A,(IX+0)
        AND	07H			; b2-b0
        CP	4
        JP	C,J6640
        CALL	C5DA7
        JP	C6123

;	  Subroutine __________________________
;	     Inputs  ________________________
;	     Outputs ________________________

C5DA7:	BIT	5,(IX+0)
        JP	Z,C5E2F
        LD	A,L
        DEC	A
        JP	NZ,C5E2F
        BIT	7,(IX+0)
        LD	E,16
        JR	Z,J5DBD			; non interlace,
        LD	E,8
J5DBD:	PUSH	AF
        LD	HL,00E2H
        LD	A,0FH	; 15
        CALL	C5F7E
        CALL	C5EBD
        POP	AF
        JR	NZ,J5E05
        LD	A,D
        AND	A
        JR	Z,C5DF1
        LD	HL,00C0H
        LD	E,33H	; "3"
        LD	A,04H	; 4
        CALL	C5E51
        LD	HL,00C4H
        LD	E,10H	; 16
        LD	A,0CH	; 12
        CALL	C5E51
        CALL	C5DF1
        LD	HL,00E3H
        LD	E,0DDH
        LD	A,04H	; 4
        JP	C5E51

;	  Subroutine __________________________
;	     Inputs  ________________________
;	     Outputs ________________________

C5DF1:	CALL	C5E82
        LD	C,10H	; 16
;	  Subroutine __________________________
;	     Inputs  ________________________
;	     Outputs ________________________

C5DF6:	LD	A,(RG23SA)
        ADD	A,C
        LD	B,A
        LD	C,17H
        PUSH	BC
        CALL	C6123
        POP	BC
        JP	WRTVDP

J5E05:	LD	H,00H
        ADD	HL,HL
        ADD	HL,HL
        ADD	HL,HL
        LD	A,D
        ADD	A,A
        ADD	A,A
        ADD	A,A
        LD	E,38H	; "8"
        PUSH	AF
        PUSH	HL
        CALL	NZ,C5E46
        POP	HL
        PUSH	HL
        LD	A,0DCH
        SUB	L
        CALL	C5E9E
        LD	C,08H	; 8
        CALL	C5DF6
        POP	HL
        POP	AF
        LD	DE,48
        ADD	HL,DE
        LD	E,0D0H
        AND	A
        CALL	NZ,C5E46
        RET

;	  Subroutine __________________________
;	     Inputs  ________________________
;	     Outputs ________________________

C5E2F:	LD	A,D
        LD	H,00H
        ADD	HL,HL
        ADD	HL,HL
        ADD	HL,HL
        ADD	A,A
        ADD	A,A
        ADD	A,A
        BIT	7,(IX+0)
        LD	E,0F8H
        JR	NZ,C5E46		; interlace,
        ADD	HL,HL
        ADD	A,A
        LD	E,0F0H
        JR	C5E51

;	  Subroutine __________________________
;	     Inputs  ________________________
;	     Outputs ________________________

C5E46:	PUSH	HL
        PUSH	DE
        PUSH	AF
        CALL	C5E51
        POP	AF
        POP	DE
        POP	HL
        SET	0,H
;	  Subroutine __________________________
;	     Inputs  ________________________
;	     Outputs ________________________

C5E51:	LD	B,A
        LD	A,(RG23SA)
        ADD	A,L
        LD	L,A
        LD	A,E
        ADD	A,L
        LD	E,A
        LD	D,H
J5E5B:	LD	A,E
        CP	L
        JR	NC,J5E60
        LD	A,L
J5E60:	NEG
        CP	B
        JR	C,J5E66
        LD	A,B
J5E66:	PUSH	AF
        CALL	C5E78
        POP	AF
        LD	C,A
        LD	A,L
        ADD	A,C
        LD	L,A
        LD	A,E
        ADD	A,C
        LD	E,A
        LD	A,B
        SUB	C
        LD	B,A
        JR	NZ,J5E5B
        RET

;	  Subroutine __________________________
;	     Inputs  ________________________
;	     Outputs ________________________

C5E78:	CALL	C6198
        OUT	(C),A
        LD	A,0E0H
        OUT	(C),A
        RET

;	  Subroutine __________________________
;	     Inputs  ________________________
;	     Outputs ________________________

C5E82:	CALL	C5EBD
        LD	H,00H
        ADD	HL,HL
        ADD	HL,HL
        ADD	HL,HL
        ADD	HL,HL
        LD	A,10H	; 16
        CALL	C5EA7
        LD	HL,00E0H
        LD	A,04H	; 4
        JR	C5EA7

;	  Subroutine __________________________
;	     Inputs  ________________________
;	     Outputs ________________________

C5E97:	LD	HL,00F0H
        LD	A,10H	; 16
        JR	C5EA7

;	  Subroutine __________________________
;	     Inputs  ________________________
;	     Outputs ________________________

C5E9E:	PUSH	HL
        PUSH	AF
        CALL	C5EA7
        POP	AF
	POP	HL
        SET	0,H
;	  Subroutine __________________________
;	     Inputs  ________________________
;	     Outputs ________________________

C5EA7:	PUSH	AF
        LD	C,00H
        LD	A,(IX+0)
        INC	A
        AND	02H	; 2
        CP	01H	; 1
        ADC	A,C
        LD	B,A
        LD	E,C
        LD	D,C
        POP	AF
        CALL	C6021
        JP	C6123

;	  Subroutine __________________________
;	     Inputs  ________________________
;	     Outputs ________________________

C5EBD:	CALL	C4C76
        LD	L,A
        LD	A,(CNSDFG)
        AND	01H	; 1
        LD	D,A
        CALL	C6B21
        RET	C
        INC	D
        RET

;	  Subroutine __________________________
;	     Inputs  ________________________
;	     Outputs ________________________

C5ECD:	PUSH	HL
        PUSH	AF
        CALL	C5ED5
        POP	AF
        POP	HL
        RET

;	  Subroutine __________________________
;	     Inputs  ________________________
;	     Outputs ________________________

C5ED5:	LD	D,A
        LD	A,(IX+0)
        AND	07H			; b2-b0
        CP	4
        JP	C,J6674
        CALL	C5EE6
        JP	C6123

;	  Subroutine __________________________
;	     Inputs  ________________________
;	     Outputs ________________________

C5EE6:	BIT	5,(IX+0)
        JR	Z,J5F59
        LD	A,L
        SUB	D
        DEC	A
        JR	NZ,J5F59
        BIT	7,(IX+0)
        JR	NZ,J5F1A		; interlace,
        CALL	C5E97
        LD	C,0F0H
        CALL	C5DF6
        CALL	C5EBD
        INC	L
        LD	A,D
        AND	A
        CALL	NZ,C5E2F
        LD	HL,00D0H
        LD	A,04H	; 4
        CALL	C5EA7
        LD	E,0F0H
        LD	HL,00E4H
        LD	A,0FH	; 15
        JP	C5E51

J5F1A:	CALL	C5EBD
        LD	H,00H
        ADD	HL,HL
        ADD	HL,HL
        ADD	HL,HL
        LD	A,D
        ADD	A,A
        ADD	A,A
        ADD	A,A
        LD	E,30H	; "0"
        PUSH	AF
        PUSH	HL
        CALL	NZ,C5E46
        POP	HL
        PUSH	HL
        LD	A,0CCH
        SUB	L
        CALL	C5E9E
        LD	HL,00F8H
        LD	A,08H	; 8
        CALL	C5E9E
        LD	C,0F8H
        CALL	C5DF6
        LD	E,0F8H
        LD	HL,00DCH
        LD	A,0FH	; 15
        CALL	C5E51
        POP	HL
        POP	AF
        LD	DE,56
        ADD	HL,DE
        LD	E,0C8H
        AND	A
        CALL	NZ,C5E46
        RET

J5F59:	LD	A,D
        LD	H,00H
        DEC	L
        ADD	HL,HL
        ADD	HL,HL
        ADD	HL,HL
        ADD	A,A
        ADD	A,A
        ADD	A,A
        BIT	7,(IX+0)
        JR	NZ,J5F70		; interlace,
        ADD	HL,HL
        DEC	HL
        ADD	A,A
        LD	E,10H	; 16
        JR	C5F7E

J5F70:	DEC	HL
        LD	E,08H	; 8
        PUSH	HL
        PUSH	DE
        PUSH	AF
        CALL	C5F7E
        POP	AF
        POP	DE
        POP	HL
        SET	0,H
;	  Subroutine __________________________
;	     Inputs  ________________________
;	     Outputs ________________________

C5F7E:	LD	B,A
        LD	A,(RG23SA)
        ADD	A,L
        LD	L,A
        LD	A,E
        ADD	A,L
        LD	E,A
        LD	D,H
J5F88:	LD	A,E
        CP	L
        JR	C,J5F8D
        LD	A,L
J5F8D:	INC	A
        CP	B
        JR	C,J5F92
        LD	A,B
J5F92:	PUSH	AF
        CALL	C5FA4
        POP	AF
        LD	C,A
        LD	A,L
        SUB	C
        LD	L,A
        LD	A,E
        SUB	C
        LD	E,A
        LD	A,B
        SUB	C
        LD	B,A
        JR	NZ,J5F88
        RET

;	  Subroutine __________________________
;	     Inputs  ________________________
;	     Outputs ________________________

C5FA4:	CALL	C6198
        LD	A,08H	; 8
        OUT	(C),A
        LD	A,0E0H
        OUT	(C),A
        RET

;	  Subroutine __________________________
;	     Inputs  ________________________
;	     Outputs ________________________

C5FB0:	CALL	C632B
        ADD	A,H
        LD	H,A
        LD	A,(IX+0)
        AND	07H			; b2-b0,
        CP	4
        JP	C,J66AA
        CALL	C5FC5
        JP	C6123

;	  Subroutine __________________________
;	     Inputs  ________________________
;	     Outputs ________________________

C5FC5:	CALL	C589F
        SCF
J5FC9:	PUSH	HL
        PUSH	AF
        LD	L,H
        LD	H,00H
        DEC	L
        ADD	HL,HL
        BIT	6,(IX+0)
        JR	Z,J5FE0			; character width 8,
        LD	E,L
        LD	D,H
        ADD	HL,HL
        ADD	HL,DE
        EX	DE,HL
        LD	BC,0C06H
        JR	J5FE6

J5FE0:	ADD	HL,HL
        ADD	HL,HL
        EX	DE,HL
        LD	BC,1008H
J5FE6:	POP	AF
        JR	C,J5FF2
        DEC	A
        JR	Z,J5FED
        LD	C,B
J5FED:	LD	B,00H
        POP	HL
        JR	J6005

J5FF2:	LD	L,00H
        LD	A,(IX+0)
        INC	A
        AND	02H	; 2
        CP	01H	; 1
        ADC	A,L
        LD	H,A
        SBC	HL,DE
        LD	C,L
        LD	B,H
        POP	HL
        RET	Z
        RET	C
J6005:	DEC	L
        LD	H,00H
        ADD	HL,HL
        ADD	HL,HL
        ADD	HL,HL
        BIT	7,(IX+0)
        JR	NZ,J6016		; interlace,
        ADD	HL,HL
        LD	A,10H	; 16
        JR	C6021

J6016:	PUSH	BC
        PUSH	HL
        CALL	C601F
        POP	HL
        POP	BC
        SET	0,H
;	  Subroutine __________________________
;	     Inputs  ________________________
;	     Outputs ________________________

C601F:	LD	A,08H	; 8
;	  Subroutine __________________________
;	     Inputs  ________________________
;	     Outputs ________________________

C6021:	PUSH	AF
        LD	A,(RG23SA)
        ADD	A,L
        LD	L,A
        POP	AF
        NEG
        CP	L
        JR	NC,C603A
        PUSH	HL
        PUSH	BC
        PUSH	AF
        LD	A,L
        CALL	C603A
        POP	AF
        POP	BC
        POP	HL
        SUB	L
        LD	L,00H
;	  Subroutine __________________________
;	     Inputs  ________________________
;	     Outputs ________________________

C603A:	NEG
        PUSH	AF
        PUSH	BC
        CALL	C610E
        INC	C
        INC	C
        OUT	(C),E
        OUT	(C),D
        OUT	(C),L
        LD	A,(ACPAGE)
        ADD	A,H
        OUT	(C),A
        POP	HL
        OUT	(C),L
        OUT	(C),H
        POP	AF
        OUT	(C),A
        XOR	A
        OUT	(C),A
        LD	A,(NORUSE)
        AND	0FH	; 15
        JR	NZ,J6090
        LD	A,(IX+0)
        BIT	0,A
        JR	Z,J6079
        BIT	1,A
        JR	Z,J6086
        LD	A,(BAKCLR)
J606F:	OUT	(C),A
        XOR	A
        OUT	(C),A
        LD	A,0C0H
        OUT	(C),A
        RET

J6079:	BIT	0,E
        JR	NZ,J6090
        BIT	0,L
J607F:	JR	NZ,J6090
        CALL	C60A2
        JR	J606F

J6086:	LD	A,E
        AND	03H	; 3
        JR	NZ,J6090
        LD	A,L
        AND	03H	; 3
        JR	J607F

J6090:	LD	A,(BAKCLR)
        OUT	(C),A
        XOR	A
        OUT	(C),A
        LD	A,(NORUSE)
        AND	0FH	; 15
        OR	80H
        OUT	(C),A
        RET

;	  Subroutine __________________________
;	     Inputs  ________________________
;	     Outputs ________________________

C60A2:	LD	A,(BAKCLR)
        BIT	0,(IX+0)
        JR	Z,J60B4
        BIT	1,(IX+0)
        RET	NZ
        LD	B,A
        ADD	A,A
        ADD	A,A
        OR	B
J60B4:	LD	B,A
        ADD	A,A
        ADD	A,A
        ADD	A,A
        ADD	A,A
        OR	B
        RET

;	  Subroutine __________________________
;	     Inputs  ________________________
;	     Outputs ________________________

C60BB:	LD	A,(IX+0)
        AND	07H			; b2-b0
        CP	4
        JP	C,J6752
        LD	H,00H
        CALL	C60D1
        BIT	7,(IX+0)
        RET	Z			; not interlaced, quit
        LD	H,01H	; 1
;	  Subroutine __________________________
;	     Inputs  ________________________
;	     Outputs ________________________

C60D1:	LD	A,(SCRMOD)
        CP	02H	; 2
        LD	DE,256
        JR	C,J60DE
        LD	DE,212
J60DE:	CALL	C610E
        INC	C
        INC	C
        XOR	A
        OUT	(C),A
        OUT	(C),A
        OUT	(C),A
        LD	A,(ACPAGE)
        ADD	A,H
        OUT	(C),A
        OUT	(C),A
        LD	A,(IX+0)
        INC	A
        AND	02H	; 2
        CP	01H	; 1
        ADC	A,00H
        OUT	(C),A
        OUT	(C),E
        OUT	(C),D
        CALL	C60A2
        OUT	(C),A
        XOR	A
        OUT	(C),A
        LD	A,0C0H
        JR	J6121

;	  Subroutine __________________________
;	     Inputs  ________________________
;	     Outputs ________________________

C610E:	LD	A,24H	; "$"
;	  Subroutine __________________________
;	     Inputs  ________________________
;	     Outputs ________________________

C6110:	PUSH	AF
        LD	A,(D0006)
        LD	C,A
        INC	C
        POP	AF
        DI
        OUT	(C),A
        LD	A,91H
        OUT	(C),A
        EI
        JR	C6123

J6121:	OUT	(C),A
;	  Subroutine __________________________
;	     Inputs  ________________________
;	     Outputs ________________________

C6123:	LD	A,(D0006)
        LD	C,A
        INC	C
J6128:	LD	A,02H	; 2
        DI
        OUT	(C),A
        LD	A,8FH
        OUT	(C),A
        IN	A,(C)
        RRA
        LD	A,00H
        OUT	(C),A
        LD	A,8FH
        OUT	(C),A
        EI
        JR	C,J6128
        RET

;	  Subroutine __________________________
;	     Inputs  ________________________
;	     Outputs ________________________

C6140:	CALL	C610E
        INC	C
        INC	C
        LD	HL,(HOLD8+36)
        OUT	(C),L
        OUT	(C),H
        LD	HL,(HOLD8+38)
        LD	A,(RG23SA)
        ADD	A,L
        OUT	(C),A
        LD	A,(ACPAGE)
        ADD	A,H
        OUT	(C),A
        LD	HL,(HOLD8+40)
        OUT	(C),L
        OUT	(C),H
        LD	HL,(HOLD8+42)
        OUT	(C),L
        OUT	(C),H
        EX	DE,HL
        LD	DE,(FORCLR)
        RL	(HL)
        JP	NC,J6176
        OUT	(C),E
        DEFB	0D2H
J6176:	OUT	(C),D
        XOR	A
        OUT	(C),A
        LD	A,(NORUSE)
        AND	0FH	; 15
        OR	0B0H
        OUT	(C),A
        DEC	C
        DEC	C
        LD	A,0ACH
        DI
        OUT	(C),A
        LD	A,91H
        OUT	(C),A
        EI
        INC	C
        INC	C
        LD	A,(HOLD8+45)
        DEC	A
        LD	B,A
        RET

;	  Subroutine __________________________
;	     Inputs  ________________________
;	     Outputs ________________________

C6198:	PUSH	AF
        LD	A,22H	; """
        CALL	C6110
        INC	C
        INC	C
        OUT	(C),L
        LD	A,(ACPAGE)
        ADD	A,H
        OUT	(C),A
        XOR	A
        OUT	(C),A
        OUT	(C),A
        OUT	(C),E
        LD	A,(ACPAGE)
        ADD	A,D
        OUT	(C),A
        OUT	(C),A
        OUT	(C),A
        POP	AF
        OUT	(C),A
        XOR	A
        OUT	(C),A
        OUT	(C),A
        RET

;	  Subroutine __________________________
;	     Inputs  ________________________
;	     Outputs ________________________

C61C2:	LD	A,C
        CP	80H
        ADC	A,0FFH
        CP	9EH
        PUSH	AF
        JR	C,J61CE
        SUB	5EH
J61CE:	SUB	3FH
        LD	C,A
        LD	A,B
        CP	0E0H
        JR	C,J61D8
        SUB	40H
J61D8:	SUB	81H
        LD	B,A
        POP	AF
        CCF
        LD	A,B
        RLA
        INC	A
        RET

;	  Subroutine __________________________
;	     Inputs  ________________________
;	     Outputs ________________________

C61E1:	LD	B,32

;	  Subroutine __________________________
;	     Inputs  ________________________
;	     Outputs ________________________

C61E3:	LD	HL,HOLD8
        LD	D,0
J61E8:	LD	E,(HL)
        PUSH	HL
        LD	HL,I721D
        ADD	HL,DE
        LD	A,(HL)
        POP	HL
        LD	(HL),A
        INC	HL
        DJNZ	J61E8
        RET

;	  Subroutine read Matsushita JIS rom
;	     Inputs  ________________________
;	     Outputs ________________________

C61F5:	IN	A,(40H)
        PUSH	AF
        LD	A,0F7H
        OUT	(40H),A
        PUSH	HL
        LD	DE,253FH
I6200:	OR	A
        SBC	HL,DE
        POP	HL
        IN	A,(41H)
        JR	NC,J620A
        IN	A,(40H)
J620A:	CP	08H	; 8
        JR	Z,J6212
        LD	A,03H	; 3
        OUT	(42H),A
J6212:	CALL	C621A
        POP	AF
        CPL
        OUT	(40H),A
        RET

;	  Subroutine __________________________
;	     Inputs  ________________________
;	     Outputs ________________________

C621A:	LD	A,H
        OUT	(47H),A
        LD	A,L
        OUT	(48H),A
        LD	HL,0
        LD	(HOLD8+0),HL
        LD	(HOLD8+8),HL
        LD	(HOLD8+22),HL
        LD	(HOLD8+30),HL
        LD	IY,HOLD8+2
        CALL	C623A
        LD	IY,HOLD8+16

;	  Subroutine __________________________
;	     Inputs  ________________________
;	     Outputs ________________________

C623A:	LD	B,3
J623C:	IN	A,(49H)
        LD	(IY+0),A
        RRCA
        RRCA
        AND	0C0H
        LD	C,A
        IN	A,(49H)
        LD	E,A
        RRCA
        RRCA
        AND	3FH
        OR	C
        LD	(IY+8),A
        LD	A,E
        ADD	A,A
        ADD	A,A
        ADD	A,A
        ADD	A,A
        LD	C,A
        IN	A,(49H)
        LD	E,A
        RRCA
        RRCA
        RRCA
        RRCA
        AND	0FH
        OR	C
        LD	(IY+1),A
        LD	A,E
        ADD	A,A
        ADD	A,A
        LD	(IY+9),A
        INC	IY
        INC	IY
        DJNZ	J623C
        RET

;	  Subroutine __________________________
;	     Inputs  ________________________
;	     Outputs ________________________

C6271:	ADD	A,20H	; " "
        PUSH	AF
        RRCA
        RRCA
        RRCA
        RRCA
        CALL	C627C
        POP	AF
;	  Subroutine __________________________
;	     Inputs  ________________________
;	     Outputs ________________________

C627C:	AND	0FH	; 15
        CP	0AH	; 10
        SBC	A,69H	; "i"
        DAA
        LD	L,A
        CALL	C62AA
        LD	BC,8
        LDIR
        RET

;	  Subroutine read character data from default charactergenerator
;	     Inputs  ________________________
;	     Outputs ________________________

C628D:	LD	DE,HOLD8+0

;	  Subroutine read character data from default charactergenerator
;	     Inputs  ________________________
;	     Outputs ________________________

C6290:	PUSH	HL
        LD	L,C
        CALL	C62AA
        LD	C,2
J6297:	LD	B,4
J6299:	LD	A,(HL)
        INC	HL
        LD	(DE),A
        INC	DE
        LD	(DE),A
        INC	DE
        DJNZ	J6299
        LD	A,8
        ADD	A,E
        LD	E,A
        DEC	C
        JR	NZ,J6297
        POP	HL
        RET

;	  Subroutine __________________________
;	     Inputs  ________________________
;	     Outputs ________________________

C62AA:	LD	H,0
        ADD	HL,HL
        ADD	HL,HL
        ADD	HL,HL
        LD	BC,(D0004)
        ADD	HL,BC
        RET

;	  Subroutine __________________________
;	     Inputs  ________________________
;	     Outputs ________________________

C62B5:	LD	IY,HOLD8+0
        CALL	C62C0
        LD	IY,HOLD8+16

;	  Subroutine __________________________
;	     Inputs  ________________________
;	     Outputs ________________________

C62C0:	LD	D,4
J62C2:	LD	E,2
        LD	A,(IY+0)
J62C7:	LD	B,4
        BIT	6,(IX+0)
        JR	Z,J62D0			; character width 8,
        DEC	B
J62D0:	LD	C,0
J62D2:	ADD	A,A
        RL	C
        RRC	C
        RL	C
        RL	C
        DJNZ	J62D2
        BIT	6,(IX+0)
        JR	Z,J62E7			; character width 8,
        RL	C
        RL	C
J62E7:	LD	(IY+0),C
        LD	(IY+1),C
        LD	BC,8
        ADD	IY,BC
        DEC	E
        JR	NZ,J62C7
        LD	BC,0FFF2H
        ADD	IY,BC
        DEC	D
        JR	NZ,J62C2
        RET

;	  Subroutine __________________________
;	     Inputs  ________________________
;	     Outputs ________________________

C62FE:	LD	IY,HOLD8+0
        CALL	C6309
        LD	IY,HOLD8+16
;	  Subroutine __________________________
;	     Inputs  ________________________
;	     Outputs ________________________

C6309:	LD	B,4
J630B:	LD	A,(IY+0)
        RRCA
        RRCA
        LD	C,A
        AND	3CH
        LD	(IY+0),A
        LD	(IY+1),A
        LD	A,C
        RRCA
        RRCA
        AND	0F0H
        LD	(IY+8),A
        LD	(IY+9),A
        INC	IY
        INC	IY
        DJNZ	J630B
        RET

;	  Subroutine __________________________
;	     Inputs  ________________________
;	     Outputs ________________________

C632B:	PUSH	BC
        CALL	C633A
        LD	A,(LINLEN)
        NEG
        ADD	A,B
        INC	A
        AND	A
        RRA
        POP	BC
        RET

;	  Subroutine __________________________
;	     Inputs  ________________________
;	     Outputs ________________________

C633A:	LD	A,(IX+0)
        AND	07H			; b2-b0
        LD	BC,080AH
        CP	2
        JR	Z,J6354
        LD	BC,4050H
        CP	5
        JR	Z,J6354
        CP	6
        JR	Z,J6354
        LD	BC,2028H
J6354:	BIT	6,(IX+0)
        RET	Z			; character width 8, quit
        LD	B,C
        RET

J635B:	CP	2
        JP	Z,J6479
        LD	E,16
        JR	J636B

J6364:	CP	2
        JP	Z,J647D
        LD	E,8
J636B:	LD	A,L
        DEC	A
        ADD	A,A
        LD	L,A
        LD	A,H
        DEC	A
        ADD	A,A
        BIT	6,(IX+0)
        JR	NZ,J63AA		; character width 6,
        ADD	A,A
        ADD	A,A
        LD	H,L
        LD	L,A
        LD	A,(D0006)
        LD	C,A
        INC	C
        LD	A,E
        LD	E,L
        LD	D,H
        CALL	C6774
        LD	HL,HOLD8+0
        LD	B,A
        DEC	C
J638C:	OUTI
        JP	NZ,J638C
        INC	C
        LD	L,E
        LD	H,D
        INC	H
        CALL	C6774
        LD	HL,HOLD8+16
        LD	B,A
        DEC	C
J639D:	OUTI
        JP	NZ,J639D
        INC	C
        EX	DE,HL
        SET	5,H
        LD	B,A
        JP	J66EB

J63AA:	LD	B,A
        ADD	A,A
        ADD	A,B
        LD	H,L
        LD	L,A
        LD	A,(D0006)
        LD	C,A
        INC	C
        LD	A,E
        CP	08H	; 8
        LD	IY,HOLD8+0
        JR	Z,C63CB
        PUSH	HL
        CALL	C63CB
        POP	HL
        LD	A,06H	; 6
        ADD	A,L
        LD	L,A
        LD	IY,HOLD8+8
        INC	C
;	  Subroutine __________________________
;	     Inputs  ________________________
;	     Outputs ________________________

C63CB:	LD	A,L
        RES	0,L
        RES	1,L
        RES	2,L
        AND	07H	; 7
        LD	D,03H	; 3
        JR	Z,C641B
        CP	02H	; 2
        JR	Z,J6412
        CP	06H	; 6
        JR	Z,J63F9
        LD	D,04H	; 4
        PUSH	HL
        CALL	C6452
        POP	HL
        LD	D,0F0H
        PUSH	IY
        CALL	C641B
        POP	IY
        INC	C
        LD	DE,0DF08H
        ADD	HL,DE
        LD	D,3FH	; "?"
        JR	C641B

J63F9:	LD	D,02H	; 2
        PUSH	HL
        CALL	C6452
        POP	HL
        LD	D,0FCH
        PUSH	IY
        CALL	C641B
        POP	IY
        INC	C
        LD	DE,0DF08H
        ADD	HL,DE
        LD	D,0FH	; 15
        JR	C641B

J6412:	LD	D,0FEH
        PUSH	HL
        CALL	C6452
        POP	HL
        LD	D,0C0H
;	  Subroutine __________________________
;	     Inputs  ________________________
;	     Outputs ________________________

C641B:	PUSH	BC
        CALL	C6431
        LD	BC,8
        ADD	IY,BC
        POP	BC
        INC	H
        CALL	C6431
        DEC	H
        SET	5,H
J642C:	LD	B,08H	; 8
        JP	J66EB

;	  Subroutine __________________________
;	     Inputs  ________________________
;	     Outputs ________________________

C6431:	PUSH	HL
        CALL	C6776
        DEC	C
        LD	HL,PATWRK
        LD	B,08H	; 8
J643B:	IN	A,(C)
        AND	D
        LD	E,A
        LD	A,D
        CPL
        AND	(IY+0)
        OR	E
        LD	(HL),A
        INC	HL
        INC	IY
        DJNZ	J643B
        POP	HL
        PUSH	HL
        LD	B,08H	; 8
        JP	J65C8

;	  Subroutine __________________________
;	     Inputs  ________________________
;	     Outputs ________________________

C6452:	PUSH	IY
        POP	HL
        CALL	C645C
        LD	A,08H	; 8
        ADD	A,L
        LD	L,A
;	  Subroutine __________________________
;	     Inputs  ________________________
;	     Outputs ________________________

C645C:	LD	E,08H	; 8
        BIT	7,D
        JR	NZ,J646D
J6462:	LD	B,D
        LD	A,(HL)
J6464:	RLCA
        DJNZ	J6464
        LD	(HL),A
        INC	HL
        DEC	E
        JR	NZ,J6462
        RET

J646D:	LD	B,D
        LD	A,(HL)
J646F:	RRCA
        INC	B
        JR	NZ,J646F
        LD	(HL),A
        INC	HL
        DEC	E
        JR	NZ,J646D
        RET

J6479:	LD	E,02H	; 2
        JR	J647F

J647D:	LD	E,01H	; 1
J647F:	LD	A,L
        DEC	A
        ADD	A,A
        LD	L,A
        LD	A,H
        DEC	A
        CALL	C6744
        LD	H,L
        LD	L,A
        LD	A,(D0006)
        LD	C,A
        DEC	E
        LD	DE,HOLD8+0
        JR	Z,C64A9
        PUSH	HL
        CALL	C64A9
        POP	HL
        BIT	6,(IX+0)
        LD	DE,32
        JR	Z,J64A5			; character width 8,
        LD	DE,24
J64A5:	ADD	HL,DE
        LD	DE,HOLD8+8

;	  Subroutine __________________________
;	     Inputs  ________________________
;	     Outputs ________________________

C64A9:	PUSH	HL
        CALL	C64B4
        LD	DE,16
        ADD	HL,DE
        EX	DE,HL
        POP	HL
        INC	H
;	  Subroutine __________________________
;	     Inputs  ________________________
;	     Outputs ________________________

C64B4:	INC	C
        CALL	C6774
        EX	DE,HL
        DEC	C
        BIT	6,(IX+0)
        LD	E,4
        JR	Z,J64C4			; character width 8,
        LD	E,03H	; 3
J64C4:	PUSH	HL
        LD	B,08H	; 8
J64C7:	RL	(HL)
        LD	A,(BAKCLR)
        JP	NC,J64D2
        LD	A,(FORCLR)
J64D2:	ADD	A,A
        ADD	A,A
        ADD	A,A
        ADD	A,A
        LD	D,A
        RL	(HL)
        LD	A,(BAKCLR)
        JP	NC,J64E2
        LD	A,(FORCLR)
J64E2:	AND	0FH	; 15
        OR	D
        OUT	(C),A
        INC	HL
        DJNZ	J64C7
        POP	HL
        DEC	E
        JR	NZ,J64C4
        RET

;	  Subroutine __________________________
;	     Inputs  ________________________
;	     Outputs ________________________

C64EF:	LD	A,(BAKCLR)
        JR	J64F7

;	  Subroutine __________________________
;	     Inputs  ________________________
;	     Outputs ________________________

C64F4:	LD	A,(FORCLR)
J64F7:	PUSH	HL
        ADD	A,A
        ADD	A,A
        ADD	A,A
        ADD	A,A
        LD	HL,BAKCLR
        OR	(HL)
D$6500:	POP	HL
        RET

J6502:	CP	02H	; 2
        JP	Z,J65D2
        LD	A,L
        DEC	A
        ADD	A,A
        LD	L,A
        LD	A,H
        DEC	A
        ADD	A,A
        BIT	6,(IX+0)
        JR	NZ,J6553		; character width 6,
        ADD	A,A
        ADD	A,A
        LD	H,L
        LD	L,A
        LD	A,(D0006)
        LD	C,A
        INC	C
        BIT	0,E
        JR	NZ,J6544
        BIT	1,E
        LD	B,08H	; 8
        JR	Z,J6529
        LD	B,10H	; 16
J6529:	PUSH	BC
        PUSH	HL
        CALL	C6531
        POP	HL
        POP	BC
        INC	H
;	  Subroutine __________________________
;	     Inputs  ________________________
;	     Outputs ________________________

C6531:	CALL	C6776
        DEC	C
        IN	A,(C)
        INC	C
        CPL
        CALL	C6774
        DEC	C
        OUT	(C),A
        INC	C
        INC	HL
        DJNZ	C6531
        RET

J6544:	INC	H
        LD	B,06H	; 6
        CALL	C654D
        BIT	1,E
        RET	Z
;	  Subroutine __________________________
;	     Inputs  ________________________
;	     Outputs ________________________

C654D:	INC	L
        INC	L
        LD	B,06H	; 6
        JR	C6531

J6553:	LD	B,A
        ADD	A,A
        ADD	A,B
        LD	H,L
        LD	L,A
        LD	A,(D0006)
        LD	C,A
        INC	C
        BIT	1,E
        JR	Z,C656A
        PUSH	HL
        CALL	C656A
        POP	HL
        LD	A,06H	; 6
        ADD	A,L
        LD	L,A
;	  Subroutine __________________________
;	     Inputs  ________________________
;	     Outputs ________________________

C656A:	LD	A,L
        RES	1,L
        RES	2,L
        AND	07H	; 7
        LD	D,0FCH
        JR	Z,C659D
        CP	02H	; 2
        JR	Z,J659B
        CP	06H	; 6
        JR	Z,J658C
        LD	D,0FH	; 15
        CALL	C659D
        LD	A,E
        LD	DE,0FF08H
        ADD	HL,DE
        LD	E,A
        LD	D,0C0H
        JR	C659D

J658C:	LD	D,03H	; 3
        CALL	C659D
        LD	A,E
        LD	DE,0FF08H
        ADD	HL,DE
        LD	E,A
        LD	D,0F0H
        JR	C659D

J659B:	LD	D,3FH	; "?"
;	  Subroutine __________________________
;	     Inputs  ________________________
;	     Outputs ________________________

C659D:	BIT	0,E
        CALL	Z,C65A3
        INC	H
;	  Subroutine __________________________
;	     Inputs  ________________________
;	     Outputs ________________________

C65A3:	PUSH	HL
        LD	B,08H	; 8
        BIT	0,E
        JR	Z,J65AE
        INC	HL
        INC	HL
        LD	B,06H	; 6
J65AE:	CALL	C6776
        DEC	C
        LD	HL,PATWRK
J65B5:	IN	A,(C)
        XOR	D
        LD	(HL),A
        INC	HL
        DJNZ	J65B5
        POP	HL
        PUSH	HL
        LD	B,08H	; 8
        BIT	0,E
        JR	Z,J65C8
        INC	HL
        INC	HL
        LD	B,06H	; 6
J65C8:	INC	C
        CALL	C6774
        LD	HL,PATWRK
        JP	J679C

J65D2:	LD	A,L
        DEC	A
        ADD	A,A
        LD	L,A
        LD	A,H
        DEC	A
        CALL	C6744
        LD	H,L
        LD	L,A
        LD	A,(D0006)
        LD	C,A
        INC	C
        LD	A,(FORCLR)
        LD	D,A
        LD	A,(BAKCLR)
        XOR	D
        LD	D,A
        ADD	A,A
        ADD	A,A
        ADD	A,A
        ADD	A,A
        OR	D
        LD	D,A
        BIT	0,E
        JR	NZ,J6623
        BIT	1,E
        LD	B,20H	; " "
        LD	E,18H
        JR	Z,J6601
        LD	B,40H	; "@"
        LD	E,30H	; "0"
J6601:	BIT	6,(IX+0)
        JR	Z,J6608			; character width 8,
        LD	B,E
J6608:	PUSH	BC
        PUSH	HL
        CALL	C6610
        POP	HL
        POP	BC
        INC	H
;	  Subroutine __________________________
;	     Inputs  ________________________
;	     Outputs ________________________

C6610:	CALL	C6776
        DEC	C
        IN	A,(C)
        INC	C
        XOR	D
        CALL	C6774
        DEC	C
        OUT	(C),A
        INC	C
        INC	HL
        DJNZ	C6610
        RET

J6623:	INC	H
        PUSH	DE
        CALL	C662C
        POP	DE
        BIT	1,E
        RET	Z
;	  Subroutine __________________________
;	     Inputs  ________________________
;	     Outputs ________________________

C662C:	LD	E,04H	; 4
        BIT	6,(IX+0)
        JR	Z,J6635			; character width 8,
        DEC	E
J6635:	INC	L
        INC	L
        LD	B,06H	; 6
        CALL	C6610
        DEC	E
        JR	NZ,J6635
        RET

J6640:	PUSH	AF
        LD	A,D
        ADD	A,A
        ADD	A,A
        ADD	A,A
        ADD	A,A
        LD	E,A
        LD	A,L
        ADD	A,A
        LD	H,A
        LD	L,00H
        LD	A,(D0006)
        LD	C,A
        INC	C
        POP	AF
        CP	02H	; 2
        JR	Z,C665F
        PUSH	DE
        PUSH	HL
        SET	5,H
        CALL	C665F
        POP	HL
        POP	DE
;	  Subroutine __________________________
;	     Inputs  ________________________
;	     Outputs ________________________

C665F:	CALL	C6781
        DEC	H
        DEC	H
        CALL	C6793
        INC	H
        INC	H
        LD	A,L
        ADD	A,20H	; " "
        LD	L,A
        JR	NC,J6670
        INC	H
J6670:	DEC	E
        JR	NZ,C665F
        RET

J6674:	PUSH	AF
        LD	A,D
        ADD	A,A
        ADD	A,A
        ADD	A,A
        ADD	A,A
        LD	E,A
        LD	A,L
        DEC	A
        ADD	A,A
        DEC	A
        LD	H,A
        LD	L,0E0H
        LD	A,(D0006)
        LD	C,A
        INC	C
        POP	AF
        CP	02H	; 2
        JR	Z,C6695
        PUSH	DE
        PUSH	HL
        SET	5,H
        CALL	C6695
        POP	HL
        POP	DE
;	  Subroutine __________________________
;	     Inputs  ________________________
;	     Outputs ________________________

C6695:	CALL	C6781
        INC	H
        INC	H
        CALL	C6793
        DEC	H
        DEC	H
        LD	A,L
        SUB	20H	; " "
        LD	L,A
        JR	NC,J66A6
        DEC	H
J66A6:	DEC	E
        JR	NZ,C6695
        RET

J66AA:	LD	BC,(D0006)
        INC	C
        CP	02H	; 2
        JR	Z,J66F0
        LD	A,L
        DEC	A
        ADD	A,A
        LD	L,A
        LD	A,H
        DEC	A
        ADD	A,A
        BIT	6,(IX+0)
        JR	Z,J66D9			; character width 8,
        LD	B,A
        ADD	A,A
        ADD	A,B
        LD	H,L
        LD	L,A
        AND	07H	; 7
        JR	Z,J66DE
        RES	1,L
        RES	2,L
        PUSH	HL
        CALL	C6711
        INC	C
        POP	HL
        LD	A,L
        ADD	A,08H	; 8
        LD	L,A
        JR	J66DE

J66D9:	ADD	A,A
        ADD	A,A
        RET	C
        LD	H,L
        LD	L,A
J66DE:	LD	A,L
        NEG
        LD	B,A
        PUSH	BC
        XOR	A
        CALL	C6702
        POP	BC
        DEC	H
        SET	5,H
J66EB:	CALL	C64F4
        JR	C6702

J66F0:	LD	A,L
        DEC	A
        ADD	A,A
        LD	L,A
        LD	A,H
        DEC	A
        CALL	C6744
        RET	C
        LD	H,L
        LD	L,A
        NEG
        LD	B,A
        CALL	C64EF
;	  Subroutine __________________________
;	     Inputs  ________________________
;	     Outputs ________________________

C6702:	PUSH	BC
        CALL	C6708
        POP	BC
        INC	H
;	  Subroutine __________________________
;	     Inputs  ________________________
;	     Outputs ________________________

C6708:	CALL	C6774
        DEC	C
J670C:	OUT	(C),A
        DJNZ	J670C
        RET

;	  Subroutine __________________________
;	     Inputs  ________________________
;	     Outputs ________________________

C6711:	LD	D,0C0H
        CP	02H	; 2
        JR	Z,J671F
        LD	D,0FCH
        CP	06H	; 6
        JR	Z,J671F
        LD	D,0F0H
J671F:	CALL	C672C
        INC	H
        CALL	C672C
        DEC	H
        SET	5,H
        JP	J642C

;	  Subroutine __________________________
;	     Inputs  ________________________
;	     Outputs ________________________

C672C:	PUSH	HL
        LD	B,08H	; 8
        CALL	C6776
        DEC	C
        LD	HL,PATWRK
J6736:	IN	A,(C)
        AND	D
        LD	(HL),A
        INC	HL
        DJNZ	J6736
        POP	HL
        PUSH	HL
        LD	B,08H	; 8
        JP	J65C8

;	  Subroutine __________________________
;	     Inputs  ________________________
;	     Outputs ________________________

C6744:	ADD	A,A
        ADD	A,A
        ADD	A,A
        LD	B,A
        ADD	A,A
        BIT	6,(IX+0)
        JR	NZ,J6750		; character width 6,
        LD	B,A
J6750:	ADD	A,B
        RET

J6752:	CP	02H	; 2
        JR	Z,J6768
        XOR	A
        LD	L,A
        LD	H,A
        CALL	C6762
        CALL	C64F4
        LD	HL,2000H
;	  Subroutine __________________________
;	     Inputs  ________________________
;	     Outputs ________________________

C6762:	LD	BC,1800H
        JP	FILVRM

J6768:	CALL	C64EF
        LD	HL,0
        LD	BC,0800H
        JP	FILVRM

;	  Subroutine __________________________
;	     Inputs  ________________________
;	     Outputs ________________________

C6774:	SET	6,H
;	  Subroutine __________________________
;	     Inputs  ________________________
;	     Outputs ________________________

C6776:	DI
        OUT	(C),L
        OUT	(C),H
        EI
        EX	(SP),HL
        EX	(SP),HL
        RES	6,H
        RET

;	  Subroutine __________________________
;	     Inputs  ________________________
;	     Outputs ________________________

C6781:	PUSH	HL
        CALL	C6776
        LD	HL,HOLD8
        LD	B,20H	; " "
        DEC	C
J678B:	INI
        JP	NZ,J678B
        INC	C
        POP	HL
        RET

;	  Subroutine __________________________
;	     Inputs  ________________________
;	     Outputs ________________________

C6793:	PUSH	HL
        CALL	C6774
        LD	HL,HOLD8
        LD	B,20H	; " "
J679C:	DEC	C
J679D:	OUTI
        JP	NZ,J679D
        INC	C
        POP	HL
        RET

;	  Subroutine initialize MSX-JE if available
;	     Inputs  ________________________
;	     Outputs ________________________

C67A5:	LD	A,(HOKVLD)
        RRCA
        CCF				; EXTBIO initialized ?
        RET	C			; nope, quit
        LD	HL,-64
        ADD	HL,SP			; allocate space for 64 bytes
        LD	A,H
        CP	0C0H			; stackpointer in page 3 with enough space ?
        RET	C			; nope, quit
        LD	SP,HL
        PUSH	HL
        IN	A,(0A8H)
        AND	0C0H
        RLCA
        RLCA				; primary slot of page 3
        LD	HL,EXPTBL
        LD	C,A
        LD	B,00H
        ADD	HL,BC
        LD	A,(HL)
        AND	80H
        JR	Z,J67D3
        INC	HL
        INC	HL
        INC	HL
        INC	HL
        LD	A,(HL)
        AND	0C0H
        RRCA
        RRCA
        RRCA
        SCF
        RRA
J67D3:	OR	C
        LD	B,A			; slotid of page 3 (so B:HL is intraslotadres)
        LD	DE,01000H		; MSX-JE function 0: get capability
        POP	HL			; workspace
        PUSH	HL
        CALL	EXTBIO
        POP	DE
        OR	A
        SBC	HL,DE			; workspace filled ?
        JR	Z,J67F3			; nope, quit with error
        SRA	L
        SRA	L
        LD	B,L			; number of entries
J67E8:	LD	A,(DE)
        INC	DE
        AND	07H			; b2-b0 zero ?
        JR	Z,J67F6			; yep, usable MSX-JE
        INC	DE
        INC	DE
        INC	DE
        DJNZ	J67E8			; next entry
J67F3:	SCF
        JR	J67FD			; quit

J67F6:	EX	DE,HL
        LD	A,(HL)			; slotid
        INC	HL
        LD	E,(HL)
        INC	HL
        LD	D,(HL)			; address
        OR	A			; clear Cx
J67FD:	PUSH	AF
        LD	HL,64+2
        ADD	HL,SP
        POP	AF
        LD	SP,HL			; deallocate workspace
        RET	C			; quit
        PUSH	AF
        PUSH	DE
        PUSH	AF
        POP	IY
        PUSH	DE
        POP	IX
        LD	A,1
        CALL	CALSLT			; MSX-JE, inquiry
        PUSH	BC			; size of workspace needed by MSX-JE
        LD	HL,353
        ADD	HL,BC			; plus an extra 0161H
        EX	DE,HL
        LD	HL,(HIMEM)
        AND	A
        SBC	HL,DE
        LD	(HIMEM),HL		; adjust HIMEM
        LD	A,(H.PHYD+0)
        CP	0C9H			; disk system active ?
        JR	Z,J682B
        LD	(DF349),HL		; yep, adjust lower of disksystem
J682B:	POP	BC
        POP	DE			; adres
        POP	AF			; slotid
        POP	IX			; return adres
        LD	SP,HL
        PUSH	IX
        PUSH	BC
        PUSH	AF
        PUSH	DE
        CALL	C4099			; get my SLTWRK entry
        LD	(IX+4),L
        LD	(IX+5),H		; save start of MSX-JE workarea
        PUSH	HL
        POP	IY
        LD	(IY+0),21H		; ld hl,
        LD	(IY+3),0F7H		; rst fcall
        LD	(IY+7),0C9H		; ret
        CALL	C698F
        XOR	A
        LD	(IY+8),A
        LD	(IY+9),A
        LD	(IY+10),A
        LD	DE,0161H
        ADD	HL,DE
        LD	(IY+1),L
        LD	(IY+2),H		; workarea + 0161H
        POP	DE
        POP	AF
        LD	(IY+4),A		; slotid MSX-JE
        LD	(IY+5),E
        LD	(IY+6),D		; address MSX-JE handler
        POP	DE
        LD	(IY+15),E
        LD	(IY+16),D		; size of MSX-JE workspace
        RET

;	  Subroutine restore functionkey F1-F8 definitions
;	     Inputs  ________________________
;	     Outputs ________________________

C6878:	CALL	C6887
        DI
        LDIR
        EI
        RET

;	  Subroutine save functionkey F1-F8 definitions
;	     Inputs  ________________________
;	     Outputs ________________________

C6880:	CALL	C6887
        EX	DE,HL
        LDIR
        RET

;	  Subroutine __________________________
;	     Inputs  ________________________
;	     Outputs ________________________

C6887:	PUSH	IY
        POP	HL
        LD	DE,17
        ADD	HL,DE
        LD	DE,FNKSTR
        LD	BC,80
        RET

;	  Subroutine __________________________
;	     Inputs  ________________________
;	     Outputs ________________________

C6895:	CALL	C487E
        CALL	C68A1
        PUSH	AF
        CALL	C4896
        POP	AF
        RET

;	  Subroutine __________________________
;	     Inputs  ________________________
;	     Outputs ________________________

C68A1:	CALL	C79B9			; get japanese input frontend processor area
        JP	Z,J741D			; not a MSX-JE,
        LD	L,(IY+9)
        LD	H,(IY+10)
        LD	A,L
        OR	H
        JP	NZ,J6939
J68B2:	BIT	1,(IY+8)
        JR	NZ,J690A
        CALL	C6953
        JR	C,J68F1
        BIT	0,(IY+8)
        JR	NZ,J68D6
        LD	A,3
        CALL	C6A19			; MSX-JE release
        CALL	C6878			; restore functionkey F1-F8 definitions
        CALL	C69CC
        CALL	NC,C6AC7
J68D1:	CALL	C69DB
        JR	J68B2

J68D6:	CALL	C6880			; save functionkey F1-F8 definitions
        LD	E,(IY+15)
        LD	D,(IY+16)
        LD	A,2
        CALL	C6A19			; MSX-JE invoke
        LD	A,4
        CALL	C6A19			; MSX-JE clear
        CALL	C69E8
        CALL	C6A73
        JR	J68D1

J68F1:	BIT	0,(IY+8)
        JR	Z,J6950
        CP	01H	; 1
        JR	Z,J6903
        CP	20H	; " "
        JR	C,J6950
        CP	7FH
        JR	Z,J6950
J6903:	CALL	C6B3A
        SET	1,(IY+8)
J690A:	LD	A,6
        CALL	C6A19			; MSX-JE dispatch
        BIT	2,A
        JR	Z,J691A
        CALL	C698F
        RES	1,(IY+8)
J691A:	RRCA
        PUSH	AF
        CALL	C,C6A48
        POP	AF
        RRCA
        JP	NC,J68B2
        LD	A,7
        CALL	C6A19			; MSX-JE get result
        LD	A,(HL)
        AND	A
        JP	Z,J68B2
        LD	A,(GETPNT)
        LD	(IY+14),A
        LD	A,80H
        LD	(GETPNT),A
J6939:	LD	B,(HL)
        INC	HL
        LD	A,(HL)
        AND	A
        JR	NZ,J6948
        LD	A,(IY+14)
        LD	(GETPNT),A
        LD	HL,0
J6948:	LD	(IY+9),L
        LD	(IY+10),H
        LD	A,B
        RET

J6950:	JP	CHGET

;	  Subroutine __________________________
;	     Inputs  ________________________
;	     Outputs ________________________

C6953:	PUSH	IY
        PUSH	IX
        CALL	CHSNS
        POP	IX
        POP	IY
        JR	Z,C6953
        LD	HL,(GETPNT)
        LD	A,(HL)
        CP	20H	; " "
        JR	NZ,J6973
        LD	A,06H	; 6
        CALL	SNSMAT
        AND	02H	; 2
        JR	Z,J6982
        LD	A,20H	; " "
J6973:	CP	18H
        SCF
        RET	NZ
        LD	A,06H	; 6
        CALL	SNSMAT
        AND	04H	; 4
        LD	A,18H
        SCF
        RET	NZ
J6982:	CALL	KILBUF
        LD	A,(IY+8)
        XOR	01H	; 1
        AND	0FDH
        LD	(IY+8),A
;	  Subroutine __________________________
;	     Inputs  ________________________
;	     Outputs ________________________

C698F:	PUSH	HL
        PUSH	AF
        PUSH	IY
        POP	HL
        LD	BC,97
        ADD	HL,BC
        EX	DE,HL
        PUSH	DE
        LD	HL,NORUSE
        DI
        RES	5,(HL)
        LD	HL,(GETPNT)
        LD	B,00H
J69A5:	LD	A,(PUTPNT)
        CP	L
        JR	Z,J69B4
        LD	A,(HL)
        LD	(DE),A
        CALL	C585B
        INC	DE
        INC	B
        JR	J69A5

J69B4:	POP	DE
        LD	A,B
        AND	A
        JR	Z,J69C8
        LD	HL,(GETPNT)
        LD	(PUTPNT),HL
J69BF:	LD	A,(DE)
        PUSH	BC
        CALL	C583C
        POP	BC
        INC	DE
        DJNZ	J69BF
J69C8:	EI
        POP	AF
        POP	HL
        RET

;	  Subroutine __________________________
;	     Inputs  ________________________
;	     Outputs ________________________

C69CC:	CALL	C6B2A			; interlace mode ?
        RET	NC			; yep, quit
        BIT	2,(IY+8)
        JR	NZ,C69DB
        XOR	A
        LD	(CNSDFG),A
        RET

;	  Subroutine __________________________
;	     Inputs  ________________________
;	     Outputs ________________________

C69DB:	PUSH	IY
        PUSH	IX
        CALL	C4A97
        POP	IX
        POP	IY
        SCF
        RET

;	  Subroutine __________________________
;	     Inputs  ________________________
;	     Outputs ________________________

C69E8:	SET	2,(IY+8)
        LD	A,(CNSDFG)
        AND	A
        RET	NZ
        CALL	C6B2A			; interlace mode ?
        RET	NC			; yep, quit
        RES	2,(IY+8)
        LD	A,(CSRY)
        LD	B,A
        LD	A,(CRTCNT)
I6A00:	CP	B
        JR	NZ,J6A13
        LD	L,01H	; 1
        PUSH	IY
        CALL	C497B
        POP	IY
        LD	A,(CSRY)
        DEC	A
        LD	(CSRY),A
J6A13:	LD	A,0FFH
        LD	(CNSDFG),A
        RET

;	  Subroutine MSX-JE function
;	     Inputs  ________________________
;	     Outputs ________________________

C6A19:	PUSH	IY
        PUSH	IX
        CALL	C6A27
        EI
        NOP
        POP	IX
        POP	IY
        RET

;	  Subroutine __________________________
;	     Inputs  ________________________
;	     Outputs ________________________

C6A27:	EXX
        EX	AF,AF'
        LD	HL,0
        ADD	HL,SP
        LD	A,H
        CP	0C1H
        JR	NC,C6A44
        EX	DE,HL
        PUSH	IY
        POP	HL
        LD	BC,0161H
        ADD	HL,BC
        LD	SP,HL
        PUSH	DE
        CALL	C6A44
        EXX
        POP	HL
        LD	SP,HL
        EXX
        RET

;	  Subroutine __________________________
;	     Inputs  ________________________
;	     Outputs ________________________

C6A44:	EX	AF,AF'
        EXX
        JP	(IY)

;	  Subroutine __________________________
;	     Inputs  ________________________
;	     Outputs ________________________

C6A48:	LD	A,(IX+2)
        PUSH	AF
        LD	(IX+2),00H
        CALL	C6A58
        POP	AF
        LD	(IX+2),A
        RET

;	  Subroutine __________________________
;	     Inputs  ________________________
;	     Outputs ________________________

C6A58:	CALL	C6A76
J6A5B:	LD	A,(HL)
        INC	HL
        AND	A
        JR	Z,C6A76
        CALL	C6A85
        JR	J6A5B

;	  Subroutine __________________________
;	     Inputs  ________________________
;	     Outputs ________________________

C6A65:	CALL	C79B9			; get japanese input frontend processor area
        BIT	0,(IY+8)
        RET	Z
        CALL	C79B9			; get japanese input frontend processor area
        JP	Z,C785C			; not a MSX-JE,

;	  Subroutine __________________________
;	     Inputs  ________________________
;	     Outputs ________________________

C6A73:	CALL	C6AC7

;	  Subroutine __________________________
;	     Inputs  ________________________
;	     Outputs ________________________

C6A76:	PUSH	HL
        CALL	C6B14
        LD	E,00H
        PUSH	IY
        CALL	C5C8E
        POP	IY
        POP	HL
        RET

;	  Subroutine __________________________
;	     Inputs  ________________________
;	     Outputs ________________________

C6A85:	CP	0CH	; 12
        JR	Z,C6AC7
        CP	05H	; 5
        JR	Z,J6ACB
        CP	08H	; 8
        JR	Z,J6AD8
        CP	12H	; 18
        JR	Z,J6AEA
        CP	18H
        JR	Z,J6AED
        CP	1AH
        JR	Z,J6AF3
        CP	10H	; 16
        RET	C
        CP	20H	; " "
        INC	HL
        RET	C
        DEC	HL
        PUSH	HL
        LD	HL,(FORCLR)
        PUSH	HL
        LD	L,(IY+12)
        LD	H,(IY+13)
        LD	(FORCLR),HL
        LD	C,A
        CALL	C6B14
        PUSH	IY
        CALL	C5864
        POP	IY
        INC	(IY+11)
        POP	HL
        LD	(FORCLR),HL
        POP	HL
        RET

;	  Subroutine __________________________
;	     Inputs  ________________________
;	     Outputs ________________________

C6AC7:	LD	(IY+11),01H	; 1
J6ACB:	PUSH	HL
        CALL	C6B14
        PUSH	IY
        CALL	C5FB0
        POP	IY
        POP	HL
        RET

J6AD8:	PUSH	HL
        DEC	(IY+11)
        CALL	C6B14
        LD	C,20H	; " "
        PUSH	IY
        CALL	C5864
        POP	IY
        POP	HL
        RET

J6AEA:	LD	A,(HL)
        INC	HL
        RET

J6AED:	LD	A,(HL)
        INC	HL
        LD	(IY+11),A
        RET

J6AF3:	LD	A,(IX+0)
        AND	07H			; b2-b0
        CP	7
        LD	A,(HL)
        JR	Z,J6B0B
        AND	0FH	; 15
        LD	(IY+13),A
        LD	A,(HL)
        RRCA
        RRCA
        RRCA
        RRCA
        AND	0FH	; 15
        JR	J6B0F

J6B0B:	LD	(IY+13),A
        CPL
J6B0F:	LD	(IY+12),A
        INC	HL
        RET

;	  Subroutine __________________________
;	     Inputs  ________________________
;	     Outputs ________________________

C6B14:	LD	HL,(CRTCNT)
        LD	H,(IY+11)
        CALL	C6B2A			; interlace mode ?
        RET	C			; nope, quit
        LD	L,25
        RET

;	  Subroutine __________________________
;	     Inputs  ________________________
;	     Outputs ________________________

C6B21:	CALL	C79B9			; get japanese input frontend processor area
        BIT	0,(IY+8)
        SCF
        RET	Z

;	  Subroutine interlace mode ?
;	     Inputs  ________________________
;	     Outputs ________________________

C6B2A:	LD	A,(IX+0)
        AND	07H			; b2-b0
        CP	4
        RET	C
        LD	A,(IX+0)
        BIT	7,A
        RET	NZ			; interlace mode, quit
        SCF
        RET

;	  Subroutine __________________________
;	     Inputs  ________________________
;	     Outputs ________________________

C6B3A:	PUSH	IY
        POP	HL
        LD	BC,97
        ADD	HL,BC
        EX	DE,HL
        PUSH	DE
        LD	HL,NORUSE
        DI
        SET	5,(HL)
        LD	HL,(GETPNT)
        LD	B,00H
J6B4E:	LD	A,(PUTPNT)
        CP	L
        JR	Z,J6B5D
        LD	A,(HL)
        LD	(DE),A
        CALL	C585B
        INC	DE
        INC	B
        JR	J6B4E

J6B5D:	POP	DE
        LD	A,B
        AND	A
        JR	Z,J6B93
        LD	HL,(GETPNT)
J6B65:	LD	A,(DE)
        CALL	C4908			; double byte header character ?
        JR	C,J6B89			; nope,
        DEC	B
        JR	Z,J6B90
        PUSH	BC
        LD	B,A
        INC	DE
        LD	A,(DE)
        LD	C,A
        CALL	C61C2
        CP	04H	; 4
        LD	A,C
        POP	BC
        JR	NZ,J6B8D
        PUSH	HL
        PUSH	BC
        LD	C,A
        LD	B,00H
        LD	HL,I731B
        ADD	HL,BC
        ADD	HL,BC
        LD	A,(HL)
        POP	BC
        POP	HL
J6B89:	LD	(HL),A
        CALL	C585B
J6B8D:	INC	DE
        DJNZ	J6B65
J6B90:	LD	(PUTPNT),HL
J6B93:	EI
        RET

;	  Subroutine H.LPTO handler
;	     Inputs  ________________________
;	     Outputs ________________________

A6B95:	EI
        PUSH	HL
        LD	HL,RAWPRT
        INC	(HL)
        DEC	(HL)			; do character conversion ?
        POP	HL
        RET	NZ			; nope, quit
        PUSH	AF
        PUSH	AF
        CALL	C4099			; get my SLTWRK entry
        LD	A,(IX+3)
        AND	A			; previous character a double byte header ?
        LD	(IX+3),0
        JR	NZ,J6BCF		; yep,
        POP	AF
        CP	0DH
        JR	Z,J6BC1			; CR,
        CP	20H
        CCF
        JR	NC,J6BC4		; other control character,
        CALL	C4908			; double byte header character ?
        JR	C,J6BC9			; nope,
        LD	(IX+3),A		; save header character
        JR	J6BEA

J6BC1:	CALL	C6C0B			; disable ESC "K" mode
J6BC4:	CALL	NC,C6C25		; not aborted, character to printer with hook disabled
        JR	J6BEA

J6BC9:	PUSH	HL
        PUSH	BC
        LD	C,A
        XOR	A
        JR	J6BDE

J6BCF:	EX	(SP),HL
        PUSH	BC
        LD	B,A			; 1st double byte character
        LD	C,H			; 2nd double byte character
        CALL	C61C2
        LD	B,A
        LD	A,C
        ADD	A,20H
        LD	C,A
        LD	A,B
        ADD	A,20H
J6BDE:	CALL	C6BF1			; enable ESC "K" mode
        CALL	NC,C6C25		; no error, character to printer with hook disabled
        LD	A,C
        CALL	NC,C6C25		; no error, character to printer with hook disabled
        POP	BC
        POP	HL
J6BEA:	EX	(SP),HL
        LD	A,H
        POP	HL
        CALL	C4504			; replace return address with quit routine
        RET

;	  Subroutine enable ESC "K" mode
;	     Inputs  ________________________
;	     Outputs ________________________

C6BF1:	AND	A
        BIT	4,(IX+1)		; in ESC "K" mode ?
        RET	NZ			; yep, quit
        PUSH	BC
        LD	B,A
        LD	A,1BH
        CALL	C6C25			; character to printer with hook disabled
        LD	A,"K"
        CALL	NC,C6C25		; not aborted, character to printer with hook disabled
        LD	A,B
        POP	BC
        RET	C
        SET	4,(IX+1)
        RET

;	  Subroutine disable ESC "K" mode
;	     Inputs  ________________________
;	     Outputs ________________________

C6C0B:	AND	A
        BIT	4,(IX+1)		; in ESC "K" mode ?
        RET	Z			; nope, quit
        PUSH	BC
        LD	B,A
        LD	A,1BH
        CALL	C6C25			; character to printer with hook disabled
        LD	A,"H"
        CALL	NC,C6C25		; not aborted, character to printer with hook disabled
        LD	A,B
        POP	BC
        RET	C
        RES	4,(IX+1)
        RET

;	  Subroutine character to printer with hook disabled
;	     Inputs  ________________________
;	     Outputs ________________________

C6C25:	PUSH	AF
        LD	A,0C9H
        LD	(H.LPTO+0),A
        POP	AF
        CALL	LPTOUT
        CALL	C,C6C38			; aborted, force end of ESC "K" mode
        LD	A,0F7H
        LD	(H.LPTO+0),A
        RET

;	  Subroutine force end of ESC "K" mode
;	     Inputs  ________________________
;	     Outputs ________________________

C6C38:	BIT	4,(IX+1)
        SCF
        RET	Z
J6C3E:	LD	IX,BREAKX
        CALL	C6C71			; check if CTRL-STOP
        JR	C,J6C3E			; yep, wait until released
        LD	IX,LPTSTT
        CALL	C6C71			; printer ready ?
        SCF
        RET	Z			; nope, quit
        LD	A,0DH
        CALL	C6C6D			; CR to printer
        EI
        NOP
        JR	C,J6C3E			; aborted by CTRL-STOP,
        LD	A,1BH
        CALL	C6C6D			; ESC to printer
        JR	C,J6C3E			; aborted by CTRL-STOP,
        LD	A,"H"
        CALL	C6C6D			; "H" to printer
        JR	C,J6C3E			; aborted by CTRL-STOP,
        RES	4,(IX+1)
        SCF
        RET

;	  Subroutine character to printer
;	     Inputs  ________________________
;	     Outputs ________________________

C6C6D:	LD	IX,LPTOUT

;	  Subroutine __________________________
;	     Inputs  ________________________
;	     Outputs ________________________

C6C71:	JP	C44E2

A6C74:	CALL	C70CD
        PUSH	DE
        CALL	C711C			; evaluate string expression and get size and address
        PUSH	DE
        LD	C,00H
        LD	A,B
        AND	A
        JR	Z,J6CBE
        LD	DE,BUF
        PUSH	HL
        POP	IX
J6C88:	LD	A,(IX+0)
        INC	IX
        CALL	C4908			; double byte header character ?
        JP	NC,J6CA8		; yep,
        CALL	C6CCA
        JR	C,J6CB6
        PUSH	BC
        LD	B,H
        LD	C,L
        CALL	C70AB
        LD	H,B
        LD	L,C
        POP	BC
        LD	A,H
        LD	(DE),A
        INC	DE
        INC	C
        LD	A,L
        JR	J6CB6

J6CA8:	LD	(DE),A
        INC	DE
        INC	C
        JP	Z,J70D4
        DEC	B
        JR	Z,J6CBE
        LD	A,(IX+0)
        INC	IX
J6CB6:	LD	(DE),A
        INC	DE
        INC	C
        JP	Z,J70D4
        DJNZ	J6C88
J6CBE:	POP	HL
        EX	(SP),HL
        LD	A,C
        CALL	C7130			; allocate string to variable
        POP	HL
        CALL	C70FA
        DEFB	")"
        RET

;	  Subroutine __________________________
;	     Inputs  ________________________
;	     Outputs ________________________

C6CCA:	CP	0A6H
        JR	C,C6D26
        CP	0B0H
        JR	Z,C6D26
        CP	0DEH
        JR	NC,C6D26
        CP	0DCH
        LD	HL,256FH
        RET	Z
        CP	0B3H
        JR	NZ,J6CF5
        LD	A,B
        DEC	A
        LD	HL,2526H
        RET	Z
        LD	A,(IX+0)
        CP	0DEH
        SCF
        CCF
        RET	NZ
        INC	IX
        DEC	B
        LD	HL,2574H
        RET

J6CF5:	PUSH	DE
        LD	E,20H	; " "
        LD	HL,I731B
J6CFB:	INC	E
        INC	HL
        INC	HL
        CP	(HL)
        JR	NZ,J6CFB
        PUSH	DE
        LD	A,B
        DEC	A
        JR	Z,J6D20
        LD	A,(IX+0)
        CP	0DEH
        JR	Z,J6D14
        CP	0DFH
        JR	NZ,J6D20
        INC	E
        INC	HL
        INC	HL
J6D14:	INC	E
        INC	HL
        INC	HL
        INC	HL
        CP	(HL)
        JR	NZ,J6D20
        POP	AF
        DEC	B
        INC	IX
        PUSH	DE
J6D20:	POP	HL
        LD	H,25H	; "%"
        POP	DE
        AND	A
        RET

;	  Subroutine __________________________
;	     Inputs  ________________________
;	     Outputs ________________________

C6D26:	CP	30H	; "0"
        JR	C,J6D2E
        CP	3AH	; ":"
        JR	C,J6D3E
J6D2E:	CP	41H	; "A"
        JR	C,J6D36
        CP	5BH	; "["
        JR	C,J6D3E
J6D36:	CP	61H	; "a"
        JR	C,J6D43
        CP	7BH	; "{"
        JR	NC,J6D43
J6D3E:	LD	H,23H	; "#"
        LD	L,A
        AND	A
        RET

J6D43:	PUSH	BC
        LD	HL,T73F3+02AH-1
        LD	BC,002AH
        CPDR
        LD	L,C
        LD	H,B
        POP	BC
        SCF
        RET	NZ
        PUSH	BC
        LD	BC,T73C9
        ADD	HL,BC
        POP	BC
        LD	L,(HL)
        LD	H,21H	; "!"
        RET

A6D5B:	CALL	C70CD
        PUSH	DE
        CALL	C711C			; evaluate string expression and get size and address
        PUSH	DE
        LD	C,00H
        LD	A,B
        AND	A
        JP	Z,J6DE7
        LD	DE,BUF
        PUSH	HL
        POP	IX
J6D70:	LD	A,(IX+0)
        INC	IX
        CALL	C4908			; double byte header character ?
        JR	C,J6DE2			; nope,
        LD	H,A
        LD	A,B
        DEC	A
        LD	A,H
        JR	Z,J6DE2
        LD	L,(IX+0)
        INC	IX
        DEC	B
        PUSH	BC
        LD	B,H
        LD	C,L
        CALL	C70A0
        LD	H,B
        LD	L,C
        POP	BC
        LD	A,H
        CP	21H	; "!"
        JR	NZ,J6DAE
        LD	A,L
        PUSH	HL
        PUSH	BC
        LD	HL,T73C9+02AH-1
        LD	BC,002AH
        CPDR
        JR	NZ,J6DAA
        LD	HL,T73F3
        ADD	HL,BC
        LD	A,(HL)
        POP	BC
        POP	HL
        JR	J6DB3

J6DAA:	POP	BC
        POP	HL
        JR	J6DD4

J6DAE:	CP	23H	; "#"
        JR	NZ,J6DB8
        LD	A,L
J6DB3:	LD	HL,I6DC1
        JR	J6DCA

J6DB8:	CP	24H	; "$"
        JR	Z,J6DC0
        CP	25H	; "%"
        JR	NZ,J6DD4
J6DC0:	PUSH	BC
I6DC1:	LD	H,00H
        ADD	HL,HL
        LD	BC,I72DB
        ADD	HL,BC
        POP	BC
        LD	A,(HL)
J6DCA:	LD	(DE),A
        INC	DE
        INC	C
        INC	HL
        LD	A,(HL)
        AND	A
        JR	NZ,J6DE2
        JR	J6DE5

J6DD4:	PUSH	BC
        LD	B,H
        LD	C,L
        CALL	C70AB
        LD	H,B
        LD	L,C
        POP	BC
        LD	A,H
        LD	(DE),A
        INC	DE
        INC	C
        LD	A,L
J6DE2:	LD	(DE),A
        INC	DE
        INC	C
J6DE5:	DJNZ	J6D70
J6DE7:	POP	HL
        EX	(SP),HL
        LD	A,C
        CALL	C7130			; allocate string to variable
        POP	HL
        CALL	C70FA
        DEFB	")"
        RET

A6DF3:	CALL	C70CD
        PUSH	DE
        CALL	C711C			; evaluate string expression and get size and address
        PUSH	DE
        LD	A,(HL)
        CALL	C4908			; double byte header character ?
        JR	C,J6E18			; nope,
        LD	A,B
        CP	02H	; 2
        JP	C,J70D7
        SCF
        JR	J6E27

A6E0A:	CALL	C70CD
        PUSH	DE
        CALL	C711C			; evaluate string expression and get size and address
        PUSH	DE
        LD	A,(HL)
        CALL	C4908			; double byte header character ?
        JR	NC,J6E21		; yep,
J6E18:	DEC	B
        INC	B
        JP	Z,J70D7
        LD	C,02H	; 2
        JR	J6E37

J6E21:	LD	A,B
        CP	02H	; 2
        JP	C,J70D7
J6E27:	LD	B,(HL)
        INC	HL
        LD	C,(HL)
        CALL	NC,C70A0
        LD	A,C
        CALL	C7155
        LD	(BUF+2),HL
        LD	C,04H	; 4
        LD	A,B
J6E37:	CALL	C7155
        LD	(BUF+0),HL
        POP	HL
        EX	(SP),HL
        LD	A,C
        CALL	C7130			; allocate string to variable
        POP	HL
        CALL	C70FA
        DEFB	")"
        RET

A6E49:	CALL	C70CD
        PUSH	DE
        CALL	C711C			; evaluate string expression and get size and address
        PUSH	BC
        PUSH	HL
        EX	DE,HL
        CALL	C70FA
        DEFB	","
        CALL	C7113			; evaluate byte operand
        CP	02H
        JP	NC,J70D7
        POP	IX
        POP	BC
        PUSH	HL
        LD	L,A
        LD	C,00H
        LD	A,B
        AND	A
        JR	Z,J6E96
        LD	DE,BUF
J6E6D:	LD	A,(IX+0)
        INC	IX
        CALL	C4908			; double byte header character ?
        BIT	0,L
        JR	Z,J6E88
        JR	C,J6E94			; nope,
        LD	(DE),A
        INC	DE
        INC	C
        DEC	B
        JR	Z,J6E96
        LD	A,(IX+0)
        INC	IX
        JR	J6E91

J6E88:	JR	C,J6E91
        DEC	B
        JR	Z,J6E96
        INC	IX
        JR	J6E94

J6E91:	LD	(DE),A
        INC	DE
        INC	C
J6E94:	DJNZ	J6E6D
J6E96:	POP	HL
        EX	(SP),HL
        LD	A,C
        CALL	C7130			; allocate string to variable
        POP	HL
        CALL	C70FA
        DEFB	")"
        RET

A6EA2:	CALL	C70CD
        PUSH	DE
        CALL	C711C			; evaluate string expression and get size and address
        PUSH	HL
        PUSH	BC
        EX	DE,HL
        CALL	C70FA
        DEFB	","
        CALL	C7113			; evaluate byte operand
        AND	A
        JP	Z,J70D7
        PUSH	AF
        LD	A,(HL)
        CP	2CH	; ","
        LD	E,0FFH
        JR	NZ,J6EC5
        CALL	C7101			; get next BASIC character
        CALL	C7113			; evaluate byte operand
J6EC5:	POP	AF
        LD	D,A
        POP	BC
        EX	(SP),HL
        LD	C,00H
        LD	A,B
        AND	A
        JR	Z,J6F06
        LD	A,E
        AND	A
        JR	Z,J6F06
J6ED3:	DEC	D
        JR	Z,J6EE5
        LD	A,(HL)
        INC	HL
        CALL	C4908			; double byte header character ?
        JR	C,J6EE1			; nope,
        DEC	B
        JR	Z,J6F06
        INC	HL
J6EE1:	DJNZ	J6ED3
        JR	J6F06

J6EE5:	LD	IX,BUF
J6EE9:	LD	A,(HL)
        LD	(IX+0),A
        INC	HL
        INC	IX
        INC	C
        CALL	C4908			; double byte header character ?
        JR	C,J6F01			; nope,
        DEC	B
        JR	Z,J6F06
        LD	A,(HL)
        LD	(IX+0),A
        INC	HL
        INC	IX
        INC	C
J6F01:	DEC	E
        JR	Z,J6F06
        DJNZ	J6EE9
J6F06:	POP	HL
        EX	(SP),HL
        LD	A,C
        CALL	C7130			; allocate string to variable
        POP	HL
        CALL	C70FA
        DEFB	")"
        RET

A6F12:	CALL	C70CD
        PUSH	DE
        CALL	C711C			; evaluate string expression and get size and address
        PUSH	DE
        LD	A,B
        CP	04H	; 4
        JP	NZ,J70D7
        LD	D,(HL)
        INC	HL
        LD	E,(HL)
        INC	HL
        CALL	C7168
        LD	B,A
        LD	D,(HL)
        INC	HL
        LD	E,(HL)
        CALL	C7168
        LD	C,A
        BIT	7,B
        CALL	P,C70AB
        LD	A,B
        LD	(BUF+0),A
        LD	A,C
        LD	(BUF+1),A
        POP	HL
        EX	(SP),HL
        LD	A,02H	; 2
        CALL	C7130			; allocate string to variable
        POP	HL
        CALL	C70FA
        DEFB	")"
        RET

A6F49:	CALL	C70C7
        PUSH	DE
        PUSH	AF
        CALL	C710D			; evaluate expression
        LD	A,(VALTYP)
        CP	3
        LD	A,1
        JR	Z,J6F76
        INC	A
        PUSH	HL
        CALL	C7107			; convert to DAC to new type
        LD	HL,(DAC+2)
        LD	A,H
        AND	A
        JP	NZ,J70D7
        LD	A,L
        AND	A
        JP	Z,J70D7
        POP	HL
        PUSH	AF
        CALL	C70FA
        DEFB	","
        CALL	C710D			; evaluate expression
        POP	AF
J6F76:	PUSH	AF
        CALL	C711F			; get size and address of string
        PUSH	HL
        PUSH	BC
        EX	DE,HL
        CALL	C70FA
        DEFB	","
        CALL	C711C			; evaluate string expression and get size and address
        POP	IX
        POP	IY
        POP	AF
        PUSH	DE
        PUSH	HL
        PUSH	BC
        PUSH	IX
        POP	BC
        PUSH	IY
        POP	HL
        LD	D,A
        LD	C,00H
        LD	A,B
        AND	A
        JR	Z,J6FDF
J6F99:	INC	C
        DEC	D
        JR	Z,J6FAC
        LD	A,(HL)
        INC	HL
        CALL	C4908			; double byte header character ?
        JR	C,J6FA8			; nope,
        DEC	B
        JR	Z,J6FDF
        INC	HL
J6FA8:	DJNZ	J6F99
        JR	J6FDF

J6FAC:	POP	AF
        POP	DE
        PUSH	BC
        EX	(SP),HL
        LD	H,L
        EX	(SP),HL
        LD	C,A
J6FB3:	PUSH	BC
        PUSH	DE
        PUSH	HL
J6FB6:	LD	A,C
        AND	A
        JR	Z,J6FE5
        LD	A,B
        AND	A
        JR	Z,J6FDD
        LD	A,(DE)
        CP	(HL)
        JR	NZ,J6FC8
        INC	DE
        INC	HL
        DEC	B
        DEC	C
        JR	J6FB6

J6FC8:	POP	HL
        POP	DE
        POP	BC
        POP	AF
        INC	A
        PUSH	AF
        LD	A,(HL)
        INC	HL
        CALL	C4908			; double byte header character ?
        JR	C,J6FD9			; nope,
        DEC	B
        JR	Z,J6FE0
        INC	HL
J6FD9:	DJNZ	J6FB3
        JR	J6FE0

J6FDD:	POP	AF
        POP	AF
J6FDF:	POP	AF
J6FE0:	POP	AF
        XOR	A
        JP	J7064

J6FE5:	POP	AF
        POP	AF
        POP	AF
        POP	AF
        JR	J7064

A6FEB:	CALL	C70C7
        PUSH	DE
        PUSH	AF
        CALL	C711C			; evaluate string expression and get size and address
        PUSH	HL
        PUSH	BC
        EX	DE,HL
        LD	A,(HL)
        CP	2CH	; ","
        LD	A,00H
        JR	NZ,J7003
        CALL	C7101			; get next BASIC character
        CALL	C7113			; evaluate byte operand
J7003:	CP	03H	; 3
        JR	NC,J7059
        POP	BC
        EX	(SP),HL
        LD	D,A
        LD	C,00H
        LD	E,00H
        LD	A,B
        AND	A
        JR	Z,J7021
J7012:	LD	A,(HL)
        INC	HL
        INC	C
        CALL	C4908			; double byte header character ?
        JR	C,J701F			; nope,
        DEC	B
        JR	Z,J7021
        INC	E
        INC	HL
J701F:	DJNZ	J7012
J7021:	DEC	D
        LD	A,C
        JP	M,J7064
        LD	A,E
        JR	NZ,J7064
        LD	A,C
        SUB	E
        JR	J7064

A702D:	CALL	C70C7
        PUSH	DE
        PUSH	AF
        CALL	C711C			; evaluate string expression and get size and address
        LD	A,B
        AND	A
        JR	Z,J7059
        PUSH	HL
        PUSH	BC
        EX	DE,HL
        CALL	C70FA
        DEFB	","
        CALL	C7113			; evaluate byte operand
        AND	A
        JR	Z,J7059
        POP	BC
        EX	(SP),HL
        LD	C,A
J7049:	DEC	C
        JR	Z,J705C
        LD	A,(HL)
        INC	HL
        CALL	C4908			; double byte header character ?
        JR	C,J7057			; nope,
        DEC	B
        JR	Z,J7059
        INC	HL
J7057:	DJNZ	J7049
J7059:	JP	J70D7

J705C:	LD	A,(HL)
        CALL	C4908			; double byte header character ?
        CCF
        LD	A,00H
        RLA
J7064:	LD	C,A
        POP	HL
        POP	AF
        EX	(SP),HL
        LD	(VALTYP),A
        LD	B,00H
        LD	(DAC+2),BC
        CALL	C707A
        POP	HL
        CALL	C70FA
        DEFB	")"
        RET

;	  Subroutine __________________________
;	     Inputs  ________________________
;	     Outputs ________________________

C707A:	PUSH	HL
        LD	HL,VALTYP
        LD	A,(HL)
        LD	C,A
        LD	(HL),2
        LD	HL,DAC+2
        CP	02H	; 2
        JR	Z,J709A
        CP	04H	; 4
        JR	Z,J7092
        CP	08H	; 8
        JP	NZ,J70D1
J7092:	PUSH	BC
        CALL	C7107			; convert to DAC to new type
        POP	BC
        LD	HL,DAC
J709A:	LD	B,0
        POP	DE
        LDIR
        RET

;	  Subroutine __________________________
;	     Inputs  ________________________
;	     Outputs ________________________

C70A0:	CALL	C61C2
        ADD	A,20H	; " "
        LD	B,A
        LD	A,C
        ADD	A,20H	; " "
        LD	C,A
        RET

;	  Subroutine __________________________
;	     Inputs  ________________________
;	     Outputs ________________________

C70AB:	LD	A,B
        DEC	A
        SRL	A
        ADD	A,71H	; "q"
        CP	0A0H
        JR	C,J70B7
        ADD	A,40H	; "@"
J70B7:	BIT	0,B
        LD	B,A
        LD	A,C
        JR	NZ,J70BF
        ADD	A,5EH	; "^"
J70BF:	ADD	A,1FH
        LD	C,A
        CP	7FH
        RET	C
J70C5:	INC	C
        RET

;	  Subroutine __________________________
;	     Inputs  ________________________
;	     Outputs ________________________

C70C7:	CALL	C70E3
        RET	NZ
        JR	J70D1

;	  Subroutine __________________________
;	     Inputs  ________________________
;	     Outputs ________________________

C70CD:	CALL	C70E3
        RET	Z
J70D1:	LD	E,13
        DEFB	1
J70D4:	LD	E,15
        DEFB	1
J70D7:	LD	E,5
        DEFB	1
J70DA:	LD	E,2
        LD	IX,M406F
        JP	CALBAS			; BASIC error

;	  Subroutine __________________________
;	     Inputs  ________________________
;	     Outputs ________________________

C70E3:	CALL	C70FA
        DEFB	"("
        LD	IX,M5EA4
        CALL	CALBAS			; locate variable
        EI
        NOP
        CALL	C70FA
        DEFB	","
        LD	A,(VALTYP)
        CP	3
        RET

;	  Subroutine check for BASIC character
;	     Inputs  ________________________
;	     Outputs ________________________

C70FA:	LD	A,(HL)
        EX	(SP),HL
        CP	(HL)
        INC	HL
        EX	(SP),HL
        JR	NZ,J70DA

;	  Subroutine get next BASIC character
;	     Inputs  ________________________
;	     Outputs ________________________

C7101:	LD	IX,M4666
        JR	J7117

;	  Subroutine convert to DAC to new type
;	     Inputs  ________________________
;	     Outputs ________________________

C7107:	LD	IX,M517A
        JR	J7117

;	  Subroutine evaluate expression
;	     Inputs  ________________________
;	     Outputs ________________________

C710D:	LD	IX,M4C64
        JR	J7117

;	  Subroutine evaluate byte operand
;	     Inputs  ________________________
;	     Outputs ________________________

C7113:	LD	IX,M521C
J7117:	CALL	CALBAS
        EI
        RET

;	  Subroutine evaluate string expression and get size and address
;	     Inputs  ________________________
;	     Outputs ________________________

C711C:	CALL	C710D			; evaluate expression

;	  Subroutine get size and address of string
;	     Inputs  ________________________
;	     Outputs ________________________

C711F:	PUSH	HL
        LD	IX,M67D0
        CALL	CALBAS			; free temporary string
        EI
        LD	B,(HL)
        INC	HL
        LD	A,(HL)
        INC	HL
        LD	H,(HL)
        LD	L,A
        POP	DE
        RET

;	  Subroutine allocate string to variable
;	     Inputs  ________________________
;	     Outputs ________________________

C7130:	PUSH	HL
        PUSH	AF
        LD	IX,M6627
        CALL	CALBAS			; allocate temporary string
        EI
        NOP
        LD	DE,(DSCTMP+1)
        LD	HL,BUF
        POP	AF
        AND	A
        JR	Z,J714B
        LD	C,A
        LD	B,0
        LDIR
J714B:	POP	DE
        LD	HL,DSCTMP
        LD	BC,3
        LDIR
        RET

;	  Subroutine __________________________
;	     Inputs  ________________________
;	     Outputs ________________________

C7155:	PUSH	AF
        RRCA
        RRCA
        RRCA
        RRCA
        CALL	C715F
        LD	L,A
        POP	AF
;	  Subroutine __________________________
;	     Inputs  ________________________
;	     Outputs ________________________

C715F:	AND	0FH	; 15
        CP	0AH	; 10
        SBC	A,69H	; "i"
        DAA
        LD	H,A
        RET

;	  Subroutine __________________________
;	     Inputs  ________________________
;	     Outputs ________________________

C7168:	LD	A,D
        CALL	C7177
        ADD	A,A
        ADD	A,A
        ADD	A,A
        ADD	A,A
        LD	D,A
        LD	A,E
        CALL	C7177
        OR	D
        RET

;	  Subroutine __________________________
;	     Inputs  ________________________
;	     Outputs ________________________

C7177:	SUB	30H	; "0"
        JR	C,J71DA
        CP	0AH	; 10
        RET	C
        SUB	07H	; 7
        CP	0AH	; 10
        JR	C,J71DA
        CP	10H	; 16
        RET	C
        SUB	20H	; " "
        CP	0AH	; 10
        JR	C,J71DA
        CP	10H	; 16
        RET	C
        JR	J71DA

A7192:	LD	A,(IDBYT2)
        AND	A			; msx 1 ?
        JR	Z,J71DA			; yep
        DEC	HL
        CALL	C7101			; get next BASIC character
        JR	Z,J71DD
        CALL	C70FA
        DEFB	"("
        LD	A,0FH
        CALL	C71D2
        PUSH	AF
        CALL	C71CC
        ADD	A,A
        ADD	A,A
        ADD	A,A
        ADD	A,A
        PUSH	AF
        CALL	C71CC
        POP	BC
        LD	C,A
        PUSH	BC
        CALL	C71CC
        POP	DE
        OR	D
        LD	D,A
        CALL	C70FA
        DEFB	")"
        POP	BC
        CALL	C71F1
        OUT	(C),D
        EX	(SP),HL
        EX	(SP),HL
        OUT	(C),E
        EI
        RET

;	  Subroutine __________________________
;	     Inputs  ________________________
;	     Outputs ________________________

C71CC:	CALL	C70FA
        DEFB	","
        LD	A,07H	; 7

;	  Subroutine __________________________
;	     Inputs  ________________________
;	     Outputs ________________________

C71D2:	PUSH	AF
        CALL	C7113			; evaluate byte operand
        POP	AF
        CP	E
        LD	A,E
        RET	NC
J71DA:	JP	J70D7

J71DD:	PUSH	HL
        LD	B,00H
        CALL	C71F1
        LD	HL,I71FD
        LD	B,32
J71E8:	OUTI
        EX	(SP),HL
        EX	(SP),HL
        JR	NZ,J71E8
        EI
        POP	HL
        RET

;	  Subroutine __________________________
;	     Inputs  ________________________
;	     Outputs ________________________

C71F1:	LD	C,10H	; 16
        CALL	WRTVDP
        LD	A,(D0006)
        ADD	A,02H	; 2
        LD	C,A
        RET

I71FD:	DEFB    00H,00H,00H,00H,11H,06H,33H,07H
        DEFB	17H,01H,27H,03H,51H,01H,27H,06H
	DEFB	71H,01H,73H,03H,61H,06H,64H,06H
	DEFB	11H,04H,65H,02H,55H,05H,77H,07H

I721D:	DEFB	00H,04H,08H,0CH,08H,0CH,08H,0CH
        DEFB	10H,14H,18H,1CH,18H,1CH,18H,1CH
	DEFB	20H,24H,28H,2CH,28H,2CH,28H,2CH
	DEFB	30H,34H,38H,3CH,38H,3CH,38H,3CH
	DEFB	40H,44H,48H,4CH,48H,4CH,48H,4CH
	DEFB	50H,54H,58H,5CH,58H,5CH,58H,5CH
	DEFB	60H,64H,68H,6CH,68H,6CH,68H,6CH
	DEFB	70H,74H,78H,7CH,78H,7CH,78H,7CH
	DEFB	40H,44H,48H,4CH,48H,4CH,48H,4CH
	DEFB	50H,54H,58H,5CH,58H,5CH,58H,5CH
	DEFB	60H,64H,68H,6CH,68H,6CH,68H,6CH
	DEFB	70H,74H,78H,7CH,78H,7CH,78H,7CH
	DEFB	40H,44H,48H,4CH,48H,4CH,48H,4CH
	DEFB	50H
        DEFB    54H,58H,5CH,58H,5CH,58H,5CH
	DEFB	60H,64H,68H,6CH,68H,6CH,68H,6CH
	DEFB	70H,74H,78H,7CH,78H,7CH,78H,7CH
	DEFB	80H,84H,88H,8CH,88H,8CH,88H,8CH
	DEFB	90H,94H,98H,9CH,98H,9CH,98H,9CH
	DEFB	0A0H,0A4H,0A8H,0ACH,0A8H,0ACH,0A8H,0ACH
	DEFB	0B0H,0B4H,0B8H,0BCH,0B8H,0BCH,0B8H,0BCH
	DEFB	0C0H,0C4H,0C8H,0CCH,0C8H,0CCH,0C8H,0CCH
	DEFB	0D0H,0D4H,0D8H,0DCH,0D8H,0DCH,0D8H,0DCH
	DEFB	0E0H,0E4H,0E8H,0ECH,0E8H,0ECH,0E8H,0ECH
	DEFB	0F0H,0F4H,0F8H,0FCH,0F8H,0FCH
I72DB:  DEFB    0F8H,0FCH
	DEFB	0C0H,0C4H,0C8H,0CCH,0C8H,0CCH,0C8H,0CCH
	DEFB	0D0H,0D4H,0D8H,0DCH,0D8H,0DCH,0D8H,0DCH
	DEFB	0E0H,0E4H,0E8H,0ECH,0E8H,0ECH,0E8H,0ECH
	DEFB	0F0H,0F4H,0F8H,0FCH,0F8H,0FCH,0F8H,0FCH
	DEFB	0C0H,0C4H,0C8H,0CCH,0C8H,0CCH,0C8H,0CCH
	DEFB	0D0H,0D4H,0D8H,0DCH,0D8H,0DCH,0D8H,0DCH
	DEFB	0E0H,0E4H,0E8H,0ECH,0E8H,0ECH,0E8H,0ECH
	DEFB	0F0H,0F4H,0F8H,0FCH,0F8H,0FCH
I731B:  DEFB    0F8H,0FCH
T731D:	DEFB	0A7H,00H,0B1H,00H,0A8H,00H,0B2H,00H
	DEFB	0A9H,00H,0B3H,00H,0AAH,00H,0B4H,00H
	DEFB	0ABH,00H,0B5H,00H,0B6H,00H,0B6H,0DEH
	DEFB	0B7H,00H,0B7H,0DEH,0B8H,00H,0B8H,0DEH
	DEFB	0B9H,00H,0B9H,0DEH,0BAH,00H,0BAH,0DEH
	DEFB	0BBH,00H,0BBH,0DEH,0BCH,00H,0BCH,0DEH
	DEFB	0BDH,00H,0BDH,0DEH,0BEH,00H,0BEH,0DEH
	DEFB	0BFH,00H,0BFH,0DEH,0C0H,00H,0C0H,0DEH
	DEFB	0C1H,00H,0C1H,0DEH,0AFH,00H,0C2H,00H
	DEFB	0C2H,0DEH,0C3H,00H,0C3H,0DEH,0C4H,00H
	DEFB	0C4H,0DEH,0C5H,00H,0C6H,00H,0C7H,00H
	DEFB	0C8H,00H,0C9H,00H,0CAH,00H,0CAH,0DEH
	DEFB	0CAH,0DFH,0CBH,00H,0CBH,0DEH,0CBH,0DFH
	DEFB	0CCH,00H,0CCH,0DEH,0CCH,0DFH,0CDH,00H
	DEFB	0CDH,0DEH,0CDH,0DFH,0CEH,00H,0CEH,0DEH
	DEFB	0CEH,0DFH,0CFH,00H,0D0H,00H,0D1H,00H
	DEFB	0D2H,00H,0D3H,00H,0ACH,00H,0D4H,00H
	DEFB	0ADH,00H,0D5H,00H,0AEH,00H,0D6H,00H
	DEFB	0D7H,00H,0D8H,00H,0D9H,00H,0DAH,00H
	DEFB	0DBH,00H,0DCH,00H,0DCH,00H,0B2H,00H
	DEFB	0B4H,00H,0A6H,00H,0DDH,00H,0CDH,0DEH
	DEFB	0B6H,00H,0B9H
        DEFB    00H

T73C9:  DEFB    21H,2AH,49H,74H
	DEFB	70H,73H,75H,47H,4AH,4BH,76H,5CH
	DEFB	24H,3DH,25H,3FH,27H,28H,63H,61H
	DEFB	64H,29H,77H,4EH,6FH,4FH,30H,32H
	DEFB	46H,50H,43H,51H,41H,23H,56H,57H
	DEFB	22H,26H,3CH,5DH,2BH
        DEFB    2CH

T73F3:  DEFB    20H,21H
	DEFB	22H,23H,24H,25H,26H,27H,28H,29H
	DEFB	2AH,2BH,2CH,2DH,2EH,2FH,3AH,3BH
	DEFB	3CH,3DH,3EH,3FH,40H,5BH,5CH,5DH
	DEFB	5EH,5FH,60H,7BH,7CH,7DH,7EH,0A1H
	DEFB	0A2H,0A3H,0A4H,0A5H,0B0H,2DH,0DEH,0DFH

J741D:	LD	L,(IY+12)
        LD	H,(IY+13)
        LD	A,L
        OR	H
        JP	NZ,J752B
J7428:	CALL	C6953
        JR	C,J7446
        BIT	0,(IY+8)
        JR	NZ,J743E
        CALL	C69CC
        LD	A,(BAKCLR)
        CALL	NC,C7865
        JR	J7428

J743E:	CALL	C69E8
J7441:	CALL	C785C
        JR	J7428

J7446:	BIT	0,(IY+8)
        JP	Z,C76C7
        CALL	C76C7
        CALL	C760D
        JP	NC,J7542
J7456:	CP	20H	; " "
        RET	C
        CP	7FH
        RET	Z
        LD	HL,I74D0
        PUSH	HL
        RET	C
        CP	0A1H
        RET	Z
        CP	0A2H
        RET	Z
        CP	0A3H
        RET	Z
        CP	0A4H
        RET	Z
        CP	0A5H
        RET	Z
        CP	0B0H
        RET	Z
        CP	0DEH
        RET	Z
        CP	0DFH
        RET	Z
        POP	HL
        CP	80H
        RET	Z
        CP	90H
        RET	Z
        CP	0A0H
        RET	Z
        CP	0FDH
        RET	NC
        CALL	C4908			; double byte header character ?
        JR	C,J7496			; nope,
        LD	B,A
        CALL	C76C7
        LD	C,A
        CALL	C76AD
        JP	C,J750F
J7496:	PUSH	AF
        CALL	C7729
        POP	AF
        CALL	C763D
J749E:	LD	C,00H
        LD	B,C
J74A1:	CP	03H	; 3
        JR	NZ,J74AD
        LD	A,(INTFLG)
        CP	03H	; 3
        JP	Z,C785C
J74AD:	CP	1BH
        JR	Z,J7441
        CP	0DH	; 13
        JR	Z,J74D5
        CALL	C76D8
        AND	A
        JR	Z,J74CB
        DEC	A
        PUSH	AF
        PUSH	BC
        LD	C,B
        CALL	Z,C7759
        POP	BC
        LD	B,C
        POP	AF
        CALL	NZ,C77BD
        CALL	C7759
J74CB:	CALL	C76C7
        JR	J74A1

I74D0:	CALL	C6D26
        JR	J750A

J74D5:	LD	A,C
        AND	A
        JR	NZ,J74FF
        PUSH	IY
        POP	HL
        LD	BC,14
        ADD	HL,BC
        LD	E,L
        LD	D,H
        INC	HL
        INC	HL
        LD	B,(IY+14)
J74E7:	PUSH	BC
        LD	C,(HL)
        INC	HL
        LD	B,(HL)
        INC	HL
        CALL	C70AB
        EX	DE,HL
        LD	(HL),B
        INC	HL
        LD	(HL),C
        INC	HL
        EX	DE,HL
        POP	BC
        DJNZ	J74E7
        XOR	A
        LD	(DE),A
        CALL	C785C
        JR	J7519

J74FF:	LD	B,00H
        ADD	HL,BC
        ADD	HL,BC
        LD	A,(HL)
        INC	HL
        LD	H,(HL)
        LD	L,A
        CALL	C785C
J750A:	LD	C,L
        LD	B,H
        CALL	C70AB
J750F:	LD	(IY+14),B
        LD	(IY+15),C
        LD	(IY+16),00H
J7519:	LD	A,(GETPNT)
        LD	(IY+11),A
        LD	A,80H
        LD	(GETPNT),A
        PUSH	IY
        POP	HL
        LD	BC,14
        ADD	HL,BC
J752B:	LD	B,(HL)
        INC	HL
        LD	A,(HL)
        AND	A
        JR	NZ,J753A
        LD	A,(IY+11)
        LD	(GETPNT),A
        LD	HL,0
J753A:	LD	(IY+12),L
        LD	(IY+13),H
        LD	A,B
        RET

J7542:	LD	HL,SWPTMP
        LD	(HL),A
        INC	HL
        LD	B,03H	; 3
J7549:	CALL	C76C7
        CP	1BH
        JP	Z,J7428
        CALL	C760D
        JP	C,J7456
        LD	(HL),A
        INC	HL
        DJNZ	J7549
        LD	HL,SWPTMP
        LD	A,(HL)
        INC	HL
        ADD	A,A
        ADD	A,A
        ADD	A,A
        ADD	A,A
        OR	(HL)
        INC	HL
        CP	21H	; "!"
        JP	C,J7428
        CP	29H	; ")"
        JR	C,J7579
        CP	30H	; "0"
        JP	C,J7428
        CP	75H	; "u"
        JP	NC,J7428
J7579:	LD	B,A
        LD	A,(HL)
        INC	HL
        ADD	A,A
        ADD	A,A
        ADD	A,A
        ADD	A,A
        OR	(HL)
        CP	21H	; "!"
        JP	C,J7428
        CP	7FH
        JP	NC,J7428
        LD	(IY+14),01H	; 1
        LD	(IY+15),00H
        LD	(IY+16),A
        LD	(IY+17),B
        LD	E,A
        LD	D,B
        PUSH	IY
        POP	HL
        LD	BC,34
        ADD	HL,BC
        LD	B,7FH
        LD	(HL),B
        INC	HL
        LD	(HL),00H
        INC	HL
J75A9:	CALL	C75D0
        LD	(HL),E
        INC	HL
        LD	(HL),D
        INC	HL
        DJNZ	J75A9
        PUSH	IY
        POP	HL
        LD	BC,34
        ADD	HL,BC
        CALL	C7729
        LD	(IY+9),E
        LD	(IY+10),D
        LD	C,00H
        CALL	C77BD
        CALL	C7759
        CALL	C76C7
        JP	J749E

;	  Subroutine __________________________
;	     Inputs  ________________________
;	     Outputs ________________________

C75D0:	INC	E
        LD	A,E
        CP	7FH
        RET	C
        LD	E,21H	; "!"
        INC	D
        LD	A,D
        CP	29H	; ")"
        RET	C
        JR	NZ,J75E1
        LD	D,30H	; "0"
        RET

J75E1:	CP	75H	; "u"
        RET	C
        LD	D,21H	; "!"
        RET

;	  Subroutine __________________________
;	     Inputs  ________________________
;	     Outputs ________________________

C75E7:	CALL	C75FC
        RET	C
        CP	0DCH
        LD	C,6FH	; "o"
        RET	Z
        LD	C,20H	; " "
        LD	HL,T731D
J75F5:	INC	C
        CP	(HL)
        INC	HL
        INC	HL
        JR	NZ,J75F5
        RET

;	  Subroutine __________________________
;	     Inputs  ________________________
;	     Outputs ________________________

C75FC:	CP	86H
        RET	C
        CP	0A0H
        JR	C,J760A
        CP	0E0H
        RET	C
        CP	0FEH
        CCF
        RET	C
J760A:	XOR	20H	; " "
        RET

;	  Subroutine __________________________
;	     Inputs  ________________________
;	     Outputs ________________________

C760D:	AND	A
        SCF
        RET	Z
        CP	07H	; 7
        JR	C,J762B
        CP	30H	; "0"
        RET	C
        CP	3AH	; ":"
        CCF
        RET	C
        PUSH	BC
        LD	B,A
        LD	A,06H	; 6
        CALL	SNSMAT
        AND	02H	; 2
        LD	A,B
        POP	BC
        SCF
        RET	NZ
        SUB	30H	; "0"
        RET

J762B:	ADD	A,09H	; 9
        CP	0CH	; 12
        SCF
        CCF
        RET	NZ
        LD	A,(INTFLG)
        CP	03H	; 3
        SCF
        RET	Z
        LD	A,0CH	; 12
        AND	A
        RET

;	  Subroutine __________________________
;	     Inputs  ________________________
;	     Outputs ________________________

C763D:	PUSH	IY
        LD	IY,SWPTMP
        LD	C,07H	; 7
J7645:	CP	08H	; 8
        JR	NZ,J7657
        LD	A,C
        CP	06H	; 6
        JR	Z,J7687
        DEC	IY
        LD	(IY+0),00H
        INC	C
        JR	J7665

J7657:	INC	C
        DEC	C
        JR	Z,J7679
        LD	(IY+0),A
        INC	IY
        LD	(IY+0),00H
        DEC	C
J7665:	EX	(SP),IY
        CALL	C78EC
        CALL	C7894
        PUSH	BC
        LD	C,00H
        CALL	C77BD
        CALL	C7759
        POP	BC
        EX	(SP),IY
J7679:	CALL	C768C
        CP	08H	; 8
        JR	Z,J7645
        CP	21H	; "!"
        JR	NC,J7645
        POP	IY
        RET

J7687:	POP	IY
        LD	A,1BH
        RET

;	  Subroutine __________________________
;	     Inputs  ________________________
;	     Outputs ________________________

C768C:	CALL	C76C7
        CP	82H
        RET	NZ
        PUSH	HL
        LD	HL,(GETPNT)
        LD	A,(HL)
        POP	HL
        CP	9FH
        JR	C,J76AA
        CP	0F2H
        JR	NC,J76AA
        CALL	C76C7
        PUSH	BC
        LD	C,A
        CALL	C76BA
        POP	BC
        RET

J76AA:	LD	A,82H
        RET

;	  Subroutine __________________________
;	     Inputs  ________________________
;	     Outputs ________________________

C76AD:	LD	A,C
        CP	9FH
        RET	C
        CP	0F2H
        CCF
        RET	C
        LD	A,B
        CP	82H
        SCF
        RET	NZ

;	  Subroutine __________________________
;	     Inputs  ________________________
;	     Outputs ________________________

C76BA:	PUSH	HL
        LD	B,0
        LD	HL,T731D-2*09FH
        ADD	HL,BC
        ADD	HL,BC
        LD	A,(HL)
        XOR	20H
        POP	HL
        RET

;	  Subroutine __________________________
;	     Inputs  ________________________
;	     Outputs ________________________

C76C7:	PUSH	IX
        PUSH	IY
J76CB:	CALL	CHSNS
        JR	Z,J76CB
        CALL	CHGET
        POP	IY
        POP	IX
        RET

;	  Subroutine __________________________
;	     Inputs  ________________________
;	     Outputs ________________________

C76D8:	CP	20H	; " "
        JR	Z,J76F2
        CP	1CH
        JR	Z,J76F2
        CP	08H	; 8
        JR	Z,J7712
        CP	1DH
        JR	Z,J7712
        CP	1EH
        JR	Z,J7720
        CP	1FH
        JR	Z,J76FE
        XOR	A
        RET

J76F2:	LD	A,C
        SUB	(HL)
        RET	Z
        INC	C
        CALL	C77B0
        LD	A,01H	; 1
        RET	NZ
        INC	A
        RET

J76FE:	LD	A,C
        CP	(IY+9)
        JR	NC,J7709
        ADD	A,(IY+9)
        JR	J770B

J7709:	LD	A,C
        ADD	A,E
J770B:	LD	C,A
        CP	(HL)
        LD	A,02H	; 2
        RET	C
        LD	C,(HL)
        RET

J7712:	LD	A,C
        AND	A
        RET	Z
        CALL	C77B0
        PUSH	AF
        DEC	C
        POP	AF
        LD	A,01H	; 1
        RET	NZ
        INC	A
        RET

J7720:	LD	A,C
        SUB	E
        LD	C,A
        LD	A,02H	; 2
        RET	P
        LD	C,00H
        RET

;	  Subroutine __________________________
;	     Inputs  ________________________
;	     Outputs ________________________

C7729:	LD	A,(LINLEN)
        CALL	C7744
        RET	C
J7730:	INC	D
        SUB	0EH	; 14
        JR	NC,J7730
        LD	E,0FH	; 15
        RET

;	  Subroutine __________________________
;	     Inputs  ________________________
;	     Outputs ________________________

C7738:	CALL	C7744
        RET	C
J773C:	INC	D
        SUB	0FH	; 15
        JR	NC,J773C
        LD	E,0FH	; 15
        RET

;	  Subroutine __________________________
;	     Inputs  ________________________
;	     Outputs ________________________

C7744:	LD	D,A
        LD	E,0FFH
J7747:	INC	E
        SUB	03H	; 3
        JR	NC,J7747
        LD	A,E
        CP	10H	; 16
        LD	A,D
        LD	D,01H	; 1
        RET	C
        SUB	1EH
        LD	D,0FFH
        AND	A
        RET

;	  Subroutine __________________________
;	     Inputs  ________________________
;	     Outputs ________________________

C7759:	PUSH	HL
        PUSH	DE
        PUSH	BC
        PUSH	IY
        PUSH	IX
        CALL	C6B14
        LD	A,C
        CP	(IY+9)
        JR	NC,J7780
        AND	A
        JR	Z,J779E
        CALL	C77B0
        LD	C,A
        LD	A,(IY+10)
        ADD	A,02H	; 2
        LD	H,A
        LD	A,(IY+14)
        ADD	A,A
        ADD	A,(IY+10)
        SUB	H
        JR	J778B

J7780:	CALL	C77B0
        LD	C,A
        LD	A,D
        ADD	A,02H	; 2
        LD	H,A
        NEG
        INC	C
J778B:	ADD	A,H
        DEC	C
        JR	NZ,J778B
        LD	H,A
        INC	H
        LD	E,02H	; 2
        CALL	C5C8E
J7796:	POP	IX
        POP	IY
        POP	BC
        POP	DE
        POP	HL
        RET

J779E:	LD	B,(IY+14)
        LD	H,01H	; 1
J77A3:	PUSH	BC
        LD	E,02H	; 2
        CALL	C5C8E
        INC	H
        INC	H
        POP	BC
        DJNZ	J77A3
        JR	J7796

;	  Subroutine __________________________
;	     Inputs  ________________________
;	     Outputs ________________________

C77B0:	LD	A,C
        CP	(IY+9)
        RET	C
        SUB	(IY+9)
J77B8:	SUB	E
        JR	NC,J77B8
        ADD	A,E
        RET

;	  Subroutine __________________________
;	     Inputs  ________________________
;	     Outputs ________________________

C77BD:	CALL	C785C
        PUSH	HL
        PUSH	DE
        PUSH	BC
        PUSH	IY
        PUSH	IX
        CALL	C77B0
        NEG
        ADD	A,C
        LD	BC,(FORCLR)
        PUSH	BC
        PUSH	AF
        LD	A,B
        LD	B,C
        LD	C,A
        LD	(FORCLR),BC
        POP	AF
        JR	Z,J781C
        LD	C,A
        LD	A,(HL)
        INC	A
        SUB	C
        LD	B,00H
        ADD	HL,BC
        ADD	HL,BC
        LD	B,A
        PUSH	HL
        CALL	C6B14
        LD	H,01H	; 1
J77EC:	LD	A,B
        AND	A
        JR	Z,J780F
J77F0:	EX	(SP),HL
        PUSH	BC
        LD	C,(HL)
        INC	HL
        LD	B,(HL)
        INC	HL
        CALL	C70AB
        POP	AF
        EX	(SP),HL
        PUSH	BC
        LD	C,B
        CALL	C5864
        INC	H
        POP	BC
        LD	B,A
        CALL	C5864
        INC	H
        LD	A,H
        ADD	A,D
        LD	H,A
        DEC	E
        JR	Z,J780F
        DJNZ	J77F0
J780F:	POP	HL
        POP	HL
        LD	(FORCLR),HL
        POP	IX
        POP	IY
        POP	BC
        POP	DE
        POP	HL
        RET

J781C:	PUSH	HL
        PUSH	IY
        CALL	C6B14
        LD	H,01H	; 1
        LD	B,(IY+14)
J7827:	PUSH	BC
        PUSH	IY
        LD	C,(IY+16)
        LD	B,(IY+17)
        CALL	C70AB
        PUSH	BC
        LD	C,B
        CALL	C5864
        INC	H
        POP	BC
        CALL	C5864
        INC	H
        POP	IY
        POP	BC
        INC	IY
        INC	IY
        DJNZ	J7827
        POP	IY
        LD	A,H
        ADD	A,(IY+10)
        LD	H,A
        EX	(SP),HL
        LD	B,(HL)
        INC	HL
        INC	HL
        LD	E,(IY+9)
        DEC	E
        LD	D,(IY+10)
        EX	(SP),HL
        JR	J77EC

;	  Subroutine __________________________
;	     Inputs  ________________________
;	     Outputs ________________________

C785C:	PUSH	AF
        LD	A,(FORCLR)
        CALL	C7865
        POP	AF
        RET

;	  Subroutine __________________________
;	     Inputs  ________________________
;	     Outputs ________________________

C7865:	PUSH	BC
        PUSH	DE
        PUSH	HL
        PUSH	IY
        PUSH	IX
        LD	L,A
        LD	A,(BAKCLR)
        PUSH	AF
        LD	A,L
        LD	(BAKCLR),A
        CALL	C6B14
        LD	H,01H	; 1
        CALL	C5FB0
        POP	AF
        LD	(BAKCLR),A
        CALL	C6B14
        LD	A,(LINLEN)
        INC	A
        LD	H,A
        CALL	C5FB0
        POP	IX
        POP	IY
        POP	HL
        POP	DE
        POP	BC
        RET

;	  Subroutine __________________________
;	     Inputs  ________________________
;	     Outputs ________________________

C7894:	PUSH	BC
        PUSH	DE
        LD	A,(MODE)
        AND	40H			; JIS-2 rom ?
        JR	NZ,J78AC		; yep, function 4
        BIT	6,(IX+0)
        JR	Z,J78A9			; character width 8, function 1
        BIT	6,(IX+1)		; Matsushita JIS-2 rom ?
        JR	NZ,J78AC		; yep, function 4
J78A9:	LD	A,1			; function 1, JIS-1 ??
        DEFB	021H
J78AC:	LD	A,4			; function 4, JIS-2 ??
        PUSH	IY
        PUSH	IX
        CALL	C78CB			; MSX-JE replacement function
        EI
        NOP
        POP	IX
        POP	IY
        PUSH	AF
        PUSH	IY
        POP	HL
        LD	DE,34
        ADD	HL,DE
        POP	AF
        JR	NC,J78C8
        LD	(HL),0
J78C8:	POP	DE
        POP	BC
        RET

;	  Subroutine MSX-JE replacement function
;	     Inputs  ________________________
;	     Outputs ________________________

C78CB:	EXX
        EX	AF,AF'
        LD	HL,0
        ADD	HL,SP
        LD	A,H
        CP	0C1H
        JR	NC,C78E8
        EX	DE,HL
        PUSH	IY
        POP	HL
        LD	BC,0222H
        ADD	HL,BC
        LD	SP,HL
        PUSH	DE
        CALL	C78E8
        EXX
        POP	HL
        LD	SP,HL
        EXX
        RET

;	  Subroutine __________________________
;	     Inputs  ________________________
;	     Outputs ________________________

C78E8:	EX	AF,AF'
        EXX
        JP	(IY)

;	  Subroutine __________________________
;	     Inputs  ________________________
;	     Outputs ________________________

C78EC:	PUSH	BC
        PUSH	DE
        PUSH	IX
        PUSH	IY
        POP	HL
        LD	DE,14
        ADD	HL,DE
        LD	IX,SWPTMP
        CALL	C7923
        LD	A,(LINLEN)
        SUB	C
        SUB	C
        CALL	C7738
        INC	E
        LD	(IY+9),E
        LD	(IY+10),D
        PUSH	IY
        POP	HL
        LD	BC,34
        ADD	HL,BC
        EX	DE,HL
        LD	HL,0FFECH
        ADD	HL,DE
        LD	BC,16
        LDIR
        POP	IX
        POP	DE
        POP	BC
        RET

;	  Subroutine __________________________
;	     Inputs  ________________________
;	     Outputs ________________________

C7923:	EX	DE,HL
        INC	DE
        PUSH	DE
        INC	DE
        LD	BC,0FF00H
J792A:	LD	A,(IX+0)
        INC	IX
        AND	A
        JR	Z,J7949
        CALL	C75FC
        PUSH	AF
        CALL	C6CCA
        JR	C,J7948
        POP	AF
        JR	C,J793F
        DEC	H
J793F:	LD	A,L
        LD	(DE),A
        INC	DE
        LD	A,H
        LD	(DE),A
        INC	DE
        INC	C
        JR	J792A

J7948:	POP	AF
J7949:	POP	DE
        XOR	A
        LD	(DE),A
        DEC	DE
        LD	A,C
        LD	(DE),A
        EX	DE,HL
        RET

;	  Subroutine initialize simple japanese input frontend processor
;	     Inputs  ________________________
;	     Outputs ________________________

C7951:	LD	DE,546
        LD	HL,(HIMEM)
        AND	A
        SBC	HL,DE
        LD	(HIMEM),HL
        LD	A,(H.PHYD+0)
        CP	0C9H			; disk system active ?
        JR	Z,J7967
        LD	(DF349),HL		; yep, adjust lower disk system
J7967:	POP	BC
        LD	SP,HL
        PUSH	BC
        CALL	C4099			; get my SLTWRK entry
        LD	(IX+4),L
        LD	A,H
        AND	7FH			; reset b7 (to indicate not a real MSX-JE)
        LD	(IX+5),A
        PUSH	HL
        POP	IY
        LD	(IY+0),21H		; ld hl,
        LD	(IY+3),0F7H		; rst fcall
        LD	(IY+5),LOW CBFF0
        LD	(IY+6),HIGH CBFF0	; dw BFF0
        LD	(IY+7),0C9H		; ret
        XOR	A
        LD	(IY+8),A
        LD	(IY+12),A
        LD	(IY+13),A
        LD	DE,30
        ADD	HL,DE
        LD	(IY+1),L
        LD	(IY+2),H		; start of workarea
        LD	DE,4
        ADD	HL,DE
        LD	(IY+32),L
        LD	(IY+33),H
        LD	(IY+30),L
        LD	(IY+31),H
        CALL	C44EB			; get slotid
        LD	(IY+4),A
        AND	A
        RET

;	  Subroutine get japanese input frontend processor area
;	     Inputs  ________________________
;	     Outputs ________________________

C79B9:	PUSH	DE
        LD	E,(IX+4)
        LD	D,(IX+5)
        BIT	7,D
        SET	7,D
        PUSH	DE
        POP	IY
        POP	DE
        RET

        DEFS    8000H-$,0FFH

        END
