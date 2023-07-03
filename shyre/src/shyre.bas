200 COLOR 15,1,1:SCREEN 2,2,0
201 BLOAD "intro.sc2",S' TODO: This should load just the tiles

FILE "cls.scr.plet5"

INCLUDE "rooms.inc"

204 DEFINT A-Z
206 DIM TL(767)

210 GOSUB 2000 'Platty Intro

250 BLOAD "shyre.sc2",S' TODO: This should load just the tiles
251 GOSUB 10000 'Load Sprites

269 'proper starting place is RR=4:RC=2:RH=0
270 'RR=2:RC=3:RH=1:I1=1:I5=1
271 RR=4:RC=2:RH=0
272 GOSUB 900

280 X=88:Y=160:GS=1:MD=1:CS=14

300 TIME=0' BEGIN GAME LOOP
301 ON GS GOSUB 400,500,600

350 PUT SPRITE 0,(X,Y),5,CS:PUT SPRITE 1,(X,Y),15,CS+1

390 IF TIME<4 THEN 390
399 GOTO 300 ' END GAME LOOP

400 'GS=1: IDLE, can transition into moving (GS=2) or pushing (GS=3)
401 PT=&H1800+X\8+(Y\8)*32:PP=0
402 ON STICK(SS) GOTO 410,499,430,499,450,499,470,499
403 GOTO 499

410 MD=1:BS=2
411 T1=VPEEK(PT-32):T2=VPEEK(PT-31)
412 IF T1=224 THEN PS=0:PC=9:GOTO 420
413 IF T1=226 AND I4=1 THEN PS=1:PC=6:GOTO 420
414 IF T1=60 AND T2=60 THEN RR=RR-1:Y=176:GS=2:MS=4:GOSUB 740
416 IF T1=178 AND I1=1 THEN PT=PT-64:NT=10:GOSUB 760
417 IF T1=182 AND I5=1 THEN PT=PT-64:NT=70:GOSUB 765
419 GOTO 490
420 IF VPEEK(PT-96)<60 AND VPEEK(PT-95)<60 THEN GS=3:MS=8:PUT SPRITE 2,(X,Y-17),PC,PS:PP=PT-64:PF=PP-32:CS=2' This should exit via another route, not 490
429 GOTO 490

430 MD=2:BS=8
431 T1=VPEEK(PT+2):T2=VPEEK(PT+34)
432 IF T1=192 THEN PS=0:PC=9:GOTO 440
433 IF T1=194 AND I4=1 THEN PS=1:PC=6:GOTO 440
434 IF T1=61 AND T2=61 THEN RC=RC+1:X=0:GS=2:MS=4:GOSUB 740
436 IF T1=146 AND I1=1 THEN PT=PT+2:NT=10:GOSUB 760
437 IF T1=150 AND I5=1 THEN PT=PT+2:NT=70:GOSUB 765
439 GOTO 490
440 IF VPEEK(PT+4)<60 AND VPEEK(PT+36)<60 THEN GS=3:MS=8:PUT SPRITE 2,(X+16,Y-1),PC,PS:PP=PT+2:PF=PP+1:CS=8' This should exit via another route, not 490
449 GOTO 490

450 MD=3:BS=14
451 T1=VPEEK(PT+64):T2=VPEEK(PT+65)
452 IF T1=192 THEN PS=0:PC=9:GOTO 460
453 IF T1=194 AND I4=1 THEN PS=1:PC=6:GOTO 460
454 IF T1=62 AND T2=62 THEN RR=RR+1:Y=0:GS=2:MS=4:GOSUB 740
456 IF T1=146 AND I1=1 THEN PT=PT+64:NT=10:GOSUB 760
457 IF T1=150 AND I5=1 THEN PT=PT+64:NT=70:GOSUB 765
459 GOTO 490
460 IF VPEEK(PT+128)<60 AND VPEEK(PT+129)<60 THEN GS=3:MS=8:PUT SPRITE 2,(X,Y+15),PC,PS:PP=PT+64:PF=PP+32:CS=14' This should exit via another route, not 490
469 GOTO 490

