

; DOS2 compile options




DOS2	EQU	1		; DOS2 flag for diskdriver
USESBF	EQU	0		; use buffer for screen output
BNKADR	EQU	07FFEH

BNKCHG	MACRO

	LD	(BNKADR),A

	ENDM
