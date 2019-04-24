;  
;   FMPAC -> Source re-created by Z80DIS 2.2
;      Z80DIS was written by Kenneth Gielow
;                            Palo Alto, CA


; PanaSoft SW-M001	PAC SRAM cartridge
; PanaSoft SW-M004	FM + PAC SRAM cartridge

        .Z80
        ORG	4000H
D.0004	EQU	0004H
RDSLT	EQU	000CH	; -C--I
WRSLT	EQU	0014H	; -C--I
ENASLT	EQU	0024H	; -C--I
WRTVRM	EQU	004DH	; J----
FILVRM	EQU	0056H	; J----
LDIRMV	EQU	0059H	; -C---
LDIRVM	EQU	005CH	; -C---
CHGCLR	EQU	0062H	; J----
INIGRP	EQU	0072H	; -C---
CHSNS	EQU	009CH	; -C---
CHGET	EQU	009FH	; -C---
I.00FF	EQU	00FFH	; ----I
D.0100	EQU	0100H	; --S-I
I.0101	EQU	0101H	; ----I
I$010F	EQU	010FH	; ----I
RSLREG	EQU	0138H	; -C---
KILBUF	EQU	0156H	; -C---

I$4113	EQU	4113H
I$4116	EQU	4116H
I$4119	EQU	4119H
I$411F	EQU	411FH

D.5FFE	EQU	5FFEH



I$020B	EQU	020BH	; ----I
I.0230	EQU	0230H	; ----I
I$0258	EQU	0258H	; ----I
I.0301	EQU	0301H	; ----I
C$0311	EQU	0311H	; -C---
I$0417	EQU	0417H	; ----I
I.0419	EQU	0419H	; ----I
I$041B	EQU	041BH	; ----I
I$069F	EQU	069FH	; ----I
I$07BC	EQU	07BCH	; ----I
I.0820	EQU	0820H	; ----I
I.0900	EQU	0900H	; ----I
J.09A2	EQU	09A2H	; J----
J.09A4	EQU	09A4H	; J----
J$09D3	EQU	09D3H	; J----
J$0AA4	EQU	0AA4H	; J----
J$0AB2	EQU	0AB2H	; J----
I.1000	EQU	1000H	; ----I
I$1770	EQU	1770H	; ----I
I.2000	EQU	2000H	; ----I
D.2100	EQU	2100H	; ---LI
I$2121	EQU	2121H	; ----I
C$2424	EQU	2424H	; -C---
I$266B	EQU	266BH	; ----I
J$2EDF	EQU	2EDFH	; J----
C$3800	EQU	3800H	; -C---
C$39FF	EQU	39FFH	; -C---
D.3A00	EQU	3A00H	; ---L-
D$3E22	EQU	3E22H	; --S--
I$3F3F	EQU	3F3FH	; ----I
I.8000	EQU	8000H	; ----I
I.8100	EQU	8100H	; ----I
D$810E	EQU	810EH	; --S--
D.8200	EQU	8200H	; disksystem found
D.8201	EQU	8201H	; --SL-
D.8202	EQU	8202H	; --SL-
D.8204	EQU	8204H	; --SL-
D.8206	EQU	8206H	; --SL-
D.8208	EQU	8208H	; --SL-
D.820A	EQU	820AH	; --SL-
D.820B	EQU	820BH	; --SL-
D.820C	EQU	820CH	; --SL-
D.820E	EQU	820EH	; --SL-
D.8210	EQU	8210H	; --SL-
D.8211	EQU	8211H	; --SL-
D.8212	EQU	8212H	; ---LI
D.8213	EQU	8213H	; --SL-
D.8214	EQU	8214H	; --SL-
D.8215	EQU	8215H	; --SL-
D.8216	EQU	8216H	; --SLI
D.8217	EQU	8217H	; --SL-
D.8218	EQU	8218H	; --SL-
D.8219	EQU	8219H	; address patterntable in ROM-BIOS
D.821B	EQU	821BH	; address patterntable in FM-PAC
D.821D	EQU	821DH	; --SL-
D.821F	EQU	821FH	; --SL-
D.8221	EQU	8221H	; --SL-
I.8223	EQU	8223H	; ----I
D.8224	EQU	8224H	; --S-I
D.8225	EQU	8225H	; --SL-
D.8226	EQU	8226H	; --SLI
D.8227	EQU	8227H	; --SLI
D.8228	EQU	8228H	; --SL-
D.822A	EQU	822AH	; --SL-
D.822B	EQU	822BH	; --SL-
D.822C	EQU	822CH	; --SL-
D.822E	EQU	822EH	; --SL-
D.8230	EQU	8230H	; --SL-
D.8232	EQU	8232H	; --SL-
D.8234	EQU	8234H	; --SL-
D.8236	EQU	8236H	; --SL-
D.8238	EQU	8238H	; --SL-
D.823A	EQU	823AH	; --SL-
D.823C	EQU	823CH	; --SL-
D.823D	EQU	823DH	; --S-I
D.823E	EQU	823EH	; --SL-
D.823F	EQU	823FH	; --SL-
D.8240	EQU	8240H	; --SLI
D.8241	EQU	8241H	; --SLI
D.8242	EQU	8242H	; --SLI
D.8243	EQU	8243H	; ---LI
D.8244	EQU	8244H	; --SL-
D.8246	EQU	8246H	; --SL-
D.8248	EQU	8248H	; --SLI
D.8249	EQU	8249H	; ---LI
D.824A	EQU	824AH	; --SL-
D.824B	EQU	824BH	; --SL-
D.824C	EQU	824CH	; --SLI
D.824D	EQU	824DH	; --SL-
D.824E	EQU	824EH	; --SL-
D.824F	EQU	824FH	; --SL-
D.8250	EQU	8250H	; --SL-
D.8251	EQU	8251H	; --SL-
D.8252	EQU	8252H	; --SL-
D.8254	EQU	8254H	; --SL-
D.8256	EQU	8256H	; --SL-
I.8258	EQU	8258H	; ----I
D.827D	EQU	827DH	; --SL-
I.827F	EQU	827FH	; ----I
I.8280	EQU	8280H	; ----I
I$8288	EQU	8288H	; ----I
D.82A4	EQU	82A4H	; --SL-
D.82A6	EQU	82A6H	; --SLI
D.82A7	EQU	82A7H	; --SL-
D.82A9	EQU	82A9H	; --SL-
D.82AB	EQU	82ABH	; --SL-
D.82AC	EQU	82ACH	; --SL-
D.82AD	EQU	82ADH	; --SL-
D.82AE	EQU	82AEH	; --SLI
D.82AF	EQU	82AFH	; --SL-
D.82B0	EQU	82B0H	; --SL-
D.82B2	EQU	82B2H	; --SL-
D.82B4	EQU	82B4H	; --SL-
D.82B5	EQU	82B5H	; --SLI
D.82B6	EQU	82B6H	; --SLI
D.82B7	EQU	82B7H	; --SL-
D.82B8	EQU	82B8H	; --SL-
D.82BA	EQU	82BAH	; --SLI
D.82BB	EQU	82BBH	; --SLI
D.82BC	EQU	82BCH	; --SLI
D.82BD	EQU	82BDH	; --SL-
D.82BE	EQU	82BEH	; --SL-
D.82BF	EQU	82BFH	; --SLI
D.82C0	EQU	82C0H	; --SL-
D.82C2	EQU	82C2H	; --SL-
D.82C3	EQU	82C3H	; --SLI
D.82C4	EQU	82C4H	; --SL-
D.82C6	EQU	82C6H	; --SL-
D.82C8	EQU	82C8H	; number of SRAMs
D.82C9	EQU	82C9H	; table with PAC SRAM slot
I.82D9	EQU	82D9H	; table with PAC SRAM type
I.82E9	EQU	82E9H	; current primairy slot
D.82EA	EQU	82EAH	; current slotid (when slot is expanded)
D.82EB	EQU	82EBH	; current entry number
D.82EC	EQU	82ECH	; --SL-
D.82ED	EQU	82EDH	; --SL-
D.82EE	EQU	82EEH	; --SL-
D.82F0	EQU	82F0H	; --SLI
D.82F1	EQU	82F1H	; --SL-
D.82F2	EQU	82F2H	; --SL-
D.82F4	EQU	82F4H	; --SL-
D.82F6	EQU	82F6H	; --SL-
D.82F7	EQU	82F7H	; --SL-
D.82F8	EQU	82F8H	; --SL-
D.82FA	EQU	82FAH	; --SL-
D.82FC	EQU	82FCH	; --SL-
D.82FE	EQU	82FEH	; --SL-
D.82FF	EQU	82FFH	; --SL-
D.8301	EQU	8301H	; --SL-
D.8303	EQU	8303H	; --SL-
D.8304	EQU	8304H	; --SL-
D.8306	EQU	8306H	; --SL-
D.8308	EQU	8308H	; --SL-
D.830A	EQU	830AH	; --SL-
D.830B	EQU	830BH	; --SL-
D.830D	EQU	830DH	; --SL-
D.830F	EQU	830FH	; --SL-
D.8310	EQU	8310H	; --SL-
D.8311	EQU	8311H	; --S-I
D.8312	EQU	8312H	; --SL-
D.8314	EQU	8314H	; --SL-
D.8316	EQU	8316H	; --SL-
D.8318	EQU	8318H	; --SL-
D.831A	EQU	831AH	; --SL-
D.831B	EQU	831BH	; --SL-
D.831D	EQU	831DH	; --SL-
D.831E	EQU	831EH	; --SL-
D.831F	EQU	831FH	; --SL-
D.8321	EQU	8321H	; --SL-
D.8322	EQU	8322H	; current BGM
D.8323	EQU	8323H	; --SL-
D.8325	EQU	8325H	; --SL-
D.8327	EQU	8327H	; --SL-
D.8329	EQU	8329H	; --SL-
D.832B	EQU	832BH	; --SL-
D.832D	EQU	832DH	; --SL-
J.832F	EQU	832FH	; J---I
D.8334	EQU	8334H	; --SL-
D.8336	EQU	8336H	; --SL-
D.8338	EQU	8338H	; --SL-
D.833A	EQU	833AH	; --SL-
D.833C	EQU	833CH	; ---L-
D.833E	EQU	833EH	; --S-I
D.833F	EQU	833FH	; --SL-
D.8341	EQU	8341H	; --S-I
D$8343	EQU	8343H	; --S--
D.8345	EQU	8345H	; --SL-
D.8347	EQU	8347H	; --SL-
D.8349	EQU	8349H	; --SL-
D.834B	EQU	834BH	; --SL-
D.834D	EQU	834DH	; --SL-
D.834F	EQU	834FH	; --SL-
I$8500	EQU	8500H	; ----I

D$F323	EQU	0F323H	; ---L-
J$F37D	EQU	0F37DH	; J----
D$F3EB	EQU	0F3EBH	; --S--
I$F87F	EQU	0F87FH	; ----I
C$F8F8	EQU	0F8F8H	; -C---
C.F8FC	EQU	0F8FCH	; JC---
C.F9FC	EQU	0F9FCH	; -C---
D$FC4A	EQU	0FC4AH	; ---L-
I.FCC1	EQU	0FCC1H	; ----I
C$FCFC	EQU	0FCFCH	; -C---
H.TIMI	EQU	0FD9FH	; ----I
H.STKE	EQU	0FEDAH	; ----I
I$FF00	EQU	0FF00H	; ----I
I$FF80	EQU	0FF80H	; ----I
I$FF98	EQU	0FF98H	; ----I
D$FFA7	EQU	0FFA7H	; ---L-
I$FFE4	EQU	0FFE4H	; ----I
I$FFE6	EQU	0FFE6H	; ----I
J$FFE7	EQU	0FFE7H	; J----
I.FFF0	EQU	0FFF0H	; ----I
I$FFF4	EQU	0FFF4H	; ----I
I.FFF6	EQU	0FFF6H	; ----I
C.FFFF	EQU	0FFFFH	; -C--I

I.4000:	DEFB	"AB"
        DEFW	0
        DEFW	0
        DEFW	0
        DEFW	0

        DEFS	6,0

        DEFS	8,0

I.4018:	DEFB	"PAC2OPLL"


; BIOS for fmpac bank switching

C.4020:	JP	J.4064
C.4023:	JP	J$405E
C.4026:	JP	J$4048
C.4029:	JP	C.402F
C.402C:	JP	J$403D

;	  Subroutine read byte from fmpac bank
;	     Inputs  HL = adres, E = bank
;	     Outputs A = data

C.402F:	PUSH	BC
        LD	BC,D.7FF7
        LD	A,(BC)
        EX	AF,AF'
        LD	A,E
        LD	(BC),A
        LD	A,(HL)
        EX	AF,AF'
        LD	(BC),A
        EX	AF,AF'
        POP	BC
        RET

;	  Subroutine read word from fmpac bank
;	     Inputs  HL = adres, E = bank
;	     Outputs HL = data

J$403D:	CALL	C.402F
        LD	D,A
        INC	HL
        CALL	C.402F
        LD	H,A
        LD	L,D
        RET

;	  Subroutine transfer to/from fmpac bank
;	     Inputs  HL = source, DE = dest, BC = lenght, bank on stack
;	     Outputs HL = data

J$4048:	LD	A,(D.7FF7)
        EX	AF,AF'
        EXX
        POP	HL
        POP	DE
        PUSH	DE
        PUSH	HL
        LD	A,E
        EXX
        LD	(D.7FF7),A
        EX	DE,HL
        LDIR
        EX	AF,AF'
        LD	(D.7FF7),A
        RET

;	  Subroutine start routine in fmpac bank
;	     Inputs  E = bank, BC = adres
;	     Outputs depends

J$405E:	PUSH	BC
        EXX
        POP	HL
        JP	J.4064

;	  Subroutine start routine in fmpac bank
;	     Inputs  E' = bank, HL' = adres
;	     Outputs depends

J.4064:	EXX
        EX	AF,AF'
        LD	A,(D.7FF7)
        PUSH	AF
        LD	A,E
        LD	(D.7FF7),A
        LD	DE,I$4076
        PUSH	DE
        PUSH	HL
        EX	AF,AF'
        EXX
        RET

I$4076:	EX	AF,AF'
        POP	AF
        LD	(D.7FF7),A
        EX	AF,AF'
        RET

        DEFS	04080H-$,0

I.4080:	DEFW	I$74BE		; address _FMPAC handler

I.4082:	DEFB	0B8H,0D8H,0B1H,00AH
        DEFB	0BAH,0CBH,0DFH,0B0H,00AH
        DEFB	0C1H,0AAH,0DDH,0BCH,0DEH,00AH
        DEFB	0CCH,0A7H,0B2H,0D9H,009H,0BBH,0B8H,0BCH,0DEH,0AEH,00AH
        DEFB	0BDH,0DBH,0AFH,0C4H,00AH
        DEFB	"BGM"
        DEFB	0

J$40A5:	PUSH	BC
        PUSH	BC
        PUSH	BC
        PUSH	BC
        LD	C,0
        LD	DE,160
        LD	HL,I$F87F
        CALL	C.7515			; clear functionkey defintions
        LD	A,(D$FFA7)
        CP	0C9H			; disksystem ?
        JP	NZ,J$40C0		; yep,
        XOR	A
        JP	J$40C2

J$40C0:	LD	A,1
J$40C2:	LD	(D.8200),A
        CALL	C$61D9			; install diskerror handler
        CALL	C$5817			; search PAC SRAM�s
        CALL	INIGRP			; screen in graphic mode
        LD	A,5
        CALL	C$67AE			; change border color
        CALL	C$47EF			; initialize patterntables
        LD	A,1
        CALL	C.64E6			; start playing BGM 1
        CALL	C$4181
        CALL	C.6551			; stop playing BGM
        LD	C,30
        PUSH	BC
        LD	C,12
        PUSH	BC
        LD	C,9
        LD	E,3
        LD	A,20
        CALL	C.4BE4			; create window
        POP	BC
        POP	BC
        XOR	A
        LD	(D.8202),HL
        CALL	C.64E6			; start playing BGM 0
        LD	C,30
        PUSH	BC
        LD	BC,I.4082
        PUSH	BC
        LD	C,1
        PUSH	BC
        LD	HL,(D.8202)
        LD	E,0
        LD	C,0
        CALL	C.4896			; display text
        POP	BC
        POP	BC
        POP	BC
J.4110:	LD	C,01H	; 1 
        PUSH	BC
        LD	HL,(D.8202)
        LD	E,01H	; 1 
        LD	C,0FCH
        CALL	C.4E12			; activate menu
        POP	BC
        CP	6
        JP	NC,J.4110
        PUSH	AF
        CP	4
        JP	NC,J$412F
        CALL	C.6551			; stop playing BGM
        LD	(D.8201),A
J$412F:	POP	AF
        PUSH	AF
        OR	A
        JP	Z,J$4151		; clear SRAM content
        CP	1
        JP	Z,J$4157		; copy SRAM content
        CP	2
        JP	Z,J$415D		; switch SRAM content
        CP	3
        JP	Z,J$4163		; delete file
        CP	4
        JP	Z,J$4169		; display slot of SRAM
        CP	5
        JP	Z,J$416F		; select BGM
        JP	J.4172

J$4151:	CALL	C$60D2
        JP	J.4172

J$4157:	CALL	C$5CFB
        JP	J.4172

J$415D:	CALL	C$5B20
        JP	J.4172

J$4163:	CALL	C$5BBC
        JP	J.4172

J$4169:	CALL	C$6154
        JP	J.4172

J$416F:	CALL	C$6408
J.4172:	POP	AF
        CP	4
        JP	NC,J.4110
        LD	A,(D.8201)
        CALL	C.64E6			; start playing BGM
        JP	J.4110

;	  Subroutine __________________________
;	     Inputs  ________________________
;	     Outputs ________________________

C$4181:	LD	HL,-104
        ADD	HL,SP
        LD	SP,HL
        LD	C,0B5H
        PUSH	BC
        LD	C,18H
        PUSH	BC
        LD	C,20H	; " "
        LD	E,00H
        XOR	A
        CALL	C.4B29
        POP	BC
        POP	BC
        CALL	C$44A8
        LD	E,17H
J$419B:	LD	A,E
        CP	03H	; 3 
        JP	C,J$41C3
        LD	A,18H
        SUB	E
        PUSH	DE
        CP	0EH	; 14 
        JP	C,J$41AC
        LD	A,0DH	; 13 
J$41AC:	PUSH	HL
        LD	C,A
        PUSH	BC
        LD	C,14H	; 20 
        LD	A,06H	; 6 
        LD	(D.8204),HL
        CALL	C.4A22
        POP	BC
        POP	BC
        POP	DE
        DEC	E
        LD	HL,(D.8204)
        JP	J$419B
;	-----------------
J$41C3:	CALL	C.72D5			; free memory
        LD	BC,I$721A
        PUSH	BC
        LD	A,(D.7219)
        LD	C,A
        PUSH	BC
        LD	A,(D.7218)
        LD	C,A
        LD	HL,D.7219
        LD	A,18H
        SUB	(HL)
        LD	E,A
        LD	HL,D.7218
        LD	A,1EH
        SUB	(HL)
        CALL	C.4A22
        POP	BC
        POP	BC
        LD	HL,I.4000
        CALL	C.6399
        LD	C,00H
        LD	DE,104
        LD	HL,0
        ADD	HL,SP
        CALL	C.7515			; clear
        LD	A,19H
J$41F9:	CP	09H	; 9 
        JP	C,J$4215
        LD	HL,0
        ADD	HL,SP
        PUSH	AF
        PUSH	HL
        LD	C,0DH	; 13 
        PUSH	BC
        LD	E,03H	; 3 
        LD	C,01H	; 1 
C$420A	EQU	$-1
        CALL	C.4A22
        POP	BC
        POP	BC
        POP	AF
        DEC	A
        JP	J$41F9
;	-----------------
J$4215:	LD	HL,I.2000
        CALL	C.6399
        LD	A,01H	; 1 
J$421D:	CP	05H	; 5 
        JP	NC,J$4255
D$4220	EQU	$-2
        LD	BC,I$6CD4
        PUSH	AF
        PUSH	BC
        LD	C,03H	; 3 
        PUSH	BC
        LD	(D.820B),A
        ADD	A,03H	; 3 
        LD	E,A
        LD	C,03H	; 3 
        LD	A,06H	; 6 
        CALL	C.4A22
        POP	BC
        POP	BC
        LD	HL,2
        ADD	HL,SP
        PUSH	HL
        LD	C,01H	; 1 
        PUSH	BC
        LD	A,(D.820B)
        INC	A
        INC	A
        LD	E,A
        LD	C,03H	; 3 
        LD	A,06H	; 6 
        CALL	C.4A22
        POP	BC
        POP	BC
        POP	AF
        INC	A
        JP	J$421D
;	-----------------
J$4255:	LD	BC,I$6D2E
        PUSH	BC
        LD	C,01H	; 1 
        PUSH	BC
        LD	C,01H	; 1 
        LD	E,07H	; 7 
        LD	A,09H	; 9 
        CALL	C.4A22
        POP	BC
        POP	BC
        LD	BC,I.6D46
        PUSH	BC
        LD	C,01H	; 1 
        PUSH	BC
        LD	C,01H	; 1 
        LD	E,08H	; 8 
        LD	A,09H	; 9 
        CALL	C.4A22
        POP	BC
        POP	BC
        LD	BC,I.6D46
        PUSH	BC
        LD	C,01H	; 1 
        PUSH	BC
        LD	C,01H	; 1 
        LD	E,09H	; 9 
        LD	A,09H	; 9 
        CALL	C.4A22
        POP	BC
        POP	BC
        LD	BC,I$6D26
        PUSH	BC
        LD	C,01H	; 1 
        PUSH	BC
        LD	C,02H	; 2 
        LD	E,07H	; 7 
        LD	A,09H	; 9 
        CALL	C.4A22
        POP	BC
        POP	BC
        LD	BC,I.6D3E
        PUSH	BC
        LD	C,01H	; 1 
        PUSH	BC
        LD	C,02H	; 2 
        LD	E,08H	; 8 
        LD	A,09H	; 9 
        CALL	C.4A22
        POP	BC
        POP	BC
        LD	BC,I.6D3E
        PUSH	BC
        LD	C,01H	; 1 
        PUSH	BC
        LD	C,02H	; 2 
        LD	E,09H	; 9 
        LD	A,09H	; 9 
        CALL	C.4A22
        POP	BC
        POP	BC
        LD	BC,I$6D1E
        PUSH	BC
        LD	C,03H	; 3 
        PUSH	BC
        LD	C,03H	; 3 
        LD	E,07H	; 7 
        LD	A,09H	; 9 
        CALL	C.4A22
        POP	BC
        POP	BC
        LD	A,01H	; 1 
J$42D5:	CP	07H	; 7 
        JP	NC,J$430B
        LD	BC,I.6D68
        PUSH	AF
        PUSH	BC
        LD	C,03H	; 3 
        PUSH	BC
        LD	(D.820A),A
        ADD	A,06H	; 6 
        LD	E,0BH	; 11 
        LD	C,03H	; 3 
        CALL	C.4A22
        POP	BC
        POP	BC
        LD	HL,2
        ADD	HL,SP
        PUSH	HL
        LD	C,03H	; 3 
        PUSH	BC
        LD	A,(D.820A)
        ADD	A,05H	; 5 
        LD	E,0BH	; 11 
        LD	C,01H	; 1 
        CALL	C.4A22
        POP	BC
        POP	BC
        POP	AF
        INC	A
        JP	J$42D5
;	-----------------
J$430B:	LD	A,07H	; 7 
J$430D:	CP	04H	; 4 
        JP	C,J$4345
        LD	BC,I.6D68
        PUSH	AF
        PUSH	BC
        LD	C,03H	; 3 
        PUSH	BC
        LD	(D.820B),A
        ADD	A,03H	; 3 
        LD	E,A
        LD	C,03H	; 3 
        LD	A,0CH	; 12 
        CALL	C.4A22
        POP	BC
        POP	BC
        LD	HL,2
        ADD	HL,SP
        PUSH	HL
        LD	C,01H	; 1 
        PUSH	BC
        LD	A,(D.820B)
        ADD	A,06H	; 6 
        LD	E,A
        LD	C,03H	; 3 
        LD	A,0CH	; 12 
        CALL	C.4A22
        POP	BC
        POP	BC
        POP	AF
        DEC	A
        JP	J$430D
;	-----------------
J$4345:	LD	HL,I.2000
        CALL	C.6399
        LD	A,1AH
J$434D:	CP	06H	; 6 
        JP	C,J$4381
        LD	BC,I$71A0
        PUSH	AF
        PUSH	BC
        LD	C,03H	; 3 
        PUSH	BC
        LD	E,03H	; 3 
        LD	C,05H	; 5 
        LD	(D.820A),A
        CALL	C.4A22
        POP	BC
        POP	BC
        LD	HL,2
        ADD	HL,SP
        PUSH	HL
        LD	C,03H	; 3 
        PUSH	BC
        LD	A,(D.820A)
        ADD	A,05H	; 5 
        LD	E,03H	; 3 
        LD	C,01H	; 1 
        CALL	C.4A22
        POP	BC
        POP	BC
        POP	AF
        DEC	A
        JP	J$434D
;	-----------------
J$4381:	LD	C,25H	; "%"
        PUSH	AF
        PUSH	BC
        LD	C,03H	; 3 
        PUSH	BC
        LD	C,05H	; 5 
        LD	E,03H	; 3 
        LD	A,06H	; 6 
        CALL	C.4B29
        POP	BC
        POP	BC
        LD	HL,560
        CALL	C.73D3			; allocate memory
        LD	(D.8206),HL
        LD	HL,560
        CALL	C.73D3			; allocate memory
        PUSH	HL
        LD	(D.8208),HL
        LD	HL,(D.8206)
        PUSH	HL
        LD	C,07H	; 7 
        PUSH	BC
        LD	C,0AH	; 10 
        LD	E,03H	; 3 
        LD	A,06H	; 6 
        LD	(D.8206),HL
        CALL	C.4ACB
        POP	BC
        POP	BC
        POP	BC
        POP	AF
J$43BD:	CP	03H	; 3 
        JP	C,J$43DD
        PUSH	AF
        LD	HL,(D.8208)
        PUSH	HL
        LD	HL,(D.8206)
        PUSH	HL
        LD	C,7
        PUSH	BC
        LD	E,3
        LD	C,10
        CALL	C.4A63
        POP	BC
        POP	BC
        POP	BC
        POP	AF
        DEC	A
        JP	J$43BD
;	-----------------
J$43DD:	LD	HL,I.1000
        CALL	C.6399
        LD	BC,I$6C52
        PUSH	BC
        LD	BC,I$6BD2
        PUSH	BC
        LD	C,4
        PUSH	BC
        LD	C,4
        LD	E,1
        LD	A,13
        CALL	C.4A63
        POP	BC
        POP	BC
        POP	BC
        LD	HL,(D.8208)
        PUSH	HL
        PUSH	HL
        LD	HL,(D.8206)
        PUSH	HL
        LD	C,06H	; 6 
        PUSH	BC
        LD	C,04H	; 4 
        LD	E,00H
        LD	A,0DH	; 13 
        LD	(D.8206),HL
        CALL	C.4ACB
        POP	BC
        POP	BC
        POP	BC
        LD	HL,I.1000
        CALL	C.6399
        LD	A,01H	; 1 
J$441D:	CP	07H	; 7 
        JP	NC,J$443E
        PUSH	AF
        LD	HL,(D.8208)
        PUSH	HL
        LD	HL,(D.8206)
        PUSH	HL
        LD	C,6
        PUSH	BC
        LD	E,A
        LD	C,4
        LD	A,13
        CALL	C.4A63
        POP	BC
        POP	BC
        POP	BC
        POP	AF
        INC	A
        JP	J$441D
