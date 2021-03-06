; DOS1.ASM

; DOS 1.00 kernel (as used in the Philips VY-0010 diskinterface)
; version number is not offical, it is created by me
; Assume this is version Jun 20, 1984

; Source re-created by Z80DIS 2.2
; Z80DIS was written by Kenneth Gielow, Palo Alto, CA

; Code Copyrighted by ASCII and maybe others
; Source comments by Arjen Zeilemaker

; Sourcecode supplied for STUDY ONLY
; Recreation NOT permitted without authorisation of the copyrightholders



        .Z80
        ASEG
        ORG     04000H


; symbols which must be defined by the diskdriver

;       EXTRN   INIHRD
;       EXTRN   DRIVES
;       EXTRN   INIENV
;       EXTRN   DSKIO
;       EXTRN   DSKCHG
;       EXTRN   GETDPB
;       EXTRN   CHOICE
;       EXTRN   DSKFMT
;       EXTRN   OEMSTA
;       EXTRN   MYSIZE
;       EXTRN   SECLEN
;       EXTRN   DEFDPB

; symbols of routines which can be used by the diskdriver

;       PUBLIC  PROMPT
;       PUBLIC  SETINT
;       PUBLIC  PRVINT
;       PUBLIC  GETSLT
;       PUBLIC  GETWRK
;       PUBLIC  DIV16
;       PUBLIC  ENASLT
;       PUBLIC  XFER


WBOOT   equ     00000H
DBUF    equ     00080H

RDSLT   equ     0000CH
WRSLT   equ     00014H
CALSLT  equ     0001CH
ENASLT  equ     00024H
IDBYT0  equ     0002BH
CALLF   equ     00030H
M0034   equ     00034H
KEYINT  equ     00038H
LDIRMV  equ     00059H
LDIRVM  equ     0005CH
CHSNS   equ     0009CH
CHGET   equ     0009FH
CHPUT   equ     000A2H
LPTOUT  equ     000A5H
BREAKX  equ     000B7H
CKCNTC  equ     000BDH
ERAFNK  equ     000CCH
TOTEXT  equ     000D2H
SNSMAT  equ     00141H
PHYDIO  equ     00144H
KILBUF  equ     00156H
CALBAS  equ     00159H

X003B   equ     0003BH                  ; helper routine in DOS memoryspace: save and change secundairy slotregister
X0046   equ     00046H                  ; helper routine in DOS memoryspace: restore secundairy slotregister (RDSLT/WRSLT)
X004B   equ     0004BH                  ; helper routine in DOS memoryspace: restore secundairy slotregister (CALSLT/CALLF)

XF1C9   equ     0F1C9H                  ; output string (BDOS 9), also start of fixed diskvars
XF1D9   equ     0F1D9H                  ; XFER, transfer to DOS memory
XF1E2   equ     0F1E2H                  ; WBOOT, warm boot DOS system
XF1E8   equ     0F1E8H                  ; start handler in DOS memory
XF1F4   equ     0F1F4H                  ; validate FCB filename
YF1F7   equ     0F1F7H                  ; reserved devicenames
YF20B   equ     0F20BH                  ; �direntry� for devices
YF22B   equ     0F22BH                  ; days in month table
YF237   equ     0F237H                  ; BDOS console output columnpos
YF238   equ     0F238H                  ; console columnpos at start of lineinput
YF239   equ     0F239H                  ; lineinput insert flag
YF23A   equ     0F23AH                  ; lineinput secret message flag
YF23B   equ     0F23BH                  ; console output to printer flag
YF23C   equ     0F23CH                  ; directory buffer changed flag
YF23D   equ     0F23DH                  ; transferaddress
YF23F   equ     0F23FH                  ; sectornumber in data buffer
YF241   equ     0F241H                  ; driveid of sector in data buffer
YF242   equ     0F242H                  ; data buffer changed flag
YF243   equ     0F243H                  ; DPB pointer current operation
YF245   equ     0F245H                  ; sectornumber (offset) in directory buffer
YF246   equ     0F246H                  ; driveid of sector in directory buffer
YF247   equ     0F247H                  ; default driveid
YF248   equ     0F248H                  ; current day (1..31)
YF249   equ     0F249H                  ; current month (1..12)
YF24A   equ     0F24AH                  ; current year (offset to 1980)
YF24C   equ     0F24CH                  ; current days since 1-1-1980
YF24E   equ     0F24EH                  ; current day of week (0=sunday)

XF24F   equ     0F24FH                  ; prompt for disk hook
XF252   equ     0F252H                  ; get fat entry content hook
XF255   equ     0F255H                  ; check if devicename hook
XF258   equ     0F258H                  ; try next direntry hook
XF25B   equ     0F25BH                  ; get next direntry hook
XF25E   equ     0F25EH                  ; next direntry hook
XF261   equ     0F261H                  ; validate FCB drive and filename hook
XF264   equ     0F264H                  ; fcb open hook
XF267   equ     0F267H                  ; get latest FAT hook
XF26A   equ     0F26AH                  ; get pointer to DPB of current drive hook
XF26D   equ     0F26DH                  ; write FAT hook
XF270   equ     0F270H                  ; read sector hook
XF273   equ     0F273H                  ; diskerror hook
XF276   equ     0F276H                  ; write dirsector hook
XF279   equ     0F279H                  ; write sector hook
XF27C   equ     0F27CH                  ; multiply hook
XF27F   equ     0F27FH                  ; divide hook
XF282   equ     0F282H                  ; get absolute cluster hook
XF285   equ     0F285H                  ; get next absolute cluster hook
XF288   equ     0F288H                  ; partical sector read hook
XF28B   equ     0F28BH                  ; partical sector write hook
XF28E   equ     0F28EH                  ; start read recordoperation from disk hook
XF291   equ     0F291H                  ; finish read recordoperation from disk hook
XF294   equ     0F294H                  ; end read recordoperation from disk hook
XF297   equ     0F297H                  ; record operation error at start hook
XF29A   equ     0F29AH                  ; start write recordoperation to disk hook
XF29D   equ     0F29DH                  ; finish write recordoperation to disk hook
XF2A0   equ     0F2A0H                  ; calculate sequencial sectors hook
XF2A3   equ     0F2A3H                  ; get sectornumber of cluster hook
XF2A6   equ     0F2A6H                  ; allocate FAT chain hook
XF2A9   equ     0F2A9H                  ; release FAT chain hook
XF2AC   equ     0F2ACH                  ; lineinput headloop hook
XF2AF   equ     0F2AFH                  ; console output hook
XF2B2   equ     0F2B2H                  ; get time and date for direntry hook
XF2B5   equ     0F2B5H                  ; setup days in februari hook

YF2B8   equ     0F2B8H                  ; current direntry number
YF2B9   equ     0F2B9H                  ; filename1
YF2C4   equ     0F2C4H                  ; original DR byte FCB
YF2C5   equ     0F2C5H                  ; filename2 (rename)
YF2D0   equ     0F2D0H                  ; temporary save for F2B9 and F2C4 (rename)
YF2DC   equ     0F2DCH                  ; flag ignore fileattributes
YF2DD   equ     0F2DDH                  ; current relative sector in cluster
YF2DE   equ     0F2DEH                  ; result of recordoperation
YF2DF   equ     0F2DFH                  ; flag increase current relative sector in cluster (0 means not)
YF2E0   equ     0F2E0H                  ; flag flake read (0 means real read)
YF2E1   equ     0F2E1H                  ; current driveid
YF2E2   equ     0F2E2H                  ; transferaddress for recordoperation
YF2E4   equ     0F2E4H                  ; start record (32 bit) for recordoperation
YF2E8   equ     0F2E8H                  ; number of records for recordoperation
YF2EA   equ     0F2EAH                  ; current relative cluster of file
YF2EC   equ     0F2ECH                  ; current cluster of file
YF2EE   equ     0F2EEH                  ; start relative sector for recordoperation
YF2F0   equ     0F2F0H                  ; relative cluster after fileend for write recordoperation
YF2F2   equ     0F2F2H                  ; start offset in sector for recordoperation
YF2F4   equ     0F2F4H                  ; start fileposition (32 bit) for recordoperation
YF2F8   equ     0F2F8H                  ; partical sector transfer at start
YF2FA   equ     0F2FAH                  ; partical sector transfer at end
YF2FC   equ     0F2FCH                  ; number of complete sectors to transfer
YF2FE   equ     0F2FEH                  ; first free direntry (0FFH if none found)
YF2FF   equ     0F2FFH                  ; flag diskoperation (0 if read, 1 if write)
YF300   equ     0F300H                  ; pointer to remaining lineinput from CON read record operation
YF302   equ     0F302H                  ; temporary store for maximium cluster
                                        ; looks like F304-F305 are unused!
YF306   equ     0F306H                  ; flag CP/M compatible BDOS call (0 means no CP/M, HL has value, <>0 means CP/M, HL is compatible filled)
YF307   equ     0F307H                  ; saved pointer to FCB search first, used for search next
YF309   equ     0F309H                  ; saved pointer to DPB search first, used for search next
YF30B   equ     0F30BH                  ; saved current direntry number search first/next (FFh means invalid)
YF30C   equ     0F30CH                  ; original EX byte FCB
RAWFLG  equ     0F30DH                  ; read after write (verify) flag
YF30E   equ     0F30EH                  ; date format (0 japanese, 1 european, 2 american)
YF30F   equ     0F30FH                  ; double byte header char table
                                        ; looks like F313-F322 are unused
YF323   equ     0F323H                  ; diskerror handler pointer
YF325   equ     0F325H                  ; abort handler pointer
XF327   equ     0F327H                  ; AUX input hook (MSXHOOK style), default returns CTRL-Z in register A
XF32C   equ     0F32CH                  ; AUX output hook (MSXHOOK style), default does nothing
XF331   equ     0F331H                  ; BDOS hook (MSXHOOK style)
YF336   equ     0F336H                  ; flag saved input available (0 = none available)
YF337   equ     0F337H                  ; save input
YF338   equ     0F338H                  ; use clockchip flag
YF339   equ     0F339H                  ; saved stackpointer format routine
YF33B   equ     0F33BH                  ; days since 1-1-1980, used when no clockchip
YF33D   equ     0F33DH                  ; recordsize GET/PUT recordoperations
YF33F   equ     0F33FH                  ; at systeminit: CTRL key flag, later: saved driveid driveroperation (0=A:)
YF340   equ     0F340H                  ; flag kernel cold boot (0 = cold, <>0 = warm)
RAMAD0  equ     0F341H                  ; slotid DOS ram page 0
RAMAD1  equ     0F342H                  ; slotid DOS ram page 1
RAMAD2  equ     0F343H                  ; slotid DOS ram page 2
RAMAD3  equ     0F344H                  ; slotid DOS ram page 3
YF345   equ     0F345H                  ; maximum number of diskbasic FCB's
YF346   equ     0F346H                  ; flag MSXDOS has been running (0 = no MSXDOS yet)
YF347   equ     0F347H                  ; number of drives in disksystem
YF348   equ     0F348H                  ; slotid disksytem rom
YF349   equ     0F349H                  ; disksystem bottom (lowest address used by the disksystem)
YF34B   equ     0F34BH                  ; msxdos system bottom
_SECBUF equ     0F34DH                  ; pointer to sectorbuffer, can be used by the diskdriver
YF34F   equ     0F34FH                  ; pointer to datasectorbuffer
YF351   equ     0F351H                  ; pointer to directorysectorbuffer
YF353   equ     0F353H                  ; pointer to the diskbasic FCB's
YF355   equ     0F355H                  ; DPB table for 8 drives
XF365   equ     0F365H                  ; routine read primary slotregister
XF368   equ     0F368H                  ; routine enable disksystem rom on page 1
XF36B   equ     0F36BH                  ; routine enable dos ram on page 1
XFER    equ     0F36EH                  ; routine transfer to/from dos ram
XF371   equ     0F371H                  ; auxiliary input routine
XF374   equ     0F374H                  ; auxiliary output routine
XF377   equ     0F377H                  ; routine diskbasic BLOAD
XF37A   equ     0F37AH                  ; routine diskbasic BSAVE
XF37D   equ     0F37DH                  ; BDOS entry point

RDPRIM  equ     0F380H
WRPRIM  equ     0F385H
CLPRIM  equ     0F38CH
CLPRM1  equ     0F398H
LINLEN  equ     0F3B0H
CNSDFG  equ     0F3DEH
LPTPOS  equ     0F415H
PRTFLG  equ     0F416H
CURLIN  equ     0F41CH
KBUF    equ     0F41FH
BUF     equ     0F55EH
TTYPOS  equ     0F661H
VALTYP  equ     0F663H
MEMSIZ  equ     0F672H
STKTOP  equ     0F674H
TXTTAB  equ     0F676H
TEMPPT  equ     0F678H
TEMPST  equ     0F67AH
DSCTMP  equ     0F698H
FRETOP  equ     0F69BH
AUTLIN  equ     0F6ABH
SAVSTK  equ     0F6B1H
VARTAB  equ     0F6C2H
STREND  equ     0F6C6H
DAC     equ     0F7F6H
ARG     equ     0F847H
MAXFIL  equ     0F85FH
FILTAB  equ     0F860H
NULBUF  equ     0F862H
PTRFIL  equ     0F864H
FILNAM  equ     0F866H
NLONLY  equ     0F87CH
SAVEND  equ     0F87DH
HOKVLD  equ     0FB20H
YFB21   equ     0FB21H                  ; diskdriver table
YFB29   equ     0FB29H                  ; diskdriver interrupt table
BOTTOM  equ     0FC48H
HIMEM   equ     0FC4AH
FLBMEM  equ     0FCAEH
RUNBNF  equ     0FCBEH
SAVENT  equ     0FCBFH
EXPTBL  equ     0FCC1H
SLTTBL  equ     0FCC5H
SLTATR  equ     0FCC9H
SLTWRK  equ     0FD09H
PROCNM  equ     0FD89H
DEVICE  equ     0FD99H

H.TIMI  equ     0FD9FH
H.DSKO  equ     0FDEFH
H.NAME  equ     0FDF9H
H.KILL  equ     0FDFEH
H.COPY  equ     0FE08H
H.DSKF  equ     0FE12H
H.DSKI  equ     0FE17H
H.LSET  equ     0FE21H
H.RSET  equ     0FE26H
H.FIEL  equ     0FE2BH
H.MKI$  equ     0FE30H
H.MKS   equ     0FE35H
H.MKD   equ     0FE3AH
H.CVI   equ     0FE3FH
H.CVS   equ     0FE44H
H.CVD   equ     0FE49H
H.GETP  equ     0FE4EH
H.NOFO  equ     0FE58H
H.NULO  equ     0FE5DH
H.NTFL  equ     0FE62H
H.BINS  equ     0FE71H
H.BINL  equ     0FE76H
H.FILE  equ     0FE7BH
H.DGET  equ     0FE80H
H.FILO  equ     0FE85H
H.INDS  equ     0FE8AH
H.LOC   equ     0FE99H
H.LOF   equ     0FE9EH
H.EOF   equ     0FEA3H
H.BAKU  equ     0FEADH
H.PARD  equ     0FEB2H
H.NODE  equ     0FEB7H
H.POSD  equ     0FEBCH
H.RUNC  equ     0FECBH
H.CLEA  equ     0FED0H
H.LOPD  equ     0FED5H
H.STKE  equ     0FEDAH
H.ERRP  equ     0FEFDH
H.PHYD  equ     0FFA7H
H.FORM  equ     0FFACH
EXTBIO  equ     0FFCAH
DISINT  equ     0FFCFH
ENAINT  equ     0FFD4H

YFFFF   equ     0FFFFH


YC000   equ     0C000H          ; bootsector transferaddress
YCONBF  equ     KBUF+186        ; KBUF is reused for read CON device records, size 127+2
YCONTP  equ     KBUF+58         ; KBUF is reused for temporary buffer buffered input, size 128


; Basic routines

M268C   equ     0268CH          ; dbl subtract
M269A   equ     0269AH          ; dbl add
M289F   equ     0289FH          ; dbl divide
M2EF3   equ     02EF3H          ; copy variable content
M2F08   equ     02F08H          ; copy variable content to DAC
M2F10   equ     02F10H          ; copy variable content from DAC
M2F99   equ     02F99H          ; integer to DAC
M3042   equ     03042H          ; convert DAC from sgn to dbl
M30D1   equ     030D1H          ; dbl to integer
M325C   equ     0325CH          ; sgn multiply
M3FD6   equ     03FD6H          ; empty string
M4055   equ     04055H          ; syntax error
M406D   equ     0406DH          ; type mismatch error
M406F   equ     0406FH          ; BASIC error
M409B   equ     0409BH          ; restart BASIC
M4173   equ     04173H          ; execute statement
M4253   equ     04253H          ; recalculate linepointers
M4601   equ     04601H          ; execution loop
M4666   equ     04666H          ; CHRGTR
M46FF   equ     046FFH          ; convert to SNG
M4756   equ     04756H          ; evaluate word operand and check for 0-32767 range
M475A   equ     0475AH          ; illegal function call error
M4AFF   equ     04AFFH          ; output back to screen
M4C5F   equ     04C5FH          ; evaluate =expression
M4C64   equ     04C64H          ; evaluate expression
M517A   equ     0517AH          ; convert DAC to other type
M521B   equ     0521BH          ; evaluate next byte operand
M521C   equ     0521CH          ; evaluate byte operand
M521F   equ     0521FH          ; convert to byte
M542F   equ     0542FH          ; evaluate address operand
M5432   equ     05432H          ; convert address to integer
M54F7   equ     054F7H          ; convert pointers to linenumbers
M5597   equ     05597H          ; GETYPR
M5EA4   equ     05EA4H          ; get address of variable
M6275   equ     06275H          ; out of memory error
M6627   equ     06627H          ; allocate temp string
M6671   equ     06671H          ; string formula too complex error
M668E   equ     0668EH          ; allocate stringspace
M67D0   equ     067D0H          ; free temporary string
M6825   equ     06825H          ; push temporary descriptor to temporary desciptor heap and quit
M6A0E   equ     06A0EH          ; evaluate filespecification
M6A6D   equ     06A6DH          ; get i/o channel pointer
M6AFA   equ     06AFAH          ; open i/o channel
M6B24   equ     06B24H          ; close i/o channel
M6C1C   equ     06C1CH          ; close all i/o channels
M6E41   equ     06E41H          ; resume character putback routine
M6E6B   equ     06E6BH          ; bad filename error
M6E6E   equ     06E6EH          ; file already open error
M6E74   equ     06E74H          ; file not found error
M6E77   equ     06E77H          ; file not open error
M6E7A   equ     06E7AH          ; field overflow error
M6E7D   equ     06E7DH          ; bad filenumber error
M6E83   equ     06E83H          ; input past end error
M6E92   equ     06E92H          ; start of BSAVE routine
M6EC6   equ     06EC6H          ; start of BLOAD routine
M6EF4   equ     06EF4H          ; finish BLOAD
M6F0B   equ     06F0BH          ; evaluate address operand (BLOAD/SAVE)
M6F1D   equ     06F1DH          ; skip strong cassette devicecheck
M7323   equ     07323H          ; newline to OUTDO if not at start of line
M7328   equ     07328H          ; newline to OUTDO
M739A   equ     0739AH          ; quit loading & start (headloop/executing)
M7D17   equ     07D17H          ; continue start of MSX-BASIC without executing BASIC programs in ROM
M7D2F   equ     07D2FH          ; address initialize BASIC screen
M7D31   equ     07D31H          ; BASIC initscreen (without INITXT & CNSDFG)
M7E14   equ     07E14H          ; start MSX-BASIC program in ROM

RETRTN  equ     WRPRIM+6        ; address with a RET instruction, allways available


; FCB structure

; off   name    cp/m function           msx function

; +0    DR      drive                   drive
; +1,8  F1-F8   filename                filename
; +9,3  T1-T3   filetype                filetype
; +12   EX      extent                  extent
; +13   S1      reserved                fileattribute
; +14   S2      reserved                extent high byte / recordsize low byte (block)
; +15   RC      record count in extent  record count in extent / recordsize high byte (block)
; +16   AL      allocation              Filesize
; +20   AL      allocation              Date
; +22   AL      allocation              Time
; +24   AL      allocation              Devicecode
; +25   AL      allocation              Directoryentry Number
; +26   AL      allocation              Start Cluster
; +28   AL      allocation              Current Cluster
; +30   AL      allocation              Current Relative Cluster
; +32   CR      record in extent        record in extent
; +33,3 R0-R2   random access record    random access record
; +36   R3      not used                random access record when recordsize <64



        defb    "AB"
        defw    A576F
        defw    A6576
        defw    0
        defw    0
        defs    6,0

; diskdriver entries

T4010:  jp      DSKIO                   ; DSKIO entrypoint
T4013:  jp      DSKCHG                  ; DSKCHG entrypoint
T4016:  jp      GETDPB                  ; GETDPB entrypoint
T4019:  jp      CHOICE                  ; CHOICE entrypoint
T401C:  jp      DSKFMT                  ; DSKFMT entrypoint
T401F:  nop                             ; MTOFF entrypoint is not supported
        nop
        nop

; kernel entries

A4022:  jp      J5B35                   ; start DiskBasic entrypoint

A4025:  scf                             ; format disk entrypoint (workarea must be supplied)
        jp      C60AC

A4029:  ret                             ; stop all disks entry point is not implemented
        nop
        nop
        nop

GETSLT:
A402D:  jp      C5FAE                   ; get slotid entrypoint

;       Subroutine      get MSX-DOS system bottom
;       Inputs          -
;       Outputs         HL = lowest address used by the base MSX-DOS system

A4030:  ld      hl,(YF34B)
        ret

;       Subroutine      check if keyboardinput available
;       Inputs          -
;       Outputs         Zx set if no input, Zx reset if input, A = input

A4034:  push    ix
        ld      ix,BREAKX
        call    A40AB                   ; BREAKX BIOS call
        pop     ix                      ; CTRL-STOP pressed ?
        jr      nc,A404B                ; nope,
        ld      a,003H
        ld      (YF336),a               ; saved input available
        ld      (YF337),a               ; CTRL-C
        and     a                       ; flag NZ
        ret

A404B:  ld      a,(YF336)
        and     a                       ; saved input available ?
        ld      a,(YF337)
        ret     nz                      ; yep, return it (flag NZ)
        push    ix
        ld      ix,CHSNS
        call    A40AB                   ; CHSNS BIOS call
        pop     ix                      ; any chars in the keyboard buffer ?
        ret     z                       ; nope, quit (flag Z)
        ld      a,0FFH
        ld      (YF336),a               ; flag saved input available
        push    ix
        ld      ix,CHGET
        call    A40AB                   ; CHGET BIOS call
        pop     ix                      ; get char from keyboard buffer
        ld      (YF337),a               ; save char
        push    bc
        ld      b,000H
        inc     b
        pop     bc                      ; flag NZ
        ret

;       Subroutine      get keyboardinput
;       Inputs          -
;       Outputs         A = input

A4078:  push    hl
        ld      hl,YF336
        xor     a
        cp      (hl)                    ; saved input available ?
        ld      (hl),a                  ; not anymore!
        inc     hl
        ld      a,(hl)
        pop     hl
        ret     nz                      ; yep, return it
        push    ix
        ld      ix,CHGET
        call    A40AB                   ; CHGET BIOS call
        pop     ix                      ; get char
        ret

;       Subroutine      output to screen
;       Inputs          A = output
;       Outputs         -

A408F:  push    ix
        ld      ix,CHPUT
        call    A40AB                   ; CHPUT BIOS call
        pop     ix
        ret

;       Subroutine      output to printer
;       Inputs          A = output
;       Outputs         -

A409B:  push    ix
        ld      ix,LPTOUT
        call    A40AB                   ; LPTOUT BIOS call
        pop     ix
        ret

;       Subroutine      BDOS 00 (system reset)
;       Inputs
;       Outputs         ________________________


A40A7:  ld      ix,M409B                ; restart BASIC

;       Subroutine      MSX-BIOS call
;       Inputs          IX = bios call, others depends on the bios call
;       Outputs         depends on the bios call

A40AB:  push    iy
        ld      iy,(EXPTBL-1+0)
        call    CALSLT
        pop     iy
        ret

C40B7:  LD      A,0DH
        OUT     (0B4H),A
        LD      A,0AH
        OUT     (0B5H),A                ; alarm off, clock running, bank 2
        XOR     A
        OUT     (0B4H),A                ; pos 0
        LD      B,0FH
J40C4:  IN      A,(0B5H)                ; read data
        AND     0FH
        XOR     B
        OUT     (0B5H),A                ; change it and write back
        LD      C,A
        EX      (SP),HL
        EX      (SP),HL                 ; wait
        IN      A,(0B5H)
        AND     0FH
        CP      C                       ; correctly readback ?
        RET     NZ                      ; nope, no clockchip!
        XOR     B
        OUT     (0B5H),A                ; restore orginal data
        DJNZ    J40C4                   ; try all values
        ld      a,0FFH
        ld      (YF338),a               ; flag use clockchip
        ld      a,13
        out     (0B4H),a
        ld      a,009H
        out     (0B5H),a                ; alarm off, clock running, bank 1
        ld      a,10
        out     (0B4H),a                ; pos 10
        ld      a,1
        out     (0B5H),a                ; 24 hour system
        ld      a,13
        out     (0B4H),a
        xor     a
        out     (0B5H),a                ; alarm off, clock paused, bank 0
        ld      bc,00D00H
A40F8:  ld      a,c
        out     (0B4H),a
        in      a,(0B5H)
        push    af
        inc     c
        djnz    A40F8                   ; save time registers
        ld      a,14
        out     (0B4H),a
        xor     a
        out     (0B5H),a                ; clear testbits
        ld      b,00DH
A410A:  dec     c
        ld      a,c
        out     (0B4H),a
        pop     af
        out     (0B5H),a
        djnz    A410A                   ; restore time registers
        jr      A414E                   ; put clock in running mode

;       Subroutine      store date
;       Inputs
;       Outputs         -

A4115:  ld      (YF33B),hl
        ld      a,(YF338)
        and     a                       ; use clockchip ?
        ret     z                       ; no, quit
        ld      a,(YF24A)
        ld      b,a
        ld      a,(YF249)
        ld      c,a
        ld      a,(YF248)
        ld      d,a                     ; current day
        ld      e,007H                  ; nibble 7 (date)
        call    A4159                   ; pause clock, select bank 0
        jr      A4142

;       Subroutine      store time
;       Inputs
;       Outputs         -

A4130:  ld      a,(YF338)
        and     a                       ; use clockchip ?
        ret     z                       ; no, quit
        ld      e,000H                  ; nibble 0 (time)
        call    A4159                   ; pause clock, select bank 0
        ld      a,00FH
        out     (0B4H),a
        ld      a,002H
        out     (0B5H),a                ; time reset
A4142:  ld      h,d
        call    A4160                   ; write clockchip byte
        ld      h,c
        call    A4160                   ; write clockchip byte
        ld      h,b
        call    A4160                   ; write clockchip byte

;       Subroutine      put clockchip in running mode
;       Inputs          -
;       Outputs         -

A414E:  ld      a,13
        out     (0B4H),a
        in      a,(0B5H)
        or      008H
A4156:  out     (0B5H),a
        ret

;       Subroutine      pause clockchip and select bank 0
;       Inputs          -
;       Outputs         -

A4159:  call    A414E                   ; clock in running mode
        and     004H
        jr      A4156                   ; clock paused, select bank 0

;       Subroutine      write byte to clockchip
;       Inputs          H = data, E = nibblenumber
;       Outputs         E = updated nibblenumber (+2)

A4160:  xor     a
        ld      l,8
A4163:  rlc     h
        adc     a,a
        daa
        dec     l
        jr      nz,A4163                ; convert to BCD
        call    A4171
        rrca
        rrca
        rrca
        rrca
A4171:  push    af
        ld      a,e
        inc     e
        out     (0B4H),a
        pop     af
        jr      A4156

;       Subroutine      get date and time
;       Inputs
;       Outputs         Cx set if from clockchip,

A4179:  ld      a,(YF338)
        and     a                       ; use clockchip ?
        ld      b,a
        ld      c,a
        ld      d,a
        ld      e,a                     ; 00:00:00
        ld      hl,(YF33B)              ; days since 1-1-1980
        ret     z                       ; no clockchip, quit
        call    A4159                   ; clock paused, select bank 0
        ld      e,12+1
        call    A41AD                   ; read byte from clockchip
        call    A5523                   ; setup days in februari
        call    A41AD                   ; read byte from clockchip
        ld      (YF249),a               ; current month
        call    A41AD                   ; read byte from clockchip
        ld      (YF248),a               ; current day
        dec     e                       ; nibble 5
        call    A41AD                   ; read byte from clockchip
        ld      b,a
        call    A41AD                   ; read byte from clockchip
        ld      c,a
        call    A41AD                   ; read byte from clockchip
        call    A414E                   ; clock in running mode
        scf
        ret

;       Subroutine      read byte from clockchip
;       Inputs          E = nibblenumber+1
;       Outputs         E = updated nibblenumber (-2), A = data

A41AD:  xor     a
        call    A41B5
        add     a,a
        add     a,a
        add     a,d
        add     a,a
A41B5:  ld      d,a
        dec     e
        ld      a,e
        out     (0B4H),a
        in      a,(0B5H)
        and     00FH
        add     a,d
        ld      d,a
        ret

; Identification string (not used)

