 Diskdriver Panasonic FS-CF351 (external floppydisk controller)

 FDC	WD2793

 Source re-created by Z80DIS 2.2
 Z80DIS was written by Kenneth Gielow, Palo Alto, CA

 Code Copyrighted by Panasonic and maybe others
 Source comments by Arjen Zeilemaker

 Sourcecode supplied for STUDY ONLY
 Recreation NOT permitted without authorisation of the copyrightholders


MYSIZE	EQU	10
SECLEN	EQU	512


I$7405:
        db	0F8h		; Media F8
        dw	512		; 80 Tracks
        db	0Fh		; 9 sectors
        db	04h		; 1 side
        db	01h		; 3.5" 360 Kb
        db	02h
        dw	1
        db	2
        db	112
        dw	12
        dw	355
        db	2
        dw	5

        db	0F9h		; Media F9
        dw	512		; 80 Tracks
        db	0Fh		; 9 sectors
        db	04h		; 2 sides
        db	01h		; 3.5" 720 Kb
        db	02h
        dw	1
        db	2
        db	112
        dw	14
        dw	714
        db	3
        dw	7

        db	0FAh		; Media FA
        dw	512		; 80 Tracks
        db	0Fh		; 8 sectors
        db	04h		; 1 side
        db	01h		; 3.5" 320 Kb
        db	02h
        dw	1
        db	2
        db	112
        dw	10
        dw	316
        db	1
        dw	3

        db	0FBh		; Media FB
        dw	512		; 80 Tracks
        db	0Fh		; 8 sectors
        db	04h		; 2 sides
        db	01h		; 3.5" 640 Kb
        db	02h
        dw	1
        db	2
        db	112
        dw	10
        dw	635
        db	2
        dw	5

        DEFB	0FCH
        DEFW	512
        DEFB	0FH
        DEFB	04H
        DEFB	00H
        DEFB	01H
        DEFW	1
        DEFB	2
        DEFB	64
        DEFW	9
        DEFW	0160H
        DEFB	2
        DEFW	5

        DEFB	0FDH
        DEFW	512
        DEFB	0FH
        DEFB	04H
        DEFB	01H
        DEFB	02H
        DEFW	1
        DEFB	2
        DEFB	112
        DEFW	12
        DEFW	0163H
        DEFB	2
        DEFW	5

        DEFB	0FEH
        DEFW	512
        DEFB	0FH
        DEFB	04H
        DEFB	00H
        DEFB	01H
        DEFW	1
        DEFB	2
        DEFB	64
        DEFW	7
        DEFW	013AH
        DEFB	1
        DEFW	3

        DEFB	0FFH
        DEFW	512
        DEFB	0FH
        DEFB	04H
        DEFB	01H
        DEFB	02H
        DEFW	1
        DEFB	2
        DEFB	112
        DEFW	10
        DEFW	013CH
        DEFB	1
        DEFW	3

          Subroutine __________________________
             Inputs  ________________________
             Outputs ________________________

DSKIO:	EI	
        PUSH	AF
        JP	NC,J$758F
        PUSH	AF
        PUSH	BC
        PUSH	DE
        PUSH	HL
        CALL	C$74E4
        POP	HL
        POP	DE
        POP	BC
        JR	C,J$74AC
        LD	A,(RAWFLG)
        AND	A				; verify on ?
        JR	NZ,J$74D6			; yep, verify write
J$74AC:	POP	DE
J.74AD:	POP	DE
        PUSH	AF
        LD	C,60
        JR	NC,J$74B5
        LD	C,0
J$74B5:	LD	A,0D0H
        LD	(D.7FB8),A			; FORCE INTERRUPT (cancel all operations)
        EX	(SP),HL
        EX	(SP),HL
        EX	(SP),HL
        EX	(SP),HL
        LD	A,(D.7FBB)
        LD	A,(D.7FB8)
        LD	(IX),120
        LD	A,D
        AND	A
        JR	NZ,J$74D1
        LD	(IX+1),C
        POP	AF
        RET	

J$74D1:	LD	(IX+2),C
        POP	AF
        RET	

J$74D6:	POP	AF
        SET	0,(IX+7)
        CALL	C.7595
        RES	0,(IX+7)
        JR	J.74AD

          Subroutine __________________________
             Inputs  ________________________
             Outputs ________________________

C$74E4:	CALL	C.769C
        RET	C
        SET	0,(IX+8)
        LD	A,H
        AND	A
        JP	M,J.7514
        CALL	C.794A
        RET	C
        INC	B
        DEC	B
        RET	Z
        LD	A,H
        AND	A
        JP	M,J.7514
        PUSH	HL
        PUSH	DE
        PUSH	BC
        LD	DE,(D.F34D)
        PUSH	DE
        LD	BC,512
        CALL	C.F36E

        POP	HL
        POP	BC
        POP	DE
        CALL	C.751F

        POP	HL
        JR	J$7517

        -----------------
J.7514:	CALL	C.751F

J$7517:	RET	C

        DEC	B
        RET	Z

        CALL	C.7755

        JR	J.7514

        -----------------

          Subroutine __________________________
             Inputs  ________________________
             Outputs ________________________

C.751F:	LD	E,0BH	 11 
J$7521:	CALL	C.77B8

        LD	A,0A0H				; WRITE SECTOR
        BIT	6,D
        JR	Z,J.7532
        OR	02H	 2 
        BIT	2,D
        JR	Z,J.7532
        OR	08H	 8 
