1 color 2,1,1
2 SCREEN 2,2,0
8 bload "raftoid.sc2",S
10 call turbo on
15 GOSUB 6000
20 GOTO 4000

100 ' GAME LOOP
110 s=stick(0)
111 if s=3 then ax=ax+0.5
112 if s=7 then ax=ax-0.5
113 s=stick(1)
114 if s=3 then ax=ax+0.5
115 if s=7 then ax=ax-0.5
116 if strig(0)=-1 then ba=0
117 if strig(1)=-1 then ba=0
120 if pc=0 then goto 130
121 py=py+1
122 if py > 184 THEN py=0:pc=0:px=200
123 if py>172 AND py<184 AND px>x-15 AND px<x+32 then GOSUB 550
130 x=x+ax
131 ax=ax*0.9
132 if x<8 then x=8:ax=0
133 if x>152 then x=152:ax=0
139 if ba>0 then bx=ba+x: GOTO 360
140 by=by+vy
150 bx=bx+vx
300 if bx > 178 THEN bx = 178: vx = -vx
310 if bx < 8 THEN bx = 8: vx = -vx
321 if by>184 THEN goto 600
330 if by<8 THEN by = 8: vy = -vy
340 if by>170 AND by<180 AND bx>x-7 AND bx<x+32 then GOSUB 500
360 ' Drawing step
361 put sprite 4, (bx,by), pb, 0
362 put sprite 1, (x,170), 15, 1
363 put sprite 2, (x+16,170), 15, 2
364 put sprite 3, (px,py), pc, 3
366 put sprite 5, (xb,yb), cb, bb+4
367 if bb=10 then cb=0 else bb=bb+1
400 ' BOUNDING BOX COLISION DETECTION
410 if vx>0 THEN sa=(bx+6-8)\16 ELSE sa=(bx-1-8)\16
411 sb=(by+3)\8
412 v = VPEEK (&H1800+sa*2+1+sb*32)
413 if v>9 AND v<48 THEN vx=-vx: GOSUB 650
415 if vy>0 THEN sb=(by+6)\8 ELSE sb=(by-1)\8
416 sa=(bx+3-8)\16
420 v = VPEEK (&H1800+sa*2+1+sb*32)
421 if v>9 AND v<48 THEN vy=-vy: GOSUB 650

450 goto 100

499 'Range of hit is from x-7, x+32. Mapped to d into (-20, 19)
500 if pb=7 then ba = bx-x: by=172
501 d=bx-x-13
510 if d<-14 then vy=-0.5:vx=-2:return
511 if d<-6 then vy=-1.5:vx=-1.5:return
512 if d<0 then vy=-2:vx=-0.5:return
513 if d<6 then vy=-2:vx=0.5:return
514 if d<14 then vy=-1.5:vx=1.5:return
516 vy=-0.5:vx=2
549 RETURN

550 'POWERUP CAPTURED
551 if pb=pc THEN sc=sc+200 ELSE sc=sc+100
555 GOSUB 777
560 pb=pc
590 py=0:px=200:pc=0
599 RETURN

600 ' LOST A LIFE
601 put sprite 4, (0,0), 0, 0
602 put sprite 3, (0,0), 0, 0
603 put sprite 1, (0,0), 0, 0
604 put sprite 2, (0,0), 0, 0
605 if pl=0 then GOTO 2500
606 ' Move the pad to the center
607 if x>=87 THEN x=x-0.5 
608 if x=<85 THEN x=x+0.5
609 put sprite 1, (x,170), 15, 1
610 put sprite 2, (x+16,170), 15, 2
611 if x>=87 OR x<=85 THEN GOTO 607
612 pl=pl-1
613 TX=24+(pl MOD 3)*2:TY=8+(pl)\3
614 FOR j=60 to 63
615   for k=0 to 100: NEXT K:T$=CHR$(j):GOSUB 9090
616 NEXT J
617 T$=" ":GOSUB 9090
618 bx=102: by=172: vx=0.5: vy=-2
619 x=86: ax=0
620 px=0: py=0: pc=0: pb=15
621 pm=0: ba=bx-x
630 GOTO 100

