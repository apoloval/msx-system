; *************************************
; BEGIN OF BRASILIAN KEYBOARD HANDLER
; ************************************* 

I0DA5:	DEFB	30H,31H,32H,33H,34H,35H,36H,37H
        DEFB	38H,39H,2DH,3DH,7BH,0FFH,5BH,0FFH
        DEFB	2AH,87H,2CH,2EH,3BH,2FH,61H,62H
        DEFB	63H,64H,65H,66H,67H,68H,69H,6AH
        DEFB	6BH,6CH,6DH,6EH,6FH,70H,71H,72H
        DEFB	73H,74H,75H,76H,77H,78H,79H,7AH
        DEFB	29H,21H,22H,23H,24H,25H,5EH,26H
        DEFB	27H,28H,5FH,2BH,7DH,0FFH,5DH,0FFH
        DEFB	40H,80H,3CH,3EH,3AH,3FH,41H,42H
        DEFB	43H,44H,45H,46H,47H,48H,49H,4AH
        DEFB	4BH,4CH,4DH,4EH,4FH,50H,51H,52H
        DEFB	53H,54H,55H,56H,57H,58H,59H,5AH
        DEFB	09H,0ACH,0ABH,0BAH,0EFH,0BDH,0F4H,0FBH
        DEFB	0ECH,07H,17H,0F1H,1EH,01H,0DH,06H
        DEFB	05H,0BBH,0F3H,0F2H,1DH,5CH,0C4H,11H
        DEFB	0BCH,0C7H,0CDH,14H,15H,13H,0DCH,0C6H
        DEFB	0DDH,0C8H,0BH,1BH,0C2H,0DBH,0CCH,18H
        DEFB	0D2H,12H,0C0H,1AH,0CFH,1CH,19H,0FH
        DEFB	0AH,00H,0FDH,0FCH,00H,00H,0F5H,00H
        DEFB	00H,08H,1FH,0F0H,16H,02H,0EH,04H
        DEFB	03H,0F7H,0AEH,0AFH,0F6H,7CH,0FEH,00H
        DEFB	0FAH,0C1H,0CEH,0D4H,10H,0D6H,0DFH,0CAH
        DEFB	0DEH,0C9H,0CH,0D3H,0C3H,0D7H,0CBH,0A9H
        DEFB	0D1H,00H,0C5H,0D5H,0D0H,0F9H,0AAH,0F8H
        DEFB	0EBH,9FH,0D9H,0BFH,9BH,98H,0E0H,0E1H
        DEFB	0E7H,87H,0EEH,0E9H,00H,0EDH,0DAH,0B7H
        DEFB	0B9H,0E5H,86H,0A6H,0A7H,0FFH,84H,97H
        DEFB	8DH,8BH,8CH,94H,81H,0B1H,0A1H,91H
        DEFB	0B3H,0B5H,0E6H,0A4H,0A2H,0A3H,83H,93H
        DEFB	89H,96H,82H,95H,88H,8AH,0A0H,85H
        DEFB	0D8H,0ADH,9EH,0BEH,9CH,9DH,00H,00H
        DEFB	0E2H,80H,00H,00H,00H,0E8H,0EAH,0B6H
        DEFB	0B8H,0E4H,8FH,00H,0A8H,0FFH,8EH,00H
        DEFB	00H,00H,00H,99H,9AH,0B0H,00H,92H
        DEFB	0B2H,0B4H,00H,0A5H,00H,0E3H,00H,00H
        DEFB	00H,00H,90H,00H,00H,00H,00H,00H

J0EC5:	LD	E,C
        LD	D,00H
        LD	HL,FNKFLG-035H
        ADD	HL,DE
        LD	A,(HL)
        AND	A
        JR	NZ,J0EE3
J0ED0:	EX	DE,HL
        ADD	HL,HL
        ADD	HL,HL
        ADD	HL,HL
        ADD	HL,HL
        LD	DE,FNKSTR-035H*16
        ADD	HL,DE
        EX	DE,HL
J0EDA:	LD	A,(DE)
        AND	A
        RET	Z
        CALL	C0F55
        INC	DE
        JR	J0EDA

J0EE3:	LD	HL,(CURLIN)
        INC	HL
        LD	A,H
        OR	L
        JR	Z,J0ED0
        LD	HL,TRPTBL-035H*3
        ADD	HL,DE
        ADD	HL,DE
        ADD	HL,DE
        LD	A,(HL)
        AND	01H
        RET	Z
        LD	A,(HL)
        OR	04H
        CP	(HL)
        RET	Z
        LD	(HL),A
        XOR	05H
        RET	NZ
        LD	A,(ONGSBF)
        INC	A
        LD	(ONGSBF),A
        RET

C0F06:	LD	A,(NEWKEY+6)
        RRCA
        LD	A,0CH
        SBC	A,00H
        JR	C0F55

C0F10:	CALL	H.KEYA
        LD	E,A
        LD	D,00H
        LD	HL,I1033-030H
        ADD	HL,DE
        LD	A,(HL)
        AND	A
        RET	Z
        JR	C0F55

J0F1F:	LD	HL,NEWKEY+6
        LD	A,C
        CP	0FH
        LD	A,03H
        JR	Z,J0F2B
        LD	A,01H
J0F2B:	BIT	0,(HL)
        JR	Z,J0F30
        INC	A
J0F30:	LD	C,A
        JP	J141C

;
;	leftover from KANA keyhandler, not used
;

        DEFS	00F36H-$,0

C0F36:	LD	HL,CAPST
        LD	A,(HL)
        CPL
        LD	(HL),A
        CPL

K.BCAP:	AND	A
        LD	A,0CH
        JR	Z,J0F43
        INC	A
J0F43:	OUT	(0ABH),A
        RET

