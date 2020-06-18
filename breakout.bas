1 SCREEN 2, 2
10 ' INIT BRICK GRID
11 DIM A(12,19): C = 6
12 LINE (9,9)-(202, 160),11, B
20 FOR J=1 TO 6
21 FOR I=0 TO 11
23 READ C
30 A(I,J)=C
31 LINE (10+I*16, 10+J*8)-(25+I*16, 17+J*8), C, BF
40 NEXT I
41 NEXT J
49 ' LOAD SPRITES
50 FOR I=1 TO 8
51 READ L: A$=A$+CHR$(L)
52 NEXT
53 SPRITE$(0)=A$
54 A$=""
60 FOR I=1 TO 32
61 READ L: A$=A$+CHR$(L)
62 NEXT
63 SPRITE$(1)=A$
75 bx = 100: by = 100: vx = -2: vy = -4
76 x = 90
80 put sprite 0, (bx,by), 15, 0
81 put sprite 1, (x,140), 15, 1
90 s=stick(0)
110 if s=3 then ax=ax+1
120 if s=7 then ax=ax-1
121 ax=ax*0.9
130 x=x+ax
140 by=by+vy
150 bx=bx+vx
300 if bx > 196 THEN bx = 196: vx = -vx
310 if bx < 10 THEN bx = 10: vx = -vx
320 if by > 152 THEN by = 152: vy = -vy
330 if by < 10 THEN by = 10: vy = -vy
400 ' BOUNDING BOX COLISION DETECTION
410 if vx>0 THEN sa=(bx-3)\16 ELSE sa=(bx-10)\16
411 sb=(by-6)\8
412 if a(sa, sb) > 0 THEN a(sa, sb) = 0: LINE (10+sa*16, 10+sb*8)-(25+sa*16, 17+sb*8), 4, BF: vx=-vx
415 if vy>0 THEN sb=(by-3)\8 ELSE sb=(by-10)\8
416 sa=(bx-6)\16
420 if a(sa, sb) > 0 THEN a(sa, sb) = 0: LINE (10+sa*16, 10+sb*8)-(25+sa*16, 17+sb*8), 4, BF: vy=-vy
700 goto 80

900 DATA 0, 6, 8, 6, 8, 6, 8, 6, 8, 6, 8, 0
901 DATA 6, 8, 6, 8, 6, 8, 6, 8, 6, 8, 6, 8
902 DATA 8, 6, 8, 6, 8, 6, 8, 6, 8, 6, 8, 6
903 DATA 6, 8, 6, 8, 6, 8, 6, 8, 6, 8, 6, 8
904 DATA 8, 6, 8, 6, 8, 6, 8, 6, 8, 6, 8, 6
905 DATA 0, 8, 6, 8, 6, 8, 6, 8, 6, 8, 6, 0

1000 ' BALL SPRITE
1001 DATA &H38,&H7C,&HFE,&HFE,&HFE,&H7C,&H38,&H00

1030 ' PADDLE SPRITE
1031 DATA &H00,&H00,&H00,&H00,&H00,&H00,&H00,&H00
1032 DATA &H00,&H00,&H00,&H00,&H7F,&HFF,&HFF,&H7F
1033 DATA &H00,&H00,&H00,&H00,&H00,&H00,&H00,&H00
1034 DATA &H00,&H00,&H00,&H00,&HFE,&HFF,&HFF,&HFE
