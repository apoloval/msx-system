;  
;   SVI707CP -> Source re-created by Z80DIS 2.2
;      Z80DIS was written by Kenneth Gielow
;                            Palo Alto, CA

        .Z80
        ORG     4000H

BUGFIX  EQU     1

INITXT  EQU     006CH
INIT32  EQU     006FH
CHPUT   EQU     00A2H
C0A36   EQU     0A36H
D3FF1   EQU     3FF1H
D3FF2   EQU     3FF2H
D3FF3   EQU     3FF3H
D3FF4   EQU     3FF4H

D7FB8   EQU     7FB8H
D7FB9   EQU     7FB9H
D7FBA   EQU     7FBAH
D7FBB   EQU     7FBBH
D7FBC   EQU     7FBCH
D7FBF   EQU     7FBFH

IB800   EQU     0B800H  ; 6845 display RAM

CNSDFG  EQU     0F3DEH
FNKSTR  EQU     0F87FH
H.KEYI  EQU     0FD9AH

; Unallowed system space. breaks MSX2 and higher compatibility

DFFD0   EQU     0FFD0H  ; transfer address
DFFD2   EQU     0FFD2H  ; 00 = CP/M loaded from disk succesfull, 01 = CP/M loaded from disk failed
DFFD3   EQU     0FFD3H  ; retry counter
IFFEE   EQU     0FFEEH  ; temporary stack
DFFEF   EQU     0FFEFH  ; flag ?
DFFF0   EQU     0FFF0H  ; IOBY feature flag
DFFF1   EQU     0FFF1H  ; track
DFFF2   EQU     0FFF2H  ; record
DFFF5   EQU     0FFF5H  ; CP/M primairy slot configuration
DFFFA   EQU     0FFFAH  ; diskdrive slot
DFFFB   EQU     0FFFBH  ; motor on/off
DFFFC   EQU     0FFFCH  ; motor timer
DFFFD   EQU     0FFFDH  ; ram slot
DFFFE   EQU     0FFFEH  ; 80 column slot

I4000:  DEFB    "AB"
        DEFW    I4013                   ; INIT
        DEFW    0                       ; STATEMENT
        DEFW    0                       ; DEVICE
        DEFW    0                       ; BASIC
        DEFS    6,0

?4010:  JP      J45B2

I4013:  DI
        LD      HL,0C000H
        LD      (DFFD0),HL              ; set transfer address
        IN      A,(0A8H)
        LD      (DFFF5),A               ; save current primary slot register
        LD      (DFFFA),A               ; diskdrive slot (page 1)
        AND     0FCH
        LD      (DFFFD),A               ; start with primary slot 0 on page 0
J4027:  LD      HL,0                    ; page 0
        OUT     (0A8H),A
        CALL    C4275                   ; test RAM
        JR      C,J4045                 ; found RAM,
        LD      A,(DFFFD)
        AND     03H
        CP      03H                     ; all primary slots done ?
        JP      Z,J42AF                 ; yep, boot DiskBasic/MSX-DOS
        LD      A,(DFFFD)
        ADD     A,01H
        LD      (DFFFD),A
        JR      J4027                   ; next primary slot

J4045:  LD      A,(DFFFD)
        AND     0CFH
        LD      (DFFFD),A               ; start with primary slot 0 on page 2
J404D:  LD      HL,08000H               ; page 2
        OUT     (0A8H),A
        CALL    C4275                   ; test RAM
        JR      C,J406B                 ; found RAM,
        LD      A,(DFFFD)
        AND     30H
        CP      30H                     ; all primary slots done ?
        JP      Z,J42AF                 ; yep, boot DiskBasic/MSX-DOS
        LD      A,(DFFFD)
        ADD     A,10H
        LD      (DFFFD),A
        JR      J404D                   ; next primary slot

