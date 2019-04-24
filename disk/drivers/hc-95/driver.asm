; Diskdriver JVC HC-95a (internal floppydisk controller)
; FDC   MB8877A

; Source re-created by Z80DIS 2.2
; Z80DIS was written by Kenneth Gielow, Palo Alto, CA

; Code Copyrighted by JVC and maybe others
; Source comments by Arjen Zeilemaker

; Sourcecode supplied for STUDY ONLY
; Recreation NOT permitted without authorisation of the copyrightholders
; Driver

MYSIZE          equ     8
SECLEN          equ     512

I7405:  DEFB    0F8H,00H,02H,0FH,04H,01H,02H,01H
        DEFB    00H,02H,70H,0CH,00H,63H,01H,02H
        DEFB    05H,00H

DEFDPB  EQU     $-1

        DEFB    0F9H,00H,02H,0FH,04H,01H
        DEFB    02H,01H,00H,02H,70H,0EH,00H,0CAH
        DEFB    02H,03H,07H,00H
        DEFB    0FAH,00H,02H,0FH
        DEFB    04H,01H,02H,01H,00H,02H,70H,0AH
        DEFB    00H,3CH,01H,01H,03H,00H
        DEFB    0FBH,00H
        DEFB    02H,0FH,04H
        DEFB    01H,02H,01H,00H,02H,70H,0CH,00H
        DEFB    7BH,02H,02H,05H,00H
        DEFB    0FCH,00H,02H,0FH,04H,00H,01H,01H
        DEFB    00H,02H,40H,09H,00H,60H,01H,02H
        DEFB    05H,00H
        DEFB    0FDH,00H,02H,0FH,04H,01H
        DEFB    02H,01H,00H,02H,70H,0CH,00H,63H
        DEFB    01H,02H,05H,00H
        DEFB    0FEH,00H,02H,0FH
        DEFB    04H,00H,01H,01H,00H,02H,40H,07H
        DEFB    00H,3AH,01H,01H,03H,00H
        DEFB    0FFH,00H
        DEFB    02H,0FH,04H,01H,02H,01H,00H,02H
        DEFB    70H,0AH,00H,3CH,01H,01H,03H,00H

;         Subroutine __________________________
;            Inputs  ________________________
;            Outputs ________________________

DSKIO:  DI
        PUSH    AF
        PUSH    AF
        PUSH    AF
        PUSH    AF                      ; reserve 4 words on stack (dskio leave, save dma/wait, save refresh, return af)
        PUSH    AF                      ; save AF
        PUSH    HL                      ; save HL
        POP     AF
        POP     AF
        POP     AF
        LD      A,(D7FFD)
        BIT     6,A                     ; Z80 mode ?
        JR      Z,J74BA                 ; yep,
        POP     AF
        POP     AF
        DEFB    0EDH
        DEFB    038H
        DEFB    032H                    ; IN0 A,(032H) save DMA/WAIT Control
        PUSH    AF
        DEFB    0EDH
        DEFB    038H
        DEFB    036H                    ; IN0 A,(036H) save Refresh Control
        PUSH    AF
        LD      A,0A0H                  ; Memory wait=2, I/O wait=2, DREQ1 level, DREQ0 level, DMA1 mode 2
        DEFB    0EDH
        DEFB    039H
        DEFB    032H                    ; OUT0 (032H),A DMA/WAIT Control
        LD      A,0BCH                  ; refresh enable, no refresh wait, interval 10 states
        DEFB    0EDH
        DEFB    039H
        DEFB    036H                    ; OUT0 (036H),A Refresh Control
J74BA:  LD      HL,I74F3
        PUSH    HL                      ; restore HD64180 registers at the end of DSKIO
        DEC     SP
        DEC     SP
        DEC     SP
        DEC     SP
        POP     HL                      ; restore orginal HL
        POP     AF                      ; restore orginal AF
        EI
        PUSH    AF
        JP      NC,J763E
        CALL    C7511
J74CC:  POP     DE
        PUSH    AF
        EI
        CALL    ENAINT
        LD      C,60
        JR      NC,J74D8
        LD      C,0
J74D8:  CALL    C793F
        LD      A,(D7FFB)               ; reset DRQ
        LD      A,(D7FF8)               ; reset INT
        LD      (IX+0),120
J74E5:  LD      A,D
        AND     A
        JR      NZ,J74EE
        LD      (IX+1),C
        POP     AF
        RET

J74EE:  LD      (IX+2),C
        POP     AF
        RET

I74F3:  DI
        INC     SP
        INC     SP
        INC     SP
        INC     SP
        INC     SP
        INC     SP
        PUSH    AF
        LD      A,(D7FFD)
        BIT     6,A                     ; Z80 mode ?
        JR      Z,J750E                 ; yep,
        DEC     SP
        DEC     SP
        DEC     SP
        DEC     SP
        POP     AF
        DEFB    0EDH
        DEFB    039H
        DEFB    036H                    ; OUT0 (036H),A restore Refresh Control
        POP     AF
        DEFB    0EDH
        DEFB    039H
        DEFB    032H                    ; OUT0 (032H),A restore DMA/WAIT Control
J750E:  POP     AF
        EI
        RET

;         Subroutine __________________________
;            Inputs  ________________________
;            Outputs ________________________

C7511:  CALL    C76F4                   ; initialize for disk i/o
        RET     C
        CALL    DISINT
        DI
J7519:  LD      A,L
        ADD     A,LOW (512-1)
        LD      A,H
        ADC     A,HIGH (512-1)
        CP      40H                     ; page 0 transfer ?
        JP      C,J7544                 ; yep, transfer can be direct
        LD      A,H
        AND     A                       ; page 2 or 3 transfer ?
        JP      M,J7544                 ; yep, transfer can be direct
        PUSH    HL
        PUSH    DE
        PUSH    BC
        LD      DE,(_SECBUF)
I7530:  PUSH    DE
        LD      BC,512
        CALL    XFER                    ; transfer first to SECBUF
        POP     HL
        POP     BC
        POP     DE
        CALL    C7555
        CALL    C75D2
        POP     HL
        JP      J754A
J7544:  CALL    C7555
        CALL    C75D2
J754A:  RET     C
        LD      E,07H
        DEC     B
        RET     Z
        CALL    C7835
        JP      J7519

;         Subroutine __________________________
;            Inputs  ________________________
;            Outputs ________________________

C7555:  CALL    C78A6                   ; wait for command ready
        LD      A,0A0H                  ; WRITE SECTOR
        PUSH    HL
        PUSH    DE
        PUSH    BC
        LD      DE,I7579
        PUSH    DE
        LD      (D7FF8),A               ; start command
        CALL    C795D                   ; wait ??
        LD      BC,D7FFC
        LD      DE,D7FFB
