; *************************************
; BEGIN OF KOREAN KEYBOARD HANDLER
; *************************************
;
J01A4   EQU     $01A4                ; call hangul rom
C141F   EQU     $141F                ; path
J63E6   EQU     $63E6                ; execute STOP statement
C7B3E   EQU     $7B3E                ; patch routine for extra pad numbers

;       Table           scancode table
;       Remark          last scancode+1,execution address

I0DA5:  DEFB    $A
        DEFW    C0E67           ; keys 0,1,2,3,4,5,6,7,8,9
        DEFB    $16
        DEFW    C0EA1           ; keys -,^,yen,@,[,;,:,],komma,.,/,_
        DEFB    $30
        DEFW    C0E7E           ; keys a,b,c,d,e,f,g,h,i,j,k,l,m,n,o,p,q,r,s,t,u,v,w,x,y,z
        DEFB    $33
        DEFW    C0F10           ; keys shift,ctrl,graph
        DEFB    $34
        DEFW    C0F36           ; key caps
        DEFB    $35
        DEFB    C0F1F           ; key kana
        DEFB    $3A
        DEFW    C1438           ; keys f1,f2,f3,f4,f5
        DEFB    $3C
        DEFW    C0F10           ; keys esc,tab
        DEFB    $3D
        DEFW    C0F46           ; key stop
        DEFB    $41
        DEFW    C0F10           ; keys bs,select,return,space
        DEFB    $42
        DEFW    C0F06           ; home
        DEFB    $FF
        DEFW    C0F10           ; ins,del,left,up,down,right, numeric pad

;       Table           keycodes for numeric keys+SHIFT

I0DC9:  DEFB    $FF,$21,$22,$23,$24,$25,$26,$27
        DEFB    $28,$29

;       Table           pointer to handler for keys a-z

I0DD3:  DEFW    C$0F55          ; SHIFT + CTRL
        DEFW    C$0F55          ; CTRL
        DEFW    C$0E93          ; SHIFT
        DEFW    C$0E95          ; normal


; - ^ yen @ [ ; : ] komma . / _ table

I0DDB:  DEFW    D$0E07-10
        DEFW    D$0DFB-10
        DEFW    D$0DEF-10
        DEFW    D$0DE3-10

;       Table           keycodes for keys -,^,yen,@,[,;,:,],komma,.,/,_

D0DE3:  DEFB    $2D,$5E,$5C,$40,$5B,$3B,$3A,$5D,$2C,$2E,$2F,$FF

;       Table           keycodes for keys -,^,yen,@,[,;,:,],komma,.,/,_ +SHIFT

D0DEF:  DEFB    $3D,$7E,$7C,$60,$7B,$2B,$2A,$7D,$3C,$3E,$3F,$5F

;       Table           keycodes for keys -,^,yen,@,[,;,:,],komma,.,/,_ +CTRL 

D0DFB:  DEFB    $2D,$1E,$1C,$0,$1B,$3B,$3A,$1D,$2C,$2E,$2F,$FF

;       Table           keycodes for keys -,^,yen,@,[,;,:,],komma,.,/,_ +CTRL+SHIFT 

D0E07:  DEFB    $3D,$1E,$1C,$0,$1B,$2B,$2A,$1D,$3C,$3E,$3F,$1F

;       Table           keycodes for easily converted keys
;       Remark          scancodes $30-$57

I0E13:  DEFB    $00,$00,$00,$00,$00,$00,$00,$00
        DEFB    $00,$00,$1B,$09,$00,$08,$18,$0D
        DEFB    $20,$0C,$12,$7F,$1D,$1E,$1F,$1C
        DEFB    $2A,$2B,$2F,$30,$31,$32,$33,$34
        DEFB    $35,$36,$37,$38,$39,$2D,$2C,$2E

;       Subroutine      K_HAND (not offical name)
;       Inputs          C = scancode
;       Outputs         ________________________

K_HAND: LD      A,C
        CP      $FF
        RET     Z                       ; scancode $FF, quit
        LD      HL,I0DA5
        CALL    H_KEYC
        CP      $30
        JR      NC,J0E5C                ; scancodes $30-$FE are handled directly
        LD      A,(NEWKEY+6)
        RRCA    
        RRCA    
        JR      NC,J0E5B                ; CTRL pressed, handle directly
        RRCA    
        JP      NC,J107D                ; GRAPH pressed, handle graphic keycodes
        LD      A,(KANAST)
        AND     A
        JP      NZ,J0F83                ; KANA on, handle kana keycodes