?41C1:  defb    " MSX-DOS ver. 2.2 Copyright 1984 by Microsoft "

;       Subroutine      BDOS 0C (return version number)
;       Inputs
;       Outputs         ________________________


A41EF:  ld      b,000H                  ; machinetype 8080, plain CP/M
        ld      a,022H                  ; CP/M version 2.2
        ret

;       Subroutine      get FAT entry content
;       Inputs          HL = clusternumber, IX = pointer to DPB
;       Outputs         HL = clusterentry content, Zx set if entry is free, DE = pointer to FAT buffer

A41F4:  ld      e,(ix+19)
        ld      d,(ix+20)               ; pointer to FAT buffer of drive
A41FA:  call    XF252
        push    de
        ld      e,l
        ld      d,h
        srl     h
        rr      l
        rra
        add     hl,de
        pop     de
        add     hl,de
        rla
        ld      a,(hl)
        inc     hl
        ld      h,(hl)
        jr      nc,A421A
        srl     h
        rra
        srl     h
        rra
        srl     h
        rra
        srl     h
        rra
A421A:  ld      l,a
        ld      a,h
        and     00FH
        ld      h,a
        or      l
        ret

;       Subroutine      set FAT entry content
;       Inputs          HL = clusternumber, DE = pointer to FAT buffer, BC = clusterentry content
;       Outputs         -

A4221:  push    de
        ld      e,l
        ld      d,h
        srl     h
        rr      l
        rra
        add     hl,de
        pop     de
        add     hl,de
        rla
        jr      nc,A4247
        sla     c
        rl      b
        sla     c
        rl      b
        sla     c
        rl      b
        sla     c
        rl      b
        ld      a,(hl)
        and     00FH
        or      c
        ld      (hl),a
        inc     hl
        ld      (hl),b
        ret

A4247:  ld      (hl),c
        inc     hl
        ld      a,(hl)
        and     0F0H
        or      b
        ld      (hl),a
        ret

;       Subroutine      compare with filename1
;       Inputs          HL = pointer to buffer, B = size
;       Outputs         Zx set if equal

A424F:  ld      de,YF2B9

;       Subroutine      compare
;       Inputs          DE = pointer to buffer1, HL = pointer to buffer2, B = size
;       Outputs         Zx set if equal

A4252:  ld      a,(de)
        cp      (hl)
        inc     hl
        inc     de
        ret     nz
        djnz    A4252
        ret

;       Subroutine      check if devicename
;       Inputs
;       Outputs         ________________________

A425A:  call    XF255
        ld      hl,YF1F7                ; table with devicenames
        ld      c,5                     ; 5 devices
A4262:  ld      b,4                     ; only check 4 bytes (because devicenames are only 4 chars long)
        call    A424F                   ; compare with filename1
        jr      nz,A4298                ; not this device, try the next
        ld      b,4
A426B:  ld      a,(de)
        inc     de
        cp      " "
        jr      nz,A42A3                ; last 4 bytes of filename not spaces, not a device
        djnz    A426B
        ld      a,c
        neg
        ld      (YF20B+11),a            ; devicecode
        ld      hl,YF2B9
        ld      de,YF20B
        ld      bc,4
        ldir                            ; copy of devicename
        call    A5496                   ; get time and date (dirformat)
        ld      (YF20B+24),bc
        ld      (YF20B+22),de
        ld      hl,YF20B
        push    hl
        pop     iy
        or      001H                    ; Cx reset, Zx reset
        ret

A4298:  dec     b
        ld      a,l
        add     a,b
        ld      l,a
        ld      a,h
        adc     a,000H
        ld      h,a
        dec     c
        jr      nz,A4262
                                        ; Zx set
A42A3:  scf
        ret

;       Subroutine      validate FCB, clear S2 and find direntry
;       Inputs
;       Outputs         ________________________


A42A5:  push    de
        ld      hl,14
        add     hl,de
        ld      (hl),0                  ; FCB S2 (extent high byte)
        call    A42B1                   ; validate FCB drive and filename and find direntry
        pop     de
        ret

A42B1:  call    A440E                   ; validate FCB drive and filename
        ret     c                       ; invalid, quit

;       Subroutine      find first directoryentry
;       Inputs
;       Outputs         ________________________


A42B5:  call    A425A                   ; check if devicename
        ret     nc                      ; yep, quit with pointer to fake device direntry
        call    A44D3                   ; reset direntry search and get latest FAT

;       Subroutine      find next directoryentry
;       Inputs
;       Outputs         ________________________

A42BC:  call    XF258
        call    A430E                   ; get next direntry
        ret     c                       ; no more, quit
A42C3:  ld      a,(hl)
        or      a
        jr      z,A42FC                 ; unused entry,
        cp      0E5H
        jr      z,A42FC                 ; deleted entry,
        push    hl
        ld      b,11
        ld      de,YF2B9
A42D1:  call    A4252                   ; compare with fcb filename
        jr      z,A42DC                 ; equal, found!
        cp      "?"
        jr      nz,A42F5                ; on difference no wildcard, try next
        djnz    A42D1                   ; wildcard pos ignored, check rest
A42DC:  pop     hl
        push    hl
        pop     iy
        ld      a,(YF2C4)
        xor     080H
        bit     7,a
        ret     z                       ; orginal FCB DR byte had b7 set, ignore direntryattribute
        ld      a,(iy+11)
        and     01EH
        ret     z                       ; files with archive or read-only bit set are ok, quit
        ld      a,(YF2DC)
        or      a                       ; include special fileattribute flag set ?
        ret     nz                      ; yep, every direntry is ok, quit
        jr      A42F6

A42F5:  pop     hl
A42F6:  call    A4348                   ; get next direntry (while searching)
        jr      nc,A42C3                ; ok, check it
        ret

A42FC:  ld      a,(YF2FE)
        inc     a                       ; already found a free direntry ?
        jr      nz,A4308
        ld      a,(YF2B8)
        ld      (YF2FE),a               ; nope, register it
A4308:  ld      a,(hl)
        or      a                       ; unused direntry ?
        jr      nz,A42F6                ; nope, the search goes on!
        scf
        ret

;       Subroutine      get next direntry (at start of search)
;       Inputs
;       Outputs         ________________________

A430E:  ld      a,(YF2B8)
        inc     a
        cp      (ix+11)                 ; last direntry ?
        jr      nc,A4367                ; yep, update directory of disk when needed and quit

;       Subroutine      get direntry
;       Inputs
;       Outputs         ________________________

A4317:  call    XF25B
        ld      (YF2B8),a
        ld      c,a
        and     (ix+4)                  ; dirmask
        ld      l,a
        ld      h,0
        add     hl,hl
        add     hl,hl
        add     hl,hl
        add     hl,hl
        add     hl,hl
        ld      de,(YF351)              ; dirsector buffer
        add     hl,de
        ld      b,(ix+5)                ; dirshift
A4331:  srl     c
        djnz    A4331
        ld      a,(YF245)
        cp      c                       ; same as dirsector currently in buffer ?
        jr      nz,A4342                ; nope, go get it
        ld      a,(YF246)
        cp      (ix+0)                  ; same driveid as dirsector buffer owner ?
        ret     z                       ; yep, do nothing
A4342:  push    hl
        call    A46A4                   ; read dirsector
        pop     hl
        ret

;       Subroutine      get next direntry (while searching)
;       Inputs
;       Outputs         ________________________

A4348:  call    XF25E
        ld      a,(YF2B8)
        inc     a
        cp      (ix+11)                 ; last direntry ?
        jr      nc,A4367                ; yep, update directory of disk when needed and quit
        ld      (YF2B8),a
        ld      de,00020H
        add     hl,de
        and     (ix+4)                  ; dirmask
        ret     nz
        inc     c
        call    A46A4                   ; read dirsector
        ld      hl,(YF351)              ; dirsector buffer
        ret

;       Subroutine      at end of directory
;       Inputs
;       Outputs         ________________________

A4367:  call    A4743                   ; flush directory buffer
        scf
        ret

;       Subroutine      BDOS 13 (delete file)
;       Inputs
;       Outputs         ________________________

A436C:  call    A440E                   ; validate FCB drive and filename
        call    nc,A42B5                ; valid, find first directoryentry
        ld      a,0FFH
        ret     c                       ; invalid or not found, quit with error
        ret     nz                      ; device, quit with error
A4376:  ld      a,0E5H
        ld      (YF23C),a               ; flag directory buffer changed
        ld      (hl),a                  ; deleted direntry
        ld      l,(iy+26)
        ld      h,(iy+27)
        ld      a,h                     ; file has start cluster ?
        or      l
        call    nz,A4F9B                ; yep, release cluster chain
        call    A42BC                   ; find next directoryentry
        jr      nc,A4376                ; found, delete next file
        call    A4403                   ; update directory of disk (SHOULD BE: CALL A4748)
        jp      A45CF                   ; write FAT buffer (SHOULD BE: JP A45C4, flush FAT buffer)

;       Subroutine      BDOS 17 (rename file)
;       Inputs
;       Outputs         ________________________

A4392:  call    A440E                   ; validate FCB drive and filename
        jr      c,A440B                 ; invalid, quit with error
        ld      de,00005H
        add     hl,de                   ; to new filename
        ld      de,YF2C5                ; new filenamebuffer
        call    XF1F4                   ; validate FCB filename (new filename)
        call    nc,A42B5                ; new filename valid, find first directoryentry
        jr      c,A440B                 ; invalid or not found, quit with error
        jr      nz,A440B
        ld      hl,YF2B9
        ld      de,YF2D0
        ld      bc,11+1
        ldir                            ; save filename (search specifier) + orginal DR byte
A43B3:  ld      hl,YF2C5                ; new filename
        ld      de,YF2B9
        ld      b,11
A43BB:  ld      a,(hl)
        cp      "?"                     ; wildcard char ?
        jr      nz,A43C3                ; nope, use the char of the new filename
        ld      a,(iy+0)                ; yep, use the char of the orginal filename
A43C3:  ld      (de),a
        inc     hl
        inc     de
        inc     iy
        djnz    A43BB
        ld      a,080H
        ld      (de),a                  ; �orginal DR byte� b7 set (ignore fileattribute)
        call    A425A                   ; check if devicename
        jr      nc,A4408                ; yep, end rename with error
        ld      a,(YF2B8)
        push    af
        ld      a,0FFH
        ld      (YF2B8),a               ; flag direntry search start at the begin
        call    A42BC                   ; find next directoryentry
        pop     bc
        jr      nc,A4408                ; found, so resulting filename does already exist. end rename with error
        ld      a,b
        call    A4317                   ; get direntry which get renamed
        ex      de,hl
        ld      hl,YF2B9
        ld      bc,11
        ldir                            ; replace filename with new one
        ld      a,0FFH
        ld      (YF23C),a               ; flag directory buffer changed
        ld      hl,YF2D0
        ld      de,YF2B9
        ld      bc,11+1
        ldir                            ; restore filename (search specifier) + orginal DR byte
        call    A42BC                   ; find next directoryentry
        jr      nc,A43B3                ; found, rename next file
A4403:  call    A4743                   ; flush directory buffer
        xor     a                       ; no error
        ret

A4408:  call    A4743                   ; flush directory buffer
A440B:  ld      a,0FFH                  ; error
        ret

;       Subroutine      validate FCB drive and filename
;       Inputs
;       Outputs         ________________________

A440E:  call    XF261
        xor     a
        ld      (YF2DC),a               ; do not include special fileattributes
        ex      de,hl
        ld      a,(hl)
        inc     hl
        ld      (YF2C4),a               ; save FCB DR byte
        and     00FH                    ; only use b3-b0 for drive
        call    A4427                   ; validate fcb driveid
        ret     c
        ld      de,YF2B9
        jp      XF1F4                   ; validate FCB filename

;       Subroutine      Validate driveid (FCB style)
;       Inputs          A = driveid
;       Outputs         ________________________

A4427:  ld      c,a
        ld      a,(YF347)
        cp      c
        ret     c
        ld      a,c
        dec     a
        jp      p,A4435
        ld      a,(YF247)               ; default driveid
A4435:  ld      (YF2E1),a               ; set current driveid
        ret

;       Subroutine      get max record and extent
;       Inputs
;       Outputs         ________________________

A4439:  ld      a,(iy+31)
        or      a
        jr      nz,A445E                ; filesize > 16777215, use max value
        ld      a,(iy+28)
        ld      c,(iy+29)
        ld      b,(iy+30)
        add     a,a
        rl      c
        rl      b                       ; number of records (128 bytes)
        jr      c,A445E                 ; >65535, use max value
        or      a                       ; is filesize a multiply of 128 ?
        jr      z,A4457
        inc     bc                      ; nope, increase the recordnumber
        ld      a,b
        or      c                       ; does that fit ?
        jr      z,A445E                 ; nope, use max value
A4457:  ld      a,c
        res     7,c                     ; c = max recordnumber (0-127)
        add     a,a
        rl      b                       ; b = max extent
        ret     nc                      ; does fit, quit
A445E:  ld      bc,0FF7FH               ; extent 255, record 127
        ret

;       Subroutine      BDOS 0F (open file)
;       Inputs
;       Outputs         ________________________

A4462:  call    A42A5                   ; validate FCB, clear S2 and find direntry
        jr      c,A440B                 ; error, quit with error
        call    A4439                   ; get max record and extent
        ld      a,(YF30C)               ; original FCB EX byte
        inc     b                       ; ?? correct for large files (filesize > 4177919 where extend is 0FFH)
        cp      b                       ; is extent of file big enough ?
        jr      nc,A440B                ; nope, quit with error
A4471:  call    XF264
        ex      de,hl
        ld      bc,0000FH
        add     hl,bc
        call    A4439                   ; get max record and extent
        ld      a,(YF30C)
        cp      b                       ; orginal FCB EX byte same as max extent ?
        jr      z,A4488                 ; same, use RC=max recordnumber (means extent is not full)
        ld      c,080H
        jr      c,A4488                 ; smaller, use RC=128 (means extend is full)
        ld      c,000H                  ; bigger, use RC=0 (means extend is empty)
A4488:  ld      (hl),c                  ; RC
        inc     hl
        ex      de,hl
        ld      bc,0001CH
        add     hl,bc
        ld      c,004H
        ldir                            ; copy filesize
        ld      bc,0FFF8H
        add     hl,bc
        ldi
        ldi                             ; creation date
        ld      c,0FCH
        add     hl,bc
        ldi
        ldi                             ; creation time
        ld      a,(iy+11)
        bit     7,a
        jr      nz,A44AE                ; device,
        ld      a,(ix+0)                ; driveid
        or      040H                    ; flag diskfile unchanged
A44AE:  ld      (de),a                  ; devicecode
        inc     de
        ld      a,(YF2B8)
        ld      (de),a                  ; direntry number
        inc     de
        ld      a,(iy+26)
        ld      (de),a
        inc     de
        inc     de
        ld      (de),a
        dec     de
        ld      a,(iy+27)
        ld      (de),a
        inc     de
        inc     de
        ld      (de),a                  ; start cluster and last cluster accessed
        inc     de
        xor     a
        ld      (de),a
        inc     de
        ld      (de),a                  ; last cluster accessed, relative
        ret

;       Subroutine      handle DSKCHG error
;       Inputs
;       Outputs         ________________________

A44CA:  ld      c,a
        ld      a,(YF2E1)               ; current driveid
        call    A470A                   ; start diskerror handler
        jr      A44DB                   ; get latest FAT (try again)

;       Subroutine      reset direntry search and get latest FAT
;       Inputs
;       Outputs         ________________________

A44D3:  ld      a,0FFH
        ld      (YF2B8),a               ; invalid latest direntry (search from the begin)
        ld      (YF2FE),a               ; not found a free direntry

;       Subroutine      get latest FAT
;       Inputs
;       Outputs         ________________________

A44DB:  call    XF267
        call    A4555                   ; get pointer to DPB of current drive
        ld      a,(YF2E1)               ; current driveid
        ld      c,(ix+1)                ; mediadesciptor
        ld      b,0
        or      a
        call    C6062                   ; DSKCHG
        jr      c,A44CA                 ; error,
        call    A4536                   ; update DPBTBL entry current drive
        ld      l,(ix+19)
        ld      h,(ix+20)
        dec     hl
        ld      a,b                     ; DSKCHG status
        or      (hl)                    ; combined with the FAT buffer status
        ld      a,(YF2E1)               ; current driveid
        ld      hl,(YF241)
        jp      m,A450A                 ; FAT buffer invalid OR diskchange unknown, read the FAT
        ret     nz                      ; FAT buffer changed OR disk unchanged, do not read the FAT and quit
        cp      l                       ; current drive same as datasector buffer owner ?
        jr      nz,A4516                ; nope, read the FAT
        dec     h                       ; datasector buffer changed ?
        ret     z                       ; yep, do not read the FAT and quit
A450A:  sub     l                       ; current drive same as datasector buffer owner ?
        jr      nz,A4516                ; nope, leave the datasector buffer alone
        ld      l,a
        ld      h,a
        ld      (YF23F),hl
        dec     l
        ld      (YF241),hl              ; invalid datasector buffer
A4516:  ld      a,0FFH
        ld      (YF246),a               ; invalid dirsector buffer
        call    A45FA                   ; get FAT parameters
        dec     hl
        ld      (hl),0                  ; FAT buffer unchanged
        inc     hl
A4522:  push    af
        call    A46D7                   ; read FAT sectors
        jr      c,A4541                 ; error, try the next FAT copy
        pop     af
A4529:  ld      b,(hl)                  ; mediabyte of FAT sector
        ld      a,(YF2E1)               ; current driveid
        ld      c,(ix+1)                ; mediadescriptor
        push    ix
        pop     hl
        call    C606A                   ; GETDPB
A4536:  push    hl
        pop     ix
        ex      de,hl
        call    A4563                   ; get DPBTBL entry of current drive
        ld      (hl),e
        inc     hl
        ld      (hl),d
        ret

A4541:  ld      a,e
        add     a,c
        ld      e,a
        jr      nc,A4547
        inc     d
A4547:  pop     af                      ; adjust first FAT sector to the first FAT sector of the next FAT copy
        dec     a
        jr      nz,A4522                ; there is a other FAT copy, try that one
        call    A45FA                   ; get FAT parameters (so the first FAT copy is used)
        push    hl
        call    A46C5                   ; read FAT sectors with DOS error handling
        pop     hl
        jr      A4529                   ; use FAT buffer

;       Subroutine      get pointer to DPB of current drive
;       Inputs
;       Outputs         HL = IX = pointer to DPB

A4555:  call    XF26A
        call    A4563                   ; get DPBTBL entry of current drive
        ld      a,(hl)
        inc     hl
        ld      h,(hl)
        ld      l,a
        push    hl
        pop     ix
        ret

;       Subroutine      get DPBTBL entry of current drive
;       Inputs          HL = address of pointer
;       Outputs         ________________________

A4563:  ld      a,(YF2E1)               ; current driveid
        ld      hl,YF355
        add     a,a
        add     a,l
        ld      l,a
        ret     nc
        inc     h
        ret

;       Subroutine      BDOS 10 (close file)
;       Inputs
;       Outputs         ________________________

A456F:  push    de
        pop     iy
        call    A440E                   ; validate FCB drive and filename
        ld      a,0FFH
        ret     c                       ; invalid, quit with error
        ld      a,(iy+24)
        and     0C0H
        ld      a,0                     ; ok
        ret     nz                      ; device OR unchanged diskfile, quit
        ld      a,(YF2E1)               ; current driveid
        ld      hl,(YF241)
        cp      l                       ; same drive as owner datasector buffer ?
        call    z,A472D                 ; yep, flush datasector buffer
        call    A4555                   ; get pointer to DPB of current drive
        ld      a,(iy+25)               ; direntrynumber
        call    A4317                   ; get direntry
        ld      b,11
        call    A424F                   ; compare with filename1
        jr      nz,A45EE                ; not the same, make FAT buffer unchanged and quit with error
        push    iy
        pop     de
        ld      c,00BH
        add     hl,bc
        ex      de,hl
        ld      c,016H
        add     hl,bc
        ldi
        ldi
        ld      bc,0FFFCH
        add     hl,bc
        ldi
        ldi
        ld      bc,00004H
        add     hl,bc
        ldi
        ldi
        ld      bc,0FFF4H
        add     hl,bc
        ld      bc,00004H
        ldir
        call    A4748                   ; update directory of disk

;       Subroutine      flush FAT buffer
;       Inputs
;       Outputs         ________________________

A45C4:  ld      l,(ix+19)
        ld      h,(ix+20)
        dec     hl
        ld      a,(hl)
        cp      1                       ; FAT buffer changed ?
        ret     nz                      ; nope, quit (?? return error if FAT buffer invalid)

;       Subroutine      write FAT buffer
;       Inputs
;       Outputs         ________________________

A45CF:  call    XF26D
        call    A45FA                   ; get FAT parameters
        dec     hl
        ld      (hl),0                  ; FAT buffer unchanged
        inc     hl
A45D9:  push    af
        push    de
        push    bc
        push    hl
        call    A4755                   ; write FAT sectors with DOS error handling
        pop     hl
        pop     bc
        pop     de
        ld      a,e
        add     a,b
        ld      e,a
        jr      nc,A45E9
        inc     d                       ; to start sector of the next FAT
A45E9:  pop     af
        dec     a
        jr      nz,A45D9                ; write next FAT
        ret

;       Subroutine      make FAT buffer unchanged and quit with error
;       Inputs
;       Outputs         ________________________

A45EE:  ld      l,(ix+19)
        ld      h,(ix+20)
        dec     hl
        ld      (hl),0                  ; FAT buffer unchanged
        ld      a,0FFH                  ; error
        ret

;       Subroutine      get FAT parameters
;       Inputs          IX = pointer to DPB
;       Outputs         A = number of FATs, DE = first FAT sector, B = number sectors per FAT, HL = pointer to FAT buffer

A45FA:  ld      a,(ix+10)               ; number of FATs
        ld      l,(ix+19)
        ld      h,(ix+20)               ; pointer to FAT buffer
        ld      b,(ix+16)               ; number of sectors per FAT
        ld      e,(ix+8)
        ld      d,(ix+9)                ; first FAT sector
        ret

;       Subroutine      get dir parameters
;       Inputs          IX = pointer to DPB, A = relative dirsector, DE = first dirsector
;       Outputs         DE = dirsector, B = 1, HL = pointer to dirsector buffer

A460D:  add     a,(ix+17)
        ld      e,a
        ld      d,(ix+18)
        jr      nc,A4617
        inc     d                       ; + first dir sector
A4617:  ld      hl,(YF351)              ; dirsector buffer
        ld      b,1                     ; 1 sector
        ret

;       Subroutine      BDOS 16 (create file)
;       Inputs
;       Outputs         ________________________

A461D:  push    de
T461E:  call    A440E                   ; validate FCB drive and filename
        jr      c,A464D                 ; invalid, quit with error
        inc     hl
        inc     hl
        ld      (hl),0                  ; clear S2 byte
        ld      hl,YF2B9
        ld      a,"?"
        ld      bc,11
        cpir                            ; wildcard char in filename ?
        jr      z,A464D                 ; yep, quit with error
        call    A42B5                   ; find first directoryentry
        jr      nc,A4651                ; found, special actions for existing file/device
        ld      a,(YF2FE)
        cp      0FFH                    ; found free direntry ?
        jr      z,A464D                 ; nope, quit with error (directory is full)
        call    A4317                   ; get direntry
        push    hl
        pop     iy
        jr      A4669                   ; setup direntry

A4647:  bit     7,(iy+11)
        jr      nz,A469D                ; device, treat as open file
                                        ; file with special fileattribute, quit with error
A464D:  pop     de
        ld      a,0FFH
        ret

A4651:  jr      nz,A4647                ; device or file with special fileattribute,
        ld      a,(YF30C)               ; orginal FCB EX byte
        or      a
        jr      nz,A469D                ; is not zero, just open the file
        ld      l,(iy+26)
        ld      h,(iy+27)
        ld      a,h
        or      l                       ; has start cluster ?
        jr      z,A4669                 ; nop,
        call    A4F9B                   ; release cluster chain
        call    A45CF                   ; write FAT buffer
A4669:  push    iy
        pop     de
        ld      hl,YF2B9
        ld      bc,11
        ldir                            ; copy filename in FCB to direntry
        ld      a,(hl)
        rla
        ld      a,000H
        jr      nc,A467C                ; b7 DR byte reset, ordinary file
        ld      a,006H                  ; b7 DR byte set, hidden system file
A467C:  ld      (de),a
        inc     de
        ex      de,hl
        ld      b,10
        xor     a
A4682:  ld      (hl),a
        inc     hl
        djnz    A4682                   ; clear unused bytes direntry
        push    hl
        call    A5496                   ; get time and date (dirformat)
        pop     hl
        ld      (hl),e
        inc     hl
        ld      (hl),d
        inc     hl
        ld      (hl),c
        inc     hl
        ld      (hl),b
        inc     hl                      ; fill in time and date in direntry
        xor     a
        ld      b,2+4
A4696:  ld      (hl),a
        inc     hl
        djnz    A4696                   ; fill in no first cluster, filesize 0 in direntry
        call    A4748                   ; update directory of disk

A469D:  push    iy
        pop     hl
        pop     de
        jp      A4471                   ; continue with open file

;       Subroutine      read dirsector
;       Inputs          C = relative dir sector
;       Outputs         ________________________

A46A4:  push    bc
        call    A4743                   ; flush directory buffer
        pop     bc
        ld      b,(ix+0)                ; driveid
        ld      (YF246-1),bc            ; set driveid and sector dirsector buffer
        push    bc
        ld      a,c                     ; relative dirsector
        call    A460D                   ; setup dirsector parameters
        call    A46C5                   ; read dirsector with DOS error handling
        pop     bc
        ret

;       Subroutine      BDOS 2F (read logical sector)
;       Inputs
;       Outputs         ________________________

A46BA:  ld      b,h
        ld      a,l
        ld      (YF2E1),a               ; set current driveid
        call    A4555                   ; get pointer to DPB of current drive
        ld      hl,(YF23D)              ; transferaddress

;       Subroutine      read sectors with DOS error handling
;       Inputs
;       Outputs         ________________________

A46C5:  call    XF270
        xor     a
        ld      (YF2FF),a               ; flag read disk operation
        call    A46D7                   ; read sector
        ret     nc                      ; no error, quit
        call    A46E8                   ; adjust parameters to restart at error sector and start diskerror handler
        dec     a
        jr      z,A46C5                 ; RETRY, try again
        ret                             ; IGNORE, quit

;       Subroutine      read sectors
;       Inputs
;       Outputs         ________________________

A46D7:  ld      a,(ix+0)                ; driveid
        ld      c,(ix+1)                ; mediadescriptor
        push    hl
        push    de
        push    bc
        call    C604D                   ; read disksector
        pop     de
        ld      c,d
        pop     de
        pop     hl
        ret

;       Subroutine      adjust parameters to restart at error sector and start diskerror handler
;       Inputs
;       Outputs         ________________________

A46E8:  push    af
        ld      a,c
        sub     b
        ld      c,a
        push    bc
        ld      b,000H
        ex      de,hl
        add     hl,bc
        push    hl
        push    de
        ld      e,(ix+2)
        ld      d,(ix+3)                ; sectorsize
        call    A4916                   ; multiply
        pop     hl
        pop     de
        add     hl,bc
        pop     bc
        pop     af
        ld      c,a
        ld      a,(YF2FF)               ; type of diskoperation
        or      c
        ld      c,a
        ld      a,(ix+0)                ; driveid

;       Subroutine      start diskerror handler
;       Inputs
;       Outputs         ________________________

A470A:  call    XF273
        push    bc
        push    de
        push    hl
        ld      hl,(YF323)
        call    XF1E8                   ; start diskerror handler in DOS memory
        ld      a,c                     ; requested action
        pop     hl
        pop     de
        pop     bc
        cp      2
        ret     nz
        jp      XF1E2                   ; Warm boot

;       Subroutine      BDOS 30 (write logical sector)
;       Inputs
;       Outputs         ________________________

A4720:  ld      b,h
        ld      a,l
        ld      (YF2E1),a               ; set current driveid
        call    A4555                   ; get pointer to DPB of current drive
        ld      hl,(YF23D)              ; transferaddress
        jr      A4755                   ; write sectors with DOS error handling

;       Subroutine      flush datasector buffer
;       Inputs
;       Outputs         ________________________

A472D:  ld      hl,YF242
        xor     a
        cp      (hl)                    ; datasector buffer changed ?
        ld      (hl),a                  ; now it is unchanged
        ret     z                       ; nope, quit
        ld      ix,(YF243)              ; saved DPB pointer
        ld      hl,(YF34F)              ; datasector buffer
        ld      b,1                     ; 1 sector
        ld      de,(YF23F)              ; sectornumber of datasector buffer
        jr      A4755                   ; write sector with DOS error handling

;       Subroutine      flush directory buffer
;       Inputs
;       Outputs         ________________________

A4743:  ld      a,(YF23C)
        or      a                       ; directory buffer changed ?
        ret     z                       ; nope, quit

;       Subroutine      write dirsector buffer
;       Inputs
;       Outputs         ________________________

A4748:  call    XF276
        xor     a
        ld      (YF23C),a               ; directory buffer unchanged
        ld      a,(YF245)               ; current dirsector (offset)
        call    A460D                   ; setup dirsector parameters

;       Subroutine      write sectors with DOS error handling
;       Inputs
;       Outputs         ________________________

