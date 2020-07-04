3 color 2,1,1
4 SCREEN 2, 2, 0
5 ' TODO: make the ball smaller
6 ' TODO: Game over animation
7 ' TODO: WIN animation
8 bload "raftoid.sc2",S
10 CALL TURBO ON
15 GOSUB 6000
90 GOTO 4000

100 ' GAME LOOP
110 s=stick(0)
111 if s=3 then ax=ax+0.5
112 if s=7 then ax=ax-0.5
113 if strig(0)=-1 then ba=0
120 if pc=0 then goto 130
121 py=py+1
122 if py > 184 THEN py=0:pc=0:px=200
123 if py>172 AND py<184 AND bx>x-7 AND bx<x+32 then GOSUB 550
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
340 if by>172 AND by<180 AND bx>x-7 AND bx<x+32 then GOSUB 500
360 ' Drawing step
361 put sprite 0, (bx,by), 15, 0
362 put sprite 1, (x,170), 15, 1
363 put sprite 2, (x+16,170), 15, 2
364 put sprite 3, (px,py), pc, 3+(py\4 MOD 12)
400 ' BOUNDING BOX COLISION DETECTION
410 if vx>0 THEN sa=(bx+6-8)\16 ELSE sa=(bx-1-8)\16
411 sb=(by+3)\8
412 v = VPEEK (&H1800+sa*2+1+sb*32)
413 if v>9 AND v<48 THEN vx=-vx: GOSUB 650
415 if vy>0 THEN sb=(by+6)\8 ELSE sb=(by-1)\8
416 sa=(bx+3-8)\16
420 v = VPEEK (&H1800+sa*2+1+sb*32)
421 if v>9 AND v<48 THEN vy=-vy: GOSUB 650

490 goto 100

500 if pm>=1 then pm=pm-1:ba = bx-x: by=172
501 d=bx-x-12
510 if d<-12 then vy=-0.5:vx=-2:return
511 if d<-6 then vy=-1.5:vx=-1.5:return
512 if d<0 then vy=-2:vx=-0.5:return
513 if d<6 then vy=-2:vx=0.5:return
514 if d<12 then vy=-1.5:vx=1.5:return
516 vy=-2:vx=0.5
549 RETURN

550 'POWERUP CAPTURED
560 if pc=4 then pm=pm+4
590 py=0:px=200:pc=0
599 RETURN

600 ' LOST A LIFE
601 put sprite 0, (0,0), 0, 0
602 put sprite 1, (0,0), 0, 0
603 put sprite 2, (0,0), 0, 0
604 put sprite 3, (0,0), 0, 0
605 pl=pl-1
606 if pl=0 then T$ = "     ":TX=24:TY=8: GOSUB 9090
607 if pl=1 then T$ = "<=   ":TX=24:TY=8: GOSUB 9090
608 if pl<0 GOTO 4000
610 bx = 102: by = 172: vx = 0.5: vy = -2
611 x = 86: ax=0
612 px=0: py=0: pc=0
613 pm=0: ba = bx-x
649 GOTO 100

650 ' BRICK HIT at sa, sb
651 bc=(v-8)/2: nc=1
652 if bc=9 THEN RETURN
655 if bc=8 THEN nc=7
656 IF nc=1 THEN GOTO 680
660 VPOKE &H1800+sa*2+1+sb*32, nc*2+8: VPOKE &H1800+sa*2+2+sb*32, nc*2+8+1
670 RETURN
680 NB=NB-1
681 if pc=0 AND rnd(time)>0.8 THEN px=(sa*16)+8: py=sb*8: pc=4
687 if sb MOD 2 = 0 THEN nc=97:cn=96 ELSE nc=96:cn=97
689 VPOKE &H1800+sa*2+1+sb*32, NC: VPOKE &H1800+sa*2+2+sb*32, CN
690 sc=sc+10*bc: T$=STR$(sc)
695 TX=30-LEN(T$):TY=2: GOSUB 9090
698 IF NB=0 THEN L=L+1: GOSUB 800
699 RETURN