650 ' BRICK HIT at sa, sb
651 bc=(v-8)/2: nc=1
652 if bc>7 THEN bb=0:xb=sa*16+8:yb=sb*8:cb=15
653 if bc=9 THEN RETURN
655 if bc=8 THEN nc=7
656 IF nc=1 THEN GOTO 680
660 VPOKE &H1800+sa*2+1+sb*32, nc*2+8: VPOKE &H1800+sa*2+2+sb*32, nc*2+8+1
670 RETURN
680 NB=NB-1
681 if pc=0 AND rnd(time)>0.8 THEN GOSUB 700
685 if pb=8 THEN IF sb=(by+3)\8 THEN vx=-vx ELSE vy=-vy
687 if sb MOD 2 = 0 THEN nc=97+(l MOD 3)*2:cn=96+(l MOD 3)*2 ELSE nc=96+(l MOD 3)*2:cn=97+(l MOD 3)*2
689 VPOKE &H1800+sa*2+1+sb*32, NC: VPOKE &H1800+sa*2+2+sb*32, CN
690 if pb=11 THEN sc=sc+10*bc*2 ELSE sc=sc+10*bc
691 GOSUB 777
698 IF NB=0 THEN L=L+1: GOSUB 800
699 RETURN

700 'POWERUP falls
710 px=(sa*16)+8: py=sb*8: pc=7
720 pr=rnd(time)
730 if pr<0.3 THEN pc=11:RETURN
740 if pr<0.6 THEN pc=8: RETURN
750 pc=7: RETURN

777 'Update and display score
780 if sc>1000 then sd=sd+1:sc=sc-1000:se=1
785 if se=0 THEN GOTO 790
786 TS$=STR$(sd):T$=RIGHT$(TS$,LEN(TS$)-1):TX=27-LEN(T$):TY=2:se=0:GOSUB 9090
787 if sd>=nl THEN pl=pl+1:nl=nl*2:GOSUB 4300
788 T$="000":TY=2:TX=27: GOSUB 9090
790 TS$=STR$(sc):T$=RIGHT$(TS$,LEN(TS$)-1): TX=30-LEN(T$):TY=2:GOSUB 9090
799 RETURN

800 ' LOAD AND DRAW LEVEL
801 put sprite 4, (0,0), 0, 0
802 put sprite 1, (0,0), 0, 0
803 put sprite 2, (0,0), 0, 0
804 put sprite 3, (0,0), 0, 0
805 GOSUB 3900
806 T$ = "STAGE:":TX=10:TY=8: GOSUB 9090
807 T$ = STR$(L):TX=16-LEN(T$):TY=10: GOSUB 9090
808 FOR I=0 TO 5000:NEXT I
809 GOSUB 3900:GOSUB 4100
810 T$ = "STAGE:":TX=24:TY=18: GOSUB 9090
811 T$ = STR$(L):TX=30-LEN(T$):TY=20: GOSUB 9090
812 LM = L MOD 5
813 if LM = 1 then restore 900 
814 if LM = 2 then restore 920 
815 if LM = 3 then restore 940 
816 if LM = 4 then restore 960 
817 if LM = 0 then restore 980 
819 NB = 0
820 FOR J=1 TO 13
821   FOR I=0 TO 10
823     READ C
832     IF C > 0 THEN NB=NB+1: VPOKE &H1800+i*2+1+j*32, c*2+8: VPOKE &H1800+i*2+2+j*32, c*2+9
840   NEXT I
841 NEXT J
875 bx = 102: by = 172: vx = 0.5: vy = -2
876 x = 86: ax=0
877 px=0: py=0: pc=0: pb=15
878 pm=0: ba = bx-x
890 RETURN

898 ' DATA for levels
899 ' Stage 1: The wall
900 DATA 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
901 DATA 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
902 DATA 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1
903 DATA 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2
904 DATA 3, 3, 3, 3, 3, 3, 3, 3, 3, 3, 3
905 DATA 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4
906 DATA 5, 5, 5, 5, 5, 5, 5, 5, 5, 5, 5
907 DATA 6, 6, 6, 6, 6, 6, 6, 6, 6, 6, 6
908 DATA 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
909 DATA 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
910 DATA 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
911 DATA 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
912 DATA 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0

