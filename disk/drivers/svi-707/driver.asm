;
;   SVI707MS -> Source re-created by Z80DIS 2.2
;      Z80DIS was written by Kenneth Gielow
;                            Palo Alto, CA
;
        .Z80
        ORG     7405H

MYSIZE  EQU     8

ENASLT  EQU     0024H
J$4022  EQU     4022H
GETSLT  EQU     402DH
DIV16   EQU     492FH
GETWRK  EQU     5FC2H
SETINT  EQU     5FF6H
PRVINT  EQU     6027H
PROMPT  EQU     625AH
RAMAD1  EQU     0F342H
RAMAD2  EQU     0F343H
_SECBUF EQU     0F34DH
ENAKRN  EQU     0F368H
XFER    EQU     0F36EH
BDOS    EQU     0F37DH
I$F51F  EQU     0F51FH
DISINT  EQU     0FFCFH
ENAINT  EQU     0FFD4H


I$7405:

; Only supports 5.25 single sided media
; DEFDPB should point to the largest media, which should be 0FDH instead of 0FCH

DEFDPB  EQU     I$7405-1

         DB	0FCh
        DW	512
        DB	00Fh
        DB	004h
        DB	000h
        DB	001h
        DW	1
        DB	2
        DB	64
        DW	9
        DW	352
        DB	2
        DW	5

        DB	0FDh
        DW	512
        DB	00Fh
        DB	004h
        DB	001h
        DB	002h
        DW	1
        DB	2
        DB	112
        DW	12
        DW	355
        DB	2
        DW	5

        DB	0FEh
        DW	512
        DB	00Fh
        DB	004h
        DB	000h
        DB	001h
        DW	1
        DB	2
        DB	64
        DW	7
        DW	314
        DB	1
        DW	3

        DB	0FFh
        DW	512
        DB	00Fh
        DB	004h
        DB	001h
        DB	002h
        DW	1
        DB	2
        DB	112
        DW	10
        DW	316
        DB	1
        DW	3


?.744C: NOP
;
;        Subroutine __________________________
;           Inputs  ________________________
;           Outputs ________________________
;
DSKIO:
C$744D: EI
        PUSH    AF
        JP      NC,J$7545
        CALL    C$747E
J$7455: POP     DE
        PUSH    AF
        LD      C,120
        JR      NC,J$745D
        LD      C,0
J$745D: LD      A,0D0H
        LD      (D7FB8),A
        EX      (SP),HL
        EX      (SP),HL
        EX      (SP),HL
        EX      (SP),HL
        LD      A,(D7FBB)
        LD      A,(D7FB8)
        LD      (IX),0F0H
        LD      A,D
        AND     A
        JR      NZ,J$7479
        LD      (IX+1),C
        POP     AF
        RET
J$7479: LD      (IX+2),C
        POP     AF
        RET

;        Subroutine __________________________
;           Inputs  ________________________
;           Outputs ________________________

C$747E: CALL    C.7604
        RET     C
        LD      A,H
        AND     A
        JP      M,J.74AE
        CALL    C$7C53
        CALL    C.7CCA
        RET     C
        INC     B
        DEC     B
        RET     Z
        LD      A,H
        AND     A
        JP      M,J.74AE
        PUSH    HL
        PUSH    DE
        PUSH    BC
        LD      DE,(_SECBUF)
        PUSH    DE
        LD      BC,512
        CALL    XFER
        POP     HL
        POP     BC
        POP     DE
        CALL    C.74BA
        POP     HL
        JP      J$74B1

J.74AE: CALL    C.74BA
J$74B1: RET     C
        DEC     B
        RET     Z
        CALL    C.76B7
        JP      J.74AE

;        Subroutine __________________________
;           Inputs  ________________________
;           Outputs ________________________

C.74BA: LD      E,15H
J$74BC: CALL    C.7707                  ; wait for FDC
        LD      A,0A0H
        BIT     6,D
        JR      Z,J.74CD
        OR      02H
        BIT     2,D
        JR      Z,J.74CD
        OR      08H
J.74CD: PUSH    HL
        PUSH    DE
        PUSH    BC
        LD      DE,I$74ED
        PUSH    DE
        CALL    DISINT
        DI
        LD      (D7FB8),A
        LD      BC,D7FBC
        LD      DE,D7FBB
J.74E1: LD      A,(BC)
        ADD     A,A
        RET     C
        JP      M,J.74E1
        LD      A,(HL)
        LD      (DE),A
        INC     HL
        JP      J.74E1

I$74ED: POP     BC
        POP     DE
        POP     HL
        EI
        CALL    ENAINT
        LD      A,(D7FB8)
        AND     0FCH
        RET     Z
        JP      M,J$753E
        BIT     6,A
        JR      NZ,J$751D
        PUSH    AF
        CALL    C.76F4
        POP     AF
        DEC     E
        JR      NZ,J$74BC
        SCF
        LD      E,A
        BIT     5,E
        LD      A,10
        RET     NZ
        BIT     4,E
        LD      A,8
        RET     NZ
        BIT     3,E
        LD      A,4
        RET     NZ
        LD      A,12
        RET

J$751D: LD      A,0D0H
        LD      (D7FB8),A
        EX      (SP),HL
        EX      (SP),HL
        LD      A,80H
        LD      (D7FB8),A
        EX      (SP),HL
        EX      (SP),HL
        LD      HL,D7FBC
        LD      DE,0
J$7531: LD      A,(HL)
        ADD     A,A
        JR      C,J.7542
        JP      P,J.7542
        DEC     DE
        LD      A,E
        OR      D
        JP      NZ,J$7531
