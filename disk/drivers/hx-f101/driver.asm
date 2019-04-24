; Diskdriver Toshiba HX-F101 (external floppydisk controller)
; FDC   unknown, wd1793 compatible

; Source re-created by Z80DIS 2.2
; Z80DIS was written by Kenneth Gielow, Palo Alto, CA

; Code Copyrighted by Toshiba and maybe others
; Source comments by Arjen Zeilemaker

; Sourcecode supplied for STUDY ONLY
; Recreation NOT permitted without authorisation of the copyrightholders
; Driver

MYSIZE          equ     9

                                ; +0	disk motor timer disabled
                                ; +1    disk motor stop timer
                                ; +2    saved current track physical drive 0
                                ; +3    saved current track physical drive 1
                                ; +4    current phantom drive (used with 1 physical drive)
                                ; +5    saved drivenumber (DSKFMT)
                                ; +6    saved RAWFLG (DSKFMT)
                                ; +7    not used
                                ; +8    number of physical drives

SECLEN          equ     512

J4022  	EQU     4022H
BDOS    EQU     0F37DH

?7405: 	DEFB    "Producted by TOSHIBA CORPORATION.Program --- by Yasuo Shimizu ( HS dev. HSA group )"

I7458:
DEFDPB  EQU     $-1

        DEFB    0F8h            ; Media F8
        DEFW    512             ; 80 Tracks
        DEFB    0Fh             ; 9 sectors
        DEFB    04h             ; 1 side
        DEFB    01h             ; 3.5" 360 Kb
        DEFB    02h
        DEFW    1
        DEFB    2
        DEFB    112
        DEFW    12
        DEFW    355
        DEFB    2
        DEFW    5

        DEFB    0F9h            ; Media F9
        DEFW    512             ; 80 Tracks
        DEFB    0Fh             ; 9 sectors
        DEFB    04h             ; 2 sides
        DEFB    01h             ; 3.5" 720 Kb
        DEFB    02h
        DEFW    1
        DEFB    2
        DEFB    112
        DEFW    14
        DEFW    714
        DEFB    3
        DEFW    7

        DEFB    0FAh            ; Media FA
        DEFW    512             ; 80 Tracks
        DEFB    0Fh             ; 8 sectors
        DEFB    04h             ; 1 side
        DEFB    01h             ; 3.5" 320 Kb
        DEFB    02h
        DEFW    1
        DEFB    2
        DEFB    112
        DEFW    10
        DEFW    316
        DEFB    1
        DEFW    3

        DEFB    0FBh            ; Media FB
        DEFW    512             ; 80 Tracks
        DEFB    0Fh             ; 8 sectors
        DEFB    04h             ; 2 sides
        DEFB    01h             ; 3.5" 640 Kb
        DEFB    02h
        DEFW    1
        DEFB    2
        DEFB    112
        DEFW    10
        DEFW    636
        DEFB    2
        DEFW    5

        DEFB    0FCH
        DEFW    512
        DEFB    0FH
        DEFB    04H
        DEFB    00H
        DEFB    01H
        DEFW    1
        DEFB    2
        DEFB    64
        DEFW    9
        DEFW    0160H
        DEFB    2
        DEFW    5

        DEFB    0FDH
        DEFW    512
        DEFB    0FH
        DEFB    04H
        DEFB    01H
        DEFB    02H
        DEFW    1
        DEFB    2
        DEFB    112
        DEFW    12
        DEFW    0163H
        DEFB    2
        DEFW    5

        DEFB    0FEH
        DEFW    512
        DEFB    0FH
        DEFB    04H
        DEFB    00H
        DEFB    01H
        DEFW    1
        DEFB    2
        DEFB    64
        DEFW    7
        DEFW    013AH
        DEFB    1
        DEFW    3

        DEFB    0FFH
        DEFW    512
        DEFB    0FH
        DEFB    04H
        DEFB    01H
        DEFB    02H
        DEFW    1
        DEFB    2
        DEFB    112
        DEFW    10
        DEFW    013CH
        DEFB    1
        DEFW    3

OEMSTA:
J74E8: 	SCF
        RET

;         Subroutine INIHRD
;            Inputs  ________________________
;            Outputs ________________________

INIHRD:
J74EA: 	CALL    C7C53                  	; some sort of hardware ready test ?
        JR      C,J74EA                	; nope, wait
        LD      A,0D0H			; FORCE INTERRUPT, terminate without interrupt
        LD      (D7FF0),A              	; execute command
        CALL    C7CB3			; wait ?? ms
        CALL    C7CB9                  	; wait ?? ms
        LD      A,1
        LD      (D7FF5),A              	; select physical drive 1
        LD      A,00H
        LD      (D7FF4),A              	; FDD motor off
        LD      A,0                     ; drive 0
        CALL    C7C70                  	; seek to track 0
        JR      C,J74EA                	; failed,
        LD      A,00H
        LD      (D7FF4),A              	; FDD motor off
        RET

DRIVES:
J7511: 	PUSH    BC
        PUSH    AF
        CALL    GETWRK
        LD      A,1                     ; drive 1
        CALL    C7C70                  	; seek to track 0
        LD      L,2
        JR      NC,J7520               	; ok, 2 physical drives connected
        DEC     L                       ; failed, 1 physical drive connected
J7520: 	LD      (IX+8),L                ; number of physical drives
        LD      A,0
        LD      (D7FF5),A              	; select physical drive 0
        POP     AF
        JR      Z,J752D
        LD      L,2
J752D: 	POP     BC
        RET

INIENV:
J752F: 	CALL    GETWRK
        XOR     A
        LD      B,9-1
J7535: 	LD      (HL),A
        INC     HL
        DJNZ    J7535
        LD      HL,I7C31
        JP      SETINT

DSKIO:
J753F: 	EI
        LD      IX,I754C
        PUSH    IX
        JP      NC,C76CF		; DSKIO read
        JP      C7556			; DSKIO write

I754C: 	PUSH    AF
        LD      A,248
        DI
        LD      (IX+1),A
        EI
        POP     AF
        RET

