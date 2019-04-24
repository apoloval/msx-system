; OPTROM.ASM

; MSX Option ROM, displays opening screen

; Added initialization msx2+ upgrade cartridge

; Source re-created by Z80DIS 2.2
; Z80DIS was written by Kenneth Gielow, Palo Alto, CA

; Code Copyrighted by ASCII and maybe others
; Source comments by Arjen Zeilemaker

; Sourcecode supplied for STUDY ONLY
; Recreation NOT permitted without authorisation of the copyrightholders

RDSLT		EQU	000CH
SNSMAT		EQU	0141H

BOTTOM		EQU	0FC48H
EXPTBL		EQU	0FCC1H
SLTTBL		EQU	0FCC5H
D.FFFF		EQU	0FFFFH	; secundary slotreg

        INCLUDE	MSX.INC

        .Z80
        ASEG
        ORG	4000H

        DEFB	"AB"
        DEFW	P_INIT
        DEFW	0
        DEFW	0
        DEFW	0
        DEFS	6,0

P_INIT:
        LD	A,8
        CALL	SNSMAT
        BIT	3,A			; DEL key pressed ?
        RET	Z			; yep, quit
        LD	HL,(BOTTOM)
        LD	DE,8000H
        RST	20H			; at least 32 KB RAM ?
        RET	NZ			; nope, quit init
        LD	HL,EXPTBL+0
        LD	A,(HL)
        ADD	A,A			; other MSXUP already initialized ?
        RET	NZ			; yep, quit init
        DI
        IN	A,(0A8H)
        AND	0CH			; my primairy slot
        RRCA
        RRCA
        LD	B,A
        SET	7,B			; slotid mainrom msx2+up
        ADD	A,L
        LD	L,A
        LD	A,(HL)
        RLCA				; my primairy slot is expanded ?
        RET	NC			; nope, no msx2+up, quit
        INC	L
        INC	L
        INC	L
        INC	L
        LD	A,(HL)
        AND	0CH
        RRCA
        RRCA
        DEC	A			; my secundairy slot is 1 ?
        RET	NZ			; nope, no msx2+up, quit

; check mainrom page 0
        LD	HL,0
        CALL	P_GTW
        LD	A,0F3H
        CP	E
        RET	NZ
        LD	A,0C3H
        CP	D
        RET	NZ

; check mainrom page 1
        LD	HL,07ED8H
        CALL	P_GTW
        LD	A,"M"
        CP	E
        RET	NZ
        LD	A,"S"
        CP	D
        RET	NZ

; check subrom page 0
        SET	2,B
        LD	HL,0
        CALL	P_GTW
        LD	A,"C"
        CP	E
        RET	NZ
        LD	A,"D"
        CP	D
        RET	NZ

; invoke msx2+up

        IF	VDP.DRW NE 098H

        LD	A,(RG1SAV)
        AND	0DFH			; clear IE bit
        OUT	(99H),A
        LD	A,81H
        OUT	(99H),A			; disable interrupts from MSX1 VDP (TMS9918)
        EX	(SP),HL
        EX	(SP),HL
        IN	A,(99H)			; clear pending interrupts MSX1 VDP

        ENDIF

        RES	2,B
        LD	A,B
        LD	(EXPTBL+0),A
        LD	HL,P_START
        LD	DE,08100H
        LD	BC,P_END-P_START
        LDIR
        LD	B,A
        RES	7,B
        JP	08100H

P_GTW:	CALL	P_GTB			; read byte from extension ROM
        LD	E,D
P_GTB:	LD	A,B
        PUSH	BC
        PUSH	DE
        CALL	RDSLT
        POP	DE
        POP	BC
        LD	D,A
        INC	HL
        RET

P_START:
        .PHASE	08100H

        LD	A,B
        ADD	A,A
        ADD	A,A
        ADD	A,B
        LD	C,A			; 0000pppp
        ADD	A,A
        ADD	A,A
        ADD	A,B
        RRCA
        RRCA
        LD	B,A			; pp00pppp
        IN	A,(0A8H)
        LD	D,A			; save primairy slot register
        AND	030H
        OR	B
        OUT	(0A8H),A
        LD	A,(D.FFFF)
        CPL
        AND	0F0H
        LD	(D.FFFF),A		; enable secundairy slot 0 in page 0 and 1
        LD	E,A
        LD	A,D
        AND	0F0H
        OR	C
        OUT	(0A8H),A		; enable mainrom in page 0 and 1
        LD	A,C
        AND	003H
        ADD	A,LOW SLTTBL
        LD	L,A
        LD	H,HIGH SLTTBL
        LD	(HL),E			; update SLTTBL with secundairy slot register
        JP	00000H

        .DEPHASE