J756D:  LD      A,(BC)
        ADD     A,A
        RET     C                       ; INT, quit
        JP      P,J756D                 ; no DRQ yet, wait
        LD      A,(HL)
        LD      (DE),A
        INC     HL
        JP      J756D

I7579:  POP     BC
        POP     DE
        POP     HL
        LD      A,(D7FF8)
        AND     5CH
        RET     Z
        PUSH    AF
        CALL    C793F
        POP     AF
        BIT     6,A                     ; write protect bit set ?
        JR      NZ,J75A2                ; yep, test if disk is realy write protected
        PUSH    AF
        CALL    C7881
        POP     AF
        DEC     E
        JR      NZ,C7555
        SCF
        LD      E,A
        BIT     4,E
        LD      A,8
        RET     NZ
        BIT     3,E
        LD      A,4
        RET     NZ
        LD      A,12
        RET

J75A2:  LD      A,80H
        LD      (D7FF8),A               ; READ SECTOR
        CALL    C795D                   ; wait ??
        LD      HL,D7FFC
        LD      DE,0                    ; timeout counter
J75B0:  LD      A,(HL)
        ADD     A,A
        JP      C,J75C5                 ; INT, yep,
        JP      M,J75C5                 ; DRQ,
        DEC     DE
        LD      A,E
        OR      D                       ; waited long enough ?
        JP      NZ,J75B0                ; nope,
        CALL    C7949                   ; terminate FDC command and wait for FDC ready
J75C1:  LD      A,2
        SCF
        RET                             ; quit with NOT READY error

J75C5:  LD      A,(D7FF8)
        CALL    C7949                   ; terminate FDC command and wait for FDC ready
        BIT     4,A                     ; record not found bit set ?
        JR      NZ,J75C1                ; yep, quit with not ready error
        XOR     A
        SCF
        RET                             ; quit with WRITE PROTECT error

;         Subroutine __________________________
;            Inputs  ________________________
;            Outputs ________________________

C75D2:  RET     C
        LD      A,(RAWFLG)
        OR      A                       ; verify on ?
        RET     Z                       ; nope, quit
        PUSH    HL
        PUSH    DE
        PUSH    BC
        CALL    C78E5
        CALL    C78E5
        CALL    C78E5
        CALL    C78A6                   ; wait for command ready
        LD      A,80H                   ; READ SECTOR
        LD      BC,D7FFC
        LD      DE,I762E
        PUSH    DE
        LD      (D7FF8),A
        CALL    C795D                   ; wait ??
        LD      DE,0
J75F9:  LD      A,(BC)
        ADD     A,A
        JP      M,J7614                 ; DRQ,
        RET     C                       ; INT, quit
        LD      A,(BC)
        ADD     A,A
        JP      M,J7614                 ; DRQ,
        RET     C                       ; INT, quit
        DEC     E
        JP      NZ,J75F9                ; try again
        DEC     D
        JP      NZ,J75F9
        POP     BC
        POP     BC
        POP     DE
        POP     HL
        JP      J76ED

J7614:  LD      DE,D7FFB
        LD      A,(DE)
        JP      J7622
J761B:  LD      A,(BC)
        ADD     A,A
        RET     C
        JP      P,J761B
        LD      A,(DE)
J7622:  INC     BC
        CPI
        JP      Z,J761B
J7628:  LD      A,(BC)
        ADD     A,A
        RET     C
        JP      J7628
I762E:  POP     BC
        POP     DE
        POP     HL
        LD      A,(D7FF8)
        AND     1CH                     ; ignore not ready, write protect, record type, data request and busy bits
        RET     Z                       ; no error bits set, quit with OK
        CALL    C7949                   ; terminate FDC command and wait for FDC ready
        LD      A,10
        SCF
        RET                             ; quit with WRITE FAULT error

J763E:  CALL    C7644
        JP      J74CC

;         Subroutine __________________________
;            Inputs  ________________________
;            Outputs ________________________

C7644:  CALL    C76F4                   ; initialize for disk i/o
        RET     C
        CALL    DISINT
        DI
J764C:  LD      A,L
        ADD     A,LOW (512-1)
        LD      A,H
        ADC     A,HIGH (512-1)
        CP      40H                     ; page 0 transfer ?
        JP      C,J7678                 ; yep, transfer can be direct
        LD      A,H
        AND     A                       ; page 2 or 3 transfer ?
        JP      M,J7678                 ; yep, transfer can be direct
        PUSH    HL
        LD      HL,(_SECBUF)
        CALL    C7685                   ; read sector in SECBUF
        POP     HL
        RET     C
        PUSH    HL
        PUSH    DE
        PUSH    BC
        EX      DE,HL
        LD      HL,(_SECBUF)
        LD      BC,512
        CALL    XFER                    ; transfer from SECBUF
        POP     BC
        POP     DE
        POP     HL
        AND     A
        JR      J767C
J7678:  CALL    C7685
        RET     C
J767C:  LD      E,07H   ; 7
        DEC     B
        RET     Z
        CALL    C7835
        JR      J764C

;         Subroutine __________________________
;            Inputs  ________________________
;            Outputs ________________________

C7685:  CALL    C78A6                   ; wait for command ready
        LD      A,80H                   ; READ SECTOR
        PUSH    HL
        PUSH    DE
        PUSH    BC
        LD      DE,I76CA
        PUSH    DE
        LD      (D7FF8),A
        CALL    C795D                   ; wait ??
        LD      DE,0
        LD      BC,D7FFC
J769D:  LD      A,(BC)
        ADD     A,A
        JP      M,J76B7                 ; DRQ,
        RET     C                       ; INT,
        LD      A,(BC)
        ADD     A,A
        JP      M,J76B7                 ; DRQ,
        RET     C                       ; INT,
        DEC     E
        JP      NZ,J769D                ; try again
        DEC     D
        JP      NZ,J769D                ; try again
        POP     BC
        POP     BC
        POP     DE
        POP     HL
        JR      J76ED

J76B7:  LD      DE,D7FFB
        LD      A,(DE)
        JP      J76C5
J76BE:  LD      A,(BC)
        ADD     A,A
        RET     C
        JP      P,J76BE
        LD      A,(DE)
J76C5:  LD      (HL),A
        INC     HL
        JP      J76BE
I76CA:  POP     BC
        POP     DE
        POP     HL
        LD      A,(D7FF8)
        AND     1CH
        RET     Z
        PUSH    AF
        CALL    C793F
        CALL    C7881
        POP     AF
        DEC     E
        JR      NZ,C7685
        SCF
        LD      E,A
        BIT     4,E                     ; record not found bit set ?
        LD      A,8
        RET     NZ                      ; yep, quit with RECORD NOT FOUND error
        BIT     3,E                     ; crc error bit set ?
        LD      A,4
        RET     NZ                      ; yep, quit with DATA (CRC) error
        LD      A,12
        RET                             ; quit with OTHER error