J0E5B:  LD      A,C
J0E5C:  CP      (HL)                    ; scancode handled by this entry ?
        INC     HL
        LD      E,(HL)
        INC     HL
        LD      D,(HL)                  ; handler
        INC     HL
        PUSH    DE
        RET     C                       ; yep, continue in handler
        POP     DE
        JR      J0E5C                   ; next

;       Subroutine      handler keys 0,1,2,3,4,5,6,7,8,9
;       Inputs          A = C = scancode ($00-$09)
;       Outputs         ________________________

C0E67:  ADD     A,"0"
        LD      B,A                     ; keycode number
        LD      A,(NEWKEY+6)
        RRCA                            ; SHIFT pressed ?
        LD      A,B
        JR      C,J0E7B                 ; no, put keycode in keyboardbuffer and quit
        LD      B,0
        LD      HL,I0DC9
        ADD     HL,BC
        LD      A,(HL)
        CP      $FF                    ; keycode for this combination ?
        RET     Z                       ; nope, quit
J0E7B:  JP      C0F55                   ; put in keyboardbuffer and quit

;       Subroutine      handler keys a-z
;       Inputs          C = scancode ($16-$2F)
;       Outputs         ________________________

C0E7E:  LD      A,(NEWKEY+6)
        AND     $3                     ; SHIFT + CTRL status
        ADD     A,A
        LD      E,A
        LD      D,0
        LD      HL,I0DD3
        ADD     HL,DE
        LD      A,(HL)
        INC     HL
        LD      H,(HL)
        LD      L,A                     ; handler for SHIFT + CTRL combination
        LD      A,C                     ; scancode
        SUB     $15                     ; code $01-$1A
        JP      (HL)

;       Subroutine      handler keys a-z, SHIFT pressed, CTRL not pressed
;       Inputs          A = lettercode ($01-$1A)
;       Outputs         ________________________

C0E93:  ADD     A,$20                   ; adjust for lowercase

;       Subroutine      handler keys a-z, SHIFT and CTRL not pressed
;       Inputs          A = lettercode ($01-$1A)
;       Outputs         ________________________

C0E95:  LD      B,A
        LD      A,(CAPST)
        CPL     
        AND     $20                     ; CAPS lock ?
        XOR     B                       ; yep, switch case; nope, keep case
        ADD     A,$40                   ; to keycode
        JR      J0E7B                   ; put in keyboardbuffer and quit

;       Subroutine      handler keys -,^,yen,@,[,;,:,],komma,.,/,_
;       Inputs          C = scancode ($0A-$15)
;       Outputs         ________________________

C0EA1:  LD      HL,I0DDB
        LD      A,(NEWKEY+6)
        AND     $3                     ; SHIFT + CTRL status
        ADD     A,A
        LD      E,A
        LD      D,0
        ADD     HL,DE
        LD      A,(HL)
        INC     HL
        LD      H,(HL)
        LD      L,A                     ; keycode table for SHIFT + CTRL combination
        LD      E,C                     ; scancode
        ADD     HL,DE
        LD      A,(HL)
        CP      $FF                    ; keycode for this combination ?
        JP      NZ,C0F55                ; yep, put in keyboardbuffer
        RET

;       Subroutine      handler functionkeys
;       Inputs          C = scancode ($35-$39)
;       Outputs         ________________________

C0EBB:  LD      A,(NEWKEY+6)
        RRCA                            ; SHIFT key pressed ?
        JR      C,J0EC5                 ; nope, F1-F5
        LD      A,C
        ADD     A,5
        LD      C,A                     ; yep, F6-F10
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
I0EDD:  CALL    C0F55                       ; put keycode in keyboardbuffer
        INC     DE
        JR      J0EDA                   ; next

J0EE3:  LD      HL,(CURLIN)
        INC     HL
        LD      A,H
        OR      L                       ; interpreter in direct mode ?
        JR      Z,J0ED0                 ; yep, normal behavior
        LD      HL,TRPTBL+0*3-$35*3
        ADD     HL,DE
        ADD     HL,DE
        ADD     HL,DE

;         Subroutine raise trap
;            Inputs  ________________________
;            Outputs ________________________

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

