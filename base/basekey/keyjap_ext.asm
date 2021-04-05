; This code is assembled at address $1B94. It is the continuation of the LPTCH0 subroutine. 
; This continuation varies depending on the language. In some cases, after this continuation
; ends, another language-specific code fragment is added. 

; For this Japanese version, LPTCH0 just continues as follows:
        AND     A
        JP      P,J1BAC                 ; plain ascii, print
        CP      $86
        JR      C,J1BB7                 ; $80-$85, print space
        CP      $A0                    ; $86-$9F ?
        JR      NC,J1BA4                ; nope,
        ADD     A,$20
        JR      J1BAC                   ; adjust to $A6-$BF and print

J1BA4:  CP      $E0                    ; $E0-$FF ?
        JR      C,J1BAC                 ; nope, print
        SUB     $20                     ; adjust to $C0-$DF
        DEFB    $38                    ; JR C,xxxx (skip next instruction, effective jump to LPTCHR)
