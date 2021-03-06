;  
;   RS232 -> Source re-created by Z80DIS 2.2
;      Z80DIS was written by Kenneth Gielow
;                            Palo Alto, CA
        .Z80
        ASEG
        ORG	04000H

RDSLT	EQU	0000CH
WRSLT	EQU	00014H
CALSLT  EQU     0001CH
ENASLT	EQU	00024H
CHSNS   EQU     0009CH
CHGET   EQU     0009FH
CHPUT   EQU     000A2H
LPTOUT  EQU     000A5H
BREAKX	EQU	000B7H

M4055	EQU	04055H			; syntax error
M406D	EQU	0406DH			; type mismatch error
M4295	EQU	04295H			; search linenumber
M4666	EQU	04666H			; CHRGTR (get next BASIC char)
M475A	EQU	0475AH			; illegal function call
M4769	EQU	04769H			; collect linenumber
M481C	EQU	0481CH			; undefined line number error
M4C64	EQU	04C64H			; evaluate expression
M517A	EQU	0517AH			; convert to DAC to new type
M521C	EQU	0521CH			; evaluate byte operand
M542F	EQU	0542FH			; evaluate address operand
M5EA4	EQU	05EA4H			; locate variable
M631B	EQU	0631BH			; enable trap
M632B	EQU	0632BH			; disable trap
M6331	EQU	06331H			; pause trap
M67D0	EQU	067D0H			; free temporary string with type check
M6E6B	EQU	06E6BH			; bad filename error
M6E80	EQU	06E80H			; internal error
M6E6E	EQU	06E6EH			; file already open error
M6E77	EQU	06E77H			; file not open error
M6E86	EQU	06E86H			; sequential I/O only error
M73B2	EQU	073B2H			; device I/O error

VALTYP	EQU	0F663H
DAC	EQU	0F7F6H
PTRFIL	EQU	0F864H
FNKSTR	EQU	0F87FH
OLDINT	EQU	0FB11H
HOKVLD	EQU	0FB20H
ONGSBF	EQU	0FBD8H
TRPTBL	EQU	0FC4CH
INTFLG	EQU	0FC9BH
ESCCNT	EQU	0FCA7H
CSRSW	EQU	0FCA9H
EXPTBL	EQU	0FCC1H
PROCNM	EQU	0FD89H
H.KEYI	EQU	0FD9AH
H.NEWS  EQU     0FF3EH
EXTBIO  EQU     0FFCAH
DISINT	EQU	0FFCFH
ENAINT	EQU	0FFD4H

DFFFF	EQU	0FFFFH

I6000	EQU	6000H
I6400	EQU	6400H
I6600	EQU	6600H
D661E	EQU	661EH
I664B	EQU	664BH
I665A	EQU	665AH
D6676	EQU	6676H
D6678	EQU	6678H
D667A	EQU	667AH
D667C	EQU	667CH
D667E	EQU	667EH
D6680	EQU	6680H
D6682	EQU	6682H
D6683	EQU	6683H
D6684	EQU	6684H
D6685	EQU	6685H
D6687	EQU	6687H
D6688	EQU	6688H
D6689	EQU	6689H
D668B	EQU	668BH
D668D	EQU	668DH
D668F	EQU	668FH
D6690	EQU	6690H
D6691	EQU	6691H
D6692	EQU	6692H
D6693	EQU	6693H
D6694	EQU	6694H
D6695	EQU	6695H
D6697	EQU	6697H
J6699	EQU	6699H
X669E	EQU	669EH
X66A3	EQU	66A3H
D66A8	EQU	66A8H
D66A9	EQU	66A9H
D66AA	EQU	66AAH
D66AB	EQU	66ABH
D66AC	EQU	66ACH
D66AD	EQU	66ADH
I66AE	EQU	66AEH
I66BB	EQU	66BBH
D66EB	EQU	66EBH
I6700	EQU	6700H
I67FC	EQU	67FCH
I6C46	EQU	6C46H
IBFF9	EQU	0BFF9H
DBFFA	EQU	0BFFAH


        DEFB	"AB"
        DEFW	C40B2
        DEFW	C435A
        DEFW	C440C
        DEFW	0
        DEFS	6,0

;     Device information byte indicates following options are installed or not:
;	bits #  76543210
;		||||||||
;		|||||||+----- reserved
;		|||||||
;		||||||+------ TXREADY interrupt
;		||||||
;		|||||+------- sync/break character detected
;		|||||
;		||||+-------- timer interrupt
;		||||
;		|||+--------- carrier detect
;		|||
;		||+---------- ring indicator
;		||
;		|+----------- reserved
;		|
;		+------------ reserved

A4010:	DEFB	010H		; +00 MSX serial features (no TxReady INT, No Sync detect, No Timer INT, Have CD, No RI)
        DEFB	1		; +01 MSX serial version (version 2.0)
        DEFB	0		; +02 reserved
J4013:	JP	J4040		; +03 RS232.INIT
        JP	C44B9		; +06 RS232.OPEN
        JP	C59C1		; +09 RS232.STAT
        JP	C4585		; +0C RS232.GETCHR
        JP	C56E7		; +0F RS232.SNDCHR
        JP	C4525		; +12 RS232.CLOSE
        JP	J408B		; +15 RS232.EOF
        JP	C4622		; +18 RS232.LOC
        JP	C4675		; +1B RS232.LOF
        JP	C46B7		; +1E RS232.BACKUP
        JP	C5903		; +21 RS232.SNDBRK
        JP	C597D		; +24 RS232.DTR
        JP	C51C7		; +27 RS232.SETCHN
        RET			; +2A future
        RET
        RET
        RET			; +2D future
        RET
        RET

;	  Subroutine __________________________
;	     Inputs  ________________________
;	     Outputs ________________________

J4040:	EI
        PUSH	BC
        PUSH	DE
        PUSH	HL
        PUSH	BC
        CALL	C53C7
        POP	BC
        LD	IY,-13
        ADD	IY,SP
        LD	SP,IY
        PUSH	IY
        POP	DE
        LD	C,13
J4056:	CALL	C488E
        LD	(DE),A
        INC	DE
        DEC	C
        JR	NZ,J4056
        DI
        LD	(D6678),SP
        LD	SP,I67FC
        PUSH	BC
        PUSH	HL
        CALL	C53A8
        PUSH	AF
        CALL	C5447
        POP	AF
        POP	HL
        POP	BC
        PUSH	AF
        CALL	C5232
        CALL	C549F
        LD	SP,(D6678)
        EX	AF,AF'
        LD	IY,13
        ADD	IY,SP
        LD	SP,IY
        EX	AF,AF'
        POP	HL
        POP	DE
        POP	BC
        RET

;	  Subroutine __________________________
;	     Inputs  ________________________
;	     Outputs ________________________

J408B:	LD	HL,0
        DI
        LD	(D6678),SP
        LD	SP,I67FC
        PUSH	BC
        PUSH	HL
        CALL	C53A8
        PUSH	AF
        CALL	C5447
        POP	AF
        POP	HL
        POP	BC
        PUSH	AF
        CALL	C551A
        CALL	C549F
        LD	SP,(D6678)
        RET	Z
        CALL	C4694
        RET

;	  Subroutine __________________________
;	     Inputs  ________________________
;	     Outputs ________________________

C40B2:	XOR	A
        LD	(D6676),A
        DEC	A
        LD	(D66EB),A
        DI
        CALL	C53A8
        PUSH	AF
        CALL	C5389			; get current slotid page 1
        LD	(D6683),A
        LD	H,80H
        CALL	ENASLT
        XOR	A
        LD	B,A
        LD	IY,I431B
J40D0:	PUSH	BC
        CALL	C42BF
        POP	BC
        CALL	C4342
        JR	NZ,J40E8
        PUSH	BC
        CALL	C5232
        CALL	C42F6
        POP	BC
        INC	B
        LD	A,B
        CP	04H	; 4 
        JR	NZ,J40D0
J40E8:	LD	A,B
        LD	(D668F),A
        POP	AF
        LD	H,80H
        CALL	ENASLT
        LD	HL,HOKVLD
        BIT	0,(HL)
        JR	NZ,J4105
        SET	0,(HL)
        LD	HL,EXTBIO
        LD	B,5
J4100:	LD	(HL),0C9H
        INC	HL
        DJNZ	J4100
J4105:	XOR	A
        LD	DE,00001H
        CALL	EXTBIO
        LD	(D6692),A
        XOR	A
        LD	DE,00801H
        CALL	EXTBIO
        LD	(D6691),A
        OR	A
        JP	Z,J41C1
        LD	HL,I6700
        LD	A,(D6683)
        LD	B,A
        LD	DE,00800H
        CALL	EXTBIO
        LD	DE,I6700
        OR	A
        SBC	HL,DE
        JP	Z,J41C1
        LD	A,L
        RRCA
        RRCA
        AND	3FH	; "?"
        LD	B,A
        LD	H,D
        LD	L,E
J413B:	LD	A,(HL)
        INC	HL
        LD	E,(HL)
        INC	HL
        LD	D,(HL)
        INC	DE
        EX	DE,HL
        PUSH	BC
        PUSH	DE
        CALL	RDSLT
        POP	DE
        POP	BC
        EX	DE,HL
        OR	A
        JR	NZ,J4154
        INC	HL
        INC	HL
        DJNZ	J413B
        JP	J41E3
J4154:	LD	A,0FFH
        LD	(D6682),A
        DEC	HL
        DEC	HL
        LD	A,(OLDINT+0)
        OR	A
        JR	Z,J4187
        LD	A,(HL)
        PUSH	HL
        LD	HL,D6676
        CALL	RDSLT
        POP	HL
        OR	A
        JR	NZ,J4187
        LD	A,(HL)
        PUSH	HL
        LD	HL,D6691
        CALL	RDSLT
        POP	HL
        OR	A
        JR	NZ,J4187
        LD	A,(D6683)
        LD	E,A
        LD	A,(HL)
        PUSH	HL
        LD	HL,D6676
        LD	(HL),E
        CALL	WRSLT
        POP	HL
J4187:	LD	B,(HL)
        LD	HL,I6600-2
J418B:	INC	HL
        INC	HL
        PUSH	BC
        LD	A,B
        CALL	RDSLT
        POP	BC
        OR	A
        JR	NZ,J418B
        LD	A,(D6676)
        OR	A
        JR	Z,J41AE
        PUSH	BC
        LD	A,B
        LD	E,0FFH
        CALL	WRSLT
        POP	BC
        INC	HL
        PUSH	BC
        LD	A,B
        LD	E,0FFH
        CALL	WRSLT
        POP	BC
        INC	HL
J41AE:	LD	A,(D6683)
        LD	E,A
        PUSH	BC
        LD	A,B
        CALL	WRSLT
        POP	BC
        INC	HL
        LD	A,(D668F)
        LD	E,A
        LD	A,B
        JP	WRSLT

J41C1:	CALL	C4328
        JR	Z,J41E3
        DI
        CALL	C53A8
        PUSH	AF
        LD	A,(D6683)
        LD	H,80H
        CALL	ENASLT
        LD	A,0FFH
        LD	(DBFFA),A
        POP	AF
        LD	H,80H
        CALL	ENASLT
        LD	HL,0FFFEH
        JR	J41E6
J41E3:	LD	HL,0EFEEH
J41E6:	LD	(D6695),HL
        LD	HL,0EFEEH
        LD	(D6697),HL
        XOR	A
        LD	(D6682),A
        LD	(D6687),A
        LD	(X66A3),A
        LD	(X669E),A
        LD	HL,I6600
        LD	B,15*2
J4201:	LD	(HL),A
        INC	HL
        DJNZ	J4201
        LD	HL,I664B
        LD	B,15*1+15*2
J420A:	LD	(HL),A
        INC	HL
        DJNZ	J420A
        DEC	A
        LD	HL,D661E
        LD	B,15*3
J4214:	LD	(HL),A
        INC	HL
        DJNZ	J4214
        LD	A,(D6683)
        LD	(I6600+0),A
        LD	A,(D668F)
        LD	(I6600+1),A
        LD	DE,J6699
        DI
        LD	HL,EXTBIO
        LD	BC,5
        LDIR
        LD	A,(D6683)
        LD	(EXTBIO+1),A
        LD	A,0F7H
        LD	(EXTBIO+0),A
        LD	HL,I4727
        LD	(EXTBIO+2),HL
        LD	A,0C9H
        LD	(EXTBIO+4),A
        LD	BC,00018H
        LD	HL,I4257
        LD	DE,DISINT
        LDIR
        XOR	A
        CALL	C42BF
        EI
        RET