;	-----------------
J$443E:	LD	HL,D.0100
        CALL	C.6399
        POP	HL
        PUSH	HL
        PUSH	HL
        LD	HL,(D.8206)
        PUSH	HL
        LD	C,6
        PUSH	BC
        LD	C,4
        LD	E,5
        LD	A,13
        LD	(D.8206),HL
        CALL	C.4A63
        POP	BC
        POP	BC
        POP	BC
        POP	HL
        CALL	C.72D5			; free memory
        LD	HL,(D.8206)
        CALL	C.72D5			; free memory
        LD	L,02H	; 2 
        LD	A,50H	; "P"
        LD	(D.820B),A
J$446E:	CP	0B8H
        JP	NC,J$44A2
        PUSH	AF
        XOR	A
J$4475:	CP	12H	; 18 
        JP	NC,J$449A
        PUSH	AF
        LD	A,L
        ADD	A,A
        ADD	A,A
        ADD	A,A
        ADD	A,A
        LD	C,A
        LD	A,(D.820B)
        LD	E,A
        POP	AF
        PUSH	AF
        PUSH	HL
        CALL	C.4BB7
        POP	HL
        INC	L
        LD	A,L
        CP	10H	; 16 
        JP	NZ,J$4495
        LD	L,02H	; 2 
J$4495:	POP	AF
        INC	A
        JP	J$4475
;	-----------------
J$449A:	POP	AF
        INC	A
        LD	(D.820B),A
        JP	J$446E

J$44A2:	LD	HL,104
        ADD	HL,SP
        LD	SP,HL
        RET

;	  Subroutine __________________________
;	     Inputs  ________________________
;	     Outputs ________________________

C$44A8:	LD	HL,2080
        CALL	C.73D3			; allocate memory
        LD	DE,2080
        LD	C,00H
        LD	(D.820C),HL
        PUSH	HL
        CALL	C.7515			; clear
        LD	BC,I$6CD2
        PUSH	BC
        LD	HL,(D.820C)
        LD	E,00H
        LD	C,00H
        LD	(D.820C),HL
        CALL	C.4525
        POP	BC
        LD	BC,I$6D1C
        PUSH	BC
        LD	HL,(D.820C)
        LD	E,00H
        LD	C,04H	; 4 
        LD	(D.820C),HL
        CALL	C.4525
        POP	BC
        LD	BC,I$6D66
        PUSH	BC
        LD	HL,(D.820C)
        LD	E,00H
        LD	C,08H	; 8 
        LD	(D.820C),HL
        CALL	C.4525
        POP	BC
        LD	BC,I$6DB0
        PUSH	BC
        LD	HL,(D.820C)
        LD	E,03H	; 3 
        LD	C,00H
        LD	(D.820C),HL
        CALL	C.4525
        POP	BC
        LD	BC,I$6E42
        PUSH	BC
        LD	HL,(D.820C)
        LD	E,03H	; 3 
        LD	C,04H	; 4 
        LD	(D.820C),HL
        CALL	C.4525
        POP	BC
        LD	BC,I$6FDC
        PUSH	BC
        LD	HL,(D.820C)
        LD	E,03H	; 3 
        LD	C,08H	; 8 
        CALL	C.4525
        POP	BC
        POP	HL
        RET

;	  Subroutine __________________________
;	     Inputs  ________________________
;	     Outputs ________________________

C.4525:	PUSH	HL
        LD	L,C
        LD	A,E
        POP	DE
        LD	H,0
        ADD	HL,HL
        ADD	HL,HL			; *4
        LD	C,L
        LD	B,H
        ADD	HL,HL
        ADD	HL,HL			; *16
        ADD	HL,BC			; *20
        LD	C,A
        LD	B,0
        ADD	HL,BC			; +
        ADD	HL,HL
        ADD	HL,HL
        ADD	HL,HL
        ADD	HL,DE
        LD	(D.820E),HL
        CALL	C.75D2			; get word from stack at offset 2
        INC	HL
        CALL	C.75AD			; put word on stack at offset 2
        DEC	HL
        LD	C,(HL)
        CALL	C.75D2			; get word from stack at offset 2
        INC	HL
        CALL	C.75AD			; put word on stack at offset 2
        DEC	HL
        LD	A,(HL)
        LD	(D.8210),A
        LD	L,C
        LD	H,00H
        ADD	HL,HL
        ADD	HL,HL
        ADD	HL,HL
        LD	C,L
        LD	B,H
J$455A:	LD	A,(D.8210)
        DEC	A
        LD	(D.8210),A
        INC	A
        RET	Z
        CALL	C.75D2			; get word from stack at offset 2
        PUSH	HL
        LD	HL,(D.820E)
        LD	E,L
        LD	D,H
        LD	(D.820E),HL
        POP	HL
        PUSH	BC
        CALL	C.7525			; copy data
        LD	HL,(D.820E)
        LD	BC,160
        ADD	HL,BC
        LD	(D.820E),HL
        CALL	C.75CC			; get word from stack at offset 4
        POP	BC
        ADD	HL,BC
        CALL	C.75AD			; put word on stack at offset 2
        JP	J$455A

;	  Subroutine __________________________
;	     Inputs  ________________________
;	     Outputs ________________________

C.4589:	OR	A
        JP	NZ,J$45A8
        LD	C,01H	; 1 
        PUSH	BC
        LD	C,6CH	; "l"
        LD	E,0B4H
        LD	A,50H	; "P"
        CALL	C.4611
        POP	BC
        LD	C,00H
        PUSH	BC
        LD	C,6CH	; "l"
        LD	E,0B4H
        LD	A,50H	; "P"
        CALL	C.4611
        POP	BC
        RET
;	-----------------
J$45A8:	LD	C,01H	; 1 
        PUSH	BC
        LD	C,74H	; "t"
        LD	E,0B4H
        LD	A,64H	; "d"
        CALL	C.4611
        POP	BC
        LD	C,01H	; 1 
        PUSH	BC
        LD	C,7CH	; "|"
        LD	E,0B4H
        LD	A,3CH	; "<"
        CALL	C.4611
        POP	BC
        LD	C,00H
        PUSH	BC
        LD	C,74H	; "t"
        LD	E,0B4H
        LD	A,64H	; "d"
        CALL	C.4611
        POP	BC
        LD	C,00H
        PUSH	BC
        LD	C,7CH	; "|"
        LD	E,0B4H
        LD	A,3CH	; "<"
        CALL	C.4611
        POP	BC
        RET
;	-----------------
I$45DD:	DEFB	0,0
        LD	D,00H
        INC	L
        NOP
        LD	B,B
        NOP
        LD	D,D
        NOP
        LD	H,D
        NOP
        LD	L,A
        NOP
        LD	A,B
        NOP
        LD	A,A
        NOP
I$45EF:	ADD	A,B
        NOP
        LD	A,A
        NOP
        LD	A,B
        NOP
        LD	L,A
        NOP
        LD	H,D
        NOP
        LD	D,D
        NOP
        LD	B,B
        NOP
        INC	L
        NOP
        LD	D,00H
I$4601:	LD	BC,D.0100
        NOP
        RST	38H
        RST	38H
        RST	38H
        RST	38H
I$4609:	RST	38H
        RST	38H
        LD	BC,I$FF00
        RST	38H
        LD	BC,D.2100
C.4611	EQU	$-1
        CALL	C,C$39FF
        LD	SP,HL
        LD	(D.8211),A
        LD	A,C
        LD	(D.8213),A
        XOR	A
J$461E:	CP	09H	; 9 
        JP	NC,J$4645
        LD	L,A
        LD	H,00H
        ADD	HL,HL
        EX	DE,HL
        LD	HL,18
        ADD	HL,SP
        ADD	HL,DE
        LD	(HL),00H
        INC	HL
        LD	(HL),00H
        LD	L,A
        LD	H,00H
        ADD	HL,HL
        EX	DE,HL
        LD	HL,0
        ADD	HL,SP
        ADD	HL,DE
        LD	(HL),00H
        INC	HL
        LD	(HL),00H
        INC	A
        JP	J$461E
;	-----------------
J$4645:	LD	HL,38
        ADD	HL,SP
        LD	A,(HL)
        DEC	A
        JP	NZ,J$4683
        LD	E,0B4H
J$4650:	LD	A,(D.8213)
        CP	E
        JP	NC,J$4665
        LD	A,(D.8211)
        LD	C,01H	; 1 
        PUSH	DE
        CALL	C.4B69
        POP	DE
        DEC	E
        JP	J$4650
;	-----------------
J$4665:	LD	E,0B4H
        LD	HL,D.8212
        LD	(HL),E
J$466B:	CP	E
        JP	NC,J$468B
        PUSH	AF
        LD	A,(D.8211)
        LD	C,00H
        PUSH	DE
        CALL	C.4B69
        POP	DE
        DEC	E
        LD	HL,D.8212
        LD	(HL),E
        POP	AF
        JP	J$466B
;	-----------------
J$4683:	LD	A,(D.8213)
        LD	E,A
        LD	HL,D.8212
        LD	(HL),E
J$468B:	XOR	A
J$468C:	CP	0CH	; 12 
        JP	NC,J$4771
        PUSH	AF
        XOR	A
J$4693:	CP	09H	; 9 
        JP	NC,J$46E2
        LD	L,A
        LD	H,00H
        ADD	HL,HL
        EX	DE,HL
        LD	HL,2
        ADD	HL,SP
        ADD	HL,DE
        LD	E,(HL)
        INC	HL
        LD	D,(HL)
        PUSH	AF
        PUSH	HL
        LD	L,A
        LD	H,00H
        ADD	HL,HL
        LD	BC,I$45DD
        ADD	HL,BC
        LD	A,(HL)
        INC	HL
        LD	H,(HL)
        LD	L,A
        ADD	HL,HL
        ADD	HL,DE
        EX	DE,HL
        POP	HL
        LD	(HL),D
        DEC	HL
        LD	(HL),E
        POP	AF
        LD	L,A
        LD	H,00H
        ADD	HL,HL
        EX	DE,HL
        LD	HL,20
        ADD	HL,SP
        ADD	HL,DE
        LD	E,(HL)
        INC	HL
        LD	D,(HL)
        PUSH	AF
        PUSH	HL
        LD	L,A
        LD	H,00H
        ADD	HL,HL
        LD	BC,I$45EF
        ADD	HL,BC
        LD	A,(HL)
        INC	HL
        LD	H,(HL)
        LD	L,A
        ADD	HL,HL
        ADD	HL,DE
        EX	DE,HL
        POP	HL
        LD	(HL),D
        DEC	HL
        LD	(HL),E
        POP	AF
        INC	A
        JP	J$4693
;	-----------------
J$46E2:	LD	L,00H
J$46E4:	LD	A,L
        CP	04H	; 4 
        JP	NC,J$476C
        XOR	A
J$46EB:	CP	09H	; 9 
        JP	NC,J$4768
        PUSH	AF
        LD	H,00H
        PUSH	AF
        LD	A,L
        LD	(D.8214),A
        POP	AF
        ADD	HL,HL
        LD	BC,I$4609
        ADD	HL,BC
        LD	E,(HL)
        INC	HL
        LD	D,(HL)
        PUSH	DE
        LD	L,A
        LD	H,00H
        ADD	HL,HL
        EX	DE,HL
        LD	HL,24
        ADD	HL,SP
        ADD	HL,DE
        LD	(D.8215),A
        LD	A,(HL)
        INC	HL
        LD	H,(HL)
        LD	L,A
        LD	B,7
        CALL	C.7533			; / 128
        POP	DE
        CALL	C.758D			; multiply (16 bit)
        LD	A,(D.8212)
        LD	E,A
        LD	D,00H
        ADD	HL,DE
        PUSH	HL
        LD	HL,(D.8214)
        LD	H,00H
        LD	A,L
        LD	(D.8214),A
        ADD	HL,HL
        LD	BC,I$4601
        ADD	HL,BC
        LD	E,(HL)
        INC	HL
        LD	D,(HL)
        PUSH	DE
        LD	HL,(D.8215)
        LD	H,00H
        ADD	HL,HL
        EX	DE,HL
        LD	HL,8
        ADD	HL,SP
        ADD	HL,DE
        LD	A,(HL)
        INC	HL
        LD	H,(HL)
        LD	L,A
        LD	B,7
        CALL	C.7533			; / 128
        POP	DE
        CALL	C.758D			; multiply (16 bit)
        LD	A,(D.8211)
        LD	E,A
        LD	D,00H
        ADD	HL,DE
        LD	A,L
        LD	HL,44
        ADD	HL,SP
        LD	C,(HL)
        POP	DE
        CALL	C.4B69
        POP	AF
        INC	A
        LD	HL,(D.8214)
        JP	J$46EB
;	-----------------
J$4768:	INC	L
        JP	J$46E4
;	-----------------
J$476C:	POP	AF
        INC	A
        JP	J$468C
;	-----------------
J$4771:	LD	HL,36
        ADD	HL,SP
        LD	SP,HL
        RET
;	-----------------

;	  Subroutine __________________________
;	     Inputs  ________________________
;	     Outputs ________________________

C$4777:	LD	A,(D.8216)
        CP	10H	; 16 
        JP	NC,J$4786
        LD	A,(D.8216)
        OR	A
        JP	NZ,J$478B
J$4786:	LD	A,01H	; 1 
        LD	(D.8216),A
J$478B:	LD	A,(D.8216)
        CP	05H	; 5 
        JP	NZ,J$4798
        LD	A,06H	; 6 
        LD	(D.8216),A
J$4798:	LD	A,(D.8216)
        ADD	A,A
        ADD	A,A
        ADD	A,A
        ADD	A,A
        LD	(D.8216),A
        XOR	A
        LD	(D.8218),A
J$47A6:	CP	18H
        JP	NC,J$47DE
        XOR	A
        LD	(D.8217),A
J$47AF:	CP	06H	; 6 
        JP	NC,J$47D4
        CALL	C.67B8
        OR	A
        RET	NZ
        LD	A,(D.8218)
        ADD	A,18H
        LD	E,A
        LD	A,(D.8216)
        LD	C,A
        LD	A,(D.8217)
        PUSH	AF
        ADD	A,03H	; 3 
        CALL	C.4BB7
        POP	AF
        INC	A
        LD	(D.8217),A
        JP	J$47AF
;	-----------------
J$47D4:	LD	A,(D.8218)
        INC	A
        LD	(D.8218),A
        JP	J$47A6
;	-----------------
J$47DE:	LD	A,(D.8216)
        RRCA
        RRCA
        RRCA
        RRCA
        AND	0FH	; 15 
        LD	(D.8216),A
        LD	HL,D.8216
        INC	(HL)
        RET

;	  Subroutine __________________________
;	     Inputs  ________________________
;	     Outputs ________________________

C$47EF:	LD	HL,(D.0004)
        LD	(D.8219),HL		; address patterntable in ROM-BIOS
        LD	E,3			; bank 3
        LD	HL,I.4080
        CALL	C.402C			; read word from FMPAC bank
        LD	(D.821B),HL		; address patterntable in FM-PAC
        RET

;	  Subroutine get patterndata
;	     Inputs  BC = buffer, E = ?, A = char
;	     Outputs ________________________

C.4801:	LD	L,E
        LD	E,C
        LD	D,B
        EX	DE,HL
        LD	(D.821D),HL
        EX	DE,HL
        INC	L
        DEC	L
        JP	Z,J.4830
        CP	21H
        JP	C,J.4830
        LD	C,3			; bank 3
        PUSH	BC
        SUB	21H
        LD	L,A
        LD	H,00H
        ADD	HL,HL
        ADD	HL,HL
        ADD	HL,HL
        ADD	HL,HL
        EX	DE,HL
        LD	HL,(D.821B)		; address patterntable in FM-PAC
        ADD	HL,DE
        EX	DE,HL
        LD	HL,(D.821D)
        LD	BC,16			; 16 bytes
        CALL	C.4026			; transfer from/to FMPAC bank
        POP	BC
        RET

J.4830:	PUSH	HL
        CALL	C$486A			; get pattern data character
        POP	HL
        INC	L
        DEC	L
        RET	Z
        LD	E,16
        LD	L,8
J$483C:	DEC	L
        LD	A,L
        INC	A
        RET	Z
        LD	H,0
        PUSH	HL
        PUSH	HL
        LD	HL,(D.821D)
        LD	C,L
        LD	B,H
        POP	HL
        ADD	HL,BC
        LD	A,(HL)
        DEC	E
        LD	L,E
        LD	H,0
        ADD	HL,BC
        LD	(HL),A
        POP	HL
        LD	H,0
        PUSH	HL
        ADD	HL,BC
        LD	A,(HL)
        DEC	E
        LD	L,E
        LD	H,0
        ADD	HL,BC
        LD	(HL),A
        POP	HL
        JP	J$483C

I$4862:	DEFB	000H,07EH,07EH,07EH,07EH,07EH,07EH,000H

;	  Subroutine __________________________
;	     Inputs  ________________________
;	     Outputs ________________________

C$486A:	CP	1
        JP	NZ,J$4879
        LD	BC,8
        LD	HL,I$4862
        CALL	C.7525			; copy data
        RET

J$4879:	LD	L,A
        LD	H,00H
        ADD	HL,HL
        ADD	HL,HL
        ADD	HL,HL
        PUSH	HL
        LD	HL,(D.8219)		; address patterntable in ROM-BIOS
        EX	DE,HL
        LD	(D.821F),HL
        EX	DE,HL
        POP	DE
        ADD	HL,DE
        EX	DE,HL
        LD	HL,(D.821F)
        EX	DE,HL
        LD	BC,8
        CALL	C.7525			; copy data
        RET

;	  Subroutine display text
;	     Inputs  ________________________
;	     Outputs ________________________

C.4896:	LD	A,C
        LD	(D.8224),A
        LD	C,L
        LD	B,H
        LD	HL,6
        ADD	HL,SP
        LD	L,(HL)
        PUSH	HL
        LD	HL,I.8223
        LD	(HL),E
        CALL	C.75C6			; get word from stack at offset 6
        PUSH	HL
        LD	HL,1
        ADD	HL,BC
        LD	A,(HL)
        LD	L,C
        LD	H,B
        LD	(D.8221),HL
        LD	HL,D.8224
        LD	C,(HL)
        ADD	A,C
        INC	A
        LD	E,A
        PUSH	DE
        LD	HL,(D.8221)
        LD	C,L
        LD	B,H
        LD	A,(BC)
        LD	HL,I.8223
        LD	E,(HL)
        ADD	A,E
        INC	A
        LD	HL,8
        ADD	HL,SP
        LD	C,(HL)
        POP	DE
        CALL	C$48D4
        POP	BC
        POP	BC
        RET

;	  Subroutine __________________________
;	     Inputs  ________________________
;	     Outputs ________________________

C$48D4:	LD	HL,-16
        ADD	HL,SP
        LD	SP,HL
        LD	HL,D.8227
        LD	(HL),C
        LD	HL,D.8226
        LD	(HL),E
        LD	(D.8225),A
        PUSH	AF
        XOR	A
        LD	(D.822B),A
        POP	AF
        LD	C,A
        LD	B,00H
        LD	L,C
        LD	H,B
        LD	(D.8228),HL
J.48F2:	CALL	C.75DE
        DEFW	18+2 			; get word from stack at offset 18
        INC	HL
        CALL	C.75B3
        DEFW	18+2 			; put word on stack at offset 18
        DEC	HL
        LD	A,(HL)
        LD	(D.822A),A
        OR	A			; end of string ?
        JP	Z,J$49C1		; yep, quit
        CP	9
        JP	Z,J$4918
        CP	10
        JP	Z,J$4924
        CP	13
        JP	Z,J$493D
        JP	J$4951

J$4918:	LD	A,1
        LD	HL,(D.822B)
        SUB	L
        LD	(D.822B),A
        JP	J.48F2

J$4924:	XOR	A
        LD	(D.822B),A
        LD	HL,(D.8228)
        LD	A,L
        LD	(D.8225),A
        LD	A,(D.8227)
        INC	A
        LD	HL,(D.8226)
        ADD	A,L
        LD	(D.8226),A
        JP	J.48F2

J$493D:	CALL	C.75DE
        DEFW	18+2			; get word from stack at offset 18
        LD	A,(HL)
        INC	HL
        CALL	C.75B3
        DEFW	18+2			; put word on stack at offset 18
        LD	HL,20
        ADD	HL,SP
        LD	(HL),A
        JP	J.48F2
;	-----------------
J$4951:	CP	0A6H
        JP	C,J$495B
        CP	0B0H
        JP	C,J$4965
J$495B:	CP	0B1H
        JP	C,J.4981
        CP	0DEH
        JP	NC,J.4981
J$4965:	LD	A,(D.822B)
        OR	A
        JP	Z,J.4981
        LD	A,(D.822A)
        CP	0C0H
        JP	NC,J$497C
        SUB	20H
        LD	(D.822A),A
        JP	J.4981

J$497C:	ADD	A,20H
        LD	(D.822A),A
J.4981:	LD	A,(D.8227)
        LD	E,A
        LD	(D.8227),A
        LD	A,(D.822A)
        LD	HL,0
        ADD	HL,SP
        LD	C,L
        LD	B,H
        CALL	C.4801			; get patterndata
        LD	HL,20
        ADD	HL,SP
        LD	L,(HL)
        PUSH	HL
        LD	HL,2
        ADD	HL,SP
        PUSH	HL
        LD	A,(D.8227)
        INC	A
        LD	C,A
        PUSH	BC
        LD	A,(D.8226)
        LD	E,A
        LD	A,(D.8225)
        LD	C,01H	; 1 
        LD	(D.8225),A
        CALL	C.49C7
        POP	BC
        POP	BC
        POP	BC
        LD	A,(D.8225)
        INC	A
        LD	(D.8225),A
        JP	J.48F2

J$49C1:	LD	HL,16
        ADD	HL,SP
        LD	SP,HL
        RET

;	  Subroutine __________________________
;	     Inputs  ________________________
;	     Outputs ________________________

C.49C7:	LD	B,E
        PUSH	BC
        LD	C,00H
        LD	L,A
        LD	H,00H
        ADD	HL,HL
        ADD	HL,HL
        ADD	HL,HL
        ADD	HL,BC
        LD	(D.822C),HL
        LD	A,H
        OR	20H	; " "
        LD	H,A
        LD	(D.822E),HL
        POP	HL
        LD	H,00H
        ADD	HL,HL
        ADD	HL,HL
        ADD	HL,HL
        LD	C,L
        LD	B,H
J$49E4:	LD	HL,2
        ADD	HL,SP
        DEC	(HL)
        LD	A,(HL)
        INC	A
        RET	Z
        CALL	C.75CC			; get word from stack at offset 4
        PUSH	HL
        LD	HL,(D.822C)
        LD	E,L
        LD	D,H
        LD	(D.822C),HL
        POP	HL
        PUSH	BC
        CALL	LDIRVM
        POP	BC
        LD	HL,6
        ADD	HL,SP
        LD	E,(HL)
        LD	HL,(D.822E)
        PUSH	BC
        PUSH	HL
        CALL	C.67AA			; fill vram
        LD	HL,(D.822C)
        INC	H
        LD	(D.822C),HL
        POP	HL
        INC	H
        LD	(D.822E),HL
        CALL	C.75C6			; get word from stack at offset 6
        POP	BC
        ADD	HL,BC
        CALL	C.75A7			; put word on stack at offset 4
        JP	J$49E4

;	  Subroutine __________________________
;	     Inputs  ________________________
;	     Outputs ________________________

C.4A22:	LD	B,E
        PUSH	BC
        LD	C,00H
        LD	L,A
        LD	H,00H
        ADD	HL,HL
        ADD	HL,HL
        ADD	HL,HL
        ADD	HL,BC
        LD	(D.8230),HL
        POP	HL
I$4A31:	LD	H,00H
        ADD	HL,HL
        ADD	HL,HL
        ADD	HL,HL
        LD	C,L
        LD	B,H
J$4A38:	LD	HL,2
        ADD	HL,SP
        DEC	(HL)
        LD	A,(HL)
        INC	A
        RET	Z
        CALL	C.75CC			; get word from stack at offset 4
        PUSH	HL
        LD	HL,(D.8230)
        LD	E,L
        LD	D,H
        LD	(D.8230),HL
        POP	HL
        PUSH	BC
        CALL	LDIRVM
        LD	HL,(D.8230)
        INC	H
        LD	(D.8230),HL
        CALL	C.75C6			; get word from stack at offset 6
        POP	BC
        ADD	HL,BC
        CALL	C.75A7			; put word on stack at offset 4
        JP	J$4A38
;	-----------------

;	  Subroutine __________________________
;	     Inputs  ________________________
;	     Outputs ________________________

C.4A63:	LD	B,E
        PUSH	BC
        LD	C,0
        LD	L,A
        LD	H,00H
        ADD	HL,HL
        ADD	HL,HL
        ADD	HL,HL
        ADD	HL,BC
        LD	(D.8232),HL
        LD	A,H
        OR	20H	; " "
        LD	H,A
        LD	(D.8234),HL
        POP	HL
        LD	H,00H
        ADD	HL,HL
        ADD	HL,HL
        ADD	HL,HL
        LD	C,L
        LD	B,H
J$4A80:	LD	HL,2
        ADD	HL,SP
        DEC	(HL)
        LD	A,(HL)
        INC	A
        RET	Z
        CALL	C.75CC			; get word from stack at offset 4
        PUSH	HL
        LD	HL,(D.8232)
        LD	E,L
        LD	D,H
        LD	(D.8232),HL
        POP	HL
        PUSH	BC
        CALL	LDIRVM
        POP	BC
        CALL	C.75C6			; get word from stack at offset 6
        PUSH	HL
        LD	HL,(D.8234)
        LD	E,L
        LD	D,H
        LD	(D.8234),HL
        POP	HL
        PUSH	BC
        CALL	LDIRVM
        LD	HL,(D.8232)
        INC	H
        LD	(D.8232),HL
        LD	HL,(D.8234)
        INC	H
        LD	(D.8234),HL
        CALL	C.75C6			; get word from stack at offset 6
        POP	BC
        ADD	HL,BC
        CALL	C.75A7			; put word on stack at offset 4
        CALL	C.75C6			; get word from stack at offset 6
        ADD	HL,BC
        CALL	C.75A1			; put word on stack at offset 6
        JP	J$4A80

;	  Subroutine __________________________
;	     Inputs  ________________________
;	     Outputs ________________________

C.4ACB:	LD	B,E
        PUSH	BC
        LD	C,00H
        LD	L,A
        LD	H,00H
        ADD	HL,HL
        ADD	HL,HL
        ADD	HL,HL
        ADD	HL,BC
        LD	(D.8236),HL
        LD	A,H
        OR	20H	; " "
        LD	H,A
        LD	(D.8238),HL
        POP	HL
        LD	H,00H
        ADD	HL,HL
        ADD	HL,HL
        ADD	HL,HL
        LD	C,L
        LD	B,H
J$4AE8:	LD	HL,2
        ADD	HL,SP
        DEC	(HL)
        LD	A,(HL)
        INC	A
        RET	Z
        CALL	C.75CC			; get word from stack at offset 4
        EX	DE,HL
        LD	HL,(D.8236)
        PUSH	BC
        LD	(D.8236),HL
        CALL	LDIRMV
        POP	BC
        CALL	C.75C6			; get word from stack at offset 6
        EX	DE,HL
        LD	HL,(D.8238)
        PUSH	BC
        PUSH	HL
        CALL	LDIRMV
        LD	HL,(D.8236)
        INC	H
        LD	(D.8236),HL
        POP	HL
        INC	H
        LD	(D.8238),HL
        CALL	C.75C6			; get word from stack at offset 6
        POP	BC
        ADD	HL,BC
        CALL	C.75A7			; put word on stack at offset 4
        CALL	C.75C6			; get word from stack at offset 6
        ADD	HL,BC
        CALL	C.75A1			; put word on stack at offset 6
        JP	J$4AE8
