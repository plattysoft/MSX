3 color 2,1,1
4 SCREEN 2, 2
5 ' TODO: make the ball smaller
6 ' TODO: Game over animation + lives
7 ' TODO: WIN animation
8 bload "raftoid.sc2",S
10 CALL TURBO ON
15 GOSUB 6000
90 GOTO 4000

100 ' GAME LOOP
110 s=stick(0)
111 if s=3 then ax=ax+0.5
112 if s=7 then ax=ax-0.5
121 ax=ax*0.9
130 x=x+ax
131 if x<8 then x=8:ax=0
132 if x>152 then x=152:ax=0
140 by=by+vy
150 bx=bx+vx
300 if bx > 178 THEN bx = 178: vx = -vx
310 if bx < 8 THEN bx = 8: vx = -vx
321 if by>184 THEN goto 600
330 if by<8 THEN by = 8: vy = -vy
361 put sprite 0, (bx,by), 15, 0
362 put sprite 1, (x,170), 15, 1
363 put sprite 2, (x+16,170), 15, 2 
400 ' BOUNDING BOX COLISION DETECTION
410 if vx>0 THEN sa=(bx+6-8)\16 ELSE sa=(bx-1-8)\16
411 sb=(by+3)\8
412 if VPEEK (&H1800+sa*2+1+sb*32) > 9 THEN vx=-vx: GOSUB 650
415 if vy>0 THEN sb=(by+6)\8 ELSE sb=(by-1)\8
416 sa=(bx+3-8)\16
420 if VPEEK (&H1800+sa*2+1+sb*32) > 9 THEN vy=-vy: GOSUB 650
450 if by>168 AND by<180 AND bx>x-7 AND bx<x+32 then GOSUB 500

490 goto 100

500 d=bx-x-12
510 if d<-15 then vy=-0.5:vx=-2:return
520 if d<-10 then vy=-1.5:vx=-1.5:return
530 if d<-5 then vy=-2:vx=-0.5:return
540 if d<5 then vy=-vy:return
550 if d<10 then vy=-2:vx=0.5:return
560 if d<15 then vy=-1.5:vx=1.5:return
570 vy=-2:vx=0.5
599 RETURN

600 ' GAME OVER
601 put sprite 0, (0,0), 0, 0
602 put sprite 1, (0,0), 0, 0
603 put sprite 2, (0,0), 0, 0
610 GOTO 4000

650 ' BRICK HIT at sa, sb 
651 bc=(VPEEK(&H1800+sa*2+1+sb*32)-8)/2: nc=1
652 if bc=12 THEN RETURN
653 if bc=11 THEN nc=10
654 if bc=10 THEN nc=9
655 if bc=8 THEN nc=7
656 IF nc=1 THEN GOTO 680
660 VPOKE &H1800+sa*2+1+sb*32, nc*2+8: VPOKE &H1800+sa*2+2+sb*32, nc*2+8+1
670 RETURN
680 NB=NB-1
687 if sb MOD 2 = 0 THEN nc=NC:cn=nc-1 ELSE cn=nc:nc=nc-1
689 VPOKE &H1800+sa*2+1+sb*32, NC: VPOKE &H1800+sa*2+2+sb*32, CN
690 IF NB=0 THEN L=L+1: GOSUB 800
699 RETURN

800 ' LOAD AND DRAW LEVEL
801 put sprite 0, (0,0), 0, 0
802 put sprite 1, (0,0), 0, 0
803 put sprite 2, (0,0), 0, 0
818 if L = 1 then restore 900 else restore 910
819 NB = 0
820 FOR J=1 TO 8
821   FOR I=0 TO 10
823     READ C
832     IF C > 0 THEN NB=NB+1: VPOKE &H1800+i*2+1+j*32, c*2+8: VPOKE &H1800+i*2+2+j*32, c*2+9
840   NEXT I
841 NEXT J
875 bx = 96: by = 100: vx = 0: vy = 2
876 x = 86: ax=0
890 RETURN