800 ' LOAD AND DRAW LEVEL
801 put sprite 0, (0,0), 0, 0
802 put sprite 1, (0,0), 0, 0
803 put sprite 2, (0,0), 0, 0
804 put sprite 3, (0,0), 0, 0
809 LM = L MOD 5
810 if LM = 1 then restore 900 
811 if LM = 2 then restore 920 
812 if LM = 3 then restore 940 
813 if LM = 4 then restore 960 
814 if LM = 0 then restore 980 
819 NB = 0
820 FOR J=1 TO 12
821   FOR I=0 TO 10
823     READ C
832     IF C > 0 THEN NB=NB+1: VPOKE &H1800+i*2+1+j*32, c*2+8: VPOKE &H1800+i*2+2+j*32, c*2+9
840   NEXT I
841 NEXT J
875 bx = 102: by = 172: vx = 0.5: vy = -2
876 x = 86: ax=0
877 px=0: py=0: pc=0
878 pm=0: ba = bx-x
890 RETURN

899 ' DATA for levels
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

920 DATA 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
921 DATA 0, 1, 1, 1, 1, 0, 3, 3, 3, 3, 0
922 DATA 0, 1, 2, 2, 1, 0, 3, 4, 4, 3, 1
923 DATA 0, 1, 2, 2, 1, 0, 3, 4, 4, 3, 2
924 DATA 0, 1, 1, 1, 1, 0, 3, 3, 3, 3, 3
925 DATA 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
926 DATA 0, 0, 0, 5, 5, 5, 5, 5, 0, 0, 0
927 DATA 0, 0, 0, 5, 6, 6, 6, 5, 0, 0, 0
928 DATA 0, 0, 0, 5, 6, 6, 6, 5, 0, 0, 0
929 DATA 0, 0, 0, 5, 5, 5, 5, 5, 0, 0, 0
930 DATA 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
931 DATA 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0

940 DATA 0, 0, 0, 1, 2, 3, 2, 1, 0, 0, 0
941 DATA 0, 0, 0, 0, 1, 2, 1, 0, 0, 0, 0
942 DATA 1, 0, 0, 0, 0, 1, 0, 0, 0, 0, 1
943 DATA 2, 1, 0, 0, 0, 0, 0, 0, 0, 1, 2
944 DATA 3, 2, 1, 0, 0, 0, 0, 0, 1, 2, 3
945 DATA 4, 3, 2, 1, 0, 0, 0, 1, 2, 3, 4
946 DATA 5, 4, 3, 2, 1, 0, 1, 2, 3, 4, 5
947 DATA 6, 5, 4, 3, 2, 1, 2, 3, 4, 5, 6
948 DATA 8, 8, 8, 8, 8, 8, 8, 8, 8, 8, 8
949 DATA 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
950 DATA 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
951 DATA 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0

960 DATA 1, 2, 0, 0, 0, 0, 0, 0, 0, 2, 1
961 DATA 2, 0, 0, 0, 0, 2, 0, 0, 0, 0, 2
962 DATA 0, 0, 0, 0, 2, 3, 2, 0, 0, 0, 0
963 DATA 0, 0, 0, 2, 3, 4, 3, 2, 0, 0, 0
964 DATA 0, 0, 2, 3, 4, 5, 4, 3, 2, 0, 0
965 DATA 0, 2, 3, 4, 5, 6, 5, 4, 3, 2, 0
966 DATA 2, 3, 4, 5, 6, 7, 6, 5, 4, 3, 2
967 DATA 0, 2, 3, 4, 5, 6, 5, 4, 3, 2, 0
968 DATA 0, 0, 2, 3, 4, 5, 4, 3, 2, 5, 0
969 DATA 0, 0, 0, 2, 3, 4, 3, 2, 0, 0, 0
970 DATA 0, 0, 0, 0, 2, 3, 2, 0, 0, 0, 0
971 DATA 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0

980 DATA 0, 0, 0, 0, 8, 1, 8, 0, 0, 0, 0
981 DATA 0, 0, 0, 0, 0, 8, 0, 0, 0, 0, 0
982 DATA 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
983 DATA 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
984 DATA 1, 1, 1, 9, 6, 8, 6, 9, 1, 1, 1
985 DATA 2, 2, 2, 2, 9, 6, 9, 2, 2, 2, 2
986 DATA 3, 3, 3, 3, 3, 9, 3, 3, 3, 3, 3
987 DATA 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4
988 DATA 8, 5, 8, 5, 5, 5, 5, 5, 8, 5, 8
989 DATA 6, 8, 9, 8, 6, 6, 6, 8, 9, 8, 6
990 DATA 8, 9, 9, 9, 8, 8, 8, 9, 9, 9, 8
991 DATA 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0

