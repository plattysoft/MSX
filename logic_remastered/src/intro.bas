1 'COLOR 2,1,1
2 'SCREEN 2,2,0
3 'BLOAD "logic_r.sc2",S
4 'BLOAD "sprites.bin",S
10 STRIG(0) ON: STRIG(1) ON

50 SOUND 8,&b00000
60 SOUND 1,0:SOUND 0,0
70 SOUND 11,0
80 SOUND 8,&b11100
90 SOUND 7,&b10111110

100 'Start New Game Screen
100 BLOAD "start.scr",S
101 ON STRIG GOSUB 200, 210
102 PUT SPRITE 0,(0,0),0,0:
110 I=20:J=1:K=4:TR=0:TIME=0
140 IF J=1 THEN I=I+4 ELSE I=I-4
160 PUT SPRITE 1,(8,I),8-TR,K:PUT SPRITE 2,(231,I),8-TR,K
170 K=K+1:IF K=8 THEN K=4
180 IF I=140 THEN J=0:TR=0
181 IF I=20 THEN J=1
185 NT=TIME+5
190 IF TIME<NT GOTO 190
192 A$=INKEY$
197 IF A$="O" THEN run"logic_o.bas"
198 IF A$="R" THEN TR=1
199 IF TIME >=800 GOTO 800 ELSE GOTO 140
200 VPOKE 0,0:VPOKE 1,TR:
201 IF VPEEK(2)=0 THEN run"logic_n.bas" ELSE run"logic_r.bas"
210 VPOKE 0,1:VPOKE 1,TR:run"logic_r.bas

300 'Move left and RIGHT
300 BLOAD "demo.scr",S
301 PUT SPRITE 1,(0,0),0,0:PUT SPRITE 2,(0,0),0,0
302 Y=55
304 VPOKE &H18C2, 28:VPOKE &H18C4, 29:VPOKE &H18A3, 30:VPOKE &H18E3, 31
310 TX=5:TY=0:T$="RIGHT AND LEFT TO MOVE@@":GOSUB 1000 
314 ' Maybe this should be procedurally generated?
314 VPOKE &H18C4, 61
320 FOR I=80 TO 160 STEP 4
321   SOUND 1,&H7:SOUND 0,&HF2:SOUND 12,4:SOUND 13,0
322   IF PS=0 THEN PS=1 ELSE PS=0
323   PUT SPRITE 0,(I,Y),6,PS
324   TIME=0
325   IF TIME<5 GOTO 325
330 NEXT I
331 VPOKE &H18C4, 29
334 TIME=0
335 IF TIME<50 GOTO 335
339 VPOKE &H18C2, 60
340 FOR I=160 TO 120 STEP -4
341   SOUND 1,&H7:SOUND 0,&HF2:SOUND 12,4:SOUND 13,0
342   IF PS=2 THEN PS=3 ELSE PS=2
343   PUT SPRITE 0,(I,Y),6,PS
344   TIME=0
345   IF TIME<5 GOTO 345
350 NEXT I
351 VPOKE &H18C2, 28
400 TX=5:TY=1:T$="UP TO HIGH JUMP@@":GOSUB 1000 
401 ' VPOKE for the stick and SOUND
401 SOUND 1,&H7:SOUND 0,&HF2:SOUND 12,60:SOUND 13,0
402 VPOKE &H18A3, 62
410 FOR VY%=-8 TO 8
411   Y=Y+VY%: VY%=VY%+1
420   PUT SPRITE 0,(120,Y),6,2
434   TIME=0
435   IF TIME<5 GOTO 435
440 NEXT VY%
441 VPOKE &H18A3, 30
450 TX=5:TY=2:T$="DOWN TO LOW JUMP@@":GOSUB 1000 
451 SOUND 1,&H7:SOUND 0,&HF2:SOUND 12,24:SOUND 13,0
452 VPOKE &H18E3, 63
460 FOR VY%=-5 TO 5
461   Y=Y+VY%: VY%=VY%+1
470   PUT SPRITE 0,(120,Y),6,2
484   TIME=0
485   IF TIME<5 GOTO 485
490 NEXT VY%
491 VPOKE &H18E3, 31
500 ' LEFT, MIXED, RIGHT
500 TX=5:TY=3:T$="MOVE IN THE AIR TO GLIDE@@":GOSUB 1000 
501 SOUND 1,&H7:SOUND 0,&HF2:SOUND 12,60
502 X=120:XM=0
503 VPOKE &H18C2, 60:VPOKE &H18A3, 62
505 FOR J=0 TO 2
506   SOUND 13,0
510   FOR VY%=-8 TO 8
511     Y=Y+VY%: VY%=VY%+1
512     IF X<80 AND XM=0 THEN XM=1: VPOKE &H18C4, 61: VPOKE &H18C2, 28
513     IF XM=0 THEN PS=2:X=X-4 ELSE PS=0:X=X+4
520     PUT SPRITE 0,(X,Y),6,PS
534     TIME=0
535     IF TIME<5 GOTO 535
540   NEXT VY%
545 NEXT J
546 VPOKE &H18C4, 29:VPOKE &H18A3, 30
550 ' Walk off screen?
554 VPOKE &H18C4, 61
560 FOR I=X TO 234 STEP 4
561   SOUND 1,&H7:SOUND 0,&HF2:SOUND 12,4:SOUND 13,0
562   IF PS=0 THEN PS=1 ELSE PS=0
563   PUT SPRITE 0,(I,Y),6,PS
564   TIME=0
565   IF TIME<5 GOTO 565
570 NEXT I
581 VPOKE &H18C4, 29
590 PUT SPRITE 0,(0,0),0,0
600 IF TIME<100 GOTO 600
610 GOTO 100