;         Subroutine DSKIO write
;            Inputs  ________________________
;            Outputs ________________________

C7556: 	CALL    C7780			; prepare for FDD operation
        RET     C			; error, quit
J755A: 	LD      A,H
        AND     A			; page 2 or 3 transfer ?
        JP      M,J757E			; yep, direct IO
        CP      3EH			; page 0 transfer ?
        JR      C,J757E			; yep, direct IO
        LD      DE,(_SECBUF)
        PUSH    HL
        PUSH    BC
        LD      BC,SECLEN
        PUSH    IX
        CALL    XFER
        POP     IX
        LD      HL,(_SECBUF)
        CALL    C758E			; write sector
        POP     BC
        POP     HL
        RET     C
        JR      J7582

J757E: 	CALL    C758E			; write sector
        RET     C
J7582: 	DEC     B
        RET     Z
        CALL    C7690			; prepare for next sector
        RET     C
        JR      J755A

?758A: 	LD      A,12
        SCF
        RET

;         Subroutine write sector
;            Inputs  ________________________
;            Outputs ________________________

C758E: 	LD      E,3			; 3 retries
        CALL    C75DD			; write sector (low level)
        JR      NC,J75A6		; succes, check for verify
        JP      M,J75C5			; NOT READY, quit with error
        BIT     6,A
        JR      NZ,J75C5		; WRITE PROTECT, quit with error
        CALL    C788C			; seek suffle (long)
        LD      E,2			; 2 retries
        CALL    C75DD			; write sector (low level)
        JR      C,J75C5			; error, quit with error
J75A6: 	LD      A,(RAWFLG)
        OR      A			; verify after write ?
        RET     Z			; nope, quit
        CALL    C7628			; verify sector
        RET     NC			; succes, quit
        JP      M,J75C5			; NOT READY, quit with error
        LD      D,3
J75B4: 	LD      E,1			; 1 retry
        CALL    C75DD			; write sector (low level)
        JR      C,J75C5			; error, quit with error
        CALL    C7628			; verify sector
        RET     NC			; succes, quit
        JP      M,J75C5			; NOT READY, quit with error
        DEC     D
        JR      NZ,J75B4
J75C5: 	LD      E,A
        LD      A,2
        BIT     7,E
        RET     NZ
        LD      A,0
        BIT     6,E
        RET     NZ
        LD      A,8
        BIT     4,E
        RET     NZ
        LD      A,4
        BIT     3,E
        RET     NZ
        LD      A,12
        RET

;         Subroutine write sector (low level)
;            Inputs  ________________________
;            Outputs ________________________

C75DD: 	PUSH    HL
        PUSH    DE
        PUSH    BC
        PUSH    IX
        PUSH    IY
        CALL    C7CAB                  	; wait for command ready
        PUSH    HL
        CALL    DISINT
        POP     HL
        DI
        LD      A,0A0H                  ; WRITE SECTOR, single sector, no delay, no side compare
        LD      (D7FF0),A              	; execute command
        LD      BC,D7FF7
        LD      DE,I760D
        PUSH    DE
        LD      DE,D7FF3
        LD      IY,J7602
        EX      (SP),HL
        EX      (SP),HL
J7602: 	LD      A,(BC)
        ADD     A,A
        RET     P                       ; IRQ, quit
        JP      C,J7602                	; no DRQ, wait
        LD      A,(HL)
        LD      (DE),A
        INC     HL
        JP      (IY)

I760D: 	EI
        CALL    ENAINT
        POP     IY
        POP     IX
        POP     BC
        POP     DE
        POP     HL
        LD      A,(D7FF0)
        AND     0DCH                    ; ignore RECORD TYPE, DRQ and BUSY flags
        RET     Z                       ; no error, quit
        SCF
        RET     M                       ; NOT READY, quit
        BIT     6,A
        RET     NZ                      ; WRITE PROTECT, quit
        DEC     E
        JR      NZ,C75DD               	; try again
        SCF
        RET

;         Subroutine verify sector
;            Inputs  ________________________
;            Outputs ________________________

C7628: 	PUSH    HL
        PUSH    DE
        LD      DE,(_SECBUF)
        OR      A
        SBC     HL,DE
        JR      NZ,J766A
        PUSH    BC
        PUSH    IX
        CALL    C7CAB                  	; wait for command ready
        CALL    DISINT
        DI
        LD      A,82H                   ; READ SECTOR, single sector, no delay, side compare, side 0
        LD      (D7FF0),A
        LD      HL,I7659
        PUSH    HL
        LD      HL,J7651
        LD      DE,D7FF3
        LD      BC,D7FF7
        EX      (SP),HL
        EX      (SP),HL
J7651: 	LD      A,(BC)
        ADD     A,A
        RET     P                       ; IRQ, quit
        JP      C,J7651                	; no DRQ, wait
        LD      A,(DE)
        JP      (HL)

I7659: 	EI
        CALL    ENAINT
        POP     IX
        POP     BC
        POP     DE
        POP     HL
        LD      A,(D7FF0)
        AND     9CH                     ; ignore WRITE PROTECT,RECORD TYPE, DRQ and BUSY flags
        RET     Z                       ; no error, quit
        SCF
        RET

J766A: 	EX      DE,HL
        LD      E,1			; 1 retry
        CALL    C772B			; read sector (low level)
        POP     DE
        POP     HL
        RET     C			; error, quit
        PUSH    HL
        PUSH    DE
        PUSH    BC
        LD      DE,(_SECBUF)
        LD      BC,SECLEN
J767D: 	LD      A,(DE)
        CPI
        SCF
        JR      NZ,J768A
        JP      PO,J7689
        INC     DE
        JR      J767D

J7689: 	CCF
J768A: 	LD      A,04H
        POP     BC
        POP     DE
        POP     HL
        RET

;         Subroutine prepare for next sector
;            Inputs  ________________________
;            Outputs ________________________

