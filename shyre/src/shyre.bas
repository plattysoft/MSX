100 COLOR 15,1,1:SCREEN 2,2,0

FILE "cls.plet5" ' 0
FILE "sprites.bin.plet5"

INCLUDE "rooms.inc"

FILE "empty.akm" '37
FILE "sfx.akx"

FILE "shyre.chr.plet5"' 39
FILE "shyre.clr.plet5"
FILE "start.chr.plet5"' 41
FILE "start.clr.plet5"

FILE "start.plet5" '43
FILE "end.plet5"
FILE "intro.plet5" '45
FILE "room_6_0.plet5" '46 - intro, outside

101 CMD WRTSCR 0

110 CMD PLYLOAD 37, 38
120 'CMD PLYSONG 0
130 CMD PLYPLAY

204 DEFINT A-Z
206 DIM TL(767)
207 DIM KT(190)

208 'Load Sprites
209 CMD WRTVRAM 1, &H3800

210 'GOTO 250 'Debug straight into game
211 GOSUB 2000 'Platty Intro

250 'CMD WRTCHR 39:CMD WRTCLR 40' Load tileset for gameplay (redundant, it is done in the intro)
252 ' Remove the color from the marker tiles
253 FOR I=0 TO 31
254  VPOKE &H21E0+I, 0:VPOKE &H29E0+I, 0:VPOKE &H31E0+I, 0
255 NEXT I
256 ' Remove the color from the map tiles
257 IF MP=1 THEN 269 'Fully supporting New Game+
258 FOR I=0 TO 23
259  VPOKE &H2028+I, 0:VPOKE &H2828+I, 0:VPOKE &H3028+I, 0
260 NEXT I

269 ' Initializing new game
270 'RR=2:RC=4:RH=3:I1=1:I5=1:I2=1:MP=1:I4=1
271 RR=4:RC=2:RH=0
272 GOSUB 900

280 X=88:Y=192:GS=1:MD=1:CS=26:WS=0
281 IX=X:IY=144:ID=MD:IG=GS:IM=0:IS=CS:IB=0 'Initial state for the first room
282 IF STRIG(0) OR STRIG(1) GOTO 282

290 FY=144:GOSUB 3900
291 CS=26:WS=0

297 T$="COMS ARE JAMMED[#NEED TO FIND A#WAY BACK[":GOSUB 1300

300 TIME=0' BEGIN GAME LOOP
301 ON GS GOSUB 400,500,600,700,720

389 PUT SPRITE 1,(X,Y),5,CS:PUT SPRITE 2,(X,Y),15,CS+1:PUT SPRITE 3,(X,Y),1,FS

390 IF TIME<2 THEN 390

391 'IF GS<1 THEN GS=GS+1 'No longer needed, we have proper states

399 GOTO 300 ' END GAME LOOP

400 'GS=1: IDLE, can transition into moving (GS=2) or pushing (GS=3)
401 PT=&H1800+X\8+(Y\8)*32:PP=0
402 ON STICK(SS) GOTO 410,403,430,403,450,403,470,403
403 IF STRIG(SS) THEN SR=SR+1 ELSE SR=0
404 IF SR=10 THEN SR=0:GOSUB 1050
409 RETURN

410 MD=1
411 T1=VPEEK(PT-32):T2=VPEEK(PT-31)
412 IF T1=224 THEN PS=0:PC=9:GOTO 420
413 IF T1=226 THEN IF I4=1 THEN PS=1:PC=6:GOTO 420 ELSE GOSUB 1400 'Too heavy dialog
414 IF T1=60 AND T2=60 THEN RR=RR-1:Y=176:GOSUB 495
416 IF T1=178 THEN IF I1=1 THEN CMD PLYSOUND 13:GS=5:MS=8:PT=PT-64:NT=10:RETURN ELSE GOSUB 1410
417 IF T1=182 THEN IF I5=1 THEN CMD PLYSOUND 14:GS=5:MS=8:PT=PT-64:NT=70:RETURN ELSE GOSUB 1414
419 GOTO 490
420 IF VPEEK(PT-96)<60 AND VPEEK(PT-95)<60 THEN GS=3:MS=8:CMD PLYSOUND 7:PUT SPRITE 0,(X,Y-17),PC,PS:PP=PT-64:PF=PP-32 ELSE GS=4:MS=8
429 GOTO 490

