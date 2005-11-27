

; DOS2 compile options



TURBOR	EQU	0		; create special MSX Turbo-R version

DOS2	EQU	1		; DOS2 flag for diskdriver
USESBF	EQU	0		; use buffer for screen output

BNKCHG	MACRO

	LD	(06000H),A

	ENDM