C7690: 	CALL    C7CAB                  	; wait for command ready
        INC     H
        INC     H
        LD      A,(D7FF2)
        INC     A
        LD      (D7FF2),A		; next record
        BIT     1,C			; media with 9 sectors per track ?
        JP      NZ,J76A5		; nope, 8 sectors per track
        CP      9+1
        JR      C,J76CD
J76A5: 	CP      8+1
        JR      C,J76CD
        LD      A,1
        LD      (D7FF2),A              	; record 1
        LD      A,(D7FF1)
        PUSH    AF                      ; save current track
        CALL    C7CAB                  	; wait for command ready
        LD      A,54H                   ; STEP-IN (with track register update, with track verify)
        CALL    C784E                  	; execute seek
        POP     DE
        RET     NC			; succes, quit
        CALL    C7862			; seek to track 0
        JR      C,J76C9			; error, quit with error
        PUSH    BC
        LD      C,D
        INC     C
        CALL    C7845                  	; seek to track
        POP     BC
        RET     NC			; succes, quit
J76C9: 	LD      A,6
        SCF
        RET

J76CD: 	OR      A
        RET

;         Subroutine DSKIO read
;            Inputs  ________________________
;            Outputs ________________________

C76CF: 	CALL    C7780			; prepare for FDD operation
        RET     C
J76D3: 	LD      A,H
        AND     A			; page 2 or 3 transfer ?
        JP      M,J76FA			; yep, direct IO
        CP      3EH			; page 0 transfer ?
        JR      C,J76FA			; yep, direct IO
        PUSH    HL
        LD      HL,(_SECBUF)
        CALL    C7706			; read sector
        POP     HL
        RET     C
        PUSH    HL
        PUSH    BC
        PUSH    IX
        EX      DE,HL
        LD      HL,(_SECBUF)
        LD      BC,SECLEN
        CALL    XFER
        POP     IX
        POP     BC
        POP     HL
        JP      J76FE

J76FA: 	CALL    C7706			; read sector
        RET     C
J76FE: 	DEC     B
        RET     Z
        CALL    C7690			; prepare for next sector
        RET     C
        JR      J76D3

;         Subroutine __________________________
;            Inputs  ________________________
;            Outputs ________________________

C7706: 	LD      E,10			; 10 retries
        CALL    C772B			; read sector (low level)
        RET     NC			; succes, quit
        JP      M,J7718			; NOT READY, quit with error
        CALL    C788C			; seek suffle (long)
        LD      E,10			; 10 retries
        CALL    C772B			; read sector (low level)
        RET     NC			; succes, quit
J7718: 	LD      E,A
        LD      A,2
        BIT     7,E
        RET     NZ
        LD      A,8
        BIT     4,E
        RET     NZ
        LD      A,4
        BIT     3,E
        RET     NZ
        LD      A,12
        RET

;         Subroutine read sector (low level)
;            Inputs  ________________________
;            Outputs ________________________

C772B: 	PUSH    HL
        PUSH    DE
        PUSH    BC
        PUSH    IX
        PUSH    IY
        CALL    C7CAB                  	; wait for command ready
        PUSH    HL
        CALL    DISINT
        POP     HL
        DI
        LD      A,80H                   ; READ SECTOR, single sector, no delay, no side compare
        LD      (D7FF0),A
        LD      BC,D7FF7
        LD      DE,I775B
        PUSH    DE
        LD      DE,D7FF3
        LD      IY,J7750
        EX      (SP),HL
        EX      (SP),HL
J7750: 	LD      A,(BC)
        ADD     A,A
        RET     P                       ; IRQ, quit
        JP      C,J7750                	; no DRQ, wait
        LD      A,(DE)
        LD      (HL),A
        INC     HL
        JP      (IY)

I775B: 	EI
        CALL    ENAINT
        POP     IY
        POP     IX
        POP     BC
        POP     DE
        POP     HL
        LD      A,(D7FF0)
        AND     9CH                     ; ignore WRITE PROTECT, RECORD TYPE, DRQ and BUSY flags
        RET     Z                       ; no error, quit
        SCF
        RET     M                       ; NOT READY, quit
        BIT     4,A
        JR      Z,J777B
        LD      D,A
        LD      A,E
        CP      03H
        LD      A,D
        JR      C,J777B
        LD      E,2                     ; RECORD NOT FOUD, only 2 retries
J777B: 	DEC     E
        JR      NZ,C772B               	; try again
        SCF
        RET

;         Subroutine prepare for FDD operation
;            Inputs  ________________________
;            Outputs ________________________

C7780: 	PUSH    HL
        PUSH    BC
        PUSH    AF
        CALL    GETWRK
        POP     AF
        POP     BC
        CP      2			; driveid valid ?
        JR      NC,J77E0		; nope, quit with error
        PUSH    AF
        LD      A,C
        CP      0F8H			; media descriptor byte valid ?
        JR      Z,J779B			; yep,
        CP      0FAH			; media descriptor byte valid ?
        JR      Z,J779B			; yep,
        POP     AF
        LD      A,10
        JR      J77E2			; quit with error

J779B: 	POP     AF
        CALL    C77E5			; setup for FDD operation
        JR      NC,J77A5		; succes, continue
        LD      A,2
        JR      J77E2			; quit with error

J77A5: 	PUSH    BC
        BIT     1,C			; 9 sectors per track media ?
        LD      C,E
        LD      B,D
        LD      DE,9
        JR      Z,J77B0			; yep,
        DEC     E			; 8 sectors per track
J77B0: 	PUSH    IX
        CALL    DIV16			; calculate track
        POP     IX
        CALL    C7CAB                  	; wait for command ready
        LD      A,L
        INC     A			; record in track is 1 based
        LD      (D7FF2),A		; setup record
        LD      A,(D7FF5)
        RRA                             ; current selected physical drive
        LD      A,(IX+2)
        JR      NC,J77CB               	; drive 0,
        LD      A,(IX+3)
