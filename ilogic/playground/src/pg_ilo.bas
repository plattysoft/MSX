10 COLOR 15,1,1
20 screen 2,2,0
30 BLOAD "ilogic.sc2",s
40 defint A-Z
1010 BLOAD "sprites.bin",S
1020 FOR I=0 TO 31:PUT SPRITE I,((I MOD 16)*20,132+(I\16)*16),0,0:NEXT I

1200 R=0:C=0

1500 SJ=0:PS%=0:SX=46:SY=80:SV=0:TH=0:TV=0
1510 'MOVE TO ANOTHER ROOM
1510 BLOAD "map_"+CHR$(C+48)+"_"+CHR$(R+48)+".scr",S
1520 call turbo ON(SX,SY,SV,SJ,R,C)

1540 RU=VPEEK(&H1800+722)
1550 IF RU=249 THEN GOSUB 6500 ELSE GOSUB 7500

1560 TV=VPEEK(&H1800+725)-250+70
1570 GOSUB 8000

1800 ON SPRITE GOSUB 5410

1990 X=SX:Y=SY:VY%=SV%:PJ%=SJ%:SPRITE ON
2000 T=TIME+5
2010 ON STICK(0) GOTO 2100,2200,2300,2020,2020,2020,2700,2800
2020 IF PJ%=1 THEN PJ%=2
2030 IF VX<>0 THEN VX=VX*0.9
2090 GOTO 3000
2100 IF PJ%=0 THEN VY%=-5:PJ%=1
2110 IF PJ%=2 THEN VY%=-5:PJ%=3
2120 IF PS%>=2 THEN PS%=2 ELSE PS%=0
2190 GOTO 3000
2200 IF PJ%=0 THEN VY%=-5:VX=4:PJ%=1 ELSE VX=VX+1: IF VX>4 THEN VX=4
2210 IF PJ%=2 THEN VY%=-5:PJ%=3
2230 PS%=0
2290 GOTO 3000
2300 IF PJ%=0 THEN VX=4 ELSE VX=VX+1: IF VX>4 THEN VX=4
2310 IF PJ%=1 THEN PJ%=2
2320 IF PS%=0 AND PJ%=0 THEN PS%=1 ELSE PS%=0
2390 GOTO 3000
2700 IF PJ%=0 THEN VX=-4 ELSE VX=VX-1: IF VX<-4 THEN VX=-4
2710 IF PJ%=1 THEN PJ%=2
2720 IF PS%=2 AND PJ%=0 THEN PS%=3 ELSE PS%=2
2790 GOTO 3000
2800 IF PJ%=0 THEN VY%=-5:PJ%=1:VX=-4 ELSE VX=VX-1: IF VX<-4 THEN VX=-4
2810 IF PJ%=2 THEN VY%=-5:PJ%=3
2830 PS%=2
2890 GOTO 3000
3000 'End of movement loop 
3100 'Check for floor tiles at 3 points under the sprite Y+16,(X, X+8, X+15)'
3100 Y=Y+VY%
3200 IF VY%>=0 THEN TY=((Y+16)\8)*32 ELSE TY=(Y\8)*32
3300 TV=VPEEK(&H1800+(X+7)\8+TY)
3310 TW=VPEEK(&H1800+(X+2)\8+TY)
3320 TU=VPEEK(&H1800+(X+12)\8+TY)
3330 IF TU>63 OR TV>63 OR TW>63 THEN IF VY%>=0 THEN GOTO 3400 ELSE GOTO 3450
3340 IF PJ%=0 THEN PJ%=-1
3350 VY%=VY%+1:IF VY%>8 THEN VY%=8
3360 GOTO 3500
3400 PJ%=0:VY%=0:Y=Y-(Y MOD 8)
3410 GOTO 3500
3450 VY%=0:Y=Y+8-(Y MOD 8)
3500 ' CONVOY BELT BEHAVIOUR 
3510 IF TV>=128 AND TV<=132 THEN VX=VX-4
3520 IF TV>=133 AND TV<=139 THEN VX=VX-2
3530 IF TV>=146 AND TV<=151 THEN VX=VX+2
3540 IF TV>=152 AND TV<=157 THEN VX=VX+4
3600 ' Check for death tiles TH. TI, TG
3600 IF VX=0 THEN TH=0: TI=0: TG=0: GOTO 3700
3610 IF VX>0 THEN TX=&H1800+(X+15)\8 ELSE TX=&H1800+(X-1)\8
3620 TH=VPEEK(TX+((Y+7)\8)*32)
3630 TI=VPEEK(TX+((Y+12)\8)*32)
3640 TG=VPEEK(TX+((Y+2)\8)*32)
3650 IF TH>63 OR TI>63 OR TG>63 THEN VX=0
3660 X=X+VX:IF PJ%=0 THEN VX=0
3700 IF (TV>=96 AND TV<=125) OR (TW>=96 AND TW<=125) OR (TU>=96 AND TU<=125) THEN GOTO 5000
3710 IF (TH>=96 AND TH<=125) OR (TI>=96 AND TI<=125) OR (TG>=96 AND TG<=125) THEN GOTO 5000
3800 ' Move to another room
3800 IF TH=31 THEN X=6:C=C+1:GOTO 9500
3810 IF TH=30 THEN X=234:C=C-1:GOTO 9500
3920 ' We substract VY from the desired Y position to be compensated on next loop
3820 IF TV=6 THEN Y=8-VY%:R=R+1:GOTO 9500
3830 IF TV=5 THEN Y=104-VY%:R=R-1:GOTO 9500

