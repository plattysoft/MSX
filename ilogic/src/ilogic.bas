FILE "../res/sprites.bin.plet5"
' Updated sprites for legs
'FILE "./sprites_updated.bin.plet5"
FILE "../res/map.chr.plet5"
FILE "../res/map.clr.plet5"

INCLUDE "map_2.inc"

FILE "../res/map_full_0_5.plet5" ' 38 - purple frame for full screen console messages (intro / ending)
FILE "../res/ilogic_2.akm"

FILE "../res/splash.chr.plet5" '40
FILE "../res/splash.clr.plet5"
FILE "../res/splash_0_0.plet5"

FILE "strings.txt" '43
FILE "../res/sfx.akx"
FILE "../res/cls.plet5"
'
20 CMD PLYLOAD 39, 44 '39,44
21 CMD PLYSONG 2:CMD PLYPLAY ' Song 2 is silent, but we want SFX

100 COLOR 15,1,1:SCREEN 2,2,0
110 DEFINT A-Z

1010 DIM RR(35), VP(672), CI(6), KT(220) 'RR - Room Resource, VP - VPeek replacement, CI - Collected items, KT - Keep tiles (for showing a popup)

2000 ' Platty Soft Intro
2001 CMD WRTSCR 45 'CLS
2002 RI=40:GOSUB 5100'Load splash and platty tiles

2100 'Prepare the initial position
2110 FOR I=0 to 3
2120  FOR K=0 TO 3
2121   VPOKE &H1906+I+K*32,152+I*32+K
2122  NEXT K
2123 NEXT I

2199 CMD PLYSOUND 18
2200 ' Scroll up 32 times (push everything up and add a line at the bottom on the 4 tiles)
2210 FOR I=&H4E0 TO &H4FF
2211 TIME=0
2212  FOR J=&HCC0 TO &HCDF
2213   FOR K=0 TO &H300 STEP &H100
2221    VPOKE J+K, VPEEK(J+K+1)
2223    VPOKE &H2000+J+K, VPEEK(&H2001+J+K)
2247   NEXT K
2248  NEXT J
2250  FOR K=0 TO &H300 STEP &H100
2252   VPOKE &HCDF+K, VPEEK(I+K)
2254   VPOKE &H2CDF+K, VPEEK(&H2800+I+K)
2296  NEXT K
2297 IF STRIG(0) OR STRIG(1) THEN 2500
2298 IF TIME<1 GOTO 2297
2299 NEXT I

2300 CMD PLYSOUND 19
2301 FOR I=0 TO 8
2309  TIME = 0
2310  FOR K=0 TO I
2320   VPOKE &H192A+K,172-I+K:VPOKE &H194A+K,204-I+K::VPOKE &H196A+K,236-I+K
2330  NEXT K
2331  IF TIME<2 GOTO 2331
2340 NEXT I
2400 FOR I=0 TO 5
2409  TIME = 0
2410  FOR K=0 TO I
2420   VPOKE &H1933+K,178-I+K:VPOKE &H1953+K,210-I+K::VPOKE &H1973+K,242-I+K
2430  NEXT K
2431  IF STRIG(0) OR STRIG(1) THEN 2500
2432  IF TIME<2 GOTO 2431
2440 NEXT I

2450 TIME=0
2451 IF STRIG(0) OR STRIG(1) THEN 2500
2460 IF TIME<150 GOTO 2451

2500 ' END OF INTRO

5000 ' Start screen
5001 'CMD WRTSCR 45
5011 CMD PLYMUTE:CMD PLYSONG 1 ' Main screen sound
5020 CMD WRTSCR 42
5021 CMD PLYPLAY ' Start the music on the main start screen
5030 IF STRIG(0) OR STRIG(1) THEN 5030 'debounce string press
5090 IF STRIG(0) THEN SS=0:GOTO 6000
5091 IF STRIG(1) THEN SS=1:GOTO 6000
5099 GOTO 5090

5100 ' Write RI (Resource ID) to pattern table (3 times) and RI+1 to color table (3 times)
5101 CMD WRTCHR RI:CMD WRTCLR RI+1 ' Load tileset (patterns and colors) Got to load them 3 times
5102 CMD WRTVRAM RI, &H800:CMD WRTVRAM RI+1, &H2800
5103 CMD WRTVRAM RI, &H1000:CMD WRTVRAM RI+1, &H3000
5109 RETURN


6000 ' Start New Game
6001 CMD PLYMUTE:CMD PLYSONG 2:CMD PLYPLAY ' Song 2 is silent
6002 CMD WRTSCR 45
6010 RI=1:GOSUB 5100 ' Load room resources

6100 ' Intro sequence
6102 FOR I=0 TO 7:PUT SPRITE I,,0,0:NEXT
6105 CMD WRTSCR 38
6109 CMD RESTORE 43:RESTORE 27:TK=1' Text sKip enabled (pressing space)
6110 ' Blank screen, show text as in a console
6120 TY=1:GOSUB 10200
6121 TY=3:GOSUB 10200
6130 TY=5:GOSUB 10200
6131 IF STRIG(SS) THEN 6131
6140 TY=8:GOSUB 10200
6141 IF STRIG(SS) THEN 6141
6150 TY=11:GOSUB 10200
6151 TY=13:GOSUB 10200
6152 TY=14:GOSUB 10200
6170 TY=17:GOSUB 10200
6171 IF STRIG(SS) THEN 6171
6180 TY=20:GOSUB 10200
6190 TY=22:GOSUB 10200
6191 IF STRIG(SS) THEN 6191
6192 TIME=0
6199 IF TIME>150 OR STRIG(SS) THEN 7000 ELSE 6199

7000 CMD WRTSCR 45

