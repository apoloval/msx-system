; BASIC.ASM

; MSX BASIC ROM, MSX 1 version (version 1.0)

; Source re-created by Z80DIS 2.2
; Z80DIS was written by Kenneth Gielow, Palo Alto, CA

; Code Copyrighted by ASCII and maybe others
; Source comments by Arjen Zeilemaker

; Sourcecode supplied for STUDY ONLY
; Recreation NOT permitted without authorisation of the copyrightholders

        INCLUDE "const.def"
        INCLUDE "msx.def"

; Define some RST vectors
        DEFC    CHRGTR = $10
        DEFC    DCOMPR = $20
        DEFC    GETYPR = $28

; Declare public symbols used from basic2.asm
        PUBLIC  C268C
        PUBLIC  C2697
        PUBLIC  C269A
        PUBLIC  C27E6
        PUBLIC  C289F
        PUBLIC  C2993
        PUBLIC  C29AC
        PUBLIC  C29FB
        PUBLIC  C2A14
        PUBLIC  C2A72
        PUBLIC  C2AFF
        PUBLIC  C2B4A
        PUBLIC  C2BDF
        PUBLIC  C2C24
        PUBLIC  C2E71
        PUBLIC  C2E82
        PUBLIC  C2E86
        PUBLIC  C2E97
        PUBLIC  C2E9A
        PUBLIC  C2EA1
        PUBLIC  C2EAB
        PUBLIC  C2EB1
        PUBLIC  C2EBE
        PUBLIC  C2EC1
        PUBLIC  C2ECC
        PUBLIC  C2ED6
        PUBLIC  C2EDF
        PUBLIC  C2EE1
        PUBLIC  C2EE8
        PUBLIC  C2EEF
        PUBLIC  C2EF3
        PUBLIC  C2EF7
        PUBLIC  C2F08
        PUBLIC  C2F0D
        PUBLIC  C2F10
        PUBLIC  C2F21
        PUBLIC  C2F4D
        PUBLIC  C2F5C
        PUBLIC  C2F83
        PUBLIC  C2F8A
        PUBLIC  C2F99
        PUBLIC  C2FB2
        PUBLIC  C2FCB
        PUBLIC  C303A
        PUBLIC  C3058
        PUBLIC  C30BE
        PUBLIC  C30CF
        PUBLIC  C314A
        PUBLIC  C3167
        PUBLIC  C3172
        PUBLIC  C3193
        PUBLIC  C31E6
        PUBLIC  C3236
        PUBLIC  C323A
        PUBLIC  C324E
        PUBLIC  C3257
        PUBLIC  C325C
        PUBLIC  C3267
        PUBLIC  C3299
        PUBLIC  C340A
        PUBLIC  C3412
        PUBLIC  C3425
        PUBLIC  C3426
        PUBLIC  C371A
        PUBLIC  C371E
        PUBLIC  C3722
        PUBLIC  C37C8
        PUBLIC  C37D7
        PUBLIC  C383F
        PUBLIC  I2D1B
        PUBLIC  J2E79
        PUBLIC  J3265
        PUBLIC  J3297

; Declared external references to the basic2.asm program
        EXTERN  C475A
        EXTERN  C4EB8
        EXTERN  C4F47
        EXTERN  C5439
        EXTERN  C6678
        EXTERN  I3FD2
        EXTERN  I6677
        EXTERN  J4058
        EXTERN  J4067
        EXTERN  J406D
        EXTERN  J601D
        EXTERN  J66A7

; Program start
;       ORG     $268C

;       Subroutine      DECSUB (dbl subtract)
;       Inputs          (DAC) = first operand, (ARG) = second operand
;       Outputs         ________________________

C268C:  LD      HL,ARG
        LD      A,(HL)
        OR      A
        RET     Z                       ; 2nd operand zero, quit
        XOR     $80
        LD      (HL),A                  ; negate 2nd operand
        JR      J26A0                   ; and do ADD

;       Subroutine      double real addition
;       Inputs          (DAC) = first operand, (HL) = second operand
;       Outputs         ________________________

C2697:  CALL    C2EEF                   ; ARG = HL

;       Subroutine      DECADD (dbl addition)
;       Inputs          (DAC) = first operand, (ARG) = second operand
;       Outputs         ________________________

C269A:  LD      HL,ARG
        LD      A,(HL)
        OR      A
        RET     Z                       ; 2nd operand zero, quit
J26A0:  AND     $7F
        LD      B,A
        LD      DE,DAC
        LD      A,(DE)
        OR      A
        JP      Z,C2F05                 ; DAC = ARG and quit
        AND     $7F
        SUB     B
        JR      NC,J26C1
        CPL
        INC     A
        PUSH    AF
        PUSH    HL
        LD      B,8
J26B6:  LD      A,(DE)
        LD      C,(HL)
        LD      (HL),A
        LD      A,C
        LD      (DE),A
        INC     DE
        INC     HL
        DJNZ    J26B6
        POP     HL
        POP     AF
J26C1:  CP      16
        RET     NC
        PUSH    AF
        XOR     A
        LD      (DAC+8),A
        LD      (ARG+8),A
        LD      HL,ARG+1
        POP     AF
        CALL    C27A3
        LD      HL,ARG
        LD      A,(DAC)
        XOR     (HL)
        JP      M,J26F7
        LD      A,(ARG+8)
        LD      (DAC+8),A
        CALL    C2759
        JP      NC,C273C                ; round DAC and quit
        EX      DE,HL
        LD      A,(HL)
        INC     (HL)
        XOR     (HL)
        JP      M,J4067                 ; overflow error
        CALL    C27DB
        SET     4,(HL)
        JR      C273C                   ; round DAC and quit

J26F7:  CALL    C276B

;       Subroutine      DECNRM
;       Inputs          ________________________
;       Outputs         ________________________

C26FA:  LD      HL,DAC+1
        LD      BC,$0800
J2700:  LD      A,(HL)
        OR      A
        JR      NZ,J270C
        INC     HL
        DEC     C
        DEC     C
        DJNZ    J2700
        JP      J2E7D                   ; DAC = 0 and quit

J270C:  AND     $F0
        JR      NZ,J2716
        PUSH    HL
        CALL    C2797
        POP     HL
        DEC     C
J2716:  LD      A,8
        SUB     B
        JR      Z,J272D
        PUSH    AF
        PUSH    BC
        LD      C,B
        LD      DE,DAC+1
        LD      B,0
        LDIR
        POP     BC
        POP     AF
        LD      B,A
        XOR     A
J2729:  LD      (DE),A
        INC     DE
        DJNZ    J2729
J272D:  LD      A,C
        OR      A
        JR      Z,C273C                 ; round DAC and quit
        LD      HL,DAC
        LD      B,(HL)
        ADD     A,(HL)
        LD      (HL),A
        XOR     B
        JP      M,J4067                 ; overflow error
        RET     Z

;       Subroutine      DECROU
;       Inputs          ________________________
;       Outputs         ________________________

C273C:  LD      HL,DAC+8
        LD      B,7

;       Subroutine      __________________________
;       Inputs          ________________________
;       Outputs         ________________________

C2741:  LD      A,(HL)
        CP      $50
        RET     C
        DEC     HL
        XOR     A
        SCF
J2748:  ADC     A,(HL)
        DAA
        LD      (HL),A
        RET     NC
        DEC     HL
        DJNZ    J2748
        LD      A,(HL)
        INC     (HL)
        XOR     (HL)
        JP      M,J4067                 ; overflow error
        INC     HL
        LD      (HL),$10
        RET

;       Subroutine      __________________________
;       Inputs          ________________________
;       Outputs         ________________________

C2759:  LD      HL,ARG+7
        LD      DE,DAC+7
        LD      B,7

;       Subroutine      __________________________
;       Inputs          ________________________
;       Outputs         ________________________

C2761:  XOR     A
J2762:  LD      A,(DE)
        ADC     A,(HL)
        DAA
        LD      (DE),A
        DEC     DE
        DEC     HL
        DJNZ    J2762
        RET

;       Subroutine      __________________________
;       Inputs          ________________________
;       Outputs         ________________________

C276B:  LD      HL,ARG+8
        LD      A,(HL)
        CP      $50
        JR      NZ,J2774
        INC     (HL)
J2774:  LD      DE,DAC+8
        LD      B,8
        XOR     A
J277A:  LD      A,(DE)
        SBC     A,(HL)
        DAA
        LD      (DE),A
        DEC     DE
        DEC     HL
        DJNZ    J277A
        RET     NC
        EX      DE,HL
        LD      A,(HL)
        XOR     $80
        LD      (HL),A
        LD      HL,DAC+8
        LD      B,8
        XOR     A
J278E:  LD      A,$0
        SBC     A,(HL)
        DAA
        LD      (HL),A
        DEC     HL
        DJNZ    J278E
        RET

;       Subroutine      __________________________
;       Inputs          ________________________
;       Outputs         ________________________

C2797:  LD      HL,DAC+8

;       Subroutine      __________________________
;       Inputs          ________________________
;       Outputs         ________________________

C279A:  PUSH    BC
        XOR     A
J279C:  RLD
        DEC     HL
        DJNZ    J279C
        POP     BC
        RET

;       Subroutine      __________________________
;       Inputs          ________________________
;       Outputs         ________________________

C27A3:  OR      A
        RRA
        PUSH    AF
        OR      A
        JP      Z,J27E2
        PUSH    AF
        CPL
        INC     A
        LD      C,A
        LD      B,$FF
        LD      DE,7
        ADD     HL,DE
        LD      D,H
        LD      E,L
        ADD     HL,BC
        LD      A,8
        ADD     A,C
        LD      C,A
        PUSH    BC
        LD      B,$0
        LDDR
        POP     BC
        POP     AF
        INC     HL
        INC     DE
        PUSH    DE
        LD      B,A
        XOR     A
J27C7:  LD      (HL),A
        INC     HL
        DJNZ    J27C7
        POP     HL
        POP     AF
        RET     NC
        LD      A,C
J27CF:  PUSH    HL
        PUSH    BC
        LD      B,A
        XOR     A
J27D3:  RRD
        INC     HL
        DJNZ    J27D3
        POP     BC
        POP     HL
        RET

;       Subroutine      __________________________
;       Inputs          ________________________
;       Outputs         ________________________

C27DB:  LD      HL,DAC+1
J27DE:  LD      A,8
        JR      J27CF

J27E2:  POP     AF
        RET     NC
        JR      J27DE

;       Subroutine      DECMUL
;       Inputs          ________________________
;       Outputs         ________________________

C27E6:  CALL    C2E71                   ; get sign DAC
        RET     Z                       ; DAC is zero, quit (result is zero)
        LD      A,(ARG+0)
        OR      A
        JP      Z,J2E7D                 ; DAC = 0 and quit
        LD      B,A
        LD      HL,DAC
        XOR     (HL)
        AND     $80
        LD      C,A
        RES     7,B
        LD      A,(HL)
        AND     $7F
        ADD     A,B
        LD      B,A
        LD      (HL),$0
        AND     $C0
        RET     Z
        CP      $C0
        JR      NZ,J280C
        JP      J4067                   ; overflow error

J280C:  LD      A,B
        ADD     A,$40
        AND     $7F
        RET     Z
        OR      C
        DEC     HL
        LD      (HL),A
        LD      DE,HOLD8+63
        LD      BC,8
        LD      HL,DAC+7
        PUSH    DE
        LDDR
        INC     HL
        XOR     A
        LD      B,8
J2825:  LD      (HL),A
        INC     HL
        DJNZ    J2825
        POP     DE
        LD      BC,J2883
        PUSH    BC

;       Subroutine      __________________________
;       Inputs          ________________________
;       Outputs         ________________________