J$753E: LD      A,2
        SCF
        RET

J.7542: XOR     A
        SCF
        RET

J$7545: CALL    C$754B
        JP      J$7455

;        Subroutine __________________________
;           Inputs  ________________________
;           Outputs ________________________

C$754B: CALL    C.7604
        RET     C
        LD      A,H
        AND     A
        JP      M,J.7580
        CALL    C$7C3F
        CALL    C.7CCA
        RET     C
        INC     B
        DEC     B
        RET     Z
        LD      A,H
        AND     A
        JP      M,J.7580
        PUSH    HL
        LD      HL,(_SECBUF)
        CALL    C.758C
        POP     HL
        RET     C
        PUSH    HL
        PUSH    DE
        PUSH    BC
        EX      DE,HL
        LD      HL,(_SECBUF)
        LD      BC,512
        CALL    XFER
        POP     BC
        POP     DE
        POP     HL
        AND     A
        JP      J$7584

J.7580: CALL    C.758C
        RET     C
J$7584: DEC     B
        RET     Z
        CALL    C.76B7
        JP      J.7580

;        Subroutine __________________________
;           Inputs  ________________________
;           Outputs ________________________

C.758C: LD      E,15H
J$758E: CALL    C.7707                  ; wait for FDC
        LD      A,80H
        BIT     6,D
        JR      Z,J.759F
        OR      02H
        BIT     2,D
        JR      Z,J.759F
        OR      08H
J.759F: PUSH    HL
        PUSH    DE
        PUSH    BC
        LD      BC,D7FBC
        LD      DE,I$75D9
        PUSH    DE
        CALL    DISINT
        DI
        LD      (D7FB8),A
        LD      DE,0
J.75B3: LD      A,(BC)
        ADD     A,A
        JP      P,J$75C7
        RET     C
        DEC     E
        JP      NZ,J.75B3
        DEC     D
        JP      NZ,J.75B3
        POP     BC
        POP     BC
        POP     DE
        POP     HL
        JR      J.7600

J$75C7: LD      DE,D7FBB
        JP      J$75D3

J.75CD: LD      A,(BC)
        ADD     A,A
        RET     C
        JP      M,J.75CD
J$75D3: LD      A,(DE)
        LD      (HL),A
        INC     HL
        JP      J.75CD

I$75D9: POP     BC
        POP     DE
        POP     HL
        EI
        CALL    ENAINT
        LD      A,(D7FB8)
        AND     9CH
        RET     Z
        JP      M,J.7600
        PUSH    AF
        CALL    C.76F4
        POP     AF
        DEC     E
        JR      NZ,J$758E
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

J.7600: LD      A,2
        SCF
        RET

;        Subroutine __________________________
;           Inputs  ________________________
;           Outputs ________________________

C.7604: PUSH    AF
        PUSH    BC
        PUSH    HL
        CALL    GETWRK
        POP     HL
        POP     BC
        POP     AF
        CP      02H
        JR      C,J$7615
J$7611: LD      A,12
        SCF
        RET

J$7615: PUSH    AF
        LD      A,C
        CP      0FCH
        JR      NC,J$761E
        POP     AF
        JR      J$7611

J$761E: EX      (SP),HL
        PUSH    HL
        PUSH    BC
        CALL    C.7707                  ; wait for FDC
        BIT     1,C
        LD      C,E
        LD      B,D
        LD      DE,8
        JR      NZ,J$762E
        INC     DE
J$762E: CALL    DIV16                   ; DIV16
        LD      A,L
        INC     A
        LD      (D7FBA),A               ; sector
        LD      L,C
        POP     BC
        POP     AF
        LD      H,A
        LD      A,(IX+7)
        DEC     A
        JR      Z,J$7641
        LD      A,H
J$7641: ADD     A,09H                   ; drive 0 -> 1001, drive 1 -> 1010
        BIT     0,C
        JR      Z,J.764D
        SRL     L
        JR      NC,J.764D
        OR      04H                     ; side 1
J.764D: LD      D,A
        LD      A,C
        RRCA
        RRCA
        AND     0C0H
        OR      D
        LD      D,A
        DI
        LD      (D7FBC),A               ; select drive, side, motor on
        LD      A,(IX)
        AND     A
        LD      (IX),0FFH
        EI
        JR      NZ,J$766E
        PUSH    HL
        LD      HL,0
J$7668: DEC     HL
        LD      A,L
        OR      H
        JR      NZ,J$7668
        POP     HL
J$766E: LD      C,L
        LD      A,(IX+7)
        DEC     A
        JR      Z,J$769A
        LD      A,(IX+3)
        CP      H
        JR      Z,J.76AE
        XOR     01H     ; 1
        LD      (IX+3),A
        LD      A,(D7FB9)
        JR      Z,J$768D
        LD      (IX+4),A
        LD      A,(IX+5)
        JR      J$7693

J$768D: LD      (IX+5),A
        LD      A,(IX+4)
J$7693: LD      (D7FB9),A
        EX      (SP),HL
        EX      (SP),HL
        JR      J$76B1

J$769A: LD      A,H
        CP      (IX+6)
        LD      (IX+6),A
        JR      Z,J.76AE
        PUSH    IX
        PUSH    DE
        PUSH    BC
        CALL    PROMPT
        POP     BC
        POP     DE
        POP     IX
J.76AE: LD      A,(D7FB9)
J$76B1: CP      C
        CALL    NZ,C$76FA
        POP     HL
        RET

;        Subroutine __________________________
;           Inputs  ________________________
;           Outputs ________________________