7990 C=3:R=3' Actual initial room of the game
7991 I1=0:I2=0:I3=0:I4=0:I5=0:I6=0' No items hold at the beginning of the game
7992 GM=1' Game Mode: 1: Infinite lifes, 2: One life with 3 hearts (TODO), 0: God Mode
7993 PZ=0:PT=5000' Player DereZ, number of deaths starts at 0, PT: Play Timer (countdown)

7994 ' DEBUG OVERRIDE INIT
7995 'GM=0
7996 C=1:R=0
7997 I1=1:I2=1:I3=1:I4=1:I5=1:I6=2
7999 'GOSUB 10000 ' Show the ending

8020 CMD WRTVRAM 0, &H3800 ' Load sprites WRTSPRPAT

8049 ' Setup of visual debug
8050 'FD=2:PUT SPRITE 31,(0,174),FD,0:PUT SPRITE 30,(200,174),PD,0

8100 'New game initialization
8101 AD=1:X=120:Y=120:GS=1:GI=0:T4=0:BS=0
8103 DIM EX(4),EY(4),EV(4),ET(4),ES(4),EW(4)' Enemy X, Y, Velocity, Type, Sprite, Wait. EC: Enemy Count
8110 FOR I=0 TO 6:CI(I)=0:NEXT I:NI=0' Clear inventory. NI: Number of items collected
8111 FOR I=0 TO 35:RR(I)=0:NEXT I'Clear room resource collected
8190 GOSUB 8800 ' Load initial room
8191 DI=-1' Not showing dialog info at the start of a new game
8195 CMD PLYMUTE:CMD PLYSONG 0:CMD PLYPLAY' Actual main song
8199 GOTO 9000 ' Start game loop

8600 'fun calculate tiles to right or left (T3, T4, T5, T6 and T7)
8601 ' We can simplify T3 and T7 calculated (it is either 4 or 5 consecutive tiles) based on the value of Y MOD 8 - IF (Y+2)\8 is the same as (Y+8)\8 or not
8602 TZ=(Y+32)/8*32' the others are at Y+8, Y+16, Y+24 and then Y+32 (8 pixels down each
8605 IF VX>0 THEN T7=VP(TT+(Y+2)/8*32+2):TZ=TZ+2:
8606 IF VX<0 THEN T7=VP(TT+(Y+2)/8*32)
8609 T3=VP(TT+TZ):T4=VP(TT+TZ-&H20):T5=VP(TT+TZ-&H40):T6=VP(TT+TZ-&H60)
8610 RETURN

8620 ' fun calculate tiles up or down (T0, T1 and T2), starting on TT (derived from X, Y and VY)
8621 IF VY<0 THEN TT=((Y+2)/8)*32 ELSE TT=((Y+32)/8)*32
8622 T0 = VP (TT+(X+2)/8)
8623 T1 = VP (TT+(X+8)/8)
8624 T2 = VP (TT+(X+15)/8)
8629 RETURN

8650 ' Draw the number of deaths
8661 T$=STR$(PZ):T$=RIGHT$(T$,LEN(T$)-1)
8662 IF PZ<100 THEN T$="0"+T$
8663 IF PZ<10 THEN T$="0"+T$
8664 TX=2:TY=22:GOSUB 10900
8669 RETURN

8670 ' Update the timer
8671 PT=PT-1 ' Check for time's up is done on the calling code to be able to pop all the stack calls
8672 T$=STR$(PT):T$=RIGHT$(T$,LEN(T$)-1)
8673 IF PT<1000 THEN T$="0"+T$
8674 IF PT<100 THEN T$="0"+T$
8675 IF PT<10 THEN T$="0"+T$
8676 TX=27:TY=22:GOSUB 10900
8679 RETURN

8680 ' GAME OVER Placeholder
8681 CMD PLYMUTE:CMD PLYSONG 2:CMD PLYPLAY ' Song 2 is silent
8682 FOR I=0 TO 7:PUT SPRITE I,,0,0:NEXT
8683 CMD WRTSCR 38
8684 CMD RESTORE 43:RESTORE 38:TK=0' Text sKip disabled (pressing space)
8685 ' Blank screen, show text as in a console
8691 TY=1:GOSUB 10200
8692 TY=4:GOSUB 10200
8693 TY=6:GOSUB 10200
8694 TY=9:GOSUB 10200
8695 TY=11:GOSUB 10200
8696 TY=14:GOSUB 10200
8697 TY=17:GOSUB 10200
8698 TY=20:GOSUB 10200
8699 IF STRIG(SS) THEN RETURN ELSE 8699

8700 ' fun player dies
8702 ' Teleport out
8703 GOSUB 11300
8704 PUT SPRITE 1,,0:PUT SPRITE 2,,0:PUT SPRITE 3,,0
8705 GOSUB 11320

8750 ' Restore player state to the beginning of the room
8751 X=RX:Y=RY:VX=RV:VY=RW:GS=RG:D=RD:SA=RA:ST=RT

8760 GOSUB 11300 'Teleport initial place
8761 PUT SPRITE 2,(X,Y+YO),15,D:PUT SPRITE 1,(X,Y+4+YO),4,9+SA+D
8762 PUT SPRITE 3,(X,Y+16+YO),14,1+ST+D
8763 GOSUB 11320

8770 ' Draw the number of deaths
8771 PZ=PZ+1:GOSUB 8650
8799 RETURN

9000 ' BEGIN GAME LOOP
9001 TIME=0:PD=0' PD: Player Dead, player is not dead at the beginning of each loop
9002 IF STRIG(SS)=0 THEN JD=0'If the trigger is not pressed, it is debounced

