;  
;   PRN -> Source re-created by Z80DIS 2.2
;      Z80DIS was written by Kenneth Gielow
;                            Palo Alto, CA
        .Z80
        ORG	36D5H

RAMSID	EQU	08BH
RAMPGS	EQU	8	
        
CALSLT	EQU	001CH

J052E	EQU	052EH
J0534	EQU	0534H
J053A	EQU	053AH
J0546	EQU	0546H
J055E	EQU	055EH
C05AE	EQU	05AEH
C05BA	EQU	05BAH
C05C0	EQU	05C0H
J05C6	EQU	05C6H
J05F6	EQU	05F6H
C05FC	EQU	05FCH
C1947	EQU	1947H
C1C4B	EQU	1C4BH
C1D2B	EQU	1D2BH

M269A	EQU	269AH
M2F8A	EQU	2F8AH
M3042	EQU	3042H
M30DB	EQU	30DBH
M3193	EQU	3193H
M324E	EQU	324EH
M325C	EQU	325CH
M3267	EQU	3267H
M3425	EQU	3425H
M3426	EQU	3426H
M46FF	EQU	46FFH
M5211	EQU	5211H

LINLEN	EQU	0F3B0H
BUF	EQU	0F55EH
TTYPOS	EQU	0F661H
VALTYP	EQU	0F663H
DAC	EQU	0F7F6H
ARG	EQU	0F847H
PTRFIL	EQU	0F864H
FILNAM	EQU	0F866H
NLONLY	EQU	0F87CH
AVCSAV	EQU	0FAF7H
LINWRK	EQU	0FC18H
SLTWRK	EQU	0FD09H
PROCNM	EQU	0FD89H
DFFF8	EQU	0FFF8H
DFFFF	EQU	0FFFFH

;
; replacement for C1947 @ 173E, adjust YY/MM/DD to MM/DD/YY
;

C36D5:	CALL	C1947			; put clockchip in running state
        LD	BC,-8
        ADD	HL,BC			; start of string
        LD	D,H
        LD	E,L
        LD	B,(HL)
        INC	HL
        LD	C,(HL)
        INC	HL			; year
        BIT	4,(HL)			; date ?
        RET	NZ			; nope, no adjust
        INC	HL
        PUSH	BC
        LD	BC,5
        LDIR				; MM/DD
        POP	BC
        INC	DE
        EX	DE,HL
        LD	(HL),B
        INC	HL
        LD	(HL),C			; MM/DD/YY
        RET	

;	patch initialize A/V control (extra A/V control for PAL version)

C36F3:	LD	(AVCSAV),A
        XOR	A
        OUT	(0F8H),A
        LD	(DFFF8),A
        RET	

;	patch SET VIDEO audio parameter (extra A/V control for PAL version)

C36FD:	RST	28H			; evaluate byte operand
        CP	16
        RET	NC
        PUSH	AF
        RRCA	
        RRCA	
        AND	03H			; extra A/V bits for PAL
        LD	E,A
        LD	A,0FCH			; mask
        CALL	C3711			; set A/V bits
        POP	AF
        AND	03H 
        SCF	
        RET	

;	  Subroutine __________________________
;	     Inputs  ________________________
;	     Outputs ________________________

C3711:	PUSH	HL
        LD	HL,DFFF8
        AND	(HL)
        OR	E
        LD	(HL),A
        OUT	(0F8H),A
        POP	HL
        RET	

I371C:	DEFB	00AH
        DEFB	000H
        DEFB	000H
        DEFB	000H
        DEFB	005H
        DEFB	002H
        DEFB	00FH
        DEFB	004H
        DEFB	004H
        DEFB	003H
        DEFB	001H
        DEFB	000H
        DEFB	002H
        DEFB	0FFH

; DEVICE HANDLER

C372A:	EI	
        INC	A
        JR	NZ,J3734
        CALL	C39C3
        RET	Z
        SCF	
        RET	

J3734:	PUSH	AF
        CALL	C3D88			; check for valid ramdisk
        POP	AF
        LD	IX,I3CAA
        PUSH	IX			; select mapper page 2
        PUSH	HL
        LD	HL,I374E-1
        ADD	A,L
        LD	L,A
        JR	NC,J3748
        INC	H
J3748:	LD	A,(HL)
        INC	HL
J374A:	LD	H,(HL)
        LD	L,A
        EX	(SP),HL
        RET	

