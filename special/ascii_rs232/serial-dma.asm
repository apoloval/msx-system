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
NULBUF	EQU	0F862H
PTRFIL	EQU	0F864H
FNKSTR	EQU	0F87FH
HOKVLD	EQU	0FB20H
ONGSBF	EQU	0FBD8H
TRPTBL	EQU	0FC4CH
INTFLG	EQU	0FC9BH
ESCCNT	EQU	0FCA7H
CSRSW	EQU	0FCA9H
EXPTBL	EQU	0FCC1H
PROCNM	EQU	0FD89H
H.TIMI	EQU	0FD9FH
H.NEWS  EQU     0FF3EH
EXTBIO  EQU     0FFCAH
DISINT	EQU	0FFCFH
ENAINT	EQU	0FFD4H


D6000	EQU	6000H
D6002	EQU	6002H
D6003	EQU	6003H
D6004	EQU	6004H
D6005	EQU	6005H
D6006	EQU	6006H
D6007	EQU	6007H
D6009	EQU	6009H
I6016	EQU	6016H
D660E	EQU	660EH                   ; timeout counter
D660F	EQU	660FH                   ; pointer to current FCB
D6611	EQU	6611H                   ; bufferlength current FCB
J6612	EQU	6612H                   ; old EXTBIO handler
J6617	EQU	6617H                   ; old H.NEWS handler
X661C	EQU	661CH                   ; old H.TIMI handler
D6621	EQU	6621H                   ; trapnumber (b7-b4), devicenumber (b3-b0)
D6622	EQU	6622H
D6623	EQU	6623H
D6625	EQU	6625H
D6626	EQU	6626H                   ; b7 = SO status (receive), b5 = CR transmitted (auto lf), b4 = break detected, b3 = channel open, b2 = XOFF received, b1 = XOFF status, b0 = SO status (send)
D6627	EQU	6627H                   ; b4 = use SI/SO control, b3 = Auto LF receive, b2 = Auto LF send, b1 = use RTS/CTS handshake, b0 = use XON/XOFF protocol
D6628	EQU	6628H
D6629	EQU	6629H
D662A	EQU	662AH
I6800	EQU	6800H			; transmit buffer ?
I7000	EQU	7000H			; receive buffer ?
D7800	EQU	7800H
D7802	EQU	7802H
I7803	EQU	7803H
D7804	EQU	7804H
D7806	EQU	7806H
I7808	EQU	7808H
D7809	EQU	7809H
I7FE0	EQU	7FE0H			; hardware port i8237 channel 0 base
I7FE6	EQU	7FE6H			; hardware port i8237 channel 3 base
D7FE8	EQU	7FE8H			; hardware port i8237 write command/read status
I7FEB	EQU	7FEBH			; hardware port i8237 write mode
D7FEC	EQU	7FECH			; hardware port i8237 clear byte pointer
D7FED	EQU	7FEDH			; hardware port i8237 master clear
D7FEF	EQU	7FEFH			; hardware port i8237 write all mask register bits
D7FF8	EQU	7FF8H			; hardware port i8251 data
D7FF9	EQU	7FF9H			; hardware port i8251 control
D7FFA	EQU	7FFAH			; hardware port status/interrupt mask
I7FFC	EQU	7FFCH			; hardware port i8253 channel 0
I7FFD	EQU	7FFDH			; hardware port i8253 channel 1
I7FFE	EQU	7FFEH			; hardware port i8253 channel 2
D7FFF	EQU	7FFFH			; hardware port i8253 write mode

        DEFB	"AB"
        DEFW	C40E1		; INIT
        DEFW	C41BB		; STATEMENT
        DEFW	C4257		; DEVICE
        DEFW	0		; no basic program
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

A4010:	DEFB	034H		; +00 MSX serial features (no TxReady INT, Sync detect, No Timer INT, Have CD, Have RI)
        DEFB	0		; +01 MSX serial version (version 1.0)
        DEFB	0		; +02 reserved
        JP	J4046		; +03 RS232.INIT
?4016:	JP	C42CB		; +06 RS232.OPEN
?4019:	JP	C52B1		; +09 RS232.STAT
?401C:	JP	C4341		; +0C RS232.GETCHR
?401F:	JP	C50A6		; +0F RS232.SNDCHR
?4022:	JP	C430C		; +12 RS232.CLOSE
?4025:	JP	J4070		; +15 RS232.EOF
?4028:	JP	C4393		; +18 RS232.LOC
?402B:	JP	C43BE		; +1B RS232.LOF
?402E:	JP	C43FB		; +1E RS232.BACKUP
?4031:	JP	C5231		; +21 RS232.SNDBRK
?4034:	JP	C5299		; +24 RS232.DTR
?4037:	RET			; +27 future entry point
        RET
        RET
?403A:	RET			; +2A future entry point
        RET
        RET
?403D:	RET			; +2D future entry point
        RET
        RET
?4040:	DEFB	"DMA"		; +30 RS232 with DMA signature ? no RS232 version 1 spec
        RET			; +33 future entry point ? no RS232 version 1 spec
        RET
        RET

;	  Subroutine RS232.INIT
;	     Inputs  ________________________
;	     Outputs ________________________

J4046:	EI
        PUSH	BC
        PUSH	DE
        PUSH	HL
        LD	IY,-13
        ADD	IY,SP
        LD	SP,IY
        PUSH	IY
        POP	DE                      ; allocate space for parameterblock on stack
        LD	C,13                    ; parameterblock is 13 bytes
J4057:	CALL	C$4547
        LD	(DE),A
        INC	DE
        DEC	C
        JR	NZ,J4057                ; copy parameterblock (RDSLT)
        CALL	C4C51                   ; initialize RS232 port
        PUSH	AF
        LD	IY,15
        ADD	IY,SP
        POP	AF
        LD	SP,IY                   ; remove space for parameterblock from stack
        POP	HL
        POP	DE
        POP	BC
        RET

;	  Subroutine RS232.EOF
;	     Inputs  ________________________
;	     Outputs ________________________

J4070:	LD	HL,0
        CALL	C4DDA
        RET	Z
        CALL	C43DB
        RET

;	  Subroutine __________________________
;	     Inputs  ________________________
;	     Outputs ________________________

C407B:	PUSH	HL
        PUSH	AF
        PUSH	BC
        PUSH	DE
        DI
        LD	(D7FED),A		; master clear i8237
        LD	A,10H
        LD	(D7FE8),A		; command i8237 (DACK active low, DREQ active low, Roatating priority, Normal timing, Controller enabled, Channel 0 address hold disabled, Memory-to-memory disable)
        LD	HL,I7FE0
        LD	BC,I7808
        LD	(HL),C
        LD	(HL),B			; set base channel 0 i8237
        INC	HL
        LD	(HL),LOW 0
        LD	(HL),HIGH 0		; set current word count channel 0 i8237
        INC	HL
        LD	BC,I7000
        LD	(HL),C
        LD	(HL),B			; set base channel 1 i8237
        INC	HL
        LD	DE,2048-1
        LD	(HL),E
        LD	(HL),D			; set current word count channel 1 i8237
        INC	HL
        LD	BC,D7802
        LD	(HL),C
        LD	(HL),B			; set base channel 2 i8237
        INC	HL
        LD	(HL),LOW 0
        LD	(HL),HIGH 0		; set current word count channel 2 i8237
        INC	HL
        LD	BC,I6800
        LD	(HL),C
        LD	(HL),B			; set base channel 3 i8237
        INC	HL
        LD	(HL),E
        LD	(HL),D			; set current word count channel 3 i8237
        LD	HL,I7FEB
        LD	A,50H
        LD	(HL),A			; write mode i8237 (single mode, address increment, autoinitialize, verify transfer, channel 0)
        LD	A,58H
        INC	A
        LD	(HL),A			; write mode i8237 (single mode, address increment, autoinitialize, read transfer, channel 1)
        INC	A
        INC	A
        LD	(HL),A			; write mode i8237 (single mode, address increment, autoinitialize, read transfer, channel 3)
        LD	A,54H
        OR	02H
        LD	(HL),A			; write mode i8237 (single mode, address increment, autoinitialize, write transfer, channel 2)
        EI
        POP	DE
        POP	BC
        LD	HL,I6800
        LD	(D7800),HL
        LD	(D7806),HL
        XOR	A
        LD	HL,D7802
        LD	(HL),A
        INC	HL
        LD	(HL),A
        INC	HL
        LD	(HL),A
        INC	HL
        LD	(HL),A
        POP	AF
        POP	HL
        RET

;
; CARTRIDGE INIT
;

C40E1:	LD	HL,D6000
        LD	(HL),00H
        LD	DE,D6000+1
        LD	BC,007FFH
        LDIR
        LD	A,6FH
        LD	(D7809),A
        LD	(D7FFA),A		; D7-D4 ??, mask i8253 channel 2 int, sync/break int, transmit data ready int, receive data ready int
        LD	IY,I41AE
        CALL	C4C51                   ; initialize RS232 port
        XOR	A
        LD	(X661C),A		; no H.TIMI handler already installed
        CALL	C407B                   ; initialize i8237
        CALL	C419C
        DI
        LD	DE,J6617
        LD	HL,H.NEWS
        LD	BC,5
        LDIR                            ; save current H.NEWS
        CALL	C4DA5			; get current slotid page 1
        LD	(H.NEWS+1),A
        LD	A,0F7H
        LD	(H.NEWS+0),A
        LD	HL,I4B55
        LD	(H.NEWS+2),HL
        LD	A,0C9H
        LD	(H.NEWS+4),A            ; install H.NEWS handler (RS232 basic interrupts)
        EI
        LD	HL,HOKVLD
        BIT	0,(HL)                  ; EXTBIO initialized ?
        JR	NZ,J413D                ; yep, skip EXTBIO initialization
        SET	0,(HL)
        LD	HL,EXTBIO
        LD	B,5
J4138:	LD	(HL),0C9H
        INC	HL
        DJNZ	J4138
