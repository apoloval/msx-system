; AUDIO10.ASM

; MSX AUDIO BASIC ROM

; Source re-created by Z80DIS 2.2
; Z80DIS was written by Kenneth Gielow, Palo Alto, CA

; Code Copyrighted by ASCII and maybe others
; Source comments by Arjen Zeilemaker

; Sourcecode supplied for STUDY ONLY
; Recreation NOT permitted without authorisation of the copyrightholders

        .Z80
        ASEG
        ORG	4000H


; voicebuffer
; +0,2	durationcounter
; +2	stringlength
; +3,2	stringaddress
; +5,2	stackaddress
; +7	musicpacket size (PSG)
; +8,7	musicpacket (PSG)
; +8	accent mask drums (drum)
; +9	notelength (FM)
; +10	normal volume drums (drum)
; +12	accent volume drums (drum)
; +13	connection note (FM)
; +15	octave
; +16	notelength
; +17	tempo
; +18	volume
; +19,2	envelope period
; +21	stack
; +38	division value

M0006	EQU	0006H	; -C-LI
RDSLT	EQU	000CH	; -C--I
WRSLT	EQU	0014H	; -C---
CALSLT	EQU	001CH	; JC--I
ENASLT	EQU	0024H	; JC---
IDBYT0	EQU	002BH	; ----I
KEYINT	EQU	0038H	; -C--I
GICINI	EQU	0090H	; -C--I
M2F8A	EQU	2F8AH	; convert to integer
M406F	EQU	406FH	; BASIC error
M4666	EQU	4666H	; get BASIC char
M4C64	EQU	4C64H	; evaluate expression
M4E9B	EQU	4E9BH	; get variable value
M517A	EQU	517AH	; convert DAC
M521C	EQU	521CH	; evaluate byte operand
M542F	EQU	542FH	; evaluate address operand
M5EA4	EQU	5EA4H	; search variable
M67D0	EQU	67D0H	; free temporary string
M6A0E	EQU	6A0EH	; evaluate filespec
M73E5	EQU	73E5H	; PLAY statement handler

C0090	EQU	0090H	; initialize AUDIO workspace
C0099	EQU	0099H	; write AUDIO register (EI)
C009C	EQU	009CH	; write AUDIO register (DI)
C00AB	EQU	00ABH	; setup AUDIO
C00AE	EQU	00AEH	; function AUDIO
C00B1	EQU	00B1H	; scan AUDIO keyboard
C00B4	EQU	00B4H	; interrupt handler AUDIO
J0312	EQU	0312H	; resume CALSLT in page 0
J2F70	EQU	2F70H	; service PSG playvoice in page 0

I3000	EQU	3000H	; channel
I3280	EQU	3280H	; control registers 1st Y8950
I32C0	EQU	32C0H	; control registers 2nd Y8950
D3496	EQU	3496H	; b7 enable audio keyboard scan, b4 sample, b3 play, b2 rec, b1-b0 mode
D3497	EQU	3497H	; put pointer record buffer audio keyboard
D349B	EQU	349BH	; end record buffer audio keyboard
D349D	EQU	349DH	; get pointer replay buffer audio keyboard
D34A1	EQU	34A1H	; end replay buffer audio keyboard
D34A3	EQU	34A3H	; audio keyboard replay timer
I34A4	EQU	34A4H	; audio keyboard recording timer (increments every TIMER-2 interrupt)
I3E89	EQU	3E89H	; general interrupt routine

D72A3	EQU	72A3H	; sample ram size (in 32 KB units) 1st Y8950
D72E3	EQU	72E3H	; sample ram size (in 32 KB units) 2nd Y8950
D7300	EQU	7300H	; general interrupt handler
D7308	EQU	7308H	; should VDP interrupts handled routine
D7340	EQU	7340H	; TIMER-1 block
D7344	EQU	7344H	; TIMER-2 block
D7370	EQU	7370H	; AST MK
D7372	EQU	7372H	; AST ADPCM 1st Y8950
D7374	EQU	7374H	; AST ADPCM 2nd Y8950
D7380	EQU	7380H	; pointer to predefined instrument definitions (00-31)
D7382	EQU	7382H	; pointer to programable instrument definitions (32-63)
D7384	EQU	7384H	; pointer to predefined instrument definitions (32-63)
D7391	EQU	7391H	; 2nd Y8950 available
D7488	EQU	7488H	; record sample mic flag
D7489	EQU	7489H	; play sample repeat flag
D7496	EQU	7496H	; audio keyboard flags
I7500	EQU	7500H	; temporary sample buffer
C7B00	EQU	7B00H	; midi hook
C7B05	EQU	7B05H	; audio keyboard key pressed/released hook
D7B0A	EQU	7B0AH	; (120*4*int freq)/2, NOT USED
D7B0C	EQU	7B0CH	; vdp i/o address
D7B0E	EQU	7B0EH	; slotid MSX-AUDIO
D7B0F	EQU	7B0FH	; current device PLAY
D7B10	EQU	7B10H	; previous device PLAY
D7B11	EQU	7B11H	; output to midi flag
D7B12	EQU	7B12H	; sample number for sample playvoice
D7B13	EQU	7B13H	; audio basic initialized
D7B14	EQU	7B14H	; in TIMER-1 handler flag
D7B15	EQU	7B15H	; number of FM-AUDIO playvoices
I7B16	EQU	7B16H	; number of channels per FM-AUDIO playvoice
D7B1F	EQU	7B1FH	; audio mode (0-7)
D7B20	EQU	7B20H	; playvoice mask
D7B22	EQU	7B22H	; total number of playvoices (includes 3 PSG voices)
D7B23	EQU	7B23H	; number of AUDIO playvoices (includes sample and drum voice)
D7B24	EQU	7B24H	; number of AUDIO playvoices, b7 set
D7B25	EQU	7B25H	; queue size
D7B26	EQU	7B26H	; playvoice active
D7B28	EQU	7B28H	; queued count
D7B29	EQU	7B29H	; background mode (0 = background)
I7B2A	EQU	7B2AH	; saved H.ERRO
D7B2F	EQU	7B2FH	; file open flag
D7B30	EQU	7B30H	; skipped queue service routine
D7B31	EQU	7B31H	; current playvoice serviced
D7B32	EQU	7B32H	; pointer to AUDIO queue controlblocks
I7B34	EQU	7B34H	; AUDIO queue controlblocks
I7B70	EQU	7B70H	; queue
I7CF0	EQU	7CF0H	; voice buffers audio playvoices (10*39)
D7E76	EQU	7E76H	; duration PSG playvoice 0
D7E78	EQU	7E78H	; duration PSG playvoice 1
D7E7A	EQU	7E7AH	; duration PSG playvoice 2
J7E7C	EQU	7E7CH	; old EXTBIO
D7E82	EQU	7E82H	; last sample ram block used 1st Y8950
D7E84	EQU	7E84H	; last sample ram block used 2nd Y8950
D7E86	EQU	7E86H	; number of samples in sample ROM 1st Y8950
D7E87	EQU	7E87H	; number of samples in sample ROM 2nd Y8950
D7E88	EQU	7E88H	; number of samples in AUDIO ROM
I7E89	EQU	7E89H	; general interrupt routine
D7EAA	EQU	7EAAH	; sample source
D7EBA	EQU	7EBAH	; sample destination
I7ECA	EQU	7ECAH	; sample definition used by audio keyboard
D7EDA	EQU	7EDAH	; default sample volume PCM
D7EDB	EQU	7EDBH	; default sample volume ADPCM
D7EDC	EQU	7EDCH	; audio keyboard key pressed/released
D7EDD	EQU	7EDDH	; audio keyboard key pressed which currently plays sample
D7EDE	EQU	7EDEH	; sample for audio keyboard
D7EDF	EQU	7EDFH	; b5 sample memory 2nd Y8950 in use, b4 sampler 2nd Y8950 in use, b1 sample memory 1st Y8950 in use, b0 sampler 1st Y8950 in use
D7EE0	EQU	7EE0H	; b1 audio keyboard sample 2nd Y8950 playing, b0 audio keyboard sample 1st Y8950 playing
D7EE1	EQU	7EE1H
I7EE2	EQU	7EE2H	; accompaniment counter
D7EE3	EQU	7EE3H	; audio keyboard accompaniment variation
D7EE4	EQU	7EE4H	; sample RAM size 1st Y8950 (256 bytes unit)
D7EE8	EQU	7EE8H	; sample RAM size 2nd Y8950 (256 bytes unit)
D7EEA	EQU	7EEAH
D7EEE	EQU	7EEEH	; VRAM mask
D7EF0	EQU	7EF0H	; number of audio keyboard keystrokes in buffer
D7EF1	EQU	7EF1H	; audio keyboard get offset keystroke buffer
D7EF2	EQU	7EF2H	; audio keyboard put offset keystroke buffer
D7EF3	EQU	7EF3H	; audio keyboard keystroke buffer (32 bytes)
I7F13	EQU	7F13H	; 16 sample definitions (8 bytes)
D7F93	EQU	7F93H	; primairy slot OR mask for MSX-AUDIO page 0 and 1
D7F94	EQU	7F94H	; secundairy slot OR mask for MSX-AUDIO page 0 and 1
D7F95	EQU	7F95H	; SLTTBL entry for MSX-AUDIO
D7F97	EQU	7F97H	; primary slot OR mask for MSX-AUDIO page 0,1 and 3
D7F98	EQU	7F98H	; saved orginal slotregisters
J7F9A	EQU	7F9AH	; old H.KEYI
I7FC4	EQU	7FC4H	; temporary stack
I7FC6	EQU	7FC6H	; interrupt corrector bytes of playvoices
D7FFE	EQU	7FFEH	; segment selector (hardware)
I7FFF	EQU	7FFFH	; Y8950 enabler (hardware)

J750B	EQU	750BH	; SYNTHE

I.8000	EQU	8000H	; ----I

C.F37D	EQU	0F37DH	; JC---
CLPRM1	EQU	0F398H	; -C---
QUEUES	EQU	0F3F3H	; ---L-
BUF	EQU	0F55EH	; J-SLI
VALTYP	EQU	0F663H	; ---LI
SUBFLG	EQU	0F6A5H	; --S--
STREND	EQU	0F6C6H	; --SL-
DAC	EQU	0F7F6H	; ----I
NULBUF	EQU	0F862H	; --SL-
FILNAM	EQU	0F866H	; ----I
MCLTAB	EQU	0F956H	; --SL-
MODE	EQU	0FAFCH	; ---L-
HOKVLD	EQU	0FB20H	; ----I
PRSCNT	EQU	0FB35H	; --SLI
SAVSP	EQU	0FB36H	; --SL-
VOICEN	EQU	0FB38H	; --SL-
SAVVOL	EQU	0FB39H	; --SL-
MCLLEN	EQU	0FB3BH	; --SLI
MCLPTR	EQU	0FB3CH	; --SL-
MUSICF	EQU	0FB3FH	; --SL-
PLYCNT	EQU	0FB40H	; --S-I
VCBA	EQU	0FB41H	; --S-I
VCBB	EQU	0FB66H	; --S--
VCBC	EQU	0FB8BH	; --S--
BASROM	EQU	0FBB1H	; ---L-
INTFLG	EQU	0FC9BH	; --SL-
EXPTBL	EQU	0FCC1H	; ---LI
SLTTBL	EQU	0FCC5H	; ----I
PROCNM	EQU	0FD89H	; ----I

H.KEYI	EQU	0FD9AH	; ----I
H.PHYD	EQU	0FFA7H	; ---L-
H.ERRO	EQU	0FFB1H	; J---I
H.PLAY	EQU	0FFC5H	; ----I
EXTBIO	EQU	0FFCAH	; ----I
D.FFFF	EQU	0FFFFH	; --S-I


KEYWRD	MACRO	X,Y
G	ASET	0
Q	ASET	0
        IRPC	D,<X>
        IF	G EQ 0
G	ASET	1
        ELSE
        IF	Q NE 0
        IF	Q EQ " "
        DEFB	0FFH
        ELSE
        DEFB	Q
        ENDIF
        ENDIF
Q	ASET	"&D"
        ENDIF
        ENDM
        DEFB	Q+128
        DEFW	Y
        ENDM

        DEFB	"AB"
D4002:	DEFW	C403E
        DEFW	C40EC
        DEFW	0
        DEFW	0

        DEFS	6,0

?4010:	JP	C6B64			; get from voicequeue serviced
?4013:	JP	J69EA			; clear playvoice bit voicequeue serviced

;	  Subroutine helper routine CALSLT
;	     Inputs  ________________________
;	     Outputs ________________________


?4016:	LD	(D.FFFF),A
        LD	A,C
        OUT	(0A8H),A
        LD	A,L
        AND	03H
        EX	(SP),HL
        LD	(HL),E
        PUSH	HL
        PUSH	BC
        EXX
        EX	AF,AF'
        CALL	CLPRM1
        EX	AF,AF'
        EXX
        POP	BC
        POP	HL
        POP	DE
        LD	A,I
        PUSH	AF
        DI
        LD	A,D
        OUT	(0A8H),A
        LD	A,B
        LD	(D.FFFF),A
        LD	A,C
        OUT	(0A8H),A
        JP	J0312

;	  Subroutine cartridge INIT
;	     Inputs  ________________________
;	     Outputs ________________________


C403E:	XOR	A
        LD	(D7FFE),A		; select segment 0
        CALL	C5CD8			; enable Y8950 on this MSX-AUDIO
        PUSH	DE			; save enable mask
        LD	B,1
        CALL	C4E23			; get slotid of page 1 (my slot)
        LD	(D7B0E),A
        CALL	C4DEC			; get slotmasks of my slot
        LD	HL,C7B00
        LD	(HL),0C9H
        LD	D,H
        LD	E,L
        INC	DE
        LD	BC,10-1
        LDIR				; initialize midi and audio keyboard hook
        LD	HL,(M0006)
        LD	(D7B0C),HL		; vdp i/o dataport addresses
        CALL	C4D83			; MSX-AUDIO in page 0
        CALL	C0090			; initialize AUDIO workspace
        LD	HL,(D7384)		; pointer to predefined instrument definitions (32-63)
        LD	DE,(D7382)		; pointer to programable instrument definitions (32-63)
        LD	BC,32*32
        LDIR				; initialize instrument definitions (32-63)
        CALL	C4D8F			; restore page 0
        POP	DE			; enable mask
        XOR	A
        LD	(D7B13),A		; AUDIO-BASIC not initialized
        DI
        LD	A,25
        OUT	(0C0H),A
        EX	(SP),HL
        EX	(SP),HL
        IN	A,(0C1H)		; read Y8950 I/O-DATA
        AND	04H			; b2 set ?
        JR	NZ,J4092		; yep, start synthesizer software
        LD	A,E
        AND	01H			; Y8950 on I/O adres 0C0H of this MSX-AUDIO ?
        RET	Z			; nope, quit (EXTBIO handle by other MSX-AUDIO)
        JP	J5C13			; initialize EXTBIO and quit

J4092:	DI
        LD	HL,I40A1
        LD	DE,BUF
        LD	BC,C40AF-I40A1
        LDIR
        JP	BUF

I40A1:	LD	A,1
        LD	(D7FFE),A		; select segment 1
        EX	(SP),HL
        EX	(SP),HL
        JP	Z,J750B			; invoked by CALL SYNTHE,
        LD	HL,(D4002)
        JP	(HL)


;	  Subroutine __________________________
;	     Inputs  ________________________
;	     Outputs ________________________


C40AF:	DI
        LD	HL,D7B13
        BIT	0,(HL)			; AUDIO-BASIC already initialized ?
        RET	NZ			; nope, quit
        SET	0,(HL)			; flag AUDIO-BASIC initialized
        LD	HL,H.KEYI
        LD	DE,J7F9A
        PUSH	HL
        CALL	C40DC
        LD	HL,I40E2
        POP	DE
        CALL	C40DC
        LD	A,(D7B0E)		; slotid MSX-AUDIO
        LD	(H.KEYI+1),A
        LD	HL,I40E7
        LD	DE,H.PLAY
        CALL	C40DC
        LD	(H.PLAY+1),A
        RET


;	  Subroutine __________________________
;	     Inputs  ________________________
;	     Outputs ________________________


C40DC:	LD	BC,5
        LDIR
        RET

I40E2:	RST	30H
        DEFB	0
        DEFW	C4D5E
        RET

I40E7:	RST	30H
        DEFB	0
        DEFW	C5F8E
        RET

;	  Subroutine cartridge STATEMENT handler
;	     Inputs  ________________________
;	     Outputs ________________________


C40EC:	EI
        PUSH	HL
        LD	HL,PROCNM
        CALL	C4267
        POP	HL
        RET	C
        PUSH	HL
        LD	HL,C4308
        OR	A
        SBC	HL,DE
        POP	HL
        JR	Z,J4111
        PUSH	HL
        LD	HL,C42EA
        OR	A
        SBC	HL,DE
        POP	HL
        JR	Z,J4111
        LD	A,(D7B13)
        AND	01H			; AUDIO-BASIC initialized ?
        SCF
        RET	Z			; nope, quit and flag "call statement not recognized"
J4111:	CALL	C411C			; check for enough stackspace
        CALL	C411A			; call routine
        EI
        OR	A			; flag "call statement recognized"
        RET

;	  Subroutine call routine
;	     Inputs  DE = routine
;	     Outputs ________________________


C411A:	PUSH	DE
        RET

;	  Subroutine check for enough stackspace
;	     Inputs  ________________________
;	     Outputs ________________________


C411C:	PUSH	HL
        PUSH	DE
        LD	HL,-768
        ADD	HL,SP			; 768 bytes of stackspace
        JP	NC,J6EB4
        LD	DE,(STREND)
        OR	A
        SBC	HL,DE
        JP	C,J6EB4
        POP	DE
        POP	HL
        RET

I4132:	DEFB	I.ST_A-I4148		; A
        DEFB	I.ST_B-I4148		; B
        DEFB	I.ST_C-I4148		; C
        DEFB	I.ST__-I4148		; D
        DEFB	I.ST__-I4148		; E
        DEFB	I.ST__-I4148		; F
        DEFB	I.ST__-I4148		; G
        DEFB	I.ST__-I4148		; H
        DEFB	I.ST_I-I4148		; I
        DEFB	I.ST__-I4148		; J
        DEFB	I.ST_K-I4148		; K
        DEFB	I.ST_L-I4148		; L
        DEFB	I.ST_M-I4148		; M
        DEFB	I.ST__-I4148		; N
        DEFB	I.ST__-I4148		; O
        DEFB	I.ST_P-I4148		; P
        DEFB	I.ST__-I4148		; Q
        DEFB	I.ST_R-I4148		; R
        DEFB	I.ST_S-I4148		; S
        DEFB	I.ST_T-I4148		; T
        DEFB	I.ST__-I4148		; U
        DEFB	I.ST_V-I4148		; V

I4148:
I.ST_A:	KEYWRD	<AUDIO>,C4308
        KEYWRD	<AUDREG>,C48BA
        KEYWRD	<APPEND MK>,C4981
        KEYWRD	<APEEK>,C4A2A
        KEYWRD	<APOKE>,C4A16
I.ST__:	DEFB	0FFH
I.ST_B:	KEYWRD	<BGM>,C43FB
        DEFB	0FFH
I.ST_C:	KEYWRD	<CONT MK>,C48B2
        KEYWRD	<COPY PCM>,C45AB
        KEYWRD	<CONVP>,C4603
        KEYWRD	<CONVA>,C45F1
        DEFB	0FFH
I.ST_I:	KEYWRD	<INMK>,C4AA4
        DEFB	0FFH
I.ST_K:	KEYWRD	<KEY ON>,C4408
        KEYWRD	<KEY OFF>,C442D
        DEFB	0FFH
I.ST_L:	KEYWRD	<LOAD PCM>,C57F1
        DEFB	0FFH
I.ST_M:	KEYWRD	<MK VOICE>,C5ED7
        KEYWRD	<MK VEL>,C4462
        KEYWRD	<MK VOL>,C447F
        KEYWRD	<MK TEMPO>,C44DF
        KEYWRD	<MK STAT>,C4A0E
        KEYWRD	<MK PCM>,C452E
        DEFB	0FFH
I.ST_R:	KEYWRD	<REC MK>,C499A
        KEYWRD	<RECMOD>,C456C
        KEYWRD	<REC PCM>,C514C
        DEFB	0FFH
I.ST_S:	KEYWRD	<STOPM>,C4879
        KEYWRD	<SET PCM>,C5021
        KEYWRD	<SAVE PCM>,C57EE
        KEYWRD	<SYNTHE>,C42EA
        DEFB	0FFH
I.ST_T:	KEYWRD	<TRANSPOSE>,C4A82
        KEYWRD	<TEMPER>,C4A92
        DEFB	0FFH
I.ST_V:	KEYWRD	<VOICE>,C5D42
        KEYWRD	<VOICE COPY>,C5DE1
        DEFB	0FFH
I.ST_P:	KEYWRD	<PLAY>,C5F36
        KEYWRD	<PLAY PCM>,C5157
        KEYWRD	<PCM FREQ>,C4581
        KEYWRD	<PCM VOL>,C44A8
        KEYWRD	<PLAY MK>,C49A6
        KEYWRD	<PITCH>,C4A7F
        DEFB	0FFH


;	  Subroutine __________________________
;	     Inputs  ________________________
;	     Outputs ________________________


C4267:	LD	A,(HL)
        SUB	"A"
        RET	C
        CP	16H
        CCF
        RET	C
        INC	HL
        PUSH	HL
        LD	HL,I4132
        CALL	C457C
        LD	A,(HL)
        LD	HL,I4148
        CALL	C457C
        EX	DE,HL
        POP	HL
J4280:	PUSH	HL
        LD	A,(DE)
        INC	A
        JR	Z,J4290
        CALL	C4293
        POP	HL
        JR	NZ,J4280
        EX	DE,HL
        LD	E,(HL)
        INC	HL
        LD	D,(HL)
        RET

J4290:	SCF
        POP	HL
        RET


;	  Subroutine __________________________
;	     Inputs  ________________________
;	     Outputs ________________________


C4293:	LD	A,(DE)
        LD	B,A
        AND	7FH
        CP	(HL)
        INC	DE
        INC	HL
        JR	NZ,J42A4
        LD	A,B
        OR	A
        JP	P,C4293
        LD	A,(HL)
        OR	A
        RET	Z
J42A4:	INC	B
        JR	NZ,J42B1
        DEC	HL
J42A8:	LD	A,(HL)
        CP	" "
        INC	HL
        JR	Z,J42A8
        DEC	HL
        JR	C4293

J42B1:	DEC	DE
J42B2:	LD	A,(DE)
        INC	DE
        INC	A
        JR	Z,J42B2
        DEC	A
        JP	P,J42B2
        INC	DE
        INC	DE
        RET

;	  Subroutine check for "(" and evaluate byte operand
;	     Inputs  ________________________
;	     Outputs ________________________


C42BE:	CALL	C4FB9			; check for "("
        JP	C6EFE			; evaluate byte operand

;	  Subroutine check for end of statement
;	     Inputs  ________________________
;	     Outputs ________________________


C42C4:	CALL	C4A0A			; end of statement ?
        JP	NZ,J6EA8		; nope, syntax error
        RET

;	  Subroutine evaluate parenthesized byte operand
;	     Inputs  ________________________
;	     Outputs ________________________


C42CB:	PUSH	BC
        CALL	C42BE			; check for "(" and evaluate byte operand
        JR	J42E4

;	  Subroutine evaluate parenthesized adres operand (unused code)
;	     Inputs  ________________________
;	     Outputs ________________________


?42D1:	PUSH	BC
        CALL	C4FB9			; check for "("
        JR	J42E1

;	  Subroutine evaluate two parenthesized adres operands (unused code)
;	     Inputs  ________________________
;	     Outputs ________________________


?42D7:	CALL	C4FB9			; check for "("
        CALL	C6EF8			; evaluate adres operand
        PUSH	DE
        CALL	C4FB4			; check for ","
J42E1:	CALL	C6EF8			; evaluate adres operand
J42E4:	CALL	C4FBE			; check for ")"
        POP	BC
        LD	A,E
        RET

;	  Subroutine CALL SYNTHE
;	     Inputs  ________________________
;	     Outputs ________________________


C42EA:	CALL	C42C4			; check for end of statement
        CALL	C42F3			; try to start synthesizer software
        JP	C6EAB			; AUDIO-BASIC initialized, illegal function call

;	  Subroutine try to start synthesizer software
;	     Inputs  ________________________
;	     Outputs ________________________


C42F3:	LD	A,(D7B13)
        AND	01H			; AUDIO-BASIC initialized ?
        JP	Z,J4092			; nope, start synthesizer software
        RET

I42FC:	DEFB	3			; number of FM-AUDIO playvoices
        DEFB	1			; mode 1
        DEFB	3			; keyboard channels
        DEFB	1,1,1,0,0,0,0,0,0

;	  Subroutine CALL AUDIO
;	     Inputs  ________________________
;	     Outputs ________________________


C4308:	PUSH	HL
        LD	HL,I42FC
        LD	DE,BUF
        LD	BC,12
        LDIR				; set defaults
        POP	HL
        CALL	C4A0A			; end of statement ?
        JR	Z,J4386			; yep, use defaults
        PUSH	HL
        LD	HL,BUF+0
        LD	DE,BUF+1
        LD	BC,12-1
        LD	(HL),0
        LDIR				; no defaults
        POP	HL
        CALL	C4FB9			; check for "("
        CP	","			; mode parameter not specified ?
        JR	Z,J4340			; yep, use 0
        CALL	C6EFE			; evaluate byte operand
        CP	8			; 0-7 ?
        JP	NC,C6EAB		; nope, illegal function call
        LD	(BUF+1),A
        LD	A,(HL)
        CP	")"			; end of statement ?
        JR	Z,J4380			; yep,
J4340:	CALL	C4FB4			; check for ","
        CP	","			; keyboard parameter not specified ?
        JR	Z,J4357			; yep, use 0
        CALL	C6EFE			; evaluate byte operand
        CP	10			; 0-9 ?
J434C:	JP	NC,C6EAB		; nope, illegal function call
        LD	(BUF+2),A
        LD	A,(HL)
        CP	")"			; end of statement ?
        JR	Z,J4380
J4357:	LD	B,9			; 9 FM-AUDIO playvoices max
        PUSH	HL
        LD	HL,BUF+3
        EX	(SP),HL
        LD	C,0			; start with playvoice 0
J4360:	CALL	C4FB4			; check for ","
        PUSH	BC
        CALL	C6EFE			; evaluate byte operand
        POP	BC
        OR	A			; 0 channels ?
        JR	Z,J434C			; yep, illegal function call
        CP	10			; more as 9 channels ?
        JR	NC,J434C		; yep, illegal function call
        EX	(SP),HL
        LD	(HL),A
        INC	HL
        INC	C
        EX	(SP),HL
        LD	A,(HL)
        CP	")"			; end of statement ?
        JR	Z,J437B			; yep,
        DJNZ	J4360
J437B:	LD	A,C
        LD	(BUF+0),A		; number of FM-AUDIO playvoices
        POP	BC
J4380:	CALL	C4FBE			; check for ")"
        JP	NZ,J6EA8		; not end of statement, syntax error
J4386:	PUSH	HL
        LD	HL,BUF+1
        LD	A,(HL)
        AND	01H
        LD	D,A
        ADD	A,A
        ADD	A,D			; drum mode uses 3 channels
        INC	HL
        ADD	A,(HL)			; channels use by keyboard
        INC	HL
        LD	D,A
        LD	A,(BUF+0)
        LD	B,A
        OR	A			; zero FM-AUDIO playvoices ?
        JR	Z,J43A0			; yep, skip
        XOR	A
J439C:	ADD	A,(HL)
        INC	HL
        DJNZ	J439C			; add the number of channels per playvoice
J43A0:	ADD	A,D
        CP	10			; total of channels 9 or less ?
        JR	NC,J434C		; nope, illegal function call
        CALL	C43AA
        POP	HL
        RET


;	  Subroutine __________________________
;	     Inputs  ________________________
;	     Outputs ________________________


C43AA:	DI
        LD	HL,BUF
        LD	A,(HL)
        LD	(D7B15),A		; number of FM-AUDIO playvoices
        INC	HL
        PUSH	HL
        INC	HL
        INC	HL
        LD	DE,I7B16
        LD	BC,9
        LDIR				; channels per FM-AUDIO playvoice
        POP	HL
        LD	B,(HL)			; mode
        INC	HL
        LD	A,(HL)			; number of keyboard channels
        LD	HL,0
        OR	A
J43C6:	JR	Z,J43D0
        SCF
        RR	H
        RR	L
        DEC	A
        JR	J43C6
J43D0:	ADD	HL,HL
        RL	A
        LD	L,H
        LD	H,A			; HL = keyboard channel mask
        LD	A,B
        LD	(D7B1F),A		; mode
        AND	01H			; drum mode ?
        JR	Z,J43E9			; nope,
        SRL	H
        RR	L
        SRL	H
        RR	L
        SRL	H
        RR	L			; remove 3 channels from the keyboard channel mask
J43E9:	EX	DE,HL
        PUSH	DE
        CALL	C6BD8
        CALL	C6C3C			; initialize playvoices
        CALL	C40AF			; hook H.KEYI/H.PLAY
        POP	DE			; keyboard channel mask
        CALL	C4E89
        JP	C6C9F

;	  Subroutine CALL BGM
;	     Inputs  ________________________
;	     Outputs ________________________


C43FB:	CALL	C42CB			; evaluate parenthesized byte operand
        CP	2			; 0-1 ?
        JP	NC,C6EAB		; nope, illegal function call
J4403:	DEC	A
        LD	(D7B29),A
        RET

;	  Subroutine CALL KEY ON
;	     Inputs  ________________________
;	     Outputs ________________________


C4408:	CALL	C42BE			; check for "(" and evaluate byte operand
        LD	A,E
        OR	A			; 0-127 ?
        JP	M,C6EAB			; nope, illegal function call
        PUSH	DE
        LD	A,(HL)
        CP	")"
        LD	E,8
        JR	Z,J4423
        CALL	C4FB4			; check for ","
        CALL	C6EFE			; evaluate byte operand
        CP	16			; 0-15 ?
        JP	NC,C6EAB		; nope, illegal function call
J4423:	CALL	C4FBE			; check for ")"
        POP	BC
        PUSH	HL
        LD	A,C
        OR	80H			; b7 set (key on)
        JR	J4439

;	  Subroutine CALL KEY OFF
;	     Inputs  ________________________
;	     Outputs ________________________


C442D:	CALL	C42CB			; evaluate parenthesized byte operand
        OR	A			; 0-127 ?
        JP	M,C6EAB			; nope, illegal function call
        AND	7FH			; b7 reset (key off)
        PUSH	HL
        LD	E,8
J4439:	LD	D,A
        LD	A,50
        CALL	C4D6A			; AUDIO function key on/off on audio keyboard channels
        POP	HL
        RET

;	  Subroutine evaluate one and optional two parenthesized adres operands
;	     Inputs  ________________________
;	     Outputs BC = operand1, DE = operand2 (=operand1 when only 1 operand specified)

C4441:	CALL	C4FB9			; check for "("
        CALL	C6EF8			; evaluate adres operand
        LD	A,(HL)
        CP	")"
        PUSH	DE
        JR	Z,J4453
        CALL	C4FB4			; check for ","
        CALL	C6EF8			; evaluate adres operand
J4453:	CALL	C4FBE			; check for ")"
        POP	BC
        LD	A,E
        RET

;	  Subroutine validate volume
;	     Inputs  ________________________
;	     Outputs ________________________


C4459:	LD	A,D
        AND	A
        SCF
        RET	NZ
        LD	A,E
        CP	64
        CCF
        RET

;	  Subroutine CALL MK VEL
;	     Inputs  ________________________
;	     Outputs ________________________


C4462:	CALL	C42CB			; evaluate parenthesized byte operand
        PUSH	HL
        CALL	C446E			; set audio keyboard velocity
        JP	C,C6EAB			; illegal function call
        POP	HL
        RET

;	  Subroutine set audio keyboard velocity
;	     Inputs  ________________________
;	     Outputs ________________________