J77CB: 	LD      (D7FF1),A		; setup track
        CP      C			; same track as operation ?
        JR      Z,J77DB			; yep, quit
        CALL    C7834			; seek to track (with retry)
        JR      NC,J77DB		; succes, quit
        LD      A,6
        POP     BC
        JR      J77E2			; quit with error

J77DB: 	POP     BC
        POP     HL
        OR      A
        RET

?77DF: 	POP     AF
J77E0: 	LD      A,12
J77E2: 	POP     HL
        SCF
        RET

;         Subroutine __________________________
;            Inputs  ________________________
;            Outputs ________________________

C77E5: 	LD      L,A
        CALL    C7CAB                  	; wait for command ready
        LD      A,(D7FF5)
        RRA                             ; current selected physical drive
        LD      A,(D7FF1)
        JR      NC,J77F7               	; drive 0,
        LD      (IX+3),A
        JR      J77FA

J77F7: 	LD      (IX+2),A
J77FA: 	LD      A,L
        LD      H,(IX+8)
        DEC     H                       ; only 1 physical drive ?
        JR      NZ,J7816               	; nope,
        LD      H,(IX+4)
        LD      (IX+4),A
        CP      H
        JR      Z,J7815
        PUSH    IX
        PUSH    DE
        PUSH    BC
        CALL    PROMPT
        POP     BC
        POP     DE
        POP     IX
J7815: 	XOR     A
J7816: 	LD      (D7FF5),A              	; select physical drive
        DI
        LD      A,0FFH
        LD      (IX+1),A
        EI
        LD      A,02H
        LD      (D7FF4),A              	; FDD motor on
        LD      A,(D7FF0)
        RLA                             ; FDD ready ?
        RET     NC                      ; yep, quit
        CALL    C7C99                  	; wait for FDD ready
        RET     NC                      ; FDD ready, quit
        LD      A,00H
        LD      (D7FF4),A              	; FDD motor off
        RET

;         Subroutine seek to track (with retry)
;            Inputs  ________________________
;            Outputs ________________________

C7834: 	LD      A,C
        CP      80
        CCF
        RET     C			; invalid track, quit with error
        CALL    C7845                  	; seek to track
        RET     NC			; succes, quit
        CALL    C7862			; seek to track 0
        RET     C			; error, quit with error
        CALL    C7845                  	; seek to track
        RET

;         Subroutine seek to track
;            Inputs  ________________________
;            Outputs ________________________

C7845: 	CALL    C7CAB                  	; wait for command ready
        LD      A,C
        LD      (D7FF3),A
        LD      A,14H                   ; SEEK (with track verify)

;         Subroutine execute seek
;            Inputs  ________________________
;            Outputs ________________________

C784E: 	LD      (D7FF0),A
        EX      (SP),HL
        EX      (SP),HL
        CALL    C7CAB                  	; wait for command ready
        LD      A,(D7FF0)
        AND     10H                     ; SEEK ERROR ?
        SCF
        RET     NZ                      ; yep, quit with error
        CALL    C7CBF                  	; wait seek settle time
        OR      A
        RET

;         Subroutine __________________________
;            Inputs  ________________________
;            Outputs ________________________

C7862: 	CALL    C7CAB                  	; wait for command ready
        LD      A,(D7FF1)
        CP      72
        LD      A,40H                   ; STEP-IN (without track register update, without track verify)
        CALL    C,C78AF			; nope, seek 7 steps
        CALL    C7873                  	; seek to track 0
        RET

;         Subroutine seek to track 0
;            Inputs  ________________________
;            Outputs ________________________

C7873: 	CALL    C7CAB                  	; wait for command ready
        LD      A,00H                   ; RESTORE (without track verify)
        LD      (D7FF0),A
        EX      (SP),HL
        EX      (SP),HL
        CALL    C7CAB                  	; wait for command ready
        LD      A,(D7FF0)
        AND     04H                     ; TRACK00 ?
        SCF
        RET     Z                       ; no, quit with error
        CALL    C7CBF                  	; wait seek settle time
        OR      A
        RET

;         Subroutine seek suffle (long)
;            Inputs  ________________________
;            Outputs ________________________

C788C: 	CALL    C7CAB                  	; wait for command ready
        LD      A,(D7FF1)
        CP      72
        PUSH    AF
        LD      A,40H                   ; STEP-IN (without track register update)
        JR      C,J789B
        LD      A,60H                   ; STEP-OUT (without track register update)
J789B: 	CALL    C78AF			; seek 7 steps
        CALL    C7CBF                  	; wait seek settle time
        POP     AF
        LD      A,60H                   ; STEP-OUT (without track register update)
        JR      C,J78A8
        LD      A,40H                   ; STEP-IN (without track register update)
J78A8: 	CALL    C78AF			; seek 7 steps
        CALL    C7CBF                  	; wait seek settle time
        RET

;         Subroutine seek 7 steps
;            Inputs  ________________________
;            Outputs ________________________

C78AF: 	PUSH    BC
        LD      B,7
        PUSH    AF
        CALL    C7CAB                  	; wait for command ready
        POP     AF
J78B7: 	LD      (D7FF0),A
        EX      (SP),HL
        EX      (SP),HL
        CALL    C7CAB                  	; wait for command ready
        LD      A,20H                   ; STEP (with track register update, without track verify)
        DJNZ    J78B7
        POP     BC
        RET

;         Subroutine seek suffle (short)
;            Inputs  ________________________
;            Outputs ________________________

C78C5: 	CALL    C7CAB                  	; wait for command ready
        LD      A,40H                   ; STEP-IN (without track register update, without track verify)
        LD      (D7FF0),A
        CALL    C7CBF                  	; wait seek settle time
        CALL    C7CAB                  	; wait for command ready
        LD      A,60H                   ; STEP-OUT (without track register update, without track verify)
        LD      (D7FF0),A
        CALL    C7CBF                  	; wait seek settle time
        RET

