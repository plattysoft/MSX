10 DEFINT B-W

20 L=VPEEK (0)
21 DIM LS(24)
22 FOR I=0 TO 23 STEP 2
23  LT=VPEEK(I\2+1)
24  LS(I)=LT\16-1:LS(I+1)=(LT MOD 16)-1
25 NEXT I

100 ' LOAD SCREEN AND SPRITES
110 COLOR 15,1,1:SCREEN 2,2,0
111 BLOAD "spacecat.sc2",S
113 'L=3
131 M=0

140 bload"sprites.bin",s

190 BLOAD "level_"+CHR$(64+L)+".scr",S
191 FOR I=0 to 4: PUT SPRITE I,,0:NEXT

192 ' M IS EXIT MODE: -1 = FAIL, >=0 = SUCCESS, NUMBER OF MICE (0-3)
192 CALL TURBO ON(M)
193 DIM MX(3),MY(3)
194 DEFINT B-W

195 MC=0

200 PUT SPRITE 4,,0,0

300 X=16:Y=148:AX=0:AY=0
310 FOR I=&H1860 TO &H1B00
311   IF VPEEK(I)=160 THEN X=(I MOD 32)*8+8:Y=((I-&H1800)\32)*8-28
319 NEXT I

500 ' MAIN LOOP
510 TIME=0
600 ' DRAW LOOP
610 PUT SPRITE 0,(X,Y),15,CS
620 PUT SPRITE 1,(X-8,Y+14),4,4
630 PUT SPRITE 2,(X+8,Y+14),4,5
640 PUT SPRITE 3,,0
650 IF BD>0 THEN PUT SPRITE 3,(X,Y+16),BD,6
660 IF BL>0 THEN PUT SPRITE 3,(X-14,Y+16),BL,7
670 IF BR>0 THEN PUT SPRITE 3,(X+14,Y+16),BR,8

700 ' INPUT MANAGEMENT
710 BD=0:BR=0:BL=0
720 S=STICK(0)
730 IF S=1 THEN BD=10:AY=AY-.2
740 IF S=7 THEN BR=10:AX=AX-.2
750 IF S=3 THEN BL=10:AX=AX+.2

800 ' UPDATE LOOP
810 AY=AY+.1
820 AX=AX*.95
830 X=X+AX
840 Y=Y+AY
850 TT=TT+1
860 IF TT MOD 5 = 0 THEN CS=CS+1: IF CS=4 THEN CS=0
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

975 IF C1=21 THEN MP=T1:GOSUB 1300
976 IF C2=21 THEN MP=T2:GOSUB 1300
977 IF C3=21 THEN MP=T3:GOSUB 1300
978 IF C4=21 THEN MP=T4:GOSUB 1300
979 IF C5=21 THEN MP=T5:GOSUB 1300

980 IF D1=21 THEN MP=U1:GOSUB 1300
981 IF D2=21 THEN MP=U2:GOSUB 1300
982 IF D3=21 THEN MP=U3:GOSUB 1300
983 IF D4=21 THEN MP=U4:GOSUB 1300
984 IF D5=21 THEN MP=U5:GOSUB 1300

985 ' TODO: Range for instant kill 176 and up, TODO Move before line 972
986 IF LS=0 GOTO 988
987 IF C1=62 OR C2=62 OR C3=62 OR C4=62 OR C5=62 OR D1=62 OR D2=62 OR D3=62 OR D4=62 OR D5=62 OR C1=63 OR C2=63 OR C3=63 OR C4=63 OR C5=63 OR D1=63 OR D2=63 OR D3=63 OR D4=63 OR D5=63 THEN 1700

988 ' Check finish pad
989 IF C2>=164 AND C2<=167 AND C3>=164 AND C3<=167 AND AY=0 THEN GOTO 1900
990 IF TIME<3 GOTO 990
999 GOTO 500

1100 ' SWAP LASER STATE color at 62,63, 126, 127, 158, 159, from CB to 00 and 6A to 60, color table starts at &H2000
1120 IF LS=1 THEN LC=&H00:LS=0 ELSE LC=&H89:LS=1
1150 FOR I=&H2000+62*8 TO &H2000+64*8 
1160  VPOKE I, LC:VPOKE I+&H800, LC: VPOKE I+&H1000, LC
1170 NEXT I
1199 RETURN

1300 ' Capture mouse subroutine
1300 IF VPEEK(MP)>0 THEN MC=MC+1 ELSE RETURN
1301 VPOKE MP,0:VPOKE MP+1,0:VPOKE MP+&H20,0:VPOKE MP+&H21,0
1310 RETURN