430 MD=2
431 T1=VPEEK(PT+2):T2=VPEEK(PT+34)
432 IF T1=192 THEN PS=0:PC=9:GOTO 440
433 IF T1=194 THEN IF I4=1 THEN PS=1:PC=6:GOTO 440 ELSE GOSUB 1400 'Too heavy dialog
434 IF T1=61 AND T2=61 THEN RC=RC+1:X=0:GOSUB 495
436 IF T1=146 THEN IF I1=1 THEN CMD PLYSOUND 13:GS=5:MS=8:PT=PT+2:NT=10:RETURN ELSE GOSUB 1410
437 IF T1=150 THEN IF I5=1 THEN CMD PLYSOUND 14:GS=5:MS=8:PT=PT+2:NT=70:RETURN ELSE GOSUB 1414
439 GOTO 490
440 IF VPEEK(PT+4)<60 AND VPEEK(PT+36)<60 THEN GS=3:MS=8:CMD PLYSOUND 7:PUT SPRITE 0,(X+16,Y-1),PC,PS:PP=PT+2:PF=PP+1 ELSE GS=4:MS=8
449 GOTO 490

450 MD=3
451 T1=VPEEK(PT+64):T2=VPEEK(PT+65)
452 IF T1=192 THEN PS=0:PC=9:GOTO 460
453 IF T1=194 THEN IF I4=1 THEN PS=1:PC=6:GOTO 460 ELSE GOSUB 1400 'Too heavy dialog
454 IF T1=62 AND T2=62 THEN RR=RR+1:Y=0:GOSUB 495
456 IF T1=146 THEN IF I1=1 THEN CMD PLYSOUND 13:GS=5:MS=8:PT=PT+64:NT=10:RETURN ELSE GOSUB 1410
457 IF T1=150 THEN IF I5=1 THEN CMD PLYSOUND 14:GS=5:MS=8:PT=PT+64:NT=70:RETURN ELSE GOSUB 1414
458 IF T1=239 THEN GOSUB 1470
459 GOTO 490
460 IF VPEEK(PT+128)<60 AND VPEEK(PT+129)<60 THEN GS=3:MS=8:CMD PLYSOUND 7:PUT SPRITE 0,(X,Y+15),PC,PS:PP=PT+64:PF=PP+32 ELSE GS=4:MS=8
469 GOTO 490

470 MD=4
471 T1=VPEEK(PT-1):T2=VPEEK(PT+31)
472 IF T1=193 THEN PS=0:PC=9:GOTO 480
473 IF T1=195 THEN IF I4=1 THEN PS=1:PC=6:GOTO 480 ELSE GOSUB 1400 'Too heavy dialog
474 IF T1=63 AND T2=63 THEN RC=RC-1:X=176:GOSUB 495
476 IF T1=147 THEN IF I1=1 THEN CMD PLYSOUND 13:GS=5:MS=8:PT=PT-2:NT=10:RETURN ELSE GOSUB 1410
477 IF T1=151 THEN IF I5=1 THEN CMD PLYSOUND 14:GS=5:MS=8:PT=PT-2:NT=70:RETURN ELSE GOSUB 1414
479 GOTO 490
480 IF VPEEK(PT-3)<60 AND VPEEK(PT+29)<60 THEN GS=3:MS=8:CMD PLYSOUND 7:PUT SPRITE 0,(X-16,Y-1),PC,PS:PP=PT-2:PF=PP-1 ELSE GS=4:MS=8
489 GOTO 490

490 ' Other checks
491 TT=VPEEK(PT)
492 IF T1<128 AND T2<128 THEN GS=2:MS=4:BS=MD*9-7:CMD PLYSOUND 6:GOSUB 500
493 IF GS=3 THEN BS=33+MD*5:VPOKE PP,TL(PP-&H1800):VPOKE PP+1,TL(PP+1-&H1800):VPOKE PP+32,TL(PP+32-&H1800):VPOKE PP+33,TL(PP+33-&H1800)
494 RETURN

495 GS=2:MS=4:BS=MD*9-7:GOSUB 740:RETURN