;	-----------------

;	  Subroutine __________________________
;	     Inputs  ________________________
;	     Outputs ________________________

C.4B29:	LD	B,E
        PUSH	BC
        LD	C,00H
        LD	L,A
        LD	H,00H
        ADD	HL,HL
        ADD	HL,HL
        ADD	HL,HL
        ADD	HL,BC
        LD	A,H
        OR	20H	; " "
        LD	H,A
        LD	(D.823A),HL
        POP	HL
        LD	H,00H
        ADD	HL,HL
        ADD	HL,HL
        ADD	HL,HL
        LD	C,L
        LD	B,H
J$4B43:	LD	HL,2
        ADD	HL,SP
        DEC	(HL)
        LD	A,(HL)
        INC	A
        RET	Z
        LD	HL,4
        ADD	HL,SP
        LD	E,(HL)
        LD	HL,(D.823A)
        PUSH	BC
        PUSH	HL
        CALL	C.67AA			; fill vram
        POP	HL
        INC	H
        LD	(D.823A),HL
        POP	BC
        JP	J$4B43
;	-----------------
I$4B61:	ADD	A,B
        LD	B,B
        JR	NZ,J$4B75
        EX	AF,AF'
        INC	B
        LD	(BC),A
        LD	BC,I$266B
C.4B69	EQU	$-2
        NOP
        LD	(D.823C),A
        LD	A,L
        AND	07H	; 7 
        LD	E,A
        LD	D,00H
J$4B75:	PUSH	DE
        LD	H,0
        LD	B,3
        LD	A,C
        LD	(D.823D),A
        CALL	C.7533			; / 8
        LD	D,L
        LD	E,00H
        LD	HL,(D.823C)
        LD	H,0
        LD	B,3
        LD	A,L
        LD	(D.823C),A
        CALL	C.7533			; / 8
        ADD	HL,HL
        ADD	HL,HL
        ADD	HL,HL
        ADD	HL,DE
        POP	DE
        ADD	HL,DE
        EX	DE,HL
        LD	HL,D.823D
        LD	C,(HL)
        LD	A,(D.823C)
        INC	C
        DEC	C
        JP	Z,J$4BB2
        AND	07H	; 7 
        LD	L,A
        LD	H,00H
        LD	BC,I$4B61
        ADD	HL,BC
        LD	A,(HL)
        JP	J$4BB3			; write vram

J$4BB2:	XOR	A
J$4BB3:	CALL	C.67B4			; write vram
        RET

;	  Subroutine __________________________
;	     Inputs  ________________________
;	     Outputs ________________________

C.4BB7:	LD	L,E
        LD	H,00H
        LD	(D.823E),A
        LD	A,L
        AND	07H	; 7 
        LD	E,A
        LD	D,00H
        LD	H,0
        LD	B,3
        PUSH	BC
        CALL	C.7533			; /8
        LD	B,L
        LD	C,00H
        LD	HL,(D.823E)
        LD	H,00H
        ADD	HL,HL
        ADD	HL,HL
        ADD	HL,HL
        ADD	HL,BC
        ADD	HL,DE
        LD	A,H
        OR	20H	; " "
        LD	H,A
        EX	DE,HL
        DEC	SP
        POP	AF
        INC	SP
        CALL	C.67B4			; write vram
        RET

;	  Subroutine __________________________
;	     Inputs  ________________________
;	     Outputs ________________________

C.4BE4:	LD	HL,-16
        ADD	HL,SP
        LD	SP,HL
        LD	HL,8
        LD	(D.823F),A
        LD	A,E
        LD	(D.8240),A
        PUSH	BC
        CALL	C.73D3			; allocate memory
        EX	DE,HL
        LD	A,(D.823F)
        DEC	A
        LD	(DE),A
        LD	(D.823F),A
        LD	A,(D.8240)
        DEC	A
        LD	HL,1
        ADD	HL,DE
        LD	(HL),A
        LD	(D.8240),A
        POP	BC
        INC	C
        INC	C
        LD	HL,2
        ADD	HL,DE
        LD	(HL),C
        LD	HL,18
        ADD	HL,SP
        LD	A,(HL)
        INC	A
        INC	A
        LD	HL,18
        ADD	HL,SP
        LD	(HL),A
        LD	HL,3
        ADD	HL,DE
        LD	(HL),A
        LD	HL,18
        ADD	HL,SP
        EX	DE,HL
        LD	(D.8244),HL
        EX	DE,HL
        LD	E,(HL)
        LD	D,00H
        LD	L,C
        LD	H,00H
        PUSH	BC
        CALL	C.758D			; multiply (16 bit)
        ADD	HL,HL
        ADD	HL,HL
        ADD	HL,HL
        CALL	C.73D3			; allocate memory
        PUSH	HL
        LD	HL,(D.8244)
        EX	DE,HL
        LD	HL,4
        ADD	HL,DE
        EX	DE,HL
        LD	(D.8244),HL
        EX	DE,HL
        POP	DE
        LD	(HL),E
        INC	HL
        LD	(HL),D
        LD	HL,20
        ADD	HL,SP
        LD	E,(HL)
        LD	D,00H
        POP	HL
        LD	H,00H
        LD	A,L
        LD	(D.8241),A
        CALL	C.758D			; multiply (16 bit)
        ADD	HL,HL
        ADD	HL,HL
        ADD	HL,HL
        CALL	C.73D3			; allocate memory
        EX	DE,HL
        LD	HL,(D.8244)
        LD	C,L
        LD	B,H
        LD	HL,6
        ADD	HL,BC
        LD	(HL),E
        INC	HL
        LD	(HL),D
        LD	HL,6
        ADD	HL,BC
        PUSH	HL
        LD	L,C
        LD	H,B
        LD	(D.8244),HL
        POP	HL
        PUSH	BC
        LD	C,(HL)
        INC	HL
        LD	B,(HL)
        PUSH	BC
        LD	HL,(D.8244)
        EX	DE,HL
        LD	HL,4
        ADD	HL,DE
        LD	C,(HL)
        INC	HL
        LD	B,(HL)
        PUSH	BC
        LD	HL,24
        ADD	HL,SP
        LD	L,(HL)
        PUSH	HL
        LD	HL,D.8241
        LD	C,(HL)
        LD	HL,D.8240
        LD	E,(HL)
        LD	A,(D.823F)
        CALL	C.4ACB
        POP	BC
        POP	BC
        POP	BC
        LD	HL,2
        ADD	HL,SP
        LD	C,L
        LD	B,H
        LD	E,0
        LD	A,20H
        CALL	C.4801			; get patterndata
        XOR	A
        LD	(D.8242),A
J$4CB8:	LD	HL,(D.8241)
        CP	L
        JP	NC,J$4DBD		; quit
        LD	E,00H
        LD	HL,D.8243
        LD	(HL),E
J$4CC5:	LD	A,E
        LD	HL,20
        ADD	HL,SP
        CP	(HL)
        JP	NC,J$4DB3
        PUSH	DE
        LD	HL,(D.8242)
        INC	L
        DEC	L
        JP	NZ,J.4CE1
        INC	E
        DEC	E
        JP	NZ,J.4CE1
        LD	A,18H
        JP	J.4D73
;	-----------------
J.4CE1:	INC	L
        DEC	L
        JP	NZ,J.4CF7
        PUSH	HL
        LD	HL,24
        ADD	HL,SP
        LD	A,(HL)
        DEC	A
        POP	HL
        CP	E
        JP	NZ,J.4CF7
        LD	A,1AH
        JP	J.4D73
;	-----------------
J.4CF7:	LD	A,(D.8241)
        DEC	A
        CP	L
        JP	NZ,J.4D09
        INC	E
        DEC	E
        JP	NZ,J.4D09
        LD	A,19H
        JP	J.4D73
;	-----------------
J.4D09:	LD	A,(D.8241)
        DEC	A
        CP	L
        JP	NZ,J.4D22
        PUSH	HL
        LD	HL,24
        ADD	HL,SP
        LD	A,(HL)
        DEC	A
        POP	HL
        CP	E
        JP	NZ,J.4D22
        LD	A,1BH
        JP	J.4D73
;	-----------------
J.4D22:	INC	L
        DEC	L
        JP	Z,J$4D2F
        LD	A,(D.8241)
        DEC	A
        CP	L
        JP	NZ,J$4D34
J$4D2F:	LD	A,16H
        JP	J.4D73
;	-----------------
J$4D34:	INC	E
        DEC	E
        JP	Z,J$4D45
        PUSH	HL
        LD	HL,24
        ADD	HL,SP
        LD	A,(HL)
        DEC	A
        POP	HL
        CP	E
        JP	NZ,J$4D4A
J$4D45:	LD	A,17H
        JP	J.4D73
;	-----------------
J$4D4A:	LD	A,L
        LD	(D.8242),A
        LD	HL,24
        ADD	HL,SP
        LD	L,(HL)
        PUSH	HL
        LD	HL,6
        ADD	HL,SP
        PUSH	HL
        LD	C,01H	; 1 
        PUSH	BC
        LD	A,(D.8240)
        ADD	A,E
        LD	E,A
        LD	A,(D.823F)
        LD	HL,(D.8242)
        ADD	A,L
        LD	C,01H	; 1 
        CALL	C.49C7
        POP	BC
        POP	BC
        POP	BC
        JP	J$4DAA
;	-----------------
J.4D73:	LD	E,0
        PUSH	AF
        LD	A,L
        LD	(D.8242),A
        POP	AF
        LD	HL,12
        ADD	HL,SP
        LD	C,L
        LD	B,H
        CALL	C.4801			; get patterndata
        LD	HL,24
        ADD	HL,SP
        LD	L,(HL)
        PUSH	HL
        LD	HL,14
        ADD	HL,SP
        PUSH	HL
        LD	C,01H	; 1 
        PUSH	BC
        LD	A,(D.8240)
        LD	HL,(D.8243)
        ADD	A,L
        LD	E,A
        LD	A,(D.823F)
        LD	HL,D.8242
        LD	C,(HL)
        ADD	A,C
        LD	C,01H	; 1 
        CALL	C.49C7
        POP	BC
        POP	BC
        POP	BC
J$4DAA:	POP	DE
        INC	E
        LD	HL,D.8243
        LD	(HL),E
        JP	J$4CC5

J$4DB3:	LD	A,(D.8242)
        INC	A
        LD	(D.8242),A
        JP	J$4CB8

J$4DBD:	POP	HL
        EX	DE,HL
        LD	HL,16
        ADD	HL,SP
        LD	SP,HL
        EX	DE,HL
        RET

;	  Subroutine remove window
;	     Inputs  ________________________
;	     Outputs ________________________

C.4DC6:	EX	DE,HL
        LD	HL,6
        ADD	HL,DE
        LD	C,(HL)
        INC	HL
        LD	B,(HL)
        PUSH	DE
        PUSH	BC
        LD	HL,4
        ADD	HL,DE
        LD	C,(HL)
        INC	HL
        LD	B,(HL)
        PUSH	BC
        LD	HL,3
        ADD	HL,DE
        LD	L,(HL)
        PUSH	HL
        LD	HL,2
        ADD	HL,DE
        LD	C,(HL)
        PUSH	BC
        LD	HL,1
        ADD	HL,DE
        LD	C,E
        LD	B,D
        LD	E,(HL)
        LD	A,(BC)
        POP	BC
        CALL	C.4A63
        POP	BC
        POP	BC
        POP	BC
        POP	BC
        LD	HL,4
        ADD	HL,BC
        LD	A,(HL)
        INC	HL
        LD	H,(HL)
        LD	L,A
        PUSH	BC
        CALL	C.72D5			; free memory
        POP	BC
        LD	HL,6
        ADD	HL,BC
        LD	A,(HL)
        INC	HL
        LD	H,(HL)
        LD	L,A
        PUSH	BC
        CALL	C.72D5			; free memory
        POP	HL
        CALL	C.72D5			; free memory
        RET

;	  Subroutine activate menu
;	     Inputs  ________________________
;	     Outputs ________________________

C.4E12:	LD	(D.8246),HL
        LD	HL,D.8249
        LD	(HL),C
        LD	HL,(D.8246)
        PUSH	DE
        PUSH	HL
        CALL	KILBUF			; clear keyboardbuffer
        POP	DE
        LD	A,(DE)
        INC	A
        LD	HL,1
        ADD	HL,DE
        LD	(D.824A),A
        LD	A,(HL)
        INC	A
        LD	HL,2
        ADD	HL,DE
        LD	(D.824B),A
        LD	A,(HL)
        DEC	A
        DEC	A
        LD	C,A
        LD	HL,3
        ADD	HL,DE
        LD	A,(HL)
        DEC	A
        DEC	A
        LD	E,A
        LD	D,00H
        PUSH	AF
        LD	L,C
        LD	H,00H
        LD	A,C
        LD	(D.824C),A
        CALL	C.758D			; multiply (16 bit)
        ADD	HL,HL
        ADD	HL,HL
        ADD	HL,HL
        CALL	C.73D3			; allocate memory
        POP	DE
        LD	E,D
        LD	D,00H
        LD	(D.8252),HL
        LD	HL,(D.824C)
        LD	H,00H
        LD	A,E
        LD	(D.824D),A
        LD	A,L
        LD	(D.824C),A
        CALL	C.758D			; multiply (16 bit)
        ADD	HL,HL
        ADD	HL,HL
        ADD	HL,HL
        CALL	C.73D3			; allocate memory
        LD	A,0FFH
        LD	(D.824E),A
        XOR	A
        LD	(D.8250),A
        LD	(D.824F),A
        POP	DE
        INC	E
        LD	B,E
        LD	A,(D.824D)
        PUSH	AF
        LD	A,E
        LD	(D.8248),A
        POP	AF
        LD	(D.8254),HL
        CALL	C$7540			; divide (8 bit)
        LD	L,A
        LD	A,L
        LD	(D.8251),A
J$4E93:	LD	A,(D.8250)
        OR	A
        JP	NZ,J.4FC0
        LD	A,(D.824E)
        CP	0FFH
        JP	Z,J$4EC6
        LD	HL,(D.8254)
        PUSH	HL
        LD	HL,(D.8252)
        PUSH	HL
        LD	HL,(D.8248)
        LD	C,L
        PUSH	BC
        LD	B,A
        LD	A,L
        CALL	C.757E			; multiply (8 bit)
        LD	HL,(D.824B)
        ADD	A,L
        LD	E,A
        LD	HL,(D.824C)
        LD	C,L
        LD	A,(D.824A)
        CALL	C.4A63
        POP	BC
        POP	BC
        POP	BC
J$4EC6:	LD	HL,(D.8254)
        PUSH	HL
        LD	HL,(D.8252)
        PUSH	HL
        LD	HL,(D.8248)
        LD	C,L
        PUSH	BC
        LD	A,(D.824F)
        LD	B,A
        LD	(D.824F),A
        LD	A,L
        PUSH	AF
        LD	A,L
        LD	(D.8248),A
        POP	AF
        CALL	C.757E			; multiply (8 bit)
        LD	HL,(D.824B)
        ADD	A,L
        LD	E,A
        LD	A,L
        LD	(D.824B),A
        LD	HL,(D.824C)
        LD	C,L
        LD	A,(D.824A)
        LD	(D.824A),A
        PUSH	AF
        LD	A,L
        LD	(D.824C),A
        POP	AF
        CALL	C.4ACB
        POP	BC
        POP	BC
        POP	BC
        LD	A,(D.8249)
        LD	C,A
        PUSH	BC
        LD	HL,D.8248
        LD	C,(HL)
        PUSH	BC
        LD	A,(D.824F)
        LD	B,A
        LD	(D.824F),A
        LD	A,C
        CALL	C.757E			; multiply (8 bit)
        LD	HL,(D.824B)
        ADD	A,L
        LD	E,A
        LD	HL,D.824C
        LD	C,(HL)
        LD	A,(D.824A)
        CALL	C.4B29
        POP	BC
        POP	BC
        LD	A,(D.824F)
        PUSH	AF
        LD	(D.824E),A
        LD	HL,4
        ADD	HL,SP
        LD	A,(HL)
        AND	01H	; 1 
        JP	Z,J$4F3D
        CALL	C$5002
J$4F3D:	CALL	C.63C1			; get nagivation key
        POP	HL
        LD	L,H
        CP	1EH
        JP	Z,J$4F62
        CP	1FH
        JP	Z,J$4F6A
        CP	20H	; " "
        JP	Z,J.4F72
        CP	0DH	; 13 
        JP	Z,J.4F72
        CP	1BH
        JP	Z,J$4F7A
        OR	A
        JP	Z,J$4F82
        JP	J.4FA2

J$4F62:	DEC	L
        LD	A,L
        LD	(D.824F),A
        JP	J.4FA2

J$4F6A:	INC	L
        LD	A,L
        LD	(D.824F),A
        JP	J.4FA2

J.4F72:	LD	A,01H	; 1 
        LD	(D.8250),A
        JP	J.4FA2

J$4F7A:	LD	A,02H	; 2 
        LD	(D.8250),A
        JP	J.4FA2

J$4F82:	LD	HL,2
        ADD	HL,SP
        LD	A,(HL)
        AND	02H	; 2 
        JP	Z,J.4FA2
        LD	A,(D.8321)
        CP	09H	; 9 
        JP	NZ,J.4FA2
        LD	A,01H	; 1 
        LD	HL,(D.8251)
        PUSH	AF
        LD	A,L
        LD	(D.824F),A
        POP	AF
        JP	J.4FC0
;	-----------------
J.4FA2:	LD	A,(D.824F)
        CP	80H
        JP	C,J$4FB2
        LD	HL,(D.8251)
        LD	A,L
        DEC	A
        JP	J.4FBA
;	-----------------
J$4FB2:	LD	HL,(D.8251)
        CP	L
        JP	C,J.4FBA
        XOR	A
J.4FBA:	LD	(D.824F),A
        JP	J$4E93
;	-----------------
J.4FC0:	PUSH	AF
        LD	HL,(D.8254)
        PUSH	HL
        PUSH	HL
        LD	HL,(D.8252)
        PUSH	HL
        LD	A,(D.8248)
        LD	C,A
        PUSH	BC
        LD	A,(D.824E)
        LD	B,A
        LD	A,C
        LD	(D.8252),HL
        CALL	C.757E			; multiply (8 bit)
        LD	HL,(D.824B)
        ADD	A,L
        LD	E,A
        LD	HL,D.824C
        LD	C,(HL)
        LD	A,(D.824A)
        CALL	C.4A63
        POP	BC
        POP	BC
        POP	BC
        LD	HL,(D.8252)
        CALL	C.72D5			; free memory
        POP	HL
        CALL	C.72D5			; free memory
        POP	AF
        DEC	A
        JP	NZ,J$4FFF
        LD	A,(D.824F)
        RET
;	-----------------
J$4FFF:	LD	A,0FFH
        RET
;	-----------------

;	  Subroutine __________________________
;	     Inputs  ________________________
;	     Outputs ________________________

C$5002:	LD	HL,(D.8334)
        EX	DE,HL
J$5006:	PUSH	DE
        CALL	C.67B8
        POP	DE
        OR	A
        RET	NZ
        LD	HL,(D.8334)
        LD	A,L
        SUB	E
        LD	L,A
        LD	A,H
        SBC	A,D
        LD	H,A
        PUSH	DE
        LD	A,L
        OR	H
        JP	Z,J.5053
        LD	DE,6000
        PUSH	HL
        CALL	C.7558			; divide (16 bit)
        POP	HL
        LD	A,E
        OR	D
        JP	NZ,J$5031
        LD	A,01H	; 1 
        CALL	C.4589
        JP	J.5053
;	-----------------
J$5031:	LD	DE,600
        PUSH	HL
        CALL	C.7558			; divide (16 bit)
        POP	HL
        LD	A,E
        OR	D
        JP	NZ,J$5045
        XOR	A
        CALL	C.4589
        JP	J.5053
;	-----------------
J$5045:	LD	DE,20
        CALL	C.7558			; divide (16 bit)
        LD	A,E
        OR	D
        JP	NZ,J.5053
D$504F	EQU	$-1
        CALL	C$4777
J.5053:	LD	A,(D.8322)
        INC	A			; BGM playing ?
        JP	NZ,J$5067		; yep,
        LD	HL,D.0100
        CALL	C.6399
        LD	HL,(D.8334)
        INC	HL
        LD	(D.8334),HL
J$5067:	POP	DE
        JP	J$5006

I$506B:	DEFB	009H,0CAH,0B2H,00AH
        DEFB	009H,0B2H,0B4H
        DEFB	0

;	  Subroutine __________________________
;	     Inputs  ________________________
;	     Outputs ________________________

C.5074:	LD	C,27
        PUSH	BC
        LD	C,4
        PUSH	BC
        LD	C,3
        LD	E,2
        LD	A,26
        CALL	C.4BE4			; create window
        POP	BC
        POP	BC
        LD	C,27
        PUSH	HL
        PUSH	BC
        LD	BC,I$506B
        PUSH	BC
        LD	C,1
        PUSH	BC
        LD	E,0
        LD	C,0
        LD	(D.8256),HL
        CALL	C.4896			; display text
        POP	BC
        POP	BC
        POP	BC
        LD	C,00H
        PUSH	BC
        LD	HL,(D.8256)
        LD	E,01H	; 1 
        LD	C,0FCH
        CALL	C.4E12			; activate menu
        POP	BC
        POP	HL
        PUSH	AF
        CALL	C.4DC6			; remove window
        POP	AF
        OR	A
        JP	NZ,J$50B8
        LD	A,1
        RET

J$50B8:	XOR	A
        RET

I$50BA:	DEFB	1
        DEFB	"????????"
        DEFB	"PAC"
        DEFB	0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0
        DEFB	0,0,0,0,0

;	  Subroutine create PAC filelist
;	     Inputs  ________________________
;	     Outputs ________________________

C$50DF:	LD	HL,-128
        ADD	HL,SP
        LD	SP,HL
        LD	HL,0
        ADD	HL,SP
        EX	DE,HL
        LD	A,1AH			; set DMA address
        CALL	C.7506			; make BDOS call
        LD	HL,1695
        CALL	C.73D3			; allocate memory
        LD	(D.827D),HL
        LD	BC,37
        PUSH	HL
        LD	DE,I.8258
        LD	HL,I$50BA		; "*.PAC"
        CALL	C.7525			; copy data
        LD	DE,I.8258
        LD	A,11H			; search first
        CALL	C.7506			; make BDOS call
        LD	E,A
        LD	A,(D.8029)
        OR	A			; error ?
        JP	NZ,J.515D
J$5114:	INC	E
        DEC	E			; search has a result ?
        JP	NZ,J.515D		; nope, stop searching
        LD	HL,(D.827D)
        LD	E,L
        LD	D,H
        LD	BC,11
        PUSH	HL
        LD	HL,5
        ADD	HL,SP			; to filename
        CALL	C.7525			; copy data
        CALL	C.75DE
        DEFW	26+2			; get word from stack at offset 26
        EX	DE,HL
        POP	BC
        LD	HL,13
        ADD	HL,BC
        LD	(HL),E
        INC	HL
        LD	(HL),D			; time
        CALL	C.75DE
        DEFW	27+2			; get word from stack at offset 27
        EX	DE,HL
        LD	HL,11
        ADD	HL,BC
        LD	(HL),E
        INC	HL
        LD	(HL),D
        LD	A,12H			; search next
        PUSH	BC
        CALL	C.7506			; make BDOS call
        LD	E,A
        LD	A,(D.8029)
        POP	BC
        OR	A			; error ?
        JP	NZ,J.515D		; yep,
        LD	HL,15
        ADD	HL,BC
        LD	(D.827D),HL
        JP	J$5114			; next search

J.515D:	LD	A,(D.8029)
        POP	HL
        OR	A			; search aborted by an error ?
        JP	Z,J$516E		; nope,
        CALL	C.72D5			; free memory
        LD	HL,0
        JP	J$5175

J$516E:	XOR	A
        PUSH	HL
        LD	HL,(D.827D)
        LD	(HL),A			; mark end of filelist
        POP	HL
J$5175:	EX	DE,HL
        LD	HL,128
        ADD	HL,SP
        LD	SP,HL
        EX	DE,HL
        RET

I$517D:	DEFB	"         "
        DEFB	0

J.5187:	DEFB	"PAC"
        DEFB	0

I$518B:	DEFB	05FH
        DEFB	0

;	  Subroutine __________________________
;	     Inputs  ________________________
;	     Outputs ________________________

C.518D:	LD	(D.82A4),HL
        LD	HL,-10
        ADD	HL,SP
        LD	SP,HL
        LD	HL,(D.82A4)
        LD	C,L
        LD	B,H
        LD	HL,D.82A6
        LD	(HL),E
        XOR	A
J.519F:	LD	(D.82BF),A
        LD	(D.82AB),A
J.51A5:	LD	A,(D.82AB)
        CP	0FFH
        JP	Z,J$51D2
        INC	A
        LD	(D.82AB),A
        DEC	A
        LD	L,A
        LD	H,00H
        ADD	HL,BC
        LD	A,(HL)
        OR	A
        JP	Z,J$51C3
        CP	09H	; 9 
        JP	Z,J.51A5
        JP	J$51CB
;	-----------------
J$51C3:	LD	A,0FFH
        LD	(D.82AB),A
        JP	J.51A5
;	-----------------
J$51CB:	LD	HL,D.82BF
        INC	(HL)
        JP	J.51A5

J$51D2:	PUSH	BC
        CALL	C$50DF			; create PAC filelist
        EX	DE,HL
        EX	DE,HL
        LD	(D.82B8),HL		; save pointer to filelist
        EX	DE,HL
        POP	HL
        LD	A,E
        OR	D			; error occured ?
        JP	NZ,J$51E8		; nope,
        LD	HL,0
        JP	J.565A

J$51E8:	LD	(D.82A4),HL
        LD	L,0			; filenumber 0
        LD	A,L
        LD	(D.82B7),A
J$51F1:	LD	H,0
        PUSH	DE
        LD	DE,15
        CALL	C.758D			; multiply (16 bit)
        POP	DE
        ADD	HL,DE
        LD	A,(HL)
        OR	A			; end of list ?
        JP	Z,J$520C		; yep,
        LD	HL,(D.82B7)
        INC	L
        LD	A,L
        LD	(D.82B7),A
        JP	J$51F1			; next file

J$520C:	LD	HL,0
        LD	(D.82A7),HL
        LD	A,(D.82B7)
        PUSH	DE
        OR	A			; found files ?
        JP	Z,J$5249		; nope,
        CP	7
        JP	C,J$5221		; <7,
        LD	A,7
J$5221:	LD	L,A
        LD	A,L
        LD	(D.82AF),A
        LD	C,27
        PUSH	BC
        LD	C,L
        PUSH	BC
        LD	C,27
        LD	A,18
        SUB	L
        LD	(D.82AD),A
        LD	E,A
        LD	A,2
        LD	(D.82AC),A
        LD	HL,D.82AE
        LD	(HL),C
        CALL	C.4BE4			; create window
        POP	BC
        POP	BC
        LD	(D.82A7),HL
        LD	A,(D.82AE)
        LD	C,A