J.7532:	PUSH	HL
        PUSH	DE
        PUSH	BC
        LD	DE,I$7552
        PUSH	DE
        CALL	C.FFCF
        DI	
        LD	(D.7FB8),A
        LD	BC,D.7FBC
        LD	DE,D.7FBB
J.7546:	LD	A,(BC)
        ADD	A,A
        RET	C
        JP	M,J.7546
        LD	A,(HL)
        LD	(DE),A
        INC	HL
        JP	J.7546

        -----------------
I$7552:	LD	B,6AH	 "j"
J$7554:	EX	(SP),HL
        EX	(SP),HL
        DJNZ	J$7554
        POP	BC
        POP	DE
        POP	HL
        EI	
        CALL	C.FFD4
        LD	A,(D.7FB8)
        AND	0FCH
        RET	Z

        JP	M,J.758B

        BIT	6,A
        JR	NZ,J$7588

        PUSH	AF
        CALL	C.7792

        POP	AF
        DEC	E
        JR	NZ,J$7521

        SCF	
        LD	E,A
        BIT	5,E
        LD	A,0AH	 10 
        RET	NZ

        BIT	4,E
        LD	A,08H	 8 
        RET	NZ

        BIT	3,E
        LD	A,04H	 4 
        RET	NZ

        LD	A,0CH	 12 
        RET	

        -----------------
J$7588:	XOR	A
        SCF	
        RET	

        -----------------
J.758B:	LD	A,02H	 2 
        SCF	
        RET	

        -----------------
J$758F:	CALL	C.7595

        JP	J.74AD

        -----------------

          Subroutine __________________________
             Inputs  ________________________
             Outputs ________________________

C.7595:	CALL	C.769C

        RET	C

        RES	0,(IX+8)
        LD	A,H
        AND	A
        JP	M,J.75E3

        CALL	C.794A

        RET	C

        INC	B
        DEC	B
        RET	Z

        LD	A,H
        AND	A
        JP	M,J.75E3

        BIT	0,(IX+7)
        JR	NZ,J$75C3

J$75B4:	PUSH	HL
        LD	HL,(D.F34D)
        CALL	C.75EE

        POP	HL
        RET	C

        BIT	0,(IX+7)
        JR	NZ,J$75E0

J$75C3:	PUSH	HL
        PUSH	DE
        PUSH	BC
        LD	DE,(D.F34D)
        BIT	0,(IX+7)
        JR	NZ,J$75D1

        EX	DE,HL
J$75D1:	LD	BC,512
        CALL	C.F36E

        POP	BC
        POP	DE
        POP	HL
        BIT	0,(IX+7)
        JR	NZ,J$75B4

J$75E0:	AND	A
        JR	J$75E7

        -----------------
J.75E3:	CALL	C.75EE

        RET	C

J$75E7:	DEC	B
        RET	Z

        CALL	C.7755

        JR	J.75E3

        -----------------

          Subroutine __________________________
             Inputs  ________________________
             Outputs ________________________

C.75EE:	LD	E,0BH	 11 
J$75F0:	CALL	C.77B8

        LD	A,80H				; READ SECTOR
        BIT	6,D
        JR	Z,J.7601
        OR	02H	 2 
        BIT	2,D
        JR	Z,J.7601
        OR	08H	 8 
J.7601:	PUSH	HL
        PUSH	DE
        PUSH	BC
        LD	BC,D.7FBC
        LD	DE,I$7646
        PUSH	DE
        CALL	C.FFCF
        DI	
        LD	(D.7FB8),A
        LD	DE,C.0000
        BIT	0,(IX+7)
        JR	NZ,J.766D

J.761B:	LD	A,(BC)
        ADD	A,A
        JP	P,J$7634

        RET	C

        DEC	E
        JP	NZ,J.761B

        DEC	D
        JP	NZ,J.761B

J$7629:	POP	BC
        POP	BC
        POP	DE
        POP	HL
        EI	
        CALL	C.FFD4

        JP	J.758B

        -----------------
J$7634:	LD	DE,D.7FBB
        JP	J$7640

        -----------------
J.763A:	LD	A,(BC)
        ADD	A,A
        RET	C

        JP	M,J.763A

J$7640:	LD	A,(DE)
        LD	(HL),A
        INC	HL
        JP	J.763A

        -----------------
I$7646:	POP	BC
        POP	DE
        POP	HL
        EI	
        CALL	C.FFD4
        LD	A,(D.7FB8)
        AND	9CH
        RET	Z
        JP	M,J.758B
J$7656:	PUSH	AF
        CALL	C.7792

        POP	AF
        DEC	E
        JR	NZ,J$75F0

        SCF	
        LD	E,A
        BIT	4,E
        LD	A,08H	 8 
        RET	NZ

        BIT	3,E
        LD	A,04H	 4 
        RET	NZ

        LD	A,0CH	 12 
        RET	

        -----------------
J.766D:	LD	A,(BC)
        ADD	A,A
        JP	P,J$767D

        RET	C

        DEC	E
        JP	NZ,J.766D

        DEC	D
        JP	NZ,J.766D

        JR	J$7629

        -----------------
J$767D:	LD	DE,D.7FBB
        JP	J$7689

        -----------------
J.7683:	LD	A,(BC)
        ADD	A,A
        RET	C

        JP	M,J.7683

J$7689:	LD	A,(DE)
        CP	(HL)
        INC	HL
        JP	Z,J.7683

        POP	BC
        POP	BC
        POP	DE
        POP	HL
        EI	
        EI	
        CALL	C.FFD4
        LD	A,08H	 8 
        JR	J$7656

        -----------------

          Subroutine __________________________
             Inputs  ________________________
             Outputs ________________________