DSKCHG:
J78DC: 	EI
        PUSH    HL
        PUSH    BC
        PUSH    AF
        CALL    GETWRK
        POP     AF
        POP     BC
        POP     HL
        LD      D,A
        LD      E,(IX+8)
        DEC     E                       ; only 1 physical drive ?
        JR      NZ,J78F8               	; nope,
        CP      (IX+4)                  ; same phantom drive as previous operation ?
        LD      A,(D7FF6)
        LD      E,A                     ; read disk change status
        JR      Z,J7913                	; yep,can use physical disk change status
        JR      J7928                  	; nope, read sector 1 to determine mediadescriptor byte of disk

J78F8: 	LD      A,(D7FF6)
        LD      E,A                     ; read disk change status
        LD      A,(D7FF5)
        AND     01H                     ; current physical drive
        CP      D                       ; same as requested ?
        JR      Z,J7913                	; yep,
        PUSH    AF
        LD      A,D
        LD      (D7FF5),A              	; select physical drive
        EX      (SP),HL
        EX      (SP),HL
        LD      A,(D7FF6)
        LD      E,A                     ; read disk change status
        POP     AF
        LD      (D7FF5),A              	; select physical drive
J7913: 	RR      E                       ; disk changed ?
        JR      NC,J7928               	; yep, read sector 1 to determine mediadescriptor byte of disk
        LD      A,C
        CP      0F8H                    ; valid mediadescriptor byte ?
        JR      Z,J7924                	; yep, return DISK NOT CHANGED
        CP      0FAH                    ; valid mediadescriptor byte ?
        JR      Z,J7924                	; yep, return DISK NOT CHANGED
        LD      A,0AH
        SCF
        RET

J7924: 	OR      A
        LD      B,1
        RET

J7928: 	LD      IY,I754C
        PUSH    IY
        LD      A,D
        LD      B,1
        PUSH    BC
        PUSH    HL
        LD      C,0F8H
        LD      DE,1			; sector 1
        LD      HL,(_SECBUF)
        CALL    C76CF			; DSKIO read
        JR      C,J795A			; error, quit
        CALL    C78C5			; seek suffle (short), to reset disk change ?
        LD      HL,(_SECBUF)
        LD      B,(HL)
        POP     HL
        PUSH    BC
        CALL    C795D			; GETDPB
        JR      C,J7958			; error, quit
        POP     AF
        POP     BC
        CP      C			; same media ?
        SCF
        CCF
        LD      B,0FFH
        RET     NZ			; no, DISK CHANGED
        INC     B			; DISK CHANGE UNKNOWN
        RET

J7958: 	LD      A,10
J795A: 	POP     DE
        POP     DE
        RET

;         Subroutine __________________________
;            Inputs  ________________________
;            Outputs ________________________

GETDPB:
C795D: 	EI
        EX      DE,HL
        INC     DE
        LD      A,B
        SUB     0F8H
        RET     C
        LD      L,A
        LD      H,00H
        ADD     HL,HL
        LD      C,L
        LD      B,H
        ADD     HL,HL
        ADD     HL,HL
        ADD     HL,HL
        ADD     HL,BC
        LD      BC,I7458
        ADD     HL,BC
        LD      BC,18
        PUSH    DE
        LDIR
        POP     HL
        DEC     HL
        OR      A
        RET

CHOICE:
J797C: 	LD      HL,0
        RET

DSKFMT:
J7980: 	LD      HL,I754C
        PUSH    HL
        CALL    GETWRK
        LD      A,D
        CP      2			; driveid valid ?
        JR      NC,J79ED		; nope, quit with error
        LD      (IX+5),A
        CALL    C77E5			; setup for FDD operation
        JR      C,J79F0			; error, quit with error
        CALL    C7873			; seek to track 0
        JR      C,J79F3			; error, quit with error
        EX      AF,AF'
        PUSH    AF
        XOR     A
        EX      AF,AF'
J799D: 	LD      B,10
J799F: 	PUSH    BC
        CALL    C7AC2                  	; format track
        AND     0C4H                    ; ignore WRITE FAULT, RECORD TYPE, DRQ and BUSY flags
        POP     BC
        JR      Z,J79AE                	; no error,
        BIT     2,A			; LOST DATA ?
        JR      Z,J79D1			; nope, quit with error
        JR      J79CF			; try again

J79AE: 	LD      A,(RAWFLG)
        OR      A			; verify after write ?
        JR      NZ,J79CA		; yep,
J79B4: 	EX      AF,AF'
        INC     A
        LD      C,A
        EX      AF,AF'
        LD      A,C
        CP      80
        JR      NC,J79F7		; finished
        CALL    C7CAB                  	; wait for command ready
        LD      A,50H                   ; STEP-IN (with track register update, without track verify)
        LD      (D7FF0),A
        CALL    C7CBF                  	; wait seek settle time
        JR      J799D

J79CA: 	CALL    C7BEA			; verify sectors on track
        JR      NC,J79B4		; succes, continue
J79CF: 	DJNZ    J799F
J79D1: 	EX      AF,AF'
        POP     AF
        EX      AF,AF'
        SCF
        LD      E,A
        LD      A,2
        BIT     7,E
        RET     NZ
        LD      A,0
        BIT     6,E
        RET     NZ
        LD      A,8
        BIT     4,E
        RET     NZ
        LD      A,4
        BIT     3,E
        RET     NZ
        LD      A,10
        RET

J79ED: 	LD      A,16
	DEFB	001H
J79F0: 	LD	A,2
	DEFB	001H
J79F3: 	LD	A,6
        SCF
        RET

J79F7: 	EX      AF,AF'
        POP     AF
        EX      AF,AF'
        CALL    C7873			; seek to track 0
        JP      C,J79F3			; error, quit with error
        LD      A,(RAWFLG)
        LD      (IX+6),A		; save RAWFLG
        LD      A,0FFH
        LD      (RAWFLG),A		; verify after write
        LD      HL,I7D05
        LD      DE,(_SECBUF)
        LD      BC,L7D05
        LDIR
        LD      BC,SECLEN-L7D05
