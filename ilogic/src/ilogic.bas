FILE "../res/sprites.bin.plet5"
FILE "../res/map.chr.plet5"
FILE "../res/map.clr.plet5"

INCLUDE "map.inc"

FILE "../res/map_3_6.plet5"


100 COLOR 15,1,1:SCREEN 2,2,0
110 DEFINT A-Z

1000 DATA  1, 2, 0, 0, 0, 3, 4
1001 DATA  5, 6, 7, 0, 8, 9,10
1002 DATA 11,12,13,14,15,16,17
1003 DATA 18,19,20,21,22,23,24
1004 DATA 25,26, 0,27, 0,28,29
1005 DATA 30,31, 0, 0, 0,32,33
1006 DATA 34,35, 0,38, 0,36,37'38 is a test room located on C=3:R=6

1010 DIM RR(49), VP(640) 'RR - Room Resource, VP - VPeek replacement
1011 FOR I=1 TO 49:READ R:RR(I)=R:NEXT I

7990 C=3:R=3' Actual initial room of the game
7999 'C=3:R=6' Override for testing

8010 CMD WRTCHR 1:CMD WRTCLR 2 ' Got to load them 3 times
8011 CMD WRTVRAM 1, &H800:CMD WRTVRAM 2, &H2800
8012 CMD WRTVRAM 1, &H1000:CMD WRTVRAM 2, &H3000

8020 CMD WRTVRAM 0, &H3800 ' Load sprites WRTSPRPAT

8050 FD=2:PUT SPRITE 31,(0,174),FD,0

8100 'New game initialization
8101 AD=1:X=8:Y=120:GS=1
8102 Y=20
8103 DIM EX(4),EY(4),EV(4),ET(4),ES(4),EW(4)' Enemy X, Y, Velocity, Type, Sprite, Wait. EC: Enemy Count
8104 GOSUB 8800 ' Load initial room
8105 GOTO 9000 ' Start game loop

9000 ' BEGIN GAME LOOP
9001 TIME=0
9002 ' UPDATE
9003 ON GS GOSUB 9100, 9200, 9300, 9400' Update player based on Game State (GS)
9005 GOSUB 9900 ' Update Enemies
9009 ' DRAW
9010 PUT SPRITE 1,(X,Y+YO),15,D:PUT SPRITE 0,(X,Y+4+YO),4,9+SA+D
9020 PUT SPRITE 2,(X,Y+14),14,1+ST+D
9030 IF EC=0 THEN 9050 'Skip enemy draw if no enemies
9031 FOR I=1 TO EC
9035  PUT SPRITE 3+I,(EX(I),EY(I)),EA,25+ES(I)+ET(I)*3
9039 NEXT I
9050 IF NL>0 GOSUB 11000 'process laser animations if there are lasers

9080 ' END GAME LOOP
9081 IF TIME=0 THEN FD=2 ELSE IF TIME>1 THEN FD=8 ELSE FD=10
9082 PUT SPRITE 31,,FD
9090 IF TIME<1 GOTO 9090 ELSE 9000

9100 'GS=1 Standing
9101 S=STICK(0)
9102 VX=0
9112 IF S=3 THEN VX=1:IF D=14 OR SA=4 THEN D=0:AD=1:SA=0:ST=0 ELSE GOTO 9118 ' Animate Walk
9113 IF S=7 THEN VX=-1:IF D=0 OR SA=4 THEN D=14:AD=1:SA=0:ST=0 ELSE GOTO 9118 ' Animate Walk
9114 IF S=0 THEN SA=4:ST=3:YO=0' SA=4 marks a resting position
9115 IF S=5 THEN YO=3:ST=4:SA=4
9117 GOTO 9140 ' Skip walk animation (no input)
9118 IF S0=4 THEN S0=0 ELSE S0=S0+1:GOTO 9140 ' No animation this frame
9120 SA=SA+AD: IF SA=3 THEN AD=-1 ELSE IF SA=0 THEN AD=1
9121 ST=ST+1:IF ST=3 THEN ST=0
9122 IF ST=1 THEN YO=1 ELSE YO=0
9140 IF NOT(STRIG(0)) THEN JD=0 ELSE IF JD=0 THEN GS=2:VY=-14:SA=0:ST=4:JD=1:DJ=1:WT=4:RETURN 'JD: Jump Debouncing, DJ=double jump
9141 X=X+VX
9142 TT = ((Y+32)/8)*32
9143 T0 = VP (TT+(X+2)/8)
9144 T1 = VP (TT+(X+8)/8)
9145 T2 = VP (TT+(X+15)/8)
9146 TT = TT + X/8
9161 IF VX=0 THEN GOTO 9190' Skip tile colision check if we are not moving
9162 IF VX>0 THEN T3=VP(TT-&H80+2):T4=VP(TT-&H60+2):T5=VP(TT-&H40+2):T6=VP(TT-&H20+2)
9163 IF VX<0 THEN T3=VP(TT-&H80):T4=VP(TT-&H60):T5=VP(TT-&H40):T6=VP(TT-&H20)
9180 IF T3>=128 OR T4>=128 OR T5>=128 OR T6>=128 THEN X=X-VX
9189 GOSUB 9700' Check for item collection
9190 IF T0<124 AND T1<124 AND T2<124 THEN IF AT>0 THEN AT=AT-1 ELSE GS=3:VX=0:ST=3:SA=4 ELSE AT=3
9197 IF X=239 THEN C=C+1:X=2:GOSUB 8800' Load new room
9198 IF X=1 THEN C=C-1:X=238:GOSUB 8800' Load new room
9199 RETURN