C282E:  CALL    C288A
        PUSH    HL
        LD      BC,8
        EX      DE,HL
        LDDR
        EX      DE,HL
        LD      HL,HOLD8+55
        LD      B,8
        CALL    C2761
        POP     DE
        CALL    C288A
        LD      C,7
        LD      DE,ARG+7
J284A:  LD      A,(DE)
        OR      A
        JR      NZ,J2852
        DEC     DE
        DEC     C
        JR      J284A

J2852:  LD      A,(DE)
        DEC     DE
        PUSH    DE
        LD      HL,HOLD8+7
J2858:  ADD     A,A
        JR      C,J2863
        JR      Z,J2871
J285D:  LD      DE,8
        ADD     HL,DE
        JR      J2858

J2863:  PUSH    AF
        LD      B,8
        LD      DE,DAC+7
        PUSH    HL
        CALL    C2761
        POP     HL
        POP     AF
        JR      J285D

J2871:  LD      B,$F
        LD      DE,DAC+14
        LD      HL,DAC+15
        CALL    C2EFE
        LD      (HL),$0
        POP     DE
        DEC     C
        JR      NZ,J2852
        RET

J2883:  DEC     HL
        LD      A,(HL)
        INC     HL
        LD      (HL),A
        JP      C26FA                   ; normalize DAC

;       Subroutine      __________________________
;       Inputs          ________________________
;       Outputs         ________________________

C288A:  LD      HL,-8
        ADD     HL,DE
        LD      C,3
J2890:  LD      B,8
        OR      A
J2893:  LD      A,(DE)
        ADC     A,A
        DAA
        LD      (HL),A
        DEC     HL
        DEC     DE
        DJNZ    J2893
        DEC     C
        JR      NZ,J2890
        RET

;       Subroutine      DECDIV (dbl division)
;       Inputs          (DAC) = first operand, (ARG) = second operand
;       Outputs         ________________________

C289F:  LD      A,(ARG)
        OR      A
        JP      Z,J4058
        LD      B,A
        LD      HL,DAC
        LD      A,(HL)
        OR      A
        JP      Z,J2E7D                 ; DAC = 0 and quit
        XOR     B
        AND     $80
        LD      C,A
        RES     7,B
        LD      A,(HL)
        AND     $7F
        SUB     B
        LD      B,A
        RRA
        XOR     B
        AND     $40
        LD      (HL),$0
        JR      Z,J28C9
        LD      A,B
        AND     $80
        RET     NZ
J28C6:  JP      J4067                   ; overflow error

J28C9:  LD      A,B
        ADD     A,$41
        AND     $7F
        LD      (HL),A
        JR      Z,J28C6
        OR      C
        LD      (HL),$0
        DEC     HL
        LD      (HL),A
        LD      DE,DAC+7
        LD      HL,ARG+7
        LD      B,7
        XOR     A
J28DF:  CP      (HL)
        JR      NZ,J28E6
        DEC     DE
        DEC     HL
        DJNZ    J28DF
J28E6:  LD      (DECTM2),HL
        EX      DE,HL
        LD      (DECTMP),HL
        LD      A,B
        LD      (DECCNT),A
        LD      HL,HOLD8+56
J28F4:  LD      B,$F
J28F6:  PUSH    HL
        PUSH    BC
        LD      HL,(DECTM2)
        EX      DE,HL
        LD      HL,(DECTMP)
        LD      A,(DECCNT)
        LD      C,$FF
J2904:  INC     C
        LD      B,A
        PUSH    HL
        PUSH    DE
        XOR     A
        EX      DE,HL
J290A:  LD      A,(DE)
        SBC     A,(HL)
        DAA
        LD      (DE),A
        DEC     HL
        DEC     DE
        DJNZ    J290A
        LD      A,(DE)
        SBC     A,B
        LD      (DE),A
        POP     DE
        POP     HL
        LD      A,(DECCNT)
        JR      NC,J2904
        LD      B,A
        EX      DE,HL
        CALL    C2761
        JR      NC,J2925
        EX      DE,HL
        INC     (HL)
J2925:  LD      A,C
        POP     BC
        LD      C,A
        PUSH    BC
        SRL     B
        INC     B
        LD      E,B
        LD      D,$0
        LD      HL,$F7F5
        ADD     HL,DE
        CALL    C279A
        POP     BC
        POP     HL
        LD      A,B
        INC     C
        DEC     C
        JR      NZ,J2973
        CP      $F
        JR      Z,J2964
        RRCA
        RLCA
        JR      NC,J2973
        PUSH    BC
        PUSH    HL
        LD      HL,DAC
        LD      B,8
        XOR     A
J294D:  CP      (HL)
        JR      NZ,J295F
        INC     HL
        DJNZ    J294D
        POP     HL
        POP     BC
        SRL     B
        INC     B
        XOR     A
J2959:  LD      (HL),A
        INC     HL
        DJNZ    J2959
        JR      J2985

J295F:  POP     HL
        POP     BC
        LD      A,B
        JR      J2973

J2964:  LD      A,(DECCNT+1)
        LD      E,A
        DEC     A
        LD      (DECCNT+1),A
        XOR     E
        JP      P,J28F4
        JP      J2E7D                   ; DAC = 0 and quit

J2973:  RRA
        LD      A,C
        JR      C,J297C
        OR      (HL)
        LD      (HL),A
        INC     HL
        JR      J2981

J297C:  ADD     A,A
        ADD     A,A
        ADD     A,A
        ADD     A,A
        LD      (HL),A
J2981:  DEC     B
        JP      NZ,J28F6
J2985:  LD      HL,DAC+8
        LD      DE,HOLD8+63
        LD      B,8
        CALL    C2EFE
        JP      J2883

;       Subroutine      COS function
;       Inputs          ________________________
;       Outputs         ________________________

C2993:  LD      HL,I2D63
        CALL    C2C3B                   ; DAC = DAC * 0.15915494309190
        LD      A,(DAC)
        AND     $7F
        LD      (DAC),A
        LD      HL,I2D23
        CALL    C2C32                   ; DAC = DAC - 0.25
        CALL    C2E8D                   ; NEG DAC
        JR      J29B2

;       Subroutine      SIN function
;       Inputs          ________________________
;       Outputs         ________________________

C29AC:  LD      HL,I2D63
        CALL    C2C3B                   ; DAC = DAC * 0.15915494309190
J29B2:  LD      A,(DAC)
        OR      A
        CALL    M,C2C80
        CALL    C2CCC                   ; push DAC
        CALL    C30CF
        CALL    C2C4D                   ; ARG = DAC
        CALL    C2CE1                   ; pop DAC
        CALL    C268C                   ; DAC - ARG
        LD      A,(DAC)
        CP      $40
        JP      C,J29F5
        LD      A,(DAC+1)
        CP      $25
        JP      C,J29F5
        CP      $75
        JP      NC,J29EC
        CALL    C2C4D                   ; ARG = DAC
        LD      HL,I2D11
        CALL    C2C5C                   ; DAC = 0.5
        CALL    C268C                   ; DAC - ARG
        JP      J29F5

J29EC:  LD      HL,I2D1B
        CALL    C2C50                   ; ARG = 1.0
        CALL    C268C                   ; DAC - ARG
J29F5:  LD      HL,I2DEF
        JP      C2C88                   ; polynomial approximation odd series

;       Subroutine      TAN function
;       Inputs          ________________________
;       Outputs         ________________________

C29FB:  CALL    C2CCC                   ; push DAC
        CALL    C2993                   ; COS DAC
        CALL    C2C6F                   ; exchange DAC with stack
        CALL    C29AC                   ; SIN DAC
        CALL    C2CDC                   ; pop ARG
        LD      A,(ARG)
        OR      A
        JP      NZ,C289F                ; DAC / ARG and quit
        JP      J4067                   ; overflow error

;       Subroutine      ATN function
;       Inputs          ________________________
;       Outputs         ________________________

C2A14:  LD      A,(DAC)
        OR      A                       ; DAC zero ?
        RET     Z                       ; yep, result zero
        CALL    M,C2C80
        CP      $41
        JP      C,C2A3C
        CALL    C2C4D                   ; ARG = DAC
        LD      HL,I2D1B
        CALL    C2C5C                   ; DAC = 1.0
        CALL    C289F                   ; DAC / ARG
        CALL    C2A3C
        CALL    C2C4D                   ; ARG = DAC
        LD      HL,I2D43
        CALL    C2C5C                   ; DAC = 1.5707963267949
        JP      C268C                   ; DAC - ARG

;       Subroutine      __________________________
;       Inputs          ________________________
;       Outputs         ________________________

C2A3C:  LD      HL,I2D4B
        CALL    C2C47                   ; compare DAC with 0.26794919243112
        JP      M,C2A6C
        CALL    C2CCC                   ; push DAC
        LD      HL,I2D53
        CALL    C2C2C                   ; DAC = DAC + 1.7320508075689
        CALL    C2C6F                   ; exchange DAC with stack
        LD      HL,I2D53
        CALL    C2C3B                   ; DAC = DAC * 1.7320508075689
        LD      HL,I2D1B
        CALL    C2C32                   ; DAC = DAC - 1.0
        CALL    C2CDC                   ; pop ARG
        CALL    C289F                   ; DAC / ARG
        CALL    C2A6C
        LD      HL,I2D5B
        JP      C2C2C                   ; DAC = DAC + 0.52359877559830

;       Subroutine      __________________________
;       Inputs          ________________________
;       Outputs         ________________________

C2A6C:  LD      HL,I2E30
        JP      C2C88                   ; polynomial approximation odd series

;       Subroutine      LOG function
;       Inputs          ________________________
;       Outputs         ________________________

C2A72:  CALL    C2E71                   ; get sign DAC
        JP      M,C475A                 ; DAC is negative, illegal function call
        JP      Z,C475A                 ; DAC is zero, illegal function call
        LD      HL,DAC
        LD      A,(HL)
        PUSH    AF
        LD      (HL),$41
        LD      HL,I2D2B
        CALL    C2C47                   ; compare DAC with 3.1622776601684
        JP      M,J2A92
        POP     AF
        INC     A
        PUSH    AF
        LD      HL,DAC
        DEC     (HL)
J2A92:  POP     AF
        LD      (TEMP3),A
        CALL    C2CCC                   ; push DAC
        LD      HL,I2D1B
        CALL    C2C2C                   ; DAC = DAC + 1.0
        CALL    C2C6F                   ; exchange DAC with stack
        LD      HL,I2D1B
        CALL    C2C32                   ; DAC = DAC - 1.0
        CALL    C2CDC                   ; pop ARG
        CALL    C289F                   ; DAC / ARG
        CALL    C2CCC                   ; push DAC
        CALL    C2C38                   ; DAC = DAC^2
        CALL    C2CCC                   ; push DAC
        CALL    C2CCC                   ; push DAC
        LD      HL,I2DC6
        CALL    C2CA3
        CALL    C2C6F                   ; exchange DAC with stack
        LD      HL,I2DA5
        CALL    C2CA3
        CALL    C2CDC                   ; pop ARG
        CALL    C289F                   ; DAC / ARG
        CALL    C2CDC                   ; pop ARG
        CALL    C27E6                   ; DAC * ARG
        LD      HL,I2D33
        CALL    C2C2C                   ; DAC = DAC + 0.86858896380650
        CALL    C2CDC                   ; pop ARG
        CALL    C27E6                   ; DAC * ARG
        CALL    C2CCC                   ; push DAC
        LD      A,(TEMP3)
        SUB     $41
        LD      L,A
        ADD     A,A
        SBC     A,A
        LD      H,A
        CALL    C2FCB                   ; convert to single precision real
        CALL    C3042
        CALL    C2CDC                   ; pop ARG
        CALL    C269A                   ; DAC + ARG
        LD      HL,I2D3B
        JP      C2C3B                   ; DAC = DAC * 2.3025850929940

