; *************************************
; BEGIN OF KOREAN KEYBOARD HANDLER
; *************************************
;
J01A4	EQU	01A4H		; call hangul rom
C141F	EQU	141FH		; path
J63E6	EQU	63E6H		; execute STOP statement
C7B3E	EQU	7B3EH		; patch routine for extra pad numbers

;	Table		scancode table
;	Remark		last scancode+1,execution address

I0DA5:	DEFB	0AH
        DEFW	C0E67		; keys 0,1,2,3,4,5,6,7,8,9
        DEFB	16H
        DEFW	C0EA1		; keys -,^,yen,@,[,;,:,],komma,.,/,_
        DEFB	30H
        DEFW	C0E7E		; keys a,b,c,d,e,f,g,h,i,j,k,l,m,n,o,p,q,r,s,t,u,v,w,x,y,z
        DEFB	33H
        DEFW	C0F10		; keys shift,ctrl,graph
        DEFB	34H
        DEFW	C0F36		; key caps
        DEFB	35H
        DEFB	C0F1F		; key kana
        DEFB	3AH
        DEFW	C1438		; keys f1,f2,f3,f4,f5
        DEFB	3CH
        DEFW	C0F10		; keys esc,tab
        DEFB	3DH
        DEFW	C0F46		; key stop
        DEFB	41H
        DEFW	C0F10		; keys bs,select,return,space
        DEFB	42H
        DEFW	C0F06		; home
        DEFB	0FFH
        DEFW	C0F10		; ins,del,left,up,down,right, numeric pad

;	Table		keycodes for numeric keys+SHIFT

I0DC9:	DEFB	0FFH,021H,022H,023H,024H,025H,026H,027H
        DEFB	028H,029H

;	Table		pointer to handler for keys a-z

I0DD3:	DEFW	C0F55H		; SHIFT + CTRL
        DEFW	C0F55H		; CTRL
        DEFW	C0E93H		; SHIFT
        DEFW	C0E95H		; normal


; - ^ yen @ [ ; : ] komma . / _ table

I0DDB:	DEFW	D0E07H-10
        DEFW	D0DFBH-10
        DEFW	D0DEFH-10
        DEFW	D0DE3H-10

;	Table		keycodes for keys -,^,yen,@,[,;,:,],komma,.,/,_

D0DE3:	DEFB	2DH,5EH,5CH,40H,5BH,3BH,3AH,5DH,2CH,2EH,2FH,0FFH

;	Table		keycodes for keys -,^,yen,@,[,;,:,],komma,.,/,_ +SHIFT

D0DEF:	DEFB	3DH,7EH,7CH,60H,7BH,2BH,2AH,7DH,3CH,3EH,3FH,5FH

;	Table		keycodes for keys -,^,yen,@,[,;,:,],komma,.,/,_ +CTRL 

D0DFB:	DEFB	2DH,1EH,1CH,00H,1BH,3BH,3AH,1DH,2CH,2EH,2FH,0FFH

;	Table		keycodes for keys -,^,yen,@,[,;,:,],komma,.,/,_ +CTRL+SHIFT 

D0E07:	DEFB	3DH,1EH,1CH,00H,1BH,2BH,2AH,1DH,3CH,3EH,3FH,1FH

;	Table		keycodes for easily converted keys
;	Remark		scancodes 030H-057H

I0E13:	DEFB	000H,000H,000H,000H,000H,000H,000H,000H
        DEFB	000H,000H,01BH,009H,000H,008H,018H,00DH
        DEFB	020H,00CH,012H,07FH,01DH,01EH,01FH,01CH
        DEFB	02AH,02BH,02FH,030H,031H,032H,033H,034H
        DEFB	035H,036H,037H,038H,039H,02DH,02CH,02EH

;	Subroutine	K.HAND (not offical name)
;	Inputs		C = scancode
;	Outputs		________________________

K.HAND:	LD	A,C
        CP	0FFH
        RET	Z			; scancode 0FFH, quit
        LD	HL,I0DA5
        CALL	H.KEYC
        CP	30H
        JR	NC,J0E5C		; scancodes 030H-0FEH are handled directly
        LD	A,(NEWKEY+6)
        RRCA	
        RRCA	
        JR	NC,J0E5B		; CTRL pressed, handle directly
        RRCA	
        JP	NC,J107D		; GRAPH pressed, handle graphic keycodes
        LD	A,(KANAST)
        AND	A
        JP	NZ,J0F83		; KANA on, handle kana keycodes