9200 'GS=2 Jumping
9210 VY=VY+1: IF VY>=0 THEN GS=3
9211 Y=Y+VY/4
9212 X=X+VX
9213 ST=5
9214 SA=3
9240 TT = ((Y+2)/8)*32
9241 T0 = VP (TT+(X+2)/8)
9242 T1 = VP (TT+(X+8)/8)
9243 T2 = VP (TT+(X+15)/8)
9244 TT = X/8
9249 IF T0>=128 OR T1>=128 OR T2>=128 THEN VY=0:Y=Y-VY:Y=((Y+2)/8+1)*8-2:DJ=0:GS=3
9250 IF VX=0 THEN 9270' Skip horizontal collision check if we are not moving
9251 ' We can simplify T3 and T7 calculated, then T4, T5 and T6 offset from T3 (or T4) as they can only overlap (it is either 4 or 5 consecutive tiles)
9254 IF VX>0 THEN T3=VP(TT+(Y+32)/8*32+2):T4=VP(TT+(Y+24)/8*32+2):T5=VP(TT+(Y+16)/8*32+2):T6=VP(TT+(Y+8)/8*32+2):T7=VP(TT+(Y+2)/8*32+2)
9255 IF VX<0 THEN T3=VP(TT+(Y+32)/8*32):T4=VP(TT+(Y+24)/8*32):T5=VP(TT+(Y+16)/8*32):T6=VP(TT+(Y+8)/8*32):T7=VP(TT+(Y+2)/8*32)
9261 IF T3>=128 OR T4>=128 OR T5>=128 OR T6>=128 OR T7>=128 THEN X=X-VX:IF VY>-4 THEN GOSUB 9800
9270 IF DJ=1 AND VY>-4 THEN GOSUB 9820 'Double Jump check
9273 GOSUB 9700' Check for item collection
9298 IF Y<=0 THEN R=R-1:Y=130:GOSUB 8800' Load new room
9299 RETURN

9300 'GS=3 Falling
9301 VY=VY+1: IF VY>14 THEN VY=14
9302 Y=Y+VY/4:X=X+VX
9314 SA=0:ST=6
9319 ' The next 3 lines enable gliding
9320 S=STICK(0)
9321 IF S=3 THEN VX=VX+1:IF VX>1 THEN VX=1:D=0
9322 IF S=7 THEN VX=VX-1:IF VX<-1 THEN VX=-1:D=14
9340 TT = ((Y+32)/8)*32
9341 T0 = VP (TT+(X+2)/8)
9342 T1 = VP (TT+(X+8)/8)
9343 T2 = VP (TT+(X+15)/8)
9344 TT = X/8
9350 IF VX=0 THEN 9385' Skip horizontal collision check if we are not moving
9354 IF VX>0 THEN T3=VP(TT+(Y+32)/8*32+2):T4=VP(TT+(Y+24)/8*32+2):T5=VP(TT+(Y+16)/8*32+2):T6=VP(TT+(Y+8)/8*32+2):T7=VP(TT+(Y+2)/8*32+2)
9355 IF VX<0 THEN T3=VP(TT+(Y+32)/8*32):T4=VP(TT+(Y+24)/8*32):T5=VP(TT+(Y+16)/8*32):T6=VP(TT+(Y+8)/8*32):T7=VP(TT+(Y+2)/8*32)
9381 IF T3>=128 OR T4>=128 OR T5>=128 OR T6>=128 OR T7>=128 THEN X=X-VX:GOSUB 9800 'Wall jump check
9385 IF T0>=124 OR T1>=124 OR T2>=124 THEN GS=1:JD=1:DJ=0:SA=4:ST=4:NK=1:VX=0:Y=((Y+32)/8)*8-32
9390 IF DJ=1 THEN GOSUB 9820 'Double Jump check
9391 GOSUB 9700' Check for item collection
9398 IF Y>=146 THEN R=R+1:Y=0:GOSUB 8800' Load new room
9399 RETURN

