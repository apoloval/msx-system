; *************************************
; BEGIN OF GERMAN KEYBOARD HANDLER
; *************************************
;
D0DA5:

; Normal layout

        DEFB	30H,31H,32H,33H,34H,35H,36H,37H
        DEFB	38H,39H,0E1H,0FFH,3CH,81H,2BH,94H
        DEFB	84H,23H,2CH,2EH,2DH,00H,61H,62H
        DEFB	63H,64H,65H,66H,67H,68H,69H,6AH
        DEFB	6BH,6CH,6DH,6EH,6FH,70H,71H,72H
        DEFB	73H,74H,75H,76H,77H,78H,7AH,79H

; Shift layout

        DEFB	3DH,21H,22H,0BFH,24H,25H,26H,2FH
        DEFB	28H,29H,3FH,0FFH,3EH,9AH,2AH,99H
        DEFB	8EH,5EH,3BH,3AH,5FH,00H,41H,42H
        DEFB	43H,44H,45H,46H,47H,48H,49H,4AH
        DEFB	4BH,4CH,4DH,4EH,4FH,50H,51H,52H
        DEFB	53H,54H,55H,56H,57H,58H,5AH,59H

; Graph layout

        DEFB	09H,0ACH,0ABH,0BAH,0EFH,0BDH,0F4H,1DH
        DEFB	0ECH,07H,0DH,27H,0AEH,01H,0F1H,06H
        DEFB	05H,7EH,0FBH,16H,17H,00H,0C4H,11H
        DEFB	0BCH,0C7H,0CDH,14H,15H,13H,0DCH,0C6H
        DEFB	0DDH,0C8H,0BH,1BH,0C2H,0DBH,0CCH,18H
        DEFB	0D2H,12H,0C0H,1AH,0CFH,1CH,19H,0FH

; Shift+Graph layout

        DEFB	0AH,00H,0FDH,0FCH,00H,0F6H,0F5H,1EH
        DEFB	00H,08H,0EH,60H,0AFH,02H,1FH,04H
        DEFB	03H,0BBH,0F7H,00H,0F0H,00H,0FEH,00H
        DEFB	0FAH,0C1H,0CEH,0D4H,10H,0D6H,0DFH,0CAH
        DEFB	0DEH,0C9H,0CH,0D3H,0C3H,0D7H,0CBH,0A9H
        DEFB	0D1H,0D9H,0C5H,0D5H,0D0H,0F9H,0AAH,0F8H

; Code layout

        DEFB	0EBH,7CH,40H,0EEH,87H,9BH,0E7H,5CH
        DEFB	5BH,5DH,0E9H,0FFH,0F3H,0EDH,0DAH,0B7H
        DEFB	0B9H,0E5H,86H,0A6H,0A7H,00H,0E0H,97H
        DEFB	8DH,8BH,8CH,9FH,98H,0B1H,0A1H,91H
        DEFB	0B3H,0B5H,0E6H,0A4H,0A2H,0A3H,83H,93H
        DEFB	89H,96H,82H,95H,88H,8AH,0A0H,85H

; Shift+Code layout

        DEFB	0D8H,0ADH,9EH,0BEH,80H,9CH,0E2H,00H
        DEFB	7BH,7DH,0A8H,0FFH,0F2H,0E8H,0EAH
        DEFB	0B6H,0B8H,0E4H,8FH,00H,00H,00H,00H
        DEFB	00H
        DEFB	00H,00H,00H,00H,00H,0B0H,00H,92H
        DEFB	0B2H,0B4H,00H,0A5H,00H,0E3H,00H,00H
        DEFB	00H,00H,90H,00H,00H,00H,00H,9DH

;	Subroutine	rest of the functionkey handler
;	Inputs		C = code (035H-03EH)
;	Outputs		________________________
;	Remark		code identical among keyboard layout versions from this point

J0EC5:	LD	E,C
        LD	D,00H
        LD	HL,FNKFLG-035H
        ADD	HL,DE
        LD	A,(HL)
        AND	A			; functionkey used for trap ?
        JR	NZ,J0EE3		; yep, handle trap
J0ED0:	EX	DE,HL
        ADD	HL,HL
        ADD	HL,HL
        ADD	HL,HL
        ADD	HL,HL
        LD	DE,FNKSTR-035H*16
        ADD	HL,DE
        EX	DE,HL			; pointer to functionkey definition string
