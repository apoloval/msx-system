; changes
;
; 425E
; 4431
; 46F3
; 4FCD
; 4FE5

RDSLT	EQU	000CH
WRSLT	EQU	0014H
CALSLT	EQU	001CH
CHSNS	EQU	009CH
CHGET	EQU	009FH
CHPUT	EQU	00A2H
LPTOUT	EQU	00A5H
BREAKX	EQU	00B7H

SNERR   EQU     4055H
TMERR   EQU     406DH
T4295	EQU	4295H
CHRGTR	EQU	4666H
FCERR   EQU     475AH
T4769	EQU	4769H
USERR   EQU     481CH
FRMEVL	EQU	4C64H
DOCNVF  EQU     517AH
GETBYT	EQU	521CH
FRMQNT	EQU	542FH
PTRGET	EQU	5EA4H
T631B	EQU	631BH
T632B	EQU	632BH
T6331	EQU	6331H
FRESTR	EQU	67D0H
DERBFN	EQU	6E6BH
DERFAO	EQU	6E6EH
DERFNO	EQU	6E77H
DERIER	EQU	6E80H
DERSOO	EQU	6E86H
DIOERR	EQU	73B2H

BUF	EQU	0F55EH
VALTYP	EQU	0F663H
DAC	EQU	0F7F6H
NULBUF	EQU	0F862H
PTRFIL	EQU	0F864H
FNKSTR	EQU	0F87FH

TOCNT	EQU	0FB03H
RSFCB	EQU	0FB04H
RSIQLN	EQU	0FB06H
MEXBIH	EQU	0FB07H
OLDSTT	EQU	0FB0CH
OLDINT	EQU	0FB11H
DEVNUM	EQU	0FB16H
DATCNT	EQU	0FB17H
ERRORS	EQU	0FB1AH
FLAGS	EQU	0FB1BH
ESTBLS	EQU	0FB1CH
COMMSK	EQU	0FB1DH
LSTCOM	EQU	0FB1EH
LSTMOD	EQU	0FB1FH

HOKVLD	EQU	0FB20H
ONGSBF	EQU	0FBD8H
KBUF	EQU	0F41FH
AVCSAV	EQU	0FAF7H
NEWKEY	EQU	0FBE5H
TRPTBL	EQU	0FC4CH
INTFLG	EQU	0FC9BH
CSRSR	EQU	0FCA9H
EXPTBL	EQU	0FCC1H
PROCNM	EQU	0FD89H
H.KEYI	EQU	0FD9AH
H.KEYC	EQU	0FDCCH
H.NEWS	EQU	0FF3EH
FCALL	EQU	0FFCAH
DISINT	EQU	0FFCFH
RG8SAV	EQU	0FFE7H
RG9SAV	EQU	0FFE8H

D.7FFD	EQU	7FFDH

        DEFB	"AB"
        DEFW	J51F5			; ROM init
        DEFW	J5A6D			; ROM call statement handler
        DEFW	J5B23			; ROM device handler
        DEFW	0			; ROM basic program
        DEFS	6,0

?4010:	DEFB	010H			; RS232 has CD detect
        DEFB	0			; RS232 version 1
        DEFB	0			; RS232 reserved byte
        JP	J4040			; RS232 init
?4016:	JP	C4270			; RS232 open
?4019:	JP	C515F			; RS232 stat
?401C:	JP	C42E0			; RS232 getchr
?401F:	JP	C4FE5			; RS232 sndchr
?4022:	JP	C42AB			; RS232 close
?4025:	JP	J406A			; RS232 eof
?4028:	JP	C4332			; RS232 loc
?402B:	JP	C435D			; RS232 lof
?402E:	JP	C439A			; RS232 backup
?4031:	JP	C50EE			; RS232 sndbrk
?4034:	JP	C5147			; RS232 dtr
?4037:	RET				; RS232 setchn (not implemented)
        RET
        RET
?403A:	RET				; RS232 reserved entry
        RET
        RET
?403D:	RET				; RS232 reserved entry
        RET
        RET

;	  Subroutine RS232 init
;	     Inputs  ________________________
;	     Outputs ________________________

J4040:	EI
        PUSH	BC
        PUSH	DE
        PUSH	HL
        LD	IY,-13
        ADD	IY,SP
        LD	SP,IY			; allocate space on stack
        PUSH	IY
        POP	DE
        LD	C,13
J4051:	CALL	C44DC			; read byte from slot
        LD	(DE),A
        INC	DE
        DEC	C
        JR	NZ,J4051
        CALL	C4CF6			; initialize RS232
        PUSH	AF
        LD	IY,13+2
        ADD	IY,SP
        POP	AF
        LD	SP,IY			; deallocate space on stack
        POP	HL
        POP	DE
        POP	BC
        RET

;	  Subroutine RS232 eof
;	     Inputs  ________________________
;	     Outputs ________________________

J406A:	LD	HL,0
        CALL	C4E7A
        RET	Z
        CALL	C437A
        RET

;	  Subroutine original RS232 ROM init
;	     Inputs  ________________________
;	     Outputs ________________________

J4075:	CALL	C4E66			; disable RS232 interrupts
        LD	IY,I4143
        CALL	C4CF6			; initialize RS232
        CALL	C4131			; empty receive buffer and clear flags and errors
        DI
        LD	DE,OLDINT
        LD	HL,H.KEYI
        LD	BC,5
        LDIR
        LD	DE,OLDSTT
        LD	HL,H.NEWS
        LD	BC,5
        LDIR
        CALL	C4E4A			; get my slotid
        LD	(H.KEYI+1),A
        LD	(H.NEWS+1),A
        LD	A,0F7H
        LD	(H.KEYI+0),A
        LD	(H.NEWS+0),A
        LD	HL,I4E74
        LD	(H.KEYI+2),HL
        LD	HL,I4BFA
        LD	(H.NEWS+2),HL
        LD	A,0C9H
        LD	(H.KEYI+4),A
        LD	(H.NEWS+4),A
        EI
        LD	HL,HOKVLD
        BIT	0,(HL)
        JR	NZ,J40D2
        SET	0,(HL)
        LD	HL,FCALL
        LD	B,5 
J40CD:	LD	(HL),0C9H
        INC	HL
        DJNZ	J40CD
J40D2:	XOR	A
        LD	DE,0801H
        CALL	FCALL
        LD	HL,DEVNUM
        LD	(HL),A			; device number of this interface
        XOR	A
        LD	DE,0001H
        CALL	FCALL
        ADD	A,A
        ADD	A,A
        ADD	A,A
        ADD	A,A
        OR	(HL)
        LD	(HL),A
        LD	DE,MEXBIH
        DI
        LD	HL,FCALL
        LD	BC,5
        LDIR
        CALL	C4E4A			; get my slotid
        LD	(FCALL+1),A
        LD	A,0F7H
        LD	(FCALL+0),A
        LD	HL,I43EF
        LD	(FCALL+2),HL
        LD	A,0C9H
        LD	(FCALL+4),A
        LD	BC,L4119
        LD	HL,I4119
        LD	DE,DISINT
        LDIR
        EI
        RET

I4119:	PUSH	DE
        LD	E,02H
        JR	J4121

?411E:	PUSH	DE
        LD	E,03H
J4121:	LD	D,00H
        PUSH	IX
        PUSH	IY
        CALL	FCALL
        EI
        POP	IY
        POP	IX
        POP	DE
        RET

L4119	EQU	$-I4119

;	  Subroutine __________________________
;	     Inputs  ________________________
;	     Outputs ________________________

C4131:	XOR	A
        LD	(FLAGS),A

;	  Subroutine __________________________
;	     Inputs  ________________________
;	     Outputs ________________________

C4135:	PUSH	HL
        LD	HL,DATCNT
        XOR	A
        LD	(HL),A			; no characters in receive buffer
        INC	HL
        LD	(HL),A			; relative get = 0
        INC	HL
        LD	(HL),A			; relative put = 0
        INC	HL
        LD	(HL),A			; errors = 0
        POP	HL
        RET

I4143:	DEFB	"8N1XHNNN"
        DEFW	1200
        DEFW	1200
        DEFB	0

;	  Subroutine original RS232 ROM CALL handler
;	     Inputs  ________________________
;	     Outputs ________________________

J4150:	EI
        PUSH	HL
        POP	IX
        LD	DE,I419F
        CALL	C415D
        RET	C
        PUSH	DE
        RET

;	  Subroutine __________________________
;	     Inputs  ________________________
;	     Outputs ________________________

C415D:	PUSH	BC
        PUSH	HL
J415F:	LD	HL,PROCNM
        LD	A,(DE)
        INC	A
        JR	Z,J4178
        CALL	C417C
        JR	Z,J4170
        INC	DE
        INC	DE
        INC	DE
        JR	J415F
J4170:	EX	DE,HL
        INC	HL
        LD	E,(HL)
        INC	HL
        LD	D,(HL)
        AND	A
        JR	J4179
J4178:	SCF
J4179:	POP	HL
        POP	BC
        RET

;	  Subroutine __________________________
;	     Inputs  ________________________
;	     Outputs ________________________

C417C:	LD	A,(DE)
        CALL	C4CED			; to uppercase
        LD	C,A
        LD	A,(HL)
        CALL	C4CED			; to uppercase
        CP	C
        JR	NZ,J418E
        AND	A
        RET	Z
        INC	DE
        INC	HL
        JR	C417C
J418E:	LD	A,(DE)
        AND	A
        JR	Z,J4195
        INC	DE
J4193:	JR	J418E
J4195:	LD	A,(HL)
        AND	A
        JR	Z,J419C
        INC	HL
        JR	J4195
J419C:	LD	A,L
        OR	H
        RET

I419F:	DEFB	"COMINI",0
        DEFW	J45A9
        DEFB	"COMDTR",0
        DEFW	J466C
        DEFB	"COMSTAT",0
        DEFW	J468A
        DEFB	"COMBREAK",0
        DEFW	J46AE
        DEFB	"COMTERM",0
        DEFW	J46F3
        DEFB	"COM",0
        DEFW	J4B51
        DEFB	"COMON",0
        DEFW	J4BA9
        DEFB	"COMOFF",0
        DEFW	J4B8B
        DEFB	"COMSTOP",0
        DEFW	J4BC7
        DEFB	"COMHELP",0
        DEFW	J495A
        DEFB	0FFH

;	  Subroutine original RS232 ROM BASIC device handler
;	     Inputs  ________________________
;	     Outputs ________________________

J41FC:	EI
        CP	0FFH			; device inquire ?
        JP	NZ,J4239		; nope, execute device function
        LD	HL,PROCNM
        LD	A,(HL)
        CP	"C"
        JR	NZ,J4237
        INC	HL
        LD	A,(HL)
        CP	"O"
        JR	NZ,J4237
        INC	HL
        LD	A,(HL)
        CP	"M"
        JR	NZ,J4237
        INC	HL
        LD	A,(HL)
        AND	A			; "COM" device ?
        JR	NZ,J421E		; nope, must be "COMx" device
        DEC	HL
        LD	A,"0"			; first COM device
J421E:	SUB	"0"
        JR	C,J4237
        CP	9+1
        JR	NC,J4237
        PUSH	BC
        PUSH	AF
        LD	A,(DEVNUM)
        AND	0FH
        LD	B,A
        POP	AF
        CP	B			; is this my COM device ?
        POP	BC
        JR	NZ,J4237		; nope, other RS232 ROM should handle it
        INC	HL
        LD	A,(HL)
        AND	A
        RET	Z
J4237:	SCF
        RET

J4239:	PUSH	HL
        PUSH	AF
        LD	HL,I424A
        ADD	A,L
        LD	L,A
        JR	NC,J4243
        INC	H
J4243:	LD	A,(HL)
        INC	HL
        LD	H,(HL)
        LD	L,A
        POP	AF
        EX	(SP),HL
        RET

;	  Subroutine BASIC device function table
;	     Inputs  ________________________
;	     Outputs ________________________

I424A:	DEFW	J425E			; OPEN
        DEFW	C42AB			; CLOSE, RS232 close
        DEFW	J4495			; RANDOM I/O, sequential i/o only error
        DEFW	J42CD			; OUTPUT
        DEFW	J42D9			; INPUT
        DEFW	J4324			; LOC
        DEFW	J4357			; LOF
        DEFW	J4371			; EOF
        DEFW	J44B3			; FPOS, illegal function call
        DEFW	C439A			; BACKUP, RS232 backup

;	  Subroutine open (BASIC)
;	     Inputs  ________________________
;	     Outputs ________________________

J425E:	LD	C,7FH			; buffersize = 127
        CALL	C4270			; RS232 open
        JR	C,J4269			; error,
        LD	(PTRFIL),HL
        RET

J4269:	DEC	A			; open in append mode ?
        JP	Z,J4489			; yep, bad filename error
        JP	J449B			; file already open

;	  Subroutine RS232 open
;	     Inputs  ________________________
;	     Outputs ________________________

C4270:	OR	A
        LD	A,(FLAGS)
        BIT	3,A			; RS232 already open ?
        LD	A,2
        SCF
        RET	NZ			; yep, quit with error
        LD	A,E
        CP	08H
        LD	A,1
        SCF
        RET	Z
        PUSH	BC
        PUSH	DE
        PUSH	HL
        LD	(RSFCB),HL
        LD	A,C
        LD	(RSIQLN),A
        LD	(HL),E
        XOR	A
        INC	HL
        INC	HL
        LD	(HL),A
        INC	HL
        LD	(HL),A
        INC	HL
        INC	HL
        INC	HL
I4295:	LD	(HL),A
        CALL	C4131			; empty receive buffer and clear flags and errors
        LD	HL,FLAGS
        SET	3,(HL)			; flag RS232 open
        DI
        CALL	C4E6D			; enable RS232 interrupts
        CALL	C5134			; RTS=1
        EI
        OR	A
        POP	HL
        POP	DE
        POP	BC
        RET

;	  Subroutine RS232 close
;	     Inputs  ________________________
;	     Outputs ________________________

C42AB:	PUSH	HL
        LD	HL,(RSFCB)
        LD	A,(HL)
        CP	02H
        SCF
        CCF
        JR	NZ,J42BB
        LD	A,1AH
        CALL	C4FE5			; RS232 sndchr
J42BB:	DI
        CALL	C5185			; wait for empty transmitter
        CALL	C513C			; RTS=0
        CALL	C4E66			; disable RS232 interrupts
        EI
        LD	HL,FLAGS
        RES	3,(HL)			; flag RS232 not open
        POP	HL
        RET

J42CD:	LD	A,C
        CALL	C4FE5			; RS232 sndchr
        EI
        JP	C,J44BF
        JP	Z,J44BF
        RET

J42D9:	CALL	C42E0			; RS232 getchr
        JP	M,J44BF
        RET

;	  Subroutine RS232 getchr
;	     Inputs  ________________________
;	     Outputs ________________________

C42E0:	PUSH	HL
        PUSH	BC
        CALL	C43B2
        LD	C,(HL)
        LD	(HL),00H
        DEC	HL
        LD	A,(HL)
        LD	(ERRORS),A
        LD	(HL),00H
        INC	HL
        AND	A
        JR	NZ,J431A
        LD	A,C
        AND	A
        JR	NZ,J4306
        CALL	C4E8E
        EI
        LD	C,A
        JP	M,J431A
        CALL	C50B3
        JR	C,J431A
        JR	Z,J431A
J4306:	PUSH	HL
        LD	HL,(RSFCB)
        LD	A,(HL)
        POP	HL
        CP	04H	; 4 
        JR	Z,J431E
        LD	A,C
        CP	1AH
        JR	NZ,J431E
        LD	(HL),A
        AND	A
        SCF
        JR	J4321
J431A:	OR	80H
        JR	J4320
J431E:	XOR	A
        INC	A
J4320:	LD	A,C
J4321:	POP	BC
        POP	HL
        RET

J4324:	PUSH	HL
        CALL	C4332			; RS232 loc
J4328:	LD	(DAC+2),HL
        LD	HL,VALTYP
        LD	(HL),2
        POP	HL
        RET

;	  Subroutine RS232 loc
;	     Inputs  ________________________
;	     Outputs ________________________

C4332:	PUSH	AF
        EI
        LD	HL,(RSFCB)
        LD	A,(HL)
        CP	01H	; 1 
        JR	NZ,J434F
        CALL	C43AA
        JR	Z,J4347
        SUB	1AH
        JR	Z,J4352
        LD	A,01H	; 1 
J4347:	PUSH	BC
        CALL	C43B9
        ADD	A,B
        POP	BC
        JR	J4352
J434F:	CALL	C4E7A
J4352:	LD	L,A
        LD	H,00H
        POP	AF
        RET

J4357:	PUSH	HL
        CALL	C435D			; RS232 lof
J435B:	JR	J4328

;	  Subroutine RS232 lof
;	     Inputs  ________________________
;	     Outputs ________________________

C435D:	PUSH	AF
        EI
        CALL	C4332			; RS232 loc
        PUSH	DE
        EX	DE,HL
        LD	A,(RSIQLN)
        LD	L,A
        LD	H,00H
        AND	A
        SBC	HL,DE
        INC	HL
        POP	DE
        POP	AF
        RET

