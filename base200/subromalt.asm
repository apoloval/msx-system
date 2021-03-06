

        .Z80
        ASEG
        ORG	0000H

        INCLUDE	MSX.INC

YFAF7	EQU	0FAF7H		; backup superimpose I/O port 0F7
YFAF8	EQU	0FAF8H		; slotid subrom
YFAF9	EQU	0FAF9H		; kanji
YFAFA	EQU	0FAFAH		; kanji
YFAFB	EQU	0FAFBH		; kanji
YFAFC	EQU	0FAFCH		; flags (VRAM size etc)
YFAFD	equ	0FAFDH		; ** reserved
YFAFE	EQU	0FAFEH		; X coord lightpen/mouse
YFAFF	EQU	0FAFFH		; X border skip lightpen
YFB00	EQU	0FB00H		; Y coord lightpen/mouse
YFB01	EQU	0FB01H		; Y border skip lightpen

YFD09	equ	0FD09H		; ramdisk flags/slotid

YFFF7	EQU	0FFF7H		; slotid MAIN-ROM
YFFF8	EQU	0FFF8H		; backup ? hardware (not supported)

; SUBROM id
        DB	"CD"
; INIT
        DW	A0336
; STATEMENT
        DW	A1649
; DEVICE
        DW	A372A
; SYNCHR
        jp	A1D32

        DS	1,0
; RDSLT (not in orginal SUBROM)
        jp	A01FD

        DS	1,0
; CHRGTR
        jp	A1D3A

        DS	1,0
; WRSLT
        jp	A0218

        DS	1,0
; OUTDO
        jp	A0577

        DS	1,0
; CALSLT MAINROM (0000-7FFF)
        jp	A0262

        DS	1,0
; DCOMPR
        ld	A,H
        sub	D
        ret	NZ
        ld	A,L
        sub	E
        ret

        DS	2,0
; EVLBYT (evaluate byte operand)
        jp	A060E

        DS	5,0
; CALLF MAINROM (0000-3FFF)
        jp	A0246

        DS	5,0
; KEYINT
        ex	af,AF'
        exx
        push	af
        push	bc
        push	de
        push	hl
        ex	af,AF'
        exx
        push	ix
        push	iy
        ld	ix,KEYINT
        ld	iy,(EXPTBL+0-1)
        call	A0258
        pop	iy
        pop	ix
        ex	af,AF'
        exx
        pop	hl
        pop	de
        pop	bc
        pop	af
        ex	af,AF'
        exx
        ei
        reti

        DS	8,0
; NMI
        jp	H.NMI

; PAINT
        ei
        jp	A2651
; PSET
        ei
        jp	A2556
; ATRSCN
        ei
        jp	A256F
; GLINE
        ei
        jp	A2607
; DOBOSF
        ei
        jp	A262A
; DOLINE
        ei
        jp	A263F
; BOXLIN
        ei
        jp	A2648
; DOGRPH
        ei
        jp	A2823
; GRPPRT
        ei
        jp	A110E
; SCALXY
        ei
        jp	A12C4
; MAPXYC
        ei
        jp	A1342
; READC
        ei
        jp	A1384
; SETATR
        ei
        jp	A13AD
; SETC
        ei
        jp	A13B5
; TRIGHT
        ei
        jp	A1426
; RIGHTC
        ei
        jp	A1439
; TLEFTC
        ei
        jp	A13E7
; LEFTC
        ei
        jp	A144B
; TDOWNC
        ei
        jp	A13FC
; DOWNC
        ei
        jp	A148C
; TUPC
        ei
        jp	A1414
; UPC
        ei
        jp	A1498
; SCANR
        ei
        jp	A14DB
; SCANL
        ei
        jp	A158F
; NVBXLN
        ei
        jp	A27E7
; NVBXFL
        ei
        jp	A2898
; CHGMOD
        ei
        jp	A09C3
; INITXT
        ei
        jp	A09E5
; INIT32
        ei
        jp	A0A1A
; INIGRP
        ei
        jp	A0A48
; INIMLT
        ei
        jp	A0A98
; SETTXT
        ei
        jp	A0B42
; SETT32
        ei
        jp	A0B9C
; SETGRP
        ei
        jp	A0BD2
; SETMLT
        ei
        jp	A0C22
; CLRSPR
        ei
        jp	A06F5
; CALPAT
        ei
        jp	A0755
; CALATR
        ei
        jp	A076A
; GSPSIZ
        ei
        jp	A077F
; GETPAT
        ei
        jp	A07D9
; WRTVRM
        ei
        jp	A08CB
; RDVRM
        ei
        jp	A08D6
; CHGCLR
        ei
        jp	A0953
; CLS
        ei
        jp	A07FE
; CLRTXT
        ei
        jp	A0864
; DSPFNK
        ei
        jp	A0D52
; DELLNO
        ei
        jp	A0E0F
; INSLNO
        ei
        jp	A0E5D
; PUTVRM
        ei
        jp	A0F16
; WRTVDP
        ei
        jp	A0647
; VDPSTA
        ei
        jp	A298B
; KYKKLOK (used only with japanese)
        ret
        ret
        ret
        ret
; PUTCHR (used only with japanese)
        ret
        ret
        ret
        ret
; SETPAG
        ei
        jp	A06A8
; INIPLT
        ei
        jp	A0F9F
; RSTPLT
        ei
        jp	A0F7E
; GETPLT
        ei
        jp	A0F6A
; SETPLT
        ei
        jp	A0FD3
; PUTSPR
        ei
        jp	A208F
; COLOR
        ei
        jp	A1DF6
; SCREEN
        ei
        jp	A1EE5
; WIDTHS
        ei
        jp	A1FDF
; VDP
        ei
        jp	A21C6
; VDPF
        ei
        jp	A21E5
; BASE
        ei
        jp	A2220
; BASEF
        ei
        jp	A2297
; VPOKE
        ei
        jp	A22F4
; VPEEK
        ei
        jp	A2307
; SETS
        ei
        jp	A1833
; BEEP
        ei
        jp	A1A62
; PROMPT
        ei
        jp	A1B4E
; SDFSCR
        ei
        jp	A0480
; SETSCR
        ei
        jp	A0470
; SCOPY
        ei
        jp	A2342
; BLTVV
        ei
        jp	A2EB9
; BLTVM
        ei
        jp	A2F42
; BLTMV
        ei
        jp	A2EDF
; BLTVD
        ei
        jp	A30A8
; BLTDV
        ei
        jp	A31B4
; BLTMD
        ei
        jp	A306F
; BLTDM
        ei
        jp	A307C
; NEWPAD
        ei
        jp	A34DD
; GETPUT
        ei
        jp	A1683
; CHGMDP
        ei
        jp	A09BF
; RESVI (reserve entry)
        ei
        jp	0
; KNJPRT
        ei
        jp	A1049

; Some piece of dirty code, same code in mainrom
; therefor code works. This code MUST run at 001C1H!!
;
A01C1:	ld	A,B
        and	03FH
        out	(0A8H),A	; page 3 = slot 0
        ld	A,(0FFFFH)
        cpl
        ld	C,A		; cur. sec. slotreg
        and	D
        ld	E,A
        ld	(0FFFFH),A	; new setting
        ld	A,B
        and	D
        out	(0A8H),A
        ld	A,E
        ld	(SLTTBL+0),A	; adjust SLTTBL
        push	bc
        exx
        ex	af,AF'
        call	CLPRIM+12	; call IX
        di
        ex	AF,AF'
        exx
        pop	bc
        ld	A,B
        and	03FH
        out	(0A8H),A
        ld	A,C
        ld	(0FFFFH),A	; restore
        ld	A,B
        out	(0A8H),A	; restore
        ld	A,C
        ld	(SLTTBL+0),A
        ex	AF,AF'
        exx
        ret
; REDCLK
        ei
        jp	A1D08
; WRTCLK
        ei
        jp	A1D10
;
A01FD:	call	A02DD
        jp	M,A020D
        in	A,(0A8H)
        ld	D,A
        and	C
        or	B
        call	RDPRIM
        ld	A,E
        ret
;
A020D:	push	hl
        call	A0302
        ex	(SP),HL
        push	bc
        call	A01FD
        jr	A0233
;
A0218:	push	de
        call	A02DD
        jp	M,A0228
        pop	de
        in	A,(0A8H)
        ld	D,A
        and	C
        or	B
        jp	WRPRIM
;
A0228:	ex	(SP),HL
        push	hl
        call	A0302
        pop	de
        ex	(SP),HL
        push	bc
        call	A0218
A0233:	pop	bc
        ex	(SP),HL
        push	af
        ld	A,B
        and	03FH
        or	C
        out	(0A8H),A
        ld	A,L
        ld	(0FFFFH),A
        ld	A,B
        out	(0A8H),A
        pop	af
        pop	hl
        ret
;
A0246:	ex	(SP),HL
        push	af
        push	de
        ld	A,(HL)
        push	af
        pop	iy
        inc	HL
        ld	E,(HL)
        inc	HL
        ld	D,(HL)
        inc	HL
        push	de
        pop	ix
        pop	de
        pop	af
        ex	(SP),HL
A0258:	exx
        ld	D,0FCH		; MAINROM on page 0
        jr	A0265
;
A025D:	exx
        ld	D,0F3H		; MAINROM on page 1
        jr	A0265
;
A0262:	exx
        ld	D,0F0H		; MAINROM on page 0 & 1
A0265:	ex	AF,AF'
        di
        ld	A,(EXPTBL+0)
        and	A		; slot 0 expanded ?
        in	A,(0A8H)
        jp	M,A0276 	; yep, handle carefull
        push	af
        and	D
        exx
        jp	CLPRIM
;
A0276:	ld	B,A
        ld	A,(YFAF8)	; slotid SUBROM
        and	003H		; also in slot 0 ?
        jr	NZ,A0284	; nop, easy
        ld	A,D
        cp	0F3H		; only page 1 MAINROM ?
        jp	NZ,A01C1	; nop, use dirty trick
A0284:	ld	A,B
        and	03FH
        out	(0A8H),A
        ld	A,(0FFFFH)
        cpl
        ld	C,A
        and	D
        ld	(0FFFFH),A
        ld	E,A
        ld	A,B
        out	(0A8H),A
        ld	A,E
        ld	(SLTTBL+0),A
        ld	A,B
        push	bc
        ld	hl,A02A6
        push	hl
        push	af
        and	D
        exx
        jp	CLPRIM
;
A02A6:	di
        exx
        ex	AF,AF'
        pop	bc
        ld	A,B
        and	03FH
        out	(0A8H),A
        ld	A,C
        ld	(0FFFFH),A
        ld	A,B
        out	(0A8H),A
        ld	A,C
        ld	(SLTTBL+0),A
        ex	AF,AF'
        exx
        ret
;
A02BD:	call	A02DD
        jp	M,A02CA
        in	A,(0A8H)
        and	C
        or	B
        out	(0A8H),A
        ret
;
A02CA:	push	hl
        call	A0302
        ld	C,A
        ld	B,000H
        ld	A,L
        and	H
        or	D
        ld	hl,SLTTBL
        add	HL,BC
        ld	(HL),A
        pop	hl
        ld	A,C
        jr	A02BD
;
A02DD:	di
        push	af
        ld	A,H
        RLCA
        RLCA
        and	003H
        ld	E,A
        ld	A,0C0H
A02E7:	RLCA
        RLCA
        dec	E
        jp	P,A02E7
        ld	E,A
        cpl
        ld	C,A
        pop	af
        push	af
        and	003H
        inc	A
        ld	B,A
        ld	A,0ABH
A02F8:	add	A,055H
        djnz	A02F8
        ld	D,A
        and	E
        ld	B,A
        pop	af
        and	A
        ret
;
A0302:	push	af
        ld	A,D
        and	0C0H
        ld	C,A
        pop	af
        push	af
        ld	D,A
        in	A,(0A8H)
        ld	B,A
        and	03FH
        or	C
        out	(0A8H),A
        ld	A,D
        RRCA
        RRCA
        and	003H
        ld	D,A
        ld	A,0ABH
A031A:	add	A,055H
        dec	D
        jp	P,A031A
        and	E
        ld	D,A
        ld	A,E
        cpl
        ld	H,A
        ld	A,(0FFFFH)
        cpl
        ld	L,A
        and	H
        or	D
        ld	(0FFFFH),A
        ld	A,B
        out	(0A8H),A
        pop	af
        and	003H
        ret
;
A0336:	ld	hl,T29F6
        ld	de,RG0SAV
        ld	bc,00008H
        ldir
        ld	de,RG8SAV
        ld	bc,00010H
        ldir			; Init backup of VDP register 0-23
        xor	A
        ld	(DPPAGE),A
        ld	(ACPAGE),A	; active & display page 0
        call	A0512
        ld	(YFAF8),A	; Slotid of this ROM
        ld	H,A
        ld	L,0F7H
        ld	(H.ERRP+0),HL
        ld	hl,A3D9C
        ld	(H.ERRP+2),HL	; init errorhandler
        ld	A,(EXPTBL+0)
        ld	(YFFF7),A	; slotid mainrom ?
        ld	A,02CH
        ld	(YFAFF),A
        ld	A,026H
        ld	(YFB01),A	; init lightpen borderskip
        ld	A,0D3H
        out	(0F7H),A

; The following instruction was:
; call	A3CC3

        ld	(YFAF7),A	; init superimpose hardware
        xor	A
        ld	C,0FFH		; enable all internal hardware
        out	(0D8H),A
        ld	A,002H
        out	(0D9H),A
        ld	hl,T050A
        ld	B,008H
A0387:	in	A,(0D9H)
        cp	(HL)
        jr	NZ,A0391
        inc	HL
        djnz	A0387
        RES	0,C		; there is a JIS-1 ROM, use external
A0391:	in	A,(0C0H)
        cp	0FFH
        jr	Z,A0399
        RES	2,C		; there is a MSX AUDIO, use external
A0399:	in	A,(0F7H)
        and	077H
        cp	077H
        jr	Z,A03A3
        RES	3,C		; there is superimpose, use external
A03A3:	in	A,(0C8H)
        cp	0FFH
        jr	Z,A03AB
        RES	4,C		; there is MSX-MOTOR, use external
A03AB:	xor	A
        out	(081H),A
        push	af
        pop	af
        out	(081H),A
        push	af
        pop	af
        out	(081H),A
        push	af
        pop	af
        ld	A,040H
        out	(081H),A
        ex	(SP),HL
        ex	(SP),HL
        in	A,(081H)
T03C0:	and	03FH
        cp	005H
        jr	NZ,A03C8
        RES	5,C		; there is a MSX serial, use external
A03C8:	in	A,(0BBH)
        cp	0FFH
        jr	Z,A03D0
        RES	6,C		; there is a Lightpen, use external
A03D0:	ld	A,C
        out	(0F5H),A	; enable internal hardware
        call	A1CF7		; bank 2 clockchip
        ld	B,000H
        call	A1CD2		; read #0 clockchip
        cp	00AH
        jr	Z,A03E2 	; validation nibble OK
A03DF:	call	A0431		; init startupdata
A03E2:	call	A1CF7		; bank 2 clockchip
        ld	B,003H
        call	A1CD2		; read #3 clockchip
        and	001H
        push	af
        call	A1CDB		; read #4 & #5 clockchip
        pop	bc
        cp	051H
        jp	NC,A03DF	; width >80, init
        or	A
        jp	Z,A03DF 	; width =0, init
        dec	B
        jr	NZ,A0402
        cp	021H
T03FF:	jp	NC,A03DF	; width>32 screen 1, init
A0402:	call	A1CF7		; bank 2 clockchip
        ld	B,001H
        call	A1CD2		; read #1 clockchip
        ld	D,A
        call	A1CD2		; read #2 clockchip
        ld	E,A
        call	A17F8		; init adjust
        call	A2A0E		; MSX startscreen
        ld	B,002H
        ld	hl,00000H
A041A:	dec	HL
        ld	A,L
        or	H
        jr	NZ,A041A
        djnz	A041A		; wait!
        call	A063C		; display off
        xor	A
        ld	bc,04000H
        call	A0977		; clear VRAM 00000-03FFFh
        call	A0A1A		; INIT32
        jp	A0F9F		; INIPLT

;
; The following instruction was:
; ld	HL,T3CEC


A0431:	ld	hl,T04FF
        ld	C,002H
A0436:	ld	B,00DH
        ld	A,004H
        sub	C
        call	A1A59		; select bank
A043E:	ld	B,00DH
A0440:	ld	A,00DH
        sub	B
        out	(0B4H),A
        ld	A,(HL)
        inc	HL
        cp	0FFH
        jr	NZ,A044D
        dec	HL
        xor	A
A044D:	out	(0B5H),A
        djnz	A0440
        dec	C
        jr	NZ,A0436
        ld	B,00DH
        ld	A,008H
        call	A1A59		; select bank 0,
        xor	A
        call	A1A59		; write #14 clockchip
        ld	A,00DH
        call	A1A59		; write #15 clockchip
        ld	A,001H
        call	A1CF9		; bank 1 clockchip
        ld	B,00AH
        ld	A,001H
        jp	A1A59		; write #10 clockchip
;
A0470:	SCF
        call	A0481
        ld	hl,07EF2H	; MSX BASIC
        call	A05F6		; print string
        ld	hl,07EE4H	; version 2.0
        jp	A05F6		; print string
;
A0480:	xor	A
A0481:	push	af
        call	A1CF7		; bank 2 clockchip
        ld	B,003H
        call	A1CD2		; read #3 clockchip
        ld	C,A
        and	001H
        pop	de
        push	af		; b0 -> screenmode
        push	de
        push	bc
        ld	A,C
        RLCA
        RLCA
        and	008H		; b1 -> interlace
        ld	C,A
        ld	A,(RG9SAV)
        and	0F7H
        or	C
        ld	B,A
        ld	C,009H		; reg 9
        call	A0647		; WRTVDP
        pop	bc
        call	A1CDB		; read #4 & #5 clockchip
        ld	E,A
        pop	af
        push	de
        push	af
        call	A1CD2		; read #6 clockchip
        ld	(FORCLR),A
        ld	(ATRBYT),A
        call	A1CD2		; read #7 clockchip
        ld	(BAKCLR),A
        call	A1CD2		; read #8 clockchip
        ld	(BDRCLR),A
        call	A1CD2		; read #9 clockchip
        ld	C,A
        RRC	C
        sbc	A,A		; b0-> functionkeys
        ld	B,A
        pop	af
        jr	NC,A04CC	; NC, no functionkeys
        ld	A,B
A04CC:	ld	(CNSDFG),A
        RRC	C
        sbc	A,A		; b1-> keyclick
        ld	(CLIKSW),A
        RRC	C		; b2-> 1200/2400 baud
        push	bc
        ld	bc,00005H
        ld	hl,CS1200
        jr	NC,A04E3
        ld	hl,CS2400
A04E3:	ld	de,LOW
        ldir
        pop	bc
        RRC	C
        sbc	A,A		; b3-> msx printer
        ld	(NTMSXP),A
        pop	de
        pop	af
        ld	(OLDSCR),A
        ld	(SCRMOD),A
        push	de
        call	A09BF		; CHGMDP
        pop	de
        jp	A1FFF		; set screenwidth


;
; The following table was not used in european rom's.
; Strange enough a new table was added at A3CEC.
;
; Because PUTCHR must be compatible, this table is now used

T04FF:	DB	00AH		; validation identifier
        DB	000H		; adjust x
        DB	000H		; adjust y
        DB	000H		; screen 0, no interlace: was 001H (screen 1)
        DB	005H		; width 37 and  15: was 00DH
        DB	002H		; width 37/16 and 15: was 001H (width 29)
        DB	00FH		;
        DB	004H		;
        DB	004H		; color 15,4,4: was 007H (color,,7)
        DB	003H		; msx printer, 1200 bps, click on, key on
        DB	0FFH

T050A:	DB	000h
        DB	040h
        DB	020h
        DB	010h
        DB	008h
        DB	004h
        DB	002h
        DB	001h

A0512:	push	bc
        push	hl
        in	A,(0A8H)
        and	003H
        ld	C,A
        ld	B,000H
        ld	hl,EXPTBL
A051E:	add	HL,BC
        or	(HL)
        ld	C,A
        inc	HL
        inc	HL
        inc	HL
        inc	HL
        ld	A,(HL)
        and	003H
        RLCA
        RLCA
        or	C
        pop	hl
        pop	bc
        ret
;
A052E:	ld	ix,06E6BH	; Bad file name
        jr	A0562
;
A0534:	ld	ix,06E86H	; Sequential I/O only
        jr	A0562
;
A053A:	ld	ix,06E6EH	; File already open
        jr	A0562
;
A0540:	ld	ix,04055H	; Syntax error
        jr	A0562
;
A0546:	ld	ix,0475AH	; Illegal function call
        jr	A0562
;
A054C:	ld	ix,0406AH	; Missing operand
        jr	A0562
;
A0552:	ld	ix,0406DH	; Type mismatch
        jr	A0562
;
A0558:	ld	ix,06275H	; Out of memory
        jr	A0562
;
A055E:	ld	ix,06E74H	; File not found
A0562:	jp	A0618
;
A0565:	ld	ix,CHGET
        jr	A058D
;
A056B:	ld	ix,GICINI
        jr	A058D
;
A0571:	ld	ix,FNKSB
        jr	A058D
;
A0577:	ld	ix,OUTDO
        jr	A058D
;
A057D:	ld	ix,RDSLT
        jr	A058D
;
A0583:	ld	ix,WRSLT
        jr	A058D
;
A0589:	ld	ix,CKCNTC	; check ctrl-stop
A058D:	jp	A0258		; CALSLT BIOS
;
A0590:	ld	ix,SNSMAT
        jr	A058D
;
A0596:	ld	ix,EOL
        jr	A058D
;
A059C:	ld	ix,0579CH	; evaluate graphic pair
        jr	A0618
;
A05A2:	ld	ix,057ABH	; evaluate sec graphic pair
        jr	A0618
;
A05A8:	ld	ix,07328H	; newline OUTDO
        jr	A0618
;
A05AE:	ld	ix,07323H	; nextline OUTDO
        jr	A0618
;
A05B4:	ld	ix,05439H	; evaluate adres operand
        jr	A0618
;
A05BA:	ld	ix,06A0EH	; evaluate filespec
        jr	A0618
;
A05C0:	ld	ix,06B24H	; close I/O channel
        jr	A0618
;
A05C6:	ld	ix,0406FH	; error
        jr	A0618
;
A05CC:	ld	ix,03412H	; print integer
        jr	A0618
;
A05D2:	ld	ix,03058H	; check string
        jr	A0618
;
A05D8:	ld	ix,05EA4H	; eval & search variable
        jr	A0618
;
A05DE:	ld	ix,03236H	;
        jr	A0618
;
A05E4:	ld	ix,04FCFH	;
        jr	A0618
;
A05EA:	ld	ix,06627H	; alloc stringspace with descriptor
        jr	A0618
;
A05F0:	ld	ix,02F92H	; convert to integer
        jr	A0618
;
A05F6:	ld	ix,06678H	; print string
        jr	A0618
;
A05FC:	ld	ix,04C64H	; evaluate expression
        jr	A0618
;
A0602:	ld	ix,0542FH	; evaluate adres operand + ,
        jr	A0618
;
A0608:	ld	ix,0520FH	; evaluate integer operand
        jr	A0618
;
A060E:	ld	ix,0521CH	; evaluate byte operand
        jr	A0618
;
A0614:	ld	ix,067D0H	; free temp string
A0618:	call	A0262		; CALSLT MAINROM
        ei
        ret
;
A061D:	ld	(CNSDFG),A
A0620:	ld	A,(SCRMOD)
        cp	002H
        ret
;
A0626:	ld	A,(SCRMOD)
        cp	004H
        ret
;
A062C:	ld	A,(SCRMOD)
        cp	005H
        ret
;
A0632:	call	A1034		; wait for VR
        ld	A,(RG1SAV)
        or	060H
        jr	A0644
;
A063C:	call	A1034		; wait for VR
        ld	A,(RG1SAV)
        and	03FH
A0644:	ld	B,A
        ld	C,001H		; reg 1, WRTVDP

A0647:	ld	A,I
        push	af
        push	hl
        ld	A,C
        and	A
        jr	NZ,A0680
        ld	A,B
        ld	hl,RG0SAV
        xor	(HL)
        and	001H
        jr	Z,A0680
        ld	hl,RG9SAV
        ld	A,(HL)
        and	0CFH
        ld	(HL),A
        ld	A,B
        and	001H
        RRCA
        RRCA
        RRCA
        RRCA
        or	(HL)
        push	bc
        ld	B,A
        ld	C,009H
        ld	hl,YFAF7
        ld	A,(HL)
        and	03FH
        ld	(HL),A
        ld	A,B
        RLCA
        RLCA
        cpl
        and	0C0H
        or	(HL)
        out	(0F7H),A
        ld	(HL),A
        call	A0647		; WRTVDP
        pop	bc
A0680:	ld	A,B
        di
        out	(099H),A
        ld	A,C
        or	080H
        out	(099H),A
        push	bc
        push	de
        ld	D,B
        ld	A,C
        ld	B,000H
        cp	008H
        jr	NC,A0698
        ld	hl,RG0SAV
        jr	A069F
;
A0698:	cp	018H
        jr	NC,A06A1
        ld	hl,RG8SAV-008H
A069F:	add	HL,BC
        ld	(HL),D
A06A1:	pop	de
        pop	bc
        pop	hl
        pop	af
        ret	PO
        ei
        ret
;
A06A8:	ld	A,(SCRMOD)
        push	af
        push	bc
        push	de
        push	hl
        di
        ld	hl,T06B8
        call	A09C9
        jr	A06F0
;
T06B8:	DW	A0B42		; SETTXT
        DW	A0B9C		; SETT32
        DW	A0BD2		; SETGRP
        DW	A0C22		; SETMLT
        DW	A0BD9
        DW	A0C56
        DW	A0C80
        DW	A0C97
        DW	A0CC7

A06CA:	push	af
        push	bc
        push	de
        push	hl
        di
        xor	A
        out	(099H),A
        ld	A,091H
        out	(099H),A
        call	A1034		; wait for VR
        ld	hl,RG0SAV
        ld	B,008H
A06DE:	ld	A,(HL)
        inc	HL
        out	(09BH),A
        djnz	A06DE
        ld	hl,RG8SAV
        ld	B,010H
A06E9:	ld	A,(HL)
        inc	HL
        out	(09BH),A
        djnz	A06E9
        ei
A06F0:	pop	hl
        pop	de
        pop	bc
        pop	af
        ret
;
A06F5:	call	A0701
        push	hl
        ld	hl,00000H
        call	A08E3
        pop	hl
        ret
;
A0701:	ld	A,(RG1SAV)
        ld	B,A
T0705:	ld	C,001H		; reg 1
        call	A0647		; WRTVDP
        ld	hl,(PATBAS)
        ld	bc,00800H
        xor	A
        call	A0977		; clear VRAM
A0714:	ld	A,(FORCLR)
        ld	E,A
        ld	hl,(ATRBAS)
        ld	bc,02000H
A071E:	call	A0626		; chkohw
        ld	A,209
        jr	C,A0727 	; 192 lines screen
        ld	A,217
A0727:	call	A08CB		; WRTVRM
        inc	HL
        inc	HL
        ld	A,C
        call	A08CB		; WRTVRM
        inc	HL
        inc	C
