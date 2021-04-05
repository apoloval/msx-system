        EXTERN  CLIKSW

; *************************************
; BEGIN OF BRASILIAN KEYBOARD HANDLER
; ************************************* 

I0DA5:  DEFB    $30,$31,$32,$33,$34,$35,$36,$37
        DEFB    $38,$39,$2D,$3D,$7B,$FF,$5B,$FF
        DEFB    $2A,$87,$2C,$2E,$3B,$2F,$61,$62
        DEFB    $63,$64,$65,$66,$67,$68,$69,$6A
        DEFB    $6B,$6C,$6D,$6E,$6F,$70,$71,$72
        DEFB    $73,$74,$75,$76,$77,$78,$79,$7A
        DEFB    $29,$21,$22,$23,$24,$25,$5E,$26
        DEFB    $27,$28,$5F,$2B,$7D,$FF,$5D,$FF
        DEFB    $40,$80,$3C,$3E,$3A,$3F,$41,$42
        DEFB    $43,$44,$45,$46,$47,$48,$49,$4A
        DEFB    $4B,$4C,$4D,$4E,$4F,$50,$51,$52
        DEFB    $53,$54,$55,$56,$57,$58,$59,$5A
        DEFB    $9,$AC,$AB,$BA,$EF,$BD,$F4,$FB
        DEFB    $EC,$7,$17,$F1,$1E,$1,$D,$6
        DEFB    $5,$BB,$F3,$F2,$1D,$5C,$C4,$11
        DEFB    $BC,$C7,$CD,$14,$15,$13,$DC,$C6
        DEFB    $DD,$C8,$B,$1B,$C2,$DB,$CC,$18
        DEFB    $D2,$12,$C0,$1A,$CF,$1C,$19,$F
        DEFB    $A,$0,$FD,$FC,$0,$0,$F5,$0
        DEFB    $0,$8,$1F,$F0,$16,$2,$E,$4
        DEFB    $3,$F7,$AE,$AF,$F6,$7C,$FE,$0
        DEFB    $FA,$C1,$CE,$D4,$10,$D6,$DF,$CA
        DEFB    $DE,$C9,$C,$D3,$C3,$D7,$CB,$A9
        DEFB    $D1,$0,$C5,$D5,$D0,$F9,$AA,$F8
        DEFB    $EB,$9F,$D9,$BF,$9B,$98,$E0,$E1
        DEFB    $E7,$87,$EE,$E9,$0,$ED,$DA,$B7
        DEFB    $B9,$E5,$86,$A6,$A7,$FF,$84,$97
        DEFB    $8D,$8B,$8C,$94,$81,$B1,$A1,$91
        DEFB    $B3,$B5,$E6,$A4,$A2,$A3,$83,$93
        DEFB    $89,$96,$82,$95,$88,$8A,$A0,$85
        DEFB    $D8,$AD,$9E,$BE,$9C,$9D,$0,$0
        DEFB    $E2,$80,$0,$0,$0,$E8,$EA,$B6
        DEFB    $B8,$E4,$8F,$0,$A8,$FF,$8E,$0
        DEFB    $0,$0,$0,$99,$9A,$B0,$0,$92
        DEFB    $B2,$B4,$0,$A5,$0,$E3,$0,$0
        DEFB    $0,$0,$90,$0,$0,$0,$0,$0

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
        LD      A,(HL)
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
        SBC     A,$0
        JR      C0F55

C0F10:  CALL    H_KEYA
        LD      E,A
        LD      D,$0
        LD      HL,I1033-$30
        ADD     HL,DE
        LD      A,(HL)
        AND     A
        RET     Z
        JR      C0F55

J0F1F:  LD      HL,NEWKEY+6
        LD      A,C
        CP      $F
        LD      A,$3
        JR      Z,J0F2B
        LD      A,$1
J0F2B:  BIT     0,(HL)
        JR      Z,J0F30
        INC     A
J0F30:  LD      C,A
        JP      J141C

;
;       leftover from KANA keyhandler, not used
;

        DEFS    $0F36-$,0

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
        LD      A,10
J0F77:  DEC     A
        JR      NZ,J0F77

K_BSND: AND     A
        LD      A,$E
        JR      Z,J0F80
        INC     A
J0F80:  OUT     ($AB),A
        RET

C0F83:  LD      A,(NEWKEY+6)
        LD      E,A
        RRA
        RRA
        PUSH    AF
        LD      A,E
        CPL
        JR      NC,J0F9E
        RRA
        RRA
        RLCA
        AND     $3
        BIT     1,A
        JR      NZ,J0FA0
        BIT     4,E
        JR      NZ,J0FA0
        OR      $4
        DEFB    $11
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
        JP      Z,J0F1F
        DEC     A
        RET     Z
        JR      C,J0FD0
        AND     $DF
        SUB     $40
        CP      $20
        RET     NC
J0FC1:  JR      C0F55

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

J0FDF:  LD      HL,CAPST
        INC     (HL)
        DEC     (HL)
        JR      Z,J0FF0
        CP      $61
        JR      C,J1011
        CP      $7B
        JR      NC,J1011
        AND     $DF
J0FF0:  LD      DE,(KANAST)
        INC     E
        DEC     E
        JR      Z,J0FC1
        LD      D,A
        OR      $20
        LD      HL,I1061+5-1
        LD      C,5
        CPDR
        LD      A,D
        JR      NZ,J0FC1
        INC     HL
        LD      C,$5
J1008:  ADD     HL,BC
        DEC     E
        JR      NZ,J1008
        LD      A,(HL)
        BIT     5,D
        JR      NZ,J0FC1
J1011:  LD      C,20
        LD      HL,I107F+20-1
        CPDR
        JR      NZ,J0FC1
        LD      C,20
        INC     HL
        ADD     HL,BC
        LD      A,(HL)
        JR      J0FC1

K_HAND: LD      A,C
        LD      HL,I1B96
        CALL    H_KEYC
        LD      D,HIGH C0F06
J102A:  CP      (HL)
        INC     HL
        LD      E,(HL)
        INC     HL
        PUSH    DE
        RET     C
        POP     DE
        JR      J102A

I1033:  DEFB    $0,$0,$0,$0,$0,$0,$0,$0
        DEFB    $0,$0,$1B,$9,$0,$8,$18,$D
        DEFB    $20,$C,$12,$7F,$1D,$1E,$1F,$1C
        DEFB    $2B,$2D,$2A,$2F,$0,$0,$0,$0
        DEFB    $0,$0,$0,$0,$0,$0,$0,$0

;         Subroutine __________________________
;            Inputs  ________________________
;            Outputs ________________________

C105B:  XOR     A
        LD      (KANAST),A
        JR      J10C2

I1061:  DEFB    $61,$65,$69,$6F,$75
        DEFB    $85,$65,$69,$95,$97
        DEFB    $A0,$82,$A1,$A2,$A3
        DEFB    $83,$88,$69,$93,$96
        DEFB    $B1,$65,$B3,$B5,$81
        DEFB    $00,$00,$00,$00,$00

I107F:  DEFB    $85,$65,$69,$6F,$97,$A0,$82,$A1,$A2,$A3,$83,$88,$93,$96,$61,$75,$81,$B1,$B5,$87
        DEFB    $8F,$45,$49,$4F,$55,$84,$90,$89,$8A,$8B,$8C,$8D,$8E,$55,$41,$55,$9A,$B0,$B4,$80

; *************************************
; END OF BRASILIAN KEYBOARD HANDLER
; ************************************* 