500 'GS=2: MOVING, there is no user input. Check for picking up items once moving is completed
509 ON MD GOTO 510,520,530,540
510 Y=Y-2:GOTO 550
520 X=X+2:GOTO 550
530 Y=Y+2:GOTO 550
540 X=X-2:GOTO 550
550 MS=MS-1:IF MS<=0 THEN GS=1:GOSUB 570
560 WS=(WS+1) MOD 8:WT=WS\2:IF WT=2 OR WT=0 THEN CS=6 ELSE IF WT=1 THEN CS=0 ELSE CS=3
561 CS=BS+CS:FS=CS+2
569 RETURN

570 'Stair and items checks at end of moving (this should be done AFTER DRAWING)
571 PT=&H1800+X\8+(Y\8)*32:PP=0
572 T1=VPEEK(PT):T2=VPEEK(PT+1):T3=VPEEK(PT+32):T4=VPEEK(PT+33)
573 IF T1=64 THEN RH=RH+1:CMD PLYSOUND 10:GOSUB 740 'Stairs up
574 IF T1=66 THEN RH=RH-1:CMD PLYSOUND 10:GOSUB 740 'Stairs down
575 IF T1=86 THEN I1=1:GOSUB 780:CMD PLYSOUND 3:GOSUB 1420
576 IF T1=88 AND I2=0 THEN I2=1:GOSUB 780:CMD PLYSOUND 3:GOSUB 1430 ' Pick up the battery
577 IF T1=90 THEN MP=1:GOSUB 780:CMD PLYSOUND 3:GOSUB 1460:GOSUB 1500 ' Pick up the map
578 IF T1=92 THEN I4=1:GOSUB 780:CMD PLYSOUND 3:GOSUB 1440
579 IF T1=84 THEN I5=1:GOSUB 780:CMD PLYSOUND 3:GOSUB 1450
580 IF T1=74 THEN GOSUB 410:CMD PLYSOUND 8:RETURN 'Up tile
581 IF T1=76 THEN GOSUB 430:CMD PLYSOUND 8:RETURN 'Right tile
582 IF T1=78 THEN GOSUB 450:CMD PLYSOUND 8:RETURN 'Up tile
583 IF T1=80 THEN GOSUB 470:CMD PLYSOUND 8:RETURN 'Right tile
584 IF T1=39 OR T2=39 OR T3=39 OR T4=39 THEN GOSUB 1100 'Death by laser, reset room
585 IF T1=26 THEN GOTO 1200 'Step on an active transmitter: Game Finished!
586 IF T1=94 AND I2=1 THEN I2=2:GOSUB 820:CMD PLYSOUND 3:GOSUB 1412 'batteries in place, swap colors
587 IF T1=24 THEN GOSUB 1416
599 RETURN

600 'GS=3: PUSHING, check for events at the end of pushing (sliding, floor switches)
601 ON MD GOTO 611,612,613,614
611 Y=Y-1:PUT SPRITE 0,(X,Y-17):GOTO 615
612 X=X+1:PUT SPRITE 0,(X+16,Y-1):GOTO 615
613 Y=Y+1:PUT SPRITE 0,(X,Y+15):GOTO 615
614 X=X-1:PUT SPRITE 0,(X-16,Y-1):GOTO 615

615 MS=MS-1
616 IF MS>6 OR MS<=2 THEN CS=BS ELSE CS=BS+2' Implement common for all directions
617 FS=BS+4

622 IF MS>0 THEN RETURN
623 GS=1:TT=TL(PF-&H1800)' Test Tile (Where the crate stands now)
624 IF TT>=28 AND TT<=31 AND TL(PF+1-&H1800)>=28 AND TL(PF+1-&H1800)<=31 AND TL(PF+32-&H1800)>=28 AND TL(PF+32-&H1800)<=31 AND TL(PF+33-&H1800)>=28 AND TL(PF+33-&H1800)<=31 GOSUB 675 'Icy floor

625 'LASER HANDLING
630 IF MD=4 AND TT=39 THEN VPOKE PF,0:TL(PF-&H1800)=0
631 IF MD=4 AND TL(PF-&H1800+32)=39 THEN VPOKE PF+32,0:TL(PF-&H1800+32)=0
632 IF MD=1 AND (VPEEK(PF+63)=39 OR VPEEK(PF+63)=238) THEN OT=0:NT=39:IT=PF+64:GOSUB 800:GOSUB 1100:GOTO 669' Lasers are back (to the right) and we die
633 IF MD=3 AND (VPEEK(PF-33)=39 OR VPEEK(PF-33)=238) THEN OT=0:NT=39:IT=PF-32:GOSUB 800:GOSUB 1100:GOTO 669' Lasers are back (to the right) and we die
634 IF MD=1 AND TT=39 THEN OT=39:NT=0:IT=PF:GOSUB 800
635 IF MD=3 AND TL(PF-&H1800+32)=39 THEN OT=39:NT=0:IT=PF+32:GOSUB 800

