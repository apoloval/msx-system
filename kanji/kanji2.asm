; KANJI2.ASM
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
        ORG	8000H

J8000:	CP	01H
        JP	Z,J803F
        CP	02H
        JR	Z,J802B
        CP	03H
        JR	Z,J802B
        CP	04H
        JP	Z,J804E
        CP	0AH
        JP	Z,J802F
        CP	0BH
        JP	Z,J8033
        CP	0CH
        JP	Z,J8037
        CP	0DH
        JP	Z,J803B
        CP	14H
        JP	Z,J8058
J802B:	LD	A,0FFH
        SCF
        RET

;	  Subroutine function 10,
;	     Inputs  ________________________
;	     Outputs ________________________

J802F:	CALL	C8BDD
        RET

;	  Subroutine function 11,
;	     Inputs  ________________________
;	     Outputs ________________________

J8033:	CALL	C8C1F
        RET

;	  Subroutine function 12,
;	     Inputs  ________________________
;	     Outputs ________________________

J8037:	CALL	C8ACA
        RET

;	  Subroutine function 13,
;	     Inputs  ________________________
;	     Outputs ________________________

J803B:	CALL	C8B2F
        RET

;	  Subroutine function 1, inquiry
;	     Inputs  ________________________
;	     Outputs ________________________

J803F:	PUSH	BC
        PUSH	HL
        PUSH	DE
        PUSH	HL
        CALL	C86C4
        POP	HL
        CALL	C8959
        POP	DE
        POP	HL
        POP	BC
        RET

;	  Subroutine function 4, virtual terminal clear
;	     Inputs  ________________________
;	     Outputs ________________________

J804E:	PUSH	BC
        PUSH	HL
        PUSH	DE
        CALL	C86C4
        POP	DE
        POP	HL
        POP	BC
        RET

;	  Subroutine function 20,
;	     Inputs  ________________________
;	     Outputs ________________________

J8058:	PUSH	HL
        CALL	C80F9
        POP	HL
        RET

I805E:	DEFB	"AIUEO"

I8063:	DEFB	"KSTNHMYRWGZDBLCPFJVQ"

I8077:	DEFB	'"'
        DEFB	"$"
        DEFB	"&"
        DEFB	"("
        DEFB	"*"
I807C:	DEFB	"+-/13579;=?ADFHJKLMNORUX[^_`abd"
		DEFB	0
		DEFB	"f$hijklmop&qr"
        DEFB	",.02468:<>@BEGIPSVY\ijklm+"
        DEFB	0
        DEFB	"/"
        DEFB	0
        DEFB	"3QTWZ]UUUUU88888VVVVV"
        DEFB	0
        DEFB	"////"
        DEFB	0,0,0
        DEFB	"'"
        DEFB	0
        DEFB	"!#"
        DEFB	0
        DEFB	"')c#e'gn#%')!#%')"

;	  Subroutine __________________________
;	     Inputs  ________________________
;	     Outputs ________________________

C80F9:	DI
        PUSH	BC
        PUSH	DE
        PUSH	IX
        PUSH	IY
        LD	C,(HL)
        INC	HL
        LD	B,(HL)
        PUSH	BC
        POP	IX
        INC	HL
        LD	C,(HL)
        INC	HL
        LD	B,(HL)
        PUSH	BC
J810B:	POP	DE
        INC	HL
J810D:	LD	A,(HL)
        LD	(IX+5),A
        PUSH	DE
        POP	HL
        LD	C,(HL)
        INC	HL
        LD	B,(HL)
        INC	HL
        EX	DE,HL
        LD	(IX+8),B
        LD	(IX+7),C
        LD	(IX+9),E
        LD	(IX+14),E
        LD	(IX+10),D
        LD	(IX+15),D
        LD	(IX+12),00H
J812D	EQU	$-1
        LD	(IX+13),00H
        LD	(IX+22),0FFH
        LD	(IX+23),0FFH
        LD	(IX+24),A
J813D:	LD	A,(IX+8)
        AND	A
        JP	NZ,J8208
        LD	A,(IX+7)
        AND	A
        JP	Z,J8208
        CP	01H	; 1
        JR	Z,J817E
        CP	02H	; 2
        JR	Z,J8168
        LD	(IX+11),03H	; 3
        LD	B,03H	; 3
        CALL	C8223
        LD	B,03H	; 3
        CALL	C8251
        JR	NC,J81A8
        LD	B,03H	; 3
        CALL	C823A
J8168:	LD	(IX+11),02H	; 2
        LD	B,02H	; 2
        CALL	C8223
        LD	B,02H	; 2
        AND	A
        CALL	C8251
        JR	NC,J81A8
        LD	B,02H	; 2
        CALL	C823A
J817E:	LD	(IX+11),01H	; 1
        LD	B,01H	; 1
        CALL	C8223
        LD	B,01H	; 1
        AND	A
        CALL	C8251
        JR	NC,J81D2
        LD	B,01H	; 1
        CALL	C823A
        LD	(IX+13),01H	; 1
        CALL	C85D1
        LD	A,(HL)
        INC	HL
        LD	B,(HL)
        CALL	C85DA
        LD	(HL),A
        INC	HL
        LD	(HL),B
        LD	B,01H	; 1
        JR	J81D6

J81A8:	LD	A,(IX+22)
        LD	C,A
        CP	0FFH
        JR	Z,J81D2
        LD	A,(IX+23)
        CP	0FFH
        JR	Z,J81D2
        CP	C
        JR	NZ,J81D2
        CALL	C85DA
        DEC	HL
        DEC	HL
        LD	A,43H	; "C"
        LD	(HL),A
        INC	HL
        LD	A,(IX+5)
        LD	C,24H	; "$"
        AND	A
        JR	NZ,J81CD
        LD	C,25H	; "%"
J81CD:	LD	(HL),C
        LD	(IX+23),0FFH
J81D2:	LD	(IX+22),0FFH
J81D6:	LD	A,(IX+11)
        SLA	A
        LD	L,A
        LD	H,00H
        ADD	HL,DE
        EX	DE,HL
        LD	A,B
        LD	B,(IX+12)
        ADD	A,B
        LD	(IX+12),A
        LD	B,00H
        LD	C,(IX+11)
        PUSH	HL
        LD	L,(IX+7)
        LD	H,(IX+8)
        AND	A
        SBC	HL,BC
        LD	(IX+7),L
        LD	(IX+8),H
        POP	HL
        JP	NZ,J813D
        LD	A,(IX+13)
        CP	01H	; 1
        JR	NZ,J820D
J8208:	SCF
        LD	A,01H	; 1
        JR	J820E

J820D:	XOR	A
J820E:	LD	D,(IX+10)
        LD	E,(IX+9)
        EX	DE,HL
        LD	B,(IX+12)
        DEC	HL
        DEC	HL
        LD	(HL),B
        POP	IY
        POP	IX
        POP	DE
        POP	BC
        EI
        RET

;	  Subroutine __________________________
;	     Inputs  ________________________
;	     Outputs ________________________
C8223:	PUSH	IX
        PUSH	DE
J8226:	LD	A,(DE)
        LD	(IX+16),A
        INC	DE
        INC	IX
        LD	A,(DE)
        LD	(IX+16),A
        INC	DE
        INC	IX
        DJNZ	J8226
        POP	DE
        POP	IX
        RET

;	  Subroutine __________________________
;	     Inputs  ________________________
;	     Outputs ________________________
C823A:	PUSH	IX
        PUSH	DE
J823D:	LD	A,(IX+16)
        LD	(DE),A
        INC	DE
        INC	IX
        LD	A,(IX+16)
        LD	(DE),A
        INC	DE
        INC	IX
        DJNZ	J823D
        POP	DE
        POP	IX
        RET

;	  Subroutine __________________________
;	     Inputs  ________________________
;	     Outputs ________________________
C8251:	PUSH	DE
        PUSH	IX
        PUSH	IY
        LD	(IX),E
        LD	(IX+1),D
        LD	(IX+2),B
        CALL	C85D1
J8262:	INC	HL
        LD	A,(HL)
        DEC	HL
        CP	23H	; "#"
        JP	NZ,J8302
        LD	A,(HL)
        CP	41H	; "A"
        JP	C,J8302
        CP	5BH	; "["
        JP	C,J828E
        CP	61H	; "a"
        JP	C,J8302
        CP	7BH	; "{"
        JP	NC,J8302
        SUB	20H	; " "
        LD	(HL),A
        LD	A,01H	; 1
        LD	(IX+3),A
        INC	HL
        INC	HL
        DEC	B
        JR	NZ,J8262
        JR	J8299

J828E:	LD	(IX+3),00H
        DEC	B
        JR	Z,J8299
        INC	HL
        INC	HL
        JR	J8262

