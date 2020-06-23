1 color 2,1,1
2 SCREEN 2, 2
3 ' TODO: make the ball smaller
5 ' TODO: Game over animation + lives
6 ' TODO: WIN animation
7 ' TODO: Consider tiles for better looking bricks
11 OPEN "GRP:" FOR OUTPUT AS #1
12 GOSUB 600
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
320 if by > 152 THEN by = 152: vy = -vy
321 'if by>160 THEN goto 800
330 if by<8 THEN by = 8: vy = -vy
361 put sprite 0, (bx,by), 15, 0
362 put sprite 1, (x,140), 15, 1
363 put sprite 2, (x+16,140), 15, 2 
400 ' BOUNDING BOX COLISION DETECTION
410 if vx>0 THEN sa=(bx+6-8)\16 ELSE sa=(bx-1-8)\16
411 sb=(by+3)\8
412 if VPEEK (&H1800+sa*2+1+sb*32) > 9 THEN vx=-vx: GOSUB 850
415 if vy>0 THEN sb=(by+6)\8 ELSE sb=(by-1)\8
416 sa=(bx+3-8)\16
420 if VPEEK (&H1800+sa*2+1+sb*32) > 9 THEN vy=-vy: GOSUB 850
450 if by>138 AND by<150 AND bx>x-7 AND bx<x+32 then GOSUB 700

490 goto 100

500 ' LOAD AND DRAW LEVEL
501 put sprite 0, (0,0), 0, 0
502 put sprite 1, (0,0), 0, 0
503 put sprite 2, (0,0), 0, 0
518 if L = 1 then restore 900 else restore 910
519 NB = 0
520 FOR J=1 TO 6
521   FOR I=0 TO 10
523     READ C
532     IF C > 0 THEN NB=NB+1: VPOKE &H1800+i*2+1+j*32, c+9: VPOKE &H1800+i*2+2+j*32, c+9
540   NEXT I
541 NEXT J
575 bx = 96: by = 100: vx = 0: vy = 4
576 x = 86: ax=0
590 RETURN

600 ' LOAD SPRITES
610 RESTORE 1000
650 FOR I=1 TO 8
651   READ L: A$=A$+CHR$(L)
652 NEXT I
653 SPRITE$(0)=A$
660 FOR S=1 TO 2
661   A$=""
662   FOR I=1 TO 32
663     READ L: A$=A$+CHR$(L)
664   NEXT I
665   SPRITE$(S)=A$
666 NEXT S
690 RETURN

700 d=bx-x-12
710 if d<-15 then vy=-1:vx=-4:return
720 if d<-10 then vy=-3:vx=-3:return
730 if d<-5 then vy=-4:vx=-1:return
740 if d<5 then vy=-vy:return
750 if d<10 then vy=-4:vx=1:return
760 if d<15 then vy=-3:vx=3:return
770 vy=-4:vx=1
799 RETURN

800 ' GAME OVER
801 put sprite 0, (0,0), 0, 0
802 put sprite 1, (0,0), 0, 0
803 put sprite 2, (0,0), 0, 0
810 GOTO 4000

850 ' BRICK HIT at sa, sb 
851 bc=VPEEK(&H1800+sa*2+1+sb*32)-10: nc=1
852 if bc=14 THEN RETURN
853 if bc=11 THEN nc=10
854 if bc=4  THEN nc=5
855 if bc=5  THEN nc=7
856 IF NC=1 THEN NB=NB-1
857 if sb MOD 2 = 0 THEN nc=NC:cn=nc-1 ELSE cn=nc:nc=nc-1
859 VPOKE &H1800+sa*2+1+sb*32, NC: VPOKE &H1800+sa*2+2+sb*32, CN
861 IF NB=0 THEN L=L+1: GOSUB 500
890 RETURN

900 ' DATA for levels, color 11 is undestructible, 11 is 2 hits (11->10), 4 is 3 hits (4->5->7)
901 DATA 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
902 DATA 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0
903 DATA 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0
904 DATA 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0
905 DATA 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0
906 DATA 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0

910 DATA 0, 2, 1, 2, 1, 2, 1, 2, 1, 2, 0
912 DATA 2, 1, 2, 1, 2, 1, 2, 1, 2, 1, 2
913 DATA 1, 2, 1, 2, 1, 2, 1, 2, 1, 2, 1
914 DATA 2, 1, 2, 1, 2, 1, 2, 1, 2, 1, 2
915 DATA 1, 2, 1, 2, 1, 2, 1, 2, 1, 2, 1
916 DATA 0, 1, 2, 1, 2, 1, 2, 1, 2, 1, 0