919 ' Stage 2: The face
920 DATA 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
921 DATA 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
922 DATA 0, 1, 1, 1, 1, 0, 1, 1, 1, 1, 0
923 DATA 0, 1, 2, 2, 1, 0, 1, 3, 3, 1, 0
924 DATA 0, 1, 2, 2, 1, 0, 1, 3, 3, 1, 0
925 DATA 0, 1, 1, 1, 1, 0, 1, 1, 1, 1, 0
926 DATA 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
927 DATA 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
928 DATA 0, 0, 5, 5, 5, 5, 5, 5, 5, 0, 0
929 DATA 0, 0, 5, 6, 8, 6, 8, 6, 5, 0, 0
930 DATA 0, 0, 5, 6, 6, 6, 6, 6, 5, 0, 0
931 DATA 0, 0, 5, 5, 5, 5, 5, 5, 5, 0, 0
932 DATA 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0

939 ' Stage 3: The diamond
940 DATA 1, 2, 0, 0, 0, 0, 0, 0, 0, 2, 1
941 DATA 2, 0, 0, 0, 0, 0, 0, 0, 0, 0, 2
942 DATA 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0
943 DATA 0, 0, 0, 0, 2, 3, 2, 0, 0, 0, 0
944 DATA 0, 0, 0, 2, 3, 4, 3, 2, 0, 0, 0
945 DATA 0, 0, 2, 3, 4, 5, 4, 3, 2, 0, 0
946 DATA 0, 2, 3, 4, 5, 6, 5, 4, 3, 2, 0
947 DATA 2, 3, 4, 5, 6, 7, 6, 5, 4, 3, 2
948 DATA 0, 2, 3, 4, 5, 6, 5, 4, 3, 2, 0
949 DATA 0, 0, 2, 3, 4, 5, 4, 3, 2, 0, 0
950 DATA 0, 0, 0, 2, 3, 4, 3, 2, 0, 0, 0
951 DATA 0, 0, 0, 0, 2, 3, 2, 0, 0, 0, 0
952 DATA 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0

959 ' Stage 4: The arrow
960 DATA 0, 0, 0, 1, 2, 8, 2, 1, 0, 0, 0
961 DATA 0, 0, 0, 0, 1, 2, 1, 0, 0, 0, 0
962 DATA 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0
963 DATA 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1
964 DATA 2, 1, 0, 0, 0, 0, 0, 0, 0, 1, 2
965 DATA 3, 2, 1, 0, 0, 0, 0, 0, 1, 2, 3
966 DATA 4, 3, 2, 1, 0, 0, 0, 1, 2, 3, 4
967 DATA 5, 4, 3, 2, 1, 0, 1, 2, 3, 4, 5
968 DATA 6, 5, 4, 3, 2, 1, 2, 3, 4, 5, 6
969 DATA 8, 8, 8, 8, 8, 8, 8, 8, 8, 8, 8
970 DATA 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
971 DATA 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
972 DATA 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0

979 ' Stage 5: The wave
980 DATA 0, 0, 0, 0, 8, 1, 8, 0, 0, 0, 0
981 DATA 0, 0, 0, 0, 0, 8, 0, 0, 0, 0, 0
982 DATA 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
983 DATA 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
984 DATA 1, 2, 3, 9, 6, 9, 6, 9, 3, 2, 1
985 DATA 2, 3, 4, 3, 8, 9, 8, 3, 4, 3, 2
986 DATA 3, 4, 5, 4, 3, 9, 3, 4, 5, 4, 3
987 DATA 4, 5, 6, 5, 4, 3, 4, 5, 6, 5, 4
988 DATA 5, 9, 8, 6, 5, 4, 5, 6, 8, 9, 5
989 DATA 8, 5, 9, 8, 6, 5, 6, 8, 9, 5, 8
990 DATA 1, 8, 5, 9, 8, 6, 8, 9, 5, 8, 1
991 DATA 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
992 DATA 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0

2500 ' Game over screen
2550 GOSUB 3900
2560 T$ = "GAME OVER":TX=10:TY=5: GOSUB 9090
2580 T$ = "SCORE:":TX=5:TY=10:GOSUB 9090
2581 T$ = "000000":TX=5:TY=12:GOSUB 9090
2582 TS$=STR$(sd):T$=RIGHT$(TS$,LEN(TS$)-1):TX=8-LEN(T$):TY=12: GOSUB 9090
2583 TS$=STR$(sc):T$=RIGHT$(TS$,LEN(TS$)-1):TX=11-LEN(T$):TY=12: GOSUB 9090
2591 T$ = "STAGE:":TX=19:TY=10: GOSUB 9090
2592 T$=STR$(l):TX=25-LEN(T$):TY=12: GOSUB 9090
2593 T$ = "PRESS ANY KEY":TX=9:TY=18: GOSUB 9090
2690 if inkey$<>"" goto 2690
2691 if inkey$="" goto 2691
2700 GOTO 4000

