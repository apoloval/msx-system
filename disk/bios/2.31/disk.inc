

; DOS2 compile options



TURBOR	EQU	1		; create special MSX Turbo-R version
BNKADR	EQU 06000H	; Bank switch address (non Turbo-R version)

USESBF	EQU	0		; use buffer for screen output

		IF TURBOR EQ 1

BNKCHG	MACRO
		LD	(07FF0H),A
		ENDM

		ELSE

BNKCHG	MACRO
		LD	(BNKADR),A
		ENDM

		ENDIF
