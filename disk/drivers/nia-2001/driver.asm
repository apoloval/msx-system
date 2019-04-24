;
;   AUCNET -> Source re-created by Z80DIS 2.2
;      Z80DIS was written by Kenneth Gielow
;                            Palo Alto, CA
        .Z80
        ORG	7405H
BDOS	EQU	0F37DH	; ----I
SNSMAT	EUQ	0141H	; -C---

C$4029	EQU	4029H	; -C---
GETSLT	EQU	402DH	; -C---
GETWRK	EQU	4DAFH	; -C---
D.BFF8	EQU	0BFF8H	; ---LI
D.BFF9	EQU	0BFF9H	; ---L-
I$C000	EQU	0C000H	; ----I

RAMAD1	EQU	0F342H	; ---L-
RAMAD2	EQU	0F343H	; ---L-
_SECBUF	EQU	0F34DH	; --SL-
ENAKRN	EQU	0F368H	; -C---
XFER	EQU	0F36EH	; -C---
JIFFY	EQU	0FC9EH	; ---L-
PROCNM	EQU	0FD89H	; ----I

MYSIZE	EQU	5


I$7405:
        DEFB	0FEH
        DEFW	512		; sectorsize
        DEFB	00FH
        DEFB	004H
        DEFB	00Fh		; 16 sectors/cluster
        DEFB	005h
        DEFW	1		; FAT at 1
        DEFB	2		; 2 FATs
        DEFB	240		; 240 entries
        DEFW	40		; first data sector
        DEFW	4086		; # of clusters+1
        DEFB	12		; size of FAT
        DEFW	25		; first rootdir sector

DEFDPB	EQU	I$7405-1

;	 Subroutine __________________________
;	    Inputs  ________________________
;	    Outputs ________________________

DSKIO:
C$7417:	EI
        JP	NC,J$7428
        CALL	C.760E		; get workarea
        LD	(IX+3),00H
        LD	(IX+0),0AH
        JR	J$743A

J$7428:	CALL	C.760E		; get workarea
        XOR	A
        CP	(IX+3)
        LD	(IX+3),A
        LD	A,2
        SCF
        RET	NZ		; quit with NOT READY ERROR
        LD	(IX+0),08H
J$743A:	LD	A,(IX+1)
        CP	02H
        LD	A,0CH
        CCF
        RET	C		; quit with OTHER ERROR
        CALL	C.7531
        RET	C
        LD	A,H
        AND	A		; page 2 or 3 transfer ?
        JP	M,J.7491	; yep,
        CALL	C$7965
        CALL	C$79A8
        RET	C
        INC	B
        DEC	B
        RET	Z
        LD	A,H
        AND	A
        JP	M,J.7491
        LD	A,(IX+0)
        CP	0AH		; sector write ?
        JR	Z,J$747A	; yep,
        PUSH	HL
        LD	HL,(_SECBUF)
        CALL	C.749B
        POP	HL
        RET	C
        PUSH	BC
        EX	DE,HL
        LD	HL,(_SECBUF)
        LD	BC,512
        CALL	XFER
        POP	BC
        EX	DE,HL
        JR	J.7495

J$747A:	PUSH	BC
        LD	DE,(_SECBUF)
        LD	BC,512
        CALL	XFER
        PUSH	HL
        LD	HL,(_SECBUF)
        CALL	C.749B
        POP	HL
        POP	BC
        RET	C
        JR	J.7495

J.7491:	CALL	C.749B
        RET	C
J.7495:	DJNZ	J.7491
        CALL	C.74F9
        RET

;	 Subroutine __________________________
;	    Inputs  ________________________
;	    Outputs ________________________

C.749B:	PUSH	BC
        CALL	C.751D
        JR	Z,J.74F8
        LD	B,40H	; "@"
        LD	DE,D.7FF8
        LD	A,(IX+0)
        CP	0AH			; sector write ?
        JR	Z,J.74D2		; yep,
J$74AD:	LD	A,(DE)
        LD	(HL),A
        INC	HL
        LD	A,(DE)
        LD	(HL),A
        INC	HL
        LD	A,(DE)
        LD	(HL),A
        INC	HL
        LD	A,(DE)
        LD	(HL),A
        INC	HL
        DJNZ	J$74AD
        CALL	C.751D
        JR	Z,J.74F8
        LD	B,40H	; "@"