9003 ' UPDATE
9004 ON GS GOSUB 9100, 9200, 9300, 9400' Update player based on Game State (GS)
9005 GOSUB 9900 ' Update Enemies
9009 ' DRAW
9010 PUT SPRITE 2,(X,Y+YO),15,D:PUT SPRITE 1,(X,Y+4+YO),4,9+SA+D
9020 PUT SPRITE 3,(X,Y+14),14,1+ST+D'PUT SPRITE 3,(X,Y+16+YO),14,1+ST+D
9030 IF EC=0 THEN 9050 'Skip enemy draw if no enemies
9031 FOR I=1 TO EC
9035  PUT SPRITE 3+I,(EX(I),EY(I)),14,25+ES(I)+ET(I)*3
9039 NEXT I
9050 IF NL>0 GOSUB 11000 'process laser animations and check for death (only if there are lasers)
9051 IF BT>0 THEN BT=BT-1:IF BT=0 THEN GOSUB 9610 ELSE IF BT=TS THEN GOSUB 9650' fun Swap temporary bricks
9052 IF NB>0 GOSUB 10400 'animate convoy belts
9080 ' END GAME LOOP
9082 'PUT SPRITE 31,,GS+4: PUT SPRITE 30,,PD ' Visual debig of Frame Drops and Player Death
9083 'IF TIME<1 THEN FD=2 ELSE FD=10
9085 IF PD>0 AND GM=1 THEN GOSUB 8700
9086 ' Once per second, update the countdown, also check for game over
9087 CW=CW+1:IF CW=30 THEN CW=0:GOSUB 8670:IF PT=0 GOSUB 8680:GOTO 2000
9090 IF TIME<2 THEN 9090 ELSE 9000

9100 'GS=1 Standing
9101 S=STICK(SS)
9102 VX=0
9112 IF S=3 OR S=2 OR S=4 THEN VX=2:IF D=14 OR SA=4 THEN D=0:AD=1:SA=0:ST=0:GOTO 9140 ELSE GOTO 9118 ' Animate Walk
9113 IF S=7 OR S=6 OR S=8 THEN VX=-2:IF D=0 OR SA=4 THEN D=14:AD=1:SA=0:ST=0:GOTO 9140 ELSE GOTO 9118 ' Animate Walk
9114 SA=4:ST=3:YO=0' SA=4 marks a resting position
9117 GOTO 9140 ' Skip walk animation (no input)
9118 IF S0=2 THEN S0=0 ELSE S0=S0+1:GOTO 9140 ' No animation this frame
9120 SA=SA+AD: IF SA=3 THEN AD=-1 ELSE IF SA=0 THEN AD=1
9121 ST=ST+1:IF ST=3 THEN ST=0:CMD PLYSOUND 6
9122 IF ST=1 THEN YO=1 ELSE YO=0
9140 IF STRIG(SS) AND JD=0 THEN GS=2:VY=-38:SA=0:ST=4:JD=1:DJ=1:WT=4:CMD PLYSOUND 8:RETURN 'JD: Jump Debouncing, DJ=double jump
9141 X=X+VX
9143 GOSUB 8620
9146 TT = TT + X/8
9161 IF VX=0 THEN GOTO 9190' Skip tile colision check if we are not moving
9162 IF VX>0 THEN T3=VP(TT-&H7E):T4=VP(TT-&H5E):T5=VP(TT-&H3E):T6=VP(TT-&H1E)' Used to be TT-&H80+2, etc
9163 IF VX<0 THEN T3=VP(TT-&H80):T4=VP(TT-&H60):T5=VP(TT-&H40):T6=VP(TT-&H20)
9170 IF T3>=128 OR T4>=128 OR T5>=128 OR T6>=128 THEN X=X-VX
9189 GOSUB 9700' Check for item collection
9190 IF T0<124 AND T1<124 AND T2<124 THEN IF AT>0 THEN AT=AT-1 ELSE GS=3:VX=0:ST=3:SA=4:CMD PLYSOUND 9 ELSE AT=3
9191 GOSUB 9500' Check for room interaction (switches, fuse, computer)
9192 IF T0=180 OR T1=180 OR T2=180 THEN X=X-2:CMD PLYSOUND 15 ELSE IF T0=183 OR T1=183 OR T2=183 THEN X=X+2:CMD PLYSOUND 15 'Handle convoy belts
9197 IF X>=238 THEN C=C+1:X=2:GOSUB 8800' Load new room (right)
9198 IF X<=1 THEN C=C-1:X=236:GOSUB 8800' Load new room (left)
9199 RETURN

9200 'GS=2 Jumping
9210 VY=VY+5: IF VY>=0 THEN GS=3:CMD PLYSOUND 9
9211 Y=Y+VY/6
9212 X=X+VX
9213 ST=5
9214 SA=3
9241 GOSUB 8620
9244 TT = X/8
9249 IF T0>=128 OR T1>=128 OR T2>=128 THEN VY=0:Y=Y-VY:Y=((Y+2)/8+1)*8-2:DJ=0:GS=3:CMD PLYSOUND 10
9250 IF VX=0 THEN 9270' Skip horizontal collision check if we are not moving
9254 GOSUB 8600 ' Calculate left and right tiles (T3, T4, T5, T6 and T7)
9261 IF T3>=128 OR T4>=128 OR T5>=128 OR T6>=128 OR T7>=128 THEN X=X-VX:IF VY>-4 THEN GOSUB 9800
9270 IF DJ=1 AND VY>-13 THEN GOSUB 9820 'Double Jump check
9273 GOSUB 9700' Check for item collection
9296 IF Y<=0 THEN R=R-1:Y=124:GOSUB 8800' Load new room (up)
9297 IF X>=238 THEN C=C+1:X=2:GOSUB 8800' Load new room (right)
9298 IF X<=1 THEN C=C-1:X=236:GOSUB 8800' Load new room (left)
9299 RETURN