J413D:	XOR	A
        LD	DE,00801H
        CALL	EXTBIO                  ; count RS232's sofar
        LD	HL,D6621
        LD	(HL),A                  ; RS232 devicenumber of this device
        XOR	A
        LD	DE,00001H
        CALL	EXTBIO                  ; get my TRAP number
        ADD	A,A
        ADD	A,A
        ADD	A,A
        ADD	A,A
        OR	(HL)
        LD	(HL),A
        LD	DE,J6612
        DI
        LD	HL,EXTBIO
        LD	BC,5
        LDIR
        CALL	C4DA5			; get current slotid page 1
        LD	(EXTBIO+1),A
        LD	A,0F7H
        LD	(EXTBIO+0),A
        LD	HL,I4450
        LD	(EXTBIO+2),HL
        LD	A,0C9H
        LD	(EXTBIO+4),A            ; install EXTBIO handler
        LD	BC,24
        LD	HL,I4184
        LD	DE,DISINT+0
        LDIR                            ; install DISINT and ENAINT handlers
        EI
        RET

I4184:	PUSH	DE
        LD	E,2
        JR	J418C			; signals disable interrupt

?4189:	PUSH	DE
        LD	E,3			; signals enable interrupt
J418C:	LD	D,00H
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

C419C:	XOR	A
        LD	(D6626),A

;	  Subroutine __________________________
;	     Inputs  ________________________
;	     Outputs ________________________

C$41A0:	PUSH	HL
        LD	HL,D6622
        XOR	A
        LD	(HL),A
        INC	HL
        LD	(HL),A
        INC	HL
        LD	(HL),A
        INC	HL
        LD	(HL),A
        POP	HL
        RET

I41AE:  DEFB    "8N1XHNNN"
        DEFW    1200
        DEFW    1200
        DEFB    0

;
; CARTRIDGE STATEMENT
;

C41BB:	EI
        PUSH	HL
        POP	IX
        LD	DE,I4218
        CALL	C$41C8
        RET	C
        PUSH	DE
        RET

;	  Subroutine __________________________
;	     Inputs  ________________________
;	     Outputs ________________________

C$41C8:	PUSH	BC
        PUSH	HL
        LD	HL,PROCNM
        LD	A,(HL)
        CP	"C"
        JR	NZ,J41F7
        INC	HL
        LD	A,(HL)
        CP	"O"
        JR	NZ,J41F7
        INC	HL
        LD	A,(HL)
        CP	"M"
        JR	NZ,J41F7
J41DE:	LD	HL,PROCNM+3
        LD	A,(DE)
        INC	A
        JR	Z,J41F7
        CALL	C41FB
        JR	Z,J41EF
        INC	DE
        INC	DE
        INC	DE
        JR	J41DE
J41EF:	EX	DE,HL
        INC	HL
        LD	E,(HL)
        INC	HL
        LD	D,(HL)
        AND	A
        JR	J41F8
J41F7:	SCF
J41F8:	POP	HL
        POP	BC
        RET

;	  Subroutine __________________________
;	     Inputs  ________________________
;	     Outputs ________________________

C41FB:	LD	A,(DE)
        LD	C,A
        LD	A,(HL)
J41FE:	CP	C
        JR	NZ,J4207
        AND	A
        RET	Z
        INC	DE
        INC	HL
        JR	C41FB
J4207:	LD	A,(DE)
        AND	A
        JR	Z,J420E
        INC	DE
        JR	J4207
J420E:	LD	A,(HL)
        AND	A
        JR	Z,J4215
        INC	HL
        JR	J420E
J4215:	LD	A,L
        OR	H
        RET

I4218:	DEFB    "INI",0
        DEFW    C4614
        DEFB    "DTR",0
        DEFW    C46D7
        DEFB    "STAT",0
        DEFW    C46F5
        DEFB    "BREAK",0
        DEFW    C4719
        DEFB    "TERM",0
        DEFW    C475E
        DEFB    0
        DEFW    C4AAC
        DEFB    "ON",0
        DEFW    C4B04
        DEFB    "OFF",0
        DEFW    C4AE6
        DEFB    "STOP",0
        DEFW    C4B22
        DEFB    "HELP",0
        DEFW    C48B5
        DEFB    0FFH

;
; CARTRIDGE DEVICE
;

C4257:	EI
        CP	0FFH
        JP	NZ,J4294
        LD	HL,PROCNM
        LD	A,(HL)
        CP	"C"
        JR	NZ,J4292
        INC	HL
        LD	A,(HL)
        CP	"O"
        JR	NZ,J4292
        INC	HL
        LD	A,(HL)
        CP	"M"
        JR	NZ,J4292
        INC	HL
        LD	A,(HL)
        AND	A
        JR	NZ,J4279
        DEC	HL
        LD	A,"0"
J4279:	SUB	"0"
        JR	C,J4292
        CP	10 
        JR	NC,J4292
        PUSH	BC
        PUSH	AF
        LD	A,(D6621)
        AND	0FH                     ; RS232 devicenumber of this device
        LD	B,A
        POP	AF
        CP	B
        POP	BC
        JR	NZ,J4292
        INC	HL
        LD	A,(HL)
        AND	A
        RET	Z
J4292:	SCF
        RET

J4294:	PUSH	HL
        PUSH	AF
        LD	HL,I42A5
        ADD	A,L
        LD	L,A
        JR	NC,J429E
        INC	H
J429E:	LD	A,(HL)
        INC	HL
        LD	H,(HL)
        LD	L,A
        POP	AF
        EX	(SP),HL
        RET

I42A5:	DEFW    C42B9			; OPEN (BASIC)
        DEFW    C430C			; CLOSE (BASIC)
        DEFW    C4500			; Random access (BASIC), sequential I/O only error
        DEFW    C432E			; Sequential output (BASIC)
        DEFW    C433A			; Sequential input (BASIC)
        DEFW    C4385			; LOC (BASIC)
        DEFW    C43B8			; LOF (BASIC)
        DEFW    C43D2			; EOF (BASIC)
        DEFW    J451E			; FPOS (BASIC), illegal function call error
        DEFW    C43FB			; BACKUP (BASIC)

;	  Subroutine OPEN (BASIC)
;	     Inputs  ________________________
;	     Outputs ________________________

C42B9:	LD	C,7FH
        CALL	C42CB			; RS232.OPEN
        JR	C,J42C4
        LD	(PTRFIL),HL
        RET
J42C4:	DEC	A
        JP	Z,J44F4                 ; bad file name error
        JP	J4506

;	  Subroutine RS232.OPEN
;	     Inputs  ________________________
;	     Outputs ________________________

C42CB:	OR	A
        LD	A,(D6626)
        BIT	3,A                     ; RS232 channel already open ?
        LD	A,2
        SCF
        RET	NZ                      ; yep, quit with error
        CALL	C500E			; install H.TIMI handler if not already done
        CALL	C407B                   ; initialize i8237
        LD	A,E
        CP	08H                     ; random mode ?
        LD	A,01H
        SCF
        RET	Z                       ; yep, quit with error
        PUSH	BC
        PUSH	DE
        PUSH	HL
        LD	(D660F),HL              ; FCB
        LD	A,C
        LD	(D6611),A               ; buffer length
        LD	(HL),E                  ; mode
        XOR	A
        INC	HL
        INC	HL
        LD	(HL),A
        INC	HL
        LD	(HL),A
        INC	HL
        INC	HL
        INC	HL
        LD	(HL),A
        CALL	C419C
        LD	HL,D6626
        SET	3,(HL)                  ; RS232 channel open
        DI
        CALL	C4DCC                   ; enable 8237 DMA requests
        CALL	C5271                   ; enable RTS signal
        EI
        OR	A
        POP	HL
        POP	DE
        POP	BC
        RET

;	  Subroutine RS232.CLOSE / CLOSE (BASIC)
;	     Inputs  ________________________
;	     Outputs ________________________

C430C:	PUSH	HL
        LD	HL,(D660F)
        LD	A,(HL)
        CP	02H			; ouput mode ?
        SCF
        CCF
        JR	NZ,J431C		; nope,
        LD	A,1AH
        CALL	C50A6			; RS232.SNDCHR
J431C:	DI
        CALL	C52D9			; wait for transmitter ready
        CALL	C5283
        CALL	C4DC4                   ; disable 8237 DMA requests
        EI
        LD	HL,D6626
        RES	3,(HL)                  ; RS232 channel closed
        POP	HL
        RET

;	  Subroutine Sequential output (BASIC)
;	     Inputs  ________________________
;	     Outputs ________________________

C432E:	LD	A,C
        CALL	C50A6			; RS232.SNDCHR
        EI
        JP	C,J452A                 ; device I/O error
        JP	Z,J452A                 ; device I/O error
        RET

;	  Subroutine Sequential input (BASIC)
;	     Inputs  ________________________
;	     Outputs ________________________

C433A:	CALL	C4341			; RS232.GETCHR
        JP	M,J452A                 ; device I/O error
        RET

;	  Subroutine RS232.GETCHR
;	     Inputs  ________________________
;	     Outputs ________________________

C4341:	PUSH	HL
        PUSH	BC
        CALL	C4413
        LD	C,(HL)
        LD	(HL),00H
        DEC	HL
        LD	A,(HL)
        LD	(D6625),A
        LD	(HL),00H
        INC	HL
        AND	A
        JR	NZ,J437B
        LD	A,C
        AND	A
        JR	NZ,J4367
        CALL	C4DEE
        EI
        LD	C,A
        JP	M,J437B
        CALL	C5177
        JR	C,J437B
        JR	Z,J437B
J4367:	PUSH	HL
        LD	HL,(D660F)
        LD	A,(HL)
        POP	HL
        CP	04H		        ; Raw mode ?
        JR	Z,J437F                 ; yep,
        LD	A,C
        CP	1AH		        ; EOF ?
        JR	NZ,J437F                ; nope,
        LD	(HL),A
        AND	A
        SCF
        JR	J4382
J437B:	OR	80H
        JR	J4381
J437F:	XOR	A
        INC	A
J4381:	LD	A,C
J4382:	POP	BC
        POP	HL
        RET

;	  Subroutine LOC (BASIC)
;	     Inputs  ________________________
;	     Outputs ________________________

C4385:	PUSH	HL
        CALL	C4393			; RS232.LOC
J4389:	LD	(DAC+2),HL
        LD	HL,VALTYP
        LD	(HL),02H	; 2 
        POP	HL
        RET

;	  Subroutine RS232.LOC
;	     Inputs  ________________________
;	     Outputs ________________________

C4393:	PUSH	AF
        EI
        LD	HL,(D660F)
        LD	A,(HL)
        CP	01H                     ; input mode ?
        JR	NZ,J43B0                ; nope,
        CALL	C440B
        JR	Z,J43A8
        SUB	1AH
        JR	Z,J43B3
        LD	A,01H	; 1 
