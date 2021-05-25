10 DEFINT A-Z

50 SOUND 8,&b00000
51 SOUND 12,0
52 SOUND 11,1
53 SOUND 13,0
54 SOUND 7,&b10111110
55 SOUND 1,&H7:SOUND 0,&HF2

59 SOUND 8,&b11100

100 ' READ S and TR From VRAM
110 S=VPEEK(0):TR=VPEEK(1)

120 FOR I=0 TO 31:PUT SPRITE I,((I MOD 16)*20,164+(I\16)*16),0,0:NEXT I
130 R=0:C=0:PL=9
140 SS=0:SJ=0:PS%=0:SX=46:SY=80:SV=0:TH=0:TV=0

151 'Load the room at Row R and Column C
151 IF R=0 AND C=9 GOTO 850
154 BLOAD "map_"+CHR$(C+48)+"_"+CHR$(R+48)+".scr",S
155 VPOKE &H1AC6,48+PL
156 GOSUB 670

160 call turbo ON(SX,SY,SV,SJ,R,C,PL,S,TR,SS)
161 DIMAE(3):DIMDE(3):DIMPO(3):DIMTE(3):DIMMM(3):DIMMN(3):DIMME(3):DIMPM(3):DIMPI(3):DIMCE(3)
162 ON SPRITE GOSUB 541

170 'Load enemies for this room
170 RESTORE 1000
171 IF R=0 GOTO 173
172 FOR I=1 TO R:FOR K=1 TO 10:READ E:FOR J=1 TO E:READ E,E,E,E,E,E,E,E,E,E:NEXT J:NEXT K:NEXT I
173 IF C=0 GOTO 180
174 FOR I=1 TO C:READ E:FOR J=1 TO E:READ E,E,E,E,E,E,E,E,E,E:NEXT J:NEXT I
180 READ E:FOR I=1 TO E:READ TE(I),DE(I),AE(I),MM(I),MN(I),ME(I),PO(I),PI(I),CE(I),PM(I):NEXT I

199 X=SX:Y=SY:VY=SV:PJ=SJ:TH=0:TV=0:PS=SS:SPRITE ON

200 ' Game loop
200 TIME=0
201 ON STICK(S) GOTO 210,220,230,240,250,260,270,280
209 GOTO 300
210 IF PJ%=0 THEN VY%=-8:PJ%=1:SOUND 1,&H7:SOUND 0,&HF2:SOUND 12,28:SOUND 13,0: IF PS%>=2 THEN PS%=2 ELSE PS%=0
219 GOTO 300
220 IF PJ%=0 THEN VY%=-8:PJ%=1:SOUND 1,&H7:SOUND 0,&HF2:SOUND 12,28:SOUND 13,0
221 TH=VPEEK(&H1800+(X+16)\8+((Y+8)\8)*32)
222 PS%=0:IF PJ%>-1 AND VPEEK(&H1800+(X+16)\8+((Y+12)\8)*32)=0 AND TH=0 AND VPEEK(&H1800+(X+16)\8+((Y+2)\8)*32)=0 THEN X=X+4 ELSE X=(X\4)*4+2
229 GOTO 300
230 TH=VPEEK(&H1800+(X+16)\8+((Y+8)\8)*32)
231 IF PJ%>-1 AND VPEEK(&H1800+(X+16)\8+((Y+12)\8)*32)=0 AND TH=0 AND VPEEK(&H1800+(X+16)\8+((Y+2)\8)*32)=0 THEN X=X+4 ELSE X=(X\4)*4+2
232 IF PS%=0 AND PJ%=0 THEN PS%=1 ELSE PS%=0
233 IF PJ%=0 THEN SOUND 1,&H7:SOUND 0,&HF2:SOUND 12,4:SOUND 13,0
239 GOTO 300
240 IF PJ%=0 THEN VY%=-5:PJ%=1:SOUND 1,&H7:SOUND 0,&HF2:SOUND 12,24:SOUND 13,0
241 TH=VPEEK(&H1800+(X+16)\8+((Y+8)\8)*32)
242 PS%=0:IF PJ%>-1 AND VPEEK(&H1800+(X+16)\8+((Y+12)\8)*32)=0 AND TH=0 AND VPEEK(&H1800+(X+16)\8+((Y+2)\8)*32)=0 THEN X=X+4 ELSE X=(X\4)*4+2
249 GOTO 300
250 IF PJ%=0 THEN VY%=-5:PJ%=1:SOUND 1,&H7:SOUND 0,&HF2:SOUND 12,24:SOUND 13,0:IF PS%>=2 THEN PS%=2 ELSE PS%=0
259 GOTO 300
260 IF PJ%=0 THEN VY%=-5:PJ%=1:SOUND 1,&H7:SOUND 0,&HF2:SOUND 12,24:SOUND 13,0
261 TH=VPEEK(&H1800+X\8+((Y+8)\8)*32)
262 PS%=2:IF PJ%>-1 AND VPEEK(&H1800+X\8+((Y+12)\8)*32)=0 AND TH=0 AND VPEEK(&H1800+X\8+((Y+2)\8)*32)=0 THEN X=X-4 ELSE X=(X\4)*4+2
269 GOTO 300
270 TH=VPEEK(&H1800+X\8+((Y+8)\8)*32)
271 IF PJ%>-1 AND VPEEK(&H1800+X\8+((Y+12)\8)*32)=0 AND TH=0 AND VPEEK(&H1800+X\8+((Y+2)\8)*32)=0 THEN X=X-4 ELSE X=(X\4)*4+2
272 IF PS%=2 AND PJ%=0 THEN PS%=3 ELSE PS%=2
273 IF PJ%=0 THEN SOUND 1,&H7:SOUND 0,&HF2:SOUND 12,4:SOUND 13,0
279 GOTO 300
280 IF PJ%=0 THEN VY%=-8:PJ%=1:SOUND 1,&H7:SOUND 0,&HF2:SOUND 12,28:SOUND 13,0
281 TH=VPEEK(&H1800+X\8+((Y+8)\8)*32)
282 PS%=2:IF PJ%>-1 AND VPEEK(&H1800+X\8+((Y+12)\8)*32)=0 AND TH=0 AND VPEEK(&H1800+X\8+((Y+2)\8)*32)=0 THEN X=X-4 ELSE X=(X\4)*4+2
289 GOTO 300

