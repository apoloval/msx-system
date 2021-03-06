;  
;   KORSUB -> Source re-created by Z80DIS 2.2
;      Z80DIS was written by Kenneth Gielow
;                            Palo Alto, CA
;

; Korean MSX2 subrom, Daewoo CPC-400S
; 27 differences with HB-F900 subrom

        .Z80
        ORG	0000H
;
I.4000	EQU	4000H	; ----I
I.4038	EQU	4038H	; ----I
I$4055	EQU	4055H	; ----I
I$406A	EQU	406AH	; ----I
I$406D	EQU	406DH	; ----I
I$406F	EQU	406FH	; ----I
I$40FE	EQU	40FEH	; ----I
I$40FF	EQU	40FFH	; ----I
D$4220	EQU	4220H	; --S--
I.46E6	EQU	46E6H	; ----I
I.46FF	EQU	46FFH	; ----I
I$475A	EQU	475AH	; ----I
I$4C64	EQU	4C64H	; ----I
I$4D37	EQU	4D37H	; ----I
I$4FCF	EQU	4FCFH	; ----I
I$5100	EQU	5100H	; ----I
I$520F	EQU	520FH	; ----I
I$5211	EQU	5211H	; ----I
I$521C	EQU	521CH	; ----I
J$5417	EQU	5417H	; J----
I$542F	EQU	542FH	; ----I
I$5439	EQU	5439H	; ----I
D$5600	EQU	5600H	; ---L-
I$579C	EQU	579CH	; ----I
I$57AB	EQU	57ABH	; ----I
D$5D3A	EQU	5D3AH	; ---L-
I$5EA4	EQU	5EA4H	; ----I
I$6053	EQU	6053H	; ----I
I$6275	EQU	6275H	; ----I
I$6545	EQU	6545H	; ----I
I$6627	EQU	6627H	; ----I
I$6678	EQU	6678H	; ----I
I$67D0	EQU	67D0H	; ----I
I$6A00	EQU	6A00H	; ----I
I$6A0E	EQU	6A0EH	; ----I
I$6B24	EQU	6B24H	; ----I
I$6E6B	EQU	6E6BH	; ----I
I$6E6E	EQU	6E6EH	; ----I
I$6E74	EQU	6E74H	; ----I
I$6E86	EQU	6E86H	; ----I
I$7017	EQU	7017H	; ----I
I$7117	EQU	7117H	; ----I
I$7323	EQU	7323H	; ----I
I$7328	EQU	7328H	; ----I
I.7876	EQU	7876H	; ----I
D$7D0E	EQU	7D0EH	; ---L-
I$7EE4	EQU	7EE4H	; ----I
I$7EF2	EQU	7EF2H	; ----I
I$7FFD	EQU	7FFDH	; ----I
I$7FFF	EQU	7FFFH	; ----I
I$801E	EQU	801EH	; ----I
J.A2CD	EQU	0A2CDH	; J----
I$AECD	EQU	0AECDH	; ----I
J$CDF0	EQU	0CDF0H	; J----
I$E5C5	EQU	0E5C5H	; ----I
I$E600	EQU	0E600H	; ----I
I.F0FA	EQU	0F0FAH	; ----I
C$F380	EQU	0F380H	; -C---
J$F385	EQU	0F385H	; J----
J.F38C	EQU	0F38CH	; J----
C$F398	EQU	0F398H	; -C---
D.F3AE	EQU	0F3AEH	; --SL-
D.F3AF	EQU	0F3AFH	; --SL-
D.F3B0	EQU	0F3B0H	; --SLI
D.F3B1	EQU	0F3B1H	; ---LI
D$F3B2	EQU	0F3B2H	; --S--
D.F3B3	EQU	0F3B3H	; ---LI
D.F3B5	EQU	0F3B5H	; --SL-
D.F3B7	EQU	0F3B7H	; ---L-
D.F3B9	EQU	0F3B9H	; --SLI
D.F3BA	EQU	0F3BAH	; --S--
D.F3BD	EQU	0F3BDH	; ---L-
D.F3BF	EQU	0F3BFH	; ---L-
D.F3C1	EQU	0F3C1H	; ---L-
D.F3C3	EQU	0F3C3H	; ---L-
D.F3C5	EQU	0F3C5H	; ---L-
D.F3C7	EQU	0F3C7H	; ---L-
D.F3C9	EQU	0F3C9H	; ---L-
D.F3CB	EQU	0F3CBH	; ---L-
D.F3CD	EQU	0F3CDH	; ---L-
D.F3CF	EQU	0F3CFH	; ---L-
D.F3D1	EQU	0F3D1H	; ---L-
D.F3D5	EQU	0F3D5H	; ---L-
D.F3D7	EQU	0F3D7H	; ---L-
D.F3D9	EQU	0F3D9H	; ---L-
D.F3DB	EQU	0F3DBH	; --SL-
D.F3DC	EQU	0F3DCH	; --SL-
D.F3DE	EQU	0F3DEH	; --SL-
D.F3DF	EQU	0F3DFH	; --SLI
D.F3E0	EQU	0F3E0H	; --SL-
D.F3E1	EQU	0F3E1H	; --SL-
D$F3E2	EQU	0F3E2H	; --S--
D$F3E3	EQU	0F3E3H	; --S--
D$F3E4	EQU	0F3E4H	; --S--
D$F3E5	EQU	0F3E5H	; --S--
D$F3E6	EQU	0F3E6H	; ---L-
D.F3E9	EQU	0F3E9H	; --SL-
D.F3EA	EQU	0F3EAH	; --SLI
D.F3EB	EQU	0F3EBH	; --SL-
D.F3F2	EQU	0F3F2H	; --SL-
D.F3F8	EQU	0F3F8H	; --SL-
D$F3FA	EQU	0F3FAH	; ---L-
D.F3FC	EQU	0F3FCH	; ---LI
I$F401	EQU	0F401H	; ----I
I.F406	EQU	0F406H	; ----I
D.F40B	EQU	0F40BH	; --S--
D.F40D	EQU	0F40DH	; --S--
D.F417	EQU	0F417H	; --SL-
D$F4FD	EQU	0F4FDH	; --S--
D.F55E	EQU	0F55EH	; --SLI
D.F560	EQU	0F560H	; --SL-
D.F561	EQU	0F561H	; --SL-
D.F562	EQU	0F562H	; --SLI
D.F564	EQU	0F564H	; --SL-
D$F565	EQU	0F565H	; --S--
D.F566	EQU	0F566H	; ---LI
D.F568	EQU	0F568H	; --SL-
D.F569	EQU	0F569H	; --S--
D.F56A	EQU	0F56AH	; --SL-
D.F56C	EQU	0F56CH	; --SL-
D.F56F	EQU	0F56FH	; --SL-
D$F570	EQU	0F570H	; --S--
D.F571	EQU	0F571H	; --SL-
D.F573	EQU	0F573H	; --SL-
D.F575	EQU	0F575H	; --S--
I.F577	EQU	0F577H	; ----I
D$F585	EQU	0F585H	; --S--
D.F5A0	EQU	0F5A0H	; --SL-
D.F5A2	EQU	0F5A2H	; --SL-
D.F5A4	EQU	0F5A4H	; --SL-
D.F5A6	EQU	0F5A6H	; --SL-
D.F5A8	EQU	0F5A8H	; --SL-
D$F661	EQU	0F661H	; ---L-
D.F663	EQU	0F663H	; --SL-
D.F666	EQU	0F666H	; --SL-
D.F668	EQU	0F668H	; --SL-
D.F669	EQU	0F669H	; --SL-
D.F66A	EQU	0F66AH	; --SLI
D$F699	EQU	0F699H	; ---L-
D.F6A5	EQU	0F6A5H	; --S--
D.F6C6	EQU	0F6C6H	; --SL-
D.F7F6	EQU	0F7F6H	; --SLI
D.F7F8	EQU	0F7F8H	; --SL-
I$F847	EQU	0F847H	; ----I
D$F862	EQU	0F862H	; --S--
D$F864	EQU	0F864H	; --S--
I.F866	EQU	0F866H	; ----I
D$F87C	EQU	0F87CH	; --S--
I$F87F	EQU	0F87FH	; ----I
I$F8CF	EQU	0F8CFH	; ----I
D.F91F	EQU	0F91FH	; ---L-
D.F920	EQU	0F920H	; ---L-
D.F922	EQU	0F922H	; --SL-
D.F924	EQU	0F924H	; --SL-
D.F926	EQU	0F926H	; --SL-
D.F928	EQU	0F928H	; --SL-
D.F92A	EQU	0F92AH	; --SL-
D.F92C	EQU	0F92CH	; --SL-
D.F942	EQU	0F942H	; --SL-
D.F944	EQU	0F944H	; --SL-
D.F949	EQU	0F949H	; --SL-
D.F94A	EQU	0F94AH	; --SL-
D.F94B	EQU	0F94BH	; --SL-
D.F94D	EQU	0F94DH	; ---L-
D.F94F	EQU	0F94FH	; ---L-
D.F951	EQU	0F951H	; --SL-
D.F953	EQU	0F953H	; --SL-
D.F954	EQU	0F954H	; --SL-
D.F955	EQU	0F955H	; --SL-
J$FA80	EQU	0FA80H	; J----
D.FAF5	EQU	0FAF5H	; --SL-
D.FAF6	EQU	0FAF6H	; --SL-
D.FAF7	EQU	0FAF7H	; --S-I
D.FAF8	EQU	0FAF8H	; --SL-
D$FAF9	EQU	0FAF9H	; --S--
D.FAFC	EQU	0FAFCH	; --SLI
D.FAFE	EQU	0FAFEH	; --SL-
D.FAFF	EQU	0FAFFH	; --SLI
D.FB00	EQU	0FB00H	; --SL-
D.FB01	EQU	0FB01H	; --SL-
D.FB02	EQU	0FB02H	; --SL-
I$FBB1	EQU	0FBB1H	; ----I
I$FBB2	EQU	0FBB2H	; ----I
I$FBCA	EQU	0FBCAH	; ----I
D$FBCD	EQU	0FBCDH	; --S--
D.FBD9	EQU	0FBD9H	; --SL-
D.FBEB	EQU	0FBEBH	; ---L-
I$FBF0	EQU	0FBF0H	; ----I
D.FC18	EQU	0FC18H	; --SLI
I.FC1A	EQU	0FC1AH	; ----I
D.FC24	EQU	0FC24H	; --SL-
D.FC26	EQU	0FC26H	; --SL-
D.FC28	EQU	0FC28H	; --SL-
D.FC2C	EQU	0FC2CH	; ---L-
D.FC32	EQU	0FC32H	; --SL-
D.FC34	EQU	0FC34H	; --SLI
D.FC35	EQU	0FC35H	; --SL-
D.FC36	EQU	0FC36H	; ---L-
D.FC38	EQU	0FC38H	; --SLI
D.FC40	EQU	0FC40H	; --S-I
D$FC9B	EQU	0FC9BH	; ---L-
I$FCA6	EQU	0FCA6H	; ----I
D.FCAC	EQU	0FCACH	; --SL-
D.FCAD	EQU	0FCADH	; --SL-
D.FCAF	EQU	0FCAFH	; --SL-
D.FCB0	EQU	0FCB0H	; --SL-
D.FCB2	EQU	0FCB2H	; --SL-
D.FCB3	EQU	0FCB3H	; --SL-
D.FCB5	EQU	0FCB5H	; --SL-
D.FCB7	EQU	0FCB7H	; --SL-
D.FCB9	EQU	0FCB9H	; --SL-
D$FCC0	EQU	0FCC0H	; ---L-
D.FCC1	EQU	0FCC1H	; ---LI
D.FCC5	EQU	0FCC5H	; --S-I
J$FCFB	EQU	0FCFBH	; J----
D.FD09	EQU	0FD09H	; --SLI
D.FD0C	EQU	0FD0CH	; --SL-
I.FD89	EQU	0FD89H	; ----I
D$FDA4	EQU	0FDA4H	; ---L-
C$FDC7	EQU	0FDC7H	; -C---
J$FDD6	EQU	0FDD6H	; J----
I.FE00	EQU	0FE00H	; ----I
D$FEFD	EQU	0FEFDH	; --S--
D$FEFF	EQU	0FEFFH	; --S--
I$FF08	EQU	0FF08H	; ----I
C$FF2A	EQU	0FF2AH	; -C---
C$FF48	EQU	0FF48H	; -C---
D$FFA7	EQU	0FFA7H	; ---L-
I$FFDE	EQU	0FFDEH	; ----I
I$FFDF	EQU	0FFDFH	; ----I
D.FFE7	EQU	0FFE7H	; ---LI
D.FFE8	EQU	0FFE8H	; --SLI
D$FFE9	EQU	0FFE9H	; --S--
D$FFEA	EQU	0FFEAH	; --S--
D$FFF1	EQU	0FFF1H	; --S--
D.FFF7	EQU	0FFF7H	; --S-I
I$FFF8	EQU	0FFF8H	; ----I
I$FFFD	EQU	0FFFDH	; ----I
D.FFFF	EQU	0FFFFH	; --SLI
;
        LD	B,E
D.0001:	LD	B,H
I$0002:	LD	(HL),03H	; 3 
D.0003	EQU	$-1
I.0004:	LD	C,C
BDOS:	LD	D,0D5H
CPMADR	EQU	$-1
I$0007:	LD	(HL),0C3H
C.0008	EQU	$-1
I.0009:	LD	(D$001D),A
I.000B	EQU	$-1
I$000C:	DEFB	0,0
I$000E:	DEFB	0,0
;
;	  Subroutine __________________________
;	     Inputs  ________________________
;	     Outputs ________________________
;
C.0010:	JP	J.1D3A
;
;	-----------------
?.0013:	NOP	
I$0014:	JP	C.0218
;
;	-----------------
?.0017:	NOP	
;
;	  Subroutine __________________________
;	     Inputs  ________________________
;	     Outputs ________________________
;
C.0018:	JP	J$0577
;
;	-----------------
?.001B:	NOP	
;
;	  Subroutine __________________________
;	     Inputs  ________________________
;	     Outputs ________________________
;
C.001C:	JP	C.0262
D$001D	EQU	$-2
;
;	-----------------
?.001F:	NOP	
;
;	  Subroutine __________________________
;	     Inputs  ________________________
;	     Outputs ________________________
;
C.0020:	LD	A,H
        SUB	D
        RET	NZ
;
        LD	A,L
        SUB	E
        RET	
;
;	-----------------
?.0026:	DEFB	0,0
;
;	  Subroutine __________________________
;	     Inputs  ________________________
;	     Outputs ________________________
;
C.0028:	JP	C.060E
;
;	-----------------
?.002B:	DEFB	0,0,0
J$002E:	DEFB	0
        POP	AF
;
;	  Subroutine __________________________
;	     Inputs  ________________________
;	     Outputs ________________________
;
C$0030:	JP	J$0246
;
;	-----------------
?.0033:	LD	BC,I$801E
        LD	BC,I$081E
X.0038	EQU	$-1
        EXX	
        PUSH	AF
        PUSH	BC
        PUSH	DE
        PUSH	HL
        EX	AF,AF'
        EXX	
        PUSH	IX
        PUSH	IY
        LD	IX,X.0038
        LD	IY,(D$FCC0)
        CALL	C.058D
;
        POP	IY
        POP	IX
        EX	AF,AF'
        EXX	
        POP	HL
        POP	DE
        POP	BC
        POP	AF
        EX	AF,AF'
        EXX	
        EI	
        RETI	
        SUB	C
        DEC	DE
        CP	C
        JR	NZ,J$0069
;
        CALL	C$0E34
;
        JP	J$FDD6
;
;	-----------------
J$0069:	EI	
        JP	J$2651
;
;	-----------------
FCB2:	EI	
        JP	J$2556
;
;	-----------------
?.0071:	EI	
        JP	C.256F
;
;	-----------------
?.0075:	EI	
        JP	J$2607
;
;	-----------------
?.0079:	EI	
        JP	J$262A
;
;	-----------------
?.007D:	EI	
        JP	J.263F
DBUF	EQU	$-1
;
;	-----------------
DBUF.1:	EI	
        JP	J.2648
D$0083	EQU	$-2
;
;	-----------------
?.0085:	EI	
        JP	C.2823
;
;	-----------------
?.0089:	EI	
        JP	J$110E
;
;	-----------------
?.008D:	EI	
        JP	C.12C4
I.0090	EQU	$-1
;
;	-----------------
?.0091:	EI	
        JP	C.1342
;
;	-----------------
?.0095:	EI	
        JP	C.1384
;
;	-----------------
?.0099:	EI	
        JP	C.13AD
;
;	-----------------
?.009D:	EI	
        JP	C.13B5
I$009F	EQU	$-2
;
;	-----------------
?.00A1:	EI	
        JP	C.1426
;
;	-----------------
?.00A5:	EI	
        JP	J.1439
;
;	-----------------
?.00A9:	EI	
        JP	C.13E7
;
;	-----------------
?.00AD:	EI	
        JP	J$144B
;
;	-----------------
?.00B1:	EI	
        JP	C.13FC
;
;	-----------------
?.00B5:	EI	
        JP	J$148C
;
;	-----------------
?.00B9:	EI	
        JP	C.1414
;
;	-----------------
I$00BD:	EI	
        JP	J$1498
I$00BF	EQU	$-2
I$00C0	EQU	$-1
;
;	-----------------
?.00C1:	EI	
        JP	C.14DB
;
;	-----------------
?.00C5:	EI	
        JP	C.158F
;
;	-----------------
I$00C9:	EI	
        JP	C.27E7
;
;	-----------------
?.00CD:	EI	
        JP	C.2898
;
;	-----------------
?.00D1:	EI	
        JP	J$09C3
I$00D3	EQU	$-2
I.00D4	EQU	$-1
;
;	-----------------
?.00D5:	EI	
        JP	J$09E5
;
;	-----------------
?.00D9:	EI	
        JP	C.0A1A
;
;	-----------------
?.00DD:	EI	
        JP	J$0A48
;
;	-----------------
?.00E1:	EI	
        JP	J$0A98
;
;	-----------------
?.00E5:	EI	
        JP	C.0B42
;
;	-----------------
?.00E9:	EI	
        JP	C.0B9C
;
;	-----------------
?.00ED:	EI	
        JP	C.0BD2
J$00F0	EQU	$-1
;
;	-----------------
?.00F1:	EI	
        JP	C.0C22
;
;	-----------------
?.00F5:	EI	
        JP	C.06F5
I$00F8	EQU	$-1
;
;	-----------------
?.00F9:	EI	
        JP	J$0755
;
;	-----------------
?.00FD:	EI	
        JP	C.076A
I.00FF	EQU	$-2
I.0100	EQU	$-1
;
;	-----------------
I$0101:	EI	
        JP	C.077F
I$0103	EQU	$-2
;
;	-----------------
?.0105:	EI	
        JP	C.07D9
I$0108	EQU	$-1
;
;	-----------------
?.0109:	EI	
        JP	C.08CB
;
;	-----------------
?.010D:	EI	
        JP	C.08D6
;
;	-----------------
?.0111:	EI	
        JP	C.0953
;
;	-----------------
?.0115:	EI	
        JP	C.07FE
;
;	-----------------
?.0119:	EI	
        JP	C.0864

; DSPFNK
?.011D:	EI	
        JP	J$2AC3			; japanese MSX2: 0D52
;
;	-----------------
?.0121:	EI	
        JP	J$0E0F
;
;	-----------------
?.0125:	EI	
        JP	J$0E5D
;
;	-----------------
?.0129:	EI	
        JP	J$0F16
;
;	-----------------
?.012D:	EI	
        JP	C.0647
;
;	-----------------
;
;	  Subroutine __________________________
;	     Inputs  ________________________
;	     Outputs ________________________
;
C.0131:	EI	
        JP	C.298B
;
;	-----------------
?.0135:	EI	
        JP	J$3F04
;
;	-----------------
?.0139:	EI	
        JP	J$3CC9
;
;	-----------------
?.013D:	EI	
J$013E:	JP	C.06A8
;
;	-----------------
I$0141:	EI	
        JP	C.0F9F
;
;	-----------------
?.0145:	EI	
        JP	J.0F7E
;
;	-----------------
?.0149:	EI	
        JP	C.0F6A
;
;	-----------------
?.014D:	EI	
        JP	C.0FD3
;
;	-----------------
?.0151:	EI	
        JP	J$208F
;
;	-----------------
?.0155:	EI	
        JP	J$1DF6
;
;	-----------------
?.0159:	EI	
        JP	J$1EE5
;
;	-----------------
?.015D:	EI	
        JP	J$1FDF
;
;	-----------------
?.0161:	EI	
        JP	J$21C6
;
;	-----------------
?.0165:	EI	
        JP	J$21E5
I$0168	EQU	$-1
;
;	-----------------
?.0169:	EI	
        JP	J$2220
;
;	-----------------
?.016D:	EI	
        JP	J$2297
;
;	-----------------
?.0171:	EI	
        JP	J$22F4
;
;	-----------------
?.0175:	EI	
        JP	J$2307
;
;	-----------------
?.0179:	EI	
        JP	J$1833
;
;	-----------------
?.017D:	EI	
        JP	J.1A62
;
;	-----------------
?.0181:	EI	
        JP	J$1B4E
I$0183	EQU	$-2
;
;	-----------------
?.0185:	EI	
I.0186:	JP	J$0480
;
;	-----------------
I.0189:	EI	
        JP	J$0470
I$018C	EQU	$-1
;
;	-----------------
?.018D:	EI	
        JP	J$2342
I$018F	EQU	$-2
;
;	-----------------
?.0191:	EI	
I$0192:	JP	J.2EB9
;
;	-----------------
I$0195:	EI	
        JP	J.2F42
;
;	-----------------
?.0199:	EI	
        JP	J.2EDF
;
;	-----------------
?.019D:	EI	
        JP	J.30A8
;
;	-----------------
?.01A1:	EI	
        JP	J.31B4
;
;	-----------------
?.01A5:	EI	
        JP	J.306F
;
;	-----------------
?.01A9:	EI	
        JP	J.307C
;
;	-----------------
?.01AD:	EI	
        JP	J$34DD
;
;	-----------------
?.01B1:	EI	
        JP	J$1683
;
;	-----------------
?.01B5:	EI	
        JP	C.09BF
;
;	-----------------
?.01B9:	EI	
        JP	C.0000
;
;	-----------------
?.01BD:	EI	
        JP	J.1049
;
;	-----------------
J$01C1:	LD	A,B
        AND	3FH	; "?"
        OUT	(0A8H),A
        LD	A,(D.FFFF)
        CPL	
        LD	C,A
        AND	D
        LD	E,A
        LD	(D.FFFF),A
        LD	A,B
        AND	D
        OUT	(0A8H),A
        LD	A,E
        LD	(D.FCC5),A
        PUSH	BC
        EXX	
        EX	AF,AF'
        CALL	C$F398
;
        DI	
        EX	AF,AF'
        EXX	
        POP	BC
        LD	A,B
        AND	3FH	; "?"
        OUT	(0A8H),A
        LD	A,C
        LD	(D.FFFF),A
        LD	A,B
        OUT	(0A8H),A
        LD	A,C
        LD	(D.FCC5),A
        EX	AF,AF'
        EXX	
        RET	
;
;	-----------------
?.01F5:	EI	
        JP	J$1D08
;
;	-----------------
?.01F9:	EI	
        JP	J$1D10
;
;	-----------------
;
;	  Subroutine __________________________
;	     Inputs  ________________________
;	     Outputs ________________________
;
C$01FD:	CALL	C.02DD
I$01FF	EQU	$-1
;
I.0200:	JP	M,J$020D
;
        IN	A,(0A8H)
        LD	D,A
        AND	C
        OR	B
        CALL	C$F380
;
        LD	A,E
I$020C:	RET	
;
;	-----------------
J$020D:	PUSH	HL
        CALL	C.0302
;
        EX	(SP),HL
        PUSH	BC
        CALL	C$01FD
;
        JR	J$0233
;
;	-----------------
;
;	  Subroutine __________________________
;	     Inputs  ________________________
;	     Outputs ________________________
;
C.0218:	PUSH	DE
        CALL	C.02DD
;
        JP	M,J$0228
I$021E	EQU	$-1
;
        POP	DE
        IN	A,(0A8H)
        LD	D,A
        AND	C
        OR	B
        JP	J$F385
;
;	-----------------
J$0228:	EX	(SP),HL
        PUSH	HL
        CALL	C.0302
;
        POP	DE
        EX	(SP),HL
        PUSH	BC
        CALL	C.0218
;
J$0233:	POP	BC
        EX	(SP),HL
        PUSH	AF
        LD	A,B
        AND	3FH	; "?"
        OR	C
        OUT	(0A8H),A
        LD	A,L
        LD	(D.FFFF),A
J$023E	EQU	$-2
        LD	A,B
        OUT	(0A8H),A
        POP	AF
        POP	HL
        RET	
;
;	-----------------
J$0246:	EX	(SP),HL
        PUSH	AF
        PUSH	DE
        LD	A,(HL)
        PUSH	AF
        POP	IY
        INC	HL
        LD	E,(HL)
        INC	HL
        LD	D,(HL)
        INC	HL
        PUSH	DE
        POP	IX
        POP	DE
        POP	AF
        EX	(SP),HL
J$0258:	EXX	
        LD	D,0FCH
        JR	J.0265
;
;	-----------------
?.025D:	EXX	
        LD	D,0F3H
        JR	J.0265
;
;	-----------------
;
;	  Subroutine __________________________
;	     Inputs  ________________________
;	     Outputs ________________________
;
C.0262:	EXX	
        LD	D,0F0H
J.0265:	EX	AF,AF'
        DI	
        LD	A,(D.FCC1)
        AND	A
        IN	A,(0A8H)
        JP	M,J$0276
;
        PUSH	AF
        AND	D
        EXX	
        JP	J.F38C
;
;	-----------------
J$0276:	LD	B,A
        LD	A,(D.FAF8)
        AND	03H	; 3 
        JR	NZ,J$0284
;
        LD	A,D
        CP	0F3H
        JP	NZ,J$01C1
;
J$0284:	LD	A,B
        AND	3FH	; "?"
        OUT	(0A8H),A
        LD	A,(D.FFFF)
        CPL	
        LD	C,A
        AND	D
        LD	(D.FFFF),A
        LD	E,A
        LD	A,B
        OUT	(0A8H),A
        LD	A,E
        LD	(D.FCC5),A
        LD	A,B
        PUSH	BC
        LD	HL,I$02A6
        PUSH	HL
        PUSH	AF
        AND	D
        EXX	
        JP	J.F38C
;
;	-----------------
I$02A6:	DI	
        EXX	
        EX	AF,AF'
        POP	BC
        LD	A,B
        AND	3FH	; "?"
        OUT	(0A8H),A
        LD	A,C
        LD	(D.FFFF),A
        LD	A,B
        OUT	(0A8H),A
        LD	A,C
        LD	(D.FCC5),A
        EX	AF,AF'
        EXX	
        RET	
;
;	-----------------
J$02BD:	CALL	C.02DD
;
        JP	M,J$02CA
;
        IN	A,(0A8H)
        AND	C
        OR	B
        OUT	(0A8H),A
        RET	
;
;	-----------------
J$02CA:	PUSH	HL
        CALL	C.0302
;
        LD	C,A
        LD	B,00H
        LD	A,L
        AND	H
        OR	D
        LD	HL,D.FCC5
        ADD	HL,BC
        LD	(HL),A
        POP	HL
        LD	A,C
        JR	J$02BD
;
;	-----------------
;
;	  Subroutine __________________________
;	     Inputs  ________________________
;	     Outputs ________________________
;
C.02DD:	DI	
        PUSH	AF
        LD	A,H
        RLCA	
        RLCA	
        AND	03H	; 3 
        LD	E,A
        LD	A,0C0H
J$02E7:	RLCA	
        RLCA	
        DEC	E
        JP	P,J$02E7
;
        LD	E,A
        CPL	
        LD	C,A
        POP	AF
        PUSH	AF
        AND	03H	; 3 
        INC	A
        LD	B,A
        LD	A,0ABH
J$02F8:	ADD	A,55H	; "U"
        DJNZ	J$02F8
;
        LD	D,A
        AND	E
        LD	B,A
        POP	AF
I$0300:	AND	A
        RET	
;
;	-----------------
;
;	  Subroutine __________________________
;	     Inputs  ________________________
;	     Outputs ________________________
;
C.0302:	PUSH	AF
        LD	A,D
        AND	0C0H
        LD	C,A
        POP	AF
        PUSH	AF
        LD	D,A
        IN	A,(0A8H)
        LD	B,A
        AND	3FH	; "?"
        OR	C
        OUT	(0A8H),A
        LD	A,D
        RRCA	
        RRCA	
        AND	03H	; 3 
        LD	D,A
        LD	A,0ABH
J$031A:	ADD	A,55H	; "U"
        DEC	D
        JP	P,J$031A
;
        AND	E
        LD	D,A
        LD	A,E
        CPL	
        LD	H,A
        LD	A,(D.FFFF)
I$0327	EQU	$-1
        CPL	
        LD	L,A
        AND	H
        OR	D
        LD	(D.FFFF),A
        LD	A,B
        OUT	(0A8H),A
        POP	AF
        AND	03H	; 3 
        RET	
;
;	-----------------
?.0336:	LD	HL,I$29F6
        LD	DE,D.F3DF
        LD	BC,C.0008
J$033E	EQU	$-1
        LDIR	
        LD	DE,D.FFE7
        LD	BC,C.0010
        LDIR	
        XOR	A
        LD	(D.FAF5),A
        LD	(D.FAF6),A
        CALL	C$0512
        LD	(D.FAF8),A
        LD	H,A
        LD	L,0F7H
        LD	(D$FEFD),HL
        LD	HL,I$3D47			; japanese MSX: 3C11
        LD	(D$FEFF),HL
        LD	A,(D.FCC1)
        LD	(D.FFF7),A
        LD	A,2CH	; ","
        LD	(D.FAFF),A
        LD	A,26H	; "&"
        LD	(D.FB01),A
        LD	A,0D7H				; japanese MSX: D3
I$0373	EQU	$-1
        OUT	(0F7H),A
        LD	(D.FAF7),A
        XOR	A
        LD	C,0FFH
        OUT	(0D8H),A
        LD	A,02H	; 2 
        OUT	(0D9H),A
        LD	HL,I$050A
        LD	B,08H	; 8 
J$0387:	IN	A,(0D9H)
        CP	(HL)
        JR	NZ,J$0391
;
        INC	HL
        DJNZ	J$0387
;
        RES	0,C
J$0391:	IN	A,(0C0H)
        CP	0FFH
        JR	Z,J$0399
;
        RES	2,C
J$0399:	IN	A,(0F7H)
        AND	77H	; "w"
        CP	77H	; "w"
        JR	Z,J$03A3
;
        RES	3,C
J$03A3:	IN	A,(0C8H)
        CP	0FFH
        JR	Z,J$03AB
;
        RES	4,C
J$03AB:	XOR	A
        OUT	(81H),A
        PUSH	AF
        POP	AF
        OUT	(81H),A
        PUSH	AF
        POP	AF
        OUT	(81H),A
        PUSH	AF
        POP	AF
        LD	A,40H	; "@"
        OUT	(81H),A
        EX	(SP),HL
        EX	(SP),HL
        IN	A,(81H)
I$03C0:	AND	3FH	; "?"
        CP	05H	; 5 
        JR	NZ,J$03C8
;
        RES	5,C
J$03C8:	IN	A,(0BBH)
        CP	0FFH
        JR	Z,J$03D0
;
        RES	6,C
J$03D0:	LD	A,C
        OUT	(0F5H),A
        CALL	C.1CF7
;
        LD	B,00H
        CALL	C.1CD2
;
        CP	0AH	; 10 
        JR	Z,J$03E2
;
J.03DF:	CALL	C$0431
;
J$03E2:	CALL	C.1CF7
;
        LD	B,03H	; 3 
        CALL	C.1CD2
;
        AND	01H	; 1 
        PUSH	AF
        CALL	C.1CDB
;
        POP	BC
        CP	51H	; "Q"
        JP	NC,J.03DF
;
        OR	A
        JP	Z,J.03DF
;
        DEC	B
        JR	NZ,J$0402
;
        CP	21H	; "!"
        JP	NC,J.03DF
I$0400	EQU	$-2
;
J$0402:	CALL	C.1CF7
;
        LD	B,01H	; 1 
        CALL	C.1CD2
;
        LD	D,A
        CALL	C.1CD2
;
        LD	E,A
        CALL	C.17F8
;
        CALL	C$2A0E
;
        LD	B,02H	; 2 
        LD	HL,C.0000
J.041A:	DEC	HL
        LD	A,L
        OR	H
        JR	NZ,J.041A
;
        DJNZ	J.041A
;
        CALL	C.063C
;
        XOR	A
        LD	BC,I.4000
        CALL	C.0977
;
        CALL	C.0A1A
;
        JP	C.0F9F
;
;	-----------------
;
;	  Subroutine __________________________
;	     Inputs  ________________________
;	     Outputs ________________________
;
C$0431:	LD	HL,I$04FF
        LD	C,02H	; 2 
J$0436:	LD	B,0DH	; 13 
        LD	A,04H	; 4 
        SUB	C
        CALL	C.1A59
;
J$043E:	LD	B,0DH	; 13 
J$0440:	LD	A,0DH	; 13 
        SUB	B
        OUT	(0B4H),A
        LD	A,(HL)
        INC	HL
        CP	0FFH
        JR	NZ,J$044D
        DEC	HL
        XOR	A
J$044D:	OUT	(0B5H),A
        DJNZ	J$0440
        DEC	C
        JR	NZ,J$0436
        LD	B,0DH	; 13 
        LD	A,08H	; 8 
        CALL	C.1A59
        XOR	A
        CALL	C.1A59
        LD	A,0DH	; 13 
        CALL	C.1A59
        CALL	C$2BDD
        DEFB	0,0				; japanese MSX2: ld a,1 call 1CF9
        LD	B,0AH	; 10 
        LD	A,01H	; 1 
        JP	C.1A59
;
;	-----------------
J$0470:	SCF	
        JP	C.0481				; japanese MSX2: call C.0481
?.0474:	LD	HL,I$7EF2
        CALL	C.05F6
        LD	HL,I$7EE4
        JP	C.05F6
;
;	-----------------
J$0480:	XOR	A
;
;	  Subroutine __________________________
;	     Inputs  ________________________
;	     Outputs ________________________
;
C.0481:	PUSH	AF
        CALL	C.1CF7
        LD	B,03H	; 3 
        CALL	C.1CD2
        LD	C,A
        AND	01H	; 1 
        POP	DE
        PUSH	AF
        PUSH	DE
        PUSH	BC
        LD	A,C
        RLCA	
        RLCA	
        AND	08H	; 8 
        LD	C,A
        LD	A,(D.FFE8)
        AND	0F7H
        OR	C
        LD	B,A
        LD	C,09H	; 9 
        CALL	C.0647
        POP	BC
        CALL	C.1CDB
        LD	E,A
        POP	AF
        PUSH	DE
        PUSH	AF
        CALL	C.1CD2
;
        LD	(D.F3E9),A
        LD	(D.F3F2),A
        CALL	C.1CD2
;
        LD	(D.F3EA),A
        CALL	C.1CD2
;
        LD	(D.F3EB),A
        CALL	C.1CD2
;
        LD	C,A
        RRC	C
        SBC	A,A
        LD	B,A
        POP	AF
        JR	NC,J$04CC
;
        LD	A,B
J$04CC:	LD	(D.F3DE),A
        RRC	C			; japanese MSX2: CB 49
        SBC	A,A
        LD	(D.F3DB),A
        RRC	C
        PUSH	BC
        LD	BC,BDOS
        LD	HL,D.F3FC
        JR	NC,J$04E3		; japanese MSX2: 28 03
        LD	HL,I$F401
J$04E3:	LD	DE,I.F406
        LDIR	
        POP	BC
        RRC	C
        SBC	A,A
        LD	(D.F417),A
        POP	DE
        POP	AF
        LD	(D.FCB0),A
        LD	(D.FCAF),A
        PUSH	DE
        CALL	C$1081			; japanese MSX2: call 09BF
        POP	DE
        JP	J$1FFC			; japanese MSX2: jp 1FFF
;
;	-----------------
I$04FF:	LD	A,(BC)
I$0500:	DEFB	0,0
        INC	B			; japanese MSX2: 01
        RLCA				; japanese MSX2: 0D
        LD	(BC),A			; japanese MSX2: 01
        RRCA	
        INC	B
        INC	B			; japanese MSX2: 07
        INC	BC
        NOP				; japanese MSX2: FF
I$050A:	LD	B,B			; japanese MSX2: 00
        ADD	HL,BC			; japanese MSX2: 40
        RST	38H			; japanese MSX2: 20
        DJNZ	J$0517
;
        INC	B
        LD	(BC),A
        LD	BC,I$E5C5
C$0512	EQU	$-2
        IN	A,(0A8H)
        AND	03H	; 3 
J$0517	EQU	$-1
        LD	C,A
        LD	B,00H
        LD	HL,D.FCC1
        ADD	HL,BC
        OR	(HL)
        LD	C,A
        INC	HL
        INC	HL
        INC	HL
        INC	HL
        LD	A,(HL)
        AND	03H	; 3 
        RLCA	
        RLCA	
        OR	C
        POP	HL
        POP	BC
        RET	
;
;	-----------------
J.052E:	LD	IX,I$6E6B
        JR	J.0562
;
;	-----------------
J$0534:	LD	IX,I$6E86
        JR	J.0562
;
;	-----------------
J$053A:	LD	IX,I$6E6E
        JR	J.0562
;
;	-----------------
J.0540:	LD	IX,I$4055
        JR	J.0562
;
;	-----------------
J.0546:	LD	IX,I$475A
        JR	J.0562
;
;	-----------------
J$054C:	LD	IX,I$406A
        JR	J.0562
;
;	-----------------
J$0552:	LD	IX,I$406D
        JR	J.0562
;
;	-----------------
J$0558:	LD	IX,I$6275
        JR	J.0562
;
;	-----------------
J.055E:	LD	IX,I$6E74
J.0562:	JP	J.0618
;
;	-----------------
;
;	  Subroutine __________________________
;	     Inputs  ________________________
;	     Outputs ________________________
;
C.0565:	LD	IX,I$009F
        JR	C.058D
;
;	-----------------
;
;	  Subroutine __________________________
;	     Inputs  ________________________
;	     Outputs ________________________
;
C$056B:	LD	IX,I.0090
        JR	C.058D
;
;	-----------------
J$0571:	LD	IX,I$00C9
        JR	C.058D
;
;	-----------------
J$0577:	LD	IX,C.0018
        JR	C.058D
;
;	-----------------
;
;	  Subroutine __________________________
;	     Inputs  ________________________
;	     Outputs ________________________
;
C.057D:	LD	IX,I$000C
        JR	C.058D
;
;	-----------------
?.0583:	LD	IX,I$0014
        JR	C.058D
;
;	-----------------
;
;	  Subroutine __________________________
;	     Inputs  ________________________
;	     Outputs ________________________
;
C$0589:	LD	IX,I$00BD
;
;	  Subroutine __________________________
;	     Inputs  ________________________
;	     Outputs ________________________
;
C.058D:	JP	J$0258
;
;	-----------------
;
;	  Subroutine __________________________
;	     Inputs  ________________________
;	     Outputs ________________________
;
C.0590:	LD	IX,I$0141
        JR	C.058D