D0732:	ld	A,(RG1SAV)
        RRCA
        RRCA
        jr	NC,A073C
        inc	C
        inc	C
        inc	C
A073C:	ld	A,E
        call	A08CB		; WRTVRM
        inc	HL
        djnz	A071E
        call	A0626		; chkohw
        ret	C		; msx1 screen, quit
        ld	hl,(ATRBAS)
        ld	bc,00200H
        sbc	HL,BC
        ld	A,(FORCLR)
        jp	A0977		; init VRAM
;
A0755:	ld	L,A
        ld	H,000H
        add	HL,HL
        add	HL,HL
        add	HL,HL
        call	A077F		; GSPSIZ
        cp	008H
        jr	Z,A0764
        add	HL,HL
        add	HL,HL
A0764:	ex	DE,HL
        ld	hl,(PATBAS)
        add	HL,DE
        ret
;
A076A:	ld	L,A
        ld	H,000H
        add	HL,HL
        add	HL,HL
        ex	DE,HL
        ld	hl,(ATRBAS)
        add	HL,DE
        ret
;
A0775:	add	A,A
        add	A,A
T0777:	call	A076A		; CALATR
        ld	de,0FE00H
        add	HL,DE
        ret
;
A077F:	ld	A,(RG1SAV)
        RRCA
        RRCA
        ld	A,008H
        ret	NC
        ld	A,020H
        ret
;
A078A:	call	H.INIP
        ld	hl,(CGPBAS)
        call	A08E3
        ld	A,(CGPNT+0)
        ld	hl,(CGPNT+1)
        ld	bc,00800H
        push	af
A079D:	pop	af
        push	af
        push	bc
        di
        call	A01FD		; RDSLT
        ei
        pop	bc
        out	(098H),A
        inc	HL
        dec	BC
        ld	A,C
        or	B
        jr	NZ,A079D
        pop	af
        ret
;
; >> NO EXECUTION PATH TO HERE <<
        call	A08F1
        ld	A,C
        or	A
        ld	A,B
        ld	B,C
        ld	C,098H
        ex	DE,HL
        jr	Z,A07BD
        inc	A
A07BD:	INIR
        dec	A
        jr	NZ,A07BD
        ex	DE,HL
        ret
;
; >> NO EXECUTION PATH TO HERE <<
        ex	DE,HL
        call	A08E3
        ex	DE,HL
        ld	A,C
        or	A
        ld	A,B
        ld	B,C
        ld	C,098H
        jr	Z,A07D2
        inc	A
A07D2:	otir
        dec	A
        jr	NZ,A07D2
        ex	DE,HL
        ret
;
A07D9:	ld	H,000H
        ld	L,A
        add	HL,HL
        add	HL,HL
        add	HL,HL
        ex	DE,HL
        ld	hl,(CGPNT+1)
        add	HL,DE
        ld	de,PATWRK
        ld	B,008H
        ld	A,(CGPNT+0)
A07EC:	push	af
        push	hl
        push	de
        push	bc
        call	A01FD		; RDSLT
        ei
        pop	bc
        pop	de
        pop	hl
        ld	(DE),A
        inc	DE
        inc	HL
        pop	af
        djnz	A07EC
        ret
;
A07FE:	call	A0626		; chkohw
        jp	Z,A0895 	; screen 4
        jr	NC,A0811	; use fast command
        call	A0620		; chkgrp
        jp	Z,A0895 	; screen 2
        jp	NC,A08AD	; screen 3
        jr	A0864		; CLRTXT
;
A0811:	push	af
        push	bc
        push	de
        push	hl
        call	A2980		; wait _CE
        ld	A,(BAKCLR)
        call	A084B
T081E:	call	A29EB		; write VDP reg 44
        xor	A
        ld	H,A
        ld	L,A
        call	A29A5		; write VDP DX & DY
        xor	A
        call	A29DB		; write VDP reg 45
        ld	A,(SCRMOD)
        and	002H
        ld	de,256
        jr	Z,A0838
        ld	de,512
A0838:	ld	hl,212
        call	A29C4		; write VDP NX & NY
        ld	A,0C0H		; VDP->VRAM byte
        call	A29E3		; write VDP reg 46
        call	A2980		; wait _CE
        pop	hl
        pop	de
        pop	bc
        pop	af
        ret
;
A084B:	ld	B,A
        ld	A,(SCRMOD)
        cp	008H
        ld	A,B
        ret	Z
        RLCA
        RLCA
        RLCA
        RLCA
        or	B
        ld	B,A
        ld	A,(SCRMOD)
        cp	006H
        ld	A,B
        ret	NZ
        RRCA
        RRCA
        or	B
        ret
;
A0864:	ld	A,(SCRMOD)
        and	A
        ld	hl,(NAMBAS)
        jr	NZ,A087E
        ld	A,(LINLEN)
        cp	029H
        jr	NC,A0879
        ld	bc,003C0H
        jr	A0881
;
A0879:	ld	bc,00780H
        jr	A0881
;
A087E:	ld	bc,00300H
A0881:	ld	A,020H
        call	A0977		; init VRAM
        call	A08C1
        ld	hl,LINTTB
        ld	B,018H
A088E:	ld	(HL),B
        inc	HL
        djnz	A088E
        jp	A0571		; FNKSB (show fkeys)
;
A0895:	call	A099C
        ld	bc,01800H
        push	bc
        ld	hl,(GRPCOL)
        ld	A,(BAKCLR)
        call	A0977		; Init VRAM
        ld	hl,(GRPCGP)
        pop	bc
        xor	A
A08AA:	jp	A0977		; Init VRAM
;
A08AD:	call	A099C
        ld	hl,BAKCLR
        ld	A,(HL)
        add	A,A
        add	A,A
        add	A,A
        add	A,A
        or	(HL)
        ld	hl,(MLTCGP)
        ld	bc,00600H
        jr	A08AA
;
A08C1:	ld	hl,00101H
        ld	(CSRY),HL
        ret
;
; >> NO EXECUTION PATH TO HERE <<
        call	A08DC
A08CB:	push	af
        call	A08E3
        pop	af
        out	(098H),A
        ret
;
A08D3:	call	A08DC
A08D6:	call	A08F1
        in	A,(098H)
        ret
;
A08DC:	push	af
        ld	A,H
        and	03FH
        ld	H,A
        pop	af
        ret
;
A08E3:	push	bc
        push	de
        push	hl
        ex	DE,HL
        call	A0914
        ld	A,H
        and	03FH
        or	040H
        jr	A08FB
;
A08F1:	push	bc
        push	de
        push	hl
        ex	DE,HL
        call	A0914
        ld	A,H
        and	03FH
A08FB:	push	af
        ld	A,H
        and	0C0H
        or	D
        RLCA
        RLCA
        di
        out	(099H),A
        ld	A,08EH
        out	(099H),A
        ld	A,L
        out	(099H),A
        pop	af
        out	(099H),A
        ei
        pop	hl
        pop	de
        pop	bc
        ret
;
A0914:	ld	A,(SCRMOD)
        ld	C,A
        ld	A,(ACPAGE)
        and	A
        ld	hl,T0925
        jp	NZ,A09CA
        ex	DE,HL
        ld	D,A
        ret
;
T0925:	DW	A0937
        DW	A0945
        DW	A0945
        DW	A0945
        DW	A0945
        DW	A0944
        DW	A0944
        DW	A0943
        DW	A0943

A0937:	ld	A,(LINLEN)
        cp	029H
        ld	A,(ACPAGE)
        jr	C,A0947
        jr	A0946
;
A0943:	add	A,A

A0944:	add	A,A

A0945:	add	A,A

A0946:	add	A,A

A0947:	add	A,A
        add	A,A
        add	A,A
        add	A,A
        ld	H,A
        ld	A,000H
        ld	L,A
        adc	A,A
        add	HL,DE
        ld	D,A
        ret
;
A0953:	call	A062C		; chknhw
        jp	NC,A0997	; use fast command
        call	A09A5
        dec	A
        jp	M,A098A
        push	af
        call	A099C
        pop	af
        ret	NZ
        ld	hl,BAKCLR
        ld	A,(FORCLR)
        add	A,A
        add	A,A
        add	A,A
        add	A,A
        or	(HL)
        ld	hl,(T32COL)
        ld	bc,00020H
A0977:	push	af
        call	A08E3
        ld	A,C
        or	A
        jr	Z,A0980
        inc	B
A0980:	pop	af
A0981:	out	(098H),A
        dec	C
        jp	NZ,A0981
        djnz	A0981
        ret
;
A098A:	ld	hl,BAKCLR
        ld	A,(FORCLR)
        add	A,A
        add	A,A
        add	A,A
        add	A,A
        or	(HL)
        jr	A099F
;
A0997:	cp	008H
        call	NZ,A09A5
A099C:	ld	A,(BDRCLR)
A099F:	ld	B,A
        ld	C,007H		; reg 7
        jp	A0647		; WRTVDP
;
A09A5:	push	af
        ld	A,(BAKCLR)
        and	00FH
        ld	(BAKCLR),A
        ld	A,(FORCLR)
        and	00FH
        ld	(FORCLR),A
        pop	af
        ret
;
; >> NO EXECUTION PATH TO HERE <<
        ret	NZ
        push	hl
        call	A07FE		; CLS
        pop	hl
        ret
;
A09BF:	ld	hl,A0F9F
        push	hl		; CHGMOD, then INIPLT

A09C3:	cp	009H
        ret	NC
        ld	hl,T09D3
A09C9:	ld	C,A
A09CA:	ld	B,000H
        add	HL,BC
        add	HL,BC
        ld	C,(HL)
        inc	HL
        ld	H,(HL)
        ld	L,C
        jp	(HL)
;
T09D3:	DW	A09E5		; INITXT
        DW	A0A1A		; INIT32
        DW	A0A48		; INIGRP
        DW	A0A98		; INIMLT
        DW	A0A71
        DW	A0AD6
        DW	A0AE3
        DW	A0AF0
        DW	A0AFD

A09E5:	xor	A
        ld	(OLDSCR),A
        call	A0B22
        ld	A,(LINL40)
        ld	(LINLEN),A
        ld	hl,00800H
        ld	(TXTCOL),HL
        ld	hl,(TXTNAM)
        ld	(NAMBAS),HL
        ld	hl,(TXTCGP)
        cp	029H
        jr	C,A0A08
        ld	hl,T1000
A0A08:	ld	(CGPBAS),HL
        call	A0B42		; SETTXT
A0A0E:	call	A0953		; CHGCLR
        call	A0864		; CLRTXT
        call	A078A
        jp	A0632		; display on
;
A0A1A:	ld	A,001H
        ld	(OLDSCR),A
        call	A0B22
        ld	A,(LINL32)
        ld	(LINLEN),A
        ld	hl,(T32NAM)
        ld	(NAMBAS),HL
        ld	hl,(T32CGP)
        ld	(CGPBAS),HL
        ld	hl,(T32PAT)
        ld	(PATBAS),HL
        ld	hl,(T32ATR)
        ld	(ATRBAS),HL
        call	A0B9C		; SETT32
        call	A0714
        jr	A0A0E
;
A0A48:	ld	A,002H
        call	A0B22
        ld	hl,(GRPATR)
        call	A0A82
        push	hl
        call	A0BD2		; SETGRP
A0A57:	pop	hl
        call	A08E3
        xor	A
        ld	B,003H
A0A5E:	out	(098H),A
        inc	A
        jr	NZ,A0A5E
        djnz	A0A5E
        call	A0895
A0A68:	call	A0953		; CHGCLR
        call	A0714
        jp	A0632		; display on
;
A0A71:	ld	A,004H
        call	A0B22
        ld	hl,T1E00
        call	A0A82
        push	hl
        call	A0BD9
        jr	A0A57
;
A0A82:	ld	(ATRBAS),HL
        ld	hl,(GRPPAT)
        ld	(PATBAS),HL
        ld	hl,(GRPCGP)
        ld	(CGPBAS),HL
        ld	hl,(GRPNAM)
        ld	(NAMBAS),HL
        ret
;
A0A98:	ld	A,003H
        call	A0B22
        ld	hl,(MLTPAT)
        ld	(PATBAS),HL
        ld	hl,(MLTATR)
        ld	(ATRBAS),HL
        ld	hl,(MLTCGP)
        ld	(CGPBAS),HL
        ld	hl,(MLTNAM)
        ld	(NAMBAS),HL
        push	hl
        call	A0C22		; SETMLT
        pop	hl
        call	A08E3
        ld	de,6
A0AC0:	ld	C,004H
A0AC2:	ld	A,D
        ld	B,020H
A0AC5:	out	(098H),A
        inc	A
        djnz	A0AC5
        dec	C
        jr	NZ,A0AC2
        ld	D,A
        dec	E
        jr	NZ,A0AC0
        call	A08AD
        jr	A0A68
;
A0AD6:	ld	A,005H
        ld	de,07876H
        call	A0B14
        call	A0C56
        jr	A0B08
;
A0AE3:	ld	A,006H
        ld	de,07876H
        call	A0B14
        call	A0C80
        jr	A0B08
;
A0AF0:	ld	A,007H
        ld	de,0F0FAH
        call	A0B14
        call	A0C97
        jr	A0B08
;
A0AFD:	ld	A,008H
        ld	de,0F0FAH
        call	A0B14
        call	A0CC7
A0B08:	call	A0953		; CHGCLR
        call	A0811
        call	A0714
        jp	A0632		; display on
;
A0B14:	ld	L,000H
        ld	H,D
        ld	(PATBAS),HL
        ld	H,E
        ld	(ATRBAS),HL
        ld	H,L
        ld	(NAMBAS),HL
A0B22:	ld	(SCRMOD),A
        xor	A
        ld	(DPPAGE),A
        ld	(ACPAGE),A
        ld	hl,00100H
        ld	(ASPCT1),HL
        ld	(ASPCT2),HL
        call	A2980		; wait _CE
        call	A063C		; display off
        ld	B,000H
        ld	C,017H		; reg 23
        jp	A0647		; WRTVDP
;
A0B42:	call	A0D2D
        ld	A,(LINLEN)
        cp	029H
        ld	B,000H
        jr	C,A0B50
        ld	B,004H
A0B50:	ld	C,010H
        call	A0D3F
        ld	A,(LINLEN)
        cp	029H
        ld	A,(DPPAGE)
        jr	NC,A0B72
        add	A,A
        ld	hl,(TXTCGP)
        ld	B,000H
        call	A0CE6
        add	A,A
        ld	hl,(TXTNAM)
        call	A0CDA
        jp	A06CA
;
A0B72:	ld	A,(DPPAGE)
        push	af
        add	A,A
        add	A,A
        ld	B,000H
        ld	hl,(CGPBAS)
        call	A0CE6
        add	A,A
        ld	B,003H
        ld	hl,(TXTNAM)
        call	A0CDA
        pop	af
        ld	hl,(TXTCOL)
        ld	E,000H
        SRL	A
        RR	E
        ld	D,A
        ld	B,007H
        call	A0CF4
        jp	A06CA
;
A0B9C:	call	A0D2D
        ld	bc,00000H
        call	A0D3F
        ld	A,(DPPAGE)
        ld	C,A
        ld	B,000H
        ld	hl,(T32CGP)
        add	A,A
        add	A,A
        add	A,A
        call	A0CE6
        ld	hl,(T32PAT)
        call	A0D20
        ld	hl,(T32NAM)
        add	A,A
        call	A0CDA
        ld	E,B
        ld	D,C
        ld	hl,(T32COL)
        call	A0CF4
        SRL	D
        RR	E
        ld	hl,(T32ATR)
        jr	A0C1C
;
A0BD2:	xor	A
        push	af
        ld	bc,00200H
        jr	A0BE0
;
A0BD9:	ld	A,003H
        or	A
        push	af
        ld	bc,00400H
A0BE0:	call	A0D3F
        call	A0D2D
        ld	A,(DPPAGE)
        ld	C,A
        ld	B,003H
        ld	hl,(GRPCGP)
        add	A,A
        add	A,A
        add	A,A
        call	A0CE6
        ld	hl,(GRPPAT)
        call	A0D20
        ld	hl,(GRPNAM)
        add	A,A
        ld	B,000H
        call	A0CDA
        ld	E,B
        ld	D,C
        ld	B,07FH
        ld	hl,(GRPCOL)
        call	A0CF4
        SRL	D
        RR	E
        pop	af
        ld	B,A
        ld	hl,(GRPATR)
        jr	Z,A0C1C
        ld	hl,(ATRBAS)
A0C1C:	call	A0D0B
        jp	A06CA
;
A0C22:	call	A0D2D
        ld	bc,00008H
        call	A0D3F
        ld	A,(DPPAGE)
        ld	C,A
        ld	B,000H
        ld	hl,(MLTCGP)
        add	A,A
        add	A,A
        add	A,A
        call	A0CE6
        ld	hl,(MLTPAT)
        call	A0D20
        ld	hl,(MLTNAM)
        add	A,A
        ld	B,000H
        call	A0CDA
        ld	E,B
        ld	D,C
        SRL	D
        RR	E
        ld	B,000H
        ld	hl,(MLTATR)
        jr	A0C1C
;
A0C56:	call	A0D36
        ld	bc,00600H
        call	A0D3F
A0C5F:	ld	A,(DPPAGE)
        ld	C,A
        ld	B,000H
        add	A,A
        add	A,A
        add	A,A
        add	A,A
        call	A0D1D
        ld	hl,(NAMBAS)
        add	A,A
        ld	B,01FH
        call	A0CDA
        ld	D,C
A0C76:	ld	E,000H
        ld	B,003H
        call	A0D08
        jp	A06CA
;
A0C80:	call	A0D36
        ld	bc,00800H
        call	A0D3F
        ld	hl,00200H
        ld	(ASPCT1),HL
        ld	hl,00080H
        ld	(ASPCT2),HL
        jr	A0C5F
;
A0C97:	call	A0D36
        ld	bc,00A00H
        call	A0D3F
        ld	hl,00200H
        ld	(ASPCT1),HL
        ld	hl,00080H
        ld	(ASPCT2),HL
A0CAC:	ld	A,(DPPAGE)
        ld	C,A
        ld	B,000H
        RRCA
        RRCA
        RRCA
        and	0E0H
        call	A0D1D
        ld	hl,(NAMBAS)
        ld	B,01FH
        call	A0CDA
        ld	A,C
        add	A,A
        ld	D,A
        jr	A0C76
;
A0CC7:	call	A0D36
        ld	bc,00E00H
        call	A0D3F
        ld	A,(RG2SAV)
        SRL	A
        ld	(RG2SAV),A
        jr	A0CAC
;
A0CDA:	ld	L,A
        SRL	H
        SRL	H
        add	A,H
        or	B
        ld	(RG2SAV),A
        ld	A,L
        ret
;
A0CE6:	ld	L,A
        SRL	H
        SRL	H
        SRL	H
        add	A,H
        or	B
        ld	(RG4SAV),A
        ld	A,L
        ret
;
A0CF4:	push	af
        xor	A
        add	HL,HL
        adc	A,A
        add	HL,HL
        adc	A,A
        ld	L,H
        ld	H,A
        add	HL,DE
        ld	A,L
        or	B
        ld	(RG3SAV),A
        ld	A,H
        ld	(RG10SAV),A
        pop	af
        ret
;
A0D08:	ld	hl,(ATRBAS)
A0D0B:	push	af
        xor	A
        add	HL,HL
        adc	A,A
        ld	L,H
        ld	H,A
        add	HL,DE
        ld	A,L
        or	B
        ld	(RG5SAV),A
        ld	A,H
        ld	(RG11SAV),A
        pop	af
        ret
;
A0D1D:	ld	hl,(PATBAS)
A0D20:	ld	L,A
        SRL	H
        SRL	H
        SRL	H
        add	A,H
        ld	(RG6SAV),A
        ld	A,L
        ret
;
A0D2D:	ld	A,(RG9SAV)
        and	07FH
        ld	(RG9SAV),A
        ret
;
A0D36:	ld	A,(RG9SAV)
        or	080H
        ld	(RG9SAV),A
        ret
;
A0D3F:	ld	A,(RG0SAV)
        and	0F1H
        or	B
        ld	(RG0SAV),A
        ld	A,(RG1SAV)
        and	0E7H
        or	C
        ld	(RG1SAV),A
        ret
;
A0D52:	ld	A,0FFH
        call	A061D
        ret	NC
        push	hl
        ld	A,(CSRY)
        ld	hl,CRTCNT
        cp	(HL)
        ld	A,00AH
        jr	NZ,A0D65
        RST	018H		; linefeed
A0D65:	ld	A,(NEWKEY+6)
        RRCA
        ld	hl,FNKSTR+0*16
        ld	A,001H
        jr	C,A0D74
        ld	hl,FNKSTR+5*16
        xor	A
A0D74:	ld	(FNKSWI),A
        call	A0DE2
        ld	C,005H
        ld	A,(LINLEN)
        cp	029H
        jr	NC,A0DA2
        call	A0DF0
        jr	C,A0D9A
A0D88:	push	bc
        ld	C,000H
A0D8B:	call	A0DFE
        djnz	A0D8B
        ld	A,010H
        sub	C
        ld	C,A
        add	HL,BC
        inc	DE
        pop	bc
        dec	C
        jr	NZ,A0D88
A0D9A:	ld	hl,(CRTCNT)
        call	A0ED7
        pop	hl
        ret
;
A0DA2:	push	af
        call	A0DF0
        pop	af
        sub	028H
A0DA9:	push	bc
        ld	C,000H
A0DAC:	ex	AF,AF'
        call	A0DFE
        ex	AF,AF'
        dec	A
        call	Z,A0DD2
        djnz	A0DAC
        dec	A
        jr	NZ,A0DBE
        call	A0DD2
        dec	DE
A0DBE:	ex	AF,AF'
        ld	A,010H
        sub	C
        ld	C,A
        add	HL,BC
        ex	AF,AF'
        inc	DE
        pop	bc
        dec	C
        jr	NZ,A0DA9
        ld	hl,(CRTCNT)
        call	A0EF2
        pop	hl
        ret
;
A0DD2:	push	bc
        push	hl
        ld	hl,(CRTCNT)
        call	A0ED8
        call	A0DE2
        pop	hl
        pop	bc
        ld	A,0FFH
        ret
;
A0DE2:	ld	de,LINWRK
        push	de
        ld	B,028H
        ld	A,020H
A0DEA:	ld	(DE),A
        inc	DE
        djnz	A0DEA
        pop	de
        ret
;
A0DF0:	sub	004H
        ret	C
        ld	B,0FFH
A0DF5:	inc	B
        sub	005H
        jr	NC,A0DF5
        ld	A,B
        sub	001H
        ret
;
A0DFE:	ld	A,(HL)
        inc	HL
T0E00:	inc	C
        call	A12A5		; cnvchr
        jr	NC,A0DFE	; MSX prefix, next
        jr	NZ,A0E0C	; MSX char,
        cp	020H
        jr	C,A0E0D 	; control char,
A0E0C:	ld	(DE),A
A0E0D:	inc	DE
        ret
;
A0E0F:	call	A0F00
        sub	L
        ret	C
        jp	Z,A0EA9
        push	hl
        push	af
        ld	C,A
        ld	B,000H
        call	A0F0A
        ld	L,E
        ld	H,D
        inc	HL
        ldir
        ld	hl,FSTPOS
        dec	(HL)
        pop	af
        pop	hl
        push	af
        ld	A,(LINLEN)
        cp	029H
        jr	NC,A0E43
        pop	af
A0E33:	push	af
A0E34:	inc	L
        call	A0EAE
        dec	L
        call	A0ED7
        inc	L
        pop	af
        dec	A
        jr	NZ,A0E33
        jr	A0E5A
;
A0E43:	pop	af
A0E44:	push	af
        inc	L
        call	A0EAF
        dec	L
        call	A0ED8
        inc	L
        call	A0EC8
        dec	L
        call	A0EF2
        inc	L
        pop	af
        dec	A
        jr	NZ,A0E44
A0E5A:	jp	A0EA9
;
A0E5D:	call	A0F00
        ld	H,A
        sub	L
        ret	C
        jp	Z,A0EA9
        ld	L,H
        push	hl
        push	af
        ld	C,A
        ld	B,000H
        call	A0F0A
        ld	L,E
        ld	H,D
        push	hl
        dec	HL
        lddr
        pop	hl
        ld	(HL),H
        pop	af
        pop	hl
        push	af
        ld	A,(LINLEN)
        cp	029H
        jr	NC,A0E92
        pop	af
A0E82:	push	af
        dec	L
        call	A0EAE
        inc	L
        call	A0ED7
        dec	L
        pop	af
        dec	A
        jr	NZ,A0E82
        jr	A0EA9
;
A0E92:	pop	af
A0E93:	push	af
        dec	L
        call	A0EAF
        inc	L
        call	A0ED8
        dec	L
        call	A0EC8
        inc	L
        call	A0EF2
        dec	L
        pop	af
        dec	A
        jr	NZ,A0E93
A0EA9:	ld	H,001H
        jp	A0596		; EOL
;
A0EAE:	db	0F6H
A0EAF:	xor	a
        push	hl
        push	af
        ld	H,001H
        call	A0F35
        pop	af
        ld	A,(LINLEN)
        jr	NZ,A0EBF
        sub	028H
A0EBF:	ld	B,A
A0EC0:	ld	de,LINWRK
        call	A0F22
        pop	hl
        ret
;
A0EC8:	push	hl
        ld	A,(LINLEN)
        sub	028H
        inc	A
        ld	H,A
        call	A0F35
        ld	B,028H
        jr	A0EC0
;
A0ED7:	db	0F6H
A0ED8:	xor	a
        push	hl
        push	af
        ld	H,001H
        call	A0F35
        pop	af
        ld	A,(LINLEN)
        jr	NZ,A0EE8
        sub	028H
A0EE8:	ld	B,A
A0EE9:	ex	DE,HL
        ld	hl,LINWRK
        call	A0F2B
        pop	hl
        ret
;
A0EF2:	push	hl
        ld	A,(LINLEN)
        sub	027H
        ld	H,A
        call	A0F35
        ld	B,028H
        jr	A0EE9
;
A0F00:	ld	A,(CNSDFG)
        push	hl
        ld	hl,CRTCNT
        add	A,(HL)
        pop	hl
        ret
;
A0F0A:	push	hl
        ld	de,LINTTB-1
        ld	H,000H
        add	HL,DE
        ld	A,(HL)
        ex	DE,HL
        pop	hl
        and	A
        ret
;
A0F16:	push	hl
        call	A0F35
        call	A08E3
        ld	A,C
        out	(098H),A
        pop	hl
        ret
;
A0F22:	call	A08F1
        ex	DE,HL
        ld	C,098H
T0F28:	INIR
        ret
;
A0F2B:	ex	DE,HL
        call	A08E3
        ex	DE,HL
        ld	C,098H
        otir
        ret
;
A0F35:	push	bc
        dec	H
        dec	L
        ld	E,H
        ld	H,000H
        ld	D,H
        add	HL,HL
        add	HL,HL
        add	HL,HL
        ld	C,L
        ld	B,H
        add	HL,HL
        add	HL,HL
        ld	A,(SCRMOD)
        and	A
        ld	A,(LINLEN)
        jr	Z,A0F50
        sub	022H
        jr	A0F5D
;
A0F50:	cp	029H
        jr	C,A0F5A
        add	HL,BC
        add	HL,HL
        sub	052H
        jr	A0F5D
;
A0F5A:	add	HL,BC
        sub	02AH