P_END:


        DEFS	OPTENT-$,0

C7A00:	DI
        CALL	C7ADA
        CALL	C7A09
        EI
        RET


;	  Subroutine __________________________
;	     Inputs  ________________________
;	     Outputs ________________________

C7A09:	LD	HL,00FFH
        CALL	C7A9F
        LD	E,H
        LD	D,26
        CALL	C7BA9			; write vdp register
        LD	E,L
        LD	D,27
        CALL	C7BA9			; write vdp register
        CALL	C7A83			; wait for passed VR
        LD	DE,0163H
        CALL	C7BA9			; write vdp register
        LD	HL,00E1H
        LD	DE,-10
J7A2A:	INC	DE
        LD	B,5
J7A2D:	PUSH	BC
        PUSH	DE
        CALL	C7A48
        POP	DE
        POP	BC
        ADD	HL,DE
        DJNZ	J7A2D
        LD	A,E
        OR	A
        JR	NZ,J7A2A
        LD	DE,1900H
        CALL	C7BA9			; write vdp register
        LD	DE,021FH
        CALL	C7BA9			; write vdp register
        RET


;	  Subroutine __________________________
;	     Inputs  ________________________
;	     Outputs ________________________

C7A48:	PUSH	HL
        CALL	C7A83			; wait for passed VR
        XOR	A
        SUB	L
        LD	E,A
        LD	A,02H
        SBC	A,H
        LD	D,A
        CALL	C7A9F
        EX	DE,HL
        CALL	C7A9F
        LD	BC,5500H+VDP.CIW
J7A5D:	LD	A,1AH
        OUT	(VDP.CW),A
        LD	A,91H
        OUT	(VDP.CW),A
        EX	DE,HL
        IN	A,(VDP.SR)
J7A68:	IN	A,(VDP.SR)
        AND	20H
        JP	Z,J7A68
        OUT	(C),H
        OUT	(C),L
        DJNZ	J7A5D
        POP	HL
        LD	DE,1A00H
        CALL	C7BA9			; write vdp register
        LD	DE,1B00H
        CALL	C7BA9			; write vdp register
        RET


;	  Subroutine wait for passed VR
;	     Inputs  ________________________
;	     Outputs ________________________

C7A83:	LD	A,02H
        OUT	(VDP.CW),A
        LD	A,8FH
        OUT	(VDP.CW),A
J7A8B:	IN	A,(VDP.SR)
        AND	40H
        JR	Z,J7A8B
J7A91:	IN	A,(VDP.SR)
        AND	40H
        JR	NZ,J7A91
        XOR	A
        OUT	(VDP.CW),A
        LD	A,8FH
        OUT	(VDP.CW),A
        RET


;	  Subroutine __________________________
;	     Inputs  ________________________
;	     Outputs ________________________

C7A9F:	DEC	HL
        LD	A,L
        SRL	H
        RRA
        RRCA
        RRCA
        INC	A
        AND	3FH
        LD	H,A
        INC	L
        LD	A,L
        NEG
        AND	07H
        LD	L,A
        RET

I7AB2:	DEFB	1CH,0E8H,00H,00H,1CH,0E8H,00H,00H
        DEFB	3CH,0E8H,00H,00H,3CH,0E8H,00H,00H
        DEFB	5CH,0E8H,00H,00H,5CH,0E8H,00H,00H
        DEFB	1CH,00H,04H,00H,3CH,00H,04H,00H
        DEFB	5CH,00H,04H,00H,0D8H,00H,00H,00H


;	  Subroutine __________________________
;	     Inputs  ________________________
;	     Outputs ________________________