J0E5B:	LD	A,C
J0E5C:	CP	(HL)			; scancode handled by this entry ?
        INC	HL
        LD	E,(HL)
        INC	HL
        LD	D,(HL)			; handler
        INC	HL
        PUSH	DE
        RET	C			; yep, continue in handler
        POP	DE
        JR	J0E5C			; next

;	Subroutine	handler keys 0,1,2,3,4,5,6,7,8,9
;	Inputs		A = C = scancode (000H-009H)
;	Outputs		________________________

C0E67:	ADD	A,"0"
        LD	B,A			; keycode number
        LD	A,(NEWKEY+6)
        RRCA				; SHIFT pressed ?
        LD	A,B
        JR	C,J0E7B			; no, put keycode in keyboardbuffer and quit
        LD	B,0
        LD	HL,I0DC9
        ADD	HL,BC
        LD	A,(HL)
        CP	0FFH			; keycode for this combination ?
        RET	Z			; nope, quit
J0E7B:	JP	C0F55			; put in keyboardbuffer and quit

;	Subroutine	handler keys a-z
;	Inputs		C = scancode (016H-02FH)
;	Outputs		________________________

C0E7E:	LD	A,(NEWKEY+6)
        AND	03H			; SHIFT + CTRL status
        ADD	A,A
        LD	E,A
        LD	D,0
        LD	HL,I0DD3
        ADD	HL,DE
        LD	A,(HL)
        INC	HL
        LD	H,(HL)
        LD	L,A			; handler for SHIFT + CTRL combination
        LD	A,C			; scancode
        SUB	15H			; code 001H-01AH
        JP	(HL)

;	Subroutine	handler keys a-z, SHIFT pressed, CTRL not pressed
;	Inputs		A = lettercode (001H-01AH)
;	Outputs		________________________

C0E93:	ADD	A,20H			; adjust for lowercase

;	Subroutine	handler keys a-z, SHIFT and CTRL not pressed
;	Inputs		A = lettercode (001H-01AH)
;	Outputs		________________________

C0E95:	LD	B,A
        LD	A,(CAPST)
        CPL	
        AND	20H			; CAPS lock ?
        XOR	B			; yep, switch case; nope, keep case
        ADD	A,40H			; to keycode
        JR	J0E7B			; put in keyboardbuffer and quit

;	Subroutine	handler keys -,^,yen,@,[,;,:,],komma,.,/,_
;	Inputs		C = scancode (00AH-015H)
;	Outputs		________________________

C0EA1:	LD	HL,I0DDB
        LD	A,(NEWKEY+6)
        AND	03H			; SHIFT + CTRL status
        ADD	A,A
        LD	E,A
        LD	D,0
        ADD	HL,DE
        LD	A,(HL)
        INC	HL
        LD	H,(HL)
        LD	L,A			; keycode table for SHIFT + CTRL combination
        LD	E,C			; scancode
        ADD	HL,DE
        LD	A,(HL)
        CP	0FFH			; keycode for this combination ?
        JP	NZ,C0F55		; yep, put in keyboardbuffer
        RET

;	Subroutine	handler functionkeys
;	Inputs		C = scancode (035H-039H)
;	Outputs		________________________

C0EBB:	LD	A,(NEWKEY+6)
        RRCA				; SHIFT key pressed ?
        JR	C,J0EC5			; nope, F1-F5
        LD	A,C
        ADD	A,5
        LD	C,A			; yep, F6-F10
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
I0EDD:	CALL	C0F55			; put keycode in keyboardbuffer
        INC	DE
        JR	J0EDA			; next

J0EE3:	LD	HL,(CURLIN)
        INC	HL
        LD	A,H
        OR	L			; interpreter in direct mode ?
        JR	Z,J0ED0			; yep, normal behavior
        LD	HL,TRPTBL+0*3-035H*3
        ADD	HL,DE
        ADD	HL,DE
        ADD	HL,DE

;	  Subroutine raise trap
;	     Inputs  ________________________
;	     Outputs ________________________

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

C0F06:	LD	A,(NEWKEY+6)
        RRCA				; SHIFT key status
        LD	A,0CH			; assume SHIFT-HOME -> CLS keycode
        SBC	A,0			; no SHIFT pressed -> HOME keycode
        JR	C0F55			; put keycode in keyboardbuffer