470 MD=4:BS=20
471 T1=VPEEK(PT-1):T2=VPEEK(PT+31)
472 IF T1=193 THEN PS=0:PC=9:GOTO 480
473 IF T1=195 AND I4=1 THEN PS=1:PC=6:GOTO 480
474 IF T1=63 AND T2=63 THEN RC=RC-1:X=176:GS=2:MS=4:GOSUB 740
476 IF T1=147 AND I1=1 THEN PT=PT-2:NT=10:GOSUB 760
477 IF T1=151 AND I5=1 THEN PT=PT-2:NT=70:GOSUB 765
479 GOTO 490
480 IF VPEEK(PT-3)<60 AND VPEEK(PT+29)<60 THEN GS=3:MS=8:PUT SPRITE 2,(X-16,Y-1),PC,PS:PP=PT-2:PF=PP-1:CS=20' This should exit via another route, not 490
489 GOTO 490

490 ' Other checks
491 TT=VPEEK(PT)
495 IF T1<128 AND T2<128 THEN GS=2:MS=4:GOSUB 500
496 IF PP>0 THEN VPOKE PP,TL(PP-&H1800):VPOKE PP+1,TL(PP+1-&H1800):VPOKE PP+32,TL(PP+32-&H1800):VPOKE PP+33,TL(PP+33-&H1800)
499 RETURN


500 'GS=2: MOVING, there is no user input. Check for picking up items once moving is completed
501 ON MD GOTO 510,520,530,540
510 Y=Y-2:GOTO 550
520 X=X+2:GOTO 550
530 Y=Y+2:GOTO 550
540 X=X-2:GOTO 550
550 MS=MS-1:IF MS<=0 THEN GS=1:GOSUB 580
560 I=(MS) MOD 4:IF I=2 THEN CS=0 ELSE IF I=3 THEN CS=4 ELSE CS=I*2' TODO: does not look this is needed anymore
570 CS=BS+CS
579 RETURN

580 'Stair and items checks at end of moving
581 PT=&H1800+X\8+(Y\8)*32:PP=0
582 T1=VPEEK(PT):T2=VPEEK(PT+1):T3=VPEEK(PT+32):T4=VPEEK(PT+33)
583 IF T1=64 THEN RH=RH+1:GOSUB 740
584 IF T1=66 THEN RH=RH-1:GOSUB 740
585 IF T1=86 THEN I1=1:GOSUB 780
586 IF T1=88 AND I2=0 THEN I2=1:GOSUB 780
587 IF T1=90 THEN MP=1:GOSUB 780
588 IF T1=92 THEN I4=1:GOSUB 780
589 IF T1=84 THEN I5=1:GOSUB 780
590 IF T1=74 THEN GOSUB 410:RETURN 'Up tile
591 IF T1=76 THEN GOSUB 430:RETURN 'Right tile
592 IF T1=78 THEN GOSUB 450:RETURN 'Up tile
593 IF T1=80 THEN GOSUB 470:RETURN 'Right tile
594 IF T1=39 OR T2=39 OR T3=39 OR T4=39 THEN GOSUB 1100 'Death by laser, reset room
595 IF T1=26 THEN GOTO 1200 'Game Finished!
596 IF T1=94 AND I2=1 THEN I2=2:GOSUB 820'batteries in place, swap colors
599 RETURN


600 'GS=3: PUSHING, check for events at the end of pushing (sliding, floor switches)
601 ON MD GOTO 610,620,630,640
610 Y=Y-1
611 PUT SPRITE 2,(X,Y-17)
612 GOTO 650
620 X=X+1
621 PUT SPRITE 2,(X+16,Y-1)
622 GOTO 650
630 Y=Y+1
631 PUT SPRITE 2,(X,Y+15)
632 GOTO 650
640 X=X-1
641 PUT SPRITE 2,(X-16,Y-1)
642 GOTO 650

650 MS=MS-1' TODO USE MOD instead?
651 IF MS>0 THEN RETURN
652 GS=1:TT=TL(PF-&H1800)' Test Tile (Where the crate stands now)
653 IF TT>=28 AND TT<=31 AND TL(PF+1-&H1800)>=28 AND TL(PF+1-&H1800)<=31 AND TL(PF+32-&H1800)>=28 AND TL(PF+32-&H1800)<=31 AND TL(PF+33-&H1800)>=28 AND TL(PF+33-&H1800)<=31 GOSUB 675 'Icy floor

654 GOTO 700' LASER HANDLING

660 PT=PF:NT=192+2*PS:GOSUB 765:PUT SPRITE 2,(0,0),0,0
661 IF TT=18 THEN CT=144:NT=16:GOSUB 670 'Open magenta door
662 IF TL(PP-&H1800)=18 THEN CT=16:NT=144:GOSUB 670 'Close magenta door
663 IF TT=22 THEN CT=148:NT=20:GOSUB 670 'Open cyan door
664 IF TL(PP-&H1800)=22 THEN CT=20:NT=148:GOSUB 670 'Close cyan door