C.76B7: CALL    C.7707                  ; wait for FDC
        INC     H
        INC     H
        LD      A,(D7FBA)
        INC     A
        LD      (D7FBA),A
        BIT     7,D
        JR      NZ,J$76CA
        CP      9+1
        RET     C
J$76CA: CP      8+1
        RET     C
        LD      A,1
        LD      (D7FBA),A
        BIT     6,D
        JR      Z,J.76E1
        BIT     2,D                     ; side 1 ?
        JR      NZ,J.76E1               ; yep, side 0 on next track
        SET     2,D                     ; side 1 on same track
        LD      A,D
        LD      (D7FBC),A
        RET

J.76E1: RES     2,D                     ; side 0
        LD      A,D
        LD      (D7FBC),A
        INC     C
        CALL    C.7707                  ; wait for FDC
        LD      A,54H
        LD      (D7FB8),A
        EX      (SP),HL
        EX      (SP),HL
        JR      C.7707                  ; wait for FDC

;        Subroutine __________________________
;           Inputs  ________________________
;           Outputs ________________________

C.76F4: BIT     0,E
        RET     NZ
        CALL    C.770E

;        Subroutine __________________________
;           Inputs  ________________________
;           Outputs ________________________

C$76FA: LD      A,C
        LD      (D7FBB),A
        EX      (SP),HL
        EX      (SP),HL
        LD      A,14H   ; 20
J$7702: LD      (D7FB8),A
        EX      (SP),HL
        EX      (SP),HL

;        Subroutine __________________________
;           Inputs  ________________________
;           Outputs ________________________

C.7707: LD      A,(D7FB8)
        RRA
        JR      C,C.7707
        RET

;        Subroutine __________________________
;           Inputs  ________________________
;           Outputs ________________________

C.770E: CALL    C.7707                  ; wait for FDC
        LD      A,00H
        JR      J$7702

INIHRD:
?.7715: LD      A,0D0H
        LD      (D7FB8),A
        EX      (SP),HL
        EX      (SP),HL
        LD      A,01H                   ; 0001, select drive 0, side 0, motor off
        CALL    C.772B
        LD      A,02H                   ; 0010, select drive 1, side 0, motor off
        CALL    C.772B

MTOFF:
        XOR     A
        LD      (D7FBC),A               ; select no drive, side 0, motor off
        RET

;        Subroutine __________________________
;           Inputs  ________________________
;           Outputs ________________________

C.772B: LD      (D7FBC),A
        CALL    C.7707                  ; wait for FDC
        LD      A,00H
        LD      (D7FB8),A
        EX      (SP),HL
        EX      (SP),HL
        LD      HL,0
J$773B: LD      A,(D7FB8)
        RRA
        RET     NC
        DEC     HL
        LD      A,L
        OR      H
        JR      NZ,J$773B
        RET

DRIVES:
?.7746: PUSH    BC
        PUSH    AF
        CALL    GETWRK
        LD      A,02H
        LD      (D7FBC),A               ; select drive 1, side 0, motor off
        CALL    C.7707                  ; wait for FDC
        LD      A,00H
        LD      (D7FB8),A
        EX      (SP),HL
        EX      (SP),HL
        LD      HL,0
J$775D: LD      A,(D7FB8)
        RRA
        JR      NC,J$776A
        DEC     HL
        LD      A,L
        OR      H
        JR      NZ,J$775D
        INC     L
        DEFB    0CAH
J$776A: LD      L,2
        LD      (IX+7),L
        XOR     A
        LD      (D7FBC),A               ; select no drive, side 0, motor off
        POP     AF
        JR      Z,J$7778
        LD      L,2
J$7778: POP     BC
        RET

INIENV:
?.777A: CALL    GETWRK
        XOR     A
        LD      B,07H   ; 7
J$7780: LD      (HL),A
        INC     HL
        DJNZ    J$7780
        LD      HL,I$778A
        JP      SETINT

I$778A: PUSH    AF
        CALL    GETWRK
        LD      A,(HL)
        AND     A
        JR      Z,J.779D
        CP      0FFH
        JR      Z,J.779D
        DEC     A
        LD      (HL),A
        JR      NZ,J.779D
        LD      (D7FBC),A               ; select no drive, side 0, motor off
J.779D: INC     HL
        LD      A,(HL)
        AND     A
        JR      Z,J$77A3
        DEC     (HL)
J$77A3: INC     HL
        LD      A,(HL)
        AND     A
        JR      Z,J$77A9
        DEC     (HL)
J$77A9: POP     AF
        JP      PRVINT

DSKCHG:
?.77AD: EI
        PUSH    HL
        PUSH    BC
        PUSH    AF
        CALL    GETWRK
        POP     AF
        POP     BC
        POP     HL
        AND     A
        LD      B,(IX+2)
        JR      NZ,J$77C0
        LD      B,(IX+1)
J$77C0: INC     B
        DEC     B
        LD      B,1
        RET     NZ
        PUSH    BC
        PUSH    HL
        LD      DE,1
        LD      HL,(_SECBUF)
        CALL    C$744D
        JR      C,J.77E9
        LD      HL,(_SECBUF)
        LD      B,(HL)
        POP     HL
        PUSH    BC
        CALL    C$77EC
        LD      A,12
        JR      C,J.77E9
        POP     AF
        POP     BC
        CP      C
        SCF
        CCF
        LD      B,0FFH
        RET     NZ
        INC     B
        RET

J.77E9: POP     DE
        POP     DE
        RET

;        Subroutine __________________________
;           Inputs  ________________________
;           Outputs ________________________