;
;	-----------------
J$0596:	LD	IX,I$0168
        JR	C.058D
;
;	-----------------
;
;	  Subroutine __________________________
;	     Inputs  ________________________
;	     Outputs ________________________
;
C.059C:	LD	IX,I$579C
        JR	J.0618
;
;	-----------------
;
;	  Subroutine __________________________
;	     Inputs  ________________________
;	     Outputs ________________________
;
C.05A2:	LD	IX,I$57AB
        JR	J.0618
;
;	-----------------
J$05A8:	LD	IX,I$7328
        JR	J.05F4
;
;	-----------------
;
;	  Subroutine __________________________
;	     Inputs  ________________________
;	     Outputs ________________________
;
C.05AE:	LD	IX,I$7323
        JR	J.05F4
;
;	-----------------
;
;	  Subroutine __________________________
;	     Inputs  ________________________
;	     Outputs ________________________
;
C$05B4:	LD	IX,I$5439
        JR	J.05F4
;
;	-----------------
;
;	  Subroutine __________________________
;	     Inputs  ________________________
;	     Outputs ________________________
;
C.05BA:	LD	IX,I$6A0E
        JR	J.05F4
;
;	-----------------
;
;	  Subroutine __________________________
;	     Inputs  ________________________
;	     Outputs ________________________
;
C$05C0:	LD	IX,I$6B24
        JR	J.05F4
;
;	-----------------
J.05C6:	LD	IX,I$406F
        JR	J.05F4
;
;	-----------------
?.05CC:	LD	IX,I$3412
        JR	J.05F4
;
;	-----------------
;
;	  Subroutine __________________________
;	     Inputs  ________________________
;	     Outputs ________________________
;
C$05D2:	LD	IX,J.3058
        JR	J.05F4
;
;	-----------------
;
;	  Subroutine __________________________
;	     Inputs  ________________________
;	     Outputs ________________________
;
C.05D8:	LD	IX,I$5EA4
        JR	J.05F4
;
;	-----------------
;
;	  Subroutine __________________________
;	     Inputs  ________________________
;	     Outputs ________________________
;
C.05DE:	LD	IX,I$3236
        JR	J.05F4
;
;	-----------------
;
;	  Subroutine __________________________
;	     Inputs  ________________________
;	     Outputs ________________________
;
C.05E4:	LD	IX,I$4FCF
        JR	J.05F4
;
;	-----------------
;
;	  Subroutine __________________________
;	     Inputs  ________________________
;	     Outputs ________________________
;
C$05EA:	LD	IX,I$6627
        JR	J.05F4
;
;	-----------------
J$05F0:	LD	IX,J.2F92
J.05F4:	JR	J.0618
;
;	-----------------
;
;	  Subroutine __________________________
;	     Inputs  ________________________
;	     Outputs ________________________
;
C.05F6:	LD	IX,I$6678
        JR	J.05F4
;
;	-----------------
;
;	  Subroutine __________________________
;	     Inputs  ________________________
;	     Outputs ________________________
;
C.05FC:	LD	IX,I$4C64
I.0600:	JR	J.0618
;
;	-----------------
?.0602:	LD	IX,I$542F
        JR	J.0618
;
;	-----------------
;
;	  Subroutine __________________________
;	     Inputs  ________________________
;	     Outputs ________________________
;
C.0608:	LD	IX,I$520F
I$060A	EQU	$-2
        JR	J.0618
;
;	-----------------
;
;	  Subroutine __________________________
;	     Inputs  ________________________
;	     Outputs ________________________
;
C.060E:	LD	IX,I$521C
        JR	J.0618
;
;	-----------------
;
;	  Subroutine __________________________
;	     Inputs  ________________________
;	     Outputs ________________________
;
C.0614:	LD	IX,I$67D0
J.0618:	CALL	C.0262
;
        EI	
        RET	
;
;	-----------------
;
;	  Subroutine __________________________
;	     Inputs  ________________________
;	     Outputs ________________________
;
C$061D:	LD	(D.F3DE),A
;
;	  Subroutine __________________________
;	     Inputs  ________________________
;	     Outputs ________________________
;
C.0620:	LD	A,(D.FCAF)
        CP	02H	; 2 
        RET	
;
;	-----------------
;
;	  Subroutine __________________________
;	     Inputs  ________________________
;	     Outputs ________________________
;
C.0626:	LD	A,(D.FCAF)
I$0627	EQU	$-2
        CP	04H	; 4 
        RET	
;
;	-----------------
;
;	  Subroutine __________________________
;	     Inputs  ________________________
;	     Outputs ________________________
;
C.062C:	LD	A,(D.FCAF)
        CP	05H	; 5 
        RET	
;
;	-----------------
J.0632:	CALL	C.1034
;
        LD	A,(D.F3E0)
        OR	60H	; "`"
        JR	J$0644
;
;	-----------------
;
;	  Subroutine __________________________
;	     Inputs  ________________________
;	     Outputs ________________________
;
C.063C:	CALL	C.1034
;
        LD	A,(D.F3E0)
        AND	3FH	; "?"
J$0644:	LD	B,A
        LD	C,01H	; 1 
;
;	  Subroutine __________________________
;	     Inputs  ________________________
;	     Outputs ________________________
;
C.0647:	LD	A,I
        PUSH	AF
        PUSH	HL
        LD	A,C
        AND	A
        JR	NZ,J.0680
;
        LD	A,B
        LD	HL,D.F3DF
        XOR	(HL)
        AND	01H	; 1 
        JR	Z,J.0680
;
        LD	HL,D.FFE8
        LD	A,(HL)
        AND	0CFH
        LD	(HL),A
        LD	A,B
        AND	01H	; 1 
        RRCA	
        RRCA	
        RRCA	
        RRCA	
        OR	(HL)
        PUSH	BC
        LD	B,A
        LD	C,09H	; 9 
        LD	HL,D.FAF7
        LD	A,(HL)
        AND	3FH	; "?"
        LD	(HL),A
        LD	A,B
        RLCA	
        RLCA	
        CPL	
        AND	0C0H
        OR	(HL)
        OUT	(0F7H),A
        LD	(HL),A
        CALL	C.0647
;
        POP	BC
J.0680:	LD	A,B
        DI	
        OUT	(99H),A
        LD	A,C
        OR	80H
        OUT	(99H),A
        PUSH	BC
        PUSH	DE
        LD	D,B
        LD	A,C
        LD	B,00H
        CP	08H	; 8 
        JR	NC,J$0698
;
        LD	HL,D.F3DF
        JR	J$069F
;
;	-----------------
J$0698:	CP	18H
        JR	NC,J$06A1
;
        LD	HL,I$FFDF
J$069F:	ADD	HL,BC
        LD	(HL),D
J$06A1:	POP	DE
        POP	BC
        POP	HL
        POP	AF
        RET	PO
;
        EI	
        RET	
;
;	-----------------
;
;	  Subroutine __________________________
;	     Inputs  ________________________
;	     Outputs ________________________
;
C.06A8:	LD	A,(D.FCAF)
        PUSH	AF
        PUSH	BC
        PUSH	DE
        PUSH	HL
        DI	
        LD	HL,I$06B8
        CALL	C$09C9
;
        JR	J$06F0
;
;	-----------------
I$06B8:	LD	B,D
        DEC	BC
        SBC	A,H
        DEC	BC
        JP	NC,J$220B
;
        INC	C
        EXX	
        DEC	BC
        LD	D,(HL)
        INC	C
        ADD	A,B
        INC	C
        SUB	A
        INC	C
        RST	00H
;
        INC	C
J.06CA:	PUSH	AF
        PUSH	BC
        PUSH	DE
        PUSH	HL
        DI	
        XOR	A
        OUT	(99H),A
        LD	A,91H
        OUT	(99H),A
        CALL	C.1034
;
        LD	HL,D.F3DF
        LD	B,08H	; 8 
J$06DE:	LD	A,(HL)
        INC	HL
        OUT	(9BH),A
        DJNZ	J$06DE
;
        LD	HL,D.FFE7
        LD	B,10H	; 16 
J$06E9:	LD	A,(HL)
        INC	HL
        OUT	(9BH),A
        DJNZ	J$06E9
;
        EI	
J$06F0:	POP	HL
        POP	DE
        POP	BC
        POP	AF
        RET	
;
;	-----------------
;
;	  Subroutine __________________________
;	     Inputs  ________________________
;	     Outputs ________________________
;
C.06F5:	CALL	C$0701
;
        PUSH	HL
        LD	HL,C.0000
        CALL	C.08E3
;
        POP	HL
        RET	
;
;	-----------------
;
;	  Subroutine __________________________
;	     Inputs  ________________________
;	     Outputs ________________________
;
C$0701:	LD	A,(D.F3E0)
        LD	B,A
        LD	C,01H	; 1 
        CALL	C.0647
;
        LD	HL,(D.F926)
        LD	BC,I.0800
        XOR	A
        CALL	C.0977
;
;
;	  Subroutine __________________________
;	     Inputs  ________________________
;	     Outputs ________________________
;
C.0714:	LD	A,(D.F3E9)
        LD	E,A
        LD	HL,(D.F928)
        LD	BC,I$2000
J$071E:	CALL	C.0626
;
        LD	A,0D1H
        JR	C,J$0727
;
        LD	A,0D9H
J$0727:	CALL	C.08CB
;
        INC	HL
        INC	HL
        LD	A,C
        CALL	C.08CB
;
        INC	HL
        INC	C
        LD	A,(D.F3E0)
        RRCA	
        RRCA	
        JR	NC,J$073C
;
        INC	C
        INC	C
        INC	C
J$073C:	LD	A,E
        CALL	C.08CB
;
        INC	HL
        DJNZ	J$071E
;
        CALL	C.0626
;
        RET	C
;
        LD	HL,(D.F928)
        LD	BC,I.0200
        SBC	HL,BC
        LD	A,(D.F3E9)
        JP	C.0977
;
;	-----------------
J$0755:	LD	L,A
        LD	H,00H
        ADD	HL,HL
        ADD	HL,HL
        ADD	HL,HL
        CALL	C.077F
;
        CP	08H	; 8 
        JR	Z,J$0764
;
        ADD	HL,HL
        ADD	HL,HL
J$0764:	EX	DE,HL
        LD	HL,(D.F926)
        ADD	HL,DE
        RET	
;
;	-----------------
;
;	  Subroutine __________________________
;	     Inputs  ________________________
;	     Outputs ________________________
;
C.076A:	LD	L,A
        LD	H,00H
        ADD	HL,HL
        ADD	HL,HL
        EX	DE,HL
        LD	HL,(D.F928)
        ADD	HL,DE
        RET	
;
;	-----------------
;
;	  Subroutine __________________________
;	     Inputs  ________________________
;	     Outputs ________________________
;
C.0775:	ADD	A,A
        ADD	A,A
        CALL	C.076A
;
        LD	DE,I.FE00
        ADD	HL,DE
        RET	
;
;	-----------------
;
;	  Subroutine __________________________
;	     Inputs  ________________________
;	     Outputs ________________________
;
C.077F:	LD	A,(D.F3E0)
I$0780	EQU	$-2
        RRCA	
        RRCA	
        LD	A,08H	; 8 
        RET	NC
;
        LD	A,20H	; " "
        RET	
;
;	-----------------
;
;	  Subroutine __________________________
;	     Inputs  ________________________
;	     Outputs ________________________
;
C$078A:	CALL	C$FDC7
;
        LD	HL,(D.F924)
        CALL	C.08E3
;
        LD	A,(D.F91F)
        LD	HL,(D.F920)
        LD	BC,I.0800
        PUSH	AF
J$079D:	POP	AF
        PUSH	AF
        PUSH	BC
        DI	
        CALL	C.057D
;
        EI	
        POP	BC
        OUT	(98H),A
        INC	HL
        DEC	BC
        LD	A,C
        OR	B
        JR	NZ,J$079D
;
        POP	AF
        RET	
;
;	-----------------
?.07B0:	CALL	C.08F1
;
        LD	A,C
        OR	A
        LD	A,B
        LD	B,C
        LD	C,98H
        EX	DE,HL
        JR	Z,J.07BD
;
        INC	A
J.07BD:	INIR	
        DEC	A
        JR	NZ,J.07BD
;
        EX	DE,HL
        RET	
;
;	-----------------
?.07C4:	EX	DE,HL
        CALL	C.08E3
;
        EX	DE,HL
        LD	A,C
        OR	A
        LD	A,B
        LD	B,C
        LD	C,98H
        JR	Z,J.07D2
I$07D0	EQU	$-1
;
        INC	A
J.07D2:	OTIR	
        DEC	A
        JR	NZ,J.07D2
;
        EX	DE,HL
        RET	
;
;	-----------------
;
;	  Subroutine __________________________
;	     Inputs  ________________________
;	     Outputs ________________________
;
C.07D9:	LD	H,00H
        LD	L,A
        ADD	HL,HL
        ADD	HL,HL
        ADD	HL,HL
        EX	DE,HL
        LD	HL,(D.F920)
        ADD	HL,DE
        LD	DE,D.FC40
        LD	B,08H	; 8 
        LD	A,(D.F91F)
J$07EC:	PUSH	AF
        PUSH	HL
        PUSH	DE
        PUSH	BC
        CALL	C.057D
;
        EI	
        POP	BC
        POP	DE
        POP	HL
        LD	(DE),A
        INC	DE
        INC	HL
        POP	AF
        DJNZ	J$07EC
;
        RET	
;
;	-----------------
;
;	  Subroutine __________________________
;	     Inputs  ________________________
;	     Outputs ________________________
;
C.07FE:	CALL	C.0626
I.0800	EQU	$-1
;
        JP	Z,C.0895
;
        JR	NC,C.0811
;
        CALL	C.0620
;
        JP	Z,C.0895
;
        JP	NC,C.08AD
;
        JR	C.0864
;
;	-----------------
;
;	  Subroutine __________________________
;	     Inputs  ________________________
;	     Outputs ________________________
;
C.0811:	PUSH	AF
        PUSH	BC
        PUSH	DE
        PUSH	HL
        CALL	C.2980
;
        LD	A,(D.F3EA)
        CALL	C$084B
;
I$081E:	CALL	C.29EB
;
        XOR	A
        LD	H,A
        LD	L,A
        CALL	C.29A5
;
        XOR	A
        CALL	C.29DB
;
        LD	A,(D.FCAF)
        AND	02H	; 2 
        LD	DE,I.0100
        JR	Z,J$0838
;
        LD	DE,I.0200
J$0838:	LD	HL,I.00D4
        CALL	C.29C4
;
        LD	A,0C0H
        CALL	C.29E3
;
        CALL	C.2980
;
        POP	HL
        POP	DE
        POP	BC
        POP	AF
        RET	
;
;	-----------------
;
;	  Subroutine __________________________
;	     Inputs  ________________________
;	     Outputs ________________________
;
C$084B:	LD	B,A
        LD	A,(D.FCAF)
        CP	08H	; 8 
        LD	A,B
        RET	Z
;
        RLCA	
        RLCA	
        RLCA	
        RLCA	
        OR	B
        LD	B,A
        LD	A,(D.FCAF)
        CP	06H	; 6 
        LD	A,B
        RET	NZ
;
        RRCA	
        RRCA	
        OR	B
        RET	
;
;	-----------------
;
;	  Subroutine __________________________
;	     Inputs  ________________________
;	     Outputs ________________________
;
C.0864:	JP	J$1068			; japanese MSX2: LD A,(FCAF)
;
;	-----------------
?.0867:	AND	A
J$0868:	LD	HL,(D.F922)
        JR	NZ,J$087E
;
        LD	A,(D.F3B0)
        CP	29H	; ")"
        JR	NC,J$0879
;
        LD	BC,I$03C0
        JR	J.0881
;
;	-----------------
J$0879:	LD	BC,I$0780
        JR	J.0881
;
;	-----------------
J$087E:	LD	BC,I$0300
J.0881:	LD	A,20H	; " "
        CALL	C.0977
;
        CALL	C$08C1
;
        LD	HL,I$FBB2
        LD	B,18H
J$088E:	LD	(HL),B
        INC	HL
        DJNZ	J$088E
;
        JP	J$0571
;
;	-----------------
;
;	  Subroutine __________________________
;	     Inputs  ________________________
;	     Outputs ________________________
;
C.0895:	CALL	C.099C
;
        LD	BC,I$1800
        PUSH	BC
        LD	HL,(D.F3C9)
        LD	A,(D.F3EA)
        CALL	C.0977
;
        LD	HL,(D.F3CB)
        POP	BC
        XOR	A
J$08AA:	JP	C.0977
;
;	-----------------
;
;	  Subroutine __________________________
;	     Inputs  ________________________
;	     Outputs ________________________
;
C.08AD:	CALL	C.099C
;
        LD	HL,D.F3EA
        LD	A,(HL)
        ADD	A,A
        ADD	A,A
        ADD	A,A
        ADD	A,A
        OR	(HL)
        LD	HL,(D.F3D5)
        LD	BC,I.0600
        JR	J$08AA
;
;	-----------------
;
;	  Subroutine __________________________
;	     Inputs  ________________________
;	     Outputs ________________________
;
C$08C1:	LD	HL,I$0101
        LD	(D.F3DC),HL
        RET	
;
;	-----------------
?.08C8:	CALL	C.08DC
;
;
;	  Subroutine __________________________
;	     Inputs  ________________________
;	     Outputs ________________________
;
C.08CB:	PUSH	AF
        CALL	C.08E3
;
        POP	AF
        OUT	(98H),A
        RET	
;
;	-----------------
;
;	  Subroutine __________________________
;	     Inputs  ________________________
;	     Outputs ________________________
;
C$08D3:	CALL	C.08DC
;
;
;	  Subroutine __________________________
;	     Inputs  ________________________
;	     Outputs ________________________
;
C.08D6:	CALL	C.08F1
;
        IN	A,(98H)
        RET	
;
;	-----------------
;
;	  Subroutine __________________________
;	     Inputs  ________________________
;	     Outputs ________________________
;
C.08DC:	PUSH	AF
        LD	A,H
        AND	3FH	; "?"
        LD	H,A
        POP	AF
        RET	
;
;	-----------------
;
;	  Subroutine __________________________
;	     Inputs  ________________________
;	     Outputs ________________________
;
C.08E3:	PUSH	BC
        PUSH	DE
        PUSH	HL
        EX	DE,HL
        CALL	C.0914
;
        LD	A,H
        AND	3FH	; "?"
        OR	40H	; "@"
        JR	J$08FB
;
;	-----------------
;
;	  Subroutine __________________________
;	     Inputs  ________________________
;	     Outputs ________________________
;
C.08F1:	PUSH	BC
        PUSH	DE
        PUSH	HL
        EX	DE,HL
        CALL	C.0914
;
        LD	A,H
        AND	3FH	; "?"
J$08FB:	PUSH	AF
        LD	A,H
        AND	0C0H
        OR	D
        RLCA	
        RLCA	
        DI	
        OUT	(99H),A
        LD	A,8EH
        OUT	(99H),A
        LD	A,L
        OUT	(99H),A
        POP	AF
        OUT	(99H),A
        EI	
        POP	HL
        POP	DE
        POP	BC
        RET	
;
;	-----------------
;
;	  Subroutine __________________________
;	     Inputs  ________________________
;	     Outputs ________________________
;
C.0914:	LD	A,(D.FCAF)
        LD	C,A
        LD	A,(D.FAF6)
        AND	A
        LD	HL,I$0925
        JP	NZ,J$09CA
;
        EX	DE,HL
        LD	D,A
        RET	
;
;	-----------------
I$0925:	SCF	
        ADD	HL,BC
        LD	B,L
        ADD	HL,BC
        LD	B,L
        ADD	HL,BC
        LD	B,L
        ADD	HL,BC
        LD	B,L
        ADD	HL,BC
        LD	B,H
        ADD	HL,BC
        LD	B,H
        ADD	HL,BC
        LD	B,E
        ADD	HL,BC
        LD	B,E
        ADD	HL,BC
        LD	A,(D.F3B0)
I$093A:	CP	29H	; ")"
        LD	A,(D.FAF6)
        JR	C,J$0947
;
        JR	J$0946
;
;	-----------------
?.0943:	ADD	A,A
        ADD	A,A
        ADD	A,A
J$0946:	ADD	A,A
J$0947:	ADD	A,A
        ADD	A,A
        ADD	A,A
        ADD	A,A
        LD	H,A
        LD	A,00H
        LD	L,A
        ADC	A,A
        ADD	HL,DE
        LD	D,A
        RET	
;
;	-----------------
;
;	  Subroutine __________________________
;	     Inputs  ________________________
;	     Outputs ________________________
;
C.0953:	CALL	C.062C
;
        JP	NC,J$0997
;
        CALL	C.09A5
;
        DEC	A
        JP	M,J$098A
;
        PUSH	AF
        CALL	C.099C
;
        POP	AF
        RET	NZ
;
        LD	HL,D.F3EA
        LD	A,(D.F3E9)
        ADD	A,A
        ADD	A,A
        ADD	A,A
        ADD	A,A
        OR	(HL)
        LD	HL,(D.F3BF)
        LD	BC,C.0020
;
;	  Subroutine __________________________
;	     Inputs  ________________________
;	     Outputs ________________________
;
C.0977:	PUSH	AF
        CALL	C.08E3
;
        LD	A,C
        OR	A
        JR	Z,J$0980
;
        INC	B
J$0980:	POP	AF
J.0981:	OUT	(98H),A
        DEC	C
        JP	NZ,J.0981
;
        DJNZ	J.0981
;
        RET	
;
;	-----------------
J$098A:	LD	HL,D.F3EA
        LD	A,(D.F3E9)
        ADD	A,A
        ADD	A,A
        ADD	A,A
        ADD	A,A
        OR	(HL)
        JR	J$099F
;
;	-----------------
J$0997:	CP	08H	; 8 
        CALL	NZ,C.09A5
;
;
;	  Subroutine __________________________
;	     Inputs  ________________________
;	     Outputs ________________________
;
C.099C:	LD	A,(D.F3EB)
J$099F:	LD	B,A
        LD	C,07H	; 7 
        JP	C.0647
;
;	-----------------
;
;	  Subroutine __________________________
;	     Inputs  ________________________
;	     Outputs ________________________
;
C.09A5:	PUSH	AF
        LD	A,(D.F3EA)
        AND	0FH	; 15 
        LD	(D.F3EA),A
        LD	A,(D.F3E9)
        AND	0FH	; 15 
        LD	(D.F3E9),A
        POP	AF
        RET	
;
;	-----------------
?.09B8:	RET	NZ
;
        PUSH	HL
        CALL	C.07FE
;
        POP	HL
        RET	
;
;	-----------------
;
;	  Subroutine __________________________
;	     Inputs  ________________________
;	     Outputs ________________________
;
C.09BF:	LD	HL,C.0F9F
        PUSH	HL
J$09C3:	CP	09H	; 9 
        RET	NC
;
        LD	HL,I$09D3
;
;	  Subroutine __________________________
;	     Inputs  ________________________
;	     Outputs ________________________
;
C$09C9:	LD	C,A
J$09CA:	LD	B,00H
        ADD	HL,BC
        ADD	HL,BC
        LD	C,(HL)
        INC	HL
        LD	H,(HL)
        LD	L,C
        JP	(HL)
;
;	-----------------
I$09D3:	PUSH	HL
        ADD	HL,BC
        LD	A,(DE)
        LD	A,(BC)
        LD	C,B
        LD	A,(BC)
        SBC	A,B
        LD	A,(BC)
        LD	(HL),C
        LD	A,(BC)
        SUB	0AH	; 10 
        EX	(SP),HL
        LD	A,(BC)
        RET	P
;
        LD	A,(BC)
        DEFB	0FDH		; << Illegal Op Code Byte >>
;	-----------------
;
        LD	A,(BC)
J$09E5:	XOR	A
        CALL	C.2AD6
;
        CALL	C.0B22
;
        LD	A,(D.F3AE)
        LD	(D.F3B0),A
        LD	HL,I.0800
        LD	(D.F3B5),HL
        LD	HL,(D.F3B3)
        LD	(D.F922),HL
        LD	HL,(D.F3B7)
I$0A00	EQU	$-1
        CP	29H	; ")"
        JR	C,J$0A08
;
        LD	HL,I.1000
J$0A08:	LD	(D.F924),HL
        CALL	C.0B42
;
J$0A0E:	CALL	C.0953
;
        CALL	C.0864
;
        CALL	C$078A
;
        JP	J.0632
;
;	-----------------
;
;	  Subroutine __________________________
;	     Inputs  ________________________
;	     Outputs ________________________
;
C.0A1A:	LD	A,01H	; 1 
        CALL	C.2AD6
;
        CALL	C.0B22
;
        LD	A,(D.F3AF)
        LD	(D.F3B0),A
        LD	HL,(D.F3BD)
        LD	(D.F922),HL
        LD	HL,(D.F3C1)
        LD	(D.F924),HL
        LD	HL,(D.F3C5)
        LD	(D.F926),HL
        LD	HL,(D.F3C3)
        LD	(D.F928),HL
        CALL	C.0B9C
;
        CALL	C.0714
;
        JR	J$0A0E
;
;	-----------------
J$0A48:	LD	A,02H	; 2 
        CALL	C.0B22
;
        LD	HL,(D.F3CD)
        CALL	C.0A82
;
        PUSH	HL
        CALL	C.0BD2
;
J$0A57:	POP	HL
        CALL	C.08E3
;
        XOR	A
        LD	B,03H	; 3 
J.0A5E:	OUT	(98H),A
        INC	A
        JR	NZ,J.0A5E
;
        DJNZ	J.0A5E
;
        CALL	C.0895
;
J$0A68:	CALL	C.0953
;
        CALL	C.0714
;
        JP	J.0632
;
;	-----------------
?.0A71:	LD	A,04H	; 4 
        CALL	C.0B22
;
        LD	HL,I$1E00
        CALL	C.0A82
;
        PUSH	HL
        CALL	C$0BD9
;
        JR	J$0A57
;
;	-----------------
;
;	  Subroutine __________________________
;	     Inputs  ________________________
;	     Outputs ________________________
;
C.0A82:	LD	(D.F928),HL
        LD	HL,(D.F3CF)
        LD	(D.F926),HL
        LD	HL,(D.F3CB)
        LD	(D.F924),HL
        LD	HL,(D.F3C7)
        LD	(D.F922),HL
        RET	
;
;	-----------------
J$0A98:	LD	A,03H	; 3 
        CALL	C.0B22
;
        LD	HL,(D.F3D9)
        LD	(D.F926),HL
        LD	HL,(D.F3D7)
        LD	(D.F928),HL
        LD	HL,(D.F3D5)
        LD	(D.F924),HL
        LD	HL,(D.F3D1)
        LD	(D.F922),HL
        PUSH	HL
        CALL	C.0C22
;
        POP	HL
        CALL	C.08E3
;
        LD	DE,CPMADR
J$0AC0:	LD	C,04H	; 4 
J$0AC2:	LD	A,D
        LD	B,20H	; " "
J$0AC5:	OUT	(98H),A
        INC	A
        DJNZ	J$0AC5
;
        DEC	C
        JR	NZ,J$0AC2
;
        LD	D,A
        DEC	E
        JR	NZ,J$0AC0
;
        CALL	C.08AD
;
        JR	J$0A68
;
;	-----------------
?.0AD6:	LD	A,05H	; 5 
        LD	DE,I.7876
        CALL	C.0B14
;
        CALL	C$0C56
;
        JR	J.0B08
;
;	-----------------
?.0AE3:	LD	A,06H	; 6 
        LD	DE,I.7876
        CALL	C.0B14
;
        CALL	C$0C80
;
        JR	J.0B08
;
;	-----------------
?.0AF0:	LD	A,07H	; 7 
        LD	DE,I.F0FA
        CALL	C.0B14
;
        CALL	C$0C97
;
        JR	J.0B08
;
;	-----------------
?.0AFD:	LD	A,08H	; 8 
        LD	DE,I.F0FA
        CALL	C.0B14
;
        CALL	C$0CC7
;
J.0B08:	CALL	C.0953
;
        CALL	C.0811
;
        CALL	C.0714
;
        JP	J.0632
;
;	-----------------
;
;	  Subroutine __________________________
;	     Inputs  ________________________
;	     Outputs ________________________
;
C.0B14:	LD	L,00H
        LD	H,D
        LD	(D.F926),HL
        LD	H,E
        LD	(D.F928),HL
        LD	H,L
        LD	(D.F922),HL
;
;	  Subroutine __________________________
;	     Inputs  ________________________
;	     Outputs ________________________
;
C.0B22:	LD	(D.FCAF),A
        XOR	A
        LD	(D.FAF5),A
        LD	(D.FAF6),A
        LD	HL,I.0100
        LD	(D.F40B),HL
        LD	(D.F40D),HL
        CALL	C.2980
;
        CALL	C.063C
;
        LD	B,00H
        LD	C,17H
        JP	C.0647
;
;	-----------------
;
;	  Subroutine __________________________
;	     Inputs  ________________________
;	     Outputs ________________________
;
C.0B42:	CALL	C.0D2D
;
        LD	A,(D.F3B0)
        CP	29H	; ")"
        LD	B,00H
        JR	C,J$0B50
;
        LD	B,04H	; 4 
J$0B50:	LD	C,10H	; 16 
        CALL	C.0D3F
;
        LD	A,(D.F3B0)
        CP	29H	; ")"
        LD	A,(D.FAF5)
        JR	NC,J$0B72
;
        ADD	A,A
        LD	HL,(D.F3B7)
        LD	B,00H
        CALL	C.0CE6
;
        ADD	A,A
        LD	HL,(D.F3B3)
        CALL	C.0CDA
;
        JP	J.06CA
;
;	-----------------
J$0B72:	LD	A,(D.FAF5)
        PUSH	AF
        ADD	A,A
        ADD	A,A
        LD	B,00H
        LD	HL,(D.F924)
        CALL	C.0CE6
;
        ADD	A,A
        LD	B,03H	; 3 
        LD	HL,(D.F3B3)
        CALL	C.0CDA
;
        POP	AF
        LD	HL,(D.F3B5)
        LD	E,00H
        SRL	A
        RR	E
        LD	D,A
        LD	B,07H	; 7 
        CALL	C.0CF4
;
        JP	J.06CA
;
;	-----------------
;
;	  Subroutine __________________________
;	     Inputs  ________________________
;	     Outputs ________________________
;
C.0B9C:	CALL	C.0D2D
;
        LD	BC,C.0000
        CALL	C.0D3F
;
        LD	A,(D.FAF5)
        LD	C,A
        LD	B,00H
        LD	HL,(D.F3C1)
        ADD	A,A
        ADD	A,A
        ADD	A,A
        CALL	C.0CE6
;
        LD	HL,(D.F3C5)
        CALL	C.0D20
;
        LD	HL,(D.F3BD)
        ADD	A,A
        CALL	C.0CDA
;
        LD	E,B
        LD	D,C
        LD	HL,(D.F3BF)
        CALL	C.0CF4
;
        SRL	D
        RR	E
        LD	HL,(D.F3C3)
        JR	J.0C1C
;
;	-----------------
;
;	  Subroutine __________________________
;	     Inputs  ________________________
;	     Outputs ________________________
;
C.0BD2:	XOR	A
        PUSH	AF
        LD	BC,I.0200
        JR	J$0BE0
;
;	-----------------
;
;	  Subroutine __________________________
;	     Inputs  ________________________
;	     Outputs ________________________
;
C$0BD9:	LD	A,03H	; 3 
        OR	A
        PUSH	AF
        LD	BC,I$0400
J$0BE0:	CALL	C.0D3F
;
        CALL	C.0D2D
;
        LD	A,(D.FAF5)
        LD	C,A
        LD	B,03H	; 3 
        LD	HL,(D.F3CB)
        ADD	A,A
        ADD	A,A
        ADD	A,A
        CALL	C.0CE6
;
        LD	HL,(D.F3CF)
        CALL	C.0D20
;
        LD	HL,(D.F3C7)
        ADD	A,A
        LD	B,00H
        CALL	C.0CDA
;
        LD	E,B
        LD	D,C
        LD	B,7FH
        LD	HL,(D.F3C9)
        CALL	C.0CF4
;
        SRL	D
        RR	E
        POP	AF
        LD	B,A
        LD	HL,(D.F3CD)
        JR	Z,J.0C1C
;
        LD	HL,(D.F928)
J.0C1C:	CALL	C$0D0B
;
        JP	J.06CA
;
;	-----------------
;
;	  Subroutine __________________________
;	     Inputs  ________________________
;	     Outputs ________________________
;
C.0C22:	CALL	C.0D2D
;
        LD	BC,C.0008
        CALL	C.0D3F
;
        LD	A,(D.FAF5)
        LD	C,A
        LD	B,00H
        LD	HL,(D.F3D5)
        ADD	A,A
        ADD	A,A
        ADD	A,A
        CALL	C.0CE6
;
        LD	HL,(D.F3D9)
        CALL	C.0D20
;
        LD	HL,(D.F3D1)
        ADD	A,A
        LD	B,00H
        CALL	C.0CDA
;
        LD	E,B
        LD	D,C
        SRL	D
        RR	E
        LD	B,00H
        LD	HL,(D.F3D7)
        JR	J.0C1C
;
;	-----------------
;
;	  Subroutine __________________________
;	     Inputs  ________________________
;	     Outputs ________________________
;
C$0C56:	CALL	C.0D36
;
        LD	BC,I.0600
        CALL	C.0D3F
;
J$0C5F:	LD	A,(D.FAF5)
        LD	C,A
        LD	B,00H
        ADD	A,A
        ADD	A,A
        ADD	A,A
        ADD	A,A
        CALL	C.0D1D
;
        LD	HL,(D.F922)
        ADD	A,A
        LD	B,1FH
        CALL	C.0CDA
;
        LD	D,C
J$0C76:	LD	E,00H
        LD	B,03H	; 3 
        CALL	C$0D08
;
        JP	J.06CA
;
;	-----------------
;
;	  Subroutine __________________________
;	     Inputs  ________________________
;	     Outputs ________________________
;
C$0C80:	CALL	C.0D36
;
        LD	BC,I.0800
        CALL	C.0D3F
;
        LD	HL,I.0200
        LD	(D.F40B),HL
        LD	HL,DBUF
        LD	(D.F40D),HL
        JR	J$0C5F
;
;	-----------------
;
;	  Subroutine __________________________
;	     Inputs  ________________________
;	     Outputs ________________________
;
C$0C97:	CALL	C.0D36
;
        LD	BC,I$0A00
        CALL	C.0D3F
;
        LD	HL,I.0200
        LD	(D.F40B),HL
        LD	HL,DBUF
        LD	(D.F40D),HL
J$0CAC:	LD	A,(D.FAF5)
        LD	C,A
        LD	B,00H
        RRCA	
        RRCA	
        RRCA	
        AND	0E0H
        CALL	C.0D1D
;
        LD	HL,(D.F922)
        LD	B,1FH
        CALL	C.0CDA
;
        LD	A,C
        ADD	A,A
        LD	D,A
        JR	J$0C76
;
;	-----------------
;
;	  Subroutine __________________________
;	     Inputs  ________________________
;	     Outputs ________________________
;
C$0CC7:	CALL	C.0D36
;
        LD	BC,I.0E00
        CALL	C.0D3F
;
        LD	A,(D.F3E1)
        SRL	A
        LD	(D.F3E1),A
        JR	J$0CAC
;
;	-----------------
;
;	  Subroutine __________________________
;	     Inputs  ________________________
;	     Outputs ________________________
;
C.0CDA:	LD	L,A
        SRL	H
        SRL	H
        ADD	A,H
        OR	B
        LD	(D.F3E1),A
        LD	A,L
        RET	
;
;	-----------------
;
;	  Subroutine __________________________
;	     Inputs  ________________________
;	     Outputs ________________________
;
C.0CE6:	LD	L,A
        SRL	H
        SRL	H
        SRL	H
        ADD	A,H
        OR	B
        LD	(D$F3E3),A
        LD	A,L
        RET	
;
;	-----------------
;
;	  Subroutine __________________________
;	     Inputs  ________________________
;	     Outputs ________________________
;
C.0CF4:	PUSH	AF
        XOR	A
        ADD	HL,HL
        ADC	A,A
        ADD	HL,HL
        ADC	A,A
        LD	L,H
        LD	H,A
        ADD	HL,DE
        LD	A,L
        OR	B
        LD	(D$F3E2),A
I$0D00	EQU	$-2
        LD	A,H
        LD	(D$FFE9),A
        POP	AF
        RET	
;
;	-----------------
;
;	  Subroutine __________________________
;	     Inputs  ________________________
;	     Outputs ________________________
;
C$0D08:	LD	HL,(D.F928)
;
;	  Subroutine __________________________
;	     Inputs  ________________________
;	     Outputs ________________________
;
C$0D0B:	PUSH	AF
        XOR	A
        ADD	HL,HL
        ADC	A,A
        LD	L,H
        LD	H,A
        ADD	HL,DE
        LD	A,L
        OR	B
        LD	(D$F3E4),A
        LD	A,H
        LD	(D$FFEA),A
        POP	AF
        RET	
;
;	-----------------
;
;	  Subroutine __________________________
;	     Inputs  ________________________
;	     Outputs ________________________
;
C.0D1D:	LD	HL,(D.F926)
;
;	  Subroutine __________________________
;	     Inputs  ________________________
;	     Outputs ________________________
;
C.0D20:	LD	L,A
        SRL	H
        SRL	H
        SRL	H
        ADD	A,H
        LD	(D$F3E5),A
        LD	A,L
        RET	
;
;	-----------------
;
;	  Subroutine __________________________
;	     Inputs  ________________________
;	     Outputs ________________________
;
C.0D2D:	LD	A,(D.FFE8)
        AND	7FH
        LD	(D.FFE8),A
        RET	
;
;	-----------------
;
;	  Subroutine __________________________
;	     Inputs  ________________________
;	     Outputs ________________________
;
C.0D36:	LD	A,(D.FFE8)
        OR	80H
        LD	(D.FFE8),A
        RET	
;
;	-----------------
;
;	  Subroutine __________________________
;	     Inputs  ________________________
;	     Outputs ________________________
;
C.0D3F:	LD	A,(D.F3DF)
        AND	0F1H
        OR	B
        LD	(D.F3DF),A
        LD	A,(D.F3E0)
        AND	0E7H
        OR	C
        LD	(D.F3E0),A
        RET	
;
;	-----------------
;
;	  Subroutine __________________________
;	     Inputs  ________________________
;	     Outputs ________________________
;
C$0D52:	LD	A,0FFH
        CALL	C$061D
        RET	NC
        PUSH	HL
        LD	A,(D.F3DC)
        LD	HL,D.F3B1
        CP	(HL)
        LD	A,0AH	; 10 
        JR	NZ,J$0D65
        RST	18H
J$0D65:	LD	A,(D.FBEB)
        RRCA	
        LD	HL,I$F87F
        LD	A,01H	; 1 
        JR	C,J$0D74
;
        LD	HL,I$F8CF
        XOR	A
J$0D74:	LD	(D$FBCD),A
        CALL	C.0DE2
;
        LD	C,05H	; 5 
        LD	A,(D.F3B0)
        CP	29H	; ")"
        JR	NC,J$0DA2
;
        CALL	C.0DF0
;
        JR	C,J$0D9A
;
J$0D88:	PUSH	BC
        LD	C,00H