A0F5D:	add	HL,DE
        cpl
        and	A
        RRA
        ld	E,A
        add	HL,DE
        ex	DE,HL
        ld	hl,(NAMBAS)
        add	HL,DE
        pop	bc
        ret
;
A0F6A:	push	hl
        ld	D,A
        call	A0FF9
        call	A08F1
        ex	(SP),HL
        ex	(SP),HL
        in	A,(098H)
        ld	B,A
        nop
        nop
        in	A,(098H)
        ld	C,A
        pop	hl
        ret
;
A0F7E:	push	hl
        ld	D,000H
        call	A0FF9
        call	A08F1
        ld	B,D
        ld	C,010H		; reg 16
        call	A0647		; WRTVDP
        ld	B,010H
A0F8F:	in	A,(098H)
        nop
        out	(09AH),A
        nop
        in	A,(098H)
        nop
        out	(09AH),A
        nop
        djnz	A0F8F
        pop	hl
        ret
;
A0F9F:	push	hl
        ld	hl,T0FB3
        ld	B,010H
        ld	D,000H
A0FA7:	ld	A,(HL)
        inc	HL
        ld	E,(HL)
        inc	HL
        call	A0FD3		; SETPLT
        inc	D
        djnz	A0FA7
        pop	hl
        ret
;
T0FB3:	DB	000h,000h
        DB	000h,000h
        DB	011h,006h
        DB	033h,007h
        DB	017h,001h
        DB	027h,003h
        DB	051h,001h
        DB	027h,006h
        DB	071h,001h
        DB	073h,003h
        DB	061h,006h
        DB	064h,006h
        DB	011h,004h
        DB	065h,002h
        DB	055h,005h
        DB	077h,007h

A0FD3:	push	bc
        push	hl
        ld	B,D
        ld	C,010H		; reg 16
        push	af
        call	A0647		; WRTVDP
        pop	af
        ld	C,09AH
        out	(C),A
        push	af
        pop	af
        out	(C),E
        call	A0FF9
        push	af
        call	A08E3
        ex	(SP),HL
        ex	(SP),HL
        pop	af
        out	(098H),A
        push	af
        pop	af
        ld	A,E
        out	(098H),A
        pop	hl
        pop	bc
        ret
;
A0FF9:	push	af
        ld	A,(SCRMOD)
        ld	hl,T1020
T1000:	push	bc
        inc	A
        ld	C,A
        ld	B,000H
        dec	A
        jr	NZ,A1010
        ld	A,(LINLEN)
        cp	029H
        jr	NC,A1010
        dec	C
A1010:	add	HL,BC
        add	HL,BC
        pop	bc
        ld	A,(HL)
        inc	HL
        ld	H,(HL)
        ld	L,A
        push	de
        ld	E,D
        ld	D,000H
        add	HL,DE
        add	HL,DE
        pop	de
        pop	af
        ret
;
T1020:	DW	00400H
        DW	00F00H
        DW	02020H
        DW	01B80H
        DW	02020H
        DW	01B80H
        DW	07680H
        DW	07680H
        DW	0FA80H
        DW	0FA80H

A1034:	ld	A,2		; reg 2
        call	A298B		; VDPSTA
        and	040H
        jr	NZ,A1034	; wait until VR
A103D:	ld	A,2		; reg 2
        call	A298B		; VDPSTA
        and	040H
        jr	Z,A103D 	; wait until VR passed
A1046:	ret
;
A1047:	pop	af
        ret
;
A1049:	push	af
A104A:	ld	A,B
        cp	021H
        jr	C,A1047
        cp	028H
        jr	C,A105B
        cp	030H
        jr	C,A1047
        cp	050H
        jr	NC,A1047
A105B:	ld	A,C
        cp	021H
        jr	C,A1047
        cp	07FH
        jr	NC,A1047
        pop	af
        push	hl
        push	de
        push	bc
        push	af
        ld	A,C
        sub	020H
        ld	E,A
        ld	D,000H
        ld	A,B
        sub	020H
        ld	L,A
        ld	H,D
        ld	C,L
        ld	B,H
        add	HL,HL
        add	HL,BC
        add	HL,HL
        add	HL,HL
        add	HL,HL
        add	HL,HL
        add	HL,HL
        add	HL,DE
        cp	010H
        jr	C,A1084
        dec	H
        dec	H
A1084:	ld	A,L
        out	(0D8H),A
        add	HL,HL
        add	HL,HL
        ld	A,H
        out	(0D9H),A
        ld	bc,020D9H
        ld	hl,LINWRK
        INIR
        pop	af
        push	af
        and	A
        ld	C,002H
        jr	Z,A10C5
        ld	hl,LINWRK
        ld	E,L
        ld	D,H
        dec	A
        jr	Z,A10A4
        inc	HL
A10A4:	ld	C,002H
A10A6:	ld	B,008H
A10A8:	ld	A,(HL)
        ld	(DE),A
        inc	HL
        inc	HL
        inc	DE
        ld	A,B
        cp	005H
        jr	NZ,A10B8
        push	bc
        ld	bc,00008H
        add	HL,BC
        pop	bc
A10B8:	djnz	A10A8
        push	bc
        ld	bc,0FFF0H
        add	HL,BC
        pop	bc
        dec	C
        jr	NZ,A10A6
        ld	C,001H
A10C5:	ld	hl,(GRPACX)
        push	hl
        ld	hl,(GRPACY)
        push	hl
        ld	de,LINWRK
A10D0:	ld	hl,(GRPACY)
        push	hl
        ld	hl,(GRPACX)
        push	hl
        ld	B,002H
A10DA:	push	bc
        ex	DE,HL
        ld	de,PATWRK
        ld	bc,00008H
        ldir
        push	hl
        call	A112D
        pop	de
        pop	bc
        djnz	A10DA
        pop	hl
        ld	(GRPACX),HL
        pop	hl
        push	bc
        ld	bc,00008H
        add	HL,BC
        pop	bc
        ld	(GRPACY),HL
        dec	C
        jr	NZ,A10D0
        pop	hl
        ld	(GRPACY),HL
        pop	hl
        ld	bc,00010H
        add	HL,BC
        ld	(GRPACX),HL
T1109:	pop	af
        pop	bc
        pop	de
        pop	hl
        ret
;
A110E:	push	hl
        push	de
        push	bc
        push	af
        ld	hl,T1109
        push	hl		; stop here
        call	A12A5		; cnvchr
        ret	NC		; MSX prefix, quit
        jr	NZ,A1124	; MSX char, cont
        cp	00DH
        jp	Z,A1210 	; CR, handle
        cp	020H
        ret	C		; control char, ignore
A1124:	call	A07D9		; GETPAT
T1127:	ld	A,(FORCLR)
        ld	(ATRBYT),A	; color
A112D:	ld	hl,(GRPACY)
        ex	DE,HL
        ld	bc,(GRPACX)
        call	A12C4		; SCALXY
        ret	NC		; out of screen, quit
        call	A1342		; MAPXYC
        ld	de,PATWRK
        call	A2980		; wait _CE
        push	de
        xor	A
        call	A29DB		; write VDP MOD
        call	A1376		; FETCHC
        ld	E,A
        call	A29A5		; write VDP DX & DY
        ld	A,E
        sub	212-8+1
        ld	L,008H
        jr	C,A115A 	; 8 lines
        ld	L,A
        ld	A,007H
        sub	L
        ld	L,A		; only part of lines
A115A:	ld	B,L
        ld	de,8		; 8 dots
        ld	H,D
        call	A29C4		; write VDP NX & NY
        pop	de
        ld	A,(ATRBYT)
        ld	L,A		; color 1 dot
        ld	A,(BAKCLR)
        ld	H,A		; color 0 dot
        ld	A,(DE)
        add	A,A		; dot in Cx
        ld	C,A
        ld	A,H
        jr	NC,A1172
        ld	A,L
A1172:	call	A29EB		; write VDP COL
        ld	A,(LOGOPR)
        and	00FH
        or	0B0H		; CPU->VRAM dot
        call	A29E3		; write VDP CMD
        di
        ld	A,0ACH
        out	(099H),A
        ld	A,091H
        out	(099H),A	; S44 non inc
        ld	A,C
        ld	C,09BH
        di
        jr	A11A3
;
A118E:	di
        ld	A,0ACH
        out	(099H),A
        ld	A,091H
        out	(099H),A
        inc	DE
        ld	A,(DE)
        RLCA
        jr	NC,A11A1
        out	(C),L
        jp	A11A3
;
A11A1:	out	(C),H
A11A3:	RLCA
        jr	NC,A11AB
        out	(C),L
        jp	A11AD
;
A11AB:	out	(C),H
A11AD:	RLCA
        jr	NC,A11B5
        out	(C),L
        jp	A11B7
;
A11B5:	out	(C),H
A11B7:	RLCA
        jr	NC,A11BF
        out	(C),L
        jp	A11C1
;
A11BF:	out	(C),H
A11C1:	RLCA
        jr	NC,A11C9
        out	(C),L
        jp	A11CB
;
A11C9:	out	(C),H
A11CB:	RLCA
        jr	NC,A11D3
        out	(C),L
        jp	A11D5
;
A11D3:	out	(C),H
A11D5:	RLCA
        jr	NC,A11DD
        out	(C),L
        jp	A11DF
;
A11DD:	out	(C),H
A11DF:	RLCA
        jr	NC,A11E7
        out	(C),L
        jp	A11E9
;
A11E7:	out	(C),H
A11E9:	ei
        djnz	A118E		; next line
        ld	A,(SCRMOD)
        and	0FEH
        cp	006H
        jr	Z,A1200 	; 512 res, adjust
        ld	A,(GRPACX)
        add	A,8
        jr	C,A1210 	; 'linefeed'
        ld	(GRPACX),A	; X=X+8
        ret
;
A1200:	ld	hl,(GRPACX)
        ld	bc,8
        add	HL,BC
        ld	A,H
        and	0FEH
        jr	NZ,A1210	; 'linefeed'
        ld	(GRPACX),HL	; X=X+8
        ret
;
A1210:	ld	hl,0
        ld	(GRPACX),HL	; X=0
        ld	A,(GRPACY)
        add	A,8
        cp	212
        jr	C,A1220 	; Y=Y+8
        xor	A		; Y=0
A1220:	ld	(GRPACY),A
        ret
;
A1224:	push	hl
        push	de
        push	bc
        push	af
        ld	hl,T1109
        push	hl
        call	A12A5		; cnvchr
        ret	NC		; MSX prefix, quit
        jr	NZ,A123A	; MSX char
        cp	007H
        jp	Z,A1A62 	; bell, BEEP
        cp	020H
        ret	C		; other control char, ignore
A123A:	call	A07D9		; GETPAT
        ld	de,PATWRK
        push	de
        call	A2980		; wait _CE
        xor	A
        call	A29DB		; write VDP reg 45
        call	A1376		; FETCHC
        call	A29A5		; write VDP DX & DY
        ld	hl,8
        ld	de,16
        call	A29C4		; write VDP NX & NY
        pop	de
        ld	hl,00103H
        ld	A,(DE)
        add	A,A
        ld	C,A
        ld	A,H
        jr	NC,A1262
        ld	A,L
A1262:	push	af
        call	A29EB		; write VDP reg 44
        ld	A,0B0H		; CPU->VRAM dot
        call	A29E3		; write VDP reg 46
        di
        ld	A,0ACH
        out	(099H),A
        ld	A,091H
        out	(099H),A
        pop	af
        out	(09BH),A
        ld	A,C
        ld	C,09BH
        ld	B,008H
        push	bc
        dec	B
        jr	A1285
;
A1280:	inc	DE
        ld	A,(DE)
        push	bc
        ld	B,008H
A1285:	RLCA
        jr	NC,A1290
        out	(C),L
        push	af
        pop	af
        out	(C),L
        jr	A1296
;
A1290:	out	(C),H
        push	af
        pop	af
        out	(C),H
A1296:	djnz	A1285
        pop	bc
        djnz	A1280
        ld	hl,(CLOC)
        ld	bc,00010H
        add	HL,BC
        jp	A1372
;
A12A5:	push	hl
        push	af
        ld	hl,GRPHED
        xor	A
        cp	(HL)
        ld	(HL),A
        jr	Z,A12BC
        pop	af
        sub	040H
        cp	020H
        jr	C,A12BA
        add	A,040H
A12B8:	cp	A
        SCF
A12BA:	pop	hl
        ret
;
A12BC:	pop	af
        cp	001H
        jr	NZ,A12B8
        ld	(HL),A
        pop	hl
        ret
;
A12C4:	call	A062C		; chknhw
        jp	NC,A1305	; yes, use fast command
        push	hl
        push	bc
        ld	B,001H
        ex	DE,HL
        ld	A,H
        add	A,A
        jr	NC,A12D8
        ld	hl,0
        jr	A12E0
;
A12D8:	ld	de,000C0H
        RST	020H
        jr	C,A12E2
        ex	DE,HL
        dec	HL
A12E0:	ld	B,000H
A12E2:	ex	(SP),HL
        ld	A,H
        add	A,A
        jr	NC,A12EC
        ld	hl,0
        jr	A12F4
;
A12EC:	ld	de,00100H
        RST	020H
        jr	C,A12F6
        ex	DE,HL
        dec	HL
A12F4:	ld	B,000H
A12F6:	pop	de
        SRL	L
        SRL	L
        SRL	E
        SRL	E
        ld	A,B
        RRCA
        ld	C,L
        ld	B,H
        pop	hl
        ret
;
A1305:	push	hl
        push	bc
        ld	B,001H
        ex	DE,HL
        ld	A,H
        add	A,A
        jr	NC,A1313
        ld	hl,0
        jr	A131B
;
A1313:	ld	de,000D4H
        RST	020H
        jr	C,A131D
        ex	DE,HL
        dec	HL
A131B:	ld	B,000H
A131D:	ex	(SP),HL
        ld	A,H
        add	A,A
        jr	NC,A1327
        ld	hl,0
        jr	A1339
;
A1327:	ld	A,(SCRMOD)
        and	002H
        ld	de,00200H
        jr	NZ,A1334
        ld	de,00100H
A1334:	RST	020H
        jr	C,A133B
        ex	DE,HL
        dec	HL
A1339:	ld	B,000H
A133B:	ld	A,B
        RRCA
        ld	B,H
        ld	C,L
        pop	de
        pop	hl
        ret
;
A1342:	call	A062C		; chknhw
        jr	C,A134F 	; nop, old method
        ld	H,B
        ld	L,C
        ld	A,E
        ld	(CMASK),A
        jr	A1372
;
A134F:	push	bc
        ld	A,C
        RRCA
        ld	A,0F0H
        jr	NC,A1358
        ld	A,00FH
A1358:	ld	(CMASK),A
        ld	A,C
        add	A,A
        add	A,A
        and	0F8H
        ld	C,A
        ld	A,E
        and	007H
        or	C
        ld	C,A
        ld	A,E
        RRCA
        RRCA
        RRCA
        and	007H
        ld	B,A
        ld	hl,(MLTCGP)
        add	HL,BC
        pop	bc
A1372:	ld	(CLOC),HL
        ret
;
A1376:	ld	A,(CMASK)
        ld	hl,(CLOC)
        ret
;
A137D:	ld	(CMASK),A
        ld	(CLOC),HL
        ret
;
A1384:	call	A062C		; chknhw
        jp	NC,A13A1	; yep, fast
        push	bc
        push	hl
        call	A1376		; FETCHC
        ld	B,A
        call	A08D3
        inc	B
        dec	B
        jp	P,A139C
        RRCA
        RRCA
        RRCA
        RRCA
A139C:	and	00FH
        pop	hl
        pop	bc
        ret
;
A13A1:	push	hl
        ld	hl,(CLOC)
        ld	A,(CMASK)
        call	A2949		; VDP point
        pop	hl
        ret
;
A13AD:	call	A1E47
        ret	C
        ld	(ATRBYT),A
        ret
;
A13B5:	push	bc
        push	de
        push	hl
        call	A062C		; chknhw
        ld	A,(CMASK)
        ld	hl,(CLOC)
        jr	C,A13CA 	; nop, slow
        call	A2961		; VDP pset
        pop	hl
        pop	de
        pop	bc
        ret
;
A13CA:	ld	B,A
        call	A08D6		; RDVRM
        ld	C,A
        ld	A,B
        cpl
        and	C
        ld	C,A
        ld	A,(ATRBYT)
        inc	B
        dec	B
        jp	P,A13DF
        add	A,A
        add	A,A
        add	A,A
        add	A,A
A13DF:	or	C
        call	A08CB		; WRTVRM
        pop	hl
        pop	de
        pop	bc
        ret
;
A13E7:	push	hl
        call	A062C		; chknhw
        call	A1376		; FETCHC
        jp	C,A1466 	; nop, slow
        dec	HL
        ld	A,H
        or	A
        jp	M,A1471
        ld	(CLOC),HL
        pop	hl
        ret
;
A13FC:	push	hl
        call	A062C		; chknhw
        call	A1376		; FETCHC
        jp	C,A1474 	; nop, slow
        ld	A,(CMASK)
        cp	0D3H
        jr	NC,A1471
        inc	A
        ld	(CMASK),A
        pop	hl
        and	A
        ret
;
A1414:	call	A062C		; chknhw
        jp	C,A14AE 	; nop, slow
        ld	A,(CMASK)
        or	A
        SCF
        ret	Z
        dec	A
        ld	(CMASK),A
        or	A
        ret
;
A1426:	push	hl
        call	A1376		; FETCHC
        and	A
        ld	A,00FH
        jp	M,A1460
        ld	A,L
        and	0F8H
        cp	0F8H
        jr	NZ,A1443
        jr	A1471
;
A1439:	push	hl
        call	A1376		; FETCHC
        and	A
        ld	A,00FH
        jp	M,A1460
A1443:	push	de
        ld	de,8
        ld	A,0F0H
        jr	A145B
;
A144B:	push	hl
        call	A1376		; FETCHC
        and	A
        ld	A,0F0H
        jp	P,A1460
A1455:	push	de
        ld	de,0FFF8H
        ld	A,00FH
A145B:	add	HL,DE
        ld	(CLOC),HL
        pop	de
A1460:	ld	(CMASK),A
        and	A
        pop	hl
        ret
;
A1466:	and	A
        ld	A,0F0H
        jp	P,A1460
        ld	A,L
        and	0F8H
        jr	NZ,A1455
A1471:	SCF
        pop	hl
        ret
;
A1474:	push	de
        push	hl
        ld	hl,(MLTCGP)
        ld	de,00500H
        add	HL,DE
        ex	DE,HL
        pop	hl
        RST	020H
        jr	C,A148E
        ld	A,L
        inc	A
        and	007H
        jr	NZ,A148E
        SCF
        pop	de
        pop	hl
        ret
;
A148C:	push	hl
        push	de
A148E:	call	A1376		; FETCHC
        inc	HL
        ld	A,L
        ld	de,000F8H
        jr	A14A2
;
A1498:	push	hl
        push	de
A149A:	call	A1376		; FETCHC
        ld	A,L
        dec	HL
        ld	de,0FF08H
A14A2:	and	007H
        jr	NZ,A14A7
        add	HL,DE
A14A7:	ld	(CLOC),HL
        and	A
        pop	de
        pop	hl
        ret
;
A14AE:	push	hl
        push	de
        ld	hl,(MLTCGP)
        ld	de,00100H
        add	HL,DE
        ex	DE,HL
        ld	hl,(CLOC)
        RST	020H
        jr	NC,A149A
        ld	A,L
        and	007H
        jr	NZ,A149A
        SCF
        pop	de
        pop	hl
        ret
;
A14C7:	and	A
        push	af
        ld	A,(SCRMOD)
        cp	008H
        jr	Z,A14D8
        pop	af
        cp	010H
        ccf
A14D4:	ld	(BRDATR),A
        ret
;
A14D8:	pop	af
        jr	A14D4
;
A14DB:	ld	hl,0
        ld	C,L
        call	A062C		; chknhw
        jp	C,A1566 	; nop, slow
        push	hl
        push	bc
        push	de
        ld	hl,(CLOC)
        ld	A,(CMASK)
        ld	E,A
        ld	D,000H
        ld	A,(BRDATR)
        call	A28E0
        jr	C,A14FF
        pop	de
A14FA:	pop	bc
        pop	hl
        ld	D,H
        ld	E,H
        ret
;
A14FF:	pop	de
        push	hl
        ld	hl,(CLOC)
        add	HL,DE
        pop	de
        or	A
        sbc	HL,DE
        jr	C,A14FA
        jr	Z,A14FA
        pop	bc
        pop	bc
        push	hl
        ex	DE,HL
        ld	(CSAVEA),HL
        ld	A,(CMASK)
        ld	(CSAVEM),A
        ld	E,A
        ld	D,000H
        ld	A,(BRDATR)
        call	A28E4
        push	af
        jr	C,A1533
        ld	A,(SCRMOD)
        and	002H
        ld	hl,001FFH
        jr	NZ,A1533
        ld	hl,000FFH
A1533:	ld	(CLOC),HL
        pop	af
        jr	C,A153A
        inc	HL
A153A:	push	hl
        ex	DE,HL
        ld	hl,(CSAVEA)
        ex	DE,HL
        or	A
        sbc	HL,DE
        ex	(SP),HL
        push	hl
        ex	DE,HL
        ld	A,(CSAVEM)
        ld	E,A
        ld	D,000H
        ld	A,(ATRBYT)
        call	A28E0
        pop	de
        jr	NC,A1561
        RST	020H
        jr	NC,A1561
        pop	de
        ld	hl,(CSAVEA)
        call	A15DB
        pop	de
        ret
;
A1561:	ld	C,000H
        pop	hl
        pop	de
        ret
;
A1566:	call	A1633
        jr	NC,A1578
        dec	DE
        ld	A,D
        or	E
        ret	Z
        call	A1426		; TRIGHT
        jr	NC,A1566
        ld	de,0
        ret
;
A1578:	call	A1376		; FETCHC
        ld	(CSAVEA),HL
        ld	(CSAVEM),A
        ld	hl,0
A1584:	inc	HL
        call	A1426		; TRIGHT
        ret	C
        call	A1633
        jr	NC,A1584
        ret
;
A158F:	ld	hl,0
        ld	C,L
        call	A062C		; chknhw
        jp	C,A1626 	; nop,
        call	A13E7		; TLEFTC
        ret	C
        ld	hl,(CLOC)
        push	hl
        ld	A,(CMASK)
        ld	E,A
        ld	D,000H
        ld	A,(BRDATR)
        call	A28D8
        push	af
        jr	C,A15B3
        ld	hl,0FFFFH
A15B3:	inc	HL
        ld	(CLOC),HL
        ex	DE,HL
        pop	hl
        ex	(SP),HL
        push	hl
        or	A
        sbc	HL,DE
        inc	HL
        ex	(SP),HL
        push	de
        ld	A,(CMASK)
        ld	E,A
        ld	D,000H
        ld	A,(ATRBYT)
        call	A28DC
        jr	NC,A161B
        pop	de
        pop	bc
        pop	af
        push	bc
        push	de
        jr	NC,A15D9
        RST	020H
        jr	C,A1621
A15D9:	pop	hl
        pop	de
A15DB:	ld	A,024H
        di
        out	(099H),A
        ld	A,091H
        out	(099H),A
        ld	A,L
        out	(09BH),A
        ld	A,H
        out	(09BH),A
        ld	A,(CMASK)
        out	(09BH),A
        ld	A,(ACPAGE)
        out	(09BH),A
        ld	A,E
        out	(09BH),A
        ld	A,D
        out	(09BH),A
        ld	A,001H
        out	(09BH),A
        xor	A
        out	(09BH),A
        ld	A,(ATRBYT)
        out	(09BH),A
        xor	A
        out	(09BH),A
        ld	A,(SCRMOD)
        cp	008H
        ld	A,080H
        jr	NZ,A1614
        ld	A,0C0H
A1614:	out	(09BH),A
        ei
        ex	DE,HL
        ld	C,0FFH
        ret
;
A161B:	pop	de
        pop	hl
        pop	de
        ld	C,000H
        ret
;
A1621:	pop	de
        pop	hl
        ld	C,000H
        ret
;
A1626:	call	A13E7		; TLEFTC
        ret	C
        call	A1633
        jp	C,A1439 	; RIGHTC
        inc	HL
        jr	A1626
;
A1633:	call	A1384		; READC
        ld	B,A
        ld	A,(BRDATR)
        sub	B
        SCF
        ret	Z
        ld	A,(ATRBYT)
        cp	B
        ret	Z
        call	A13B5		; SETC
        ld	C,001H
        and	A
        ret
;
A1649:	ei
        ld	de,T1660
        push	hl
        ld	hl,PROCNM
        call	A16AD
        pop	hl
        ret	C
        SCF
        ret	NZ
        call	A165E
        ei
        and	A
        ret
;
A165E:	push	de
        ret
;
T1660:	DB	"MEMINI",0
        DW	A3702
        DB	"MKILL",0
        DW	A3978
        DB	"MNAME",0
        DW	A39DD
        DB	"MFILES",0
        DW	A3867
        DB	0FFH

A1683:	push	af
        push	hl
        ld	de,T1699
        call	A16AD
        jr	C,A1695
        pop	af
        pop	af
        dec	HL
        call	A165E
        and	A
        ret
;
A1695:	pop	hl
        pop	af
        SCF
        ret
;
T1699:	DB	0CBH,0		; TIME
        DW	A16DB
        DB	"DATE",0
        DW	A16E1
        DB	"KANJI",0
        DW	A2195
        DB	0FFH

A16AD:	push	hl
        ld	A,(DE)
        inc	A
        jr	Z,A16C6
        call	A16C9
        jr	Z,A16BD
        inc	DE
        inc	DE
        inc	DE
        pop	hl
        jr	A16AD
;
A16BD:	ld	A,(HL)
        ex	(SP),HL
A16BF:	ex	DE,HL
        inc	HL
        ld	E,(HL)
        inc	HL
        ld	D,(HL)
        and	A
        db	038H
A16C6:	scf
        pop	hl
        ret
;
A16C9:	ld	A,(DE)
        or	A
        ret	Z
        cp	(HL)
        jr	NZ,A16D3
        inc	DE
        inc	HL
        jr	A16C9
;
A16D3:	ld	A,(DE)
        and	A
        inc	DE
        jr	NZ,A16D3
        dec	DE
        dec	A
        ret
;
A16DB:	dec	B
        ld	bc,T174B	; time table
        jr	A16E5
;
A16E1:	dec	B
        ld	bc,T1767	; date table
A16E5:	jp	P,A0546 	; PUT, illegal function call
        RST	010H
        push	bc
        call	A05D8		; get var
        call	A05D2		; check if string
        dec	HL
        RST	010H
        jr	Z,A16FE
        RST	008H
        DB	','
        RST	008H
        DB	'A'
        ex	(SP),HL
        ld	bc,14
        add	HL,BC
        ex	(SP),HL 	; alarm
A16FE:	pop	bc
        push	hl
        push	de
        push	bc
        ld	A,008H
        call	A05EA		; alloc string & DSC
        ld	hl,(DSCTMP+1)
        pop	de
        push	hl
        ld	A,(DE)
        RLCA
        and	001H
        ld	B,A
        ld	C,004H
        call	A194B		; select bank, pause clock
        ld	C,3-1
A1718:	ld	B,2
A171A:	ld	A,(DE)
        inc	A
        jr	Z,A1723 	; do not read
        dec	A
        out	(0B4H),A
        in	A,(0B5H)