C7ADA:	CALL	C7A83			; wait for passed VR
        LD	DE,0123H
        CALL	C7BA9			; write vdp register
        CALL	C7C85
        LD	A,55H
        LD	HL,0
        LD	C,L
        LD	B,L
        CALL	C7BD2			; fill vram
        CALL	C7C3E
        LD	DE,0705H
        CALL	C7BA9			; write vdp register
        LD	HL,07800H
        LD	BC,48
        LD	A,0FFH
        CALL	C7BD2			; fill vram
        LD	HL,07830H
        LD	BC,16
        LD	A,0F0H
        CALL	C7BD2			; fill vram
        LD	HL,07400H
        LD	A,05H
        LD	BC,512
        CALL	C7BD2			; fill vram
        LD	HL,I7AB2
        LD	DE,07600H
        LD	BC,40
        CALL	C7BE5			; transfer to vram
        LD	DE,1903H
        CALL	C7BA9			; write vdp register
        LD	DE,023FH
        CALL	C7BA9			; write vdp register
        LD	DE,2D00H
        CALL	C7BA9			; write vdp register
        LD	D,2AH
        CALL	C7BA9			; write vdp register
        INC	D
        CALL	C7BA9			; write vdp register
        LD	D,27H
        CALL	C7BA9			; write vdp register
        LD	E,20H
        LD	HL,I7D3B
        EXX
        LD	HL,I7CB4
        EXX
J7B50:	LD	A,03H
        PUSH	AF
        LD	BC,002DH
        LD	D,26H
        CALL	C7BA9			; write vdp register
        EXX
        LD	B,08H
        LD	C,(HL)
        INC	HL
        EXX
J7B61:	CALL	C7C18
        LD	A,(HL)
        INC	HL
        CP	0FEH
        JR	Z,J7BA1
        PUSH	HL
        PUSH	BC
        LD	BC,01A6H
        JR	NC,J7B74
        LD	B,0
        LD	C,A
J7B74:	CALL	C7C14
        POP	HL
        ADD	HL,BC
        LD	C,L
        LD	B,H
        POP	HL
        POP	AF
        XOR	03H	; 3
        CALL	C7C23
        PUSH	AF
        CALL	C7C2C
        EXX
        SLA	C
        DJNZ	J7B8F
        LD	B,08H	; 8
        LD	C,(HL)
        INC	HL
J7B8F:	EXX
        JR	NC,J7B61
        DEC	BC
        CALL	C7C18
        INC	BC
        LD	A,02H	; 2
        CALL	C7C23
        CALL	C7C39
        JR	J7B61

J7BA1:	INC	E
        POP	AF
        LD	A,(HL)
        CP	0FEH
        JR	NZ,J7B50
        RET


;	  Subroutine write vdp register
;	     Inputs  ________________________
;	     Outputs ________________________

C7BA9:	PUSH	AF
        LD	A,E
        OUT	(VDP.CW),A
        LD	A,D
        OR	80H
        OUT	(VDP.CW),A
        POP	AF
        RET


;	  Subroutine wait for vdp command completion
;	     Inputs  ________________________
;	     Outputs ________________________

C7BB4:	LD	A,2
        CALL	C7BBE			; read vdp statusregister
        RRCA				; CE still set (command still executing) ?
        JR	C,C7BB4			; yep, wait
        RLCA
        RET


;	  Subroutine read vdp statusregister
;	     Inputs  ________________________
;	     Outputs ________________________

C7BBE:	OUT	(VDP.CW),A
        LD	A,8FH
        OUT	(VDP.CW),A
        PUSH	HL
        POP	HL
        IN	A,(VDP.SR)
        PUSH	AF
        XOR	A
        OUT	(VDP.CW),A
        LD	A,8FH
        OUT	(VDP.CW),A
        POP	AF
        RET


;	  Subroutine fill vram
;	     Inputs  ________________________
;	     Outputs ________________________

C7BD2:	PUSH	AF
        CALL	C7BFA			; setup vdp for VRAM writing
        LD	A,C
        OR	A			; low byte zero ?
        JR	Z,J7BDB
        INC	B
J7BDB:	POP	AF
J7BDC:	OUT	(VDP.DRW),A
        DEC	C
        JP	NZ,J7BDC
        DJNZ	J7BDC
        RET


;	  Subroutine transfer to vram
;	     Inputs  ________________________
;	     Outputs ________________________

C7BE5:	EX	DE,HL
        CALL	C7BFA			; setup vdp for VRAM writing
        EX	DE,HL
        LD	A,C
        OR	A			; low byte zero ?
        LD	A,B
        LD	B,C
        LD	C,VDP.DRW
        JR	Z,J7BF3
        INC	A			; nope,
J7BF3:	OTIR
        DEC	A
        JR	NZ,J7BF3
        EX	DE,HL
        RET


;	  Subroutine setup vdp for VRAM writing
;	     Inputs  ________________________
;	     Outputs ________________________