300 'Collisions: Check for floor tiles at 3 points under the sprite Y+16,(X, X+8, X+15)'
300 Y=Y+VY%
320 IF VY%<0 GOTO 340
330 TV=VPEEK(&H1800+(X+8)\8+((Y+16)\8)*32)
331 TW=VPEEK(&H1800+(X+2)\8+((Y+16)\8)*32)
332 TU=VPEEK(&H1800+(X+12)\8+((Y+16)\8)*32)
333 IF TU>0 OR TV>0 OR TW>0 THEN VY%=0:Y=Y-(Y MOD 8):IF PJ<>0 THEN PJ%=0:SOUND 0,0:SOUND 1,0: SOUND 13,0: GOTO 350 ELSE GOTO 350
334 VY%=VY%+1:IF VY%>8 THEN VY%=8
335 IF PJ%=0 THEN PJ%=-1:SOUND 1,&H7:SOUND 0,&HF2:SOUND 12,20:SOUND 13,4
339 GOTO 350
340 TV=VPEEK(&H1800+(X+8)\8+(Y\8)*32)
341 TW=VPEEK(&H1800+(X+2)\8+(Y\8)*32)
342 TU=VPEEK(&H1800+(X+12)\8+(Y\8)*32)
343 IF TU>0 OR TV>0 OR TW>0 THEN VY%=0:Y=Y+8-(Y MOD 8) ELSE VY%=VY%+1:IF VY%>8 THEN VY%=8
350 IF TV<128 OR TV>142 THEN GOTO 355
351   TH=VPEEK(&H1800+(X+16)\8+((Y+8)\8)*32)
352   IF VPEEK(&H1800+(X+16)\8+((Y+12)\8)*32)=0 AND TH=0 AND VPEEK(&H1800+(X+16)\8+((Y+2)\8)*32)=0 THEN X=X+4 ELSE X=(X\4)*4+2
353   ' TODO: WHITE NOISE?
355 IF TV<143 OR TV>157 THEN GOTO 360
356   TH=VPEEK(&H1800+X\8+((Y+8)\8)*32)
357   IF VPEEK(&H1800+X\8+((Y+12)\8)*32)=0 AND TH=0 AND VPEEK(&H1800+X\8+((Y+2)\8)*32)=0 THEN X=X-4 ELSE X=(X\4)*4+2
358   ' TODO: WHITE NOISE?
360 IF (TU>=96 AND TU<=125) OR (TV>=96 AND TV<=125) OR (TW>=96 AND TW<=125) OR (TH>=96 AND TH<=125) THEN GOTO 530
363 IF (TV>=160 AND TV<=183) OR (TH>=160 AND TH<=183) THEN GOSUB 550
364 IF (TV>=192 AND TV<=215) OR (TH>=192 AND TH<=215) THEN GOSUB 600
380 IF X>=226 THEN X=18:C=C+1:GOTO 700
381 IF X<=14 THEN X=222:C=C-1:GOTO 700
382 IF Y>=112 THEN Y=4:R=R+1:GOTO 700
383 IF Y<=2 THEN Y=110:R=R-1:GOTO 700