GETDPB:
C$77EC: EI
        EX      DE,HL
        INC     DE
        LD      A,B
        SUB     0FCH
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
        LD      BC,I$7405
        ADD     HL,BC
        LD      BC,18
        LDIR
        RET

CHOICE:
?.7807: LD      HL,I$780B
        RET

I$780B: DEFB    13,10
        DEFB    "1 - Single Side",13,10
        DEFB    "2 - Double Side",13,10
        DEFB    13,10
        DEFB    0

OEMSTA:
        SCF
        RET

DSKFMT:
?.7834: CALL    C$7840
        PUSH    AF
        LD      A,00H
        LD      (D7FBC),A               ; select no drive, side 0, motor off
        POP     AF
        EI
        RET

;        Subroutine __________________________
;           Inputs  ________________________
;           Outputs ________________________

C$7840: DI
        EX      AF,AF'
        LD      A,D
        CP      01H     ; 1
        JR      NC,J$789C
        PUSH    HL
        LD      HL,I$1964
        SBC     HL,BC
        POP     HL
        JR      NC,J$78A0
        PUSH    HL
        LD      A,0D0H
        LD      (D7FB8),A
        EX      (SP),HL
        EX      (SP),HL
        LD      A,09H
        LD      (D7FBC),A               ; select drive 0, side 0, motor on
        CALL    C.7707                  ; wait for FDC
        LD      A,00H
        LD      (D7FB8),A
J$7865: EX      (SP),HL
        EX      (SP),HL
J$7867: LD      HL,0
J$786A: LD      A,(D7FB8)
J$786C  EQU     $-1
        RRA
        JR      NC,J$7877
        DEC     HL
        LD      A,H
        OR      L
        JR      NZ,J$786A
        JR      J.7897

J$7877: LD      HL,0
J$787A: LD      A,(D7FB8)
J$787D: AND     02H     ; 2
        JR      Z,J$7888
        DEC     HL
        LD      A,H
        OR      L
        JR      NZ,J$787A
        JR      J.7897

J$7888: LD      HL,0
J$788B: LD      A,(D7FB8)
        AND     02H     ; 2
        JR      NZ,J$78A4
        DEC     HL
        LD      A,H
        OR      L
        JR      NZ,J$788B
J.7897: SCF
        POP     HL
        LD      A,2
        RET

J$789C: SCF
        LD      A,12
        RET

J$78A0: SCF
        LD      A,14
        RET

J$78A4: POP     HL
        PUSH    IX
        PUSH    HL
        EX      (SP),HL
        EX      (SP),IX
        EX      (SP),HL
        POP     HL
        INC     HL
        INC     HL
        INC     HL
        INC     HL
        INC     HL
        INC     HL
        EX      AF,AF'
        LD      (IX+4),A
        DEC     A
        LD      A,0FCH
        JR      Z,J$78BE
        LD      A,0FDH
J$78BE: LD      (IX+5),A
        XOR     A
        LD      (IX),A
        DEC     A
        LD      (IX+3),A
        LD      (IX+1),A
J$78CC: INC     (IX+1)
J$78CF: INC     (IX+3)
        CALL    C.79BC
        CALL    C.7A39
        CALL    C.7A82
        JR      NC,J$78EA
        LD      A,15H
        CP      (IX+3)
        JR      NZ,J$78CF
        LD      A,16
        SCF
        POP     IX
        RET

J$78EA: LD      A,(IX+4)
        DEC     A
        JR      Z,J$791B
        LD      A,0FFH
        LD      (IX+3),A
        LD      A,0DH                   ; 1101
        LD      (D7FBC),A               ; select drive 1, side 1, motor on
        INC     (IX)
J$78FD: INC     (IX+3)
        CALL    C.79BC
        CALL    C.7A39
        CALL    C.7A82
        JR      NC,J$7918
        LD      A,15H
        CP      (IX+3)
        JR      NZ,J$78FD
        LD      A,16
        SCF
        POP     IX
        RET

J$7918: DEC     (IX)
J$791B: LD      A,27H
        CP      (IX+1)
        JR      Z,J$7931
        CALL    C$7997
        LD      A,09H                   ; 1001
        LD      (D7FBC),A               ; select drive 0, side 0, motor on
        LD      A,0FFH
        LD      (IX+3),A
        JR      J$78CC

J$7931: CALL    C.770E
        PUSH    HL
        EX      DE,HL
        POP     HL
        PUSH    HL
        INC     DE
        XOR     A
        LD      (HL),A
        LD      BC,I$11FF
        LD      A,(IX+4)
        DEC     A
        JR      Z,J$7947
        LD      BC,I$17FF
J$7947: LDIR
        POP     HL
        PUSH    HL
        EX      DE,HL
        LD      HL,I$7B7A
        LD      BC,I$00C3
        LDIR
        POP     HL
        PUSH    HL
        LD      BC,512
        ADD     HL,BC
        LD      A,(IX+5)
        LD      (HL),A
        INC     HL
        LD      A,0FFH
        LD      (HL),A
        INC     HL
        LD      (HL),A
        LD      BC,512-2
        ADD     HL,BC
        LD      A,(IX+5)
        LD      (HL),A
        INC     HL
        LD      A,0FFH
        LD      (HL),A
        INC     HL
        LD      (HL),A
        LD      B,0CH
        LD      C,0FDH
        LD      A,(IX+4)
        DEC     A
        JR      NZ,J$798B
        POP     HL
        PUSH    HL
        EX      DE,HL
        LD      HL,I$7B5C
        LD      BC,30
        LDIR
        LD      B,09H   ; 9
        LD      C,0FCH
J$798B: XOR     A
        LD      DE,0
        POP     HL
        SCF
        CALL    C$7AE8
        POP     IX
        RET