J$74C2:	LD	A,(DE)
        LD	(HL),A
        INC	HL
        LD	A,(DE)
        LD	(HL),A
        INC	HL
        LD	A,(DE)
        LD	(HL),A
        INC	HL
        LD	A,(DE)
        LD	(HL),A
        INC	HL
        DJNZ	J$74C2
        JR	J$74F5

J.74D2:	LD	A,(HL)
        LD	(DE),A
        INC	HL
        LD	A,(HL)
        LD	(DE),A
        INC	HL
        LD	A,(HL)
        LD	(DE),A
        INC	HL
        LD	A,(HL)
        LD	(DE),A
        INC	HL
        DJNZ	J.74D2
        CALL	C.751D
        JR	Z,J.74F8
        LD	B,40H	; "@"
J$74E7:	LD	A,(HL)
        LD	(DE),A
        INC	HL
        LD	A,(HL)
        LD	(DE),A
        INC	HL
        LD	A,(HL)
        LD	(DE),A
        INC	HL
        LD	A,(HL)
        LD	(DE),A
        INC	HL
        DJNZ	J$74E7
J$74F5:	POP	BC
        AND	A
        RET

J.74F8:	POP	BC
;	 Subroutine __________________________
;	    Inputs  ________________________
;	    Outputs ________________________

C.74F9:	CALL	C.7506
        LD	E,A
        CALL	C.7506
        OR	E
        RET	Z
        LD	A,0CH	; 12
        SCF
        RET

;	 Subroutine __________________________
;	    Inputs  ________________________
;	    Outputs ________________________

C.7506:	PUSH	BC
        LD	BC,0
J$750A:	DEC	BC
        LD	A,C
        OR	B
        LD	A,0FFH
        JR	Z,J$751B
        LD	A,(D.7FF9)
        BIT	0,A
        JR	Z,J$750A
        LD	A,(D.7FF8)
J$751B:	POP	BC
        RET

;	 Subroutine __________________________
;	    Inputs  ________________________
;	    Outputs ________________________

C.751D:	PUSH	BC
        LD	BC,0
J$7521:	DEC	BC
        LD	A,C
        OR	B
        JR	Z,J$752F
        LD	A,(D.7FF9)
        BIT	0,A
        JR	Z,J$7521
        AND	40H	; "@"
J$752F:	POP	BC
        RET

;	 Subroutine __________________________
;	    Inputs  ________________________
;	    Outputs ________________________

C.7531:	PUSH	BC
        PUSH	HL
        LD	H,B
        LD	L,00H
        LD	B,(IX+0)
        XOR	A
        CP	(IX+1)
        JR	NZ,J$7546
        SLA	H
        SLA	E
        RL	D
        RLA
J$7546:	LD	C,A
        CALL	C.7555
        POP	HL
        POP	BC
        RET

;	 Subroutine __________________________
;	    Inputs  ________________________
;	    Outputs ________________________

C.754D:	LD	C,00H
        LD	DE,0
        LD	HL,0

;	 Subroutine __________________________
;	    Inputs  ________________________
;	    Outputs ________________________

C.7555:	PUSH	DE
        CALL	C$7588
        POP	DE
        LD	A,02H	; 2
        SCF
        RET	Z
        PUSH	BC
        PUSH	DE
        PUSH	HL
        LD	HL,5
        ADD	HL,SP
        LD	B,06H	; 6
        LD	DE,0
J.756A:	DEC	DE
        LD	A,E
        OR	D
        LD	A,02H	; 2
        SCF
        JR	Z,J$7584
        LD	A,(D.7FF9)
        BIT	0,A
        JR	Z,J.756A
        LD	DE,0
        LD	A,(HL)
        LD	(D.7FF8),A
        DEC	HL
        DJNZ	J.756A
        AND	A
J$7584:	POP	HL
        POP	DE
        POP	BC
        RET

;	 Subroutine __________________________
;	    Inputs  ________________________
;	    Outputs ________________________