I4257:	PUSH	DE
        LD	E,02H	; 2 
        JR	J425F
        PUSH	DE
        LD	E,03H	; 3 
J425F:	LD	D,00H
        PUSH	IX
        PUSH	IY
        CALL	EXTBIO
        EI
        POP	IY
        POP	IX
        POP	DE
        RET

;	  Subroutine __________________________
;	     Inputs  ________________________
;	     Outputs ________________________

C426F:	DI
        LD	A,(X66A3)
        OR	A
        RET	NZ
        LD	DE,X66A3
        LD	HL,H.KEYI
        LD	BC,5
        LDIR
        LD	A,0F7H
        LD	(H.KEYI+0),A
        LD	A,(D6683)
        LD	(H.KEYI+1),A
        LD	HL,I5514
        LD	(H.KEYI+2),HL
        LD	A,0C9H
        LD	(H.KEYI+4),A
        RET

;	  Subroutine __________________________
;	     Inputs  ________________________
;	     Outputs ________________________

C4297:	DI
        LD	A,(X669E)
        OR	A
        RET	NZ
        LD	DE,X669E
        LD	HL,H.NEWS
        LD	BC,5
        LDIR
        LD	A,0F7H
        LD	(H.NEWS+0),A
        LD	A,(D6683)
        LD	(H.NEWS+1),A
        LD	HL,I50E4
        LD	(H.NEWS+2),HL
        LD	A,0C9H
        LD	(H.NEWS+4),A
        RET

;	  Subroutine __________________________
;	     Inputs  ________________________
;	     Outputs ________________________

C42BF:	LD	(D6688),A
        LD	B,A
        LD	HL,I6000+04000H
        ADD	A,H
        LD	H,A
        LD	(D668D),HL
        LD	A,B
        LD	IX,I6400+04000H
        LD	BC,128
        LD	HL,IBFF9
        LD	DE,-8
        OR	A
        JP	Z,J42EE
        ADD	IX,BC
        ADD	HL,DE
        DEC	A
        JP	Z,J42EE
        ADD	IX,BC
        ADD	HL,DE
        DEC	A
        JP	Z,J42EE
        ADD	IX,BC
        ADD	HL,DE
J42EE:	LD	(D6689),IX
        LD	(D668B),HL
        RET

;	  Subroutine __________________________
;	     Inputs  ________________________
;	     Outputs ________________________

C42F6:	LD	(IX+9),00H

;	  Subroutine __________________________
;	     Inputs  ________________________
;	     Outputs ________________________

C42FA:	LD	(IX+1),00H
        LD	(IX+2),00H
        PUSH	BC
        LD	B,04H	; 4 
        LD	A,05H	; 5 
        CALL	C430C
        POP	BC
        RET

;	  Subroutine __________________________
;	     Inputs  ________________________
;	     Outputs ________________________

C430C:	PUSH	IX
        EX	(SP),HL
        ADD	A,L
        LD	L,A
        JR	NC,J4314
        INC	HL
J4314:	LD	(HL),00H
        INC	HL
        DJNZ	J4314
        POP	HL
        RET

I431B:	DEFB	"8N1XHNNN"
        DEFW	1200
        DEFW	1200
        DEFB	0

;	  Subroutine __________________________
;	     Inputs  ________________________
;	     Outputs ________________________

C4328:	XOR	A
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
        EX	(SP),HL
        EX	(SP),HL
        IN	A,(81H)
        AND	3FH	; "?"
        CP	05H	; 5 
        RET

;	  Subroutine __________________________
;	     Inputs  ________________________
;	     Outputs ________________________

C4342:	LD	HL,(D668B)
        XOR	A
        LD	(HL),A
        PUSH	AF
        POP	AF
        LD	(HL),A

;	  Subroutine __________________________
;	     Inputs  ________________________
;	     Outputs ________________________

C434A:	PUSH	AF
        POP	AF
        LD	(HL),A
        PUSH	AF
        POP	AF
        LD	A,40H	; "@"
        LD	(HL),A
        EX	(SP),HL
        EX	(SP),HL
        LD	A,(HL)
        AND	3FH	; "?"
        CP	05H	; 5 
        RET

;	  Subroutine __________________________
;	     Inputs  ________________________
;	     Outputs ________________________

C435A:	EI
        LD	A,(D6682)
        OR	A
        SCF
        RET	NZ
        LD	(D6685),HL
        LD	DE,I43AF
        CALL	C436D
        RET	C
J436B:	PUSH	DE
        RET

;	  Subroutine __________________________
;	     Inputs  ________________________
;	     Outputs ________________________

C436D:	PUSH	BC
        PUSH	HL
J436F:	LD	HL,PROCNM
        LD	A,(DE)
        INC	A
        JR	Z,J4388
        CALL	C438C
        JR	Z,J4380
        INC	DE
        INC	DE
        INC	DE
        JR	J436F
J4380:	EX	DE,HL
        INC	HL
        LD	E,(HL)
        INC	HL
        LD	D,(HL)
        OR	A
        JR	J4389
J4388:	SCF
J4389:	POP	HL
        POP	BC
        RET

;	  Subroutine __________________________
;	     Inputs  ________________________
;	     Outputs ________________________

C438C:	LD	A,(DE)
        CALL	C5229
        LD	C,A
        LD	A,(HL)
        CALL	C5229
        CP	C
        JR	NZ,J439E
        OR	A
        RET	Z
        INC	DE
        INC	HL
        JR	C438C
J439E:	LD	A,(DE)
        OR	A
        JR	Z,J43A5
        INC	DE
        JR	J439E
J43A5:	LD	A,(HL)
        OR	A
        JR	Z,J43AC
        INC	HL
        JR	J43A5
J43AC:	LD	A,L
        OR	H
        RET
I43AF:	DEFB	"COMINI",0
        DEFW	C495B
        DEFB	"COMDTR",0
        DEFW	C4AF4
        DEFB	"COMSTAT",0
        DEFW	C4B1F
        DEFB	"COMBREAK",0
        DEFW	C4B51
        DEFB	"COMTERM",0
        DEFW	C4BA3
        DEFB	"COM",0
        DEFW	C5001
        DEFB	"COMON",0
        DEFW	C5068
        DEFB	"COMOFF",0
        DEFW	C504E
        DEFB	"COMSTOP",0
        DEFW	C5082
        DEFB	"COMHELP",0
        DEFW	C4E08
        DEFB	0FFH

C440C:	EI
        PUSH	AF
        LD	A,(D6682)
        OR	A
        JR	Z,J4417
        POP	AF
        SCF
        RET
J4417:	POP	AF
        CP	0FFH
        JP	NZ,J4459
        LD	HL,PROCNM
        LD	A,(HL)
        CP	"C"
        SCF
        RET	NZ
        INC	HL
        LD	A,(HL)
        CP	"O"
        SCF
        RET	NZ
        INC	HL
        LD	A,(HL)
        CP	"M"
        SCF
        RET	NZ
        INC	HL
        LD	A,(HL)
        OR	A
        JR	NZ,J4439
        DEC	HL
        LD	A,"0"
J4439:	SUB	"0"
        RET	C
        CP	0AH	; 10 
        CCF
        RET	C
        LD	E,A
        CALL	C51C7
        RET	C
        INC	HL
        LD	A,(HL)
        OR	A
        SCF
        RET	NZ
        LD	A,(D6687)
        LD	HL,D6691
        SUB	(HL)
        LD	HL,D66EB
        CP	(HL)
        ADC	A,0FFH
        OR	A
        RET
J4459:	CP	13H	; 19 
        JP	NC,J4841
        BIT	0,A
        JP	NZ,J4841
        PUSH	HL
        PUSH	AF
        LD	HL,I4474
        ADD	A,L
        LD	L,A
        JR	NC,J446D
        INC	H
J446D:	LD	A,(HL)
        INC	HL
        LD	H,(HL)
        LD	L,A
        POP	AF
        EX	(SP),HL
        RET

I4474:	DEFW	C4488
        DEFW	C450A
        DEFW	C4847
        DEFW	C456C
        DEFW	C457B
        DEFW	C4611
        DEFW	C466C
        DEFW	C4688
        DEFW	J4865
        DEFW	C46B4

C4488:	PUSH	HL
        LD	HL,I664B
        LD	A,(D6687)
        ADD	A,L
        LD	L,A
        LD	A,(HL)
        POP	HL
        OR	A
        LD	A,02H	; 2 
        JR	NZ,J44B2
        LD	A,(D6687)
        EX	DE,HL
        PUSH	HL
        ADD	A,A
        ADD	A,5AH	; "Z"
        LD	L,A
        LD	H,66H	; "f"
        LD	(HL),E
        INC	HL
        LD	(HL),D
        POP	HL
        EX	DE,HL
        CALL	C44B9
        JR	C,J44B2
        LD	(HL),E
        LD	(PTRFIL),HL
        RET
J44B2:	DEC	A
        JP	Z,J483B
        JP	J484D

;	  Subroutine __________________________
;	     Inputs  ________________________
;	     Outputs ________________________

C44B9:	PUSH	BC
        PUSH	HL
        PUSH	DE
        CALL	C53C7
        CALL	C426F
        POP	DE
        DI
        LD	(D6678),SP
        LD	SP,I67FC
        PUSH	BC
        PUSH	HL
        CALL	C53A8
        PUSH	AF
        CALL	C5447
        POP	AF
        POP	HL
        POP	BC
        PUSH	AF
        LD	HL,I664B
        LD	A,(D6687)
        ADD	A,L
        LD	L,A
        LD	A,(HL)
        OR	A
        JR	NZ,J4505
        LD	A,E
        CP	08H	; 8 
        JR	NC,J4501
        DI
        LD	(HL),E
        CALL	C42F6
        CALL	C5500
        CALL	C5965
        SCF
J44F5:	CCF
        CALL	C549F
        LD	SP,(D6678)
        POP	HL
        POP	BC
        EI
        RET
J4501:	XOR	A
        INC	A
        JR	J44F5
J4505:	LD	A,02H	; 2 
        OR	A
        JR	J44F5

C450A:	CALL	C4709
        CALL	C4525
        LD	(HL),00H
        LD	A,(D6687)
        EX	DE,HL
        PUSH	HL
        ADD	A,A
        ADD	A,5AH	; "Z"
        LD	L,A
        LD	H,66H	; "f"
        LD	(HL),00H
        INC	HL
        LD	(HL),00H
        POP	HL
        EX	DE,HL
        RET

;	  Subroutine __________________________
;	     Inputs  ________________________
;	     Outputs ________________________

C4525:	PUSH	DE
        PUSH	HL
        LD	HL,I664B
        LD	A,(D6687)
        ADD	A,L
        LD	L,A
        LD	A,(HL)
        LD	(HL),00H
        CP	02H	; 2 
        LD	E,00H
        SCF
        CCF
        JR	NZ,J4541
        LD	A,1AH
        CALL	C56E7
        PUSH	AF
        POP	DE
J4541:	DI
        LD	(D6678),SP
        LD	SP,I67FC
        PUSH	BC
        PUSH	HL
        CALL	C53A8
        PUSH	AF
        CALL	C5447
        POP	AF
        POP	HL
        POP	BC
        PUSH	AF
        CALL	C5A09
        CALL	C596D
        CALL	C5507
        CALL	C549F
        LD	SP,(D6678)
        PUSH	DE
        POP	AF
        POP	HL
        POP	DE
        EI
        RET

C456C:	CALL	C4709
        LD	A,C
        CALL	C56E7
        EI
        JP	C,J4871
        JP	Z,J4871
        RET

C457B:	CALL	C4709
        CALL	C4585
        JP	M,J4871
        RET

;	  Subroutine __________________________
;	     Inputs  ________________________
;	     Outputs ________________________

