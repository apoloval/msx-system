; *************************************
; BEGIN OF RUSSIAN KEYBOARD HANDLER
; *************************************
;

        EXTERN  CLIKSW

I0DA5:  DEFB    $29,$2B,$21,$22,$23,$BF,$25,$26
        DEFB    $27,$28,$24,$3D,$2D,$68,$2A,$76
        DEFB    $5C,$3E,$62,$40,$3C,$3F,$66,$69
        DEFB    $73,$77,$75,$61,$70,$72,$5B,$6F
        DEFB    $6C,$64,$78,$74,$5D,$7A,$6A,$6B
        DEFB    $79,$65,$67,$6D,$63,$7C,$6E,$71

        DEFB    $39,$3B,$31,$32,$33,$34,$35,$36
        DEFB    $37,$38,$30,$5F,$5E,$48,$3A,$56
        DEFB    $5C,$2E,$42,$40,$2C,$2F,$46,$49
        DEFB    $53,$57,$55,$41,$50,$52,$7B,$4F
        DEFB    $4C,$44,$58,$54,$7D,$5A,$4A,$4B
        DEFB    $59,$45,$47,$4D,$43,$7E,$4E,$51

        DEFB    $9,$A0,$AB,$A1,$AF,$A2,$B4,$BB
        DEFB    $AC,$7,$17,$B1,$1E,$1,$D,$6
        DEFB    $5,$A3,$B3,$B2,$1D,$60,$84,$11
        DEFB    $A4,$87,$8D,$14,$15,$13,$9C,$86
        DEFB    $9D,$88,$B,$1B,$82,$9B,$8C,$18
        DEFB    $92,$12,$80,$1A,$8F,$1C,$19,$F

        DEFB    $A,$A5,$BD,$BC,$A6,$A7,$B5,$A8
        DEFB    $A9,$8,$1F,$B0,$16,$2,$E,$4
        DEFB    $3,$B7,$AE,$9A,$B6,$0,$BE,$99
        DEFB    $BA,$81,$8E,$94,$10,$96,$9F,$8A
        DEFB    $9E,$89,$C,$93,$83,$97,$8B,$AA
        DEFB    $91,$AD,$85,$95,$90,$B9,$98,$B8

        DEFB    $29,$2B,$21,$22,$23,$BF,$25,$26
        DEFB    $27,$28,$0,$3D,$DF,$C8,$2A,$D6
        DEFB    $DC,$3E,$C2,$C0,$3C,$3F,$C6,$C9
        DEFB    $D3,$D7,$D5,$C1,$D0,$D2,$DB,$CF
        DEFB    $CC,$C4,$D8,$D4,$DD,$DA,$CA,$CB
        DEFB    $D9,$C5,$C7,$CD,$C3,$DE,$CE,$D1

        DEFB    $39,$3B,$31,$32,$33,$34,$35,$36
        DEFB    $37,$38,$30,$5F,$2D,$E8,$3A,$F6
        DEFB    $FC,$2E,$E2,$E0,$2C,$2F,$E6,$E9
        DEFB    $F3,$F7,$F5,$E1,$F0,$F2,$FB,$EF
        DEFB    $EC,$E4,$F8,$F4,$FD,$FA,$EA,$EB
        DEFB    $F9,$E5,$E7,$ED,$E3,$FE,$EE,$F1


J0EC5:  LD      E,C
        LD      D,$0
        LD      HL,FNKFLG-$35
        ADD     HL,DE
        LD      A,(HL)
        AND     A
        JR      NZ,J0EE3
J0ED0:  EX      DE,HL
        ADD     HL,HL
        ADD     HL,HL
        ADD     HL,HL
        ADD     HL,HL
        LD      DE,FNKSTR-$35*16
        ADD     HL,DE
        EX      DE,HL
J0EDA:  LD      A,(DE)
        AND     A
        RET     Z
        CALL    C0F55
        INC     DE
        JR      J0EDA

J0EE3:  LD      HL,(CURLIN)
        INC     HL
        LD      A,H
        OR      L
        JR      Z,J0ED0
        LD      HL,TRPTBL-$35*3
        ADD     HL,DE
        ADD     HL,DE
        ADD     HL,DE

;       Subroutine      raise trap
;       Inputs          ________________________
;       Outputs         ________________________
;       Remark          code identical among keyboard layout versions

C0EF1:  LD      A,(HL)
        AND     $1
        RET     Z
        LD      A,(HL)
        OR      $4
        CP      (HL)
        RET     Z
        LD      (HL),A
        XOR     $5
        RET     NZ
        LD      A,(ONGSBF)
        INC     A
        LD      (ONGSBF),A
        RET     

C0F06:  LD      A,(NEWKEY+6)
        RRCA    
        LD      A,$C
        SBC     A,0
        JR      C0F55

;         Subroutine key handler for scancode $30 and above returning normal keycode
;            Inputs  ________________________
;            Outputs ________________________

C0F10:  CALL    H_KEYA
        LD      E,A
        LD      D,$0
        LD      HL,D1033-$30
        ADD     HL,DE
        LD      A,(HL)
        AND     A
        RET     Z                       ; no action, quit
        JR      C0F55

;         Subroutine russian �kana� key
;            Inputs  ________________________
;            Outputs ________________________

C0F1F:  LD      HL,KANAST
        LD      A,(HL)
        CPL     
        LD      (HL),A