;       Subroutine      SQR function
;       Inputs          ________________________
;       Outputs         ________________________

C2AFF:  CALL    C2E71                   ; get sign DAC
        RET     Z                       ; DAC is zero, quit (result is zero)
        JP      M,C475A                 ; DAC is negative, illegal function call
        CALL    C2C4D                   ; ARG = DAC
        LD      A,(DAC)
        OR      A
        RRA
        ADC     A,$20
        LD      (ARG),A
        LD      A,(DAC+1)
        OR      A
        RRCA
        OR      A
        RRCA
        AND     $33
        ADD     A,$10
        LD      (ARG+1),A
        LD      A,$7
J2B23:  LD      (TEMP3),A
        CALL    C2CCC                   ; push DAC
        CALL    C2CC7                   ; push ARG
        CALL    C289F                   ; DAC / ARG
        CALL    C2CDC                   ; pop ARG
        CALL    C269A                   ; DAC + ARG
        LD      HL,I2D11
        CALL    C2C3B                   ; DAC = DAC * 0.5
        CALL    C2C4D                   ; ARG = DAC
        CALL    C2CE1                   ; pop DAC
        LD      A,(TEMP3)
        DEC     A
        JR      NZ,J2B23
        JP      C2C59                   ; DAC = ARG

;       Subroutine      EXP function
;       Inputs          ________________________
;       Outputs         ________________________

C2B4A:  LD      HL,I2D09
        CALL    C2C3B                   ; DAC = DAC * 0.43429448190324
        CALL    C2CCC                   ; push DAC
        CALL    C2F8A                   ; convert DAC to integer
        LD      A,L
        RLA
        SBC     A,A
        CP      H
        JR      Z,J2B70
        LD      A,H
        OR      A
        JP      P,J2B6D                 ; overflow error
        CALL    C304F
        CALL    C2CE1                   ; pop DAC
        LD      HL,I2D13
        JP      C2C5C                   ; DAC = 0

J2B6D:  JP      J4067                   ; overflow error

J2B70:  LD      (TEMP3),HL
        CALL    C303A                   ; convert DAC to double real
        CALL    C2C4D                   ; ARG = DAC
        CALL    C2CE1                   ; pop DAC
        CALL    C268C                   ; DAC - ARG
        LD      HL,I2D11
        CALL    C2C47                   ; compare DAC with 0.5
        PUSH    AF
        JR      Z,J2B90
        JR      C,J2B90
        LD      HL,I2D11
        CALL    C2C32                   ; DAC = DAC - 0.5
J2B90:  CALL    C2CCC                   ; push DAC
        LD      HL,I2D8C
        CALL    C2C88                   ; polynomial approximation odd series
        CALL    C2C6F                   ; exchange DAC with stack
        LD      HL,I2D6B
        CALL    C2C9A                   ; polynomial approximation even series
        CALL    C2CDC                   ; pop ARG
        CALL    C2CC7                   ; push ARG
        CALL    C2CCC                   ; push DAC
        CALL    C268C                   ; DAC - ARG
        LD      HL,HOLD8+56
        CALL    C2C67                   ; = DAC
        CALL    C2CDC                   ; pop ARG
        CALL    C2CE1                   ; pop DAC
        CALL    C269A                   ; DAC + ARG
        LD      HL,HOLD8+56
        CALL    C2C50                   ; ARG =
        CALL    C289F                   ; DAC / ARG
        POP     AF
        JR      C,J2BD1
        JR      Z,J2BD1
        LD      HL,I2D2B
        CALL    C2C3B                   ; DAC = DAC * 3.1622776601684
J2BD1:  LD      A,(TEMP3)
        LD      HL,DAC
        LD      C,(HL)
        ADD     A,(HL)
        LD      (HL),A
        XOR     C
        RET     P
        JP      J4067                   ; overflow error

;       Subroutine      RND function
;       Inputs          ________________________
;       Outputs         ________________________

C2BDF:  CALL    C2E71                   ; get sign DAC
        LD      HL,RNDX
        JR      Z,J2C15                 ; DAC is zero, use current RNDX value
        CALL    M,C2C67                 ; DAC is negative, RNDX = DAC
        LD      HL,HOLD8+56
        LD      DE,RNDX
        CALL    C2C6A                   ; = RNDX
        LD      HL,I2CF9
        CALL    C2C50                   ; ARG = 0.21132486540519
        LD      HL,I2CF1
        CALL    C2C5C                   ; DAC = 0.14389820420821
        LD      DE,HOLD8+63
        CALL    C282E
        LD      DE,DAC+8
        LD      HL,RNDX+1
        LD      B,7
        CALL    C2EF7                   ; copy mantissa to RNDX
        LD      HL,RNDX+0
        LD      (HL),0
J2C15:  CALL    C2C5C                   ; DAC = RNDX
        LD      HL,DAC
        LD      (HL),$40                ; in 0-1 range
        XOR     A
        LD      (DAC+8),A
        JP      C26FA                   ; normalize DAC

;       Subroutine      initialize RNDX
;       Inputs          ________________________
;       Outputs         ________________________

C2C24:  LD      DE,I2D01
        LD      HL,RNDX
        JR      C2C6A                   ; RNDX = 0.40649651372358 and quit

;       Subroutine      DAC = DAC + operand
;       Inputs          HL = pointer to operand
;       Outputs         ________________________

C2C2C:  CALL    C2C50                   ; ARG =
        JP      C269A                   ; DAC + ARG

;       Subroutine      DAC = DAC - operand
;       Inputs          HL = pointer to operand
;       Outputs         ________________________

C2C32:  CALL    C2C50                   ; ARG =
        JP      C268C                   ; DAC - ARG

;       Subroutine      DAC = DAC^2
;       Inputs          ________________________
;       Outputs         ________________________

C2C38:  LD      HL,DAC

;       Subroutine      DAC = DAC * operand
;       Inputs          HL = pointer to operand
;       Outputs         ________________________

C2C3B:  CALL    C2C50                   ; ARG =
        JP      C27E6                   ; DAC * ARG and quit

;       Subroutine      DAC = DAC / operand
;       Inputs          HL = pointer to operand
;       Outputs         ________________________
;       Remark          Unused Code
;                       Not called from anywhere, leftover from a early Microsoft BASIC

N2C41:  CALL    C2C50                   ; ARG =
        JP      C289F                   ; DAC / ARG and quit

;       Subroutine      compare with DAC
;       Inputs          HL = pointer to operand
;       Outputs         ________________________


C2C47:  CALL    C2C50                   ; ARG =
        JP      C2F5C                   ; compare double real

;       Subroutine      MAF (copy DAC to ARG)
;       Inputs          ________________________
;       Outputs         ________________________

C2C4D:  LD      HL,DAC

;       Subroutine      MAM (copy HL to ARG)
;       Inputs          ________________________
;       Outputs         ________________________

C2C50:  LD      DE,ARG

;       Subroutine      MOV$8D (copy HL to DE)
;       Inputs          ________________________
;       Outputs         ________________________

J2C53:  EX      DE,HL
        CALL    C2C6A                   ; copy
        EX      DE,HL
        RET

;       Subroutine      MFA (copy ARG to DAC)
;       Inputs          ________________________
;       Outputs         ________________________

C2C59:  LD      HL,ARG

;       Subroutine      MFM (copy HL to DAC)
;       Inputs          ________________________
;       Outputs         ________________________

C2C5C:  LD      DE,DAC
        JR      J2C53

;       Subroutine      initialize RNDX
;       Inputs          HL = value
;       Outputs         ________________________
;       Remark          Unused Code
;                       Not called from anywhere, leftover from a early Microsoft BASIC

N2C61:  CALL    C2FCB                   ; convert to single precision real
        LD      HL,RNDX

;       Subroutine      MMF (copy DAC to HL)
;       Inputs          ________________________
;       Outputs         ________________________

C2C67:  LD      DE,DAC

;       Subroutine      MOV8HD
;       Inputs          ________________________
;       Outputs         ________________________

C2C6A:  LD      B,8
        JP      C2EF7

;       Subroutine      XTF (exchange DAC with stack)
;       Inputs          ________________________
;       Outputs         ________________________

C2C6F:  POP     HL
        LD      (FBUFFR),HL
        CALL    C2CDC                   ; pop ARG
        CALL    C2CCC                   ; push DAC
        CALL    C2C59                   ; DAC = ARG
        LD      HL,(FBUFFR)
        JP      (HL)

;       Subroutine      __________________________
;       Inputs          ________________________
;       Outputs         ________________________

C2C80:  CALL    C2E8D                   ; NEG DAC
        LD      HL,C2E8D
        EX      (SP),HL                 ; NEG DAC afterwards
        JP      (HL)

;       Subroutine      polynomial approximation odd series
;       Inputs          ________________________
;       Outputs         ________________________

C2C88:  LD      (FBUFFR),HL
        CALL    C2CCC                   ; push DAC
        LD      HL,(FBUFFR)
        CALL    C2C9A                   ; polynomial approximation even series
        CALL    C2CDC                   ; pop ARG
        JP      C27E6                   ; DAC * ARG and quit

;       Subroutine      polynomial approximation even series
;       Inputs          ________________________
;       Outputs         ________________________

C2C9A:  LD      (FBUFFR),HL
        CALL    C2C38                   ; DAC = DAC^2
        LD      HL,(FBUFFR)


;       Subroutine      __________________________
;       Inputs          ________________________
;       Outputs         ________________________


C2CA3:  LD      A,(HL)
        PUSH    AF
        INC     HL
        PUSH    HL
        LD      HL,FBUFFR
        CALL    C2C67                   ; = DAC
        POP     HL
        CALL    C2C5C                   ; DAC =
J2CB1:  POP     AF
        DEC     A
        RET     Z
        PUSH    AF
        PUSH    HL
        LD      HL,FBUFFR
        CALL    C2C3B                   ; DAC = DAC * .
        POP     HL
        CALL    C2C50                   ; ARG =
        PUSH    HL
        CALL    C269A                   ; DAC + ARG
        POP     HL
        JR      J2CB1

;       Subroutine      PHA (push ARG on stack)
;       Inputs          ________________________
;       Outputs         ________________________

C2CC7:  LD      HL,ARG+7
        JR      J2CCF

;       Subroutine      PHF (push DAC on stack)
;       Inputs          ________________________
;       Outputs         ________________________

C2CCC:  LD      HL,DAC+7
J2CCF:  LD      A,4
        POP     DE
J2CD2:  LD      B,(HL)
        DEC     HL
        LD      C,(HL)
        DEC     HL
        PUSH    BC
        DEC     A
        JR      NZ,J2CD2
        EX      DE,HL
        JP      (HL)

;       Subroutine      PPA (pop ARG from stack)
;       Inputs          ________________________
;       Outputs         ________________________

C2CDC:  LD      HL,ARG
        JR      J2CE4

;       Subroutine      PPF (pop DAC from stack)
;       Inputs          ________________________
;       Outputs         ________________________

C2CE1:  LD      HL,DAC
J2CE4:  LD      A,4
        POP     DE
J2CE7:  POP     BC
        LD      (HL),C
        INC     HL
        LD      (HL),B
        INC     HL
        DEC     A
        JR      NZ,J2CE7
        EX      DE,HL
        JP      (HL)