A4755:  call    XF279
        ld      a,1
        ld      (YF2FF),a               ; flag write disk operation
        ld      a,(ix+0)                ; driveid
        ld      c,(ix+1)                ; mediadescriptor
        push    hl
        push    de
        push    bc
        call    C604F                   ; write disksector
        pop     de
        ld      c,d
        pop     de
        pop     hl
        ret     nc                      ; no error, quit
        call    A46E8                   ; adjust parameters to restart at error sector and start diskerror handler
        dec     a
        jr      z,A4755                 ; RETRY, try again
        ret                             ; IGNORE, quit

;       Subroutine      BDOS 14 (read next record)
;       Inputs
;       Outputs         ________________________

A4775:  call    A4EF8                   ; get recordnumber from CR,EX and S2 fields
        call    A4B23                   ; read record
        jr      A4783                   ; update sequencial fields

;       Subroutine      BDOS 15 (write next record)
;       Inputs
;       Outputs         ________________________

A477D:  call    A4EF8                   ; get recordnumber from CR,EX and S2 fields
        call    A4CA3                   ; write record
A4783:  call    A486A                   ; increase recordnumber if something was read/written
        jr      A479C                   ; update CR,EX and S2 field

;       Subroutine      BDOS 21 (random access read record)
;       Inputs
;       Outputs         ________________________

A4788:  call    A4857                   ; get recordnumber from Rx fields, 1 record
        call    A4B23                   ; read record
        jr      A4799                   ; update Rx, CR,EX and S2 field

A4790:  push    iy
        pop     de

;       Subroutine      BDOS 22 (random access write record)
;       Inputs
;       Outputs         ________________________

A4793:  call    A4857                   ; get recordnumber from Rx fields, 1 record
        call    A4CA3                   ; write record
A4799:  call    A4844                   ; update Rx fields

A479C:  ld      a,l
        and     07FH
        ld      (iy+32),a               ; CR
        sla     l
        rl      h
        ld      (iy+12),h               ; S2
        rl      e
        ld      (iy+14),e               ; EX
        ld      a,(YF2DE)               ; result recordoperation
        ret

;       Subroutine      BDOS 27 (MSXDOS random block read)
;       Inputs
;       Outputs         ________________________

A47B2:  xor     a
        ld      (YF306),a               ; no CP/M call
        call    A485A                   ; get random record number
        call    A4B23                   ; read record(s)
        jr      A47C8

;       Subroutine      BDOS 26 (MSXDOS random block write)
;       Inputs
;       Outputs         ________________________

A47BE:  xor     a
        ld      (YF306),a               ; no CP/M call
        call    A485A                   ; get random record number
        call    A4CA3                   ; write record(s)
A47C8:  call    A486A                   ; increase recordnumber if something was read/written
        call    A4844                   ; update Rx fields
        ld      l,c
        ld      h,b
        ret

;       Subroutine      BDOS 28 (write random with zero fill)
;       Inputs
;       Outputs         ________________________

A47D1:  push    de
        pop     iy
        ld      a,(iy+16)
        ld      c,(iy+17)
        ld      b,(iy+18)
        ld      e,(iy+19)
        add     a,a
        rl      c
        rl      b
        rl      e                       ; convert filesize to a random record number
        or      a                       ; was filesize a multiply of 128 ?
        jr      z,A47F0
        inc     bc
        ld      a,b
        or      c
        jr      nz,A47F0
        inc     e                       ; no, increase random record number

; the following code depends on the fact that CP/M 2.2 only uses the R0 and R1 field
; code only works when the random record (filesize) is within 65536 records of the random record (fcb)

A47F0:  ld      l,(iy+33)
        ld      h,(iy+34)               ; R1 and R0
        sbc     hl,bc
        jr      z,A4790                 ; exact at end of file, random access write record and quit
        ld      a,(iy+35)
        sbc     a,e                     ; before end of file ?
        jr      c,A4790                 ; yep, random access write record and quit
        push    hl                      ; save number of gap records
        call    A4790                   ; random access write record (gap in filled with garbage)
        pop     de
        or      a
        ret     nz                      ; error, quit

; now the gap is filled. dirsector buffer is used for the zero filled record
; neat code should first flush the dirsector buffer, but this is ommited

        ld      hl,(YF23D)              ; transferaddress
        push    hl
        ld      hl,(YF351)
        ld      (YF23D),hl              ; tempory use dirsector buffer
        ld      b,128
A4813:  ld      (hl),a
        inc     hl
        djnz    A4813                   ; create a zero filed random record
        dec     a
        ld      (YF246),a               ; invalid dirsector buffer
        ld      l,(iy+33)
        ld      h,(iy+34)
        sbc     hl,de
        ld      c,l
        ld      b,h
        ex      de,hl
        ld      d,000H
        ld      a,(iy+35)
        sbc     a,d
        ld      e,a                     ; start record of gap
A482D:  push    hl
        ld      hl,1
        call    A4CA3                   ; write record
        call    A486A                   ; increase recordnumber if something was writen
        ld      c,l
        ld      b,h
        pop     hl
        dec     hl
        ld      a,h
        or      l
        jr      nz,A482D                ; next record
        pop     hl
        ld      (YF23D),hl              ; restore transferaddress
        ret

A4844:  ld      a,(YF2DE)               ; result recordoperation
        ld      (iy+33),l
        ld      (iy+34),h
        ld      (iy+35),e
        inc     d
        dec     d
        ret     z
        ld      (iy+36),d
        ret

A4857:  ld      hl,1                    ; 1 record
A485A:  push    de
        pop     iy
        ld      c,(iy+33)               ; R0
        ld      b,(iy+34)               ; R1
        ld      e,(iy+35)               ; R2
        ld      d,(iy+36)               ; R3
        ret

A486A:  ret     z
        inc     hl
        ld      a,h
        or      l
        ret     nz
        inc     de
        ret

A4871:  pop     hl
        ld      l,c
        ld      h,b
        ld      a,1
        ld      (YF2DE),a               ; error in recordoperation
        xor     a
        ld      c,a
        ld      b,a
        ret

A487D:  ld      (YF2E8),hl              ; number of records requested
        ld      (YF2E4+0),bc
        ld      (YF2E4+2),de            ; startrecord
        ld      a,(iy+0)
        call    A4427                   ; validate fcb driveid
        jr      c,A4871
        ld      de,00080H
        ld      a,(YF306)
        or      a                       ; Random Block ?
        jr      nz,A48A8
        ld      a,(iy+14)
        ld      d,(iy+15)               ; yep, use user set recordsize
        ld      e,a
        or      d                       ; zero recordsize ?
        jr      nz,A48A8
        ld      e,128
        ld      (iy+14),e               ; yep, use 128 bytes default
A48A8:  inc     d
        dec     d
        jr      nz,A48B1
        ld      a,e
        cp      64
        jr      c,A48B5
A48B1:  xor     a
        ld      (YF2E4+3),a             ; recordsize >64, clear b31-b24 of record (use 24 bit recordnumbers)
A48B5:  ld      hl,(YF23D)
        ld      (YF2E2),hl              ; current transferaddress
        xor     a
        ld      (YF2DE),a               ; no error in recordoperation
        ld      (YF2DF),a               ; flag do not increase sector
        ld      bc,(YF2E8)              ; number of records requested
        call    A4916                   ; * recordsize
        ld      a,(iy+24)
        or      a
        ret     m                       ; DOS device, quit
        push    bc
        call    A4555                   ; get pointer to DPB of current drive
        ld      bc,(YF2E4+0)
        call    A4916                   ; multiply
        ld      (YF2F4+0),bc
        push    bc
        ld      bc,(YF2E4+2)
        call    A491C                   ; multiply high word
        ld      (YF2F4+2),bc            ; startbyte = startrecord * recordsize
        ld      h,b
        ld      l,c
        pop     bc                      ; BCHL = startbyte
        ld      e,(ix+2)
        ld      d,(ix+3)
        call    A4932                   ; / sectorsize
        ld      (YF2F2),hl              ; offset in sector of startbyte
        ld      (YF2EE),bc              ; relative sector of startbyte
        ld      a,(ix+6)
        and     c                       ; clustermask
        ld      (YF2DD),a               ; current relative sector in cluster (of startbyte)
        ld      a,(ix+7)                ; clustershift
A4906:  dec     a
        jr      z,A490F
        srl     b
        rr      c
        jr      A4906

A490F:  ld      (YF2EC),bc              ; relative cluster of startbyte
        pop     bc
        xor     a
        ret

;       Subroutine      multiply
;       Inputs
;       Outputs         ________________________

A4916:  call    XF27C
        ld      hl,0

;       Subroutine      multiply high word
;       Inputs
;       Outputs         ________________________

A491C:  ld      a,b
        ld      b,011H
        jr      A4928

A4921:  jr      nc,A4924
        add     hl,de
A4924:  rr      h
        rr      l
A4928:  rra
        rr      c
        djnz    A4921
        ld      b,a
        ret

;       Subroutine      divide
;       Inputs
;       Outputs         ________________________

DIV16:
A492F:  ld      hl,0

;       Subroutine      divide
;       Inputs
;       Outputs         ________________________

A4932:  call    XF27F
        ld      a,b
        ld      b,010H
        rl      c
        rla
A493B:  rl      l
        rl      h
        jr      c,A494E
        sbc     hl,de
        jr      nc,A4946
        add     hl,de
A4946:  ccf
A4947:  rl      c
        rla
        djnz    A493B
        ld      b,a
        ret

A494E:  or      a
        sbc     hl,de
        jr      A4947

;       Subroutine      calculate partial sector transfers
;       Inputs
;       Outputs         ________________________

A4953:  ld      h,b
        ld      l,c                     ; bytes to transfer
        ld      bc,(YF2F2)              ; offset in sector startbyte
        ld      a,b
        or      c
        ld      e,a
        ld      d,a
        jr      z,A4972                 ; at start sector, no partial start
        ld      e,(ix+2)
        ld      d,(ix+3)
        ex      de,hl                   ; sectorsize
        sbc     hl,bc
        ex      de,hl                   ; bytes left in sector
        sbc     hl,de                   ; enough ?
        jr      nc,A4972                ; nop, get what you can
        add     hl,de
        ex      de,hl
        ld      hl,0
A4972:  ld      (YF2F8),de              ; bytes to transfer from partial sector
        ld      c,l
        ld      b,h                     ; bytes left after partial sector transfer
        ld      e,(ix+2)
        ld      d,(ix+3)
        call    A492F                   ; / sectorsize
        ld      (YF2FA),hl              ; partial bytes in endsector
        ld      (YF2FC),bc              ; hole sectors of transfer
        ret

;       Subroutine      get absolute cluster
;       Inputs
;       Outputs         ________________________

A4989:  call    XF282
        ld      l,(iy+28)
        ld      h,(iy+29)               ; current cluster of file
        ld      e,(iy+30)
        ld      d,(iy+31)               ; current relative cluster of file
        ld      a,l
        or      h
        jr      z,A49CF                 ; file has no start cluster,
        push    bc
        ld      a,c
        sub     e
        ld      c,a
        ld      a,b
        sbc     a,d
        ld      b,a
        jr      nc,A49B0                ; requested cluster behind current, search from current cluster
        pop     bc
        ld      de,0                    ; relative cluster 0
        ld      l,(iy+26)
        ld      h,(iy+27)               ; start cluster of file
        push    af
A49B0:  pop     af
A49B1:  call    XF285
        ld      a,b
        or      c
        ret     z
        push    de
        push    hl
        call    A41F4                   ; get FAT entry content
        pop     de
        ld      a,h
        cp      00FH
        jr      c,A49C7
        ld      a,l
        cp      0F8H
        jr      nc,A49CC                ; end cluster
A49C7:  pop     de
        inc     de
        dec     bc
        jr      A49B1

A49CC:  ex      de,hl
        pop     de
        ret

A49CF:  inc     bc                      ; BC<>0 (means not found)
        dec     de
        ret

;       Subroutine      read datasector
;       Inputs
;       Outputs         ________________________

A49D2:  ld      (YF2E0),a
        ld      hl,(YF2EC)              ; relative cluster
        ld      a,(YF2DD)               ; current relative sector in cluster
        call    A4EDB                   ; get sectornumber of cluster
        ex      de,hl
        ld      hl,(YF23F)
        sbc     hl,de                   ; is it currently in the datasector buffer ?
        jr      nz,A49F0                ; nope, get it
        ld      a,(YF2E1)               ; current driveid
        ld      l,a
        ld      a,(YF241)
        cp      l                       ; same drive as owner datasector buffer ?
        jr      z,A4A1B                 ; yep,
A49F0:  push    de
        push    ix
        call    A472D                   ; flush datasector buffer
        pop     ix
        pop     de
        ld      a,(YF2E0)
        or      a                       ; real or fake read ?
        jr      nz,A4A0D                ; fake read
        dec     a
        ld      (YF241),a
        ld      hl,(YF34F)              ; datasector buffer
        ld      b,1                     ; 1 sector
        push    de
        call    A46C5                   ; read sector with DOS error handling
        pop     de
A4A0D:  ld      (YF23F),de              ; current datasector
        ld      a,(YF2E1)               ; current driveid
        ld      (YF241),a               ; set owner datasector buffer
        ld      (YF243),ix              ; save DPB pointer
A4A1B:  ld      a,1
        ld      (YF2DF),a               ; flag do increase sector
        ld      hl,(YF2E2)
        push    hl
        ld      bc,(YF2F8)
        add     hl,bc
        ld      (YF2E2),hl              ; update current transferaddress
        ld      hl,(YF34F)              ; datasector buffer
        ld      de,(YF2F2)
        add     hl,de
        pop     de
        ret

;       Subroutine      do partical sector read if needed
;       Inputs
;       Outputs         ________________________

A4A36:  call    XF288
        ld      hl,(YF2F8)
        ld      a,h
        or      l                       ; partial sector read
        ret     z                       ; nope, quit
        xor     a                       ; real read
        call    A49D2                   ; read datasector
        jp      XF1D9                   ; transfer to DOS memory

;       Subroutine      handle partial sector write
;       Inputs
;       Outputs         ________________________

A4A46:  call    XF28B
        ld      hl,(YF2F8)
        ld      a,h
        or      l                       ; partial start ?
        ret     z                       ; nop, quit
        ld      hl,(YF2EE)
        inc     hl
        ld      (YF2EE),hl              ; update relative sector of startbyte
        xor     a
        ex      de,hl
        ld      hl,(YF2F0)
        sbc     hl,de                   ; sector behind end of file ?
        rra                             ; if yes, fake read
        call    A49D2                   ; read datasector
        ex      de,hl
        call    XF1D9                   ; transfer from DOS memory
        ld      a,1
        ld      (YF242),a               ; flag datasector changed
        ret

;       Subroutine      last partial sector ?
;       Inputs
;       Outputs         ________________________

A4A6B:  ld      hl,0
        ld      (YF2F2),hl
        ld      hl,(YF2FA)
        ld      (YF2F8),hl
        ld      a,h
        or      l
        scf
        ret     z

;       Subroutine      to next sector (only when partical read was done)
;       Inputs
;       Outputs         ________________________

A4A7B:  ld      a,(YF2DF)
        or      a                       ; flag do not increase
        ret     z                       ; yep, quit
        ld      a,(YF2DD)
        cp      (ix+6)                  ; clustermask
        jr      c,A4AA2                 ; still sectors left in this cluster, increase relative sector in cluster
        ld      de,(YF2EC)              ; current cluster of file
        ld      hl,00FF7H
        sbc     hl,de
        ret     c                       ; is the end cluster, quit
        ex      de,hl
        call    A41F4                   ; get FAT entry content
        ld      (YF2EC),hl              ; new current cluster of file
        ld      hl,(YF2EA)
        inc     hl
        ld      (YF2EA),hl              ; new current relative cluster of file
        ld      a,0FFH                  ; relative sector in cluster 0
A4AA2:  inc     a
        ld      (YF2DD),a
        or      a
        ret

; finish CON read

A4AA8:  ld      a,(hl)
        ldi
        cp      00DH
        jr      nz,A4AB1
        ld      (hl),00AH
A4AB1:  cp      00AH
        jr      z,A4ACA
        ld      a,b
        or      c
        jr      nz,A4AA8
A4AB9:  ld      (YF300),hl

; finish read record for dos devices

A4ABC:  ld      (YF2E2),de              ; update current transferaddress
        jp      nz,A4BE2
        res     6,(iy+24)
        jp      A4BE2

A4ACA:  call    A53A8                   ; console output
        ld      hl,00000H
        ld      a,c
        or      b
        jr      nz,A4AF9
        inc     a
        jr      A4AB9

;       Subroutine      read record for dos devices
;       Inputs
;       Outputs         ________________________

A4AD7:  ld      de,(YF2E2)              ; current transferaddress
        inc     a
        jr      z,A4AF2                 ; CON, handle
        inc     a
        jr      nz,A4ABC                ; PRN, quit

; read record AUX

A4AE1:  call    A546E                   ; auxiliary input
        ld      (de),a
        inc     de
        cp      01AH
        jr      z,A4ABC                 ; CTRL-Z,
        dec     bc
        ld      a,b
        or      c                       ; all bytes done ?
        jr      nz,A4AE1                ; nope, next byte
        inc     a
        jr      A4ABC

; read record CON

A4AF2:  ld      hl,(YF300)
        ld      a,h
        or      l
        jr      nz,A4AA8
A4AF9:  ld      hl,128
        ld      a,(YCONBF+0)
        cp      l
        jr      z,A4B05
        ld      (YCONBF+0),hl
A4B05:  push    bc
        push    de
        ld      de,YCONBF
        call    A50E0                   ; BDOS 0A (buffered console input)
        pop     de
        pop     bc
        ld      hl,YCONBF+2
        ld      a,(hl)
        cp      01AH
        jr      nz,A4AA8
        ld      (de),a
        inc     de
        ld      a,00AH                  ; LF
        call    A53A8                   ; console output
        xor     a
        ld      h,a
        ld      l,a
        jr      A4AB9

;       Subroutine      read record
;       Inputs          DEBC = recordnumber, HL = number of records
;       Outputs         DEHL = last record done, BC = number of records done

A4B23:  call    A487D                   ; initialize record info
        jp      m,A4AD7                 ; dos device, special action
        ld      l,(iy+16)
        ld      h,(iy+17)
        ld      de,(YF2F4+0)
        or      a
        sbc     hl,de
        push    hl
        ld      l,(iy+18)
        ld      h,(iy+19)
        ld      de,(YF2F4+2)
        sbc     hl,de
        pop     hl
        jp      c,A4C97                 ; startbyte behind end of file, quit with nothing done
        jr      nz,A4B56                ; startbyte at least 65536 bytes from the end of file, go get it
        ld      a,h
        or      l
        jp      z,A4C97                 ; startbyte is at end of file, quit with nothing done
        push    hl
        sbc     hl,bc                   ; requested number of bytes past file ?
        pop     hl
        jr      nc,A4B56                ; nope, go get it
        ld      b,h
        ld      c,l                     ; only read number of bytes until the end of file
A4B56:  call    XF28E
        call    A4953                   ; calculate partial sector transfers
        ld      bc,(YF2EC)              ; relative cluster
        call    A4989                   ; get absolute cluster
        ld      a,b
        or      c                       ; found ?
        jp      nz,A4C97                ; nope, quit with nothing done
        ld      (YF2EC),hl              ; current cluster = cluster of startbyte
        ld      (YF2EA),de              ; current relative cluster = relative cluster of startbyte
        call    A4A36                   ; do partical sector read if needed
        ld      hl,(YF2FC)
        ld      a,h
        or      l
        jp      z,A4BDC                 ; not any whole sectors to transfer, to partical end
        call    A4A7B                   ; to next sector (only when partical read was done)
        jr      c,A4BE2                 ; there is no next,
        ld      a,1
        ld      (YF2DF),a               ; flag do increase sector
        ld      a,(YF2DD)               ; current relative sector in cluster
        ld      bc,(YF2FC)
        ld      hl,(YF2EC)              ; current cluster of file
A4B8E:  push    bc
        call    A4E48                   ; calculate sequential sectors
        push    bc
        push    af
        ld      b,a
        call    A46C5                   ; read sectors with DOS error handling
        pop     af
        ld      c,a
        ld      b,000H                  ; number of sectors read
        jr      c,A4BC1                 ; sectors read does not include the sector in the datasector buffer
        ld      a,(YF242)
        or      a                       ; datasector buffer changed ?
        jr      z,A4BC1                 ; nope, then no need to transfer the datasector buffer
        push    bc
        ld      c,(ix+2)
        ld      b,(ix+3)                ; sectorsize
        push    bc
        push    hl
        ld      hl,(YF23F)              ; sectornumber of datasector buffer
        sbc     hl,de
        ex      de,hl
        call    A4916                   ; multiply
        pop     hl
        add     hl,bc
        pop     bc
        ex      de,hl
        ld      hl,(YF34F)              ; datasector buffer
        call    XF1D9                   ; transfer to DOS memory
        pop     bc
A4BC1:  pop     de
        pop     hl
        or      a
        sbc     hl,bc                   ; done all whole sectors ?
        jr      z,A4BDC                 ; yep, go partial end
        ld      c,l
        ld      b,h
        ld      hl,00FF7H
        sbc     hl,de                   ; end cluster ?
        jr      c,A4BE2                 ; yep, finish without partial end
        ld      hl,(YF2EA)
        inc     hl
        ld      (YF2EA),hl              ; increase current relarive cluster
        xor     a                       ; current relative sector in cluster = first sector
        ex      de,hl
        jr      A4B8E                   ; again

A4BDC:  call    A4A6B                   ; last partial sector ?
        call    nc,A4A36                ; yes, do partical sector read if needed
A4BE2:  call    XF291
        ld      hl,(YF2E2)              ; current transferaddress (end)
        ld      de,(YF23D)              ; transferaddress (begin)
        or      a
        sbc     hl,de
        ld      c,l
        ld      b,h                     ; size of transfer
        ld      de,00080H
        ld      a,(YF306)
        or      a                       ; Random Block
        jr      nz,A4C00                ; nope, use 128 bytes recordsize
        ld      e,(iy+14)
        ld      d,(iy+15)               ; user recordsize for Random Block
A4C00:  call    A492F                   ; how many records ?
        ld      a,h
        or      l                       ; partly records ?
        jr      z,A4C17                 ; nop,
        inc     bc                      ; records +1
        ex      de,hl
        sbc     hl,de                   ; 'missed' bytes
        ld      de,(YF2E2)
A4C0F:  xor     a
        ld      (de),a
        inc     de
        dec     hl
        ld      a,h
        or      l
        jr      nz,A4C0F                ; clear 'missed' bytes
A4C17:  ld      hl,(YF2E8)              ; number of records requested
        sbc     hl,bc
        jr      z,A4C22                 ; all done,
        inc     a
        ld      (YF2DE),a               ; error in record operation
A4C22:  call    XF294
        ld      hl,(YF2EC)
        ld      (iy+28),l
        ld      (iy+29),h               ; current cluster of file FCB
        ld      hl,(YF2EA)
        ld      (iy+30),l
        ld      (iy+31),h               ; current relative cluster of file FCB
A4C37:  ld      hl,(YF2E4+0)
        ld      de,(YF2E4+2)            ; startrecord
        ld      a,b
        or      c                       ; done any records ?
        ret     z                       ; nope, quit
        dec     bc
        add     hl,bc
        inc     bc
        ret     nc
        inc     de                      ; return current record
        ret

;       Subroutine      write record for dos devices
;       Inputs
;       Outputs         ________________________

A4C47:  ld      hl,(YF23D)              ; transferaddress
        or      040H
        inc     a
        jr      z,A4C73                 ; CON, handle
        inc     a
        jr      z,A4C63                 ; AUX, handle
        inc     a
A4C53:  jr      z,A4C81                 ; NUL, handle

        ld      a,(hl)
        inc     hl
        cp      01AH
        jr      z,A4C81
        call    A5466                   ; printer output
        dec     bc
        ld      a,b
        or      c
        jr      A4C53

A4C63:  ld      a,(hl)
        inc     hl
        call    A5475                   ; auxiliary output
        cp      01AH
        jr      z,A4C81
        dec     bc
        ld      a,b
        or      c
        jr      nz,A4C63
        jr      A4C81

A4C73:  ld      a,(hl)
        inc     hl
        cp      01AH
        jr      z,A4C81
        call    A53A8                   ; console output
        dec     bc
        ld      a,b
        or      c
        jr      nz,A4C73
A4C81:  ld      bc,(YF2E8)              ; no. of records
        jr      A4C37

A4C87:  ld      c,e
        ld      b,d                     ; clusters to skip
        call    A49B1                   ; get next absolute cluster
        ld      a,b
        or      c                       ; found ?
        jp      z,A4D41                 ; yep,
        call    A4F12                   ; allocate cluster chain
        jp      nc,A4D41                ; ok, go writing

A4C97:  call    XF297
        xor     a
        ld      c,a
        ld      b,a                     ; no records read/write
        inc     a
        ld      (YF2DE),a               ; error in record operation
        jr      A4C37

;       Subroutine      write record
;       Inputs          DEBC = recordnumber, HL = number of records
;       Outputs         ________________________

A4CA3:  call    A487D                   ; initialize record info
        push    af
        push    bc
        call    A5496                   ; get time and date (dirformat)
        ld      (iy+20),c
        ld      (iy+21),b
        ld      (iy+22),e
        ld      (iy+23),d
        pop     bc
        pop     af
        jp      m,A4C47                 ; DOS device, special action
        res     6,(iy+24)               ; flag FCB changed
        push    bc
        call    A4953                   ; calculate partical sector transfers
        pop     bc
        ld      hl,(YF2F4+0)
        ld      de,(YF2F4+2)            ; startbyte
        ld      a,b
        or      c                       ; zero bytes to write (only possible with Random Block) ?
        jp      z,A4DDD                 ; yep, filesize adjust action
        dec     bc
        add     hl,bc
        jr      nc,A4CD6
        inc     de                      ; endbyte
A4CD6:  ld      b,h
        ld      c,l
        ex      de,hl
        ld      e,(ix+2)
        ld      d,(ix+3)
        call    A4932                   ; / sectorsize
        ld      h,b
        ld      l,c                     ; relative sector of endbyte
        ld      b,(ix+7)                ; clustershift
        dec     b
        jr      z,A4CF0
A4CEA:  srl     h
        rr      l
        djnz    A4CEA                   ; relative cluster of endbyte
A4CF0:  push    hl
        ld      c,(iy+16)
        ld      b,(iy+17)
        ld      l,(iy+18)
        ld      h,(iy+19)               ; filesize
        call    A4932                   ; / sectorsize
        ld      a,h
        or      l                       ; offset in sector
        jr      z,A4D05
        inc     bc                      ; relative sector
A4D05:  call    XF29A
        ld      (YF2F0),bc              ; relative sector behind fileend
        ld      bc,(YF2EC)              ; relative cluster of startbyte
        call    A4989                   ; get absolute cluster
        ld      (YF2EC),hl              ; current cluster = cluster of startbyte
        ld      (YF2EA),de              ; current relative cluster = relative cluster of startbyte
        ex      (sp),hl
        or      a
        sbc     hl,de                   ; start and endbyte in same cluster ?
        ex      de,hl
        pop     hl
        jr      z,A4D41                 ; yep,
        ld      a,b
        or      c                       ; is cluster of startbyte found ?
        jp      z,A4C87                 ; yep, make chain to cluster of endbyte if needed and start writing
        push    bc
        ld      c,e
        ld      b,d                     ; clusters to allocate
        call    A4F12                   ; allocate cluster chain
        pop     bc
        jp      c,A4C97                 ; failed, quit with nothing done
        ld      de,(YF2EA)
        inc     de                      ; relative cluster to start
        dec     bc                      ; clusters to skip
        call    A49B1                   ; get next absolute cluster
        ld      (YF2EC),hl              ; cluster of startbyte
        ld      (YF2EA),de              ; relative cluster of startbyte
A4D41:  call    A4A46                   ; handle partial sector write
        ld      hl,(YF2FC)
        ld      a,h
        or      l                       ; any complete sectors ?
        jr      z,A4D8C                 ; nope, goto partial end
        ld      de,(YF2EE)
        add     hl,de
        ld      (YF2EE),hl              ; update relative sector of startbyte
        call    A4A7B                   ; to the next sector (only when partial write was done)
        ld      a,1
        ld      (YF2DF),a               ; flag do increase sector
        ld      a,(YF2DD)               ; current relative sector in cluster
        ld      hl,(YF2EC)              ; relative cluster
        ld      bc,(YF2FC)              ; whole sectors
A4D65:  push    bc
        call    A4E48                   ; calculate sequencial sectors
        push    bc
        push    af
        ld      b,a
        jr      c,A4D73                 ; sectors writen does not include the sector in the datasector buffer
        ld      a,0FFH
        ld      (YF241),a               ; invalid datasector buffer
A4D73:  call    A4755                   ; write datasectors with DOS error handling
        pop     af
        pop     de
        pop     hl
        ld      c,a
        xor     a
        ld      b,a
        sbc     hl,bc                   ; whole sectors left ?
        jr      z,A4D8C                 ; nop, go to partial end
        ld      c,l
        ld      b,h
        ld      hl,(YF2EA)
        inc     hl
        ld      (YF2EA),hl              ; update relative cluster
        ex      de,hl
        jr      A4D65                   ; again

