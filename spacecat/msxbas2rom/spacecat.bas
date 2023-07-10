INCLUDE "levels.inc"

FILE "cls.plet5"
FILE "loading.plet5"
FILE "start.plet5"

FILE "spacecat.chr.plet5" ' IDX: 27
FILE "spacecat.clr.plet5"

FILE "loading.chr.plet5"' IDX: 29
FILE "loading.clr.plet5"

FILE "lselect.chr.plet5"' IDX: 31
FILE "lselect.clr.plet5"

FILE "ending.chr.plet5"' IDX: 33
FILE "ending.clr.plet5"

FILE "sprites.bin.plet5"

FILE "help_1.plet5"' IDX: 36
FILE "help_2.plet5"
FILE "help_3.plet5"
FILE "help_4.plet5"
FILE "help_5.plet5"
FILE "help_6.plet5"

FILE "bad_end.plet5" 'IDX: 42
FILE "good_end.plet5"
FILE "best_end.plet5"
FILE "end_common.plet5"

1 COLOR 2,1,1: SCREEN 2,2,0
10 DEFINT B-W
21 DIM LL(24)
23 DIM MX(3),MY(3),CS(4)

24 CMD WRTSCR 24
27 CMD WRTSPRPAT 35

30 LT=0:L=0
31 FOR I=0 TO 23
32  LL(I)=-1
33 NEXT I

50 GOTO 3500

100 ' LOAD SCREEN AND SPRITES
110 CMD WRTCHR 27
111 CMD WRTCLR 28

190 FOR I=0 to 4: PUT SPRITE I,,0:NEXT
191 IF L=24 THEN L=23:GOTO 6000
192 CMD WRTSCR L

195 ' M IS EXIT MODE: -1 = FAIL, >=0 = SUCCESS, NUMBER OF MICE (0-3)

199 MC=0:LT=144:GOSUB 1100:GOSUB 1000

200 PUT SPRITE 4,,0,0

300 X=16:Y=148:AX=0:AY=0:LP=0:LS=1
310 FOR I=&H1860 TO &H1B00
311   VP = VPEEK(I)
312   IF VP=160 THEN X=(I MOD 32)*8+8:Y=((I-&H1800)\32)*8-28
313   IF VP=62 OR VP=63 THEN LP=1
319 NEXT I

350 IF LP=1 THEN SOUND 8, &B11111 ELSE SOUND 8,0
351 SOUND 9, 0
361 SOUND 7, &B10101010
362 SOUND 1,&H4:SOUND 0,&H80
364 SOUND 11,&H80
365 SOUND 12,&H04
366 SOUND 13, 12
367 SOUND 6, &B01101

500 ' MAIN LOOP
510 TIME=0
600 ' DRAW LOOP
610 PUT SPRITE 0,(X,Y),15,CS(CA)
620 PUT SPRITE 1,(X-8,Y+14),4,4
630 PUT SPRITE 2,(X+8,Y+14),4,5
640 PUT SPRITE 3,,0
650 IF BD>0 THEN PUT SPRITE 3,(X,Y+27),BD,SD
660 IF BL>0 THEN PUT SPRITE 3,(X-24,Y+14),BL,SD
670 IF BR>0 THEN PUT SPRITE 3,(X+24,Y+14),BR,SD

700 ' INPUT MANAGEMENT
710 BD=0:BR=0:BL=0
720 S=STICK(SS)
730 IF S=1 OR S=8 OR S=2 THEN BD=10:AY=AY-.2:SD=16+FIX(RND(1)*4)
740 IF S=7 THEN BR=10:AX=AX-.22:SD=8+FIX(RND(1)*2)
750 IF S=3 THEN BL=10:AX=AX+.22:SD=6+FIX(RND(1)*2)

760 IF BD=0 AND BR=0 AND BL=0 THEN SOUND 9,0 ELSE SOUND 9, 12

800 ' UPDATE LOOP
810 AY=AY+.1
820 AX=AX*.96:IF ABS(AX)<0.05 THEN AX=0
830 X=X+AX
840 Y=Y+AY
850 TT=TT+1
855 IF TT MOD 3 = 0 THEN GOSUB 1200
860 IF TT MOD 5 = 0 THEN CA=CA+1: IF CA=4 THEN CA=0:IF RND(1)<0.6 THEN ON FIX(RND(1)*4) GOSUB 1010,1020,1030 ELSE GOSUB 1000
870 IF TT MOD 40 = 0 THEN GOSUB 1100