J7A1A: 	XOR     A
        LD      (DE),A
        INC     DE
        DEC     BC
        LD      A,B
        OR      C
        JR      NZ,J7A1A		; construct boot sector
        LD      A,(IX+5)
        LD      HL,(_SECBUF)
        LD      BC,01F8H
        LD      DE,0			; sector 0
        PUSH    HL
        CALL    C7556			; DSKIO write, write boot sector
        POP     HL
        JR      C,J7AAC			; error, quit with error
        LD      A,0F8H
        LD      (HL),A
        INC     HL
        LD      A,0FFH
        LD      (HL),A
        INC     HL
        LD      (HL),A
        INC     HL
        XOR     A
        LD      B,256-3
J7A42: 	LD      (HL),A
        INC     HL
        DJNZ    J7A42
J7A46: 	LD      (HL),A
        INC     HL
        DJNZ    J7A46			; construct 1st FAT sector
        LD      BC,01F8H
        LD      DE,1			; 1st FAT sector of first FAT
        LD      HL,(_SECBUF)
        PUSH    HL
        PUSH    BC
        LD      A,(IX+5)
        CALL    C7556			; DSKIO write, write 1st FAT sector of first FAT
        POP     BC
        POP     HL
        JP      C,J7AAC			; error, quit with error
        PUSH    HL
        PUSH    BC
        LD      DE,3			; 1st FAT sector of second FAT
        LD      A,(IX+5)
        CALL    C7556			; DSKIO write, write 1st FAT sector of second FAT
        POP     BC
        POP     HL
        JP      C,J7AAC			; error, quit with error
        PUSH    HL
        XOR     A
        LD      (HL),A
        INC     HL
        LD      (HL),A
        INC     HL
        LD      (HL),A
        POP     HL			; construct 2nd FAT sector
        PUSH    HL
        LD      DE,2
        LD      A,(IX+5)
        CALL    C7556			; DSKIO write, write 2nd FAT sector of first FAT
        POP     HL
        JP      C,J7AAC			; error, quit with error
        LD      B,8
        LD      DE,4
        LD      A,(IX+5)
J7A8E: 	PUSH    AF
        PUSH    BC
        PUSH    DE
        PUSH    HL
        LD      BC,01F8H
        CALL    C7556			; DSKIO write
        JP      C,J7ABC			; error, quit with error
        POP     HL
        POP     DE
        POP     BC
        POP     AF
        INC     DE
        DJNZ    J7A8E			; write 2nd FAT sector of second FAT and DIR sectors
        PUSH    AF
        LD      A,(IX+6)
        LD      (RAWFLG),A		; restore old RAWFLG
        POP     AF
        OR      A
        RET

J7AAC: 	CP      10
        JR      NZ,J7AB2
        LD      A,16
J7AB2: 	PUSH    AF
        LD      A,(IX+6)
        LD      (RAWFLG),A
        POP     AF
        SCF
        RET

J7ABC: 	POP     BC
        POP     BC
        POP     BC
        POP     BC
        JR      J7AB2

;         Subroutine format track
;            Inputs  ________________________
;            Outputs ________________________

C7AC2: 	PUSH    IX
        LD      HL,I7BDC
        PUSH    HL
        EX      AF,AF'
        PUSH    AF
        CALL    DISINT
        DI
        POP     AF
        EX      AF,AF'
        CALL    C7CAB                  	; wait for command ready
        LD      A,0F0H                  ; WRITE TRACK (no delay)
        LD      (D7FF0),A
        LD      C,1
        LD      B,80
        LD      HL,D7FF3
        LD      DE,D7FF7
        EX      (SP),HL
        EX      (SP),HL
J7AE4: 	LD      A,(DE)
        ADD     A,A
        RET     P                       ; IRQ, quit
        JP      C,J7AE4                	; no DRQ, wait
        LD      (HL),4EH
        DJNZ    J7AE4
        LD      B,12
J7AF0: 	LD      A,(DE)
        ADD     A,A
        RET     P
        JP      C,J7AF0
        LD      (HL),00H
        DJNZ    J7AF0
        LD      B,3
J7AFC: 	LD      A,(DE)
        ADD     A,A
        RET     P
        JP      C,J7AFC
        LD      (HL),0F6H
        DJNZ    J7AFC
J7B06: 	LD      A,(DE)
        ADD     A,A
        RET     P
        JP      C,J7B06
        LD      (HL),0FCH
        LD      B,1AH
J7B10: 	LD      A,(DE)
        ADD     A,A
        RET     P
        JP      C,J7B10
        LD      (HL),4EH
        DJNZ    J7B10
J7B1A: 	LD      B,12
J7B1C: 	LD      A,(DE)
        ADD     A,A
        RET     P
        JP      C,J7B1C
        LD      (HL),0
        DJNZ    J7B1C
        LD      B,3
J7B28: 	LD      A,(DE)
        ADD     A,A
        RET     P
        JP      C,J7B28
        LD      (HL),0F5H
        DJNZ    J7B28
J7B32: 	LD      A,(DE)
        ADD     A,A
        RET     P
        JP      C,J7B32
        LD      (HL),0FEH
J7B3A: 	LD      A,(DE)
        ADD     A,A
        RET     P
        JP      C,J7B3A
        EX      AF,AF'
        LD      (HL),A
        EX      AF,AF'
J7B43: 	LD      A,(DE)
        ADD     A,A
        RET     P
        JP      C,J7B43
        LD      (HL),00H
J7B4B: 	LD      A,(DE)
        ADD     A,A
        RET     P
        JP      C,J7B4B
        LD      (HL),C
J7B52: 	LD      A,(DE)
        ADD     A,A
        RET     P
        JP      C,J7B52
        LD      (HL),2
J7B5A: 	LD      A,(DE)
        ADD     A,A
        RET     P
        JP      C,J7B5A
        LD      (HL),0F7H
        LD      B,16H
J7B64: 	LD      A,(DE)
        ADD     A,A
        RET     P
        JP      C,J7B64
        LD      (HL),4EH
        DJNZ    J7B64
        LD      B,12