C0F06:  LD      A,(NEWKEY+6)
        RRCA                            ; SHIFT key status
        LD      A,$C                   ; assume SHIFT-HOME -> CLS keycode
        SBC     A,0                     ; no SHIFT pressed -> HOME keycode
        JR      C0F55                   ; put keycode in keyboardbuffer

;       Subroutine      handler easily converted keys
;       Inputs          A = scancode ($30-$15)
;       Outputs         ________________________

C0F10:  CALL    H_KEYA
        LD      E,A
        LD      D,0
        LD      HL,D0E13-$30
        ADD     HL,DE
        LD      A,(HL)
        AND     A                       ; keycode for key ?
        RET     Z                       ; nope, quit
        JR      C0F55                   ; put keycode in keyboardbuffer


;         Subroutine handler KANA key
;            Inputs  ________________________
;            Outputs ________________________

C0F1F:  LD      HL,KANAST
        LD      A,(HL)
        CPL     
        LD      (HL),A
        LD      A,$F
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
        
;       Subroutine      handler CAPS key
;       Inputs          -
;       Outputs         ________________________

C0F36:  LD      HL,CAPST
        LD      A,(HL)
        CPL
        LD      (HL),A                  ; toggle CAPS status
        CPL                             ; adjust for CHGCAP and change CAPS led

;       Subroutine      CHGCAP
;       Inputs          ________________________
;       Outputs         ________________________
;       Remark          entrypoint compatible with MSX1

K_BCAP: AND     A
        LD      A,$C
        JR      Z,J0F43
        INC     A
J0F43:  OUT     ($AB),A
        RET     

;       Subroutine      handler STOP key
;       Inputs          -
;       Outputs         ________________________
;       Remark          entrypoint compatible with MSX1

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
;       Remark          entrypoint compatible with MSX1

C0F55:  LD      HL,(PUTPNT)
        LD      (HL),A
        CALL    C10C2
        LD      A,(GETPNT)
        CP      L
        RET     Z
        LD      (PUTPNT),HL

;       Subroutine      make keyclick
;       Inputs          -
;       Outputs         ________________________
;       Remark          entrypoint compatible with MSX1

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
;       Remark          entrypoint compatible with MSX1

K_BSND: AND     A
        LD      A,$E
        JR      Z,J0F80
        INC     A
J0F80:  OUT     ($AB),A
        RET

;       Subroutine      handle scancodes when KANA is on (and GRAPH and CTRL are not pressed)
;       Inputs          C = scancode ($00-$2F)
;       Outputs         ________________________

J0F83:  LD      A,(NEWKEY+6)
        RRCA                            ; SHIFT key status in Cx
        LD      HL,I0FA6
        JR      C,J0F8F                 ; SHIFT not pressed, use normal layout
        LD      HL,I0FD6                ; use shift layout
J0F8F:  LD      B,0
        ADD     HL,BC
        LD      A,(HL)                  ; has keycode ?
        AND     A
        RET     Z                       ; nope, quit
        JP      C0F55                   ; put in keyboard buffer

;       Patch           for STOP korean
;       Inputs          
;       Outputs         ________________________

J0F98:  PUSH    HL
        CALL    C141F                   ; patch routine
        POP     HL
        XOR     A
        LD      SP,(SAVSTK)
        PUSH    BC
        JP      J63E6

;       Table           layout, without SHIFT (based on CAPS on)

I0FA6:  DEFB    $30,$31,$32,$33,$34,$35,$36,$37
        DEFB    $38,$39,$2D,$5E,$5C,$40,$5B,$3B
        DEFB    $3A,$5D,$2C,$2E,$2F,$0,$8C,$A4
        DEFB    $94,$91,$89,$8B,$98,$A1,$9B,$9D
        DEFB    $99,$A6,$A5,$A3,$9A,$9E,$8D,$86
        DEFB    $88,$8F,$9F,$97,$92,$96,$A2,$95

;       Table           layout, with SHIFT (based on CAPS on)

I0FD6:  DEFB    $0,$21,$22,$23,$24,$25,$26,$27
        DEFB    $28,$29,$3D,$7E,$7C,$60,$7B,$2B
        DEFB    $2A,$7D,$3C,$3E,$3F,$5F,$0,$0
        DEFB    $0,$0,$8A,$0,$0,$0,$0,$0
        DEFB    $0,$0,$0,$0,$9C,$A0,$8E,$87
        DEFB    $0,$90,$0,$0,$93,$0,$0,$0