900 ' COLLISION CLASHING / CORRECTION
910 IF AY>0 THEN 920 ELSE 930
920 T1=&H1800+((Y+23)\8)*&H20+(X-8)\8
921 T2=&H1800+((Y+27)\8)*&H20+(X)\8
923 T3=&H1800+((Y+27)\8)*&H20+(X+16)\8
924 T4=&H1800+((Y+23)\8)*&H20+(X+23)\8
925 T5=&H1800+((Y+27)\8)*&H20+(X+8)\8
929 GOTO 940
930 T1=&H1800+((Y+16)\8)*&H20+(X-8)\8
931 T2=&H1800+((Y)\8)*&H20+(X)\8
932 T3=&H1800+((Y)\8)*&H20+(X+16)\8
934 T4=&H1800+((Y+16)\8)*&H20+(X+23)\8
935 T5=&H1800+((Y)\8)*&H20+(X+8)\8
939 GOTO 940

940 IF AX>0 THEN 950 ELSE 960
950 U1=&H1800+((Y)\8)*&H20+(X+16)\8
952 U2=&H1800+((Y+16)\8)*&H20+(X+23)\8
954 U3=&H1800+((Y+23)\8)*&H20+(X+23)\8
956 U4=&H1800+((Y+27)\8)*&H20+(X+16)\8
957 U5=&H1800+((Y+8)\8)*&H20+(X+16)\8
959 GOTO 970
960 U1=&H1800+((Y)\8)*&H20+(X)\8
962 U2=&H1800+((Y+16)\8)*&H20+(X-8)\8
964 U3=&H1800+((Y+23)\8)*&H20+(X-8)\8
966 U4=&H1800+((Y+27)\8)*&H20+(X)\8
967 U5=&H1800+((Y+8)\8)*&H20+(X)\8
969 GOTO 970

970 C1=VPEEK(T1):C2=VPEEK(T2):C3=VPEEK(T3):C4=VPEEK(T4):C5=VPEEK(T5)
971 D1=VPEEK(U1):D2=VPEEK(U2):D3=VPEEK(U3):D4=VPEEK(U4):D5=VPEEK(U5)

972 IF C1>64 OR C2>64 OR C3>64 OR C4>64 OR C5>64 THEN IF ABS(AY)>1.2 THEN GOTO 1700 ELSE Y=Y-AY:AY=0
973 IF D1>64 OR D2>64 OR D3>64 OR D4>64 OR D5>64 THEN IF ABS(AX)>1.2 THEN GOTO 1700 ELSE X=X-AX:AX=0

974 'Checking for mice (nmouse start is either 19 or 21, it depends of the value, should go in sets of 2 (19-20/51-52) (21-22/53-54)
975 IF C1>=19 AND C1<=54 THEN MP=T1:C0=C1:GOSUB 1300
976 IF C2>=19 AND C2<=54 THEN MP=T2:C0=C2:GOSUB 1300
977 IF C3>=19 AND C3<=54 THEN MP=T3:C0=C3:GOSUB 1300
978 IF C4>=19 AND C4<=54 THEN MP=T4:C0=C4:GOSUB 1300
979 IF C5>=19 AND C5<=54 THEN MP=T5:C0=C5:GOSUB 1300

980 IF D1>=19 AND D1<=54 THEN MP=U1:C0=D1:GOSUB 1300
981 IF D2>=19 AND D2<=54 THEN MP=U2:C0=D2:GOSUB 1300
982 IF D3>=19 AND D3<=54 THEN MP=U3:C0=D3:GOSUB 1300
983 IF D4>=19 AND D4<=54 THEN MP=U4:C0=D4:GOSUB 1300
984 IF D5>=19 AND D5<=54 THEN MP=U5:C0=D5:GOSUB 1300