656 TP=VPEEK(PT):PT=PF:NT=192+2*PS:GOSUB 765:PUT SPRITE 0,(0,0),0,0
657 IF TT=18 THEN CT=144:NT=16:CMD PLYSOUND 8:GS=5:MS=8:GOSUB 1670 'Open magenta door (with crate)
658 IF TL(PP-&H1800)=18 THEN CT=16:NT=144:CMD PLYSOUND 11:GS=5:MS=8:GOSUB 1670 'Close magenta door (crate moves out)
659 IF TT=22 THEN CT=148:NT=20:CMD PLYSOUND 8:GS=5:MS=8:GOSUB 1670 'Open cyan door (with crate)
660 IF TL(PP-&H1800)=22 THEN CT=20:NT=148:CMD PLYSOUND 11:GS=5:MS=8:GOSUB 1670 'Close cyan door (crate moves out)
669 RETURN

675 ' On icy floor, if ice in the next tiles in the current direction, continue sliding
676 ON MD GOTO 677,678,679,680
677 CX=X:CY=Y-17:GOTO 681
678 CX=X+16:CY=Y-1:GOTO 681
679 CX=X:CY=Y+15:GOTO 681
680 CX=X-16:CY=Y-1:GOTO 681

681 PT=PF:ON MD GOTO 682,683,684,685
682 T1=VPEEK(PF-32):T2=VPEEK(PF-31):PF=PP-32:GOTO 686
683 T1=VPEEK(PF+2):T2=VPEEK(PF+34):PF=PP+1:GOTO 686
684 T1=VPEEK(PF+64):T2=VPEEK(PF+65):PF=PP+32:GOTO 686
685 T1=VPEEK(PF-1):T2=VPEEK(PF+31):PF=PP-1:GOTO 686

686 IF T1>=28 AND T1<=31 AND T2>=28 AND T2<=31 THEN PP=PT:GOTO 690
689 RETURN

690 CMD PLYSOUND 15:FOR I=1 TO 4' Why is this 4 and not 8?? Where is the reentrant code?
691  ON MD GOTO 692,693,694,695
692  CY=CY-1:GOTO 696
693  CX=CX+1:GOTO 696
694  CY=CY+1:GOTO 696
695  CX=CX-1:GOTO 696
696  PUT SPRITE 0,(CX,CY),9,0
697  IF TIME<1 GOTO 697 ELSE TIME=0
698 NEXT
699 GOTO 681

700 'GS=4 unsuccess push
710 MS=MS-1
711 IF MS>6 OR MS<=2 THEN CS=33+MD*5 ELSE CS=35+MD*5' Implement common for all directions
712 IF MS=0 THEN GS=1
717 FS=37+MD*5
719 RETURN

720 'GS=5 waiting to change sprite (hammer and machete)
721 MS=MS-1
722 IF MS=0 THEN GOSUB 760:GS=1
729 RETURN


740 IX=X:IY=Y:ID=MD:IG=GS:IM=MS:IS=CS:IB=BS 'Remember state of player when enters the room (*I*nitial state)
750 'load room and checks
751 PUT SPRITE 1,,0,0:PUT SPRITE 2,,0::PUT SPRITE 3,,0
754 GOSUB 900 'Load room and check items
759 RETURN

760 ' Replace 4 tiles starting at PT (previous tile) with tiles from NT (new tile)
761 II=PT-&H1800:TL(II)=NT:TL(II+1)=NT+1:TL(II+32)=NT+32:TL(II+33)=NT+33
765 VPOKE PT,NT:VPOKE PT+1,NT+1:VPOKE PT+32,NT+32:VPOKE PT+33,NT+33
769 RETURN

780 ' Pick up items
781 NT=0:GOSUB 760:GOSUB 790
789 RETURN