A4D8C:  call    XF29D
        call    A4A6B                   ; last partial sector ?
        call    nc,A4A46                ; partial end, handle partial sector write
        ld      hl,(YF2E2)              ; current transferaddress
        ld      de,(YF23D)              ; transferaddress
        or      a
        sbc     hl,de
        ld      de,(YF2F4+0)
        add     hl,de
        ld      de,(YF2F4+2)
        jr      nc,A4DAB
        inc     de
A4DAB:  ld      (YF2F4+0),hl
        ld      (YF2F4+2),de            ; startbyte = startbyte + transfersize
        ld      c,(iy+16)
        ld      b,(iy+17)
        or      a
        sbc     hl,bc
        ld      c,(iy+18)
        ld      b,(iy+19)
        ex      de,hl
        sbc     hl,bc                   ; has file expanded ?
        jr      c,A4DD6                 ; nop,
A4DC6:  push    iy
        pop     hl
        ld      de,00010H
        add     hl,de
        ex      de,hl
        ld      hl,YF2F4                ; filelength = endbyte
        ld      bc,4
        ldir
A4DD6:  ld      bc,(YF2E8)              ; no. of records
        jp      A4C22

; filesize adjust

A4DDD:  ld      a,h
        or      l
        or      d
        or      e                       ; startbyte zero ?
        jr      z,A4E32                 ; yep, kill chain and quit
        ld      bc,1
        sbc     hl,bc
        ex      de,hl
        dec     bc
        sbc     hl,bc
        ld      b,d
        ld      c,e                     ; filesize = startbyte-1
        ld      e,(ix+2)
        ld      d,(ix+3)
        call    A4932                   ; / sectorsize
        ld      a,(ix+7)                ; clustershift
A4DFA:  dec     a
        jr      z,A4E03
        srl     b
        rr      c
        jr      A4DFA

A4E03:  call    A4989                   ; get absolute cluster
        ld      a,b
        or      c                       ; found ?
        jr      z,A4E26                 ; yep, this means chain must be shortend
        call    A4F12                   ; allocate cluster chain
        jp      c,A4C97                 ; failed, quit with nothing done
A4E10:  ld      bc,0
        ld      (YF2E8),bc              ; number of records = 0
        ld      (YF2EA),bc              ; current relative cluster = 0
        ld      l,(iy+26)
        ld      h,(iy+27)               ; start cluster of file
        ld      (YF2EC),hl              ; current cluster = start cluster of file
        jr      A4DC6

A4E26:  ld      bc,00FFFH
        call    A4F9E                   ; mark end & release rest chain
A4E2C:  dec     de
        ld      a,0FFH
        ld      (de),a                  ; flag FAT buffer changed
        jr      A4E10

A4E32:  ld      l,(iy+26)
        ld      h,(iy+27)
        ld      a,h
        or      l                       ; file has start cluster ?
        jr      z,A4E10                 ; nop,
        xor     a
        ld      (iy+26),a
        ld      (iy+27),a               ; file has no start cluster (empty file)
        call    A4F9B                   ; release cluster chain
        jr      A4E2C                   ; mark FAT buffer changed

;       Subroutine      calculate sequencial sectors
;       Inputs
;       Outputs         ________________________

A4E48:  call    XF2A0
        ld      d,a
        push    hl
        inc     b
        dec     b
        jr      z,A4E53
        ld      c,0FFH
A4E53:  ld      e,c
        push    de
        ld      a,(ix+6)                ; clustermask
        ld      (YF2DD),a               ; current relative sector in cluster
        inc     a
        sub     d
        ld      b,a
A4E5E:  ld      (YF2EC),hl
        push    hl
        call    A41F4                   ; get FAT entry content
        pop     de
        ld      a,c
        sub     b
        ld      c,a
        jr      z,A4E78
        ld      b,(ix+6)                ; clustermask
        jr      c,A4ECA
        inc     b
        inc     de
        ex      de,hl
        sbc     hl,de
        ex      de,hl
        jr      z,A4E5E
A4E78:  pop     de
        ex      (sp),hl
        push    hl
        push    de
        ld      a,e
        sub     c
        ld      e,a
        ld      d,000H
        ld      c,(ix+2)
        ld      b,(ix+3)                ; sectorsize
        call    A4916                   ; multiply
        pop     af
        ld      hl,(YF2E2)
        push    hl
        add     hl,bc
        ld      (YF2E2),hl              ; update current transferaddress
        pop     bc
        pop     hl
        push    bc
        push    de
        ex      de,hl
        ld      hl,(YF2EC)
        sbc     hl,de
        ld      bc,(YF2EA)
        add     hl,bc
        ld      (YF2EA),hl
        ex      de,hl
        call    A4EDB                   ; get sectornumber of cluster
        ex      de,hl
        pop     bc
        ld      a,(YF241)
        cp      (ix+0)                  ; driveid
        ld      a,c
        scf
        jr      nz,A4EC7
        ld      hl,(YF23F)              ; sectornumber of datasector buffer
        or      a
        sbc     hl,de
        jr      c,A4EC7
        ld      h,b
        ld      l,c
        add     hl,de
        dec     hl
        ld      bc,(YF23F)              ; sectornumber of datasector buffer
        sbc     hl,bc
A4EC7:  pop     hl
        pop     bc
        ret

A4ECA:  add     a,b
        ld      (YF2DD),a               ; current relative sector in cluster
        ld      c,000H
        jr      A4E78

;       Subroutine      get decoded characterpair (not needed, uses for secret message)
;       Inputs
;       Outputs         ________________________

A4ED2:  call    A41FA
        ld      a,l
        add     hl,hl
        add     hl,hl                   ; second char in H
        and     03FH                    ; first char in A
        ret

;       Subroutine      get sectornumber of cluster
;       Inputs          HL = cluster, A = relative sector in cluster
;       Outputs         HL = sectornumber

A4EDB:  call    XF2A3
        push    bc
        ld      b,(ix+7)                ; clustershift
        dec     hl
        dec     hl
        dec     b
        jr      z,A4EED
A4EE7:  sla     l
        rl      h
        djnz    A4EE7
A4EED:  or      l
        ld      l,a
        ld      c,(ix+12)
        ld      b,(ix+13)
        add     hl,bc                   ; + first datasector
        pop     bc
        ret

;       Subroutine      get recordnumber from S2,EX and CR fields
;       Inputs
;       Outputs         ________________________

A4EF8:  push    de
        pop     iy
        ld      c,(iy+32)               ; CR (current record)
        ld      b,(iy+12)               ; EX (extent)
        ld      e,(iy+14)               ; S2
        ld      d,0
        sla     c
        srl     e
        rr      b
        rr      c                       ; debc = recordnumber
        ld      hl,1                    ; 1 record
        ret

;       Subroutine      allocate cluster chain
;       Inputs
;       Outputs         ________________________

A4F12:  call    XF2A6
        ld      e,(ix+19)
        ld      d,(ix+20)
        ex      de,hl                   ; pointer to FAT buffer of drive
        ld      a,(hl)
        inc     hl
        ld      h,(hl)
        ld      l,a                     ; pointer to FAT
        push    hl
        ex      de,hl
        ld      e,(ix+14)
        ld      d,(ix+15)               ; Max cluster
        ld      (YF302),de              ; store
        push    hl
A4F2D:  push    bc                      ; clusters to allocate
        push    hl                      ; start cluster
        ld      d,h
        ld      e,l
A4F31:  push    de
        ex      de,hl
        ld      hl,(YF302)
        dec     hl
        or      a
        sbc     hl,de
        ex      de,hl                   ; last cluster on disk ?
        pop     de
        jr      nc,A4F4E                ; nop, go up
        ld      a,e
        or      d                       ; search below finished ?
        jr      nz,A4F56                ; nop, go below
        pop     hl
        pop     hl
        pop     hl
        ld      bc,00FFFH
        call    A4F9E                   ; mark end & release rest chain
        scf
        jr      A4F94

A4F4E:  inc     hl
        call    A4F5E                   ; try to allocate
        ld      a,e                     ; nop not free !
        or      d                       ; search below finished ?
        jr      z,A4F31                 ; try again (up)
A4F56:  dec     de
        ex      de,hl
        call    A4F5E                   ; try to allocate
        ex      de,hl                   ; nop not free !
        jr      A4F31                   ; try again

;       Subroutine      allocate cluster if free
;       Inputs
;       Outputs         ________________________

A4F5E:  push    hl
        push    de
        call    A41F4                   ; cluster free ?
        pop     de
        pop     hl
        ret     nz                      ; nop, no alloc
        pop     bc
        ld      c,l
        ld      b,h
        ex      (sp),hl
        ld      e,(ix+19)
        ld      d,(ix+20)               ; pointer to FAT buffer of drive
        call    A4221                   ; set FAT entry content
        pop     hl
        pop     bc
        dec     bc
        ld      a,b
        or      c
        jr      nz,A4F2D
        ld      bc,00FFFH               ; chain endmarker
        call    A4221                   ; set FAT entry content
        dec     de
        ld      a,1
        ld      (de),a                  ; FAT changed
        pop     hl
        push    hl
        call    A41F4                   ; get FAT entry content
        pop     bc
        ld      a,c
        or      b
        jr      nz,A4F94
        ld      (iy+26),l
        ld      (iy+27),h               ; start cluster of file
A4F94:  ex      de,hl
        pop     bc
        ld      (hl),c
        inc     hl
        ld      (hl),b
        ex      de,hl
        ret

;       Subroutine      release cluster chain
;       Inputs
;       Outputs         ________________________

A4F9B:  ld      bc,0

;       Subroutine      set cluster entry and release rest of cluster chain
;       Inputs
;       Outputs         ________________________

A4F9E:  call    XF2A9
        push    hl
        call    A41F4                   ; get FAT entry content
        ex      (sp),hl
        call    A4221                   ; set FAT entry content
        pop     hl
        ld      a,h
        or      l
        ret     z
        ld      a,h
        cp      00FH
        jr      c,A4F9B
        ld      a,l
        cp      0F8H
        jr      c,A4F9B                 ; not end of chain, release
        ret

;       Subroutine      BDOS 11 (search for first)
;       Inputs
;       Outputs         ________________________

A4FB8:  call    A42A5                   ; validate FCB, clear S2 and find direntry
A4FBB:  jr      c,A5000                 ; error, quit
        ld      a,(YF2B8)
        jr      z,A4FC4                 ; file, save direntry number for search next
        ld      a,0FFH                  ; device, flag search next invalid
A4FC4:  ld      (YF30B),a
        ld      (YF309),ix              ; save pointer to DPB
        ld      de,(YF23D)              ; transferaddress
        ld      a,(YF2E1)               ; current driveid
        inc     a
        ld      (de),a
        inc     de
        ld      a,(hl)
        cp      005H
        jr      nz,A4FDC
        ld      (hl),0E5H
A4FDC:  ld      bc,32
        call    XF1D9                   ; transfer direntry to DOS memory (?? LDIR is also sufficient)
        call    A4439                   ; get max record and extent
        ld      a,(YF30C)
        cp      b                       ; orginal FCB EX byte same as max extent ?
        jr      z,A4FEF                 ; same, RC = max record
        jr      nc,A5000                ; bigger, quit with error
        ld      c,080H                  ; smaller, RC = 128 (means extend is full)
A4FEF:  ld      hl,(YF23D)              ; transferaddress
        ld      de,0000CH
        add     hl,de
        ld      b,(hl)                  ; MS-DOS fileattribute
        ld      (hl),a                  ; EX = orginal FCB EX byte (CP/M: requested extent)
        inc     hl
        ld      (hl),b                  ; S1 = MS-DOS fileattribute (CP/M: reserved)
        inc     hl
        ld      (hl),d                  ; S2 = 0 (CP/M: extent high byte)
        inc     hl
        ld      (hl),c                  ; RC = (CP/M: recordcount)
        xor     a                       ; CP/M direntry 0, no error
        ret

A5000:  ld      a,0FFH
        ld      (YF30B),a               ; search for next invalid
        ret

;       Subroutine      BDOS 12 (search for next)
;       Inputs
;       Outputs         ________________________

A5006:  call    A440E                   ; validate FCB drive and filename
        jr      c,A5000                 ; invalid,
        ld      a,(YF30B)               ; saved direntrynumber of last search first
        cp      0FFH
        jr      z,A5000                 ; flag search next invalid, quit with error
        ld      (YF2B8),a
        ld      ix,(YF309)              ; saved pointer to DPB
        call    A42BC                   ; find next directoryentry
        jr      A4FBB                   ; finish

;       Subroutine      BDOS 23 (compute filesize)
;       Inputs
;       Outputs         ________________________

A501E:  call    A42A5                   ; validate FCB, clear S2 and find direntry
        ld      a,0FFH
        ret     c                       ; error, quit
        push    de
        pop     ix
        ld      a,(iy+28)
        ld      c,(iy+29)
        ld      b,(iy+30)
        ld      e,(iy+31)
        add     a,a
        rl      c
        rl      b
        rl      e                       ; convert filesize to random record
        or      a                       ; filesize a multiply of 128 ?
        jr      z,A5043
        inc     bc
        ld      a,b
        or      c
        jr      nz,A5043
        inc     e                       ; nope, increase random record
A5043:  ld      (ix+33),c
        ld      (ix+34),b
        ld      (ix+35),e               ; set R2,R1 and R0
        xor     a
        ret                             ; quit without error

;       Subroutine      BDOS 18 (return bitmap of logged-in drives)
;       Inputs
;       Outputs         ________________________

A504E:  ld      a,(YF347)
        ld      b,a
        xor     a
A5053:  scf
        rla
        djnz    A5053                   ; all drives all online
        ret

;       Subroutine      BDOS 1A (set DMA address)
;       Inputs
;       Outputs         ________________________

A5058:  ld      (YF23D),de              ; set transferaddress
        ret

;       Subroutine      BDOS 1B (MSXDOS get allocation)
;       Inputs
;       Outputs         ________________________

A505D:  xor     a
        ld      (YF306),a               ; no CP/M call
        ld      a,e
        call    A4427                   ; validate fcb driveid
        ld      a,0FFH
        ret     c                       ; error, quit
        call    A44DB                   ; get latest FAT
        ld      e,(ix+19)
        ld      d,(ix+20)
        push    de
        pop     iy                      ; pointer to FAT buffer of drive
        ld      hl,2                    ; start at clusterentry 2
        ld      b,h
        ld      c,h                     ; free cluster = 0
        ld      e,(ix+14)
        ld      d,(ix+15)
        dec     de                      ; number of clusters on disk
        push    de
A5081:  push    de
        push    hl
        call    A41F4                   ; get FAT entry content
        pop     hl
        pop     de
        jr      nz,A508B
        inc     bc                      ; free clusters + 1
A508B:  inc     hl
        dec     de
        ld      a,e
        or      d
        jr      nz,A5081                ; next cluster
        ld      h,b
        ld      l,c                     ; number of free clusters
        pop     de                      ; number of clusters
        ld      a,(ix+6)
        inc     a                       ; number of sectors per cluster
        ld      c,(ix+2)
        ld      b,(ix+3)                ; sectorsize
        ret

;       Subroutine      BDOS 0D (reset discs)
;       Inputs
;       Outputs         ________________________

A509F:  ld      hl,00080H
        ld      (YF23D),hl              ; default transferaddress
        xor     a
        ld      (YF247),a               ; default driveid 0 (A:)
        call    A472D                   ; flush datasector buffer
        ld      hl,YF355
        ld      a,(YF347)               ; all drives
A50B2:  ld      e,(hl)
        inc     hl
        ld      d,(hl)                  ; pointer to DPB
        inc     hl
        push    hl
        push    af
        push    de
        pop     ix
        call    A45C4                   ; flush FAT buffer
        pop     af
        pop     hl
        dec     a
        jr      nz,A50B2                ; next drive
        ret

;       Subroutine      BDOS 25 (return current drive)
;       Inputs
;       Outputs         ________________________

A50C4:  ld      a,(YF247)
        ret

;       Subroutine      BDOS 34 (update random access pointer)
;       Inputs
;       Outputs         ________________________

A50C8:  call    A4EF8                   ; get recordnumber from CR,EX and S2 field
        ld      (iy+33),l
        ld      (iy+34),h
        ld      (iy+35),e
        ret

;       Subroutine      BDOS 0E (select disc)
;       Inputs
;       Outputs         ________________________

A50D5:  ld      a,(YF347)
        cp      e
        ret     c
        ret     z
        ld      hl,YF247
        ld      (hl),e
        ret

;       Subroutine      BDOS 0A (buffered console input)
;       Inputs
;       Outputs         ________________________

A50E0:  push    de
        ld      a,(YF237)
        ld      (YF238),a               ; save current console columnpos to record start of inputline
        xor     a
        ld      (YF239),a               ; not in insertmode
        ld      h,d
        ld      l,e
        ld      b,a
        ld      c,(hl)                  ; size of buffer
        inc     hl
        ld      d,a
        ld      e,(hl)                  ; length of line already in buffer
        inc     hl
        ld      ix,YCONTP
        ld      a,e
        cp      c                       ; is lengthbyte valid ?
        jr      nc,A5103
        push    hl                      ; length smaller than size of buffer
        add     hl,de
        ld      a,(hl)
        pop     hl
        cp      00DH                    ; then line must be terminated by a CR
A5101:  jr      z,A5104                 ; it is, use the line in buffer as basis
A5103:  ld      e,d                     ; use empty line as basis

; linputinput headloop, also lineinput CTRL-F

A5104:  call    XF2AC                   ; hook
        call    A544E                   ; BDOS 8 (direct input)
A510A:  push    hl
        push    bc
        ld      hl,T5374
        ld      bc,NKEYNT               ; number of keyentries
        cpir
        add     hl,bc
        add     hl,bc
        add     hl,bc
        ld      c,(hl)
        inc     hl
        ld      h,(hl)
        ld      l,c
        pop     bc
        ex      (sp),hl
        ret

; lineinput CTRL-A, MSX graphic header

A511E:  call    A544E                   ; BDOS 8 (direct input)
        cp      040H
        jr      c,A510A
        cp      060H
        jr      nc,A510A
        push    af
        ld      a,b
        inc     a
        cp      c
        jr      nc,A515E                ; beep
        ld      a,1
        ld      (ix+0),a
        inc     ix
        inc     b
        call    A535D
        pop     af


; lineinput, normal key action

A513B:  push    af
        ld      a,b
        cp      c
        jr      nc,A515E                ; beep
        pop     af
        ld      (ix+0),a
        inc     ix
        inc     b
        call    A535D
        ld      a,(YF239)
        or      a                       ; insertmode ?
        jr      nz,A5104                ; yep,
        inc     d
        ld      a,e
        cp      d
        jr      c,A5104
        ld      a,(hl)
        dec     a
        inc     hl
        jr      nz,A5104
        inc     d
        inc     hl
        jr      A5104

A515E:  pop     af
        ld      a,007H                  ; bell
        call    A53A8                   ; console output
        jr      A5104

; lineinput UP key, ESC key, CTRL-U (VOID)

A5166:  pop     de
        ld      a,(YF238)
        ld      b,a
        ld      a,(YF237)
        sub     b                       ; length of the inputline
        jr      z,A5177                 ; empty inputline, restart line input
        ld      b,a
A5172:  call    A534F
        djnz    A5172
A5177:  jp      A50E0                   ; restart lineinput

; lineinput CTRL-J

A517A:  ld      a,b
        ld      (YF23A),a               ; store current linelength (for secret message)
        call    A5183                   ; newline
A5181:  jr      A5104

A5183:  ld      a,00DH
        call    A53A8                   ; console output
        ld      a,00AH
        jp      A53A8                   ; console output

; lineinput CR key

A518D:  pop     de
A518E:  call    A53A8                   ; console output
        push    de
        inc     de
        ld      a,b
        ld      (de),a
        cp      c
        push    af
        inc     de
        ld      c,b
        xor     a
        ld      b,a
        or      c
        jr      z,A51A3
        ld      hl,YCONTP
        ldir
A51A3:  pop     af
        jr      z,A51A9
        ld      a,00DH
        ld      (de),a
A51A9:  pop     de
        ret

; lineinput LEFT key, BS key (BS)

A51AB:  ld      a,(YF23A)
        and     b
        cp      07FH
        jp      z,A5244                 ; secret programmers message
        inc     b
        dec     b
        jr      z,A51DC
        dec     b
        dec     ix
        call    A534F
        inc     b
        dec     b
        jr      z,A51CE
        dec     b
        dec     ix
        ld      a,(ix+0)
        dec     a
        jr      z,A51DC
        inc     b
        inc     ix
A51CE:  ld      a,(ix+0)
        cp      020H
        jr      nc,A51DC
        cp      009H
        jr      z,A51FB
        call    A534F
A51DC:  ld      a,(YF239)
        or      a                       ; insertmode ?
        jr      nz,A5181                ; yep,
        inc     d
        dec     d
        jr      z,A5181
        dec     d
        ld      a,d
        cp      e
        jr      nc,A5181
        dec     hl
        ld      a,d
        cp      001H
        jr      c,A5181
        dec     hl
        ld      a,(hl)
        dec     a
        inc     hl
        jr      nz,A5181
        dec     d
        dec     hl
        jr      A5181

A51FB:  push    hl
        push    bc
        ld      a,(YF238)
        ld      c,a                     ; start of the inputline
        inc     b
        dec     b
        jr      z,A521A
        ld      hl,YCONTP
A5208:  ld      a,(hl)
        inc     hl
        cp      001H
        jr      z,A5218
        inc     c
        cp      020H
        jr      nc,A5218
        cp      009H
        jr      z,A522A
        inc     c
A5218:  djnz    A5208
A521A:  ld      a,(YF237)               ; current console columnpos
        sub     c
        jr      z,A5226
        ld      b,a
A5221:  call    A534F
        djnz    A5221
A5226:  pop     bc
        pop     hl
        jr      A51DC

A522A:  ld      a,c
        add     a,007H
        and     0F8H
        ld      c,a
        jr      A5218

; lineinput INS key (INSERT)

A5232:  ld      a,(YF239)
        xor     001H
        jr      A523E                   ; toggle insertmode

; unused code

        xor     a
        jr      A523E

; unused code

        ld      a,001H

A523E:  ld      (YF239),a
        jp      A5104

;       Subroutine      display message of programmer (not needed)
;       Inputs
;       Outputs
;       Remark          activated by:
;                       input 127 or 255 chars, press CTRL-J, press BS or LEFT

A5244:  xor     a
        ld      (YF23A),a
        push    bc
        ld      b,16
        ld      de,T547D
        ld      hl,0
A5251:  push    hl
        call    A4ED2                   ; get decoded characterpair
        add     a,020H
        call    A53A8                   ; console output
        ld      a,h
        add     a,020H
        call    A53A8                   ; console output
        pop     hl
        inc     hl
        djnz    A5251
        pop     bc

; lineinput HOME key (NEWLINE)

A5265:  ld      a,040H
        pop     de
        call    A518E
        call    A5183                   ; newline
        ld      a,(YF238)
        or      a                       ; start of the inputline at the begin of a line ?
        jp      z,A50E0                 ; yep, restart lineinput routine
        ld      b,a
        ld      a," "
A5278:  call    A53A8                   ; console output
        djnz    A5278
        jp      A50E0                   ; restart lineinput routine

; lineinput DOWN key (COPYALL)

A5280:  ld      a,0FFH
        jr      A52B5

; lineinput CTRL-L (SKIPUP)

A5284:  call    A52E3
        jp      c,A5104
        push    bc
        ld      c,a
        ld      b,000H
        add     hl,bc
        pop     bc
        add     a,d
        ld      d,a
        jp      A5104

; lineinput SELECT key (COPYUP)

A5295:  call    A52E3
        jp      c,A5104
        jr      A52B5

; lineinput DEL key (SKIP1)

A529D:  ld      a,d
        cp      e
        jp      nc,A5104
        inc     d
        ld      a,(hl)
        dec     a
        inc     hl
        jp      nz,A5104
        inc     d
        inc     hl
        jp      A5104

; lineinput RIGHT key (COPY1)

A52AE:  ld      a,(hl)
        dec     a
        ld      a,001H
        jr      nz,A52B5
        inc     a
A52B5:  push    af
        xor     a
        ld      (YF239),a               ; insertmode off
        ld      a,b
        cp      c
        jr      nc,A52DF
        ld      a,d
        cp      e
        jr      nc,A52DF
        ld      a,(hl)
        cp      001H
        jr      nz,A52CD
        ld      a,b
        inc     a
        cp      c
        jr      nc,A52DF
        ld      a,(hl)
A52CD:  inc     hl
        ld      (ix+0),a
        inc     ix
        call    A535D
        inc     b
        inc     d
        pop     af
        dec     a
        jr      nz,A52B5
        jp      A5104

A52DF:  pop     af
        jp      A5104

A52E3:  call    A544E                   ; BDOS 8 (direct input)
        cp      001H
        jr      nz,A531F
        call    A544E                   ; BDOS 8 (direct input)
        cp      040H
        jr      c,A531F
        cp      060H
        jr      nc,A531F
        push    hl
        push    de
        push    bc
        ld      iy,00000H
A52FC:  scf
        push    af
        ld      a,001H
        call    A531F
        jr      c,A531A
        ld      c,a
        ld      b,000H
        add     hl,bc
        add     a,d
        ld      d,a
        push    iy
        pop     af
        add     a,c
        push    af
        pop     iy
        inc     hl
        pop     af
        cp      (hl)
        dec     hl
        jr      nz,A52FC
        push    iy
A531A:  pop     af
        pop     bc
        pop     de
        pop     hl
        ret

A531F:  push    bc
        push    af
        ld      a,e
        sub     d
        jr      c,A534B
        jr      z,A534B
        dec     a
        jr      z,A534B
        ld      c,a
        ld      b,000H
        pop     af
        push    hl
        push    af
        ld      a,(hl)
        dec     a
        jr      nz,A5336
        inc     hl
        dec     c
A5336:  pop     af
        inc     c
        dec     c
        jr      nz,A533F
        pop     hl
        pop     bc
        scf
        ret

A533F:  inc     hl
        cpir
        pop     hl
        jr      nz,A534C
        ld      a,e
        sub     d
        dec     a
        sub     c
        pop     bc
        ret

A534B:  pop     af
A534C:  pop     bc
        scf
        ret

A534F:  ld      a,008H
        call    A53A8                   ; console output
        ld      a,020H
        call    A53A8                   ; console output
        ld      a,008H
        jr      A53A8                   ; console output

A535D:  cp      020H
        jr      nc,A53A8                ; console output
        cp      009H
        jr      z,A53A8                 ; console output
        cp      001H
        jr      z,A53A8                 ; console output
        push    af
        ld      a,"^"
        call    A53A8                   ; console output
        pop     af
        or      040H
        jr      A53A8                   ; console output

; keytable lineinput
; first table contains all keycodes, code 8 at the end is a fake one for 'other key', because it is already in the table
; second table contains all serviceroutines, but in reserve order (so last one belongs to the first keycode)

T5374:  defb    006H,07FH,008H,00DH,00AH,015H,00BH,00CH
        defb    01BH,012H,018H,01CH,01DH,01EH,01FH,001H
        defb    008H

        defw    A513B
        defw    A511E,A5280,A5166,A51AB,A52AE,A5295,A5232,A5166
        defw    A5284,A5265,A5166,A517A,A518D,A51AB,A529D,A5104

NKEYNT  equ     ($-T5374)/3


;       Subroutine      BDOS 02 (console output)
;       Inputs
;       Outputs         ________________________

A53A7:  ld      a,e
A53A8:  call    XF2AF
        cp      00BH
        jr      z,A53E8
        cp      00CH
        jr      z,A53E8
        cp      01CH
        jr      z,A53D5
        cp      01DH
        jr      z,A53F0
        cp      00DH
        jr      z,A53E8
        cp      008H
        jr      z,A53F0
        cp      009H
        jr      z,A53F8
        cp      07FH
        jr      z,A53F0
        cp      020H
        jr      c,A53D5
        push    hl
        ld      hl,YF237
        inc     (hl)                    ; increase console columnpos
        pop     hl
A53D5:  push    bc
        ld      b,a
        call    A5412
        ld      a,b
        call    A408F                   ; output to screen
        ld      a,(YF23B)
        or      a                       ; console output also to printer ?
        ld      a,b
        pop     bc
        ret     z                       ; nope, quit
        jp      A409B                   ; output to printer

A53E8:  push    af
        xor     a
        ld      (YF237),a               ; console columpos
        pop     af
        jr      A53D5

A53F0:  push    hl
        ld      hl,YF237
        dec     (hl)                    ; decrease console columnpos
        pop     hl
        jr      A53D5

A53F8:  ld      a," "
        call    A53A8                   ; console output
        ld      a,(YF237)
        and     007H
        jr      nz,A53F8                ; to the next console tabposition
        ret

A5405:  cp      010H                    ; CTRL-P ?
        jr      z,A541D                 ; yep, handle it
        cp      00EH                    ; CTRL-N ?
        jr      z,A541D                 ; yep, handle it
        cp      003H                    ; CTRL-C ?
        jr      z,A541D                 ; yep, handle it
        ret                             ; nope, quit

A5412:  call    A4034                   ; check if keyboardinput available
        ret     z                       ; nope, quit
        cp      013H                    ; CTRL-S ?
        jr      nz,A5405                ; nope, check other specials
        call    A4078                   ; get keyboardinput (the CTRL-S)
                                        ; next wait for other consoleinput