J43A8:	PUSH	BC
        CALL	C$441A
        ADD	A,B
        POP	BC
        JR	J43B3
J43B0:	CALL	C4DDA
J43B3:	LD	L,A
        LD	H,00H
        POP	AF
        RET

;	  Subroutine LOF (BASIC)
;	     Inputs  ________________________
;	     Outputs ________________________

C43B8:	PUSH	HL
        CALL	C43BE			; RS232.LOF
J43BC:	JR	J4389

;	  Subroutine RS232.LOF
;	     Inputs  ________________________
;	     Outputs ________________________

C43BE:	PUSH	AF
        EI
        CALL	C4393			; RS232.LOC
        PUSH	DE
        EX	DE,HL
        LD	A,(D6611)
        LD	L,A
        LD	H,00H                   ; buffer length
        AND	A
        SBC	HL,DE
        INC	HL
        POP	DE
        POP	AF
        RET

;	  Subroutine EOF (BASIC)
;	     Inputs  ________________________
;	     Outputs ________________________

C43D2:	PUSH	HL
        CALL	C43DB
        JP	M,J452A                 ; device I/O error
        JR	J43BC

;	  Subroutine __________________________
;	     Inputs  ________________________
;	     Outputs ________________________

C43DB:	PUSH	BC
        LD	B,A
        EI
        CALL	C4341			; RS232.GETCHR
        JP	M,J43F8
        PUSH	BC
        LD	C,A
        CALL	C43FB			; RS232.BACKUP
        POP	BC
        CP	1AH
        JR	Z,J43F4
        XOR	A
        LD	L,A
        LD	H,A
        INC	A
        JR	J43F8
J43F4:	LD	HL,-1
        SCF
J43F8:	LD	A,B
        POP	BC
        RET

;	  Subroutine RS232.BACKUP / BACKUP (BASIC)
;	     Inputs  ________________________
;	     Outputs ________________________

C43FB:	PUSH	HL
        CALL	C4413
        LD	(HL),C
        PUSH	AF
        DEC	HL
        LD	A,(D6625)
        AND	38H
        LD	(HL),A
        POP	AF
        POP	HL
        RET

;	  Subroutine __________________________
;	     Inputs  ________________________
;	     Outputs ________________________

C440B:	PUSH	HL
        CALL	C4413
        LD	A,(HL)
        POP	HL
        AND	A
        RET

;	  Subroutine __________________________
;	     Inputs  ________________________
;	     Outputs ________________________

C4413:	LD	HL,(D660F)
        INC	HL
        INC	HL
        INC	HL
        RET

;	  Subroutine __________________________
;	     Inputs  ________________________
;	     Outputs ________________________

C$441A:	PUSH	AF
        PUSH	HL
        LD	B,00H
        CALL	C4DE9
        JR	Z,J4430
        LD	C,A
J4424:	CALL	C$4433
        LD	A,(HL)
        CP	1AH
        JR	Z,J4430
        INC	B
        DEC	C
        JR	NZ,J4424
J4430:	POP	HL
        POP	AF
        RET

;	  Subroutine __________________________
;	     Inputs  ________________________
;	     Outputs ________________________

C$4433:	PUSH	DE
        LD	A,(D6623)
        LD	HL,D6611
        ADD	A,B
        JR	C,J4440
        CP	(HL)
        JR	C,J4441
J4440:	SUB	(HL)
J4441:	LD	HL,(D660F)
        LD	E,09H
        LD	D,00H
        ADD	HL,DE
        LD	E,A
        LD	D,00H
        ADD	HL,DE
        ADD	HL,DE
        POP	DE
        RET
I4450:	EI
        PUSH	AF
        LD	A,D
        INC	A
        JP	Z,J44A4
        DEC	A
        JP	NZ,J44C4
        LD	A,E
        AND	A
        JR	Z,J446B
        DEC	A
        JR	Z,J4478
        DEC	A
        JR	Z,J447E
        DEC	A
        JR	Z,J448F
        JP	J44DF
J446B:	LD	A,08H	; 8 
        CALL	C4531
        LD	A,00H
        CALL	C4531
        JP	J44DF
J4478:	POP	AF
        INC	A
        PUSH	AF
        JP	J44DF
J447E:	CALL	C4B96                   ; Check if RS232 channel is open
        JR	Z,J448C                 ; nope,
        PUSH	BC
        CALL	C5071
        EI
        NOP
        POP	BC
        DI
        EI
J448C:	JP	J44DF
J448F:	CALL	C4B96                   ; Check if RS232 channel is open
        JR	Z,J44A1                 ; nope,
        DI
        CALL	C4DCC                   ; enable 8237 DMA requests
        CALL	C5271                   ; enable RTS signal
        PUSH	BC
        CALL	C5057
        POP	BC
        EI
J44A1:	JP	J44DF
J44A4:	LD	A,E
        AND	A
        JR	NZ,J44C2
        CALL	C4DA5			; get current slotid page 1
        CALL	C4531
        LD	A,40H
        CALL	C4531
        LD	A,40H
        CALL	C4531
        LD	A,00H
        CALL	C4531
        LD	A,00H
        CALL	C4531
J44C2:	JR	J44DF
J44C4:	CP	08H	; 8 
        JR	NZ,J44DF
        LD	A,E
        AND	A
        JR	Z,J44D2
        CP	01H	; 1 
        JR	Z,J44DC
        JR	J44DF
J44D2:	CALL	C$44E3
        LD	A,00H
        CALL	C4531
        JR	J44DF
J44DC:	POP	AF
        INC	A
        PUSH	AF
J44DF:	POP	AF
        JP	J6612                   ; EXTBIO chain

;	  Subroutine __________________________
;	     Inputs  ________________________
;	     Outputs ________________________

C$44E3:	CALL	C4DA5			; get current slotid page 1
        CALL	C4531
        LD	A,LOW A4010
        CALL	C4531
        LD	A,HIGH A4010
        CALL	C4531
        RET

J44F4:	LD	IX,M6E6B
        JR	J452E
?44FA:	LD	IX,M6E80
        JR	J452E
C4500:	LD	IX,M6E86
        JR	J452E
J4506:	LD	IX,M6E6E
        JR	J452E
J450C:	LD	IX,M6E77
        JR	J452E
J4512:	LD	IX,M481C
        JR	J452E
J4518:	LD	IX,M4055
        JR	J452E
J451E:	LD	IX,M475A
        JR	J452E
J4524:	LD	IX,M406D
        JR	J452E
J452A:	LD	IX,M73B2
J452E:	JP	C4603

;	  Subroutine __________________________
;	     Inputs  ________________________
;	     Outputs ________________________

C4531:	PUSH	AF
        PUSH	BC
        PUSH	DE
        PUSH	IX
        LD	E,A
        LD	A,B
        LD	IX,WRSLT
        CALL	C4608
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

C$4547:	PUSH	BC
        PUSH	DE
        PUSH	IX
        LD	A,B
        LD	IX,RDSLT
        CALL	C4608
        EI
        INC	HL
        POP	IX
        POP	DE
        POP	BC
        RET

;	  Subroutine check if CTRL-STOP pressed
;	     Inputs  ________________________
;	     Outputs ________________________

C455A:	PUSH	IX
        LD	IX,BREAKX
        CALL	C4608
        POP	IX
        RET

;	  Subroutine __________________________
;	     Inputs  ________________________
;	     Outputs ________________________

C4566:	PUSH	BC
        LD	B,A
        LD	A,(D6003)
        AND	A
        JR	Z,J458C
        LD	A,B
        CP	20H	; " "
        JR	NC,J458C
        LD	A,5EH	; "^"
        CALL	C458E
        LD	A,B
        ADD	A,40H	; "@"
        CALL	C458E
        LD	A,B
        CP	0AH	; 10 
        POP	BC
        RET	NZ
        LD	A,0DH	; 13 
        CALL	C458E
        LD	A,0AH	; 10 
        JR	C458E
J458C:	LD	A,B
        POP	BC

;	  Subroutine __________________________
;	     Inputs  ________________________
;	     Outputs ________________________

C458E:	PUSH	AF
        CALL	CHPUT
        EI
        LD	A,(D6005)
        AND	A
        JR	Z,J459F
        POP	AF
        PUSH	AF
        CALL	LPTOUT
        EI
J459F:	POP	AF
        RET

;	  Subroutine __________________________
;	     Inputs  ________________________
;	     Outputs ________________________

C45A1:	LD	A,(HL)
        EX	(SP),HL
        CP	(HL)
        JP	NZ,J4518                ; syntax error
        INC	HL
        EX	(SP),HL

;	  Subroutine __________________________
;	     Inputs  ________________________
;	     Outputs ________________________

C45A9:	PUSH	IX
        LD	IX,M4666
        EXX
        PUSH	HL
        EXX
        CALL	C4603
        EXX
        POP	HL
        EXX
        POP	IX
        RET

;	  Subroutine __________________________
;	     Inputs  ________________________
;	     Outputs ________________________

C$45BB:	PUSH	IX
        LD	IX,M4C64
        CALL	C4603
        POP	IX
        RET

;	  Subroutine __________________________
;	     Inputs  ________________________
;	     Outputs ________________________

C45C7:	PUSH	IX
        LD	IX,M542F
        CALL	C4603
        POP	IX
        RET

;	  Subroutine __________________________
;	     Inputs  ________________________
;	     Outputs ________________________

C$45D3:	PUSH	IX
        LD	IX,M521C
        CALL	C4603
        POP	IX
        RET

;	  Subroutine __________________________
;	     Inputs  ________________________
;	     Outputs ________________________

C$45DF:	PUSH	IX
        LD	IX,M5EA4
        CALL	C4603
        POP	IX
        RET

;	  Subroutine __________________________
;	     Inputs  ________________________
;	     Outputs ________________________

C$45EB:	PUSH	IX
        LD	IX,M67D0
        CALL	C4603
        POP	IX
        RET

;	  Subroutine __________________________
;	     Inputs  ________________________
;	     Outputs ________________________

C45F7:	PUSH	IX
        LD	IX,M517A
        CALL	C4603
        POP	IX
        RET

;	  Subroutine __________________________
;	     Inputs  ________________________
;	     Outputs ________________________

C4603:	CALL	C4608
        EI
        RET