790 ' Redraw item space (to be reused when loading rooms and when picking up items)
791 IF MP=1 THEN PT=&H189D:NT=90:GOSUB 765 ' MAP (should be I3)
792 IF I1=1 THEN PT=&H189A:NT=86:GOSUB 765 ' I1 is machete
793 IF I2=1 THEN PT=&H18DD:NT=88:GOSUB 765 ' I2 is batteries
794 IF I4=1 THEN PT=&H185D:NT=92:GOSUB 765 ' I4 is magnet
795 IF I5=1 THEN PT=&H18DA:NT=84:GOSUB 765 ' I5 is hammer
799 RETURN

800 'Delete all OT with NT starting at IT moving right
801 IF VPEEK(IT)<>OT THEN RETURN ELSE VPOKE IT,NT:TL(IT-&H1800)=NT:IT=IT+1:GOTO 801

820 ' Putting batteries in place
821 PT=&H18DD:NT=0:GOSUB 765 'delete them from items
822 CT=94:NT=88:GOSUB 1670 'Draw batteries in place
823 CT=24:NT=26:GOSUB 1670 'Swap ending tile
829 RETURN

900 'Explore room, remember floor type and remove collected items
901 IF RH=0 THEN CR=2+RR*5+RC ELSE IF RH=1 THEN CR=27+(RR-1)*3+RC-1 ELSE CR=36
902 CMD WRTSCR CR

903 GOSUB 790 'Redraw items

904 GOSUB 980 'Remove items from screen space

910 FOR I=0 TO 734 STEP 32
911  FOR J=0 TO 23
920   T=VPEEK(&H1800+I+J)
930   IF T<192 THEN TL(I+J)=T ELSE TL(I+J)=0
931   'IF T>=84 AND T<=94 GOSUB 970 ' Dynamic removal of items, enable for debugging
946   'IF I2=2 AND T=24 THEN PT=&H1800+I+J:NT=26:GOSUB 760 ' Enable teleport if batteries are in
949  NEXT J
950 NEXT I
959 WS=0 ' Reset the walking sprite count (gets off when killed by laser)
960 RETURN

970 'IF MP=1 AND T=90 THEN PT=&H1800+I+J:NT=0:GOSUB 760 ' Delete map item from screen space
971 'IF I1=1 AND T=86 THEN PT=&H1800+I+J:NT=0:GOSUB 760
973 'IF I2>0 AND T=88 THEN PT=&H1800+I+J:NT=0:GOSUB 760 ' Delete batteries from screen space
974 'IF I4=1 AND T=92 THEN PT=&H1800+I+J:NT=0:GOSUB 760
975 'IF I2=2 AND T=94 THEN PT=&H1800+I+J:NT=88:GOSUB 760 ' Show batteries as plugged if they are plugged
977 'IF I5=1 AND T=84 THEN PT=&H1800+I+J:NT=0:GOSUB 760
979 'RETURN

980 IF MP=1 AND CR=34 THEN PT=&H1A15:NT=0:GOSUB 760 ' Delete map item from screen space: (16,31)-> &H215
981 IF I1=1 AND CR=26 THEN PT=&H1A44:NT=0:GOSUB 760 ' Machete:(18,4) -> &H244
983 IF I2>0 AND CR=16 THEN PT=&H186B:NT=0:GOSUB 760 ' Delete batteries from screen space (3,11) -> &H6B
984 IF I4=1 AND CR=22 THEN PT=&H1A82:NT=0:GOSUB 760 ' Magnet: (20,2) -> &H282 (MAGNET?)
985 IF I2=2 AND CR=36 THEN PT=&H194B:NT=88:GOSUB 760:PT=&H1A2B:NT=26:GOSUB 760 ' Plugged Batteries (10,11) -> &H14B / (17,11) Teleport &h22B
987 IF I5=1 AND CR=9  THEN PT=&H1AB5:NT=0:GOSUB 760' Hammer: (21,21) -> 21*32+21 -> &H2B5
989 RETURN

1000 PUT SPRITE 0,(X,Y),7,58
1001 I=0:CMD PLYSOUND 12
1010 PUT SPRITE 0,,,I+58
1011 I=I+1
1012 IF TIME<4 THEN GOTO 1012 ELSE IF I<4 THEN TIME=0:GOTO 1010
1013 PUT SPRITE 1,,0:PUT SPRITE 2,,0:PUT SPRITE 3,,0
1014 PUT SPRITE 0,,,I+58
1015 I=I-1
1016 IF TIME<4 THEN GOTO 1016 ELSE IF I>=0 THEN TIME=0:GOTO 1014
1017 PUT SPRITE 0,(0,0),0
1018 RETURN