C4585:	PUSH	BC
        PUSH	DE
        PUSH	HL
        DI
        LD	(D6678),SP
        LD	SP,I67FC
        PUSH	BC
        PUSH	HL
        CALL	C53A8
        PUSH	AF
        CALL	C5447
        POP	AF
        POP	HL
        POP	BC
        PUSH	AF
        LD	C,(IX+1)
        LD	(IX+1),00H
        LD	A,(IX+2)
        LD	(IX+2),00H
        LD	(IX+8),A
        PUSH	AF
        LD	HL,I664B
        LD	A,(D6687)
        ADD	A,L
        LD	L,A
        LD	E,(HL)
        POP	AF
        CALL	C549F
        LD	SP,(D6678)
        OR	A
        JR	NZ,J4605
        LD	A,C
        OR	A
        JR	NZ,J45D6
        CALL	C552A
        EI
        LD	C,A
        JP	M,J4605
        CALL	C58AA
        JR	C,J4605
        JR	Z,J4605
J45D6:	LD	A,E
        CP	04H	; 4 
        JR	Z,J4609
        LD	A,C
        CP	1AH
        JR	NZ,J4609
        DI
        LD	(D6678),SP
        LD	SP,I67FC
        PUSH	BC
        PUSH	HL
        CALL	C53A8
        PUSH	AF
        CALL	C5447
        POP	AF
        POP	HL
        POP	BC
        PUSH	AF
        LD	A,1AH
        LD	(IX+1),A
        CALL	C549F
        LD	SP,(D6678)
        OR	A
        SCF
        JR	J460C
J4605:	OR	80H
        JR	J460B
J4609:	XOR	A
        INC	A
J460B:	LD	A,C
J460C:	POP	HL
        POP	DE
        POP	BC
        EI
        RET

C4611:	CALL	C4709
        PUSH	HL
        CALL	C4622
J4618:	LD	(DAC+2),HL
        LD	HL,VALTYP
        LD	(HL),02H	; 2 
        POP	HL
        RET

;	  Subroutine __________________________
;	     Inputs  ________________________
;	     Outputs ________________________

C4622:	PUSH	AF
        EI
        DEFB	0,0
        DI
        LD	(D6678),SP
        LD	SP,I67FC
        PUSH	BC
        PUSH	HL
        CALL	C53A8
        PUSH	AF
        CALL	C5447
        POP	AF
        POP	HL
        POP	BC
        PUSH	AF
        LD	HL,I664B
        LD	A,(D6687)
        ADD	A,L
        LD	L,A
        LD	A,(HL)
        CP	01H	; 1 
        JR	NZ,J465C
        LD	A,(IX+1)
        OR	A
        JR	Z,J4654
        SUB	1AH
        JR	Z,J465F
        LD	A,01H	; 1 
J4654:	PUSH	BC
        CALL	C46E1
        ADD	A,C
        POP	BC
        JR	J465F
J465C:	CALL	C551A
J465F:	LD	L,A
        LD	H,00H
        CALL	C549F
        LD	SP,(D6678)
        POP	AF
        EI
        RET

C466C:	CALL	C4709
        PUSH	HL
        CALL	C4675
J4673:	JR	J4618

;	  Subroutine __________________________
;	     Inputs  ________________________
;	     Outputs ________________________

C4675:	PUSH	AF
        EI
        CALL	C4622
        PUSH	DE
        EX	DE,HL
        LD	A,80H
        LD	L,A
        LD	H,00H
        OR	A
        SBC	HL,DE
        INC	HL
        POP	DE
        POP	AF
        RET

C4688:	CALL	C4709
        PUSH	HL
        CALL	C4694
        JP	M,J4871
        JR	J4673

;	  Subroutine __________________________
;	     Inputs  ________________________
;	     Outputs ________________________

C4694:	PUSH	BC
        LD	B,A
        EI
        CALL	C4585
        JP	M,J46B1
        PUSH	BC
        LD	C,A
        CALL	C46B7
        POP	BC
        CP	1AH
        JR	Z,J46AD
        XOR	A
        LD	L,A
        LD	H,A
        INC	A
        JR	J46B1
J46AD:	LD	HL,-1
        SCF
J46B1:	LD	A,B
        POP	BC
        RET

C46B4:	CALL	C4709

;	  Subroutine __________________________
;	     Inputs  ________________________
;	     Outputs ________________________

C46B7:	PUSH	AF
        DI
        LD	(D6678),SP
        LD	SP,I67FC
        PUSH	BC
        PUSH	HL
        CALL	C53A8
        PUSH	AF
        CALL	C5447
        POP	AF
        POP	HL
        POP	BC
        PUSH	AF
        LD	(IX+1),C
        LD	A,(IX+8)
        AND	38H	; "8"
        LD	(IX+2),A
        CALL	C549F
        LD	SP,(D6678)
        POP	AF
        RET

;	  Subroutine __________________________
;	     Inputs  ________________________
;	     Outputs ________________________

C46E1:	PUSH	AF
        PUSH	HL
        LD	C,00H
        LD	A,(IX+5)
        OR	A
        JR	Z,J46F7
        LD	B,A
J46EC:	CALL	C46FA
        LD	A,(HL)
        CP	1AH
        JR	Z,J46F7
        INC	C
        DJNZ	J46EC
J46F7:	POP	HL
        POP	AF
        RET

;	  Subroutine __________________________
;	     Inputs  ________________________
;	     Outputs ________________________

C46FA:	LD	A,(IX+6)
        ADD	A,C
        JP	P,J4703
        SUB	80H
J4703:	LD	HL,(D668D)
        ADD	A,A
        LD	L,A
        RET

;	  Subroutine __________________________
;	     Inputs  ________________________
;	     Outputs ________________________

C4709:	PUSH	AF
        PUSH	BC
        EX	DE,HL
        PUSH	HL
        LD	B,0FFH
        LD	HL,I665A
J4712:	INC	B
        LD	A,(HL)
        INC	HL
        LD	C,(HL)
        INC	HL
        CP	E
        JR	NZ,J4712
        LD	A,C
        CP	D
        JR	NZ,J4712
        LD	A,B
        LD	(D6687),A
        POP	HL
        EX	DE,HL
        POP	BC
        POP	AF
        RET

;	  Subroutine EXTBIO handler
;	     Inputs  ________________________
;	     Outputs ________________________

I4727:	EI
        PUSH	AF
        LD	A,D
        INC	A			; system exclusive ?
        JP	Z,J47EC			; yep, handle it
        DEC	A			; broadcast ?
        JP	NZ,J47FF		; nope,
        LD	A,E
        OR	A			; build device name table ?
        JR	Z,J4742			; yep,
        DEC	A			; return numer of trap entries ?
        JR	Z,J474F			; yep,
        DEC	A			; disable interrupt ?
        JR	Z,J4761
        DEC	A			; enable interrupt ?
        JR	Z,J47A7
        JP	J4826			; unknown function, quit

J4742:	LD	A,08H
        CALL	C4878			; RS232 device (8)
        LD	A,00H
        CALL	C4878			; reserved byte
        JP	J4826			; quit

J474F:	PUSH	BC
        PUSH	DE
        CALL	C53C7
        POP	DE
        POP	BC
        POP	AF
        PUSH	HL
        LD	HL,D6690
        ADD	A,(HL)
        POP	HL
        PUSH	AF
        JP	J4826			; quit

J4761:	PUSH	BC
        PUSH	DE
        PUSH	HL
        LD	A,(D661E)
        INC	A
        JR	Z,J47A1
        DI
        LD	(D6678),SP
        LD	SP,I67FC
        CALL	C53A8
        PUSH	AF
        LD	A,(D6691)
        LD	D,A
        LD	E,00H
        LD	HL,I664B
        ADD	A,L
        LD	L,A
J4781:	LD	A,(HL)
        OR	A
        JR	Z,J4791
        LD	A,D
        PUSH	HL
        CALL	C544A
        CALL	C56B7
        CALL	C5507
        POP	HL
J4791:	INC	HL
        INC	D
        INC	E
        LD	A,(D6690)
        CP	E
        JR	NZ,J4781
        CALL	C549F
        LD	SP,(D6678)
J47A1:	POP	HL
        POP	DE
        POP	BC
        JP	J4826

J47A7:	PUSH	BC
        PUSH	DE
        PUSH	HL
        LD	A,(D661E)
        INC	A
        JR	Z,J47A1
        DI
        LD	(D6678),SP
        LD	SP,I67FC
        CALL	C53A8
        PUSH	AF
        LD	A,(D6691)
        LD	D,A
        LD	E,00H
        LD	HL,I664B
        ADD	A,L
        LD	L,A
J47C7:	LD	A,(HL)
        OR	A
        JR	Z,J47DA
        LD	A,D
        PUSH	HL
        CALL	C544A
        CALL	C5500
        CALL	C5965
        CALL	C56A1
        POP	HL
J47DA:	INC	HL
        INC	D
        INC	E
        LD	A,(D6690)
        CP	E
        JR	NZ,J47C7
        CALL	C549F
        LD	SP,(D6678)
        JR	J47A1

J47EC:	LD	A,E
        OR	A			; Build slot address table ?
        JR	NZ,J47FD		; nope, quit
        CALL	C482A			; slotid + jumptable start
        LD	A,00H
        CALL	C4878			; reserved byte
        LD	A,00H
        CALL	C4878			; reserved byte
J47FD:	JR	J4826			; quit
J47FF:	CP	08H			; device RS232 ?
        JR	NZ,J4826		; nope, quit
        LD	A,E
        OR	A
        JR	Z,J480D
        CP	01H	; 1 
        JR	Z,J4817
        JR	J4826
J480D:	CALL	C482A			; slotid + jumptable start
        LD	A,00H
        CALL	C4878			; reserved byte
        JR	J4826

J4817:	PUSH	BC
        PUSH	DE
        CALL	C53C7
        POP	DE
        POP	BC
        POP	AF
        PUSH	HL
        LD	HL,D6690
        ADD	A,(HL)
        POP	HL
        PUSH	AF
J4826:	POP	AF
        JP	J6699

;	  Subroutine __________________________
;	     Inputs  ________________________
;	     Outputs ________________________

C482A:	CALL	C5389			; get current slotid page 1
        CALL	C4878			; slotid
        LD	A,LOW A4010
        CALL	C4878
        LD	A,HIGH A4010
        CALL	C4878
        RET
J483B:	LD	IX,M6E6B
        JR	J4875
J4841:	LD	IX,M6E80
        JR	J4875

C4847:	LD	IX,M6E86
        JR	J4875
J484D:	LD	IX,M6E6E
        JR	J4875
J4853:	LD	IX,M6E77
        JR	J4875
J4859:	LD	IX,M481C
        JR	J4875
J485F:	LD	IX,M4055
        JR	J4875

J4865:	LD	IX,M475A
        JR	J4875
J486B:	LD	IX,M406D
        JR	J4875
J4871:	LD	IX,M73B2
J4875:	JP	C494A

;	  Subroutine __________________________
;	     Inputs  ________________________
;	     Outputs ________________________

C4878:	PUSH	AF
        PUSH	BC
        PUSH	DE
        PUSH	IX
        LD	E,A
        LD	A,B
        LD	IX,WRSLT
        CALL	C494F
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

C488E:	PUSH	BC
        PUSH	DE
        PUSH	IX
        LD	A,B
        LD	IX,RDSLT
        CALL	C494F
        EI
        INC	HL
        POP	IX
        POP	DE
        POP	BC
        RET

;	  Subroutine __________________________
;	     Inputs  ________________________
;	     Outputs ________________________

C48A1:	PUSH	IX
        LD	IX,BREAKX
        CALL	C494F
        POP	IX
        RET

;	  Subroutine __________________________
;	     Inputs  ________________________
;	     Outputs ________________________

C48AD:	PUSH	BC
        LD	B,A
        LD	A,(D66AA)
        OR	A
        JR	Z,J48D3
        LD	A,B
        CP	20H	; " "
        JR	NC,J48D3
        LD	A,5EH	; "^"
        CALL	C48D5
        LD	A,B
        ADD	A,40H	; "@"
        CALL	C48D5
        LD	A,B
        CP	0AH	; 10 
        POP	BC
        RET	NZ
        LD	A,0DH	; 13 
        CALL	C48D5
        LD	A,0AH	; 10 
        JR	C48D5
J48D3:	LD	A,B
        POP	BC

;	  Subroutine __________________________
;	     Inputs  ________________________
;	     Outputs ________________________