J7B70: 	LD      A,(DE)
        ADD     A,A
        RET     P
        JP      C,J7B70
        LD      (HL),00H
        DJNZ    J7B70
        LD      B,3
J7B7C: 	LD      A,(DE)
        ADD     A,A
        RET     P
        JP      C,J7B7C
        LD      (HL),0F5H
        DJNZ    J7B7C
J7B86: 	LD      A,(DE)
        ADD     A,A
        RET     P
        JP      C,J7B86
        LD      (HL),0FBH
J7B8E: 	LD      A,(DE)
        ADD     A,A
        RET     P
        JP      C,J7B8E
        LD      (HL),0E5H
        DJNZ    J7B8E
J7B98: 	LD      A,(DE)
        ADD     A,A
        RET     P
        JP      C,J7B98
        LD      (HL),0E5H
        DJNZ    J7B98
J7BA2: 	LD      A,(DE)
        ADD     A,A
        RET     P
        JP      C,J7BA2
        LD      (HL),0F7H
        LD      B,36H
J7BAC: 	LD      A,(DE)
        ADD     A,A
        RET     P
        JP      C,J7BAC
        LD      (HL),4EH
        DJNZ    J7BAC
        INC     C
        LD      A,C
        CP      9+1
        JP      C,J7B1A
J7BBD: 	LD      A,(DE)
        ADD     A,A
        RET     P
        JP      C,J7BBD
        LD      (HL),4EH
        DJNZ    J7BBD
J7BC7: 	LD      A,(DE)
        ADD     A,A
        RET     P
        JP      C,J7BC7
        LD      (HL),4EH
        DJNZ    J7BC7
J7BD1: 	LD      A,(DE)
        ADD     A,A
        RET     P
        JP      C,J7BD1
        LD      (HL),4EH
        DJNZ    J7BD1
        POP     HL
I7BDC: 	EX      AF,AF'
        PUSH    AF
        EI
        CALL    ENAINT
        POP     AF
        EX      AF,AF'
        POP     IX
        LD      A,(D7FF0)              	; read status
        RET

;         Subroutine verify sectors on track
;            Inputs  ________________________
;            Outputs ________________________

C7BEA: 	EX      AF,AF'
        PUSH    AF
        EX      AF,AF'
        PUSH    HL
        PUSH    BC
        LD      HL,(_SECBUF)
        LD      B,01H   ; 1
J7BF4: 	CALL    C7CAB                  	; wait for command ready
        LD      A,B
        LD      (D7FF2),A
        CALL    C7628			; verify sector
        JR      C,J7C1C
        INC     B
        INC     B
        LD      A,B
        CP      9+1
        JR      C,J7BF4
        LD      B,2
J7C09: 	CALL    C7CAB                  	; wait for command ready
        LD      A,B
        LD      (D7FF2),A
        CALL    C7628			; verify sector
        JR      C,J7C1C
        INC     B
        INC     B
        LD      A,B
        CP      9
        JR      C,J7C09
J7C1C: 	POP     BC
        POP     HL
        EX      AF,AF'
        POP     AF
        EX      AF,AF'
        RET

MTOFF:
	CALL    GETWRK
        XOR     A
        DI
        LD      (HL),A
        INC     HL
        LD      (HL),A
        LD      A,00H
        LD      (D7FF4),A              	; FDD motor off
        EI
        RET

;         Subroutine interrupt handler disk driver
;            Inputs  ________________________
;            Outputs ________________________

I7C31: 	PUSH    AF
        CALL    GETWRK
        LD      A,(HL)
        OR      A                       ; disk motor timer disabled ?
        JP      NZ,J7C4F               	; yep, quit
        INC     HL
        LD      A,(HL)
        OR      A                       ; disk motor timer already finished ?
        JP      Z,J7C4F                	; yep, quit
        CP      0FFH                    ; disk motor timer paused ?
        JP      Z,J7C4F                	; yep, quit
        DEC     A
        LD      (HL),A                  ; disk motor timer finshed ?
        JP      NZ,J7C4F
        LD      A,00H
        LD      (D7FF4),A              	; FDD motor off
J7C4F: 	POP     AF
        JP      PRVINT

;         Subroutine __________________________
;            Inputs  ________________________
;            Outputs ________________________

C7C53: 	XOR     A
        LD      (D7FF5),A              	; select physical drive 0
        INC     A
        LD      (D7FF6),A		; ??
        LD      A,(D7FF5)
        AND     01H                     ; drive select register working ok ?
        SCF
        RET     NZ                      ; nope, quit
        INC     A
        LD      (D7FF5),A              	; select physical drive 1
        DEC     A
        LD      (D7FF6),A		; ??
        LD      A,(D7FF5)
        RRA
        CCF				; drive select register working ok/faulty
        RET

;         Subroutine seek to track 0
;            Inputs  A = physical drive
;            Outputs ________________________

C7C70: 	LD      (D7FF5),A              	; select physical drive
        CALL    C7CAB                  	; wait for command ready
        LD      A,00H                   ; RESTORE (without track verify)
        LD      (D7FF0),A
        EX      (SP),HL
        EX      (SP),HL
        LD      HL,45000
J7C80: 	LD      A,(D7FF0)
        RRA                             ; RESTORE finished ?
        JR      NC,J7C94               	; yep, quit
        DEC     HL
        LD      A,H
        OR      L
        JR      NZ,J7C80
        LD      A,0D0H			; FORCE INTERRUPT, terminate without interrupt
        LD      (D7FF0),A              	; execute command
        EX      (SP),HL
        EX      (SP),HL
        SCF
        RET

J7C94: 	AND     02H     ; 2
        RET     NZ
        SCF
        RET

;         Subroutine wait for FDD ready
;            Inputs  ________________________
;            Outputs ________________________

C7C99: 	PUSH    HL
        LD      HL,64000
J7C9D: 	LD      A,(D7FF0)
        RLA
        JR      NC,J7CA9
        DEC     HL
        LD      A,H
        OR      L
        JR      NZ,J7C9D
        SCF
J7CA9: 	POP     HL
        RET

