1 DEFINT A-Z
21 DIM LS(24)
22 FOR I=0 TO 23 STEP 2
23  LT=VPEEK(I\2+1)
24  LS(I)=LT\16-1:LS(I+1)=(LT MOD 16)-1
28 NEXT I

100 GOSUB 10000

4100 BLOAD "lselect.sc2",S
4101 BLOAD "cls.scr",S
4110 X=8: Y=8
4111 STRIG(0) ON: STRIG(1) ON: ON STRIG GOSUB 4500, 4500

4115 CALL TURBO ON(LS())
4119 LA=1
4120 'DISPLAY THE LEVELS AS THEY ARE
4120 ' LA: Level Available
4120 ' IA: Initial address for VPOKE of the level in screen
4120 ' LI: Level Initial value on the name table for the row
4120 FOR I=0 TO 23
4130  LI=1: IF LS(I)=-1 THEN LA=LA-1: IF LA<0 THEN LI=10
4131  IA=&H1800+(I MOD 6)*5 + 1 + (I\6)*&HA0 + &H20
4132  VPOKE IA, LI:VPOKE IA+1, LI+1:VPOKE IA+2, LI+1: VPOKE IA+3, LI+1:VPOKE IA+4, LI+2
4133  'Level number is st 2nd and 3rd slots on the 2nd and 3rd column
4133  IA=IA+&H20:LI=LI+3:LN=LI+1
4134  IF I>=19 THEN LN=43 ELSE IF I>=9 THEN LN=42
4135  LD=32+(I MOD 10): IF I>=9 THEN LD=LD+10
4136  IF LA<0 THEN LN=LN+&H40:LD=LD+&H40: IF I<9 THEN LN=LI+1
4137  VPOKE IA, LI:VPOKE IA+1, LN:VPOKE IA+2, LD: VPOKE IA+3, LI+1:VPOKE IA+4, LI+2
4138  IA=IA+&H20:LD=LD+&H20: IF LN>40 THEN LN=LN+&H20
4139  VPOKE IA, LI:VPOKE IA+1, LN:VPOKE IA+2, LD: VPOKE IA+3, LI+1:VPOKE IA+4, LI+2

4140  'PAWS
4140  IA=IA+&H20:IF LS(I)>0 THEN LI=150+LS(I)*10 ELSE GOTO 4160
4141  VPOKE IA, LI:VPOKE IA+1, LI+1:VPOKE IA+2, LI+2: VPOKE IA+3, LI+3:VPOKE IA+4, LI+4
4150  IA=IA+&H20:LI=LI+5
4151  VPOKE IA, LI:VPOKE IA+1, LI+1:VPOKE IA+2, LI+2: VPOKE IA+3, LI+3:VPOKE IA+4, LI+4
4152  GOTO 4190
4160 ' Level without paws (not started, unavailable, or 0 stars)
4160  LN=LI+1: IF LS(I)=-1 THEN LN=20: IF LA>-1 THEN LN=19
4161  VPOKE IA, LI:VPOKE IA+1, LI+1:VPOKE IA+2, LN: VPOKE IA+3, LI+1:VPOKE IA+4, LI+2
4162  IA=IA+&H20:LI=LI+3
4163  VPOKE IA, LI:VPOKE IA+1, LI+1:VPOKE IA+2, LI+1: VPOKE IA+3, LI+1:VPOKE IA+4, LI+2
4190 NEXT I

4192 CALL TURBO OFF

4220 PUT SPRITE 0,(X,Y-1),10,0
4230 PUT SPRITE 1,(X+24,Y-1),10,1
4240 PUT SPRITE 2,(X,Y+23),10,2
4250 PUT SPRITE 3,(X+24,Y+23),10,3

4320 SS=S
4321 S=STICK(0)
4322 IF S=SS GOTO 4321
4330 IF S=1 THEN Y=Y-40: IF Y<8 THEN Y=8
4340 IF S=3 THEN X=X+40: IF X>208 THEN X=208
4350 IF S=5 THEN Y=Y+40: IF Y>128 THEN Y=128
4360 IF S=7 THEN X=X-40: IF X<8 THEN X=8

4460 GOTO 4220

4500 'Level loading screen
4510 BLOAD "loading.sc2",S
4520 'Put level selection in VRAM info
4520 VPOKE 0, (X-8)\40+(Y-8)*6\40+1
4522 FOR I=0 TO 23 STEP 2
4523  VPOKE I/2+1, (LS(I)+1)*16+(LS(I+1)+1)
4525 NEXT I
4590 RUN "spacecat.bas"

5030 DATA 00,03,0F,1E,38,30,70,60,60,60,60,60,60,60,60,60
5040 DATA 00,FF,FF,00,00,00,00,00,00,00,00,00,00,00,00,00
5080 DATA 00,FF,FF,00,00,00,00,00,00,00,00,00,00,00,00,00
5090 DATA 00,80,E0,F0,38,18,1C,0C,0C,0C,0C,0C,0C,0C,0C,0C
5130 DATA 60,60,60,60,60,60,60,60,70,30,38,1E,0F,03,00,00
5140 DATA 00,00,00,00,00,00,00,00,00,00,00,00,FF,FF,00,00
5180 DATA 00,00,00,00,00,00,00,00,00,00,00,00,FF,FF,00,00
5190 DATA 0C,0C,0C,0C,0C,0C,0C,0C,1C,18,38,F0,E0,80,00,00
5200 DATA *

10000 REM -- LOAD SPRITES
10010 S=BASE(9)
10020 READ R$: IF R$="*" THEN RETURN ELSE VPOKE S,VAL("&H"+R$):S=S+1:GOTO 10020
