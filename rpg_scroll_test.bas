10 COLOR 2, 1, 1
11 call TURBO ON
20 SCREEN 2
100 FOR j=0 to 63
110   READ R
120   VPOKE j, R
121   VPOKE j+2048, R
122   VPOKE j+4096, R
140 NEXT j
150 RESTORE 2040
160 FOR i=0 to 7
165   READ R
170   FOR j=0 to 7
180     VPOKE &H2000+i*8+j, R
181     VPOKE &H2000+2048+i*8+j, R
182     VPOKE &H2000+4096+i*8+j, R
190   NEXT j
195 NEXT i

500 ' MAKE A MAP
510 for y=0 to 23
520   for x=0 to 31
530     VPOKE &H1800+x+y*32, RND(1)*8
540   next x
550 next y

600 s=STICK(0)
610 if s=1 THEN GOSUB 700
620 if s=3 THEN GOSUB 750
630 if s=5 THEN GOSUB 800
640 if s=7 THEN GOSUB 850
690 GOTO 600

700 ' MOVING UP
701 for y=0 to 22
702   for x=0 to 31
703     t = VPEEK (&H1800+x+(y+1)*32)
704     VPOKE &H1800+x+y*32, t
705   next x
706 next y
708 for x=0 to 31
710   VPOKE &H1800+x+23*32, RND(1)*8
711 next x
749 RETURN

750 ' MOVING RIGHT
751 for y=0 to 23
752   for x=0 to 31
753     t = VPEEK (&H1800+x+y*32)
754     VPOKE &H1800+x+y*32, t
755   next x
756 next y
760 RETURN

800 ' MOVING DOWN
801 for y=23 to 1 STEP -1
802   for x=0 to 31
803     t = VPEEK (&H1800+x+(y-1)*32)
804     VPOKE &H1800+x+y*32, t
805   next x
806 next y
808 for x=0 to 31
810   VPOKE &H1800+x, RND(1)*8
811 next x
849 RETURN

850 ' MOVING LEFT
851 for y=0 to 23
852   for x=0 to 31
853     t = VPEEK (&H1800+x+y*32)
854     VPOKE &H1800+x+y*32, t
855   next x
856 next y
860 RETURN

990 goto 990

1000 DATA &Hff, &Hff, &Hbf, &H9f, &H8f, &H87, &H83, &H81
1010 DATA &Hff, &Hff, &Hfd, &Hf9, &Hf1, &He1, &Hc1, &H81
1020 DATA &H81, &H83, &H87, &H8f, &H9f, &Hbf, &Hff, &Hff
1030 DATA &H81, &Hc1, &He1, &Hf1, &Hf9, &Hfd, &Hff, &Hff
	
1040 DATA &H90, &H40, &H00, &H40, &H00, &H10, &H00, &H82
1050 DATA &H90, &H40, &H00, &H40, &H00, &H10, &H00, &H82
1060 DATA &H50, &H20, &H00, &H48, &H20, &H90, &H40, &H40
1070 DATA &H80, &H20, &H80, &H00, &H41, &H00, &H84, &H10

2040 DATA &H45, &H45, &H45, &H45, &H23, &H23, &HAB, &HAB