800 'INTRO TEXT
800 ON STRIG GOSUB 990,990
815 BLOAD "cls.scr",S
816 PUT SPRITE 0,(0,0),0,0:PUT SPRITE 1,(0,0),0,0:PUT SPRITE 2,(0,0),0,0
851 TIME=0
852 TX=0:TY=0:T$="BEGIN BOOTING SEQUENCE\":GOSUB 1000 
853 TX=1:TY=1:T$="LOCATION@@[@[@[@[@ UNKNOWN@":GOSUB 1000
854 TX=1:TY=2:T$="COMM LINK@@[@[@[@ OFFLINE@":GOSUB 1000
855 TX=1:TY=3:T$="DIRECTIVE@@[@[@[@ GET OUT@":GOSUB 1000

860 TX=0:TY=5:T$="@LOGIC HAS A MISSION AND":GOSUB 1000
865 TX=0:TY=6:T$="NOT MUCH OF A CHOICE[@":GOSUB 1000

870 TX=0:TY=8:T$="@THIS MAY BE THE PGD_` TEST":GOSUB 1000
871 TX=1:TY=9:T$="PLANNERS AND GOAL DRIVEN DROIDS@":GOSUB 1000
872 TX=1:TY=10:T$="LEVEL `@":GOSUB 1000

880 TX=0:TY=12:T$="@THE CLOSEST THING TO A PROMOTION@":GOSUB 1000
881 TX=0:TY=13:T$="APPLY SEEMED A GOOD IDEA@":GOSUB 1000
882 TX=0:TY=14:T$="NOT SO MUCH NOW[@@":GOSUB 1000

890 TX=0:TY=16:T$="@THIS MIGHT BE THE TEST SCENARIO@":GOSUB 1000
891 TX=0:TY=17:T$="IT LOOKS DEADLY ALL THE SAME[@":GOSUB 1000

910 TX=0:TY=19:T$="@LOGIC IS DETERMINED TO SUCCEED":GOSUB 1000
920 TX=0:TY=20:T$="THROUGH BLOOD @SWEAT @AND TEARS[@":GOSUB 1000
930 TX=0:TY=22:T$="@IF ONLY ROBOTS HAD SUCH FLUIDS[":GOSUB 1000
940 ' Previous line is as long as the screen and it is the last place for text.

977 TIME=0
978 IF TIME<100 GOTO 978
979 GOTO 300

990 RETURN 100

1000 'Writing text on Screen subroutine
1000 SOUND 1,&H0:SOUND 0,&H78:SOUND 12,2
1010 FOR I=1 TO LEN(T$)
1020   CT$=MID$(T$,i,1)
1030   IF CT$="@" THEN TW=10:TX=TX-1:GOTO 1044 ELSE TW=1
1040   VPOKE &H1800+TX-1+TY*32+I,ASC(CT$)+159:SOUND 13,0
1044   TIME=0
1045   IF TIME<TW GOTO 1045
1050 NEXT I
1090 RETURN
