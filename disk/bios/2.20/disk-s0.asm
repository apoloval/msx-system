; DISK-S0.ASM
;
; DOS 2.20 kernel bank 0 (ASCII version)
;
; Source re-created by Z80DIS 2.2
; Z80DIS was written by Kenneth Gielow, Palo Alto, CA
;
; Code Copyrighted by ASCII and maybe others
; Source comments by Arjen Zeilemaker
;
; Sourcecode supplied for STUDY ONLY
; Recreation NOT permitted without authorisation of the copyrightholders
;

DOS2    EQU     1               ; DOS2 flag for diskdriver

        .Z80
        ASEG
        ORG     04000H

D.0000  EQU     0000H   ; --SLI
I.0001  EQU     0001H   ; ----I
I$0004  EQU     0004H   ; ----I
RDSLT   EQU     000CH
CALSLT  EQU     001CH
ENASLT  EQU     0024H
IDBYT0  EQU     002BH   ; ---L-
IDBYT2  EQU     002DH   ; ---L-
L0034   EQU     0034H   ; ----I
I$003B  EQU     003BH   ; ----I
C$004B  EQU     004BH   ; -C---
C$0059  EQU     0059H   ; -C---
C005C   EQU     005CH   ; -C---
DBUF    EQU     0080H   ; --S-I
C0080   EQU     0080H
C0083   EQU     0083H   ; ----I
C0086   EQU     0086H   ; ----I
D$0092  EQU     0092H   ; ---L-
CHGET   EQU     009FH   ; -C--I
CHPUT   EQU     00A2H   ; -C--I
CKCNTC  EQU     00BDH   ; -C---
ERAFNK  EQU     00CCH   ; -C---
TOTEXT  EQU     00D2H   ; -C---
J.0100  EQU     0100H   ; J---I
SNSMAT  EQU     0141H   ; -C---
KILBUF  EQU     0156H   ; ----I
CALBAS  EQU     0159H   ; JC---

I$051E  EQU     051EH   ; ----I
I$0600  EQU     0600H   ; ----I
I$071E  EQU     071EH   ; ----I
I$073E  EQU     073EH   ; ----I
I$0800  EQU     0800H   ; ----I
I$083E  EQU     083EH   ; ----I
I$0867  EQU     0867H   ; ----I
I$09FF  EQU     09FFH   ; ----I
D.0A0D  EQU     0A0DH   ; ---L-
I$0D1E  EQU     0D1EH   ; ----I
I$101E  EQU     101EH   ; ----I
C$175E  EQU     175EH   ; -C---
D.2020  EQU     2020H   ; ---L-
I$243E  EQU     243EH   ; ----I
C$268C  EQU     268CH   ; -C---
J$269A  EQU     269AH   ; J----
I$26FE  EQU     26FEH   ; ----I
C$289F  EQU     289FH   ; -C---
D.2A2A  EQU     2A2AH   ; ---L-
C$2EF3  EQU     2EF3H   ; -C---
J$2F08  EQU     2F08H   ; J----
C$2F10  EQU     2F10H   ; -C---
C.2F99  EQU     2F99H   ; JC---
C.3042  EQU     3042H   ; -C---
C$30D1  EQU     30D1H   ; -C---
I$321E  EQU     321EH   ; ----I
C.325C  EQU     325CH   ; -C---
I$341E  EQU     341EH   ; ----I
I$351E  EQU     351EH   ; ----I
I$361E  EQU     361EH   ; ----I
I$371E  EQU     371EH   ; ----I
I$381E  EQU     381EH   ; ----I
C$38F1  EQU     38F1H   ; -C---
I$3A6A  EQU     3A6AH   ; ----I
I$3B1E  EQU     3B1EH   ; ----I
I$3C00  EQU     3C00H   ; ----I
I$3C1E  EQU     3C1EH   ; ----I
I$3D1E  EQU     3D1EH   ; ----I
I$3E1E  EQU     3E1EH   ; ----I
I$3F00  EQU     3F00H   ; ----I
I$3F1E  EQU     3F1EH   ; ----I
I$3FD6  EQU     3FD6H   ; ----I

M406F   EQU     406FH
M409B   EQU     409BH
M4173   EQU     4173H
M4253   EQU     4253H
M4601   EQU     4601H
M4666   EQU     4666H
M46FF   EQU     46FFH
M4756   EQU     4756H
M4AFF   EQU     4AFFH
M4C5F   EQU     4C5FH
M4C64   EQU     4C64H
M517A   EQU     517AH
M520F   EQU     520FH
M521B   EQU     521BH
M521C   EQU     521CH
M521F   EQU     521FH
M537B   EQU     537BH
M542F   EQU     542FH
M5432   EQU     5432H
M54F7   EQU     54F7H
M5597   EQU     5597H
M5EA4   EQU     5EA4H
M6627   EQU     6627H
M668E   EQU     668EH
M67D0   EQU     67D0H
M6A0E   EQU     6A0EH
M6A6D   EQU     6A6DH
M6AFA   EQU     6AFAH
M6B24   EQU     6B24H
M6C1C   EQU     6C1CH
M6F0B   EQU     6F0BH
M6F1D   EQU     6F1DH
M7323   EQU     7323H   ; ----I
M7328   EQU     7328H   ; ----I
M739A   EQU     739AH   ; ----I
M7D17   EQU     7D17H   ; ----I
M7D30   EQU     7D30H   ; ----I
M7D31   EQU     7D31H   ; ----I
M7DE9   EQU     7DE9H   ; ----I

I.8000  EQU     8000H   ; ----I
I$803B  EQU     803BH   ; ----I
D$986C  EQU     986CH   ; --S--
I$AA55  EQU     0AA55H  ; ----I
J$B46B  EQU     0B46BH  ; J----
I$BC0B  EQU     0BC0BH  ; ----I
I.BC20  EQU     0BC20H  ; ----I
D.BE00  EQU     0BE00H  ; ---L-
I$BE02  EQU     0BE02H  ; ----I
I$BFFF  EQU     0BFFFH  ; ----I
I$C001  EQU     0C001H  ; ----I
J$C01E  EQU     0C01EH  ; J----
C.C024  EQU     0C024H  ; -C---
D$C025  EQU     0C025H  ; --S--
C.C028  EQU     0C028H  ; -C---
I.C200  EQU     0C200H  ; ----I
J$C4C3  EQU     0C4C3H  ; J----
J$C95C  EQU     0C95CH  ; J----
D$CD00  EQU     0CD00H  ; ---L-
C$DEDD  EQU     0DEDDH  ; -C---
J$E4E3  EQU     0E4E3H  ; J----
J$ECEB  EQU     0ECEBH  ; J----
D$ECFE  EQU     0ECFEH  ; ---L-

LF1C9	EQU	0F1C9H			; BDOS _STROUT
LF1D3	EQU	0F1D3H			; transfer to/from page 1
LF1E2	EQU	0F1E2H			; start DOS1 style handler
LF1E5   equ     0F1E5H
LF1E8   equ     0F1E8H
LF1EB   equ     0F1EBH
LF1EE   equ     0F1EEH
LF1F1   equ     0F1F1H
LF1F4   equ     0F1F4H
LF1FD	EQU	0F1FDH			; enable DOS RAM on page 0
LF206	EQU	0F206H			; RD_SEG handler
LF218	EQU	0F218H			; PUT_P0 handler
LF21B	EQU	0F21BH			; GET_P0 handler
LF21E	EQU	0F21EH			; PUT_P1 handler
LF221	EQU	0F221H			; GET_P1 handler
LF224	EQU	0F224H			; PUT_P2 handler
LF227	EQU	0F227H			; GET_P2 handler
LF23C	EQU	0F23CH			; default drive
C.F24F  EQU     0F24FH  ; -C--I
D$F2B8  EQU     0F2B8H  ; ---L-
I$F2B9  EQU     0F2B9H  ; ----I
D.F2BA  EQU     0F2BAH  ; --SL-
D.F2BC  EQU     0F2BCH  ; --SL-
D$F2BD  EQU     0F2BDH  ; --S--
D.F2BE  EQU     0F2BEH  ; --SL-
D.F2BF  EQU     0F2BFH  ; --SL-
J.F2C0  EQU     0F2C0H  ; J---I
D.F2CF  EQU     0F2CFH  ; ---L-
D$F2D0  EQU     0F2D0H  ; ---L-
J.F2D5  EQU     0F2D5H  ; J---I
D$F2DA  EQU     0F2DAH  ; --S--
D$F2DC  EQU     0F2DCH  ; --S--
D$F2DE  EQU     0F2DEH  ; --S--
D.F2E1  EQU     0F2E1H  ; --SL-
D.F2E3  EQU     0F2E3H  ; --SL-
D.F2E5  EQU     0F2E5H  ; --SL-
D$F2E6  EQU     0F2E6H  ; ---L-
D.F2E8  EQU     0F2E8H  ; --SL-
D.F2F1  EQU     0F2F1H  ; --S--
D.F2F3  EQU     0F2F3H  ; --S--
D.F2F5  EQU     0F2F5H  ; --SL-
D.F2F7  EQU     0F2F7H  ; --SL-
D.F2F9  EQU     0F2F9H  ; --SL-
D.F2FB  EQU     0F2FBH  ; --S--
D.F2FD  EQU     0F2FDH  ; --SL-
D.F2FE  EQU     0F2FEH  ; --SL-
D$F300  EQU     0F300H  ; --S--
D$F302  EQU     0F302H  ; --S--
D$F306  EQU     0F306H  ; --S--
D$F30E  EQU     0F30EH  ; --S--
I$F30F  EQU     0F30FH  ; ----I
D.F313  EQU     0F313H  ; --SL-
D.F314  EQU     0F314H  ; ---L-
D.F315  EQU     0F315H  ; ---L-
D.F316  EQU     0F316H  ; ---L-
D.F323  EQU     0F323H  ; --SLI
D.F325  EQU     0F325H  ; --SL-
I$F327  EQU     0F327H  ; ----I
D$F333  EQU     0F333H  ; --S--
D$F338  EQU     0F338H  ; --S--
D.F33B  EQU     0F33BH  ; --SL-
D.F33D  EQU     0F33DH  ; ---L-
D.F33F  EQU     0F33FH  ; --SL-
LF340	EQU	0F340H			; first start DiskBASIC flag
RAMAD2	equ	0F343H			; slotid DOS ram page 2
RAMAD3	equ	0F344H			; slotid DOS ram page 3
LF346	EQU	0F346H			; MSXDOS started flag
LF347	EQU	0F347H			; number of drives
LF348	EQU	0F348H			; slotid disksystem ROM
D.F349  EQU     0F349H  ; --SL-
D.F34B  EQU     0F34BH  ; --SL-
_SECBUF equ	0F34DH
D.F34F  EQU     0F34FH  ; --S--
D.F351  EQU     0F351H  ; --S--
D.F353  EQU     0F353H  ; --S-I
I$F355  EQU     0F355H  ; ----I
I$F365  EQU     0F365H  ; ----I
XF368	EQU	0F368H			; enable disksystem ROM on page 1
XF36B	EQU	0F36BH			; enable TPA RAM on page 2
XFER	EQU	0F36EH			; transfer to/fram TPA RAM on page 2
J$F377  EQU     0F377H  ; J----
J$F37A  EQU     0F37AH  ; J----
B.BDOS  EQU     0F37DH  ; -C---

VARWRK	EQU	0F380H
LF38B	EQU	0F38BH			; on this adres is a simple RET instruction
LINLEN	EQU	0F3B0H
CNSDFG	EQU	0F3DEH
LPTPOS	EQU	0F415H
PRTFLG	EQU	0F416H
CURLIN	EQU	0F41CH
BUF	EQU	0F55EH
TTYPOS	EQU	0F661H
VALTYP	EQU	0F663H
MEMSIZ	EQU	0F672H
STKTOP	EQU	0F674H
TXTTAB	EQU	0F676H
TEMPPT	EQU	0F678H
DSCTMP	EQU	0F698H
FRETOP	EQU	0F69BH
AUTLIN	EQU	0F6ABH			; used for bigest sectorsize during disksystem init
SAVSTK	EQU	0F6B1H
VARTAB	EQU	0F6C2H
STREND	EQU	0F6C6H
DAC	EQU	0F7F6H
ARG	EQU	0F847H
MAXFIL	EQU	0F85FH
FILTAB	EQU	0F860H
NULBUF	EQU	0F862H
PTRFIL	EQU	0F864H
FILNAM	EQU	0F866H
NLONLY	EQU	0F87CH
SAVEND	EQU	0F87DH

HOKVLD	EQU	0FB20H			; EXTBIO valid flag (b0)
DRVTBL	EQU	0FB21H			; diskdriver table
DRVINT	EQU	0FB29H			; diskdriver interrupt table

BASROM	EQU	0FBB1H
BOTTOM	EQU	0FC48H
HIMEM	EQU	0FC4AH
FLBMEM	EQU	0FCAEH
RUNBNF	EQU	0FCBEH
SAVENT	EQU	0FCBFH
EXPTBL	EQU	0FCC1H
SLTTBL	EQU	0FCC5H
SLTWRK	EQU	0FD09H
PROCNM	EQU	0FD89H
DEVICE	EQU	0FD99H			; used temp for diskdriver count

H.TIMI  EQU     0FD9FH
H.DSKO	EQU	0FDEFH
H.NAME	EQU	0FDF9H
H.KILL	EQU	0FDFEH
H.COPY	EQU	0FE08H
H.DSKF	EQU	0FE12H
H.DSKI	EQU	0FE17H
H.LSET	EQU	0FE21H
H.RSET	EQU	0FE26H
H.FIEL	EQU	0FE2BH
H.MKI$	EQU	0FE30H
H.MKS$	EQU	0FE35H
H.MKD$	EQU	0FE3AH
H.CVI	EQU	0FE3FH
H.CVS	EQU	0FE44H
H.CVD	EQU	0FE49H
H.GETP	EQU	0FE4EH
H.NOFO	EQU	0FE58H
H.NULO	EQU	0FE5DH
H.NTFL	EQU	0FE62H
H.BINS	EQU	0FE71H
H.BINL	EQU	0FE76H
H.FILE	EQU	0FE7BH
H.DGET	EQU	0FE80H
H.FILO	EQU	0FE85H
H.INDS	EQU	0FE8AH
H.LOC	EQU	0FE99H
H.LOF	EQU	0FE9EH
H.EOF	EQU	0FEA3H
H.BAKU	EQU	0FEADH
H.PARD	EQU	0FEB2H
H.NODE	EQU	0FEB7H
H.POSD	EQU	0FEBCH
H.RUNC	EQU	0FECBH
H.CLEA	EQU	0FED0H
H.LOPD	EQU	0FED5H
H.STKE	EQU	0FEDAH
H.ERRP	EQU	0FEFDH
H.PHYD	EQU	0FFA7H
H.FORM	EQU	0FFACH

EXTBIO  EQU     0FFCAH
DISINT	equ	0FFCFH
ENAINT	equ	0FFD4H
LFFFF	EQU	0FFFFH

        INCLUDE DISK.INC


I4000:  DEFB    "AB"

        IF MSXJE EQ 0

        DEFW    C403C                   ; EXTENSION ROM INIT handler
        DEFW    C575C                   ; EXTENSION ROM CALL statement handler

        ELSE

        DEFW    C406A                   ; EXTENSION ROM INIT handler
        DEFW    C403C                   ; EXTENSION ROM CALL statement handler

        ENDIF

        DEFW    0                       ; EXTENSION ROM device handler (no device)
        DEFW    0                       ; EXTENSION ROM basic program (no basic program)
        DEFS    6,0

C4010:  JP      DSKIO                   ; DRIVER:  DSKIO
C4013:  JP      DSKCHG                  ; DRIVER:  DSKCHG
C4016:  JP      GETDPB                  ; DRIVER:  GETDPB
C4019:  JP      CHOICE                  ; DRIVER:  CHOICE
C401C:  JP      DSKFMT                  ; DRIVER:  DSKFMT
C401F:  JP      MTOFF                   ; DRIVER:  MTOFF
C4022:  JP      J4B1B                   ; SYSTEM:  Start DiskBASIC
C4025:  SCF                             ; SYSTEM:  Format disk
        JP      J4E67
C4029:  JP      J4CD3                  ; SYSTEM:  Stop drives

        NOP

;         Subroutine GETSLT
;            Inputs  ________________________
;            Outputs ________________________

GETSLT:
C402D:  JP      C4E05                  ; SYSTEM:  Get own slotid
L4030:  LD      HL,(D.F34B)             ; SYSTEM:  Get system boundary
        RET

; 04034H
; DOS1 kernel compatible:  CP/M BIOS CONST entry
; This entry is supported, to use MSXDOS.SYS

C4034:  JP      J4177

        DEFS    04038H-$,0

; 04038H
; DOS2: pointer to kernel version ASCIIZ string

        DEFW    I411E

        DEFS    0403CH-$,0


        IF      MSXJE EQ 0

;         Subroutine EXTENSION ROM INIT handler
;            Inputs  ________________________
;            Outputs ________________________

C403C:  XOR     A
        CALL    C4092                  ; select DOS2 ROM bank 0
        JP      J47D6

;         Subroutine EXTBIO handler
;            Inputs  ________________________
;            Outputs ________________________

I4043:  CALL    C410C
        JP      J.F2D5

;         Subroutine H.TIMI handler
;            Inputs  ________________________
;            Outputs ________________________

I4049:  PUSH    AF
        LD      A,(D40FF)
        PUSH    AF                      ; save current DOS2 ROM bank
        XOR     A
        CALL    C4092                  ; select DOS2 ROM bank 0
        CALL    C4CF3                  ; H.TIMI handler
        POP     AF
        CALL    C4092                  ; restore DOS2 ROM bank
        POP     AF
        RET

;         Subroutine inter DOS2 ROM bank call
;            Inputs  A = DOS2 ROM bank, AF' =
;            Outputs ________________________

J405B:  CALL    C4092                  ; select DOS2 ROM bank
        EX      AF,AF'
        CALL    C4069                  ; call routine (in IX)
        EX      AF,AF'
        XOR     A
        CALL    C4092                  ; select DOS2 ROM bank 0
        EX      AF,AF'
        RET

;         Subroutine __________________________
;            Inputs  ________________________
;            Outputs ________________________

C4069:  JP      (IX)

        DEFS    04078H-$,0FFH


        ELSE

;         Subroutine EXTENSION ROM CALL statement handler
;            Inputs  ________________________
;            Outputs ________________________

C403C:  CALL    C40E4                   ; MSX-JE call statement handler
        RET     NC                      ; statement handled, quit
        JP      C575C                   ; MSXDOS2 kernel call statement handler

;         Subroutine EXTBIO handler
;            Inputs  ________________________
;            Outputs ________________________

I4043:  LD      IX,I40B4
        CALL    C4051                   ; inter DOS2 ROM bank 0 call
        JP      J$F2D5

;         Subroutine H.TIMI handler
;            Inputs  ________________________
;            Outputs ________________________

I404D:  LD      IX,I40BA                ; jmp

;         Subroutine inter DOS2 ROM bank 0 call
;            Inputs  AF' =
;            Outputs ________________________

C4051:  EX      AF,AF'
        LD      A,(D40FF)
        PUSH    AF                      ; save current DOS2 ROM bank
        CALL    C406E                   ; select DOS2 ROM bank 0 and execute routine
        EX      AF,AF'
        POP     AF
        CALL    C4092                   ; restore DOS2 ROM bank
        EX      AF,AF'
        RET