I374E:	DEFW	C3A0D
        DEFW	C3A98
        DEFW	C3939
        DEFW	C3AB2
        DEFW	C3B2F
        DEFW	C38E0
        DEFW	C38EF
        DEFW	C3936
        DEFW	C3961
        DEFW	C3B8D

D3762:	DEFB	RAMSID
D3763:	DEFB	RAMPGS-2
D3764:	DEFW	((RAMPGS-2)*16*1024/256 - 25)

;
; CALL MEMINI
;

C3766:	LD	A,(SLTWRK+0)
        BIT	5,A			; ramdisk disabled ?
        JR	NZ,J37AC		; yep, illegal function call
        AND	70H			; keep b6,b5 and b4
        LD	B,A
        LD	A,(D3762)		; slotid ramdisk RAM
        OR	10H			; set b4 bit
        OR	B
        LD	(SLTWRK+0),A
        BIT	6,A			; ramdisk valid (in use) ?
        JR	Z,J378B		; nope, skip file open detection
        LD	B,64
J377F:	CALL	C3B9A			; read fileentry ramdisk
        LD	A,(LINWRK+16)
        OR	A
        JP	NZ,J3D84		; file open, file still open error
        DJNZ	J377F
J378B:	LD	A,(D3763)
        LD	C,A			; number of mapper pages for ramdisk
        LD	DE,0
        DEC	HL
J3793:	RST	10H
        LD	A,C
        JR	Z,J37D4		; no argument, use defaults
        RST	08H
        DEFB	"("			; check for (
        PUSH	BC
        CALL	C3CCD			; evaluate size operand
        POP	BC
        LD	B,A
        PUSH	BC
        RST	08H
        DEFB	")"			; check for )
        POP	BC
        RET	NZ			; not end of statement, quit
        LD	A,B
        CP	C			; enough mapper pages ?
        JR	C,J37B0		; yep,
        JR	NZ,J37AC		; nope,
        LD	A,D
        OR	E
J37AC:	JP	NZ,J0546		; illegal function call
        LD	A,B
J37B0:	OR	A			; zero pages ?
        JR	NZ,J37D4		; no, initialize RAM disk
        PUSH	HL
        LD	HL,0E600H
        ADD	HL,DE
        POP	HL			; >=6656 bytes ?
        JR	C,J37D4		; yep, initialize RAM disk
        PUSH	HL
        LD	HL,SLTWRK+0
        RES	6,(HL)			; RAM disk invalid
        CALL	C38D7
        DEFB	"No RAM disk",13,10
        DEFB	0
        POP	HL
        RET	

J37D4:	PUSH	HL
        PUSH	DE
        PUSH	AF
        LD	HL,BUF+4
        LD	(HL),A
        DEC	HL
        LD	(HL),D
        DEC	HL
        LD	(HL),E
        OR	A
        JR	Z,J37EB
        SET	4,D
        CP	1
        JR	Z,J37EB
        LD	DE,07FFFH
J37EB:	DEC	HL
        LD	(HL),D
        DEC	HL
        LD	(HL),E
        LD	DE,04000H
        LD	BC,5
        CALL	C3CAF			; select mapper page 3
        CALL	C3C68			; transfer ramdisk
        POP	AF
        POP	DE
        LD	L,A
        LD	H,00H
        ADD	HL,HL
        ADD	HL,HL
        ADD	HL,HL
        ADD	HL,HL
        ADD	HL,HL
        ADD	HL,HL
        LD	E,D
        LD	D,00H
        ADD	HL,DE
        LD	DE,-(1+16+8)
        ADD	HL,DE
        PUSH	HL
        LD	HL,0FFFFH
        LD	(LINWRK+32),HL		; marked as used
        LD	BC,(D3764)
J3819:	CALL	C3BC2			; write fatentry ramdisk
        DEC	BC
        LD	A,B
        OR	C
        JR	NZ,J3819
        POP	BC
        PUSH	BC
        INC	HL
        LD	(LINWRK+32),HL		; marked as unused
J3827:	CALL	C3BC2			; write fatentry ramdisk
        DEC	BC
        LD	A,B
        OR	C
        JR	NZ,J3827
        CALL	C385A			; empty fileentry
        LD	B,64
J3834:	CALL	C3B9B			; write fileentry ramdisk
        DJNZ	J3834
        LD	HL,SLTWRK+0
        SET	6,(HL)			; ramdisk valid
        POP	HL
        CALL	C3D68			; *256 to interpreter output
        CALL	C38D7
        DEFB	" bytes allocated",13,10
        DEFB	0
        POP	HL
        RET	

