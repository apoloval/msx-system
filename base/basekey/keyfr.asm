; *************************************
; BEGIN OF FREN$C KEYBOARD HANDLER
; *************************************

        EXTERN  CLIKSW

;
I0DA5:

;       Table   keycodes for scancode $00-$2F Normal layout

        DEFB    $85,$26,$82,$22,$27,$28,$BF,$8A
        DEFB    $21,$87,$29,$2D,$3C,$FF,$24,$6D
        DEFB    $97,$23,$3B,$3A,$3D,$0,$71,$62
        DEFB    $63,$64,$65,$66,$67,$68,$69,$6A
        DEFB    $6B,$6C,$2C,$6E,$6F,$70,$61,$72
        DEFB    $73,$74,$75,$76,$7A,$78,$79,$77

;       Table   keycodes for scancode $00-$2F Shift layout

        DEFB    $30,$31,$32,$33,$34,$35,$36,$37
        DEFB    $38,$39,$F8,$5F,$3E,$FF,$2A,$4D
        DEFB    $25,$9C,$2E,$2F,$2B,$0,$51,$42
        DEFB    $43,$44,$45,$46,$47,$48,$49,$4A
        DEFB    $4B,$4C,$3F,$4E,$4F,$50,$41,$52
        DEFB    $53,$54,$55,$56,$5A,$58,$59,$57

;       Table   keycodes for scancode $00-$2F Graph layout

        DEFB    $9,$AC,$AB,$BA,$BB,$EF,$F4,$FB
        DEFB    $EC,$7,$1,$17,$AE,$FF,$D,$6
        DEFB    $5,$BD,$F6,$1E,$F1,$0,$C4,$11
        DEFB    $BC,$C7,$CD,$14,$15,$13,$DC,$C6
        DEFB    $DD,$C8,$B,$1B,$C2,$DB,$CC,$18
        DEFB    $D2,$12,$C0,$1A,$CF,$1C,$19,$F

;       Table   keycodes for scancode $00-$2F Shift+Graph layout

        DEFB    $A,$16,$FD,$FC,$F7,$0,$F5,$0
        DEFB    $0,$8,$2,$1F,$AF,$FF,$E,$4
        DEFB    $3,$0,$0,$1D,$F0,$0,$FE,$0
        DEFB    $FA,$C1,$CE,$D4,$10,$D6,$DF,$CA
        DEFB    $DE,$C9,$C,$D3,$C3,$D7,$CB,$A9
        DEFB    $D1,$D9,$C5,$D5,$D0,$F9,$AA,$0

;       Table   keycodes for scancode $00-$2F Code layout

        DEFB    $EB,$7C,$40,$E0,$60,$7B,$5E,$EE
        DEFB    $E7,$E9,$7D,$ED,$F3,$FF,$9B,$B7
        DEFB    $B9,$E5,$86,$A6,$A7,$0,$84,$E1
        DEFB    $8D,$8B,$8C,$94,$81,$B1,$A1,$91
        DEFB    $B3,$B5,$E6,$A4,$A2,$A3,$83,$93
        DEFB    $89,$96,$98,$95,$88,$9F,$A0,$DA

;       Table   keycodes for scancode $00-$2F Shift+Code layout

        DEFB    $D8,$AD,$90,$9E,$0,$5B,$BE,$7E
        DEFB    $E2,$80,$5D,$E8,$F2,$FF,$0,$B6
        DEFB    $B8,$E4,$8F,$5C,$0,$0,$8E,$0
        DEFB    $0,$0,$0,$99,$9A,$B0,$0,$92
        DEFB    $B2,$B4,$A8,$A5,$0,$E3,$0,$0
        DEFB    $0,$0,$0,$0,$0,$0,$9D,$EA

;       Subroutine      rest of the functionkey handler
;       Inputs          C = code ($35-$3E)
;       Outputs         ________________________
;       Remark          code identical among keyboard layout versions from this point

J0EC5:  LD      E,C
        LD      D,$0
        LD      HL,FNKFLG-$35
        ADD     HL,DE
        LD      A,(HL)
        AND     A                       ; functionkey used for trap ?
        JR      NZ,J0EE3                ; yep, handle trap