9300 'GS=3 Falling
9301 VY=VY+5: IF VY>38 THEN VY=38
9302 Y=Y+VY/6:X=X+VX
9314 SA=0:ST=6
9319 ' The next 3 lines enable gliding
9320 S=STICK(SS)
9321 IF S=3 OR S=2 OR S=4 THEN D=0:VX=VX+2:IF VX>2 THEN VX=2
9322 IF S=7 OR S=6 OR S=8 THEN D=14:VX=VX-2:IF VX<-2 THEN VX=-2
9341 GOSUB 8620
9344 TT = X/8
9350 IF VX=0 THEN 9385' Skip horizontal collision check if we are not moving
9354 GOSUB 8600 ' Calculate left and right tiles (T3, T4, T5, T6 and T7)
9381 IF T3>=128 OR T4>=128 OR T5>=128 OR T6>=128 OR T7>=128 THEN X=X-VX:GOSUB 9800 'Wall jump check
9385 IF T0>=124 OR T1>=124 OR T2>=124 THEN GS=1:JD=1:DJ=0:SA=4:ST=4:NK=1:VX=0:Y=((Y+32)/8)*8-32:CMD PLYSOUND 10
9390 IF DJ>0 THEN GOSUB 9820 'Double Jump check
9391 GOSUB 9700' Check for item collection
9396 IF Y>=124 THEN R=R+1:Y=0:GOSUB 8800' Load new room
9397 IF X>=238 THEN C=C+1:X=2:GOSUB 8800' Load new room
9398 IF X<=1 THEN C=C-1:X=238:GOSUB 8800' Load new room
9399 RETURN

9400 'GS=4 Holding into a wall
9401 WT=WT-1: IF WT>0 GOTO 9450 'The first 4 frames of wall jump are stick (skip tile checks and speed movement)
9402 'Wall grip re-check
9403 TT = (X+VX)/8
9404 TZ=TT+(Y+24)/8*32
9406 IF VX>0 THEN TZ=TZ+2
9407 T4=VP(TZ):T5=VP(TZ-&H20):T6=VP(TZ-&H40)
9408 GOSUB 9800 'Re-check wall grip
9409 IF GS<>4 THEN RETURN 'If we are no longer holding on a wall, skip the step
9410 ' Still holding on a wall, move and check for floor hit
9411 IF VY<12 THEN VY=VY+5 ELSE VY=12
9412 Y=Y+VY/6
9420 GOSUB 8620
9421 CMD PLYSOUND 11
9429 'IF VY<0 AND (T0>=128 OR T1>=128 OR T2>=128) THEN VY=0 'Wall grip never has negative speed
9449 IF VY>0 AND (T0>=124 OR T1>=124 OR T2>=124) THEN GS=1:JD=1:DJ=0:SA=4:ST=4:NK=1:VX=0:Y=((Y+32)/8)*8-32
9450 S=STICK(SS)
9451 IF VX>0 THEN IF S<>7 THEN US=0 ELSE US=US+1:IF US>=4 THEN GS=3 'Un-sticking from a wall
9452 IF VX<0 THEN IF S<>3 THEN US=0 ELSE US=US+1:IF US>=4 THEN GS=3
9490 ' Check for wall jump actually
9492 IF STRIG(SS) AND JD=0 THEN GS=2:VY=-38:VX=-VX:JD=1:WT=4:DJ=2:CMD PLYSOUND 7:IF D=0 THEN D=14 ELSE D=0'JD: Jump Debouncing
9496 IF Y>=124 THEN R=R+1:Y=0:GOSUB 8800' Load new room
9499 RETURN

9500 ' fun Check room interactions (switches, fuse & computer)
9501 IF T4=155 THEN GOSUB 9750:RETURN ' Fuse Box
9502 IF T4=119 THEN GOSUB 9760:RETURN ' Computer Terminal
9503 IC=(Y+2)\8*32+(X+2)\8+32
9504 IF VP(IC)=80 OR VP(IC+1)=81 OR VP(IC)=84 THEN GOSUB 9510:RETURN ' Switches
9505 IF VP(IC)=82 THEN GOSUB 9550:RETURN ' Open Fuse Box
9509 RETURN

9510 ' Fun swap bricks (Icons swap, but only one is actually checked)
9513 IF GI=0 THEN GI=-1:TR=7:GOSUB 10300:RETURN
9514 IF S=5 THEN GI=1 ELSE RETURN 'GI: Game Item action performed (if they do it once, we stop showing the tutorial popup)
9517 IF I3=0 THEN TR=8:GOSUB 10300:RETURN
9518 IF VP(IC)=84 THEN GOSUB 9600:RETURN ' Swap temp bricks
9519 IF BS=1 THEN BS=0:TP=&H70 ELSE BS=1:TP=&HD0
9520 CMD PLYSOUND 5
9521 ' Swap the image
9522 FOR I=0 TO 15
9523   A=VPEEK(1680+I+BS*16):VPOKE &H380+I,A:VPOKE &HB80+I,A:VPOKE &H1380+I,A'1680 = 210*8, 896 = 118*8 = &h380, steps start at 0, &h800 and &h1000
9524   VPOKE &H2280+I,TP:VPOKE &H2A80+I,TP:VPOKE &H3280+I,TP'640 = 80*8 = &h280, steps start at &H2000, &h2800 and &h3000
9529 NEXT
9530 ' Swap Bricks and console color
9531 FOR I=0 TO 7
9532   A=VPEEK(&H680+I+BS*8):VPOKE &H3C0+I,A:VPOKE &HBC0+I,A:VPOKE &H13C0+I,A' 208*8 = &h680, 120*8 = &H3C0, steps start at 0, &h800 and &h1000
9533   A=VPEEK(&H688+I-BS*8):VPOKE &H3C8+I,A:VPOKE &HBC8+I,A:VPOKE &H13C8+I,A '121*8=&H3C8
9539 NEXT
9540 ' Also swap the screen reading, change them for empty and solid
9541 FOR I=0 TO 672
9542   IF VP(I)=120 THEN VP(I)=152 ELSE IF VP(I)=152 THEN VP(I)=120
9543   IF VP(I)=121 THEN VP(I)=153 ELSE IF VP(I)=153 THEN VP(I)=121
9544 NEXT
9545 IF STICK(SS)=5 THEN 9545
9549 RETURN