C446E:	CP	16
        CCF
        RET	C
        LD	C,A			; velocity
        LD	B,1			; audio keyboard FM play enabled
        LD	A,3
        LD	HL,C00AB		; setup AUDIO
        CALL	C4D6D			; start routine in MSX-AUDIO BIOS
        AND	A
        RET

;	  Subroutine CALL MK VOL
;	     Inputs  ________________________
;	     Outputs ________________________


C447F:	CALL	C4441			; evaluate one and optional two parenthesized adres operands
        PUSH	HL
        CALL	C448B			; set audio keyboard volume
        JP	C,C6EAB			; illegal function call
        POP	HL
        RET

;	  Subroutine set audio keyboard volume
;	     Inputs  ________________________
;	     Outputs ________________________


C448B:	PUSH	BC
        LD	IY,I32C0
        CALL	C4499			; set audio keyboard volume 2nd Y8950
        POP	DE
        RET	C
        LD	IY,I3280
                                        ; set audio keyboard volume 1st Y8950

;	  Subroutine set audio keyboard volume Y8950
;	     Inputs  ________________________
;	     Outputs ________________________


C4499:	CALL	C4459			; validate volume
        RET	C			; invalid, quit with error
        CPL
        LD	E,A
        LD	C,15H
        LD	A,53
J44A3:	CALL	C4D6A			; AUDIO BIOS function
        AND	A
        RET

;	  Subroutine CALL PCM VOL
;	     Inputs  ________________________
;	     Outputs ________________________


C44A8:	CALL	C4441			; evaluate one and optional two parenthesized adres operands
        PUSH	HL
        CALL	C44B4			; set sample volume
        JP	C,C6EAB			; illegal function call
        POP	HL
        RET

;	  Subroutine set sample volume
;	     Inputs  ________________________
;	     Outputs ________________________


C44B4:	PUSH	BC
        LD	IY,I32C0
        CALL	C44C2			; set sample volume 2nd Y8950
        POP	DE
        RET	C
        LD	IY,I3280
                                        ; set sample volume 1st Y8950

;	  Subroutine set sample volume Y8950
;	     Inputs  ________________________
;	     Outputs ________________________


C44C2:	CALL	C4459			; validate volume
        RET	C
        PUSH	AF
        CPL
        AND	3FH
        LD	C,A
        LD	A,7			; ADPCM volume
        CALL	C4D6A			; AUDIO BIOS function
        POP	AF
        AND	38H
        RRA
        RRA
        RRA
        JR	NZ,J44D9
        INC	A
J44D9:	LD	C,A
        LD	A,4			; PCM volume
        JP	J44A3			; AUDIO BIOS function and quit

;	  Subroutine CALL MK TEMPO
;	     Inputs  ________________________
;	     Outputs ________________________



C44DF:	CALL	C4FB9			; check for "("
        LD	A,(HL)
        CP	","			; parameter not specified ?
        JR	Z,C4502			; yep, only evaluate variation and quit
        CALL	C6EF8			; evaluate adres operand
        LD	A,(HL)
        CP	")"			; end of parameterlist ?
        JR	Z,J44F6			; yep, finish
        PUSH	DE
        CALL	C4502			; evaluate audio keyboard accompaniment variation
        POP	DE
        JR	J44F9

J44F6:	CALL	C4FBE			; check for ")"
J44F9:	PUSH	HL
        CALL	C4514			; set audio keyboard accompaniment tempo
        POP	HL
        RET	NC
J44FF:	JP	C6EAB			; illegal function call

;	  Subroutine set audio keyboard variation
;	     Inputs  ________________________
;	     Outputs ________________________


C4502:	CALL	C4FB4			; check for ","
        CALL	C6EFE			; evaluate byte operand
        CALL	C4FBE			; check for ")"
        LD	A,E
        CP	32			; 0-31 ?
        JR	NC,J44FF		; nope, illegal function call
        LD	(D7EE3),A		; set audio keyboard variation
        RET

;	  Subroutine set audio keyboard accompaniment tempo
;	     Inputs  ________________________
;	     Outputs ________________________


C4514:	LD	HL,-(360+1)
        ADD	HL,DE
        RET	C
        LD	HL,-(24+1)
        ADD	HL,DE
        CCF
        RET	C
        LD	HL,6250
        EX	DE,HL
        CALL	C63B9			; 6250/tempo
        XOR	A
        SUB	E
        LD	C,A			; 256-val
        LD	A,18			; set TIMER-2
        JP	J44A3			; AUDIO BIOS function

;	  Subroutine CALL MK PCM
;	     Inputs  ________________________
;	     Outputs ________________________


C452E:	CALL	C4FB9			; check for "("
        CP	0EBH			; OFF token ?
        LD	E,0FFH
        JR	Z,J4540			; yep, use 255
        CALL	C6EFE			; evaluate byte operand
        INC	A
        JP	Z,C6EAB			; 255, illegal function call
        JR	J4543

J4540:	CALL	C6EEC			; read OFF token
J4543:	CALL	C4FBE			; check for ")"
        JP	NZ,J6EA8		; not end of statement, syntax error
        LD	A,E
        CALL	C4551			; set sample for audio keyboard
        JP	C,C6EAB			; illegal function call
        RET

;	  Subroutine set sample for audio keyboard
;	     Inputs  ________________________
;	     Outputs ________________________


C4551:	CP	0FFH
        JR	Z,J4564			; off,
        CP	16
        CCF				; sample 0-15 ?
        RET	C			; nope, quit with error
        PUSH	HL
        LD	(D7EDE),A		; set sample
        CALL	C4B7C			; scan audio keyboard enabled
        SET	4,(HL)			; audio keyboard play sample
J4562:	POP	HL
        RET

J4564:	PUSH	HL
        LD	HL,D7496
        RES	4,(HL)			; audio keyboard does not play sample
        JR	J4562

;	  Subroutine CALL RECMOD
;	     Inputs  ________________________
;	     Outputs ________________________


C456C:	CALL	C42CB			; evaluate parenthesized byte operand
        CALL	C4576
        JP	C,C6EAB			; illegal function call
        RET

;	  Subroutine set audio keyboard recording mode
;	     Inputs  ________________________
;	     Outputs ________________________


C4576:	LD	C,A
        LD	E,0
        JP	C49FF


;	  Subroutine __________________________
;	     Inputs  ________________________
;	     Outputs ________________________


C457C:	ADD	A,L
        LD	L,A
        RET	NC
        INC	H
        RET

;	  Subroutine CALL PCM FREQ
;	     Inputs  ________________________
;	     Outputs ________________________


C4581:	CALL	C4441			; evaluate one and optional two parenthesized adres operands
        PUSH	HL
        CALL	C458D			; set sample frequency
        JP	C,C6EAB			; illegal function call
        POP	HL
        RET

;	  Subroutine set sample frequency
;	     Inputs  ________________________
;	     Outputs ________________________


C458D:	PUSH	BC
        LD	IY,I32C0
        CALL	C459B			; set sample frequency 2nd Y8950
        POP	DE
        RET	C
        LD	IY,I3280
                                        ; set sample frequency 1st Y8950

;	  Subroutine set sample frequency Y8950
;	     Inputs  ________________________
;	     Outputs ________________________


C459B:	LD	HL,-49717
        ADD	HL,DE
        RET	C
        LD	HL,-1800
        ADD	HL,DE
        CCF
        RET	C
        LD	A,43
        JP	J44A3			; AUDIO BIOS function

;	  Subroutine CALL COPY PCM
;	     Inputs  ________________________
;	     Outputs ________________________


C45AB:	CALL	C4618			; evaluate "(" samplenumber,samplenumber
        LD	A,(HL)
        CP	")"			; end of parameters ?
        JR	Z,J45E8			; yep,
        CALL	C4FB4			; check for ","
        CP	","			; parameter not specified ?
        JR	Z,J45C6			; yep, use default
        CALL	C6EF8			; evaluate adres operand (source start offset)
        LD	(BUF+2),DE
        LD	A,(HL)
        CP	")"			; end of parameters ?
        JR	Z,J45E8			; yep,
J45C6:	CALL	C4FB4			; check for ","
        CP	","			; parameter not specified ?
        JR	Z,J45DE			; yep, use default
        CALL	C6EF8			; evaluate adres operand (length)
        LD	A,D
        OR	E			; 0 ?
        JP	Z,C6EAB			; yep, illegal function call
        LD	(BUF+4),DE
        LD	A,(HL)
        CP	")"			; end of parameters ?
        JR	Z,J45E8			; yep,
J45DE:	CALL	C4FB4			; check for ","
        CALL	C6EF8			; evaluate adres operand (destination start offset)
        LD	(BUF+6),DE
J45E8:	CALL	C4FBE			; check for ")"
        PUSH	HL
        CALL	C463F			; copy pcm sample
        JR	J4613			; finish

;	  Subroutine CALL CONVA
;	     Inputs  ________________________
;	     Outputs ________________________


C45F1:	CALL	C4618			; evaluate "(" samplenumber,samplenumber
        LD	A,(BUF+8)
        OR	A			; first samplenumber has "#" prefix ?
        JR	NZ,J4615		; yep, illegal function call
        CALL	C4FBE			; check for ")"
        PUSH	HL
        CALL	C46E8			; convert pcm to adpcm
        JR	J4613			; finish

;	  Subroutine CALL CONVP
;	     Inputs  ________________________
;	     Outputs ________________________


C4603:	CALL	C4618			; evaluate "(" samplenumber,samplenumber
        LD	A,(BUF+8)
        OR	A			; first samplenumber has "#" prefix ?
        JR	NZ,J4615		; yep, illegal function call
        CALL	C4FBE			; check for ")"
        PUSH	HL
        CALL	C4705			; convert adpcm to pcm
J4613:	POP	HL
        RET	NC
J4615:	JP	C6EAB			; illegal function call

;	  Subroutine evaluate "(" samplenumber,samplenumber
;	     Inputs  ________________________
;	     Outputs ________________________


C4618:	LD	DE,BUF
        LD	B,9
        XOR	A
J461E:	LD	(DE),A
        INC	DE
        DJNZ	J461E
        CALL	C4FB9			; check for "("
        CP	"#"
        JR	NZ,J462F
        LD	(BUF+8),A
        CALL	C6EEC			; read "#"
J462F:	CALL	C6EFE			; evaluate byte operand
        LD	(BUF+0),A
        CALL	C4FB4			; check for ","
        CALL	C6EFE			; evaluate byte operand
        LD	(BUF+1),A
        RET

;	  Subroutine copy pcm sample
;	     Inputs  ________________________
;	     Outputs ________________________


C463F:	LD	A,(BUF+8)
        OR	A			; first samplenumber has "#" prefix ?
        JR	NZ,J468D		; yep, get AUDIO ROM sample definition
        CALL	C4813			; copy both sampledefinitions
        RET	C			; error, quit
J4649:	EX	DE,HL			; source length
        LD	DE,(BUF+2)
        SCF
        SBC	HL,DE			; source start offset valid ?
        RET	C			; nope, quit with error
        INC	HL
        PUSH	HL
        LD	HL,BUF+16
        CALL	C486A			; adjust source start
        POP	HL
        LD	DE,(BUF+4)
        LD	A,D
        OR	E			; length = 0 ?
        JR	Z,J468A			; yep, use remain length
        SBC	HL,DE			; length valid ?
        RET	C			; too big, quit with error
J4666:	LD	(BUF+16+4),DE		; source length
        LD	DE,(BUF+6)		; destination start offset
        LD	HL,(BUF+32+4)
        SCF
        SBC	HL,DE			; valid ?
        RET	C			; nope, quit with error
        INC	HL
        PUSH	HL
        LD	HL,BUF+32
        CALL	C486A			; adjust destination start
        POP	HL
        LD	DE,(BUF+16+4)
        SBC	HL,DE			; destination length suficient ?
        LD	A,0
        JP	NC,J4719		; yep, start transfer
        RET

J468A:	EX	DE,HL
        JR	J4666

J468D:	LD	A,(D7E88)
        LD	B,A
        LD	A,(BUF+0)
        CP	B			; AUDIO ROM sample number valid ?
        CCF
        RET	C			; nope, quit with error
        LD	HL,I4FDD
        LD	DE,BUF+128
        LD	BC,E$4FDD-I4FDD
        LDIR				; routine for copying from segment 2 or 3
        DI
        LD	(BUF+254),SP		; save current stackpointer
        LD	SP,I7FC4
        CALL	C4FC3			; switch MSX-AUDIO in page 2
        LD	HL,(BUF+0)
        LD	H,0			; AUDIO ROM sample number
        ADD	HL,HL
        ADD	HL,HL
        ADD	HL,HL			; *8
        LD	BC,16
        ADD	HL,BC			; at offset 16
        LD	DE,BUF+16
        LD	BC,8
        CALL	BUF+128			; copy from segment 2 or 3
        CALL	C4FD5			; restore orginal page 2
        LD	SP,(BUF+254)		; restore stackpointer
        LD	A,(BUF+16)
        OR	01H
        LD	(BUF+16),A		; looks like sample ROM
        LD	A,(BUF+1)		; destination samplenumber
        LD	HL,BUF+32
        CALL	C4839			; copy sampledefinition
        RET	C			; error, quit
        LD	A,(HL)
        AND	05H
        DEC	A			; destination memorytype sample ROM ?
        LD	DE,(BUF+20)
        JP	NZ,J4649		; nope, continue
        SCF
        RET				; yep, quit with error

;	  Subroutine convert pcm to adpcm
;	     Inputs  ________________________
;	     Outputs ________________________


C46E8:	CALL	C480B			; validate source and destination
        RET	C			; invalid, quit with error
        RLA
        CCF				; source sampletype ADPCM ?
        RET	C			; yep, quit with error
        SRL	D
        RR	E			; length ADPCM = length PCM/2
        JR	NC,J46F9		; even number of bytes, ok
        LD	A,D
        OR	E			; only 1 byte PCM data ?
        SCF
        RET	Z			; yep, quit with error
J46F9:	PUSH	HL
        CALL	C47AF
        POP	HL
        RET	C
        RES	7,(HL)			; destination sampletype = ADPCM
        LD	A,3			; convert pcm to adpcm
        JR	J4719

;	  Subroutine convert adpcm to pcm
;	     Inputs  ________________________
;	     Outputs ________________________


C4705:	CALL	C480B			; validate source and destination
        RET	C			; invalid, quit with error
        RLA				; source sampletype PCM ?
        RET	C			; yep, quit with error
        SLA	E
        RL	D			; length PCM = length ADPCM*2
        PUSH	HL
        CALL	C47AF
        POP	HL
        RET	C
        SET	7,(HL)			; destination sampletype = PCM
        LD	A,2			; convert adpcm to pcm

;	  Subroutine transfer/convert
;	     Inputs  A = functionnumber
;	     Outputs ________________________


J4719:	PUSH	AF
        CALL	C521D			; wait for all samplers and sample memories to become ready
        JR	NZ,J4721		; not aborted by CTRL-STOP, continue
        POP	AF
        RET

J4721:	LD	A,33H
        LD	(D7EDF),A		; sampler and sample memory both Y8950 in use
        CALL	C4D83			; MSX-AUDIO in page 0
        LD	A,10
        LD	IY,I3280
        RST	00H			; abort sampling 1st Y8950
        LD	A,10
        LD	IY,I32C0
        RST	00H			; abort sampling 2st Y8950
        LD	A,(BUF+8)
        OR	A			; source a AUDIO ROM sample ?
        JR	NZ,J4751		; yep,
        POP	AF
        LD	IX,BUF+16		; source
        LD	IY,BUF+32		; destination
        LD	C,0
        RST	00H
J4749:	CALL	C4D8F			; restore page 0
        XOR	A
        LD	(D7EDF),A		; sampler and sample memory both Y8950 free
        RET

J4751:	POP	AF
        LD	A,4
        LD	(BUF+48+0),A		; temp source memorytype = RAM
        LD	HL,(NULBUF)
        LD	(BUF+48+2),HL		; temp source buffer = NULBUF
        LD	HL,(BUF+16+2)
        LD	H,L
        LD	L,0
        LD	(BUF+16+2),HL
J4766:	LD	HL,1
        LD	(BUF+48+4),HL		; temp source length = 1*256 bytes
        DI
        LD	(BUF+254),SP
        LD	SP,I7FC4
        CALL	C4FC3			; switch MSX-AUDIO in page 2
        LD	HL,(BUF+16+2)
        LD	DE,(NULBUF)
        LD	BC,256
        CALL	BUF+128			; copy AUDIO ROM sample data to temporary source buffer
        CALL	C4FD5			; restore orginal page 2
        LD	SP,(BUF+254)
        EI
        LD	IX,BUF+48
        LD	IY,BUF+32
        LD	A,0
        RST	00H			; transfer to destination
        LD	HL,BUF+16+3
        INC	(HL)			; source+256
        LD	HL,(BUF+32+2)
        INC	HL
        LD	(BUF+32+2),HL		; destination+1
        LD	HL,(BUF+16+4)
        DEC	HL
        LD	(BUF+16+4),HL		; decrease blocks source
        LD	A,H
        OR	L			; all blocks done ?
        JR	NZ,J4766		; nope, next block
        JR	J4749			; quit


;	  Subroutine __________________________
;	     Inputs  ________________________
;	     Outputs ________________________


C47AF:	LD	A,(HL)
        AND	07H
        LD	B,A
        AND	05H			; destination memory type sample RAM ?
        JR	NZ,J47EB		; nope,
        LD	A,B
        LD	(BUF+1),A		; save destination memory type
        CALL	C5428			; reserve sample RAM
        RET	C			; no sample RAM left, quit with error
        PUSH	HL
        INC	HL
        INC	HL
        LD	(HL),C
        INC	HL
        LD	(HL),B			; set start
        CALL	C47FF			; set length and sample frequency
        LD	A,(BUF+16)
        LD	B,A
        LD	A,(BUF+1)
        CP	B			; same sample ram ?
        JR	NZ,J47DB		; nope,
        LD	HL,(BUF+48)
        LD	DE,BUF+16
        CALL	C47DF			; copy sampledefinition, clear PCM and Y8950 bits
J47DB:	POP	HL
        LD	DE,BUF+32

;	  Subroutine copy sampledefinition, clear PCM and Y8950 bits
;	     Inputs  ________________________
;	     Outputs ________________________


C47DF:	PUSH	DE
        LD	BC,8
        LDIR
        POP	HL
        LD	A,(HL)
        AND	07H
        LD	(HL),A
        RET

J47EB:	PUSH	HL
        LD	HL,(BUF+32+4)
        SBC	HL,DE
        POP	HL
        RET	C
        INC	HL
        INC	HL
        INC	HL
        LD	A,B
        CP	4
        JR	NZ,C47FF
        INC	HL
        INC	HL
        JR	J4802


;	  Subroutine __________________________
;	     Inputs  ________________________
;	     Outputs ________________________

C47FF:	CALL	C4806
J4802:	LD	DE,(BUF+16+6)


;	  Subroutine __________________________
;	     Inputs  ________________________
;	     Outputs ________________________


C4806:	INC	HL
        LD	(HL),E
        INC	HL
        LD	(HL),D
        RET


;	  Subroutine __________________________
;	     Inputs  ________________________
;	     Outputs ________________________


C480B:	LD	DE,(BUF+0)
        LD	A,D
        CP	E			; source sample same as destination ?
        SCF
        RET	Z			; yep, quit with error

;	  Subroutine copy both sampledefinitions
;	     Inputs  ________________________
;	     Outputs ________________________


C4813:	LD	A,(BUF+0)		; source samplenumber
        LD	HL,BUF+16
        CALL	C4839			; copy sampledefinition
        RET	C
        PUSH	HL
        LD	A,(BUF+1)		; destination samplenumber
        LD	HL,BUF+32
        CALL	C4839			; copy sampledefinition
        POP	DE
        RET	C
        LD	A,(HL)
        AND	05H
        DEC	A			; destination memorytype sample ROM ?
        LD	A,(DE)			; source memorytype
        LD	(BUF+48),DE		; save source sampledefinition pointer
        LD	DE,(BUF+16+4)		; source length
        RET	NZ			; no sample ROM, quit
        SCF
        RET				; sample ROM, quit with error

;	  Subroutine copy sampledefinition
;	     Inputs  HL = source definition, A = destination samplenumber
;	     Outputs ________________________


C4839:	CP	16
        CCF				; samplenumber 0-15 ?
        RET	C			; nope, quit with error
        PUSH	HL
        CALL	C54F4			; get pointer to sample entry
        POP	DE
        PUSH	HL
        CALL	C47DF			; copy sampledefinition, clear PCM and Y8950 bits
        INC	HL
        INC	HL
        CP	4			; memorytype RAM ?
        JR	NZ,J4861		; nope, other
        PUSH	HL
        CALL	C4935			; search array variable
        POP	HL
        LD	(HL),C
        INC	HL
        LD	(HL),B			; start of array
        INC	HL
        INC	DE
        EX	DE,HL
        AND	A
        SBC	HL,BC
        EX	DE,HL			; size of array
        LD	(HL),D
        INC	HL
        LD	(HL),0
        POP	HL
        RET

J4861:	INC	HL
        INC	HL
        LD	A,(HL)
        INC	HL
        OR	(HL)			; length zero ?
        POP	HL
        RET	NZ			; nope, ok
        SCF
        RET				; yep, quit with error

;	  Subroutine adjust start
;	     Inputs  ________________________
;	     Outputs ________________________


C486A:	LD	A,(HL)
        INC	HL
        INC	HL
        CP	4			; memory type RAM ?
        LD	A,E
        JR	Z,J4875			; yep, that is in bytes, adjust high byte
        ADD	A,(HL)
        LD	(HL),A
        LD	A,D
J4875:	INC	HL
        ADC	A,(HL)
        LD	(HL),A
        RET

;	  Subroutine CALL STOPM
;	     Inputs  ________________________
;	     Outputs ________________________


C4879:	CALL	C4A0A			; end of statement ?
        JR	Z,C488C			; yep, stop all sound and quit
        CALL	C4FB9			; check for "("
        CALL	C488C			; stop all sound
        PUSH	DE
        CALL	C6ED8			; search variable
        EX	(SP),HL
        JP	J4A41			; put in variable, check for ")" and quit

;	  Subroutine stop all sound
;	     Inputs  ________________________
;	     Outputs ________________________


C488C:	PUSH	HL
        CALL	C6CDC			; stop background music
        CALL	C4D83			; MSX-AUDIO in page 0
        LD	IY,I3280
        LD	A,10
        RST	00H			; abort sampling 1st Y8950
        LD	IY,I32C0
        LD	A,10
        RST	00H			; abort sampling 2nd Y8950
        DI
        LD	HL,D7EDF
        LD	(HL),0			; sampler and sample memory both Y8950 free
        LD	A,57
        LD	E,1
        RST	00H			; audio function stop audio keyboard recording/replay
        CALL	C4D8F			; restore page 0
        POP	HL
        OR	A
        RET

;	  Subroutine CALL CONT MK
;	     Inputs  ________________________
;	     Outputs ________________________


C48B2:	CALL	C42C4			; check for end of statement
J48B5:	LD	E,2
        JP	C49FF

;	  Subroutine CALL AUDREG
;	     Inputs  ________________________
;	     Outputs ________________________


C48BA:	CALL	C4FB9			; check for "("
        CALL	C6EFE			; evaluate byte operand (register)
        PUSH	DE
        CALL	C4FB4			; check for ","
        CALL	C6EFE			; evaluate byte operand (value)
        PUSH	DE
        LD	A,(HL)
        CP	")"			; end of parameter list ?
        LD	E,0
        JR	Z,J48D5			; yep, use the 1st Y8950
        CALL	C4FB4			; check for ","
        CALL	C6EFE			; evaluate byte operand (Y8950 number)
J48D5:	CALL	C4FBE			; check for ")"
        LD	A,E
        CP	2			; Y8950 number 0-1 ?
        JP	NC,C6EAB		; nope, illegal function call
        LD	IY,I3280
        AND	A			; use 1st Y8950 ?
        JR	Z,J48E9
        LD	IY,I32C0		; nope, use 2nd Y8950
J48E9:	POP	DE
        POP	BC
        LD	A,E
        PUSH	HL
        LD	HL,C0099		; write AUDIO register (EI)
        CALL	C4D6D			; start routine in MSX-AUDIO BIOS
        POP	HL
        RET

;	  Subroutine setup audio and audio keyboard mode
;	     Inputs  ________________________
;	     Outputs ________________________


C48F5:	LD	C,8			; default audio keyboard velocity
        CALL	C4D83			; MSX-AUDIO in page 0
        LD	A,D
        OR	E			; keyboard channels ?
        PUSH	AF
        LD	B,0
        JR	Z,J4902			; nope, audio keyboard FM play disabled
        INC	B			; yep, audio keyboard FM play enabled
J4902:	PUSH	BC
        LD	HL,D3496
        RES	7,(HL)			; scan audio keyboard disabled
        LD	A,(D7B1F)		; mode
        PUSH	AF
        AND	04H			; b4
        LD	C,A
        RRCA
        OR	C
        RRCA
        LD	C,A			; 0 for mode 0-3, 3 for mode 4-7
        POP	AF
        ADD	A,A
        ADD	A,A
        AND	04H			; drum mode
        OR	C
        LD	C,A
        LD	A,0
        CALL	C00AB			; setup audio
        POP	BC
        LD	A,3
        CALL	C00AB			; setup audiokeyboard FM play and velocity
        LD	A,2
        CALL	C00AB			; setup audio
        POP	AF
        JR	Z,J4932			; no keyboard channels
        LD	HL,D3496
        SET	7,(HL)			; scan audio keyboard enabled
J4932:	JP	C4D8F			; restore page 0 and quit

;	  Subroutine search array variable
;	     Inputs  ________________________
;	     Outputs BC = start of array, DE = end of array

C4935:	LD	A,1
        LD	(SUBFLG),A
        CALL	C6ED8			; search variable
        JP	NZ,C6EAB		; illegal function call
        LD	(SUBFLG),A
        LD	A,(VALTYP)
        CP	3			; string ?
        JP	Z,C6EAB			; yep, illegal function call
        EX	DE,HL
        ADD	HL,BC
        DEC	HL
        EX	DE,HL			; end of array
        LD	A,(BC)
        SCF
        RLA
        ADD	A,C
        LD	C,A
        RET	NC
        INC	B
        RET

;	  Subroutine evaluate APPEND/REC/PLAY MK parameterlist
;	     Inputs  ________________________
;	     Outputs ________________________


C4957:	CALL	C4A0A			; end of statement ?
        RET	Z			; yep, quit (Zx set)
        CALL	C4FB9			; check for "("
        PUSH	HL
        CALL	C6EF8			; evaluate adres operand
        LD	A,(HL)
        CP	")"			; end of parameterlist ?
        JR	Z,J4976			; yep, search for array
        POP	AF
        PUSH	DE
        CALL	C4FB4			; check for ","
        CALL	C6EF8			; evaluate adres operand
        CALL	C4FBE			; check for ")"
        POP	BC
        XOR	A
        INC	A			; Cx reset, Zx reset
        RET

J4976:	POP	HL
        CALL	C4935			; search array variable
        CALL	C4FBE			; check for ")"
        SCF
        ADC	A,A
        RRA				; Cx set, Zx reset
        RET

;	  Subroutine CALL APPEND MK
;	     Inputs  ________________________
;	     Outputs ________________________


C4981:	CALL	C4957			; evaluate parameterlist
        JR	Z,J4997			; no parameters, illegal function call
        PUSH	BC
        POP	IX			; start of buffer
        LD	B,0FFH			; append rec
J498B:	PUSH	DE
        POP	IY
        LD	C,0
        JR	C,J4993			; array, c=000H
        DEC	C			; memory, c=0FFH
J4993:	CALL	C49D0			; start audio keyboard recording
        RET	NC			; no error, quit
J4997:	JP	C6EAB			; illegal function call

;	  Subroutine CALL REC MK
;	     Inputs  ________________________
;	     Outputs ________________________


C499A:	CALL	C4957			; evaluate parameterlist
        JR	Z,J4997			; no parameters, illegal function call
        PUSH	BC
        POP	IX
        LD	B,0			; new rec
        JR	J498B

;	  Subroutine CALL PLAY MK
;	     Inputs  ________________________
;	     Outputs ________________________


C49A6:	CALL	C4957			; evaluate parameterlist
        PUSH	BC
        POP	IX
        PUSH	DE
        POP	IY
        LD	B,0FFH
        JR	Z,J49B4			; no parameters, B=0FFH
        INC	B			; B=000H
J49B4:	LD	C,0
        JR	C,J49B9			; array
        DEC	C			; memory
J49B9:	LD	E,4			; start audio keyboard replay
        CALL	C49E8
        RET	C
        RET	NZ
J49C0:	EI
        CALL	C6B8D			; CTRL-STOP pressed ?
        DI
        JR	Z,J49DC			; yep,
        LD	A,(D7496)
        BIT	3,A			; still replaying ?
        JR	NZ,J49C0		; yep, wait
        OR	A
        RET

;	  Subroutine start audio keyboard recording
;	     Inputs  ________________________
;	     Outputs ________________________


C49D0:	LD	E,3			; start audio keyboard recording
        CALL	C49E8
        RET	C
        RET	NZ
J49D7:	EI
        CALL	C6B8D			; CTRL-STOP pressed ?
        DI
J49DC:	JP	Z,C488C			; yep, stop all sound and quit
        LD	A,(D7496)
        BIT	2,A			; still recording ?
        JR	NZ,J49D7		; yep, wait
        OR	A
        RET


;	  Subroutine __________________________
;	     Inputs  ________________________
;	     Outputs ________________________


C49E8:	LD	A,(D7EE1)
        OR	A
        JR	NZ,J49F0
        LD	C,0FFH
J49F0:	LD	A,(D7B29)
        OR	A			; background mode ?
        JR	Z,J49F8
        LD	C,0			; nope,
J49F8:	CALL	C49FF
        RET	C
        LD	A,C
        OR	A
        RET

;	  Subroutine audio keyboard bios function
;	     Inputs  ________________________
;	     Outputs ________________________


C49FF:	LD	A,57
        PUSH	HL
        CALL	C4B7C			; scan audio keyboard enabled
        CALL	C4D6A			; AUDIO BIOS function
        POP	HL
        RET

;	  Subroutine end of statement ?
;	     Inputs  ________________________
;	     Outputs ________________________


C4A0A:	DEC	HL
        JP	C6EEC

;	  Subroutine CALL MK STAT
;	     Inputs  ________________________
;	     Outputs ________________________


C4A0E:	CALL	C4FB9			; check for "("
        LD	DE,D3496
        JR	J4A33

;	  Subroutine CALL APOKE
;	     Inputs  ________________________
;	     Outputs ________________________


C4A16:	CALL	C4FB9			; check for "("
        CALL	C6EF8			; evaluate adres operand
        PUSH	DE
        CALL	C4FB4			; check for ","
        CALL	C6EFE			; evaluate byte operand
        CALL	C4FBE			; check for ")"
        LD	A,E
        POP	DE
        LD	(DE),A
        RET

;	  Subroutine CALL APEEK
;	     Inputs  ________________________
;	     Outputs ________________________


C4A2A:	CALL	C4FB9			; check for "("
        CALL	C6EF8			; evaluate adres operand
        CALL	C4FB4			; check for ","
J4A33:	PUSH	DE
        CALL	C6ED8			; search variable
        EX	(SP),HL
        CALL	C4D83			; MSX-AUDIO in page 0
        LD	L,(HL)
        LD	H,00H
        CALL	C4D8F			; restore page 0
J4A41:	CALL	C4A49			; put in DAC and convert and put in variable
        POP	HL
        CALL	C4FBE			; check for ")"
        RET

;	  Subroutine put in DAC and convert and put in variable
;	     Inputs  ________________________
;	     Outputs ________________________


C4A49:	LD	(DAC+2),HL
        LD	HL,VALTYP
        LD	A,(HL)
        CP	2
        JR	Z,J4A75
        CP	4
        JR	Z,J4A67
        CP	8
        JP	NZ,J6EAE
        LD	(HL),2
        PUSH	DE
        CALL	C6EDE			; convert DAC
        LD	C,8
        JR	J4A6F

J4A67:	LD	(HL),2
        PUSH	DE
        CALL	C6EDE			; convert DAC
        LD	C,4
J4A6F:	POP	DE
        LD	HL,DAC+0
        JR	J4A7A

