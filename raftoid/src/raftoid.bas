10 DEFINT A-Z
11 DIM BB(144)
12 DIM LN$(10)

13 PUT SPRITE 1,,0: PUT SPRITE 2,,0: 

14 GOSUB 900

20 L=1:sc=0:sd=0:pl=2:nl=5

30 GOTO 811

40 call turbo on(NB, PL, L, SC, SD, NL, BB())
41 'DIM BB(141)
42 DEFINT A-Z
43 DEFSNG X

49 K=1
50 FOR J=&H1820 TO &H19A0 STEP &H20
51   FOR I=1 TO 21 STEP 2
53     C=BB(K):K=K+1
54     IF C>0 THEN VPOKE j+i,c*2+8:VPOKE j+i+1,c*2+9: IF C<>9 THEN NB=NB+1
60   NEXT I
61 NEXT J

71 PR=RND(-TIME):BX!=102:BY!=172:VX!=0.5:VY!=-2
72 x=86:ax!=0
73 px=0:py=0:pc=0:pb=15
74 pm=0:ba=BX!-x

100 ' GAME LOOP
100 TIME=0
110 s=stick(0)
111 if s=3 then ax!=ax!+0.5
112 if s=7 then ax!=ax!-0.5
113 s=stick(1)
114 if s=3 then ax!=ax!+0.5
115 if s=7 then ax!=ax!-0.5
116 if strig(0)=-1 then ba=0
117 if strig(1)=-1 then ba=0
120 if pc=0 goto 130
121 py=py+1
122 if py>184 THEN py=0:pc=0:px=200
123 if py>172 AND py<184 AND px>x-15 AND px<x+32 THEN GOSUB 550
130 x=x+ax!
131 ax!=ax!*0.9
132 if x<8 then x=8:ax!=0
133 if x>152 then x=152:ax!=0
139 if ba>0 then BX!=ba+x:GOTO 360
140 BY!=BY!+VY!
150 BX!=BX!+VX!
300 if BX!>178 THEN BX!=178:VX!=-VX!
310 if BX!<8 THEN BX!=8:VX!=-VX!
321 if BY!>184 goto 600
330 if BY!<8 THEN BY!=8: VY!=-VY!
340 if BY!>170 AND BY!<180 AND BX!>x-7 AND BX!<x+32 THEN GOSUB 500
360 ' Drawing step
361 put sprite 4,(BX!,BY!),pb,0
362 put sprite 1,(x,170),15,1
363 put sprite 2,(x+16,170),15,2
364 put sprite 3,(px,py),pc,3
366 put sprite 5,(xb,yb),cb,bb+4
367 if bb=10 then cb=0 else bb=bb+1
400 ' BOUNDING BOX COLISION DETECTION
410 if VX!>0 THEN sa=(BX!+6-8)\16 ELSE sa=(BX!-1-8)\16
411 sb=(BY!+3)\8
412 v=VPEEK(&H1800+sa*2+1+sb*32)
413 if v>9 AND v<48 THEN VX!=-VX!:GOSUB 650
415 if VY!>0 THEN sb=(BY!+6)\8 ELSE sb=(BY!-1)\8
416 sa=(BX!+3-8)\16
420 v=VPEEK(&H1800+sa*2+1+sb*32)
421 if v>9 AND v<48 THEN VY!=-VY!:GOSUB 650

440 IF TIME<1 GOTO 440
450 goto 100

499 'Range of hit is from x-7, x+32. Mapped to d into (-20, 19)
500 if pb=7 then ba=BX!-x: BY!=172
501 d=BX!-x-13
510 if d<-14 then VY!=-0.5:VX!=-2:return
511 if d<-6 then VY!=-1.5:VX!=-1.5:return
512 if d<0 then VY!=-2:VX!=-0.5:return
513 if d<6 then VY!=-2:VX!=0.5:return
514 if d<14 then VY!=-1.5:VX!=1.5:return
516 VY!=-0.5:VX!=2
549 RETURN

550 'POWERUP CAPTURED
551 if pb=pc THEN sc=sc+200 ELSE sc=sc+100
555 GOSUB 777
560 pb=pc
590 py=0:px=200:pc=0
599 RETURN