A1723:	inc	DE
        ex	DE,HL
        add	A,(HL)		; offset
        ex	DE,HL
        dec	DE
        daa			; BCD
        and	00FH
        or	'0'             ; digit
        ld	(HL),A
        inc	DE
        inc	DE
        inc	HL
        djnz	A171A		; next of pair
        inc	C
        dec	C
        jr	Z,A173E 	; ready
        ld	A,(DE)
        ld	(HL),A
        inc	DE
        inc	HL
        dec	C
        jr	A1718		; next pair

; The following intstruction was:
; call	A3CA7

A173E:	call	A1947
        pop	de
        pop	hl
        ld	(HL),008H
        inc	HL
        ld	(HL),E
        inc	HL
        ld	(HL),D
        pop	hl
        ret
;
T174B:	DB	005H,0
        DB	004H,0
        DB	":"
        DB	003H,0
        DB	002H,0
        DB	":"
        DB	001H,0
        DB	000H,0

        DB	085H,0
        DB	084H,0
        DB	":"
        DB	083H,0
        DB	082H,0
        DB	":"
        DB	081H,0
        DB	080H,0

T1767:	DB	008H,0		; was 00CH,8
        DB	007H,0		; was 00BH,0
        DB	"/"
        DB	00AH,0
        DB	009H,0
        DB	"/"
        DB	00CH,8		; was 008H,0
        DB	00BH,0		; was 007H,0

        DB	088H,0		; was 0FFH,0
        DB	087H,0		; was 0FFH,0
        DB	"/"
        DB	0FFH,0
        DB	0FFH,0
        DB	"/"
        DB	0FFH,0		; was 088H,0
        DB	0FFH,0		; was 087H,0

A1783:	RST	010H
        push	hl
        call	A1CF7		; bank 2 clockchip
        ld	B,003H
        ld	A,(OLDSCR)
        ld	C,A
        ld	A,(RG9SAV)
        RRCA
        RRCA
        and	002H
        or	C
        call	A1A59		; write #3 clockchip
        ld	A,(LINLEN)
        call	A1A50		; write #4,5 clockchip
        ld	A,(FORCLR)
        call	A1A59		; write #6 clockchip
        ld	A,(BAKCLR)
        call	A1A59		; write #7 clockchip
        ld	A,(BDRCLR)
        call	A1A59		; write #8 clockchip
        ld	C,000H
        ld	A,(CNSDFG)
        or	A
        jr	Z,A17BB
        SET	0,C
A17BB:	ld	A,(CLIKSW)
        or	A
        jr	Z,A17C3
        SET	1,C
A17C3:	ld	A,(NTMSXP)
        or	A
        jr	Z,A17CB
        SET	2,C
A17CB:	ld	A,(CS1200)
        ld	hl,LOW
        cp	(HL)
        jr	Z,A17D6
        SET	3,C
A17D6:	ld	A,C
        jp	A1A8C
;
A17DA:	RST	008H
        DB	'('
        call	A180D
        ld	A,E
        push	af
        RST	008H
        DB	','
        call	A180D
        RST	008H
        DB	')'
        pop	af
        and	00FH
        ld	D,A
        call	A17F8		; init adjust
        call	A1CF7		; bank 2 clockchip
        ld	B,001H
        ld	A,D
        jp	A1A50		; write #1,2 clockchip
;
A17F8:	ld	A,E
        RLCA
        RLCA
        RLCA
        RLCA
        and	0F0H
        or	D
T1800:	ld	D,A
        ld	(RG18SAV),A
        di
        out	(099H),A
        ld	A,092H
        ei
        out	(099H),A
        ret
;
A180D:	call	A0608		; eval word
        push	hl
        ex	DE,HL
        call	A25DC
        ex	DE,HL
        ld	hl,00007H
        RST	020H
        jr	NC,A1823
        ld	hl,0FFF7H
        RST	020H
        jp	NC,A0546	; illegal function call
A1823:	pop	hl
        ret
;
A1825:	call	A05FC		; eval expression
        push	hl
        call	A0614		; free temp string
        ld	A,(HL)
        inc	HL
        ld	E,(HL)
        inc	HL
        ld	D,(HL)
        pop	hl
        ret
;
A1833:	cp	0C5H
        jp	Z,A1783
        cp	0CBH
        jp	Z,A188A
        cp	0C0H
        jp	Z,A19A6
        ld	de,T184F
        call	A16AD
        jp	C,A0540 	; syntax error
        dec	HL
        RST	010H
        push	de
        ret
;
T184F:	DB	"PAGE",0
        DW	A1FB1
        DB	"VIDEO",0
        DW	A35AF
        DB	"ADJUST",0
        DW	A17DA
        DB	"TITLE",0
        DW	A1980
        DB	"PASSW",0F7H,"D",0
        DW	A19DD
        DB	"PROMPT",0
        DW	A19E1
        DB	"DATE",0
        DW	A188E
        DB	0FFH
;
A188A:	RST	010H
        ld	A,03AH
        DB	001H
A188E:	ld	A,02FH
        push	af
        call	A1825
        pop	ix
        cp	008H		; length of string 8 ?
        jp	NZ,A0540	; nop, syntax error
        push	hl
        ex	DE,HL
        call	A195E		; get digitpair
        ld	E,024H
        jr	NZ,A18A7	; time, hour<24
        ld	D,A
        ld	E,032H		; date, day<32
A18A7:	cp	E
        jr	NC,A18C3	; nop, error
        ld	B,A
        call	A1956		; get next digitpair
        ld	E,013H
        jr	Z,A18B4 	; date, month<13
        ld	E,060H		; time, min<60
A18B4:	cp	E
        jr	NC,A18C3	; nop, error
        ld	C,A
        call	A1956		; get next digitpair
        jr	NZ,A18C0	; time,
        ld	B,A
        jr	A18C6		; date, 00-99
;
A18C0:	ld	D,A
        cp	060H		; time, sec<60
A18C3:	jp	NC,A0546	; nop, illegal function call
A18C6:	pop	hl
        push	ix
        dec	HL
        RST	010H		; alarm prefix ?
        ld	A,000H
        jr	Z,A18D5 	; nop,
        RST	008H
        DB	','
        RST	008H
        DB	'A'             ; eval alarm prefix
        or	001H
A18D5:	pop	ix
        nop
        nop			; leftover due date format difference
        push	hl
        push	af
        push	bc
        push	de
        jr	NZ,A18EA	; alarm
        ld	bc,00004H
        call	A194B		; Clock pause, bank 0
        ld	bc,00E00H
        jr	A18F8		; #0F = 0E
;
A18EA:	ld	bc,00108H
        call	A194B		; Alarm off, bank 1
        call	A196C
        jr	Z,A18FD 	; date,
        ld	bc,00D00H	; #0F = 0D
A18F8:	ld	A,00FH
        call	A194D
A18FD:	pop	de
        ld	B,000H
        call	A196C
        jr	NZ,A1907	; time, offset 0
        ld	B,007H		; date, offset 7
A1907:	ld	A,D
        call	A1A50		; write clockchip
        pop	de
        pop	af
        push	af
        jr	Z,A1915 	; not alarm,
        call	A196C
        jr	Z,A1941 	; alarm date, skip
A1915:	ld	A,E
        call	A1A50		; write clockchip
        ld	A,D
        call	A196C
        jr	NZ,A193E	; time, write hour
        push	af
        push	bc
        bit	4,A
        jr	Z,A1927
        add	A,002H
A1927:	and	003H
        push	af
        ld	A,001H
        call	A1CF9		; bank 1 clockchip
        pop	af
        ld	B,00BH
        call	A1A59		; write #11 clockchip
        xor	A
        call	A1CF9		; bank 0 clockchip
        pop	bc
        pop	af
        sub	080H
        daa
A193E:	call	A1A50		; write clockchip
A1941:	pop	af
        pop	hl
        ld	B,004H
        jr	NZ,A1949	; alarm, Alarm on
A1947:	ld	B,008H		;      , Clock run
A1949:	ld	C,00FH
A194B:	ld	A,00DH
A194D:	out	(0B4H),A
        in	A,(0B5H)
        and	C
        or	B
        out	(0B5H),A
        ret
;
A1956:	push	ix
        pop	af
        cp	(HL)
        inc	HL
        jp	NZ,A0540	; syntax error
A195E:	call	A1974
        RLCA
        RLCA
        RLCA
        RLCA
        and	0F0H
        ld	E,A
        call	A1974
        or	E
A196C:	push	bc
        push	ix
        pop	bc
        bit	4,B
        pop	bc
        ret
;
A1974:	ld	A,(HL)
        inc	HL
        sub	030H
        jr	C,A197D
        cp	00AH
        ret	C
A197D:	jp	A0546		; illegal function call
;
A1980:	cp	02CH
        jr	Z,A198B
        xor	A
        call	A19EC
        dec	HL
        RST	010H
        ret	Z
A198B:	RST	008H
        DB	','
        RST	028H		; eval byte
        ret	NZ
        dec	A
        cp	004H
        jr	NC,A197D
        push	af
        call	A1CF7		; bank 2 clockchip
        ld	B,00BH
        call	A1CD2		; read #11 clockchip
        and	00CH
        ld	C,A
        pop	af
        or	C
        dec	B
        jp	A1A59		; write #11 clockchip
;
A19A6:	call	A1CF7		; bank 2 clockchip
        ld	B,00AH
        call	A1CD2		; read #10 clockchip
        push	af
        RST	010H
        cp	02CH
        jr	Z,A19C8
        RST	028H		; eval byte
        dec	A
        cp	004H
        jr	NC,A19CE
        RLCA
        RLCA
        and	00CH
        ld	B,A
        pop	af
        and	003H
        or	B
        push	af
        dec	HL
        RST	010H
        jr	Z,A19D7
A19C8:	RST	008H
        DB	','
        RST	028H		; eval byte
        dec	A
        cp	004H
A19CE:	jp	NC,A0546	; illegal function call
        ld	B,A
        pop	af
        and	00CH
        or	B
        push	af
A19D7:	ld	B,00AH
        pop	af
        jp	A1A59		; write #10 clockchip
;
A19DD:	ld	A,001H
        jr	A19E3
;
A19E1:	ld	A,002H
A19E3:	call	A19EC
        dec	HL
        RST	010H
        jp	NZ,A0540	; syntax error
        ret
;
A19EC:	push	af
        call	A1825		; eval string
        ld	C,A
        call	A1CF3		; bank 3 clockchip
        ld	B,00CH
        xor	A
A19F7:	call	A1A59		; write clockchip
        dec	B
        djnz	A19F7		; clear bank
        pop	af
        call	A1A59		; write #0 clockchip (ID)
        push	hl
        ex	DE,HL
        dec	A
        jr	Z,A1A17 	; password
        ld	E,006H
A1A08:	dec	C
        inc	C
        jr	Z,A1A15
        ld	A,(HL)
        inc	HL
        call	A1A50		; write clockchip
        dec	C
        dec	E
        jr	NZ,A1A08
A1A15:	pop	hl
        ret
;
A1A17:	ld	A,021H
        call	A1A50		; write #1,2 clockchip
        ld	A,003H
        call	A1A59		; write #3 clockchip
        ld	A,C
        push	af
        call	A1CA5		; calc 'CRC' password
        ld	B,004H
        ld	A,E
        call	A1A50		; write #4,5 clockchip
        ld	A,D
        call	A1A50		; write #6,7 clockchip
        pop	af
        ld	C,A
        xor	A
        out	(07FH),A
        in	A,(07FH)
        cp	0AAH
        jr	NZ,A1A15	; no CARD, quit
        ld	A,C
        or	A
        ld	A,001H
        jr	Z,A1A42 	; no password, ID = only CARD
        inc	A		; ID = CARD & user
A1A42:	call	A1A59		; write #8 clockchip
        push	bc
        call	A1C97		; calc 'CRC' cardword
        pop	bc
        ld	A,E
        call	A1A50		; write #9,10 clockchip
        ld	A,D
        pop	hl		; write #11,12 clockchip

A1A50:	push	af
        call	A1A59		; write clockchip
        pop	af
        RRCA
        RRCA
        RRCA
        RRCA			; write clockchip

A1A59:	push	af
        ld	A,B
        out	(0B4H),A
        inc	B
        pop	af
        out	(0B5H),A
        ret
;
A1A62:	push	hl
        call	A1AD0		; get beep parameters from clock
        push	af
        dec	B
        jr	Z,A1A90 	; melody 1
        dec	B
        jr	Z,A1AAD 	; melody 2
        dec	B
        jr	Z,A1ABC 	; melody 3
        ld	E,055H
        call	A1B11		; write freq A
        call	A1B1A		; tone A
        call	A1B32		; get volume
        ld	A,008H
        call	A1B1E		; write vol A
        ld	bc,2000
        call	A1B28		; wait
A1A86:	call	A056B		; GICINI (psg init)
        pop	af
        ld	B,00DH
A1A8C:	pop	hl
        jp	A1A59		; restore bank
;
A1A90:	ld	hl,T1B3E
        ld	E,0B8H
        call	A1B1C		; tone A,B,C
        ld	E,0A7H
        ld	A,002H
        call	A1B12		; write freq B
        ld	E,0A8H
        ld	A,004H
        call	A1B12		; write freq C
        ld	E,0A6H
A1AA8:	call	A1AEA		; melody
        jr	A1A86
;
A1AAD:	ld	hl,T1B3E
        call	A1B1A		; tone A
        ld	E,02AH
        call	A1AEA		; melody
        ld	E,035H
        jr	A1AA8		; melody
;
A1ABC:	ld	hl,T1B46
        call	A1B1A		; tone A
        ld	E,06BH
        call	A1AEA		; melody
        ld	E,047H
        call	A1AEA		; melody
        ld	E,055H
        jr	A1AA8		; melody
;
A1AD0:	ld	B,00DH
        call	A1CD2		; read #13 clockchip
        push	af
        call	A1CF7		; bank 2 clockchip
        ld	B,00AH
        call	A1CD2		; read #10 clockchip
        ld	C,A
        RRCA
        RRCA
A1AE1:	and	003H
        ld	B,A
        ld	A,C
        and	003H
        ld	C,A
        pop	af
        ret
;
A1AEA:	call	A1B11		; write freq A
        push	bc
        push	hl
        call	A1B32		; get volume
        pop	hl
        push	hl
        add	HL,BC
        add	HL,BC
        ld	C,(HL)
        inc	HL
        ld	B,(HL)
A1AF9:	ld	A,008H
        call	A1B1E		; write vol A
        ld	A,009H
        call	A1B1E		; write vol B
        ld	A,00AH
        call	A1B1E		; write vol C
        call	A1B28		; wait
        dec	E
        jr	NZ,A1AF9	; lower vol
        pop	hl
        pop	bc
        ret
;
A1B11:	xor	A
A1B12:	call	A1B1E		; write PSG
        ld	E,000H
        inc	A
        jr	A1B1E		; write PSG
;
A1B1A:	ld	E,0BEH
A1B1C:	ld	A,007H
A1B1E:	di
        out	(0A0H),A
        push	af
        ld	A,E
        ei
        out	(0A1H),A
        pop	af
        ret
;
A1B28:	push	bc
A1B29:	dec	BC
        ex	(SP),HL
        ex	(SP),HL
        ld	A,B
        or	C
        jr	NZ,A1B29
        pop	bc
        ret
;
A1B32:	ld	B,000H
        ld	hl,T1B3A
        add	HL,BC
        ld	E,(HL)
        ret
;
T1B3A:	DB	004H,007H,00AH,00FH

T1B3E:	DW	010D8H,0099FH,006BDH,0047EH
T1B46:	DW	0059DH,00335H,0023FH,0017FH

A1B4E:	call	A05AE		; CR/LF
        call	A1CF3		; bank 3 clockchip
        call	A1CD0		; read #0 clockchip
        cp	002H		; prompt ?
        ld	hl,03FD7H
        jp	NZ,A05F6	; nop, print default string
A1B5F:	call	A1CDB		; read byte clockchip
        jr	Z,A1B6A 	; end of string
        RST	018H		; outdo
        ld	A,B
        cp	00DH
        jr	C,A1B5F 	; not end of bank, cont
A1B6A:	jp	A05A8		; CR/LF
;
A1B6D:	call	A1C73		; read VRAM 01FFFFH
        ld	C,A
        cpl
        call	A1C74		; write VRAM 01FFFFH
        call	A1C73		; read VRAM 01FFFFH
        cpl
        cp	C
        ld	A,C
        call	A1C74		; write VRAM 01FFFFH
        ld	hl,T1C68
        ld	C,002H
        jr	NZ,A1B8A	; incorrect, 64 Kb VRAM
        call	rdvext
        ld	c,a
        cpl
        call	wrvext
        call	rdvext
        cpl
        cp	c
        ld	a,c
        call	wrvext
        ld	c,004H
        ld	hl,T1C64
        jr	nz,A1B8A	; incorrect, 128 Kb VRAM
        ld	hl,V192K
A1B8A:	push	hl
        ld	A,(YFAFC)
        and	11111001b
        or	C
        ld	(YFAFC),A
        ld	hl,128
        ld	A,172
        call	A1D2B		; at 128,108
        ld	hl,T1C5E
        call	A1C4B		; print VRAM
        pop	hl
        call	A1C4B		; print vramsize
        ld	hl,T1C6C
        call	A1C4B		; print Kb
;
; Count Main RAM
;
        call	cntmem
        ld	a,l
        or	h
        jr	nz,memok
        ld	l,4
memok:	add	hl,hl
        add	hl,hl
        add	hl,hl
        add	hl,hl
        call	makstr
        ld	hl,144
        ld	a,180
        call	A1D2B
        ld	hl,MRAM
        call	A1C4B
        ld	hl,BUF
        call	A1C4B
        ld	hl,T1C6C
        call	A1C4B

;
;
;
        xor	A
        out	(099H),A
        out	(099H),A
        out	(099H),A
        ld	A,08EH
        out	(099H),A
        call	A1CF3		; bank 3 clockchip
        call	A1CD0		; read #0 clockchip
        jr	Z,A1C35 	; title,
        dec	A
        ret	NZ		; not password, quit
        call	A1CD2		; read #1 clockchip
        cp	001H
        ret	NZ		; invalid header, quit
        call	A1CD2		; read #2 clockchip
        cp	002H
        ret	NZ		; invalid header, quit
        call	A1CD2		; read #3 clockchip
        cp	003H
        ret	NZ		; invalid header, quit
        ld	B,008H
        call	A1CD2		; read #8 clockchip
        jr	Z,A1BEF 	; no CARD password, soft user
        xor	A
        out	(07FH),A
        in	A,(07FH)
        cp	0AAH
        jr	NZ,A1BEF	; no CARD available, soft user
        push	bc
        call	A1C97		; calc 'CRC' cardword
        pop	bc
        call	A1CEA		; read #9,10,11,12 clockchip
        RST	020H
        ret	Z		; correct, quit
        jr	A1C00
;
A1BEF:	ld	A,006H
        call	A0590		; SNSMAT
        and	004H
        jr	NZ,A1C00
        ld	A,007H
        call	A0590		; SNSMAT
        and	010H
        ret	Z		; GRAPH+STOP, quit user password
A1C00:	ld	hl,96
        ld	A,208
        call	A1D2B		; at 96,144
        ld	hl,T1C54
        call	A1C4B		; Print Password
        ld	B,008H
        call	A1CD2		; read #8 clockchip
        dec	A		; only CARD entry ?
A1C14:	jr	Z,A1C14 	; yep, hanging
A1C16:	ld	hl,BUF
        ld	B,0FFH
A1C1B:	call	A0565		; CHGET
        cp	00DH
        jr	Z,A1C26 	; return, quit
        ld	(HL),A
        inc	HL
        djnz	A1C1B
A1C26:	ld	A,0FFH
        sub	B
        call	A1CA2		; calc 'CRC' password
        ld	B,004H
        call	A1CEA		; read #4,5,6,7 clockchip
        RST	020H
        ret	Z		; correct, quit
        jr	A1C16		; try again
;
A1C35:	ld	hl,200
        ld	A,200
        call	A1D2B		; at 200,136
A1C3C:	call	A1CDB		; read byte clockchip
        ret	Z		; nul byte, quit
        call	A1224		; print char
        ld	A,B
        cp	00DH
        jr	C,A1C3C
        jp	A0565		; CHGET
;
A1C4B:	ld	A,(HL)
        inc	HL
        or	A
        ret	Z
        call	A1224		; print char
        jr	A1C4B
;
T1C54:	DB	"Password:",0
;
;
;
MRAM:	db	"MAIN RAM:",0
;
;
;
T1C5E:	DB	"VIDEO RAM:",0
;
;
;
V192K:	db	"192",0
;
;
;
T1C64:	DB	"128",0
T1C68:	DB	"64",0

T1C6C:	DB	" Kb",0

;
; Read/Write external VRAM, extra 64 Kb scratchpad for VDP
;
rdvext: db	0F6H
wrvext: scf
        push	af
        ld	a,01000000B
        out	(099H),a
        ld	a,0ADH
        out	(099H),a	; MXC = 1
        ld	a,003H
        out	(099H),a
        ld	a,08EH
        out	(099H),a
        ld	a,0FFH
        out	(099H),a
        pop	af
        push	af
        ld	a,07FH
        jr	c,L0000
        ld	a,03FH
L0000:	out	(099H),a
        ex	(sp),hl
        ex	(sp),hl
        pop	af
        jr	c,L0001
        in	a,(098H)
        jr	L0002
L0001:	out	(098H),a
L0002:	push	af
        xor	a
        out	(099H),a	; MXC=0
        ld	a,0ADH
        out	(099H),a
        pop	af
        ret
;
;
;
A1C73:	db	0F6H
A1C74:	scf
        push	af
        ld	A,007H
        out	(099H),A
        ld	A,08EH
        out	(099H),A
        ld	A,0FFH
        out	(099H),A
        pop	af
        push	af
        ld	A,07FH
        jr	C,A1C8A
        ld	A,03FH
A1C8A:	out	(099H),A
        ex	(SP),HL
        ex	(SP),HL
        pop	af
        jr	C,A1C94
        in	A,(098H)
        ret
A1C94:	out	(098H),A
        ret
;
A1C97:	in	A,(07FH)
        ld	L,A
        in	A,(07FH)
        ld	H,A
        ld	(BUF),HL
A1CA0:	ld	A,002H
A1CA2:	ld	hl,BUF
A1CA5:	ld	de,0
        ld	C,A
        or	A
        ret	Z
        SCF
A1CAC:	push	af
A1CAD:	ld	B,008H
A1CAF:	pop	af
        push	af
        jr	NC,A1CB5
        RLC	(HL)
A1CB5:	RL	E
        RL	D
        jr	NC,A1CC3
        ld	A,D
        xor	080H
        ld	D,A
        ld	A,E
        xor	005H
        ld	E,A
A1CC3:	djnz	A1CAF
        inc	HL
        dec	C
        jr	NZ,A1CAD
        pop	af
        ret	NC
        or	A
        ld	C,002H
        jr	A1CAC
;
A1CD0:	ld	B,000H
A1CD2:	ld	A,B
        out	(0B4H),A
        inc	B
        in	A,(0B5H)
        and	00FH
        ret
;
A1CDB:	push	de
        call	A1CD2		; read #B clockchip
        ld	D,A
        call	A1CD2		; read #B+1 clockchip
        RLCA
        RLCA
        RLCA
        RLCA
        or	D
        pop	de
        ret
;
A1CEA:	call	A1CDB		; read byte clockchip
        ld	L,A
        call	A1CDB		; read byte clockchip
        ld	H,A
        ret
;
A1CF3:	ld	A,003H
        jr	A1CF9
;
A1CF7:	ld	A,002H
A1CF9:	push	bc
        push	af
        ld	B,00DH
        call	A1CD2		; read #13 clockchip
        and	00CH
        pop	bc
        or	B
        out	(0B5H),A	; set bank
        pop	bc
        ret
;
A1D08:	call	A1D1A
        in	A,(0B5H)
        and	00FH
        ret
;
A1D10:	push	af
        call	A1D1A
        pop	af
        and	00FH
        out	(0B5H),A
        ret
;
A1D1A:	ld	A,C
        push	af
        and	030H		; Bank
        RRCA
        RRCA
        RRCA
        RRCA
        call	A1CF9		; set bank
        pop	af
        and	00FH		; register
        out	(0B4H),A
        ret
;
A1D2B:	ld	(CLOC),HL
        ld	(CMASK),A
        ret
;
; Extra subroutines to count main memory
;
makstr: ld	ix,BUF
        ld	c,0
        ld	de,-10000
        call	makdig
        ld	de,-1000
        call	makdig
        ld	de,-100
        call	makdig
        ld	de,-10
        call	makdig
        ld	a,l
        add	a,'0'
        ld	(ix+0),a
        ld	(ix+1),0
        ret

makdig: ld	a,-1
makcnt: add	hl,de
        inc	a
        jr	c,makcnt
        sbc	hl,de
        bit	0,c
        jr	nz,makset
        and	a
        ret	z
        set	0,c
makset: add	a,'0'
        ld	(ix+0),a
        inc	ix
        ret

cntmem: ld	hl,0
        ld	de,EXPTBL
        ld	b,0
cntnp:	ld	a,(de)
        ld	c,a
cntns:	ld	a,c
        or	b
        call	tstslt
        bit	7,c
        jr	z,cntap
        ld	a,c
        add	a,4
        ld	c,a
        bit	4,c
        jr	z,cntns
cntap:	inc	de
        inc	b
        ld	a,b
        cp	4
        jr	c,cntnp
        push	hl
        ld	h,040H
        ld	a,(EXPTBL+0)
        call	A02BD
        pop	hl
        ret

tstslt: push	bc
        push	de
        push	hl
        ld	h,040H
        call	A02BD
        call	tstmap
        pop	hl
        jr	c,tstnm
        ld	c,a
        ld	b,0
        and	a
        jr	nz,tstn4
        inc	b
tstn4:	add	hl,bc
tstnm:	pop	de
        pop	bc
        ret

tstmap: ld	hl,04000H
        xor	a
        out	(0FDH),a
        ld	(hl),0AAH
        inc	a
        out	(0FDH),a
        ld	(hl),055H
        dec	a
        out	(0FDH),a
        ld	a,(hl)
        cp	0AAH
        scf
        jr	nz,nomap
        ld	b,0
mapini: ld	a,b
        out	(0FDH),a
        ld	(hl),0AAH
        inc	b
        jr	nz,mapini
mapnxt: ld	a,b
        out	(0FDH),a
        inc	b
        ld	a,(hl)
        cp	0AAH
        jr	nz,mapend
        ld	a,055H
        ld	(hl),a
        cp	(hl)
        jr	z,mapnxt
mapend: dec	b
        and	a
nomap:	ld	a,2
        out	(0FDH),a
        ld	a,b
        ret
;
;
;
A1D32:	ld	A,(HL)
        ex	(SP),HL
        cp	(HL)
        jp	NZ,A0540	; syntax error
        inc	HL
        ex	(SP),HL
A1D3A:	call	H.CHRG
        inc	HL
A1D3E:	ld	A,(HL)
        cp	03AH
        ret	NC
        cp	020H
        jr	Z,A1D3A
        jr	NC,A1DB1
        or	A
        ret	Z
        cp	00BH
        jr	C,A1DAC
        cp	01EH
        jr	NZ,A1D57
        ld	A,(CONSAV)
        or	A
        ret