3850 'Check collecting item
3850 TZ=VPEEK(&H1800+(X+8)\8+((Y+10)\8)*32)
3860 IF TZ>31 AND TZ<64 THEN GOTO 5100

3900 PUT SPRITE 0,(X,Y-1),6,PS%

4000 IF STICK(0)=5 AND PJ%=0 THEN GOTO 6000

4900 IF TIME<T GOTO 4900
4910 GOTO 9000
4980 IF TIME>=60 THEN TIME=0

4990 GOTO 2000

5000 'Lost a life
5090 GOTO 1990

5100 ' Collect an item
5100 VPOKE &H1800+(X+8)\8+((Y+10)\8)*32, 0
5110 FOR I=0 TO 1
5120   FOR J=0 TO 2
5130     IF VPEEK(&H1800+2+I*2+(19+J*2)*32)=0 THEN VPOKE &H1800+2+I*2+(19+J*2)*32,TZ:TZ=0
5140   NEXT J
5150 NEXT I
5190 GOTO 3900

5410 'Sprite collision, lose a life
5410 PUT SPRITE 0,(0,0),0,0
5420 SPRITE OFF
5490 GOTO 5000

6000 ' SWITCH RED AND BLUE TILES
6100 IF TV=69 THEN GOSUB 6500: VPOKE &H1800+722, 249
6200 IF TV=70 THEN GOSUB 7500: VPOKE &H1800+722, 248
6210 IF TV>70 AND TV<76 THEN GOSUB 8000: VPOKE &H1800+725, TK+250
6290 IF STRIG(0)=-1 GOTO 6290
6300 GOTO 4900

6500 FOR I=&H1800 TO &H19FF
6510   CT=VPEEK(I)
6530   IF CT=65 THEN VPOKE I, 1
6540   IF CT=4 THEN VPOKE I, 66
6550   IF CT=69 THEN VPOKE I, 70
6800 NEXT I
6900 RETURN

7500 FOR I=&H1800 TO &H19FF
7510   CT=VPEEK(I)
7520   IF CT=1 THEN VPOKE I, 65
7540   IF CT=66 THEN VPOKE I, 4
7550   IF CT=70 THEN VPOKE I, 69
7800 NEXT I
7900 RETURN

8000 'Swap the convoy belts
8100 TK=TV-70: IF TK=5 THEN TK=0
8200 FOR I=&H1800 TO &H19FF
8210   CT=VPEEK(I)
8220   IF CT>70  AND CT<76  THEN VPOKE I, 71+TK
8230   IF CT>127 AND CT<158 THEN IF (CT MOD 2) = 0 THEN VPOKE I, 128+6*TK ELSE VPOKE I, 129+6*TK
8300 NEXT I
8400 RETURN

9000 ' Animation
9010 IF AN=15 THEN AN=8 ELSE AN=AN+1
9100 ' Lasers
9100 FOR I=887 TO 895
9110   VPOKE I, VPEEK(I+AN)
9120   VPOKE I+2048, VPEEK(I+2048+AN)
9130   VPOKE I, VPEEK(I+AN)
9140   VPOKE I+2048, VPEEK(I+2048+AN)
9200 NEXT I
9250 ' Belts
9260 IF AF=40 THEN AF=16 ELSE AF=AF+8
9270 AG=AF+16: IF AG>40 THEN AG=AG-32
9300 ' Consider animating only the current mode
9300 FOR I=128*8 TO 128*8+8
9310 ' FAST BACK
9310   VPOKE I, VPEEK(I+AF)
9320   VPOKE I+2048, VPEEK(I+2048+AF)
9330   VPOKE I+8, VPEEK(I+AG)
9340   VPOKE I+2048+8, VPEEK(I+2048+AG)
9350 ' BACK
9350   VPOKE I+48, VPEEK(I+48+AF)
9360   VPOKE I+48+8, VPEEK(I+48+AF)
9370   VPOKE I+2048+48, VPEEK(I+2048+48+AF)
9380   VPOKE I+2048+48+8, VPEEK(I+2048+48+AF)
9390 ' FORWARD (actually, it is the same byte 4 times)
9390   VPOKE I+144, VPEEK(I+144+AF)
9400   VPOKE I+2048+144, VPEEK(I+2048+144+AF)
9410   VPOKE I+144+8, VPEEK(I+144+AF)
9420   VPOKE I+2048+144+8, VPEEK(I+2048+144+AF)
9430 ' FAST FORWARD
9440   VPOKE I+192, VPEEK(I+192+AF)
9450   VPOKE I+2048+192, VPEEK(I+2048+192+AF)
9460   VPOKE I+192+8, VPEEK(I+192+AG)
9470   VPOKE I+2048+192+8, VPEEK(I+2048+192+AG)
9480 NEXT I
9490 GOTO 4980

9500 'Move to another room
9500 FOR I=0 TO 4:PUT SPRITE I,(I*20,132),0,0:NEXT I
9550 SPRITE OFF
9600 SX=X:SY=Y:SV%=VY%:SJ%=PJ%
9700 call turbo off
9800 GOTO 1510