1050 'Reset the room
1051 GOSUB 1000
1052 X=IX:Y=IY:GS=IG:MD=ID:MS=IM:CS=IS:BS=IB 'Remember starting position on a room
1053 GOSUB 750
1054 RETURN 300

1100 'Death by laser animation
1102 PUT SPRITE 0,(X,Y),13,43:GOSUB 1001
1111 X=IX:Y=IY:GS=IG:MD=ID:MS=IM:CS=IS:BS=IB 'Remember starting position on a room
1120 GOSUB 750
1130 RETURN 300

1200 ' Ending
1201 GOSUB 1000
1220 'Last remarks and then THE END
1250 IF TIME<50 THEN 1250
1251 CMD WRTSCR 0

1260 T$="YOU RETURNED TO THE SHIP#JUST IN TIME[":TY=4:GOSUB 1290
1261 T$="THE STORM INTENSIFIED AND#DESTROYED THE RUINS[":TY=9:GOSUB 1290
1262 T$="YOUR RECORDS ARE ALL THAT#REMAINS[":TY=14:GOSUB 1290
1263 T$="JUST ANOTHER DAY ON THE#SPACE ARCHEOLOGY CORPS[":TY=19:GOSUB 1290

1280 CMD WRTSCR 0
1281 CMD WRTCHR 41
1282 CMD WRTCLR 42
1283 CMD WRTSCR 44' THE END Screen
1284 'Debounce, then wait for press space
1288 IF STRIG(SS) THEN 1288
1289 IF NOT STRIG(SS) THEN 1289 ELSE GOTO 210

1290 TX=2:GOSUB 1900:TIME=0
1291 IF STRIG(SS) THEN 1291
1292 IF STRIG(SS) THEN 1294
1293 IF TIME<500 THEN 1292
1294 RETURN

1300 ' Display a pop-up
1301 ' Store current scrren info
1302 KS=&H1903
1303 FOR I=0 TO 9 'Rows
1304   FOR J=0 to 17 'Columns
1305     KT(I*18+J)=VPEEK (KS+I*32+J)
1306   NEXT J
1307 NEXT I

1308 IF X<16 OR X>160 OR Y<56 OR Y>128 GOTO 1311
1309 PUT SPRITE 1,,0,0:PUT SPRITE 2,,0::PUT SPRITE 3,,0

1311 VPOKE KS,2:FOR J=1 to 16:VPOKE KS+J,36:NEXT J:VPOKE KS+17, 3
1320 FOR I=1 TO 8 'Rows
1321   VPOKE KS+I*32, 4
1330   FOR J=1 to 16 'Columns
1340     VPOKE KS+I*32+J, 0
1350   NEXT J
1351   VPOKE KS+I*32+17, 4
1360 NEXT I
1370 KS=&H1A03:VPOKE KS,34:FOR J=1 to 16:VPOKE KS+J,36:NEXT J:VPOKE KS+17, 35
1371 CMD PLYSOUND 5
1375 TX=4:TY=9:GOSUB 1900
1376 IF STRIG(SS) THEN 1376
1379 IF NOT STRIG(SS) THEN 1379

1380 ' Dismiss
1382 KS=&H1903
1383 FOR I=0 TO 9 'Rows
1384   FOR J=0 to 17 'Columns
1385     VPOKE KS+I*32+J, KT(I*18+J)
1386   NEXT J
1387 NEXT I

1390 RETURN

1400 T$="THIS METAL CRATE#IS TOO HEAVY[#I CAN\T MOVE IT["
1401 GOSUB 1300:RETURN

1410 T$="A SMALL TREE[#I COULD CUT IT#WITH THE PROPER#TOOL["
1411 GOSUB 1300:RETURN

1412 T$="BATTERY PLUGGED[#THE SYSTEM IS#WORKING AGAIN["
1413 GOSUB 1300:RETURN

1414 T$="A WEAK WALL[#I COULD BREAK IT#WITH THE PROPER#TOOL["
1415 GOSUB 1300:RETURN

1416 T$="THE TRANSMITTER#IS OFF[#I NEED TO POWER#IT UP["
1417 GOSUB 1300:RETURN