J$0D8B:	CALL	C.2C34
;
        DJNZ	J$0D8B
;
        LD	A,10H	; 16 
        SUB	C
        LD	C,A
        ADD	HL,BC
        INC	DE
        POP	BC
        DEC	C
        JR	NZ,J$0D88
;
J$0D9A:	LD	HL,(D.F3B1)
        CALL	C.0ED7
;
        POP	HL
        RET	
;
;	-----------------
J$0DA2:	PUSH	AF
        CALL	C.0DF0
;
        POP	AF
        SUB	28H	; "("
J$0DA9:	PUSH	BC
        LD	C,00H
J$0DAC:	PUSH	AF
        CALL	C.2C34
;
        POP	AF
        DEC	A
        CALL	Z,C.0DD2
;
        DJNZ	J$0DAC
;
        DEC	A
        JR	NZ,J$0DBE
;
        CALL	C.0DD2
;
        DEC	DE
J$0DBE:	EX	AF,AF'
        LD	A,10H	; 16 
        SUB	C
        LD	C,A
        ADD	HL,BC
        EX	AF,AF'
        INC	DE
        POP	BC
        DEC	C
        JR	NZ,J$0DA9
;
        LD	HL,(D.F3B1)
        CALL	C.0EF2
;
        POP	HL
        RET	
;
;	-----------------
;
;	  Subroutine __________________________
;	     Inputs  ________________________
;	     Outputs ________________________
;
C.0DD2:	PUSH	BC
        PUSH	HL
        LD	HL,(D.F3B1)
        CALL	C.0ED8
;
        CALL	C.0DE2
;
        POP	HL
        POP	BC
        LD	A,0FFH
        RET	
;
;	-----------------
;
;	  Subroutine __________________________
;	     Inputs  ________________________
;	     Outputs ________________________
;
C.0DE2:	LD	DE,D.FC18
        PUSH	DE
        LD	B,28H	; "("
        LD	A,20H	; " "
J$0DEA:	LD	(DE),A
        INC	DE
        DJNZ	J$0DEA
;
        POP	DE
        RET	
;
;	-----------------
;
;	  Subroutine __________________________
;	     Inputs  ________________________
;	     Outputs ________________________
;
C.0DF0:	SUB	04H	; 4 
        RET	C
;
        LD	B,0FFH
J$0DF5:	INC	B
        SUB	05H	; 5 
        JR	NC,J$0DF5
;
        LD	A,B
        SUB	01H	; 1 
        RET	
;
;	-----------------
J.0DFE:	LD	A,(HL)
        INC	HL
I.0E00:	INC	C
        CALL	C.12A5
;
        JR	NC,J.0DFE
;
        JR	NZ,J$0E0C
;
        CP	20H	; " "
        JR	C,J$0E0D
;
J$0E0C:	LD	(DE),A
J$0E0D:	INC	DE
        RET	
;
;	-----------------
J$0E0F:	CALL	C.0F00
;
        SUB	L
        RET	C
;
        JP	Z,J.0EA9
;
        PUSH	HL
        PUSH	AF
        LD	C,A
        LD	B,00H
        CALL	C.0F0A
;
        LD	L,E
        LD	H,D
        INC	HL
        LDIR	
        LD	HL,I$FBCA
        DEC	(HL)
        POP	AF
        POP	HL
        PUSH	AF
        LD	A,(D.F3B0)
        CP	29H	; ")"
        JR	NC,J$0E43
;
        POP	AF
J$0E33:	PUSH	AF
;
;	  Subroutine __________________________
;	     Inputs  ________________________
;	     Outputs ________________________
;
C$0E34:	INC	L
        CALL	C.0EAE
;
        DEC	L
        CALL	C.0ED7
;
        INC	L
        POP	AF
        DEC	A
        JR	NZ,J$0E33
;
        JR	J$0E5A
;
;	-----------------
J$0E43:	POP	AF
J$0E44:	PUSH	AF
        INC	L
        CALL	C.0EAF
;
        DEC	L
        CALL	C.0ED8
;
        INC	L
        CALL	C.0EC8
;
        DEC	L
        CALL	C.0EF2
;
        INC	L
        POP	AF
        DEC	A
        JR	NZ,J$0E44
;
J$0E5A:	JP	J.0EA9
;
;	-----------------
J$0E5D:	CALL	C.0F00
;
        LD	H,A
        SUB	L
        RET	C
;
        JP	Z,J.0EA9
;
        LD	L,H
        PUSH	HL
        PUSH	AF
        LD	C,A
        LD	B,00H
        CALL	C.0F0A
;
        LD	L,E
        LD	H,D
        PUSH	HL
        DEC	HL
        LDDR	
        POP	HL
        LD	(HL),H
        POP	AF
        POP	HL
        PUSH	AF
        LD	A,(D.F3B0)
        CP	29H	; ")"
        JR	NC,J$0E92
;
        POP	AF
J$0E82:	PUSH	AF
        DEC	L
        CALL	C.0EAE
;
        INC	L
        CALL	C.0ED7
;
        DEC	L
        POP	AF
        DEC	A
        JR	NZ,J$0E82
;
        JR	J.0EA9
;
;	-----------------
J$0E92:	POP	AF
J$0E93:	PUSH	AF
        DEC	L
        CALL	C.0EAF
;
        INC	L
        CALL	C.0ED8
I.0E9B	EQU	$-1
;
        DEC	L
        CALL	C.0EC8
;
        INC	L
        CALL	C.0EF2
;
        DEC	L
        POP	AF
        DEC	A
        JR	NZ,J$0E93
;
J.0EA9:	LD	H,01H	; 1 
        JP	J$0596
;
;	-----------------
;
;	  Subroutine __________________________
;	     Inputs  ________________________
;	     Outputs ________________________
;
C.0EAE:	OR	0AFH
C.0EAF	EQU	$-1
        PUSH	HL
        PUSH	AF
        LD	H,01H	; 1 
        CALL	C.0F35
;
        POP	AF
        LD	A,(D.F3B0)
        JR	NZ,J$0EBF
;
        SUB	28H	; "("
J$0EBF:	LD	B,A
J$0EC0:	LD	DE,D.FC18
        CALL	C.0F22
;
        POP	HL
        RET	
;
;	-----------------
;
;	  Subroutine __________________________
;	     Inputs  ________________________
;	     Outputs ________________________
;
C.0EC8:	PUSH	HL
        LD	A,(D.F3B0)
        SUB	28H	; "("
        INC	A
        LD	H,A
        CALL	C.0F35
;
        LD	B,28H	; "("
        JR	J$0EC0
;
;	-----------------
;
;	  Subroutine __________________________
;	     Inputs  ________________________
;	     Outputs ________________________
;
C.0ED7:	OR	0AFH
C.0ED8	EQU	$-1
        PUSH	HL
        PUSH	AF
        LD	H,01H	; 1 
        CALL	C.0F35
;
        POP	AF
        LD	A,(D.F3B0)
        JR	NZ,J$0EE8
;
        SUB	28H	; "("
J$0EE8:	LD	B,A
J$0EE9:	EX	DE,HL
        LD	HL,D.FC18
        CALL	C.0F2B
;
        POP	HL
        RET	
;
;	-----------------
;
;	  Subroutine __________________________
;	     Inputs  ________________________
;	     Outputs ________________________
;
C.0EF2:	PUSH	HL
        LD	A,(D.F3B0)
        SUB	27H	; "'"
        LD	H,A
        CALL	C.0F35
;
        LD	B,28H	; "("
        JR	J$0EE9
;
;	-----------------
;
;	  Subroutine __________________________
;	     Inputs  ________________________
;	     Outputs ________________________
;
C.0F00:	LD	A,(D.F3DE)
        PUSH	HL
        LD	HL,D.F3B1
        ADD	A,(HL)
        POP	HL
        RET	
;
;	-----------------
;
;	  Subroutine __________________________
;	     Inputs  ________________________
;	     Outputs ________________________
;
C.0F0A:	PUSH	HL
        LD	DE,I$FBB1
        LD	H,00H
        ADD	HL,DE
        LD	A,(HL)
        EX	DE,HL
        POP	HL
        AND	A
        RET	
;
;	-----------------
J$0F16:	PUSH	HL
        CALL	C.0F35
;
        CALL	C.08E3
;
        LD	A,C
        OUT	(98H),A
        POP	HL
        RET	
;
;	-----------------
;
;	  Subroutine __________________________
;	     Inputs  ________________________
;	     Outputs ________________________
;
C.0F22:	CALL	C.08F1
;
        EX	DE,HL
        LD	C,98H
        INIR	
        RET	
;
;	-----------------
;
;	  Subroutine __________________________
;	     Inputs  ________________________
;	     Outputs ________________________
;
C.0F2B:	EX	DE,HL
        CALL	C.08E3
;
        EX	DE,HL
        LD	C,98H
        OTIR	
        RET	
;
;	-----------------
;
;	  Subroutine __________________________
;	     Inputs  ________________________
;	     Outputs ________________________
;
C.0F35:	PUSH	BC
        DEC	H
        DEC	L
        LD	E,H
        LD	H,00H
        LD	D,H
        ADD	HL,HL
        ADD	HL,HL
        ADD	HL,HL
        LD	C,L
        LD	B,H
        ADD	HL,HL
        ADD	HL,HL
        LD	A,(D.FCAF)
        AND	A
        LD	A,(D.F3B0)
        JR	Z,J$0F50