C$7588:	LD	DE,0
J$758B:	DEC	DE
        LD	A,E
        OR	D
        RET	Z
        LD	A,(D.7FF9)
        AND	10H	; 16
        JR	Z,J$758B
        LD	A,01H	; 1
        LD	(D.7FF8),A
        LD	A,08H	; 8
        LD	(D.7FF9),A
        LD	DE,0
J$75A3:	DEC	DE
        LD	A,E
        OR	D
        RET	Z
        LD	A,(D.7FF9)
        AND	10H	; 16
        JR	NZ,J$75A3
        XOR	A
        LD	(D.7FF9),A
J.75B2:	LD	DE,0
J$75B5:	DEC	DE
        LD	A,E
        OR	D
        RET	Z
        LD	A,(D.7FF9)
        AND	0F9H
        CP	89H
        JR	Z,J$75CC
        CP	09H	; 9
        JR	Z,J$75D3
        CP	0A9H
        JR	NZ,J$75B5
        AND	A
        RET

J$75CC:	LD	A,08H	; 8
        LD	(D.7FF8),A
        JR	J.75B2

J$75D3:	LD	A,(D.7FF8)
        JR	J.75B2

;	 Subroutine __________________________
;	    Inputs  ________________________
;	    Outputs ________________________

C.75D8:	PUSH	HL
        LD	B,25H	; "%"
        CALL	C.754D
        POP	HL
        RET	C
        LD	B,04H	; 4
        LD	DE,0
J.75E5:	DEC	DE
        LD	A,E
        OR	D
        LD	A,02H	; 2
        SCF
        RET	Z
        LD	A,(D.7FF9)
        BIT	0,A
        JR	Z,J.75E5
        LD	DE,0
        XOR	A
        LD	(D.7FF8),A
        DJNZ	J.75E5
        LD	DE,D.7FF8
        LD	B,08H	; 8
J$7601:	CALL	C.751D
        JR	Z,J$760B
        LD	A,(DE)
        LD	(HL),A
        INC	HL
        DJNZ	J$7601
J$760B:	JP	C.74F9

;	 Subroutine __________________________
;	    Inputs  ________________________
;	    Outputs ________________________

C.760E:	PUSH	BC
        PUSH	HL
        CALL	GETWRK
        POP	HL
        POP	BC
        RET

INIHRD:
?.7616:	RET

?.7617:	LD	HL,(JIFFY)
        PUSH	HL
J.761B:	LD	HL,(JIFFY)
        POP	DE
        AND	A
        SBC	HL,DE
        LD	BC,1200			; 20 seconds
        AND	A
        SBC	HL,BC
        RET	NC
        PUSH	DE
        CALL	C.7642
        LD	B,00H
        CALL	C.754D
        JR	C,J.761B
        CALL	C.74F9
        JR	C,J.761B
        POP	AF
        LD	B,01H	; 1
        CALL	C.754D
        JP	C.74F9

;	 Subroutine __________________________
;	    Inputs  ________________________
;	    Outputs ________________________

C.7642:	PUSH	HL
        XOR	A
        LD	(D.7FF9),A
        LD	HL,0
J$764A:	LD	A,(D.7FF9)
        RRCA
        JR	NC,J$7656
        LD	A,(D.7FF8)
        LD	HL,0
J$7656:	DEC	HL
        LD	A,L
        OR	H
        JR	NZ,J$764A
        POP	HL
        RET

DRIVES:
?.765D:	LD	L,0
        RET

INIENV:
?.7660:	CALL	GETWRK
        CALL	C$769E			; ESC pressed ?
        LD	(IX+3),00H
        JR	NZ,J$766F		; nope,
        INC	(IX+3)
J$766F:	CALL	C$76A6			; SELECT pressed ?
        LD	(IX+1),0FFH
        RET	Z			; yep, quit
        LD	HL,I$C000

C$767A:	LD	(IX+2),0FFH
        LD	(IX+1),0FFH
        PUSH	HL
        CALL	C.75D8
        POP	HL
        RET	C
        INC	HL
        INC	HL
        INC	HL
        INC	HL
        LD	A,(HL)
        INC	HL
        OR	(HL)
        RET	NZ
        INC	HL
        INC	HL
        OR	(HL)
        RET	NZ
        DEC	HL
        LD	A,(HL)
        DEC	A
        CP	02H	; 2
        RET	NC
        LD	(IX+1),A
        RET