J0ED0:  EX      DE,HL
        ADD     HL,HL
        ADD     HL,HL
        ADD     HL,HL
        ADD     HL,HL
        LD      DE,FNKSTR-$35*16
        ADD     HL,DE
        EX      DE,HL                   ; pointer to functionkey definition string
J0EDA:  LD      A,(DE)
        AND     A                       ; end of string ?
        RET     Z                       ; yep, quit
        CALL    C0F55                   ; put keycode in keyboardbuffer
        INC     DE
        JR      J0EDA                   ; next

J0EE3:  LD      HL,(CURLIN)
        INC     HL
        LD      A,H
        OR      L                       ; interpreter in direct mode ?
        JR      Z,J0ED0                 ; yep, normal behavior
        LD      HL,TRPTBL-$35*3
        ADD     HL,DE
        ADD     HL,DE
        ADD     HL,DE

;       Subroutine      raise trap
;       Inputs          ________________________
;       Outputs         ________________________
;       Remark          code identical among keyboard layout versions

C0EF1:  LD      A,(HL)
        AND     $1                     ; trap enabled ?
        RET     Z                       ; nope, quit
        LD      A,(HL)
        OR      $4
        CP      (HL)                    ; trap occured flag set ?
        RET     Z                       ; yep, quit
        LD      (HL),A                  ; flag trap occured
        XOR     $5                     ; trap paused ?
        RET     NZ                      ; yep, quit
        LD      A,(ONGSBF)
        INC     A
        LD      (ONGSBF),A              ; increase trap counter
        RET

;       Subroutine      handler HOME key
;       Inputs          -
;       Outputs         ________________________
;       Remark          code identical among keyboard layout versions

C0F06:  LD      A,(NEWKEY+6)
        RRCA                            ; SHIFT key status
        LD      A,$C                   ; assume SHIFT-HOME -> CLS keycode
        SBC     A,0                     ; no SHIFT pressed -> HOME keycode
        JR      C0F55                   ; put keycode in keyboardbuffer

;       Subroutine      handler easily converted keys
;       Inputs          A = scancode ($30-$57)
;       Outputs         ________________________
;       Remark          code identical among keyboard layout versions

C0F10:  CALL    H_KEYA
        LD      E,A
        LD      D,$0
        LD      HL,I1041-$30
        ADD     HL,DE
        LD      A,(HL)
        AND     A
        RET     Z
        JR      C0F55

;       Table           scancode table
;       Remark          last scancode+1,low byte execution address

I0F1F:  DEFB    $30, $00FF&C0F83
        DEFB    $33, $00FF&C0F10
        DEFB    $34, $00FF&C0F36
        DEFB    $35, $00FF&C0F10
        DEFB    $3A, $00FF&C0FE7
        DEFB    $3C, $00FF&C0F10
        DEFB    $3D, $00FF&C0F46
        DEFB    $40, $00FF&C0F10
        DEFB    $41, $00FF&C0FF4
        DEFB    $42, $00FF&C0F06
        DEFB    $FF, $00FF&C0F10

        DEFS    $0F36-$,0

;       Subroutine      handler CAPS key
;       Inputs          -
;       Outputs         ________________________
;       Remark          code identical among keyboard layout versions

C0F36:  LD      HL,CAPST
        LD      A,(HL)
        CPL
        LD      (HL),A                  ; toggle CAPS status
        CPL                             ; adjust for CHGCAP and change CAPS led

;       Subroutine      CHGCAP
;       Inputs          ________________________
;       Outputs         ________________________
;       Remark          code identical among keyboard layout versions

K_BCAP: AND     A
        LD      A,$C
        JR      Z,J0F43
        INC     A
J0F43:  OUT     ($AB),A
        RET

;       Subroutine      handler STOP key
;       Inputs          -
;       Outputs         ________________________
;       Remark          code identical among keyboard layout versions

C0F46:  LD      A,(NEWKEY+6)
        RRCA
        RRCA                            ; CTRL key status
        LD      A,3                     ; CTRL-STOP
        JR      NC,J0F50                ; CTRL pressed, flag CTRL-STOP
        INC     A                       ; STOP
J0F50:  LD      (INTFLG),A
        JR      C,J0F64                 ; STOP, continue in keyclick

