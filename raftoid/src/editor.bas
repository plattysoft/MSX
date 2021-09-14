1 color 15,1,1
10 SCREEN 2,2,0
11 BLOAD "editor.sc2",s

20 A$="": RESTORE 6101
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
450 goto 100

600 VPOKE &H1800+sa*2+1+sb*32, VAL(B$)*2+8: VPOKE &H1800+sa*2+2+sb*32, VAL(B$)*2+9
610 RETURN

650 ' BRICK HIT at sa, sb
687 if sb MOD 2 = 0 THEN nc=97+(l MOD 3)*2:cn=96+(l MOD 3)*2 ELSE nc=96+(l MOD 3)*2:cn=97+(l MOD 3)*2
689 VPOKE &H1800+sa*2+1+sb*32, NC: VPOKE &H1800+sa*2+2+sb*32, CN
699 RETURN

800 ' Export level: TODO
820 FOR J=1 TO 13
821   FOR I=0 TO 10
823     READ C
832     IF C > 0 THEN NB=NB+1: VPOKE &H1800+i*2+1+j*32, c*2+8: VPOKE &H1800+i*2+2+j*32, c*2+9
840   NEXT I
841 NEXT J

6100 ' Ball sprite
6101 DATA &HE3,&H80,&H80,&H00,&H00,&H80,&H80,&HE3,&H00,&H00,&H00,&H00,&H00,&H00,&H00,&H00
6120 DATA &HC7,&H01,&H01,&H00,&H00,&H01,&H01,&HC7,&H00,&H00,&H00,&H00,&H00,&H00,&H00,&H00