3900 'CLS
3910 FOR I=0 TO 768
3920   VPOKE &H1800+I, 59
3930 NEXT I
3950 RETURN

4000 ' START SCREEN
4001 GOSUB 3900
4004 for i=128 to 248
4005   VPOKE &H1802+i, i
4006   VPOKE &H1800+512+12+i, i
4009 next i
4011 T$ = "PRESS SPACE TO START":TX=5:TY=14: GOSUB 9090
4019 if inkey$<>"" goto 4019
4020 A$=inkey$
4030 if A$=" " GOTO 4050
4031 if A$="q" then END
4040 GOTO 4020
4050 L=5:sc=0:pl=2
4060 GOSUB 3900
4071 GOSUB 4100
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
4180     if i MOD 2 = 0 = k MOD 2 THEN V=96 ELSE V=97
4189     VPOKE &H1800+i+K*32, V
4190   NEXT I
4191   if km > 2 then VPOKE &H1800+23+K*32, 5+km else VPOKE &H1800+23+K*32, 7
4200 NEXT K
4210 T$ = "SCORE:":TX=24:TY=0: GOSUB 9090
4211 T$ = "0":TX=29:TY=2: GOSUB 9090
4220 T$ = "LIVES:":TX=24:TY=6: GOSUB 9090
4221 T$ = "<= <=":TX=24:TY=8: GOSUB 9090
4223 'T$ = "<=":TX=24:TY=9: GOSUB 9090
4299 RETURN

6000 ' LOAD SPRITES
6010 RESTORE 6100
6020 FOR I=1 TO 8
6030   READ L: A$=A$+CHR$(L)
6040 NEXT I
6050 SPRITE$(0)=A$
6060 FOR S=1 TO 14
6061   A$=""
6062   FOR I=1 TO 32
6063     READ L: A$=A$+CHR$(L)
6064   NEXT I
6065   SPRITE$(S)=A$
6066 NEXT S
6090 RETURN

6100 ' BALL SPRITE
6101 DATA &H38,&H7C,&HFE,&HFE,&HFE,&H7C,&H38,&H00

6120 ' left side of the paddle
6130 DATA &H00,&H00,&H00,&H00,&H00,&H00,&H00,&H00
6140 DATA &H00,&H00,&H67,&H67,&H4F,&H4F,&H67,&H67
6150 DATA &H00,&H00,&H00,&H00,&H00,&H00,&H00,&H00
6160 DATA &H00,&H00,&HFF,&HFF,&HFF,&HFF,&HFF,&HFF
6200 ' Right side of the paddle
6210 DATA &H00,&H00,&H00,&H00,&H00,&H00,&H00,&H00
6220 DATA &H00,&H00,&HFF,&HFF,&HFF,&HFF,&HFF,&HFF
6230 DATA &H00,&H00,&H00,&H00,&H00,&H00,&H00,&H00
6240 DATA &H00,&H00,&HE6,&HE6,&HF2,&HF2,&HE6,&HE6