;	  Subroutine __________________________
;	     Inputs  ________________________
;	     Outputs ________________________
C385A:	PUSH	BC
        XOR	A
        LD	B,32
        LD	HL,LINWRK
J3861:	LD	(HL),A
        INC	HL
        DJNZ	J3861
        POP	BC
        RET	

;
; CALL MFILES
;

C3867:	CALL	C3D88			; check for valid ramdisk
        CALL	C05AE			; fresh line to interpreter output
        PUSH	HL
        LD	BC,04000H
J3871:	CALL	C3B9A			; read fileentry ramdisk
        LD	HL,LINWRK
        LD	A,(HL)
        AND	A
        JR	Z,J38AE
        INC	C
        PUSH	BC
        LD	DE,BUF
        PUSH	DE
        LD	BC,11
        LDIR	
        POP	HL
        LD	B,08H	; 8 
        CALL	C38D1
        LD	A,(HL)
        CP	" "
        JR	Z,J3893
        LD	A,"."
J3893:	RST	18H
        LD	B,03H	; 3 
        CALL	C38D1
        LD	A,(TTYPOS)
        AND	A
        JR	Z,J38AD
        ADD	A,0CH	; 12 
        LD	HL,LINLEN
        CP	(HL)
        JR	NC,J38AA
        LD	A," "
J38A9:	RST	18H
J38AA:	CALL	NC,C05AE		; fresh line to interpreter output
J38AD:	POP	BC
J38AE:	DJNZ	J3871
        LD	A,C
        OR	A
        JP	Z,J055E			; file not found
        CALL	C05AE			; fresh line to interpreter output
        CALL	C3961			; MEM device FPOS
        CALL	C3D72			; DAC to interpreter output
        CALL	C38D7
        DEFB	" bytes free",13,10
        DEFB	0
        POP	HL
        RET	

;	  Subroutine __________________________
;	     Inputs  ________________________
;	     Outputs ________________________

C38D1:	LD	A,(HL)
        INC	HL
        RST	18H
        DJNZ	C38D1
        RET	

;	  Subroutine __________________________
;	     Inputs  ________________________
;	     Outputs ________________________

C38D7:	EX	(SP),HL
        LD	A,(HL)
        INC	HL
        EX	(SP),HL
        AND	A
        RET	Z
        RST	18H
        JR	C38D7

;
; MEM device LOC
;

C38E0:	CALL	C3B94
        LD	HL,(LINWRK+14)
        LD	C,(IY+6)
        LD	B,L
        LD	L,H
        LD	H,00H
        JR	J3900

;
; MEM device LOF
;

C38EF:	CALL	C3B94
        LD	BC,(LINWRK+28)
        LD	A,(HL)
        RRCA	
        JR	C,J38FD
        LD	C,(IY+6)
J38FD:	LD	HL,(LINWRK+30)
J3900:	PUSH	BC
        LD	IX,M46FF
        CALL	CALSLT
        LD	BC,06545H
        LD	DE,06053H
        LD	IX,M325C
        CALL	CALSLT
        LD	HL,DAC
        LD	DE,ARG
        LD	BC,8
        LDIR	
        POP	HL
        LD	IX,M46FF
J3925:	CALL	CALSLT
        LD	IX,M3042
        CALL	CALSLT
J392F:	LD	IX,M269A
        JP	CALSLT

;
; MEM device EOF
;

C3936:	LD	A,(HL)
        CP	01H
C3939:	LD	E,61
        JP	NZ,J3D90
        CALL	C3950
        LD	HL,0FFFFH
        JR	C,J3947
        INC	HL
J3947:	LD	(DAC+2),HL
        LD	A,02H	; 2 
        LD	(VALTYP),A
        RET	

;	  Subroutine __________________________
;	     Inputs  ________________________
;	     Outputs ________________________

C3950:	PUSH	HL
        POP	IY
        LD	A,(IY+7)
        AND	01H	; 1 
        RET	Z
        LD	A,(IY+6)
        CP	(IY+5)
        CCF	
        RET	

;	  Subroutine MEM device FPOS
;	     Inputs  ________________________
;	     Outputs ________________________

C3961:	LD	BC,(D3764)
        LD	HL,0
J3968:	CALL	C3BC1			; read fatentry ramdisk
        JR	NZ,J396E
        INC	HL
J396E:	DEC	BC
        LD	A,B
        OR	C
        JR	NZ,J3968
        LD	B,L
        LD	L,H
        LD	H,C
        JR	J3900

;
; CALL MKILL
;

