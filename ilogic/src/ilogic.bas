FILE "../res/sprites.bin.plet5"
FILE "../res/map.chr.plet5"
FILE "../res/map.clr.plet5"

INCLUDE "map_2.inc"

FILE "../res/map_3_6.plet5"
FILE "../res/ilogic.akm"

FILE "../res/splash.chr.plet5" '40
FILE "../res/splash.clr.plet5"
FILE "../res/splash_0_0.plet5"


20 CMD PLYLOAD 39, 1
21 'CMD PLYSONG 0
22 'CMD PLYPLAY

100 COLOR 15,1,1:SCREEN 2,2,0
110 DEFINT A-Z

1010 DIM RR(49), VP(672), CI(5), KT(220) 'RR - Room Resource, VP - VPeek replacement, CI - Collected items, KT - Keep tiles (for showing a popup)



5000 ' Start screen
5001 CMD CLRSCR
5010 CMD WRTCHR 40:CMD WRTCLR 41 ' Load tileset (patterns and colors) Got to load them 3 times
5011 CMD WRTVRAM 40, &H800:CMD WRTVRAM 41, &H2800
5012 CMD WRTVRAM 40, &H1000:CMD WRTVRAM 41, &H3000
5020 CMD WRTSCR 42
5090 IF STRIG(0) THEN SS=0:GOTO 7990
5091 IF STRIG(1) THEN SS=1:GOTO 7990
5099 GOTO 5090

7990 C=3:R=3' Actual initial room of the game
7991 I1=0:I2=0:I3=0:I4=0:I5=0:I6=0' No items hold at the beginning of the game
7992 GM=1' Game Mode: 1: Infinite lifes, 2: One life with 3 hearts, 0: God Mode

7994 ' DEBUG OVERRIDE INIT
7995 'GM=0
7996 'C=5:R=3
7999 I1=1:I2=1:I3=1:I4=1:I5=1:I6=2

8001 CMD CLRSCR
8010 CMD WRTCHR 1:CMD WRTCLR 2 ' Load tileset (patterns and colors) Got to load them 3 times
8011 CMD WRTVRAM 1, &H800:CMD WRTVRAM 2, &H2800
8012 CMD WRTVRAM 1, &H1000:CMD WRTVRAM 2, &H3000

8020 CMD WRTVRAM 0, &H3800 ' Load sprites WRTSPRPAT

8049 ' Setup of visual debug
8050 FD=2:PUT SPRITE 31,(0,174),FD,0:PUT SPRITE 30,(200,174),PD,0

8100 'New game initialization
8101 AD=1:X=8:Y=120:GS=1:GI=0
8102 Y=20
8103 DIM EX(4),EY(4),EV(4),ET(4),ES(4),EW(4)' Enemy X, Y, Velocity, Type, Sprite, Wait. EC: Enemy Count
8110 FOR I=0 TO 5:CI(I)=0:NEXT I:NI=0' Clear inventory. NI: Number of items collected
8190 GOSUB 8800 ' Load initial room
8199 GOTO 9000 ' Start game loop

8700 ' fun player dies
8701 ' Animate death: TODO
8702 TIME=0
8703 IF TIME<25 THEN 8703 'for now, just add a 1 second delay
8751 ' Restore player state to the beginning of the room
8752 X=RX:Y=RY:VX=RV:VY=RW:GS=RG:D=RD:SA=RA:ST=RT
8799 IF STICK(SS)=0 THEN RETURN ELSE 8799

9000 ' BEGIN GAME LOOP
9001 TIME=0:PD=0' PD: Player Dead, player is not dead at the beginning of each loop
9002 IF STRIG(SS)=0 THEN JD=0'If the trigger is not pressed, it is debounced

9003 ' UPDATE
9004 ON GS GOSUB 9100, 9200, 9300, 9400' Update player based on Game State (GS)
9005 GOSUB 9900 ' Update Enemies
9009 ' DRAW
9010 PUT SPRITE 1,(X,Y+YO),15,D:PUT SPRITE 0,(X,Y+4+YO),4,9+SA+D
9020 PUT SPRITE 2,(X,Y+14),14,1+ST+D
9030 IF EC=0 THEN 9050 'Skip enemy draw if no enemies
9031 FOR I=1 TO EC
9035  PUT SPRITE 3+I,(EX(I),EY(I)),14,25+ES(I)+ET(I)*3
9039 NEXT I
9050 IF NL>0 GOSUB 11000 'process laser animations and check for death (only if there are lasers)
9051 IF BT>0 THEN BT=BT-1:IF BT=0 THEN GOSUB 9610 ELSE IF BT=TS THEN GOSUB 9650' fun Swap temporary bricks
9080 ' END GAME LOOP
9081 IF TIME=0 THEN FD=2 ELSE IF TIME>1 THEN FD=8 ELSE FD=10 ' FD is debug for detecting frame drops
9082 PUT SPRITE 31,,FD: PUT SPRITE 30,,PD ' Visual debig of Frame Drops and Player Death
9083 IF PD>0 AND GM=1 THEN GOSUB 8700
9090 IF TIME<1 GOTO 9090 ELSE 9000