J0EDA:	LD	A,(DE)
        AND	A			; end of string ?
        RET	Z			; yep, quit
        CALL	C0F55			; put keycode in keyboardbuffer
        INC	DE
        JR	J0EDA			; next

J0EE3:	LD	HL,(CURLIN)
        INC	HL
        LD	A,H
        OR	L			; interpreter in direct mode ?
        JR	Z,J0ED0			; yep, normal behavior
        LD	HL,TRPTBL-035H*3
        ADD	HL,DE
        ADD	HL,DE
        ADD	HL,DE

;	Subroutine	raise trap
;	Inputs		________________________
;	Outputs		________________________
;	Remark		code identical among keyboard layout versions

C0EF1:	LD	A,(HL)
        AND	01H			; trap enabled ?
        RET	Z			; nope, quit
        LD	A,(HL)
        OR	04H
        CP	(HL)			; trap occured flag set ?
        RET	Z			; yep, quit
        LD	(HL),A			; flag trap occured
        XOR	05H			; trap paused ?
        RET	NZ			; yep, quit
        LD	A,(ONGSBF)
        INC	A
        LD	(ONGSBF),A		; increase trap counter
        RET

;	Subroutine	handler HOME key
;	Inputs		-
;	Outputs		________________________
;	Remark		code identical among keyboard layout versions

C0F06:	LD	A,(NEWKEY+6)
        RRCA				; SHIFT key status
        LD	A,0CH			; assume SHIFT-HOME -> CLS keycode
        SBC	A,0			; no SHIFT pressed -> HOME keycode
        JR	C0F55			; put keycode in keyboardbuffer

;	Subroutine	handler easily converted keys
;	Inputs		A = scancode (030H-057H)
;	Outputs		________________________
;	Remark		code identical among keyboard layout versions

C0F10:	CALL	H.KEYA
        LD	E,A
        LD	D,0
        LD	HL,I1038-030H
        ADD	HL,DE
        LD	A,(HL)
        AND	A			; keycode for key ?
        RET	Z			; nope, quit
        JR	C0F55			; put keycode in keyboardbuffer

I0F1F:	DEFB	030H,LOW C0F83
        DEFB	033H,LOW C0F10
        DEFB	034H,LOW C0F36
        DEFB	035H,LOW C0F10
        DEFB	03AH,LOW C0FC3
        DEFB	03CH,LOW C0F10
        DEFB	03DH,LOW C0F46
        DEFB	040H,LOW C0F10
        DEFB	041H,LOW C0FF1
        DEFB	042H,LOW C0F06
        DEFB	0FFH,LOW C0F10

        DEFS	00F36H-$,0

;	Subroutine	handler CAPS key
;	Inputs		-
;	Outputs		________________________
;	Remark		code identical among keyboard layout versions

C0F36:	LD	HL,CAPST
        LD	A,(HL)
        CPL
        LD	(HL),A			; toggle CAPS status
        CPL				; adjust for CHGCAP and change CAPS led

;	Subroutine	CHGCAP
;	Inputs		________________________
;	Outputs		________________________
;	Remark		code identical among keyboard layout versions

K.BCAP:	AND	A
        LD	A,0CH
        JR	Z,J0F43
        INC	A
J0F43:	OUT	(0ABH),A
        RET

;	Subroutine	handler STOP key
;	Inputs		-
;	Outputs		________________________
;	Remark		code identical among keyboard layout versions

C0F46:	LD	A,(NEWKEY+6)
        RRCA
        RRCA				; CTRL key status
        LD	A,3			; CTRL-STOP
        JR	NC,J0F50		; CTRL pressed, flag CTRL-STOP
        INC	A			; STOP
J0F50:	LD	(INTFLG),A
        JR	C,J0F64			; STOP, continue in keyclick

;	Subroutine	put keycode in keyboardbuffer
;	Inputs		A = keycode
;	Outputs		________________________
;	Remark		entrypoint compatible among keyboard layout versions

C0F55:	LD	HL,(PUTPNT)
        LD	(HL),A			; put in keyboardbuffer
        CALL	C1060			; reset DEAD status, next postition in keyboardbuffer with roundtrip
        LD	A,(GETPNT)
        CP	L			; keyboard buffer full ?
        RET	Z			; yep, quit
        LD	(PUTPNT),HL		; update put pointer

;	Subroutine	make keyclick
;	Inputs		-
;	Outputs		________________________
;	Remark		code identical among keyboard layout versions