9550 ' fun Can we set the fuse in an open box?
9551 IF I6=0 AND DI=0 THEN DI=-1:TR=9:GOSUB 10300:RETURN
9552 IF I6=1 THEN I6=2:TR=10:TV=154:TP=IC:GOSUB 12220:GOSUB 10300:RETURN'VPOKE IC+&H1800,154:VPOKE IC+&H1801,155:VPOKE IC+&H1820,186:VPOKE IC+&H1821,187:GOSUB 10300:RETURN ' Got the fuse, put it in place, close the box but do not chnce the VPOKE proxy
9559 RETURN

9600 ' fun start timer for temp bricks
9601 IF BT=0 THEN BT=1:TC=1:GOSUB 9610:BT=300:TS=160 ELSE BT=0:GOSUB 9610
9602 CMD PLYSOUND 5
9609 RETURN

9610 ' fun swap temp bricks
9611 ' Swap the indicator on the console
9612 TM=752+BT*16' TeMp value: initial value is 210 tile (210*8), dst tile is 116, 928=116*8, 752=210*8-928
9613 FOR I=928 TO 935
9614   A=VPEEK(TM+I):VPOKE I,A:VPOKE &H800+I,A:VPOKE &H1000+I,A
9618 NEXT
9619 CMD PLYSOUND 5
9620 ' Swap bricks
9621 TM=688+BT*8' TeMp value: initial value is 208 tile (208*8), dst tile is 122, 976=122*8, 688=208*8-976
9622 FOR I=976 TO 983
9623   A=VPEEK(TM+I):VPOKE I,A:VPOKE &H800+I,A:VPOKE &H1000+I,A
9629 NEXT
9630 ' Also swap the screen reading, change them for empty and solid
9631 FOR I=0 TO 672
9632   IF VP(I)=184 THEN VP(I)=122 ELSE IF VP(I)=122 THEN VP(I)=184
9633 NEXT
9648 IF STICK(SS)=5 THEN 9648
9649 RETURN

9650 ' fun Swap tmp brick color
9651 IF TC=1 THEN TC=0:TS=TS-5 ELSE TC=1:IF TS>60 THEN TS=TS-45 ELSE TS=TS-10
9652 TM=688+TC*8' TeMp value: initial value is 208 tile (208*8), dst tile is 122, 976=122*8, 688=208*8-976
9653 FOR I=976 TO 983
9654   A=VPEEK(TM+I):VPOKE I,A:VPOKE &H800+I,A:VPOKE &H1000+I,A
9655 NEXT
9658 CMD PLYSOUND 13
9659 RETURN

9700 ' fun Check for item collection
9701 IF IR=0 THEN RETURN
9702 IC=(X+4)/8+(Y+12)/8*32
9703 II=IC:GOSUB 9710 ' Check tile for item
9704 II=IC+32:GOSUB 9710 ' Check tile for item
9705 II=IC+64:GOSUB 9710 ' Check tile for item
9709 RETURN

9710 ' fun Check tile for item
9711 I0=VP(II):IF (I0 MOD 2 = 0 AND I0>=96 AND I0<=106) THEN TI=(II-32):GOSUB 9720' Pick up item
9719 RETURN

9720 ' fun Pick up item
9721 TV=0:TP=TI:GOSUB 12220 ' Put 0 in TI position (4 tiles)
9722 NI=NI+1:CI(NI)=VP(TI)
9723 TV=VP(TI):TP=&H2A5+NI*3:GOSUB 12220' Need to add 6
9724 VP(TI)=0:VP(TI+1)=0
9725 VP(TI+32)=0:VP(TI+33)=0
9726 IF RR(R*7+C+1) = 0 THEN RR(R*7+C+1)=TI' Set the item collected position on room details
9728 IF TV=64 THEN I1=1:TR=0:GOSUB 10300 'Boots - Double Jump item
9729 IF TV=66 THEN I2=1:TR=1:GOSUB 10300 'Glove - Wall jump item
9730 IF TV=68 THEN I3=1:TR=2:GOSUB 10300 'ID Card - Brick Swap item
9731 IF TV=70 THEN I4=1:TR=3:GOSUB 10300 'Wrench, to open fuse box
9732 IF TV=72 THEN I5=1:TR=4:GOSUB 10300 'Boot disk - boot computer
9733 IF TV=74 THEN I6=1:TR=5:GOSUB 10300 'Fuse - Fix the main power

9739 RETURN

9750 ' fun open fuse box
9751 IF I4=0 AND DI=0 THEN DI=-1:TR=13:GOSUB 10300:RETURN
9752 IF I6=2 AND DI=0 THEN DI=-1:TR=14:GOSUB 10300:RETURN
9753 IF DI=-1 THEN RETURN
9755 ' Open, show broken fuse
9756 TV=82:TP=TT-&H61:GOSUB 12220'IT=&H1800+TT-&H60-1:VPOKE IT,82:VPOKE IT+1,83::VPOKE IT+32,114::VPOKE IT+33,115
9757 ' Replace VPEEK proxy
9758 VP(TP)=82:VP(TP+1)=83:VP(TP+32)=114:VP(TP+33)=115
9759 RETURN

9760 ' fun access computer
9761 IF I6<2 AND DI=0 THEN DI=-1:TR=11:GOSUB 10300:RETURN' IF NO POWER, show NO POWER Message
9762 IF I6=2 AND I5=0 THEN DI=-1:TR=12:GOSUB 10300:RETURN' IF POWER BUT NO DISK show NO DISK Message
9763 IF I6=2 AND I5=1 THEN GOSUB 10000:GOTO 2000' IF POWER AND DISK show ending
9769 RETURN