J76ED:  CALL    C7949                   ; terminate FDC command and wait for FDC ready
        LD      A,2
        SCF
        RET                             ; quit with NOT READY error

;         Subroutine initialize for disk i/o
;            Inputs  ________________________
;            Outputs ________________________

C76F4:  PUSH    AF
        PUSH    BC
        PUSH    HL
        CALL    GETWRK
        POP     HL
        POP     BC
        POP     AF
        CP      2                       ; drivenumber valid (0-1) ?
        JR      C,J7705                 ; yep,
J7701:  LD      A,12
        SCF
        RET
J7705:  PUSH    AF
        LD      A,C
        CP      0F0H                    ; mediadescriptor valid (0F0H-0FFH) ?
        JR      NC,J770E                ; yep,
        POP     AF
        JR      J7701
J770E:  EX      (SP),HL
        PUSH    HL
        PUSH    BC
        CALL    C78A6                   ; wait for command ready
        BIT     1,C                     ; 8 sectors/track ?
        LD      C,E
        LD      B,D
        LD      DE,8
        JR      NZ,J771E                ; yep,
        INC     DE                      ; 9 sectors/track
J771E:  CALL    DIV16
        LD      A,L
        INC     A
        LD      (D7FFA),A               ; sectornumber
        LD      L,C
        POP     BC
        POP     AF
        LD      H,A
        XOR     A                       ; drives enable, side 0
        BIT     0,C
        JR      Z,J7734
        SRL     L
        JR      NC,J7734
        INC     A                       ; side 1
J7734:  SLA     A
        SLA     A
        SLA     A                       ; side to b3
        LD      D,A
        LD      A,(IX+7)
        DEC     A                       ; 1 physical drive ?
        JR      Z,J7742                 ; yep, use drive 0
        LD      A,H
J7742:  SLA     A
        SLA     A
        OR      D                       ; drive number to b2
        LD      D,A
        SET     0,A                     ; drive 0 motor on
        SET     1,A                     ; drive 1 motor on
        CALL    DISINT
        DI
        LD      (D7FFC),A
        LD      A,(IX+0)
        AND     A                       ; was motor still on ?
        LD      (IX+0),0FFH
        JR      NZ,J776D                ; yep, skip motor spinup
        CALL    C78C5
        CALL    C78C5                   ; wait ? ms (motor spinup)
        CALL    C7911                   ; check if drive is ready
        JR      NZ,J776D                ; yep,
J7768:  POP     HL
        LD      A,2
        SCF                             ; NOT READY error
        RET

J776D:  PUSH    DE
        PUSH    BC
        LD      A,(D7FFA)
        PUSH    AF                      ; save sector register
        LD      DE,I77AD
        PUSH    DE
        LD      A,0C0H                  ; READ ADDRESS
        LD      (D7FF8),A
        CALL    C795D                   ; wait ??
        LD      DE,0
        LD      BC,D7FFC
J7785:  LD      A,(BC)
        ADD     A,A
        JP      M,J779C                 ; DRQ,
        RET     C                       ; INT, quit
        DEC     E
        JP      NZ,J7785                ; try again
        DEC     D
        JP      NZ,J7785                ; try again
        POP     BC
        POP     AF
        LD      (D7FFA),A
        POP     BC
        POP     DE
        JR      J77BC

J779C:  LD      DE,D7FFB
        LD      A,(DE)                  ; read data
        JP      J77A3

J77A3:  LD      A,(BC)
        ADD     A,A
        RET     C                       ; INT, quit
        JP      P,J77A3                 ; no DRQ yet, wait
        LD      A,(DE)                  ; read data
        JP      J77A3

I77AD:  POP     AF
        LD      (D7FFA),A               ; restore sector register
        POP     BC
        POP     DE
        LD      A,(D7FF8)
        AND     18H                     ; Record not found or CRC error ?
        LD      E,7
        JR      Z,J77BE                 ; nope, 7 tries
J77BC:  LD      E,3                     ; 3 tries
J77BE:  CALL    C793F
        LD      A,C
        RRCA
        RRCA
        AND     0C0H
        OR      D
        LD      D,A
        LD      C,L
        LD      A,(IX+7)
        DEC     A                       ; 1 physical drive ?
        JR      Z,J77F5                 ; yep,
        LD      A,(IX+3)
        CP      H                       ; physical drive same as the last one used ?
        JR      Z,J782C                 ; yep, track register already ok
        XOR     01H
        LD      (IX+3),A                ; new physical drive used last
        LD      A,(D7FF9)               ; save track register
        JR      Z,J77E7
        LD      (IX+4),A
        LD      A,(IX+5)
        JR      J77ED
J77E7:  LD      (IX+5),A
        LD      A,(IX+4)
J77ED:  LD      (D7FF9),A               ; update track register
        CALL    C795D                   ; wait ??
        JR      J782F                   ; seek to track if needed and quit
J77F5:  LD      A,H
        CP      (IX+6)
        LD      (IX+6),A
        JR      Z,J782C
        PUSH    IX
        PUSH    DE
        PUSH    BC
        LD      A,(D7FFC)               ; save drive control state
        PUSH    AF
        LD      A,10H
        LD      (D7FFC),A               ; drives disabled, side 0, drive 0, drive 1 motor off, drive 0 motor off
        EI
        CALL    ENAINT
        CALL    PROMPT
        CALL    DISINT
        DI
        POP     AF
        POP     BC
        POP     DE
        POP     IX
        XOR     08H                     ; side select was read back inverted
        LD      (D7FFC),A               ; restore drive control state
        CALL    C78C5
        CALL    C78C5                   ; wait ? ms (motor spinup)
        CALL    C7911                   ; check if drive is ready
        JP      Z,J7768                 ; nope,
J782C:  LD      A,(D7FF9)
J782F:  CP      C
        CALL    NZ,C7887
        POP     HL
        RET

;         Subroutine __________________________
;            Inputs  ________________________
;            Outputs ________________________

C7835:  CALL    C78A6                   ; wait for command ready
        INC     H
        INC     H
        LD      A,(D7FFA)
        INC     A
        LD      (D7FFA),A
        BIT     7,D
        JR      NZ,J7848
        CP      9+1
        RET     C
J7848:  CP      8+1
        RET     C
        LD      A,1
        LD      (D7FFA),A
        CALL    C78FB
        BIT     6,D                     ; single sided media ?
        LD      A,(D7FFC)               ; save drive control state
        JR      Z,J7869                 ; yep, side 0 and next track
        BIT     3,D
        JR      NZ,J7869                ; currently side 1, side 0 and next track
        SET     3,D
        SET     3,A                     ; side 1
        LD      (D7FFC),A               ; update drive control state
        CALL    C78E5
        RET

