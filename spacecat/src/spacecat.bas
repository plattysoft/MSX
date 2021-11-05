10 DEFINT B-W

100 ' LOAD SCREEN AND SPRITES
110 COLOR 15,1,1:SCREEN 2,2,0
111 BLOAD "spacecat.sc2",S
112 FOR I=0 TO 31: PUT SPRITE I,(I*16, Y-16),0,0:NEXT I
115 CALL TURBO ON
116 DIM MX(3),MY(3)
130 'DEFDBL AX,AY,X,Y
140 GOSUB 10000
190 X=16:Y=148:AX=0:AY=0
191 MX(1)=60:MY(1)=128:MX(2)=120:MY(2)=96:MX(3)=180:MY(3)=112

200 ON SPRITE GOSUB 1200
210 PUT SPRITE 4,(MX(1),MY(1)),14,9
220 PUT SPRITE 5,(MX(2),MY(2)),14,9
230 PUT SPRITE 6,(MX(3),MY(3)),14,9

500 ' MAIN LOOP
510 TIME=0
600 ' DRAW LOOP
601 SPRITE OFF
610 PUT SPRITE 0,(X,Y),15,CS
620 PUT SPRITE 1,(X-8,Y+14),4,4
630 PUT SPRITE 2,(X+8,Y+14),4,5
640 PUT SPRITE 3,(-16,-16),0,6
650 IF BD>0 THEN PUT SPRITE 3,(X,Y+16),BD,6
660 IF BL>0 THEN PUT SPRITE 3,(X-14,Y+16),BL,7
670 IF BR>0 THEN PUT SPRITE 3,(X+14,Y+16),BR,8
690 'PUT SPRITE 5,(50,100),14,9
699 SPRITE ON

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

900 ' COLLISION CLASHING / CORRECTION
910 IF AY>0 THEN 920 ELSE 930
920 C1=VPEEK(&H1800+((Y+23)\8)*&H20+(X-8)\8):C2=VPEEK(&H1800+((Y+27)\8)*&H20+(X)\8)
921 C3=VPEEK(&H1800+((Y+27)\8)*&H20+(X+16)\8):C4=VPEEK(&H1800+((Y+23)\8)*&H20+(X+23)\8)
929 GOTO 940
930 C1=VPEEK(&H1800+((Y+16)\8)*&H20+(X-8)\8):C2=VPEEK(&H1800+((Y)\8)*&H20+(X)\8)
931 C3=VPEEK(&H1800+((Y)\8)*&H20+(X+16)\8):C4=VPEEK(&H1800+((Y+16)\8)*&H20+(X+23)\8)
939 GOTO 940

940 IF AX>0 THEN 950 ELSE 960
950 D1=VPEEK(&H1800+((Y)\8)*&H20+(X+16)\8):D2=VPEEK(&H1800+((Y+16)\8)*&H20+(X+23)\8)
951 D3=VPEEK(&H1800+((Y+23)\8)*&H20+(X+23)\8):D4=VPEEK(&H1800+((Y+27)\8)*&H20+(X+16)\8)
959 GOTO 970
960 D1=VPEEK(&H1800+((Y)\8)*&H20+(X)\8):D2=VPEEK(&H1800+((Y+16)\8)*&H20+(X-8)\8)
961 D3=VPEEK(&H1800+((Y+23)\8)*&H20+(X-8)\8):D4=VPEEK(&H1800+((Y+27)\8)*&H20+(X)\8)
969 GOTO 970


970 IF C1>64 OR C2>64 OR C3>64 OR C4>46 THEN IF ABS(AY)>1.2 THEN GOTO 1100 ELSE Y=Y-AY:AY=0
980 IF D1>64 OR D2>64 OR D3>64 OR D4>64 THEN IF ABS(AX)>1.2 THEN GOTO 1100 ELSE X=X-AX:AX=0
989 IF C2=129 AND C3=129 AND AY=0 THEN GOSUB 1000
990 IF TIME<3 GOTO 990
999 GOTO 500

1000 PUT SPRITE 0,,10
1010 IF STRIG(0) GOTO 190 ELSE GOTO 1010

1100 PUT SPRITE 0,,8
1110 IF STRIG(0) GOTO 190 ELSE GOTO 1110

1200 IF X<90 THEN PUT SPRITE 4,(0,0),0
1210 IF X>90 AND X<160 THEN PUT SPRITE 5,(0,0),0
1220 IF X>160 THEN PUT SPRITE 6,(0,0),0
1290 RETURN

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
2990 DATA *

10000 REM -- LOAD SPRITES
10010 S=&H3800
10020 READ R$: IF R$="*" THEN RETURN ELSE VPOKE S,VAL("&H"+R$):S=S+1:GOTO 10020

