;
;   NMS8260 -> Source re-created by Z80DIS 2.2
;      Z80DIS was written by Kenneth Gielow
;                            Palo Alto, CA
        .Z80
        ORG	7405H
CALSLT	EQU	001CH	; -C---
ENASLT	EQU	0024H	; -C---
CHPUT	EQU	00A2H	; ----I
BEEP	EQU	00C0H	; ----I
SNSMAT	EQU	0141H	; ----I
J$4022	EQU	4022H	; J----

; +00   drive + cylinder
; +01   track + sector (H)
; +02   sector (L)
; +03   number of sectors
; +04   operation
; +05   number of sectors left
; +06   slotid interface
; +07   sector number
; +09
; +10   start of workspace
; +12   drive (format)
; +13   track (format)


MYSIZE	EQU	49
SECLEN	EQU	512

I$7405:	DEFB	0F0H
        DEFW	512
        DEFB	0FH
        DEFB	04H
        DEFB	1FH
        DEFB	06H
        DEFW	13
        DEFB	2
        DEFB	254
        DEFW	34
        DEFW	653
        DEFB	2
        DEFW	17

DEFDPB	EQU	I$7405-1

INIHRD:	JP	J$7454
DRIVES:	JP	J$7432
INIENV:	JP	J$7442
DSKIO:	JP	C.74C5
DSKCHG:	JP	J$7443
GETDPB:	JP	J$7447
CHOICE:	JP	J$76B0
DSKFMT:	JP	J$7785
OEMSTA:	JP	J$7452

;	  Subroutine DRIVES
;	     Inputs  ________________________
;	     Outputs ________________________

J$7432:	PUSH	BC
        LD	L,1
        CALL	C.7981			; port 07EH
        IN	H,(C)
        BIT	1,H			; second drive connected ?
        JR	NZ,J$7440		; nope, return 1 drive
        LD	L,2			; return 2 drives
J$7440:	POP	BC
        RET

;	  Subroutine INIENV
;	     Inputs  ________________________
;	     Outputs ________________________

J$7442:	RET

;	  Subroutine DSKCHG
;	     Inputs  ________________________
;	     Outputs ________________________

J$7443:	LD	B,1			; disk unchanged
        AND	A
MTOFF:	RET

;	  Subroutine GETDPB
;	     Inputs  ________________________
;	     Outputs ________________________

J$7447:	EX	DE,HL
        INC	DE
        LD	BC,18
        LD	HL,I$7405
        LDIR
        RET

;	  Subroutine OEMSTA
;	     Inputs  ________________________
;	     Outputs ________________________

J$7452:	SCF
        RET

;	  Subroutine INIHRD
;	     Inputs  ________________________
;	     Outputs ________________________

J$7454:	CALL	C$7B25			; welcome
        DI
J$7458:	CALL	C.7947
        JR	C,J.7489
        CALL	C$79D4
        JR	C,J.7489

        LD	D,00H
        CALL	C.79FE
        JR	C,J.7489
        LD	D,00H
        CALL	C.7A3B
        JR	C,J.7489
        CALL	C.7981			; port 07EH
        IN	A,(C)
        BIT	1,A			; second drive connected ?
        JR	NZ,J.7487		; nope, quit

J$7479:	LD	D,20H
        CALL	C.79FE
        JR	C,J.74A5
        LD	D,20H
        CALL	C.7A3B
        JR	C,J.74A5
J.7487:	EI
        RET

J.7489:	BIT	6,A
        JR	Z,J$7492
        PUSH	AF
        CALL	C.7947
        POP	AF
J$7492:	CALL	C.7BD4			; print number
        LD	HL,I$7B8D               ; HDD system error
        CALL	C.7B28			; print string
        CALL	C.7BEF			; beep
        CALL	C.7BFB			; wait for Y or N key
        JR	C,J$7458		; Y, retry
        JR	J.7487			; N, quit

J.74A5:	BIT	6,A
        JR	Z,J$74AC
        CALL	C.7947
J$74AC:	CALL	C.7BD4			; print number
        LD	HL,I$7BB4               ; 2nd HD error
        CALL	C.7B28			; print string
        LD	HL,I$7BA3               ; retry
        CALL	C.7B28			; print string
        CALL	C.7BEF			; beep
        CALL	C.7BFB			; wait for Y or N key
        JR	C,J$7479		; Y, retry
        JR	J.7487			; N, quit

;	  Subroutine DSKIO
;	     Inputs  ________________________
;	     Outputs ________________________