1420 T$="FOUND A MACHETE[#NOW I CAN CLEAR#CUT TREES["
1421 GOSUB 1300:RETURN

1430 T$="FOUND A BATTERY[#I SHOULD PLUG IT#SOMEWHERE["
1431 GOSUB 1300:RETURN

1440 T$="FOUND A MAGNET[#NOW I CAN PUSH#METAL CRATES["
1441 GOSUB 1300:RETURN

1450 T$="FOUND A HAMMER[#NOW I CAN BREAK#WEAK WALLS["
1451 GOSUB 1300:RETURN

1460 T$="FOUND A MAP[#NOW I CAN SEE#WHERE I AM["
1461 GOSUB 1300:RETURN

1470 T$="IS DANGROUS OUT#THERE[#I NEED TO FIND#OTHER WAY BACK["
1471 GOSUB 1300:RETURN

1500 'Activate map the map (enable colors in the 3 tiles)
1501 FOR I=0 TO 7
1502  VPOKE &H2028+I,&H40:VPOKE &H2828+I,&H40:VPOKE &H3028+I,&H40
1503  VPOKE &H2030+I,&HA0:VPOKE &H2830+I,&HA0:VPOKE &H3030+I,&HA0
1504  VPOKE &H2038+I,&H60:VPOKE &H2838+I,&H60:VPOKE &H3038+I,&H60
1505 NEXT I
1506 RETURN

1670 FOR I=0 TO 734 STEP 32
1671  FOR J=0 TO 23
1672   IF TL(I+J)=CT THEN PT=&H1800+I+J:GOSUB 760:RETURN
1673  NEXT J:NEXT I
1674 RETURN

1900 'Write text T$ on Screen at position TX, TY (in row/column)
1901 TF=0
1910 FOR I=1 TO LEN(T$)
1911   TF=TF+1
1920   CT$=MID$(T$,i,1)
1940   IF CT$=" " THEN TT=0 ELSE TT=ASC(CT$)+131
1941   IF CT$="#" THEN TF=0:TY=TY+2 ELSE VPOKE &H1800+TX-1+TY*32+TF, TT
1950 NEXT I
1990 RETURN

2000 ' Platty Soft Intro
2001 CMD WRTSCR 0 'CLS
2002 CMD WRTCHR 41 ' Load tiles for home screen and platty intro
2003 CMD WRTCLR 42

2010 STRIG(0) ON: STRIG(1) ON
2020 ON STRIG GOSUB 2700, 2700

2100 'Prepare the initial position
2110 FOR I=0 to 3
2120  FOR K=0 TO 3
2121   VPOKE &H1906+I+K*32,152+I*32+K
2122  NEXT K
2123 NEXT I

2300 ' Scroll up 32 times (push everything up and add a line at the bottom on the 4 tiles)
2310 FOR I=0 TO 31
2311 TIME=0
2312  FOR J=1 TO 31
2313   FOR K=0 TO &H300 STEP &H100
2321    VPOKE &HCBF+J+K, VPEEK(&HCC0+J+K)
2323    VPOKE &H2CBF+J+K, VPEEK(&H2CC0+J+K)
2347   NEXT K
2348  NEXT J
2350  FOR K=0 TO &H300 STEP &H100
2352   VPOKE &HCDF+K, VPEEK(&H4E0+I+K)
2354   VPOKE &H2CDF+K, VPEEK(&H2CE0+I+K)
2396  NEXT K
2397 IF TIME<1 GOTO 2397
2398 NEXT I

2500 FOR I=0 TO 8
2509  TIME = 0
2510  FOR K=0 TO I
2520   VPOKE &H192A+K,172-I+K:VPOKE &H194A+K,204-I+K::VPOKE &H196A+K,236-I+K
2530  NEXT K
2531  IF TIME<2 GOTO 2531
2540 NEXT I
2600 FOR I=0 TO 5
2609  TIME = 0
2610  FOR K=0 TO I
2620   VPOKE &H1933+K,178-I+K:VPOKE &H1953+K,210-I+K::VPOKE &H1973+K,242-I+K
2630  NEXT K
2631  IF TIME<2 GOTO 2631
2640 NEXT I

2650 TIME=0
2660 IF TIME<75 GOTO 2660

2680 STRIG(0) OFF: STRIG(1) OFF

2699 GOTO 2800

2700 STRIG(0) OFF: STRIG(1) OFF:RETURN 2800