C48D5:	PUSH	AF
        CALL	CHPUT
        EI
        LD	A,(D66AC)
        OR	A
        JR	Z,J48E6
        POP	AF
        PUSH	AF
        CALL	LPTOUT
        EI
J48E6:	POP	AF
        RET

;	  Subroutine __________________________
;	     Inputs  ________________________
;	     Outputs ________________________

C48E8:	LD	A,(HL)
        EX	(SP),HL
        CP	(HL)
        JP	NZ,J485F
        INC	HL
        EX	(SP),HL

;	  Subroutine __________________________
;	     Inputs  ________________________
;	     Outputs ________________________

C48F0:	PUSH	IX
        LD	IX,M4666
        EXX
        PUSH	HL
        EXX
        CALL	C494A
        EXX
        POP	HL
        EXX
        POP	IX
        RET

;	  Subroutine __________________________
;	     Inputs  ________________________
;	     Outputs ________________________

C4902:	PUSH	IX
        LD	IX,M4C64
        CALL	C494A
        POP	IX
        RET

;	  Subroutine __________________________
;	     Inputs  ________________________
;	     Outputs ________________________

C490E:	PUSH	IX
        LD	IX,M542F
        CALL	C494A
        POP	IX
        RET

;	  Subroutine __________________________
;	     Inputs  ________________________
;	     Outputs ________________________

C491A:	PUSH	IX
        LD	IX,M521C
        CALL	C494A
        POP	IX
        RET

;	  Subroutine __________________________
;	     Inputs  ________________________
;	     Outputs ________________________

C4926:	PUSH	IX
        LD	IX,M5EA4
        CALL	C494A
        POP	IX
        RET

;	  Subroutine __________________________
;	     Inputs  ________________________
;	     Outputs ________________________

C4932:	PUSH	IX
        LD	IX,M67D0
        CALL	C494A
        POP	IX
        RET

;	  Subroutine __________________________
;	     Inputs  ________________________
;	     Outputs ________________________

C493E:	PUSH	IX
        LD	IX,M517A
        CALL	C494A
        POP	IX
        RET

;	  Subroutine __________________________
;	     Inputs  ________________________
;	     Outputs ________________________

C494A:	CALL	C494F
        EI
        RET

;	  Subroutine __________________________
;	     Inputs  ________________________
;	     Outputs ________________________

C494F:	PUSH	IY
        LD	IY,(EXPTBL+0-1)
        CALL	CALSLT
        POP	IY
        RET

C495B:	EI
        CALL	C53C7
        CALL	C5161
        DI
        LD	(D6678),SP
        LD	SP,I67FC
        PUSH	BC
        PUSH	HL
        CALL	C53A8
        PUSH	AF
        CALL	C5447
        POP	AF
        POP	HL
        POP	BC
        PUSH	AF
        CALL	C5507
        LD	A,(IX+12)
        LD	(D6684),A
        EXX
        LD	(D667A),HL
        EXX
        CALL	C549F
        LD	SP,(D6678)
        PUSH	BC
        PUSH	DE
        PUSH	HL
        LD	BC,13
        LD	HL,I431B
        LD	DE,I66AE
        PUSH	DE
        POP	IY
        LDIR
        POP	HL
        POP	DE
        POP	BC
        EXX
        LD	HL,(D667A)
        EXX
        LD	A,B
        AND	C
        INC	A
        JR	NZ,J49BF
        LD	A,D
        OR	A
        JP	Z,J4A9C
        CP	3AH	; ":"
        JP	Z,J4A9C
        CP	29H	; ")"
        JP	Z,J4A99
        CALL	C48E8
        INC	L
        JR	J49E6
J49BF:	PUSH	HL
        EXX
        PUSH	HL
        EXX
        POP	HL
        LD	A,B
        OR	A
        JR	Z,J49D8
        PUSH	IY
        POP	DE
J49CB:	LD	A,(HL)
        CP	20H	; " "
        JR	Z,J49D4
        CALL	C5229
        LD	(DE),A
J49D4:	INC	DE
        INC	HL
        DJNZ	J49CB
J49D8:	POP	HL
        DEC	HL
        CALL	C48F0
        CP	29H	; ")"
        JP	Z,J4A99
        CALL	C48E8
        INC	L
J49E6:	CP	2CH	; ","
        JR	Z,J4A38
        CALL	C490E
        DI
        LD	(D6678),SP
        LD	SP,I67FC
        PUSH	BC
        PUSH	HL
        CALL	C53A8
        PUSH	AF
        CALL	C5447
        POP	AF
        POP	HL
        POP	BC
        PUSH	AF
        LD	(IY+8),E
        LD	(IY+9),D
        CALL	C549F
        LD	SP,(D6678)
        LD	A,(HL)
        CP	29H	; ")"
        JR	NZ,J4A38
        DI
        LD	(D6678),SP
        LD	SP,I67FC
        PUSH	BC
        PUSH	HL
        CALL	C53A8
        PUSH	AF
        CALL	C5447
        POP	AF
        POP	HL
        POP	BC
        PUSH	AF
        LD	(IY+10),E
        LD	(IY+11),D
        CALL	C549F
        LD	SP,(D6678)
        JR	J4A99
J4A38:	CALL	C48E8
        INC	L
        CP	2CH	; ","
        JR	Z,J4A6A
        CALL	C490E
        DI
        LD	(D6678),SP
        LD	SP,I67FC
        PUSH	BC
        PUSH	HL
        CALL	C53A8
        PUSH	AF
        CALL	C5447
        POP	AF
        POP	HL
        POP	BC
        PUSH	AF
        LD	(IY+10),E
        LD	(IY+11),D
        CALL	C549F
        LD	SP,(D6678)
        LD	A,(HL)
        CP	29H	; ")"
        JR	Z,J4A99
J4A6A:	CALL	C48E8
        INC	L
        CP	29H	; ")"
        JR	Z,J4A99
        CALL	C491A
        DI
        LD	(D6678),SP
        LD	SP,I67FC
        PUSH	BC
        PUSH	HL
        CALL	C53A8
        PUSH	AF
        CALL	C5447
        POP	AF
        POP	HL
        POP	BC
        PUSH	AF
        LD	(IY+12),E
        CALL	C549F
        LD	SP,(D6678)
        CALL	C48E8
        ADD	HL,HL
        DEC	HL
J4A99:	CALL	C48F0
J4A9C:	DI
        LD	(D6678),SP
        LD	SP,I67FC
        PUSH	BC
        PUSH	HL
        CALL	C53A8
        PUSH	AF
        CALL	C5447
        POP	AF
        POP	HL
        POP	BC
        PUSH	AF
        CALL	C5232
        CALL	C549F
        LD	SP,(D6678)
        JP	C,J4865
        DI
        LD	(D6678),SP
        LD	SP,I67FC
        PUSH	BC
        PUSH	HL
        CALL	C53A8
        PUSH	AF
        CALL	C5447
        POP	AF
        POP	HL
        POP	BC
        PUSH	AF
        PUSH	HL
        LD	HL,I664B
        LD	A,(D6687)
        ADD	A,L
        LD	L,A
        LD	A,(HL)
        POP	HL
        OR	A
        CALL	NZ,C5500
        LD	A,(D6684)
        BIT	5,A
        CALL	NZ,C5965
        CALL	C549F
        LD	SP,(D6678)
        EI
        OR	A
        RET

;	  Subroutine __________________________
;	     Inputs  ________________________
;	     Outputs ________________________

C4AF4:	EI
        CALL	C53C7
        CALL	C5161
        CALL	C51E6
        CALL	C48E8
        INC	L
        PUSH	HL
        LD	HL,I664B
        LD	A,(D6687)
        ADD	A,L
        LD	L,A
        LD	A,(HL)
        POP	HL
        OR	A
        JP	Z,J4853
        CALL	C490E
        CALL	C48E8
        ADD	HL,HL
        LD	A,D
        OR	E
        CALL	C597D
        EI
        RET

;	  Subroutine __________________________
;	     Inputs  ________________________
;	     Outputs ________________________

C4B1F:	EI
        CALL	C53C7
        CALL	C5161
        CALL	C51E6
        CALL	C48E8
        INC	L
        PUSH	HL
        LD	HL,I664B
        LD	A,(D6687)
        ADD	A,L
        LD	L,A
        LD	A,(HL)
        POP	HL
        OR	A
        JP	Z,J4853
        CALL	C4926
        PUSH	HL
        CALL	C59C1
        LD	(DAC+2),HL
        POP	HL
        CALL	C51F0
        CALL	C48E8
        ADD	HL,HL
        OR	A
        EI
        RET

;	  Subroutine __________________________
;	     Inputs  ________________________
;	     Outputs ________________________

C4B51:	EI
        CALL	C53C7
        CALL	C5161
        CALL	C51E6
        PUSH	HL
        LD	HL,I664B
        LD	A,(D6687)
        ADD	A,L
        LD	L,A
        LD	A,(HL)
        POP	HL
        OR	A
        JP	Z,J4853
        LD	A,D
        CP	2CH	; ","
        JR	Z,J4B7F
        OR	A
        JR	Z,J4B7A
        CP	3AH	; ":"
        JR	Z,J4B7A
        CALL	C48E8
        ADD	HL,HL
J4B7A:	LD	DE,10
        JR	J4B89
J4B7F:	CALL	C48F0
        CALL	C490E
        CALL	C48E8
        ADD	HL,HL
J4B89:	PUSH	HL
        LD	HL,2
        OR	A
        SBC	HL,DE
        JP	NC,J4865
        CALL	C5903
        POP	HL
        EI
        LD	A,00H
        INC	A
        CALL	C58AA
        JP	C,J4871
        OR	A
        RET

;	  Subroutine __________________________
;	     Inputs  ________________________
;	     Outputs ________________________

C4BA3:	EI
        CALL	C53C7
        CALL	C5161
        CALL	C51E6
        LD	A,D
        OR	A
        JR	Z,J4BB9
        CP	3AH	; ":"
        JR	Z,J4BB9
        CALL	C48E8
        ADD	HL,HL
J4BB9:	LD	(D6685),HL
        XOR	A
        LD	(D66A8),A
        LD	(D66AC),A
        LD	(D66AA),A
        LD	(D66AB),A
        LD	HL,FNKSTR+5*16
        LD	DE,I66BB
        LD	BC,3*16
        PUSH	BC
        PUSH	HL
        LDIR
        POP	HL
        POP	BC
        LD	B,C
        PUSH	HL
J4BDA:	LD	(HL),00H
        INC	HL
        DJNZ	J4BDA
        POP	DE
        LD	HL,I4DC0
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
        LD	A,(CSRSW)
        LD	(D66AD),A
        CALL	C4DDC
        LD	E,04H	; 4 
        CALL	C44B9
        JP	C,J484D
J4C09:	EI
        CALL	C4622
        EI
        LD	A,L
        OR	H
        JR	Z,J4C34
        CALL	C552A
        EI
        JR	C,J4C60
        LD	C,A
        JP	M,J4C2F
        LD	HL,D66A8
        LD	A,(HL)
        CP	02H	; 2 
        LD	A,C
        JR	NZ,J4C29
        LD	(HL),00H
        JR	J4C90
J4C29:	CP	1BH
        JR	NZ,J4C2F
        INC	(HL)
        DEFB	001H
J4C2F:	LD	(HL),0
        CALL	C48AD
J4C34:	CALL	C4DFD
        CALL	NZ,C4DD4
        CALL	C48A1
        JR	C,J4C60
        CALL	CHSNS
        EI
        JR	Z,J4C09
        CALL	CHGET
        EI
        CP	0A0H
        JP	Z,J4D9F
        CALL	C4DCF
        LD	C,A
        LD	A,(D66AB)
        OR	A
        JP	Z,J4C09
        LD	A,C
        CALL	C48AD
        JP	J4C09
J4C60:	CALL	C4525
        XOR	A
        LD	(D66A8),A
        LD	(D66AC),A
        LD	(D66AA),A
        LD	(D66AB),A
        LD	HL,I66BB
        LD	DE,FNKSTR+5*16
        LD	BC,3*16
        LDIR
        LD	HL,(D6685)
        LD	A,(D66AD)
        OR	A
        PUSH	AF
        CALL	Z,C4DEB
        POP	AF
        CALL	NZ,C4DDC
        XOR	A
        DI
        LD	(INTFLG),A
        RET