C.74C5:	PUSH	HL
        PUSH	AF
        PUSH	BC
        CALL	GETWRK
        POP	BC
        LD	(IX+7),D
        LD	(IX+8),E		; start sector
        LD	(IX+3),B		; number of sectors
        LD	(IX+5),B		; number of sectors
        POP	AF
        PUSH	AF
        RRC	A
        RRC	A
        RRC	A
        LD	(IX+0),A		; drivenumber in b5 ?
        LD	A,0F0H
        CP	C			; correct mediadescriptor ?
        JR	NZ,J$74F1		; nope, quit with error
        CALL	C.74F6
        POP	AF
        POP	HL
        JR	NC,J$751F		; sector read
        JR	J$7525			; sector write

J$74F1:	POP	AF
        POP	HL
        JP	J.75E8			; other error

;	  Subroutine __________________________
;	     Inputs  ________________________
;	     Outputs ________________________

C.74F6:	PUSH	DE
        POP	BC
        LD	DE,17
        CALL	DIV16
        LD	(IX+1),L		; track
        LD	DE,2
        CALL	DIV16
        LD	A,L			; cylinder
        OR	(IX+0)
        LD	(IX+0),A		; combine with drive
        LD	(IX+2),C		; sector (b0-b7)
        LD	A,B
        RLCA
        RLCA
        RLCA
        RLCA
        RLCA
        RLCA				; sector (b8,b9)
        OR	(IX+1)
        LD	(IX+1),A		; combine with track
        RET

;	  Subroutine Read sectors
;	     Inputs  ________________________
;	     Outputs ________________________

J$751F:	LD	(IX+4),08H		; operation read sector
        JR	J.7538

;	  Subroutine Write sectors
;	     Inputs  ________________________
;	     Outputs ________________________

J$7525:	CALL	C.7981			; port 07EH
        IN	A,(C)
        BIT	2,A
        JR	Z,J$7534		; write protect error
        LD	(IX+4),0AH		; operation write sector
        JR	J.7538

J$7534:	XOR	A			; WRITE PROTECT error
        JP	J.75EA

J.7538:	PUSH	HL
        CALL	C.7984			; port 07FH
        XOR	A
        OUT	(C),A
        LD	B,(IX+3)		; number of sectors
        LD	C,(IX+4)		; operation
        LD	D,(IX+0)		; drive + cylinder
        LD	H,(IX+1)		; track + sector (H)
        LD	L,(IX+2)		; sector (L)
        CALL	C.7A4A
        JR	C,J.758C		; error,
        LD	BC,L767D
        LD	HL,I$767D
        LD	DE,(_SECBUF)
        LDIR				; i/o routine in _SECBUF
        CALL	GETSLT
        LD	(IX+6),A		; slotid of this diskrom
        POP	HL

J$7566:	PUSH	HL
        LD	L,1EH
J$7569:	LD	H,0FFH
J$756B:	LD	B,0FFH
J$756D:	CALL	C.797E			; port 07DH
        IN	A,(C)
        AND	0FH	; 15
        BIT	3,A
        JR	Z,J.758C
        CP	0FH	; 15
        JR	Z,J$75CC
        CP	0BH	; 11
        JR	Z,J$758F
        CP	09H	; 9
        JR	Z,J$7593
        DJNZ	J$756D
        DEC	H
        JR	NZ,J$756B
        DEC	L
        JR	NZ,J$7569
J.758C:	POP	HL
        JR	J.75E5

J$758F:	LD	B,1			; read
        JR	J$7595

J$7593:	LD	B,0			; write
J$7595:	CALL	C.797B			; port 07CH
        POP	HL
        LD	A,L
        ADD	A,LOW 512-1
        LD	A,H
        ADC	A,HIGH 512-1
        CP	40H			; transfer in page 0 ?
        JR	C,J.75B3		; yep, use I/O routine in ROM
        LD	A,H
        AND	A			; transfer in page 2 or 3 ?
        JP	M,J.75B3		; yep, use I/O routine in ROM
        CALL	C$75AD			; use I/O routine in _SECBUF
        JR	J.75C5

;	  Subroutine __________________________
;	     Inputs  ________________________
;	     Outputs ________________________

C$75AD:	LD	IY,(_SECBUF)
        JP	(IY)

J.75B3:	BIT	0,B			; write sector ?
        JR	Z,J$75BF		; yep,
        LD	B,0
        INIR
        INIR
        JR	J.75C5

