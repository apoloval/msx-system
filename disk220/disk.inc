

; DOS2 compile options




DOS2	EQU	1		; DOS2 flag for diskdriver
USESBF	EQU	0		; use buffer for screen output
MSXJE	EQU	0		; MSX-JE in DOS2 bank 3
DOS1	EQU	0		; DOS1 in DOS2 bank 3

BNKADR	EQU	07FFEH

BNKCHG	MACRO

	LD	(BNKADR),A

	ENDM
