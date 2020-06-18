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
60 FOR S=1 TO 2
61 A$=""
62 FOR I=1 TO 32
63 READ L: A$=A$+CHR$(L)
64 NEXT I
65 SPRITE$(S)=A$
66 NEXT S
75 bx = 100: by = 100: vx = -2: vy = -4
76 x = 90
100 ' GAME LOOP
101 put sprite 0, (bx,by), 15, 0
102 put sprite 1, (x,140), 15, 1
103 put sprite 2, (x+16,140), 15, 2
110 s=stick(0)
111 if s=3 then ax=ax+1
112 if s=7 then ax=ax-1
121 ax=ax*0.9
130 x=x+ax
131 if x<10 then x=10:ax=0
132 if x>170 then x=170:ax=0
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
700 goto 100

900 DATA 0, 6, 8, 6, 8, 6, 8, 6, 8, 6, 8, 0
901 DATA 6, 8, 6, 8, 6, 8, 6, 8, 6, 8, 6, 8
902 DATA 8, 6, 8, 6, 8, 6, 8, 6, 8, 6, 8, 6
903 DATA 6, 8, 6, 8, 6, 8, 6, 8, 6, 8, 6, 8
904 DATA 8, 6, 8, 6, 8, 6, 8, 6, 8, 6, 8, 6
905 DATA 0, 8, 6, 8, 6, 8, 6, 8, 6, 8, 6, 0

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