J$75BF:	LD	B,0
        OTIR
        OTIR
J.75C5:	DEC	(IX+5)			; more sectors ?
        JR	Z,J$75CD		; nope,
        JR	J$7566			; yep, next

J$75CC:	POP	HL
J$75CD:	PUSH	HL
        CALL	C.7ABF
        POP	HL
        JR	C,J.75E5
        JR	Z,J$7652
        LD	A,(IX+0)
        AND	20H			; drive
        LD	D,A
        PUSH	HL
        CALL	C.7AE0
        POP	HL
        JR	C,J.75E5
        JR	J$75EF

J.75E5:	CALL	C.7947
J.75E8:	LD	A,0CH			; OTHER error
J.75EA:	LD	B,(IX+5)
        SCF
J.75EE:	RET

J$75EF:	CP	18H
        JR	Z,J$7621
J$75F3:	CP	04H
        JR	Z,J$760D		; not ready error
        CP	11H
        JR	Z,J$7611		; data error
        CP	03H
        JR	Z,J$7615		; write fault
        CP	12H
        JR	Z,J.7619		; record not found error
        CP	21H
        JR	Z,J.7619		; record not found error
        AND	0F0H
        JR	Z,J$761D		; seek error
        JR	J.75E8			; other error

J$760D:	LD	A,02H			; NOT READY error
        JR	J.75EA

J$7611:	LD	A,04H			; DATA error
        JR	J.75EA

J$7615:	LD	A,0AH			; WRITE FAULT error
        JR	J.75EA

J.7619:	LD	A,08H 			; RECORD NOT FOUND error
        JR	J.75EA

J$761D:	LD	A,06H			; SEEK error
        JR	J.75EA

J$7621:	LD	A,(IX+4)
        CP	08H			; sector read ?
        JR	NZ,J.75E8		; nope, other error
        LD	D,(IX+7)
        LD	E,(IX+8)		; sectornumber
        LD	A,(IX+5)
        AND	A			; sectors remaining ?
        JR	Z,J.75EE		; nope, quit
        LD	C,A
        LD	A,(IX+3)		; number of sectors
        SUB	C
        LD	B,A
J$763A:	INC	DE
        DJNZ	J$763A
        LD	B,(IX+5)
        LD	C,0F0H			; mediadescriptor
        LD	A,(IX+0)
        AND	20H			; drive 0 ?
        JR	Z,J$764F		; yep,
        LD	A,1			; second HDD
J$764B:	AND	A
        JP	C.74C5			; read sector

J$764F:	XOR	A			; first HDD
        JR	J$764B

J$7652:	LD	A,(IX+4)
        CP	0AH			; sector write ?
        JR	Z,J$765C		; yep,
J.7659:	AND	A
        JR	J.75EE
J$765C:	LD	A,(RAWFLG)
        AND	A			; verify ?
        JR	Z,J.7659		; nope, quit
        LD	C,05H			; operation
        LD	B,(IX+3)		; number of sectors
        LD	D,(IX+0)		; drive + cylinder
        LD	H,(IX+1)		; track + sector (H)
        LD	L,(IX+2)		; sector (L)
        CALL	C.79E3
        JR	NC,J.7659
        BIT	6,A
        JP	Z,J$75F3
        JP	J.75E5

I$767D:	PUSH	IX
        PUSH	HL
        PUSH	BC
        LD	HL,04000H
        LD	A,(RAMAD1)
        CALL	ENASLT
        POP	BC
        POP	HL
        BIT	0,B
        JR	Z,J$7698
        LD	B,0
        INIR
        INIR
        JR	J$769E

J$7698:	LD	B,0
        OTIR
        OTIR
J$769E:	POP	IX
        PUSH	IX
        PUSH	HL
        LD	A,(IX+6)
        LD	HL,04000H
        CALL	ENASLT
        POP	HL
        POP	IX
        RET

L767D	EQU	$-I$767D

;	  Subroutine CHOICE
;	     Inputs  ________________________
;	     Outputs ________________________

J$76B0:	LD	HL,I$76B4
        RET

