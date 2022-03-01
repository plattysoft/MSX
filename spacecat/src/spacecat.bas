10 DEFINT B-W

20 L=VPEEK (0)
21 DIM LS(24)
22 FOR I=0 TO 23 STEP 2
23  LT=VPEEK((I\2*32)+1)
24  LS(I)=LT\16-1:LS(I+1)=(LT MOD 16)-1
25 NEXT I

100 ' LOAD SCREEN AND SPRITES
110 COLOR 15,1,1:SCREEN 2,2,0
111 BLOAD "spacecat.sc2",S
112 'FOR I=0 TO 31: PUT SPRITE I,(I*16, Y-16),0,0:NEXT I
113 'L=3
130 'DEFDBL AX,AY,X,Y

140 REM -- LOAD SPRITES
141 S=&H3800
142 READ R$: IF R$="*" THEN GOTO 190 
143 VPOKE S,VAL("&H"+R$):S=S+1
144 GOTO 142

190 BLOAD "level_"+CHR$(64+L)+".scr",S

191 CALL TURBO ON
192 DIM MX(3),MY(3)
193 DEFINT B-W

195 XX=64:YY=0:YM=0

200 PUT SPRITE 4,,0,0
210 FOR I=&H1860 TO &H1B00
211   IF VPEEK(I)=160 THEN X=(I MOD 32)*8+8:Y=((I-&H1800)\32)*8-28
212   IF VPEEK(I)=153 THEN XX=(I MOD 32)*8+4:YY=((I-&H1800)\32)*8-4:YM=-1:YL=YY:YK=YY-48: PUT SPRITE 4,(XX,YY),10,10:VPOKE I,0:VPOKE I+1,0: VPOKE I+2, 0
219 NEXT I

300 X=16:Y=148:AX=0:AY=0

500 ' MAIN LOOP
510 TIME=0
600 ' DRAW LOOP
601 'SPRITE OFF
610 PUT SPRITE 0,(X,Y),15,CS
620 PUT SPRITE 1,(X-8,Y+14),4,4
630 PUT SPRITE 2,(X+8,Y+14),4,5
640 PUT SPRITE 3,(-16,-16),0,6
650 IF BD>0 THEN PUT SPRITE 3,(X,Y+16),BD,6
660 IF BL>0 THEN PUT SPRITE 3,(X-14,Y+16),BL,7
670 IF BR>0 THEN PUT SPRITE 3,(X+14,Y+16),BR,8
680 PUT SPRITE 4,(XX,YY)
699 'SPRITE ON

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
880 YY=YY+YM:IF YY>YL THEN YM=YM-.1 ELSE IF YY<YK THEN YM=YM+.1
881 IF YM<>0 THEN VPOKE &H1800+((YY+16)\8)*&H20+(XX+8)\8, 156:VPOKE &H1800+((YY+8)\8)*&H20+(XX+8)\8, 0

900 ' COLLISION CLASHING / CORRECTION
910 IF AY>0 THEN 920 ELSE 930
920 T1=&H1800+((Y+23)\8)*&H20+(X-8)\8
921 T2=&H1800+((Y+27)\8)*&H20+(X)\8
923 T3=&H1800+((Y+27)\8)*&H20+(X+16)\8
924 T4=&H1800+((Y+23)\8)*&H20+(X+23)\8
929 GOTO 940
930 T1=&H1800+((Y+16)\8)*&H20+(X-8)\8
931 T2=&H1800+((Y)\8)*&H20+(X)\8
932 T3=&H1800+((Y)\8)*&H20+(X+16)\8
934 T4=&H1800+((Y+16)\8)*&H20+(X+23)\8
939 GOTO 940