985 'TODO Move before line 972
986 IF LS=0 GOTO 988
987 IF C1=62 OR C2=62 OR C3=62 OR C4=62 OR C5=62 OR D1=62 OR D2=62 OR D3=62 OR D4=62 OR D5=62 OR C1=63 OR C2=63 OR C3=63 OR C4=63 OR C5=63 OR D1=63 OR D2=63 OR D3=63 OR D4=63 OR D5=63 THEN 1700

988 ' Check finish pad
989 IF C2>=164 AND C2<=167 AND C3>=164 AND C3<=167 AND AY=0 THEN GOTO 1900
990 IF FX>0 THEN FX=FX-1: IF FX=0 THEN READ FX,A,B: SOUND 5,A: SOUND 4,B: IF A=0 AND B=0 THEN FX=0: SOUND 10,0
998 IF TIME<3 GOTO 998
999 GOTO 500

1000 CS(0)=0:CS(1)=1:CS(2)=2:CS(3)=3:RETURN
1010 CS(0)=3:CS(1)=25:CS(2)=25:CS(3)=3:RETURN
1020 CS(0)=3:CS(1)=26:CS(2)=26:CS(3)=3:RETURN
1030 CS(0)=0:CS(1)=24:CS(2)=23:CS(3)=24:RETURN

1100 ' SWAP LASER STATE color at tiles 62, 63,from &H89 to 00. Color table starts at &H2000
1120 IF LS=1 THEN LC=&H00:LS=0 ELSE LC=&H89:LS=1
1150 FOR I=&H21F0 TO &H21FF 
1160  VPOKE I, LC:VPOKE I+&H800, LC: VPOKE I+&H1000, LC
1170 NEXT I
1180 ' Lasers ON enable sound on channel 3 with sound generator
1181 IF LC=0 THEN SOUND 8, 0 ELSE IF LP=1 THEN SOUND 8, &B11111
1199 RETURN

1200 'ANIMATE LASER, we have 4 patterns, they all have the same colors, tile 144-147, bae address for the copy is tile 62 -> 62*8=496 -> 0x1F0
1210 LT=LT+1:IF LT=148 THEN LT=144
1220 FOR I=0 TO 7
1230  LR=VPEEK(LT*8+I): LM=VPEEK(LT*8+I+32)
1240  VPOKE &H1F0+I, LR:VPOKE I+&H9F0, LR: VPOKE I+&H11F0, LR
1241  VPOKE &H1F8+I, LM:VPOKE I+&H9F8, LM: VPOKE I+&H11F8, LM
1250 NEXT I
1299 RETURN

1300 ' Capture mouse subroutine
1301 IF C0>32 THEN MP=MP-32
1302 IF C0 MOD 2 = 0 THEN MP=MP-1
1307 IF VPEEK(MP)>0 THEN MC=MC+1 ELSE RETURN
1308 VPOKE MP,0:VPOKE MP+1,0:VPOKE MP+&H20,0:VPOKE MP+&H21,0
1309 FX=1: SOUND 10,15: RESTORE 1400
1310 RETURN

1399 ' SOUND FOR CATCHING MICE
1400 DATA 2, &H00, &H55, 2, &H00, &H40, 0, 0, 0

1690 ' TEST OVER DIALOG (RETRY / MENU)
1691 DATA 10,11,11,11,11,11, 11, 11, 11, 11, 11, 11, 11, 11, 11,12
1692 DATA 13,14,14,14,14,13,223,217,222,223, 14,220,250,217,221,15
1693 DATA 13,14,14,14,14,13, 17, 17, 17, 17, 17, 17, 17, 17, 17,15
1694 DATA 13,40,41,42,14,13, 14, 14, 14, 14, 14, 14, 14, 14, 14,15
1695 DATA 13,43,44,45,14,13, 14, 14,221,217,223,221,252, 14, 14,15
1696 DATA 13,46,47,48,14,13, 14, 14, 14, 14, 14, 14, 14, 14, 14,15
1697 DATA 13,14,14,14,14,13, 14, 14,218,217,219,249, 14, 14, 14,15
1698 DATA 16,17,17,17,17,17, 17, 17, 17, 17, 17, 17, 17, 17, 17,18

