10 ' --- Slot 0
20 ' color 1
30 DATA 00,7F,7F,00,6D,6D,6D,6C,6D,6B,67,6E,6D,00,7F,7F
40 DATA 00,FF,FF,00,DB,BB,73,EB,DB,9B,5B,DB,DB,00,FF,FF
50 ' 
60 ' --- Slot 1
70 ' color 1
80 DATA 00,07,1F,33,73,7F,FF,FF,FF,FF,FF,7F,7F,3F,1F,07
90 DATA 00,C0,F0,98,9C,FC,FE,FE,FE,FE,FE,FC,FC,F8,F0,C0
100 ' 
110 ' --- Slot 2
120 ' color 1
130 DATA 00,07,1F,3F,7F,7F,FF,FF,FF,FF,FF,7F,7F,3F,1F,07
140 DATA 00,C0,F0,F8,FC,E4,E6,FE,FE,FE,E6,E4,FC,F8,F0,C0
150 ' 
160 ' --- Slot 3
170 ' color 1
180 DATA 00,07,1F,3F,7F,7F,FF,FF,FF,FF,FF,7F,73,33,1F,07
190 DATA 00,C0,F0,F8,FC,FC,FE,FE,FE,FE,FE,FC,9C,98,F0,C0
200 ' 
210 ' --- Slot 4
220 ' color 1
230 DATA 00,07,1F,3F,7F,4F,CF,FF,FF,FF,CF,4F,7F,3F,1F,07
240 DATA 00,C0,F0,F8,FC,FC,FE,FE,FE,FE,FE,FC,FC,F8,F0,C0

241 ' --- Slot 0 Down
242 DATA 00,00,07,0F,08,3F,D0,DF,8F,CF,67,97,93,50,02,01
243 DATA 00,00,C0,E0,20,F8,16,F6,E2,E6,CC,D2,92,14,80,00
244 ' --- Slot 1 Right
245 DATA 00,00,07,0F,0F,3F,DF,DF,8F,CF,67,97,93,50,02,01
246 DATA 00,00,C0,E0,20,F0,10,F0,E0,E0,C0,C0,80,00,80,00
247 ' --- Slot 2 Up
248 DATA 00,00,07,0F,0F,3F,DF,DF,8F,CF,67,97,93,50,02,01
249 DATA 00,00,C0,E0,E0,F8,F6,F6,E2,E6,CC,D2,92,14,80,00
250 ' --- Slot 3 Left
251 DATA 00,00,07,0F,09,1F,11,1F,0F,0F,07,07,03,00,02,01
252 DATA 00,00,C0,E0,E0,F8,F6,F6,E2,E6,CC,D2,92,14,80,00

260 COLOR 15,1,1:SCREEN 2,2,0
261 BLOAD "shyre.sc2",S

INCLUDE "rooms.inc"

264 DEFINT A-Z
265 'CALL TURBO ON
266 DIM TL(767)
268 GOSUB 10000

269 'proper starting place is RR=4:RC=2:RH=0
270 RR=0:RC=0:RH=0
271 GOSUB 900

280 X=88:Y=160:GS=1:MD=1:ES=1

300 TIME=0
301 ON GS GOSUB 400,500,600,600 ' Game States 3 and 4 are pushign and sliding, they are the same except the character doesn't move

310 ' ENEMY MOVES
311 GOSUB 700

350 PUT SPRITE 0,(X,Y),5,CS:PUT SPRITE 1,(X,Y),15,CS+1
390 IF TIME<4 THEN 390
399 GOTO 300

400 'IDLE
401 PT=&H1800+X\8+(Y\8)*32:PP=0
402 ON STICK(0) GOTO 410,499,430,499,450,499,470,499
403 GOTO 499

410 MD=1:BS=9
411 T1=VPEEK(PT-32):T2=VPEEK(PT-31)
412 IF T1=224 OR T1=226 THEN GOTO 420
413 IF T1=9 AND T2=9 THEN RR=RR-1:Y=176: GOSUB 750
414 IF T1=113 THEN PT=PT-64:GOSUB 770
419 GOTO 490
420 IF VPEEK(PT-96)<64 AND VPEEK(PT-95)<64 THEN GS=3:MS=8:PUT SPRITE 2,(X,Y-17),9,0:PP=PT-64:PF=PP-32:CS=9
429 GOTO 490

