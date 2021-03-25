; BIOS.ASM

; MSX BIOS ROM, MSX 1 version (version 1.0)

; Source re-created by Z80DIS 2.2
; Z80DIS was written by Kenneth Gielow, Palo Alto, CA

; Code Copyrighted by ASCII and maybe others
; Source comments by Arjen Zeilemaker

; Sourcecode supplied for STUDY ONLY
; Recreation NOT permitted without authorisation of the copyrightholders


        org     0000H

CHKRAM: di                              ; 0000H
        jp      A02D7


CGTABL: dw      T1BBF                   ; 0004H
        db      098H
        db      098H

SYNCHR: jp      A2683                   ; 0008H

        defs    0000CH-$,0

RDSLT:  jp      A01B6                   ; 000CH

        defs    00010H-$,0

CHRGTR: jp      A2686                   ; 0010H

        defs    00014H-$,0

WRSLT:  jp      A01D1                   ; 0014H

        defs    00018H-$,0

OUTDO:  jp      A1B45                   ; 0018H

        defs    0001CH-$,0

CALSLT: jp      A0217                   ; 001CH

        defs    00020H-$,0

DCOMPR: jp      A146A                   ; 0020H

        defs    00024H-$,0

ENASLT: jp      A025E                   ; 0024H

        defs    00028H-$,0

GETYPR: jp      A2689                   ; 0028H
;
IDBYT0:                                 ; 002BH
        IF      INTHZ EQ 60
        DEFB    CHRGEN+16*DATFMT
        ELSE
        DEFB    CHRGEN+16*DATFMT+128
        ENDIF
IDBYT1: DEFB    KEYTYP+16*BASVER        ; 002CH
IDBYT2: DEFB    MSXVER                  ; 002DH, MSX version 0 = MSX1
        DEFB    0

        DEFS    00030H-$

CALLF:  jp      A0205                   ; 0030H
;
        DEFS    00034H-$

;       The next bytes are used by the diskrom, to initialize the double byte header char
;       table (0F30FH). I have not seen a MSX with anything other than four zero's, meaning
;       no double byte chars.

D0034:  db      0,0
        db      0,0

KEYINT: jp      A0C3C                   ; 0038H
INITIO: jp      A049D                   ; 003BH
INIFNK: jp      A139D                   ; 003EH
DISSCR: jp      A0577                   ; 0041H
ENASCR: jp      A0570                   ; 0044H
WRTVDP: jp      A057F                   ; 0047H
RDVRM:  jp      A07D7                   ; 004AH
WRTVRM: jp      A07CD                   ; 004DH
SETRD:  jp      A07EC                   ; 0050H
SETWRT: jp      A07DF                   ; 0053H
FILVRM: jp      A0815                   ; 0056H
LDIRMV: jp      A070F                   ; 0059H
LDIRVM: jp      A0744                   ; 005CH
CHGMOD: jp      A084F                   ; 005FH
CHGCLR: jp      A07F7                   ; 0062H

        defs    00066H-$,0              ; align to Z80 NMI entry at 0066H

NMIHND: jp      A1398                   ; 0066H
CLRSPR: jp      A06A8                   ; 0069H
INITXT: jp      A050E                   ; 006CH
INIT32: jp      A0538                   ; 006FH
        jp      A05D2                   ; 0072H
        jp      A061F                   ; 0075H
SETTXT: jp      A0594                   ; 0078H
        jp      A05B4                   ; 007BH
SETGRP: jp      A0602                   ; 007EH
SETMLT: jp      A0659                   ; 0081H
CALPAT: jp      A06E4                   ; 0084H
CALATR: jp      A06F9                   ; 0087H
GSPSIZ: jp      A0704                   ; 008AH
GRPPRT: jp      A1510                   ; 008DH
GICINI: jp      A04BD                   ; 0090H
WRTPSG: jp      A1102                   ; 0093H
        jp      A110E                   ; 0096H
STRTMS: jp      A11C4                   ; 0099H
CHSNS:  jp      A0D6A                   ; 009CH
CHGET:  jp      A10CB                   ; 009FH
CHPUT:  jp      A08BC                   ; 00A2H
LPTOUT: jp      A085D                   ; 00A5H
        jp      A0884                   ; 00A8H
CNVCHR: jp      A089D                   ; 00ABH
PINLIN: jp      A23BF                   ; 00AEH
INLIN:  jp      A23D5                   ; 00B1H
QINLIN: jp      A23CC                   ; 00B4H
        jp      A046F                   ; 00B7H
ISCNTC: jp      A03FB                   ; 00BAH
CKCNTC: jp      A10F9                   ; 00BDH
BEEP:   jp      A1113                   ; 00C0H
CLS:    jp      A0848                   ; 00C3H
POSIT:  jp      A088E                   ; 00C6H
FNKSB:  jp      A0B26                   ; 00C9H
ERAFNK: jp      A0B15                   ; 00CCH
DSPFNK: jp      A0B2B                   ; 00CFH
TOTEXT: jp      A083B                   ; 00D2H
GTSTCK: jp      A11EE                   ; 00D5H
GTTRIG: jp      A1253                   ; 00D8H
GTPAD:  jp      A12AC                   ; 00DBH
GTPDL:  jp      A1273                   ; 00DEH
TAPION: jp      A1A63                   ; 00E1H
TAPIN:  jp      A1ABC                   ; 00E4H
TAPIOF: jp      A19E9                   ; 00E7H
TAPOON: jp      A19F1                   ; 00EAH
TAPOUT: jp      A1A19                   ; 00EDH
TAPOOF: jp      A19DD                   ; 00F0H
STMOTR: jp      A1384                   ; 00F3H
LFTQ:   jp      A14EB                   ; 00F6H
PUTQ:   jp      A1492                   ; 00F9H
        jp      A16C5                   ; 00FCH
LEFTC:  jp      A16EE                   ; 00FFH
        jp      A175D                   ; 0102H
TUPC:   jp      A173C                   ; 0105H
DOWNC:  jp      A172A                   ; 0108H
TDOWNC: jp      A170A                   ; 010BH
SCALXY: jp      A1599                   ; 010EH
MAPXYC: jp      A15DF                   ; 0111H
FETCHC: jp      A1639                   ; 0114H
STOREC: jp      A1640                   ; 0117H
SETATR: jp      A1676                   ; 011AH
READC:  jp      A1647                   ; 011DH
SETC:   jp      A167E                   ; 0120H
NSETCX: jp      A1809                   ; 0123H
GTASPC: jp      A18C7                   ; 0126H
PNTINI: jp      A18CF                   ; 0129H
SCANR:  jp      A18E4                   ; 012CH
SCANL:  jp      A197A                   ; 012FH
        jp      K.BCAP                  ; 0132H
        jp      K.BSND                  ; 0135H
        jp      A144C                   ; 0138H
        jp      A144F                   ; 013BH
        jp      A1449                   ; 013EH
        jp      A1452                   ; 0141H
        jp      A148A                   ; 0144H
        jp      A148E                   ; 0147H
ISFLIO: jp      A145F                   ; 014AH
OUTDLP: jp      A1B63                   ; 014DH
GETVCP: jp      A1470                   ; 0150H
GETVC2: jp      A1474                   ; 0153H
        jp      A0468                   ; 0156H
        jp      A01FF                   ; 0159H

        IF      SLOTFIX EQ 0

        defs    001B6H-$,0

        ELSE

        defs    0016FH-$,0

C016F:  CALL    C01AD
        JR      NZ,A01C6
        PUSH    HL
        CALL    C0199
        EX      (SP),HL
        CALL    M7FBE
        JR      J018D

C017E:  CALL    C01AD
        JP      NZ,A01E1
        POP     DE
        PUSH    HL
        CALL    C0199
        EX      (SP),HL
        CALL    M7FC4
J018D:  EX      (SP),HL
        PUSH    AF
        LD      A,L
        OUT     (0A8H),A
        LD      A,H
        LD      (D.FFFF),A
        POP     AF
        POP     HL
        RET

C0199:  PUSH    AF
        LD      A,(D.FFFF)
        CPL
        LD      H,A
        AND     0F3H
        LD      (D.FFFF),A
        IN      A,(0A8H)
        LD      L,A
        AND     0F3H
        OUT     (0A8H),A
        POP     AF
        RET

C01AD:  INC     D
        DEC     D
        RET     NZ
        LD      B,A
        LD      A,E
        CP      3
        LD      A,B
        RET
        ENDIF

A01B6:  call    A027E                   ; make masks

        IF      SLOTFIX EQ 1
        jp      m,C016F
        ELSE
        jp      m,A01C6                 ; expanded slot, handle
        ENDIF

        in      a,(0A8H)
        ld      d,a
        and     c                       ; clear slot of page
        or      b                       ; set new slot
        call    RDPRIM                  ; read byte
        ld      a,e
        ret
;
A01C6:  push    hl
        call    A02A3                   ; change sec. slotregister
        ex      (sp),hl
        push    bc
        call    A01B6                   ; do a RDSLT for primary slot
        jr      A01EC
;
A01D1:  push    de
        call    A027E                   ; make masks

        IF      SLOTFIX EQ 1
        jp      m,C017E
        ELSE
        jp      m,A01E1                 ; expanded slot, handle
        ENDIF

        pop     de
        in      a,(0A8H)
        ld      d,a
        and     c                       ; clear slot of page
        or      b                       ; set new slot
        jp      WRPRIM                  ; write byte
;
A01E1:  ex      (sp),hl
        push    hl
        call    A02A3                   ; change sec. slotregister
        pop     de
        ex      (sp),hl
        push    bc
        call    A01D1                   ; do a WRSLT for primairy slot
A01EC:  pop     bc
        ex      (sp),hl
        push    af
        ld      a,b
        and     03FH
        or      c                       ; slot of sec. slotreg
        out     (0A8H),a
        ld      a,l
        ld      (D.FFFF),a              ; restore register
        ld      a,b
        out     (0A8H),a                ; restore prim. slotreg
        pop     af
        pop     hl
        ret
;
A01FF:  ld      iy,(EXPTBL+0-1)         ; slotid mainrom
        jr      A0217
;
A0205:  ex      (sp),hl
        push    af
        push    de
        ld      a,(hl)
        push    af
        pop     iy                      ; slotid
        inc     hl
        ld      e,(hl)
        inc     hl
        ld      d,(hl)
        inc     hl
        push    de
        pop     ix                      ; adres
        pop     de
        pop     af
        ex      (sp),hl

A0217:  exx
        ex      af,af'                  ; alternative set
        push    iy
        pop     af
        push    ix
        pop     hl
        call    A027E                   ; make masks
        jp      m,A022E                 ; expanded slot, handle
        in      a,(0A8H)
        push    af
        and     c
        or      b
        exx
        jp      CLPRIM
;
A022E:  call    A02A3
        push    af
        pop     iy
        push    hl
        push    bc
        ld      c,a
        ld      b,000H
        ld      a,l
        and     h
        or      d
        ld      hl,SLTTBL
        add     hl,bc
        ld      (hl),a
        push    hl
        ex      af,af'
        exx
        call    A0217                   ; do a CALSLT with primairy slot
        exx
        ex      af,af'
        pop     hl
        pop     bc
        pop     de
        ld      a,b
        and     03FH
        or      c
        di
        out     (0A8H),a
        ld      a,e
        ld      (D.FFFF),a
        ld      a,b
        out     (0A8H),a
        ld      (hl),e
        ex      af,af'
        exx
        ret
;
A025E:  call    A027E                   ; get masks
        jp      m,A026B                 ; expanded slot, handle
        in      a,(0A8H)
        and     c
        or      b
        out     (0A8H),a
        ret
;
A026B:  push    hl
        call    A02A3
        ld      c,a
        ld      b,000H
        ld      a,l
        and     h
        or      d
        ld      hl,SLTTBL
        add     hl,bc
        ld      (hl),a
        pop     hl
        ld      a,c
        jr      A025E
;
A027E:  di
        push    af
        ld      a,h
        rlca
        rlca
        and     003H                    ; page
        ld      e,a
        ld      a,0C0H
A0288:  rlca
        rlca
        dec     e
        jp      p,A0288
        ld      e,a                     ; e = page select mask
        cpl
        ld      c,a                     ; c = page clear mask
        pop     af
        push    af
        and     003H                    ; primairy slot
        inc     a                       ; +1
        ld      b,a
        ld      a,0-01010101b
A0299:  add     a,01010101b
        djnz    A0299
        ld      d,a                     ; d = slot set mask
        and     e
        ld      b,a                     ; b = slot set mask
        pop     af
        and     a                       ; flag expanded slot
        ret
;
A02A3:  push    af
        ld      a,d
        and     0C0H
        ld      c,a                     ; page set mask for page 3
        pop     af
        push    af
        ld      d,a
        in      a,(0A8H)
        ld      b,a
        and     03FH                    ; clear slot of page 3
        or      c                       ; set page 3 for sec. slotreg
        out     (0A8H),a                ; invoke
        ld      a,d
        rrca
        rrca
        and     003H                    ; secundairy slot
        ld      d,a
        ld      a,0-01010101b