;       Subroutine      put keycode in keyboardbuffer
;       Inputs          A = keycode
;       Outputs         ________________________
;       Remark          entrypoint compatible among keyboard layout versions

C0F55:  LD      HL,(PUTPNT)
        LD      (HL),A                  ; put in keyboardbuffer
        CALL    C1069                   ; reset DEAD status, next postition in keyboardbuffer with roundtrip
        LD      A,(GETPNT)
        CP      L                       ; keyboard buffer full ?
        RET     Z                       ; yep, quit
        LD      (PUTPNT),HL             ; update put pointer

;       Subroutine      make keyclick
;       Inputs          -
;       Outputs         ________________________
;       Remark          code identical among keyboard layout versions

J0F64:  LD      A,(CLIKSW)
        AND     A                       ; keyclicks enabled ?
        RET     Z                       ; nope, quit
        LD      A,(CLIKFL)
        AND     A                       ; keyclick already done (only one click for multiple keys) ?
        RET     NZ                      ; yep, quit
        LD      A,$F
        LD      (CLIKFL),A              ; no keyclick until the next scan
        OUT     ($AB),A                ; set click bit
        LD      A,10
J0F77:  DEC     A
        JR      NZ,J0F77                ; wait
                                        ; reset click bit

;       Subroutine      change click bit
;       Inputs          A = 0, A <> 0
;       Outputs         ________________________
;       Remark          code identical among keyboard layout versions

K_BSND: AND     A
        LD      A,$E
        JR      Z,J0F80
        INC     A
J0F80:  OUT     ($AB),A
        RET

;       Subroutine      handler scancodes $00-$2F
;       Inputs          C = scancode ($00-$2F)
;       Outputs         ________________________

C0F83:  LD      A,(NEWKEY+6)
        LD      E,A
        AND     $14
        CP      $14                     ; CODE or GRAPH key pressed ?
        JR      NZ,J0FA3                ; yep,
        LD      A,C
        CP      $B                     ; 0-9, or - key ?
        JR      C,J0F9E                 ; yep, use CAPS status
        CP      $F                     ; ; key ?
        JR      Z,J0F9E                 ; yep, use CAPS status
        CP      $22                     ; M key ?
        JR      Z,J0FA3                 ; yep, ignore CAPS status
        CP      $16                     ; ^ \ @ ( : ) , . / _ ?
        JR      C,J0FA3                 ; yep, ignore CAPS status
J0F9E:  LD      A,(CAPST)
        AND     A                       ; in CAPS mode ?
        DEFB    $38                    ; JR C,xx skip next instruction
J0FA3:  XOR     A                       ; ignore CAPS mode
        LD      A,E
        JR      Z,J0FAA
        XOR     $1                     ; toggle SHIFT key status
        LD      E,A
J0FAA:  RRA
        RRA                             ; CTRL status in Cx
        PUSH    AF
        LD      A,E
        CPL
        NOP
        NOP                             ; patch from international keyboard handler
        RRA
        RRA
        RLCA
        AND     $3                     ; GRAPH and SHIFT status
        BIT     1,A
        JR      NZ,J0FC3                ; GRAPH pressed, ignore CODE key, use GRAPH and SHIFT
        BIT     4,E                     ; CODE pressed ?
        JR      NZ,J0FC3                ; nope, no GRAPH, no CODE, use only SHIFT
        OR      $4                     ; flag CODE pressed
        NOP
        NOP
        NOP                             ; patch from international keyboard handler
J0FC3:  LD      E,A
        ADD     A,A
        ADD     A,E
        ADD     A,A
        ADD     A,A
        ADD     A,A
        ADD     A,A
        LD      E,A                     ; *48 (6*8)
        LD      D,0
        LD      HL,I0DA5
        ADD     HL,DE                   ; keycode table
        LD      B,D
        ADD     HL,BC                   ; + scancode
        POP     AF
        LD      A,(HL)
        INC     A                       ; DEAD key ?
        JP      Z,J1B96                 ; yep, handle dead key
        DEC     A                       ; keycode for this combination ?
        RET     Z                       ; nope, quit
        JR      C,J0FFA                 ; no CTRL pressed, non CTRL handler
        AND     $DF                    ; make upcase
        SUB     $40                     ; convert '@','A'-'Z' to keycode (controlcode)
        CP      $20                     ; was '@' or 'A'-'Z' ?
        RET     NC                      ; nope, quit (ignore)