;       Subroutine      korean BIOS routine $0186
;       Inputs          
;       Outputs         ________________________

J1006:  CALL    C1070                       ; hangul rom available ?
        RET     Z                       ; nope, quit
        PUSH    IX
        LD      IX,$4023
        JR      J103C

;       Subroutine      korean BIOS routine $0189
;       Inputs          
;       Outputs         ________________________

J1012:  CALL    C1070                       ; hangul rom available ?
        RET     Z                       ; nope, quit
        PUSH    IX
        LD      IX,$4026
        JR      J103C

;       Subroutine      korean BIOS routine $018C
;       Inputs          
;       Outputs         ________________________

J101E:  CALL    C1070                       ; hangul rom available ?
        RET     Z                       ; nope, quit
        PUSH    IX
        LD      IX,$4032
        JR      J103C

;       Subroutine      korean BIOS routine $018F
;       Inputs          
;       Outputs         ________________________

J102A:  CALL    C1070                       ; hangul rom available ?
        RET     Z                       ; nope, quit
        PUSH    IX
        LD      IX,$402C
        JR      J103C

;       Subroutine      korean BIOS routine $0192
;       Inputs          
;       Outputs         ________________________

J1036:  PUSH    IX
        LD      IX,$4029
J103C:  JP      J01A4

;       Patch           for reading mouse/lightpen switch
;       Inputs          
;       Outputs         ________________________
;       Remark          korean does this via V9948 VDP

J103F:  LD      A,1
        DI      
        OUT     ($99),A
        LD      A,$8F
        OUT     ($99),A                 ; VDP(15)=1
        IN      A,($99)                 : status register
        PUSH    AF
        XOR     A
        OUT     ($99),A
        LD      A,$8F
        OUT     ($99),A                 ; VDP(15)=0
        POP     AF
        BIT     7,A                     ; FL (mouse/lightpen switch)
        JR      Z,J105C
        LD      HL,XSAVE+1
        SET     7,(HL)
J105C:  IN      A,($99)
        AND     A
        RET     

;       Patch           for PAD function
;       Inputs          
;       Outputs         ________________________
;       Remark          for korean lightpen

J1060:  CP      $14                     ; pad 20 or above ?
        JR      NC,J1068                ; yep, handle differently
J1064:  CALL    C7B3E                       ; patch routine for extra pad numbers
        RET     

J1068:  CP      $18                     ; pad 24 or above ?
        JR      NC,J1064                ; yep, handle normaly
        SUB     $C                     ; range 20-23 = range 8-11 (lightpen)
        JR      J1064

;         Subroutine hangul rom available ?
;            Inputs  ________________________
;            Outputs ________________________

C1070:  PUSH    BC
        LD      B,A
        LD      A,(SLTWRK+4)            ; slotid hangul rom
        CP      0
        LD      A,B
        POP     BC
        RET     

        DEFS    $107D-$,0               ; unused space

;       Subroutine      handle scancodes $00-$2F with GRAPH key pressed
;       Inputs          C = scancode
;       Outputs         ________________________

J107D:  LD      B,0
        LD      HL,I1092
        ADD     HL,BC
        LD      A,(HL)                  ; keycode
        AND     A
        RET     Z                       ; no keycode, quit
        CP      $80                     ; keycodes $01-$7F ?
        PUSH    AF
        LD      A,1
        CALL    C,C0F55                 ; yep, put MSX header keycode in keyboard buffer
        POP     AF
        JP      C0F55                   ; put keycode in keyboard buffer

;       Table           keycodes for scancodes $00-$2F with GRAPH pressed
;       $00            no keycode
;       $01-$7F       keycode 1 + keycode (special MSX graphic character)
;       $80-$FF       keycode

I1092:  DEFB    $0,$0,$0,$0,$0,$0,$0,$0
        DEFB    $0,$0,$57,$0,$0,$0,$84,$82
        DEFB    $81,$85,$0,$0,$80,$83,$0,$5B
        DEFB    $5A,$54,$58,$55,$53,$0,$56,$0
        DEFB    $0,$0,$0,$0,$0,$50,$0,$52
        DEFB    $0,$59,$0,$51,$0,$5C,$0,$0

; *************************************
; END OF KOREAN KEYBOARD HANDLER
; *************************************