9400 'GS=4 Initial hold onto wall
9401 WT=WT-1: IF WT=0 THEN GS=3' WT: Wall Time is reset each time we start a jump
9402 IF NOT(STRIG(0)) THEN JD=0 ELSE IF JD=0 THEN GS=2:VY=-14:VX=-VX:JD=1:WT=4:IF D=0 THEN D=14 ELSE D=0'JD: Jump Debouncing
9499 RETURN

9700 ' fun Check for item collection
9701 IC=(X+4)/8+(Y+12)/8*32
9702 II=IC:GOSUB 9710 ' Check tile for item
9703 II=IC+32:GOSUB 9710 ' Check tile for item
9704 II=IC+64:GOSUB 9710 ' Check tile for item
9709 RETURN

9710 ' fun Check tile for item
9711 I0=VP(II):IF (I0 MOD 2 = 0 AND I0>=96 AND I0<=106) THEN TI=(II-32):GOSUB 9720' Pick up item
9719 RETURN

9720 ' fun Pick up item
9721 VPOKE &H1800+TI,0:VPOKE &H1800+TI+1,0
9722 VPOKE &H1800+TI+32,0:VPOKE &H1800+TI+33,0
9723 VP(TI)=0:VP(TI+1)=0
9724 VP(TI+32)=0:VP(TI+33)=0
9729 RETURN

9800 'fun Wall jump check: need to have a substantial amount of wall to grip to
9801 IF T5>=64 AND (T4>=64 OR T6>=64) THEN IF WT>0 THEN GS=4:GOTO 9809 ELSE 9802 ELSE 9809
9802 SA=3:ST=7
9803 IF VY>7 THEN VY=7 ELSE IF VY<-9 THEN VY=-9
9808 IF NOT(STRIG(0)) THEN JD=0 ELSE IF JD=0 THEN GS=2:VY=-14:VX=-VX:JD=1:WT=4:IF D=0 THEN D=14 ELSE D=0'JD: Jump Debouncing
9809 RETURN

9820 'fun Double Jump Check
9821 IF JD=1 AND NOT(STRIG(0)) THEN JD=0:GOTO 9829
9822 IF JD=0 AND STRIG(0) THEN GS=2:SA=0:ST=4:JD=1:DJ=0:VY=VY-14:IF VY<-14 THEN VY=-14 ELSE IF VY>-6 THEN VY=-6
9829 RETURN

9900 'fun Update enemies
9901 EA=14:IF EC=0 THEN RETURN ' Skip enemy updates if no enemies
9902 FOR EI=1 TO EC
9903  EW(EI)=EW(EI)+1:IF EW(EI)=3 THEN EW(EI)=0:ES(EI)=ES(EI)+EV(EI):IF ES(EI)=3 THEN ES(EI)=0 ELSE IF ES(EI)=-1 THEN ES(EI)=2
9904  ON ET(EI) GOSUB 9910,9920,9930,9940 ' Update enemy based on type
9905  ' Colision box detection
9906  IF ABS(X-EX(EI))<16 AND Y-EY(EI)>-31 AND Y-EY(EI)<15 THEN EA=8
9908 NEXT I
9909 RETURN

9910 'fun Update enemy type 1: Horizontal, lower
9911 EX(EI)=EX(EI)+EV(EI)
9913 IF EX(EI) MOD 8=0 THEN EL=VP(((EY(EI)+9)\8)*32+(EX(EI)+8+4*EV(EI))\8):IF EL=138 OR EL=140 THEN EV(EI)=-EV(EI)
9919 RETURN

9920 'fun Update enemy type 2: Horizontal, upper
9921 EX(EI)=EX(EI)+EV(EI)
9923 IF EX(EI) MOD 8=0 THEN EL=VP(((EY(EI)+8)\8)*32+(EX(EI)+8+4*EV(EI))\8):IF EL=170 OR EL=172 THEN EV(EI)=-EV(EI)
9929 RETURN

9930 'fun Update enemy type 3: Vertical, right wall
9931 EY(EI)=EY(EI)+EV(EI)
9933 IF EY(EI) MOD 8=6 THEN EL=VP(((EY(EI)+8+6*EV(EI))\8)*32+(EX(EI)+8)\8):IF EL=142 OR EL=174 THEN EY(EI)=EY(EI)-EV(EI):EV(EI)=-EV(EI)
9939 RETURN

9940 'fun Update enemy type 4: Vertical, left wall
9941 EY(EI)=EY(EI)+EV(EI)
9943 IF EY(EI) MOD 8=6 THEN EL=VP(((EY(EI)+8+6*EV(EI))\8)*32+(EX(EI))\8):IF EL=141 OR EL=173 THEN EY(EI)=EY(EI)-EV(EI):EV(EI)=-EV(EI)
9949 RETURN