9100 'GS=1 Standing
9101 S=STICK(SS)
9102 VX=0
9112 IF S=3 THEN VX=1:IF D=14 OR SA=4 THEN D=0:AD=1:SA=0:ST=0:GOTO 9140 ELSE GOTO 9118 ' Animate Walk
9113 IF S=7 THEN VX=-1:IF D=0 OR SA=4 THEN D=14:AD=1:SA=0:ST=0:GOTO 9140 ELSE GOTO 9118 ' Animate Walk
9114 SA=4:ST=3:YO=0' SA=4 marks a resting position
9117 GOTO 9140 ' Skip walk animation (no input)
9118 IF S0=4 THEN S0=0 ELSE S0=S0+1:GOTO 9140 ' No animation this frame
9120 SA=SA+AD: IF SA=3 THEN AD=-1 ELSE IF SA=0 THEN AD=1
9121 ST=ST+1:IF ST=3 THEN ST=0
9122 IF ST=1 THEN YO=1 ELSE YO=0
9140 IF STRIG(SS) AND JD=0 THEN GS=2:VY=-14:SA=0:ST=4:JD=1:DJ=1:WT=4:RETURN 'JD: Jump Debouncing, DJ=double jump
9141 X=X+VX
9142 TT = ((Y+32)/8)*32
9143 T0 = VP (TT+(X+2)/8)
9144 T1 = VP (TT+(X+8)/8)
9145 T2 = VP (TT+(X+15)/8)
9146 TT = TT + X/8
9161 IF VX=0 THEN GOTO 9190' Skip tile colision check if we are not moving
9162 IF VX>0 THEN T3=VP(TT-&H80+2):T4=VP(TT-&H60+2):T5=VP(TT-&H40+2):T6=VP(TT-&H20+2)
9163 IF VX<0 THEN T3=VP(TT-&H80):T4=VP(TT-&H60):T5=VP(TT-&H40):T6=VP(TT-&H20)
9170 IF T3>=128 OR T4>=128 OR T5>=128 OR T6>=128 THEN X=X-VX
9189 GOSUB 9700' Check for item collection
9190 IF T0<124 AND T1<124 AND T2<124 THEN IF AT>0 THEN AT=AT-1 ELSE GS=3:VX=0:ST=3:SA=4 ELSE AT=3
9191 GOSUB 9500' Check for room interaction (switches, fuse, computer)
9192 IF T0=180 OR T1=180 OR T2=180 THEN X=X-1 ELSE IF T0=183 OR T1=183 OR T2=183 THEN X=X+1 'Handle convoy belts
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
9252 ' TODO: This calculations are the same for Going up, down, and sliding wall, we can consolidate a subroutine
9254 IF VX>0 THEN T3=VP(TT+(Y+32)/8*32+2):T4=VP(TT+(Y+24)/8*32+2):T5=VP(TT+(Y+16)/8*32+2):T6=VP(TT+(Y+8)/8*32+2):T7=VP(TT+(Y+2)/8*32+2)
9255 IF VX<0 THEN T3=VP(TT+(Y+32)/8*32):T4=VP(TT+(Y+24)/8*32):T5=VP(TT+(Y+16)/8*32):T6=VP(TT+(Y+8)/8*32):T7=VP(TT+(Y+2)/8*32)
9261 IF T3>=128 OR T4>=128 OR T5>=128 OR T6>=128 OR T7>=128 THEN X=X-VX:IF VY>-4 THEN GOSUB 9800
9270 IF DJ=1 AND VY>-4 THEN GOSUB 9820 'Double Jump check
9273 GOSUB 9700' Check for item collection
9296 IF Y<=0 THEN R=R-1:Y=124:GOSUB 8800' Load new room
9297 IF X=239 THEN C=C+1:X=2:GOSUB 8800' Load new room
9298 IF X=1 THEN C=C-1:X=238:GOSUB 8800' Load new room
9299 RETURN