J406B : LD      A,(DFFF5)
        AND     0FCH
        LD      (DFFF5),A
        LD      A,(DFFFD)
        AND     03H                     ; primary slot with RAM on page 0
        LD      HL,DFFF5
        OR      (HL)
        LD      (DFFF5),A
        OUT     (0A8H),A
        LD      SP,03FF0H               ; stack on page 0
        LD      A,(DFFF5)
        LD      (D3FF1),A
        LD      A,(DFFFD)
        LD      (D3FF2),A
        LD      A,(D3FF2)
        AND     3FH
        LD      (D3FF2),A
J4098:  LD      HL,0C000H               ; page 3
        OUT     (0A8H),A
        CALL    C4275                   ; test RAM
        JR      C,J40B6                 ; found RAM,
        LD      A,(D3FF2)
        AND     0C0H
        CP      0C0H                    ; all primary slots done ?
        JP      Z,J42AF                 ; yep, boot DiskBasic/MSX-DOS
        LD      A,(D3FF2)
        ADD     A,40H
        LD      (D3FF2),A
        JR      J4098                   ; next primary slot

J40B6:  LD      A,(D3FF2)
        LD      (D3FF1),A
        LD      HL,I4230
        LD      DE,0
        LD      BC,000FAH
        LDIR                            ; helper routine search RAM on page 1
        CALL    0                       ; search RAM on page 1
        JP      NC,J42AF                ; not found, boot DiskBasic/MSX-DOS
        LD      A,(D3FF1)
        LD      (DFFF5),A
        LD      A,(D3FF2)
        LD      (DFFFD),A
        XOR     A
        LD      (DFFEF),A
        LD      SP,IFFEE

        LD      A,0EH
        OUT     (78H),A                 ; select 6845 register 14 (cursor address high)
        LD      A,25H
        OUT     (79H),A                 ; write register
        LD      A,0FH
        OUT     (78H),A			; select 6845 register 15 (cursor address low)
        LD      A,0A2H
        OUT     (79H),A                 ; write register
        LD      A,0EH
        OUT     (78H),A                 ; select 6845 register 14 (cursor address high)
        IN      A,(79H)                 ; read register
        AND     3FH                     ; 6 bits
        CP      25H                     ; register still holds value written ?
        JP      NZ,J457A                ; nope, no SVI727, boot CP/M without 80 column card
        LD      A,0FH
        OUT     (78H),A			; select 6845 register 15 (cursor address low)
        IN      A,(79H)                 ; read register
        CP      0A2H                    ; register still holds value written ?
        JP      NZ,J457A                ; nope, no SVI727, boot CP/M without 80 column card
        IN      A,(0A8H)
        LD      (DFFF5),A
        AND     0CFH
        LD      (DFFFE),A               ; 80 column slot
J4112:  LD      A,(DFFFE)
        OUT     (0A8H),A
        LD      HL,08000H               ; page 2
        CALL    C4275                   ; test RAM
        JR      C,J4124                 ; found RAM at 08000H, not the SVI727 slot
        CALL    C4290                   ; Test 6845 VRAM
        JR      C,J4133                 ; found RAM at 0B800H, found the SVI727 slot
J4124:  LD      A,(DFFFE)
        ADD     A,10H
        LD      (DFFFE),A               ; next slot
        AND     30H
        JR      NZ,J4112
        JP      J457A                   ; no SVI727, boot CP/M without 80 column card

; Boot CP/M with 80 column card

J4133:  LD      A,(DFFFE)
        AND     30H
        LD      (DFFFE),A               ; register 80 column card slot
        CALL    C42F8                   ; save slot config and enable 80 column card on page 2
        LD      D," "
        LD      HL,IB800
        LD      BC,25*80
J4146:  LD      (HL),D
        INC     HL
        DEC     BC
        LD      A,B
        OR      C
        JR      NZ,J4146                ; clear 80 column display
        CALL    C430D                   ; restore slot config
        LD      A,(DFFEF)
        AND     A
        LD      HL,I4455                ; no 64KB
        JR      NZ,J415C
        LD      HL,I4339                ; loading