;	  Subroutine __________________________
;	     Inputs  ________________________
;	     Outputs ________________________

C4608:	PUSH	IY
        LD	IY,(EXPTBL+0-1)
        CALL	CALSLT
        POP	IY
        RET

;	  Subroutine CALL COMINI statement handler
;	     Inputs  ________________________
;	     Outputs ________________________

C4614:	CALL	C4B9C
        CALL	C4B96                   ; Check if RS232 channel is open
        DI
        CALL	C4DC4                   ; disable 8237 DMA requests
        EI
        LD	A,(D6629)		; last i8251 command
        LD	(D6002),A
        LD	IY,D6009
        PUSH	BC
        PUSH	DE
        PUSH	HL
        LD	BC,13
        PUSH	IY
        POP	DE
        LD	HL,I41AE
        LDIR
        POP	HL
        POP	DE
        POP	BC
        LD	A,B
        AND	C
        INC	A
        JR	NZ,J4654
        LD	A,D
        AND	A
        JP	Z,J46C0
        CP	3AH	; ":"
        JP	Z,J46C0
        CP	29H	; ")"
        JP	Z,J46BD
        CALL	C45A1
        DEFB	","
        JR	J467A
J4654:	PUSH	HL
        EXX
        PUSH	HL
        EXX
        POP	HL
        LD	A,B
        AND	A
        JR	Z,J466D
        PUSH	IY
        POP	DE
J4660:	LD	A,(HL)
        CP	20H	; " "
        JR	Z,J4669
        CALL	C$4C48
        LD	(DE),A
J4669:	INC	DE
        INC	HL
        DJNZ	J4660
J466D:	POP	HL
        DEC	HL
        CALL	C45A9
        CP	")"
        JR	Z,J46BD
        CALL	C45A1
        DEFB	","
J467A:	CP	","
        JR	Z,J4694
        CALL	C45C7
        LD	(IY+8),E
        LD	(IY+9),D
        LD	A,(HL)
        CP	")"
        JR	NZ,J4694
        LD	(IY+10),E
        LD	(IY+11),D
        JR	J46BD
J4694:	CALL	C45A1
        DEFB	","
        CP	","
        JR	Z,J46AA
        CALL	C45C7
        LD	(IY+10),E
        LD	(IY+11),D
        LD	A,(HL)
        CP	29H	; ")"
        JR	Z,J46BD
J46AA:	CALL	C45A1
        DEFB	","
        CP	")"
        JR	Z,J46BD
        CALL	C$45D3
        LD	(IY+12),A
        CALL	C45A1
        DEFB	")"
        DEC	HL
J46BD:	CALL	C45A9
J46C0:	EI
        CALL	C4C51                   ; initialize RS232 port
        JP	C,J451E                 ; illegal function call error
        CALL	C4B96                   ; Check if RS232 channel is open
        CALL	NZ,C4DCC                ; yep, enable 8237 DMA requests
        LD	A,(D6002)
        BIT	5,A
        CALL	NZ,C5271                ; enable RTS signal
        AND	A
        RET

;	  Subroutine CALL COMDTR statement handler
;	     Inputs  ________________________
;	     Outputs ________________________

C46D7:	CALL	C4B9C
        CALL	C4C05
        CALL	C45A1
        DEFB	","
        CALL	C4B96                   ; Check if RS232 channel is open
        JP	Z,J450C                 ; nope, file not open error
        CALL	C45C7
        CALL	C45A1
        DEFB	")"
        LD	A,D
        OR	E
        CALL	C5299			; RS232.DTR
        EI
        RET

;	  Subroutine CALL COMSTAT statement handler
;	     Inputs  ________________________
;	     Outputs ________________________

C46F5:	CALL	C4B9C
        CALL	C4C05
        CALL	C45A1
        DEFB	","
        CALL	C4B96                   ; Check if RS232 channel is open
        JP	Z,J450C                 ; nope, file not open error
        CALL	C$45DF
        PUSH	HL
        CALL	C52B1			; RS232.STAT
        LD	(DAC+2),HL
        POP	HL
        CALL	C$4C0F
        CALL	C45A1
        DEFB	")"
        AND	A
        RET

;	  Subroutine CALL COMBREAK statement handler
;	     Inputs  ________________________
;	     Outputs ________________________

C4719:	CALL	C4B9C
        CALL	C4C05
        CALL	C4B96                   ; Check if RS232 channel is open
        JP	Z,J450C                 ; nope, file not open error
        LD	A,D
        CP	","
        JR	Z,J473A
        AND	A
        JR	Z,J4735
        CP	":"
        JR	Z,J4735
        CALL	C45A1
        DEFB	")"
J4735:	LD	DE,10
        JR	J4744
J473A:	CALL	C45A9
        CALL	C45C7
        CALL	C45A1
        DEFB	")"
J4744:	PUSH	HL
        LD	HL,2
        AND	A
        SBC	HL,DE
        JP	NC,J451E                ; illegal function call error
        POP	HL
        CALL	C5231			; RS232.SNDBRK
        EI
        LD	A,00H
        INC	A
        CALL	C5177
        JP	C,J452A                 ; device I/O error
        AND	A
        RET

;	  Subroutine CALL COMTERM statement handler
;	     Inputs  ________________________
;	     Outputs ________________________

C475E:	CALL	C4B9C
        CALL	C4C05
        LD	A,D
        AND	A
        JR	Z,J4770
        CP	":"
        JR	Z,J4770
        CALL	C45A1
        DEFB	")"
J4770:	LD	(D6007),HL
        CALL	C4B96                   ; Check if RS232 channel is open
        JP	NZ,J4506                ; yep, file already open error
        XOR	A
        LD	(D6000),A
        LD	(D6005),A
        LD	(D6003),A
        LD	(D6004),A
        LD	HL,FNKSTR+5*16
        LD	DE,I6016
        LD	BC,00030H
        PUSH	BC
        PUSH	HL
        LDIR
        POP	HL
        POP	BC
        LD	B,C
        PUSH	HL
J4797:	LD	(HL),00H
        INC	HL
        DJNZ	J4797
        POP	DE
        LD	HL,I484C
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
        XOR	A
        LD	(D6009),A
        LD	A,(CSRSW)
        LD	(D6006),A
        CALL	C486D
        LD	HL,(NULBUF)
        LD	E,04H	; 4 
        LD	C,78H	; "x"
        CALL	C42CB			; RS232.OPEN
J47CC:	EI
        CALL	C4393			; RS232.LOC
        LD	A,L
        OR	H
        JR	Z,J47DC
        CALL	C$485B
        JR	C,J4808
        CALL	C4566
J47DC:	CALL	C$48AA
        CALL	NZ,C$4865
        CALL	C455A                   ; check if CTRL-STOP pressed
        JR	C,J4808                 ; yep,
        CALL	CHSNS
        EI
        JR	Z,J47CC
        CALL	CHGET
        EI
        CP	0FEH
        JP	Z,J482B
        CALL	C$4860
        LD	C,A
        LD	A,(D6004)
        AND	A
        JP	Z,J47CC
I4800	EQU	$-1
        LD	A,C
        CALL	C4566
        JP	J47CC
J4808:	CALL	C430C			; RS232.CLOSE
        LD	HL,I6016
        LD	DE,FNKSTR+5*16
        LD	BC,00030H
        LDIR
        LD	HL,(D6007)
        LD	A,(D6006)
        AND	A
        PUSH	AF
        CALL	Z,C488A
        POP	AF
        CALL	NZ,C486D
        XOR	A
        DI
        LD	(INTFLG),A
        RET
J482B:	CALL	CHGET
        EI
        SUB	06H	; 6 
        JR	Z,J483E
        DEC	A
        JR	Z,J4843
        DEC	A
        JR	NZ,J4849
        LD	HL,D6005
        JR	J4846
J483E:	LD	HL,D6003
        JR	J4846
J4843:	LD	HL,D6004
J4846:	LD	A,(HL)
        CPL
        LD	(HL),A
J4849:	JP	J47CC
D$484B	EQU	$-1
I484C:	CP	06H	; 6 
        NOP
        LD	L,H
        LD	L,C
        CP	07H	; 7 
        NOP
        LD	L,B
        LD	H,(HL)
        CP	08H	; 8 
I4858:	NOP
        LD	(HL),B
        LD	H,L

;	  Subroutine __________________________
;	     Inputs  ________________________
;	     Outputs ________________________

C$485B:	CALL	C4DEE
        EI
        RET

;	  Subroutine __________________________
;	     Inputs  ________________________
;	     Outputs ________________________

C$4860:	CALL	C50A6			; RS232.SNDCHR
        EI
        RET

;	  Subroutine __________________________
;	     Inputs  ________________________
;	     Outputs ________________________

C$4865:	LD	DE,100
        CALL	C5231			; RS232.SNDBRK
        EI
        RET

;	  Subroutine __________________________
;	     Inputs  ________________________
;	     Outputs ________________________

C486D:	LD	A,(ESCCNT)
        OR	A
        RET	NZ
        LD	A,(D6009)
        OR	A
        RET	NZ
        CPL
        LD	(D6009),A
        LD	A,1BH
        CALL	CHPUT
        LD	A,79H	; "y"
J4882:	CALL	CHPUT
        LD	A,35H	; "5"
J4887:	JP	CHPUT

;	  Subroutine __________________________
;	     Inputs  ________________________
;	     Outputs ________________________

C488A:	LD	A,(ESCCNT)
        OR	A
        RET	NZ
        LD	A,(D6009)
        OR	A
        RET	Z
        CPL
        LD	(D6009),A
        LD	A,1BH
        CALL	CHPUT
        LD	A,78H	; "x"
        JR	J4882

;	  Subroutine __________________________
;	     Inputs  ________________________
;	     Outputs ________________________

C$48A1:	LD	A,0DH	; 13 
        CALL	C4566
        LD	A,0AH	; 10 
        JR	J4887

;	  Subroutine __________________________
;	     Inputs  ________________________
;	     Outputs ________________________

C$48AA:	LD	A,(INTFLG)
        AND	A
        RET	Z
        XOR	A
        LD	(INTFLG),A
        INC	A
        RET

;	  Subroutine CALL COMHELP statement handler
;	     Inputs  ________________________
;	     Outputs ________________________

C48B5:	CALL	C4B9C
        CALL	C4C05
        LD	A,D
        AND	A
        JR	Z,J48C7
        CP	":"
        JR	Z,J48C7
        CALL	C45A1
        DEFB	")"