7000 ' Sample powerup with animation (12 sprites)
7030 DATA &H7F,&HFB,&HF9,&HFA,&HFB,&HFB,&H7F,&H00
7031 DATA &H00,&H00,&H00,&H00,&H00,&H00,&H00,&H00
7040 DATA &HFC,&HBE,&H3E,&HBE,&HBE,&HBE,&HFC,&H00
7041 DATA &H00,&H00,&H00,&H00,&H00,&H00,&H00,&H00
7080 DATA &H7F,&HFF,&HFB,&HF9,&HFA,&HFB,&H7F,&H00,&H00,&H00,&H00,&H00,&H00,&H00,&H00,&H00
7090 DATA &HFC,&HFE,&HBE,&H3E,&HBE,&HBE,&HFC,&H00,&H00,&H00,&H00,&H00,&H00,&H00,&H00,&H00
7130 DATA &H7F,&HFF,&HFF,&HFB,&HF9,&HFA,&H7F,&H00,&H00,&H00,&H00,&H00,&H00,&H00,&H00,&H00
7140 DATA &HFC,&HFE,&HFE,&HBE,&H3E,&HBE,&HFC,&H00,&H00,&H00,&H00,&H00,&H00,&H00,&H00,&H00
7180 DATA &H7F,&HFF,&HFF,&HFF,&HFB,&HF9,&H7F,&H00,&H00,&H00,&H00,&H00,&H00,&H00,&H00,&H00
7190 DATA &HFC,&HFE,&HFE,&HFE,&HBE,&H3E,&HFC,&H00,&H00,&H00,&H00,&H00,&H00,&H00,&H00,&H00
7230 DATA &H7F,&HFF,&HFF,&HFF,&HFF,&HFB,&H7F,&H00,&H00,&H00,&H00,&H00,&H00,&H00,&H00,&H00
7240 DATA &HFC,&HFE,&HFE,&HFE,&HFE,&HBE,&HFC,&H00,&H00,&H00,&H00,&H00,&H00,&H00,&H00,&H00
7280 DATA &H7F,&HFF,&HFF,&HFF,&HFF,&HFF,&H7F,&H00,&H00,&H00,&H00,&H00,&H00,&H00,&H00,&H00
7290 DATA &HFC,&HFE,&HFE,&HFE,&HFE,&HFE,&HFC,&H00,&H00,&H00,&H00,&H00,&H00,&H00,&H00,&H00
7291 DATA &H7F,&HFF,&HFF,&HFF,&HFF,&HFF,&H7F,&H00,&H00,&H00,&H00,&H00,&H00,&H00,&H00,&H00
7292 DATA &HFC,&HFE,&HFE,&HFE,&HFE,&HFE,&HFC,&H00,&H00,&H00,&H00,&H00,&H00,&H00,&H00,&H00
7293 DATA &H7F,&HFF,&HFF,&HFF,&HFF,&HFF,&H7F,&H00,&H00,&H00,&H00,&H00,&H00,&H00,&H00,&H00
7294 DATA &HFC,&HFE,&HFE,&HFE,&HFE,&HFE,&HFC,&H00,&H00,&H00,&H00,&H00,&H00,&H00,&H00,&H00
7295 DATA &H7F,&HFF,&HFF,&HFF,&HFF,&HFF,&H7F,&H00,&H00,&H00,&H00,&H00,&H00,&H00,&H00,&H00
7296 DATA &HFC,&HFE,&HFE,&HFE,&HFE,&HFE,&HFC,&H00,&H00,&H00,&H00,&H00,&H00,&H00,&H00,&H00
7330 DATA &H7F,&HFB,&HFF,&HFF,&HFF,&HFF,&H7F,&H00,&H00,&H00,&H00,&H00,&H00,&H00,&H00,&H00
7340 DATA &HFC,&HBE,&HFE,&HFE,&HFE,&HFE,&HFC,&H00,&H00,&H00,&H00,&H00,&H00,&H00,&H00,&H00
7380 DATA &H7F,&HFB,&HFB,&HFF,&HFF,&HFF,&H7F,&H00,&H00,&H00,&H00,&H00,&H00,&H00,&H00,&H00
7390 DATA &HFC,&HBE,&HBE,&HFE,&HFE,&HFE,&HFC,&H00,&H00,&H00,&H00,&H00,&H00,&H00,&H00,&H00
7430 DATA &H7F,&HFA,&HFB,&HFB,&HFF,&HFF,&H7F,&H00,&H00,&H00,&H00,&H00,&H00,&H00,&H00,&H00
7440 DATA &HFC,&HBE,&HBE,&HBE,&HFE,&HFE,&HFC,&H00,&H00,&H00,&H00,&H00,&H00,&H00,&H00,&H00
7480 DATA &H7F,&HF9,&HFA,&HFB,&HFB,&HFF,&H7F,&H00,&H00,&H00,&H00,&H00,&H00,&H00,&H00,&H00
7490 DATA &HFC,&H3E,&HBE,&HBE,&HBE,&HFE,&HFC,&H00,&H00,&H00,&H00,&H00,&H00,&H00,&H00,&H00

9090 FOR i=1 to LEN(T$)
9091   CT$=MID$(T$,i,1)
9092   VPOKE &H1800+tx+ty*32+i, ASC(CT$)
9093 NEXT I
9094 RETURN