J$5249:	LD	A,C
        LD	(D.82AE),A
        LD	C,23
        PUSH	HL
        PUSH	BC
        LD	C,2
        PUSH	BC
        LD	A,(D.82BF)
        ADD	A,9
        LD	C,A
        LD	E,20
        LD	HL,D.82BF
        LD	A,20
        SUB	(HL)
        CALL	C.4BE4			; create window
        POP	BC
        POP	BC
        LD	C,23
        PUSH	HL
        PUSH	BC
        LD	(D.82A9),HL
        LD	HL,(D.82A4)
        PUSH	HL
        LD	C,1
        PUSH	BC
        LD	HL,(D.82A9)
        LD	E,0
        LD	C,0
        CALL	C.4896			; display text
        POP	BC
        POP	BC
        POP	BC
        LD	HL,6
        ADD	HL,SP
        LD	(HL),00H
        LD	HL,D.82AE
        LD	C,(HL)
        LD	L,C
        LD	H,00H
        ADD	HL,HL
        ADD	HL,HL
        ADD	HL,HL
        PUSH	BC
        CALL	C.73D3			; allocate memory
        LD	(D.82B0),HL
        POP	HL
        LD	H,00H
        ADD	HL,HL
        ADD	HL,HL
        ADD	HL,HL
        CALL	C.73D3			; allocate memory
        LD	(D.82B2),HL
        LD	A,0FFH
        LD	(D.82BC),A
        LD	(D.82BA),A
        LD	(D.82B5),A
        XOR	A
        LD	(D.82BE),A
        LD	(D.82BB),A
        LD	(D.82B6),A
        PUSH	HL
J.52BB:	LD	A,(D.82BE)
        OR	A
        JP	NZ,J$55E0
        LD	HL,(D.82B7)
        INC	L
        DEC	L
        JP	Z,J.5456
        LD	A,(D.82BB)
        CP	80H
        JP	C,J$52D7
        LD	A,L
        DEC	A
        JP	J.52E5
;	-----------------
J$52D7:	LD	A,(D.82BB)
        CP	L
        JP	C,J$52E2
        XOR	A
        JP	J.52E5
;	-----------------
J$52E2:	LD	A,(D.82BB)
J.52E5:	LD	(D.82BB),A
        LD	A,01H	; 1 
        LD	(D.82BD),A
        LD	HL,D.82BC
        LD	A,(D.82BB)
        CP	(HL)
        JP	NC,J$5300
        LD	A,(D.82BB)
        LD	(D.82BC),A
        JP	J.531E
;	-----------------
J$5300:	LD	A,(D.82BC)
        LD	HL,(D.82AF)
        ADD	A,L
        LD	B,A
        LD	A,(D.82BB)
        CP	B
        JP	C,J$531A
        LD	A,(D.82BB)
        SUB	L
        INC	A
        LD	(D.82BC),A
        JP	J.531E
;	-----------------
J$531A:	XOR	A
        LD	(D.82BD),A
J.531E:	LD	A,(D.82BD)
        OR	A
        JP	Z,J$533D
        LD	A,0FFH
        LD	(D.82BA),A
        LD	HL,(D.82B8)
        PUSH	HL
        LD	HL,(D.82AF)
        LD	C,L
        LD	HL,(D.82A7)
        LD	A,(D.82BC)
        LD	E,A
        CALL	C$5689
        POP	BC
J$533D:	LD	HL,D.82BA
        LD	A,(D.82BB)
        CP	(HL)
        JP	Z,J.53B4
        LD	A,(D.82A6)
        OR	A
        JP	NZ,J.53B4
        LD	E,00H
        LD	HL,D.82B6
        LD	(HL),E
J$5354:	LD	HL,D.82BB
        LD	L,(HL)
        LD	H,00H
        PUSH	DE
        LD	DE,15
        CALL	C.758D			; multiply (16 bit)
        EX	DE,HL
        LD	HL,(D.82B8)
        EX	DE,HL
        ADD	HL,DE
        LD	C,E
        LD	B,D
        POP	DE
        LD	D,00H
        ADD	HL,DE
        LD	A,(HL)
        CP	20H	; " "
        JP	Z,J.53A5
        LD	A,E
        CP	08H	; 8 
        JP	NC,J.53A5
        PUSH	BC
        LD	HL,D.82BB
        LD	L,(HL)
        LD	H,00H
        LD	A,E
        LD	(D.82B6),A
        LD	DE,15
        CALL	C.758D			; multiply (16 bit)
        POP	BC
        ADD	HL,BC
        LD	A,(D.82B6)
        LD	E,A
        LD	D,00H
        ADD	HL,DE
        LD	A,(HL)
        LD	C,E
        LD	B,00H
        LD	HL,8
        ADD	HL,SP
        ADD	HL,BC
        LD	(HL),A
        INC	E
        LD	HL,D.82B6
        LD	(HL),E
        JP	J$5354

J.53A5:	LD	C,E
        LD	B,00H
        LD	HL,8
        ADD	HL,SP
        ADD	HL,BC
        LD	(HL),00H
        LD	A,0FFH
        LD	(D.82B5),A
J.53B4:	LD	A,(D.82BA)
        INC	A
        JP	Z,J$53DF
        LD	HL,(D.82B2)
        PUSH	HL
        LD	HL,(D.82B0)
        PUSH	HL
        LD	C,1
        PUSH	BC
        LD	HL,(D.82AE)
        LD	C,L
        LD	A,(D.82BA)
        LD	HL,(D.82AD)
        ADD	A,L
        LD	HL,D.82BC
        SUB	(HL)
        LD	E,A
        LD	A,(D.82AC)
        CALL	C.4A63
        POP	BC
        POP	BC
        POP	BC
J$53DF:	LD	HL,D.82BB
        LD	L,(HL)
        LD	H,00H
        LD	DE,15
        CALL	C.758D			; multiply (16 bit)
        EX	DE,HL
        LD	HL,(D.82B8)
        EX	DE,HL
        ADD	HL,DE
        PUSH	HL
        LD	HL,10
        ADD	HL,SP
        EX	DE,HL
        POP	HL
        CALL	C.5660
        OR	A
        JP	Z,J.5456
        LD	HL,(D.82B2)
        PUSH	HL
        LD	HL,(D.82B0)
        PUSH	HL
        LD	C,01H	; 1 
        PUSH	BC
        LD	HL,(D.82AE)
        LD	C,L
        LD	A,(D.82BB)
        PUSH	AF
        LD	A,L
        LD	(D.82AE),A
        POP	AF
        LD	HL,(D.82AD)
        ADD	A,L
        PUSH	AF
        LD	A,L
        LD	(D.82AD),A
        POP	AF
        LD	HL,D.82BC
        SUB	(HL)
        LD	E,A
        LD	A,(D.82AC)
        LD	(D.82AC),A
        CALL	C.4ACB
        POP	BC
        POP	BC
        POP	BC
        LD	C,0FCH
        PUSH	BC
        LD	C,01H	; 1 
        PUSH	BC
        LD	HL,D.82AE
        LD	C,(HL)
        LD	A,(D.82BB)
        LD	HL,(D.82AD)
        ADD	A,L
        LD	HL,D.82BC
        SUB	(HL)
        LD	E,A
        LD	A,(D.82AC)
        CALL	C.4B29
        POP	BC
        POP	BC
        LD	A,(D.82BB)
        LD	(D.82BA),A
J.5456:	LD	A,(D.82B5)
        LD	HL,(D.82B6)
        CP	L
        JP	Z,J$54C0
        LD	C,0FCH
        PUSH	HL
        PUSH	BC
        LD	BC,I$517D
        PUSH	BC
        LD	C,1
        PUSH	BC
        LD	A,L
        LD	(D.82B6),A
        LD	HL,(D.82A9)
        LD	A,(D.82BF)
        LD	E,A
        LD	C,0
        LD	(D.82A9),HL
        CALL	C.4896			; display text
        POP	BC
        POP	BC
        POP	BC
        LD	C,0FCH
        PUSH	BC
        LD	HL,12
        ADD	HL,SP
        PUSH	HL
        LD	C,1
        PUSH	BC
        LD	HL,(D.82A9)
        LD	A,(D.82BF)
        LD	E,A
        LD	C,0
        LD	(D.82A9),HL
        CALL	C.4896			; display text
        POP	BC
        POP	BC
        POP	BC
        LD	C,0FCH
        PUSH	BC
        LD	BC,I$518B
        PUSH	BC
        LD	C,1
        PUSH	BC
        LD	A,(D.82BF)
        LD	HL,(D.82B6)
        ADD	A,L
        LD	E,A
        LD	HL,(D.82A9)
        LD	C,0
        CALL	C.4896			; display text
        POP	BC
        POP	BC
        POP	BC
        POP	HL
        LD	A,L
        LD	(D.82B5),A
J$54C0:	CALL	C.63B2			; get key
        CALL	C$750C			; make upcase
        LD	(D.82B4),A
        CP	20H
        JP	Z,J.54EA		; spacebar,
        CP	0DH
        JP	Z,J.54EA		; return,
        CP	1BH
        JP	Z,J$54F2		; esc,
        CP	1EH
        JP	Z,J$54FA		; up,
        CP	1FH
        JP	Z,J$5512		; down,
        CP	08H
        JP	Z,J$552A		; backspace,
        JP	J$5544

J.54EA:	LD	A,1
        LD	(D.82BE),A
        JP	J.5593

J$54F2:	LD	A,0FFH
        LD	(D.82BE),A
        JP	J.5593

J$54FA:	LD	A,(D.82A6)
        OR	A
        JP	Z,J$5508
        XOR	A
        LD	(D.82A6),A
        JP	J$550C

J$5508:	LD	A,(D.82BB)
        DEC	A
J$550C:	LD	(D.82BB),A
        JP	J.5593

J$5512:	LD	A,(D.82A6)
        OR	A
        JP	Z,J$5520
        XOR	A
        LD	(D.82A6),A
        JP	J$5524

J$5520:	LD	A,(D.82BB)
        INC	A
J$5524:	LD	(D.82BB),A
        JP	J.5593

J$552A:	LD	HL,(D.82B6)
        INC	L
        DEC	L
        JP	Z,J.5593
        DEC	L
        LD	A,L
        LD	(D.82B6),A
        LD	C,L
        LD	B,00H
        LD	HL,8
        ADD	HL,SP
        ADD	HL,BC
        LD	(HL),00H
        JP	J.5593

J$5544:	LD	HL,(D.82B6)
        LD	A,L
        CP	08H
        JP	Z,J.5593		; backspace,
        LD	A,(D.82B4)
        CP	"0"
        JP	C,J$555A
        CP	"9"+1
        JP	C,J.556E		; digit,
J$555A:	CP	"A"
        JP	C,J$5564
        CP	"Z"+1
        JP	C,J.556E		; letter
J$5564:	CP	86H
        JP	C,J.5593
        CP	0FEH
        JP	NC,J.5593
J.556E:	INC	L
        PUSH	AF
        LD	A,L
        LD	(D.82B6),A
        POP	AF
        LD	(D.82B4),A
        LD	A,L
        DEC	A
        PUSH	HL
        LD	L,A
        LD	H,00H
        EX	DE,HL
        LD	HL,10
        ADD	HL,SP
        ADD	HL,DE
        LD	A,(D.82B4)
        LD	(HL),A
        POP	HL
        LD	C,L
        LD	B,00H
        LD	HL,8
        ADD	HL,SP
        ADD	HL,BC
        LD	(HL),00H
J.5593:	LD	A,(D.82B6)
        LD	HL,D.82B5
        LD	E,(HL)
        CP	E
        JP	Z,J.52BB
        LD	L,00H
        LD	A,L
        LD	(D.82AB),A
J$55A4:	LD	A,L
        LD	HL,(D.82B7)
        CP	L
        JP	NC,J.52BB
        LD	HL,(D.82AB)
        LD	H,00H
        LD	DE,15
        CALL	C.758D			; multiply (16 bit)
        EX	DE,HL
        LD	HL,(D.82B8)
        EX	DE,HL
        ADD	HL,DE
        PUSH	HL
        LD	HL,10
        ADD	HL,SP
        EX	DE,HL
        POP	HL
        CALL	C.5660
        OR	A
        JP	Z,J$55D5
        LD	HL,(D.82AB)
        LD	A,L
        LD	(D.82BB),A
        JP	J.52BB

J$55D5:	LD	HL,(D.82AB)
        INC	L
        LD	A,L
        LD	(D.82AB),A
        JP	J$55A4

J$55E0:	LD	HL,(D.82B0)
        CALL	C.72D5			; free memory
        POP	HL
        CALL	C.72D5			; free memory
        POP	HL
        CALL	C.4DC6			; remove window
        POP	HL
        LD	A,L
        OR	H
        JP	Z,J$55F7
        CALL	C.4DC6			; remove window
J$55F7:	POP	HL
        CALL	C.72D5			; free memory
        LD	A,(D.82BE)
        DEC	A
        JP	NZ,J$560B
        LD	HL,0
        ADD	HL,SP
        LD	A,(HL)
        OR	A
        JP	NZ,J$5611
J$560B:	LD	HL,0
        JP	J.565A
;	-----------------
J$5611:	LD	C,00H
        LD	DE,37
        LD	HL,I.827F
        CALL	C.7515			; clear
        LD	C,20H	; " "
        LD	DE,11
        LD	HL,I.8280
        CALL	C.7515			; clear
        LD	E,00H
J$5629:	LD	C,E
        LD	B,00H
        LD	HL,0
        ADD	HL,SP
        ADD	HL,BC
        LD	A,(HL)
        OR	A
        JP	Z,J$564B
        LD	C,E
        LD	B,00H
        LD	HL,0
        ADD	HL,SP
        ADD	HL,BC
        LD	A,(HL)
        LD	L,E
        LD	H,00H
        LD	BC,I.8280
        ADD	HL,BC
        LD	(HL),A
        INC	E
        JP	J$5629
;	-----------------
J$564B:	LD	BC,3
        LD	DE,I$8288
        LD	HL,J.5187
        CALL	C.7525			; copy data
        LD	HL,I.827F
J.565A:	POP	BC
        POP	BC
        POP	BC
        POP	BC
        POP	BC
        RET
;	-----------------

;	  Subroutine __________________________
;	     Inputs  ________________________
;	     Outputs ________________________

C.5660:	LD	C,L
        LD	B,H
        EX	DE,HL
        LD	E,00H
J$5665:	LD	A,E
        CP	08H	; 8 
        JP	NC,J$5686
        LD	A,(BC)
        CP	(HL)
        JP	Z,J$5680
        LD	A,(BC)
        CP	20H	; " "
        JP	NZ,J.567E
        LD	A,(HL)
        OR	A
        JP	NZ,J.567E
        LD	A,01H	; 1 
        RET
;	-----------------
J.567E:	XOR	A
        RET
;	-----------------
J$5680:	INC	BC
        INC	HL
        INC	E
        JP	J$5665
;	-----------------
J$5686:	LD	A,01H	; 1 
        RET
;	-----------------

;	  Subroutine __________________________
;	     Inputs  ________________________
;	     Outputs ________________________

C$5689:	LD	(D.82C0),HL
        LD	HL,-28
        ADD	HL,SP
        LD	SP,HL
        LD	HL,(D.82C0)
        LD	A,E
        LD	(D.82C2),A
        XOR	A
        LD	(D.82C3),A
J$569C:	CP	C
        JP	NC,J$5700
        LD	(D.82C0),HL
        LD	HL,(D.82C2)
        LD	H,00H
        LD	DE,15
        PUSH	BC
        CALL	C.758D			; multiply (16 bit)
        PUSH	HL
        LD	HL,(D.82C3)
        LD	H,00H
        LD	DE,15
        LD	A,L
        LD	(D.82C3),A
        CALL	C.758D			; multiply (16 bit)
        PUSH	HL
        CALL	C.75DE
        DEFW	36+2			; get word from stack at offset 36
        POP	DE
        ADD	HL,DE
        POP	DE
        ADD	HL,DE
        EX	DE,HL
        LD	HL,2
        ADD	HL,SP
        CALL	C$5706
        LD	C,1BH
        PUSH	BC
        LD	HL,4
        ADD	HL,SP
        PUSH	HL
        LD	C,0
        PUSH	BC
        LD	HL,D.82C3
        LD	C,(HL)
        LD	HL,(D.82C0)
        LD	E,0
        LD	A,C
        LD	(D.82C3),A
        LD	(D.82C0),HL
        CALL	C.4896			; display text
        POP	BC
        POP	BC
        POP	BC
        LD	A,(D.82C3)
        INC	A
        LD	(D.82C3),A
        POP	BC
        LD	HL,(D.82C0)
        JP	J$569C
;	-----------------
J$5700:	LD	HL,28
        ADD	HL,SP
        LD	SP,HL
        RET
;	-----------------

;	  Subroutine __________________________
;	     Inputs  ________________________
;	     Outputs ________________________

C$5706:	LD	A,(DE)
        OR	A
        JP	NZ,J$570D
        XOR	A
        RET
;	-----------------
J$570D:	LD	(D.82C4),HL
        PUSH	HL
        INC	HL
        PUSH	DE
        PUSH	HL
        EX	DE,HL
        LD	BC,8
        POP	DE
        CALL	C.7525			; copy data
        POP	DE
        LD	HL,11
        ADD	HL,DE
        LD	A,(HL)
        INC	HL
        LD	H,(HL)
        LD	L,A
        LD	B,9
        CALL	C.7533			; / 512
        LD	BC,I$07BC
        ADD	HL,BC
        PUSH	DE
        EX	DE,HL
        LD	HL,(D.82C4)
        LD	(D.82C4),HL
        LD	BC,10
        ADD	HL,BC
        LD	C,04H	; 4 
        CALL	C.57EB
        POP	DE
        LD	HL,11
        ADD	HL,DE
        LD	A,(HL)
        INC	HL
        LD	H,(HL)
        LD	L,A
        LD	B,5
        CALL	C.7533			; /32
        LD	A,L
        AND	0FH	; 15 
        PUSH	DE
        LD	E,A
        LD	D,00H
        LD	HL,(D.82C4)
        LD	(D.82C4),HL
        LD	BC,15
        ADD	HL,BC
        LD	C,02H	; 2 
        CALL	C.57EB
        POP	DE
        LD	HL,11
        ADD	HL,DE
        LD	A,(HL)
        AND	1FH
        PUSH	DE
        LD	E,A
        LD	D,00H
        LD	HL,(D.82C4)
        LD	(D.82C4),HL
        LD	BC,18
        ADD	HL,BC
        LD	C,02H	; 2 
        CALL	C.57EB
        POP	DE
        LD	HL,13
        ADD	HL,DE
        LD	A,(HL)
        INC	HL
        LD	H,(HL)
        LD	L,A
        LD	B,11
        CALL	C.7533			; /2048
        PUSH	DE
        EX	DE,HL
        LD	HL,(D.82C4)
        LD	(D.82C4),HL
        LD	BC,21
        ADD	HL,BC
        LD	C,02H	; 2 
        CALL	C.57EB
        POP	DE
        LD	HL,13
        ADD	HL,DE
        LD	A,(HL)
        INC	HL
        LD	H,(HL)
        LD	L,A
        LD	B,5
        CALL	C.7533			; /32
        LD	A,L
        AND	3FH	; "?"
        LD	E,A
        LD	D,00H
        LD	HL,(D.82C4)
        LD	BC,24
        ADD	HL,BC
        LD	C,02H	; 2 
        CALL	C.57EB
        POP	DE
        LD	HL,26
        ADD	HL,DE
        LD	A,20H	; " "
        LD	(HL),A
        LD	HL,20
        ADD	HL,DE
        LD	(HL),A
        LD	HL,9
        ADD	HL,DE
        LD	(HL),A
        LD	(DE),A
        LD	HL,17
        ADD	HL,DE
        LD	(HL),2DH	; "-"
        LD	HL,14
        ADD	HL,DE
        LD	(HL),2DH	; "-"
        LD	HL,23
        ADD	HL,DE
        LD	(HL),3AH	; ":"
        LD	HL,27
        ADD	HL,DE
        LD	(HL),00H
        LD	A,01H	; 1 
        RET
;	-----------------

;	  Subroutine __________________________
;	     Inputs  ________________________
;	     Outputs ________________________

C.57EB:	PUSH	DE
        EX	DE,HL
        LD	L,C
        LD	H,00H
        ADD	HL,DE
        LD	(D.82C6),HL
        POP	HL
J$57F5:	DEC	C
        LD	A,C
        INC	A
        RET	Z
        PUSH	BC
        LD	DE,10
        PUSH	HL
        CALL	C.7558			; divide (16 bit)
        LD	A,E
        ADD	A,"0"
        LD	HL,(D.82C6)
        DEC	HL
        LD	(D.82C6),HL
        LD	(HL),A
        POP	HL
        LD	DE,10
        CALL	C.7558			; divide (16 bit)
        POP	BC
        JP	J$57F5

;	  Subroutine __________________________
;	     Inputs  ________________________
;	     Outputs ________________________

C$5817:	CALL	C$66DB			; install PAC routines
        LD	E,0			; primairy slot 0
        LD	HL,I.82E9
        LD	(HL),E
        LD	A,E
        LD	(D.82EB),A		; no PAC SRAM�s found yet
J$5824:	LD	A,E
        CP	4
        JP	NC,J$58DA
        LD	L,E
        LD	H,0
        LD	BC,I.FCC1
        ADD	HL,BC
        LD	A,(HL)
        AND	80H			; is slot expanded ?
        PUSH	DE
        OR	A
        JP	NZ,J$587A		; yep, handle
        LD	A,E
        PUSH	DE
        CALL	C.5927			; check if PAC SRAM
        POP	DE
        OR	A
        JP	Z,J.58D1		; nope, next slot
        LD	A,E
        PUSH	DE
        CALL	C.58EA			; check if PAC2 indentifier
        OR	A
        JP	Z,J$5852		; nope,
        LD	HL,1			; FMPAC SRAM
        JP	J$5855

J$5852:	LD	HL,0			; PAC SRAM
J$5855:	LD	H,L
        PUSH	HL
        LD	A,(D.82EB)
        LD	L,A
        LD	H,0
        LD	BC,I.82D9
        ADD	HL,BC
        LD	(D.82EB),A
        POP	AF
        LD	(HL),A			; SRAM type
        LD	A,(D.82EB)
        INC	A
        LD	(D.82EB),A		; increase number of PAC SRAM found
        DEC	A
        LD	L,A
        LD	H,0
        LD	BC,D.82C9
        ADD	HL,BC
        POP	DE
        LD	(HL),E			; slotid
        JP	J.58D1			; next slot

J$587A:	XOR	A			; secundairy slot 0
J$587B:	CP	4
        JP	NC,J.58D1
        PUSH	AF
        ADD	A,A
        ADD	A,A
        LD	B,A
        LD	A,80H
        LD	HL,I.82E9
        LD	E,(HL)
        OR	E
        OR	B
        LD	(D.82EA),A
        CALL	C.5927			; check if PAC SRAM
        OR	A
        JP	Z,J$58CC		; nope, next slot
        LD	A,(D.82EA)
        PUSH	AF
        CALL	C.58EA			; check if PAC2 indentifier
        OR	A
        JP	Z,J$58A7		; nope,
        LD	HL,1			; FMPAC SRAM
        JP	J$58AA

J$58A7:	LD	HL,0			; PAC SRAM
J$58AA:	LD	H,L
        PUSH	HL
        LD	A,(D.82EB)
        LD	L,A
        LD	H,00H
        LD	BC,I.82D9
        ADD	HL,BC
        LD	(D.82EB),A
        POP	AF
        LD	(HL),A			; SRAM type
        LD	A,(D.82EB)
        INC	A
        LD	(D.82EB),A		; increase number of PAC SRAM found
        DEC	A
        LD	L,A
        LD	H,00H
        LD	BC,D.82C9
        ADD	HL,BC
        POP	AF
        LD	(HL),A			; slotid
J$58CC:	POP	AF
        INC	A
        JP	J$587B			; next secundair slot

J.58D1:	POP	DE
        INC	E
        LD	HL,I.82E9
        LD	(HL),E
        JP	J$5824			; next primair slot

J$58DA:	LD	A,(D.82EB)
        LD	(D.82C8),A
        LD	L,A
        LD	H,0
        LD	BC,D.82C9
        ADD	HL,BC
        LD	(HL),0FFH		; endmarker
        RET

;	  Subroutine __________________________
;	     Inputs  ________________________
;	     Outputs ________________________

C.58EA:	LD	(D.82EC),A
        LD	DE,I.4018+0
        CALL	C.8085			; read from slot
        CP	"P"
        JP	NZ,J.5925
        LD	A,(D.82EC)
        LD	DE,I.4018+1
        CALL	C.8085			; read from slot
        CP	"A"
        JP	NZ,J.5925
        LD	A,(D.82EC)
        LD	DE,I.4018+2
        CALL	C.8085			; read from slot
        CP	"C"
        JP	NZ,J.5925
        LD	A,(D.82EC)
        LD	DE,I.4018+3
        CALL	C.8085			; read from slot
        CP	"2"
        JP	NZ,J.5925
        LD	A,1
        RET

J.5925:	XOR	A
        RET

;	  Subroutine __________________________
;	     Inputs  ________________________
;	     Outputs ________________________

C.5927:	PUSH	AF
        CALL	C.74C8			; get current slotid in page 1
        POP	HL
        LD	L,H
        CP	L
        JP	NZ,J$593E		; check if PAC SRAM
        LD	A,L
        CALL	C.58EA			; check if PAC2 indentifier
        OR	A
        JP	Z,J$593C		; nope, FMPAC without PAC SRAM
        LD	A,1			; FMPAC with PAC SRAM
        RET

J$593C:	XOR	A
        RET

J$593E:	LD	A,L
        LD	DE,I.4000
        PUSH	AF
        LD	A,L
        LD	(D.82ED),A
        POP	AF
        CALL	C.8085			; read from slot
        PUSH	AF			; save current value
        CPL
        LD	C,A			; invert value
        LD	A,(D.82ED)
        LD	DE,I.4000
        PUSH	AF
        CALL	C.808B			; write to slot
        POP	AF
        LD	DE,I.4000
        CALL	C.8085			; read from slot
        LD	H,A			; current value
        POP	BC
        LD	C,B
        LD	A,C
        CPL
        CP	H			; writeable memory ?
        JP	NZ,J$5973		; nope,
        LD	A,(D.82ED)
        LD	DE,I.4000
        CALL	C.808B			; write to slot
        XOR	A			; no PAC SRAM
        RET

J$5973:	LD	A,(D.82ED)
        LD	DE,I.4000
        LD	(D.82ED),A
        CALL	C.8030			; read byte from SRAM
        PUSH	AF
        CPL
        LD	C,A
        LD	A,(D.82ED)
        LD	DE,I.4000
        PUSH	AF
        CALL	C.8043			; write byte to SRAM
        POP	AF
        LD	DE,I.4000
        CALL	C.8030			; read byte from SRAM
        LD	H,A
        POP	BC
        LD	C,B
        LD	A,C
        CPL
        CP	H
        JP	NZ,J$59A8
        LD	A,(D.82ED)
        LD	DE,I.4000
        CALL	C.8043			; write byte to SRAM
        LD	A,1			; PAC SRAM found
        RET

J$59A8:	XOR	A
        RET

I$59AA:	DEFB	"PAC      ",0

I$59B4:	DEFB	"FMPAC    ",0

;	  Subroutine SRAM selection
;	     Inputs  ________________________
;	     Outputs ________________________

C.59BE:	LD	(D.82EE),HL
        LD	HL,-26
        ADD	HL,SP
        LD	SP,HL
        LD	HL,(D.82EE)
        LD	A,(D.82C8)
        DEC	A			; 2 or more SRAMs found ?
        JP	NZ,J$59D6		; yep,
        LD	A,(D.82C9+0)
        JP	J.5AEE			; select the only SRAM found

J$59D6:	LD	C,23
        PUSH	BC
        LD	C,2