;        Subroutine __________________________
;           Inputs  ________________________
;           Outputs ________________________

C$7997: LD      A,54H
        PUSH    AF
        CALL    C.7707                  ; wait for FDC
        POP     AF
        LD      (D7FB8),A
        CALL    C.79AE
J$79A4: LD      A,(D7FBC)
        ADD     A,A
        JR      NC,J$79A4
        CALL    C.7707                  ; wait for FDC
        RET

;        Subroutine __________________________
;           Inputs  ________________________
;           Outputs ________________________

C.79AE: EX      (SP),HL
        EX      (SP),HL
        EX      (SP),HL
        EX      (SP),HL
I$79B2: RET

?.79B3: LD      BC,I$0206
        RLCA
        INC     BC
        EX      AF,AF'
        INC     B
        ADD     HL,BC
        DEC     B

;        Subroutine __________________________
;           Inputs  ________________________
;           Outputs ________________________

C.79BC: LD      C,01H
        LD      D,H
        LD      E,L
        LD      A,4EH
        LD      B,32H
        CALL    C.7A33
J$79C7: XOR     A
        LD      B,0CH
        CALL    C.7A33
        LD      A,0F5H
        LD      B,03H
        CALL    C.7A33
        LD      A,0FEH
        LD      (DE),A
        INC     DE
        LD      A,(IX+1)
        LD      (DE),A
        INC     DE
        LD      A,(IX)
        LD      (DE),A
        INC     DE
        PUSH    HL
        LD      HL,I$79B2
        LD      B,00H
        ADD     HL,BC
        LD      A,(HL)
        POP     HL
        LD      (DE),A
        INC     DE
        LD      A,02H
        LD      (DE),A
        INC     DE
        LD      A,0F7H
        LD      (DE),A
        INC     DE
        LD      A,4EH
        LD      B,16H
        CALL    C.7A33
        XOR     A
        LD      B,0CH
        CALL    C.7A33
        LD      A,0F5H
        LD      B,03H
        CALL    C.7A33
        LD      A,0FBH
        LD      (DE),A
        INC     DE
        LD      A,0E5H
        LD      B,00H
        CALL    C.7A33
        CALL    C.7A33
        LD      A,0F7H
        LD      (DE),A
        INC     DE
        LD      A,4EH
        LD      B,20H
        CALL    C.7A33
        INC     C
        LD      A,C
        CP      0AH
        JR      NZ,J$79C7
        LD      A,4EH
        LD      B,00H
        CALL    C.7A33
        CALL    C.7A33
        RET

;        Subroutine __________________________
;           Inputs  ________________________
;           Outputs ________________________

C.7A33: LD      (DE),A
        INC     DE
        DEC     B
        JR      NZ,C.7A33
        RET

;        Subroutine __________________________
;           Inputs  ________________________
;           Outputs ________________________

C.7A39: PUSH    HL
        LD      DE,I$7A57
        PUSH    DE
        LD      BC,D7FBC
        LD      DE,D7FBB
        CALL    C.7707                  ; wait for FDC
        LD      A,0F4H
        LD      (D7FB8),A
J.7A4C: LD      A,(BC)
        ADD     A,A
        RET     C
        JP      M,J.7A4C
        LD      A,(HL)
        LD      (DE),A
        INC     HL
        JR      J.7A4C

I$7A57: POP     HL
        LD      A,(D7FB8)
        LD      E,A
        AND     0E4H
        RET     Z
        POP     BC
J$7A60: SCF
        POP     IX
        JP      P,J$7A69
        LD      A,02H
        RET

J$7A69: BIT     6,A
        JR      Z,J$7A70
        LD      A,00H
        RET

J$7A70: BIT     5,E
        LD      A,0AH
        RET     NZ
        BIT     4,E
        LD      A,08H
        RET     NZ
        BIT     3,E
        LD      A,04H
        RET     NZ
        LD      A,10H
        RET

;        Subroutine __________________________
;           Inputs  ________________________
;           Outputs ________________________

C.7A82: PUSH    HL
        XOR     A
J$7A84: PUSH    AF
        CALL    C.7707                  ; wait for FDC
        POP     AF
        INC     A
        LD      (D7FBA),A
        PUSH    AF
        CALL    C.7707                  ; wait for FDC
        LD      DE,I$7AAB
        PUSH    DE
        LD      A,80H
        LD      (D7FB8),A
        LD      BC,D7FBC
        LD      DE,D7FBB
J.7AA0: LD      A,(BC)
        ADD     A,A
        RET     C
        JP      M,J.7AA0
        LD      A,(DE)
        LD      (HL),A
        INC     HL
        JR      J.7AA0

I$7AAB: LD      A,(D7FB8)
        LD      E,A
        AND     0FCH
        JR      Z,J$7ACE
        POP     AF
        POP     HL
        SCF
        JP      P,J$7ABC
        LD      A,02H
        RET

J$7ABC: BIT     5,E
        LD      A,0AH
        RET     NZ
        BIT     4,E
        LD      A,08H
        RET     NZ
        BIT     3,E
        LD      A,04H
        RET     NZ
        LD      A,10H
        RET

J$7ACE: POP     AF
        CP      09H     ; 9
        JR      C,J$7A84
        POP     HL
        PUSH    HL
        LD      BC,9*512
J$7AD8: LD      A,0E5H
        CP      (HL)
        JR      NZ,J$7AE5
        INC     HL
        DEC     BC
        LD      A,B
        OR      C
        JR      NZ,J$7AD8
        POP     HL
        RET

J$7AE5: SCF
        POP     HL
        RET

