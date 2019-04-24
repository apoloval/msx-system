Mainrom

        ORG	00183H

; Some sort of extra BIOS

J0183:	JP	J1469
J0186:	JP	J1006
J0189:	JP	J1012
J018C:	JP	J101E
J018F:	JP	J102A
J0192:	JP	J1036
J0195:	JP	J145E

J0198:	CALL	C1070
        JP	Z,CHSNS			; no hangul rom, do CHSNS
        PUSH	IX
        LD	IX,04038H
J01A4:	PUSH	IY
        PUSH	AF
        LD	A,(SLTWRK+4)		; slotid hangul rom
        PUSH	AF
        POP	IY
        POP	AF
        CALL	CALSLT
        POP	IY
        POP	IX
        RET


        ORG	00540H

; patch device STOP
; MSX2 had
;
;	XOR	A
;	LD	SP,(F6B1)
;	PUSH	BC
;	JP	J63E6

        JP	J0F98
        DEFS	00549H-$,0

; end of patch

        ORG	0058DH
; patch BREAKX
;
; MSX2 had
;
;	LD	(REPCNT),A

        CALL	C141CH

; end of patch

        ORG	00C24H

;
; MSX2 had part of KANA key handler here

        PUSH	HL
        PUSH	DE
        PUSH	BC
        CALL	C1070
        CALL	NZ,C1122		; hangul rom available,
        POP	BC
        POP	DE
        POP	HL
        PUSH	IX
        LD	IX,S.GRPPRT
        JP	J0295
        NOP

        ORG	01006H

;	-----------------
;	korean �BIOS� routine 0186H
;	-----------------

J1006:	CALL	C1070
        RET	Z			; no hangul rom, quit
        PUSH	IX
        LD	IX,04023H
        JR	J103C

;	-----------------
;	korean �BIOS� routine 0189H
;	-----------------

J1012:	CALL	C1070
        RET	Z			; no hangul rom, quit
        PUSH	IX
        LD	IX,04026H
        JR	J103C

;	-----------------
;	korean �BIOS� routine 018CH
;	-----------------

J101E:	CALL	C1070
        RET	Z			; no hangul rom, quit
        PUSH	IX
        LD	IX,04032H
        JR	J103C

;	-----------------
;	korean �BIOS� routine 018FH
;	-----------------

J102A:	CALL	C1070
        RET	Z			; no hangul rom, quit
        PUSH	IX
        LD	IX,0402CH
        JR	J103C

;	-----------------
;	korean �BIOS� routine 0192H
;	-----------------

J1036:	PUSH	IX
        LD	IX,04029H
J103C:	JP	J01A4

;	-----------------
;	patch routine read statusregister VDP (extra: read reading mouse/lightpen switch)
;	korean does this via V9938 VDP
;	-----------------

?.103F:	LD	A,01H	; 1 
        DI	
        OUT	(99H),A
        LD	A,8FH
        OUT	(99H),A			; VDP(15)=1, select status register 1
        IN	A,(99H)			; read status register
        PUSH	AF
        XOR	A
        OUT	(99H),A
        LD	A,8FH
        OUT	(99H),A			; VDP(15)=0, select status register 0
        POP	AF
        BIT	7,A			; FL (mouse/lightpen switch)
        JR	Z,J105C
        LD	HL,XSAVE+1
        SET	7,(HL)
J105C:	IN	A,(99H)			; read status register
        AND	A
        RET	

;	-----------------
;	patch routine for PAD function
;	-----------------

?.1060:	CP	14H			; pad 20 or above ?
        JR	NC,J1068		; yep, handle differently
J1064:	CALL	C7B3E
        RET	
;
;	-----------------
J1068:	CP	18H			; pad 24 or above ?
        JR	NC,J1064		; yep, handle normaly
        SUB	0CH			; range 20-23 = range 8-11 (lightpen)
        JR	J1064
;
;	-----------------
;
;	  Subroutine __________________________
;	     Inputs  ________________________
;	     Outputs ________________________
;
C.1070:	PUSH	BC
        LD	B,A
        LD	A,(SLTWRK+4)		; slotid hangul rom
        CP	00H
        LD	A,B
        POP	BC
        RET	

        ORG	0111CH

; MSX2 had unused code here

J111C:	CALL	C1070
        JP	Z,CNVCHR		; no hangul rom, do CNVCHR
C1122:	LD	IX,0401FH
        LD	C,A
        LD	A,(SLTWRK+5)		; slotid korean extension rom
        PUSH	AF
        POP	IY
        LD	A,C
        JP	CALSLT


        ORG	0141CH

; MSX2 had unused space here

C141C:	LD	(REPCNT),A
C141F:	CALL	C1070
        RET	Z			; no hangul rom, quit
        PUSH	IX
        LD	IX,04035H
        JP	J01A4
;
;	-----------------
?.142C:	CALL	C1070
        JR	Z,J$1434		; no hangul rom, skip
        CALL	C$1455
J$1434:	CALL	FNKSB
        RET	

;	  Subroutine function key handler
;	     Inputs  ________________________
;	     Outputs ________________________

J1438:	LD	A,(KANAMD)
        CP	02H
        JP	C,J0EBB
        CP	05H
        JP	NC,J0EBB
        CALL	C1070
        JP	Z,J0EBB			; no hangul rom, default action
        LD	A,C
        PUSH	IX
        LD	IX,04053H
        JP	J01A4
;
;	-----------------
;
;	  Subroutine __________________________
;	     Inputs  ________________________
;	     Outputs ________________________
;
C$1455:	PUSH	IX
        LD	IX,04050H
        JP	J01A4

;	-----------------
;	korean �BIOS� routine 0195H
;	-----------------

J145E:	CALL	C1070
        RET	Z			; no hangul rom, quit
        LD	IX,0401CH
        JP	J$1126

;	-----------------
;	korean �BIOS� routine 0183H
;	-----------------

J1469:	CALL	C1070
        RET	Z			; no hangul rom, quit
        PUSH	IX
        LD	IX,04020H
        JP	J01A4

        DEFS	01479H-$,0


        ORG	0148CH

; patch read statusregister VDP

; MSX2 had
;	IN	A,(099H)
        AND	A
        RET

        JP	J103F
        NOP
        NOP


        ORG	01513H

; patch GRPPRT
;
; MSX2 had
;
;	PUSH	IX
;	LD	IX,0089H
;	JP	0295H

        JP	J0C24
        DEFS	0151CH-$,0


        ORG	015C0H

; patch
;
; MSX2 had
;
;	JR	C,15C6H
;	EX	DE,HL

        JP	J111CH


        ORG	01B87H

; patch OUTDLP
;
; no difference between non-MSX en MSX printer

        JP	J1BAB
        DEFS	01BABH-$,0

        ORG	07349H

; patch INKEY$ statement

        CALL	C0198


        ORG	078FBH

; patch KEY statements

        CALL	C142C


        ORG	0796CH

; patch PAD function
;
; MSX2 had
;
;	CP	14H

        CP	18H


        ORG	07976H

; patch PAD function
;
; MSX2 had
;
;	CALL	07B3E

        CALL	C1060


        ORG	07D3B

; patch
; skip copyright and bytes free message

        RET



Subrom
Has also differences
