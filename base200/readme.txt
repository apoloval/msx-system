subrom msx2

SONY HB-F1		base version 2.0 japanese


SONY HB-F900		cassette/printer fix

orginal code

$04CF:	RRC	C
	SBC	A,A
	LD	(D.F3DB),A
	RRC	C
	PUSH	BC
	LD	BC,BDOS
	LD	HL,D.F3FC
	JR	NC,J$04E3
	LD	HL,I$F401

becomes

$04CF:	RRC	C
	SBC	A,A
	LD	(D.F3DB),A
	BIT	1,C
	PUSH	BC
	LD	BC,BDOS
	LD	HL,D.F3FC
	JR	Z,J$04E3
	LD	HL,I$F401


Panasonic FS-A1FM	jis2 different ?? (compared to SONY HB-F900)

orginal code

$:	XOR	A
	LD	C,0FFH			; enable all internal devices
	OUT	(0D8H),A
	LD	A,2
	OUT	(0D9H),A

becomes

$:	XOR	A
	LD	C,0FDH			; enable all internal devices (except b1 = JIS2 ??)
	OUT	(0D8H),A
	LD	A,2
	OUT	(0D9H),A

National_FS-5500F1	mouse timing (compared to SONY HB-F1)

orginal code

$:	CALL	C3585

becomes

$:	CALL	C3F8B


orginal code

C35AA:	EX	(SP),HL
	EX	(SP),HL
	EX	(SP),HL
	EX	(SP),HL
	RET

becomes

C35AA:	NOP
	NOP
	NOP
	NOP
	RET

extra code FS-5500F1

C3F8B:	LD	D,48
J3F8D:	DEC	D
	JR	NZ,J3F8D
	JP	C3585


Sony HB-F500P		european version (compared to SONY HB-F1)

orginal code

$0372:	LD	A,0D3H
	OUT	(0F7H),A
	LD	(0FAF7),A

becomes

$0372:	LD	A,0D3H
	OUT	(0F7H),A
	CALL	C3CC3


orginal code

$0431:	LD	HL,D04FF

becomes

$0431:	LD	HL,D3CEC


orginal code

$173E:	CALL	C1947

becomes

$173E:	CALL	C3CA7


orginal code

	CP	24H
	JR	NC,J18C0
J18A6:	LD	B,A
	CALL	C.1956
	JR	Z,J18B0
	CP	60H
	JR	J18B2

J18B0:	CP	13H
J18B2:	JR	NC,J18C0
	LD	C,A
	CALL	C.1956
	JR	Z,J18BE
	CP	60H
	JR	J18C0

J18BE:	CP	32H
J18C0:	JP	NC,J0546
	LD	D,A
	POP	HL
	PUSH	IX
	DEC	HL
	RST	10H
	POP	IX
	LD	A,0
	JR	Z,J18D9
	PUSH	IX
	RST	08H
	DEFB	","
	RST	08H
	DEFB	"A"
	POP	IX
	OR	01H

becomes

	LD	E,24H
	JR	NZ,J18A7
	LD	D,A
	LD	E,32H
J18A7:	CP	E
	JR	NC,J18C3
	LD	B,A
	CALL	C1956
	LD	E,13H
	JR	Z,J18B4
	LD	E,60H
J18B4:	CP	E
	JR	NC,J18C3
	LD	C,A
	CALL	C.1956
	JR	NZ,J18C0
	LD	B,A
	JR	J18C6

J18C0:	LD	D,A
	CP	60H
J18C3:	JP	NC,J0546
J18C6:	POP	HL
	PUSH	IX
	DEC	HL
	RST	10H
	LD	A,0
	JR	Z,J18D5
	RST	08H
	DEFB	","
	RST	08H
	DEFB	",A"
	OR	01H	; 1 
	POP	IX
	NOP
	NOP

orginal

I29F6:	DEFB	00H,20H,00H,00H,00H,00H,00H,00H
	DEFB	08H,00H,00H,00H,00H,00H,00H,00H
	DEFB	00H,00H,00H,00H,00H,3BH,05H,00H

becomes

I29F6:	DEFB	00H,20H,00H,00H,00H,00H,00H,00H
	DEFB	08H,02H,00H,00H,00H,00H,00H,00H
	DEFB	00H,00H,00H,00H,00H,3BH,05H,00H


orginal

I2B4F:	DEFB	00H,08H,01H,20H,08H,2AH,09H,00H
	DEFB	02H,1FH,05H,0F7H,0BH,00H,06H,0EH

becomes

I2B4F:	DEFB	00H,08H,01H,20H,08H,2AH,09H,02H
	DEFB	02H,1FH,05H,0F7H,0BH,00H,06H,0EH