9990 ' Visual debug
9991 VPOKE &H1AA0,I0:VPOKE &H1AC0,I1:VPOKE &H1AE0,I2
9992 VPOKE &H1AA1,I3:VPOKE &H1AC1,I4:VPOKE &H1AE1,I5
9999 RETURN

11000 ' fun Process laser animations
11001 TA=TA+1 ' TA: timer for animation
11002 IF TA MOD 5 = 1 THEN GOSUB 12000
11003 IF TA MOD 5 = 3 THEN GOSUB 12100
11008 IF TA MOD 80 = 0 THEN GOSUB 11100
11009 RETURN

11100 ' SWAP LASER STATE color at tiles 62, 63,from &H89 to 00. Color table starts at &H2000
11200 IF LS=1 THEN LC=&H00:LS=0 ELSE LC=&H89:LS=1
11500 FOR I=&H21F0 TO &H21FF
11600  VPOKE I, LC:VPOKE I+&H800, LC: VPOKE I+&H1000, LC
11700 NEXT I
11800 ' Lasers ON enable sound on channel 3 with sound generator
11810 'IF LC=0 THEN SOUND 8, 0 ELSE IF LP=1 THEN SOUND 8, &B11111
11990 RETURN

12000 'ANIMATE LASER (vertical), we have 4 patterns, they all have the same colors, tile 144-147, base address for the copy is tile 62 -> 62*8=496 -> 0x1F0
12001 LT=LT+1:IF LT=200 THEN LT=196
12002 FOR I=0 TO 7
12003  LR=VPEEK(LT*8+I)
12004  VPOKE &H1F0+I, LR:VPOKE I+&H9F0, LR: VPOKE I+&H11F0, LR
12006 NEXT I
12099 RETURN

12100 'ANIMATE LASER (horizontal), we have 4 patterns, they all have the same colors, tile 144-147, base address for the copy is tile 62 -> 62*8=496 -> 0x1F0
12101 'LT=LT+1:IF LT=200 THEN LT=196 'We only need to swap pattern once
12102 FOR I=0 TO 7
12103  LM=VPEEK(LT*8+I+32)
12105  VPOKE &H1F8+I, LM:VPOKE I+&H9F8, LM: VPOKE I+&H11F8, LM
12106 NEXT I
12199 RETURN

8800 ' fun Load new room
8801 FOR I=0 TO 7: PUT SPRITE I,(0,-16),0:NEXT I
8805 CMD WRTSCR RR(R*7+C+1)+2
8806 EC=0:LT=196:NL=0
8810 FOR I=0 TO 640
8820  TT=VPEEK(&H1800+I)
8821  IF TT=192 THEN TT=0:GOSUB 8910 ' Parse enemy type 1
8822  IF TT=160 THEN TT=0:GOSUB 8920 ' Parse enemy type 2
8823  IF TT=163 THEN TT=0:GOSUB 8930 ' Parse enemy type 3
8824  IF TT=162 THEN TT=0:GOSUB 8940 ' Parse enemy type 4
8825  IF TT=62 OR TT=63 THEN NL=1 ' There are lasers in the room
8826  VP(I)=TT
8829 NEXT I
8830 RETURN

8840 ' fun Initialize enemy
8841 EC=EC+1
8842 EX(EC)=(I MOD 32)*8
8843 EY(EC)=(I\32)*8-1
8849 RETURN

8850 ' fun Preload sprite where the enemy is located
8851 PUT SPRITE 3+EC,(EX(EC),EY(EC)),14,25+ES(EC)+ET(EC)*3
8859 RETURN

8910 ' fun Parse enemy type 1 (horizontal, bottom)
8911 GOSUB 8840' Initialize enemy
8912 ET(EC)=1:EV(EC)=1
8914 GOSUB 8850 ' Preload sprite
8918 VPOKE &H1800+I,0:VPOKE &H1800+I+1,0
8919 RETURN

8920 ' fun Parse enemy type 2 (horizontal, top)
8921 GOSUB 8840' Initialize enemy
8922 ET(EC)=2:EV(EC)=1
8923 EY(EC)=EY(EC)-8
8924 GOSUB 8850' Preload sprite
8928 VPOKE &H1800+I,0:VPOKE &H1800+I+1,0
8929 RETURN

8930 ' fun Parse enemy type 3 (vertical, right)
8931 GOSUB 8840' Initialize enemy
8932 ET(EC)=3:EV(EC)=1
8935 GOSUB 8850' Preload sprite
8938 VPOKE &H1800+I,0:VPOKE &H1800+I+32,0
8939 RETURN

8940 ' fun Parse enemy type 4 (vertical, left)
8941 GOSUB 8840' Initialize enemy
8942 ET(EC)=4:EV(EC)=1
8944 EX(EC)=EX(EC)-8
8945 GOSUB 8850' Preload sprite
8948 VPOKE &H1800+I,0:VPOKE &H1800+I+32,0
8949 RETURN