J7869:  RES     3,D
        RES     3,A                     ; side 0
        LD      (D7FFC),A               ; update drive control state
        INC     C
        CALL    C78A6                   ; wait for command ready
        LD      A,58H                   ; STEP-IN
        LD      (D7FF8),A
        CALL    C795D                   ; wait ??
        CALL    C78A6                   ; wait for command ready
        JR      C78E5

;         Subroutine __________________________
;            Inputs  ________________________
;            Outputs ________________________

C7881:  BIT     0,E
        RET     NZ
        CALL    C78AD

;         Subroutine __________________________
;            Inputs  ________________________
;            Outputs ________________________

C7887:  LD      A,C
        CP      80
        JP      NC,J7701
        LD      (D7FFB),A
        CALL    C795D                   ; wait ??
        LD      A,(0)
        LD      A,(0)                   ; some sort of wait ???
        LD      A,18H                   ; SEEK
J789B:  LD      (D7FF8),A
        CALL    C795D                   ; wait ??
        CALL    C78A6                   ; wait for command ready
        JR      C78E5

;         Subroutine wait for command ready
;            Inputs  ________________________
;            Outputs ________________________

C78A6:  LD      A,(D7FF8)
        RRA
        JR      C,C78A6
        RET

;         Subroutine __________________________
;            Inputs  ________________________
;            Outputs ________________________

C78AD:  CALL    C78A6                   ; wait for command ready
        PUSH    BC
        LD      B,2
J78B3:  LD      A,58H                   ; STEP-IN
        LD      (D7FF8),A
        CALL    C795D                   ; wait ??
        CALL    C78A6                   ; wait for command ready
        DJNZ    J78B3
        POP     BC
        LD      A,08H                   ; RESTORE
        JR      J789B

;         Subroutine wait 0.5 motor spinup time
;            Inputs  ________________________
;            Outputs ________________________

C78C5:  PUSH    HL
        LD      HL,7440H
        LD      A,(D7FFD)
        BIT     6,A                     ; Z80 mode ?
        JR      Z,J7909                 ; yep,
        LD      HL,9FC4H
        JR      J7909

;         Subroutine __________________________
;            Inputs  ________________________
;            Outputs ________________________

C78D5:  PUSH    HL
        LD      HL,45C4H
        LD      A,(D7FFD)
        BIT     6,A                     ; Z80 mode ?
        JR      Z,J7909                 ; yep,
        LD      HL,0AF00H
        JR      J7909

;         Subroutine __________________________
;            Inputs  ________________________
;            Outputs ________________________

C78E5:  PUSH    HL
        LD      HL,0DF3H
        LD      HL,0708H
        LD      A,(D7FFD)
        BIT     6,A                     ; Z80 mode ?
        JR      Z,J7909                 ; yep,
        LD      HL,1450H
        LD      HL,0A28H
        JR      J7909

;         Subroutine __________________________
;            Inputs  ________________________
;            Outputs ________________________

C78FB:  PUSH    HL
        LD      HL,00EEH
        LD      A,(D7FFD)
        BIT     6,A                     ; Z80 mode ?
        JR      Z,J7909                 ; yep,
        LD      HL,0155H
J7909:  DEC     HL
        LD      A,H
        OR      L
        JR      NZ,J7909
        POP     HL
        XOR     A
        RET

;         Subroutine check if drive is ready
;            Inputs  ________________________
;            Outputs ________________________

C7911:  PUSH    BC
        LD      BC,9470H
        LD      A,0D0H
        LD      (D7FF8),A               ; execute terminate without interrupt command
        CALL    C795D                   ; wait ??
        LD      A,(0)
        LD      A,(0)
J7923:  LD      A,(D7FF8)
        BIT     1,A                     ; at INDEX MARK ?
        JR      Z,J7931                 ; nope,
        DEC     BC
        LD      A,C
        OR      B
        JR      NZ,J7923                ; wait
        JR      J793D

J7931:  LD      A,(D7FF8)
        BIT     1,A                     ; at INDEX MARK ?
        JR      NZ,J793D                ; yep, then drive must be ready, quit
        DEC     BC
        LD      A,C
        OR      B
        JR      NZ,J7931
J793D:  POP     BC
        RET

;         Subroutine __________________________
;            Inputs  ________________________
;            Outputs ________________________

C793F:  LD      A,(D7FFA)
        CALL    C7949                   ; terminate FDC command and wait for FDC ready
        LD      (D7FFA),A
        RET

;         Subroutine __________________________
;            Inputs  ________________________
;            Outputs ________________________

C7949:  PUSH    AF
        LD      A,0D0H
        LD      (D7FF8),A               ; execute terminate without interrupt command
        CALL    C795D                   ; wait ??
        LD      A,(0)
        LD      A,(0)                   ; some sort of wait ??
        CALL    C78A6                   ; wait for command ready
        POP     AF
        RET

;         Subroutine __________________________
;            Inputs  ________________________
;            Outputs ________________________

C795D:  PUSH    AF
        LD      A,(0)
        LD      A,(0)
        LD      A,(0)
        POP     AF
        RET

;         Subroutine __________________________
;            Inputs  ________________________
;            Outputs ________________________

C7969:  PUSH    AF
        EX      (SP),HL
        EX      (SP),HL
        LD      A,(D7FFD)
        BIT     6,A                     ; Z80 mode ?
        JR      Z,J7977                 ; yep,
        EX      (SP),HL
        EX      (SP),HL
        EX      (SP),HL
        EX      (SP),HL
J7977:  POP     AF
        RET

INIHRD: LD      A,0D0H
        LD      (D7FF8),A               ; execute terminate without interrupt command
        CALL    C7969
        LD      A,03H                   ; drives enabled, side 0, drive 0, drive 1 motor on, drive 0 motor on
        LD      (D7FFC),A
        CALL    C78D5
        CALL    C78D5
        CALL    C799D
        LD      A,07H                   ; drives enabled, side 0, drive 1, drive 1 motor on, drive 0 motor on
        LD      (D7FFC),A
        CALL    C799D

MTOFF:
        LD      A,10H                   ; drives disabled, side 0, drive 0, drive 1 motor off, drive 0 motor off
        LD      (D7FFC),A
        RET

;         Subroutine __________________________
;            Inputs  ________________________
;            Outputs ________________________

C799D:  CALL    C78A6                   ; wait for command ready
        PUSH    BC
        LD      B,2
