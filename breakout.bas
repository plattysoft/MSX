1 color 15,1,1
2 SCREEN 2, 2
3 ' TODO: make the ball smaller
4 ' TODO: Initial screen
5 ' TODO: Game over animation + lives
6 ' TODO: WIN animation and next screen
7 ' TODO: Consider tiles for better looking bricks
10 ' INIT BRICK GRID
12 LINE (15,7)-(208, 160),2, B
17 L=1
40 GOSUB 500
50 GOSUB 600
75 bx = 100: by = 100: vx = 0: vy = 4
76 x = 90
100 ' GAME LOOP
110 s=stick(0)
111 if s=3 then ax=ax+0.5
112 if s=7 then ax=ax-0.5
121 ax=ax*0.9
130 x=x+ax
131 if x<16 then x=16:ax=0
132 if x>176 then x=176:ax=0
140 by=by+vy
150 bx=bx+vx
300 if bx > 202 THEN bx = 202: vx = -vx
310 if bx < 16 THEN bx = 16: vx = -vx
320 'if by > 152 THEN by = 152: vy = -vy
321 if by>160 THEN goto 800
330 if by<8 THEN by = 8: vy = -vy
361 put sprite 0, (bx,by), 15, 0
362 put sprite 1, (x,140), 15, 1
363 put sprite 2, (x+16,140), 15, 2 
400 ' BOUNDING BOX COLISION DETECTION
410 if vx>0 THEN sa=(bx+6) ELSE sa=(bx-1)
411 sb=(by+3)
412 if POINT(sa,sb)>3 THEN vx=-vx: GOSUB 850
415 if vy>0 THEN sb=(by+6) ELSE sb=(by-1)
416 sa=(bx+3)
420 if POINT(sa,sb)>3 THEN vy=-vy: GOSUB 850
450 if by>138 AND by<150 AND bx>x-7 AND bx<x+32 then GOSUB 700

490 goto 100

500 ' LOAD AND DRAW LEVEL
518 if L = 1 then restore 900 else restore 910
520 FOR J=1 TO 6
521   FOR I=0 TO 11
523     READ C
531     LINE (16+I*16, 8+J*8)-(31+I*16, 15+J*8), C, BF
540   NEXT I
541 NEXT J
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
801 END

850 ' BRICK HIT at sa, sb 
851 bc=POINT(sa,sb): nc=1
852 if bc=14 THEN RETURN ' UNDESTRUCTIBLE BRICK
853 if bc=11 THEN nc=10
854 if bc=4  THEN nc=5
855 if bc=5  THEN nc=7
860 LINE ((sa\16)*16, (sb\8)*8)-((sa\16)*16+15, 7+(sb\8)*8), nc, BF: 
890 RETURN

899 ' DATA for levels, color 11 is undestructible, 11 is 2 hits (11->10), 4 is 3 hits (4->5->7)
900 DATA 0, 6, 8, 6, 8, 6, 8, 6, 8, 6, 8, 0
901 DATA 6, 8, 6, 8, 6, 8, 6, 8, 6, 8, 6, 8
902 DATA 8, 6, 8, 6, 8, 6, 8, 6, 8, 6, 8, 6
903 DATA 6, 8, 6, 8, 6, 8, 6, 8, 6, 8, 6, 8
904 DATA 8, 6, 8, 6, 8, 6, 8, 6, 8, 6, 8, 6
905 DATA 0, 8, 6, 8, 6, 8, 6, 8, 6, 8, 6, 0

910 DATA 0,  6,  8,  9, 9,  9,  8, 6,  8,  6,  8, 0
911 DATA 0,  8,  6,  8, 9,  9,  9, 8,  6,  8,  6, 0
912 DATA 0,  6,  8,  6, 8,  9,  9, 9,  8,  6,  8, 0
913 DATA 0,  8,  6,  8, 6,  8,  9, 9,  9,  8,  6, 0
914 DATA 0,  6, 14,  6, 8,  6,  8, 6,  8, 14,  8, 0
915 DATA 0, 14,  4,  4, 4, 5,  5, 11, 4,  4, 14, 0

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
