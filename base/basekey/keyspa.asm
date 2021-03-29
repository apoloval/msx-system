; *************************************
; BEGIN OF SPANISH KEYBOARD HANDLER
; *************************************

        EXTERN  CLIKSW

D0DA5:

;       Table   keycodes for scancode $00-$2F Normal layout

        DEFB    $30,$31,$32,$33,$34,$35,$36,$37
        DEFB    $38,$39,$2D,$3D,$5C,$5B,$5D,$A4
        DEFB    $27,$3B,$2C,$2E,$2F,$FF,$61,$62
        DEFB    $63,$64,$65,$66,$67,$68,$69,$6A
        DEFB    $6B,$6C,$6D,$6E,$6F,$70,$71,$72
        DEFB    $73,$74,$75,$76,$77,$78,$79,$7A

;       Table   keycodes for scancode $00-$2F Shift layout

        DEFB    $29,$21,$40,$23,$24,$25,$5E,$26
        DEFB    $2A,$28,$5F,$2B,$7C,$7B,$7D,$A5
        DEFB    $22,$3A,$3C,$3E,$3F,$FF,$41,$42
        DEFB    $43,$44,$45,$46,$47,$48,$49,$4A
        DEFB    $4B,$4C,$4D,$4E,$4F,$50,$51,$52
        DEFB    $53,$54,$55,$56,$57,$58,$59,$5A

;       Table   keycodes for scancode $00-$2F Graph layout

        DEFB    $9,$AC,$AB,$BA,$EF,$BD,$F4,$FB
        DEFB    $EC,$7,$17,$F1,$1E,$1,$D,$6
        DEFB    $5,$BB,$F3,$F2,$1D,$FF,$C4,$11
        DEFB    $BC,$C7,$CD,$14,$15,$13,$DC,$C6
        DEFB    $DD,$C8,$B,$1B,$C2,$DB,$CC,$18
        DEFB    $D2,$12,$C0,$1A,$CF,$1C,$19,$F

;       Table   keycodes for scancode $00-$2F Shift+Graph layout

        DEFB    $A,$0,$FD,$FC,$0,$0,$F5,$0
        DEFB    $0,$8,$1F,$F0,$16,$2,$E,$4
        DEFB    $3,$F7,$AE,$AF,$F6,$FF,$FE,$0
        DEFB    $FA,$C1,$CE,$D4,$10,$D6,$DF,$CA
        DEFB    $DE,$C9,$C,$D3,$C3,$D7,$CB,$A9
        DEFB    $D1,$0,$C5,$D5,$D0,$F9,$AA,$F8

;       Table   keycodes for scancode $00-$2F Code layout

        DEFB    $EB,$9F,$D9,$BF,$9B,$98,$E0,$E1
        DEFB    $E7,$87,$EE,$E9,$0,$ED,$DA,$B7
        DEFB    $B9,$E5,$86,$A6,$A7,$FF,$84,$97
        DEFB    $8D,$8B,$8C,$94,$81,$B1,$A1,$91
        DEFB    $B3,$B5,$E6,$60,$A2,$A3,$83,$93
        DEFB    $89,$96,$82,$95,$88,$8A,$A0,$85

;       Table   keycodes for scancode $00-$2F Shift+Code layout

        DEFB    $D8,$AD,$9E,$BE,$9C,$9D,$0,$0
        DEFB    $E2,$80,$0,$0,$0,$E8,$EA,$B6
        DEFB    $B8,$E4,$8F,$0,$A8,$FF,$8E,$0
        DEFB    $0,$0,$0,$99,$9A,$B0,$0,$92
        DEFB    $B2,$B4,$0,$7E,$0,$E3,$0,$0
        DEFB    $0,$0,$90,$0,$0,$0,$0,$0

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
        LD      D,0
        LD      HL,D1033-$30
        ADD     HL,DE
        LD      A,(HL)
        AND     A                       ; keycode for key ?
        RET     Z                       ; nope, quit
        JR      C0F55                   ; put keycode in keyboardbuffer