C.769C:	PUSH	AF
        PUSH	BC
        PUSH	HL
        CALL	C.5FC2
        POP	HL
        POP	BC
        POP	AF
        CP	02H	 2 
        JR	C,J$76AD

J$76A9:	LD	A,0CH	 12 
        SCF	
        RET	

        -----------------
J$76AD:	PUSH	AF
        LD	A,C
        CP	0F8H
        JR	NC,J$76B6

        POP	AF
        JR	J$76A9

        -----------------
J$76B6:	POP	AF
        PUSH	IX
        PUSH	BC
        PUSH	DE
        PUSH	AF
        LD	A,(IX+9)
        DEC	A
        JR	NZ,J.76DA

        POP	AF
        LD	B,00H
        PUSH	BC
        CP	(IX+6)
        JR	Z,J.76DA
        LD	(IX+6),A
        XOR	A
        LD	(D.7FBC),A			; unselect drive, side 0, motor off
        LD	(IX+0),A
        PUSH	HL
        CALL	C$625A
        POP	HL
J.76DA:	POP	AF
        POP	DE
        POP	BC
        POP	IX
        PUSH	HL
        PUSH	AF
        PUSH	BC
        CALL	C.77B8
        BIT	1,C
        LD	C,E
        LD	B,D
        LD	DE,8
        JR	NZ,J$76EF
        INC	DE
J$76EF:	CALL	DIV16
        LD	A,L
        INC	A
        LD	(D.7FBA),A
        LD	L,C
        POP	BC
        POP	AF
        LD	H,A
        ADD	A,09H				; select drive, side 0, motor on
        BIT	0,C
        JR	Z,J.7707
        SRL	L
        JR	NC,J.7707
        OR	04H				; side 1
J.7707:	LD	D,A
        LD	A,C
        RRCA	
        RRCA	
        AND	0C0H
        OR	D
        LD	D,A
        DI	
        LD	(D.7FBC),A			; select drive, side, motor on
        LD	A,(IX+0)
        AND	A				; motor still on ?
        LD	(IX+0),0FFH
        EI	
        JR	NZ,J$7728
        PUSH	HL
        LD	HL,0
J$7722:	DEC	HL
        LD	A,L
        OR	H
        JR	NZ,J$7722
        POP	HL
J$7728:	LD	C,L
        LD	A,(IX+3)
        CP	H
        JR	Z,J$774C
        XOR	01H	 1 
        LD	(IX+3),A
        LD	A,(D.7FB9)
        JR	Z,J$7741

        LD	(IX+4),A
        LD	A,(IX+5)
        JR	J$7747

        -----------------
J$7741:	LD	(IX+5),A
        LD	A,(IX+4)
J$7747:	LD	(D.7FB9),A
        EX	(SP),HL
        EX	(SP),HL
J$774C:	LD	A,(D.7FB9)
        CP	C
        CALL	NZ,C$7798

        POP	HL
        RET	

        -----------------

          Subroutine __________________________
             Inputs  ________________________
             Outputs ________________________

C.7755:	CALL	C.77B8

        INC	H
        INC	H
        LD	A,(D.7FBA)
        INC	A
        LD	(D.7FBA),A
        BIT	7,D
        JR	NZ,J$7768

        CP	0AH	 10 
        RET	C

J$7768:	CP	09H	 9 
        RET	C
        LD	A,01H	 1 
        LD	(D.7FBA),A
        BIT	6,D
        JR	Z,J.777F
        BIT	2,D				; now on side 1 ?
        JR	NZ,J.777F			; yep, select next track and side 0
        SET	2,D				; side 1
        LD	A,D
        LD	(D.7FBC),A			; select drive, side, motor on
        RET	

        -----------------
J.777F:	RES	2,D				; side 0
        LD	A,D
        LD	(D.7FBC),A			; select drive, side, motor on
        INC	C
        CALL	C.77B8
        LD	A,51H
        LD	(D.7FB8),A			; STEP-IN (next track with trackregister update)
        EX	(SP),HL
        EX	(SP),HL
        JR	J$77A5

        -----------------

          Subroutine __________________________
             Inputs  ________________________
             Outputs ________________________

C.7792:	BIT	0,E
        RET	NZ
        CALL	C$77BF


          Subroutine __________________________
             Inputs  ________________________
             Outputs ________________________

C$7798:	LD	A,C
        LD	(D.7FBB),A
        EX	(SP),HL
        EX	(SP),HL
        LD	A,11H				; SEEK (select track)
J$77A0:	LD	(D.7FB8),A
        EX	(SP),HL
        EX	(SP),HL
J$77A5:	CALL	C.77B8
        BIT	0,(IX+8)
        RET	Z
        PUSH	BC
        LD	BC,I.0DFC
J$77B1:	DEC	BC
        LD	A,B
        OR	C
        JR	NZ,J$77B1
        POP	BC
        RET	

        -----------------

          Subroutine __________________________
             Inputs  ________________________
             Outputs ________________________

C.77B8:	LD	A,(D.7FB8)
        RRA	
        JR	C,C.77B8
        RET	

        -----------------

          Subroutine __________________________
             Inputs  ________________________
             Outputs ________________________

C$77BF:	CALL	C.77B8

        LD	A,01H	 1 
        JR	J$77A0

          Subroutine __________________________
             Inputs  ________________________
             Outputs ________________________

