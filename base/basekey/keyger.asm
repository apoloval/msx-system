; *************************************
; BEGIN OF GERMAN KEYBOARD HANDLER
; *************************************
;

        EXTERN  CLIKSW

D0DA5:
; Normal layout

        DEFB    $30,$31,$32,$33,$34,$35,$36,$37
        DEFB    $38,$39,$E1,$FF,$3C,$81,$2B,$94
        DEFB    $84,$23,$2C,$2E,$2D,$0,$61,$62
        DEFB    $63,$64,$65,$66,$67,$68,$69,$6A
        DEFB    $6B,$6C,$6D,$6E,$6F,$70,$71,$72
        DEFB    $73,$74,$75,$76,$77,$78,$7A,$79

; Shift layout

        DEFB    $3D,$21,$22,$BF,$24,$25,$26,$2F
        DEFB    $28,$29,$3F,$FF,$3E,$9A,$2A,$99
        DEFB    $8E,$5E,$3B,$3A,$5F,$0,$41,$42
        DEFB    $43,$44,$45,$46,$47,$48,$49,$4A
        DEFB    $4B,$4C,$4D,$4E,$4F,$50,$51,$52
        DEFB    $53,$54,$55,$56,$57,$58,$5A,$59

; Graph layout

        DEFB    $9,$AC,$AB,$BA,$EF,$BD,$F4,$1D
        DEFB    $EC,$7,$D,$27,$AE,$1,$F1,$6
        DEFB    $5,$7E,$FB,$16,$17,$0,$C4,$11
        DEFB    $BC,$C7,$CD,$14,$15,$13,$DC,$C6
        DEFB    $DD,$C8,$B,$1B,$C2,$DB,$CC,$18
        DEFB    $D2,$12,$C0,$1A,$CF,$1C,$19,$F

; Shift+Graph layout

        DEFB    $A,$0,$FD,$FC,$0,$F6,$F5,$1E
        DEFB    $0,$8,$E,$60,$AF,$2,$1F,$4
        DEFB    $3,$BB,$F7,$0,$F0,$0,$FE,$0
        DEFB    $FA,$C1,$CE,$D4,$10,$D6,$DF,$CA
        DEFB    $DE,$C9,$C,$D3,$C3,$D7,$CB,$A9
        DEFB    $D1,$D9,$C5,$D5,$D0,$F9,$AA,$F8

; Code layout

        DEFB    $EB,$7C,$40,$EE,$87,$9B,$E7,$5C
        DEFB    $5B,$5D,$E9,$FF,$F3,$ED,$DA,$B7
        DEFB    $B9,$E5,$86,$A6,$A7,$0,$E0,$97
        DEFB    $8D,$8B,$8C,$9F,$98,$B1,$A1,$91
        DEFB    $B3,$B5,$E6,$A4,$A2,$A3,$83,$93
        DEFB    $89,$96,$82,$95,$88,$8A,$A0,$85

; Shift+Code layout

        DEFB    $D8,$AD,$9E,$BE,$80,$9C,$E2,$0
        DEFB    $7B,$7D,$A8,$FF,$F2,$E8,$EA
        DEFB    $B6,$B8,$E4,$8F,$0,$0,$0,$0
        DEFB    $0
        DEFB    $0,$0,$0,$0,$0,$B0,$0,$92
        DEFB    $B2,$B4,$0,$A5,$0,$E3,$0,$0
        DEFB    $0,$0,$90,$0,$0,$0,$0,$9D

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
        LD      HL,I1038-$30
        ADD     HL,DE
        LD      A,(HL)
        AND     A                       ; keycode for key ?
        RET     Z                       ; nope, quit
        JR      C0F55                   ; put keycode in keyboardbuffer

I0F1F:  DEFB    $30, $00FF&C0F83
        DEFB    $33, $00FF&C0F10
        DEFB    $34, $00FF&C0F36
        DEFB    $35, $00FF&C0F10
        DEFB    $3A, $00FF&C0FC3
        DEFB    $3C, $00FF&C0F10
        DEFB    $3D, $00FF&C0F46
        DEFB    $40, $00FF&C0F10
        DEFB    $41, $00FF&C0FF1
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
        CALL    C1060                   ; reset DEAD status, next postition in keyboardbuffer with roundtrip
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
        NOP
        NOP                             ; removed code for CTRL key (was in INT keyboard)
        RRA
        RRA
        RLCA
        AND     $3                     ; GRAPH and SHIFT status
        BIT     1,A
        JR      NZ,J0FA0                ; GRAPH pressed, ignore CODE key, use GRAPH and SHIFT
        BIT     4,E                     ; CODE pressed ?
        JR      NZ,J0FA0                ; nope, no GRAPH, no CODE, use only SHIFT
        OR      $4                     ; flag CODE pressed
        NOP
        NOP
        NOP                             ; removed code for CTRL key (was in INT keyboard)
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
        JP      Z,J1B96                 ; yep, handle dead key
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
        JR      Z,J0FF5                 ; nope, unchanged
        CP      'a'
        JR      C,J1016                 ; not a lowercase letter,
        CP      'z'+1
        JR      NC,J1016                ; not a lowercase letter,
        AND     $DF                    ; upcase
        DEFB    $DA                    ; German keyboard extra instruction, to skip LD A,' '