;	 Subroutine ESC pressed ?
;	    Inputs  ________________________
;	    Outputs ________________________

C$769E:	LD	A,7
        CALL	SNSMAT
        BIT	2,A
        RET

;	 Subroutine SELECT pressed ?
;	    Inputs  ________________________
;	    Outputs ________________________

C$76A6:	LD	A,7
        CALL	SNSMAT
        BIT	6,A
        RET

MTOFF:
?.76AE:	EI
        LD	HL,(_SECBUF)
        CALL	C.75D8
        RET	C
        LD	B,0BH	; 11
        LD	HL,(_SECBUF)
        INC	HL
        LD	C,(HL)
        INC	HL
        LD	D,(HL)
        INC	HL
        LD	E,(HL)
        LD	HL,0
        CALL	C.7555
        JP	C.74F9

DSKCHG:
?.76CA:	EI
        CALL	GETWRK
        LD	A,(IX+1)
        CP	02H	; 2
        LD	B,00H
        JR	NC,J$76DE
        LD	B,(IX+2)
        LD	(IX+2),01H	; 1
J$76DE:	OR	A
        RET

GETDPB:
?.76E0:	EI
        INC	HL
        EX	DE,HL
        LD	HL,I$7405
        LD	BC,18
        LDIR
        AND	A
        RET

CHOICE:
?.76ED:	LD	HL,I$76F1
        RET

I$76F1:	DEFB	13,10
        DEFB	"1 - Format with verify",13,10
        DEFB	"2 - Format only",13,10
        DEFB	13,10
        DEFB	0

DSKFMT:
        EI
        DEC	A
        CP	02H	; 2
        JR	C,J$7729
        LD	A,0CH	; 12
        SCF
        RET

J$7729:	PUSH	AF
        CALL	GETWRK
        POP	AF
        LD	(IX+4),A
        CALL	C.7642
        LD	B,04H	; 4
        CALL	C.754D
        RET	C
J$773A:	LD	A,(D.7FF9)
        BIT	0,A
J$773E	EQU	$-1
        JR	Z,J$773A
        CALL	C.74F9
        LD	A,10H	; 16
        RET	C
        LD	HL,(_SECBUF)
        CALL	C$767A
        LD	HL,(_SECBUF)
        LD	E,L
        LD	D,H
        INC	DE
        LD	BC,512-1
J$7756:	LD	(HL),0
        LDIR
        LD	DE,2			; second sector of FAT #1
        CALL	C.7859			; write FAT sectors
        RET	C
        LD	DE,14			; second sector of FAT #2
        CALL	C.7859			; write FAT sectors
        RET	C
        LD	B,15			; 15 directory sectors
        LD	DE,25			; first sector of rootdirectory
        CALL	C.785B			; write directory sectors
        RET	C
        LD	HL,(_SECBUF)
        LD	(HL),0FEH
J$7776:	INC	HL
        LD	(HL),0FFH
        INC	HL
J$777A:	LD	(HL),0FFH
        LD	DE,1			; first sector of FAT #1
        CALL	C.7866			; write sector
        RET	C
        LD	DE,13			; first sector of FAT #2
J$7786:	CALL	C.7866			; write sector
        RET	C
        LD	DE,(_SECBUF)
        LD	HL,I$787C
        LD	BC,00B3H
        LDIR
        LD	DE,0			; bootsector
        CALL	C.7866			; write sector
        RET	C
        LD	A,(IX+4)
        AND	A			; verify ?
        RET	NZ			; nope, quit
        LD	HL,2
        LD	BC,4085
J$77A8:	PUSH	BC
        PUSH	HL
        CALL	C$77B9
        POP	HL
        CALL	C,C$77F2
        POP	BC
        INC	HL
        DEC	BC
        LD	A,C
        OR	B
        JR	NZ,J$77A8
        RET

;	 Subroutine __________________________
;	    Inputs  ________________________
;	    Outputs ________________________