J4371:	PUSH	HL
        CALL	C437A
        JP	M,J44BF
        JR	J435B

;	  Subroutine __________________________
;	     Inputs  ________________________
;	     Outputs ________________________

C437A:	PUSH	BC
        LD	B,A
        EI
        CALL	C42E0			; RS232 getchr
        JP	M,J4397
        PUSH	BC
        LD	C,A
        CALL	C439A			; RS232 backup
        POP	BC
        CP	1AH
        JR	Z,J4393
        XOR	A
        LD	L,A
        LD	H,A
        INC	A
        JR	J4397
J4393:	LD	HL,0FFFFH
        SCF
J4397:	LD	A,B
        POP	BC
        RET

;	  Subroutine RS232 backup
;	     Inputs  ________________________
;	     Outputs ________________________

C439A:	PUSH	HL
        CALL	C43B2
        LD	(HL),C
        PUSH	AF
        DEC	HL
        LD	A,(ERRORS)
        AND	38H	; "8"
        LD	(HL),A
        POP	AF
        POP	HL
        RET

;	  Subroutine __________________________
;	     Inputs  ________________________
;	     Outputs ________________________

C43AA:	PUSH	HL
        CALL	C43B2
        LD	A,(HL)
        POP	HL
        AND	A
        RET

;	  Subroutine __________________________
;	     Inputs  ________________________
;	     Outputs ________________________

C43B2:	LD	HL,(RSFCB)
        INC	HL
        INC	HL
        INC	HL
        RET

;	  Subroutine __________________________
;	     Inputs  ________________________
;	     Outputs ________________________

C43B9:	PUSH	AF
        PUSH	HL
        LD	B,00H
        CALL	C4E89			; check if characters in receive buffer
        JR	Z,J43CF			; nope,
        LD	C,A
J43C3:	CALL	C43D2
        LD	A,(HL)
        CP	1AH
        JR	Z,J43CF
        INC	B
        DEC	C
        JR	NZ,J43C3
J43CF:	POP	HL
        POP	AF
        RET

;	  Subroutine __________________________
;	     Inputs  ________________________
;	     Outputs ________________________

C43D2:	PUSH	DE
        LD	A,(DATCNT+1)
        LD	HL,RSIQLN
        ADD	A,B
        JR	C,J43DF
        CP	(HL)
        JR	C,J43E0
J43DF:	SUB	(HL)
J43E0:	LD	HL,(RSFCB)
        LD	E,09H	; 9 
        LD	D,00H
        ADD	HL,DE
        LD	E,A
        LD	D,00H
        ADD	HL,DE
        ADD	HL,DE
        POP	DE
        RET

I43EF:	EI
        PUSH	AF
        LD	A,D
        INC	A			; system exclusive ?
        JP	Z,J4446
        DEC	A			; broadcast ?
        JP	NZ,J4459
        LD	A,E
        AND	A			; build device name table ?
        JR	Z,J440A			; yep,
        DEC	A			; return numer of trap entries ?
        JR	Z,J4417
        DEC	A			; disable interrupt ?
        JR	Z,J441D
        DEC	A			; enable interrupt ?
        JR	Z,J4431
        JP	J4474

J440A:	LD	A,08H			; RS232 device
        CALL	C44C6
        LD	A,00H			; reserved byte
        CALL	C44C6
        JP	J4474

J4417:	POP	AF
        INC	A			; RS232 uses 1 trap
        PUSH	AF
        JP	J4474

J441D:	CALL	C4C3B			; RS232 port open ?
        JR	Z,J442E			; nope,
        PUSH	BC
        CALL	C4FB1			; signal sender to stop sending
        EI
        NOP
        POP	BC
        DI
        CALL	C4E66			; disable RS232 interrupts
        EI
J442E:	JP	J4474

J4431:	CALL	C4C3B			; RS232 port open ?
        JR	Z,J4443			; nope,
        DI
        CALL	C4E6D			; enable RS232 interrupts
        CALL	C5134			; RTS=1
        PUSH	BC
        CALL	C4F97			; signal sender to resume sending
        POP	BC
        EI
J4443:	JP	J4474

J4446:	LD	A,E
        AND	A
        JR	NZ,J4457
        CALL	C4478			; slotid and jumptable
        LD	A,00H			; makerid = ASCII
        CALL	C44C6
        LD	A,00H			; reserved byte
        CALL	C44C6
J4457:	JR	J4474
J4459:	CP	08H			; RS232 ?
        JR	NZ,J4474		; nope, other extended bios should handle this
        LD	A,E
        AND	A			; Build slot address table ?
        JR	Z,J4467			; yep,
        CP	1			; Return number of channels ?
        JR	Z,J4471
        JR	J4474

J4467:	CALL	C4478			; slotid and jumptable
        LD	A,00H			; reserved byte
        CALL	C44C6
        JR	J4474
J4471:	POP	AF
        INC	A			; RS232 has 1 channel
        PUSH	AF
J4474:	POP	AF
        JP	MEXBIH

;	  Subroutine __________________________
;	     Inputs  ________________________
;	     Outputs ________________________

C4478:	CALL	C4E4A			; get my slotid
        CALL	C44C6
        LD	A,10H
        CALL	C44C6
        LD	A,40H
        CALL	C44C6
        RET

J4489:	LD	IX,DERBFN
        JR	J44C3
?448F:	LD	IX,DERIER
        JR	J44C3
J4495:	LD	IX,DERSOO
        JR	J44C3
J449B:	LD	IX,DERFAO
        JR	J44C3
J44A1:	LD	IX,DERFNO
        JR	J44C3
J44A7:	LD	IX,USERR
        JR	J44C3
J44AD:	LD	IX,SNERR
        JR	J44C3
J44B3:	LD	IX,FCERR
        JR	J44C3
J44B9:	LD	IX,TMERR
        JR	J44C3
J44BF:	LD	IX,DIOERR
J44C3:	JP	C4598			; call mainrom and enable interrupts

;	  Subroutine __________________________
;	     Inputs  ________________________
;	     Outputs ________________________

C44C6:	PUSH	AF
        PUSH	BC
        PUSH	DE
        PUSH	IX
        LD	E,A
        LD	A,B
        LD	IX,WRSLT
        CALL	C459D			; call mainrom
        EI
        INC	HL
        POP	IX
        POP	DE
        POP	BC
        POP	AF
        RET

;	  Subroutine __________________________
;	     Inputs  ________________________
;	     Outputs ________________________

C44DC:	PUSH	BC
        PUSH	DE
        PUSH	IX
        LD	A,B
        LD	IX,RDSLT
        CALL	C459D			; call mainrom
        EI
        INC	HL
        POP	IX
        POP	DE
        POP	BC
        RET

;	  Subroutine __________________________
;	     Inputs  ________________________
;	     Outputs ________________________

C44EF:	PUSH	IX
        LD	IX,BREAKX
        CALL	C459D			; call mainrom
        POP	IX
        RET

;	  Subroutine __________________________
;	     Inputs  ________________________
;	     Outputs ________________________

C44FB:	PUSH	BC
        LD	B,A
        LD	A,(BUF+3)
        AND	A
        JR	Z,J4521
        LD	A,B
        CP	20H	; " "
        JR	NC,J4521
        LD	A,5EH	; "^"
        CALL	C4523
        LD	A,B
        ADD	A,40H	; "@"
        CALL	C4523
        LD	A,B
        CP	0AH	; 10 
        POP	BC
        RET	NZ
        LD	A,0DH	; 13 
        CALL	C4523
        LD	A,0AH	; 10 
        JR	C4523
J4521:	LD	A,B
        POP	BC

;	  Subroutine __________________________
;	     Inputs  ________________________
;	     Outputs ________________________

C4523:	PUSH	AF
        CALL	CHPUT
        EI
        LD	A,(BUF+5)
        AND	A
        JR	Z,J4534
        POP	AF
        PUSH	AF
        CALL	LPTOUT
        EI
J4534:	POP	AF
        RET

;	  Subroutine __________________________
;	     Inputs  ________________________
;	     Outputs ________________________

C4536:	LD	A,(HL)
        EX	(SP),HL
        CP	(HL)
        JP	NZ,J44AD
        INC	HL
        EX	(SP),HL

;	  Subroutine get next BASIC character
;	     Inputs  ________________________
;	     Outputs ________________________

C453E:	PUSH	IX
        LD	IX,CHRGTR
        EXX
        PUSH	HL
        EXX
        CALL	C4598			; call mainrom and enable interrupts
        EXX
        POP	HL
        EXX
        POP	IX
        RET

;	  Subroutine __________________________
;	     Inputs  ________________________
;	     Outputs ________________________

C4550:	PUSH	IX
        LD	IX,FRMEVL
        CALL	C4598			; call mainrom and enable interrupts
        POP	IX
        RET

;	  Subroutine __________________________
;	     Inputs  ________________________
;	     Outputs ________________________

C455C:	PUSH	IX
        LD	IX,FRMQNT
        CALL	C4598			; call mainrom and enable interrupts
        POP	IX
        RET

;	  Subroutine __________________________
;	     Inputs  ________________________
;	     Outputs ________________________

C4568:	PUSH	IX
        LD	IX,GETBYT
        CALL	C4598			; call mainrom and enable interrupts
        POP	IX
        RET

;	  Subroutine __________________________
;	     Inputs  ________________________
;	     Outputs ________________________

C4574:	PUSH	IX
        LD	IX,PTRGET
        CALL	C4598			; call mainrom and enable interrupts
        POP	IX
        RET

;	  Subroutine __________________________
;	     Inputs  ________________________
;	     Outputs ________________________

C4580:	PUSH	IX
        LD	IX,FRESTR
        CALL	C4598			; call mainrom and enable interrupts
        POP	IX
        RET

;	  Subroutine __________________________
;	     Inputs  ________________________
;	     Outputs ________________________

C458C:	PUSH	IX
        LD	IX,DOCNVF
        CALL	C4598			; call mainrom and enable interrupts
        POP	IX
        RET

;	  Subroutine call mainrom and enable interrupts
;	     Inputs  ________________________
;	     Outputs ________________________

C4598:	CALL	C459D			; call mainrom
        EI
        RET

;	  Subroutine call mainrom
;	     Inputs  ________________________
;	     Outputs ________________________

C459D:	PUSH	IY
        LD	IY,(EXPTBL+0-1)
        CALL	CALSLT
        POP	IY
        RET

;	  Subroutine CALL COMINI statement
;	     Inputs  ________________________
;	     Outputs ________________________

J45A9:	CALL	C4C41
        CALL	C4C3B			; RS232 port open ?
        DI
        CALL	C4E66			; disable RS232 interrupts
        EI
        LD	A,(LSTCOM)
        LD	(BUF+2),A
        LD	IY,BUF+9
        PUSH	BC
        PUSH	DE
        PUSH	HL
        LD	BC,13
        PUSH	IY
        POP	DE
        LD	HL,I4143
        LDIR
        POP	HL
        POP	DE
        POP	BC
        LD	A,B
        AND	C
        INC	A
        JR	NZ,J45E9
        LD	A,D
        AND	A
        JP	Z,J4655
        CP	3AH	; ":"
        JP	Z,J4655
        CP	29H	; ")"
        JP	Z,J4652
        CALL	C4536
        DEFB	","
        JR	J460F
J45E9:	PUSH	HL
        EXX
        PUSH	HL
        EXX
        POP	HL
        LD	A,B
        AND	A
        JR	Z,J4602
        PUSH	IY
        POP	DE
J45F5:	LD	A,(HL)
        CP	20H	; " "
        JR	Z,J45FE
        CALL	C4CED			; to uppercase
        LD	(DE),A
J45FE:	INC	DE
        INC	HL
        DJNZ	J45F5
J4602:	POP	HL
        DEC	HL
        CALL	C453E			; get next BASIC character
        CP	")"
        JR	Z,J4652
        CALL	C4536
        DEFB	","
J460F:	CP	","
        JR	Z,J4629
        CALL	C455C
        LD	(IY+8),E
        LD	(IY+9),D
        LD	A,(HL)
        CP	29H	; ")"
        JR	NZ,J4629
        LD	(IY+10),E
        LD	(IY+11),D
        JR	J4652
J4629:	CALL	C4536
        DEFB	","
        CP	","
        JR	Z,J463F
        CALL	C455C
        LD	(IY+10),E
        LD	(IY+11),D
        LD	A,(HL)
        CP	29H	; ")"
        JR	Z,J4652
J463F:	CALL	C4536
        DEFB	","
        CP	")"
        JR	Z,J4652
        CALL	C4568
        LD	(IY+12),A
        CALL	C4536
        DEFB	")"
        DEC	HL
J4652:	CALL	C453E			; get next BASIC character
J4655:	EI
        CALL	C4CF6			; initialize RS232
        JP	C,J44B3			; illegal function call
        CALL	C4C3B			; RS232 port open ?
        CALL	NZ,C4E6D		; yep, enable RS232 interrupts
        LD	A,(BUF+2)
        BIT	5,A
        CALL	NZ,C5134		; RTS=1
        AND	A
        RET

;	  Subroutine CALL COMDTR statement
;	     Inputs  ________________________
;	     Outputs ________________________

J466C:	CALL	C4C41
        CALL	C4CAA
        CALL	C4536
        DEFB	","
        CALL	C4C3B			; RS232 port open ?
        JP	Z,J44A1			; nope,
        CALL	C455C
        CALL	C4536
        DEFB	")"
        LD	A,D
        OR	E
        CALL	C5147			; RS232 dtr
        EI
        RET

;	  Subroutine CALL COMSTAT statement
;	     Inputs  ________________________
;	     Outputs ________________________

J468A:	CALL	C4C41
        CALL	C4CAA
        CALL	C4536
        DEFB	","
        CALL	C4C3B			; RS232 port open ?
        JP	Z,J44A1			; nope,
        CALL	C4574
        PUSH	HL
        CALL	C515F			; RS232 stat
        LD	(DAC+2),HL
        POP	HL
        CALL	C4CB4
        CALL	C4536
        DEFB	")"
        AND	A
        RET

;	  Subroutine CALL COMBREAK statement
;	     Inputs  ________________________
;	     Outputs ________________________

J46AE:	CALL	C4C41
        CALL	C4CAA
        CALL	C4C3B			; RS232 port open ?
        JP	Z,J44A1			; nope,
        LD	A,D
        CP	2CH	; ","
        JR	Z,J46CF
        AND	A
        JR	Z,J46CA
        CP	3AH	; ":"
        JR	Z,J46CA
        CALL	C4536
        DEFB	")"
J46CA:	LD	DE,10
        JR	J46D9
J46CF:	CALL	C453E			; get next BASIC character
        CALL	C455C
        CALL	C4536
        DEFB	")"
J46D9:	PUSH	HL
        LD	HL,2
        AND	A
        SBC	HL,DE
        JP	NC,J44B3		; illegal function call
        POP	HL
        CALL	C50EE			; RS232 sndbrk
        EI
        LD	A,00H
        INC	A
        CALL	C50B3
        JP	C,J44BF
        AND	A
        RET

;	  Subroutine CALL COMTERM statement
;	     Inputs  ________________________
;	     Outputs ________________________

J46F3:	CALL	C4C41
        CALL	C4CAA
        LD	A,D
        AND	A
        JR	Z,J4705
        CP	":"
        JR	Z,J4705
        CALL	C4536
        DEFB	")"
J4705:	LD	(BUF+7),HL
        CALL	C4C3B			; RS232 port open ?
        JP	NZ,J449B		; yep, file already open
        XOR	A
        LD	(BUF+0),A
        LD	(BUF+5),A
        LD	(BUF+3),A
        LD	(BUF+4),A
        LD	HL,FNKSTR+5*16
        LD	DE,BUF+16
        LD	BC,3*16
        PUSH	BC
        PUSH	HL
        LDIR
        POP	HL
        POP	BC
        LD	B,C
        PUSH	HL
J472C:	LD	(HL),00H
        INC	HL
        DJNZ	J472C
        POP	DE
        LD	HL,I490C
        LD	BC,5
        PUSH	BC
        LDIR
        POP	BC
        LD	DE,FNKSTR+6*16
        PUSH	BC
        LDIR
        POP	BC
        LD	DE,FNKSTR+7*16
        PUSH	BC
        LDIR
        POP	BC
        LD	A,(CSRSR)
        LD	(BUF+6),A
        CALL	C492D
        LD	HL,(NULBUF)
        LD	E,4
        LD	C,120
        CALL	C4270			; RS232 open
J475D:	EI
        CALL	C4332			; RS232 loc
        LD	A,L
        OR	H
        JR	Z,J478F
        CALL	C491B
        JR	C,J47BB
        LD	C,A
        LD	A,(BUF+0)
        AND	A
        JR	NZ,J4781
        LD	A,C
        CP	1BH
        JR	NZ,J477C
        LD	A,01H	; 1 
        LD	(BUF+0),A
        LD	A,C
J477C:	CALL	C44FB
        JR	J478F
J4781:	XOR	A
        LD	(BUF+0),A
        LD	A,C
        CP	1BH
        JR	NZ,J477C
        CALL	C44FB
        JR	J47DE