J$59DB:	PUSH	BC
        LD	C,26
        LD	A,E
        LD	(D.82F0),A
        LD	E,2
        LD	A,3
        LD	(D.82EE),HL
        CALL	C.4BE4			; create window
        POP	BC
        POP	BC
        LD	C,17H
        PUSH	BC
        LD	(D.82F4),HL
        LD	HL,(D.82EE)
        PUSH	HL
        LD	C,1
        PUSH	BC
        LD	HL,(D.82F4)
        LD	E,0
        LD	C,0
        LD	(D.82F4),HL
        CALL	C.4896			; display text
        POP	BC
        POP	BC
        POP	BC
        LD	C,27
        PUSH	BC
        LD	HL,D.82F0
        LD	E,(HL)
        LD	A,E
        INC	A
        JP	NZ,J$5A1D
        LD	HL,0
        JP	J$5A20

J$5A1D:	LD	HL,1
J$5A20:	LD	A,(D.82C8)
        SUB	L
        LD	L,A
        PUSH	HL
        LD	C,10
        LD	E,11
        LD	A,3
        CALL	C.4BE4			; create window
        POP	BC
        POP	BC
        LD	E,0
        LD	A,E
        LD	(D.82F1),A
        LD	(D.82F2),HL
J$5A3A:	LD	A,E
        LD	HL,D.82C8
        CP	(HL)
        JP	NC,J$5AC1
        LD	L,E
        LD	H,0
        LD	BC,D.82C9
        ADD	HL,BC
        LD	A,(HL)			; slotid SRAM
        PUSH	DE
        LD	HL,(D.82F0)
        CP	L
        JP	Z,J$5ABC
        LD	L,E
        LD	H,00H
        LD	BC,I.82D9
        ADD	HL,BC
        LD	A,(HL)
        OR	A			; FMPAC SRAM ?
        JP	NZ,J$5A64		; yep,
        LD	HL,I$59AA
        JP	J$5A67			; PAC text

J$5A64:	LD	HL,I$59B4		; FMPAC text
J$5A67:	PUSH	DE
        PUSH	HL
        LD	HL,6
        ADD	HL,SP
        EX	DE,HL
        LD	BC,10
        POP	HL
        CALL	C.7525			; copy data
        POP	HL
        LD	H,00H
        PUSH	HL
        LD	BC,D.82C9
        ADD	HL,BC
        LD	E,(HL)			; slotid SRAM
        LD	HL,10
        ADD	HL,SP
        CALL	C.61A5			; construct slotid text
        LD	C,1BH
        PUSH	BC
        LD	HL,6
        ADD	HL,SP
        PUSH	HL
        LD	C,0
        PUSH	BC
        LD	A,(D.82F1)
        LD	C,A
        LD	(D.82F1),A
        LD	HL,(D.82F2)
        LD	E,1
        CALL	C.4896			; display text
        POP	BC
        POP	BC
        POP	BC
        POP	HL
        LD	H,00H
        LD	BC,D.82C9
        ADD	HL,BC
        LD	B,(HL)			; slotid SRAM
        LD	A,(D.82F1)
        INC	A
        LD	(D.82F1),A
        DEC	A
        LD	L,A
        LD	H,00H
        EX	DE,HL
        LD	HL,12
        ADD	HL,SP
        ADD	HL,DE
        LD	(HL),B
J$5ABC:	POP	DE
        INC	E
        JP	J$5A3A
;	-----------------
J$5AC1:	LD	C,00H
        PUSH	BC
        LD	HL,(D.82F2)
        LD	E,00H
        LD	C,0FCH
        LD	(D.82F2),HL
        CALL	C.4E12			; activate menu
        POP	BC
        PUSH	AF
        LD	HL,(D.82F2)
        CALL	C.4DC6			; remove window
        LD	HL,(D.82F4)
        CALL	C.4DC6			; remove window
        POP	AF
        CP	0FFH
        JP	Z,J.5AEE
        LD	C,A
        LD	B,00H
        LD	HL,10
        ADD	HL,SP
        ADD	HL,BC
        LD	A,(HL)
J.5AEE:	LD	HL,26
        ADD	HL,SP
        LD	SP,HL
        RET

I$5AF4:	DEFB	0C1H,0AAH,0DDH,0BCH,0DEH,009H,0BDH,0D9H,"PAC"
        DEFB	0CAH,0C4H,0DEH,0DAH,0B6H,0C5H,"?(1)"
        DEFB	0

I$5B0A:	DEFB	0C1H,0AAH,0DDH,0BCH,0DEH,009H,0BDH,0D9H,"PAC"
        DEFB	0CAH,0C4H,0DEH,0DAH,0B6H,0C5H,"?(2)"
        DEFB	0

;	  Subroutine switch SRAM content
;	     Inputs  ________________________
;	     Outputs ________________________

C$5B20:	PUSH	BC
        PUSH	BC
        LD	A,(D.82C8)
        DEC	A			; 2 or more SRAMs found ?
        JP	NZ,J$5B33		; yep,
        LD	E,1			; wait for key
        LD	A,12
        CALL	C.6B39			; display message
        JP	J.5BAA			; quit

J$5B33:	LD	A,(D.82C8)
        CP	2			; 2 SRAMs found ?
        JP	Z,J$5B5B		; yep, no need to select
J$5B3B:	LD	DE,00FFH
        LD	HL,I$5AF4
        CALL	C.59BE			; SRAM selection
        LD	(D.82F6),A		; first SRAM
        CP	0FFH
        JP	Z,J.5BAA		; none selected, quit
        LD	E,A
        LD	HL,I$5B0A
        CALL	C.59BE			; SRAM selection
        CP	0FFH
        JP	NZ,J$5B64
        JP	J$5B3B			; none selected, try again

J$5B5B:	LD	A,(D.82C9+0)		; slotid 1st SRAM
        LD	(D.82F6),A
        LD	A,(D.82C9+1)		; slotid 2nd SRAM
J$5B64:	LD	E,1			; wait for key
        LD	(D.82F7),A
        LD	A,6
        CALL	C.6B39			; display message
        LD	HL,8192-2
        CALL	C.73D3			; allocate memory
        PUSH	HL
        LD	HL,8192-2
        CALL	C.73D3			; allocate memory
        POP	DE
        LD	A,(D.82F6)
        LD	(D.82F6),A		; first SRAM
        PUSH	HL
        PUSH	DE
        PUSH	HL
        CALL	C.8092			; copy SRAM to memory
        POP	DE
        LD	A,(D.82F7)
        LD	(D.82F7),A		; second SRAM
        PUSH	DE
        CALL	C.8092			; copy SRAM to memory
        POP	DE
        LD	A,(D.82F6)		; first SRAM
        CALL	C.80C1			; copy memory to SRAM
        POP	DE
        LD	A,(D.82F7)		; second SRAM
        PUSH	DE
        CALL	C.80C1			; copy memory to SRAM
        POP	HL
        CALL	C.72D5			; free memory
        POP	HL
        CALL	C.72D5			; free memory
J.5BAA:	POP	BC
        POP	BC
        RET

I$5BAD:	DEFB	009H,0BBH,0B8H,0BCH,0DEH,0AEH,0BDH,0D9H,009H,0CCH,0A7H,0B2H,0D9H,03AH
        DEFB	0

;	  Subroutine delete file
;	     Inputs  ________________________
;	     Outputs ________________________

C$5BBC:	LD	HL,-10
        ADD	HL,SP
        LD	SP,HL
        LD	A,(D.8200)
        OR	A			; disksystem ?
        JP	NZ,J.5BD2		; yep,
        LD	E,1			; wait for key
        LD	A,11
        CALL	C.6B39			; display message
        JP	J.5CC8			; quit

J.5BD2:	LD	E,0
        LD	HL,I$5BAD
        CALL	C.518D
        LD	(D.82FC),HL
        LD	A,L
        OR	H			; files found ?
        JP	NZ,J$5BE9		; yep,
        XOR	A
        LD	(D.8029),A
        JP	J.5CC8

J$5BE9:	LD	E,0			; do not wait for key
        LD	A,7
        PUSH	HL
        CALL	C.6B39			; display message
        LD	(D.82FA),HL
        POP	HL
        INC	HL
        PUSH	HL
        LD	HL,2
        ADD	HL,SP
        EX	DE,HL
        LD	BC,8
        POP	HL
        CALL	C.7525			; copy data
        LD	HL,8
        ADD	HL,SP
        LD	(HL),00H
        LD	C,0FCH
        PUSH	BC
        LD	HL,2
        ADD	HL,SP
        PUSH	HL
        LD	C,1
        PUSH	BC
        LD	HL,(D.82FA)
        LD	E,1
        LD	C,0
        LD	(D.82FA),HL
        CALL	C.4896			; display text
        POP	BC
        POP	BC
        POP	BC
        CALL	C.5074			; select file
        LD	HL,(D.82FA)
        PUSH	AF
        CALL	C.4DC6			; remove window
        POP	AF
        OR	A
        JP	Z,J.5BD2
        LD	HL,(D.82FC)
        PUSH	HL
        CALL	C.662C			; open file
        POP	HL
        INC	A			; file open ?
        JP	NZ,J$5C50		; yep,
        LD	A,(D.8029)
        OR	A			; error ?
        JP	NZ,J.5CC4		; yep, quit
J$5C46:	LD	E,1			; wait for key
        LD	A,14
        CALL	C.6B39			; display message
        JP	J.5BD2

J$5C50:	PUSH	HL
        LD	HL,8192-2+16
        CALL	C.73D3			; allocate memory
        LD	(D.82F8),HL
        EX	DE,HL
        POP	HL
        LD	BC,8192-2+16
        CALL	C.6608			; read from file
        LD	A,L
        CP	LOW (8192-2+16)
        JP	NZ,J$5C6B
        LD	A,H
        CP	HIGH (8192-2+16)
J$5C6B:	JP	NZ,J$5C78		; filesize incorrect,
        LD	HL,(D.82FC)
        CALL	C.6617			; close file
        INC	A			; closed ok ?
        JP	NZ,J$5C8F		; yep,
J$5C78:	LD	HL,(D.82F8)
        CALL	C.72D5			; free memory
        LD	A,(D.8029)
        OR	A			; error ?
        JP	NZ,J.5CC4		; yep, quit
J$5C85:	LD	E,1			; wait for key
        LD	A,16
        CALL	C.6B39			; display message
        JP	J.5BD2

J$5C8F:	LD	HL,(D.82F8)
        LD	A,(HL)
        CP	"P"
        JP	Z,J$5C9E
        CALL	C.72D5			; free memory
        JP	J$5C85

J$5C9E:	CALL	C.72D5			; free memory
        LD	E,0			; do not wait for key
        LD	A,8
        CALL	C.6B39			; display message
        PUSH	HL
        LD	HL,(D.82FC)
        CALL	C$65E4			; delete file
        LD	(D.82FE),A
        POP	HL
        CALL	C.4DC6			; remove window
        LD	A,(D.8029)
        OR	A			; error ?
        JP	NZ,J.5CC4		; yep, quit
        LD	A,(D.82FE)
        INC	A
        JP	Z,J$5C46
J.5CC4:	XOR	A
        LD	(D.8029),A
J.5CC8:	POP	BC
        POP	BC
        POP	BC
        POP	BC
        POP	BC
        RET

I$5CCE:	DEFB	"PAC    -> PAC",00AH
        DEFB	"PAC    -> ",0CCH,0DBH,0AFH,0CBH,0DFH,0B0H,00AH
        DEFB	0CCH,0DBH,0AFH,0CBH,0DFH,0B0H," -> PAC"
        DEFB	0

;	  Subroutine copy SRAM content
;	     Inputs  ________________________
;	     Outputs ________________________

C$5CFB:	LD	A,(D.82C8)
        DEC	A			; 2 or more SRAMs found ?
        JP	NZ,J.5D11		; yep, copy possible
        LD	A,(D.8200)
        OR	A			; disksystem ?
        JP	NZ,J.5D11		; yep, copy possible
        LD	E,1			; wait for key
        LD	A,10
        CALL	C.6B39			; display message
        RET

J.5D11:	LD	C,27
        PUSH	BC
        LD	C,6
        PUSH	BC
        LD	C,16
        LD	E,15
        LD	A,13
        CALL	C.4BE4			; create window
        POP	BC
        POP	BC
J$5D22:	LD	(D.82FF),HL
        LD	C,1BH
        PUSH	HL
        PUSH	BC
        LD	BC,I$5CCE
        PUSH	BC
        LD	C,1
        PUSH	BC
        LD	E,0
        LD	C,0
        CALL	C.4896			; display text
        POP	BC
        POP	BC
        POP	BC
J.5D3A:	LD	C,00H
        PUSH	BC
        LD	HL,(D.82FF)
        LD	E,01H	; 1 
        LD	C,0FCH
        CALL	C.4E12			; activate menu
        POP	BC
        OR	A
        JP	Z,J$5D59		; copy SRAM to SRAM
        CP	1
        JP	Z,J$5D63		; copy SRAM to file
        CP	2
        JP	Z,J$5D6D		; copy file to SRAM
        JP	J.5D77			; quit

J$5D59:	CALL	C$5FBC
        OR	A
        JP	Z,J.5D77		; quit
        JP	J.5D3A

J$5D63:	CALL	C$5DC2
        OR	A
        JP	Z,J.5D77		; quit
        JP	J.5D3A

J$5D6D:	CALL	C$5EC1
        OR	A
        JP	Z,J.5D77		; quit
        JP	J.5D3A

J.5D77:	POP	HL
        CALL	C.4DC6			; remove window
        RET

I.5D7C:	DEFB	"PAC2 BACKUP DATA"
        DEFB	0

I.5D8D:	DEFB	0BAH,0CBH,0DFH,0B0H,009H,0D3H,0C4H,0C9H,"PAC",0CAH,0C4H,0DEH,0DAH,0B6H,0C5H,03FH
        DEFB	0

I.5DA0:	DEFB	0BAH,0CBH,0DFH,0B0H,009H,0BBH,0B7H,0C9H,"PAC",0CAH,0C4H,0DEH,0DAH,0B6H,0C5H,03FH
        DEFB	0

I$5DB3:	DEFB	0BAH,0CBH,0DFH,0B0H,009H,0BBH,0B7H,0C9H,009H,00CH,0A7H,0B2H,0D9H,03AH
        DEFB	0

;	  Subroutine copy SRAM to file
;	     Inputs  ________________________
;	     Outputs ________________________

C$5DC2:	LD	A,(D.8200)
        OR	A			; disksystem ?
        JP	NZ,J.5DD3		; yep,
        LD	E,1			; wait for key
        LD	A,11
        CALL	C.6B39			; display message
        LD	A,1
        RET

J.5DD3:	LD	DE,00FFH
        LD	HL,I.5D8D
        CALL	C.59BE			; SRAM selection
        LD	(D.8303),A
        INC	A
        JP	NZ,J.5DE6
        LD	A,1
        RET

J.5DE6:	LD	E,1
        LD	HL,I$5DB3
        CALL	C.518D
        LD	(D.8301),HL
        LD	A,L
        OR	H
        JP	NZ,J$5E0C
        LD	A,(D.8029)
        OR	A
        JP	Z,J$5E02
J$5DFD:	XOR	A
        LD	(D.8029),A
        RET
;	-----------------
J$5E02:	LD	A,(D.82C8)
        DEC	A			; 2 or more SRAMs found ?
        JP	NZ,J.5DD3		; yep,
        LD	A,01H	; 1 
        RET
;	-----------------
J$5E0C:	PUSH	HL
        CALL	C.662C			; open file
        POP	HL
        OR	A
        JP	NZ,J$5E26
        PUSH	HL
        CALL	C.6617			; close file
        POP	HL
        PUSH	HL
        CALL	C$606A
        POP	HL
        OR	A
        JP	NZ,J$5E2D
        JP	J.5DE6
;	-----------------
J$5E26:	LD	A,(D.8029)
        OR	A
        JP	NZ,J$5DFD
J$5E2D:	PUSH	HL
        LD	E,0			; do not wait for key
        LD	A,5
        CALL	C.6B39			; display message
        LD	(D.8306),HL
        LD	HL,8192-2+16
        CALL	C.73D3			; allocate memory
        LD	E,L
        LD	D,H
        PUSH	HL
        LD	BC,16
        LD	HL,I.5D7C		; PAC file indentifier
        CALL	C.7525			; copy data
        POP	HL
        LD	(D.8304),HL
        LD	BC,16
        ADD	HL,BC
        EX	DE,HL
        LD	A,(D.8303)
        CALL	C.8092			; copy SRAM to memory
        POP	HL
        LD	DE,8192-2+16
        PUSH	HL
        CALL	C$6647			; create file
        POP	HL
        INC	A
        JP	Z,J.5E88
        PUSH	HL
        LD	HL,(D.8304)
        EX	DE,HL
        POP	HL
        LD	BC,8192-2+16
        CALL	C$65F9			; write to file
        LD	A,L
        CP	LOW (8192-2+16)
        JP	NZ,J$5E7B
        LD	A,H
        CP	HIGH (8192-2+16)
J$5E7B:	JP	NZ,J.5E88
        LD	HL,(D.8301)
        CALL	C.6617			; close file
        INC	A
        JP	NZ,J$5EA2
J.5E88:	LD	A,(D.8029)
        OR	A
        JP	Z,J$5E96
        XOR	A
        LD	(D.8029),A
        JP	J.5EA3
;	-----------------
J$5E96:	LD	E,1			; wait for key
        LD	A,15
        CALL	C.6B39			; display message
        LD	A,01H	; 1 
        JP	J.5EA3
;	-----------------
J$5EA2:	XOR	A
J.5EA3:	LD	HL,(D.8304)
        PUSH	AF
        CALL	C.72D5			; free memory
        LD	HL,(D.8306)
        CALL	C.4DC6			; remove window
        POP	AF
        RET

I$5EB2:	DEFB	0BAH,0CBH,0DFH,0B0H,009H,0D3H,0C4H,0C9H,009H,0CCH,0A7H,0B2H,0D9H,03AH
        DEFB	0

;	  Subroutine copy file to SRAM
;	     Inputs  ________________________
;	     Outputs ________________________

C$5EC1:	LD	A,(D.8200)
        OR	A			; disksystem ?
        JP	NZ,J.5ED2		; yep,
        LD	E,1			; wait for key
        LD	A,11
        CALL	C.6B39			; display message
        LD	A,1
        RET

J.5ED2:	LD	E,0
        LD	HL,I$5EB2
        CALL	C.518D
        LD	(D.8308),HL
        LD	A,L
        OR	H
        JP	NZ,J.5EF1
        LD	A,(D.8029)
        OR	A
        JP	Z,J$5EEE
        XOR	A
        LD	(D.8029),A
        RET
;	-----------------
J$5EEE:	LD	A,01H	; 1 
        RET
;	-----------------
J.5EF1:	LD	DE,00FFH
        LD	HL,I.5DA0
        CALL	C.59BE			; SRAM selection
        LD	(D.830A),A
        CP	0FFH
        JP	Z,J.5ED2
        CALL	C.6025
        OR	A
        JP	NZ,J$5F13
        LD	A,(D.82C8)
        DEC	A			; 2 or more SRAMs found ?
        JP	NZ,J.5EF1		; yep,
        JP	J.5ED2
;	-----------------
J$5F13:	LD	E,0			; do not wait for key
        LD	A,5
        CALL	C.6B39			; display message
        LD	(D.830D),HL
        LD	HL,8192-2+16
        CALL	C.73D3			; allocate memory
        LD	E,L
        LD	D,H
        PUSH	HL
        LD	BC,16
        LD	HL,I.5D7C		; PAC file indentifier
        CALL	C.7525			; copy data
        LD	HL,(D.8308)
        CALL	C.662C			; open file
        POP	HL
        LD	(D.830B),HL
        INC	A
        JP	NZ,J$5F57
        LD	A,(D.8029)
        OR	A
        JP	Z,J$5F4B
        XOR	A
        LD	(D.8029),A
        JP	J.5FA8
;	-----------------
J$5F4B:	LD	E,1			; wait for key
        LD	A,14
        CALL	C.6B39			; display message
        LD	A,02H	; 2 
        JP	J.5FA8
;	-----------------
J$5F57:	LD	E,L
        LD	D,H
        PUSH	HL
        LD	HL,(D.8308)
        LD	BC,8192-2+16
        CALL	C.6608			; read from file
        POP	BC
        LD	A,L
        CP	LOW (8192-2+16)
        JP	NZ,J$5F6D
        LD	A,H
        CP	HIGH (8192-2+16)
J$5F6D:	JP	NZ,J$5F7C
        PUSH	BC
        LD	HL,(D.8308)
        CALL	C.6617			; close file
        POP	BC
        INC	A
        JP	NZ,J$5F96
J$5F7C:	LD	A,(D.8029)
        OR	A
        JP	Z,J.5F8A
        XOR	A
        LD	(D.8029),A
        JP	J.5FA8
;	-----------------
J.5F8A:	LD	E,1			; wait for key
        LD	A,16
        CALL	C.6B39			; display message
        LD	A,02H	; 2 
        JP	J.5FA8
;	-----------------
J$5F96:	LD	A,(BC)
        CP	50H	; "P"
        JP	NZ,J.5F8A
        LD	HL,16
        ADD	HL,BC
        EX	DE,HL
        LD	A,(D.830A)
        CALL	C.80C1			; copy memory to SRAM
        XOR	A
J.5FA8:	PUSH	AF
        LD	HL,(D.830D)
        CALL	C.4DC6			; remove window
        LD	HL,(D.830B)
        CALL	C.72D5			; free memory
        POP	AF
        CP	02H	; 2 
        RET	NZ
        JP	J.5ED2

;	  Subroutine copy SRAM to SRAM
;	     Inputs  ________________________
;	     Outputs ________________________

C$5FBC:	LD	A,(D.82C8)
        DEC	A			; 2 or more SRAMs found ?
        JP	NZ,J.5FCD		; yep,
        LD	E,1			; wait for key
        LD	A,12
        CALL	C.6B39			; display message
        LD	A,1
        RET

J.5FCD:	LD	DE,00FFH
        LD	HL,I.5D8D
        CALL	C.59BE			; SRAM selection
        LD	(D.830F),A
        INC	A
        JP	NZ,J.5FE0
        LD	A,01H	; 1 
        RET
;	-----------------
J.5FE0:	LD	A,(D.830F)
        LD	E,A
        LD	HL,I.5DA0
        CALL	C.59BE			; SRAM selection
        LD	(D.8310),A
        CP	0FFH
        JP	Z,J.5FCD
        CALL	C.6025
        OR	A
        JP	Z,J.5FE0
        LD	E,1			; wait for key
        LD	A,5
        CALL	C.6B39			; display message
        LD	HL,8192-2+16
        CALL	C.73D3			; allocate memory
        PUSH	HL
        LD	BC,16
        ADD	HL,BC
        EX	DE,HL
        LD	A,(D.830F)
        CALL	C.8092			; copy SRAM to memory
        POP	HL
        PUSH	HL
        LD	BC,16
        ADD	HL,BC
        EX	DE,HL
        LD	A,(D.8310)
        CALL	C.80C1			; copy memory to SRAM
        POP	HL
        CALL	C.72D5			; free memory
        XOR	A
        RET

;	  Subroutine __________________________
;	     Inputs  ________________________
;	     Outputs ________________________

C.6025:	PUSH	BC
        PUSH	BC
        LD	E,0			; do not wait for key
        LD	(D.8311),A
        LD	A,3
        CALL	C.6B39			; display message
        LD	(D.8312),HL
        PUSH	HL
        LD	HL,D.8311
        LD	E,(HL)
        LD	HL,2
        ADD	HL,SP
        CALL	C.61A5			; construct slotid text
        LD	HL,5
        ADD	HL,SP
        LD	(HL),00H
        LD	C,0FCH
        PUSH	BC
        LD	HL,4
        ADD	HL,SP
        PUSH	HL
        LD	C,1
        PUSH	BC
        LD	HL,(D.8312)
        LD	E,8
        LD	C,0
        CALL	C.4896			; display text
        POP	BC
        POP	BC
        POP	BC
        CALL	C.5074			; select file
        POP	HL
        PUSH	AF
        CALL	C.4DC6			; remove window
        POP	AF
        POP	BC
        POP	BC
        RET
;	-----------------

;	  Subroutine __________________________
;	     Inputs  ________________________
;	     Outputs ________________________

C$606A:	LD	(D.8314),HL
        LD	HL,-10
        ADD	HL,SP
        LD	SP,HL
        LD	HL,(D.8314)
        LD	E,0			; do not wait for key
        LD	A,4
        LD	(D.8314),HL
        CALL	C.6B39			; display message
        LD	(D.8316),HL
        PUSH	HL
        LD	HL,(D.8314)
        INC	HL
        PUSH	HL
        LD	HL,4
        ADD	HL,SP
        EX	DE,HL
        LD	BC,8
        POP	HL
        CALL	C.7525			; copy data
        LD	HL,10
        ADD	HL,SP
        LD	(HL),00H
        LD	C,0FCH
        PUSH	BC
        LD	HL,4
        ADD	HL,SP
        PUSH	HL
        LD	C,1
        PUSH	BC
        LD	HL,(D.8316)
        LD	E,1
        LD	C,0
        CALL	C.4896			; display text
        POP	BC
        POP	BC
        POP	BC
        CALL	C.5074			; select file
        POP	HL
        PUSH	AF
        CALL	C.4DC6			; remove window
        POP	AF
        POP	BC
        POP	BC
        POP	BC
        POP	BC
        POP	BC
        RET

I$60C1:	DEFB	0B8H,0D8H,0B1H,009H,0BDH,0D9H,"PAC",0CAH,0C4H,0DEH,0DAH,0B6H,0C5H,03FH
        DEFB	0

;	  Subroutine clear SRAM content
;	     Inputs  ________________________
;	     Outputs ________________________

C$60D2:	PUSH	BC
        PUSH	BC
J$60D4:	LD	DE,00FFH
        LD	HL,I$60C1
        CALL	C.59BE			; SRAM selection
        LD	(D.831A),A
        CP	0FFH
        JP	Z,J.6151		; none selected, quit
        LD	E,0			; do not wait for key
        PUSH	AF
        LD	A,1
        CALL	C.6B39			; display message
        POP	DE
        LD	E,D
        PUSH	HL
        LD	(D.8318),HL
        LD	HL,2
        ADD	HL,SP
        CALL	C.61A5			; construct slotid text
        LD	HL,5
        ADD	HL,SP
        LD	(HL),00H
        LD	C,0FCH
        PUSH	BC
        LD	HL,4
        ADD	HL,SP
        PUSH	HL
        LD	C,1
        PUSH	BC
        LD	HL,(D.8318)
        LD	E,5
        LD	C,0
        CALL	C.4896			; display text
        POP	BC
        POP	BC
        POP	BC
        CALL	C.5074			; select file
        POP	HL
        PUSH	AF
        CALL	C.4DC6			; remove window
        POP	AF
        OR	A
        JP	NZ,J$612F
        LD	A,(D.82C8)
        DEC	A			; 2 or more SRAMs found ?
        JP	NZ,J$60D4		; yep,
        JP	J.6151

J$612F:	LD	E,1			; wait for key
        LD	A,2
        CALL	C.6B39			; display message
        LD	HL,8192-2
        CALL	C.73D3			; allocate memory
        LD	DE,8192-2
        LD	C,0FFH
        PUSH	HL
        CALL	C.7515			; clear
        POP	DE
        LD	A,(D.831A)
        PUSH	DE
        CALL	C.80C1			; copy memory to SRAM
        POP	HL
        CALL	C.72D5			; free memory
J.6151:	POP	BC
        POP	BC
        RET

;	  Subroutine display slotid SRAM
;	     Inputs  ________________________
;	     Outputs ________________________

C$6154:	PUSH	BC
        PUSH	BC
        LD	A,(D.82C8)
        DEC	A			; 2 or more SRAMs found ?
        JP	Z,J$6167		; nope,
        LD	E,1			; wait for key
        LD	A,13
        CALL	C.6B39			; display message
        JP	J$61A2			; quit