669 RETURN


670 FOR I=0 TO 767
671   IF TL(I)=CT THEN PT=&H1800+I:GOSUB 760:RETURN
672 NEXT I
673 RETURN

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

690 FOR I=1 TO 4' Why is this 4 and not 8?? Where is the reentrant code?
691  ON MD GOTO 692,693,694,695
692  CY=CY-1:GOTO 696
693  CX=CX+1:GOTO 696
694  CY=CY+1:GOTO 696
695  CX=CX-1:GOTO 696
696  PUT SPRITE 2,(CX,CY),9,0
697  IF TIME<1 GOTO 697 ELSE TIME=0
698 NEXT
699 GOTO 681

700 'LASER HANDLING
701 IF MD=4 AND TT=39 THEN VPOKE PF,0:TL(PF-&H1800)=0
702 IF MD=4 AND TL(PF-&H1800+32)=39 THEN VPOKE PF+32,0:TL(PF-&H1800+32)=0
703 IF MD=1 AND (VPEEK(PF+63)=39 OR VPEEK(PF+63)=238) THEN OT=0:NT=39:IT=PF+64:GOSUB 800:GOSUB 1100:GOTO 669' Lasers are back (to the right) and we die
704 IF MD=3 AND (VPEEK(PF-33)=39 OR VPEEK(PF-33)=238) THEN OT=0:NT=39:IT=PF-32:GOSUB 800:GOSUB 1100:GOTO 669' Lasers are back (to the right) and we die
705 IF MD=1 AND TT=39 THEN OT=39:NT=0:IT=PF:GOSUB 800
706 IF MD=3 AND TL(PF-&H1800+32)=39 THEN OT=39:NT=0:IT=PF+32:GOSUB 800

739 GOTO 660' TODO Better to make space for this in line 660 without a GOTO

740 IX=X:IY=Y:ID=MD:IG=GS:IM=MS:IS=CS:IB=BS
750 'load room and checks
751 PUT SPRITE 0,,0,0:PUT SPRITE 1,,0
752 GOSUB 900 'Load room and check items
753 GOSUB 790 'Redraw items
759 RETURN


760 ' Replace 4 tiles starting at PT (previous tile) with tiles from NT (new tile)
761 II=PT-&H1800:TL(II)=NT:TL(II+1)=NT+1:TL(II+32)=NT+32:TL(II+33)=NT+33
765 VPOKE PT,NT:VPOKE PT+1,NT+1:VPOKE PT+32,NT+32:VPOKE PT+33,NT+33
769 RETURN

780 ' Pick up items
781 NT=0:GOSUB 760:GOSUB 790
789 RETURN

790 ' Redraw item space (to be reused when loading rooms and when picking up items)
791 IF MP=1 THEN PT=&H1860+27:NT=90:GOSUB 765
792 IF I1=1 THEN PT=&H1860+25:NT=86:GOSUB 765
793 IF I2=1 THEN PT=&H1860+29:NT=88:GOSUB 765
794 IF I4=1 THEN PT=&H18C0+27:NT=92:GOSUB 765
795 IF I5=1 THEN PT=&H18C0+25:NT=84:GOSUB 765
799 RETURN

800 'Delete all OT with NT starting at IT moving right
801 IF VPEEK(IT)<>OT THEN RETURN ELSE VPOKE IT,NT:TL(IT-&H1800)=NT:IT=IT+1:GOTO 801

820 ' Putting batteries in place
821 PT=&H1860+29:NT=0:GOSUB 765 'delete them from items
822 CT=94:NT=88:GOSUB 670 'Draw batteries in place
823 CT=24:NT=26:GOSUB 670 'Swap ending tile
829 RETURN

