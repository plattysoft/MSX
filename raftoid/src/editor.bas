12 DEFINT A-Z
13 OPEN "RAFTOID.BLD" FOR APPEND AS #1: CLOSE #1
14 DIM LN$(10):

70 GOTO 2000

90 BLOAD "editor.scr",S
91 x=8:y=8:sa=0:sb=1
92 GOSUB 700

100 ' MAIN LOOP
100 S=STICK(0)

110 IF TIME<10 GOTO 300
120 IF S<>0 THEN TIME=0

210 if s=1 AND y>8 then y=y-8:sb=sb-1
230 if s=3 and x<168 then x=x+16:sa=sa+1
250 if s=5 AND y<104 then y=y+8:sb=sb+1
270 if s=7 and x>8 then x=x-16:sa=sa-1

300 put sprite 1, (x,y-1), 15, 14

430 B$=inkey$
440 if B$="0" THEN GOSUB 650
441 if B$>="1" AND B$<="9" THEN GOSUB 600
450 IF B$="S" GOTO 800
451 IF B$="B" GOTO 2000
500 goto 100

600 VPOKE &H1800+sa*2+1+sb*32, VAL(B$)*2+8: VPOKE &H1800+sa*2+2+sb*32, VAL(B$)*2+9
610 RETURN

650 ' DELETE A BRICK
687 if sb MOD 2 = 0 THEN nc=97+(l MOD 3)*2:cn=96+(l MOD 3)*2 ELSE nc=96+(l MOD 3)*2:cn=97+(l MOD 3)*2
689 VPOKE &H1800+sa*2+1+sb*32, NC: VPOKE &H1800+sa*2+2+sb*32, CN
699 RETURN

700 ' Import level
710 OPEN LN$(CL) FOR INPUT AS #1
720 FOR J=&H1820 TO &H19A0 STEP &H20
730   FOR I=1 TO 21 STEP 2
740     INPUT #1, C
750     IF C>0 THEN VPOKE j+i,c*2+8:VPOKE j+i+1,c*2+9
760   NEXT I
770 NEXT J
780 CLOSE #1
790 RETURN

800 ' Export level
810 OPEN LN$(CL) FOR OUTPUT AS #1
820 FOR J=&H1820 TO &H19A0 STEP &H20
821   FOR I=1 TO 21 STEP 2
822     C=(VPEEK(J+I)-8)/2
823     IF C>9 THEN C=0
830     PRINT #1, C;
840   NEXT I
845   PRINT #1, ""
850 NEXT J
860 CLOSE #1
870 GOTO 2000

900 ' Create empty level
910 OPEN LN$(CL) FOR OUTPUT AS #1
920 FOR J=0 TO 13
921   FOR I=0 TO 11
930     PRINT #1, 0;
940   NEXT I
945   PRINT #1, ""
950 NEXT J
960 CLOSE #1
990 RETURN

2000 ' Editor level selection
2000 BLOAD "editmenu.scr",s
2011 OPEN "RAFTOID.BLD" FOR INPUT AS #1
2012 CL=0
2020 ' Read 10 levels or until EOF
2030 IF EOF(1) GOTO 2100
2040 INPUT #1, LN$(CL)
2045 TX=2:TY=CL+11:T$=LN$(CL):GOSUB 9090
2050 CL=CL+1
2060 IF CL<10 GOTO 2030
2100 CLOSE #1
2120 SS=0: Y=88: OY=80
2200 ' TODO Use cursors to select
2200 B$=inkey$

2210 S=STICK(0)
2211 PUT SPRITE 1, (16,y-1), 3, 15
2220 IF S<>0 AND SS=S GOTO 2210 
2230 SS=S
2240 IF S=1 AND Y>88 THEN Y=Y-8
2250 IF S=5 AND Y<160 THEN Y=Y+8
2260 IF S=3 THEN GOTO 3000
2360 GOTO 2200

3000 'OPTIONS MENU
3010 IF STRIG(0) OR STRIG(1) GOTO 3400
3210 S=STICK(0)
3211 PUT SPRITE 1, (152,OY-1), 3, 15
3220 IF S<>0 AND SS=S GOTO 3000 
3230 SS=S
3240 IF S=1 AND OY>80 THEN OY=OY-16: IF OY=144 THEN OY=128
3250 IF S=5 AND OY<176 THEN OY=OY+16: IF OY=144 THEN OY=160
3260 IF S=7 THEN GOTO 2200
3300 GOTO 3000

3400 'EDIT
3400 IF OY=80 THEN CL=(Y-88)/8: GOTO 90
3410 'PLAYTEST
3410 IF OY=96 GOTO 3000
3420 'DELETE
3420 IF OY=112 GOTO 3600
3430 'NEW
3430 IF OY=128 THEN CL=(Y-88)/8:LN$(CL)="STAGE_"+CHR$(CL+48)+".LVL":GOSUB 8000:GOSUB 900:GOTO 90
3440 'PLAY ALL: A flag was set when we launched editor, just run raftoid.bas
3440 IF OY=160 GOTO RUN "raftoid.bas"
3450 'BACK
3440 IF OY=176 THEN RUN "start.bas"
3450 GOTO 3000

8000 ' SAVE LIST OF LEVELS TO FILE
8000 OPEN "RAFTOID.BLD" FOR OUTPUT AS #1
8010 FOR I=0 TO 9
8020  PRINT #1, LN$(I)
8030 NEXT I
8090 CLOSE #1
8099 RETURN

9090 ' PRINT TEXT ON SCREEN
9090 FOR i=1 to LEN(T$)
9091   CT$=MID$(T$,i,1)
9092   VPOKE &H1800+tx+ty*32+i,ASC(CT$)
9093 NEXT I
9094 RETURN