A541D:  call    A4078                   ; get keyboardinput
        cp      010H
        jr      z,A5431                 ; CTRL-P, enable printer output
        cp      00EH
        jr      z,A5437                 ; CTRL-N, disable printer output
        cp      003H                    ; CTRL-C ?
        ret     nz                      ; nope, quit
        ld      hl,(YF325)
        jp      XF1E8                   ; start abort handler in DOS memory

A5431:  ld      a,1
        ld      (YF23B),a
        ret

A5437:  xor     a
        ld      (YF23B),a
        ret

;       Subroutine      BDOS 0B (console status)
;       Inputs
;       Outputs         ________________________

A543C:  call    A5412
        ld      a,000H
        ret     z
        or      0FFH
        ret

;       Subroutine      BDOS 01 (console input)
;       Inputs
;       Outputs         ________________________

A5445:  call    A544E                   ; BDOS 8 (direct input)
        push    af
        call    A53A8                   ; console output
        pop     af
        ret

;       Subroutine      BDOS 08 (direct input)
;       Inputs
;       Outputs         ________________________

A544E:  call    A541D
        jr      z,A544E
        ret

;       Subroutine      BDOS 06 (direct console i/o)
;       Inputs          A=0FFH for console input, A<>0FFH for console output
;       Outputs         A=input (console input)

A5454:  ld      a,e
        cp      0FFH                    ; console input ?
        jp      nz,A408F                ; console output, output to screen and quit
        call    A4034                   ; check if keyboardinput available
        jp      nz,A4078                ; yep, get keyboardinput and quit
        xor     a
        ret

;       Subroutine      BDOS 07 (MSXDOS direct input)
;       Inputs
;       Outputs         ________________________

A5462:  jp      A4078                   ; get keyboardinput

;       Subroutine      BDOS 05 (printer output)
;       Inputs
;       Outputs         ________________________

A5465:  ld      a,e
A5466:  push    af
        call    A5412
        pop     af
        jp      A409B                   ; output to printer

;       Subroutine      BDOS 03 (auxiliary input)
;       Inputs
;       Outputs         ________________________

A546E:  call    A5412
        jp      XF371

;       Subroutine      BDOS 04 (auxiliary output)
;       Inputs
;       Outputs         ________________________

A5474:  ld      a,e
A5475:  push    af
        call    A5412
        pop     af
        jp      XF374

; Programmers message, decoded in FAT entries (not needed)
; MSXDOS BY T PATERSON J SUZUKI   @

T547D:  defb    0EDH,08CH,093H,0EFH,00CH,088H,039H,040H
        defb    003H,070H,048H,097H,0F2H,0FCH,0BAH,080H
        defb    00AH,0CCH,0B5H,05EH,0AFH,029H,000H,000H

; unused code

        ret

A5496:  call    XF2B2
        call    A54C0                   ; get time and date values
        ld      a,c
        add     a,a
        add     a,a
        add     a,a
        rl      b
        add     a,a
        rl      b
        add     a,a
        rl      b
        srl     d
        or      d
        ld      e,a
        ld      d,b
        ld      bc,(YF249)
        ld      a,c
        add     a,a
        add     a,a
        add     a,a
        add     a,a
        add     a,a
        rl      b
        ld      c,a
        ld      a,(YF248)               ; current day
        or      c
        ld      c,a
        ret

A54C0:  call    A4179                   ; get date and time
        jr      c,A550B                 ; from clockchip,
        push    de
        push    hl
        ld      de,(YF24C)              ; days since 1-1-1980
        or      a
        sbc     hl,de
        pop     hl
        pop     de
        ret     z
        ld      (YF24C),hl
        push    bc
        push    de
        ld      c,l
        ld      b,h
        ld      de,4*365+1
        call    A492F                   ; divide
        ld      a,c
        add     a,a
        add     a,a
        add     a,a
        ld      b,000H
        ld      de,T5534
        call    A5515
        srl     a
        jr      nc,A54F2
        ld      de,200
        add     hl,de
A54F2:  call    A5523                   ; setup days in februari
        ld      a,001H
        ld      de,YF22B
        call    A5515
        ld      (YF249),a
        inc     l
        ld      a,l
        ld      (YF248),a               ; current day
A5505:  call    A5588
        pop     de
        pop     bc
        ret

A550B:  push    bc
        push    de
        ld      hl,(YF24A)
        call    A559D                   ; calculate days since 1-1-1980
        jr      A5505

A5515:  ex      de,hl
        ld      c,(hl)
        inc     hl
        ex      de,hl
        or      a
        sbc     hl,bc
        jr      c,A5521
        inc     a
        jr      A5515

A5521:  add     hl,bc
        ret

A5523:  call    XF2B5
        ld      (YF24A),a               ; year (offset)
A5529:  and     003H
        ld      a,28
        jr      nz,A5530
        inc     a
A5530:  ld      (YF22B+1),a
        ret

T5534:  defb    200,166,200,165,200,165,200,165

;       Subroutine      BDOS 2A (MSXDOS get date)
;       Inputs
;       Outputs         ________________________

A553C:  xor     a
        ld      (YF306),a               ; no CP/M call
        call    A54C0                   ; get time and date values
        ld      hl,(YF24A)
        ld      de,1980
        add     hl,de
        ld      de,(YF248)              ; current day and month
        ld      a,(YF24E)
        ret

;       Subroutine      BDOS 2B (set date)
;       Inputs
;       Outputs         ________________________

A5552:  ld      bc,-1980
        add     hl,bc
        jr      nc,A559A                ; year <1980, error
        ld      a,h
        or      a
        jr      nz,A559A                ; yearoffset not in 1 byte, error
        ld      a,l
        cp      120
        jr      nc,A559A                ; year >2099, error
        call    A5529                   ; setup febuari days
        inc     e
        dec     e
        jr      z,A559A                 ; day 0, error
        ld      a,d
        or      a
        jr      z,A559A                 ; month 0, error
        cp      12+1
        jr      nc,A559A                ; month >12, error
        push    hl
        ld      hl,YF22B-1
        add     a,l
        ld      l,a
        jr      nc,A5579
        inc     h
A5579:  ld      a,(hl)                  ; days in month
        pop     hl
        cp      e
        jr      c,A559A                 ; invalid day, error
        ld      (YF248),de              ; current day and month
        call    A559D                   ; calculate days since 1-1-1980
        call    A4115                   ; store date (clockchip or otherwise)
A5588:  ld      bc,(YF24C)              ; days since 1-1-1980
        ld      de,7
        inc     bc
        inc     bc
        call    A492F                   ; divide
        ld      a,l
        ld      (YF24E),a
        xor     a
        ret

A559A:  ld      a,0FFH
        ret

A559D:  ld      a,l                     ; year (offset)
        call    A5523                   ; setup days in februari
        ld      c,l
        srl     c
        srl     c                       ; /4
        ld      b,0
        ld      de,4*365+1
        call    A4916                   ; multiply
        ld      l,c
        ld      h,b
        ld      a,(YF24A)               ; year (offset)
        and     003H
        add     a,a
        ld      de,T5534
        ld      b,0
        inc     a
        call    A55D2
        ld      de,YF22B
        ld      a,(YF249)               ; current month
        call    A55D2
        ld      a,(YF248)               ; current day
        dec     a
        ld      c,a
        add     hl,bc
        ld      (YF24C),hl              ; days since 1-1-1980
        ret

A55D2:  dec     a
        ret     z
        ex      de,hl
        ld      c,(hl)
        inc     hl
        ex      de,hl
        add     hl,bc
        jr      A55D2

;       Subroutine      BDOS 2C (MSXDOS get time)
;       Inputs
;       Outputs         ________________________

A55DB:  xor     a
        ld      (YF306),a               ; no CP/M call
        call    A54C0                   ; get time and date values
        ld      h,b
        ld      l,c
        xor     a
        ret

;       Subroutine      BDOS 2D (set time)
;       Inputs
;       Outputs         ________________________

A55E6:  ld      b,h
        ld      c,l
        ld      a,b
        cp      24
        jr      nc,A559A
        ld      a,59
        cp      c
        jr      c,A559A
        cp      d
        jr      c,A559A
        ld      a,e
        cp      100
        jr      nc,A559A
        call    A4130                   ; store time (clockchip or otherwise)
        xor     a
        ret

;       Subroutine      BDOS 2E (set verify flag)
;       Inputs
;       Outputs         ________________________

A55FF:  ld      a,e
        ld      (RAWFLG),a
        ret

;       Subroutine      Validate FCB filename
;       Inputs          HL = address of FCB+1,DE = destination
;       Outputs         ________________________
;       Remark          is copied to 0F1F4H

A5604:  ld      a,(hl)
        cp      " "
        scf
        ret     z                       ; filename that start with a space is illegal, quit
        ld      bc,00802H               ; first do the filename, then the fileextension
        cp      0E5H
        jr      nz,A5622                ; not the charcode also used as deleted file marker
        ld      a,005H
        ld      (de),a
        inc     hl
        inc     de
        dec     b                       ; use replacement charcode 005H, otherwise fileentry looks deleted
        ld      a,0E5H
        call    A5681                   ; is this a double byte 'header' char ?
        jr      nc,A5622                ; nope, no special action
        ld      a,(hl)
        ld      (de),a
        inc     hl
        inc     de
        dec     b                       ; yep, copy 'follow' char
A5622:  ld      a,(hl)
        call    A5681                   ; is this a double byte 'header' char ?
        jr      nc,A5631                ; nope, do upcasing and check
        ld      (de),a
        inc     hl
        inc     de                      ; copy 'header' char
        dec     b
        scf
        ret     z                       ; no 'follow' char, quit with error
        ld      a,(hl)
        jr      A5667                   ; copy 'follow' char and continue

A5631:  ld      a,(YF30E)
        and     a
        ld      a,(hl)
        jr      z,A564C                 ; japanese have no accent chars,
        cp      080H
        jr      c,A564C                 ; normal ASCII,
        cp      0BAH
        jr      nc,A564C
        push    hl                      ; 080H-0B9H accent chars
        push    bc
        ld      c,a
        ld      b,000H
        ld      hl,T5696-080H
        add     hl,bc
        ld      a,(hl)                  ; get the upcase version of the accent char
        pop     bc
        pop     hl
A564C:  cp      "a"
        jr      c,A5656
        cp      "z"+1
        jr      nc,A5656
        sub     020H                    ; lowercase char, make upcase
A5656:  cp      020H
        ret     c                       ; control code are illegal, quit with error
        push    hl
        push    bc
        ld      hl,T5677
        ld      bc,0000AH
        cpir                            ; one of the illegal chars ?
        pop     bc
        pop     hl
        scf
        ret     z                       ; yep, quit with error
A5667:  ld      (de),a                  ; copy char
        inc     hl
        inc     de
        djnz    A5622                   ; next char
        ld      b,003H
        dec     c
        jr      nz,A5622                ; now do the fileextension
        or      a                       ; flag no error
        ld      a,(hl)
        ld      (YF30C),a               ; save the FCB EX byte
        ret

T5677:  defb    '."/[]:+=;,'

;       Subroutine      check if double byte header char
;       Inputs          ________________________
;       Outputs         ________________________

A5681:  push    hl
        ld      hl,YF30F
        cp      (hl)
        ccf
        jr      nc,A5694                ; below (F30F), quit (not in range)
        inc     hl
        cp      (hl)
        jr      c,A5694                 ; below (F310), quit (in range 1)
        inc     hl
        cp      (hl)
        ccf
        jr      nc,A5694                ; below (F311), quit (not in range)
        inc     hl
        cp      (hl)
A5694:  pop     hl
        ret

;       Table 080H-0B9H accent upcase chars

T5696:  defb    080H,09AH,"E" ,"A" ,08EH,"A" ,08FH,080H
        defb    "E" ,"E" ,"E" ,"I" ,"I" ,"I" ,08EH,08FH
        defb    090H,092H,092H,"O" ,099H,"O" ,"U" ,"U"
        defb    "Y" ,099H,09AH,09BH,09CH,09DH,09EH,09FH
        defb    "A" ,"I" ,"O" ,"U" ,0A5H,0A5H,0A6H,0A7H
        defb    0A8H,0A9H,0AAH,0ABH,0ACH,0ADH,0AEH,0AFH
        defb    0B0H,0B0H,0B2H,0B2H,0B4H,0B4H,0B6H,0B6H
        defb    0B8H,0B8H

;       Subroutine      unsupported CP/M BDOS calls
;       Inputs
;       Outputs         ________________________

A56D0:  xor     a
        ld      b,a
        ret

;       Subroutine      BDOS handler (for DiskBASIC)
;       Inputs
;       Outputs         ________________________

C56D3:  LD      A,1
        LD      (YF306),A
        LD      A,C
        CP      31H
        JR      NC,A56D0
        CP      11H
        JR      NZ,J56E5
        LD      (YF307),DE
J56E5:  CP      12H
        jr      nz,A56ED
        ld      de,(YF307)              ; yep, get saved address FCB Search First
A56ED:  push    hl
        ld      hl,T5700
        ex      (sp),hl                 ; after BDOS routine, fill HL in a CP/M compatible manner
        push    hl
        ld      hl,T570D
        ld      b,0
        add     hl,bc
        add     hl,bc
        ld      b,(hl)
        inc     hl
        ld      h,(hl)
        ld      l,b
        ex      (sp),hl
        ret                             ; start BDOS routine

T5700:  push    af
        ld      a,(YF306)
        or      a                       ; CP/M compatible call
        jr      z,A570B                 ; no, leave HL alone
        pop     af
        ld      l,a
        ld      h,b                     ; CP/M compatible HL
        ret

A570B:  pop     af
        ret

T570D:  defw    A40A7,A5445,A53A7,A546E,A5474,A5465,A5454,A5462
        defw    A544E,XF1C9,A50E0,A543C,A41EF,A509F,A50D5,A4462
        defw    A456F,A4FB8,A5006,A436C,A4775,A477D,A461D,A4392
        defw    A504E,A50C4,A5058,A505D,A56D0,A56D0,A56D0,A56D0
        defw    A56D0,A4788,A4793,A501E,A50C8,A56D0,A47BE,A47B2
        defw    A47D1,A56D0,A553C,A5552,A55DB,A55E6,A55FF,A46BA
        defw    A4720

A576F:  call    INIHRD                  ; initialize diskhardware
        di
        ld      a,(DEVICE)
        and     a                       ; abort disksystem init ?
        ret     m                       ; yep, quit
        jp      nz,A580C                ; disksystem init already started by an other diskrom, skip init
        ld      hl,HOKVLD
        bit     0,(hl)                  ; EXTBIO hook valid ?
        jr      nz,A578E
        set     0,(hl)
        ld      hl,EXTBIO
        ld      b,3*5
A5789:  ld      (hl),0C9H
        inc     hl
        djnz    A5789                   ; nop, init EXTBIO,DISINT and ENAINT hooks
A578E:  ld      hl,(BOTTOM)
        ld      de,0C001H
        rst     020H                    ; at least 16Kb RAM ?
        jr      nc,A57A3                ; nop, abort
        ld      a,006H
        call    SNSMAT
        di
        rrca                            ; SHIFT key pressed ?
        jr      c,A57A9                 ; nop, cont
        ld      a,007H
        rst     018H                    ; beep
A57A3:  ld      a,0FFH
        ld      (DEVICE),a              ; flag abort disksystem init
        ret

;       Subroutine      Initialize disksystem, first diskrom

A57A9:  ld      hl,0F380H+MYSIZE
        ld      de,XF1C9
        and     a
        sbc     hl,de                   ; bytes needed for static workarea+workarea driver
        call    nc,C5EE3                ; allocate memory (adjust BASIC areapointers)
        ret     c                       ; failed, quit
A57B6:  push    hl
        ld      hl,XF1C9-0F380H
        ld      bc,XF1C9
A57BD:  xor     a
        ld      (bc),a
        inc     bc
        inc     hl
        ld      a,l
        or      h
        jr      nz,A57BD                ; clear static workarea
        ld      (AUTLIN),hl             ; biggest sectorsize sofar = 0
        ld      b,4*2+4*3
        ld      hl,YFB21
A57CD:  ld      (hl),a
        inc     hl
        djnz    A57CD                   ; clear DRVTBL, DRVINT
        ld      hl,XF24F
        ld      b,069H
A57D6:  ld      (hl),0C9H
        inc     hl
        djnz    A57D6                   ; init disksystem hooks
        ld      a,0DBH
        ld      hl,0C9A8H
        ld      (XF365+0),a
        ld      (XF365+1),hl            ; read primairy slotregister entry
        ld      a,006H
        call    SNSMAT
        and     002H
        ld      (YF33F),a               ; saved CTRL key status for panthom drive
        ld      a,007H
        rst     018H                    ; beep
        ld      hl,T5807
        ld      de,H.RUNC
        ld      bc,5
        ldir
        call    A402D
        ld      (H.RUNC+1),a            ; init RUNC hook, to intialize further when the interpeter is initialized
        pop     de                      ; base diskdriver workarea
        jr      A5825

T5807:  rst     030H
        defb    0
        defw    A5897
        ret

;       Subroutine      Initialize disksystem, not the first diskrom

A580C:  ld      hl,YFB21                ; DRVTBL
        ld      b,4                     ; 4 diskroms
        xor     a
A5812:  add     a,(hl)
        jp      c,J5EC7                 ; invalid DRVTBL, error
        inc     hl
        inc     hl
        djnz    A5812
        cp      8                       ; 8 or more drives ?
        ret     nc                      ; yep, no more drives!
        ld      hl,MYSIZE               ; number of bytes for workarea driver
        call    C5EE3                   ; allocate memory (adjust BASIC areapointers)
        ret     c                       ; failed, quit
        ex      de,hl

A5825:  call    C5FC8                   ; get my SLTWRK entry
        ld      (hl),e
        inc     hl
        ld      (hl),d                  ; save base workarea in SLTWRK
        ld      hl,(AUTLIN)
        ld      de,SECLEN
        rst     020H                    ; SECLEN sofar big enough ?
        jr      nc,A5838
        ld      (AUTLIN),de             ; nop, adjust
A5838:  ld      de,YFB21                ; DRVTBL
        ld      bc,00400H               ; 4 diskroms
A583E:  ld      a,(de)
        and     a
        jr      z,A584B                 ; free entry, use it
        add     a,c
        ld      c,a
        inc     de
        inc     de
        djnz    A583E                   ; next entry
        jp      J5EC7                   ; none free, error

A584B:  ld      a,(YF33F)
        and     a
        ld      a,c                     ; phantom flag
A5850:  call    DRIVES                  ; query no. of drives
        add     a,l
        cp      9
        ld      a,l                     ; more as 8 drives ?
        jr      c,A585C                 ; nop, ok
        ld      a,8
        sub     c                       ; as much as possible
A585C:  push    bc
        ld      (de),a                  ; save drives
        inc     de
        call    A402D
        ld      (de),a                  ; save slotid diskrom
        pop     bc                      ; drivenumber
        ld      b,0
        ld      hl,YF355
        add     hl,bc
        add     hl,bc                   ; DPBTBL
        push    hl
        dec     de
        ld      a,(de)
        push    af
        ld      c,a                     ; drives
        ld      de,21
        call    A4916                   ; * size of DPB
        ld      l,c
        ld      h,b                     ; number of bytes for the DPBs
        call    C5EC3                   ; allocate memory (adjust BASIC areapointers, halt when error)
        ex      de,hl
        pop     af
        pop     hl
A587E:  ld      (hl),e
        inc     hl
        ld      (hl),d                  ; save in DPBTBL
        inc     hl
        push    hl
        ld      hl,DEFDPB
        ld      bc,21
        ldir                            ; initialize DPB
        pop     hl
        dec     a
        jr      nz,A587E                ; next drive
        call    INIENV                  ; initialize driver workarea
        ld      hl,DEVICE
        inc     (hl)                    ; increase diskdriver count
        ret

;       Subroutine      H.RUNC interceptor
;       Inputs          -
;       Outputs         -
;       Remark          Control is passed to this routine when the BASIC interpreter is initialized
;                       There are two ways: a BASIC program in ROM is started OR at the start of MSX-BASIC

A5897:  ld      hl,H.RUNC
        ld      b,5
A589C:  ld      (hl),0C9H
        inc     hl
        djnz    A589C                   ; clear RUNC hook
        ld      hl,DEVICE
        xor     a
        cp      (hl)
        ld      (hl),a                  ; clear diskinterface count
        ret     p                       ; already cleared, return control
A58A8:  CALL    A402D
        ld      (YF348),a               ; disksystem diskrom slotid
        ld      hl,A7397
        ld      de,XF1C9
        ld      bc,0006EH
        ldir                            ; initialize some static disksystem variables
        ld      hl,M0034
        ld      de,YF30F
        ld      bc,4
        ldir                            ; initialize double byte header char table
        ld      a,(IDBYT0)
        rrca
        rrca
        rrca
        rrca
        and     007H
        ld      (YF30E),a               ; date format
        ld      a,0FFH
        ld      (YF241),a               ; invalid datasector buffer
        ld      (YF246),a               ; invalid directorysector buffer
        ld      (YF24C+1),a             ; days since 1-1-1980 is 65280 (0FF00H) (somewhere in the year 2158), this is inpossible, so when no clockchip this is updated!
        ld      a,00DH
        ld      (YCONBF+130),a          ; ?? end marker con buffer
        ld      a,7
        ld      (YF345),a               ; max number of FCB�s is 7
        ld      hl,1461
        ld      (YF33B),hl              ; default date when no clockchip is 1-1-1984
        ld      b,8
        ld      hl,XF368
A58F0:  ld      (hl),0C3H
        inc     hl
        inc     hl
        inc     hl
        djnz    A58F0                   ; initialize jumptable
        ld      hl,(AUTLIN)
        push    hl                      ; size of the biggest sector
        call    C5EC3                   ; allocate memory (adjust BASIC areapointers, halt when error)
        ld      (_SECBUF),hl            ; allocate sectorbuffer
        pop     hl                      ; size of the biggest sector
        push    hl
        call    C5EC3                   ; allocate memory (adjust BASIC areapointers, halt when error)
        ld      (YF34F),hl              ; allocate datasector buffer
        pop     hl                      ; size of the biggest sector
        call    C5EC3                   ; allocate memory (adjust BASIC areapointers, halt when error)
        ld      (YF351),hl              ; allocate dirsector buffer
        ld      hl,YFB21                ; DRVTBL
        ld      b,4                     ; 4 diskroms
        xor     a
A5916:  add     a,(hl)
        jp      c,J5EC7                 ; invalid DRVTBL, error
        inc     hl
        inc     hl
        djnz    A5916
        cp      9                       ; more as 8 drives ?
        jp      nc,J5EC7                ; yep, error
        ld      (YF347),a               ; drives in system
        ld      b,a                     ; number of drives
        ld      c,0                     ; drive 0
        ld      hl,YF355
A592C:  ld      e,(hl)
        inc     hl
        ld      d,(hl)                  ; DPB of drive
        inc     hl
        push    hl
        push    de
        pop     ix
        ld      (ix+0),c                ; set drivenumber in DPB
        inc     c
        push    bc
        ld      c,(ix+2)
        ld      b,(ix+3)                ; sectorsize
        ld      e,(ix+16)
        ld      d,0                     ; number of sectors per FAT
        call    A4916                   ; * FAT size
        inc     bc                      ; and a FAT buffer flag
        ld      l,c
        ld      h,b                     ; size of the FAT buffer
        call    C5EC3                   ; allocate memory (adjust BASIC areapointers, halt when error)
        ld      (YF349),hl              ; base system bottom sofar
        ld      (hl),0FFH               ; flag invalid FAT buffer
        inc     hl
        ld      (ix+19),l
        ld      (ix+20),h               ; pointer to FAT buffer
        pop     bc
        pop     hl
        djnz    A592C                   ; next drive
        ld      hl,XF327
        ld      (hl),03EH
        inc     hl
        ld      (hl),01AH
        ld      b,2*5-2
A5967:  inc     hl
        ld      (hl),0C9H
        djnz    A5967                   ; initialize MSX-serial hooks
        ld      hl,XF327
        ld      (XF371+1),hl
        ld      hl,XF32C
        ld      (XF374+1),hl
        ld      hl,XF331
        ld      (XF37D+1),hl            ; initialize jumptable
        ld      hl,M7D2F
        ld      a,(EXPTBL+0)
        call    RDSLT
        push    af
        inc     hl
        ld      a,(EXPTBL+0)
        call    RDSLT
        pop     de
        ld      h,a
        ld      l,d                     ; read startup screen address
        push    hl
        pop     ix
        ld      iy,(EXPTBL-1+0)
        call    CALSLT                  ; initialize BASIC screenmode
        call    C40B7                   ; check for and initialize clockchip
        call    C5C69                   ; initialize hooks
        ld      a,(EXPTBL+0)
        ld      (RAMAD0),a
        ld      (RAMAD1),a              ; assume no ram available for page 0 and 1
        call    C5F93
        ld      (RAMAD2),a              ; slotid of current page 2
        call    C5F90
        ld      (RAMAD3),a              ; slotid of current page 3
        ld      c,000H
        call    C5E4D                   ; search ram in page 0
        jr      c,A59C1
        ld      (RAMAD0),a              ; found, set ram slotid page 0
A59C1:  ld      c,040H
        call    C5E4D                   ; search ram in page 1
        jr      c,A59CB
        ld      (RAMAD1),a              ; found, set ram slotid page 1
A59CB:  ld      sp,0C200H               ; switch to a temporary stack, just above temp startbuffer
        ld      a,(H.STKE+0)
        cp      0C9H                    ; STKE hook set ?
        jr      z,A59DB                 ; nop, cont
        ld      ix,M7D17
        jr      A59ED                   ; skip BASIC extension ROMs and transfer control

A59DB:  ld      hl,SLTATR
        ld      b,040H
A59E0:  ld      a,(hl)
        add     a,a                     ; TEXT extension ?
        jr      c,A59E9                 ; yep, start it
        inc     hl
        djnz    A59E0
        jr      A59F3                   ; no TEXT extension ROM found,

A59E9:  ld      ix,M7E14                ; start BASIC program in ROM
A59ED:  call    C5C11                   ; initialize diskbasic
        jp      CALBAS

A59F3:  ld      hl,J5B35
        push    hl                      ; if quit anywhere start diskbasic
        call    C5AE2                   ; read bootsector
        ret     c                       ; failed, start diskbasic
        call    C5AD6                   ; start bootcode with Cx reset (some disk can take control from here)
        ld      hl,(BOTTOM)
        ld      de,08000H
        rst     020H                    ; check if ram on both page 3 and 2
        ret     nz                      ; nope, start diskbasic
        ld      hl,RAMAD0
        ld      a,(EXPTBL+0)
        cp      (hl)
        ret     z                       ; no ram available on page 0, start diskbasic
        inc     hl
        cp      (hl)
        ret     z                       ; no ram available on page 1, start diskbasic

; MSXDOS requirement are met, try starting it

C5A11:  XOR     A
        CALL    C6095                   ; invalidate FAT buffer drive 0
        LD      HL,(YF349)
        LD      (YF34B),HL              ; bottom MSX-DOS system
        CALL    C5AE2                   ; try reading bootsector of drive 0
        JP      C,J5B35                 ; error, start diskbasic
        LD      A,0FFH
        LD      (YF346),A
        LD      A,(RAMAD0)
        LD      H,0
        CALL    C64A0                   ; ENASLT
        XOR     A
        LD      L,A
        LD      H,A
J5A31:  LD      (HL),A
        INC     L
        JR      NZ,J5A31                ; clear 0000-00FF
        LD      BC,L6382
        CALL    C5EA8                   ; allocate MSXDOS memory (halt when error)
        LD      (XFER+1),HL
        EX      DE,HL
        LD      HL,I6382
        LDIR                            ; install XFER routine
        LD      BC,L63A5
        CALL    C5EA8                   ; allocate MSXDOS memory (halt when error)
        LD      E,L
        LD      D,H
        LD      (XF368+1),HL
        INC     HL
        INC     HL
        LD      (XF36B+1),HL
        LD      HL,I63A5
        LDIR                            ; install ENAKRN and ENARAM
        LD      BC,L63F8
        CALL    C5EA8                   ; allocate MSXDOS memory (halt when error)
        PUSH    HL
        EX      DE,HL
        LD      HL,C63F8
        PUSH    HL
        LDIR                            ; install slot switching routines
        POP     BC
        POP     DE
        PUSH    DE
        LD      HL,R0116-C63F8+1
        ADD     HL,DE
        LD      (HL),LOW X003B
        INC     HL
        LD      (HL),HIGH X003B
        LD      HL,I63BE
        CALL    C630D                   ; relocate
        LD      HL,I5B0A
        XOR     A
        LD      B,A
        LD      D,A
J5A7F:  LD      E,(HL)
        CP      E
        JR      Z,J5A93
        INC     HL
        LD      C,(HL)
        INC     HL
        EX      (SP),HL
        ADD     HL,BC
        EX      DE,HL
        LD      (HL),0C3H
        INC     HL
        LD      (HL),E
        INC     HL
        LD      (HL),D
        EX      DE,HL
        EX      (SP),HL
        JR      J5A7F