430 MD=2:BS=15
431 T1=VPEEK(PT+2):T2=VPEEK(PT+34)
432 IF T1=192 OR T1=194 THEN GOTO 440
433 IF T1=8 AND T2=8 THEN RC=RC+1:X=0: GOSUB 750
434 IF T1=81 THEN PT=PT+2:GOSUB 770
439 GOTO 490
440 IF VPEEK(PT+4)<64 AND VPEEK(PT+36)<64 THEN GS=3:MS=8:PUT SPRITE 2,(X+16,Y-1),9,0:PP=PT+2:PF=PP+1:CS=15
449 GOTO 490

450 MD=3:BS=21
451 T1=VPEEK(PT+64):T2=VPEEK(PT+65)
452 IF T1=192 OR T1=194 THEN GOTO 460
453 IF T1=7 AND T2=7 THEN RR=RR+1:Y=0: GOSUB 750
454 IF T1=81 THEN PT=PT+64:GOSUB 770
459 GOTO 490
460 IF VPEEK(PT+128)<64 AND VPEEK(PT+129)<64 THEN GS=3:MS=8:PUT SPRITE 2,(X,Y+15),9,0:PP=PT+64:PF=PP+32:CS=21
469 GOTO 490

470 MD=4:BS=27
471 T1=VPEEK(PT-1):T2=VPEEK(PT+31)
472 IF T1=193 OR T1=195 THEN GOTO 480
473 IF T1=10 AND T2=10 THEN RC=RC-1:X=176: GOSUB 750
474 IF T1=82 THEN PT=PT-2:GOSUB 770
479 GOTO 490
480 IF VPEEK(PT-3)<64 AND VPEEK(PT+29)<64 THEN GS=3:MS=8:PUT SPRITE 2,(X-16,Y-1),9,0:PP=PT-2:PF=PP-1:CS=27
489 GOTO 490

490 ' Other checks
495 IF T1<128 AND T2<128 THEN GS=2:MS=4:GOSUB 500
496 IF PP>0 THEN VPOKE PP,TL(PP-&H1800):VPOKE PP+1,TL(PP+1-&H1800):VPOKE PP+32,TL(PP+32-&H1800):VPOKE PP+33,TL(PP+33-&H1800)
499 RETURN

500 'MOVING
501 ON MD GOTO 510,520,530,540
510 Y=Y-2:GOTO 550
520 X=X+2:GOTO 550
530 Y=Y+2:GOTO 550
540 X=X-2:GOTO 550
550 MS=MS-1:IF MS=0 THEN GS=1: GOSUB 580
560 I=(MS) MOD 4:IF I=2 THEN CS=0 ELSE IF I=3 THEN CS=4 ELSE CS=I*2' TODO: This does not look needed anymore
570 CS=BS+CS
579 RETURN

580 'Stair and items checks at end of moving
581 PT=&H1800+X\8+(Y\8)*32:PP=0
582 T1=VPEEK(PT)
583 IF T1=64 THEN RH=RH+1:GOSUB 750
584 IF T1=66 THEN RH=RH-1:GOSUB 750
585 IF T1=86 THEN I1=1:GOSUB 780
586 IF T1=88 THEN I2=1:GOSUB 780
587 IF T1=90 THEN MP=1:GOSUB 780
599 RETURN

600 'PUSHING
601 ON MD GOTO 610,620,630,640
610 Y=Y-1
611 PUT SPRITE 2,(X,Y-17),9,0
612 GOTO 650
620 X=X+1
621 PUT SPRITE 2,(X+16,Y-1),9,0
622 GOTO 650
630 Y=Y+1
631 PUT SPRITE 2,(X,Y+15),9,0
632 GOTO 650
640 X=X-1
641 PUT SPRITE 2,(X-16,Y-1),9,0
642 GOTO 650

650 MS=MS-1' TODO USE MOD instead?
651 IF MS>0 THEN RETURN
652 GS=1
653 IF TL(PF-&H1800)>=12 AND TL(PF-&H1800)<=15 AND TL(PF+1-&H1800)>=12 AND TL(PF+1-&H1800)<=15 AND TL(PF+32-&H1800)>=12 AND TL(PF+32-&H1800)<=15 AND TL(PF+33-&H1800)>=12 AND TL(PF+33-&H1800)<=15 GOSUB 675 'Icy floor
654 VPOKE PF,192:VPOKE PF+1,193:VPOKE PF+32,224:VPOKE PF+33,225:PUT SPRITE 2,(0,0),0,0
655 IF TL(PF-&H1800)=18 THEN GOSUB 660 'Open door
656 IF TL(PP-&H1800)=18 THEN GOSUB 670 'Close door
659 RETURN