1699 ' TEST OVER DIALOG DISPLAY
1700 PUT SPRITE 3,,0:PUT SPRITE 0,,,15:SOUND 8,0:SOUND 9,0:SOUND 5,0: SOUND 4,0
1701 TIME=0
1702 sound 8, &B11111
1703 SOUND 1, &H08: SOUND 0, &H00
1704 SOUND 12,&H30: SOUND 11, &H80
1705 SOUND 13, 3
1706 IF TIME<100 GOTO 1706
1707 PUT SPRITE 0,,0: PUT SPRITE 1,(72,75),0,13: PUT SPRITE 2,(72,75+16),0,14: PUT SPRITE 3,(72,75+32),0,13
1708 RESTORE 1691
1709 FOR I=&H1900 TO &H19E0 STEP &H20: FOR J=8 TO 23: READ V:VPOKE I+J,V:NEXT J:NEXT I
1710 M=-1:GOTO 2920

1890 ' TEST PASSED DIALOG (NEXT / RETRY / MENU)
1891 DATA 10,11,11,11,11,11,11,11,11,11,11,11,11,11,11,12
1892 DATA 13,14,14,14,14,13,14,14,14,14,14,14,14,14,14,15
1893 DATA 13, 6, 7,14,14,13,14,14,219,217,251,223,14,14,14,15
1894 DATA 13,14,14,14,14,13,14,14,14, 14, 14, 14 ,14,14,14,15
1895 DATA 13,38,39,14,14,13,14,14,221,217,223,221,252,14,14,15
1896 DATA 13,14,14,14,14,13,14,14,14 ,14 ,14 ,14 ,14,14,14,15
1897 DATA 13, 6, 7,14,14,13,14,14,218,217,219,249,14,14,14,15
1898 DATA 16,17,17,17,17,17,17,17,17,17,17,17,17,17,17,18

1899 ' TEST PASSED DIALOG DISPLAY
1900 PUT SPRITE 3,,0:SOUND 8,&B11000:SOUND 9,0: SOUND 12,&H0: SOUND 11, &H80:SOUND 5,0: SOUND 4,0:RESTORE 2000:FX=1
1901 TIME=0:AX=-1:YY=Y
1902 'JUMP, LAND AND SMILE
1903 AX=AX+.05:YY=YY+AX
1904 PUT SPRITE 0,(X,YY),,0

1905 IF TIME MOD 4 <> 0 GOTO 1905
1906 IF FX>1 THEN FX=FX-1 ELSE IF FX=1 THEN READ R1, R0:SOUND 0, R0:SOUND 1, R1:SOUND 13,13: IF R1=0 AND R0=0 THEN FX=0 ELSE FX=8

1907 IF YY<Y GOTO 1903
1908 FOR I=20 TO 22:PUT SPRITE 0,,,I:TIME=0
1909   IF TIME<12 GOTO 1909 
1910 NEXT I

1917 PUT SPRITE 0,,,23
1918 SOUND 12, &H0:SOUND 11, &HFF: SOUND 13, 4
1919 IF TIME<100 GOTO 1919

1921 PUT SPRITE 0,,0: PUT SPRITE 1,(72,75),0,13: PUT SPRITE 2,(72,75+16),0,14: PUT SPRITE 3,(72,75+32),0,13
1922 RESTORE 1891
1923 FOR I=&H1900 TO &H19E0 STEP &H20: FOR J=8 TO 23: READ V:VPOKE I+J,V:NEXT J:NEXT I
1925 IF MC>0 THEN PUT SPRITE 1,,8
1926 IF MC>1 THEN PUT SPRITE 2,,8
1927 IF MC>2 THEN PUT SPRITE 3,,8
1929 M=MC:GOTO 2920

2000 DATA &H1,&HAC,&H1,&H1D, &H0,&HFE, &H1,&H1D, &H1,&H1D
2010 DATA &H0, &H0

2920 ' GENERAL EXIT POINT TO LOAD NEXT LEVEL
2922 IF M>LL(L) THEN LL(L)=M
2923 Y=0
2930 IF M=-1 GOTO 2960

2940 ' HANDLING OF TEST PASSED OPTIONS
2941 PUT SPRITE 0, (112, 79+Y), 10, 12
2942 S=STICK(SS)
2943 IF S<>R THEN R=S ELSE GOTO 2946
2944 IF S=1 THEN Y=Y-16: IF Y<0 THEN Y=32
2945 IF S=5 THEN Y=Y+16: IF Y>32 THEN Y=0
2946 IF STRIG(SS) THEN IF Y=32 THEN CMD WRTSCR 24:GOTO 4100 ELSE IF Y=0 THEN L=L+1: GOTO 190 ELSE GOTO 190
2950 GOTO 2940