J48C7:	XOR	A
        LD	(D6003),A
        LD	(D6005),A
        LD	(D6004),A
        PUSH	HL
        CALL	C$48A1
        LD	HL,I490E
J48D8:	LD	A,(HL)
        INC	HL
        INC	A
        JR	Z,J490B
        DEC	A
        JR	Z,J48ED
        CALL	C4566
        LD	A,(INTFLG)
        AND	A
        JR	Z,J48D8
        CP	03H	; 3 
        JR	Z,J490B
J48ED:	PUSH	HL
        LD	HL,INTFLG
        LD	(HL),00H
        CALL	C486D
J48F6:	EI
        LD	A,(HL)
        AND	A
        JR	Z,J48F6
        PUSH	AF
        CALL	C488A
        POP	AF
        POP	HL
        CP	03H	; 3 
        JR	Z,J490B
        XOR	A
        LD	(INTFLG),A
        JR	J48D8
J490B:	POP	HL
        AND	A
        RET

I490E:	DEFB    "Initialize statement options",13,10
        DEFB    13,10
        DEFB    'CALL COMINI ("',13,10
        DEFB    "<device# {0,1,2...9}>:",13,10
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

;	  Subroutine CALL COM statement handler
;	     Inputs  ________________________
;	     Outputs ________________________

C4AAC:	CALL	C4B9C
        CALL	C4C05
        CALL	C4B89
        JP	C,J451E                 ; illegal function call error
J4AB8:	CALL	C45A1
        DEFB	","
J4ABC:	CALL	C45A1
        DEFB	08DH			; GOSUB token
J4AC0:	LD	IX,M4769
        CALL	C4603
        PUSH	HL
        LD	A,E
        OR	D
        JR	Z,J4AD8
        LD	IX,M4295
        CALL	C4603
J4AD3:	JP	NC,J4512                ; undefined line error
        LD	E,C
        LD	D,B
J4AD8:	CALL	C4B76
J4ADB:	INC	HL
        LD	(HL),E
        INC	HL
        LD	(HL),D
        POP	HL
        CALL	C45A1
        DEFB	")"
        AND	A
        RET

;	  Subroutine CALL COMOFF statement handler
;	     Inputs  ________________________
;	     Outputs ________________________

C4AE6:	CALL	C4B9C
        CALL	C4C05
        LD	A,D
        AND	A
        JR	Z,J4AF8
        CP	":"
        JR	Z,J4AF8
        CALL	C45A1
        DEFB	")"
J4AF8:	CALL	C4B89
        JP	C,J451E                 ; illegal function call error
        LD	IX,M632B
        JR	J4B4B

;	  Subroutine CALL COMON statement handler
;	     Inputs  ________________________
;	     Outputs ________________________

C4B04:	CALL	C4B9C
        CALL	C4C05
        LD	A,D
        AND	A
        JR	Z,J4B16
        CP	":"
        JR	Z,J4B16
        CALL	C45A1
        DEFB	")"
J4B16:	CALL	C4B89
        JP	C,J451E                 ; illegal function call error
        LD	IX,M631B
        JR	J4B3E

;	  Subroutine CALL COMSTOP statement handler
;	     Inputs  ________________________
;	     Outputs ________________________

C4B22:	CALL	C4B9C
        CALL	C4C05
        LD	A,D
        AND	A
        JR	Z,J4B34
        CP	":"
        JR	Z,J4B34
        CALL	C45A1
        DEFB	")"
J4B34:	CALL	C4B89
        JP	C,J451E                 ; illegal function call error
        LD	IX,M6331
J4B3E:	PUSH	HL
        PUSH	AF
        CALL	C4B76
        LD	A,(HL)
        AND	01H
        CALL	Z,C$41A0
        POP	AF
        POP	HL
J4B4B:	PUSH	HL
        CALL	C4B76
        CALL	C4603
        POP	HL
        AND	A
        RET

;	  Subroutine H.NEWS handler
;	     Inputs  ________________________
;	     Outputs ________________________

I4B55:	EI
        CALL	C4DDA			; character left ?
        PUSH	HL
        CALL	NZ,C4B61		; yep,
        POP	HL
        JP	J6617			; H.NEWS chain

;	  Subroutine __________________________
;	     Inputs  ________________________
;	     Outputs ________________________

C4B61:	CALL	C4B76
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

C4B76:	CALL	C4B89
        JP	C,J451E                 ; illegal function call error
        PUSH	BC
        LD	C,A
        ADD	A,A
        ADD	A,C
        LD	C,A
        LD	B,00H
        LD	HL,TRPTBL+18*3
        ADD	HL,BC
        POP	BC
        RET

;	  Subroutine __________________________
;	     Inputs  ________________________
;	     Outputs ________________________

C4B89:	LD	A,(D6621)
        AND	0F0H
        RRCA
        RRCA
        RRCA
        RRCA                            ; trapnumber of this device
        CP	06H
        CCF
        RET

;	  Subroutine Check if RS232 channel is open
;	     Inputs  ________________________
;	     Outputs ________________________

C4B96:	LD	A,(D6626)
        BIT	3,A
        RET

;	  Subroutine __________________________
;	     Inputs  ________________________
;	     Outputs ________________________

C4B9C:	DEC	HL
        CALL	C45A9
        LD	D,A
        JR	NZ,J4BAA
J4BA3:	XOR	A
        LD	BC,-1
        PUSH	HL
        JR	J4BE8
J4BAA:	CP	"("
        JP	Z,J4BB5
        CP	","
        JR	Z,J4BA3
        JR	J4BBD
J4BB5:	CALL	C45A9
        LD	D,A
        CP	","
        JR	Z,J4BA3
J4BBD:	CALL	C$45BB
        PUSH	HL
        CALL	C$45EB
        LD	C,00H
        LD	B,(HL)
        INC	HL
        LD	A,(HL)
        INC	HL
        LD	H,(HL)
        LD	L,A
        LD	A,B
        AND	A
        JR	Z,J4BE8
        INC	HL
        LD	A,(HL)
        CP	":"
        JR	Z,J4BDA
        DEC	HL
        XOR	A
        JR	J4BE8
J4BDA:	DEC	HL
        LD	A,(HL)
        SUB	"0"
        JR	C,J4C02
        CP	0AH	; 10 
        JR	NC,J4C02
        INC	HL
        INC	HL
        DEC	B
        DEC	B
J4BE8:	LD	E,A
        LD	A,(D6621)
        AND	0FH                     ; RS232 devicenumber of this device
        PUSH	HL
        EXX
        POP	HL
        EXX
        POP	HL
        PUSH	AF
        DEC	HL
        CALL	C45A9
        LD	D,A
        POP	AF
        CP	E
        RET	Z
J4BFC:	POP	HL
        PUSH	IX
        POP	HL
        SCF
        RET
J4C02:	POP	HL
        JR	J4BFC

;	  Subroutine __________________________
;	     Inputs  ________________________
;	     Outputs ________________________

C4C05:	LD	A,B
        OR	C
        RET	Z
        LD	A,B
        AND	C
        INC	A
        RET	Z
        JP	J451E                   ; illegal function call error

;	  Subroutine __________________________
;	     Inputs  ________________________
;	     Outputs ________________________

C$4C0F:	PUSH	HL
        LD	HL,VALTYP
        LD	A,(HL)
        CP	02H	; 2 
        JR	Z,J4C3D
        CP	04H	; 4 
        JR	Z,J4C2D
        CP	08H	; 8 
        JP	NZ,J4524                ; type mismatch error
        LD	(HL),02H	; 2 
        PUSH	DE
        LD	A,08H	; 8 
        CALL	C45F7
        LD	C,08H	; 8 
        JR	J4C37
J4C2D:	LD	(HL),02H	; 2 
        PUSH	DE
        LD	A,04H	; 4 
        CALL	C45F7
        LD	C,04H	; 4 
J4C37:	POP	DE
        LD	HL,DAC+0
        JR	J4C42
J4C3D:	LD	HL,DAC+2
        LD	C,02H	; 2 
J4C42:	LD	B,00H
        LDIR
        POP	HL
        RET

;	  Subroutine __________________________
;	     Inputs  ________________________
;	     Outputs ________________________

C$4C48:	CP	"a"
        RET	C
        CP	"z"+1
        RET	NC
        SUB	20H
        RET

;	  Subroutine initialize RS232 port
;	     Inputs  ________________________
;	     Outputs ________________________

C4C51:	LD	A,(IY+0)
        SUB	"5"
        CP	"8"-"5"+1
        JR	NC,J4C72
        LD	B,A
        LD	D,A
        CALL	C$4D26			; character mask
        LD	A,(IY+1)
        CP	"E"
I4C64:	JR	Z,J4C74
        CP	"O"
        JR	Z,J4C76
        CP	"I"
        JR	Z,J4C7A
        CP	"N"
        JR	Z,J4C81
J4C72:	SCF
        RET

J4C74:	SET	3,B			; parity even
J4C76:	SET	2,B			; parity enabled
        JR	J4C81
J4C7A:	LD	A,B
        CP	"8"-"5"			; parity ignore AND 8 bits ?
        JP	Z,J4C72			; yep, quit with error (illegal)
        INC	B
J4C81:	RLC	B
        RLC	B
        LD	A,(IY+2)
        SUB	"1"
        CP	03H	; 3 
        JP	NC,J4C72
        INC	A
        RRCA
        RRCA
        OR	B
        LD	B,A
        LD	C,00H
        LD	A,(IY+3)
        CP	"X"
        JR	NZ,J4CA1
        SET	0,C			; use XON/XOFF protocol
        JR	J4CA6

J4CA1:	CP	"N"
        JP	NZ,J4C72
J4CA6:	LD	A,(IY+4)
        CP	"H"
        JR	NZ,J4CB1
        SET	1,C			; use RTS/CTS handshake
        JR	J4CB6
J4CB1:	CP	"N"
        JP	NZ,J4C72
J4CB6:	LD	A,(IY+5)
        CP	"A"
        JR	NZ,J4CC1
        SET	3,C			; use Auto LF receive
        JR	J4CC6

J4CC1:	CP	"N"
        JP	NZ,J4C72
J4CC6:	LD	A,(IY+6)
        CP	"A"
        JR	NZ,J4CD1
        SET	2,C			; use Auto LF send
        JR	J4CD6