J$6167:	LD	E,0			; do not wait for key
        LD	A,9
        CALL	C.6B39			; display message
        LD	A,(D.82C9+0)		; slotid 1st SRAM
        LD	E,A
        PUSH	HL
        LD	(D.831B),HL
        LD	HL,2
        ADD	HL,SP
        CALL	C.61A5			; construct slotid text
        LD	HL,5
        ADD	HL,SP
        LD	(HL),00H
        LD	C,0FCH
        PUSH	BC
        LD	HL,4
        ADD	HL,SP
        PUSH	HL
        LD	C,1
        PUSH	BC
        LD	HL,(D.831B)
        LD	E,10
        LD	C,2
        CALL	C.4896			; display text
        POP	BC
        POP	BC
        POP	BC
        CALL	C.63D2			; wait for up/down/esc or space key
        POP	HL
        CALL	C.4DC6			; remove window
J$61A2:	POP	BC
        POP	BC
        RET

;	  Subroutine __________________________
;	     Inputs  ________________________
;	     Outputs ________________________

C.61A5:	LD	C,E
        EX	DE,HL
        LD	A,C
        AND	80H
        JP	NZ,J$61BE
        LD	HL,2
        ADD	HL,DE
        LD	A," "
        LD	(HL),A
        LD	(DE),A
        LD	A,C
        ADD	A,"0"
        LD	HL,1
        ADD	HL,DE
        LD	(HL),A
        RET

J$61BE:	LD	A,C
        AND	03H
        ADD	A,"0"
        LD	(DE),A
        LD	A,C
        RRCA
        RRCA
        AND	3FH
        AND	03H
        ADD	A,"1"
        LD	HL,2
        ADD	HL,DE
        LD	(HL),A
        LD	HL,1
        ADD	HL,DE
        LD	(HL),"-"
        RET

;	  Subroutine __________________________
;	     Inputs  ________________________
;	     Outputs ________________________

C$61D9:	LD	HL,I$61F6
        LD	DE,I.8000
        LD	BC,43
        LD	(D$F323),DE
        LDIR
        CALL	C.74C8			; get current slotid in page 1
        LD	(D.8008),A
        RET

;	  Subroutine make BDOS call
;	     Inputs  ________________________
;	     Outputs ________________________

C.61EF:	LD	(D.8027),SP
        JP	J$F37D

I$61F6:
        .PHASE	08000H

        DEFW	I$8002

I$8002:	PUSH	IX
        PUSH	IY
        LD	A,C
        RST	30H
D.8008:	DEFB	0
        DEFW	I$62D6
        POP	IY
        POP	IX
        LD	C,A
        EI
        CP	2
        RET	NZ
        LD	SP,(D.8027)
        LD	A,(D.8008)
        LD	HL,I.4000
        CALL	ENASLT			; restore FM-PAC in page 1
        LD	A,0FFH
        LD	H,A
        LD	L,A
        EI
        RET

D.8027:	DEFW	0
D.8029:	DEFB	0

        .DEPHASE

I$6220:	DEFW	I$622E
        DEFW	I$6244
        DEFW	I$625D
        DEFW	I$6269
        DEFW	I$6275
        DEFW	I$6291
        DEFW	I$62AA

I$622E:	DEFB	009H,0D1H,0D1H,0A4H,0B6H,0B7H,0BAH,0D0H
        DEFB	0B7H,0DDH,0BCH,0C6H,0C5H,0AFH,0C3H,0B2H
        DEFB	0D9H,0BFH,0DEH,21H,21H
        DEFB	0

I$6244:	DEFB	0CCH,0DBH,0AFH,0CBH,0DFH,0B0H,009H,0B6H
        DEFB	0DEH,009H,0BEH,0AFH,0C4H,009H,0BBH,0DAH
        DEFB	0C3H,0B2H,0C5H,0B2H,0BFH,0DEH,021H,021H
        DEFB	0

I$625D:	DEFB	009H,0D6H,0D0H,0BAH,0D2H,0C5H,0B2H,0BFH
        DEFB	0DEH,021H,021H
        DEFB	0

I$6269:	DEFB	009H,0B6H,0B7H,0BAH,0D2H,0C5H,0B2H,0BFH
        DEFB	0DEH,021H,021H
        DEFB	0

I$6275:	DEFB	009H,0BAH,0C9H,009H,0CCH,0DBH,0AFH,0CBH
        DEFB	0DFH,0B0H,009H,0CAH,04DH,053H,058H,0C3H
        DEFB	0DEH,0CAH,0C2H,0B6H,0B4H,0C5H,0B2H,0BFH
        DEFB	0DEH,021H,021H
        DEFB	0

I$6291:	DEFB	009H,0BAH,0C9H,009H,0CCH,0DBH,0AFH,0CBH
        DEFB	0DFH,0B0H,009H,0CAH,0BAH,0DCH,0DAH,0C3H
        DEFB	0B2H,0D9H,0D6H,0B3H,0C0H,0DEH,021H,021H
        DEFB	0

I$62AA:	DEFB	009H,0BAH,0C9H,009H,0CCH,0DBH,0AFH,0CBH
        DEFB	0DFH,0B0H,009H,0CAH,04DH,053H,058H,0C3H
        DEFB	0DEH,0CAH,0C2H,0B6H,0B4H,0C5H,0B2H,0BFH
        DEFB	0DEH,021H,021H
        DEFB	0

I$62C6:	DEFB	009H,0D3H,0B3H,0B2H,0C1H,0C4H,0DEH,0C0H
        DEFB	0D2H,0BCH,0C3H,0D0H,0D9H,0B6H,03FH
        DEFB	0

I$62D6:	LD	(D.831D),A
        AND	80H
        JP	Z,J$62E3
        LD	A,5
        JP	J.6328

J$62E3:	LD	A,(D.831D)
        RRCA
        AND	7FH
        OR	A
        JP	Z,J$6309
        CP	1
        JP	Z,J$630D
        CP	2
        JP	Z,J.6312
        CP	3
        JP	Z,J.6312
        CP	4
        JP	Z,J.6312
        CP	5
        JP	Z,J.6312
        JP	J$6326

J$6309:	XOR	A
        JP	J.6328

J$630D:	LD	A,1
        JP	J.6328

J.6312:	LD	A,(D.831D)
        CP	10
        JP	NZ,J$631F
        LD	A,6
        JP	J.6328

J$631F:	AND	01H	; 1 
        INC	A
        INC	A
        JP	J.6328

J$6326:	LD	A,4
J.6328:	LD	C,26
        PUSH	BC
        LD	C,4
        PUSH	BC
        LD	C,24
        LD	E,11
        LD	(D.831D),A
        LD	A,4
        CALL	C.4BE4			; create window
        POP	BC
        POP	BC
        LD	C,1AH
        PUSH	HL
        PUSH	BC
        LD	(D.831F),HL
        LD	HL,(D.831D)
        LD	H,0
        ADD	HL,HL
        LD	BC,I$6220
        ADD	HL,BC
        LD	C,(HL)
        INC	HL
        LD	B,(HL)
        PUSH	BC
        LD	C,1
        PUSH	BC
        LD	HL,(D.831F)
        LD	E,0
        LD	C,0
        LD	(D.831F),HL
        CALL	C.4896			; display text
        POP	BC
        POP	BC
        POP	BC
        LD	C,1AH
        PUSH	BC
        LD	BC,I$62C6
        PUSH	BC
        LD	C,1
        PUSH	BC
        LD	HL,(D.831F)
        LD	E,0
        LD	C,2
        CALL	C.4896			; display text
        POP	BC
        POP	BC
        POP	BC
        LD	A,01H	; 1 
        LD	(D.831E),A
        CALL	C.5074			; select file
        OR	A
        JP	NZ,J$6391
        LD	A,02H	; 2 
        LD	(D.831E),A
        LD	A,1
        LD	(D.8029),A
J$6391:	POP	HL
        CALL	C.4DC6			; remove window
        LD	A,(D.831E)
        RET
;	-----------------

;	  Subroutine __________________________
;	     Inputs  ________________________
;	     Outputs ________________________

C.6399:	EX	DE,HL
J$639A:	DEC	DE
        LD	HL,1
        ADD	HL,DE
        LD	A,L
        OR	H
        JP	Z,J$63B0
        PUSH	DE
        CALL	C.67B8
        POP	DE
        OR	A
        JP	Z,J$639A
        LD	A,01H	; 1 
        RET
;	-----------------
J$63B0:	XOR	A
        RET
;	-----------------

;	  Subroutine __________________________
;	     Inputs  ________________________
;	     Outputs ________________________

C.63B2:	CALL	CHGET
        LD	(D.8321),A
        CP	1
        RET	NZ
        CALL	CHGET
        JP	C.63B2

;	  Subroutine get navigationkey
;	     Inputs  ________________________
;	     Outputs ________________________

C.63C1:	CALL	C.63B2			; get key
        CP	1EH
        RET	Z			; up, quit
        CP	1FH
        RET	Z			; down, quit
        CP	1BH
        RET	Z			; esc, quit
        CP	20H
        RET	Z			; spacebar, quit
        XOR	A
        RET

;	  Subroutine wait for up/down/esc or space key
;	     Inputs  ________________________
;	     Outputs ________________________

C.63D2:	CALL	C.63C1			; get nagivation key
        OR	A
        JP	Z,C.63D2		; no nagivation key, get next
        RET

I$63DA:	DEFB	0BBH,0DDH,0CCH,0DFH,0D9H,20H,31H,00AH
        DEFB	0BBH,0DDH,0CCH,0DFH,0D9H,20H,32H,00AH
        DEFB	0BBH,0DDH,0CCH,0DFH,0D9H,20H,33H,00AH
        DEFB	0BBH,0DDH,0CCH,0DFH,0D9H,20H,34H,00AH
        DEFB	0BBH,0DDH,0CCH,0DFH,0D9H,20H,35H,00AH
        DEFB	0BDH,0C4H,0AFH,0CCH,0DFH
        DEFB	0

;	  Subroutine select BGM
;	     Inputs  ________________________
;	     Outputs ________________________

C$6408:	PUSH	BC
        PUSH	BC
        LD	C,27
        PUSH	BC
        LD	C,12
        PUSH	BC
        LD	C,8
J$6412:	LD	E,3
        LD	A,3
        CALL	C.4BE4			; create window
        POP	BC
        POP	BC
J$641B:	LD	C,1BH
        PUSH	BC
        LD	BC,I$63DA
        PUSH	BC
        LD	C,1
J$6424:	PUSH	BC
        LD	E,0
        LD	C,0
        LD	(D.8327),HL
        CALL	C.4896			; display text
J$642D	EQU	$-2
        POP	BC
        POP	BC
        POP	BC
        LD	C,02H	; 2 
        PUSH	BC
        LD	HL,(D.8327)
J$6436	EQU	$-2
        LD	E,01H	; 1 
        LD	C,0FCH
        LD	(D.8327),HL
        CALL	C.4E12			; activate menu
        POP	BC
        PUSH	AF
        LD	HL,(D.8327)
        CALL	C.4DC6			; remove window
        POP	AF
        OR	A
        JP	Z,J.6470
        CP	1
        JP	Z,J.6470
        CP	2
        JP	Z,J.6470
        CP	3
        JP	Z,J.6470
        CP	4
        JP	Z,J.6470
        CP	5
        JP	Z,J$647B
        CP	6
        JP	Z,J$6481
        JP	J.64E3			; quit

J.6470:	PUSH	AF
        CALL	C.6551			; stop playing BGM
        POP	AF
        CALL	C.64E6			; start playing BGM
        JP	J.64E3			; quit

J$647B:	CALL	C.6551			; stop playing BGM
        JP	J.64E3			; quit

J$6481:	CALL	C.6551			; stop playing BGM
        LD	C,31
        PUSH	AF
        PUSH	BC
        LD	C,11
        PUSH	BC
        LD	C,25
        LD	E,11
        LD	A,3
        CALL	C.4BE4			; create window
        POP	BC
        POP	BC
        LD	C,23
        PUSH	HL
        PUSH	BC
        LD	C,2
        PUSH	BC
        LD	C,15
        LD	E,1
        LD	A,13
        LD	(D.8329),HL
        CALL	C.4BE4			; create window
        POP	BC
        POP	BC
        EX	DE,HL
        LD	HL,4
        ADD	HL,SP
        PUSH	DE
        EX	DE,HL
        LD	HL,(D.8329)
        EX	DE,HL
        LD	(HL),E
        INC	HL
        LD	(HL),D
        LD	HL,8
        ADD	HL,SP
        POP	DE
        LD	(HL),E
        INC	HL
        LD	(HL),D
        PUSH	DE
        LD	E,3			; bank 3
        LD	HL,I.4082
        CALL	C.402C			; read word from FMPAC bank
        PUSH	HL
        LD	E,3			; bank 3
        LD	HL,8
        ADD	HL,SP
        LD	C,L
        LD	B,H
        POP	HL
        CALL	C.4023			; start routine in bank
        POP	HL
        CALL	C.4DC6			; remove window
        POP	HL
        CALL	C.4DC6			; remove window
        POP	AF
        CALL	C.64E6			; start playing BGM
J.64E3:	POP	BC
        POP	BC
        RET

;	  Subroutine start playing BGM
;	     Inputs  ________________________
;	     Outputs ________________________

C.64E6:	PUSH	AF
        CP	0FFH
        JP	Z,J$654C
        LD	HL,256
        PUSH	AF
        CALL	C.73D3			; allocate memory
        INC	HL
        LD	A,L
        AND	0FEH
        LD	L,A
        LD	(D.8323),HL
        POP	HL
        LD	L,H
        LD	H,0
        ADD	HL,HL
        LD	BC,I.4080
        ADD	HL,BC
        LD	E,2			; bank 2
        CALL	C.402C			; read word from FMPAC bank
        LD	E,2			; bank 2
        LD	(D.832B),HL
        CALL	C.402C			; read word from FMPAC bank
        LD	(D.832D),HL
        CALL	C.73D3			; allocate memory
        LD	(D.8325),HL
        LD	C,2			; bank 2
        PUSH	BC
        LD	HL,(D.832D)
        LD	C,L
        LD	B,H
        LD	HL,(D.832B)
        INC	HL
        INC	HL
        EX	DE,HL
        LD	HL,(D.8325)
        CALL	C.4026			; transfer from/to FMPAC bank
        POP	BC
        LD	HL,(D.8323)
        CALL	C$65B1			; INIOPL
        LD	HL,08000H
        CALL	C.74CF			; get current slotid in page 2
        LD	E,A
        PUSH	DE
        CALL	C.74C8			; get current slotid in page 1
        POP	DE
        CALL	C$6575			; initialize player on interrupt hook
        LD	HL,(D.8325)
        EX	DE,HL
        XOR	A
        CALL	C$65BB			; MSTART
J$654C:	POP	AF
        LD	(D.8322),A
        RET

;	  Subroutine __________________________
;	     Inputs  ________________________
;	     Outputs ________________________

C.6551:	LD	A,(D.8322)
        INC	A			; BGM playing ?
        JP	Z,J$656A		; nope,
        CALL	C$65C6			; MSTOP
        CALL	C$65A3
        LD	HL,(D.8323)
        CALL	C.72D5			; free memory
        LD	HL,(D.8325)
        CALL	C.72D5			; free memory
J$656A:	LD	A,(D.8322)
        PUSH	AF
        LD	A,0FFH
        LD	(D.8322),A		; no BGM playing
        POP	AF
        RET

;	  Subroutine __________________________
;	     Inputs  ________________________
;	     Outputs ________________________

C$6575:	PUSH	DE
        LD	HL,I$65CF
        LD	DE,I.8100
        LD	BC,22
        LDIR
        LD	HL,H.TIMI
        PUSH	HL
        LD	DE,J.832F
        LD	BC,5
        LDIR
        LD	(D$810E),A
        POP	HL
        DI
        LD	(HL),0F7H
        INC	HL
        POP	DE
        LD	(HL),E
        INC	HL
        LD	DE,I.8100
        LD	(HL),E
        INC	HL
        LD	(HL),D
        INC	HL
        LD	(HL),0C9H
        EI
        RET

;	  Subroutine __________________________
;	     Inputs  ________________________
;	     Outputs ________________________

C$65A3:	DI
        LD	HL,J.832F
        LD	DE,H.TIMI
        LD	BC,5
        LDIR
        EI
        RET

;	  Subroutine start INIOPL
;	     Inputs  ________________________
;	     Outputs ________________________


C$65B1:	EXX
        LD	HL,I$4113
        LD	E,0			; bank 0
        EXX
        JP	C.4020			; start routine in bank

;	  Subroutine start MSTART
;	     Inputs  ________________________
;	     Outputs ________________________


C$65BB:	EXX
        LD	HL,I$4116
        LD	E,0			; bank 0
        EXX
        EX	DE,HL
        JP	C.4020			; start routine in bank

;	  Subroutine start MSTOP
;	     Inputs  ________________________
;	     Outputs ________________________


C$65C6:	LD	HL,I$4119
        LD	E,0			; bank 0
        EXX
        JP	C.4020			; start routine in bank

I$65CF:	DI
        LD	HL,(D.8334)
        INC	HL
        LD	(D.8334),HL
        LD	HL,I$411F		; OPLDRV
        LD	E,0			; bank 0
        RST	30H
        DEFB	0
        DEFW	C.4023			; start routine in bank
        EI
        JP	J.832F			; continue in old H.TIMI

;	  Subroutine __________________________
;	     Inputs  ________________________
;	     Outputs ________________________

C$65E4:	EX	DE,HL
        LD	A,13H			; delete file
        CALL	C.7506			; make BDOS call
        INC	A
        JP	NZ,J$65F4
        LD	HL,C.FFFF
        JP	J$65F7

J$65F4:	LD	HL,0
J$65F7:	LD	A,L
        RET

;	  Subroutine __________________________
;	     Inputs  ________________________
;	     Outputs ________________________

C$65F9:	LD	A,1AH			; set DMA address
        PUSH	HL
        PUSH	BC
        CALL	C.7506			; make BDOS call
        POP	BC
        POP	DE
        LD	A,26H			; write random block
        CALL	C.7506			; make BDOS call
        RET

;	  Subroutine __________________________
;	     Inputs  ________________________
;	     Outputs ________________________

C.6608:	LD	A,1AH			; set DMA address
        PUSH	HL
        PUSH	BC
        CALL	C.7506			; make BDOS call
        POP	BC
        POP	DE
        LD	A,27H			; read random block
        CALL	C.7506			; make BDOS call
        RET

;	  Subroutine __________________________
;	     Inputs  ________________________
;	     Outputs ________________________

C.6617:	EX	DE,HL
        LD	A,10H			; close file
        CALL	C.7506			; make BDOS call
        INC	A
        JP	NZ,J$6627
        LD	HL,C.FFFF
        JP	J$662A

J$6627:	LD	HL,0
J$662A:	LD	A,L
        RET

;	  Subroutine open file
;	     Inputs  ________________________
;	     Outputs ________________________

C.662C:	LD	E,L
        LD	D,H
        LD	A,0FH			; open file
        PUSH	HL
        CALL	C.7506			; make BDOS call
        POP	HL
        INC	A
        JP	NZ,J$663C
        LD	A,0FFH
        RET

J$663C:	LD	BC,14
        ADD	HL,BC
        LD	(HL),LOW 1
        INC	HL
        LD	(HL),HIGH 1
        XOR	A
        RET

;	  Subroutine __________________________
;	     Inputs  ________________________
;	     Outputs ________________________

C$6647:	LD	(D.8336),HL
        LD	HL,-12
        ADD	HL,SP
        LD	SP,HL
        EX	DE,HL
        LD	(D.8338),HL
        LD	HL,(D.8336)
        LD	(D.8336),HL
        EX	DE,HL
        LD	A,13H			; delete file
        CALL	C.7506			; make BDOS call
        INC	A
        JP	NZ,J.666F
        LD	A,(D.8029)
        OR	A
        JP	Z,J.666F
        LD	A,0FFH
        JP	J.66D4			; quit with error

J.666F:	LD	HL,0
        ADD	HL,SP
        EX	DE,HL
        LD	A,1			; drive A:
        CALL	C$67C0			; get disk info
        LD	A,L
        INC	A
        OR	H
        JP	NZ,J$6684
        LD	A,0FFH
        JP	J.66D4			; quit with error

J$6684:	LD	HL,0
        ADD	HL,SP
        LD	E,(HL)
        LD	D,0			; sectors per cluster
        PUSH	DE
        CALL	C$75C0			; get word from stack at offset 7
        POP	DE
        CALL	C.758D			; multiply (16 bit)
        EX	DE,HL
        EX	DE,HL
        LD	(D.833A),HL
        CALL	C$75D8			; get word from stack at offset 1
        PUSH	HL
        LD	HL,(D.833A)
        EX	DE,HL
        LD	HL,(D.8338)
        ADD	HL,DE
        DEC	HL
        CALL	C.7558			; divide (16 bit)
        POP	DE
        LD	A,E
        SUB	L
        LD	A,D
        SBC	A,H
        JP	NC,J$66B5
        LD	A,0FFH
        JP	J.66D4			; quit with error

J$66B5:	LD	HL,(D.8336)
        LD	E,L
        LD	D,H
        LD	A,16H			; create file
        PUSH	HL
        CALL	C.7506			; make BDOS call
        POP	HL
        INC	A
        JP	NZ,J$66CA
        LD	A,0FFH
        JP	J.66D4			; quit with error

J$66CA:	LD	BC,14
        ADD	HL,BC
        LD	(HL),LOW 1
        INC	HL
        LD	(HL),HIGH 1
        XOR	A			; no error
J.66D4:	POP	BC
        POP	BC
        POP	BC
        POP	BC
        POP	BC
        POP	BC
        RET

;	  Subroutine __________________________
;	     Inputs  ________________________
;	     Outputs ________________________

C$66DB:	LD	HL,I$66E7
        LD	DE,C.8030
        LD	BC,196
        LDIR
        RET

I$66E7:

        .PHASE	08030H

C.8030:	LD	(D.80F1),A
        PUSH	DE
        PUSH	AF
        CALL	C.8057			; enable SRAM
        POP	AF
        POP	HL
        CALL	RDSLT
        PUSH	AF
        CALL	C.806E			; disable SRAM
        POP	AF
        RET

C.8043:	LD	(D.80F1),A
        PUSH	DE
        PUSH	BC
        PUSH	AF
        CALL	C.8057			; enable SRAM
        POP	AF
        POP	BC
        POP	HL
        LD	E,C
        CALL	WRSLT
        CALL	C.806E			; disable SRAM
        RET

C.8057:	LD	A,(D.80F1)
        LD	E,4DH
        LD	HL,D.5FFE+0
        CALL	WRSLT
        LD	A,(D.80F1)
        LD	E,69H
        LD	HL,D.5FFE+1
        CALL	WRSLT
        RET

C.806E:	LD	A,(D.80F1)
        LD	E,0
        LD	HL,D.5FFE+0
        CALL	WRSLT
        LD	A,(D.80F1)
        LD	E,0
        LD	HL,D.5FFE+1
        CALL	WRSLT
        RET

C.8085:	EX	DE,HL
        CALL	RDSLT
        EI
        RET

C.808B:	EX	DE,HL
        LD	E,C
        CALL	WRSLT
        EI
        RET

C.8092:	PUSH	DE
        PUSH	AF
        CALL	C.74C8			; get current slotid in page 1
        LD	(D.80F2),A		; save current slotid in page 1
        POP	AF
        LD	HL,I.4000
        CALL	ENASLT			; enable PAC in page 1
        LD	HL,0694DH
        LD	(D.5FFE),HL		; enable SRAM
        POP	DE
        LD	HL,I.4000
        LD	BC,8192-2
        LDIR				; copy from SRAM to
        LD	HL,0
        LD	(D.5FFE),HL		; disable SRAM
        LD	A,(D.80F2)
        LD	HL,I.4000
        CALL	ENASLT			; restore page 1
        EI
        RET

C.80C1:	PUSH	DE
        PUSH	AF
        CALL	C.74C8			; get current slotid in page 1
        LD	(D.80F2),A		; save current slotid in page 1
        POP	AF
        LD	HL,I.4000
        CALL	ENASLT			; enable PAC in page 1
        LD	HL,0694DH
        LD	(D.5FFE),HL		; enable SRAM
        POP	DE
        LD	HL,I.4000
        EX	DE,HL
        LD	BC,8192-2
        LDIR				; copy from ? to SRAM
        LD	HL,0
        LD	(D.5FFE),HL		; disable SRAM
        LD	A,(D.80F2)
        LD	HL,I.4000
        CALL	ENASLT			; restore page 1
        EI
        RET

D.80F1:	DEFB	1
D.80F2:	DEFB	1

        .DEPHASE

C.67AA:	LD	A,E
        JP	FILVRM

;	  Subroutine __________________________
;	     Inputs  ________________________
;	     Outputs ________________________

C$67AE:	LD	(D$F3EB),A
        JP	CHGCLR

;	  Subroutine __________________________
;	     Inputs  ________________________
;	     Outputs ________________________

C.67B4:	EX	DE,HL
        JP	WRTVRM

;	  Subroutine __________________________
;	     Inputs  ________________________
;	     Outputs ________________________

C.67B8:	CALL	CHSNS
        LD	A,0
        RET	Z
        INC	A
        RET

;	  Subroutine get disk info
;	     Inputs  DE = buffer, A = drive
;	     Outputs ________________________

C$67C0:	LD	(D.833C),DE
        LD	E,A
        LD	C,1BH			; get disk information
        CALL	C.61EF			; make BDOS call
        PUSH	IY
        PUSH	IX
        PUSH	BC
        PUSH	DE
        PUSH	HL
        LD	HL,(D.833C)
        LD	(HL),A			; number of sectors per cluster
        LD	B,5
J$67D7:	POP	DE
        INC	HL
        LD	(HL),E
        INC	HL
        LD	(HL),D
        DJNZ	J$67D7
        RET

I.67DF:	DEFB	0F8H,00AH,001H,00BH,002H,001H
        DEFW	I.6867
        DEFB	017H,004H,001H,017H,004H,001H
        DEFW	I.6874
        DEFB	013H,005H,000H,015H,002H,000H
        DEFW	I.68A7
        DEFB	017H,002H,001H,01BH,004H,001H
        DEFW	I.68D3
        DEFB	017H,003H,001H,019H,004H,001H
        DEFW	I.690A
        DEFB	013H,005H,000H,016H,002H,000H
        DEFW	I.6930
        DEFB	013H,004H,000H,017H,002H,000H
        DEFW	I.6957
        DEFB	017H,003H,001H,019H,004H,001H
        DEFW	I.6980
        DEFB	013H,002H,000H,01BH,002H,000H
        DEFW	I.69A6
        DEFB	017H,003H,000H,019H,006H,001H
        DEFW	I.69D1
        DEFB	01AH,006H,000H,013H,006H,001H
        DEFW	I.6A14
        DEFB	01AH,007H,000H,012H,004H,001H
        DEFW	I.6A49
        DEFB	01AH,002H,000H,01CH,004H,001H
        DEFW	I.6A73
        DEFB	01AH,006H,000H,012H,006H,001H
        DEFW	I.6A9D
        DEFB	01AH,003H,000H,01AH,002H,001H
        DEFW	I.6AD7
        DEFB	01AH,004H,000H,017H,004H,001H
        DEFW	I.6AF3
        DEFB	01AH,006H,000H,013H,004H,001H
        DEFW	I.6B19


I.6867:	DEFB	0D2H,0D3H,0D8H,009H,0B6H,0DEH,0C0H,0D8H
        DEFB	0CFH,0BEH,0DDH,0A1H
        DEFB	0

