; This code is assembled at address $1B94. It is the continuation of the LPTCH0 subroutine. 
; This continuation varies depending on the language. In some cases, after this continuation
; ends, another language-specific code fragment is added. 

; The code of LPTCH0 is interrupted here.
; This ignores the katakama to hiragana mapping code from JAP version, directly jumping to LPTCHR below. 
        JR      LPTCHR

;       Table           scancode table
;       Remark          last scancode+1,low byte execution address

KYJTAB:
I1B96:  DEFB    $30, $00FF & C0F83 ; scancodes $00-$2F
        DEFB    $33, $00FF & C0F10 ; SHIFT,CTRL,GRAPH
        DEFB    $34, $00FF & C0F36 ; CAPS
        DEFB    $35, $00FF & C0F10 ; CODE
        DEFB    $3A, $00FF & C0FC3 ; F1,F2,F3,F4,F5
        DEFB    $3C, $00FF & C0F10 ; ESC,TAB
        DEFB    $3D, $00FF & C0F46 ; STOP
        DEFB    $41, $00FF & C0F10 ; BS,SELECT,RETURN,SPACE
        DEFB    $42, $00FF & C0F06 ; HOME
        DEFB    $FF, $00FF & C0F10 ; ins,del,left,up,down,right, numeric pad