INIHRD:	LD	A,0D0H
        LD	(D.7FB8),A
        EX	(SP),HL
        EX	(SP),HL
        LD	A,1				; drive 0, side 0, motor off
        CALL	C.77DC
        LD	A,2				; drive 1, side 0, motor off
        CALL	C.77DC

MTOFF:	XOR	A
        LD	(D.7FBC),A			; deselect drive, side 0, motor off
        RET	

          Subroutine __________________________
             Inputs  ________________________
             Outputs ________________________

C.77DC:	LD	(D.7FBC),A			; select drive, side, motor
        CALL	C.77B8
        LD	A,01H
        LD	(D.7FB8),A			; RESTORE (select track 00)
        EX	(SP),HL
        EX	(SP),HL
        LD	HL,0
J$77EC:	LD	A,(D.7FB8)
        CPL	
        RRA					; command still busy
        RET	C				; nope, quit
        DEC	HL
        LD	A,L
        OR	H
        JR	NZ,J$77EC
        RET	

DRIVES:	PUSH	BC
        PUSH	AF
        CALL	C.5FC2
        LD	A,2				; drive 1, side 0, motor off
        CALL	C.77DC
        JR	C,J$7806			; commando finished, drive 1 is there
        INC	L				; 1 physical drive
        DEFB	0CAH
J$7806:	LD	L,2				; 2 physical drives
        LD	(IX+9),L
        XOR	A
        LD	(D.7FBC),A			; deselect drive, side 0, motor off
        POP	AF				; use panthom drives ?
        JR	Z,J$7814			; nope, return physical drives
        LD	L,2
J$7814:	POP	BC
        RET	

        -----------------
INIENV:	LD	A,1
        LD	(RAWFLG),A			; verify on
        CALL	C.5FC2
        XOR	A
        LD	B,9
J$7821:	LD	(HL),A
        INC	HL
        DJNZ	J$7821
        LD	HL,I$782B
        JP	SETINT

I$782B:	PUSH	AF
        CALL	C.5FC2
        LD	A,(HL)
        AND	A
        JR	Z,J.783E
        CP	0FFH
        JR	Z,J.783E
        DEC	A
        LD	(HL),A
        JR	NZ,J.783E
        LD	(D.7FBC),A			; deselect drive, side 0, motor off
J.783E:	INC	HL
        LD	A,(HL)
        AND	A
        JR	Z,J$7844
        DEC	(HL)
J$7844:	INC	HL
        LD	A,(HL)
        AND	A
        JR	Z,J$784A
        DEC	(HL)
J$784A:	POP	AF
        JP	PRVINT

DSKCHG:	EI	
        PUSH	HL
        PUSH	BC
        PUSH	AF
        CALL	C.5FC2
        POP	AF
        POP	BC
        POP	HL
        AND	A
        LD	B,(IX+2)
        JR	NZ,J$7861
        LD	B,(IX+1)
J$7861:	INC	B
        DEC	B
        LD	B,01H	 1 
        RET	NZ
        PUSH	BC
        PUSH	HL
        LD	DE,1
        LD	HL,(D.F34D)
        AND	A
        CALL	DSKIO
        JR	C,J.788B
        LD	HL,(D.F34D)
        LD	B,(HL)
        POP	HL
        PUSH	BC
        CALL	GETDPB
        LD	A,0CH	 12 
        JR	C,J.788B
        POP	AF
        POP	BC
        CP	C
        SCF	
        CCF	
        LD	B,0FFH
        RET	NZ
        INC	B
        RET	

J.788B:	POP	DE
        POP	DE
        RET	

          Subroutine __________________________
             Inputs  ________________________
             Outputs ________________________

GETDPB:	EI	
        EX	DE,HL
        INC	DE
        LD	A,B
        SUB	0F8H
        RET	C
        LD	L,A
        LD	H,00H
        ADD	HL,HL
        LD	C,L
        LD	B,H
        ADD	HL,HL
        ADD	HL,HL
        ADD	HL,HL
        ADD	HL,BC
        LD	BC,I$7405
        ADD	HL,BC
        LD	BC,I$0012
        LDIR	
        RET	

        -----------------
CHOICE:	LD	HL,I$78AD
        RET	

        -----------------
I$78AD:	DEFB	13,10
        DEFB	"1 - 1 side",13,10
        DEFB	"2 - 2 sides",13,10
        DEFB	"3 - 1 side, double track",13,10
        DEFB	"4 - 2 sides, double track",13,10
        DEFB	13,10
        DEFB	0

OEMSTA:	PUSH	HL
        LD	DE,J.7935
        CALL	C.791F
        LD	E,1
        JR	Z,J$7914
        LD	DE,I$793F
        CALL	C.791F
        LD	E,0
J$7912:	JR	NZ,J$791C
J$7914:	LD	C,2EH
        CALL	C.F37D
J$7919:	XOR	A
        POP	HL
        RET	

        -----------------
J$791C:	POP	HL
        SCF	
        RET	

        -----------------

          Subroutine __________________________
             Inputs  ________________________
             Outputs ________________________

C.791F:	LD	HL,I$FD89
J$7922:	LD	A,(DE)
        AND	A
        JR	Z,J.792C
        CP	(HL)
        RET	NZ
        INC	HL
J$7929:	INC	DE
        JR	J$7922

        -----------------
J.792C:	LD	A,(HL)
        AND	A
        RET	Z

        INC	HL
        CP	20H	 " "
        JR	Z,J.792C

        RET	

        -----------------
J.7935:	DEFB	"VERIFY ON",0
I$793F:	DEFB	"VERIFY OFF",0

          Subroutine __________________________
             Inputs  ________________________
             Outputs ________________________