390 PUT SPRITE 0,(X,Y-1),6,PS%

400 ' Update Enemies for the room
400 FOR I=1 TO E
410   IF TE(I)=1 THEN 430
420     DE(I)=DE(I)+ME(I)
421     IF DE(I)>MM(I) THEN ME(I)=-ME(I):DE(I)=MM(I)
422     IF DE(I)<MN(I) THEN ME(I)=-ME(I):DE(I)=MN(I)
423     GOTO 460
430     AE(I)=AE(I)+ME(I)
431     IF AE(I)>MM(I) THEN ME(I)=-ME(I):AE(I)=MM(I)
432     IF AE(I)<MN(I) THEN ME(I)=-ME(I):AE(I)=MN(I)
433     GOTO 460
460   PO(I)=PO(I)+1
470   IF PO(I)>=PM(I) THEN PO(I)=PI(I)
480   PUT SPRITE I,(DE(I)+8,AE(I)-16),CE(I),PO(I)-1
481 NEXT I

490 ' Sync timing with VDP for accurate and reliable speed
490 IF TIME<5 GOTO 490
499 GOTO 200

530 'Lost a life
530 IF TR=0 THEN PL=PL-1
531 SOUND 1,&HD:SOUND 0,&H5D:SOUND 12,18:SOUND 13,13
532 K=11
535 TIME=0
536 K=K+1: IF K=19 THEN 539 ELSE IF K=16 THEN SOUND 13,0
537 PUT SPRITE 0,(X,Y-1),6,K
538 IF TIME<10 THEN 538 ELSE 535
539 IF PL=-1 THEN R=3:C=9:GOTO 700
540 'Update lifes UI
540 VPOKE &H1AC6,48+PL: GOTO 199

541 'Sprite collision, lose a life
541 SPRITE OFF
549 RETURN 530

550 'Get a key
550 IF TV>=160 AND TV<=183 THEN K=TV\8-20 ELSE K=TH\8-20
551 IF VPEEK(&H1A42+2*K)<44 THEN RETURN
552 SOUND 3,&H3:SOUND 2,&H8A
553 SOUND 12,8:SOUND 13,4
560 VPOKE &H1A42+2*K, 20+4*K
561 VPOKE &H1A43+2*K, 21+4*K
562 VPOKE &H1A62+2*K, 22+4*K
563 VPOKE &H1A63+2*K, 23+4*K
590 RETURN

600 'Open a lock
600 IF TV>=192 AND TV<=215 THEN K=TV\8-24 ELSE K=TH\8-24
610 IF VPEEK(&H1A42+2*K)>31 THEN RETURN
620 SOUND 3,&H3:SOUND 2,&H8A
621 SOUND 12,16:SOUND 13,4
660 VPOKE &H1A42+2*K, 32+4*K
661 VPOKE &H1A43+2*K, 33+4*K
662 VPOKE &H1A62+2*K, 34+4*K
663 VPOKE &H1A63+2*K, 35+4*K
664 GOSUB 670
665 RETURN

670 'Remap tiles of opened doors (info is read from an invisible tile)
670 L=VPEEK(&H1800)-23
671 IF L<=0 THEN RETURN
672 K=VPEEK(&H1A40+2*L)
680 IF K<31 OR K>44 THEN RETURN
681 IF L=1 THEN FOR I=0 TO 3:VPOKE &H19C6+I,0:VPOKE &H19E6+I,0:NEXT I
682 IF L=2 THEN FOR I=0 TO 3:VPOKE &H191A+I,0:VPOKE &H193A+I,0:VPOKE &H195A+I,0:VPOKE &H197A+I,0:VPOKE &H199A+I,0:VPOKE &H19BA+I,0:NEXT I
683 IF L=3 THEN FOR I=0 TO 3:VPOKE &H195A+I,0:VPOKE &H197A+I,0:VPOKE &H199A+I,0:VPOKE &H19BA+I,0:NEXT I
690 RETURN

