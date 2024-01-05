FILE "../res/sprites.bin.plet5"
FILE "../res/map.chr.plet5"
FILE "../res/map.clr.plet5"

INCLUDE "map.inc"

7999 R=0:C=3

8000 COLOR 15,1,1:SCREEN 2,2,0
8001 DEFINT A-Z

8010 CMD WRTCHR 1:CMD WRTCLR 2 ' Got to load them 3 times
8011 CMD WRTVRAM 1, &H800:CMD WRTVRAM 2, &H2800
8012 CMD WRTVRAM 1, &H1000:CMD WRTVRAM 2, &H3000

8020 CMD WRTVRAM 0, &H3800

8100 'New game initialization
8101 AD=1:X=8:Y=120:GS=1
8102 Y=20
8103 DIM EX(4),EY(4),EV(4),ET(4),ES(4),EW(4)' Enemy X, Y, Velocity, Type, Sprite, Wait. EC: Enemy Count
8104 GOSUB 8800:GOSUB 9000

8800 ' Parse new room
8801 FOR I=0 TO 7: PUT SPRITE I,(0,-16),0:NEXT I
8805 CMD WRTSCR R+C*5+3
8806 EC=0
8810 FOR I=&H1820 TO &H1B80
8820  TT=VPEEK(I)
8821  IF TT=192 THEN GOSUB 8910
8822  IF TT=160 THEN GOSUB 8920
8823  IF TT=163 THEN GOSUB 8930
8824  IF TT=162 THEN GOSUB 8940
8829 NEXT I
8830 RETURN

8840 EC=EC+1
8841 EX(EC)=(I MOD 32)*8
8842 EY(EC)=((I-&H1800)\32)*8
8849 RETURN

8850 'PUT SPRITE 3+EC,(EX(EC),EY(EC)),14,25+ES(EC)+ET(EC)*3 'If we uncomment this line, a new enemy shows on room 3?? somehow EC++ on the ET=1
8851 ' Makes no sense, probably a compiler error
8859 RETURN

8910 GOSUB 8840
8911 ET(EC)=1:EV(EC)=1
8912 EY(EC)=EY(EC)+1
8913 GOSUB 8850
8914 VPOKE I,0:VPOKE I+1,0
8919 RETURN

8920 GOSUB 8840
8921 ET(EC)=2:EV(EC)=1
8922 EY(EC)=EY(EC)-12
8923 GOSUB 8850
8924 VPOKE I,0:VPOKE  I+1,0
8929 RETURN

8930 GOSUB 8840
8931 ET(EC)=3:EV(EC)=1
8932 EY(EC)=EY(EC)-2
8933 EX(EC)=EX(EC)+2
8934 GOSUB 8850
8938 VPOKE I,0:VPOKE I+32,0
8939 RETURN

8940 GOSUB 8840
8941 ET(EC)=4:EV(EC)=1
8942 EY(EC)=EY(EC)-2
8943 EX(EC)=EX(EC)-10
8944 GOSUB 8850
8948 VPOKE I,0:VPOKE I+32,0
8949 RETURN

9000 ' BEGIN GAME LOOP
9001 TIME=0
9002 ' UPDATE
9003 ON GS GOSUB 9100, 9200, 9300, 9400
9005 GOSUB 9900 ' Update Enemies
9009 ' DRAW
9010 PUT SPRITE 1,(X,Y+YO),15,D:PUT SPRITE 0,(X,Y+4+YO),4,9+SA+D
9020 PUT SPRITE 2,(X,Y+14),14,1+ST+D
9030 IF EC=0 THEN 9090
9031 FOR I=1 TO EC
9035  PUT SPRITE 3+I,(EX(I),EY(I)),EA,25+ES(I)+ET(I)*3
9039 NEXT I
9089 ' END GAME LOOP
9090 IF TIME<1 GOTO 9090 ELSE 9000