I2CF1:  DEFB    $00,$14,$38,$98,$20,$42,$08,$21         ; 0.14389820420821
I2CF9:  DEFB    $00,$21,$13,$24,$86,$54,$05,$19         ; 0.21132486540519
I2D01:  DEFB    $00,$40,$64,$96,$51,$37,$23,$58         ; 0.40649651372358
I2D09:  DEFB    $40,$43,$42,$94,$48,$19,$03,$24         ; 0.43429448190324
I2D11:  DEFB    $40,$50                                       ; 0.5
I2D13:  DEFB    $00,$00,$00,$00,$00,$00,$00,$00         ; 0.0
I2D1B:  DEFB    $41,$10,$00,$00,$00,$00,$00,$00         ; 1.0
I2D23:  DEFB    $40,$25,$00,$00,$00,$00,$00,$00         ; 0.25
I2D2B:  DEFB    $41,$31,$62,$27,$76,$60,$16,$84         ; 3.1622776601684
I2D33:  DEFB    $40,$86,$85,$88,$96,$38,$06,$50         ; 0.86858896380650
I2D3B:  DEFB    $41,$23,$02,$58,$50,$92,$99,$40         ; 2.3025850929940
I2D43:  DEFB    $41,$15,$70,$79,$63,$26,$79,$49         ; 1.5707963267949
I2D4B:  DEFB    $40,$26,$79,$49,$19,$24,$31,$12         ; 0.26794919243112
I2D53:  DEFB    $41,$17,$32,$05,$08,$07,$56,$89         ; 1.7320508075689
I2D5B:  DEFB    $40,$52,$35,$98,$77,$55,$98,$30         ; 0.52359877559830
I2D63:  DEFB    $40,$15,$91,$54,$94,$30,$91,$90         ; 0.15915494309190
I2D6B:  DEFB    4
        DEFB    $41,$10,$00,$00,$00,$00,$00,$00         ; 1.0
        DEFB    $43,$15,$93,$74,$15,$23,$60,$31         ; 159.37415236031
        DEFB    $44,$27,$09,$31,$69,$40,$85,$16         ; 2709.3169408516
        DEFB    $44,$44,$97,$63,$35,$57,$40,$58         ; 4497.6335574058
I2D8C:  DEFB    3
        DEFB    $42,$18,$31,$23,$60,$15,$92,$75         ; 18.312360159275
        DEFB    $43,$83,$14,$06,$72,$12,$93,$71         ; 831.40672129371
        DEFB    $44,$51,$78,$09,$19,$91,$51,$62         ; 5178.0919915162
I2DA5:  DEFB    4
        DEFB    $C0,$71,$43,$33,$82,$15,$32,$26         ; -0.71433382153226
        DEFB    $41,$62,$50,$36,$51,$12,$79,$08         ; 6.2503651127908
        DEFB    $C2,$13,$68,$23,$70,$24,$15,$03         ; -13.682370241503
        DEFB    $41,$85,$16,$73,$19,$87,$23,$89         ; 8.5167319872389
I2DC6:  DEFB    5
        DEFB    $41,$10,$00,$00,$00,$00,$00,$00         ; 1.0
        DEFB    $C2,$13,$21,$04,$78,$35,$01,$56         ; -13.210478350156
        DEFB    $42,$47,$92,$52,$56,$04,$38,$73         ; 47.925256043873
        DEFB    $C2,$64,$90,$66,$82,$74,$09,$43         ; -64.906682740943
        DEFB    $42,$29,$41,$57,$50,$17,$23,$23         ; 29.415750172323
I2DEF:  DEFB    8
        DEFB    $C0,$69,$21,$56,$92,$29,$18,$09         ; -0.69215692291809
        DEFB    $41,$38,$17,$28,$86,$38,$57,$71         ; 3.8172886385771
        DEFB    $C2,$15,$09,$44,$99,$47,$48,$01         ; -15.094499474801
        DEFB    $42,$42,$05,$86,$89,$66,$73,$55         ; 42.058689667355
        DEFB    $C2,$76,$70,$58,$59,$68,$32,$91         ; -76.705859683291
        DEFB    $42,$81,$60,$52,$49,$27,$55,$13         ; 81.605249275513
        DEFB    $C2,$41,$34,$17,$02,$24,$03,$98         ; -41.341702240398
        DEFB    $41,$62,$83,$18,$53,$07,$17,$96         ; 6.2831853071796
I2E30:  DEFB    8
        DEFB    $BF,$52,$08,$69,$39,$04,$00,$00         ; -0.05208693904000
        DEFB    $3F,$75,$30,$71,$49,$13,$48,$00         ; 0.07530714913480
        DEFB    $BF,$90,$81,$34,$32,$24,$70,$50         ; -0.09081343224705
        DEFB    $40,$11,$11,$07,$94,$18,$40,$29         ; 0.11110794184029
        DEFB    $C0,$14,$28,$57,$08,$55,$48,$84         ; -0.14285708554884
        DEFB    $40,$19,$99,$99,$99,$94,$89,$67         ; 0.19999999948967
        DEFB    $C0,$33,$33,$33,$33,$33,$31,$60         ; -0.33333333333160
        DEFB    $41,$10,$00,$00,$00,$00,$00,$00         ; 1.0

;       Subroutine      SIGN
;       Inputs          ________________________
;       Outputs         Zx set and A = $00 if zero, Zx reset and Cx set and A = $FF if negative, Zx reset and Cx reset and A = $01 if postive

C2E71:  LD      A,(DAC+0)
        OR      A
        RET     Z
        DEFB    $FE            ; CP xx, skip next instruction
J2E77:  CPL
J2E78:  RLA
J2E79:  SBC     A,A
        RET     NZ
        INC     A
        RET

;       Subroutine      DAC zero
;       Inputs          ________________________
;       Outputs         ________________________

J2E7D:  XOR     A
        LD      (DAC+0),A
        RET

;       Subroutine      ABS function
;       Inputs          ________________________
;       Outputs         ________________________

C2E82:  CALL    C2EA1                   ; get sign DAC
        RET     P                       ; already postive, quit

;       Subroutine      negate
;       Inputs          ________________________
;       Outputs         ________________________

C2E86:  RST     GETYPR                  ; get DAC type
        JP      M,J322B                 ; integer,
        JP      Z,J406D                 ; string, type mismatch error

;       Subroutine      NEG (for single and double real)
;       Inputs          ________________________
;       Outputs         ________________________

C2E8D:  LD      HL,DAC
        LD      A,(HL)
        OR      A                       ; exponent zero ?
        RET     Z                       ; yep, quit
        XOR     $80
        LD      (HL),A                  ; negate sign bit
        RET

;       Subroutine      SGN function
;       Inputs          ________________________
;       Outputs         ________________________

C2E97:  CALL    C2EA1                   ; get sign DAC

;       Subroutine      __________________________
;       Inputs          ________________________
;       Outputs         ________________________

C2E9A:  LD      L,A
        RLA
        SBC     A,A
        LD      H,A
        JP      C2F99                   ; put HL in DAC

;       Subroutine      get sign DAC
;       Inputs          ________________________
;       Outputs         ________________________

C2EA1:  RST     GETYPR                  ; get DAC type
        JP      Z,J406D                 ; string, type mismatch error
        JP      P,C2E71                 ; single or double real, get sign DAC and quit
        LD      HL,(DAC+2)              ; integer value

;       Subroutine      get sign of integer
;       Inputs          ________________________
;       Outputs         ________________________

C2EAB:  LD      A,H
        OR      L                       ; integer 0 ?
        RET     Z                       ; yep, quit
        LD      A,H
        JR      J2E78                   ; sign in A

;       Subroutine      PUSHF (push DAC on stack, single real)
;       Inputs          ________________________
;       Outputs         ________________________

C2EB1:  EX      DE,HL
        LD      HL,(DAC+2)
        EX      (SP),HL
        PUSH    HL
        LD      HL,(DAC+0)
        EX      (SP),HL
        PUSH    HL
        EX      DE,HL
        RET

;       Subroutine      MOVFM (DAC =)
;       Inputs          HL = address
;       Outputs         ________________________

C2EBE:  CALL    C2EDF                   ; load from HL (single)

;       Subroutine      MOVFR (DAC =)
;       Inputs          DEBC = single
;       Outputs         ________________________

C2EC1:  EX      DE,HL
        LD      (DAC+2),HL
        LD      H,B
        LD      L,C
        LD      (DAC+0),HL
        EX      DE,HL
        RET

;       Subroutine      MOVRF (= DAC)
;       Inputs          none
;       Outputs         DEBC = single

C2ECC:  LD      HL,(DAC+2)
        EX      DE,HL
        LD      HL,(DAC+0)
        LD      C,L
        LD      B,H
        RET

;       Subroutine      MOVRMI
;       Inputs          HL = address
;       Outputs         DEBC =

C2ED6:  LD      C,(HL)
        INC     HL
        LD      B,(HL)
        INC     HL
        LD      E,(HL)
        INC     HL
        LD      D,(HL)
        INC     HL
        RET

;       Subroutine      MOVRM
;       Inputs          HL = address
;       Outputs         BCDE =

C2EDF:  LD      E,(HL)
        INC     HL

;       Subroutine      get size and address of string
;       Inputs          HL = pointer to stringdescriptor
;       Outputs         D = size of string, BC = address of string

C2EE1:  LD      D,(HL)
        INC     HL
        LD      C,(HL)
        INC     HL
        LD      B,(HL)

;       Subroutine      __________________________
;       Inputs          ________________________
;       Outputs         ________________________

C2EE6:  INC     HL
        RET

;       Subroutine      MOVMF (DAC =)
;       Inputs          ________________________
;       Outputs         ________________________


C2EE8:  LD      DE,DAC

;       Subroutine      MOVE ( =)
;       Inputs          ________________________
;       Outputs         ________________________


C2EEB:  LD      B,4
        JR      C2EF7

;       Subroutine      VMOVAM (ARG =)
;       Inputs          ________________________
;       Outputs         ________________________


C2EEF:  LD      DE,ARG

;       Subroutine      MOVVFM (DE = HL)
;       Inputs          ________________________
;       Outputs         ________________________

C2EF2:  EX      DE,HL

;       Subroutine      VMOVE (copy variable content)
;       Inputs          HL = source variable pointer, DE = destination variable pointer, (VALTYP) = variabletype
;       Outputs         ________________________

C2EF3:  LD      A,(VALTYP)
        LD      B,A

;       Subroutine      __________________________
;       Inputs          ________________________
;       Outputs         ________________________

C2EF7:  LD      A,(DE)
        LD      (HL),A
        INC     DE
        INC     HL
        DJNZ    C2EF7
        RET


;       Subroutine      __________________________
;       Inputs          ________________________
;       Outputs         ________________________


C2EFE:  LD      A,(DE)
        LD      (HL),A
        DEC     DE
        DEC     HL
        DJNZ    C2EFE
        RET

;       Subroutine      VMOVFA (DAC = ARG)
;       Inputs          _______________________
;       Outputs         ________________________


C2F05:  LD      HL,ARG

;       Subroutine      VMOVFM (DAC = HL)
;       Inputs          _______________________
;       Outputs         ________________________

C2F08:  LD      DE,C2EF2                ; afterwards DE = HL
        JR      J2F13                   ; load DAC address

;       Subroutine      VMOVAF (ARG = DAC)
;       Inputs          ________________________
;       Outputs         ________________________


C2F0D:  LD      HL,ARG

;       Subroutine      VMOVMF (HL = DAC)
;       Inputs          ________________________
;       Outputs         ________________________


C2F10:  LD      DE,C2EF3                ; afterwards HL = DE
J2F13:  PUSH    DE
        LD      DE,DAC+0
        LD      A,(VALTYP)
        CP      4
        RET     NC
        LD      DE,DAC+2
        RET

;       Subroutine      FCOMP (single real compare)
;       Inputs          DEBC = first operand, (DAC) = second operand
;       Outputs         ________________________

C2F21:  LD      A,C
        OR      A
        JP      Z,C2E71                 ; get sign DAC and quit
        LD      HL,J2E77
        PUSH    HL
        CALL    C2E71                   ; get sign DAC
        LD      A,C
        RET     Z                       ; DAC is zero,
        LD      HL,DAC
        XOR     (HL)
        LD      A,C
        RET     M
        CALL    C2F3B
        RRA
        XOR     C
        RET


