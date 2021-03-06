100 COLOR 15,1,1:SCREEN 2,2,0
110 DEFINT A-Z

130 DATA 03,0E,35,EA,D5,FA,FD,FF,FF,FF,FF,FF,FF,3F,0F,03
131 DATA C0,B0,5C,AB,57,AC,70,C0,00,00,00,00,00,00,00,00
132 DATA 00,01,0A,15,2A,05,02,00,00,00,00,00,00,00,00,00
133 DATA 00,40,A0,54,A8,53,8F,3F,FF,FF,FF,FF,FF,FC,F0,C0
134 DATA *

135 S=BASE(9)
136 READ R$: IF R$="*" THEN GOTO 140 ELSE VPOKE S,VAL("&H"+R$):S=S+1:GOTO 136

140 BLOAD "logic_3d.sc2",S

145 CALL TURBO ON
146 'We store the room of size [8][8][4] in the array R using index (I+J*8+K*64)
146 DIM R(255)

150 X=60:Y=60

170 DATA 4,4,3,3,2,2,1,1
171 DATA 4,4,3,3,2,2,1,1
172 DATA 3,3,2,2,1,1,0,0
173 DATA 3,3,2,2,1,1,0,0
174 DATA 2,2,1,1,0,0,0,0
175 DATA 2,2,1,1,0,0,0,0
176 DATA 1,1,0,0,0,0,0,0
177 DATA 1,1,0,0,0,0,0,0

200 'Read the scene from the previous DATA block
200 FOR I=0 TO 7
210  FOR J=0 TO 7®
220   READ KE
230   FOR K=0 TO 3
240    IF K<KE THEN R(I+J*8+K*64)=1 ELSE R(I+J*8+K*64)=0
250   NEXT K
260  NEXT J
270 NEXT I

310 'Render the scene
310  FOR I=0 TO 7
320   FOR J=0 TO 7
321    FOR K=0 TO 3
330     IF R(I+J*8+K*64)=1 THEN GOSUB 1000
340   NEXT K
350  NEXT J
360 NEXT I

380 GOTO 1400

1000 ' Draw a block
1010 'Calculate position of the top-left tile (TX,TY) based on I,J,K
1010 TX=14-2*J+2*I:TY=6+I+J-K
1020 'Tile Initial VRAM position calculated from (TX,TY)
1020 TI=TX+TY*32+&H1800

1030 'First two tiles of top row (based on the current leftmost tile)
1030 CT=VPEEK(TI): ST=52
1031 IF CT=22 THEN ST=56
1032 IF CT=54 OR CT=215 OR CT=58 OR CT=62 OR CT=94 THEN ST=60
1033 IF CT=116 OR CT=212 OR CT=216 OR CT=158 OR CT=120 THEN ST=120
1034 IF CT=148 THEN ST=152
1035 IF CT=150 OR CT=218 OR CT=214 OR CT=118 OR CT=156 THEN ST=156
1036 IF CT=84 OR CT=117 OR CT=92 THEN ST=92
1037 IF CT=154 OR CT=122 THEN ST=220
1039 VPOKE TI, ST:VPOKE TI+1, ST+1

1040 'Last two tiles of top row (based on the current rightmost tile)
1040 CT=VPEEK(TI+3): ST=52
1041 IF CT=21 THEN ST=56
1042 IF CT=53 OR CT=212 OR CT=57 OR CT=61 OR CT=93 THEN ST=60
1043 IF CT=119 OR CT=215 OR CT=219 OR CT=157 OR CT=123 THEN ST=120
1044 IF CT=151 THEN ST=152
1045 IF CT=149 OR CT=217 OR CT=213 OR CT=117 OR CT=159 THEN ST=156
1046 IF CT=87 OR CT=118 OR CT=95 THEN ST=92
1047 IF CT=153 OR CT=121 THEN ST=220
1049 VPOKE TI+2, ST+2:VPOKE TI+3, ST+3

1959 'Middle Row tiles, always the same
1050 VPOKE TI+32, 84:VPOKE TI+33, 85:VPOKE TI+34, 86:VPOKE TI+35, 87

1060 'First 2 tiles of bottom row (based on the current leftmost tile)
1060 CT=VPEEK(TI+64): ST=116
1061 IF CT=84 THEN ST=148  
1070 VPOKE TI+64, ST:VPOKE TI+65, ST+1

1080 'Last 2 tiles of bottom row (based on the current rightmost tile)
1080 CT=VPEEK(TI+67): ST=116
1081 IF CT=87 THEN ST=148
1090 VPOKE TI+66, ST+2:VPOKE TI+67, ST+3
1100 RETURN

1400 S=STICK(0)
1410 'Moving up if stick up, we are within bounds and item at (X,Y-1,Z) is not solid
1410 IF S=1 AND Y>0 AND (Z>32 OR R(X\8+((Y-1)\8)*8+(Z\8)*64)=0) THEN Y=Y-1
1420 'Moving right if stick left, we are within bounds, and item at (X+1,Y,Z) is not solid
1430 IF S=3 AND X<60 AND (Z>31 OR R((X+1)\8+(Y\8)*8+(Z\8)*64)=0) THEN X=X+1
1450 IF S=5 AND Y<60 AND (Z>31 OR R(X\8+((Y+1)\8)*8+(Z\8)*64)=0) THEN Y=Y+1
1470 IF S=7 AND X>0 AND (Z>31 OR R((X-1)\8+(Y\8)*8+(Z\8)*64)=0) THEN X=X-1

1480 'PJ: Player Jump, 0 on ground, 1 jumping, -1 falling
1480 IF STRIG(0) AND PJ=0 THEN PJ=1:VZ=6
1490 'If we are not in solid ground, apply velocity to Z coordinate and gravity to VZ (within a certain range).
1490 IF PJ<>0 THEN Z=Z+VZ:VZ=VZ-1:IF VZ<-6 THEN VZ=-6
1491 'We never go below ground (Z=0)
1491 IF Z<0 THEN Z=0:PJ=0:VZ=0
1491 'Check if the current (X,Y,Z-1) position of the sprite is solid ground (1)
1492 IF Z>1 AND Z<32 AND VZ<0 AND R(X\8+(Y\8)*8+((Z-1)\8)*64)=1 THEN Z=((Z-VZ)\8)*8:PJ=0:VZ=0
1493 ' Check if the current (X,Y,Z-1) position of the sprite is empty (triggers falling)
1493 IF PJ=0 AND Z>7 AND R(X\8+(Y\8)*8+((Z-1)\8)*64)=0 THEN PJ=-1:VZ=0

1500 IX=(X*2-Y*2)+120
1510 IY=(X+Y)+47-Z

1800 PUT SPRITE 0,(IX,IY),8,0
1810 PUT SPRITE 1,(IX,IY),6,1

1890 IF TIME<2 THEN 1890 ELSE TIME=0
1900 GOTO 1400

1950 CALL TURBO OFF
1960 GOTO 140