9100 'GS=1 Standing
9101 S=STICK(0)
9102 VX=0
9112 IF S=3 THEN VX=1:IF D=14 OR SA=4 THEN D=0:AD=1:SA=0:ST=0 ELSE GOTO 9118
9113 IF S=7 THEN VX=-1:IF D=0 OR SA=4 THEN D=14:AD=1:SA=0:ST=0 ELSE GOTO 9118
9114 IF S=0 THEN SA=4:ST=3:YO=0' SA=4 marks a resting position
9115 IF S=5 THEN YO=3:ST=4:SA=4
9117 GOTO 9140
9118 IF S0=4 THEN S0=0 ELSE S0=S0+1:GOTO 9140
9120 SA=SA+AD: IF SA=3 THEN AD=-1 ELSE IF SA=0 THEN AD=1
9121 ST=ST+1:IF ST=3 THEN ST=0
9122 IF ST=1 THEN YO=1 ELSE YO=0
9140 IF NOT(STRIG(0)) THEN JD=0 ELSE IF JD=0 THEN GS=2:VY=-14:SA=0:ST=4:JD=1:DJ=1:WT=4:RETURN 'JD: Jump Debouncing, DJ=double jump
9141 X=X+VX
9145 TT = &H1800+((Y+32)\8)*32
9146 T0 = VPEEK (TT+(X+2)\8)
9147 T1 = VPEEK (TT+(X+8)\8)
9148 T2 = VPEEK (TT+(X+15)\8)
9149 TT = TT + X\8
9150 IF D=0 THEN T3=VPEEK(TT-&H80+2):T4=VPEEK(TT-&H60+2):T5=VPEEK(TT-&H40+2):T6=VPEEK(TT-&H20+2)
9151 IF D=14 THEN T3=VPEEK(TT-&H80):T4=VPEEK(TT-&H60):T5=VPEEK(TT-&H40):T6=VPEEK(TT-&H20)
9180 IF T3>=64 OR T4>=64 OR T5>=64 OR T6>=60 THEN X=X-VX
9182 IF T0<60 AND T1<60 AND T2<60 THEN IF AT>0 THEN AT=AT-1 ELSE GS=3:VX=0:ST=3:SA=4 ELSE AT=3
9197 IF X=239 THEN C=C+1:X=1:GOSUB 8800
9198 IF X=0 THEN C=C-1:X=238:GOSUB 8800
9199 RETURN

9200 'GS=2 Jumping
9210 VY=VY+1: IF VY>=0 THEN GS=3
9211 Y=Y+VY/4
9212 X=X+VX
9213 ST=5
9214 SA=3
9240 TT = &H1800+((Y+2)\8)*32
9241 T0 = VPEEK (TT+(X+2)\8)
9242 T1 = VPEEK (TT+(X+8)\8)
9243 T2 = VPEEK (TT+(X+15)\8)
9244 TT =  &H1800+X\8
9249 IF T0>=64 OR T1>=64 OR T2>=64 THEN VY=0:Y=Y-VY:Y=((Y+2)\8+1)*8-2:DJ=0:GS=3
9250 TT = &H1800+X\8
9251 ' We can simplify T3 and T7 calculated, then T4, T5 and T6 offset from T3 (or T4) as they can only overlap (it is either 4 or 5 consecutive tiles)
9254 IF VX>0 THEN T3=VPEEK(TT+(Y+32)\8*32+2):T4=VPEEK(TT+(Y+24)\8*32+2):T5=VPEEK(TT+(Y+16)\8*32+2):T6=VPEEK(TT+(Y+8)\8*32+2):T7=VPEEK(TT+(Y+2)\8*32+2)
9255 IF VX<0 THEN T3=VPEEK(TT+(Y+32)\8*32):T4=VPEEK(TT+(Y+24)\8*32):T5=VPEEK(TT+(Y+16)\8*32):T6=VPEEK(TT+(Y+8)\8*32):T7=VPEEK(TT+(Y+2)\8*32)
9281 IF T3>=64 OR T4>=64 OR T5>=64 OR T6>=64 OR T7>=64 THEN X=X-VX:IF VY>-4 THEN GOSUB 9800
9290 IF DJ=1 AND VY>-4 THEN GOSUB 9820
9298 IF Y<=0 THEN R=R-1:Y=146:GOSUB 8800
9299 RETURN

9300 'GS=3 Falling
9301 VY=VY+1: IF VY>14 THEN VY=14
9302 Y=Y+VY/4:X=X+VX
9314 SA=0:ST=6
9319 ' The next 3 lines enable gliding
9320 S=STICK(0)
9321 IF S=3 THEN VX=VX+1:IF VX>1 THEN VX=1:D=0
9322 IF S=7 THEN VX=VX-1:IF VX<-1 THEN VX=-1:D=14
9340 TT = &H1800+((Y+32)\8)*32
9341 T0 = VPEEK (TT+(X+2)\8)
9342 T1 = VPEEK (TT+(X+8)\8)
9343 T2 = VPEEK (TT+(X+15)\8)
9344 TT = &H1800+X\8
9354 IF VX>0 THEN T3=VPEEK(TT+(Y+32)\8*32+2):T4=VPEEK(TT+(Y+24)\8*32+2):T5=VPEEK(TT+(Y+16)\8*32+2):T6=VPEEK(TT+(Y+8)\8*32+2):T7=VPEEK(TT+(Y+2)\8*32+2)
9355 IF VX<0 THEN T3=VPEEK(TT+(Y+32)\8*32):T4=VPEEK(TT+(Y+24)\8*32):T5=VPEEK(TT+(Y+16)\8*32):T6=VPEEK(TT+(Y+8)\8*32):T7=VPEEK(TT+(Y+2)\8*32)
9381 IF T3>=64 OR T4>=64 OR T5>=64 OR T6>=64 OR T7>=64 THEN X=X-VX:GOSUB 9800 'Wall jump check
9385 IF T0>=60 OR T1>=60 OR T2>=60 THEN GS=1:JD=1:DJ=0:SA=4:ST=4:VX=0:Y=((Y+32)\8)*8-32
9390 IF DJ=1 THEN GOSUB 9820'Double Jump check
9398 IF Y>=146 THEN R=R+1:Y=0:GOSUB 8800
9399 RETURN

