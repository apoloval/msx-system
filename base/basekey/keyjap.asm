; *************************************
; BEGIN OF JAPANSE KEYBOARD HANDLER
; *************************************

        EXTERN  CLIKSW

;       Table           scancode table
;       Remark          last scancode+1,execution address

I0DA5:  DEFB    $0A
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
        DEFW    C0F1F           ; key kana
        DEFB    $3A
        DEFW    C0EBB           ; keys f1,f2,f3,f4,f5
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

I0DC9:  DEFB    $FF
        DEFB    "!",$22,"#$%&'()"

;       Table           pointer to handler for keys a-z

I0DD3:  DEFW    C0F55                ; SHIFT + CTRL, put lettercode in keyboardbuffer
        DEFW    C0F55           ; CTRL, put lettercode in keyboardbuffer
        DEFW    C0E93           ; SHIFT
        DEFW    C0E95

;       Table           pointers to keycode tables for keys -,^,yen,@,[,;,:,],komma,.,/,_

I0DDB:  DEFW    D0E07-$0A      ; SHIFT + CTRL
        DEFW    D0DFB-$0A      ; CTRL
        DEFW    D0DEF-$0A      ; SHIFT
        DEFW    D0DE3-$0A

;       Table           keycodes for keys -,^,yen,@,[,;,:,],komma,.,/,_

D0DE3:  DEFB    "-^\@@[;:],./",$FF

;       Table           keycodes for keys -,^,yen,@,[,;,:,],komma,.,/,_ +SHIFT

D0DEF:  DEFB    "=~|`{+*}<>?_"

;       Table           keycodes for keys -,^,yen,@,[,;,:,],komma,.,/,_ +CTRL

D0DFB:  DEFB    "-",$1E,$1C,0,$1B,";:",$1D,",./",$FF

;       Table           keycodes for keys -,^,yen,@,[,;,:,],komma,.,/,_ +CTRL+SHIFT

D0E07:  DEFB    "=",$1E,$1C,0,$1B,"+*",$1D,"<>?",$1F

;       Table           keycodes for easily converted keys
;       Remark          scancodes $30-$57

D0E13:  DEFB    0,0,0,0,0,0,0,0
        DEFB    0,0,$1B,$09,0,$08,$18,$0D
        DEFB    " ",$0C,$12,$7F,$1D,$1E,$1F,$1C
        DEFB    "*","+","/","0","1","2","3","4"
        DEFB    "5","6","7","8","9","-",",","."

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

C0E67:  ADD     A,'0'
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

;       Subroutine      handler KANA key
;       Inputs          -
;       Outputs         ________________________

C0F1F:

        IF      MSXVER = 0

; #####################
; MSX 1 code: (0F1F-0F35)

        LD      HL,KANAST
        LD      A,(HL)
        CPL     
        LD      (HL),A                  ; toggle KANA mode
J0F29:  LD      A,15
        OUT     ($A0),A
        IN      A,($A2)
        AND     $7F
        LD      B,A                     ; PSG register 15 without KANA led bit
        LD      A,(HL)                  ; KANA status
        CPL
        AND     $80                     ; KANA led bit
        OR      B
        OUT     ($A1),A                ; change KANA led
        RET

        ELSE
        
; #####################
; MSX 2 and above have extension for the new SHIFT KANA mode
; there was too little space for all of the code.
; Therefore led code was moved to 111C, most of the KANA key code was placed
; here, remainer was placed at 0C25-0C3B

        LD      HL,MODE
        BIT     0,(HL)                  ; in SHIFT KANA mode ?
        JR      Z,J0F2C                 ; nope,
        XOR     A                       ; KANA led off
        RES     0,(HL)                  ; leave SHIFT KANA mode
J0F29:  JP      J111C                   ; change KANA led

J0F2C:  LD      A,(KANAST)
        INC     A                       ; KANA ON ?
        JP      Z,J0C36                 ; yes, KANA OFF
        JP      J0C25                   ; nope, KANA ON or SHIFT KANA mode

; #####################

        ENDIF

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

C0F55:

        IF      MSXVER = 0

; #####################
; MSX 1 code: (0F55-0F63)

        LD      HL,(PUTPNT)
        LD      (HL),A                  ; put in keyboardbuffer
        CALL    C10C2                   ; next postition in keyboardbuffer with roundtrip
        LD      A,(GETPNT)
        CP      L                       ; keyboard buffer full ?
        RET     Z                       ; yep, quit
        LD      (PUTPNT),HL             ; update put pointer

        ELSE

; #####################
; MSX 2 and above have code in subrom to handle the new SHIFT KANA mode

        POP     HL
        PUSH    HL
        LD      BC,I0EDD+3
        OR      A
        SBC     HL,BC                   ; called from functionkeyhandler ?
        LD      IX,S.PUTCHR
        JP      C029B                   ; put keycode in keyboardbuffer