;        Subroutine __________________________
;           Inputs  ________________________
;           Outputs ________________________

C$7AE8: AND     A
        CALL    C$7AFD
        PUSH    AF
        LD      A,0D0H
        LD      (D7FB8),A
        CALL    C.79AE
        LD      A,(D7FBB)
        LD      A,(D7FB8)
        POP     AF
        RET

;        Subroutine __________________________
;           Inputs  ________________________
;           Outputs ________________________

C$7AFD: LD      A,09H                   ; drive 0, side 0, motor on
        LD      (D7FBC),A
        XOR     A
        LD      (IX+2),A
        LD      B,09H
J.7B08: PUSH    BC
        INC     (IX+2)
        CALL    C.7707                  ; wait for FDC
        LD      A,(IX+2)
        LD      (D7FBA),A
        CALL    C.7707                  ; wait for FDC
        LD      A,0A0H
        LD      DE,I$7B33
        PUSH    DE
        LD      (D7FB8),A
        LD      BC,D7FBC
        LD      DE,D7FBB
J.7B27: LD      A,(BC)
        ADD     A,A
        RET     C
        JP      M,J.7B27
        LD      A,(HL)
        LD      (DE),A
        INC     HL
        JP      J.7B27

I$7B33: LD      A,(D7FB8)
        AND     0FCH
        POP     BC
        JP      NZ,J$7A60
        LD      A,(IX+2)
        CP      09H
        JR      Z,J$7B49
        DEC     B
        JR      NZ,J.7B08
J$7B46: SCF
        CCF
        RET

J$7B49: LD      A,(IX+4)
        DEC     A
        JR      Z,J$7B46
        LD      A,0DH                   ; 1101
        LD      (D7FBC),A               ; select drive 0, side 1, motor on
        LD      B,03H
        XOR     A
        LD      (IX+2),A
        JR      J.7B08

I$7B5C: EX      DE,HL
        CP      90H
        LD      D,E
        LD      D,(HL)
        LD      C,C
        DEC     L
        SCF
        JR      NC,J$7B9D
        LD      D,E
        NOP
        LD      (BC),A
        LD      BC,1
        LD      (BC),A
        LD      B,B
        NOP
        LD      L,B
        LD      BC,I$02FC
        NOP
        ADD     HL,BC
        NOP
        LD      BC,0
        NOP
I$7B7A: EX      DE,HL
        CP      90H
        LD      D,E
        LD      D,(HL)
        LD      C,C
        DEC     L
        SCF
        JR      NC,J$7BBB
        LD      B,H
        NOP
        LD      (BC),A
        LD      (BC),A
        LD      BC,512
        LD      (HL),B
        NOP
        RET     NC
        LD      (BC),A
        DEFB    0FDH            ; << Illegal Op Code Byte >>
        LD      (BC),A
        NOP
        ADD     HL,BC
        NOP
        LD      (BC),A
        DEFB    0,0,0
        RET     NC
        LD      (D$C059),DE
J$7B9D: LD      (D.C0C4),A
        LD      (HL),56H        ; "V"
        INC     HL
        LD      (HL),0C0H
J$7BA5: LD      SP,I$F51F
        LD      DE,I.C09F
        LD      C,0FH   ; 15
        CALL    BDOS
        INC     A
        JP      Z,J$C063
        LD      DE,00100H
        LD      C,1AH
        CALL    BDOS
J$7BBB  EQU     $-1
        LD      HL,1
        LD      (D$C0AD),HL
        LD      HL,04000H-00100H
        LD      DE,I.C09F
        LD      C,27H   ; "'"
        CALL    BDOS
        JP      00100H

?.7BD0: LD      E,B
        RET     NZ
        CALL    0
        LD      A,C
        AND     0FEH
        CP      02H
        JP      NZ,J$C06A
        LD      A,(D.C0C4)
        AND     A
        JP      Z,J$4022
        LD      DE,I$C079
        LD      C,09H
        CALL    BDOS
        LD      C,07H
        CALL    BDOS
        JR      J$7BA5

?.7BF3: LD      B,D
        LD      L,A
        LD      L,A
        LD      (HL),H
        JR      NZ,J$7C5E
        LD      (HL),D
        LD      (HL),D
        LD      L,A
        LD      (HL),D
        DEC     C
        LD      A,(BC)
        LD      D,B
        LD      (HL),D
        LD      H,L
        LD      (HL),E
        LD      (HL),E
        JR      NZ,J$7C67
        LD      L,(HL)
        LD      A,C
        JR      NZ,J$7C75
        LD      H,L
        LD      A,C
        JR      NZ,J$7C74
        LD      L,A
        LD      (HL),D
        JR      NZ,J$7C84
        LD      H,L
        LD      (HL),H
        LD      (HL),D
        LD      A,C
        DEC     C
        LD      A,(BC)
        INC     H
        NOP
        LD      C,L
        LD      D,E
        LD      E,B
        LD      B,H
        LD      C,A
        LD      D,E
        JR      NZ,J$7C42
        LD      D,E
        LD      E,C
        LD      D,E
        DEFB    0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0
        DEFB    0,0,0,0,0,0

;        Subroutine __________________________
;           Inputs  ________________________
;           Outputs ________________________

C$7C3F: PUSH    HL
        PUSH    DE
        PUSH    BC
J$7C42: LD      HL,I$7CD0
        LD      DE,(_SECBUF)
        LD      BC,I$0120
        LDIR
        LD      HL,I$7CA6
        JR      J.7C65

;        Subroutine __________________________
;           Inputs  ________________________
;           Outputs ________________________

