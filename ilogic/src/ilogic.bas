10 COLOR 15,1,1
20 screen 2,2,0
30 BLOAD "ilogic.sc2",s
40 defint A-Z

50 SOUND 8,&b00000
51 SOUND 12,48
52 SOUND 11,1
53 SOUND 13, 0
54 SOUND 7,&b10111110
55 SOUND 0,&h4E
56 SOUND 1,5

101 BLOAD "sprites.bin",S
102 FOR I=0 TO 31:PUT SPRITE I,((I MOD 16)*20,132+(I\16)*16),0,0:NEXT I
110 DEF FN FF(X,Y)=VPEEK(&H1800+X\8+(Y\8)*32)
120 R=0:C=0

150 SJ=0:PS%=0:SX=46:SY=80:SV=0:TH=0:TV=0	

151 R$=STR$(R): R$=RIGHT$(R$,LEN(R$)-1)
152 C$=STR$(C): C$=RIGHT$(C$,LEN(C$)-1)
154 BLOAD "map_"+C$+"_"+R$+".scr",S

160 call turbo ON(SX,SY,SV,SJ,R,C)
161 'Load enemies for this room
162 DIMAE(3):DIMDE(3):DIMPO(3):DIMTE(3):DIMMM(3):DIMMN(3):DIMME(3):DIMPM(3):DIMPI(3):DIMCE(3)
163 RESTORE 850
164 IF R=0 GOTO 166
165 FOR I=1 TO R:FOR K=1 TO 10:READ E:FOR J=1 TO E:READ E,E,E,E,E,E,E,E,E,E:NEXT J:NEXT K:NEXT I
166 IF C=0 GOTO 170
167 FOR I=1 TO C:READ E:FOR J=1 TO E:READ E,E,E,E,E,E,E,E,E,E:NEXT J:NEXT I
170 READ E:FOR I=1 TO E:READ TE(I),DE(I),AE(I),MM(I),MN(I),ME(I),PO(I),PI(I),CE(I),PM(I):NEXT I
180 ON SPRITE GOSUB 541

199 X=SX:Y=SY:VY=SV:PJ=SJ:SPRITE ON
200 T=TIME+5
201 ON STICK(0) GOTO 210,220,230,300,300,300,270,280
209 GOTO 300
210 IF PJ%=0 THEN VY%=-8:PJ%=1:SOUND 8,&b11100: SOUND 13, 0:IF PS%>=2 THEN PS%=2 ELSE PS%=0
219 GOTO 300
220 IF PJ%=0 THEN VY%=-8:PJ%=1
221 TH=VPEEK(&H1800+(X+16)\8+((Y+8)\8)*32)
222 PS%=0:IF VPEEK(&H1800+(X+16)\8+((Y+12)\8)*32)=0 AND TH=0 AND VPEEK(&H1800+(X+16)\8+((Y+2)\8)*32)=0 THEN X=X+4
229 GOTO 300
230 TH=VPEEK(&H1800+(X+16)\8+((Y+8)\8)*32)
231 IF VPEEK(&H1800+(X+16)\8+((Y+12)\8)*32)=0 AND TH=0 AND VPEEK(&H1800+(X+16)\8+((Y+2)\8)*32)=0 THEN X=X+4
232 IF PS%=0 AND PJ%=0 THEN PS%=1 ELSE PS%=0
239 GOTO 300
270 TH=VPEEK(&H1800+X\8+((Y+8)\8)*32)
271 IF VPEEK(&H1800+X\8+((Y+12)\8)*32)=0 AND TH=0 AND VPEEK(&H1800+X\8+((Y+2)\8)*32)=0 THEN X=X-4
272 IF PS%=2 AND PJ%=0 THEN PS%=3 ELSE PS%=2
279 GOTO 300
280 IF PJ%=0 THEN VY%=-8:PJ%=1
281 TH=VPEEK(&H1800+X\8+((Y+8)\8)*32)
282 PS%=2:IF VPEEK(&H1800+X\8+((Y+12)\8)*32)=0 AND TH=0 AND VPEEK(&H1800+X\8+((Y+2)\8)*32)=0 THEN X=X-4
289 GOTO 300
300 'End of movement loop 
301 'Check for floor tiles at 3 points under the sprite Y+16,(X, X+8, X+15)'
310 Y=Y+VY%
320 IF VY%<0 GOTO 340
330 TV=VPEEK(&H1800+(X+8)\8+((Y+16)\8)*32)
331 IF VPEEK(&H1800+(X+2)\8+((Y+16)\8)*32)>0 OR TV>0 OR VPEEK(&H1800+(X+12)\8+((Y+16)\8)*32)>0 THEN PJ%=0:VY%=0:Y=Y-(Y MOD 8) ELSE PJ%=-1:VY%=VY%+1:IF VY%>8 THEN VY%=8
339 GOTO 350
340 TV=VPEEK(&H1800+(X+8)\8+(Y\8)*32)
341 IF VPEEK(&H1800+(X+2)\8+(Y\8)*32)>0 OR TV>0 OR VPEEK(&H1800+(X+12)\8+(Y\8)*32)>0 THEN VY%=0:Y=Y+8-(Y MOD 8) ELSE VY%=VY%+1:IF VY%>8 THEN VY%=8
350 IF (TV>=96 AND TV<=125) OR (TX>=96 AND TX<=125) THEN GOTO 500
351 IF TV>=128 AND TV<=142 THEN X=X+4
352 IF TV>=143 AND TV<=157 THEN X=X-4
380 IF X>=226 THEN X=18:C=C+1:GOTO 550
381 IF X<=14 THEN X=222:C=C-1:GOTO 550
382 IF Y>=112 THEN Y=8:R=R+1:GOTO 550
383 IF Y<=4 THEN Y=114:R=R-1:GOTO 550
390 PUT SPRITE 0,(X,Y-1),6,PS%
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
480   PUT SPRITE I,(DE(I)+8,AE(I)-13),CE(I),PO(I)-1
481 NEXT I
490 IF TIME<T GOTO 490
499 GOTO 200