A02BB:  add     a,01010101b
        dec     d
        jp      p,A02BB                 ; slot set mask
        and     e
        ld      d,a                     ; slot set (page) mask
        ld      a,e
        cpl
        ld      h,a                     ; page clear mask
        ld      a,(D.FFFF)
        cpl
        ld      l,a                     ; old sec. slotreg
        and     h                       ; clear page
        or      d                       ; set new slot
        ld      (D.FFFF),a
        ld      a,b
        out     (0A8H),a                ; restore primairy slot on page 3
        pop     af
        and     003H
        ret
;
A02D7:  ld      a,082H
        out     (0ABH),a                ; initialize PPI (active, group A mode 0, group A output, upper port C output, group B mode 0, group B input, lower port C output)
        xor     a
        out     (0A8H),a                ; select primairy slot 0 on all pages
        ld      a,050H
        out     (0AAH),a                ; CAPS off, motor off, keyboard row 0
        ld      de,0FFFFH               ; initialize lowest RAM address found (page 2)
        xor     a                       ; start with primairy slot 0
        ld      c,a                     ; initialize expanded slot flags
A02E7:  out     (0A8H),a                ; select primairy slot on page 2 and 3
        sla     c                       ; shift expanded slot flags
        ld      b,0                     ; assume not expanded slot
        ld      hl,0FFFFH
        ld      (hl),0F0H
        ld      a,(hl)
        sub     00FH                    ; is slot expanded (writen value readback inverted) ?
        jr      nz,A0302                ; nope,
        ld      (hl),a
        ld      a,(hl)
        inc     a                       ; is slot expanded (writen value readback inverted) ?
        jr      nz,A0302                ; nope,
        inc     b
        set     0,c                     ; flag slot expanded
A02FF:  ld      (D.FFFF),a
A0302:  ld      hl,0C000H-256           ; page 2
A0305:  ld      a,(hl)
        cpl
        ld      (hl),a
        cp      (hl)                    ; RAM found (write inverted correctly read back) ?
        cpl
        ld      (hl),a                  ; restore orginal value
        jr      nz,A0314                ; no RAM
        inc     l
        jr      nz,A0305
        dec     h
        jp      m,A0305
A0314:  ld      l,000H
        inc     h                       ; round up 256 bytes boundary
        ld      a,l
        sub     e
        ld      a,h
        sbc     a,d                     ; page 2 with more RAM ?
        jr      nc,A0327                ; nope,
        ex      de,hl                   ; new lowest RAM address found
        ld      a,(D.FFFF)
        cpl
        ld      l,a
        in      a,(0A8H)
        ld      h,a
        ld      sp,hl                   ; save primairy and secundairy slotregister of lowest RAM address found (page 2)
A0327:  ld      a,b
        and     a                       ; slot expanded ?
        jr      z,A0335                 ; nope, next primary slot
        ld      a,(D.FFFF)
        cpl
        add     a,010H                  ; next secundairy slot page 2
        cp      040H                    ; all secundairy slots done ?
        jr      c,A02FF                 ; nope, next
A0335:  in      a,(0A8H)
        add     a,050H                  ; next primary slot page 2 and 3
        jr      nc,A02E7                ; all primary slots done ? nope, next
        ld      hl,0
        add     hl,sp
        ld      a,h
        out     (0A8H),a
        ld      a,l
        ld      (D.FFFF),a              ; select slot with lowest RAM address found (page 2)
        ld      a,c
        rlca
        rlca
        rlca
        rlca
        ld      c,a                     ; expanded slot flags in b7-b4
        ld      de,0FFFFH               ; initialize lowest RAM address found (page 3)
        in      a,(0A8H)
        and     03FH                    ; primairy slot 0 in page 3
A0353:  out     (0A8H),a                ; select new primairy slot in page 3
        ld      b,0
        rlc     c                       ; slot expanded ?
        jr      nc,A0365                ; nope,
        inc     b                       ; flag slot expanded
        ld      a,(D.FFFF)
        cpl
        and     03FH                    ; secundairy slot 0 in page 3
A0362:  ld      (D.FFFF),a              ; select new secundairy slot in page 3
A0365:  ld      hl,0FF00H-256           ; page 3 (leave upper 256 bytes out for secundairy slot register)
A0368:  ld      a,(hl)
        cpl
        ld      (hl),a
        cp      (hl)                    ; RAM found (write inverted correctly read back) ?
        cpl
        ld      (hl),a                  ; restore orginal value
        jr      nz,A0379                ; no RAM
        inc     l
        jr      nz,A0368
        dec     h
        ld      a,h
        cp      0C0H
        jr      nc,A0368
A0379:  ld      l,000H
        inc     h                       ; round up 256 bytes boundary
        ld      a,l
        sub     e
        ld      a,h
        sbc     a,d                     ; page 3 with more RAM ?
        jr      nc,A038C                ; nope,
        ex      de,hl                   ; new lowest RAM address found
        ld      a,(D.FFFF)
        cpl
        ld      l,a
        in      a,(0A8H)
        ld      h,a
        ld      sp,hl                   ; save primairy and secundairy slotregister of lowest RAM address found (page 3)
A038C:  ld      a,b
        and     a                       ; slot expanded ?
        jr      z,A0398                 ; nope,
        ld      a,(D.FFFF)
        cpl
        add     a,040H                  ; next secundairy slot page 3
        jr      nc,A0362                ; all secundairy slots done ? nope, next
A0398:  in      a,(0A8H)
        add     a,040H                  ; next primairy slot page 3
        jr      nc,A0353                ; all primary slots done ? nope, next
        ld      hl,0
        add     hl,sp
        ld      a,h
        out     (0A8H),a
        ld      a,l
        ld      (D.FFFF),a              ; select slot with lowest RAM address found (page 3)
        ld      a,c
        ld      bc,0C49H
        ld      de,VARWRK+1
        ld      hl,VARWRK
        ld      (hl),000H
        ldir                            ; clear system variable area
        ld      c,a
        ld      b,4
        ld      hl,EXPTBL+3
A03BD:  rr      c
        sbc     a,a
        and     080H
        ld      (hl),a                  ; initialize slot expanded flag
        dec     hl
        djnz    A03BD
        in      a,(0A8H)
        ld      c,a                     ; save current primairy slot register
        xor     a
        out     (0A8H),a                ; select primairy slot 0 in page 0,1,2,3
        ld      a,(D.FFFF)
        cpl
        ld      l,a                     ; save current secundairy slot register slot 0
        ld      a,040H
        out     (0A8H),a                ; select primairy slot 0 in page 0,1,2 slot 1 in page 3
        ld      a,(D.FFFF)
        cpl
        ld      h,a                     ; save current secundairy slot register slot 1
        ld      a,080H
        out     (0A8H),a                ; select primairy slot 0 in page 0,1,2 slot 2 in page 3
        ld      a,(D.FFFF)
        cpl
        ld      e,a                     ; save current secundairy slot register slot 2
        ld      a,0C0H
        out     (0A8H),a                ; select primairy slot 0 in page 0,1,2 slot 3 in page 3
        ld      a,(D.FFFF)
        cpl
        ld      d,a                     ; save current secundairy slot register slot 3
        ld      a,c
        out     (0A8H),a                ; restore primairy slot register
        ld      (SLTTBL+0),hl
        ex      de,hl
        ld      (SLTTBL+2),hl           ; current secundairy slot registers saved in SLTTBL
        im      1                       ; Z80 interrupt mode 1 (RST 38H on INT)
        jp      A2680                   ; part 2 of init
;
A03FB:  ld      a,(BASROM)
        and     a                       ; executing basicrom ?
        ret     nz                      ; yep, quit
        push    hl
        ld      hl,INTFLG
        di                              ; INTFLG can not change
        ld      a,(hl)
        ld      (hl),000H               ; reset
        pop     hl
        ei
        and     a                       ; STOP or CTRL/STOP ?
        ret     z                       ; nop, quit
        cp      003H
        jr      z,A042C                 ; it is CTRL/STOP
        push    hl
        push    de
        push    bc
        call    A09DA                   ; cursor on
        ld      hl,INTFLG
A0419:  di                              ; INTFLG can not change
        ld      a,(hl)
        ld      (hl),000H               ; reset
        ei
        and     a                       ; STOP or CTRL/STOP ?
        jr      z,A0419                 ; nop, try again
        push    af
        call    A0A27                   ; cursor off
        pop     af
        pop     bc
        pop     de
        pop     hl
        cp      003H                    ; CTRL/STOP ?
        ret     nz                      ; nop, just quit
A042C:  push    hl
        call    A0468                   ; clear keyboard buffer
        call    A0454
        jr      nc,A043F
        ld      hl,TRPTBL+10*3
        di
        call    C0EF1
        ei
        pop     hl
        ret
;
A043F:  call    A083B
        ld      a,(EXPTBL+0)
        ld      h,040H
        call    A025E
        pop     hl
        xor     a
        ld      sp,(SAVSTK)
        push    bc
        jp      C63E6
;
A0454:  ld      a,(TRPTBL+10*3+0)
        rrca
        ret     nc
        ld      hl,(TRPTBL+10*3+1)
        ld      a,h
        or      l
        ret     z
        ld      hl,(CURLIN)
        inc     hl
        ld      a,h
        or      l
        ret     z
        scf
        ret
;
A0468:  ld      hl,(PUTPNT)
        ld      (GETPNT),hl
        ret
;
A046F:  in      a,(0AAH)
        and     0F0H
        or      007H
        out     (0AAH),a
        in      a,(0A9H)
        and     010H
        ret     nz
        in      a,(0AAH)
        dec     a
        out     (0AAH),a
        in      a,(0A9H)
        and     002H
        ret     nz
        push    hl
        ld      hl,(PUTPNT)
        ld      (GETPNT),hl
        pop     hl
        ld      a,(OLDKEY+7)
        and     0EFH
        ld      (OLDKEY+7),a
        LD      A,13
        ld      (REPCNT),a
        scf
        ret
;
A049D:  ld      a,007H
        ld      e,080H
        call    A1102
        ld      a,00FH
        ld      e,0CFH
        call    A1102
        ld      a,00BH
        ld      e,a
        call    A1102
        call    A110C
        and     040H
        ld      (KANAMD),a
        ld      a,0FFH
        out     (090H),a
A04BD:  push    hl
        push    de
        push    bc
        push    af
        ld      hl,MUSICF
        ld      b,071H
        xor     a
A04C7:  ld      (hl),a
        inc     hl
        djnz    A04C7
        ld      de,VOICAQ
        ld      b,07FH
        ld      hl,128
A04D3:  push    hl
        push    de
        push    bc
        push    af
        call    A14DA
        pop     af
        add     a,008H
        ld      e,000H
        call    A1102
        sub     008H
        push    af
        ld      l,00FH
        call    A1477
        ex      de,hl
        ld      hl,T0508
        ld      bc,6
        ldir
        pop     af
        pop     bc
        pop     hl
        pop     de
        add     hl,de
        ex      de,hl
        inc     a
        cp      003H
        jr      c,A04D3
        ld      a,007H
        ld      e,0B8H
        call    A1102
        jp      A08DA
;
T0508:  db      4
        db      4
        db      120
        db      8+128
        dw      255

A050E:  call    A0577
        xor     a
        ld      (SCRMOD),a
        ld      (OLDSCR),a
        ld      a,(LINL40)
        ld      (LINLEN),a
        ld      hl,(TXTNAM)
        ld      (NAMBAS),hl
        ld      hl,(TXTCGP)
        ld      (CGPBAS),hl
        call    A07F7
        call    A077E
        call    A071E
        call    A0594
        jr      A0570
;
A0538:  call    A0577
        ld      a,001H
        ld      (SCRMOD),a
        ld      (OLDSCR),a
        ld      a,(LINL32)
        ld      (LINLEN),a
        ld      hl,(T32NAM)
        ld      (NAMBAS),hl
        ld      hl,(T32CGP)
        ld      (CGPBAS),hl
        ld      hl,(T32PAT)
        ld      (PATBAS),hl
        ld      hl,(T32ATR)
        ld      (ATRBAS),hl
        call    A07F7
        call    A077E
        call    A071E
        call    A06BB
        call    A05B4
A0570:  ld      a,(RG1SAV)
        or      040H
        jr      A057C
;
A0577:  ld      a,(RG1SAV)
        and     0BFH
A057C:  ld      b,a
        ld      c,001H
A057F:  ld      a,b
        di
        out     (099H),a
        ld      a,c
        or      080H
        out     (099H),a
        ei
        push    hl
        ld      a,b
        ld      b,000H
        ld      hl,RG0SAV
        add     hl,bc
        ld      (hl),a
        pop     hl
        ret
;
A0594:  ld      a,(RG0SAV)
        and     001H
        ld      b,a
        ld      c,000H
        call    A057F
        ld      a,(RG1SAV)
        and     0E7H
        or      010H
        ld      b,a
        inc     c
        call    A057F
        ld      hl,TXTNAM
        ld      de,00000H
        jp      A0677
;
A05B4:  ld      a,(RG0SAV)
        and     001H
        ld      b,a
        ld      c,000H
        call    A057F
        ld      a,(RG1SAV)
        and     0E7H
        ld      b,a
        inc     c
        call    A057F
        ld      hl,T32NAM
        ld      de,00000H
        jp      A0677