9300 'GS=3 Falling
9301 VY=VY+1: IF VY>14 THEN VY=14
9302 Y=Y+VY/4:X=X+VX
9314 SA=0:ST=6
9319 ' The next 3 lines enable gliding
9320 S=STICK(SS)
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
9396 IF Y>=124 THEN R=R+1:Y=0:GOSUB 8800' Load new room
9397 IF X=239 THEN C=C+1:X=2:GOSUB 8800' Load new room
9398 IF X=1 THEN C=C-1:X=238:GOSUB 8800' Load new room
9399 RETURN

9400 'GS=4 Holding into a wall
9401 WT=WT-1: IF WT>0 GOTO 9410 'Only do wall grip check every 4 frames
9402 TT = X/8
9403 IF VX>0 THEN T4=VP(TT+(Y+24)/8*32+2):T5=VP(TT+(Y+16)/8*32+2):T6=VP(TT+(Y+8)/8*32+2)
9404 IF VX<0 THEN T4=VP(TT+(Y+24)/8*32):T5=VP(TT+(Y+16)/8*32):T6=VP(TT+(Y+8)/8*32)
9405 GOSUB 9800 'Re-check wall grip
9409 IF GS<>4 THEN RETURN 'If we are no longer holding on a wall, skip the step
9410 ' Still holding on a wall, move and check for ceiling and floor hit
9411 IF VY<7 THEN VY=VY+1
9412 Y=Y+VY/4
9413 IF VY<0 THEN TT=((Y+2)/8)*32 ELSE TT=((Y+32)/8)*32
9420 T0 = VP (TT+(X+2)/8)
9421 T1 = VP (TT+(X+8)/8)
9422 T2 = VP (TT+(X+15)/8)
9429 IF VY<0 AND (T0>=128 OR T1>=128 OR T2>=128) THEN VY=0
9449 IF VY>0 AND (T0>=124 OR T1>=124 OR T2>=124) THEN GS=1:JD=1:DJ=0:SA=4:ST=4:NK=1:VX=0:Y=((Y+32)/8)*8-32
9450 S=STICK(SS)
9451 IF VX>0 THEN IF S<>7 THEN US=0 ELSE US=US+1:IF US=8 THEN GS=3
9452 IF VX<0 THEN IF S<>3 THEN US=0 ELSE US=US+1:IF US=8 THEN GS=3
9490 ' Check for wall jump actually
9492 IF STRIG(SS) AND JD=0 THEN GS=2:VY=-14:VX=-VX:JD=1:WT=4:IF D=0 THEN D=14 ELSE D=0'JD: Jump Debouncing
9493 ' TODO Consider moving the jump debouncing to the main game loop
9496 IF Y>=124 THEN R=R+1:Y=0:GOSUB 8800' Load new room
9499 RETURN

9500 ' fun Check room interactions (switches, fuse & computer)
9501 IF T4=155 THEN GOSUB 9750:RETURN ' Fuse Box
9502 IF T4=87 THEN GOSUB 9760:RETURN ' Computer Terminal
9503 IC=(Y+2)\8*32+(X+2)\8+32
9504 IF VP(IC)=80 OR VP(IC+1)=81 OR VP(IC)=84 THEN GOSUB 9510:RETURN ' Switches
9505 IF VP(IC)=82 THEN GOSUB 9550:RETURN ' Open Fuse Box
9506 IF VP(IC)=80 OR VP(IC+1)=81 OR VP(IC)=84 THEN GOSUB 9510:RETURN ' Computer
9509 RETURN