J4CD1:	CP	"N"
        JP	NZ,J4C72
J4CD6:	LD	A,(IY+7)
        CP	"S"
        JR	NZ,J4CE7
        LD	A,D
        CP	02H	; 2 
        JP	NZ,J4C72
        SET	4,C			; use SI/SO control
        JR	J4CEC

J4CE7:	CP	"N"
        JP	NZ,J4C72
J4CEC:	LD	A,C
        LD	(D6627),A
        LD	A,02H	; 2 
        OR	B
        LD	(D662A),A
        CALL	C5189			; initalize i8251
        LD	E,(IY+8)
        LD	D,(IY+9)		; receive baudrate
        CALL	C4D3A
        JP	C,J4C72
        LD	C,0			; channel 0
        CALL	C5357			; set baudrate channel
        LD	E,(IY+10)
        LD	D,(IY+11)		; transmit baudrate
        CALL	C4D3A
        JP	C,J4C72
        LD	C,1			; channel 1
        CALL	C5357			; set baudrate channel
        LD	A,(IY+12)
        LD	(D660E),A               ; timeout counter
        CALL	C529C			; enable DTR
        OR	A
        RET

;	  Subroutine __________________________
;	     Inputs  ________________________
;	     Outputs ________________________

C$4D26:	PUSH	AF
        PUSH	BC
        XOR	03H	; 3 
        LD	C,0FFH
        JR	Z,J4D33
        LD	B,A
J4D2F:	SRL	C
        DJNZ	J4D2F
J4D33:	LD	A,C
        LD	(D6628),A
        POP	BC
        POP	AF
        RET

;	  Subroutine __________________________
;	     Inputs  ________________________
;	     Outputs ________________________

C4D3A:	PUSH	HL
        BIT	7,D
        JR	Z,J4D4C
        LD	A,E
        AND	D
        INC	A
        JR	Z,J4D68
        LD	HL,0
        SBC	HL,DE
        EX	DE,HL
        JR	J4D67
J4D4C:	LD	HL,I4D6B
J4D4F:	LD	C,(HL)
        INC	HL
        LD	B,(HL)
        INC	HL
        LD	A,B
        OR	C
        JR	Z,J4D68
        PUSH	HL
        LD	L,E
        LD	H,D
        AND	A
        SBC	HL,BC
        POP	HL
        JR	Z,J4D64
        INC	HL
        INC	HL
        JR	J4D4F
J4D64:	LD	E,(HL)
        INC	HL
        LD	D,(HL)
J4D67:	SCF
J4D68:	CCF
        POP	HL
        RET
I4D6B:  DEFW       50,00900h
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

;	  Subroutine get current slotid page 1
;	     Inputs  ________________________
;	     Outputs ________________________

C4DA5:	PUSH	BC
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
J4DB5:	AND	80H
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

;	  Subroutine disable 8237 DMA requests
;	     Inputs  ________________________
;	     Outputs ________________________

C4DC4:	PUSH	AF
        LD	A,0FFH
        LD	(D7FEF),A		; set channel mask bit channel 0,1,2,3 i8237
        POP	AF
        RET

;	  Subroutine enable 8237 DMA requests
;	     Inputs  ________________________
;	     Outputs ________________________

C4DCC:	PUSH	HL
        LD	HL,D7FEF
        LD	(HL),0F0H		; reset channel mask bit channel 0,1,2,3 i8237
        POP	HL
        RET

;	  Subroutine H.TIMI handler
;	     Inputs  ________________________
;	     Outputs ________________________

I4DD4:	CALL	C$4F2B
        JP	X661C			; H.TIMI chain

;	  Subroutine __________________________
;	     Inputs  ________________________
;	     Outputs ________________________

C4DDA:	CALL	C4DE9
        PUSH	BC
        LD	B,A
        CALL	C440B			; backup char ?
        JR	Z,J4DE6			; nope,
        LD	A,1
J4DE6:	ADD	A,B
        POP	BC
        RET

;	  Subroutine __________________________
;	     Inputs  ________________________
;	     Outputs ________________________

C4DE9:	LD	A,(D6622)
        AND	A
        RET

;	  Subroutine __________________________
;	     Inputs  ________________________
;	     Outputs ________________________

C4DEE:	PUSH	HL
        PUSH	DE
        PUSH	BC
        LD	HL,D6622
J4DF4:	EI
        CALL	C455A                   ; check if CTRL-STOP pressed
        JR	C,J4E39                 ; yep,
        LD	A,(HL)
        AND	A
        JR	NZ,J4E0A
        CALL	C5271                   ; enable RTS signal
        CALL	C5057
        JR	C,J4E39
        JR	Z,J4E39
        JR	J4DF4
J4E0A:	PUSH	HL
        LD	HL,I7803
        BIT	3,(HL)
        RES	3,(HL)
        POP	HL
        JR	Z,J4E20
        CALL	C5271                   ; enable RTS signal
        CALL	C5057
        EI
        JR	C,J4E39
        JR	Z,J4E39
J4E20:	DI
        DEC	(HL)
        CALL	C503C
        LD	C,(HL)
        LD	B,80H
        INC	HL
        LD	A,(HL)
        LD	(D6625),A
        AND	A
        JR	Z,J4E31
        INC	B
J4E31:	LD	A,C
        OR	A
        DEC	B
J4E34:	EI
        POP	BC
        POP	DE
        POP	HL
        RET
J4E39:	PUSH	AF
        POP	BC
        RES	7,C
        PUSH	BC
        POP	AF
        JR	J4E34

;	  Subroutine __________________________
;	     Inputs  ________________________
;	     Outputs ________________________

C$4E41:	PUSH	HL
        LD	HL,(D7804)
        LD	A,H
        OR	L
        POP	HL
        RET	Z
        PUSH	HL
        PUSH	BC
        LD	HL,(D7800)
        LD	A,(HL)
        INC	HL
        LD	BC,I7000
        OR	A
        PUSH	HL
        SBC	HL,BC
        POP	HL
        JR	C,J4E5D
        LD	HL,I6800
J4E5D:	LD	(D7800),HL
        LD	HL,(D7804)
        DEC	HL
        LD	(D7804),HL
        POP	BC
        POP	HL
        RET

;	  Subroutine __________________________
;	     Inputs  ________________________
;	     Outputs ________________________

C$4E6A:	PUSH	HL
        PUSH	BC
        LD	HL,(D7800)
        LD	BC,2048
        ADD	HL,BC
        LD	A,(HL)
        POP	BC
        POP	HL
        RET

;	  Subroutine __________________________
;	     Inputs  ________________________
;	     Outputs ________________________

C4E77:	PUSH	IX
        LD	IX,I7FE6
        DI
        LD	(D7FEC),A			; clear byte pointer i8237
        LD	L,(IX+0)
        LD	H,(IX+0)			; current address channel 3 i8237
J4E87:	LD	E,(IX+0)
        LD	D,(IX+0)
        OR	A
        SBC	HL,DE
        EX	DE,HL				; still changing ?
        JR	NZ,J4E87			; yep, wait
        POP	IX
        LD	DE,(D7800)
        OR	A
        SBC	HL,DE
        RET	NC
        LD	DE,2048
        ADD	HL,DE
        RET

;	  Subroutine __________________________
;	     Inputs  ________________________
;	     Outputs ________________________

C$4EA2:	PUSH	HL
        PUSH	DE
        CALL	C4E77
        PUSH	HL
        LD	DE,(D7804)
        OR	A
        SBC	HL,DE
        JR	NC,J4ED6
        LD	DE,2048
        ADD	HL,DE
        LD	DE,(D7800)
        ADD	HL,DE
        LD	DE,512-1
        ADD	HL,DE
        LD	DE,I7000-1
        OR	A
        EX	DE,HL
        SBC	HL,DE
        JR	NC,J4ECC
        LD	HL,-2048
        ADD	HL,DE
        EX	DE,HL
J4ECC:	LD	(D7800),DE
        POP	HL
        CALL	C4E77
        PUSH	HL
        SCF
J4ED6:	POP	HL
        LD	(D7804),HL
        POP	DE
        POP	HL
        RET

;	  Subroutine __________________________
;	     Inputs  ________________________
;	     Outputs ________________________

C$4EDD:	PUSH	HL
        PUSH	BC
        PUSH	DE
        LD	HL,(D7804)
        LD	DE,(D7800)
        ADD	HL,DE
        LD	DE,I7000
        OR	A
        PUSH	HL
        SBC	HL,DE
        POP	HL
        JR	C,J4EF6
        LD	DE,-2048
        ADD	HL,DE
J4EF6:	LD	DE,(D7806)
        PUSH	HL
        OR	A
        SBC	HL,DE
        JR	NC,J4F04
        LD	DE,2048
        ADD	HL,DE
J4F04:	LD	B,H
        LD	C,L
        POP	HL
        LD	(D7806),HL
        LD	DE,I6800
J4F0D:	LD	A,B
        OR	C
        JR	Z,J4F27
        DEC	HL
        PUSH	HL
        SBC	HL,DE
        POP	HL
        JR	NC,J4F1B
        LD	HL,I6800+2048-1
J4F1B:	LD	A,(HL)
        CP	11H                     ; XON ?
        JR	Z,J4F27
        CP	13H                     ; XOFF ?
        JR	Z,J4F27
        DEC	BC
        JR	J4F0D
J4F27:	POP	DE
        POP	BC
        POP	HL
        RET

;	  Subroutine RS232 interrupt handler
;	     Inputs  ________________________
;	     Outputs ________________________

C$4F2B:	LD	HL,D6626
        BIT	3,(HL)                  ; RS232 channel open ?
        RET	Z                       ; nope, quit
        CALL	C$4EA2
        LD	HL,I7803
        JR	NC,J4F3B
        SET	0,(HL)
J4F3B:	LD	HL,(D7804)
        OR	A
        PUSH	HL
        LD	DE,1024
        SBC	HL,DE
        JR	NC,J4F51
        PUSH	HL
        LD	HL,I7803
        SET	3,(HL)
        POP	HL
        POP	HL
        JR	J4F5A
J4F51:	POP	DE
        LD	HL,1536
        SBC	HL,DE
        CALL	C,C5071
J4F5A:	CALL	C$4EDD
        LD	HL,D6626
        CP	11H			; XON ?
        JR	NZ,J4F68
        RES	2,(HL)                  ; partner not in XOFF mode
        JR	J4F6E