;       Subroutine      __________________________
;       Inputs          ________________________
;       Outputs         ________________________


C2F3B:  LD      A,C
        CP      (HL)
        RET     NZ
        INC     HL
        LD      A,B
        CP      (HL)
        RET     NZ
        INC     HL
        LD      A,E
        CP      (HL)
        RET     NZ
        INC     HL
        LD      A,D
        SUB     (HL)
        RET     NZ
        POP     HL
        POP     HL
        RET

;       Subroutine      ICOMP (compare integer)
;       Inputs          ________________________
;       Outputs         ________________________

C2F4D:  LD      A,D
        XOR     H                       ; sign equal ?
        LD      A,H
        JP      M,J2E78                 ; nope, sign in A
        CP      D                       ; high byte equal ?
        JR      NZ,J2F59                ; nope,
        LD      A,L
        SUB     E
        RET     Z
J2F59:  JP      J2E79

;       Subroutine      XDCOMP (compare double real)
;       Inputs          ________________________
;       Outputs         ________________________

C2F5C:  LD      DE,ARG
        LD      A,(DE)
        OR      A
        JP      Z,C2E71                 ; get sign DAC and quit
        LD      HL,J2E77
        PUSH    HL
        CALL    C2E71                   ; get sign DAC
        LD      A,(DE)
        LD      C,A
        RET     Z                       ; DAC is zero,
        LD      HL,DAC
        XOR     (HL)
        LD      A,C
        RET     M
        LD      B,8
J2F76:  LD      A,(DE)
        SUB     (HL)
        JR      NZ,J2F80
        INC     DE
        INC     HL
D2F7C:  DJNZ    J2F76
        POP     BC
        RET

J2F80:  RRA
        XOR     C
        RET

C2F83:  CALL    C2F5C                   ; compare double real
        JP      NZ,J2E77
        RET

;       Subroutine      FRCINT (convert DAC to integer), also CINT function
;       Inputs          ________________________
;       Outputs         ________________________

C2F8A:  RST     GETYPR                  ; get DAC type
        LD      HL,(DAC+2)
        RET     M                       ; already integer, quit
        JP      Z,J406D                 ; string, type mismatch error

;       Subroutine      convert single real or double real to integer
;       Inputs          ________________________
;       Outputs         ________________________

C2F92:  CALL    C305D
        JP      C,J4067                 ; overflow error
        EX      DE,HL


;       Subroutine      __________________________
;       Inputs          ________________________
;       Outputs         ________________________


C2F99:  LD      (DAC+2),HL


;       Subroutine      __________________________
;       Inputs          ________________________
;       Outputs         ________________________


C2F9C:  LD      A,2
J2F9E:  LD      (VALTYP),A
        RET


;       Subroutine      __________________________
;       Inputs          ________________________
;       Outputs         ________________________


C2FA2:  LD      BC,$32C5
        LD      DE,$8076
        CALL    C2F21                   ; single real compare
        RET     NZ                      ; not -32768 SGN, quit
        LD      HL,$8000               ; -32768 INT
J2FAF:  POP     DE                      ; remove return address
        JR      C2F99                   ; put HL in DAC

;       Subroutine      FRCSNG (convert DAC to single real), also CSNG function
;       Inputs          ________________________
;       Outputs         ________________________

C2FB2:  RST     GETYPR                  ; get DAC type
        RET     PO                      ; already single real, quit
        JP      M,C2FC8                 ; integer, convert integer to single real
        JP      Z,J406D                 ; string, type mismatch
        CALL    C3053
        CALL    C3752
        INC     HL
        LD      A,B
        OR      A
        RRA
        LD      B,A
        JP      C2741

;       Subroutine      __________________________
;       Inputs          ________________________
;       Outputs         ________________________

C2FC8:  LD      HL,(DAC+2)

;       Subroutine      convert to single precision real
;       Inputs          HL = integer value
;       Outputs         ________________________

C2FCB:  LD      A,H
J2FCC:  OR      A
        PUSH    AF
        CALL    M,C3221
        CALL    C3053
        EX      DE,HL
        LD      HL,0
        LD      (DAC+0),HL
        LD      (DAC+2),HL
        LD      A,D
        OR      E
        JP      Z,J66A7
        LD      BC,$0500
        LD      HL,DAC+1
        PUSH    HL
        LD      HL,J3030
J2FED:  LD      A,$FF
        PUSH    DE
        LD      E,(HL)
        INC     HL
        LD      D,(HL)
        INC     HL
        EX      (SP),HL
        PUSH    BC
J2FF6:  LD      B,H
        LD      C,L
        ADD     HL,DE
        INC     A
        JR      C,J2FF6
        LD      H,B
        LD      L,C
        POP     BC
        POP     DE
        EX      DE,HL
        INC     C
        DEC     C
        JR      NZ,J3010
        OR      A
        JR      Z,J3024
        PUSH    AF
        LD      A,$40
        ADD     A,B
        LD      (DAC),A
        POP     AF
J3010:  INC     C
        EX      (SP),HL
        PUSH    AF
        LD      A,C
        RRA
        JR      NC,J301F
        POP     AF
        ADD     A,A
        ADD     A,A
        ADD     A,A
        ADD     A,A
        LD      (HL),A
        JR      J3023

J301F:  POP     AF
        OR      (HL)
        LD      (HL),A
        INC     HL
J3023:  EX      (SP),HL
J3024:  LD      A,D
        OR      E
        JR      Z,J302A
        DJNZ    J2FED
J302A:  POP     HL
        POP     AF
        RET     P
        JP      C2E8D                   ; NEG DAC

J3030:  DEFW    -10000
        DEFW    -1000
        DEFW    -100
        DEFW    -10
        DEFW    -1

;       Subroutine      FRCDBL (convert DAC to double real), also CDBL function
;       Inputs          ________________________
;       Outputs         ________________________

C303A:  RST     GETYPR                  ; get DAC type
        RET     NC                      ; already double real, quit
        JP      Z,J406D                 ; string, type mismatch error
        CALL    M,C2FC8                 ; integer, convert to single real

;       Subroutine      __________________________
;       Inputs          ________________________
;       Outputs         ________________________

C3042:  LD      HL,0
        LD      (DAC+4),HL
        LD      (DAC+6),HL
        LD      A,H
        LD      (DAC+8),A

;       Subroutine      __________________________
;       Inputs          ________________________
;       Outputs         ________________________

C304F:  LD      A,8
        JR      J3055

;       Subroutine      __________________________
;       Inputs          ________________________
;       Outputs         ________________________


C3053:  LD      A,4
J3055:  JP      J2F9E


;       Subroutine      check if string
;       Inputs          ________________________
;       Outputs         ________________________

C3058:  RST     GETYPR                  ; get DAC type
        RET     Z                       ; already string, quit
        JP      J406D                   ; not a string, type mismatch error

;       Subroutine      convert SGN/DBL to signed integer
;       Inputs          ________________________
;       Outputs         ________________________

C305D:  LD      HL,I30BA
        PUSH    HL
        LD      HL,DAC
        LD      A,(HL)
        AND     $7F
        CP      $46
        RET     NC
        SUB     $41
        JR      NC,J3074
        OR      A
        POP     DE
        LD      DE,0
        RET

J3074:  INC     A
        LD      B,A
        LD      DE,0
        LD      C,D
        INC     HL
J307B:  LD      A,C
        INC     C
        RRA
        LD      A,(HL)
        JR      C,J3087
        RRA
        RRA
        RRA
        RRA
        JR      J3088

J3087:  INC     HL
J3088:  AND     $F
        LD      (DECTMP),HL
        LD      H,D
        LD      L,E
        ADD     HL,HL
        RET     C
        ADD     HL,HL
        RET     C
        ADD     HL,DE
        RET     C
        ADD     HL,HL
        RET     C
        LD      E,A
        LD      D,$0
        ADD     HL,DE
        RET     C
        EX      DE,HL
        LD      HL,(DECTMP)
        DJNZ    J307B
        LD      HL,$8000
        RST     DCOMPR
        LD      A,(DAC)
        RET     C
        JR      Z,J30B6
        POP     HL
        OR      A
        RET     P
        EX      DE,HL
        CALL    C3221
        EX      DE,HL
        OR      A
        RET

J30B6:  OR      A
        RET     P
        POP     HL
        RET

I30BA:  SCF
        RET

;       Unused Code
;       Not called from anywhere, leftover from a early Microsoft BASIC

N30BC:  DEC     BC
        RET

;       Subroutine      FIXER (round DAC), also FIX function
;       Inputs          ________________________
;       Outputs         ________________________

C30BE:  RST     GETYPR                  ; get DAC type
        RET     M                       ; integer, quit doing nothing
        CALL    C2E71                   ; get sign DAC
        JP      P,C30CF                 ; DAC is postive, just do a INT
        CALL    C2E8D                   ; NEG DAC
        CALL    C30CF                   ; do INT
        JP      C2E86                   ; negate

;       Subroutine      INT function
;       Inputs          ________________________
;       Outputs         ________________________

C30CF:  RST     GETYPR                  ; get DAC type
        RET     M                       ; integer, quit doing nothing
        LD      HL,DAC+8
        LD      C,14
        JR      NC,J30E0                ; double real,
        JP      Z,J406D                 ; string, type mismatch error
        LD      HL,DAC+4
        LD      C,6
J30E0:  LD      A,(DAC)
        OR      A
        JP      M,J3100
        AND     $7F
        SUB     $41
        JP      C,J2E7D                 ; DAC = 0 and quit
        INC     A
        SUB     C
        RET     NC
        CPL
        INC     A
        LD      B,A
J30F4:  DEC     HL
        LD      A,(HL)
        AND     $F0
        LD      (HL),A
        DEC     B
        RET     Z
        XOR     A
        LD      (HL),A
        DJNZ    J30F4
        RET

J3100:  AND     $7F
        SUB     $41
        JR      NC,J310C
        LD      HL,-1
        JP      C2F99                   ; put HL in DAC

J310C:  INC     A
        SUB     C
        RET     NC
        CPL
        INC     A
        LD      B,A
        LD      E,$0
J3114:  DEC     HL
        LD      A,(HL)
        LD      D,A
        AND     $F0
        LD      (HL),A
        CP      D
        JR      Z,J311E
        INC     E
J311E:  DEC     B
        JR      Z,J3129
        XOR     A
        LD      (HL),A
        CP      D
        JR      Z,J3127
        INC     E
J3127:  DJNZ    J3114
J3129:  INC     E
        DEC     E
        RET     Z
        LD      A,C
        CP      $6
        LD      BC,$10C1
        LD      DE,0
        JP      Z,C324E                 ; single real addition
        EX      DE,HL
        LD      (ARG+6),HL
        LD      (ARG+4),HL
        LD      (ARG+2),HL
        LD      H,B
        LD      L,C
        LD      (ARG),HL
        JP      C269A                   ; DAC + ARG

;       Subroutine      UMULT (unsigned integer multiply)
;       Inputs          ________________________
;       Outputs         ________________________

C314A:  PUSH    HL
        LD      HL,0
        LD      A,B
        OR      C
        JR      Z,J3164
        LD      A,16
J3154:  ADD     HL,HL
        JP      C,J601D                 ; subscript out of range
        EX      DE,HL
        ADD     HL,HL
        EX      DE,HL
        JR      NC,J3161
        ADD     HL,BC
        JP      C,J601D                 ; subscript out of range
J3161:  DEC     A
        JR      NZ,J3154
J3164:  EX      DE,HL
        POP     HL
        RET

;       Subroutine      ISUB (subtract integer)
;       Inputs          ________________________
;       Outputs         ________________________