660 FOR I=0 TO 767
661   IF TL(I)=144 THEN VPOKE &H1800+I,16:VPOKE &H1800+I+1,17:VPOKE &H1800+I+32,48:VPOKE &H1800+I+33,49:RETURN
662 NEXT I
669 RETURN

670 FOR I=0 TO 767
671   IF TL(I)=144 THEN VPOKE &H1800+I,144:VPOKE &H1800+I+1,145:VPOKE &H1800+I+32,176:VPOKE &H1800+I+33,177:RETURN
672 NEXT I
674 RETURN

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

686 IF T1>=12 AND T1<=15 AND T2>=12 AND T2<=15 THEN PP=PT:GOTO 690
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


700 ' ENEMY MOVES
701 ON ES GOSUB 709, 800
702 PUT SPRITE 3,(EX,EY-1),4,ED+4
703 RETURN

709 ON ED GOTO 710,720,730,740

710 'DOWN (TODO ALIGN TILES WITH THE JOYSTICK DIRECTIONS FOR CLARITY)
711 EY=EY+1: IF (EY MOD 8) = 0 THEN ES=2:RETURN ELSE RETURN
720 EX=EX+1: IF (EX MOD 8) = 0 THEN ES=2:RETURN ELSE RETURN
730 EY=EY-1: IF (EY MOD 8) = 0 THEN ES=2:RETURN ELSE RETURN
740 EX=EX-1: IF (EX MOD 8) = 0 THEN ES=2:RETURN ELSE RETURN

750 'load room and checks
752 GOSUB 900 'Enemy checks
753 GOSUB 790 'Redraw items
759 RETURN

760 ' Use Key if have it
770 IF I1=1 THEN VPOKE PT,17:VPOKE PT+1,18:VPOKE PT+32,49:VPOKE PT+33,50
779 RETURN

780 ' Pick up items
781 VPOKE PT,0:VPOKE PT+1,0:VPOKE PT+32,0:VPOKE PT+33,0
788 GOSUB 790
789 RETURN

790 ' Redraw item space (to be reused when loading rooms and when picking up items)
791 IF MP=1 THEN VPOKE &H1860+27, 90:VPOKE &H1860+28, 91: VPOKE &H1860+59, 122:VPOKE &H1860+60, 123
792 IF I1=1 THEN VPOKE &H1860+25, 86:VPOKE &H1860+26, 87: VPOKE &H1860+57, 118:VPOKE &H1860+58, 119
793 IF I2=1 THEN VPOKE &H1860+29, 88:VPOKE &H1860+30, 89: VPOKE &H1860+61, 120:VPOKE &H1860+62, 121
799 RETURN

800 'Check for turns
801 ET=&H1800+EX\8+(EY\8)*32
802 E0=VPEEK(ET)

809 ON ED GOTO 810,820,830,840

810 T1=ET+64:T2=T1+1
819 GOTO 850

820 IF E0=5 THEN ED=1:RETURN
821 T1=ET+2:T2=T1+32
829 GOTO 850

830 IF E0=5 THEN ED=4:RETURN
831 T1=ET-32:T2=T1+1
839 GOTO 850

840 IF E0=4 THEN ED=1:RETURN
841 T1=ET-1:T2=T1+32
849 GOTO 850
 
850 E1=VPEEK(T1):E2=VPEEK(T2)
860 IF E1>=64 OR E2>=64 THEN ED=((ED+2) MOD 4) ELSE ES=1
870 IF ED=0 THEN ED=4
880 RETURN

900 'Explore room, remember floor type, find enemy spawn points (TILES 7-10) and remove collected items
901 IF RH=0 THEN CR=1+RR*5+RC ELSE CR=26+(RR-1)*3+RC-1
902 CMD WRTSCR CR
910 FOR I=0 TO 767
920   T=VPEEK(&H1800+I)
930   IF T<192 THEN TL(I)=T ELSE TL(I)=T-192
940   IF T>=7 AND T<=10 THEN EY=(I/32)*8:EX=((I MOD 32)-1)*8:ED=T-6:EM=8
941   IF MP=1 AND (T=90 OR T=91 OR T=122 OR T=123) THEN VPOKE &H1800+I,0
942   IF I1=1 AND (T=86 OR T=87 OR T=118 OR T=119) THEN VPOKE &H1800+I,0 ' Can check for the first item and then do 4 pokes (or a subroutine to clean)
943   IF I2=1 AND (T=88 OR T=89 OR T=120 OR T=121) THEN VPOKE &H1800+I,0
950 NEXT I
960 RETURN


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