3900 'CLS
3910 FOR I=0 TO 767
3920   VPOKE &H1800+I, 59
3930 NEXT I
3950 RETURN

4000 ' START SCREEN
4002 GOSUB 3900
4004 for i=128 to 248
4005   VPOKE &H1802+i, i
4006   VPOKE &H1800+512+12+i, i
4009 next i
4011 T$ = "PRESS SPACE TO START":TX=5:TY=14: GOSUB 9090
4019 if inkey$<>"" goto 4019
4020 A$=inkey$
4031 if A$="q" then END
4032 if strig(0)=-1 OR strig(1)=-1 GOTO 4050
4040 GOTO 4020
4050 L=1:sc=0:sd=0:pl=2:nl=5
4051 TX=5:TY=14
4053 for k=0 to 900 
4054   if k MOD 200 = 0 then  T$ = "                    ": GOSUB 9090
4055   if k MOD 200 = 80 then T$ = "PRESS SPACE TO START": GOSUB 9090
4059 next k
4080 GOSUB 800
4090 GOTO 100

4100 ' DRAW THE GRID
4101 RESTORE 4110
4110 DATA 1, 3, 3, 4, 5, 3, 3, 3, 4, 5, 3, 3
4111 DATA 3, 3, 4, 5, 3, 3, 3, 4, 5, 3, 3, 2
4112 FOR I=0 TO 23
4113   READ BG
4114   VPOKE &H1800+i, BG
4119 NEXT I
4160 FOR K=1 TO 23
4161   km = (k+1) MOD 5
4162   if km > 2 then VPOKE &H1800+K*32, 5+km else VPOKE &H1800+K*32, 6
4170   FOR I=1 TO 22
4180     if i MOD 2 = k MOD 2 THEN V=96+(l MOD 3)*2 ELSE V=97+(l MOD 3)*2
4189     VPOKE &H1800+i+K*32, V
4190   NEXT I
4191   if km > 2 then VPOKE &H1800+23+K*32, 5+km else VPOKE &H1800+23+K*32, 7
4200 NEXT K
4210 T$ = "SCORE:":TX=24:TY=0: GOSUB 9090
4211 T$ = "000000":TX=24:TY=2:GOSUB 9090:se=1:GOSUB 777
4220 T$ = "LIVES:":TX=24:TY=6: GOSUB 9090
4221 GOSUB 4300
4299 RETURN

4300 'Draw lives
4301 T$="< "
4310 for j=0 to pl-1
4320   TX=24+ (j MOD 3)*2
4330   TY=8+j\3: GOSUB 9090
4340 NEXT j
4390 RETURN

6000 ' LOAD SPRITES
6010 RESTORE 6100
6050 SPRITE$(0)=A$
6060 FOR S=0 TO 13
6061   A$=""
6062   FOR I=1 TO 32
6063     READ L: A$=A$+CHR$(L)
6064   NEXT I
6065   SPRITE$(S)=A$
6066 NEXT S
6090 RETURN

6100 ' Ball sprite
6101 DATA &H38,&H7C,&HFE,&HFE,&HFE,&H7C,&H38,&H00,&H00,&H00,&H00,&H00,&H00,&H00,&H00,&H00
6102 DATA &H00,&H00,&H00,&H00,&H00,&H00,&H00,&H00,&H00,&H00,&H00,&H00,&H00,&H00,&H00,&H00
6120 ' left side of the paddle
6130 DATA &H00,&H00,&H00,&H00,&H00,&H00,&H00,&H00,&H00,&H00,&H67,&H67,&H4F,&H4F,&H67,&H67
6150 DATA &H00,&H00,&H00,&H00,&H00,&H00,&H00,&H00,&H00,&H00,&HFF,&HFF,&HFF,&HFF,&HFF,&HFF
6200 ' Right side of the paddle
6210 DATA &H00,&H00,&H00,&H00,&H00,&H00,&H00,&H00,&H00,&H00,&HFF,&HFF,&HFF,&HFF,&HFF,&HFF
6230 DATA &H00,&H00,&H00,&H00,&H00,&H00,&H00,&H00,&H00,&H00,&HE6,&HE6,&HF2,&HF2,&HE6,&HE6