C3167:  LD      A,H
        RLA
        SBC     A,A
        LD      B,A
        CALL    C3221
        LD      A,C
        SBC     A,B
        JR      J3175

;       Subroutine      IADD (add integer)
;       Inputs          ________________________
;       Outputs         ________________________

C3172:  LD      A,H
        RLA
        SBC     A,A
J3175:  LD      B,A
        PUSH    HL
        LD      A,D
        RLA
        SBC     A,A
        ADD     HL,DE
        ADC     A,B
        RRCA
        XOR     H
        JP      P,J2FAF
        PUSH    BC
        EX      DE,HL
        CALL    C2FCB                   ; convert to single precision real
        POP     AF
        POP     HL
        CALL    C2EB1                   ; push DAC (single)
        CALL    C2FCB                   ; convert to single precision real
        POP     BC
        POP     DE
        JP      C324E                   ; single real addition

;       Subroutine      IMULT (multiply integer)
;       Inputs          ________________________
;       Outputs         ________________________

C3193:  LD      A,H
        OR      L
        JP      Z,C2F99                 ; put HL in DAC
        PUSH    HL
        PUSH    DE
        CALL    C3215
        PUSH    BC
        LD      B,H
        LD      C,L
        LD      HL,0
        LD      A,16
J31A5:  ADD     HL,HL
        JR      C,J31C7
        EX      DE,HL
        ADD     HL,HL
        EX      DE,HL
        JR      NC,J31B0
        ADD     HL,BC
        JR      C,J31C7
J31B0:  DEC     A
        JR      NZ,J31A5
        POP     BC
        POP     DE
J31B5:  LD      A,H
        OR      A
        JP      M,J31BF
        POP     DE
        LD      A,B
        JP      J321D

J31BF:  XOR     $80
        OR      L
        JR      Z,J31D8
        EX      DE,HL
        JR      J31C9

J31C7:  POP     BC
        POP     HL
J31C9:  CALL    C2FCB                   ; convert to single precision real
        POP     HL
        CALL    C2EB1                   ; push DAC (single)
        CALL    C2FCB                   ; convert to single precision real
        POP     BC
        POP     DE
        JP      C325C                   ; single real muliply

J31D8:  LD      A,B
        OR      A
        POP     BC
        JP      M,C2F99                 ; put HL in DAC
        PUSH    DE
        CALL    C2FCB                   ; convert to single precision real
        POP     DE
        JP      C2E8D                   ; NEG DAC

;       Subroutine      IDIV (integer divide)
;       Inputs          ________________________
;       Outputs         ________________________

C31E6:  LD      A,H
        OR      L
        JP      Z,J4058
        CALL    C3215
        PUSH    BC
        EX      DE,HL
        CALL    C3221
        LD      B,H
        LD      C,L
        LD      HL,0
        LD      A,17
        OR      A
        JR      J3206

J31FD:  PUSH    HL
        ADD     HL,BC
        JR      NC,J3205
        INC     SP
        INC     SP
        SCF
        DEFB    $30                    ; skip next instruction
J3205:  POP     HL
J3206:  RL      E
        RL      D
        ADC     HL,HL
        DEC     A
        JR      NZ,J31FD
        EX      DE,HL
        POP     BC
        PUSH    DE
        JP      J31B5

;       Subroutine      __________________________
;       Inputs          ________________________
;       Outputs         ________________________

C3215:  LD      A,H
        XOR     D
        LD      B,A
        CALL    C321C
        EX      DE,HL

;       Subroutine      __________________________
;       Inputs          ________________________
;       Outputs         ________________________

C321C:  LD      A,H
J321D:  OR      A
        JP      P,C2F99                 ; put HL in DAC

;       Subroutine      __________________________
;       Inputs          ________________________
;       Outputs         ________________________

C3221:  XOR     A
        LD      C,A
        SUB     L
        LD      L,A
        LD      A,C
        SBC     A,H
        LD      H,A
        JP      C2F99                   ; put HL in DAC

J322B:  LD      HL,(DAC+2)
        CALL    C3221
        LD      A,H
        XOR     $80
        OR      L
        RET     NZ

;       Subroutine      convert unsigned integer to single real
;       Inputs          ________________________
;       Outputs         ________________________

C3236:  XOR     A
        JP      J2FCC

;       Subroutine      IMOD (integer mod)
;       Inputs          ________________________
;       Outputs         ________________________

C323A:  PUSH    DE
        CALL    C31E6                   ; integer divide
        XOR     A
        ADD     A,D
        RRA
        LD      H,A
        LD      A,E
        RRA
        LD      L,A
        CALL    C2F9C
        POP     AF
        JR      J321D

;       Unused Code
;       Not called from anywhere, leftover from a early Microsoft BASIC

N324B:  CALL    C2EDF                   ; load from HL (single)

;       Subroutine      single real addition
;       Inputs          ________________________
;       Outputs         ________________________

C324E:  CALL    C3280
        CALL    C3042
        JP      C269A                   ; DAC + ARG

;       Subroutine      single real subtract
;       Inputs          ________________________
;       Outputs         ________________________

C3257:  CALL    C2E8D                   ; NEG DAC
        JR      C324E                   ; single real addition

;       Subroutine      single real muliply
;       Inputs          ________________________
;       Outputs         ________________________

C325C:  CALL    C3280
        CALL    C3042
        JP      C27E6                   ; DAC * ARG and quit

J3265:  POP     BC
        POP     DE

;       Subroutine      single real divide
;       Inputs          ________________________
;       Outputs         ________________________

C3267:  LD      HL,(DAC+2)
        EX      DE,HL
        LD      (DAC+2),HL
        PUSH    BC
        LD      HL,(DAC)
        EX      (SP),HL
        LD      (DAC),HL
        POP     BC
        CALL    C3280
        CALL    C3042
        JP      C289F                   ; DAC / ARG and quit

;       Subroutine      __________________________
;       Inputs          ________________________
;       Outputs         ________________________

C3280:  EX      DE,HL
        LD      (ARG+2),HL
        LD      H,B
        LD      L,C
        LD      (ARG+0),HL
        LD      HL,0
        LD      (ARG+4),HL
        LD      (ARG+6),HL
        RET

;       Subroutine      __________________________
;       Inputs          ________________________
;       Outputs         ________________________

C3293:  DEC     A
        RET

;       Subroutine      __________________________
;       Inputs          ________________________
;       Outputs         ________________________

C3295:  DEC     HL
        RET

J3297:  POP     HL
        RET

;       Subroutine      FIN (convert text to number)
;       Inputs          ________________________
;       Outputs         ________________________

C3299:  EX      DE,HL
        LD      BC,$00FF
        LD      H,B
        LD      L,B
        CALL    C2F99                   ; put HL in DAC
        EX      DE,HL
        LD      A,(HL)
        CP      '&'
        JP      Z,C4EB8                 ; convert text with radix indication to number
        CP      '-'
        PUSH    AF
        JR      Z,J32B3
        CP      '+'
        JR      Z,J32B3
        DEC     HL
J32B3:  RST     CHRGTR                  ; get next BASIC character
        JP      C,J3386
        CP      '.'
        JP      Z,J334F
        CP      'e'
        JR      Z,J32C2
        CP      'E'
J32C2:  JR      NZ,J32DE
        PUSH    HL
        RST     CHRGTR                  ; get next BASIC character
        CP      'l'
        JR      Z,J32D4
        CP      'L'
        JR      Z,J32D4
        CP      'q'
        JR      Z,J32D4
        CP      'Q'
J32D4:  POP     HL
        JR      Z,J32DD
        RST     GETYPR                  ; get DAC type
        JR      NC,J32F5                ; double real,
        XOR     A
        JR      J32F6

J32DD:  LD      A,(HL)
J32DE:  CP      '%'
        JP      Z,J3362
        CP      '#'
        JP      Z,J3370
        CP      '!'
        JP      Z,J3371
        CP      'd'
        JR      Z,J32F5
        CP      'D'
        JR      NZ,J331E
J32F5:  OR      A
J32F6:  CALL    C3377
        RST     CHRGTR                  ; get next BASIC character
        PUSH    DE
        LD      D,$0
        CALL    C4F47
        LD      C,D
        POP     DE
J3302:  RST     CHRGTR                  ; get next BASIC character
        JR      NC,J3318
        LD      A,E
        CP      $C
        JR      NC,J3314
        RLCA
        RLCA
        ADD     A,E
        RLCA
        ADD     A,(HL)
        SUB     $30
        LD      E,A
        JR      J3302

J3314:  LD      E,$80
        JR      J3302

J3318:  INC     C
        JR      NZ,J331E
        XOR     A
        SUB     E
        LD      E,A
J331E:  RST     GETYPR                  ; get DAC type
        JP      M,J3334                 ; integer,
        LD      A,(DAC+0)
        OR      A                       ; DAC zero ?
        JR      Z,J3334                 ; yep,
        LD      A,D
        SUB     B
        ADD     A,E
        ADD     A,$40
        LD      (DAC),A
        OR      A
        CALL    M,C334C                 ; overflow error
J3334:  POP     AF
        PUSH    HL
        CALL    Z,C2E86                 ; negate
        RST     GETYPR                  ; get DAC type
        JR      NC,J3347                ; double real,
        POP     HL
        RET     PE                      ; no single real, quit
        PUSH    HL
        LD      HL,J3297
        PUSH    HL
        CALL    C2FA2
        RET

J3347:  CALL    C273C                   ; round DAC
        POP     HL
        RET

;       Subroutine      __________________________
;       Inputs          ________________________
;       Outputs         ________________________

C334C:  JP      J4067                   ; overflow error

J334F:  RST     GETYPR                  ; get DAC type
        INC     C
        JR      NZ,J331E
        JR      NC,J335F                ; double real,
        CALL    C3377
        LD      A,(DAC)
        OR      A
        JR      NZ,J335F
        LD      D,A
J335F:  JP      J32B3

J3362:  RST     CHRGTR                  ; get next BASIC character
        POP     AF
        PUSH    HL
        LD      HL,J3297
        PUSH    HL
        LD      HL,C2F8A
        PUSH    HL                      ; convert DAC to integer
        PUSH    AF
        JR      J331E

J3370:  OR      A
J3371:  CALL    C3377
        RST     CHRGTR                  ; get next BASIC character
        JR      J331E

;       Subroutine      __________________________
;       Inputs          ________________________
;       Outputs         ________________________

C3377:  PUSH    HL
        PUSH    DE
        PUSH    BC
        PUSH    AF
        CALL    Z,C2FB2                 ; convert DAC to single real
        POP     AF
        CALL    NZ,C303A                ; convert DAC to double real
        POP     BC
        POP     DE
        POP     HL
        RET

J3386:  SUB     $30
        JP      NZ,J3393
        OR      C
        JP      Z,J3393
        AND     D
        JP      Z,J32B3
J3393:  INC     D
        LD      A,D
        CP      $7
        JR      NZ,J339D
        OR      A
        CALL    C3377
J339D:  PUSH    DE
        LD      A,B
        ADD     A,C
        INC     A
        LD      B,A
        PUSH    BC
        PUSH    HL
        LD      A,(HL)
        SUB     $30
        PUSH    AF
        RST     GETYPR                  ; get DAC type
        JP      P,J33D1                 ; not a integer,
        LD      HL,(DAC+2)
        LD      DE,3277
        RST     DCOMPR
        JR      NC,J33CE
        LD      D,H
        LD      E,L
        ADD     HL,HL
        ADD     HL,HL
        ADD     HL,DE
        ADD     HL,HL
        POP     AF
        LD      C,A
        ADD     HL,BC
        LD      A,H
        OR      A
        JP      M,J33CC
        LD      (DAC+2),HL