;
A05D2:  call    A0577
        ld      a,002H
        ld      (SCRMOD),a
        ld      hl,(GRPPAT)
        ld      (PATBAS),hl
        ld      hl,(GRPATR)
        ld      (ATRBAS),hl
        ld      hl,(GRPNAM)
        call    A07DF
        xor     a
        ld      b,003H
A05EF:  out     (098H),a
        inc     a
        jr      nz,A05EF
        djnz    A05EF
        call    A07A1
        call    A06BB
        call    A0602
        jp      A0570
;
A0602:  ld      a,(RG0SAV)
        or      002H
        ld      b,a
        ld      c,000H
        call    A057F
        ld      a,(RG1SAV)
        and     0E7H
        ld      b,a
        inc     c
        call    A057F
        ld      hl,GRPNAM
        ld      de,07F03H
        jr      A0677
;
A061F:  call    A0577
        ld      a,003H
        ld      (SCRMOD),a
        ld      hl,(MLTPAT)
        ld      (PATBAS),hl
        ld      hl,(MLTATR)
        ld      (ATRBAS),hl
        ld      hl,(MLTNAM)
        call    A07DF
        ld      de,6
A063C:  ld      c,004H
A063E:  ld      a,d
        ld      b,020H
A0641:  out     (098H),a
        inc     a
        djnz    A0641
        dec     c
        jr      nz,A063E
        ld      d,a
        dec     e
        jr      nz,A063C
        call    A07B9
        call    A06BB
        call    A0659
        jp      A0570
;
A0659:  ld      a,(RG0SAV)
        and     001H
        ld      b,a
        ld      c,000H
        call    A057F
        ld      a,(RG1SAV)
        and     0E7H
        or      008H
        ld      b,a
        ld      c,001H
        call    A057F
        ld      hl,MLTNAM
        ld      de,00000H
A0677:  ld      bc,A0602
        call    A0690
        ld      b,00AH
        ld      a,d
        call    A0691
        ld      b,005H
        ld      a,e
        call    A0691
        ld      b,009H
        call    A0690
        ld      b,005H
A0690:  xor     a
A0691:  push    hl
        push    af
        ld      a,(hl)
        inc     hl
        ld      h,(hl)
        ld      l,a
        xor     a
A0698:  add     hl,hl
        adc     a,a
        djnz    A0698
        ld      l,a
        pop     af
        or      l
        ld      b,a
        call    A057F
        pop     hl
        inc     hl
        inc     hl
        inc     c
        ret
;
A06A8:  ld      a,(RG1SAV)
        ld      b,a
        ld      c,001H
        call    A057F
        ld      hl,(PATBAS)
        ld      bc,00800H
        xor     a
        call    A0815
A06BB:  ld      a,(FORCLR)
        ld      e,a
        ld      hl,(ATRBAS)
        ld      bc,02000H
A06C5:  ld      a,0D1H
        call    A07CD
        inc     hl
        inc     hl
        ld      a,c
        call    A07CD
        inc     hl
        inc     c
        ld      a,(RG1SAV)
        rrca
        rrca
        jr      nc,A06DC
        inc     c
        inc     c
        inc     c
A06DC:  ld      a,e
        call    A07CD
        inc     hl
        djnz    A06C5
        ret
;
A06E4:  ld      l,a
        ld      h,000H
        add     hl,hl
        add     hl,hl
        add     hl,hl
        call    A0704
        cp      008H
        jr      z,A06F3
        add     hl,hl
        add     hl,hl
A06F3:  ex      de,hl
        ld      hl,(PATBAS)
        add     hl,de
        ret
;
A06F9:  ld      l,a
        ld      h,000H
        add     hl,hl
        add     hl,hl
        ex      de,hl
        ld      hl,(ATRBAS)
        add     hl,de
        ret
;
A0704:  ld      a,(RG1SAV)
        rrca
        rrca
        ld      a,008H
        ret     nc
        ld      a,020H
        ret
;
A070F:  call    A07EC
        ex      (sp),hl
        ex      (sp),hl
A0714:  in      a,(098H)
        ld      (de),a
        inc     de
        dec     bc
        ld      a,c
        or      b
        jr      nz,A0714
        ret
;
A071E:  call    H.INIP
        ld      hl,(CGPBAS)
        call    A07DF
        ld      a,(CGPNT+0)
        ld      hl,(CGPNT+1)
        ld      bc,00800H
        push    af
A0731:  pop     af
        push    af
        push    bc
        di
        call    A01B6
        ei
        pop     bc
        out     (098H),a
        inc     hl
        dec     bc
        ld      a,c
        or      b
        jr      nz,A0731
        pop     af
        ret
;
A0744:  ex      de,hl
        call    A07DF
A0748:  ld      a,(de)
        out     (098H),a
        inc     de
        dec     bc
        ld      a,c
        or      b
        jr      nz,A0748
        ret
;
A0752:  ld      h,000H
        ld      l,a
        add     hl,hl
        add     hl,hl
        add     hl,hl
        ex      de,hl
        ld      hl,(CGPNT+1)
        add     hl,de
        ld      de,PATWRK
        ld      b,008H
        ld      a,(CGPNT+0)
A0765:  push    af
        push    hl
        push    de
        push    bc
        call    A01B6
        ei
        pop     bc
        pop     de
        pop     hl
        ld      (de),a
        inc     de
        inc     hl
        pop     af
        djnz    A0765
        ret
;
A0777:  call    A0B9F                   ; grafic mode ?
        jr      z,A07A1                 ; yep, screen 2
        jr      nc,A07B9                ; yep, screen 3
A077E:  ld      a,(SCRMOD)
        and     a
        ld      hl,(NAMBAS)
        ld      bc,24*40
        jr      z,A078D
        ld      bc,24*32
A078D:  ld      a,020H
        call    A0815
        call    A0A7F
        ld      hl,LINTTB
        ld      b,018H
A079A:  ld      (hl),b
        inc     hl
        djnz    A079A
        jp      A0B26
;
A07A1:  call    A0832
        ld      bc,256/8*192
        push    bc
        ld      hl,(GRPCOL)
        ld      a,(BAKCLR)
        call    A0815
        ld      hl,(GRPCGP)
        pop     bc
        xor     a
A07B6:  jp      A0815
;
A07B9:  call    A0832
        ld      hl,BAKCLR
        ld      a,(hl)
        add     a,a
        add     a,a
        add     a,a
        add     a,a
        or      (hl)
        ld      hl,(MLTCGP)
        ld      bc,00600H
        jr      A07B6
;
A07CD:  push    af
        call    A07DF
        ex      (sp),hl
        ex      (sp),hl
        pop     af
        out     (098H),a
        ret
;
A07D7:  call    A07EC
        ex      (sp),hl
        ex      (sp),hl
        in      a,(098H)
        ret
;
A07DF:  ld      a,l
        di
        out     (099H),a
        ld      a,h
        and     03FH
        or      040H
        out     (099H),a
        ei
        ret
;
A07EC:  ld      a,l
        di
        out     (099H),a
        ld      a,h
        and     03FH
        out     (099H),a
        ei
        ret
;
A07F7:  ld      a,(SCRMOD)
        dec     a
        jp      m,A0824
        push    af
        call    A0832
        pop     af
        ret     nz
        ld      a,(FORCLR)
        add     a,a
        add     a,a
        add     a,a
        add     a,a
        ld      hl,BAKCLR
        or      (hl)
        ld      hl,(T32COL)
        ld      bc,32
A0815:  push    af
        call    A07DF
A0819:  pop     af
        out     (098H),a
        push    af
        dec     bc
        ld      a,c
        or      b
        jr      nz,A0819
        pop     af
        ret
;
A0824:  ld      a,(FORCLR)
        add     a,a
        add     a,a
        add     a,a
        add     a,a
        ld      hl,BAKCLR
        or      (hl)
        ld      b,a
        jr      A0835
;
A0832:  ld      a,(BDRCLR)
A0835:  ld      b,a
        ld      c,007H
        jp      A057F
;
A083B:  call    A0B9F                   ; grafic mode ?
        ret     c                       ; nop, quit
        ld      a,(OLDSCR)
        call    H.TOTE
        jp      A084F
;
A0848:  ret     nz
        push    hl
        call    A0777
        pop     hl
        ret
;
A084F:  dec     a
        jp      m,A050E
        jp      z,A0538
        dec     a
        jp      z,A05D2
        jp      A061F
;
A085D:  call    H.LPTO
        push    af
A0861:  call    A046F
        jr      c,A0878
        call    A0884
        jr      z,A0861
        pop     af
A086C:  push    af
        out     (091H),a
        xor     a
        out     (090H),a
        dec     a
        out     (090H),a
        pop     af
        and     a
        ret
;
A0878:  xor     a
        ld      (LPTPOS),a
        ld      a,00DH
        call    A086C
        pop     af
        scf
        ret
;
A0884:  call    H.LPTS
        in      a,(090H)
        rrca
        rrca
        ccf
        sbc     a,a
        ret
;
A088E:  ld      a,01BH
        rst     OUTDO
        ld      a,059H
        rst     OUTDO
        ld      a,l
        add     a,01FH
        rst     OUTDO
        ld      a,h
        add     a,01FH
        rst     OUTDO
        ret
;
A089D:  push    hl
        push    af
        ld      hl,GRPHED
        xor     a
        cp      (hl)
        ld      (hl),a
        jr      z,A08B4
        pop     af
        sub     040H
        cp      020H
        jr      c,A08B2
        add     a,040H
A08B0:  cp      a
        scf
A08B2:  pop     hl
        ret
;
A08B4:  pop     af
        cp      001H
        jr      nz,A08B0
        ld      (hl),a
        pop     hl
        ret
;
A08BC:  push    hl
        push    de
        push    bc
        push    af
        call    H.CHPU
        call    A0B9F                   ; grafic mode ?
        jr      nc,A08DA                ; yep, quit
        call    A0A2E                   ; cursor off
        pop     af
        push    af
        call    A08DF                   ; decode char
        call    A09E1                   ; cursor on
        ld      a,(CSRX)
        dec     a
        ld      (TTYPOS),a              ; set TTYPOS
A08DA:  pop     af
A08DB:  pop     bc
        pop     de
        pop     hl
        ret
;
A08DF:  call    A089D                   ; grafic header ?
        ret     nc                      ; yep, quit
        ld      c,a
        jr      nz,A08F3                ; grafic char
        ld      hl,ESCCNT
        ld      a,(hl)
        and     a                       ; in ESC sequence ?
        jp      nz,A098F                ; yep, handle
        ld      a,c
        cp      020H                    ; control char ?
        jr      c,A0914                 ; yep, handle
A08F3:  ld      hl,(CSRY)               ; cursor position
        cp      07FH
        jp      z,A0AE3                 ; DEL, handle
        call    A0BE6                   ; 'print' char
        call    A0A44                   ; increase col
        ret     nz                      ; not at end, quit
        xor     a
        call    A0C2B                   ; expand logical line
        ld      h,001H                  ; at begin of line
A0908:  call    A0A61                   ; down
        ret     nz                      ; no scroll needed, quit
        call    A0A69                   ; scroll up
        ld      l,001H
        jp      A0A88                   ; clear line
;
A0914:  ld      hl,T092F-2
        ld      c,00CH
A0919:  inc     hl
        inc     hl
        and     a
        dec     c
        ret     m
        cp      (hl)
        inc     hl
        jr      nz,A0919
        ld      c,(hl)
        inc     hl
        ld      b,(hl)
        ld      hl,(CSRY)               ; cursor position
        call    A092D                   ; execute function
        xor     a
        ret
;
A092D:  push    bc
        ret
;
T092F:  db      007H
        dw      A1113
        db      008H
        dw      A0A4C
        db      009H
        dw      A0A71
        db      00AH
        dw      A0908
        db      00BH
        dw      A0A7F
        db      00CH
        dw      A077E
        db      00DH
        dw      A0A81
        db      01BH
        dw      A0989
        db      01CH
        dw      A0A5B
        db      01DH
        dw      A0A4C
        db      01EH
        dw      A0A57
        db      01FH
        dw      A0A61

T0953:  db      'j'
        dw      A077E
        db      'E'
        dw      A077E
        db      'K'
        dw      A0AEE
        db      'J'
        dw      A0B05
        db      'l'
        dw      A0AEC
        db      'L'
        dw      A0AB4
        db      'M'
        dw      A0A85
        db      'Y'
        dw      A0986
        db      'A'
        dw      A0A57
        db      'B'
        dw      A0A61
        db      'C'
        dw      A0A44
        db      'D'
        dw      A0A55
        db      'H'
        dw      A0A7F
        db      'x'
        dw      A0980
        db      'y'
        dw      A0983

A0980:  ld      a,001H
        db      001H
A0983:  ld      a,002H
        db      001H
A0986:  ld      a,004H
        db      001H
A0989:  ld      a,0FFH
        ld      (ESCCNT),a
        ret
;
A098F:  jp      p,A099D                 ; handle long ESC sequences
        ld      (hl),0                  ; next is no ESC anymore
        ld      a,c
        ld      hl,T0953-2
        ld      c,00FH
        jp      A0919                   ; handle function