C0FF1:  LD      A,' '                   ; German keyboard extra instruction
J0FF5:  LD      B,0                     ; German keyboard extra instruction
        LD      DE,(KANAST)
        INC     E
        DEC     E                       ; DEAD key was pressed ?
        JR      Z,J0FC1                 ; nope, no DEAD + letter sequence, put keycode in keyboardbuffer and quit

;
;       The following code handles Dead key mode, but should never occure on the german keyboard
;
        LD      D,A
        OR      $20                     ; lowercase
        LD      HL,I1066+7-1
        LD      C,7
        CPDR
        LD      A,D
        JR      NZ,J0FC1                ; not a vowel, no accent
        INC     HL
        LD      C,7
J100D:  ADD     HL,BC
        DEC     E
        JR      NZ,J100D                ; to correct DEAD table
        LD      A,(HL)
        BIT     5,D                     ; upcase letter ?
        JR      NZ,J0FC1                ; nope, put keycode in keyboardbuffer and quit
J1016:  LD      C,37
        LD      HL,I106D+37-1
        CPDR                            ; character with upcase variant ?
        JR      NZ,J0FC1                ; nope, put keycode in keyboardbuffer and quit
        LD      C,37
        INC     HL
        ADD     HL,BC
        LD      A,(HL)                  ; upcase variant
        JR      J0FC1                   ; put keycode in keyboardbuffer and quit

;       Subroutine      K_HAND (not offical name)
;       Inputs          C = scancode
;       Outputs         ________________________

K_HAND: LD      A,C
        LD      HL,I0F1F
        JP      J10B7                   ; patch routine for dead key on german keyboard

J102D:  LD      D, C0F06>>8             ; it is assumed that all handlers are in the $0F00-$0FFF area!
J102F:  CP      (HL)                    ; scancode handled by this entry ?
        INC     HL
        LD      E,(HL)                  ; handler (low byte)
        INC     HL
        PUSH    DE
        RET     C                       ; yep, continue in handler
        POP     DE
        JR      J102F                   ; next

;       Table           keycodes for easily converted keys
;       Remark          scancodes $30-$57

I1038:  DEFB    $0,$0,$0,$0,$0,$0,$0,$0
        DEFB    $0,$0,$1B,$9,$0,$8,$18,$D
        DEFB    $20,$C,$12,$7F,$1D,$1E,$1F,$1C
        DEFB    $2A,$2B,$2F,$30,$31,$32,$33,$34
        DEFB    $35,$36,$37,$38,$39,$2D,$2C,$2E

;       Subroutine      reset DEAD status, next postition in keyboardbuffer with roundtrip
;       Inputs          -
;       Outputs         ________________________

C1060:  XOR     A
        LD      (KANAST),A
        JR      C10C2

;       Table   valid DEAD letters

I1066:  DEFB    'a' ,'e' ,'i' ,'o' ,'u' ,'y' ,' '

I106D:  DEFB    $A0,$82,$A1,$A2,$A3,$79,$27              ; DEAD
        DEFB    $85,$8A,$8D,$95,$97,$79,$60              ; SHIFT DEAD
        DEFB    $83,$88,$8C,$93,$96,$79,$5E              ; CODE DEAD
        DEFB    $84,$89,$8B,$94,$81,$98,$20              ; SHIFT CODE DEAD

        DEFB    $B1,$B3,$B5,$B7,$A4,$86,$87,$91,$B9    ; accent vowels with upcase version

; upcase version of 0106D

        DEFB    'A' ,'E' ,'I' ,'O' ,'U' ,'Y' ,$60
        DEFB    'A' ,$90,'I' ,'O' ,'U' ,'Y' ,$27
        DEFB    'A' ,'E' ,'I' ,'O' ,'U' ,'Y' ,$5E
        DEFB    $8E,'E' ,'I' ,$99,$9A,'Y' ,$20

        DEFB    $B0,$B2,$B4,$B6,$A5,$8F,$80,$92,$B8

;       Patch           deadkey on german keyboard
;       Inputs          -
;       Outputs         ________________________

J10B7:  CALL    H_KEYC
        CP      $15                     ; DEAD key (strange, key not on a german keyboard) ?
        JP      Z,C0F36                 ; yep, handle like CAPS key
        JP      J102D                   ; continue orginal code

; *************************************
; END OF GERMAN KEYBOARD HANDLER
; *************************************