J4A75:	LD	HL,DAC+2
        LD	C,2
J4A7A:	LD	B,0
        LDIR
        RET

;	  Subroutine CALL PITCH
;	     Inputs  ________________________
;	     Outputs ________________________


C4A7F:	LD	A,30
        DEFB	1

;	  Subroutine CALL TRANSPOSE
;	     Inputs  ________________________
;	     Outputs ________________________


C4A82:	LD	A,31
        PUSH	AF
        CALL	C4441			; evaluate one and optional two parenthesized adres operands
        POP	AF
J4A89:	PUSH	HL
        CALL	C4D6A			; AUDIO BIOS function
        POP	HL
        JP	C,C6EAB			; illegal function call
        RET

;	  Subroutine CALL TEMPER
;	     Inputs  ________________________
;	     Outputs ________________________


C4A92:	CALL	C42CB			; evaluate parenthesized byte operand
        LD	C,A
        LD	A,29
        JR	J4A89


;	  Subroutine __________________________
;	     Inputs  ________________________
;	     Outputs ________________________


C4A9A:	PUSH	AF
        PUSH	HL
        LD	A,28
        CALL	C4D6A			; AUDIO BIOS function
        POP	HL
        POP	AF
        RET

;	  Subroutine CALL INMK
;	     Inputs  ________________________
;	     Outputs ________________________


C4AA4:	EX	DE,HL
        CALL	C4B7C			; scan audio keyboard enabled
        LD	HL,0
        LD	(BUF+0),HL
        LD	(BUF+2),HL
        LD	(BUF+4),HL
        EX	DE,HL
        CALL	C4A0A			; end of statement ?
        JR	NZ,J4AC4		; nope, evaluate
        DI
        LD	(D7EF0),DE
        LD	(D7EF1),DE		; clear keystroke buffer
        RET

J4AC4:	CALL	C4FB9			; check for "("
        CP	","
        JR	Z,J4AD7
        CALL	C6ED8			; search variable
        LD	(BUF+0),DE
        LD	A,(HL)
        CP	")"			; end of parameterlist ?
        JR	Z,J4AF4			; yep,
J4AD7:	CALL	C4FB4			; check for ","
        CP	","
        JR	Z,J4AEA
        CALL	C6ED8			; search variable
        LD	(BUF+2),DE
        LD	A,(HL)
        CP	")"			; end of parameterlist ?
        JR	Z,J4AF4			; yep,
J4AEA:	CALL	C4FB4			; check for ","
        CALL	C6ED8			; search variable
        LD	(BUF+4),DE
J4AF4:	CALL	C4FBE			; check for ")"
        EX	DE,HL
        CALL	C4B59			; get from audio keyboard keystroke buffer
        EX	DE,HL
        LD	E,13H
        JP	C,J6EB6			; keystroke buffer overflow, device i/o error
        LD	DE,(BUF+0)
        INC	D
        DEC	D			; keynumber variable specified ?
        JR	Z,J4B10			; nope, skip
        PUSH	AF
        AND	7FH
        CALL	C4B32			; put in variable
        POP	AF
J4B10:	LD	DE,(BUF+2)
        INC	D
        DEC	D			; pressed/released variable specified ?
        JR	Z,J4B20			; nope, skip
        PUSH	AF
        RLCA
        AND	01H
        CALL	C4B32			; put in variable
        POP	AF
J4B20:	LD	DE,(BUF+4)
        INC	D
        DEC	D			; sample frequency variable specified ?
        RET	Z			; nope, quit
        AND	A
        JR	Z,C4B32			; put 0 in variable and quit
        PUSH	HL
        CALL	C4C73			; get sample frequency for key
        LD	H,B
        LD	L,C
        JR	J4B36			; put in variable and quit

;	  Subroutine put in variable
;	     Inputs  A = value, DE = address variable
;	     Outputs ________________________


C4B32:	PUSH	HL
        LD	L,A
        LD	H,0
J4B36:	CALL	C4A49			; put in DAC and convert and put in variable
        POP	HL
        RET

;	  Subroutine put in audio keyboard keystroke buffer
;	     Inputs  ________________________
;	     Outputs ________________________


C4B3B:	LD	HL,D7EF0
        DI
        LD	A,32
        CP	(HL)			; >32 ?
        JR	C,J4B57			; yep, quit
        INC	(HL)			; increase
        CP	(HL)			; >32 ?
        JR	C,J4B57			; yep, quit
        INC	HL
        INC	HL
        INC	(HL)			; increase
        LD	A,(HL)
        CP	32			; >31 ?
        JR	C,J4B52
        LD	(HL),0			; yep, reset to zero
J4B52:	CALL	C457C			; get table entry
        LD	(HL),D
        AND	A
J4B57:	EI
        RET

;	  Subroutine get from audio keyboard keystroke buffer
;	     Inputs  ________________________
;	     Outputs ________________________


C4B59:	LD	HL,D7EF0
        DI
        LD	A,(HL)
        AND	A
        JR	Z,J4B68
        LD	A,32
        CP	(HL)
        JR	NC,J4B6A
        LD	(HL),0
J4B68:	EI
        RET

J4B6A:	DEC	(HL)
        INC	HL
        INC	(HL)
        LD	A,(HL)
        CP	32
        JR	C,J4B74
        LD	(HL),0
J4B74:	INC	HL
        CALL	C457C
        LD	A,(HL)
        AND	A
        EI
        RET

;	  Subroutine scan audio keyboard enabled
;	     Inputs  ________________________
;	     Outputs ________________________


C4B7C:	LD	HL,D7496
        SET	7,(HL)
        RET

;	  Subroutine AST MK
;	     Inputs  ________________________
;	     Outputs ________________________


I4B82:	CALL	C7B05			; hook ?
        CALL	C4B3B			; put in audio keyboard keystroke buffer
        LD	A,D
        LD	(D7EDC),A
        LD	A,(D3496)
        BIT	4,A			; audio keyboard play sample ?
        PUSH	AF
        CALL	NZ,C4BC1		; yep, key on/off sample
        POP	AF
        BIT	2,A			; recording ?
        RET	Z			; nope, quit
        BIT	0,A			; mode 0 or 2 ?
        RET	Z			; yep, quit

;	  Subroutine save in recording buffer
;	     Inputs  ________________________
;	     Outputs ________________________


C4B9C:	LD	HL,I34A4
        LD	A,(HL)
        LD	(HL),0			; clear recording timer
        LD	HL,(D3497)
        LD	(HL),A			; timecode
        INC	HL
        LD	(HL),D			; keycode
        INC	HL
        BIT	7,D
        JR	Z,J4BAF
        LD	(HL),E
        INC	HL
J4BAF:	LD	(D3497),HL
        LD	BC,(D349B)
        DEC	BC
        AND	A
        SBC	HL,BC
        RET	C
        LD	HL,D3496
        RES	2,(HL)			; stop recording
        RET

;	  Subroutine key on/off sample
;	     Inputs  ________________________
;	     Outputs ________________________


C4BC1:	LD	A,(D7EDD)
        BIT	7,D			; key released ?
        JR	Z,J4C33			; yep,
        LD	A,D
        LD	(D7EDD),A		; store key pressed
        LD	A,(D7EDE)		; sample for audio keyboard
J4BCF:	PUSH	DE
        CALL	C54F4			; get pointer to sample entry
        POP	DE
        LD	A,(HL)
        OR	A			; PCM sample ?
        RET	M			; yep, quit
        AND	05H			; sample RAM ?
        JR	Z,J4BDD			; yep,
        DEC	A			; sample ROM ?
        RET	NZ			; nope, quit
J4BDD:	PUSH	HL
        INC	HL
        INC	HL
        INC	HL
        INC	HL
        LD	A,(HL)
        INC	HL
        OR	(HL)
        POP	HL
        RET	Z
        LD	A,(HL)
        AND	02H			; 1st Y8950 ?
        LD	A,(D7EDF)
        JR	Z,J4BF8			; yep,
        LD	IY,I32C0
        AND	10H			; sample memory 2nd Y8950 in use ?
        RET	NZ			; yep, quit
        JR	J4BFF

J4BF8:	LD	IY,I3280
        AND	01H			; sample memory 1st Y8950 in use ?
        RET	NZ			; yep, quit
J4BFF:	PUSH	HL
        CALL	C4C72			; get sample frequency for key
        POP	HL
        LD	(I7ECA+6),BC		; sample frequency
        PUSH	DE
        LD	DE,I7ECA
        PUSH	DE
        LD	BC,6
        LDIR
        POP	IX
        LD	HL,D7EE0
        LD	A,(IX+0)
        AND	07H
        LD	(IX+0),A
        AND	02H			; 1st Y8950 ?
        JR	Z,J4C27			; yep,
        SET	1,(HL)			; audio keyboard sample on 2nd Y8950 playing
        JR	J4C29

J4C27:	SET	0,(HL)			; audio keyboard sample on 1st Y8950 playing
J4C29:	LD	A,10
        RST	00H			; abort sampling
        LD	C,7
        LD	A,11
        RST	00H			; play sample
        POP	DE
        RET

J4C33:	AND	7FH
        SUB	D			; key released = key pressed ?
        RET	NZ			; nope, quit
        LD	(D7EDD),A		; no sample playing from audio keyboard
J4C3A:	PUSH	DE
        LD	A,(D7EE0)
        PUSH	AF
        AND	01H			; audio keyboard sample on 1st Y8950 playing ?
        JR	Z,J4C57			; nope, skip sample abort
        LD	A,10
        LD	IY,I3280
        RST	00H			; abort sampling 1st Y8950
        DI
        LD	HL,D7EDF
        LD	A,0F0H
        AND	(HL)
        LD	(HL),A			; sampler and sample memory 1st Y8950 free
        LD	HL,D7EE0
        RES	0,(HL)			; audio keyboard sample on 1st Y8950 stopped
J4C57:	POP	AF
        AND	02H			; audio keyboard sample on 2nd Y8950 playing ?
        JR	Z,J4C70			; nope, skip sample abort
        LD	A,10
        LD	IY,I32C0
        RST	00H			; abort sampling 2nd Y8950
        DI
        LD	HL,D7EDF
        LD	A,0FH
        AND	(HL)
        LD	(HL),A			; sampler and sample memory 2nd Y8950 free
        LD	HL,D7EE0
        RES	1,(HL)			; audio keyboard sample on 2nd Y8950 stopped
J4C70:	POP	DE
        RET

;	  Subroutine get sample frequency for key
;	     Inputs  ________________________
;	     Outputs ________________________


C4C72:	LD	A,D

;	  Subroutine get sample frequency for key
;	     Inputs  ________________________
;	     Outputs ________________________


C4C73:	ADD	A,A
        LD	HL,I4CA0
        LD	BC,0818H
        CP	0A8H
        JR	C,J4C8C
        SUB	0A8H
J4C80:	SUB	C
        JP	NC,J4C80
        ADD	A,C
        CALL	C457C
        LD	C,(HL)
        INC	HL
        LD	B,(HL)
        RET

J4C8C:	DEC	B
        SUB	C
        JP	NC,J4C8C
        ADD	A,C
        CALL	C457C
        LD	C,(HL)
        INC	HL
        LD	A,(HL)
J4C98:	AND	A
        RRA
        RR	C
        DJNZ	J4C98
        LD	B,A
        RET

I4CA0:	DEFW	06336H
        DEFW	0691DH
        DEFW	06F5DH
        DEFW	075FCH
        DEFW	07D00H
        DEFW	0846FH
        DEFW	08C4FH
        DEFW	094A7H
        DEFW	09D7DH
        DEFW	0A6DBH
        DEFW	0B0C7H
        DEFW	0BB4AH

;	  Subroutine TIMER-2 handler
;	     Inputs  ________________________
;	     Outputs ________________________


I4CB8:	LD	A,(D3496)
        BIT	2,A			; audio keyboard recording ?
        CALL	NZ,C4CED		; yep, increase audio keyboard recording counter
        PUSH	AF
        OR	A			; scan audio keyboard enabled ?
        CALL	M,C00B1			; yep, scan audio keyboard
        POP	AF
        BIT	3,A			; audio keyboard replaying ?
        CALL	NZ,C4D01		; yep,
        LD	HL,I7EE2
        DEC	(HL)
        RET	NZ
        LD	(HL),30
        LD	A,(D7EE3)
        AND	A			; audio keyboard accompaniment variation set ?
        RET	Z			; nope, quit
        LD	C,A
        LD	A,21
        RST	00H			; audio function play percussion
        RET

;	  Subroutine AST ADPCM 2nd Y8950
;	     Inputs  ________________________
;	     Outputs ________________________


I4CDC:	LD	A,0FH
        DEFB	021H

;	  Subroutine AST ADPCM 1st Y8950
;	     Inputs  ________________________
;	     Outputs ________________________


I4CDF:	LD	A,0F0H
        LD	HL,D7EDF
        DI
        AND	(HL)
        LD	(HL),A			; sampler and sample memory free
        XOR	A
        LD	(D7EDD),A		; no sample playing from audio keyboard
        EI
        RET


;	  Subroutine __________________________
;	     Inputs  ________________________
;	     Outputs ________________________


C4CED:	DI
        LD	HL,I34A4
        INC	(HL)			; increase timer
        RET	NZ
        INC	(HL)
        LD	HL,(D3497)
        LD	(HL),0FFH		; timecode
        INC	HL
        LD	(HL),7FH		; keycode (= no key)
        INC	HL
        LD	(D3497),HL
        RET


;	  Subroutine __________________________
;	     Inputs  ________________________
;	     Outputs ________________________


C4D01:	DI
        LD	HL,D34A3
        LD	A,(HL)
        AND	A
        JR	Z,J4D0B
        DEC	(HL)
        RET	NZ
J4D0B:	LD	HL,(D349D)
        INC	HL
        LD	D,(HL)			; keycode
        INC	HL
        LD	E,8
        BIT	7,D
        JR	Z,J4D19
        LD	E,(HL)
        INC	HL
J4D19:	LD	(D349D),HL
        LD	A,D
        AND	A
        JR	Z,J4D42
        CP	7FH
        JR	Z,J4D42
        CP	7EH			; end marker ?
        JR	Z,J4D52			; yep, stop replay
        PUSH	HL
        LD	A,(D3496)
        BIT	2,A			; audio keyboard recording ?
        JR	Z,J4D37			; nope,
        BIT	1,A			; mode 2 or 3 ?
        PUSH	AF
        CALL	NZ,C4B9C		; yep, save in recording buffer
        POP	AF
J4D37:	BIT	4,A			; audio keyboard play sample ?
        CALL	NZ,C4BC1		; yep, key on/off sample
        LD	A,50
        RST	00H			; AUDIO function key on/off on audio keyboard channels
        DI
        POP	HL
        AND	A
J4D42:	LD	A,(HL)
        LD	BC,(D34A1)
        SBC	HL,BC
        JR	NC,J4D52
        AND	A
        JR	Z,J4D0B
        LD	(D34A3),A
        RET

J4D52:	LD	HL,D3496
        RES	3,(HL)			; stop keyboard replay
        BIT	2,(HL)			; audio keyboard recording ?
        RET	NZ			; yep, quit
        LD	A,49
        RST	00H			; AUDIO function key off on audio keyboard channels
        RET

;	  Subroutine H.KEYI handler
;	     Inputs  ________________________
;	     Outputs ________________________


C4D5E:	DI
        PUSH	HL
        LD	HL,C00B4		; interrupt handler AUDIO
        CALL	C4D6D			; start routine in MSX-AUDIO BIOS
        POP	HL
        JP	J7F9A			; continue in old H.KEYI

;	  Subroutine start AUDIO BIOS function
;	     Inputs  ________________________
;	     Outputs ________________________


C4D6A:	LD	HL,C00AE		; function AUDIO

;	  Subroutine start routine in MSX-AUDIO BIOS
;	     Inputs  ________________________
;	     Outputs ________________________


C4D6D:	EX	AF,AF'
        EXX
        CALL	C4D9B			; select MSX-AUDIO in page 0
        DI
        PUSH	BC			; save slotregisters
        EXX
        EX	AF,AF'
        CALL	C4D82
        EX	AF,AF'
        EXX
        POP	BC			; saved slotregisters
        CALL	C4DD0			; restore page 0
        EXX
        EX	AF,AF'
        RET


;	  Subroutine __________________________
;	     Inputs  ________________________
;	     Outputs ________________________


C4D82:	JP	(HL)

;	  Subroutine save current page 0 and select MSX-AUDIO in page 0
;	     Inputs  ________________________
;	     Outputs ________________________


C4D83:	EX	AF,AF'
        EXX
        CALL	C4D9B			; select MSX-AUDIO in page 0
        LD	(D7F98),BC		; save orginal slotregisters
        EXX
        EX	AF,AF'
        RET

;	  Subroutine restore page 0
;	     Inputs  ________________________
;	     Outputs ________________________


C4D8F:	EX	AF,AF'
        EXX
        LD	BC,(D7F98)
        CALL	C4DD0
        EXX
        EX	AF,AF'
        RET

;	  Subroutine select MSX-AUDIO in page 0
;	     Inputs  ________________________
;	     Outputs ________________________


C4D9B:	LD	A,I
        PUSH	AF
        DI
        IN	A,(0A8H)
        LD	B,A
        AND	0F0H
        LD	HL,(D7F93)
        OR	L
        OUT	(0A8H),A		; select MSX-AUDIO primairy slot in page 0 and 1
        BIT	7,H			; is MSX-AUDIO in expanded slot ?
        JR	NZ,J4DCC		; nope, done
        LD	E,A
        LD	D,H
        LD	HL,(D7F95)
        LD	A,(HL)			; secundairy slotregister of primary slot MSX-AUDIO
        LD	C,A
        AND	0FH
        CP	D			; are page 0 and 1 already in correct secundairy slot ?
        JR	Z,J4DCC			; yep, done
        LD	A,C
        AND	0F0H
        OR	D
        LD	(HL),A			; update SLTTBL with new secundairy slot register
        LD	D,A
        LD	A,(D7F97)
        OUT	(0A8H),A		; select primary slot MSX-AUDIO in page 0,1 and 3
        LD	A,D
        LD	(D.FFFF),A		; write secundairy slot register
        LD	A,E
        OUT	(0A8H),A		; restore page 3
J4DCC:	POP	AF
        RET	PO
        EI
        RET


;	  Subroutine __________________________
;	     Inputs  ________________________
;	     Outputs ________________________


C4DD0:	LD	A,I
        DI
        LD	A,(D7F94)
        RLA
        JR	C,J4DE6
        LD	HL,(D7F95)
        LD	(HL),C
        LD	A,(D7F97)
        OUT	(0A8H),A
        LD	A,C
        LD	(D.FFFF),A
J4DE6:	LD	A,B
        OUT	(0A8H),A
        RET	PO
        EI
        RET

;	  Subroutine get slotmasks of page 1 (my slot)
;	     Inputs  ________________________
;	     Outputs ________________________


C4DEC:	LD	E,A
        RLCA
        RLCA
        CALL	C4E1A
        AND	0FH
        LD	(D7F93),A		; primairy slot OR mask for MSX-AUDIO page 0 and 1
        LD	B,A
        AND	03H
        LD	HL,SLTTBL
        ADD	A,L
        LD	L,A
        LD	(D7F95),HL		; SLTTBL entry for MSX-AUDIO
        LD	A,0FFH
        LD	(D7F94),A
        LD	A,E
        AND	A
        RET	P
        CALL	C4E1A
        AND	0FH
        LD	(D7F94),A		; secundairy slot OR mask for MSX-AUDIO page 0 and 1
        LD	A,B
        RRCA
        RRCA
        OR	B
        LD	(D7F97),A		; primary slot OR mask for MSX-AUDIO page 0,1 and 3
        RET


;	  Subroutine __________________________
;	     Inputs  ________________________
;	     Outputs ________________________


C4E1A:	AND	0FCH
        LD	D,A
        RRCA
        RRCA
        AND	03H
        OR	D
        RET

;	  Subroutine get slotid of page
;	     Inputs  B = page
;	     Outputs ________________________


C4E23:	IN	A,(0A8H)
        CALL	C4E45
        AND	03H
        LD	E,A
        LD	D,00H
        LD	HL,EXPTBL
        ADD	HL,DE
        LD	A,(HL)
        AND	80H
        OR	E
        RET	P
        LD	E,A
        INC	HL
        INC	HL
        INC	HL
        INC	HL
        LD	A,(HL)
        RLCA
        RLCA
        CALL	C4E45
        AND	0CH
        OR	E
        RET


;	  Subroutine __________________________
;	     Inputs  ________________________
;	     Outputs ________________________


C4E45:	INC	B
        DEC	B
        RET	Z
        PUSH	BC
J4E49:	RRCA
        RRCA
        DJNZ	J4E49
        POP	BC
        RET

I4E4F:	PUSH	AF
        PUSH	BC
        PUSH	DE
        PUSH	HL
        EXX
        EX	AF,AF'
        PUSH	IX
        PUSH	IY
        LD	IX,KEYINT
        LD	IY,(EXPTBL+0-1)
        CALL	CALSLT
        POP	IY
        POP	IX
        EX	AF,AF'
        EXX
J4E6A:	POP	HL
        POP	DE
        POP	BC
        POP	AF
        EI
        RET
E$4E4F:

I4E70:	DEFB	4			; default sample volume PCM
        DEFB	0			; default sample volume ADPCM
        DEFB	0
        DEFB	0			; no sample playing from audio keyboard
        DEFB	0			; samplenumber used for audio keyboard
        DEFB	0			; sample flags
        DEFB	0			; audio keyboard sample playing flags
        DEFB	1
        DEFB	30			; accompaniment counter
        DEFB	0			; accompaniment variation
        DEFW	128			; sample ram size 1st Y8950
        DEFW	-1			; sample ram size 2nd Y8950
        DEFW	0
        DEFW	0
        DEFW	0FFFFH			; VRAM mask
        DEFB	040H
        DEFB	0,0,0,0


;	  Subroutine __________________________
;	     Inputs  ________________________
;	     Outputs ________________________


C4E89:	PUSH	DE
        DI
        CALL	C4D83			; MSX-AUDIO in page 0
        CALL	C0090			; initialize AUDIO workspace
        LD	HL,I4E4F
        LD	DE,I7E89
        LD	BC,E$4E4F-I4E4F
        LDIR				; copy general interrupt handler
        LD	HL,I4E70
        LD	DE,D7EDA
        LD	BC,25
        LDIR
        LD	A,0C3H
        LD	(D7300+0),A
        LD	HL,I3E89
        LD	(D7300+1),HL		; general interrupt handler
        LD	HL,0C937H
        LD	(D7308),HL		; VDP interrupts are not handled
        LD	HL,I6828
        LD	(D7340+1),HL		; TIMER-1 handler service playqueues
        LD	HL,I4CB8
        LD	(D7344+1),HL		; TIMER-2 handler service audio keyboard
        LD	HL,I4B82
        LD	(D7370),HL		; AST MK
        LD	HL,I4CDF
        LD	(D7372),HL		; AST ADPCM 1st Y8950
        LD	HL,I4CDC
        LD	(D7374),HL		; AST ADPCM 2nd Y8950
        LD	IY,I3280
        CALL	C4F6D			; set sample volume 1st Y8950
        LD	IY,I32C0
        CALL	C4F6D			; set sample volume 2nd Y8950
        LD	DE,D.FFFF
        LD	A,(D72A3)		; sample RAM size 1st Y8950
        CALL	C4F64
        LD	(D7EE4),HL		; sample RAM size 1st Y8950 in 256 bytes units
        LD	A,(D7391)
        BIT	0,A			; 2nd Y8950 found ?
        JR	NZ,J4F04		; nope,
        LD	A,(D72E3)		; sample RAM size 2nd Y8950
        CALL	C4F64
        LD	(D7EE8),HL		; sample ram size 2nd Y8950 in 256 bytes units
        LD	(D7EEA),DE
J4F04:	LD	A,(MODE)
        LD	HL,63
        AND	06H
        JR	Z,J4F14			; 16 KB VRAM, 63
        LD	L,E
        CP	02H
        JR	Z,J4F14			; 64 KB VRAM, 255
        INC	H			; 128 KB VRAM, 511
J4F14:	LD	(D7EEE),HL		; VRAM mask
        CALL	C4D8F			; restore page 0
        LD	HL,I7F13
        LD	E,L
        LD	D,H
        INC	DE
        PUSH	DE
        LD	BC,16*8-1
        LD	(HL),0
        LDIR				; clear
        POP	HL			; sample entry 0 = sample ram 1st Y8950
        INC	HL
        INC	HL
        INC	HL			; sample start = 0
        LD	(HL),LOW 128		; sample length = 128 blocks
        INC	HL
        INC	HL
        LD	(HL),LOW 8000
        INC	HL
        LD	(HL),HIGH 8000		; sample frequency = 8000
        LD	HL,128-1
        LD	(D7E82),HL
        LD	HL,-1
        LD	(D7E84),HL
        LD	A,30
        LD	(D7E88),A		; number of samples in AUDIO ROM
        POP	DE			; keyboard channel mask
        CALL	C48F5			; setup audio and audio keyboard mode
        CALL	C4D83			; MSX-AUDIO in page 0
        LD	A,17
        LD	C,98H			; every 8.32 ms TIMER-1 interrupt (120 Hz)
        RST	00H			; set TIMER-1 counter
        LD	A,18
        LD	C,0CCH			; every 16.64 ms TIMER-1 interrupt (60 Hz)
        RST	00H			; set TIMER-2 counter
        LD	A,16
        LD	C,3			; do not mask TIMER-1, TIMER-2
        RST	00H			; start TIMER-1,TIMER-2 and set TIMER masks
        CALL	C4D8F			; restore page 0
        CALL	C4F7C			; count number of samples in sample ROM
        EI
        RET

;	  Subroutine sample ram size in 256 bytes units
;	     Inputs  ________________________
;	     Outputs ________________________


C4F64:	AND	A
        RRA
        LD	H,A
        LD	L,0
        RR	L
        DEC	HL
        RET

;	  Subroutine set sample volume
;	     Inputs  ________________________
;	     Outputs ________________________


C4F6D:	LD	A,(D7EDA)
        LD	C,A
        LD	A,4
        RST	00H
        LD	A,(D7EDB)
        LD	C,A
        LD	A,7
        RST	00H
        RET


;	  Subroutine __________________________
;	     Inputs  ________________________
;	     Outputs ________________________


C4F7C:	LD	A,1			; source memory type = sample ROM 1st Y8950
        CALL	C4F8D
        LD	(D7E86),A		; number of samples in sample ROM 1st Y8950
        LD	A,3			; source memory type = sample ROM 2nd Y8950
        CALL	C4F8D
        LD	(D7E87),A		; number of samples in sample ROM 2nd Y8950
        RET


;	  Subroutine __________________________
;	     Inputs  ________________________
;	     Outputs ________________________


C4F8D:	CALL	C550A			; get sample rom directory
        XOR	A
        LD	D,A
        LD	HL,I7500
        LD	A,(HL)
        CP	"A"
        JR	NZ,J4FB2
        INC	HL
        LD	A,(HL)
        CP	"B"			; valid "AB" header ?
        JR	NZ,J4FB2		; nope, no sample rom
        LD	BC,20-1
        ADD	HL,BC			; start at offset 16+4
J4FA4:	LD	A,(HL)
        INC	HL
        OR	(HL)			; sample length zero ?
        JR	Z,J4FB0			; yep, no more samples
        INC	D
        LD	BC,8-1
        ADD	HL,BC
        JR	J4FA4			; next sample

J4FB0:	LD	A,D
        RET

J4FB2:	XOR	A
        RET

;	  Subroutine check for ","
;	     Inputs  ________________________
;	     Outputs ________________________


C4FB4:	CALL	C6EE4
        DEFB	","
        RET

;	  Subroutine check for "("
;	     Inputs  ________________________
;	     Outputs ________________________


C4FB9:	CALL	C6EE4
        DEFB	"("
        RET

;	  Subroutine check for ")"
;	     Inputs  ________________________
;	     Outputs ________________________

C4FBE:	CALL	C6EE4
        DEFB	")"
        RET

;	  Subroutine switch MSX-AUDIO in page 2
;	     Inputs  ________________________
;	     Outputs ________________________


C4FC3:	LD	B,2
        CALL	C4E23			; get slotid of page 2
        PUSH	AF
        LD	A,(D7B0E)
        LD	H,80H
        CALL	ENASLT			; MSX-AUDIO on page 2
        POP	AF
        LD	L,A
        EX	(SP),HL
        JP	(HL)

;	  Subroutine restore orginal page 2
;	     Inputs  ________________________
;	     Outputs ________________________


C4FD5:	POP	HL
        EX	(SP),HL
        LD	A,L
        LD	H,80H
        JP	ENASLT

I4FDD:	LD	A,H
        AND	80H
        RES	7,H
        RLCA
        OR	02H			; first 32 KB in segment 2, second 32 KB in segment 3
        DI
        LD	(D7FFE),A		; select segment
        LD	A,40H
        ADD	A,H
        LD	H,A			; page 1 and 2 based
        LDIR
        XOR	A
        LD	(D7FFE),A		; select segment 0
        RET
E$4FDD:

;	  Subroutine check for "," <>255 or not specified operand
;	     Inputs  ________________________
;	     Outputs ________________________


C4FF4:	CALL	C4FB4			; check for ","
        CP	","
        LD	DE,D.FFFF		; default
        LD	A,E
        RET	Z

;	  Subroutine check for <>255 operand
;	     Inputs  ________________________
;	     Outputs ________________________


C4FFE:	CALL	C6EFE			; evaluate byte operand
        CP	0FFH
        RET	NZ
        JR	J5016			; illegal function call

;	  Subroutine check for "," <>65535 or not specified operand
;	     Inputs  ________________________
;	     Outputs ________________________


C5006:	CALL	C4FB4			; check for ","
        CP	","
        LD	DE,D.FFFF		; default
        RET	Z
        CALL	C6EF8			; evaluate adres operand
        LD	A,E
        AND	D
        INC	A			; 65535 ?
        RET	NZ			; nope, quit
J5016:	JP	C6EAB			; illegal function call


;	  Subroutine __________________________
;	     Inputs  ________________________
;	     Outputs ________________________


C5019:	LD	A,(HL)
        CP	")"
        RET	NZ
        POP	DE
        JP	J5082

;	  Subroutine CALL SET PCM
;	     Inputs  ________________________
;	     Outputs ________________________


C5021:	PUSH	HL
        LD	HL,BUF+2
        LD	DE,BUF+2+1
        LD	BC,8-1
        LD	(HL),0FFH
        LDIR				; defaults
        POP	HL
        CALL	C4FB9			; check for "("
        CALL	C6EFE			; evaluate byte operand (samplenumber)
        LD	(BUF+0),A
        CALL	C4FB4			; check for ","
        CALL	C6EFE			; evaluate byte operand (memorytype)
        LD	(BUF+1),A
        OR	A
        JR	Z,J5057			; 0, sample ram 1st Y8950
        DEC	A
        JR	Z,J5090			; 1, sample rom 1st Y8950
        DEC	A
        JR	Z,J5057			; 2, sample ram 2nd Y8950
        DEC	A
        JR	Z,J5090			; 3, sample rom 2nd Y8950
        DEC	A
        JR	Z,J50A1			; 4, ram
        DEC	A
        JP	Z,J50D2			; 5, vram
        JR	J5016			; illegal function call

J5057:	CALL	C5019			; finish when end of parameterlist
        CALL	C4FF4			; check for "," <>255 or not specified operand (sample type)
        LD	(BUF+2),A
        CALL	C5019			; finish when end of parameterlist
        CALL	C4FB4			; check for "," (no sample start)
J5066:	CALL	C5006			; check for "," <>65535 or not specified operand (sample length)
        LD	(BUF+5),DE
J506D:	CALL	C5019			; finish when end of parameterlist
        CALL	C5006			; check for "," <>65535 or not specified operand (sample freq)
        LD	(BUF+7),DE
        CALL	C5019			; finish when end of parameterlist
        CALL	C4FF4			; check for "," <>255 or not specified operand (Y8950 number)
        JR	Z,J5016			; not specified, illegal function call
        LD	(BUF+9),A