2960 ' HANDLING OF TEST OVER OPTIONS
2961 PUT SPRITE 0, (112, 95+Y), 10, 12
2970 S=STICK(SS)
2971 IF S<>R THEN R=S: IF S<>0 THEN IF Y=16 THEN Y=0 ELSE Y=16
2972 IF STRIG(SS) THEN IF Y=16 THEN CMD WRTSCR 24:GOTO 4100 ELSE GOTO 190
2980 GOTO 2960

3500 ' START.BAS
3501 CMD WRTSCR 24
3502 CMD WRTCHR 29
3503 CMD WRTCLR 30

3508 STRIG(0) ON: STRIG(1) ON
3509 ON STRIG GOSUB 3990, 3990

3600 'Prepare the initial position
3610 FOR I=0 to 3
3620  FOR K=0 TO 3
3621   VPOKE &H1800+262+I+K*32,152+I*32+K
3622  NEXT K
3623 NEXT I

3700 ' Scroll up 32 times (push everything up and add a line at the bottom on the 4 tiles)
3710 FOR I=0 TO 31
3711 TIME=0
3712  FOR J=1 TO 31
3713   FOR K=0 TO &H300 STEP &H100
3721    VPOKE &HCBF+J+K, VPEEK(&HCC0+J+K)
3723    VPOKE &H2CBF+J+K, VPEEK(&H2CC0+J+K)
3747   NEXT K
3748  NEXT J
3750  FOR K=0 TO &H300 STEP &H100
3752   VPOKE &HCDF+K, VPEEK(&H4E0+I+K)
3754   VPOKE &H2CDF+K, VPEEK(&H2CE0+I+K)
3796  NEXT K
3797 IF TIME<1 GOTO 3797
3798 NEXT I

3800 FOR I=0 TO 8
3809  TIME = 0
3810  FOR K=0 TO I
3820   VPOKE &H192A+K,172-I+K:VPOKE &H194A+K,204-I+K::VPOKE &H196A+K,236-I+K
3830  NEXT K
3831  IF TIME<2 GOTO 3831
3840 NEXT I
3900 FOR I=0 TO 5
3909  TIME = 0
3910  FOR K=0 TO I
3920   VPOKE &H1933+K,178-I+K:VPOKE &H1953+K,210-I+K::VPOKE &H1973+K,242-I+K
3930  NEXT K
3931  IF TIME<2 GOTO 3931
3940 NEXT I

3950 TIME=0
3960 IF TIME<75 GOTO 3960

3990 STRIG(0) OFF: STRIG(1) OFF
3991 CMD WRTSCR 24
3999 GOTO 5000

4100 ' LEVEL SELECT
4101 FOR I=0 to 4: PUT SPRITE I,,0:NEXT
4102 CMD WRTSCR 24
4103 CMD WRTCHR 31
4104 CMD WRTCLR 32
4110 X=8+((L) MOD 6)*40: Y=8+((L)\6)*40

4119 LA=1
4120 'DISPLAY THE LEVELS AS THEY ARE
4121 ' LA: Level Available
4122 ' IA: Initial address for VPOKE of the level in screen
4123 ' LI: Level Initial value on the name table for the row
4124 FOR I=0 TO 23
4125  LI=1: IF LL(I)=-1 THEN LA=LA-1: IF LA<0 THEN LI=10
4126  IA=&H1800+(I MOD 6)*5 + 1 + (I\6)*&HA0 + &H20
4127  VPOKE IA, LI:VPOKE IA+1, LI+1:VPOKE IA+2, LI+1: VPOKE IA+3, LI+1:VPOKE IA+4, LI+2
4128  'Level number is st 2nd and 3rd slots on the 2nd and 3rd column
4129  IA=IA+&H20:LI=LI+3:LN=LI+1
4130  IF I>=19 THEN LN=43 ELSE IF I>=9 THEN LN=42
4131  LD=32+(I MOD 10): IF I>=9 THEN LD=LD+10
4132  IF LA<0 THEN LN=LN+&H40:LD=LD+&H40: IF I<9 THEN LN=LI+1
4133  VPOKE IA, LI:VPOKE IA+1, LN:VPOKE IA+2, LD: VPOKE IA+3, LI+1:VPOKE IA+4, LI+2
4134  IA=IA+&H20:LD=LD+&H20: IF LN>40 THEN LN=LN+&H20
4135  VPOKE IA, LI:VPOKE IA+1, LN:VPOKE IA+2, LD: VPOKE IA+3, LI+1:VPOKE IA+4, LI+2

