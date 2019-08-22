; *************************************
; BEGIN OF UK KEYBOARD HANDLER
; *************************************

D0DA5:	DEFB	30H,31H,32H,33H,34H,35H,36H,37H
        DEFB	38H,39H,2DH,3DH,5CH,5BH,5DH,3BH
        DEFB	27H,60H,2CH,2EH,2FH,9CH,61H,62H
        DEFB	63H,64H,65H,66H,67H,68H,69H,6AH
        DEFB	6BH,6CH,6DH,6EH,6FH,70H,71H,72H
        DEFB	73H,74H,75H,76H,77H,78H,79H,7AH

        DEFB	29H,21H,40H,23H,24H,25H,5EH,26H
        DEFB	2AH,28H,5FH,2BH,7CH,7BH,7DH,3AH
        DEFB	22H,7EH,3CH,3EH,3FH,9CH,41H,42H
        DEFB	43H,44H,45H,46H,47H,48H,49H,4AH
        DEFB	4BH,4CH,4DH,4EH,4FH,50H,51H,52H
        DEFB	53H,54H,55H,56H,57H,58H,59H,5AH

        DEFB	09H,0ACH,0ABH,0BAH,0EFH,0BDH,0F4H,0FBH
        DEFB	0ECH,07H,17H,0F1H,1EH,01H,0DH,06H
        DEFB	05H,0BBH,0F3H,0F2H,1DH,9CH,0C4H,11H
        DEFB	0BCH,0C7H,0CDH,14H,15H,13H,0DCH,0C6H
        DEFB	0DDH,0C8H,0BH,1BH,0C2H,0DBH,0CCH,18H
        DEFB	0D2H,12H,0C0H,1AH,0CFH,1CH,19H,0FH

        DEFB	0AH,00H,0FDH,0FCH,00H,00H,0F5H,00H
        DEFB	00H,08H,1FH,0F0H,16H,02H,0EH,04H
        DEFB	03H,0F7H,0AEH,0AFH,0F6H,9CH,0FEH,00H
        DEFB	0FAH,0C1H,0CEH,0D4H,10H,0D6H,0DFH,0CAH
        DEFB	0DEH,0C9H,0CH,0D3H,0C3H,0D7H,0CBH,0A9H
        DEFB	0D1H,00H,0C5H,0D5H,0D0H,0F9H,0AAH,0F8H

        DEFB	0EBH,9FH,0D9H,0BFH,9BH,98H,0E0H,0E1H
        DEFB	0E7H,87H,0EEH,0E9H,9CH,0EDH,0DAH,0B7H
        DEFB	0B9H,0E5H,86H,0A6H,0A7H,9CH,84H,97H
        DEFB	8DH,8BH,8CH,94H,81H,0B1H,0A1H,91H
        DEFB	0B3H,0B5H,0E6H,0A4H,0A2H,0A3H,83H,93H
        DEFB	89H,96H,82H,95H,88H,8AH,0A0H,85H

        DEFB	0D8H,0ADH,9EH,0BEH,9CH,9DH,00H,00H
        DEFB	0E2H,80H,00H,00H,00H,0E8H,0EAH,0B6H
        DEFB	0B8H,0E4H,8FH,00H,0A8H,9CH,8EH,00H
        DEFB	00H,00H,00H,99H,9AH,0B0H,00H,92H
        DEFB	0B2H,0B4H,00H,0A5H,00H,0E3H,00H,00H
        DEFB	00H,00H,90H,00H,00H,00H,00H,00H

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
        LD	HL,D1033-030H
        ADD	HL,DE
        LD	A,(HL)
        AND	A			; keycode for key ?
        RET	Z			; nope, quit
        JR	C0F55			; put keycode in keyboardbuffer

;	Subroutine	handler DEAD key
;	Inputs		-
;	Outputs		________________________

J0F1F:	LD	A,(NEWKEY+6)
        LD	E,A
        OR	0FEH		; SHIFT key status (rest of bits 1)
        BIT	4,E
        JR	NZ,J0F2B	; CODE not pressed, use SHIFT
J0F29:	AND	0FDH		; reset b1
J0F2B:	CPL
        INC	A
        LD	(KANAST),A	; set DEAD status (001H-004H)
        JR	J0F64		; make keyclick

;
;	leftover from KANA keyhandler, not used
;

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
        CALL	C105B			; reset DEAD status, next postition in keyboardbuffer with roundtrip
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
        JR	NC,J0F9E		; CTRL pressed, ignore GRAPH and CODE key, use only SHIFT
        RRA
        RRA
        RLCA
        AND	03H			; GRAPH and SHIFT status
        BIT	1,A
        JR	NZ,J0FA0		; GRAPH pressed, ignore CODE key, use GRAPH and SHIFT
        BIT	4,E			; CODE pressed ?
        JR	NZ,J0FA0		; nope, no GRAPH, no CODE, use only SHIFT
        OR	04H			; flag CODE pressed
        DEFB	011H			; LD DE,xxxx