C.794A:	PUSH	HL
        PUSH	DE
        PUSH	BC
        LD	HL,I$79C8
J$7950:	LD	DE,(D.F34D)
        LD	BC,I$01EB
        LDIR	
        LD	HL,I$7980
J.795C:	LD	E,(HL)
        INC	HL
        LD	D,(HL)
        INC	HL
        LD	A,E
        OR	D
        JR	Z,J$7979

        PUSH	HL
        LD	HL,(D.F34D)
        ADD	HL,DE
        INC	HL
J$796A:	LD	C,(HL)
        INC	HL
        LD	B,(HL)
        EX	DE,HL
        LD	HL,(D.F34D)
        ADD	HL,BC
        EX	DE,HL
        LD	(HL),D
        DEC	HL
        LD	(HL),E
        POP	HL
        JR	J.795C

        -----------------
J$7979:	POP	BC
        POP	DE
        LD	HL,(D.F34D)
        EX	(SP),HL
        RET	

        -----------------
I$7980:	LD	B,00H
        JR	NZ,J$7984

J$7984:	ADD	HL,HL
        NOP	
        INC	L
        NOP	
        LD	B,E
        NOP	
        LD	E,C
        NOP	
J$798C:	LD	E,(HL)
        NOP	
        LD	H,D
        NOP	
        LD	L,L
        NOP	
        LD	(HL),E
        NOP	
        LD	A,C
        NOP	
J$7996:	ADD	A,E
        NOP	
        ADC	A,B
        NOP	
        ADC	A,H
        NOP	
        SUB	H
        NOP	
        SBC	A,D
        NOP	
        CP	L
        NOP	
        RET	NZ

        NOP	
        JP	J$C600

        -----------------
?.79A7:	NOP	
        JP	Z,J$CF00

        NOP	
        RST	10H

        NOP	
        CALL	PO,C$F800

        NOP	
        INC	C
        LD	BC,I$012B
        LD	L,01H	 1 
        LD	SP,I$3901
        LD	BC,C.017A
        XOR	E
        LD	BC,I$01BA
        CALL	PO,C$CA01

        LD	BC,C.0000

I$79C8:	PUSH	HL
        PUSH	DE
        PUSH	BC
        CALL	C$402D

        LD	(D$016E),A
        LD	H,80H
        CALL	C.0024

        EI	
        LD	A,(D$F342)
        LD	H,40H	 "@"
        CALL	C.0024

        EI	
        POP	BC
        POP	DE
        POP	HL
        DEC	HL
        LD	A,H
        ADD	A,02H	 2 
        INC	HL
        JP	M,J.015D

        LD	E,0BH	 11 
        BIT	0,(IX+8)
        JP	NZ,J$00E4

        CALL	C.01DD

        LD	A,80H
        BIT	6,D
        JR	Z,J.7A05

        OR	02H	 2 
        BIT	2,D
        JR	Z,J.7A05

        OR	08H	 8 
J.7A05:	PUSH	HL
        PUSH	DE
        PUSH	BC
        LD	BC,D.BFBC
        LD	DE,I$00AE
        PUSH	DE
        CALL	C.FFCF

        DI	
        LD	(D.BFB8),A
        LD	DE,C.0000
        BIT	0,(IX+7)
        JR	NZ,J$7A49

        LD	A,(BC)
        ADD	A,A
        JP	P,J$0070

        RET	C

        DEC	E
        JP	NZ,J.0057

        DEC	D
        JP	NZ,J.0057

J$7A2D:	POP	BC
        POP	BC
        POP	DE
        POP	HL
        EI	
        CALL	C.FFD4

        JP	J.015A

        -----------------
?.7A38:	LD	DE,D.BFBB
        JP	J$007C

        -----------------
J$7A3E:	LD	A,(BC)
        ADD	A,A
        RET	C

        JP	M,J$0076

        LD	A,(DE)
        LD	(HL),A
        INC	HL
        JR	J$7A3E

        -----------------
J$7A49:	LD	A,(BC)
        ADD	A,A
        JP	P,J$0091

        RET	C

        DEC	E
        JP	NZ,DBUF.1

        DEC	D
        JP	NZ,DBUF.1

        JR	J$7A2D

        -----------------
?.7A59:	LD	DE,D.BFBB
        JP	J$009D

        -----------------
J$7A5F:	LD	A,(BC)
        ADD	A,A
        RET	C

        JP	M,J$0097

        LD	A,(DE)
        CP	(HL)
        INC	HL
        JR	Z,J$7A5F

        POP	BC
        POP	BC
        POP	DE
        POP	HL
        EI	
        CALL	C.FFD4

        LD	A,08H	 8 
        JR	J$7A91

        -----------------
?.7A76:	POP	BC
        POP	DE
        POP	HL
        EI	
        CALL	C.FFD4

        LD	A,(D.BFB8)
        AND	9CH
        JR	NZ,J$7A8E

        DEC	B
        JP	Z,J.015D

        CALL	C.017A

        JP	J.001B

        -----------------
J$7A8E:	JP	M,J.015A

J$7A91:	PUSH	AF
        CALL	C.01B7

        POP	AF
        DEC	E
        JP	NZ,J$002C

        LD	E,A
        BIT	4,E
        LD	A,08H	 8 
        JP	NZ,J$015C

        BIT	3,E
        LD	A,04H	 4 
        JR	NZ,J.7B24

        LD	A,0CH	 12 
        JR	J.7B24

        -----------------