I$76B4:	DEFB	07H,0AH,0DH,01H,58H,01H,57H,01H
        DEFB	57H,01H,57H,01H,57H,01H,57H,01H
        DEFB	57H,01H,57H,01H,57H,01H,57H,01H
        DEFB	57H,01H,57H,01H,57H,01H,57H,01H
        DEFB	57H,01H,57H,01H,59H,0AH,0DH,01H
        DEFB	56H,21H,21H,21H,20H,57H,41H,52H
        DEFB	4EH,49H,4EH,47H,20H,21H,21H,21H
        DEFB	01H,56H,0AH,0DH,01H,5AH,01H,57H
        DEFB	01H,57H,01H,57H,01H,57H,01H,57H
        DEFB	01H,57H,01H,57H,01H,57H,01H,57H
        DEFB	01H,57H,01H,57H,01H,57H,01H,57H
        DEFB	01H,57H,01H,57H,01H,5BH,0AH,0DH
        DEFB	0AH,0DH,41H,4CH,4CH,20H,44H,41H
        DEFB	54H,41H,20H,4FH,4EH,20H,48H,41H
        DEFB	52H,44H,20H,44H,49H,53H,4BH,20H
        DEFB	44H,52H,49H,56H,45H,20H,0AH,0DH
        DEFB	57H,49H,4CH,4CH,20H,42H,45H,20H
        DEFB	4CH,4FH,53H,54H,20H,21H,0A0H,0AH
        DEFB	0DH,0AH,0DH,31H,20H,20H,20H,20H
        DEFB	20H,20H,2DH,2DH,2DH,20H,43H,6FH
        DEFB	6EH,74H,69H,6EH,75H,65H,0A0H,0AH
        DEFB	0DH,43H,54H,52H,4CH,2BH,43H,20H
        DEFB	2DH,2DH,2DH,20H,41H,62H,6FH,72H
        DEFB	74H,0A0H,0AH,0DH,0AH,0DH,50H,72H
        DEFB	65H,73H,73H,20H,65H,69H,74H,68H
        DEFB	65H,72H,20H,6BH,65H,79H,20H,07H
        DEFB	00H

;	  Subroutine DSKFMT
;	     Inputs  ________________________
;	     Outputs ________________________

J$7785:	CP	01H	; 1
        JR	Z,J$778D
        LD	A,0CH	; 12
        JR	J.77F0

J$778D:	PUSH	HL
        PUSH	BC
        CALL	GETWRK
        POP	BC
        POP	HL
        LD	(IX+12),D		; drive
        RRC	D
        RRC	D
        RRC	D
        LD	(IX+0),D
        PUSH	HL
        LD	A,H
        AND	A			; workarea in page 2 or 3 ?
        JP	M,J$77B5		; yep,
        ADD	HL,BC
        AND	A
        LD	DE,08000H+512-1
        SBC	HL,DE
        JR	C,J$77BD
        POP	HL
        LD	HL,08000H
        JR	J$77C0
J$77B5:	LD	H,B
        LD	L,C
        AND	A
        LD	BC,0400H
        SBC	HL,BC
J$77BD:	POP	HL
        JR	C,J$7830
J$77C0:	LD	(IX+11),H
        LD	(IX+10),L
        LD	HL,I$7C34
        LD	D,(IX+11)
        LD	E,(IX+10)
        LD	BC,512
        LDIR
        LD	A,(IX+12)               ; drive
        LD	B,1
        LD	C,0F0H
        LD	DE,0
        LD	H,(IX+11)
        LD	L,(IX+10)
        SCF
        CALL	C.74C5			; write boot sector
        JR	NC,J$77F3
J.77EA:	CP	0CH	; 12
        JR	NZ,J.77F0
        LD	A,10H	; 16
J.77F0:	JP	J.7832

J$77F3:	LD	BC,2*512-1
        LD	H,(IX+11)
        LD	L,(IX+10)
        LD	D,H
        LD	E,L
        INC	DE
        LD	(HL),00H
        LDIR
        LD	B,9
        LD	DE,17-2
J$7808:	CALL	C.7835
        JR	C,J.77EA
        DJNZ	J$7808			; write directory sectors
        LD	H,(IX+11)
        LD	L,(IX+10)
        LD	(HL),0F0H
        INC	HL
        LD	(HL),0FFH
        INC	HL
        LD	(HL),0FFH
        CALL	C$784D
        JR	C,J.7832
        LD	B,2
        LD	DE,13-2
J$7827:	CALL	C.7835
        JR	C,J.77EA
        DJNZ	J$7827			; write FAT sectors
        AND	A
J$782F:	RET
J$7830:	LD	A,0EH	; 14
J.7832:	SCF
        JR	J$782F

;	  Subroutine __________________________
;	     Inputs  ________________________
;	     Outputs ________________________