J0F64:	LD	A,(CLIKSW)
        AND	A			; keyclicks enabled ?
        RET	Z			; nope, quit
        LD	A,(CLIKFL)
        AND	A			; keyclick already done (only one click for multiple keys) ?
        RET	NZ			; yep, quit
        LD	A,0FH
        LD	(CLIKFL),A		; no keyclick until the next scan
        OUT	(0ABH),A		; set click bit
        LD	A,10
J0F77:	DEC	A
        JR	NZ,J0F77		; wait
                                        ; reset click bit

;	Subroutine	change click bit
;	Inputs		A = 0, A <> 0
;	Outputs		________________________
;	Remark		code identical among keyboard layout versions

K.BSND:	AND	A
        LD	A,0EH
        JR	Z,J0F80
        INC	A
J0F80:	OUT	(0ABH),A
        RET

;	Subroutine	handler scancodes 000H-02FH
;	Inputs		C = scancode (000H-02FH)
;	Outputs		________________________

C0F83:	LD	A,(NEWKEY+6)
        LD	E,A
        RRA
        RRA				; CTRL status in Cx
        PUSH	AF
        LD	A,E
        CPL
        NOP
        NOP				; removed code for CTRL key (was in INT keyboard)
        RRA
        RRA
        RLCA
        AND	03H			; GRAPH and SHIFT status
        BIT	1,A
        JR	NZ,J0FA0		; GRAPH pressed, ignore CODE key, use GRAPH and SHIFT
        BIT	4,E			; CODE pressed ?
        JR	NZ,J0FA0		; nope, no GRAPH, no CODE, use only SHIFT
        OR	04H			; flag CODE pressed
        NOP
        NOP
        NOP				; removed code for CTRL key (was in INT keyboard)
J0FA0:	LD	E,A
        ADD	A,A
        ADD	A,E
        ADD	A,A
        ADD	A,A
        ADD	A,A
        ADD	A,A
        LD	E,A			; *48 (6*8)
        LD	D,0
        LD	HL,D0DA5
        ADD	HL,DE			; keycode table
        LD	B,D
        ADD	HL,BC			; + scancode
        POP	AF
        LD	A,(HL)
        INC	A			; DEAD key ?
        JP	Z,J1B96			; yep, handle dead key
        DEC	A			; keycode for this combination ?
        RET	Z			; nope, quit
        JR	C,J0FD0			; no CTRL pressed, non CTRL handler
        AND	0DFH			; make upcase
        SUB	40H			; convert "@","A"-"Z" to keycode (controlcode)
        CP	20H			; was "@" or "A"-"Z" ?
        RET	NC			; nope, quit (ignore)
J0FC1:	JR	C0F55			; put keycode in keyboardbuffer

;	Subroutine	handler functionkeys
;	Inputs		C = scancode (035H-039H)
;	Outputs		________________________

C0FC3:	LD	A,(NEWKEY+6)
        RRCA				; SHIFT key pressed ?
        JR	C,J0FCD			; nope, F1-F5
        LD	A,C
        ADD	A,5
        LD	C,A			; yep, F6-F10
J0FCD:	JP	J0EC5			; rest of the functionkey handler

;	Subroutine	handler keycodes scancodes 000H-02FH
;	Inputs		A = keycode
;	Outputs		________________________

J0FD0:	CP	20H			; keycode with graphic header ?
        JR	NC,J0FDF		; nope,
        PUSH	AF
        LD	A,1			; put MSX header keycode in keyboard buffer
        CALL	C0F55			; put keycode in keyboardbuffer
        POP	AF
        ADD	A,40H			; to 040H-05FH keycode
        JR	J0FC1			; put keycode in keyboardbuffer

J0FDF:	LD	HL,CAPST
        INC	(HL)
        DEC	(HL)			; in CAPS mode ?
        JR	Z,J0FF5			; nope, unchanged
        CP	"a"
        JR	C,J1016			; not a lowercase letter,
        CP	"z"+1
        JR	NC,J1016		; not a lowercase letter,
        AND	0DFH			; upcase
        DEFB	0DAH			; German keyboard extra instruction, to skip LD A," "
C0FF1:	LD	A," "			; German keyboard extra instruction
J0FF5:	LD	B,0			; German keyboard extra instruction
        LD	DE,(KANAST)
        INC	E
        DEC	E			; DEAD key was pressed ?
        JR	Z,J0FC1			; nope, no DEAD + letter sequence, put keycode in keyboardbuffer and quit