orginal

$3632:	RST	028H
	CP	004H

becomes

$3632:	CALL	C3CCD


path code area

C3CA7:	CALL	C1947
	DEC	HL
	LD	C,(HL)
	DEC	HL
	LD	B,(HL)
	DEC	HL
	BIT	4,(HL)
	RET	NZ
J3CB2:	LD	DE,-5
	ADD	HL,DE
	LD	D,(HL)
	LD	(HL),B
	INC	HL
	LD	E,(HL)
	LD	(HL),C
	LD	BC,5
J3CBE:	ADD	HL,BC
	LD	(HL),D
J3CC0:	INC	HL
	LD	(HL),E
	RET


C3CC3:	LD	(D.FAF7),A
	XOR	A
	OUT	(0F8H),A
J3CC9:	LD	(D.FFF8),A
J3CCC:	RET


C3CCD:	RST	28H
J3CCE:	CP	16
J3CD0:	RET	NC
	PUSH	AF
	RRCA
	RRCA
	AND	03H
	LD	E,A
	LD	A,0FCH
	CALL	C3CE1
	POP	AF
	AND	03H
	SCF
	RET


C3CE1:	PUSH	HL
J3CE2:	LD	HL,D.FFF8
	AND	(HL)
	OR	E
	LD	(HL),A
	OUT	(0F8H),A
	POP	HL
	RET


I3CEC:	DEFB	00AH,000H,000H,000H,005H,002H,00FH,004H
	DEFB	004H,003H,001H,000H,003H,0FFH

Sony HB-F9P		country? (compared to SONY HB-F500P)

orginal

I3CEC:	DEFB	00AH,000H,000H,000H,005H,002H,00FH,004H
	DEFB	004H,003H,001H,000H,003H,0FFH

becomes

I3CEC:	DEFB	00AH,000H,000H,000H,005H,002H,00FH,004H
	DEFB	004H,003H,001H,000H,005H,0FFH


Philips NMS8220		fast ramdisk (compared to Sony HB-F500P)

complete redesign of the ramdisk

some unused space is filled with zero instead of garbage
device handler starts at $372A
bios entry 0135H is patched with RETs
bios entry 0139H is patched with RETs
$36D5 patch for date
$36F3 patch for european digitizer
$36FD patch for extended SCREEN digitize parameter
$371C modified table for initializing clockchip
$372A redesigned ramdisk routines


Philips NMS8255		ramdisk parameters (compared to Philips NMS8220)

orginal

$3762:	DEFB	08BH
	DEFB	2
	DEFW	00067H

becomes

$3762:	DEFB	08BH
	DEFB	6
	DEFW	00167H

Philips NMS8245		extra (compared to Phlips NMS8255)

orginal

$1C64:	DEFB	"128",0
	DEFB	" 64",0

becomes

$1C64:	DEFB	" 128",0
	DEFB	"64",0

orginal

$3E6F:	CALL	C1C4B

becomes

$3E6F:	CALL	C3E8C


extra

C$3E8C:	PUSH	BC
	PUSH	DE
	LD	A,0FFH
	LD	C,0FCH
	OUT	(C),A			; select largest mapper page
	IN	B,(C)			; read back register
	XOR	A
	OUT	(C),A			; select smallest mapper page
	IN	A,(C)			; read back register
	XOR	B
	LD	L,A			; which bits are changed
	LD	A,3
	OUT	(C),A			; restore orginal mapper page
	LD	H,0
	INC	HL			; number of pages
	ADD	HL,HL
	ADD	HL,HL
	ADD	HL,HL
	ADD	HL,HL			; * 16
	LD	DE,03030H
	LD	B,D
	LD	C,B			; 0000
J.3EAD:	LD	A,"9"+1
	INC	B			; increase low digit
	CP	B			; overflow ?
	JR	NZ,J.3EC0		; nope,
	LD	B,"0"
	INC	C
	CP	C
	JR	NZ,J.3EC0
	LD	C,B
	INC	D
	CP	D
	JR	NZ,J.3EC0
	LD	D,C
	INC	E
J.3EC0:	DEC	HL
	XOR	A
	OR	L			;
	JR	NZ,J.3EAD
	OR	H
	JR	NZ,J.3EAD
	LD	A,E
	CP	"0"			; highest digit still zero ?
	JR	NZ,J.3ECF		; nope,
	LD	E," "
J.3ECF:	LD	A,E
	CALL	C.1224
	LD	A,D
	CALL	C.1224
	LD	A,C
	CALL	C.1224
	LD	A,B
	CALL	C.1224
	POP	DE
	POP	BC
	RET	