I.6874:	DEFB	0A2H,0BDH,0DBH,0AFH,0C4H,05FH,05FH,05FH
        DEFB	009H,0C9H,009H,0CAH,0DFH,0BDH,0DCH,0B0H
        DEFB	0C4H,0DEH,009H,0D4H,009H,0C3H,0DEH,0B0H
        DEFB	0C0H,009H,0B6H,0DEH,00AH,009H,0B7H,0B4H
        DEFB	0D9H,0B6H,0DEH,0D6H,0B2H,0B6H,0C5H,03FH
        DEFB	0A3H,0C4H,04DH,053H,058H,0CAH,0B2H,0AFH
        DEFB	0C0H,0A1H
        DEFB	0

I.68A7:	DEFB	009H,04DH,053H,058H,0CAH,0A2H,009H,0B8H
        DEFB	0D8H,0B1H,009H,0A3H,0C9H,0BCH,0DEH,0ADH
        DEFB	0C2H,0A6H,0C2H,0B6H,0AFH,0C0H,0A1H,00AH
        DEFB	0BCH,0ADH,0CAH,0DFH,0CAH,0DFH,0CAH,0DFH
        DEFB	0CAH,0DFH,0CAH,0DFH,02EH,02EH,02EH,02EH
        DEFB	02EH,02EH,02EH
        DEFB	0

I.68D3:	DEFB	0A2H,0BAH,0CBH,0DFH,0B0H,009H,0BBH,0B7H
        DEFB	028H,05FH,05FH,05FH,029H,0C9H,009H,0CAH
        DEFB	0DFH,0BDH,0DCH,0B0H,0C4H,0DEH,009H,0D4H
        DEFB	009H,0C3H,0DEH,0B0H,0C0H,009H,0B6H,0DEH
        DEFB	00AH,009H,0B7H,0B4H,0D9H,0B6H,0DEH,0D6H
        DEFB	0B2H,0B6H,0C5H,03FH,0A3H,0C4H,04DH,053H
        DEFB	058H,0CAH,0B2H,0AFH,0C0H,0A1H
        DEFB	0

I.690A:	DEFB	0A2H,05FH,05FH,05FH,05FH,05FH,05FH,05FH
        DEFB	05FH,009H,0C6H,0B3H,0DCH,0B6H,0DEH,0B7H
        DEFB	0BDH,0D9H,0B6H,0DEH,0D6H,0B2H,0B6H,0C5H
        DEFB	03FH,0A3H,00AH,009H,0C4H,04DH,053H,058H
        DEFB	0CAH,0B2H,0AFH,0C0H,0A1H
        DEFB	0

I.6930:	DEFB	04DH,053H,058H,009H,0CAH,0A2H,009H,0BAH
        DEFB	0CBH,0DFH,0B0H,009H,0A3H,0C9H,0BCH,0DEH
        DEFB	0ADH,0C2H,0A6H,0C2H,0B6H,0AFH,0C0H,0A1H
        DEFB	00AH,0CBH,0DFH,0CBH,0DFH,0CBH,0DFH,0CBH
        DEFB	0DFH,0A4H,0BAH,0CBH,0DFH,0B0H
        DEFB	0

I.6957:	DEFB	04DH,053H,058H,009H,0CAH,0A2H,009H,0C1H
        DEFB	0AAH,0DDH,0BCH,0DEH,009H,0A3H,0C9H,0BCH
        DEFB	0DEH,0ADH,0C2H,0A6H,0C2H,0B6H,0AFH,0C0H
        DEFB	0A1H,00AH,0C1H,0AAH,0C1H,0AAH,0C1H,0AAH
        DEFB	0A4H,0C1H,0AAH,0DDH,0BCH,0DEH,021H,021H
        DEFB	0

I.6980:	DEFB	0A2H,05FH,05FH,05FH,05FH,05FH,05FH,05FH
        DEFB	05FH,009H,0A6H,0BBH,0B8H,0BCH,0DEH,0AEH
        DEFB	0BDH,0D9H,0B6H,0DEH,0D6H,0B2H,0B6H,0C5H
        DEFB	03FH,0A3H,00AH,009H,0C4H,04DH,053H,058H
        DEFB	0CAH,0B2H,0AFH,0C0H,0A1H
        DEFB	0

I.69A6:	DEFB	04DH,053H,058H,009H,0CAH,0A2H,009H,0CCH
        DEFB	0A7H,0B2H,0D9H,009H,0BBH,0B8H,0BCH,0DEH
        DEFB	0AEH,0A3H,0C9H,0BCH,0DEH,0ADH,0C2H,0A6H
        DEFB	0C2H,0B6H,0AFH,0C0H,0A1H,00AH,009H,0BBH
        DEFB	0B0H,0A4H,0B8H,0B0H,0A4H,0BCH,0DEH,0AEH
        DEFB	021H,021H
        DEFB	0

I.69D1:	DEFB	04DH,053H,058H,009H,0CAH,0A2H,009H,0BDH
        DEFB	0DBH,0AFH,0C4H,009H,0A3H,0C9H,0BCH,0DEH
        DEFB	0ADH,0C2H,0A6H,0C2H,0B6H,0AFH,0C0H,0A1H
        DEFB	00AH,0A2H,050H,041H,043H,009H,0CAH,009H
        DEFB	0A4H,0BDH,0DBH,0AFH,0C4H,05FH,05FH,05FH
        DEFB	009H,0C6H,0B1H,0D9H,0A1H,009H,0D2H,0D3H
        DEFB	009H,0BCH,0C0H,0B6H,0C5H,03FH,0A3H,00AH
        DEFB	009H,0C4H,04DH,053H,058H,0CAH,0B2H,0AFH
        DEFB	0C0H,0A1H
        DEFB	0

I.6A14:	DEFB	009H,0A2H,0BAH,0C9H,0BCH,0DEH,0ADH,0D3H
        DEFB	0DDH,0CAH,0A4H,009H,0CCH,0DBH,0AFH,0CBH
        DEFB	0DFH,0B0H,009H,0B6H,00AH,009H,050H,041H
        DEFB	043H,0B6H,0DEH,0D3H,0B3H,0CBH,0C4H,0C2H
        DEFB	0CBH,0C2H,0D6H,0B3H,0BCH,0DEH,0ACH,0A1H
        DEFB	0A3H,00AH,009H,0C4H,04DH,053H,058H,0CAH
        DEFB	0B2H,0AFH,0C0H,0A1H
        DEFB	0

I.6A49:	DEFB	009H,0A2H,0BAH,0C9H,0BCH,0DEH,0ADH,0D3H
        DEFB	0DDH,0CAH,0A4H,009H,0CCH,0DBH,0AFH,0CBH
        DEFB	0DFH,0B0H,009H,0B6H,0DEH,00AH,009H,0CBH
        DEFB	0C2H,0D6H,0B3H,0BCH,0DEH,0ACH,0A1H,0A3H
        DEFB	0C4H,04DH,053H,058H,0CAH,0B2H,0AFH,0C0H
        DEFB	0A1H
        DEFB	0

I.6A73:	DEFB	009H,0A2H,0BAH,0C9H,0BCH,0DEH,0ADH,0D3H
        DEFB	0DDH,0CAH,0A4H,00AH,009H,050H,041H,043H
        DEFB	0B6H,0DEH,0D3H,0B3H,0CBH,0C4H,0C2H,0CBH
        DEFB	0C2H,0D6H,0B3H,0BCH,0DEH,0ACH,0A1H,0A3H
        DEFB	0C4H,04DH,053H,058H,0CAH,0B2H,0AFH,0C0H
        DEFB	0A1H
        DEFB	0

I.6A9D:	DEFB	009H,032H,0C2H,0B2H,0BCH,0DEH,0AEH,0B3H
        DEFB	0C9H,050H,041H,043H,0B6H,0DEH,0B1H,0D9H
        DEFB	0BFH,0DEH,021H,00AH,009H,020H,020H,020H
        DEFB	020H,00DH,0A1H,0C3H,0DEH,0DDH,0B9H,0DEH
        DEFB	0DDH,0A6H,0B7H,0D8H,00DH,01AH,00AH,009H
        DEFB	050H,041H,043H,0A6H,031H,0C2H,0C6H,0BCH
        DEFB	0C3H,0B6H,0D7H,0C2H,0B6H,0B3H,0BAH,0C4H
        DEFB	0A1H
        DEFB	0

I.6AD7:	DEFB	0A2H,0CCH,0A7H,0B2H,0D9H,009H,0B6H,0DEH
        DEFB	0D0H,0C2H,0B6H,0D7H,0C5H,0B2H,0BFH,0DEH
        DEFB	0A1H,0A3H,0C4H,04DH,053H,058H,0CAH,0B2H
        DEFB	0AFH,0C0H,0A1H
        DEFB	0

I.6AF3:	DEFB	0A2H,0CCH,0DBH,0AFH,0CBH,0DFH,0B0H,009H
        DEFB	0C9H,0B1H,0B7H,009H,0B4H,0D8H,0B1H,009H
        DEFB	0B6H,0DEH,0C0H,0D8H,0C5H,0B2H,0BFH,0DEH
        DEFB	0A1H,0A3H,00AH,009H,0C4H,04DH,053H,058H
        DEFB	0CAH,0B2H,0AFH,0C0H,0A1H
        DEFB	0

I.6B19:	DEFB	0A2H,0CCH,0A7H,0B2H,0D9H,009H,0B9H,0B2H
        DEFB	0BCH,0B7H,0B6H,0DEH,0B5H,0B6H,0BCH,0B2H
        DEFB	0BFH,0DEH,0A1H,0A3H,00AH,009H,0C4H,04DH
        DEFB	053H,058H,0CAH,0B2H,0AFH,0C0H,0A1H
        DEFB	0

;	  Subroutine display message
;	     Inputs  A = message, E = keyflag
;	     Outputs ________________________

C.6B39:	LD	L,A
        LD	H,0
        ADD	HL,HL
        ADD	HL,HL
        ADD	HL,HL
        LD	BC,I.67DF+0
        ADD	HL,BC
        LD	L,(HL)
        PUSH	AF
        PUSH	HL
        LD	L,A
        LD	H,0
        ADD	HL,HL
        ADD	HL,HL
        ADD	HL,HL
        LD	BC,I.67DF+4
        ADD	HL,BC
        LD	L,(HL)
        PUSH	HL
        LD	L,A
        LD	H,0
        ADD	HL,HL
        ADD	HL,HL
        ADD	HL,HL
        LD	BC,I.67DF+2
        ADD	HL,BC
        PUSH	AF
        LD	A,(HL)
        ADD	A,11
        PUSH	AF
        LD	A,E
        LD	(D.833E),A
        POP	AF
        LD	E,A
        POP	HL
        LD	L,H
        LD	H,0
        PUSH	HL
        ADD	HL,HL
        ADD	HL,HL
        ADD	HL,HL
        LD	BC,I.67DF+1
        ADD	HL,BC
        LD	A,(HL)
        POP	HL
        LD	H,0
        ADD	HL,HL
        ADD	HL,HL
        ADD	HL,HL
        LD	BC,I.67DF+3
        ADD	HL,BC
        LD	C,(HL)
        CALL	C.4BE4			; create window
        POP	BC
        POP	BC
        POP	AF
        LD	(D.833F),HL
        PUSH	HL
        LD	L,A
        LD	H,00H
        ADD	HL,HL
        ADD	HL,HL
        ADD	HL,HL
        LD	BC,I.67DF+0
        ADD	HL,BC
        LD	L,(HL)
        PUSH	HL
        LD	L,A
        LD	H,00H
        ADD	HL,HL
        ADD	HL,HL
        ADD	HL,HL
        LD	BC,I.67DF+6
        ADD	HL,BC
        LD	C,(HL)
        INC	HL
        LD	B,(HL)
        PUSH	BC
        LD	L,A
        LD	H,0
        ADD	HL,HL
        ADD	HL,HL
        ADD	HL,HL
        LD	BC,I.67DF+5
        ADD	HL,BC
        LD	L,(HL)
        PUSH	HL
        LD	HL,(D.833F)
        LD	E,0
        LD	C,0
        CALL	C.4896			; display text
        POP	BC
        POP	BC
        POP	BC
        LD	HL,D.833E
        LD	E,(HL)
        INC	E
        DEC	E
        JP	Z,J$6BCE
        CALL	C.63D2			; wait for up/down/esc or space key
        LD	HL,(D.833F)
        CALL	C.4DC6			; remove window
J$6BCE:	POP	HL
        RET

?.6BD0:	INC	B
        INC	B

I$6BD2:	DEFB	0FDH		; << Illegal Op Code Byte >>
        DEFB	0FDH		; << Illegal Op Code Byte >>
        DEFB	0FDH		; << Illegal Op Code Byte >>
;	-----------------
        RET	PO
        RET	P
        RET	M
        RET	P
        RET	P
        RST	38H
        RST	38H
        RST	38H
        RET	NZ
        ADD	A,B
        RST	38H
        ADD	A,B
        ADD	A,B
        RET	P
        RET	PO
        RET	NZ
        ADD	A,B
        ADD	A,B
        RST	18H
        RST	18H
        RST	08H
        ADD	A,B
        RET	NZ
        RET	PO
        RET	M
        RET	M
        SBC	A,B
        RST	38H
        RST	38H
        DEFB	0EDH		; << Illegal Op Code Byte >>
        DEFB	0FDH		; << Illegal Op Code Byte >>
        DEFB	0FDH		; << Illegal Op Code Byte >>
        DEFB	0FDH		; << Illegal Op Code Byte >>
        DEFB	0FDH		; << Illegal Op Code Byte >>
        DEFB	0FDH		; << Illegal Op Code Byte >>
        DEFB	0FDH		; << Illegal Op Code Byte >>
        DEFB	0FDH		; << Illegal Op Code Byte >>
;	-----------------
        CP	A
        CP	0F8H
        RET	PO
        ADD	A,B
        RST	38H
        RST	38H
        RET	P
        RST	00H
        POP	HL
        RST	38H
        RST	38H
        RST	38H
        RST	38H
        RST	38H
        SUB	B
        RST	38H
        RST	38H
        ADD	A,B
        RET	NZ
        RET	P
        RET	M
        CALL	M,0FDFEH
        DEFB	0FDH		; << Illegal Op Code Byte >>
        DEFB	0FDH		; << Illegal Op Code Byte >>
        DEFB	0FDH		; << Illegal Op Code Byte >>
;	-----------------
        RET	M
        RET	P
        RET	P
        RET	M
        RET	P
        RET	M
        RET	PO
        RET	P
        RST	18H
        RST	38H
        RST	38H
        RST	38H
        SUB	B
        CP	0F0H
        SBC	A,A
        RST	38H
        RST	38H
        RST	38H
        RST	38H
        POP	BC
        EX	(SP),HL
        ADD	A,B
        RST	38H
        RST	38H
        ADD	A,B
        ADD	A,B
        RET	NZ
        DEFB	0FDH		; << Illegal Op Code Byte >>
        DEFB	0FDH		; << Illegal Op Code Byte >>
        DEFB	0FDH		; << Illegal Op Code Byte >>
        DEFB	0FDH		; << Illegal Op Code Byte >>
        DEFB	0FDH		; << Illegal Op Code Byte >>
;	-----------------
        RST	38H
        RST	38H
        RST	38H
        RST	38H
        RST	38H
        RST	38H
        ADD	A,B
        RET	PO
        RET	NZ
        ADD	A,B
        RET	NZ
        EX	(SP),HL
        JP	0E7C3H
;	-----------------
?.6C46:	RST	38H
        RST	38H
        RST	38H
        RST	38H
        RET	NZ
        RET	NZ
        RET	NZ
        RET	PO
        RET	P
        RET	M
        RET	M
        RET	P
I$6C52:	LD	D,D
        LD	D,D
        LD	D,D
        LD	D,D
        LD	D,D
        LD	D,D
        LD	D,D
        LD	D,D
        LD	D,L
        LD	D,L
        LD	D,L
        DEC	H
        DEC	H
        LD	D,L
        DEC	H
        DEC	H
        LD	E,C
        LD	E,C
        LD	E,C
        LD	E,C
        LD	E,C
        SBC	A,D
        SBC	A,D
        SBC	A,D
        SUB	L
        SUB	L
        SUB	L
        SUB	L
        SUB	L
        SUB	L
        LD	D,L
        LD	D,L
        LD	D,D
        LD	D,D
        LD	D,D
        LD	D,D
        LD	D,D
        LD	D,D
        LD	D,D
        LD	D,D
        LD	D,D
        LD	E,C
        LD	E,C
        LD	E,C
        LD	E,C
        SBC	A,C
        SBC	A,C
        LD	E,A
        SBC	A,D
        SBC	A,D
        SBC	A,C
        SBC	A,C
        SBC	A,C
        SBC	A,C
        SBC	A,C
        RRA
        LD	D,L
        LD	D,L
        SUB	L
        SUB	L
        SUB	L
        SUB	L
        SUB	L
        SUB	L
        LD	D,D
        LD	D,D
        LD	D,D
        LD	D,D
        LD	E,A
        LD	E,A
        LD	E,A
        LD	E,A
        LD	E,A
        LD	E,A
        LD	E,C
        LD	E,C
        SUB	L
        SBC	A,C
        SBC	A,C
        SBC	A,C
        RRA
        PUSH	AF
        LD	SP,HL
        SBC	A,A
        SBC	A,C
        SBC	A,C
        SBC	A,C
        SBC	A,C
        LD	E,C
        LD	E,C
        SUB	L
        LD	D,L
        LD	D,L
        SUB	L
        SUB	L
        SUB	L
        LD	D,D
        LD	D,D
        LD	D,D
        LD	D,D
        LD	D,D
        LD	D,L
        LD	D,L
        LD	D,L
        SBC	A,C
        SBC	A,C
        SBC	A,C
        LD	E,C
        LD	E,C
        LD	E,C
        LD	E,C
        LD	E,C
        SBC	A,A
        SBC	A,A
        SBC	A,A
        SBC	A,A
        SBC	A,C
        SBC	A,C
        SBC	A,C
        SBC	A,C
        SUB	L
        SUB	L
        SUB	L
        SUB	L
        SUB	L
        SUB	L
        SUB	L
        SUB	L

I$6CD2:	INC	BC
        INC	BC
I$6CD4:	DEFB	0,0,0
        LD	BC,I.0101
        INC	BC
        INC	BC
        RST	38H
        RST	38H
        RST	38H
        RST	38H
        RST	38H
        RET	M
        RET	P
        RET	P
        RET	P
        CALL	M,0FEFEH
        RST	38H
        LD	A,A
        CCF
        CCF
        INC	BC
        RLCA
        RLCA
        RLCA
        RRCA
        RRCA
        RRCA
        RRA
        RET	P
        RET	PO
        RET	PO
        POP	HL
        RST	38H
        RST	38H
        RST	38H
        RST	38H
        CCF
        LD	A,A
        LD	A,A
        CP	0FEH
        CALL	M,0F0F8H
        RRA
        RRA
        CCF
        CCF
        CCF
        LD	A,(HL)
        LD	A,(HL)
        LD	A,(HL)
        RST	38H
        ADD	A,B
        DEFB	0,0,0,0,0,0
        RET	NZ
        DEFB	0,0,0,0,0,0,0
I$6D1C:	INC	BC
        INC	BC
I$6D1E:	DEFB	0,0,0,0,0,0,0,0
I$6D26:	RRCA
        RRCA
        RRA
        RRA
        CCF
        CCF
        LD	A,(HL)
        LD	A,(HL)
I$6D2E:	RST	38H
        RST	38H
        RST	38H
        RST	38H
        LD	A,(HL)
        LD	A,(HL)
        LD	A,(HL)
        LD	A,(HL)
        DEFB	0,0
        LD	BC,I.0301
        INC	BC
        RLCA
        RLCA
I.6D3E:	CALL	M,0F8FCH
        RET	M
        POP	AF
        POP	AF
        RST	38H
        RST	38H
I.6D46:	CALL	M,0FCFCH
        CALL	M,0F8F8H
        RET	M
        RET	M
        RRCA
        RRCA
        RRA
        RRA
        CCF
        CCF
        LD	A,(HL)
        LD	A,(HL)
        RST	38H
        RST	38H
        ADD	A,E
        ADD	A,E
        RLCA
        RLCA
        RLCA
        RLCA
        RET	P
        RET	P
        RET	P
        RET	P
        RET	PO
        RET	PO
        RET	PO
        RET	PO
I$6D66:	INC	BC
        INC	BC
I.6D68:	DEFB	0,0,0,0
        LD	BC,I.0301
        INC	BC
        RRA
        LD	A,A
        RST	38H
        RST	38H
        CALL	M,0F8FCH
        RET	M
        RET	M
        CP	0FFH
        RST	38H
        LD	A,A
        LD	A,A
        CP	0FEH
        INC	BC
        RLCA
        RLCA
        RLCA
        RRCA
        RRCA
        RRCA
        RRA
        RET	M
        RET	P
        RET	P
        RET	P
        RET	PO
        EX	(SP),HL
        EX	(SP),HL
        RST	00H
        CP	00H
        DEFB	0,0,0
        RET	M
        RET	M
        RET	P
        RRA
        RRA
        CCF
        CCF
        CCF
        CCF
        RRA
        RLCA
        RST	00H
        RST	00H
        ADC	A,A
        ADC	A,A
        RST	38H
        RST	38H
        RST	38H
        CP	0F0H
        RET	P
        RET	PO
        RET	PO
        RET	NZ
        RET	NZ
        ADD	A,B
        NOP
I$6DB0:	LD	B,03H	; 3 
        DEFB	0,0,0,0,0,0
        INC	BC
        RRCA
        DEFB	0,0,0,0,0,0
        RET	M
        CP	00H
        DEFB	0,0,0,0,0
        RRCA
        RRCA
        DEFB	0,0,0,0,0,0
        SBC	A,(HL)
        CP	A
        DEFB	0,0,0,0,0,0
        INC	BC
        RRCA
        DEFB	0,0,0,0,0,0
        RET	M
        CP	1FH
        CCF
        CCF
        NOP
        RLCA
        RRA
        CCF
        CCF
        RST	38H
        SBC	A,A
        RRCA
        RRCA
        RST	18H
        RST	38H
        RST	38H
        CP	0FH	; 15 
        SBC	A,A
        SBC	A,A
        RRA
        LD	A,3EH	; ">"
        LD	A,7CH	; "|"
        RST	38H
        RST	38H
        RST	08H
        RRCA
        RRA
        RRA
        RRA
        LD	A,9FH
        CP	A
        CP	A
        ADD	A,B
        RLCA
        RRA
        CCF
        CCF
        RST	38H
        SBC	A,A
        RRCA
        RRCA
        RST	18H
        RST	38H
        RST	38H
        CP	7EH	; "~"
        LD	A,H
        RET	M
        LD	SP,HL
        RST	38H
        RST	38H
        LD	A,(HL)
        INC	A
        LD	A,3EH	; ">"
        LD	A,H
        CALL	M,0F9FCH
        LD	SP,HL
        DEFB	0FDH		; << Illegal Op Code Byte >>
;	-----------------
        LD	A,H
        LD	A,H
        RET	M
        RET	M
        RET	M
        RET	P
        RET	P
        RET	P
        LD	A,3EH	; ">"
        LD	A,H
        LD	A,H
        LD	A,H
        RET	M
        RET	M
        RET	M
        LD	A,(HL)
        LD	A,H
        RET	M
        LD	SP,HL
        RST	38H
        RST	38H
        LD	A,(HL)
        INC	A
        LD	A,3EH	; ">"
        LD	A,H
        CALL	M,0F8FCH
        RET	M
        CALL	M,C$0311
I$6E42	EQU	$-2
        DEFB	0,0,0,0,0,0
        RLCA
        RLCA
        DEFB	0,0,0,0,0,0
        ADC	A,0DFH
        DEFB	0,0,0,0,0,0
        JR	C,J$6ED8
        DEFB	0,0,0,0,0,0
        LD	A,3EH	; ">"
        DEFB	0,0,0,0,0,0
        RRA
        RRA
        DEFB	0,0,0,0,0,0
        RLCA
        RRA
        DEFB	0,0,0,0,0,0
        RET	PO
        RET	P
        DEFB	0,0,0,0,0,0
        RRA
        LD	A,A
        DEFB	0,0,0,0,0,0
        RET	NZ
        RET	P
        DEFB	0,0,0,0,0,0
        LD	SP,HL
        EI
        DEFB	0,0,0,0,0,0
        RST	00H
        RST	28H
        DEFB	0,0,0,0,0,0,0
        ADD	A,E
        DEFB	0,0,0,0,0,0
        CP	0FFH
        DEFB	0,0,0,0,0,0
        RLCA
        ADD	A,A
        DEFB	0,0,0,0,0,0
        RST	08H
        RST	18H
        DEFB	0,0,0,0,0,0
        RRCA
        ADC	A,A
        LD	A,H
        LD	A,H
        LD	A,H
        RET	M
        RET	M
        RET	M
        RST	38H
        RST	38H
        RLCA
        RRCA
        RRCA
        RRCA
        RRA
        RRA
        RRA
        LD	A,0FFH
        RST	38H
        RST	38H
        SBC	A,A
J$6ED8:	LD	A,3EH	; ">"
        LD	A,7CH	; "|"
        CP	0FEH
        CP	3EH	; ">"
        LD	A,H
        LD	A,H
        LD	A,H
        LD	SP,HL
        LD	A,7CH	; "|"
        LD	A,H
        LD	A,H
        RET	M
        RET	M
        RET	M
        RET	P
        RRA
        LD	A,3EH	; ">"
        LD	A,7CH	; "|"
        LD	A,H
        LD	A,H
        RET	M
        CCF
        LD	A,A
        LD	A,L
        RET	M
        CALL	M,C.FFFF
        LD	A,A
        RET	M
        RET	M
        LD	SP,HL
        LD	SP,HL
        INC	BC
        INC	BC
        JP	J$FFE7
;	-----------------
?.6F05:	RST	38H
        RET	P
        RET	P
        POP	HL
        POP	HL
        RST	38H
        RST	38H
        RET	P
        LD	SP,HL
        LD	SP,HL
        LD	SP,HL
        DI
        DI
        DI
        RST	20H
        RST	38H
        RST	38H
        RST	38H
        DI
        RST	20H
        RST	20H
        RST	20H
        RST	08H
        RST	38H
        RST	38H
        RST	38H
        RST	20H
        RST	08H
        RST	08H
        RST	08H
        SBC	A,A
        RST	00H
        RST	00H
        RST	08H
        RST	08H
        SBC	A,A
        SBC	A,A
        SBC	A,A
        CCF
        RST	38H
        RST	38H
        ADD	A,A
        ADD	A,A
        RRCA
        RRCA
        RST	38H
        RST	38H
        ADD	A,A
        RST	08H
        RST	08H
        RST	08H
        SBC	A,A
        SBC	A,A
        SBC	A,A
        LD	A,0FFH
        RST	38H
        RST	20H
        ADD	A,A
        RRCA
        RRCA
        RRCA
        RRA
        RST	18H
        RST	18H
        JP	J.87C3