J8299:	CALL	C85D1
        CALL	C830B
        JR	C,J8302
        CALL	C85DA
        LD	A,(IX+3)
        CP	01H	; 1
        JR	NZ,J82D8
        LD	A,(HL)
        CP	22H	; """
        JR	Z,J82D6
        CP	24H	; "$"
        JR	Z,J82D6
        CP	26H	; "&"
        JR	Z,J82D6
        CP	28H	; "("
        JR	Z,J82D6
        CP	2AH	; "*"
        JR	Z,J82D6
        CP	44H	; "D"
        JR	Z,J82D6
        CP	64H	; "d"
        JR	Z,J82D6
        CP	66H	; "f"
        JR	Z,J82D6
        CP	68H	; "h"
        JR	Z,J82D6
        CP	6FH	; "o"
        JR	Z,J82D6
        JR	J82D8

J82D6:	DEC	A
        LD	(HL),A
J82D8:	INC	HL
        LD	A,(IX+5)
        CP	00H
        JR	Z,J82F1
J82E0:	LD	A,24H	; "$"
        LD	(HL),A
        INC	HL
        INC	HL
        LD	A,(IX+2)
        DEC	A
        LD	(IX+2),A
        JR	NZ,J82E0
        AND	A
        JR	J8305

J82F1:	LD	A,25H	; "%"
        LD	(HL),A
        INC	HL
        INC	HL
        LD	A,(IX+2)
        DEC	A
        LD	(IX+2),A
        JR	NZ,J82F1
        AND	A
        JR	J8305

J8302:	XOR	A
        LD	B,A
        SCF
J8305:	POP	IY
        POP	IX
        POP	DE
        RET

;	  Subroutine __________________________
;	     Inputs  ________________________
;	     Outputs ________________________
C830B:	LD	A,(IX+2)
        CP	01H	; 1
        JR	Z,J831D
        CP	02H	; 2
        JR	Z,J832F
        CP	03H	; 3
        JR	Z,J832F
        JP	J84A0

J831D:	LD	A,(HL)
        CALL	C85EB
        JP	C,J837C
        CALL	C8602
        LD	(IX+22),E
        JP	J84A0

?832D:	AND	A
        RET

J832F:	LD	A,(HL)
        CP	4EH	; "N"
        JR	Z,J835D
        CALL	C8602
        JP	C,J84A0
        INC	HL
        INC	HL
J833C:	LD	A,(HL)
        CALL	C85EB
        JR	C,J8388
        PUSH	DE
        CALL	C8602
        LD	(IX+4),E
        POP	DE
        JP	C,J84A0
        INC	HL
        INC	HL
        LD	A,(HL)
        CALL	C85EB
        JP	NC,J84A0
        CALL	C84A2
        JP	C,J84A0
        RET

J835D:	LD	E,0FH	; 15
        LD	D,00H
        INC	HL
        INC	HL
        LD	A,(HL)
        CP	4EH	; "N"
        JR	NZ,J833C
        LD	A,(IX+11)
        CP	02H	; 2
        JP	NZ,J84A0
        DEC	HL
        DEC	HL
        LD	A,(HL)
        CALL	C85DA
        LD	A,73H	; "s"
        LD	(HL),A
        JP	C848A

J837C:	LD	HL,I8077
        ADD	HL,BC
        LD	A,(HL)
        CALL	C85DA
        LD	(HL),A
        JP	C848A

J8388:	LD	A,(IX+2)
        CP	03H	; 3
        JP	Z,J84A0
        LD	(IX+23),E
        LD	H,B
        LD	L,C
        ADD	HL,DE
        LD	A,L
        LD	DE,I807C
        ADD	HL,DE
        CP	21H	; "!"
        JP	Z,J847E
        CP	1FH
        JP	Z,J84A0
        CP	50H	; "P"
        JP	C,J83C1
        CP	55H	; "U"
        JP	C,J83CD
        CP	5AH	; "Z"
        JP	C,J83F0
        CP	5FH	; "_"
        JP	C,J8414
        CP	64H	; "d"
        JP	C,J8457
        JP	J84A0

J83C1:	LD	A,(HL)
        AND	A
        JP	Z,J84A0
        CALL	C85DA
        LD	(HL),A
        JP	C848A

J83CD:	LD	A,C
        CP	02H	; 2
        JR	Z,J83C1
        LD	A,(HL)
        PUSH	HL
        CALL	C85DA
        LD	(HL),A
        POP	HL
        LD	A,L
        ADD	A,19H
        LD	L,A
        LD	A,H
        ADC	A,00H
        LD	H,A
        LD	A,(HL)
        CP	00H
        JP	Z,J84A0
        CALL	C85DA
        INC	HL
        INC	HL
        LD	(HL),A
        JP	C8495

J83F0:	LD	A,C
        CP	01H	; 1
        JP	Z,J83C1
        LD	A,(HL)
        PUSH	HL
        CALL	C85DA
        LD	(HL),A
        POP	HL
        LD	A,L
        ADD	A,19H
        LD	L,A
        LD	A,H
        ADC	A,00H
        LD	H,A
        LD	A,(HL)
        CP	00H
        JP	Z,J84A0
        CALL	C85DA
        INC	HL
        INC	HL
        LD	(HL),A
        JP	C8495

J8414:	LD	A,(IX+5)
        CP	00H
        JR	Z,J8439
        LD	A,(HL)
        PUSH	HL
        CALL	C85DA
        LD	(HL),A
        POP	HL
        LD	A,L
        ADD	A,1EH
        LD	L,A
        LD	A,H
        ADC	A,00H
        LD	H,A
        LD	A,(HL)
        CP	00H
        JP	Z,J84A0
        CALL	C85DA
        INC	HL
        INC	HL
        LD	(HL),A
        JP	C8495

J8439:	LD	A,74H	; "t"
        PUSH	HL
        CALL	C85DA
        LD	(HL),A
        POP	HL
        LD	A,C
        CP	02H	; 2
        JR	Z,C848A
        LD	A,L
        ADD	A,1EH
        LD	L,A
        LD	A,H
        ADC	A,00H
        LD	H,A
        LD	A,(HL)
        CALL	C85DA
        INC	HL
        INC	HL
        LD	(HL),A
        JR	C8495

J8457:	LD	A,C
        CP	02H	; 2
        JP	Z,J83C1
        LD	A,(HL)
        AND	A
        JP	Z,J84A0
        PUSH	HL
        CALL	C85DA
        LD	(HL),A
        POP	HL
        LD	A,L
        ADD	A,14H	; 20
        LD	L,A
        LD	A,H
        ADC	A,00H
        LD	H,A
        LD	A,(HL)
        CP	00H
        JP	Z,J84A0
        CALL	C85DA
        INC	HL
        INC	HL
        LD	(HL),A
        JR	C8495

J847E:	LD	A,(HL)
        CALL	C85DA
        LD	(HL),A
        LD	A,27H	; "'"
        INC	HL
        INC	HL
        LD	(HL),A
        JR	C8495

;	  Subroutine __________________________
;	     Inputs  ________________________
;	     Outputs ________________________
C848A:	LD	A,01H	; 1
        LD	B,A
        LD	(IX+2),A
        LD	(IX+24),A
        AND	A
        RET

;	  Subroutine __________________________
;	     Inputs  ________________________
;	     Outputs ________________________
C8495:	LD	A,02H	; 2
        LD	B,A
        LD	(IX+2),A
        LD	(IX+24),A
        AND	A
        RET

J84A0:	SCF
        RET

;	  Subroutine __________________________
;	     Inputs  ________________________
;	     Outputs ________________________
C84A2:	LD	(IX+23),E
        LD	A,(IX+2)
        CP	03H	; 3
        JP	NZ,J85CF
        LD	A,(IX+4)
        CP	05H	; 5
        JR	Z,J84C5
        CP	14H	; 20
        JR	Z,J84F7
        CP	1EH
        JP	Z,J8557
        CP	28H	; "("
        JP	Z,J859C
        JP	J85CF

J84C5:	LD	A,E
        CP	0AH	; 10
        JR	Z,J84CD
        JP	J85CF

J84CD:	LD	A,44H	; "D"
        CALL	C85DA
        LD	(HL),A
        LD	A,C
        CP	02H	; 2
        JR	NZ,J84DC
        CALL	C848A
        RET

J84DC:	LD	L,C
        LD	H,B
        PUSH	BC
        LD	BC,I807C
        ADD	HL,BC
        POP	BC
        LD	A,L
        ADD	A,69H	; "i"
        LD	L,A
        LD	A,H
        ADC	A,00H
        LD	H,A
        LD	A,(HL)
        CALL	C85DA
        INC	HL
        INC	HL
        LD	(HL),A
        CALL	C8495
        RET

J84F7:	LD	A,E
        CP	46H	; "F"
        JR	Z,J8503
        CP	05H	; 5
        JR	Z,J852D
        JP	J85CF

J8503:	LD	A,41H	; "A"
        CALL	C85DA
        LD	(HL),A
        LD	A,C
        CP	01H	; 1
        JR	NZ,J8512
        CALL	C848A
        RET

J8512:	LD	L,C
        LD	H,B
        PUSH	BC
        LD	BC,I807C
        ADD	HL,BC
        POP	BC
        LD	A,L
        ADD	A,6EH	; "n"
        LD	L,A
        LD	A,H
        ADC	A,00H
        LD	H,A
        LD	A,(HL)
        CALL	C85DA
        INC	HL
        INC	HL
        LD	(HL),A
        CALL	C8495
        RET

J852D:	LD	A,37H	; "7"
        CALL	C85DA
        LD	(HL),A
        LD	A,C
        CP	01H	; 1
        JR	NZ,J853C
        CALL	C848A
        RET

J853C:	LD	L,C
        LD	H,B
        PUSH	BC
        LD	BC,I807C
        ADD	HL,BC
        POP	BC
        LD	A,L
        ADD	A,6EH	; "n"
        LD	L,A
        LD	A,H
        ADC	A,00H
        LD	H,A
        LD	A,(HL)
        CALL	C85DA
        INC	HL
        INC	HL
        LD	(HL),A
        CALL	C8495
        RET

J8557:	LD	A,E
        CP	1EH
        JP	Z,J85CF
        CP	28H	; "("
        JP	Z,J85CF
        CP	46H	; "F"
        JP	NZ,J856B
        LD	A,0AH	; 10
        JR	J857A

J856B:	CP	50H	; "P"
        JP	Z,J85CF
        CP	5AH	; "Z"
        JP	Z,J85CF
        CP	5FH	; "_"
        JP	P,J85CF
J857A:	INC	A
        LD	E,A
        LD	HL,I807C
        ADD	HL,DE
        LD	A,(HL)
        CALL	C85DA
        LD	(HL),A
        LD	HL,I807C
        ADD	HL,BC
        LD	A,L
        ADD	A,6EH	; "n"
        LD	L,A
        LD	A,H
        ADC	A,00H
        LD	H,A
        LD	A,(HL)
        CALL	C85DA
        INC	HL
        INC	HL
        LD	(HL),A
        CALL	C8495
        RET

J859C:	LD	A,E
        CP	5FH	; "_"
        JR	Z,J85AB
        CP	00H
        JR	Z,J85AB
        CP	2DH	; "-"
        JR	Z,J85AB
        JR	J85CF

J85AB:	INC	A
        INC	A
        LD	E,A
        XOR	D
        LD	HL,I807C
        ADD	HL,DE
        LD	A,(HL)
        CALL	C85DA
        LD	(HL),A
        LD	HL,I807C
        ADD	HL,BC
        LD	A,L
        ADD	A,73H	; "s"
        LD	L,A
        LD	A,H
        ADC	A,00H
        LD	H,A
        LD	A,(HL)
        CALL	C85DA
        INC	HL
        INC	HL
        LD	(HL),A
        CALL	C8495
        RET

J85CF:	SCF
        RET

;	  Subroutine __________________________
;	     Inputs  ________________________
;	     Outputs ________________________
C85D1:	PUSH	AF
        LD	L,(IX)
        LD	H,(IX+1)
J85D6	EQU	$-2
        POP	AF
        RET

;	  Subroutine __________________________
;	     Inputs  ________________________
;	     Outputs ________________________
C85DA:	PUSH	DE
        LD	E,(IX+12)
        SLA	E
        LD	D,00H
        LD	H,(IX+15)
        LD	L,(IX+14)
        ADD	HL,DE
        POP	DE
        RET

;	  Subroutine __________________________
;	     Inputs  ________________________
;	     Outputs ________________________

C85EB:	PUSH	HL
        LD	HL,I805E
        LD	BC,5
        CPIR
        JR	NZ,J85FF
        PUSH	AF
        LD	A,5-1
        SUB	C
        LD	C,A
        POP	AF
        POP	HL
        SCF
        RET

J85FF:	AND	A
        POP	HL
        RET

;	  Subroutine __________________________
;	     Inputs  ________________________
;	     Outputs ________________________

C8602:	PUSH	HL
        LD	HL,I8063
J8606:	LD	BC,20
        CPIR
        JR	NZ,J861F
        PUSH	AF
        LD	A,20-1
        SUB	C
        LD	C,A
        SLA	C
        SLA	C
        ADD	A,C
        LD	E,A
        LD	A,00H
        LD	D,A
        POP	AF
        POP	HL
        AND	A
        RET

J861F:	POP	HL
        SCF
        RET

I8622:	DEFB	00H,00H,00H,00H,00H,00H,00H,00H
		DEFB	0C1H,01H,00H,00H,26H,03H,00H,00H
		DEFB	35H,04H,00H,00H,0DCH,04H,50H,06H
		DEFB	74H,09H,0E7H,09H,0B7H,0BH,03H,0CH
		DEFB	15H,0DH,33H,0DH,0CH,0EH,46H,0EH
		DEFB	3EH,10H,89H,10H,27H,12H,48H,12H
		DEFB	98H,15H,0BBH,16H,0AAH,17H,0B9H,17H
		DEFB	0B9H,18H,0E3H,18H,0E3H,19H,04H,1AH
		DEFB	0E7H,1BH,34H,1CH,00H,00H,00H,00H
		DEFB	1BH,1DH,00H,00H,36H,1EH,0C0H,1EH
		DEFB	0D8H,1EH,67H,20H,0B4H,20H,8DH,21H
		DEFB	16H,22H,39H,22H,7BH,22H,0E8H,22H
		DEFB	0A3H,24H,00H,00H,0F9H,24H,60H,26H
		DEFB	00H,00H,91H,26H,7DH,27H,9AH,27H
		DEFB	9DH,27H,0E1H,27H,0FDH,27H,05H,28H
		DEFB	0F7H,28H,00H,00H,63H,29H,6AH,2AH
		DEFB	29H,2BH,88H,2BH,0CEH,2BH,00H,00H
		DEFB	7CH,2CH,00H,00H,05H,2DH,00H,00H
		DEFB	84H,2DH,31H,2EH,6EH,2EH,1DH,2FH
		DEFB	2CH,2FH,78H,2FH,00H,00H,0B7H,2FH
		DEFB	5EH,30H

C86C4:	PUSH    BC
        PUSH	DE
        PUSH	IX
        PUSH	IY
        LD	C,(HL)
        INC	HL
        LD	B,(HL)
        PUSH	BC
        POP	IX
        LD	BC,128
        ADD	IX,BC
        INC	HL
        LD	C,(HL)
        INC	HL
        LD	B,(HL)
        PUSH	BC
        POP	IY
        LD	A,(IY+0)
        CP	00H
        JR	Z,J86EC
        CP	08H	; 8
        JR	NC,J86EC
        CALL	C870C
        JR	J86F0

J86EC:	LD	(IX+128),00H
J86F0:	LD	BC,-128
        ADD	IX,BC
        LD	A,(IX)
        AND	A
        JR	NZ,J8700
        LD	A,01H	; 1
        SCF
        JR	J8705

J8700:	XOR	A
        AND	A
        PUSH	IX
        POP	HL
J8705:	POP	IY
        POP	IX
        POP	DE
        POP	BC
        RET

;	  Subroutine __________________________
;	     Inputs  ________________________
;	     Outputs ________________________
C870C:	PUSH	IX
        PUSH	IY
        CALL	C872D
        POP	IY
        POP	IX
        LD	A,(IY)
        CP	00H
        JR	Z,J872C
        LD	A,(IX+92)
        CP	00H
        JR	NZ,J8729
        CALL	C8808
        RET

J8729:	CALL	C8856
J872C:	RET

;	  Subroutine __________________________
;	     Inputs  ________________________
;	     Outputs ________________________
C872D:	LD	A,(IY)
        DEC	A
        LD	(IX+92),A
        CP	07H	; 7
        JP	NC,J8803
        LD	A,(IY+2)
        CP	70H	; "p"
        JP	NC,J8803
        CP	21H	; "!"
        JP	C,J8803
        SUB	20H	; " "
        LD	HL,I8C80
        LD	E,A
        LD	D,00H
        SLA	E
        PUSH	IY
        LD	IY,I8622
        ADD	IY,DE
        LD	C,(IY)
        LD	B,(IY+1)
        LD	A,B
        CP	00H
        JR	NZ,J8774
        LD	A,C
        CP	00H
        JR	NZ,J8774
        LD	A,E
        CP	04H	; 4
        JR	Z,J8774
        CP	7EH	; "~"
        JR	Z,J8774
        JP	J8801

J8774:	PUSH	HL
        ADD	HL,BC
        LD	(IX+93),L
        LD	(IX+94),H
J877C:	INC	IY
        INC	IY
        LD	C,(IY)
        LD	B,(IY+1)
        LD	A,B
        CP	00H
        JR	NZ,J8790
        LD	A,C
        CP	00H
        JR	Z,J877C
J8790:	POP	HL
        ADD	HL,BC
        LD	(IX+95),L
        LD	(IX+96),H
        LD	A,(IX+92)
        CP	00H
        JR	Z,J87FE
        POP	IY
        PUSH	IY
        INC	IY
        INC	IY
        LD	(IX+114),A
        PUSH	BC
        PUSH	IX
        LD	BC,97
        ADD	IX,BC
        PUSH	IX
        POP	HL
        POP	IX
        POP	BC
        INC	IY
        INC	IY
        LD	A,(IY+1)
        CP	24H	; "$"
        JR	Z,J87D2
        CP	25H	; "%"
        JR	Z,J87D2
        CP	21H	; "!"
        JR	NZ,J8801
        LD	A,(IY)
        CP	3CH	; "<"
        JR	NZ,J8801
J87D2:	LD	A,(IY)
        LD	(HL),A
        LD	A,(IX+114)
        DEC	A
        LD	(IX+114),A
        CP	00H
        JR	Z,J87FE
        INC	HL
        INC	IY
        INC	IY
        LD	A,(IY+1)
        CP	24H	; "$"
        JR	Z,J87D2
        CP	25H	; "%"
        JR	Z,J87D2
        CP	21H	; "!"
        JR	NZ,J8801
        LD	A,(IY)
        CP	3CH	; "<"
        JR	Z,J87D2
        JR	J8801

J87FE:	POP	IY
        RET

J8801:	POP	IY
J8803:	XOR	A
        LD	(IX+128),A
        RET

;	  Subroutine __________________________
;	     Inputs  ________________________
;	     Outputs ________________________
C8808:	LD	L,(IX+93)
        LD	H,(IX+94)
        LD	E,(IX+95)
        LD	D,(IX+96)
        PUSH	IX
        LD	BC,-128
        ADD	IX,BC
        INC	IX
        INC	IX
        LD	BC,0
J8822:	LD	A,(HL)
        SLA	A
        JR	C,J884D
        SRL	A
        LD	(IX+1),A
        INC	HL
        LD	A,D
        CP	H
        JR	NZ,J8835
        LD	A,E
        CP	L
        JR	Z,J884D
J8835:	LD	A,(HL)
        SLA	A
        JR	C,J884D
        SRL	A
        LD	(IX),A
        INC	HL
        INC	IX
        INC	IX
        INC	BC
        LD	A,H
        CP	D
        JR	NZ,J8822
        LD	A,L
        CP	E
        JR	NZ,J8822
J884D:	POP	IX
        LD	(IX+128),C
        LD	(IX-127),B
        RET

;	  Subroutine __________________________
;	     Inputs  ________________________
;	     Outputs ________________________
C8856:	LD	E,(IX+93)
        LD	D,(IX+94)
        LD	C,(IX+95)
        LD	B,(IX+96)
J8862:	PUSH	IY
        CALL	C8892
        POP	IY
        LD	A,(IX+105)
        CP	01H	; 1
        JR	Z,J888A
        LD	A,D
        CP	B
        JR	NZ,J8878
        LD	A,E
        CP	C
        JR	Z,J888A
J8878:	PUSH	DE
        PUSH	BC
        CALL	C890F
        POP	BC
        POP	DE
        LD	A,(IX+106)
        CP	00H
        JR	NZ,J8862
        CALL	C8808
        RET

J888A:	XOR	A
        LD	(IX+128),A
        LD	(IX-127),A
        RET

;	  Subroutine __________________________
;	     Inputs  ________________________
;	     Outputs ________________________
C8892:	XOR	A
        LD	(IX+105),A
        LD	(IX+113),A
J8899:	LD	A,(DE)
        SLA	A
        JR	C,J88B2
        INC	DE
        INC	DE
        PUSH	DE
        POP	HL
        LD	(IX+103),C
        LD	(IX+104),B
        LD	A,C
        CP	L
        JR	NZ,J8899
        LD	A,B
        CP	H
        JR	NZ,J8899
        JR	J8906

J88B2:	PUSH	BC
        PUSH	IX
        LD	BC,107
        ADD	IX,BC
        PUSH	IX
        POP	IY
        POP	IX
        POP	BC
        SRL	A
        CP	70H	; "p"
        JR	NZ,J88C9
        LD	A,3CH	; "<"
J88C9:	LD	(IY),A
        LD	A,(IX+113)
        INC	A
        LD	(IX+113),A
J88D3:	INC	DE
        PUSH	BC
        POP	HL
        LD	(IX+103),C
        LD	(IX+104),B
        LD	A,D
        CP	H
        JR	NZ,J88E4
        LD	A,E
        CP	L
        JR	Z,J88FF
J88E4:	LD	A,(DE)
        SLA	A
        JR	NC,J88FF
        SRL	A
        INC	IY
        CP	70H	; "p"
        JR	NZ,J88F3
        LD	A,3CH	; "<"
J88F3:	LD	(IY),A
        LD	A,(IX+113)
        INC	A
        LD	(IX+113),A
        JR	J88D3

J88FF:	LD	(IX+93),E
        LD	(IX+94),D
        RET

J8906:	LD	A,(IX+105)
        LD	A,01H	; 1
        LD	(IX+105),A
        RET

;	  Subroutine __________________________
;	     Inputs  ________________________
;	     Outputs ________________________
C890F:	PUSH	IY
        PUSH	IX
        LD	A,(IX+113)
        LD	B,A
        LD	A,(IX+92)
        CP	B
        JR	NZ,J893F
        POP	IY
        PUSH	IX
        PUSH	BC
        LD	BC,97
        ADD	IX,BC
        LD	C,6BH	; "k"
        ADD	IY,BC
        POP	BC
        LD	C,A
J892D:	LD	B,(IX)
        LD	A,(IY)
        CP	B
        JR	NZ,J893F
        INC	IX
        INC	IY
        DEC	C
        JR	Z,J894C
        JR	J892D

J893F:	POP	IX
        POP	IY
        LD	A,(IX+106)
        LD	A,01H	; 1
        LD	(IX+106),A
        RET

J894C:	POP	IX
        POP	IY
        LD	A,(IX+106)
        LD	A,00H
        LD	(IX+106),A
        RET

;	  Subroutine __________________________
;	     Inputs  ________________________
;	     Outputs ________________________
C8959:	PUSH	AF
        PUSH	BC
        PUSH	DE
        LD	C,(HL)
        INC	HL
        LD	B,(HL)
        PUSH	BC
        PUSH	BC
        POP	IX
        POP	IY
        LD	B,(IX)
        LD	C,B
        LD	A,B
        OR	A
        JR	Z,J89A5
        INC	IX
        INC	IX
J8971:	LD	A,(IX+1)
        CP	50H	; "P"
        JR	C,J8998
        DEC	C
        PUSH	BC
        PUSH	IX
        PUSH	IY
        POP	HL
        POP	BC
        LD	DE,201
        ADD	HL,DE
        AND	A
        SBC	HL,BC
        PUSH	HL
        POP	BC
        PUSH	IX
        PUSH	IX
        POP	DE
        POP	HL
        INC	HL
        INC	HL
        LDIR
        POP	BC
        DEC	IX
        DEC	IX
J8998:	INC	IX
        INC	IX
        DJNZ	J8971
        LD	(IY),C
        LD	A,C
        OR	A
        JR	Z,J89A9
J89A5:	POP	DE
        POP	BC
        POP	AF
        RET

J89A9:	POP	DE
        POP	BC
        POP	AF
        LD	A,01H	; 1
        SCF
        RET

I89B0:	DEFB	20H,21H,22H,23H,24H,25H,26H,27H
		DEFB	28H,29H,2AH,2BH,2CH,2DH,2EH,2FH
		DEFB	3AH,3BH,3CH,3DH,3EH,3FH,40H,5BH
		DEFB	5CH,5DH,5EH,5FH,60H,7BH,7CH,7DH
		DEFB	7EH,0A1H,0A2H,0A3H,0A4H,0A5H,0B0H,0DEH
		DEFB	0DFH,00H
I89DA:	DEFB	30H,31H,32H,33H,34H,35H
		DEFB	36H,37H,38H,39H,41H,42H,43H,44H
		DEFB	45H,46H,47H,48H,49H,4AH,4BH,4CH
		DEFB	4DH,4EH,4FH,50H,51H,52H,53H,54H
		DEFB	55H,56H,57H,58H,59H,5AH,61H,62H
		DEFB	63H,64H,65H,66H,67H,68H,69H,6AH
		DEFB	6BH,6CH,6DH,6EH,6FH,70H,71H,72H
		DEFB	73H,74H,75H,76H,77H,78H,79H,7AH
		DEFB	00H
I8A19:	DEFB	0A6H,0A7H,0A8H,0A9H,0AAH,0ABH,0ACH
		DEFB	0ADH,0AEH,0AFH,0B1H,0B2H,0B3H,0B4H,0B5H
		DEFB	0B6H,0B7H,0B8H,0B9H,0BAH,0BBH,0BCH,0BDH
		DEFB	0BEH,0BFH,0C0H,0C1H,0C2H,0C3H,0C4H,0C5H
		DEFB	0C6H,0C7H,0C8H,0C9H,0CAH,0CBH,0CCH,0CDH
		DEFB	0CEH,0CFH,0D0H,0D1H,0D2H,0D3H,0D4H,0D5H
		DEFB	0D6H,0D7H,0D8H,0D9H,0DAH,0DBH,0DCH,0DDH
		DEFB	00H
I8A51:	DEFB	21H,2AH,6DH,74H,70H,73H,75H
		DEFB	47H,4AH,4BH,76H,5CH,24H,5DH,25H
		DEFB	3FH,27H,28H,52H,61H,53H,29H,77H
		DEFB	4EH,6FH,4FH,30H,32H,2EH,50H,43H
		DEFB	51H,41H,23H,56H,57H,22H,26H,3CH
		DEFB	2BH,2CH
I8A7A:	DEFB	72H,21H,23H,25H,27H,29H
		DEFB	63H,65H,67H,43H,22H,24H,26H,28H
		DEFB	2AH,2BH,2DH,2FH,31H,33H,35H,37H
		DEFB	39H,3BH,3DH,3FH,41H,44H,46H,48H
		DEFB	4AH,4BH,4CH,4DH,4EH,4FH,52H,55H
		DEFB	58H,5BH,5EH,5FH,60H,61H,62H,64H
		DEFB	66H,68H,69H,6AH,6BH,6CH,6DH,6FH
		DEFB	73H
I8AB1:	DEFB	2CH,2EH,30H,32H,34H,36H,38H
		DEFB	3AH,3CH,3EH,40H,42H,45H,47H,49H
		DEFB	50H,53H,56H,59H,5CH
I8AC5:	DEFB	51H,54H,57H
		DEFB	5AH,5DH

;	  Subroutine __________________________
;	     Inputs  ________________________
;	     Outputs ________________________
C8ACA:	PUSH	BC
        PUSH	DE
        PUSH	IY
        PUSH	IX
        LD	A,H
        AND	A
        JP	Z,J8AF3
        LD	HL,I89B0
        LD	BC,42
        CPIR
        JR	Z,J8AFB
        LD	HL,I89DA
        LD	BC,62
        CPIR
        JR	Z,J8B0F
        LD	HL,I8A19
        LD	BC,55
        CPIR
        JR	Z,J8B15
J8AF3:	XOR	A
        LD	H,A
        LD	L,A
        LD	A,01H	; 1
        SCF
        JR	J8B28

J8AFB:	LD	A,29H	; ")"
        SUB	C
        LD	B,00H
        LD	C,A
        LD	IX,I8A51
        ADD	IX,BC
        LD	L,(IX)
        LD	A,21H	; "!"
        LD	H,A
        JR	J8B26

J8B0F:	LD	L,A
        LD	A,23H	; "#"
        LD	H,A
        JR	J8B26

J8B15:	LD	A,36H	; "6"
        SUB	C
        LD	B,00H
        LD	C,A
        LD	IX,I8A7A
        ADD	IX,BC
        LD	L,(IX)
        LD	H,25H	; "%"
J8B26:	XOR	A
        AND	A
J8B28:	POP	IX
        POP	IY
        POP	DE
        POP	BC
        RET

;	  Subroutine __________________________
;	     Inputs  ________________________
;	     Outputs ________________________
C8B2F:	PUSH	BC
        PUSH	DE
        PUSH	IX
        PUSH	IY
        LD	A,H
        AND	A
        JP	Z,J8BD0
        LD	E,L
        CP	21H	; "!"
        JR	Z,J8B4A
        CP	23H	; "#"
        JR	Z,J8B6C
        CP	25H	; "%"
        JR	Z,J8B7F
        JP	J8BD0

J8B4A:	LD	A,E
        LD	HL,I8A51
        LD	BC,41
        CPIR
        JP	NZ,J8BD0
        LD	A,28H	; "("
        SUB	C
        LD	B,00H
        LD	C,A
        LD	IX,I89B0
        ADD	IX,BC
        LD	H,(IX)
        LD	L,00H
        XOR	A
        AND	A
        JP	J8BD6

J8B6C:	LD	A,E
        LD	HL,I89DA
        LD	BC,62
        CPIR
        JR	NZ,J8BD0
        LD	H,A
        LD	L,00H
        XOR	A
        AND	A
        JP	J8BD6

J8B7F:	LD	A,E
        CP	74H	; "t"
        JR	Z,J8BA7
        LD	HL,I8AB1
        LD	BC,20
        CPIR
        JR	NZ,J8B95
        SUB	01H	; 1
        LD	E,A
        LD	L,0DEH
        JR	J8BB0

J8B95:	LD	A,E
        LD	HL,I8AC5
        LD	BC,5
        CPIR
        JR	NZ,J8BAE
        SUB	02H	; 2
        LD	E,A
        LD	L,0DFH
        JR	J8BB0

J8BA7:	LD	HL,IB3DE
        XOR	A
        AND	A
        JR	J8BD6

J8BAE:	LD	L,00H
J8BB0:	LD	A,E
        PUSH	HL
        LD	HL,I8A7A
        LD	BC,55
        CPIR
        POP	HL
        JR	NZ,J8BD0
        LD	A,36H	; "6"
        SUB	C
        LD	B,00H
        LD	C,A
        LD	IX,I8A19
        ADD	IX,BC
        LD	H,(IX)
        XOR	A
        AND	A
        JR	J8BD6

J8BD0:	LD	HL,0
        LD	A,01H	; 1
        SCF
J8BD6:	POP	IY
        POP	IX
        POP	DE
        POP	BC
        RET

;	  Subroutine __________________________
;	     Inputs  ________________________
;	     Outputs ________________________
C8BDD:	PUSH	BC
        PUSH	DE
        PUSH	IY
        PUSH	IX
        LD	A,H
        CP	21H	; "!"
        JR	NZ,J8BF2
        LD	A,L
        CP	21H	; "!"
        JR	NZ,J8BF2
        LD	HL,2020H
        JR	J8C16

J8BF2:	LD	A,L
        ADD	A,1FH
        LD	L,A
        SRL	H
        JP	C,J8C00
        DEC	H
        LD	A,L
        ADD	A,5EH	; "^"
        LD	L,A
J8C00:	LD	A,L
        CP	7FH
        JP	C,J8C07
        INC	L
J8C07:	LD	A,H
        CP	2FH	; "/"
        JP	NC,J8C12
        ADD	A,71H	; "q"
        LD	H,A
        JR	J8C16

J8C12:	LD	A,H
        ADD	A,0B1H
        LD	H,A
J8C16:	XOR	A
        AND	A
        POP	IX
        POP	IY
        POP	DE
        POP	BC
        RET

;	  Subroutine __________________________
;	     Inputs  ________________________
;	     Outputs ________________________
C8C1F:	PUSH	BC
        PUSH	DE
        PUSH	IY
        PUSH	IX
        LD	A,H
        CP	20H	; " "
        JR	NZ,J8C35
        LD	A,L
        CP	20H	; " "
        JR	NZ,J8C35
        LD	A,21H	; "!"
        LD	H,A
        LD	L,A
        JR	J8C65

J8C35:	LD	A,H
        CP	80H
        JR	Z,J8C65
        CP	0A0H
        JR	NC,J8C43
        SUB	70H	; "p"
        LD	H,A
        JR	J8C4B

J8C43:	CP	0F0H
        JP	NC,J8C65
        SUB	0B0H
        LD	H,A
J8C4B:	LD	A,L
        CP	7FH
        OR	A
        JP	P,J8C53
        DEC	L
J8C53:	LD	A,H
        ADD	A,H
        LD	H,A
        LD	A,L
        CP	9EH
        JP	C,J8C61
        SUB	5EH	; "^"
        LD	L,A
        JR	J8C62

J8C61:	DEC	H
J8C62:	SUB	1FH
        LD	L,A
J8C65:	XOR	A
        AND	A
        POP	IX
        POP	IY
        POP	DE
        POP	BC
        RET

?8C6E:	DEFS    8C80H-$,0FFH

I8C80:	DEFB	30H,21H,30H,24H,30H,22H,30H,23H
		DEFB	50H,33H,0A4H,41H,6AH,30H,26H,30H
		DEFB	25H,30H,29H,30H,28H,4DH,75H,30H
		DEFB	23H,30H,27H,0A4H,0C0H,34H,56H,0A6H
		DEFB	41H,78H,0A8H,0C6H,34H,3AH,0AAH,40H
		DEFB	44H,41H,73H,0AAH,0A4H,30H,2AH,0AAH
		DEFB	0B0H,36H,44H,0AAH,0EBH,40H,7AH,0ABH
		DEFB	40H,56H,39H,24H,0ABH,0C4H,0ADH,36H
		DEFB	47H,0ABH,0CDH,30H,2BH,0ADH,4CH,40H
		DEFB	3EH,3CH,3DH,29H,3EH,4FH,3EH,34H
		DEFB	30H,2CH,0ADH,0E9H,39H,38H,3EH,34H
		DEFB	49H,4BH,0ADH,0E9H,0E1H,0EBH,44H,7CH
		DEFB	0ADH,0EBH,4BH,30H,31H,5EH,0ADH,0ECH
		DEFB	0EBH,4AH,72H,0AFH,30H,2DH,30H,2EH
		DEFB	30H,2FH,0AFH,0BFH,33H,29H,0B1H,3CH
		DEFB	6BH,0B1H,0DCH,0CEH,3DH,6CH,0B2H,0EBH
		DEFB	4DH,48H,0B3H,0ACH,0ECH,46H,34H,0B4H
		DEFB	33H,5CH,70H,77H,0B5H,44H,2BH,4BH
		DEFB	63H,40H,75H,0B5H,0A4H,40H,75H,0B5H
		DEFB	0D2H,30H,30H,0B6H,3BH,7AH,61H,5CH
		DEFB	0B6H,0E4H,0ABH,41H,2FH,0B7H,42H,2DH
		DEFB	35H,53H,30H,31H,30H,32H,0B8H,4CH
		DEFB	23H,30H,33H,0BAH,0B1H,0EBH,4DH,42H
		DEFB	0BAH,0B5H,30H,34H,0BBH,34H,40H,0BCH
		DEFB	48H,4AH,37H,4DH,0BDH,0D6H,4DH,37H
		DEFB	0BFH,0A4H,32H,41H,43H,4DH,0BFH,0A8H
		DEFB	0EBH,4DH,3FH,0BFH,0ABH,0E2H,33H,66H
		DEFB	0BFH,0BFH,0ABH,0A4H,32H,39H,43H,48H
		DEFB	0BFH,0DEH,46H,2CH,0BFH,0E9H,0B7H,0A4H
		DEFB	3FH,37H,0C0H,3DH,32H,35H,58H,0C4H
		DEFB	30H,35H,46H,46H,30H,2FH,30H,36H
		DEFB	46H,58H,0C4H,0A4H,47H,2EH,38H,7CH
		DEFB	3DH,6BH,0C4H,0ABH,0A4H,30H,37H,0C4H
		DEFB	0DEH,0EBH,3DH,38H,0C6H,30H,38H,0C8H
		DEFB	38H,65H,40H,57H,40H,58H,3AH,2FH
		DEFB	0CAH,37H,6AH,39H,26H,0CAH,0C9H,0EBH
		DEFB	49H,6EH,0CBH,37H,3BH,6CH,31H,0CBH
		DEFB	0E8H,0E1H,55H,3FH,0CDH,3BH,50H,30H
		DEFB	39H,0D3H,0EBH,4DH,61H,0D5H,0ECH,0EBH
		DEFB	30H,6EH,0D6H,30H,3AH,0D6H,0CAH,0A4H
		DEFB	34H,6DH,0D6H,0DFH,46H,2AH,0D6H,0E9H
		DEFB	4CH,7DH,0DEH,45H,37H,46H,74H,0DEH
		DEFB	0A4H,34H,45H,0DEH,0EBH,4DH,3EH,0DFH
		DEFB	4CH,56H,0E0H,4AH,54H,0E1H,31H,2BH
		DEFB	30H,3BH,0E4H,30H,3DH,30H,3CH,0E4H
		DEFB	0B7H,0A4H,32H,78H,0E6H,30H,3EH,0E9H
		DEFB	0A4H,39H,53H,41H,46H,0E9H,0ABH,0B8H
		DEFB	0E1H,4DH,3DH,0E9H,0B7H,4DH,72H,0E9H
		DEFB	0BDH,0A6H,41H,68H,0E9H,0EFH,0B9H,43H
		DEFB	78H,0EAH,35H,42H,0EBH,30H,3FH,0EBH
		DEFB	0AFH,4AH,62H,0EFH,4BH,22H,30H,40H
		DEFB	0EFH,0A4H,43H,38H,0EFH,0BBH,30H,41H
		DEFB	0EFH,0C6H,0EBH,39H,32H,0EFH,0ECH,30H
		DEFB	25H,0EFH,0ECH,0E0H,4EH,79H,0F3H,30H
		DEFB	42H,30H,46H,30H,45H,30H,43H,30H
		DEFB	48H,30H,47H,30H,44H,0F3H,0BAH,30H
		DEFB	49H,30H,51H,30H,66H,30H,4AH,30H
		DEFB	55H,30H,4CH,30H,4BH,30H,63H,30H
		DEFB	65H,30H,57H,30H,61H,30H,5BH,30H
		DEFB	4DH,30H,5DH,30H,5CH,30H,64H,30H
		DEFB	59H,30H,4FH,30H,52H,30H,5FH,43H
		DEFB	76H,30H,56H,48H,65H,30H,58H,30H
		DEFB	4EH,30H,53H,30H,5EH,30H,50H,30H
		DEFB	54H,30H,5AH,30H,60H,30H,62H,30H
		DEFB	67H,34H,50H,42H,42H,56H,61H,57H
		DEFB	43H,43H,72H,0A4H,48H,53H,0A6H,38H
		DEFB	40H,31H,3EH,0A8H,32H,48H,0ABH,0C0H
		DEFB	48H,35H,0ABH,0EAH,45H,5CH,44H,76H
		DEFB	49H,45H,0ADH,30H,68H,42H,29H,3FH
		DEFB	68H,0ADH,0AAH,0A4H,40H,2AH,0AFH,39H
		DEFB	54H,30H,69H,34H,76H,30H,6AH,0B1H
		DEFB	43H,53H,0B3H,0A4H,37H,46H,0B5H,0AAH
		DEFB	38H,79H,37H,2EH,0B5H,0AEH,0E8H,0A4H
		DEFB	37H,69H,0B5H,0B5H,0ABH,3AH,33H,0B5H
		DEFB	0E0H,4DH,26H,0B7H,40H,50H,0B7H,0BAH
		DEFB	0A8H,41H,43H,0BAH,0DFH,40H,74H,0BDH
		DEFB	30H,6BH,0BDH,0ACH,0B7H,0A4H,4BH,3BH
		DEFB	0BDH,0B0H,35H,5EH,0BFH,48H,44H,0BFH
		DEFB	0AFH,44H,4BH,0BFH,0B9H,43H,57H,0BFH
		DEFB	0C0H,0ADH,44H,3AH,0BFH,0E0H,45H,69H
		DEFB	0BFH,0EBH,3BH,6AH,45H,7EH,0C1H,30H
		DEFB	6CH,3BH,54H,30H,6DH,50H,21H,0C1H
		DEFB	0B4H,67H,75H,0C4H,30H,6FH,30H,6EH
		DEFB	0C8H,3BH,65H,0CAH,48H,5DH,0CCH,38H
		DEFB	24H,36H,69H,58H,7CH,0CCH,0A4H,34H
		DEFB	25H,0CDH,30H,70H,0CEH,0B7H,0B7H,43H
		DEFB	76H,0CEH,0C1H,4CH,3FH,0CEH,0EBH,35H
		DEFB	27H,45H,78H,0D0H,0E9H,30H,71H,5BH
		DEFB	79H,37H,55H,0DEH,3AH,23H,0E0H,34H
		DEFB	77H,0E2H,30H,72H,3DH,73H,3DH,72H
		DEFB	0E2H,0A6H,0C8H,4BH,65H,0E4H,0B7H,0A4H
		DEFB	48H,5CH,41H,28H,6CH,4DH,0E8H,0A4H
		DEFB	0E8H,4CH,7CH,0E9H,32H,57H,0EBH,46H
		DEFB	7EH,35H,6FH,3CH,4DH,43H,72H,40H
		DEFB	79H,0EDH,3FH,27H,0EFH,34H,64H,48H
		DEFB	58H,0EFH,0A4H,3DH,4BH,0EFH,0B7H,30H
		DEFB	73H,0F3H,30H,77H,31H,21H,30H,7AH
		DEFB	30H,75H,30H,78H,30H,7BH,31H,22H
		DEFB	31H,23H,30H,74H,30H,7EH,30H,79H
		DEFB	30H,7DH,30H,7CH,30H,76H,31H,24H
		DEFB	70H,28H,0F3H,0C1H,31H,25H,31H,26H
		DEFB	31H,2BH,31H,29H,31H,27H,31H,28H
		DEFB	31H,2DH,31H,2CH,31H,2AH,0A8H,3EH
		DEFB	65H,35H,32H,0A8H,0EBH,3FH,22H,0AAH
		DEFB	35H,7BH,0ABH,0ACH,0A4H,31H,2EH,0ABH
		DEFB	0ACH,0A6H,3BH,47H,31H,2EH,0ACH,0C4H
		DEFB	40H,7CH,0AFH,49H,62H,0B0H,0A4H,0B9H
		DEFB	32H,29H,72H,74H,0B1H,3CH,75H,0B4H
		DEFB	0AFH,46H,30H,0B5H,0AEH,45H,46H,45H
		DEFB	51H,0B7H,35H,6DH,31H,2FH,0B7H,0EDH
		DEFB	38H,65H,0B8H,3BH,61H,0B9H,31H,31H
		DEFB	31H,30H,0B9H,0A4H,47H,76H,0BAH,31H
		DEFB	32H,0BAH,0AFH,61H,56H,0BDH,31H,33H
		DEFB	0BFH,32H,4EH,31H,34H,0BFH,0A4H,4DH
		DEFB	58H,0C1H,46H,62H,4EH,23H,0C4H,42H
		DEFB	47H,46H,24H,31H,35H,31H,36H,5DH
		DEFB	35H,0C4H,0AFH,0B7H,0A4H,48H,7EH,0C4H
		DEFB	0B9H,3CH,4CH,0C4H,0EFH,34H,6FH,0C7H
		DEFB	4FH,53H,0CAH,0AEH,31H,37H,0CAH,0B8H
		DEFB	39H,60H,0CAH,0BAH,0AFH,70H,77H,0CAH
		DEFB	0EBH,53H,39H,0CDH,37H,4DH,40H,26H
		DEFB	48H,50H,0D0H,31H,38H,0D0H,0A6H,43H
		DEFB	25H,0DEH,38H,61H,47H,4FH,0DEH,0A4H
		DEFB	3BH,5DH,0DEH,0E4H,31H,39H,0DFH,33H
		DEFB	24H,47H,3FH,0E0H,47H,3FH,0E1H,47H
		DEFB	5FH,47H,60H,0E9H,31H,3AH,4EH,22H
		DEFB	0E9H,0CAH,0A4H,40H,6AH,4BH,4EH,0E9H
		DEFB	0E0H,3AH,28H,31H,65H,0E9H,0E4H,0E0H
		DEFB	41H,22H,0EAH,31H,3BH,0EBH,47H,64H
		DEFB	0EBH,0A6H,31H,3CH,0EBH,0AAH,0A4H,3DH
		DEFB	61H,0EBH,0B7H,3CH,3FH,0EBH,0EFH,0B7H
		DEFB	0A4H,4EH,6FH,0ECH,0A4H,4DH,2BH,3DH
		DEFB	25H,0ECH,0B7H,0A4H,34H,72H,0EDH,0B3H
		DEFB	4EH,5AH,0EFH,0B5H,31H,3DH,0F3H,31H
		DEFB	3FH,31H,40H,31H,3EH,3DH,45H,39H
		DEFB	3EH,31H,52H,37H,43H,4AH,41H,33H
		DEFB	28H,31H,41H,31H,42H,37H,45H,0A4H
		DEFB	31H,47H,31H,44H,31H,51H,31H,49H
		DEFB	31H,52H,31H,4AH,31H,46H,31H,4BH
		DEFB	31H,54H,31H,48H,31H,4DH,31H,4EH
		DEFB	31H,45H,31H,53H,31H,4CH,31H,4FH
		DEFB	31H,43H,31H,50H,0ACH,0AFH,49H,41H
		DEFB	0ADH,31H,58H,30H,57H,31H,57H,31H
		DEFB	55H,31H,56H,65H,68H,0B5H,31H,42H
		DEFB	0C0H,3BH,5EH,0C4H,31H,5BH,31H,59H
		DEFB	31H,5CH,31H,5AH,0CEH,0ADH,31H,5DH
		DEFB	0D3H,32H,5CH,0D3H,0B9H,3DH,3FH,0E9H
		DEFB	0A4H,30H,4EH,0EAH,36H,5EH,36H,5FH
		DEFB	0EBH,46H,40H,0F3H,31H,5FH,31H,69H
		DEFB	31H,60H,31H,67H,31H,73H,31H,64H
		DEFB	31H,76H,31H,6CH,31H,68H,31H,6AH
		DEFB	4AH,25H,31H,74H,31H,71H,31H,6FH
		DEFB	31H,63H,31H,6EH,31H,70H,31H,62H
		DEFB	31H,6DH,31H,6BH,31H,72H,31H,5EH
		DEFB	31H,61H,31H,65H,31H,66H,31H,75H
		DEFB	55H,36H,5FH,61H,43H,4BH,4DH,3AH
		DEFB	48H,78H,38H,66H,31H,78H,3DH,6FH
		DEFB	31H,77H,49H,57H,0A4H,35H,68H,31H
		DEFB	79H,0A4H,0C6H,31H,77H,0A6H,32H,23H
		DEFB	31H,7BH,31H,7EH,32H,26H,44H,49H
		DEFB	31H,7CH,32H,21H,32H,24H,32H,2BH
		DEFB	39H,44H,31H,7DH,32H,29H,32H,22H
		DEFB	32H,2AH,32H,25H,31H,7AH,32H,27H
		DEFB	32H,28H,53H,52H,58H,66H,72H,74H
		DEFB	0A6H,0AEH,40H,70H,0AAH,42H,67H,0AAH
		DEFB	0A4H,42H,3FH,0AAH,0ABH,0DFH,4FH,35H
		DEFB	0AAH,0ADH,0A4H,42H,67H,0AAH,0C8H,0EAH
		DEFB	4BH,31H,0AAH,0E0H,0CDH,33H,35H,0AAH
		DEFB	0E4H,0B1H,38H,78H,0ABH,32H,2CH,35H
		DEFB	56H,0ABH,0B9H,3FH,2FH,0ACH,0E0H,47H
		DEFB	52H,0ADH,32H,2DH,0ADH,0C6H,59H,5DH
		DEFB	0ADH,0CAH,32H,27H,0AEH,32H,2EH,0AEH
		DEFB	0CAH,0A6H,4AH,64H,0AFH,32H,30H,32H
		DEFB	2FH,43H,56H,31H,7CH,32H,31H,32H
		DEFB	32H,0AFH,0EBH,41H,77H,42H,23H,0B1H
		DEFB	32H,33H,0B3H,0BFH,0EBH,42H,55H,0B3H
		DEFB	0CAH,0A6H,39H,54H,0B3H,0EBH,45H,5CH
		DEFB	0B4H,0EBH,54H,7AH,0B5H,0A8H,0EBH,4DH
		DEFB	5EH,0B5H,0CAH,0A4H,4DH,44H,0B7H,0A4H
		DEFB	40H,4BH,0B9H,4DH,3AH,3FH,64H,32H
		DEFB	21H,32H,34H,0BDH,0A4H,43H,59H,0BDH
		DEFB	0A6H,3DH,31H,0BDH,0ECH,36H,73H,0C0H
		DEFB	0E4H,0ABH,32H,3AH,0C1H,0EBH,4DH,6EH
		DEFB	0C3H,0C8H,49H,57H,0C4H,32H,35H,0C8H
		DEFB	32H,3BH,0C8H,0A6H,0C8H,44H,6FH,0C8H
		DEFB	0B3H,43H,4BH,0C8H,0EAH,53H,79H,0C8H
		DEFB	0EBH,4EH,74H,0C9H,0B9H,33H,45H,0C9H
		DEFB	0EAH,4DH,59H,0C9H,0EBH,4DH,59H,0C9H
		DEFB	0EDH,0AFH,36H,43H,58H,33H,0CAH,0B8H
		DEFB	46H,31H,0CBH,35H,34H,0CEH,49H,60H
		DEFB	0CEH,0ECH,38H,4AH,0D3H,42H,53H,0D3H
		DEFB	0A8H,0EBH,36H,31H,0DCH,0ECH,0EBH,45H
		DEFB	2EH,0DCH,0EDH,5BH,30H,0E2H,3CH,67H
		DEFB	0E2H,0A4H,3DH,45H,0E2H,0A6H,41H,5BH
		DEFB	0E2H,0C6H,49H,3DH,0E2H,0E0H,0ADH,3CH
		DEFB	71H,0E2H,0E0H,0AFH,49H,6BH,0E2H,0EAH
		DEFB	3FH,6EH,0E4H,3FH,46H,0E8H,0D3H,35H
		DEFB	5AH,0EBH,40H,5EH,0ECH,32H,36H,0EDH
		DEFB	0ABH,36H,72H,0EDH,0B7H,32H,37H,0EFH
		DEFB	0EAH,3DH,2AH,0F3H,32H,3BH,38H,66H
		DEFB	32H,39H,32H,38H,31H,23H,32H,3AH
		DEFB	31H,65H,31H,75H,0F3H,0CAH,3DH,77H
		DEFB	32H,3DH,32H,3CH,32H,48H,32H,44H
		DEFB	32H,41H,32H,4EH,32H,43H,32H,4AH
		DEFB	32H,50H,32H,4CH,32H,56H,32H,5DH
		DEFB	32H,4FH,32H,3FH,32H,61H,38H,44H
		DEFB	32H,5AH,32H,46H,39H,61H,3CH,2FH
		DEFB	32H,5FH,32H,59H,32H,5BH,32H,42H
		DEFB	32H,3EH,32H,47H,32H,45H,32H,4BH
		DEFB	32H,62H,32H,4DH,32H,5EH,32H,63H
		DEFB	31H,32H,31H,3BH,32H,54H,32H,52H
		DEFB	32H,55H,32H,51H,32H,49H,32H,57H
		DEFB	32H,40H,32H,53H,32H,58H,32H,5CH
		DEFB	32H,60H,0A4H,32H,71H,32H,73H,33H
		DEFB	2BH,33H,24H,33H,26H,32H,72H,33H
		DEFB	2CH,32H,7EH,32H,70H,33H,23H,32H
		DEFB	77H,33H,27H,33H,28H,32H,78H,32H
		DEFB	7CH,33H,29H,33H,2DH,32H,75H,32H
		DEFB	7BH,32H,76H,33H,25H,32H,74H,32H
		DEFB	79H,33H,22H,32H,7AH,32H,7DH,33H
		DEFB	21H,33H,2AH,50H,72H,57H,4BH,0A4H
		DEFB	0B3H,3BH,3DH,0A4H,0EAH,33H,3DH,0A6H
		DEFB	47H,63H,0A8H,0B9H,4AH,56H,0A8H,0C7H
		DEFB	49H,76H,0A8H,0EAH,0DFH,0EBH,38H,5CH
		DEFB	0A8H,0EBH,42H,58H,33H,3FH,0AAH,34H
		DEFB	69H,0AAH,0EAH,39H,61H,33H,3EH,0AAH
		DEFB	0EBH,39H,61H,37H,30H,33H,3EH,0ABH
		DEFB	0EAH,37H,38H,33H,5DH,0ACH,0DFH,34H
		DEFB	55H,36H,40H,0ACH,0E4H,0AFH,4DH,54H
		DEFB	0ADH,33H,40H,33H,41H,33H,42H,69H
		DEFB	5AH,0AEH,38H,30H,33H,43H,6EH,6CH
		DEFB	0AFH,3DH,71H,32H,68H,33H,46H,33H
		DEFB	4AH,33H,4EH,33H,51H,33H,55H,33H
		DEFB	57H,33H,4BH,33H,48H,44H,61H,33H
		DEFB	50H,33H,4DH,33H,53H,33H,56H,33H
		DEFB	4CH,33H,4FH,3BH,5BH,33H,54H,33H
		DEFB	49H,33H,52H,33H,44H,33H,45H,33H
		DEFB	47H,41H,5FH,59H,78H,0B0H,53H,4CH
		DEFB	0B1H,33H,5DH,45H,52H,0B1H,0EBH,36H
		DEFB	6EH,36H,6FH,0B2H,37H,4AH,31H,46H
		DEFB	31H,22H,30H,7EH,0B3H,0E0H,30H,4FH
		DEFB	0B4H,4FH,36H,64H,46H,0B5H,33H,5EH
		DEFB	3BH,31H,3FH,73H,0B6H,0EBH,3EH,7EH
		DEFB	0B7H,33H,5FH,33H,60H,0B7H,0B3H,0A4H
		DEFB	38H,2DH,0B7H,0E9H,46H,2CH,0B7H,0EFH
		DEFB	47H,70H,33H,7CH,0B8H,33H,61H,42H
		DEFB	49H,0B8H,0ABH,33H,62H,0B9H,42H,5FH
		DEFB	47H,74H,41H,6CH,0B9H,0DFH,32H,62H
		DEFB	0BAH,3FH,74H,4FH,42H,0BBH,0B0H,32H
		DEFB	54H,0BCH,49H,77H,0BFH,4AH,7DH,37H
		DEFB	3FH,4AH,52H,33H,63H,38H,2AH,0BFH
		DEFB	0A4H,38H,47H,37H,78H,39H,45H,0BFH
		DEFB	0C1H,37H,41H,0BFH,0CAH,45H,61H,0BFH
		DEFB	0DEH,0EAH,32H,74H,0BFH,0E8H,0EBH,4AH
		DEFB	50H,0BFH,0EBH,38H,6CH,0C4H,3EH,21H
		DEFB	33H,68H,33H,64H,33H,6BH,39H,6EH
		DEFB	33H,6AH,33H,67H,33H,6DH,33H,66H
		DEFB	33H,69H,33H,65H,33H,6CH,33H,6EH
		DEFB	60H,51H,0C4H,0AAH,33H,6FH,0C4H,0C6H
		DEFB	3EH,28H,0C4H,0E9H,37H,4BH,0C6H,4EH
		DEFB	48H,0C9H,4CH,67H,33H,51H,0CAH,3AH
		DEFB	48H,0CAH,0A4H,33H,70H,0CAH,0A6H,33H
		DEFB	70H,0CAH,0A8H,45H,24H,0CAH,0B7H,0A4H
		DEFB	48H,61H,0CAH,0E9H,0BAH,49H,2CH,0CBH
		DEFB	33H,2AH,0CDH,36H,62H,3EH,62H,3EH
		DEFB	60H,0D0H,33H,72H,33H,71H,0D0H,0CDH
		DEFB	3BH,53H,0D0H,0F3H,33H,73H,0D6H,33H
		DEFB	74H,49H,73H,0D6H,0C8H,33H,75H,51H
		DEFB	49H,0D6H,0E9H,45H,2DH,0D9H,4AH,49H
		DEFB	0DEH,33H,77H,33H,79H,4DH,52H,33H
		DEFB	78H,33H,76H,0DEH,0A8H,39H,3DH,0DEH
		DEFB	0C9H,33H,76H,0DFH,3EH,65H,3FH,40H
		DEFB	3BH,66H,48H,31H,33H,7AH,0DFH,0CAH
		DEFB	0EAH,4DH,6BH,0E0H,33H,7AH,0E1H,35H
		DEFB	35H,49H,53H,0E2H,33H,7BH,0E2H,0E1H
		DEFB	32H,2AH,0E4H,33H,7DH,33H,7EH,33H
		DEFB	7CH,0E6H,34H,21H,0E9H,45H,62H,33H
		DEFB	4CH,0E9H,0A4H,3FH,49H,0E9H,0B9H,31H
		DEFB	28H,0E9H,0C0H,42H,4EH,0E9H,0E0H,0B7H
		DEFB	43H,77H,0EAH,32H,3EH,3CH,6DH,34H
		DEFB	22H,34H,67H,34H,23H,0EAH,0EBH,3CH
		DEFB	5AH,0EBH,0A4H,37H,5AH,0ECH,48H,60H
		DEFB	0ECH,0EBH,38H,4FH,0EFH,40H,6EH,32H
		DEFB	4FH,33H,57H,48H,69H,0EFH,0AFH,34H
		DEFB	25H,33H,69H,0EFH,0E4H,52H,4EH,0EFH
		DEFB	0E9H,34H,24H,0F3H,34H,56H,34H,58H
		DEFB	34H,30H,34H,5BH,34H,31H,34H,51H
		DEFB	34H,49H,34H,36H,34H,46H,34H,44H
		DEFB	34H,2CH,34H,29H,34H,34H,34H,33H
		DEFB	34H,3FH,34H,39H,34H,5AH,34H,47H
		DEFB	34H,4AH,34H,54H,34H,35H,34H,2BH
		DEFB	34H,53H,34H,55H,3FH,7BH,34H,45H
		DEFB	34H,25H,34H,32H,34H,4FH,34H,4BH
		DEFB	34H,37H,48H,21H,34H,28H,34H,57H
		DEFB	34H,41H,34H,2AH,34H,4EH,34H,40H
		DEFB	34H,27H,34H,2EH,34H,3EH,34H,3AH
		DEFB	34H,59H,34H,38H,34H,2DH,34H,3DH
		DEFB	34H,26H,34H,3BH,34H,3CH,34H,43H
		DEFB	34H,48H,34H,4DH,4FH,4BH,34H,2FH
		DEFB	34H,42H,34H,4CH,34H,50H,34H,52H
		DEFB	34H,5CH,55H,21H,59H,7EH,5EH,75H
		DEFB	6BH,5DH,0F3H,0CCH,0ADH,6FH,59H,0F3H
		DEFB	0E0H,0EAH,34H,27H,32H,68H,32H,6CH
		DEFB	32H,6DH,32H,66H,34H,24H,32H,6AH
		DEFB	32H,65H,32H,67H,32H,64H,32H,69H
		DEFB	32H,6FH,32H,6EH,32H,6BH,0A4H,33H
		DEFB	30H,33H,39H,33H,32H,33H,35H,33H
		DEFB	36H,33H,3AH,33H,34H,33H,33H,33H
		DEFB	38H,33H,3BH,33H,2EH,33H,2FH,33H
		DEFB	31H,33H,37H,33H,3CH,0AFH,33H,58H
		DEFB	33H,5AH,33H,5BH,33H,59H,33H,5CH
		DEFB	55H,5CH,58H,33H,0B1H,33H,33H,0C4H
		DEFB	37H,6EH,0E9H,4AH,41H,0EFH,42H,26H
		DEFB	0F3H,34H,5DH,34H,5EH,38H,35H,34H
		DEFB	64H,34H,69H,34H,5FH,34H,6AH,34H
		DEFB	63H,34H,60H,34H,61H,34H,67H,34H
		DEFB	62H,34H,66H,34H,68H,34H,65H,35H
		DEFB	21H,4CH,5AH,35H,24H,34H,7CH,35H
		DEFB	2DH,34H,6FH,35H,2CH,34H,70H,34H
		DEFB	6BH,35H,2FH,34H,73H,35H,22H,34H
		DEFB	6EH,34H,75H,35H,25H,35H,2AH,34H
		DEFB	6DH,3CH,79H,34H,78H,35H,28H,32H
		DEFB	2BH,35H,2EH,35H,35H,35H,31H,35H
		DEFB	34H,34H,7AH,34H,7BH,34H,71H,34H
		DEFB	7EH,34H,6CH,34H,7DH,34H,74H,35H
		DEFB	29H,35H,33H,34H,76H,35H,26H,34H
		DEFB	79H,35H,27H,35H,30H,35H,23H,34H
		DEFB	77H,35H,32H,4CH,27H,34H,72H,35H
		DEFB	2BH,37H,37H,51H,5CH,59H,64H,5BH
		DEFB	39H,65H,3AH,73H,4AH,35H,4BH,0AFH
		DEFB	4AH,39H,35H,46H,35H,47H,35H,45H
		DEFB	0B3H,0EAH,3EH,41H,0B6H,0E0H,39H,6FH
		DEFB	0B7H,34H,5FH,0BAH,3DH,7DH,61H,53H
		DEFB	0BAH,0AFH,43H,5BH,0BAH,0CAH,65H,2BH
		DEFB	0BFH,4BH,4CH,0BFH,0CAH,0A4H,31H,78H
		DEFB	0C1H,35H,48H,0C4H,35H,4AH,35H,4DH
		DEFB	35H,4CH,35H,49H,35H,4BH,0C4H,0CDH
		DEFB	38H,51H,0CCH,38H,28H,0CCH,0BFH,35H
		DEFB	4EH,0CDH,35H,4FH,0CEH,0B3H,42H,7BH
		DEFB	0D0H,32H,67H,0D3H,35H,50H,0D3H,0B7H
		DEFB	0A4H,38H,37H,0DFH,37H,2FH,0E2H,34H
		DEFB	4EH,43H,40H,0E3H,32H,40H,0E3H,0AFH
		DEFB	35H,52H,35H,53H,35H,51H,0E5H,0A6H
		DEFB	35H,6BH,36H,65H,35H,5EH,35H,5CH
		DEFB	35H,5AH,35H,61H,35H,59H,35H,69H
		DEFB	35H,65H,35H,57H,35H,66H,35H,56H
		DEFB	35H,6CH,35H,5FH,35H,5BH,35H,63H
		DEFB	35H,5DH,35H,6AH,35H,67H,48H,37H
		DEFB	35H,60H,31H,39H,35H,58H,35H,62H
		DEFB	35H,64H,35H,68H,36H,6AH,64H,7DH
		DEFB	0E7H,35H,73H,35H,70H,35H,76H,35H
		DEFB	6FH,35H,6EH,35H,72H,35H,77H,35H
		DEFB	71H,35H,75H,31H,33H,35H,74H,35H
		DEFB	78H,6EH,31H,0E7H,0A6H,35H,7EH,37H
		DEFB	50H,36H,35H,36H,36H,36H,26H,36H
		DEFB	2FH,36H,28H,36H,3DH,36H,25H,36H
		DEFB	41H,36H,21H,36H,37H,36H,2DH,36H
		DEFB	3FH,36H,32H,36H,3BH,36H,43H,36H
		DEFB	40H,36H,38H,36H,2BH,36H,39H,36H
		DEFB	3CH,36H,22H,35H,7CH,36H,33H,30H
		DEFB	49H,36H,27H,36H,2EH,35H,7DH,36H
		DEFB	29H,36H,2CH,36H,3AH,36H,24H,36H
		DEFB	42H,36H,31H,36H,23H,36H,2AH,36H
		DEFB	30H,36H,34H,36H,3EH,39H,3CH,59H
		DEFB	51H,0E7H,0AFH,36H,49H,36H,4AH,36H
		DEFB	4BH,0E8H,0A4H,40H,36H,0E9H,0A4H,37H
		DEFB	79H,0EAH,4CH,38H,36H,4DH,3FH,6DH
		DEFB	0EBH,40H,5AH,43H,65H,3BH,42H,0EDH
		DEFB	36H,4EH,0EDH,0E1H,0BCH,0C8H,0EBH,36H
		DEFB	4EH,0EFH,3AH,5DH,0F3H,36H,62H,36H
		DEFB	61H,36H,50H,36H,51H,36H,5AH,36H
		DEFB	58H,36H,5BH,36H,53H,36H,5DH,36H
		DEFB	57H,36H,60H,36H,55H,36H,52H,36H
		DEFB	56H,36H,4FH,36H,5EH,36H,54H,36H
		DEFB	5CH,36H,5FH,36H,59H,71H,3CH,35H
		DEFB	44H,35H,3BH,35H,41H,35H,3FH,35H
		DEFB	37H,35H,3EH,34H,6CH,35H,3AH,35H
		DEFB	36H,35H,3DH,35H,43H,35H,3CH,35H
		DEFB	39H,35H,38H,35H,40H,35H,42H,34H
		DEFB	74H,0E3H,0AFH,35H,55H,35H,54H,0E5H
		DEFB	0A6H,35H,6DH,0E7H,38H,66H,35H,79H
		DEFB	35H,7BH,35H,7AH,0E7H,0A6H,36H,48H
		DEFB	39H,54H,36H,44H,36H,47H,36H,45H
		DEFB	36H,46H,0E7H,0AFH,36H,4CH,0F3H,36H
		DEFB	64H,36H,63H,36H,68H,36H,65H,35H
		DEFB	57H,36H,6CH,36H,70H,36H,67H,36H
		DEFB	6EH,36H,69H,36H,66H,36H,6BH,36H
		DEFB	6AH,36H,6DH,36H,6FH,0A4H,36H,74H
		DEFB	39H,3AH,3AH,70H,0A4H,0EBH,32H,79H
		DEFB	0A6H,36H,75H,36H,74H,39H,50H,0ADH
		DEFB	37H,54H,0AEH,45H,23H,0B0H,0A4H,39H
		DEFB	74H,0B5H,41H,70H,0B5H,0A4H,3DH,2DH
		DEFB	0B5H,0E0H,0E9H,41H,51H,0B5H,0EAH,3AH
		DEFB	3FH,0B5H,0EBH,49H,65H,0B7H,36H,7AH
		DEFB	36H,7BH,0B7H,0EDH,36H,7CH,0B8H,0E9H
		DEFB	37H,5FH,0B9H,46H,6FH,3EH,40H,0B9H
		DEFB	0CEH,0ADH,46H,6FH,0B9H,0EAH,4CH,74H
		DEFB	0BAH,33H,6BH,36H,7DH,0BAH,0ECH,0EBH
		DEFB	4AH,78H,0BBH,4AH,4AH,0BDH,4AH,35H
		DEFB	0C0H,34H,49H,0C1H,38H,7DH,0C1H,0D0H
		DEFB	0B7H,53H,5CH,0C1H,0D3H,0EBH,3FH,30H
		DEFB	0C1H,0EBH,35H,60H,0C4H,37H,21H,37H
		DEFB	24H,36H,7EH,37H,22H,37H,23H,0C4H
		DEFB	0EFH,37H,25H,0CBH,39H,71H,4BH,2EH
		DEFB	54H,22H,0D0H,0EBH,47H,5BH,0D3H,3CH
		DEFB	73H,37H,5BH,70H,74H,0DCH,37H,26H
		DEFB	0DEH,37H,27H,37H,28H,0DFH,41H,48H
		DEFB	0E0H,35H,62H,0E1H,37H,29H,0E2H,31H
		DEFB	40H,43H,58H,0E2H,0EAH,46H,5EH,0E4H
		DEFB	0E0H,32H,79H,0E9H,42H,22H,41H,52H
		DEFB	30H,48H,0E9H,0A4H,30H,4CH,30H,45H
		DEFB	0EAH,37H,2AH,37H,2BH,0EAH,0E4H,3FH
		DEFB	5FH,0EBH,4DH,68H,37H,2BH,0EBH,0B7H
		DEFB	0A4H,36H,6CH,0EBH,0DEH,3CH,56H,0EBH
		DEFB	0EFH,33H,54H,33H,47H,0ECH,4AH,6BH
		DEFB	38H,62H,0ECH,0CAH,0A4H,39H,48H,0EDH
		DEFB	39H,75H,0EFH,37H,2CH,37H,2DH,0EFH
		DEFB	0B7H,0A4H,3EH,5CH,0F3H,37H,2FH,37H
		DEFB	31H,37H,2EH,37H,30H,36H,71H,36H
		DEFB	66H,36H,72H,36H,73H,0A6H,36H,78H
		DEFB	35H,5CH,36H,79H,36H,76H,36H,77H
		DEFB	0E9H,0E0H,34H,24H,0F3H,37H,33H,37H
		DEFB	34H,37H,32H,32H,3DH,4CH,53H,37H
		DEFB	36H,37H,35H,37H,37H,0A4H,35H,7EH
		DEFB	37H,50H,37H,38H,37H,57H,37H,41H
		DEFB	37H,59H,37H,3FH,37H,5AH,36H,25H
		DEFB	37H,4AH,37H,4FH,37H,43H,37H,44H
		DEFB	37H,3AH,37H,51H,37H,3BH,37H,39H
		DEFB	37H,4BH,37H,40H,37H,3CH,37H,47H
		DEFB	37H,49H,37H,48H,37H,3DH,37H,46H
		DEFB	37H,5CH,37H,42H,37H,4CH,37H,52H
		DEFB	37H,3EH,37H,4EH,37H,58H,36H,2AH
		DEFB	37H,45H,37H,4DH,37H,53H,37H,54H
		DEFB	37H,55H,37H,56H,37H,5BH,66H,7AH
		DEFB	0B9H,3EH,43H,0BAH,0EBH,3AH,6FH,0BFH
		DEFB	37H,65H,0C0H,0E2H,0CEH,3DH,43H,0C4H
		DEFB	37H,68H,37H,6BH,37H,6CH,37H,67H
		DEFB	37H,6AH,37H,69H,37H,66H,37H,6DH
		DEFB	0E0H,0EAH,31H,6CH,0E2H,0CEH,3DH,43H
		DEFB	0EBH,3DH,33H,0F3H,37H,7AH,38H,2BH
		DEFB	38H,33H,38H,29H,38H,22H,37H,6FH
		DEFB	38H,21H,38H,26H,37H,72H,38H,31H
		DEFB	37H,74H,38H,28H,37H,7BH,37H,78H
		DEFB	37H,73H,38H,24H,38H,25H,38H,2AH
		DEFB	38H,2EH,37H,75H,38H,2FH,38H,2CH
		DEFB	37H,7CH,37H,77H,38H,2DH,37H,7DH
		DEFB	38H,30H,38H,32H,30H,3CH,37H,76H
		DEFB	38H,34H,37H,7EH,37H,71H,37H,79H
		DEFB	34H,42H,37H,70H,38H,23H,38H,27H
		DEFB	52H,25H,54H,21H,32H,3CH,0A4H,37H
		DEFB	5DH,37H,5EH,37H,5FH,69H,3AH,0ADH
		DEFB	37H,60H,37H,62H,37H,63H,37H,61H
		DEFB	37H,64H,5CH,7CH,0C4H,37H,6EH,0F3H
		DEFB	38H,36H,38H,3DH,38H,35H,38H,40H
		DEFB	38H,42H,38H,3AH,38H,3BH,38H,37H
		DEFB	38H,39H,38H,3CH,38H,38H,38H,3EH
		DEFB	38H,3FH,38H,41H,53H,6EH,3BH,52H
		DEFB	3EH,2EH,38H,4DH,38H,45H,38H,4BH
		DEFB	3BH,79H,38H,4EH,38H,44H,38H,47H
		DEFB	4AH,34H,38H,46H,38H,50H,35H,72H
		DEFB	38H,58H,38H,57H,38H,4AH,38H,5CH
		DEFB	38H,5BH,38H,49H,38H,5DH,38H,4FH
		DEFB	38H,55H,38H,6FH,32H,55H,38H,4CH
		DEFB	38H,54H,38H,48H,38H,51H,38H,52H
		DEFB	38H,53H,38H,59H,38H,43H,38H,56H
		DEFB	38H,5AH,38H,6AH,3BH,46H,0A4H,4EH
		DEFB	78H,38H,70H,47H,3BH,38H,71H,0A6H
		DEFB	39H,62H,39H,54H,39H,29H,38H,72H
		DEFB	38H,78H,39H,3BH,38H,7DH,38H,77H
		DEFB	39H,2DH,36H,3DH,38H,7EH,39H,4DH
		DEFB	39H,3EH,39H,56H,39H,25H,39H,5DH
		DEFB	39H,41H,39H,2CH,39H,52H,39H,3DH
		DEFB	39H,5BH,38H,7CH,38H,7AH,39H,2FH
		DEFB	39H,53H,40H,41H,39H,5FH,39H,36H
		DEFB	39H,61H,38H,79H,39H,33H,39H,48H
		DEFB	38H,75H,39H,30H,38H,70H,39H,43H
		DEFB	39H,4BH,39H,39H,32H,2BH,39H,60H
		DEFB	39H,27H,39H,40H,39H,28H,39H,44H
		DEFB	39H,38H,39H,35H,39H,45H,39H,31H
		DEFB	39H,5AH,39H,59H,39H,46H,39H,4CH
		DEFB	39H,42H,39H,2AH,39H,55H,39H,58H
		DEFB	36H,44H,39H,57H,39H,34H,39H,21H
		DEFB	39H,26H,4CH,57H,39H,23H,39H,5CH
		DEFB	39H,63H,39H,37H,39H,3FH,39H,4AH
		DEFB	39H,51H,38H,7BH,39H,2BH,39H,32H
		DEFB	33H,43H,38H,73H,39H,2EH,39H,4EH
		DEFB	39H,5EH,3AH,68H,38H,74H,38H,76H
		DEFB	39H,22H,39H,24H,39H,3AH,39H,3CH
		DEFB	39H,47H,39H,49H,39H,4FH,39H,50H
		DEFB	3BH,29H,4FH,4AH,55H,64H,56H,3EH
		DEFB	57H,22H,5AH,4AH,60H,44H,66H,6AH
		DEFB	0A6H,0B8H,39H,6DH,0A6H,0E0H,0EBH,4CH
		DEFB	58H,0A8H,40H,3CH,0A8H,0EBH,48H,6EH
		DEFB	0AAH,0EAH,37H,34H,49H,39H,0ACH,0E9H
		DEFB	0B7H,51H,5EH,0AFH,39H,71H,39H,75H
		DEFB	39H,70H,39H,6FH,39H,6EH,39H,73H
		DEFB	39H,74H,51H,6EH,53H,2DH,54H,22H
		DEFB	0B0H,41H,66H,0B1H,42H,5DH,0B3H,0EDH
		DEFB	3FH,34H,0B3H,0EDH,0B6H,0B7H,3BH,56H
		DEFB	0B3H,0EDH,0DFH,3BH,6EH,0B3H,0EDH,0E8H
		DEFB	0A4H,32H,77H,0B4H,0A8H,0EBH,45H,60H
		DEFB	0B7H,31H,5BH,39H,78H,39H,77H,4DH
		DEFB	41H,0B7H,0ADH,39H,79H,0B9H,0EBH,3BH
		DEFB	24H,0BAH,0A8H,3EH,3FH,0BFH,0A8H,45H
		DEFB	7AH,0C4H,39H,7CH,39H,7BH,39H,7AH
		DEFB	0C8H,3BH,76H,3CH,6CH,36H,57H,0C8H
		DEFB	0B4H,0C8H,0AFH,3CH,3DH,0C8H,0D6H,0ADH
		DEFB	3CH,77H,54H,68H,0C8H,0EFH,0B6H,38H
		DEFB	41H,0CAH,4AH,34H,0CEH,3AH,21H,0D3H
		DEFB	0EBH,55H,3BH,0DEH,36H,70H,39H,7DH
		DEFB	0DEH,0EBH,3AH,24H,0DFH,39H,7EH,0E0H
		DEFB	39H,7EH,0E1H,4AH,46H,0E2H,41H,26H
		DEFB	38H,56H,0E8H,0DFH,4EH,71H,0EAH,0EBH
		DEFB	44H,28H,0EBH,36H,45H,0ECH,40H,27H
		DEFB	3AH,21H,0EDH,3AH,22H,0EDH,0E2H,30H
		DEFB	61H,0EFH,0A4H,49H,5DH,0F3H,3AH,23H
		DEFB	3AH,2CH,3AH,27H,3AH,2EH,3AH,24H
		DEFB	3AH,29H,3AH,30H,3AH,32H,3AH,28H
		DEFB	3AH,2BH,3AH,2DH,3AH,26H,3AH,2AH
		DEFB	3AH,25H,3AH,2FH,3AH,31H,38H,5EH
		DEFB	38H,65H,38H,61H,38H,6CH,38H,66H
		DEFB	38H,6EH,38H,5FH,38H,63H,38H,6DH
		DEFB	38H,62H,38H,67H,38H,6BH,39H,21H
		DEFB	38H,64H,38H,6FH,38H,60H,38H,68H
		DEFB	38H,69H,38H,6AH,0A6H,39H,67H,39H
		DEFB	66H,39H,6BH,36H,3FH,39H,6CH,39H
		DEFB	64H,39H,69H,39H,6AH,39H,65H,39H
		DEFB	68H,50H,7EH,5DH,5DH,39H,21H,0AFH
		DEFB	39H,76H,0C8H,4BH,68H,0C8H,0B7H,47H
		DEFB	21H,3AH,34H,3AH,3AH,3AH,38H,43H
		DEFB	63H,3AH,39H,3AH,3DH,3AH,3FH,3AH
		DEFB	36H,3AH,3EH,3AH,37H,3BH,37H,3AH
		DEFB	40H,3CH,53H,3AH,35H,3AH,3CH,3AH
		DEFB	3BH,3AH,33H,0A4H,3AH,50H,3AH,47H
		DEFB	3AH,46H,3AH,59H,3AH,5DH,3AH,51H
		DEFB	3AH,5BH,3AH,57H,3AH,4DH,3AH,4AH
		DEFB	3AH,4EH,3AH,44H,3AH,45H,3AH,6BH
		DEFB	3AH,52H,3AH,5CH,3AH,5AH,3AH,58H
		DEFB	3AH,4CH,40H,46H,3AH,48H,3AH,56H
		DEFB	3AH,4FH,3AH,55H,3AH,49H,3AH,4BH
		DEFB	3AH,54H,3AH,53H,56H,43H,60H,4AH
		DEFB	0A4H,0EFH,0A4H,39H,2CH,0A8H,3AH,63H
		DEFB	0AAH,34H,48H,5CH,2AH,0ABH,3AH,65H
		DEFB	3AH,64H,0ABH,0A4H,36H,2DH,3AH,66H
		DEFB	0ABH,0A8H,31H,49H,0ABH,0ADH,3AH,67H
		DEFB	0ABH,0BAH,0ADH,47H,55H,47H,56H,0ABH
		DEFB	0CAH,35H,7BH,3AH,68H,0ABH,0CEH,0DCH
		DEFB	0EBH,41H,4CH,0ACH,0B9H,41H,5CH,43H
		DEFB	35H,0ADH,40H,68H,3AH,6AH,3AH,6BH
		DEFB	3AH,69H,3AH,6CH,0ADH,0ACH,0B1H,33H
		DEFB	21H,0AEH,3AH,6DH,0AFH,3AH,6EH,3AH
		DEFB	76H,3AH,72H,3AH,77H,3AH,6FH,3FH
		DEFB	5DH,3AH,69H,3AH,78H,3AH,73H,3AH
		DEFB	70H,3AH,71H,3AH,74H,3AH,75H,0AFH
		DEFB	0E9H,3AH,79H,5DH,2FH,0B1H,3CH,72H
		DEFB	3AH,7AH,0B1H,0D6H,36H,2BH,0B1H,0EBH
		DEFB	4EH,76H,0B5H,3AH,7BH,0B5H,0B2H,0EBH
		DEFB	4AH,7BH,0B5H,0E4H,0AFH,53H,71H,0B6H
		DEFB	0CAH,0DFH,4EH,7AH,0B8H,3AH,7CH,0BDH
		DEFB	0A6H,4DH,36H,0BDH,0EAH,6AH,38H,0C0H
		DEFB	44H,67H,0C1H,39H,2CH,0C4H,3BH,26H
		DEFB	3BH,21H,3AH,7EH,3BH,25H,3AH,7DH
		DEFB	3BH,23H,3BH,27H,3BH,24H,3BH,22H
		DEFB	51H,6BH,0C4H,0ADH,3BH,29H,0C8H,4EH
		DEFB	24H,0C8H,0A4H,41H,6FH,0C8H,0B9H,4DH
		DEFB	21H,0C8H,0EBH,38H,67H,0D0H,3BH,2AH
		DEFB	0D0H,0ADH,3BH,2BH,0D0H,0AFH,3BH,2BH
		DEFB	0D3H,3BH,2CH,0D3H,0B7H,0A4H,3CH,64H
		DEFB	4EH,54H,0DEH,4DH,4DH,0DEH,0BFH,0B2H
		DEFB	0EBH,4BH,38H,0E0H,0A4H,34H,28H,0E0H
		DEFB	0E9H,0A4H,3BH,78H,0E1H,3BH,2DH,0E1H
		DEFB	0EBH,40H,43H,0E4H,3EH,64H,0E9H,39H
		DEFB	39H,3BH,2EH,0E9H,0B7H,3BH,2FH,0E9H
		DEFB	0B9H,3BH,2FH,0EBH,3FH,3DH,35H,6EH
		DEFB	31H,6EH,0EFH,42H,74H,5FH,37H,0EFH
		DEFB	0B0H,41H,7BH,0EFH,0E4H,0ABH,41H,56H
		DEFB	0F3H,3BH,30H,3BH,33H,3BH,3AH,3BH
		DEFB	32H,3BH,3BH,3BH,36H,3BH,40H,3BH
		DEFB	3FH,3BH,34H,3BH,3EH,3BH,37H,3BH
		DEFB	3DH,3BH,31H,3BH,39H,3BH,41H,3BH
		DEFB	35H,3BH,38H,3BH,3CH,52H,55H,3AH
		DEFB	42H,3AH,41H,3AH,43H,0A4H,3AH,5FH
		DEFB	3AH,60H,3AH,62H,3AH,61H,3AH,5EH
		DEFB	3AH,4BH,0C4H,3BH,28H,0F3H,3BH,44H
		DEFB	3BH,34H,3BH,43H,3BH,42H,58H,50H
		DEFB	3BH,4DH,3BH,52H,3BH,54H,3BH,71H
		DEFB	3BH,64H,3BH,4EH,3BH,59H,3BH,58H
		DEFB	3BH,57H,3BH,61H,3BH,48H,3BH,66H
		DEFB	3BH,60H,3BH,6EH,3BH,45H,3BH,55H
		DEFB	3BH,5FH,3BH,65H,3BH,5CH,3BH,4BH
		DEFB	3BH,56H,3BH,4AH,3CH,28H,3BH,6BH
		DEFB	3BH,4FH,3BH,51H,3BH,75H,3BH,6FH
		DEFB	3BH,49H,3BH,6DH,3BH,5EH,3BH,6AH
		DEFB	3BH,74H,3BH,69H,3BH,50H,3BH,5DH
		DEFB	3CH,22H,3BH,63H,3BH,70H,3BH,67H
		DEFB	3BH,6CH,3BH,4CH,3BH,72H,3BH,62H
		DEFB	3BH,47H,3BH,46H,3BH,5BH,3BH,73H
		DEFB	3BH,68H,3BH,53H,3BH,5AH,3FH,5AH
		DEFB	43H,50H,53H,4FH,59H,75H,0A2H,0EFH
		DEFB	0BBH,39H,2CH,0A4H,44H,47H,0AAH,31H
		DEFB	76H,44H,2CH,3CH,2EH,0AAH,0EAH,5BH
		DEFB	59H,0ABH,3CH,2FH,0ABH,0B7H,0C6H,3CH
		DEFB	29H,0ABH,0D0H,0CDH,3BH,53H,0ABH,0EBH
		DEFB	3CH,38H,0ADH,3CH,30H,3FH,27H,49H
		DEFB	5FH,3FH,25H,3CH,31H,0ADH,0A4H,6FH
		DEFB	67H,0AEH,3CH,32H,0B2H,0EBH,4CH,50H
		DEFB	48H,4BH,0B3H,0A6H,0B7H,0C6H,3CH,29H
		DEFB	0B7H,3CH,35H,0BAH,40H,45H,0BAH,0ABH
		DEFB	40H,45H,0BAH,0AFH,3CH,36H,0BAH,0E0H
		DEFB	44H,40H,0BFH,32H,3CH,40H,65H,0BFH
		DEFB	0A6H,4AH,69H,0BFH,0ACH,0A6H,3DH,3EH
		DEFB	0C1H,3CH,37H,3CH,41H,0C4H,3CH,3CH
		DEFB	3CH,41H,3CH,3AH,3CH,39H,3CH,3EH
		DEFB	3CH,40H,3CH,3FH,3CH,3BH,3CH,38H
		DEFB	3CH,3DH,0C4H,0B1H,6DH,3FH,0C8H,0DFH
		DEFB	3CH,43H,0CAH,49H,4AH,0CEH,3CH,44H
		DEFB	0CEH,0B0H,4EH,3FH,0CEH,0D3H,3CH,45H
		DEFB	0CEH,0D6H,47H,26H,3CH,45H,0D0H,3CH
		DEFB	47H,3CH,46H,0D0H,0B7H,0D0H,3CH,48H
		DEFB	0D0H,0E9H,0AFH,3BH,43H,0D0H,0EBH,47H
		DEFB	7BH,0D6H,3DH,42H,0D9H,3CH,49H,69H
		DEFB	22H,0DCH,0E0H,43H,7CH,0DCH,0EBH,39H
		DEFB	4AH,3AH,71H,0DEH,45H,67H,3CH,4AH
		DEFB	45H,68H,0E1H,0B9H,3CH,28H,0E1H,0EBH
		DEFB	4AH,44H,3CH,3EH,39H,4AH,0E2H,32H
		DEFB	3CH,41H,7AH,0E3H,3CH,52H,3CH,54H
		DEFB	3CH,56H,3CH,4CH,3CH,4BH,3CH,4DH
		DEFB	3CH,55H,3CH,4EH,3CH,51H,3CH,50H
		DEFB	3CH,4FH,3CH,53H,3AH,35H,3CH,57H
		DEFB	3AH,3BH,54H,7AH,55H,30H,5EH,2FH
		DEFB	67H,52H,0E3H,0AFH,3CH,5AH,3CH,61H
		DEFB	3CH,5CH,3CH,5FH,3CH,5EH,3CH,60H
		DEFB	3CH,62H,3CH,5BH,3CH,5DH,53H,70H
		DEFB	55H,22H,61H,7BH,0E3H,0D9H,0EBH,43H
		DEFB	7DH,0E5H,3CH,6AH,3CH,67H,3CH,68H
		DEFB	3CH,6FH,3CH,73H,3CH,69H,3CH,72H
		DEFB	3CH,6EH,3CH,6CH,3CH,71H,3CH,6BH
		DEFB	3CH,6DH,3CH,70H,0E5H,0A6H,3DH,38H
		DEFB	3DH,2CH,3DH,35H,3CH,7DH,3DH,2AH
		DEFB	3DH,28H,3DH,29H,3DH,23H,3DH,24H
		DEFB	3CH,7EH,3DH,30H,3DH,21H,3DH,22H
		DEFB	3CH,39H,3DH,27H,3DH,2EH,3DH,31H
		DEFB	3DH,2DH,3DH,37H,3DH,26H,3CH,7CH
		DEFB	3DH,25H,3DH,32H,3DH,33H,3DH,2BH
		DEFB	3DH,36H,3DH,39H,3DH,2FH,3DH,34H
		DEFB	0E5H,0A6H,0C8H,67H,4FH,0E5H,0A6H,0C8H
		DEFB	0E1H,38H,48H,0E5H,0AFH,3DH,49H,3DH
		DEFB	4CH,3DH,4BH,3DH,4DH,3DH,4AH,3DH
		DEFB	47H,3DH,48H,0E5H,0C4H,3DH,50H,0E5H
		DEFB	0F3H,3DH,55H,3DH,53H,3DH,5CH,3DH
		DEFB	59H,3DH,56H,3DH,58H,3DH,54H,3DH
		DEFB	57H,64H,23H,68H,26H,0E7H,3DH,6AH
		DEFB	3DH,71H,3DH,69H,3DH,74H,3DH,70H
		DEFB	3DH,68H,3DH,6BH,3DH,6FH,3DH,6EH
		DEFB	3DH,6DH,3DH,6CH,3DH,73H,3DH,72H
		DEFB	0E7H,0A6H,40H,38H,3EH,2EH,41H,6AH
		DEFB	3EH,26H,40H,35H,3EH,3EH,3EH,21H
		DEFB	40H,2DH,3EH,5EH,3EH,2FH,3EH,5AH
		DEFB	3EH,3CH,3EH,4AH,3EH,3AH,41H,75H
		DEFB	3EH,43H,3EH,2DH,3EH,46H,3EH,5DH
		DEFB	3EH,50H,3EH,63H,3EH,44H,3DH,7DH
		DEFB	3DH,7EH,3EH,37H,3EH,35H,3EH,4FH
		DEFB	3EH,4BH,3EH,27H,3EH,42H,3EH,52H
		DEFB	41H,71H,3EH,49H,3EH,30H,3EH,3BH
		DEFB	3EH,47H,3EH,48H,3EH,4DH,3EH,51H
		DEFB	3EH,5CH,3EH,57H,3EH,62H,3EH,58H
		DEFB	3EH,32H,3EH,34H,3EH,4EH,3EH,29H
		DEFB	3EH,23H,3EH,24H,3EH,22H,3EH,31H
		DEFB	3EH,3DH,3EH,38H,3EH,59H,3EH,2CH
		DEFB	3EH,45H,3EH,4CH,3EH,2AH,3EH,2BH
		DEFB	3EH,53H,3EH,67H,3EH,39H,3EH,36H
		DEFB	3EH,55H,3EH,5FH,3EH,33H,3EH,40H
		DEFB	3EH,41H,3EH,56H,3EH,61H,3EH,64H
		DEFB	3EH,25H,3EH,28H,3EH,3FH,3EH,54H
		DEFB	3EH,5BH,3EH,60H,58H,21H,58H,5EH
		DEFB	66H,46H,69H,2CH,6BH,56H,6BH,7AH
		DEFB	0E7H,0AFH,3FH,29H,3FH,26H,3FH,27H
		DEFB	3FH,25H,3EH,7EH,3FH,22H,3FH,28H
		DEFB	3FH,23H,3EH,7CH,3EH,7DH,3FH,21H
		DEFB	3FH,2AH,3FH,24H,54H,27H,69H,2CH
		DEFB	0E9H,0D9H,0EBH,44H,34H,0EAH,3FH,2CH
		DEFB	0EBH,43H,4EH,3DH,41H,0EDH,47H,72H
		DEFB	3EH,6BH,0EFH,62H,32H,0F3H,3FH,37H
		DEFB	3FH,40H,3FH,2EH,3FH,34H,3FH,4AH
		DEFB	3FH,3FH,3FH,48H,3FH,39H,3FH,3DH
		DEFB	3FH,33H,3FH,46H,3FH,3CH,3FH,36H
		DEFB	3FH,2DH,3FH,4BH,3FH,4CH,3FH,43H
		DEFB	3FH,42H,43H,24H,3FH,2FH,3FH,47H
		DEFB	3FH,32H,3FH,35H,3FH,3BH,3FH,30H
		DEFB	3FH,31H,3FH,38H,3FH,41H,3FH,3AH
		DEFB	3FH,49H,3FH,3EH,3FH,44H,3FH,45H
		DEFB	3BH,7EH,3BH,76H,43H,4FH,3CH,2BH
		DEFB	3BH,7DH,3CH,23H,3CH,21H,4FH,29H
		DEFB	3BH,7BH,3BH,79H,3BH,7AH,3CH,28H
		DEFB	3CH,2DH,3BH,77H,3CH,2AH,3CH,22H
		DEFB	3BH,78H,3BH,7CH,3CH,24H,3CH,27H
		DEFB	3CH,29H,3CH,26H,46H,76H,3CH,25H
		DEFB	3CH,2CH,0A4H,4CH,6CH,0AFH,3CH,34H
		DEFB	3CH,33H,0C4H,3CH,42H,0E3H,3CH,58H
		DEFB	3CH,59H,0E3H,0AFH,3CH,63H,3CH,65H
		DEFB	3FH,7DH,3CH,64H,3CH,66H,0E3H,0F3H
		DEFB	3FH,7DH,0E5H,3CH,75H,3CH,78H,3CH
		DEFB	77H,3CH,79H,3CH,7BH,44H,5CH,3CH
		DEFB	7AH,3CH,74H,3CH,76H,0E5H,0A6H,3DH
		DEFB	3DH,3DH,3BH,3DH,45H,3DH,42H,3DH
		DEFB	3EH,3DH,3CH,3DH,46H,3DH,40H,3DH
		DEFB	44H,3DH,43H,3DH,41H,3DH,26H,3DH
		DEFB	3FH,3DH,3AH,57H,4FH,0E5H,0AFH,3DH
		DEFB	4FH,3DH,4EH,0E5H,0C4H,3DH,51H,3DH
		DEFB	52H,0E5H,0F3H,3DH,60H,3DH,63H,3DH
		DEFB	67H,3DH,5CH,3DH,64H,3DH,5FH,3DH
		DEFB	61H,3DH,5AH,3DH,5BH,3DH,62H,3DH
		DEFB	5EH,46H,57H,3DH,5DH,3DH,66H,3DH
		DEFB	65H,0E7H,3DH,77H,3DH,75H,3DH,7CH
		DEFB	3DH,78H,3DH,76H,47H,21H,3DH,79H
		DEFB	3DH,7AH,3DH,7BH,50H,30H,59H,33H
		DEFB	0E7H,0A6H,3EH,65H,3EH,6CH,3EH,70H
		DEFB	3EH,72H,3EH,6FH,3EH,68H,3EH,6BH
		DEFB	3EH,75H,3EH,79H,3EH,7BH,3EH,76H
		DEFB	3EH,66H,3EH,74H,3EH,7AH,3EH,6EH
		DEFB	3EH,78H,3EH,6AH,3EH,67H,3EH,69H
		DEFB	3EH,6DH,3EH,71H,3EH,73H,3EH,77H
		DEFB	61H,48H,65H,36H,0E7H,0AFH,3FH,2BH
		DEFB	6AH,73H,0F3H,3FH,4DH,3FH,40H,3FH
		DEFB	58H,3FH,4EH,31H,41H,3FH,4FH,3FH
		DEFB	52H,3FH,54H,3FH,53H,3FH,50H,3FH
		DEFB	55H,3FH,57H,3FH,51H,3FH,56H,3FH
		DEFB	59H,3FH,43H,41H,47H,3FH,5CH,3CH
		DEFB	77H,41H,63H,3FH,5DH,3FH,5BH,4EH
		DEFB	7CH,3FH,5AH,3BH,5BH,0A4H,3FH,65H
		DEFB	3FH,64H,3BH,40H,3FH,61H,3FH,6BH
		DEFB	3FH,6CH,3FH,66H,3FH,68H,3FH,6AH
		DEFB	3FH,67H,3FH,69H,3FH,62H,3FH,63H
		DEFB	3FH,6DH,3FH,6EH,57H,42H,0A6H,3FH
		DEFB	74H,35H,5BH,3FH,72H,3FH,75H,3FH
		DEFB	77H,3FH,76H,3FH,73H,0A8H,4BH,76H
		DEFB	3FH,78H,0A8H,0EBH,3FH,78H,0ACH,3FH
		DEFB	7BH,0ACH,0BFH,3BH,51H,0ADH,37H,64H
		DEFB	3DH,7BH,0AEH,3FH,79H,3FH,7AH,0AFH
		DEFB	39H,77H,0AFH,0A6H,35H,5FH,35H,45H
		DEFB	0AFH,0CAH,0A4H,3EH,2FH,0B1H,32H,70H
		DEFB	4AH,65H,4EH,3CH,49H,2BH,0B2H,3FH
		DEFB	7BH,0B3H,0D6H,0EBH,3FH,7CH,0B4H,0A4H
		DEFB	40H,28H,0B7H,72H,3FH,0B8H,36H,5AH
		DEFB	0B9H,47H,61H,0B9H,0ADH,47H,76H,0B9H
		DEFB	0E0H,3FH,4AH,0B9H,0E1H,0EBH,41H,26H
		DEFB	0BAH,4EH,6BH,3CH,62H,0BAH,0B7H,0A4H
		DEFB	4EH,43H,0BAH,0E1H,3FH,7DH,0BAH,0EAH
		DEFB	38H,27H,0BDH,3FH,7EH,0C0H,0ECH,4EH
		DEFB	7CH,0C6H,0EBH,3CH,4EH,0C7H,34H,7BH
		DEFB	0CAH,3AH,3DH,0CAH,0EFH,0C1H,42H,28H
		DEFB	0CDH,66H,7AH,0D9H,0C6H,41H,34H,0D9H
		DEFB	0EBH,33H,6AH,0DFH,33H,51H,43H,3AH
		DEFB	4BH,4FH,40H,21H,36H,79H,3DH,63H
		DEFB	0E0H,3DH,3BH,3AH,51H,40H,21H,40H
		DEFB	34H,40H,33H,0E2H,0E2H,4DH,7BH,0EAH
		DEFB	40H,22H,0EBH,0C9H,0A4H,31H,54H,0F3H
		DEFB	40H,23H,46H,2CH,3FH,5EH,3FH,60H
		DEFB	3FH,5FH,0A4H,3FH,6FH,3FH,70H,3FH
		DEFB	71H,40H,24H,3BH,5CH,40H,25H,47H
		DEFB	58H,40H,26H,40H,54H,0A4H,40H,38H
		DEFB	40H,2FH,40H,3EH,40H,2EH,40H,35H
		DEFB	40H,29H,40H,3DH,40H,2DH,3EH,4AH
		DEFB	40H,36H,40H,44H,40H,3AH,40H,2AH
		DEFB	40H,3CH,40H,32H,40H,30H,40H,45H
		DEFB	40H,31H,40H,39H,40H,41H,40H,3FH
		DEFB	40H,3BH,40H,46H,40H,2CH,40H,37H
		DEFB	40H,42H,40H,40H,40H,2BH,40H,34H
		DEFB	40H,28H,40H,33H,40H,43H,3AH,54H
		DEFB	0ACH,0ECH,50H,67H,0ADH,34H,58H,40H
		DEFB	50H,40H,4AH,40H,56H,40H,51H,40H
		DEFB	53H,40H,55H,40H,57H,40H,4EH,40H
		DEFB	52H,40H,49H,40H,4FH,40H,4BH,40H
		DEFB	4CH,40H,59H,3CH,64H,40H,58H,40H
		DEFB	4DH,31H,61H,33H,31H,40H,54H,0C4H
		DEFB	40H,5FH,40H,5CH,40H,5AH,40H,62H
		DEFB	40H,61H,40H,63H,40H,5EH,40H,5DH
		DEFB	40H,5BH,40H,60H,5DH,75H,0DEH,0A4H
		DEFB	36H,39H,0DFH,40H,66H,0E1H,0EBH,40H
		DEFB	55H,0EAH,36H,5CH,0F3H,40H,69H,40H
		DEFB	6EH,40H,6FH,41H,2AH,40H,7EH,40H
		DEFB	68H,41H,25H,40H,6CH,40H,75H,40H
		DEFB	74H,40H,76H,41H,21H,40H,6AH,41H
		DEFB	2FH,40H,67H,41H,2CH,40H,6BH,40H
		DEFB	77H,41H,26H,40H,78H,40H,70H,40H
		DEFB	7BH,41H,29H,41H,23H,41H,2DH,36H
		DEFB	7CH,40H,72H,40H,79H,41H,2BH,41H
		DEFB	2EH,46H,51H,40H,6DH,40H,7CH,40H
		DEFB	7DH,41H,22H,4FH,4BH,40H,71H,40H
		DEFB	73H,40H,7AH,41H,24H,41H,27H,41H
		DEFB	28H,6CH,4DH,6FH,59H,0F3H,0C1H,41H
		DEFB	38H,40H,27H,0A4H,40H,47H,40H,48H
		DEFB	6CH,54H,0C4H,40H,64H,40H,65H,0CBH
		DEFB	41H,2CH,0EDH,4EH,6DH,0F3H,41H,30H
		DEFB	41H,34H,41H,33H,41H,31H,41H,35H
		DEFB	41H,32H,41H,37H,41H,36H,0F3H,0DEH
		DEFB	0A4H,69H,2FH,41H,48H,41H,47H,41H
		DEFB	4AH,41H,43H,41H,3CH,41H,44H,41H
		DEFB	3DH,41H,4BH,41H,46H,41H,49H,41H
		DEFB	40H,41H,45H,41H,42H,41H,3FH,41H
		DEFB	4DH,41H,39H,41H,3AH,41H,3BH,41H
		DEFB	3EH,41H,41H,41H,4CH,36H,3EH,0A6H
		DEFB	41H,6AH,41H,77H,41H,6DH,41H,61H
		DEFB	41H,52H,41H,68H,41H,75H,41H,5BH
		DEFB	41H,70H,41H,55H,41H,76H,41H,5CH
		DEFB	41H,60H,41H,4FH,3DH,21H,41H,6BH
		DEFB	41H,63H,41H,71H,41H,58H,41H,72H
		DEFB	41H,5DH,41H,50H,41H,7BH,41H,62H
		DEFB	37H,2CH,31H,68H,45H,3AH,41H,78H
		DEFB	41H,3DH,41H,54H,41H,53H,41H,4EH
		DEFB	41H,5EH,41H,65H,41H,67H,41H,6EH
		DEFB	41H,7AH,41H,51H,41H,73H,41H,56H
		DEFB	41H,5AH,41H,6FH,41H,57H,41H,64H
		DEFB	41H,66H,41H,79H,41H,69H,41H,74H
		DEFB	41H,3EH,41H,59H,41H,5FH,41H,6CH
		DEFB	58H,6AH,66H,62H,0A6H,0EDH,0A6H,38H
		DEFB	75H,0AFH,42H,26H,42H,2DH,42H,28H
		DEFB	42H,2CH,42H,2EH,42H,27H,42H,29H
		DEFB	42H,2BH,42H,25H,42H,2AH,3AH,49H
		DEFB	0B3H,44H,6CH,0B7H,0EBH,48H,70H,0C4H
		DEFB	42H,34H,4EH,28H,3FH,63H,0C7H,42H
		DEFB	35H,0C8H,33H,30H,0CAH,0A8H,36H,21H
		DEFB	0CAH,0A8H,0EBH,48H,77H,0CEH,31H,60H
		DEFB	42H,36H,31H,72H,0D0H,4BH,35H,36H
		DEFB	3EH,0E0H,0AFH,48H,40H,0E1H,0EBH,40H
		DEFB	77H,0E9H,36H,75H,0EBH,44H,66H,0ECH
		DEFB	42H,36H,0EDH,0A4H,42H,37H,0F3H,42H
		DEFB	3CH,42H,38H,42H,3BH,42H,39H,42H
		DEFB	3AH,42H,3DH,0A6H,42H,24H,42H,22H
		DEFB	41H,7DH,41H,70H,3EH,5DH,41H,7CH
		DEFB	42H,23H,42H,21H,41H,7EH,0AFH,42H
		DEFB	33H,42H,32H,42H,30H,42H,2FH,42H
		DEFB	31H,0F3H,42H,38H,45H,44H,42H,3EH
		DEFB	42H,3FH,42H,40H,42H,4CH,42H,41H
		DEFB	42H,42H,42H,4BH,0A4H,42H,67H,42H
		DEFB	65H,42H,50H,42H,4EH,42H,66H,42H
		DEFB	54H,42H,40H,42H,5EH,42H,5FH,42H
		DEFB	62H,42H,56H,42H,60H,42H,53H,42H
		DEFB	58H,42H,61H,42H,59H,42H,5AH,42H
		DEFB	51H,42H,55H,42H,5BH,42H,57H,42H
		DEFB	5DH,42H,64H,42H,4FH,42H,52H,42H
		DEFB	5CH,42H,63H,5AH,2CH,5AH,2DH,6AH
		DEFB	74H,0A4H,0E9H,4AH,3FH,0A8H,4CH,2FH
		DEFB	0A8H,0EBH,42H,51H,0AAH,0B9H,45H,5DH
		DEFB	0AAH,0ECH,0EBH,5AH,4DH,0ABH,42H,6BH
		DEFB	39H,27H,0ABH,0A4H,39H,62H,0ABH,0E9H
		DEFB	4AH,75H,0ACH,0A4H,38H,5FH,0ADH,42H
		DEFB	6CH,42H,6DH,0AFH,42H,70H,42H,77H
		DEFB	42H,74H,42H,6EH,42H,73H,42H,72H
		DEFB	3FH,66H,42H,75H,42H,76H,42H,6FH
		DEFB	42H,71H,42H,78H,0AFH,0DEH,0B7H,0A4H
		DEFB	6DH,77H,0AFH,0DFH,39H,2AH,3EH,22H
		DEFB	0AFH,0EFH,0A8H,0EBH,43H,5FH,0B1H,49H
		DEFB	70H,43H,5DH,33H,59H,3EH,66H,42H
		DEFB	7BH,0B1H,0B7H,4CH,54H,0B1H,0CEH,0B3H
		DEFB	64H,23H,0B3H,42H,7CH,42H,7DH,0B4H
		DEFB	45H,66H,0B7H,0ABH,33H,4EH,0B7H,0CAH
		DEFB	0E0H,53H,4FH,0B9H,42H,2DH,0B9H,0ADH
		DEFB	6BH,27H,0B9H,0B1H,0EBH,3DH,75H,0BAH
		DEFB	0B5H,0A8H,0EBH,37H,48H,0BAH,0CDH,0EBH
		DEFB	4BH,2CH,3FH,52H,0BFH,0A8H,0EBH,43H
		DEFB	39H,0BFH,0ABH,0A4H,40H,6FH,0BFH,0ABH
		DEFB	0A6H,46H,2EH,0BFH,0ADH,43H,21H,0BFH
		DEFB	0AFH,43H,21H,0BFH,0DFH,3EH,76H,0BFH
		DEFB	0EAH,63H,2EH,0C0H,4DH,23H,42H,7EH
		DEFB	0C0H,0B7H,43H,69H,43H,22H,0C0H,0B7H
		DEFB	0A4H,40H,35H,0C0H,0B9H,64H,7DH,0C0H
		DEFB	0E8H,0A6H,49H,3AH,0C1H,43H,23H,0C1H
		DEFB	0D0H,0CAH,35H,4CH,0C1H,0DEH,0C1H,39H
		DEFB	7AH,0C4H,43H,47H,3AH,5BH,43H,23H
		DEFB	40H,64H,4EH,35H,43H,24H,4EH,36H
		DEFB	70H,67H,0C4H,0DFH,43H,27H,0C6H,3DH
		DEFB	44H,3DH,62H,43H,28H,3DH,5DH,0C9H
		DEFB	0EAH,43H,29H,0C9H,0EBH,43H,29H,0CAH
		DEFB	43H,2AH,0CBH,43H,2BH,0CCH,0ADH,43H
		DEFB	2CH,0CDH,3CH,6FH,30H,7DH,0CEH,0B7H
		DEFB	0A4H,33H,5AH,0CEH,0E0H,4DH,6AH,0D0H
		DEFB	42H,2BH,0D3H,45H,59H,4EH,39H,0D9H
		DEFB	0EBH,3FH,29H,0DEH,35H,65H,36H,4CH
		DEFB	3CH,6EH,0DEH,0B4H,4DH,71H,0DEH,0B7H
		DEFB	0A4H,3AH,32H,0DEH,0EFH,0EBH,3BH,72H
		DEFB	0DFH,4CH,31H,0E0H,0EDH,46H,56H,0E1H
		DEFB	30H,59H,0E1H,0E9H,0A6H,6DH,30H,6DH
		DEFB	34H,0E1H,0EBH,43H,79H,4EH,2FH,0E2H
		DEFB	0C4H,4AH,5DH,0E9H,43H,2DH,0EBH,43H
		DEFB	2EH,0ECH,3FH,62H,0EFH,0E9H,49H,36H
		DEFB	0F3H,48H,3FH,43H,31H,43H,34H,43H
		DEFB	3BH,43H,3AH,43H,3CH,43H,30H,43H
		DEFB	35H,43H,38H,43H,43H,43H,42H,43H
		DEFB	22H,43H,32H,43H,40H,43H,33H,43H
		DEFB	36H,43H,41H,43H,3EH,43H,39H,43H
		DEFB	37H,43H,3DH,43H,3FH,58H,6BH,5DH
		DEFB	5FH,61H,62H,6AH,7CH,34H,2EH,42H
		DEFB	47H,42H,45H,42H,4CH,42H,44H,42H
		DEFB	46H,42H,4DH,42H,43H,42H,48H,42H
		DEFB	49H,42H,4AH,42H,4BH,54H,58H,0A4H
		DEFB	42H,67H,42H,65H,42H,68H,42H,6AH
		DEFB	42H,66H,42H,69H,0AFH,4AH,7AH,42H
		DEFB	7AH,42H,79H,0C4H,43H,26H,43H,25H
		DEFB	0DEH,0EBH,4CH,5BH,0ECH,43H,2FH,0F3H
		DEFB	43H,4BH,43H,4CH,43H,44H,43H,4AH
		DEFB	43H,47H,43H,46H,43H,48H,43H,45H
		DEFB	43H,36H,43H,49H,43H,4FH,40H,69H
		DEFB	43H,53H,43H,4EH,43H,4DH,43H,56H
		DEFB	37H,6CH,43H,57H,43H,59H,43H,52H
		DEFB	43H,55H,43H,54H,43H,51H,43H,58H
		DEFB	43H,5AH,43H,50H,65H,4CH,0A4H,0B5H
		DEFB	0A4H,3EH,2EH,0ABH,0A4H,36H,61H,0ABH
		DEFB	0A6H,40H,40H,0ABH,0E9H,4EH,4FH,0AFH
		DEFB	43H,5BH,43H,5DH,43H,5FH,43H,5CH
		DEFB	43H,5EH,43H,60H,0C1H,49H,63H,46H
		DEFB	7DH,43H,61H,0C2H,0E0H,3DH,4CH,0C4H
		DEFB	43H,62H,0DEH,0BFH,39H,2BH,0E3H,43H
		DEFB	63H,0E3H,0AFH,43H,65H,43H,64H,0E5H
		DEFB	0A6H,43H,66H,43H,6DH,43H,67H,43H
		DEFB	6BH,43H,69H,43H,73H,43H,68H,43H
		DEFB	6EH,43H,72H,43H,6AH,43H,6CH,3FH
		DEFB	5FH,43H,6FH,43H,70H,43H,71H,6BH
		DEFB	4FH,0E7H,43H,78H,43H,79H,43H,76H
		DEFB	43H,74H,43H,75H,43H,77H,0E7H,0A6H
		DEFB	44H,39H,44H,2EH,44H,34H,44H,2BH
		DEFB	44H,25H,44H,23H,43H,7AH,44H,3BH
		DEFB	44H,36H,44H,27H,44H,22H,44H,30H
		DEFB	44H,2CH,44H,26H,44H,29H,44H,32H
		DEFB	43H,7BH,44H,3AH,44H,33H,44H,2FH
		DEFB	44H,21H,44H,28H,44H,38H,44H,35H
		DEFB	44H,37H,43H,7EH,44H,24H,43H,7CH
		DEFB	43H,7DH,44H,2AH,44H,2DH,44H,31H
		DEFB	0E7H,0AFH,44H,3EH,44H,3CH,44H,3DH
		DEFB	0EAH,3FH,50H,0EBH,3BH,36H,0F3H,44H
		DEFB	42H,44H,40H,44H,41H,44H,44H,44H
		DEFB	43H,44H,3FH,44H,45H,0A4H,42H,50H
		DEFB	44H,49H,44H,47H,44H,46H,3FH,6BH
		DEFB	44H,48H,44H,4AH,42H,4FH,0A6H,44H
		DEFB	4CH,44H,4BH,0A8H,3EH,73H,0ABH,44H
		DEFB	4DH,42H,2BH,0ABH,0B5H,3BH,4AH,0ABH
		DEFB	0DFH,44H,4FH,0ABH,0E0H,44H,4FH,0ABH
		DEFB	0ECH,0EBH,48H,68H,0ACH,44H,4EH,0ADH
		DEFB	37H,6EH,44H,50H,0AEH,3CH,21H,0AFH
		DEFB	49H,55H,43H,65H,46H,4DH,3DH,22H
		DEFB	46H,35H,0AFH,0A8H,34H,79H,0AFH,0C0H
		DEFB	44H,51H,0AFH,0EBH,42H,24H,41H,4FH
		DEFB	0B0H,43H,6DH,3BH,4CH,0B0H,0CAH,0A6H
		DEFB	3DH,7EH,0B1H,44H,52H,0B1H,0EBH,44H
		DEFB	52H,0B2H,44H,53H,0B8H,44H,54H,0BFH
		DEFB	44H,55H,0BFH,0A8H,0EBH,45H,41H,0BFH
		DEFB	0CAH,0A4H,40H,5BH,0C1H,45H,5AH,44H
		DEFB	48H,44H,4AH,0C1H,0ABH,0A6H,47H,5DH
		DEFB	0C4H,45H,7BH,0C4H,0B7H,0E0H,3FH,35H
		DEFB	36H,60H,0C4H,0DFH,44H,69H,0C4H,0E0H
		DEFB	4AH,71H,0C5H,0DFH,38H,5DH,0C5H,0EAH
		DEFB	44H,56H,0C5H,0EBH,44H,56H,0C8H,0CBH
		DEFB	3DH,48H,0CAH,39H,4BH,0CDH,3EH,6FH
		DEFB	39H,31H,0CEH,33H,51H,0CEH,0EBH,4AH
		DEFB	67H,0D0H,42H,43H,44H,57H,0D0H,0ADH
		DEFB	44H,58H,0D0H,0B5H,4DH,63H,0D0H,0E1H
		DEFB	31H,6DH,0D6H,4EH,33H,0D6H,0ECH,44H
		DEFB	59H,0D6H,0ECH,0EBH,44H,59H,0DCH,44H
		DEFB	5AH,44H,5BH,54H,64H,0DEH,3AH,4AH
		DEFB	44H,5CH,0DFH,3AH,61H,0E0H,40H,51H
		DEFB	45H,26H,0E0H,0AEH,44H,5DH,0E0H,0B0H
		DEFB	4BH,42H,0E1H,35H,4DH,44H,5EH,0E1H
		DEFB	0BFH,0A4H,4EH,64H,0E1H,0EBH,35H,4DH
		DEFB	0E4H,31H,70H,0E6H,4FH,2AH,0E9H,0A4H
		DEFB	3FH,49H,0EAH,44H,60H,44H,5FH,0EBH
		DEFB	44H,61H,44H,60H,44H,5FH,4CH,22H
		DEFB	46H,58H,0EBH,0AEH,37H,75H,3CH,6AH
		DEFB	0A4H,44H,6AH,44H,6DH,44H,64H,44H
		DEFB	63H,44H,73H,44H,6BH,44H,78H,43H
		DEFB	7AH,45H,21H,44H,79H,44H,6CH,44H
		DEFB	68H,44H,6FH,44H,62H,44H,67H,44H
		DEFB	71H,44H,7BH,44H,6EH,44H,7AH,44H
		DEFB	65H,44H,69H,44H,7EH,44H,74H,44H
		DEFB	77H,44H,70H,44H,66H,44H,75H,44H
		DEFB	76H,45H,22H,45H,23H,44H,72H,44H
		DEFB	7CH,44H,7DH,45H,24H,6EH,44H,0ADH
		DEFB	45H,2AH,45H,2CH,45H,28H,45H,26H
		DEFB	45H,2BH,45H,29H,45H,27H,45H,2DH
		DEFB	0C4H,45H,34H,45H,30H,45H,2FH,45H
		DEFB	31H,45H,33H,45H,32H,6FH,44H,0E9H
		DEFB	3BH,7BH,0EBH,3EH,48H,0F3H,45H,39H
		DEFB	45H,37H,45H,40H,45H,3EH,45H,38H
		DEFB	45H,35H,45H,3AH,45H,3DH,45H,3CH
		DEFB	45H,36H,45H,3BH,45H,3FH,53H,73H
		DEFB	3DH,50H,0A4H,45H,25H,0ADH,45H,2EH
		DEFB	0EBH,3DH,50H,0F3H,45H,44H,45H,45H
		DEFB	45H,41H,45H,42H,45H,43H,67H,3DH
		DEFB	45H,54H,38H,4DH,45H,50H,45H,4FH
		DEFB	3FH,5EH,45H,4CH,45H,53H,45H,49H
		DEFB	45H,4DH,45H,52H,45H,47H,45H,4EH
		DEFB	45H,56H,45H,4AH,45H,4BH,45H,48H
		DEFB	45H,55H,45H,46H,45H,51H,45H,57H
		DEFB	0A4H,48H,75H,0A6H,45H,6CH,4CH,64H
		DEFB	45H,76H,45H,67H,46H,23H,45H,5EH
		DEFB	45H,6AH,46H,2CH,45H,7DH,45H,79H
		DEFB	45H,7AH,46H,24H,45H,50H,45H,7CH
		DEFB	46H,2EH,45H,70H,45H,72H,46H,26H
		DEFB	45H,5DH,46H,28H,45H,5FH,46H,2BH
		DEFB	46H,27H,45H,74H,45H,7EH,45H,60H
		DEFB	45H,63H,45H,4DH,46H,2DH,45H,6DH
		DEFB	46H,29H,45H,62H,45H,61H,45H,7BH
		DEFB	46H,25H,45H,6FH,3FH,60H,45H,73H
		DEFB	45H,69H,45H,65H,45H,75H,46H,22H
		DEFB	45H,64H,37H,23H,45H,68H,45H,6BH
		DEFB	45H,6EH,45H,71H,45H,77H,45H,78H
		DEFB	46H,21H,46H,2AH,46H,3AH,5EH,39H
		DEFB	61H,56H,0A6H,0B2H,46H,3DH,0A6H,0C8H
		DEFB	0A4H,42H,3AH,35H,2EH,0AAH,3DH,3DH
		DEFB	0AAH,0A4H,31H,73H,0AAH,0EAH,44H,4CH
		DEFB	0AAH,0EBH,45H,30H,46H,29H,35H,7CH
		DEFB	0ACH,44H,4EH,0ACH,0E1H,0EBH,52H,6BH
		DEFB	0ACH,0EBH,40H,6DH,0ADH,3BH,7EH,46H
		DEFB	3EH,72H,2AH,0AEH,32H,40H,0AFH,46H
		DEFB	43H,40H,62H,46H,40H,46H,44H,46H
		DEFB	41H,46H,46H,46H,3FH,46H,45H,46H
		DEFB	42H,0B1H,0EBH,4DH,4FH,4DH,50H,0B2H
		DEFB	3BH,49H,5BH,33H,5BH,79H,0B3H,3EH
		DEFB	32H,0B3H,0EDH,3DH,6AH,3DH,68H,0B7H
		DEFB	47H,2FH,4EH,70H,49H,52H,3AH,50H
		DEFB	3DH,53H,4DH,78H,0C1H,46H,4AH,46H
		DEFB	4BH,0C4H,46H,4DH,46H,4CH,0C9H,46H
		DEFB	4EH,0C9H,0AFH,46H,4FH,0C9H,0B1H,46H
		DEFB	4FH,0C9H,0EDH,0ADH,39H,6CH,0CAH,0A8H
		DEFB	0EBH,3EH,27H,0CAH,0EAH,4EH,59H,0CEH
		DEFB	45H,42H,0D3H,46H,50H,0D3H,0E9H,48H
		DEFB	62H,0D6H,48H,74H,44H,37H,0DCH,0B7H
		DEFB	0A4H,4BH,33H,0DEH,46H,51H,0DFH,49H
		DEFB	59H,49H,5AH,0E1H,0EBH,4EH,31H,0E2H
		DEFB	4DH,27H,36H,21H,48H,3CH,43H,52H
		DEFB	4AH,7EH,70H,5DH,36H,26H,0E2H,0A8H
		DEFB	47H,43H,0E8H,4BH,2DH,0E9H,38H,57H
		DEFB	46H,52H,0E9H,0A8H,0EBH,4AH,61H,0EAH
		DEFB	44H,3BH,46H,53H,0EAH,0B3H,5AH,22H
		DEFB	0EAH,0C7H,3AH,56H,0EBH,3CH,68H,0EDH
		DEFB	46H,54H,0F3H,46H,5AH,46H,5CH,46H
		DEFB	57H,46H,59H,46H,5BH,46H,55H,46H
		DEFB	56H,46H,58H,0F3H,0D3H,46H,50H,45H
		DEFB	59H,45H,5AH,45H,58H,45H,5CH,45H
		DEFB	5BH,0A6H,46H,31H,46H,30H,46H,3BH
		DEFB	46H,32H,46H,2FH,46H,33H,46H,38H
		DEFB	46H,3CH,46H,36H,46H,39H,46H,37H
		DEFB	46H,34H,46H,35H,46H,3AH,58H,56H
		DEFB	60H,58H,0AFH,46H,49H,46H,48H,46H
		DEFB	47H,0CEH,45H,42H,0E2H,0EBH,35H,49H
		DEFB	0EBH,4AH,26H,0EDH,45H,25H,0F3H,46H
		DEFB	5EH,46H,5FH,46H,5DH,6CH,45H,0F3H
		DEFB	0D6H,0EAH,50H,27H,4CH,3EH,46H,60H
		DEFB	3AH,5AH,46H,61H,32H,58H,0A4H,46H
		DEFB	62H,4CH,35H,0A8H,49H,44H,0AAH,3EH
		DEFB	30H,4DH,31H,44H,3EH,0ABH,43H,66H
		DEFB	43H,67H,0ABH,0ECH,4CH,5EH,0ACH,31H
		DEFB	4AH,0ACH,0A4H,44H,39H,0ACH,0E1H,0EBH
		DEFB	44H,2FH,0ACH,0E9H,46H,63H,0ACH,0ECH
		DEFB	0EBH,4EH,2EH,0AEH,46H,65H,46H,64H
		DEFB	0AEH,0B5H,3DH,6DH,44H,75H,0AFH,4CH
		DEFB	44H,35H,63H,53H,2DH,0B0H,46H,65H
		DEFB	0B0H,0EBH,32H,25H,0B2H,0AFH,43H,32H
		DEFB	43H,37H,0B2H,0EBH,45H,6AH,0B5H,0B1H
		DEFB	3EH,70H,0B7H,4DH,7CH,0B9H,32H,58H
		DEFB	0BEH,46H,66H,0C0H,46H,67H,0C4H,32H
		DEFB	46H,46H,68H,0C4H,0ABH,0B7H,0A4H,32H
		DEFB	7BH,0C7H,0EBH,49H,6FH,0C9H,45H,79H
		DEFB	0CAH,3CH,37H,0CAH,0E1H,3CH,50H,0CBH
		DEFB	32H,3FH,0D9H,46H,69H,0DEH,40H,38H
		DEFB	0DEH,0EAH,31H,74H,6BH,42H,0DFH,47H
		DEFB	48H,4AH,42H,4FH,32H,0DFH,0C0H,4EH
		DEFB	5EH,5EH,25H,0E1H,0EBH,67H,53H,0E4H
		DEFB	0E0H,47H,3AH,0E9H,46H,6AH,0E9H,0A6H
		DEFB	3DH,2CH,4AH,6FH,0E9H,0D6H,4AH,42H
		DEFB	0EAH,4CH,69H,0EBH,40H,2EH,0ECH,46H
		DEFB	6BH,0ECH,0EBH,34H,37H,46H,6BH,0EFH
		DEFB	46H,6CH,0EFH,0C6H,46H,6DH,0F3H,46H
		DEFB	6EH,46H,71H,46H,70H,46H,6FH,30H
		DEFB	49H,0F3H,0B8H,46H,72H,46H,73H,43H
		DEFB	30H,32H,59H,3CH,24H,46H,74H,46H
		DEFB	75H,46H,76H,50H,31H,0A8H,6CH,53H
		DEFB	0AAH,0A4H,46H,77H,0AAH,0A6H,3DH,2DH
		DEFB	46H,77H,0ACH,0A4H,36H,6CH,0AEH,0E4H
		DEFB	0ABH,46H,78H,0AEH,0EBH,30H,2EH,0AEH
		DEFB	0EFH,0A4H,46H,78H,0AFH,46H,79H,0AFH
		DEFB	0A4H,41H,7EH,0B2H,0EBH,46H,28H,0B4H
		DEFB	0EBH,42H,79H,0B7H,40H,3EH,0B7H,0ADH
		DEFB	36H,53H,0B8H,46H,7AH,0B8H,0E5H,0A6H
		DEFB	46H,7BH,0BBH,34H,66H,35H,36H,0C1H
		DEFB	46H,7CH,0CAH,0A6H,43H,34H,0D6H,0A4H
		DEFB	46H,5FH,0E5H,0A6H,46H,7EH,46H,7DH
		DEFB	0E7H,47H,21H,0E7H,0A6H,47H,22H,0E9H
		DEFB	47H,23H,0EBH,3CH,51H,3BH,77H,0EFH
		DEFB	44H,6DH,0EFH,0ABH,32H,64H,0EFH,0C8H
		DEFB	0EAH,37H,5CH,0F3H,3FH,4DH,47H,24H
		DEFB	47H,27H,47H,26H,47H,25H,0A6H,4BH
		DEFB	25H,0ABH,39H,47H,0AFH,48H,34H,0B0H
		DEFB	43H,26H,0B7H,3CH,67H,0B9H,0E0H,45H
		DEFB	70H,0CEH,49H,5BH,0DEH,3EH,42H,0EBH
		DEFB	45H,49H,0ECH,47H,28H,0ECH,0EBH,47H
		DEFB	28H,43H,4DH,47H,29H,47H,2AH,3AH
		DEFB	2CH,0A4H,47H,2BH,0AEH,47H,2CH,0B3H
		DEFB	47H,2DH,0B8H,0EBH,47H,31H,0BAH,0DFH
		DEFB	41H,4DH,0BFH,0E0H,45H,4AH,0C4H,47H
		DEFB	2EH,0D0H,0EBH,47H,34H,0E0H,0EBH,4CH
		DEFB	32H,0E9H,0A6H,41H,40H,0EBH,3FH,32H
		DEFB	4FH,23H,4EH,7BH,0F3H,47H,2FH,41H
		DEFB	33H,47H,30H,47H,33H,47H,31H,47H
		DEFB	34H,47H,32H,4CH,6EH,47H,37H,47H
		DEFB	35H,47H,36H,47H,38H,0A6H,47H,3DH
		DEFB	47H,40H,47H,3EH,47H,3CH,47H,3AH
		DEFB	47H,3BH,47H,3FH,47H,39H,39H,44H
		DEFB	0ADH,38H,2EH,0B3H,0AEH,0EAH,35H,78H
		DEFB	0BEH,0ADH,47H,41H,0BEH,0AFH,3DH,7CH
		DEFB	47H,41H,0C9H,30H,76H,39H,22H,0CEH
		DEFB	0B7H,0EBH,47H,4DH,0D3H,0EBH,3FH,2DH
		DEFB	0D6H,3FH,2EH,0DCH,0EAH,56H,70H,0DCH
		DEFB	0EBH,3EH,3AH,0DFH,47H,42H,0E0H,30H
		DEFB	7BH,46H,5DH,0EAH,4BH,21H,35H,2CH
		DEFB	35H,2AH,45H,35H,42H,27H,37H,7BH
		DEFB	48H,4FH,38H,52H,36H,6BH,0EBH,3EH
		DEFB	68H,0EDH,0A6H,3CH,76H,0F3H,44H,2AH
		DEFB	4DH,55H,47H,49H,47H,48H,47H,4BH
		DEFB	3BH,75H,3FH,4FH,47H,43H,47H,45H
		DEFB	47H,46H,47H,4AH,47H,44H,47H,47H
		DEFB	48H,76H,0A4H,47H,5BH,47H,54H,47H
		DEFB	58H,47H,53H,47H,51H,47H,55H,47H
		DEFB	50H,47H,52H,47H,5AH,47H,59H,33H
		DEFB	25H,47H,56H,47H,57H,47H,67H,66H
		DEFB	75H,0A6H,47H,67H,0A8H,47H,68H,6AH
		DEFB	24H,0ABH,4AH,68H,0ABH,0DEH,38H,53H
		DEFB	0ABH,0EAH,47H,69H,0ABH,0EBH,42H,2CH
		DEFB	4BH,45H,0ACH,0CDH,39H,5DH,0AEH,47H
		DEFB	6BH,47H,6AH,0AFH,47H,72H,4DH,7AH
		DEFB	47H,6EH,47H,77H,47H,76H,41H,5DH
		DEFB	47H,70H,47H,71H,47H,75H,47H,6FH
		DEFB	47H,6CH,47H,73H,45H,47H,47H,74H
		DEFB	33H,7CH,47H,6DH,60H,61H,64H,36H
		DEFB	0B0H,47H,6DH,0B2H,46H,45H,0B2H,0B7H
		DEFB	0A4H,37H,63H,4EH,75H,0B2H,0E0H,4EH
		DEFB	65H,0B3H,48H,22H,48H,21H,0B5H,0DFH
		DEFB	6EH,77H,0B5H,0E0H,36H,34H,59H,51H
		DEFB	0B6H,0DEH,48H,23H,0B7H,36H,36H,43H
		DEFB	3CH,48H,24H,0B7H,0B4H,44H,74H,0B7H
		DEFB	0D0H,0DFH,3FH,3AH,0B7H,0E9H,43H,6CH
		DEFB	0B7H,0EBH,41H,76H,0B8H,43H,51H,0B8H
		DEFB	0E1H,3BH,4FH,48H,25H,0B9H,4FH,21H
		DEFB	4DH,56H,0BAH,48H,26H,0BBH,0EBH,43H
		DEFB	5AH,0BCH,48H,27H,0BFH,48H,28H,48H
		DEFB	2AH,34H,7AH,48H,2BH,3FH,41H,0BFH
		DEFB	0B1H,48H,2AH,48H,2BH,0BFH,0E9H,0AFH
		DEFB	46H,2FH,0C0H,48H,29H,0C0H,0ABH,4DH
		DEFB	67H,0C1H,48H,2CH,4BH,2AH,48H,2DH
		DEFB	0C4H,48H,2FH,3DH,69H,48H,31H,48H
		DEFB	30H,48H,2EH,0C6H,32H,4CH,0C8H,48H
		DEFB	37H,0CAH,32H,56H,32H,5AH,49H,21H
		DEFB	0CAH,0B7H,4FH,43H,48H,38H,52H,74H
		DEFB	0CAH,0B9H,4AH,7CH,0CAH,0CFH,0C0H,3FH
		DEFB	53H,0CAH,0ECH,0EBH,4EH,25H,0CAH,0EFH
		DEFB	48H,39H,0CBH,3EH,7DH,0CDH,31H,29H
		DEFB	0CFH,4AH,6CH,0D0H,49H,7DH,36H,52H
		DEFB	0D0H,0ABH,0EBH,58H,5FH,0DEH,49H,4DH
		DEFB	5FH,40H,0DEH,0B0H,0EAH,48H,3AH,0E4H
		DEFB	0A4H,41H,61H,42H,2EH,0E4H,0B7H,4EH
		DEFB	53H,53H,72H,0E4H,0D6H,0B5H,48H,3BH
		DEFB	0E9H,38H,36H,4AH,22H,66H,6CH,0E9H
		DEFB	0A6H,4AH,27H,0E9H,0E0H,55H,54H,0EAH
		DEFB	3FH,4BH,4EH,42H,6FH,2AH,0EBH,3DH
		DEFB	55H,44H,25H,45H,3DH,0EBH,0ABH,4DH
		DEFB	5AH,0ECH,40H,32H,0ECH,0EBH,3CH,70H
		DEFB	0F3H,48H,3FH,48H,3EH,3AH,65H,48H
		DEFB	3DH,48H,4EH,3AH,64H,48H,44H,48H
		DEFB	4CH,48H,47H,48H,48H,48H,53H,48H
		DEFB	4BH,48H,3CH,48H,4FH,48H,49H,48H
		DEFB	42H,48H,4AH,48H,4DH,48H,41H,48H
		DEFB	43H,48H,52H,48H,46H,48H,51H,48H
		DEFB	40H,48H,45H,48H,50H,48H,59H,5CH
		DEFB	51H,48H,28H,3EH,6CH,47H,4FH,47H
		DEFB	4CH,47H,4EH,47H,4DH,0A4H,47H,64H
		DEFB	47H,63H,47H,5CH,47H,5FH,47H,5EH
		DEFB	47H,5DH,47H,65H,47H,66H,47H,62H
		DEFB	47H,60H,47H,61H,0AFH,47H,7AH,4BH
		DEFB	3DH,4BH,6BH,47H,7EH,47H,79H,47H
		DEFB	7BH,47H,78H,47H,7CH,47H,7DH,0C4H
		DEFB	48H,34H,48H,33H,48H,36H,48H,32H
		DEFB	48H,35H,0F3H,48H,56H,48H,3DH,48H
		DEFB	44H,48H,57H,48H,3CH,48H,55H,48H
		DEFB	58H,48H,54H,48H,5AH,48H,59H,47H
		DEFB	45H,46H,7CH,48H,71H,32H,50H,48H
		DEFB	74H,48H,66H,4DH,5BH,48H,73H,48H
		DEFB	60H,48H,6BH,48H,63H,48H,6FH,48H
		DEFB	5DH,48H,69H,48H,72H,48H,61H,48H
		DEFB	68H,45H,74H,48H,6EH,49H,30H,48H
		DEFB	64H,48H,75H,48H,65H,48H,5EH,48H
		DEFB	6AH,48H,67H,48H,62H,45H,75H,48H
		DEFB	5BH,48H,5CH,48H,6CH,48H,5FH,48H
		DEFB	6DH,48H,70H,48H,76H,48H,7BH,55H
		DEFB	39H,6CH,5DH,0A4H,0E9H,0AEH,49H,22H
		DEFB	0A8H,49H,23H,0ABH,0A8H,39H,35H,0ABH
		DEFB	0EAH,38H,77H,0ACH,0B7H,45H,6CH,0ACH
		DEFB	0E0H,4AH,48H,0ADH,49H,24H,49H,25H
		DEFB	0AFH,30H,7AH,43H,46H,31H,48H,0AFH
		DEFB	0A4H,44H,63H,0B2H,49H,26H,71H,79H
		DEFB	0B3H,49H,27H,0B5H,35H,57H,0B5H,0B4H
		DEFB	49H,3BH,0B5H,0B7H,48H,5FH,0B6H,49H
		DEFB	28H,0B7H,49H,29H,0B7H,0E3H,0AFH,3CH
		DEFB	5DH,0B8H,49H,2AH,39H,4FH,67H,3EH
		DEFB	0B8H,0EAH,40H,3BH,0BAH,0DFH,4FH,44H
		DEFB	0BFH,0A4H,33H,5BH,0BFH,0B9H,3FH,3BH
		DEFB	0C0H,6AH,7EH,0C0H,0EAH,3AH,38H,0C4H
		DEFB	49H,2CH,49H,2EH,48H,67H,49H,2BH
		DEFB	49H,2DH,49H,2FH,0C4H,0AEH,34H,3DH
		DEFB	5BH,4DH,0C4H,0B8H,4CH,24H,4DH,53H
		DEFB	0C5H,0E1H,44H,7DH,0C7H,3DH,28H,0C8H
		DEFB	3FH,4DH,0C8H,0B7H,3FH,4EH,0C8H,0B7H
		DEFB	0A4H,45H,79H,0C8H,0DFH,46H,37H,0C8H
		DEFB	0EAH,46H,48H,0C9H,0A4H,39H,73H,0CAH
		DEFB	3FH,77H,6EH,41H,0CDH,0EBH,47H,31H
		DEFB	0CEH,0ADH,49H,30H,5BH,58H,0DEH,32H
		DEFB	4BH,0E1H,49H,31H,49H,32H,0E2H,49H
		DEFB	33H,0E3H,0AFH,49H,34H,33H,7CH,0E4H
		DEFB	4EH,64H,0E7H,0A6H,49H,3DH,49H,3EH
		DEFB	49H,38H,49H,3CH,49H,39H,47H,6FH
		DEFB	49H,36H,49H,3AH,49H,37H,49H,3BH
		DEFB	49H,3FH,71H,28H,0E9H,4AH,3FH,4BH
		DEFB	67H,0E9H,0E1H,0AFH,41H,2EH,0EBH,43H
		DEFB	6BH,49H,48H,48H,76H,49H,47H,0EBH
		DEFB	0E0H,36H,31H,0ECH,49H,49H,0EDH,4DH
		DEFB	4EH,39H,28H,39H,2DH,39H,30H,39H
		DEFB	40H,47H,6EH,0EDH,0A4H,57H,22H,0EDH
		DEFB	0A6H,3DH,26H,0EDH,0B7H,34H,32H,0F3H
		DEFB	49H,4AH,49H,4DH,49H,4FH,49H,50H
		DEFB	49H,51H,49H,4BH,49H,4CH,49H,4EH
		DEFB	48H,7EH,48H,77H,48H,78H,48H,79H
		DEFB	49H,21H,48H,7DH,48H,7CH,48H,7AH
		DEFB	48H,7BH,55H,3BH,69H,2FH,0E5H,0A6H
		DEFB	49H,35H,0E7H,0A6H,49H,42H,49H,43H
		DEFB	49H,41H,49H,44H,49H,45H,49H,46H
		DEFB	49H,40H,0F3H,4AH,58H,49H,52H,49H
		DEFB	53H,49H,54H,49H,55H,49H,57H,49H
		DEFB	5CH,49H,59H,49H,58H,49H,5FH,49H
		DEFB	69H,49H,61H,49H,5BH,49H,63H,49H
		DEFB	62H,49H,6AH,49H,5EH,49H,68H,49H
		DEFB	65H,49H,56H,49H,5DH,49H,6CH,49H
		DEFB	66H,49H,64H,49H,6DH,49H,6BH,4AH
		DEFB	63H,49H,60H,49H,67H,49H,5AH,6BH
		DEFB	3EH,0A6H,49H,77H,49H,75H,49H,76H
		DEFB	0A8H,45H,2BH,0ABH,0A4H,3FH,3CH,0ADH
		DEFB	49H,78H,49H,79H,0AFH,4AH,21H,49H
		DEFB	7EH,49H,7CH,49H,7BH,49H,7DH,4AH
		DEFB	23H,3FH,61H,49H,7AH,4AH,22H,4AH
		DEFB	24H,3FH,21H,49H,78H,0AFH,0E0H,34H
		DEFB	5EH,0AFH,0EDH,42H,5EH,0AFH,0EDH,0A6H
		DEFB	5BH,66H,0B1H,0EBH,43H,3FH,0B5H,4BH
		DEFB	3CH,0B7H,40H,61H,0B8H,46H,23H,0B9H
		DEFB	49H,7AH,32H,69H,0B9H,0DEH,32H,28H
		DEFB	0BBH,0B0H,4BH,49H,0BFH,41H,50H,33H
		DEFB	38H,0BFH,0BFH,0D3H,3AH,46H,0C0H,3BH
		DEFB	25H,0C1H,4AH,25H,31H,6FH,5EH,3CH
		DEFB	0C4H,4AH,27H,4AH,28H,4AH,26H,0C7H
		DEFB	49H,2EH,0C8H,0A4H,42H,40H,0C8H,0B3H
		DEFB	0EDH,32H,7BH,0CAH,4AH,2BH,0CDH,41H
		DEFB	25H,3DH,2EH,0DFH,4AH,38H,0E0H,46H
		DEFB	27H,0E2H,0C8H,4FH,3CH,0E6H,45H,5FH
		DEFB	0EBH,3FH,36H,0EBH,0A4H,38H
IB3DE:	DEFB	45H,0EBH
		DEFB	0A8H,0EBH,3FH,4CH,0F3H,4AH,2CH,4AH
		DEFB	34H,4AH,36H,4AH,33H,4AH,2EH,4AH
		DEFB	30H,4AH,37H,4AH,2FH,4AH,32H,4AH
		DEFB	35H,4AH,2DH,4AH,31H,49H,74H,49H
		DEFB	70H,49H,71H,49H,6EH,49H,6FH,49H
		DEFB	72H,49H,73H,0BFH,46H,5AH,0C4H,4AH
		DEFB	2AH,4AH,29H,0F3H,4AH,2CH,4AH,38H
		DEFB	4AH,39H,0F3H,4AH,2DH,55H,7BH,0A4H
		DEFB	4AH,3FH,4AH,3CH,4AH,42H,4AH,41H
		DEFB	4AH,3BH,4AH,44H,4AH,40H,4AH,45H
		DEFB	4AH,3DH,4AH,3EH,4AH,3AH,4AH,43H
		DEFB	0ADH,4AH,49H,4AH,4AH,4AH,4BH,4AH
		DEFB	48H,60H,7AH,6DH,64H,0BDH,67H,41H
		DEFB	0D3H,3CH,58H,0E9H,4AH,4FH,0F3H,4AH
		DEFB	51H,4AH,54H,4AH,55H,4AH,56H,4AH
		DEFB	52H,4AH,53H,4AH,50H,4AH,57H,6EH
		DEFB	34H,4AH,55H,0A4H,4AH,46H,0C4H,4AH
		DEFB	4CH,4AH,4DH,4AH,4EH,0CBH,39H,48H
		DEFB	0F3H,4AH,58H,4AH,5BH,4AH,59H,4AH
		DEFB	5CH,4AH,5AH,48H,50H,0BCH,0B8H,4AH
		DEFB	47H,0A4H,0B8H,4AH,47H,4AH,5DH,4AH
		DEFB	62H,4AH,64H,4AH,61H,4AH,5EH,4AH
		DEFB	66H,4AH,65H,48H,41H,4AH,5FH,4AH
		DEFB	63H,4AH,60H,67H,54H,0A6H,4AH,7DH
		DEFB	4BH,21H,4AH,7CH,4AH,73H,4AH,75H
		DEFB	4BH,2DH,4BH,2CH,4BH,2EH,4AH,71H
		DEFB	49H,75H,4BH,27H,4AH,74H,4BH,25H
		DEFB	4AH,76H,4BH,24H,4BH,32H,4AH,7AH
		DEFB	4BH,23H,4BH,31H,4AH,7EH,4BH,22H
		DEFB	4AH,78H,4BH,2BH,4BH,26H,30H,29H
		DEFB	4BH,2AH,4AH,70H,4BH,29H,4AH,7BH
		DEFB	4BH,28H,4BH,30H,4AH,6FH,4AH,72H
		DEFB	46H,3EH,4AH,77H,4AH,79H,4BH,2FH
		DEFB	57H,47H,0A6H,0ADH,64H,36H,0A8H,4BH
		DEFB	4AH,0A8H,0EBH,4BH,4AH,52H,76H,0AAH
		DEFB	4BH,51H,4BH,4BH,0ABH,42H,3EH,0ACH
		DEFB	0E9H,0ABH,4FH,2FH,0AFH,4BH,4CH,0B3H
		DEFB	4CH,37H,4BH,48H,37H,61H,0B3H,0E9H
		DEFB	63H,2CH,0B3H,0EAH,54H,3CH,0B3H,0EBH
		DEFB	38H,58H,0B3H,0EDH,0D3H,0EBH,43H,3EH
		DEFB	0B7H,40H,31H,0B9H,34H,33H,0BDH,0A4H
		DEFB	3AH,59H,0BFH,0EBH,37H,56H,6AH,25H
		DEFB	0C8H,0B1H,4AH,29H,0C8H,0F3H,0C9H,4BH
		DEFB	58H,0C9H,44H,78H,0CDH,39H,7CH,0CEH
		DEFB	0AAH,31H,6AH,31H,6BH,0CEH,0ABH,50H
		DEFB	3CH,0DEH,0ECH,4DH,40H,0E1H,0EBH,3EH
		DEFB	5EH,4BH,2BH,0E9H,46H,36H,0EAH,4BH
		DEFB	59H,0EBH,44H,26H,37H,21H,0ECH,0EBH
		DEFB	39H,7BH,0EDH,4BH,5AH,0EDH,0D3H,0EBH
		DEFB	4CH,47H,0EDH,0D6H,4BH,34H,0F3H,4BH
		DEFB	5CH,4BH,5DH,4BH,5BH,48H,40H,4AH
		DEFB	67H,4AH,6CH,4CH,4FH,4AH,6BH,4AH
		DEFB	68H,4AH,6DH,4AH,69H,4AH,6EH,32H
		DEFB	34H,4AH,6AH,0A6H,4BH,3EH,4BH,49H
		DEFB	4BH,42H,4BH,3CH,4BH,47H,4BH,3DH
		DEFB	4BH,34H,4BH,3AH,4BH,40H,4BH,37H
		DEFB	4BH,41H,4BH,39H,4BH,3BH,4BH,35H
		DEFB	4BH,38H,4BH,44H,4BH,45H,4BH,46H
		DEFB	4BH,33H,4BH,3FH,4BH,43H,4BH,36H
		DEFB	4BH,48H,5AH,55H,62H,48H,68H,2BH
		DEFB	6BH,6EH,0AFH,4BH,52H,4BH,4FH,4BH
		DEFB	50H,4BH,53H,4BH,4DH,4BH,51H,4BH
		DEFB	4EH,4BH,54H,0BFH,0F3H,4BH,55H,0C4H
		DEFB	4BH,57H,4BH,56H,0F3H,4BH,5EH,4BH
		DEFB	5FH,5BH,70H,34H,56H,3FH,3FH,47H
		DEFB	4FH,4BH,63H,4BH,60H,4BH,62H,4BH
		DEFB	61H,62H,43H,0A4H,4BH,68H,49H,71H
		DEFB	4BH,67H,4BH,65H,4BH,64H,4BH,66H
		DEFB	62H,46H,6EH,32H,0A4H,0EBH,4BH,69H
		DEFB	0A8H,41H,30H,0ADH,34H,2CH,4BH,52H
		DEFB	4BH,6AH,3FH,45H,0AFH,4BH,6BH,47H
		DEFB	45H,4BH,6CH,3BH,35H,3CH,2CH,0AFH
		DEFB	0E9H,4BH,6DH,0B0H,0EDH,4BH,6EH,0B3H
		DEFB	0C8H,3FH,3FH,40H,3FH,0B4H,42H,39H
		DEFB	0B5H,40H,35H,3EH,3BH,4BH,6FH,40H
		DEFB	2FH,0B5H,0EBH,3EH,21H,0B9H,41H,7DH
		DEFB	31H,57H,3EH,23H,4BH,71H,4BH,70H
		DEFB	0BAH,0B7H,0A4H,49H,4FH,0BFH,4BH,74H
		DEFB	4BH,73H,38H,54H,4BH,72H,0BFH,0B0H
		DEFB	38H,59H,0BFH,0BFH,0AFH,3DH,56H,0C0H
		DEFB	0E9H,48H,43H,0C1H,44H,2EH,33H,39H
		DEFB	0C3H,0BFH,0AFH,41H,34H,0C4H,3EH,3EH
		DEFB	42H,54H,4BH,76H,4BH,77H,4BH,75H
		DEFB	0C4H,0B2H,62H,4CH,0C4H,0EAH,3AH,57H
		DEFB	0C7H,4BH,78H,0C8H,45H,2AH,0C8H,0A4H
		DEFB	45H,3BH,0C9H,41H,6BH,0C9H,0A6H,4FH
		DEFB	47H,0CAH,0A4H,0BFH,50H,59H,0CAH,0D6H
		DEFB	55H,5CH,0CDH,0AFH,3EH,37H,0DCH,0EDH
		DEFB	0B7H,38H,38H,0DEH,4BH,79H,50H,56H
		DEFB	0E0H,0B7H,69H,7DH,0E1H,46H,26H,0E2H
		DEFB	0EBH,3CH,69H,0E6H,4BH,7AH,48H,7DH
		DEFB	0E6H,0BAH,0DFH,42H,63H,0E6H,0DFH,43H
		DEFB	49H,0E8H,0A6H,4CH,42H,0EAH,35H,47H
		DEFB	5DH,5CH,0EBH,34H,5DH,0ECH,35H,29H
		DEFB	0EDH,4BH,7BH,0F3H,4BH,7CH,4BH,7EH
		DEFB	4CH,21H,4BH,7DH,4CH,22H,52H,58H
		DEFB	5EH,60H,68H,5FH,71H,3DH,0F3H,0B8H
		DEFB	52H,44H,3CH,42H,48H,7EH,3FH,48H
		DEFB	4CH,23H,4CH,24H,4CH,6FH,4CH,25H
		DEFB	4CH,26H,4CH,27H,0ACH,0AFH,4BH,61H
		DEFB	0ADH,34H,34H,0AEH,31H,26H,0B3H,56H
		DEFB	60H,0B3H,0C8H,0CEH,0EAH,3EH,5BH,0B5H
		DEFB	0AAH,41H,60H,0B5H,0ADH,4CH,28H,0B8H
		DEFB	0ABH,0A4H,43H,3BH,0B8H,0E1H,3BH,34H
		DEFB	0BAH,3FH,65H,3FH,70H,0BAH,0A6H,0DFH
		DEFB	38H,50H,0BBH,45H,39H,0BDH,0ABH,33H
		DEFB	22H,0BEH,39H,42H,0C0H,0EAH,60H,50H
		DEFB	0C0H,0ECH,0EBH,4DH,70H,0C1H,46H,3BH
		DEFB	0C4H,4BH,7EH,4CH,29H,4CH,2AH,0C4H
		DEFB	0B0H,39H,57H,0C8H,0E1H,0EBH,47H,27H
		DEFB	0C9H,0EAH,4EH,50H,3FH,69H,4AH,4BH
		DEFB	0CAH,33H,27H,0CAH,0C8H,39H,41H,4CH
		DEFB	2BH,0CAH,0DFH,46H,6EH,0CAH,0E2H,0C8H
		DEFB	38H,3BH,0CBH,0AFH,0A4H,3DH,39H,0CDH
		DEFB	4AH,76H,4EH,66H,4AH,77H,56H,2AH
		DEFB	0CEH,4CH,2CH,64H,42H,0CEH,0EAH,4CH
		DEFB	2DH,0CEH,0EBH,3CH,42H,0DFH,3CH,2AH
		DEFB	0DFH,0CAH,0B0H,0B5H,4EH,6AH,0E3H,0AFH
		DEFB	4CH,2EH,0E4H,35H,5CH,0E4H,0B3H,45H
		DEFB	54H,0E7H,0A6H,4CH,3EH,4CH,40H,4CH
		DEFB	2FH,0EAH,4CH,30H,0F3H,4CH,31H,4CH
		DEFB	32H,4CH,33H,4CH,35H,4CH,34H,4CH
		DEFB	38H,4CH,36H,4CH,37H,4CH,39H,0ABH
		DEFB	0A8H,0EBH,37H,5EH,0ABH,0B7H,40H,4EH
		DEFB	0ADH,38H,7EH,0AEH,47H,7EH,0AFH,4CH
		DEFB	3AH,0AFH,0A4H,0EBH,3DH,37H,0B0H,0E9H
		DEFB	4EH,2AH,0B3H,4CH,3BH,54H,66H,0B4H
		DEFB	0A4H,39H,73H,0B7H,43H,6EH,0B9H,3EH
		DEFB	78H,0B9H,0E1H,4CH,3CH,0BAH,0ABH,0B7H
		DEFB	0A4H,46H,71H,0C1H,4AH,5CH,0C4H,4BH
		DEFB	53H,0CDH,3DH,21H,36H,3BH,3BH,5DH
		DEFB	45H,6FH,0E9H,42H,3CH,0E9H,0B5H,0ADH
		DEFB	3BH,67H,0ECH,37H,32H,0EDH,3CH,3CH
		DEFB	4CH,5CH,34H,63H,32H,6AH,0A4H,4CH
		DEFB	3EH,4CH,40H,4CH,3FH,4CH,41H,4CH
		DEFB	43H,4CH,44H,4CH,42H,4CH,3DH,4CH
		DEFB	45H,62H,54H,6EH,49H,0ABH,0B1H,3EH
		DEFB	2AH,0B0H,0EBH,3DH,64H,0B9H,3EH,24H
		DEFB	4CH,46H,3BH,73H,0BAH,0E9H,0B7H,0A4H
		DEFB	44H,41H,0C4H,4CH,47H,0C8H,0EBH,55H
		DEFB	38H,0F3H,4CH,4CH,4CH,48H,4CH,4AH
		DEFB	4CH,49H,4CH,4DH,4CH,4BH,4CH,4FH
		DEFB	4CH,50H,41H,53H,41H,74H,4CH,4EH
		DEFB	0A6H,4CH,53H,4CH,56H,4CH,54H,4CH
		DEFB	55H,4CH,57H,4CH,52H,4CH,58H,4CH
		DEFB	51H,5BH,24H,5BH,2FH,0A6H,0B1H,4CH
		DEFB	59H,0A6H,0B1H,0EBH,4CH,59H,0A6H,0B9H
		DEFB	3FH,3DH,0A6H,0C7H,0EBH,37H,58H,0A8H
		DEFB	0EBH,47H,33H,4BH,28H,0AFH,4CH,5CH
		DEFB	4CH,5AH,4CH,5BH,4CH,5DH,0B0H,0EBH
		DEFB	40H,78H,0C0H,0A8H,0EBH,4CH,65H,0C1H
		DEFB	4CH,5FH,4CH,5EH,71H,36H,0C1H,0A4H
		DEFB	0EBH,4DH,51H,0C3H,0C8H,0E2H,3AH,47H
		DEFB	4CH,60H,0C6H,0A2H,0BDH,0D6H,4FH,2EH
		DEFB	0C8H,4BH,5CH,38H,35H,34H,70H,41H
		DEFB	47H,0C8H,0E1H,0EBH,4FH,4BH,0C9H,0EAH
		DEFB	4CH,61H,0C9H,0EBH,4CH,61H,0CEH,3CH
		DEFB	54H,4AH,2AH,0DFH,4CH,62H,0E2H,49H
		DEFB	34H,45H,6DH,42H,5CH,0E9H,0A4H,4CH
		DEFB	63H,0E9H,0A6H,4CH,63H,0EAH,3FH,39H
		DEFB	40H,39H,45H,4EH,0ECH,31H,4CH,0ECH
		DEFB	0EBH,4FH,33H,0EDH,0A4H,40H,48H,0F3H
		DEFB	4CH,64H,4CH,67H,4CH,66H,4CH,65H
		DEFB	0F3H,0E1H,4CH,68H,4CH,6EH,32H,30H
		DEFB	4CH,6BH,4CH,70H,4CH,6FH,4CH,69H
		DEFB	4CH,6AH,3AH,48H,4CH,6CH,40H,7DH
		DEFB	4CH,6DH,43H,2BH,0A4H,0D0H,51H,63H
		DEFB	0ABH,0BFH,34H,5BH,34H,5CH,0AFH,4CH
		DEFB	73H,4CH,74H,4CH,72H,3EH,46H,4CH
		DEFB	75H,4CH,76H,4CH,71H,0B0H,0E9H,4FH
		DEFB	26H,0B7H,5CH,3FH,0B7H,0ADH,45H,21H
		DEFB	0B7H,0EDH,3CH,52H,0B9H,42H,59H,4CH
		DEFB	77H,39H,2FH,47H,2BH,0B9H,0A4H,30H
		DEFB	42H,0BBH,0EBH,41H,69H,0C4H,45H,5BH
		DEFB	0C8H,0A6H,38H,5BH,4DH,43H,0C9H,3DH
		DEFB	49H,0CAH,0AEH,4CH,78H,4DH,4CH,0D6H
		DEFB	4CH,79H,69H,2EH,0D6H,0EBH,47H,4BH
		DEFB	0DEH,3BH,33H,0DEH,0A4H,49H,42H,0DEH
		DEFB	0C8H,4FH,41H,0DFH,30H,47H,0EAH,41H
		DEFB	64H,4CH,7AH,41H,79H,0EFH,0E9H,0ABH
		DEFB	0A4H,46H,70H,3DH,40H,4DH,22H,4CH
		DEFB	7DH,45H,72H,4DH,21H,4CH,7BH,4CH
		DEFB	7EH,4CH,7CH,53H,48H,0A4H,30H,64H
		DEFB	4DH,23H,30H,54H,0A6H,4DH,2DH,4DH
		DEFB	25H,4DH,33H,4DH,3AH,4DH,27H,4DH
		DEFB	37H,4DH,39H,4DH,3BH,4DH,3CH,4DH
		DEFB	26H,4DH,35H,4DH,36H,4DH,34H,4DH
		DEFB	2BH,4DH,2CH,4DH,31H,4DH,24H,4DH
		DEFB	2AH,4DH,29H,4DH,2FH,4DH,38H,4DH
		DEFB	56H,4DH,28H,4CH,60H,4DH,2EH,4DH
		DEFB	30H,4DH,32H,0A8H,38H,4EH,0ABH,3EH
		DEFB	32H,0ADH,39H,2CH,47H,37H,40H,63H
		DEFB	0AFH,39H,54H,40H,42H,0BAH,4DH,2EH
		DEFB	0BAH,0EBH,3EH,79H,0BFH,0ABH,4BH,2DH
		DEFB	0C7H,0EBH,68H,27H,0D3H,3BH,58H,0DFH
		DEFB	35H,5DH,0E1H,4CH,34H,0EBH,4DH,49H
		DEFB	0EBH,0A4H,34H,4BH,3BH,4DH,42H,65H
		DEFB	40H,24H,4DH,3FH,4DH,3DH,4CH,6BH
		DEFB	4DH,3EH,4DH,42H,4DH,40H,4DH,41H
		DEFB	0A4H,4EH,49H,41H,31H,3EH,2CH,0A6H
		DEFB	4DH,51H,4DH,4EH,4DH,57H,4DH,55H
		DEFB	4DH,46H,4DH,4DH,4DH,4BH,4DH,5BH
		DEFB	4DH,5CH,4DH,58H,4DH,59H,4DH,44H
		DEFB	4DH,48H,4DH,52H,3FH,6CH,4DH,53H
		DEFB	4DH,49H,4DH,4FH,4DH,4AH,4DH,47H
		DEFB	4DH,45H,31H,4DH,4DH,43H,4DH,5AH
		DEFB	4DH,4CH,4DH,56H,4DH,50H,4DH,54H
		DEFB	59H,39H,0A6H,0E4H,0AFH,41H,32H,0AFH
		DEFB	4DH,61H,4DH,5FH,4DH,63H,4DH,62H
		DEFB	4DH,5EH,4DH,5DH,4DH,60H,0B3H,32H
		DEFB	23H,0B7H,35H,41H,4DH,33H,35H,48H
		DEFB	39H,25H,4BH,27H,32H,42H,0C9H,4DH
		DEFB	64H,0C9H,0E0H,45H,43H,0D6H,38H,46H
		DEFB	0DFH,0ACH,0A8H,0EBH,61H,34H,0E0H,46H
		DEFB	49H,6CH,26H,0E1H,32H,47H,0E2H,0AEH
		DEFB	4BH,29H,0EBH,4CH,6BH,34H,73H,47H
		DEFB	32H,0EDH,0A4H,33H,3BH,0EDH,0B7H,0AFH
		DEFB	35H,39H,0EFH,0A4H,3CH,65H,0F3H,3BH
		DEFB	4DH,4DH,65H,4DH,67H,4DH,66H,0A4H
		DEFB	4DH,68H,4DH,6AH,4DH,6BH,4DH,69H
		DEFB	61H,7AH,62H,7DH,0AFH,33H,5AH,4DH
		DEFB	6EH,4DH,6DH,4DH,6FH,4DH,6CH,0C1H
		DEFB	54H,3FH,54H,40H,0C4H,51H,6FH,59H
		DEFB	47H,6DH,65H,0F3H,4DH,70H,4DH,72H
		DEFB	4DH,77H,4DH,71H,4DH,73H,4DH,76H
		DEFB	4DH,75H,4DH,74H,73H,42H,4DH,7DH
		DEFB	4DH,78H,4DH,7AH,4EH,22H,4EH,25H
		DEFB	4EH,24H,4DH,7CH,4DH,7BH,4EH,21H
		DEFB	4DH,79H,4DH,7EH,4EH,23H,58H,26H
		DEFB	6BH,4AH,0ADH,4EH,4FH,0AFH,4EH,26H
		DEFB	0C4H,4EH,29H,4EH,28H,4EH,27H,4EH
		DEFB	2AH,58H,4BH,0E3H,0AFH,4EH,2CH,4EH
		DEFB	2BH,0E5H,0A6H,4EH,29H,4EH,2EH,4EH
		DEFB	35H,4CH,78H,4EH,31H,4EH,34H,4EH
		DEFB	32H,4EH,2FH,4EH,33H,4EH,2DH,4EH
		DEFB	30H,4EH,36H,0E7H,4EH,39H,4EH,38H
		DEFB	4EH,3AH,4EH,37H,0E7H,0A6H,4EH,41H
		DEFB	4EH,3EH,4EH,40H,4EH,49H,4EH,4EH
		DEFB	4EH,4CH,35H,79H,4EH,45H,4EH,3DH
		DEFB	4EH,3BH,4EH,6EH,4EH,48H,4EH,43H
		DEFB	4EH,3CH,4EH,44H,4EH,4BH,4EH,4DH
		DEFB	4EH,3FH,4EH,47H,4EH,42H,4EH,46H
		DEFB	4EH,4AH,4EH,6AH,5BH,22H,6DH,52H
		DEFB	0E7H,0AFH,4EH,4FH,4EH,50H,0F3H,4EH
		DEFB	53H,4EH,59H,4EH,58H,4EH,57H,4EH
		DEFB	52H,4EH,55H,4EH,5BH,4EH,51H,4EH
		DEFB	54H,4EH,5AH,4EH,56H,51H,5BH,52H
		DEFB	67H,63H,48H,6DH,38H,4FH,2CH,4EH
		DEFB	5CH,3CH,48H,0A4H,4EH,5DH,4EH,60H
		DEFB	4EH,5EH,4EH,5FH,0A4H,4EH,70H,4EH
		DEFB	63H,4EH,6BH,4EH,64H,4EH,61H,4EH
		DEFB	69H,4EH,6DH,4EH,6EH,4EH,65H,4EH
		DEFB	6FH,4EH,66H,4EH,68H,4EH,6CH,4EH
		DEFB	62H,4EH,67H,4EH,6AH,63H,39H,73H
		DEFB	74H,0ADH,4EH,72H,4EH,71H,63H,2AH
		DEFB	0C4H,4EH,73H,4EH,75H,4EH,76H,4EH
		DEFB	74H,0F3H,4FH,22H,4EH,7DH,4EH,78H
		DEFB	4FH,21H,4FH,23H,4EH,7BH,4EH,77H
		DEFB	4EH,7CH,4EH,7EH,4EH,79H,4EH,7AH
		DEFB	4FH,29H,4FH,2AH,4FH,24H,4FH,27H
		DEFB	4FH,25H,48H,27H,4FH,26H,4FH,28H
		DEFB	0A6H,4FH,3AH,4FH,2BH,4FH,37H,4FH
		DEFB	2FH,4FH,32H,4FH,2DH,4FH,35H,4FH
		DEFB	39H,4FH,30H,4FH,36H,4FH,33H,4FH
		DEFB	2CH,4FH,34H,4FH,38H,4FH,2EH,4FH
		DEFB	31H,0AFH,4FH,3BH,4FH,3FH,4FH,3CH
		DEFB	4FH,3DH,4FH,3EH,0F3H,4FH,40H,4FH
		DEFB	42H,4FH,43H,34H,44H,4EH,58H,4FH
		DEFB	41H,47H,47H,47H,4AH,0A4H,4FH,45H
		DEFB	37H,28H,4FH,44H,0ABH,0A4H,3CH,63H
		DEFB	0ABH,0ECH,0EBH,4AH,4CH,0ADH,4FH,46H
		DEFB	66H,7EH,0AFH,4FH,47H,4AH,28H,4DH
		DEFB	2FH,4FH,48H,4DH,30H,0B1H,4CH,75H
		DEFB	0B6H,35H,3BH,0B6H,0EFH,0A4H,3AH,52H
		DEFB	32H,52H,0B7H,4FH,49H,0B9H,0ECH,0EBH
		DEFB	4BH,3AH,0BAH,0ABH,36H,4FH,0BAH,0E9H
		DEFB	0EFH,0B7H,0A4H,48H,51H,0BFH,4CH,4AH
		DEFB	4CH,49H,0BFH,0AFH,0B7H,3BH,64H,0BFH
		DEFB	0B7H,3BH,64H,0BFH,0EAH,4FH,4BH,4FH
		DEFB	4AH,0BFH,0EBH,4FH,4AH,0C0H,0C1H,45H
		DEFB	32H,0CAH,66H,2BH,0CBH,4FH,4CH,0D3H
		DEFB	4FH,4DH,0D3H,0B7H,0A4H,50H,4EH,0D3H
		DEFB	0EBH,4FH,4DH,0E9H,4FH,4EH,0E9H,0A6H
		DEFB	3EH,50H,0E9H,0B8H,70H,5EH,0E9H,0D3H
		DEFB	4FH,4FH,0E9H,0D9H,46H,38H,0EAH,33H
		DEFB	64H,0EBH,33H,64H,0EBH,0A4H,30H,2DH
		DEFB	0ECH,38H,63H,32H,66H,0F3H,4FH,51H
		DEFB	4FH,53H,4FH,52H,4FH,50H

        DEFS	0BFF0H-$,0FFH

        JP	J8000

        DEFS	0C000H-$,0FFH

        END