J415C:  LD      DE,IB800+10*80
        LD      A,(HL)
        LD      C,A
        LD      B,0
        INC     HL
        CALL    C42F8                   ; save slot config and enable 80 column card on page 2
        LDIR                            ; display message on 80 column display
        CALL    C430D                   ; restore slot config
        LD      HL,I4315
        LD      B,16
J4171:  LD      A,(HL)
        OUT     (78H),A
        INC     HL
        LD      A,(HL)
        OUT     (79H),A
        INC     HL
        DJNZ    J4171                   ; initialize 6845
        LD      A,(DFFEF)
        AND     A                       ;
        RET     NZ
        CALL    C45A6                   ; CP/M functionkey definition
        XOR     A
        LD      (CNSDFG),A              ; functionkey display off
        LD      A,83H                   ; LIST = LPT:, PUNCH = TTY:, READER = TTY:, CONSOLE = UC1:
        LD      (DFFF0),A               ; IOBY
        IN      A,(0A8H)
        LD      (DFFF5),A
        AND     0FCH
        OUT     (0A8H),A
        CALL    C0A36                   ; illegal call to non-documented routine: cursor off
        CALL    INIT32                  ; screen mode 1
        LD      HL,I4487-1              ; CP/M message
J419E:  INC     HL
        LD      A,(HL)
        CP      0FFH
        JR      Z,J41A9
        CALL    CHPUT
        JR      J419E

J41A9:  DI
        CALL    C46CD                   ; select diskdrive slot in page 1
        CALL    C4666                   ; select drive 0, motor on
        LD      B,03H
        CALL    C467E                   ; ?? delay
        CALL    C465A                   ; select track 0
        LD      A,0
        LD      (D3FF4),A
        LD      (DFFF1),A               ; track 0
        LD      (DFFF2),A               ; record 0
        CALL    C45B9                   ; read record from disk
        LD      HL,(DFFD0)              ; transfer address
        LD      BC,00039H
        ADD     HL,BC
        LD      A,(HL)
        LD      (D3FF3),A               ; number of records
        INC     HL
        LD      E,(HL)
        INC     HL
        LD      D,(HL)                  ; start of CP/M
        LD      A,0C3H
        LD      (0),A
        PUSH    DE
        POP     HL
        LD      (1),HL                  ; create WBOOT entry
        XOR     A
        LD      B,A                     ; track 0
        LD      A,0
        LD      C,A                     ; record 0
J41E4:  PUSH    BC
        LD      A,B
        LD      (DFFF1),A               ; track
        LD      A,C
        LD      (DFFF2),A               ; record
        PUSH    DE
        CALL    C45B9                   ; read record from disk
        POP     DE
        LD      HL,(DFFD0)              ; transfer address
        LD      BC,256
        LDIR
        POP     BC
        INC     C                       ; next record
        LD      A,C
        CP      17
        JR      NZ,J4204
        LD      C,0                     ; record 0
        INC     B                       ; next track
J4204:  LD      A,(D3FF3)
        DEC     A
        LD      (D3FF3),A
        JR      NZ,J41E4
        LD      HL,H.KEYI
        LD      DE,H.KEYI+1
        LD      (HL),0C9H
        LD      BC,00230H
        LDIR                            ; clear HOOKS
        LD      HL,I4228
        LD      DE,0C000H
        LD      BC,9
        LDIR                            ; helper routine
        JP      0C000H                  ; enable RAM and start CP/M

I4228:  LD      A,(DFFFD)
        OUT     (0A8H),A                ; RAM on all pages
        JP      0                       ; start CP/M

I4230:  LD      A,(D3FF2)
        AND     0F3H
        LD      (D3FF2),A
J4238:  LD      HL,04000H
        PUSH    HL
        OUT     (0A8H),A
        LD      B,40H
        LD      C,A
J4241:  LD      (HL),A
        INC     A
        INC     H
        DEC     B
        JR      NZ,J4241
        POP     HL
        LD      A,C
        LD      B,40H
J424B:  CP      (HL)
        JR      NZ,J425A
        INC     A
        INC     H
        DEC     B
        JR      NZ,J424B
        LD      A,(D3FF1)
        OUT     (0A8H),A
        SCF
        RET