J0F29:  LD      A,$F
        OUT     ($A0),A
        IN      A,($A2)
        AND     $7F
        LD      B,A
        LD      A,(HL)
        CPL     
        AND     $80
        OR      B
        OUT     ($A1),A
        RET

;         Subroutine CAPS key handler
;            Inputs  ________________________
;            Outputs ________________________

C0F36:  LD      HL,CAPST
        LD      A,(HL)
        CPL     
        LD      (HL),A
        CPL     

K_BCAP: AND     A
        LD      A,$C
        JR      Z,J0F43
        INC     A
J0F43:  OUT     ($AB),A
        RET     

C0F46:  LD      A,(NEWKEY+6)
        RRCA    
        RRCA    
        LD      A,$3
        JR      NC,J0F50
        INC     A
J0F50:  LD      (INTFLG),A
        JR      C,J0F64

;         Subroutine __________________________
;            Inputs  ________________________
;            Outputs ________________________

C0F55:  LD      HL,(PUTPNT)
        LD      (HL),A
        CALL    C105B
        LD      A,(GETPNT)
        CP      L
        RET     Z
        LD      (PUTPNT),HL
J0F64:  LD      A,(CLIKSW)
        AND     A
        RET     Z
        LD      A,(CLIKFL)
        AND     A
        RET     NZ
        LD      A,$F
        LD      (CLIKFL),A
        OUT     ($AB),A
        LD      A,$A
J0F77:  DEC     A
        JR      NZ,J0F77

K_BSND: AND     A
        LD      A,$E
        JR      Z,J0F80
        INC     A
J0F80:  OUT     ($AB),A
        RET     

;         Subroutine ordinary key handler
;            Inputs  ________________________
;            Outputs ________________________

C0F83:  LD      A,(NEWKEY+6)
        LD      E,A
        RRA     
        RRA     
        PUSH    AF
        LD      A,E
        CPL     
        JR      NC,J0F9E                ; CTRL pressed,
        RRA     
        RRA     
        RLCA    
        AND     $3                     ; 3 
        BIT     1,A
        JR      NZ,J0FA0                ; GRAPH pressed,
        JP      J1067                   ; patched code, handle russian �kana�, resumes at $0FA0

        DEFS    $0F9E-$,0               ; unused space

J0F9E:  AND     $01
J0FA0:  LD      E,A
        ADD     A,A
        ADD     A,E
        ADD     A,A
        ADD     A,A
        ADD     A,A
        ADD     A,A
        LD      E,A
        LD      D,$0
        LD      HL,I0DA5
        ADD     HL,DE
        LD      B,D
        ADD     HL,BC
        POP     AF
        LD      A,(HL)
        INC     A
        JP      Z,C0F1F                 ; dead key, handle
        DEC     A
        RET     Z                       ; no action for key, quit
        JR      C,J0FD0                 ; CTRL not pressed,
        AND     $DF
        SUB     $40
        CP      $20
        RET     NC
J0FC1:  JR      C0F55

;         Subroutine function key handler
;            Inputs  ________________________
;            Outputs ________________________

C0FC3:  LD      A,(NEWKEY+6)
        RRCA    
        JR      C,J0FCD
        LD      A,C
        ADD     A,$5
        LD      C,A
J0FCD:  JP      J0EC5

J0FD0:  CP      $20
        JR      NC,J0FDF
        PUSH    AF
        LD      A,$1
        CALL    C0F55
        POP     AF
        ADD     A,$40
        JR      J0FC1

J0FDF:  JP      J1073                   ; patch code for upcase

        DEFS    $0FF0-$,0               ; unused space

J0FEE:  AND     $DF
J0FF0:  JP      C0F55

        DEFS    $1011-$,0               ; unused space

J1011:  JP      C0F55

        DEFS    $1021-$,0               ; usused space

K_HAND: LD      A,C
        LD      HL,I1B96
        CALL    H_KEYC
        LD      D,$F
J102A:  CP      (HL)
        INC     HL
        LD      E,(HL)
        INC     HL
        PUSH    DE
        RET     C
        POP     DE
        JR      J102A

D1033:  DEFB    $0,$0,$0,$0,$0,$0,$0,$0
        DEFB    $0,$0,$1B,$9,$0,$8,$18,$D
        DEFB    $20,$C,$12,$7F,$1D,$1E,$1F,$1C
        DEFB    $D,$2B,$2A,$30,$31,$32,$33,$34
        DEFB    $35,$36,$37,$38,$39,$2D,$2C,$2E

;         Subroutine __________________________
;            Inputs  ________________________
;            Outputs ________________________

C105B:  XOR     A
        NOP
        NOP
        NOP                             ; patch hole, normaly resets KANAST
        JR      C10C2

        DEFS    $1067-$,0               ; unused space

J1067:  PUSH    AF
        LD      A,(KANAST)
        AND     $4
        LD      E,A
        POP     AF
        OR      E
        JP      J0FA0

J1073:  LD      HL,CAPST
        INC     (HL)
        DEC     (HL)
        JP      Z,J0FF0
        CP      $61
        JP      C,J1011
        CP      $DF
        JP      NC,J1011
        CP      $7B
        JP      C,J0FEE
        CP      $C0
        JP      C,J1011
        OR      $20
        JP      J0FF0

; *************************************
; END OF RUSSIAN KEYBOARD HANDLER
; *************************************