7000 ' Powerup
7010 DATA &H7F,&HFF,&HFF,&HFF,&HFF,&HFF,&H7F,&H00,&H00,&H00,&H00,&H00,&H00,&H00,&H00,&H00
7020 DATA &HFC,&HFE,&HFE,&HFE,&HFE,&HFE,&HFC,&H00,&H00,&H00,&H00,&H00,&H00,&H00,&H00,&H00

7509 ' Brick blinking (10 sprites)
7510 DATA &H03,&H03,&H07,&H07,&H0F,&H0F,&H1F,&H1F,&H00,&H00,&H00,&H00,&H00,&H00,&H00,&H00
7520 DATA &HF8,&HF8,&HF0,&HF0,&HE0,&HE0,&HC0,&HC0,&H00,&H00,&H00,&H00,&H00,&H00,&H00,&H00
7530 DATA &HBC,&HBC,&H78,&H78,&HF0,&HF0,&HE0,&HE0,&H00,&H00,&H00,&H00,&H00,&H00,&H00,&H00
7550 DATA &H0F,&H0F,&H1E,&H1E,&H3C,&H3C,&H78,&H78,&H00,&H00,&H00,&H00,&H00,&H00,&H00,&H00
7560 DATA &H07,&H07,&H0F,&H0F,&H1E,&H1E,&H3D,&H3D,&H00,&H00,&H00,&H00,&H00,&H00,&H00,&H00
7540 DATA &H1E,&H1E,&H3C,&H3C,&H78,&H78,&HF0,&HF0,&H00,&H00,&H00,&H00,&H00,&H00,&H00,&H00
7570 DATA &H1E,&H1E,&H3C,&H3C,&H78,&H78,&HF0,&HF0,&H00,&H00,&H00,&H00,&H00,&H00,&H00,&H00
7580 DATA &H0F,&H0F,&H1E,&H1E,&H3C,&H3C,&H78,&H78,&H00,&H00,&H00,&H00,&H00,&H00,&H00,&H00
7590 DATA &H3C,&H3C,&H78,&H78,&HF0,&HF0,&HE0,&HE0,&H00,&H00,&H00,&H00,&H00,&H00,&H00,&H00
7600 DATA &H07,&H07,&H0F,&H0F,&H1E,&H1E,&H3C,&H3C,&H00,&H00,&H00,&H00,&H00,&H00,&H00,&H00
7610 DATA &H78,&H78,&HF0,&HF0,&HE0,&HE0,&HC0,&HC0,&H00,&H00,&H00,&H00,&H00,&H00,&H00,&H00
7620 DATA &H03,&H03,&H07,&H07,&H0F,&H0F,&H1E,&H1E,&H00,&H00,&H00,&H00,&H00,&H00,&H00,&H00
7630 DATA &HF0,&HF0,&HE0,&HE0,&HC0,&HC0,&H80,&H80,&H00,&H00,&H00,&H00,&H00,&H00,&H00,&H00
7640 DATA &H01,&H01,&H03,&H03,&H07,&H07,&H0F,&H0F,&H00,&H00,&H00,&H00,&H00,&H00,&H00,&H00
7650 DATA &HE0,&HE0,&HC0,&HC0,&H80,&H80,&H00,&H00,&H00,&H00,&H00,&H00,&H00,&H00,&H00,&H00
7660 DATA &H00,&H00,&H01,&H01,&H03,&H03,&H07,&H07,&H00,&H00,&H00,&H00,&H00,&H00,&H00,&H00
7670 DATA &H00,&H00,&H00,&H00,&H01,&H01,&H03,&H03,&H00,&H00,&H00,&H00,&H00,&H00,&H00,&H00
7690 DATA &HC0,&HC0,&H80,&H80,&H00,&H00,&H00,&H00,&H00,&H00,&H00,&H00,&H00,&H00,&H00,&H00
7680 DATA &H80,&H80,&H00,&H00,&H00,&H00,&H00,&H00,&H00,&H00,&H00,&H00,&H00,&H00,&H00,&H00
7700 DATA &H00,&H00,&H00,&H00,&H00,&H00,&H01,&H01,&H00,&H00,&H00,&H00,&H00,&H00,&H00,&H00

9090 FOR i=1 to LEN(T$)
9091   CT$=MID$(T$,i,1)
9092   VPOKE &H1800+tx+ty*32+i, ASC(CT$)
9093 NEXT I
9094 RETURN