C0F46:	LD	A,(NEWKEY+6)
        RRCA
        RRCA
        LD	A,03H
        JR	NC,J0F50
        INC	A
J0F50:	LD	(INTFLG),A
        JR	C,J0F64

;	  Subroutine __________________________
;	     Inputs  ________________________
;	     Outputs ________________________

C0F55:	LD	HL,(PUTPNT)
        LD	(HL),A
        CALL	C105B
        LD	A,(GETPNT)
        CP	L
        RET	Z
        LD	(PUTPNT),HL
J0F64:	LD	A,(CLIKSW)
        AND	A
        RET	Z
        LD	A,(CLIKFL)
        AND	A
        RET	NZ
        LD	A,0FH
        LD	(CLIKFL),A
        OUT	(0ABH),A
        LD	A,10
J0F77:	DEC	A
        JR	NZ,J0F77

K.BSND:	AND	A
        LD	A,0EH
        JR	Z,J0F80
        INC	A
J0F80:	OUT	(0ABH),A
        RET

C0F83:	LD	A,(NEWKEY+6)
        LD	E,A
        RRA
        RRA
        PUSH	AF
        LD	A,E
        CPL
        JR	NC,J0F9E
        RRA
        RRA
        RLCA
        AND	03H
        BIT	1,A
        JR	NZ,J0FA0
        BIT	4,E
        JR	NZ,J0FA0
        OR	04H
        DEFB	011H
J0F9E:	AND	001H
J0FA0:	LD	E,A
        ADD	A,A
        ADD	A,E
        ADD	A,A
        ADD	A,A
        ADD	A,A
        ADD	A,A
        LD	E,A
        LD	D,00H
        LD	HL,I0DA5
        ADD	HL,DE
        LD	B,D
        ADD	HL,BC
        POP	AF
        LD	A,(HL)
        INC	A
        JP	Z,J0F1F
        DEC	A
        RET	Z
        JR	C,J0FD0
        AND	0DFH
        SUB	40H
        CP	20H
        RET	NC
J0FC1:	JR	C0F55

C0FC3:	LD	A,(NEWKEY+6)
        RRCA
        JR	C,J0FCD
        LD	A,C
        ADD	A,05H
        LD	C,A
J0FCD:	JP	J0EC5

J0FD0:	CP	20H
        JR	NC,J0FDF
        PUSH	AF
        LD	A,01H
        CALL	C0F55
        POP	AF
        ADD	A,40H
        JR	J0FC1

J0FDF:	LD	HL,CAPST
        INC	(HL)
        DEC	(HL)
        JR	Z,J0FF0
        CP	61H
        JR	C,J1011
        CP	7BH
        JR	NC,J1011
        AND	0DFH
J0FF0:	LD	DE,(KANAST)
        INC	E
        DEC	E
        JR	Z,J0FC1
        LD	D,A
        OR	20H
        LD	HL,I1061+5-1
        LD	C,5
        CPDR
        LD	A,D
        JR	NZ,J0FC1
        INC	HL
        LD	C,05H
J1008:	ADD	HL,BC
        DEC	E
        JR	NZ,J1008
        LD	A,(HL)
        BIT	5,D
        JR	NZ,J0FC1
J1011:	LD	C,20
        LD	HL,I107F+20-1
        CPDR
        JR	NZ,J0FC1
        LD	C,20
        INC	HL
        ADD	HL,BC
        LD	A,(HL)
        JR	J0FC1

K.HAND:	LD	A,C
        LD	HL,I1B96
        CALL	H.KEYC
        LD	D,HIGH C0F06
J102A:	CP	(HL)
        INC	HL
        LD	E,(HL)
        INC	HL
        PUSH	DE
        RET	C
        POP	DE
        JR	J102A

I1033:	DEFB	00H,00H,00H,00H,00H,00H,00H,00H
        DEFB	00H,00H,1BH,09H,00H,08H,18H,0DH
        DEFB	20H,0CH,12H,7FH,1DH,1EH,1FH,1CH
        DEFB	2BH,2DH,2AH,2FH,00H,00H,00H,00H
        DEFB	00H,00H,00H,00H,00H,00H,00H,00H

;	  Subroutine __________________________
;	     Inputs  ________________________
;	     Outputs ________________________

C105B:	XOR	A
        LD	(KANAST),A
        JR	J10C2

I1061:	DEFB	061H,065H,069H,06FH,075H
        DEFB	085H,065H,069H,095H,097H
        DEFB	0A0H,082H,0A1H,0A2H,0A3H
        DEFB	083H,088H,069H,093H,096H
        DEFB	0B1H,065H,0B3H,0B5H,081H
        DEFB	000H,000H,000H,000H,000H

I107F:	DEFB	085H,065H,069H,06FH,097H,0A0H,082H,0A1H,0A2H,0A3H,083H,088H,093H,096H,061H,075H,081H,0B1H,0B5H,087H
        DEFB	08FH,045H,049H,04FH,055H,084H,090H,089H,08AH,08BH,08CH,08DH,08EH,055H,041H,055H,09AH,0B0H,0B4H,080H

        DEFS	010C2H-$,0

        ORG	01B94H

        JR	J1BAC

I1B96:	DEFB	030H,LOW C0F83
        DEFB	033H,LOW C0F10
        DEFB	034H,LOW C0F36
        DEFB	035H,LOW C0F10
        DEFB	03AH,LOW C0FC3
        DEFB	03CH,LOW C0F10
        DEFB	03DH,LOW C0F46
        DEFB	041H,LOW C0F10
        DEFB	042H,LOW C0F06
        DEFB	0FFH,LOW C0F10

        DEFS	01BABH-$,0

; *************************************
; END OF BRASILIAN KEYBOARD HANDLER
; ************************************* 