J5A93:  POP     HL
        LD      HL,C655C
        LD      DE,X003B
        LD      BC,L655C
        LDIR                            ; install slotswitching helper routines
        LD      BC,L633D
        CALL    C5EA8                   ; allocate MSXDOS memory (halt when error)
        PUSH    HL
        EX      DE,HL
        LD      HL,I633D
        PUSH    HL
        LDIR                            ; install interrupt routine
        POP     BC
        POP     DE
        PUSH    DE
        LD      HL,I6335
        CALL    C630D                   ; relocate
        POP     HL
        LD      A,0C3H
        LD      (KEYINT+0),A
        LD      (KEYINT+1),HL
        LD      DE,R0021-I633D+1
        ADD     HL,DE
        LD      DE,(YF34B)
        LD      (HL),E
        INC     HL
        LD      (HL),D
        LD      BC,160
        CALL    C5EA8                   ; allocate MSXDOS memory (halt when error)
        LD      A,0C3H
        CALL    C5C5D
        SCF
C5AD6:  LD      HL,YF323
        LD      DE,XF368
        LD      A,(YF340)
        JP      YC000+0001EH

C5AE2:  LD      A,(DEFDPB+1)
        LD      C,A
        LD      B,1
        LD      HL,(YF351)
        PUSH    HL
        XOR     A
        LD      E,A
        LD      D,A
        CALL    PHYDIO
        LD      A,0FFH
        LD      (YF246),A
        POP     HL
        RET     C
        LD      A,(HL)
        LD      DE,YC000
        LD      BC,256
        LDIR
        CP      0EBH
        RET     Z
        CP      0E9H
        RET     Z
        SCF
        RET

I5B0A:  DEFB    LOW RDSLT ,C63F8-C63F8
        DEFB    LOW WRSLT ,C6419-C63F8
        DEFB    LOW CALLF ,C6447-C6419
        DEFB    LOW CALSLT,C6459-C6447
        DEFB    LOW ENASLT,C64A0-C6459
        DEFB    0

I5B15:  DEFB    0
        DEFB    "AUTOEXECBAS"
        DEFB    0
L5B15   EQU     $-I5B15

I5B22:  DEFB    'RUN"AUTOEXEC.BAS'
        DEFB    0
L5B22   EQU     $-I5B22

I5B33:  DEFW    J5B8D

J5B35:  CALL    C5C5B
        LD      HL,I5B22
        LD      DE,BUF+10
        LD      BC,L5B22
        LDIR
        LD      HL,YF340
        LD      A,(HL)
        AND     A
        LD      (HL),H
        JR      NZ,J5B69
        LD      (YF346),A
        LD      HL,I5B33
        LD      (YF323),HL
        LD      HL,I5B15
        LD      DE,BUF+10+L5B22
        LD      BC,37                   ; a bit odd, should be L5B15
        PUSH    DE
        LDIR
        POP     DE
        CALL    A4462                   ; open fcb
        INC     A
        JR      Z,J5B8D
        JR      J5B9B

J5B69:  LD      A,(WBOOT+0)
        CP      0C3H
        JR      NZ,J5B97
        LD      HL,DBUF
        LD      B,(HL)
        INC     B
        DEC     B
        JR      Z,J5B97
J5B78:  INC     HL
        LD      A,(HL)
        CP      20H     ; " "
        JR      NZ,J5B82
        DJNZ    J5B78
        JR      J5B97

J5B82:  XOR     A
        LD      C,B
        LD      B,A
        LD      DE,BUF+14
        LDIR
        LD      (DE),A
        JR      J5B9B

J5B8D:  LD      SP,YC000+256+256
        LD      A,(YF338)
        AND     A
        CALL    Z,C5D3A
J5B97:  XOR     A
        LD      (BUF+13),A
J5B9B:  LD      SP,YC000+256+256
        LD      A,(RAMAD2)
        LD      H,80H
        CALL    ENASLT
        LD      A,(EXPTBL+0)
        LD      H,00H
        CALL    ENASLT
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
        CALL    C5C11
        LD      SP,(STKTOP)
        LD      A,0FFH
        LD      (CNSDFG),A
        LD      A,0CH   ; 12
        RST     18H
        LD      IX,M7D31
        CALL    CALBAS
        CALL    C5F81
        DEFB    13,10
        DEFB    "Disk BASIC version 1.0",13,10
        DEFB    0
        LD      HL,M4173
        PUSH    HL
        LD      HL,BUF+10-1
        PUSH    HL
        LD      HL,BUF+64
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

C5C11:  LD      HL,I72AA
        LD      (YF323),HL
        LD      HL,I5C67
        LD      (YF325),HL
        LD      HL,(YF349)
        LD      (HIMEM),HL
        LD      A,(YF345)
        LD      C,A
J5C27:  LD      B,00H
        LD      DE,37
        CALL    A4916
        CALL    C5EB3
        LD      (YF353),HL
        LD      BC,25
        CALL    C5EB3
        LD      (XF377+1),HL
        EX      DE,HL
        LD      HL,I62F4
        LDIR
        LD      HL,-11
        ADD     HL,DE
        LD      (XF37A+1),HL
        LD      A,(YF348)
        LD      DE,-7
        ADD     HL,DE
        LD      (HL),A
        LD      DE,14
        ADD     HL,DE
        LD      (HL),A
        CALL    C5F5A

;         Subroutine __________________________
;            Inputs  ________________________
;            Outputs ________________________

C5C5B:  LD      A,0C9H

;         Subroutine __________________________
;            Inputs  ________________________
;            Outputs ________________________

C5C5D:  LD      (XF368),A
        LD      (XF36B),A
        LD      (XFER),A
        RET

I5C67:  DEFW    A40A7

C5C69:  LD      HL,I62EF
        LD      DE,H.POSD
        LD      BC,5
        LDIR
        LD      HL,I5C91
J5C77:  LD      E,(HL)
        INC     HL
        LD      D,(HL)
        INC     HL
        LD      A,E
        OR      D
        RET     Z
        EX      DE,HL
        LD      (HL),0F7H
        INC     HL
        LD      A,(YF348)
        LD      (HL),A
        INC     HL
        EX      DE,HL
        LDI
        LDI
        LD      A,0C9H
        LD      (DE),A
        JR      J5C77

I5C91:  DEFW    H.DSKO,C6B92
        DEFW    H.DSKI,C6B71
        DEFW    H.NAME,C6F1C
        DEFW    H.KILL,C6EFC
        DEFW    H.COPY,C7077
        DEFW    H.DSKF,C705D
        DEFW    H.LSET,C6CD3
        DEFW    H.RSET,C6CD2
        DEFW    H.FIEL,C6C45
        DEFW    H.MKI$,C6DAB
        DEFW    H.MKS,C6DAE
        DEFW    H.MKD,C6DB1
        DEFW    H.CVI ,C6DD3
        DEFW    H.CVS ,C6DD6
        DEFW    H.CVD ,C6DD9
        DEFW    H.GETP,C66A3
        DEFW    H.NOFO,C66B2
        DEFW    H.NULO,C66FA
        DEFW    H.NTFL,C68CC
        DEFW    H.BINS,C690A
        DEFW    H.BINL,C6935
        DEFW    H.FILE,C6E84
        DEFW    H.DGET,C6BD6
        DEFW    H.FILO,C688A
        DEFW    H.INDS,C6816
        DEFW    H.LOC ,C7009
        DEFW    H.LOF ,C7005
        DEFW    H.EOF ,C6E6C
        DEFW    H.BAKU,C6872
        DEFW    H.PARD,C7326
        DEFW    H.NODE,C737E
        DEFW    H.ERRP,C71CF
        DEFW    H.PHYD,C6050
        DEFW    H.FORM,C60AB
        DEFW    XF331 ,C56D3
        DEFW    0

I5D1F:  DEFB    1,048H,"-",1,041H,"-",1,047H,"):",0
I5D2A:  defb    "M-D-Y):",0
I5D32:  defb    "D-M-Y):",0

C5D3A:  LD      (BUF+98),SP
        LD      A,14H   ; 20
        LD      (BUF+100),A
J5D43:  CALL    C5F81
        DEFB    13,10,"Enter date (",0
        NOP
        NOP
        NOP
        NOP
        NOP
        LD      A,(YF30E)
        CP      01H     ; 1
        LD      HL,I5D1F
        JR      C,J5D6C
        LD      HL,I5D2A
        JR      Z,J5D6C
        LD      HL,I5D32
J5D6C:  CALL    C5F87
        LD      HL,I5E46
        LD      (YF325),HL
        LD      DE,BUF+100
        CALL    A50E0
        LD      HL,BUF+102
        LD      A,(HL)
        CP      0DH     ; 13
        RET     Z
        LD      A,(YF30E)
        AND     A
        JR      NZ,J5D9A
        CALL    C5E08
        CALL    C5DE4
        LD      D,C
        LD      A,(HL)
        INC     HL
        CP      B
        JR      NZ,J5DC6
        CALL    C5DF3
        LD      E,C
        JR      J5DB4

J5D9A:  CALL    C5DF3
        LD      D,C
        CALL    C5DE4
        LD      E,C
        LD      A,(HL)
        INC     HL
        CP      B
        JR      NZ,J5DAC
        CALL    C5E08
        JR      J5DB4

J5DAC:  PUSH    DE
        CALL    A553C
        PUSH    HL
        POP     IX
J5DB3:  POP     DE
J5DB4:  LD      A,(YF30E)
        CP      02H     ; 2
        JR      C,J5DBE
        LD      A,E
        LD      E,D
        LD      D,A
J5DBE:  PUSH    IX
        POP     HL
        CALL    A5552
        OR      A
        RET     Z
J5DC6:  LD      SP,(BUF+98)
        CALL    C5F81
        DEFB    13,10,"Invalid date",0
        NOP
        NOP
        NOP
        NOP
        NOP
        JP      J5D43


;         Subroutine __________________________
;            Inputs  ________________________
;            Outputs ________________________

C5DE4:  LD      A,(HL)
        INC     HL
        LD      B,A
        CP      2FH     ; "/"
        JR      Z,C5DF3
        CP      2EH     ; "."
        JR      Z,C5DF3
        CP      2DH     ; "-"
        JR      NZ,J5DC6

;         Subroutine __________________________
;            Inputs  ________________________
;            Outputs ________________________

C5DF3:  CALL    C5E3C
        JR      C,J5DC6
        LD      C,A
        CALL    C5E3C
        RET     C
        PUSH    AF
        LD      A,C
        ADD     A,A
        ADD     A,A
        ADD     A,C
        ADD     A,A
        LD      C,A
        POP     AF
        ADD     A,C
        LD      C,A
        RET


;         Subroutine __________________________
;            Inputs  ________________________
;            Outputs ________________________

C5E08:  CALL    C5DF3
        LD      B,C
        CALL    C5E3C
        JR      C,J5E27
        DEC     HL
        CALL    C5DF3
        PUSH    HL
        PUSH    BC
        LD      C,B
        LD      B,00H
        PUSH    DE
        LD      DE,100
        CALL    A4916
        POP     DE
        POP     HL
        LD      H,00H
        JR      J5E36

J5E27:  PUSH    HL
        LD      C,B
        LD      B,00H
        LD      HL,1900
        LD      A,C
        CP      50H     ; "P"
        JR      NC,J5E36
        LD      HL,2000
J5E36:  ADD     HL,BC
        PUSH    HL
        POP     IX
        POP     HL
        RET


;         Subroutine __________________________
;            Inputs  ________________________
;            Outputs ________________________

C5E3C:  LD      A,(HL)
        SUB     30H     ; "0"
        RET     C
        CP      0AH     ; 10
        CCF
        RET     C
        INC     HL
        RET

I5E46:  LD      C,B
        LD      E,(HL)
        LD      SP,(BUF+98)
        RET

C5E4D:  LD      HL,EXPTBL
        LD      B,04H   ; 4
        XOR     A
J5E53:  AND     03H     ; 3
        OR      (HL)
J5E56:  PUSH    BC
        PUSH    HL
        LD      H,C
J5E59:  LD      L,10H   ; 16
J5E5B:  PUSH    AF
        CALL    RDSLT
        CPL
        LD      E,A
        POP     AF
        PUSH    DE
        PUSH    AF
        CALL    WRSLT
        POP     AF
        POP     DE
        PUSH    AF
        PUSH    DE
        CALL    RDSLT
        POP     BC
        LD      B,A
        LD      A,C
        CPL
        LD      E,A
        POP     AF
        PUSH    AF
        PUSH    BC
        CALL    WRSLT
        POP     BC
        LD      A,C
        CP      B
        JR      NZ,J5E95
        POP     AF
        DEC     L
        JR      NZ,J5E5B
        INC     H
        INC     H
        INC     H
        INC     H
        LD      C,A
        LD      A,H
        CP      40H     ; "@"
        JR      Z,J5E91
        CP      80H
        LD      A,C
        JR      NZ,J5E59
J5E91:  LD      A,C
        POP     HL
        POP     HL
        RET

J5E95:  POP     AF
        POP     HL
        POP     BC
        AND     A
        JP      P,J5EA2
        ADD     A,04H   ; 4
        CP      90H
        JR      C,J5E56
J5EA2:  INC     HL
        INC     A
I5EA4:  DJNZ    J5E53
        SCF
        RET


;         Subroutine __________________________
;            Inputs  ________________________
;            Outputs ________________________

C5EA8:  LD      HL,(YF34B)
        AND     A
        SBC     HL,BC
        LD      (YF34B),HL
        JR      J5EBC


;         Subroutine __________________________
;            Inputs  ________________________
;            Outputs ________________________

C5EB3:  LD      HL,(HIMEM)
        AND     A
        SBC     HL,BC
        LD      (HIMEM),HL
J5EBC:  JR      C,J5EC7
        LD      A,H
        CP      0C2H
        JR      J5EC6

C5EC3:  CALL    C5EE3
J5EC6:  RET     NC
J5EC7:  CALL    C5F81
        DEFB    12
I5ECB:  DEFB    "No enough memory",0
        NOP
        NOP
        NOP
        NOP
        NOP
        DI
        HALT


;         Subroutine __________________________
;            Inputs  ________________________
;            Outputs ________________________

C5EE3:  LD      A,L
        OR      H
        RET     Z
        XOR     A
        SUB     L
        LD      L,A
        LD      A,00H
        SBC     A,H
        LD      H,A
        LD      C,L
        LD      B,H
        ADD     HL,SP
        CCF
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
        AND     A
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
        LD      DE,0FDEAH
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
J5F36:  LD      (STKTOP),HL
        DEC     HL
        DEC     HL
        LD      (SAVSTK),HL
        LD      L,E
        LD      H,D
        INC     HL
        INC     HL
        INC     HL
J5F43:  INC     HL
        LD      A,02H   ; 2
J5F46:  EX      DE,HL
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
        JR      NZ,J5F46
        RET


;         Subroutine __________________________
;            Inputs  ________________________
;            Outputs ________________________

C5F5A:  LD      A,01H   ; 1
        LD      (MAXFIL),A
        LD      HL,(HIMEM)
        LD      DE,0FDEAH
        ADD     HL,DE
        LD      (FILTAB),HL
        LD      E,L
        LD      D,H
        DEC     HL
        DEC     HL
        LD      (MEMSIZ),HL
        LD      BC,200
        AND     A
        SBC     HL,BC
        PUSH    HL
        LD      HL,13
        ADD     HL,DE
        LD      (NULBUF),HL
        POP     HL
        JR      J5F36


;         Subroutine __________________________
;            Inputs  ________________________
;            Outputs ________________________

C5F81:  EX      (SP),HL
        CALL    C5F87
        EX      (SP),HL
        RET


;         Subroutine __________________________
;            Inputs  ________________________
;            Outputs ________________________

C5F87:  LD      A,(HL)
        INC     HL
        AND     A
        RET     Z
        CALL    A408F
        JR      C5F87

C5F90:  LD      B,6
        DEFB    021H
C5F93:  LD      B,4
        CALL    XF365
        PUSH    BC
J5F99:  RRCA
        DJNZ    J5F99
        CALL    C5FE7
        POP     BC
        OR      (HL)
        LD      C,A
        INC     HL
        INC     HL
        INC     HL
        INC     HL
        LD      A,(HL)
        DEC     B
        DEC     B
J5FA9:  RRCA
        DJNZ    J5FA9
        JR      J5FB9

C5FAE:  CALL    C5FE2
        OR      (HL)
        RET     P
        LD      C,A
        INC     HL
        INC     HL
        INC     HL
        INC     HL
        LD      A,(HL)
J5FB9:  AND     0CH     ; 12
        OR      C
        RET

GETWRK:
C5FBD:  CALL    C5FC8
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

C5FC8:  CALL    C5FE2
        ADD     A,A
        ADD     A,A
        ADD     A,A
        SCF
        ADC     A,A
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
        JR      J5FEE


;         Subroutine __________________________
;            Inputs  ________________________
;            Outputs ________________________

C5FE2:  CALL    XF365
        RRCA
        RRCA

;         Subroutine __________________________
;            Inputs  ________________________
;            Outputs ________________________

C5FE7:  AND     03H     ; 3
        LD      HL,EXPTBL

;         Subroutine __________________________
;            Inputs  ________________________
;            Outputs ________________________

C5FEC:  LD      B,00H
J5FEE:  LD      C,A
        ADD     HL,BC
        RET

SETINT:
C5FF1:  LD      A,(H.TIMI+0)
        CP      0C9H
        JR      Z,J600D
        PUSH    HL
        LD      A,(DEVICE)
        LD      HL,YFB29
        CALL    C5FEC
        ADD     HL,BC
        ADD     HL,BC
        EX      DE,HL
        LD      HL,H.TIMI+1
        LD      C,03H   ; 3
        LDIR
        POP     HL
J600D:  DI
        LD      A,0F7H
        LD      (H.TIMI+0),A
        LD      (H.TIMI+2),HL
        LD      A,0C9H
        LD      (H.TIMI+4),A
        CALL    A402D
        LD      (H.TIMI+1),A
        RET

PRVINT:
C6022:  PUSH    AF
        CALL    A402D
        LD      B,04H   ; 4
        LD      DE,YFB29
        LD      HL,YFB21+1
J602E:  CP      (HL)
        JR      Z,J603A
        INC     DE
        INC     DE
        INC     DE
        INC     HL
        INC     HL
        DJNZ    J602E
J6038:  POP     AF
        RET

J603A:  EX      DE,HL
        LD      A,(HL)
        AND     A
        JR      Z,J6038
        PUSH    AF
        POP     IY
        INC     HL
        LD      C,(HL)
        INC     HL
        LD      B,(HL)
        PUSH    BC
        POP     IX
        POP     AF
        JP      CALSLT

C604D:  AND     A
        DEFB    038H

C604F:  SCF

C6050:  PUSH    IX
        PUSH    IY
        PUSH    HL
        PUSH    AF
        CALL    C6081
        LD      L,A
        POP     AF
        LD      A,L
        LD      IX,T4010
        JR      J6076

C6062:  PUSH    IX
        LD      IX,T4013
        JR      J6070

C606A:  PUSH    IX
        LD      IX,T4016
J6070:  PUSH    IY
        PUSH    HL
        CALL    C6081
J6076:  POP     HL
        PUSH    HL
        CALL    CALSLT
        POP     HL
        POP     IY
        POP     IX
        RET


;         Subroutine __________________________
;            Inputs  ________________________
;            Outputs ________________________

C6081:  LD      (YF33F),A
        LD      HL,YFB21
J6087:  SUB     (HL)
        JR      C,J608E
        INC     HL
        INC     HL
        JR      J6087

J608E:  ADD     A,(HL)
        INC     HL
        LD      H,(HL)
        PUSH    HL
        POP     IY
        RET


;         Subroutine __________________________
;            Inputs  ________________________
;            Outputs ________________________

C6095:  LD      HL,YF355
        CALL    C5FEC
        ADD     HL,BC
        LD      E,(HL)
        INC     HL
        LD      D,(HL)
        LD      HL,19
        ADD     HL,DE
        LD      E,(HL)
        INC     HL
        LD      D,(HL)
        DEC     DE
        EX      DE,HL
        LD      (HL),0FFH
        RET

C60AB:  AND     A
C60AC:  LD      (YF339),SP
        CALL    NC,C62DD
        PUSH    HL
        PUSH    BC
        LD      A,(YF347)
        DEC     A
        JR      Z,J60FC
J60BB:  CALL    C5F81
        DEFB    "Drive name? (",0
        NOP
        NOP
        NOP
        NOP
        NOP
        LD      A,(YF347)
        LD      B,A
        LD      A,41H   ; "A"
        JR      J60E0

J60D9:  PUSH    AF
        LD      A,2CH   ; ","
        CALL    A408F
        POP     AF
J60E0:  CALL    A408F
        INC     A
        DJNZ    J60D9
        CALL    C5F81
        DEFB    ") ",0
J60EC:  CALL    C6190
        CALL    C62CD
        AND     0DFH
        SUB     41H     ; "A"
        LD      HL,YF347
        CP      (HL)
        JR      NC,J60BB
J60FC:  CALL    C6095
        CALL    C6081
        PUSH    IY
        PUSH    AF
        PUSH    IY
        LD      IX,T4019
        CALL    CALSLT
        LD      A,L
        OR      H
        JR      Z,J6139
        POP     AF
J6113:  PUSH    AF
        CALL    RDSLT
        AND     A
        JR      Z,J6121
        CALL    A408F
        INC     HL
        POP     AF
        JR      J6113

J6121:  POP     AF
        CALL    C5F81
        DEFB    "? ",0
J6128:  CALL    C6190
        SUB     31H     ; "1"
        CP      09H     ; 9
        JR      NC,J6128
        ADD     A,31H   ; "1"
J6133:  CALL    C62CD
        SUB     30H     ; "0"
        PUSH    AF
J6139:  CALL    C616F
        POP     AF
        POP     DE
        POP     IY
        POP     BC
        POP     HL
        LD      IX,T401C
        CALL    CALSLT
        LD      HL,I61DB
        JR      NC,J6158
        LD      HL,I624F
        CALL    C5FEC
        LD      A,(HL)
        INC     HL
        LD      H,(HL)
        LD      L,A
J6158:  CALL    C62D0
        CALL    C5F87
        JP      C62D0


;         Subroutine __________________________
;            Inputs  ________________________
;            Outputs ________________________

C6161:  XOR     A
        LD      (YF336),A
        LD      IX,KILBUF
        CALL    A40AB
        JP      A4078


;         Subroutine __________________________
;            Inputs  ________________________
;            Outputs ________________________

C616F:  CALL    C5F81
        DEFB    "Strike a key when ready ",0
J618B:  NOP
        NOP
        NOP
        NOP
        NOP

;         Subroutine __________________________
;            Inputs  ________________________
;            Outputs ________________________

C6190:  CALL    C6161
        CP      03H     ; 3
        RET     NZ
        LD      SP,(YF339)
        CALL    C5F81
        DEFB    13,10,"Aborted",0
        RET

I61A8:  DEFB    "Write protected",0
I61B8:  DEFB    "Not ready",0
I61C2:  DEFB    "Disk error",0
I61CD:  DEFB    "Bad parameter",0
I61DB:  DEFB    "Format complete",0

        DEFS    100,0

I624F:  DEFW    I61A8
        DEFW    I61B8
        DEFW    I61C2
        DEFW    I61C2
        DEFW    I61C2
        DEFW    I61C2
        DEFW    I61CD
        DEFW    I5ECB
        DEFW    I61C2

PROMPT:
C6255:  LD      A,(YF33F)
        ADD     A,41H   ; "A"
        CALL    XF24F
        PUSH    AF
        CALL    C5F81
        DEFB    13,10,"Insert diskette for drive ",0
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        POP     AF
        CALL    A408F
        CALL    C5F81
        DEFB    ":",13,10,"and strike a key when ready",0
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
J62C4:  CALL    C6161
        CP      03H     ; 3
        JR      Z,J62C4
        JR      C62D0


;         Subroutine __________________________
;            Inputs  ________________________
;            Outputs ________________________

C62CD:  CALL    A408F

;         Subroutine __________________________
;            Inputs  ________________________
;            Outputs ________________________

C62D0:  PUSH    AF
        LD      A,0DH   ; 13
        CALL    A408F
        LD      A,0AH   ; 10
        CALL    A408F
J62DB:  POP     AF
        RET


;         Subroutine __________________________
;            Inputs  ________________________
;            Outputs ________________________

C62DD:  LD      HL,-256
        ADD     HL,SP
        LD      DE,(STREND)
        XOR     A
J62E6:  SBC     HL,DE
J62E8:  LD      C,L
        LD      B,H
        EX      DE,HL
        RET     NC
        LD      C,A
        LD      B,A
        RET

I62EF:  INC     SP
        INC     SP
        JP      M6F1D

I62F4:  LD      A,D
        CP      09H     ; 9
        JP      NC,J6EC9
        RST     30H
        NOP
        AND     E
        LD      L,D
        PUSH    HL
        JP      J6EF4

?6302:  LD      A,D
        CP      09H     ; 9
        JP      NC,J6E95
        RST     30H
        NOP
        EX      (SP),HL
J630B:  LD      L,C
        RET


;         Subroutine __________________________
;            Inputs  ________________________
;            Outputs ________________________

C630D:  PUSH    DE
        EX      DE,HL
        AND     A
        SBC     HL,BC
        PUSH    HL
        POP     IX
        EX      DE,HL
J6316:  POP     DE
J6317:  LD      C,(HL)
        INC     HL
        LD      B,(HL)
        INC     HL
        LD      A,C
        AND     B
        INC     A
        RET     Z
        PUSH    DE
        EX      DE,HL
        ADD     HL,BC
        INC     HL
        LD      C,(HL)
        INC     HL
        LD      B,(HL)
        PUSH    HL
J6327:  PUSH    IX
        POP     HL
        ADD     HL,BC
        LD      C,L
        LD      B,H
        POP     HL
        LD      (HL),B
        DEC     HL
        LD      (HL),C
        EX      DE,HL
        POP     DE
        JR      J6317

I6335:  DEFW    R000C  -I633D
        DEFW    R001E+1-I633D
        DEFW    R002F  -I633D
        DEFW    0FFFFH

I633D:  PUSH    IY
        PUSH    IX
        PUSH    HL
        PUSH    DE
        PUSH    BC
        PUSH    AF
        EXX
        EX      AF,AF'
        PUSH    AF
        PUSH    HL
R000C:  LD      HL,(D6365+1)
        LD      A,L
        OR      H
        POP     HL
        LD      IX,KEYINT
        LD      IY,(EXPTBL-1)
        JR      NZ,J637C
        POP     AF
R001E:  LD      (D6365+1),SP
R0021:  LD      SP,0
        CALL    CALSLT
        DI
D6365:  LD      SP,0
        PUSH    HL
        LD      HL,0
R002F:  LD      (D6365+1),HL
        POP     HL
J6370:  EX      AF,AF'
        EXX
        POP     AF
        POP     BC
        POP     DE
        POP     HL
        POP     IX
        POP     IY
        EI
        RET

J637C:  POP     AF
        CALL    CALSLT
        JR      J6370

L633D   EQU     $-I633D

I6382:  PUSH    AF
        PUSH    HL
        PUSH    DE
        PUSH    BC
        CALL    A402D
        PUSH    AF
        LD      H,40H
        LD      A,(RAMAD1)
        CALL    ENASLT
        POP     AF
        POP     BC
        POP     DE
        POP     HL
        LDIR
        PUSH    HL
        PUSH    DE
        PUSH    BC
        LD      H,40H
        CALL    ENASLT
        POP     BC
        POP     DE
        POP     HL
        POP     AF
        RET

L6382   EQU     $-I6382

I63A5:  JR      J63AD

?63A7:  PUSH    AF
        LD      A,(RAMAD1)
        JR      J63B1

J63AD:  PUSH    AF
        LD      A,(YF348)
J63B1:  PUSH    HL
        PUSH    DE
        PUSH    BC
        LD      H,40H   ; "@"
        CALL    ENASLT
        POP     BC
        POP     DE
        POP     HL
        POP     AF
        RET

L63A5   EQU     $-I63A5

I63BE:  DEFW    C63F8-C63F8
        DEFW    R0003-C63F8
        DEFW    R0017-C63F8
        DEFW    R001C-C63F8
        DEFW    R0022-C63F8
        DEFW    R0025-C63F8
        DEFW    R0039-C63F8
        DEFW    R003F-C63F8
        DEFW    R0069-C63F8
        DEFW    R006C-C63F8
        DEFW    R007E-C63F8
        DEFW    R0094-C63F8
        DEFW    C64A0-C63F8
        DEFW    R00AB-C63F8
        DEFW    R00BC-C63F8
        DEFW    J6408-C63F8
        DEFW    R0013-C63F8
        DEFW    J6429-C63F8
        DEFW    R0034-C63F8
        DEFW    J6470-C63F8
        DEFW    R007B-C63F8
        DEFW    J64AD-C63F8
        DEFW    R00B8-C63F8
        DEFW    J651E-C63F8
        DEFW    R0131-C63F8
        DEFW    J652C-C63F8
        DEFW    R0145-C63F8
        DEFW    C6541-C63F8
        DEFW    0FFFFH

;         Subroutine RDSLT MSXDOS
;            Inputs  ________________________
;            Outputs ________________________

C63F8:  CALL    C64C6                   ; calculate masks
R0003:  JP      M,J6408                 ; expanded slot, handle
        IN      A,(0A8H)
        LD      D,A
        AND     C
        OR      B
        CALL    RDPRIM
        LD      A,E
        RET

J6408:  CALL    C6515                   ; check if primairy slot 0, page 0
R0013:  JP      Z,J651E                 ; yep, handle RDSLT without helper routines
        PUSH    HL
R0017:  CALL    C64EB
        EX      (SP),HL
        PUSH    BC
R001C:  CALL    C63F8
        JR      J643A