;
A099D:  dec     a
        jr      z,A09BE                 ; ESC "x"
        dec     a
        jr      z,A09C8                 ; ESC "y"
        dec     a
        ld      (hl),a                  ; ESC "Y" ends ?
        ld      a,(LINLEN)              ; max kol
        ld      de,CSRX
        jr      z,A09B3
        ld      (hl),003H
        call    A0C32                   ; max row
        dec     de
A09B3:  ld      b,a
        ld      a,c
        sub     32
        cp      b
        inc     a
        ld      (de),a
        ret     c
        ld      a,b
        ld      (de),a
        ret
;
A09BE:  ld      (hl),a
        ld      a,c
        sub     '4'
        jr      z,A09CF                 ; ESC "x4", block cursor
        dec     a
        jr      z,A09D6                 ; ESC "x5", cursor invisable
        ret
;
A09C8:  ld      (hl),a
        ld      a,c
        sub     '4'
        jr      nz,A09D3
        inc     a                       ; ESC "y4", stripe cursor
A09CF:  ld      (CSTYLE),a
        ret
;
A09D3:  dec     a
        ret     nz
        inc     a                       ; ESC "y5", cursor visable
A09D6:  ld      (CSRSR),a
        ret
;
A09DA:  ld      a,(CSRSR)
        and     a                       ; cursor visable ?
        ret     nz                      ; yep, quit
        jr      A09E6
;
A09E1:  ld      a,(CSRSR)
        and     a                       ; cursor visable ?
        ret     z                       ; nop, quit
A09E6:  call    H.DSPC
        call    A0B9F                   ; grafic mode ?
        ret     nc                      ; yep, quit
        ld      hl,(CSRY)
        push    hl
        call    A0BD8                   ; get char at cursorposition
        ld      (CURSAV),a              ; save
        ld      l,a
        ld      h,000H
        add     hl,hl
        add     hl,hl
        add     hl,hl
        ex      de,hl
        ld      hl,(CGPBAS)
        push    hl
        add     hl,de
        call    A0BA5                   ; copy char patern to LINWRK
        ld      hl,LINWRK+7
        ld      b,8
        ld      a,(CSTYLE)
        and     a                       ; block cursor ?
        jr      z,A0A13                 ; yep,
        ld      b,3
A0A13:  ld      a,(hl)
        cpl
        ld      (hl),a
        dec     hl
        djnz    A0A13
        pop     hl
        ld      bc,255*8
        add     hl,bc                   ; vramadres cursor patern
        call    A0BBE                   ; copy LINWRK to vram
        pop     hl
        ld      c,0FFH
        jp      A0BE6                   ; put cursor on screen
;
A0A27:  ld      a,(CSRSR)
        and     a                       ; cursor visable ?
        ret     nz                      ; yep, quit
        jr      A0A33
;
A0A2E:  ld      a,(CSRSR)
        and     a                       ; cursor visable ?
        ret     z                       ; nop, quit
A0A33:  call    H.ERAC
        call    A0B9F                   ; grafic mode ?
        ret     nc                      ; yep, quit
        ld      hl,(CSRY)
        ld      a,(CURSAV)
        ld      c,a
        jp      A0BE6                   ; put orginal char on screen
;
A0A44:  ld      a,(LINLEN)
        cp      h
        ret     z
        inc     h
        jr      A0A69
;
A0A4C:  call    A0A55
        ret     nz
        ld      a,(LINLEN)
        ld      h,a
        defb    011H
A0A55:  dec     h
        defb    03EH
A0A57:  dec     l
        ret     z
        jr      A0A69

A0A5B:  call    A0A44
        ret     nz
        ld      h,001H
A0A61:  call    A0C32
        cp      l
        ret     z
        jr      c,A0A6D
        inc     l
A0A69:  ld      (CSRY),hl
        ret
;
A0A6D:  dec     l
        xor     a
        jr      A0A69
;
A0A71:  ld      a,020H
        call    A08DF
        ld      a,(CSRX)
        dec     a
        and     007H
        jr      nz,A0A71
        ret
;
A0A7F:  ld      l,001H
A0A81:  ld      h,001H
        jr      A0A69

A0A85:  call    A0A81
A0A88:  call    A0C32
        sub     l
        ret     c
        jp      z,A0AEC
        push    hl
        push    af
        ld      c,a
        ld      b,000H
        call    A0C1D
        ld      l,e
        ld      h,d
        inc     hl
        ldir
        ld      hl,FSTPOS
        dec     (hl)
        pop     af
        pop     hl
A0AA3:  push    af
        inc     l
        call    A0BAA
        dec     l
        call    A0BC3
        inc     l
        pop     af
        dec     a
        jr      nz,A0AA3
        jp      A0AEC

A0AB4:  call    A0A81
A0AB7:  call    A0C32
        ld      h,a
        sub     l
        ret     c
        jp      z,A0AEC
        ld      l,h
        push    hl
        push    af
        ld      c,a
        ld      b,000H
        call    A0C1D
        ld      l,e
        ld      h,d
        push    hl
        dec     hl
        lddr
        pop     hl
        ld      (hl),h
        pop     af
        pop     hl
A0AD3:  push    af
        dec     l
        call    A0BAA
        inc     l
        call    A0BC3
        dec     l
        pop     af
        dec     a
        jr      nz,A0AD3
        jr      A0AEC
;
A0AE3:  call    A0A4C
        ret     z
        ld      c,020H
        jp      A0BE6
;
A0AEC:  ld      h,001H
A0AEE:  call    A0C29
        push    hl
        call    A0BF2
        call    A07DF
        pop     hl
A0AF9:  ld      a,020H
        out     (098H),a
        inc     h
        ld      a,(LINLEN)
        cp      h
        jr      nc,A0AF9
        ret
;
A0B05:  push    hl
        call    A0AEE
        pop     hl
        call    A0C32
        cp      l
        ret     c
        ret     z
        ld      h,001H
        inc     l
        jr      A0B05
;
A0B15:  call    H.ERAF
        xor     a
        call    A0B9C
        ret     nc
        push    hl
        ld      hl,(CRTCNT)
        call    A0AEC
        pop     hl
        ret
;
A0B26:  ld      a,(CNSDFG)
        and     a
        ret     z
A0B2B:  call    H.DSPF
        ld      a,0FFH
        call    A0B9C
        ret     nc
        push    hl
        ld      a,(CSRY)
        ld      hl,CRTCNT
        cp      (hl)
        ld      a,00AH
        jr      nz,A0B41
        rst     OUTDO
A0B41:  ld      a,(NEWKEY+6)
        rrca
        ld      hl,FNKSTR+0*16
        ld      a,001H
        jr      c,A0B50
        ld      hl,FNKSTR+5*16
        xor     a
A0B50:  ld      (FNKSWI),a
        ld      de,LINWRK
        push    de
        ld      b,028H
        ld      a,020H
A0B5B:  ld      (de),a
        inc     de
        djnz    A0B5B
        pop     de
        ld      c,005H
        ld      a,(LINLEN)
        sub     004H
        jr      c,A0B94
        ld      b,0FFH
A0B6B:  inc     b
        sub     005H
        jr      nc,A0B6B
        ld      a,b
        and     a
        jr      z,A0B94
        defb    03EH
A0B75:  inc     de
        push    bc
        ld      c,000H
A0B79:  ld      a,(hl)
        inc     hl
        inc     c
        call    A089D
        jr      nc,A0B79
        jr      nz,A0B87
        cp      020H
        jr      c,A0B88
A0B87:  ld      (de),a
A0B88:  inc     de
        djnz    A0B79
        ld      a,010H
        sub     c
        ld      c,a
        add     hl,bc
        pop     bc
        dec     c
        jr      nz,A0B75
A0B94:  ld      hl,(CRTCNT)
        call    A0BC3
        pop     hl
        ret
;
A0B9C:  ld      (CNSDFG),a
A0B9F:  ld      a,(SCRMOD)
        cp      002H
        ret
;
A0BA5:  push    hl
        ld      c,008H
        jr      A0BB4
;
A0BAA:  push    hl
        ld      h,001H
        call    A0BF2
        ld      a,(LINLEN)
        ld      c,a
A0BB4:  ld      b,000H
        ld      de,LINWRK
        call    A070F
        pop     hl
        ret
;
A0BBE:  push    hl
        ld      c,008H
        jr      A0BCD
;
A0BC3:  push    hl
        ld      h,001H
        call    A0BF2
        ld      a,(LINLEN)
        ld      c,a
A0BCD:  ld      b,000H
        ex      de,hl
        ld      hl,LINWRK
        call    A0744
        pop     hl
        ret
;
A0BD8:  push    hl
        call    A0BF2
        call    A07EC
        ex      (sp),hl
        ex      (sp),hl
        in      a,(098H)
        ld      c,a
        pop     hl
        ret
;
A0BE6:  push    hl
        call    A0BF2
        call    A07DF
        ld      a,c
        out     (098H),a
        pop     hl
        ret
;
A0BF2:  push    bc
        ld      e,h
        ld      h,000H
        ld      d,h
        dec     l
        add     hl,hl
        add     hl,hl
        add     hl,hl
        ld      c,l
        ld      b,h
        add     hl,hl
        add     hl,hl
        add     hl,de
        ld      a,(SCRMOD)
        and     a
        ld      a,(LINLEN)
        jr      z,A0C0D
        sub     022H
        jr      A0C10
;
A0C0D:  add     hl,bc
        sub     02AH
A0C10:  cpl
        and     a
        rra
        ld      e,a
        add     hl,de
        ex      de,hl
        ld      hl,(NAMBAS)
        add     hl,de
        dec     hl
        pop     bc
        ret
;
A0C1D:  push    hl
        ld      de,LINTTB-1
        ld      h,000H
        add     hl,de
        ld      a,(hl)
        ex      de,hl
        pop     hl
        and     a
        ret
;
A0C29:  defb    03EH
A0C2A:  xor     a
A0C2B:  push    af
        call    A0C1D
        pop     af
        ld      (de),a
        ret
;
A0C32:  ld      a,(CNSDFG)
        push    hl
        ld      hl,CRTCNT
        add     a,(hl)
        pop     hl
        ret
;
A0C3C:  push    hl
        push    de
        push    bc
        push    af
        exx
        ex      af,af'
        push    hl
        push    de
        push    bc
        push    af
        push    iy
        push    ix
        call    H.KEYI
        in      a,(099H)
        and     a                       ; vdp interrupt ?
        jp      p,A0D02                 ; nop, quit KEYINT
        call    H.TIMI
        ei
        ld      (STATFL),a              ; save statusregister
        and     020H                    ; sprite collisionflag set ?
        ld      hl,TRPTBL+11*3
        call    nz,C0EF1                ; yep, set sprite event
        ld      hl,(INTCNT)
        dec     hl
        ld      a,h
        or      l                       ; intervaltime passed ?
        jr      nz,A0C73                ; nop, skip
        ld      hl,TRPTBL+17*3
        call    C0EF1                   ; set interval event
        ld      hl,(INTVAL)             ; reload INTCNT
A0C73:  ld      (INTCNT),hl
        ld      hl,(JIFFY)
        inc     hl
        ld      (JIFFY),hl              ; timecounter
        ld      a,(MUSICF)
        ld      c,a
        xor     a                       ; playchannel
A0C82:  rr      c                       ; handle this channel ?
        push    af
        push    bc
        call    c,A113B                 ; yep, do it
        pop     bc
        pop     af
        inc     a
        cp      003H
        jr      c,A0C82                 ; all 3 channels
        ld      hl,SCNCNT
        dec     (hl)                    ; do i have to scan ?
        jr      nz,A0D02                ; nop, quit KEYINT
        ld      (hl),003H               ; next scan after 3 ints
        xor     a
        call    A120C                   ; read joystick 0
        and     030H                    ; only firebuttons
        push    af
        ld      a,001H
        call    A120C                   ; read joystick 1
        and     030H                    ; only firebuttons
        rlca
        rlca
        pop     bc
        or      b
        push    af
        call    A1226                   ; read keyboard row 8
        and     001H                    ; only spacebar
        pop     bc
        or      b
        ld      c,a
        ld      hl,TRGFLG
        xor     (hl)
        and     (hl)
        ld      (hl),c                  ; save triggerflag
        ld      c,a
        rrca                            ; spacebar being pressed ?
        ld      hl,TRPTBL+12*3
        call    c,C0EF1                 ; yep, set STRIG0 event
        rl      c                       ; firebutton 2 B being pressed ?
        ld      hl,TRPTBL+16*3
        call    c,C0EF1                 ; yep, set STRIG4 event
        rl      c
        ld      hl,TRPTBL+14*3
        call    c,C0EF1                 ; yep, set STRIG2 event
        rl      c
        ld      hl,TRPTBL+15*3
        call    c,C0EF1                 ; yep, set STRIG3 event
        rl      c
        ld      hl,TRPTBL+13*3
        call    c,C0EF1                 ; yep, set STRIG1 event
        xor     a
        ld      (CLIKFL),a
        call    A0D12                   ; scan keyboard
        jr      nz,A0D02                ; buffer not empty, quit KEYINT
        ld      hl,REPCNT
        dec     (hl)
        jr      nz,A0D02
        ld      (hl),001H
        ld      hl,OLDKEY
        ld      de,OLDKEY+1
        ld      bc,11-1
        ld      (hl),0FFH
        ldir                            ; create a being pressed
        call    A0D4E