900 'Explore room, remember floor type and remove collected items
901 IF RH=0 THEN CR=2+RR*5+RC ELSE IF RH=1 THEN CR=27+(RR-1)*3+RC-1 ELSE CR=36
902 CMD WRTSCR CR
910 FOR I=0 TO 767
920   T=VPEEK(&H1800+I)
930   IF T<192 THEN TL(I)=T ELSE TL(I)=T-192
941   IF MP=1 AND T=90 THEN PT=&H1800+I:NT=0:GOSUB 760
942   IF I1=1 AND T=86 THEN PT=&H1800+I:NT=0:GOSUB 760
943   IF I2>0 AND T=88 THEN PT=&H1800+I:NT=0:GOSUB 760
944   IF I4=1 AND T=92 THEN PT=&H1800+I:NT=0:GOSUB 760
945   IF I2=2 AND T=94 THEN PT=&H1800+I:NT=88:GOSUB 760
946   IF I2=2 AND T=24 THEN PT=&H1800+I:NT=26:GOSUB 760
950 NEXT I
960 RETURN

1100 PUT SPRITE 1,,8:PUT SPRITE 2,,0,0:TIME=0
1110 IF TIME<20 GOTO 1110
1111 X=IX:Y=IY:GS=IG:MD=ID:CS=14:MS=IM:CS=IS:BS=IB'Remember starting position on a room
1120 GOSUB 750
1130 RETURN 300

1200 ' Ending
1210 'TODO: Load a victory screen
1220 'Wait for press space
1299 END 'GOTO BACK TO TITLE


2000 ' Platty Soft Intro
2001 BLOAD "intro.sc2",S
2002 'CLS
2010 STRIG(0) ON: STRIG(1) ON
2020 ON STRIG GOSUB 2700, 2700

2100 'Prepare the initial position
2110 FOR I=0 to 3
2120  FOR K=0 TO 3
2121   VPOKE &H1800+262+I+K*32,152+I*32+K
2122  NEXT K
2123 NEXT I

2300 ' Scroll up 32 times (push everything up and add a line at the bottom on the 4 tiles)
2310 FOR I=0 TO 31
2311 TIME=0
2312  FOR J=1 TO 31
2313   FOR K=0 TO &H300 STEP &H100
2320    VP = VPEEK(&HCC0+J+K)
2321    VPOKE &HCBF+J+K, VP
2322    VP = VPEEK(&H2CC0+J+K)
2323    VPOKE &H2CBF+J+K, VP
2347   NEXT K
2348  NEXT J
2350  FOR K=0 TO &H300 STEP &H100
2351   VP=VPEEK(&H4E0+I+K)
2352   VPOKE &HCDF+K, VP
2353   VP=VPEEK(&H2CE0+I+K)
2354   VPOKE &H2CDF+K, VP
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

2800 'Shyre new game screen
2810 BLOAD "start.sc2",S ' Should be just a map file
2820 IF STRIG(0) THEN SS=0:RETURN 250
2821 IF STRIG(1) THEN SS=1:RETURN 250
2830 GOTO 2820

