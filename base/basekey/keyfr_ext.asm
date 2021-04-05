; This code is assembled at address $1B94. It is the continuation of the LPTCH0 subroutine. 
; This continuation varies depending on the language. In some cases, after this continuation
; ends, another language-specific code fragment is added. 

; The code of LPTCH0 is interrupted here.
; This ignores the katakama to hiragana mapping code from JAP version, directly jumping to LPTCHR below. 
        JR      LPTCHR

; After this, the remaining space is used to define the following subroutine.

;       Subroutine      handler DEAD key
;       Inputs          -
;       Outputs         ________________________

J1B96:  LD      A,(NEWKEY+6)
        LD      E,A
        OR      $FE            ; SHIFT key status (rest of bits 1)
        CPL
        INC     A
        LD      (KANAST),A      ; set DEAD status ($01-$02)
        JP      J0F64           ; make keyclick