J4F68:	CP	13H			; XOFF ?
        JR	NZ,J4F6E
        SET	2,(HL)                  ; partner in XOFF mode
J4F6E:	LD	HL,(D7804)
        LD	A,H
        OR	L
        RET	Z
        LD	HL,D6622
        LD	A,(D6611)
        SUB	(HL)
        RET	Z
        CALL	C$4F81
        JR	J4F6E

;	  Subroutine __________________________
;	     Inputs  ________________________
;	     Outputs ________________________

C$4F81:	CALL	C$4E6A                  ; get received status
        AND	38H
        LD	B,A
        CALL	C$4E41                  ; get received char
        LD	HL,D6628
        AND	(HL)                    ; mask off unused bits
        LD	C,A
        LD	A,B
        AND	A                       ; any errors ?
        JR	NZ,J4FA6                ; yep,
        LD	A,(D6627)
        BIT	0,A			; XON/XOFF protcol enabled ?
        JR	Z,J4FB4			; nope,
        LD	HL,D6626
        LD	A,C
        CP	11H			; XON received ?
        RET	Z
        CP	13H			; XOFF received ?
        RET	Z
        JR	J4FB4
J4FA6:	AND	20H                     ; FE (Framing Error) ?
        JR	Z,J4FCC                 ; nope,
        LD	A,C
        AND	A
        JR	NZ,J4FCC
        LD	HL,D6626
        SET	4,(HL)                  ; break detected
        RET
J4FB4:	LD	A,(D6627)
        BIT	4,A			; SI/SO control enabled ?
        JR	Z,J4FCC			; nope,
        LD	HL,D6626
        LD	A,C
        SUB	0FH                     ; SI received ?
        JR	NZ,J4FC6
        RES	7,(HL)                  ; yep, reset flag
        RET
J4FC6:	INC	A                       ; SO received ?
        JR	NZ,J4FCC                ; nope,
        SET	7,(HL)                  ; yep, set flag
        RET
J4FCC:	LD	HL,D6622
        INC	(HL)
        INC	HL
        PUSH	BC
        CALL	C503C
        POP	BC
        LD	A,(D6627)
        BIT	4,A			; SI/SO control enabled ?
        LD	A,C
        JR	Z,J4FEC			; nope,
        CP	20H
        JR	C,J4FEC
        LD	A,(D6626)
        BIT	7,A                     ; in SO mode ?
        LD	A,C
        JR	Z,J4FEC
        OR	80H                     ; yep, set b7
J4FEC:	LD	(HL),A
        PUSH	HL
        LD	HL,I7803
        BIT	0,(HL)
        JR	Z,J4FF9
        SET	7,B
        RES	0,(HL)
J4FF9:	POP	HL
        LD	A,B
        INC	HL
        LD	(HL),A
        DEC	HL
        AND	A
        RET	NZ
        LD	A,(D6627)
        BIT	3,A			; auto LF receive enabled ?
        RET	Z			; nope,
        LD	A,(HL)
        CP	0DH
        RET	NZ
        LD	C,0AH
        JR	J4FCC

;	  Subroutine install H.TIMI handler if not already done
;	     Inputs  ________________________
;	     Outputs ________________________

C500E:	DI
        LD	A,(X661C)
        OR	A			; H.TIMI handler already installed ?
        RET	NZ			; yep, quit
        PUSH	HL
        PUSH	DE
        PUSH	BC
        LD	DE,X661C
        LD	HL,H.TIMI
        LD	BC,5
        LDIR
        CALL	C4DA5			; get current slotid page 1
        LD	(H.TIMI+1),A
        LD	A,0F7H
        LD	(H.TIMI+0),A
        LD	HL,I4DD4
        LD	(H.TIMI+2),HL
        LD	A,0C9H
        LD	(H.TIMI+4),A
        POP	BC
        POP	DE
        POP	HL
        RET

;	  Subroutine __________________________
;	     Inputs  ________________________
;	     Outputs ________________________

C503C:	INC	HL
        LD	A,(HL)
        LD	C,A
        INC	A
        PUSH	HL
        LD	HL,D6611
        CP	(HL)
        POP	HL
        JR	C,J5049
        XOR	A
J5049:	LD	(HL),A
        EX	DE,HL
        LD	HL,(D660F)
        LD	B,00H
        ADD	HL,BC
        ADD	HL,BC
        LD	BC,9
        ADD	HL,BC
        RET

;	  Subroutine __________________________
;	     Inputs  ________________________
;	     Outputs ________________________

C5057:	DI
        LD	A,(D6626)
        BIT	1,A                     ; in XOFF mode ?
        JR	NZ,J5062                ; yep, leave XOFF mode
        XOR	A
        INC	A
        RET
J5062:	LD	C,11H                   ; XON
        CALL	C508D
        RET	C
        RET	Z
        PUSH	HL
        LD	HL,D6626
        RES	1,(HL)
        POP	HL
        RET

;	  Subroutine __________________________
;	     Inputs  ________________________
;	     Outputs ________________________

C5071:	DI
        XOR	A
        INC	A
        LD	A,(D6626)
        BIT	1,A                     ; in XOFF mode ?
        RET	NZ                      ; yep, quit
        LD	C,13H                   ; XOFF
        CALL	C508D
        CALL	C52D9			; wait for transmitter ready
        PUSH	HL
        LD	HL,D6626
        SET	1,(HL)                  ; XOFF mode
        POP	HL
        CALL	C5279                   ; disable RTS signal
        RET

;	  Subroutine __________________________
;	     Inputs  ________________________
;	     Outputs ________________________

C508D:	LD	A,(D6627)
        BIT	0,A			; XON/XOFF protocol enabled ?
        JR	NZ,J5097		; yep,
        XOR	A
        INC	A
        RET

J5097:	CALL	C52D9			; wait for transmitter ready
        PUSH	DE
        CALL	C52E9			; wait for CTS (if RTS/CTS enabled)
        POP	DE
        RET	C
        RET	Z
        LD	A,C
        LD	(D7FF8),A		; transmit data
        RET

;	  Subroutine RS232.SNDCHR
;	     Inputs  ________________________
;	     Outputs ________________________

C50A6:	PUSH	BC
        LD	C,A
        CALL	C50AE
        LD	A,C
        POP	BC
        RET

;	  Subroutine __________________________
;	     Inputs  ________________________
;	     Outputs ________________________

C50AE:	EI
        PUSH	BC
        LD	C,A
        LD	A,(D6627)
        BIT	4,A			; SI/SO control enabled ?
        JR	Z,J50F0                 ; nope,
        LD	A,C
        CP	20H
        JR	C,J50F0
        LD	A,(D6626)
        BIT	0,A                     ; in SO mode ?
        JR	NZ,J50DA                ; yep,
        BIT	7,C
        JR	Z,J50F0
        LD	A,0EH
        CALL	C50F2
        JR	C,J513E
        JR	Z,J513E
        PUSH	HL
        LD	HL,D6626
        SET	0,(HL)                  ; SO mode
        POP	HL
        JR	J50EE
J50DA:	BIT	7,C
        JR	NZ,J50EE
        LD	A,0FH
        CALL	C50F2
        JR	C,J513E
        JR	Z,J513E
        PUSH	HL
        LD	HL,D6626
        RES	0,(HL)                  ; SI mode
        POP	HL
J50EE:	RES	7,C
J50F0:	LD	A,C
        POP	BC

;	  Subroutine __________________________
;	     Inputs  ________________________
;	     Outputs ________________________

C50F2:	PUSH	HL
        LD	HL,D6627
        BIT	2,(HL)			; auto LF send ?
        POP	HL
        JR	Z,J5111			; nope,
        CP	0AH
        JR	NZ,J5111
        LD	A,(D6626)
        BIT	5,A                     ; CR transmitted before this ?
        LD	A,0AH
        JR	Z,J5111                 ; nope,
        PUSH	HL
        LD	HL,D6626
        RES	5,(HL)                  ; reset CR transmitted flag
        POP	HL
        AND	A
        RET
J5111:	PUSH	BC
        LD	C,A
        PUSH	DE
        CALL	C5144
        POP	DE
        JR	C,J513E
        JR	Z,J513E
        CALL	C52D9			; wait for transmitter ready
        JR	C,J513E
        CALL	C52E9			; wait for CTS (if RTS/CTS enabled)
        JR	C,J513E
        JR	Z,J513E
        LD	A,C
        LD	(D7FF8),A		; transmit data
        EI
        PUSH	HL
        LD	HL,D6626
        CP	0DH
        JR	NZ,J5139
        SET	5,(HL)                  ; set CR transmitted flag
        JR	J513B
J5139:	RES	5,(HL)                  ; reset CR transmitted flag
J513B:	POP	HL
        XOR	A
        INC	A
J513E:	CALL	C5177
        LD	A,C
        POP	BC
        RET

;	  Subroutine __________________________
;	     Inputs  ________________________
;	     Outputs ________________________

C5144:	LD	A,(D6627)
        BIT	0,A			; XON/XOFF protocol enabled ?
        JR	Z,J5174			; nope,
        LD	A,(D660E)
        LD	D,A                     ; timeout counter
J514F:	LD	E,100
J5151:	CALL	C5343			; setup channel 2 i8253 for 10 ms
J5154:	EI
        CALL	C455A                   ; check if CTRL-STOP pressed
        DI
        RET	C                       ; yep, quit
        LD	A,(D6626)
        BIT	2,A                     ; partner in XOFF mode ?
        JR	Z,J5174                 ; nope,
        LD	A,(D660E)
        AND	A                       ; timeout counter 0 ?
        JR	Z,J5154                 ; yep, no timeout
        CALL	C5351			; channel 2 i8253 finished ?
        JR	NC,J5154		; nope,
        AND	A
        DEC	E
        JR	NZ,J5151
        DEC	D
        JR	NZ,J514F
        RET
J5174:	XOR	A
        INC	A
        RET

;	  Subroutine __________________________
;	     Inputs  ________________________
;	     Outputs ________________________

C5177:	PUSH	HL
        LD	HL,D6625
        LD	(HL),00H
        JR	C,J5185
        JR	NZ,J5187
        SET	6,(HL)
        JR	J5187
J5185:	SET	2,(HL)
J5187:	POP	HL
        RET

;	  Subroutine Initialize i8251
;	     Inputs  ________________________
;	     Outputs ________________________