600 ' LOST A LIFE
601 put sprite 4,(0,0),0,0
602 put sprite 3,(0,0),0,0
603 put sprite 1,(0,0),0,0
604 put sprite 2,(0,0),0,0
605 if pl=0 GOTO 800
606 ' Move the pad to the center
607 if x>=87 THEN x=x-0.5 
608 if x=<85 THEN x=x+0.5
609 put sprite 1,(x,170),15,1
610 put sprite 2,(x+16,170),15,2
611 if x>=87 OR x<=85 GOTO 607
612 pl=pl-1
613 TX=24+(pl MOD 3)*2:TY=8+(pl)\3
614 FOR j=60 to 63
615   for k=0 to 100:NEXT K:T$=CHR$(j):GOSUB 760
616 NEXT J
617 T$=" ":GOSUB 760
618 BX!=102:BY!=172:VX!=0.5:VY!=-2
619 x=86:ax!=0
620 px=0:py=0:pc=0:pb=15
621 pm=0:ba=BX!-x
630 GOTO 100

650 ' BRICK HIT at sa, sb
651 bc=(v-8)/2:nc=1
652 if bc>7 THEN bb=0:xb=sa*16+8:yb=sb*8:cb=15
653 if bc=9 THEN RETURN
655 if bc=8 THEN nc=7
656 IF nc=1 GOTO 680
660 VPOKE &H1800+sa*2+1+sb*32,nc*2+8:VPOKE &H1800+sa*2+2+sb*32,nc*2+8+1
670 RETURN
680 NB=NB-1
685 if pc=0 AND rnd(1)>0.8 then GOSUB 700
686 if pb=8 THEN IF sb=(BY!+3)\8 THEN VX!=-VX! ELSE VY!=-VY!
687 if sb MOD 2 = 0 THEN nc=97+(l MOD 3)*2:cn=96+(l MOD 3)*2 ELSE nc=96+(l MOD 3)*2:cn=97+(l MOD 3)*2
689 VPOKE &H1800+sa*2+1+sb*32,CN:VPOKE &H1800+sa*2+2+sb*32,NC
690 if pb=11 THEN sc=sc+10*bc*2 ELSE sc=sc+10*bc
691 GOSUB 777
698 IF NB=0 THEN L=L+1:GOTO 800
699 RETURN

700 'POWERUP falls
710 px=(sa*16)+8:py=sb*8
720 PR!=rnd(1)
730 if PR!<0.3 THEN pc=11:RETURN
740 if PR!<0.6 THEN pc=8:RETURN
750 pc=7:RETURN

760 FOR i=1 to LEN(T$)
761   CT$=MID$(T$,i,1)
762   VPOKE &H1800+tx+ty*32+i,ASC(CT$)
763 NEXT I
764 RETURN

770 'Draw lives
771 T$="< "
772 for j=0 to pl-1
773   TX=24+(j MOD 3)*2
774   TY=8+j\3:GOSUB 760
775 NEXT j
776 RETURN

777 'Update and display score
780 if sc>1000 then sd=sd+1:sc=sc-1000:se=1
785 if se=0 GOTO 790
786 TS$=STR$(sd):T$=RIGHT$(TS$,LEN(TS$)-1):TX=27-LEN(T$):TY=2:se=0:GOSUB 760
787 if sd>=nl THEN pl=pl+1:nl=nl*2:GOSUB 770
788 T$="000":TY=2:TX=27:GOSUB 760
790 TS$=STR$(sc):T$=RIGHT$(TS$,LEN(TS$)-1): TX=30-LEN(T$):TY=2:GOSUB 760
799 RETURN

800 ' REDIRECTION FOR EXITING TURBO BLOCK
800 CALL TURBO OFF
801 'GAME OVER COULD BE PART OF TURBO ON
801 IF pl=0 GOTO 2500

811 put sprite 4,(0,0),0,0
812 put sprite 1,(0,0),0,0
813 put sprite 2,(0,0),0,0
814 put sprite 3,(0,0),0,0
815 BLOAD "cls.scr",S
816 T$="STAGE:":TX=10:TY=8:GOSUB 9090
817 T$=STR$(L):TX=16-LEN(T$):TY=10:GOSUB 9090
819 TIME=0
832 ' IF ON PLAY ALL MODE, READ THE FILES FROM 
830 IF VPEEK(0) = 0 THEN 832 ELSE LF$=LN$((L-1) MOD CL): GOTO 839
832 ON L MOD 5 GOTO 833,834,835,836,837
833 LF$="level_1.dat":GOTO 839
834 LF$="level_2.dat":GOTO 839
835 LF$="level_3.dat":GOTO 839
836 LF$="level_4.dat":GOTO 839
837 LF$="level_5.dat":GOTO 839
839 NB=0:K=1
840 OPEN LF$ FOR INPUT AS #1
850 FOR J=&H1820 TO &H19A0 STEP &H20
851   FOR I=1 TO 21 STEP 2
853     INPUT #1, C
854     BB(K)=C:K=K+1
860   NEXT I
861 NEXT J
870 CLOSE #1