5001 ' --- Basic crate
5003 DATA 00,7F,7F,00,6D,6D,6D,6C,6D,6B,67,6E,6D,00,7F,7F
5004 DATA 00,FF,FF,00,DB,BB,73,EB,DB,9B,5B,DB,DB,00,FF,FF
5005 '
5006 ' --- Heavy crate
5008 DATA 00,4D,4D,00,26,26,26,26,4D,4D,00,26,26,26,4D,4D
5009 DATA 00,FE,FE,00,FC,FC,FC,FC,FE,FE,00,FC,FC,FC,FE,FE
5010 DATA 00,00,00,00,80,80,80,00,00,00,1F,1F,1F,00,00,00
5020 DATA 00,00,00,00,02,02,02,00,00,00,F0,F0,F0,00,00,00
5030 DATA 00,1F,3F,7F,7F,3F,4F,70,3F,1F,60,C0,C0,D3,1E,1E
5040 DATA 00,F0,F8,FC,FC,F8,E4,1C,F8,F0,0C,06,06,96,F0,F0
5050 DATA 00,00,00,80,80,80,00,00,00,1F,1F,1F,00,00,00,00
5060 DATA 00,00,00,02,02,02,00,00,00,F0,F0,F0,00,00,00,00
5070 DATA 1F,3F,7F,7F,3F,4F,70,3F,1F,60,C0,C0,D3,1E,1E,00
5080 DATA F0,F8,FC,FC,F8,E4,1C,F8,F0,0C,06,06,90,F0,F0,F0
5090 DATA 00,00,00,80,80,80,00,00,00,1F,1F,1F,00,00,00,00
5100 DATA 00,00,00,02,02,02,00,00,00,F0,F0,F0,00,00,00,00
5110 DATA 1F,3F,7F,7F,3F,4F,70,3F,1F,60,C0,C0,13,1E,1E,1E
5120 DATA F0,F8,FC,FC,F8,E4,1C,F8,F0,0C,06,06,96,F0,F0,00
5200 ' --- Looking Right
5210 DATA 00,00,02,65,6A,64,00,00,00,0F,0E,0E,00,04,04,03
5220 DATA 00,00,80,00,04,08,10,00,00,E0,E0,E0,00,00,00,80
5230 DATA 3F,7F,F8,90,90,90,F8,7F,1E,00,01,01,03,03,03,00
5240 DATA F8,FC,06,02,02,02,66,FC,18,00,00,00,C0,C0,80,00
5250 DATA 00,00,00,02,65,6A,64,00,00,00,0F,01,0F,00,20,20
5260 DATA 00,00,00,80,00,04,08,10,00,00,E0,E0,E0,00,00,38
5270 DATA 00,3F,7F,F8,90,90,90,F8,7F,1E,00,1E,20,0E,1C,18
5280 DATA 00,F0,FC,06,02,02,02,66,FC,18,00,00,18,E0,70,00
5290 DATA 00,00,00,02,65,6A,64,00,00,00,0F,0F,0F,00,20,20
5300 DATA 00,00,00,80,00,04,08,10,00,00,E0,00,E0,00,00,38
5310 DATA 00,3F,7F,F8,90,90,90,F8,7F,1E,00,10,20,0E,1C,18
5320 DATA 00,F8,FC,06,02,02,02,66,FC,18,00,E0,18,E0,70,00
5400 ' Looking down
5410 DATA 00,00,00,0A,94,A8,90,00,00,00,1F,1F,1F,00,00,0C
5420 DATA 00,00,00,00,02,0A,12,20,00,00,F0,F0,F0,00,00,60
5430 DATA 00,1F,3F,60,40,40,40,63,3F,10,60,C0,C0,D3,1E,12
5440 DATA 00,F0,F8,0C,04,04,04,8C,F8,10,0C,06,06,96,F0,90
5450 DATA 00,00,0A,94,A8,90,00,00,00,1F,1F,1F,00,00,00,0C
5460 DATA 00,00,00,02,0A,12,20,00,00,F0,F0,F0,00,00,60,00
5470 DATA 1F,3F,60,40,40,40,63,3F,10,60,C0,C0,13,1E,1E,12
5480 DATA F0,F8,0C,04,04,04,8C,F8,10,0C,06,06,96,F0,90,00
5490 DATA 00,00,0A,94,A8,90,00,00,00,1F,1F,1F,00,00,0C,00
5500 DATA 00,00,00,02,0A,12,20,00,00,F0,F0,F0,00,00,00,60
5510 DATA 1F,3F,60,40,40,40,63,3F,10,60,C0,C0,D3,1E,12,00
5520 DATA F0,F8,0C,04,04,04,8C,F8,10,0C,06,06,90,F0,F0,90
5600 'Looking left
5610 DATA 00,00,02,01,40,20,10,00,00,0F,0E,0E,00,00,00,03
5620 DATA 00,00,80,4C,AC,4C,00,00,00,E0,E0,E0,00,40,40,80
5630 DATA 3F,7F,C0,80,80,80,CC,7F,30,00,01,01,07,07,03,00
5640 DATA F8,FC,3E,12,12,12,3E,FC,F0,00,00,00,80,80,80,00
5650 DATA 00,00,00,02,01,40,20,10,00,00,0F,0F,0F,00,00,38
5660 DATA 00,00,00,80,4C,AC,4C,00,00,00,E0,00,E0,00,08,08
5670 DATA 00,1F,7F,C0,80,80,80,CC,7F,30,00,00,30,0E,1C,00
5680 DATA 00,F8,FC,3E,12,12,12,3E,FC,F0,00,F0,08,E0,70,30
5690 DATA 00,00,00,02,01,40,20,10,00,00,0F,01,0F,00,00,38
5700 DATA 00,00,00,80,4C,AC,4C,00,00,00,E0,E0,E0,00,08,08
5710 DATA 00,3F,7F,C0,80,80,80,CC,7F,30,00,0E,30,0E,1C,00
5720 DATA 00,F8,FC,3E,12,12,12,3E,FC,F0,00,10,08,E0,70,30

5999 DATA *

10000 REM -- LOAD SPRITES
10010 S=&H3800
10020 READ R$: IF R$="*" THEN RETURN ELSE VPOKE S,VAL("&H"+R$):S=S+1:GOTO 10020