J5082:	CALL	C4FBE			; check for ")"
        JP	NZ,J6EA8		; not end of statement, syntax error
        PUSH	HL
        CALL	C51BA			; define sample
        POP	HL
        JR	C,J5016			; error, illegal function call
        RET

J5090:	CALL	C4FB4			; check for "," (no sample type for a ROM)
        CALL	C4FB4			; check for ","
        CALL	C6EFE			; evaluate byte operand (sample start)
        LD	(BUF+3),A
        CALL	C5019			; finish when end of parameterlist
        JR	J5066			; rest of parameterlist

J50A1:	LD	A,4
        LD	(BUF+1),A
        CALL	C4FF4			; check for "," <>255 or not specified operand (sample type)
        LD	(BUF+2),A
        CALL	C4FB4			; check for ","
        CALL	C50F4			; read variabelname
        PUSH	HL
        LD	HL,BUF+6
        LD	A,":"
        LD	(HL),A
        DEC	HL
        LD	(HL),A
        DEC	HL
        LD	(HL),B			; second char varname
        DEC	HL
        LD	(HL),C			; first char varname
        INC	HL
        LD	A,B
        CP	":"			; second char varname ?
        JR	Z,J50C6			; nope,
        INC	HL
J50C6:	LD	(HL),E			; vartype indicator
        POP	HL
        LD	A,(HL)
        CP	")"			; end of parameterlist ?
        JR	Z,J5082			; yep, finish
        CALL	C4FB4			; check for ","
        JR	J506D			; rest of parameterlist

J50D2:	LD	A,5
        LD	(BUF+1),A
        CALL	C4FF4			; check for "," <>255 or not specified operand (sampletype)
        LD	(BUF+2),A
        CALL	C4FB4			; check for ","
        CALL	C6EF8			; evaluate adres operand (sample start)
        LD	(BUF+3),DE
        CALL	C4FB4			; check for ","
        CALL	C6EF8			; evaluate adres operand (sample length)
        LD	(BUF+5),DE
        JP	J506D			; rest of parameterlist


;	  Subroutine __________________________
;	     Inputs  ________________________
;	     Outputs ________________________


C50F4:	LD	C,(HL)
        CALL	C512B			; is upcase letter ?
        JP	C,J6EA8			; nope, syntax error
        LD	B,":"
        CALL	C6EEC			; read upcase letter
        JR	C,J5107			; next char a digit,
        CALL	C512B			; is upcase letter ?
        JR	C,J5112			; nope, syntax error
J5107:	LD	B,A
J5108:	CALL	C6EEC			; read char
        JR	C,J5108			; next char a digit, next
        CALL	C512B			; is upcase letter ?
        JR	NC,J5108		; yep, next
J5112:	LD	E,":"
        CP	26H
        RET	NC
        CP	"%"
        JR	Z,J5126
        CP	"$"
        JR	Z,J5126
        CP	"!"
        JR	Z,J5126
        CP	"#"
        RET	NZ
J5126:	LD	E,A
        CALL	C6EEC			; read char
        RET

;	  Subroutine is upcase letter
;	     Inputs  ________________________
;	     Outputs ________________________


C512B:	CP	"A"
        RET	C
        CP	"Z"+1
        CCF
        RET

;	  Subroutine validate samplefrequency
;	     Inputs  ________________________
;	     Outputs ________________________


C5132:	LD	A,D
        AND	E
        INC	A
        JR	NZ,J513B
        LD	DE,8000
        RET

J513B:	PUSH	HL
        LD	HL,16000
        AND	A
        SBC	HL,DE
        JR	C,J514A
        LD	HL,1800-1
        SBC	HL,DE
        CCF
J514A:	POP	HL
        RET

;	  Subroutine CALL REC PCM
;	     Inputs  ________________________
;	     Outputs ________________________


C514C:	CALL	C516B			; evaluate parameterlist
        PUSH	HL
        CALL	C5535			; record sample
        JR	C,J515E			; error, illegal function call
        POP	HL
        RET

;	  Subroutine CALL PLAY PCM
;	     Inputs  ________________________
;	     Outputs ________________________


C5157:	CALL	C516B			; evaluate parameterlist
        PUSH	HL
        CALL	C571C			; play sample
J515E:	JP	C,C6EAB			; error, illegal function call
        POP	HL
        RET


;	  Subroutine __________________________
;	     Inputs  ________________________
;	     Outputs ________________________


C5163:	LD	A,(HL)
        CP	")"
        RET	NZ
        POP	DE
        JP	J51B3


;	  Subroutine __________________________
;	     Inputs  ________________________
;	     Outputs ________________________


C516B:	PUSH	HL
        LD	HL,BUF+1
        LD	B,8
J5171:	LD	(HL),0FFH
        INC	HL
        DJNZ	J5171
        POP	HL
        CALL	C4FB9			; check for "("
        CALL	C6EFE			; evaluate byte operand (sample number)
        LD	(BUF+0),A
        CALL	C5163			; finish when end of parameterlist
        CALL	C4FF4			; check for "," <>255 or not specified operand (repeat/mic)
        LD	(BUF+1),A
        CALL	C5163			; finish when end of parameterlist
        CALL	C5006			; check for "," <>65535 or not specified operand (start offset)
        LD	(BUF+2),DE
        CALL	C5163			; finish when end of parameterlist
        CALL	C5006			; check for "," <>65535 or not specified operand (end offset )
        LD	(BUF+4),DE
        CALL	C5163			; finish when end of parameterlist
        CALL	C5006			; check for "," <>65535 or not specified operand (sample frequency)
        LD	(BUF+6),DE
        CALL	C5163			; finish when end of parameterlist
        CALL	C4FB4			; check for ","
        CALL	C4FFE			; check for <> 255 operand (Y8950 number)
        LD	(BUF+8),A
J51B3:	CALL	C4FBE			; check for ")"
        JP	NZ,J6EA8		; not end of statement, syntax error
        RET

;	  Subroutine define sample
;	     Inputs  ________________________
;	     Outputs ________________________


C51BA:	LD	A,(BUF+0)
        CP	16
        CCF				; samplenumber 0-15 ?
        RET	C			; nope, quit with error
        LD	DE,(BUF+7)		; sample frequency
        LD	A,(BUF+1)
        AND	05H
        DEC	A			; sample rom ?
        CALL	NZ,C5132		; nope, validate samplefrequency
        RET	C			; invalid, quit with error
        LD	(BUF+7),DE		; default replaced by samplefrequency 8000
        LD	DE,(BUF+5)
        LD	A,E
        OR	D			; sample lenghth <>0 ?
        SCF
        RET	Z			; nope, quit with error
        CALL	C521D			; wait for all samplers and sample memories to become ready
        RET	Z			; aborted by CTRL-STOP, quit
        LD	A,33H
        LD	(D7EDF),A		; sampler and sample memory both Y8950 in use
        LD	IY,I3280
        CALL	C5717			; abort sampling 1st Y8950
        LD	IY,I32C0
        CALL	C5717			; abort sampling 2nd Y8950
        CALL	C51FC			; fill sample entry
        PUSH	AF
        XOR	A
        LD	(D7EDF),A		; sampler and sample memory both Y8950 free
        POP	AF
        RET

;	  Subroutine fill sample entry
;	     Inputs  ________________________
;	     Outputs ________________________


C51FC:	LD	A,(BUF+0)
        CALL	C54F4			; get pointer to sample entry
        LD	A,(BUF+1)
        OR	A
        JR	Z,J5239			; 0, sample ram 1st Y8950
        DEC	A
        JP	Z,J52C4			; 1, sample rom 1st Y8950
        DEC	A
        JR	Z,J522D			; 2, sample ram 2nd Y8950
        DEC	A
        JP	Z,J52B5			; 3, sample rom 2nd Y8950
        DEC	A
        JP	Z,J5337			; 4, ram
        DEC	A
        JP	Z,J5349			; 5, vram
        SCF
        RET

;	  Subroutine wait for all samplers and sample memories to become ready
;	     Inputs  ________________________
;	     Outputs ________________________


C521D:	DI
        LD	A,(D7EDF)
        OR	A			; all samplers and sample memory free ?
        JR	Z,J522B			; yep, quit
        EI
        CALL	C6B8D			; CTRL-STOP pressed ?
        JR	NZ,C521D		; nope, loop
        RET

J522B:	INC	A
        RET

;	  Subroutine fill sample entry sample ram 2nd Y8950
;	     Inputs  ________________________
;	     Outputs ________________________


J522D:	LD	A,(BUF+9)
        CP	0FFH			; Y8950 number specified ?
        JR	Z,J5241			; nope, ok
        DEC	A			; yep, then it must be 1
        SCF
        RET	NZ			; nope, quit with error
        JR	J5241

;	  Subroutine fill sample entry sample ram 1st Y8950
;	     Inputs  ________________________
;	     Outputs ________________________


J5239:	LD	A,(BUF+9)
        LD	B,A
        RRCA
        CP	B			; Y8950 number not specified or 0 ?
        SCF
        RET	NZ			; nope, quit with error
J5241:	CALL	C54B9			; validate sample type
        RET	C
        LD	DE,(BUF+5)		; sample length
        CALL	C5428			; reserve sample RAM
        RET	C			; error, quit with error
        LD	(BUF+3),BC		; start block
        EX	DE,HL
        LD	(BUF+5),HL		; length
J5255:	LD	HL,BUF+1
        PUSH	HL
        LD	BC,8
        LDIR				; fill sample entry
        POP	HL
        LD	A,(HL)
        AND	07H
        CP	04H			; destination type = RAM ?
        RET	Z			; yep, quit
        AND	05H
        DEC	A			; destination type = sample rom ?
        RET	Z			; yep, quit
        PUSH	HL
        LD	HL,I7500
        LD	DE,I7500+1
        LD	BC,256-1
        LD	(HL),0
        LDIR				; clear temporary sample buffer
        POP	HL
        LD	A,(HL)
        AND	07H			; destination type
        INC	HL
        INC	HL
        LD	E,(HL)
        INC	HL
        LD	D,(HL)			; destination address
        INC	HL
        LD	C,(HL)
        INC	HL
        LD	B,(HL)			; number of blocks
        DI
        LD	IX,D7EAA
        LD	IY,D7EBA
        LD	(IY+0),A
        LD	A,4
        LD	(IX+0),A		; source type = RAM
        LD	HL,I7500
        LD	(D7EAA+2),HL		; source start = temporary sample buffer
J529B:	LD	(D7EBA+2),DE		; destination start = destination address
        LD	HL,1
        LD	(D7EAA+4),HL		; number of blocks = 1
        PUSH	BC
        PUSH	DE
        LD	A,0			; transfer sample data
        CALL	C4D6A			; AUDIO BIOS function
        POP	DE
        POP	BC
        INC	DE
        DEC	BC
        LD	A,C
        OR	B
        JR	NZ,J529B		; next block
        RET

;	  Subroutine fill sample entry sample rom 2nd Y8950
;	     Inputs  ________________________
;	     Outputs ________________________


J52B5:	LD	A,(BUF+9)
        CP	0FFH			; Y8950 number specified ?
        JR	Z,J52BF			; nope, ok
        DEC	A			; yep, then it must be 1
        SCF
        RET	NZ			; nope, quit with error
J52BF:	LD	A,(D7E87)		; number of samples in sample ROM
        JR	J52CF

;	  Subroutine fill sample entry sample rom 1st Y8950
;	     Inputs  ________________________
;	     Outputs ________________________


J52C4:	LD	A,(BUF+9)
        LD	B,A
        RRCA
        CP	B			; Y8950 number 0 or not specified ?
        SCF
        RET	NZ			; nope, quit with error
        LD	A,(D7E86)		; number of samples in sample ROM
J52CF:	LD	B,A
        LD	A,(BUF+3)
        CP	B			; rom samplenumber valid ?
        CCF
        RET	C			; nope, quit with error
        CALL	C54FF			; pointer to rom sample entry
        PUSH	HL
        LD	A,(BUF+1)		; source type
        CALL	C550A			; get sample rom directory
        POP	HL
        LD	A,(BUF+2)
        INC	A			; sample type specified ?
        SCF
        RET	NZ			; yep, quit with error
        LD	A,(BUF+1)
        OR	(HL)
        LD	(BUF+1),A		; bits from the rom sample
        XOR	A
        LD	(BUF+2),A
        INC	HL
        INC	HL
        LD	E,(HL)
        INC	HL
        LD	D,(HL)
        LD	(BUF+3),DE		; start rom sample
        INC	HL
        LD	E,(HL)
        INC	HL
        LD	D,(HL)			; length of rom sample
        PUSH	HL
        LD	HL,(BUF+5)
        LD	A,L
        AND	H
        INC	A			; length specified ?
        JR	NZ,J530F		; yep, validate
        POP	HL
        LD	(BUF+5),DE		; nope, use the length of rom sample
        JR	J5314

J530F:	EX	DE,HL
        SBC	HL,DE			; length valid ?
        POP	HL
        RET	C			; nope, quit with error
J5314:	LD	DE,(BUF+7)
        LD	A,E
        AND	D
        INC	A			; sample frequency specified ?
        JR	NZ,J5321		; use that one
        INC	HL
        LD	E,(HL)
        INC	HL
        LD	D,(HL)			; use that default for that sample
J5321:	CALL	C5132			; validate samplefrequency
        RET	C			; invalid samplefrequency, quit with error
        LD	(BUF+7),DE
        LD	A,(BUF+0)
        CALL	C54F4			; get pointer to sample entry
        PUSH	HL
        CALL	C5374			; free sample RAM if sample RAM entry
        POP	DE
        JP	J5255			; transfer sample

;	  Subroutine fill sample entry ram
;	     Inputs  ________________________
;	     Outputs ________________________


J5337:	CALL	C54B9			; validate sample type
        RET	C			; invalid, quit with error
        PUSH	HL
        LD	HL,BUF+3
        CALL	C5E52			; get array variable address and size
        POP	HL
        LD	A,D
        OR	A			; size <255 ?
        SCF
        RET	Z			; yep, quit with error
        JR	J536A

;	  Subroutine fill sample entry vram
;	     Inputs  ________________________
;	     Outputs ________________________


J5349:	CALL	C54B9			; validate sample type
        RET	C			; invalid, quit with error
        PUSH	HL
        LD	HL,(D7EEE)
        PUSH	HL
        LD	BC,(BUF+3)		; destination vram begin block
        OR	A
        SBC	HL,BC			; valid vram block ?
        POP	DE
        JR	C,J5372			; nope, quit with error
        INC	DE
        LD	HL,(BUF+5)
        ADD	HL,BC			; destination vram end block
        JR	C,J5372
        EX	DE,HL
        OR	A
        SBC	HL,DE			; valid vram block ?
        JR	C,J5372			; nope, quit with error
        POP	HL
J536A:	CALL	C5374			; free sample RAM if sample RAM entry
        LD	E,L
        LD	D,H
        JP	J5255

J5372:	POP	HL
        RET

;	  Subroutine free sample RAM if sample RAM entry
;	     Inputs  ________________________
;	     Outputs ________________________


C5374:	LD	A,(HL)
        AND	07H
        LD	(BUF+31),A
        AND	05H			; sample entry in use as sample RAM ?
        RET	NZ			; nope, quit
        PUSH	HL
        INC	HL
        INC	HL
        LD	E,(HL)
        INC	HL
        LD	D,(HL)			; start block
        INC	HL
        LD	C,(HL)
        LD	(HL),0
        INC	HL
        LD	B,(HL)
        LD	(HL),0			; length = 0
        LD	A,B
        OR	C			; length was 0 ?
        JR	Z,J53E6			; yep, already free, quit
        LD	A,16			; 16 entries
        PUSH	DE
        POP	IY			; save start block
J5394:	PUSH	AF
        DEC	A
        CALL	C54F4			; get pointer to sample entry
        LD	A,(HL)
        AND	07H
        LD	E,A
        LD	A,(BUF+31)
        CP	E			; of the same sample RAM ?
        JR	NZ,J53C2		; nope, next entry
        INC	HL
        INC	HL
        LD	E,(HL)
        INC	HL
        LD	D,(HL)			; start block
        INC	HL
        LD	A,(HL)
        INC	HL
        OR	(HL)			; free ?
        JR	Z,J53C2			; yep, next entry
        DEC	HL
        DEC	HL
        DEC	HL
        PUSH	HL
        PUSH	IY
        POP	HL			; start block entry in question
        SBC	HL,DE
        POP	HL
        JR	NC,J53C2		; this entry is before that, next entry
        EX	DE,HL
        OR	A
        SBC	HL,BC
        EX	DE,HL
        LD	(HL),E
        INC	HL
        LD	(HL),D
J53C2:	POP	AF
        DEC	A
        JR	NZ,J5394		; next entry
        PUSH	IY
        POP	HL
        PUSH	BC
        CALL	C53E8
        POP	BC
        LD	A,(BUF+31)
        OR	A
        JR	NZ,J53DE
        LD	HL,(D7E82)		; last sample ram block used 1st Y8950
        SBC	HL,BC
        LD	(D7E82),HL
        JR	J53E6

J53DE:	LD	HL,(D7E84)
        SBC	HL,BC
        LD	(D7E84),HL
J53E6:	POP	HL
        RET


;	  Subroutine __________________________
;	     Inputs  ________________________
;	     Outputs ________________________


C53E8:	LD	E,L
        LD	D,H
        ADD	HL,BC
        PUSH	DE
        PUSH	HL
        EX	DE,HL
        LD	A,(BUF+31)
        OR	A
        LD	HL,(D7E82)		; last sample ram block used 1st Y8950
        JR	Z,J53FA
        LD	HL,(D7E84)
J53FA:	INC	HL
        SBC	HL,DE
        LD	C,L
        LD	B,H
        POP	HL
        POP	DE
        LD	A,C
        OR	B
        RET	Z
        DI
        LD	IX,D7EAA
        LD	IY,D7EBA
        LD	A,(BUF+31)
        LD	(IX+0),A
        LD	(IY+0),A
        LD	(D7EAA+2),HL
        LD	(D7EAA+4),BC
        LD	(D7EBA+2),DE
        LD	A,0			; transfer data
        CALL	C4D6A			; AUDIO BIOS function
        EI
        RET

;	  Subroutine reserve sample RAM
;	     Inputs  ________________________
;	     Outputs ________________________


C5428:	PUSH	DE
        CALL	C5374			; free sample RAM if sample RAM entry
        POP	DE
        PUSH	HL
        LD	A,E
        AND	D
        INC	A			; sample length specified ?
        JR	Z,J547D			; nope,
        LD	A,(BUF+1)
        AND	07H			; sample ram 1st Y8950 ?
        LD	BC,(D7E82)
        JR	Z,J5442			; yep, last sample ram block used 1st Y8950
        LD	BC,(D7E84)
J5442:	LD	L,E
        LD	H,D			; sample length
        LD	A,C
        AND	B
        INC	A			; 0FFFFH (whole sample ram free) ?
        JR	NZ,J544C		; nope,
        ADD	HL,BC			; end block = length-1
        JR	J544F

J544C:	ADD	HL,BC
        JR	C,J547B			; sample too big,quit with error
J544F:	LD	C,L
        LD	B,H
        LD	A,(BUF+1)
        AND	07H			; sample ram 1st Y8950 ?
        JR	NZ,J5469		; nope, 2nd Y8950
        LD	HL,(D7EE4)		; sample RAM size 1st Y8950 (256 bytes unit)
        SBC	HL,BC
        JR	C,J547B			; sample too big ,quit with error
        LD	HL,(D7E82)		; last sample ram block used 1st Y8950
        INC	HL
        LD	(D7E82),BC
        JR	J5478

J5469:	LD	HL,(D7EE8)		; sample RAM size 2nd Y8950 (256 bytes unit)
        SBC	HL,BC
        JR	C,J547B
        LD	HL,(D7E84)
        INC	HL
        LD	(D7E84),BC
J5478:	LD	C,L
        LD	B,H			; start block
J547A:	OR	A
J547B:	POP	HL
        RET

J547D:	LD	A,(BUF+1)
        AND	07H
        JR	NZ,J549E
        LD	BC,(D7E82)
        LD	HL,(D7EE4)		; sample RAM size 1st Y8950 (256 bytes unit)
        LD	A,L
        OR	H
        SCF
        JR	Z,J547B
        CCF
        LD	E,L
        LD	D,H
        SBC	HL,BC
        SCF
        JR	Z,J547B
        EX	DE,HL
        LD	(D7E82),HL
        JR	J54B6

J549E:	LD	BC,(D7E84)
        LD	HL,(D7EE8)		; sample RAM size 2nd Y8950 (256 bytes unit)
        LD	A,L
        OR	H
        SCF
        JR	Z,J547B
        CCF
        LD	E,L
        LD	D,H
        SBC	HL,BC
        SCF
        JR	Z,J547B
        EX	DE,HL
        LD	(D7E84),HL
J54B6:	INC	BC
        JR	J547A

;	  Subroutine validate sample type
;	     Inputs  ________________________
;	     Outputs ________________________


C54B9:	LD	A,(BUF+2)
        INC	A
        ADD	A,0FDH			; sample type not specified or 0-1 ?
        RET	C			; nope, quit with error
        CPL
        DEC	A
        AND	80H
        LD	B,A			; b7 set if PCM sample
        LD	A,(BUF+1)
        LD	C,A
        AND	05H			; sample RAM ?
        LD	A,(BUF+9)
        JR	NZ,J54DC		; nope, check Y8950 number
        INC	A			; specified ?
        JR	NZ,J54DD		; yep, check Y8950 number
        LD	A,C
        AND	02H			; sample type specifies Y8950 number
        RRCA
        RRCA
        RRCA
        LD	C,A			; in b6
        JR	J54E5

J54DC:	INC	A
J54DD:	ADD	A,0FDH			; not specified or 0-1 ?
        RET	C			; nope, quit with error
        CPL
        DEC	A
        AND	40H
        LD	C,A			; b6 set if Y8950 number = 1
J54E5:	LD	A,(BUF+1)
        AND	07H
        OR	B
        OR	C
        LD	(BUF+1),A
        XOR	A
        LD	(BUF+2),A
        RET

;	  Subroutine get pointer to sample entry
;	     Inputs  ________________________
;	     Outputs ________________________


C54F4:	ADD	A,A
        ADD	A,A
        ADD	A,A
        LD	E,A
        LD	D,0
        LD	HL,I7F13
        ADD	HL,DE
        RET

;	  Subroutine get pointer to rom sample entry
;	     Inputs  ________________________
;	     Outputs ________________________


C54FF:	LD	L,A
        LD	H,00H
        ADD	HL,HL
        ADD	HL,HL
        ADD	HL,HL
        LD	DE,I7500+16
        ADD	HL,DE
        RET

;	  Subroutine get sample rom directory
;	     Inputs  ________________________
;	     Outputs ________________________


C550A:	DI
        LD	IX,D7EAA
        LD	IY,D7EBA
        LD	(IX+0),A		; source type
        LD	(IY+0),4		; destination type = RAM
        XOR	A
        LD	(IX+2),A
        LD	(IX+3),A		; source start = 0
        LD	(IX+4),1
        LD	(IX+5),A		; number of blocks = 1
        LD	HL,I7500
        LD	(D7EBA+2),HL		; destination start = temporary sample buffer
        LD	A,0			; transfer sample
        CALL	C4D6A			; AUDIO BIOS function
        EI
        RET

;	  Subroutine record sample
;	     Inputs  ________________________
;	     Outputs ________________________


C5535:	LD	A,(BUF+0)
        CP	16			; samplenumber 0-15 ?
        CCF
        RET	C			; nope, quit with error
        LD	A,11H
        LD	(BUF+9),A
        LD	HL,(BUF+2)
        LD	A,L
        AND	H
        INC	A
        JR	NZ,J554D
        INC	HL
        LD	(BUF+2),HL
J554D:	LD	A,(BUF+1)
        LD	B,A
        RRCA
        SUB	B			; 0 or not specified ?
        CPL
        JR	Z,J555A			; yep, mic
        DEC	B			; 1 ?
        SCF
        RET	NZ			; nope, quit with error
        XOR	A			; mic
J555A:	LD	(D7488),A
        LD	A,(BUF+0)
        CALL	C54F4			; get pointer to sample entry
        LD	A,(BUF+8)
        CP	0FFH
        JR	NZ,J5572
        LD	A,(HL)
        AND	40H
        RLCA
        RLCA
        LD	(BUF+8),A
J5572:	AND	0FEH
        SCF
        RET	NZ
        LD	A,(HL)
        AND	07H
        JR	Z,J5592			; sample ram 1st Y8950
        DEC	A
        JP	Z,J561C			; sample rom 1st Y8950, quit with error
        DEC	A
        JR	Z,J5590			; sample ram 2nd Y8950
        DEC	A
        JP	Z,J561C			; sample rom 2nd Y8950, quit with error
        DEC	A
        JP	Z,J561E			; ram
        DEC	A
        JP	Z,J5621			; vram
        SCF
        RET

J5590:	LD	A,2			; sample source memory = sample RAM 2nd Y8950
J5592:	CALL	C5674			; define sample source
        CALL	C57DB			; if sample frequency specified, validate it and put in sample source
        RET	C
        LD	A,(HL)
        LD	B,A
        AND	07H
        LD	A,(BUF+8)
        JR	NZ,J55A6
        OR	A
        SCF
        RET	NZ
        INC	A
J55A6:	DEC	A
        SCF
        RET	NZ
        BIT	7,B
        LD	C,12			; record ADPCM sample from sample memory
        JR	Z,J55B1
        LD	C,6			; record PCM sample

;	  Subroutine play/record sample from/to sample memory
;	     Inputs  ________________________
;	     Outputs ________________________


J55B1:	CALL	C56C0			; sample frequency 0 ?
        SCF
        RET	Z			; yep, quit with error
        CALL	C56C7			; validate start offset and length and put in sample source
        RET	C			; error, quit with error
        SCF
        RET	Z			; length = 0, quit with error
        DI

;	  Subroutine play/record sample
;	     Inputs  ________________________
;	     Outputs ________________________


J55BD:	LD	IY,I3280
        LD	A,(BUF+8)
        OR	A
        JR	Z,J55CB
        LD	IY,I32C0
J55CB:	CALL	C5640			; wait for free sampler and reserve sampler
        CCF
        RET	NC			; CTRL-STOP pressed, quit
        PUSH	BC
        CALL	C5717			; abort sampling
        POP	BC
        PUSH	BC
        LD	A,C
        LD	C,0
        CALL	C4D6A			; AUDIO BIOS function
        POP	BC
        JR	NC,J55E8		; no error,
        CP	3			; aborted by CTRL-STOP ?
        JR	NZ,J55E6
        LD	(INTFLG),A		; yep, flag this. Basic then picks up CTRL-STOP als well
J55E6:	LD	C,9			; fake "record ADPCM sample", so sample memory operation gets terminated
J55E8:	PUSH	IY
        POP	HL
        LD	DE,I3280
        OR	A
        SBC	HL,DE
        LD	D,0F0H
        JR	Z,J55F7
        LD	D,00FH
J55F7:	LD	A,C
        CP	12			; record ADPCM sample from sample memory ?
        JR	Z,J5608			; yep, sampler and sample memory frees itself when ready
        CP	11			; play ADPCM sample from sample memory ?
        JR	Z,J5608			; yep, sampler and sample memory frees itself when ready
        DI
        LD	A,(D7EDF)
        AND	D
        LD	(D7EDF),A		; sampler and sample memory free
J5608:	EI
        LD	A,(D7B29)
        OR	A			; background music ?
        RET	Z			; yep, quit
        LD	A,D
        CPL
        LD	D,A
J5611:	CALL	C6B8D			; CTRL-STOP pressed ?
        RET	Z			; yep, quit
        LD	A,(D7EDF)
        AND	D			; sampler and sample memory free ?
        JR	NZ,J5611		; nope, wait
        RET

J561C:	SCF
        RET

J561E:	LD	A,4			; sample source memory = RAM
        DEFB	1
J5621:	LD	A,5			; sample source memory = VRAM
        CALL	C5674			; define sample source
        CALL	C57DB			; if sample frequency specified, validate it and put in sample source
        RET	C
        BIT	7,(HL)
        LD	C,9			; record ADPCM sample
        JR	Z,J5632
        LD	C,6			; record PCM sample

;	  Subroutine play/record sample from/to RAM/VRAM
;	     Inputs  ________________________
;	     Outputs ________________________


J5632:	CALL	C56C0			; sample frequency 0 ?
        SCF
        RET	Z			; yep, quit with error
        CALL	C56C7			; validate start offset and length and put in sample source
        RET	C			; invalid, quit with error
        SCF
        RET	Z			; length =0, quit with error
        JP	J55BD

;	  Subroutine wait for free sampler and reserve sampler
;	     Inputs  ________________________
;	     Outputs ________________________


C5640:	PUSH	HL
        PUSH	IY
        POP	HL
        LD	DE,I3280
        OR	A
        SBC	HL,DE
        POP	HL
        LD	DE,00F02H
        JR	Z,J5653
        LD	DE,0F020H
J5653:	DI
        LD	A,(D7EDF)
        AND	D			; sampler and sample memory free ?
        JR	Z,J5662			; yep, reserve sampler
        EI
        CALL	C6B8D			; CTRL-STOP pressed ?
        SCF
        RET	Z
        JR	J5653

J5662:	LD	A,(BUF+9)
        AND	D
        OR	E
        LD	E,A
        LD	A,(D7EDF)
        OR	E
        LD	(D7EDF),A		; reserve sampler
        XOR	A
        LD	(D7EE0),A		; no audio keyboard sample playing
        RET

;	  Subroutine define sample source
;	     Inputs  ________________________
;	     Outputs ________________________


C5674:	CP	4			; sample memory = RAM ?
        JR	Z,J5689			; yep, determine array start and size
        LD	DE,D7EAA
        PUSH	DE
        LD	(DE),A
        INC	DE
        LD	BC,7
        PUSH	HL
        INC	HL
        LDIR				; fill in sample source
        POP	HL
        POP	IX
        RET

J5689:	LD	(D7EAA+0),A
        PUSH	HL
        INC	HL
        INC	HL
        LD	DE,BUF+32
        LD	A,":"
        LD	(DE),A
        INC	DE
        LD	BC,4
        PUSH	DE
        LDIR
        POP	HL
        CALL	C5E52			; get array variable address and size
        POP	HL
        LD	IX,D7EAA
        LD	(D7EAA+2),BC		; array start
        LD	(IX+4),D
        LD	(IX+5),0		; size in 256 bytes units
        PUSH	HL
        LD	BC,6
        ADD	HL,BC
        LD	A,(HL)
        LD	(IX+6),A
        INC	HL
        LD	A,(HL)
        LD	(IX+7),A		; sample frequency
        POP	HL
        RET

;	  Subroutine sample frequency 0 ?
;	     Inputs  ________________________
;	     Outputs ________________________


C56C0:	LD	A,(IX+6)
        OR	(IX+7)
        RET

;	  Subroutine validate start offset and length and put in sample source
;	     Inputs  ________________________
;	     Outputs ________________________


C56C7:	LD	DE,(D7EAA+4)		; sample length
        LD	HL,(BUF+2)
        OR	A
        SBC	HL,DE			; start offset valid ?
        CCF
        RET	C			; nope, quit with error
        LD	HL,(BUF+4)
        LD	A,H
        OR	L			; length 0 ?
        RET	Z			; yep, quit (Cx reset, Zx set)
        LD	A,H
        AND	L
        INC	A			; length specified ?
        JR	NZ,J56E9		; yep,
        LD	HL,(BUF+2)
        PUSH	DE
        EX	DE,HL
        SBC	HL,DE			; sample length - start offset
        LD	(BUF+4),HL		; = length
        POP	DE
J56E9:	PUSH	DE
        LD	DE,(BUF+2)
        ADD	HL,DE			; length + start offset
        POP	DE
        RET	C			; too big, quit with error
        EX	DE,HL
        SBC	HL,DE			; end offset > sample length ?
        RET	C			; yep, quit with error
        LD	HL,(D7EAA+2)		; source start
        LD	DE,(BUF+2)
        LD	A,(D7EAA+0)
        CP	4			; source is RAM ?
        JR	NZ,J570A		; nope, work in blocks
        LD	A,D
        OR	A			; number of blocks > 255 ?
        SCF
        RET	NZ			; yep, quit with error
        LD	D,E
        LD	E,0			; in bytes