700 'Move to another room
701 FOR I=0 TO 4:PUT SPRITE I,(I*20,132),0,0:NEXT I
705 SPRITE OFF
710 SX=X:SY=Y:SV=VY:SJ=PJ:SS=PS
720 CALL TURBO OFF
730 IF PL<0 GOTO 800
790 GOTO 151

800 'Game Over Screen, press fire or wait 3 seconds
800 BLOAD "over.scr",S
801 TIME=0
810 IF STRIG(0) OR STRIG(1) OR TIME>150 GOTO 900
820 GOTO 810

850 'Ending Screen
850 run "ending.bas

900 'Start New Game Screen
900 run "intro.bas

1000 'Enemy data (line number is 1{R}{C}0)
1000 DATA 1,1,180,66,94,34,4,4,5,5,9
1010 DATA 1,1,112,60,110,50,4,4,5,8,9
1020 DATA 1,2,115,78,150,105,4,4,5,2,9
1030 DATA 1,2,115,80,180,80,4,9,9,9,11
1040 DATA 2,1,180,66,110,34,6,4,5,5,9,2,100,32,160,80,4,9,9,9,13
1050 DATA 1,1,180,66,122,34,4,4,5,3,9
1060 DATA 1,1,110,60,110,50,4,4,5,8,9
1070 DATA 2,1,110,60,110,50,4,5,5,8,9,1,180,60,110,50,6,7,5,8,9
1080 DATA 1,2,115,90,180,50,8,9,9,3,12
1090 DATA 1,2,115,90,180,50,8,9,9,3,12
1100 DATA 2,1,110,54,110,50,4,5,5,8,9,1,40,60,110,45,6,7,5,7,9
1110 DATA 1,1,180,60,110,50,4,4,5,2,9
1120 DATA 1,1,112,60,110,50,4,4,5,8,9
1130 DATA 1,2,180,64,180,180,0,9,9,8,13
1140 DATA 2,1,110,60,110,50,4,5,5,8,9,1,180,60,110,50,6,7,5,8,9
1150 DATA 1,1,50,30,90,50,4,4,5,8,9
1160 DATA 1,1,112,60,110,40,4,4,5,5,9
1170 DATA 1,1,100,60,110,40,4,4,5,3,9
1180 DATA 1,2,100,32,180,50,6,9,9,7,13
1190 DATA 1,2,115,47,180,80,4,9,9,9,11
1200 DATA 1,2,120,78,150,105,4,4,5,8,9
1210 DATA 1,1,180,60,110,50,6,4,5,3,9
1220 DATA 2,1,110,60,94,50,4,4,5,8,9,1,180,60,110,50,6,4,5,9,9
1230 DATA 2,1,110,60,110,50,4,6,5,8,9,1,70,60,110,60,4,6,5,8,9
1240 DATA 1,1,100,60,110,50,4,4,5,8,9
1250 DATA 3,1,110,60,110,50,4,4,5,8,9,1,170,60,110,60,4,7,5,2,9,1,70,70,110,50,6,5,5,7,9
1260 DATA 1,2,110,80,155,75,6,11,9,4,13
1270 DATA 1,2,80,64,88,46,4,11,9,4,13
1280 DATA 1,1,112,60,110,50,4,4,5,8,9
1290 DATA 2,2,70,32,125,45,6,9,9,7,13,1,45,50,110,50,4,8,5,3,9
1300 DATA 1,1,110,60,110,50,4,5,5,8,9
1310 DATA 1,1,112,60,95,50,5,5,5,5,6
1320 DATA 1,1,42,60,110,70,4,4,5,8,9
1330 DATA 1,1,85,60,110,50,4,4,5,8,9
1340 DATA 2,2,60,112,120,48,5,9,9,7,13,2,180,112,180,140,5,11,9,5,13
1350 DATA 2,1,48,60,110,50,4,4,5,8,9,1,180,100,97,50,4,7,5,9,9
1360 DATA 2,2,55,112,110,50,5,9,9,8,13,2,125,112,180,120,5,9,9,6,13
1370 DATA 1,2,90,112,180,45,6,9,9,3,13
1380 DATA 1,2,115,80,180,50,8,9,9,10,12
1390 DATA 1,1,45,60,110,50,4,4,5,8,9