;	-----------------
?.6F49:	ADD	A,A
        ADD	A,A
        RRCA
        CP	0FEH
        RET	PO
        RET	PO
        RET	NZ
        RET	NZ
        RET	NZ
        ADD	A,B
        LD	A,3EH	; ">"
        LD	A,H
        LD	A,H
        LD	A,H
        LD	SP,HL
        LD	SP,HL
        LD	SP,HL
        LD	A,H
        LD	A,H
        LD	SP,HL
        LD	SP,HL
        LD	SP,HL
        DI
        DI
        DI
        LD	SP,HL
        LD	SP,HL
        DI
        DI
        DI
        EX	(SP),HL
        POP	HL
        RET	PO
        RET	P
        RET	P
        POP	HL
        RST	20H
        RST	38H
        RST	38H
        EI
        DI
        RET	M
        RET	M
        DI
        DI
        DI
        EX	(SP),HL
        POP	HL
        RET	PO
        RRA
        RLCA
        EX	(SP),HL
        RST	30H
        RST	38H
        RST	38H
        RST	38H
        CP	0E7H
        RST	20H
        RST	28H
        RST	28H
        RST	08H
        RST	00H
        ADD	A,A
        LD	BC,C.FFFF
        ADD	A,B
        ADD	A,A
        RST	38H
        RST	38H
        RST	38H
        CP	0E7H
        RST	20H
        RRCA
        RST	08H
        RST	08H
        RST	18H
        SBC	A,A
        RRA
        RST	08H
        RST	08H
        SBC	A,A
        SBC	A,A
        SBC	A,A
        LD	A,3EH	; ">"
        LD	A,9FH
        SBC	A,A
        LD	A,3EH	; ">"
        LD	A,7CH	; "|"
        LD	A,H
        LD	A,H
        CCF
        CCF
        LD	A,H
        LD	A,H
        LD	A,A
        CCF
        CCF
        RRCA
        RST	38H
        RST	38H
        NOP
        LD	A,0FEH
        CP	0FCH
        RET	P
        LD	A,3EH	; ">"
        LD	A,H
        LD	A,H
        LD	A,H
        RET	M
        RET	M
        RET	M
        RRA
        RRA
        LD	A,3EH	; ">"
        LD	A,7CH	; "|"
        LD	A,H
        LD	A,H
        RRCA
        RRCA
        RRA
        RRA
        RRA
        LD	A,3EH	; ">"
        LD	A,80H
        ADD	A,B
        DEFB	0,0,0,0,0,0
I$6FDC:	LD	C,04H	; 4 
        DEFB	0,0,0,0,0,0
        INC	BC
        RRCA
        DEFB	0,0,0,0,0,0
        RET	M
        CP	00H
        DEFB	0,0,0,0,0
        RRCA
        RRCA
        DEFB	0,0,0,0,0,0
        SBC	A,H
        CP	H
        RLCA
        RLCA
        RLCA
        RRCA
        RRCA
        RRCA
        RST	38H
        RST	38H
        RET	NZ
        RET	NZ
        RET	NZ
        ADD	A,B
        ADD	A,B
        ADD	A,B
        RST	20H
        RST	20H
        DEFB	0,0,0,0,0,0
        ADC	A,0DEH
        LD	C,1FH
        RRA
        LD	C,00H
        NOP
        LD	A,H
        LD	A,H
        DEFB	0,0,0,0,0,0
        RRA
        LD	A,A
        RRA
        RRA
        RRA
        LD	A,3EH	; ">"
        LD	A,7CH	; "|"
        CALL	M,C.0000
        DEFB	0,0,0,0
        RRA
        LD	A,A
        DEFB	0,0,0,0,0,0
        LD	A,H
        CALL	M,C.0000
        DEFB	0,0,0,0
        RRA
        LD	A,A
        DEFB	0,0,0,0,0,0
        RET	NZ
        RET	P
        RRA
        CCF
        CCF
        NOP
        RLCA
        RRA
        CCF
        CCF
        RST	38H
        SBC	A,A
        RRCA
        RRCA
        RST	18H
        RST	38H
        RST	38H
        CP	0FH	; 15 
        SBC	A,A
        SBC	A,A
        SBC	A,A
        CCF
        LD	A,3EH	; ">"
        LD	A,H
        LD	SP,IY
        RET	M
        RET	NZ
        DEFB	0,0,0,0
        RST	38H
        RST	38H
        LD	A,3EH	; ">"
        LD	A,H
        LD	A,H
        LD	A,H
        RET	M
        RST	00H
        RST	08H
        RRCA
        RRCA
        RRA
        RRA
        RRA
        LD	A,0FEH
        CALL	M,C$E0FC
        ADD	A,C
        LD	BC,I.0301
        LD	A,H
        RET	M
        LD	SP,HL
        LD	SP,HL
        DI
        DI
        DI
        RST	20H
        RST	38H
        RST	38H
        LD	SP,HL
        RET	P
        POP	HL
        POP	HL
        POP	HL
        JP	C.F8FC
;	-----------------
?.7098:	LD	SP,HL
        LD	SP,HL
        DI
        DI
        DI
        RST	20H
        RST	38H
        RST	38H
        LD	SP,HL
        RET	P
        POP	HL
        POP	HL
        POP	HL
        JP	C.F8FC
;	-----------------
?.70A8:	LD	SP,HL
        LD	SP,HL
        DI
        DI
        DI
        RST	20H
        RST	38H
        RST	38H
        RET	P
        RET	P
        POP	HL
        POP	HL
        RST	38H
        RST	38H
        RET	P
        RET	M
        RET	M
        RET	M
        RET	P
        RET	P
        RET	P
        RET	PO
        LD	A,(HL)
        LD	A,H
        RET	M
        LD	SP,HL
        RST	38H
        RST	38H
        LD	A,(HL)
        INC	A
        LD	A,3EH	; ">"
        LD	A,H
        CALL	M,C.F9FC
        LD	SP,HL
        DEFB	0FDH		; << Illegal Op Code Byte >>
;	-----------------
        LD	A,H
        LD	A,H
        RET	M
        RET	M
        RET	M
        RET	P
        RET	P
        RET	P
        DEFB	0,0
        LD	BC,I.0101
        INC	BC
        INC	BC
        INC	BC
        RET	M
        RET	M
        RET	P
        RET	P
        RET	P
        RET	PO
        RET	PO
        RET	PO
        LD	A,3EH	; ">"
        LD	A,H
        LD	A,H
        LD	A,H
        RET	M
        RET	M
        RET	M
        INC	BC
        INC	BC
        RLCA
        RLCA
        RLCA
        RRCA
        RRCA
        RRCA
        RST	20H
        RST	20H
        RST	08H
        RST	08H
        RST	08H
        ADC	A,A
        ADD	A,A
        ADD	A,E
        JP	J.87C3
;	-----------------
?.7101:	RST	08H
        RST	38H
        RST	38H
        RST	28H
        RST	08H
        RST	20H
        RST	20H
        RST	08H
        RST	08H
        RST	08H
        ADC	A,A
        ADD	A,A
        ADD	A,E
        JP	J.87C3
;	-----------------
?.7111:	RST	08H
        RST	38H
        RST	38H
        RST	38H
        RST	28H
        RST	20H
        RST	20H
        RST	08H
        RST	08H
        RST	08H
        ADD	A,A
        ADD	A,A
        ADD	A,C
        RST	38H
        RST	38H
        ADD	A,B
I$7121:	ADD	A,A
        RST	38H
        RST	38H
        RST	38H
        CP	0E0H
        RET	PO
        NOP
        RET	NZ
        RET	NZ
        RET	NZ
        ADD	A,B
        DEFB	0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0
        DEFB	0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0
        DEFB	0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0
        DEFB	0,0,0,0,0,0,0,0,0,0,0,0,0,0
        LD	A,3FH	; "?"
        RRA
        RRCA
        INC	BC
        DEFB	0,0
        RRA
        CCF
        CP	0FEH
        RET	M
        RET	PO
        DEFB	0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0
        DEFB	0,0,0,0,0,0
        DEC	B
        INC	BC
I$71A0:	DEFB	0,0,0
        RST	38H
        RST	38H
        RST	38H
        RST	38H
        RST	38H
        DEFB	0,0,0
        CP	0FEH
        CP	0FEH
        CP	00H
        DEFB	0,0
        LD	A,3FH	; "?"
        CCF
        CCF
        CCF
        DEFB	0,0,0,0,0
        ADD	A,B
        POP	BC
        EX	(SP),HL
        DEFB	0,0,0
        LD	A,7EH	; "~"
        CP	0FEH
        CP	0F8H
        RET	M
        RET	M
        RST	38H
        RST	38H
        RST	38H
        RST	38H
        RST	38H
        DEFB	0,0,0
        RET	M
        RET	M
        RET	M
        RET	M
        RET	M
        CCF
        CCF
        CCF
        LD	A,3EH	; ">"
        LD	A,3EH	; ">"
        LD	A,0F7H
        RST	38H
        RST	38H
        RST	38H
        LD	A,A
        LD	A,1CH
        NOP
        CP	0FEH
        CP	0BEH
        LD	A,3EH	; ">"
        LD	A,3EH	; ">"
        RET	M
        RET	M
        RET	M
        RET	M
        RET	M
        RET	M
        RET	M
        RET	M
        DEFB	0,0,0,0,0,0,0,0
        LD	A,3EH	; ">"
        LD	A,3EH	; ">"
        LD	A,3EH	; ">"
        LD	A,3EH	; ">"
        DEFB	0,0,0,0,0,0,0,0
        LD	A,3EH	; ">"
        LD	A,3EH	; ">"
        LD	A,3EH	; ">"
        LD	A,3EH	; ">"
D.7218:	RRCA
D.7219:	LD	BC,I$4A31
I$721A	EQU	$-2
        ADD	A,D
        ADD	A,D
        ADD	A,D
        LD	C,D
        LD	SP,I$CF00
        JR	Z,J$724D
        CPL
        JR	Z,J$7250
        RET	Z
        NOP
        INC	A
        AND	D
        AND	D
        INC	A
        JR	Z,J$7254
        LD	(D.0100),HL
        INC	BC
        DEC	B
        LD	BC,I$6101
        LD	H,A
        NOP
        LD	C,11H	; 17 
        LD	DE,I$010F
        LD	(BC),A
        CALL	Z,C$3800
        LD	B,L
        LD	B,L
        JR	C,J.728C
        LD	B,L
        JR	C,J$724A
J$724A:	RET	PO
        DJNZ	J$725D
J$724D:	RET	PO
        DJNZ	J$7260
J$7250:	RET	PO
        DEFB	0,0,0
J$7254:	DEFB	0,0,0,0,0,0
        ADC	A,B
        EXX
        XOR	D
J$725D:	XOR	D
        ADC	A,E
        ADC	A,D
J$7260:	ADC	A,D
        NOP
        SBC	A,A
        LD	B,H
        INC	H
        INC	H
        CALL	PO,C$2424
        NOP
        ADD	HL,SP
        LD	B,L
        LD	B,C
        ADD	HL,SP
        DEC	B
        LD	B,L
        JR	C,J$7272
J$7272:	INC	DE
        INC	D
        INC	D
        INC	DE
        DJNZ	J.728C
        EX	(SP),HL
        NOP
        SUB	C
        LD	D,C
        LD	DE,J.519F
        LD	D,C
        SUB	C
        NOP
        LD	(HL),A
        LD	HL,I$2121
        LD	HL,I$7121
        NOP
        RET	Z
        INC	D
J.728C:	LD	(D$3E22),HL
        LD	(D$0022),HL

;	  Subroutine __________________________
;	     Inputs  ________________________
;	     Outputs ________________________

C.7292:	LD	HL,0
        LD	(D.8345),HL
        LD	HL,I$8500
        LD	(D.8347),HL
        LD	HL,07300H
        ADD	HL,SP
        CALL	C.73D3			; allocate memory
        CALL	C.72D5			; free memory
        RET

;	  Subroutine __________________________
;	     Inputs  ________________________
;	     Outputs ________________________

C$72A9:	LD	C,L
        LD	B,H
        LD	HL,(D.8347)
        EX	DE,HL
        LD	HL,0
        ADD	HL,SP
        LD	A,L
        SUB	E
        LD	L,A
        LD	A,H
        SBC	A,D
        LD	H,A
        DEC	H
        DEC	H
        DEC	H
        DEC	H
        LD	A,L
        SUB	C
        LD	A,H
        SBC	A,B
        JP	NC,J$72C8
        LD	HL,C.FFFF
        RET
;	-----------------
J$72C8:	LD	HL,(D.8347)
        PUSH	HL
        LD	HL,(D.8347)
        ADD	HL,BC
        LD	(D.8347),HL
        POP	HL
        RET

;	  Subroutine free memory
;	     Inputs  ________________________
;	     Outputs ________________________

C.72D5:	DEC	HL
        DEC	HL
        DEC	HL
        DEC	HL
        LD	C,L
        LD	B,H
        LD	HL,(D.8345)
        EX	DE,HL
        EX	DE,HL
        LD	(D.834B),HL
        EX	DE,HL
J$72E4:	LD	A,E
        SUB	C
        LD	A,D
        SBC	A,B
        JP	NC,J$72F5
        LD	L,E
        LD	H,D
        LD	A,C
        SUB	(HL)
        INC	HL
        LD	A,B
        SBC	A,(HL)
        JP	C,J.731C
J$72F5:	LD	L,E
        LD	H,D
        LD	A,E
        SUB	(HL)
        INC	HL
        LD	A,D
        SBC	A,(HL)
        JP	C,J$7310
        LD	A,E
I$7300:	SUB	C
        LD	A,D
        SBC	A,B
        JP	C,J.731C
        LD	L,E
        LD	H,D
        LD	A,C
        SUB	(HL)
        INC	HL
        LD	A,B
        SBC	A,(HL)
        JP	C,J.731C
J$7310:	EX	DE,HL
        LD	E,(HL)
        INC	HL
        LD	D,(HL)
        EX	DE,HL
        LD	(D.834B),HL
        EX	DE,HL
        JP	J$72E4
;	-----------------
J.731C:	LD	L,E
        LD	H,D
        PUSH	HL
        LD	L,C
        LD	H,B
        LD	(D.8349),HL
        POP	HL
        LD	C,(HL)
        INC	HL
        LD	B,(HL)
        PUSH	BC
        LD	HL,(D.8349)
        LD	C,L
        LD	B,H
        LD	HL,2
        ADD	HL,BC
        LD	A,(HL)
        INC	HL
        LD	H,(HL)
        LD	L,A
        ADD	HL,HL
        ADD	HL,HL
        ADD	HL,BC
        PUSH	HL
        LD	L,C
        LD	H,B
        LD	(D.8349),HL
        POP	HL
        POP	BC
        PUSH	DE
        LD	A,L
        CP	C
        JP	NZ,J$7349
        LD	A,H
        CP	B
J$7349:	JP	NZ,J$737D
        LD	HL,(D.8349)
        PUSH	HL
        INC	HL
        INC	HL
        LD	E,(HL)
        INC	HL
        LD	D,(HL)
        PUSH	HL
        LD	HL,(D.834B)
        LD	(D.834B),HL
        LD	A,(HL)
        INC	HL
        LD	H,(HL)
        LD	L,A
        INC	HL
        INC	HL
        LD	A,(HL)
        INC	HL
        LD	H,(HL)
        LD	L,A
        ADD	HL,DE
        EX	DE,HL
        POP	HL
        LD	(HL),D
        DEC	HL
        LD	(HL),E
        LD	HL,(D.834B)
        LD	A,(HL)
        INC	HL
        LD	H,(HL)
        LD	L,A
        LD	C,(HL)
        INC	HL
        LD	B,(HL)
        POP	HL
        LD	(HL),C
        INC	HL
        LD	(HL),B
        JP	J$7387
;	-----------------
J$737D:	EX	DE,HL
        LD	C,(HL)
        INC	HL
        LD	B,(HL)
        LD	HL,(D.8349)
        LD	(HL),C
        INC	HL
        LD	(HL),B
J$7387:	POP	DE
        LD	HL,2
        ADD	HL,DE
        LD	A,(HL)
        INC	HL
        LD	H,(HL)
        LD	L,A
        ADD	HL,HL
        ADD	HL,HL
        ADD	HL,DE
        PUSH	DE
        PUSH	HL
        LD	HL,(D.8349)
        LD	C,L
        LD	B,H
        POP	HL
        LD	A,L
        CP	C
        JP	NZ,J$73A2
        LD	A,H
        CP	B
J$73A2:	JP	NZ,J$73C9
        LD	HL,2
        ADD	HL,DE
        PUSH	DE
        LD	E,(HL)
        INC	HL
        LD	D,(HL)
        PUSH	HL
        LD	HL,2
        ADD	HL,BC
        LD	A,(HL)
        INC	HL
        LD	H,(HL)
        LD	L,A
        ADD	HL,DE
        EX	DE,HL
        POP	HL
        LD	(HL),D
        DEC	HL
        LD	(HL),E
        LD	L,C
        LD	H,B
        LD	C,(HL)
        INC	HL
        LD	B,(HL)
        POP	DE
        EX	DE,HL
        LD	(HL),C
        INC	HL
        LD	(HL),B
        JP	J$73CD
;	-----------------
J$73C9:	EX	DE,HL
        LD	(HL),C
        INC	HL
        LD	(HL),B
J$73CD:	POP	DE
        EX	DE,HL
        LD	(D.8345),HL
        RET

;	  Subroutine allocate memory
;	     Inputs  ________________________
;	     Outputs ________________________

C.73D3:	INC	HL
        INC	HL
        INC	HL
        LD	B,2
        CALL	C.7533			; /4
        INC	HL
        LD	C,L
        LD	B,H
        LD	HL,(D.8345)
        LD	(D.834D),HL
        LD	A,L
        OR	H
        JP	NZ,J$7400
        LD	HL,D.8341
        LD	(D.834D),HL
        PUSH	HL
        LD	HL,D.8341
        LD	(D.8345),HL
        LD	(D.8341),HL
        LD	HL,0
        LD	(D$8343),HL
        POP	HL
J$7400:	LD	E,(HL)
        INC	HL
        LD	D,(HL)
J$7403:	LD	HL,2
        ADD	HL,DE
        LD	A,(HL)
        SUB	C
        INC	HL
        LD	A,(HL)
        SBC	A,B
        JP	C,J$7455
        LD	HL,2
        ADD	HL,DE
        LD	A,(HL)
        CP	C
        INC	HL
        JP	NZ,J$741B
        LD	A,(HL)
        CP	B
J$741B:	JP	NZ,J$742C
        LD	L,E
        LD	H,D
        LD	C,(HL)
        INC	HL
        LD	B,(HL)
        LD	HL,(D.834D)
        LD	(HL),C
        INC	HL
        LD	(HL),B
        JP	J$744A
;	-----------------
J$742C:	LD	HL,2
        ADD	HL,DE
        LD	A,(HL)
        SUB	C
        LD	(HL),A
        INC	HL
        LD	A,(HL)
        SBC	A,B
        LD	(HL),A
        LD	HL,2
        ADD	HL,DE
        LD	A,(HL)
        INC	HL
        LD	H,(HL)
        LD	L,A
        ADD	HL,HL
        ADD	HL,HL
        ADD	HL,DE
        EX	DE,HL
        LD	HL,2
        ADD	HL,DE
        LD	(HL),C
        INC	HL
        LD	(HL),B
J$744A:	LD	HL,(D.834D)
        LD	(D.8345),HL
        LD	HL,4
        ADD	HL,DE
        RET
;	-----------------
J$7455:	LD	HL,(D.8345)
        PUSH	BC
        LD	A,E
        CP	L
        JP	NZ,J$7460
        LD	A,D
        CP	H
J$7460:	JP	NZ,J$749C
        LD	L,C
        LD	H,B
        ADD	HL,HL
        ADD	HL,HL
        PUSH	HL
        LD	L,C
        LD	H,B
        LD	(D.834F),HL
        POP	HL
        CALL	C$72A9
        LD	A,L
        AND	H
        INC	A
        JP	NZ,J$7483
        CALL	C.7292			; initialize memory (32 KB RAM)
        LD	E,0			; do not wait for key
        XOR	A
        CALL	C.6B39			; display message
J$7480:	JP	J$7480			; halt

J$7483:	PUSH	HL
        INC	HL
        INC	HL
        PUSH	HL
        LD	HL,(D.834F)
        LD	C,L
        LD	B,H
        POP	HL
        LD	(HL),C
        INC	HL
        LD	(HL),B
        POP	HL
        INC	HL
        INC	HL
        INC	HL
        INC	HL
        CALL	C.72D5			; free memory
        LD	HL,(D.8345)
        EX	DE,HL
J$749C:	EX	DE,HL
        LD	(D.834D),HL
        EX	DE,HL
        EX	DE,HL
        LD	E,(HL)
        INC	HL
        LD	D,(HL)
        POP	BC
        JP	J$7403

;	  Subroutine __________________________
;	     Inputs  ________________________
;	     Outputs ________________________
;	Remark	Not Used

?.74A9:	CALL	C.74C8			; get current slotid in page 1
        LD	HL,H.STKE
        LD	(HL),0F7H
        INC	HL
        LD	(HL),A
        INC	HL
        LD	DE,I$74BE
        LD	(HL),E
        INC	HL
        LD	(HL),D
        INC	HL
        LD	(HL),0C9H
        RET

;	  Subroutine __________________________
;	     Inputs  ________________________
;	     Outputs ________________________

I$74BE:	LD	HL,(D$FC4A)
        LD	SP,HL			; initialize stackpointer
        CALL	C.7292			; initialize memory (32 KB RAM)
        JP	J$40A5			; start PAC commander

;	  Subroutine __________________________
;	     Inputs  ________________________
;	     Outputs ________________________

C.74C8:	LD	HL,04000H
        CALL	C.74CF			; get current slotid in page 1
        RET

;	  Subroutine get current slotid in page
;	     Inputs  ________________________
;	     Outputs ________________________

C.74CF:	LD	B,14
        CALL	C.7533			; /16384
        ADD	HL,HL
        PUSH	HL
        CALL	RSLREG
        POP	HL
        LD	B,L
        CALL	C.752B			; shift
        AND	03H
        LD	E,A
        LD	C,E
        LD	B,0
        PUSH	HL
        LD	HL,I.FCC1
        ADD	HL,BC
        LD	A,(HL)
        AND	80H
        POP	BC
        OR	A
        JP	NZ,J$74F3
        LD	A,E
        RET

J$74F3:	INC	HL
        INC	HL
        INC	HL
        INC	HL
        LD	A,(HL)
        LD	B,C
        CALL	C.752B			; shift
        AND	03H
        ADD	A,A
        ADD	A,A
        LD	B,A
        LD	A,80H
        OR	E
        OR	B
        RET

;	  Subroutine make BDOS call
;	     Inputs  ________________________
;	     Outputs ________________________

C.7506:	LD	H,B
        LD	L,C
        LD	C,A
        JP	C.61EF			; make BDOS call

;	  Subroutine make upcase
;	     Inputs  ________________________
;	     Outputs ________________________

C$750C:	CP	61H
        RET	C
        CP	7BH
        RET	NC
        SUB	20H
        RET

;	  Subroutine __________________________
;	     Inputs  ________________________
;	     Outputs ________________________

C.7515:	LD	A,C
        LD	C,E
        LD	B,D
        LD	E,A
        LD	A,C
        OR	B
        RET	Z
        LD	(HL),E
        LD	E,L
        LD	D,H
        INC	DE
        DEC	BC
        JP	C.7525			; copy data

?.7524:	EX	DE,HL

;	  Subroutine __________________________
;	     Inputs  ________________________
;	     Outputs ________________________

C.7525:	LD	A,C
        OR	B
        RET	Z
        LDIR
        RET

;	  Subroutine 8 bit shift right
;	     Inputs  ________________________
;	     Outputs ________________________

C.752B:	INC	B
J$752C:	DEC	B
        RET	Z
        AND	A
        RRA
        JP	J$752C

;	  Subroutine 16 bit shift right
;	     Inputs  ________________________
;	     Outputs ________________________

C.7533:	INC	B
J$7534:	DEC	B
        RET	Z
        AND	A
        LD	A,H
        RRA
        LD	H,A
        LD	A,L
        RRA
        LD	L,A
        JP	J$7534

;	  Subroutine 8 bit divide
;	     Inputs  ________________________
;	     Outputs ________________________

C$7540:	LD	L,A
        LD	H,0
        LD	C,8
J$7545:	ADD	HL,HL
        LD	A,H
        JP	C,J$754E
        CP	B
        JP	C,J$7551
J$754E:	SUB	B
        INC	L
        LD	H,A
J$7551:	DEC	C
        JP	NZ,J$7545
        LD	A,L
        LD	B,H
        RET

;	  Subroutine 16 bit divide
;	     Inputs  ________________________
;	     Outputs ________________________

C.7558:	LD	B,D
        LD	C,E
        LD	DE,0
        LD	A,16
J$755F:	PUSH	AF
        ADD	HL,HL
        LD	A,E
        RLA
        LD	E,A
        LD	A,D
        RLA
        LD	D,A
        JP	C,J$7571
        LD	A,E
        SUB	C
        LD	A,D
        SBC	A,B
        JP	C,J$7578
J$7571:	LD	A,E
        SUB	C
        LD	E,A
        LD	A,D
        SBC	A,B
        LD	D,A
        INC	L
J$7578:	POP	AF
        DEC	A
        JP	NZ,J$755F
        RET

;	  Subroutine 8 bit multiply
;	     Inputs  ________________________
;	     Outputs ________________________

C.757E:	LD	H,A
        XOR	A
        LD	C,8
J$7582:	ADD	A,A
        ADD	HL,HL
        JP	NC,J$7588
        ADD	A,B
J$7588:	DEC	C
        JP	NZ,J$7582
        RET

;	  Subroutine 16 bit multiply
;	     Inputs  ________________________
;	     Outputs ________________________

C.758D:	LD	B,H
        LD	C,L
        LD	HL,0
        LD	A,16
J$7594:	ADD	HL,HL
        EX	DE,HL
        ADD	HL,HL
        EX	DE,HL
        JP	NC,J$759C
        ADD	HL,BC
J$759C:	DEC	A
        JP	NZ,J$7594
        RET

;	  Subroutine __________________________
;	     Inputs  ________________________
;	     Outputs ________________________

C.75A1:	LD	DE,8
        JP	J.75B9

;	  Subroutine __________________________
;	     Inputs  ________________________
;	     Outputs ________________________

C.75A7:	LD	DE,6
        JP	J.75B9

;	  Subroutine __________________________
;	     Inputs  ________________________
;	     Outputs ________________________

C.75AD:	LD	DE,4
        JP	J.75B9

;	  Subroutine __________________________
;	     Inputs  ________________________
;	     Outputs ________________________

C.75B3:	EX	(SP),HL
        LD	E,(HL)
        INC	HL
        LD	D,(HL)
        INC	HL
        EX	(SP),HL
J.75B9:	EX	DE,HL
        ADD	HL,SP
        LD	(HL),E
        INC	HL
        LD	(HL),D
        EX	DE,HL
        RET

;	  Subroutine __________________________
;	     Inputs  ________________________
;	     Outputs ________________________

C$75C0:	LD	HL,9
        JP	J.75E5

;	  Subroutine __________________________
;	     Inputs  ________________________
;	     Outputs ________________________

C.75C6:	LD	HL,8
        JP	J.75E5

;	  Subroutine __________________________
;	     Inputs  ________________________
;	     Outputs ________________________

C.75CC:	LD	HL,6
        JP	J.75E5

;	  Subroutine __________________________
;	     Inputs  ________________________
;	     Outputs ________________________

C.75D2:	LD	HL,4
        JP	J.75E5

;	  Subroutine __________________________
;	     Inputs  ________________________
;	     Outputs ________________________

C$75D8:	LD	HL,3
        JP	J.75E5

;	  Subroutine __________________________
;	     Inputs  ________________________
;	     Outputs ________________________

C.75DE:	POP	HL
        LD	E,(HL)
        INC	HL
        LD	D,(HL)
        INC	HL
        PUSH	HL
        EX	DE,HL
J.75E5:	ADD	HL,SP
        LD	E,(HL)
        INC	HL
        LD	D,(HL)
        EX	DE,HL
        RET

        DEFS	07FEDH-$,0

        RET

        DEFS	07FF7H-$,0

D.7FF7:	DEFB	1

        DEFS	08000H-$,0

        END