2800 'Shyre START GAME screen
2810 CMD WRTSCR 43
2811 IF STRIG(0) OR STRIG(1) GOTO 2811 'Debouncing space press
2820 IF STRIG(0) THEN SS=0:GOTO 3000
2821 IF STRIG(1) THEN SS=1:GOTO 3000
2830 GOTO 2820

3000 CMD WRTSCR 0
3002 CMD WRTCHR 39 ' Load tileset for gameplay
3003 CMD WRTCLR 40

3011 T$="RESEARCH MISSION[[[#ALIEN RUINS OF PLANET SHYRE":TY=4:GOSUB 1290

3019 CMD WRTSCR 45 ' Pick up the datapad
3020 T$="IT IS DANGEROUS TO GO#ALONE[ I\LL TAKE THIS[" 'TODO This could be in the screen itself
3021 TX=2:TY=7:GOSUB 1900
3022 PT=&H19AC:NT=82:GOSUB 765
3023 X=96:Y=170':BS=15'3*6-3
3024 TIME=0:PUT SPRITE 1,(X,Y),5,26:PUT SPRITE 2,(X,Y),15,27:PUT SPRITE 3,(X,Y),1,28
3025 IF STRIG(0) OR STRIG(1) GOTO 3025

3026 IF TIME<25 THEN 3026

3027 ON STRIG GOSUB 3032, 3032
3028 STRIG(0) ON: STRIG(1) ON

3030 FY=100:GOSUB 3900
3031 STRIG(0) OFF: STRIG(1) OFF:GOTO 3040

3032 STRIG(0) OFF: STRIG(1) OFF
3033 PT=&H19AC:NT=0:GOSUB 765:PT=&H185A:NT=82:GOSUB 765
3034 PUT SPRITE 1,,0:PUT SPRITE 2,,0:PUT SPRITE 3,,0
3036 RETURN 3200

3040 CMD PLYSOUND 3
3041 PT=&H19AC:NT=0:GOSUB 765:PT=&H185A:NT=82:GOSUB 765'remove the item, mark it within items
3044 IF TIME<100 THEN 3044

3180 TIME=0:I=0:CMD PLYSOUND 12
3190 GOSUB 1000 ' TELEPORT
3200 PUT SPRITE 0,,0
3201 T$="TELEPORTED TO SHYRE[[[#MYSTERIES AWAIT[      ":TY=7:GOSUB 1290

3250 CMD WRTSCR 0
3251 T$="SOME TIME LATER[[[":TY=7:GOSUB 1290

3300 'Storm, take shelter
3301 CMD WRTSCR 46
3323 X=88:Y=144:BS=26
3324 TIME=0:PUT SPRITE 1,(X,Y),5,BS:PUT SPRITE 2,(X,Y),15,BS+1:PUT SPRITE 3,(X,Y),1,BS+2
3325 T$="A ELECTRIC STORM#IS COMING[#TAKING SHELTER#ON LARGE RUINS[":TY=7:GOSUB 1300
3326 IF STRIG(0) OR STRIG(1) GOTO 3326

3328 ON STRIG GOSUB 3334, 3334
3329 STRIG(0) ON: STRIG(1) ON

3330 FY=-16:GOSUB 3900
3331 STRIG(0) OFF: STRIG(1) OFF
3333 GOTO 3810

3334 RETURN 3331

3810 PUT SPRITE 0,(0,-17):PUT SPRITE 1,(0,-17):PUT SPRITE 2,(0,-17):PUT SPRITE 3,(0,-17):CMD WRTSCR 0
3899 RETURN 250

3900 'BS=3'1*6-3
3910 Y=Y-2:TIME=0
3911 WS=(WS+1) MOD 8:WT=WS\2:IF WT=2 OR WT=0 THEN CS=6 ELSE IF WT=1 THEN CS=0 ELSE CS=3
3912 IF WS=1 THEN CMD PLYSOUND 6
3913 CS=2+CS
3914 PUT SPRITE 1,(X,Y),5,CS:PUT SPRITE 2,(X,Y),15,CS+1:PUT SPRITE 3,(X,Y),1,CS+2
3915 IF TIME<2 THEN 3915 ELSE IF Y>FY THEN 3910
3921 PUT SPRITE 1,,,26:PUT SPRITE 2,,,27:PUT SPRITE 3,,,28
3922 RETURN