;
A1D57:	cp	010H
        jr	Z,A1D8F
        push	af
        inc	HL
        ld	(CONSAV),A
        sub	01CH
        jr	NC,A1D94
        sub	0F5H
        jr	NC,A1D6E
        cp	0FEH
        jr	NZ,A1D82
        ld	A,(HL)
        inc	HL
A1D6E:	ld	(CONTXT),HL
        ld	H,000H
A1D73:	ld	L,A
        ld	(CONLO),HL
        ld	A,002H
        ld	(CONTYP),A
        ld	hl,046E6H
        pop	af
        or	A
        ret
;
A1D82:	ld	A,(HL)
        inc	HL
        inc	HL
        ld	(CONTXT),HL
        dec	HL
        ld	H,(HL)
        jr	A1D73
;
; >> NO EXECUTION PATH TO HERE <<
        call	A1DB7
A1D8F:	ld	hl,(CONTXT)
        jr	A1D3E
;
A1D94:	inc	A
        RLCA
        ld	(CONTYP),A
        push	de
        push	bc
        ld	de,CONLO
        call	A1DF0
        pop	bc
        pop	de
        ld	(CONTXT),HL
        pop	af
        ld	hl,046E6H
        or	A
        ret
;
A1DAC:	cp	009H
        jp	NC,A1D3A
A1DB1:	cp	030H
        ccf
        inc	A
        dec	A
        ret
;
A1DB7:	ld	A,(CONSAV)
        cp	00FH
        jr	NC,A1DD1
        cp	00DH
        jr	C,A1DD1
        ld	hl,(CONLO)
        jr	NZ,A1DCE
        inc	HL
        inc	HL
        inc	HL
        ld	E,(HL)
        inc	HL
        ld	D,(HL)
        ex	DE,HL
A1DCE:	jp	A05DE		; in DAC
;
A1DD1:	ld	A,(CONTYP)
        ld	(VALTYP),A
        cp	002H
        jr	NZ,A1DE1
        ld	hl,(CONLO)
        ld	(DAC+2),HL
A1DE1:	ld	hl,CONLO
        ld	de,DAC
        ld	A,(VALTYP)
        cp	004H
        jr	NC,A1DF0
        inc	DE
        inc	DE
A1DF0:	ld	C,A
        ld	B,000H
        ldir
        ret
;
A1DF6:	jp	Z,A1ED5
        cp	0EFH
        jp	Z,A1ECA
        cp	0C7H
T1E00:	jp	Z,A2040
        ld	de,(FORCLR)
        push	de
        cp	02CH
        jr	Z,A1E17
        RST	028H		; eval byte
        call	A1E40
        pop	de
        ld	E,A
        push	de
        dec	HL
        RST	010H
        jr	Z,A1E33
A1E17:	RST	008H
        DB	','
        cp	02CH
        jr	Z,A1E28
        RST	028H		; eval byte
        call	A1E40
        pop	de
        ld	D,A
        push	de
        dec	HL
        RST	010H
        jr	Z,A1E33
A1E28:	RST	008H
        DB	','
        RST	028H		; eval byte
        call	A1E40
        ld	(BDRCLR),A
        dec	HL
        RST	010H
A1E33:	ex	(SP),HL
        ld	(FORCLR),HL
        ld	A,L
        ld	(ATRBYT),A
        call	A0953		; CHGCLR
        pop	hl
        ret
;
A1E40:	call	A1E47
        ret	NC
        jp	A0546		; illegal function call
;
A1E47:	push	af
        ld	A,(SCRMOD)
        cp	006H
        jr	Z,A1E5B
        cp	008H
        jr	Z,A1E58
        pop	af
        cp	010H
        ccf
        ret
;
A1E58:	pop	af
        and	A
        ret
;
A1E5B:	pop	af
        cp	020H
        ccf
        ret	C
        cp	010H
        jr	C,A1E67
        and	00FH
        ret
;
A1E67:	and	003H
        push	bc
        ld	B,A
        add	A,A
        add	A,A
        add	A,B
        pop	bc
        ret
;
A1E70:	RST	010H
        ld	A,00FH
        call	A1EDC
        push	af
        call	A0F6A		; GETPLT
        push	bc
        RST	008H
        DB	','
        cp	02CH
        jr	Z,A1E98
        ld	A,007H
        call	A1EDC
        add	A,A
        add	A,A
        add	A,A
        add	A,A
        ld	E,A
        pop	bc
        ld	A,B
        and	00FH
        or	E
        ld	B,A
        push	bc
        dec	HL
        RST	010H
        cp	029H
        jr	Z,A1EBA
A1E98:	RST	008H
        DB	','
        cp	02CH
        jr	Z,A1EAC
        ld	A,007H
        call	A1EDC
        pop	bc
        ld	C,A
        push	bc
        dec	HL
        RST	010H
        cp	029H
        jr	Z,A1EBA
A1EAC:	RST	008H
        DB	','
        ld	A,007H
        call	A1EDC
        pop	bc
        ld	A,B
        and	0F0H
        or	E
        ld	B,A
        push	bc
A1EBA:	RST	008H
        DB	')'
        pop	bc
        ld	A,B
        ld	E,C
        pop	bc
        ld	D,B
        push	af
        call	A1034		; wait for VR
        pop	af
        call	A0FD3		; SETPLT
        ret
;
A1ECA:	RST	010H
        cp	'('
        jr	Z,A1E70 	; COLOR=()
        cp	08CH
        jr	Z,A1ED8 	; COLOR=RESTORE
        RST	008H
        DB	094H		; COLOR=NEW
A1ED5:	jp	A0F9F		; INIPLT
;
A1ED8:	RST	010H
        jp	A0F7E		; RSTPLT
;
A1EDC:	push	af
        RST	028H		; eval byte
        pop	af
        cp	E
        ld	A,E
        ret	NC
        jp	A0546		; illegal function call
;
A1EE5:	cp	02CH
        jr	Z,A1F1D
        RST	028H		; eval byte
        cp	009H
        jp	NC,A0546	; illegal function call
        cp	005H
        jr	C,A1F0E
        push	af
        ld	A,(YFAFC)
        RRCA
        and	003H
        ld	C,A
        pop	af
        cp	007H
        push	af
        ld	A,C
        jr	NC,A1F08
        cp	001H
        jr	C,A1F0A
        jr	A1F0D
;
A1F08:	cp	002H
A1F0A:	jp	C,A0546 	; illegal function call
A1F0D:	pop	af
A1F0E:	push	hl
        call	A09BF		; CHGMDP
        ld	A,(LINLEN)
        ld	E,A
        call	A2033
        pop	hl
        dec	HL
        RST	010H
        ret	Z
A1F1D:	RST	008H
        DB	','
        cp	02CH
        jr	Z,A1F3A
        RST	028H		; eval byte
        cp	004H
        jp	NC,A0546	; illegal function call
        ld	A,(RG1SAV)
        and	0FCH
        or	E
        ld	(RG1SAV),A
        push	hl
        call	A06F5		; CLRSPR
        pop	hl
        dec	HL
        RST	010H
        ret	Z
A1F3A:	RST	008H
        DB	','
        cp	02CH
        jr	Z,A1F45
        RST	028H		; eval byte
        ld	(CLIKSW),A
        ret	Z
A1F45:	RST	008H
        DB	','
        cp	02CH
        jr	Z,A1F51
        call	A1F7A
        dec	HL
        RST	010H
        ret	Z
A1F51:	RST	008H
        DB	','
        cp	02CH
        jr	Z,A1F5C
        RST	028H		; eval byte
        ld	(NTMSXP),A
        ret	Z
A1F5C:	RST	008H
        DB	','
        RST	028H		; eval byte
        cp	004H
        jp	NC,A0546	; illegal function call
        add	A,A
        bit	1,A
        jr	Z,A1F6B
        SET	3,A
A1F6B:	and	00CH
        ld	B,A
        ld	A,(RG9SAV)
        and	0F3H
        or	B
        ld	C,009H
A1F76:	ld	B,A
        jp	A0647		; WRTVDP
;
A1F7A:	RST	028H		; eval byte
        dec	A
        cp	002H
        jp	NC,A0546	; illegal function call
        push	hl
        ld	bc,00005H
        and	A
        ld	hl,CS1200
        jr	Z,A1F8C
        add	HL,BC
A1F8C:	ld	de,LOW
        ldir
        pop	hl
        ret
;
A1F93:	push	bc
        ld	B,A
        call	A062C		; chknhw
        jr	C,A1FAE 	; nop,
        cp	007H
        ld	A,001H
        jr	NC,A1FAD	; screen 7 & 8, maxpage = 1
        ld	A,(YFAFC)
        and	006H
        cp	004H
        ld	A,001H
        jr	C,A1FAD 	; 64 Kb VRAM, maxpage = 1
        ld	A,003H		; maxpage = 3
A1FAD:	cp	B
A1FAE:	ld	A,B
        pop	bc
        ret
;
A1FB1:	ld	de,(DPPAGE)
        cp	02CH
        jr	Z,A1FC7
        push	de
        RST	028H		; eval byte
        pop	de
        call	A1F93		; check valid page
A1FBF:	jp	C,A0546 	; nop, illegal function call
        ld	E,A
        dec	HL
        RST	010H
        jr	Z,A1FD2
A1FC7:	push	de
        RST	008H
        DB	','
        RST	028H		; eval byte
        pop	de
        call	A1F93		; check valid page
        jr	C,A1FBF 	; nop, illegal function call
        ld	D,A
A1FD2:	ld	(DPPAGE),DE
        push	hl
        call	A2980		; wait _CE
        call	A06A8		; SETPAG
        pop	hl
        ret
;
A1FDF:	jp	Z,A0546 	; illegal function call
        ld	A,(OLDSCR)
        and	A
        ld	A,E
        jr	Z,A1FEE
        cp	021H
        jp	NC,A0546	; illegal function call
A1FEE:	cp	029H
        jr	C,A1FF7
        cp	051H
        jp	NC,A0546	; illegal function call
A1FF7:	ld	A,(LINLEN)
        cp	E
        ret	Z
        ld	A,00CH
        RST	018H		; clear screen
A1FFF:	ld	A,E
T2000:	ld	(LINLEN),A
        call	A2033
        ld	A,(OLDSCR)
        dec	A
        ld	A,E
        jr	NZ,A2014
        ld	(LINL32),A
        ld	A,00CH
        RST	018H		; clear screen
        ret
;
A2014:	ld	C,029H
        ld	A,(LINL40)
T2019:	cp	C
        ld	A,E
        ld	(LINL40),A
        push	af
        ld	A,00CH
        RST	018H		; clear screen
        pop	af
        jr	C,A2028
        cp	C
        ret	NC
T2027:	ld	C,A
A2028:	cp	C
        ret	C
        push	af
        push	hl
        xor	A
        call	A09BF		; CHGMDP
        pop	hl
        pop	af
        ld	E,A
A2033:	sub	00EH
        jr	NC,A2033
        add	A,01CH
        cpl
        inc	A
        add	A,E
        ld	(CLMLST),A
        ret
;
A2040:	call	A0626		; chkohw
        jp	C,A0546 	; msx1 screen, illegal function call
        RST	010H
        cp	'$'
        jr	Z,A2065
        ld	A,31
        call	A2318		; eval (spriteplane)
        push	hl
        call	A0775
        ex	(SP),HL
        RST	008H
        DB	0EFH		; =
        RST	028H		; eval byte
        and	A
        jp	M,A0546 	; >127, illegal function call
        ld	bc,16
        ex	(SP),HL
        call	A0977		; init VRAM
        pop	hl
        ret
;
A2065:	RST	008H
        DB	'$'
        ld	A,31
        call	A2318		; eval (spriteplane)
        push	hl
        call	A0775
        ex	(SP),HL
        RST	008H
        DB	0EFH		; =
        call	A05FC		; eval expression
        push	hl
        call	A0614		; free temp string
        ld	A,(HL)
        cp	16+1
        jr	C,A2081
        ld	A,16
A2081:	inc	HL
        ld	E,(HL)
        inc	HL
        ld	D,(HL)
        pop	hl
        ex	(SP),HL
        and	A		; length zero ?
        ld	B,A
        ex	DE,HL
        call	NZ,A0F2B	; nop,
        pop	hl
        ret
;
A208F:	RST	010H
        RST	028H		; eval byte
        cp	020H
        jp	NC,A0546	; illegal function call
        ld	(BUF+2),A
        push	hl
        push	af
        call	A0775
        ld	(LINWRK),HL
        ld	de,LINWRK+2
        ld	B,010H
        call	A0F22
        pop	af
        push	af
        call	A076A		; CALATR
        ld	(BUF),HL
        pop	af
        ld	B,A
        ld	A,020H
        sub	B
        ld	B,A
A20B7:	ld	(BUF+3),A
        ld	de,0F562H
        push	de
        call	A0F22
        pop	hl
        ex	(SP),HL
        RST	008H
        DB	','
        cp	02CH
        jr	Z,A20F5
        call	A059C		; eval coordinates
        ex	(SP),HL
        ld	(HL),E
        inc	HL
        ld	A,B
        add	A,A
        ld	A,C
        ld	C,000H
        jr	NC,A20DA
        add	A,020H
        ld	C,080H
A20DA:	ld	(HL),A
        push	hl
        ld	hl,LINWRK+2
T20DF:	ld	B,010H
A20E1:	ld	A,(HL)
        and	07FH
        or	C
        ld	(HL),A
        inc	HL
        djnz	A20E1
        call	A217A
        pop	hl
        inc	HL
        ex	(SP),HL
        dec	HL
        RST	010H
        pop	bc
        jr	Z,A212E
        push	bc
A20F5:	RST	008H
        DB	','
        cp	02CH
        jr	Z,A2119
        RST	028H		; eval byte
        and	A
        jp	M,A0546 	; illegal function call
        push	hl
        ld	hl,LINWRK+2
        ld	C,A
        ld	B,010H
A2107:	ld	A,(HL)
        and	080H
        or	C
        ld	(HL),A
        inc	HL
        djnz	A2107
        call	A217A
        pop	hl
        dec	HL
        RST	010H
        pop	bc
        jr	Z,A212E
        push	bc
A2119:	RST	008H
        DB	','
        RST	028H		; eval byte
        call	A077F		; GSPSIZ
        ld	A,E
        jr	NC,A2129
        cp	040H
        jp	NC,A0546	; illegal function call
        add	A,A
        add	A,A
A2129:	ex	(SP),HL
        ld	(HL),A
        ld	B,H
        ld	C,L
        pop	hl
A212E:	push	hl
        ld	A,(BUF+2)
        sub	01FH
        jr	Z,A216A
        ld	hl,(LINWRK)
        ld	A,(BUF+3)
        ld	B,A
A213D:	ld	de,16
        add	HL,DE
        push	hl
        push	bc
        ld	de,LINWRK+2
        ld	B,010H
        call	A0F22
        call	A2187
        pop	bc
        pop	hl
        jr	Z,A2154
        djnz	A213D
A2154:	ld	A,(BUF+3)
        sub	B
        jr	Z,A216A
        ld	B,A
        ld	hl,0F566H
        ld	de,(BUF+4)
A2162:	ld	(HL),E
        inc	HL
        ld	(HL),D
        inc	HL
        inc	HL
        inc	HL
        djnz	A2162
A216A:	inc	A
        add	A,A
        add	A,A
        ld	B,A
        ld	hl,0F562H
        ld	de,(BUF)
        call	A0F2B
        pop	hl
        ret
;
A217A:	ld	hl,LINWRK+2
        ld	de,(LINWRK)
        ld	B,010H
        call	A0F2B
        ret
;
A2187:	ld	hl,LINWRK+2
        ld	B,010H
A218C:	ld	A,(HL)
        and	040H
        ret	NZ
        inc	HL
        djnz	A218C
        xor	A
        ret
;
A2195:	dec	B
        jp	M,A0540 	; syntax error
        ld	A,(SCRMOD)
        cp	005H
        jp	C,A0546 	; illegal function call
        RST	010H
        cp	02CH
        call	NZ,A059C	; eval coordinates
        RST	008H
        DB	','
        call	A0608		; eval word
        push	de
        call	A256F
        call	A2594
        dec	HL
        RST	010H
        cp	02CH
        ld	A,000H
        jr	NZ,A21C2
        RST	010H
        RST	028H		; eval byte
        cp	003H
        jp	NC,A0546	; illegal function call
A21C2:	pop	bc
        jp	A1049
;
A21C6:	ld	A,47
        call	A2318		; eval (?)
        cp	008H
        jr	C,A21DD
        jp	Z,A0546 	; illegal function call
        dec	E
        dec	A
        cp	018H
        jr	C,A21DD
        cp	020H
        jp	C,A0546 	; illegal function call
A21DD:	push	de
        RST	008H
        DB	0EFH		; =
        RST	028H		; eval byte
        pop	bc
        jp	A1F76
;
A21E5:	RST	010H
        RST	008H
        DB	'('
        call	A0608
        RST	008H
        DB	')'
        push	hl
        ld	A,D
        RLCA
        jr	C,A220E
        and	A
        jr	NZ,A21F8
        ld	A,E
        cp	019H
A21F8:	jp	NC,A0546	; illegal function call
        cp	009H
        jr	NC,A2204
        ld	hl,RG0SAV
        jr	A2207
;
A2204:	ld	hl,RG8SAV-9
A2207:	add	HL,DE
        ld	A,(HL)
A2209:	call	A05E4		; in DAC
        pop	hl
        ret
;
A220E:	ex	DE,HL
        call	A25DC
        ex	DE,HL
        ld	hl,00009H
        RST	020H
        jp	C,A0546 	; illegal function call
        ld	A,E
        call	A298B		; VDPSTA
        jr	A2209
;
A2220:	ld	A,19
        call	A2318		; eval (?)
        ld	D,000H
        push	de
        RST	008H
        DB	0EFH		; =
        call	A0608		; eval word
        cp	040H
        jp	NC,A0546	; illegal function call
        ex	(SP),HL
        push	hl
        ld	C,E
        ld	B,D
        pop	hl
        ld	A,L
        push	af
        add	HL,HL
        ex	DE,HL
        ld	hl,T226F
        add	HL,DE
        ld	A,C
        and	(HL)
        jr	NZ,A2246
        inc	HL
        ld	A,B
        and	(HL)
A2246:	jp	NZ,A0546	; illegal function call
        ld	hl,TXTNAM
        add	HL,DE
        ld	(HL),C
        inc	HL
        ld	(HL),B
        pop	af
        ld	E,0FFH
A2253:	inc	E
        sub	005H
        jr	NC,A2253
        ld	A,(SCRMOD)
        cp	E
        call	Z,A2261
        pop	hl
        ret
;
A2261:	dec	A
        jp	M,A0B42 	; SETTXT
        jp	Z,A0B9C 	; SETT32
        dec	A
        jp	Z,A0BD2 	; SETGRP
        jp	A0C22		; SETMLT
;
T226F:	DW	003FFH
        DW	0003FH
        DW	007FFH
        DW	0007FH
        DW	007FFH

        DW	003FFH
        DW	0003FH
        DW	007FFH
        DW	0007FH
        DW	007FFH

        DW	003FFH
        DW	01FFFH
        DW	01FFFH
        DW	0007FH
        DW	007FFH

        DW	003FFH
        DW	0003FH
        DW	007FFH
        DW	0007FH
        DW	007FFH

A2297:	RST	010H
        ld	A,44
        call	A2318		; eval (?)
        cp	014H
        jr	NC,A22C2
        push	hl
A22A2:	cp	002H
        jr	NZ,A22B2
        ld	A,(LINLEN)
        cp	029H
        jr	C,A22B2
        ld	hl,T1000
        jr	A22BD
;
A22B2:	ld	hl,TXTNAM
        ld	D,000H
        add	HL,DE
        add	HL,DE
        ld	A,(HL)
        inc	HL
        ld	H,(HL)
        ld	L,A
A22BD:	call	A05DE		; in DAC
        pop	hl
        ret
;
A22C2:	push	hl
        sub	019H
        jr	NC,A22D3
        add	A,00FH
        ld	E,A
        cp	00DH
        jr	NZ,A22A2
        ld	hl,(D22DE)
        jr	A22BD
;
A22D3:	ld	D,000H
        ld	E,A
        ld	hl,T22E0
        add	HL,DE
        ld	H,(HL)
        ld	L,D
        jr	A22BD
;
D22DE:	dw	01E00H

T22E0:	db	000H
        db	000H
        db	000H
        db	076H
        db	078H
        db	000H
        db	000H
        db	000H
        db	076H
        db	078H
        db	000H
        db	000H
        db	000H
        db	0FAH
        db	0F0H
        db	000H
        db	000H
        db	000H
        db	0FAH
        db	0F0H

A22F4:	call	A0602
        push	de
        RST	008H
        DB	','
        RST	028H		; eval byte
        ex	(SP),HL
        call	A08CB		; WRTVRM
        ld	hl,0
        call	A08D6		; RDVRM
        pop	hl
        ret
;
A2307:	call	A05B4		; eval adres
        call	A08D6		; RDVRM
        push	af
        ld	hl,0
        call	A08D6		; RDVRM
        pop	af
        jp	A05E4		; in DAC
;
A2318:	push	af
        RST	008H
        DB	'('
        RST	028H		; eval byte
        pop	af
        cp	E
        jp	C,A0546 	; illegal function call
        RST	008H
        DB	')'
        ld	A,E
        ret
;
A2325:	ld	A,(VALTYP)
        cp	008H
        jr	NC,A2331
        sub	003H
        or	A
        SCF
        ret
;
A2331:	sub	003H
        or	A
        ret
;
; >> NO EXECUTION PATH TO HERE <<
        call	A2325
        ld	hl,(DAC+2)
        ret	M
        jp	Z,A0552 	; type mismatch
        jp	A05F0		; to int
;
A2342:	cp	0C5H
        jp	Z,A3676 	; COPY SCREEN statement
        ld	(BUF+0),HL	; save basicpointer
        cp	'('
        jr	Z,A23C3 	; graph coordinates
        call	A24F6		; check for string or array
        ld	(BUF+4),DE
        ld	(BUF+6),BC
        jr	NC,A238C	; array,
        dec	HL
        RST	010H
        jp	Z,A254D
        cp	0D9H
        jr	NZ,A236F
        RST	010H
        cp	028H
        jr	NZ,A2378
        xor	A
        ld	(BUF+17),A
        jr	A2372
;
A236F:	call	A252B
A2372:	push	hl
        ld	hl,A30A8	; BLTVD
        jr	A23A4
;
A2378:	call	A24F6		; check for string or array
        jp	C,A254D
        ld	(BUF+8),DE
        ld	(BUF+10),BC
        push	hl
        ld	hl,A306F	; BLTMD
        jr	A23BD
;
A238C:	dec	HL
        RST	010H
        cp	0D9H
        jr	NZ,A239D
        RST	010H
        cp	028H
        jr	NZ,A23AB
        xor	A
        ld	(BUF+17),A
        jr	A23A0
;
A239D:	call	A252B
A23A0:	push	hl
        ld	hl,A2F42	; BLTVM
A23A4:	ld	(BUF+2),HL
        pop	hl
        jp	A24A9
;
A23AB:	call	A24F6		; check for string or array
        jp	NC,A0540	; syntax error
        ld	(BUF+8),DE
        ld	(BUF+10),BC
        push	hl
        ld	hl,A307C	; BLTDM
A23BD:	ld	(BUF+2),HL
        jp	A24E4
;
A23C3:	push	hl
        ld	hl,A2EB9	; BLTVV
        ld	(BUF+2),HL
        pop	hl
        call	A059C		; eval coordinates
        push	bc
        push	de
        RST	008H
        DB	0F2H		; -
        call	A05A2
        dec	HL
        RST	010H
        cp	0D9H
        ld	A,(ACPAGE)
        jr	Z,A23E1
        RST	008H
        DB	','
        RST	028H		; eval byte
A23E1:	call	A1F93		; check valid page
        jp	C,A0546 	; nop, illegal function call
        ld	(BUF+6+1),A
        pop	de
        pop	bc
        RST	008H
        DB	0D9H		; TO
        push	hl
        call	A12C4		; SCALXY
        ld	(BUF+4),BC
        ld	A,E
        ld	(BUF+6),A
        call	A25F1
        call	A12C4		; SCALXY
        call	A25F1
        ex	AF,AF'
        xor	A
        ex	AF,AF'
        call	A25D5
        jr	NC,A240F
        ex	AF,AF'
        or	004H
        ex	AF,AF'
A240F:	inc	HL
        ld	(BUF+12),HL
        call	A25E6
        jr	NC,A241C
        ex	AF,AF'
        or	008H
        ex	AF,AF'
A241C:	inc	HL
        ld	(BUF+14),HL
        ex	AF,AF'
        ld	(BUF+17),A
        ex	AF,AF'
        push	bc
        push	de
        ld	bc,(BUF+12)
        ld	E,L
        ld	D,H
        call	A3376
        jp	C,A0546 	; illegal function call
        pop	de
        pop	bc
        pop	hl
        dec	HL
        RST	010H
        cp	028H
        jr	Z,A24A9
        call	A24F6		; check for string or array
        ld	(BUF+8),DE
        ld	(BUF+10),BC
        jr	NC,A2450
        push	hl
        ld	hl,A31B4	; BLTDV
        jp	A24A4
;
A2450:	push	hl
        push	bc
        push	de
        ld	bc,(BUF+12)
        ld	de,(BUF+14)
        call	A3052
        ld	A,000H
        add	A,A
        ld	E,A
        call	A253B
        dec	B
        jr	Z,A248D
        dec	B
        jr	Z,A2480
        ld	bc,00003H
        add	HL,BC
        ld	A,E
        adc	A,000H
        SRL	A
        RR	H
        RR	L
        SRL	A
        RR	H
        RR	L
        jr	A248D
;
A2480:	ld	bc,00001H
        add	HL,BC
        ld	A,E
        adc	A,000H
        SRL	A
        RR	H
        RR	L
A248D:	pop	de
        add	HL,DE
        jr	C,A249E
        nop
        ld	de,4
        add	HL,DE
        jr	C,A249E
        nop
        pop	de
        ex	DE,HL
        and	A
        sbc	HL,DE
A249E:	jp	C,A0546 	; illegal function call
        ld	hl,A2EDF	; BLTMV
A24A4:	ld	(BUF+2),HL
        jr	A24DE
;
A24A9:	call	A05A2		; eval 2nd coordinates
        push	hl
        call	A12C4		; SCALXY
        ld	(BUF+8),BC
        ld	A,E
        ld	(BUF+10),A
        pop	hl
        xor	A
        ld	(BUF+10+1),A
        dec	HL
        RST	010H
        ld	A,(ACPAGE)
        jr	Z,A24CE
        RST	008H
        DB	','
        cp	02CH
        ld	A,(ACPAGE)
        call	NZ,A060E	; eval byte
A24CE:	call	A1F93		; check valid page
        jp	C,A0546 	; nop, illegal function call
        ld	(BUF+10+1),A
        call	A2594
        ld	(BUF+18),A
        push	hl
A24DE:	call	A062C		; chknhw
        jp	C,A0546 	; nop, illegal function call
A24E4:	ld	hl,T24F0
        push	hl
        ld	hl,(BUF+2)
        push	hl
        ld	hl,0F562H
        ret
;
T24F0:	pop	hl
        jp	C,A0546 	; illegal function call
        and	A
        ret