4140  'PAWS
4141  IA=IA+&H20:IF LL(I)>0 THEN LI=150+LL(I)*10 ELSE GOTO 4160
4142  VPOKE IA, LI:VPOKE IA+1, LI+1:VPOKE IA+2, LI+2: VPOKE IA+3, LI+3:VPOKE IA+4, LI+4
4150  IA=IA+&H20:LI=LI+5
4151  VPOKE IA, LI:VPOKE IA+1, LI+1:VPOKE IA+2, LI+2: VPOKE IA+3, LI+3:VPOKE IA+4, LI+4
4152  GOTO 4190
4159 ' Level without paws (not started, unavailable, or 0 stars)
4160  LN=LI+1: IF LL(I)=-1 THEN LN=20: IF LA>-1 THEN LN=19
4161  VPOKE IA, LI:VPOKE IA+1, LI+1:VPOKE IA+2, LN: VPOKE IA+3, LI+1:VPOKE IA+4, LI+2
4162  IA=IA+&H20:LI=LI+3
4163  VPOKE IA, LI:VPOKE IA+1, LI+1:VPOKE IA+2, LI+1: VPOKE IA+3, LI+1:VPOKE IA+4, LI+2
4190 NEXT I

4200 ON STRIG GOSUB 4500, 4500:STRIG(0) ON: STRIG(1) ON

4220 PUT SPRITE 0,(X,Y-1),10,27
4230 PUT SPRITE 1,(X+24,Y-1),10,28
4240 PUT SPRITE 2,(X,Y+23),10,29
4250 PUT SPRITE 3,(X+24,Y+23),10,30

4320 PS=S
4321 S=STICK(SS)
4322 IF S=PS GOTO 4321
4330 IF S=1 THEN Y=Y-40: IF Y<8 THEN Y=8
4340 IF S=3 THEN X=X+40: IF X>208 THEN IF Y<128 THEN X=8:Y=Y+40 ELSE X=208
4350 IF S=5 THEN Y=Y+40: IF Y>128 THEN Y=128
4360 IF S=7 THEN X=X-40: IF X<8 THEN IF Y>8 THEN X=208: Y=Y-40 ELSE X=8

4460 GOTO 4220

4499 'Level loading screen
4500 STRIG(0) OFF:STRIG(1) OFF
4501 ' LS of the previous level needs to be <>-1 (Maybe play a wrong sound)
4502 SL=(X-8)\40+(Y-8)*6\40
4503 IF SL>1 THEN IF LL(SL-1)=-1 THEN GOTO 4200
4510 PUT SPRITE 0,,0:PUT SPRITE 1,,0:PUT SPRITE 2,,0:PUT SPRITE 3,,0
4519 L=SL:CMD WRTSCR 24
4590 GOTO 100

5000 PUT SPRITE 0,,0:Y=0
5002 CMD WRTSCR 26
5003 IF STRIG(0) OR STRIG(1) GOTO 5003

5010 ON STRIG GOSUB 5090, 5091
5011 STRIG(0) ON: STRIG(1) ON

5020 ' HANDLING  OPTIONS
5030 PUT SPRITE 0, (104, 135+Y), 10, 12
5041 S0=STICK(0)
5042 IF S0<>R0 THEN R0=S0 ELSE GOTO 5046
5043 IF R0=1 THEN Y=Y-16: IF Y<0 THEN Y=16
5044 IF R0=5 THEN Y=Y+16: IF Y>16 THEN Y=0