C.7835:	INC	DE
        INC	DE
        PUSH	DE
        PUSH	BC
        LD	A,(IX+12)
        LD	B,2
        LD	C,0F0H
        LD	H,(IX+11)
        LD	L,(IX+10)
        SCF
        CALL	C.74C5			; write sector
        POP	BC
        POP	DE
        RET

;	  Subroutine __________________________
;	     Inputs  ________________________
;	     Outputs ________________________

C$784D:	LD	(IX+14),00H
        LD	(IX+13),02H	; 2
        LD	(IX+3),20H	; " "
        LD	(IX+7),00H
        LD	(IX+8),22H	; """
        LD	(IX+9),00H
        CALL	C$78DD			; print formating text
J$7868:	LD	A,(IX+0)
        AND	20H
        LD	(IX+0),A		; only drive
        LD	D,(IX+7)
        LD	E,(IX+8)
        CALL	C.74F6
        LD	B,(IX+3)		; number of sectors
        LD	D,(IX+0)
        LD	H,(IX+1)		; track + sector (H)
        LD	L,(IX+2)		; sector (L)
        LD	C,05H			; operation
        CALL	C.7A4A
        JR	C,J.78C7
        CALL	C.7ABF
        JR	C,J.78C7
        CALL	NZ,C$7912
        LD	H,(IX+7)
        LD	L,(IX+8)		; sectornumber
        LD	E,(IX+3)		; number of sectors
        LD	D,00H
        ADD	HL,DE
        LD	(IX+7),H
        LD	(IX+8),L
        INC	(IX+9)
        BIT	5,(IX+9)
        CALL	NZ,C$78CF
        LD	H,(IX+14)
        LD	L,(IX+13)
        INC	HL
        LD	(IX+14),H
        LD	(IX+13),L
        LD	DE,653
        AND	A
        SBC	HL,DE
        JR	NZ,J$7868
        AND	A
J$78C6:	RET

J.78C7:	CALL	C.7947
        LD	A,10H	; 16
        SCF
        JR	J$78C6

;	  Subroutine __________________________
;	     Inputs  ________________________
;	     Outputs ________________________

C$78CF:	PUSH	IX
        LD	(IX+9),00H
        LD	A,83H
        CALL	C.7B19			; print char
        POP	IX
        RET

;	  Subroutine __________________________
;	     Inputs  ________________________
;	     Outputs ________________________

C$78DD:	PUSH	IX
        LD	HL,I$78E8
        CALL	C.7B28                  ; print string
        POP	IX
        RET

I$78E8:	DEFB	10,13
        DEFB	"Formatting "
        DEFB	10,13
        DEFB	" [                    ]"
        DEFB	13
        DEFB	" ["
        DEFB	0

;	  Subroutine __________________________
;	     Inputs  ________________________
;	     Outputs ________________________

C$7912:	LD	D,(IX+14)
        LD	E,(IX+13)
        AND	A
        RR	D
J$791B:	AND	A
        RR	E
        PUSH	AF
J$791F:	LD	H,D
        LD	L,E
J$7921:	ADD	HL,HL
        ADD	HL,DE
J$7923:	LD	B,(IX+11)
        LD	C,(IX+10)
J$7929:	ADD	HL,BC
        POP	AF
J$792B:	JR	C,J$793A
J$792D:	LD	(HL),0F7H
        INC	HL
        SET	0,(HL)
        SET	1,(HL)
        SET	2,(HL)
        SET	3,(HL)
        JR	J$7946

J$793A:	INC	HL
        SET	4,(HL)
        SET	5,(HL)
        SET	6,(HL)
        RES	7,(HL)
        INC	HL
        LD	(HL),0FFH
J$7946:	RET

;	  Subroutine __________________________
;	     Inputs  ________________________
;	     Outputs ________________________

C.7947:	CALL	C.797E			; port 07DH
        OUT	(C),A
        LD	D,20
J$794E:	LD	B,0FFH
J$7950:	DJNZ	J$7950
        DEC	D
        JR	NZ,J$794E		; wait xx ms
        LD	E,10H
J$7957:	LD	D,0FFH
J$7959:	LD	B,0FFH
J$795B:	INC	C			; port 07EH
        OUT	(C),A
        DEC	C
        IN	A,(C)
        BIT	5,A
        JR	NZ,J.7977
        BIT	4,A
        JR	NZ,J.7977
        AND	0FH
        XOR	0DH
        JR	Z,J$7987
        DJNZ	J$795B
        DEC	D
        JR	NZ,J$7959
        DEC	E
        JR	NZ,J$7957
J.7977:	LD	A,41H
        SCF
        RET

;	  Subroutine Port 07CH
;	     Inputs  ________________________
;	     Outputs ________________________

C.797B:	LD	C,7CH
        RET

;	  Subroutine Port 07DH
;	     Inputs  ________________________
;	     Outputs ________________________

C.797E:	LD	C,7DH
        RET

;	  Subroutine Port 07EH
;	     Inputs  ________________________
;	     Outputs ________________________

C.7981:	LD	C,7EH
        RET

;	  Subroutine Port 07FH
;	     Inputs  ________________________
;	     Outputs ________________________

C.7984:	LD	C,7FH
        RET

J$7987:	CALL	C.7984			; port 07FH
        XOR	A
        OUT	(C),A
        LD	C,0CH
        LD	D,00H
        LD	H,00H
        LD	L,00H
        LD	B,00H
        CALL	C$79A5
        JR	C,J.79C7
        LD	C,0CH			; operation
        LD	D,20H
        LD	HL,0
        LD	B,0

;	  Subroutine __________________________
;	     Inputs  ________________________
;	     Outputs ________________________

C$79A5:	CALL	C.7A4A
        JR	C,J.79C7
        LD	B,08H	; 8
        CALL	C.797B			; port 07CH
        LD	HL,I$79CC
        LD	D,09H	; 9
J$79B4:	CALL	C.7A9E
        JR	C,J.79C8
        OUTI
        JR	NZ,J$79B4
        CALL	C.7ABF
        JR	C,J.79C8
        JR	Z,J.79C7
        LD	A,42H	; "B"
J$79C6:	SCF
J.79C7:	RET
J.79C8:	LD	A,40H	; "@"
        JR	J$79C6

I$79CC:	DEFB	002H
        DEFB	068H
        DEFB	002H
        DEFB	002H
        DEFB	069H
        DEFB	001H
        DEFB	032H
        DEFB	00BH

;	  Subroutine __________________________
;	     Inputs  ________________________
;	     Outputs ________________________

C$79D4:	CALL	C.7984			; port 07FH
        XOR	A
        OUT	(C),A
        LD	C,0E4H			; operation
        LD	D,0
        LD	B,0
        LD	HL,0

;	  Subroutine __________________________
;	     Inputs  ________________________
;	     Outputs ________________________

C.79E3:	PUSH	DE
        CALL	C.7A4A
        POP	DE
        JR	C,J.79FA
        PUSH	DE
        CALL	C.7ABF
        POP	DE
        JR	C,J.79FA
        JR	Z,J$79FD
        CALL	C.7AE0
        JR	C,J.79FA
        JR	J$79FC
J.79FA:	LD	A,40H
J$79FC:	SCF
J$79FD:	RET

;	  Subroutine __________________________
;	     Inputs  ________________________
;	     Outputs ________________________

C.79FE:	CALL	C.7984			; port 07FH
        XOR	A
        OUT	(C),A
        LD	L,01H	; 1
J$7A06:	LD	H,0FH	; 15
J$7A08:	LD	B,0FFH
J$7A0A:	PUSH	HL
        PUSH	BC
        PUSH	DE
        LD	C,00H			; operation
        LD	HL,0
        LD	B,0
        CALL	C.7A4A
        JR	NC,J$7A1E
        POP	DE
        POP	BC
        POP	HL
        JR	J.7A37
J$7A1E:	CALL	C.7ABF
        POP	DE
        POP	BC
        POP	HL
        JR	C,J.7A37
        JR	Z,J$7A3A
        DJNZ	J$7A0A
        DEC	H
        JR	NZ,J$7A08
        DEC	L
        JR	NZ,J$7A06
        CALL	C.7AE0
        JR	C,J.7A37
        JR	J$7A39
J.7A37:	LD	A,40H	; "@"
J$7A39:	SCF
J$7A3A:	RET

;	  Subroutine __________________________
;	     Inputs  ________________________
;	     Outputs ________________________

C.7A3B:	CALL	C.7984			; port 07FH
        XOR	A
        OUT	(C),A
        LD	C,01H			; operation
        LD	B,0
        LD	HL,0
        JR	C.79E3

;	  Subroutine __________________________
;	     Inputs  ________________________
;	     Outputs ________________________

C.7A4A:	PUSH	BC
        PUSH	DE
        CALL	C.7981			; port 07EH
        OUT	(C),A
        DEC	C
        LD	B,0FFH
J$7A54:	IN	A,(C)
        BIT	3,A
        JR	NZ,J$7A62
        DJNZ	J$7A54
        POP	DE
        POP	BC
J.7A5E:	LD	A,40H
        SCF
        RET

J$7A62:	LD	D,0DH	; 13
        CALL	C.7A9E
        JR	C,J.7A5E
        POP	DE
        POP	BC
        LD	A,C
        CALL	C.797B			; port 07CH
        OUT	(C),A
        PUSH	DE
        LD	D,0DH
        CALL	C.7A9E
        POP	DE
        JR	C,J.7A5E
        OUT	(C),D
        LD	D,0DH	; 13
        CALL	C.7A9E
        JR	C,J.7A5E
        OUT	(C),H
        CALL	C.7A9E
        JR	C,J.7A5E
        OUT	(C),L
        CALL	C.7A9E
        JR	C,J.7A5E
        OUT	(C),B
        CALL	C.7A9E
        JR	C,J.7A5E
        LD	A,05H	; 5
        OUT	(C),A
        AND	A
        RET

;	  Subroutine __________________________
;	     Inputs  ________________________
;	     Outputs ________________________

C.7A9E:	PUSH	HL
        PUSH	BC
        LD	L,28H	; "("
J$7AA2:	LD	H,0FFH
J$7AA4:	LD	B,0FFH
J$7AA6:	CALL	C.797E			; port 07DH
        IN	A,(C)
        AND	0FH	; 15
        XOR	D
        JR	Z,J$7ABB
        DJNZ	J$7AA6
        DEC	H
        JR	NZ,J$7AA4
        DEC	L
        JR	NZ,J$7AA2
        SCF
        JR	J$7ABC
J$7ABB:	AND	A
J$7ABC:	POP	BC
        POP	HL
        RET

;	  Subroutine __________________________
;	     Inputs  ________________________
;	     Outputs ________________________

C.7ABF:	LD	D,0FH	; 15
        CALL	C.7A9E
        JR	C,J.7ADF
        CALL	C.797B			; port 07CH
        IN	A,(C)
        OR	A
        BIT	1,A
        PUSH	AF
        INC	C
        LD	B,00H
J$7AD2:	IN	A,(C)
        AND	0FH	; 15
        JR	Z,J$7ADE
        DJNZ	J$7AD2
        POP	AF
        SCF
        JR	J.7ADF
J$7ADE:	POP	AF
J.7ADF:	RET

;	  Subroutine __________________________
;	     Inputs  ________________________
;	     Outputs ________________________

C.7AE0:	LD	C,03H			; operation
        LD	HL,0
        LD	B,0
        CALL	C.7A4A
        JR	C,J.7B0F
        CALL	C.797B			; port 07CH
        LD	D,0BH	; 11
        CALL	C.7A9E
        JR	C,J.7B0F
        IN	A,(C)
        AND	7FH
        PUSH	AF
        LD	B,03H	; 3
J$7AFD:	CALL	C.7A9E
        JR	C,J.7B15
        IN	A,(C)
        DJNZ	J$7AFD
        CALL	C.7ABF
        JR	C,J.7B15
        JR	NZ,J$7B10
        POP	AF
J$7B0E:	OR	A
J.7B0F:	RET
J$7B10:	POP	AF
        LD	A,43H	; "C"
        JR	J$7B0E
J.7B15:	POP	AF
        SCF
        JR	J.7B0F

;	  Subroutine __________________________
;	     Inputs  ________________________
;	     Outputs ________________________

C.7B19:	LD	IY,(EXPTBL+0-1)
        LD	IX,CHPUT
        CALL	CALSLT
        RET

;	  Subroutine __________________________
;	     Inputs  ________________________
;	     Outputs ________________________

C$7B25:	LD	HL,I$7B37

;	  Subroutine __________________________
;	     Inputs  ________________________
;	     Outputs ________________________

C.7B28:	LD	A,(HL)
        AND	7FH
        OR	A
        JR	Z,J$7B36
        PUSH	HL
        CALL	C.7B19			; print char
        POP	HL
        INC	HL
        JR	C.7B28
J$7B36:	RET

I$7B37:	DEFB	10,13
        DEFB	"HC-95/90 HDD SYSTEM TYPE 2"
        DEFB	0A0H
        DEFB	10,13
        DEFB	"Ver. 0.2   by K.C. & R.A."
        DEFB	0A0H
        DEFB	10,13
        DEFB	"Copyright 1986 by JVC"
        DEFB	0A0H
        DEFB	10,13,10,13
        DEFB	0

I$7B8D:	DEFB	" : HDD System Error"
        DEFB	0A0H
        DEFB	10,13

I$7BA3:	DEFB	"Retry (Y/N) ?"
        DEFB	0A0H
        DEFB	10,13
        DEFB	0

I$7BB4:	DEFB	" : 2nd Hard Disk Drive Error"
        DEFB	0A0H
        DEFB	10,13
        DEFB	0

;	  Subroutine __________________________
;	     Inputs  ________________________
;	     Outputs ________________________

C.7BD4:	AND	7FH
        LD	C,A
        LD	D,2
J$7BD9:	LD	B,4
J$7BDB:	SRL	A
        DJNZ	J$7BDB
J$7BDF:	OR	"0"
J$7BE1:	PUSH	BC
        PUSH	DE
        CALL	C.7B19			; print char
        POP	DE
        POP	BC
J$7BE8:	LD	A,C
        AND	0FH	; 15
        DEC	D
        JR	NZ,J$7BDF
        RET

;	  Subroutine __________________________
;	     Inputs  ________________________
;	     Outputs ________________________

C.7BEF:	LD	IY,(EXPTBL+0-1)
        LD	IX,BEEP
        CALL	CALSLT
        RET

;	  Subroutine __________________________
;	     Inputs  ________________________
;	     Outputs ________________________

C.7BFB:	LD	IY,(EXPTBL+0-1)
        LD	IX,SNSMAT
        LD	A,5
J$7C05:	CALL	CALSLT
        BIT	6,A
J$7C0A:	JR	Z,J$7C1F
        LD	IY,(EXPTBL+0-1)
        LD	IX,SNSMAT
        LD	A,4
        CALL	CALSLT
        BIT	3,A
        JR	Z,J$7C23
        JR	C.7BFB

J$7C1F:	SCF
        PUSH	AF
        JR	J$7C25

J$7C23:	AND	A
        PUSH	AF
J$7C25:	LD	HL,I$7C2D
        CALL	C.7B28                          ; print string
        POP	AF
        RET

I$7C2D:	DEFB	27,"A",27,"M",27,"M"            ; cursor up, cursor down, cursor down
        DEFB	0

I$7C34:
        .PHASE	0C000H

        DEFB	0EBH				; x86 JMP +0100H
        DEFB	0FEH
        DEFB	090H				; x86 NOP
        DEFB	"JVC_HDD2"
        DEFW	512
        DEFB	32
        DEFW	13
        DEFB	2
        DEFW	254
        DEFW	51EAH
        DEFB	0F0H
        DEFW	2
        DEFW	17
        DEFW	2
        DEFW	1

        RET	NC
        LD	(DC058+1),DE
        LD	(DC0C4),A
        LD	(HL),LOW DC056
        INC	HL
        LD	(HL),HIGH DC056
J$7430:	LD	SP,KBUF+256
        LD	DE,DC09F
        LD	C,0FH	; 15
        CALL	XF37D
        INC	A
        JP	Z,DC063
        LD	DE,0100H
        LD	C,1AH
        CALL	XF37D
        LD	HL,1
        LD	(DC09F+14),HL
        LD	HL,04000H-0100H
        LD	DE,DC09F
        LD	C,27H	; "'"
        CALL	XF37D
        JP	0100H

DC056:	DEFW	DC058

DC058:	CALL	0
        LD	A,C
        AND	0FEH
        CP	02H	; 2
        JP	NZ,DC06A
DC063:	LD	A,(DC0C4)
        AND	A
        JP	Z,J4022
DC06A:	LD	DE,DC079
        LD	C,09H	; 9
        CALL	XF37D
        LD	C,07H	; 7
        CALL	XF37D
        JR	J$7430

DC079:	DEFB	"Boot error",13,10
        DEFB	"Press any key for retry",13,10
        DEFB	"$"

DC09F:	DEFB	0
        DEFB	"MSXDOS  SYS"
        DEFW	0
        DEFW	0
        DEFB	0,0,0,0
        DEFW	0
        DEFW	0
        DEFB	0
        DEFB	0
        DEFW	0
        DEFW	0
        DEFW	0
        DEFB	0
        DEFB	0,0,0,0

DC0C4:	DEFB	0

        .DEPHASE

        DEFS	07FB0H-$,0

        DEFM	"Copyright 1986  by K.Chiba (VSE) MSX BIOS TYPE 2   Ver.  0.3      Oct.11 1986  "
        NOP
        END