;         Subroutine wait for command ready
;            Inputs  ________________________
;            Outputs ________________________

C7CAB: 	LD      A,(D7FF0)
        RRA
        RET     NC
        JP      C7CAB

;         Subroutine __________________________
;            Inputs  ________________________
;            Outputs ________________________

C7CB3: 	PUSH    HL
        LD      HL,48000
        JR      J7CC9

;         Subroutine __________________________
;            Inputs  ________________________
;            Outputs ________________________

C7CB9: 	PUSH    HL
        LD      HL,24000
        JR      J7CC9

;         Subroutine __________________________
;            Inputs  ________________________
;            Outputs ________________________

C7CBF: 	PUSH    HL
        LD      HL,2400
        JR      J7CC9

?7CC5: 	PUSH    HL
        LD      HL,2400
J7CC9: 	DEC     HL
        LD      A,H
        OR      L
        JR      NZ,J7CC9
        POP     HL
        RET

?7CD0: 	POP     HL
        LD      A,(HL)
        OR      A
        SCF
        RET     NZ
        DEC     A
        LD      (RAWFLG),A
        OR      A
        RET

?7CDB: 	POP     HL
        LD      A,(HL)
        OR      A
        SCF
        RET     NZ
        LD      (RAWFLG),A
        OR      A
        RET

?7CE5: 	POP     HL
        LD      A,(HL)
        OR      A
        SCF
        RET     NZ
        PUSH    HL
        CALL    GETWRK
        POP     HL
        LD      A,0FFH
        LD      (IX+0),A
        OR      A
        RET

?7CF6: 	POP     HL
        LD      A,(HL)
        OR      A
        SCF
        RET     NZ
        PUSH    HL
        CALL    GETWRK
        POP     HL
        XOR     A
        LD      (IX+0),A
        RET

I7D05:
        .PHASE  0C000H

        DEFB    0EBH                    ; x86 JMP +0100H
        DEFB    0FEH
        DEFB    090H                    ; x86 NOP
        DEFB    "ASC  2.2"
        DEFW    512
        DEFB    2
        DEFW    1
        DEFB    2
        DEFW    112
        DEFW    02D0H
        DEFB    0F8H
        DEFW    2
        DEFW    9
        DEFW    1
        DEFW    0

        RET     NC
        LD      (DC058+1),DE
        LD      (DC0C4),A
        LD      (HL),LOW DC056
        INC     HL
        LD      (HL),HIGH DC056
J7430:  LD      SP,KBUF+256
        LD      DE,DC09F
        LD      C,0FH   ; 15
        CALL    BDOS
        INC     A
        JP      Z,DC063
        LD      DE,0100H
        LD      C,1AH
        CALL    BDOS
        LD      HL,1
        LD      (DC09F+14),HL
        LD      HL,04000H-0100H
        LD      DE,DC09F
        LD      C,27H
        CALL    BDOS
        JP      0100H

DC056:  DEFW    DC058

DC058:  CALL    0
        LD      A,C
        AND     0FEH
        CP      02H     ; 2
        JP      NZ,DC06A
DC063:  LD      A,(DC0C4)
        AND     A
        JP      Z,J4022
DC06A:  LD      DE,DC079
        LD      C,09H   ; 9
        CALL    BDOS
        LD      C,07H   ; 7
        CALL    BDOS
        JR      J7430

DC079:  DEFB    "Boot error",13,10
        DEFB    "Press any key for retry",13,10
        DEFB    "$"

DC09F:  DEFB    0
        DEFB    "MSXDOS  SYS"
        DEFW    0
        DEFW    0
        DEFB    0,0,0,0
        DEFW    0
        DEFW    0
        DEFB    0
        DEFB    0
        DEFW    0
        DEFW    0
        DEFW    0
        DEFB    0
        DEFB    0,0,0,0

DC0C4:  DEFB    0

        .DEPHASE
L7D05	EQU	$-I7D05

        DEFS    07F00H-$,0

        JP      J74EA
?7F03: 	JP      J7511
?7F06: 	JP      J752F
?7F09: 	JP      J753F
?7F0C: 	JP      J78DC
?7F0F: 	JP      C795D
?7F12: 	JP      J797C
?7F15: 	JP      J7980
?7F18: 	JP      J74E8
?7F1B: 	DEFB    0,0,0
        DEFB    0,0,0
        JP      PROMPT
?7F24: 	JP      SETINT
?7F27: 	JP      PRVINT
?7F2A: 	JP      GETSLT
?7F2D: 	JP      GETWRK
?7F30: 	JP      DIV16
?7F33: 	JP      ENASLT
?7F36: 	JP      XFER
?7F39: 	DEFB    0,0,0
        DEFB    0,0,0
        JP      J7F51
?7F42: 	JP      J7F55
?7F45: 	JP      J7F59
?7F48: 	JP      J7F5D
?7F4B: 	JP      J7F61
?7F4E: 	JP      J7F65

J7F51: 	LD      HL,(_SECBUF)
        RET

J7F55: 	LD      HL,RAMAD0
        RET

J7F59: 	LD      HL,RAMAD1
        RET

J7F5D: 	LD      HL,RAMAD2
        RET

J7F61: 	LD      HL,RAMAD3
        RET

J7F65: 	LD      HL,RAWFLG
        RET

        DEFS    07FD0H-$,0

        DEFB    "TSDFDD00104Apr85"

        DEFS    07FEEH-$,0

        DEFB    0ADH
        DEFB    065H

D7FF0: 	DEFB    0
D7FF1: 	DEFB    0
D7FF2: 	DEFB    0
D7FF3: 	DEFB    0
D7FF4: 	DEFB    0                       ; b0 FDD motor on/off (w)
D7FF5: 	DEFB    0                       ; b0 FDD select (r/w)
D7FF6: 	DEFB    0                       ; b0 FDD change (r/w)
D7FF7: 	DEFB    0                       ; b7 DRQ (r), b6 IRQ (r)

        DEFS    08000H-$,0

        END