J79A3:  LD      A,58H                   ; STEP-IN
        LD      (D7FF8),A
        CALL    C7969
        CALL    C78A6                   ; wait for command ready
        DJNZ    J79A3
        POP     BC
        LD      A,08H                   ; RESTORE
        LD      (D7FF8),A
        CALL    C7969
        LD      HL,7530H
        LD      A,(D7FFD)
        BIT     6,A                     ; Z80 mode ?
        JR      Z,J79C4                 ; yep,
        ADD     HL,HL
J79C4:  LD      A,(D7FF8)
        RRA
        RET     NC
        EX      (SP),HL
        EX      (SP),HL
        DEC     HL
        LD      A,L
        OR      H
        JR      NZ,J79C4
        CALL    C78E5
        RET

DRIVES: PUSH    BC
        PUSH    AF
        CALL    GETWRK
        LD      A,06H                   ; drives enabled, side 0, drive 1, drive 1 motor on, drive 0 motor off
        LD      (D7FFC),A
        CALL    C78D5
        CALL    C78D5
        CALL    C78A6                   ; wait for command ready
        LD      A,08H                   ; RESTORE
        LD      (D7FF8),A
        CALL    C7969
        LD      HL,7530H
        LD      A,(D7FFD)
        BIT     6,A                     ; Z80 mode ?
        JR      Z,J79FA                 ; yep,
        ADD     HL,HL
J79FA:  LD      A,(D7FF8)
        RRA
        JR      NC,J7A09
        EX      (SP),HL
        EX      (SP),HL
        DEC     HL
        LD      A,L
        OR      H
        JR      NZ,J79FA
        INC     L
        DEFB    0CAH
J7A09:  LD      L,2
        LD      (IX+7),L
        LD      A,10H                   ; drives disabled, side 0, drive 0, drive 1 motor off, drive 0 motor off
        LD      (D7FFC),A
        POP     AF
        JR      NZ,J7A1D
        LD      L,1
        LD      (IX+7),L
        JR      J7A1F
J7A1D:  LD      L,02H   ; 2
J7A1F:  POP     BC
        RET

INIENV: CALL    GETWRK
        XOR     A
        LD      B,07H   ; 7
J7A27:  LD      (HL),A
        INC     HL
        DJNZ    J7A27
        LD      HL,I7A31
        JP      SETINT

I7A31:  PUSH    AF
        CALL    GETWRK
        LD      A,(HL)
        AND     A
        JR      Z,J7A4D
        CP      0FFH
        JR      Z,J7A4D
        DEC     A
        LD      (HL),A
        JR      NZ,J7A4D
        LD      A,(D7FFC)
        AND     0CH                     ; leave side and drive, drive 1 motor off, drive 0 motor off
        OR      10H                     ; drives disabled
        XOR     08H                     ; side is read back inverted
        LD      (D7FFC),A
J7A4D:  INC     HL
        LD      A,(HL)
        AND     A
        JR      Z,J7A53
        DEC     (HL)
J7A53:  INC     HL
        LD      A,(HL)
        AND     A
        JR      Z,J7A59
        DEC     (HL)
J7A59:  POP     AF
        JP      PRVINT

DSKCHG: EI
        PUSH    HL
        PUSH    BC
        PUSH    AF
        CALL    GETWRK
        POP     AF
        POP     BC
        POP     HL
        AND     A
        LD      B,(IX+2)
        JR      NZ,J7A70
        LD      B,(IX+1)
J7A70:  INC     B
        DEC     B
        LD      B,01H   ; 1
        RET     NZ
        PUSH    BC
        PUSH    HL
        LD      DE,1
        LD      HL,(_SECBUF)
        CALL    DSKIO
        JR      C,J7A99
        LD      HL,(_SECBUF)
        LD      B,(HL)
        POP     HL
        PUSH    BC
        CALL    GETDPB
        LD      A,0CH   ; 12
        JR      C,J7A99
        POP     AF
        POP     BC
        CP      C
        SCF
        CCF
        LD      B,0FFH
        RET     NZ
        INC     B
        RET
J7A99:  POP     DE
        POP     DE
        RET

;         Subroutine __________________________
;            Inputs  ________________________
;            Outputs ________________________

GETDPB: EI
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
        LD      BC,I7405
        ADD     HL,BC
        LD      BC,18
        LDIR
        RET

CHOICE: LD      HL,I7ABC
        OR      A
        RET

I7ABC:  DEFB    13,10
        DEFM    '1 -- single side',13,10
        DEFM    '2 -- double side',13,10
        DEFB    13,10
        DEFM    ' Select 1 or 2'
        DEFB    0

DSKFMT: DI
        PUSH    AF
        LD      A,B
        CP      HIGH 0180H
        JR      NC,J7B08
        LD      A,C
        CP      LOW 0180H
        JR      NC,J7B08
        POP     AF
        LD      A,0EH   ; 14
        SCF
        EI
        CALL    ENAINT
        RET

J7B08:  POP     AF
        PUSH    AF
        PUSH    AF
        PUSH    AF
        PUSH    AF
        PUSH    AF
        PUSH    HL
        POP     AF
        POP     AF
        POP     AF
        LD      A,(D7FFD)
        BIT     6,A                     ; Z80 mode ?
        JR      Z,J7B2D                 ; yep,
        POP     AF
        POP     AF
        DEFB    0EDH
        DEFB    038H
        DEFB    032H                    ; IN0 A,(032H) DMA/WAIT Control
        PUSH    AF
        DEFB    0EDH
        DEFB    038H
        DEFB    036H                    ; IN0 A,(036H) Refresh Control
        PUSH    AF
        LD      A,0A0H                  ; Memory wait=2, I/O wait=2, DREQ1 level, DREQ0 level, DMA1 mode 2
        DEFB    0EDH
        DEFB    039H
        DEFB    032H                    ; OUT0 (032H),A DMA/WAIT Control
        LD      A,0BCH                  ; refresh enable, no refresh wait, interval 10 states
        DEFB    0EDH
        DEFB    039H
        DEFB    036H                    ; OUT0 (036H),A Refresh Control
J7B2D:  LD      HL,I74F3
        PUSH    HL                      ; restore HD64180 registers at the end of DSKFMT
        DEC     SP
        DEC     SP
        DEC     SP
        DEC     SP
        POP     HL
        POP     AF
        PUSH    DE
        CP      03H     ; 3
        JR      NC,J7B4C
        PUSH    AF
        LD      IY,I7F0F
        LD      A,(IY+8)
        ADD     A,(IY+9)
        CP      9FH
        JR      Z,J7B51
        POP     AF
J7B4C:  LD      A,0CH   ; 12
        JP      J7BCD

J7B51:  POP     AF
        PUSH    HL
        POP     IY
        LD      (IY+6),D