J570A:	ADD	HL,DE
        LD	(D7EAA+2),HL		; source start
        LD	HL,(BUF+4)
        LD	(D7EAA+4),HL		; source length
        XOR	A
        INC	A			; Cx reset, Zx reset
        RET

;	  Subroutine abort sampling
;	     Inputs  ________________________
;	     Outputs ________________________


C5717:	LD	A,10
        JP	C4D6A			; AUDIO BIOS function

;	  Subroutine play sample
;	     Inputs  ________________________
;	     Outputs ________________________


C571C:	LD	A,(BUF+0)
        CP	16			; samplenumber 0-15 ?
        CCF
        RET	C			; nope, quit with error
        XOR	A
        LD	(BUF+9),A
        LD	HL,(BUF+2)
        LD	A,L
        AND	H
        INC	A			; start specified ?
        JR	NZ,J5733		; yep, use that
        INC	HL
        LD	(BUF+2),HL		; use 0
J5733:	LD	A,(BUF+1)
        LD	B,A
        RRCA
        SUB	B			; 0 or not specified ?
        JR	Z,J5740			; yep, no repeat
        DEC	B			; then it must be 1
        SCF
        RET	NZ			; nope, quit with error
        LD	A,0FFH			; flag repeat
J5740:	LD	(D7489),A
        LD	A,(BUF+0)
        CALL	C54F4			; get pointer to sample entry
        LD	A,(BUF+8)
        CP	0FFH			; ? specified ?
        JR	NZ,J5758		; yep,
        LD	A,(HL)
        AND	40H
        RLCA
        RLCA
        LD	(BUF+8),A		; use b6 of sampledefinition
J5758:	AND	0FEH			; 0 or 1 ?
        SCF
        RET	NZ			; nope, quit with error
        LD	A,(HL)
        AND	07H
        JR	Z,J5774
        DEC	A
        JR	Z,J57BE
        DEC	A
        JR	Z,J5772
        DEC	A
        JR	Z,J57C0
        DEC	A
        JR	Z,J57C4
        DEC	A
        JR	Z,J57C7
        SCF
        RET

;	  Subroutine play sample from sample RAM 2nd Y8950
;	     Inputs  ________________________
;	     Outputs ________________________


J5772:	LD	A,2			; sample source memory = sample RAM 2nd Y8950

;	  Subroutine play sample from sample memory
;	     Inputs  ________________________
;	     Outputs ________________________


J5774:	CALL	C5674			; define sample source
        LD	A,(HL)
        AND	80H			; ADPCM sample ?
        JR	Z,J5782			; yep, check sample frequency in extended range
        CALL	C57DB			; if sample frequency specified, validate it and put in sample source
        RET	C			; invalid, quit with error
        JR	J57A3

J5782:	LD	DE,(BUF+6)
        LD	A,E
        AND	D
        INC	A			; ADPCM sample frequency specified ?
        JR	Z,J57A3			; nope, use the default
        PUSH	HL
        LD	HL,49716
        AND	A
        SBC	HL,DE
        POP	HL			; ADPCM sample frequency >49716 ?
        RET	C			; yep, quit with error
        PUSH	HL
        LD	HL,1800-1
        SBC	HL,DE
        CCF
        POP	HL			; ADPCM sample frequency <1800 ?
        RET	C			; yep, quit with error
        LD	(IX+6),E
        LD	(IX+7),D		; sample frequency
J57A3:	LD	A,(HL)
        LD	B,A
        AND	02H			; sample memory of which Y8950
        LD	A,(BUF+8)
        JR	NZ,J57B0		; 2nd Y8950, check if playdevice is also 2nd Y8950
        OR	A			; 1st Y8950, playdevice also 1st Y8950 ?
        SCF
        RET	NZ			; nope, quit with error
        INC	A			; continue in next code
J57B0:	DEC	A
        SCF
        RET	NZ			; nope, quit with error
        BIT	7,B			; ADPCM sample ?
        LD	C,11
        JR	Z,J57BB			; yep, play ADPCM sample from sample memory
        LD	C,5			; play PCM sample
J57BB:	JP	J55B1

;	  Subroutine play sample from sample ROM 1st Y8950
;	     Inputs  ________________________
;	     Outputs ________________________


J57BE:	LD	A,-2

;	  Subroutine play sample from sample ROM
;	     Inputs  ________________________
;	     Outputs ________________________


J57C0:	ADD	A,3
        JR	J5774			; play sample from sample memory

;	  Subroutine play sample from RAM
;	     Inputs  ________________________
;	     Outputs ________________________


J57C4:	LD	A,4
        DEFB	1

;	  Subroutine play sample from VRAM
;	     Inputs  ________________________
;	     Outputs ________________________


J57C7:	LD	A,5
        CALL	C5674			; define sample source
        CALL	C357DB			; if sample frequency specified, validate it and put in sample source
        RET	C
        BIT	7,(HL)			; ADPCM sample ?
        LD	C,8
        JR	Z,J57D8			; yep, play ADPCM sample
        LD	C,5			; nope, play PCM sample
J57D8:	JP	J5632

;	  Subroutine if sample frequency specified, validate it and put in sample source
;	     Inputs  ________________________
;	     Outputs ________________________


C57DB:	LD	DE,(BUF+6)
        LD	A,E
        AND	D
        INC	A
        RET	Z
        CALL	C5132			; validate samplefrequency
        RET	C
        LD	(IX+6),E
        LD	(IX+7),D
        RET

;	  Subroutine CALL SAVE PCM
;	     Inputs  ________________________
;	     Outputs ________________________


C57EE:	LD	D,0
        DEFB	1

;	  Subroutine CALL LOAD PCM
;	     Inputs  ________________________
;	     Outputs ________________________


C57F1:	LD	D,1
        CALL	C4FB9			; check for "("
        PUSH	HL
        PUSH	DE
        CALL	C6EF2			; evaluate expression
        PUSH	HL
        CALL	C6F04			; free temporary string
        POP	HL
        CALL	C4FB4			; check for ","
        CALL	C6EFE			; evaluate byte operand
        CALL	C4FBE			; check for ")"
        JP	NZ,J6EA8		; not end of statement, syntax error
        POP	AF
        EX	(SP),HL
        OR	A			; LOAD or SAVE ?
        LD	A,E
        JR	Z,J5817			; SAVE
        CALL	C5823
        JR	J581A			; quit

J5817:	CALL	C581C			; write sample to file
J581A:	POP	HL
        RET

;	  Subroutine write sample to file
;	     Inputs  ________________________
;	     Outputs ________________________


C581C:	CALL	C5849
J581F:	JP	C,C6EAB			; illegal function call
        RET

;	  Subroutine read sample from file
;	     Inputs  ________________________
;	     Outputs ________________________


C5823:	CALL	C5A11
        JR	J581F


;	  Subroutine __________________________
;	     Inputs  ________________________
;	     Outputs ________________________


C5828:	CP	16			; samplenumber 0-15 ?
        CCF
        RET	C			; nope, quit with error
        PUSH	AF
        XOR	A
        LD	(D7B2F),A		; file is closed
        CALL	C6ED2			; evaluate filespec
        LD	A,D
        CP	9			; diskdrive ?
        JP	NC,J6EA5		; nope, bad file name
        LD	(BUF+15),A		; driveid
        POP	AF
        CALL	C54F4			; get pointer to sample entry
        LD	(BUF+21),HL
        LD	B,(HL)
        CALL	C5938
        RET


;	  Subroutine __________________________
;	     Inputs  ________________________
;	     Outputs ________________________


C5849:	CALL	C5828
        RET	C			; invalid samplenumber, quit with error
        RET	Z			; aborted by CTRL-STOP, quit
        LD	A,0FEH
        LD	(BUF+0),A		; bload/bsave fileid
        PUSH	BC
        PUSH	HL
        LD	HL,0
        LD	(BUF+1),HL
        CALL	C5717			; abort sampling
        POP	HL
        POP	BC
        LD	A,B
        BIT	7,A
        LD	DE,0
        JR	Z,J586A
        LD	E,1
J586A:	LD	(BUF+5),DE
        AND	07H
        CP	04H			; RAM ?
        JP	Z,J595F			; yep,
        LD	(D7EAA+0),A
        INC	HL
        INC	HL
        LD	E,(HL)
        INC	HL
        LD	D,(HL)
        LD	(D7EAA+2),DE
        INC	HL
        LD	E,(HL)
        INC	HL
        LD	D,(HL)
        INC	HL
        LD	A,D
        OR	E
        SCF
        RET	Z
        LD	(BUF+7),DE
        LD	A,D
        LD	D,E
        LD	E,8
        OR	A
        JR	Z,J5898
        LD	DE,0
J5898:	DEC	DE
        LD	(BUF+3),DE
        LD	E,(HL)
        INC	HL
        LD	D,(HL)
        LD	(BUF+9),DE
        LD	HL,0
        LD	(BUF+11),HL
        LD	(BUF+13),HL
        LD	A,(BUF+5)
        OR	A
        JR	Z,J58BF
        LD	HL,I.8000
        LD	(BUF+11),HL
        LD	HL,127
        LD	(BUF+13),HL
J58BF:	LD	HL,BUF
        LD	DE,(NULBUF)
        PUSH	DE
        LD	BC,15
        LDIR
        POP	BC			; start of buffer
        LD	HL,256			; filesize = 256 bytes
        LD	E,1			; create file
        LD	A,(BUF+15)
        LD	D,A			; driveid
        CALL	C59CE			; intercept errors to close file
        CALL	C5B21			; open/create file
        LD	A,0FFH
        LD	(D7B2F),A		; file is open
        LD	HL,15
        CALL	C5B95			; write bytes disk filebuffer
        LD	BC,(BUF+7)
        LD	A,4
        LD	(D7EBA+0),A
        LD	HL,(NULBUF)
        LD	(D7EBA+2),HL
J58F6:	PUSH	BC
        CALL	C591D
        CALL	C5B92			; write disk filebuffer
        POP	BC
        DEC	BC
        LD	A,B
        OR	C
        JR	NZ,J58F6
J5903:	CALL	C5BB6			; close file


;	  Subroutine __________________________
;	     Inputs  ________________________
;	     Outputs ________________________


C5906:	LD	HL,(BUF+21)
        LD	A,(HL)
        AND	40H
        LD	A,0F0H
        JR	Z,J5912
        LD	A,0FH
J5912:	DI
        LD	HL,D7EDF
        AND	(HL)			; sampler and sample memory free
        LD	(HL),A
        CALL	C5A07			; restore orginal H.ERRO
        EI
        RET


;	  Subroutine __________________________
;	     Inputs  ________________________
;	     Outputs ________________________


C591D:	LD	IX,D7EAA
        LD	HL,1
        LD	(D7EAA+4),HL
        LD	IY,D7EBA
        LD	A,0
        CALL	C4D6A			; AUDIO BIOS function
        LD	HL,(D7EAA+2)
        INC	HL
        LD	(D7EAA+2),HL
        RET


;	  Subroutine __________________________
;	     Inputs  ________________________
;	     Outputs ________________________


C5938:	BIT	6,B
        LD	DE,00F03H
        LD	IY,I3280
        JR	Z,J594A
        LD	DE,0F030H
        LD	IY,I32C0
J594A:	EI
        CALL	C6B8D			; CTRL-STOP pressed ?
        RET	Z			; yep, quit
        DI
        LD	A,(D7EDF)
        AND	D			; sampler or sample memory in use ?
        JR	NZ,J594A		; yep, wait
        LD	A,(D7EDF)
        OR	E
        LD	(D7EDF),A		; reserve sampler and sample memory
        EI
        RET

J595F:	CALL	C5AFD
        RET	C
        LD	E,7
        LD	(BUF+3),DE
        LD	E,D
        LD	D,0
        LD	(BUF+7),DE
        INC	HL
        INC	HL
        INC	HL
        INC	HL
        LD	E,(HL)
        INC	HL
        LD	D,(HL)
        LD	(BUF+9),DE
        LD	HL,0
        LD	(BUF+11),HL
        LD	(BUF+13),HL
        LD	A,(BUF+5)
        OR	A
        JR	Z,J5996
        LD	HL,I.8000
        LD	(BUF+11),HL
        LD	HL,127
        LD	(BUF+13),HL
J5996:	LD	HL,BUF
        LD	DE,(NULBUF)
        PUSH	DE
        LD	BC,15
        LDIR
        POP	BC			; start of buffer
        LD	HL,256			; buffersize = 256 bytes
        LD	E,1			; create file
        LD	A,(BUF+15)
        LD	D,A			; driveid
        CALL	C59CE			; intercept errors
        CALL	C5B21			; open/create file
        LD	A,0FFH
        LD	(D7B2F),A		; file is open
        LD	HL,15
        CALL	C5B95			; write bytes disk filebuffer
        LD	DE,(BUF+16)
        LD	HL,(BUF+18)
        CALL	C5B6C			; set address and size of disk filebuffer
        CALL	C5B92			; write disk filebuffer
        JP	J5903

;	  Subroutine intercept errors
;	     Inputs  ________________________
;	     Outputs ________________________


C59CE:	PUSH	AF
        PUSH	BC
        PUSH	DE
        PUSH	HL
        DI
        LD	HL,H.ERRO
        PUSH	HL
        LD	DE,I7B2A
        CALL	C40DC			; save H.ERRO
        LD	HL,I59ED
        POP	DE
        CALL	C40DC			; install new H.ERRO
        LD	A,(D7B0E)		; slotid MSX-AUDIO
        LD	(H.ERRO+1),A
        JP	J4E6A			; quit

I59ED:	RST	30H
        DEFB	0
        DEFW	C59F2
        RET

C59F2:	PUSH	AF
        PUSH	BC
        PUSH	DE
        PUSH	HL
        CALL	C5906
        LD	A,(D7B2F)
        OR	A			; file open ?
        CALL	NZ,C5BB6		; yep, close file
        POP	HL
        POP	DE
        POP	BC
        POP	AF
        JP	H.ERRO			; to orginal H.ERRO hook


;	  Subroutine __________________________
;	     Inputs  ________________________
;	     Outputs ________________________


C5A07:	DI
        LD	HL,I7B2A
        LD	DE,H.ERRO
        JP	C40DC


;	  Subroutine __________________________
;	     Inputs  ________________________
;	     Outputs ________________________


C5A11:	CALL	C5828
        RET	C			; invalid samplenumber, quit with error
        RET	Z			; aborted by CTRL-STOP, quit
        PUSH	BC
        PUSH	HL
        CALL	C5717			; abort sampling
        LD	BC,BUF			; start of buffer
        LD	HL,15			; size of buffer = 15 bytes
        PUSH	HL
        LD	E,0			; open file
        LD	A,(BUF+15)
        LD	D,A			; driveid
        CALL	C59CE			; intercept error
        CALL	C5B21			; open/create file
        LD	A,0FFH
        LD	(D7B2F),A		; file is open
        CALL	C5BA3			; read disk file buffer
        POP	DE
        OR	A
        SBC	HL,DE			; 15 bytes read ?
        POP	HL
        POP	BC
        SCF
        RET	NZ			; nope, quit with error
        LD	A,(BUF+0)
        CP	0FEH			; bsave/bload fileid ?
        SCF
        RET	NZ			; nope, quit with error
        LD	A,B
        AND	07H
        CP	04H			; RAM ?
        JP	Z,J5AEA			; yep,
        LD	(D7EBA+0),A
        AND	05H
        DEC	A			; sample rom ?
        SCF
        RET	Z			; yep, quit with error
        INC	HL
        INC	HL
        LD	E,(HL)
        INC	HL
        LD	D,(HL)
        LD	(D7EBA+2),DE
        INC	HL
        LD	E,(HL)
        INC	HL
        LD	D,(HL)
        INC	HL
        LD	A,D
        OR	E
        SCF
        RET	Z
        LD	HL,(BUF+7)
        OR	A
        EX	DE,HL
        PUSH	HL
        SBC	HL,DE
        POP	HL
        JR	C,J5A73
        EX	DE,HL
J5A73:	PUSH	HL
        CALL	C5B69			; set address and size of temporary disk filebuffer
        POP	BC
        XOR	A
        LD	(BUF+25),A
        LD	HL,(BUF+23)
        LD	(D7EAA+2),HL
        LD	A,4
        LD	(D7EAA+0),A
J5A87:	LD	A,B
        OR	C
        JR	Z,J5A95
        PUSH	BC
        CALL	C5BA3			; read disk file buffer
        POP	BC
        CALL	C5AB7
        JR	J5A87

J5A95:	CALL	C5BB6			; close file
        LD	HL,(BUF+21)
        LD	A,(BUF+5)
        AND	01H
        RRCA
        LD	B,A
        LD	A,(HL)
        AND	7FH
        OR	B
        LD	(HL),A
        LD	DE,(BUF+9)
        PUSH	HL
        LD	BC,6
        ADD	HL,BC
        LD	(HL),E
        INC	HL
        LD	(HL),D
        POP	HL
        JP	C5906


;	  Subroutine __________________________
;	     Inputs  ________________________
;	     Outputs ________________________


C5AB7:	LD	A,(BUF+26)
        LD	L,A
        LD	H,00H
        OR	A
        PUSH	HL
        SBC	HL,BC
        POP	HL
        JR	C,J5AC6
        LD	L,C
        LD	H,B
J5AC6:	LD	IX,D7EAA
        LD	(D7EAA+4),HL
        LD	IY,D7EBA
        LD	A,0
        PUSH	BC
        PUSH	HL
        CALL	C4D6A			; AUDIO BIOS function
        POP	HL
        PUSH	HL
        LD	BC,(D7EBA+2)
        ADD	HL,BC
        LD	(D7EBA+2),HL
        POP	BC
        POP	HL
        OR	A
        SBC	HL,BC
        LD	C,L
        LD	B,H
        RET

J5AEA:	CALL	C5AFD
        RET	C
        LD	DE,(BUF+16)
        LD	HL,(BUF+18)
        CALL	C5B6C			; set address and size of disk filebuffer
        CALL	C5BA3			; read disk file buffer
        JR	J5A95


;	  Subroutine __________________________
;	     Inputs  ________________________
;	     Outputs ________________________


C5AFD:	INC	HL
        INC	HL
        PUSH	HL
        LD	DE,BUF+16
        LD	A,":"
        LD	(DE),A
        INC	DE
        LD	BC,4
        PUSH	DE
        LDIR
        POP	HL
        CALL	C5E52			; get array variable address and size
        POP	HL
        LD	(BUF+16),BC
        LD	E,00H
        LD	(BUF+18),DE
        LD	A,D
        OR	A
        RET	NZ
        SCF
        RET

;	  Subroutine open/create file
;	     Inputs  E = read/write, D=driveid, BC = start of buffer, HL = size of buffer (0 = use temporary buffer)
;	     Outputs ________________________


C5B21:	LD	A,(H.PHYD+0)
        CP	0C9H			; MSX disksystem ?
        JP	Z,C6EAB			; nope, illegal function call
        PUSH	BC			; start of buffer
        PUSH	HL			; size of buffer
        LD	HL,BUF+27		; FCB in BUF
        PUSH	HL
        LD	(HL),D			; driveid FCB
        LD	A,E
        AND	A
        PUSH	AF
        EX	DE,HL
        INC	DE
        LD	HL,FILNAM
        LD	BC,11
        LDIR				; filename FCB
        XOR	A
        LD	B,25
J5B40:	LD	(DE),A
        INC	DE
        DJNZ	J5B40			; clear rest of the FCB
        POP	AF
        POP	DE
        PUSH	AF
        LD	C,0FH			; OPEN (FCB)
        JR	Z,J5B4D
        LD	C,16H			; CREATE (FCB)
J5B4D:	CALL	C.F37D
        INC	A			; error ?
        JR	NZ,J5B5C		; nope,
        POP	AF
        JP	Z,J6EA2			; read file, file not found
        LD	E,43H
        JP	J6EB6			; write file, too many files

J5B5C:	LD	HL,1
        LD	(BUF+27+14),HL		; record size FCB
        POP	AF
        POP	HL
        POP	DE
        LD	A,H
        OR	L
        JR	NZ,C5B6C		; set address and size of disk filebuffer

;	  Subroutine set address and size of temporary disk filebuffer
;	     Inputs  ________________________
;	     Outputs ________________________


C5B69:	CALL	C5B78			; get address and size of temporary disk filebuffer

;	  Subroutine set address and size of disk filebuffer
;	     Inputs  ________________________
;	     Outputs ________________________


C5B6C:	LD	(BUF+23),DE		; start of buffer
        LD	(BUF+25),HL		; size of buffer
        LD	C,1AH			; SETDMA
        JP	C.F37D

;	  Subroutine get address and size of disk filebuffer
;	     Inputs  ________________________
;	     Outputs ________________________


C5B78:	LD	HL,-768
        ADD	HL,SP
        JR	NC,J5B8A
        LD	DE,(STREND)
        AND	A
        SBC	HL,DE
        JR	C,J5B8A
        LD	A,H
        AND	A
        RET	NZ
J5B8A:	LD	DE,(NULBUF)
        LD	HL,256
        RET

;	  Subroutine write disk filebuffer
;	     Inputs  ________________________
;	     Outputs ________________________


C5B92:	LD	HL,(BUF+25)		; size of buffer

;	  Subroutine write bytes disk filebuffer
;	     Inputs  ________________________
;	     Outputs ________________________


C5B95:	LD	DE,BUF+27
        LD	C,26H			; random block write
        CALL	C.F37D
        AND	A			; error ?
        RET	Z			; nope, quit
        LD	E,42H
        JR	J5BB3			; disk full

;	  Subroutine read disk filebuffer
;	     Inputs  ________________________
;	     Outputs ________________________


C5BA3:	LD	HL,(BUF+25)		; size of buffer
        LD	DE,BUF+27
        LD	C,27H			; random block read
        CALL	C.F37D
        LD	A,L
        OR	H			; something read ?
        RET	NZ			; yep, quit
        LD	E,37H
J5BB3:	JP	J6EB6			; input past end

;	  Subroutine close file
;	     Inputs  ________________________
;	     Outputs ________________________


C5BB6:	XOR	A
        LD	(D7B2F),A		; file is closed
        LD	DE,BUF+27
        LD	C,10H			; CLOSE (FCB)
        JP	C.F37D

;	  Table      EXTBIO

I5BC2:	DEFB	0,0,0
        JP	J5CC9		; start routine in AUDIO-BIOS
        JP	C43AA		; �CALL AUDIO�
        JP	C42F3		; �CALL SYNTHE�
        JP	C5F50		; playvoice active ?
        JP	J4403		; set BGM
        JP	C4514		; set audio keyboard accompaniment tempo
        JP	J5CBD		; replay audio keyboard recording
        JP	J5CC3		; (append) recording audio keyboard
        JP	C488C		; stop all sound
        JP	J48B5		; continue recording audio keyboard
        JP	C4576		; set audio keyboard recording mode
        JP	C6CDC		; stop background music
        JP	C51BA		; define sample
        JP	C5535		; record sample
        JP	C571C		; play sample
        JP	C458D		; set sample frequency
        JP	C4551		; set sample for audio keyboard
        JP	C44B4		; set sample volume
        JP	C581C		; save sample
        JP	C5823		; load sample
        JP	C463F		; copy sample
        JP	C4705		; convert adpcm to pcm
        JP	C46E8		; convert pcm to adpcm
        JP	C5D86		; set voice
        JP	C5E5C		; copy voice
        RET
        RET
        RET

;	  Subroutine initialize EXTBIO
;	     Inputs  ________________________
;	     Outputs ________________________


J5C13:	DI
        LD	HL,HOKVLD
        BIT	0,(HL)
        JR	NZ,J5C2A
        SET	0,(HL)
        LD	HL,EXTBIO+0
        LD	DE,EXTBIO+1
        LD	BC,29-1
        LD	(HL),0C9H
        LDIR
J5C2A:	LD	DE,J7E7C
        LD	HL,EXTBIO
        LD	BC,5
        LDIR				; save current EXTBIO
        LD	HL,I5C46
        LD	DE,EXTBIO
        CALL	C40DC			; MSX-AUDIO EXTBIO
        LD	A,(D7B0E)		; slotid MSX-AUDIO
        LD	(EXTBIO+1),A
        EI
        RET

I5C46:	RST	30H
        DEFB	0
        DEFW	C5C4B
        RET

C5C4B:	EI
        PUSH	AF
        LD	A,D
        INC	A			; system exclusive EXTBIO ?
        JR	Z,J5C68			; yep, handle
        DEC	A			; broadcast EXTBIO ?
        JR	NZ,J5C7B		; nope, check if MSX-AUDIO EXTBIO
        LD	A,E
        OR	A			; build devicename table function ?
        JR	Z,J5C5C			; yep, handle
J5C58:	POP	AF
        JP	J7E7C			; control to next EXTBIO handler

J5C5C:	LD	A,10
        CALL	C5CB3			; write devicenumber (10 = MSX-AUDIO)
        LD	A,0
        CALL	C5CB3			; write reserved
        JR	J5C58			; control to next EXTBIO handler

J5C68:	LD	A,E
        OR	A
        JR	NZ,J5C79
        CALL	C5CA2			; write slotid and jumptable adres
        LD	A,0
        CALL	C5CB3			; write makerid (0 = ASCII)
        LD	A,0
        CALL	C5CB3			; write reserved
J5C79:	JR	J5C58			; control to next EXTBIO handler

J5C7B:	CP	10			; MSX-AUDIO EXTBIO ?
        JR	NZ,J5C58		; nope, control to next EXTBIO handler
        LD	A,E
        OR	A			; function 0
        JR	Z,J5C89
        CP	1			; function 1
        JR	Z,J5C93
        JR	J5C58			; control to next EXTBIO handler

J5C89:	CALL	C5CA2			; write slotid and jumptable adres
        LD	A,0
        CALL	C5CB3			; write reserved
        JR	J5C58			; control to next EXTBIO handler

J5C93:	POP	AF
        INC	A			; increase number of Y8950
        PUSH	HL
        LD	HL,D7391
        BIT	0,(HL)			; 2nd Y8950 found ?
        POP	HL
        JR	NZ,J5C9F		; nope,
        INC	A			; increase number of Y8950
J5C9F:	PUSH	AF
        JR	J5C58			; control to next EXTBIO handler


;	  Subroutine __________________________
;	     Inputs  ________________________
;	     Outputs ________________________


C5CA2:	LD	A,(D7B0E)		; slotid MSX-AUDIO
        CALL	C5CB3
        LD	A,LOW I5BC2
        CALL	C5CB3
        LD	A,HIGH I5BC2
        CALL	C5CB3
        RET


;	  Subroutine __________________________
;	     Inputs  ________________________
;	     Outputs ________________________


C5CB3:	PUSH	BC
        LD	E,A
        LD	A,B
        CALL	WRSLT
        EI
        INC	HL
        POP	BC
        RET

J5CBD:	CALL	C5CCF
        JP	J49B9

J5CC3:	CALL	C5CCF
        JP	C49D0			; start audio keyboard recording

J5CC9:	CALL	C5CCF
        JP	C4D6D			; start routine in MSX-AUDIO BIOS


;	  Subroutine __________________________
;	     Inputs  ________________________
;	     Outputs ________________________


C5CCF:	LD	IX,(BUF+0)
        LD	IY,(BUF+2)
        RET

;	  Subroutine enable Y8950 on this MSX-AUDIO
;	     Inputs  ________________________
;	     Outputs ________________________


C5CD8:	DI
        LD	HL,I7FFF
        XOR	A
        LD	E,A
        LD	(HL),A			; first disable all Y8950�s on this MSX-AUDIO
        LD	C,0C0H
        CALL	C5CFE			; test if Y8950 at I/O 0C0H
        JR	C,J5CE8			; found, do not enable Y8950 at 0C0H of this MSX-AUDIO
        SET	0,E			; not found, enable Y8950 at 0C0H of this MSX-AUDIO
J5CE8:	LD	C,0C2H
        CALL	C5CFE			; test if Y8950 at I/O 0C2H
        JR	C,J5CF1			; found, do not enable Y8950 at 0C2H of this MSX-AUDIO
        SET	1,E			; not found, enable Y8950 at 0C2H of this MSX-AUDIO
J5CF1:	LD	A,E
        LD	(HL),A			; enable
        CP	3			; both Y8950 on this MSX-AUDIO enabled ?
        RET	NZ			; nope, quit
        CALL	C5D06			; check if Y8950 on 0C0H is the same as on 0C2H
        RET	NC			; it is not, quit
        LD	E,1
        LD	(HL),E			; enable only Y8950 at 0C0H of this MSX-AUDIO
        RET

;	  Subroutine test for Y8950
;	     Inputs  C = I/O address Y8950
;	     Outputs Cx set if Y8950 found

C5CFE:	CALL	C5D1B			; program TIMER-1
        CALL	C5D32			; check for valid TIMER-1 interrupt
        JR	J5D12			; disable TIMER-1

;	  Subroutine check if Y8950 on 0C0H is the same as on 0C2H
;	     Inputs  ________________________
;	     Outputs ________________________


C5D06:	LD	C,0C0H
        CALL	C5D1B			; program TIMER-1 first Y8950
        LD	C,0C2H
        CALL	C5D32			; check for valid TIMER-1 interrupt
        LD	C,0C0H
J5D12:	LD	A,78H

;	  Subroutine write OPL register
;	     Inputs  ________________________
;	     Outputs ________________________


C5D14:	OUT	(C),D
        INC	C
        OUT	(C),A
        DEC	C
        RET

;	  Subroutine program TIMER-1
;	     Inputs  ________________________
;	     Outputs ________________________


C5D1B:	LD	D,02H
        LD	A,0FCH
        CALL	C5D14			; OPL TIMER-1 register
        LD	D,04H
        LD	A,78H			; mask timer 1, mask timer 2, ....
        CALL	C5D14			; OPL FLAG CONTROL register
        LD	A,39H			; timer 1 enabled
        CALL	C5D14			; OPL FLAG CONTROL register
        LD	A,80H			; irq reset
        JR	C5D14			; OPL FLAG CONTROL register

;	  Subroutine check for valid TIMER-1 interrupt
;	     Inputs  ________________________
;	     Outputs ________________________


C5D32:	IN	A,(C)
        AND	40H			; TIMER-1 interrupt ?
        RET	NZ			; yep, quit
        LD	B,A
J5D38:	IN	A,(C)
        AND	40H
        SCF
        RET	NZ
        DJNZ	J5D38
        OR	A
        RET

;	  Subroutine CALL VOICE
;	     Inputs  ________________________
;	     Outputs ________________________


C5D42:	CALL	C6EE4
        DEFB	"("			; check for "("
        LD	DE,BUF
        LD	B,9
J5D4B:	LD	A,(HL)
        CP	","
        JR	Z,J5D6F
        PUSH	BC
        LD	A,9
        SUB	B
        LD	(DE),A			; channelnumber
        INC	DE
        PUSH	DE
        LD	A,(HL)
        CALL	C5E28			; evaluate instrument operand
        LD	A,0
        JR	C,J5D60			; instrument number,
        CPL				; variable
J5D60:	EX	(SP),HL
        LD	(HL),A
        INC	HL
        LD	(HL),E
        INC	HL
        LD	(HL),D
        INC	HL			; instrument or address variable
        EX	(SP),HL
        POP	DE
        POP	BC
        LD	A,(HL)
        CP	")"
        JR	Z,J5D75
J5D6F:	CALL	C6EE4
        DEFB	","
        DJNZ	J5D4B
J5D75:	CALL	C6EE4
        DEFB	")"
        JP	NZ,J6EA8		; not end of statement, syntax error
        LD	A,0FFH
        LD	(DE),A			; end marker
        CALL	C5D86
        JP	C,C6EAB			; illegal function call
        RET


;	  Subroutine __________________________
;	     Inputs  ________________________
;	     Outputs ________________________


C5D86:	PUSH	HL
        LD	HL,BUF
J5D8A:	LD	A,(HL)
        CP	0FFH
        JR	Z,J5DC4
        INC	HL
        CALL	C5DD0			; get pointer to channel
        LD	A,(HL)
        INC	HL
        OR	A
        JR	Z,J5DA8
        LD	C,(HL)
        INC	HL
        LD	B,(HL)
        PUSH	HL
        CALL	C4D83			; MSX-AUDIO in page 0
        LD	A,29H
        CALL	C5DC7			; do AUDIO function and next
        LD	A,29H
        JR	J5DBA