;
A24F6:	push	hl
        call	A05FC		; eval expression
        ld	A,(VALTYP)
        cp	003H
        jr	Z,A2523 	; it's a string, quit
        pop	hl
        ld	A,001H
        ld	(SUBFLG),A	; array without index
        call	A05D8		; get var
        jp	NZ,A0546	; illegal function call
        ld	(SUBFLG),A
        push	hl
        ld	H,B
        ld	L,C
        ex	DE,HL
        add	HL,DE
        dec	HL
        push	hl
        ld	A,(BC)
        add	A,A
        ld	L,A
        ld	H,000H
        inc	BC
        add	HL,BC
        ex	DE,HL
        pop	bc
        pop	hl
        and	A
        ret
;
A2523:	push	hl
        call	A0614		; free temp string
        pop	hl
        pop	de
        SCF
        ret
;
A252B:	RST	008H
        DB	','
        RST	028H		; eval byte
        cp	004H
        jp	NC,A0546	; illegal function call
        add	A,A
        add	A,A
        ld	(BUF+17),A
        RST	008H
        DB	0D9H		; TO
        ret
;
A253B:	ld	B,001H
        ld	A,(SCRMOD)
        cp	008H
        ret	Z
        inc	B
        cp	005H
        ret	Z
        cp	007H
        ret	Z
        inc	B
        inc	B
        ret
;
A254D:	xor	A
        ld	(SUBFLG),A
        ld	hl,(BUF)
        SCF
        ret
;
A2556:	push	af
        call	A05A2		; eval 2nd coordinates
        pop	af
        call	A2572
        call	A2594
        push	hl
        call	A12C4		; SCALXY
        jr	NC,A256D
        call	A1342		; MAPXYC
        call	A13B5		; SETC
A256D:	pop	hl
        ret
;
A256F:	ld	A,(FORCLR)
A2572:	push	bc
        push	de
        ld	E,A
        call	A0620		; chkgrp
        jp	C,A0546 	; textscreen, illegal function call
        dec	HL
        RST	010H
        jr	Z,A2586
        RST	008H
        DB	','
        cp	02CH
        jr	Z,A2586
        RST	028H		; eval byte
A2586:	ld	A,E
        push	hl
        call	A13AD		; SETATR
        jp	C,A0546 	; illegal function call
        pop	hl
        pop	de
        pop	bc
        jp	A1D3E
;
A2594:	ld	A,000H
        push	de
        ld	D,000H
        ld	E,A
        dec	HL
        RST	010H
        jr	Z,A25CC
        RST	008H
        DB	','
        jp	Z,A054C 	; missing operand
        cp	02CH
        jr	Z,A25CC
        ld	E,A
        cp	054H
        jr	Z,A25C4
        cp	0D9H
        jr	Z,A25BC
        inc	A
        jr	NZ,A25CB
        RST	010H
        RST	008H
        DB	08DH		; TAN
        RST	008H
        DB	'D'
        ld	E,0F6H
        jr	A25C1
;
A25BC:	RST	010H
        RST	008H
        DB	'R'
        ld	E,0F7H
A25C1:	dec	HL
        jr	A25C9
;
A25C4:	RST	010H
        jp	Z,A0540 	; syntax error
        ld	E,A
A25C9:	ld	D,008H
A25CB:	RST	010H
A25CC:	ld	A,E
        call	A27B6
        jp	C,A0540 	; syntax error
        pop	de
        ret
;
A25D5:	ld	hl,(GXPOS)
        and	A
        sbc	HL,BC
A25DB:	ret	NC
A25DC:	xor	A
        sub	L
        ld	L,A
        sbc	A,H
        sub	L
        ld	H,A
        xor	A
        sub	001H
        ret
;
A25E6:	ld	hl,(GYPOS)
        and	A
        sbc	HL,DE
        jr	A25DB
;
A25EE:	call	A12C4		; SCALXY
A25F1:	call	A2600		; set GYPOS on start
A25F4:	push	hl		;  save end
        push	bc
        ld	hl,(GXPOS)
        ex	(SP),HL
        ld	(GXPOS),HL	; set GXPOS on start
        pop	bc		;  save end
        pop	hl
        ret
;
A2600:	push	hl
        ld	hl,(GYPOS)
        ex	DE,HL
        jr	A263A
;
A2607:	call	A059C		; eval coordinates
        push	bc
        push	de
        RST	008H
        DB	0F2H		; -
        call	A05A2
        call	A256F
        pop	de
        pop	bc
        dec	HL
        RST	010H
        jr	Z,A263F
        RST	008H
        DB	','
        cp	02CH
        jr	Z,A263F
        RST	008H
        DB	'B'
        jr	Z,A2648
        cp	02CH
        jr	Z,A2648
        RST	008H
        DB	'F'
A262A:	call	A2594
        push	hl
        call	A2898		; NVBXFL
A2631:	ld	hl,(GRPACX)
        ld	(GXPOS),HL
        ld	hl,(GRPACY)
A263A:	ld	(GYPOS),HL
        pop	hl
        ret
;
A263F:	call	A2594
        push	hl
        call	A2823		; DOGRPH
        jr	A2631
;
A2648:	call	A2594
        push	hl
        call	A27E7		; NVBXLN
        jr	A2631
;
A2651:	call	A059C		; eval coordinates
        push	bc
        push	de
        call	A256F
        ld	A,(ATRBYT)
        ld	E,A
        dec	HL
        RST	010H
        jr	Z,A2664
        RST	008H
        DB	','
        RST	028H		; eval byte
A2664:	ld	A,E
        and	A
        call	A14C7
        jp	C,A0546 	; illegal function call
        pop	de
        pop	bc
        push	hl
        call	A27AD
        call	A1342		; MAPXYC
        ld	de,00001H
        call	A277E
        jr	Z,A2691
        push	hl
        call	A278F
        pop	de
        add	HL,DE
        ex	DE,HL
        xor	A
        call	A275B
        ld	A,040H
        call	A275B
        ld	B,0C0H
        jr	A26B3
;
A2691:	pop	hl
        ret
;
A2693:	ld	A,(INTFLG)
        or	A
        call	NZ,A0589	; CKCNTC
        ld	A,(LOHDIR)
        or	A
        jr	Z,A26AC
        ld	hl,(LOHADR)
        push	hl
        ld	hl,(LOHMSK)
        push	hl
        ld	hl,(LOHCNT)
        push	hl
A26AC:	pop	de
        pop	bc
        pop	hl
        ld	A,C
        call	A137D
A26B3:	ld	A,B
        ld	(PDIREC),A
        add	A,A
        jr	Z,A2691
        push	de
        jr	NC,A26C2
        call	A1414		; TUPC
        jr	A26C5
;
A26C2:	call	A13FC		; TDOWNC
A26C5:	pop	de
        jr	C,A26AC
        call	A277E
        jp	Z,A26AC
        xor	A
        ld	(LOHDIR),A
        call	A278F
        ld	E,L
        ld	D,H
        or	A
        jr	Z,A26F4
        dec	HL
        dec	HL
        ld	A,H
        add	A,A
        jr	C,A26F4
        ld	(LOHCNT),DE
        call	A1376		; FETCHC
        ld	(LOHADR),HL
        ld	(LOHMSK),A
        ld	A,(PDIREC)
        cpl
        ld	(LOHDIR),A
A26F4:	ld	hl,(MOVCNT)
        add	HL,DE
        ex	DE,HL
        call	A274F
        ld	hl,(CSAVEA)
        ld	A,(CSAVEM)
        call	A137D
A2705:	ld	hl,(SKPCNT)
        ld	de,(MOVCNT)
        or	A
        sbc	HL,DE
        jr	Z,A274C
        jr	C,A272F
        ex	DE,HL
        ld	B,001H
        call	A277E
        jr	Z,A274C
        or	A
        jr	Z,A2705
        ex	DE,HL
        ld	hl,(CSAVEA)
        ld	A,(CSAVEM)
        ld	C,A
        ld	A,(PDIREC)
        ld	B,A
        call	A2760
        jr	A2705
;
A272F:	call	A25DC
        dec	HL
        dec	HL
        ld	A,H
        add	A,A
        jr	C,A274C
        inc	HL
        push	hl
        ex	DE,HL
        ld	hl,(CLOC)
        or	A
        sbc	HL,DE
        ld	(CLOC),HL
        pop	de
        ld	A,(PDIREC)
        cpl
        call	A275B
A274C:	jp	A2693
;
A274F:	ld	A,(LFPROG)
        ld	C,A
        ld	A,(RTPROG)
        or	C
        ret	Z
        ld	A,(PDIREC)
A275B:	ld	B,A
        call	A1376		; FETCHC
        ld	C,A
A2760:	ex	(SP),HL
        push	bc
        push	de
        push	hl
        ld	C,002H
        push	hl
        ld	hl,(STREND)
        ld	B,000H
        add	HL,BC
        add	HL,BC
        ld	A,088H
        sub	L
        ld	L,A
        ld	A,0FFH
        sbc	A,H
        ld	H,A
        jr	C,A277B
        add	HL,SP
        pop	hl
        ret	C
A277B:	jp	A0558		; out of memory
;
A277E:	call	A14DB		; SCANR
        ld	(SKPCNT),DE
        ld	(MOVCNT),HL
        ld	A,H
        or	L
        ld	A,C
        ld	(RTPROG),A
        ret
;
A278F:	call	A1376		; FETCHC
        push	hl
        push	af
        ld	hl,(CSAVEA)
        ld	A,(CSAVEM)
        call	A137D
        pop	af
        pop	hl
        ld	(CSAVEA),HL
        ld	(CSAVEM),A
        call	A158F		; SCANL
        ld	A,C
        ld	(LFPROG),A
        ret
;
A27AD:	push	hl
        call	A12C4		; SCALXY
        jp	NC,A0546	; illegal function call
        pop	hl
        ret
;
A27B6:	and	A
        jr	Z,A27E2
        push	bc
        ld	B,A
        call	A062C		; chknhw
        ld	A,B
        pop	bc
        ret	C		; nop, quit
        cp	0F8H
        jr	Z,A27E0 	; XOR
        cp	0F7H
        jr	Z,A27DD 	; OR
        cp	0F6H
        jr	Z,A27DA 	; AND
        cp	0C3H
        jr	Z,A27D7 	; PRESET
        cp	0C2H
        SCF
        ret	NZ
        xor	A		; PSET
        DB	0C2H
A27D7:	ld	A,004H
        DB	0C2H
A27DA:	ld	A,001H
        DB	0C2H
A27DD:	ld	A,002H
        DB	0C2H
A27E0:	ld	A,003H
A27E2:	or	D
        ld	(LOGOPR),A
        ret
;
A27E7:	call	A25EE
        call	A25EE
        call	A25D5
        jr	Z,A2823 	; DOGRPH
        call	C,A25F4
        call	A25E6
        jr	Z,A2823 	; DOGRPH
        call	C,A2600
        ld	hl,(GYPOS)
        push	hl
        push	de
        ex	DE,HL
        call	A2823		; DOGRPH
        pop	hl
        ld	(GYPOS),HL
        ex	DE,HL
        call	A2823		; DOGRPH
        pop	hl
        dec	HL
        inc	DE
        ld	(GYPOS),HL
        ld	hl,(GXPOS)
        push	bc
        ld	C,L
        ld	B,H
        call	A2823		; DOGRPH
        pop	hl
        ld	(GXPOS),HL
        ld	C,L
        ld	B,H		; DOGRPH

A2823:	push	bc
        push	de
        push	hl
        ld	hl,(GYPOS)
        push	hl
        ld	hl,(GXPOS)
        push	hl
        call	A25EE		; scale start & exchange
        call	A12C4		; SCALXY (end)
        call	A25E6		; NY
        call	C,A25F1 	; exchange
        push	de
        push	hl
        ex	AF,AF'
        xor	A
        ex	AF,AF'          ; right down X=major
        call	A25D5		; NX
        ex	DE,HL
        jr	NC,A2849
        ex	AF,AF'
        or	004H		; left
        ex	AF,AF'
A2849:	pop	hl
        RST	020H		; NX bigger as NY ?
        jr	C,A2852 	; yep
        ex	DE,HL
        ex	AF,AF'
        or	001H		; nop, Y=major
        ex	AF,AF'
A2852:	ex	(SP),HL
        call	A2980		; wait _CE
        ld	A,024H
        di
        out	(099H),A
        ld	A,091H
        out	(099H),A	; select S36
        ld	A,C
        out	(09BH),A
        ld	A,B
        out	(09BH),A	; DX
        ld	A,L
        out	(09BH),A
        ld	A,(ACPAGE)
        out	(09BH),A	; DY
        ld	A,E
        out	(09BH),A
        ld	A,D
        out	(09BH),A	; NX
        pop	hl
        ld	A,L
        out	(09BH),A
        ld	A,H
        out	(09BH),A	; NY
        ld	A,(ATRBYT)
        out	(09BH),A	; COL
        ex	AF,AF'
        out	(09BH),A	; MOD
        ld	A,(LOGOPR)
        and	00FH
        or	070H		; LINE
        out	(09BH),A
        ei
        pop	hl
        ld	(GXPOS),HL
        pop	hl
        ld	(GYPOS),HL	; set GPOS on end
        pop	hl
        pop	de
        pop	bc
        ret
;
A2898:	call	A12C4		; SCALXY
        ld	L,C
        ld	H,B
        ld	A,E
        call	A29A5		; write VDP DX & DY
        call	A25F1
        call	A25EE
        ex	AF,AF'
        xor	A		; right/down
        ex	AF,AF'
        call	A25D5
        jr	NC,A28B3
        ex	AF,AF'
        or	004H		; left
        ex	AF,AF'
A28B3:	inc	HL
        push	hl
        call	A25E6
        jr	NC,A28BE
        ex	AF,AF'
        or	008H		; up
        ex	AF,AF'
A28BE:	inc	HL
        pop	de
        call	A29C4		; write VDP NX & NY
        ex	AF,AF'
        call	A29DB		; write VDP reg 45
        ex	AF,AF'
        ld	A,(ATRBYT)
        call	A29EB		; write VDP reg 44
        ld	A,(LOGOPR)
        and	00FH
        add	A,080H		; VDP->VRAM dot
        call	A29E3		; write VDP reg 46
A28D8:	ld	B,004H		; left & equal
        jr	A28E6
;
A28DC:	ld	B,006H		; left & _equal
        jr	A28E6
;
A28E0:	ld	B,002H		; right & _equal
        jr	A28E6
;
A28E4:	ld	B,000H		; right & equal
A28E6:	push	bc
        call	A2925		; write VDP S & D & COLOR
        pop	af
        di
        out	(099H),A
        ld	A,0ADH
        out	(099H),A	; write S45
        ld	A,060H
        out	(099H),A
        ld	A,0AEH
        out	(099H),A	; SEARCH
        call	A2980		; wait _CE
        and	010H
        ret	Z		; _BD, quit
        ld	A,008H
        di
        out	(099H),A
        ld	A,08FH
        out	(099H),A
        in	A,(099H)	; BXl
        ld	L,A
D290C:	ld	A,009H
        out	(099H),A
        ld	A,08FH
        out	(099H),A
        in	A,(099H)	; BXh
        push	af
        xor	A
        out	(099H),A
        ld	A,08FH
        out	(099H),A	; status reg 0
        ei
        pop	af
        and	001H
        ld	H,A
        SCF
        ret
;
A2925:	push	af
        call	A2980		; wait _CE
        ld	A,020H
        di
        out	(099H),A
        ld	A,091H
        out	(099H),A	; S32
        ld	A,L
        out	(09BH),A
        ld	A,H
        out	(09BH),A	; SX
        ld	A,E
        out	(09BH),A
        ld	A,(ACPAGE)
        out	(09BH),A	; SY
        pop	af
        out	(099H),A
        ld	A,0ACH
        out	(099H),A	; Color
        ei
        ret
;
A2949:	push	de
        call	A29A0		; write VDP SX & SY
        xor	A
        call	A29DB		; write VDP reg 45
        ld	A,040H		; POINT dot
        call	A29E3		; write VDP reg 46
        call	A2980		; wait _CE
        ld	A,7		; reg 7
        call	A298B		; VDPSTA
        ei
        pop	de
        ret
;
A2961:	call	A29A5		; write VDP DX & DY
        ld	A,02CH
        di
        out	(099H),A
        ld	A,091H
        out	(099H),A	; S44
        ld	A,(ATRBYT)
        out	(09BH),A
        xor	A
        out	(09BH),A
        ld	A,(LOGOPR)
        and	00FH
        or	050H		; PSET
        out	(09BH),A
        ei
        ret
;
A2980:	ld	A,2		; reg 2
        call	A298B		; VDPSTA
        ei
        RRCA
        jr	C,A2980 	; wait until no CE
        RLCA
        ret
;
A298B:	di
        out	(099H),A
        ld	A,08FH
        out	(099H),A
        push	hl
        pop	hl
        in	A,(099H)
        push	af
        xor	A
        out	(099H),A
        ld	A,08FH
        out	(099H),A
        pop	af
        ret
;
A29A0:	push	af
        ld	A,020H
        jr	A29A8
;
A29A5:	push	af
        ld	A,024H
A29A8:	push	af
        call	A2980		; wait _CE
        di
        pop	af
        out	(099H),A
        ld	A,091H
        out	(099H),A
        ld	A,L
        out	(09BH),A
        ld	A,H
        out	(09BH),A
        pop	af
        out	(09BH),A
        ld	A,(ACPAGE)
        out	(09BH),A
        ei
        ret
;
A29C4:	ld	A,028H
        di
        out	(099H),A
        ld	A,091H
        out	(099H),A
        ld	A,E
        out	(09BH),A
        ld	A,D
        out	(09BH),A
        ld	A,L
        out	(09BH),A
        ld	A,H
        out	(09BH),A
        ei
        ret
;
A29DB:	push	af
        di
        out	(099H),A
        ld	A,0ADH
        jr	A29F1
;
A29E3:	push	af
        di
        out	(099H),A
        ld	A,0AEH
        jr	A29F1
;
A29EB:	push	af
        di
        out	(099H),A
        ld	A,0ACH
A29F1:	out	(099H),A
        ei
        pop	af
        ret

; Initial VDP register values

T29F6:  DEFB	000H                    ; R#0: DG=0 (Digitize off), IE2=0 (lightpen int off) IE1=0 (VR int off), M5=0, M4=0, M3=0 (screen 1)
        DEFB    020H                    ; R#1: BLK=0 Enable display IE0=1 (HR int on), M1=0, M2=0 (screen 1), SZ=0 (8x8 sprites), MAG=0 (sprites not magnified)
        DEFB    000H                    ; R#2: A16=0, A15=0, A14=0, A13=0, A12=0, A11=0, A10=0
        DEFB    000H                    ; R#3: B13=0, B12=0, B11=0, B10=0, B9=0,  B8=0,  B7=0, B6=0
        DEFB    000H                    ; R#4: C16=0, C15=0, C14=0, C13=0, C12=0, C11=0
        DEFB    000H                    ; R#5: D14=0, D13=0, D12=0, D11=0, D10=0, D9=0,  D8=0, D7=0
        DEFB    000H                    ; R#6: E16=0, E15=0, E14=0, E13=0, E12=0, E11=0
        DEFB    000H                    ; R#7: TC3=0, TC2=0, TC1=0, TC0=0 (text color 0), BDC3=0,BDC2=0,BDC1=0,BDC0=0 (border color 0)

        DEFB	008H                    ; R#8: MS=0 (disable mouse), LP=0 (disable lightpen), TP=0 (color 0 is transparent), CBD=0 (colorbus not input), VRS1=0, VRS0=0 (64 KB RAM chip), SPD=0 (sprites enabled), B/W=0 (blank/white off)

        IF	INTHZ EQ 60

        DEFB	000H                    ; R#9: LN=0, SYM1=0, SYM0=0 (internal synchronisation), IL=0 (no interlace), EO=0 (no odd even display), NTSC=0 (NTSC), DCD=0 (dot clock direction output)

        ELSE

        DEFB	002H                    ; R#9: LN=0, SYM1=0, SYM0=0 (internal synchronisation), IL=0 (no interlace), EO=0 (no odd even display), NTSC=1 (PAL), DCD=0 (dot clock direction output)

        ENDIF

        DEFB	000H                    ; R#10: B16=0, B15=0, B14=0
        DEFB    000H                    ; R#11: D16=0, D15=0
        DEFB    000H                    ; R#12: C3=0, C2=0, C1=0, C0=0 (color 0), BC3=0, BC2=0, BC1=0, BC0=0 (back color 0)
        DEFB    000H                    ; R#13: ON3=0, ON2=0, ON1=0, ON0=0 (blink on ?), OF3=0, OF2=0, OF1=0, OF0=0 (blink off ?)
        DEFB    000H                    ; R#14: F16=0, F15=0, F14=0 (VRAM base access is lower 16 KB, TMS9918 compatibel)
        DEFB    000H                    ; R#15: RS3=0, RS2=0, RS1=0, RS0=0 (select status register 0, TMS9918 compatibel)
        DEFB	000H                    ; R#16: C3=0, C2=0, C1=0, C0=0 (color code 0)
        DEFB    000H                    ; R#17: AII=0 (autoincrement register), RC5=0, RC4=0, RC3=0, RC2=0, RC1=0, RC0=0 (control register 0)
        DEFB    000H                    ; R#18: dV3=0, dV2=0, dV1=0, dV0=0 (no vertical adjust), dH3=0, dH2=0, dH1=0, dH0=0 (no horizontal adjust)
        DEFB    000H                    ; R#19: IL7=0, IL6=0, IL5=0, IL4=0, IL3=0, IL2=0, IL1=0, IL0=0 (interrupt on line 0)
        DEBF    000H                    ; R#20: CBX5=0, CBX4=0, CBX3=0, CBX2=0, CBX1=0, CBX0=0 (Color burst value of phase 0)
        DEFB    03BH                    ; R#21: CBX5=1, CBX4=1, CBX3=1, CBX2=0, CBX1=1, CBX0=1 (Color burst value of phase 1/3)
        DEFB    005H                    ; R#22: CBX5=0, CBX4=0, CBX3=0, CBX2=1, CBX1=0, CBX0=1 (Color burst value of phase 2/3)
        DEFB    000H                    ; R#23: DO7=0, DO6=0, DO5=0, DO4=0, DO3=0, DO2=0, DO1=0, DO0=0 (display offset)

; Start screen

A2A0E:	call	A2A14		; build logo
        jp	A1B6D		; print info
;
; New startscreen
;
A2A14:	call	A2B40		; init VDP regs
        di
        ld	A,055H
        ld	hl,00000H
        ld	bc,08000H
        call	A0977		; init VRAM
        call	A2AFF		; init colors & table
        ld	de,00705H
        call	A2AC2		; VDP(7)=005H (bordercolor 1)
        ld	de,01740H
        call	A2AC2
        ld	de,00160H
        call	A2AC2		; enable screen
;
; Make window
;
        call	A2980		; wait _CE
        ld	de,01124H
        call	A2AC2
        ld	hl,WINCPY
        ld	b,11
        ld	c,09BH
        otir
;
; Make logo
;
        ld	hl,LOGCPY
        ld	de,BUF+32
        ld	bc,11
        ldir
        ld	hl,LOGDAT
        call	MAKLIN
        push	hl
        ld	a,(BUF+48)
        ld	(BUF+32+8),a	; first byte
        call	A2980		; wait _CE
        ld	de,01124H
        call	A2AC2
        ld	hl,BUF+32
        ld	b,11
        ld	c,09BH
        otir
        ld	de,011ACH
        call	A2AC2
        ld	hl,BUF+48+1
        ld	b,66-1
        ld	c,09BH
        otir
        pop	hl
        ld	b,57
LOGNXT: push	bc
        call	MAKLIN
        push	hl
        ld	hl,BUF+48
        ld	b,66
        ld	c,09BH
        otir
        pop	hl
        pop	bc
        djnz	LOGNXT
;
; Fade in
;
        ld	b,16
NXTFAD: push	bc
        ld	b,4*3
        ld	ix,BUF+0
NXTCLR: ld	a,(ix+12)
        add	a,(ix+0)
        ld	(ix+12),a
        inc	ix
        djnz	NXTCLR
        ld	de,01000H
        call	A2AC2		; write VDP reg 16 =0
        call	A1034		; wait VR
        call	A1034		; wait VR
        call	A1034		; wait VR
        call	A1034		; wait VR
        ld	b,4
NXTINI: ld	a,(ix+0)
        and	0F0H
        rrca
        rrca
        rrca
        rrca
        ld	l,a
        ld	a,(ix+1)
        and	0F0H
        or	l
        ld	l,a
        ld	a,(ix+2)
        and	0F0H
        rrca
        rrca
        rrca
        rrca
        ld	h,a
        call	A2B33
        inc	ix
        inc	ix
        inc	ix
        djnz	NXTINI
        pop	bc
        djnz	NXTFAD
        ei
        ret

MAKLIN: push	hl
        ld	hl,BUF+48
        ld	de,BUF+48+1
        ld	bc,66-1
        ld	(hl),0
        ldir
        pop	hl
        ld	ix,BUF+48
        ld	d,4
        xor	a
        ld	c,3
NXTLIN: push	af
        ld	a,c
        xor	3
        ld	c,a
        pop	af
        ld	b,(hl)
        inc	hl
        inc	b
        djnz	CNTLIN
ENDLIN: rlca
        rlca
        dec	d
        jr	nz,ENDLIN
        ld	(ix+0),a
        ret
CNTLIN: rlca
        rlca
        add	a,c
        dec	d
        jr	nz,NOBYT
        ld	(ix+0),a
        inc	ix
        xor	a
        ld	d,4
NOBYT:	djnz	CNTLIN
        jr	NXTLIN



LOGCPY: dw	124
        dw	96
        dw	264
        dw	58
        db	0
        db	0
        db	11110000B

WINCPY: dw	104
        dw	86
        dw	304
        dw	78
        db	00000000B
        db	0
        db	11000000B

A2AC2:	push	bc
        push	af
        di
        ld	C,099H
        out	(C),E
        ld	A,D
        or	080H
        ex	(SP),HL
        ex	(SP),HL
        out	(C),A
        ei
        pop	af
        pop	bc
        ret
;
A2AFF:	ld	A,002H
        call	A1CF9		; bank 2 clockchip
        ld	B,00BH
        call	A1CD2		; read #11 clockchip
        rlca
        and	006H
        ld	C,A
        ld	B,000H
        ld	hl,T2B5F
        add	hl,bc
        add	hl,bc
        add	hl,bc
        ld	de,BUF+0
        ld	bc,2*3
        ldir
        ld	hl,DEFCLR
        ld	bc,2*3
        ldir
        ld	h,d
        ld	l,e
        inc	de
        ld	(hl),0
        ld	bc,4*3-1
        ldir
        ld	de,01000H
        call	A2AC2		; write VDP reg 16 =0
        ld	hl,0
        call	A2B33		; set color 0
        call	A2B33		; set color 1
        call	A2B33		; set color 2
                                ; set color 3
A2B33:	push	bc
        ld	C,09AH
        di
        out	(C),L
        ex	(SP),HL
        ex	(SP),HL
        out	(C),H
        ei
        pop	bc
        ret
;
A2B40:	ld	B,008H
        ld	hl,T2B4F
A2B45:	ld	D,(HL)
        inc	HL
        ld	E,(HL)
        inc	HL
        call	A2AC2
        djnz	A2B45
        ret