J478F:	CALL	C494F
        CALL	NZ,C4925
        CALL	C44EF
        JR	C,J47BB
        CALL	CHSNS
        EI
        JR	Z,J475D
        CALL	CHGET
        EI
        CP	0A0H
        JP	Z,J48EB
        CALL	C4920
        LD	C,A
        LD	A,(BUF+4)
        AND	A
        JP	Z,J475D
        LD	A,C
        CALL	C44FB
        JP	J475D

J47BB:	CALL	C42AB			; RS232 close
        LD	HL,BUF+16
        LD	DE,FNKSTR+5*16
        LD	BC,3*16
        LDIR
        LD	HL,(BUF+7)
        LD	A,(BUF+6)
        AND	A
        PUSH	AF
        CALL	Z,C493D
        POP	AF
        CALL	NZ,C492D
        XOR	A
        DI
        LD	(INTFLG),A
        RET

J47DE:	LD	A,(BUF+3)
        AND	A
        JP	NZ,J475D
        CALL	C493D
        LD	A,0FFH
        LD	(BUF+1),A
J47ED:	CALL	C491B
        JP	C,J47BB
        CP	3AH	; ":"
        JR	NZ,J47ED
        CALL	C48B9
        JP	C,J4870
        AND	A
        JR	Z,J4847
I4800:	LD	B,A
        LD	E,A
        CALL	C48AE
        JP	C,J4870
        CALL	C48B9
        JP	C,J4870
        ADD	A,L
        ADD	A,H
        ADD	A,E
        LD	E,A
J4812:	CALL	C48B9
        JR	C,J4870
        LD	(HL),A
        ADD	A,E
        LD	E,A
        INC	HL
        DJNZ	J4812
        CALL	C48B9
        JR	C,J4870
        ADD	A,E
        JR	NZ,J4870
        LD	A,47H	; "G"
        CALL	C4920
        LD	A,(BUF+1)
        AND	A
        JR	Z,J483B
        INC	A
        LD	(BUF+1),A
        LD	A,2AH	; "*"
        CALL	C44FB
        JR	J4844
J483B:	DEC	A
        LD	(BUF+1),A
        LD	A,7FH
        CALL	C44FB
J4844:	JP	J47ED
J4847:	CALL	C48AE
        JR	C,J4870
        LD	A,H
        OR	L
        JR	NZ,J4878
        CALL	C48B9
        JR	C,J4870
        CP	01H	; 1 
        JR	NZ,J4870
        CALL	C48B9
        JR	C,J4870
        CP	0FFH
        JR	NZ,J4870
J4862:	LD	A,47H	; "G"
        CALL	C4920
        CALL	C4946
        CALL	C492D
        JP	J475D

J4870:	LD	A,42H	; "B"
        CALL	C4920
        JP	J47ED

J4878:	CALL	C48B9
        JR	C,J4870
        CP	01H	; 1 
        JR	NZ,J4870
        ADD	A,L
        ADD	A,H
        LD	E,A
        CALL	C48B9
        JR	C,J4870
        ADD	A,E
        JR	NZ,J4870
        CALL	C491B
        JP	C,J47BB
        CP	0AH	; 10 
        JR	NZ,J4862
        LD	A,47H	; "G"
        CALL	C4920
        CALL	C4946
        PUSH	IX
        PUSH	HL
        LD	HL,I48A6
        EX	(SP),HL
        JP	(HL)

I48A6:	POP	IX
        CALL	C492D
        JP	J475D

;	  Subroutine __________________________
;	     Inputs  ________________________
;	     Outputs ________________________

C48AE:	CALL	C48B9
        RET	C
        LD	H,A
        CALL	C48B9
        RET	C
        LD	L,A
        RET

;	  Subroutine __________________________
;	     Inputs  ________________________
;	     Outputs ________________________

C48B9:	PUSH	BC
        CALL	C491B
        JR	C,J48D4
        CALL	C48D6
        JR	C,J48D4
        ADD	A,A
        ADD	A,A
        ADD	A,A
        ADD	A,A
        LD	B,A
        CALL	C491B
        JR	C,J48D4
        CALL	C48D6
        JR	C,J48D4
        ADD	A,B
J48D4:	POP	BC
        RET

;	  Subroutine __________________________
;	     Inputs  ________________________
;	     Outputs ________________________

C48D6:	CALL	C4CED			; to uppercase
        SUB	"0"
        RET	C
        CP	0AH
        JR	C,J48E9
        SUB	11H
        RET	C
        CP	06H
        CCF
        RET	C
        ADD	A,0AH	; 10 
J48E9:	AND	A
        RET

J48EB:	CALL	CHGET
        EI
        SUB	06H
        JR	Z,J48FE
        DEC	A
        JR	Z,J4903
        DEC	A
        JR	NZ,J4909
        LD	HL,BUF+5
        JR	J4906
J48FE:	LD	HL,BUF+3
        JR	J4906
J4903:	LD	HL,BUF+4
J4906:	LD	A,(HL)
        CPL
        LD	(HL),A
J4909:	JP	J475D

I490C:	DEFB	0A0H,006H,000H,06CH,069H
        DEFB	0A0H,007H,000H,068H,066H
        DEFB	0A0H,008H,000H,070H,065H

;	  Subroutine __________________________
;	     Inputs  ________________________
;	     Outputs ________________________

C491B:	CALL	C4E8E
        EI
        RET

;	  Subroutine __________________________
;	     Inputs  ________________________
;	     Outputs ________________________

C4920:	CALL	C4FE5			; RS232 sndchr
        EI
        RET

;	  Subroutine __________________________
;	     Inputs  ________________________
;	     Outputs ________________________

C4925:	LD	DE,100
        CALL	C50EE			; RS232 sndbrk
        EI
        RET

;	  Subroutine __________________________
;	     Inputs  ________________________
;	     Outputs ________________________

C492D:	LD	A,1BH
        CALL	C44FB
        LD	A,"y"
J4934:	CALL	C44FB
        LD	A,"5"
J4939:	CALL	C44FB
        RET

;	  Subroutine __________________________
;	     Inputs  ________________________
;	     Outputs ________________________

C493D:	LD	A,1BH
        CALL	C44FB
        LD	A,"x"
        JR	J4934

;	  Subroutine __________________________
;	     Inputs  ________________________
;	     Outputs ________________________

C4946:	LD	A,0DH
        CALL	C44FB
        LD	A,0AH
        JR	J4939

;	  Subroutine __________________________
;	     Inputs  ________________________
;	     Outputs ________________________

C494F:	LD	A,(INTFLG)
        AND	A
        RET	Z
        XOR	A
        LD	(INTFLG),A
        INC	A
        RET

;	  Subroutine CALL COMHELP statement
;	     Inputs  ________________________
;	     Outputs ________________________

J495A:	CALL	C4C41
        CALL	C4CAA
        LD	A,D
        AND	A
        JR	Z,J496C
        CP	3AH	; ":"
        JR	Z,J496C
        CALL	C4536
        DEFB	")"
J496C:	XOR	A
        LD	(BUF+3),A
        LD	(BUF+5),A
        LD	(BUF+4),A
        PUSH	HL
        CALL	C4946
        LD	HL,I49B3
J497D:	LD	A,(HL)
        INC	HL
        INC	A
        JR	Z,J49B0
        DEC	A
        JR	Z,J4992
        CALL	C44FB
        LD	A,(INTFLG)
        AND	A
        JR	Z,J497D
        CP	03H	; 3 
        JR	Z,J49B0
J4992:	PUSH	HL
        LD	HL,INTFLG
        LD	(HL),00H
        CALL	C492D
J499B:	EI
        LD	A,(HL)
        AND	A
        JR	Z,J499B
        PUSH	AF
        CALL	C493D
        POP	AF
        POP	HL
        CP	03H	; 3 
        JR	Z,J49B0
        XOR	A
        LD	(INTFLG),A
        JR	J497D
J49B0:	POP	HL
        AND	A
        RET

I49B3:	DEFB	"Initialize statement options",13,10
        DEFB	13,10
        DEFB	'CALL COMINI ("',13,10
        DEFB	"<device# {0,1,2...9}>:",13,10
        DEFB	"<character length {5,6,7,8}>",13,10
        DEFB	"<parity {E,O,I,N}>",13,10
        DEFB	"<stop bits {1,2,3}>",13,10
        DEFB	"<XON/XOFF {X,N}>",13,10
        DEFB	"<CTS hand-shake {H,N}>",13,10
        DEFB	"auto LF on receive {A,N}>",13,10
        DEFB	"auto LF on transmit {A,N}>",13,10
        DEFB	'SI/SO {S,N}>"',13,10
        DEFB	",<receiver baud rate>",13,10
        DEFB	",<transmitter baud rate>",13,10
        DEFB	",<time out count>",13,10
        DEFB	"                          )",13,10
        DEFB	"Default:",13,10
        DEFB	' CALL COMINI("0:8N1XHNNN"',13,10
        DEFB	"      ,1200,1200,0)",13,10
        DEFB	-1

;	  Subroutine CALL COM statement
;	     Inputs  ________________________
;	     Outputs ________________________

J4B51:	CALL	C4C41
        CALL	C4CAA
        CALL	C4C2E			; get trap number
        JP	C,J44B3			; illegal function call
J4B5D:	CALL	C4536
        DEFB	","
J4B61:	CALL	C4536
        DEFB	08DH
J4B65:	LD	IX,T4769		; collect linenumber
        CALL	C4598			; call mainrom and enable interrupts
        PUSH	HL
        LD	A,E
        OR	D			; linenumber = 0 ?
        JR	Z,J4B7D			; yep,
        LD	IX,T4295		; search linenumber
        CALL	C4598			; call mainrom and enable interrupts
        JP	NC,J44A7		; not found,
        LD	E,C
        LD	D,B
J4B7D:	CALL	C4C1B			; get trap entry
J4B80:	INC	HL
        LD	(HL),E
        INC	HL
        LD	(HL),D
        POP	HL
        CALL	C4536
        DEFB	")"
        AND	A
        RET

;	  Subroutine CALL COMOFF statement
;	     Inputs  ________________________
;	     Outputs ________________________

J4B8B:	CALL	C4C41
        CALL	C4CAA
        LD	A,D
        AND	A
        JR	Z,J4B9D
        CP	":"
        JR	Z,J4B9D
        CALL	C4536
        DEFB	")"
J4B9D:	CALL	C4C2E			; get trap number
        JP	C,J44B3			; illegal function call
        LD	IX,T632B		; disable trap
        JR	J4BF0

;	  Subroutine CALL COMON statement
;	     Inputs  ________________________
;	     Outputs ________________________

J4BA9:	CALL	C4C41
        CALL	C4CAA
        LD	A,D
        AND	A
        JR	Z,J4BBB
        CP	":"
        JR	Z,J4BBB
        CALL	C4536
        DEFB	")"
J4BBB:	CALL	C4C2E			; get trap number
        JP	C,J44B3			; illegal function call
        LD	IX,T631B		; enable trap
        JR	J4BE3

;	  Subroutine CALL COMSTOP statement
;	     Inputs  ________________________
;	     Outputs ________________________

J4BC7:	CALL	C4C41
        CALL	C4CAA
        LD	A,D
        AND	A
        JR	Z,J4BD9
        CP	":"
        JR	Z,J4BD9
        CALL	C4536
        DEFB	")"
J4BD9:	CALL	C4C2E			; get trap number
        JP	C,J44B3			; illegal function call
        LD	IX,T6331		; pause trap
J4BE3:	PUSH	HL
        PUSH	AF
        CALL	C4C1B			; get trap entry
        LD	A,(HL)
        AND	01H			; trap enabled ?
        CALL	Z,C4135			; nope, empty receive buffer and clear error flags
        POP	AF
        POP	HL
J4BF0:	PUSH	HL
        CALL	C4C1B			; get trap entry
        CALL	C4598			; call mainrom and enable interrupts
        POP	HL
        AND	A
        RET

;	  Subroutine new statement handler
;	     Inputs  ________________________
;	     Outputs ________________________

I4BFA:	EI
        CALL	C4E7A
        PUSH	HL
        CALL	NZ,C4C06
        POP	HL
        JP	OLDSTT

;	  Subroutine __________________________
;	     Inputs  ________________________
;	     Outputs ________________________

C4C06:	CALL	C4C1B			; get trap entry
        LD	A,(HL)
        AND	01H			; trap enabled ?
        RET	Z			; nope, quit
        LD	A,(HL)
        OR	04H
        CP	(HL)			; trap occured already set ?
        RET	Z			; yep, quit
        CP	05H			; trap enabled and trap occured and trap not paused ?
        RET	NZ			; trap paused, quit
        LD	(HL),A			; flag trap occured
        LD	HL,ONGSBF
        INC	(HL)			; increase trap counter
        RET

;	  Subroutine get trap entry
;	     Inputs  ________________________
;	     Outputs ________________________

C4C1B:	CALL	C4C2E			; get trap number
        JP	C,J44B3			; illegal function call
        PUSH	BC
        LD	C,A
        ADD	A,A
        ADD	A,C
        LD	C,A
        LD	B,0
        LD	HL,TRPTBL+18*3
        ADD	HL,BC
        POP	BC
        RET

;	  Subroutine get trap number
;	     Inputs  ________________________
;	     Outputs ________________________

C4C2E:	LD	A,(DEVNUM)
        AND	0F0H
        RRCA
        RRCA
        RRCA
        RRCA
        CP	06H
        CCF
        RET

;	  Subroutine RS232 port open ?
;	     Inputs  ________________________
;	     Outputs ________________________

C4C3B:	LD	A,(FLAGS)
        BIT	3,A
        RET

;	  Subroutine __________________________
;	     Inputs  ________________________
;	     Outputs ________________________

C4C41:	DEC	HL
        CALL	C453E			; get next BASIC character
        LD	D,A
        JR	NZ,J4C4F
J4C48:	XOR	A
        LD	BC,0FFFFH
        PUSH	HL
        JR	J4C8D
J4C4F:	CP	"("
        JP	Z,J4C5A
        CP	2CH	; ","
        JR	Z,J4C48
        JR	J4C62
J4C5A:	CALL	C453E			; get next BASIC character
        LD	D,A
        CP	2CH	; ","
        JR	Z,J4C48
J4C62:	CALL	C4550
        PUSH	HL
        CALL	C4580
        LD	C,00H
        LD	B,(HL)
        INC	HL
        LD	A,(HL)
        INC	HL
        LD	H,(HL)
        LD	L,A
        LD	A,B
        AND	A
        JR	Z,J4C8D
        INC	HL
        LD	A,(HL)
        CP	3AH	; ":"
        JR	Z,J4C7F
        DEC	HL
        XOR	A
        JR	J4C8D
J4C7F:	DEC	HL
        LD	A,(HL)
        SUB	"0"
        JR	C,J4CA7
        CP	0AH
        JR	NC,J4CA7
        INC	HL
        INC	HL
        DEC	B
        DEC	B
J4C8D:	LD	E,A
        LD	A,(DEVNUM)
        AND	0FH			; get device number
        PUSH	HL
        EXX
        POP	HL
        EXX
        POP	HL
        PUSH	AF
        DEC	HL
        CALL	C453E			; get next BASIC character
        LD	D,A
        POP	AF
        CP	E
        RET	Z
J4CA1:	POP	HL
        PUSH	IX
        POP	HL
        SCF
        RET
J4CA7:	POP	HL
        JR	J4CA1

;	  Subroutine __________________________
;	     Inputs  ________________________
;	     Outputs ________________________

C4CAA:	LD	A,B
        OR	C
        RET	Z
        LD	A,B
        AND	C
        INC	A
        RET	Z
        JP	J44B3			; illegal function call

;	  Subroutine __________________________
;	     Inputs  ________________________
;	     Outputs ________________________

C4CB4:	PUSH	HL
        LD	HL,VALTYP
        LD	A,(HL)
        CP	2
        JR	Z,J4CE2
        CP	4
        JR	Z,J4CD2
        CP	8
        JP	NZ,J44B9
        LD	(HL),2
        PUSH	DE
        LD	A,08H	; 8 
        CALL	C458C
        LD	C,08H	; 8 
        JR	J4CDC
J4CD2:	LD	(HL),02H	; 2 
        PUSH	DE
        LD	A,04H	; 4 
        CALL	C458C
        LD	C,04H	; 4 
J4CDC:	POP	DE
        LD	HL,DAC+0
        JR	J4CE7
J4CE2:	LD	HL,DAC+2
        LD	C,02H	; 2 
J4CE7:	LD	B,00H
        LDIR
        POP	HL
        RET

;	  Subroutine to uppercase
;	     Inputs  ________________________
;	     Outputs ________________________

C4CED:	CP	"a"
        RET	C
        CP	"z"+1
        RET	NC
        SUB	20H
        RET

;	  Subroutine initialize RS232
;	     Inputs  ________________________
;	     Outputs ________________________

C4CF6:	LD	A,(IY+0)
        SUB	"5"
        CP	04H
        JR	NC,J4D17
        LD	B,A
        LD	D,A
        CALL	C4DCB
        LD	A,(IY+1)
        CP	"E"
        JR	Z,J4D19
        CP	"O"
        JR	Z,J4D1B
        CP	"I"
        JR	Z,J4D1F
        CP	"N"
        JR	Z,J4D26