940 IF AX>0 THEN 950 ELSE 960
950 U1=&H1800+((Y)\8)*&H20+(X+16)\8
952 U2=&H1800+((Y+16)\8)*&H20+(X+23)\8
954 U3=&H1800+((Y+23)\8)*&H20+(X+23)\8
956 U4=&H1800+((Y+27)\8)*&H20+(X+16)\8
959 GOTO 970
960 U1=&H1800+((Y)\8)*&H20+(X)\8
962 U2=&H1800+((Y+16)\8)*&H20+(X-8)\8
964 U3=&H1800+((Y+23)\8)*&H20+(X-8)\8
966 U4=&H1800+((Y+27)\8)*&H20+(X)\8
969 GOTO 970

970 C1=VPEEK(T1):C2=VPEEK(T2):C3=VPEEK(T3):C4=VPEEK(T4)
971 D1=VPEEK(U1):D2=VPEEK(U2):D3=VPEEK(U3):D4=VPEEK(U4)


975 IF C1>64 OR C2>64 OR C3>64 OR C4>64 THEN IF ABS(AY)>1.2 THEN GOTO 1000 ELSE Y=Y-AY:AY=0
976 IF D1>64 OR D2>64 OR D3>64 OR D4>64 THEN IF ABS(AX)>1.2 THEN GOTO 1000 ELSE X=X-AX:AX=0

977 IF C1=21 THEN MP=T1:GOSUB 1300
978 IF C2=21 THEN MP=T2:GOSUB 1300
979 IF C3=21 THEN MP=T3:GOSUB 1300
980 IF C4=21 THEN MP=T4:GOSUB 1300
981 IF D1=21 THEN MP=U1:GOSUB 1300
982 IF D2=21 THEN MP=U2:GOSUB 1300
983 IF D3=21 THEN MP=U3:GOSUB 1300
984 IF D4=21 THEN MP=U4:GOSUB 1300


985 ' TODO: Range for instant kill 176 and up
986 IF LS=0 GOTO 988
987 IF C1=62 OR C2=62 OR C3=62 OR C4=62 OR D1=62 OR D2=62 OR D3=62 OR D4=62 OR C1=63 OR C2=63 OR C3=63 OR C4=63 OR D1=63 OR D2=63 OR D3=63 OR D4=63 THEN 1000

988 ' Check finish pad
989 IF C2>=164 AND C2<=167 AND C3>=164 AND C3<=167 AND AY=0 THEN GOTO 1900
990 IF TIME<3 GOTO 990
999 GOTO 500

1000 PUT SPRITE 0,,8
1010 ' TODO: We need to reloacate the mice  
1010 IF STRIG(0) GOTO 300 ELSE GOTO 1010

1100 ' SWAP LASER STATE color at 62,63, 126, 127, 158, 159, from CB to 00 and 6A to 60, color table starts at &H2000
1120 IF LS=1 THEN LC=&H00:LS=0 ELSE LC=&H89:LS=1
1150 FOR I=&H2000+62*8 TO &H2000+64*8 
1160  VPOKE I, LC:VPOKE I+&H800, LC: VPOKE I+&H1000, LC
1170 NEXT I
1199 RETURN

1200 'SPRITE OFF
1210 IF X<90 THEN PUT SPRITE 4,(0,0),0
1220 IF X>90 AND X<160 THEN PUT SPRITE 5,(16,0),0
1230 IF X>160 THEN PUT SPRITE 6,(16,0),0
1250 RETURN

1300 ' TODO: Use a different tile to mark this, so mice can be reloaded without reloading the screen
1300 VPOKE MP,0:VPOKE MP+1,0:VPOKE MP+&H20,0:VPOKE MP+&H21,0
1310 RETURN

1900 PUT SPRITE 0,,10
1901 'SPRITE OFF
1910 CALL TURBO OFF
1911 LS(L)=L MOD 4
1912 FOR I=0 TO 23 STEP 2
1913  VPOKE (I\2)*32+1, (LS(I)+1)*16+(LS(I+1)+1)
1914 NEXT I
1920 L=L+1
1930 IF STRIG(0) THEN run"start.bas"
1940 GOTO 1930