;
T2B4F:	DB	0,008H		; M5=1 (screen 6)
        DB	1,020H		; IE0=1
        DB	8,02AH		; TP=1,VRS=10,SPD=1
        DB	9,002H		; PAL=1, was DB 9,000H
        DB	2,01FH
        DB	5,0F7H
        DB	11,000H
        DB	6,00EH

T2B5F:	DB	000H,000H,000H
        DB	007H,000H,000H

        DB	007H,002H,002H
        DB	000H,002H,004H

        DB	006H,005H,000H
        DB	002H,007H,002H

        DB	000H,007H,000H
        DB	000H,007H,005H

DEFCLR: DB	004H,004H,004H
        DB	007H,007H,007H

; Startup screen data

; ULTRASOFT + MSX LOGO (264 * 58)
;
; Syntax: offlen, onlen .... 0

LOGDAT: db	006H,007H,00DH,007H,003H,007H,009H,01AH
        db	004H,015H,015H,006H,017H,013H,00CH,011H
        db	010H,011H,004H,01AH,000H
        db	006H,007H,00DH,007H,003H,007H,009H,01AH
        db	004H,018H,011H,008H,013H,016H,00AH,015H
        db	00BH,014H,004H,01AH,000H
        db	006H,007H,00DH,007H,003H,007H,009H,01AH
        db	004H,019H,00EH,00BH,010H,018H,008H,018H
        db	008H,016H,004H,01AH,000H
        db	005H,007H,00EH,006H,003H,007H,014H,006H
        db	00EH,006H,00CH,008H,00CH,00DH,00DH,009H
        db	019H,007H,00BH,007H,006H,008H,01DH,006H
        db	000H
        db	005H,007H,00DH,007H,003H,007H,013H,007H
        db	00DH,007H,00EH,006H,00BH,00FH,00BH,008H
        db	01AH,007H,00EH,005H,005H,007H,01EH,007H
        db	000H
        db	005H,007H,00DH,007H,003H,007H,013H,006H
        db	00EH,007H,00EH,006H,00AH,007H,003H,006H
        db	00AH,007H,01BH,007H,00FH,006H,004H,006H
        db	01FH,006H,000H
        db	005H,007H,00DH,007H,003H,007H,013H,006H
        db	00EH,007H,00DH,007H,009H,007H,004H,007H
        db	009H,007H,01BH,006H,010H,006H,003H,007H
        db	01FH,006H,000H
        db	004H,007H,00DH,007H,003H,007H,013H,007H
        db	00DH,007H,00CH,008H,009H,007H,006H,006H
        db	009H,009H,018H,007H,00FH,007H,003H,006H
        db	01FH,007H,000H
        db	004H,007H,00DH,007H,003H,007H,013H,006H
        db	00EH,01AH,009H,007H,007H,006H,00AH,015H
        db	00AH,007H,010H,006H,003H,018H,00EH,006H
        db	000H
        db	004H,007H,00DH,007H
        db	003H,007H,012H,007H,00EH,017H,00BH,008H
        db	007H,007H,00AH,016H,008H,007H,010H,006H
        db	003H,018H,00DH,007H,000H
        db	004H,006H,00EH,007H,003H,006H,013H,007H
        db	00DH,015H,00EH,007H,009H,006H,00CH,016H
        db	006H,006H,010H,007H,003H,018H,00DH,007H
        db	000H
        db	004H,006H,00DH,007H,004H,006H,013H,007H
        db	00DH,015H,00DH,007H,00AH,007H,00EH,014H
        db	005H,006H,010H,006H,004H,018H,00DH,007H
        db	000H
        db	003H,007H,00DH,007H,003H,007H,013H,006H
        db	00EH,007H,007H,008H,00BH,019H,01BH,008H
        db	003H,007H,010H,006H,003H,007H,01FH,006H
        db	000H
        db	003H,007H,00DH,007H,003H,007H,012H,007H
        db	00EH,007H,009H,007H,00AH,01AH,01CH,006H
        db	003H,006H,010H,006H,004H,007H,01EH,007H
        db	000H
        db	003H,007H,00CH,008H,003H,007H,012H,007H
        db	00EH,007H,00AH,007H,008H,01BH,01CH,006H
        db	003H,006H,010H,006H,004H,007H,01EH,007H
        db	000H
        db	003H,008H,009H,009H,004H,007H,012H,006H
        db	00EH,007H,00CH,007H,006H,006H,00FH,007H
        db	01AH,007H,004H,006H,00FH,006H,004H,007H
        db	01FH,006H,000H
        db	004H,018H,005H,008H,011H,006H,00EH,007H
        db	00CH,007H,005H,007H,010H,007H,016H,009H
        db	006H,006H,00CH,007H,005H,007H,01FH,006H
        db	000H
        db	004H,016H,008H,012H,005H,007H,00EH,007H
        db	00DH,007H,003H,007H,011H,007H,005H,018H
        db	008H,018H,006H,007H,01EH,007H,000H
        db	005H,013H,00BH,011H,005H,006H,00EH,007H
        db	00EH,007H,003H,006H,012H,008H,004H,016H
        db	00CH,014H,008H,006H,01FH,006H,000H
        db	007H,00EH,010H,00FH,005H,006H,00EH,007H
        db	00EH,007H,003H,006H,013H,007H,004H,013H
        db	011H,010H,00AH,006H,01FH,006H,000H
        db	000H
        db	000H
        db	000H
        db	000H
        db	000H
        db	000H
        db	000H
        db	03BH,00FH,00EH,00FH,015H,037H,016H,014H
        db	000H
        db	03AH,010H,00DH,010H,011H,03CH,013H,015H
        db	000H
        db	03AH,011H,00CH,011H,00DH,040H,011H,014H
        db	000H
        db	039H,012H,00BH,012H,00BH,044H,00EH,014H
        db	000H
        db	039H,013H,00AH,013H,009H,046H,00BH,014H
        db	000H
        db	038H,014H,009H,014H,008H,049H,008H,014H
        db	000H
        db	038H,015H,008H,015H,006H,04BH,005H,014H
        db	000H
        db	037H,016H,007H,016H,005H,04EH,002H,014H
        db	000H
        db	037H,017H,006H,017H,004H,011H,02AH,028H
        db	000H
        db	036H,018H,005H,018H,004H,010H,02CH,025H
        db	000H
        db	036H,019H,004H,019H,003H,011H,02DH,022H
        db	000H
        db	035H,01AH,003H,01AH,003H,022H,01DH,01FH
        db	000H
        db	035H,01BH,002H,01BH,003H,026H,01AH,01CH
        db	000H
        db	034H,039H,004H,028H,018H,019H,000H
        db	034H,03AH,004H,02AH,017H,016H,000H
        db	033H,03BH,005H,02AH,016H,015H,000H
        db	033H,03CH,006H,02AH,013H,018H,000H
        db	032H,010H,002H,01AH,002H,00FH,009H,028H
        db	010H,01BH,000H
        db	032H,010H,002H,01AH,002H,010H,00CH,025H
        db	00EH,01EH,000H
        db	031H,010H,004H,018H,004H,00FH,01EH,013H
        db	00DH,020H,000H
        db	031H,010H,004H,018H,004H,010H,020H,010H
        db	00BH,023H,000H
        db	030H,010H,006H,016H,006H,00FH,020H,010H
        db	00AH,026H,000H
        db	030H,010H,006H,016H,006H,010H,01CH,013H
        db	008H,014H,001H,014H,000H
        db	02FH,010H,008H,014H,008H,03EH,007H,014H
        db	004H,014H,000H
        db	02FH,010H,008H,014H,008H,03DH,006H,015H
        db	006H,014H,000H
        db	02EH,010H,00AH,012H,00AH,03BH,006H,014H
        db	009H,015H,000H
        db	02EH,010H,00AH,012H,00AH,039H,006H,015H
        db	00CH,014H,000H
        db	02DH,010H,00CH,010H,00CH,037H,006H,014H
        db	00FH,015H,000H
        db	02DH,010H,00CH,010H,00CH,035H,007H,014H
        db	012H,014H,000H
        db	02CH,010H,00EH,00EH,00EH,030H,009H,014H
        db	015H,014H,000H
        db	02CH,010H,00EH,00EH,00EH,02BH,00DH,014H
        db	018H,014H,000H
;
;
;
A2EB9:	ld	bc,(BUF+12)
        ld	de,(BUF+14)
        call	A3376
        ret	C
        call	A2980		; wait _CE
        ld	A,020H
        call	A336E
        ld	hl,0F562H
        ld	bc,00E9BH
        otir
        ld	A,(HL)
        and	00FH
        or	090H
        out	(C),A
        ei
        and	A
        ret
;
A2EDF:	call	A3320
        ld	A,(SCRMOD)
        sub	006H
        jr	C,A2EFA
        jr	Z,A2F1B
        dec	A
        jr	Z,A2EFA
A2EEE:	call	A3354
        ld	(HL),A
        inc	HL
        dec	BC
        ld	A,C
        or	B
        jp	NZ,A2EEE
        ret
;
A2EFA:	ld	D,002H
        ld	(HL),000H
A2EFE:	call	A2F13
        call	A3354
        or	(HL)
        ld	(HL),A
        dec	BC
        ld	A,C
        or	B
        jr	Z,A2F11
        dec	D
        jr	NZ,A2EFE
        inc	HL
        jr	A2EFA
;
A2F11:	dec	D
        ret	Z
A2F13:	ld	A,(HL)
        add	A,A
        add	A,A
        add	A,A
        add	A,A
        ld	(HL),A
        and	A
        ret
;
A2F1B:	ld	D,004H
        ld	(HL),000H
A2F1F:	ld	A,(HL)
        add	A,A
        add	A,A
        ld	(HL),A
        call	A3354
        or	(HL)
        ld	(HL),A
        dec	BC
        ld	A,C
        or	B
        jr	NZ,A2F31
        or	E
        jr	Z,A2F37
        dec	E
A2F31:	dec	D
        jr	NZ,A2F1F
        inc	HL
        jr	A2F1B
;
A2F37:	dec	D
        ret	Z
        ld	A,(HL)
A2F3A:	add	A,A
        add	A,A
        dec	D
        jr	NZ,A2F3A
        ld	(HL),A
        and	A
        ret
;
A2F42:	call	A32C9
        ret	C
        call	A2980		; wait _CE
        ld	A,020H
        call	A336E
        push	bc
        ld	hl,0F562H
        ld	bc,00E9BH
        otir
        pop	bc
        ld	A,(HL)
        and	00FH
        or	0B0H
        pop	hl
        push	af
        ld	A,(SCRMOD)
        sub	006H
        jr	C,A2F92
        jr	Z,A2FD4
        dec	A
        jr	Z,A2F92
        call	A336C
        ld	A,(BUF+74)
        ld	E,A
        and	A
        call	NZ,A33A2
        ld	A,(HL)
        out	(09BH),A
        pop	af
        out	(099H),A
        ld	A,0AEH
        out	(099H),A
        ei
A2F81:	dec	BC
        ld	A,C
        or	B
        ret	Z
        inc	HL
        ld	A,E
        and	A
        call	NZ,A33A2
        jr	C,A2F81
        ld	A,(HL)
        out	(09BH),A
        jr	A2F81
;
A2F92:	call	A336C
        ld	D,00FH
        ld	A,(BUF+74)
        ld	E,A
        and	A
        call	NZ,A33A2
        ld	A,(HL)
        RRCA
        RRCA
        RRCA
        RRCA
        and	D
        out	(09BH),A
        pop	af
        out	(099H),A
        ld	A,0AEH
        out	(099H),A
        ei
A2FAF:	dec	BC
        ld	A,C
        or	B
        ret	Z
        ld	A,E
        and	A
        call	NZ,A33A2
        jr	C,A2FBE
        ld	A,(HL)
        and	D
        out	(09BH),A
A2FBE:	inc	HL
        dec	BC
        ld	A,C
        or	B
        ret	Z
        ld	A,E
        and	A
        call	NZ,A33A2
        jr	C,A2FAF
        ld	A,(HL)
        RRCA
        RRCA
        RRCA
        RRCA
        and	D
        out	(09BH),A
        jr	A2FAF
;
A2FD4:	call	A336C
        ld	D,003H
        ld	A,(BUF+74)
        and	A
        call	NZ,A33A2
        ld	A,(HL)
        RRCA
        RRCA
        and	D
        out	(09BH),A
        pop	af
        out	(099H),A
        ld	A,0AEH
        out	(099H),A
        ei
A2FEE:	dec	BC
        ld	A,C
        or	B
        jp	NZ,A2FF7
        or	E
        ret	Z
        dec	E
A2FF7:	ld	A,(BUF+74)
        and	A
        call	NZ,A33A2
        jr	C,A3008
        ld	A,(HL)
        RRCA
        RRCA
        RRCA
        RRCA
        and	D
        out	(09BH),A
A3008:	dec	BC
        ld	A,C
        or	B
        jp	NZ,A3011
        or	E
        ret	Z
        dec	E
A3011:	ld	A,(BUF+74)
        and	A
        call	NZ,A33A2
        jr	C,A3020
        ld	A,(HL)
        RRCA
        RRCA
        and	D
        out	(09BH),A
A3020:	dec	BC
        ld	A,C
        or	B
        jp	NZ,A3029
        or	E
        ret	Z
        dec	E
A3029:	ld	A,(BUF+74)
        and	A
        call	NZ,A33A2
        jr	C,A3036
        ld	A,(HL)
        and	D
        out	(09BH),A
A3036:	dec	BC
        ld	A,C
        or	B
        jp	NZ,A303F
        or	E
        ret	Z
        dec	E
A303F:	inc	HL
        ld	A,(BUF+74)
        and	A
        call	NZ,A33A2
        jr	C,A2FEE
        ld	A,(HL)
        RLCA
        RLCA
        and	D
        out	(09BH),A
        jp	A2FEE
;
A3052:	ld	hl,0
        ld	A,010H
        and	A
A3058:	push	af
        add	HL,HL
        jr	NC,A305F
        pop	af
        SCF
        push	af
A305F:	ex	DE,HL
        add	HL,HL
        ex	DE,HL
        jr	NC,A306A
        add	HL,BC
        jr	NC,A306A
        pop	af
        SCF
        push	af
A306A:	pop	af
        dec	A
        jr	NZ,A3058
        ret
;
A306F:	push	hl
        call	A32BB
        pop	hl
        inc	HL
        inc	HL
        inc	HL
        inc	HL
        ld	E,000H
        jr	A3087
;
A307C:	push	hl
        inc	HL
        inc	HL
        inc	HL
        inc	HL
        call	A32BB
        pop	hl
        ld	E,001H
A3087:	push	de
        ld	C,(HL)
        inc	HL
        ld	B,(HL)
        inc	HL
        ld	E,(HL)
        inc	HL
        ld	D,(HL)
        ex	DE,HL
        and	A
        sbc	HL,BC
        inc	HL
        pop	de
        push	de
        call	A33C7
        pop	de
        dec	E
        push	af
        call	NZ,A3444
        pop	af
        call	Z,A3433
        call	A3457
        and	A
        ret
;
A30A8:	push	hl
        call	A32BB
        ld	hl,0
        ld	E,L
        call	A33C7
        call	A3444
        ld	(BUF+23),HL
        ld	de,(BUF+19)
        pop	hl
        ld	(HL),E
        inc	HL
        ld	(HL),D
        dec	HL
        call	A32C9
        jr	C,A30F3
        call	A2980		; wait _CE
        ld	A,020H
        call	A336E
        push	bc
        ld	hl,0F562H
        ld	bc,00E9BH
        otir
        pop	bc
        ld	A,(HL)
        and	00FH
        or	0B0H
        ld	hl,T30F2
        ex	(SP),HL
        push	af
        ld	A,(SCRMOD)
        sub	006H
        jr	C,A311C
        jp	Z,A315C
        dec	A
        jr	Z,A311C
        jr	A30F9
;
T30F2:	and	A
A30F3:	push	af
        call	A3457
        pop	af
        ret
;
A30F9:	call	A336C
        call	A339D
        ld	A,(HL)
D3100:	out	(09BH),A
        pop	af
        out	(099H),A
        ld	A,0AEH
        out	(099H),A
        ei
A310A:	dec	BC
        ld	A,C
        or	B
        ret	Z
        inc	HL
        call	A3279
        call	A339D
        jr	C,A310A
        ld	A,(HL)
        out	(09BH),A
        jr	A310A
;
A311C:	call	A336C
        ld	D,000H
        call	A339D
        ld	A,(HL)
        RRCA
        RRCA
        RRCA
        RRCA
        and	00FH
        out	(09BH),A
        pop	af
        out	(099H),A
        ld	A,0AEH
        out	(099H),A
        ei
A3135:	inc	D
        dec	BC
        ld	A,C
        or	B
        jr	NZ,A313E
        or	E
        ret	Z
        dec	E
A313E:	call	A3279
        ld	A,D
        RRCA
        ld	A,(HL)
        inc	HL
        jr	C,A314C
        dec	HL
        RRCA
        RRCA
        RRCA
        RRCA
A314C:	push	af
        call	A339D
        jr	C,A3159
        pop	af
        and	00FH
        out	(09BH),A
        jr	A3135
;
A3159:	pop	af
        jr	A3135
;
A315C:	call	A336C
        ld	D,000H
        call	A339D
        ld	A,(HL)
        RRCA
        RRCA
        and	003H
        out	(09BH),A
        pop	af
        out	(099H),A
        ld	A,0AEH
        out	(099H),A
        ei
A3173:	inc	D
        dec	BC
        ld	A,C
        or	B
        jr	NZ,A317C
        or	E
        ret	Z
        dec	E
A317C:	call	A3279
        ld	A,D
        and	003H
        jr	Z,A3197
        dec	A
        jr	Z,A319F
        dec	A
        jr	Z,A319A
        call	A339D
        jr	C,A3194
        ld	A,(HL)
        and	003H
        out	(09BH),A
A3194:	inc	HL
        jr	A3173
;
A3197:	ld	A,(HL)
        jr	A31A2
;
A319A:	ld	A,(HL)
        RRCA
        RRCA
        jr	A31A4
;
A319F:	ld	A,(HL)
        RLCA
        RLCA
A31A2:	RLCA
        RLCA
A31A4:	push	af
        call	A339D
        jr	C,A31B1
        pop	af
        and	003H
        out	(09BH),A
        jr	A3173
;
A31B1:	pop	af
        jr	A3173
;
A31B4:	push	hl
        inc	HL
        inc	HL
        inc	HL
        inc	HL
        push	hl
        call	A32BB
        ld	hl,0
        ld	E,001H
        call	A33C7
        ld	de,(BUF+19)
        pop	hl
        ld	(HL),E
        inc	HL
        ld	(HL),D
        pop	hl
        call	A3320
        ld	A,(SCRMOD)
        sub	006H
        jr	C,A31ED
        jr	Z,A3227
        dec	A
        jr	Z,A31ED
A31DD:	call	A3292
        call	A3354
        ld	(HL),A
        inc	HL
        dec	BC
        ld	A,C
        or	B
        jr	NZ,A31DD
        jp	A3270
;
A31ED:	ld	D,000H
A31EF:	call	A3292
        ld	A,007H
        di
        out	(099H),A
        ld	A,08FH
        out	(099H),A
        push	hl
        pop	hl
        ld	A,D
        RRCA
        in	A,(099H)
        jr	NC,A3208
        or	(HL)
        ld	(HL),A
        inc	HL
        jr	A320D
;
A3208:	add	A,A
        add	A,A
        add	A,A
        add	A,A
        ld	(HL),A
A320D:	xor	A
        out	(099H),A
        ld	A,08FH
        out	(099H),A
        ei
        inc	D
        dec	BC
        ld	A,C
        or	B
        jr	NZ,A31EF
        or	E
        jr	Z,A3221
        dec	E
        jr	A31EF
;
A3221:	ld	A,D
        RRCA
        jr	C,A3271
        jr	A3270
;
A3227:	ld	D,000H
A3229:	call	A3292
        ld	A,007H
        di
        out	(099H),A
        ld	A,08FH
        out	(099H),A
        push	hl
T3236:	pop	hl
        ld	A,D
        and	003H
        jr	Z,A3249
        dec	A
        jr	Z,A324F
        dec	A
        in	A,(099H)
        jr	Z,A3253
        or	(HL)
        ld	(HL),A
        inc	HL
        jr	A3257
;
A3249:	in	A,(099H)
        RRCA
        RRCA
        jr	A3256
;
A324F:	in	A,(099H)
        RLCA
        RLCA
A3253:	RLCA
        RLCA
        or	(HL)
A3256:	ld	(HL),A
A3257:	xor	A
        out	(099H),A
        ld	A,08FH
        out	(099H),A
        ei
        inc	D
        dec	BC
        ld	A,C
        or	B
        jr	NZ,A3229
        or	E
        jr	Z,A326B
        dec	E
        jr	A3229
;
A326B:	ld	A,D
        and	003H
        jr	NZ,A3271
A3270:	dec	HL
A3271:	call	A32B0
        call	A3457
        and	A
        ret
;
A3279:	push	de
        push	hl
        ld	hl,(BUF+19)
        ld	de,(BUF+23)
        add	HL,DE
        ex	DE,HL
        pop	hl
        RST	020H
        pop	de
        ret	C
        push	bc
        push	de
        call	A3444
        ld	(BUF+23),HL
        jr	A32AA
;
A3292:	push	de
        push	hl
        ld	hl,(BUF+19)
        ld	de,(BUF+21)
        add	HL,DE
        ex	DE,HL
        pop	hl
        RST	020H
        pop	de
        ret	C
        ld	hl,(BUF+21)
        push	bc
        push	de
        call	A3436
        and	A
A32AA:	pop	de
        pop	bc
        ld	hl,(BUF+19)
        ret
;
A32B0:	ld	de,(BUF+19)
        and	A
        sbc	HL,DE
        inc	HL
        jp	A3436
;
A32BB:	ld	A,(HL)
        inc	HL
        ld	H,(HL)
        ld	L,A
        call	A05BA		; eval filespec
        ld	A,D
A32C3:	cp	009H
        ret	C
        jp	A052E		; bad filename
;
A32C9:	ld	hl,(BUF+4)
        ld	C,(HL)
        inc	HL
        ld	B,(HL)
        inc	HL
        ld	E,(HL)
        inc	HL
        ld	D,(HL)
        inc	HL
        call	A3376
        ret	C
        push	hl
        push	bc
        push	de
        ld	hl,(BUF+8)
        ld	A,(BUF+17)
        and	004H
        jr	NZ,A32ED
        ex	DE,HL
        call	A3390
        and	A
        sbc	HL,DE
        db	03EH
A32ED:	inc	hl
        ld	(BUF+66),HL
        ld	(BUF+68),HL
        ld	D,B
        ld	E,C
        ex	DE,HL
        sbc	HL,DE
        jr	NC,A32FE
        ld	hl,0
A32FE:	ld	(BUF+70),HL
        ld	(BUF+72),HL
        ld	A,H
        or	L
T3306:	ld	(BUF+74),A
        pop	de
        pop	bc
        ld	(BUF+12),BC
        ld	(BUF+14),DE
        call	A3052
        ld	B,H
        ld	C,L
        ld	A,000H
        adc	A,A
        ld	E,A
        and	A
        pop	hl
        ex	(SP),HL
        jp	(HL)
;
A3320:	call	A2980		; wait _CE
        ld	A,020H
        call	A336E
        ld	hl,0F562H
        ld	bc,00E9BH
        otir
        ld	A,0A0H
        out	(C),A
        ei
        ld	bc,(BUF+12)
        ld	de,(BUF+14)
        ld	hl,(BUF+8)
        ld	(HL),C
        inc	HL
        ld	(HL),B
        inc	HL
        ld	(HL),E
        inc	HL
        ld	(HL),D
        inc	HL
        push	hl
        call	A3052
        ld	B,H
        ld	C,L
        ld	A,000H
        adc	A,A
        ld	E,A
        pop	hl
        ret
;
A3354:	di
        ld	A,007H
        out	(099H),A
        ld	A,08FH
        out	(099H),A
        push	hl
        pop	hl
        in	A,(099H)
        push	af
        xor	A
        out	(099H),A
        ld	A,08FH
        out	(099H),A
        pop	af
        ei
        ret
;
A336C:	ld	A,0ACH
A336E:	di
        out	(099H),A
        ld	A,091H
        out	(099H),A
        ret
;
A3376:	ld	A,B
        or	C
        SCF
        ret	Z
        ld	A,D
        or	E
        SCF
        ret	Z
        push	hl
        push	de
        ld	E,C
        ld	D,B
        call	A3390
        RST	020H
        pop	de
        pop	hl
        ret	C
        push	hl
        ld	hl,000D4H
        RST	020H
        pop	hl
        ret
;
A3390:	ld	hl,00100H
        ld	A,(SCRMOD)
        and	006H
        cp	006H
        ret	NZ
        inc	H
        ret
;
A339D:	ld	A,(BUF+74)
        and	A
        ret	Z
A33A2:	push	hl
        ld	hl,(BUF+68)
        ld	A,L
        or	H
        jr	Z,A33B0
        dec	HL
        ld	(BUF+68),HL
        pop	hl
        ret
;
A33B0:	ld	hl,(BUF+72)
        dec	HL
        ld	A,L
        or	H
        jr	NZ,A33C1
        ld	hl,(BUF+66)
        ld	(BUF+68),HL
        ld	hl,(BUF+70)
A33C1:	ld	(BUF+72),HL
        pop	hl
        SCF
        ret
;
A33C7:	ld	A,(H.PHYD+0)
        cp	0C9H		; disksystem ?
        jp	Z,A0546 	; nop, illegal function call
        push	bc
        push	hl
        ld	hl,0F577H
        push	hl
        ld	(HL),D
        ld	A,E
        and	A
        push	af
        ex	DE,HL
        inc	DE
        ld	hl,FILNAM
        ld	bc,0000BH
        ldir
        xor	A
        ld	B,019H
A33E6:	ld	(DE),A
        inc	DE
        djnz	A33E6
        pop	af
        pop	de
        push	af
        ld	C,00FH		; _FOPEN
        jr	Z,A33F3
        ld	C,016H		; _FMAKE
A33F3:	call	A345C		; B.BDOS
        inc	A
        jr	NZ,A3401
        pop	af
        jp	Z,A055E 	; file not found
        ld	E,043H
        jr	A3454
;
A3401:	ld	hl,00001H
        ld	(BUF+25+14),HL
        pop	af
        pop	hl
        pop	de
        ld	A,H
        or	L
        jr	NZ,A3428
        ld	hl,0FE00H
        add	HL,SP
T3412:	jr	NC,A3421
        ld	de,(STREND)
        and	A
        sbc	HL,DE
        jr	C,A3421
        ld	A,H
        and	A
        jr	NZ,A3428
A3421:	ld	de,(NULBUF)
        ld	hl,00100H
A3428:	ld	(BUF+19),DE
        ld	(BUF+21),HL
        ld	C,01AH		; _SETDTA
        jr	A345C		; B.BDOS
;
A3433:	ld	hl,(BUF+21)
A3436:	ld	de,0F577H
        ld	C,026H		; _WRBLK
        call	A345C		; B.BDOS
        and	A
        ret	Z
        ld	E,042H
        jr	A3454
;
A3444:	ld	hl,(BUF+21)
        ld	de,0F577H
        ld	C,027H		; _RDBLK
        call	A345C		; B.BDOS
        ld	A,L
        or	H
        ret	NZ
        ld	E,037H
A3454:	jp	A05C6		; error
;
A3457:	ld	de,0F577H
        ld	C,010H		; _FCLOSE