J425A:  LD      A,(D3FF2)
        AND     0CH
        CP      0CH
        JR      Z,J426D
        LD      A,(D3FF2)
        ADD     A,04H
        LD      (D3FF2),A
        JR      J4238

J426D:  LD      A,(D3FF1)
        OUT     (0A8H),A
        SCF
        CCF
        RET

;        Subroutine Test RAM
;           Inputs  ________________________
;           Outputs ________________________

C4275:  PUSH    HL
        LD      B,50
        LD      C,A
J4279:  LD      (HL),A
        INC     A
        INC     H
        DEC     B
        JR      NZ,J4279
        POP     HL
        LD      A,C
        LD      B,50
J4283:  CP      (HL)
        JR      NZ,J428D
        INC     A
        INC     H
        DEC     B
        JR      NZ,J4283
        SCF
        RET

J428D:  SCF
        CCF
        RET

;        Subroutine Test 6845 VRAM
;           Inputs  ________________________
;           Outputs ________________________

C4290:  LD      HL,IB800+10
        LD      B,64
        LD      C,A
J4296:  LD      (HL),A
        INC     A
        INC     HL
        DEC     B
        JR      NZ,J4296
        LD      HL,IB800+10
        LD      B,64
        LD      A,C
J42A2:  CP      (HL)
        JR      NZ,J42AC
        INC     A
        INC     HL
        DEC     B
        JR      NZ,J42A2
        SCF
        RET

J42AC:  SCF
        CCF
        RET

; boot DiskBasic/MSX-DOS

J42AF:  LD      HL,I42BD
        LD      DE,0E000H
        LD      BC,00064H               ; BUG: should be LD BC,I42CC-I42AF
        LDIR
        JP      0E000H

I42BD:  LD      A,(D7FBF)               ; select MSX Disk Kernel ROM
        IN      A,(0A8H)
        IFDEF   BUGFIX
        AND     0F0H
        ELSE
        AND     30H                     ; BUG: should be AND F0H !!!
        ENDIF
        OUT     (0A8H),A                ; select slot 0 for page 1,0. leave page 3,2
        NOP
        NOP
        NOP
        JP      0                       ; reset MSX

?.42CC: LD      HL,J4384                ; disk error
        LD      DE,IB800+10*80
        LD      A,(HL)
        LD      B,0
        LD      C,A
        INC     HL
        CALL    C42F8                   ; save slot config and enable 80 column card on page 2
        LDIR                            ; disk error on 80 column screen
        CALL    C430D                   ; restore slot config
        IN      A,(0A8H)
        AND     0FCH
        LD      A,0CH
        CALL    CHPUT                   ; clear screen
        LD      HL,J4354-1              ; disk error
J42EB:  INC     HL
        LD      A,(HL)
        CP      0FFH
        JR      Z,J42F6
        CALL    CHPUT
        JR      J42EB

J42F6:  JR      J42F6                   ; halt

;        Subroutine Enable 6845 VRAM
;           Inputs  ________________________
;           Outputs ________________________

C42F8:  PUSH    AF
        PUSH    HL
        LD      A,(DFFFE)
        AND     30H
        LD      H,A
        IN      A,(0A8H)
        LD      (DFFF5),A
        AND     0CFH
        OR      H
        OUT     (0A8H),A
        POP     HL
        POP     AF
        RET

;        Subroutine Disable 6845 VRAM
;           Inputs  ________________________
;           Outputs ________________________

C430D:  PUSH    AF
        LD      A,(DFFF5)
        OUT     (0A8H),A
        POP     AF
        RET

I4315:  DEFB    000H,070H
        DEFB    001H,050H
        DEFB    002H,05BH
        DEFB    003H,009H
        DEFB    004H,01EH
        DEFB    005H,000H
        DEFB    006H,018H
        DEFB    007H,01AH
        DEFB    008H,000H
        DEFB    009H,008H
        DEFB    00AH,068H
        DEFB    00BH,008H
        DEFB    00CH,000H
        DEFB    00DH,000H
        DEFB    00EH,007H
        DEFB    00FH,081H