2000 DATA 18,3C,3C,7F,E7,CB,DB,DB,67,3F,1F,1F,1F,1F,1F,1F
2010 DATA 30,78,78,FC,CE,96,B6,B6,CC,F8,F0,F0,F0,F0,FF,FF
2020 DATA 18,3C,3C,7F,E7,CB,DB,DB,67,3F,1F,1F,1F,1F,1F,1F
2030 DATA 30,78,78,FC,CE,96,B6,B6,CC,F8,F0,F0,F0,F7,FF,FC
2040 DATA 18,3C,3C,7F,E7,CB,DB,DB,67,3C,1C,1E,1F,1F,1F,1F
2050 DATA 30,78,78,FC,CE,96,B6,B6,CC,78,70,F0,F6,F6,FE,FC
2060 DATA 18,3C,3C,7F,E7,CB,DB,DB,67,3F,1F,1F,1F,1F,1F,1F
2070 DATA 30,78,78,FC,CE,96,B6,B6,CC,F8,F0,F0,F0,F3,FF,FE

2000 DATA 00,0C,14,24,7F,7F,7F,7D,FF,76,F9,3F,03,07,0F,7F
2010 DATA 00,30,28,24,FE,FE,FE,BE,FF,6E,9F,FC,C0,E0,F0,70
2020 DATA 00,0C,14,24,7F,7F,7F,7D,FF,76,F9,3F,03,07,4F,3F
2030 DATA 00,30,28,24,FE,FE,FE,BE,FF,6E,9F,FC,C0,E0,F0,70
2040 DATA 0C,14,24,7F,7F,7F,7D,FF,72,F0,38,0F,03,07,0F,7F
2050 DATA 30,28,24,FE,FE,FE,BE,FF,4E,0F,1C,F0,C0,E0,F0,70
2060 DATA 00,0C,14,24,7F,7F,7F,7D,FF,76,F9,3F,03,07,0F,7F
2070 DATA 00,30,28,24,FE,FE,FE,BE,FF,6E,9F,FC,C0,E0,F0,70

2080 DATA 03,1F,7F,FF,99,FF,7F,1F,03,00,00,00,00,00,00,00
2090 DATA 00,00,FF,FF,99,FF,FF,FF,E0,1F,3B,7C,F3,00,00,00
2100 DATA 00,00,FF,FF,99,FF,FF,FF,07,F8,DC,3E,C7,00,00,00
2110 DATA C0,F8,FE,FF,99,FF,FE,F8,C0,00,00,00,00,00,00,00

2120 DATA 00,00,00,00,00,00,00,00,00,00,00,03,06,07,03,01
2130 DATA 00,00,00,00,00,00,00,00,00,00,00,80,C0,C0,80,00
2140 DATA 00,30,78,F8,30,00,00,00,00,00,00,00,00,00,00,00
2150 DATA 00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00
2160 DATA 00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00
2170 DATA 00,0C,1E,1F,0C,00,00,00,00,00,00,00,00,00,00,00

2200 DATA 60,F1,B0,DF,DF,7B,1B,1F,5F,9C,9F,7F,00,00,00,00
2210 DATA C0,E0,E0,60,A0,40,60,F0,E8,00,C0,C0,00,00,00,00

2220 DATA 0F,3C,7B,F7,FB,0D,0D,0D,0D,0D,0D,0D,0D,0D,0D,0D
2230 DATA F0,3C,DE,EF,DF,B0,B0,B0,B0,B0,B0,B0,B0,B0,B0,B0

2240 DATA 0D,0D,0D,0D,0D,0D,0D,0D,0D,0D,0D,FB,F7,7B,3C,0F
2250 DATA B0,B0,B0,B0,B0,B0,B0,B0,B0,B0,B0,DF,EF,DE,3C,F0

2990 DATA *