J4D17:	SCF
        RET

J4D19:	SET	3,B
J4D1B:	SET	2,B
        JR	J4D26

J4D1F:	LD	A,B
        CP	03H	; 3 
        JP	Z,J4D17
        INC	B
J4D26:	RLC	B
        RLC	B
        LD	A,(IY+2)
        SUB	"1"
        CP	03H
        JP	NC,J4D17
        INC	A
        RRCA
        RRCA
        OR	B
        LD	B,A
        LD	C,00H
        LD	A,(IY+3)
        CP	"X"
        JR	NZ,J4D46
        SET	0,C			; use XON/XOFF protocol
        JR	J4D4B
J4D46:	CP	"N"
        JP	NZ,J4D17
J4D4B:	LD	A,(IY+4)
        CP	"H"
        JR	NZ,J4D56
        SET	1,C			; use RTS/CTS handshake
        JR	J4D5B
J4D56:	CP	"N"
        JP	NZ,J4D17
J4D5B:	LD	A,(IY+5)
        CP	"A"
        JR	NZ,J4D66
        SET	3,C			; use Auto LF receive
        JR	J4D6B
J4D66:	CP	"N"
        JP	NZ,J4D17
J4D6B:	LD	A,(IY+6)
        CP	"A"
        JR	NZ,J4D76
        SET	2,C			; use Auto LF send
        JR	J4D7B
J4D76:	CP	"N"
        JP	NZ,J4D17
J4D7B:	LD	A,(IY+7)
        CP	"S"
        JR	NZ,J4D8C
        LD	A,D
        CP	02H	; 2 
        JP	NZ,J4D17
        SET	4,C			; use SI/SO control
        JR	J4D91
J4D8C:	CP	"N"
        JP	NZ,J4D17
J4D91:	LD	A,C
        LD	(ESTBLS),A
        LD	A,02H	; 2 
        OR	B
        LD	(LSTMOD),A
        CALL	C50C5
        LD	E,(IY+8)
        LD	D,(IY+9)
        CALL	C4DDF			; get countervalue
        JP	C,J4D17
        LD	C,0			; timer 0
        CALL	C51DE			; initialize timer
        LD	E,(IY+10)
        LD	D,(IY+11)
        CALL	C4DDF			; get countervalue
        JP	C,J4D17
        LD	C,1			; timer 1
        CALL	C51DE			; initialize timer
        LD	A,(IY+12)
        LD	(TOCNT),A
        CALL	C514A			; DTR=1
        OR	A
        RET

;	  Subroutine __________________________
;	     Inputs  ________________________
;	     Outputs ________________________

C4DCB:	PUSH	AF
        PUSH	BC
        XOR	03H	; 3 
        LD	C,0FFH
        JR	Z,J4DD8
        LD	B,A
J4DD4:	SRL	C
        DJNZ	J4DD4
J4DD8:	LD	A,C
        LD	(COMMSK),A
        POP	BC
        POP	AF
        RET

;	  Subroutine __________________________
;	     Inputs  ________________________
;	     Outputs ________________________

C4DDF:	PUSH	HL
        BIT	7,D
        JR	Z,J4DF1
        LD	A,E
        AND	D
        INC	A
        JR	Z,J4E0D
        LD	HL,0
        SBC	HL,DE
        EX	DE,HL
        JR	J4E0C
J4DF1:	LD	HL,I4E10
J4DF4:	LD	C,(HL)
        INC	HL
        LD	B,(HL)
        INC	HL
        LD	A,B
        OR	C
        JR	Z,J4E0D
        PUSH	HL
        LD	L,E
        LD	H,D
        AND	A
        SBC	HL,BC
        POP	HL
        JR	Z,J4E09
        INC	HL
        INC	HL
        JR	J4DF4
J4E09:	LD	E,(HL)
        INC	HL
        LD	D,(HL)
J4E0C:	SCF
J4E0D:	CCF
        POP	HL
        RET

I4E10:	DEFW	50,00900h
        DEFW	75,00600h
        DEFW	110,00417h
        DEFW	300,00180h
        DEFW	600,000C0h
        DEFW	1200,00060h
        DEFW	1800,00040h
        DEFW	2000,0003Ah
        DEFW	2400,00030h
        DEFW	3600,00020h
        DEFW	4800,00018h
        DEFW	7200,00010h
        DEFW	9600,0000Ch
        DEFW	19200,00006h
        DEFW	0

;	  Subroutine get my slotid
;	     Inputs  ________________________
;	     Outputs ________________________

C4E4A:	PUSH	BC
        PUSH	HL
        IN	A,(0A8H)
        RRCA
        RRCA
        AND	03H
        LD	C,A
        LD	B,00H
        LD	HL,EXPTBL
        ADD	HL,BC
        OR	(HL)
J4E5A:	LD	C,A
        INC	HL
        INC	HL
        INC	HL
        INC	HL
        LD	A,(HL)
        AND	0CH
        OR	C
        POP	HL
        POP	BC
        RET

;	  Subroutine disable RS232 interrupts
;	     Inputs  ________________________
;	     Outputs ________________________

C4E66:	PUSH	AF
        LD	A,0FFH
        OUT	(82H),A
        POP	AF
        RET

;	  Subroutine enable RS232 interrupts
;	     Inputs  ________________________
;	     Outputs ________________________

C4E6D:	PUSH	AF
        LD	A,0FEH
        OUT	(82H),A
        POP	AF
        RET

;	  Subroutine RS232 interrupt handler
;	     Inputs  ________________________
;	     Outputs ________________________

I4E74:	CALL	C4EDA
        JP	OLDINT

;	  Subroutine __________________________
;	     Inputs  ________________________
;	     Outputs ________________________

C4E7A:	CALL	C4E89			; check if characters in receive buffer
        PUSH	BC
        LD	B,A
        CALL	C43AA
        JR	Z,J4E86			; nope,
        LD	A,01H	; 1 
J4E86:	ADD	A,B
        POP	BC
        RET

;	  Subroutine check if characters in receive buffer
;	     Inputs  ________________________
;	     Outputs ________________________

C4E89:	LD	A,(DATCNT+0)
        AND	A
        RET

;	  Subroutine __________________________
;	     Inputs  ________________________
;	     Outputs ________________________

C4E8E:	PUSH	HL
        PUSH	DE
        PUSH	BC
        LD	HL,DATCNT
J4E94:	EI
        CALL	C44EF
        JR	C,J4ED2
        LD	A,(HL)
        AND	A			; characters in receive buffer ?
        JR	NZ,J4EAA		; yep,
        CALL	C5134			; RTS=1
        CALL	C4F97			; signal sender to resume sending
        JR	C,J4ED2
        JR	Z,J4ED2
        JR	J4E94
J4EAA:	CP	3			; 3 or more ?
        JR	NC,J4EB9		; yep,
        CALL	C5134			; RTS=1
        CALL	C4F97			; signal sender to resume sending
        EI
        JR	C,J4ED2
        JR	Z,J4ED2
J4EB9:	DI
        DEC	(HL)
        CALL	C4F7C			; get pointer in receive buffer
        LD	C,(HL)
        LD	B,80H
        INC	HL
        LD	A,(HL)
        LD	(ERRORS),A
        AND	A
        JR	Z,J4ECA
        INC	B
J4ECA:	LD	A,C
        OR	A
        DEC	B
J4ECD:	EI
        POP	BC
        POP	DE
        POP	HL
        RET
J4ED2:	PUSH	AF
        POP	BC
        RES	7,C
        PUSH	BC
        POP	AF
        JR	J4ECD

;	  Subroutine __________________________
;	     Inputs  ________________________
;	     Outputs ________________________

C4EDA:	IN	A,(81H)
        AND	02H
        RET	Z
        IN	A,(80H)
        LD	HL,COMMSK
        AND	(HL)			; mask off unused bits
        LD	C,A
        CALL	C5120			; read error status
        LD	B,A
        AND	A			; errors ?
        JR	NZ,J4F07		; yep,
        LD	HL,FLAGS
        LD	A,C
        CP	11H			; XON ?
        JR	Z,J4EFD			; yep,
        CP	13H			; XOFF ?
        JR	NZ,J4F18		; nope,
        SET	2,(HL)
        JR	J4EFF
J4EFD:	RES	2,(HL)
J4EFF:	LD	A,(ESTBLS)
        BIT	0,A			; use XON/XOFF protocol ?
        RET	NZ			; yep,
        JR	J4F18

J4F07:	AND	20H			; framing error ?
        JR	Z,J4F30			; nope, put in receive buffer
        LD	A,C
        AND	A
        JR	NZ,J4F30
        LD	HL,FLAGS
        SET	4,(HL)
        LD	B,0
        JR	J4F30

J4F18:	LD	A,(ESTBLS)
        BIT	4,A			; use SI/SO protocol ?
        JR	Z,J4F30			; nope,
        LD	HL,FLAGS
        LD	A,C
        SUB	0FH			; SI ?
        JR	NZ,J4F2A
        RES	7,(HL)
        RET
J4F2A:	INC	A			; SO ?
        JR	NZ,J4F30
        SET	7,(HL)			; flag shift-out
        RET

J4F30:	LD	HL,DATCNT+0
        LD	A,(RSIQLN)
        CP	(HL)			; receive buffer full ?
        RET	Z			; yep, quit
        INC	(HL)
        INC	HL
        PUSH	BC
        CALL	C4F7C			; get pointer in receive buffer
        POP	BC
        LD	A,(ESTBLS)
        BIT	4,A			; use SI/SO protocol ?
        LD	A,C
        JR	Z,J4F55			; nope,
        CP	20H			; control character ?
        JR	C,J4F55			; yep,
        LD	A,(FLAGS)
        BIT	7,A			; shift-out ?
        LD	A,C
        JR	Z,J4F55			; nope,
        OR	80H			; yep, set b7 of character
J4F55:	LD	(HL),A			; put character in receive buffer
        PUSH	HL
        LD	HL,DATCNT+0
        LD	A,(RSIQLN)
        SUB	(HL)			; receive buffer full ?
        POP	HL
        JR	NZ,J4F63		; nope,
        SET	7,B			; yep,
J4F63:	CP	16			; receive buffer has <16 room ?
        CALL	C,C4FB1			; yep, signal sender to stop sending
        LD	A,B
        INC	HL
        LD	(HL),A			; put receive status in receive buffer
        DEC	HL
        AND	A			; error ?
        RET	NZ			; yep, quit
        LD	A,(ESTBLS)
        BIT	3,A			; use Auto LF receive ?
        RET	Z			; nope, quit
        LD	A,(HL)
        CP	0DH			; CR received ?
        RET	NZ			; nope, quit
        LD	C,0AH
        JR	J4F30			; put LF in receive buffer

;	  Subroutine get pointer in receive buffer
;	     Inputs  ________________________
;	     Outputs ________________________

C4F7C:	INC	HL
        LD	A,(HL)
        LD	C,A
        INC	A
        PUSH	HL
        LD	HL,RSIQLN
        CP	(HL)
        POP	HL
        JR	C,J4F89
        XOR	A
J4F89:	LD	(HL),A
        EX	DE,HL
        LD	HL,(RSFCB)
        LD	B,0
        ADD	HL,BC
        ADD	HL,BC
        LD	BC,9
        ADD	HL,BC
        RET

;	  Subroutine signal sender to resume sending
;	     Inputs  ________________________
;	     Outputs ________________________

C4F97:	DI
        LD	A,(FLAGS)
        BIT	1,A
        JR	NZ,J4FA2
        XOR	A
        INC	A
        RET
J4FA2:	LD	C,11H			; XON
        CALL	C4FCD			; send XON (if XON/XOFF handshake is enabled)
        RET	C			; CTRL-STOP, quit
        RET	Z			; timeout, quit
        PUSH	HL
        LD	HL,FLAGS
        RES	1,(HL)
        POP	HL
        RET

;	  Subroutine signal sender to stop sending
;	     Inputs  ________________________
;	     Outputs ________________________

C4FB1:	DI
        XOR	A
        INC	A
        LD	A,(FLAGS)
        BIT	1,A			; sender already signaled ?
        RET	NZ			; yep, quit
        PUSH	HL
        LD	HL,FLAGS
        SET	1,(HL)
        POP	HL
        LD	C,13H			; XOFF
        CALL	C4FCD			; send XOFF (if XON/XOFF handshake is enabled)
        CALL	C5185			; wait for empty transmitter
        CALL	C513C			; RTS=0
        RET

;	  Subroutine send XON/XOFF (if XON/XOFF handshake is enabled)
;	     Inputs  ________________________
;	     Outputs ________________________

C4FCD:	LD	A,(ESTBLS)
        BIT	0,A			; use XON/XOFF protocol ?
        JR	NZ,J4FD7		; yep,
        XOR	A
        INC	A
        RET
J4FD7:	CALL	C5185			; wait for empty transmitter
        PUSH	DE
        CALL	C5194			; wait for CTS (if RTS/CTS handshake is enabled)
        POP	DE
        RET	C			; CTRL-STOP, quit
        RET	Z			; timeout, quit
        LD	A,C
        OUT	(80H),A
        RET

;	  Subroutine RS232 sndchr
;	     Inputs  ________________________
;	     Outputs ________________________

C4FE5:	PUSH	BC
        LD	C,A
        CALL	C4FED
        LD	A,C
        POP	BC
        RET

;	  Subroutine __________________________
;	     Inputs  ________________________
;	     Outputs ________________________

C4FED:	EI
        PUSH	BC
        LD	C,A
        LD	A,(ESTBLS)
        BIT	4,A			; use SI/SO protocol ?
        JR	Z,J502F			; nope,
        LD	A,C
        CP	20H	; " "
        JR	C,J502F
        LD	A,(FLAGS)
        BIT	0,A
        JR	NZ,J5019
        BIT	7,C
        JR	Z,J502F
        LD	A,0EH	; 14 
        CALL	C5031
        JR	C,J507A
        JR	Z,J507A
        PUSH	HL
        LD	HL,FLAGS
        SET	0,(HL)
        POP	HL
        JR	J502D
J5019:	BIT	7,C
        JR	NZ,J502D
        LD	A,0FH	; 15 
        CALL	C5031
        JR	C,J507A
        JR	Z,J507A
        PUSH	HL
        LD	HL,FLAGS
        RES	0,(HL)
        POP	HL
J502D:	RES	7,C
J502F:	LD	A,C
        POP	BC

;	  Subroutine __________________________
;	     Inputs  ________________________
;	     Outputs ________________________

C5031:	PUSH	HL
        LD	HL,ESTBLS
        BIT	2,(HL)			; use Auto LF send ?
        POP	HL
        JR	Z,J5050			; nope,
        CP	0AH
        JR	NZ,J5050
        LD	A,(FLAGS)
        BIT	5,A
        LD	A,0AH	; 10 
        JR	Z,J5050
        PUSH	HL
        LD	HL,FLAGS
        RES	5,(HL)
        POP	HL
        AND	A
        RET

J5050:	PUSH	BC
        LD	C,A
        PUSH	DE
        CALL	C5080
        POP	DE
        JR	C,J507A
        JR	Z,J507A
        CALL	C5185			; wait for empty transmitter
        CALL	C5194			; wait for CTS (if RTS/CTS handshake is enabled)
        JR	C,J507A
        JR	Z,J507A
        LD	A,C
        OUT	(80H),A
        EI
        PUSH	HL
        LD	HL,FLAGS
        CP	0DH	; 13 
        JR	NZ,J5075
        SET	5,(HL)
        JR	J5077
J5075:	RES	5,(HL)
J5077:	POP	HL
        XOR	A
        INC	A
J507A:	CALL	C50B3
        LD	A,C
        POP	BC
        RET

;	  Subroutine __________________________
;	     Inputs  ________________________
;	     Outputs ________________________

C5080:	LD	A,(ESTBLS)
        BIT	0,A			; use XON/XOFF protocol ?
        JR	Z,J50B0			; nope,
        LD	A,(TOCNT)
        LD	D,A
J508B:	LD	E,64H	; "d"
J508D:	CALL	C51CD
J5090:	EI
        CALL	C44EF
        DI
        RET	C
        LD	A,(FLAGS)
        BIT	2,A
        JR	Z,J50B0
        LD	A,(TOCNT)
        AND	A
        JR	Z,J5090
        CALL	C51D9
        JR	NC,J5090
        AND	A
        DEC	E
        JR	NZ,J508D
        DEC	D
        JR	NZ,J508B
        RET
J50B0:	XOR	A
        INC	A
        RET

;	  Subroutine __________________________
;	     Inputs  ________________________
;	     Outputs ________________________

C50B3:	PUSH	HL
        LD	HL,ERRORS
        LD	(HL),00H
        JR	C,J50C1
        JR	NZ,J50C3
        SET	6,(HL)
        JR	J50C3
J50C1:	SET	2,(HL)
J50C3:	POP	HL
        RET

;	  Subroutine __________________________
;	     Inputs  ________________________
;	     Outputs ________________________