;         Subroutine WRSLT MSXDOS
;            Inputs  ________________________
;            Outputs ________________________

C6419:  PUSH    DE
R0022:  CALL    C64C6                   ; calculate masks
R0025:  JP      M,J6429                 ; expanded slot, handle
        POP     DE
        IN      A,(0A8H)
        LD      D,A
        AND     C
        OR      B
        JP      WRPRIM

J6429:  CALL    C6515                   ; check if primairy slot 0, page 0
R0034:  JP      Z,J6524                 ; yep, handle WRSLT without helper routines
        EX      (SP),HL
        PUSH    HL
R0039:  CALL    C64EB
        POP     DE
        EX      (SP),HL
        PUSH    BC
R003F:  CALL    C6419
J643A:  POP     BC
        EX      (SP),HL
        PUSH    AF
        LD      A,B
        AND     3FH     ; "?"
        OR      C
        CALL    X0046
        POP     AF
        POP     HL
        RET

;         Subroutine CALLF MSXDOS
;            Inputs  ________________________
;            Outputs ________________________

C6447:  EX      (SP),HL
        PUSH    AF
        PUSH    DE
        LD      A,(HL)
        PUSH    AF
        POP     IY
        INC     HL
        LD      E,(HL)
        INC     HL
        LD      D,(HL)
        INC     HL
        PUSH    DE
        POP     IX
        POP     DE
        POP     AF
        EX      (SP),HL

;         Subroutine CALSLT MSXDOS
;            Inputs  ________________________
;            Outputs ________________________

C6459:  EXX
        EX      AF,AF'
        PUSH    IY
        POP     AF
        PUSH    IX
        POP     HL
R0069:  CALL    C64C6                   ; calculate masks
R006C:  JP      M,J6470                 ; expanded slot, handle
        IN      A,(0A8H)
        PUSH    AF
        AND     C
        OR      B
        EXX
        JP      CLPRIM

J6470:  CALL    C6515                   ; check if primairy slot 0, page 0
R007B:  JP      Z,J652C                 ; yep, handle CALSLT without helper routines
R007E:  CALL    C64EB
        PUSH    AF
        POP     IY
        PUSH    HL
        PUSH    BC
        LD      C,A
        LD      B,00H
        LD      A,L
        AND     H
        OR      D
        LD      HL,SLTTBL
        ADD     HL,BC
        LD      (HL),A
        PUSH    HL
        EX      AF,AF'
        EXX
R0094:  CALL    C6459
        EXX
        EX      AF,AF'
        POP     HL
        POP     BC
        POP     DE
        LD      A,B
        AND     3FH     ; "?"
        OR      C
        DI
        CALL    X004B
        LD      (HL),E
        EX      AF,AF'
        EXX
        RET


;         Subroutine ENASLT MSXDOS
;            Inputs  ________________________
;            Outputs ________________________

C64A0:  CALL    C64C6                   ; calculate masks
R00AB:  JP      M,J64AD                 ; expanded slot, handle
        IN      A,(0A8H)
        AND     C
        OR      B
        OUT     (0A8H),A
        RET

J64AD:  CALL    C6515                   ; check if primairy slot 0, page 0
R00B8:  JP      Z,C6541                 ; yep, handle ENASLT without helper routines
        PUSH    HL
R00BC:  CALL    C64EB
        LD      C,A
        LD      B,00H
        LD      A,L
        AND     H
        OR      D
        LD      HL,SLTTBL
        ADD     HL,BC
        LD      (HL),A
        POP     HL
        LD      A,C
        JR      C64A0


;         Subroutine caculate masks
;            Inputs  ________________________
;            Outputs ________________________

C64C6:  DI
        PUSH    AF
        LD      A,H
        RLCA
        RLCA
        AND     03H
        LD      E,A                     ; page
        INC     E
        LD      A,0C0H
J64D1:  RLCA
        RLCA
        DEC     E
        JR      NZ,J64D1
        LD      E,A                     ; page select mask
        CPL
        LD      C,A                     ; page clear mask
        POP     AF
        PUSH    AF
        AND     03H
        LD      B,A                     ; primairy slot
        INC     B
        LD      A,0ABH
J64E1:  ADD     A,55H   ; "U"
        DJNZ    J64E1
        LD      D,A                     ; slot set mask (all pages)
        AND     E
        LD      B,A                     ; slot set mask (page)
        POP     AF
        AND     A
        RET


;         Subroutine __________________________
;            Inputs  ________________________
;            Outputs ________________________

C64EB:  PUSH    AF
        LD      A,D
        AND     0C0H
        LD      C,A
        POP     AF
        PUSH    AF
        LD      D,A
        IN      A,(0A8H)
        LD      B,A
        AND     3FH     ; "?"
        OR      C
        PUSH    AF
        LD      A,D
        RRCA
        RRCA
        AND     03H     ; 3
        LD      D,A
        INC     D
        LD      A,0ABH
J6503:  ADD     A,55H   ; "U"
        DEC     D
        JR      NZ,J6503
        AND     E
        LD      D,A
        LD      A,E
        CPL
        LD      H,A
        POP     AF
R0116:  CALL    C655C
        POP     AF
        AND     03H     ; 3
        RET


;         Subroutine __________________________
;            Inputs  ________________________
;            Outputs ________________________

C6515:  INC     D
        DEC     D                       ; primairy slot 0 ?
        RET     NZ
        LD      B,A
        LD      A,E
        CP      03H                     ; page 0 ?
        LD      A,B
        RET

J651E:  CALL    C6549                   ; change secundairy slot register
        LD      E,(HL)
        JR      C6529                   ; restore secundairy slot register

J6524:  POP     DE
R0131:  CALL    C6549                   ; change secundairy slot register
        LD      (HL),E

;       Subroutine      __________________________
;       Inputs          ________________________
;       Outputs         ________________________

C6529:  LD      A,B
        JR      J6557

J652C:  CALL    C6541                   ; change secundairy slot register and update SLTTBL
        PUSH    HL
        PUSH    BC
        EX      AF,AF'
        EXX
        CALL    CLPRM1
        EXX
        EX      AF,AF'
        POP     BC
R0145:  CALL    C6529                   ; restore secundairy slot register
        POP     HL
        LD      (HL),B                  ; restore SLTTBL
        EX      AF,AF'
        EXX
        RET

;       Subroutine      __________________________
;       Inputs          ________________________
;       Outputs         ________________________

C6541:  CALL    C6549                   ; change secundairy slot register
        LD      HL,SLTTBL
        LD      (HL),D
        RET

;       Subroutine      __________________________
;       Inputs          ________________________
;       Outputs         ________________________

C6549:  RRCA
        RRCA
        AND     03H
        LD      D,A
        LD      A,(YFFFF)
        CPL
        LD      B,A
        AND     0FCH
        OR      D
        LD      D,A
J6557:  LD      (YFFFF),A
        LD      A,E
        RET

L63F8   EQU     $-C63F8

;       Subroutine      __________________________
;       Inputs          ________________________
;       Outputs         ________________________

C655C:  OUT     (0A8H),A
        LD      A,(YFFFF)
        CPL
        LD      L,A
        AND     H
        OR      D
        JR      J656F

?6567:  OUT     (0A8H),A
        LD      A,L
        JR      J656F

?656C:  OUT     (0A8H),A
        LD      A,E
J656F:  LD      (YFFFF),A
        LD      A,B
        OUT     (0A8H),A
        RET

L655C   EQU     $-C655C

A6576:  ld      a,(H.GETP+0)
        cp      0C9H
        scf
        ret     z
        push    hl
        call    A402D
        ld      hl,YF348
        cp      (hl)
        jr      nz,A65AD
        ld      hl,T65B1
A658A:  ld      de,PROCNM
A658D:  ld      a,(de)
        cp      (hl)
        inc     de
        inc     hl
        jr      nz,A65A3
        and     a
        jr      nz,A658D
        ld      a,(hl)
        inc     hl
        ld      h,(hl)
        ld      l,a
        ex      (sp),hl
        call    C72D6                   ;
        scf
        ccf
        ret

A65A1:  inc     hl
        ld      a,(hl)
A65A3:  and     a
        jr      nz,A65A1
        inc     hl
        inc     hl
        inc     hl
        ld      a,(hl)
        and     a
        jr      nz,A658A
A65AD:  pop     hl
        jp      OEMSTA

T65B1:  defb    "SYSTEM",0
        defw    A65C4
        defb    "FORMAT",0
        defw    A65DC
        defb    0

A65C4:  ret     nz
        ld      a,(YF346)
        and     a
        jp      z,J7319                 ; illegal function call error
        ld      ix,M6C1C
        call    CALBAS                  ; close all i/o channels
        call    TOTEXT
        call    ERAFNK
        jp      C5A11                   ; start MSXDOS

A65DC:  push    hl
        call    z,C60AC
        pop     hl
        and     a
        ret

A65E3:  ld      a,d
A65E4:  dec     a
        ret     p
        ld      a,(YF247)
        ret

A65EA:  push    hl
        push    de
        push    bc
        call    A65E3                   ; convert to driveid
        ld      c,a
        ld      hl,(FILTAB)             ; I/O channel pointer table
        ld      a,(MAXFIL)              ; number of I/O channels
A65F7:  push    af
        ld      e,(hl)
        inc     hl
        ld      d,(hl)
        inc     hl
        push    hl
        ex      de,hl                   ; pointer to I/O channel
        ld      a,(hl)
        and     a                       ; channel in use ?
        jr      z,A662E                 ; nope, check next
        inc     hl
        inc     hl
        inc     hl
        inc     hl
        ld      a,(hl)
        cp      9                       ; channel in use by a disk device ?
        jr      nc,A662E                ; nope, check next
        dec     hl
        dec     hl
        ld      d,(hl)
        dec     hl
        ld      e,(hl)                  ; pointer to FCB
        ld      a,(de)                  ; DR byte of FCB
        call    A65E4                   ; convert to driveid
        cp      c                       ; same as the requested one ?
        jr      nz,A662E                ; nope, check next
        inc     de
        ex      de,hl
        ld      de,FILNAM
        ld      b,11
A661E:  ld      a,(de)
        cp      "?"
        jr      z,A6626                 ; wildcard, treat as equal
        cp      (hl)
        jr      nz,A662E                ; filename not equal, check next
A6626:  inc     de
        inc     hl
        djnz    A661E                   ; next char
        pop     hl
        pop     hl
        jr      J669F                   ; quit with Zx set (file open)

A662E:  pop     hl
        pop     af
        dec     a
        jp      p,A65F7                 ; next channel
        jr      J669F                   ; quit with Zx reset (file not open)

A6636:  push    hl
        push    de
        push    bc
        ld      a,d
        ld      (BUF+10),a
        call    A6657                   ; copy FILNAM to FCB
        call    A6645                   ; search file
        jr      J669F

A6645:  ld      hl,BUF+84
        ld      (YF23D),hl              ; transferaddress in BUF
        ld      de,BUF+10
        xor     a
        ld      (BUF+10+12),a           ; clear EX byte of FCB
D6652:  call    A4FB8                   ; search for first
        inc     a
        ret

A6657:  ld      de,BUF+10+1
A665A:  ld      hl,FILNAM
        ld      bc,11
        ldir
        ret

;       Subroutine      take control from caller (move parameters on stack)
;       Inputs          IX = returnaddress replacement, IYH = number of bytes to move
;       Outputs         ________________________

;       This is what the stack looks like at entry:
;
;       prim    exp
;       +0      +0      returnaddress A6663 caller
;       +2      +2      callf BIOS registers
;       +6      +14     returnaddress CALLF caller
;       +8      +16     returnaddress hook caller

C6663:  PUSH    HL
        PUSH    DE
        PUSH    BC
        PUSH    AF
        LD      A,(YF348)
        ADD     A,A
        LD      HL,16
        JR      NC,J6672
        LD      L,16+8
J6672:  ADD     HL,SP
        PUSH    IX
        POP     BC
        LD      (HL),C
        INC     HL
        LD      (HL),B
        LD      HL,10
        ADD     HL,SP
        EX      DE,HL
        JR      J668C

J6680:  PUSH    IY
        POP     BC
J6683:  LD      C,(HL)
        LD      A,(DE)
        LD      (HL),A
        LD      A,C
        LD      (DE),A
        INC     HL
        INC     DE
        DJNZ    J6683
J668C:  LD      A,(YF348)
        ADD     A,A
        LD      HL,18
        JR      NC,J6697
        LD      L,18+8
J6697:  ADD     HL,SP
        LD      A,E
        SUB     L
        LD      A,D
        SBC     A,H
        JR      C,J6680
J669E:  POP     AF
J669F:  POP     BC
        POP     DE
        POP     HL
        RET

C66A3:  LD      IX,RETRTN
        LD      IY,00200H
        CALL    C6663
        POP     HL
        LD      A,(HL)
        AND     A
        RET

C66B2:  LD      BC,256
        LD      (YF33D),BC
        CALL    C72D6
        LD      A,E
        RET     Z
        PUSH    AF
        PUSH    HL
        LD      A,(YF348)
        ADD     A,A
        LD      HL,12
        JR      NC,J66CB
        LD      L,12+8
J66CB:  ADD     HL,SP
        LD      A,(HL)
        CP      04H     ; 4
        JP      NZ,J731F                ; syntax error
        INC     HL
        LD      A,(HL)
        CP      09H     ; 9
        JP      NC,J731F                ; syntax error
        POP     HL
        CALL    C72CC
        DEFB    0FFH
        CALL    C72CC
        DEFB    092H
        CALL    C72CC
        DEFB    0EFH
        LD      IX,M4756
        CALL    CALBAS
        DEC     DE
        INC     D
        DEC     D
        JP      NZ,J7319                ; illegal function call error
        INC     DE
        LD      (YF33D),DE
        POP     AF
        RET

C66FA:  RET     NC
        LD      IX,RETRTN
        LD      IY,00400H
        CALL    C6663
        CALL    C6FA5
        CALL    A65EA
        JP      Z,J7301                 ; file already open error
        LD      (PTRFIL),HL
        LD      A,E
        CP      04H     ; 4
        JR      Z,J671E
        LD      BC,1
        LD      (YF33D),BC
J671E:  POP     AF
        PUSH    AF
        PUSH    HL
        PUSH    DE
        LD      HL,YF345
        CP      (HL)
        JP      NC,J7307                ; bad filenumber error
        LD      BC,37
        LD      E,A
        LD      D,B
        LD      HL,(YF353)
        CALL    A491C
        XOR     A
        LD      HL,12
        ADD     HL,BC
        LD      (HL),A
        POP     DE
        POP     HL
        INC     HL
        LD      (HL),C
        INC     HL
        LD      (HL),B
        INC     HL
        LD      (HL),A
        INC     HL
        LD      (HL),D
        INC     HL
        INC     HL
        LD      (HL),A
        CALL    A6636
        PUSH    BC
        PUSH    DE
        LD      A,D
        LD      (BC),A
        LD      E,C
        LD      D,B
        INC     DE
        CALL    A665A
        POP     DE
        POP     BC
        LD      A,E
        JR      NZ,J6775
        AND     86H
        JP      Z,J7313                 ; file not found error
J675E:  PUSH    DE
        PUSH    BC
        LD      E,C
        LD      D,B
        CALL    A461D
        AND     A
        JP      NZ,J71A7
        POP     HL
        CALL    C67FB
        POP     DE
        LD      HL,(PTRFIL)
        LD      (HL),E
J6772:  POP     AF
        POP     HL
        RET

J6775:  CP      08H     ; 8
        JR      Z,J67BE
        CP      02H     ; 2
        JR      Z,J675E
        CP      80H
        JR      Z,J675E
        PUSH    DE
        PUSH    BC
        LD      E,C
        LD      D,B
        CALL    A4462                   ; open fcb
        POP     HL
        CALL    C67FB
        POP     DE
        LD      HL,(PTRFIL)
        LD      (HL),E
        LD      A,E
        CP      04H     ; 4
        JR      Z,J6772
        PUSH    HL
        LD      HL,FLBMEM
        XOR     A
        CP      (HL)
        LD      (HL),A
        POP     HL
        JR      NZ,J6772
        LD      BC,6
        ADD     HL,BC
        PUSH    HL
        LD      (HL),0FFH
        LD      HL,(PTRFIL)
        CALL    C6827
        POP     HL
        DEC     HL
        DEC     HL
        DEC     HL
        LD      (HL),A
        CP      0FFH
        JR      NZ,J6772
        INC     HL
        INC     HL
        INC     HL
        INC     HL
        LD      (HL),80H
J67BC:  JR      J6772

J67BE:  PUSH    BC
        LD      E,C
        LD      D,B
        CALL    A4462                   ; open fcb
        POP     HL
        PUSH    HL
        CALL    C67FB
        LD      HL,(PTRFIL)
        LD      (HL),01H        ; 1
        LD      BC,6
        ADD     HL,BC
        LD      (HL),0FFH
        LD      HL,(PTRFIL)
J67D7:  PUSH    HL
        CALL    C6827
        POP     HL
        JR      NC,J67D7
        LD      (HL),02H        ; 2
        POP     HL
        LD      BC,33
        ADD     HL,BC
        LD      C,04H   ; 4
        PUSH    HL
        SCF
J67E9:  LD      A,(HL)
        SBC     A,B
        LD      (HL),A
        INC     HL
        DEC     C
        JR      NZ,J67E9
        POP     HL
        INC     C
        JR      NC,J67F6
        LD      C,04H   ; 4
J67F6:  CALL    C6810
        JR      J67BC


;         Subroutine __________________________
;            Inputs  ________________________
;            Outputs ________________________

C67FB:  LD      BC,12
        ADD     HL,BC
        LD      (HL),B
        INC     HL
        LD      (HL),B
        INC     HL
        LD      BC,(YF33D)
        LD      (HL),C
        INC     HL
        LD      (HL),B
        LD      BC,17
        ADD     HL,BC
        LD      C,05H   ; 5

;         Subroutine __________________________
;            Inputs  ________________________
;            Outputs ________________________

C6810:  LD      (HL),B
        INC     HL
        DEC     C
        JR      NZ,C6810
        RET

C6816:  LD      IX,RETRTN
        LD      IY,00600H
        CALL    C6663
        CALL    C6827
        JP      J669F


;         Subroutine __________________________
;            Inputs  ________________________
;            Outputs ________________________

C6827:  PUSH    HL
        LD      A,(HL)
        CP      01H     ; 1
        JP      NZ,J7195                ; bad file mode error
        LD      E,L
        LD      D,H
        INC     HL
        INC     HL
        INC     HL
        LD      A,(HL)
        AND     A
        JR      NZ,J6863
        INC     HL
        INC     HL
        INC     HL
        INC     (HL)
        LD      A,(HL)
        INC     HL
        INC     HL
        INC     HL
        JR      NZ,J685E
        PUSH    HL
        LD      (YF23D),HL
        EX      DE,HL
        INC     HL
        LD      E,(HL)
        INC     HL
        LD      D,(HL)
        LD      HL,256
        CALL    A47B2
        LD      E,L
        LD      D,H
        DEC     H
        LD      A,L
        OR      H
        POP     HL
        JR      Z,J685E
        PUSH    HL
        ADD     HL,DE
        LD      (HL),1AH
        POP     HL
        XOR     A
J685E:  LD      C,A
        LD      B,00H
        ADD     HL,BC
        LD      A,(HL)
J6863:  LD      B,A
        SUB     1AH
        SUB     01H     ; 1
        LD      A,B
        POP     HL
        INC     HL
        INC     HL
        INC     HL
        LD      (HL),00H
        RET     NC
        LD      (HL),A
        RET

C6872:  PUSH    HL
        LD      A,(YF348)
        ADD     A,A
        LD      HL,8
        JR      NC,J687E
        LD      L,10H   ; 16
J687E:  ADD     HL,SP
        LD      (HL),41H        ; "A"
        INC     HL
        LD      (HL),6EH        ; "n"
        POP     HL
        INC     HL
        INC     HL
        INC     HL
        LD      (HL),C
        RET

C688A:  LD      IX,RETRTN
        LD      IY,00800H
        CALL    C6663
        LD      A,(HL)
        CP      02H     ; 2
        JP      NZ,J7195                ; bad file mode error
        POP     AF
        PUSH    AF
        CALL    C68A3
        JP      J669E


;         Subroutine __________________________
;            Inputs  ________________________
;            Outputs ________________________

C68A3:  PUSH    HL
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

C68B1:  PUSH    HL
        INC     HL
        LD      E,(HL)
        INC     HL
        LD      D,(HL)
        LD      BC,4
        ADD     HL,BC
        LD      A,(HL)
        INC     HL
        INC     HL
        INC     HL
        LD      (YF23D),HL
        AND     A
        LD      L,A
        LD      H,B
        JR      NZ,J68C7
        INC     H
J68C7:  CALL    C718B
        POP     HL
        RET

C68CC:  LD      IX,RETRTN
        LD      IY,00400H
        CALL    C6663
        POP     HL
        LD      A,(HL)
        SUB     02H     ; 2
        JR      NZ,J68F0
        PUSH    HL
        LD      HL,FLBMEM
        CP      (HL)
        LD      (HL),A
        POP     HL
        JR      NZ,J68F0
        LD      (HL),04H        ; 4
        LD      A,1AH
        CALL    C68A3
        CALL    NZ,C68B1
J68F0:  PUSH    HL
        INC     HL
        LD      E,(HL)
        INC     HL
        LD      D,(HL)
        CALL    A456F
        POP     HL
        PUSH    HL
        LD      DE,7
        ADD     HL,DE
        LD      (HL),D
        LD      L,D
        LD      H,D
        LD      (PTRFIL),HL
        POP     HL
        INC     (HL)
        DEC     (HL)
        LD      (HL),D
        POP     HL
        RET

C690A:  CALL    C7381
        PUSH    HL
        LD      IX,M54F7
        CALL    CALBAS
        LD      A,0FFH
        CALL    C69C3
        LD      HL,(TXTTAB)
        LD      (YF23D),HL
        EX      DE,HL
        LD      HL,(VARTAB)
        AND     A
        SBC     HL,DE
        CALL    C7187
        LD      (NLONLY),A
        POP     HL
        LD      IX,M6B24
        JP      CALBAS

C6935:  LD      IX,M739A
        LD      IY,00200H
        CALL    C6663
        POP     AF
        JP      Z,J7195                 ; bad file mode error
        LD      IX,M6C1C
        CALL    CALBAS
        LD      HL,(YF353)
        PUSH    HL
        CALL    C67FB
        POP     HL
        PUSH    HL
        LD      BC,19
        ADD     HL,BC
        LD      A,(HL)
        AND     A
        JP      NZ,J72E9                ; out of memory error
        DEC     HL
        OR      (HL)
        JP      NZ,J72E9                ; out of memory error
        DEC     HL
        LD      D,(HL)
        DEC     HL
        LD      E,(HL)
        LD      HL,(TXTTAB)
        ADD     HL,DE
        JP      C,J72E9                 ; out of memory error
        LD      BC,128+19
        ADD     HL,BC
        JP      C,J72E9                 ; out of memory error
        SBC     HL,SP
        JP      NC,J72E9                ; out of memory error
        EX      DE,HL
        EX      (SP),HL
        EX      DE,HL
        CALL    C69CC
        LD      HL,(TXTTAB)
        LD      (YF23D),HL
        POP     HL
        DEC     HL
        CALL    A47B2
        LD      DE,(TXTTAB)
        ADD     HL,DE
        LD      (VARTAB),HL
        LD      IX,M4253
        CALL    CALBAS
        LD      A,(FILNAM+0)
        AND     A
        RET     NZ
        LD      (NLONLY),A
        LD      HL,I69B5
        LD      DE,BUF+10
        LD      BC,5
        PUSH    DE
        LDIR
        POP     HL
        LD      IX,M4601
        JP      CALBAS

I69B5:  DEFB    ":",092H,0
        DEFW    0

;         Subroutine __________________________
;            Inputs  ________________________
;            Outputs ________________________

C69BA:  PUSH    HL
        LD      A,L
        CALL    C69C7
        POP     HL
        LD      A,H
        JR      C69C7


;         Subroutine __________________________
;            Inputs  ________________________
;            Outputs ________________________

C69C3:  LD      DE,(YF353)

;         Subroutine __________________________
;            Inputs  ________________________
;            Outputs ________________________

C69C7:  LD      BC,A47BE
        JR      J69CF


;         Subroutine __________________________
;            Inputs  ________________________
;            Outputs ________________________

C69CC:  LD      BC,A47B2
J69CF:  PUSH    AF
        LD      HL,1
        ADD     HL,SP
        LD      (YF23D),HL
        PUSH    DE
        CALL    C69DE
        POP     DE
        POP     AF
        RET


;         Subroutine __________________________
;            Inputs  ________________________
;            Outputs ________________________

C69DE:  LD      HL,1
        PUSH    BC
        RET

?69E3:  PUSH    DE
        CALL    C6B66
        LD      (SAVENT),DE
        PUSH    DE
        CALL    C6B66
        LD      (SAVEND),DE
        EX      (SP),HL
        EX      DE,HL
        RST     20H
        JP      C,J7319                 ; illegal function call error
        EX      DE,HL
        EX      (SP),HL
        CALL    C72D6
        SCF
        JR      Z,J6A17
        CALL    C72CC
        INC     L
        CP      53H     ; "S"
        JR      NZ,J6A0F
        CALL    C72D7
        AND     A
        JR      J6A17

J6A0F:  CALL    C6B6A
        LD      (SAVENT),DE
        SCF
J6A17:  POP     BC
        JR      NC,J6A1F
        INC     B
        DEC     B
        JP      P,J7319                 ; illegal function call error
J6A1F:  POP     DE
        PUSH    HL
        PUSH    BC
        PUSH    AF
        XOR     A
        LD      E,02H   ; 2
        LD      IX,M6AFA
        CALL    CALBAS
        LD      A,0FEH
        CALL    C69C3
        POP     AF
        POP     HL
        PUSH    HL
        PUSH    AF
        CALL    C69BA
        LD      HL,(SAVEND)
        CALL    C69BA
        LD      HL,(SAVENT)
        CALL    C69BA
        POP     AF
        POP     BC
        PUSH    AF
        LD      (YF23D),BC
        LD      HL,(SAVEND)
        AND     A
        SBC     HL,BC
        INC     HL
        POP     AF
        JR      NC,J6A69
        CALL    C7187
J6A59:  LD      A,0FFH
        LD      (FLBMEM),A
        XOR     A
        LD      IX,M6B24
        CALL    CALBAS
        JP      J6EF4

J6A69:  CALL    C7161
J6A6C:  PUSH    HL
I6A6D:  LD      DE,(SAVENT)
        RST     20H
        PUSH    AF
        LD      C,L
        LD      B,H
        LD      HL,(SAVEND)
        PUSH    HL
        ADD     HL,BC
        LD      (SAVEND),HL
        POP     HL
        LD      DE,(YF23D)
        CALL    LDIRMV
        POP     AF
        JR      NC,J6A9A
        POP     HL
        PUSH    HL
        CALL    C7187
        LD      HL,(SAVENT)
        POP     DE
        AND     A
        SBC     HL,DE
        LD      (SAVENT),HL
        EX      DE,HL
        JR      J6A6C

J6A9A:  POP     HL
        LD      HL,(SAVENT)
        CALL    C7187
        JR      J6A59

?6AA3:  PUSH    DE
        XOR     A
        LD      (RUNBNF),A
        LD      C,A
        LD      B,A
        CALL    C72D6
        JR      Z,J6ACC
        CALL    C72CC
        INC     L
        CP      52H     ; "R"
        JR      Z,J6ABB
        CP      53H     ; "S"
        JR      NZ,J6AC7
J6ABB:  LD      (RUNBNF),A
        CALL    C72D7
        JR      Z,J6ACC
        CALL    C72CC
        INC     L
J6AC7:  CALL    C6B6A
        LD      B,D
        LD      C,E
J6ACC:  POP     DE
        PUSH    HL
        PUSH    BC
        LD      A,0FFH
        LD      (FLBMEM),A
        XOR     A
        LD      E,01H   ; 1
        LD      IX,M6AFA
        CALL    CALBAS
        LD      DE,(YF353)
        CALL    C69CC
        CP      0FEH
        JP      NZ,J7195                ; bad file mode error
        POP     BC
        CALL    C6B58
        PUSH    HL
        CALL    C6B58
        PUSH    HL
        CALL    C6B58
        LD      (SAVENT),HL
        POP     HL
I6AFA:  POP     BC
        AND     A
        SBC     HL,BC
        INC     HL
        LD      (YF23D),BC
        LD      A,(RUNBNF)
        CP      53H     ; "S"
        JR      Z,J6B16
        CALL    A47B2
J6B0D:  LD      IX,M4AFF
        CALL    CALBAS
        POP     HL
        RET

J6B16:  CALL    C7161
J6B19:  PUSH    HL
        LD      DE,(SAVENT)
        RST     20H
        PUSH    AF
        LD      DE,(YF353)
I6B24:  CALL    A47B2
        POP     AF
        POP     BC
        PUSH    BC
        PUSH    AF
        LD      HL,(SAVEND)
        PUSH    HL
        ADD     HL,BC
        LD      (SAVEND),HL
        POP     DE
        LD      HL,(YF23D)
        POP     AF
        JR      NC,J6B4A
        CALL    LDIRVM
        LD      HL,(SAVENT)
        POP     DE
        AND     A
        SBC     HL,DE
        LD      (SAVENT),HL
        EX      DE,HL
        JR      J6B19