J4C90:	LD	A,(D66AA)
        OR	A
        JP	NZ,J4C09
        CALL	C4DEB
        LD	A,0FFH
        LD	(D66A9),A
J4C9F:	CALL	C552A
        EI
        JP	C,J4C60
        CP	3AH	; ":"
        JR	NZ,J4C9F
        CALL	C4D6D
        JP	C,J4D23
        OR	A
        JR	Z,J4CFA
        LD	B,A
        LD	E,A
        CALL	C4D62
        JP	C,J4D23
        CALL	C4D6D
        JP	C,J4D23
        ADD	A,L
        ADD	A,H
        ADD	A,E
        LD	E,A
J4CC5:	CALL	C4D6D
        JR	C,J4D23
        LD	(HL),A
        ADD	A,E
        LD	E,A
        INC	HL
        DJNZ	J4CC5
        CALL	C4D6D
        JR	C,J4D23
        ADD	A,E
        JR	NZ,J4D23
        LD	A,47H	; "G"
        CALL	C4DCF
        LD	A,(D66A9)
        OR	A
        JR	Z,J4CEE
        INC	A
        LD	(D66A9),A
        LD	A,2AH	; "*"
        CALL	C48AD
        JR	J4CF7
J4CEE:	DEC	A
        LD	(D66A9),A
        LD	A,7FH
        CALL	C48AD
J4CF7:	JP	J4C9F
J4CFA:	CALL	C4D62
        JR	C,J4D23
        LD	A,H
        OR	L
        JR	NZ,J4D2B
        CALL	C4D6D
        JR	C,J4D23
        CP	01H	; 1 
        JR	NZ,J4D23
        CALL	C4D6D
        JR	C,J4D23
        CP	0FFH
        JR	NZ,J4D23
J4D15:	LD	A,47H	; "G"
        CALL	C4DCF
        CALL	C4DF4
        CALL	C4DDC
        JP	J4C09
J4D23:	LD	A,42H	; "B"
        CALL	C4DCF
        JP	J4C9F
J4D2B:	CALL	C4D6D
        JR	C,J4D23
        CP	01H	; 1 
        JR	NZ,J4D23
        ADD	A,L
        ADD	A,H
        LD	E,A
        CALL	C4D6D
        JR	C,J4D23
        ADD	A,E
        JR	NZ,J4D23
        CALL	C552A
        EI
        JP	C,J4C60
        CP	0AH	; 10 
        JR	NZ,J4D15
        LD	A,47H	; "G"
        CALL	C4DCF
        CALL	C4DF4
        PUSH	IX
        PUSH	HL
        LD	HL,I4D5A
        EX	(SP),HL
        JP	(HL)
I4D5A:	POP	IX
        CALL	C4DDC
        JP	J4C09

;	  Subroutine __________________________
;	     Inputs  ________________________
;	     Outputs ________________________

C4D62:	CALL	C4D6D
        RET	C
        LD	H,A
        CALL	C4D6D
        RET	C
        LD	L,A
        RET

;	  Subroutine __________________________
;	     Inputs  ________________________
;	     Outputs ________________________

C4D6D:	PUSH	BC
        CALL	C552A
        JR	C,J4D88
        CALL	C4D8A
        JR	C,J4D88
        ADD	A,A
        ADD	A,A
        ADD	A,A
        ADD	A,A
        LD	B,A
        CALL	C552A
        JR	C,J4D88
        CALL	C4D8A
        JR	C,J4D88
        ADD	A,B
J4D88:	POP	BC
        RET

;	  Subroutine __________________________
;	     Inputs  ________________________
;	     Outputs ________________________

C4D8A:	CALL	C5229
        SUB	30H	; "0"
        RET	C
        CP	0AH	; 10 
        JR	C,J4D9D
        SUB	11H	; 17 
        RET	C
        CP	06H	; 6 
        CCF
        RET	C
        ADD	A,0AH	; 10 
J4D9D:	OR	A
        RET

J4D9F:	CALL	CHGET
        EI
        SUB	06H	; 6 
        JR	Z,J4DB2
        DEC	A
        JR	Z,J4DB7
        DEC	A
        JR	NZ,J4DBD
        LD	HL,D66AC
        JR	J4DBA
J4DB2:	LD	HL,D66AA
        JR	J4DBA
J4DB7:	LD	HL,D66AB
J4DBA:	LD	A,(HL)
        CPL
        LD	(HL),A
J4DBD:	JP	J4C09
I4DC0:	AND	B
        LD	B,00H
        LD	L,H
        LD	L,C
        AND	B
        RLCA
        NOP
        LD	L,B
        LD	H,(HL)
        AND	B
        EX	AF,AF'
        NOP
        LD	(HL),B
        LD	H,L

;	  Subroutine __________________________
;	     Inputs  ________________________
;	     Outputs ________________________

C4DCF:	CALL	C56E7
        EI
        RET

;	  Subroutine __________________________
;	     Inputs  ________________________
;	     Outputs ________________________

C4DD4:	LD	DE,100
        CALL	C5903
        EI
        RET

;	  Subroutine __________________________
;	     Inputs  ________________________
;	     Outputs ________________________

C4DDC:	LD	A,1BH
        CALL	C48AD
        LD	A,79H	; "y"
J4DE3:	CALL	C48AD
        LD	A,35H	; "5"
J4DE8:	JP	C48AD

;	  Subroutine __________________________
;	     Inputs  ________________________
;	     Outputs ________________________

C4DEB:	LD	A,1BH
        CALL	C48AD
        LD	A,78H	; "x"
        JR	J4DE3

;	  Subroutine __________________________
;	     Inputs  ________________________
;	     Outputs ________________________

C4DF4:	LD	A,0DH	; 13 
        CALL	C48AD
        LD	A,0AH	; 10 
        JR	J4DE8

;	  Subroutine __________________________
;	     Inputs  ________________________
;	     Outputs ________________________

C4DFD:	LD	A,(INTFLG)
        OR	A
        RET	Z
        XOR	A
        LD	(INTFLG),A
        INC	A
        RET

;	  Subroutine __________________________
;	     Inputs  ________________________
;	     Outputs ________________________

C4E08:	EI
        CALL	C53C7
        CALL	C5161
        CALL	C51E6
        LD	A,D
        OR	A
        JR	Z,J4E1E
        CP	3AH	; ":"
        JR	Z,J4E1E
        CALL	C48E8
        ADD	HL,HL
J4E1E:	XOR	A
        LD	(D66AA),A
        LD	(D66AC),A
        LD	(D66AB),A
        PUSH	HL
        CALL	C4DF4
        LD	HL,I4E65
J4E2F:	LD	A,(HL)
        INC	HL
        INC	A
        JR	Z,J4E62
        DEC	A
        JR	Z,J4E44
        CALL	C48AD
        LD	A,(INTFLG)
        OR	A
        JR	Z,J4E2F
        CP	03H	; 3 
        JR	Z,J4E62
J4E44:	PUSH	HL
        LD	HL,INTFLG
        LD	(HL),00H
        CALL	C4DDC
J4E4D:	EI
        LD	A,(HL)
        OR	A
        JR	Z,J4E4D
        PUSH	AF
        CALL	C4DEB
        POP	AF
        POP	HL
        CP	03H	; 3 
        JR	Z,J4E62
        XOR	A
        LD	(INTFLG),A
        JR	J4E2F
J4E62:	POP	HL
        OR	A
        RET

I4E65:	DEFB    "Initialize statement options",13,10
        DEFB    13,10
        DEFB    'CALL COMINI ("',13,10
        DEFB    "<device# {0,1,2,3}>:",13,10
        DEFB    "<character length {5,6,7,8}>",13,10
        DEFB    "<parity {E,O,I,N}>",13,10
        DEFB    "<stop bits {1,2,3}>",13,10
        DEFB    "<XON/XOFF {X,N}>",13,10
        DEFB    "<CTS hand-shake {H,N}>",13,10
        DEFB    "<auto LF on receive {A,N}>",13,10
        DEFB    "<auto LF on transmit {A,N}>",13,10
        DEFB    '<SI/SO {S,N}>"',13,10
        DEFB    ",<receiver baud rate>",13,10
        DEFB    ",<transmitter baud rate>",13,10
        DEFB    ",<time out count>",13,10
        DEFB    "                          )",13,10
        DEFB    "Default:",13,10
        DEFB    ' CALL COMINI("0:8N1XHNNN"',13,10
        DEFB    "      ,1200,1200,0)",13,10
        DEFB    0FFH

;	  Subroutine __________________________
;	     Inputs  ________________________
;	     Outputs ________________________

C5001:	EI
J5002:	CALL	C53C7
J5005:	CALL	C5161
        CALL	C51E6
        CALL	C48E8
        INC	L
J500F:	CALL	C48E8
        ADC	A,L
        LD	IX,M4769
        CALL	C494A
J501A:	PUSH	HL
        LD	A,E
        OR	D
        JR	Z,J502B
        LD	IX,M4295
J5023:	CALL	C494A
        JP	NC,J4859
        LD	E,C
        LD	D,B
J502B:	POP	HL
        PUSH	DE
        DEC	HL
        CALL	C48F0
        JR	Z,J5037
        CALL	C48E8
        ADD	HL,HL
J5037:	POP	DE
        PUSH	HL
        DI
        LD	A,(D6687)
        CALL	C5141
        JP	C,J4865
        INC	HL
        LD	(HL),E
        INC	HL
        LD	(HL),D
        CALL	C4297
        EI
        POP	HL
        OR	A
        RET

;	  Subroutine __________________________
;	     Inputs  ________________________
;	     Outputs ________________________

C504E:	EI
        CALL	C53C7
        CALL	C5161
        CALL	C51E6
        DEC	HL
        CALL	C48F0
        JR	Z,J5062
        CALL	C48E8
        ADD	HL,HL
J5062:	LD	IX,M632B
        JR	J50CF

;	  Subroutine __________________________
;	     Inputs  ________________________
;	     Outputs ________________________

C5068:	EI
        CALL	C53C7
        CALL	C5161
        CALL	C51E6
        DEC	HL
        CALL	C48F0
        JR	Z,J507C
        CALL	C48E8
        ADD	HL,HL
J507C:	LD	IX,M631B
        JR	J509A

;	  Subroutine __________________________
;	     Inputs  ________________________
;	     Outputs ________________________

C5082:	EI
        CALL	C53C7
        CALL	C5161
        CALL	C51E6
        DEC	HL
        CALL	C48F0
        JR	Z,J5096
        CALL	C48E8
        ADD	HL,HL
J5096:	LD	IX,M6331
J509A:	PUSH	HL
        DI
        LD	A,(D6687)
        CALL	C5141
        JP	C,J4865
        LD	A,(HL)
        AND	01H	; 1 
        JR	NZ,J50CD
        PUSH	IX
        DI
        LD	(D6678),SP
        LD	SP,I67FC
        PUSH	BC
        PUSH	HL
        CALL	C53A8
        PUSH	AF
        CALL	C5447
        POP	AF
        POP	HL
        POP	BC
        PUSH	AF
        CALL	C42FA
        CALL	C549F
        LD	SP,(D6678)
        POP	IX
J50CD:	EI
        POP	HL
J50CF:	PUSH	HL
        DI
        LD	A,(D6687)
        CALL	C5141
        JP	C,J4865
        CALL	C494A
        CALL	C4297
        EI
        POP	HL
        OR	A
        RET

;	  Subroutine __________________________
;	     Inputs  ________________________
;	     Outputs ________________________

I50E4:	EI
        LD	A,(D661E)
        INC	A
        JP	Z,X669E
        PUSH	BC
        PUSH	DE
        PUSH	HL
        DI
        LD	(D6678),SP
        LD	SP,I67FC
        CALL	C53A8
        PUSH	AF
        LD	A,(D6691)
        LD	D,A
        LD	E,00H
J5101:	LD	A,D
        LD	HL,I664B
        ADD	A,L
        LD	L,A
        LD	A,(HL)
        OR	A
        JR	Z,J5116
        LD	A,D
        CALL	C544A
        CALL	C551A
        LD	A,D
        CALL	NZ,C512B
J5116:	INC	D
        INC	E
        LD	A,(D6690)
        CP	E
        JR	NZ,J5101
        CALL	C549F
        LD	SP,(D6678)
        POP	HL
        POP	DE
        POP	BC
        JP	X669E