I4335:  DEFB    01BH,059H
        DEFB    02CH,020H
I4339:  DEFB    019H
        DEFB    "loading CP/M system . . ."
        DEFB    0FFH

J4354:  DEFB    01BH,"Y",02BH,020H
        DEFB    "DISK ERROR  ! ! !"
        DEFB    10,10,13
        DEFB    "reboot with SV-707 disk"
        DEFB    0FFH

J4384:  DEFB    0C8H
        DEFB    "DISK ERROR  ! ! !                                                                                                                                               reboot with SV-707 disk                         "

I4455:  DEFB    032H
        DEFB    "can't find 64K continuous RAM--back to MSX system"

I4487:  DEFB    01BH,"Y",029H,029H
        DEFB    "SPECTRAVIDEO"
        DEFB    01BH,"Y",02BH,024H
        DEFB    "CP/M-80  Revision 2.22"
        DEFB    01BH,"Y",02FH,029H
        DEFB    "Copyright (C)"
        DEFB    01BH,"Y",030H,026H
        DEFB    "by Digital Research"
        DEFB    0FFH

I44DA:  DEFB    "DIR",13
        DEFS    16-4,0
        DEFB    "USER "
        DEFS    16-5,0
        DEFB    "TYPE "
        DEFS    16-5,0
        DEFB    "SAVE "
        DEFS    16-5,0
        DEFB    "STAT",13
        DEFS    16-5,0
        DEFB    "REN "
        DEFS    16-4,0
        DEFB    "ERA "
        DEFS    16-4,0
        DEFB    "PIP "
        DEFS    16-4,0
        DEFB    "SUBMIT "
        DEFS    16-7,0
        DEFB    "STAT *.*",13
        DEFS    16-9,0

; Boot CP/M without 80 column card

J457A:  LD      A,(DFFEF)
        AND     A
        RET     NZ
        CALL    C45A6                   ; CP/M functionkey definition
        XOR     A
        LD      (CNSDFG),A              ; functionkey display off
        LD      A,81H                   ; LIST = LPT:, PUNCH = TTY:, READER = TTY:, CONSOLE = CRT:
        LD      (DFFF0),A               ; IOBY
        IN      A,(0A8H)
        LD      (DFFF5),A
        AND     0FCH
        OUT     (0A8H),A
        CALL    INITXT
        LD      HL,I4335-1              ; loading message
J459A:  INC     HL
        LD      A,(HL)
        CP      0FFH
        JP      Z,J41A9
        CALL    CHPUT
        JR      J459A

;        Subroutine __________________________
;           Inputs  ________________________
;           Outputs ________________________

C45A6:  LD      HL,I44DA
        LD      DE,FNKSTR
        LD      BC,10*16
        LDIR
        RET

J45B2:  DEC     A
        LD      (DFFEF),A
        JP      J40B6

;        Subroutine read record from disk
;           Inputs  ________________________
;           Outputs ________________________

C45B9:  CALL    C46CD                   ; select diskdrive slot in page 1
        LD      A,(DFFFC)
        OR      A                       ; motor still spinning ?
        LD      A,01H
        LD      (DFFFB),A
        JR      NZ,J45D6                ; yep, no spin-up delay
        CALL    C4666                   ; select drive 0, motor on
        LD      A,01H
        LD      (DFFFB),A
        LD      B,14H
        CALL    C467E                   ; ?? delay (motor spin-up delay)
        JR      J45DE

J45D6:  CALL    C4666                   ; select drive 0, motor on
        LD      A,01H
        LD      (DFFFB),A
J45DE:  LD      A,10
        LD      (DFFD3),A               ; max 10 retries
        DI
        LD      A,(DFFF1)
        CALL    C4695                   ; select track
        LD      HL,0C000H
        LD      (DFFD0),HL              ; transfer address