J$7AAC:	CALL	C.01DD

        LD	A,0A0H
        BIT	6,D
        JR	Z,J.7ABD

        OR	02H	 2 
        BIT	2,D
        JR	Z,J.7ABD

        OR	08H	 8 
J.7ABD:	PUSH	HL
        PUSH	DE
        PUSH	BC
        LD	DE,I$0114
        PUSH	DE
        CALL	C.FFCF

        DI	
        LD	(D.BFB8),A
        LD	BC,D.BFBC
        LD	DE,D.BFBB
J$7AD1:	LD	A,(BC)
        ADD	A,A
        RET	C

        JP	M,J$0109

        LD	A,(HL)
        LD	(DE),A
        INC	HL
        JR	J$7AD1

        -----------------
?.7ADC:	LD	B,6AH	 "j"
J$7ADE:	EX	(SP),HL
        EX	(SP),HL
        DJNZ	J$7ADE

        POP	BC
        POP	DE
        POP	HL
        EI	
        CALL	C.FFD4

        LD	A,(D.BFB8)
        AND	0FCH
        JR	NZ,J$7AF9

        DEC	B
        JR	Z,J$7B25

        CALL	C.017A

        JP	J.001B

        -----------------
J$7AF9:	JP	M,J.015A

        BIT	6,A
        JR	NZ,J$7B1F

        PUSH	AF
        CALL	C.01B7

        POP	AF
        DEC	E
        JR	NZ,J$7AAC

        LD	E,A
        BIT	5,E
        LD	A,0AH	 10 
        JR	NZ,J.7B24

        BIT	4,E
        LD	A,08H	 8 
        JR	NZ,J.7B24

        BIT	3,E
        LD	A,04H	 4 
        JR	NZ,J.7B24

        LD	A,0CH	 12 
        JR	J.7B24

        -----------------
J$7B1F:	XOR	A
        JR	J.7B24

        -----------------
?.7B22:	LD	A,02H	 2 
J.7B24:	SCF	
J$7B25:	PUSH	HL
        PUSH	DE
        PUSH	BC
        PUSH	AF
        LD	A,(D$F343)
        LD	H,80H
        CALL	C.0024

        CALL	C$F368

        EI	
        LD	A,00H
        LD	H,40H	 "@"
        CALL	C.0024

        EI	
        POP	AF
        POP	BC
        POP	DE
        POP	HL
        RET	

        -----------------
?.7B42:	CALL	C.01DD

        INC	H
        INC	H
        LD	A,(D.BFBA)
        INC	A
        LD	(D.BFBA),A
        BIT	7,D
        JR	NZ,J$7B55

        CP	0AH	 10 
        RET	C

J$7B55:	CP	09H	 9 
        RET	C

        LD	A,01H	 1 
        LD	(D.BFBA),A
        BIT	6,D
        JR	Z,J.7B6C

        BIT	2,D
        JR	NZ,J.7B6C

        SET	2,D
        LD	A,D
        LD	(D.BFBC),A
        RET	

        -----------------
J.7B6C:	RES	2,D
        LD	A,D
        LD	(D.BFBC),A
        INC	C
        CALL	C.01DD

        LD	A,51H	 "Q"
        LD	(D.BFB8),A
        EX	(SP),HL
        EX	(SP),HL
        JR	J$7B92

        -----------------
?.7B7F:	BIT	0,E
        RET	NZ

        CALL	C$01E4

        LD	A,C
        LD	(D.BFBB),A
        EX	(SP),HL
        EX	(SP),HL
        LD	A,11H	 17 
J$7B8D:	LD	(D.BFB8),A
        EX	(SP),HL
        EX	(SP),HL
J$7B92:	CALL	C.01DD

        BIT	0,(IX+8)
        RET	Z

        PUSH	BC
        LD	BC,I.0DFC
J$7B9E:	DEC	BC
        LD	A,B
        OR	C
        JR	NZ,J$7B9E

        POP	BC
        RET	

        -----------------
J$7BA5:	LD	A,(D.BFB8)
        RRA	
        JR	C,J$7BA5

        RET	

        -----------------
?.7BAC:	CALL	C.01DD

        LD	A,01H	 1 
        JR	J$7B8D

        -----------------
DSKFMT:	PUSH	HL
        POP	IY
        DEC	A
        LD	E,A
        LD	A,03H	 3 
        CP	E
        LD	A,0CH	 12 
        RET	C
        LD	A,B
        CP	18H
        LD	A,0EH	 14 
        RET	C
        LD	A,D
        AND	01H	 1 
        LD	(IY+9),A
        PUSH	HL
        LD	BC,I$0020
        ADD	HL,BC
        LD	(IY+5),L
        LD	(IY+6),H
        LD	D,00H
        LD	B,05H	 5 
        LD	HL,I$7D01
J$7BDC:	ADD	HL,DE
        DJNZ	J$7BDC
        POP	DE
        LD	BC,5
        LDIR	
        CALL	INIHRD
        XOR	A
        LD	(IX+4),A
        LD	(IX+5),A
        LD	A,(IY+9)
        LD	DE,C.0000
        LD	BC,I$00FF
        CALL	C.769C

        RET	C

        CALL	C.FFCF

        DI	
        LD	E,02H	 2 
        CALL	C.7E67

        RET	C

        LD	E,00H
        CALL	C.7E67

        RET	C

        LD	C,(IY+2)
        LD	B,09H	 9 
        LD	DE,C.0000
