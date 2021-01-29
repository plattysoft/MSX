10 COLOR 15,1,1
20 screen 2,2,0
30 BLOAD "ilogic.sc2",s
40 defint A-Z
101 BLOAD "sprites.bin",S
102 FOR I=0 TO 31:PUT SPRITE I,((I MOD 16)*20,132+(I\16)*16),0,0:NEXT I
110 DEF FN FF(X,Y)=VPEEK(&H1800+X\8+(Y\8)*32)
120 R=0:C=0

140 call turbo ON

150 SJ=0:PS%=0:SX=46:SY=80:SV=0:TH=0:TV=0
151 'MOVE TO ANOTHER ROOM REMOVED ON PLAYGROUND
152 RU=1
153 'GOSUB 600

180 ON SPRITE GOSUB 541

199 X=SX:Y=SY:VY%=SV%:PJ%=SJ%:SPRITE ON
200 T=TIME+5
201 ON STICK(0) GOTO 210,220,230,202,202,202,270,280
202 IF PJ%=1 THEN PJ%=2
209 GOTO 300
210 IF PJ%=0 THEN VY%=-5:PJ%=1
211 IF PJ%=2 THEN VY%=-5:PJ%=3
212 IF PS%>=2 THEN PS%=2 ELSE PS%=0
219 GOTO 300
220 IF PJ%=0 THEN VY%=-5:PJ%=1
221 IF PJ%=2 THEN VY%=-5:PJ%=3
222 VX=4
223 PS%=0
229 GOTO 300
230 VX=4
231 IF PJ%=1 THEN PJ%=2
232 IF PS%=0 AND PJ%=0 THEN PS%=1 ELSE PS%=0
239 GOTO 300
270 VX=-4
271 IF PJ%=1 THEN PJ%=2
272 IF PS%=2 AND PJ%=0 THEN PS%=3 ELSE PS%=2
279 GOTO 300
280 IF PJ%=0 THEN VY%=-5:PJ%=1
281 IF PJ%=2 THEN VY%=-5:PJ%=3
282 VX=-4
283 PS%=2
289 GOTO 300
300 'End of movement loop 
310 'Check for floor tiles at 3 points under the sprite Y+16,(X, X+8, X+15)'
310 Y=Y+VY%
320 IF VY%>=0 THEN TY=((Y+16)\8)*32 ELSE TY=(Y\8)*32
330 TV=VPEEK(&H1800+(X+8)\8+TY)
331 TW=VPEEK(&H1800+(X+2)\8+TY)
332 TU=VPEEK(&H1800+(X+12)\8+TY)
333 IF TU>31 OR TV>31 OR TW>31 THEN IF VY%>=0 THEN GOTO 340 ELSE GOTO 345
334 IF PJ%=0 THEN PJ%=-1
335 VY%=VY%+1:IF VY%>8 THEN VY%=8
336 GOTO 350
340 PJ%=0:VY%=0:Y=Y-(Y MOD 8)
341 GOTO 350
345 VY%=0:Y=Y+8-(Y MOD 8)
350 ' CONVOY BELT BEHAVIOUR 
351 IF TV>=128 AND TV<=132 THEN VX=VX-4
352 IF TV>=133 AND TV<=139 THEN VX=VX-2
353 IF TV>=146 AND TV<=151 THEN VX=VX+2
354 IF TV>=152 AND TV<=157 THEN VX=VX+4
360 ' Check for death tiles TH. TI, TG
360 IF VX=0 THEN TH=0: TI=0: TG=0: GOTO 370
361 IF VX>0 THEN TX=&H1800+(X+16)\8 ELSE TX=&H1800+X\8
362 TH=VPEEK(TX+((Y+8)\8)*32)
363 TI=VPEEK(TX+((Y+12)\8)*32)
364 TG=VPEEK(TX+((Y+2)\8)*32)
365 IF TH>31 OR TI>31 OR TG>31 THEN VX=0
366 X=X+VX:VX=0
370 IF (TV>=96 AND TV<=125) OR (TW>=96 AND TW<=125) OR (TU>=96 AND TU<=125) THEN GOTO 500
371 IF (TH>=96 AND TH<=125) OR (TI>=96 AND TI<=125) OR (TG>=96 AND TG<=125) THEN GOTO 500
380 ' Move to another room
380 IF TH=31 THEN X=6:C=C+1:GOTO 550
381 IF TH=30 THEN X=234:C=C-1:GOTO 550
392 ' We substract VY from the desired Y position to be compensated on next loop
382 IF TV=6 THEN Y=8-VY%:R=R+1:GOTO 550
383 IF TV=5 THEN Y=104-VY%:R=R-1:GOTO 550
390 PUT SPRITE 0,(X,Y-1),6,PS%