;         Subroutine inter DOS2 ROM bank call
;            Inputs  AF' =
;            Outputs ________________________

J4060:  CALL    C406F                   ; select DOS2 ROM bank and execute routine
        EX      AF,AF'
        XOR     A
        CALL    C4092                   ; select DOS2 ROM bank 0
        EX      AF,AF'
        RET

;         Subroutine EXTENSION ROM INIT handler
;            Inputs  ________________________
;            Outputs ________________________

C406A:  LD      IX,J47D6                ; DOS2 kernel INIT routine

;         Subroutine select DOS2 ROM bank 0 and execute routine
;            Inputs  AF' =
;            Outputs ________________________

C406E:  XOR     A

;         Subroutine select DOS2 ROM bank and execute routine
;            Inputs  AF' = , A = bank
;            Outputs ________________________

C406F:  CALL    C4092                   ; select DOS2 ROM bank
        EX      AF,AF'
        JP      (IX)

        DEFS    04078H-$,0

        ENDIF



; 04078H
; DOS1 kernel compatible:  CP/M BIOS CONIN entry
; This entry is supported, to use MSXDOS.SYS

        JP      J417C

        DEFS    04080H-$,0FFH

; DOS2:  RAMDISK driver jumpentries

L4080:  JP      J6D49                   ; RAMDISK:  DSKIO routine
L4083:  JP      J6D39                   ; RAMDISK:  DSKCHG routine
L4086:  JP      J6EF1                   ; RAMDISK:  GETDPB routine
L4089:  JP      J6EF2                   ; RAMDISK:  CHOICE routine
L408C:  JP      J6EF6                   ; RAMDISK:  DSKFMT routine

        DEFS    0408FH-$,0

; 0408F
; DOS1 kernel compatible:  CP/M BIOS CONOUT entry
; This entry is supported, to use MSXDOS.SYS

L408F:  JP      J4181



;         Subroutine Select DOS2 ROM bank
;            Inputs  ________________________
;            Outputs ________________________

C4092:  BNKCHG
        RET


        IF MSXJE EQ 1

        DEFS    040B4H-$,0

;         Subroutine EXTBIO handler
;            Inputs  ________________________
;            Outputs ________________________

I40B4:  CALL    C40E7                   ; H.EXTBIO MSX-JE
        JP      J410C                   ; H.EXTBIO DOS2

;         Subroutine H.TIMI handler
;            Inputs  ________________________
;            Outputs ________________________

I40BA:  CALL    C40EA                   ; H.TIMI MSX-JE
        JP      J4CF3                   ; H.TIMI DOS2

;         Subroutine call 4100 in bank 3 (MSX-JE TOTEXT handler)
;            Inputs  ________________________
;            Outputs ________________________

L40C0:  CALL    C40ED

;         Subroutine call 4103 in bank 3 (MSX-JE CHPUT handler)
;            Inputs  ________________________
;            Outputs ________________________

        CALL    C40ED

;         Subroutine call 4106 in bank 3 (MSX-JE display cursor handler)
;            Inputs  ________________________
;            Outputs ________________________

        CALL    C40ED

;         Subroutine call 4109 in bank 3 (MSX-JE erase cursor handler)
;            Inputs  ________________________
;            Outputs ________________________

        CALL    C40ED

;         Subroutine call 410C in bank 3 (MSX-JE erase function keys handler)
;            Inputs  ________________________
;            Outputs ________________________

        CALL    C40ED

;         Subroutine call 410F in bank 3 (MSX-JE display function keys handler)
;            Inputs  ________________________
;            Outputs ________________________

        CALL    C40ED

;         Subroutine call 4112 in bank 3 (MSX-JE PINLIN handler)
;            Inputs  ________________________
;            Outputs ________________________

        CALL    C40ED

;         Subroutine call 4115 in bank 3 (MSX-JE INLIN handler)
;            Inputs  ________________________
;            Outputs ________________________

        CALL    C40ED

;         Subroutine call 4118 in bank 3 (MSX-JE LPTOUT handler)
;            Inputs  ________________________
;            Outputs ________________________

        CALL    C40ED

;         Subroutine call 411B in bank 3 (MSX-JE CHGET handler)
;            Inputs  ________________________
;            Outputs ________________________

        CALL    C40ED

;         Subroutine call 411E in bank 3 (MSX-JE WIDTH handler)
;            Inputs  ________________________
;            Outputs ________________________

        CALL    C40ED

;         Subroutine call 4121 in bank 3 (MSX-JE SCREEN handler)
;            Inputs  ________________________
;            Outputs ________________________

        CALL    C40ED

;         Subroutine call 4124 in bank 3 (MSX-JE statement handler)
;            Inputs  ________________________
;            Outputs ________________________

C40E4:  CALL    C40ED

;         Subroutine call 4127 in bank 3 (MSX-JE extended bios handler)
;            Inputs  ________________________
;            Outputs ________________________

C40E7:  CALL    C40ED

;         Subroutine call 412A in bank 3 (MSX-JE timer interrupt handler)
;            Inputs  ________________________
;            Outputs ________________________

C40EA:  CALL    C40ED

;         Subroutine execute MSX-JE routine
;            Inputs  ________________________
;            Outputs ________________________

C40ED:  POP     IX
        PUSH    BC
        LD      BC,003DH
        EX      AF,AF'
        LD      A,3                     ; bank 3
        ADD     IX,BC
        POP     BC
        JP      J4060                  ; inter DOS2 ROM bank call


        ENDIF

        DEFS    040FFH-$,0

D40FF:  DEFB    0

C4100:  CALL    C410F                   ; Check and invoke memorymapper of 6 or more segments
C4103:  CALL    C410F                   ; install disksystem routines
C4106:  CALL    C410F                   ; copy message to buffer
I4109:  CALL    C410F                   ; copy errorstring to buffer
C410C:  CALL    C410F                   ; EXTBIO handler memorymapper

;         Subroutine inter DOS2 ROM bank 1 call
;            Inputs  ________________________
;            Outputs ________________________

C410F:  POP     IX
        PUSH    BC
        LD      BC,-3
        EX      AF,AF'
        LD      A,1                     ; DOS2 ROM bank 1
        ADD     IX,BC
        POP     BC
        JP      J405B                   ; inter DOS2 ROM bank call

I411E:  DEFB    "MSX-DOS kernel version 2.20",0
I413A:  DEFB    "Disk BASIC version 2.01",0
        DEFB    "Copyright (C) 1989 ASCII Corporation",0

J4177:  LD      HL,C0086
        JR      J4185

J417C:  LD      HL,C0080
        JR      J4185

J4181:  LD      C,A
J4182:  LD      HL,C0083
J4185:  JP      J$F377

        DEFS    041EFH-$,0C9H
;
; BDOS 00CH ENTRY
;

L41EF:  LD      C,00CH
        JP      J4F54
        DEFS    0436CH-$,0C9H
;
; BDOS 013H ENTRY
;
L436C:  LD      C,013H
        JP      J4F54

        DEFS    04392H-$,0C9H
;
; BDOS 017H ENTRY
;
L4392:  LD      C,017H
        JP      J4F54

        DEFS    04462H-$,0C9H
;
; BDOS 00FH ENTRY
;
L4462:  LD      C,00FH
        JP      J4F54

        DEFS    0456FH-$,0C9H
;
; BDOS 010H ENTRY
;
L456F:  LD      C,010H
        JP      J4F54

        DEFS    0461DH-$,0C9H
;
; BDOS 016H ENTRY
;
L461D:  LD      C,016H
        JP      J4F54

        DEFS    046BAH-$,0C9H
;
; BDOS 02FH ENTRY
;
L46BA:  LD      C,02FH
        JP      J4F54

        DEFS    04720H-$,0C9H
;
; BDOS 030H ENTRY
;
L4720:  LD      C,030H
        JP      J4F54

        DEFS    04775H-$,0C9H
;
; BDOS 014H ENTRY
;
L4775:  LD      C,014H
        JP      J4F54

        DEFS    0477DH-$,0C9H
;
; BDOS 015H ENTRY
;
L477D:  LD      C,015H
        JP      J4F54

        DEFS    04788H-$,0C9H
;
; BDOS 021H ENTRY
;
L4788:  LD      C,021H
        JP      J4F54

        DEFS    04793H-$,0C9H
;
; BDOS 022H ENTRY
;
L4793:  LD      C,022H
        JP      J4F54

        DEFS    047B2H-$,0C9H
;
; BDOS 027H ENTRY
;
L47B2:  LD      C,027H
        JP      J4F54

        DEFS    047BEH-$,0C9H
;
; BDOS 026H ENTRY
;
L47BE:  LD      C,026H
        JP      J4F54

        DEFS    047D1H-$,0C9H
;
; BDOS 028H ENTRY
;
L47D1:  LD      C,028H
        JP      J4F54


J47D6:  CALL    INIHRD
        DI
        LD      A,(IDBYT2)
        OR      A
        RET     Z
        LD      A,(DEVICE)
        OR      A
        RET     M
        JR      NZ,J4865
        LD      HL,HOKVLD
        BIT     0,(HL)
        JR      NZ,J47F9
        SET     0,(HL)
        LD      HL,EXTBIO
        LD      B,3*5
J47F4:  LD      (HL),0C9H
        INC     HL
        DJNZ    J47F4
J47F9:  LD      HL,(BOTTOM)
        LD      DE,I$C001
        RST     20H
        JR      NC,J4817
        LD      HL,(HIMEM)
        LD      DE,VARWRK
        RST     20H
        JR      NZ,J4817
        LD      A,06H   ; 6
        CALL    SNSMAT
I480E   EQU     $-2
        DI
        RRCA
        JR      C,J481D
        LD      A,07H   ; 7
        RST     18H
J4817:  LD      A,0FFH
        LD      (DEVICE),A
        RET

J481D:  CALL    C492A
I481E   EQU     $-2
        RET     C
        LD      HL,439
        CALL    C5604
        RET     C
        LD      BC,439
J482B:  XOR     A
        LD      (HL),A
        INC     HL
        DEC     BC
        LD      A,C
        OR      B
        JR      NZ,J482B
        LD      (AUTLIN),BC
        LD      B,4*2+4*3
        LD      HL,DRVTBL
J483C:  LD      (HL),A
        INC     HL
        DJNZ    J483C
        LD      HL,C.F24F
        LD      B,69H   ; "i"
J4845:  LD      (HL),0C9H
        INC     HL
        DJNZ    J4845
        LD      HL,I$F365
        LD      (HL),0DBH
        INC     HL
        LD      (HL),0A8H
        INC     HL
        LD      (HL),0C9H
        LD      A,06H   ; 6
        CALL    SNSMAT
        DI
        AND     02H     ; 2
        LD      (D.F33F),A
        LD      A,07H   ; 7
        RST     18H
        JR      J4870