900 ' DATA for levels, color 12 is undestructible, 8 is 2 hits (8->7), 11 is 3 hits (11->10->9)
901 DATA 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
902 DATA 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0
903 DATA 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0
904 DATA 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0
905 DATA 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0
906 DATA 0, 0, 0, 0, 0, 5, 0, 0, 0, 0, 0
907 DATA 0, 0, 0, 0, 0, 5, 0, 0, 0, 0, 0
908 DATA 0, 0, 0, 0, 0, 8, 0, 0, 0, 0, 0

910 DATA 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
912 DATA 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1
913 DATA 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2
914 DATA 3, 3, 3, 3, 3, 3, 3, 3, 3, 3, 3
915 DATA 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4
916 DATA 5, 5, 5, 5, 5, 5, 5, 5, 5, 5, 5
917 DATA 6, 6, 6, 6, 6, 6, 6, 6, 6, 6, 6
918 DATA 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0

920 DATA 0, 2, 1, 2, 1, 2, 1, 2, 1, 2, 0
922 DATA 2, 1, 2, 1, 2, 1, 2, 1, 2, 1, 2
923 DATA 1, 2, 1, 2, 1, 2, 1, 2, 1, 2, 1
924 DATA 2, 1, 2, 1, 2, 1, 2, 1, 2, 1, 2
925 DATA 1, 2, 1, 2, 1, 2, 1, 2, 1, 2, 1
926 DATA 0, 1, 2, 1, 2, 1, 2, 1, 2, 1, 0

3900 'CLS
3910 FOR I=0 TO 1535
3920   VPOKE &H1800+I, 59
3930 NEXT I
3950 RETURN

4000 ' START SCREEN
4001 GOSUB 3900
4004 for i=128 to 248
4005   VPOKE &H1802+i, i
4006   VPOKE &H1800+512+12+i, i
4009 next i
4010 'T$ = "RAFTOID":TX=12:TY=1: GOSUB 9090
4011 T$ = "PRESS SPACE TO START":TX=5:TY=14: GOSUB 9090
4020 A$=inkey$
4030 if A$=" " GOTO 4050
4031 if A$="q" then END
4040 GOTO 4020
4050 L=1
4060 GOSUB 3900
4071 GOSUB 4100
4080 GOSUB 800
4090 GOTO 100

4100 ' DRAW THE GRID
4160 FOR K=0 TO 23
4170 FOR I=0 TO 23
4180 if i MOD 2 = k MOD 2 THEN V=0 ELSE V=1
4181 if i=0 OR i=23 THEN V = K MOD 4 + 2
4183 if K=0 THEN V = 6 + I MOD 4
4189 VPOKE &H1800+i+K*32, V
4190 NEXT I
4200 NEXT K
4299 RETURN

6000 ' LOAD SPRITES
6010 RESTORE 6100
6020 FOR I=1 TO 8
6030   READ L: A$=A$+CHR$(L)
6040 NEXT I
6050 SPRITE$(0)=A$
6060 FOR S=1 TO 2
6061   A$=""
6062   FOR I=1 TO 32
6063     READ L: A$=A$+CHR$(L)
6064   NEXT I
6065   SPRITE$(S)=A$
6066 NEXT S
6090 RETURN

6100 ' BALL SPRITE
6101 DATA &H38,&H7C,&HFE,&HFE,&HFE,&H7C,&H38,&H00

6120 ' LEFT SPRITE
6130 DATA &H00,&H00,&H00,&H00,&H00,&H00,&H00,&H00
6140 DATA &H00,&H00,&H67,&H67,&H4F,&H4F,&H67,&H67
6150 DATA &H00,&H00,&H00,&H00,&H00,&H00,&H00,&H00
6160 DATA &H00,&H00,&HFF,&HFF,&HFF,&HFF,&HFF,&HFF
6200 ' RIGHT SPRITE
6210 DATA &H00,&H00,&H00,&H00,&H00,&H00,&H00,&H00
6220 DATA &H00,&H00,&HFF,&HFF,&HFF,&HFF,&HFF,&HFF
6230 DATA &H00,&H00,&H00,&H00,&H00,&H00,&H00,&H00
6240 DATA &H00,&H00,&HE6,&HE6,&HF2,&HF2,&HE6,&HE6

9090 FOR i=1 to LEN(T$)
9091   CT$=MID$(T$,i,1)
9092   VPOKE &H1800+tx+ty*32+i, ASC(CT$)
9093 NEXT I
9094 RETURN