J7B58:  DEC     A
        JR      Z,J7B81
        DEC     A
        JR      Z,J7B80
        LD      D,0F0H
        LD      A,(HL)
        DEC     A
        JR      Z,J7B66
        SET     3,D
J7B66:  INC     HL
        LD      A,(HL)
        BIT     0,A
        JR      NZ,J7B6E
        SET     1,D
J7B6E:  INC     HL
        LD      A,(HL)
        CP      28H     ; "("
        JR      NZ,J7B76
        SET     2,D
J7B76:  INC     HL
        LD      A,(HL)
        DEC     A
        JR      NZ,J7B7D
        SET     0,D
J7B7D:  LD      A,D
        JR      J7B8F
J7B80:  INC     A
J7B81:  ADD     A,0F8H
        LD      (HL),02H        ; 2
        INC     HL
        LD      (HL),09H        ; 9
        INC     HL
        LD      (HL),50H        ; "P"
        INC     HL
        INC     HL
        LD      (HL),00H
J7B8F:  LD      (IY+10),A
        LD      A,(IY+1)
        LD      (IY+5),A
        LD      DE,0
        LD      A,(IY+6)
        LD      C,(IY+10)
        LD      B,00H
        LD      (IY+7),B
        CALL    C76F4                   ; initialize for disk i/o
        LD      A,10H
        JP      C,J7BCD
        CALL    C78AD
        XOR     A
        LD      D,A
J7BB3:  LD      C,(IY+7)
        LD      E,01H   ; 1
        CALL    C7D4D
        AND     44H     ; "D"
        JR      Z,J7BD1
        LD      B,A
        LD      A,00H
        BIT     6,B
        JR      NZ,J7BC8
        LD      A,10H   ; 16
J7BC8:  PUSH    AF
        CALL    C78AD
        POP     AF
J7BCD:  SCF
        JP      J74CC
J7BD1:  PUSH    BC
        PUSH    HL
        PUSH    DE
        LD      C,D
        LD      B,(IY+5)
        LD      A,01H   ; 1
        LD      (D7FFA),A
        LD      HL,(_SECBUF)
J7BE0:  LD      E,07H   ; 7
        CALL    C7685
        JR      C,J7BF3
        DEC     B
        JR      Z,J7BFB
        LD      A,(D7FFA)
        INC     A
        LD      (D7FFA),A
        JR      J7BE0
J7BF3:  POP     DE
        POP     HL
        POP     BC
        LD      A,10H   ; 16
        JP      J7BC8

J7BFB:  POP     DE
        POP     HL
        POP     BC
        CALL    C78FB
        PUSH    BC
        LD      C,(IY+10)
        BIT     0,C
        JR      Z,J7C1A
        LD      A,(D7FFC)
        LD      (D7FFC),A               ; select other side
        LD      A,(IY+7)
        XOR     01H     ; 1
        LD      (IY+7),A
        DEC     A
        JR      Z,J7C49
J7C1A:  INC     D
        LD      A,D
        CP      (IY+2)
        JR      NC,J7C50
        LD      A,(IY+2)
        LD      B,1
        CP      80
        JR      Z,J7C2B
        INC     B
J7C2B:  CALL    C78A6                   ; wait for command ready
        LD      A,58H                   ; STEP-IN
        LD      (D7FF8),A
        CALL    C78E5
        DJNZ    J7C2B
        LD      A,(IY+4)
        CP      00H
        JR      Z,J7C49
        CP      D
        LD      A,(IY+1)
        JR      NZ,J7C46
        DEC     A
J7C46:  LD      (IY+5),A
J7C49:  CALL    C78E5
        POP     BC
        JP      J7BB3
J7C50:  POP     BC
        CALL    C78AD
        LD      A,(IY+10)
        SUB     0F8H
        JP      C,J7BCD
        LD      L,A
        LD      H,00H
        ADD     HL,HL
        LD      C,L
        LD      B,H
        ADD     HL,HL
        ADD     HL,HL
        ADD     HL,HL
        ADD     HL,BC
        LD      BC,I7405
        ADD     HL,BC
        PUSH    IX
        PUSH    HL
        LD      HL,I7F0F
        LD      BC,L7F0F
        LD      DE,(_SECBUF)
        LDIR
        LD      BC,512-L7F0F
        EX      DE,HL
        CALL    C7D44
        POP     HL
        LD      IX,(_SECBUF)
        LD      A,(IY+10)
        LD      (IX+21),A
        LD      BC,6
        ADD     HL,BC
        LD      A,(HL)
        LD      (IX+13),A
        INC     HL
        INC     HL
        INC     HL
        LD      A,(HL)
        LD      (IY+8),A
        INC     HL
        LD      A,(HL)
        LD      (IX+17),A
        INC     HL
        LD      A,(HL)
        LD      (IY+11),A
        LD      BC,4
        ADD     HL,BC
        LD      A,(HL)
        LD      (IY+9),A
        LD      (IX+22),A
        INC     HL
        LD      A,(HL)
        LD      (IY+12),A
        LD      A,(IY+10)
        LD      HL,160
        BIT     2,A
        JR      Z,J7CC0
        LD      L,80
J7CC0:  BIT     0,A
        JR      NZ,J7CC9
        SRL     L
        DEC     (IX+26)
J7CC9:  LD      C,L
        LD      B,H
        ADD     HL,HL
        ADD     HL,HL
        ADD     HL,HL
        BIT     1,A
        JR      Z,J7CD7
        DEC     (IX+24)
        JR      J7CD8
J7CD7:  ADD     HL,BC
J7CD8:  LD      (IX+19),L
        LD      (IX+20),H
        POP     IX
        LD      (IY+5),00H
        CALL    C7EF5
        JP      C,J7BC8
        LD      D,(IY+8)
J7CED:  LD      HL,(_SECBUF)
        LD      E,(IY+9)
        LD      A,(IY+10)
        LD      (HL),A
        INC     HL
        LD      A,0FFH
        LD      (HL),A
        INC     HL
        LD      (HL),A
        INC     HL
        LD      BC,512-3
        CALL    C7D44
        PUSH    DE
        CALL    C7EF5
        POP     DE
        JP      C,J7BC8
J7D0C:  DEC     E
        JR      Z,J7D22
        LD      HL,(_SECBUF)
        LD      BC,512
        CALL    C7D44
        PUSH    DE
        CALL    C7EF5
        POP     DE
        JP      C,J7BC8
        JR      J7D0C
J7D22:  DEC     D
        JR      NZ,J7CED
        LD      D,(IY+12)
        LD      A,(IY+11)
        SUB     D
        LD      D,A