C7BFA:	LD	A,H
        AND	3FH
        OR	40H
        EX	AF,AF'
        LD	A,H
        AND	0C0H
        RLCA
        RLCA
        OUT	(VDP.CW),A
        LD	A,8EH
        OUT	(VDP.CW),A
        LD	A,L
        OUT	(VDP.CW),A
        EX	AF,AF'
        OUT	(VDP.CW),A
        EX	(SP),HL
        EX	(SP),HL
        RET


;	  Subroutine __________________________
;	     Inputs  ________________________
;	     Outputs ________________________

C7C14:	LD	D,28H
        JR	J7C1A


;	  Subroutine __________________________
;	     Inputs  ________________________
;	     Outputs ________________________

C7C18:	LD	D,24H
J7C1A:	PUSH	DE
        LD	E,C
        CALL	C7BA9			; write vdp register
        LD	E,B
        INC	D
        JR	J7C27


;	  Subroutine __________________________
;	     Inputs  ________________________
;	     Outputs ________________________

C7C23:	PUSH	DE
        LD	E,A
        LD	D,2CH
J7C27:	CALL	C7BA9			; write vdp register
        POP	DE
        RET


;	  Subroutine __________________________
;	     Inputs  ________________________
;	     Outputs ________________________

C7C2C:	PUSH	DE
        LD	E,70H
J7C2F:	LD	D,2EH
        CALL	C7BA9			; write vdp register
        CALL	C7BB4			; wait for vdp command completion
        POP	DE
        RET


;	  Subroutine __________________________
;	     Inputs  ________________________
;	     Outputs ________________________

C7C39:	PUSH	DE
        LD	E,50H
        JR	J7C2F


;	  Subroutine __________________________
;	     Inputs  ________________________
;	     Outputs ________________________

C7C3E:
        IFDEF	RTCENA
        LD	A,0DH
        OUT	(0B4H),A
        IN	A,(0B5H)
        AND	0CH
        OR	02H
        OUT	(0B5H),A
        LD	A,0BH
        OUT	(0B4H),A
        IN	A,(0B5H)
        RLCA
        RLCA
        AND	0CH

        ELSE

        XOR	A

        ENDIF

        LD	C,A
        LD	B,00H
        LD	HL,I7CA4
        ADD	HL,BC
        LD	C,(HL)
        INC	HL
        LD	B,(HL)
        PUSH	BC
        INC	HL
        LD	E,(HL)
        INC	HL
        LD	D,(HL)
        EX	DE,HL
        LD	DE,1000H
        CALL	C7BA9			; write vdp register
        CALL	C7C7A			; write pallette color 0
        POP	HL
        CALL	C7C7A			; write pallette color 1
        LD	HL,0444H
        CALL	C7C7A			; write pallette color 2
        LD	HL,0777H
                                        ; write pallette color 3

;	  Subroutine write pallette
;	     Inputs  ________________________
;	     Outputs ________________________

C7C7A:	PUSH	BC
        LD	C,VDP.PRW
        OUT	(C),L
        EX	(SP),HL
        EX	(SP),HL
        OUT	(C),H
        POP	BC
        RET


;	  Subroutine __________________________
;	     Inputs  ________________________
;	     Outputs ________________________

C7C85:	LD	B,8
        LD	HL,I7C94
J7C8A:	LD	D,(HL)
        INC	HL
        LD	E,(HL)
        INC	HL
        CALL	C7BA9			; write vdp register
        DJNZ	J7C8A
        RET

I7C94:	DEFB	0,08H
        DEFB	1,23H
        DEFB	8,28H

        IF	INTHZ EQ 60

        DEFB	9,00H

        ELSE

        DEFB	9,02H

        ENDIF

        DEFB	2,1FH
        DEFB	5,0EFH
        DEFB	11,00H
        DEFB	6,0FH

I7CA4:	DEFB	07H,00H,00H,00H,20H,04H,27H,02H
        DEFB	72H,02H,56H,00H,70H,05H,70H,00H

