10 'On & Off
13 'MsxPenEdit
16 'Kirem 14/02/2022
17 'Concurso  Msx Basic 9a 2022
20 CLEAR 5000:DEFINT A-Z
30 SCREEN1,1:WIDTH32:KEYOFF:COLOR 15,0,0
50 GOSUB2440:'Sprite
60 GOSUB2580:'Load char
70 GOSUB 1130:'Story
80 PX=0:PY=0:SM=0:FS=0:BT=0:PL=1:PC=1:SL=PL:SC=PC:VI=2:LL=1:DF=2
90 GOSUB590:'Title
100 GOSUB 1850:'Create lvl
110 VPOKE BASE(6)+28,&HFE:'Blanc/Gris
120 VPOKE BASE(6)+29,&HF0:'Blanc/Noir Trap
130 GOSUB 330:'Intro Niveau
140 S=STICK(0) or STICK(1)
150 IF S=1 AND SM=0 THEN PY=PY-16:SM=1:PL=PL-1:PLAY"l8g":GOTO200
160 IF S=5 AND SM=0 THEN PY=PY+16:PL=PL+1:SM=1:PLAY"l8a":GOTO200
170 IF S=3 AND SM=0 THEN PX=PX+16:SM=1:PC=PC+1:PLAY"l8c":GOTO200
180 IF S=7 AND SM=0 THEN PX=PX-16:SM=1:PC=PC-1:PLAY"l8d":GOTO200
190 IF S=0 THEN SM=0:GOTO250
200 IF PX<0 OR PX>MX THEN PX=SX:PC=SC:GOTO250
210 IF PY<0 OR PY>MY THEN PY=SY:PL=SL:GOTO250
220 IF LI(PL,PC)<2 THEN 250:'move ok
230 IF LI(PL,PC)=2 THEN 1710 :'win
240 IF LI(PL,PC)=3 THEN 1290 :'-1 life
250 SX=PX:SY=PY:SC=PC:SL=PL
260 PUT SPRITE 0,(PX,PY),12,FS:PUT SPRITE 1,(X2,Y2),13,FS
270 IF LI(PL,PC)=5 THEN 2340 :'Light
280 BT=BT+1:'Time for form sprite
290 IF BT>8 THEN BT=0:FS=FS+1
300 IF FS=2 THEN FS=0
310 GOTO140
320 'levelStart
330 X2=PX:Y2=PY
340 PUT SPRITE 5,(CX,CY),10,4
350 TIME=0
360 LOCATE23,21:PRINT"Light On "
370 FOR F=0TO3
380 LOCATE10,22:PRINT"Look ";3-F;"s"
390 IF TIME<60 THEN 390 ELSE TIME=0
400 NEXT
410 PUT SPRITE 1,(X2,Y2),13,0
420 LOCATE10,22:PRINT"Easy,Look"
430 TIME=0
440 IF TIME<60 THEN 440
450 FOR F=1 TO LEN(LV$)
460 V$=MID$(LV$,F,1)
470 IF V$="g" THEN Y2=Y2-16:PLAY"l8g":GOTO510
480 IF V$="c" THEN X2=X2+16:PLAY"l8c":GOTO510
490 IF V$="a" THEN Y2=Y2+16:PLAY"l8a":GOTO510
500 IF V$="d" THEN X2=X2-16:PLAY"l8d":GOTO510
510 PUT SPRITE 1,(X2,Y2),13,0
520 IF PLAY(0) THEN 520
530 NEXT
540 LOCATE0,21:PRINT"Lifes";VI
550 LOCATE10,22:PRINT"         "
560 VPOKE BASE(6)+28,&HF0:'Blanc/Noir
570 LOCATE23,21:PRINT"Light Off"
580 RETURN
590 CLS
600 LOCATE13,3:PRINT"ON&OFF"
610 LOCATE15,8:PRINT"By":LOCATE13,13:PRINT"Kirem":LOCATE14,15:PRINT"For":LOCATE1,17:PRINT"Concurso MSX-Basic 9a edicion":LOCATE11,22:PRINT"Press Fire"
620 TIME=0
630 IF TIME<720 THEN 660
640 GOSUB 1130
650 GOTO 590
660 IF NOT (STRIG(0) or strig(1)) THEN 630
670 IF (STRIG(0)orstrig(1)) THEN 670
680 'GOSUB 1180
690 CLS:LOCATE8,0:PRINT"Select Difficulty"
700 LOCATE4,6:PRINT"Easy":LOCATE4,12:PRINT"Medium":LOCATE4,18:PRINT"Hard"
710 S=STICK(0) or stick(1)
720 IF (STICK(0) or stick(1)) THEN 720
730 IF S=1 THEN DF=DF-1 ELSE IF S=5 THEN DF=DF+1
740 IF DF=0 THEN DF=1
750 IF DF=4 THEN DF=3
760 PUT SPRITE 5,(0,48*DF),10,4
770 IF NOT (STRIG(0)or strig(1)) THEN 710
780 IF (STRIG(0)or strig(1)) THEN 780
790 VI=VI+DF
800 IF DF=1 THEN RESTORE2910 ELSEIF DF=2 THEN RESTORE 3030 ELSEIF DF=3 THEN RESTORE 3150
810 READ LM
820 CLS:LOCATE10,0:PRINT"How To Play"
830 PUT SPRITE 0,(0,48),12,0
840 LOCATE4,7:PRINT"Move with cursor key"
850 VPOKE BASE(6)+30,&HF5:'Blanc/Bleu Start
860 LOCATE0,9:PRINTCHR$(244)+CHR$(245):PRINTCHR$(246)+CHR$(247)+"  Start"
870 VPOKE BASE(6)+24,&HF8:'Blanc/Rouge Goal
880 LOCATE0,12:PRINTCHR$(194)+CHR$(195):PRINTCHR$(196)+CHR$(197)+"  Goal"
890 VPOKE BASE(6)+28,&HFE:'Blanc/Gris Ground
900 LOCATE0,15:PRINTCHR$(224)+CHR$(225):PRINTCHR$(226)+CHR$(227)+"  Ground"
910 PUT SPRITE 5,(0,144),10,4
920 LOCATE4,19:PRINT"Bonus Light";1*DF;"s"
930 LOCATE11,22:PRINT"Press Fire"
940 GOSUB 1670
950 PUT SPRITE 0,(256,212),12,0
960 PUT SPRITE 5,(256,212),10,4
970 CLS
980 RETURN
990 'Win
1000 PUT SPRITE 5,(256,212),10,4:CLS:LOCATE12,0:PRINT"Well Done"
1010 LOCATE10,3:PRINT"On & Off are free.":LOCATE3,5:PRINT"And returned to their planet"
1020 LOCATE12,10:PRINT"Game Over":LOCATE12,19:PRINT"Press fire"
1030 PUT SPRITE 0,(104,176),12,FS:PUT SPRITE 1,(136,176),13,FS:PUTSPRITE3,(120,160),8,3
1040 GOSUB 1670
1050 CLS:PUTSPRITE3,(255,191),8,3
1060 F=176
1070 F=F-2
1080 PUT SPRITE 0,(104,F),12,FS:PUT SPRITE 1,(136,F),13,FS
1090 IF F>0 THEN 1070
1100 PUT SPRITE 0,(255,191),12,FS:PUT SPRITE 1,(255,191),13,FS
1110 GOTO80
1120 'Intro
1130 CLS:LOCATE10,0:PRINT"Roswell 1947"
1140 LOCATE5,3:PRINT"On & Off a young couple,":LOCATE5,5:PRINT"on a bridal trip."
1150 LOCATE2,7:PRINT"But a slight incident occurs."
1160 TIME=0
1170 IF TIME<90 THEN 1170
1180 F=0
1190 F=F+1
1200 PUT SPRITE 0,(104,F),12,0:PUT SPRITE 1,(136,F),13,0
1210 IF F<175 THEN 1190
1220 LOCATE2,9:PRINT"In short they are captured.":LOCATE2,11:PRINT"But 75 years later it's time":LOCATE2,13:PRINT"to escape."
1230 LOCATE13,21:PRINT"On  Off"
1240 TIME=0
1250 IF TIME<240 THEN 1250
1260 PUT SPRITE 0,(255,191),12,0:PUT SPRITE 1,(255,191),13,0
1270 RETURN
1280 'Gestion life
1290 VI=VI-1
1300 IF VI=0 THEN 1450 ELSE 1310
1310 PY=MY+16
1320 PUT SPRITE 0,(PX,PY),12,FS
1330 PY=PY+1
1340 IF PY<212 THEN 1320
1350 LOCATE0,21:PRINT"Lifes";VI:LOCATE23,21:PRINT"Light On ":PUTSPRITE 5,(CX,CY),10,4
1360 VPOKE BASE(6)+28,&HFE:'Blanc/Gris
1370 TIME=0
1380 IF TIME<(60*DF)THEN 1380
1390 VPOKE BASE(6)+28,&HF0:'Blanc/Noir
1400 LOCATE23,21:PRINT"Light Off"
1410 PX=0:PY=0:SM=0:FS=0:BT=0:PL=1:PC=1:SL=PL:SC=PC
1420 PX=(DX)*16:PY=(DY)*16:SC=DX:SL=DY:PC=DX:PL=DY
1430 LI(CL,CC)=5:'HeartorThunder
1440 GOTO 140
1450 BEEP:PY=MY+16
1460 LOCATE0,21:PRINT"Lifes";VI:LOCATE23,21:PRINT"Light On "
1470 VPOKE BASE(6)+28,&HFE:'Blanc/Gris
1480 PUT SPRITE 1,(256,212),12,FS:PUTSPRITE 5,(256,212),10,4
1490 PUT SPRITE 0,(PX,PY),12,FS
1500 PY=PY+2:PRINT
1510 IF PY<168 THEN 1490
1520 IF NY>=8 THEN FOR F=0TO20:PRINT:NEXT
1530 LOCATE0,23:PRINT"###############################";
1540 PUT SPRITE 0,(PX,PY),12,FS
1550 PY=PY+2
1560 IF PY<176 THEN 1540
1570 PUT SPRITE 0,(PX,PY),12,2
1580 TIME=0
1590 IF TIME<20 THEN 1590
1600 LOCATE 10,3:PRINT"GAME OVER"
1610 LOCATE 9,9:PRINT"Levels";LL;"/";LM
1620 LOCATE 10,15:PRINT"Press Fire"
1630 GOSUB 1670
1640 PUT SPRITE 0,(256,212),12,2
1650 ERASE LI
1660 GOTO 80
1670 IF NOT (STRIG(0) or strig(1)) THEN 1670
1680 IF (STRIG(0) or strig(1)) THEN 1680
1690 RETURN
1700 'Level end
1710 LOCATE 10,20:PRINT"Good"
1720 PUT SPRITE 0,(PX,PY),12,FS
1730 BEEP
1740 LOCATE23,21:PRINT"Light On "
1750 VPOKE BASE(6)+28,&HFE:'Blanc/Gris
1760 PX=0:PY=0:SM=0:FS=0:BT=0:PL=1:PC=1:SL=PL:SC=PC:LL=LL+1:ERASE LI
1770 IF LL>LM THEN 1000
1780 LOCATE0,22:PRINT"                              ":LOCATE 10,22:PRINT "Press Fire"
1790 GOSUB 1670
1800 PUT SPRITE 0,(256,212),12,FS:PUT SPRITE 1,(256,212),13,FS
1810 PUT SPRITE 5,(256,212),10,4
1820 CLS
1830 GOTO100
1840 'Creation Level
1850 R=RND(-TIME)
1860 LOCATE 9,21:PRINT"Levels";LL;"/";LM:LOCATE 10,22:PRINT "Please wait":LOCATE0,0
1870 VPOKE BASE(6)+28,&H0:'Blanc/Noir Dalle
1880 VPOKE BASE(6)+29,&H0:'Noir/noir Trap
1890 VPOKE BASE(6)+30,&H0:'Noir/noir Start
1900 VPOKE BASE(6)+24,&H0:'Noir/noir Goal
1910 READ NX,NY,DX,DY,FX,FY,CC,CL,NP,LV$
1920 DIM LI(NY,NX)
1930 TX=DX:TY=DY:PL=DY:PC=DX
1940 FOR F=1TOLEN(LV$)
1950 LI(TY,TX)=1
1960 V$=MID$(LV$,F,1)
1970 IF V$="g" THEN TY=TY-1:GOTO2010
1980 IF V$="c" THEN TX=TX+1:GOTO2010
1990 IF V$="a" THEN TY=TY+1:GOTO2010
2000 IF V$="d" THEN TX=TX-1:GOTO2010
2010 NEXT
2020 LI(DY,DX)=4:'Start
2030 LI(TY,TX)=2:'Goal
2040 LI(CL,CC)=5:'HeartorThunder
2050 IF DF=3 THEN 2140:'lvl hard
2060 FOR F=1TO NP
2070 RX=INT(RND(1)*10)
2080 IF RX>NX THEN 2070
2090 RY=INT(RND(1)*10)
2100 IF RY>NY THEN 2090
2110 IF LI(RY,RX)=0 THEN LI(RY,RX)=3 ELSE 2070
2120 NEXT
2130 GOTO 2180
2140 FORG=0TONY
2150 FORF=0TONX
2160 IF LI(G,F)=0 THEN LI(G,F)=3
2170 NEXT:NEXT
2180 FORG=0TO NY
2190 FOR F=0TONX
2200 IF LI(G,F)=3 THEN PRINT CHR$(234)+CHR$(235); ELSE IF LI(G,F)=4 THEN PRINT CHR$(244)+CHR$(245); ELSE IF LI(G,F)=2 THEN PRINT CHR$(194)+CHR$(195); ELSE PRINT CHR$(224)+CHR$(225);
2210 NEXT:PRINT
2220 FORF=0TONX
2230 IF LI(G,F)=3 THEN PRINT CHR$(236)+CHR$(237); ELSE IF LI(G,F)=4 THEN PRINT CHR$(246)+CHR$(247); ELSE IF LI(G,F)=2 THEN PRINT CHR$(196)+CHR$(197);ELSE PRINT CHR$(226)+CHR$(227);
2240 NEXT:PRINT:NEXTG
2250 PX=(DX)*16:PY=(DY)*16:SC=DX:SL=DY:PC=DX:PL=DY:CX=16*CC:CY=16*CL
2260 MX=NX*16:MY=(NY)*16
2270 LOCATE9,21:PRINT"                      ":LOCATE 10,22:PRINT "           ":LOCATE0,0
2280 VPOKE BASE(6)+28,&HFE:'Blanc/Gris Ground
2290 VPOKE BASE(6)+29,&HF0:'blanc/noir Trap
2300 VPOKE BASE(6)+30,&HF5:'Blanc/vert Start
2310 VPOKE BASE(6)+24,&HF8:'Noir/vert Goal
2320 RETURN
2330 'Thunder collected
2340 LI(CL,CC)=0:'No Thunder
2350 PUT SPRITE 5,(256,212),10,4
2360 LOCATE23,21:PRINT"Light On "
2370 VPOKE BASE(6)+28,&HFE:'Blanc/Gris
2380 TIME=0
2390 IF TIME<(60*DF)THEN 2390
2400 VPOKE BASE(6)+28,&HF0:'Blanc/Noir
2410 LOCATE23,21:PRINT"Light Off"
2420 GOTO280
2430 'Creation sprite
2440 FORJ=0TO4:A$="":B$=""
2450 FORI=0TO7
2460 READ A$:B$=B$+CHR$(VAL(A$))
2470 SPRITE$(J)=B$
2480 NEXTI:NEXTJ
2490 RETURN
2500 'Sprites
2510 DATA&h7e,&hdb,&hff,&h24,&hff,&h3c,&h66,&ha5:'anim1
2520 DATA&h00,&h7e,&hdb,&hff,&h24,&hff,&h3c,&h66:'anim2
2530 DATA&h91,&h83,&h3c,&h7e,&hdb,&hff,&h24,&hbd:'dead
2540 DATA&h66,&he7,&hff,&hff,&h7e,&h7e,&h3c,&h18:'heart
2550 DATA&h06,&h0c,&h18,&h3e,&h7c,&h18,&h30,&h60:'thunder
2560 END
2570 '********** Creation Tiles *********************
2580 RESTORE 2690:READ NT:'Numbers tiles
2590 FOR G%=1TO NT
2600 READ NC:'Tiles Number
2610 FORF%=0TO7
2620 READ A:'Read Tiles
2630 VPOKEBASE(7)+NC*8+F%,A
2640 NEXT
2650 NEXT
2660 'VPOKE BASE(6)+AS/8,&H0:REM COLOR INVISIBLE
2670 RETURN:'GOTO90
2680 'data charactere,1er nb,numero ascii
2690 DATA18:'nombre de tiles
2700 DATA 244,255,128,128,128,128,128,128,128
2710 DATA 245,255,1,1,1,1,1,1,1
2720 DATA 246,128,128,128,128,128,128,128,255
2730 DATA 247,1,1,1,1,1,1,1,255
2740 DATA 224,255,128,128,128,128,128,128,128
2750 DATA 225,255,1,1,1,1,1,1,1
2760 DATA 226,128,128,128,128,128,128,128,255
2770 DATA 227,1,1,1,1,1,1,1,255
2780 DATA 234,255,128,128,128,128,128,128,128
2790 DATA 235,255,1,1,1,1,1,1,1
2800 DATA 236,128,128,128,128,128,128,128,255
2810 DATA 237,1,1,1,1,1,1,1,255
2820 DATA 192,32,32,32,255,4,4,4,255
2830 DATA 35,24,60,90,24,24,24,24,255
2840 DATA 194,255,128,128,128,128,128,128,128
2850 DATA 195,255,1,1,1,1,1,1,1
2860 DATA 196,128,128,128,128,128,128,128,255
2870 DATA 197,1,1,1,1,1,1,1,255
2890 'Level Max 15X10Y (0-14X0-9Y)
2900 'Easy lvl
2910 DATA 10
2920 DATA 3,1,0,0,3,1,1,1,2,"ccac"
2930 DATA 3,2,0,0,3,2,2,1,2,"caacc"
2940 DATA 2,3,1,0,0,3,0,2,2,"caadad"
2950 DATA 3,3,3,0,0,3,1,0,3,"addada"
2960 DATA 3,3,0,2,3,3,0,0,3,"acgggccaaa"
2970 DATA 3,3,0,0,0,3,3,3,3,"cccaadadd"
2980 DATA 3,3,3,2,2,0,0,3,3,"addgdggcc"
2990 DATA 3,3,3,3,0,0,2,2,4,"ddggdg"
3000 DATA 3,3,1,3,3,0,2,1,4,"dggcgcc"
3010 DATA 4,4,2,4,1,0,4,1,6,"ccggddddggc"
3020 'Medium lvl
3030 DATA 10
3040 DATA 4,4,4,1,1,0,2,2,8,"aaadgddadggggc"
3050 DATA 5,4,0,4,5,0,2,1,9,"gccacccggddggcc"
3060 DATA 5,4,2,0,5,4,0,4,8,"ddaacaaccggccaa"
3070 DATA 6,5,0,1,6,0,3,4,12,"gccaaaddaacccccgggcgg"
3080 DATA 7,7,7,0,0,7,2,0,15,"aaaaaaaddggggggdgdaaaaadddaa"
3090 DATA 7,4,0,2,7,4,2,0,11,"cgcccaaccac"
3100 DATA 7,7,3,7,7,0,1,1,17,"cccggdddddadgggccgggcccaaccgg"
3110 DATA 7,7,4,2,4,7,6,1,20,"ddddggcccccccaadaacaddgddddadaaccgcca"
3120 DATA 9,6,9,6,7,0,0,2,28,"gddaddgddaddgdggccgccaccgccggd"
3130 DATA 9,9,0,9,9,0,2,4,46,"cccggccaacccggcggddddgddgdgdggcccaccaccggc"
3140 'Hard lvl
3150 DATA 10
3160 DATA 14,9,10,9,4,9,7,1,1,"cccgggggcgdgdgdgddddddddadadadacaaaaaccc"
3170 DATA 14,9,5,9,9,9,7,1,1,"cggddddddgcgccgcgcgcggccaacacacaccacaddddddaac"
3180 DATA 13,8,5,4,10,8,10,1,0,"aaddggggccccaaaaaaddddddggggggggccccccccccacaadddaacccaaddad"
3190 DATA 14,9,14,4,4,8,7,3,1,"adddgcgcgcggdddaaddadadadadddadddaaccccg"
3200 DATA 11,9,0,0,0,9,10,3,70,"cccccccaaccccaaaddddddaaccaaddddggdddaa"
3210 DATA 12,8,6,0,10,8,0,7,80,"dddaaddaadaacccaaccgggggcccccccaaaadad"
3220 DATA 14,9,14,9,0,9,7,0,1,"ggggggdaaaddgggdaaaddgggggdddaaaaaddgggddaaadaaa"
3230 DATA 14,9,4,3,10,3,7,1,1,"cacacaaadddadddggdggggcggccgccccccccaccaacaaaadaadddgdggggcg"
3240 DATA 14,9,11,0,6,5,6,1,1,"ccacaaddaaccaaddaadddgggggggggddaadddggddaaaaddaaaaaccccggccgg"
3250 DATA 14,9,10,2,0,6,13,3,1,"ddadaddadddgddggcgcgcccccccccccaacaaddaaaccaaddddgdgdgdaadadddgdddgg"