9510 ' Fun swap bricks (Icons swap, but only one is actually checked)
9513 IF GI=0 THEN GI=-1:T$="PRESS \ TO OPERATE#THE CONFIG SWITCHES[":GOSUB 10300:RETURN
9514 IF S=5 THEN GI=1 ELSE RETURN 'GI: Game Item action performed (if they do it once, we stop showing the tutorial popup)
9517 IF I3=0 THEN T$="I NEED MY ID CARD TO#OPERATE THE CONFIG#SWITCHES[":GOSUB 10300:RETURN
9518 IF VP(IC)=84 THEN GOSUB 9600:RETURN ' Swap temp bricks
9519 IF BS=1 THEN BS=0:TP=&H70 ELSE BS=1:TP=&HD0
9520 ' And swap the indicator on the console
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
9551 IF I6=0 AND DI=0 THEN DI=-1:T$="THE FUSE IS BROKEN[#I NEED A NEW ONE TO#REPLACE IT[":GOSUB 10300:RETURN
9552 IF I6=1 THEN I6=2:T$="I SWAPPED THE FUSE[#MAIN POWER IS BACK[#I CAN REBOOT THE#SYSTEM^":TV=154:TP=IC:GOSUB 12220:GOSUB 10300:RETURN'VPOKE IC+&H1800,154:VPOKE IC+&H1801,155:VPOKE IC+&H1820,186:VPOKE IC+&H1821,187:GOSUB 10300:RETURN ' Got the fuse, put it in place, close the box but do not chnce the VPOKE proxy
9559 RETURN

9560 ' fun check the computer
9561 IF I6=0 THEN T$="THE COMPUTER IS OFF[#I NEED TO RESTORE#MAIN POWER[":GOSUB 10300:RETURN

9600 ' fun start timer for temp bricks
9601 IF BT=0 THEN BT=1:TC=1:GOSUB 9610:BT=600:TS=300 ELSE BT=0:GOSUB 9610
9609 RETURN

9610 ' fun swap temp bricks
9611 ' Swap the indicator on the console
9612 TM=752+BT*16' TeMp value: initial value is 210 tile (210*8), dst tile is 116, 928=116*8, 752=210*8-928
9613 FOR I=928 TO 935
9614   A=VPEEK(TM+I):VPOKE I,A:VPOKE &H800+I,A:VPOKE &H1000+I,A
9619 NEXT
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
9651 IF TC=1 THEN TC=0:TS=TS-5 ELSE TC=1:IF TS>100 THEN TS=TS-95 ELSE TS=TS-20
9652 TM=688+TC*8' TeMp value: initial value is 208 tile (208*8), dst tile is 122, 976=122*8, 688=208*8-976
9653 FOR I=976 TO 983
9654   A=VPEEK(TM+I):VPOKE I,A:VPOKE &H800+I,A:VPOKE &H1000+I,A
9655 NEXT
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
9723 NI=NI+1:CI(NI)=VP(TI)
9724 TV=VP(TI):TP=&H1AA0+NI*3:GOSUB 12220
9725 VP(TI)=0:VP(TI+1)=0
9726 VP(TI+32)=0:VP(TI+33)=0
9727 IF RR(R*7+C+1)\64 = 0 THEN RR(R*7+C+1)=TI*64' Set the item collected position on room details
9728 IF TV=64 THEN I1=1:T$="GOT THE NG_BOOTS^#I CAN DOUBLE JUMP IN#THE AIR[":GOSUB 10300 'Double Jump item
9729 IF TV=66 THEN I2=1:T$="GOT THE ST_GLOVE^#I CAN HOLD TO WALLS#AND JUMP FROM THEM[":GOSUB 10300 'Wall jump item
9730 IF TV=68 THEN I3=1:T$="GOT MY ID CARD^#I CAN USE THE CONFIG#SWITCHES[":GOSUB 10300'ID Card - Brick Swap item
9731 IF TV=70 THEN I4=1:T$="FOUND A WRENCH^#I CAN OPEN THE#FUSE BOX":GOSUB 10300
9732 IF TV=72 THEN I5=1:T$="GOT THE BOOT DISK^#I CAN REBOOT THE#SYSTEM  WITH IT[":GOSUB 10300'ID Card - Brick Swap item
9733 IF TV=74 THEN I6=1:T$="FOUND A FUSE^#I CAN RESTORE THE#MAIN POWER WITH IT[":GOSUB 10300'ID Card - Brick Swap item

9739 RETURN

9750 ' fun open fuse box
9751 IF I4=0 AND DI=0 THEN DI=-1:T$="THE CIRCUIT PANEL#IS STUCK^#I NEED A TOOL TO#OPEN IT[":GOSUB 10300:RETURN
9752 IF I6=2 AND DI=0 THEN DI=-1:T$="I ALREADY REPLACED#THE FUSE^#NOTHING ELSE TO DO#HERE[":GOSUB 10300:RETURN
9753 IF DI=-1 THEN RETURN
9755 ' Open, show broken fuse
9756 TV=82:TP=TT:GOSUB 12220'IT=&H1800+TT-&H60-1:VPOKE IT,82:VPOKE IT+1,83::VPOKE IT+32,114::VPOKE IT+33,115
9757 ' Replace VPEEK proxy
9758 IT=IT-&H1800:VP(IT)=82:VP(IT+1)=83:VP(IT+32)=114:VP(IT+33)=115
9759 RETURN