C$77B9:	DEC	HL
        DEC	HL
        ADD	HL,HL
        ADD	HL,HL
        ADD	HL,HL
        ADD	HL,HL
        LD	B,10H	; 16
        LD	DE,40
        ADD	HL,DE
        EX	DE,HL
        LD	(IX+0),08H	; 8
        CALL	C.7531
        LD	DE,D.7FF8
        LD	A,B
        ADD	A,A
        LD	C,A
J$77D3:	CALL	C.751D
        JR	Z,J$77EF
        LD	B,10H	; 16
J$77DA:	LD	A,(DE)
        LD	A,(DE)
        LD	A,(DE)
        LD	A,(DE)
        LD	A,(DE)
        LD	A,(DE)
        LD	A,(DE)
        LD	A,(DE)
        LD	A,(DE)
        LD	A,(DE)
        LD	A,(DE)
        LD	A,(DE)
        LD	A,(DE)
        LD	A,(DE)
        LD	A,(DE)
        LD	A,(DE)
        DJNZ	J$77DA
        DEC	C
        JR	NZ,J$77D3
J$77EF:	JP	C.74F9

;	 Subroutine __________________________
;	    Inputs  ________________________
;	    Outputs ________________________

C$77F2:	PUSH	HL
        LD	E,L
        LD	D,H
        SRL	H
        RR	L
        PUSH	AF
        ADD	HL,DE
        LD	A,H
        SRL	A
        INC	A
        LD	E,A
        LD	D,00H
        LD	A,H
        AND	01H	; 1
        LD	H,A
        LD	BC,512-1
        PUSH	HL
        SBC	HL,BC
        JR	Z,J$782F
        CALL	C.7865			; read sector
        POP	HL
        LD	BC,(_SECBUF)
        ADD	HL,BC
        POP	AF
        JR	C,J$7821
        LD	(HL),0F7H
        INC	HL
        LD	(HL),0FH	; 15
        JR	J$782A

J$7821:	LD	A,(HL)
        AND	0FH	; 15
        OR	70H	; "p"
        LD	(HL),A
        INC	HL
J$7828:	LD	(HL),0FFH
J$782A:	CALL	C.784B			; write FAT sector (both FATs)
        POP	HL
        RET

J$782F:	CALL	C.7865			; read sector
        POP	HL
        LD	BC,(_SECBUF)
        ADD	HL,BC
        POP	AF
        LD	A,(HL)
        AND	0FH	; 15
        OR	70H	; "p"
        LD	(HL),A
        CALL	C.784B			; write FAT sector (both FATs)
        INC	DE
        CALL	C.7865			; read sector
        LD	HL,(_SECBUF)
        JR	J$7828

;	 Subroutine __________________________
;	    Inputs  ________________________
;	    Outputs ________________________

C.784B:	PUSH	DE
        CALL	C.7866			; write sector
        LD	HL,12
        ADD	HL,DE
        EX	DE,HL
        CALL	C.7866			; write sector
        POP	DE
        RET

;	 Subroutine __________________________
;	    Inputs  ________________________
;	    Outputs ________________________

C.7859:	LD	B,11

;	 Subroutine __________________________
;	    Inputs  ________________________
;	    Outputs ________________________

C.785B:	PUSH	BC
        CALL	C.7866
        POP	BC
        RET	C
        INC	DE
        DJNZ	C.785B
        RET

;	 Subroutine __________________________
;	    Inputs  ________________________
;	    Outputs ________________________

C.7865:	OR	37H	; "7"
C.7866	EQU	$-1
        PUSH	DE
        LD	A,0			; drive 0
        LD	HL,(_SECBUF)
        LD	BC,1*256+0FEH
        CALL	C$7417			; read/write sector
        POP	DE
        RET	NC
        CP	02H	; 2
        SCF
        RET	Z
        LD	A,10H	; 16
        RET

I$787C:
        .PHASE	0C000H

        DEFB	0EBH,0FEH
        DEFB	090H
        DEFB	"TAKAOKA "