;
        SUB	22H	; """
        JR	J.0F5D
;
;	-----------------
J$0F50:	CP	29H	; ")"
        JR	C,J$0F5A
;
        ADD	HL,BC
        ADD	HL,HL
        SUB	52H	; "R"
        JR	J.0F5D
;
;	-----------------
J$0F5A:	ADD	HL,BC
        SUB	2AH	; "*"
J.0F5D:	ADD	HL,DE
        CPL	
        AND	A
        RRA	
        LD	E,A
        ADD	HL,DE
        EX	DE,HL
        LD	HL,(D.F922)
        ADD	HL,DE
        POP	BC
        RET	
;
;	-----------------
;
;	  Subroutine __________________________
;	     Inputs  ________________________
;	     Outputs ________________________
;
C.0F6A:	PUSH	HL
        LD	D,A
        CALL	C.0FF9
;
        CALL	C.08F1
;
        EX	(SP),HL
        EX	(SP),HL
        IN	A,(98H)
        LD	B,A
        DEFB	0,0
        IN	A,(98H)
        LD	C,A
        POP	HL
        RET	
;
;	-----------------
J.0F7E:	PUSH	HL
        LD	D,00H
        CALL	C.0FF9
;
        CALL	C.08F1
;
        LD	B,D
        LD	C,10H	; 16 
        CALL	C.0647
;
        LD	B,10H	; 16 
J$0F8F:	IN	A,(98H)
        NOP	
        OUT	(9AH),A
        NOP	
        IN	A,(98H)
        NOP	
        OUT	(9AH),A
        NOP	
        DJNZ	J$0F8F
;
        POP	HL
        RET	
;
;	-----------------
;
;	  Subroutine __________________________
;	     Inputs  ________________________
;	     Outputs ________________________
;
C.0F9F:	PUSH	HL
        LD	HL,I$0FB3
        LD	B,10H	; 16 
        LD	D,00H
J$0FA7:	LD	A,(HL)
        INC	HL
        LD	E,(HL)
        INC	HL
        CALL	C.0FD3
;
        INC	D
        DJNZ	J$0FA7
;
        POP	HL
        RET	
;
;	-----------------
I$0FB3:	DEFB	0,0,0,0
        LD	DE,I$3306
        RLCA	
        RLA	
        LD	BC,I$0327
        LD	D,C
        LD	BC,I$0627
        LD	(HL),C
        LD	BC,I$0373
        LD	H,C
        LD	B,64H	; "d"
        LD	B,11H	; 17 
        INC	B
        LD	H,L
        LD	(BC),A
        LD	D,L
        DEC	B
        LD	(HL),A
        RLCA	
;
;	  Subroutine __________________________
;	     Inputs  ________________________
;	     Outputs ________________________
;
C.0FD3:	PUSH	BC
        PUSH	HL
        LD	B,D
        LD	C,10H	; 16 
        PUSH	AF
        CALL	C.0647
;
        POP	AF
        LD	C,9AH
        OUT	(C),A
        PUSH	AF
        POP	AF
        OUT	(C),E
        CALL	C.0FF9
;
        PUSH	AF
        CALL	C.08E3
;
        EX	(SP),HL
        EX	(SP),HL
        POP	AF
        OUT	(98H),A
        PUSH	AF
        POP	AF
        LD	A,E
        OUT	(98H),A
        POP	HL
        POP	BC
        RET	
;
;	-----------------
;
;	  Subroutine __________________________
;	     Inputs  ________________________
;	     Outputs ________________________
;
C.0FF9:	PUSH	AF
        LD	A,(D.FCAF)
        LD	HL,I$1020
I.1000:	PUSH	BC
        INC	A
        LD	C,A
        LD	B,00H
        DEC	A
        JR	NZ,J.1010
;
        LD	A,(D.F3B0)
        CP	29H	; ")"
        JR	NC,J.1010
;
        DEC	C
J.1010:	ADD	HL,BC
        ADD	HL,BC
        POP	BC
        LD	A,(HL)
        INC	HL
        LD	H,(HL)
        LD	L,A
        PUSH	DE
        LD	E,D
        LD	D,00H
        ADD	HL,DE
        ADD	HL,DE
        POP	DE
        POP	AF
        RET	
;
;	-----------------
I$1020:	NOP	
        INC	B
        NOP	
        RRCA	
        JR	NZ,J$1046
;
        ADD	A,B
        DEC	DE
        JR	NZ,J$104A
;
        ADD	A,B
        DEC	DE
        ADD	A,B
        HALT	
;
;	-----------------
?.102E:	ADD	A,B
        HALT	
;
;	-----------------
?.1030:	ADD	A,B
        JP	M,J$FA80
;
;
;	  Subroutine __________________________
;	     Inputs  ________________________
;	     Outputs ________________________
;
C.1034:	LD	A,02H	; 2 
        CALL	C.298B
;
        AND	40H	; "@"
        JR	NZ,C.1034
;
J$103D:	LD	A,02H	; 2 
        CALL	C.298B
I$1041	EQU	$-1
;
        AND	40H	; "@"
        JR	Z,J$103D
;
J$1046:	RET	
;
;	-----------------
?.1047:	POP	AF
        RET	

;	  Subroutine KNJPRT
;	     Inputs  ________________________
;	     Outputs ________________________

J.1049:	PUSH	HL
J$104A:	PUSH	DE
        PUSH	BC
        PUSH	AF
        PUSH	BC
        LD	A,B
        CALL	C.1061
        POP	BC
        POP	AF
        PUSH	AF
        LD	(D.FC40),A
        LD	A,C
        CALL	C.1061
        POP	AF
        POP	BC
        POP	DE
        POP	HL
        RET	
;
;	-----------------
;
;	  Subroutine __________________________
;	     Inputs  ________________________
;	     Outputs ________________________
;
C.1061:	LD	IX,I$0195
        JP	C.001C
;
;	-----------------
J$1068:	LD	A,(D.FCAD)
        CP	03H	; 3 
        JR	C,J.107A
;
        CP	05H	; 5 
        JR	NC,J.107A
;
        LD	IX,I$0192
        JP	C.001C
;
;	-----------------
J.107A:	LD	A,(D.FCAF)
        AND	A
        JP	J$0868
;
;	-----------------
;
;	  Subroutine __________________________
;	     Inputs  ________________________
;	     Outputs ________________________
;
C$1081:	PUSH	AF
        CP	01H	; 1 
        JR	Z,J$108D
;
        LD	A,(D.FFE8)
        BIT	3,A
        JR	NZ,J$1091
;
J$108D:	POP	AF
        JP	C.09BF
;
;	-----------------
J$1091:	LD	A,E
        CP	65H	; "e"
        LD	IX,I.0186
        JR	NC,J$109E
;
        LD	IX,I.0189
J$109E:	CALL	C.001C
;
        POP	AF
        RET	

J$10A3:	CP	20			; korean lightpen (V9938) function 0 ?
        JP	Z,J$2D9E		;
        CP	23			; korean lightpen (V9938) function 3 ?
        JP	Z,J$2D92		; yep,

                                        ; old code, replaced by patch jump

        CP	8			; read lightpen function 0 ?
        JP	Z,J$3474		; yep, normal lightpen
        JP	J$34E1
;
;	-----------------
;
;	  Subroutine __________________________
;	     Inputs  ________________________
;	     Outputs ________________________
;
C$10B5:	CALL	C.1C73
;
        LD	C,A
        CPL	
        CALL	C.1C74
;
        CALL	C.1C73
;
        CPL	
        CP	C
        LD	A,C
        CALL	C.1C74
;
        RET	
;
;	-----------------
?.10C7:	CALL	M,C$2AE5
;
        CP	C
        CALL	M,C$11E5
J$10CC	EQU	$-2
;
        JR	J$10CC
;
;	-----------------
J$10D0:	LD	HL,(D.FCB9)
        PUSH	HL
        LD	HL,(D.FCB7)
        PUSH	HL
        LD	B,02H	; 2 
J$10DA:	PUSH	BC
        EX	DE,HL
        LD	DE,D.FC40
        LD	BC,C.0008
        LDIR	
        PUSH	HL
        CALL	C$112D
;
        POP	DE
        POP	BC
        DJNZ	J$10DA
;
        POP	HL
        LD	(D.FCB7),HL
I$10EF	EQU	$-1
        POP	HL
        PUSH	BC
        LD	BC,C.0008
        ADD	HL,BC
        POP	BC
        LD	(D.FCB9),HL
        DEC	C
        JR	NZ,J$10D0
;
        POP	HL
        LD	(D.FCB9),HL
        POP	HL
        LD	BC,C.0010
        ADD	HL,BC
        LD	(D.FCB7),HL
I.1109:	POP	AF
        POP	BC
        POP	DE
        POP	HL
        RET	
;
;	-----------------
J$110E:	PUSH	HL
        PUSH	DE
        PUSH	BC
        PUSH	AF
        LD	HL,I.1109
        PUSH	HL
        CALL	C.12A5
;
        RET	NC
;
        JR	NZ,J$1124
;
        CP	0DH	; 13 
        JP	Z,J.1210
;
        CP	20H	; " "
        RET	C
;
J$1124:	CALL	C.07D9
;
I$1127:	LD	A,(D.F3E9)
        LD	(D.F3F2),A
;
;	  Subroutine __________________________
;	     Inputs  ________________________
;	     Outputs ________________________
;
C$112D:	LD	HL,(D.FCB9)
        EX	DE,HL
        LD	BC,(D.FCB7)
        CALL	C.12C4
;
        RET	NC
;
        CALL	C.1342
;
        LD	DE,D.FC40
        CALL	C.2980
;
        PUSH	DE
        XOR	A
        CALL	C.29DB
;
        CALL	C.1376
;
        LD	E,A
        CALL	C.29A5
;
        LD	A,E
        SUB	0CDH
        LD	L,08H	; 8 
        JR	C,J$115A
;
        LD	L,A
        LD	A,07H	; 7 
        SUB	L
        LD	L,A
J$115A:	LD	B,L
        LD	DE,C.0008
        LD	H,D
        CALL	C.29C4
;
        POP	DE
        LD	A,(D.F3F2)
        LD	L,A
        LD	A,(D.F3EA)
        LD	H,A
        LD	A,(DE)
        ADD	A,A
        LD	C,A
        LD	A,H
        JR	NC,J$1172
;
        LD	A,L
J$1172:	CALL	C.29EB
;
        LD	A,(D.FB02)
        AND	0FH	; 15 
        OR	0B0H
        CALL	C.29E3
;
        DI	
        LD	A,0ACH
        OUT	(99H),A
        LD	A,91H
        OUT	(99H),A
        LD	A,C
        LD	C,9BH
        DI	
        JR	J.11A3
;
;	-----------------
J$118E:	DI	
        LD	A,0ACH
        OUT	(99H),A
        LD	A,91H
        OUT	(99H),A
        INC	DE
        LD	A,(DE)
        RLCA	
        JR	NC,J$11A1
;
        OUT	(C),L
        JP	J.11A3
;
;	-----------------
J$11A1:	OUT	(C),H
J.11A3:	RLCA	
        JR	NC,J$11AB
;
        OUT	(C),L
        JP	J$11AD
;
;	-----------------
J$11AB:	OUT	(C),H
J$11AD:	RLCA	
        JR	NC,J$11B5
;
        OUT	(C),L
        JP	J$11B7
;
;	-----------------
J$11B5:	OUT	(C),H
J$11B7:	RLCA	
        JR	NC,J$11BF
;
        OUT	(C),L
        JP	J$11C1
;
;	-----------------
J$11BF:	OUT	(C),H
J$11C1:	RLCA	
        JR	NC,J$11C9
;
        OUT	(C),L
        JP	J$11CB
;
;	-----------------
J$11C9:	OUT	(C),H
J$11CB:	RLCA	
        JR	NC,J$11D3
;
        OUT	(C),L
        JP	J$11D5
;
;	-----------------
J$11D3:	OUT	(C),H
J$11D5:	RLCA	
        JR	NC,J$11DD
;
        OUT	(C),L
        JP	J$11DF
;
;	-----------------
J$11DD:	OUT	(C),H
J$11DF:	RLCA	
        JR	NC,J$11E7
;
        OUT	(C),L
        JP	J$11E9
C$11E5	EQU	$-2
;
;	-----------------
J$11E7:	OUT	(C),H
J$11E9:	EI	
        DJNZ	J$118E
;
        LD	A,(D.FCAF)
        AND	0FEH
        CP	06H	; 6 
        JR	Z,J$1200
;
        LD	A,(D.FCB7)
        ADD	A,08H	; 8 
        JR	C,J.1210
;
        LD	(D.FCB7),A
        RET	
;
;	-----------------
J$1200:	LD	HL,(D.FCB7)
        LD	BC,C.0008
        ADD	HL,BC
        LD	A,H
        AND	0FEH
        JR	NZ,J.1210
;
        LD	(D.FCB7),HL
        RET	
;
;	-----------------
J.1210:	LD	HL,C.0000
        LD	(D.FCB7),HL
        LD	A,(D.FCB9)
        ADD	A,08H	; 8 
        CP	0D4H
        JR	C,J$1220
;
        XOR	A
J$1220:	LD	(D.FCB9),A
        RET	
;
;	-----------------
;
;	  Subroutine __________________________
;	     Inputs  ________________________
;	     Outputs ________________________
;
C$1224:	PUSH	HL
        PUSH	DE
        PUSH	BC
        PUSH	AF
        LD	HL,I.1109
        PUSH	HL
        CALL	C.12A5
;
        RET	NC
;
        JR	NZ,J$123A
;
        CP	07H	; 7 
        JP	Z,J.1A62
;
        CP	20H	; " "
        RET	C
;
J$123A:	CALL	C.07D9
;
        LD	DE,D.FC40
        PUSH	DE
        CALL	C.2980
;
        XOR	A
        CALL	C.29DB
;
        CALL	C.1376
;
        CALL	C.29A5
;
        LD	HL,C.0008
        LD	DE,C.0010
        CALL	C.29C4
;
        POP	DE
        LD	HL,I$0103
        LD	A,(DE)
        ADD	A,A
        LD	C,A
        LD	A,H
        JR	NC,J$1262
;
        LD	A,L
J$1262:	PUSH	AF
        CALL	C.29EB
;
        LD	A,0B0H
        CALL	C.29E3
;
        DI	
        LD	A,0ACH
        OUT	(99H),A
        LD	A,91H
        OUT	(99H),A
        POP	AF
        OUT	(9BH),A
        LD	A,C
        LD	C,9BH
        LD	B,08H	; 8 
        PUSH	BC
        DEC	B
        JR	J.1285
;
;	-----------------
J$1280:	INC	DE
        LD	A,(DE)
        PUSH	BC
        LD	B,08H	; 8 
J.1285:	RLCA	
        JR	NC,J$1290
;
        OUT	(C),L
        PUSH	AF
        POP	AF
        OUT	(C),L
        JR	J$1296
;
;	-----------------
J$1290:	OUT	(C),H
        PUSH	AF
        POP	AF
        OUT	(C),H
J$1296:	DJNZ	J.1285
;
        POP	BC
        DJNZ	J$1280
;
        LD	HL,(D.F92A)
        LD	BC,C.0010
        ADD	HL,BC
        JP	J.1372
;
;	-----------------
;
;	  Subroutine __________________________
;	     Inputs  ________________________
;	     Outputs ________________________
;
C.12A5:	PUSH	HL
        PUSH	AF
        LD	HL,I$FCA6
        XOR	A
        CP	(HL)
        LD	(HL),A
        JR	Z,J$12BC
;
        POP	AF
        SUB	40H	; "@"
        CP	20H	; " "
        JR	C,J$12BA
;
        ADD	A,40H	; "@"
J$12B8:	CP	A
        SCF	
J$12BA:	POP	HL
        RET	
;
;	-----------------
J$12BC:	POP	AF
        CP	01H	; 1 
        JR	NZ,J$12B8
;
        LD	(HL),A
        POP	HL
        RET	
;
;	-----------------
;
;	  Subroutine __________________________
;	     Inputs  ________________________
;	     Outputs ________________________
;
C.12C4:	CALL	C.062C
;
        JP	NC,J$1305
;
        PUSH	HL
        PUSH	BC
        LD	B,01H	; 1 
        EX	DE,HL
        LD	A,H
        ADD	A,A
        JR	NC,J$12D8
;
        LD	HL,C.0000
        JR	J$12E0
;
;	-----------------
J$12D8:	LD	DE,I$00C0
        RST	20H
;
        JR	C,J$12E2
;
        EX	DE,HL
        DEC	HL
J$12E0:	LD	B,00H
J$12E2:	EX	(SP),HL
        LD	A,H
        ADD	A,A
        JR	NC,J$12EC
;
        LD	HL,C.0000
        JR	J$12F4
;
;	-----------------
J$12EC:	LD	DE,I.0100
        RST	20H
;
        JR	C,J$12F6
;
        EX	DE,HL
        DEC	HL
J$12F4:	LD	B,00H
J$12F6:	POP	DE
        SRL	L
        SRL	L
        SRL	E
        SRL	E
        LD	A,B
        RRCA	
        LD	C,L
        LD	B,H
        POP	HL
        RET	
;
;	-----------------
J$1305:	PUSH	HL
        PUSH	BC
        LD	B,01H	; 1 
        EX	DE,HL
        LD	A,H
        ADD	A,A
        JR	NC,J$1313
;
        LD	HL,C.0000
        JR	J$131B
;
;	-----------------
J$1313:	LD	DE,I.00D4
        RST	20H
;
        JR	C,J$131D
;
        EX	DE,HL
        DEC	HL
J$131B:	LD	B,00H
J$131D:	EX	(SP),HL
        LD	A,H
        ADD	A,A
        JR	NC,J$1327
;
        LD	HL,C.0000
        JR	J$1339
;
;	-----------------
J$1327:	LD	A,(D.FCAF)
        AND	02H	; 2 
        LD	DE,I.0200
        JR	NZ,J$1334
;
        LD	DE,I.0100
J$1334:	RST	20H
;
        JR	C,J$133B
;
        EX	DE,HL
        DEC	HL
J$1339:	LD	B,00H
J$133B:	LD	A,B
        RRCA	
        LD	B,H
        LD	C,L
        POP	DE
        POP	HL
        RET	
;
;	-----------------
;
;	  Subroutine __________________________
;	     Inputs  ________________________
;	     Outputs ________________________
;
C.1342:	CALL	C.062C
;
        JR	C,J$134F
;
        LD	H,B
        LD	L,C
        LD	A,E
        LD	(D.F92C),A
        JR	J.1372
;
;	-----------------
J$134F:	PUSH	BC
        LD	A,C
        RRCA	
        LD	A,0F0H
        JR	NC,J$1358
;
        LD	A,0FH	; 15 
J$1358:	LD	(D.F92C),A
        LD	A,C
        ADD	A,A
        ADD	A,A
        AND	0F8H
        LD	C,A
        LD	A,E
        AND	07H	; 7 
        OR	C
        LD	C,A
        LD	A,E
        RRCA	
        RRCA	
        RRCA	
        AND	07H	; 7 
        LD	B,A
        LD	HL,(D.F3D5)
        ADD	HL,BC
        POP	BC
J.1372:	LD	(D.F92A),HL
        RET	
;
;	-----------------
;
;	  Subroutine __________________________
;	     Inputs  ________________________
;	     Outputs ________________________
;
C.1376:	LD	A,(D.F92C)
        LD	HL,(D.F92A)
        RET	
;
;	-----------------
;
;	  Subroutine __________________________
;	     Inputs  ________________________
;	     Outputs ________________________
;
C.137D:	LD	(D.F92C),A
        LD	(D.F92A),HL
        RET	
;
;	-----------------
;
;	  Subroutine __________________________
;	     Inputs  ________________________
;	     Outputs ________________________
;
C.1384:	CALL	C.062C
;
        JP	NC,J$13A1
;
        PUSH	BC
        PUSH	HL
        CALL	C.1376
;
        LD	B,A
        CALL	C$08D3
;
        INC	B
        DEC	B
        JP	P,J$139C
;
        RRCA	
        RRCA	
        RRCA	
        RRCA	
J$139C:	AND	0FH	; 15 
        POP	HL
        POP	BC
        RET	
;
;	-----------------
J$13A1:	PUSH	HL
        LD	HL,(D.F92A)
        LD	A,(D.F92C)
        CALL	C$2949
;
        POP	HL
        RET	
;
;	-----------------
;
;	  Subroutine __________________________
;	     Inputs  ________________________
;	     Outputs ________________________
;
C.13AD:	CALL	C.1E47
;
        RET	C
;
        LD	(D.F3F2),A
        RET	
;
;	-----------------
;
;	  Subroutine __________________________
;	     Inputs  ________________________
;	     Outputs ________________________
;
C.13B5:	PUSH	BC
        PUSH	DE
        PUSH	HL
        CALL	C.062C
;
        LD	A,(D.F92C)
        LD	HL,(D.F92A)
        JR	C,J$13CA
;
        CALL	C$2961
;
        POP	HL
        POP	DE
        POP	BC
        RET	
;
;	-----------------
J$13CA:	LD	B,A
        CALL	C.08D6
;
        LD	C,A
        LD	A,B
        CPL	
        AND	C
        LD	C,A
        LD	A,(D.F3F2)
        INC	B
        DEC	B
        JP	P,J$13DF
;
        ADD	A,A
        ADD	A,A
        ADD	A,A
        ADD	A,A
J$13DF:	OR	C
        CALL	C.08CB
;
        POP	HL
        POP	DE
        POP	BC
        RET	
;
;	-----------------
;
;	  Subroutine __________________________
;	     Inputs  ________________________
;	     Outputs ________________________
;
C.13E7:	PUSH	HL
        CALL	C.062C
;
        CALL	C.1376
;
        JP	C,J$1466
;
        DEC	HL
        LD	A,H
        OR	A
        JP	M,J.1471
;
        LD	(D.F92A),HL
        POP	HL
        RET	
;
;	-----------------
;
;	  Subroutine __________________________
;	     Inputs  ________________________
;	     Outputs ________________________
;
C.13FC:	PUSH	HL
        CALL	C.062C
;
        CALL	C.1376
;
        JP	C,J$1474
;
        LD	A,(D.F92C)
        CP	0D3H
        JR	NC,J.1471
;
        INC	A
        LD	(D.F92C),A
        POP	HL
        AND	A
        RET	
;
;	-----------------
;
;	  Subroutine __________________________
;	     Inputs  ________________________
;	     Outputs ________________________
;
C.1414:	CALL	C.062C
;
        JP	C,J$14AE
;
        LD	A,(D.F92C)
        OR	A
        SCF	
        RET	Z
;
        DEC	A
        LD	(D.F92C),A
        OR	A
        RET	
;
;	-----------------
;
;	  Subroutine __________________________
;	     Inputs  ________________________
;	     Outputs ________________________
;
C.1426:	PUSH	HL
        CALL	C.1376
;
        AND	A
        LD	A,0FH	; 15 
        JP	M,J.1460
;
        LD	A,L
        AND	0F8H
        CP	0F8H
        JR	NZ,J$1443
;
        JR	J.1471
;
;	-----------------
J.1439:	PUSH	HL
        CALL	C.1376
;
        AND	A
        LD	A,0FH	; 15 
        JP	M,J.1460
;
J$1443:	PUSH	DE
        LD	DE,C.0008
        LD	A,0F0H
        JR	J$145B
;
;	-----------------
J$144B:	PUSH	HL
        CALL	C.1376
;
        AND	A
        LD	A,0F0H
        JP	P,J.1460
;
J$1455:	PUSH	DE
        LD	DE,I$FFF8
        LD	A,0FH	; 15 
J$145B:	ADD	HL,DE
        LD	(D.F92A),HL
        POP	DE
J.1460:	LD	(D.F92C),A
        AND	A
        POP	HL
        RET	
;
;	-----------------
J$1466:	AND	A
        LD	A,0F0H
        JP	P,J.1460
;
        LD	A,L
        AND	0F8H
        JR	NZ,J$1455
;
J.1471:	SCF	
        POP	HL
        RET	
;
;	-----------------
J$1474:	PUSH	DE
        PUSH	HL
        LD	HL,(D.F3D5)
        LD	DE,I$0500
        ADD	HL,DE
        EX	DE,HL
        POP	HL
        RST	20H
;
        JR	C,J.148E
;
        LD	A,L
        INC	A
        AND	07H	; 7 
        JR	NZ,J.148E
;
        SCF	
        POP	DE
        POP	HL
        RET	
;
;	-----------------
J$148C:	PUSH	HL
        PUSH	DE
J.148E:	CALL	C.1376
;
        INC	HL
        LD	A,L
        LD	DE,I$00F8
        JR	J$14A2
;
;	-----------------
J$1498:	PUSH	HL
        PUSH	DE
J.149A:	CALL	C.1376
;
        LD	A,L
        DEC	HL
        LD	DE,I$FF08
J$14A2:	AND	07H	; 7 
        JR	NZ,J$14A7
;
        ADD	HL,DE
J$14A7:	LD	(D.F92A),HL
        AND	A
        POP	DE
        POP	HL
        RET	
;
;	-----------------
J$14AE:	PUSH	HL
        PUSH	DE
        LD	HL,(D.F3D5)
        LD	DE,I.0100
        ADD	HL,DE
        EX	DE,HL
        LD	HL,(D.F92A)
        RST	20H
;
        JR	NC,J.149A
;
        LD	A,L
        AND	07H	; 7 
        JR	NZ,J.149A
;
        SCF	
        POP	DE
        POP	HL
        RET	
;
;	-----------------
;
;	  Subroutine __________________________
;	     Inputs  ________________________
;	     Outputs ________________________
;
C$14C7:	AND	A
        PUSH	AF
        LD	A,(D.FCAF)
        CP	08H	; 8 
        JR	Z,J$14D8
;
        POP	AF
        CP	10H	; 16 
        CCF	
J$14D4:	LD	(D.FCB2),A
        RET	
;
;	-----------------
J$14D8:	POP	AF
        JR	J$14D4
;
;	-----------------
;
;	  Subroutine __________________________
;	     Inputs  ________________________
;	     Outputs ________________________
;
C.14DB:	LD	HL,C.0000
        LD	C,L
        CALL	C.062C
;
        JP	C,J.1566
;
        PUSH	HL
        PUSH	BC
        PUSH	DE
        LD	HL,(D.F92A)
        LD	A,(D.F92C)
        LD	E,A
        LD	D,00H
        LD	A,(D.FCB2)
        CALL	C.28E0
;
        JR	C,J$14FF
;
        POP	DE
J.14FA:	POP	BC
        POP	HL
        LD	D,H
        LD	E,H
        RET	
;
;	-----------------
J$14FF:	POP	DE
        PUSH	HL
        LD	HL,(D.F92A)
        ADD	HL,DE
        POP	DE
        OR	A
        SBC	HL,DE
        JR	C,J.14FA
;
        JR	Z,J.14FA
;
        POP	BC
        POP	BC
        PUSH	HL
        EX	DE,HL
        LD	(D.F942),HL
        LD	A,(D.F92C)
        LD	(D.F944),A
        LD	E,A
        LD	D,00H
        LD	A,(D.FCB2)
        CALL	C$28E4
;
        PUSH	AF
        JR	C,J.1533
;
        LD	A,(D.FCAF)
        AND	02H	; 2 
        LD	HL,I$01FF
        JR	NZ,J.1533
;
        LD	HL,I.00FF
J.1533:	LD	(D.F92A),HL
        POP	AF
        JR	C,J$153A
;
        INC	HL
J$153A:	PUSH	HL
        EX	DE,HL
        LD	HL,(D.F942)
        EX	DE,HL
        OR	A
        SBC	HL,DE
        EX	(SP),HL
        PUSH	HL
        EX	DE,HL
        LD	A,(D.F944)
        LD	E,A
        LD	D,00H
        LD	A,(D.F3F2)
        CALL	C.28E0
;
        POP	DE
        JR	NC,J.1561
;
        RST	20H
;
        JR	NC,J.1561
;
        POP	DE
        LD	HL,(D.F942)
        CALL	C$15DB
;
        POP	DE
        RET	
;
;	-----------------
J.1561:	LD	C,00H
        POP	HL
        POP	DE
        RET	
;
;	-----------------
J.1566:	CALL	C.1633
;
        JR	NC,J$1578
;
        DEC	DE
        LD	A,D
        OR	E
        RET	Z
;
        CALL	C.1426
;
        JR	NC,J.1566
;
        LD	DE,C.0000
        RET	
;
;	-----------------
J$1578:	CALL	C.1376
;
        LD	(D.F942),HL
        LD	(D.F944),A
        LD	HL,C.0000
J$1584:	INC	HL
        CALL	C.1426
;
        RET	C
;
        CALL	C.1633
;
        JR	NC,J$1584
;
        RET	
;
;	-----------------
;
;	  Subroutine __________________________
;	     Inputs  ________________________
;	     Outputs ________________________
;
C.158F:	LD	HL,C.0000
        LD	C,L
        CALL	C.062C
;
        JP	C,J.1626
;
        CALL	C.13E7
;
        RET	C
;
        LD	HL,(D.F92A)
        PUSH	HL
        LD	A,(D.F92C)
        LD	E,A
        LD	D,00H
        LD	A,(D.FCB2)
        CALL	C$28D8
;
        PUSH	AF
        JR	C,J$15B3
;
        LD	HL,D.FFFF
J$15B3:	INC	HL
        LD	(D.F92A),HL
        EX	DE,HL
        POP	HL
        EX	(SP),HL
        PUSH	HL
        OR	A
        SBC	HL,DE
        INC	HL
        EX	(SP),HL
        PUSH	DE
        LD	A,(D.F92C)
        LD	E,A
        LD	D,00H
        LD	A,(D.F3F2)
        CALL	C$28DC
;
        JR	NC,J$161B
;
        POP	DE
        POP	BC
        POP	AF
        PUSH	BC
        PUSH	DE
        JR	NC,J$15D9
;
        RST	20H
;
        JR	C,J$1621
;
J$15D9:	POP	HL
        POP	DE
;
;	  Subroutine __________________________
;	     Inputs  ________________________
;	     Outputs ________________________
;
C$15DB:	LD	A,24H	; "$"
        DI	
        OUT	(99H),A
        LD	A,91H
        OUT	(99H),A
        LD	A,L
        OUT	(9BH),A
        LD	A,H
        OUT	(9BH),A
        LD	A,(D.F92C)
        OUT	(9BH),A
        LD	A,(D.FAF6)
        OUT	(9BH),A
        LD	A,E
        OUT	(9BH),A
        LD	A,D
        OUT	(9BH),A
        LD	A,01H	; 1 
        OUT	(9BH),A
        XOR	A
        OUT	(9BH),A
        LD	A,(D.F3F2)
        OUT	(9BH),A
I$1605	EQU	$-1
        XOR	A
        OUT	(9BH),A
        LD	A,(D.FCAF)
        CP	08H	; 8 
        LD	A,80H
        JR	NZ,J$1614
;
        LD	A,0C0H
J$1614:	OUT	(9BH),A
        EI	
        EX	DE,HL
        LD	C,0FFH
        RET	
;
;	-----------------
J$161B:	POP	DE
        POP	HL
        POP	DE
        LD	C,00H
        RET	
;
;	-----------------
J$1621:	POP	DE
        POP	HL
        LD	C,00H
        RET	
;
;	-----------------
J.1626:	CALL	C.13E7
;
        RET	C
;
        CALL	C.1633
;
        JP	C,J.1439
;
        INC	HL
        JR	J.1626
;
;	-----------------
;
;	  Subroutine __________________________
;	     Inputs  ________________________
;	     Outputs ________________________
;
C.1633:	CALL	C.1384
;
        LD	B,A
        LD	A,(D.FCB2)
        SUB	B
        SCF	
        RET	Z
;
        LD	A,(D.F3F2)
        CP	B
        RET	Z
;
        CALL	C.13B5
;
I$1645:	LD	C,01H	; 1 
        AND	A
        RET	
;
;	-----------------
?.1649:	EI	
        LD	DE,I$1660
        PUSH	HL
        LD	HL,I.FD89
        CALL	C.16AD
;
        POP	HL
        RET	C
;
        SCF	
        RET	NZ
;
        CALL	C.165E
;
        EI	
        AND	A
        RET	
;
;	-----------------
;
;	  Subroutine __________________________
;	     Inputs  ________________________
;	     Outputs ________________________
;
C.165E:	PUSH	DE
        RET	
;
;	-----------------
I$1660:	LD	C,L
        LD	B,L
        LD	C,L
        LD	C,C
        LD	C,(HL)
        LD	C,C
        NOP	
        LD	DE,I$4D37
        LD	C,E
        LD	C,C
        LD	C,H
        LD	C,H
        NOP	
        INC	HL
        ADD	HL,SP
        LD	C,L
        LD	C,(HL)
        LD	B,C
        LD	C,L
        LD	B,L
        NOP	
        ADC	A,B
        ADD	HL,SP
        LD	C,L
        LD	B,(HL)
        LD	C,C
        LD	C,H
        LD	B,L
        LD	D,E
        NOP	
        LD	(DE),A
        JR	C,J$1682
J$1682	EQU	$-1
;
J$1683:	PUSH	AF
        PUSH	HL
        LD	DE,I$1699
        CALL	C.16AD
;
        JR	C,J$1695
;
        POP	AF
        POP	AF
        DEC	HL
        CALL	C.165E
;
        AND	A
        RET	
;
;	-----------------
J$1695:	POP	HL
        POP	AF
        SCF	
        RET	
;
;	-----------------
I$1699:	RLC	B
        IN	A,(16H)
        LD	B,H
        LD	B,C
        LD	D,H
        LD	B,L
        NOP	
        POP	HL
        LD	D,48H	; "H"
        LD	B,C
        LD	C,(HL)
        NOP	
        SUB	L
        LD	HL,I$21FF
        RST	38H
;
;	  Subroutine __________________________
;	     Inputs  ________________________
;	     Outputs ________________________
;
C.16AD:	PUSH	HL
        LD	A,(DE)
        INC	A
        JR	Z,J$16C6
;
        CALL	C.16C9
;
        JR	Z,J$16BD
;
        INC	DE
        INC	DE
        INC	DE
        POP	HL
        JR	C.16AD
;
;	-----------------
J$16BD:	LD	A,(HL)
        EX	(SP),HL
        EX	DE,HL
        INC	HL
        LD	E,(HL)
        INC	HL
        LD	D,(HL)
        AND	A
I$16C5:	JR	C,J.16FE
J$16C6	EQU	$-1
;
        POP	HL
        RET	
;
;	-----------------
;
;	  Subroutine __________________________
;	     Inputs  ________________________
;	     Outputs ________________________
;
C.16C9:	LD	A,(DE)
        OR	A
        RET	Z
;
        CP	(HL)
        JR	NZ,J.16D3
;
        INC	DE
        INC	HL
        JR	C.16C9
;
;	-----------------
J.16D3:	LD	A,(DE)
        AND	A
        INC	DE
        JR	NZ,J.16D3
;
        DEC	DE
        DEC	A
        RET	
;
;	-----------------
?.16DB:	DEC	B
        LD	BC,I$174B
        JR	J$16E5
;
;	-----------------
?.16E1:	DEC	B
        LD	BC,I$1767
J$16E5:	JP	P,J.0546
;
        RST	10H
;
        PUSH	BC
        CALL	C.05D8
;
        CALL	C$05D2
;
        DEC	HL
        RST	10H
;
        JR	Z,J.16FE
;
        RST	08H
;
        INC	L
        RST	08H
;
        LD	B,C
        EX	(SP),HL
        LD	BC,I$000E
        ADD	HL,BC
        EX	(SP),HL
J.16FE:	POP	BC
        PUSH	HL
        PUSH	DE
        PUSH	BC
        LD	A,08H	; 8 
        CALL	C$05EA
;
        LD	HL,(D$F699)
        POP	DE
        PUSH	HL
        LD	A,(DE)
        RLCA	
        AND	01H	; 1 
        LD	B,A
        LD	C,04H	; 4 
        CALL	C.194B
;
        LD	C,02H	; 2 
J$1718:	LD	B,02H	; 2 
J$171A:	LD	A,(DE)
        INC	A
        JR	Z,J$1723
;
        DEC	A
        OUT	(0B4H),A
        IN	A,(0B5H)
J$1723:	INC	DE
        EX	DE,HL
        ADD	A,(HL)
        EX	DE,HL
        DEC	DE
        DAA	
        AND	0FH	; 15 
        OR	30H	; "0"
        LD	(HL),A
        INC	DE
        INC	DE
        INC	HL
        DJNZ	J$171A
;
        INC	C
        DEC	C
        JR	Z,J$173E
;
        LD	A,(DE)
        LD	(HL),A
        INC	DE
        INC	HL
        DEC	C
        JR	J$1718
;
;	-----------------
J$173E:	CALL	C$1947
;
        POP	DE
        POP	HL
        LD	(HL),08H	; 8 
        INC	HL
        LD	(HL),E
        INC	HL
        LD	(HL),D
        POP	HL
        RET	
;
;	-----------------
I$174B:	DEC	B
        NOP	
        INC	B
        NOP	
        LD	A,(D.0003)
        LD	(BC),A
        NOP	
        LD	A,(D.0001)
        DEFB	0,0
        ADD	A,L
        NOP	
        ADD	A,H
        NOP	
        LD	A,(D$0083)
        ADD	A,D
        NOP	
        LD	A,(DBUF.1)
        ADD	A,B
        NOP	
I$1767:	INC	C
        EX	AF,AF'
        DEC	BC
        NOP	
        CPL	
        LD	A,(BC)
        NOP	
        ADD	HL,BC
        NOP	
        CPL	
        EX	AF,AF'
        NOP	
        RLCA	
        NOP	
        RST	38H
        NOP	
        RST	38H
        NOP	
        CPL	
        RST	38H
        NOP	
        RST	38H
        NOP	
        CPL	
        ADC	A,B
        NOP	
        ADD	A,A
        NOP	
J$1783:	RST	10H
;
        PUSH	HL
        CALL	C.1CF7
;
        LD	B,03H	; 3 
        LD	A,(D.FCB0)
        LD	C,A
        LD	A,(D.FFE8)
        RRCA	
        RRCA	
        AND	02H	; 2 
        OR	C
        CALL	C$2C14
;
        LD	A,(D.F3B0)
        CALL	C.1A50
;
        LD	A,(D.F3E9)
        CALL	C.1A59
;
        LD	A,(D.F3EA)
        CALL	C.1A59
J$17AA	EQU	$-1
;
        LD	A,(D.F3EB)
        CALL	C.1A59
;
        LD	C,00H
        LD	A,(D.F3DE)
        OR	A
        JR	Z,J$17BB
;
        SET	0,C
J$17BB:	LD	A,(D.F3DB)
        OR	A
        JR	Z,J$17C3
;
        SET	1,C
J$17C3:	LD	A,(D.F417)
        OR	A
        JR	Z,J$17CB
;
        SET	2,C
J$17CB:	LD	A,(D.F3FC)
        LD	HL,I.F406
        CP	(HL)
        JR	Z,J$17D6
;
        SET	3,C
J$17D6:	LD	A,C
        JP	J$2C24
;
;	-----------------
?.17DA:	RST	08H
;
        JR	Z,J$17AA
;
        DEC	C
        JR	J$185B
;
;	-----------------
?.17E0:	PUSH	AF
        RST	08H
;
        INC	L
        CALL	C$180D
;
        RST	08H
;
        ADD	HL,HL
        POP	AF
        AND	0FH	; 15 
        LD	D,A
        CALL	C.17F8
;
        CALL	C.1CF7
;
        LD	B,01H	; 1 
        LD	A,D
        JP	C.1A50
;
;	-----------------
;
;	  Subroutine __________________________
;	     Inputs  ________________________
;	     Outputs ________________________
;
C.17F8:	LD	A,E
        RLCA	
        RLCA	
        RLCA	
        RLCA	
        AND	0F0H
        OR	D
I$1800:	LD	D,A
        LD	(D$FFF1),A
        DI	
        OUT	(99H),A
        LD	A,92H
        EI	
        OUT	(99H),A
        RET	
;
;	-----------------
;
;	  Subroutine __________________________
;	     Inputs  ________________________
;	     Outputs ________________________
;
C$180D:	CALL	C.0608
;
        PUSH	HL
        EX	DE,HL
        CALL	C.25DC
;
        EX	DE,HL
        LD	HL,I$0007
        RST	20H
;
        JR	NC,J$1823
;
        LD	HL,D.FFF7
        RST	20H
;
        JP	NC,J.0546
;
J$1823:	POP	HL
        RET	
;
;	-----------------
;
;	  Subroutine __________________________
;	     Inputs  ________________________
;	     Outputs ________________________
;
C.1825:	CALL	C.05FC
;
        PUSH	HL
        CALL	C.0614
;
        LD	A,(HL)
        INC	HL
        LD	E,(HL)
        INC	HL
        LD	D,(HL)
        POP	HL
        RET	
;
;	-----------------
J$1833:	CP	0C5H
        JP	Z,J$1783
;
        CP	0CBH
        JP	Z,J$188A
;
        CP	0C0H
        JP	Z,J$19A6
;
        LD	DE,I$184F
        CALL	C$2DD2
;
        JP	C,J.0540
;
        DEC	HL
        RST	10H
;
        PUSH	DE
        RET	
;
;	-----------------
I$184F:	LD	D,B
        LD	B,C
        LD	B,A
        LD	B,L
        NOP	
        OR	C
        RRA	
        LD	D,(HL)
        LD	C,C
        LD	B,H
        LD	B,L
        LD	C,A
J$185B:	NOP	
        XOR	A
        DEC	(HL)
        LD	B,C
        LD	B,H
        LD	C,D
        LD	D,L
        LD	D,E
        LD	D,H
        NOP	
        JP	C,J$5417
;
        LD	C,C
        LD	D,H
        LD	C,H
        LD	B,L
        NOP	
        ADD	A,B
        ADD	HL,DE
        LD	D,B
        LD	B,C
        LD	D,E
        LD	D,E
        LD	D,A
        RST	30H
;
        LD	B,H
        NOP	
        ADD	IX,DE
        LD	D,B
        LD	D,D
        LD	C,A
        LD	C,L
        LD	D,B
        LD	D,H
        NOP	
        POP	HL
        ADD	HL,DE
        LD	B,H
        LD	B,C
        LD	D,H
        LD	B,L
        NOP	
        ADC	A,(HL)
        JR	J$1889
J$1889	EQU	$-1
;
;	-----------------
J$188A:	RST	10H
;
        LD	A,3AH	; ":"
        LD	BC,I$2F3E
        PUSH	AF
        CALL	C.1825
;
        POP	IX
        CP	08H	; 8 
        JP	NZ,J.0540
;
        PUSH	HL
        EX	DE,HL
        CALL	C$195E
;
        JR	Z,J$18A6
;
        CP	24H	; "$"
        JR	NC,J.18C0
;
J$18A6:	LD	B,A
        CALL	C.1956
;
        JR	Z,J$18B0
;
        CP	60H	; "`"
        JR	J$18B2
;
;	-----------------
J$18B0:	CP	13H	; 19 
J$18B2:	JR	NC,J.18C0
;
        LD	C,A
        CALL	C.1956
;
        JR	Z,J$18BE
;
        CP	60H	; "`"
        JR	J.18C0
;
;	-----------------
J$18BE:	CP	32H	; "2"
J.18C0:	JP	NC,J.0546
;
        LD	D,A
        POP	HL
        PUSH	IX
        DEC	HL
        RST	10H
;
        POP	IX
        LD	A,00H
        JR	Z,J$18D9
;
        PUSH	IX
        RST	08H
;
        INC	L
        RST	08H
;
        LD	B,C
        POP	IX
        OR	01H	; 1 
J$18D9:	PUSH	HL
        PUSH	AF
        PUSH	BC
        PUSH	DE
        JR	NZ,J$18EA
;
        LD	BC,I.0004
        CALL	C.194B
;
        LD	BC,I.0E00
        JR	J$18F8
;
;	-----------------
J$18EA:	LD	BC,I$0108
        CALL	C.194B
;
        CALL	C.196C
;
        JR	Z,J$18FD
;
        LD	BC,I$0D00
J$18F8:	LD	A,0FH	; 15 
        CALL	C$194D
;
J$18FD:	POP	DE
        LD	B,00H
        CALL	C.196C
;
        JR	NZ,J$1907
;
        LD	B,07H	; 7 
J$1907:	LD	A,D
        CALL	C.1A50
;
        POP	DE
        POP	AF
        PUSH	AF
        JR	Z,J$1915
;
        CALL	C.196C
;
        JR	Z,J$1941
;
J$1915:	LD	A,E
        CALL	C.1A50
;
        LD	A,D
        CALL	C.196C
;
        JR	NZ,J$193E
;
        PUSH	AF
        PUSH	BC
        BIT	4,A
        JR	Z,J$1927
;
        ADD	A,02H	; 2 
J$1927:	AND	03H	; 3 
        PUSH	AF
        LD	A,01H	; 1 
        CALL	C.1CF9
;
        POP	AF
        LD	B,0BH	; 11 
        CALL	C.1A59
;
        XOR	A
        CALL	C.1CF9
;
        POP	BC
        POP	AF
        SUB	80H
        DAA	
J$193E:	CALL	C.1A50
;
J$1941:	POP	AF
        POP	HL
        LD	B,04H	; 4 
        JR	NZ,J$1949
;
;
;	  Subroutine __________________________
;	     Inputs  ________________________
;	     Outputs ________________________
;
C$1947:	LD	B,08H	; 8 
J$1949:	LD	C,0FH	; 15 
;
;	  Subroutine __________________________
;	     Inputs  ________________________
;	     Outputs ________________________
;
C.194B:	LD	A,0DH	; 13 
;
;	  Subroutine __________________________
;	     Inputs  ________________________
;	     Outputs ________________________
;
C$194D:	OUT	(0B4H),A
        IN	A,(0B5H)
        AND	C
        OR	B
        OUT	(0B5H),A
        RET	
;
;	-----------------
;
;	  Subroutine __________________________
;	     Inputs  ________________________
;	     Outputs ________________________
;
C.1956:	PUSH	IX
        POP	AF
        CP	(HL)
        INC	HL
        JP	NZ,J.0540
;
;
;	  Subroutine __________________________
;	     Inputs  ________________________
;	     Outputs ________________________
;
C$195E:	CALL	C.1974
;
        RLCA	
        RLCA	
        RLCA	
        RLCA	
        AND	0F0H
        LD	E,A
        CALL	C.1974
;
        OR	E
;
;	  Subroutine __________________________
;	     Inputs  ________________________
;	     Outputs ________________________
;
C.196C:	PUSH	BC
        PUSH	IX
        POP	BC
        BIT	4,B
        POP	BC
        RET	
;
;	-----------------
;
;	  Subroutine __________________________
;	     Inputs  ________________________
;	     Outputs ________________________
;
C.1974:	LD	A,(HL)
        INC	HL
        SUB	30H	; "0"
        JR	C,J.197D
;
        CP	0AH	; 10 
        RET	C
;
J.197D:	JP	J.0546
;
;	-----------------
?.1980:	CP	2CH	; ","
        JR	Z,J$198B
;
        XOR	A
        CALL	C.19EC
;
        DEC	HL
        RST	10H
;
        RET	Z
;
J$198B:	RST	08H
;
        INC	L
        RST	28H
;
        RET	NZ
;
        DEC	A
        CP	04H	; 4 
        JR	NC,J.197D
;
        PUSH	AF
        CALL	C.1CF7
;
        LD	B,0BH	; 11 
        CALL	C.1CD2
;
        AND	0CH	; 12 
        LD	C,A
        POP	AF
        OR	C
        DEC	B
        JP	C.1A59
;
;	-----------------
J$19A6:	CALL	C.1CF7
;
        LD	B,0AH	; 10 
        CALL	C.1CD2
;
        PUSH	AF
        RST	10H
;
        CP	2CH	; ","
        JR	Z,J$19C8
;
        RST	28H
;
        DEC	A
        CP	04H	; 4 
        JR	NC,J$19CE
;
        RLCA	
        RLCA	
        AND	0CH	; 12 
        LD	B,A
        POP	AF
        AND	03H	; 3 
        OR	B
        PUSH	AF
        DEC	HL
        RST	10H
;
        JR	Z,J$19D7
;
J$19C8:	RST	08H
;
        INC	L
        RST	28H
;
        DEC	A
        CP	04H	; 4 
J$19CE:	JP	NC,J.0546
;
        LD	B,A
        POP	AF
        AND	0CH	; 12 
        OR	B
        PUSH	AF
J$19D7:	LD	B,0AH	; 10 
        POP	AF
        JP	C.1A59
;
;	-----------------
?.19DD:	LD	A,01H	; 1 
        JR	J$19E3
;
;	-----------------
?.19E1:	LD	A,02H	; 2 
J$19E3:	CALL	C.19EC
;
        DEC	HL
        RST	10H
;
        JP	NZ,J.0540
;
        RET	
;
;	-----------------
;
;	  Subroutine __________________________
;	     Inputs  ________________________
;	     Outputs ________________________
;
C.19EC:	PUSH	AF
        CALL	C.1825
;
        LD	C,A
        CALL	C.1CF3
;
        LD	B,0CH	; 12 
        XOR	A
J$19F7:	CALL	C.1A59
;
        DEC	B
        DJNZ	J$19F7
;
        POP	AF
        CALL	C.1A59
;
        PUSH	HL
        EX	DE,HL
        DEC	A
        JR	Z,J$1A17
;
        LD	E,06H	; 6 
J$1A08:	DEC	C
        INC	C
        JR	Z,J.1A15
;
        LD	A,(HL)
        INC	HL
        CALL	C.1A50
;
        DEC	C
        DEC	E
        JR	NZ,J$1A08
;
J.1A15:	POP	HL
        RET	
;
;	-----------------
J$1A17:	LD	A,21H	; "!"
        CALL	C.1A50
;
        LD	A,03H	; 3 
        CALL	C.1A59
;
        LD	A,C
        PUSH	AF
        CALL	C$1CA5
;
        LD	B,04H	; 4 
        LD	A,E
        CALL	C.1A50
;
        LD	A,D
        CALL	C.1A50
;
        POP	AF
        LD	C,A
        XOR	A
        OUT	(7FH),A
        IN	A,(7FH)
        CP	0AAH
        JR	NZ,J.1A15
;
        LD	A,C
        OR	A
        LD	A,01H	; 1 
        JR	Z,J$1A42
;
        INC	A
J$1A42:	CALL	C.1A59
;
        PUSH	BC
        CALL	C.1C97
;
        POP	BC
        LD	A,E
        CALL	C.1A50
;
        LD	A,D
        POP	HL
;
;	  Subroutine __________________________
;	     Inputs  ________________________
;	     Outputs ________________________
;
C.1A50:	PUSH	AF
        CALL	C.1A59
;
        POP	AF
        RRCA	
        RRCA	
        RRCA	
        RRCA	
;
;	  Subroutine __________________________
;	     Inputs  ________________________
;	     Outputs ________________________
;
C.1A59:	PUSH	AF
        LD	A,B
        OUT	(0B4H),A
        INC	B
        POP	AF
        OUT	(0B5H),A
        RET	
;
;	-----------------
J.1A62:	PUSH	HL
        CALL	C$1AD0
;
        PUSH	AF
        DEC	B
        JR	Z,J$1A90
;
        DEC	B
        JR	Z,J$1AAD
;
        DEC	B
        JR	Z,J$1ABC
;
        LD	E,55H	; "U"
        CALL	C.1B11
;
        CALL	C.1B1A
;
        CALL	C.1B32
;
        LD	A,08H	; 8 
        CALL	C.1B1E
;
        LD	BC,I$07D0
        CALL	C.1B28
;
J$1A86:	CALL	C$056B
;
        POP	AF
        LD	B,0DH	; 13 
        POP	HL
        JP	C.1A59
;
;	-----------------
J$1A90:	LD	HL,I.1B3E
        LD	E,0B8H
        CALL	C$1B1C
;
        LD	E,0A7H
        LD	A,02H	; 2 
        CALL	C.1B12
;
        LD	E,0A8H
        LD	A,04H	; 4 
        CALL	C.1B12
;
        LD	E,0A6H
J.1AA8:	CALL	C.1AEA
;
        JR	J$1A86
;
;	-----------------
J$1AAD:	LD	HL,I.1B3E
        CALL	C.1B1A
;
        LD	E,2AH	; "*"
        CALL	C.1AEA
;
        LD	E,35H	; "5"
        JR	J.1AA8
;
;	-----------------
J$1ABC:	LD	HL,I$1B46
        CALL	C.1B1A
;
        LD	E,6BH	; "k"
        CALL	C.1AEA
;
        LD	E,47H	; "G"
        CALL	C.1AEA
;
        LD	E,55H	; "U"
        JR	J.1AA8
;
;	-----------------
;
;	  Subroutine __________________________
;	     Inputs  ________________________
;	     Outputs ________________________
;
C$1AD0:	LD	B,0DH	; 13 
        CALL	C.1CD2
;
        PUSH	AF
        CALL	C.1CF7
;
        LD	B,0AH	; 10 
        CALL	C.1CD2
;
        LD	C,A
        RRCA	
        RRCA	
J$1AE1:	AND	03H	; 3 
        LD	B,A
        LD	A,C
        AND	03H	; 3 
        LD	C,A
        POP	AF
        RET	
;
;	-----------------
;
;	  Subroutine __________________________
;	     Inputs  ________________________
;	     Outputs ________________________
;
C.1AEA:	CALL	C.1B11
;
        PUSH	BC
        PUSH	HL
        CALL	C.1B32
;
        POP	HL
        PUSH	HL
        ADD	HL,BC
        ADD	HL,BC
        LD	C,(HL)
        INC	HL
        LD	B,(HL)
J$1AF9:	LD	A,08H	; 8 
        CALL	C.1B1E
;
        LD	A,09H	; 9 
        CALL	C.1B1E
;
        LD	A,0AH	; 10 
        CALL	C.1B1E
;
        CALL	C.1B28
;
        DEC	E
        JR	NZ,J$1AF9
;
        POP	HL
        POP	BC
        RET	
;
;	-----------------
;
;	  Subroutine __________________________
;	     Inputs  ________________________
;	     Outputs ________________________
;
C.1B11:	XOR	A
;
;	  Subroutine __________________________
;	     Inputs  ________________________
;	     Outputs ________________________
;
C.1B12:	CALL	C.1B1E
;
        LD	E,00H
        INC	A
        JR	C.1B1E
;
;	-----------------
;
;	  Subroutine __________________________
;	     Inputs  ________________________
;	     Outputs ________________________
;
C.1B1A:	LD	E,0BEH
;
;	  Subroutine __________________________
;	     Inputs  ________________________
;	     Outputs ________________________
;
C$1B1C:	LD	A,07H	; 7 
;
;	  Subroutine __________________________
;	     Inputs  ________________________
;	     Outputs ________________________
;
C.1B1E:	DI	
        OUT	(0A0H),A
        PUSH	AF
        LD	A,E
        EI	
        OUT	(0A1H),A
        POP	AF
        RET	
;
;	-----------------
;
;	  Subroutine __________________________
;	     Inputs  ________________________
;	     Outputs ________________________
;
C.1B28:	PUSH	BC
J$1B29:	DEC	BC
        EX	(SP),HL
        EX	(SP),HL
        LD	A,B
        OR	C
        JR	NZ,J$1B29
;
        POP	BC
        RET	
;
;	-----------------
;
;	  Subroutine __________________________
;	     Inputs  ________________________
;	     Outputs ________________________
;
C.1B32:	LD	B,00H
        LD	HL,I$1B3A
        ADD	HL,BC
        LD	E,(HL)
        RET	
;
;	-----------------
I$1B3A:	INC	B
        RLCA	
        LD	A,(BC)
        RRCA	
I.1B3E:	RET	C
;
        DJNZ	J$1AE1
;
        ADD	HL,BC
        CP	L
        LD	B,7EH	; "~"
        INC	B
I$1B46:	SBC	A,L
        DEC	B
        DEC	(HL)
        INC	BC
        CCF	
        LD	(BC),A
        LD	A,A
        LD	BC,I$AECD
J$1B4E	EQU	$-2
        DEC	B
        CALL	C.1CF3
;
        CALL	C.1CD0
;
        CP	02H	; 2 
        LD	HL,I$3FD7
        JP	NZ,C.05F6
;
J$1B5F:	CALL	C.1CDB
;
        JR	Z,J$1B6A
;
        RST	18H
;
        LD	A,B
        CP	0DH	; 13 
        JR	C,J$1B5F
;
J$1B6A:	JP	J$05A8
;
;	-----------------
?.1B6D:	CALL	C.1C73
;
        LD	C,A
        CPL	
        CALL	C.1C74
;
        CALL	C.1C73
;
        CPL	
        CP	C
        LD	A,C
        CALL	C.1C74
;
        LD	HL,I$1C64
        LD	C,04H	; 4 
        JR	Z,J$1B8A
;
        LD	HL,I$1C68
        LD	C,02H	; 2 
J$1B8A:	PUSH	HL
        LD	A,(D.FAFC)
        AND	0F9H
        OR	C
        LD	(D.FAFC),A
        LD	HL,I.0090
        LD	A,0B4H
        CALL	C$1D2B
;
        LD	HL,I$1C5E
        CALL	C.1C4B
;
        POP	HL
        CALL	C.1C4B
;
        LD	HL,I$1C6C
        CALL	C.1C4B
;
J$1BAC:	XOR	A
        OUT	(99H),A
        OUT	(99H),A
        OUT	(99H),A
        LD	A,8EH
        OUT	(99H),A
        CALL	C.1CF3
;
        CALL	C.1CD0
;
        JR	Z,J$1C35
;
        DEC	A
        RET	NZ
;
        CALL	C.1CD2
;
        CP	01H	; 1 
        RET	NZ
;
        CALL	C.1CD2
;
        CP	02H	; 2 
        RET	NZ
;
        CALL	C.1CD2
;
        CP	03H	; 3 
        RET	NZ
;
        LD	B,08H	; 8 
        CALL	C.1CD2
;
        JR	Z,J.1BEF
;
        XOR	A
        OUT	(7FH),A
        IN	A,(7FH)
        CP	0AAH
        JR	NZ,J.1BEF
;
        PUSH	BC
        CALL	C.1C97
;
        POP	BC
        CALL	C.1CEA
;
        RST	20H
;
        RET	Z
;
        JR	J.1C00
;
;	-----------------
J.1BEF:	LD	A,06H	; 6 
        CALL	C.0590
;
        AND	04H	; 4 
        JR	NZ,J.1C00
;
        LD	A,07H	; 7 
        CALL	C.0590
;
        AND	10H	; 16 
        RET	Z
;
J.1C00:	DEFB	0,0,0,0,0,0,0
        EI	
        LD	HL,I$1C54
        CALL	C.2A4B
;
        LD	B,08H	; 8 
        CALL	C.1CD2
;
        DEC	A
J$1C14:	JR	Z,J$1C14
;
J$1C16:	LD	HL,D.F55E
        LD	B,0FFH
J$1C1B:	CALL	C.0565
;
        CP	0DH	; 13 
        JR	Z,J$1C26
;
        LD	(HL),A
        INC	HL
        DJNZ	J$1C1B
;
J$1C26:	LD	A,0FFH
        SUB	B
        CALL	C$1CA2
;
        LD	B,04H	; 4 
        CALL	C.1CEA
;
        RST	20H
;
        RET	Z
;
        JR	J$1C16
;
;	-----------------
J$1C35:	DEFB	0,0,0,0,0,0,0
J$1C3C:	CALL	C.1CDB
;
        RET	Z
;
        CALL	C.0018
;
        LD	A,B
        CP	0DH	; 13 
        JR	C,J$1C3C
;
        JP	C.0565
;
;	-----------------
;
;	  Subroutine __________________________
;	     Inputs  ________________________
;	     Outputs ________________________
;
C.1C4B:	LD	A,(HL)
        INC	HL
        OR	A
        RET	Z
;
        CALL	C$1224
;
        JR	C.1C4B
;
;	-----------------
I$1C54:	LD	D,B
        LD	H,C
        LD	(HL),E
        LD	(HL),E
        LD	(HL),A
        LD	L,A
        LD	(HL),D
        LD	H,H
        LD	A,(D$5600)
I$1C5E	EQU	$-1
        LD	D,D
        LD	B,C
        LD	C,L
        LD	A,(D$3100)
I$1C64	EQU	$-1
        LD	(X.0038),A
I$1C68:	JR	NZ,J$1CA0
;
        INC	(HL)
        NOP	
I$1C6C:	LD	C,E
        LD	H,D
        LD	A,C
        LD	(HL),H
        LD	H,L
        LD	(HL),E
        NOP	
;
;	  Subroutine __________________________
;	     Inputs  ________________________
;	     Outputs ________________________
;
C.1C73:	OR	37H	; "7"
C.1C74	EQU	$-1
        PUSH	AF
        LD	A,07H	; 7 
        OUT	(99H),A
        LD	A,8EH
        OUT	(99H),A
        LD	A,0FFH
        OUT	(99H),A
        POP	AF
        PUSH	AF
        LD	A,7FH
        JR	C,J$1C8A
;
        LD	A,3FH	; "?"
J$1C8A:	OUT	(99H),A
        EX	(SP),HL
        EX	(SP),HL
        POP	AF
        JR	C,J$1C94
;
        IN	A,(98H)
        RET	
;
;	-----------------
J$1C94:	OUT	(98H),A
        RET	
;
;	-----------------
;
;	  Subroutine __________________________
;	     Inputs  ________________________
;	     Outputs ________________________
;
C.1C97:	IN	A,(7FH)
        LD	L,A
        IN	A,(7FH)
        LD	H,A
        LD	(D.F55E),HL
J$1CA0:	LD	A,02H	; 2 
;
;	  Subroutine __________________________
;	     Inputs  ________________________
;	     Outputs ________________________
;
C$1CA2:	LD	HL,D.F55E
;
;	  Subroutine __________________________
;	     Inputs  ________________________
;	     Outputs ________________________
;
C$1CA5:	LD	DE,C.0000
        LD	C,A
        OR	A
        RET	Z
;
        SCF	
J$1CAC:	PUSH	AF
J$1CAD:	LD	B,08H	; 8 
J$1CAF:	POP	AF
        PUSH	AF
        JR	NC,J$1CB5
;
        RLC	(HL)
J$1CB5:	RL	E
        RL	D
        JR	NC,J$1CC3
;
        LD	A,D
        XOR	80H
        LD	D,A
        LD	A,E
        XOR	05H	; 5 
        LD	E,A
J$1CC3:	DJNZ	J$1CAF
;
        INC	HL
        DEC	C
        JR	NZ,J$1CAD
;
        POP	AF
        RET	NC
;
        OR	A
        LD	C,02H	; 2 
        JR	J$1CAC
;
;	-----------------
;
;	  Subroutine __________________________
;	     Inputs  ________________________
;	     Outputs ________________________
;
C.1CD0:	LD	B,00H
;
;	  Subroutine __________________________
;	     Inputs  ________________________
;	     Outputs ________________________
;
C.1CD2:	LD	A,B
        OUT	(0B4H),A
        INC	B
        IN	A,(0B5H)
        AND	0FH	; 15 
        RET	
;
;	-----------------
;
;	  Subroutine __________________________
;	     Inputs  ________________________
;	     Outputs ________________________
;
C.1CDB:	PUSH	DE
        CALL	C.1CD2
;
        LD	D,A
        CALL	C.1CD2
;
        RLCA	
        RLCA	
        RLCA	
        RLCA	
        OR	D
        POP	DE
        RET	
;
;	-----------------
;
;	  Subroutine __________________________
;	     Inputs  ________________________
;	     Outputs ________________________
;
C.1CEA:	CALL	C.1CDB
;
        LD	L,A
        CALL	C.1CDB
;
        LD	H,A
        RET	
;
;	-----------------
;
;	  Subroutine __________________________
;	     Inputs  ________________________
;	     Outputs ________________________
;
C.1CF3:	LD	A,03H	; 3 
        JR	C.1CF9
;
;	-----------------
;
;	  Subroutine __________________________
;	     Inputs  ________________________
;	     Outputs ________________________
;
C.1CF7:	LD	A,02H	; 2 
;
;	  Subroutine __________________________
;	     Inputs  ________________________
;	     Outputs ________________________
;
C.1CF9:	PUSH	BC
        PUSH	AF
        LD	B,0DH	; 13 
        CALL	C.1CD2
;
        AND	0CH	; 12 
        POP	BC
        OR	B
        OUT	(0B5H),A
        POP	BC
        RET	
;
;	-----------------
J$1D08:	CALL	C.1D1A
;
        IN	A,(0B5H)
        AND	0FH	; 15 
        RET	
;
;	-----------------
J$1D10:	PUSH	AF
        CALL	C.1D1A
;
        POP	AF
        AND	0FH	; 15 
        OUT	(0B5H),A
        RET	
;
;	-----------------
;
;	  Subroutine __________________________
;	     Inputs  ________________________
;	     Outputs ________________________
;
C.1D1A:	LD	A,C
        PUSH	AF
        AND	30H	; "0"
        RRCA	
        RRCA	
        RRCA	
        RRCA	
        CALL	C.1CF9
;
        POP	AF
        AND	0FH	; 15 
        OUT	(0B4H),A
        RET	
;
;	-----------------
;
;	  Subroutine __________________________
;	     Inputs  ________________________
;	     Outputs ________________________
;
C$1D2B:	LD	(D.F92A),HL
        LD	(D.F92C),A
        RET	
;
;	-----------------
?.1D32:	LD	A,(HL)
        EX	(SP),HL
        CP	(HL)
        JP	NZ,J.0540
;
        INC	HL
        EX	(SP),HL
J.1D3A:	CALL	C$FF48
;
        INC	HL
J.1D3E:	LD	A,(HL)
        CP	3AH	; ":"
        RET	NC
;
        CP	20H	; " "
        JR	Z,J.1D3A
;
        JR	NC,J$1DB1
;
        OR	A
        RET	Z
;
        CP	0BH	; 11 
        JR	C,J$1DAC
;
        CP	1EH
        JR	NZ,J$1D57
;
        LD	A,(D.F668)
        OR	A
        RET	
;
;	-----------------
J$1D57:	CP	10H	; 16 
        JR	Z,J$1D8F
;
        PUSH	AF
        INC	HL
        LD	(D.F668),A
        SUB	1CH
        JR	NC,J$1D94
;
        SUB	0F5H
        JR	NC,J$1D6E
;
        CP	0FEH
        JR	NZ,J$1D82
;
        LD	A,(HL)
        INC	HL
J$1D6E:	LD	(D.F666),HL
        LD	H,00H
J$1D73:	LD	L,A
        LD	(D.F66A),HL
        LD	A,02H	; 2 
        LD	(D.F669),A
        LD	HL,I.46E6
        POP	AF
        OR	A
        RET	
;
;	-----------------
J$1D82:	LD	A,(HL)
        INC	HL
        INC	HL
        LD	(D.F666),HL
        DEC	HL
        LD	H,(HL)
        JR	J$1D73
;
;	-----------------
?.1D8C:	CALL	C$1DB7
;
J$1D8F:	LD	HL,(D.F666)
        JR	J.1D3E
;
;	-----------------
J$1D94:	INC	A
        RLCA	
        LD	(D.F669),A
        PUSH	DE
        PUSH	BC
        LD	DE,D.F66A
        CALL	C.1DF0
;
        POP	BC
        POP	DE
        LD	(D.F666),HL
        POP	AF
        LD	HL,I.46E6
        OR	A
        RET	
;
;	-----------------
J$1DAC:	CP	09H	; 9 
        JP	NC,J.1D3A
;
J$1DB1:	CP	30H	; "0"
        CCF	
        INC	A
        DEC	A
        RET	
;
;	-----------------
;
;	  Subroutine __________________________
;	     Inputs  ________________________
;	     Outputs ________________________
;
C$1DB7:	LD	A,(D.F668)
        CP	0FH	; 15 
        JR	NC,J.1DD1
;
        CP	0DH	; 13 
        JR	C,J.1DD1
;
        LD	HL,(D.F66A)
        JR	NZ,J$1DCE
;
        INC	HL
        INC	HL
        INC	HL
        LD	E,(HL)
        INC	HL
        LD	D,(HL)
        EX	DE,HL
J$1DCE:	JP	C.05DE
;
;	-----------------
J.1DD1:	LD	A,(D.F669)
        LD	(D.F663),A
        CP	02H	; 2 
        JR	NZ,J$1DE1
;
        LD	HL,(D.F66A)
        LD	(D.F7F8),HL
J$1DE1:	LD	HL,D.F66A
        LD	DE,D.F7F6
        LD	A,(D.F663)
        CP	04H	; 4 
        JR	NC,C.1DF0
;
        INC	DE
        INC	DE
;
;	  Subroutine __________________________
;	     Inputs  ________________________
;	     Outputs ________________________
;
C.1DF0:	LD	C,A
        LD	B,00H
        LDIR	
        RET	
;
;	-----------------
J$1DF6:	JP	Z,J$1ED5
;
        CP	0EFH
        JP	Z,J$1ECA
;
        CP	0C7H
I$1E00:	JP	Z,J$2040
;
        LD	DE,(D.F3E9)
        PUSH	DE
        CP	2CH	; ","
        JR	Z,J$1E17
;
        RST	28H
;
        CALL	C.1E40
;
        POP	DE
        LD	E,A
        PUSH	DE
        DEC	HL
        RST	10H
;
        JR	Z,J.1E33
;
J$1E17:	RST	08H
;
        INC	L
        CP	2CH	; ","
        JR	Z,J$1E28
;
        RST	28H
;
        CALL	C.1E40
;
        POP	DE
        LD	D,A
        PUSH	DE
        DEC	HL
        RST	10H
;
        JR	Z,J.1E33
;
J$1E28:	RST	08H
;
        INC	L
        RST	28H
;
        CALL	C.1E40
;
        LD	(D.F3EB),A
        DEC	HL
        RST	10H
;
J.1E33:	EX	(SP),HL
        LD	(D.F3E9),HL
        LD	A,L
        LD	(D.F3F2),A
        CALL	C.0953
;
        POP	HL
        RET	
;
;	-----------------
;
;	  Subroutine __________________________
;	     Inputs  ________________________
;	     Outputs ________________________
;
C.1E40:	CALL	C.1E47
;
        RET	NC
;
        JP	J.0546
;
;	-----------------
;
;	  Subroutine __________________________
;	     Inputs  ________________________
;	     Outputs ________________________
;
C.1E47:	PUSH	AF
        LD	A,(D.FCAF)
        CP	06H	; 6 
        JR	Z,J$1E5B
;
        CP	08H	; 8 
        JR	Z,J$1E58
;
        POP	AF
        CP	10H	; 16 
        CCF	
        RET	
;
;	-----------------
J$1E58:	POP	AF
        AND	A
        RET	
;
;	-----------------
J$1E5B:	POP	AF
        CP	20H	; " "
        CCF	
        RET	C
;
        CP	10H	; 16 
        JR	C,J$1E67
;
        AND	0FH	; 15 
        RET	
;
;	-----------------
J$1E67:	AND	03H	; 3 
        PUSH	BC
        LD	B,A
        ADD	A,A
        ADD	A,A
        ADD	A,B
        POP	BC
        RET	
;
;	-----------------
J$1E70:	RST	10H
;
        LD	A,0FH	; 15 
        CALL	C.1EDC
;
        PUSH	AF
        CALL	C.0F6A
;
        PUSH	BC
        RST	08H
;
        INC	L
        CP	2CH	; ","
        JR	Z,J$1E98
;
        LD	A,07H	; 7 
        CALL	C.1EDC
;
        ADD	A,A
        ADD	A,A
        ADD	A,A
        ADD	A,A
        LD	E,A
        POP	BC
        LD	A,B
        AND	0FH	; 15 
        OR	E
        LD	B,A
        PUSH	BC
        DEC	HL
        RST	10H
;
        CP	29H	; ")"
        JR	Z,J.1EBA
;
J$1E98:	RST	08H
;
        INC	L
        CP	2CH	; ","
        JR	Z,J$1EAC
;
        LD	A,07H	; 7 
        CALL	C.1EDC
;
        POP	BC
        LD	C,A
        PUSH	BC
        DEC	HL
        RST	10H
;
        CP	29H	; ")"
        JR	Z,J.1EBA
;
J$1EAC:	RST	08H
;
        INC	L
        LD	A,07H	; 7 
        CALL	C.1EDC
;
        POP	BC
        LD	A,B
        AND	0F0H
        OR	E
        LD	B,A
        PUSH	BC
J.1EBA:	RST	08H
;
        ADD	HL,HL
        POP	BC
        LD	A,B
        LD	E,C
        POP	BC
        LD	D,B
        PUSH	AF
        CALL	C.1034
;
        POP	AF
        CALL	C.0FD3
;
        RET	
;
;	-----------------
J$1ECA:	RST	10H
;
        CP	28H	; "("
        JR	Z,J$1E70
;
        CP	8CH
        JR	Z,J$1ED8
;
        RST	08H
;
        SUB	H
J$1ED5:	JP	C.0F9F
;
;	-----------------
J$1ED8:	RST	10H
;
        JP	J.0F7E
;
;	-----------------
;
;	  Subroutine __________________________
;	     Inputs  ________________________
;	     Outputs ________________________
;
C.1EDC:	PUSH	AF
        RST	28H
;
        POP	AF
        CP	E
        LD	A,E
        RET	NC
;
        JP	J.0546
;
;	-----------------
J$1EE5:	CP	2CH	; ","
        JR	Z,J$1F1D
;
        RST	28H
;
        CP	09H	; 9 
        JP	NC,J$2CBC
;
        CP	05H	; 5 
        JR	C,J$1F0E
;
        PUSH	AF
        LD	A,(D.FAFC)
        RRCA	
        AND	03H	; 3 
        LD	C,A
        POP	AF
        CP	07H	; 7 
        PUSH	AF
        LD	A,C
        JR	NC,J$1F08
;
        CP	01H	; 1 
        JR	C,J$1F0A
;
        JR	J$1F0D
;
;	-----------------
J$1F08:	CP	02H	; 2 
J$1F0A:	JP	C,J.0546
;
J$1F0D:	POP	AF
J$1F0E:	PUSH	HL
        CALL	C.09BF
;
        LD	A,(D.F3B0)
        LD	E,A
        CALL	C.2033
;
        POP	HL
        DEC	HL
        RST	10H
;
        RET	Z
;
J$1F1D:	RST	08H
;
        INC	L
        CP	2CH	; ","
        JR	Z,J$1F3A
;
        RST	28H
;
        CP	04H	; 4 
        JP	NC,J.0546
;
        LD	A,(D.F3E0)
        AND	0FCH
        OR	E
        LD	(D.F3E0),A
        PUSH	HL
        CALL	C.06F5
;
        POP	HL
        DEC	HL
        RST	10H
;
        RET	Z
;
J$1F3A:	RST	08H
;
        INC	L
        CP	2CH	; ","
        JR	Z,J$1F45
;
        RST	28H
;
        LD	(D.F3DB),A
        RET	Z
;
J$1F45:	RST	08H
;
        INC	L
        CP	2CH	; ","
        JR	Z,J$1F51
;
        CALL	C.1F7A
;
        DEC	HL
        RST	10H
;
        RET	Z
;
J$1F51:	RST	08H
;
        INC	L
        CP	2CH	; ","
        JR	Z,J$1F5C
;
        RST	28H
;
        LD	(D.F417),A
        RET	Z
;
J$1F5C:	RST	08H
;
        INC	L
        RST	28H
;
        CP	04H	; 4 
        JP	NC,J.0546
;
        ADD	A,A
        BIT	1,A
        JR	Z,J$1F6B
;
        SET	3,A
J$1F6B:	AND	0CH	; 12 
        LD	B,A
        LD	A,(D.FFE8)
        AND	0F3H
        OR	B
        LD	C,09H	; 9 
J$1F76:	LD	B,A
        JP	C.0647
;
;	-----------------
;
;	  Subroutine __________________________
;	     Inputs  ________________________
;	     Outputs ________________________
;
C.1F7A:	RST	28H
;
        DEC	A
        CP	02H	; 2 
        JP	NC,J.0546
;
        PUSH	HL
        LD	BC,BDOS
        AND	A
        LD	HL,D.F3FC
        JR	Z,J$1F8C
;
        ADD	HL,BC
J$1F8C:	LD	DE,I.F406
        LDIR	
        POP	HL
        RET	
;
;	-----------------
;
;	  Subroutine __________________________
;	     Inputs  ________________________
;	     Outputs ________________________
;
C.1F93:	PUSH	BC
        LD	B,A
        CALL	C.062C
;
        JR	C,J$1FAE
;
        CP	07H	; 7 
        LD	A,01H	; 1 
        JR	NC,J.1FAD
;
        LD	A,(D.FAFC)
        AND	06H	; 6 
        CP	04H	; 4 
        LD	A,01H	; 1 
        JR	C,J.1FAD
;
        LD	A,03H	; 3 
J.1FAD:	CP	B
J$1FAE:	LD	A,B
        POP	BC
        RET	
;
;	-----------------
?.1FB1:	LD	DE,(D.FAF5)
        CP	2CH	; ","
        JR	Z,J$1FC7
;
        PUSH	DE
        RST	28H
;
        POP	DE
        CALL	C.1F93
;
J$1FBF:	JP	C,J.0546
;
        LD	E,A
        DEC	HL
        RST	10H
;
        JR	Z,J$1FD2
;
J$1FC7:	PUSH	DE
        RST	08H
;
        INC	L
        RST	28H
;
        POP	DE
        CALL	C.1F93
;
        JR	C,J$1FBF
;
        LD	D,A
J$1FD2:	LD	(D.FAF5),DE
        PUSH	HL
        CALL	C.2980
;
        CALL	C.06A8
;
        POP	HL
        RET	
;
;	-----------------
J$1FDF:	JP	Z,J.0546
;
        LD	A,(D.FCB0)
        AND	A
        LD	A,E
        JR	Z,J$1FEE
;
        CP	21H	; "!"
        JP	NC,J.0546
;
J$1FEE:	CP	29H	; ")"
        JR	C,J$1FF7
;
        CP	51H	; "Q"
        JP	NC,J.0546
;
J$1FF7:	LD	A,(D.F3B0)
        CP	E
        RET	Z
;
J$1FFC:	CALL	C$2D48
;
        LD	A,E
I$2000:	LD	(D.F3B0),A
        CALL	C.2033
;
        LD	A,(D.FCB0)
        DEC	A
        LD	A,E
        JR	NZ,J$2014
;
        LD	(D.F3AF),A
        LD	A,0CH	; 12 
        RST	18H
;
        RET	
;
;	-----------------
J$2014:	LD	C,29H	; ")"
        LD	A,(D.F3AE)
        CP	C
        LD	A,E
        LD	(D.F3AE),A
        PUSH	AF
        LD	A,0CH	; 12 
        RST	18H
;
        POP	AF
        JR	C,J$2028
;
        CP	C
        RET	NC
;
I$2027:	LD	C,A
J$2028:	CP	C
        RET	C
;
        PUSH	AF
        PUSH	HL
        XOR	A
        CALL	C$2CA9
;
        POP	HL
        POP	AF
        LD	E,A
;
;	  Subroutine __________________________
;	     Inputs  ________________________
;	     Outputs ________________________
;
C.2033:	SUB	0EH	; 14 
        JR	NC,C.2033
;
        ADD	A,1CH
        CPL	
        INC	A
        ADD	A,E
        LD	(D$F3B2),A
        RET	
;
;	-----------------
J$2040:	CALL	C.0626
;
        JP	C,J.0546
;
        RST	10H
;
        CP	24H	; "$"
        JR	Z,J$2065
;
        LD	A,1FH
        CALL	C.2318
;
        PUSH	HL
        CALL	C.0775
;
        EX	(SP),HL
        RST	08H
;
        RST	28H
;
        RST	28H
;
        AND	A
        JP	M,J.0546
;
        LD	BC,C.0010
        EX	(SP),HL
        CALL	C.0977
;
        POP	HL
        RET	
;
;	-----------------
J$2065:	RST	08H
;
        INC	H
        LD	A,1FH
        CALL	C.2318
;
        PUSH	HL
        CALL	C.0775
;
        EX	(SP),HL
        RST	08H
;
        RST	28H
;
        CALL	C.05FC
;
        PUSH	HL
        CALL	C.0614
;
        LD	A,(HL)
        CP	11H	; 17 
        JR	C,J$2081
;
        LD	A,10H	; 16 
J$2081:	INC	HL
        LD	E,(HL)
        INC	HL
        LD	D,(HL)
        POP	HL
        EX	(SP),HL
        AND	A
        LD	B,A
        EX	DE,HL
        CALL	NZ,C.0F2B
;
        POP	HL
        RET	
;
;	-----------------
J$208F:	RST	10H
;
        RST	28H
;
        CP	20H	; " "
        JP	NC,J.0546
;
        LD	(D.F560),A
        PUSH	HL
        PUSH	AF
        CALL	C.0775
;
        LD	(D.FC18),HL
        LD	DE,I.FC1A
        LD	B,10H	; 16 
        CALL	C.0F22
;
        POP	AF
        PUSH	AF
        CALL	C.076A
;
        LD	(D.F55E),HL
        POP	AF
        LD	B,A
        LD	A,20H	; " "
        SUB	B
        LD	B,A
        LD	(D.F561),A
        LD	DE,D.F562
        PUSH	DE
        CALL	C.0F22
;
        POP	HL
        EX	(SP),HL
        RST	08H
;
        INC	L
        CP	2CH	; ","
        JR	Z,J$20F5
;
        CALL	C.059C
;
        EX	(SP),HL
        LD	(HL),E
        INC	HL
        LD	A,B
        ADD	A,A
        LD	A,C
        LD	C,00H
        JR	NC,J$20DA
;
        ADD	A,20H	; " "
        LD	C,80H
J$20DA:	LD	(HL),A
        PUSH	HL
        LD	HL,I.FC1A
I$20DF:	LD	B,10H	; 16 
J$20E1:	LD	A,(HL)
        AND	7FH
        OR	C
        LD	(HL),A
        INC	HL
        DJNZ	J$20E1
;
        CALL	C.217A
;
        POP	HL
        INC	HL
        EX	(SP),HL
        DEC	HL
        RST	10H
;
        POP	BC
        JR	Z,J.212E
;
        PUSH	BC
J$20F5:	RST	08H
;
        INC	L
        CP	2CH	; ","
        JR	Z,J$2119
;
        RST	28H
;
        AND	A
        JP	M,J.0546
;
        PUSH	HL
        LD	HL,I.FC1A
        LD	C,A
        LD	B,10H	; 16 
J$2107:	LD	A,(HL)
        AND	80H
        OR	C
        LD	(HL),A
        INC	HL
        DJNZ	J$2107
;
        CALL	C.217A
;
        POP	HL
        DEC	HL
        RST	10H
;
        POP	BC
        JR	Z,J.212E
;
        PUSH	BC
J$2119:	RST	08H
;
        INC	L
        RST	28H
;
        CALL	C.077F
;
        LD	A,E
        JR	NC,J$2129
;
        CP	40H	; "@"
        JP	NC,J.0546
;
        ADD	A,A
        ADD	A,A
J$2129:	EX	(SP),HL
        LD	(HL),A
        LD	B,H
        LD	C,L
        POP	HL
J.212E:	PUSH	HL
        LD	A,(D.F560)
        SUB	1FH
        JR	Z,J.216A
;
        LD	HL,(D.FC18)
        LD	A,(D.F561)
        LD	B,A
J$213D:	LD	DE,C.0010
        ADD	HL,DE
        PUSH	HL
        PUSH	BC
        LD	DE,I.FC1A
        LD	B,10H	; 16 
        CALL	C.0F22
;
        CALL	C$2187
;
        POP	BC
        POP	HL
        JR	Z,J$2154
;
        DJNZ	J$213D
;
J$2154:	LD	A,(D.F561)
        SUB	B
        JR	Z,J.216A
;
        LD	B,A
        LD	HL,D.F566
        LD	DE,(D.F562)
J$2162:	LD	(HL),E
        INC	HL
        LD	(HL),D
        INC	HL
        INC	HL
        INC	HL
        DJNZ	J$2162
;
J.216A:	INC	A
        ADD	A,A
        ADD	A,A
        LD	B,A
        LD	HL,D.F562
        LD	DE,(D.F55E)
        CALL	C.0F2B
;
        POP	HL
        RET	
;
;	-----------------
;
;	  Subroutine __________________________
;	     Inputs  ________________________
;	     Outputs ________________________
;
C.217A:	LD	HL,I.FC1A
        LD	DE,(D.FC18)
        LD	B,10H	; 16 
        CALL	C.0F2B
;
        RET	
;
;	-----------------
;
;	  Subroutine __________________________
;	     Inputs  ________________________
;	     Outputs ________________________
;
C$2187:	LD	HL,I.FC1A
        LD	B,10H	; 16 
J$218C:	LD	A,(HL)
        AND	40H	; "@"
        RET	NZ
;
        INC	HL
        DJNZ	J$218C
;
        XOR	A
        RET	
;
;	-----------------
?.2195:	DEC	B
        JP	M,J.0540
;
        LD	A,(D.FCAF)
        CP	05H	; 5 
        JP	C,J.0546
;
        RST	10H
;
        CP	2CH	; ","
        CALL	NZ,C.059C
;
        RST	08H
;
        INC	L
        CALL	C.0608
;
        PUSH	DE
        CALL	C.256F
;
        CALL	C.2594
;
        DEC	HL
        RST	10H
;
        CP	2CH	; ","
J$21B6	EQU	$-1
        LD	A,00H
        JR	NZ,J$21C2
;
        RST	10H
;
        RST	28H
;
        CP	03H	; 3 
        JP	NC,J.0546
;
J$21C2:	POP	BC
        JP	J.1049
;
;	-----------------
J$21C6:	LD	A,2FH	; "/"
        CALL	C.2318
;
        CP	08H	; 8 
        JR	C,J.21DD
;
        JP	Z,J.0546
;
        DEC	E
        DEC	A
        CP	18H
        JR	C,J.21DD
;
        CP	20H	; " "
        JP	C,J.0546
;
J.21DD:	PUSH	DE
        RST	08H
;
        RST	28H
;
        RST	28H
;
        POP	BC
        JP	J$1F76
;
;	-----------------
J$21E5:	RST	10H
;
        RST	08H
;
        JR	Z,J$21B6
;
        EX	AF,AF'
        LD	B,0CFH
        ADD	HL,HL
        PUSH	HL
        LD	A,D
        RLCA	
        JR	C,J$220E
;
        AND	A
        JR	NZ,J$21F8
;
        LD	A,E
        CP	19H
J$21F8:	JP	NC,J.0546
;
        CP	09H	; 9 
        JR	NC,J$2204
;
I$21FF:	LD	HL,D.F3DF
        JR	J$2207
;
;	-----------------
J$2204:	LD	HL,I$FFDE
J$2207:	ADD	HL,DE
        LD	A,(HL)
J$2209:	CALL	C.05E4
J$220B	EQU	$-1
;
        POP	HL
        RET	
;
;	-----------------
J$220E:	EX	DE,HL
        CALL	C.25DC
;
        EX	DE,HL
        LD	HL,I.0009
        RST	20H
;
        JP	C,J.0546
;
        LD	A,E
        CALL	C.298B
;
        JR	J$2209
;
;	-----------------
J$2220:	LD	A,13H	; 19 
        CALL	C.2318
;
        LD	D,00H
        PUSH	DE
        RST	08H
;
        RST	28H
;
        CALL	C.0608
;
        CP	40H	; "@"
        JP	NC,J.0546
;
        EX	(SP),HL
        PUSH	HL
        LD	C,E
        LD	B,D
        POP	HL
        LD	A,L
        PUSH	AF
        ADD	HL,HL
        EX	DE,HL
        LD	HL,I$226F
        ADD	HL,DE
        LD	A,C
        AND	(HL)
        JR	NZ,J$2246
;
        INC	HL
        LD	A,B
        AND	(HL)
J$2246:	JP	NZ,J.0546
;
        LD	HL,D.F3B3
        ADD	HL,DE
        LD	(HL),C
        INC	HL
        LD	(HL),B
        POP	AF
        LD	E,0FFH
J$2253:	INC	E
        SUB	05H	; 5 
        JR	NC,J$2253
;
        LD	A,(D.FCAF)
        CP	E
        CALL	Z,C$2261
;
        POP	HL
        RET	
;
;	-----------------
;
;	  Subroutine __________________________
;	     Inputs  ________________________
;	     Outputs ________________________
;
C$2261:	DEC	A
        JP	M,C.0B42
;
        JP	Z,C.0B9C
;
        DEC	A
        JP	Z,C.0BD2
;
        JP	C.0C22
;
;	-----------------
I$226F:	RST	38H
        INC	BC
        CCF	
        NOP	
        RST	38H
        RLCA	
        LD	A,A
        NOP	
        RST	38H
        RLCA	
        RST	38H
        INC	BC
        CCF	
        NOP	
        RST	38H
        RLCA	
        LD	A,A
        NOP	
        RST	38H
        RLCA	
        RST	38H
        INC	BC
        RST	38H
        RRA	
        RST	38H
        RRA	
        LD	A,A
        NOP	
        RST	38H
        RLCA	
        RST	38H
        INC	BC
        CCF	
        NOP	
        RST	38H
        RLCA	
        LD	A,A
        NOP	
        RST	38H
        RLCA	
J$2297:	RST	10H
;
        LD	A,2CH	; ","
        CALL	C.2318
;
        CP	14H	; 20 
        JR	NC,J$22C2
;
        PUSH	HL
J$22A2:	CP	02H	; 2 
        JR	NZ,J.22B2
;
        LD	A,(D.F3B0)
        CP	29H	; ")"
        JR	C,J.22B2
;
        LD	HL,I.1000
        JR	J.22BD
;
;	-----------------
J.22B2:	LD	HL,D.F3B3
        LD	D,00H
        ADD	HL,DE
        ADD	HL,DE
        LD	A,(HL)
        INC	HL
        LD	H,(HL)
        LD	L,A
J.22BD:	CALL	C.05DE
;
        POP	HL
        RET	
;
;	-----------------
J$22C2:	PUSH	HL
        SUB	19H
        JR	NC,J$22D3
;
        ADD	A,0FH	; 15 
        LD	E,A
        CP	0DH	; 13 
        JR	NZ,J$22A2
;
        LD	HL,(D$22DE)
        JR	J.22BD
;
;	-----------------
J$22D3:	LD	D,00H
        LD	E,A
        LD	HL,I$22E0
        ADD	HL,DE
        LD	H,(HL)
        LD	L,D
        JR	J.22BD
;
;	-----------------
D$22DE:	NOP	
        LD	E,00H
I$22E0	EQU	$-1
        DEFB	0,0
        HALT	
;
;	-----------------
?.22E4:	LD	A,B
        DEFB	0,0,0
        HALT	
;
;	-----------------
?.22E9:	LD	A,B
        DEFB	0,0,0
        JP	M,J$00F0
;
        DEFB	0,0
        JP	M,J$CDF0
J$22F4	EQU	$-1
;
        LD	(BC),A
        LD	B,0D5H
        RST	08H
;
        INC	L
        RST	28H
;
        EX	(SP),HL
        CALL	C.08CB
;
        LD	HL,C.0000
        CALL	C.08D6
;
        POP	HL
        RET	
;
;	-----------------
J$2307:	CALL	C$05B4
;
        CALL	C.08D6
J$230B	EQU	$-2
;
        PUSH	AF
        LD	HL,C.0000
        CALL	C.08D6
;
        POP	AF
        JP	C.05E4
;
;	-----------------
;
;	  Subroutine __________________________
;	     Inputs  ________________________
;	     Outputs ________________________
;
C.2318:	PUSH	AF
        RST	08H
;
        JR	Z,J$230B
;
        POP	AF
        CP	E
        JP	C,J.0546
;
        RST	08H
;
        ADD	HL,HL
        LD	A,E
        RET	
;
;	-----------------
;
;	  Subroutine __________________________
;	     Inputs  ________________________
;	     Outputs ________________________
;
C$2325:	LD	A,(D.F663)
        CP	08H	; 8 
        JR	NC,J$2331
;
        SUB	03H	; 3 
        OR	A
        SCF	
        RET	
;
;	-----------------
J$2331:	SUB	03H	; 3 
        OR	A
        RET	
;
;	-----------------
?.2335:	CALL	C$2325
;
        LD	HL,(D.F7F8)
        RET	M
;
        JP	Z,J$0552
;
        JP	J$05F0
;
;	-----------------
J$2342:	CP	0C5H
        JP	Z,J$3676
;
        LD	(D.F55E),HL
        CP	28H	; "("
        JR	Z,J$23C3
;
        CALL	C.24F6
;
        LD	(D.F562),DE
        LD	(D.F564),BC
        JR	NC,J$238C
;
        DEC	HL
        RST	10H
;
        JP	Z,J.254D
;
        CP	0D9H
        JR	NZ,J$236F
;
        RST	10H
;
        CP	28H	; "("
        JR	NZ,J$2378
;
        XOR	A
        LD	(D.F56F),A
        JR	J$2372
;
;	-----------------
J$236F:	CALL	C.252B
;
J$2372:	PUSH	HL
        LD	HL,J.30A8
        JR	J$23A4
;
;	-----------------
J$2378:	CALL	C.24F6
;
        JP	C,J.254D
;
        LD	(D.F566),DE
        LD	(D.F568),BC
        PUSH	HL
        LD	HL,J.306F
        JR	J$23BD
;
;	-----------------
J$238C:	DEC	HL
        RST	10H
;
        CP	0D9H
        JR	NZ,J$239D
;
        RST	10H
;
        CP	28H	; "("
        JR	NZ,J$23AB
;
        XOR	A
        LD	(D.F56F),A
        JR	J$23A0
;
;	-----------------
J$239D:	CALL	C.252B
;
J$23A0:	PUSH	HL
        LD	HL,J.2F42
J$23A4:	LD	(D.F560),HL
        POP	HL
        JP	J.24A9
;
;	-----------------
J$23AB:	CALL	C.24F6
;
        JP	NC,J.0540
;
        LD	(D.F566),DE
        LD	(D.F568),BC
        PUSH	HL
        LD	HL,J.307C
J$23BD:	LD	(D.F560),HL
        JP	J$24E4
;
;	-----------------
J$23C3:	PUSH	HL
        LD	HL,J.2EB9
        LD	(D.F560),HL
        POP	HL
        CALL	C.059C
;
        PUSH	BC
        PUSH	DE
        RST	08H
;
        JP	P,J.A2CD
;
        DEC	B
        DEC	HL
        RST	10H
;
        CP	0D9H
        LD	A,(D.FAF6)
        JR	Z,J$23E1
;
        RST	08H
;
        INC	L
        RST	28H
;
J$23E1:	CALL	C.1F93
;
        JP	C,J.0546
;
        LD	(D$F565),A
        POP	DE
        POP	BC
        RST	08H
;
        EXX	
        PUSH	HL
        CALL	C.12C4
;
        LD	(D.F562),BC
        LD	A,E
        LD	(D.F564),A
        CALL	C.25F1
;
        CALL	C.12C4
;
        CALL	C.25F1
;
        EX	AF,AF'
        XOR	A
        EX	AF,AF'
        CALL	C.25D5
;
        JR	NC,J$240F
;
        EX	AF,AF'
        OR	04H	; 4 
        EX	AF,AF'
J$240F:	INC	HL
        LD	(D.F56A),HL
        CALL	C.25E6
;
        JR	NC,J$241C
;
        EX	AF,AF'
        OR	08H	; 8 
        EX	AF,AF'
J$241C:	INC	HL
        LD	(D.F56C),HL
        EX	AF,AF'
        LD	(D.F56F),A
        EX	AF,AF'
        PUSH	BC
        PUSH	DE
        LD	BC,(D.F56A)
        LD	E,L
        LD	D,H
        CALL	C.3376
;
        JP	C,J.0546
;
        POP	DE
        POP	BC
        POP	HL
        DEC	HL
        RST	10H
;
        CP	28H	; "("
        JR	Z,J.24A9
;
        CALL	C.24F6
;
        LD	(D.F566),DE
        LD	(D.F568),BC
        JR	NC,J$2450
;
        PUSH	HL
        LD	HL,J.31B4
        JP	J$24A4
;
;	-----------------
J$2450:	PUSH	HL
        PUSH	BC
        PUSH	DE
        LD	BC,(D.F56A)
        LD	DE,(D.F56C)
        CALL	C.3052
;
        LD	A,00H
        ADD	A,A
        LD	E,A
        CALL	C$253B
;
        DEC	B
        JR	Z,J.248D
;
        DEC	B
        JR	Z,J$2480
;
        LD	BC,D.0003
        ADD	HL,BC
        LD	A,E
        ADC	A,00H
        SRL	A
        RR	H
        RR	L
        SRL	A
        RR	H
        RR	L
        JR	J.248D
;
;	-----------------
J$2480:	LD	BC,D.0001
        ADD	HL,BC
        LD	A,E
        ADC	A,00H
        SRL	A
        RR	H
        RR	L
J.248D:	POP	DE
        ADD	HL,DE
        JR	C,J.249E
;
        NOP	
        LD	DE,I.0004
        ADD	HL,DE
        JR	C,J.249E
;
        NOP	
        POP	DE
        EX	DE,HL
        AND	A
        SBC	HL,DE
J.249E:	JP	C,J.0546
;
        LD	HL,J.2EDF
J$24A4:	LD	(D.F560),HL
        JR	J$24DE
;
;	-----------------
J.24A9:	CALL	C.05A2
;
        PUSH	HL
        CALL	C.12C4
;
        LD	(D.F566),BC
        LD	A,E
        LD	(D.F568),A
        POP	HL
        XOR	A
        LD	(D.F569),A
        DEC	HL
        RST	10H
;
        LD	A,(D.FAF6)
        JR	Z,J$24CE
;
        RST	08H
;
        INC	L
        CP	2CH	; ","
        LD	A,(D.FAF6)
        CALL	NZ,C.060E
;
J$24CE:	CALL	C.1F93
;
        JP	C,J.0546
;
        LD	(D.F569),A
        CALL	C.2594
;
        LD	(D$F570),A
        PUSH	HL
J$24DE:	CALL	C.062C
;
        JP	C,J.0546
;
J$24E4:	LD	HL,I$24F0
        PUSH	HL
        LD	HL,(D.F560)
        PUSH	HL
        LD	HL,D.F562
        RET	
;
;	-----------------
I$24F0:	POP	HL
        JP	C,J.0546
;
        AND	A
        RET	
;
;	-----------------
;
;	  Subroutine __________________________
;	     Inputs  ________________________
;	     Outputs ________________________
;
C.24F6:	PUSH	HL
        CALL	C.05FC
;
        LD	A,(D.F663)
        CP	03H	; 3 
        JR	Z,J$2523
;
        POP	HL
        LD	A,01H	; 1 
        LD	(D.F6A5),A
        CALL	C.05D8
;
        JP	NZ,J.0546
;
        LD	(D.F6A5),A
        PUSH	HL
        LD	H,B
        LD	L,C
        EX	DE,HL
        ADD	HL,DE
        DEC	HL
        PUSH	HL
        LD	A,(BC)
        ADD	A,A
        LD	L,A
        LD	H,00H
        INC	BC
        ADD	HL,BC
        EX	DE,HL
        POP	BC
        POP	HL
        AND	A
        RET	
;
;	-----------------
J$2523:	PUSH	HL
        CALL	C.0614
;
        POP	HL
        POP	DE
        SCF	
        RET	
;
;	-----------------
;
;	  Subroutine __________________________
;	     Inputs  ________________________
;	     Outputs ________________________
;
C.252B:	RST	08H
;
        INC	L
        RST	28H
;
        CP	04H	; 4 
        JP	NC,J.0546
;
        ADD	A,A
        ADD	A,A
        LD	(D.F56F),A
        RST	08H
;
        EXX	
        RET	
;
;	-----------------
;
;	  Subroutine __________________________
;	     Inputs  ________________________
;	     Outputs ________________________
;
C$253B:	LD	B,01H	; 1 
        LD	A,(D.FCAF)
        CP	08H	; 8 
        RET	Z
;
        INC	B
        CP	05H	; 5 
        RET	Z
;
        CP	07H	; 7 
        RET	Z
;
        INC	B
        INC	B
        RET	
;
;	-----------------
J.254D:	XOR	A
        LD	(D.F6A5),A
        LD	HL,(D.F55E)
        SCF	
        RET	
;
;	-----------------
J$2556:	PUSH	AF
        CALL	C.05A2
;
        POP	AF
        CALL	C$2572
;
        CALL	C.2594
;
        PUSH	HL
        CALL	C.12C4
;
        JR	NC,J$256D
;
        CALL	C.1342
;
        CALL	C.13B5
;
J$256D:	POP	HL
        RET	
;
;	-----------------
;
;	  Subroutine __________________________
;	     Inputs  ________________________
;	     Outputs ________________________
;
C.256F:	LD	A,(D.F3E9)
;
;	  Subroutine __________________________
;	     Inputs  ________________________
;	     Outputs ________________________
;
C$2572:	PUSH	BC
        PUSH	DE
        LD	E,A
        CALL	C.0620
;
        JP	C,J.0546
;
        DEC	HL
        RST	10H
;
        JR	Z,J.2586
;
        RST	08H
;
        INC	L
        CP	2CH	; ","
        JR	Z,J.2586
;
        RST	28H
;
J.2586:	LD	A,E
        PUSH	HL
        CALL	C.13AD
;
        JP	C,J.0546
;
        POP	HL
        POP	DE
        POP	BC
        JP	J.1D3E
;
;	-----------------
;
;	  Subroutine __________________________
;	     Inputs  ________________________
;	     Outputs ________________________
;
C.2594:	LD	A,00H
        PUSH	DE
        LD	D,00H
        LD	E,A
        DEC	HL
        RST	10H
;
        JR	Z,J.25CC
;
        RST	08H
;
        INC	L
        JP	Z,J$054C
;
        CP	2CH	; ","
        JR	Z,J.25CC
;
        LD	E,A
        CP	54H	; "T"
        JR	Z,J$25C4
;
        CP	0D9H
        JR	Z,J$25BC
;
        INC	A
        JR	NZ,J$25CB
;
        RST	10H
;
        RST	08H
;
        ADC	A,L
        RST	08H
;
        LD	B,H
        LD	E,0F6H
        JR	J$25C1
;
;	-----------------
J$25BC:	RST	10H
;
        RST	08H
;
        LD	D,D
        LD	E,0F7H
J$25C1:	DEC	HL
        JR	J$25C9
;
;	-----------------
J$25C4:	RST	10H
;
        JP	Z,J.0540
;
        LD	E,A
J$25C9:	LD	D,08H	; 8 
J$25CB:	RST	10H
;
J.25CC:	LD	A,E
        CALL	C$27B6
;
        JP	C,J.0540
;
        POP	DE
        RET	
;
;	-----------------
;
;	  Subroutine __________________________
;	     Inputs  ________________________
;	     Outputs ________________________
;
C.25D5:	LD	HL,(D.FCB3)
        AND	A
        SBC	HL,BC
J$25DB:	RET	NC
;
;
;	  Subroutine __________________________
;	     Inputs  ________________________
;	     Outputs ________________________
;
C.25DC:	XOR	A
        SUB	L
        LD	L,A
        SBC	A,H
        SUB	L
        LD	H,A
        XOR	A
        SUB	01H	; 1 
        RET	
;
;	-----------------
;
;	  Subroutine __________________________
;	     Inputs  ________________________
;	     Outputs ________________________
;
C.25E6:	LD	HL,(D.FCB5)
        AND	A
        SBC	HL,DE
        JR	J$25DB
;
;	-----------------
;
;	  Subroutine __________________________
;	     Inputs  ________________________
;	     Outputs ________________________
;
C.25EE:	CALL	C.12C4
;
;
;	  Subroutine __________________________
;	     Inputs  ________________________
;	     Outputs ________________________
;
C.25F1:	CALL	C.2600
;
;
;	  Subroutine __________________________
;	     Inputs  ________________________
;	     Outputs ________________________
;
C$25F4:	PUSH	HL
        PUSH	BC
        LD	HL,(D.FCB3)
        EX	(SP),HL
        LD	(D.FCB3),HL
        POP	BC
        POP	HL
        RET	
;
;	-----------------
;
;	  Subroutine __________________________
;	     Inputs  ________________________
;	     Outputs ________________________
;
C.2600:	PUSH	HL
        LD	HL,(D.FCB5)
        EX	DE,HL
        JR	J$263A
;
;	-----------------
J$2607:	CALL	C.059C
;
        PUSH	BC
        PUSH	DE
        RST	08H
;
        JP	P,J.A2CD
;
        DEC	B
        CALL	C.256F
;
        POP	DE
        POP	BC
        DEC	HL
        RST	10H
;
        JR	Z,J.263F
;
        RST	08H
;
        INC	L
        CP	2CH	; ","
        JR	Z,J.263F
;
        RST	08H
;
        LD	B,D
        JR	Z,J.2648
;
        CP	2CH	; ","
        JR	Z,J.2648
;
        RST	08H
;
        LD	B,(HL)
J$262A:	CALL	C.2594
;
        PUSH	HL
        CALL	C.2898
;
J.2631:	LD	HL,(D.FCB7)
        LD	(D.FCB3),HL
        LD	HL,(D.FCB9)
J$263A:	LD	(D.FCB5),HL
        POP	HL
        RET	
;
;	-----------------
J.263F:	CALL	C.2594
;
        PUSH	HL
        CALL	C.2823
;
        JR	J.2631
;
;	-----------------
J.2648:	CALL	C.2594
;
        PUSH	HL
        CALL	C.27E7
;
        JR	J.2631
;
;	-----------------
J$2651:	CALL	C.059C
;
        PUSH	BC
        PUSH	DE
        CALL	C.256F
;
        LD	A,(D.F3F2)
        LD	E,A
        DEC	HL
        RST	10H
;
        JR	Z,J$2664
;
        RST	08H
;
        INC	L
        RST	28H
;
J$2664:	LD	A,E
        AND	A
        CALL	C$14C7
;
        JP	C,J.0546
;
        POP	DE
        POP	BC
        PUSH	HL
        CALL	C$27AD
;
        CALL	C.1342
;
        LD	DE,D.0001
        CALL	C.277E
;
        JR	Z,J.2691
;
        PUSH	HL
        CALL	C.278F
;
        POP	DE
        ADD	HL,DE
        EX	DE,HL
        XOR	A
        CALL	C.275B
;
        LD	A,40H	; "@"
        CALL	C.275B
;
        LD	B,0C0H
        JR	J$26B3
;
;	-----------------
J.2691:	POP	HL
        RET	
;
;	-----------------
J$2693:	LD	A,(D$FC9B)
        OR	A
        CALL	NZ,C$0589
;
I$269A:	LD	A,(D.F94A)
        OR	A
        JR	Z,J.26AC
;
        LD	HL,(D.F94B)
        PUSH	HL
        LD	HL,(D.F949)
        PUSH	HL
        LD	HL,(D.F94D)
        PUSH	HL
J.26AC:	POP	DE
        POP	BC
        POP	HL
        LD	A,C
        CALL	C.137D
;
J$26B3:	LD	A,B
        LD	(D.F953),A
        ADD	A,A
        JR	Z,J.2691
;
        PUSH	DE
        JR	NC,J$26C2
;
        CALL	C.1414
;
        JR	J$26C5
;
;	-----------------
J$26C2:	CALL	C.13FC
;
J$26C5:	POP	DE
        JR	C,J.26AC
;
        CALL	C.277E
;
        JP	Z,J.26AC
;
        XOR	A
        LD	(D.F94A),A
        CALL	C.278F
;
        LD	E,L
        LD	D,H
        OR	A
        JR	Z,J.26F4
;
        DEC	HL
        DEC	HL
        LD	A,H
        ADD	A,A
        JR	C,J.26F4
;
        LD	(D.F94D),DE
        CALL	C.1376
;
        LD	(D.F94B),HL
        LD	(D.F949),A
        LD	A,(D.F953)
        CPL	
        LD	(D.F94A),A
J.26F4:	LD	HL,(D.F951)
        ADD	HL,DE
        EX	DE,HL
        CALL	C$274F
;
        LD	HL,(D.F942)
        LD	A,(D.F944)
        CALL	C.137D
;
J.2705:	LD	HL,(D.F94F)
        LD	DE,(D.F951)
        OR	A
        SBC	HL,DE
        JR	Z,J.274C
;
        JR	C,J$272F
;
        EX	DE,HL
        LD	B,01H	; 1 
        CALL	C.277E
;
        JR	Z,J.274C
;
        OR	A
        JR	Z,J.2705
;
        EX	DE,HL
        LD	HL,(D.F942)
        LD	A,(D.F944)
        LD	C,A
        LD	A,(D.F953)
D$2727	EQU	$-2
        LD	B,A
        CALL	C$2760
;
        JR	J.2705
;
;	-----------------
J$272F:	CALL	C.25DC
;
        DEC	HL
        DEC	HL
        LD	A,H
        ADD	A,A
        JR	C,J.274C
;
        INC	HL
        PUSH	HL
        EX	DE,HL
        LD	HL,(D.F92A)
        OR	A
        SBC	HL,DE
        LD	(D.F92A),HL
        POP	DE
        LD	A,(D.F953)
        CPL	
        CALL	C.275B
;
J.274C:	JP	J$2693
;
;	-----------------
;
;	  Subroutine __________________________
;	     Inputs  ________________________
;	     Outputs ________________________
;
C$274F:	LD	A,(D.F954)
        LD	C,A
        LD	A,(D.F955)
        OR	C
        RET	Z
;
        LD	A,(D.F953)
;
;	  Subroutine __________________________
;	     Inputs  ________________________
;	     Outputs ________________________
;
C.275B:	LD	B,A
        CALL	C.1376
;
        LD	C,A
;
;	  Subroutine __________________________
;	     Inputs  ________________________
;	     Outputs ________________________
;
C$2760:	EX	(SP),HL
        PUSH	BC
        PUSH	DE
        PUSH	HL
        LD	C,02H	; 2 
        PUSH	HL
        LD	HL,(D.F6C6)
        LD	B,00H
        ADD	HL,BC
        ADD	HL,BC
        LD	A,88H
        SUB	L
        LD	L,A
        LD	A,0FFH
        SBC	A,H
        LD	H,A
        JR	C,J$277B
;
        ADD	HL,SP
        POP	HL
        RET	C
;
J$277B:	JP	J$0558
;
;	-----------------
;
;	  Subroutine __________________________
;	     Inputs  ________________________
;	     Outputs ________________________
;
C.277E:	CALL	C.14DB
;
        LD	(D.F94F),DE
        LD	(D.F951),HL
        LD	A,H
        OR	L
        LD	A,C
        LD	(D.F955),A
        RET	
;
;	-----------------
;
;	  Subroutine __________________________
;	     Inputs  ________________________
;	     Outputs ________________________
;
C.278F:	CALL	C.1376
;
        PUSH	HL
        PUSH	AF
        LD	HL,(D.F942)
        LD	A,(D.F944)
        CALL	C.137D
;
        POP	AF
        POP	HL
        LD	(D.F942),HL
        LD	(D.F944),A
        CALL	C.158F
;
        LD	A,C
        LD	(D.F954),A
        RET	
;
;	-----------------
;
;	  Subroutine __________________________
;	     Inputs  ________________________
;	     Outputs ________________________
;
C$27AD:	PUSH	HL
        CALL	C.12C4
;
        JP	NC,J.0546
;
        POP	HL
        RET	
;
;	-----------------
;
;	  Subroutine __________________________
;	     Inputs  ________________________
;	     Outputs ________________________
;
C$27B6:	AND	A
        JR	Z,J$27E2
;
        PUSH	BC
        LD	B,A
        CALL	C.062C
;
        LD	A,B
        POP	BC
        RET	C
;
        CP	0F8H
        JR	Z,J$27E0
;
        CP	0F7H
        JR	Z,J$27DD
;
        CP	0F6H
        JR	Z,J$27DA
;
        CP	0C3H
        JR	Z,J$27D7
;
        CP	0C2H
        SCF	
        RET	NZ
;
        XOR	A
        JP	NZ,J$043E
J$27D7	EQU	$-2
;
        JP	NZ,J$013E
J$27DA	EQU	$-2
;
        JP	NZ,J$023E
J$27DD	EQU	$-2
;
        JP	NZ,J$033E
J$27E0	EQU	$-2
;
J$27E2:	OR	D
        LD	(D.FB02),A
        RET	
;
;	-----------------
;
;	  Subroutine __________________________
;	     Inputs  ________________________
;	     Outputs ________________________
;
C.27E7:	CALL	C.25EE
;
        CALL	C.25EE
;
        CALL	C.25D5
;
        JR	Z,C.2823
;
        CALL	C,C$25F4
;
        CALL	C.25E6
;
        JR	Z,C.2823
;
        CALL	C,C.2600
;
        LD	HL,(D.FCB5)
I$27FE	EQU	$-2
        PUSH	HL
        PUSH	DE
        EX	DE,HL
        CALL	C.2823
;
        POP	HL
        LD	(D.FCB5),HL
        EX	DE,HL
        CALL	C.2823
;
        POP	HL
        DEC	HL
        INC	DE
        LD	(D.FCB5),HL
        LD	HL,(D.FCB3)
        PUSH	BC
        LD	C,L
        LD	B,H
        CALL	C.2823
;
        POP	HL
        LD	(D.FCB3),HL
        LD	C,L
        LD	B,H
;
;	  Subroutine __________________________
;	     Inputs  ________________________
;	     Outputs ________________________
;
C.2823:	PUSH	BC
        PUSH	DE
        PUSH	HL
        LD	HL,(D.FCB5)
        PUSH	HL
        LD	HL,(D.FCB3)
        PUSH	HL
        CALL	C.25EE
;
        CALL	C.12C4
;
        CALL	C.25E6
;
        CALL	C,C.25F1
;
        PUSH	DE
        PUSH	HL
        EX	AF,AF'
        XOR	A
        EX	AF,AF'
        CALL	C.25D5
;
        EX	DE,HL
        JR	NC,J$2849
;
        EX	AF,AF'
        OR	04H	; 4 
        EX	AF,AF'
J$2849:	POP	HL
        RST	20H
;
        JR	C,J$2852
;
        EX	DE,HL
        EX	AF,AF'
        OR	01H	; 1 
        EX	AF,AF'
J$2852:	EX	(SP),HL
        CALL	C.2980
;
        LD	A,24H	; "$"
        DI	
        OUT	(99H),A
        LD	A,91H
        OUT	(99H),A
        LD	A,C
        OUT	(9BH),A
        LD	A,B
        OUT	(9BH),A
        LD	A,L
        OUT	(9BH),A
        LD	A,(D.FAF6)
        OUT	(9BH),A
        LD	A,E
        OUT	(9BH),A
        LD	A,D
        OUT	(9BH),A
        POP	HL
        LD	A,L
        OUT	(9BH),A
        LD	A,H
        OUT	(9BH),A
        LD	A,(D.F3F2)
        OUT	(9BH),A
        EX	AF,AF'
        OUT	(9BH),A
        LD	A,(D.FB02)
        AND	0FH	; 15 
        OR	70H	; "p"
        OUT	(9BH),A
        EI	
        POP	HL
        LD	(D.FCB3),HL
        POP	HL
        LD	(D.FCB5),HL
        POP	HL
        POP	DE
        POP	BC
        RET	
;
;	-----------------
;
;	  Subroutine __________________________
;	     Inputs  ________________________
;	     Outputs ________________________
;
C.2898:	CALL	C.12C4
;
        LD	L,C
        LD	H,B
        LD	A,E
        CALL	C.29A5
;
        CALL	C.25F1
;
        CALL	C.25EE
;
        EX	AF,AF'
        XOR	A
        EX	AF,AF'
        CALL	C.25D5
;
        JR	NC,J$28B3
;
        EX	AF,AF'
        OR	04H	; 4 
        EX	AF,AF'
J$28B3:	INC	HL
        PUSH	HL
        CALL	C.25E6
;
        JR	NC,J$28BE
;
        EX	AF,AF'
        OR	08H	; 8 
        EX	AF,AF'
J$28BE:	INC	HL
        POP	DE
        CALL	C.29C4
;
        EX	AF,AF'
        CALL	C.29DB
;
        EX	AF,AF'
        LD	A,(D.F3F2)
        CALL	C.29EB
;
        LD	A,(D.FB02)
        AND	0FH	; 15 
        ADD	A,80H
        CALL	C.29E3
;
;
;	  Subroutine __________________________
;	     Inputs  ________________________
;	     Outputs ________________________
;
C$28D8:	LD	B,04H	; 4 
        JR	J.28E6
;
;	-----------------
;
;	  Subroutine __________________________
;	     Inputs  ________________________
;	     Outputs ________________________
;
C$28DC:	LD	B,06H	; 6 
        JR	J.28E6
;
;	-----------------
;
;	  Subroutine __________________________
;	     Inputs  ________________________
;	     Outputs ________________________
;
C.28E0:	LD	B,02H	; 2 
        JR	J.28E6
;
;	-----------------
;
;	  Subroutine __________________________
;	     Inputs  ________________________
;	     Outputs ________________________
;
C$28E4:	LD	B,00H
J.28E6:	PUSH	BC
        CALL	C$2925
;
        POP	AF
        DI	
        OUT	(99H),A
        LD	A,0ADH
        OUT	(99H),A
        LD	A,60H	; "`"
        OUT	(99H),A
        LD	A,0AEH
        OUT	(99H),A
        CALL	C.2980
;
        AND	10H	; 16 
        RET	Z
;
        LD	A,08H	; 8 
        DI	
        OUT	(99H),A
        LD	A,8FH
        OUT	(99H),A
        IN	A,(99H)
        LD	L,A
        LD	A,09H	; 9 
        OUT	(99H),A
        LD	A,8FH
        OUT	(99H),A
        IN	A,(99H)
        PUSH	AF
        XOR	A
        OUT	(99H),A
        LD	A,8FH
        OUT	(99H),A
        EI	
        POP	AF
        AND	01H	; 1 
        LD	H,A
        SCF	
        RET	
;
;	-----------------
;
;	  Subroutine __________________________
;	     Inputs  ________________________
;	     Outputs ________________________
;
C$2925:	PUSH	AF
        CALL	C.2980
;
        LD	A,20H	; " "
        DI	
        OUT	(99H),A
        LD	A,91H
        OUT	(99H),A
        LD	A,L
        OUT	(9BH),A
        LD	A,H
        OUT	(9BH),A
        LD	A,E
        OUT	(9BH),A
        LD	A,(D.FAF6)
        OUT	(9BH),A
        POP	AF
        OUT	(99H),A
        LD	A,0ACH
        OUT	(99H),A
        EI	
        RET	
;
;	-----------------
;
;	  Subroutine __________________________
;	     Inputs  ________________________
;	     Outputs ________________________
;
C$2949:	PUSH	DE
        CALL	C$29A0
;
        XOR	A
        CALL	C.29DB
;
        LD	A,40H	; "@"
        CALL	C.29E3
;
        CALL	C.2980
;
        LD	A,07H	; 7 
        CALL	C.298B
;
        EI	
        POP	DE
        RET	
;
;	-----------------
;
;	  Subroutine __________________________
;	     Inputs  ________________________
;	     Outputs ________________________
;
C$2961:	CALL	C.29A5
;
        LD	A,2CH	; ","
        DI	
        OUT	(99H),A
        LD	A,91H
        OUT	(99H),A
        LD	A,(D.F3F2)
        OUT	(9BH),A
        XOR	A
        OUT	(9BH),A
        LD	A,(D.FB02)
        AND	0FH	; 15 
        OR	50H	; "P"
        OUT	(9BH),A
        EI	
        RET	
;
;	-----------------
;
;	  Subroutine __________________________
;	     Inputs  ________________________
;	     Outputs ________________________
;
C.2980:	LD	A,02H	; 2 
        CALL	C.298B
;
        EI	
        RRCA	
        JR	C,C.2980
;
        RLCA	
        RET	
;
;	-----------------
;
;	  Subroutine __________________________
;	     Inputs  ________________________
;	     Outputs ________________________
;
C.298B:	DI	
        OUT	(99H),A
        LD	A,8FH
        OUT	(99H),A
        PUSH	HL
        POP	HL
        IN	A,(99H)
        PUSH	AF
        XOR	A
        OUT	(99H),A
        LD	A,8FH
        OUT	(99H),A
        POP	AF
        RET	
;
;	-----------------
;
;	  Subroutine __________________________
;	     Inputs  ________________________
;	     Outputs ________________________
;
C$29A0:	PUSH	AF
        LD	A,20H	; " "
        JR	J$29A8
;
;	-----------------
;
;	  Subroutine __________________________
;	     Inputs  ________________________
;	     Outputs ________________________
;
C.29A5:	PUSH	AF
        LD	A,24H	; "$"
J$29A8:	PUSH	AF
        CALL	C.2980
;
        DI	
        POP	AF
        OUT	(99H),A
        LD	A,91H
        OUT	(99H),A
        LD	A,L
        OUT	(9BH),A
        LD	A,H
        OUT	(9BH),A
        POP	AF
        OUT	(9BH),A
        LD	A,(D.FAF6)
        OUT	(9BH),A
        EI	
        RET	
;
;	-----------------
;
;	  Subroutine __________________________
;	     Inputs  ________________________
;	     Outputs ________________________
;
C.29C4:	LD	A,28H	; "("
        DI	
        OUT	(99H),A
        LD	A,91H
        OUT	(99H),A
        LD	A,E
        OUT	(9BH),A
        LD	A,D
        OUT	(9BH),A
        LD	A,L
        OUT	(9BH),A
        LD	A,H
        OUT	(9BH),A
        EI	
        RET	
;
;	-----------------
;
;	  Subroutine __________________________
;	     Inputs  ________________________
;	     Outputs ________________________
;
C.29DB:	PUSH	AF
        DI	
        OUT	(99H),A
        LD	A,0ADH
        JR	J.29F1
;
;	-----------------
;
;	  Subroutine __________________________
;	     Inputs  ________________________
;	     Outputs ________________________
;
C.29E3:	PUSH	AF
        DI	
        OUT	(99H),A
        LD	A,0AEH
        JR	J.29F1
;
;	-----------------
;
;	  Subroutine __________________________
;	     Inputs  ________________________
;	     Outputs ________________________
;
C.29EB:	PUSH	AF
        DI	
        OUT	(99H),A
        LD	A,0ACH
J.29F1:	OUT	(99H),A
        EI	
        POP	AF
        RET	

; Initial VDP register values

I$29F6:	DEFB	000H                    ; R#0: DG=0 (Digitize off), IE2=0 (lightpen int off) IE1=0 (VR int off), M5=0, M4=0, M3=0 (screen 1)
        DEFB    020H                    ; R#1: BLK=0 Enable display IE0=1 (HR int on), M1=0, M2=0 (screen 1), SZ=0 (8x8 sprites), MAG=0 (sprites not magnified)
        DEFB    000H                    ; R#2: A16=0, A15=0, A14=0, A13=0, A12=0, A11=0, A10=0
        DEFB    000H                    ; R#3: B13=0, B12=0, B11=0, B10=0, B9=0,  B8=0,  B7=0, B6=0
        DEFB    000H                    ; R#4: C16=0, C15=0, C14=0, C13=0, C12=0, C11=0
        DEFB    000H                    ; R#5: D14=0, D13=0, D12=0, D11=0, D10=0, D9=0,  D8=0, D7=0
        DEFB    000H                    ; R#6: E16=0, E15=0, E14=0, E13=0, E12=0, E11=0
        DEFB    000H                    ; R#7: TC3=0, TC2=0, TC1=0, TC0=0 (text color 0), BDC3=0,BDC2=0,BDC1=0,BDC0=0 (border color 0)

        DEFB	008H                    ; R#8: MS=0 (disable mouse), LP=0 (disable lightpen), TP=0 (color 0 is transparent), CBD=0 (colorbus not input), VRS1=0, VRS0=0 (64 KB RAM chip), SPD=0 (sprites enabled), B/W=0 (blank/white off)

        IF	INTHZ EQ 60

        DEFB	000H                    ; R#9: LN=0, SYM1=0, SYM0=0 (internal synchronisation), IL=0 (no interlace), EO=0 (no odd even display), NTSC=0 (NTSC), DCD=0 (dot clock direction output)

        ELSE

        DEFB	002H                    ; R#9: LN=0, SYM1=0, SYM0=0 (internal synchronisation), IL=0 (no interlace), EO=0 (no odd even display), NTSC=1 (PAL), DCD=0 (dot clock direction output)

        ENDIF

        DEFB	000H                    ; R#10: B16=0, B15=0, B14=0
        DEFB    000H                    ; R#11: D16=0, D15=0
        DEFB    000H                    ; R#12: C3=0, C2=0, C1=0, C0=0 (color 0), BC3=0, BC2=0, BC1=0, BC0=0 (back color 0)
        DEFB    000H                    ; R#13: ON3=0, ON2=0, ON1=0, ON0=0 (blink on ?), OF3=0, OF2=0, OF1=0, OF0=0 (blink off ?)
        DEFB    000H                    ; R#14: F16=0, F15=0, F14=0 (VRAM base access is lower 16 KB, TMS9918 compatibel)
        DEFB    000H                    ; R#15: RS3=0, RS2=0, RS1=0, RS0=0 (select status register 0, TMS9918 compatibel)
        DEFB	000H                    ; R#16: C3=0, C2=0, C1=0, C0=0 (color code 0)
        DEFB    000H                    ; R#17: AII=0 (autoincrement register), RC5=0, RC4=0, RC3=0, RC2=0, RC1=0, RC0=0 (control register 0)
        DEFB    000H                    ; R#18: dV3=0, dV2=0, dV1=0, dV0=0 (no vertical adjust), dH3=0, dH2=0, dH1=0, dH0=0 (no horizontal adjust)
        DEFB    000H                    ; R#19: IL7=0, IL6=0, IL5=0, IL4=0, IL3=0, IL2=0, IL1=0, IL0=0 (interrupt on line 0)
        DEBF    000H                    ; R#20: CBX5=0, CBX4=0, CBX3=0, CBX2=0, CBX1=0, CBX0=0 (Color burst value of phase 0)
        DEFB    03BH                    ; R#21: CBX5=1, CBX4=1, CBX3=1, CBX2=0, CBX1=1, CBX0=1 (Color burst value of phase 1/3)
        DEFB    005H                    ; R#22: CBX5=0, CBX4=0, CBX3=0, CBX2=1, CBX1=0, CBX0=1 (Color burst value of phase 2/3)
        DEFB    000H                    ; R#23: DO7=0, DO6=0, DO5=0, DO4=0, DO3=0, DO2=0, DO1=0, DO0=0 (display offset)

;
;	  Subroutine __________________________
;	     Inputs  ________________________
;	     Outputs ________________________
;
C$2A0E:	CALL	C.2BE6
;
        CALL	C$2A54
;
        XOR	A
        CALL	C.0481
;
        CALL	C.0F9F
;
        LD	HL,I$2A80
        CALL	C.2A4B
;
        CALL	C.2A73
;
        CALL	C$10B5
;
        LD	HL,I$2A97
        LD	C,04H	; 4 
        JR	Z,J$2A33
;
        LD	HL,J.2A9D
        LD	C,02H	; 2 
J$2A33:	LD	A,(D.FAFC)
        AND	0F9H
        OR	C
        LD	(D.FAFC),A
        CALL	C.2A4B
;
        LD	HL,J.2AA2
        CALL	C.2A4B
;
        CALL	C.2A73
;
        JP	J$1BAC
;
;	-----------------
;
;	  Subroutine __________________________
;	     Inputs  ________________________
;	     Outputs ________________________
;
C.2A4B:	LD	A,(HL)
        AND	A
        RET	Z
;
        CALL	C.0018
;
        INC	HL
        JR	C.2A4B
;
;	-----------------
;
;	  Subroutine __________________________
;	     Inputs  ________________________
;	     Outputs ________________________
;
C$2A54:	LD	A,05H	; 5 
        LD	(D.FCAF),A
        CALL	C.09BF
;
        XOR	A
J$2A5D:	PUSH	AF
        LD	(D.FAF6),A
        XOR	A
        CALL	C.07FE
;
        CALL	C.06F5
;
        POP	AF
        INC	A
        CP	04H	; 4 
        JR	NZ,J$2A5D
;
        XOR	A
        LD	(D.FAF6),A
        RET	
;
;	-----------------
;
;	  Subroutine __________________________
;	     Inputs  ________________________
;	     Outputs ________________________
;
C.2A73:	PUSH	BC
        PUSH	AF
        LD	B,80H
J$2A77:	XOR	A
J$2A78:	DEC	A
        JR	NZ,J$2A78
;
        DJNZ	J$2A77
;
        POP	AF
        POP	BC
        RET	
;
;	-----------------
I$2A80:	LD	E,B
        LD	(D$4220),A
        LD	C,C
        LD	C,A
        LD	D,E
        JR	NZ,J$2AFF
;
        LD	H,L
        LD	(HL),D
        LD	(HL),E
        LD	L,C
        LD	L,A
        LD	L,(HL)
        JR	NZ,J$2AC2
;
        LD	L,30H	; "0"
        JR	NC,J.2AA2
;
        LD	A,(BC)
        NOP	
I$2A97:	LD	SP,I$3832
        LD	C,E
        JR	NZ,J.2A9D
;
J.2A9D:	LD	(HL),34H	; "4"
        LD	C,E
        JR	NZ,J.2AA2
;
J.2AA2:	LD	D,(HL)
        LD	L,C
        LD	H,H
        LD	H,L
        LD	L,A
        JR	NZ,J$2B16
;
        LD	H,L
        LD	L,L
        LD	L,A
        LD	(HL),D
        LD	A,C
        JR	NZ,J$2B19
;
        LD	L,(HL)
        LD	(HL),E
        LD	(HL),H
        LD	H,C
        LD	L,H
        LD	L,H
        LD	H,L
        LD	H,H
        DEC	C
        LD	A,(BC)
        NOP	
;
;	  Subroutine __________________________
;	     Inputs  ________________________
;	     Outputs ________________________
;
C$2ABB:	LD	IX,I$0183
        CALL	C.001C
J$2AC2:	RET	

; korean patch

J$2AC3:	PUSH	HL
        PUSH	HL
        LD	HL,(D.F3B9)
        EX	(SP),HL
        XOR	A
        LD	(D.F3B9),A
        CALL	C$0D52
        POP	HL
        LD	(D.F3B9),HL
        POP	HL
        RET	
;
;	-----------------
;
;	  Subroutine __________________________
;	     Inputs  ________________________
;	     Outputs ________________________
;
C.2AD6:	LD	(D.FCB0),A
        PUSH	AF
        LD	A,(D.FFE8)
        AND	0F7H
        LD	(D.FFE8),A
        POP	AF
        RET	
;
;	-----------------
?.2AE4:	CALL	C.2B94
C$2AE5	EQU	$-2
;
        JP	Z,J.2B08
;
        CP	2CH	; ","
        JR	Z,J$2B03
;
        RST	28H
;
        PUSH	AF
        CP	02H	; 2 
        JP	NC,J.0546
;
        LD	B,A
        LD	A,(D.FC18)
        AND	0F0H
        OR	B
        LD	(D.FC18),A
D$2AFE	EQU	$-1
J$2AFF:	POP	AF
        JP	Z,J.2B60
;
J$2B03:	RST	08H
;
        INC	L
        CALL	C.2B9D
;
J.2B08:	LD	B,0DH	; 13 
        CALL	C.1CD2
;
        PUSH	AF
        LD	BC,I$020C
        CALL	C.194B
;
        LD	B,03H	; 3 
J$2B16:	CALL	C.1CD2
;
J$2B19:	AND	03H	; 3 
        LD	C,A
        LD	A,(D.FC18)
        RRC	A
        RRC	A
        AND	0CH	; 12 
        OR	C
        DEC	B
        CALL	C.1A59
;
        LD	B,09H	; 9 
        CALL	C.1CD2
;
        RES	2,A
        LD	C,A
        LD	A,(D.FC18)
        BIT	0,A
        JR	Z,J$2B3B
;
        SET	2,C
J$2B3B:	LD	A,C
        DEC	B
        CALL	C.1A59
;
        LD	B,0BH	; 11 
        CALL	C.1CD2
;
        AND	03H	; 3 
        LD	C,A
        LD	A,(D.FC18)
        RLC	A
        RLC	A
        RLC	A
        RLC	A
        AND	0CH	; 12 
        OR	C
        DEC	B
        CALL	C.1A59
;
        POP	AF
        LD	B,0DH	; 13 
        JP	C.1A59
;
;	-----------------
J.2B60:	CALL	C.2BD6
;
        JR	J.2B08
;
;	-----------------
?.2B65:	CALL	C.2B94
;
        JP	Z,J.0540
;
        CP	2CH	; ","
        JR	Z,J$2B87
;
        RST	28H
;
        PUSH	AF
        CP	02H	; 2 
        JP	NC,J.0546
;
        RLCA	
        AND	02H	; 2 
        LD	B,A
        LD	A,(D.FC18)
        AND	0F1H
        OR	B
        LD	(D.FC18),A
        POP	AF
        JP	Z,J.2B60
;
J$2B87:	RST	08H
;
        INC	L
        CALL	C.2B9D
;
        AND	30H	; "0"
        JP	Z,J$2D1B
;
        JP	J$2D31
;
;	-----------------
;
;	  Subroutine __________________________
;	     Inputs  ________________________
;	     Outputs ________________________
;
C.2B94:	LD	A,(D.FD0C)
        LD	(D.FC18),A
        DEC	HL
        RST	10H
;
        RET	
;
;	-----------------
;
;	  Subroutine __________________________
;	     Inputs  ________________________
;	     Outputs ________________________
;
C.2B9D:	CP	2CH	; ","
        JR	Z,J$2BBD
;
        RST	28H
;
        CP	02H	; 2 
        JP	NC,J.0546
;
        RLC	A
        RLC	A
        RLC	A
        RLC	A
        LD	B,A
        LD	A,(D.FC18)
        AND	0CFH
        OR	B
        LD	(D.FC18),A
        DEC	HL
        RST	10H
;
        JR	Z,C.2BD6
;
J$2BBD:	RST	08H
;
        INC	L
        RST	28H
;
        JP	NZ,J.0540
;
        CP	02H	; 2 
        JP	NC,J.0546
;
        RRC	A
        RRC	A
        LD	B,A
        LD	A,(D.FC18)
        AND	3FH	; "?"
        OR	B
        LD	(D.FC18),A
;
;	  Subroutine __________________________
;	     Inputs  ________________________
;	     Outputs ________________________
;
C.2BD6:	LD	A,(D.FC18)
        LD	(D.FD0C),A
        RET	
;
;	-----------------
;
;	  Subroutine __________________________
;	     Inputs  ________________________
;	     Outputs ________________________
;
C$2BDD:	CALL	C.2BE6
        LD	A,01H	; 1 
        CALL	C.1CF9
        RET	
;
;	-----------------
;
;	  Subroutine __________________________
;	     Inputs  ________________________
;	     Outputs ________________________
;
C.2BE6:	CALL	C.1CF7
        LD	B,03H	; 3 
        CALL	C.1CD2
        RLC	A
        RLC	A
        AND	30H	; "0"
        LD	C,A
        LD	B,09H	; 9 
        CALL	C.1CD2
        BIT	2,A
        JR	Z,J$2C00
        SET	0,C
J$2C00:	LD	B,0BH	; 11 
        CALL	C.1CD2
        RRC	A
        RRC	A
        RRC	A
        RRC	A
        AND	0C0H
        OR	C
        LD	(D.FD0C),A
        RET	
;
;	-----------------
;
;	  Subroutine __________________________
;	     Inputs  ________________________
;	     Outputs ________________________
;
C$2C14:	AND	03H	; 3 
        PUSH	AF
        CALL	C.1CD2
;
        AND	0CH	; 12 
        LD	C,A
        POP	AF
        OR	C
        DEC	B
        CALL	C.1A59
;
        RET	
;
;	-----------------
J$2C24:	AND	0BH	; 11 
        PUSH	AF
        CALL	C.1CD2
;
        AND	04H	; 4 
        LD	A,C
        POP	AF
        OR	C
        DEC	B
        POP	HL
        JP	C.1A59
;
;	-----------------
;
;	  Subroutine __________________________
;	     Inputs  ________________________
;	     Outputs ________________________
;
C.2C34:	LD	A,(D.FCAD)
        CP	02H	; 2 
        JP	NZ,J.0DFE
;
        LD	A,(D$FDA4)
        CP	0F7H
        JP	NZ,J.0DFE
;
J$2C44:	LD	A,(HL)
        INC	HL
        INC	C
        CALL	C.12A5
;
        JR	NC,J$2C57
;
        JR	NZ,J$2C52
;
        CP	20H	; " "
        JR	C,J$2C55
;
J$2C52:	CALL	C$2C61
;
J$2C55:	INC	DE
        RET	
;
;	-----------------
J$2C57:	PUSH	HL
        LD	HL,D.F3B9
        LD	(HL),00H
        POP	HL
        JP	J$2C44
;
;	-----------------
;
;	  Subroutine __________________________
;	     Inputs  ________________________
;	     Outputs ________________________
;
C$2C61:	PUSH	AF
        PUSH	HL
        LD	HL,D.F3B9
        LD	A,(HL)
        AND	A
        JR	NZ,J$2C78
;
        POP	HL
        POP	AF
        BIT	7,A
        JR	Z,J$2C76
;
        LD	(D.F3B9),A
        INC	B
        DEC	DE
        RET	
;
;	-----------------
J$2C76:	LD	(DE),A
        RET	
;
;	-----------------
J$2C78:	POP	HL
        POP	AF
        LD	(D.F3BA),A
        CALL	C$2C9A
;
        PUSH	HL
        XOR	A
        LD	(D.F3B9),A
        LD	(D.F3BA),A
        LD	HL,I$6A00
J$2C8B:	CALL	C$2CA1
;
        AND	A
        JR	Z,J$2C96
;
        LD	(DE),A
        INC	DE
        INC	HL
        DJNZ	J$2C8B
;
J$2C96:	INC	B
        DEC	DE
        POP	HL
        RET	
;
;	-----------------
;
;	  Subroutine __________________________
;	     Inputs  ________________________
;	     Outputs ________________________
;
C$2C9A:	LD	IX,I$018C
        CALL	C.001C
;
;
;	  Subroutine __________________________
;	     Inputs  ________________________
;	     Outputs ________________________
;
C$2CA1:	LD	IX,I$018F
        CALL	C.001C
;
        RET	
;
;	-----------------
;
;	  Subroutine __________________________
;	     Inputs  ________________________
;	     Outputs ________________________
;
C$2CA9:	LD	A,(D.FCAD)
        CP	03H	; 3 
        JR	C,J.2CB8
;
        CP	05H	; 5 
        JR	NC,J.2CB8
;
        POP	HL
        POP	HL
        POP	AF
        RET	
;
;	-----------------
J.2CB8:	XOR	A
        JP	C.09BF
;
;	-----------------
J$2CBC:	CP	0AH	; 10 
        JP	NC,J.0546
;
        PUSH	HL
        CALL	C$2D03
;
        POP	HL
        DEC	HL
        RST	10H
;
        RET	Z
;
        RST	08H
;
        INC	L
        CP	2CH	; ","
        JR	Z,J$2CD8
;
        RST	28H
;
        CP	04H	; 4 
        JP	NC,J.0546
;
        DEC	HL
        RST	10H
;
        RET	Z
;
J$2CD8:	RST	08H
;
        INC	L
        CP	2CH	; ","
        JR	Z,J$2CE3
;
        RST	28H
;
        LD	(D.F3DB),A
        RET	Z
;
J$2CE3:	RST	08H
;
        INC	L
        CP	2CH	; ","
        JR	Z,J$2CEF
;
        CALL	C.1F7A
;
        DEC	HL
        RST	10H
;
        RET	Z
;
J$2CEF:	RST	08H
;
        INC	L
        CP	2CH	; ","
        JR	Z,J$2CFA
;
        RST	28H
;
        LD	(D.F417),A
        RET	Z
;
J$2CFA:	RST	08H
;
        INC	L
        RST	28H
;
        CP	04H	; 4 
D$2CFE	EQU	$-1
        JP	NC,J.0546
;
        RET	
;
;	-----------------
;
;	  Subroutine __________________________
;	     Inputs  ________________________
;	     Outputs ________________________
;
C$2D03:	LD	IX,I.0186
        CALL	C.001C
;
        RET	
;
;	-----------------
I$2D0B:	LD	C,B
        LD	B,C
        LD	C,(HL)
        NOP	
        LD	H,L
        DEC	HL
        LD	D,E
        LD	E,C
        LD	D,E
        LD	D,H
        LD	B,L
        LD	C,L
        NOP	
        CALL	PO,C$FF2A
;
J$2D1B:	PUSH	HL
        LD	A,0CH	; 12 
        RST	18H
;
        LD	A,(D.FCAD)
        CP	02H	; 2 
        JR	C,J.2D2E
;
        CP	05H	; 5 
        JR	NC,J.2D2E
;
        XOR	A
        LD	(D.FCAD),A
J.2D2E:	POP	HL
        AND	A
        RET	
;
;	-----------------
J$2D31:	PUSH	HL
        LD	A,0CH	; 12 
        RST	18H
;
        LD	A,(D.FCAD)
        CP	02H	; 2 
        JR	C,J.2D42
;
        CP	05H	; 5 
        JR	NC,J.2D42
;
        JR	J$2D45
;
;	-----------------
J.2D42:	CALL	C$2ABB
;
J$2D45:	POP	HL
        AND	A
        RET	
;
;	-----------------
;
;	  Subroutine __________________________
;	     Inputs  ________________________
;	     Outputs ________________________
;
C$2D48:	PUSH	HL
        PUSH	DE
        PUSH	BC
        PUSH	AF
        LD	A,(D.FCAD)
        CP	04H	; 4 
        JR	Z,J$2D60
;
        CP	03H	; 3 
        CALL	Z,C$2D7A
;
J.2D58:	LD	A,0CH	; 12 
        RST	18H
;
        POP	AF
        POP	BC
        POP	DE
        POP	HL
        RET	
;
;	-----------------
J$2D60:	LD	A,E
        CP	41H	; "A"
        JR	C,J.2D58
;
        LD	A,(D.F3DE)
        PUSH	AF
        XOR	A
        LD	(D.F3DE),A
        LD	IX,I.0186
        CALL	C.001C
;
        POP	AF
        LD	(D.F3DE),A
        JR	J.2D58
;
;	-----------------
;
;	  Subroutine __________________________
;	     Inputs  ________________________
;	     Outputs ________________________
;
C$2D7A:	LD	A,E
        CP	41H	; "A"
        RET	NC
;
        LD	A,(D.F3DE)
        PUSH	AF
        XOR	A
        LD	(D.F3DE),A
        LD	IX,I.0189
        CALL	C.001C
;
        POP	AF
        LD	(D.F3DE),A
        RET	

;	  Subroutine korean lightpen function 3
;	     Inputs  ________________________
;	     Outputs ________________________

J$2D92:	LD	A,1
        CALL	C.0131			; read vdp status register 1
        EI	
        AND	40H
        RET	Z
        LD	A,0FFH
        RET	

;	  Subroutine korean lightpen function 0
;	     Inputs  ________________________
;	     Outputs ________________________

J$2D9E:	LD	HL,XSAVE+1
        XOR	A
        BIT	7,(HL)			; lightpen interrupt flag set ?
        RET	Z			; nope, quit
        RES	7,(HL)			; reset lightpen interrupt flag
        DI	
        CALL	C$2DB4			; read lightpen data via V9938
        EI	
        EX	DE,HL
        LD	A,H
        AND	01H
        LD	H,A
        JP	J$34AD			; finish with lightpen data

;	  Subroutine __________________________
;	     Inputs  ________________________
;	     Outputs ________________________

C$2DB4:	LD	A,3
        CALL	C.0131			; read vdp status register 3
        LD	L,A
        LD	A,4
        CALL	C.0131			; read vdp status register 4
        AND	01H	; 1 
        LD	H,A
        LD	A,6
        CALL	C.0131			; read vdp status register 6
        AND	03H
        LD	D,A
        LD	A,5
        CALL	C.0131			; read vdp status register 5
        LD	E,A
        EI	
        RET	
;
;	-----------------
;
;	  Subroutine __________________________
;	     Inputs  ________________________
;	     Outputs ________________________
;
C$2DD2:	CALL	C.16AD
;
        RET	NC
;
        LD	DE,I$2D0B
        CALL	C.16AD
;
        RET	
;
;	-----------------
?.2DDD:	RRA	
        ADD	HL,SP
        LD	H,0BH	; 11 
        ADD	HL,HL
        LD	B,27H	; "'"
        DEC	(HL)
        CP	2DH	; "-"
        JR	NZ,J$2DF7
;
        LD	HL,(D$7D0E)
        LD	A,(BC)
        JR	Z,J$2DF9
;
        DAA	
        INC	SP
        CP	2DH	; "-"
        RRA	
        RRCA	
        ADD	HL,HL
        RRCA	
J$2DF7:	LD	A,H
        ADD	HL,BC
J$2DF9:	ADD	HL,HL
        INC	C
        DAA	
        LD	(D$2CFE),A
        JR	NZ,J$2E11
;
        JR	Z,J$2E13
;
        LD	A,E
        EX	AF,AF'
        JR	Z,J$2E17
;
        DAA	
J$2E08:	JR	NC,J$2E08
;
        INC	L
        RRA	
        LD	DE,I$1127
        LD	A,D
        RLCA	
J$2E11:	ADD	HL,HL
        LD	(DE),A
J$2E13:	DAA	
        CPL	
        CP	2BH	; "+"
J$2E17:	RRA	
        INC	DE
        DEC	H
        INC	DE
        LD	A,B
        RLCA	
        JR	Z,J$2E35
;
        DAA	
        DEC	L
        CP	2BH	; "+"
        RRA	
        INC	DE
        DEC	H
        INC	DE
        LD	(HL),A
        LD	B,29H	; ")"
        JR	J$2E53
;
;	-----------------
?.2E2C:	INC	L
        CP	2AH	; "*"
        RRA	
        DEC	D
        INC	HL
        DEC	D
        LD	(HL),L
        LD	B,28H	; "("
J$2E35	EQU	$-1
        INC	E
        DAA	
        LD	HL,(D$2AFE)
        RRA	
        DEC	D
        INC	HL
        DEC	D
        LD	(HL),H
        LD	B,27H	; "'"
        RRA	
        DAA	
        ADD	HL,HL
        CP	29H	; ")"
        RRA	
        RLA	
        LD	HL,I$7117
        LD	B,28H	; "("
        LD	(D$2727),HL
        CP	29H	; ")"
J$2E53:	RRA	
        RLA	
        LD	HL,I$7017
        LD	B,27H	; "'"
        DEC	H
        DAA	
        LD	H,0FEH
        JR	Z,J$2E7F
;
        ADD	HL,DE
        RRA	
        ADD	HL,DE
        LD	L,L
        LD	B,28H	; "("
        JR	Z,J$2E8F
;
        INC	H
        CP	28H	; "("
        RRA	
        ADD	HL,DE
        RRA	
        ADD	HL,DE
        LD	L,D
        EX	AF,AF'
        DAA	
        DEC	HL
        DAA	
        INC	HL
        CP	27H	; "'"
        RRA	
        DEC	DE
        DEC	E
        DEC	DE
        LD	H,(HL)
        ADD	HL,BC
        JR	Z,J$2EAD
;
J$2E7F:	DAA	
        LD	HL,I$27FE
        RRA	
        DEC	DE
        DEC	E
        DEC	DE
        LD	H,E
        DEC	BC
        DAA	
        LD	SP,I$2027
        CP	26H	; "&"
J$2E8F:	RRA	
        DEC	E
        DEC	DE
        DEC	E
        LD	E,A
        INC	C
        JR	Z,J$2ECB
;
        DAA	
        LD	E,0FEH
        LD	H,1FH
        DEC	E
        DEC	DE
        DEC	E
        LD	E,E
        LD	C,28H	; "("
        SCF	
        DAA	
        DEC	E
        CP	0FFH
        CP	0FFH
        CP	0FFH
        CP	0FFH
J$2EAD:	CP	0FFH
        CP	0FFH
        CP	0FFH
        CP	0FFH
        CP	0FFH
        CP	0FEH
J.2EB9:	LD	BC,(D.F56A)
        LD	DE,(D.F56C)
        CALL	C.3376
;
        RET	C
;
        CALL	C.2980
;
        LD	A,20H	; " "
        CALL	C.336E
J$2ECB	EQU	$-2
;
        LD	HL,D.F562
        LD	BC,I.0E9B
        OTIR	
        LD	A,(HL)
        AND	0FH	; 15 
        OR	90H
        OUT	(C),A
        EI	
        AND	A
        RET	
;
;	-----------------
J.2EDF:	CALL	C.3320
;
        LD	A,(D.FCAF)
        SUB	06H	; 6 
        JR	C,J.2EFA
;
        JR	Z,J.2F1B
;
        DEC	A
        JR	Z,J.2EFA
;
J$2EEE:	CALL	C.3354
;
        LD	(HL),A
        INC	HL
        DEC	BC
        LD	A,C
        OR	B
        JP	NZ,J$2EEE
;
        RET	
;
;	-----------------
J.2EFA:	LD	D,02H	; 2 
        LD	(HL),00H
J$2EFE:	CALL	C$2F13
;
        CALL	C.3354
;
        OR	(HL)
        LD	(HL),A
        DEC	BC
        LD	A,C
        OR	B
        JR	Z,J$2F11
;
        DEC	D
        JR	NZ,J$2EFE
;
        INC	HL
        JR	J.2EFA
;
;	-----------------
J$2F11:	DEC	D
        RET	Z
;
;
;	  Subroutine __________________________
;	     Inputs  ________________________
;	     Outputs ________________________
;
C$2F13:	LD	A,(HL)
        ADD	A,A
        ADD	A,A
        ADD	A,A
        ADD	A,A
        LD	(HL),A
        AND	A
        RET	
;
;	-----------------
J.2F1B:	LD	D,04H	; 4 
        LD	(HL),00H
J$2F1F:	LD	A,(HL)
        ADD	A,A
        ADD	A,A
        LD	(HL),A
        CALL	C.3354
;
        OR	(HL)
        LD	(HL),A
        DEC	BC
        LD	A,C
        OR	B
        JR	NZ,J$2F31
;
        OR	E
        JR	Z,J$2F37
;
        DEC	E
J$2F31:	DEC	D
        JR	NZ,J$2F1F
;
        INC	HL
        JR	J.2F1B
;
;	-----------------
J$2F37:	DEC	D
        RET	Z
;
        LD	A,(HL)
J$2F3A:	ADD	A,A
        ADD	A,A
        DEC	D
        JR	NZ,J$2F3A
I$2F3E	EQU	$-1
;
        LD	(HL),A
        AND	A
        RET	
;
;	-----------------
J.2F42:	CALL	C.32C9
;
        RET	C
;
        CALL	C.2980
;
        LD	A,20H	; " "
        CALL	C.336E
;
        PUSH	BC
        LD	HL,D.F562
        LD	BC,I.0E9B
        OTIR	
        POP	BC
        LD	A,(HL)
        AND	0FH	; 15 
        OR	0B0H
        POP	HL
        PUSH	AF
        LD	A,(D.FCAF)
        SUB	06H	; 6 
        JR	C,J.2F92
;
        JR	Z,J$2FD4
;
        DEC	A
        JR	Z,J.2F92
;
        CALL	C.336C
;
        LD	A,(D.F5A8)
        LD	E,A
        AND	A
        CALL	NZ,C.33A2
;
        LD	A,(HL)
        OUT	(9BH),A
        POP	AF
        OUT	(99H),A
        LD	A,0AEH
        OUT	(99H),A
        EI	
J.2F81:	DEC	BC
        LD	A,C
        OR	B
        RET	Z
;
        INC	HL
        LD	A,E
        AND	A
        CALL	NZ,C.33A2
I$2F8A	EQU	$-1
;
        JR	C,J.2F81
;
        LD	A,(HL)
        OUT	(9BH),A
        JR	J.2F81
;
;	-----------------
J.2F92:	CALL	C.336C
;
        LD	D,0FH	; 15 
        LD	A,(D.F5A8)
        LD	E,A
        AND	A
        CALL	NZ,C.33A2
;
        LD	A,(HL)
        RRCA	
        RRCA	
        RRCA	
        RRCA	
        AND	D
        OUT	(9BH),A
        POP	AF
        OUT	(99H),A
        LD	A,0AEH
        OUT	(99H),A
        EI	
J.2FAF:	DEC	BC
        LD	A,C
        OR	B
        RET	Z
;
        LD	A,E
        AND	A
        CALL	NZ,C.33A2
;
        JR	C,J$2FBE
;
        LD	A,(HL)
        AND	D
        OUT	(9BH),A
J$2FBE:	INC	HL
        DEC	BC
        LD	A,C
        OR	B
        RET	Z
;
        LD	A,E
        AND	A
        CALL	NZ,C.33A2
;
        JR	C,J.2FAF
;
        LD	A,(HL)
        RRCA	
        RRCA	
        RRCA	
        RRCA	
        AND	D
        OUT	(9BH),A
        JR	J.2FAF
;
;	-----------------
J$2FD4:	CALL	C.336C
;
        LD	D,03H	; 3 
        LD	A,(D.F5A8)
        AND	A
        CALL	NZ,C.33A2
;
        LD	A,(HL)
        RRCA	
        RRCA	
        AND	D
        OUT	(9BH),A
        POP	AF
        OUT	(99H),A
        LD	A,0AEH
        OUT	(99H),A
        EI	
J.2FEE:	DEC	BC
        LD	A,C
        OR	B
        JP	NZ,J$2FF7
;
        OR	E
        RET	Z
;
        DEC	E
J$2FF7:	LD	A,(D.F5A8)
        AND	A
        CALL	NZ,C.33A2
;
        JR	C,J$3008
;
        LD	A,(HL)
        RRCA	
        RRCA	
        RRCA	
        RRCA	
        AND	D
        OUT	(9BH),A
J$3008:	DEC	BC
        LD	A,C
        OR	B
        JP	NZ,J$3011
;
        OR	E
        RET	Z
;
        DEC	E
J$3011:	LD	A,(D.F5A8)
        AND	A
        CALL	NZ,C.33A2
;
        JR	C,J$3020
;
        LD	A,(HL)
        RRCA	
        RRCA	
        AND	D
        OUT	(9BH),A
J$3020:	DEC	BC
        LD	A,C
        OR	B
        JP	NZ,J$3029
;
        OR	E
        RET	Z
;
        DEC	E
J$3029:	LD	A,(D.F5A8)
        AND	A
        CALL	NZ,C.33A2
;
        JR	C,J$3036
;
        LD	A,(HL)
        AND	D
        OUT	(9BH),A
J$3036:	DEC	BC
        LD	A,C
        OR	B
        JP	NZ,J$303F
;
        OR	E
        RET	Z
;
        DEC	E
J$303F:	INC	HL
        LD	A,(D.F5A8)
I$3042	EQU	$-1
        AND	A
        CALL	NZ,C.33A2
;
        JR	C,J.2FEE
;
        LD	A,(HL)
        RLCA	
        RLCA	
        AND	D
        OUT	(9BH),A
        JP	J.2FEE
;
;	-----------------
;
;	  Subroutine __________________________
;	     Inputs  ________________________
;	     Outputs ________________________
;
C.3052:	LD	HL,C.0000
        LD	A,10H	; 16 
        AND	A
J.3058:	PUSH	AF
        ADD	HL,HL
        JR	NC,J$305F
;
        POP	AF
        SCF	
        PUSH	AF
J$305F:	EX	DE,HL
        ADD	HL,HL
        EX	DE,HL
        JR	NC,J.306A
;
        ADD	HL,BC
        JR	NC,J.306A
;
        POP	AF
        SCF	
        PUSH	AF
J.306A:	POP	AF
        DEC	A
        JR	NZ,J.3058
;
        RET	
;
;	-----------------
J.306F:	PUSH	HL
        CALL	C.32BB
;
        POP	HL
        INC	HL
        INC	HL
        INC	HL
        INC	HL
        LD	E,00H
        JR	J$3087
;
;	-----------------
J.307C:	PUSH	HL
        INC	HL
        INC	HL
        INC	HL
        INC	HL
        CALL	C.32BB
;
        POP	HL
        LD	E,01H	; 1 
J$3087:	PUSH	DE
        LD	C,(HL)
        INC	HL
        LD	B,(HL)
        INC	HL
        LD	E,(HL)
        INC	HL
        LD	D,(HL)
        EX	DE,HL
        AND	A
        SBC	HL,BC
        INC	HL
        POP	DE
        PUSH	DE
        CALL	C.33C7
;
        POP	DE
        DEC	E
        PUSH	AF
        CALL	NZ,C.3444
;
        POP	AF
        CALL	Z,C$3433
;
        CALL	C.3457
;
        AND	A
        RET	
;
;	-----------------
J.30A8:	PUSH	HL
        CALL	C.32BB
;
        LD	HL,C.0000
        LD	E,L
        CALL	C.33C7
;
        CALL	C.3444
;
        LD	(D.F575),HL
        LD	DE,(D.F571)
        POP	HL
        LD	(HL),E
        INC	HL
        LD	(HL),D
        DEC	HL
        CALL	C.32C9
;
        JR	C,J$30F3
;
        CALL	C.2980
;
        LD	A,20H	; " "
        CALL	C.336E
;
        PUSH	BC
        LD	HL,D.F562
        LD	BC,I.0E9B
        OTIR	
        POP	BC
        LD	A,(HL)
        AND	0FH	; 15 
I$30DB	EQU	$-1
        OR	0B0H
        LD	HL,I$30F2
        EX	(SP),HL
        PUSH	AF
        LD	A,(D.FCAF)
        SUB	06H	; 6 
        JR	C,J.311C
;
        JP	Z,J$315C
;
        DEC	A
        JR	Z,J.311C
;
        JR	J$30F9
;
;	-----------------
I$30F2:	AND	A
J$30F3:	PUSH	AF
        CALL	C.3457
;
        POP	AF
        RET	
;
;	-----------------
J$30F9:	CALL	C.336C
;
        CALL	C.339D
;
        LD	A,(HL)
D$3100:	OUT	(9BH),A
        POP	AF
        OUT	(99H),A
        LD	A,0AEH
        OUT	(99H),A
        EI	
J.310A:	DEC	BC
        LD	A,C
        OR	B
        RET	Z
;
        INC	HL
        CALL	C.3279
;
        CALL	C.339D
;
        JR	C,J.310A
;
        LD	A,(HL)
        OUT	(9BH),A
        JR	J.310A
;
;	-----------------
J.311C:	CALL	C.336C
;
        LD	D,00H
        CALL	C.339D
;
        LD	A,(HL)
        RRCA	
        RRCA	
        RRCA	
        RRCA	
        AND	0FH	; 15 
        OUT	(9BH),A
        POP	AF
        OUT	(99H),A
        LD	A,0AEH
        OUT	(99H),A
        EI	
J.3135:	INC	D
        DEC	BC
        LD	A,C
        OR	B
        JR	NZ,J$313E
;
        OR	E
        RET	Z
;
        DEC	E
J$313E:	CALL	C.3279
;
        LD	A,D
        RRCA	
        LD	A,(HL)
        INC	HL
        JR	C,J$314C
;
        DEC	HL
        RRCA	
        RRCA	
        RRCA	
        RRCA	
J$314C:	PUSH	AF
        CALL	C.339D
;
        JR	C,J$3159
;
        POP	AF
        AND	0FH	; 15 
        OUT	(9BH),A
        JR	J.3135
;
;	-----------------
J$3159:	POP	AF
        JR	J.3135
;
;	-----------------
J$315C:	CALL	C.336C
;
        LD	D,00H
        CALL	C.339D
;
        LD	A,(HL)
        RRCA	
        RRCA	
        AND	03H	; 3 
        OUT	(9BH),A
        POP	AF
        OUT	(99H),A
        LD	A,0AEH
        OUT	(99H),A
        EI	
J.3173:	INC	D
        DEC	BC
        LD	A,C
        OR	B
        JR	NZ,J$317C
;
        OR	E
        RET	Z
;
        DEC	E
J$317C:	CALL	C.3279
;
        LD	A,D
        AND	03H	; 3 
        JR	Z,J$3197
;
        DEC	A
        JR	Z,J$319F
;
        DEC	A
        JR	Z,J$319A
;
        CALL	C.339D
;
        JR	C,J$3194
;
        LD	A,(HL)
        AND	03H	; 3 
        OUT	(9BH),A
I$3193	EQU	$-1
J$3194:	INC	HL
        JR	J.3173
;
;	-----------------
J$3197:	LD	A,(HL)
        JR	J$31A2
;
;	-----------------
J$319A:	LD	A,(HL)
        RRCA	
        RRCA	
        JR	J$31A4
;
;	-----------------
J$319F:	LD	A,(HL)
        RLCA	
        RLCA	
J$31A2:	RLCA	
        RLCA	
J$31A4:	PUSH	AF
        CALL	C.339D
;
        JR	C,J$31B1
;
        POP	AF
        AND	03H	; 3 
        OUT	(9BH),A
        JR	J.3173
;
;	-----------------
J$31B1:	POP	AF
        JR	J.3173
;
;	-----------------
J.31B4:	PUSH	HL
        INC	HL
        INC	HL
        INC	HL
        INC	HL
        PUSH	HL
        CALL	C.32BB
;
        LD	HL,C.0000
        LD	E,01H	; 1 
        CALL	C.33C7
;
        LD	DE,(D.F571)
        POP	HL
        LD	(HL),E
        INC	HL
        LD	(HL),D
        POP	HL
        CALL	C.3320
;
        LD	A,(D.FCAF)
        SUB	06H	; 6 
        JR	C,J.31ED
;
        JR	Z,J$3227
;
        DEC	A
        JR	Z,J.31ED
;
J$31DD:	CALL	C.3292
;
        CALL	C.3354
;
        LD	(HL),A
        INC	HL
        DEC	BC
        LD	A,C
        OR	B
        JR	NZ,J$31DD
;
        JP	J.3270
;
;	-----------------
J.31ED:	LD	D,00H
J.31EF:	CALL	C.3292
;
        LD	A,07H	; 7 
        DI	
        OUT	(99H),A
        LD	A,8FH
        OUT	(99H),A
        PUSH	HL
        POP	HL
        LD	A,D
        RRCA	
        IN	A,(99H)
        JR	NC,J$3208
;
        OR	(HL)
        LD	(HL),A
        INC	HL
        JR	J$320D
;
;	-----------------
J$3208:	ADD	A,A
        ADD	A,A
        ADD	A,A
        ADD	A,A
        LD	(HL),A
J$320D:	XOR	A
        OUT	(99H),A
        LD	A,8FH
        OUT	(99H),A
        EI	
        INC	D
        DEC	BC
        LD	A,C
        OR	B
        JR	NZ,J.31EF
;
        OR	E
        JR	Z,J$3221
;
        DEC	E
        JR	J.31EF
;
;	-----------------
J$3221:	LD	A,D
        RRCA	
        JR	C,J.3271
;
        JR	J.3270
;
;	-----------------
J$3227:	LD	D,00H
J.3229:	CALL	C.3292
;
        LD	A,07H	; 7 
        DI	
        OUT	(99H),A
        LD	A,8FH
        OUT	(99H),A
        PUSH	HL
I$3236:	POP	HL
        LD	A,D
        AND	03H	; 3 
        JR	Z,J$3249
;
        DEC	A
        JR	Z,J$324F
;
        DEC	A
        IN	A,(99H)
        JR	Z,J$3253
;
        OR	(HL)
        LD	(HL),A
        INC	HL
        JR	J$3257
;
;	-----------------
J$3249:	IN	A,(99H)
        RRCA	
        RRCA	
        JR	J$3256
I.324E	EQU	$-1
;
;	-----------------
J$324F:	IN	A,(99H)
        RLCA	
        RLCA	
J$3253:	RLCA	
        RLCA	
        OR	(HL)
J$3256:	LD	(HL),A
J$3257:	XOR	A
        OUT	(99H),A
        LD	A,8FH
I.325C:	OUT	(99H),A
        EI	
        INC	D
        DEC	BC
        LD	A,C
        OR	B
        JR	NZ,J.3229
;
        OR	E
        JR	Z,J$326B
I$3267	EQU	$-1
;
        DEC	E
        JR	J.3229
;
;	-----------------
J$326B:	LD	A,D
        AND	03H	; 3 
        JR	NZ,J.3271
;
J.3270:	DEC	HL
J.3271:	CALL	C$32B0
;
        CALL	C.3457
;
        AND	A
        RET	
;
;	-----------------
;
;	  Subroutine __________________________
;	     Inputs  ________________________
;	     Outputs ________________________
;
C.3279:	PUSH	DE
        PUSH	HL
        LD	HL,(D.F571)
        LD	DE,(D.F575)
        ADD	HL,DE
        EX	DE,HL
        POP	HL
        RST	20H
;
        POP	DE
        RET	C
;
        PUSH	BC
        PUSH	DE
        CALL	C.3444
;
        LD	(D.F575),HL
        JR	J$32AA
;
;	-----------------
;
;	  Subroutine __________________________
;	     Inputs  ________________________
;	     Outputs ________________________
;
C.3292:	PUSH	DE
        PUSH	HL
        LD	HL,(D.F571)
        LD	DE,(D.F573)
        ADD	HL,DE
        EX	DE,HL
        POP	HL
        RST	20H
;
        POP	DE
        RET	C
;
        LD	HL,(D.F573)
        PUSH	BC
        PUSH	DE
        CALL	C.3436
;
        AND	A
J$32AA:	POP	DE
        POP	BC
        LD	HL,(D.F571)
        RET	
;
;	-----------------
;
;	  Subroutine __________________________
;	     Inputs  ________________________
;	     Outputs ________________________
;
C$32B0:	LD	DE,(D.F571)
        AND	A
        SBC	HL,DE
        INC	HL
        JP	C.3436
;
;	-----------------
;
;	  Subroutine __________________________
;	     Inputs  ________________________
;	     Outputs ________________________
;
C.32BB:	LD	A,(HL)
        INC	HL
        LD	H,(HL)
        LD	L,A
        CALL	C.05BA
;
        LD	A,D
        CP	09H	; 9 
        RET	C
;
        JP	J.052E
;
;	-----------------
;
;	  Subroutine __________________________
;	     Inputs  ________________________
;	     Outputs ________________________
;
C.32C9:	LD	HL,(D.F562)
        LD	C,(HL)
        INC	HL
        LD	B,(HL)
        INC	HL
        LD	E,(HL)
        INC	HL
        LD	D,(HL)
        INC	HL
        CALL	C.3376
;
        RET	C
;
        PUSH	HL
        PUSH	BC
        PUSH	DE
        LD	HL,(D.F566)
        LD	A,(D.F56F)
        AND	04H	; 4 
        JR	NZ,J$32ED
;
        EX	DE,HL
        CALL	C.3390
;
        AND	A
        SBC	HL,DE
        LD	A,23H	; "#"
J$32ED	EQU	$-1
        LD	(D.F5A0),HL
        LD	(D.F5A2),HL
        LD	D,B
        LD	E,C
        EX	DE,HL
        SBC	HL,DE
        JR	NC,J$32FE
;
        LD	HL,C.0000
J$32FE:	LD	(D.F5A4),HL
        LD	(D.F5A6),HL
        LD	A,H
        OR	L
I$3306:	LD	(D.F5A8),A
        POP	DE
        POP	BC
        LD	(D.F56A),BC
        LD	(D.F56C),DE
        CALL	C.3052
;
        LD	B,H
        LD	C,L
        LD	A,00H
        ADC	A,A
        LD	E,A
        AND	A
        POP	HL
        EX	(SP),HL
        JP	(HL)
;
;	-----------------
;
;	  Subroutine __________________________
;	     Inputs  ________________________
;	     Outputs ________________________
;
C.3320:	CALL	C.2980
;
        LD	A,20H	; " "
        CALL	C.336E
;
        LD	HL,D.F562
        LD	BC,I.0E9B
        OTIR	
        LD	A,0A0H
        OUT	(C),A
        EI	
        LD	BC,(D.F56A)
        LD	DE,(D.F56C)
        LD	HL,(D.F566)
        LD	(HL),C
        INC	HL
        LD	(HL),B
        INC	HL
        LD	(HL),E
        INC	HL
        LD	(HL),D
        INC	HL
        PUSH	HL
        CALL	C.3052
;
        LD	B,H
        LD	C,L
        LD	A,00H
        ADC	A,A
        LD	E,A
        POP	HL
        RET	
;
;	-----------------
;
;	  Subroutine __________________________
;	     Inputs  ________________________
;	     Outputs ________________________
;
C.3354:	DI	
        LD	A,07H	; 7 
        OUT	(99H),A
        LD	A,8FH
        OUT	(99H),A
        PUSH	HL
        POP	HL
        IN	A,(99H)
        PUSH	AF
        XOR	A
        OUT	(99H),A
        LD	A,8FH
        OUT	(99H),A
        POP	AF
        EI	
        RET	
;
;	-----------------
;
;	  Subroutine __________________________
;	     Inputs  ________________________
;	     Outputs ________________________
;
C.336C:	LD	A,0ACH
;
;	  Subroutine __________________________
;	     Inputs  ________________________
;	     Outputs ________________________
;
C.336E:	DI	
        OUT	(99H),A
        LD	A,91H
        OUT	(99H),A
        RET	
;
;	-----------------
;
;	  Subroutine __________________________
;	     Inputs  ________________________
;	     Outputs ________________________
;
C.3376:	LD	A,B
        OR	C
        SCF	
        RET	Z
;
        LD	A,D
        OR	E
        SCF	
        RET	Z
;
        PUSH	HL
        PUSH	DE
        LD	E,C
        LD	D,B
        CALL	C.3390
;
        RST	20H
;
        POP	DE
        POP	HL
        RET	C
;
        PUSH	HL
        LD	HL,I.00D4
        RST	20H
;
        POP	HL
        RET	
;
;	-----------------
;
;	  Subroutine __________________________
;	     Inputs  ________________________
;	     Outputs ________________________
;
C.3390:	LD	HL,I.0100
        LD	A,(D.FCAF)
        AND	06H	; 6 
        CP	06H	; 6 
        RET	NZ
;
        INC	H
        RET	
;
;	-----------------
;
;	  Subroutine __________________________
;	     Inputs  ________________________
;	     Outputs ________________________
;
C.339D:	LD	A,(D.F5A8)
        AND	A
        RET	Z
;
;
;	  Subroutine __________________________
;	     Inputs  ________________________
;	     Outputs ________________________
;
C.33A2:	PUSH	HL
        LD	HL,(D.F5A2)
        LD	A,L
        OR	H
        JR	Z,J$33B0
;
        DEC	HL
        LD	(D.F5A2),HL
        POP	HL
        RET	
;
;	-----------------
J$33B0:	LD	HL,(D.F5A6)
        DEC	HL
        LD	A,L
        OR	H
        JR	NZ,J$33C1
;
        LD	HL,(D.F5A0)
        LD	(D.F5A2),HL
        LD	HL,(D.F5A4)
J$33C1:	LD	(D.F5A6),HL
        POP	HL
        SCF	
        RET	
;
;	-----------------
;
;	  Subroutine __________________________
;	     Inputs  ________________________
;	     Outputs ________________________
;
C.33C7:	LD	A,(D$FFA7)
        CP	0C9H
        JP	Z,J.0546
;
        PUSH	BC
        PUSH	HL
        LD	HL,I.F577
        PUSH	HL
        LD	(HL),D
        LD	A,E
        AND	A
        PUSH	AF
        EX	DE,HL
        INC	DE
        LD	HL,I.F866
        LD	BC,I.000B
        LDIR	
        XOR	A
        LD	B,19H
J$33E6:	LD	(DE),A
        INC	DE
        DJNZ	J$33E6
;
        POP	AF
        POP	DE
        PUSH	AF
        LD	C,0FH	; 15 
        JR	Z,J$33F3
;
        LD	C,16H
J$33F3:	CALL	C.345C
;
        INC	A
        JR	NZ,J$3401
;
        POP	AF
        JP	Z,J.055E
;
        LD	E,43H	; "C"
        JR	J.3454
;
;	-----------------
J$3401:	LD	HL,D.0001
        LD	(D$F585),HL
        POP	AF
        POP	HL
        POP	DE
        LD	A,H
        OR	L
        JR	NZ,J.3428
;
        LD	HL,I.FE00
        ADD	HL,SP
I$3412:	JR	NC,J.3421
;
        LD	DE,(D.F6C6)
        AND	A
        SBC	HL,DE
        JR	C,J.3421
;
        LD	A,H
        AND	A
        JR	NZ,J.3428
;
J.3421:	LD	DE,(D$F862)
I$3425:	LD	HL,I.0100
J.3428:	LD	(D.F571),DE
        LD	(D.F573),HL
        LD	C,1AH
        JR	C.345C
;
;	-----------------
;
;	  Subroutine __________________________
;	     Inputs  ________________________
;	     Outputs ________________________
;
C$3433:	LD	HL,(D.F573)
;
;	  Subroutine __________________________
;	     Inputs  ________________________
;	     Outputs ________________________
;
C.3436:	LD	DE,I.F577
        LD	C,26H	; "&"
        CALL	C.345C
;
        AND	A
        RET	Z
;
        LD	E,42H	; "B"
        JR	J.3454
;
;	-----------------
;
;	  Subroutine __________________________
;	     Inputs  ________________________
;	     Outputs ________________________
;
C.3444:	LD	HL,(D.F573)
        LD	DE,I.F577
        LD	C,27H	; "'"
        CALL	C.345C
;
        LD	A,L
        OR	H
        RET	NZ
;
        LD	E,37H	; "7"
J.3454:	JP	J.05C6
;
;	-----------------
;
;	  Subroutine __________________________
;	     Inputs  ________________________
;	     Outputs ________________________
;
C.3457:	LD	DE,I.F577
        LD	C,10H	; 16 
;
;	  Subroutine __________________________
;	     Inputs  ________________________
;	     Outputs ________________________
;
C.345C:	LD	IX,I$7FFD
        JP	C.0262
;
;	-----------------
;
;	  Subroutine __________________________
;	     Inputs  ________________________
;	     Outputs ________________________
;
C.3463:	LD	B,00H
        AND	7FH
        LD	C,A
        SBC	HL,BC
        RET	
;
;	-----------------
J$346B:	IN	A,(0BAH)
        CPL	
        AND	08H	; 8 
        RET	Z
        LD	A,0FFH
        RET	
;
;	-----------------
J$3474:	LD	HL,D.FAFF
        XOR	A
        BIT	7,(HL)
        RET	Z
        RES	7,(HL)
        IN	A,(0BAH)
        AND	07H	; 7 
        LD	D,A
        IN	A,(0B8H)
        LD	L,A
        LD	H,00H
        IN	A,(0B9H)
        SRL	D
        RRA	
        LD	E,A
        RL	H
        PUSH	HL
        PUSH	DE
        LD	BC,I$FFFD
        ADD	HL,BC
        EX	DE,HL
        LD	C,0EEH
        ADD	HL,BC
        LD	A,E
        OUT	(0B8H),A
        RR	D
        ADC	HL,HL
        LD	A,L
        OUT	(0B9H),A
        LD	A,H
        OUT	(0BAH),A
        POP	DE
        POP	HL
        IN	A,(0BAH)
        AND	20H	; " "
        RET	Z

J$34AD:	LD	A,(D.FB01)
        CALL	C.3463
        LD	BC,I$00D3
        CALL	C$34C7
        LD	A,L
        LD	(D.FB00),A
        EX	DE,HL
        LD	A,(D.FAFF)
        CALL	C.3463
;
        LD	BC,I.00FF
;
;	  Subroutine __________________________
;	     Inputs  ________________________
;	     Outputs ________________________
;
C$34C7:	LD	A,H
        RLA	
        JR	C,J$34D4
;
        PUSH	HL
        SBC	HL,BC
        POP	HL
        JR	C,J$34D6
;
        LD	L,C
        LD	H,B
        JP	C,J$002E
J$34D4	EQU	$-2
;
J$34D6:	LD	A,L
        LD	(D.FAFE),A
        LD	A,0FFH
        RET	

;	Subroutine	S.NEWPAD
;	Inputs		________________________
;	Outputs		________________________

J$34DD:	JP	J$10A3			; patch code
        NOP

J$34E1:	CP	0BH	; 11 
        JR	Z,J$346B
        LD	E,0FH	; 15 
        LD	BC,I$00BF
        LD	HL,I$10EF
        CP	0CH	; 12 
        JR	Z,J.3509
        LD	BC,I$40FF
        LD	HL,I$20DF
        CP	10H	; 16 
        JR	Z,J.3509
        AND	03H	; 3 
        SUB	02H	; 2 
        LD	A,(D.FAFE)
        RET	M
        LD	A,(D.FB00)
        RET	Z
        XOR	A
        RET	
;
;	-----------------
J.3509:	DI	
        CALL	C.357F
;
        CALL	C$359A
;
        PUSH	AF
        CALL	C.3585
;
        CALL	C.3591
;
        PUSH	AF
        CALL	C.357F
;
        CALL	C.3597
;
        PUSH	AF
        CALL	C.3585
;
        CALL	C.3597
;
        PUSH	AF
        CALL	C.357F
;
        CALL	C.3597
;
        PUSH	AF
        CALL	C.3585
;
        CALL	C.3591
;
        PUSH	AF
        CALL	C.357F
;
        CALL	C.35AA
;
        CALL	C.3585
;
        CALL	C.35AA
;
        CALL	C.357F
;
        EI	
        POP	AF
        POP	HL
        POP	DE
        POP	BC
        XOR	08H	; 8 
        SUB	02H	; 2 
        CP	0DH	; 13 
        JR	C,J$355D
;
        POP	AF
        CALL	C.3577
;
        LD	(D.FB00),A
        POP	AF
        CALL	C.3577
;
        JR	J$3571
;
;	-----------------
J$355D:	LD	A,D
        ADD	A,A
        ADD	A,A
        ADD	A,A
        ADD	A,A
        OR	H
        NEG	
        LD	(D.FB00),A
        POP	AF
        POP	DE
        ADD	A,A
        ADD	A,A
        ADD	A,A
        ADD	A,A
        OR	B
        NEG	
J$3571:	LD	(D.FAFE),A
        LD	A,0FFH
        RET	
;
;	-----------------
;
;	  Subroutine __________________________
;	     Inputs  ________________________
;	     Outputs ________________________
;
C.3577:	XOR	08H	; 8 
        BIT	3,A
        RET	Z
;
        OR	0F0H
        RET	
;
;	-----------------
;
;	  Subroutine __________________________
;	     Inputs  ________________________
;	     Outputs ________________________
;
C.357F:	CALL	C.35A2
;
        AND	L
        JR	J$3589
;
;	-----------------
;
;	  Subroutine __________________________
;	     Inputs  ________________________
;	     Outputs ________________________
;
C.3585:	CALL	C.35A2
;
        OR	H
J$3589:	PUSH	AF
        LD	A,E
        OUT	(0A0H),A
        POP	AF
        OUT	(0A1H),A
        RET	
;
;	-----------------
;
;	  Subroutine __________________________
;	     Inputs  ________________________
;	     Outputs ________________________
;
C.3591:	CALL	C.35AA
;
        CALL	C.35AA
;
;
;	  Subroutine __________________________
;	     Inputs  ________________________
;	     Outputs ________________________
;
C.3597:	CALL	C.35AA
;
;
;	  Subroutine __________________________
;	     Inputs  ________________________
;	     Outputs ________________________
;
C$359A:	LD	A,0EH	; 14 
        CALL	C$35A3
;
        AND	0FH	; 15 
        RET	
;
;	-----------------
;
;	  Subroutine __________________________
;	     Inputs  ________________________
;	     Outputs ________________________
;
C.35A2:	LD	A,E
;
;	  Subroutine __________________________
;	     Inputs  ________________________
;	     Outputs ________________________
;
C$35A3:	OUT	(0A0H),A
        IN	A,(0A2H)
        AND	C
        OR	B
        RET	
;
;	-----------------
;
;	  Subroutine __________________________
;	     Inputs  ________________________
;	     Outputs ________________________
;
C.35AA:	EX	(SP),HL
        EX	(SP),HL
        EX	(SP),HL
        EX	(SP),HL
        RET	
;
;	-----------------
?.35AF:	CP	2CH	; ","
        JR	Z,J$35EF
;
        RST	28H
;
        CP	04H	; 4 
        JR	NC,J.3635
;
        AND	A
        JR	Z,J.35C2
;
        CP	01H	; 1 
        JR	Z,J.35C2
;
        LD	E,00H
        DEC	A
J.35C2:	PUSH	DE
        RRCA	
        RRCA	
        LD	D,A
        RRCA	
        RRCA	
        LD	E,A
        LD	A,(D.FFE8)
        AND	0CFH
        OR	E
        LD	C,09H	; 9 
        CALL	C.36B4
;
        LD	A,D
        XOR	0C0H
        LD	E,A
        LD	A,3FH	; "?"
        CALL	C.3661
;
        POP	DE
        LD	A,E
        RRCA	
        RRCA	
        RRCA	
        LD	E,A
        LD	A,(D.FFE7)
        AND	0DFH
        OR	E
        CALL	C.36B2
;
        DEC	HL
        RST	10H
;
        RET	Z
;
J$35EF:	RST	08H
;
        INC	L
        CP	2CH	; ","
        JR	Z,J$3600
;
        CALL	C.366C
;
        LD	A,0DFH
        CALL	C.3661
;
        DEC	HL
        RST	10H
;
        RET	Z
;
J$3600:	RST	08H
;
        INC	L
        CP	2CH	; ","
        JR	Z,J$3617
;
        CALL	C.366C
;
        RRC	E
        LD	A,(D.FFE7)
        AND	0EFH
        OR	E
        CALL	C.36B2
;
        DEC	HL
        RST	10H
;
        RET	Z
;
J$3617:	RST	08H
;
        INC	L
        CP	2CH	; ","
        JR	Z,J$362C
;
        CALL	C.366C
;
        RLCA	
        RLCA	
        RLCA	
        LD	E,A
        LD	A,0F7H
        CALL	C.3661
;
        DEC	HL
        RST	10H
;
        RET	Z
;
J$362C:	RST	08H
;
        INC	L
        CP	2CH	; ","
        JR	Z,J$3644
;
        RST	28H
;
        CP	04H	; 4 
J.3635:	JP	NC,J.0546
;
        CPL	
        AND	03H	; 3 
        LD	E,A
        LD	A,0FCH
        CALL	C.3661
;
        DEC	HL
        RST	10H
;
        RET	Z
;
J$3644:	RST	08H
;
        INC	L
        CP	2CH	; ","
        JR	Z,J$3658
;
        CALL	C.366C
;
        RLCA	
        RLCA	
        LD	E,A
        LD	A,0FBH
        CALL	C.3661
;
        DEC	HL
        RST	10H
;
        RET	Z
;
J$3658:	RST	08H
;
        INC	L
        CALL	C.366C
;
        RRC	E
        LD	A,0EFH
;
;	  Subroutine __________________________
;	     Inputs  ________________________
;	     Outputs ________________________
;
C.3661:	PUSH	HL
        LD	HL,D.FAF7
        AND	(HL)
        OR	E
        LD	(HL),A
        OUT	(0F7H),A
        POP	HL
        RET	
;
;	-----------------
;
;	  Subroutine __________________________
;	     Inputs  ________________________
;	     Outputs ________________________
;
C.366C:	RST	28H
;
        CP	02H	; 2 
        JR	NC,J.3635
;
        AND	A
        RET	Z
;
        LD	E,20H	; " "
        RET	
;
;	-----------------
J$3676:	RST	10H
;
        JR	Z,J.3686
;
        CP	2CH	; ","
        JR	Z,J.3686
;
        CALL	C.366C
;
        DEC	A
        JR	NZ,J.3686
;
        LD	E,00H
        LD	BC,I$021E
J.3686	EQU	$-2
        DEC	HL
        RST	10H
;
        LD	A,0FFH
        JR	Z,J$3693
;
        PUSH	DE
        RST	08H
;
        INC	L
        RST	28H
;
        POP	DE
J$3693:	LD	D,A
        LD	A,(D$F3E6)
        PUSH	AF
        LD	A,D
        CALL	C$36AE
;
        CALL	C.36B8
;
        OR	40H	; "@"
J$36A0	EQU	$-1
        CALL	C.36B4
;
        CALL	C.36B8
;
        EI	
        AND	0BFH
        CALL	C.36B4
;
        POP	AF
;
;	  Subroutine __________________________
;	     Inputs  ________________________
;	     Outputs ________________________
;
C$36AE:	LD	C,07H	; 7 
        JR	C.36B4
;
;	-----------------
;
;	  Subroutine __________________________
;	     Inputs  ________________________
;	     Outputs ________________________
;
C.36B2:	LD	C,08H	; 8 
;
;	  Subroutine __________________________
;	     Inputs  ________________________
;	     Outputs ________________________
;
C.36B4:	LD	B,A
        JP	C.0647
;
;	-----------------
;
;	  Subroutine __________________________
;	     Inputs  ________________________
;	     Outputs ________________________
;
C.36B8:	LD	A,02H	; 2 
        CALL	C.298B
;
        AND	40H	; "@"
        JR	Z,C.36B8
;
J$36C1:	LD	A,02H	; 2 
        CALL	C.298B
;
        BIT	6,A
        JR	NZ,J$36C1
;
        OR	E
        AND	02H	; 2 
        JR	Z,C.36B8
;
        LD	A,(D.F3DF)
        LD	C,00H
        RET	
;
;	-----------------
?.36D5:	EI	
        INC	A
        JR	NZ,J$36DF
;
        CALL	C.396E
;
        RET	Z
;
        SCF	
        RET	
;
;	-----------------
J$36DF:	PUSH	AF
        CALL	C.3D33
;
        POP	AF
        LD	IX,I$3C55
        PUSH	IX
J$36E9	EQU	$-1
        PUSH	HL
        LD	HL,I$36F8
        ADD	A,L
        LD	L,A
        JR	NC,J$36F3
;
        INC	H
J$36F3:	LD	A,(HL)
        INC	HL
        LD	H,(HL)
        LD	L,A
        EX	(SP),HL
I$36F8:	RET	
;
;	-----------------
?.36F9:	CP	B
        ADD	HL,SP
        LD	B,E
        LD	A,(D$38E4)
        LD	E,L
        LD	A,(D$3ADA)
        ADC	A,E
        JR	C,J$36A0
;
        JR	C,J$36E9
;
        JR	C,J$3716
;
J$370A:	ADD	HL,SP
        JR	C,J$3748
;
D$370D:	ADC	A,B
D$370E:	LD	B,67H	; "g"
D.370F	EQU	$-1
        LD	BC,I$093A
        DEFB	0FDH		; << Illegal Op Code Byte >>
;	-----------------
;
        BIT	5,A
J$3716:	JR	NZ,J.3757
;
        AND	70H	; "p"
        LD	B,A
        LD	A,(D$370D)
        OR	10H	; 16 
        OR	B
        LD	(D.FD09),A
        BIT	6,A
        JR	Z,J$3736
;
        LD	B,40H	; "@"
J$372A:	CALL	C.3B45
;
        LD	A,(D.FC28)
        OR	A
        JP	NZ,J$3D2F
;
        DJNZ	J$372A
;
J$3736:	LD	A,(D$370E)
        LD	C,A
        LD	DE,C.0000
        DEC	HL
        RST	10H
;
        LD	A,C
        JR	Z,J.377F
;
        RST	08H
;
        JR	Z,J$370A
;
        CALL	C$3C78
;
J$3748:	POP	BC
        LD	B,A
        PUSH	BC
        RST	08H
;
        ADD	HL,HL
        POP	BC
        RET	NZ
;
        LD	A,B
        CP	C
        JR	C,J$375B
;
        JR	NZ,J.3757
;
        LD	A,D
        OR	E
J.3757:	JP	NZ,J.0546
;
        LD	A,B
J$375B:	OR	A
        JR	NZ,J.377F
;
        PUSH	HL
        LD	HL,I$E600
        ADD	HL,DE
        POP	HL
        JR	C,J.377F
;
        PUSH	HL
        LD	HL,D.FD09
        RES	6,(HL)
        CALL	C.3882
;
        LD	C,(HL)
        LD	L,A
        JR	NZ,J$37C5
;
        LD	B,C
        LD	C,L
        JR	NZ,J$37DB
;
        LD	L,C
        LD	(HL),E
        LD	L,E
        DEC	C
        LD	A,(BC)
        NOP	
        POP	HL
        RET	
;
;	-----------------
J.377F:	PUSH	HL
        PUSH	DE
        PUSH	AF
        LD	HL,D.F562
        LD	(HL),A
        DEC	HL
        LD	(HL),D
        DEC	HL
        LD	(HL),E
        OR	A
        JR	Z,J.3796
;
        SET	4,D
        CP	01H	; 1 
        JR	Z,J.3796
;
        LD	DE,I$7FFF
J.3796:	DEC	HL
        LD	(HL),D
        DEC	HL
        LD	(HL),E
        LD	DE,I.4000
        LD	BC,BDOS
        CALL	C.3C5A
;
        CALL	C.3C13
;
        POP	AF
        POP	DE
        LD	L,A
        LD	H,00H
        ADD	HL,HL
        ADD	HL,HL
        ADD	HL,HL
        ADD	HL,HL
        ADD	HL,HL
        ADD	HL,HL
        LD	E,D
        LD	D,00H
        ADD	HL,DE
        LD	DE,D.FFE7
        ADD	HL,DE
        PUSH	HL
        LD	HL,D.FFFF
        LD	(D.FC38),HL
        LD	BC,(D.370F)
J$37C4:	CALL	C.3B6D
J$37C5	EQU	$-2
;
        DEC	BC
        LD	A,B
        OR	C
        JR	NZ,J$37C4
;
        POP	BC
        PUSH	BC
        INC	HL
        LD	(D.FC38),HL
J$37D2:	CALL	C.3B6D
;
        DEC	BC
        LD	A,B
        OR	C
        JR	NZ,J$37D2
;
        CALL	C.3805
J$37DB	EQU	$-2
;
        LD	B,40H	; "@"
J$37DF:	CALL	C.3B46
;
        DJNZ	J$37DF
;
        LD	HL,D.FD09
        SET	6,(HL)
        POP	HL
        CALL	C$3D13
;
        CALL	C.3882
;
        JR	NZ,J$3854
;
        LD	A,C
        LD	(HL),H
        LD	H,L
        LD	(HL),E
        JR	NZ,J.3859
;
        LD	L,H
        LD	L,H
        LD	L,A
        LD	H,E
        LD	H,C
        LD	(HL),H
        LD	H,L
        LD	H,H
        DEC	C
        LD	A,(BC)
        NOP	
        POP	HL
        RET	
;
;	-----------------
;
;	  Subroutine __________________________
;	     Inputs  ________________________
;	     Outputs ________________________
;
C.3805:	PUSH	BC
        XOR	A
        LD	B,20H	; " "
        LD	HL,D.FC18
J$380C:	LD	(HL),A
        INC	HL
        DJNZ	J$380C
;
        POP	BC
        RET	
;
;	-----------------
?.3812:	CALL	C.3D33
;
        CALL	C.05AE
;
        PUSH	HL
        LD	BC,I.4000
J$381C:	CALL	C.3B45
;
        LD	HL,D.FC18
        LD	A,(HL)
        AND	A
        JR	Z,J.3859
;
        INC	C
        PUSH	BC
        LD	DE,D.F55E
        PUSH	DE
        LD	BC,I.000B
        LDIR	
        POP	HL
I$3832:	LD	B,08H	; 8 
        CALL	C.387C
;
        LD	A,(HL)
        CP	20H	; " "
        JR	Z,J$383E
;
        LD	A,2EH	; "."
J$383E:	RST	18H
;
        LD	B,03H	; 3 
        CALL	C.387C
;
        LD	A,(D$F661)
        AND	A
        JR	Z,J$3858
;
        ADD	A,0CH	; 12 
        LD	HL,D.F3B0
        CP	(HL)
        JR	NC,J$3855
;
        LD	A,20H	; " "
J$3854:	RST	18H
;
J$3855:	CALL	NC,C.05AE
;
J$3858:	POP	BC
J.3859:	DJNZ	J$381C
;
        LD	A,C
        OR	A
        JP	Z,J.055E
;
        CALL	C.05AE
;
        CALL	C$390C
;
        CALL	C$3D1D
;
        CALL	C.3882
;
        JR	NZ,J$38D0
;
        LD	A,C
        LD	(HL),H
        LD	H,L
        LD	(HL),E
        JR	NZ,J$38DA
;
        LD	(HL),D
        LD	H,L
        LD	H,L
        DEC	C
        LD	A,(BC)
        NOP	
        POP	HL
        RET	
;
;	-----------------
;
;	  Subroutine __________________________
;	     Inputs  ________________________
;	     Outputs ________________________
;
C.387C:	LD	A,(HL)
        INC	HL
        RST	18H
;
        DJNZ	C.387C
;
        RET	
;
;	-----------------
;
;	  Subroutine __________________________
;	     Inputs  ________________________
;	     Outputs ________________________
;
C.3882:	EX	(SP),HL
        LD	A,(HL)
        INC	HL
        EX	(SP),HL
        AND	A
        RET	Z
;
        RST	18H
;
        JR	C.3882
;
;	-----------------
?.388B:	CALL	C.3B3F
;
        LD	HL,(D.FC26)
        LD	C,(IY+6)
        LD	B,L
        LD	L,H
        LD	H,00H
        JR	J.38AB
;
;	-----------------
?.389A:	CALL	C.3B3F
;
        LD	BC,(D.FC34)
        LD	A,(HL)
        RRCA	
        JR	C,J$38A8
;
        LD	C,(IY+6)
J$38A8:	LD	HL,(D.FC36)
J.38AB:	PUSH	BC
        LD	IX,I.46FF
        CALL	C.001C
;
        LD	BC,I$6545
        LD	DE,I$6053
        LD	IX,I.325C
        CALL	C.001C
;
        LD	HL,D.F7F6
        LD	DE,I$F847
        LD	BC,C.0008
        LDIR	
        POP	HL
        LD	IX,I.46FF
J$38D0:	CALL	C.001C
;
        LD	IX,I$3042
        CALL	C.001C
;
J$38DA:	LD	IX,I$269A
        JP	C.001C
;
;	-----------------
?.38E1:	LD	A,(HL)
        CP	01H	; 1 
D$38E4:	LD	E,3DH	; "="
        JP	NZ,J.3D3B
;
        CALL	C.38FB
;
        LD	HL,D.FFFF
        JR	C,J$38F2
;
        INC	HL
J$38F2:	LD	(D.F7F8),HL
        LD	A,02H	; 2 
        LD	(D.F663),A
        RET	
;
;	-----------------
;
;	  Subroutine __________________________
;	     Inputs  ________________________
;	     Outputs ________________________
;
C.38FB:	PUSH	HL
        POP	IY
        LD	A,(IY+7)
        AND	01H	; 1 
        RET	Z
;
        LD	A,(IY+6)
        CP	(IY+5)
        CCF	
        RET	
;
;	-----------------
;
;	  Subroutine __________________________
;	     Inputs  ________________________
;	     Outputs ________________________
;
C$390C:	LD	BC,(D.370F)
        LD	HL,C.0000
J$3913:	CALL	C.3B6C
;
        JR	NZ,J$3919
;
        INC	HL
J$3919:	DEC	BC
        LD	A,B
        OR	C
        JR	NZ,J$3913
;
        LD	B,L
        LD	L,H
        LD	H,C
        JR	J.38AB
;
;	-----------------
J$3923:	CALL	C.3953
;
        RST	08H
;
        ADD	HL,HL
        CALL	C.3D27
;
;
;	  Subroutine __________________________
;	     Inputs  ________________________
;	     Outputs ________________________
;
C$392B:	XOR	A
        LD	(D.FC18),A
        CALL	C.3B46
;
        LD	DE,(D.FC32)
        LD	A,D
        OR	E
        RET	Z
;
        PUSH	HL
J$393A:	LD	B,D
        LD	C,E
        CALL	C.3B6C
;
        LD	DE,(D.FC38)
        LD	HL,C.0000
        LD	(D.FC38),HL
        CALL	C.3B6D
;
        LD	A,D
        AND	E
        INC	A
        JR	NZ,J$393A
;
        POP	HL
        RET	
;
;	-----------------
;
;	  Subroutine __________________________
;	     Inputs  ________________________
;	     Outputs ________________________
;
C.3953:	RST	08H
;
        JR	Z,J$3923
;
        INC	SP
        DEC	A
;
;	  Subroutine __________________________
;	     Inputs  ________________________
;	     Outputs ________________________
;
C$3958:	CALL	C.05BA
;
        RET	Z
;
        LD	A,D
        CP	0FCH
        JR	NC,J.396B
;
        CP	09H	; 9 
        JR	C,J.396B
;
        PUSH	HL
        CALL	C.396E
;
        POP	HL
        RET	Z
;
J.396B:	JP	J.052E
;
;	-----------------
;
;	  Subroutine __________________________
;	     Inputs  ________________________
;	     Outputs ________________________
;
C.396E:	LD	HL,I.FD89
        LD	DE,I$3983
J$3974:	LD	A,(DE)
        CP	(HL)
        JR	NZ,J$397E
;
        INC	HL
        INC	DE
        OR	A
        JR	NZ,J$3974
;
        RET	
;
;	-----------------
J$397E:	SUB	30H	; "0"
        RET	NZ
;
        OR	(HL)
        RET	
;
;	-----------------
I$3983:	LD	C,L
        LD	B,L
        LD	C,L
        JR	NC,J$3988
;
J$3988:	CALL	C.3953
;
        CALL	C.3D27
;
        PUSH	BC
        RST	08H
;
        LD	B,C
        RST	08H
;
        LD	D,E
        CALL	C$3958
;
        RST	08H
;
        ADD	HL,HL
        CALL	C.3BA2
;
        LD	E,41H	; "A"
        JP	Z,J.3D3B
;
        POP	BC
        CALL	C.3B45
;
        PUSH	HL
        CALL	C$3A35
;
        POP	HL
        JP	C.3B46
;
;	-----------------
I$39AC:	POP	DE
        LD	A,0FFH
        LD	B,(IY+1)
        LD	(D.FC28),A
        JP	C.3B46
;
;	-----------------
?.39B8:	PUSH	DE
        CALL	C.3BA2
;
        LD	IX,I$39AC
        PUSH	IX
        PUSH	AF
        OR	A
        JP	NZ,J$053A
;
        LD	A,E
        RRCA	
        RRCA	
        JR	C,J$3A15
;
        RRCA	
        JP	C,J$0534
;
        POP	AF
        JP	NZ,J.055E
;
        CALL	C.3C61
;
        BIT	0,E
        JR	NZ,J$39F9
;
        LD	HL,(D.FC35)
        LD	(D.FC26),HL
        LD	HL,D.FC34
        LD	A,(HL)
        LD	(IY+6),A
        XOR	A
        LD	(HL),A
        LD	HL,(D.FC32)
        LD	A,H
        OR	L
        RET	Z
;
        LD	HL,(D.FC2C)
        LD	(D.FC24),HL
        JP	C.3BE0
;
;	-----------------
J$39F9:	LD	H,A
        LD	L,A
        LD	(D.FC24),HL
        LD	(D.FC26),HL
        LD	HL,(D.FC34)
        LD	(IY+5),L
        DEC	HL
        LD	A,H
        OR	A
        RET	NZ
;
        LD	A,(D.FC36)
        OR	A
        RET	NZ
;
        SET	0,(IY+7)
        RET	
;
;	-----------------
J$3A15:	POP	AF
        JR	NZ,J$3A1B
;
        CALL	C$392B
;
J$3A1B:	LD	B,40H	; "@"
J$3A1D:	CALL	C.3B45
;
        LD	A,(D.FC18)
        AND	A
        JR	Z,J$3A2D
;
        DJNZ	J$3A1D
;
        LD	E,43H	; "C"
        JP	J.3D3B
;
;	-----------------
J$3A2D:	LD	E,02H	; 2 
        CALL	C.3C61
;
        CALL	C.3805
;
;
;	  Subroutine __________________________
;	     Inputs  ________________________
;	     Outputs ________________________
;
C$3A35:	PUSH	BC
        LD	DE,D.FC18
        LD	HL,I.F866
        LD	BC,I.000B
        LDIR	
        POP	BC
        RET	
;
;	-----------------
?.3A43:	CALL	C.3B3F
;
        PUSH	BC
        XOR	A
        LD	(D.FC28),A
        LD	A,(HL)
        RRCA	
        JR	C,J$3A59
;
        LD	A,(IY+6)
        LD	(D.FC34),A
        AND	A
        CALL	NZ,C.3BE1
;
J$3A59:	POP	BC
        JP	C.3B46
;
;	-----------------
?.3A5D:	PUSH	HL
        POP	IY
        LD	A,(IY+6)
        AND	A
        JR	NZ,J$3AB2
;
        PUSH	HL
        PUSH	BC
        CALL	C.3B3F
;
        LD	BC,D.0001
        LD	HL,(D.370F)
J$3A71:	CALL	C.3B6C
;
        JR	Z,J$3A81
;
        DEC	HL
        INC	BC
        LD	A,H
        OR	L
        JR	NZ,J$3A71
;
        LD	E,42H	; "B"
        JP	J.3D3B
;
;	-----------------
J$3A81:	LD	HL,(D.FC32)
        LD	A,H
        OR	L
        JR	NZ,J$3A8C
;
        LD	(D.FC32),BC
J$3A8C:	LD	(D.FC38),BC
        PUSH	BC
        LD	BC,(D.FC24)
        CALL	NZ,C.3B6D
;
        POP	BC
        LD	(D.FC2C),BC
        LD	(D.FC24),BC
        LD	HL,D.FFFF
        LD	(D.FC38),HL
        CALL	C.3B6D
;
        LD	B,(IY+1)
        CALL	C.3B46
;
        POP	BC
        POP	HL
J$3AB2:	PUSH	HL
        LD	DE,I.0009
        ADD	HL,DE
        LD	E,(IY+6)
        ADD	HL,DE
        LD	(HL),C
        INC	(IY+6)
        POP	HL
        RET	NZ
;
        CALL	C.3B3F
;
        PUSH	BC
        CALL	C.3BE1
;
        POP	BC
        LD	HL,(D.FC35)
        INC	HL
        LD	(D.FC35),HL
;
;	  Subroutine __________________________
;	     Inputs  ________________________
;	     Outputs ________________________
;
C$3AD0:	LD	HL,(D.FC26)
        INC	HL
        LD	(D.FC26),HL
        JP	C.3B46
;
;	-----------------
D$3ADA:	CALL	C.38FB
;
        RET	C
;
        LD	A,(IY+3)
        OR	A
        LD	C,00H
        LD	(IY+3),C
        RET	NZ
;
        LD	A,(IY+6)
        AND	A
        JR	Z,J$3B05
;
        LD	BC,I.0009
        ADD	HL,BC
        LD	C,A
        ADD	HL,BC
        LD	A,(HL)
        INC	(IY+6)
        RET	NZ
;
        PUSH	AF
        LD	B,(IY+1)
        CALL	C.3B45
;
        CALL	C$3AD0
;
        POP	AF
        RET	
;
;	-----------------
J$3B05:	CALL	C.3B3F
;
        PUSH	BC
        LD	BC,(D.FC24)
        LD	A,B
        OR	C
        LD	HL,(D.FC32)
        LD	(D.FC38),HL
        CALL	NZ,C.3B6C
;
        LD	HL,(D.FC38)
        LD	(D.FC24),HL
        PUSH	HL
        CALL	C.3BE0
;
        INC	(IY+6)
        POP	DE
        LD	HL,(D.FC2C)
        RST	20H
;
        JR	NZ,J$3B30
;
        SET	0,(IY+7)
J$3B30:	POP	BC
        CALL	C.3B46
;
        LD	A,(IY+9)
        RET	
;
;	-----------------
?.3B38:	PUSH	HL
        POP	IY
        LD	(IY+3),C
        RET	
;
;	-----------------
;
;	  Subroutine __________________________
;	     Inputs  ________________________
;	     Outputs ________________________
;
C.3B3F:	INC	HL
        LD	B,(HL)
        DEC	HL
        PUSH	HL
        POP	IY
;
;	  Subroutine __________________________
;	     Inputs  ________________________
;	     Outputs ________________________
;
C.3B45:	OR	37H	; "7"
C.3B46	EQU	$-1
        PUSH	HL
        PUSH	DE
        PUSH	BC
        PUSH	AF
        LD	A,B
        OR	A
        JR	Z,J.3B9D
;
        CP	41H	; "A"
        JR	NC,J.3B9D
;
        LD	L,B
        LD	H,00H
        DEC	HL
        ADD	HL,HL
        ADD	HL,HL
        ADD	HL,HL
        ADD	HL,HL
        ADD	HL,HL
        LD	DE,I$5100
        ADD	HL,DE
        LD	DE,D.FC18
        POP	AF
        JR	NC,J$3B67
;
        EX	DE,HL
J$3B67:	LD	BC,C.0020
        JR	J$3B84
;
;	-----------------
;
;	  Subroutine __________________________
;	     Inputs  ________________________
;	     Outputs ________________________
;
C.3B6C:	OR	37H	; "7"
C.3B6D	EQU	$-1
        PUSH	HL
        PUSH	DE
        PUSH	BC
        PUSH	AF
        CALL	C.3B93
;
        LD	HL,I$40FE
        ADD	HL,BC
        ADD	HL,BC
        LD	DE,D.FC38
        POP	AF
        JR	NC,J$3B81
;
        EX	DE,HL
J$3B81:	LD	BC,I$0002
J$3B84:	CALL	C.3C5A
;
        CALL	C.3C13
;
        LD	HL,(D.FC38)
        LD	A,H
        OR	L
        POP	BC
        POP	DE
        POP	HL
        RET	
;
;	-----------------
;
;	  Subroutine __________________________
;	     Inputs  ________________________
;	     Outputs ________________________
;
C.3B93:	LD	A,B
        OR	C
        JR	Z,J.3B9D
;
        LD	HL,(D.370F)
        SBC	HL,BC
        RET	NC
;
J.3B9D:	LD	E,3CH	; "<"
        JP	J.3D3B
;
;	-----------------
;
;	  Subroutine __________________________
;	     Inputs  ________________________
;	     Outputs ________________________
;
C.3BA2:	PUSH	HL
        PUSH	DE
        LD	DE,I.F866
        LD	B,0BH	; 11 
J$3BA9:	LD	A,(DE)
        CP	61H	; "a"
        JR	C,J.3BB5
;
        CP	7BH	; "{"
        JR	NC,J.3BB5
;
        AND	0DFH
        LD	(DE),A
J.3BB5:	INC	DE
        DJNZ	J$3BA9
;
        LD	B,40H	; "@"
J$3BBA:	CALL	C.3B45
;
        PUSH	BC
        LD	HL,D.FC18
        LD	A,(HL)
        AND	A
        JR	Z,J.3BD6
;
        LD	DE,I.F866
        LD	B,0BH	; 11 
J$3BCA:	LD	A,(DE)
        CP	(HL)
        JR	NZ,J.3BD6
;
        INC	DE
        INC	HL
        DJNZ	J$3BCA
;
        XOR	A
        POP	BC
        JR	J$3BDA
;
;	-----------------
J.3BD6:	POP	BC
        DJNZ	J$3BBA
;
        INC	B
J$3BDA:	LD	A,(D.FC28)
        POP	DE
        POP	HL
        RET	
;
;	-----------------
;
;	  Subroutine __________________________
;	     Inputs  ________________________
;	     Outputs ________________________
;
C.3BE0:	OR	37H	; "7"
C.3BE1	EQU	$-1
        PUSH	AF
        PUSH	IY
        POP	HL
        LD	BC,I.0009
        ADD	HL,BC
        PUSH	HL
        LD	BC,(D.FC24)
        CALL	C.3B93
;
        LD	HL,C.0018
        ADD	HL,BC
        LD	A,L
        AND	3FH	; "?"
        OR	40H	; "@"
        LD	D,A
        LD	E,00H
        ADD	HL,HL
        ADD	HL,HL
        LD	A,02H	; 2 
        ADD	A,H
        CP	04H	; 4 
        JR	NC,J$3C09
;
        XOR	01H	; 1 
J$3C09:	OUT	(0FDH),A
        POP	HL
        POP	AF
        JR	C,J$3C10
;
        EX	DE,HL
J$3C10:	LD	BC,I.0100
;
;	  Subroutine __________________________
;	     Inputs  ________________________
;	     Outputs ________________________
;
C.3C13:	EXX	
        LD	HL,D.FFFF
        LD	A,(D.FD09)
        LD	D,A
        RRCA	
        RRCA	
        AND	0C0H
        LD	C,A
        RRCA	
        RRCA	
        RRCA	
        RRCA	
        OR	C
        LD	C,A
        IN	A,(0A8H)
        LD	B,A
        AND	33H	; "3"
        OR	C
        LD	E,A
        DI	
        OUT	(0A8H),A
        LD	A,D
        AND	0CH	; 12 
        LD	D,A
        LD	A,(HL)
        CPL	
        LD	C,A
        AND	0F3H
        OR	D
        LD	(HL),A
        LD	A,E
        AND	3FH	; "?"
        LD	D,A
        LD	A,B
        AND	0C0H
        OR	D
        EI	
        OUT	(0A8H),A
        EXX	
        LDIR	
        EXX	
        LD	A,E
        DI	
        OUT	(0A8H),A
        LD	A,C
        LD	(HL),A
        LD	A,B
        EI	
        OUT	(0A8H),A
        EXX	
I$3C55:	PUSH	AF
        LD	A,02H	; 2 
        JR	J$3C5D
;
;	-----------------
;
;	  Subroutine __________________________
;	     Inputs  ________________________
;	     Outputs ________________________
;
C.3C5A:	PUSH	AF
        LD	A,03H	; 3 
J$3C5D:	OUT	(0FDH),A
        POP	AF
        RET	
;
;	-----------------
;
;	  Subroutine __________________________
;	     Inputs  ________________________
;	     Outputs ________________________
;
C.3C61:	PUSH	HL
        POP	IY
        PUSH	HL
        XOR	A
        LD	(D$F864),HL
        LD	(HL),E
        INC	HL
        LD	(HL),B
        INC	HL
        INC	HL
        LD	(HL),A
        INC	HL
        INC	HL
        LD	(HL),A
        INC	HL
        LD	(HL),A
        INC	HL
        LD	(HL),A
        POP	HL
        RET	
;
;	-----------------
;
;	  Subroutine __________________________
;	     Inputs  ________________________
;	     Outputs ________________________
;
C$3C78:	CALL	C.05FC
;
        LD	A,(D.F663)
        CP	03H	; 3 
        JP	Z,J.0546
;
        CP	02H	; 2 
        JR	NZ,J$3C96
;
        LD	DE,(D.F7F8)
        INC	DE
        LD	A,D
        RLCA	
        RLCA	
        AND	03H	; 3 
        RES	7,D
        RES	6,D
        RET	
;
;	-----------------
J$3C96:	PUSH	HL
        LD	BC,I$1041
        LD	DE,C.0000
        LD	IX,I.324E
        CALL	C.001C
;
        LD	HL,(D.F7F6)
        LD	DE,(D.F7F8)
        PUSH	HL
        PUSH	DE
        PUSH	HL
        PUSH	DE
        LD	HL,I$1645
        LD	(D.F7F6),HL
        LD	HL,I.4038
        LD	(D.F7F8),HL
        POP	DE
        POP	BC
        LD	IX,I$3267
        CALL	C.001C
;
        LD	HL,(D.F7F6)
        PUSH	HL
        LD	HL,(D.F7F8)
J$3CC9	EQU	$-2
        PUSH	HL
        LD	IX,I$30DB
        CALL	C.001C
;
        LD	BC,I$16C5
        LD	DE,I.4038
        LD	IX,I.325C
        CALL	C.001C
;
        POP	BC
        POP	HL
        POP	DE
        EX	(SP),HL
        PUSH	BC
        LD	C,L
        LD	B,H
        LD	IX,I.324E
        CALL	C.001C
;
        LD	IX,I$2F8A
        CALL	C.001C
;
        POP	DE
        POP	BC
        PUSH	HL
        LD	(D.F7F6),BC
        LD	(D.F7F8),DE
        LD	A,04H	; 4 
        LD	(D.F663),A
        LD	IX,I$5211
        CALL	C.001C
;
        JP	NZ,J.0546
;
        LD	A,E
        POP	DE
        POP	HL
        RET	
;
;	-----------------
;
;	  Subroutine __________________________
;	     Inputs  ________________________
;	     Outputs ________________________
;
C$3D13:	LD	DE,I.0100
        LD	IX,I$3193
        CALL	C.001C
;
;
;	  Subroutine __________________________
;	     Inputs  ________________________
;	     Outputs ________________________
;
C$3D1D:	LD	IX,I$3425
        CALL	C.001C
;
        JP	C.05F6
;
;	-----------------
;
;	  Subroutine __________________________
;	     Inputs  ________________________
;	     Outputs ________________________
;
C.3D27:	CALL	C.3BA2
;
        JP	NZ,J.055E
;
        AND	A
        RET	Z
;
J$3D2F:	LD	E,40H	; "@"
        JR	J.3D3B
;
;	-----------------
;
;	  Subroutine __________________________
;	     Inputs  ________________________
;	     Outputs ________________________
;
C.3D33:	LD	A,(D.FD09)
        BIT	6,A
        RET	NZ
;
        LD	E,46H	; "F"
J.3D3B:	XOR	A
        LD	(D$F87C),A
        PUSH	DE
        CALL	C$05C0
;
        POP	DE
        JP	J.05C6
;
;	-----------------
I$3D47:	LD	BC,I$3D6A
J$3D4A:	LD	A,(BC)
        INC	BC
        OR	A
        RET	Z
;
        SUB	E
        JR	Z,J$3D55
;
        INC	BC
        INC	BC
        JR	J$3D4A
;
;	-----------------
J$3D55:	LD	L,C
        LD	H,B
        LD	E,(HL)
        INC	HL
        LD	D,(HL)
        LD	HL,D.F55E
        PUSH	HL
        LD	(HL),A
J$3D5F:	INC	DE
        INC	HL
        LD	A,(DE)
        LD	(HL),A
        OR	A
        JR	NZ,J$3D5F
;
        POP	HL
        LD	E,01H	; 1 
        RET	
;
;	-----------------
I$3D6A:	INC	A
        LD	A,A
        DEC	A
        DEC	A
        ADD	A,A
        DEC	A
        LD	B,B
        SUB	L
        DEC	A
        LD	B,C
        AND	L
        DEC	A
        LD	B,D
        CP	C
        DEC	A
        LD	B,E
        RST	00H
;
        DEC	A
        LD	B,(HL)
        SUB	3DH	; "="
        NOP	
        LD	B,D
        LD	H,C
        LD	H,H
        JR	NZ,J$3DCB
;
        LD	B,C
        LD	D,H
        NOP	
        LD	B,D
        LD	H,C
        LD	H,H
        JR	NZ,J$3DF3
;
        LD	L,C
        LD	L,H
        LD	H,L
        JR	NZ,J$3DFF
;
        LD	L,A
        LD	H,H
        LD	H,L
        NOP	
        LD	B,(HL)
        LD	L,C
        LD	L,H
        LD	H,L
        JR	NZ,J$3E0F
;
        LD	(HL),H
        LD	L,C
        LD	L,H
        LD	L,H
        JR	NZ,J$3E11
;
        LD	(HL),B
        LD	H,L
        LD	L,(HL)
        NOP	
        LD	B,(HL)
        LD	L,C
        LD	L,H
        LD	H,L
        JR	NZ,J$3E0D
;
        LD	L,H
        LD	(HL),D
        LD	H,L
        LD	H,C
        LD	H,H
        LD	A,C
        JR	NZ,J$3E19
;
        LD	A,B
        LD	L,C
        LD	(HL),E
        LD	(HL),H
        LD	(HL),E
        NOP	
        LD	D,D
        LD	B,C
J$3DBC:	LD	C,L
        JR	NZ,J.3E23
;
        LD	L,C
        LD	(HL),E
        LD	L,E
        JR	NZ,J$3E2A
;
        LD	(HL),L
        LD	L,H
        LD	L,H
J.3DC7:	NOP	
        LD	D,H
        LD	L,A
        LD	L,A
J$3DCB:	JR	NZ,J$3E3A
;
        LD	H,C
        LD	L,(HL)
        LD	A,C
        JR	NZ,J$3E38
;
        LD	L,C
        LD	L,H
        LD	H,L
        LD	(HL),E
        NOP	
        LD	D,D
        LD	B,C
        LD	C,L
        JR	NZ,J$3E40
;
        LD	L,C
        LD	(HL),E
        LD	L,E
        JR	NZ,J$3E50
;
        LD	H,(HL)
        LD	H,(HL)
        LD	L,H
        LD	L,C
        LD	L,(HL)
        LD	H,L
        NOP	
        LD	D,L
        JR	NZ,J$3DF2
;
        LD	A,0E2H
        CALL	C.3EBC
;
        JR	J.3DC7
;
;	-----------------
J$3DF2:	LD	A,B
J$3DF3:	LD	E,C
        CALL	C$3E3D
;
        JR	J.3DC7
;
;	-----------------
;
;	  Subroutine __________________________
;	     Inputs  ________________________
;	     Outputs ________________________
;
C$3DF9:	CALL	C$3E29
;
        LD	B,A
        ADD	A,A
        ADD	A,A
J$3DFF:	ADD	A,B
        LD	D,A
        LD	A,E
        CALL	C$3E2F
;
        ADD	A,D
        LD	L,A
        LD	A,D
        CP	0FH	; 15 
        JR	NC,J$3E10
;
        LD	A,L
J$3E0D:	SUB	70H	; "p"
J$3E0F:	RET	
;
;	-----------------
J$3E10:	CP	23H	; "#"
J$3E11	EQU	$-1
        JR	NC,J$3E18
;
        LD	A,L
        SUB	30H	; "0"
        RET	
;
;	-----------------
J$3E18:	LD	A,L
J$3E19:	SUB	23H	; "#"
        LD	BC,I$3F71
        JR	J.3E23
;
;	-----------------
;
;	  Subroutine __________________________
;	     Inputs  ________________________
;	     Outputs ________________________
;
C.3E20:	LD	BC,I$3F16
J.3E23:	LD	L,A
        LD	H,00H
        ADD	HL,BC
        LD	A,(HL)
        RET	
;
;	-----------------
;
;	  Subroutine __________________________
;	     Inputs  ________________________
;	     Outputs ________________________
;
C$3E29:	CALL	C.3E20
J$3E2A	EQU	$-2
;
        AND	0FH	; 15 
        RET	
;
;	-----------------
;
;	  Subroutine __________________________
;	     Inputs  ________________________
;	     Outputs ________________________
;
C$3E2F:	CALL	C.3E20
;
        SUB	14H	; 20 
        CP	01H	; 1 
        JR	C,J$3E3B
;
J$3E38:	CP	06H	; 6 
J$3E3A:	RET	C
;
J$3E3B:	XOR	A
        RET	
;
;	-----------------
;
;	  Subroutine __________________________
;	     Inputs  ________________________
;	     Outputs ________________________
;
C$3E3D:	LD	D,A
        CALL	C.3E20
J$3E40	EQU	$-1
;
        CP	0BH	; 11 
        JR	NC,J$3E48
;
        LD	A,D
        JR	J$3E8A
;
;	-----------------
J$3E48:	CP	21H	; "!"
        JR	C,J.3E58
;
        CP	26H	; "&"
        JR	NC,J.3E58
;
J$3E50:	LD	A,D
        CALL	C.3EB9
;
;
;	  Subroutine __________________________
;	     Inputs  ________________________
;	     Outputs ________________________
;
C.3E54:	LD	A,0DEH
        JR	C.3EBC
;
;	-----------------
J.3E58:	LD	A,D
        CP	50H	; "P"
        JR	NZ,J$3E67
;
        LD	A,48H	; "H"
        CALL	C.3EB9
;
        LD	A,0DFH
        JP	C.3EBC
;
;	-----------------
J$3E67:	CP	4AH	; "J"
        JR	NZ,J$3E79
;
        LD	A,9CH
        PUSH	DE
        CALL	C.3EBC
;
        CALL	C.3E54
;
        POP	DE
        LD	C,E
        JP	J$3DBC
;
;	-----------------
J$3E79:	CP	46H	; "F"
        JR	NZ,J$3E8C
;
        LD	A,0ECH
        PUSH	DE
        CALL	C.3EBC
;
J$3E83:	POP	DE
        LD	A,E
        CP	55H	; "U"
        RET	Z
;
J.3E88:	LD	A,4CH	; "L"
J$3E8A:	JR	C.3EB9
;
;	-----------------
J$3E8C:	CP	59H	; "Y"
        JR	NZ,J$3E96
;
        CALL	C.3EB9
;
        LD	A,E
        JR	J$3EA2
;
;	-----------------
J$3E96:	CP	57H	; "W"
        JR	NZ,J$3EA7
;
        CALL	C.3EB9
;
        LD	A,E
        CP	49H	; "I"
        JR	Z,J.3E88
;
J$3EA2:	CP	45H	; "E"
        RET	NZ
;
        JR	J.3E88
;
;	-----------------
J$3EA7:	CP	56H	; "V"
        JR	NZ,J$3EB7
;
        LD	A,55H	; "U"
        PUSH	DE
        CALL	C$3EB6
;
        CALL	C.3E54
;
        JR	J$3E83
;
;	-----------------
;
;	  Subroutine __________________________
;	     Inputs  ________________________
;	     Outputs ________________________
;
C$3EB6:	LD	E,A
J$3EB7:	LD	A,51H	; "Q"
;
;	  Subroutine __________________________
;	     Inputs  ________________________
;	     Outputs ________________________
;
C.3EB9:	CALL	C$3DF9
;
;
;	  Subroutine __________________________
;	     Inputs  ________________________
;	     Outputs ________________________
;
C.3EBC:	LD	HL,D.FAFC
        BIT	7,(HL)
        JR	Z,J.3ED1
;
        CP	0E0H
        JR	C,J$3ECB
;
        SUB	20H	; " "
        JR	J.3ED1
;
;	-----------------
J$3ECB:	CP	0A0H
        JR	NC,J.3ED1
;
        ADD	A,20H	; " "
J.3ED1:	LD	HL,(D.F3F8)
        LD	(HL),A
        INC	HL
        LD	A,L
        CP	18H
        JR	NZ,J$3EDE
;
        LD	HL,I$FBF0
J$3EDE:	LD	A,(D$F3FA)
        CP	L
        RET	Z
;
        LD	(D.F3F8),HL
        RET	
;
;	-----------------
?.3EE7:	LD	A,(D.F3DB)
        AND	A
        RET	Z
;
        LD	A,(D.FBD9)
        AND	A
        RET	NZ
;
        LD	A,0FH	; 15 
        LD	(D.FBD9),A
        DI	
        OUT	(0ABH),A
        LD	A,0AH	; 10 
J$3EFB:	DEC	A
        JR	NZ,J$3EFB
;
        LD	A,0EH	; 14 
        OUT	(0ABH),A
        EI	
        RET	
;
;	-----------------
J$3F04:	LD	HL,D.FAFC
        BIT	0,(HL)
        JR	Z,J$3F10
;
        RES	0,(HL)
        XOR	A
        JR	J.3F29
;
;	-----------------
J$3F10:	LD	A,(D.FCAC)
        INC	A
        JR	Z,J$3F26
;
I$3F16:	LD	A,(D.FBEB)
        RRCA	
        JR	C,J$3F24
;
        XOR	A
        LD	(D$FAF9),A
        SET	0,(HL)
        JR	J.3F29
;
;	-----------------
J$3F24:	LD	A,0FFH
J$3F26:	LD	(D.FCAC),A
J.3F29:	PUSH	AF
        LD	A,0FH	; 15 
        OUT	(0A0H),A
        IN	A,(0A2H)
        AND	7FH
        LD	B,A
        POP	AF
        OR	A
        LD	A,80H
        JR	Z,J$3F3A
;
        XOR	A
J$3F3A:	OR	B
        OUT	(0A1H),A
        RET	
;
;	-----------------
?.3F3E:	LD	HL,(D$5D3A)
        LD	E,A
        CCF	
        LD	A,7BH	; "{"
        LD	A,L
        LD	E,H
        LD	B,B
        LD	A,3FH	; "?"
        LD	E,E
        INC	A
        LD	A,E
        LD	A,L
        OR	B
        SBC	A,0A1H
        AND	L
        RST	18H
;
        AND	H
        AND	D
        AND	E
        LD	A,(BC)
        DEC	D
        DEC	H
        JR	Z,J$3F7E
;
        JR	J$3F9D
;
;	-----------------
?.3F5D:	LD	HL,I$1605
        LD	C,E
        LD	BC,I$060A
        INC	B
        ADD	HL,DE
        JR	Z,J$3FE8
;
        EX	AF,AF'
        LD	(BC),A
        INC	BC
        RLA	
        LD	B,B
        LD	C,C
        ADC	A,H
        LD	B,A
        LD	(D$F4FD),HL
I$3F71	EQU	$-2
        SUB	D
        PUSH	AF
        SUB	D
        OR	0F7H
        RET	M
;
        LD	SP,HL
        JP	M,J$FCFB
;
        SUB	E
J$3F7E:	SUB	E
        SUB	E
        ADD	A,(HL)
        ADD	A,A
        ADC	A,B
        ADC	A,C
        ADC	A,D
        ADC	A,E
        ADC	A,H
        ADC	A,B
        ADC	A,L
        ADC	A,D
        ADC	A,(HL)
        DEFB	0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0
J$3F9D:	DEFB	0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0
        DEFB	0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0
        DEFB	0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0
I$3FD7:	DEFB	0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0
J$3FE8:	DEFB	0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0
        DEFB	0,0,0,0
        END
0
I$3FD7:	DEFB	0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0
J$3FE8:	DEFB	0,0,0,0,0,0,0,0,0,0,0,0,