J$7C14:	PUSH	DE
        PUSH	BC
        LD	A,(IY+9)
        CALL	C.769C

        LD	A,06H	 6 
        JR	C,J$7C2E

        LD	(IY+7),D
        LD	L,(IY+5)
        LD	H,(IY+6)
        PUSH	HL
        CALL	C.7D8D

        POP	HL
J$7C2E:	POP	BC
        POP	DE
        JR	NC,J$7C3C

        PUSH	AF
        LD	A,(IY+9)
        LD	D,A
        POP	AF
        PUSH	DE
        JP	J.74AD

        -----------------
J$7C3C:	PUSH	DE
        PUSH	BC
        LD	A,D
        OR	E
        JR	Z,J.7C4D

        PUSH	HL
        LD	HL,J.001B
        SBC	HL,DE
        POP	HL
        JR	C,J.7C4D

        DEC	DE
        INC	B
J.7C4D:	XOR	A
        LD	A,(IY+9)
        CALL	DSKIO

        LD	A,04H	 4 
        POP	BC
        POP	DE
        RET	C

        PUSH	HL
        LD	HL,I$013B
        BIT	0,C
        JR	Z,J$7C62

        ADD	HL,HL
J$7C62:	AND	A
        SBC	HL,DE
        POP	HL
        JR	NC,J$7C89

        PUSH	DE
        PUSH	BC
        PUSH	HL
        LD	B,01H	 1 
        LD	HL,I$0007
        BIT	0,C
        JR	Z,J$7C77

        LD	HL,C.0010
J$7C77:	AND	A
        EX	DE,HL
        SBC	HL,DE
        EX	DE,HL
        POP	HL
        XOR	A
        LD	A,(IY+9)
        CALL	DSKIO

        LD	A,04H	 4 
        POP	BC
        POP	DE
        RET	C

J$7C89:	LD	H,00H
        LD	L,B
        ADD	HL,DE
        EX	DE,HL
        LD	A,(IY+4)
        SUB	D
        JR	NZ,J$7D14

        LD	A,(IY+3)
        SUB	E
        JP	NZ,J$7C14

        LD	L,(IY+5)
        LD	H,(IY+6)
        PUSH	HL
        LD	BC,I$1800
J$7CA5:	LD	(HL),00H
        INC	HL
        DEC	BC
        LD	A,B
        OR	C
        JR	NZ,J$7CA5

        LD	L,(IY)
        LD	H,(IY+1)
        POP	DE
        PUSH	DE
        LD	BC,I$001E
        LDIR	
        LD	HL,I$7E82
        LD	BC,I$00A7
        LDIR	
        POP	HL
        PUSH	HL
        LD	A,(IY+2)
        INC	H
        INC	H
        LD	(HL),A
        INC	HL
        DEC	(HL)
        INC	HL
        DEC	(HL)
        INC	H
        INC	H
        INC	H
        INC	H
        CP	0F9H
        JR	NZ,J$7CD8

        INC	H
        INC	H
J$7CD8:	DEC	(HL)
        DEC	HL
        DEC	(HL)
        DEC	HL
        LD	(HL),A
        POP	HL
        PUSH	HL
        LD	B,0CH	 12 
        LD	C,A
        LD	A,(IY+9)
        LD	DE,C.0000
        SCF	
        CALL	DSKIO

        POP	HL
        RET	C

        LD	BC,I$0E00
        ADD	HL,BC
        LD	B,02H	 2 
        LD	C,(IY+2)
        LD	DE,I$000C
        LD	A,(IY+9)
        SCF	
        JP	DSKIO

        -----------------
I$7D01:	DEFW	I$7D15
        DEFB	0FCH
        DEFW	0168H

        DEFW	I$7D33
        DEFB	0FDH
        DEFW	02D0H

        DEFW	I$7D51
        DEFB	0F8H
        DEFW	02D0H

        DEFW	I$7D6F
        DEFB	0F9H
        DEFW	05A0H

I$7D15:	DEFB	0EBH
        DEFB	0FEH
        DEFB	090H
        DEFB	"MSX_01  "
        DEFW	512
        DEFB	1
        DEFW	1
        DEFB	2
        DEFW	64
        DEFW	0168H
        DEFB	0FCH
        DEFW	2
        DEFW	9
        DEFW	1
        DEFW	0

I$7D33:	DEFB	0EBH
        DEFB	0FEH
        DEFB	090H
        DEFB	"MSX_02  "
        DEFW	512
        DEFB	2
        DEFW	1
        DEFB	2
        DEFW	112
        DEFW	02D0H
        DEFB	0FDH
        DEFW	2
        DEFW	9
        DEFW	2
        DEFW	0

I$7D51:	DEFB	0EBH
        DEFB	0FEH
        DEFB	090H
        DEFB	"MSX_03  "
        DEFW	512
        DEFB	2
        DEFW	1
        DEFB	2
        DEFW	112
        DEFW	02D0H
        DEFB	0F8H
        DEFW	2
        DEFW	9
        DEFW	1
        DEFW	0

I$7D6F:	DEFB	0EBH
        DEFB	0FEH
        DEFB	090H
        DEFB	"MSX_04  "
        DEFW	512
        DEFB	2
        DEFW	1
        DEFB	2
        DEFW	112
        DEFW	05A0H
        DEFB	0F9H
        DEFW	3
        DEFW	9
        DEFW	2
        DEFW	0

          Subroutine __________________________
             Inputs  ________________________
             Outputs ________________________

C.7D8D:	LD	D,01H	 1 
        LD	A,4EH	 "N"
        LD	B,50H	 "P"
        CALL	C.7E7D

        CALL	C.7E7A

        LD	A,0F6H