J7D2D:  LD      HL,(_SECBUF)
        LD      BC,512
        CALL    C7D44
        PUSH    DE
        CALL    C7EF5
        POP     DE
        JP      C,J7BC8
        DEC     D
        JR      NZ,J7D2D
        JP      J74CC

;         Subroutine __________________________
;            Inputs  ________________________
;            Outputs ________________________

C7D44:  LD      (HL),00H
        INC     HL
        DEC     BC
        LD      A,C
        OR      B
        JR      NZ,C7D44
        RET

;         Subroutine __________________________
;            Inputs  ________________________
;            Outputs ________________________

C7D4D:  CALL    C78A6                   ; wait for command ready
        LD      HL,I7EF1
        PUSH    HL
        LD      L,(IY+5)
        CALL    DISINT
        DI
        LD      A,0F0H                  ; WRITE TRACK
        LD      (D7FF8),A
        CALL    C795D                   ; wait ??
        LD      B,50H   ; "P"
        LD      H,4EH   ; "N"
J7D67:  LD      A,(D7FFC)
        ADD     A,A
        RET     C                       ; INT, quit
        JP      P,J7D67                 ; no DRQ yet, wait
        LD      A,H
        LD      (D7FFB),A
        DJNZ    J7D67
        LD      B,0CH   ; 12
        LD      H,00H
J7D79:  LD      A,(D7FFC)
        ADD     A,A
        RET     C                       ; INT, quit
        JP      P,J7D79                 ; no DRQ yet, wait
        LD      A,H
        LD      (D7FFB),A
        DJNZ    J7D79
        LD      B,03H   ; 3
        LD      H,0F6H
J7D8B:  LD      A,(D7FFC)
        ADD     A,A
        RET     C
        JP      P,J7D8B
        LD      A,H
        LD      (D7FFB),A
        DJNZ    J7D8B
        INC     B
        LD      H,0FCH
J7D9C:  LD      A,(D7FFC)
        ADD     A,A
        RET     C
        JP      P,J7D9C
        LD      A,H
        LD      (D7FFB),A
        DJNZ    J7D9C
        LD      B,1AH
        LD      H,4EH   ; "N"
J7DAE:  LD      A,(D7FFC)
        ADD     A,A
        RET     C
        JP      P,J7DAE
        LD      A,H
        LD      (D7FFB),A
        DJNZ    J7DAE
J7DBC:  LD      B,0CH   ; 12
        LD      H,00H
J7DC0:  LD      A,(D7FFC)
        ADD     A,A
        RET     C
        JP      P,J7DC0
        LD      A,H
        LD      (D7FFB),A
        DJNZ    J7DC0
        LD      B,03H   ; 3
        LD      H,0F5H
J7DD2:  LD      A,(D7FFC)
        ADD     A,A
        RET     C
        JP      P,J7DD2
        LD      A,H
        LD      (D7FFB),A
        DJNZ    J7DD2
        INC     B
        LD      H,0FEH
J7DE3:  LD      A,(D7FFC)
        ADD     A,A
        RET     C
        JP      P,J7DE3
        LD      A,H
        LD      (D7FFB),A
        DJNZ    J7DE3
        INC     B
        LD      H,D
J7DF3:  LD      A,(D7FFC)
        ADD     A,A
        RET     C
        JP      P,J7DF3
        LD      A,H
        LD      (D7FFB),A
        DJNZ    J7DF3
        INC     B
        LD      H,C
J7E03:  LD      A,(D7FFC)
        ADD     A,A
        RET     C
        JP      P,J7E03
        LD      A,H
        LD      (D7FFB),A
        DJNZ    J7E03
        INC     B
        LD      H,E
J7E13:  LD      A,(D7FFC)
        ADD     A,A
        RET     C
        JP      P,J7E13
        LD      A,H
        LD      (D7FFB),A
        DJNZ    J7E13
        INC     B
        LD      H,(IY)
J7E25:  LD      A,(D7FFC)
        ADD     A,A
        RET     C
        JP      P,J7E25
        LD      A,H
        LD      (D7FFB),A
        DJNZ    J7E25
        INC     B
        LD      H,0F7H
J7E36:  LD      A,(D7FFC)
        ADD     A,A
        RET     C
        JP      P,J7E36
        LD      A,H
        LD      (D7FFB),A
        DJNZ    J7E36
        LD      B,18H
        LD      H,4EH   ; "N"
J7E48:  LD      A,(D7FFC)
        ADD     A,A
        RET     C
        JP      P,J7E48
        LD      A,H
        LD      (D7FFB),A
        DJNZ    J7E48
        LD      B,0CH   ; 12
        LD      H,00H
J7E5A:  LD      A,(D7FFC)
        ADD     A,A
        RET     C
        JP      P,J7E5A
        LD      A,H
        LD      (D7FFB),A
        DJNZ    J7E5A
        LD      B,03H   ; 3
        LD      H,0F5H
J7E6C:  LD      A,(D7FFC)
        ADD     A,A
        RET     C
        JP      P,J7E6C
        LD      A,H
        LD      (D7FFB),A
        DJNZ    J7E6C
        INC     B
        LD      H,0FBH
J7E7D:  LD      A,(D7FFC)
        ADD     A,A
        RET     C
        JP      P,J7E7D
        LD      A,H
        LD      (D7FFB),A
        DJNZ    J7E7D
        LD      H,0E5H
J7E8D:  LD      A,(D7FFC)
        ADD     A,A
        RET     C
        JP      P,J7E8D
        LD      A,H
        LD      (D7FFB),A
        DJNZ    J7E8D
        BIT     1,(IY)
        JP      Z,J7EB0
J7EA2:  LD      A,(D7FFC)
        ADD     A,A
        RET     C
        JP      P,J7EA2
        LD      A,H
        LD      (D7FFB),A
        DJNZ    J7EA2
J7EB0:  INC     B
        LD      H,0F7H
J7EB3:  LD      A,(D7FFC)
        ADD     A,A
        RET     C
        JP      P,J7EB3
        LD      A,H
        LD      (D7FFB),A
        DJNZ    J7EB3
        LD      B,36H   ; "6"
        LD      H,4EH   ; "N"
J7EC5:  LD      A,(D7FFC)
        ADD     A,A
        RET     C
        JP      P,J7EC5
        LD      A,H
        LD      (D7FFB),A
        DJNZ    J7EC5
        LD      A,E
        INC     E
        CP      L
        JP      C,J7DBC
        LD      B,00H
        LD      H,4EH   ; "N"
        LD      L,08H   ; 8
J7EDF:  LD      A,(D7FFC)
        ADD     A,A
        RET     C                       ; INT, quit
        JP      P,J7EDF                 ; no DRQ yet, wait
        LD      A,H
        LD      (D7FFB),A
        DJNZ    J7EDF
        DEC     L
        JR      NZ,J7EDF
        POP     HL