;	Subroutine	handler easily converted keys
;	Inputs		A = scancode (030H-015H)
;	Outputs		________________________

C0F10:	CALL	H.KEYA
        LD	E,A
        LD	D,0
        LD	HL,D0E13-030H
        ADD	HL,DE
        LD	A,(HL)
        AND	A			; keycode for key ?
        RET	Z			; nope, quit
        JR	C0F55			; put keycode in keyboardbuffer


;	  Subroutine handler KANA key
;	     Inputs  ________________________
;	     Outputs ________________________

C0F1F:	LD	HL,KANAST
        LD	A,(HL)
        CPL	
        LD	(HL),A
        LD	A,0FH
        OUT	(0A0H),A
        IN	A,(0A2H)
        AND	7FH
        LD	B,A
        LD	A,(HL)
        CPL	
        AND	80H
        OR	B
        OUT	(0A1H),A
        RET
        
;	Subroutine	handler CAPS key
;	Inputs		-
;	Outputs		________________________

C0F36:	LD	HL,CAPST
        LD	A,(HL)
        CPL
        LD	(HL),A			; toggle CAPS status
        CPL				; adjust for CHGCAP and change CAPS led

;	Subroutine	CHGCAP
;	Inputs		________________________
;	Outputs		________________________
;	Remark		entrypoint compatible with MSX1

K.BCAP:	AND	A
        LD	A,0CH
        JR	Z,J0F43
        INC	A
J0F43:	OUT	(0ABH),A
        RET	

;	Subroutine	handler STOP key
;	Inputs		-
;	Outputs		________________________
;	Remark		entrypoint compatible with MSX1

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
;	Remark		entrypoint compatible with MSX1

C0F55:	LD	HL,(PUTPNT)
        LD	(HL),A
        CALL	C10C2
        LD	A,(GETPNT)
        CP	L
        RET	Z
        LD	(PUTPNT),HL

;	Subroutine	make keyclick
;	Inputs		-
;	Outputs		________________________
;	Remark		entrypoint compatible with MSX1

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
;	Remark		entrypoint compatible with MSX1

K.BSND:	AND	A
        LD	A,0EH
        JR	Z,J0F80
        INC	A
J0F80:	OUT	(0ABH),A
        RET

;	Subroutine	handle scancodes when KANA is on (and GRAPH and CTRL are not pressed)
;	Inputs		C = scancode (000H-02FH)
;	Outputs		________________________

J0F83:	LD	A,(NEWKEY+6)
        RRCA				; SHIFT key status in Cx
        LD	HL,I0FA6
        JR	C,J0F8F			; SHIFT not pressed, use normal layout
        LD	HL,I0FD6		; use shift layout
J0F8F:	LD	B,0
        ADD	HL,BC
        LD	A,(HL)			; has keycode ?
        AND	A
        RET	Z			; nope, quit
        JP	C0F55			; put in keyboard buffer

;	Patch		for STOP korean
;	Inputs		
;	Outputs		________________________

J0F98:	PUSH	HL
        CALL	C141F			; patch routine
        POP	HL
        XOR	A
        LD	SP,(SAVSTK)
        PUSH	BC
        JP	J63E6

;	Table		layout, without SHIFT (based on CAPS on)

I0FA6:	DEFB	30H,31H,32H,33H,34H,35H,36H,37H
        DEFB	38H,39H,2DH,5EH,5CH,40H,5BH,3BH
        DEFB	3AH,5DH,2CH,2EH,2FH,00H,8CH,0A4H
        DEFB	94H,91H,89H,8BH,98H,0A1H,9BH,9DH
        DEFB	99H,0A6H,0A5H,0A3H,9AH,9EH,8DH,86H
        DEFB	88H,8FH,9FH,97H,92H,96H,0A2H,95H

;	Table		layout, with SHIFT (based on CAPS on)

I0FD6:	DEFB	00H,21H,22H,23H,24H,25H,26H,27H
        DEFB	28H,29H,3DH,7EH,7CH,60H,7BH,2BH
        DEFB	2AH,7DH,3CH,3EH,3FH,5FH,00H,00H
        DEFB	00H,00H,8AH,00H,00H,00H,00H,00H
        DEFB	00H,00H,00H,00H,9CH,0A0H,8EH,87H
        DEFB	00H,90H,00H,00H,93H,00H,00H,00H