C$7C53: PUSH    HL
        PUSH    DE
        PUSH    BC
        LD      HL,I$7DF0
        LD      DE,(_SECBUF)
        LD      BC,I$0134
J$7C5E  EQU     $-2
        LDIR
        LD      HL,I$7C86
J.7C65: LD      E,(HL)
        INC     HL
J$7C67: LD      D,(HL)
        INC     HL
        LD      A,E
        OR      D
        JR      Z,J$7C82
        PUSH    HL
        LD      HL,(_SECBUF)
        ADD     HL,DE
        INC     HL
        LD      C,(HL)
J$7C74: INC     HL
J$7C75: LD      B,(HL)
        EX      DE,HL
        LD      HL,(_SECBUF)
        ADD     HL,BC
        EX      DE,HL
        LD      (HL),D
        DEC     HL
        LD      (HL),E
        POP     HL
        JR      J.7C65

J$7C82: POP     BC
        POP     DE
J$7C84: POP     HL
        RET

I$7C86: LD      B,00H
        JR      NZ,J$7C8A
J$7C8A: DEC     H
        NOP
        ADD     HL,SP
        NOP
        LD      C,L
        NOP
        LD      D,E
        NOP
        LD      H,A
        NOP
        LD      L,H
        NOP
        LD      (HL),H
        NOP
        XOR     D
        NOP
        OR      B
        NOP
        SUB     00H
        RLCA
        LD      BC,I$0116
        DEC     L
        LD      BC,0
I$7CA6: LD      B,00H
        JR      NZ,J$7CAA
J$7CAA: DEC     H
        NOP
        INC     A
        NOP
        LD      C,H
        NOP
        LD      D,C
        NOP
        LD      D,L
        NOP
        LD      H,C
        NOP
        LD      H,A
        NOP
        LD      L,L
        NOP
        ADD     A,C
        NOP
        ADD     A,(HL)
        NOP
        ADC     A,D
        NOP
        JP      NZ,J$F300
        NOP
        LD      (BC),A
        LD      BC,C.0119
        DEFB    0,0

;        Subroutine __________________________
;           Inputs  ________________________
;           Outputs ________________________

C.7CCA: PUSH    HL
        LD      HL,(_SECBUF)
        EX      (SP),HL
        RET

I$7CD0: PUSH    HL
        PUSH    DE
        PUSH    BC
        CALL    GETSLT
        LD      (D$00B6),A
        LD      H,80H
        CALL    ENASLT
        EI
        LD      A,(RAMAD1)
        LD      H,40H
        CALL    ENASLT
        EI
        POP     BC
        POP     DE
        POP     HL
J$7CEB: DEC     HL
        LD      A,H
        ADD     A,02H   ; 2
        INC     HL
        JP      M,J$00A5
        LD      E,15H
J$7CF5: CALL    C.0112
        LD      A,80H
        BIT     6,D
        JR      Z,J.7D06
        OR      02H     ; 2
        BIT     2,D
        JR      Z,J.7D06
        OR      08H     ; 8
J.7D06: PUSH    HL
        PUSH    DE
        PUSH    BC
        LD      BC,D.BFBC
        LD      DE,I$0070
        PUSH    DE
        CALL    DISINT
        DI
        LD      (D.BFB8),A
        LD      DE,0
        LD      A,(BC)
        ADD     A,A
        JP      P,J$005E
        RET     C
        DEC     E
        JP      NZ,J.004A
        DEC     D
        JP      NZ,J.004A
        POP     BC
        POP     BC
        POP     DE
        POP     HL
        JR      J$7D72

?.7D2E: LD      DE,D.BFBB
        JP      J$006A

?.7D34: LD      A,(BC)
        ADD     A,A
        RET     C
        JP      M,J.0064
        LD      A,(DE)
        LD      (HL),A
        INC     HL
        JP      J.0064

?.7D40: POP     BC
        POP     DE
        POP     HL
        EI
        CALL    ENAINT
        LD      A,(D.BFB8)
        AND     9CH
        JR      NZ,J$7D56
        DEC     B
        JR      Z,J$7D75
        CALL    C$00C2
        JR      J$7CEB

J$7D56: JP      M,J$00A2
        PUSH    AF
        CALL    C$00FF
        POP     AF
        DEC     E
        JR      NZ,J$7CF5
        LD      E,A
        BIT     4,E
        LD      A,08H
        JR      NZ,J.7D74
        BIT     3,E
        LD      A,04H
        JR      NZ,J.7D74
        LD      A,0CH
        JR      J.7D74

J$7D72: LD      A,02H
J.7D74: SCF
J$7D75: PUSH    HL
        PUSH    DE
        PUSH    BC
        PUSH    AF
        LD      A,(RAMAD2)
        LD      H,80H
        CALL    ENASLT
        CALL    ENAKRN
        EI
        LD      A,00H
        LD      H,40H
        CALL    ENASLT
        EI
        POP     AF
        POP     BC
        POP     DE
        POP     HL
        RET

?.7D92: CALL    C.0112
        INC     H
        INC     H
        LD      A,(D.BFBA)
        INC     A
        LD      (D.BFBA),A
        BIT     7,D
        JR      NZ,J$7DA5
        CP      9+1
        RET     C
J$7DA5: CP      8+1
        RET     C
        LD      A,01H   ; 1
        LD      (D.BFBA),A
        BIT     6,D
        JR      Z,J.7DBC
        BIT     2,D
        JR      NZ,J.7DBC
        SET     2,D
        LD      A,D
        LD      (D.BFBC),A
        RET