J5DA8:	LD	C,(HL)
        LD	A,C
        CP	64
        CCF
        RET	C
        INC	HL
        PUSH	HL
        CALL	C4D83			; MSX-AUDIO in page 0
        LD	A,27H
        CALL	C5DC7			; do AUDIO function and next
        LD	A,27H
J5DBA:	CALL	C5DC7			; do AUDIO function and next
        CALL	C4D8F			; restore page 0
        POP	HL
        INC	HL
        JR	J5D8A			; next channel

J5DC4:	POP	HL
        OR	A
        RET

;	  Subroutine do AUDIO function
;	     Inputs  ________________________
;	     Outputs ________________________


C5DC7:	PUSH	BC
        RST	00H
        LD	BC,32
        ADD	IX,BC
        POP	BC
        RET

;	  Subroutine get pointer to channel
;	     Inputs  ________________________
;	     Outputs ________________________


C5DD0:	LD	IX,I3000
        OR	A
        RET	Z
        PUSH	BC
        LD	BC,64
J5DDA:	ADD	IX,BC
        DEC	A
        JR	NZ,J5DDA
        POP	BC
        RET

;	  Subroutine CALL VOICE COPY
;	     Inputs  ________________________
;	     Outputs ________________________


C5DE1:	CALL	C6EE4
        DEFB	"("
        CALL	C5E28			; evaluate instrument operand
        CCF
        SBC	A,A
        LD	(BUF+0),A		; instrumentnumber or variable
        LD	(BUF+1),DE		; instrumentnumber or address of variable
        LD	(BUF+3),BC		; variablesize
        CALL	C6EE4
        DEFB	","			; check for ","
        CALL	C5E28			; evaluate instrument operand
        CCF
        SBC	A,A
        LD	(BUF+5),A		; instrumentnumber or variable
        LD	(BUF+6),DE		; instrumentnumber or address of variable
        LD	(BUF+8),BC		; variablesize
        JR	NZ,J5E10		; destination a variable, skip
        LD	A,E
        CP	32			; destination a readonly instrument ?
        JR	C,J5E41			; yep, illegal function call
J5E10:	CALL	C6EE4
        DEFB	")"			; check for ")"
        JP	NZ,J6EA8		; not end of statement, syntax error
        PUSH	HL
        LD	HL,BUF+0
        LD	A,(BUF+5)
        AND	(HL)			; source and destination both variables ?
        JR	NZ,J5E41		; yep, illegal function call
        CALL	C5E5C			; copy instrument definition
        JR	C,J5E41			; error, illegal function call
        POP	HL
        RET

;	  Subroutine evaluate instrument operand
;	     Inputs  ________________________
;	     Outputs ________________________


C5E28:	CP	"@"
        JR	Z,J5E38
        CP	0F3H			; * token ?
        JR	NZ,J5E44
        CALL	C6EEC			; read * token
        LD	DE,255			; indicates all changable instruments
        SCF
        RET

J5E38:	CALL	C6EEC			; read "@" char
        CALL	C6EFE			; evaluate byte operand
        CP	64
        RET	C
J5E41:	JP	C6EAB			; illegal function call

J5E44:	CALL	C5E52			; get array variable address and size
        LD	A,E
        AND	0E0H
        OR	D
        JR	Z,J5E41
        PUSH	DE
        LD	E,C
        LD	D,B
        POP	BC
        RET

;	  Subroutine get array variable address and size
;	     Inputs  ________________________
;	     Outputs BC = start of array, DE = size

C5E52:	CALL	C4935			; search array variable
        EX	DE,HL
        OR	A
        SBC	HL,BC
        INC	HL
        EX	DE,HL
        RET

;	  Subroutine copy instrument definition
;	     Inputs  ________________________
;	     Outputs ________________________


C5E5C:	LD	A,(BUF+5)
        LD	HL,(BUF+6)
        OR	A			; destination a variable ?
        JR	NZ,J5E6C		; yep, already a address
        LD	A,L
        INC	A			; instrument 255 ?
        JR	Z,J5EA6			; yep, destination is all instrument definitions 32-63
        CALL	C5EBB			; get pointer to instrument definition
J5E6C:	PUSH	HL
        LD	A,(BUF+0)
        LD	HL,(BUF+1)
        OR	A			; source a variable ?
        JR	NZ,J5E7D		; yep, already a address
        LD	A,L
        INC	A			; instrument 255 ?
        JR	Z,J5E8D			; yep, source is all instrument definitions 32-63
        CALL	C5EBB			; get pointer to instrument definition
J5E7D:	POP	DE
        LD	BC,32
J5E81:	DI
        CALL	C4D83			; MSX-AUDIO in page 0
        LDIR				; copy instrument definition
        CALL	C4D8F			; restore page 0
        OR	A
        EI
        RET

J5E8D:	POP	HL			; clean stack
        LD	A,(BUF+5)
        OR	A			; destination a instrument ?
        SCF
        RET	Z			; yep, quit with error
        LD	A,(BUF+9)
        CP	HIGH (32*32)		; variablesize big enough ?
        RET	C			; nope, quit with error
        LD	HL,(D7382)		; pointer to programable instrument definitions (32-63)
        LD	DE,(BUF+6)		; destination
J5EA1:	LD	BC,32*32
        JR	J5E81			; copy instrument definitions

J5EA6:	LD	A,(BUF+0)
        OR	A			; source a instrument ?
        SCF
        RET	Z			; yep, quit with error
        LD	A,(BUF+4)
        CP	HIGH (32*32)		; variablesize big enough ?
        RET	C			; nope, quit with error
        LD	HL,(BUF+1)
        LD	DE,(D7382)		; pointer to programable instrument definitions (32-63)
        JR	J5EA1			; copy instrument definitions

;	  Subroutine get pointer to instrument definition
;	     Inputs  L = instrumentnumber
;	     Outputs HL = pointer

C5EBB:	LD	A,L
        CP	32
        LD	HL,(D7380)		; pointer to predefined instrument definitions (00-31)
        JR	C,J5ECC
        LD	HL,(D7382)		; pointer to programable instrument definitions (32-63)
        LD	DE,4000H
        ADD	HL,DE			; page 1 based
        SUB	32
J5ECC:	EX	DE,HL
        ADD	A,A
        ADD	A,A
        ADD	A,A
        LD	H,00H
        LD	L,A
        ADD	HL,HL
        ADD	HL,HL
        ADD	HL,DE
        RET

;	  Subroutine CALL MK VOICE
;	     Inputs  ________________________
;	     Outputs ________________________


C5ED7:	CALL	C6EE4
        DEFB	"("
        CALL	C5E28
        CCF
        SBC	A,A
        PUSH	DE
        PUSH	AF
        PUSH	DE
        PUSH	AF
        LD	A,(HL)
        CP	")"
        JR	Z,J5EF6
        POP	AF
        POP	DE
        CALL	C6EE4
        DEFB	","
        CALL	C5E28
        CCF
        SBC	A,A
        PUSH	DE
        PUSH	AF
J5EF6:	CALL	C6EE4
        DEFB	")"
        JP	NZ,J6EA8		; not end of statement, syntax error
        POP	AF
        POP	DE
        POP	BC
        EX	(SP),HL
        CALL	C5F09
        JP	C,C6EAB			; illegal function call
        POP	HL
        RET


;	  Subroutine __________________________
;	     Inputs  ________________________
;	     Outputs ________________________


C5F09:	PUSH	AF
        PUSH	DE
        PUSH	BC
        PUSH	HL
        POP	BC
        POP	AF
        LD	IY,I3280
        CALL	C5F1E
        JR	C,J5F32
        POP	BC
        POP	AF
        LD	IY,I32C0


;	  Subroutine __________________________
;	     Inputs  ________________________
;	     Outputs ________________________


C5F1E:	DI
        OR	A
        LD	A,56
        JR	NZ,J5F2F
        LD	A,B
        OR	A
        SCF
        RET	NZ
        LD	A,C
        CP	40H
        CCF
        RET	C
        LD	A,54
J5F2F:	JP	C4D6A			; AUDIO BIOS function
J5F32:	POP	BC
        POP	AF
        SCF
        RET

;	  Subroutine CALL PLAY
;	     Inputs  ________________________
;	     Outputs ________________________


C5F36:	CALL	C42BE			; check for "(" and evaluate byte operand
        LD	A,(D7B22)		; number of playvoices
        CP	E			; playvoice valid ?
        JP	C,C6EAB			; nope, illegal function call
        LD	A,E
        PUSH	HL
        CALL	C5F50
        EX	(SP),HL
        CALL	C4FB4			; check for ","
        CALL	C6ED8			; search variable
        EX	(SP),HL
        JP	J4A41			; put in variable, check for ")" and quit


;	  Subroutine __________________________
;	     Inputs  ________________________
;	     Outputs ________________________


C5F50:	LD	HL,(D7B26)
        OR	A			; all playvoices ?
        JR	NZ,J5F61		; nope, only selected playvoice
        LD	A,H
        AND	1FH
        OR	L			; any of the 13 playvoices active ?
        JR	Z,J5F5E			; nope return 0
        LD	A,0FFH			; return -1
J5F5E:	LD	L,A
        LD	H,A
        RET

J5F61:	SRL	H
        RR	L
        DEC	A
        JR	NZ,J5F61		; shift correct bit in Cx
        SBC	A,A			; 0FFH when active, 000H when inactive
        JR	J5F5E			; return

I5F6B:	LD	A,(D7B0E)		; slotid MSX-AUDIO
        PUSH	AF
        PUSH	BC
        PUSH	DE
        PUSH	HL
        LD	A,(EXPTBL+0)
        LD	H,40H
        CALL	ENASLT
        POP	HL
        POP	DE
        POP	BC
        CALL	M2F8A
        POP	AF
        PUSH	AF
        PUSH	BC
        PUSH	DE
        PUSH	HL
        LD	H,40H
        CALL	ENASLT
        JP	J4E6A

I5F8D:	DEFB	" "

;	  Subroutine PLAY statement handler
;	     Inputs  ________________________
;	     Outputs ________________________


C5F8E:	CALL	C411C			; check for enough stackspace
        CALL	C5FC5
        PUSH	HL
        LD	A,(D7B0E)		; slotid MSX-AUDIO
        DI
        ADD	A,A
        LD	HL,8
        JR	NC,J5FA1
        LD	L,8+8
J5FA1:	ADD	HL,SP
        PUSH	HL
        LD	E,(HL)
        INC	HL
        LD	D,(HL)
        LD	HL,M73E5+3
        OR	A
        SBC	HL,DE			; H.PLAY called by PLAY statement ?
        JP	NZ,J6E9F		; nope, internal error
        POP	HL
        DEC	HL
        LD	D,H
        LD	E,L
        INC	DE
        INC	DE
        LD	A,(D7B0E)		; slotid MSX-AUDIO
        ADD	A,A
        LD	BC,8
        JR	NC,J5FC0
        LD	C,8+8
J5FC0:	LDDR
        POP	HL
        POP	HL
        RET

;	  Subroutine execute PLAY statement
;	     Inputs  ________________________
;	     Outputs ________________________


C5FC5:	CP	"#"			; playdevice specified ?
        JP	NZ,J5FE5		; no, use PSG
        CALL	C6EEC			; read "#" char
        CALL	C6EFE			; evaluate byte operand
        PUSH	AF
        CALL	C4FB4			; check for ","
        POP	AF
        OR	A
        JR	Z,J5FE5			; 0, use PSG
        DEC	A
        JR	Z,J5FE2			; 1, use MIDI
        SUB	3
        JR	C,J6018			; 2-3, use AUDIO/PSG
        JP	C6EAB			; illegal function call

J5FE2:	INC	A			; MIDI
        JR	J6019

J5FE5:	XOR	A			; no MIDI
        LD	(D7B0F),A
        PUSH	HL
        LD	A,(D7B23)
        OR	A			; no AUDIO playvoices ?
        JR	Z,J600E			; skip initialization of AUDIO playvoices
        LD	B,A			; number of AUDIO playvoices
J5FF1:	PUSH	BC
        LD	A,B
        DEC	A
        CALL	C6F0F			; get pointer to stringlength in voicebuffer
        LD	DE,I5F8D
        LD	(HL),1			; stringlength = 1
        INC	HL
        LD	(HL),E
        INC	HL
        LD	(HL),D
        INC	HL			; string = " "
        LD	D,H
        LD	E,L
        LD	BC,33-5
        ADD	HL,BC
        EX	DE,HL
        LD	(HL),E
        INC	HL
        LD	(HL),D			; initialize voice stack
        POP	BC
        DJNZ	J5FF1
J600E:	POP	HL
        XOR	A
        LD	(PRSCNT),A		; no strings completed
        LD	A,(D7B23)		; number of AUDIO playvoices = first PSG playvoice
        JR	J6020

J6018:	XOR	A			; no MIDI
J6019:	LD	(D7B0F),A
        XOR	A
        LD	(PRSCNT),A		; no strings completed
                                        ; start with playvoice 0
J6020:	PUSH	HL
        LD	HL,-10
        ADD	HL,SP
        LD	(SAVSP),HL
        POP	HL
        PUSH	AF			; current playvoice
J602A:	PUSH	HL
        LD	HL,I5F6B
        LD	DE,BUF+128
        LD	BC,0022H
        LDIR
        POP	HL			; 2F8A routine in BUF+128
        CALL	C6EF2			; evaluate expression
        EX	(SP),HL
        PUSH	HL
        CALL	C6F04			; free temporary string
        CALL	C6F5D			; get string parameters
        LD	A,E
        OR	A			; empty string ?
        JR	NZ,J604D		; nope, use string
        LD	E,1			; length = 1
        LD	BC,I5F8D
        LD	D,C
        LD	C,B			; use special " " string
J604D:	POP	AF			; current playvoice
        PUSH	AF
        CALL	C66CC			; get pointer to interrupt corrector byte of playvoice
        XOR	A
        LD	(IX+0),A		; reset
        POP	AF			; current playvoice
        PUSH	AF
        CALL	C6F0F			; get pointer to stringlength in voicebuffer
        LD	(HL),E			; store string length
        INC	HL
        LD	(HL),D
        INC	HL
        LD	(HL),C			; store string address
        INC	HL
        LD	D,H
        LD	E,L
        LD	BC,33-5
        ADD	HL,BC
        EX	DE,HL
        LD	(HL),E
        INC	HL
        LD	(HL),D			; initialize voice stack
        POP	BC			; current playvoice
        POP	HL			; BASIC pointer
        INC	B
        LD	A,(D7B22)
        DEC	A
        CP	B			; last playvoice ?
        JR	C,J6090			; yep, check for end of statement
        DEC	HL
        CALL	C6EEC			; end of statement ?
        JR	Z,J6081			; yep,
        PUSH	BC			; save current playvoice
        CALL	C4FB4			; check for ","
        JR	J602A			; next voice

J6081:	LD	A,B
        LD	(VOICEN),A		; current playvoice
        CALL	C6191			; increase strings completed and put endbyte in queue
        INC	B
        LD	A,(D7B22)
        DEC	A
        CP	B			; last playvoice ?
        JR	NC,J6081		; nope, next
J6090:	DEC	HL
        CALL	C6EEC			; end of statement ?
        JP	NZ,J6EA8		; nope, syntax error
        PUSH	HL

J6098:	XOR	A			; start with playvoice 0

J6099:	PUSH	AF
        LD	(VOICEN),A		; current playvoice
        LD	C,A
        LD	A,(D7B22)		; number of playvoices
        SUB	C
        SUB	4			; PSG playvoice ?
        LD	HL,I61C8
        JR	C,J60B8			; yep, use PSG MCL
        LD	HL,I6454
        JR	NZ,J60B8		; FM playvoice, use FM MCL
        LD	A,(D7B1F)
        AND	01H			; drum mode ?
        JR	Z,J60B8			; nope, use FM MCL
        LD	HL,I676F		; drum playvoice, use drum MCL
J60B8:	LD	(MCLTAB),HL
        LD	A,C
        LD	B,A
        CALL	C61BB			; less then 8 bytes free in voice queue ?
        JP	C,J6153			; yep, skip to the next voice
        LD	A,B
        CALL	C6F0F			; get pointer to stringlength in voicebuffer
        LD	A,(HL)
        OR	A			; stringlength zero ?
        JP	Z,J6153			; yep, skip to the next voice
        LD	(MCLLEN),A
        INC	HL
        LD	E,(HL)
        INC	HL
        LD	D,(HL)
        INC	HL
        LD	(MCLPTR),DE		; setup for MCL parsing
        LD	E,(HL)
        INC	HL
        LD	D,(HL)			; source end = voice stackpointer
        INC	HL
        PUSH	HL
        LD	L,36
        CALL	C6F13			; get pointer in voicebuffer of current playvoice
        PUSH	HL
        LD	HL,(SAVSP)
        DEC	HL			; destination start
        POP	BC			; source start = offset 36
        DI
        CALL	C6F50			; copy data from voicebuffer to Z80 stack
        POP	DE
        LD	H,B
        LD	L,C
        LD	SP,HL			; stack on destination end
        EI
        LD	A,(VOICEN)
        OR	A			; current playvoice 0 ?
        JR	NZ,J6108		; nope, skip device selection
        LD	A,(D7B0F)		; PLAY MIDI
        LD	HL,D7B10
        CP	(HL)			; same as previous PLAY ?
        JR	Z,J6108			; yep, skip device selection
        LD	(HL),A
        LD	A,88H
        OR	(HL)
        LD	E,A			; device selection (088H,089H)
        CALL	C61AB			; put byte in queue (DI)
J6108:	JP	J6D1A			; start MCL parser


J610B:	LD	A,(MCLLEN)
        OR	A
        JR	NZ,J6114
J6111:	CALL	C6191			; increase strings completed and put endbyte in queue
J6114:	LD	A,(VOICEN)		; current playvoice
        CALL	C6F0F			; get pointer to stringlength in voicebuffer
        LD	A,(MCLLEN)
        LD	(HL),A
        INC	HL
        LD	DE,(MCLPTR)
        LD	(HL),E
        INC	HL
        LD	(HL),D
        LD	HL,0
        ADD	HL,SP
        EX	DE,HL
        LD	HL,(SAVSP)
        DI
        LD	SP,HL
        POP	BC
        POP	BC
        POP	BC
        PUSH	HL
        OR	A
        SBC	HL,DE
        JR	Z,J6151
        LD	A,0F0H
        AND	L
        OR	H
        JP	NZ,C6EAB		; illegal function call
        LD	L,36
        CALL	C6F13			; get pointer in voicebuffer of current playvoice
        POP	BC
        DEC	BC
        CALL	C6F50			; copy data from Z80 stack to voicebuffer
        POP	HL
        DEC	HL
        LD	(HL),B
        DEC	HL
        LD	(HL),C
        JR	J6153

J6151:	POP	BC
        POP	BC
J6153:	EI
        POP	AF			; current playvoice
        INC	A			; next playvoice
        LD	HL,D7B22
        CP	(HL)			; done all playvoices ?
        JP	C,J6099			; nope, next
        DI
        CALL	C6B8D			; CTRL-STOP pressed ?
        JR	Z,J618B			; yep, stop backgroud music and quit
        LD	A,(PRSCNT)
        RLCA				; music dequeueing already started ?
        JR	C,J6174			; yep, do not start again
        LD	HL,D7B28
        INC	(HL)			; something queued
        LD	A,(HL)
        LD	(PLYCNT),A		; something queued for PSG
        CALL	C6F66			; start dequeueing
J6174:	EI
        LD	HL,PRSCNT
        SET	7,(HL)			; flag music dequeueing started
        LD	A,(HL)
        LD	HL,D7B24
        CP	(HL)			; last playvoice ?
        JP	NZ,J6098		; nope, start again
        LD	A,(D7B29)
        OR	A			; background playing ?
        CALL	NZ,C6B79		; nope, wait until queues are empty and playvoices are stopped
        JR	NC,J618F		; not aborted by CTRL-STOP, quit
J618B:	CALL	C6CDC			; stop background music
        EI
J618F:	POP	HL
        RET

;	  Subroutine increase strings completed and put endbyte in queue
;	     Inputs  ________________________
;	     Outputs ________________________


C6191:	LD	A,(PRSCNT)
        INC	A
        LD	(PRSCNT),A
        LD	E,0FFH

;	  Subroutine put byte in queue (EI)
;	     Inputs  ________________________
;	     Outputs ________________________


C619A:	PUSH	HL
        PUSH	BC
J619C:	PUSH	DE
        LD	A,(VOICEN)		; current playvoice
        DI
        CALL	C6E25
        EI
        POP	DE
        JR	Z,J619C
J61A8:	POP	BC
        POP	HL
        RET

;	  Subroutine put byte in queue (DI)
;	     Inputs  ________________________
;	     Outputs ________________________


C61AB:	PUSH	HL
        PUSH	BC
J61AD:	PUSH	DE
        LD	A,(VOICEN)		; current playvoice
        DI
        CALL	C6E25
        POP	DE
        JR	NZ,J61A8
        EI
        JR	J61AD

;	  Subroutine less then 8 bytes free in voice queue
;	     Inputs  ________________________
;	     Outputs ________________________


C61BB:	LD	A,(VOICEN)		; current playvoice
        PUSH	BC
        DI
        CALL	C6E6D
        EI
        POP	BC
        CP	8
        RET

;	  Table      MCL PSG
;	     Inputs  ________________________
;	     Outputs ________________________


I61C8:	DEFB	"A"
        DEFW	C6303
        DEFB	"M"+128
        DEFW	C623A
        DEFB	"V"+128
        DEFW	C6223
        DEFB	"S"+128
        DEFW	C625C
        DEFB	"N"+128
        DEFW	C62C0
        DEFB	"O"+128
        DEFW	C628C
        DEFB	"R"+128
        DEFW	C629B
        DEFB	"T"+128
        DEFW	C627F
        DEFB	"L"+128
        DEFW	C6266
        DEFB	"X"
        DEFW	C6E0B
        DEFB	">"
        DEFW	C657A
        DEFB	"<"
        DEFW	C6587
        DEFB	"Y"+128
        DEFW	C63E8
        DEFB	"Q"+128
        DEFW	C63FE
        DEFB	"@"
        DEFW	C640D
        DEFB	"&"
        DEFW	C63E7
        DEFB	"Z"+128
        DEFW	C6409
        DEFB	0

I61FC:	DEFB	010H,012H,014H,016H
        DEFB	000H,000H,002H,004H
        DEFB	006H,008H,00AH,00AH
        DEFB	00CH,00EH,010H

I620B:	DEFW	3421,3228,3047,2876,2715,2562
        DEFW	2419,2283,2155,2034,1920,1812

;	  Subroutine PSG MCL "V"
;	     Inputs  ________________________
;	     Outputs ________________________


C6223:	JR	C,J6227			; value specified
        LD	E,8			; use a default of 8
J6227:	LD	A,15
        CP	E			; volume 0-15 ?
        JR	C,J627C			; nope, illegal function call
J622C:	CALL	C6425			; check for byte value
        LD	L,18
        CALL	C6F13			; get pointer in voicebuffer of current playvoice
        LD	A,40H
        AND	(HL)			; keep b6
        OR	E
        LD	(HL),A			; set volume
        RET

;	  Subroutine PSG MCL "M"
;	     Inputs  ________________________
;	     Outputs ________________________


C623A:	LD	A,E
        JR	C,J6240			; value specified, check for zero
        CPL
        INC	A
        LD	E,A			; use a default of 255
J6240:	OR	D
        JR	Z,J627C			; zero value, illegal function call
        LD	L,19
        CALL	C6F13			; get pointer in voicebuffer of current playvoice
        PUSH	HL
        LD	A,(HL)
        INC	HL
        LD	H,(HL)
        LD	L,A			; current envelope
        CALL	C6FF4			; compare with new envelope
        POP	HL
        RET	Z			; equal, quit
        LD	(HL),E
        INC	HL
        LD	(HL),D			; new envelope
        DEC	HL
        DEC	HL
        LD	A,40H
        OR	(HL)
        LD	(HL),A			; set b6 volume
        RET

;	  Subroutine PSG MCL "S"
;	     Inputs  ________________________
;	     Outputs ________________________


C625C:	LD	A,E
        CP	16			; value 0-15 ?
        JR	NC,J627C		; nope, illegal function call
        OR	10H
        LD	E,A			; b4 set
        JR	J622C			; set volume

;	  Subroutine FM/PSG MCL "L"
;	     Inputs  ________________________
;	     Outputs ________________________


C6266:	JR	C,J626A			; specified, use that
        LD	E,4			; use a default of 4
J626A:	LD	A,E
        CP	64+1			; notelength 0-64 ?
        JR	NC,J627C		; nope, illegal function call
        LD	L,16			; notelength offset

;	  Subroutine check for non zero value and set value
;	     Inputs  L = offset
;	     Outputs ________________________


J6271:	CALL	C6F13			; get pointer in voicebuffer of current playvoice
        CALL	C6425			; check for byte value
        OR	E			; zero value ?
        JR	Z,J627C			; yep, illegal function call
        LD	(HL),A
        RET

J627C:	JP	C6EAB			; illegal function call

;	  Subroutine FM/PSG/drum MCL "T"
;	     Inputs  ________________________
;	     Outputs ________________________


C627F:	JR	C,J6283			; value specified, use that
        LD	E,120			; use a default of 120
J6283:	LD	A,E
        CP	32			; tempo 32-255 ?
        JR	C,J627C			; nope, illegal function call
        LD	L,17
        JR	J6271			; check for non zero value and set tempo value

;	  Subroutine FM/PSG MCL "O"
;	     Inputs  ________________________
;	     Outputs ________________________


C628C:	JR	C,J6290			; value specified, use that
        LD	E,4			; use a default of 4
J6290:	LD	A,E
        CP	8+1			; octave 0-8 ?
        JR	NC,J627C		; nope, illegal function call
        LD	L,15
        JR	J6271			; check for non zero value and set octave value

J6299:	XOR	A
        LD	D,A
C629B:	JR	C,J629F
        LD	E,04H
J629F:	XOR	A
        OR	D
        JR	NZ,J627C
        OR	E
        JR	Z,J627C
        CP	64+1
        JR	NC,J627C
J62AA:	LD	HL,0
        PUSH	HL
        LD	L,16			; notelength offset
        CALL	C6F13			; get pointer in voicebuffer of current playvoice
        PUSH	HL
        INC	HL
        INC	HL
        LD	A,(HL)
        LD	(SAVVOL),A
        LD	(HL),80H
        DEC	HL
        DEC	HL
        JR	J633C

;	  Subroutine PSG MCL "N"
;	     Inputs  ________________________
;	     Outputs ________________________


C62C0:	JR	NC,J627C
        CALL	C6425			; check for byte value
        OR	E
        JR	Z,J62AA
        CP	96+1
        JR	NC,J627C
        LD	A,E
        LD	B,0
        LD	E,B
J62D0:	SUB	12
        INC	E
        JR	NC,J62D0
        ADD	A,12
        ADD	A,A
        LD	C,A
        JP	J6313


;	  Subroutine __________________________
;	     Inputs  ________________________
;	     Outputs ________________________


C62DC:	LD	B,C
        LD	A,C
        SUB	40H
        ADD	A,A
        LD	C,A
        CALL	C6D6E			; get MCL char
        JR	Z,J6301			; end of string,
        CP	"#"
        RET	Z
        CP	"+"
        RET	Z
        CP	"-"
        JR	Z,J62F6
        CALL	C6D94			; undo MCL char
        JR	J6301

J62F6:	DEC	C
        LD	A,B
        CP	"C"
        JR	Z,J6300
        CP	"F"
        JR	NZ,J6301
J6300:	DEC	C
J6301:	DEC	C
        RET

;	  Subroutine PSG MCL "A"-"G"
;	     Inputs  ________________________
;	     Outputs ________________________


C6303:	CALL	C62DC
        LD	L,15
        CALL	C6F13			; get pointer in voicebuffer of current playvoice
        LD	E,(HL)			; current octave
        LD	B,0
        LD	HL,I61FC
        ADD	HL,BC
        LD	C,(HL)
J6313:	LD	HL,I620B
        ADD	HL,BC
        LD	A,E
        LD	E,(HL)
        INC	HL
        LD	D,(HL)
J631B:	DEC	A
        JR	Z,J6327
        SRL	D
        RR	E
        JR	J631B

J6324:	CALL	C6EAB			; illegal function call
J6327:	ADC	A,E
        LD	E,A
        ADC	A,D
        SUB	E
        LD	D,A
        PUSH	DE
        LD	L,16
        CALL	C6F13			; get pointer in voicebuffer of current playvoice
        LD	C,(HL)			; notelength
        PUSH	HL
        CALL	C6D6E			; get MCL char
        JR	Z,J6348			; end of string,
        CALL	C6DA5			; parse numeric operand (1st char get)
J633C:	LD	A,64
        CP	E
        JR	C,J6324
        CALL	C6425			; check for byte value
        OR	E
        JR	Z,J6348
        LD	C,E
J6348:	POP	HL
        INC	HL
        PUSH	HL
        CALL	C667B
        EX	DE,HL
        LD	BC,-9
        POP	HL
        PUSH	HL
        ADD	HL,BC
        LD	(HL),D
        INC	HL
        LD	(HL),E
        INC	HL
        LD	C,2
        EX	(SP),HL
        INC	HL
        LD	E,(HL)
        LD	A,E
        AND	0BFH
        LD	(HL),A
        EX	(SP),HL
        LD	A,80H
        OR	E
        LD	(HL),A
        INC	HL
        INC	C
        EX	(SP),HL
        LD	A,E
        AND	40H
        JR	Z,J637B
        INC	HL
        LD	E,(HL)
        INC	HL
        LD	D,(HL)
        POP	HL
        LD	(HL),D
        INC	HL
        LD	(HL),E
        INC	HL
        INC	C
        INC	C
        DEFB	0FEH
J637B:	POP	HL
        POP	DE
        LD	A,D
        OR	E
        JR	Z,J6386
        LD	(HL),D
        INC	HL
        LD	(HL),E
        INC	C
        INC	C
J6386:	LD	L,7
        CALL	C6F13			; get pointer in voicebuffer of current playvoice
        LD	(HL),C			; musicpacket size
        LD	A,C
        SUB	02H
        RRCA
        RRCA
        RRCA
        INC	HL
        OR	(HL)
        LD	(HL),A
        DEC	HL
        LD	A,D
        OR	E
        JR	NZ,J63A6
        PUSH	HL
        LD	A,(SAVVOL)
        OR	80H
        LD	BC,11
        ADD	HL,BC
        LD	(HL),A
        POP	HL
J63A6:	POP	DE
        LD	B,(HL)
        INC	HL
J63A9:	LD	E,(HL)
        INC	HL
        CALL	C619A			; put byte in queue (EI)
        DJNZ	J63A9
        CALL	C61BB			; less then 8 bytes free in voice queue ?
        JP	C,J610B			; yep,
        JP	J6D1A			; start MCL parser

;	  Subroutine divide
;	     Inputs  DE = param, HL = divider
;	     Outputs HL = remainer, DE = result

C63B9:	LD	B,H
        LD	C,L
        XOR	A
        LD	H,A
        LD	L,A
        PUSH	HL
        SBC	HL,BC
        EX	DE,HL
        ADD	HL,HL
        LD	A,H
        LD	C,L
        POP	HL
        LD	B,16
J63C8:	ADC	HL,HL
        ADD	HL,DE
        JR	C,J63CF
        SBC	HL,DE
J63CF:	RL	C
        RLA
        DJNZ	J63C8
        LD	D,A
        LD	E,C
        RET


;	  Subroutine __________________________
;	     Inputs  ________________________
;	     Outputs ________________________


C63D7:	LD	E,8
        LD	HL,0
J63DC:	ADD	HL,HL
        RLA
        JR	NC,J63E3
        ADD	HL,BC
        ADC	A,0
J63E3:	DEC	E
        JP	NZ,J63DC
C63E7:	RET

C63E8:	JR	NC,J6428
        LD	A,E
        CP	200+1
        JR	NC,J6428
        CALL	C6425			; check for byte value
        CALL	C6D6E			; get MCL char
        CP	","
        JR	NZ,J6428
        CALL	C6DA2			; parse numeric operand
        JR	C6425			; check for byte value