J0F9E:	AND	001H			; use only SHIFT
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
        JP	Z,J0F1F			; yep, handle dead key
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
        JR	Z,J0FF0			; nope, unchanged
        CP	"a"
        JR	C,J1011			; not a lowercase letter,
        CP	"z"+1
        JR	NC,J1011		; not a lowercase letter,
        AND	0DFH			; upcase
J0FF0:	LD	DE,(KANAST)
        INC	E
        DEC	E			; DEAD key was pressed ?
        JR	Z,J0FC1			; nope, no DEAD + letter sequence, put keycode in keyboardbuffer and quit
        LD	D,A
        OR	20H			; lowercase
        LD	HL,D1061+6-1
        LD	C,6
        CPDR				; valid DEAD letter ?
        LD	A,D
        JR	NZ,J0FC1		; nope, put keycode in keyboardbuffer and quit
        INC	HL
        LD	C,6
J1008:	ADD	HL,BC
        DEC	E
        JR	NZ,J1008		; to correct DEAD table
        LD	A,(HL)
        BIT	5,D			; upcase letter ?
        JR	NZ,J0FC1		; nope, put keycode in keyboardbuffer and quit
J1011:	LD	C,31
        LD	HL,D107F+01FH-1
        CPDR				; character with upcase variant ?
        JR	NZ,J0FC1		; nope, put keycode in keyboardbuffer and quit
        LD	C,31
        INC	HL
        ADD	HL,BC
        LD	A,(HL)			; upcase variant
        JR	J0FC1			; put keycode in keyboardbuffer and quit

;	Subroutine	K.HAND (not offical name)
;	Inputs		C = scancode
;	Outputs		________________________

K.HAND:	LD	A,C
        LD	HL,I1B97
        CALL	H.KEYC
        LD	D,HIGH C0F06		; it is assumed that all handlers are in the 0F00H-0FFFH area!
J102A:	CP	(HL)			; scancode handled by this entry ?
        INC	HL
        LD	E,(HL)			; handler (low byte)
        INC	HL
        PUSH	DE
        RET	C			; yep, continue in handler
        POP	DE
        JR	J102A			; next

;	Table		keycodes for easily converted keys
;	Remark		scancodes 030H-057H

D1033:	DEFB	00H,00H,00H,00H,00H,00H,00H,00H
        DEFB	00H,00H,1BH,09H,00H,08H,18H,0DH
        DEFB	20H,0CH,12H,7FH,1DH,1EH,1FH,1CH
        DEFB	00H,00H,00H,30H,31H,32H,33H,34H
        DEFB	35H,36H,37H,38H,39H,2DH,2CH,2EH

;	Subroutine	reset DEAD status, next postition in keyboardbuffer with roundtrip
;	Inputs		-
;	Outputs		________________________

C105B:	XOR	A
        LD	(KANAST),A		; reset DEAD status
        JR	C10C2			; next postition in keyboardbuffer with roundtrip

;	Table	valid DEAD letters

D1061:	DEFB	"a" ,"e", "i" ,"o" ,"u" ,"y"

;	Table	translation DEAD

        DEFB	085H,08AH,08DH,095H,097H,"y"

;	Table	translation DEAD+SHIFT

        DEFB	0A0H,082H,0A1H,0A2H,0A3H,"y"

;	Table	translation DEAD+CODE

        DEFB	083H,088H,08CH,093H,096H,"y"

;	Table	translation DEAD+CODE+SHIFT

        DEFB	084H,089H,08BH,094H,081H,098H

;	Table	accent characters with upcase

D107F:	DEFB	083H,088H,08CH,093H,096H,084H,089H,08BH
        DEFB	094H,081H,098H,0A0H,082H,0A1H,0A2H,0A3H
        DEFB	085H,08AH,08DH,095H,097H,0B1H,0B3H,0B5H
        DEFB	0B7H,0A4H,086H,087H,091H,0B9H,"y"

;	Table	translation accent characters with upcase

D109E:	DEFB	"A" ,"E" ,"I" ,"O" ,"U" ,08EH,"E" ,"I"
        DEFB	099H,09AH,"Y" ,"A" ,090H,"I" ,"O" ,"U"
        DEFB	"A" ,"E" ,"I" ,"O" ,"U" ,0B0H,0B2H,0B4H
        DEFB	0B6H,0A5H,08FH,080H,092H,0B8H,"Y"

        DEFS	010C2H-$,0


        ORG	01B94H

        JP	J1BAC

I$1B97:	DEFB	030H,LOW C0F83		; scancodes 000H-02FH
        DEFB	033H,LOW C0F10		; SHIFT,CTRL,GRAPH
        DEFB	034H,LOW C0F36		; CAPS
        DEFB	035H,LOW C0F10		; CODE
        DEFB	03AH,LOW C0FC3		; F1,F2,F3,F4,F5
        DEFB	03CH,LOW C0F10		; ESC,TAB
        DEFB	03DH,LOW C0F46		; STOP
        DEFB	041H,LOW C0F10		; BS,SELECT,RETURN,SPACE
        DEFB	042H,LOW C0F06		; HOME
        DEFB	0FFH,LOW C0F10		; ins,del,left,up,down,right, numeric pad

; *************************************
; END OF UK KEYBOARD HANDLER
; *************************************