J45F0:  LD      A,(DFFF2)
        INC     A
        LD      (D7FBA),A               ; set record
        LD      A,80H                   ; read sector data
        LD      (D7FB8),A
        LD      BC,D7FBC
        LD      HL,(DFFD0)              ; transfer address
        LD      DE,0
J4605:  LD      A,(BC)
        ADD     A,A
        JP      P,J4618
        DEC     E
        JP      NZ,J4605
        DEC     D
        JP      NZ,J4605
        CALL    C4672                   ; select no drive, motor off
        JP      J463F

J4618:  LD      DE,D7FBB
        JP      J4625

J461E:  LD      A,(BC)
        ADD     A,A
        JR      C,J462B
        JP      M,J461E
J4625:  LD      A,(DE)
        LD      (HL),A
        INC     HL
        JP      J461E

J462B:  LD      A,(D7FB8)
        BIT     0,A
        JR      NZ,J462B                ; wait for FDC
        AND     1CH                     ; errors ?
        JR      Z,J4647                 ; nope,
        LD      A,(DFFD3)
        DEC     A
        LD      (DFFD3),A
        JR      NZ,J45F0
J463F:  LD      A,1
        LD      (DFFD2),A
        JP      J42AF                   ; boot DiskBasic/MSX-DOS

J4647:  LD      A,0
        LD      (DFFD2),A
        LD      A,250
        LD      (DFFFC),A
        LD      A,0
        LD      (DFFFB),A
        LD      A,(DFFD2)
        RET

;        Subroutine Select track 0
;           Inputs  ________________________
;           Outputs ________________________

C465A:  LD      A,02H                   ; select track 0
        LD      (D7FB8),A
        CALL    C46BB                   ; wait
        CALL    C46C2                   ; wait for FDC
        RET

;        Subroutine Select drive 0, motor on
;           Inputs  ________________________
;           Outputs ________________________

C4666:  LD      A,(D3FF4)
        OR      09H
        LD      (D7FBC),A
        LD      (D3FF4),A
        RET

;        Subroutine Select no drive, motor off
;           Inputs  ________________________
;           Outputs ________________________

C4672:  LD      A,(D3FF4)
        AND     0F4H
        LD      (D7FBC),A
        LD      (D3FF4),A
        RET

;        Subroutine Delay of ?? ms
;           Inputs  ________________________
;           Outputs ________________________

C467E:  PUSH    AF
        PUSH    HL
        PUSH    BC
J4681:  LD      HL,001FFH
J4684:  DEC     HL
        LD      A,L
        OR      H
        JR      NZ,J4684
        DEC     B
        JR      NZ,J4681
        POP     BC
        POP     HL
        POP     AF
        RET

?4690:  CALL    C465A                   ; select track 0
        JR      J469B

;        Subroutine Select track
;           Inputs  ________________________
;           Outputs ________________________

C4695:  LD      B,A
        LD      A,(D7FB9)
        CP      B                       ; already on track ?
        RET     Z
J469B:  LD      A,B
        LD      (D7FBB),A               ; set track
        LD      A,12H                   ; select track
        LD      (D7FB8),A
        CALL    C46BB                   ; wait
        CALL    C46C2                   ; wait for FDC
J46AA:  LD      A,(D7FB8)
        BIT     0,A
        JR      NZ,J46AA
        BIT     4,A
        JR      NZ,C4695
        LD      B,0AH
        CALL    C467E                   ; ?? delay
        RET

C46BB:  NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        RET

;        Subroutine Wait for FDC
;           Inputs  ________________________
;           Outputs ________________________

C46C2:  CALL    C46BB                   ; wait
J46C5:  LD      A,(D7FB8)
        BIT     0,A
        JR      NZ,J46C5
        RET

;        Subroutine Select diskdrive slot in page 1
;           Inputs  ________________________
;           Outputs ________________________

C46CD:  LD      A,(DFFFA)
        AND     0CH
        LD      B,A
        LD      A,(DFFFD)
        AND     0F3H
        OR      B
        OUT     (0A8H),A
        RET

?.46DC: LD      A,(DFFFD)
        OUT     (0A8H),A
        RET

        END