;	  Subroutine __________________________
;	     Inputs  ________________________
;	     Outputs ________________________

C512B:	CALL	C5141
        RET	C
        LD	A,(HL)
        AND	01H	; 1 
        RET	Z
        LD	A,(HL)
        OR	04H	; 4 
        CP	(HL)
        RET	Z
        CP	05H	; 5 
        RET	NZ
        LD	(HL),A
        LD	HL,ONGSBF
        INC	(HL)
        RET

;	  Subroutine __________________________
;	     Inputs  ________________________
;	     Outputs ________________________

C5141:	CALL	C5153
        RET	C
        PUSH	BC
        LD	C,A
        ADD	A,A
        ADD	A,C
        LD	C,A
        LD	B,00H
        LD	HL,TRPTBL+18*3
        ADD	HL,BC
        POP	BC
        OR	A
        RET

;	  Subroutine __________________________
;	     Inputs  ________________________
;	     Outputs ________________________

C5153:	PUSH	HL
        LD	HL,D6691
        SUB	(HL)
        LD	HL,D6692
        ADD	A,(HL)
        CP	06H	; 6 
        CCF
        POP	HL
        RET

;	  Subroutine __________________________
;	     Inputs  ________________________
;	     Outputs ________________________

C5161:	DEC	HL
        CALL	C48F0
        LD	D,A
        JR	NZ,J516F
J5168:	XOR	A
        LD	BC,-1
        PUSH	HL
        JR	J51AD
J516F:	CP	28H	; "("
        JP	Z,J517A
        CP	2CH	; ","
        JR	Z,J5168
        JR	J5182
J517A:	CALL	C48F0
        LD	D,A
        CP	2CH	; ","
        JR	Z,J5168
J5182:	CALL	C4902
        PUSH	HL
        CALL	C4932
        LD	C,00H
        LD	B,(HL)
        INC	HL
        LD	A,(HL)
        INC	HL
        LD	H,(HL)
        LD	L,A
        LD	A,B
        OR	A
        JR	Z,J51AD
        INC	HL
        LD	A,(HL)
        CP	3AH	; ":"
        JR	Z,J519F
        DEC	HL
        XOR	A
        JR	J51AD
J519F:	DEC	HL
        LD	A,(HL)
        SUB	30H	; "0"
        JR	C,J51C4
        CP	0AH	; 10 
        JR	NC,J51C4
        INC	HL
        INC	HL
        DEC	B
        DEC	B
J51AD:	LD	E,A
        PUSH	HL
        EXX
        POP	HL
        EXX
        POP	HL
        DEC	HL
        CALL	C48F0
        LD	D,A
        PUSH	BC
        CALL	C51C7
        POP	BC
        RET	NC
J51BE:	POP	HL
        LD	HL,(D6685)
        SCF
        RET
J51C4:	POP	HL
        JR	J51BE

;	  Subroutine RS232.SETCHN
;	     Inputs  ________________________
;	     Outputs ________________________

C51C7:	PUSH	DE
        CALL	C53C7
        POP	DE
        LD	A,(D66EB)
        CP	E
        SCF
        RET	Z
        LD	A,(D6690)
        LD	C,A
        LD	A,(D6691)
        LD	B,A
        ADD	A,C
        LD	C,A
        LD	A,E
        CP	B
        RET	C
        CP	C
        CCF
        RET	C
        LD	(D6687),A
        RET

;	  Subroutine __________________________
;	     Inputs  ________________________
;	     Outputs ________________________

C51E6:	LD	A,B
        OR	C
        RET	Z
        LD	A,B
        AND	C
        INC	A
        RET	Z
        JP	J4865

;	  Subroutine __________________________
;	     Inputs  ________________________
;	     Outputs ________________________

C51F0:	PUSH	HL
        LD	HL,VALTYP
        LD	A,(HL)
        CP	02H	; 2 
        JR	Z,J521E
        CP	04H	; 4 
        JR	Z,J520E
        CP	08H	; 8 
        JP	NZ,J486B
        LD	(HL),02H	; 2 
        PUSH	DE
        LD	A,08H	; 8 
        CALL	C493E
        LD	C,08H	; 8 
        JR	J5218
J520E:	LD	(HL),02H	; 2 
        PUSH	DE
        LD	A,04H	; 4 
        CALL	C493E
        LD	C,04H	; 4 
J5218:	POP	DE
        LD	HL,DAC+0
        JR	J5223
J521E:	LD	HL,DAC+2
        LD	C,02H	; 2 
J5223:	LD	B,00H
        LDIR
        POP	HL
        RET

;	  Subroutine __________________________
;	     Inputs  ________________________
;	     Outputs ________________________

C5229:	CP	61H	; "a"
        RET	C
        CP	7BH	; "{"
        RET	NC
        SUB	20H	; " "
        RET

;	  Subroutine __________________________
;	     Inputs  ________________________
;	     Outputs ________________________

C5232:	LD	A,(IY)
        SUB	35H	; "5"
        CP	04H	; 4 
        JR	NC,J5253
        LD	B,A
        LD	D,A
        CALL	C530A
        LD	A,(IY+1)
        CP	45H	; "E"
        JR	Z,J5255
        CP	4FH	; "O"
        JR	Z,J5257
        CP	49H	; "I"
        JR	Z,J525B
        CP	4EH	; "N"
        JR	Z,J5262
J5253:	SCF
        RET
J5255:	SET	3,B
J5257:	SET	2,B
        JR	J5262
J525B:	LD	A,B
        CP	03H	; 3 
        JP	Z,J5253
        INC	B
J5262:	RLC	B
        RLC	B
        LD	A,(IY+2)
        SUB	31H	; "1"
        CP	03H	; 3 
        JP	NC,J5253
        INC	A
        RRCA
        RRCA
        OR	B
        LD	B,A
        LD	C,00H
        LD	A,(IY+3)
        CP	58H	; "X"
        JR	NZ,J5282
        SET	0,C
        JR	J5287
J5282:	CP	4EH	; "N"
        JP	NZ,J5253
J5287:	LD	A,(IY+4)
        CP	48H	; "H"
        JR	NZ,J5292
        SET	1,C
        JR	J5297
J5292:	CP	4EH	; "N"
        JP	NZ,J5253
J5297:	LD	A,(IY+5)
        CP	41H	; "A"
        JR	NZ,J52A2
        SET	3,C
        JR	J52A7
J52A2:	CP	4EH	; "N"
        JP	NZ,J5253
J52A7:	LD	A,(IY+6)
        CP	41H	; "A"
        JR	NZ,J52B2
        SET	2,C
        JR	J52B7
J52B2:	CP	4EH	; "N"
        JP	NZ,J5253
J52B7:	LD	A,(IY+7)
        CP	53H	; "S"
        JR	NZ,J52C8
        LD	A,D
        CP	02H	; 2 
        JP	NZ,J5253
        SET	4,C
        JR	J52CD
J52C8:	CP	4EH	; "N"
        JP	NZ,J5253
J52CD:	LD	A,C
        LD	(IX+10),A
        LD	A,02H	; 2 
        OR	B
        LD	(IX+13),A
        PUSH	HL
        LD	HL,(D668B)
        CALL	C58DD
        LD	E,(IY+8)
        LD	D,(IY+9)
        CALL	C531E
        JR	C,J5308
        LD	C,00H
        CALL	C5A36
        LD	E,(IY+10)
        LD	D,(IY+11)
        CALL	C531E
        JR	C,J5308
        LD	C,01H	; 1 
        CALL	C5A36
        LD	A,(IY+12)
        LD	(IX+4),A
        CALL	C59A9
        OR	A
J5308:	POP	HL
        RET

;	  Subroutine __________________________
;	     Inputs  ________________________
;	     Outputs ________________________

C530A:	PUSH	AF
        PUSH	BC
        XOR	03H	; 3 
        LD	C,0FFH
        JR	Z,J5317
        LD	B,A
J5313:	SRL	C
        DJNZ	J5313
J5317:	LD	A,C
        LD	(IX+11),A
        POP	BC
        POP	AF
        RET

;	  Subroutine __________________________
;	     Inputs  ________________________
;	     Outputs ________________________

C531E:	PUSH	HL
        BIT	7,D
        JR	Z,J5330
        LD	A,E
        AND	D
        INC	A
        JR	Z,J534C
        LD	HL,0
        SBC	HL,DE
        EX	DE,HL
        JR	J534B

J5330:	LD	HL,I534F
J5333:	LD	C,(HL)
        INC	HL
        LD	B,(HL)
        INC	HL
        LD	A,B
        OR	C
        JR	Z,J534C
        PUSH	HL
        LD	L,E
        LD	H,D
        OR	A
        SBC	HL,BC
        POP	HL
        JR	Z,J5348
        INC	HL
        INC	HL
        JR	J5333
J5348:	LD	E,(HL)
        INC	HL
        LD	D,(HL)
J534B:	SCF
J534C:	CCF
        POP	HL
        RET

I534F:	DEFW       50,00900h
        DEFW       75,00600h
        DEFW      110,00417h
        DEFW      300,00180h
        DEFW      600,000C0h
        DEFW     1200,00060h
        DEFW     1800,00040h
        DEFW     2000,0003Ah
        DEFW     2400,00030h
        DEFW     3600,00020h
        DEFW     4800,00018h
        DEFW     7200,00010h
        DEFW     9600,0000Ch
        DEFW    19200,00006h
        DEFW    0

;	  Subroutine __________________________
;	     Inputs  ________________________
;	     Outputs ________________________

C5389:	PUSH	BC
        PUSH	HL
        IN	A,(0A8H)
        RRCA
        RRCA
        AND	03H	; 3 
        LD	C,A
        LD	B,00H
        LD	HL,EXPTBL
        ADD	HL,BC
        LD	A,(HL)
J5399:	AND	80H
        OR	C
        LD	C,A
        INC	HL
        INC	HL
        INC	HL
        INC	HL
        LD	A,(HL)
        AND	0CH	; 12 
        OR	C
        POP	HL
        POP	BC
        RET

;	  Subroutine __________________________
;	     Inputs  ________________________
;	     Outputs ________________________

C53A8:	IN	A,(0A8H)
        RRCA
        RRCA
        RRCA
        RRCA
        AND	03H	; 3 
        LD	C,A
        LD	B,00H
        LD	HL,EXPTBL
        ADD	HL,BC
        LD	A,(HL)
        AND	80H
        OR	C
        LD	C,A
        INC	HL
        INC	HL
        INC	HL
        INC	HL
        LD	A,(HL)
        RRCA
        RRCA
        AND	0CH	; 12 
        OR	C
        RET

;	  Subroutine __________________________
;	     Inputs  ________________________
;	     Outputs ________________________

C53C7:	PUSH	HL
        LD	A,(D661E)
        INC	A
        JR	Z,J53E0
        LD	HL,I6600-2
J53D1:	INC	HL
        INC	HL
        LD	A,(HL)
        OR	A
        JR	NZ,J53D1
        LD	DE,(D6680)
        SBC	HL,DE
        POP	HL
        RET	Z
        PUSH	HL
J53E0:	LD	(D6690),A
        LD	HL,I6600
        LD	DE,D661E
J53E9:	LD	A,(HL)
        OR	A
        JR	Z,J5436
        CP	0FFH
        JR	NZ,J5405
        LD	(DE),A
        INC	DE
        LD	(DE),A
        INC	DE
        LD	(DE),A
        INC	DE
        INC	HL
        INC	HL
        LD	A,(D6690)
        LD	(D66EB),A
        INC	A
        LD	(D6690),A
        JR	J53E9
J5405:	AND	03H	; 3 
        ADD	A,A
        ADD	A,A
        ADD	A,A
        ADD	A,A
        LD	B,A
        LD	A,(HL)
        AND	8CH
        JP	P,J5415
        ADD	A,A
        ADD	A,A
        DEFB	0DAH
J5415:	LD	A,0FFH
        LD	C,A
        INC	HL
        LD	A,(HL)
        EX	DE,HL
J541B:	LD	(HL),B
        INC	HL
        LD	(HL),C
        INC	HL
        EX	DE,HL
        PUSH	AF
        SUB	(HL)

; BUGFIX

        NEG