C63FE:	JR	C,J6402
        LD	E,8
J6402:	LD	A,E
        CP	9
        JR	NC,J6428
        JR	C6425			; check for byte value

C6409:	JR	NC,J6428
        JR	C6425			; check for byte value

C640D:	CALL	C6D68			; get MCL char (error if end of string)
        CP	"V"
        JR	Z,J642B
        CP	"W"
        JR	Z,J643E
        CALL	C64ED			; numeric operand ?
        JR	C,J6428			; nope, illegal function call
        CALL	C6DA5			; parse numeric operand (1st char get)
        LD	A,E
        CP	64
        JR	NC,J6428

;	  Subroutine check for byte value
;	     Inputs  ________________________
;	     Outputs ________________________


C6425:	LD	A,D
        OR	A
        RET	Z
J6428:	JP	C6EAB			; illegal function call

J642B:	CALL	C6D6E			; get MCL char
        RET	Z			; end of string, quit
        CALL	C64ED			; numeric operand ?
        JR	C,J6428			; nope, illegal function call
        CALL	C6DA5			; parse numeric operand (1st char get)
        LD	A,E
        CP	128
        JR	NC,J6428
        JR	C6425			; check for byte value

J643E:	CALL	C6D6E			; get MCL char
        JR	Z,J6451			; end of string
        CALL	C64ED			; numeric operand ?
        JR	C,J644E			; nope,
        CALL	C6DA5			; parse numeric operand (1st char get)
        JP	J629F

J644E:	CALL	C6D94			; undo MCL char
J6451:	JP	J6299

;	  Table      MCL FM
;	     Inputs  ________________________
;	     Outputs ________________________


I6454:	DEFB	"A"
        DEFW	C65BC
        DEFB	"&"
        DEFW	C66DB
        DEFB	"{"
        DEFW	C66E4
        DEFB	"}"+128
        DEFW	C6763
        DEFB	"Y"+128
        DEFW	C64FD
        DEFB	"L"+128
        DEFW	C6266
        DEFB	"Q"+128
        DEFW	C656C
        DEFB	"V"+128
        DEFW	C6533
        DEFB	"O"+128
        DEFW	C628C
        DEFB	">"
        DEFW	C657A
        DEFB	"<"
        DEFW	C6587
        DEFB	"Z"+128
        DEFW	C6529
        DEFB	"X"
        DEFW	C6E0B
        DEFB	"R"+128
        DEFW	C6592
        DEFB	"N"+128
        DEFW	C65AF
        DEFB	"T"+128
        DEFW	C627F
        DEFB	"@"
        DEFW	C648E
        DEFB	"M"+128
        DEFW	C655D
        DEFB	"S"+128
        DEFW	C6564
        DEFB	0

;	  Subroutine FM MCL "@"
;	     Inputs  ________________________
;	     Outputs ________________________


C648E:	CALL	C6D68			; get MCL char (error if end of string)
        CP	"V"
        JR	Z,J64C1
        CP	"W"
        JR	Z,J64E1
        CALL	C64ED			; numeric operand ?
        JR	C,J64EA			; nope, illegal function call
        CALL	C6DA5			; parse numeric operand (1st char get)
        CALL	C6425			; check for byte value
        LD	A,E
        CP	64			; instrumentnumber 0-63 ?
        JR	NC,J64EA		; nope, illegal function call
        LD	C,A
        LD	A,(VOICEN)		; current playvoice
        CALL	C696D			; get playvoice type
        JR	NC,J64B7		; not a sample playvoice, instrument valid
        LD	A,C
        CP	16			; instrument a valid samplenumber 0-15 ?
        JR	NC,J64EA		; nope, illegal function call
J64B7:	LD	E,84H			; change instrument
        CALL	C61AB			; put byte in queue (DI)
        LD	E,C
        POP	BC
        JP	J6646

;	  Subroutine FM/drum MCL "@V" (set volume fine)
;	     Inputs  ________________________
;	     Outputs ________________________


J64C1:	CALL	C6D68			; get MCL char (error if end of string)
        CALL	C64ED			; numeric operand ?
        JR	C,J64EA			; nope, illegal function call
        CALL	C6DA5			; parse numeric operand (1st char get)
        LD	A,127
        SUB	E
        JP	M,J64EA
        RRA
        LD	C,A
        CALL	C6425			; check for byte value
        LD	E,85H			; set volume (fine)
        CALL	C61AB			; put byte in queue (DI)
        LD	E,C
        POP	BC
        JP	J6646

;	  Subroutine FM MCL "@W" (length)
;	     Inputs  ________________________
;	     Outputs ________________________


J64E1:	POP	DE
        CALL	C6652			; get notelength
        LD	E,83H
        JP	J6631			; put 3 bytes in queue (DI) and

J64EA:	JP	C6EAB			; illegal function call

;	  Subroutine numeric operand ?
;	     Inputs  ________________________
;	     Outputs ________________________


C64ED:	CP	"+"
        RET	Z
        CP	"-"
        RET	Z
        CP	"="
        RET	Z
        CP	"0"
        RET	C
        CP	"9"+1
        CCF
        RET

;	  Subroutine FM/drum MCL "Y"
;	     Inputs  ________________________
;	     Outputs ________________________


C64FD:	JR	NC,J6526		; value not specified, illegal function call
        LD	A,E
        CP	0C9H			; registernumber 0-0C8H ?
        JR	NC,J6526		; nope, illegal function call
        CALL	C6425			; check for byte value
        PUSH	DE
        CALL	C6D68			; get MCL char (error if end of string)
        CP	","
        JR	NZ,J6526		; not a seperator, illegal function call
        CALL	C6DA2			; parse numeric operand
        CALL	C6425			; check for byte value
        PUSH	DE
        LD	E,82H			; WRITE Y8950 REGISTER
        CALL	C61AB			; put byte in queue (DI)
        POP	HL
        EX	(SP),HL
        LD	E,L
        CALL	C61AB			; put byte in queue (DI)
        POP	DE
        POP	BC
        JP	J6646

J6526:	JP	C6EAB			; illegal function call

;	  Subroutine FM MCL "Z"
;	     Inputs  ________________________
;	     Outputs ________________________


C6529:	JR	NC,J6526
        CALL	C6425			; check for byte value
        LD	C,E
        LD	E,8AH			; MIDI DATA
        JR	J6542

;	  Subroutine FM MCL "V"
;	     Inputs  ________________________
;	     Outputs ________________________


C6533:	JR	C,J6537			; value specified, use that
        LD	E,8
J6537:	CALL	C6425			; check for byte value
        LD	A,E
        CP	16
        JR	NC,J6561
J653F:	LD	C,A
        LD	E,81H			; SET VOLUME
J6542:	CALL	C61AB			; put byte in queue (DI)
        LD	E,C
        POP	BC
        JP	J6646

;	  Subroutine drum MCL "V"
;	     Inputs  ________________________
;	     Outputs ________________________


C654A:	JR	C,J654E			; value specified, use that
        LD	E,8
J654E:	CALL	C6425			; check for byte value
        LD	A,E
        CP	16
        JR	NC,J6561
        LD	A,15
        SUB	E
        ADD	A,A
        LD	E,A
        JR	J653F

;	  Subroutine FM MCL "M"
;	     Inputs  ________________________
;	     Outputs ________________________


C655D:	RET	NC
        LD	A,E
        OR	D
        RET	NZ
J6561:	JP	C6EAB			; illegal function call

;	  Subroutine FM MCL "S"
;	     Inputs  ________________________
;	     Outputs ________________________


C6564:	LD	A,E
        CP	16
        JR	NC,J6561
        JP	C6425			; check for byte value

;	  Subroutine FM MCL "Q"
;	     Inputs  ________________________
;	     Outputs ________________________


C656C:	JR	C,J6570			; value specified, use that
        LD	E,8			; use a default of 8
J6570:	LD	A,E
        CP	8+1			; 0-8 ?
        JR	NC,J6561		; nope, illegal function call
        LD	L,38
        JP	J6271			; check for non zero value and set division value

;	  Subroutine FM/PSG MCL ">"
;	     Inputs  ________________________
;	     Outputs ________________________


C657A:	LD	L,15
        CALL	C6F13			; get pointer in voicebuffer of current playvoice
        LD	A,(HL)			; current octave
        INC	A			; increase
        CP	8+1			; octave > 8 ?
        JR	NC,J6561		; yep, illegal function call
        LD	(HL),A			; new octave
        RET

;	  Subroutine FM/PSG MCL "<"
;	     Inputs  ________________________
;	     Outputs ________________________


C6587:	LD	L,15
        CALL	C6F13			; get pointer in voicebuffer of current playvoice
        LD	A,(HL)			; current octave
        DEC	A			; decrease
        JR	Z,J6561			; octave 0, illegal function call
        LD	(HL),A			; new octave
        RET

;	  Subroutine FM/drum MCL "R"
;	     Inputs  ________________________
;	     Outputs ________________________


C6592:	JR	C,J6596
        LD	E,4
J6596:	CALL	C6425			; check for byte value
        OR	E
        JR	Z,J6561
        CP	64+1
        JR	NC,J6561
        XOR	A
        PUSH	AF
        LD	HL,I65DC
        PUSH	HL
        LD	L,16			; notelength offset
        CALL	C6F13			; get pointer in voicebuffer of current playvoice
        PUSH	HL
        JP	J666D			; get note duration

;	  Subroutine FM MCL "N"
;	     Inputs  ________________________
;	     Outputs ________________________


C65AF:	JR	NC,J6561
        CALL	C6425			; check for byte value
        LD	A,E
        CP	96+1
        JR	C,J65D6
        JP	C6EAB			; illegal function call

;	  Subroutine FM MCL "A"-"G"
;	     Inputs  ________________________
;	     Outputs ________________________


C65BC:	CALL	C62DC
        LD	L,15
        CALL	C6F13			; get pointer in voicebuffer of current playvoice
        LD	D,12
        LD	B,(HL)			; current octave
        LD	A,-12
J65C9:	ADD	A,D
        DJNZ	J65C9
        LD	D,A
        LD	B,0
        LD	HL,I61FC
        ADD	HL,BC
        LD	A,(HL)
        RRCA
        ADD	A,D
J65D6:	ADD	A,12
        PUSH	AF
        CALL	C6652			; get notelength
I65DC:	PUSH	HL
        CALL	C6D6E			; get MCL char
        JR	Z,J65EB			; end of string,
        CP	"&"
        PUSH	AF
        CALL	C6D94			; undo MCL char
        POP	AF
        JR	Z,J662D			; yep, use 3 bytes version
J65EB:	LD	L,38
        CALL	C6F13			; get pointer in voicebuffer of current playvoice
        LD	A,(HL)
        CP	8			; default division value ?
        JR	Z,J662D			; yep, use 3 bytes version
        POP	DE
        PUSH	DE
        LD	B,A
        LD	HL,0
J65FB:	ADD	HL,DE
        DJNZ	J65FB			; * division value
        SRL	H
        RR	L
        SRL	H
        RR	L
        SRL	H
        RR	L			; /8
        POP	DE
        EX	DE,HL
        OR	A
        SBC	HL,DE
        EX	DE,HL
        JR	Z,J662E
        POP	AF
        POP	BC
        PUSH	DE
        LD	E,A
        CALL	C61AB			; put byte in queue (DI)
        LD	E,L
        CALL	C61AB			; put byte in queue (DI)
        LD	E,H
        CALL	C61AB			; put byte in queue (DI)
        LD	E,0
        CALL	C61AB			; put byte in queue (DI)
        POP	DE
        CALL	C61AB			; put byte in queue (DI)
        LD	E,D
        JR	J6639

J662D:	POP	HL
J662E:	POP	AF
        POP	DE
        LD	E,A
J6631:	CALL	C61AB			; put byte in queue (DI)
        LD	E,L
        CALL	C61AB			; put byte in queue (DI)
        LD	E,H
J6639:	CALL	C61AB			; put byte in queue (DI)
        CALL	C61BB			; less then 8 bytes free in voice queue ?
        EI
        JP	C,J610B			; yep,
        JP	J6D1A			; start MCL parser

J6646:	CALL	C61AB			; put byte in queue (DI)
        CALL	C61BB			; less then 8 bytes free in voice queue ?
        JP	C,J610B			; yep,
        JP	J6D1A			; start MCL parser

;	  Subroutine get notelength
;	     Inputs  ________________________
;	     Outputs ________________________


C6652:	LD	L,9
        CALL	C6F13			; get pointer in voicebuffer of current playvoice
        LD	C,(HL)
        LD	A,C
        OR	A
        PUSH	AF
        LD	L,16
        CALL	C6F13			; get pointer in voicebuffer of current playvoice
        POP	AF
        JR	NZ,J6664
        LD	C,(HL)			; notelength
J6664:	PUSH	HL
        CALL	C6D6E			; get MCL char
        JR	Z,J6679			; end of string, use current notelength
        CALL	C6DA5			; parse numeric operand (1st char get)
J666D:	LD	A,64
        CP	E			; 0-64 ?
        JR	C,J66E1			; nope, illegal function call
        CALL	C6425			; check for byte value
        OR	E			; zero value ?
        JR	Z,J6679			; yep, use
        LD	C,E
J6679:	POP	HL
        INC	HL


;	  Subroutine __________________________
;	     Inputs  ________________________
;	     Outputs ________________________


C667B:	LD	A,(HL)
        LD	B,0
        CALL	C63D7
        PUSH	HL
        LD	DE,28800		; (120*4*int freq)/2, int freq=120 Hz
        CALL	C63B9			; divide
        EX	DE,HL
        EX	(SP),HL
        LD	B,5
J668C:	SRL	H
        RR	L
        DJNZ	J668C			; /32
        CALL	C63B9			; divide
        CALL	C66CC			; get pointer to interrupt corrector byte of playvoice
        LD	L,(IX+0)
        LD	H,0
        ADD	HL,DE
        LD	(IX+0),L
        LD	DE,-32
        ADD	HL,DE
        JR	NC,J66AD
        LD	(IX+0),L
        POP	HL
        INC	HL
        PUSH	HL
J66AD:	POP	DE
        LD	H,D
        LD	L,E
J66B0:	CALL	C6D6E			; get MCL char
        JR	Z,J66CB			; end of string, quit
        CP	"."
        JR	NZ,J66C8
        SRL	D
        RR	E
        ADC	HL,DE
        LD	A,0E0H
        AND	H
        JR	Z,J66B0
        XOR	H
        LD	H,A
        JR	J66CB

J66C8:	CALL	C6D94			; undo MCL char
J66CB:	RET

;	  Subroutine get pointer to interrupt corrector byte of playvoice
;	     Inputs  ________________________
;	     Outputs ________________________


C66CC:	PUSH	BC
        LD	A,(VOICEN)		; current playvoice
        LD	C,A
        LD	B,0
        LD	IX,I7FC6
        ADD	IX,BC
        POP	BC
        RET

;	  Subroutine FM MCL "&"
;	     Inputs  ________________________
;	     Outputs ________________________


C66DB:	LD	E,87H
        POP	BC
        JP	J6646

J66E1:	JP	C6EAB			; illegal function call

;	  Subroutine FM MCL "{"
;	     Inputs  ________________________
;	     Outputs ________________________


C66E4:	LD	L,9
        CALL	C6F13			; get pointer in voicebuffer of current playvoice
        LD	A,(HL)
        JR	NZ,J66E1
        LD	C,0
        LD	HL,(MCLPTR)
        PUSH	HL
        LD	A,(MCLLEN)
        PUSH	AF
J66F6:	CALL	C6D68			; get MCL char (error if end of string)
J66F9:	CP	"N"
        JR	Z,J6709
        CP	"R"
        JR	Z,J6709
        CP	"A"
        JR	C,J670C
        CP	"G"+1
        JR	NC,J670C
J6709:	INC	C
        JR	J66F6

J670C:	CP	"}"
        JR	Z,J6722
        CP	"{"			; nesting of "{" ?
        JR	Z,J66E1			; yep, illegal function call
        CP	"="
        JR	NZ,J66F6
J6718:	CALL	C6D68			; get MCL char (error if end of string)
        CALL	C6FCE
        JR	C,J6718
        JR	J66F9

J6722:	LD	L,16
        CALL	C6F13			; get pointer in voicebuffer of current playvoice
        LD	E,(HL)			; notelength
        LD	D,0
        CALL	C6D6E			; get MCL char
        JR	Z,J673C			; end of string, use current notelength
        CALL	C6D94			; undo MCL char
        CALL	C64ED			; numeric operand ?
        JR	C,J673C			; nope, use current notelength
        PUSH	BC
        CALL	C6DA2			; parse numeric operand
        POP	BC
J673C:	LD	A,64
        CP	E
        JR	C,J66E1
        CALL	C6425			; check for byte value
        LD	A,C			; number of notes
        LD	B,D
        LD	C,E
        CALL	C63D7			;
        OR	H
        JR	NZ,J66E1
        LD	A,L
        CP	64+1
        JR	NC,J66E1
        PUSH	AF
        LD	L,9
        CALL	C6F13			; get pointer in voicebuffer of current playvoice
        POP	AF
        LD	(HL),A
        POP	AF
        LD	(MCLLEN),A
        POP	HL
        LD	(MCLPTR),HL
        RET

;	  Subroutine FM MCL "}"
;	     Inputs  ________________________
;	     Outputs ________________________


C6763:	LD	L,9
        CALL	C6F13			; get pointer in voicebuffer of current playvoice
        LD	A,(HL)
        OR	A
        JR	Z,J679B
        LD	(HL),00H
        RET

;	  Table      MCL drum
;	     Inputs  ________________________
;	     Outputs ________________________


I676F:	DEFB	"B"
        DEFW	C679E
        DEFB	"S"
        DEFW	C679E
        DEFB	"M"
        DEFW	C679E
        DEFB	"C"
        DEFW	C679E
        DEFB	"H"
        DEFW	C679E
        DEFB	"R"+128
        DEFW	C6592
        DEFB	"@"
        DEFW	C67F7
        DEFB	"T"+128
        DEFW	C627F
        DEFB	"Y"+128
        DEFW	C64FD
        DEFB	"V"+128
        DEFW	C654A
        DEFB	"X"
        DEFW	C6E0B
        DEFB	0

I6791:	DEFB "B","S","M","C","H"
        DEFB 010H,008H,004H,002H,001H


J679B:	JP	C6EAB			; illegal function call

;	  Subroutine drum MCL "B","S","M","C","H"
;	     Inputs  ________________________
;	     Outputs ________________________


C679E:	LD	BC,0
        CALL	C6D94			; undo MCL char
J67A4:	CALL	C6D68			; get MCL char (error if end of string)
        CALL	C64ED			; numeric operand ?
        JR	NC,J67D0		; yep,
        PUSH	BC
        LD	HL,I6791
        LD	BC,5
        CPIR				; find drum instrument
        JR	NZ,J679B		; not found, illegal function call
        LD	C,4
        ADD	HL,BC
        LD	D,(HL)			; or mask
        POP	BC
        CALL	C6D68			; get MCL char (error if end of string)
        CP	"!"			; accents preceeding note ?
        PUSH	AF
        CALL	NZ,C6D94		; nope, undo MCL char
        POP	AF
        JR	NZ,J67CB
        LD	A,D
        OR	B
        LD	B,A			; set drum instrument in accent mask
J67CB:	LD	A,D
        OR	C
        LD	C,A			; set drum instrument in normal mask
        JR	J67A4			; next

J67D0:	INC	C
        DEC	C			; any drums ?
        JR	Z,J679B			; nope, illegal function call
        LD	A,0C0H
        OR	C			; drum "note" indicator
        PUSH	AF
        PUSH	BC
        LD	HL,I67EC
        PUSH	HL			; after this, put in queue
        LD	L,16			; notelength offset
        CALL	C6F13			; get pointer in voicebuffer of current playvoice
        PUSH	HL
        CALL	C6D94			; undo MCL char
        CALL	C6DA2			; parse numeric operand
        JP	J666D			; get "note" duration

I67EC:	POP	BC
        POP	AF
        POP	DE
        LD	E,A			; drums byte with normal drum mask
        CALL	C61AB			; put byte in queue (DI)
        LD	E,B			; accent drum mask
        JP	J6631			; put 3 bytes in queue (DI) and

;	  Subroutine drum MCL "@"
;	     Inputs  ________________________
;	     Outputs ________________________


C67F7:	CALL	C6D68			; get MCL char (error if end of string)
        CP	"V"
        JP	Z,J64C1
        CP	"A"
        JR	NZ,J679B		; nope, illegal function call
        CALL	C6D68			; get MCL char (error if end of string)
        CALL	C64ED			; numeric operand ?
        JR	C,J6825			; nope, illegal function call
        CALL	C6DA5			; parse numeric operand (1st char get)
        CALL	C6425			; check for byte value
        LD	A,E
        CP	16
        JR	NC,J6825
        LD	A,15
        SUB	E
        ADD	A,A
        LD	C,A
        LD	E,86H			; set accent volume drums
        CALL	C61AB			; put byte in queue (DI)
        LD	E,C
        POP	BC
        JP	J6646

J6825:	JP	C6EAB			; illegal function call

;	  Subroutine TIMER-1 handler
;	     Inputs  ________________________
;	     Outputs ________________________


I6828:	PUSH	AF
        DI
        LD	HL,D7B30
        LD	A,(D7B14)
        OR	A			; already in TIMER-1 handler ?
        JR	NZ,J6845		; yep, count int skip and quit
J6833:	CPL
        LD	(D7B14),A		; flag we are in TIMER-1 handler
        PUSH	HL
        CALL	C6848			; execute playvoice activities
        POP	HL
        DI
        XOR	A
        LD	(D7B14),A		; we are leaving the TIMER-1 handler
        DEC	(HL)			; do we have some skiped interrupts left ?
        JP	P,J6833			; yep, execute to keep up with
J6845:	INC	(HL)
        POP	AF
        RET


;	  Subroutine __________________________
;	     Inputs  ________________________
;	     Outputs ________________________


C6848:	LD	A,(MUSICF)
        OR	A			; any PSG playvoice active OR b7 set ?
        JR	Z,J6858			; nope,
        CALL	C6B8D			; CTRL-STOP pressed ?
        JR	NZ,J6865		; nope,
        LD	A,(MUSICF)
        AND	7FH			; any PSG playvoice active ?
J6858:	LD	HL,(D7B26)
        OR	L
        OR	H			; any playvoice active ?
        LD	HL,D7B28
        OR	(HL)			; OR something queued ?
        CALL	NZ,C6CDC		; yep, stop background music
        RET

J6865:	LD	BC,(D7B26)
        LD	A,B
        OR	C			; any playvoice active ?
        JR	Z,J6897			; nope, quit
        LD	HL,(D7F98)
        PUSH	HL
        CALL	C4D83			; MSX-AUDIO in page 0
        LD	HL,(D7F98)
        PUSH	HL
        XOR	A
J6879:	SRL	B
        RR	C
        PUSH	AF
        PUSH	BC
        CALL	C,C6898			; service playvoice
        POP	BC
        POP	AF
        INC	A
        LD	HL,D7B22
        CP	(HL)
        JR	C,J6879
        DI
        POP	HL
        LD	(D7F98),HL
        CALL	C4D8F			; restore page 0
        POP	HL
        LD	(D7F98),HL
J6897:	RET

;	  Subroutine service playvoice
;	     Inputs  ________________________
;	     Outputs ________________________


C6898:	LD	(D7B31),A		; current playvoice serviced
        DI
        LD	L,0
        CALL	C6F16			; get pointer in voicebuffer
        LD	E,(HL)
        INC	HL
        LD	D,(HL)
        LD	A,D
        OR	E			; duration counter zero ?
        JR	Z,J68B0			; yep, get new packet
        DEC	DE
        LD	(HL),D
        DEC	HL
        LD	(HL),E			; decrease duration counter
        LD	A,D
        OR	E			; counter reached zero ?
        RET	NZ			; nope, quit
        INC	HL
J68B0:	LD	A,(D7B23)
        LD	B,A			; number of AUDIO playvoices
        LD	A,(D7B31)		; current playvoice serviced
        CP	B			; PSG playvoice ?
        JP	NC,J2F70		; yep, handle
J68BB:	CALL	C6B64			; get from voicequeue serviced
        RET	Z			; queue empty, quit
J68BF:	INC	A			; endmarker (0FFH) ?
        JP	Z,J69E0			; yep, handle
        DEC	A			; 080H-FEH ?
        JP	M,J6A0A			; yep, handle
        PUSH	HL
        PUSH	AF
        LD	L,13
        CALL	C6B72			; get pointer in voicebuffer of playvoice serviced
        POP	AF
        LD	(HL),A
        POP	HL
        LD	D,A
        CALL	C6B64			; get from voicequeue serviced
        LD	C,A
        CALL	C6B64			; get from voicequeue serviced
        LD	(HL),A
        DEC	HL
        LD	(HL),C			; new duration
        LD	A,D
        OR	A			; zero ?
        JP	Z,C6945			; yep, note off and quit
        CALL	C693F			; note off
        CALL	C69B2			; get channelpointer and channels playvoice
        LD	L,18
        CALL	C6B72			; get pointer in voicebuffer of playvoice serviced
        LD	C,(HL)			; volume
        LD	E,0
        CALL	C4A9A			; audio bios 28
        CALL	C690D			; output to midi ?
        JP	NZ,J6B99		; yep, start midi note on and quit
        CALL	C696A			; get playvoice type of current serviced playvoice
        JP	C,J6936			; not a FM playvoice, sample playvoice
J68FE:	PUSH	BC
        PUSH	DE
        LD	A,35
        RST	00H			; audio function both Y8950 key-on
        LD	BC,64
        ADD	IX,BC
        POP	DE
        POP	BC
        DJNZ	J68FE			; next channel
        RET

;	  Subroutine output to midi ?
;	     Inputs  ________________________
;	     Outputs ________________________


C690D:	PUSH	HL
        LD	HL,D7B11
        BIT	0,(HL)
        POP	HL
        RET

;	  Subroutine connection
;	     Inputs  ________________________
;	     Outputs ________________________


C6915:	CALL	C6B64			; get from voicequeue serviced
        RET	Z			; queue empty, quit
        OR	A			; command byte or endmarker (080H-0FEH,0FFH) ?
        JP	M,J68BF			; yep, handle command byte or endmarker
        JR	Z,J68BF			; note off, handle note off
        PUSH	HL
        PUSH	AF
        LD	L,13
        CALL	C6B72			; get pointer in voicebuffer of playvoice serviced
        POP	AF
        CP	(HL)
        POP	HL
        JR	NZ,J68BF		; nope, handle note on
        CALL	C6B64			; get from voicequeue serviced
        LD	C,A
        CALL	C6B64			; get from voicequeue serviced
        LD	(HL),A
        DEC	HL
        LD	(HL),C			; duration
        RET

J6936:	LD	A,(D7B12)		; sample number for sample playvoice
        JP	J4BCF

J693C:	JP	J4C3A

;	  Subroutine note off
;	     Inputs  ________________________
;	     Outputs ________________________


C693F:	PUSH	DE
        CALL	C6945			; note off
        POP	DE
        RET

;	  Subroutine note off
;	     Inputs  ________________________
;	     Outputs ________________________


C6945:	CALL	C696A			; get playvoice type of current serviced playvoice
        JR	NC,J6954		; FM playvoice, note off FM
        RET	NZ			; not the first non-FM playvoice (drums), quit
        CALL	C690D			; output to midi ?
        JP	NZ,J6BA4		; yep, start midi note off and quit
        JP	J693C			; stop playing sample

J6954:	CALL	C690D			; output to midi ?
        JP	NZ,J6BA4		; yep, start midi note off and quit
        CALL	C69B2			; get channelpointer and channels playvoice
J695D:	PUSH	BC
        LD	A,37
        RST	00H			; audio function both Y8950 key-off
        LD	BC,64
        ADD	IX,BC
        POP	BC
        DJNZ	J695D			; next channel
        RET

;	  Subroutine get playvoice type of current serviced playvoice
;	     Inputs  ________________________
;	     Outputs ________________________


C696A:	LD	A,(D7B31)		; current playvoice serviced

;	  Subroutine get playvoice type
;	     Inputs  ________________________
;	     Outputs ________________________


C696D:	LD	HL,D7B15
        CP	(HL)			; number of FM-AUDIO playvoices
        CCF
        RET	NC			; FM-AUDIO playvoice (Cx is reset)
        PUSH	AF
        LD	A,(D7B1F)
        DEC	A			; audio mode 1 ?
        JR	Z,J697C			; yep,
        POP	AF			; Cx is set, Zx is set if first non-FM playvoice, Zx reset for any other playvoice
        RET

J697C:	POP	AF			; assume A<>0 and <128. Cx is set
        ADC	A,A			; this put the Cx flag in b0. Reset Cx, Reset Zx
        RRA				; Set Cx. Zx remains unchanged
        RET


;	  Subroutine __________________________
;	     Inputs  ________________________
;	     Outputs ________________________


C6980:	CALL	C690D			; output to midi ?
        JP	NZ,J6BA8		; yep, start midi program change
        CALL	C696A			; get playvoice type of current serviced playvoice
        JR	NC,J6990		; FM playvoice,
        LD	A,C
        LD	(D7B12),A		; sample number for sample playvoice
        RET

J6990:	PUSH	BC
        CALL	C69B2			; get channelpointer and channels playvoice
        POP	DE
        LD	C,E
J6996:	PUSH	BC
        LD	A,34			; both Y8950: operators sustain level 0, key off
        RST	00H
        POP	BC
        PUSH	BC
        LD	A,39			; set predefined instrument
        RST	00H
        LD	BC,32
        ADD	IX,BC
        POP	BC
        PUSH	BC
        LD	A,39			; set predefined instrument
        RST	00H
        LD	BC,32
        ADD	IX,BC
        POP	BC
        DJNZ	J6996			; next channel
        RET

;	  Subroutine get channelpointer and channels playvoice
;	     Inputs  ________________________
;	     Outputs ________________________


C69B2:	LD	A,(D7B31)		; current playvoice serviced
        CALL	C696D			; get playvoice type
        JR	NC,J69C3		; FM playvoice,
        JR	Z,J69C3			; first non-FM playvoice,
        LD	IX,I3000+6*64		; drum channel
        LD	B,3			; 3 channels
        RET

J69C3:	LD	HL,I7B16
        OR	A			; first AUDIO playvoice ?
        JR	Z,J69CF			; yep, first channel = 0
        LD	B,A
        XOR	A
J69CB:	ADD	A,(HL)
        INC	HL
        DJNZ	J69CB			; calculate first channel of AUDIO playvoice
J69CF:	LD	IX,I3000		; buffer channel 0
        OR	A			; channel 0 ?
        JR	Z,J69DE
        LD	BC,64
J69D9:	ADD	IX,BC
        DEC	A
        JR	NZ,J69D9		; get pointer to channel buffer
J69DE:	LD	B,(HL)
        RET

;	  Subroutine endmarker
;	     Inputs  ________________________
;	     Outputs ________________________


J69E0:	CALL	C6945			; note off
        LD	L,13
        CALL	C6B72			; get pointer in voicebuffer of playvoice serviced
        LD	(HL),0
J69EA:	LD	A,(D7B31)		; current playvoice serviced
        LD	HL,1
        LD	B,A
        OR	A
        JR	Z,J69F7
J69F4:	ADD	HL,HL
        DJNZ	J69F4
J69F7:	EX	DE,HL
        DI
        LD	HL,(D7B26)
        LD	A,E
        AND	L
        XOR	L
        LD	L,A
        LD	A,D
        AND	H
        XOR	H
        LD	H,A
        LD	(D7B26),HL		; deactivate playvoice
        JP	C6F66			; start dequeueing

;	  Subroutine special operationcode (80H-FEH)
;	     Inputs
;	     Outputs ________________________


J6A0A:	LD	E,A
        AND	0C0H
        CP	0C0H			; drum "notes" ?
        JP	Z,J6B1D			; yep, handle drums
        LD	A,E
        ADD	A,A
        EX	DE,HL
        ADD	A,LOW I6A23
        LD	L,A
        LD	A,0
        ADC	A,HIGH I6A23
        LD	H,A
        LD	C,(HL)
        INC	HL
        LD	B,(HL)
        EX	DE,HL
        PUSH	BC
        RET