9760 ' fun access computer
9761 IF I6<2 AND DI=0 THEN DI=-1:T$="THE COMPUTER IS OFF[#IT NEEDS MAIN POWER#TO BOOT UP[":GOSUB 10300:RETURN' IF NO POWER, show NO POWER Message
9762 IF I6=2 AND I5=0 THEN DI=-1:T$="THE BOOT SECTOR IS[#CORRUPTED^#I NEED A BOOT DISK#TO RESTART IT[":GOSUB 10300:RETURN' IF POWER BUT NO DISK show NO DISK Message
9763 IF I6=2 AND I5=1 THEN T$="SUCCESS^#GAME OVER":GOSUB 10300:RETURN' IF POWER AND DISK show ending
9769 RETURN

9800 'fun Wall jump check: need to have a substantial amount of wall to grip to
9801 IF I2=0 THEN RETURN
9802 IF T5>=64 AND (T4>=64 OR T6>=64) THEN GS=4:SA=3:ST=7:WT=4 ELSE 9810
9804 IF VY>7 THEN VY=7 ELSE IF VY<-9 THEN VY=-9
9809 RETURN
9810 ' No grip
9811 IF GS=4 THEN IF VY>0 THEN GS=2 ELSE GS=3
9819 RETURN

9820 'fun Double Jump Check
9821 IF I1=0 THEN RETURN
9823 IF JD=0 AND STRIG(SS) THEN GS=2:SA=0:ST=4:JD=1:DJ=0:VY=VY-14:IF VY<-14 THEN VY=-14 ELSE IF VY>-6 THEN VY=-6
9829 RETURN

9900 'fun Update enemies
9901 IF EC=0 THEN RETURN ' Skip enemy updates if no enemies
9902 FOR EI=1 TO EC
9903  EW(EI)=EW(EI)+1:IF EW(EI)=3 THEN EW(EI)=0:ES(EI)=ES(EI)+EV(EI):IF ES(EI)=3 THEN ES(EI)=0 ELSE IF ES(EI)=-1 THEN ES(EI)=2
9904  ON ET(EI) GOSUB 9910,9920,9930,9940 ' Update enemy based on type
9905  ' Colision box detection
9906  ' Original check: IF ABS(X-EX(EI))<16 AND Y-EY(EI)>-31 AND Y-EY(EI)<15
9907  IF ABS(X-EX(EI))<12 AND Y-EY(EI)>-29 AND Y-EY(EI)<12 THEN PD=8 'Maybe we can do a more refined check if a "gross" check succeed
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

10300 ' fun Display a pop-up  [\]^_` map to .(down arrow))?!-,
10301 ' Store current scrren info
10302 KS=&H1905
10303 FOR I=0 TO 9 'Rows
10304   FOR J=0 to 21 'Columns
10305     KT(I*22+J)=VPEEK (KS+I*32+J)
10306   NEXT J
10307 NEXT I

10308 'IF X<16 OR X>160 OR Y<56 OR Y>128 GOTO 10311 ' TODO:For now Always hide the main character and the enemies
10309 FOR I=0 TO 7:PUT SPRITE I,,0,0:NEXT

10311 VPOKE KS,2:FOR J=1 to 20:VPOKE KS+J,36:NEXT J:VPOKE KS+21, 3
10320 FOR I=1 TO 8 'Rows
10321   KR=KS+I*32
10322   VPOKE KR, 4
10330   FOR J=1 to 20 'Columns
10340     VPOKE KR+J, 0
10350   NEXT J
10351   VPOKE KR+21, 4
10360 NEXT I
10370 KS=&H1A05:VPOKE KS,34:FOR J=1 to 20:VPOKE KS+J,36:NEXT J:VPOKE KS+21, 35
10371 CMD PLYSOUND 5
10375 TX=6:TY=9:GOSUB 10900
10376 IF STRIG(SS) THEN 10376
10379 IF NOT STRIG(SS) THEN 10379

10380 ' Dismiss dialog
10382 KS=&H1905
10383 FOR I=0 TO 9 'Rows
10384   FOR J=0 to 21 'Columns
10385     VPOKE KS+I*32+J, KT(I*22+J)
10386   NEXT J
10387 NEXT I
10388 IF STRIG(SS) THEN 10388