;
;	The following code handles Dead key mode, but should never occure on the german keyboard
;
        LD	D,A
        OR	20H			; lowercase
        LD	HL,I1066+7-1
        LD	C,7
        CPDR
        LD	A,D
        JR	NZ,J0FC1		; not a vowel, no accent
        INC	HL
        LD	C,7
J100D:	ADD	HL,BC
        DEC	E
        JR	NZ,J100D		; to correct DEAD table
        LD	A,(HL)
        BIT	5,D			; upcase letter ?
        JR	NZ,J0FC1		; nope, put keycode in keyboardbuffer and quit
J1016:	LD	C,37
        LD	HL,I106D+37-1
        CPDR				; character with upcase variant ?
        JR	NZ,J0FC1		; nope, put keycode in keyboardbuffer and quit
        LD	C,37
        INC	HL
        ADD	HL,BC
        LD	A,(HL)			; upcase variant
        JR	J0FC1			; put keycode in keyboardbuffer and quit

;	Subroutine	K.HAND (not offical name)
;	Inputs		C = scancode
;	Outputs		________________________

K.HAND:	LD	A,C
        LD	HL,I0F1F
        JP	J10B7			; patch routine for dead key on german keyboard

J102D:	LD	D,HIGH C0F06		; it is assumed that all handlers are in the 0F00H-0FFFH area!
J102F:	CP	(HL)			; scancode handled by this entry ?
        INC	HL
        LD	E,(HL)			; handler (low byte)
        INC	HL
        PUSH	DE
        RET	C			; yep, continue in handler
        POP	DE
        JR	J102F			; next

;	Table		keycodes for easily converted keys
;	Remark		scancodes 030H-057H

I1038:	DEFB	00H,00H,00H,00H,00H,00H,00H,00H
        DEFB	00H,00H,1BH,09H,00H,08H,18H,0DH
        DEFB	20H,0CH,12H,7FH,1DH,1EH,1FH,1CH
        DEFB	2AH,2BH,2FH,30H,31H,32H,33H,34H
        DEFB	35H,36H,37H,38H,39H,2DH,2CH,2EH

;	Subroutine	reset DEAD status, next postition in keyboardbuffer with roundtrip
;	Inputs		-
;	Outputs		________________________

C1060:	XOR	A
        LD	(KANAST),A
        JR	C10C2

;	Table	valid DEAD letters

I1066:	DEFB	"a" ,"e" ,"i" ,"o" ,"u" ,"y" ," "

I106D:	DEFB	0A0H,082H,0A1H,0A2H,0A3H,079H,027H		; DEAD
        DEFB	085H,08AH,08DH,095H,097H,079H,060H		; SHIFT DEAD
        DEFB	083H,088H,08CH,093H,096H,079H,05EH		; CODE DEAD
        DEFB	084H,089H,08BH,094H,081H,098H,020H		; SHIFT CODE DEAD

        DEFB	0B1H,0B3H,0B5H,0B7H,0A4H,086H,087H,091H,0B9H	; accent vowels with upcase version

; upcase version of 0106D

        DEFB	"A" ,"E" ,"I" ,"O" ,"U" ,"Y" ,060H
        DEFB	"A" ,090H,"I" ,"O" ,"U" ,"Y" ,027H
        DEFB	"A" ,"E" ,"I" ,"O" ,"U" ,"Y" ,05EH
        DEFB	08EH,"E" ,"I" ,099H,09AH,"Y" ,020H

        DEFB	0B0H,0B2H,0B4H,0B6H,0A5H,08FH,080H,092H,0B8H

;	Patch		deadkey on german keyboard
;	Inputs		-
;	Outputs		________________________

J10B7:	CALL	H.KEYC
        CP	15H			; DEAD key (strange, key not on a german keyboard) ?
        JP	Z,C0F36			; yep, handle like CAPS key
        JP	J102D			; continue orginal code


        ORG	01B94H

        JR	J1BAC

;	Subroutine	handler DEAD key
;	Inputs		-
;	Outputs		________________________
;	Remark		never called, because DEAD key is already intercepted by patch J10B7

J1B96:	LD	A,(NEWKEY+6)
        LD	E,A
        OR	0FEH			; SHIFT key status (rest of bits 1)
        BIT	4,E
        JR	NZ,J1BA2		; CODE not pressed, use SHIFT
        AND	0FDH			; reset b1
J1BA2:	CPL
        INC	A
        LD	(KANAST),A		; set DEAD status (001H-004H)
        JP	J0F64			; make keyclick



        DEFS	01BABH-$,0

; *************************************
; END OF GERMAN KEYBOARD HANDLER
; *************************************