9800 'fun Wall jump check: need to have a substantial amount of wall to grip to
9801 IF I2=0 THEN RETURN' Can't hold to walls without the Glove (I2)
9802 IF T5>=128 AND (T4>=128 OR T6>=128) THEN 9803 ELSE 9810
9803 IF GS<4 THEN GS=4:CMD PLYSOUND 11:SA=3:ST=7:WT=4
9804 IF VY>12 THEN VY=12 ELSE IF VY<0 THEN VY=0
9809 RETURN
9810 ' No grip
9811 IF GS=4 THEN GS=2:CMD PLYSOUND 10
9819 RETURN

9820 'fun Double Jump Check
9821 IF I1=0 THEN RETURN
9823 IF JD=0 AND STRIG(SS) THEN GS=2:CMD PLYSOUND 20 ELSE 9829
9824 SA=0:ST=4:JD=1:DJ=0:VY=VY-38:IF VY<-38 THEN VY=-38 ELSE IF VY>-28 THEN VY=-28
9825 S=STICK(SS)
9826 IF S=3 THEN VX=2:D=0
9827 IF S=7 THEN VX=-2:D=14
9829 RETURN

9900 'fun Update enemies
9901 IF EC=0 THEN RETURN ' Skip enemy updates if no enemies
9902 FOR EI=1 TO EC
9903  EW(EI)=EW(EI)+1:IF EW(EI)=3 THEN EW(EI)=0:ES(EI)=ES(EI)+EV(EI)/2:IF ES(EI)=3 THEN ES(EI)=0 ELSE IF ES(EI)=-1 THEN ES(EI)=2
9904  ON ET(EI) GOSUB 9910,9920,9930,9940 ' Update enemy based on type
9905  ' Colision box detection
9906  ' Original check: IF ABS(X-EX(EI))<16 AND Y-EY(EI)>-31 AND Y-EY(EI)<15
9907  IF ABS(X-EX(EI))<12 AND Y-EY(EI)>-29 AND Y-EY(EI)<12 THEN PD=8 'Maybe we can do a more refined check if a "gross" check succeed
9908 NEXT I
9909 RETURN

9910 'fun Update enemy type 1: Horizontal, lower
9911 EX(EI)=EX(EI)+EV(EI)
9913 IF EX(EI) MOD 8=0 THEN EL=VP(((EY(EI)+9)\8)*32+(EX(EI)+8+2*EV(EI))\8):IF EL=138 OR EL=140 THEN EV(EI)=-EV(EI):CMD PLYSOUND 17
9919 RETURN

9920 'fun Update enemy type 2: Horizontal, upper
9921 EX(EI)=EX(EI)+EV(EI)
9923 IF EX(EI) MOD 8=0 THEN EL=VP(((EY(EI)+8)\8)*32+(EX(EI)+8+2*EV(EI))\8):IF EL=170 OR EL=172 THEN EV(EI)=-EV(EI):CMD PLYSOUND 17
9929 RETURN

9930 'fun Update enemy type 3: Vertical, right wall
9931 EY(EI)=EY(EI)+EV(EI)
9933 IF EY(EI) MOD 8=7 THEN EL=VP(((EY(EI)+8+3*EV(EI))\8)*32+(EX(EI)+8)\8):IF EL=142 OR EL=174 THEN EY(EI)=EY(EI)-EV(EI):EV(EI)=-EV(EI):CMD PLYSOUND 17
9939 RETURN

9940 'fun Update enemy type 4: Vertical, left wall
9941 EY(EI)=EY(EI)+EV(EI)
9943 IF EY(EI) MOD 8=7 THEN EL=VP(((EY(EI)+8+3*EV(EI))\8)*32+(EX(EI))\8):IF EL=141 OR EL=173 THEN EY(EI)=EY(EI)-EV(EI):EV(EI)=-EV(EI):CMD PLYSOUND 17
9949 RETURN

8800 ' fun Load new room
8801 'CMD PLYMUTE pausing music here does more harm than good
8802 FOR I=0 TO 7: PUT SPRITE I,(0,-16),0:NEXT I' TODO: Maybe reload the player earlier (8010 or so), to make it feel more snappy
8803 ' Record player state when entering the room
8004 RX=X:RY=Y:RV=VX:RW=VY:RG=GS:RD=D:RA=SA:RT=ST
8005 DI=0:IF GI=-1 THEN GI=0' We show the tutorial action once per room
8806 CMD WRTSCR R*7+C+3
8807 IF R=3 AND C=3 THEN GOSUB 8860' This part is only needed on room 3-3, which is the one with the lower part of the screen
8808 RI=RR(R*7+C+1) ' We store collection of items on the room info (we store the position in screen)
8809 IF RI>0 THEN TP=RI:TV=0:GOSUB 12220
8810 EC=0:LT=196*8:NL=0:IR=0:NB=0'TODO: We could pre-caclulate if there are items, lasers and belts in the room, or hardcode it in one specific tile

8820 IF BT>0 THEN BT=0:TC=0:TS=0:GOSUB 9610
8821 FOR I=0 TO 672
8822  TT=VPEEK(&H1800+I)
8823  IF TT<62 THEN 8836 ' Given that most of the rooms are places you can walk through, this saves a lot of IF checks
8824  IF TT=62 OR TT=63 THEN NL=1: GOTO 8836 ' There are lasers in the room
8825  IF TT>=64 AND TT<=74 THEN IR=1:GOTO 8836 ' There are items in the room
8826  ' TODO: If we put the enemies together after 192 we can also skip most comparisons here
8828  IF TT=108 THEN TT=0:GOSUB 8910:GOTO 8836 ' Parse enemy type 1
8829  IF TT=76 THEN TT=0:GOSUB 8920:GOTO 8836 ' Parse enemy type 2
8830  IF TT=79 THEN TT=0:GOSUB 8930:GOTO 8836 ' Parse enemy type 3
8831  IF TT=78 THEN TT=0:GOSUB 8940:GOTO 8836 ' Parse enemy type 4
8832  IF TT=120 AND BS=1 THEN TT=152:GOTO 8836 ' TODO Maybe we can put all the special cases together, so we can save more comparisons
8833  IF TT=121 AND BS=0 THEN TT=153:GOTO 8836
8834  IF TT=180 OR TT=183 THEN NB=1 ' There are convoy belts in the room
8836  VP(I)=TT
8837 NEXT I
8838 'CMD PLYPLAY pausing music here does more harm than good
8839 RETURN