I7CB4:	DEFB	00H,00H,00H,00H,00H,00H,00H,00H
        DEFB	00H,6EH,00H,9FH,00H,6FH,00H,9FH
        DEFB	00H,6FH,00H,9FH,00H,6FH,00H,9FH
        DEFB	00H,6FH,00H,9FH,00H,6FH,00H,9FH
        DEFB	00H,6FH,00H,0FFH,00H,07H,00H,0FCH
        DEFB	07H,00H,0F7H,00H,07H,00H,0F3H,00H
        DEFB	07H,00H,0F7H,00H,07H,00H,0FFH,00H
        DEFB	07H,00H,0FFH,00H,0FH,00H,0FCH,3CH
        DEFB	0FCH,3CH,0FCH,3CH,87H,0C0H,7BH,0C0H
        DEFB	87H,0C0H,7BH,0C0H,86H,0C0H,7BH,0C0H
        DEFB	86H,0C0H,7AH,0C0H,86H,0C0H,78H,0C0H
        DEFB	86H,90H,7AH,0F0H,86H,0F0H,7FH,0C0H
        DEFB	83H,0C0H,7FH,0C0H,0D7H,0C0H,2FH,0C0H
        DEFB	0D7H,0C0H,2FH,0C0H,0D7H,0C0H,2FH,0C0H
        DEFB	0D7H,0C0H,2FH,0C0H,0D7H,0C0H,2FH,0C0H
        DEFB	0D7H,0C0H,2FH,0C0H,0D5H,80H,00H,00H
        DEFB	00H,00H,00H,00H,00H,00H,00H