I6A23:	DEFW	C6A43			; 080H, NOTE OFF
        DEFW	C6A46			; 081H, SET VOLUME
        DEFW	C6A73			; 082H, WRITE Y8950 REGISTER
        DEFW	C6A80			; 083H, SET NOTELENGTH
        DEFW	C6A8B			; 084H, CHANGE INSTRUMENT
        DEFW	C6A95			; 085H, SET VOLUME (FINE)
        DEFW	C6AF0			; 086H, SET ACCENT VOLUME DRUMS
        DEFW	C6915			; 087H, CONNECTION
        DEFW	C6A39			; 088H, OUPUT TO AUDIO/PSG
        DEFW	C6A3B			; 089H, OUPUT TO MIDI
        DEFW	C6BD0			; 08AH, RAW MIDI DATA

C6A39:	XOR	A			; output to audio/psg
        DEFB	1

C6A3B:	LD	A,1
        LD	(D7B11),A		; output to midi
        JP	J68BB

C6A43:	JP	C6945			; note off

;	  Subroutine set volume
;	     Inputs  ________________________
;	     Outputs ________________________


C6A46:	PUSH	HL
        CALL	C696A			; get playvoice type of current serviced playvoice
        POP	HL
        JR	NC,J6A52		; FM playvoice, set volume fm
        JP	NZ,J6AD8		; not the first non-FM playvoice, set volume drums
        JR	J6A60			; first non-FM playvoice, set volume sample

;	  Subroutine set volume FM playvoice
;	     Inputs  ________________________
;	     Outputs ________________________


J6A52:	PUSH	HL
        LD	L,18
        CALL	C6B72			; get pointer in voicebuffer of playvoice serviced
        CALL	C6B64			; get from voicequeue serviced
        LD	(HL),A			; set volume
J6A5C:	POP	HL
        JP	J68BB

;	  Subroutine set volume sample playvoice
;	     Inputs  ________________________
;	     Outputs ________________________


J6A60:	PUSH	HL
        LD	L,18
        CALL	C6B72			; get pointer in voicebuffer of playvoice serviced
        CALL	C6B64			; get from voicequeue serviced
        LD	(HL),A			; set volume
        ADD	A,A
        ADD	A,A
        ADD	A,3
        CALL	C6ACF
        JR	J6A5C

;	  Subroutine write y8950 register
;	     Inputs  ________________________
;	     Outputs ________________________


C6A73:	PUSH	HL
        CALL	C6B64			; get from voicequeue serviced
        LD	C,A
        CALL	C6B64			; get from voicequeue serviced
        CALL	C009C			; write audio register (DI)
        JR	J6A5C

;	  Subroutine set notelength
;	     Inputs  ________________________
;	     Outputs ________________________


C6A80:	CALL	C6B64			; get from voicequeue serviced
        LD	C,A
        CALL	C6B64			; get from voicequeue serviced
        LD	(HL),A
        DEC	HL
        LD	(HL),C
        RET

;	  Subroutine change instrument
;	     Inputs  ________________________
;	     Outputs ________________________


C6A8B:	PUSH	HL
        CALL	C6B64			; get from voicequeue serviced
        LD	C,A
        CALL	C6980
        JR	J6A5C

;	  Subroutine set volume (fine)
;	     Inputs  ________________________
;	     Outputs ________________________


C6A95:	CALL	C690D			; output to midi ?
        JP	NZ,J6BAD		; yep, start midi volume change
        PUSH	HL
        CALL	C696A			; get playvoice type of current serviced playvoice
        JR	NC,J6AA3		; FM playvoice,
        JR	Z,J6AC3			; first non-FM playvoice,
J6AA3:	CALL	C69B2			; get channelpointer and channels playvoice
        CALL	C6B64			; get from voicequeue serviced
        LD	E,A
        LD	C,15H
J6AAC:	CALL	C6AB6
        CALL	C6AB6
        DJNZ	J6AAC			; next channel
        JR	J6A5C


;	  Subroutine __________________________
;	     Inputs  ________________________
;	     Outputs ________________________


C6AB6:	PUSH	BC
        PUSH	DE
        LD	A,38
        RST	00H
        LD	BC,32
        ADD	IX,BC
        POP	DE
        POP	BC
        RET

J6AC3:	CALL	C6B64			; get from voicequeue serviced
        LD	E,A
        LD	A,63
        SUB	E
        CALL	C6ACF
        POP	HL
        RET


;	  Subroutine __________________________
;	     Inputs  ________________________
;	     Outputs ________________________


C6ACF:	LD	C,A
        LD	B,00H
        LD	E,A
        LD	D,00H
        JP	C44B4

;	  Subroutine set normal volume drums
;	     Inputs  ________________________
;	     Outputs ________________________


J6AD8:	PUSH	HL
        LD	L,10
        CALL	C6B72			; get pointer in voicebuffer of playvoice serviced
        CALL	C6B64			; get from voicequeue serviced
        LD	(HL),A
        LD	E,A
        LD	L,8
        CALL	C6B72			; get pointer in voicebuffer of playvoice serviced
        LD	A,(HL)
        CPL
        CALL	C6B07			; set volume drums
        JP	J6A5C

;	  Subroutine set accent volume drums
;	     Inputs  ________________________
;	     Outputs ________________________


C6AF0:	PUSH	HL
        LD	L,12
        CALL	C6B72			; get pointer in voicebuffer of playvoice serviced
        CALL	C6B64			; get from voicequeue serviced
        LD	(HL),A
        LD	E,A
        LD	L,8
        CALL	C6B72			; get pointer in voicebuffer of playvoice serviced
        LD	A,(HL)
        CALL	C6B07			; set volume drums
        JP	J6A5C

;	  Subroutine set volume drums
;	     Inputs  ________________________
;	     Outputs ________________________


C6B07:	AND	1FH
        RET	Z
        CALL	C690D			; output to midi ?
        JP	NZ,J6BC0		; yep, start midi rhythm velocity and quit
        PUSH	BC
        PUSH	DE
        LD	C,A
        LD	A,44
        LD	IX,I3000
        RST	00H			; AUDIO function set volume drums
        POP	DE
        POP	BC
        RET

;	  Subroutine drum operationcode (0C0H-0FEH)
;	     Inputs  ________________________
;	     Outputs ________________________


J6B1D:	CALL	C6B64			; get from voicequeue serviced (accent drum mask)
        LD	D,A
        CALL	C6B64			; get from voicequeue serviced (duration low)
        LD	C,A
        CALL	C6B64			; get from voicequeue serviced (duration high)
        LD	(HL),A
        DEC	HL
        LD	(HL),C			; duration
        PUSH	HL
        LD	L,8
        CALL	C6B72			; get pointer in voicebuffer of playvoice serviced
        LD	A,D
        XOR	(HL)			; accent mask changed ?
        JR	Z,J6B55			; nope, do not change percussion volume
        LD	(HL),D			; new accent mask
        PUSH	DE
        PUSH	AF
        AND	D
        PUSH	AF
        LD	L,12
        CALL	C6B72			; get pointer in voicebuffer of playvoice serviced
        LD	E,(HL)
        POP	AF
        CALL	C6B07			; set volume drums
        LD	A,D
        CPL
        LD	D,A
        POP	AF
        AND	D
        PUSH	AF
        LD	L,10
        CALL	C6B72			; get pointer in voicebuffer of playvoice serviced
        LD	E,(HL)
        POP	AF
        CALL	C6B07			; set volume drums
        POP	DE
J6B55:	POP	HL
        LD	A,E
        AND	3FH
        LD	C,A
        CALL	C690D			; output to midi ?
        JP	NZ,J6BCB		; yep, start midi rhythm operation and quit
        LD	A,21
        RST	00H			; audio function play percussion
        RET

;	  Subroutine get from voicequeue serviced
;	     Inputs  ________________________
;	     Outputs ________________________


C6B64:	PUSH	HL
        PUSH	DE
        PUSH	BC
        LD	A,(D7B31)		; current playvoice serviced
        DI
        CALL	C6E40
        POP	BC
        POP	DE
        POP	HL
        RET

;	  Subroutine get pointer in voicebuffer of playvoice serviced
;	     Inputs  ________________________
;	     Outputs ________________________


C6B72:	LD	A,(D7B31)		; current playvoice serviced
        DI
        JP	C6F16			; get pointer in voicebuffer

;	  Subroutine wait until queues are empty and playvoices are stopped
;	     Inputs  ________________________
;	     Outputs ________________________


C6B79:	EI
        CALL	C6B8D			; CTRL-STOP pressed ?
        SCF
        RET	Z			; yep, quit
        DI
        LD	HL,(D7B26)
        LD	A,L
        OR	H			; any playvoice active ?
        LD	HL,D7B28
        OR	(HL)			; OR something queued ?
        JR	NZ,C6B79		; yep, wait some more
        EI
        RET

;	  Subroutine CTRL-STOP pressed ?
;	     Inputs  ________________________
;	     Outputs ________________________


C6B8D:	LD	A,(BASROM)
        OR	A
        RET	NZ
        LD	A,(INTFLG)
        SUB	3
        OR	A
        RET

;	  Subroutine start midi note on
;	     Inputs
;	     Outputs ________________________


J6B99:	LD	B,0

;	  Subroutine start midi function
;	     Inputs  B = midi function
;	     Outputs ________________________


C6B9B:	LD	A,(D7B31)		; current playvoice serviced
        PUSH	HL
        CALL	C7B00			; midi hook
        POP	HL
        RET

;	  Subroutine start midi note off
;	     Inputs
;	     Outputs ________________________


J6BA4:	LD	B,1
        JR	C6B9B

;	  Subroutine start midi program change
;	     Inputs
;	     Outputs ________________________


J6BA8:	LD	B,2
        LD	D,C
        JR	C6B9B

;	  Subroutine start midi volume change
;	     Inputs
;	     Outputs ________________________


J6BAD:	CALL	C6B64			; get from voicequeue serviced
        LD	D,A
        PUSH	HL
        CALL	C696A			; get playvoice type of current serviced playvoice
        POP	HL
        LD	B,3
        JR	NC,C6B9B		; FM playvoice,
        JR	Z,C6B9B			; first non-FM playvoice,
        LD	B,4
        JR	C6B9B			; non the first non-FM playvoice

;	  Subroutine start midi rhythm velocity
;	     Inputs
;	     Outputs ________________________


J6BC0:	PUSH	BC
        PUSH	DE
        LD	D,A
        LD	B,5
        CALL	C6B9B
        POP	DE
        POP	BC
        RET

;	  Subroutine start midi rhythm operation
;	     Inputs
;	     Outputs ________________________


J6BCB:	LD	B,6
        LD	D,C
        JR	C6B9B

;	  Subroutine start midi raw data
;	     Inputs
;	     Outputs ________________________


C6BD0:	CALL	C6B64			; get from voicequeue serviced
        LD	D,A
        LD	B,07H
        JR	C6B9B


;	  Subroutine __________________________
;	     Inputs  ________________________
;	     Outputs ________________________


C6BD8:	XOR	A
        LD	(D7B29),A		; background
        LD	A,(D7B15)		; number of FM-AUDIO playvoices
        LD	HL,D7B1F
        BIT	0,(HL)			; drum mode ?
        JR	Z,J6BE7
        INC	A			; yep, extra playvoice
J6BE7:	BIT	1,(HL)			; sample mode ?
        JR	Z,J6BEC
        INC	A			; yep, extra playvoice
J6BEC:	LD	(D7B23),A		; number of AUDIO playvoices
        ADD	A,3			; and 3 playvoices for PSG
        LD	(D7B22),A		; total number of playvoices
        LD	B,A
        OR	80H
        LD	(D7B24),A		; number of playvoices, b7 set
        LD	HL,0
J6BFD:	SCF
        ADC	HL,HL
        DJNZ	J6BFD
        LD	(D7B20),HL		; playvoice mask
        LD	A,(D7B23)		; number of AUDIO playvoices
        ADD	A,LOW I6C31
        LD	L,A
        LD	A,0
        ADC	A,HIGH I6C31
        LD	H,A
        LD	A,(HL)			; voicequeue size
        LD	(D7B25),A		; queue size
        LD	HL,I7B34
        LD	(D7B32),HL
        LD	A,(EXPTBL+0)
        LD	HL,IDBYT0
        CALL	RDSLT
        AND	80H			; VDP interrupt frequency
        LD	HL,14400
        JR	Z,J6C2D			; 60 Hz
        LD	HL,12000		; 50 Hz
J6C2D:	LD	(D7B0A),HL
        RET

I6C31:	DEFB	000H,0FFH,07FH,07FH,03FH,03FH,03FH,01FH,01FH,01FH,01FH

;	  Subroutine __________________________
;	     Inputs  ________________________
;	     Outputs ________________________

C6C3C:	DI
        XOR	A
        LD	(D7B30),A		; no skipped TIMER-1 interrupts
        LD	(D7B28),A		; nothing queued
        LD	(D7B14),A		; not in TIMER-1 handler
        LD	(D7B0F),A		; current PLAY is AUDIO/PSG
        LD	(D7B10),A		; previous PLAY was AUDIO/PSG
        LD	(D7B11),A		; output to AUDIO/PSG
        LD	(D7B12),A		; sample number for sample playvoice = 0
        LD	HL,0
        LD	(D7B26),HL		; no playvoice active
        LD	A,(D7B23)
        OR	A			; no AUDIO playvoices ?
        JR	Z,J6C98			; yep, skip
        LD	B,A			; number of AUDIO playvoices
        LD	DE,I7B70
J6C63:	PUSH	BC
        PUSH	DE
        LD	A,(D7B23)
        SUB	B
        LD	(D7B31),A		; current playvoice serviced
        LD	HL,D7B25
        LD	B,(HL)			; queue size
        CALL	C6E5C
        POP	DE
        POP	BC
        LD	A,(D7B25)
        INC	A
        LD	L,A
        LD	H,0
        ADD	HL,DE
        EX	DE,HL
        DJNZ	J6C63			; next playvoice
        LD	A,(D7B23)
        LD	B,A			; number of AUDIO playvoices
J6C84:	PUSH	BC
        LD	A,B
        DEC	A
        LD	L,0			; start of voicebuffer
        CALL	C6F16			; get pointer in voicebuffer
        EX	DE,HL
        LD	HL,I6CB5
        LD	BC,39
        LDIR
        POP	BC
        DJNZ	J6C84
J6C98:	XOR	A
        LD	(MUSICF),A
        JP	J6EC6


;	  Subroutine __________________________
;	     Inputs  ________________________
;	     Outputs ________________________


C6C9F:	LD	A,(D7B1F)
        AND	01H			; drum mode ?
        RET	Z			; nope, quit
        LD	A,(I6CB5+10)		; default normal drum volume
        LD	E,A
        LD	A,1FH
        CALL	C4D83			; MSX-AUDIO in page 0
        CALL	C6B07			; set volume drums
        CALL	C4D8F			; restore page 0
        RET

I6CB5:	DEFW	0			; +0 , duration counter
        DEFB	0			; +2 , stringlength
        DEFW	0			; +3 , stringadres
        DEFW	0			; +5 , stackdata
        DEFB	0			; +7 , music packet length
        DEFB	0,0,14,0,0,0,0		; +8 , music packet
        DEFB	4			; +15, octave
        DEFB	4			; +16, length
        DEFB	120			; +17, tempo
        DEFB	8			; +18, volume
        DEFW	0			; +19, envelope period
        DEFS	16,0			; +21, stack
        DEFB	0			; +37, ?
        DEFB	8			; +38, division value
;	  Subroutine stop background music
;	     Inputs  ________________________
;	     Outputs ________________________


C6CDC:	CALL	C6C3C			; initialize playvoice
        CALL	C6C9F			; initialize for drums
        CALL	C4D83			; MSX-AUDIO in page 0
        LD	A,(D7B23)		; number of AUDIO playvoices
        CALL	C6CEE
        JP	C4D8F			; restore page 0


;	  Subroutine __________________________
;	     Inputs  ________________________
;	     Outputs ________________________


C6CEE:	DEC	A
        RET	M
        LD	(D7B31),A		; current playvoice serviced
        PUSH	AF
        CALL	C6945			; note off
        POP	AF
        JR	C6CEE

J6CFA:	CALL	C6F04			; free temporary string
        CALL	C6F5D			; get string parameters
        LD	B,C
        LD	C,D
        LD	D,E
        LD	A,B
        OR	C
        JR	Z,J6D0D
        LD	A,D
        OR	A
        JR	Z,J6D0D
        PUSH	BC
        PUSH	DE
J6D0D:	POP	AF
        LD	(MCLLEN),A
        POP	HL
        LD	A,H
        OR	L			; something to parse ?
        JP	Z,J6111			; nope, quit
        LD	(MCLPTR),HL

;	  Subroutine start MCL parser
;	     Inputs  ________________________
;	     Outputs ________________________


J6D1A:	CALL	C6D6E			; get MCL char
        JR	Z,J6D0D			; end of string,
        LD	HL,(MCLTAB)
        CP	"A"
        JR	C,J6D2A
        CP	"G"+1
        JR	C,J6D3A
J6D2A:	ADD	A,A
        LD	C,A
J6D2C:	LD	A,(HL)
        ADD	A,A
J6D2E:	CALL	Z,C6EAB			; illegal function call
        CP	C
        JR	Z,J6D39
        INC	HL
        INC	HL
        INC	HL
        JR	J6D2C

J6D39:	LD	A,(HL)
J6D3A:	LD	BC,J6D1A
        PUSH	BC			; at return, start the MCL parser
        LD	C,A
        ADD	A,A
        JR	NC,J6D62
        OR	A
        RRA
        LD	C,A
        PUSH	BC
        PUSH	HL
        CALL	C6D6E			; get MCL char
        LD	DE,1
        JP	Z,J6D5F			; end of string,
        CALL	C6FCE
        JP	NC,J6D5C
        CALL	C6DA5			; parse numeric operand (1st char get)
        SCF
        JR	J6D60

J6D5C:	CALL	C6D94			; undo MCL char
J6D5F:	OR	A
J6D60:	POP	HL
        POP	BC
J6D62:	INC	HL
        LD	A,(HL)
        INC	HL
        LD	H,(HL)
        LD	L,A
        JP	(HL)

;	  Subroutine get MCL char (error if end of string)
;	     Inputs  ________________________
;	     Outputs ________________________


C6D68:	CALL	C6D6E			; get MCL char
        JR	Z,J6D2E			; end of string, illegal function call
        RET

;	  Subroutine get MCL char
;	     Inputs  ________________________
;	     Outputs ________________________


C6D6E:	PUSH	HL
J6D6F:	LD	HL,MCLLEN
        LD	A,(HL)
        OR	A
        JR	Z,J6DA0
        DEC	(HL)
        LD	HL,(MCLPTR)
        LD	A,(HL)
        INC	HL
        LD	(MCLPTR),HL
        CP	" "
        JR	Z,J6D6F
        POP	HL
        CALL	C6D8B
        SCF
        ADC	A,A
        RRA
        RET


;	  Subroutine __________________________
;	     Inputs  ________________________
;	     Outputs ________________________


C6D8B:	CP	"a"
        RET	C
        CP	"z"+1
        RET	NC
        SUB	20H
        RET

;	  Subroutine undo MCL char
;	     Inputs  ________________________
;	     Outputs ________________________


C6D94:	PUSH	HL
        LD	HL,MCLLEN
        INC	(HL)
        LD	HL,(MCLPTR)
        DEC	HL
        LD	(MCLPTR),HL
J6DA0:	POP	HL
        RET

;	  Subroutine parse numeric operand
;	     Inputs  ________________________
;	     Outputs ________________________


C6DA2:	CALL	C6D68			; get MCL char (error if end of string)

;	  Subroutine parse numeric operand (1 char get)
;	     Inputs  ________________________
;	     Outputs ________________________


C6DA5:	CP	"="
        JP	Z,J6E03
        CP	"+"
        JR	Z,C6DA2			; yep, ignore
        CP	"-"
        JR	NZ,J6DB8
        LD	DE,I6E1E
        PUSH	DE
        JR	C6DA2

J6DB8:	LD	DE,0
J6DBB:	CP	","
        JR	Z,C6D94			; undo MCL char and quit
        CP	";"
        RET	Z
        CP	"9"+1
        JR	NC,C6D94		; undo MCL char and quit
        CP	"0"
        JR	C,C6D94			; undo MCL char and quit
        LD	HL,0
        LD	B,10
J6DCF:	ADD	HL,DE
        JR	C,J6DFC
        DJNZ	J6DCF
        SUB	"0"
        LD	E,A
        LD	D,00H
        ADD	HL,DE
        JR	C,J6DFC
        EX	DE,HL
        CALL	C6D6E			; get MCL char
        JR	NZ,J6DBB		; not end of string,
        RET


;	  Subroutine __________________________
;	     Inputs  ________________________
;	     Outputs ________________________


C6DE3:	CALL	C6D68			; get MCL char (error if end of string)
        LD	DE,BUF
        PUSH	DE
        LD	B,40
        CALL	C6FCE
        JR	C,J6DFC
J6DF1:	LD	(DE),A
        INC	DE
        CP	";"
        JR	Z,J6DFF
        CALL	C6D68			; get MCL char (error if end of string)
        DJNZ	J6DF1
J6DFC:	CALL	C6EAB			; illegal function call
J6DFF:	POP	HL
        JP	J6ECC			; get variable value

J6E03:	CALL	C6DE3
        CALL	BUF+128
        EX	DE,HL
        RET

;	  Subroutine FM/PSG/drum MCL "X"
;	     Inputs  ________________________
;	     Outputs ________________________


C6E0B:	CALL	C6DE3
        LD	A,(MCLLEN)
        LD	HL,(MCLPTR)
        EX	(SP),HL
        PUSH	AF
        LD	C,2			; 2 words
        CALL	C6FB4			; check for stackspace
        JP	J6CFA

I6E1E:	XOR	A
        SUB	E
        LD	E,A
        SBC	A,D
        SUB	E
        LD	D,A
        RET


;	  Subroutine __________________________
;	     Inputs  ________________________
;	     Outputs ________________________


C6E25:	CALL	C6E7C
        LD	A,B
        INC	A
        INC	HL
        AND	(HL)
        CP	C
        RET	Z
        DEC	HL
        DEC	HL
        DEC	HL
        LD	(HL),A
        INC	HL
        INC	HL
        INC	HL
        INC	HL
        LD	C,A
        LD	A,(HL)
        INC	HL
        LD	H,(HL)
        LD	L,A
        LD	B,00H
        ADD	HL,BC
        LD	(HL),E
        RET


;	  Subroutine __________________________
;	     Inputs  ________________________
;	     Outputs ________________________


C6E40:	CALL	C6E7C
        LD	A,C
        CP	B
        RET	Z
        INC	HL
        INC	A
        AND	(HL)
        DEC	HL
        DEC	HL
        LD	(HL),A
        INC	HL
        INC	HL
        INC	HL
        LD	C,A
        LD	A,(HL)
        INC	HL
        LD	H,(HL)
        LD	L,A
        LD	B,00H
        ADD	HL,BC
        LD	A,(HL)
        SCF
        ADC	A,A
        RRA
        RET


;	  Subroutine __________________________
;	     Inputs  ________________________
;	     Outputs ________________________


C6E5C:	PUSH	BC
        CALL	C6E84
        LD	(HL),B
        INC	HL
        LD	(HL),B
        INC	HL
        LD	(HL),B
        INC	HL
        POP	AF
        LD	(HL),A
        INC	HL
        LD	(HL),E
        INC	HL
        LD	(HL),D
        RET


;	  Subroutine __________________________
;	     Inputs  ________________________
;	     Outputs ________________________


C6E6D:	CALL	C6E7C
        LD	A,B
        INC	A
        INC	HL
        AND	(HL)
        LD	B,A
        LD	A,C
        SUB	B
        AND	(HL)
        LD	L,A
        LD	H,00H
        RET


;	  Subroutine __________________________
;	     Inputs  ________________________
;	     Outputs ________________________


C6E7C:	CALL	C6E84
        LD	B,(HL)
        INC	HL
        LD	C,(HL)
        INC	HL
        RET


;	  Subroutine __________________________
;	     Inputs  ________________________
;	     Outputs ________________________


C6E84:	LD	C,A
        LD	A,(D7B22)
        SUB	C
        SUB	4
        LD	HL,(QUEUES)
        JR	C,J6E95
        LD	HL,(D7B32)
        LD	A,C
        CPL
J6E95:	CPL
        ADD	A,A			; *2
        LD	B,A
        ADD	A,A			; *4
        ADD	A,B			; *6
        LD	C,A
        LD	B,0
        ADD	HL,BC
        RET

J6E9F:	LD	E,33H
        DEFB	1
J6EA2:	LD	E,35H
        DEFB	1
J6EA5:	LD	E,38H
        DEFB	1
J6EA8:	LD	E,02H
        DEFB	1
C6EAB:	LD	E,05H
        DEFB	1
J6EAE:	LD	E,0DH
        DEFB	1
        LD	E,06H
        DEFB	1
J6EB4:	LD	E,07H
J6EB6:	LD	A,(D7B13)
        AND	01H			; AUDIO-BASIC initialized ?
        PUSH	DE
        CALL	NZ,C6CDC		; yep, stop background music
        POP	DE
        LD	IX,M406F
        JR	J6F08

J6EC6:	LD	IX,GICINI
        JR	J6F08

;	  Subroutine get variable value
;	     Inputs  ________________________
;	     Outputs ________________________


J6ECC:	LD	IX,M4E9B
        JR	J6F08

;	  Subroutine evaluate filespec
;	     Inputs  ________________________
;	     Outputs ________________________


C6ED2:	LD	IX,M6A0E
        JR	J6F08

;	  Subroutine search variable
;	     Inputs  ________________________
;	     Outputs ________________________


C6ED8:	LD	IX,M5EA4
        JR	J6F08

;	  Subroutine convert DAC
;	     Inputs  ________________________
;	     Outputs ________________________


C6EDE:	LD	IX,M517A
        JR	J6F08

;	  Subroutine check for
;	     Inputs  ________________________
;	     Outputs ________________________


C6EE4:	LD	A,(HL)
        EX	(SP),HL
        CP	(HL)
        JP	NZ,J6EA8		; nope, syntax error
        INC	HL
        EX	(SP),HL

;	  Subroutine get BASIC char
;	     Inputs  ________________________
;	     Outputs ________________________


C6EEC:	LD	IX,M4666
        JR	J6F08

;	  Subroutine evaluate expression
;	     Inputs  ________________________
;	     Outputs ________________________


C6EF2:	LD	IX,M4C64
        JR	J6F08

;	  Subroutine evaluate adres operand
;	     Inputs  ________________________
;	     Outputs ________________________


C6EF8:	LD	IX,M542F
        JR	J6F08

;	  Subroutine evaluate byte operand
;	     Inputs  ________________________
;	     Outputs ________________________


C6EFE:	LD	IX,M521C
        JR	J6F08

;	  Subroutine free temporary string
;	     Inputs  ________________________
;	     Outputs ________________________


C6F04:	LD	IX,M67D0

;	  Subroutine start MAIN-ROM routine
;	     Inputs  ________________________
;	     Outputs ________________________


J6F08:	LD	IY,(EXPTBL+0-1)
        JP	CALSLT

;	  Subroutine get pointer to stringlength in voicebuffer
;	     Inputs  ________________________
;	     Outputs ________________________


C6F0F:	LD	L,2
        JR	C6F16			; get pointer in voicebuffer

;	  Subroutine get pointer in voicebuffer of current playvoice
;	     Inputs  ________________________
;	     Outputs ________________________


C6F13:	LD	A,(VOICEN)

;	  Subroutine get pointer in voicebuffer
;	     Inputs  ________________________
;	     Outputs ________________________


C6F16:	LD	H,0
        PUSH	DE
        LD	E,A
        LD	A,(D7B22)
        SUB	E
        SUB	4
        JR	C,J6F2F
        LD	A,E
        LD	DE,I7CF0
        ADD	HL,DE
        OR	A
        JR	Z,J6F4E
        LD	DE,39
        JR	J6F4A

J6F2F:	CPL
        EX	AF,AF'
        LD	A,L
        OR	A
        JR	NZ,J6F3F
        EX	AF,AF'
        LD	HL,D7E76
        ADD	A,A
        ADD	A,L
        LD	L,A
        POP	DE
        XOR	A
        RET

J6F3F:	EX	AF,AF'
        LD	DE,VCBA
        ADD	HL,DE
        OR	A
        JR	Z,J6F4E
        LD	DE,37
J6F4A:	ADD	HL,DE
        DEC	A
        JR	NZ,J6F4A
J6F4E:	POP	DE
        RET

;	  Subroutine copy data
;	     Inputs  BC = source start, HL = destination start, DE = source end
;	     Outputs BC = destination end, HL = source end, DE = unchanged

C6F50:	PUSH	BC
        EX	(SP),HL
        POP	BC
J6F53:	CALL	C6FF4			; compare
        LD	A,(HL)
        LD	(BC),A
        RET	Z			; equal, quit
        DEC	BC
        DEC	HL
        JR	J6F53


;	  Subroutine __________________________
;	     Inputs  ________________________
;	     Outputs ________________________


C6F5D:	LD	E,(HL)
        INC	HL
        LD	D,(HL)
        INC	HL
        LD	C,(HL)
        INC	HL
        LD	B,(HL)
        INC	HL
        RET

;	  Subroutine start dequeueing
;	     Inputs  ________________________
;	     Outputs ________________________


C6F66:	DI
        LD	HL,(D7B26)
        LD	A,L
        OR	H			; any playvoice active ?
        RET	NZ			; yep, quit
        LD	HL,PLYCNT
        OR	(HL)
        JR	Z,J6F90
        DEC	(HL)
        LD	HL,-1
        LD	(VCBA+0),HL
        LD	(VCBB+0),HL
        LD	(VCBC+0),HL
        INC	HL
        INC	HL
        LD	(D7E76),HL		; duration PSG playvoice 0 = 1
        LD	(D7E78),HL		; duration PSG playvoice 1 = 1
        LD	(D7E7A),HL		; duration PSG playvoice 2 = 1
        LD	A,87H
        LD	(MUSICF),A
J6F90:	LD	HL,D7B28
        LD	A,(HL)
        OR	A			; something queued ?
        RET	Z			; nope, quit
        DEC	(HL)
        LD	A,(D7B23)
        OR	A			; no AUDIO playvoices ?
        JR	Z,J6FAD			; yep, skip
        LD	B,A
        LD	HL,I7CF0
        LD	DE,39
J6FA4:	LD	(HL),LOW 1
        INC	HL
        LD	(HL),HIGH 1		; duration AUDIO playvoice = 1
        DEC	HL
        ADD	HL,DE
        DJNZ	J6FA4
J6FAD:	LD	HL,(D7B20)		; playvoice mask
        LD	(D7B26),HL		; all playvoices active
        RET

;	  Subroutine check for stackspace
;	     Inputs  C = number of words
;	     Outputs ________________________


C6FB4:	PUSH	HL
        LD	HL,(STREND)
        LD	B,00H
        ADD	HL,BC
        ADD	HL,BC
        LD	A,0E5H			; UNUSED entrypoint
        LD	A,88H
        SUB	L
        LD	L,A
        LD	A,0FFH
        SBC	A,H
        LD	H,A
        JR	C,J6FCB
        ADD	HL,SP
        POP	HL
        RET	C
J6FCB:	JP	J6EB4


;	  Subroutine __________________________
;	     Inputs  ________________________
;	     Outputs ________________________


C6FCE:	CP	"{"
        RET	Z
        CP	"}"
        RET	Z
        CP	">"
        RET	Z
        CP	"<"
        RET	Z
        CP	"&"
        RET	Z
        CP	"@"
        RET	C
        CP	"Z"+1
        CCF
        RET

;	  Subroutine (UNUSED)
;	     Inputs  ________________________
;	     Outputs ________________________


?6FE4:	LD	A,(VALTYP)
        CP	8
        JR	NC,J6FF0
        SUB	3
        OR	A
        SCF
        RET

J6FF0:	SUB	3
        OR	A
        RET

;	  Subroutine compare
;	     Inputs  HL = value1, DE = value2
;	     Outputs ________________________


C6FF4:	LD	A,H
        SUB	D
        RET	NZ
        LD	A,L
        SUB	E
        RET

        DEFS	08000H-$,0

        END