8840 ' fun Initialize enemy
8841 EC=EC+1
8842 EX(EC)=(I MOD 32)*8
8843 EY(EC)=(I\32)*8-1
8849 RETURN

8850 ' fun Preload sprite where the enemy is located
8851 PUT SPRITE 3+EC,(EX(EC),EY(EC)),14,25+ES(EC)+ET(EC)*3
8859 RETURN

8860 ' fun Redraw items on the bottom area and number of deaths (only needed on reload of the initial screen and when debugging)
8862 FOR I=1 TO 6
8863  IF CI(I)>0 THEN TP=&H2A5+I*3:TV=CI(I):GOSUB 12220' set TV (tile value) into TP (tile position) 16x16 tiles
8864 NEXT I
8865 GOSUB 8650:RETURN

8910 ' fun Parse enemy type 1 (horizontal, bottom)
8911 GOSUB 8840' Initialize enemy
8912 ET(EC)=1:EV(EC)=2
8914 GOSUB 8850 ' Preload sprite
8918 VPOKE &H1800+I,0:VPOKE &H1801+I,0
8919 RETURN

8920 ' fun Parse enemy type 2 (horizontal, top)
8921 GOSUB 8840' Initialize enemy
8922 ET(EC)=2:EV(EC)=2
8923 EY(EC)=EY(EC)-8
8924 GOSUB 8850' Preload sprite
8928 VPOKE &H1800+I,0:VPOKE &H1801+I,0
8929 RETURN

8930 ' fun Parse enemy type 3 (vertical, right)
8931 GOSUB 8840' Initialize enemy
8932 ET(EC)=3:EV(EC)=2
8935 GOSUB 8850' Preload sprite
8938 VPOKE &H1800+I,0:VPOKE &H1820+I,0
8939 RETURN

8940 ' fun Parse enemy type 4 (vertical, left)
8941 GOSUB 8840' Initialize enemy
8942 ET(EC)=4:EV(EC)=2
8944 EX(EC)=EX(EC)-8
8945 GOSUB 8850' Preload sprite
8948 VPOKE &H1800+I,0:VPOKE &H1820+I,0
8949 RETURN

10000 'fun ending
10001 CMD PLYMUTE:CMD PLYSONG 2:CMD PLYPLAY' Song 2 is silent
10002 FOR I=0 TO 7:PUT SPRITE I,,0,0:NEXT
10005 CMD WRTSCR 38
10009 CMD RESTORE 43:RESTORE 16:TK=0' Text sKip enable (to skip text using space) disabled
10010 ' Blank screen, show text as in a console
10020 TY=1:GOSUB 10200
10021 TY=3:GOSUB 10200
10030 TY=5:GOSUB 10200
10040 TY=8:GOSUB 10200
10050 TY=10:GOSUB 10200
10051 TY=11:GOSUB 10200
10052 TY=12:GOSUB 10200
10070 TY=15:GOSUB 10200
10080 TY=18:GOSUB 10200
10090 TY=22:GOSUB 10200
10091 IF STRIG(SS)=0 THEN 10091
10099 RETURN

10200 'Writing text on Screen subroutine (a letter at a time, with sound)
10201 READ T$:TX=1
10210 FOR I=1 TO LEN(T$)
10220   CT$=MID$(T$,i,1)
10230   IF CT$="@" THEN TW=12:TX=TX-1:GOTO 10244 ELSE TW=3
10231   IF CT$=" " THEN TT=0:GOTO 10240
10232   TT=ASC(CT$)+159
10233   IF TT<224 THEN TT=TT+7 'Fix the gap on the ASCII numbers and the letters
10240   VPOKE &H1800+TX-1+TY*32+I,TT:CMD PLYSOUND 1
10244   T=TIME
10245   IF TK=1 AND STRIG(SS) THEN TX=1:GOSUB 10900:RETURN
10246   IF TIME<T+TW GOTO 10245
10250 NEXT I
10290 RETURN

10300 ' fun Display a pop-up
10301 CMD RESTORE 43:RESTORE TR:READ T$
10302 ' Store current scrren info
10303 KS=&H18C5
10304 FOR I=0 TO 9 'Rows
10305   FOR J=0 to 21 'Columns
10306     KT(I*22+J)=VPEEK (KS+I*32+J)
10307   NEXT J
10308 NEXT I

10309 ' Hide only the sprites that are behind the popup
10310 ' Main character
10311 IF X>24 AND X<214 AND Y>16 AND Y<112 THEN PUT SPRITE 1,,0,0:PUT SPRITE 2,,0,0:PUT SPRITE 3,,0,0
10314 ' Enemies
10315 FOR I=1 TO EC ' Hide the enemies
10316   IF EX(I)>24 AND EX(I)<216 AND EY(I)>32 AND EY(I)<112 THEN PUT SPRITE I+3,,0,0
10317 NEXT

10319 VPOKE KS,2:FOR J=1 to 20:VPOKE KS+J,36:NEXT J:VPOKE KS+21, 3
10320 FOR I=1 TO 8 'Rows
10321   KR=KS+I*32
10322   VPOKE KR, 4
10330   FOR J=1 to 20 'Columns
10340     VPOKE KR+J, 0
10350   NEXT J
10351   VPOKE KR+21, 4
10360 NEXT I
10370 KS=&H19C5:VPOKE KS,34:FOR J=1 to 20:VPOKE KS+J,36:NEXT J:VPOKE KS+21, 35
10371 CMD PLYSOUND 3
10375 TX=6:TY=7:GOSUB 10900
10376 IF STRIG(SS) THEN 10376
10379 IF NOT STRIG(SS) THEN 10379