;	Subroutine	korean BIOS routine 0186H
;	Inputs		
;	Outputs		________________________

J1006:	CALL	C1070			; hangul rom available ?
        RET	Z			; nope, quit
        PUSH	IX
        LD	IX,04023H
        JR	J103C

;	Subroutine	korean BIOS routine 0189H
;	Inputs		
;	Outputs		________________________

J1012:	CALL	C1070			; hangul rom available ?
        RET	Z			; nope, quit
        PUSH	IX
        LD	IX,04026H
        JR	J103C

;	Subroutine	korean BIOS routine 018CH
;	Inputs		
;	Outputs		________________________

J101E:	CALL	C1070			; hangul rom available ?
        RET	Z			; nope, quit
        PUSH	IX
        LD	IX,04032H
        JR	J103C

;	Subroutine	korean BIOS routine 018FH
;	Inputs		
;	Outputs		________________________

J102A:	CALL	C1070			; hangul rom available ?
        RET	Z			; nope, quit
        PUSH	IX
        LD	IX,0402CH
        JR	J103C

;	Subroutine	korean BIOS routine 0192H
;	Inputs		
;	Outputs		________________________

J1036:	PUSH	IX
        LD	IX,04029H
J103C:	JP	J01A4

;	Patch		for reading mouse/lightpen switch
;	Inputs		
;	Outputs		________________________
;	Remark		korean does this via V9948 VDP

J103F:	LD	A,1
        DI	
        OUT	(99H),A
        LD	A,8FH
        OUT	(99H),A			; VDP(15)=1
        IN	A,(99H)			: status register
        PUSH	AF
        XOR	A
        OUT	(99H),A
        LD	A,8FH
        OUT	(99H),A			; VDP(15)=0
        POP	AF
        BIT	7,A			; FL (mouse/lightpen switch)
        JR	Z,J105C
        LD	HL,XSAVE+1
        SET	7,(HL)
J105C:	IN	A,(99H)
        AND	A
        RET	

;	Patch		for PAD function
;	Inputs		
;	Outputs		________________________
;	Remark		for korean lightpen

J1060:	CP	14H			; pad 20 or above ?
        JR	NC,J1068		; yep, handle differently
J1064:	CALL	C7B3E			; patch routine for extra pad numbers
        RET	

J1068:	CP	18H			; pad 24 or above ?
        JR	NC,J1064		; yep, handle normaly
        SUB	0CH			; range 20-23 = range 8-11 (lightpen)
        JR	J1064

;	  Subroutine hangul rom available ?
;	     Inputs  ________________________
;	     Outputs ________________________

C1070:	PUSH	BC
        LD	B,A
        LD	A,(SLTWRK+4)		; slotid hangul rom
        CP	0
        LD	A,B
        POP	BC
        RET	

        DEFS	0107DH-$,0		; unused space

;	Subroutine	handle scancodes 000H-02FH with GRAPH key pressed
;	Inputs		C = scancode
;	Outputs		________________________

J107D:	LD	B,0
        LD	HL,I1092
        ADD	HL,BC
        LD	A,(HL)			; keycode
        AND	A
        RET	Z			; no keycode, quit
        CP	80H			; keycodes 001H-7FH ?
        PUSH	AF
        LD	A,1
        CALL	C,C0F55			; yep, put MSX header keycode in keyboard buffer
        POP	AF
        JP	C0F55			; put keycode in keyboard buffer

;	Table		keycodes for scancodes 000H-02FH with GRAPH pressed
;	000H		no keycode
;	001H-07FH	keycode 1 + keycode (special MSX graphic character)
;	080H-0FFH	keycode

I1092:	DEFB	00H,00H,00H,00H,00H,00H,00H,00H
        DEFB	00H,00H,57H,00H,00H,00H,84H,82H
        DEFB	81H,85H,00H,00H,80H,83H,00H,5BH
        DEFB	5AH,54H,58H,55H,53H,00H,56H,00H
        DEFB	00H,00H,00H,00H,00H,50H,00H,52H
        DEFB	00H,59H,00H,51H,00H,5CH,00H,00H

; *************************************
; END OF KOREAN KEYBOARD HANDLER
; *************************************