J$7888:	DEFW	512			; 512 bytes per sector
        DEFB	16			; 16 sectors per cluster
        DEFW	1			; 1 reserved sector
        DEFB	2			; 2 fat copies
        DEFW	240			; 240 root directory entries
        DEFW	65400			; total disk sectors
        DEFB	0FEH			; mediascriptor
        DEFW	12			; 12 sectors per fat
        DEFW	33			; 33 sectors per track
        DEFW	1			; 1 side
        DEFW	0			; 0 hidden sectors

        RET	NC
        LD	(LC058+1),DE
        LD	(LC0C4),A
        LD	(HL),LOW LC056
        INC	HL
        LD	(HL),HIGH LC056
L7F3A:	LD	SP,KBUF+256
        LD	DE,LC09F
        LD	C,00FH
        CALL	BDOS
        INC	A
        JP	Z,LC063
        LD	DE,00100H
        LD	C,01AH
        CALL	BDOS
        LD	HL,1
        LD	(LC09F+14),HL
        LD	HL,04000H-00100H
        LD	DE,LC09F
        LD	C,027H
        CALL	BDOS
        JP	00100H

LC056:	DEFW	LC058

LC058:	CALL	0
        LD	A,C
        AND	0FEH
        CP	2
        JP	NZ,LC06A
LC063:	LD	A,(LC0C4)
        AND	A
        JP	Z,DSKBAS
LC06A:	LD	DE,LC079
        LD	C,009H
        CALL	BDOS
        LD	C,007H
        CALL	BDOS
        JR	L7F3A

LC079:	DEFB	"Boot error",13,10
        DEFB	"Press any key for retry",13,10
        DEFB	"$"

LC09F:	DEFB	0
        DEFB	"MSXDOS  SYS"

        .DEPHASE

OEMSTA:
        PUSH	HL
        LD	HL,I$7952
J$7933:	LD	DE,PROCNM
J$7936:	LD	A,(DE)
        CP	(HL)
        JR	NZ,J$7945
        INC	DE
        INC	HL
        AND	A
        JR	NZ,J$7936
        LD	E,(HL)
        INC	HL
        LD	D,(HL)
        POP	HL
        PUSH	DE
        RET

J$7945:	LD	C,0FFH
        XOR	A
        CPIR
        INC	HL
        INC	HL
J$794C:	CP	(HL)
        JR	NZ,J$7933
        POP	HL
        SCF
        RET

I$7952:	DEFB	"SHUTDOWN",0
        DEFW	C795E
        DEFB	0

C795E:	PUSH	HL
        CALL	C$4029			; stop all drives
        POP	HL
        AND	A
        RET

;	 Subroutine __________________________
;	    Inputs  ________________________
;	    Outputs ________________________

C$7965:	PUSH	HL
        PUSH	BC
        LD	HL,I$79AE
J$7968	EQU	$-2
        LD	DE,(_SECBUF)
        LD	BC,00DAH
J$7971:	LDIR
        LD	HL,I$7996
J$7976:	LD	E,(HL)
        INC	HL
        LD	D,(HL)
        INC	HL
        LD	A,E
        OR	D
        JR	Z,J$7993
J$797E:	PUSH	HL
J$797F:	LD	HL,(_SECBUF)
        ADD	HL,DE
        INC	HL
        LD	C,(HL)
        INC	HL
        LD	B,(HL)
        EX	DE,HL
        LD	HL,(_SECBUF)
        ADD	HL,BC
        EX	DE,HL
        LD	(HL),D
J$798E:	DEC	HL
        LD	(HL),E
        POP	HL
        JR	J$7976

J$7993:	POP	BC
        POP	HL
        RET

I$7996:	DEFW	0005H
        DEFW	0019H
        DEFW	003EH
        DEFW	0047H
        DEFW	0066H
        DEFW	008BH
        DEFW	00A2H
        DEFW	00A6H
        DEFW	0

;	 Subroutine __________________________
;	    Inputs  ________________________
;	    Outputs ________________________

C$79A8:	PUSH	HL
        LD	HL,(_SECBUF)
        EX	(SP),HL
        RET

I$79AE:	PUSH	HL
        PUSH	BC
        CALL	GETSLT
        LD	(D$002C),A
        LD	H,80H
        CALL	ENASLT
        EI
        LD	A,(RAMAD1)
        LD	H,40H	; "@"
        CALL	ENASLT
        EI
        POP	BC
        POP	HL
        CALL	C$0037
        PUSH	HL
        PUSH	BC
        PUSH	AF
        LD	A,(RAMAD2)
        LD	H,80H
        CALL	ENASLT
        CALL	ENAKRN
        EI
        LD	A,00H
        LD	H,40H	; "@"
        CALL	ENASLT
        EI
        POP	AF
        POP	BC
        POP	HL
        RET