A0D02:  pop     ix
        pop     iy
        pop     af
        pop     bc
        pop     de
        pop     hl
        ex      af,af'
        exx
        pop     af
        pop     bc
        pop     de
        pop     hl
        ei
        ret
;
A0D12:  in      a,(0AAH)
        and     0F0H
        ld      c,a
        ld      b,11
        ld      hl,NEWKEY
A0D1C:  ld      a,c
        out     (0AAH),a
        in      a,(0A9H)
        ld      (hl),a
        inc     c
        inc     hl
        djnz    A0D1C                   ; scan keyboard & put in NEWKEY
        ld      a,(ENSTOP)
        and     a                       ; Hot break possible ?
        jr      z,A0D3A                 ; nop, quit
        ld      a,(NEWKEY+6)
        cp      11101000b               ; CODE+GRAPH+CTRL+SHIFT pressed ?
        jr      nz,A0D3A                ; nop, quit
        ld      ix,J409B                ; start headloop
        jp      A01FF                   ; with CALBAS
;
A0D3A:  ld      de,OLDKEY+11
        ld      b,11
A0D3F:  dec     de
        dec     hl
        ld      a,(de)
        cp      (hl)                    ; changed ?
        jr      nz,A0D49                ; yep, reload REPCNT
        djnz    A0D3F
        jr      A0D4E
;
A0D49:  ld      a,13
        ld      (REPCNT),a
A0D4E:  ld      b,11
        ld      hl,OLDKEY
        ld      de,NEWKEY
A0D56:  ld      a,(de)
        ld      c,a
        xor     (hl)
        and     (hl)                    ; key being pressed ?
        ld      (hl),c                  ; OLDKEY renewed
        call    nz,A0D89                ; yep, handle
        inc     de
        inc     hl
        djnz    A0D56                   ; next row
A0D62:  ld      hl,(GETPNT)
        ld      a,(PUTPNT)
        sub     l                       ; flag buffer empty
        ret
;
A0D6A:  ei
        push    hl
        push    de
        push    bc
        call    A0B9F                   ; graphic mode ?
        jr      nc,A0D82                ; yep, skip functionkeys
        ld      a,(FNKSWI)
        ld      hl,NEWKEY+6
        xor     (hl)                    ; SHIFT changed ?
        ld      hl,CNSDFG
        and     (hl)                    ; display functionkeys ?
        rrca
        call    c,A0B2B                 ; yep, DSPFNK
A0D82:  call    A0D62                   ; flag KEYBUF is empty
        pop     bc
        pop     de
        pop     hl
        ret
;
A0D89:  push    hl
        push    de
        push    bc
        push    af
        ld      a,11
        sub     b                       ; row
        add     a,a
        add     a,a
        add     a,a                     ; *8
        ld      c,a
        ld      b,8
        pop     af
A0D97:  rra                             ; this key being pressed ?
        push    bc
        push    af
        call    c,K.HAND                ; yep, handle key
        pop     af
        pop     bc
        inc     c
        djnz    A0D97                   ; next key in row
        jp      A08DB                   ; quit


        IF      KEYTYP EQ 0

        INCLUDE "keyjap.asm"

        ENDIF


        IF      KEYTYP EQ 1

        INCLUDE "keyint.asm"

        ENDIF


        IF      KEYTYP EQ 2

        INCLUDE "keyfr.asm"

        ENDIF


        IF      KEYTYP EQ 3

        INCLUDE "keyuk.asm"

        ENDIF


        IF      KEYTYP EQ 4

        INCLUDE "keyger.asm"

        ENDIF


        IF      KEYTYP EQ 5

        INCLUDE "keyrus.asm"

        ENDIF


        IF      KEYTYP EQ 6

        INCLUDE "keyspa.asm"

        ENDIF


        ORG     010C2H

C10C2:  inc     hl
        ld      a,l
        cp      LOW (KEYBUF+40)
        ret     nz
        ld      hl,KEYBUF
        ret
;
A10CB:  push    hl
        push    de
        push    bc
        call    H.CHGE
        call    A0D6A
        jr      nz,A10E1
        call    A09DA
A10D9:  call    A0D6A
        jr      z,A10D9
        call    A0A27
A10E1:  ld      hl,INTFLG
        ld      a,(hl)
        cp      004H
        jr      nz,A10EB
        ld      (hl),000H
A10EB:  ld      hl,(GETPNT)
        ld      c,(hl)
        call    C10C2
        ld      (GETPNT),hl
        ld      a,c
        jp      A08DB
;
A10F9:  push    hl
        ld      hl,0
        call    A03FB
        pop     hl
        ret
;
A1102:  di
        out     (0A0H),a
        push    af
        ld      a,e
        out     (0A1H),a
        ei
        pop     af
        ret
;
A110C:  ld      a,00EH
A110E:  out     (0A0H),a
        in      a,(0A2H)
        ret
;
A1113:  xor     a
        ld      e,055H
        call    A1102
        ld      e,a
        inc     a
        call    A1102
        ld      e,0BEH
        ld      a,007H
        call    A1102
        ld      e,a
        inc     a
        call    A1102
        ld      bc,2000
        call    A1133
        jp      A04BD
;
A1133:  dec     bc
        ex      (sp),hl
        ex      (sp),hl
        ld      a,b
        or      c
        jr      nz,A1133
        ret
;
A113B:  ld      b,a                     ; channel
        call    A1470                   ; get voice pointer
        dec     hl
        ld      d,(hl)
        dec     hl
        ld      e,(hl)
        dec     de
        ld      (hl),e
        inc     hl
        ld      (hl),d                  ; decrease voice counter
        ld      a,d
        or      e                       ; counter expires ?
        ret     nz                      ; nop, quit
        ld      a,b
        ld      (QUEUEN),a
        call    A11E2                   ; get byte
        cp      0FFH
        jr      z,A11B0                 ; end byte,
        ld      d,a
        and     0E0H
        rlca
        rlca
        rlca
        ld      c,a                     ; length of packet
        ld      a,d
        and     01FH
        ld      (hl),a                  ; MSB of counter
        call    A11E2                   ; get byte
        dec     hl
        ld      (hl),a                  ; LSB of counter
        inc     c
A1166:  dec     c                       ; packet ends ?
        ret     z                       ; yep, quit
        call    A11E2                   ; get byte
        ld      d,a
        and     0C0H
        jr      nz,A1181                ; not a freqency packet
        call    A11E2                   ; get byte
        ld      e,a
        ld      a,b
        rlca                            ; freqency register
        call    A1102                   ; write PSG register
        inc     a
        ld      e,d
        call    A1102                   ; write PSG register
        dec     c
        jr      A1166                   ; next
;
A1181:  ld      h,a
        and     080H
        jr      z,A1195                 ; not a amplitude packet
        ld      e,d
        ld      a,b
        add     a,008H                  ; amplitude register
        call    A1102                   ; write PSG register
        ld      a,e
        and     010H                    ; modulate ?
        ld      a,00DH
        call    nz,A1102                ; yep, write PSG register 13
A1195:  ld      a,h
        and     040H
        jr      z,A1166                 ; there is no envelope packet, next
        call    A11E2                   ; get byte
        ld      d,a
        call    A11E2                   ; get byte
        ld      e,a
        ld      a,00BH
        call    A1102                   ; write PSG register 11
        inc     a
        ld      e,d
        call    A1102                   ; write PSG register 12
        dec     c
        dec     c
        jr      A1166                   ; next
;
A11B0:  ld      a,b
        add     a,008H                  ; amplitude register
        ld      e,000H
        call    A1102                   ; write PSG register
        inc     b
        ld      hl,MUSICF
        xor     a
        scf
A11BE:  rla
        djnz    A11BE
        and     (hl)
        xor     (hl)
        ld      (hl),a                  ; channel not active
A11C4:  ld      a,(MUSICF)
        or      a                       ; no channel active ?
        ret     nz                      ; nop, quit
        ld      hl,PLYCNT
        ld      a,(hl)
        or      a                       ; strings left ?
        ret     z                       ; nop, quit
        dec     (hl)
        ld      hl,1
        ld      (VCBA+0),hl
        ld      (VCBB+0),hl
        ld      (VCBC+0),hl
        ld      a,007H
        ld      (MUSICF),a
        ret
;
A11E2:  ld      a,(QUEUEN)
        push    hl
        push    de
        push    bc
        call    A14AD
        jp      A08DB
;
A11EE:  dec     a
        jp      m,A1200
        call    A120C
        ld      hl,T1233
A11F8:  and     00FH
        ld      e,a
        ld      d,000H
        add     hl,de
        ld      a,(hl)
        ret
;
A1200:  call    A1226
        rrca
        rrca
        rrca
        rrca
        ld      hl,T1243
        jr      A11F8
;
A120C:  ld      b,a
        ld      a,00FH
        di
        call    A110E
        djnz    A121B
        and     0DFH
        or      04CH
        jr      A121F
;
A121B:  and     0AFH
        or      003H
A121F:  out     (0A1H),a
        call    A110C
        ei
        ret
;
A1226:  di
        in      a,(0AAH)
        and     0F0H
        add     a,008H
        out     (0AAH),a
        in      a,(0A9H)
        ei
        ret
;
T1233:  db      0,5,1,0,3,4,2,3,7,6,8,7,0,5,1,0

T1243:  db      0,3,5,4,1,2,0,3,7,0,6,5,8,1,7,0

A1253:  dec     a
        jp      m,A126C
        push    af
        and     001H
        call    A120C
        pop     bc
        dec     b
        dec     b
        ld      b,010H
        jp      m,A1267
        ld      b,020H
A1267:  and     b
A1268:  sub     001H
        sbc     a,a
        ret
;
A126C:  call    A1226
        and     001H
        jr      A1268
;
A1273:  inc     a
        and     a
        rra
        push    af
        ld      b,a
        xor     a
        scf
A127A:  rla
        djnz    A127A
        ld      b,a
        pop     af
        ld      c,010H
        ld      de,003AFH
        jr      nc,A128B
        ld      c,020H
        ld      de,04C9FH
A128B:  ld      a,00FH
        di
        call    A110E
        and     e
        or      d
        or      c
        out     (0A1H),a
        xor     c
        out     (0A1H),a
        ld      a,00EH
        out     (0A0H),a
        ld      c,000H
A129F:  in      a,(0A2H)
        and     b
        jr      z,A12A9
        inc     c
        jp      nz,A129F
        dec     c
A12A9:  ei
        ld      a,c
        ret
;
A12AC:  cp      004H
        ld      de,00CECH
        jr      c,A12B8
        ld      de,003D3H
        sub     004H
A12B8:  dec     a
        jp      m,A12C5
        dec     a
        ld      a,(PADX)
        ret     m
        ld      a,(PADY)
        ret     z
A12C5:  push    af
        ex      de,hl
        ld      (FILNAM+0),hl
        sbc     a,a
        cpl
        and     040H
        ld      c,a
        ld      a,00FH
        di
        call    A110E
        and     0BFH
        or      c
        out     (0A1H),a
        pop     af
        jp      m,A12E8
        call    A110C
        ei
        and     008H
        sub     001H
        sbc     a,a
        ret
;
A12E8:  ld      c,000H
        call    A1332
        call    A1332
        jr      c,A131A
        call    A1320
        jr      c,A131A
        push    de
        call    A1320
        pop     bc
        jr      c,A131A
        ld      a,b
        sub     d
        jr      nc,A1304
        cpl
        inc     a
A1304:  cp      005H
        jr      nc,A12E8
        ld      a,c
        sub     e
        jr      nc,A130E
        cpl
        inc     a
A130E:  cp      005H
        jr      nc,A12E8
        ld      a,d
        ld      (PADX),a
        ld      a,e
        ld      (PADY),a
A131A:  ei
        ld      a,h
        sub     001H
        sbc     a,a
        ret
;
A1320:  ld      c,00AH
        call    A1332
        ret     c
        ld      d,l
        push    de
        ld      c,000H
        call    A1332
        pop     de
        ld      e,l
        xor     a
        ld      h,a
        ret
;
A1332:  call    A135B
        ld      b,008H
        ld      d,c
A1338:  res     0,d
        res     2,d
        call    A136D
        call    A110C
        ld      h,a
        rra
        rra
        rra
        rl      l
        set     0,d
        set     2,d
        call    A136D
        djnz    A1338
        set     4,d
        set     5,d
        call    A136D
        ld      a,h
        rra
        ret
;
A135B:  ld      a,035H
        or      c
        ld      d,a
        call    A136D
A1362:  call    A110C
        and     002H
        jr      z,A1362
        res     4,d
        res     5,d
A136D:  push    hl
        push    de
        ld      hl,(FILNAM+0)
        ld      a,l
        cpl
        and     d
        ld      d,a
        ld      a,00FH
        out     (0A0H),a
        in      a,(0A2H)
        and     l
        or      d
        or      h
        out     (0A1H),a
        pop     de
        pop     hl
        ret
;
A1384:  and     a
        jp      m,A1392
A1388:  jr      nz,A138D
        ld      a,009H
        defb    0C2H
A138D:  ld      a,008H
        out     (0ABH),a
        ret