C50C5:	XOR	A
        OUT	(81H),A
        PUSH	AF
        POP	AF
        OUT	(81H),A
        PUSH	AF
        POP	AF
        OUT	(81H),A
        PUSH	AF
        POP	AF
        LD	A,40H	; "@"
        OUT	(81H),A
        PUSH	AF
        POP	AF
        LD	A,(LSTMOD)
        OUT	(81H),A
        PUSH	AF
        POP	AF
        IN	A,(80H)
        CALL	C5120
        LD	A,07H	; 7 
        CALL	C51C5
        IN	A,(80H)
        JP	C5120

;	  Subroutine RS232 sndbrk
;	     Inputs  ________________________
;	     Outputs ________________________

C50EE:	PUSH	BC
        DI
        CALL	C4E66			; disable RS232 interrupts
        EI
        LD	A,(LSTCOM)
        OR	08H	; 8 
        LD	B,A
J50FA:	CALL	C44EF
        JR	C,J510E
        CALL	C5185			; wait for empty transmitter
        XOR	A
        OUT	(80H),A
        LD	A,B
        CALL	C51C5
        DEC	DE
        LD	A,E
        OR	D
        JR	NZ,J50FA
J510E:	PUSH	AF
        CALL	C5185			; wait for empty transmitter
        LD	A,B
        AND	0F7H
        CALL	C51C5
        DI
        CALL	C4E6D			; enable RS232 interrupts
        EI
        POP	AF
        POP	BC
        RET

;	  Subroutine __________________________
;	     Inputs  ________________________
;	     Outputs ________________________

C5120:	IN	A,(81H)
        AND	38H
        PUSH	AF
        LD	A,(LSTCOM)
        PUSH	AF
        OR	10H
        CALL	C51C5
        POP	AF
        LD	(LSTCOM),A
        POP	AF
        RET

;	  Subroutine RTS=1
;	     Inputs  ________________________
;	     Outputs ________________________

C5134:	PUSH	AF
        LD	A,(LSTCOM)
        SET	5,A
        JR	J5142

;	  Subroutine RTS=0
;	     Inputs  ________________________
;	     Outputs ________________________

C513C:	PUSH	AF
        LD	A,(LSTCOM)
        RES	5,A
J5142:	CALL	C51C5
        POP	AF
        RET

;	  Subroutine RS232 dtr
;	     Inputs  ________________________
;	     Outputs ________________________

C5147:	AND	A
        JR	Z,J5153

;	  Subroutine DTR=1
;	     Inputs  ________________________
;	     Outputs ________________________

C514A:	DI
        PUSH	AF
        LD	A,(LSTCOM)
        OR	02H
        JR	J515A

;	  Subroutine DTR=0
;	     Inputs  ________________________
;	     Outputs ________________________

J5153:	DI
        PUSH	AF
        LD	A,(LSTCOM)
        AND	0FDH
J515A:	CALL	C51C5
        POP	AF
        RET

;	  Subroutine RS232 stat
;	     Inputs  ________________________
;	     Outputs ________________________

C515F:	PUSH	AF
        IN	A,(82H)
        LD	L,0C1H
        XOR	L
        AND	L
        LD	L,A
        IN	A,(81H)
        AND	80H
        JR	Z,J516F
        SET	3,L
J516F:	DI
        LD	A,(FLAGS)
        BIT	4,A
        JR	Z,J517E
        SET	2,L
        RES	4,A
        LD	(FLAGS),A
J517E:	EI
        LD	A,(ERRORS)
        LD	H,A
        POP	AF
        RET

;	  Subroutine wait for empty transmitter
;	     Inputs  ________________________
;	     Outputs ________________________

C5185:	PUSH	AF
J5186:	EI
        NOP
        NOP
        DI
        IN	A,(81H)
        AND	05H
        CP	05H
        JR	NZ,J5186
        POP	AF
        RET

;	  Subroutine __________________________
;	     Inputs  ________________________
;	     Outputs ________________________

C5194:	LD	A,(ESTBLS)
        BIT	1,A			; use RTS/CTS handshake ?
        JR	Z,J51C2			; nope, quit
        LD	A,(TOCNT)
        LD	D,A			; timeout in seconds
J519F:	LD	E,100			; 100x 10ms = 1 second
J51A1:	CALL	C51CD			; initialize timer 2 for 10 ms
J51A4:	CALL	C44EF			; CTRL-STOP pressed ?
        EI
        RET	C
        IN	A,(82H)
        BIT	7,A			; CTS asserted ?
        JR	Z,J51C2			; yep, quit
        LD	A,(TOCNT)
        AND	A			; no timeout ?
        JR	Z,J51A4			; yep, wait (forever)
        CALL	C51D9			; timer 2 finished ?
        JR	NC,J51A4		; nope, wait
        AND	A
        DEC	E
        JR	NZ,J51A1
        DEC	D
        JR	NZ,J519F
        RET
J51C2:	XOR	A
        INC	A
        RET

;	  Subroutine __________________________
;	     Inputs  ________________________
;	     Outputs ________________________

C51C5:	OUT	(81H),A
        LD	(LSTCOM),A
        PUSH	AF
        POP	AF
        RET

;	  Subroutine __________________________
;	     Inputs  ________________________
;	     Outputs ________________________

C51CD:	PUSH	AF
        PUSH	BC
        PUSH	DE
        LD	A,0B0H			; LSB/MSB, interrupt generator, binary
        LD	C,86H			; timer 2
        LD	DE,4800H		; 10 ms
        JR	J51EB

;	  Subroutine __________________________
;	     Inputs  ________________________
;	     Outputs ________________________

C51D9:	IN	A,(82H)
        RLCA
        RLCA
        RET

;	  Subroutine __________________________
;	     Inputs  ________________________
;	     Outputs ________________________

C51DE:	PUSH	AF
        PUSH	BC
        PUSH	DE
        LD	A,C
        LD	B,C
        ADD	A,84H
        LD	C,A
        LD	A,B
        RRCA
        RRCA
        OR	36H			; LSB/MSB, square wave generator, binary
J51EB:	OUT	(87H),A
        OUT	(C),E
        OUT	(C),D
        POP	DE
        POP	BC
        POP	AF
        RET


; JVC HC9x setup ROM


; ROM init routine

J51F5:	DI
        LD	A,0D3H
        OUT	(0F7H),A
        LD	A,(D.7FFD)
        BIT	6,A			; Z80 mode ?
        JP	Z,J551A			; yep,
        LD	A,3FH			; internal I/O ports on I/O port 000H-040H, IOSTP=1
        DEFB	0EDH
        DEFB	039H
        DEFB	03FH			; OUT0 (03FH),A
        DEFB	0EDH
        DEFB	038H
        DEFB	034H			; IN0 A,(034H)
        BIT	7,A			; TRAP bit set ?
        JP	Z,J54E3			; nope,
        CALL	C52FD
        CALL	C5341
        CALL	C5409
        LD	DE,100
        LD	(KBUF+4),DE
        LD	A,40H	; "@"
        LD	(KBUF+6),A
        LD	DE,40
        LD	C,00H
        CALL	C541D
        LD	IX,I5BEF
        LD	BC,D.1900
        LD	D,(IX+0)
        INC	IX
        LD	A,(IX+0)
        INC	IX
        LD	H,A
J523E:	AND	0F0H
        RLCA
        RLCA
        RLCA
        RLCA
        OUT	(99H),A
        LD	A,0ACH
        OUT	(99H),A
        DEC	BC
        LD	A,0B8H
        OUT	(99H),A
        LD	A,0AEH
        OUT	(99H),A
        LD	A,02H	; 2 
        OUT	(99H),A
        LD	A,8FH
        OUT	(99H),A
J525B:	IN	A,(99H)
        BIT	7,A
        JR	Z,J525B
        BIT	0,C
        JR	NZ,J527E
        DEC	D
        JR	Z,J526B
        LD	A,H
        JR	J5275

J526B:	LD	D,(IX+0)
        INC	IX
        LD	A,(IX+0)
        INC	IX
J5275:	LD	H,A
        AND	0F0H
        RLCA
        RLCA
        RLCA
        RLCA
        JR	J5281

J527E:	LD	A,H
        AND	0FH	; 15 
J5281:	OUT	(99H),A
        LD	A,0ACH
        OUT	(99H),A
        DEC	BC
        LD	A,B
        OR	C
        JR	NZ,J525B
        LD	BC,I.07D0
J528F:	IN	A,(99H)
        BIT	0,A
        JR	Z,J52A2
        DEC	BC
        LD	A,B
        OR	C
        JR	NZ,J528F
        LD	A,00H
        OUT	(99H),A
        LD	A,0AEH
        OUT	(99H),A
J52A2:	LD	IX,I5B33
J52A6:	LD	E,(IX+0)
        LD	D,(IX+1)
        LD	C,(IX+2)
        LD	A,D
        CP	0FFH
        JR	NZ,J52BA
        XOR	E
        JR	NZ,J52BA
        JP	J52CD

J52BA:	LD	L,(IX+3)
        LD	H,(IX+4)
        LD	B,(IX+5)
        CALL	C5396
        LD	DE,6
        ADD	IX,DE
        JR	J52A6

J52CD:	LD	D,71H	; "q"
J52CF:	LD	A,0FAH
        CALL	C580A
        LD	A,0FAH
        CALL	C580A
        LD	A,0FAH
        CALL	C580A
        LD	A,0FAH
        CALL	C580A
        LD	A,08H	; 8 
        OUT	(99H),A
        LD	A,90H
        OUT	(99H),A
        RLC	D
        RLC	D
        RLC	D
        RLC	D
        LD	A,D
        OUT	(9AH),A
        LD	A,01H	; 1 
        OUT	(9AH),A
        JP	J52CF

;	  Subroutine __________________________
;	     Inputs  ________________________
;	     Outputs ________________________

C52FD:	LD	DE,(D$533F)
        CALL	C53F1
        LD	IX,KBUF+16
        LD	HL,I531F
        LD	B,32
J530D:	LD	A,(IX+0)
        CP	(HL)
        JR	NZ,J531A
        INC	HL
        INC	IX
        DEC	B
        JR	NZ,J530D
        RET

J531A:	LD	A,01H	; 1 
        OUT	(0F5H),A
        RET

I531F:	NOP
        LD	A,A
        INC	B
        INC	B
        INC	B
        CCF
        INC	H
        INC	H
        NOP
        CALL	M,C$4040
        LD	B,B
        RET	M
        LD	C,B
        LD	C,B
        INC	H
        INC	H
        CCF
        INC	B
        INC	B
        INC	B
        INC	B
        RST	38H
        LD	C,B
        LD	C,B
        RET	M
        LD	B,B
        LD	B,B
        LD	B,B
        LD	B,B
        CP	10H	; 16 
D$533F	EQU	$-1
        DEFB	1

C5341:	PUSH	AF
        PUSH	BC
        PUSH	HL
        LD	A,00H
        OUT	(99H),A
        LD	A,91H
        OUT	(99H),A
        LD	HL,I537F
        LD	B,0CH	; 12 
        LD	C,9BH
        OTIR
        LD	A,24H	; "$"
        OUT	(99H),A
        LD	A,91H
        OUT	(99H),A
        LD	HL,I538B
        LD	B,0BH	; 11 
        LD	C,9BH
        OTIR
        LD	A,02H	; 2 
        OUT	(99H),A
        LD	A,8FH
        OUT	(99H),A
J536E:	IN	A,(99H)
        RRCA
        JR	C,J536E
        LD	A,40H	; "@"
        OUT	(99H),A
        LD	A,81H
        OUT	(99H),A
        POP	HL
        POP	BC
        POP	AF
        RET

I537F:	LD	A,(BC)
        NOP
        RRA
        DEFB	0,0
        RST	30H
        LD	E,0F4H
        LD	A,(BC)
        ADD	A,B
        NOP
        LD	BC,0
I538B	EQU	$-2
        DEFB	0,0,0
        LD	(BC),A
        NOP
        LD	BC,I$0044
        ADD	A,B
;	  Subroutine __________________________
;	     Inputs  ________________________
;	     Outputs ________________________

C5396:	PUSH	IX
        PUSH	HL
        PUSH	BC
        PUSH	DE
        CALL	C5409
J539E:	CALL	C541D
        LD	D,(HL)
        INC	HL
        LD	A,D
        CP	0FEH
        JR	NZ,J53BC
        LD	A,(HL)
        INC	HL
        LD	D,A
        AND	0FH	; 15 
        LD	(KBUF+12),A
        LD	A,D
        AND	0F0H
        RRCA
        RRCA
        RRCA
        RRCA
        LD	(KBUF+13),A
        LD	D,(HL)
        INC	HL
J53BC:	LD	E,(HL)
        INC	HL
        CALL	C53F1
        CALL	C5451
        DEC	B
        JR	Z,J53EB
        EXX
        POP	DE
        LD	HL,I$01DF
        EX	DE,HL
        LD	BC,32
        ADD	HL,BC
        EX	DE,HL
        SUB	A
        SBC	HL,DE
        JR	NC,J53E5
        LD	DE,16
        POP	HL
        LD	A,L
        ADD	A,13H	; 19 
        LD	L,A
        PUSH	HL
        PUSH	DE
        EXX
        LD	C,A
        JR	J53E7

J53E5:	PUSH	DE
        EXX
J53E7:	POP	DE
        PUSH	DE
        JR	J539E

J53EB:	POP	DE
        POP	BC
        POP	HL
        POP	IX
        RET

;	  Subroutine __________________________
;	     Inputs  ________________________
;	     Outputs ________________________

C53F1:	PUSH	AF
        PUSH	BC
        PUSH	HL
        LD	HL,KBUF+16
        LD	A,D
        OUT	(0D8H),A
        LD	A,E
        OUT	(0D9H),A
        LD	B,20H	; " "
J53FF:	IN	A,(0D9H)
        LD	(HL),A
        INC	HL
        DJNZ	J53FF
        POP	HL
        POP	BC
        POP	AF
        RET

;	  Subroutine __________________________
;	     Inputs  ________________________
;	     Outputs ________________________

C5409:	PUSH	AF
        PUSH	BC
        PUSH	DE
        PUSH	HL
        LD	HL,I5449
        LD	DE,KBUF+0
        LD	BC,8
        LDIR
        POP	HL
        POP	DE
        POP	BC
        POP	AF
        RET

;	  Subroutine __________________________
;	     Inputs  ________________________
;	     Outputs ________________________

C541D:	PUSH	AF
        PUSH	BC
        PUSH	HL
        LD	A,E
        LD	(KBUF+0),A
        LD	A,D
        LD	(KBUF+1),A
        LD	A,C
        LD	(KBUF+2),A
        LD	A,24H	; "$"
        OUT	(99H),A
        LD	A,91H
        OUT	(99H),A
        LD	HL,KBUF+0
        LD	B,08H	; 8 
        LD	C,9BH
        OTIR
        LD	A,00H
        OUT	(99H),A
        LD	A,0ADH
        OUT	(99H),A
        POP	HL
        POP	BC
        POP	AF
        RET

I5449:	DEFB	0,0,0,0
        JR	NZ,J544F
J544F:	JR	NZ,C5451
;	  Subroutine __________________________
;	     Inputs  ________________________
;	     Outputs ________________________

C5451:	PUSH	BC
        PUSH	DE
        LD	IX,KBUF+16
        LD	B,00H
J5459:	LD	D,(IX+0)
        CALL	C549A
        INC	B
        LD	D,(IX+8)
        CALL	C549A
        INC	IX
        INC	B
        LD	A,B
        CP	20H	; " "
        JR	Z,J5479
        CP	10H	; 16 
        JR	NZ,J5459
        LD	DE,8
        ADD	IX,DE
        JR	J5459

J5479:	LD	A,02H	; 2 
        OUT	(99H),A
        LD	A,8FH
        OUT	(99H),A
        LD	BC,I.07D0
J5484:	IN	A,(99H)
        BIT	0,A
        JR	Z,J5497
        DEC	BC
        LD	A,B
        OR	C
        JR	NZ,J5484
        LD	A,00H
        OUT	(99H),A
        LD	A,0AEH
        OUT	(99H),A
J5497:	POP	DE
        POP	BC
        RET

;	  Subroutine __________________________
;	     Inputs  ________________________
;	     Outputs ________________________

C549A:	PUSH	AF
        PUSH	HL
        PUSH	BC
        LD	H,B
        LD	BC,(KBUF+12)
        LD	A,B
        RLC	D
        JR	C,J54A8
        LD	A,C
J54A8:	OUT	(99H),A
        LD	A,0ACH
        OUT	(99H),A
        LD	A,H
        AND	A
        JR	NZ,J54BA
        LD	A,0B8H
        OUT	(99H),A
        LD	A,0AEH
        OUT	(99H),A
J54BA:	LD	A,02H	; 2 
        OUT	(99H),A
        LD	A,8FH
        OUT	(99H),A
        LD	E,0FH	; 15 
J54C4:	IN	A,(99H)
        BIT	7,A
        JR	Z,J54C4
        BIT	0,E
        JR	Z,J54D0
        RRC	D
J54D0:	RLC	D
        LD	A,B
        JR	C,J54D6
        LD	A,C