9400 'GS=4 Initial hold onto wall
9401 WT=WT-1: IF WT=0 THEN GS=3' WT: Wall Time is reset each time we start a jump
9402 IF NOT(STRIG(0)) THEN JD=0 ELSE IF JD=0 THEN GS=2:VY=-14:VX=-VX:JD=1:WT=4:IF D=0 THEN D=14 ELSE D=0'JD: Jump Debouncing
9499 RETURN


9800 'Check for wall jump, need to have a substantial amount of wall to grip to
9801 IF T5>=64 AND (T4>=64 OR T6>=64) THEN IF WT>0 THEN GS=4:GOTO 9809 ELSE 9802 ELSE 9809
9802 SA=3:ST=7
9803 IF VY>7 THEN VY=7 ELSE IF VY<-9 THEN VY=-9
9808 IF NOT(STRIG(0)) THEN JD=0 ELSE IF JD=0 THEN GS=2:VY=-14:VX=-VX:JD=1:WT=4:IF D=0 THEN D=14 ELSE D=0'JD: Jump Debouncing
9809 RETURN

9820 'Double Jump Check
9821 IF JD=1 AND NOT(STRIG(0)) THEN JD=0:GOTO 9829
9822 IF JD=0 AND STRIG(0) THEN GS=2:SA=0:ST=4:JD=1:DJ=0:VY=VY-14:IF VY<-14 THEN VY=-14 ELSE IF VY>-6 THEN VY=-6
9829 RETURN

9900 'MOVE ENEMIES
9901 EA=14:IF EC=0 THEN RETURN
9902 FOR EI=1 TO EC
9903  EW(EI)=EW(EI)+1:IF EW(EI)=3 THEN EW(EI)=0:ES(EI)=ES(EI)+EV(EI):IF ES(EI)=3 THEN ES(EI)=0 ELSE IF ES(EI)=-1 THEN ES(EI)=2
9904  ON ET(EI) GOSUB 9910,9920,9930,9940
9905  ' Colision box detection
9906  IF ABS(X-EX(EI))<16 AND Y-EY(EI)>-32 AND Y-EY(EI)<16 THEN EA=8
9908 NEXT I
9909 RETURN

9910 'Horizontal moving enemy, lower
9911 EX(EI)=EX(EI)+EV(EI)
9913 IF EX(EI) MOD 8=0 THEN EL=VPEEK(&H1800+((EY(EI)+9)\8)*32+(EX(EI)+8+4*EV(EI))\8):IF EL=75 OR EL=77 THEN EV(EI)=-EV(EI)
9919 RETURN

9920 ' Horizontal moving enemy, upper
9921 EX(EI)=EX(EI)+EV(EI)
9923 IF EX(EI) MOD 8=0 THEN EL=VPEEK(&H1800+((EY(EI)+9)\8)*32+(EX(EI)+8+4*EV(EI))\8):IF EL=107 OR EL=109 THEN EV(EI)=-EV(EI)
9929 RETURN

9930 ' Vertical moving enemy, right wall
9931 EY(EI)=EY(EI)+EV(EI)
9933 IF EY(EI) MOD 8=0 THEN EL=VPEEK(&H1800+((EY(EI)+10+4*EV(EI))\8)*32+(EX(EI)+8)\8):IF EL=79 OR EL=111 THEN EV(EI)=-EV(EI)
9939 RETURN

9940 ' Vertical moving enemy, left wall
9941 EY(EI)=EY(EI)+EV(EI)
9943 IF EY(EI) MOD 8=0 THEN EL=VPEEK(&H1800+((EY(EI)+10+4*EV(EI))\8)*32+(EX(EI)+8)\8):IF EL=78 OR EL=110 THEN EV(EI)=-EV(EI)
9949 RETURN