10380 ' Dismiss dialog
10381 CMD PLYSOUND 4
10382 KS=&H18C5
10383 FOR I=0 TO 9 'Rows
10384   FOR J=0 to 21 'Columns
10385     VPOKE KS+I*32+J, KT(I*22+J)
10386   NEXT J
10387 NEXT I
10388 IF STRIG(SS) THEN 10388
10390 RETURN

10400 ' fun animate convoy belts
10401 ' each frame, we swap state (we have 4 states)
10402 CB=CB+8
10404 IT=&HA8+CB: IF CB=32 THEN CB=0 'Left tiles are stored in 54 (IT+&H100)
10405 FOR I=2 TO 4 'The only bytes that change are the middle ones
10406  TT=VPEEK(IT+I):VPOKE &H5B8+I,TT:VPOKE &HDB8+I,TT:VPOKE &H15B8+I,TT
10407  TT=VPEEK(IT+&H100+I):VPOKE &H5A0+I,TT:VPOKE &HDA0+I,TT:VPOKE &H15A0+I,TT
10408 NEXT
10409 RETURN

10900 'fun Write text T$ on Screen at position TX, TY (in row/column)
10901 TF=0
10910 FOR I=1 TO LEN(T$)
10911   TF=TF+1
10920   CT$=MID$(T$,i,1)
10940   IF CT$=" " THEN TT=0:GOTO 10949
10941   IF CT$="#" THEN TF=0:TY=TY+2:GOTO 10950
10942   IF CT$="@" THEN TF=TF-1:GOTO 10950 ' Non printable character
10943   TT=ASC(CT$)+159
10944   IF TT<224 THEN TT=TT+7 'Fix the gap on the ASCII numbers and the letters
10949   VPOKE &H1800+TX-1+TY*32+TF, TT
10950 NEXT I
10990 RETURN

11000 ' fun Process laser animations
11001 ' Skip laser death check if lasers are off
11002 IF LS=0 THEN 11091
11003 ' Horizontal lasers check
11004 CMD PLYSOUND 16
11010 I0=X\8+1+Y\8*32
11011 IF VP(I0)=62 OR VP(I0+32)=62 OR VP(I0+64)=62 OR VP(I0+96)=62 THEN PD=8
11020 ' Vertical lasers check
11021 I0=X\8+(Y+12)\8*32
11022 IF VP(I0)=63 OR VP(I0+1)=63 OR VP(I0+2)=63 THEN PD=8
11090 ' Check animations (we animate when they are off to have consistent frame drops if any) TODO: Does this make sense
11091 TA=TA+1 ' TA: timer for animation
11092 IF TA MOD 4 = 0 GOSUB 12000
11093 IF TA MOD 4 = 2 GOSUB 12100 'we animate vertical one horizontal separately
11098 IF TA MOD 40 = 0 THEN GOSUB 11100
11099 RETURN

11100 ' SWAP LASER STATE color at tiles 62, 63,from &H89 to 00. Color table starts at &H2000
11110 IF LS=1 THEN LC=&H00:LS=0 ELSE LC=&H89:LS=1
11120 FOR I=&H21F0 TO &H21FF
11130  VPOKE I, LC:VPOKE I+&H800, LC: VPOKE I+&H1000, LC
11140 NEXT I
11150 ' TODO: Apply SFX for lasers turning on and off
11190 RETURN

11300 ' fun teleport start
11301 PUT SPRITE 0,(X,Y+4),13,41
11302 CMD PLYSOUND 12
11310 I=41' Animate teleport in
11311  TIME=0:PUT SPRITE 0,,,I
11312 IF TIME<4 THEN 11312 ELSE I=I+1:IF I<44 THEN 11311
11319 RETURN

11320 I=44' Animate teleport out
11321 'CMD PLYSOUND 12
11322 TIME=0:PUT SPRITE 0,,,I
11323 IF TIME<4 THEN 11323 ELSE I=I-1: IF I>40 THEN 11322
11324 PUT SPRITE 0,(0,-16),0
11329 RETURN


12000 'ANIMATE LASER (horizontal), we have 4 patterns, they all have the same colors, tile 144-147, base address for the copy is tile 62 -> 62*8=496 -> 0x1F0
12001 ' First step of the animation, swap patterns
12002 LT=LT+8:IF LT=200*8 THEN LT=196*8
12050 'Replace tiles (vertical), current pattern, starting on LV: Laser Vpoke position
12052 FOR I=0 TO 7
12053  LM=VPEEK(LT+I)
12054  VPOKE &H1F0+I, LM:VPOKE &H9F0+I, LM:VPOKE &H11F0+I, LM
12056 NEXT I
12059 RETURN

12100 'ANIMATE LASER (vertical), we have 4 patterns, they all have the same colors, tile 144-147, base address for the copy is tile 62 -> 62*8=496 -> 0x1F0
12101 'We only need to swap pattern once in LT, on the horizintal one, the patter for vertical is 4 tiles ahead (32 positions)
12150 FOR I=0 TO 7'The vertical tiles are 32 positions (4 tiles) ahead of the vertical ones
12153  LM=VPEEK(LT+I+32)
12155  VPOKE &H1F8+I, LM:VPOKE &H9F8+I, LM:VPOKE &H11F8+I, LM
12156 NEXT I
12159 RETURN

12220 ' fun set TV (tile value) into TP (tile position) 16x16 tiles
12221 TQ=TP+&H1800:VPOKE TQ,TV:VPOKE TQ+1,TV+1:VPOKE TQ+&H20,TV+&H20:VPOKE TQ+&H21,TV+&H21
12222 RETURN