;       Subroutine      handler DEAD key
;       Inputs          -
;       Outputs         ________________________

J0F1F:  LD      A,(NEWKEY+6)
        LD      E,A
        OR      $FE            ; SHIFT key status (rest of bits 1)
        BIT     4,E
        JR      NZ,J0F2B        ; CODE not pressed, use SHIFT
J0F29:  AND     $FD            ; reset b1
J0F2B:  CPL
        INC     A
        LD      (KANAST),A      ; set DEAD status ($01-$04)
        JR      J0F64           ; make keyclick

;
;       leftover from KANA keyhandler, not used
;

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
        CALL    C105B                   ; reset DEAD status, next postition in keyboardbuffer with roundtrip
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
        RRA
        RRA                             ; CTRL status in Cx
        PUSH    AF
        LD      A,E
        CPL
        JR      NC,J0F9E                ; CTRL pressed, ignore GRAPH and CODE key, use only SHIFT
        RRA
        RRA
        RLCA
        AND     $3                     ; GRAPH and SHIFT status
        BIT     1,A
        JR      NZ,J0FA0                ; GRAPH pressed, ignore CODE key, use GRAPH and SHIFT
        BIT     4,E                     ; CODE pressed ?
        JR      NZ,J0FA0                ; nope, no GRAPH, no CODE, use only SHIFT
        OR      $4                     ; flag CODE pressed
        DEFB    $11                    ; LD DE,xxxx
J0F9E:  AND     $01                    ; use only SHIFT
J0FA0:  LD      E,A
        ADD     A,A
        ADD     A,E
        ADD     A,A
        ADD     A,A
        ADD     A,A
        ADD     A,A
        LD      E,A                     ; *48 (6*8)
        LD      D,0
        LD      HL,D0DA5
        ADD     HL,DE                   ; keycode table
        LD      B,D
        ADD     HL,BC                   ; + scancode
        POP     AF
        LD      A,(HL)
        INC     A                       ; DEAD key ?
        JP      Z,J0F1F                 ; yep, handle dead key
        DEC     A                       ; keycode for this combination ?
        RET     Z                       ; nope, quit
        JR      C,J0FD0                 ; no CTRL pressed, non CTRL handler
        AND     $DF                    ; make upcase
        SUB     $40                     ; convert '@','A'-'Z' to keycode (controlcode)
        CP      $20                     ; was '@' or 'A'-'Z' ?
        RET     NC                      ; nope, quit (ignore)
J0FC1:  JR      C0F55                   ; put keycode in keyboardbuffer

;       Subroutine      handler functionkeys
;       Inputs          C = scancode ($35-$39)
;       Outputs         ________________________

C0FC3:  LD      A,(NEWKEY+6)
        RRCA                            ; SHIFT key pressed ?
        JR      C,J0FCD                 ; nope, F1-F5
        LD      A,C
        ADD     A,5
        LD      C,A                     ; yep, F6-F10
J0FCD:  JP      J0EC5                   ; rest of the functionkey handler

;       Subroutine      handler keycodes scancodes $00-$2F
;       Inputs          A = keycode
;       Outputs         ________________________

J0FD0:  CP      $20                     ; keycode with graphic header ?
        JR      NC,J0FDF                ; nope,
        PUSH    AF
        LD      A,1                     ; put MSX header keycode in keyboard buffer
        CALL    C0F55                   ; put keycode in keyboardbuffer
        POP     AF
        ADD     A,$40                   ; to $40-$5F keycode
        JR      J0FC1                   ; put keycode in keyboardbuffer

J0FDF:  LD      HL,CAPST
        INC     (HL)
        DEC     (HL)                    ; in CAPS mode ?
        JR      Z,J0FF0                 ; nope, unchanged
        CP      'a'
        JR      C,J1011                 ; not a lowercase letter,
        CP      'z'+1
        JR      NC,J1011                ; not a lowercase letter,
        AND     $DF                    ; upcase