J33C6:  POP     HL
        POP     BC
        POP     DE
        JP      J32B3

J33CC:  LD      A,C
        PUSH    AF
J33CE:  CALL    C2FC8
J33D1:  POP     AF
        POP     HL
        POP     BC
        POP     DE
        JR      NZ,J33E3
        LD      A,(DAC)
        OR      A
        LD      A,$0
        JR      NZ,J33E3
        LD      D,A
        JP      J32B3

J33E3:  PUSH    DE
        PUSH    BC
        PUSH    HL
        PUSH    AF
        LD      HL,DAC
        LD      (HL),$1
        LD      A,D
        CP      $10
        JR      C,J33F4
        POP     AF
        JR      J33C6

J33F4:  INC     A
        OR      A
        RRA
        LD      B,$0
        LD      C,A
        ADD     HL,BC
        POP     AF
        LD      C,A
        LD      A,D
        RRA
        LD      A,C
        JR      NC,J3406
        ADD     A,A
        ADD     A,A
        ADD     A,A
        ADD     A,A
J3406:  OR      (HL)
        LD      (HL),A
        JR      J33C6

;       Subroutine      "in" number to interpreter output
;       Inputs          ________________________
;       Outputs         ________________________

C340A:  PUSH    HL
        LD      HL,I3FD2
        CALL    C6678                   ; message to interpreter output
        POP     HL

;       Subroutine      number to interpreter output
;       Inputs          ________________________
;       Outputs         ________________________

C3412:  LD      BC,I6677
        PUSH    BC                      ; after this: skip first char, message to interpreter
        CALL    C2F99                   ; put HL in DAC
        XOR     A
        LD      (TEMP3),A
        LD      HL,FBUFFR+1
        LD      (HL),' '
        OR      (HL)
        JR      J3441

;       Subroutine      FOUT (convert DAC to text, unformatted)
;       Inputs          ________________________
;       Outputs         ________________________


C3425:  XOR     A
;       Subroutine      PUFOUT (convert DAC to text, formatted)
;       Inputs          ________________________
;       Outputs         ________________________

C3426:  CALL    C375F
        AND     $8
        JR      Z,J342F
        LD      (HL),'+'
J342F:  EX      DE,HL
        CALL    C2EA1                   ; get sign DAC
        EX      DE,HL
        JP      P,J3441
        LD      (HL),'-'
        PUSH    BC
        PUSH    HL
        CALL    C2E86                   ; negate
        POP     HL
        POP     BC
        OR      H
J3441:  INC     HL
        LD      (HL),$30
        LD      A,(TEMP3)
        LD      D,A
        RLA
        LD      A,(VALTYP)
        JP      C,J34F7
        JP      Z,J34EF
        CP      $4
        JP      NC,J34A1
        LD      BC,0
        CALL    C36DB

;       Subroutine      __________________________
;       Inputs          ________________________
;       Outputs         ________________________

C345D:  LD      HL,FBUFFR+1
        LD      B,(HL)
        LD      C,$20
        LD      A,(TEMP3)
        LD      E,A
        AND     $20
        JR      Z,J3477
        LD      A,B
        CP      C
        LD      C,$2A
        JR      NZ,J3477
        LD      A,E
        AND     $4
        JR      NZ,J3477
        LD      B,C
J3477:  LD      (HL),C
        RST     CHRGTR                  ; get next BASIC character
        JR      Z,J348F
        CP      'E'
        JR      Z,J348F
        CP      'D'
        JR      Z,J348F
        CP      $30
        JR      Z,J3477
        CP      ','
        JR      Z,J3477
        CP      '.'
        JR      NZ,J3492
J348F:  DEC     HL
        LD      (HL),$30
J3492:  LD      A,E
        AND     $10
        JR      Z,J349A
        DEC     HL
        LD      (HL),CHRCUR
J349A:  LD      A,E
        AND     $4
        RET     NZ
        DEC     HL
        LD      (HL),B
        RET

J34A1:  PUSH    HL
        CALL    C3752
        LD      D,B
        INC     D
        LD      BC,$0300
        LD      A,(DAC)
        SUB     $3F
        JR      C,J34B9
        INC     D
        CP      D
        JR      NC,J34B9
        INC     A
        LD      B,A
        LD      A,$2
J34B9:  SUB     $2
        POP     HL
        PUSH    AF
        CALL    C368E
        LD      (HL),$30
        CALL    Z,C2EE6
        CALL    C36B3
J34C8:  DEC     HL
        LD      A,(HL)
        CP      $30
        JR      Z,J34C8
        CP      '.'
        CALL    NZ,C2EE6
        POP     AF
        JR      Z,J34F0

;       Subroutine      __________________________
;       Inputs          ________________________
;       Outputs         ________________________

C34D6:  LD      (HL),'E'
        INC     HL
        LD      (HL),'+'
        JP      P,J34E2
        LD      (HL),'-'
        CPL
        INC     A
J34E2:  LD      B,$2F
J34E4:  INC     B
        SUB     $A
        JR      NC,J34E4
        ADD     A,$3A
        INC     HL
        LD      (HL),B
        INC     HL
        LD      (HL),A
J34EF:  INC     HL
J34F0:  LD      (HL),$0
        EX      DE,HL
        LD      HL,FBUFFR+1
        RET

J34F7:  INC     HL
        PUSH    BC
        CP      $4
        LD      A,D
        JP      NC,J3566
        RRA
        JP      C,J35EF
        LD      BC,$0603
        CALL    C3686
        POP     DE
        LD      A,D
        SUB     $5
        CALL    P,C3666
        CALL    C36DB
J3513:  LD      A,E
        OR      A
        CALL    Z,C3295
        DEC     A
        CALL    P,C3666
J351C:  PUSH    HL
        CALL    C345D
        POP     HL
        JR      Z,J3525
        LD      (HL),B
        INC     HL
J3525:  LD      (HL),$0
        LD      HL,FBUFFR
J352A:  INC     HL
J352B:  LD      A,(TEMP2)
        SUB     L
        SUB     D
        RET     Z
        LD      A,(HL)
        CP      ' '
        JR      Z,J352A
        CP      '*'
        JR      Z,J352A
        DEC     HL
        PUSH    HL
I353C:  PUSH    AF
        LD      BC,I353C
        PUSH    BC
        RST     CHRGTR                  ; get next BASIC character
        CP      '-'
        RET     Z
        CP      '+'
        RET     Z
        CP      CHRCUR
        RET     Z
        POP     BC
        CP      $30
        JR      NZ,J355F
        INC     HL
        RST     CHRGTR                  ; get next BASIC character
        JR      NC,J355F
        DEC     HL
        JR      J3559

J3557:  DEC     HL
        LD      (HL),A
J3559:  POP     AF
        JR      Z,J3557
        POP     BC
        JR      J352B

J355F:  POP     AF
        JR      Z,J355F
        POP     HL
        LD      (HL),'%'
        RET

J3566:  PUSH    HL
        RRA
        JP      C,J35F5
        CALL    C3752
        LD      D,B
        LD      A,(DAC)
        SUB     $4F
        JR      C,J3581
        POP     HL
        POP     BC
        CALL    C3425                   ; convert DAC to text, unformatted
        LD      HL,FBUFFR
        LD      (HL),'%'
        RET

J3581:  CALL    C2E71                   ; get sign DAC
        CALL    NZ,C37A2                ; DAC not zero,
        POP     HL
        POP     BC
        JP      M,J35A6
        PUSH    BC
        LD      E,A
        LD      A,B
        SUB     D
        SUB     E
        CALL    P,C3666
        CALL    C367A
        CALL    C36B3
        OR      E
        CALL    NZ,C3674
        OR      E
        CALL    NZ,C36A0
        POP     DE
        JP      J3513

J35A6:  LD      E,A
        LD      A,C
        OR      A
        CALL    NZ,C3293
        ADD     A,E
        JP      M,J35B1
        XOR     A
J35B1:  PUSH    BC
        PUSH    AF
        CALL    M,C377B
        POP     BC
        LD      A,E
        SUB     B
        POP     BC
        LD      E,A
        ADD     A,D
        LD      A,B
        JP      M,J35CB
        SUB     D
        SUB     E
        CALL    P,C3666
        PUSH    BC
        CALL    C367A
        JR      J35DC

J35CB:  CALL    C3666
        LD      A,C
        CALL    C36A3
        LD      C,A
        XOR     A
        SUB     D
        SUB     E
        CALL    C3666
        PUSH    BC
        LD      B,A
        LD      C,A
J35DC:  CALL    C36B3
        POP     BC
        OR      C
        JR      NZ,J35E6
        LD      HL,(TEMP2)
J35E6:  ADD     A,E
        DEC     A
        CALL    P,C3666
        LD      D,B
        JP      J351C

J35EF:  PUSH    HL
        PUSH    DE
        CALL    C2FC8
        POP     DE
J35F5:  CALL    C3752
        LD      E,B
        CALL    C2E71                   ; get sign DAC
        PUSH    AF
        CALL    NZ,C37A2                ; DAC not zero,
        POP     AF
        POP     HL
        POP     BC
        PUSH    AF
        LD      A,C
        OR      A
        PUSH    AF
        CALL    NZ,C3293
        ADD     A,B
        LD      C,A
        LD      A,D
        AND     $4
        CP      $1
        SBC     A,A
        LD      D,A
        ADD     A,C
        LD      C,A
        SUB     E
        PUSH    AF
        JP      P,J3628
        CALL    C377B
        JR      NZ,J3628
        PUSH    HL
        CALL    C27DB
        LD      HL,DAC
        INC     (HL)
        POP     HL
J3628:  POP     AF
        PUSH    BC
        PUSH    AF
        JP      M,J362F
        XOR     A
J362F:  CPL
        INC     A
        ADD     A,B
        INC     A
        ADD     A,D
        LD      B,A
        LD      C,$0
        CALL    Z,C368E
        CALL    C36B3
        POP     AF
        CALL    P,C366E
        CALL    C36A0
        POP     BC
        POP     AF
        JR      NZ,J3654
        CALL    C3295
        LD      A,(HL)
        CP      '.'
        CALL    NZ,C2EE6
        LD      (TEMP2),HL
J3654:  POP     AF
        LD      A,(DAC)
        JR      Z,J365D
        ADD     A,E
        SUB     B
        SUB     D
J365D:  PUSH    BC
        CALL    C34D6
        EX      DE,HL
        POP     DE
        JP      J351C

;       Subroutine      __________________________
;       Inputs          ________________________
;       Outputs         ________________________

C3666:  OR      A
J3667:  RET     Z
        DEC     A
        LD      (HL),$30
        INC     HL
        JR      J3667

;       Subroutine      __________________________
;       Inputs          ________________________
;       Outputs         ________________________

C366E:  JR      NZ,C3674
J3670:  RET     Z
        CALL    C36A0

;       Subroutine      __________________________
;       Inputs          ________________________
;       Outputs         ________________________

C3674:  LD      (HL),$30
        INC     HL
        DEC     A
        JR      J3670

;       Subroutine      __________________________
;       Inputs          ________________________
;       Outputs         ________________________

C367A:  LD      A,E
        ADD     A,D
        INC     A
        LD      B,A
        INC     A
J367F:  SUB     $3
        JR      NC,J367F
        ADD     A,$5
        LD      C,A

;       Subroutine      __________________________
;       Inputs          ________________________
;       Outputs         ________________________

C3686:  LD      A,(TEMP3)
        AND     $40
        RET     NZ
        LD      C,A
        RET

;       Subroutine      __________________________
;       Inputs          ________________________
;       Outputs         ________________________

C368E:  DEC     B
        JP      P,J36A1
        LD      (TEMP2),HL
        LD      (HL),'.'