J3978:	CALL	C39A8			; check for ( and evaluate filespecification with check for mem device
        RST	08H
        DEFB	")"			; check for )
        CALL	C3D7C			; find fileentry and check for not open

;	  Subroutine __________________________
;	     Inputs  ________________________
;	     Outputs ________________________

C3980:	XOR	A
        LD	(LINWRK+0),A		; fileentry not used (anymore)
        CALL	C3B9B			; write fileentry ramdisk
        LD	DE,(LINWRK+26)
        LD	A,D
        OR	E
        RET	Z
        PUSH	HL
J398F:	LD	B,D
        LD	C,E
        CALL	C3BC1			; read fatentry ramdisk
        LD	DE,(LINWRK+32)		; next cluster
        LD	HL,0
        LD	(LINWRK+32),HL		; marked as unused
        CALL	C3BC2			; write fatentry ramdisk
        LD	A,D
        AND	E
        INC	A			; end of cluster chain ?
        JR	NZ,J398F		; nope, continue
        POP	HL
        RET	

;	  Subroutine check for ( and evaluate filespecification with check for mem device
;	     Inputs  ________________________
;	     Outputs ________________________

C39A8:	RST	08H
        DEFB	"("			; check for (
        CALL	C3D88			; check for valid ramdisk

;	  Subroutine evaluate filespecification with check for mem device
;	     Inputs  ________________________
;	     Outputs ________________________

C39AD:	CALL	C05BA			; evaluate filespecification
        RET	Z
        LD	A,D
        CP	0FCH			; internal device ?
        JR	NC,J39C0		; yep, bad filename
        CP	09H			; diskdrive device ?
        JR	C,J39C0		; yep, bad filename
        PUSH	HL
        CALL	C39C3			; check if MEM device
        POP	HL
        RET	Z			; yep, quit
J39C0:	JP	J052E			; bad filename

;	  Subroutine __________________________
;	     Inputs  ________________________
;	     Outputs ________________________

C39C3:	LD	HL,PROCNM
        LD	DE,I39D8
J39C9:	LD	A,(DE)
        CP	(HL)
        JR	NZ,J39D3
        INC	HL
        INC	DE
        OR	A
        JR	NZ,J39C9
        RET	

J39D3:	SUB	"0"
        RET	NZ
        OR	(HL)
        RET	

I39D8:	DEFB	"MEM0"
        DEFB	0

;
; CALL MNAME
;

J39DD:	CALL	C39A8			; check for ( and evaluate filespecification with check for mem device
        CALL	C3D7C			; find fileentry and check for not open
        PUSH	BC			; save fileentry number
        RST	08H
        DEFB	"A"
        RST	08H
        DEFB	"S"			; check for AS
        CALL	C39AD			; evaluate filespecification with check for mem device
        RST	08H
        DEFB	")"			; check for )
        CALL	C3BF7			; find fileentry
        LD	E,65
        JP	Z,J3D90		; found,
        POP	BC			; restore fileentry number
        CALL	C3B9A			; read fileentry ramdisk
        PUSH	HL
        CALL	C3A8A			; put new name in fileentry
        POP	HL
        JP	C3B9B			; write fileentry ramdisk

I3A01:	POP	DE
        LD	A,0FFH
        LD	B,(IY+1)
        LD	(LINWRK+16),A
        JP	C3B9B			; write fileentry ramdisk

;
; MEM device open
;

C3A0D:	PUSH	DE
        CALL	C3BF7			; find fileentry
        LD	IX,I3A01
        PUSH	IX
        PUSH	AF
        OR	A			; file open ?
        JP	NZ,J053A		; yep, file already open
        LD	A,E
        RRCA	
        RRCA	
        JR	C,J3A6A
        RRCA	
        JP	C,J0534			; sequential i/o only error
        POP	AF
        JP	NZ,J055E		; file not found
        CALL	C3CB6
        BIT	0,E
        JR	NZ,J3A4E
        LD	HL,(LINWRK+29)
        LD	(LINWRK+14),HL
        LD	HL,LINWRK+28
        LD	A,(HL)
        LD	(IY+6),A
        XOR	A
        LD	(HL),A
        LD	HL,(LINWRK+26)
        LD	A,H
        OR	L
        RET	Z
        LD	HL,(LINWRK+20)
        LD	(LINWRK+12),HL
        JP	C3C35

J3A4E:	LD	H,A
        LD	L,A
        LD	(LINWRK+12),HL
        LD	(LINWRK+14),HL
        LD	HL,(LINWRK+28)
        LD	(IY+5),L
        DEC	HL
        LD	A,H
        OR	A
        RET	NZ
        LD	A,(LINWRK+30)
        OR	A
        RET	NZ
        SET	0,(IY+7)
        RET	
J3A6A:	POP	AF
        JR	NZ,J3A70
        CALL	C3980			; delete file
J3A70:	LD	B,40H
J3A72:	CALL	C3B9A			; read fileentry ramdisk
        LD	A,(LINWRK+0)
        AND	A
        JR	Z,J3A82
        DJNZ	J3A72
        LD	E,67
        JP	J3D90

J3A82:	LD	E,02H	; 2 
        CALL	C3CB6
        CALL	C385A			; empty fileentry

;	  Subroutine __________________________
;	     Inputs  ________________________
;	     Outputs ________________________

C3A8A:	PUSH	BC
        LD	DE,LINWRK
        LD	HL,FILNAM
        LD	BC,11
        LDIR	
        POP	BC
        RET

;
; MEM device close
;

C3A98:	CALL	C3B94
        PUSH	BC
        XOR	A
        LD	(LINWRK+16),A
        LD	A,(HL)
        RRCA	
        JR	C,J3AAE
        LD	A,(IY+6)
        LD	(LINWRK+28),A
        AND	A
        CALL	NZ,C3C36
J3AAE:	POP	BC
        JP	C3B9B			; write fileentry ramdisk

;
; MEM device seq output
;

C3AB2:	PUSH	HL
        POP	IY
        LD	A,(IY+6)
        AND	A
        JR	NZ,J3B07
        PUSH	HL
        PUSH	BC
        CALL	C3B94
        LD	BC,1
        LD	HL,(D3764)
J3AC6:	CALL	C3BC1			; read fatentry ramdisk
        JR	Z,J3AD6
        DEC	HL
        INC	BC
        LD	A,H
        OR	L
        JR	NZ,J3AC6
        LD	E,66
        JP	J3D90

J3AD6:	LD	HL,(LINWRK+26)
        LD	A,H
        OR	L
        JR	NZ,J3AE1
        LD	(LINWRK+26),BC
J3AE1:	LD	(LINWRK+32),BC
        PUSH	BC
        LD	BC,(LINWRK+12)
        CALL	NZ,C3BC2		; write fatentry ramdisk
        POP	BC
        LD	(LINWRK+20),BC
        LD	(LINWRK+12),BC
        LD	HL,0FFFFH
        LD	(LINWRK+32),HL
        CALL	C3BC2			; write fatentry ramdisk
        LD	B,(IY+1)
        CALL	C3B9B			; write fileentry ramdisk
        POP	BC
        POP	HL
J3B07:	PUSH	HL
        LD	DE,9
        ADD	HL,DE
        LD	E,(IY+6)
        ADD	HL,DE
        LD	(HL),C
        INC	(IY+6)
        POP	HL
        RET	NZ
        CALL	C3B94
        PUSH	BC
        CALL	C3C36
        POP	BC
        LD	HL,(LINWRK+29)
        INC	HL
        LD	(LINWRK+29),HL
;	  Subroutine __________________________
;	     Inputs  ________________________
;	     Outputs ________________________
C3B25:	LD	HL,(LINWRK+14)
        INC	HL
        LD	(LINWRK+14),HL
        JP	C3B9B			; write fileentry ramdisk

;
; MEM device seq input
;

D3B2F:	CALL	C3950
        RET	C
        LD	A,(IY+3)
        OR	A
        LD	C,00H
        LD	(IY+3),C
        RET	NZ
        LD	A,(IY+6)
        AND	A
        JR	Z,J3B5A
        LD	BC,9
        ADD	HL,BC
        LD	C,A
        ADD	HL,BC
        LD	A,(HL)
        INC	(IY+6)
        RET	NZ
        PUSH	AF
        LD	B,(IY+1)
        CALL	C3B9A			; read fileentry ramdisk
        CALL	C3B25
        POP	AF
        RET	
J3B5A:	CALL	C3B94
        PUSH	BC
        LD	BC,(LINWRK+12)
        LD	A,B
        OR	C
        LD	HL,(LINWRK+26)
        LD	(LINWRK+32),HL
        CALL	NZ,C3BC1		; read fatentry ramdisk
        LD	HL,(LINWRK+32)
        LD	(LINWRK+12),HL
        PUSH	HL
        CALL	C3C35
        INC	(IY+6)
        POP	DE
        LD	HL,(LINWRK+20)
        RST	20H
        JR	NZ,J3B85
        SET	0,(IY+7)
J3B85:	POP	BC
        CALL	C3B9B			; write fileentry ramdisk
        LD	A,(IY+9)
        RET

;
; MEM device putback
;

C3B8D:	PUSH	HL
        POP	IY
        LD	(IY+3),C
        RET	
;	  Subroutine __________________________
;	     Inputs  ________________________
;	     Outputs ________________________
C3B94:	INC	HL
        LD	B,(HL)
        DEC	HL
        PUSH	HL
        POP	IY

;	  Subroutine __________________________
;	     Inputs  ________________________
;	     Outputs ________________________

C3B9A:	DEFB	0F6H
C3B9B:	SCF
        PUSH	HL
        PUSH	DE
        PUSH	BC
        PUSH	AF
        LD	A,B
        OR	A
        JR	Z,J3BF2
        CP	41H	; "A"
        JR	NC,J3BF2
        LD	L,B
        LD	H,00H
        DEC	HL
        ADD	HL,HL
        ADD	HL,HL
        ADD	HL,HL
        ADD	HL,HL
        ADD	HL,HL
        LD	DE,04000H+17*256
        ADD	HL,DE
        LD	DE,LINWRK
        POP	AF
        JR	NC,J3BBC
        EX	DE,HL
J3BBC:	LD	BC,32
        JR	J3BD9

;	  Subroutine __________________________
;	     Inputs  ________________________
;	     Outputs ________________________

C3BC1:	DEFB	0F6H
C3BC2:	SCF
        PUSH	HL
        PUSH	DE
        PUSH	BC
        PUSH	AF
        CALL	C3BE8
        LD	HL,04000H+1*256-2
        ADD	HL,BC
        ADD	HL,BC
        LD	DE,LINWRK+32
        POP	AF
        JR	NC,J3BD6
        EX	DE,HL
J3BD6:	LD	BC,2
J3BD9:	CALL	C3CAF			; select mapper page 3
        CALL	C3C68			; transfer ramdisk
        LD	HL,(LINWRK+32)
        LD	A,H
        OR	L
        POP	BC
        POP	DE
        POP	HL
        RET	
;	  Subroutine __________________________
;	     Inputs  ________________________
;	     Outputs ________________________
C3BE8:	LD	A,B
        OR	C
        JR	Z,J3BF2
        LD	HL,(D3764)
        SBC	HL,BC
        RET	NC
J3BF2:	LD	E,60
        JP	J3D90

;	  Subroutine find fileentry
;	     Inputs  ________________________
;	     Outputs ________________________

C3BF7:	PUSH	HL
        PUSH	DE
        LD	DE,FILNAM
        LD	B,11
J3BFE:	LD	A,(DE)
        CP	"a"
        JR	C,J3C0A
        CP	"z"+1
        JR	NC,J3C0A
        AND	0DFH			; to upper
        LD	(DE),A
J3C0A:	INC	DE
        DJNZ	J3BFE
        LD	B,40H
J3C0F:	CALL	C3B9A			; read fileentry ramdisk
        PUSH	BC
        LD	HL,LINWRK
        LD	A,(HL)
        AND	A			; fileentry used ?
        JR	Z,J3C2B		; nope, skip to next
        LD	DE,FILNAM
        LD	B,11
J3C1F:	LD	A,(DE)
        CP	(HL)
        JR	NZ,J3C2B		; no match, skip to next
        INC	DE
        INC	HL
        DJNZ	J3C1F
        XOR	A
        POP	BC
        JR	J3C2F
J3C2B:	POP	BC
        DJNZ	J3C0F
        INC	B
J3C2F:	LD	A,(LINWRK+16)
        POP	DE
        POP	HL
        RET	
;	  Subroutine __________________________
;	     Inputs  ________________________
;	     Outputs ________________________
C3C35:	DEFB	0F6H
C3C36:	SCF
        PUSH	AF
        PUSH	IY
        POP	HL
        LD	BC,9
        ADD	HL,BC
        PUSH	HL
        LD	BC,(LINWRK+12)
        CALL	C3BE8
        LD	HL,24
        ADD	HL,BC
        LD	A,L
        AND	3FH	; "?"
        OR	40H	; "@"
        LD	D,A
        LD	E,00H
        ADD	HL,HL
        ADD	HL,HL
        LD	A,2
        ADD	A,H
        CP	04H
        JR	NC,J3C5E
        XOR	01H			; first mapperpage 3, second mapperpage 2
J3C5E:	OUT	(0FDH),A		; select mapperpage
        POP	HL
        POP	AF
        JR	C,J3C65
        EX	DE,HL
J3C65:	LD	BC,256

;	  Subroutine __________________________
;	     Inputs  ________________________
;	     Outputs ________________________

C3C68:	EXX	
        LD	HL,DFFFF
        LD	A,(SLTWRK+0)
        LD	D,A
        RRCA	
        RRCA
        AND	0C0H			; primairy slot ramdisk RAM in page 3
        LD	C,A
        RRCA	
        RRCA	
        RRCA	
        RRCA	
        OR	C
        LD	C,A			; primairy slot ramdisk RAM in page 1
        IN	A,(0A8H)
        LD	B,A			; save current primairy slot register
        AND	33H
        OR	C
        LD	E,A
        DI	
        OUT	(0A8H),A		; enable primairy slot ramdisk RAM in page 3 and 1
        LD	A,D
        AND	0CH
        LD	D,A			; secundairy slot ramdisk RAM in page 1
        LD	A,(HL)
        CPL	
        LD	C,A			; save current secundairy slot register
        AND	0F3H
        OR	D
        LD	(HL),A			; enable secundairy slot ramdisk RAM in page 1
        LD	A,E
        AND	3FH
        LD	D,A
        LD	A,B
        AND	0C0H
        OR	D
        EI	
        OUT	(0A8H),A		; restore orginal primairy slot in page 3
        EXX	
        LDIR				; transfer
        EXX	
        LD	A,E
        DI	
        OUT	(0A8H),A		; primairy slot ramdisk RAM in page 3
        LD	A,C
        LD	(HL),A			; restore orginal secundairy slot register
        LD	A,B
        EI	
        OUT	(0A8H),A		; restore orginal secindairy slot register
        EXX	
I3CAA:	PUSH	AF
        LD	A,2
        JR	J3CB2
;	  Subroutine __________________________
;	     Inputs  ________________________
;	     Outputs ________________________
C3CAF:	PUSH	AF
        LD	A,3
J3CB2:	OUT	(0FDH),A
        POP	AF
        RET	
;	  Subroutine __________________________
;	     Inputs  ________________________
;	     Outputs ________________________
C3CB6:	PUSH	HL
        POP	IY
        PUSH	HL
        XOR	A
        LD	(PTRFIL),HL
        LD	(HL),E
        INC	HL
        LD	(HL),B
        INC	HL
        INC	HL
        LD	(HL),A
        INC	HL
        INC	HL
        LD	(HL),A
        INC	HL
        LD	(HL),A
        INC	HL
        LD	(HL),A
        POP	HL
        RET	

;	  Subroutine __________________________
;	     Inputs  ________________________
;	     Outputs ________________________

C3CCD:	CALL	C05FC			; evaluate expression
        LD	A,(VALTYP)
        CP	3
        JP	Z,J0546			; string, illegal function call
        CP	2
        JR	NZ,J3CEB		; not a integer,
        LD	DE,(DAC+2)
        INC	DE			; size in bytes
        LD	A,D
        RLCA	
        RLCA	
        AND	03H			; size in pages
        RES	7,D
        RES	6,D			; size in last page
        RET

J3CEB:	PUSH	HL
        LD	BC,01041H
        LD	DE,00000H		; 1.0
        LD	IX,M324E
        CALL	CALSLT			; single real addition
        LD	HL,(DAC+0)
        LD	DE,(DAC+2)
        PUSH	HL
        PUSH	DE			; save DAC
        PUSH	HL
        PUSH	DE			; save DAC
        LD	HL,01645H
        LD	(DAC+0),HL
        LD	HL,04038H
        LD	(DAC+2),HL		; 16384
        POP	DE
        POP	BC			; size
        LD	IX,M3267
        CALL	CALSLT			; single real divide
        LD	HL,(DAC+0)
        PUSH	HL
        LD	HL,(DAC+2)
        PUSH	HL			; save DAC (number of pages)
        LD	IX,M30DB
        CALL	CALSLT			; INT single real
        LD	BC,016C5H
        LD	DE,04038H		; -16384
        LD	IX,M325C
        CALL	CALSLT			; single real multiply
        POP	BC
        POP	HL
        POP	DE
        EX	(SP),HL
        PUSH	BC
        LD	C,L
        LD	B,H
        LD	IX,M324E
        CALL	CALSLT			; single real addition
        LD	IX,M2F8A
        CALL	CALSLT			; convert DAC to integer
        POP	DE
        POP	BC
        PUSH	HL
        LD	(DAC+0),BC
        LD	(DAC+2),DE
        LD	A,4
        LD	(VALTYP),A		; single real
        LD	IX,M5211
        CALL	CALSLT			; convert DAC to integer
        JP	NZ,J0546		; illegal function call
        LD	A,E
        POP	DE
        POP	HL
        RET

;	  Subroutine __________________________
;	     Inputs  ________________________
;	     Outputs ________________________

C3D68:	LD	DE,256
        LD	IX,M3193
        CALL	CALSLT			; multiply integer
;
;	  Subroutine __________________________
;	     Inputs  ________________________
;	     Outputs ________________________

C3D72:	LD	IX,M3425
        CALL	CALSLT			; convert DAC to text, unformatted
        JP	J05F6			; message to interpreter output

;	  Subroutine find fileentry and check for not open
;	     Inputs  ________________________
;	     Outputs ________________________

C3D7C:	CALL	C3BF7			; find fileentry
        JP	NZ,J055E		; file not found
        AND	A			; file open ?
        RET	Z			; nope, quit
J3D84:	LD	E,64
        JR	J3D90

;	  Subroutine check for valid ramdisk
;	     Inputs  ________________________
;	     Outputs ________________________

C3D88:	LD	A,(SLTWRK+0)
        BIT	6,A			; ramdisk valid ?
        RET	NZ			; yep, quit
        LD	E,70

J3D90:	XOR	A
        LD	(NLONLY),A		; not loading basic program, close i/o channels when requested
        PUSH	DE
        CALL	C05C0			; close i/o channel
        POP	DE
        JP	J05C6			; BASIC error

;	Subroutine	extended errorhandler
;	Inputs		HL = errortext pointer, E=errorcode
;	Outputs		HL = errortext pointer, E=errorcode

C3D9C:	LD	BC,I3DBF
J3D9F:	LD	A,(BC)
        INC	BC
        OR	A
        RET	Z
        SUB	E
        JR	Z,J3DAA
        INC	BC
        INC	BC
        JR	J3D9F

J3DAA:	LD	L,C
        LD	H,B
        LD	E,(HL)
        INC	HL
        LD	D,(HL)
        LD	HL,BUF
        PUSH	HL
        LD	(HL),A
J3DB4:	INC	DE
        INC	HL
        LD	A,(DE)
        LD	(HL),A
        OR	A
        JR	NZ,J3DB4
        POP	HL
        LD	E,01H	; 1 
        RET	

I3DBF:	DEFB	03CH
        DEFW	I3DD5-1
        DEFB	03DH
        DEFW	I3DDD-1
        DEFB	040H
        DEFW	I3DEB-1
        DEFB	041H
        DEFW	I3DFB-1
        DEFB	042H
        DEFW	I3E0F-1
        DEFB	043H
        DEFW	I3E1D-1
        DEFB	046H
        DEFW	I3E2C-1
        DEFB	0

I3DD5:	DEFB	"Bad FAT",0
I3DDD:	DEFB	"Bad file mode",0
I3DEB:	DEFB	"File still open",0
I3DFB:	DEFB	"File already exists",0
I3E0F:	DEFB	"RAM disk full",0
I3E1D:	DEFB	"Too many files",0
I3E2C:	DEFB	"RAM disk offline",0

C3E3C:	PUSH	HL			; save KB string
        CALL	C1C4B			; print KB string
        LD	A,0BEH
        LD	HL,0068H
        CALL	C1D2B			; set position
        LD	HL,I3E81
        CALL	C1C4B			; print user ram string
        LD	A,(D3763)
        INC	A
        INC	A			; number of mapper pages
J3E54:	LD	L,A
        LD	H,0
        ADD	HL,HL
        ADD	HL,HL
        ADD	HL,HL
        ADD	HL,HL			; * 16
        LD	(DAC+2),HL
        LD	A,02H
        LD	(VALTYP),A
        LD	IX,M3426
        LD	A,80H			; formated, without commas, fixed point
        LD	BC,00300H		; 3 digits before, 0 digits after
        CALL	CALSLT			; convert DAC to text, formatted
        CALL	C1C4B			; print user ram size
        POP	HL
        JP	C1C4B			; print KB string

I3E76:	DEFB	"VIDEO RAM:",0
I3E81:	DEFB	"USER  RAM:",0

        DEFS	04000H-$,0

        END