920 DATA 0,  6,  8,  9, 9,  9,  8, 6,  8,  6,  8, 0
921 DATA 0,  8,  6,  8, 9,  9,  9, 8,  6,  8,  6, 0
922 DATA 0,  6,  8,  6, 8,  9,  9, 9,  8,  6,  8, 0
923 DATA 0,  8,  6,  8, 6,  8,  9, 9,  9,  8,  6, 0
924 DATA 0,  6, 14,  6, 8,  6,  8, 6,  8, 14,  8, 0
925 DATA 0, 14,  4,  4, 4, 5,  5, 11, 4,  4, 14, 0

1000 ' BALL SPRITE
1001 DATA &H38,&H7C,&HFE,&HFE,&HFE,&H7C,&H38,&H00

2020 ' LEFT SPRITE
2030 DATA &H00,&H00,&H00,&H00,&H00,&H00,&H00,&H00
2040 DATA &H00,&H00,&H67,&H67,&H4F,&H4F,&H67,&H67
2050 DATA &H00,&H00,&H00,&H00,&H00,&H00,&H00,&H00
2060 DATA &H00,&H00,&HFF,&HFF,&HFF,&HFF,&HFF,&HFF
2140 ' RIGHT SPRITE
2150 DATA &H00,&H00,&H00,&H00,&H00,&H00,&H00,&H00
2160 DATA &H00,&H00,&HFF,&HFF,&HFF,&HFF,&HFF,&HFF
2170 DATA &H00,&H00,&H00,&H00,&H00,&H00,&H00,&H00
2180 DATA &H00,&H00,&HE6,&HE6,&HF2,&HF2,&HE6,&HE6

3000 ' DRAW THE GRID
3160 FOR K=0 TO 23
3170 FOR I=0 TO 23
3180 if i MOD 2 = k MOD 2 THEN V=0 ELSE V=1
3181 if i=0 OR i=23 THEN V = K MOD 4 + 2
3183 if K=0 THEN V = 6 + I MOD 4
3189 VPOKE &H1800+i+K*32, V
3190 NEXT I
3200 NEXT K
3299 RETURN

4000 ' START SCREEN
4001 CLS
4010 PSET (100,7),0:PRINT#1,"RAFTOID"
4011 PSET (50,100),0:PRINT#1,"press space to start"
4020 A$=input$(1)
4030 if A$=" " GOTO 4050
4040 GOTO 4020
4050 L=1
4060 CLS
4070 GOSUB 7000
4071 GOSUB 3000
4080 GOSUB 500
4090 GOTO 100

7000 ' LOAD TILES
7001 RESTORE 8000
7010 FOR j=0 to 95
7081 READ R$
7090 VPOKE j, VAL("&H"+R$)
7110 VPOKE 2048+j, VAL("&H"+R$)
7130 VPOKE 4096+j, VAL("&H"+R$)
7150 next J
7151 'Now read the colors
7152 FOR j=0 to 95
7153 READ C
7155 VPOKE &H2000+j, C
7156 VPOKE &H2000+2048+j, C
7157 VPOKE &H2000+4096+j, C
7158 NEXT J
7200 RETURN

8000 'TILES PATTERN
8010 DATA E0,8F,0F,1E,1E,3D,30,7D
8020 DATA 7D,7D,70,B8,B0,D0,40,80
8100 DATA 7A,7A,7A,7A,7A,7A,7A,7A,7A,7A,7A,7A,7A,7A,7A,7A
8200 DATA 7E,BF,BF,BF,BF,00,BF,00,BF,00,BF,00,BF,BF,BF,7E
8210 DATA 00,7F,7F,7F,7F,7F,7F,00,00,FE,FE,FE,FE,FE,FE,00
8220 DATA 7A,FA,FA,FA,FA,FA,FA,7A,AE,AF,AF,AF,AF,AF,AF,AE
8230 DATA FF,FF,FF,FF,FF,FF,FF,FF,FF,FF,FF,FF,FF,FF,FF,FF

8300 'COLOR
8500 DATA 65,65,65,65,65,65,65,65
8600 DATA 65,65,65,65,65,65,65,65
8800 DATA 33,33,33,33,33,33,33,33,33,33,33,33,33,33,33,33
8900 DATA 49,35,35,35,35,33,35,33,35,33,35,33,35,35,35,49
8910 DATA 33,33,49,33,33,33,33,33,33,33,49,33,33,33,33,33
8920 DATA 33,33,33,33,33,33,33,33,33,33,33,33,33,33,33,33
8930 DATA 128,128,128,128,128,128,128,128,144,144,144,144,144,144,144,144