C5189:	XOR	A
        LD	(D7FF9),A
        PUSH	AF
        PUSH	DE
        PUSH	HL
        LD	A,0B0H			; LSB/MSB, interrupt generator, binary
        LD	DE,18
        LD	HL,I7FFE
        LD	(D7FFF),A
        LD	(HL),E
        LD	(HL),D
        LD	HL,D7FFA
J51A0:	BIT	6,(HL)			; channel 2 i8253 finished ?
        JR	Z,J51A0
        POP	HL
        POP	DE
        POP	AF
        LD	(D7FF9),A
        PUSH	AF
        PUSH	DE
        PUSH	HL
        LD	A,0B0H			; LSB/MSB, interrupt generator, binary
        LD	DE,18
        LD	HL,I7FFE
        LD	(D7FFF),A
        LD	(HL),E
        LD	(HL),D
        LD	HL,D7FFA
J51BD:	BIT	6,(HL)			; channel 2 i8253 finished ?
        JR	Z,J51BD
        POP	HL
        POP	DE
        POP	AF
        LD	(D7FF9),A
        PUSH	AF
        PUSH	DE
        PUSH	HL
        LD	A,0B0H			; LSB/MSB, interrupt generator, binary
        LD	DE,18
        LD	HL,I7FFE
        LD	(D7FFF),A
        LD	(HL),E
        LD	(HL),D
        LD	HL,D7FFA
J51DA:	BIT	6,(HL)			; channel 2 i8253 finished ?
        JR	Z,J51DA
        POP	HL
        POP	DE
        POP	AF
        LD	A,40H
        LD	(D7FF9),A
        PUSH	AF
        PUSH	DE
        PUSH	HL
        LD	A,0B0H			; LSB/MSB, interrupt generator, binary
        LD	DE,18
        LD	HL,I7FFE
        LD	(D7FFF),A
        LD	(HL),E
        LD	(HL),D
        LD	HL,D7FFA
J51F9:	BIT	6,(HL)			; channel 2 i8253 finished ?
        JR	Z,J51F9
        POP	HL
        POP	DE
        POP	AF
        LD	A,(D662A)
        LD	(D7FF9),A
        PUSH	AF
        PUSH	DE
        PUSH	HL
        LD	A,0B0H			; LSB/MSB, interrupt generator, binary
        LD	DE,18
        LD	HL,I7FFE
        LD	(D7FFF),A
        LD	(HL),E
        LD	(HL),D
        LD	HL,D7FFA
J5219:	BIT	6,(HL)			; channel 2 i8253 finished ?
        JR	Z,J5219
        POP	HL
        POP	DE
        POP	AF
        LD	A,(D7FF8)		; read receiver (empty receiver ?)
        CALL	C525C			; read status i8251 and clear error bits
        LD	A,07H			; no HUNT mode, RTS clear, ERROR RESET clear, SEND BREAK clear, RECEIVE ENABLED, DTR set, TRANSMIT ENABLED
        CALL	C531B			; write i8251 command (with error clear)
        LD	A,(D7FF8)		; read receiver (empty receiver ?)
        JP	C525C			; read status i8251 and clear error bits

;	  Subroutine RS232.SNDBRK
;	     Inputs  ________________________
;	     Outputs ________________________

C5231:	PUSH	BC
        EI
        LD	A,(D6629)		; last i8251 command
        OR	08H			; send break character flag set
        LD	B,A
J5239:	CALL	C455A                   ; check if CTRL-STOP pressed
        JR	C,J524E                 ; yep,
        CALL	C52D9			; wait for transmitter ready
        XOR	A
        LD	(D7FF8),A
        LD	A,B
        CALL	C531B			; write i8251 command (with error clear)
        DEC	DE
        LD	A,E
        OR	D
        JR	NZ,J5239
J524E:	PUSH	AF
        CALL	C52D9			; wait for transmitter ready
        LD	A,B
        AND	0F7H
        CALL	C531B			; write i8251 command (with error clear)
        EI
        POP	AF
        POP	BC
        RET

;	  Subroutine read status i8251 and clear error bits
;	     Inputs  ________________________
;	     Outputs ________________________

C525C:	LD	A,(D7FF9)		; read i8251 status
        AND	38H			; only FE,OE,PE (error) bits
        PUSH	AF
        LD	A,(D6629)		; last i8251 command
        PUSH	AF
        OR	10H			; error reset flag set
        CALL	C531B			; write i8251 command (with error clear)
        POP	AF
        LD	(D6629),A
        POP	AF
        RET

;	  Subroutine enable RTS signal
;	     Inputs  ________________________
;	     Outputs ________________________

C5271:	PUSH	AF
        LD	A,(D6629)		; last i8251 command
        SET	5,A			; RTS set
        JR	J5289

;	  Subroutine disable RTS signal
;	     Inputs  ________________________
;	     Outputs ________________________

C5279:	PUSH	AF
        LD	A,(D6627)
        BIT	1,A			; RTS/CTS handshake enabled ?
        JR	NZ,J5284		; yep,
        POP	AF
        RET

;	  Subroutine __________________________
;	     Inputs  ________________________
;	     Outputs ________________________

C5283:	PUSH	AF
J5284:	LD	A,(D6629)		; last i8251 command
        RES	5,A			; RTS reset
J5289:	CALL	C531B			; write i8251 command (with error clear)
        POP	AF
        RET

?.528E:	PUSH	AF
        LD	A,(D6629)		; last i8251 command
        SET	7,A			; enter hunt mode set
        LD	(D7FF9),A
        POP	AF
        RET

;	  Subroutine RS232.DTR
;	     Inputs  ________________________
;	     Outputs ________________________

C5299:	AND	A
        JR	Z,J52A5

;	  Subroutine enable DTR
;	     Inputs  ________________________
;	     Outputs ________________________

C529C:	DI
        PUSH	AF
        LD	A,(D6629)		; last i8251 command
        OR	02H			; DTR set
        JR	J52AC

J52A5:	DI
        PUSH	AF
        LD	A,(D6629)		; last i8251 command
        AND	0FDH			; DTR reset
J52AC:	CALL	C531B			; write i8251 command (with error clear)
        POP	AF
        RET

;	  Subroutine RS232.STAT
;	     Inputs  ________________________
;	     Outputs ________________________

C52B1:	PUSH	AF
        LD	A,(D7FFA)
        LD	L,0C3H
        XOR	L
        AND	L			; clear reserved bits
        LD	L,A
        LD	A,(D7FF9)		; read i8251 status
        AND	80H			; only DSR bit
        JR	Z,J52C3
        SET	3,L                     ; DSR
J52C3:	DI
        LD	A,(D6626)
        BIT	4,A                     ; break detected flag ?
        JR	Z,J52D2                 ; nope,
        SET	2,L                     ; break detected
        RES	4,A
        LD	(D6626),A               ; reset break detected flag
J52D2:	EI
        LD	A,(D6625)
        LD	H,A
        POP	AF
        RET

;	  Subroutine wait for transmitter ready
;	     Inputs  ________________________
;	     Outputs ________________________

C52D9:	PUSH	AF
J52DA:	EI
        NOP
        NOP
        DI
        LD	A,(D7FF9)		; read i8251 status
        AND	01H			; only TxRDY bit
        CP	01H			; transmitter ready ?
        JR	NZ,J52DA		; nope, wait
        POP	AF
        RET

;	  Subroutine wait for CTS (if RTS/CTS enabled)
;	     Inputs  ________________________
;	     Outputs ________________________

C52E9:	LD	A,(D6627)
        BIT	1,A			; RTS/CTS handshake enabled ?
        JR	Z,J5318			; nope,
        LD	A,(D660E)
        LD	D,A
J52F4:	LD	E,100
J52F6:	CALL	C5343			; setup channel 2 i8253 for 10 ms
J52F9:	CALL	C455A                   ; check if CTRL-STOP pressed
        EI
        RET	C                       ; yep, quit
        LD	A,(D7FFA)
        BIT	7,A			; CTS set ?
        JR	Z,J5318			; yep,
        LD	A,(D660E)
        AND	A
        JR	Z,J52F9
        CALL	C5351			; channel 2 i8253 finished ?
        JR	NC,J52F9		; nope,
        AND	A
        DEC	E
        JR	NZ,J52F6
        DEC	D
        JR	NZ,J52F4
        RET
J5318:	XOR	A
        INC	A
        RET

;	  Subroutine write i8251 command (with error clear)
;	     Inputs  ________________________
;	     Outputs ________________________

C531B:	LD	(D7FF9),A
        LD	(D6629),A		; save last command
        PUSH	AF
        OR	10H			; error reset flag set
        LD	(D7802),A
        POP	AF
        PUSH	AF
        PUSH	DE
        PUSH	HL
        LD	A,0B0H			; LSB/MSB, interrupt generator, binary
        LD	DE,18
        LD	HL,I7FFE
        LD	(D7FFF),A
        LD	(HL),E
        LD	(HL),D
        LD	HL,D7FFA
J533B:	BIT	6,(HL)			; channel 2 i8253 finished ?
        JR	Z,J533B
        POP	HL
        POP	DE
        POP	AF
        RET

;	  Subroutine setup channel 2 i8253 for 10 ms
;	     Inputs  ________________________
;	     Outputs ________________________

C5343:	PUSH	AF
        PUSH	BC
        PUSH	DE
        PUSH	HL
        LD	A,0B0H			; LSB/MSB, interrupt generator, binary
        LD	HL,I7FFE
        LD	DE,04800H		; 10 ms
        JR	J5366

;	  Subroutine channel 2 i8253 finished ?
;	     Inputs  ________________________
;	     Outputs ________________________

C5351:	LD	A,(D7FFA)
        RLCA
        RLCA
        RET

;	  Subroutine set baudrate channel
;	     Inputs  ________________________
;	     Outputs ________________________

C5357:	PUSH	AF
        PUSH	BC
        PUSH	DE
        PUSH	HL
        LD	B,0
        LD	HL,I7FFC
        ADD	HL,BC
        LD	A,C
        RRCA
        RRCA
        OR	36H			; LSB/MSB, square wave generator, binary
J5366:	LD	(D7FFF),A
        LD	(HL),E
        LD	(HL),D
        POP	HL
        POP	DE
        POP	BC
        POP	AF
        RET

        DEFS	06000H-$,0FFH

        END