A345C:	ld	ix,07FFDH	; MAINROM BDOS entry point
        jp	A0262		; CALSLT MAINROM
;
A3463:	ld	B,000H
        and	07FH
        ld	C,A
        sbc	HL,BC
        ret
;
A346B:	in	A,(0BAH)
        cpl
        and	008H
        ret	Z
        ld	A,0FFH
        ret
;
A3474:	ld	hl,0FAFFH
        xor	A
        bit	7,(HL)
        ret	Z
        RES	7,(HL)
        in	A,(0BAH)
        and	007H
        ld	D,A
        in	A,(0B8H)
        ld	L,A
        ld	H,000H
        in	A,(0B9H)
        SRL	D
        RRA
        ld	E,A
        RL	H
        push	hl
        push	de
        ld	bc,0FFFDH
        add	HL,BC
        ex	DE,HL
        ld	C,0EEH
        add	HL,BC
        ld	A,E
        out	(0B8H),A
        RR	D
        adc	HL,HL
        ld	A,L
        out	(0B9H),A
        ld	A,H
        out	(0BAH),A
        pop	de
        pop	hl
        in	A,(0BAH)
        and	020H
        ret	Z
        ld	A,(YFB01)
        call	A3463
        ld	bc,000D3H
        call	A34C7
        ld	A,L
        ld	(YFB00),A
        ex	DE,HL
        ld	A,(YFAFF)
        call	A3463
        ld	bc,000FFH
A34C7:	ld	A,H
        RLA
        jr	C,A34D4
        push	hl
        sbc	HL,BC
        pop	hl
        jr	C,A34D6
        ld	L,C
        ld	H,B
        DB	0DAH
A34D4:	ld	L,0
A34D6:	ld	A,L
        ld	(YFAFE),A
        ld	A,0FFH
        ret
;
A34DD:	cp	008H
        jr	Z,A3474 	; read lightpen
        cp	00BH
        jr	Z,A346B 	; get lightpen status
        ld	E,00FH	; reg 15
        ld	bc,0000000010111111b
        ld	hl,0001000011101111b
        cp	00CH
        jr	Z,A3509 	; read mouse/trackball 1
        ld	bc,0100000011111111b
        ld	hl,0010000011011111b
        cp	010H
        jr	Z,A3509 	; read mouse/trackball 2
        and	003H
        sub	002H
        ld	A,(YFAFE)
        ret	M		; get X coordinate
        ld	A,(YFB00)
        ret	Z		; get Y coordinate
        xor	A		; no function
        ret
;
A3509:	di
        call	A357F		; pulse low
        call	A359A		; read input
        push	af
        call	A3585		; pulse high
        call	A3591		; wait 3 & read input
        push	af
        call	A357F		; pulse low
        call	A3597		; wait 1 & read input
        push	af
        call	A3585		; pulse high
        call	A3597		; wait 1 & read input
        push	af
        call	A357F		; pulse low
        call	A3597		; wait 1 & read input
        push	af
        call	A3585		; pulse high
        call	A3591		; wait 3 & read input
        push	af
        call	A357F		; pulse low
        call	A35AA		; wait 1
        call	A3585		; pulse high
        call	A35AA		; wait 1
        call	A357F		; pulse low
        ei
        pop	af
        pop	hl
        pop	de
        pop	bc
        xor	008H
        sub	002H
        cp	00DH
        jr	C,A355D
        pop	af
        call	A3577
        ld	(YFB00),A
        pop	af
        call	A3577
        jr	A3571
;
A355D:	ld	A,D
        add	A,A
        add	A,A
        add	A,A
        add	A,A
        or	H
        neg
        ld	(YFB00),A
        pop	af
        pop	de
        add	A,A
        add	A,A
        add	A,A
        add	A,A
        or	B
        neg
A3571:	ld	(YFAFE),A
        ld	A,0FFH
        ret
;
A3577:	xor	008H
        bit	3,A
        ret	Z
        or	0F0H
        ret
;
A357F:	call	A35A2
        and	L
        jr	A3589
;
A3585:	call	A35A2
        or	H
A3589:	push	af
        ld	A,E
        out	(0A0H),A
        pop	af
        out	(0A1H),A
        ret
;
A3591:	call	A35AA		; wait
        call	A35AA		; wait
A3597:	call	A35AA		; wait
A359A:	ld	A,00EH
        call	A35A3		; read input
        and	00FH
        ret
;
A35A2:	ld	A,E
A35A3:	out	(0A0H),A
        in	A,(0A2H)
        and	C
        or	B
        ret
;
A35AA:	ex	(SP),HL
        ex	(SP),HL
        ex	(SP),HL
        ex	(SP),HL
        ret
;
A35AF:	cp	02CH
        jr	Z,A35EF
        RST	028H		; eval byte
        cp	004H
        jr	NC,A3635
        and	A
        jr	Z,A35C2
        cp	001H
        jr	Z,A35C2
        ld	E,000H
        dec	A
A35C2:	push	de
        RRCA
        RRCA
        ld	D,A
        RRCA
        RRCA
        ld	E,A
        ld	A,(RG9SAV)
        and	0CFH
        or	E
        ld	C,009H
        call	A36B4
        ld	A,D
        xor	0C0H
        ld	E,A
        ld	A,03FH
        call	A3661
        pop	de
        ld	A,E
        RRCA
        RRCA
        RRCA
        ld	E,A
        ld	A,(RG8SAV)
        and	0DFH
        or	E
        call	A36B2
        dec	HL
        RST	010H
        ret	Z
A35EF:	RST	008H
        DB	','
        cp	02CH
        jr	Z,A3600
        call	A366C
        ld	A,0DFH
        call	A3661
        dec	HL
        RST	010H
        ret	Z
A3600:	RST	008H
        DB	','
        cp	02CH
        jr	Z,A3617
        call	A366C
        RRC	E
        ld	A,(RG8SAV)
        and	0EFH
        or	E
        call	A36B2
        dec	HL
        RST	010H
        ret	Z
A3617:	RST	008H
        DB	','
        cp	02CH
        jr	Z,A362C
        call	A366C
        RLCA
        RLCA
        RLCA
        ld	E,A
        ld	A,0F7H
        call	A3661
        dec	HL
        RST	010H
        ret	Z
A362C:	RST	008H
        DB	','
        cp	02CH
        jr	Z,A3644

; The following was:
; call	A3CCD

        RST	028H
        cp	004H
A3635:	jp	NC,A0546	; illegal function call
        cpl
        and	003H
        ld	E,A
        ld	A,0FCH
        call	A3661
        dec	HL
        RST	010H
        ret	Z
A3644:	RST	008H
        DB	','
        cp	02CH
        jr	Z,A3658
        call	A366C
        RLCA
        RLCA
        ld	E,A
        ld	A,0FBH
        call	A3661
        dec	HL
        RST	010H
        ret	Z
A3658:	RST	008H
        DB	','
        call	A366C
        RRC	E
        ld	A,0EFH
A3661:	push	hl
        ld	hl,YFAF7
        and	(HL)
        or	E
        ld	(HL),A
        out	(0F7H),A
        pop	hl
        ret
;
A366C:	RST	028H		; eval byte
        cp	002H
        jr	NC,A3635
        and	A
        ret	Z
        ld	E,020H
        ret
;
A3676:	RST	010H
        jr	Z,A3686
        cp	02CH
        jr	Z,A3686
        call	A366C
        dec	A
        jr	NZ,A3686
        ld	E,000H
        db	001H
A3686:	ld	e,002H
        dec	HL
        RST	010H
        ld	A,0FFH
        jr	Z,A3693
        push	de
        RST	008H
        DB	','
        RST	028H		; eval byte
        pop	de
A3693:	ld	D,A
        ld	A,(RG7SAV)
        push	af
        ld	A,D
        call	A36AE
        call	A36B8
        or	040H
        call	A36B4
        call	A36B8
        ei
        and	0BFH
        call	A36B4
        pop	af
A36AE:	ld	C,007H
        jr	A36B4
;
A36B2:	ld	C,008H
A36B4:	ld	B,A
        jp	A0647		; WRTVDP
;
A36B8:	ld	A,2		; reg 2
        call	A298B		; VDPSTA
        and	040H
        jr	Z,A36B8 	; wait until VR
A36C1:	ld	A,2		; reg 2
        call	A298B		; VDPSTA
        bit	6,A
        jr	NZ,A36C1	; wait until VR passed
        or	E
        and	002H
        jr	Z,A36B8
        ld	A,(RG0SAV)
        ld	C,000H
        ret


; DEVICE handler

A372A:	ei
        inc	a
        jr	nz,A36DF
A36D9:	call	A392C
        ret	z
        scf
        ret
;
A36DF:	push	hl
        ld	hl,T36EE-1
        add	a,l
        ld	l,a
        jr	nc,A36E8
        inc	h
A36E8:	ld	a,(hl)
        inc	hl
        ld	h,(hl)
        ld	l,a
        ex	(sp),hl
T36ED:	ret
;
T36EE:	dw	A3973
        dw	A39FA
        dw	A38B9
        dw	A3A1E
        dw	A3A7C
        dw	A3898
        dw	A38A3
        dw	A38B6
        dw	A38D7
        dw	A3AC8

A3702:	dec	hl
        rst	010H
        ld	de,07FFFH
        jr	z,A3714 	; no parameters, use 32767
        rst	008H
        db	"("
        call	A0608
        jp	m,A0546 	; >32678, illegal
        rst	008H
        db	")"
        ret	nz
A3714:	push	hl
        push	de
        ld	a,(YFD09)
        and	a		; RAM searched ?
        jr	z,A3722 	; nop,
        bit	5,a		; _MEMINI disabled ?
        jr	nz,A3777	; yep, illegal
        jr	A377A

; ----------------------------------------------
; CHANGED BY ULTRASOFT: USE (ONLY) MEMORY MAPPER
; ----------------------------------------------

A3722:	di
        in	a,(0A8H)
        rlca
        rlca
        and	003H
        ld	c,a
        ld	b,0
        ld	hl,EXPTBL
        add	hl,bc
        or	(hl)
        jp	p,nonexp
        ld	c,a
        inc	hl
        inc	hl
        inc	hl
        inc	hl
        ld	a,(hl)
        rlca
        rlca
        rlca
        rlca
        and	00CH
        or	c
nonexp:
        ld	h,000H
nxtkil: ld	l,010H
nxtbyt: push	af
        call	A01FD		; RDSLT
        cpl
        ld	e,a
        pop	af
        push	de
        push	af
        call	A0218		; WRSLT
        pop	af
        pop	de
        push	af
        push	de
        call	A01FD		; RDSLT
        pop	bc
        ld	b,a
        ld	a,c
        cpl
        ld	e,a
        pop	af
        push	af
        push	bc
        call	A0218		; WRSLT
        pop	bc
        ld	a,c
        cp	b
        jp	nz,A3777	; no RAM,
        pop	af
        dec	l
        jr	nz,nxtbyt
        inc	h
        inc	h
        inc	h
        inc	h
        jp	p,nxtkil

        push	af
        ld	hl,YFD09
        ld	a,2
        out	(0FFH),a	; segment 2
        ld	b,(hl)		; save
        ld	(hl),0FFH	; write
        xor	a
        out	(0FFH),a	; segment 0
        cp	(hl)		; memory mapper ?
        ld	a,2
        out	(0FFH),a	; segment 2
        ld	(hl),b		; restore
        ld	a,0
        out	(0FFH),a	; segment 0
        jp	nz,A3777	; no mapper,
        pop	af
        ld	(YFD09),a
        jr	A377A

A3777:	jp	A0546


; ----------------------------------------------
; END OF CHANGE
; ----------------------------------------------

;
A377A:	bit	6,a		; ramdisk already valid ?
        jr	z,A3795 	; nop,
        ld	ix,00100H
        ld	b,020H		; 32 files
A3784:	call	A3AD8		; read DIR entry
        ld	a,(LINWRK+13)
        and	a		; file open ?
        jp	nz,A3BF9	; yep,
        ld	de,00010H
        add	ix,de
        djnz	A3784
A3795:	pop	hl
        xor	a
        ld	de,003FFH
        sbc	hl,de		; use 768 bytes for admin
        jr	c,A3804 	; no UNITS left,
        inc	h
        push	hl
        ld	b,080H		; 128 UNITS
        ld	c,a
        dec	a		; reserved
A37A4:	inc	c
        call	A3AEC		; write FAT entry
        djnz	A37A4
        ld	b,h
        xor	a		; free
        ld	c,a
A37AD:	inc	c
        call	A3AEC		; write FAT entry
        djnz	A37AD
        ld	hl,0FC18H
        ld	de,0FC19H
        ld	c,00FH
        ld	(hl),b
        ldir			; free
        ld	ix,00100H
        ld	b,020H
A37C4:	call	A3AD9		; write DIR entry
        ld	de,00010H
        add	ix,de
        djnz	A37C4
        ld	hl,0FD09H
        set	6,(hl)		; Ramdisk valid
        pop	hl
        ld	l,b		; UNIT = 256 bytes
        push	hl
        call	A05CC		; print size
        call	A388F
        db	" bytes allocated",13,10,0
        pop	hl
        inc	h
        inc	h
        inc	h
        ld	(LINWRK+0),hl
        ld	hl,0FC18H
        ld	de,00000H
        ld	bc,00002H
        call	A3B6A		; write size id
        pop	hl
        ret
;
A3804:	xor	a
        ld	(YFD09),a	; no ramdisk
        call	A388F
        db	"No RAM disk",13,10,0
        pop	hl
        ret
;
A3867:	call	A3BFD
        call	A05AE
        push	hl
        ld	ix,00100H
        ld	bc,02000H
A3829:	call	A3AD8		; read DIR entry
        ld	hl,0FC18H
        ld	a,(hl)
        and	a
        jr	z,A3861
        inc	c
        push	ix
        push	bc
        ld	b,008H
        call	A3889
        ld	a,(hl)
        cp	020H
        jr	z,A3843
        ld	a,02EH
A3843:	rst	018H
        ld	b,003H
        call	A3889
        ld	a,(LINLEN)
        ld	b,a
        ld	a,(TTYPOS)
        and	a
        jr	z,A385E
        add	a,00CH
        cp	b
        jr	nc,A385B
        ld	a,020H
        rst	018H
A385B:	call	nc,A05AE
A385E:	pop	bc
        pop	ix
A3861:	ld	de,00010H
        add	ix,de
        djnz	A3829
        ld	a,c
        or	a
        jp	z,A055E
        call	A05AE
        call	A38D7
        call	A05CC
        call	A388F
        db	" bytes free",13,10,0
        pop	hl
        ret
;
A3889:	ld	a,(hl)
        inc	hl
        rst	018H
        djnz	A3889
        ret
;
A388F:	ex	(sp),hl
        ld	a,(hl)
        inc	hl
        ex	(sp),hl
        and	a
        ret	z
        rst	018H
        jr	A388F
;
A3898:	push	hl
        pop	iy
        ld	h,(iy+005H)
        ld	l,(iy+006H)
        jr	A38E6
;
A38A3:	call	A3ACF
        push	hl
        pop	iy
        ld	a,(hl)
        cp	001H
        ld	hl,(LINWRK+14)
        jr	z,A38E6
        ld	l,(iy+006H)
        jr	A38E6
;
A38B6:	ld	a,(hl)
        cp	001H
A38B9:	ld	e,03DH
        jp	nz,A3C05
        push	hl
        pop	iy
        call	A3ACF
        ld	l,(iy+006H)
        ld	h,(iy+005H)
        ld	de,(LINWRK+14)
        rst	020H
        ld	hl,0FFFFH
        jr	nc,A38E6
        inc	hl
        jr	A38E6
;
A38D7:	ld	bc,07D01H
        ld	hl,00000H
A38DD:	call	A3AEB		; read FAT entry
        jr	nz,A38E3
        inc	h
A38E3:	inc	c
        djnz	A38DD
A38E6:	ld	(DAC+2),hl
        ld	a,002H
        ld	(VALTYP),a
        ret
;
A3978:	call	A3911
        rst	008H
        db	")"
        call	A3BF1
A38F7:	ld	(LINWRK+0),a
        call	A3AD9		; write DIR entry
        ld	a,(LINWRK+11)
        and	a
        ret	z
A3902:	ld	c,a
        call	A3AEB		; read FAT entry
        push	af
        xor	a
        call	A3AEC		; write FAT entry
        pop	af
        cp	0FFH
        jr	nz,A3902
        ret
;
A3911:	rst	008H
        db	"("
        call	A3BFD
A3916:	call	A05BA
        ret	z
        ld	a,d
        cp	0FCH
        jr	nc,A3929
        cp	009H
        jr	c,A3929
        push	hl
        call	A392C
        pop	hl
        ret	z
A3929:	jp	A052E
;
A392C:	ld	hl,0FD89H
        ld	de,T3941
A3932:	ld	a,(de)
        cp	(hl)
        jr	nz,A393C
        inc	hl
        inc	de
        or	a
        jr	nz,A3932
        ret
;
A393C:	sub	030H
        ret	nz
        or	(hl)
        ret
;
T3941:	db	"MEM0",0

A39DD:	call	A3911
        call	A3BF1
        push	ix
        rst	008H
        db	"A"
        rst	008H
        db	"S"
        call	A3916
        rst	008H
        db	")"
        call	A3B0D
        ld	e,041H
        jp	z,A3C05
        pop	ix
        call	A3AD8		; read DIR entry
A3964:	push	hl
        ld	de,0FC18H
        ld	hl,0F866H
        ld	bc,0000BH
        ldir
        pop	hl
        jr	A3995
;
A3973:	call	A3BFD
        call	A3B0D
        push	af
        ld	a,e
        cp	004H
        jp	z,A0534
        cp	002H
        jr	z,A3998
        cp	008H
        jr	z,A39D1
        pop	af
        jr	nz,A39D2
        or	a
        jr	nz,A39D6
        call	A3BD6
A3991:	dec	a
        ld	(LINWRK+13),a
A3995:	jp	A3AD9		; write DIR entry
;
A3998:	pop	af
        jr	nz,A39A1
        or	a
        jr	nz,A39D6
        call	A38F7
A39A1:	ld	ix,00100H
        ld	b,020H
A39A7:	call	A3AD8		; read DIR entry
        ld	a,(LINWRK+0)
        and	a
        jr	z,A39BC
        ld	de,00010H
        add	ix,de
        djnz	A39A7
        ld	e,043H
        jp	A3C05
;
A39BC:	ld	e,002H
        call	A3BD6
        ld	hl,0FC18H
        ld	b,010H
A39C6:	ld	(hl),a
        inc	hl
        djnz	A39C6
        dec	a
        ld	(LINWRK+13),a
        jp	A3964
;
A39D1:	pop	af
A39D2:	jp	nz,A055E
        or	a
A39D6:	jp	nz,A053A
        call	A3BD6
        ld	hl,(LINWRK+14)
        ld	(iy+005H),h
        ld	(iy+006H),l
        ld	l,a
        ld	(LINWRK+14),hl
        call	A3991
        ld	a,(LINWRK+11)
        and	a
        ret	z
        ld	a,(LINWRK+12)
        ld	(iy+007H),a
        jp	A3B51		; read UNIT
;
A39FA:	call	A3ACF
        xor	a
        ld	(LINWRK+13),a
        call	A3AD9		; write DIR entry
        ld	a,(hl)
        cp	001H
        ret	z
        push	hl
        pop	iy
        ld	a,(iy+006H)
        and	a
        ret	z
        call	A3B52		; write UNIT
        ld	hl,(LINWRK+14)
        ld	l,(iy+006H)
        ld	(LINWRK+14),hl
        jr	A3A7A
;
A3A1E:	push	hl
        pop	iy
        ld	a,(iy+006H)
        and	a
        jr	nz,A3A5D
        push	hl
        push	bc
        call	A3ACF
        ld	bc,07D01H
A3A2F:	call	A3AEB		; read FAT entry
        jr	z,A3A3C
        inc	c
        djnz	A3A2F
        ld	e,042H
        jp	A3C05
;
A3A3C:	ld	a,(LINWRK+11)
        and	a
        ld	a,c
        jr	nz,A3A46
        ld	(LINWRK+11),a
A3A46:	ld	c,(iy+007H)
        call	nz,A3AEC	; write FAT entry
        ld	(LINWRK+12),a
        ld	(iy+007H),a
        ld	c,a
        ld	a,0FFH
        call	A3AEC		; write FAT entry
        call	A3AD9		; write DIR entry
        pop	bc
        pop	hl
A3A5D:	ld	de,00009H
        add	hl,de
        ld	e,(iy+006H)
        add	hl,de
        ld	(hl),c
        inc	(iy+006H)
        ret	nz
        call	A3B52		; write UNIT
        inc	(iy+005H)
        push	iy
        pop	hl
        call	A3ACF
        ld	hl,0FC27H
        inc	(hl)
A3A7A:	jr	A3AD9		; write DIR entry
;
A3A7C:	push	hl
        push	hl
        pop	iy
        call	A3ACF
        ld	l,(iy+006H)
        ld	h,(iy+005H)
        ld	de,(LINWRK+14)
        rst	020H
        pop	hl
        ccf
        ret	c
        ld	a,(iy+003H)
        and	a
        ld	(iy+003H),000H
        ret	nz
        ld	a,(iy+006H)
        and	a
        jr	z,A3AAF
        ld	bc,00009H
        add	hl,bc
        ld	c,a
        add	hl,bc
        ld	a,(hl)
        inc	(iy+006H)
        ret	nz
        inc	(iy+005H)
        ret
;
A3AAF:	ld	a,(iy+007H)
        and	a
        ld	c,a
        ld	a,(LINWRK+11)
        call	nz,A3AEB	; read FAT entry
        ld	(iy+007H),a
        call	A3B51		; read UNIT
        ld	a,(iy+009H)
        inc	(iy+006H)
        and	a
        ret
;
A3AC8:	push	hl
        pop	iy
        ld	(iy+003H),c
        ret
;
A3ACF:	inc	hl
        ld	c,(hl)
        inc	hl
        ld	b,(hl)
        push	bc
        pop	ix
        dec	hl
        dec	hl

A3AD8:	db	0F6H
A3AD9:	scf
        push	hl
        push	de
        push	bc
        push	ix
        pop	hl
        ld	de,0FC18H
        jr	nc,A3AE6
        ex	de,hl
A3AE6:	ld	bc,00010H
        jr	A3B02
;
A3AEB:	db	0F6H
A3AEC:	scf
        push	hl
        push	de
        push	bc
        push	af
        ld	hl,0007FH
        ld	b,000H
        add	hl,bc
        ld	de,0FC28H
        pop	af
        jr	nc,A3AFF
        ex	de,hl
        ld	(hl),a
A3AFF:	ld	bc,00001H
A3B02:	call	A3B6A
        pop	bc
        pop	de
        pop	hl
        ld	a,(LINWRK+16)
        and	a
        ret
;
A3B0D:	push	hl
        push	de
        ld	de,0F866H
        ld	b,00BH
A3B14:	ld	a,(de)
        cp	061H
        jr	c,A3B20
        cp	07BH
        jr	nc,A3B20
        and	0DFH
        ld	(de),a
A3B20:	inc	de
        djnz	A3B14
        ld	ix,00100H
        ld	c,020H
A3B29:	call	A3AD8		; read DIR entry
        ld	hl,0FC18H
        ld	a,(hl)
        and	a
        jr	nz,A3B3E
A3B33:	ld	de,00010H
        add	ix,de
        dec	c
        jr	nz,A3B29
        inc	c
        jr	A3B4B
;
A3B3E:	ld	de,0F866H
        ld	b,00BH
A3B43:	ld	a,(de)
        cp	(hl)
        jr	nz,A3B33
        inc	de
        inc	hl
        djnz	A3B43
A3B4B:	pop	de
        pop	hl
        ld	a,(LINWRK+13)
        ret
;
A3B51:	db	0F6H
A3B52:	scf
        push	af
        push	iy
        pop	hl
        ld	bc,00009H
        add	hl,bc
        ld	e,000H
        ld	a,(iy+007H)
        add	a,002H
        ld	d,a
        pop	af
        jr	c,A3B67
        ex	de,hl
A3B67:	ld	bc,00100H


; ----------------------------------------------
; CHANGED BY ULTRASOFT: USE MEMORY MAPPER
; ----------------------------------------------

A3B6A:	di
        exx
        ld	hl,0FFFFH
        in	a,(0A8H)
        ld	b,a		; save
        and	0C0H
        rrca
        rrca
        rrca
        rrca			; in page 1
        ld	c,a
        ld	a,b
        and	0F3H		; clear page 1
        or	c
        out	(0A8H),a
        ld	a,(hl)
        cpl
        ld	c,a		; save
        and	0C0H
        rrca
        rrca
        rrca
        rrca
        ld	e,a
        ld	a,c
        and	0F3H
        or	e
        ld	(hl),a
        exx
        ld	a,h
        and	a
        jp	m,skpsrc
        set	6,h
        jr	setpag
skpsrc: ld	a,d
        set	6,d
setpag: cp	040H
        ld	a,2
        adc	a,0
        out	(0FDH),a
        ldir
        ld	a,2
        out	(0FDH),a
        exx
        ld	a,c
        ld	(hl),a
        ld	a,b
        out	(0A8H),a
        exx
        ei
        ret

; ----------------------------------------------
; END OF CHANGE
; ----------------------------------------------

;
A3BD6:	push	hl
        pop	iy
        push	ix
        pop	bc
        ld	(iy+001H),c
        ld	(iy+002H),b
        xor	a
        ld	(iy+003H),a
        ld	(iy+005H),a
        ld	(iy+006H),a
        ld	(PTRFIL),hl
        ld	(hl),e
        ret
;
A3BF1:	call	A3B0D
        jp	nz,A055E
        and	a
        ret	z
A3BF9:	ld	e,040H
        jr	A3C05
;
A3BFD:	ld	a,(YFD09)
        bit	6,a		; ramdisk valid ?
        ret	nz		; yep, ok
        ld	e,046H
A3C05:	xor	a
        ld	(NLONLY),a
        push	de
        call	A05C0
        pop	de
        jp	A05C6


; Extended errormsg

A3D9C:	ld	bc,T3DBF
A3D9F:	ld	a,(bc)
        inc	bc
        or	a
        ret	z
        sub	e
        jr	z,A3DAA
        inc	bc
        inc	bc
        jr	A3D9F
;
A3DAA:	ld	l,c
        ld	h,b
        ld	e,(hl)
        inc	hl
        ld	d,(hl)
        ld	hl,0F55EH
        push	hl
        ld	(hl),a
A3DB4:	inc	de
        inc	hl
        ld	a,(de)
        ld	(hl),a
        or	a
        jr	nz,A3DB4
        pop	hl
        ld	e,001H
        ret
;
T3DBF:	db	03CH
        dw	T3DD5-1
        db	03DH
        dw	T3DDD-1
        db	040H
        dw	T3DEB-1
        db	041H
        dw	T3DFB-1
        db	042H
        dw	T3E0F-1
        db	043H
        dw	T3E1D-1
        db	046H
        dw	T3E2C-1
        db	0

T3DD5:	db	"Bad FAT",0
T3DDD:	db	"Bad file name",0
T3DEB:	db	"File still open",0
T3DFB:	db	"File already exists",0
T3E0F:	db	"RAM disk full",0
T3E1D:	db	"Too many files",0
T3E2C:	db	"RAM disk offline",0

        DEFS	04000H-$,0

        end