J4865:  LD      A,(D.F313)
        CP      22H     ; """
        JR      NC,J4888
        CALL    C492A
        RET     C
J4870:  LD      A,22H                   ; version 2.2
        LD      (D.F313),A
        CALL    C402D                   ; GETSLT
        LD      HL,H.RUNC
        LD      (HL),0F7H
        INC     HL
        LD      (HL),A
        INC     HL
        LD      (HL),LOW I495B
        INC     HL
        LD      (HL),HIGH I495B
        INC     HL
        LD      (HL),0C9H
J4888:  CALL    C4906
        RET     Z
        LD      HL,MYSIZE
        CALL    C5604
        JR      C,J48FE
        EX      DE,HL
        CALL    C4DBB
        LD      (HL),E
        INC     HL
        LD      (HL),D
        LD      HL,(AUTLIN)
        LD      DE,512
        RST     20H
        JR      NC,J48A8
        LD      (AUTLIN),DE
J48A8:  CALL    C4906
        LD      HL,DRVTBL
        LD      D,00H
        ADD     HL,DE
        ADD     HL,DE
        EX      DE,HL
        LD      A,(D.F33F)
        OR      A
        LD      A,C
        CALL    DRIVES
        ADD     A,L
        CP      09H     ; 9
        JR      C,J48C2
        LD      A,08H   ; 8
J48C2:  SUB     C
        JR      Z,J48FE
        LD      (DE),A
        INC     DE
        CALL    C402D                   ; GETSLT
        LD      (DE),A
        LD      B,00H
        LD      HL,I$F355
        ADD     HL,BC
        ADD     HL,BC
        PUSH    HL
        DEC     DE
        LD      A,(DE)
        PUSH    AF
        LD      C,A
        ADD     A,A
        ADD     A,A
        ADD     A,C
        ADD     A,A
        ADD     A,A
        ADD     A,C
        LD      L,A
        LD      H,B
        CALL    C4C50
        EX      DE,HL
        POP     AF
        POP     HL
J48E5:  LD      (HL),E
        INC     HL
        LD      (HL),D
        INC     HL
        PUSH    HL
        LD      HL,DEFDPB
        LD      BC,21
        LDIR
        POP     HL
        DEC     A
        JR      NZ,J48E5
        CALL    INIENV
        LD      HL,DEVICE
        INC     (HL)
        RET

J48FE:  LD      HL,DEVICE
        INC     (HL)
        DEC     (HL)
        RET     NZ
        INC     (HL)
        RET

;         Subroutine __________________________
;            Inputs  ________________________
;            Outputs ________________________

C4906:  LD      HL,DRVTBL
        LD      B,4
        XOR     A
        LD      E,A
J490D:  LD      C,A
        ADD     A,(HL)
        JR      C,J4927
        CP      C
        JR      Z,J491B
        INC     E
        INC     HL
        INC     HL
        DJNZ    J490D
        CP      A
        RET

J491B:  ADD     A,(HL)
        CP      C
        JR      NZ,J4927
I491E   EQU     $-1
        INC     HL
        INC     HL
        DJNZ    J491B
        CP      08H     ; 8
        RET     Z
        RET     C
J4927:  JP      J4C54

;         Subroutine __________________________
;            Inputs  ________________________
;            Outputs ________________________

C492A:  CALL    C4E12
        CALL    C4100
        RET     C
        LD      HL,5
        ADD     HL,SP
        IN      A,(0A8H)
        RRD
        LD      (HL),A
        CALL    C4E05
        BIT     7,A
        RET     Z
        LD      HL,12
        ADD     HL,SP
        LD      C,A
        CALL    C4E21
        XOR     C
        AND     03H     ; 3
        JR      NZ,J4954
        LD      A,(LFFFF)
        CPL
        RRD
        LD      (HL),A
J4954:  DEC     HL
        IN      A,(0A8H)
        RRD
        LD      (HL),A
        RET

I495B:  LD      HL,H.RUNC
        LD      B,5
J4960:  LD      (HL),0C9H
        INC     HL
        DJNZ    J4960
        LD      HL,DEVICE
        LD      A,(HL)
        LD      (HL),B
        OR      A
        RET     M
        LD      D,A
        CALL    C4906
        LD      (LF347),A
        LD      A,D
        SUB     E
        JR      Z,J4986
        DEC     A
        JP      NZ,J4C54
        LD      DE,DRVINT+0
        LD      HL,DRVINT+3
        LD      BC,4*3
        LDIR
J4986:  CALL    C402D                   ; GETSLT
        LD      (LF348),A
        LD      HL,L0034
        LD      DE,I$F30F
        LD      BC,4
        LDIR
        LD      A,(IDBYT0)
        RRCA
        RRCA
        RRCA
        RRCA
        AND     07H     ; 7
        LD      (D$F30E),A
        LD      HL,I$F327
        LD      (HL),3EH        ; ">"
        INC     HL
        LD      (HL),1AH
        INC     HL
        LD      B,08H   ; 8
J49AE:  LD      (HL),0C9H
        INC     HL
        DJNZ    J49AE
        LD      A,0CDH
        LD      HL,XF368
        LD      (LF1C9+0),A
        LD      (LF1C9+1),HL
        LD      A,0C3H
        LD      HL,C53AC
        LD      (LF1C9+3),A
        LD      (LF1C9+4),HL
        LD      HL,I4109
        LD      (D$F2DA),HL
        LD      HL,I4D32
        LD      (D$F2DC),HL
        LD      HL,I6A82
        LD      (D$F2DE),HL
        LD      HL,J6A86
        LD      (D$F333),HL
        LD      A,0FFH
        LD      (D$F338),A
        LD      HL,21
        CALL    C4C50
        LD      (D.F353),HL
        LD      HL,(AUTLIN)
        LD      DE,512
        RST     20H
        JR      NC,J49F9
        EX      DE,HL
J49F9:  LD      (D.F34F),HL
        INC     HL
        CALL    C4C50
        LD      (HL),00H
        INC     HL
        LD      (_SECBUF),HL
        LD      HL,D.F353
        LD      BC,I$09FF
J4A0C:  LD      E,(HL)
        INC     HL
        LD      D,(HL)
        INC     HL
        LD      A,E
        OR      D
        JR      Z,J4A24
        EX      DE,HL
        LD      (HL),C
        PUSH    BC
        LD      BC,19
        ADD     HL,BC
        LD      BC,(_SECBUF)
I4A1E   EQU     $-1
        LD      (HL),C
        INC     HL
        LD      (HL),B
        POP     BC
        EX      DE,HL
J4A24:  INC     C
        DJNZ    J4A0C
        CALL    C4E12
        CALL    C4103
        JP      C,J4C54
        LD      HL,328
        CALL    C4C50
        LD      (D.F2F5),HL
        LD      DE,100
        ADD     HL,DE
        LD      (D.F2F7),HL
        LD      DE,64
        ADD     HL,DE
        LD      (D.F2F9),HL
        LD      DE,100
        ADD     HL,DE
        LD      (D.F2FB),HL
        LD      HL,(HIMEM)
        LD      (D.F349),HL
        LD      HL,H.TIMI
        PUSH    HL
        LD      DE,J.F2C0
        LD      BC,5
        LDIR
        POP     HL

        IF MSXJE EQ 0

        LD      DE,I4049

        ELSE

        LD      DE,I404D

        ENDIF

        CALL    C4C73
        LD      HL,EXTBIO
        LD      DE,J.F2D5
        LD      BC,5
        PUSH    HL
        LDIR
        POP     HL

        IF MSXJE EQ 0

        LD      DE,I4043

        ELSE

        LD      DE,I4043

        ENDIF

        CALL    C4C73
        CALL    C56A5
        LD      HL,M7D30
        LD      A,(EXPTBL+0)
        CALL    RDSLT
        PUSH    AF
        INC     SP
        DEC     HL
        LD      A,(EXPTBL+0)
        CALL    RDSLT
        PUSH    AF
        INC     SP
        POP     IX
        LD      IY,(EXPTBL+0-1)
        CALL    CALSLT
        CALL    C4C66
        LD      SP,I.C200
        LD      A,(H.STKE)
        CP      0C9H
        LD      IX,M7D17
        JR      NZ,J4ABB
        LD      A,(BASROM)
        OR      A
        LD      IX,M7DE9
        JP      NZ,J4ABB
        CALL    C4C16
        JR      J4AC1

J4ABB:  CALL    C4BE8
        JP      CALBAS

J4AC1:  LD      HL,J4B1B
        PUSH    HL
        CALL    C694A
        RET     Z
        CALL    C4AFB
        LD      HL,(BOTTOM)
        LD      DE,I.8000
        RST     20H
        RET     NZ
        LD      A,(LF23C)
        LD      HL,I4B18
        JR      J4ADF

J4ADC:  LD      A,(D.F2FD)
J4ADF:  LD      SP,I.C200
        PUSH    HL
        LD      HL,J4B1B
        EX      (SP),HL
        PUSH    AF
        LD      A,0FFH
        LD      (LF346),A
        POP     AF
        CALL    C68B3
        CALL    C694A
        RET     Z
        LD      A,0C3H
        CALL    C4C18
        SCF
;         Subroutine __________________________
;            Inputs  ________________________
;            Outputs ________________________

C4AFB:  LD      HL,D.F323
        LD      DE,XF368
        LD      A,(LF340)
        JP      J$C01E

I4B07:  DEFB	'RUN"\AUTOEXEC.BAS'
I4B18:  DEFB    0

I4B19:  DEFW    J4B7B

J4B1B:  LD      SP,I.C200
I4B1E:  CALL    C4C16
        LD      HL,I4B07
        LD      DE,BUF+12
        LD      BC,18
        LDIR
        LD      HL,LF340
        LD      A,(HL)
        OR      A
        LD      (HL),H
        JR      NZ,J4B50
        LD      (LF346),A
        LD      HL,I4B19
        LD      (D.F323),HL
        LD      DE,BUF+16
        LD      A,01H   ; 1
        LD      C,43H   ; "C"
        CALL    B.BDOS
        JR      NZ,J4B7B
        LD      C,45H   ; "E"
        CALL    B.BDOS
        JR      J4B7F

J4B50:  LD      A,(D.0000)
        CP      0C3H
        JR      NZ,J4B7B
        LD      HL,DBUF
        LD      B,(HL)
        INC     B
        DEC     B
        JR      Z,J4B7B
J4B5F:  INC     HL
        LD      A,(HL)
        CALL    C4B6A
        JR      NZ,J4B70
        DJNZ    J4B5F
        JR      J4B7B

;         Subroutine __________________________
;            Inputs  ________________________
;            Outputs ________________________

C4B6A:  CP      09H
        RET     Z
        CP      20H
        RET

J4B70:  XOR     A
        LD      C,B
        LD      B,A
        LD      DE,BUF+16
        LDIR
        LD      (DE),A
        JR      J4B7F

J4B7B:  XOR     A
        LD      (BUF+15),A
J4B7F:  LD      SP,I.C200
        LD      A,(RAMAD2)
        LD      H,80H
        CALL    ENASLT
        LD      A,(EXPTBL+0)
        LD      H,00H
        CALL    ENASLT
        CALL    C4BE8
J4B95:  LD      BC,0061H
        CALL    B.BDOS
        JR      NZ,J4B95
        LD      HL,(BOTTOM)
        XOR     A
        LD      (HL),A
        INC     HL
        LD      (TXTTAB),HL
        LD      (HL),A
        INC     HL
        LD      (HL),A
        INC     HL
        LD      (VARTAB),HL
        LD      HL,0FFFFH
        LD      (CURLIN),HL
        LD      SP,(STKTOP)
        LD      A,0FFH
        LD      (CNSDFG),A
        LD      IX,M7D31
        CALL    CALBAS
        CALL    C4D61
        LD      DE,I413A
        CALL    C4D7D
        CALL    C4D61
        LD      HL,M4173
        PUSH    HL
        LD      HL,BUF+11
        PUSH    HL
        LD      HL,BUF+10
        PUSH    HL
        LD      (HL),0E1H
        INC     HL
        LD      (HL),0C9H
        LD      A,(EXPTBL+0)
        LD      H,40H
        JP      ENASLT

;         Subroutine __________________________
;            Inputs  ________________________
;            Outputs ________________________

C4BE8:  LD      HL,(D.F349)
        LD      (HIMEM),HL
        CALL    C6A06
        LD      HL,I6563
        LD      (D.F323),HL
        LD      HL,I6568
        LD      (D.F325),HL
        LD      BC,(D.F34F)
        CALL    C4C40
        LD      (D.F351),HL
        LD      (D.F33B),HL
        LD      BC,13
        CALL    C4C40
        CALL    C4C22
        CALL    C565C

;         Subroutine __________________________
;            Inputs  ________________________
;            Outputs ________________________

C4C16:  LD      A,0C9H
;         Subroutine __________________________
;            Inputs  ________________________
;            Outputs ________________________

C4C18:  LD      (XF368+0),A
        LD      (XF36B+0),A
        LD      (XFER+0),A
        RET

;         Subroutine __________________________
;            Inputs  ________________________
;            Outputs ________________________

C4C22:  LD      (D.F2F1),HL
        EX      DE,HL
        LD      HL,I4C90
        LDIR
        LD      HL,-5
        ADD     HL,DE
        LD      (D.F2F3),HL
        LD      A,(LF348)
        LD      HL,-12
        ADD     HL,DE
        LD      (HL),A
        LD      HL,-4
        ADD     HL,DE
        LD      (HL),A
        RET

;         Subroutine __________________________
;            Inputs  ________________________
;            Outputs ________________________

C4C40:  LD      HL,(HIMEM)
        OR      A
        SBC     HL,BC
        LD      (HIMEM),HL
        JR      C,J4C54
        LD      A,H
        CP      0C2H
        JR      J4C53

;         Subroutine __________________________
;            Inputs  ________________________
;            Outputs ________________________

C4C50:  CALL    C5604
J4C53:  RET     NC
J4C54:  LD      A,0CH   ; 12
        CALL    C4D97
        LD      A,01H   ; 1
        LD      DE,BUF
        CALL    C4106
        CALL    C4D7D
        DI
        HALT

;         Subroutine __________________________
;            Inputs  ________________________
;            Outputs ________________________

C4C66:  LD      HL,H.CLEA
        LD      A,(HL)
        CP      0C9H
        RET     Z
        LD      HL,H.LOPD
        LD      DE,I4C82

;         Subroutine __________________________
;            Inputs  ________________________
;            Outputs ________________________

C4C73:  LD      (HL),0F7H
        INC     HL
        LD      A,(LF348)
        LD      (HL),A
        INC     HL
        LD      (HL),E
        INC     HL
        LD      (HL),D
        INC     HL
        LD      (HL),0C9H
        RET

I4C82:  LD      A,0C9H
        LD      (H.LOPD),A
        LD      DE,(HIMEM)
        LD      (D.F349),DE
        RET

I4C90:  RST     30H
        DEFB    0
        DEFW    C5DB6
        PUSH    HL
        JP      J6EF4

        RST     30H
        DEFB    0
        DEFW	C5CF2
        RET

C4C9D:  EI
        PUSH    HL
        PUSH    AF
        CALL    C4CB9
        JR      C,J4CAB
        SCF
        LD      A,0CH
        POP     HL
        POP     HL
        RET

J4CAB:  LD      L,A
        POP     AF
        LD      A,L
        POP     HL
        PUSH    HL
        LD      IX,C4010
        CALL    CALSLT
        POP     HL
        RET

;         Subroutine __________________________
;            Inputs  ________________________
;            Outputs ________________________

C4CB9:  PUSH    BC
        LD      (D.F33F),A
        LD      HL,DRVTBL
        LD      B,4
J4CC2:  SUB     (HL)
        JR      NC,J4CCD
        ADD     A,(HL)
        INC     HL
        LD      H,(HL)
        PUSH    HL
        POP     IY
        POP     BC
        RET

J4CCD:  INC     HL
        INC     HL
        DJNZ    J4CC2
        POP     BC
        RET

J4CD3:  LD      HL,DRVTBL
        LD      B,4
J4CD8:  INC     HL
        LD      A,(HL)
        PUSH    AF
        POP     IY
        INC     HL
        PUSH    HL
        PUSH    BC
        LD      HL,C401F
        PUSH    HL
        POP     IX
        OR      A
        CALL    NZ,RDSLT
        OR      A
        CALL    NZ,CALSLT
        POP     BC
        POP     HL
        DJNZ    J4CD8
        RET

;         Subroutine __________________________
;            Inputs  ________________________
;            Outputs ________________________

C4CF3:  PUSH    AF
        CALL    C6A44
        CALL    C4CFE
        POP     AF
        JP      J.F2C0

;         Subroutine __________________________
;            Inputs  ________________________
;            Outputs ________________________

C4CFE:  LD      DE,DRVTBL
        LD      HL,DRVINT
        LD      B,4
J4D06:  LD      A,(DE)
        AND     A
        RET     Z
        INC     DE
        LD      A,(DE)
        INC     DE
        CP      (HL)
        JR      NZ,J4D27
        LD      A,(LF348)
        CP      (HL)
        LD      A,(HL)
        PUSH    BC
        PUSH    DE
        PUSH    HL
        INC     HL
        LD      E,(HL)
        INC     HL
        LD      D,(HL)
        PUSH    AF
        POP     IY
        PUSH    DE
        POP     IX
D4D20   EQU     $-1
        CALL    C4D2D
        POP     HL
        POP     DE
        POP     BC
J4D27:  INC     HL
        INC     HL
        INC     HL
        DJNZ    J4D06
        RET

;         Subroutine __________________________
;            Inputs  ________________________
;            Outputs ________________________

C4D2D:  JP      NZ,CALSLT
        JP      (IX)

PROMPT:
I4D32:  LD      A,(D.F33F)
        ADD     A,"A"
        CALL    C.F24F
        PUSH    AF
        CALL    C4D61
        LD      A,07H   ; 7
        CALL    C4D6E
        POP     AF
        CALL    C4D97
        LD      A,08H   ; 8
        CALL    C4D6E
        CALL    C4D61
        LD      A,09H   ; 9
        CALL    C4D6E
J4D54:  CALL    C4D5B
        JR      Z,J4D54
        JR      C4D61

;         Subroutine __________________________
;            Inputs  ________________________
;            Outputs ________________________

C4D5B:  CALL    C4D86
        CP      03H     ; 3
        RET

;         Subroutine __________________________
;            Inputs  ________________________
;            Outputs ________________________

C4D61:  PUSH    AF
        LD      A,0DH   ; 13
        CALL    C4D97
        LD      A,0AH   ; 10
        CALL    C4D97
        POP     AF
        RET

;         Subroutine __________________________
;            Inputs  ________________________
;            Outputs ________________________

C4D6E:  PUSH    HL
        PUSH    DE
        LD      DE,(_SECBUF)
        CALL    C4106
        CALL    C4D7D
        POP     DE
        POP     HL
        RET

;         Subroutine __________________________
;            Inputs  ________________________
;            Outputs ________________________

C4D7D:  LD      A,(DE)
        INC     DE
        OR      A
        RET     Z
        CALL    C4D97
        JR      C4D7D

;         Subroutine __________________________
;            Inputs  ________________________
;            Outputs ________________________

C4D86:  PUSH    IX
        PUSH    HL
        LD      IX,KILBUF
        CALL    C4DA3
        POP     HL
        LD      IX,CHGET
        JR      J4D9D

;         Subroutine __________________________
;            Inputs  ________________________
;            Outputs ________________________

C4D97:  PUSH    IX
        LD      IX,CHPUT
J4D9D:  CALL    C4DA3
        POP     IX
        RET

;         Subroutine __________________________
;            Inputs  ________________________
;            Outputs ________________________

C4DA3:  PUSH    IY
        LD      IY,(EXPTBL+0-1)
        CALL    CALSLT
        EI
        POP     IY
        RET

GETWRK:
        CALL    C4DBB
        LD      A,(HL)
        INC     HL
        LD      H,(HL)
        LD      L,A
        PUSH    HL
        POP     IX
        RET

;         Subroutine __________________________
;            Inputs  ________________________
;            Outputs ________________________

C4DBB:  IN      A,(0A8H)
        AND     0CH
        RRCA
        RRCA
        LD      HL,EXPTBL
        CALL    C4DDC
        ADD     A,A
        ADD     A,A
        ADD     A,A
        ADD     A,A
        INC     A
        LD      C,A
        LD      A,(HL)
        ADD     A,A
        SBC     A,A
        AND     0CH     ; 12
        INC     HL
        INC     HL
        INC     HL
        INC     HL
        AND     (HL)
        OR      C
        ADD     A,A
        LD      HL,SLTWRK

;         Subroutine __________________________
;            Inputs  ________________________
;            Outputs ________________________

C4DDC:  LD      C,A
        LD      B,0
        ADD     HL,BC
        RET

SETINT:
        EX      DE,HL
        CALL    C402D                  ; GETSLT
        PUSH    AF
        LD      A,(DEVICE)
        LD      HL,DRVINT
        CALL    C4DDC
        ADD     HL,BC
        ADD     HL,BC
        POP     AF
        LD      (HL),A
        INC     HL
        LD      (HL),E
        INC     HL
        LD      (HL),D
PRVINT:
        RET

;         Subroutine __________________________
;            Inputs  ________________________
;            Outputs ________________________

C4DF8:  PUSH    HL
        PUSH    BC
        IN      A,(0A8H)
        CALL    C4E38
        JR      Z,J4E35
        RLCA
        RLCA
        JR      J4E30

;         Subroutine __________________________
;            Inputs  ________________________
;            Outputs ________________________

C4E05:  PUSH    HL
        PUSH    BC
        IN      A,(0A8H)
        RRCA
        RRCA
        CALL    C4E38
        JR      Z,J4E35
        JR      J4E30

;         Subroutine __________________________
;            Inputs  ________________________
;            Outputs ________________________

C4E12:  PUSH    HL
        PUSH    BC
        IN      A,(0A8H)
        RRCA
        RRCA
        RRCA
        RRCA
        CALL    C4E38
        JR      Z,J4E35
        JR      J4E2E

;         Subroutine __________________________
;            Inputs  ________________________
;            Outputs ________________________

C4E21:  PUSH    HL
        PUSH    BC
        IN      A,(0A8H)
        RLCA
        RLCA
        CALL    C4E38
        JR      Z,J4E35
        RRCA
        RRCA
J4E2E:  RRCA
        RRCA
J4E30:  AND     0CH     ; 12
        OR      80H
        OR      C
J4E35:  POP     BC
        POP     HL
        RET

;         Subroutine __________________________
;            Inputs  ________________________
;            Outputs ________________________

C4E38:  AND     03H     ; 3
        LD      C,A
        LD      B,0
        LD      HL,EXPTBL
        ADD     HL,BC
        BIT     7,(HL)
        RET     Z
        INC     HL
        INC     HL
        INC     HL
        INC     HL
        LD      A,(HL)
        RET

DIV16:
        LD      HL,0
        LD      A,11H   ; 17
J4E4F:  RL      C
        RL      B
        DEC     A
        RET     Z
        ADC     HL,HL
        JR      NC,J4E5E
        OR      A
        SBC     HL,DE
        JR      J4E4F

J4E5E:  SBC     HL,DE
        JR      NC,J4E63
        ADD     HL,DE
J4E63:  CCF
        JR      J4E4F

;         Subroutine __________________________
;            Inputs  ________________________
;            Outputs ________________________

C4E66:  OR      A
J4E67:  EI
        JR      C,J4E7C
        LD      HL,-256
        ADD     HL,SP
        LD      DE,(STREND)
        XOR     A
        SBC     HL,DE
        LD      C,L
        LD      B,H
        EX      DE,HL
        JR      NC,J4E7C
        LD      C,A
        LD      B,A
J4E7C:  PUSH    HL
        PUSH    BC
        LD      L,00H
        LD      BC,I$0867
J4E83:  ADD     HL,HL
        PUSH    HL
        PUSH    BC
        XOR     A
        CALL    B.BDOS
        POP     BC
        POP     HL
        JR      NZ,J4E8F
        INC     HL
J4E8F:  DJNZ    J4E83
        LD      A,L
        OR      A
        JP      Z,J4F47
        DEC     A
        AND     L
        LD      A,L
        JR      Z,J4EDE
        PUSH    HL
        LD      A,02H   ; 2
        CALL    C4D6E
        POP     HL
        PUSH    HL
        LD      A,40H   ; "@"
J4EA5:  INC     A
        SRL     L
        JR      NC,J4EB4
        CALL    C4D97
        PUSH    AF
        LD      A,2CH   ; ","
        CALL    NZ,C4D97
        POP     AF
J4EB4:  JR      NZ,J4EA5
        LD      A,03H   ; 3
        CALL    C4D6E
        POP     HL
J4EBC:  CALL    C4D5B
        JP      Z,J4F47
        AND     0DFH
        LD      C,A
        SUB     41H     ; "A"
        CP      08H     ; 8
        JR      NC,J4EBC
        LD      B,A
        INC     B
        XOR     A
        SCF
J4ECF:  RLA
        DJNZ    J4ECF
        AND     L
        JR      Z,J4EBC
        PUSH    AF
        LD      A,C
        CALL    C4D97
        CALL    C4D61
        POP     AF
J4EDE:  INC     B
        RRCA
        JR      NC,J4EDE
        LD      C,67H   ; "g"
        PUSH    BC
        XOR     A
        CALL    B.BDOS
        LD      A,L
        OR      H
        JR      Z,J4F1C
        LD      A,B
J4EEE:  PUSH    AF
        CALL    RDSLT
        OR      A
        JR      Z,J4EFC
        CALL    C4D97
        POP     AF
        INC     HL
        JR      J4EEE

J4EFC:  POP     AF
        LD      A,3FH   ; "?"
        CALL    C4D97
        LD      A,20H   ; " "
        CALL    C4D97
J4F07:  CALL    C4D5B
        JR      Z,J4F46
        SUB     31H     ; "1"
        CP      09H     ; 9
        JR      NC,J4F07
        ADD     A,31H   ; "1"
        CALL    C4D97
        CALL    C4D61
        SUB     31H     ; "1"
J4F1C:  INC     A
        PUSH    AF
        LD      A,04H   ; 4
        CALL    C4D6E
        CALL    C4D5B
        JR      Z,J4F45
        CALL    C4D61
        POP     AF
        POP     BC
        POP     DE
        POP     HL
        CALL    B.BDOS
        JR      Z,J4F41
        LD      B,A
        LD      DE,(_SECBUF)
        LD      C,66H   ; "f"
        CALL    B.BDOS
        JP      C4D7D

J4F41:  LD      A,06H   ; 6
        JR      J4F4E

J4F45:  POP     AF
J4F46:  POP     AF
J4F47:  POP     AF
        POP     AF
        CALL    C4D61
        LD      A,05H   ; 5
J4F4E:  CALL    C4D6E
        JP      C4D61

J4F54:  XOR     A
        LD      (D$F306),A
        JP      J6A86

        DEFS    04FB8H-$,0C9H
;
; BDOS 011H ENTRY
;
L4FB8:  LD      C,011H
        JP      J4F54

        DEFS    05006H-$,0C9H
;
; BDOS 012H ENTRY
;
L5006:  LD      C,012H
        JP      J4F54

        DEFS    0501EH-$,0C9H
;
; BDOS 023H ENTRY
;
L501E:  LD      C,023H
        JP      J4F54

        DEFS    0504EH-$,0C9H
;
; BDOS 018H ENTRY
;
L504E:  LD      C,018H
        JP      J4F54

        DEFS    05058H-$,0C9H
;
; BDOS 01AH ENTRY
;
L5058:  LD      C,01AH
        JP      J4F54

        DEFS    0505DH-$,0C9H
;
; BDOS 01BH ENTRY
;
L505D:  LD      C,01BH
        JP      J4F54

        DEFS    0509FH-$,0C9H
;
; BDOS 00DH ENTRY
;
L509F:  LD      C,00DH
        JP      J4F54

        DEFS    050A9H-$,0C9H
;
; DOS1 kernel compatible:  flush buffers
; This entry is supported, to use MSXDOS.SYS
;
L50A9:  LD      BC,0FF5FH
        LD      D,0
        JP      J4F54

        DEFS    050C4H-$,0C9H
;
; BDOS 019H ENTRY
;
L50C4:  LD      C,019H
        JR      L50CA

        DEFS    050C8H-$,0C9H
;
; BDOS 024H ENTRY
;
L50C8:  LD      C,024H
L50CA:  JP      J4F54

        DEFS    050D5H-$,0C9H
;
; BDOS 00EH ENTRY
;
L50D5:  LD      C,00EH
        JP      J4F54

        DEFS    050E0H-$,0C9H
;
; BDOS 00AH ENTRY
;
L50E0:  LD      C,00AH
        JP      J4F54

        DEFS    05183H-$,0C9H
;
; DOS1 kernel compatible:  newline to console
; This entry is supported, to use MSXDOS.SYS
;
L5183:  LD      E,13
        CALL    L53A7
        LD      E,10
        JP      L53A7

        DEFS    0535DH-$,0C9H
;
; DOS1 kernel compatible:  print abort string (DOS1:  ^C)
; This entry is supported, to use MSXDOS.SYS
;
L535D:  EXX
        PUSH    BC              ; errorcode
        EXX
        CALL    L5183           ; CR/LF to console
        LD      A,10            ; message 10 (Abort)
        LD      DE,(_SECBUF)
        CALL    C4106           ; copy message to buffer
        CALL    L5379           ; print prompt
        POP     BC
        LD      DE,(_SECBUF)
        LD      C,066H
        CALL    B.BDOS          ; EXPLAIN error
                                ; print errorstring
L5379:  LD      A,(DE)
        OR      A
        RET     Z
        PUSH    DE
        LD      E,A
        CALL    L53A7           ; print char
        POP     DE
        INC     DE
        JR      L5379

        DEFS 053A7H-$,0C9H
;
; BDOS 002H ENTRY
;
L53A7:  LD      C,2
        JP      J4F54

C53AC:	LD	HL,0C91AH	; LD A,(DE)  RET
        PUSH	HL 		; on stack (routine)
        CALL	C53C0		; Get char out of memory
        POP	HL
        CP	"$"		; check "$" encountered
        RET	Z		; yes, quit
        PUSH	DE
        LD	E,A
        CALL	L53A7		; Print char (BDOS #02)
        POP	DE
        INC	DE
        JR	C53AC		; next char

C53C0:	LD	HL,XF368
        PUSH	HL 		; Routine Switch SystemDiskROM on page 1 on stack
        LD	HL,4
        ADD	HL,SP
        PUSH	HL 		; Call "routine" on stack
        JP	XF36B		; Switch RAM on page 1

        DEFS    0543CH-$,0C9H
;
; BDOS 00BH ENTRY
;
L543C:  LD      C,00BH
        JP      J4F54

        DEFS    05445H-$,0C9H
;
; BDOS 001H ENTRY
;
L5445:  LD      C,1
        JP      J4F54

        DEFS    0544EH-$,0C9H
;
; BDOS 008H ENTRY
;
L544E:  LD      C,8
        JP      J4F54

        DEFS    05454H-$,0C9H
;
; BDOS 006H ENTRY
;
L5454:  LD      C,6
        JP      J4F54

        DEFS    05462H-$,0C9H
;
; BDOS 007H ENTRY
;
L5462:  LD      C,7
        DEFB    011H            ; Pseudo LD DE,nnnn
;
; BDOS 005H ENTRY
;
L5465:  LD      C,5
        JP      J4F54

        DEFS    0546EH-$,0C9H
;
; BDOS 003H ENTRY
;
L546E:  LD      C,3
        JP      J4F54

        DEFS    05474H-$,0C9H
;
; BDOS 004H ENTRY
;
L5474:  LD      C,4
        JP      J4F54

        DEFS    0553CH-$,0C9H
;
; BDOS 02AH ENTRY
;
L553C:  LD      C,02AH
        JP      J4F54

        DEFS    05552H-$,0C9H
;
; BDOS 02BH ENTRY
;
L5552:  LD      C,02BH
        JP      J4F54

        DEFS    055DBH-$,0C9H
;
; BDOS 02CH ENTRY
;
L55DB:  LD      C,02CH
        JP      J4F54

        DEFS    055E6H-$,0C9H
;
; BDOS 02DH ENTRY
;
L55E6:  LD      C,02DH
        JP      J4F54

        DEFS    055FFH-$,0C9H
;
; BDOS 02EH ENTRY
;
L55FF:  LD      C,2EH   ; "."
        JP      J4F54

;         Subroutine __________________________
;            Inputs  ________________________
;            Outputs ________________________

C5604:  LD      A,L
        OR      H
        RET     Z
        EX      DE,HL
        LD      HL,0
        SBC     HL,DE
        LD      C,L
        LD      B,H
        ADD     HL,SP
        CCF
        RET     C
        LD      A,H
        CP      HIGH 0C200H
        RET     C
        LD      DE,(BOTTOM)
        SBC     HL,DE
        RET     C
        LD      A,H
        CP      02H     ; 2
        RET     C
        PUSH    BC
        LD      HL,0
        ADD     HL,SP
        LD      E,L
        LD      D,H
        ADD     HL,BC
        PUSH    HL
        LD      HL,(STKTOP)
        OR      A
        SBC     HL,DE
        LD      C,L
        LD      B,H
        INC     BC
        POP     HL
        LD      SP,HL
        EX      DE,HL
        LDIR
        POP     BC
        LD      HL,(HIMEM)
        ADD     HL,BC
        LD      (HIMEM),HL
        LD      DE,-534
        ADD     HL,DE
        LD      (FILTAB),HL
        EX      DE,HL
        LD      HL,(MEMSIZ)
        ADD     HL,BC
        LD      (MEMSIZ),HL
        LD      HL,(NULBUF)
        ADD     HL,BC
        LD      (NULBUF),HL
        LD      HL,(STKTOP)
        ADD     HL,BC
        JR      J5681

;         Subroutine __________________________
;            Inputs  ________________________
;            Outputs ________________________

C565C:  LD      A,1
        LD      (MAXFIL),A
        LD      HL,(HIMEM)
        LD      DE,-534
        ADD     HL,DE
        LD      (FILTAB),HL
        LD      E,L
        LD      D,H
        DEC     HL
        DEC     HL
        LD      (MEMSIZ),HL
        LD      BC,200
        OR      A
        SBC     HL,BC
        PUSH    HL
        LD      HL,13
        ADD     HL,DE
        LD      (NULBUF),HL
        POP     HL
J5681:  LD      (STKTOP),HL
        DEC     HL
        DEC     HL
        LD      (SAVSTK),HL
        LD      L,E
        LD      H,D
        INC     HL
        INC     HL
        INC     HL
        INC     HL
        LD      A,02H   ; 2
J5691:  EX      DE,HL
        LD      (HL),E
        INC     HL
        LD      (HL),D
        INC     HL
        EX      DE,HL
        LD      BC,7
        LD      (HL),B
        ADD     HL,BC
        LD      (HL),B
        LD      BC,258
        ADD     HL,BC
        DEC     A
        JR      NZ,J5691
        RET

;         Subroutine __________________________
;            Inputs  ________________________
;            Outputs ________________________

C56A5:  LD      HL,I5757
        LD      DE,H.POSD
        LD      BC,5
        LDIR
        LD      HL,I56CD
J56B3:  LD      E,(HL)
        INC     HL
        LD      D,(HL)
        INC     HL
        LD      A,E
        OR      D
        RET     Z
        EX      DE,HL
        LD      (HL),0F7H
        INC     HL
        LD      A,(LF348)
        LD      (HL),A
        INC     HL
        EX      DE,HL
        LDI
        LDI
        LD      A,0C9H
        LD      (DE),A
        JR      J56B3

I56CD:  DEFW	H.DSKO,C5EDC
        DEFW	H.DSKI,C5EBB
        DEFW	H.NAME,C6315
        DEFW	H.KILL,C6303
        DEFW	H.COPY,C6424
        DEFW	H.DSKF,C640D
        DEFW	H.LSET,C6026
        DEFW	H.RSET,C6025
        DEFW	H.FIEL,C5F9F
        DEFW	H.MKI$,C60E6
        DEFW	H.MKS$,C60E9
        DEFW	H.MKD$,C60EC
        DEFW	H.CVI,C6123
        DEFW	H.CVS,C6126
        DEFW	H.CVD,C6129
        DEFW	H.GETP,C5A2A
        DEFW	H.NOFO,C5A39
        DEFW	H.NULO,C5A82
        DEFW	H.NTFL,C5BEF
        DEFW	H.BINS,C5C51
        DEFW	H.BINL,C5C79
        DEFW	H.FILE,C61E0
        DEFW	H.DGET,C5F1E
        DEFW	H.FILO,C5BD6
        DEFW	H.INDS,C5B4F
        DEFW	H.LOC,C6361
        DEFW	H.LOF,C635E
        DEFW	H.EOF,C61C8
        DEFW	H.BAKU,C5BBD
        DEFW	H.PARD,C6665
        DEFW	H.NODE,C674F
        DEFW	H.ERRP,C6753
        DEFW	H.PHYD,C4C9D
        DEFW	H.FORM,C4E66
I5755:	DEFW	0

I5757:  INC     SP
        INC     SP
        JP      M6F1D

;         Subroutine EXTENSION ROM CALL statement handler
;            Inputs  ________________________
;            Outputs ________________________

C575C:  EI
        LD      A,(H.PHYD)
        CP      0C9H
        SCF
        RET     Z
        PUSH    HL
        CALL    C402D                  ; GETSLT
        LD      HL,LF348
        CP      (HL)
        JR      NZ,J5795
        LD      HL,I5799
J5771:  LD      DE,PROCNM
J5774:  LD      A,(DE)
        CP      (HL)
        JR      NZ,J578B
        INC     DE
        INC     HL
        AND     A
        JR      NZ,J5774
        LD      E,(HL)
        INC     HL
        LD      D,(HL)
        POP     HL
        CALL    C665E
        CALL    C5789
        AND     A
        RET

;         Subroutine __________________________
;            Inputs  ________________________
;            Outputs ________________________

C5789:  PUSH    DE
        RET

J578B:  LD      C,0FFH
        XOR     A
        CPIR
        INC     HL
        INC     HL
        CP      (HL)
        JR      NZ,J5771
J5795:  POP     HL
        JP      OEMSTA

I5799:  DEFB	"SYSTEM"
        DEFB	0
        DEFW	C57D6

        DEFB	"FORMAT"
        DEFB	0
        DEFW	C581A

        DEFB	"CHDRV"
        DEFB	0
        DEFW	C5821

        DEFB	"CHDIR"
        DEFB	0
        DEFW	C585A

        DEFB	"MKDIR"
        DEFB	0
        DEFW	C5869

        DEFB	"RMDIR"
        DEFB	0
        DEFW	C587D

        DEFB	"RAMDISK"
        DEFB	0
        DEFW	C58AF

        DEFB	0

C57D6:  LD      DE,BUF+10
        JR      Z,J5805
        CALL    C6654
        DEFB    "("
        LD      IX,M4C64
        CALL    C664F
        PUSH    HL
        LD      IX,M67D0
        CALL    C664F
        LD      C,(HL)
        INC     HL
        LD      A,(HL)
        INC     HL
        LD      H,(HL)
        LD      L,A
        LD      DE,BUF+10
        INC     C
        DEC     C
        JR      Z,J57FF
        LD      B,00H
        LDIR
J57FF:  POP     HL
        CALL    C6654
        DEFB    ")"
        RET     NZ
J5805:  XOR     A
        LD      (DE),A
        LD      IX,M6C1C
        CALL    C664F
        CALL    TOTEXT
        CALL    ERAFNK
        LD      HL,BUF+10
        JP      J4ADC

C581A:  RET     NZ
        PUSH    HL
        CALL    C4E66
        POP     HL
        RET

C5821:  CALL    C634C
        CALL    C6654
        DEFB    ")"
        PUSH    HL
        LD      BC,005BH
        CALL    C6559
        EX      DE,HL
        LD      A,B
        AND     05H     ; 5
        XOR     04H     ; 4
        OR      (HL)
        JP      NZ,J65ED
        LD      A,C
        CALL    C5846
        DEC     A
        LD      E,A
        LD      C,0EH   ; 14
        CALL    B.BDOS
        POP     HL
        RET

;         Subroutine __________________________
;            Inputs  ________________________
;            Outputs ________________________

C5846:  PUSH    AF
        LD      C,18H
        CALL    B.BDOS
        POP     AF
        PUSH    AF
J584E:  SRL     H
        RR      L
        DEC     A
        JR      NZ,J584E
        JP      NC,J65ED
        POP     AF
        RET

C585A:  CALL    C634C
        CALL    C6654
        DEFB    ")"
        PUSH    HL
        LD      C,5AH   ; "Z"
        CALL    C6559
        POP     HL
        RET

C5869:  CALL    C634C
        CALL    C6654
        DEFB    ")"
        PUSH    HL
        LD      B,10H   ; 16
        LD      C,44H   ; "D"
        CALL    C6559
        CALL    C6343
        POP     HL
        RET

C587D:  CALL    C634C
        CALL    C6654
        DEFB    ")"
        RET     NZ
        PUSH    HL
        LD      B,10H   ; 16
        CALL    C59D3
        XOR     A
        PUSH    AF
J588D:  LD      A,(BUF+24)
        AND     10H     ; 16
        JR      Z,J589F
        LD      DE,BUF+10
        LD      C,4DH   ; "M"
        CALL    C655D
        POP     AF
        SCF
        PUSH    AF
J589F:  CALL    C59D8
        JR      NC,J588D
        POP     AF
        LD      A,0D6H
        JP      NC,J65C3
        CALL    C6343
        POP     HL
        RET

C58AF:  CALL    C6654
        DEFB    "("                     ; Check for "("
        CP      ","                     ; Is it a ","
        LD      A,0FFH
        JR      Z,J58DB
        LD      IX,M520F
        CALL    C664F
        INC     D
        DEC     D
        JP      M,J662D
        LD      B,4
J58C7:  SRL     D
        RR      E
        JR      NC,J58CE

; HSH V2 has
;       LD      D,E
; looks like a bit in EPROM was corrupted (013H vs 053H)

        INC     DE
J58CE:  DJNZ    J58C7
        LD      A,E
        INC     D
        DEC     D
        JR      NZ,J58D9
        CP      0FFH
        JR      NZ,J58DB
J58D9:  LD      A,0FEH
J58DB:  PUSH    AF
        LD      A,(HL)
        CP      2CH     ; ","
        LD      DE,D.0000
        JR      NZ,J58EE
        CALL    C665F
        LD      IX,M5EA4
        CALL    C664F
J58EE:  POP     BC
        CALL    C6654
        DEFB    ")"
        RET     NZ
        LD      A,(VALTYP)
        CP      03H     ; 3
        JP      Z,J6627
        PUSH    HL
        PUSH    DE
        PUSH    AF
        LD      C,68H   ; "h"
        CALL    C655D
        LD      L,B
        LD      H,00H
        ADD     HL,HL
        ADD     HL,HL
        ADD     HL,HL
        ADD     HL,HL
        LD      (DAC+2),HL
        POP     AF
        LD      (VALTYP),A
        POP     DE
        LD      A,E
        OR      D
        CALL    NZ,C591A
        POP     HL
        RET

;         Subroutine __________________________
;            Inputs  ________________________
;            Outputs ________________________

C591A:  PUSH    DE
        LD      HL,VALTYP
        LD      A,(HL)
        LD      C,A
        LD      (HL),02H        ; 2
        LD      HL,DAC+2
        CP      02H     ; 2
        JR      Z,J593E
        CP      04H     ; 4
        JR      Z,J5932
        CP      08H     ; 8
        JP      NZ,J6627
J5932:  PUSH    BC
        LD      IX,M517A
        CALL    C664F
        POP     BC
        LD      HL,DAC
J593E:  LD      B,0
        POP     DE
        LDIR
        RET

;         Subroutine __________________________
;            Inputs  ________________________
;            Outputs ________________________

C5944:  PUSH    HL
        PUSH    DE
        PUSH    BC
        XOR     A
        LD      (BUF+10),A
        LD      HL,(FILTAB)
        LD      A,(MAXFIL)
J5951:  PUSH    AF
        LD      E,(HL)
        INC     HL
        LD      D,(HL)
        INC     HL
        PUSH    HL
        EX      DE,HL
        LD      A,(HL)
        AND     A
        JR      Z,J598F
        INC     HL
        INC     HL
        INC     HL
        INC     HL
        LD      A,(HL)
        CP      09H     ; 9
        JR      NC,J598F
        LD      A,(BUF+10)
        AND     A
        JR      NZ,J597E
        PUSH    HL
        LD      DE,(D.F33B)
        LD      B,06H   ; 6
        LD      IX,BUF+10
        LD      C,40H   ; "@"
        CALL    C59DE
        POP     HL
        JR      C,J5998
J597E:  DEC     HL
        DEC     HL
        DEC     HL
        LD      B,(HL)
        LD      DE,BUF+10
        LD      C,4CH   ; "L"
        CALL    C655D
        LD      A,B
        AND     A
        JP      NZ,J663C
J598F:  POP     HL
        POP     AF
        DEC     A
        JP      P,J5951
        JP      J5A26

J5998:  POP     HL
        POP     HL
        JP      J5A26

;         Subroutine __________________________
;            Inputs  ________________________
;            Outputs ________________________

C599D:  PUSH    AF
        LD      B,00H
        LD      C,5BH   ; "["
        CALL    C6559
        POP     AF
        PUSH    BC
        PUSH    DE
        PUSH    HL
        PUSH    AF
        LD      B,A
        CALL    C59D3
        POP     AF
        POP     HL
        POP     DE
        POP     BC
        BIT     5,B
        RET     NZ
        LD      D,A
        LD      A,(BUF+24)
        AND     10H     ; 16
        RET     Z
        LD      A,L
        CP      E
        RET     Z
        PUSH    BC
        LD      B,D
        LD      DE,BUF+10
        PUSH    DE
        POP     IX
        LD      HL,I5755
        LD      C,40H   ; "@"
        CALL    C655D
        POP     BC
        RET

;         Subroutine __________________________
;            Inputs  ________________________
;            Outputs ________________________

C59D1:  LD      B,00H
;         Subroutine __________________________
;            Inputs  ________________________
;            Outputs ________________________

C59D3:  LD      C,40H   ; "@"
        JP      J6555

;         Subroutine __________________________
;            Inputs  ________________________
;            Outputs ________________________

C59D8:  LD      IX,BUF+10
        LD      C,41H   ; "A"
;         Subroutine __________________________
;            Inputs  ________________________
;            Outputs ________________________

C59DE:  CALL    B.BDOS
        RET     Z
        CP      0D7H
        SCF
        RET     Z
        JP      J65C3

;         Subroutine __________________________
;            Inputs  ________________________
;            Outputs ________________________

C59E9:  EI
        PUSH    HL
        PUSH    DE
        PUSH    BC
        PUSH    AF
        LD      A,(LF348)
        ADD     A,A
        LD      HL,16
        JR      NC,J59F9
        LD      L,16+8
J59F9:  ADD     HL,SP
        PUSH    IX
        POP     BC
        LD      (HL),C
        INC     HL
        LD      (HL),B
        LD      HL,10
        ADD     HL,SP
        EX      DE,HL
        JR      J5A13

J5A07:  PUSH    IY
        POP     BC
J5A0A:  LD      C,(HL)
        LD      A,(DE)
        LD      (HL),A
        LD      A,C
        LD      (DE),A
        INC     HL
        INC     DE
        DJNZ    J5A0A
J5A13:  LD      A,(LF348)
        ADD     A,A
        LD      HL,18
        JR      NC,J5A1E
        LD      L,18+8
J5A1E:  ADD     HL,SP
        LD      A,E
        SUB     L
        LD      A,D
        SBC     A,H
        JR      C,J5A07
J5A25:  POP     AF
J5A26:  POP     BC
        POP     DE
        POP     HL
        RET

C5A2A:  LD      IX,LF38B
        LD      IY,0200H
        CALL    C59E9
        POP     HL
        LD      A,(HL)
        AND     A
        RET

C5A39:  EI
        LD      BC,256
        LD      (D.F33D),BC
        CALL    C665E
        LD      A,E
        RET     Z
        PUSH    AF
        PUSH    HL
        LD      A,(LF348)
        ADD     A,A
        LD      HL,12
        JR      NC,J5A53
        LD      L,12+8
J5A53:  ADD     HL,SP
        LD      A,(HL)
        CP      04H     ; 4
        JP      NZ,J6630
        INC     HL
        LD      A,(HL)
        CP      09H     ; 9
        JP      NC,J6630
        POP     HL
        CALL    C6654
        DEFB    0FFH
        CALL    C6654
        DEFB	092H
        CALL    C6654
        DEFB    0EFH
        LD      IX,M4756
        CALL    C664F
        DEC     DE
        INC     D
        DEC     D
        JP      NZ,J662D
        INC     DE
        LD      (D.F33D),DE
        POP     AF
        RET

C5A82:  EI
        RET     NC
        LD      IX,LF38B
        LD      IY,0400H
        CALL    C59E9
        CALL    C5944
        LD      (PTRFIL),HL
        INC     HL
        INC     HL
        XOR     A
        LD      (HL),A
        INC     HL
        LD      (HL),A
        INC     HL
        LD      (HL),D
        INC     HL
        INC     HL
        LD      (HL),A
        LD      A,E
        PUSH    AF
        AND     82H
        JR      Z,J5AB7
J5AA6:  XOR     A
        LD      B,A
        LD      C,44H   ; "D"
        CALL    C6559
J5AAD:  POP     AF
        LD      HL,(PTRFIL)
        LD      (HL),A
        INC     HL
        LD      (HL),B
        POP     AF
        POP     HL
        RET

J5AB7:  LD      A,E
        CP      04H     ; 4
        JR      NZ,J5AD4
        LD      HL,(PTRFIL)
        INC     HL
        INC     HL
        LD      A,(D.F33D)
        DEC     A
        LD      (HL),A
        LD      DE,(D.F33B)
        XOR     A
        LD      C,43H   ; "C"
        CALL    C59DE
        JR      C,J5AA6
        JR      J5AAD

J5AD4:  CP      01H     ; 1
        JR      NZ,J5B0B
        XOR     A
        LD      C,43H   ; "C"
        CALL    C6559
        LD      HL,FLBMEM
        XOR     A
        CP      (HL)
        LD      (HL),A
        JR      NZ,J5AAD
        POP     AF
        LD      HL,(PTRFIL)
        LD      (HL),A
        INC     HL
        LD      (HL),B
        DEC     HL
        EX      DE,HL
        LD      HL,6
        ADD     HL,DE
        LD      (HL),0FFH
        PUSH    HL
        EX      DE,HL
        CALL    C5B60
        POP     HL
        DEC     HL
        DEC     HL
        DEC     HL
        LD      (HL),A
        INC     A
        JR      NZ,J5B08
        INC     HL
        INC     HL
        INC     HL
        INC     HL
        LD      (HL),80H
J5B08:  POP     AF
        POP     HL
        RET

J5B0B:  XOR     A
        LD      C,43H   ; "C"
        CALL    C6559
        POP     AF
        LD      HL,(PTRFIL)
        LD      (HL),01H        ; 1
        INC     HL
        LD      (HL),B
        DEC     HL
        EX      DE,HL
        LD      HL,6
        ADD     HL,DE
        LD      (HL),0FFH
        EX      DE,HL
        LD      BC,D.0000
        LD      E,C
        LD      D,B
J5B27:  PUSH    HL
        PUSH    DE
        PUSH    BC
        CALL    C5B60
        POP     BC
        POP     DE
        POP     HL
        JR      C,J5B3A
        INC     BC
        LD      A,C
        OR      B
        JR      NZ,J5B27
        INC     DE
        JR      J5B27

J5B3A:  PUSH    BC
        LD      (HL),02H        ; 2
        INC     HL
        LD      B,(HL)
        INC     HL
        INC     HL
        INC     HL
        INC     HL
        INC     HL
        XOR     A
        LD      (HL),A
        POP     HL
        LD      C,4AH   ; "J"
        CALL    B.BDOS
        POP     AF
        POP     HL
        RET

C5B4F:  LD      IX,LF38B
        LD      IY,0600H
        CALL    C59E9
        CALL    C5B60
        JP      J5A26

;         Subroutine __________________________
;            Inputs  ________________________
;            Outputs ________________________

C5B60:  PUSH    HL
        LD      A,(HL)
        CP      01H     ; 1
        JP      NZ,J65EA
        LD      E,L
        LD      D,H
        INC     HL
        INC     HL
        INC     HL
        LD      A,(HL)
        AND     A
        JR      NZ,J5BAF
        INC     HL
        INC     HL
        INC     HL
        INC     (HL)
        LD      A,(HL)
        INC     HL
        INC     HL
        INC     HL
        JR      NZ,J5BAA
        PUSH    HL
        EX      DE,HL
        INC     HL
        LD      B,(HL)
        LD      HL,256
        LD      C,48H   ; "H"
        CALL    B.BDOS
        JR      Z,J5B92
        CP      0C7H
        JP      NZ,J65C3
        POP     HL
        LD      (HL),1AH
        JR      J5BAE

J5B92:  LD      C,L
        LD      B,H
        DEC     H
        LD      A,L
        OR      H
        POP     HL
        JR      Z,J5BAA
        PUSH    HL
        LD      E,L
        LD      D,H
        INC     D
        DEC     DE
        ADD     HL,BC
        LD      A,C
        DEC     HL
        LDDR
        DEC     HL
        DEC     HL
        NEG
        LD      (HL),A
        POP     HL
J5BAA:  LD      C,A
        LD      B,00H
        ADD     HL,BC
J5BAE:  LD      A,(HL)
J5BAF:  SUB     1AH
        SUB     01H     ; 1
        LD      A,(HL)
        POP     HL
        INC     HL
        INC     HL
        INC     HL
        LD      (HL),00H
        RET     NC
        LD      (HL),A
        RET

C5BBD:  EI
        PUSH    HL
        LD      A,(LF348)
        ADD     A,A
        LD      HL,8
        JR      NC,J5BCA
        LD      L,8+8
J5BCA:  ADD     HL,SP
        LD      (HL),41H        ; "A"
        INC     HL
        LD      (HL),6EH        ; "n"
        POP     HL
        INC     HL
        INC     HL
        INC     HL
        LD      (HL),C
        RET

C5BD6:  LD      IX,LF38B
        LD      IY,0800H
        CALL    C59E9
        LD      A,(HL)
        CP      02H     ; 2
        JP      NZ,J65EA
        POP     AF
        PUSH    AF
        CALL    C5C2B
        JP      J5A25

C5BEF:  LD      IX,LF38B
        LD      IY,0400H
        CALL    C59E9
        POP     HL
        LD      A,(HL)
        SUB     02H     ; 2
        JR      NZ,J5C13
        PUSH    HL
        LD      HL,FLBMEM
        CP      (HL)
        LD      (HL),A
        POP     HL
        JR      NZ,J5C13
        LD      (HL),04H        ; 4
        LD      A,1AH
        CALL    C5C2B
        CALL    NZ,C5C39
J5C13:  XOR     A
        CP      (HL)
        LD      (HL),A
        PUSH    AF
        INC     HL
        LD      B,(HL)
        LD      DE,6
        ADD     HL,DE
        LD      (HL),A
        LD      L,A
        LD      H,A
        LD      (PTRFIL),HL
        LD      C,45H   ; "E"
        CALL    C655D
        POP     AF
        POP     HL
        RET

;         Subroutine __________________________
;            Inputs  ________________________
;            Outputs ________________________

C5C2B:  PUSH    HL
        LD      BC,6
        ADD     HL,BC
        LD      C,(HL)
        INC     (HL)
        INC     HL
        INC     HL
        INC     HL
        ADD     HL,BC
        LD      (HL),A
        POP     HL
        RET     NZ

;         Subroutine __________________________
;            Inputs  ________________________
;            Outputs ________________________

C5C39:  PUSH    HL
        INC     HL
        LD      B,(HL)
        LD      DE,5
        ADD     HL,DE
        LD      A,(HL)
        INC     HL
        INC     HL
        INC     HL
        EX      DE,HL
        DEC     A
        LD      L,A
        LD      H,00H
        INC     HL
        LD      C,49H   ; "I"
        CALL    C655D
        POP     HL
        RET

C5C51:  CALL    C6888
        PUSH    HL
        LD      IX,M54F7
        CALL    C664F
        LD      A,0FFH
        CALL    C5E8F
        LD      DE,(TXTTAB)
        LD      HL,(VARTAB)
        AND     A
        SBC     HL,DE
        CALL    C5EA7
        LD      (NLONLY),A
        POP     HL
        LD      IX,M6B24
        JP      C664F

C5C79:  LD      IX,M739A
        LD      IY,512
        CALL    C59E9
        POP     AF
        JP      Z,J65EA
        LD      IX,M6C1C
        CALL    C664F
        LD      HL,-199
        ADD     HL,SP
        LD      DE,(TXTTAB)
        SBC     HL,DE
        JP      C,J662A
        PUSH    HL
        CALL    C5EAF
        PUSH    BC
        XOR     A
        LD      DE,D.0000
        LD      HL,I.0001
        LD      C,4AH   ; "J"
        CALL    C655D
        POP     BC
        LD      DE,(TXTTAB)
        POP     HL
        PUSH    HL
        LD      C,48H   ; "H"
        CALL    C655D
        POP     DE
        PUSH    HL
        AND     A
        SBC     HL,DE
        POP     HL
        JP      NC,J662A
        LD      DE,(TXTTAB)
        ADD     HL,DE
        LD      (VARTAB),HL
        LD      IX,M4253
        CALL    C664F
        LD      A,(FILNAM+0)
        AND     A
        RET     NZ
        LD      (NLONLY),A
        LD      HL,I5CED
        LD      DE,BUF+10
        LD      BC,5
        PUSH    DE
        LDIR
        POP     HL
        LD      IX,M4601
        JP      C664F

I5CED:	DEFB	03AH,092H,0
        DEFW	0

C5CF2:  PUSH    DE
        CALL    C5E7E
        LD      (SAVENT),DE
        PUSH    DE
        CALL    C5E7E
        LD      (SAVEND),DE
        EX      (SP),HL
        EX      DE,HL
        RST     20H
        JP      C,J662D
        EX      DE,HL
        EX      (SP),HL
        CALL    C665E
        SCF
        JR      Z,J5D26
        CALL    C6654
        DEFB    ","
        CP      "S"
        JR      NZ,J5D1E
        CALL    C665F
        AND     A
        JR      J5D26

J5D1E:  CALL    C5E82
        LD      (SAVENT),DE
        SCF
J5D26:  POP     BC
        JR      NC,J5D2E
        INC     B
        DEC     B
        JP      P,J662D
J5D2E:  POP     DE
        PUSH    HL
        PUSH    BC
        PUSH    AF
        XOR     A
        LD      E,02H   ; 2
        LD      IX,M6AFA
        CALL    C664F
        LD      A,0FEH
        CALL    C5E8F
        POP     AF
        POP     HL
        PUSH    HL
        PUSH    AF
        CALL    C5E89
        LD      HL,(SAVEND)
        CALL    C5E89
        LD      HL,(SAVENT)
        CALL    C5E89
        POP     AF
        POP     BC
        PUSH    AF
        LD      HL,(SAVEND)
        AND     A
        SBC     HL,BC
        INC     HL
        POP     AF
        JR      NC,J5D76
        LD      E,C
        LD      D,B
        CALL    C5EA7
J5D66:  LD      A,0FFH
        LD      (FLBMEM),A
        XOR     A
        LD      IX,M6B24
        CALL    C664F
        JP      J627A

J5D76:  CALL    C6511
J5D79:  PUSH    HL
        LD      DE,(SAVENT)
        RST     20H
        PUSH    AF
        PUSH    BC
        LD      C,L
        LD      B,H
        LD      HL,(SAVEND)
        PUSH    HL
        ADD     HL,BC
        LD      (SAVEND),HL
        POP     HL
        POP     DE
        PUSH    DE
        CALL    C$0059
        POP     BC
        POP     AF
        JR      NC,J5DAB
        POP     HL
        PUSH    HL
        PUSH    BC
        LD      E,C
        LD      D,B
        CALL    C5EA7
        POP     BC
        POP     DE
        LD      HL,(SAVENT)
        AND     A
        SBC     HL,DE
        LD      (SAVENT),HL
        EX      DE,HL
        JR      J5D79

J5DAB:  POP     HL
        LD      HL,(SAVENT)
        LD      E,C
        LD      D,B
        CALL    C5EA7
        JR      J5D66

C5DB6:  PUSH    DE
        XOR     A
        LD      (RUNBNF),A
        LD      C,A
        LD      B,A
        CALL    C665E
        JR      Z,J5DDF
        CALL    C6654
        DEFB    ","
        CP      "R"
        JR      Z,J5DCE
        CP      "S"
        JR      NZ,J5DDA
J5DCE:  LD      (RUNBNF),A
        CALL    C665F
        JR      Z,J5DDF
        CALL    C6654
        DEFB    ","
J5DDA:  CALL    C5E82
        LD      B,D
        LD      C,E
J5DDF:  POP     DE
        PUSH    HL
        PUSH    BC
        LD      A,0FFH
        LD      (FLBMEM),A
        XOR     A
        LD      E,01H   ; 1
        LD      IX,M6AFA
        CALL    C664F
        CALL    C5E92
        CP      0FEH
        JP      NZ,J65EA
        POP     BC
        CALL    C5E70
        PUSH    HL
        CALL    C5E70
        PUSH    HL
        CALL    C5E70
        LD      (SAVENT),HL
        POP     HL
        POP     BC
        AND     A
        SBC     HL,BC
        INC     HL
        LD      A,(RUNBNF)
        CP      53H     ; "S"
        JR      Z,J5E28
        LD      E,C
        LD      D,B
        CALL    C5EAF
        LD      C,48H   ; "H"
        CALL    C655D
J5E1F:  LD      IX,M4AFF
        CALL    C664F
        POP     HL
        RET

J5E28:  CALL    C6511
J5E2B:  PUSH    HL
        PUSH    BC
        LD      DE,(SAVENT)
        RST     20H
        PUSH    AF
        LD      E,C
        LD      D,B
        CALL    C5EAF
        LD      C,48H   ; "H"
        CALL    B.BDOS
        POP     AF
        POP     HL
        POP     BC
        PUSH    BC
        PUSH    HL
        PUSH    AF
        LD      HL,(SAVEND)
        PUSH    HL
        ADD     HL,BC
        LD      (SAVEND),HL
        POP     DE
        POP     AF
        POP     HL
        JR      NC,J5E62
        PUSH    HL
        CALL    C005C
        POP     BC
        POP     DE
        LD      HL,(SAVENT)
        AND     A
        SBC     HL,DE
        LD      (SAVENT),HL
        EX      DE,HL
        JR      J5E2B

J5E62:  POP     BC
        LD      BC,(SAVENT)
        CALL    C005C
        XOR     A
        LD      (RUNBNF),A
        JR      J5E1F

;         Subroutine __________________________
;            Inputs  ________________________
;            Outputs ________________________

C5E70:  PUSH    BC
        CALL    C5E92
        PUSH    AF
        CALL    C5E92
        LD      H,A
        POP     AF
        LD      L,A
        POP     BC
        ADD     HL,BC
        RET

;         Subroutine __________________________
;            Inputs  ________________________
;            Outputs ________________________

C5E7E:  CALL    C6654
        DEFB    ","

;         Subroutine __________________________
;            Inputs  ________________________
;            Outputs ________________________

C5E82:  LD      IX,M6F0B
        JP      C664F

;         Subroutine __________________________
;            Inputs  ________________________
;            Outputs ________________________

C5E89:  PUSH    HL
        LD      A,L
        CALL    C5E8F
        POP     AF
;         Subroutine __________________________
;            Inputs  ________________________
;            Outputs ________________________

C5E8F:  LD      C,49H   ; "I"
        LD      HL,I480E
C5E92   EQU     $-2
J5E93   EQU     $-1
        CALL    C5EAF
        PUSH    AF
        LD      HL,I.0001
        ADD     HL,SP
        EX      DE,HL
        LD      HL,I.0001
        PUSH    BC
        CALL    C655D
        POP     BC
        POP     AF
        RET

;         Subroutine __________________________
;            Inputs  ________________________
;            Outputs ________________________

C5EA7:  CALL    C5EAF
        LD      C,49H   ; "I"
        JP      C655D

;         Subroutine __________________________
;            Inputs  ________________________
;            Outputs ________________________

C5EAF:  PUSH    HL
        LD      HL,(FILTAB)
        LD      B,(HL)
        INC     HL
        LD      H,(HL)
        LD      L,B
        INC     HL
        LD      B,(HL)
        POP     HL
        RET

C5EBB:  CALL    C6888
        CALL    C665F
        CALL    C6654
        DEFB    "("
        CALL    C5F09
        CALL    C6654
        DEFB    ")"
        PUSH    HL
        LD      HL,I$3FD6
        LD      (DAC+2),HL
        LD      A,03H   ; 3
        LD      (VALTYP),A
        LD      L,2FH   ; "/"
        JR      J5EE9

C5EDC:  CALL    C6888
        CALL    C5F09
        CALL    C665E
        RET     NZ
        PUSH    HL
        LD      L,30H   ; "0"
J5EE9:  PUSH    HL
        PUSH    DE
        PUSH    BC
        LD      DE,BUF+10
        LD      L,C
        LD      C,31H   ; "1"
        CALL    C655D
        LD      DE,(D.F351)
        LD      C,1AH
        CALL    B.BDOS
        POP     HL
        DEC     L
        LD      H,01H   ; 1
        POP     DE
        POP     BC
        CALL    C655D
        POP     HL
        RET

;         Subroutine __________________________
;            Inputs  ________________________
;            Outputs ________________________

C5F09:  LD      IX,M521C
        CALL    C664F
        PUSH    DE
        CALL    C6654
        DEFB    ","
        LD      IX,M542F
        CALL    C664F
        POP     BC
        RET

C5F1E:  LD      IX,LF38B
        LD      IY,0400H
        CALL    C59E9
        LD      A,(HL)
        CP      04H     ; 4
        JP      NZ,J65EA
        EX      (SP),HL
        CALL    C665E
        JR      Z,J5F7D
        CALL    C6654
        DEFB    ","
        LD      IX,M4C64
        CALL    C664F
        PUSH    HL
        CALL    C6147
        LD      A,C
        OR      B
        OR      L
        OR      H
        JP      Z,J662D
        LD      A,C
        OR      B
        DEC     BC
        JR      NZ,J5F51
        DEC     HL
J5F51:  EX      DE,HL
        POP     HL
        EX      (SP),HL
        PUSH    HL
        PUSH    DE
        INC     HL
        INC     HL
        LD      E,(HL)
        LD      D,00H
        INC     DE
        CALL    C689F
        POP     IX
        PUSH    BC
        PUSH    IX
        POP     BC
        CALL    C68A2
        LD      A,L
        OR      H
        JP      NZ,J662D
        LD      E,C
        LD      D,B
        POP     HL
        POP     BC
        PUSH    BC
        INC     BC
        LD      A,(BC)
        LD      B,A
        XOR     A
        LD      C,4AH   ; "J"
        CALL    B.BDOS
        POP     HL
        EX      (SP),HL
J5F7D:  EX      (SP),HL
        INC     HL
        LD      B,(HL)
        INC     HL
        LD      E,(HL)
        LD      D,00H
        INC     DE
        INC     HL
        INC     HL
        INC     HL
        INC     HL
        INC     HL
        INC     HL
        INC     HL
        EX      DE,HL
        POP     IX
        POP     AF
        PUSH    IX
        AND     A
        LD      C,48H   ; "H"
        JR      Z,J5F99
        LD      C,49H   ; "I"
J5F99:  CALL    C655D
        JP      J627A

C5F9F:  CALL    C6888
        CP      23H     ; "#"
        CALL    Z,C665F
        LD      IX,M521C
        CALL    C664F
        JP      Z,J6630
        PUSH    HL
        LD      IX,M6A6D
        CALL    C664F
        LD      E,L
        LD      D,H
        JP      Z,J6645
        JP      C,J662D
        LD      A,(HL)
        CP      04H     ; 4
        JP      NZ,J65EA
        INC     HL
        INC     HL
        LD      L,(HL)
        LD      H,00H
        INC     HL
        LD      (BUF+10),HL
        LD      HL,0
        LD      (BUF+12),HL
        LD      BC,9
        POP     HL
J5FDA:  EX      DE,HL
        ADD     HL,BC
        EX      DE,HL
        LD      A,(HL)
        CP      2CH     ; ","
        RET     NZ
        PUSH    DE
        LD      IX,M521B
        CALL    C664F
        PUSH    AF
        CALL    C6654
        DEFB    "A"
        CALL    C6654
        DEFB    "S"
        LD      IX,M5EA4
        CALL    C664F
        LD      IX,M5597
        CALL    C664F
        JP      NZ,J6627
        POP     AF
        EX      (SP),HL
        PUSH    DE
        PUSH    HL
        LD      HL,(BUF+12)
        LD      C,A
        LD      B,00H
        ADD     HL,BC
        LD      (BUF+12),HL
        EX      DE,HL
        LD      HL,(BUF+10)
        RST     20H
        JP      C,J6633
        POP     DE
        POP     HL
        LD      (HL),C
        INC     HL
        LD      (HL),E
        INC     HL
        LD      (HL),D
        LD      B,00H
        POP     HL
        JR      J5FDA

C6025:  DEFB	0F6H		        ; OR #37
C6026:  SCF
        CALL    C6888
        PUSH    AF
        LD      IX,M5EA4
        CALL    C664F
        LD      IX,M5597
        CALL    C664F
        JP      NZ,J6627
        PUSH    DE
        LD      IX,M4C5F
        CALL    C664F
        POP     BC
        EX      (SP),HL
        PUSH    HL
        PUSH    BC
        LD      IX,M67D0
        CALL    C664F
        LD      B,(HL)
        EX      (SP),HL
        LD      A,(HL)
        LD      C,A
I6053:  PUSH    BC
        PUSH    HL
        PUSH    AF
        INC     HL
        LD      E,(HL)
        INC     HL
        LD      D,(HL)
        OR      A
        JR      Z,J60B9
        LD      HL,(NULBUF)
        DEC     HL
        RST     20H
        JR      C,J6097
        LD      HL,(VARTAB)
        RST     20H
        JR      C,J6097
        LD      E,C
        LD      D,00H
        LD      HL,(STKTOP)
        ADD     HL,DE
        EX      DE,HL
        LD      HL,(FRETOP)
        RST     20H
        JR      C,J60CC
        POP     AF
J6079:  LD      A,C
        LD      IX,M668E
        CALL    C664F
        POP     HL
        POP     BC
        EX      (SP),HL
        PUSH    DE
        PUSH    BC
        LD      IX,M67D0
        CALL    C664F
        POP     BC
        POP     DE
        EX      (SP),HL
        PUSH    BC
        PUSH    HL
        INC     HL
        PUSH    AF
        LD      (HL),E
        INC     HL
        LD      (HL),D
J6097:  POP     AF
        POP     HL
        INC     HL
        LD      E,(HL)
        INC     HL
        LD      D,(HL)
        POP     BC
        POP     HL
        INC     HL
        LD      A,(HL)
        INC     HL
        LD      H,(HL)
        LD      L,A
        LD      A,C
        CP      B
        JR      NC,J60A9
        LD      B,A
J60A9:  SUB     B
        LD      C,A
        POP     AF
        CALL    NC,C60C3
        INC     B
J60B0:  DEC     B
        JR      Z,J60BE
        LD      A,(HL)
        LD      (DE),A
        INC     HL
        INC     DE
        JR      J60B0

J60B9:  POP     BC
        POP     BC
        POP     BC
        POP     BC
        POP     BC
J60BE:  CALL    C,C60C3
        POP     HL
        RET

;         Subroutine __________________________
;            Inputs  ________________________
;            Outputs ________________________

C60C3:  LD      A,20H   ; " "
        INC     C
J60C6:  DEC     C
        RET     Z
        LD      (DE),A
        INC     DE
        JR      J60C6

J60CC:  POP     AF
        POP     HL
        POP     BC
        EX      (SP),HL
        EX      DE,HL
        JR      NZ,J60E0
        PUSH    BC
        LD      A,B
        LD      IX,M6627
        CALL    C664F
        CALL    C6107
        POP     BC
J60E0:  EX      (SP),HL
        PUSH    BC
        PUSH    HL
        JP      J6079

C60E6:  LD      A,2
        DEFB    001H
C60E9:  LD      A,4
        DEFB    001H
C60EC:  LD      A,8
        CALL    C6888
        PUSH    AF
        LD      IX,M517A
        CALL    C664F
        POP     AF
        LD      IX,M6627
        CALL    C664F
        LD      HL,(DSCTMP+1)
        CALL    C$2F10

;         Subroutine __________________________
;            Inputs  ________________________
;            Outputs ________________________

C6107:  LD      DE,DSCTMP
        LD      HL,(TEMPPT)
        LD      (DAC+2),HL
        LD      A,03H   ; 3
        LD      (VALTYP),A
        CALL    C$2EF3
        LD      DE,FRETOP
        RST     20H
        LD      (TEMPPT),HL
        JP      Z,J6624
        RET

C6123:  LD      A,1
        DEFB    001H
C6126:  LD      A,3
        DEFB    001H
C6129:  LD      A,7
        CALL    C6888
        PUSH    AF
        LD      IX,M67D0
        CALL    C664F
        POP     AF
        CP      (HL)
        JP      NC,J662D
        INC     A
        INC     HL
        LD      C,(HL)
        INC     HL
        LD      H,(HL)
        LD      L,C
        LD      (VALTYP),A
        JP      J$2F08

;         Subroutine __________________________
;            Inputs  ________________________
;            Outputs ________________________

C6147:  LD      IX,M5597
        CALL    C664F
        JP      M,J61B3
        JP      Z,J6627
        LD      HL,DAC+0
        LD      A,(HL)
        AND     A
        JP      M,J662D
        LD      DE,BUF+10
        LD      BC,8
        LDIR
        LD      HL,I61C0
        LD      DE,ARG
        LD      C,8
        LDIR
        CALL    C$289F
        AND     A
        CALL    C$30D1
        LD      IX,M5432
        CALL    C664F
        PUSH    DE
        EX      DE,HL
        LD      IX,M46FF
        CALL    C664F
        CALL    C.3042
        LD      BC,I6545
        LD      DE,I6053
        CALL    C.325C
        LD      HL,DAC
        PUSH    HL
        LD      DE,ARG
        LD      BC,8
        LDIR
        LD      HL,BUF+10
        POP     DE
        LD      C,08H   ; 8
        LDIR
        CALL    C$268C
        LD      IX,M5432
        CALL    C664F
        LD      C,E
        LD      B,D
        POP     HL
        RET

J61B3:  LD      BC,(DAC+2)
        INC     B
        DEC     B
        JP      M,J662D
        LD      HL,D.0000
        RET

I61C0:  045H,065H,053H,060H,0,0,0,0

C61C8:  CALL    C6888
        PUSH    HL
        CALL    C5B60
        LD      HL,D.0000
        JR      NC,J61D5
        DEC     HL
J61D5:  PUSH    AF
        CALL    C.2F99
        POP     AF
        POP     HL
        INC     HL
        INC     HL
        INC     HL
        LD      (HL),A
        RET

C61E0:  CALL    C6888
        CALL    C665E
        JR      Z,J61F1
        CP      2CH     ; ","
        JR      Z,J61F1
        CALL    C6350
        JR      J61F7

J61F1:  XOR     A
        LD      DE,(D.F33B)
        LD      (DE),A
J61F7:  CALL    C665E
        SCF
        JR      Z,J6206
        CALL    C6654
        DEFB    ","
        CALL    C6654
        DEFB    "L"
        AND     A
J6206:  PUSH    HL
        LD      A,(PRTFLG)
        INC     A
        DEC     A
        PUSH    AF
        LD      IX,M7323
        CALL    C664F
        POP     AF
        PUSH    AF
        LD      A,16H
        JR      NC,J621C
        LD      A,10H   ; 16
J621C:  CALL    C599D
        LD      A,C
        ADD     A,40H   ; "@"
        RST     18H
        LD      A,3AH   ; ":"
        RST     18H
        LD      A,5CH   ; "\"
        RST     18H
        LD      DE,BUF+75
        PUSH    DE
        LD      C,5EH   ; "^"
        CALL    C655D
        LD      (HL),A
        DEC     HL
        LD      (HL),A
        POP     HL
        CALL    C62FC
        LD      IX,M7328
        CALL    C664F
J6240:  POP     AF
        PUSH    AF
        CALL    C6282
        CALL    CKCNTC
        POP     AF
        PUSH    AF
        JR      NC,J6267
        LD      A,(LINLEN)
        LD      B,A
        LD      A,(TTYPOS)
        JR      Z,J625A
        LD      B,80
        LD      A,(LPTPOS)
J625A:  AND     A
        JR      Z,J626E
        ADD     A,0DH   ; 13
        CP      B
        JR      NC,J6267
        LD      A,20H   ; " "
        RST     18H
        JR      J626E

J6267:  LD      IX,M7328
        CALL    C664F
J626E:  LD      IX,BUF+10
        LD      C,41H   ; "A"
        CALL    B.BDOS
        JR      Z,J6240
        POP     AF
J627A:  POP     HL
        LD      IX,M4AFF
        JP      C664F

;         Subroutine __________________________
;            Inputs  ________________________
;            Outputs ________________________

C6282:  JR      NC,J62A4

;         Subroutine __________________________
;            Inputs  ________________________
;            Outputs ________________________

C6284:  LD      DE,BUF+11
        LD      HL,(D.F33B)
        LD      C,5CH   ; "\"
        CALL    C655D
        LD      B,08H   ; 8
        CALL    C629E
        LD      A,(HL)
        CP      20H     ; " "
        JR      Z,J629B
        LD      A,2EH   ; "."
J629B:  RST     18H
        LD      B,03H   ; 3
;         Subroutine __________________________
;            Inputs  ________________________
;            Outputs ________________________

C629E:  LD      A,(HL)
        RST     18H
        INC     HL
        DJNZ    C629E
        RET

J62A4:  CALL    C6284
        LD      A,20H   ; " "
        RST     18H
        LD      A,(BUF+24)
        LD      C,A
        BIT     4,C
        LD      A,64H   ; "d"
        CALL    C62F6
        BIT     0,C
        LD      A,72H   ; "r"
        CALL    C62F6
        BIT     1,C
        LD      A,68H   ; "h"
        CALL    C62F6
        BIT     2,C
        LD      A,73H   ; "s"
        CALL    C62F6
        BIT     5,C
        LD      A,61H   ; "a"
        CALL    C62F6
        LD      BC,(BUF+31)
        LD      HL,(BUF+33)
        CALL    C63BA
        LD      IX,M537B
        CALL    C664F
        INC     HL
        PUSH    HL
        LD      B,0CH   ; 12
J62E6:  LD      A,(HL)
        INC     HL
        DEC     B
        AND     A
        JR      NZ,J62E6
        LD      A,20H   ; " "
J62EE:  RST     18H
        DJNZ    J62EE
        POP     HL
        CALL    C62FC
        RET

;         Subroutine __________________________
;            Inputs  ________________________
;            Outputs ________________________

C62F6:  JR      NZ,J62FA
        LD      A,2DH   ; "-"
J62FA:  RST     18H
        RET

;         Subroutine __________________________
;            Inputs  ________________________
;            Outputs ________________________

C62FC:  LD      A,(HL)
        AND     A
        INC     HL
        RET     Z
        RST     18H
        JR      C62FC

C6303:  CALL    C6888
        CALL    C6350
        CALL    C665E
        RET     NZ
        PUSH    HL
        CALL    C59D1
        LD      C,4DH   ; "M"
        JR      J632E

C6315:  CALL    C6888
        CALL    C6350
        PUSH    HL
        CALL    C59D1
        POP     HL
        CALL    C6654
        DEFB    "A"
        CALL    C6654
        DEFB    "S"
        CALL    C6350
        PUSH    HL
        LD      C,4EH   ; "N"
J632E:  PUSH    BC
        LD      DE,BUF+10
        LD      HL,(D.F33B)
        CALL    C655D
        CALL    C59D8
        POP     BC
        JR      NC,J632E
        CALL    C6343
        POP     HL
        RET

;         Subroutine __________________________
;            Inputs  ________________________
;            Outputs ________________________

C6343:  LD      B,0FFH
        LD      D,00H
        LD      C,5FH   ; "_"
        JP      C655D

;         Subroutine __________________________
;            Inputs  ________________________
;            Outputs ________________________

C634C:  CALL    C6654
        DEFB    "("
C6350:  LD      IX,M6A0E
        CALL    C664F
        LD      A,D
        CP      09H     ; 9
        RET     C
        JP      J65ED

C635E:  LD      A,2
        DEFB    011H
C6361:  LD      A,1
        CALL    C6888
        PUSH    AF
        LD      IX,M521F
        CALL    C664F
        LD      IX,M6A6D
        CALL    C664F
        JP      C,J662D
        JP      Z,J6645
        INC     HL
        LD      B,(HL)
        INC     HL
        LD      C,(HL)
        LD      A,01H   ; 1
        LD      DE,D.0000
        LD      HL,D.0000
        PUSH    BC
        LD      C,4AH   ; "J"
        CALL    C655D
        POP     BC
        POP     AF
        DEC     A
        JR      NZ,J6399
        PUSH    BC
        CALL    C63E4
        POP     BC
        JR      J63B7

J6399:  PUSH    HL
        PUSH    DE
        LD      A,02H   ; 2
        LD      DE,D.0000
        LD      HL,D.0000
        LD      C,4AH   ; "J"
        PUSH    BC
        CALL    C655D
        POP     BC
        POP     IX
        EX      (SP),HL
        PUSH    DE
        PUSH    IX
        POP     DE
        XOR     A
        CALL    C655D
        POP     DE
        POP     HL
J63B7:  LD      C,L
        LD      B,H
        EX      DE,HL
;         Subroutine __________________________
;            Inputs  ________________________
;            Outputs ________________________

C63BA:  PUSH    BC
        LD      IX,M46FF
        CALL    C664F
        LD      BC,I6545
        LD      DE,I6053
        CALL    C.325C
        LD      HL,DAC
        LD      DE,ARG
        LD      BC,8
        LDIR
        POP     HL
        LD      IX,M46FF
        CALL    C664F
        CALL    C.3042
        JP      J$269A

;         Subroutine __________________________
;            Inputs  ________________________
;            Outputs ________________________

C63E4:  INC     C
        JR      NZ,J63EF
        LD      A,L
        LD      L,H
        LD      H,E
        LD      E,D
        LD      D,00H
        JR      J6403

J63EF:  XOR     A
        LD      B,21H   ; "!"
J63F2:  ADC     A,A
        JR      C,J63F9
        CP      C
        CCF
        JR      NC,J63FB
J63F9:  SUB     C
        SCF
J63FB:  ADC     HL,HL
        EX      DE,HL
        ADC     HL,HL
        EX      DE,HL
        DJNZ    J63F2
J6403:  OR      A
        RET     Z
        INC     L
        RET     NZ
        INC     H
        RET     NZ
        INC     E
        RET     NZ
        INC     D
        RET

C640D:  CALL    C6888
        LD      IX,M521F
        CALL    C664F
        AND     A
        CALL    NZ,C5846
        LD      E,A
        LD      C,1BH
        CALL    B.BDOS
        JP      C.2F99

C6424:  CALL    C6888
        CALL    C6350
        PUSH    HL
        CALL    C59D1
        POP     HL
        CALL    C665E
        LD      A,00H
        PUSH    HL
        LD      HL,(D.F33B)
        LD      (HL),A
        POP     HL
        JR      Z,J6447
        CALL    C6654
        DEFB    0D9H
        CALL    C6350
        CALL    C665E
        RET     NZ
J6447:  PUSH    HL
J6448:  CALL    CKCNTC
        LD      DE,BUF+10
        XOR     A
        LD      C,43H   ; "C"
        CALL    C655D
        LD      A,B
        LD      (BUF+138),A
        XOR     A
        LD      C,56H   ; "V"
        CALL    C655D
        LD      (BUF+140),DE
        LD      (BUF+142),HL
        LD      A,0FFH
        LD      (BUF+139),A
        LD      HL,I6532
        LD      (D.F325),HL
        CALL    C6518
        LD      E,C
        LD      D,B
J6475:  PUSH    HL
        PUSH    DE
J6477:  LD      A,L
        OR      H
        JR      Z,J6498
        PUSH    HL
        PUSH    DE
        LD      A,(BUF+138)
        LD      B,A
        LD      C,48H   ; "H"
        CALL    B.BDOS
        JR      Z,J648A
        CP      0C7H
J648A:  JP      NZ,J6538
        EX      DE,HL
        POP     HL
        ADD     HL,DE
        EX      (SP),HL
        SBC     HL,DE
        LD      A,E
        OR      D
        POP     DE
        JR      NZ,J6477
J6498:  EX      DE,HL
        POP     DE
        PUSH    DE
        SBC     HL,DE
        LD      A,(BUF+139)
        INC     A
        JR      NZ,J64CC
        PUSH    HL
        LD      HL,BUF+11
        LD      DE,BUF+75
        LD      BC,13
        LDIR
        LD      DE,(D.F33B)
        LD      B,00H
        LD      IX,BUF+74
        LD      C,42H   ; "B"
        CALL    C6534
        LD      DE,BUF+74
        XOR     A
        LD      C,43H   ; "C"
I64C3   EQU     $-1
        CALL    C6534
        LD      A,B
        LD      (BUF+139),A
        POP     HL
J64CC:  POP     DE
        LD      A,(BUF+139)
        LD      B,A
        PUSH    DE
        LD      C,49H   ; "I"
        CALL    C6534
        POP     DE
        POP     BC
        SBC     HL,BC
        LD      L,C
        LD      H,B
        JR      NC,J6475
        LD      A,(BUF+139)
        LD      B,A
        LD      A,01H   ; 1
        LD      IX,(BUF+140)
        LD      HL,(BUF+142)
        LD      C,56H   ; "V"
        CALL    C6534
        LD      A,(BUF+138)
        LD      B,A
        LD      C,45H   ; "E"
        CALL    C6534
        LD      A,(BUF+139)
        LD      B,A
        LD      C,45H   ; "E"
        CALL    C6534
        LD      HL,I6568
        LD      (D.F325),HL
        CALL    C59D8
        JP      NC,J6448
        POP     HL
        RET

;         Subroutine __________________________
;            Inputs  ________________________
;            Outputs ________________________

C6511:  LD      (SAVENT),HL
        LD      (SAVEND),BC

;         Subroutine __________________________
;            Inputs  ________________________
;            Outputs ________________________

C6518:  LD      HL,-512
        ADD     HL,SP
        JR      NC,J652A
        LD      BC,(STREND)
        AND     A
        SBC     HL,BC
        JR      C,J652A
        LD      A,H
        AND     A
        RET     NZ
J652A:  LD      BC,(NULBUF)
        LD      HL,256
        RET

I6532:  LD      L,D
        LD      H,L
;         Subroutine __________________________
;            Inputs  ________________________
;            Outputs ________________________

C6534:  CALL    B.BDOS
        RET     Z
J6538:  PUSH    AF
        LD      HL,I6568
        LD      (D.F325),HL
        LD      A,(BUF+138)
        LD      B,A
        LD      C,45H   ; "E"
I6545:  CALL    B.BDOS
        LD      A,(BUF+139)
        LD      B,A
        INC     A
        LD      C,45H   ; "E"
        CALL    NZ,B.BDOS
        POP     AF
        JR      J65C3

J6555:  LD      IX,BUF+10
;         Subroutine __________________________
;            Inputs  ________________________
;            Outputs ________________________

C6559:  LD      DE,(D.F33B)
;         Subroutine __________________________
;            Inputs  ________________________
;            Outputs ________________________

C655D:  CALL    B.BDOS
        RET     Z
        JR      J65C3
J6562   EQU     $-1

I6563:  DEFW	I6565

I6565:  LD      C,2
        RET

I6568:  DEFW	I6571

;         Subroutine __________________________
;            Inputs  ________________________
;            Outputs ________________________

C656A:  CP      9DH
        JR      NZ,J656F
        LD      A,B
J656F:  OR      A
        RET

I6571:  CALL    C656A
        JR      NZ,J65C3
        LD      IX,M409B
        JP      C664F

I657D:  DEFB	0BAH
        DEFB	03EH		; .NRAMD -> Bad drive name
        DEFB	04BH		; .RAMDX -> RAM disk already exists
        DEFB	0BDH
        DEFB	0BEH
        DEFB	0BFH
        DEFB	0C0H
        DEFB	0C1H
        DEFB	0C2H
        DEFB	0C3H
        DEFB	0C4H
        DEFB	0C5H
        DEFB	0C6H
        DEFB	037H		; .EOF -> Input past end
        DEFB	03CH		; .FILE -> Bad allocation table
        DEFB	0C9H
        DEFB	040H		; .FOPEN -> File still open
        DEFB	041H		; .FILEX -> File already exists
        DEFB	049H		; .DIRX -> Directory already exists
        DEFB	041H		; .SYSX -> File already exists
        DEFB	038H		; .DOT -> Bad file name
        DEFB	0CFH
        DEFB	041H		; .DIRNE -> File already exists
        DEFB	048H		; .FILRO -> File write protected
        DEFB	0D2H
        DEFB	041H		; .DUPF -> File already exists
        DEFB	042H		; .DKFUL -> Disk full
        DEFB	043H		; .DRFUL -> Too many files
        DEFB	04AH		; .NODIR -> Directory not found
        DEFB	035H		; .NOFIL -> File not found
        DEFB	038H		; .PLONG -> Bad filename
        DEFB	038H		; .IPATH -> Bad filename
        DEFB	038H		; .IFNM -> Bad filename
        DEFB	03EH		; .IDRV -> Bad drivename
        DEFB	0DCH
        DEFB	0DDH
        DEFB	0DEH
        DEFB	0DFH
        DEFB	0E0H
        DEFB	0E1H
        DEFB	0E2H
        DEFB	0E3H
        DEFB	0E4H
        DEFB	0E5H
        DEFB	0E6H
        DEFB	0E7H
        DEFB	0E8H
        DEFB	0E9H
        DEFB	0EAH
        DEFB	0EBH
        DEFB	0ECH
        DEFB	0EDH
        DEFB	0EEH
        DEFB	0EFH
        DEFB	0F0H
        DEFB	0F1H
        DEFB	03CH		; .IFAT -> Bad allocation table
        DEFB	045H		; .SEEK -> Disk I/O error
        DEFB	045H		; .WFILE -> Disk I/O error
        DEFB	045H		; .WDISK -> Disk I/O error
        DEFB	045H		; .NDOS -> Disk I/O error
        DEFB	045H		; .UFORM -> Disk I/O error
        DEFB	044H		; .WPROT -> Disk write protected
        DEFB	045H		; .RNF -> Disk I/O error
        DEFB	045H		; .DATA -> Disk I/O error
        DEFB	045H		; .VERFY -> Disk I/O error
        DEFB	046H		; .NRDY -> Disk offline
        DEFB	045H		; .DISK -> Disk I/O error
        DEFB	045H		; .WRERR -> Disk I/O error
        DEFB	045H		; .NCOMP -> Disk I/O error

J65C3:  PUSH    AF
        CALL    C6343
        POP     AF
        CP      9FH
        JR      Z,J65CE
        CP      9EH
J65CE:  LD      IX,M409B
        JR      Z,C664F
        LD      E,A
J65D5:  CP      0BAH
        JR      C,J65E6
        LD      C,A
        LD      B,00H
        LD      HL,I657D-0BAH
        ADD     HL,BC
        LD      A,(HL)
        LD      E,A
        CP      3CH     ; "<"
        JR      C,J6623
J65E6:  DEFB    001H
        LD      E,03CH
        DEFB    001H
J65EA:  LD      E,03DH
        DEFB    001H
J65ED:  LD      E,03EH
        DEFB    001H
        LD      E,03FH
        DEFB    001H
        LD      E,040H
        DEFB    001H
        LD      E,041H
        DEFB    001H
        LD      E,042H
        DEFB    001H
        LD      E,043H
        DEFB    001H
        LD      E,044H
        DEFB    001H
        LD      E,045H
        DEFB    001H
        LD      E,046H
        DEFB    001H
        LD      E,047H
        DEFB    001H
        LD      E,048H
        DEFB    001H
        LD      E,049H
        DEFB    001H
        LD      E,04AH
        DEFB    001H
        LD      E,04BH
        XOR     A
        LD      (NLONLY),A
        PUSH    DE
        LD      IX,M6B24
        CALL    C664F
        POP     DE
J6623:  DEFB    001H
J6624:  LD      E,16
        DEFB    001H
J6627:  LD      E,13
        DEFB    001H
J662A:  LD      E,7
        DEFB    001H
J662D:  LD      E,5
        DEFB    001H
J6630:  LD      E,2
        DEFB    001H
J6633:  LD      E,032H
        DEFB    001H
        LD      E,034H
        DEFB    001H
        LD      E,035H
        DEFB    001H
J663C:  LD      E,036H
        DEFB    001H
        LD      E,037H
        DEFB    001H
J6642:  LD      E,038H
        DEFB    001H
J6645:  LD      E,03BH
        XOR     A
        LD      (FLBMEM),A
        LD      IX,M406F

;         Subroutine execute BASIC routine
;            Inputs  ________________________
;            Outputs ________________________

C664F:  CALL    CALBAS
        EI
        RET

;         Subroutine __________________________
;            Inputs  ________________________
;            Outputs ________________________

C6654:  CALL    C665E
        EX      (SP),HL
        CP      (HL)
        JR      NZ,J6630
        INC     HL
        EX      (SP),HL
        INC     HL
;         Subroutine __________________________
;            Inputs  ________________________
;            Outputs ________________________

C665E:  DEC     HL
;         Subroutine __________________________
;            Inputs  ________________________
;            Outputs ________________________

C665F:  LD      IX,M4666
        JR      C664F

C6665:  EI
        LD      A,3AH   ; ":"
        CP      (HL)
        JR      Z,J6642
        PUSH    HL
        PUSH    DE
        LD      A,E
        CP      40H     ; "@"
        JR      NC,J6642
        LD      C,E
        LD      B,00H
        LD      DE,(D.F33B)
        PUSH    BC
        PUSH    DE
        LDIR
        XOR     A
        LD      (DE),A
        POP     HL
        POP     BC
        CPIR
        JR      Z,J6642
        LD      C,5BH   ; "["
        CALL    C6559
        LD      A,(DE)
        CP      3AH     ; ":"
        JR      NZ,J6692
        POP     DE
        POP     HL
        RET

J6692:  BIT     2,B
        JR      NZ,J6698
        LD      C,00H
J6698:  LD      A,B
        AND     0C2H
        JR      Z,J66A7
        LD      A,(DE)
        OR      A
        JR      NZ,J6642
        POP     DE
        LD      E,A
        PUSH    DE
        PUSH    BC
        JR      J66EC

J66A7:  POP     DE
        POP     HL
        LD      IX,(D.F33B)
        BIT     2,B
        JR      Z,J66B9
        INC     HL
        INC     HL
        DEC     E
        DEC     E
        INC     IX
        INC     IX
J66B9:  PUSH    HL
        PUSH    DE
        PUSH    BC
        INC     E
        DEC     E
        JR      Z,J66EC
        LD      C,E
        LD      A,(HL)
        CP      20H     ; " "
        JP      Z,J6642
        LD      B,08H   ; 8
        CALL    C6729
        JR      Z,J66E9
        BIT     1,D
        JR      Z,J66D4
        DEC     IX
J66D4:  LD      A,2EH   ; "."
        LD      (IX),A
        INC     IX
        CP      (HL)
        JR      NZ,J66E2
        INC     HL
        DEC     C
        JR      Z,J66E9
J66E2:  LD      B,C
        CALL    C6729
        JP      NZ,J6642
J66E9:  LD      (IX),C
J66EC:  LD      A,(LF348)
        ADD     A,A
        LD      HL,12
        JR      NC,J66F7
        LD      L,12+8
J66F7:  ADD     HL,SP
        LD      (HL),8BH
        INC     HL
        LD      (HL),0F3H
        INC     HL
        INC     HL
        INC     HL
        INC     HL
        INC     HL
        LD      E,(HL)
        INC     HL
        LD      D,(HL)
        PUSH    HL
        LD      HL,I6E95
        RST     20H
        LD      BC,(D.F2F3)
        JR      Z,J671C
        LD      HL,I6EC9
        RST     20H
        LD      BC,(D.F2F1)
        JR      Z,J671C
        LD      C,E
        LD      B,D
J671C:  POP     HL
        LD      (HL),B
        DEC     HL
        LD      (HL),C
        POP     BC
        LD      A,C
        OR      A
        CALL    NZ,C5846
        POP     DE
        POP     HL
        RET

;         Subroutine __________________________
;            Inputs  ________________________
;            Outputs ________________________

C6729:  LD      D,01H   ; 1
J672B:  PUSH    HL
        PUSH    BC
        LD      E,(HL)
        LD      C,5DH   ; "]"
        CALL    C655D
        POP     BC
        POP     HL
        LD      A,E
        BIT     4,D
        JR      NZ,J6746
        LD      (IX),A
        INC     IX
        INC     HL
        DEC     C
        RET     Z
        DJNZ    J672B
        RET

J6745:  LD      A,(HL)
J6746:  CP      20H     ; " "
        RET     NZ
        INC     HL
        DEC     C
        RET     Z
        DJNZ    J6745
        RET

C674F:  EI
        LD      A,00H
        RET

C6753:  EI
        LD      A,E
        SUB     3CH     ; "<"
        RET     C
        CP      10H     ; 16
        RET     NC
        INC     A
        LD      B,A
        LD      HL,I6775
J6760:  LD      A,(HL)
        AND     A
        INC     HL
        JR      NZ,J6760
        DJNZ    J6760
        DEC     HL
        LD      DE,BUF+10
        PUSH    DE
        LD      BC,26
        LDIR
        LD      E,01H   ; 1
        POP     HL
        RET

I6775:  DEFB	0
        DEFB	"Bad FAT",0
        DEFB	"Bad file mode",0
        DEFB	"Bad drive name",0
        DEFB	"Bad sector number",0
        DEFB	"File still open",0
        DEFB	"File already exists",0
        DEFB	"Disk full",0
        DEFB	"Too many files",0
        DEFB	"Disk write protected",0
        DEFB	"Disk I/O error",0
        DEFB	"Disk offline",0
        DEFB	"Rename across disk",0
        DEFB	"File write protected",0
        DEFB	"Directory already exists",0
        DEFB	"Directory not found",0
        DEFB	"RAM disk already exists",0

;         Subroutine __________________________
;            Inputs  ________________________
;            Outputs ________________________

C6888:  EI
        PUSH    HL
        PUSH    AF
        LD      A,(LF348)
J688E:  ADD     A,A
        LD      HL,12
        JR      NC,J6896
        LD      L,12+8
J6896:  ADD     HL,SP
        LD      (HL),8BH
        INC     HL
        LD      (HL),0F3H
        POP     AF
        POP     HL
        RET

;         Subroutine __________________________
;            Inputs  ________________________
;            Outputs ________________________

C689F:  LD      HL,D.0000
;         Subroutine __________________________
;            Inputs  ________________________
;            Outputs ________________________

C68A2:  LD      A,11H   ; 17
J68A4:  RR      B
        RR      C
        DEC     A
        RET     Z
J68AA:  JR      NC,J68AD
J68AB   EQU     $-1
        ADD     HL,DE
J68AD:  RR      H
J68AF:  RR      L
        JR      J68A4

;         Subroutine __________________________
;            Inputs  ________________________
;            Outputs ________________________

C68B3:  LD      B,A
        LD      A,(LF23C)
        PUSH    AF
        PUSH    BC
        PUSH    HL
        LD      HL,(D.F349)
J68BB   EQU     $-2
        LD      (D.F34B),HL
        DI
        LD      A,(D.F314)
        CALL    LF218                   ; PUT_P0
        LD      A,(D.F315)
        CALL    LF21E                   ; PUT_P1
        LD      A,(D.F316)
        CALL    LF224                   ; PUT_P2
J68D1   EQU     $-2
        LD      A,(RAMAD3)
J68D5   EQU     $-1
        LD      H,80H
        CALL    ENASLT
J68DB:  CALL    LF1FD
        LD      HL,D.0000
J68E1:  LD      (HL),H
        INC     L
        JR      NZ,J68E1
        LD      HL,I6930
J68E7   EQU     $-1
J68E8:  LD      E,(HL)
        INC     HL
        LD      D,(HL)
        INC     HL
        LD      A,D
        OR      E
        JR      Z,J68FA
        LD      A,0C3H
        LD      (DE),A
        INC     DE
        LDI
        LDI
        JR      J68E8

J68FA:  CALL    LF227                   ; GET_P2
        EX      AF,AF'
        LD      A,(D$F2D0)
        CALL    LF224                   ; PUT_P2
        LD      HL,I$803B
        LD      DE,I$003B
        LD      BC,26
        LDIR
        EX      AF,AF'
        CALL    LF224                   ; PUT_P2
        EI
        POP     HL
        LD      DE,DBUF+1
        LD      B,0FFH
J691A:  LD      A,(HL)
        LD      (DE),A
        INC     HL
        INC     DE
        INC     B
        OR      A
        JR      NZ,J691A
        LD      A,B
        LD      (DBUF+0),A
        POP     AF
        OR      A
        CALL    NZ,C699B
        POP     AF
        CALL    C699B
        RET

I6930:  DEFW	000CH,LF1E8
        DEFW	0014H,LF1EB
        DEFW	001CH,LF1EE
        DEFW	0024H,LF1F1
        DEFW	0030H,LF1F4
        DEFW	0038H,LF1E5
        DEFW	0

;         Subroutine __________________________
;            Inputs  ________________________
;            Outputs ________________________

C694A:  LD      HL,I6A02
        LD      (D.F323),HL
        LD      HL,I6A04
        LD      (D.F325),HL
        LD      DE,(_SECBUF)
        LD      C,1AH
        CALL    C69F5
        LD      C,01H   ; 1
        LD      DE,DRVTBL
J6964:  PUSH    BC
        PUSH    DE
        LD      L,C
        DEC     L
        LD      H,01H   ; 1
        LD      DE,D.0000
        LD      C,2FH   ; "/"
        CALL    C69F5
        POP     DE
        POP     BC
        JR      NZ,J6980
        LD      HL,(_SECBUF)
        LD      A,(HL)
        OR      02H     ; 2
        CP      0EBH
        JR      Z,J698A
J6980:  LD      A,(DE)
        ADD     A,C
        LD      C,A
        INC     DE
        INC     DE
        LD      A,(DE)
        AND     A
        JR      NZ,J6964
        RET

J698A:  LD      A,C
        LD      (LF23C),A
        LD      HL,(_SECBUF)
        LD      DE,0C000H
        LD      BC,256
        LDIR
        OR      A
        RET

;         Subroutine __________________________
;            Inputs  ________________________
;            Outputs ________________________

C699B:  LD      (LF23C),A
        LD      HL,I6A02
        LD      (D.F323),HL
        LD      HL,I6A04
        LD      (D.F325),HL
        LD      B,00H
        LD      D,B
        LD      C,6AH   ; "j"
        CALL    C69F5
        LD      DE,I69E8
        XOR     A
        LD      C,43H   ; "C"
        CALL    C69F5
        JR      NZ,J69E7
        LD      DE,J.0100
        LD      HL,I$3F00
        LD      C,48H   ; "H"
        PUSH    BC
        CALL    C69F5
        POP     BC
        PUSH    AF
        LD      C,45H   ; "E"
        CALL    C69F5
        POP     AF
        JR      NZ,J69E7
        LD      A,(LF23C)
        LD      (D.F2FD),A
        LD      A,0C3H
        LD      (XF368+0),A
        LD      (XF36B+0),A
        LD      (XFER+0),A
        JP      J.0100

J69E7:  RET

I69E8:  DEFB	"\MSXDOS2.SYS"
        DEFB	0

;         Subroutine __________________________
;            Inputs  ________________________
;            Outputs ________________________

C69F5:  CALL    B.BDOS
        CP      9DH
        JR      NZ,J69FD
        LD      A,B
J69FD:  OR      A
        RET

I69FF:  LD      C,02H   ; 2
I6A01:  RET

I6A02:  DEFW	I69FF
I6A04:  DEFW	I6A01

C6A06:  LD      A,(D.F314)
        CALL    LF218                   ; PUT_P0
        LD      A,(D.F315)
        CALL    LF21E                   ; PUT_P1
        LD      A,(D.F316)
        CALL    LF224                   ; PUT_P2
        RET

I6A19:  EXX
        LD      B,A
        EXX
        LD      SP,(D.F2E8)
        LD      HL,(D.F325)
        JP      J6A3C

I6A26:  EX      AF,AF'
        LD      L,C
        LD      C,A
        LD      A,B
        DEC     A
        LD      B,L
        LD      HL,(D.F323)
        CALL    C6A37
        LD      A,03H   ; 3
        SUB     C
        EI
        RET

;         Subroutine __________________________
;            Inputs  ________________________
;            Outputs ________________________

C6A37:  PUSH    HL
        LD      HL,XF368
        EX      (SP),HL
J6A3C:  PUSH    HL
        LD      HL,LF1E2
        EX      (SP),HL
        JP      XF36B

;         Subroutine __________________________
;            Inputs  ________________________
;            Outputs ________________________

C6A44:  DI
        LD      A,01H   ; 1
        LD      (D$F2BD),A
        LD      HL,I$F2B9
        INC     (HL)
        LD      A,(D$F2B8)
        CP      (HL)
        JR      NZ,J6A6A
        LD      (HL),00H
        LD      A,(D.F2BE)
        CP      02H     ; 2
        ADC     A,0FFH
        LD      (D.F2BE),A
        LD      A,(D.F2BF)
        CP      07H     ; 7
        ADC     A,00H
        LD      (D.F2BF),A
J6A6A:  LD      HL,(D.F2BA)
        LD      A,(D.F2BC)
        LD      C,A
        RRCA
        RRCA
        RRCA
        XOR     C
        RLA
        RLA
        ADC     HL,HL
        LD      A,C
        ADC     A,A
        LD      (D.F2BC),A
        LD      (D.F2BA),HL
        RET

I6A82:  LD      IX,(D$F2E6)
J6A86:  EX      AF,AF'
        EXX
        LD      HL,I6A19
        LD      (D$F302),HL
        LD      HL,I6A26
        LD      (D$F300),HL
        LD      HL,(D.F2FE)
        OR      A
        SBC     HL,SP
        JR      C,J6AA3
        LD      BC,300
        SBC     HL,BC
        JR      C,J6AB4
J6AA3:  LD      (D.F2E8),SP
        LD      SP,(D.F2FE)
        CALL    C6AB9
        LD      SP,(D.F2E8)
        OR      A
        RET

J6AB4:  CALL    C6AB9
        OR      A
        RET

;         Subroutine __________________________
;            Inputs  ________________________
;            Outputs ________________________

C6AB9:  EXX
        PUSH    HL
        LD      A,C
        CP      71H     ; "q"
        JR      C,J6AC2
        LD      A,1CH
J6AC2:  LD      HL,I6AD2
        ADD     A,A
        ADD     A,L
        LD      L,A
        JR      NC,J6ACB
        INC     H
J6ACB:  LD      A,(HL)
        INC     HL
        LD      H,(HL)
        LD      L,A
        EX      (SP),HL
        EX      AF,AF'
        RET

I6AD2:  DEFW	C6C98,C6BB4,C6BB4,C6BB4,C6BB4,C6BB4,C6BB4,C6BB4
        DEFW	C6BB4,C6BBA,C6BCA,C6BB4,C6BB4,C6BB4,C6BB4,C6BEE
        DEFW	C6BEE,C6BEE,C6BB4,C6BEE,C6BEE,C6BEE,C6BEE,C6BEE
        DEFW	C6BB4,C6BB4,C6BB4,C6BE6,C6C98,C6C98,C6C98,C6C98
        DEFW	C6C98,C6BF1,C6BF1,C6BF1,C6BF1,C6C98,C6C12,C6C12
        DEFW	C6BF1,C6C98,C6C2D,C6C2D,C6C2D,C6C2D,C6BB4,C6C98
        DEFW	C6C98,C6C32,C6C98,C6C98,C6C98,C6C98,C6C98,C6C98
        DEFW	C6C98,C6C98,C6C98,C6C98,C6C98,C6C98,C6C98,C6C98
        DEFW	C6C44,C6C4B,C6C44,C6C6D,C6C6D,C6C98,C6C98,C6C98
        DEFW	C6C98,C6C98,C6C98,C6C98,C6C6D,C6C6D,C6C67,C6C67
        DEFW	C6C6D,C6C6D,C6C98,C6C88,C6C88,C6C98,C6C98,C6C98
        DEFW	C6C98,C6CA0,C6CE3,C6C9B,C6CC0,C6C98,C6CA0,C6C98
        DEFW	C6C98,C6C98,C6C98,C6C98,C6C98,C6C98,C6CE9,C6C98
        DEFW	C6C98,C6C98,C6C98,C6C98,C6C98,C6C98,C6C98,C6C98
        DEFW	C6C98

C6BB4:  CALL    C6C98
        LD      A,L
        LD      B,H
        RET

C6BBA:  LD      A,(DE)
        INC     DE
        CP      24H     ; "$"
        JR      Z,J6BE1
        PUSH    DE
        LD      E,A
        LD      C,02H   ; 2
        CALL    C6C98
        POP     DE
        JR      C6BBA

C6BCA:  PUSH    DE
        LD      A,(DE)
        LD      DE,(D.F2F5)
        LD      (DE),A
        CALL    C6C98
        POP     DE
        LD      A,(DE)
        INC     DE
        LD      HL,(D.F2F5)
        INC     HL
        LD      C,A
        LD      B,00H
        INC     BC
        LDIR
J6BE1:  XOR     A
        LD      B,A
        LD      L,A
        LD      H,A
        RET

C6BE6:  CALL    C6C98
        LD      A,C
        LD      BC,512
        RET

C6BEE:  LD      A,21H
        DEFB    021H
C6BF1:  LD      A,24H
        PUSH    DE
        EXX
        POP     HL
        LD      C,A
        LD      B,00H

;         Subroutine __________________________
;            Inputs  ________________________
;            Outputs ________________________

C6BF9:  PUSH    HL
        PUSH    BC
        LD      DE,(D.F2F5)
        PUSH    DE
        LDIR
        EXX
        POP     DE
        PUSH    DE
        CALL    C6C98
        EXX
        POP     HL
        POP     BC
        POP     DE
        LDIR
        EXX
        LD      A,L
        LD      B,H
        RET

C6C12:  PUSH    DE
        EXX
        POP     HL
        PUSH    HL
        LD      BC,15
        ADD     HL,BC
        LD      C,24H   ; "$"
        LD      A,(HL)
        OR      A
        JR      NZ,J6C27
        DEC     HL
        LD      A,(HL)
        CP      40H     ; "@"
        JR      NC,J6C27
        INC     C
J6C27:  POP     HL
        CALL    C6BF9
        EX      DE,HL
        RET

C6C2D:  CALL    C6C98
        LD      A,C
        RET

C6C32:  PUSH    DE
        LD      DE,(D.F2F5)
        CALL    C6C98
        EX      DE,HL
        POP     DE
        PUSH    DE
        LD      BC,32
        LDIR
        POP     DE
        RET

C6C44:  CALL    C6CFD
        CALL    C,C6D20
        RET     NZ
C6C4B:  PUSH    IX
        POP     HL
        PUSH    HL
        LD      DE,(D.F2F7)
        PUSH    BC
        LD      BC,64
        LDIR
        POP     BC
        CALL    C6C8D
        POP     DE
        LD      HL,(D.F2F7)
        LD      BC,64
        LDIR
        RET

C6C67:  CALL    C6D20
        LD      HL,(D.F2F9)
C6C6D:  EX      AF,AF'
        PUSH    DE
        CALL    C6CFD
        PUSH    AF
        EX      AF,AF'
        CALL    C6C94
        EX      AF,AF'
        EXX
        POP     AF
        POP     DE
        JR      NC,J6C85
        LD      HL,(D.F2F5)
        LD      BC,64
        LDIR
J6C85:  EX      AF,AF'
        EXX
        RET

C6C88:  EX      AF,AF'
        CALL    C6D20
        EX      AF,AF'

;         Subroutine __________________________
;            Inputs  ________________________
;            Outputs ________________________

C6C8D:  LD      IX,(D.F2F7)
        LD      HL,(D.F2F9)
;         Subroutine __________________________
;            Inputs  ________________________
;            Outputs ________________________

C6C94:  LD      DE,(D.F2F5)
;         Subroutine __________________________
;            Inputs  ________________________
;            Outputs ________________________

C6C98:  JP      J$F37A

C6C9B:  PUSH    DE
        CALL    C6D01
        POP     DE
C6CA0:  EX      DE,HL
        PUSH    HL
        LD      DE,(D.F2F5)
        OR      A
        SBC     HL,DE
        PUSH    HL
        PUSH    DE
        CALL    C6C98
        EXX
        POP     HL
        POP     BC
        POP     DE
        PUSH    BC
        LD      BC,64
        LDIR
        EXX
        EX      (SP),HL
        EX      DE,HL
        ADD     HL,DE
        EX      (SP),HL
        ADD     HL,DE
        POP     DE
        RET

C6CC0:  PUSH    HL
        PUSH    HL
        LD      L,E
        LD      H,D
        CALL    C6D01
        LD      DE,(D.F2F5)
        OR      A
        SBC     HL,DE
        EX      (SP),HL
        PUSH    HL
        CALL    C6C8D
        EXX
        POP     DE
        LD      BC,11
        LD      HL,(D.F2F9)
        LDIR
        EXX
        POP     HL
        ADD     HL,DE
        EX      DE,HL
        POP     HL
        RET

C6CE3:  CALL    C6D01
        JP      C6C94

C6CE9:  PUSH    DE
        LD      DE,(D.F2FB)
        CALL    C6C98
        EX      DE,HL
        POP     DE
        PUSH    DE
        PUSH    BC
        LD      BC,64
        LDIR
        POP     BC
        POP     DE
        RET

;         Subroutine __________________________
;            Inputs  ________________________
;            Outputs ________________________

C6CFD:  LD      A,(DE)
        INC     A
        JR      NZ,J6D11

;         Subroutine __________________________
;            Inputs  ________________________
;            Outputs ________________________

C6D01:  PUSH    HL
        PUSH    BC
        EX      DE,HL
        LD      DE,(D.F2F5)
        LD      BC,64
        LDIR
        POP     BC
        POP     HL
        SCF
        RET

J6D11:  PUSH    HL
        PUSH    BC
        EX      DE,HL
        LD      DE,(D.F2F5)
        LD      B,64H   ; "d"
        CALL    C6D2E
        POP     BC
        POP     HL
        RET

;         Subroutine __________________________
;            Inputs  ________________________
;            Outputs ________________________

C6D20:  PUSH    DE
        PUSH    BC
        LD      DE,(D.F2F9)
        LD      B,64H   ; "d"
        CALL    C6D2E
        POP     BC
        POP     DE
        RET

;         Subroutine __________________________
;            Inputs  ________________________
;            Outputs ________________________

C6D2E:  LD      A,(HL)
        INC     HL
        LD      (DE),A
        INC     DE
        OR      A
        RET     Z
        DJNZ    C6D2E
        LD      A,0D8H
        RET

;         Subroutine DSKCHG RAMDISK
;            Inputs  ________________________
;            Outputs ________________________

J6D39:  LD      HL,I.BC20
        LD      A,(D.F2CF)
        CALL    LF206                   ; RD_SEG
        CP      56H     ; "V"
        LD      B,00H
        RET     Z
        DEC     B
        RET

;         Subroutine DSKIO RAMDISK
;            Inputs  ________________________
;            Outputs ________________________

J6D49:  EI
        LD      (D.F2E3),DE
        LD      (D.F2E1),HL
        LD      A,B
        LD      (D.F2E5),A
        EX      AF,AF'
        LD      HL,I.BC20
        LD      A,(D.F2CF)
        CALL    LF206                   ; RD_SEG
        EI
        SUB     56H     ; "V"
        CALL    NZ,C6E5B
        RET     C
        LD      HL,(SLTTBL+0)
        PUSH    HL
        LD      HL,(SLTTBL+2)
        PUSH    HL
J6D6E:  LD      DE,(D.F2E3)
        CALL    C6DFF
        JR      C,J6DA6
        LD      E,A
        LD      A,(D.F2E5)
        SUB     E
        JR      NC,J6D81
        ADD     A,E
        LD      E,A
        XOR     A
J6D81:  LD      (D.F2E5),A
        OR      A
        PUSH    AF
        PUSH    HL
        LD      HL,(D.F2E3)
        LD      D,00H
        ADD     HL,DE
        LD      (D.F2E3),HL
        POP     HL
        LD      D,E
        SLA     D
        LD      E,00H
        PUSH    DE
        CALL    C6DCA
        POP     DE
        LD      HL,(D.F2E1)
        ADD     HL,DE
        LD      (D.F2E1),HL
        POP     AF
        JR      NZ,J6D6E
        XOR     A
J6DA6:  EX      AF,AF'
        DI
        POP     HL
        LD      (SLTTBL+2),HL
        POP     HL
        LD      (SLTTBL+0),HL
        LD      HL,SLTTBL+0
        XOR     A
J6DB4:  LD      C,A
        IN      A,(0A8H)
        LD      B,A
        AND     3FH     ; "?"
        OR      C
        LD      E,(HL)
        INC     HL
        CALL    C$004B
        LD      A,C
        ADD     A,40H   ; "@"
        JR      NZ,J6DB4
        EI
        EX      AF,AF'
        LD      B,00H
        RET

;         Subroutine __________________________
;            Inputs  ________________________
;            Outputs ________________________

C6DCA:  DI
        LD      A,(RAMAD3)
        CP      B
        JR      Z,J6DE4
        CALL    LF221                   ; GET_P1
        PUSH    AF
        LD      A,C
        CALL    LF21E                   ; PUT_P1
        SET     6,H
        CALL    LF1D3
        POP     AF
        CALL    LF21E                   ; PUT_P1
        EI
        RET

J6DE4:  CALL    LF21B                   ; GET_P0
        PUSH    AF
        LD      A,C
        CALL    LF218                   ; PUT_P0
        LD      B,D
        LD      C,E
        LD      DE,(D.F2E1)
        EX      AF,AF'
        JR      NC,J6DF6
        EX      DE,HL
J6DF6:  EX      AF,AF'
        LDIR
        POP     AF
        CALL    LF218                   ; PUT_P0
        EI
        RET

;         Subroutine __________________________
;            Inputs  ________________________
;            Outputs ________________________

C6DFF:  LD      A,D
        OR      E
        JR      NZ,J6E11
        LD      A,(D.F2CF)
        LD      C,A
        LD      A,(RAMAD3)
        LD      B,A
        LD      HL,I$3C00
        LD      A,01H   ; 1
        RET

J6E11:  CALL    LF227                   ; GET_P2
        PUSH    AF
        LD      A,(D.F2CF)
        CALL    LF224                   ; PUT_P2
        LD      HL,(D.BE00)
        LD      H,00H
        ADD     HL,HL
        ADD     HL,HL
        ADD     HL,HL
        ADD     HL,HL
        ADD     HL,HL
        POP     AF
        CALL    LF224                   ; PUT_P2
        SBC     HL,DE
        LD      A,0CH   ; 12
        RET     C
        LD      H,D
        LD      L,E
        DEC     HL
        ADD     HL,HL
        LD      A,L
        PUSH    AF
        ADD     HL,HL
        ADD     HL,HL
        LD      E,H
        LD      D,00H
        LD      HL,I$BE02
        ADD     HL,DE
        ADD     HL,DE
        CALL    LF227                   ; GET_P2
        PUSH    AF
        LD      A,(D.F2CF)
        CALL    LF224                   ; PUT_P2
        LD      C,(HL)
        INC     HL
        LD      B,(HL)
        POP     AF
        CALL    LF224                   ; PUT_P2
        POP     AF
        AND     3EH     ; ">"
        LD      H,A
        LD      L,00H
        LD      A,40H   ; "@"
        SUB     H
        RRCA
        OR      A
        RET

;         Subroutine __________________________
;            Inputs  ________________________
;            Outputs ________________________

C6E5B:  CALL    LF227                   ; GET_P2
        PUSH    AF
        LD      A,(D.F2CF)
        CALL    LF224                   ; PUT_P2
        LD      A,(D.BE00)
        OR      A
        JR      NZ,J6E73
        POP     AF
        CALL    LF224                   ; PUT_P2
        LD      A,0CH   ; 12
        SCF
        RET

J6E73:  EXX
        LD      HL,I$BC0B
        LD      (HL),00H
        INC     HL
        LD      (HL),02H        ; 2
        INC     HL
        LD      (HL),01H        ; 1
        CP      81H
        JR      C,J6E84
        INC     (HL)
J6E84:  INC     HL
        LD      (HL),01H        ; 1
        INC     HL
        LD      (HL),00H
        INC     HL
        LD      (HL),02H        ; 2
        INC     HL
        LD      C,A
        SRL     A
        SRL     A
        ADD     A,04H   ; 4
I6E95:  LD      E,A
        LD      D,00H
        PUSH    DE
        EX      DE,HL
        ADD     HL,HL
        ADD     HL,HL
        ADD     HL,HL
        ADD     HL,HL
        EX      DE,HL
        LD      (HL),E
        INC     HL
        LD      (HL),D
        INC     HL
        LD      E,C
        LD      D,00H
        EX      DE,HL
        ADD     HL,HL
        ADD     HL,HL
        ADD     HL,HL
        ADD     HL,HL
        ADD     HL,HL
        INC     HL
        EX      DE,HL
        LD      (HL),E
        INC     HL
        LD      (HL),D
        INC     HL
        LD      (HL),0FFH
        INC     HL
        EX      DE,HL
        LD      A,C
        DEC     HL
        POP     BC
        OR      A
        SBC     HL,BC
        CP      81H
        JR      C,J6EC4
        SRL     H
        RR      L
J6EC4:  LD      B,H
        LD      C,L
        ADD     HL,BC
        ADD     HL,BC
        EX      DE,HL
I6EC9:  DEC     DE
        SRL     D
        SRL     D
        INC     D
        LD      (HL),D
        INC     HL
        LD      (HL),00H
        INC     HL
        LD      HL,I6EE6
        LD      DE,I.BC20
        LD      BC,11
        LDIR
        EXX
        POP     AF
        CALL    LF224                   ; PUT_P2
        XOR     A
        RET

I6EE6:  DEFB	"VOL_ID"

I6EEC:  DEFB	0
        DEFB	1
        DEFB	2
        DEFB	3
        DEFB	4

;         Subroutine GETDPB RAMDISK
;            Inputs  ________________________
;            Outputs ________________________

J6EF1:  RET

;         Subroutine CHOICE RAMDISK
;            Inputs  ________________________
;            Outputs ________________________

J6EF2:  LD      HL,I6EEC
J6EF4   EQU     $-1
        RET

;         Subroutine DSKFMT RAMDISK
;            Inputs  ________________________
;            Outputs ________________________

J6EF6:  LD      A,0CH
        SCF
        RET

; DRIVER section starts here

        INCLUDE	DRIVER.ASM

        DEFS	08000H-$,0

        END