J3697:  INC     HL
        LD      (HL),'0'
        INC     B
        LD      C,B
        JR      NZ,J3697
        INC     HL
        RET

;       Subroutine      __________________________
;       Inputs          ________________________
;       Outputs         ________________________

C36A0:  DEC     B
J36A1:  JR      NZ,J36AB

;       Subroutine      __________________________
;       Inputs          ________________________
;       Outputs         ________________________

C36A3:  LD      (HL),'.'
        LD      (TEMP2),HL
        INC     HL
        LD      C,B
        RET

J36AB:  DEC     C
        RET     NZ
        LD      (HL),','
        INC     HL
        LD      C,$3
        RET

;       Subroutine      __________________________
;       Inputs          ________________________
;       Outputs         ________________________

C36B3:  PUSH    DE
        PUSH    HL
        PUSH    BC
        CALL    C3752
        LD      A,B
        POP     BC
        POP     HL
        LD      DE,DAC+1
        SCF
J36C0:  PUSH    AF
        CALL    C36A0
        LD      A,(DE)
        JR      NC,J36CD
        RRA
        RRA
        RRA
        RRA
        JR      J36CE

J36CD:  INC     DE
J36CE:  AND     $F
        ADD     A,'0'
        LD      (HL),A
        INC     HL
        POP     AF
        DEC     A
        CCF
        JR      NZ,J36C0
        JR      J370A

;       Subroutine      __________________________
;       Inputs          ________________________
;       Outputs         ________________________

C36DB:  PUSH    DE
        LD      DE,I3710
        LD      A,$5
J36E1:  CALL    C36A0
        PUSH    BC
        PUSH    AF
        PUSH    HL
        EX      DE,HL
        LD      C,(HL)
        INC     HL
        LD      B,(HL)
        PUSH    BC
        INC     HL
        EX      (SP),HL
        EX      DE,HL
        LD      HL,(DAC+2)
        LD      B,$2F
J36F4:  INC     B
        LD      A,L
        SUB     E
        LD      L,A
        LD      A,H
        SBC     A,D
        LD      H,A
        JR      NC,J36F4
        ADD     HL,DE
        LD      (DAC+2),HL
        POP     DE
        POP     HL
        LD      (HL),B
        INC     HL
        POP     AF
        POP     BC
        DEC     A
        JR      NZ,J36E1
J370A:  CALL    C36A0
        LD      (HL),A
        POP     DE
        RET

I3710:  DEFW    10000
        DEFW    1000
        DEFW    100
        DEFW    10
        DEFW    1

;       Subroutine      FOUTB (convert integer to binary text)
;       Inputs          ________________________
;       Outputs         ________________________

C371A:  LD      B,1
        JR      J3724

;       Subroutine      FOUTO (convert integer to octal text)
;       Inputs          ________________________
;       Outputs         ________________________

C371E:  LD      B,3
        JR      J3724

;       Subroutine      FOUTH (convert integer to hexadecimal text)
;       Inputs          ________________________
;       Outputs         ________________________

C3722:  LD      B,4
J3724:  PUSH    BC
        CALL    C5439                   ; convert address to integer
        LD      DE,FBUFFR+17
        XOR     A
        LD      (DE),A
        POP     BC
        LD      C,A
J372F:  PUSH    BC
        DEC     DE
J3731:  AND     A
        LD      A,H
        RRA
        LD      H,A
        LD      A,L
        RRA
        LD      L,A
        LD      A,C
J3739:  RRA
        LD      C,A
        DJNZ    J3731
        POP     BC
        PUSH    BC
J373F:  RLCA
        DJNZ    J373F
        ADD     A,'0'
        CP      '9'+1
        JR      C,J374A
        ADD     A,$7
J374A:  LD      (DE),A
        POP     BC
        LD      A,L
        OR      H
        JR      NZ,J372F
        EX      DE,HL
        RET

;       Subroutine      __________________________
;       Inputs          ________________________
;       Outputs         ________________________

C3752:  RST     GETYPR                  ; get DAC type
        LD      HL,DAC+7
        LD      B,14
        RET     NC                      ; double real, quit
        LD      HL,DAC+3
        LD      B,6
        RET

;       Subroutine      __________________________
;       Inputs          ________________________
;       Outputs         ________________________

C375F:  LD      (TEMP3),A
        PUSH    AF
        PUSH    BC
        PUSH    DE
        CALL    C303A                   ; convert DAC to double real
        LD      HL,I2D13
        LD      A,(DAC)
        AND     A
        CALL    Z,C2C5C                 ; ?, DAC = 0
        POP     DE
        POP     BC
        POP     AF
        LD      HL,FBUFFR+1
        LD      (HL),$20
        RET

;       Subroutine      __________________________
;       Inputs          ________________________
;       Outputs         ________________________

C377B:  PUSH    HL
        PUSH    DE
        PUSH    BC
        PUSH    AF
        CPL
        INC     A
        LD      E,A
        LD      A,$1
        JP      Z,J379C
        CALL    C3752
        PUSH    HL
J378B:  CALL    C27DB
        DEC     E
        JR      NZ,J378B
        POP     HL
        INC     HL
        LD      A,B
        RRCA
        LD      B,A
        CALL    C2741
        CALL    C37B4
J379C:  POP     BC
        ADD     A,B
        POP     BC
        POP     DE
        POP     HL
        RET

;       Subroutine      __________________________
;       Inputs          ________________________
;       Outputs         ________________________

C37A2:  PUSH    BC
        PUSH    HL
        CALL    C3752
        LD      A,(DAC)
        SUB     $40
        SUB     B
        LD      (DAC),A
        POP     HL
        POP     BC
        OR      A
        RET

;       Subroutine      __________________________
;       Inputs          ________________________
;       Outputs         ________________________

C37B4:  PUSH    BC
        CALL    C3752
J37B8:  LD      A,(HL)
        AND     $F
        JR      NZ,J37C5
        DEC     B
        LD      A,(HL)
        OR      A
        JR      NZ,J37C5
        DEC     HL
        DJNZ    J37B8
J37C5:  LD      A,B
        POP     BC
        RET

;       Subroutine      SGNEXP (single real to the power)
;       Inputs          ________________________
;       Outputs         ________________________

C37C8:  CALL    C3280
        CALL    C3042
        CALL    C2CC7                   ; push ARG
        CALL    C2C6F                   ; exchange DAC with stack
        CALL    C2CDC                   ; pop ARG

;       Subroutine      DBLEXP (double real to the power)
;       Inputs          ________________________
;       Outputs         ________________________

C37D7:  LD      A,(ARG)
        OR      A
        JP      Z,J3843
        LD      H,A
        LD      A,(DAC)
        OR      A
        JP      Z,J384D
        CALL    C2CCC                   ; push DAC
        CALL    C391A
        JR      C,J382A
        EX      DE,HL
        LD      (TEMP8),HL
        CALL    C304F
        CALL    C2CDC                   ; pop ARG
        CALL    C391A
        CALL    C304F
        LD      HL,(TEMP8)
        JP      NC,J385A
        LD      A,(ARG)
        PUSH    AF
        PUSH    HL
        CALL    C2C59                   ; DAC = ARG
        LD      HL,FBUFFR
        CALL    C2C67                   ; = DAC
        LD      HL,I2D1B
        CALL    C2C5C                   ; DAC = 1.0
        POP     HL
        LD      A,H
        OR      A
        PUSH    AF
        JP      P,J3826
        XOR     A
        LD      C,A
        SUB     L
        LD      L,A
        LD      A,C
        SBC     A,H
        LD      H,A
J3826:  PUSH    HL
        JP      J3894

J382A:  CALL    C304F
        CALL    C2C59                   ; DAC = ARG
        CALL    C2C6F                   ; exchange DAC with stack
        CALL    C2A72                   ; LOG DAC
        CALL    C2CDC                   ; pop ARG
        CALL    C27E6                   ; DAC * ARG
        JP      C2B4A                   ; EXP DAC

;       Subroutine      INTEXP (integer to the power)
;       Inputs          ________________________
;       Outputs         ________________________

C383F:  LD      A,H
        OR      L
        JR      NZ,J3849
J3843:  LD      HL,1
        JP      J3857

J3849:  LD      A,D
        OR      E
        JR      NZ,J385A
J384D:  LD      A,H
        RLA
        JR      NC,J3854
        JP      J4058

J3854:  LD      HL,0
J3857:  JP      C2F99                   ; put HL in DAC

J385A:  LD      (TEMP8),HL
        PUSH    DE
        LD      A,H
        OR      A
        PUSH    AF
        CALL    M,C3221
        LD      B,H
        LD      C,L
        LD      HL,1
J3869:  OR      A
        LD      A,B
        RRA
        LD      B,A
        LD      A,C
        RRA
        LD      C,A
        JR      NC,J3877
        CALL    C390D
        JR      NZ,J38C3
J3877:  LD      A,B
        OR      C
        JR      Z,J38DE
        PUSH    HL
        LD      H,D
        LD      L,E
        CALL    C390D
        EX      DE,HL
        POP     HL
        JR      Z,J3869
        PUSH    BC
        PUSH    HL
        LD      HL,FBUFFR
        CALL    C2C67                   ; = DAC
        POP     HL
        CALL    C2FCB                   ; convert to single precision real
        CALL    C3042
J3894:  POP     BC
        LD      A,B
        OR      A
        RRA
        LD      B,A
        LD      A,C
        RRA
        LD      C,A
        JR      NC,J38A6
        PUSH    BC
        LD      HL,FBUFFR
        CALL    C2C3B                   ; DAC = DAC * .
        POP     BC
J38A6:  LD      A,B
        OR      C
        JR      Z,J38DE
        PUSH    BC
        CALL    C2CCC                   ; push DAC
        LD      HL,FBUFFR
        PUSH    HL
        CALL    C2C5C                   ; DAC =
        POP     HL
        PUSH    HL
        CALL    C2C3B                   ; DAC = DAC * .
        POP     HL
        CALL    C2C67                   ; = DAC
        CALL    C2CE1                   ; pop DAC
        JR      J3894

J38C3:  PUSH    BC
        PUSH    DE
        CALL    C303A                   ; convert DAC to double real
        CALL    C2C4D                   ; ARG = DAC
        POP     HL
        CALL    C2FCB                   ; convert to single precision real
        CALL    C3042
        LD      HL,FBUFFR
        CALL    C2C67                   ; = DAC
        CALL    C2C59                   ; DAC = ARG
        POP     BC
        JR      J38A6

J38DE:  POP     AF
        POP     BC
        RET     P
        LD      A,(VALTYP)
        CP      2
        JR      NZ,J38F0
        PUSH    BC
        CALL    C2FCB                   ; convert to single precision real
        CALL    C3042
        POP     BC
J38F0:  LD      A,(DAC)
        OR      A
        JR      NZ,J3901
        LD      HL,(TEMP8)
        OR      H
        RET     P
        LD      A,L
        RRCA
        AND     B
        JP      J4067                   ; overflow error

J3901:  CALL    C2C4D                   ; ARG = DAC
        LD      HL,I2D1B
        CALL    C2C5C                   ; DAC = 1.0
        JP      C289F                   ; DAC / ARG

;       Subroutine      __________________________
;       Inputs          ________________________
;       Outputs         ________________________

C390D:  PUSH    BC
        PUSH    DE
        CALL    C3193                   ; integer multiply
        LD      A,(VALTYP)
        CP      2
        POP     DE
        POP     BC
        RET

;       Subroutine      __________________________
;       Inputs          ________________________
;       Outputs         ________________________

C391A:  CALL    C2C59                   ; DAC = ARG
        CALL    C2CC7                   ; push ARG
        CALL    C30CF
        CALL    C2CDC                   ; pop ARG
        CALL    C2F5C                   ; compare double real
        SCF
        RET     NZ
        JP      C305D