J$7D9A	EQU	$-1
        LD	B,03H	 3 
        CALL	C.7E7D

        LD	(HL),0FCH
        INC	HL
        LD	A,4EH	 "N"
        LD	B,32H	 "2"
        CALL	C.7E7D

J$7DAA:	CALL	C.7E7A
J$7DAC	EQU	$-1

        LD	A,0F5H
        LD	B,03H	 3 
        CALL	C.7E7D

        LD	(HL),0FEH
        INC	HL
        CALL	C.77B8

        LD	A,(D.7FB9)
        LD	(HL),A
        INC	HL
        LD	A,(IY+7)
        AND	04H	 4 
        RRCA	
        RRCA	
        LD	(HL),A
        INC	HL
        LD	(HL),D
        INC	HL
        LD	(HL),02H	 2 
        INC	HL
        LD	(HL),0F7H
        INC	HL
        LD	A,4EH	 "N"
        LD	B,16H
        CALL	C.7E7D

        CALL	C.7E7A

        LD	A,0F5H
        LD	B,03H	 3 
        CALL	C.7E7D

        LD	(HL),0FBH
        INC	HL
        LD	BC,512
J$7DE7:	LD	(HL),40H	 "@"
        INC	HL
        DEC	BC
        LD	A,B
        OR	C
        JR	NZ,J$7DE7

        LD	(HL),0F7H
        INC	HL
        LD	B,54H	 "T"
        LD	A,4EH	 "N"
        CALL	C.7E7D

        INC	D
        LD	A,09H	 9 
        CP	D
        JR	NC,J$7DAA

        LD	(HL),0FFH
        LD	(IY+8),05H	 5 
J$7E05:	CALL	C.77B8

        LD	HL,I$7E3E
        PUSH	HL
        LD	L,(IY+5)
        LD	H,(IY+6)
        CALL	C.FFCF

        DI	
        LD	BC,D.7FBC
        LD	DE,D.7FBB
        LD	A,0F4H
        LD	(D.7FB8),A			; FORMAT TRACK
J$7E21:	LD	A,(HL)
        INC	A
        JP	Z,J.7E32

J$7E26:	LD	A,(BC)
        ADD	A,A
        RET	C

        JP	M,J$7E26

        LD	A,(HL)
        LD	(DE),A
        INC	HL
        JP	J$7E21

        -----------------
J.7E32:	LD	A,(BC)
        ADD	A,A
        RET	C

        JP	M,J.7E32

        LD	A,4EH	 "N"
        LD	(DE),A
        JP	J.7E32

        -----------------
I$7E3E:	LD	A,(D.7FB8)
        AND	7CH	 "|"
        PUSH	AF
        JR	NZ,J$7E4A

        EI	
        CALL	C.FFD4

J$7E4A:	POP	AF
        RET	Z

        LD	B,A
        BIT	6,B
        LD	A,00H
        JR	NZ,J$7E55

        LD	A,10H	 16 
J$7E55:	DEC	(IY+8)
        JR	NZ,J$7E05

J$7E5A:	PUSH	AF
        EI	
        CALL	C.FFD4
        POP	AF
        LD	HL,D.7FBC
        LD	(HL),0				; deselect drive, side 0, motor off
        SCF	
        RET	

        -----------------

          Subroutine __________________________
             Inputs  ________________________
             Outputs ________________________

C.7E67:	LD	BC,I$FFFF
J$7E6A:	LD	A,(D.7FB8)
        AND	02H	 2 
        CP	E
        RET	Z

        DEC	BC
        LD	A,B
        OR	C
        JR	NZ,J$7E6A

        LD	A,02H	 2 
        JR	J$7E5A

        -----------------

          Subroutine __________________________
             Inputs  ________________________
             Outputs ________________________

C.7E7A:	XOR	A
        LD	B,0CH	 12 

          Subroutine __________________________
             Inputs  ________________________
             Outputs ________________________

C.7E7D:	LD	(HL),A
        INC	HL
        DJNZ	C.7E7D

        RET	

I$7E82:
        .PHASE	0C01EH

        RET	NC
        LD	(DC058+1),DE
        LD	(DC0C4),A
        LD	(HL),LOW DC056
        INC	HL
        LD	(HL),HIGH DC056
J$C02A:	LD	SP,KBUF+256
        LD	DE,DC09F
        LD	C,0FH	; 15 
        CALL	BDOS
        INC	A
        JP	Z,DC063
        LD	DE,J.0100
        LD	C,1AH
        CALL	BDOS
        LD	HL,1
        LD	(DC09F+14),HL
        LD	HL,04000H-0100H
        LD	DE,DC09F
        LD	C,27H	; "'"
        CALL	BDOS
        JP	J.0100

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
        CALL	BDOS
        LD	C,07H	; 7 
        CALL	BDOS
        JR	J$C02A

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

        RST	38H
        RST	38H
        RST	38H
J$7F2C:	RST	38H
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
J$7F48:	RST	38H
        RST	38H
        RST	38H
        RST	38H
        RST	38H
        RST	38H
        RST	38H
        RST	38H
        RST	38H
J$7F51:	RST	38H
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
J$7F5E:	RST	38H
J$7F5F:	RST	38H
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
J$7F6E:	RST	38H
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
D.7FB8:	RST	38H
D.7FB9:	RST	38H
D.7FBA:	RST	38H
D.7FBB:	RST	38H
D.7FBC:	RST	38H
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
        END