880 IF TIME<100 GOTO 880
881 'TODO: Move this inside the turbo block
881 BLOAD "cls.scr",S:GOSUB 4100
882 T$="STAGE:":TX=24:TY=18:GOSUB 9090
883 T$=STR$(L):TX=30-LEN(T$):TY=20:GOSUB 9090

890 goto 40

900 ' Editor level selection
911 OPEN "RAFTOID.BLD" FOR INPUT AS #1
912 CL=0
920 ' Read 10 levels or until EOF
930 IF EOF(1) GOTO 990
940 INPUT #1, LN$(CL)
950 CL=CL+1
960 IF CL<10 GOTO 930
990 CLOSE #1
999 RETURN

2500 ' Game over screen TODO Extract
2550 BLOAD "cls.scr",S
2560 T$="GAME OVER":TX=10:TY=5:GOSUB 9090
2580 T$="SCORE:":TX=5:TY=10:GOSUB 9090
2581 T$="000000":TX=5:TY=12:GOSUB 9090
2582 TS$=STR$(sd):T$=RIGHT$(TS$,LEN(TS$)-1):TX=8-LEN(T$):TY=12:GOSUB 9090
2583 TS$=STR$(sc):T$=RIGHT$(TS$,LEN(TS$)-1):TX=11-LEN(T$):TY=12:GOSUB 9090
2591 T$="STAGE:":TX=19:TY=10: GOSUB 9090
2592 T$=STR$(l):TX=25-LEN(T$):TY=12:GOSUB 9090
2593 T$="PRESS ANY KEY":TX=9:TY=18:GOSUB 9090
2690 if inkey$<>"" goto 2690
2691 if inkey$="" goto 2691
2700 GOTO 4000

4000 ' START SCREEN
4002 IF VPEEK(0)=0 THEN RUN"start.bas" ELSE RUN "editor.bas"

4100 ' DRAW THE GRID TODO: This can also be done with BLOAD or turbo
4101 RESTORE 4110
4110 DATA 1, 3, 3, 4, 5, 3, 3, 3, 4, 5, 3, 3
4111 DATA 3, 3, 4, 5, 3, 3, 3, 4, 5, 3, 3, 2
4112 FOR I=0 TO 23
4113   READ BG
4114   VPOKE &H1800+i,BG
4119 NEXT I
4160 FOR K=1 TO 23
4161   km=(k+1) MOD 5
4162   if km>2 then VPOKE &H1800+K*32,5+km else VPOKE &H1800+K*32,6
4163   if k MOD 2=0 THEN cn=96+(l MOD 3)*2:nc=cn+1 ELSE cn=97+(l MOD 3)*2:nc=cn-1
4170   FOR I=1 TO 22 step 2
4189     VPOKE &H1800+i+K*32,cn:VPOKE &H1800+i+1+K*32,nc
4190   NEXT I
4191   if km>2 then VPOKE &H1800+23+K*32,5+km else VPOKE &H1800+23+K*32,7
4200 NEXT K
4210 T$="SCORE:":TX=24:TY=0:GOSUB 9090
4211 T$="000000":TX=24:TY=2:GOSUB 9090:se=1:GOSUB 777
4220 T$="LIVES:":TX=24:TY=6:GOSUB 9090
4221 GOSUB 4300
4299 RETURN

4300 'Draw lives
4301 T$="< "
4310 for j=0 to pl-1
4320   TX=24+(j MOD 3)*2
4330   TY=8+j\3:GOSUB 9090
4340 NEXT j
4390 RETURN

9090 FOR i=1 to LEN(T$)
9091   CT$=MID$(T$,i,1)
9092   VPOKE &H1800+tx+ty*32+i,ASC(CT$)
9093 NEXT I
9094 RETURN