I7EF1:  LD      A,(D7FF8)
        RET

;         Subroutine __________________________
;            Inputs  ________________________
;            Outputs ________________________

C7EF5:  LD      HL,(_SECBUF)
        LD      D,0
        LD      E,(IY+5)
        LD      B,1
        LD      C,(IY+10)
        LD      A,(IY+6)
        SCF
        CALL    DSKIO
        INC     (IY+5)
        RET

OEMSTA: SCF
        RET

I7F0F:
                .PHASE  0C000H

                db      0EBh,0FEh       ; JMP 0100h (i8088)
                db      090h            ; NOP (i8088)

                db      "JVC  KTW"

                dw      512
                db      2
                dw      1
                db      2
                dw      112
                dw      05A0H
                db      0F9H
                dw      3
                dw      9
                dw      2
                dw      0

BootTrap:       ret     nc
                ld      (SetRomPage+1),de
                ld      (StartFlag),a
                ld      (hl),LOW ErrorHand
                inc     hl
                ld      (hl),HIGH ErrorHand
BootAgain:      ld      sp,0F51Fh
                ld      de,MsxDosFcb
                ld      c,0Fh
                call    0F37Dh
                inc     a
                jp      z,OpenDosError
                ld      de,0100h
                ld      c,01Ah
                call    0F37Dh
                ld      hl,1
                ld      (MsxDosFcb+0Eh),hl
                ld      hl,04000h-0100h
                ld      de,MsxDosFcb
                ld      c,027h
                call    0F37Dh
                jp      0100h

ErrorHand:      dw      SetRomPage

SetRomPage:     call    0
                ld      a,c
                and     0FEh
                cp      02h
                jp      nz,DiskBootError
OpenDosError:   ld      a,(StartFlag)
                and     a                       ; Startup ?
                jp      z,04022h                ; yep, jump direct
DiskBootError:  ld      de,BootErrorTxt
                call    PrintMessage
                ld      c,07h
                call    0F37Dh
                jr      BootAgain               ; nop, boot again

PrintMessage:   ld      a,(de)
                or      a
                ret     z
                push    de
                ld      e,a
                ld      c,6
                call    0F37DH
                pop     de
                inc     de
                jr      PrintMessage

BootErrorTxt:   db      "Boot error",13,10
                db      "Press any key for retry",13,10
                db      0

MsxDosFcb:      db      0
                db      "MSXDOS  SYS"
                dw      0
                dw      0
                db      0,0,0,0
                dw      0
                dw      0
                db      0
                db      0
                dw      0
                dw      0
                dw      0
                db      0
                db      0,0,0,0

StartFlag:      db      0

                .DEPHASE



        DEFB    0EBH,0FEH,90H,4AH,56H,43H,20H,20H
        DEFB    4BH,54H,57H,00H,02H,02H,01H,00H
        DEFB    02H,70H,00H,0A0H,05H,0F9H,03H,00H
        DEFB    09H,00H,02H,00H,00H,00H
?7F2D:  RET     NC
        LD      (D$C059),DE
        LD      (D.C0D0),A
        LD      (HL),56H        ; "V"
        INC     HL
        LD      (HL),0C0H
J7F3A:  LD      SP,I$F51F
        LD      DE,I.C0AB
        LD      C,0FH   ; 15
        CALL    C.F37D
        INC     A
        JP      Z,J$C063
        LD      DE,0100H
        LD      C,1AH
        CALL    C.F37D
        LD      HL,1
        LD      (D$C0B9),HL
        LD      HL,04000H-0100H
        LD      DE,I.C0AB
        LD      C,27H   ; "'"
        CALL    C.F37D
        JP      0100H
?7F65:  LD      E,B
        RET     NZ
        CALL    0
        LD      A,C
        AND     0FEH
        CP      02H     ; 2
        JP      NZ,J$C06A
        LD      A,(D.C0D0)
        AND     A
        JP      Z,J$4022
        LD      DE,I$C085
        CALL    C$C077
        LD      C,07H   ; 7
        CALL    C.F37D
        JR      J7F3A
J7F86:  LD      A,(DE)
        OR      A
        RET     Z
        PUSH    DE
        LD      E,A
        LD      C,06H   ; 6
        CALL    C.F37D
        POP     DE
        INC     DE
        JR      J7F86

?7F94:  DEFB    42H,6FH,6FH,74H,20H,65H,72H,72H
        DEFB    6FH,72H,0DH,0AH,50H,72H,65H,73H
        DEFB    73H,20H,61H,6EH,79H,20H,6BH,65H
        DEFB    79H,20H,66H,6FH,72H,20H,72H,65H
        DEFB    74H,72H,79H,0DH,0AH,00H,00H,4DH
        DEFB    53H,58H,44H,4FH,53H,20H,20H,53H
        DEFB    59H,53H,00H,00H,00H,00H,00H,00H
        DEFB    00H,00H,00H,00H,00H,00H,00H,00H
        DEFB    00H,00H,00H,00H,00H,00H,00H,00H
        DEFB    00H,00H,00H,00H

L7F0F   EQU     $-I7F0F

        DEFB    0FFH,0FFH,0FFH,0FFH
        DEFB    0FFH,0FFH,0FFH,0FFH,0FFH,0FFH,0FFH,0FFH
        DEFB    0FFH,0FFH,0FFH,0FFH,0FFH,0FFH,0FFH,0FFH
        DEFB    0FFH,0FFH,0FFH,0FFH

        DEFB    24H
        DEFB    00H
        DEFB    07H
        DEFB    00H
        DEFB    0BH
        DEFB    80H,0FFH,0FFH

D7FF8   EQU     07FF8H                  ; MB8877A
D7FF9   EQU     07FF9H                  ; MB8877A
D7FFA   EQU     07FFAH                  ; MB8877A
D7FFB   EQU     07FFBH                  ; MB8877A

D7FFC   EQU     07FFCH                  ; R b7 = INT (1 = INT)
                                        ; R b6 = DRQ (1 = DRQ)
                                        ; W b4 = drive enable (1 = enable)
                                        ; R b4 = motor control (1 = enable)
                                        ; W b3 = side select (1 = side 1, 0 = side 0)
                                        ; R b3 = side select (1 = side 0, 1 = side 1)!
                                        ; W b2 = drive select (1 = drive 1, 0 = drive 0)
                                        ; R b2 = drive select (1 = drive 1, 0 = drive 0)
                                        ; W b1 = motor control drive 1 (1 = motor on)
                                        ; W b0 = motor control drive 0 (1 = motor on)
D7FFD   EQU     07FFDH                  ; R b6 = CPU mode (1 = HD64180, 0 = Z80)

        END