J54D6:	OUT	(99H),A
        LD	A,0ACH
        OUT	(99H),A
        DEC	E
        JR	NZ,J54C4
        POP	BC
        POP	HL
        POP	AF
        RET

J54E3:	LD	A,(NEWKEY+7)
        BIT	2,A			; ESC key pressed ?
        JP	Z,J554B			; yep,
        LD	A,32H			; DMAs disabled
        DEFB	0EDH
        DEFB	039H
        DEFB	030H			; OUT0 (030H),A
        LD	A,0C1H			; DMA dest memory incr, src memory incr, cycle steal
        DEFB	0EDH
        DEFB	039H
        DEFB	031H			; OUT0 (031H),A
        LD	A,020H			; memory 0 wait states, io 3 wait states, level sense, Mem to I/O
        DEFB	0EDH
        DEFB	039H
        DEFB	032H			; OUT0 (032H),A
        LD	A,000H			; interrupt vector low = 0
        DEFB	0EDH
        DEFB	039H
        DEFB	033H			; OUT0 (033H),A
        LD	A,39H			; TRAP=0, UFO=0, INT2 enabled, INT1 disabled, INT0 enabled
        DEFB	0EDH
        DEFB	039H
        DEFB	034H			; OUT0 (034H),A
        LD	A,0BFH			; refresh enabled, no refresh wait, interval = 80 cycles
        DEFB	0EDH
        DEFB	039H
        DEFB	036H			; OUT0 (036H),A
        LD	A,000H			; MNU common base = 0
        DEFB	0EDH
        DEFB	039H
        DEFB	038H			; OUT0 (038H),A
        LD	A,000H			; MNU bank base = 0
        DEFB	0EDH
        DEFB	039H
        DEFB	039H			; OUT0 (039H),A
        LD	A,0F0H			; MNU common starts at 0F000H, bank starts at 00000H
        DEFB	0EDH
        DEFB	039H
        DEFB	03AH			; OUT0 (03AH),A
        JR	J5522

J551A:	LD	A,(NEWKEY+7)
        BIT	2,A			; ESC key pressed ?
        JP	Z,J554B			; yep, start setup
J5522:	LD	A,(NEWKEY+8)
        BIT	3,A			; DEL key pressed ?
        JR	Z,J5534			; yep, disable functionkey functionality
        LD	BC,5
        LD	HL,I5546
        LD	DE,H.KEYC
        LDIR
J5534:	LD	HL,D.7FFD
        LD	A,(NEWKEY+7)
        BIT	5,A			; BS key pressed ?
        JR	NZ,J5543		; nope,
        SET	5,(HL)			; enable RS232
        JP	J4075			; initalize RS232

J5543:	RES	5,(HL)			; disable RS232
        RET

I5546:	RST	30H
        DEFB	084H			; slot 0-1
        DEFW	J59E7
        RET

;	  Subroutine HC95 setup
;	     Inputs  ________________________
;	     Outputs ________________________

J554B:	LD	A,00H
        OUT	(99H),A
        LD	A,8EH
        OUT	(99H),A
        LD	A,00H
        CALL	C5697
        EXX
        LD	A,(D.7FFD)
        LD	B,4
        LD	D,2
        BIT	6,A			; Z80 mode ?
        JR	NZ,J5568		; nope,
        LD	B,1
        LD	D,4
J5568:	LD	E,0
        EXX
        LD	HL,0
        ADD	HL,SP
        LD	BC,10
        SUB	A
        SBC	HL,BC
        LD	BC,0
        PUSH	BC
        PUSH	BC
        PUSH	BC
        PUSH	BC
        PUSH	BC
        PUSH	HL
        POP	IY
        PUSH	IY
        IN	A,(0AAH)
        LD	(IY+8),A
        CALL	C5716
        CALL	C5820
        POP	IY
        PUSH	IY
        POP	IX
        PUSH	IX
J5595:	CALL	C5770
        CP	0DH			; RETURN pressed ?
        JP	Z,J5613			; yep,
        CP	00H			; CURSOR LEFT pressed ?
        JR	Z,J55F6
        CP	01H			; CURSOR UP pressed ?
        JR	Z,J55C4
        CP	02H			; CURSOR DOWN pressed ?
        JR	Z,J55E0
        CP	03H			; CURSOR RIGHT pressed ?
        JR	Z,J5607
        CP	10H			; HOME pressed ?
        JR	Z,J55B3
        JR	J5595

J55B3:	POP	IY
        PUSH	IY
        CALL	C5716
        EXX
        LD	A,E
        EXX
        LD	C,A
        LD	B,00H
        ADD	IY,BC
        JR	J5595

J55C4:	CALL	C583A
        EXX
        DEC	IY
        DEC	E
        JP	P,J55DA
        POP	IY
        PUSH	IY
        EX	DE,HL
        LD	E,B
        LD	D,0
        ADD	IY,DE
        EX	DE,HL
        LD	E,B
J55DA:	EXX
        CALL	C5820
        JR	J5595

J55E0:	CALL	C583A
        EXX
        INC	IY
        LD	A,E
        INC	A
        CP	B
        JR	Z,J55F3
        JR	C,J55F3
        POP	IY
        PUSH	IY
        LD	A,0
J55F3:	LD	E,A
        JR	J55DA

J55F6:	LD	A,(IY+0)
        DEC	A
        JP	P,J55FF
        LD	A,03H	; 3 
J55FF:	LD	(IY+0),A
        CALL	C5851
        JR	J5595

J5607:	LD	A,(IY+0)
        INC	A
        CP	04H	; 4 
        JR	C,J55FF
        LD	A,00H
        JR	J55FF

; RETURN

J5613:	POP	IY
        LD	HL,D.7FFD
        BIT	0,(IY+0)		; enable RS232 ?
        JR	Z,J5622			; nope,
        SET	5,(HL)			; enable RS232
        JR	J5624

J5622:	RES	5,(HL)			; disable RS232
J5624:	BIT	0,(IY+1)		; enable functionkeys ?
        JR	Z,J5635			; nope,
        LD	BC,5
        LD	HL,I5546
        LD	DE,H.KEYC
        LDIR				; install KEYC handler
J5635:	LD	A,(D.7FFD)
        BIT	6,A			; Z80 mode ?
        JR	Z,J5681			; yep, skip HD64180 settings
        LD	A,(IY+2)		; memory wait states
        LD	B,(IY+3)		; io wait states
        RRCA
        RRCA
        SLA	B
        SLA	B
        SLA	B
        SLA	B
        OR	B
        LD	B,A
        LD	A,(IY+4)		; refresh interval
        AND	03H
        OR	0BCH
        LD	C,A
        LD	A,32H			; DMAs disabled
        DEFB	0EDH
        DEFB	039H
        DEFB	030H			; OUT0 (030H),A
        LD	A,0C1H			; DMA dest memory incr, src memory incr, cycle steal
        DEFB	0EDH
        DEFB	039H
        DEFB	031H			; OUT0 (031H),A
        LD	A,B			; memory ? wait states, io ? wait states
        DEFB	0EDH
        DEFB	039H
        DEFB	032H			; OUT0 (032H),A
        LD	A,000H			; interrupt vector low = 0
        DEFB	0EDH
        DEFB	039H
        DEFB	033H			; OUT0 (033H),A
        LD	A,39H			; TRAP=0, UFO=0, INT2 enabled, INT1 disabled, INT0 enabled
        DEFB	0EDH
        DEFB	039H
        DEFB	034H			; OUT0 (034H),A
        LD	A,C			; interval = ? cycles
        DEFB	0EDH
        DEFB	039H
        DEFB	036H			; OUT0 (036H),A
        LD	A,000H			; MNU common base = 0
        DEFB	0EDH
        DEFB	039H
        DEFB	038H			; OUT0 (038H),A
        LD	A,000H			; MNU bank base = 0
        DEFB	0EDH
        DEFB	039H
        DEFB	039H			; OUT0 (039H),A
        LD	A,0F0H			; MNU common starts at 0F000H, bank starts at 00000H
        DEFB	0EDH
        DEFB	039H
        DEFB	03AH			; OUT0 (03AH),A
J5681:	POP	BC
        POP	BC
        POP	BC
        POP	BC
        POP	BC
        LD	A,C
        OUT	(0AAH),A
        LD	A,01H	; 1 
        CALL	C5697
        LD	A,(D.7FFD)
        BIT	5,A			; RS232 enabled ?
        JP	NZ,J4075		; yep, initialize RS232
        RET

;	  Subroutine __________________________
;	     Inputs  ________________________
;	     Outputs ________________________

C5697:	LD	HL,I58BF
J569A:	AND	A
        JR	Z,J56A0
        LD	HL,I58C7
J56A0:	LD	D,A
        LD	A,00H
        OUT	(99H),A
        LD	A,91H
        OUT	(99H),A
        LD	B,08H	; 8 
        LD	C,9BH
        OTIR
        LD	A,00H
        OUT	(99H),A
        LD	A,40H	; "@"
        OUT	(99H),A
J56B6	EQU	$-1
        LD	BC,I$4000
J56BA:	LD	A,00H
        OUT	(98H),A
        DEC	BC
        LD	A,B
        OR	C
        JP	NZ,J56BA
        LD	A,D
        AND	A
        JR	NZ,J56D2
        LD	A,00H
        OUT	(99H),A
        LD	A,48H	; "H"
        OUT	(99H),A
        JR	J56DA

J56D2:	LD	A,00H
        OUT	(99H),A
        LD	A,40H	; "@"
        OUT	(99H),A
J56DA:	LD	HL,I$1BBF
        LD	C,98H
        LD	E,08H	; 8 
J56E1:	LD	B,00H
J56E3:	LD	A,(HL)
        INC	HL
        OUT	(C),A
        EX	(SP),HL
        EX	(SP),HL
        DJNZ	J56E3
        DEC	E
        JR	NZ,J56E1
        LD	A,D
        AND	A
        JR	NZ,J570D
        LD	A,08H	; 8 
        OUT	(99H),A
        LD	A,48H	; "H"
        OUT	(99H),A
        LD	HL,I59D7
        LD	B,10H	; 16 
        LD	C,98H
J5701:	LD	A,(HL)
        INC	HL
        OUT	(C),A
        EX	(SP),HL
        EX	(SP),HL
        DJNZ	J5701
        LD	A,70H	; "p"
        JR	J570F

J570D:	LD	A,60H	; "`"
J570F:	OUT	(99H),A
        LD	A,81H
        OUT	(99H),A
        RET

;	  Subroutine __________________________
;	     Inputs  ________________________
;	     Outputs ________________________

C5716:	PUSH	IX
        PUSH	HL
        PUSH	BC
        PUSH	DE
        LD	(IY+0),00H
        LD	(IY+1),01H	; 1 
        LD	(IY+2),00H
        LD	(IY+3),02H	; 2 
        LD	(IY+4),03H	; 3 
        LD	(IY+5),0FFH
        LD	(IY+6),00H
        LD	IX,I58CF
        LD	HL,200
        LD	D,0FFH
J5740:	LD	BC,34
        LD	A,L
        OUT	(99H),A
        LD	A,H
        OR	40H	; "@"
        OUT	(99H),A
J574B:	LD	A,(IX+0)
        INC	IX
        OUT	(98H),A
        DEC	BC
        LD	A,B
        OR	C
        JR	NZ,J574B
        EXX
        LD	A,B
        EXX
        CP	D
        JR	Z,J576A
        INC	D
        EXX
        LD	A,D
        EXX
        LD	BC,40
J5764:	ADD	HL,BC
        DEC	A
        JR	NZ,J5764
        JR	J5740

J576A:	POP	DE
        POP	BC
        POP	HL
        POP	IX
        RET

;	  Subroutine __________________________
;	     Inputs  ________________________
;	     Outputs ________________________

C5770:	LD	A,0AH
        CALL	C580A
        LD	A,(IX+8)
        AND	0F0H
        OR	07H
        OUT	(0AAH),A		; select row 7
        NOP
        IN	A,(0A9H)
        RLCA				; RETURN key pressed ?
        JR	C,J5787			; nope,
        LD	A,0DH
        RET

J5787:	LD	A,(IX+8)
        AND	0F0H
        OR	08H
        OUT	(0AAH),A		; select row 8
        NOP
        IN	A,(0A9H)
        BIT	1,A			; HOME pressed ?
        JR	NZ,J579B		; nope,
        LD	A,10H
        JR	J57CC

J579B:	AND	0F0H
        XOR	0F0H			; cursor keys pressed ?
        JR	NZ,J57AA		; yep,
J57A1:	XOR	A
        LD	(IX+6),A
        CPL
        LD	(IX+5),A
        RET

J57AA:	RRCA
        RRCA
        RRCA
        RRCA
        CP	01H			; cursor left pressed ?
        JR	NZ,J57B6		; nope,
        LD	A,00H
        JR	J57CC

J57B6:	CP	02H			; cursor up pressed ?
        JR	NZ,J57BE		; nope,
        LD	A,01H
        JR	J57CC

J57BE:	CP	04H			; cursor down pressed ? 
        JR	NZ,J57C6		; nope,
        LD	A,02H
        JR	J57CC

J57C6:	CP	08H			; cursor right pressed ?
        JR	NZ,J57A1		; nope,
        LD	A,03H
J57CC:	CP	(IX+5)
        JR	Z,J57D9
        LD	(IX+5),A
        LD	(IX+6),00H
        RET

J57D9:	LD	C,A
        BIT	7,(IX+6)
        JR	Z,J57F5
        INC	(IX+6)
        LD	A,(IX+6)
        AND	7FH
        CP	0AH
        JR	C,J57F2
        LD	(IX+6),80H
        LD	A,C
        RET

J57F2:	LD	A,0FFH
        RET

J57F5:	LD	A,(IX+6)
        AND	7FH
        CP	32H	; "2"
        JR	C,J5804
        LD	(IX+6),80H
        LD	A,C
        RET

J5804:	INC	(IX+6)
        LD	A,0FFH
        RET

;	  Subroutine __________________________
;	     Inputs  ________________________
;	     Outputs ________________________

C580A:	PUSH	BC
        PUSH	DE
        LD	E,A
J580D:	LD	BC,007AH
J5810:	DEC	BC
        LD	A,B
        OR	C
        JR	NZ,J5810
        DEC	D
        DEC	D
        DEC	D
        DEC	D
        DEC	D
        DEC	E
        JR	NZ,J580D
        POP	DE
        POP	BC
        RET

;	  Subroutine __________________________
;	     Inputs  ________________________
;	     Outputs ________________________

C5820:	CALL	C588B
        LD	BC,34
        ADD	HL,BC
        LD	A,L
        OUT	(99H),A
        LD	A,H
        OR	40H	; "@"
        OUT	(99H),A
        LD	A,01H	; 1 
        OUT	(98H),A
        EX	(SP),HL
        EX	(SP),HL
        LD	A,02H	; 2 
        OUT	(98H),A
        RET

;	  Subroutine __________________________
;	     Inputs  ________________________
;	     Outputs ________________________

C583A:	CALL	C588B
        LD	BC,34
        ADD	HL,BC
        LD	A,L
        OUT	(99H),A
        LD	A,H
        OR	40H	; "@"
        OUT	(99H),A
        XOR	A
        OUT	(98H),A
        EX	(SP),HL
        EX	(SP),HL
        OUT	(98H),A
        RET

;	  Subroutine __________________________
;	     Inputs  ________________________
;	     Outputs ________________________

C5851:	PUSH	IX
        LD	IX,J599B
        LD	E,A
        ADD	A,A
        ADD	A,E
        LD	E,A
        EXX
        LD	A,E
        EXX
        AND	A
        JR	Z,J5868
        LD	B,A
        LD	C,0CH	; 12 
        XOR	A
J5865:	ADD	A,C
        DJNZ	J5865
J5868:	ADD	A,E
        LD	E,A
        LD	D,00H
        ADD	IX,DE
        CALL	C588B
        LD	BC,31
        ADD	HL,BC
        LD	A,L
        OUT	(99H),A
        LD	A,H
        OR	40H	; "@"
        OUT	(99H),A
        LD	B,03H	; 3 
J587F:	LD	A,(IX+0)
        OUT	(98H),A
        INC	IX
        DJNZ	J587F
        POP	IX
        RET

;	  Subroutine __________________________
;	     Inputs  ________________________
;	     Outputs ________________________

C588B:	PUSH	BC
        PUSH	DE
        LD	HL,200
        EXX
        LD	A,D
        EXX
        LD	BC,C.0028
J5896:	ADD	HL,BC
        DEC	A
        JR	NZ,J5896
        EXX
        LD	A,E
        EXX
        AND	A
        JR	Z,J58BC
        EX	DE,HL
        LD	BC,C.0028
        LD	HL,0
        EXX
        LD	A,D
        EXX
J58AA:	ADD	HL,BC
        DEC	A
        JR	NZ,J58AA
        EXX
        LD	A,E
        EXX
        PUSH	HL
        POP	BC
        LD	HL,0
J58B6:	ADD	HL,BC
        DEC	A
        JR	NZ,J58B6
        EX	DE,HL
        ADD	HL,DE
J58BC:	POP	DE
        POP	BC
        RET

I58BF:	NOP
        JR	NC,J58C2