J$79E5:	DEC	HL
        LD	A,H
        INC	HL
        ADD	A,02H	; 2
        RET	M
        PUSH	BC
        CALL	C$0047
        POP	BC
        RET	C
        DJNZ	J$79E5
        JR	J.7A50

?.79F5:	CALL	C.00C6
        JR	Z,J.7A50
        LD	B,40H	; "@"
        LD	DE,D.BFF8
        LD	A,(IX+0)
        CP	0AH	; 10
        JR	Z,J.7A2B
J$7A06:	LD	A,(DE)
        LD	(HL),A
        INC	HL
        LD	A,(DE)
        LD	(HL),A
        INC	HL
        LD	A,(DE)
        LD	(HL),A
        INC	HL
        LD	A,(DE)
        LD	(HL),A
        INC	HL
        DJNZ	J$7A06
        CALL	C.00C6
        JR	Z,J.7A50
        LD	B,40H	; "@"
J$7A1B:	LD	A,(DE)
        LD	(HL),A
        INC	HL
        LD	A,(DE)
        LD	(HL),A
        INC	HL
        LD	A,(DE)
        LD	(HL),A
        INC	HL
        LD	A,(DE)
        LD	(HL),A
        INC	HL
        DJNZ	J$7A1B
        AND	A
        RET

J.7A2B:	LD	A,(HL)
        LD	(DE),A
        INC	HL
        LD	A,(HL)
        LD	(DE),A
        INC	HL
        LD	A,(HL)
        LD	(DE),A
        INC	HL
        LD	A,(HL)
        LD	(DE),A
        INC	HL
        DJNZ	J.7A2B
        CALL	C.00C6
        JR	Z,J.7A50
        LD	B,40H	; "@"
J$7A40:	LD	A,(HL)
        LD	(DE),A
        INC	HL
        LD	A,(HL)
        LD	(DE),A
        INC	HL
        LD	A,(HL)
        LD	(DE),A
        INC	HL
        LD	A,(HL)
        LD	(DE),A
        INC	HL
        DJNZ	J$7A40
        AND	A
        RET

J.7A50:	CALL	C.00AF
        LD	E,A
        CALL	C.00AF
        OR	E
        RET	Z
        LD	A,0CH	; 12
        SCF
        RET

?.7A5D:	PUSH	BC
        LD	BC,0
J$7A61:	DEC	BC
        LD	A,C
        OR	B
        LD	A,0FFH
        JR	Z,J$7A72
        LD	A,(D.BFF9)
        BIT	0,A
        JR	Z,J$7A61
        LD	A,(D.BFF8)
J$7A72:	POP	BC
        RET

?.7A74:	PUSH	BC
        LD	BC,0
J$7A78:	DEC	BC
        LD	A,C
        OR	B
        JR	Z,J$7A86
        LD	A,(D.BFF9)
        BIT	0,A
        JR	Z,J$7A78
        AND	40H	; "@"
J$7A86:	POP	BC
        RET

        DEFS	07FD0H-$,0

        LD	(D$7FF0),A
        RET

?.7FD4:	RST	38H
        RST	38H
        RST	38H
        RST	38H
        RST	38H
        RST	38H
        RST	38H
        RST	38H
        RST	38H
        RST	38H
        RST	38H
        RST	38H
        RST	38H
        RST	38H
        RST	38H
        RST	38H
        RST	38H
        RST	38H
        RST	38H
        RST	38H
        RST	38H
        RST	38H
        RST	38H
        RST	38H
        RST	38H
        RST	38H
        RST	38H
        RST	38H
D$7FF0:	RST	38H
        RST	38H
        RST	38H
        RST	38H
        RST	38H
        RST	38H
        RST	38H
        RST	38H
D.7FF8:	RST	38H
D.7FF9:	RST	38H
        RST	38H
        RST	38H
        RST	38H
        RST	38H
        RST	38H
        RST	38H
        END
