10 OPEN"GRP:"AS#1
11 COLOR 15,1,1
12 Q=2
20 SCREEN 2,1:KEY OFF:V=3:PUN=0:LA=0:X=85:Y=85:D=75:E=0:R=2::GOTO 1330
21 STOP ON:ONSTOP GOSUB 20
30 SCREEN 2:SPRITE$(1)=CHR$(128)
40 LA=0:PUN=0:V=3:R=2:E=0:X=75:Y=75:D=70
50 SPRITE$(0)=CHR$(255)+CHR$(255)+CHR$(255)
51 SPRITE$(5)=CHR$(238)+CHR$(238)+CHR$(238)
52 SPRITE$(6)=CHR$(198)+CHR$(198)+CHR$(198)
60 SPRITE$(2)=CHR$(252)+CHR$(252)
70 FORI=2 TO 7:PUT SPRITE I,((I-1)*18,2+10*I),11,2:NEXT
80 PUT SPRITE 8,(18*7,30),11,2
90 LINE(5,10)-(150,160),Q,BF
100 PSET (160,30):PRINT#1,"VIDAS:";V
110 PSET(160,60):PRINT#1,"PUNTOS:";PUN:PSET (160,90):PRINT#1,"PANTALLA:";C
111 PSET(160,120):PRINT#1,"MAXIMO:";MA
120 PUT SPRITE 1,(X,Y),15,1
130 PUT SPRITE 0,(D,150),1,0
140 SPRITE ON:ON SPRITE GOSUB 390
150 IFSTICK(0)>0THENA=STICK(0)ELSEA=STICK(1)
160 IF A=3 THEN D=D+5
170 IF A=7 THEN D=D-5
180 X=X+E
190 Y=Y+R
200 IF LA>1 THEN X=X+E/4:Y=Y+R/4
210 IF LA>2 THEN X=X+E/4:Y=Y+R/4
220 IF LA>3 THEN X=X+E/4:Y=Y+R/4
230 IF LA>4 THEN X=X+E/4:Y=Y+R/4
240 IF LA>5 THEN X=X+E/4:Y=Y+R/4
250 IF LA>6 THEN X=X+E/4:Y=Y+R/4
260 IF X=>148 THEN E=NOT(E)-1:X=147
270 IF Y=<12 THEN R=2
280 IF X=<6 THEN E=NOT(E)-1:X=6
290 IF Y=>160 THEN GOTO 590
300 IF D=<6 THEN D=7
310 IF D=>135 THEN D=134
320 IF Y=>145 THEN GOTO 340
330 GOTO 120
340 IF X=D THEN E=-4:R=-2:GOTO 130
341 IF X=D+8 THEN E=1:R=-2
342 IF X=D+7 THEN E=-1:R=-2
350 IF X=D+16 THEN E=4:R=-2:GOTO 130
360 IF X<D+15.9 AND X>D+8 THEN E=2:R=-2:GOTO 120
370 IF X>D+.9 AND X<D+8 THEN E=-2:R=-2:GOTO 120
380 GOTO 120
390 SPRITE OFF:IF Y>160 THEN GOTO 590
400 IF Y>130 AND Y<159 THEN Y=148:GOTO 340
410 PUT SPRITE INT(((X+4)/18)+1),(X,Y+190),0,3:PUN=PUN+50:LINE(212,60)-(255,80),1,BF:PSET(212,60),1:PRINT#1,PUN
412 IF PUN=1000 THEN V=V+1:PLAY"O6CA":PLAY"O7CA":LINE(204,30)-(220,50),1,BF:PSET(204,30):PRINT#1,V
420 BEEP
425 SPRITE OFF
430 LA=LA+1:IF LA=7 THEN C=C+1:GOTO 450
440 R=NOT(R)-1:GOTO 120
450 SCREEN 0:IF C=11 THEN 1420
460 COLOR 15,1,1:LOCATE 10,10:PRINT"PANTALLA ";C
470 PLAY"L64S8O7CCAGGDFFEAAGCCA"
480 FORI=1 TO 999:NEXT
490 IF C=2 THEN GOTO 610
500 IF C=3 THEN GOTO 690
510 IF C=4 THEN GOTO 770
520 IF C=5 THEN GOTO 850
530 IF C=6 THEN GOTO 930
540 IF C=7 THEN GOTO 1010
550 IF C=8 THEN GOTO 1090
560 IF C=9 THEN GOTO 1170
570 IF C=10 THEN GOTO 1250
580 GOTO 30
590 V=V-1:SPRITE OFF:PUT SPRITE 0,(D,150),1,5:FORI=1 TO 300:NEXT:PUT SPRITE 0,(D,150),1,6:FOR I=1 TO 300:NEXT:PUTSPRITE0,(0,0),0,7:FORI=1TO500:NEXT:X=75:Y=75:E=0:R=2:D=70:IF V=-1 THEN GOTO 1410
600 LINE(160,30)-(220,50),1,BF:PSET (160,30):PRINT#1,"VIDAS:";V:GOTO 120
610 SCREEN 2:PUT SPRITE 2,(18,60),8,2
620 PUT SPRITE 3,(2*18,50),8,2
630 PUT SPRITE 4,(3*18,40),8,2
640 PUT SPRITE 5,(4*18,30),8,2
650 PUT SPRITE 6,(5*18,20),8,2
660 PUT SPRITE 7,(6*18,10),8,2
670 PUT SPRITE 8,(7*18,20),8,2
680 LA=0:Q=7:X=85:Y=85:E=0:R=2:GOTO 90
690 SCREEN 2:PUT SPRITE 2,(18,30),2,2
700 PUT SPRITE 3,(2*18,10),2,2
710 PUT SPRITE 4,(3*18,30),2,2
720 PUT SPRITE 5,(4*18,20),2,2
730 PUT SPRITE 6,(5*18,10),2,2
740 PUT SPRITE 7,(6*18,30),2,2
750 PUT SPRITE 8,(7*18,20),2,2
760 LA=0:X=85:Y=85:Q=8:E=0:R=2:GOTO 90
770 SCREEN 2:PUT SPRITE 2,(18,50),5,2
780 PUT SPRITE 3,(2*18,30),5,2
790 PUT SPRITE 4,(3*18,10),5,2
800 PUT SPRITE 5,(4*18,10),5,2
810 PUT SPRITE 6,(5*18,10),5,2
820 PUT SPRITE 7,(6*18,30),5,2
830 PUT SPRITE 8,(7*18,50),5,2
840 LA=0:Q=11:X=85:Y=85:E=0:R=2:GOTO 90
850 SCREEN 2:PUT SPRITE 2,(18,50),11,2
860 PUT SPRITE 3,(2*18,50),11,2
870 PUT SPRITE 4,(3*18,30),11,2
880 PUT SPRITE 5,(4*18,10),11,2
890 PUT SPRITE 6,(5*18,50),11,2
900 PUT SPRITE 7,(6*18,30),11,2
910 PUT SPRITE 8,(7*18,10),11,2
920 LA=0:X=85:Q=4:Y=85:E=0:R=2:GOTO 90
930 SCREEN 2:PUT SPRITE 2,(18,30),9,2
940 PUT SPRITE 3,(2*18,30),9,2
950 PUT SPRITE 4,(3*18,10),9,2
960 PUT SPRITE 5,(4*18,10),9,2
970 PUT SPRITE 6,(5*18,10),9,2
980 PUT SPRITE 7,(6*18,30),9,2
990 PUT SPRITE 8,(7*18,30),9,2
1000 LA=0:X=85:Q=5:Y=85:E=0:R=2:GOTO 90
1010 SCREEN 2:PUT SPRITE 2,(18,10),13,2
1020 PUT SPRITE 3,(2*18,30),13,2
1030 PUT SPRITE 4,(3*18,50),13,2
1040 PUT SPRITE 5,(4*18,50),13,2
1050 PUT SPRITE 6,(5*18,50),13,2
1060 PUT SPRITE 7,(6*18,30),13,2
1070 PUT SPRITE 8,(7*18,10),13,2
1080 LA=0:X=85:Q=11:Y=85:E=0:R=2:GOTO 90
1090 SCREEN 2:PUT SPRITE 2,(18,10),7,2
1100 PUT SPRITE 3,(2*18,10),7,2
1110 PUT SPRITE 4,(3*18,30),7,2
1120 PUT SPRITE 5,(4*18,50),7,2
1130 PUT SPRITE 6,(5*18,10),7,2
1140 PUT SPRITE 7,(6*18,30),7,2
1150 PUT SPRITE 8,(7*18,50),7,2
1160 LA=0:X=85:Y=85:Q=3:E=0:R=2:GOTO 90
1170 SCREEN 2:PUT SPRITE 2,(18,10),1,2
1180 PUT SPRITE 3,(2*18,10),1,2
1190 PUT SPRITE 4,(3*18,30),1,2
1200 PUT SPRITE 5,(4*18,30),1,2
1210 PUT SPRITE 6,(5*18,30),1,2
1220 PUT SPRITE 7,(6*18,10),1,2
1230 PUT SPRITE 8,(7*18,10),1,2
1240 LA=0:Q=8:X=85:Y=85:E=0:R=2:GOTO 90
1250 SCREEN 2:PUT SPRITE 2,(18,50),11,2
1260 PUT SPRITE 3,(2*18,30),11,2
1270 PUT SPRITE 4,(3*18,10),11,2
1280 PUT SPRITE 5,(4*18,30),11,2
1290 PUT SPRITE 6,(5*18,10),11,2
1300 PUT SPRITE 7,(6*18,30),11,2
1310 PUT SPRITE 8,(7*18,50),11,2
1320 LA=0:Q=14:X=85:Y=85:E=0:R=2:GOTO 90
1330 SCREEN 0:C=1:COLOR 15,1,1:LOCATE 5,5:PRINT"����� ����� �     �����"
1331 SPRITEOFF
1332 STOP ON:ONSTOP GOSUB 20
1340 LOCATE 5,6:PRINT"� � � �   � �     �"
1350 LOCATE 5,7:PRINT"�   � ����� �     �����"
1360 LOCATE 5,8:PRINT"�   � �   � ����� �"
1370 LOCATE 5,11:PRINT"PULSA DISPARO PARA JUGAR"
1380 LOCATE 3,20:PRINT"POR RAUL PORTALES:NEW soft"
1390 Z=Z+1:IF STRIG(1) ORSTRIG(0)THEN 450
1391 IF Z=600 THEN Z=0:GOTO 2000
1400 GOTO 1390
1410 SCREEN 0:COLOR 15,1,1:IF PUN=>MA THEN MA=PUN:LOCATE1,10:PRINT"�BRAVO, HAS HECHO UN NUEVO RECORD!":FORI=1 TO 999:NEXT
1411 SCREEN 0:COLOR 15,1,1:LOCATE 10,10:PRINT"JUEGO TERMINADO":FORI=1 TO 999:NEXT:GOTO 1330
1415 SCREEN 0:LOCATE 10,10:PRINT"JUEGO TERMINADO":FORI=1 TO 999:NEXT:GOTO 1330
1420 SCREEN 2:COLOR 15,4,4
1430 PUT SPRITE 1,(100,145),1,0
1440 CIRCLE(100,50),20,11:PAINT(100,50),11
1450 FORI=85TO145:PUT SPRITE 0,(108,I),15,1:NEXT
1460 FORI=145 TO 70STEP-1:PUT SPRITE 0,(108,I),15,1:NEXT
1470 FORI=1 TO 15:CIRCLE(100,50),20,I:PAINT(100,50),I:NEXT
1480 FOR I=1 TO 11:COLOR 11:PSET(60,100):PRINT#1,LEFT$("FELICIDADES",I):NEXT
1490 FOR I=1 TO 11:COLOR 11:PSET(60,120):PRINT#1,LEFT$("LO LOGRASTE",I):NEXT
1500 FORI=1 TO 999:NEXT:GOTO 1410
2000 SCREEN2,3
2020 RESTORE:FORI=1 TO 2:FORR=1 TO 32:READ A:A$=A$+CHR$(A):NEXTR:SPRITE$(I)=A$:A$="":NEXT:K=200
2030 FORI=0 TO 100 STEP 2:PUT SPRITE 1,(I,50),11,1:IFSTRIG(0)ORSTRIG(1)THEN1330ELSEPUT SPRITE 2,(K,50),4,2:K=K-2:NEXT
2040 COLOR 11:FORI=1 TO7:PSET(125,80):PRINT#1,LEFT$("EW soft",I):NEXT
2050 FORI=1TO1000:IF STRIG(0)ORSTRIG(1)THEN1330ELSE NEXT
2070 GOTO 2100
2080 DATA0,3,3,5,5,9,9,17,16,32,32,64,64,128,128,0,0,0,0,0,0,1,2,130,132,136,136,144,160,96,0,0
2090 DATA 255,124,124,58,58,22,22,14,15,7,7,3,3,1,1,0,255,254,254,252,252,248,248,112,112,96,96,64,64,128,128,0
2100 SCREEN2
2110 COLOR 15:PSET(2,10):PRINT#1,"A�O 2002:"
2120 PSET(3,10):PRINT#1,"A�O 2002:"
2130 PSET(2,22):PRINT#1,"TODAS LAS COMUNICACIONES DE LA"
2140 PSET(3,22):PRINT#1,"TODAS LAS COMUNICACIONES DE LA"
2150 PSET(2,34):PRINT#1,"TIERRA HAN SIDO CORTADAS MEDIANTE"
2160 PSET(3,34):PRINT#1,"TIERRA HAN SIDO CORTADAS MEDIANTE"
2170 PSET(2,46):PRINT#1,"10 BARRERAS DE LADRILLOS SONICOS."
2171 PSET(3,46):PRINT#1,"10 BARRERAS DE LADRILLOS SONICOS."
2180 PSET(2,58):PRINT#1,"TU MISION CONSISTE EN DESTRUIR"
2181 PSET(3,58):PRINT#1,"TU MISION CONSISTE EN DESTRUIR"
2190 PSET(2,70):PRINT#1,"DICHAS BARRERAS AYUDANDOTE DE UNA"
2191 PSET(3,70):PRINT#1,"DICHAS BARRERAS AYUDANDOTE DE UNA"
2200 PSET(2,82):PRINT#1,"BOLA SONICA QUE PUEDE DESTRUIR A"
2201 PSET(3,82):PRINT#1,"BOLA SONICA QUE PUEDE DESTRUIR A"
2210 PSET(2,94):PRINT#1,"LOS LADILLOS SONICOS QUE FORMAN"
2211 PSET(3,94):PRINT#1,"LOS LADILLOS SONICOS QUE FORMAN"
2220 PSET(2,106):PRINT#1,"LAS BARRERAS.
2221 PSET(3,106):PRINT#1,"LAS BARRERAS.
2230 PSET(40,140):PRINT#1,"�BUENA SUERTE!"
2231 PSET(41,140):PRINT#1,"�BUENA SUERTE!"
2240 FORI=1TO300:IF STRIG(0) OR STRIG(1) THEN1330 ELSE NEXT
2250 PSET(20,180):PRINT#1,"LA VAS A NECESITAR"
2251 PSET(21,180):PRINT#1,"LA VAS A NECESITAR"
2260 FORI=1TO900:IF STRIG(0) OR STRIG(1) THEN1330 ELSE NEXT
2500 GOTO 1330