J0FE4:  JP      C0F55                   ; put keycode in keyboardbuffer

;       Subroutine      handler functionkeys
;       Inputs          C = scancode ($35-$39)
;       Outputs         ________________________

C0FE7:  LD      A,(NEWKEY+6)
        RRCA                            ; SHIFT key pressed ?
        JR      C,J0FF1                 ; nope, F1-F5
        LD      A,C
        ADD     A,5
        LD      C,A                     ; yep, F6-F10
J0FF1:  JP      J0EC5                   ; rest of the functionkey handler

;       Subroutine      handler spacebar
;       Inputs          -
;       Outputs         ________________________

C0FF4:  LD      A,' '
        LD      B,0
        JR      J1009

J0FFA:  CP      $20                     ; keycode with graphic header ?
        JR      NC,J1009
        PUSH    AF
        LD      A,1                     ; put MSX header keycode in keyboard buffer
        CALL    C0F55                   ; put keycode in keyboardbuffer
        POP     AF
        ADD     A,$40                   ; to $40-$5F keycode
        JR      J0FE4                   ; put keycode in keyboardbuffer

J1009:  LD      DE,(KANAST)
        INC     E
        DEC     E                       ; DEAD key was pressed ?
        JR      Z,J0FE4                 ; nope, no DEAD + letter sequence, put keycode in keyboardbuffer and quit
        LD      D,A
        OR      $20                     ; lowercase
        LD      HL,I106F+7-1
        LD      C,7
        CPDR                            ; valid DEAD letter ?
        LD      A,D
        JR      NZ,J0FE4                ; nope, put keycode in keyboardbuffer and quit
        INC     HL
        LD      C,7
J1021:  ADD     HL,BC
        DEC     E
        JR      NZ,J1021                ; to correct DEAD table
        BIT     5,D                     ; upcase letter ?
        JR      NZ,J102C                ; nope,
        LD      C,14
        ADD     HL,BC
J102C:  LD      A,(HL)
        JR      J0FE4                   ; put keycode in keyboardbuffer and quit

;       Subroutine      K_HAND (not offical name)
;       Inputs          C = scancode
;       Outputs         ________________________

K_HAND: LD      A,C
        LD      HL,I0F1F
        CALL    H_KEYC
        LD      D, C0F06>>8             ; it is assumed that all handlers are in the $0F00-$0FFF area!
J1038:  CP      (HL)
        INC     HL
        LD      E,(HL)                  ; handler (low byte)
        INC     HL
        PUSH    DE
        RET     C                       ; yep, continue in handler
        POP     DE
        JR      J1038                   ; next

;       Table           keycodes for easily converted keys
;       Remark          scancodes $30-$57

I1041:  DEFB    $0,$0,$0,$0,$0,$0,$0,$0
        DEFB    $0,$0,$1B,$9,$0,$8,$18,$D
        DEFB    ' ',$C,$12,$7F,$1D,$1E,$1F,$1C
        DEFB    '*' ,'+' ,'/' ,'0' ,'1' ,'2' ,'3' ,'4'
        DEFB    '5' ,'6' ,'7' ,'8' ,'9' ,'-' ,',' ,'.'

;       Subroutine      reset DEAD status, next postition in keyboardbuffer with roundtrip
;       Inputs          -
;       Outputs         ________________________
;       Remark          Unused, leftover from international keyboard handler

C1069:  XOR     A
        LD      (KANAST),A
        JR      C10C2

;       Table   valid DEAD letters

I106F:  DEFB    'a' ,'e' ,'i' ,'o' ,'u' ,'y' ,' '

;       Table   translation DEAD

        DEFB    $83,$88,$8C,$93,$96,$79,$5E

;       Table   translation SHIFT DEAD

        DEFB    $84,$89,$8B,$94,$81,$98,$20

;       Table   translation DEAD upcase

        DEFB    'A' ,'E' ,'I' ,'O' ,'U' ,'Y' ,$5E

;       Table   translation SHIFT DEAD upcase

        DEFB    $8E,'E' ,'I' ,$99,$9A,'Y' ,$20

; *************************************
; END OF FREN$C KEYBOARD HANDLER
; *************************************