;

        LD	(DE),A
        INC	DE
        LD	A,(D6690)
        INC	A
        LD	(D6690),A
        POP	AF
        EX	DE,HL
        DEC	A
        JR	NZ,J541B
        EX	DE,HL
        INC	HL
        JR	J53E9
J5436:	DEC	A
        LD	(DE),A
        LD	(D6680),HL
        LD	HL,D6690
        LD	A,(HL)
        CP	05H	; 5 
        JR	C,J5445
        LD	(HL),04H	; 4 
J5445:	POP	HL
        RET

;	  Subroutine __________________________
;	     Inputs  ________________________
;	     Outputs ________________________

C5447:	LD	A,(D6687)

;	  Subroutine __________________________
;	     Inputs  ________________________
;	     Outputs ________________________

C544A:	DI
        PUSH	DE
        LD	HL,D6691
        SUB	(HL)
        LD	HL,(D6695)
        JR	Z,J5458
        LD	HL,(D6697)
J5458:	LD	(D6693),HL
        LD	HL,D661E
        LD	C,A
        ADD	A,A
        ADD	A,C
        ADD	A,L
        LD	L,A
        LD	B,(HL)
        INC	HL
        LD	C,(HL)
        INC	HL
        LD	L,(HL)
        IN	A,(0A8H)
        AND	0CFH
        OR	B
        OUT	(0A8H),A
        BIT	7,C
        JP	NZ,J5499
        LD	D,A
        AND	3FH	; "?"
        LD	E,A
        LD	A,B
        RLCA
        RLCA
        OR	E
        OUT	(0A8H),A
        LD	A,(DFFFF)
        CPL
        AND	0CFH
        OR	C
        LD	(DFFFF),A
        LD	E,A
        LD	A,D
        OUT	(0A8H),A
        LD	A,B
        RLCA
        RLCA
        RLCA
        RLCA
        LD	D,L
        ADD	A,0C5H
        LD	L,A
        LD	H,0FCH
        LD	(HL),E
        LD	L,D
J5499:	LD	A,L
        CALL	C42BF
        POP	DE
        RET

;	  Subroutine __________________________
;	     Inputs  ________________________
;	     Outputs ________________________

C549F:	DI
        EXX
        POP	HL
        POP	BC
        PUSH	HL
        PUSH	AF
        LD	A,B
        AND	83H
        JP	M,J54BA
        ADD	A,A
        ADD	A,A
        ADD	A,A
        ADD	A,A
        LD	B,A
        IN	A,(0A8H)
        AND	0CFH
        OR	B
        OUT	(0A8H),A
        POP	AF
        EXX
        RET
J54BA:	LD	A,B
        AND	03H	; 3 
        ADD	A,0C5H
        LD	L,A
        LD	H,0FCH
        LD	A,B
        ADD	A,A
        ADD	A,A
        LD	E,A
        AND	0CH	; 12 
        ADD	A,A
        ADD	A,A
        LD	B,A
        LD	A,E
        AND	30H	; "0"
        LD	C,A
        LD	A,(HL)
        AND	30H	; "0"
        CP	C
        JR	NZ,J54DF
        IN	A,(0A8H)
        AND	0CFH
        OR	B
        OUT	(0A8H),A
        POP	AF
        EXX
        RET
J54DF:	IN	A,(0A8H)
        AND	0CFH
        OR	B
        LD	D,A
        AND	3FH	; "?"
        LD	E,A
        LD	A,B
        RLCA
        RLCA
        OR	E
        OUT	(0A8H),A
        LD	A,(DFFFF)
        CPL
        AND	0CFH
        OR	C
        LD	(DFFFF),A
        LD	E,A
        LD	A,D
        OUT	(0A8H),A
        LD	(HL),E
        POP	AF
        EXX
        RET

;	  Subroutine __________________________
;	     Inputs  ________________________
;	     Outputs ________________________

C5500:	PUSH	AF
        PUSH	HL
        LD	A,(D6693)
        JR	J550C

;	  Subroutine __________________________
;	     Inputs  ________________________
;	     Outputs ________________________

C5507:	PUSH	AF
        PUSH	HL
        LD	A,(D6694)
J550C:	LD	HL,(D668B)
        INC	HL
        LD	(HL),A
        POP	HL
        POP	AF
        RET
I5514:	CALL	C559D
        JP	X66A3

;	  Subroutine __________________________
;	     Inputs  ________________________
;	     Outputs ________________________

C551A:	LD	A,(IX+5)
        PUSH	BC
        LD	B,A
        LD	A,(IX+1)
        OR	A
        JR	Z,J5527
        LD	A,01H	; 1 
J5527:	ADD	A,B
        POP	BC
        RET

;	  Subroutine __________________________
;	     Inputs  ________________________
;	     Outputs ________________________

C552A:	PUSH	HL
        PUSH	DE
        PUSH	BC
J552D:	EI
        DEFB	0,0
        DI
        LD	(D6678),SP
        LD	SP,I67FC
        PUSH	BC
        PUSH	HL
        CALL	C53A8
        PUSH	AF
        CALL	C5447
        POP	AF
        POP	HL
        POP	BC
        PUSH	AF
        CALL	C48A1
        JR	C,J5595
        LD	HL,(D668B)
        LD	A,(IX+5)
        OR	A
        JR	NZ,J5566
        CALL	C5965
        CALL	C56A1
        JR	C,J5595
        JR	Z,J5595
        CALL	C549F
        LD	SP,(D6678)
        JR	J552D
J5566:	CP	03H	; 3 
        JR	NC,J5574
        CALL	C5965
        CALL	C56A1
        JR	C,J5595
        JR	Z,J5595
J5574:	DEC	(IX+5)
        CALL	C567F
        LD	C,(HL)
        LD	B,80H
        INC	HL
        LD	A,(HL)
        LD	(IX+8),A
        OR	A
        JR	Z,J5586
        INC	B
J5586:	LD	A,C
        OR	A
        DEC	B
J5589:	CALL	C549F
        LD	SP,(D6678)
        EI
        POP	BC
        POP	DE
        POP	HL
        RET
J5595:	PUSH	AF
        POP	BC
        RES	7,C
        PUSH	BC
        POP	AF
        JR	J5589

;	  Subroutine __________________________
;	     Inputs  ________________________
;	     Outputs ________________________

C559D:	LD	A,(D661E)
        INC	A
        RET	Z
        DI
        LD	(D6678),SP
        LD	SP,I67FC
        CALL	C53A8
        PUSH	AF
        LD	A,(D6691)
        LD	D,A
        LD	E,00H
J55B4:	LD	A,D
        LD	HL,I664B
        ADD	A,L
        LD	L,A
        LD	A,(HL)
        OR	A
        JR	Z,J55C7
        LD	A,D
        CALL	C544A
        LD	A,(HL)
        AND	02H	; 2 
        JR	NZ,J55D7
J55C7:	INC	D
        INC	E
        LD	A,(D6690)
        CP	E
        JR	NZ,J55B4
        CALL	C549F
        LD	SP,(D6678)
        RET
J55D7:	CALL	C55E2
        CALL	C549F
        LD	SP,(D6678)
        RET

;	  Subroutine __________________________
;	     Inputs  ________________________
;	     Outputs ________________________

C55E2:	DEC	HL
        LD	A,(HL)
        INC	HL
        AND	(IX+11)
        LD	C,A
        LD	A,(HL)
        AND	38H	; "8"
        JP	Z,J55F7
        PUSH	AF
        LD	A,(IX+12)
        OR	10H	; 16 
        LD	(HL),A
        POP	AF
J55F7:	LD	B,A
        OR	A
        JR	NZ,J5615
        LD	A,C
        CP	11H	; 17 
        JR	Z,J560A
        CP	13H	; 19 
        JR	NZ,J5625
        SET	2,(IX+9)
        JR	J560E
J560A:	RES	2,(IX+9)
J560E:	BIT	0,(IX+10)
        RET	NZ
        JR	J5625
J5615:	AND	20H	; " "
        JR	Z,J563D
        LD	A,C
        OR	A
        JR	NZ,J563D
        SET	4,(IX+9)
        LD	B,00H
        JR	J563D
J5625:	BIT	4,(IX+10)
        JR	Z,J563D
        LD	A,C
        SUB	0FH	; 15 
        JR	NZ,J5635
        RES	7,(IX+9)
        RET
J5635:	INC	A
        JR	NZ,J563D
        SET	7,(IX+9)
        RET
J563D:	LD	A,(IX+5)
        AND	A
        RET	M
        INC	(IX+5)
        CALL	C5690
        BIT	4,(IX+10)
        LD	A,C
        JR	Z,J565B
        CP	20H	; " "
        JR	C,J565B
        BIT	7,(IX+9)
        JR	Z,J565B
        OR	80H
J565B:	LD	(HL),A
        LD	A,(IX+5)
        AND	A
        JP	P,J5665
        SET	7,B
J5665:	CP	60H	; "`"
        CALL	NC,C56B7
        LD	A,B
        INC	HL
        LD	(HL),A
        OR	A
        RET	NZ
        LD	A,(IX+10)
        BIT	3,A
        RET	Z
        DEC	HL
        LD	A,(HL)
        CP	0DH	; 13 
        RET	NZ
        LD	BC,10
        JR	J563D

;	  Subroutine __________________________
;	     Inputs  ________________________
;	     Outputs ________________________

C567F:	LD	HL,(D668D)
        LD	A,(IX+6)
        ADD	A,A
        LD	L,A
        INC	(IX+6)
        RET	P
        LD	(IX+6),00H
        RET

;	  Subroutine __________________________
;	     Inputs  ________________________
;	     Outputs ________________________

C5690:	LD	HL,(D668D)
        LD	A,(IX+7)
        ADD	A,A
        LD	L,A
        INC	(IX+7)
        RET	P
        LD	(IX+7),00H
        RET

;	  Subroutine __________________________
;	     Inputs  ________________________
;	     Outputs ________________________

C56A1:	LD	A,(IX+9)
        BIT	1,A
        JR	NZ,J56AB
        XOR	A
        INC	A
        RET
J56AB:	LD	C,11H	; 17 
        CALL	C56CF
        RET	C
        RET	Z
        RES	1,(IX+9)
        RET

;	  Subroutine __________________________
;	     Inputs  ________________________
;	     Outputs ________________________

C56B7:	XOR	A
        INC	A
        LD	A,(IX+9)
        BIT	1,A
        RET	NZ
        SET	1,(IX+9)
        LD	C,13H	; 19 
        CALL	C56CF
        CALL	C5A09
        CALL	C596D
        RET

;	  Subroutine __________________________
;	     Inputs  ________________________
;	     Outputs ________________________

C56CF:	LD	A,(IX+10)
        BIT	0,A
        JR	NZ,J56D9
        XOR	A
        INC	A
        RET
J56D9:	CALL	C5A09
        LD	A,C
        PUSH	HL
        LD	HL,(D668B)
        DEC	HL
        LD	(HL),A
        POP	HL
        XOR	A
        INC	A
        RET

;	  Subroutine __________________________
;	     Inputs  ________________________
;	     Outputs ________________________

C56E7:	PUSH	BC
        LD	C,A
        CALL	C56EF
        LD	A,C
        POP	BC
        RET

;	  Subroutine __________________________
;	     Inputs  ________________________
;	     Outputs ________________________

C56EF:	PUSH	BC
        LD	C,A
        EI
        DEFB	0,0
        DI
        LD	(D6678),SP
        LD	SP,I67FC
        PUSH	BC
        PUSH	HL
        CALL	C53A8
        PUSH	AF
        CALL	C5447
        POP	AF
        POP	HL
        POP	BC
        PUSH	AF
        BIT	4,(IX+10)
        JR	Z,J5750
        LD	A,C
        CP	20H	; " "
        JR	C,J5750
        BIT	0,(IX+9)
        JR	NZ,J5735
        OR	A
        JP	P,J5750
        LD	(D667C),BC
        LD	C,0EH	; 14 
        CALL	C577C
        LD	BC,(D667C)
        JR	C,J576E
        JR	Z,J576E
        SET	0,(IX+9)
        JR	J574E
J5735:	OR	A
        JP	M,J574E
        LD	(D667C),BC
        LD	C,0FH	; 15 
        CALL	C577C
        LD	BC,(D667C)
        JR	C,J576E
        JR	Z,J576E
        RES	0,(IX+9)