J58C2:	ADD	A,B
        LD	BC,I$0736
        CALL	P,C$2000
I58C7	EQU	$-2
        LD	B,80H
        NOP
        LD	(HL),07H	; 7 
        RLCA

I58CF:	DEFB	"  << SYSTEM CONTROL INFORMATION >>"
        DEFB	"   1. RS-232C CONTROL ENABLE : NO "
        DEFB	"   2. FUNCTION KEY OPTION    : ON "
        DEFB	"   3. TURBO MEMORY WAIT      : 0  "
        DEFB	"   4. TURBO I/O WAIT         : 3  "
        DEFB	"   5. TURBO REFRESH CYCLE    : 80 "

        DEFB	"NO "
        DEFB	"YES"
        DEFB	"NO "
        DEFB	"YES"
        DEFB	"OFF"
        DEFB	"ON "
        DEFB	"OFF"
        DEFB	"ON "
        DEFB	"0  "
        DEFB	"1  "
        DEFB	"2  "
        DEFB	"3  "
        DEFB	"0  "
        DEFB	"2  "
        DEFB	"3  "
        DEFB	"4  "
        DEFB	"10 "
        DEFB	"20 "
        DEFB	"40 "
        DEFB	"80 "



I59D7:	DEFB	010H
J59D8:	CCF
        LD	A,A
        RST	38H
        LD	A,A
        CCF
        DJNZ	J59DF
J59DF:	NOP
        RET	PO
J59E1:	RET	PO
        RET	PO
        RET	PO
J59E4:	RET	PO
J59E5:	DEFB	0,0

;	  Subroutine KEYC handler
;	     Inputs  ________________________
;	     Outputs ________________________


J59E7:	DI
J59E8:	CP	35H			; F1 - F5 key ?
        RET	C			; nope, quit
J59EB:	CP	39H
        RET	NC			; nope, quit
        PUSH	AF
        LD	A,(NEWKEY+6)
        AND	03H			; CTRL+SHIFT pressed ?
J59F4:	JR	NZ,J5A13		; nope,
        POP	AF
        CP	37H			; with F1 or F2 ?
J59F9:	RET	NC			; nope, quit
        CP	35H			; F1 pressed ?
        JR	NZ,J5A05		; F2 pressed ,

; CTRL+SHIFT+F1

J59FE:	LD	A,(AVCSAV)
        AND	0FBH
        JR	J5A0A

; CTRL+SHIFT+F2

J5A05:	LD	A,(AVCSAV)
        OR	04H			; select 
J5A0A:	LD	(AVCSAV),A
        OUT	(0F7H),A
        LD	A,31H			; GRAPH pressed
        LD	C,A
        RET

J5A13:	CP	01H			; CTRL pressed ?
        JR	Z,J5A19			; yep,
        POP	AF
        RET				; nope, quit

J5A19:	PUSH	BC
        PUSH	HL
        LD	A,C
        SUB	35H
        LD	B,00H
        LD	C,A
        ADD	A,A
        ADD	A,C
        LD	C,A			; *3
        LD	HL,I5A5E
        ADD	HL,BC
        LD	B,(HL)
        INC	HL
        LD	A,(RG8SAV)
        AND	0DFH
        OR	B
        LD	(RG8SAV),A
        OUT	(99H),A
        LD	A,88H
        OUT	(99H),A			; write VDP R#8
        LD	B,(HL)
        INC	HL
        LD	A,(RG9SAV)
        AND	0CFH
        OR	B
        LD	(RG9SAV),A
        OUT	(99H),A
        LD	A,89H
        OUT	(99H),A			; write VDP R#9
        LD	A,(AVCSAV)
        AND	04H
        LD	B,A
        LD	A,(HL)
        OR	B
        LD	(AVCSAV),A
        OUT	(0F7H),A
        POP	HL
        POP	BC
        POP	AF
        LD	A,31H			; GRAPH pressed
        LD	C,A
        RET

I5A5E:	DEFB	000H,010H,098H		; TP=0, S1=0, S0=1, superimpose, Ym=0, AV=1, audio mixed
        DEFB	000H,020H,058H		; TP=0, S1=1, S0=0, television, Ym=0, AV=1, audio mixed
        DEFB	000H,000H,0D3H		; TP=0, S1=0, S0=0, computer, Ym=0, AV=1, audio not mixed
        DEFB	020H,010H,098H		; TP=1 (color 0 not transparent), S1=0, S0=1, superimpose, Ym=0, AV=1, audio mixed
        DEFB	000H,010H,0B8H		; TP=0, S1=0, S0=1, superimpose, Ym=1 (half brightness), AV=1, audio mixed

; ROM CALL statement handler

J5A6D:	DI
        PUSH	AF
        PUSH	BC
        PUSH	DE
        PUSH	IX
        PUSH	HL
        LD	IX,I5AE7
J5A78:	LD	HL,PROCNM
J5A7B:	LD	A,(HL)
        INC	HL
        CP	(IX+0)
        JR	NZ,J5A8C
        LD	A,(IX+0)
        AND	A
        JR	Z,J5AA4
        INC	IX
        JR	J5A7B

J5A8C:	LD	A,(IX+0)
        AND	A
        INC	IX
        JR	NZ,J5A8C
        INC	IX
        INC	IX
        INC	IX
        LD	A,(IX+0)
        CP	0FFH
        JR	NZ,J5A78
        JP	J5ABD

J5AA4:	LD	E,(IX+1)
        LD	D,(IX+2)
        LD	C,(IX+3)
        LD	HL,I5AB4
        PUSH	HL
        PUSH	HL
        PUSH	DE
        RET

I5AB4:	POP	HL
        POP	IX
        POP	DE
        POP	BC
        POP	AF
        SCF
        CCF
J5ABC:	RET

J5ABD:	LD	A,(D.7FFD)
        BIT	5,A			; RS232 enabled ?
        JR	Z,J5ACD			; nope, quit CALL statement handler
        POP	HL
        POP	IX
        POP	DE
        POP	BC
        POP	AF
        JP	J4150			; CALL statement handler RS232

J5ACD:	POP	HL
        POP	IX
        POP	DE
        POP	BC
        POP	AF
        SCF
        RET

J5AD5:	LD	A,(D.7FFD)
        BIT	5,A			; RS232 enabled ?
        JR	NZ,J5AE0		; yep,
        CALL	J4075			; initialize RS232
        DI
J5AE0:	LD	HL,D.7FFD
        SET	5,(HL)			; enable RS232
        POP	AF
        RET

I5AE7:	DEFB	"RSON",0
        DEFW	J5AD5
        DEFB	0
        DEFB	"SUPER0",0
        DEFW	J5A19
        DEFB	038H
        DEFB	"SUPER1",0
        DEFW	J5A19
        DEFB	037H
        DEFB	"SUPER2",0
        DEFW	J5A19
        DEFB	039H
        DEFB	"SUPER3",0
        DEFW	J5A19
        DEFB	035H
        DEFB	"SUPER4",0
        DEFB	J5A19
        DEFB	036H
        DEFB	0FFH
        DEFB	0FFH

; ROM device handler

J5B23:	DI
        PUSH	HL
        LD	HL,D.7FFD
        BIT	5,(HL)			; RS232 enabled ?
        JR	Z,J5B30			; nope, quit device handler
        POP	HL
        JP	J41FC			; RS232 device handler

J5B30:	POP	HL
        SCF
        RET

I5B33:	SUB	H
        NOP
        JR	NZ,J5B7E
        LD	E,E
        LD	A,(BC)
        JR	NC,J5B3B
J5B3B:	LD	C,D
        LD	E,L
        LD	E,E
        DAA
        JR	NC,J5B41
J5B41:	ADD	A,A
        XOR	L
        LD	E,E
        JR	NZ,J5B45
J5B45	EQU	$-1
        RST	38H
        CP	0F8H
        LD	BC,I$1405
        DEC	B
J5B4D:	INC	D
        DEC	B
        DEC	B
        DEC	B
        LD	C,05H	; 5 
        INC	D
        DEC	B
        ADD	HL,BC
        DEC	B
        RRCA
        DEC	B
        LD	C,05H	; 5 
        LD	HL,(0FE01H)
        RET	P
        INC	DE
        LD	B,2EH	; "."
        LD	B,3DH	; "="
        RLCA
        DEC	D
        EX	AF,AF'
        EX	AF,AF'
        EX	AF,AF'
        CPL
        LD	B,3FH	; "?"
        RLCA
        DEC	A
        LD	BC,I$081C
        LD	(D.3D08),HL
        LD	BC,I.0809
        DAA
        LD	B,2FH	; "/"
        LD	B,10H	; 16 
        LD	SP,I$200E
J5B7E	EQU	$-1
        DAA
        LD	B,0DH	; 13 
        LD	B,3EH	; ">"
        LD	B,1BH
        LD	B,13H	; 19 
        RLCA
        INC	HL
        LD	BC,I$080E
        DEC	A
        LD	BC,I$081E
        DEC	HL
        EX	AF,AF'
        LD	(D.3D08),HL
        LD	BC,I.0809
        DAA
        LD	B,08H	; 8 
        LD	HL,I$3C11
        RLA
        LD	B,26H	; "&"
        LD	B,0FH	; 15 
        LD	B,20H	; " "
        LD	B,15H
        LD	B,04H	; 4 
        LD	B,23H	; "#"
        LD	BC,I$F0FE
        LD	(D.3D08),HL
        LD	BC,I.0809
        ADD	HL,SP
        RLCA
        INC	H
        RLCA
        INC	BC
        EX	AF,AF'
        LD	BC,I$2E08
        LD	B,3AH	; ":"
        JR	Z,J5BCC
        RLCA
        ADD	HL,DE
        LD	D,08H	; 8 
        LD	B,2FH	; "/"
        LD	B,2CH	; ","
        DEC	(HL)
        LD	A,(DE)
J5BCC:	LD	B,05H	; 5 
        JR	NC,J5BEB
        INC	E
        LD	(DE),A
        RLCA
        LD	A,(D$2328)
        LD	B,26H	; "&"
        LD	B,0BH	; 11 
        LD	B,09H	; 9 
        RLCA
        INC	D
        LD	E,2AH	; "*"
        LD	B,23H	; "#"
        LD	B,26H	; "&"
        LD	B,0FH	; 15 
        LD	B,20H	; " "
        LD	B,15H
        LD	B,04H	; 4 
J5BEB	EQU	$-1
        LD	B,23H	; "#"
        DEFB	1

I5BEF:	DEFB	032H
        DEFB	044H
        LD	(D.3244),A
        LD	B,H
        LD	(D.3244),A
        LD	B,H
        LD	(D.3244),A
        LD	B,H
        DEC	BC
        LD	B,H
        INC	BC
        LD	DE,I.1401
        DEC	B
        LD	B,H
        INC	BC
        LD	DE,I.1401
        LD	A,(DE)
        LD	B,H
        ADD	HL,BC
        LD	B,H
        LD	BC,I.0541
        LD	DE,I.EE01
        LD	BC,I.02EF
        CP	01H	; 1 
        POP	HL
        DEC	B
        LD	DE,I$4419
        EX	AF,AF'
        LD	B,H
        LD	BC,I.0641
        LD	DE,I.EE01
        LD	(BC),A
        RST	38H
        LD	(BC),A
        CP	01H	; 1 
        POP	HL
        INC	B
        LD	DE,I.1401
        JR	J5C75

?5C31:	EX	AF,AF'
        LD	B,H
        LD	B,11H	; 17 
        LD	BC,I$04EE
        RST	38H
        LD	BC,I.01FE
        XOR	05H	; 5 
        LD	DE,I.1401
        RLA
        LD	B,H
        RLCA
        LD	B,H
        LD	BC,I.0641
        LD	DE,I.EF01
        INC	BC
        RST	38H
        LD	(BC),A
        RST	28H
        LD	BC,I.01FE
        POP	HL
        DEC	B
        LD	DE,I.1401
        LD	D,44H	; "D"
        RLCA
        LD	B,H
        LD	B,11H	; 17 
        LD	BC,I$041E
        RST	38H
        INC	BC
        CP	01H	; 1 
        POP	HL
        DEC	B
        LD	DE,I.1401
        LD	D,44H	; "D"
        RLCA
        LD	B,H
        LD	B,11H	; 17 
        LD	BC,I$041F
        RST	38H
        LD	(BC),A
        RST	28H
J5C75:	LD	BC,I.01EE
        CP	06H	; 6 
        LD	DE,C.4416
        LD	B,44H	; "D"
        LD	BC,I.0641
        LD	DE,0FF07H
        LD	BC,I.01EF
        CP	01H	; 1 
        POP	HL
        DEC	B
        LD	DE,I.1401
        DEC	D
        LD	B,H
        LD	B,44H	; "D"
        LD	BC,I.0541
        LD	DE,I.1F01
        DEC	B
        RST	38H
        INC	BC
        CP	02H	; 2 
        XOR	05H	; 5 
        LD	DE,I.1401
        DEC	D
        LD	B,H
        LD	B,44H	; "D"
        LD	BC,I.0541
        LD	DE,0FF09H
        LD	(BC),A
        XOR	01H	; 1 
        POP	HL
        DEC	B
        LD	DE,I$4415
        LD	B,44H	; "D"
        LD	BC,I.0441
        LD	DE,I.1F01
        RLCA
        RST	38H
        LD	BC,I.01FE
        RST	38H
        INC	BC
        XOR	04H	; 4 
        LD	DE,I.1401
        DEC	D
        LD	B,H
        LD	B,44H	; "D"
        LD	BC,I.0441
        LD	DE,0FF09H
        INC	BC
        CP	01H	; 1 
        XOR	01H	; 1 
        POP	HL
        INC	BC
        LD	DE,I.1401
        DEC	D
        LD	B,H
        LD	B,44H	; "D"
        LD	BC,I$0341
        LD	DE,I.1E01
        LD	BC,I.07EF
        RST	38H
        LD	(BC),A
        CP	04H	; 4 
        XOR	03H	; 3 
        LD	DE,C.4416
        RLCA
        LD	B,H
        INC	BC
        LD	DE,I.EE01
        DEC	BC
        RST	38H
        LD	BC,I.02EF
        XOR	01H	; 1 
        POP	HL
        LD	BC,I.0111
        CALL	Z,C.4416
        RLCA
        LD	B,H
        LD	BC,I.0141
        LD	DE,I.1E01
        LD	(BC),A
        RST	28H
        LD	BC,I.02FF
        LD	DE,I.1E01
        INC	BC
        RST	38H
        LD	(BC),A
        LD	DE,I.1E01
        LD	BC,I$03FE
        XOR	01H	; 1 
        LD	(X.CC01),HL
        LD	D,44H	; "D"
        EX	AF,AF'
        LD	B,H
        LD	BC,I.0111
        LD	E,04H	; 4 
        RST	38H
        LD	BC,I$01E1
        RST	28H
        LD	(BC),A
        RST	38H
        LD	BC,I.01FE
        RST	38H
        LD	BC,I.011E
        RST	38H
        LD	(BC),A
        RST	28H
        LD	(BC),A
        XOR	01H	; 1 
        INC	L
        LD	BC,I$16CE
        LD	B,H
        ADD	HL,BC
        LD	B,H
        LD	BC,I.0D4E
        RST	38H
        LD	(BC),A
        CP	01H	; 1 
        JP	PO,X.2C01
        LD	BC,I$01CE
        RST	38H
        DEC	D
        LD	B,H
        LD	A,(BC)
        LD	B,H
        LD	BC,I$0DEF
        RST	38H
        LD	BC,I.01FE
        JP	PO,X.CC01
        LD	BC,I.01EE
        RST	38H
        LD	BC,I$14FE
        LD	B,H
        LD	A,(BC)
        LD	B,H
        LD	BC,I.0D4E
        RST	38H
        LD	BC,I.01EE
        INC	L
        LD	BC,I.01CF
        RST	28H
        LD	BC,I.01FF
        CP	01H	; 1 
        CALL	PO,C$4413
        DEC	BC
        LD	B,H
        LD	BC,I.024E
        RST	38H
        LD	BC,I$05FE
        RST	38H
        LD	BC,I.02EF
        RST	38H
        LD	BC,I.01FE
        JP	PO,X.CC01
        LD	BC,I.03EE
        RST	38H
        LD	BC,I.01FE
        CALL	PO,C$4412
        INC	C
        LD	B,H
        LD	BC,I.09EF
        RST	38H
        LD	BC,I.01FE
        JP	PO,X.2C01
        LD	BC,I.01CF
        XOR	04H	; 4 
        RST	38H
        LD	BC,I.01FE
        CALL	PO,C$4411
        INC	C
        LD	B,H
        LD	BC,I$014C
        LD	L,02H	; 2 
        RST	38H
        LD	BC,I$02F1
        LD	DE,0FF01H
        LD	BC,I.01EF
        RST	38H
        LD	(BC),A
        LD	(D$CF01),HL
        LD	BC,I.01FE
        RST	28H
        DEC	B
        RST	38H
        LD	BC,I.01EF
        XOR	10H	; 16 
        LD	B,H
        INC	C
        LD	B,H
        LD	BC,I.01EF
        JP	NZ,J$2201
        LD	BC,I.01EF
        RST	38H
        LD	BC,I.0111
        LD	E,01H	; 1 
        RST	28H
        LD	BC,I.01FF
        LD	(X.2C01),HL
        LD	BC,I.01CF
        RST	38H
        LD	BC,I.07EF
        RST	38H
        LD	BC,I.01FE
        XOR	0FH	; 15 
        LD	B,H
        DEC	BC
        LD	B,H
        LD	BC,I.014E
        XOR	02H	; 2 
        RST	38H
        LD	BC,I.01EF
        RST	38H
        LD	BC,I.01FE
        XOR	01H	; 1 
        RST	38H
        LD	BC,I.01FE
        INC	L
        LD	BC,I$02CF
        RST	38H
        LD	BC,I$08EF
        RST	38H
        LD	BC,I.01FE
        XOR	0EH	; 14 
        LD	B,H
        DEC	BC
        LD	B,H
        LD	BC,I$044E
        RST	38H
        LD	BC,I.01EE
        JP	(HL)