10390 RETURN

10900 'fun Write text T$ on Screen at position TX, TY (in row/column)
10901 TF=0
10910 FOR I=1 TO LEN(T$)
10911   TF=TF+1
10920   CT$=MID$(T$,i,1)
10940   IF CT$=" " THEN TT=0 ELSE TT=ASC(CT$)+159
10941   IF CT$="#" THEN TF=0:TY=TY+2 ELSE VPOKE &H1800+TX-1+TY*32+TF, TT
10950 NEXT I
10990 RETURN

11000 ' fun Process laser animations
11001 ' Check laser death if lasers are on
11002 IF LS=0 THEN 11091
11003 ' Horizontal lasers check
11010 I0=(X+8)\8+Y\8*32
11011 IF VP(I0)=62 OR VP(I0+32)=62 OR VP(I0+64)=62 OR VP(I0+96)=62 THEN PD=8
11020 ' Vertical lasers check
11021 I0=X\8+(Y+12)\8*32
11022 IF VP(I0)=63 OR VP(I0+1)=63 OR VP(I0+2)=63 THEN PD=8
11090 ' Check animations (we animate when they are off to have consistent frame drops if any)
11091 TA=TA+1 ' TA: timer for animation
11092 IF TA MOD 5 = 1 THEN GOSUB 12000
11093 IF TA MOD 5 = 3 THEN GOSUB 12100
11098 IF TA MOD 80 = 0 THEN GOSUB 11100
11099 RETURN

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
12004  VPOKE &H1F0+I, LR:VPOKE &H9F0+I, LR: VPOKE &H11F0+I, LR
12006 NEXT I
12099 RETURN

12100 'ANIMATE LASER (horizontal), we have 4 patterns, they all have the same colors, tile 144-147, base address for the copy is tile 62 -> 62*8=496 -> 0x1F0
12101 'LT=LT+1:IF LT=200 THEN LT=196 'We only need to swap pattern once
12102 FOR I=0 TO 7
12103  LM=VPEEK(LT*8+I+32)
12105  VPOKE &H1F8+I, LM:VPOKE &H9F8+I, LM: VPOKE &H11F8+I, LM
12106 NEXT I
12199 RETURN

12220 ' fun set TV (tile value) into TP (tile position) 16x16 tiles
12221 VPOKE TP,TV:VPOKE TP+1,TV+1:VPOKE TP+&H20,TV+&H20:VPOKE TP+&H21,TV+&H21
12222 RETURN

8800 ' fun Load new room
8801 FOR I=0 TO 7: PUT SPRITE I,(0,-16),0:NEXT I
8802 ' Record player state when entering the room
8003 RX=X:RY=Y:RV=VX:RW=VY:RG=GS:RD=D:RA=SA:RT=ST
8004 DI=0:IF GI=-1 THEN GI=0' We show the tutorial action once per room
8805 CMD WRTSCR R*7+C+3
8806 RI=RR(R*7+C+1)\64 ' We store collection of items after the 7th bit of the room info (we store the position in screen)
8807 IF RI>0 THEN TP=&H1800+RI:TV=0:GOSUB 12220
8808 EC=0:LT=196:NL=0:IR=0
8809 IF BT>0 THEN BT=0:TC=0:TS=0:GOSUB 9610
8810 FOR I=0 TO 672
8811  TT=VPEEK(&H1800+I)
8812  IF TT=192 THEN TT=0:GOSUB 8910 ' Parse enemy type 1
8813  IF TT=160 THEN TT=0:GOSUB 8920 ' Parse enemy type 2
8814  IF TT=163 THEN TT=0:GOSUB 8930 ' Parse enemy type 3
8815  IF TT=162 THEN TT=0:GOSUB 8940 ' Parse enemy type 4
8816  IF TT=62 OR TT=63 THEN NL=1 ' There are lasers in the room
8817  IF TT>=64 OR TT<=74 THEN IR=1 ' There are items in the room
8820  IF TT=120 AND BS=1 THEN TT=152
8821  IF TT=121 AND BS=0 THEN TT=153
8824  VP(I)=TT
8825 NEXT I
8826 ' TODO: This part will not be needed once the screens only load 18 rows of data
8827 FOR I=1 TO 5
8828  IF CI(I)>0 THEN TP=&H1AA0+I*3:TV=CI(I):GOSUB 12220' set TV (tile value) into TP (tile position) 16x16 tiles
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