;
A1392:  in      a,(0AAH)
        and     010H
        jr      A1388
;
A1398:  call    H.NMI
        retn

A139D:  ld      bc,10*16
        ld      de,FNKSTR
        ld      hl,T13A9
        ldir
        ret
;
T13A9:  db      "color ",0
        ds      16-7,0
        db      "auto ",0
        ds      16-6,0
        db      "goto ",0
        ds      16-6,0
        db      "list ",0
        ds      16-6,0
        db      "run",13,0
        ds      16-5,0

        IF BASVER EQ 0
        DEFM    'color 15,4,7',13,0
        ds      16-14,0
        ELSE
        DEFM    'color 15,4,4',13,0
        ds      16-14,0
        ENDIF
        db      'cload"',0
        ds      16-7,0
        db      "cont",13,0
        ds      16-6,0
        db      "list.",13,30,30,0
        ds      16-9,0
        db      12,"run",13,0
        ds      16-6,0

A1449:  in      a,(099H)
        ret
;
A144C:  in      a,(0A8H)
        ret
;
A144F:  out     (0A8H),a
        ret
;
A1452:  ld      c,a
        di
        in      a,(0AAH)
        and     0F0H
        add     a,c
        out     (0AAH),a
        in      a,(0A9H)
        ei
        ret
;
A145F:  call    H.ISFL
        push    hl
        ld      hl,(PTRFIL)
        ld      a,l
        or      h
        pop     hl
        ret
;
A146A:  ld      a,h
        sub     d
        ret     nz
        ld      a,l
        sub     e
        ret
;
A1470:  ld      l,002H
        jr      A1477
;
A1474:  ld      a,(VOICEN)
A1477:  push    de
        ld      de,VCBA
        ld      h,000H
        add     hl,de
        or      a
        jr      z,A1488
        ld      de,37
A1484:  add     hl,de
        dec     a
        jr      nz,A1484
A1488:  pop     de
        ret
;
A148A:  call    H.PHYD
        ret
;
A148E:  call    H.FORM
        ret
;
A1492:  call    A14FA
        ld      a,b
        inc     a
        inc     hl
        and     (hl)
        cp      c
        ret     z
        push    hl
        dec     hl
        dec     hl
        dec     hl
        ex      (sp),hl
        inc     hl
        ld      c,a
        ld      a,(hl)
        inc     hl
        ld      h,(hl)
        ld      l,a
        ld      b,000H
        add     hl,bc
        ld      (hl),e
        pop     hl
        ld      (hl),c
        ret
;
A14AD:  call    A14FA
        ld      (hl),000H
        jr      nz,A14D1
        ld      a,c
        cp      b
        ret     z
        inc     hl
        inc     a
        and     (hl)
        dec     hl
        dec     hl
        push    hl
        inc     hl
        inc     hl
        inc     hl
        ld      c,a
        ld      a,(hl)
        inc     hl
        ld      h,(hl)
        ld      l,a
        ld      b,000H
        add     hl,bc
        ld      a,(hl)
        pop     hl
        ld      (hl),c
        or      a
        ret     nz
        inc     a
        ld      a,000H
        ret
;
A14D1:  ld      c,a
        ld      b,000H
        ld      hl,QUEBAK-1
        add     hl,bc
        ld      a,(hl)
        ret
;
A14DA:  push    bc
        call    A1504
        ld      (hl),b
        inc     hl
        ld      (hl),b
        inc     hl
        ld      (hl),b
        inc     hl
        pop     af
        ld      (hl),a
        inc     hl
        ld      (hl),e
        inc     hl
        ld      (hl),d
        ret
;
A14EB:  call    A14FA
        ld      a,b
        inc     a
        inc     hl
        and     (hl)
        ld      b,a
        ld      a,c
        sub     b
        and     (hl)
        ld      l,a
        ld      h,000H
        ret
;
A14FA:  call    A1504
        ld      b,(hl)
        inc     hl
        ld      c,(hl)
        inc     hl
        ld      a,(hl)
        or      a
        ret
;
A1504:  rlca
        ld      b,a
        rlca
        add     a,b
        ld      c,a
        ld      b,000H
        ld      hl,(QUEUES)
        add     hl,bc
        ret
;
A1510:  push    hl
        push    de
        push    bc
        push    af
        call    A089D
        jr      nc,A157B
        jr      nz,A1523
        cp      00DH
        jr      z,A157E
        cp      020H
        jr      c,A157B
A1523:  call    A0752
        ld      a,(FORCLR)
        ld      (ATRBYT),a
        ld      hl,(GRPACY)
        ex      de,hl
        ld      bc,(GRPACX)
        call    A1599
        jr      nc,A157B
        call    A15DF
        ld      de,PATWRK
        ld      c,008H
A1541:  ld      b,008H
        call    A1639
        push    hl
        push    af
        ld      a,(de)
A1549:  add     a,a
        push    af
        call    c,A167E
        call    A16AC
        pop     hl
        jr      c,A1558
        push    hl
        pop     af
        djnz    A1549
A1558:  pop     af
        pop     hl
        call    A1640
        call    A170A
        jr      c,A1566
        inc     de
        dec     c
        jr      nz,A1541
A1566:  call    A15D9
        ld      a,(GRPACX)
        jr      z,A1574
        add     a,020H
        jr      c,A157E
        jr      A1578
;
A1574:  add     a,008H
        jr      c,A157E
A1578:  ld      (GRPACX),a
A157B:  jp      A08DA
;
A157E:  xor     a
        ld      (GRPACX),a
        call    A15D9
        ld      a,(GRPACY)
        jr      z,A158D
        add     a,020H
        db      001H
A158D:  add     a,008H
        cp      0C0H
        jr      c,A1594
        xor     a
A1594:  ld      (GRPACY),a
        jr      A157B
;
A1599:  push    hl
        push    bc
        ld      b,001H
        ex      de,hl
        ld      a,h
        add     a,a
        jr      nc,A15A7
        ld      hl,0
        jr      A15AF
;
A15A7:  ld      de,192
        rst     DCOMPR
        jr      c,A15B1
        ex      de,hl
        dec     hl
A15AF:  ld      b,000H
A15B1:  ex      (sp),hl
        ld      a,h
        add     a,a
        jr      nc,A15BB
        ld      hl,0
        jr      A15C3
;
A15BB:  ld      de,256
        rst     DCOMPR
        jr      c,A15C5
        ex      de,hl
        dec     hl
A15C3:  ld      b,000H
A15C5:  pop     de
        call    A15D9
        jr      z,A15D3
        srl     l
        srl     l
        srl     e
        srl     e
A15D3:  ld      a,b
        rrca
        ld      b,h
        ld      c,l
        pop     hl
        ret
;
A15D9:  ld      a,(SCRMOD)
        sub     002H
        ret
;
A15DF:  push    bc
        call    A15D9
        jr      nz,A1613
        ld      d,c
        ld      a,c
        and     007H
        ld      c,a
        ld      hl,T160B
        add     hl,bc
        ld      a,(hl)
        ld      (CMASK),a
        ld      a,e
        rrca
        rrca
        rrca
        and     01FH
        ld      b,a
        ld      a,d
        and     0F8H
        ld      c,a
        ld      a,e
        and     007H
        or      c
        ld      c,a
        ld      hl,(GRPCGP)
        add     hl,bc
        ld      (CLOC),hl
        pop     bc
        ret
;
T160B:  db      10000000b
        db      01000000b
        db      00100000b
        db      00010000b
        db      00001000b
        db      00000100b
        db      00000010b
        db      00000001b

A1613:  ld      a,c
        rrca
        ld      a,0F0H
        jr      nc,A161B
        ld      a,00FH
A161B:  ld      (CMASK),a
        ld      a,c
        add     a,a
        add     a,a
        and     0F8H
        ld      c,a
        ld      a,e
        and     007H
        or      c
        ld      c,a
        ld      a,e
        rrca
        rrca
        rrca
        and     007H
        ld      b,a
        ld      hl,(MLTCGP)
        add     hl,bc
        ld      (CLOC),hl
        pop     bc
        ret
;
A1639:  ld      a,(CMASK)
        ld      hl,(CLOC)
        ret
;
A1640:  ld      (CMASK),a
        ld      (CLOC),hl
        ret
;
A1647:  push    bc
        push    hl
        call    A1639
        ld      b,a
        call    A15D9
        jr      nz,A166C
        call    A07D7
        and     b
        push    af
        ld      bc,02000H
        add     hl,bc
        call    A07D7
        ld      b,a
        pop     af
        ld      a,b
        jr      z,A1667
A1663:  rrca
        rrca
        rrca
        rrca
A1667:  and     00FH
        pop     hl
        pop     bc
        ret
;
A166C:  call    A07D7
        inc     b
        dec     b
        jp      p,A1667
        jr      A1663
;
A1676:  cp      010H
        ccf
        ret     c
        ld      (ATRBYT),a
        ret
;
A167E:  push    hl
        push    bc
        call    A15D9
        call    A1639
        jr      nz,A1690
        push    de
        call    A186C
        pop     de
        pop     bc
        pop     hl
        ret
;
A1690:  ld      b,a
        call    A07D7
        ld      c,a
        ld      a,b
        cpl
        and     c
        ld      c,a
        ld      a,(ATRBYT)
        inc     b
        dec     b
        jp      p,A16A5
        add     a,a
        add     a,a
        add     a,a
        add     a,a
A16A5:  or      c
        call    A07CD
        pop     bc
        pop     hl
        ret
;
A16AC:  push    hl
        call    A15D9
        jp      nz,A1779
        call    A1639
        rrca
        jr      nc,A1704
        ld      a,l
        and     0F8H
        cp      0F8H
        ld      a,080H
        jr      nz,A16D2
        jp      A175A
;
A16C5:  push    hl
        call    A15D9
        jp      nz,A178B
        call    A1639
        rrca
        jr      nc,A1704
A16D2:  push    de
        ld      de,8
        jr      A16FF
;
A16D8:  push    hl
        call    A15D9
        jp      nz,A179C
        call    A1639
        rlca
        jr      nc,A1704
        ld      a,l
        and     0F8H
        ld      a,001H
        jr      nz,A16FB
        jr      A175A
;
A16EE:  push    hl
        call    A15D9
        jp      nz,A17AC
        call    A1639
        rlca
        jr      nc,A1704
A16FB:  push    de
        ld      de,-8
A16FF:  add     hl,de
        ld      (CLOC),hl
        pop     de
A1704:  ld      (CMASK),a
        and     a
        pop     hl
        ret
;
A170A:  push    hl
        push    de
        ld      hl,(CLOC)
        call    A15D9
        jp      nz,A17C6
        push    hl
        ld      hl,(GRPCGP)
        ld      de,256*24-256
        add     hl,de
        ex      de,hl
        pop     hl
        rst     DCOMPR
        jr      c,A1735
        ld      a,l
        inc     a
        and     007H
        jr      nz,A1735
        jr      A1759
;
A172A:  push    hl
        push    de
        ld      hl,(CLOC)
        call    A15D9
        jp      nz,A17DC
A1735:  inc     hl
        ld      a,l
        ld      de,248
        jr      A176D
;
A173C:  push    hl
        push    de
        ld      hl,(CLOC)
        call    A15D9
        jp      nz,A17E3
        push    hl
        ld      hl,(GRPCGP)
        ld      de,256
        add     hl,de
        ex      de,hl
        pop     hl
        rst     DCOMPR
        jr      nc,A1768
        ld      a,l
        and     007H
        jr      nz,A1768
A1759:  pop     de
A175A:  scf
        pop     hl
        ret
;
A175D:  push    hl
        push    de
        ld      hl,(CLOC)
        call    A15D9
        jp      nz,A17F8
A1768:  ld      a,l
        dec     hl
        ld      de,-248
A176D:  and     007H
        jr      nz,A1772
        add     hl,de
A1772:  ld      (CLOC),hl
        and     a
        pop     de
        pop     hl
        ret
;
A1779:  call    A1639
        and     a
        ld      a,00FH
        jp      m,A17C0
        ld      a,l
        and     0F8H
        cp      0F8H
        jr      nz,A1794
        jr      A175A
;
A178B:  call    A1639
        and     a
        ld      a,00FH
        jp      m,A17C0
A1794:  push    de
        ld      de,8
        ld      a,0F0H
        jr      A17BB
;
A179C:  call    A1639
        and     a
        ld      a,0F0H
        jp      p,A17C0
        ld      a,l
        and     0F8H
        jr      nz,A17B5
        jr      A175A
;
A17AC:  call    A1639
        and     a
        ld      a,0F0H
        jp      p,A17C0
A17B5:  push    de
        ld      de,-8
        ld      a,00FH
A17BB:  add     hl,de
        ld      (CLOC),hl
        pop     de
A17C0:  ld      (CMASK),a
        and     a
        pop     hl
        ret
;
A17C6:  push    hl
        ld      hl,(MLTCGP)
        ld      de,64*24-256
        add     hl,de
        pop     hl
        rst     DCOMPR
        jr      c,A17DC
        ld      a,l
        inc     a
        and     007H
        jr      nz,A17DC
        scf
        pop     de
        pop     hl
        ret