1691 ' TEST OVER DIALOG (RETRY / MENU)
1691 DATA 10,11,11,11,11,11, 11, 11, 11, 11, 11, 11, 11, 11, 11,12
1692 DATA 13,14,14,14,14,13,223,217,222,223, 14,220,250,217,221,15
1693 DATA 13,14,14,14,14,13, 17, 17, 17, 17, 17, 17, 17, 17, 17,15
1694 DATA 13,40,41,42,14,13, 14, 14, 14, 14, 14, 14, 14, 14, 14,15
1695 DATA 13,43,44,45,14,13, 14, 14,221,217,223,221,252, 14, 14,15
1696 DATA 13,46,47,48,14,13, 14, 14, 14, 14, 14, 14, 14, 14, 14,15
1697 DATA 13,14,14,14,14,13, 14, 14,218,217,219,249, 14, 14, 14,15
1698 DATA 16,17,17,17,17,17, 17, 17, 17, 17, 17, 17, 17, 17, 17,18

1700 ' TEST OVER DIALOG DISPLAY
1700 PUT SPRITE 0,,0
1701 PUT SPRITE 1,(72,75),0,13: PUT SPRITE 2,(72,75+16),0,14: PUT SPRITE 3,(72,75+32),0,13
1702 RESTORE 1691
1703 FOR I=&H1800+&H20*8 TO &H1800+&H20*15 STEP &H20: FOR J=8 TO 23: READ V:VPOKE I+J,V:NEXT J:NEXT I
1710 M=-1:GOTO 1910

1891 ' TEST PASSED DIALOG (NEXT / RETRY / MENU)
1891 DATA 10,11,11,11,11,11,11,11,11,11,11,11,11,11,11,12
1892 DATA 13,14,14,14,14,13,14,14,14,14,14,14,14,14,14,15
1893 DATA 13, 6, 7,14,14,13,14,14,219,217,251,223,14,14,14,15
1894 DATA 13,14,14,14,14,13,14,14,14, 14, 14, 14 ,14,14,14,15
1895 DATA 13,38,39,14,14,13,14,14,221,217,223,221,252,14,14,15
1896 DATA 13,14,14,14,14,13,14,14,14 ,14 ,14 ,14 ,14,14,14,15
1897 DATA 13, 6, 7,14,14,13,14,14,218,217,219,249,14,14,14,15
1898 DATA 16,17,17,17,17,17,17,17,17,17,17,17,17,17,17,18

1900 ' TEST PASSED DIALOG DISPLAY
1900 PUT SPRITE 0,,0
1901 PUT SPRITE 1,(72,75),0,13: PUT SPRITE 2,(72,75+16),0,14: PUT SPRITE 3,(72,75+32),0,13
1902 RESTORE 1891
1903 FOR I=&H1800+&H20*8 TO &H1800+&H20*15 STEP &H20: FOR J=8 TO 23: READ V:VPOKE I+J,V:NEXT J:NEXT I
1905 IF MC>0 THEN PUT SPRITE 1,,8
1906 IF MC>1 THEN PUT SPRITE 2,,8
1907 IF MC>2 THEN PUT SPRITE 3,,8
1909 M=MC:GOTO 1910

1910 ' GENERAL EXIT POINT TO LOAD NEXT LEVEL
1910 CALL TURBO OFF
1911 IF M>LS(L-1) THEN LS(L-1)=M
1912 ' SAVE LEVEL VALUES
1912 FOR I=0 TO 23 STEP 2
1913  VPOKE I\2+1, (LS(I)+1)*16+(LS(I+1)+1)
1914 NEXT I
1915 IF M=-1 GOTO 1960

1940 ' HANDLING OF TEST PASSED OPTIONS
1940 PUT SPRITE 0, (112, 79+Y), 10, 12
1941 S=STICK(0)
1942 IF S<>R THEN R=S ELSE GOTO 1945
1943 IF S=1 THEN Y=Y-16: IF Y<0 THEN Y=32
1944 IF S=5 THEN Y=Y+16: IF Y>32 THEN Y=0
1945 IF STRIG(0) THEN IF Y=32 THEN run"lselect.bas" ELSE IF Y=0 THEN L=L+1: GOTO 190 ELSE GOTO 190
1950 GOTO 1940

1960 ' HANDLING OF TEST OVER OPTIONS
1960 PUT SPRITE 0, (112, 95+Y), 10, 12
1970 S=STICK(0)
1971 IF S<>R THEN R=S: IF S<>0 THEN IF Y=16 THEN Y=0 ELSE Y=16
1972 IF STRIG(0) THEN IF Y=16 THEN RUN"lselect.bas" ELSE GOTO 190
1980 GOTO 1960