J.7DBC: RES     2,D
        LD      A,D
        LD      (D.BFBC),A
        INC     C
        CALL    C.0112
        LD      A,54H
        LD      (D.BFB8),A
        EX      (SP),HL
        EX      (SP),HL
        JR      J.7DE2

?.7DCF: BIT     0,E
        RET     NZ
        CALL    C.0119
        LD      A,C
        LD      (D.BFBB),A
        EX      (SP),HL
        EX      (SP),HL
        LD      A,14H
J$7DDD: LD      (D.BFB8),A
        EX      (SP),HL
        EX      (SP),HL
J.7DE2: LD      A,(D.BFB8)
        RRA
        JR      C,J.7DE2
        RET

?.7DE9: CALL    C.0112
        LD      A,00H
        JR      J$7DDD

I$7DF0: PUSH    HL
        PUSH    DE
        PUSH    BC
        CALL    GETSLT
        LD      (D$00CA),A
        LD      H,80H
        CALL    ENASLT
        EI
        LD      A,(RAMAD1)
        LD      H,40H
        CALL    ENASLT
        EI
        POP     BC
        POP     DE
        POP     HL
J$7E0B: DEC     HL
        LD      A,H
        ADD     A,02H
        INC     HL
        JP      M,J$00B9
        LD      E,15H
J$7E15: CALL    C.0126
        LD      A,0A0H
        BIT     6,D
        JR      Z,J.7E26
        OR      02H
        BIT     2,D
        JR      Z,J.7E26
        OR      08H
J.7E26: PUSH    HL
        PUSH    DE
        PUSH    BC
        LD      DE,I$0056
        PUSH    DE
        CALL    DISINT
        DI
        LD      (D.BFB8),A
        LD      BC,D.BFBC
        LD      DE,D.BFBB
        LD      A,(BC)
        ADD     A,A
        RET     C
        JP      M,J.004A
        LD      A,(HL)
        LD      (DE),A
        INC     HL
        JP      J.004A

?.7E46: POP     BC
        POP     DE
        POP     HL
        EI
        CALL    ENAINT
        LD      A,(D.BFB8)
        AND     0FCH
        JR      NZ,J$7E5C
        DEC     B
        JR      Z,J$7EA9
        CALL    C$00D6
        JR      J$7E0B

J$7E5C: JP      M,J$00B3
        BIT     6,A
        JR      NZ,J$7E82
        PUSH    AF
        CALL    C$0113
        POP     AF
        DEC     E
        JR      NZ,J$7E15
        LD      E,A
        BIT     5,E
        LD      A,10
        JR      NZ,J.7EA8
        BIT     4,E
        LD      A,8
        JR      NZ,J.7EA8
        BIT     3,E
        LD      A,4
        JR      NZ,J.7EA8
        LD      A,12
        JR      J.7EA8

J$7E82: LD      A,0D0H
        LD      (D.BFB8),A
        EX      (SP),HL
        EX      (SP),HL
        LD      A,80H
        LD      (D.BFB8),A
        EX      (SP),HL
        EX      (SP),HL
        LD      HL,D.BFBC
        LD      DE,0
        LD      A,(HL)
        ADD     A,A
        JR      C,J$7EA7
        JP      P,J$00B7
        DEC     DE
        LD      A,E
        OR      D
        JP      NZ,J$00A6
        LD      A,02H
        JR      J.7EA8

J$7EA7: XOR     A
J.7EA8: SCF
J$7EA9: PUSH    HL
        PUSH    DE
        PUSH    BC
        PUSH    AF
        LD      A,(RAMAD2)
        LD      H,80H
        CALL    ENASLT
        CALL    C.F368
        EI
        LD      A,00H
        LD      H,40H
        CALL    ENASLT
        EI
        POP     AF
        POP     BC
        POP     DE
        POP     HL
        RET

?.7EC6: CALL    C.0126
        INC     H
        INC     H
        LD      A,(D.BFBA)
        INC     A
        LD      (D.BFBA),A
        BIT     7,D
        JR      NZ,J$7ED9
        CP      9+1
        RET     C
J$7ED9: CP      8+1
        RET     C
        LD      A,1
        LD      (D.BFBA),A
        BIT     6,D
        JR      Z,J.7EF0
        BIT     2,D
        JR      NZ,J.7EF0
        SET     2,D
        LD      A,D
        LD      (D.BFBC),A
        RET

J.7EF0: RES     2,D
        LD      A,D
        LD      (D.BFBC),A
        INC     C
        CALL    C.0126
        LD      A,54H
        LD      (D.BFB8),A
        EX      (SP),HL
        EX      (SP),HL
        JR      J.7F16

?.7F03: BIT     0,E
        RET     NZ
        CALL    C$012D
        LD      A,C
        LD      (D.BFBB),A
        EX      (SP),HL
        EX      (SP),HL
        LD      A,14H   ; 20
J$7F11: LD      (D.BFB8),A
        EX      (SP),HL
        EX      (SP),HL
J.7F16: LD      A,(D.BFB8)
        RRA
        JR      C,J.7F16
        RET

?.7F1D: CALL    C.0126
        LD      A,00H
        JR      J$7F11

D7FB8   EQU     07FB8H                  ; WD2793
D7FB9   EQU     07FB9H                  ; WD2793
D7FBA   EQU     07FBAH                  ; WD2793
D7FBB   EQU     07FBBH                  ; WD2793
D7FBC   EQU     07FBCH                  ; INT,DRQ

D.BFB8  EQU     D7FB8+04000H
D.BFBA  EQU     D7FBA+04000H
D.BFBB  EQU     D7FBB+04000H
D.BFBC  EQU     D7FBC+04000H

        END