J574E:	RES	7,C
J5750:	LD	A,C
        JR	J576B

?5753:	EI
        PUSH	BC
        LD	C,A
        DI
        LD	(D6678),SP
        LD	SP,I67FC
        PUSH	BC
        PUSH	HL
        CALL	C53A8
        PUSH	AF
        CALL	C5447
        POP	AF
        POP	HL
        POP	BC
        PUSH	AF
J576B:	CALL	C577C
J576E:	CALL	C58CC
        CALL	C549F
        LD	SP,(D6678)
        LD	A,C
        POP	BC
        EI
        RET

;	  Subroutine __________________________
;	     Inputs  ________________________
;	     Outputs ________________________

C577C:	BIT	2,(IX+10)
        JR	Z,J5792
        CP	0AH	; 10 
        JR	NZ,J5792
        BIT	5,(IX+9)
        JR	Z,J5792
        RES	5,(IX+9)
        OR	A
        RET
J5792:	BIT	0,(IX+10)
        JR	Z,J5810
        BIT	2,(IX+9)
        JR	Z,J5810
        LD	(D667A),HL
        POP	HL
        LD	(D667E),HL
        LD	A,(IX+4)
        LD	H,A
J57A9:	LD	L,64H	; "d"
J57AB:	CALL	C5A29
J57AE:	CALL	C549F
        LD	SP,(D6678)
        EI
        CALL	C48A1
        DI
        JR	NC,J57DA
        DI
        LD	(D6678),SP
        LD	SP,I67FC
        PUSH	BC
        PUSH	HL
        CALL	C53A8
        PUSH	AF
        CALL	C5447
        POP	AF
        POP	HL
        POP	BC
        PUSH	AF
        SCF
J57D2:	LD	HL,(D667E)
        PUSH	HL
        LD	HL,(D667A)
        RET
J57DA:	DI
        LD	(D6678),SP
        LD	SP,I67FC
        PUSH	BC
        PUSH	HL
        CALL	C53A8
        PUSH	AF
        CALL	C5447
        POP	AF
        POP	HL
        POP	BC
        PUSH	AF
        BIT	2,(IX+9)
        JR	Z,J5809
        LD	A,(IX+4)
        OR	A
        JR	Z,J57AE
        CALL	C5A1F
        JR	NC,J57AE
        OR	A
        DEC	L
        JR	NZ,J57AB
        DEC	H
        JR	NZ,J57A9
        JR	J57D2
J5809:	LD	HL,(D667E)
        PUSH	HL
        LD	HL,(D667A)
J5810:	CALL	C5A09
        BIT	1,(IX+10)
        JP	Z,J5891

; BUGFIX? (code removed)
;
;	PUSH	HL
;	LD	HL,(Y668B)	; memory mapped adres
;	INC	HL
;	LD	A,(HL)
;	POP	HL
;	BIT	7,A		; CTS ?
;	JR	Z,A589A		; yes, continue

        
        LD	(D667A),HL
        POP	HL
        LD	(D667E),HL
        LD	A,(IX+4)
        LD	H,A
J5825:	LD	L,64H	; "d"
J5827:	CALL	C5A29
J582A:	CALL	C549F
        LD	SP,(D6678)
        EI
        CALL	C48A1
        DI
        JR	NC,J5856
        DI
        LD	(D6678),SP
        LD	SP,I67FC
        PUSH	BC
        PUSH	HL
        CALL	C53A8
        PUSH	AF
        CALL	C5447
        POP	AF
        POP	HL
        POP	BC
        PUSH	AF
        SCF
J584E:	LD	HL,(D667E)
        PUSH	HL
        LD	HL,(D667A)
        RET
J5856:	DI
        LD	(D6678),SP
        LD	SP,I67FC
        PUSH	BC
        PUSH	HL
        CALL	C53A8
        PUSH	AF
        CALL	C5447
        POP	AF
        POP	HL
        POP	BC
        PUSH	AF
        PUSH	HL
        LD	HL,(D668B)
        INC	HL
        LD	A,(HL)
        POP	HL
        BIT	7,A
        JR	Z,J588A
        LD	A,(IX+4)
        OR	A
        JR	Z,J582A
        CALL	C5A1F
        JR	NC,J582A
        OR	A
        DEC	L
        JR	NZ,J5827
        DEC	H
        JR	NZ,J5825
        JR	J584E
J588A:	LD	HL,(D667E)
        PUSH	HL
        LD	HL,(D667A)
J5891:	LD	A,C
        PUSH	HL
        LD	HL,(D668B)
        DEC	HL
        LD	(HL),A
        POP	HL
        CP	0DH	; 13 
        JR	NZ,J58A3
        SET	5,(IX+9)
        JR	J58A7
J58A3:	RES	5,(IX+9)
J58A7:	XOR	A
        INC	A
        RET

;	  Subroutine __________________________
;	     Inputs  ________________________
;	     Outputs ________________________

C58AA:	EX	AF,AF'
        DI
        LD	(D6678),SP
        LD	SP,I67FC
        PUSH	BC
        PUSH	HL
        CALL	C53A8
        PUSH	AF
        CALL	C5447
        POP	AF
        POP	HL
        POP	BC
        PUSH	AF
        EX	AF,AF'
        CALL	C58CC
        CALL	C549F
        LD	SP,(D6678)
        RET

;	  Subroutine __________________________
;	     Inputs  ________________________
;	     Outputs ________________________

C58CC:	LD	(IX+8),00H
        JR	C,J58D8
        RET	NZ
        SET	6,(IX+8)
        RET
J58D8:	SET	2,(IX+8)
        RET

;	  Subroutine __________________________
;	     Inputs  ________________________
;	     Outputs ________________________

C58DD:	XOR	A
        LD	(HL),A
        PUSH	AF
        POP	AF
        LD	(HL),A
        PUSH	AF
        POP	AF
        LD	(HL),A
        PUSH	AF
        POP	AF
        LD	A,40H	; "@"
        LD	(HL),A
        PUSH	AF
        POP	AF
        LD	A,(IX+13)
        LD	(HL),A
        PUSH	AF
        POP	AF
        DEC	HL
        LD	A,(HL)
        INC	HL
        CALL	C5958
        LD	A,07H	; 7 
        CALL	C5A18
        DEC	HL
        LD	A,(HL)
        INC	HL
        JP	C5958

;	  Subroutine __________________________
;	     Inputs  ________________________
;	     Outputs ________________________

C5903:	PUSH	BC
        DI
        LD	(D6678),SP
        LD	SP,I67FC
        PUSH	BC
        PUSH	HL
        CALL	C53A8
        PUSH	AF
        CALL	C5447
        POP	AF
        POP	HL
        POP	BC
        PUSH	AF
        CALL	C5507
        LD	A,(IX+12)
        OR	08H	; 8 
        LD	B,A
J5922:	CALL	C48A1
        JR	C,J593C
        CALL	C5A09
        XOR	A
        PUSH	HL
        LD	HL,(D668B)
        DEC	HL
        LD	(HL),A
        INC	HL
        LD	A,B
        CALL	C5A18
        POP	HL
        DEC	DE
        LD	A,E
        OR	D
        JR	NZ,J5922
J593C:	PUSH	AF
        CALL	C5A09
        LD	A,B
        AND	0F7H
        PUSH	HL
        LD	HL,(D668B)
        CALL	C5A18
        POP	HL
        CALL	C5500
        POP	AF
        CALL	C549F
        LD	SP,(D6678)
        POP	BC
        RET

;	  Subroutine __________________________
;	     Inputs  ________________________
;	     Outputs ________________________

C5958:	LD	A,(HL)
        AND	38H	; "8"
        RET	Z
        PUSH	AF
        LD	A,(IX+12)
        OR	10H	; 16 
        LD	(HL),A
        POP	AF
        RET

;	  Subroutine __________________________
;	     Inputs  ________________________
;	     Outputs ________________________

C5965:	PUSH	AF
        LD	A,(IX+12)
        SET	5,A
        JR	J5973

;	  Subroutine __________________________
;	     Inputs  ________________________
;	     Outputs ________________________

C596D:	PUSH	AF
        LD	A,(IX+12)
        RES	5,A
J5973:	PUSH	HL
        LD	HL,(D668B)
        CALL	C5A18
        POP	HL
        POP	AF
        RET

;	  Subroutine __________________________
;	     Inputs  ________________________
;	     Outputs ________________________

C597D:	PUSH	AF
        LD	(D667C),A
        DI
        LD	(D6678),SP
        LD	SP,I67FC
        PUSH	BC
        PUSH	HL
        CALL	C53A8
        PUSH	AF
        CALL	C5447
        POP	AF
        POP	HL
        POP	BC
        PUSH	AF
        LD	A,(D667C)
        CALL	C59A6
        CALL	C549F
        LD	SP,(D6678)
        POP	AF
        EI
        RET

;	  Subroutine __________________________
;	     Inputs  ________________________
;	     Outputs ________________________

C59A6:	OR	A
        JR	Z,J59B1

;	  Subroutine __________________________
;	     Inputs  ________________________
;	     Outputs ________________________

C59A9:	PUSH	AF
        LD	A,(IX+12)
        OR	02H	; 2 
        JR	J59B7
J59B1:	PUSH	AF
        LD	A,(IX+12)
        AND	0FDH
J59B7:	PUSH	HL
        LD	HL,(D668B)
        CALL	C5A18
        POP	HL
        POP	AF
        RET

;	  Subroutine __________________________
;	     Inputs  ________________________
;	     Outputs ________________________

C59C1:	PUSH	AF
        PUSH	DE
        DI
        LD	(D6678),SP
        LD	SP,I67FC
        PUSH	BC
        PUSH	HL
        CALL	C53A8
        PUSH	AF
        CALL	C5447
        POP	AF
        POP	HL
        POP	BC
        PUSH	AF
        LD	HL,(D668B)
        INC	HL
        LD	A,(HL)
        LD	E,0C1H
        XOR	E
        AND	E
        LD	E,A
        DEC	HL
        LD	A,(HL)
        AND	80H
        JR	Z,J59EA
        SET	3,E
J59EA:	DI
        LD	A,(IX+9)
        BIT	4,A
        JR	Z,J59F9
        SET	2,E
        RES	4,A
        LD	(IX+9),A
J59F9:	LD	A,(IX+8)
        LD	H,A
        LD	L,E
        CALL	C549F
        LD	SP,(D6678)
        POP	DE
        POP	AF
        EI
        RET

;	  Subroutine __________________________
;	     Inputs  ________________________
;	     Outputs ________________________

C5A09:	PUSH	AF
        PUSH	HL
        LD	HL,(D668B)
J5A0E:	LD	A,(HL)
        AND	05H
        CP	05H
        JR	NZ,J5A0E
        POP	HL
        POP	AF
        RET

;	  Subroutine __________________________
;	     Inputs  ________________________
;	     Outputs ________________________

C5A18:	LD	(HL),A
        LD	(IX+12),A
        PUSH	AF
        POP	AF
        RET

;	  Subroutine __________________________
;	     Inputs  ________________________
;	     Outputs ________________________

C5A1F:	PUSH	HL
        LD	HL,(D668B)
        INC	HL
        LD	A,(HL)
        POP	HL
        RLCA
        RLCA
        RET

;	  Subroutine __________________________
;	     Inputs  ________________________
;	     Outputs ________________________

C5A29:	PUSH	AF
        PUSH	BC
        PUSH	DE
        PUSH	HL
        LD	B,30H
        LD	C,02H
        LD	DE,04800H
        JR	J5A3C

;	  Subroutine __________________________
;	     Inputs  ________________________
;	     Outputs ________________________

C5A36:	PUSH	AF
        PUSH	BC
        PUSH	DE
        PUSH	HL
        LD	B,36H
J5A3C:	LD	HL,(D668B)
        INC	HL
        INC	HL
        INC	HL
        PUSH	HL
        INC	HL
        INC	HL
        INC	HL
        EX	(SP),HL
        PUSH	BC
        LD	B,00H
        ADD	HL,BC
        POP	BC
        EX	(SP),HL
        LD	A,C
        RRCA
        RRCA
        OR	B
        LD	(HL),A
        POP	HL
        LD	(HL),E
        LD	(HL),D
        POP	HL
        POP	DE
        POP	BC
        POP	AF
        RET

        DEFS	06000H-$,0FFH

        END