;
A17DC:  inc     hl
        ld      a,l
        ld      de,248
        jr      A17FD
;
A17E3:  push    hl
        ld      hl,(MLTCGP)
        ld      de,256
        add     hl,de
        pop     hl
        rst     DCOMPR
        jr      nc,A17F8
        ld      a,l
        and     007H
        jr      nz,A17F8
        scf
        pop     de
        pop     hl
        ret
;
A17F8:  ld      a,l
        dec     hl
        ld      de,-248
A17FD:  and     007H
        jr      nz,A1802
        add     hl,de
A1802:  ld      (CLOC),hl
        and     a
        pop     de
        pop     hl
        ret
;
A1809:  call    A15D9
        jp      nz,A18BB
        push    hl
        call    A1639
        ex      (sp),hl
        add     a,a
        jr      c,A182F
        push    af
        ld      bc,-1
        rrca
A181C:  add     hl,bc
        jr      nc,A1864
        rrca
        jr      nc,A181C
        pop     af
        dec     a
        ex      (sp),hl
        push    hl
        call    A186C
        pop     hl
        ld      de,8
        add     hl,de
        ex      (sp),hl
A182F:  ld      a,l
        and     007H
        ld      c,a
        ld      a,h
        rrca
        ld      a,l
        rra
        rrca
        rrca
        and     03FH
        pop     hl
        ld      b,a
        jr      z,A1853
A183F:  xor     a
        call    A07CD
        ld      de,02000H
        add     hl,de
        ld      a,(ATRBYT)
        call    A07CD
        ld      de,02008H
        add     hl,de
        djnz    A183F
A1853:  dec     c
        ret     m
        push    hl
        ld      hl,T185D
        add     hl,bc
        ld      a,(hl)
        jr      A186B
;
T185D:  db      10000000b
        db      11000000b
        db      11100000b
        db      11110000b
        db      11111000b
        db      11111100b
        db      11111110b

A1864:  add     a,a
        dec     a
        cpl
        ld      b,a
        pop     af
        dec     a
        and     b
A186B:  pop     hl
A186C:  ld      b,a
        call    A07D7
        ld      c,a
        ld      de,02000H
        add     hl,de
        call    A07D7
        push    af
        and     00FH
        ld      e,a
        pop     af
        sub     e
        ld      d,a
        ld      a,(ATRBYT)
        cp      e
        jr      z,A189E
        add     a,a
        add     a,a
        add     a,a
        add     a,a
        cp      d
        jr      z,A18A2
        push    af
        ld      a,b
        or      c
        cp      0FFH
        jr      z,A18AA
        push    hl
        push    de
        call    A18A2
        pop     de
        pop     hl
        pop     af
        or      e
        jr      A18B8
;
A189E:  ld      a,b
        cpl
        and     c
        db      011H
A18A2:  ld      a,b
        or      c
A18A4:  ld      de,02000H
        add     hl,de
        jr      A18B8
;
A18AA:  pop     af
        ld      a,b
        cpl
        push    hl
        push    de
        call    A18A4
        pop     de
        pop     hl
        ld      a,(ATRBYT)
        or      d
A18B8:  jp      A07CD
;
A18BB:  push    hl
        call    A167E
        call    A16C5
        pop     hl
        dec     l
        jr      nz,A18BB
        ret
;
A18C7:  ld      hl,(ASPCT1)
        ex      de,hl
        ld      hl,(ASPCT2)
        ret
;
A18CF:  push    af
        call    A15D9
        jr      z,A18DB
        pop     af
        cp      010H
        ccf
        jr      A18E0
;
A18DB:  pop     af
        ld      a,(ATRBYT)
        and     a
A18E0:  ld      (BRDATR),a
        ret
;
A18E4:  ld      hl,0
        ld      c,l
        call    A15D9                   ; grafic mode ?
        jr      nz,A1951                ; nop
        ld      a,b
        ld      (FILNAM+0),a
        xor     a
        ld      (FILNAM+3),a
        ld      a,(BRDATR)
        ld      b,a
A18F9:  call    A1647                   ; get color of pixel
        cp      b                       ; is border color ?
        jr      nz,A190C                ; nop,
        dec     de
        ld      a,d
        or      e                       ; skipped all ?
        ret     z                       ; yep, quit
        call    A16AC                   ; move right
        jr      nc,A18F9                ; not out of screen, cont
        ld      de,0
        ret
;
A190C:  call    A19AE
        push    de
        call    A1639                   ; get pixel adres & mask
        ld      (CSAVEA),hl
        ld      (CSAVEM),a              ; save it
        ld      de,0
A191C:  inc     de
        call    A16AC                   ; move right
        jr      c,A192D                 ; out of screen,
        call    A1647                   ; get pixel color
        cp      b                       ; is border color ?
        jr      z,A192D                 ; yep,
        call    A19AE
        jr      A191C
;
A192D:  push    de
        call    A1639                   ; get pixel adres & mask
        push    hl
        push    af                      ; save
        ld      hl,(CSAVEA)
        ld      a,(CSAVEM)
        call    A1640                   ; set pixel adres & mask
        ex      de,hl
        ld      (FILNAM+1),hl
        ld      a,(FILNAM+0)
        and     a
        call    nz,A1809
        pop     af
        pop     hl
        call    A1640
        pop     hl
        pop     de
        jp      A19A9
;
A1951:  call    A19C7
        jr      nc,A1963
        dec     de
        ld      a,d
        or      e
        ret     z
        call    A16AC
        jr      nc,A1951
        ld      de,0
        ret
;
A1963:  call    A1639
        ld      (CSAVEA),hl
        ld      (CSAVEM),a
        ld      hl,0
A196F:  inc     hl
        call    A16AC
        ret     c
        call    A19C7
        jr      nc,A196F
        ret
;
A197A:  ld      hl,0
        ld      c,l
        call    A15D9
        jr      nz,A19BA
        xor     a
        ld      (FILNAM+3),a
        ld      a,(BRDATR)
        ld      b,a
A198B:  call    A16D8
        jr      c,A199F
        call    A1647
        cp      b
        jr      z,A199C
        call    A19AE
        inc     hl
        jr      A198B
;
A199C:  call    A16C5
A199F:  push    hl
        ld      de,(FILNAM+1)
        add     hl,de
        call    A1809
        pop     hl
A19A9:  ld      a,(FILNAM+3)
        ld      c,a
        ret
;
A19AE:  push    hl
        ld      hl,ATRBYT
        cp      (hl)
        pop     hl
        ret     z
        inc     a
        ld      (FILNAM+3),a
        ret
;
A19BA:  call    A16D8
        ret     c
        call    A19C7
        jp      c,A16C5
        inc     hl
        jr      A19BA
;
A19C7:  call    A1647
        ld      b,a
        ld      a,(BRDATR)
        sub     b
        scf
        ret     z
        ld      a,(ATRBYT)
        cp      b
        ret     z
        call    A167E
        ld      c,001H
        and     a
        ret
;
A19DD:  push    bc
        push    af
        ld      bc,0
A19E2:  dec     bc
        ld      a,b
        or      c
        jr      nz,A19E2                ; wait 550 msec
        pop     af
        pop     bc                      ; cassettemotor off

A19E9:  push    af
        ld      a,009H
        out     (0ABH),a
        pop     af
        ei
        ret
;
A19F1:  or      a
        push    af                      ; flag for headerlength
        ld      a,008H
        out     (0ABH),a                ; cassettemotor on
        ld      hl,0
A19FA:  dec     hl
        ld      a,h
        or      l
        jr      nz,A19FA                ; wait 550 msec
        pop     af
        ld      a,(HEADER)              ; headerlength
        jr      z,A1A07                 ; short header
        add     a,a
        add     a,a                     ; *4 for long header
A1A07:  ld      b,a
        ld      c,000H                  ; *256 = # of cycli
        di
A1A0B:  call    A1A4D                   ; high cycle
        call    A1A3F                   ; wait
        dec     bc
        ld      a,b
        or      c
        jr      nz,A1A0B                ; next cyclus
        jp      A046F                   ; quit with BREAKX
;
A1A19:  ld      hl,(LOW.)               ; size of low cycle
        push    af
        ld      a,l
        sub     00EH
        ld      l,a                     ; 14 units shorter
        call    A1A50                   ; low cycle (start bit)
        pop     af
        ld      b,8                     ; 8 bits data
A1A27:  rrca
        call    c,A1A40                 ; 1, write mark
        call    nc,A1A39                ; 0, write space
        djnz    A1A27                   ; next bit
        call    A1A40
        call    A1A40                   ; write 2 marks (stopbits)
        jp      A046F                   ; quit with BREAKX
;
A1A39:  ld      hl,(LOW.)               ; low cycle size
        call    A1A50                   ; write low cycle
A1A3F:  ret
;
A1A40:  call    A1A4D                   ; write high cycle
        ex      (sp),hl
        ex      (sp),hl
        nop
        nop
        nop
        nop                             ; wait
        call    A1A4D                   ; write high cycle
        ret
;
A1A4D:  ld      hl,(HIGH.)              ; length of high cycle
A1A50:  push    af
A1A51:  dec     l
        jp      nz,A1A51                ; wait low part
        ld      a,00BH
        out     (0ABH),a                ; high
A1A59:  dec     h
        jp      nz,A1A59                ; wait high part
        ld      a,00AH
        out     (0ABH),a                ; low
        pop     af
        ret
;
A1A63:  ld      a,008H
        out     (0ABH),a                ; cassettemotor on
        di
        ld      a,00EH
        out     (0A0H),a                ; select register 14 of PSG
A1A6C:  ld      hl,1111
A1A6F:  ld      d,c
        call    A1B34                   ; count length of cycle
        ret     c                       ; break, quit
        ld      a,c
        cp      222
        jr      nc,A1A6C                ; illegal, start again
        cp      4+1
        jr      c,A1A6C                 ; illegal, start again
        sub     d                       ; compare with previous cycle
        jr      nc,A1A82
        cpl
        inc     a
A1A82:  cp      4                       ; difer less then 35 sec ?
        jr      nc,A1A6C                ; nop, start again
        dec     hl
        ld      a,h
        or      l                       ; all 1111 cycles tollerant ?
        jr      nz,A1A6F                ; nop, cont
        ld      hl,0
        ld      b,l
        ld      d,l                     ; 256
A1A90:  call    A1B34                   ; count length of cycle
        ret     c                       ; break, quit
        add     hl,bc                   ; add to total
        dec     d
        jp      nz,A1A90                ; next cycle
        ld      bc,1710
        add     hl,bc                   ; add extra for calc
        ld      a,h
        rra
        and     07FH
        ld      d,a                     ; /2
        add     hl,hl                   ; *2
        ld      a,h
        sub     d                       ; = 1.5*
        ld      d,a
        sub     6                       ; - extra
        ld      (LOWLIM),a              ; min. size of startbit
        ld      a,d
        add     a,a
        ld      b,000H
A1AAF:  sub     3
        inc     b
        jr      nc,A1AAF
        ld      a,b
        sub     3
        ld      (WINWID),a
        or      a
        ret
;
A1ABC:  ld      a,(LOWLIM)
        ld      d,a                     ; min. size of startbit
A1AC0:  call    A046F                   ; BREAKX
        ret     c                       ; break, quit
        in      a,(0A2H)
        rlca
        jr      nc,A1AC0                ; wait for high
A1AC9:  call    A046F                   ; BREAKX
        ret     c                       ; break, quit
        in      a,(0A2H)
        rlca
        jr      c,A1AC9                 ; wait for low
        ld      e,000H
        call    A1B1F                   ; count length of cycle
A1AD7:  ld      b,c
        call    A1B1F                   ; count length of cycle
        ret     c                       ; break, quit
        ld      a,b
        add     a,c                     ; size of two cycles
        jp      c,A1AD7                 ; illegal, try again
        cp      d                       ; > as LOWLIM ?
        jr      c,A1AD7                 ; nop, try again
        ld      l,8                     ; 8 bits
A1AE6:  call    A1B03                   ; count transitions
        cp      4
        ccf
        ret     c                       ; illegal, quit
        cp      2
        ccf                             ; databit
        rr      d
        ld      a,c
        rrca                            ; even transitions ?
        call    nc,A1B23                ; yep, skip 1 transitions
        call    A1B1F                   ; skip 1 transitions
        dec     l
        jp      nz,A1AE6                ; next bit
        call    A046F                   ; BREAKX
        ld      a,d
        ret
;
A1B03:  ld      a,(WINWID)
        ld      b,a
        ld      c,000H
A1B09:  in      a,(0A2H)
        xor     e
        jp      p,A1B17
        ld      a,e
        cpl
        ld      e,a
        inc     c
        djnz    A1B09
        ld      a,c
        ret
;
A1B17:  nop
        nop
        nop
        nop
A1B1B:  djnz    A1B09
        ld      a,c
        ret
;
A1B1F:  call    A046F
        ret     c
A1B23:  ld      c,000H
A1B25:  inc     c
        jr      z,A1B32
        in      a,(0A2H)
        xor     e
        jp      p,A1B25
        ld      a,e
        cpl
        ld      e,a
        ret
;
A1B32:  dec     c
        ret