I7D3B:	DEFB	0FFH
        DEFB	0FEH,0FFH,0FEH,0FFH,0FEH,0FFH,0FEH,0FFH
        DEFB	0FEH,0FFH,0FEH,0FFH,0FEH,0FFH,0FEH,0FFH
        DEFB	0FEH,44H,1DH,1DH,1CH,30H,67H,2BH
        DEFB	28H,22H,0FEH,44H,1DH,1CH,1EH,2AH
        DEFB	6DH,29H,29H,22H,0FEH,43H,1FH,1BH
        DEFB	1EH,26H,73H,25H,29H,24H,0FEH,43H
        DEFB	1FH,1AH,20H,22H,77H,23H,29H,25H
        DEFB	0FEH,42H,21H,19H,20H,1FH,7CH,1FH
        DEFB	29H,27H,0FEH,42H,21H,18H,22H,1BH
        DEFB	80H,1DH,29H,28H,0FEH,41H,23H,17H
        DEFB	22H,19H,84H,1AH,28H,2AH,0FEH,41H
        DEFB	23H,16H,24H,17H,86H,17H,29H,2BH
        DEFB	0FEH,40H,25H,15H,24H,15H,8AH,14H
        DEFB	28H,2DH,0FEH,40H,25H,14H,26H,13H
        DEFB	8CH,11H,29H,2EH,0FEH,3FH,27H,13H
        DEFB	26H,12H,8FH,0EH,29H,2FH,0FEH,3FH
        DEFB	27H,12H,28H,10H,91H,0CH,28H,31H
        DEFB	0FEH,3EH,29H,11H,28H,0FH,94H,08H
        DEFB	29H,32H,0FEH,3EH,2AH,0FH,2AH,0DH
        DEFB	96H,06H,28H,34H,0FEH,3DH,2BH,0EH
        DEFB	2BH,0CH,99H,02H,29H,35H,0FEH,3DH
        DEFB	2CH,0DH,2CH,0BH,0C2H,37H,0FEH,3CH
        DEFB	2DH,0CH,2DH,0AH,26H,4CH,50H,38H
        DEFB	0FEH,3CH,2EH,0BH,2EH,09H,23H,51H
        DEFB	4CH,3AH,0FEH,3BH,2FH,0AH,2FH,09H
        DEFB	21H,54H,4AH,3BH,0FEH,3BH,30H,09H
        DEFB	30H,08H,20H,57H,46H,3DH,0FEH,3AH
        DEFB	31H,08H,31H,08H,21H,57H,44H,3EH
        DEFB	0FEH,3AH,32H,07H,32H,07H,23H,57H
        DEFB	41H,3FH,0FEH,39H,33H,06H,33H,07H
        DEFB	26H,55H,3EH,41H,0FEH,39H,34H,05H
        DEFB	34H,07H,46H,36H,3BH,42H,0FEH,38H
        DEFB	35H,04H,35H,07H,4BH,32H,38H,44H
        DEFB	0FEH,38H,36H,03H,36H,07H,4EH,30H
        DEFB	35H,45H,0FEH,37H,37H,02H,37H,08H
        DEFB	50H,2EH,32H,47H,0FEH,37H,71H,08H
        DEFB	52H,2DH,2FH,48H,0FEH,36H,72H,09H
        DEFB	54H,2BH,2CH,4AH,0FEH,36H,73H,09H
        DEFB	55H,2BH,29H,4BH,0FEH,35H,74H,0AH
        DEFB	55H,29H,2AH,4BH,0FEH,35H,75H,0BH
        DEFB	55H,25H,2DH,4AH,0FEH,34H,76H,0CH
        DEFB	55H,23H,30H,48H,0FEH,34H,1FH,01H
        DEFB	37H,01H,1FH,0DH,54H,20H,33H,47H
        DEFB	0FEH,33H,20H,02H,36H,02H,1EH,10H
        DEFB	52H,1EH,36H,45H,0FEH,33H,1FH,03H
        DEFB	35H,03H,1FH,12H,50H,1BH,39H,44H
        DEFB	0FEH,32H,20H,04H,34H,04H,1EH,15H
        DEFB	4EH,19H,3CH,42H,0FEH,32H,1FH,05H
        DEFB	33H,05H,1FH,18H,4AH,18H,3EH,41H
        DEFB	0FEH,31H,20H,06H,32H,06H,1EH,1DH
        DEFB	46H,15H,42H,3FH,0FEH,31H,1FH,07H
        DEFB	31H,07H,1FH,3CH,26H,14H,44H,3EH
        DEFB	0FEH,30H,20H,08H,30H,08H,1EH,40H
        DEFB	22H,12H,48H,3CH,0FEH,30H,1FH,09H
        DEFB	2FH,09H,1FH,41H,20H,11H,4AH,3BH
        DEFB	0FEH,2FH,20H,0AH,2EH,0AH,1EH,41H
        DEFB	20H,0FH,4EH,39H,0FEH,2FH,1FH,0BH
        DEFB	2DH,0BH,1FH,40H,20H,0EH,28H,01H
        DEFB	27H,38H,0FEH,2EH,20H,0CH,2CH,0CH
        DEFB	1EH,3EH,22H,0CH,29H,04H,27H,36H
        DEFB	0FEH,2EH,1FH,0DH,2BH,0DH,1FH,39H
        DEFB	26H,0BH,29H,06H,27H,35H,0FEH,2DH
        DEFB	20H,0EH,2AH,0EH,7DH,0AH,28H,0AH
        DEFB	27H,33H,0FEH,2DH,1FH,0FH,29H,0FH
        DEFB	7CH,09H,29H,0CH,27H,32H,0FEH,2CH
        DEFB	20H,10H,28H,10H,7BH,08H,28H,10H
        DEFB	27H,30H,0FEH,2CH,1FH,11H,27H,11H
        DEFB	7AH,07H,29H,12H,27H,2FH,0FEH,2BH
        DEFB	1FH,13H,25H,13H,78H,07H,28H,16H
        DEFB	27H,2DH,0FEH,2BH,1FH,13H,25H,13H
        DEFB	77H,06H,29H,18H,27H,2CH,0FEH,2AH
        DEFB	1FH,15H,23H,15H,75H,06H,28H,1CH
        DEFB	27H,2AH,0FEH,2AH,1FH,15H,23H,15H
        DEFB	74H,06H,27H,1FH,27H,29H,0FEH,29H
        DEFB	1FH,17H,21H,17H,71H,06H,28H,22H
        DEFB	27H,27H,0FEH,29H,1FH,17H,21H,17H
        DEFB	70H,06H,27H,25H,27H,26H,0FEH,28H
        DEFB	1FH,19H,1FH,19H,6DH,06H,28H,28H
        DEFB	27H,24H,0FEH,28H,1FH,19H,1FH,19H
        DEFB	6AH,08H,27H,2BH,27H,23H,0FEH,27H
        DEFB	1FH,1BH,1DH,1BH,66H,09H,28H,2EH
        DEFB	27H,21H,0FEH,27H,1FH,1BH,1DH,1BH
        DEFB	63H,0BH,27H,31H,27H,20H,0FEH,26H
        DEFB	1FH,1DH,1BH,1DH,5FH,0CH,28H,34H
        DEFB	27H,1EH,0FEH,26H,1FH,1DH,1BH,1DH
        DEFB	5AH,0FH,28H,37H,27H,1DH,0FEH,0FFH
        DEFB	0FEH,0FFH,0FEH,0FFH,0FEH,0FFH,0FEH,0FFH
        DEFB	0FEH,0FFH,0FEH,0FFH,0FEH,0FFH,0FEH,0FFH
        DEFB	0FEH,0FEH,0FFH,0FFH

        DEFS	08000H-$,0

        END