500 'Lost a life
540 GOTO 199

541 'Sprite collision, lose a life
541 PUT SPRITE 0,(0,0),0,0
542 SPRITE OFF
549 RETURN 500

550 'Move to another room
551 FOR I=0 TO 4:PUT SPRITE I,(I*20,132),0,0:NEXT I
555 SPRITE OFF
560 SX=X:SY=Y:SV=VY:SJ=PJ
570 call turbo off
580 GOTO 151

850 DATA 1,1,180,66,94,34,4,4,5,5,9
890 DATA 1,1,110,60,111,50,4,4,5,8,9
920 DATA 1,2,115,76,150,105,4,4,5,2,9
960 DATA 1,2,115,77,180,80,4,9,9,9,11
1000 DATA 2,1,180,66,110,34,6,4,5,5,9,2,100,28,160,80,4,9,9,9,13
1030 DATA 1,1,180,66,122,34,4,4,5,3,9
1060 DATA 1,1,110,60,111,50,4,4,5,8,9
1090 DATA 2,1,110,60,111,50,4,5,5,8,9,1,180,60,111,50,6,7,5,8,9
1120 DATA 1,2,115,90,180,50,8,9,9,3,12
1150 DATA 1,2,115,90,180,50,8,9,9,3,12
1180 DATA 2,1,110,54,111,50,4,5,5,8,9,1,40,60,111,45,6,7,5,7,9
1210 DATA 1,1,180,60,111,50,4,4,5,2,9
1240 DATA 1,1,105,60,111,50,4,4,5,8,9
1270 DATA 1,2,180,60,180,180,0,9,9,8,13
1310 DATA 2,1,110,60,111,50,4,5,5,8,9,1,180,60,111,50,6,7,5,8,9
1340 DATA 1,1,50,30,90,50,4,4,5,8,9
1380 DATA 1,1,110,60,111,40,4,4,5,5,9
1410 DATA 1,1,100,60,111,40,4,4,5,3,9
1450 DATA 1,2,100,27,180,50,6,9,9,7,13
1490 DATA 1,2,115,47,180,80,4,9,9,9,11
1530 DATA 1,2,120,76,150,105,4,4,5,8,9
1570 DATA 1,1,180,60,111,50,6,4,5,3,9
1610 DATA 2,1,110,60,94,50,4,4,5,8,9,1,180,60,111,50,6,4,5,9,9
1640 DATA 2,1,110,60,111,50,4,6,5,8,9,1,70,60,111,60,4,6,5,8,9
1670 DATA 1,1,100,60,111,50,4,4,5,8,9
1700 DATA 3,1,110,60,111,50,4,4,5,8,9,1,170,60,111,60,4,7,5,2,9,1,70,70,111,50,6,5,5,7,9
1730 DATA 1,2,110,77,155,75,6,11,9,4,13
1770 DATA 1,2,80,60,88,46,4,11,9,4,13
1800 DATA 1,1,110,60,111,50,4,4,5,8,9
1830 DATA 2,2,70,27,125,45,6,9,9,7,13,1,45,50,110,50,4,8,5,3,9
1860 DATA 1,1,110,60,111,50,4,5,5,8,9
1890 DATA 1,1,110,60,95,50,5,5,5,5,6
1930 DATA 1,1,42,60,110,70,4,4,5,8,9
1960 DATA 1,1,85,60,111,50,4,4,5,8,9
1990 DATA 2,2,60,111,120,48,5,9,9,7,13,2,180,111,180,140,5,11,9,5,13
2020 DATA 2,1,48,60,111,50,4,4,5,8,9,1,180,100,97,50,4,7,5,9,9
2060 DATA 2,2,55,111,110,50,5,9,9,8,13,2,125,111,180,120,5,9,9,6,13
2090 DATA 1,2,90,111,180,45,6,9,9,3,13
2120 DATA 1,2,115,77,180,50,8,9,9,2,12
2160 DATA 1,1,45,60,111,50,4,4,5,8,9