?5E2F:	LD	BC,I$019E
        XOR	01H	; 1 
        CP	03H	; 3 
        RST	38H
        LD	BC,I.09EF
        RST	38H
        LD	(BC),A
        CP	01H	; 1 
        CALL	PO,C$440D
        DEC	BC
        LD	B,H
        LD	(BC),A
        RST	28H
        LD	D,0FFH
        LD	BC,I.01FE
        XOR	01H	; 1 
        CALL	PO,C$440C
        DEC	BC
        LD	B,H
        LD	BC,I$17EE
        RST	38H
        LD	BC,I.01FE
        RST	38H
        LD	BC,I$0CEE
        LD	B,H
        DEC	BC
        LD	B,H
        LD	BC,I$18EE
        RST	38H
        LD	(BC),A
        CP	01H	; 1 
        XOR	0BH	; 11 
        LD	B,H
        DEC	BC
        LD	B,H
        LD	BC,I$03EF
        RST	38H
        LD	BC,I$15FE
        RST	38H
        LD	BC,I.01EF
        XOR	01H	; 1 
        CALL	PO,C$440A
        DEC	BC
        LD	B,H
        LD	BC,I.01EF
        RST	38H
        LD	BC,I.01FE
        RST	38H
        LD	BC,I$16EF
        RST	38H
        LD	(BC),A
        CP	0AH	; 10 
        LD	B,H
        DEC	BC
        LD	B,H
        LD	BC,I.01EF
        RST	38H
        LD	BC,I.01FE
        LD	DE,0FE01H
        LD	BC,I.01EF
        XOR	04H	; 4 
        RST	38H
        LD	BC,I.01FE
        RST	28H
        LD	BC,I.01FE
        RST	38H
        LD	BC,I.0BEF
        RST	38H
        LD	BC,I.02EF
        XOR	09H	; 9 
        LD	B,H
        DEC	BC
        LD	B,H
        LD	BC,I.02EF
        RST	38H
        LD	BC,I.011E
        RRA
        LD	BC,I.01FF
        RST	28H
        DEC	B
        RST	38H
        LD	BC,I.01FE
        RST	38H
        LD	BC,I.01EE
        RST	28H
        DEC	BC
        RST	38H
        LD	(BC),A
        RST	28H
        LD	BC,I.01EE
        CALL	PO,C$4408
        DEC	BC
        LD	B,H
        LD	BC,I.01EF
        RST	38H
        LD	BC,I.01EF
        POP	AF
        LD	BC,I.011E
        LD	DE,I.EE01
        LD	BC,I.05EF
        RST	38H
        LD	BC,I.01EF
        XOR	02H	; 2 
        RST	28H
        LD	A,(BC)
        RST	38H
        LD	BC,I.01FE
        RST	38H
        LD	BC,I.01EF
        XOR	08H	; 8 
        LD	B,H
        DEC	BC
        LD	B,H
        LD	BC,I.02EF
        RST	38H
        LD	BC,I.01FE
        POP	HL
        LD	BC,I.0111
        RRA
        LD	BC,I$0311
        RST	38H
        LD	(BC),A
        RST	28H
        LD	BC,I.01EE
        POP	HL
        LD	BC,I$0CEF
        RST	38H
        LD	(BC),A
        CP	01H	; 1 
        RST	28H
        LD	BC,I$0714
        LD	B,H
        DEC	BC
        LD	B,H
        LD	BC,I.02EF
        RST	38H
        LD	BC,I.01FE
        XOR	02H	; 2 
        LD	DE,I.EE01
        INC	BC
        RST	38H
        INC	BC
        CP	02H	; 2 
        XOR	01H	; 1 
        CP	0BH	; 11 
        RST	38H
        LD	(BC),A
        CP	01H	; 1 
        XOR	01H	; 1 
        CALL	PO,C.4407
        DEC	BC
        LD	B,H
        LD	BC,I.02EF
        RST	38H
        LD	(BC),A
        XOR	01H	; 1 
        INC	D
        LD	BC,I.0111
        LD	E,01H	; 1 
        RST	28H
        LD	(BC),A
        RST	38H
        LD	BC,I.02EF
        XOR	01H	; 1 
        LD	DE,I$EF02
        INC	C
        RST	38H
        LD	BC,I.01EE
        CP	01H	; 1 
        XOR	07H	; 7 
        LD	B,H
        DEC	BC
        LD	B,H
        LD	BC,I.02EF
        RST	38H
        LD	BC,I.01EF
        POP	HL
        LD	BC,I.0114
        LD	B,C
        LD	BC,I.0111
        RST	28H
        LD	(BC),A
        RST	38H
        LD	(BC),A
        CP	01H	; 1 
        XOR	01H	; 1 
        LD	E,01H	; 1 
        CP	06H	; 6 
        RST	38H
        LD	BC,I.05EF
        RST	38H
        LD	(BC),A
        RST	28H
        LD	BC,I.01EE
        CP	01H	; 1 
        CALL	PO,C$4406
        DEC	BC
        LD	B,H
        LD	BC,I.02EF
        RST	38H
        LD	BC,I.01EE
        POP	HL
        LD	BC,I.0114
        LD	B,H
        LD	BC,I.0141
        XOR	02H	; 2 
        RST	38H
        LD	BC,I.02EF
        XOR	01H	; 1 
        LD	E,01H	; 1 
        XOR	0BH	; 11 
        RST	38H
        INC	BC
        CP	01H	; 1 
        XOR	01H	; 1 
        RST	28H
        LD	BC,I$06EE
        LD	B,H
        DEC	BC
        LD	B,H
        LD	BC,I.01EF
        RST	38H
        INC	BC
        CP	01H	; 1 
        INC	D
        LD	(BC),A
        LD	B,H
        LD	BC,I.024E
        RST	38H
        LD	(BC),A
        CP	01H	; 1 
        POP	HL
        LD	BC,I.011E
        XOR	04H	; 4 
        RST	38H
        LD	(BC),A
        RST	28H
        RLCA
        RST	38H
        LD	BC,I.01EE
        CP	02H	; 2 
        XOR	06H	; 6 
        LD	B,H
        DEC	BC
        LD	B,H
        LD	BC,I.02EF
        RST	38H
        LD	BC,I.01EF
        POP	HL
        LD	BC,I$0214
        LD	B,H
        LD	BC,I.024E
        RST	38H
        LD	BC,I$04EF
        XOR	03H	; 3 
        RST	38H
        LD	BC,I.011E
        CP	08H	; 8 
        RST	38H
        LD	(BC),A
        RST	28H
        LD	BC,I.01EE
        POP	HL
        LD	B,44H	; "D"
        DEC	BC
        LD	B,H
        LD	BC,I.01EF
        RST	38H
        LD	(BC),A
        CP	01H	; 1 
        XOR	01H	; 1 
        INC	D
        LD	(BC),A
        LD	B,H
        LD	BC,I.014E
        RST	38H
        INC	BC
        CP	01H	; 1 
        XOR	01H	; 1 
        LD	DE,I.EF01
        LD	(BC),A
        RRA
        LD	BC,I.01FE
        RST	28H
        ADD	HL,BC
        RST	38H
        INC	BC
        CP	01H	; 1 
        XOR	01H	; 1 
        INC	D
        DEC	B
        LD	B,H
        DEC	BC
        LD	B,H
        LD	BC,I.02EF
        RST	38H
        LD	(BC),A
        XOR	01H	; 1 
        INC	D
        LD	(BC),A
        LD	B,H
        LD	BC,I.024E
        RST	38H
        LD	BC,I.02EF
        XOR	02H	; 2 
        POP	HL
        LD	BC,I.0111
        XOR	0CH	; 12 
        RST	38H
        LD	BC,I.02EF
        XOR	01H	; 1 
        POP	HL
        DEC	B
        LD	B,H
        DEC	BC
        LD	B,H
        LD	BC,I.01EF
        RST	38H
        LD	(BC),A
        CP	01H	; 1 
        LD	DE,I.1401
        LD	(BC),A
        LD	B,H
        LD	BC,I.024E
        RST	38H
        LD	(BC),A
        CP	01H	; 1 
        LD	E,02H	; 2 
        LD	DE,I.1E01
        LD	BC,I.0BEF
        RST	38H
        LD	(BC),A
        CP	02H	; 2 
        XOR	01H	; 1 
        LD	E,05H	; 5 
        LD	B,H
        DEC	BC
        LD	B,H
        LD	BC,I.01EF
        RST	38H
        LD	(BC),A
        RST	28H
        LD	BC,I$03E1
        LD	B,H
        LD	BC,I.024E
        RST	38H
        LD	BC,I.01EF
        XOR	01H	; 1 
        POP	HL
        LD	(BC),A
        LD	DE,I.EF01
        LD	BC,I.01EE
        RST	28H
        DEC	BC
        RST	38H
        LD	BC,I.01EF
        XOR	02H	; 2 
        POP	HL
        DEC	B
        LD	B,H
        LD	A,(BC)
        LD	B,H
        LD	BC,I.024E
        RST	38H
        LD	(BC),A
        CP	01H	; 1 
        POP	HL
        INC	BC
        LD	B,H
        LD	BC,I.014E
        RST	38H
        INC	BC
        CP	01H	; 1 
        LD	E,02H	; 2 
        LD	DE,I.EE01
        LD	BC,I.01FE
        RST	28H
        LD	A,(BC)
        RST	38H
        LD	(BC),A
        CP	02H	; 2 
        XOR	01H	; 1 
        LD	E,05H	; 5 
        LD	B,H
        LD	A,(BC)
        LD	B,H
        LD	BC,I.024E
        RST	38H
        LD	BC,I.02EF
        POP	HL
        INC	BC
        LD	B,H
        LD	BC,I.024E
        RST	38H
        LD	BC,I.01EF
        XOR	01H	; 1 
        POP	HL
        LD	(BC),A
        LD	DE,I.1F01
        LD	BC,I$0BEE
        RST	38H
        LD	(BC),A
        RST	28H
        LD	BC,I.01EE
        LD	E,01H	; 1 
        POP	HL
        DEC	B
        LD	B,H
        LD	A,(BC)
        LD	B,H
        LD	BC,I.014E
        RST	38H
        LD	(BC),A
        CP	02H	; 2 
        POP	HL
        INC	BC
        LD	B,H
        LD	BC,I.014E
        RST	38H
        INC	BC
        CP	01H	; 1 
        LD	E,02H	; 2 
        LD	DE,I.1E01
        LD	BC,I.01EE
        RST	28H
        LD	A,(BC)
        RST	38H
        LD	(BC),A
        CP	01H	; 1 
        XOR	01H	; 1 
        POP	HL
        LD	BC,I$051E
        LD	B,H
        LD	A,(BC)
        LD	B,H
        LD	BC,I.024E
        RST	38H
        LD	BC,I.01EE
        CP	01H	; 1 
        LD	DE,I$4403
        LD	BC,I.024E
        RST	38H
        LD	BC,I.01EF
        XOR	01H	; 1 
        POP	HL
        INC	BC
        LD	DE,I$EE02
        RLCA
        RST	38H
        LD	(BC),A
        RST	28H
        LD	BC,I.01FF
        RST	28H
        LD	(BC),A
        XOR	02H	; 2 
        POP	HL
        DEC	B
        LD	B,H
        LD	A,(BC)
        LD	B,H
        LD	BC,I.01EF
        RST	38H
        LD	BC,I.01FE
        RST	28H
        LD	BC,I.01EE
        INC	D
        INC	BC
        LD	B,H
        LD	BC,I.024E
        RST	38H
        LD	(BC),A
        CP	01H	; 1 
        POP	HL
        INC	BC
        LD	DE,I.1E01
        LD	BC,I.01EE
        POP	HL
        RLCA
        RST	38H
        INC	B
        CP	01H	; 1 
        XOR	01H	; 1 
        LD	E,01H	; 1 
        LD	DE,I$4405
        LD	A,(BC)
        LD	B,H
        LD	BC,I.02EF
        RST	38H
        LD	BC,I.01EE
        LD	E,01H	; 1 
        INC	D
        INC	BC
        LD	B,H
        LD	BC,I.024E
        RST	38H
        LD	(BC),A
        RST	28H
        LD	BC,I$05EE
        LD	DE,I.EF01
        LD	BC,I.01EE
        POP	HL
        DEC	B
        RST	38H
        INC	BC
        RST	28H
        LD	BC,I.01EE
        LD	E,01H	; 1 
        POP	HL
        LD	BC,I.0511
        LD	B,H
        ADD	HL,BC
        LD	B,H
        LD	BC,I.024E
        RST	38H
        LD	(BC),A
        CP	01H	; 1 
        POP	HL
        LD	BC,I.0314
        LD	B,H
        LD	BC,I.024E
        RST	38H
        LD	(BC),A
        CP	01H	; 1 
        XOR	04H	; 4 
        LD	DE,0FF02H
        LD	BC,I$02FE
        XOR	02H	; 2 
        LD	E,05H	; 5 
        CP	03H	; 3 
        POP	HL
        LD	BC,I.0511
        LD	B,H
        ADD	HL,BC
        LD	B,H
        LD	BC,I.02EF
        RST	38H
        LD	BC,I.01EF
        XOR	01H	; 1 
        CP	01H	; 1 
        INC	D
        INC	BC
        LD	B,H
        LD	BC,I$024F
        RST	38H
        LD	BC,I.02EF
        XOR	02H	; 2 
        LD	DE,I.1F01
        ADD	HL,BC
        RST	38H
        INC	BC
        RST	28H
        LD	(BC),A
        XOR	01H	; 1 
        LD	E,01H	; 1 
        LD	DE,I.1401
        DEC	B
        LD	B,H
        EX	AF,AF'
        LD	B,H
        LD	BC,I.024E
        RST	38H
        LD	(BC),A
        RST	28H
        LD	BC,I.01FE
        POP	HL
        LD	BC,I.0314
        LD	B,H
        LD	BC,I.01EF
        RST	38H
        INC	BC
        CP	01H	; 1 
        XOR	01H	; 1 
        LD	DE,I.1F01
        LD	BC,I.01FF
        RRA
        INC	BC
        RST	38H
        LD	BC,I.01F1
        RST	38H
        LD	(BC),A
        RST	28H
        INC	BC
        CP	01H	; 1 
        XOR	03H	; 3 
        POP	HL
        LD	BC,I$0611
        LD	B,H
        EX	AF,AF'
        LD	B,H
        LD	BC,I.01EF
        RST	38H
        LD	BC,I$011F
        RST	38H
        LD	BC,I.011E
        POP	HL
        LD	BC,I.03EE
        LD	B,H
        LD	BC,I$054E
        RST	38H
        LD	BC,I.01EE
        LD	DE,I.1F01
        LD	BC,I.02FF
        RRA
        LD	BC,I.01F1
        RST	38H
        LD	BC,I.01F1
        LD	E,02H	; 2 
        CP	01H	; 1 
        POP	HL
        INC	BC
        XOR	01H	; 1 
        LD	E,02H	; 2 
        LD	DE,I.1401
        LD	B,44H	; "D"
        EX	AF,AF'
        LD	B,H
        LD	BC,I.01EF
        POP	AF
        LD	BC,I.01EF
        POP	AF
        LD	(BC),A
        XOR	01H	; 1 
        INC	D
        INC	BC
        LD	B,H
        LD	BC,I.014E
        POP	AF
        LD	BC,I.02EF
        RRA
        LD	BC,I.01EE
        POP	HL
        LD	(BC),A
        LD	DE,0FE01H
        LD	(BC),A
        RRA
        LD	BC,I.01F1
        LD	E,03H	; 3 
        LD	DE,I.1E01
        LD	(BC),A
        LD	DE,I$E103
        LD	(BC),A
        LD	DE,C.4407
        LD	(DE),A
        LD	B,H
        LD	BC,I$014F
        LD	E,01H	; 1 
        POP	AF
        LD	BC,I.01EF
        LD	E,01H	; 1 
        CP	01H	; 1 
        POP	HL
        LD	(BC),A
        LD	DE,I.EE01
        LD	C,11H	; 17 
        EX	AF,AF'
        LD	B,H
        LD	(0FF44H),A

        END