J6B4A:  POP     BC
        LD      BC,(SAVENT)
        CALL    LDIRVM
        XOR     A
        LD      (RUNBNF),A
        JR      J6B0D


;         Subroutine __________________________
;            Inputs  ________________________
;            Outputs ________________________

C6B58:  PUSH    BC
        CALL    C69CC
        PUSH    AF
        CALL    C69CC
        LD      H,A
        POP     AF
        LD      L,A
        POP     BC
        ADD     HL,BC
        RET


;         Subroutine __________________________
;            Inputs  ________________________
;            Outputs ________________________

C6B66:  CALL    C72CC
        INC     L

;         Subroutine __________________________
;            Inputs  ________________________
;            Outputs ________________________

C6B6A:  LD      IX,M6F0B
        JP      CALBAS

C6B71:  CALL    C7381
        CALL    C72D7
        CALL    C72CC
        DEFB    "("
        CALL    C6BC1
        CALL    C72CC
        ADD     HL,HL
        PUSH    HL
        LD      HL,M3FD6
        LD      (DAC+2),HL
        POP     HL
        LD      A,03H   ; 3
        LD      (VALTYP),A
        AND     A
        JR      J6B9D

C6B92:  CALL    C7381
        CALL    C6BC1
        CALL    C72D6
        RET     NZ
        SCF
J6B9D:  PUSH    AF
        PUSH    HL
        PUSH    DE
        LD      E,C
        CALL    A505D
        INC     A
        JP      Z,J7198                 ; bad drive name error
        POP     DE
        POP     HL
        POP     AF
        PUSH    HL
        LD      A,0FFH
        LD      (YF246),A
        LD      A,(IX+0)
        LD      B,1
        LD      C,(IX+1)
        LD      HL,(YF351)
        CALL    PHYDIO
        POP     HL
        RET


;         Subroutine __________________________
;            Inputs  ________________________
;            Outputs ________________________

C6BC1:  LD      IX,M521C
        CALL    CALBAS
        PUSH    DE
        CALL    C72CC
        INC     L
        LD      IX,M542F
        CALL    CALBAS
        POP     BC
        RET

C6BD6:  LD      IX,RETRTN
        LD      IY,00400H
        CALL    C6663
        LD      A,(HL)
        CP      04H     ; 4
        JP      NZ,J7195                ; bad file mode error
        INC     HL
        LD      E,(HL)
        INC     HL
        LD      D,(HL)
        LD      BC,7
        ADD     HL,BC
        EX      (SP),HL
        CALL    C72D6
        JR      Z,J6C25
        PUSH    DE
        CALL    C72CC
        INC     L
        LD      IX,M4C64
        CALL    CALBAS
        PUSH    HL
        CALL    C6DF7
        LD      A,C
        OR      B
        OR      L
        OR      H
        JP      Z,J7319                 ; illegal function call error
        LD      A,C
        OR      B
        DEC     BC
        JR      NZ,J6C12
        DEC     HL
J6C12:  EX      DE,HL
        POP     HL
        EX      (SP),HL
        PUSH    HL
        PUSH    DE
        LD      DE,33
        ADD     HL,DE
        POP     DE
I6C1C:  LD      (HL),C
        INC     HL
        LD      (HL),B
        INC     HL
        LD      (HL),E
        INC     HL
        LD      (HL),D
        POP     DE
        POP     HL
J6C25:  EX      (SP),HL
        LD      (YF23D),HL
        POP     HL
        POP     AF
        PUSH    HL
        AND     A
        LD      HL,J72F5                ; input past end error
        LD      BC,A47B2
        JR      Z,J6C3B
        LD      HL,J71A4
        LD      BC,A47BE
J6C3B:  PUSH    HL
        CALL    C69DE
        AND     A
        RET     NZ
        POP     HL
        JP      J6EF4

C6C45:  CALL    C7381
        CP      23H     ; "#"
        CALL    Z,C72D7
        LD      IX,M521C
        CALL    CALBAS
        JP      Z,J731F                 ; syntax error
        PUSH    HL
        LD      IX,M6A6D
        CALL    CALBAS
        LD      E,L
        LD      D,H
        JP      Z,J72EF                 ; file not open error
        JP      C,J7319                 ; illegal function call error
        LD      A,(HL)
        CP      04H     ; 4
        JP      NZ,J7195                ; bad file mode error
        INC     HL
        LD      A,(HL)
        INC     HL
        LD      H,(HL)
        LD      L,A
        LD      BC,14
        ADD     HL,BC
        LD      C,(HL)
        INC     HL
        LD      B,(HL)
        LD      (BUF+10),BC
        LD      HL,0
        LD      (BUF+12),HL
        LD      BC,9
        POP     HL
J6C87:  EX      DE,HL
        ADD     HL,BC
        EX      DE,HL
        LD      A,(HL)
        CP      2CH     ; ","
        RET     NZ
        PUSH    DE
        LD      IX,M521B
        CALL    CALBAS
        PUSH    AF
        CALL    C72CC
        LD      B,C
        CALL    C72CC
        LD      D,E
        LD      IX,M5EA4
        CALL    CALBAS
        LD      IX,M5597
        CALL    CALBAS
        JP      NZ,J72E3                ; type mismatch error
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
        JP      C,J72FB                 ; field overflow error
        POP     DE
        POP     HL
        LD      (HL),C
        INC     HL
        LD      (HL),E
        INC     HL
        LD      (HL),D
        LD      B,00H
        POP     HL
        JR      J6C87

C6CD2:  DEFB    0F6H

C6CD3:  SCF
        CALL    C7381
        PUSH    AF
        LD      IX,M5EA4
        CALL    CALBAS
        LD      IX,M5597
        CALL    CALBAS
        JP      NZ,J72E3                ; type mismatch error
        PUSH    DE
        LD      IX,M4C5F
        CALL    CALBAS
        POP     BC
        EX      (SP),HL
        PUSH    HL
        PUSH    BC
        LD      IX,M67D0
        CALL    CALBAS
        LD      B,(HL)
        EX      (SP),HL
        LD      A,(HL)
        LD      C,A
        PUSH    BC
        PUSH    HL
        PUSH    AF
        INC     HL
        LD      E,(HL)
        INC     HL
        LD      D,(HL)
        OR      A
        JR      Z,J6D66
        LD      HL,(NULBUF)
        DEC     HL
        RST     20H
        JR      C,J6D44
        LD      HL,(VARTAB)
        RST     20H
        JR      C,J6D44
        LD      E,C
        LD      D,00H
        LD      HL,(STKTOP)
        ADD     HL,DE
        EX      DE,HL
        LD      HL,(FRETOP)
        RST     20H
        JR      C,J6D79
        POP     AF
J6D26:  LD      A,C
        LD      IX,M668E
        CALL    CALBAS
        POP     HL
        POP     BC
        EX      (SP),HL
        PUSH    DE
        PUSH    BC
        LD      IX,M67D0
        CALL    CALBAS
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
J6D44:  POP     AF
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
        JR      NC,J6D56
        LD      B,A
J6D56:  SUB     B
        LD      C,A
        POP     AF
        CALL    NC,C6D70
        INC     B
J6D5D:  DEC     B
        JR      Z,J6D6B
        LD      A,(HL)
        LD      (DE),A
        INC     HL
        INC     DE
        JR      J6D5D

J6D66:  POP     BC
        POP     BC
        POP     BC
        POP     BC
        POP     BC
J6D6B:  CALL    C,C6D70
        POP     HL
        RET


;         Subroutine __________________________
;            Inputs  ________________________
;            Outputs ________________________

C6D70:  LD      A,20H   ; " "
        INC     C
J6D73:  DEC     C
        RET     Z
        LD      (DE),A
        INC     DE
        JR      J6D73

J6D79:  POP     AF
        POP     HL
        POP     BC
        EX      (SP),HL
        EX      DE,HL
        JR      NZ,J6DA5
        PUSH    BC
        LD      A,B
        LD      IX,M6627
        CALL    CALBAS
        LD      DE,DSCTMP
        LD      HL,(TEMPPT)
        LD      (DAC+2),HL
        LD      A,3
        LD      (VALTYP),A
        CALL    M2EF3
        LD      DE,FRETOP
        RST     20H
        LD      (TEMPPT),HL
        JP      Z,J72DD                 ; string formula too complex error
        POP     BC
J6DA5:  EX      (SP),HL
        PUSH    BC
        PUSH    HL
        JP      J6D26

C6DAB:  LD      A,2
        DEFB    1

C6DAE:  LD      A,4
        DEFB    1

C6DB1:  LD      A,8
        CALL    C7381
        PUSH    AF
        LD      IX,M517A
        CALL    CALBAS
        POP     AF
        LD      IX,M6627
        CALL    CALBAS
        LD      HL,(DSCTMP+1)
        CALL    M2F10
        LD      IX,M6825
        JP      CALBAS                  ; push temporary descriptor to temporary desciptor heap and quit

C6DD3:  LD      A,2-1
        DEFB    1

C6DD6:  LD      A,4-1
        DEFB    1

C6DD9:  LD      A,8-1
        CALL    C7381
        PUSH    AF
        LD      IX,M67D0
        CALL    CALBAS
        POP     AF
        CP      (HL)
        JP      NC,J7319                ; illegal function call error
        INC     A
        INC     HL
        LD      C,(HL)
        INC     HL
        LD      H,(HL)
        LD      L,C
        LD      (VALTYP),A
        JP      M2F08


;         Subroutine __________________________
;            Inputs  ________________________
;            Outputs ________________________

C6DF7:  LD      IX,M5597
        CALL    CALBAS
        LD      BC,(DAC+2)
        LD      HL,0
        RET     M
        JP      Z,J72E3                 ; type mismatch error
        LD      HL,DAC
        LD      DE,BUF+158
        LD      BC,8
        LDIR
        LD      HL,I6E64
        LD      DE,ARG
        LD      C,08H   ; 8
        LDIR
        CALL    M289F
        AND     A
        CALL    M30D1
        LD      IX,M5432
        CALL    CALBAS
        PUSH    DE
        EX      DE,HL
        LD      IX,M46FF
        CALL    CALBAS
        CALL    M3042
        LD      BC,06545H
        LD      DE,06053H
        CALL    M325C
        LD      HL,DAC
        LD      DE,ARG
        LD      BC,8
        LDIR
        LD      HL,BUF+158
        LD      DE,DAC
        LD      C,08H   ; 8
        LDIR
        CALL    M268C
        LD      IX,M5432
        CALL    CALBAS
        LD      C,E
        LD      B,D
        POP     HL
        RET

I6E64:  DEFB    045H,065H,053H,060H,000H,000H,000H,000H

C6E6C:  CALL    C7381
        PUSH    HL
        CALL    C6827
        LD      HL,0
        JR      NC,J6E79
        DEC     HL
J6E79:  PUSH    AF
        CALL    M2F99
        POP     AF
        POP     HL
        INC     HL
        INC     HL
        INC     HL
        LD      (HL),A
        RET

C6E84:  CALL    C7381
        LD      D,00H
        JR      Z,J6E91
        CALL    C6F7C
        PUSH    HL
        JR      J6E95

J6E91:  PUSH    HL
        CALL    C6FFA
J6E95:  CALL    C6F5F
        LD      A,(PRTFLG)
        AND     A
        PUSH    AF
        CALL    A6645
        JP      Z,J7313                 ; file not found error
        LD      IX,M7323
        CALL    CALBAS
J6EAA:  LD      HL,BUF+85
        LD      B,0BH   ; 11
J6EAF:  LD      A,(HL)
        INC     HL
        RST     18H
        LD      A,B
        CP      04H     ; 4
        JR      NZ,J6EBF
        LD      A,(HL)
        CP      20H     ; " "
        JR      Z,J6EBE
        LD      A,2EH   ; "."
J6EBE:  RST     18H
J6EBF:  DJNZ    J6EAF
        CALL    CKCNTC
        POP     AF
        PUSH    AF
        LD      A,(LINLEN)
J6EC9:  LD      B,A
        LD      A,(TTYPOS)
        JR      Z,J6ED4
        LD      B,50H   ; "P"
        LD      A,(LPTPOS)
J6ED4:  AND     A
        JR      Z,J6EE6
        ADD     A,0CH   ; 12
        CP      B
        JR      NC,J6EDF
        LD      A,20H   ; " "
        RST     18H
J6EDF:  LD      IX,M7328
        CALL    NC,CALBAS
J6EE6:  LD      DE,BUF+10
        XOR     A
        LD      (BUF+22),A
        CALL    A5006
        INC     A
        JR      NZ,J6EAA
        POP     AF
J6EF4:  POP     HL
        LD      IX,M4AFF
        JP      CALBAS

C6EFC:  CALL    C7381
        CALL    C6F92
        CALL    C72D6
        RET     NZ
        CALL    A65EA
        JP      Z,J719E                 ; file still open error
        CALL    C6F5F
        PUSH    HL
        LD      DE,BUF+10
        CALL    A436C
        AND     A
        JP      NZ,J7313                ; file not found error
        POP     HL
        RET

C6F1C:  CALL    C7381
        CALL    C6F92
        CALL    A65EA
        JP      Z,J719E                 ; file still open error
        CALL    C6F5F
        PUSH    HL
        CALL    A6645
        JP      Z,J7313                 ; file not found error
        POP     HL
        CALL    C72CC
        LD      B,C
        CALL    C72CC
        LD      D,E
        CALL    C6F92
        LD      A,D
        LD      (BUF+26),A
        PUSH    HL
        LD      HL,(BUF+10)
        AND     A
        JR      Z,J6F4D
        CP      L
        JP      NZ,J71B3
J6F4D:  LD      DE,BUF+27
        CALL    A665A
        LD      DE,BUF+10
        CALL    A4392
        AND     A
        JP      NZ,J71A1                ; file already exists
        POP     HL
        RET


;         Subroutine __________________________
;            Inputs  ________________________
;            Outputs ________________________

C6F5F:  CALL    A65E3
        INC     A
        LD      (BUF+10),A
        PUSH    HL
        PUSH    DE
        CALL    A6657
        POP     DE
        POP     HL
        RET


;         Subroutine __________________________
;            Inputs  ________________________
;            Outputs ________________________

C6F6E:  LD      IX,M6A0E
        CALL    CALBAS
        LD      A,D
        CP      09H     ; 9
        RET     C
        JP      J7198                   ; bad drive name error


;         Subroutine __________________________
;            Inputs  ________________________
;            Outputs ________________________

C6F7C:  CALL    C6F6E
        PUSH    HL
        LD      HL,FILNAM
        LD      B,0BH   ; 11
J6F85:  LD      A,(HL)
        INC     HL
        CP      20H     ; " "
        JR      NZ,J6F96
        DJNZ    J6F85
        CALL    C6FFA
        JR      J6F96


;         Subroutine __________________________
;            Inputs  ________________________
;            Outputs ________________________

C6F92:  CALL    C6F6E
        PUSH    HL
J6F96:  LD      HL,FILNAM
        LD      B,08H   ; 8
        CALL    C6FF1
        LD      B,03H   ; 3
        CALL    C6FF1
        POP     HL
        DEFB    0F6H
C6FA5:  SCF
        PUSH    DE
        PUSH    HL
        LD      DE,FILNAM
        PUSH    DE
        LD      B,0BH   ; 11
J6FAE:  PUSH    BC
        LD      A,(DE)
        LD      HL,I6FC8
        LD      BC,13
        JR      C,J6FB9
        DEC     BC
J6FB9:  CPIR
        JR      Z,J6FEE
        POP     BC
        INC     DE
        DJNZ    J6FAE
        POP     HL
        CALL    C6FD5
        POP     HL
        POP     DE
        RET

I6FC8:  DEFB    '."/\[]:+=;,*?'

C6FD5:  LD      A," "
        CP      (HL)
        JR      Z,J6FEE
        LD      B,07H   ; 7
        CALL    C6FE1
        LD      B,03H   ; 3

;         Subroutine __________________________
;            Inputs  ________________________
;            Outputs ________________________

C6FE1:  INC     HL
        CP      (HL)
        JR      Z,J6FE8
        DJNZ    C6FE1
        RET

J6FE8:  DEC     B
        RET     Z
        INC     HL
        CP      (HL)
        JR      Z,J6FE8
J6FEE:  JP      J730D                   ; bad filename error


;         Subroutine __________________________
;            Inputs  ________________________
;            Outputs ________________________

C6FF1:  LD      A,(HL)
        CP      2AH     ; "*"
        JR      Z,J6FFF
        INC     HL
        DJNZ    C6FF1
        RET


;         Subroutine __________________________
;            Inputs  ________________________
;            Outputs ________________________

C6FFA:  LD      HL,FILNAM
        LD      B,0BH   ; 11
J6FFF:  LD      (HL),3FH        ; "?"
        INC     HL
        DJNZ    J6FFF
        RET

C7005:  LD      BC,16
        DEFB    011H

C7009:  LD      BC,33
        CALL    C7381
        PUSH    BC
        LD      IX,M521F
        CALL    CALBAS
        LD      IX,M6A6D
        CALL    CALBAS
        JP      C,J7319                 ; illegal function call error
        JP      Z,J72EF                 ; file not open error
        POP     BC
        INC     HL
        LD      E,(HL)
        INC     HL
        LD      D,(HL)
        EX      DE,HL
        ADD     HL,BC
        LD      C,(HL)
        INC     HL
        LD      B,(HL)
        INC     HL
        LD      E,(HL)
        INC     HL
        LD      D,(HL)
        EX      DE,HL
        PUSH    BC
        LD      IX,M46FF
        CALL    CALBAS
        LD      BC,06545H
        LD      DE,06053H
        CALL    M325C
        LD      HL,DAC
        LD      DE,ARG
        LD      BC,8
        LDIR
        POP     HL
        LD      IX,M46FF
        CALL    CALBAS
        CALL    M3042
        JP      M269A

C705D:  CALL    C7381
        LD      IX,M521F
        CALL    CALBAS
        LD      HL,YF347
        CP      (HL)
        JR      Z,J7070
        JP      NC,J7198                ; bad drive name error
J7070:  LD      E,A
        CALL    A505D
        JP      M2F99

C7077:  CALL    C7381
        CALL    C6F7C
        CALL    A65EA
        JP      Z,J719E                 ; file still open error
        CALL    C6F5F
        PUSH    HL
        LD      A,(YF247)
        INC     A
        LD      (BUF+47),A
        LD      HL,BUF+11
        LD      DE,BUF+48
        LD      BC,36
        LDIR
        POP     HL
        CALL    C72D6
        JR      Z,J70BF
        CALL    C72CC
        EXX
        CALL    C6F7C
        CALL    A65EA
        JP      Z,J719E                 ; file still open error
        CALL    A65E3
        INC     A
        LD      (BUF+47),A
        PUSH    HL
        LD      DE,BUF+48
        CALL    A665A
        POP     HL
        CALL    C72D6
        RET     NZ
J70BF:  PUSH    HL
        CALL    A6645
        JP      Z,J7313                 ; file not found error
J70C6:  CALL    CKCNTC
        LD      BC,BUF+47
        LD      DE,BUF+121
        LD      HL,BUF+84
        LD      A,0CH   ; 12
J70D4:  PUSH    AF
        LD      A,(BC)
        CP      3FH     ; "?"
        JR      NZ,J70DB
        LD      A,(HL)
J70DB:  LD      (DE),A
        INC     BC
        INC     DE
        INC     HL
        POP     AF
        DEC     A
        JR      NZ,J70D4
        LD      HL,BUF+84
        LD      DE,BUF+121
        LD      B,0CH   ; 12
J70EB:  LD      A,(DE)
        CP      (HL)
        JR      NZ,J70F6
        INC     HL
        INC     DE
        DJNZ    J70EB
        JP      J7319                   ; illegal function call error

J70F6:  CALL    C7168
        PUSH    HL
        XOR     A
        LD      (BUF+96),A
        LD      DE,BUF+84
        CALL    A4462                   ; open fcb
        LD      DE,BUF+121
        CALL    A461D
        AND     A
        JP      NZ,J71A7
        LD      L,A
        LD      H,A
        LD      (BUF+117),HL
        LD      (BUF+119),HL
        LD      (BUF+154),HL
        LD      (BUF+156),HL
        INC     HL
        LD      (BUF+98),HL
        LD      (BUF+135),HL
        POP     HL
J7124:  PUSH    HL
        LD      DE,BUF+84
        CALL    A47B2
        LD      A,L
        OR      H
        JR      Z,J7138
        LD      DE,BUF+121
        CALL    C718B
        POP     HL
        JR      J7124

J7138:  POP     HL
        LD      HL,(BUF+104)
        LD      (BUF+141),HL
        LD      HL,(BUF+106)
        LD      (BUF+143),HL
        LD      DE,BUF+121
        CALL    A456F
        LD      HL,BUF+84
        LD      (YF23D),HL
        LD      DE,BUF+10
        XOR     A
        LD      (BUF+22),A
        CALL    A5006
        INC     A
        JP      NZ,J70C6
        POP     HL
        RET


;         Subroutine __________________________
;            Inputs  ________________________
;            Outputs ________________________

C7161:  LD      (SAVENT),HL
        LD      (SAVEND),BC

;         Subroutine __________________________
;            Inputs  ________________________
;            Outputs ________________________

C7168:  LD      HL,-512
        ADD     HL,SP
        JR      NC,J717B
        LD      DE,(STREND)
        AND     A
        SBC     HL,DE
        JR      C,J717B
        LD      A,H
        AND     A
        JR      NZ,J7182
J717B:  LD      DE,(NULBUF)
        LD      HL,256
J7182:  LD      (YF23D),DE
        RET


;         Subroutine __________________________
;            Inputs  ________________________
;            Outputs ________________________

C7187:  LD      DE,(YF353)

;         Subroutine __________________________
;            Inputs  ________________________
;            Outputs ________________________

C718B:  CALL    A47BE
        AND     A
        RET     Z
        JR      J71A4

J7192:  LD      E,3CH
        DEFB    1
J7195:  LD      E,3DH
        DEFB    1
J7198:  LD      E,3EH
        DEFB    1
        LD      E,3FH
        DEFB    1
J719E:  LD      E,40H
        DEFB    1
J71A1:  LD      E,41H
        DEFB    1
J71A4:  LD      E,42H
        DEFB    1
J71A7:  LD      E,43H
        DEFB    1
J71AA:  LD      E,44H
        DEFB    1
J71AD:  LD      E,45H
        DEFB    1
J71B0:  LD      E,46H
        DEFB    1
J71B3:  LD      E,47H
        LD      BC,0
        XOR     A
        LD      (NLONLY),A
        LD      (FLBMEM),A
        PUSH    DE
        LD      IX,M6B24
        CALL    CALBAS
        POP     DE
        LD      IX,M406F
        JP      CALBAS

C71CF:  LD      A,E
        CP      3CH
        RET     C
        CP      48H
        RET     NC
        SUB     3BH
        LD      B,A
        LD      HL,I71F1
J71DC:  LD      A,(HL)
        AND     A
        INC     HL
        JR      NZ,J71DC
        DJNZ    J71DC
        DEC     HL
        LD      DE,BUF+166
        PUSH    DE
        LD      BC,22
        LDIR
        LD      E,01H   ; 1
        POP     HL
        RET

I71F1:  DEFB    0
        DEFB    "Bad FAT",0
        DEFB    "Bad file mode",0
        DEFB    "Bad drive name",0
        DEFB    "Bad sector number",0
        DEFB    "File still open",0
        DEFB    "File already exists",0
        DEFB    "Disk full",0
        DEFB    "Too many files",0
        DEFB    "Disk write protected",0
        DEFB    "Disk I/O error",0
        DEFB    "Disk offline",0
        DEFB    "Rename across disk",0


I72AA:  DEFW    J72AC

J72AC:  BIT     7,C
        JP      NZ,J7192                ; bad fat error
        RES     0,C
        LD      B,00H
        LD      HL,I72BE
        ADD     HL,BC
J72B9:  LD      A,(HL)
        INC     HL
        LD      H,(HL)
        LD      L,A
        JP      (HL)

I72BE:  DEFW    J71AA
        DEFW    J71B0
        DEFW    J71AD
        DEFW    J71AD
        DEFW    J71AD
        DEFW    J71AD
        DEFW    J71AD

;         Subroutine __________________________
;            Inputs  ________________________
;            Outputs ________________________

C72CC:  CALL    C72D6
        EX      (SP),HL
        CP      (HL)
        JR      NZ,J731F                ; syntax error
        INC     HL
        EX      (SP),HL
        INC     HL

;         Subroutine __________________________
;            Inputs  ________________________
;            Outputs ________________________

C72D6:  DEC     HL

;         Subroutine __________________________
;            Inputs  ________________________
;            Outputs ________________________

C72D7:  LD      IX,M4666
        JR      J7323

J72DD:  LD      IX,M6671
        JR      J7323

J72E3:  LD      IX,M406D
        JR      J7323

J72E9:  LD      IX,M6275
        JR      J7323

J72EF:  LD      IX,M6E77
        JR      J7323

J72F5:  LD      IX,M6E83
        JR      J7323

J72FB:  LD      IX,M6E7A
J72FF:  JR      J7323

J7301:  LD      IX,M6E6E
        JR      J7323

J7307:  LD      IX,M6E7D
        JR      J7323

J730D:  LD      IX,M6E6B
        JR      J7323

J7313:  LD      IX,M6E74
        JR      J7323

J7319:  LD      IX,M475A
        JR      J7323

J731F:  LD      IX,M4055
J7323:  JP      CALBAS

C7326:  PUSH    HL
        PUSH    DE
I7328:  LD      A,(YF348)
        ADD     A,A
        LD      HL,16
        JR      NC,J7333
        LD      L,16+8
J7333:  ADD     HL,SP
        LD      E,(HL)
        INC     HL
        LD      D,(HL)
        PUSH    HL
        LD      HL,M6E92+3
        RST     20H
        POP     HL
        JR      Z,J734C
        PUSH    HL
        LD      HL,M6EC6+3
        RST     20H
        POP     HL
        JR      NZ,J7352
        LD      DE,XF377
        JR      J734F

J734C:  LD      DE,XF37A
J734F:  LD      (HL),D
        DEC     HL
        LD      (HL),E
J7352:  POP     DE
        POP     HL
        LD      A,E
        CP      02H     ; 2
        RET     C
        LD      A,(HL)
        CP      ":"
        JR      Z,J730D                 ; bad filename error
        INC     HL
        LD      A,(HL)
        CP      ":"
        DEC     HL
        RET     NZ
        CALL    C7381
        LD      A,(HL)
        AND     0DFH
        SUB     40H
        PUSH    HL
        LD      HL,YF347
        CP      (HL)
        POP     HL
        JR      Z,J7376
        JP      NC,J7198                ; bad drive name error
J7376:  INC     HL
        INC     HL
        DEC     E
        DEC     E
        PUSH    DE
        INC     E
        POP     DE
        RET

C737E:  LD      A,0
        RET


;         Subroutine __________________________
;            Inputs  ________________________
;            Outputs ________________________

C7381:  PUSH    HL
        PUSH    AF
        LD      A,(YF348)
        ADD     A,A
        LD      HL,12
        JR      NC,J738E
        LD      L,12+8
J738E:  ADD     HL,SP
        LD      (HL),LOW RETRTN
        INC     HL
        LD      (HL),HIGH RETRTN
        POP     AF
        POP     HL
        RET

;       Subroutine      BDOS 09 (output string)
;       Inputs          DE = address of string
;       Outputs         ________________________
;       Remark          is copied to 0F1C9H

A7397:  call    XF36B                   ; enable ram on page 1
        ld      a,(de)
        call    XF368                   ; enable system diskrom
        inc     de
        cp      '$'
        ret     z                       ; end of string, quit
        call    A53A8                   ; console output
        jr      A7397                   ; next

;       Subroutine      XFER (transfer)
;       Inputs          HL = source address, DE = destition address, BC = size
;       Outputs         ________________________
;       Remark          is copied to 0F1D9H

        call    XF36B                   ; enable ram on page 1
        ldir                            ; transfer
        call    XF368                   ; enable system diskrom
        ret

;       Subroutine      Warm Boot
;       Inputs          ________________________
;       Outputs         ________________________
;       Remark          is copied to 0F1E2H

        call    XF36B                   ; enable ram on page 1
        jp      0                       ; WBOOT

;       Subroutine      start handler in DOS memory
;       Inputs          HL = address of pointer
;       Outputs         ________________________
;       Remark          is copied to 0F1E8H

        ld      de,XF1D9+5
        push    de                      ; on return, enable system diskrom
        ld      e,(hl)
        inc     hl
        ld      d,(hl)                  ; get pointer
        ex      de,hl
        call    XF36B                   ; enable ram on page 1
        jp      (hl)                    ; start it

;       Subroutine      validate FCB filename
;       Inputs          HL = address of pointer
;       Outputs         ________________________
;       Remark          is copied to 0F1F4H

        jp      A5604

;       Data            table with reserved filenames (devicenames)
;       Remark          is copied to 0F1F7H

        defb    "PRN "
        defb    "LST "
        defb    "NUL "
        defb    "AUX "
        defb    "CON "

;       Data            fake direntry for devices
;       Remark          is copied to 0F20BH

        defb    "           "
        defb    10000000b
        defs    10
        defw    0
        defw    0
        defw    0
        defw    0,0

        defb    31,28,31,30,31,30,31,31,30,31,30,31

; DRIVER section starts here

DSKDRV:

        INCLUDE DRIVER.ASM

        DEFS    08000H-$,0

        end