400 IF STRIG(0)=-1 AND PJ%=0 THEN GOSUB 600

490 IF TIME<T GOTO 490
491 GOSUB 900
498 IF TIME>=60 THEN TIME=0

499 GOTO 200

500 'Lost a life
540 GOTO 199

541 'Sprite collision, lose a life
541 PUT SPRITE 0,(0,0),0,0
542 SPRITE OFF
549 RETURN 500

550 'Move to another room
550 'FOR I=0 TO 4:PUT SPRITE I,(I*20,132),0,0:NEXT I
555 SPRITE OFF
560 SX=X:SY=Y:SV%=VY%:SJ%=PJ%
570 'call turbo off
580 GOTO 151

600 ' SWITCH RED AND BLUE TILES
600 TC = VPEEK(&H1800+(X+8)\8+((Y+8)\8)*32)
610 IF TC>6 AND TC<11 THEN GOSUB 650
620 IF TC>10 AND TC<15 THEN GOSUB 750
621 IF TC>14 AND TC<20 THEN GOSUB 800
629 IF STRIG(0)=-1 GOTO 629
630 RETURN

650 FOR I=&H1800 TO &H19FF
651   CT=VPEEK(I)
653   IF CT=65 THEN VPOKE I, 1
654   IF CT=4 THEN VPOKE I, 66
655   IF CT>6 AND CT<11 THEN VPOKE I, CT+4
680 NEXT I
690 RETURN

750 FOR I=&H1800 TO &H19FF
751   CT=VPEEK(I)
752   IF CT=1 THEN VPOKE I, 65
754   IF CT=66 THEN VPOKE I, 4
755   IF CT>10 AND CT<15 THEN VPOKE I, CT-4
780 NEXT I
790 RETURN

800 'Swap the convoy belts
810 TK=TC+1: IF TK=20 THEN TK=15
820 FOR I=&H1800 TO &H19FF
821   CT=VPEEK(I)
822   IF CT=TC THEN VPOKE I, TK
823   IF CT>127 AND CT<152 THEN VPOKE I, CT+6
824   IF CT>151 AND CT<158 THEN VPOKE I, CT-24
830 NEXT I
840 RETURN

900 ' Animation
901 IF AN=15 THEN AN=8 ELSE AN=AN+1
910 ' Lasers
910 FOR I=887 TO 895
911   VPOKE I, VPEEK(I+AN)
912   VPOKE I+2048, VPEEK(I+2048+AN)
913   VPOKE I, VPEEK(I+AN)
914   VPOKE I+2048, VPEEK(I+2048+AN)
920 NEXT I
925 ' Belts
926 IF AF=40 THEN AF=16 ELSE AF=AF+8
927 AG=AF+16: IF AG>40 THEN AG=AG-32
930 ' Consider animating only the current mode
930 FOR I=128*8 TO 128*8+8
931 ' FAST BACK
931   VPOKE I, VPEEK(I+AF)
932   VPOKE I+2048, VPEEK(I+2048+AF)
933   VPOKE I+8, VPEEK(I+AG)
934   VPOKE I+2048+8, VPEEK(I+2048+AG)
935 ' BACK
935   VPOKE I+48, VPEEK(I+48+AF)
936   VPOKE I+48+8, VPEEK(I+48+AF)
937   VPOKE I+2048+48, VPEEK(I+2048+48+AF)
938   VPOKE I+2048+48+8, VPEEK(I+2048+48+AF)
939 ' FORWARD (actually, it is the same byte 4 times)
939   VPOKE I+144, VPEEK(I+144+AF)
940   VPOKE I+2048+144, VPEEK(I+2048+144+AF)
941   VPOKE I+144+8, VPEEK(I+144+AF)
942   VPOKE I+2048+144+8, VPEEK(I+2048+144+AF)
943 ' FAST FORWARD
944   VPOKE I+192, VPEEK(I+192+AF)
944   VPOKE I+2048+192, VPEEK(I+2048+192+AF)
945   VPOKE I+192+8, VPEEK(I+192+AG)
946   VPOKE I+2048+192+8, VPEEK(I+2048+192+AG)
948 NEXT I
949 RETURN