J0FF0:  LD      DE,(KANAST)
        INC     E
        DEC     E                       ; DEAD key was pressed ?
        JR      Z,J0FC1                 ; nope, no DEAD + letter sequence, put keycode in keyboardbuffer and quit
        LD      D,A
        OR      $20                     ; lowercase
        LD      HL,D1061+6-1
        LD      C,6
        CPDR                            ; valid DEAD letter ?
        LD      A,D
        JR      NZ,J0FC1                ; nope, put keycode in keyboardbuffer and quit
        INC     HL
        LD      C,6
J1008:  ADD     HL,BC
        DEC     E
        JR      NZ,J1008                ; to correct DEAD table
        LD      A,(HL)
        BIT     5,D                     ; upcase letter ?
        JR      NZ,J0FC1                ; nope, put keycode in keyboardbuffer and quit
J1011:  LD      C,31
        LD      HL,D107F+$1F-1
        CPDR                            ; character with upcase variant ?
        JR      NZ,J0FC1                ; nope, put keycode in keyboardbuffer and quit
        LD      C,31
        INC     HL
        ADD     HL,BC
        LD      A,(HL)                  ; upcase variant
        JR      J0FC1                   ; put keycode in keyboardbuffer and quit

;       Subroutine      K_HAND (not offical name)
;       Inputs          C = scancode
;       Outputs         ________________________

K_HAND: LD      A,C
        LD      HL,I1B96
        CALL    H_KEYC
        LD      D, C0F06>>8             ; it is assumed that all handlers are in the $0F00-$0FFF area!
J102A:  CP      (HL)                    ; scancode handled by this entry ?
        INC     HL
        LD      E,(HL)                  ; handler (low byte)
        INC     HL
        PUSH    DE
        RET     C                       ; yep, continue in handler
        POP     DE
        JR      J102A                   ; next

;       Table           keycodes for easily converted keys
;       Remark          scancodes $30-$57

D1033:  DEFB    $00,$00,$00,$00,$00,$00,$00,$00
        DEFB    $00,$00,$1B,$09,$00,$08,$18,$0D
        DEFB    ' ' ,$0C,$12,$7F,$1D,$1E,$1F,$1C
        DEFB    '*' ,'+' ,'/' ,'0' ,'1' ,'2' ,'3' ,'4'
        DEFB    '5' ,'6' ,'7' ,'8' ,'9' ,'-' ,',' ,'.'

;       Subroutine      reset DEAD status, next postition in keyboardbuffer with roundtrip
;       Inputs          -
;       Outputs         ________________________

C105B:  XOR     A
        LD      (KANAST),A              ; reset DEAD status
        JR      C10C2                   ; next postition in keyboardbuffer with roundtrip

;       Table   valid DEAD letters

D1061:  DEFB    'a' ,'e', 'i' ,'o' ,'u' ,'y'

;       Table   translation DEAD

        DEFB    $A0,$82,$A1,$A2,$A3,$79

;       Table   translation DEAD+SHIFT

        DEFB    $B1,$65,$B3,$B5,$B7,$79

;       Table   translation DEAD+CODE

        DEFB    $85,$8A,$8D,$95,$97,$79

;       Table   translation DEAD+CODE+SHIFT

        DEFB    $83,$88,$8C,$93,$96,$79

D107F:
;       Table   accent characters with upcase

        DEFB    $83,$88,$8C,$93,$96,$84,$89,$8B
        DEFB    $94,$81,$98,$A0,$82,$A1,$A2,$A3
        DEFB    $85,$8A,$8D,$95,$97,$B1,$B3,$B5
        DEFB    $B7,$A4,$86,$87,$91,$B9,$79

;       Table   translation accent characters with upcase

D109E:  DEFB    $41,$45,$49,$4F,$55,$8E,$45,$49
        DEFB    $99,$9A,$59,$41,$90,$49,$4F,$55
        DEFB    $41,$45,$49,$4F,$55,$B0,$B2,$B4
        DEFB    $B6,$A5,$8F,$80,$92,$B8,$59

; *************************************
; END OF INTERNATIONAL KEYBOARD HANDLER
; *************************************