;
A1B34:  call    A046F                   ; BREAKX
        ret     c                       ; break, quit
        in      a,(0A2H)
        rlca
        jr      c,A1B34                 ; wait until casinput = 0
        ld      e,000H
        call    A1B23                   ; count to high input
        jp      A1B25                   ; add count to low input
;
A1B45:  push    af
        call    H.OUTD
        call    A145F                   ; is file output ?
        jr      z,A1B56                 ; nop,
        pop     af
        ld      ix,C6C48                ; seq. output
        jp      A01FF                   ; with CALBAS
;
A1B56:  ld      a,(PRTFLG)
        or      a                       ; output to printer ?
        jr      z,A1BBB                 ; nop
        ld      a,(RAWPRT)
        and     a                       ; data raw to printer ?
        jr      nz,A1BAB                ; yep, to printer
        pop     af
A1B63:  push    af
        cp      009H                    ; tab ?
        jr      nz,A1B76                ; nop
A1B68:  ld      a,020H
        call    A1B63
        ld      a,(LPTPOS)
        and     007H
        jr      nz,A1B68                ; print spaces
        pop     af
        ret
;
A1B76:  sub     00DH
        jr      z,A1B84                 ; cr, LPTPOS = 0
        jr      c,A1B87
        cp      013H
        jr      c,A1B87                 ; control char, don't increase
        ld      a,(LPTPOS)
        inc     a                       ; increase LPTPOS
A1B84:  ld      (LPTPOS),a
A1B87:  ld      a,(NTMSXP)
        and     a                       ; MSX printer ?
        jr      z,A1BAB                 ; yep, to printer
        pop     af
        call    A089D                   ; is grafic header ?
        ret     nc                      ; header, quit
        jr      nz,J1BB7                ; grafic char, print space


        IF      KEYTYP EQ 0

; *************************************
; *************************************


        AND     A
        JP      P,J1BAC                 ; plain ascii, print
        CP      86H
        JR      C,J1BB7                 ; 80H-85H, print space
        CP      0A0H                    ; 86H-9FH ?
        JR      NC,J1BA4                ; nope,
        ADD     A,20H
        JR      J1BAC                   ; adjust to A6H-BFH and print

J1BA4:  CP      0E0H                    ; E0H-FFH ?
        JR      C,J1BAC                 ; nope, print
        SUB     20H                     ; adjust to C0H-DFH
        DEFB    038H                    ; JR C,xxxx (skip next instruction)


; *************************************
; *************************************

        ENDIF

        ORG     01BABH

A1BAB:  pop     af
J1BAC:  call    A085D                   ; to printer
        ret     nc                      ; no break, quit
        ld      ix,J73B2                ; Device I/O error
        jp      A01FF                   ; via CALBAS
;
J1BB7:  ld      a,020H
        jr      J1BAC
;
A1BBB:  pop     af
        jp      A08BC

T1BBF:


        IF      CNTRY EQ 9

        INCLUDE "chrkor.asm"

        ENDIF


        IF      CNTRY EQ 0

        INCLUDE "chrjapv2.asm"

        ENDIF


        IF      CNTRY EQ 10

        INCLUDE "chrrus.asm"

        ENDIF


        IF      CNTRY EQ 5

        INCLUDE "chrger.asm"

        ENDIF


        IF      (CNTRY NE 9) AND (CNTRY NE 0) AND (CNTRY NE 10) AND (CNTRY NE 5)

        INCLUDE "chrint.asm"

        ENDIF


A23BF:  call    H.PINL
        ld      a,(AUTFLG)
        and     a
        jr      nz,A23D5
        ld      l,000H
        jr      A23E0
;
A23CC:  call    H.QINL
        ld      a,'?'
        rst     OUTDO
        ld      a,' '
        rst     OUTDO
;
A23D5:  call    H.INLI
        ld      hl,(CSRY)
        dec     l
        call    nz,A0C29                ; no extend on next line
        inc     l
A23E0:  ld      (FSTPOS),hl
        xor     a
        ld      (INTFLG),a
A23E7:  call    A10CB                   ; get char
        ld      hl,T2439-2
        ld      c,00BH
        call    A0919
        push    af
        call    nz,A23FF
        pop     af
        jr      nc,A23E7
        ld      hl,BUFMIN
        ret     z
        ccf
A23FE:  ret
;
A23FF:  push    af
        cp      009H
        jr      nz,A2413
        pop     af
A2405:  ld      a,020H
        call    A23FF
        ld      a,(CSRX)
        dec     a
        and     007H
        jr      nz,A2405
        ret
;
A2413:  pop     af
        ld      hl,INSFLG
        cp      001H
        jr      z,A2426
        cp      020H
        jr      c,A2428
        push    af
        ld      a,(hl)
        and     a
        call    nz,A24F2
        pop     af
A2426:  rst     OUTDO
        ret
;
A2428:  ld      (hl),000H
        rst     OUTDO
        defb    03EH
A242C:  defb    03EH
A242D:  xor     a
        push    af
        call    A0A2E                   ; cursor off
        pop     af
        ld      (CSTYLE),a
        jp      A09E1                   ; cursor on
;
T2439:  db      008H
        dw      A2561
        db      012H
        dw      A24E5
        db      01BH
        dw      A23FE
        db      002H
        dw      A260E
        db      006H
        dw      A25F8
        db      00EH
        dw      A25D7
        db      005H
        dw      A25B9
        db      003H
        dw      A24C5
        db      00DH
        dw      A245A
        db      015H
        dw      A25AE
        db      07FH
        dw      A2550

A245A:  call    A266C
        ld      a,(AUTFLG)
        and     a
        jr      z,A2465
        ld      h,001H
A2465:  push    hl
        call    A0A2E                   ; cursor off
        pop     hl
        ld      de,BUF
        ld      b,0FEH
        dec     l
A2470:  inc     l
A2471:  push    de
        push    bc
        call    A0BD8                   ; read char from VRAM
        pop     bc
        pop     de
        and     a
        jr      z,A248F
        cp      020H
        jr      nc,A248A
        dec     b
        jr      z,A249F
        ld      c,a
        ld      a,001H
        ld      (de),a
        inc     de
        ld      a,c
        add     a,040H
A248A:  ld      (de),a
        inc     de
        dec     b
        jr      z,A249F
A248F:  inc     h
        ld      a,(LINLEN)
        cp      h
        jr      nc,A2471
        push    de
        call    A0C1D                   ; extend at next line ?
        pop     de
        ld      h,001H
        jr      z,A2470
A249F:  dec     de
        ld      a,(de)
        cp      020H
        jr      z,A249F
        push    hl
        push    de
        call    A09E1                   ; cursor on
        pop     de
        pop     hl
        inc     de
        xor     a
        ld      (de),a
A24AF:  ld      a,00DH
        and     a
A24B2:  push    af
        call    A0C29                   ; no extend on next line
        call    A088E                   ; put cursor
        ld      a,00AH
        rst     OUTDO
        xor     a
        ld      (INSFLG),a
        pop     af
        scf
        pop     hl
        ret
;
A24C4:  inc     l
A24C5:  call    A0C1D                   ; extends in next line ?
        jr      z,A24C4
        call    A242D
        xor     a
        ld      (BUF),a
        ld      h,001H
        push    hl
        call    A04BD
        call    A0454
        pop     hl
        jr      c,A24AF
        ld      a,(BASROM)
        and     a
        jr      nz,A24AF
        jr      A24B2

A24E5:  ld      hl,INSFLG
        ld      a,(hl)
        xor     0FFH
        ld      (hl),a
        jp      z,A242D
        jp      A242C
;
A24F2:  call    A0A2E                   ; cursor off
        ld      hl,(CSRY)
        ld      c,020H
A24FA:  push    hl
A24FB:  push    bc
        call    A0BD8                   ; read char from VRAM
        pop     de
        push    bc
        ld      c,e
        call    A0BE6                   ; calc VRAM adres
        pop     bc
        ld      a,(LINLEN)
        inc     h
        cp      h
        ld      a,d
        jr      nc,A24FB
        pop     hl
        call    A0C1D                   ; extend in next line ?
        jr      z,A254B
        ld      a,c
        cp      020H
        push    af
        jr      nz,A2524
        ld      a,(LINLEN)
        cp      h
        jr      z,A2524
        pop     af
        jp      A09E1                   ; cursor on
;
A2524:  call    A0C2A                   ; extend on next line
        inc     l
        push    bc
        push    hl
        call    A0C32                   ; max linenumber
        cp      l
        jr      c,A2535
        call    A0AB7
        jr      A2544
;
A2535:  ld      hl,CSRY
        dec     (hl)
        jr      nz,A253C
        inc     (hl)
A253C:  ld      l,001H
        call    A0A88
        pop     hl
        dec     l
        push    hl
A2544:  pop     hl
        pop     bc
        pop     af
        jp      z,A09E1                 ; cursor on
        dec     l
A254B:  inc     l
        ld      h,001H
        jr      A24FA

A2550:  ld      a,(LINLEN)
        cp      h
        jr      nz,A255B
        call    A0C1D                   ; extend in next line ?
        jr      nz,A2595
A255B:  ld      a,01CH
        rst     OUTDO
        ld      hl,(CSRY)
A2561:  push    hl
        call    A0A2E                   ; cursor off
        pop     hl
        dec     h
        jp      nz,A257A
        inc     h
        push    hl
        dec     l
        jr      z,A2579
        ld      a,(LINLEN)
        ld      h,a
        call    A0C1D                   ; extend on next line ?
        jr      nz,A2579
        ex      (sp),hl
A2579:  pop     hl
A257A:  ld      (CSRY),hl
A257D:  ld      a,(LINLEN)
        cp      h
        jr      z,A2595
        inc     h
A2584:  call    A0BD8                   ; read char from VRAM
        dec     h
        call    A0BE6                   ; calc VRAM adres
        inc     h
        inc     h
        ld      a,(LINLEN)
        inc     a
        cp      h
        jr      nz,A2584
        dec     h
A2595:  ld      c,020H
        call    A0BE6                   ; calc VRAM adres
        call    A0C1D                   ; extend on next line ?
        jp      nz,A09E1                ; cursor on
        push    hl
        inc     l
        ld      h,001H
        call    A0BD8                   ; read char from VRAM
        ex      (sp),hl
        call    A0BE6                   ; calc VRAM adres
        pop     hl
        jr      A257D

A25AE:  call    A0A2E                   ; cursor off
        call    A266C
        ld      (CSRY),hl
        jr      A25BE

A25B9:  push    hl
        call    A0A2E                   ; cursor off
        pop     hl
A25BE:  call    A0C1D                   ; extend on next line ?
        push    af
        call    A0AEE                   ; clear to end of line
        pop     af
        jr      nz,A25CD
        ld      h,001H
        inc     l
        jr      A25BE
;
A25CD:  call    A09E1                   ; cursor on
        xor     a
        ld      (INSFLG),a
        jp      A242D

A25D7:  call    A0A2E                   ; cursor off
        ld      hl,(CSRY)
        dec     l
A25DE:  inc     l
        call    A0C1D                   ; extend on next line ?
        jr      z,A25DE
        ld      a,(LINLEN)
        ld      h,a
        inc     h
A25E9:  dec     h
        jr      z,A25F3
        call    A0BD8                   ; read char from VRAM
        cp      020H
        jr      z,A25E9
A25F3:  call    A0A5B                   ; cursor right
        jr      A25CD

A25F8:  call    A0A2E                   ; cursor off
        call    A2634
A25FE:  call    A2624
        jr      z,A25CD
        jr      c,A25FE
A2605:  call    A2624
        jr      z,A25CD
        jr      nc,A2605
        jr      A25CD

A260E:  call    A0A2E                   ; cursor off
A2611:  call    A2634
        jr      z,A25CD
        jr      nc,A2611
A2618:  call    A2634
        jr      z,A25CD
        jr      c,A2618
        call    A0A5B                   ; cursor right
        jr      A25CD
;
A2624:  ld      hl,(CSRY)
        call    A0A5B                   ; cursor right
        call    A0C32                   ; max linenumber
        ld      e,a
        ld      a,(LINLEN)
        ld      d,a
        jr      A263D
;
A2634:  ld      hl,(CSRY)
        call    A0A4C                   ; cursor left
        ld      de,00101H
A263D:  ld      hl,(CSRY)
        rst     DCOMPR
        ret     z
        ld      de,A2668
        push    de
        call    A0BD8                   ; read char from VRAM
        cp      030H
        ccf
        ret     nc
        cp      03AH
        ret     c
        cp      041H
        ccf
        ret     nc
        cp      05BH
        ret     c
        cp      061H
        ccf
        ret     nc
        cp      07BH
        ret     c
        cp      086H
        ccf
        ret     nc
        cp      0A0H
        ret     c
        cp      0A6H
        ccf
A2668:  ld      a,000H
        inc     a
        ret
;
A266C:  dec     l
        jr      z,A2674
        call    A0C1D                   ; extend on next line ?
        jr      z,A266C
A2674:  inc     l
        ld      a,(FSTPOS)
        cp      l
        ld      h,001H
        ret     nz
        ld      hl,(FSTPOS)
        ret
;
A2680:  jp      C7C76
;
A2683:  jp      C558C
;
A2686:  jp      C4666
;
A2689:  jp      C5597