; #####################

        ENDIF

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

J0F83:  LD      A,(KANAMD)
        AND     A                       ; ANSI layout ?
        LD      A,(NEWKEY+6)
        RRCA                            ; SHIFT key status in Cx
        JR      Z,J0F97                 ; yep, use ANSI layout
        LD      HL,I101D                ; assume JIS layout without SHIFT
        JR      C,J0F9F                 ; SHIFT not pressed, continue
        LD      HL,I104D                ; use JIS layout with SHIFT
        JR      J0F9F

J0F97:  LD      HL,I0FBD                ; assume ANSI layout without SHIFT
        JR      C,J0F9F                 ; SHIFT not pressed, continue
        LD      HL,I0FED                ; use ANSI layout with SHIFT
J0F9F:  LD      B,0
        ADD     HL,BC
        LD      BC,C0F55
        PUSH    BC                      ; put in keyboard buffer
        LD      A,(CAPST)
        AND     A
        LD      A,(HL)                  ; keycode
        RET     NZ                      ; CAPS lock active, quit
        CP      $A6                    ; keycodes $00-$A5 ?
        RET     C                       ; nope, keycode unchanged
        CP      $B0                    ; keycode $B0 ?
        RET     Z                       ; yep, keycode unchanged
        CP      $DE                    ; keycodes $DE-$FF ?
        RET     NC                      ; yep, keycode unchanged
        SUB     $20                     ; make lowercase
        CP      $A0                    ; good assumption ?
        RET     C                       ; yep, quit
        ADD     A,$40                   ; make uppercase
        RET     

;       Table           ANSI layout, without SHIFT (based on CAPS on)

I0FBD:  DEFB    $C9,$B1,$B2,$B3,$B4,$B5,$C5,$C6
        DEFB    $C7,$C8,$D7,$D8,$D9,$DA,$DB,$D3
        DEFB    $DE,$DF,$D6,$DC,$A6,$DD,$BB,$C4
        DEFB    $C2,$BD,$B8,$BE,$BF,$CF,$CC,$D0
        DEFB    $D1,$D2,$D5,$D4,$CD,$CE,$B6,$B9
        DEFB    $BC,$BA,$CB,$C3,$B7,$C1,$CA,$C0

;       Table           ANSI layout, with SHIFT (based on CAPS on)

I0FED:  DEFB    $C9,$A7,$A8,$A9,$AA,$AB,$C5,$C6
        DEFB    $C7,$C8,$D7,$D8,$D9,$DA,$A2,$D3
        DEFB    $B0,$A3,$AE,$A4,$A1,$A5,$BB,$C4
        DEFB    $AF,$BD,$B8,$BE,$BF,$CF,$CC,$D0
        DEFB    $D1,$D2,$AD,$AC,$CD,$CE,$B6,$B9
        DEFB    $BC,$BA,$CB,$C3,$B7,$C1,$CA,$C0

;       Table           JIS layout, without SHIFT (based on CAPS on)

I101D:  DEFB    $DC,$C7,$CC,$B1,$B3,$B4,$B5,$D4
        DEFB    $D5,$D6,$CE,$CD,$B0,$DE,$DF,$DA
        DEFB    $B9,$D1,$C8,$D9,$D2,$DB,$C1,$BA
        DEFB    $BF,$BC,$B2,$CA,$B7,$B8,$C6,$CF
        DEFB    $C9,$D8,$D3,$D0,$D7,$BE,$C0,$BD
        DEFB    $C4,$B6,$C5,$CB,$C3,$BB,$DD,$C2

;       Table           JIS layout, with SHIFT (based on CAPS on)

I104D:  DEFB    $A6,$C7,$CC,$A7,$A9,$AA,$AB,$AC
        DEFB    $AD,$AE,$CE,$CD,$B0,$DE,$A2,$DA
        DEFB    $B9,$A3,$A4,$A1,$A5,$DB,$C1,$BA
        DEFB    $BF,$BC,$A8,$CA,$B7,$B8,$C6,$CF
        DEFB    $C9,$D8,$D3,$D0,$D7,$BE,$C0,$BD
        DEFB    $C4,$B6,$C5,$CB,$C3,$BB,$DD,$AF

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

I1092:  DEFB    "O" ,"G" ,"A" ,"B" ,"C" ,"D" ,"E" ,"F"
        DEFB    "M" ,"N" ,"W" ,$00,"I" ,$00,$84,$82
        DEFB    $81,$85,"_" ,"]" ,$80,$83,$00,"["
        DEFB    "Z" ,"T" ,"X" ,"U" ,"S" ,"J" ,"V" ,$00
        DEFB    $00,"^" ,"K" ,$00,$00,"P" ,$00,"R"
        DEFB    "L" ,"Y" ,$00,"Q" ,$00,$5C,"H" ,$00



; *************************************
; END OF JAPANSE KEYBOARD HANDLER
; *************************************