5046 S1=STICK(1)
5047 IF S1<>R1 THEN R1=S1 ELSE GOTO 5020
5048 IF R1=1 THEN Y=Y-16: IF Y<0 THEN Y=16
5049 IF R1=5 THEN Y=Y+16: IF Y>16 THEN Y=0
5050 GOTO 5020

5089 'SAVE JOYSTICK / KEYBOARD selection
5090 STRIG(0) OFF: STRIG(1) OFF: IF Y=0 THEN SS=0: GOTO 5100 ELSE GOTO 5300
5091 STRIG(0) OFF: STRIG(1) OFF: IF Y=0 THEN SS=1: GOTO 5100 ELSE GOTO 5300
5099 'Put level selection in VRAM info
5100 PUT SPRITE 0,,0:CMD WRTSCR 24
5101 PLAY "o4L8cdefefgbo5d", "o3L8cR32L4dfR16L16dR32L4e"
5120 GOTO 4100

5300 'HELP
5301 HP=1: PUT SPRITE 0, , 0
5302 IF STRIG(0) OR STRIG(1) GOTO 5302
5310 CMD WRTSCR HP+35
5320 S=STICK(0)
5321 IF S<>R0 THEN R0=S:GOSUB 5610 ELSE GOTO 5324
5322 IF S=3 THEN GOSUB 5510:HP=HP+1: IF HP>6 THEN HP=1: GOTO 5310 ELSE GOTO 5310
5323 IF S=7 THEN GOSUB 5560:HP=HP-1: IF HP=0 THEN HP=6: GOTO 5310 ELSE GOTO 5310
5324 S=STICK(1)
5325 IF S<>R1 THEN R1=S:GOSUB 5610 ELSE GOTO 5330
5326 IF S=3 THEN GOSUB 5510:HP=HP+1: IF HP>6 THEN HP=1: GOTO 5310 ELSE GOTO 5310
5327 IF S=7 THEN GOSUB 5560:HP=HP-1: IF HP=0 THEN HP=6: GOTO 5310 ELSE GOTO 5310

5330 IF STRIG(0) OR STRIG(1) GOTO 5002
5500 GOTO 5320

5510 PUT SPRITE 0,(221,85),10,27
5520 PUT SPRITE 1,(236,85),10,28
5530 PUT SPRITE 2,(221,99),10,29
5540 PUT SPRITE 3,(236,99),10,30
5550 RETURN
5560 PUT SPRITE 0,(5,85),10,27
5570 PUT SPRITE 1,(20,85),10,28
5580 PUT SPRITE 2,(5,99),10,29
5590 PUT SPRITE 3,(20,99),10,30
5600 RETURN
5610 PUT SPRITE 0,,0:PUT SPRITE 1,,0:PUT SPRITE 2,,0:PUT SPRITE 3,,0:RETURN

6000 'END.bas

6100 'LOAD THE END SCREEN
6101 CMD WRTSCR 24:
6102 CMD WRTCHR 33
6103 CMD WRTCLR 34
6104 CMD WRTSCR 45
6109 ' PRINT THE SCORE ON THE SCREEN
6110 TM=0:FOR I=0 TO 23:TM=TM+LL(I):NEXT

6111 'F is <35, then in changes of 6, 3 mice get a +.Rank is 0 for F, 1 for E... 3 for C (B is minimum for certified pilot) ...6 for S
6112 RK = (TM - 36) \ 6

6120 IF TM=72 THEN VPOKE &H1920+19, 114 ELSE VPOKE &H1920+19, 101-RK
6121 IF TM MOD 6 >= 3 THEN VPOKE &H1920+20, 43
6190 TD = TM \ 10
6191 TU = TM MOD 10
6200 IF TD > 0 THEN VPOKE &H1980+19,33+TD: VPOKE &H1980+20,33+TU ELSE VPOKE &H1980+19,33+TU

6300 'CERTIFIED PILOT STAMP
6301 IF TM<60 THEN CMD WRTVRAM 42,&H19A0 ELSE IF TM=72 THEN CMD WRTVRAM 44,&H19A0 :PLAY "S9M3050L4O1B" ELSE CMD WRTVRAM 43,&H19A0 :PLAY "S9M3050L4O1B"

6420 IF INKEY$<>"" THEN 6420
6421 IF INKEY$="" AND NOT STRIG(1) THEN 6421

6430 GOTO 3500
