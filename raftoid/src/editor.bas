1 color 15,1,1
10 SCREEN 2,2,0
11 BLOAD "editor.sc2",s

12 DEFINT A-Z

20 A$=""
30 FOR I=1 TO 32
40   READ L: A$=A$+CHR$(L)
50 NEXT I
60 SPRITE$(0)=A$

90 x=8:y=8:sa=0:sb=1

100 ' MAIN LOOP
100 S=STICK(0)

110 IF TIME<10 GOTO 300
120 IF S<>0 THEN TIME=0

210 if s=1 AND y>8 then y=y-8:sb=sb-1
230 if s=3 and x<168 then x=x+16:sa=sa+1
250 if s=5 AND y<112 then y=y+8:sb=sb+1
270 if s=7 and x>8 then x=x-16:sa=sa-1

300 put sprite 1, (x,y-1), 15, 0

430 B$=inkey$
440 if B$="0" THEN GOSUB 650
441 if B$>="1" AND B$<="9" THEN GOSUB 600
450 IF B$="S" GOTO 800
500 goto 100

600 VPOKE &H1800+sa*2+1+sb*32, VAL(B$)*2+8: VPOKE &H1800+sa*2+2+sb*32, VAL(B$)*2+9
610 RETURN

650 ' DELETE A BRICK
687 if sb MOD 2 = 0 THEN nc=97+(l MOD 3)*2:cn=96+(l MOD 3)*2 ELSE nc=96+(l MOD 3)*2:cn=97+(l MOD 3)*2
689 VPOKE &H1800+sa*2+1+sb*32, NC: VPOKE &H1800+sa*2+2+sb*32, CN
699 RETURN

800 ' Export level
810 OPEN "BUILD.LVL" FOR OUTPUT AS #1
820 FOR J=1 TO 13
821   FOR I=0 TO 10
822     C=(VPEEK(&H1800+I*2+1+J*32)-8)/2
823     IF C>9 THEN C=0
830     PRINT #1, C;
840   NEXT I
845   PRINT #1, ""
850 NEXT J
860 CLOSE

1000 DATA &HE3,&H80,&H80,&H00,&H00,&H80,&H80,&HE3,&H00,&H00,&H00,&H00,&H00,&H00,&H00,&H00
1010 DATA &HC7,&H01,&H01,&H00,&H00,&H01,&H01,&HC7,&H00,&H00,&H00,&H00,&H00,&H00,&H00,&H00
