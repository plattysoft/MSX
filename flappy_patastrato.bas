1 COLOR 15,2,2
10 SCREEN 2,2
20 FOR S=0 TO 8
25   A$=""
30   FOR I=1 TO 32
40     READ R
50     A$=A$+CHR$(R)
60   NEXT I
70   SPRITE$(S)=A$
80 NEXT S
82 LINE (15,15)-(175,175),4,BF
90 V=0: A=.4: Y=100: T=0
91 PX=175
92 P2=260
93 BS=0
93 SPRITE ON:ON SPRITE GOSUB 500
100 ' ********************
102 ' *    GAME LOOP     *
104 ' ********************
110 PUTSPRITE 0,(50,Y),11,BS
120 J=STICK(0)
130 IF J=1 THEN V=-6:T=0
140 Y=Y+V+A*T
150 T=T+1
160 BS=BS+1
170 IF BS=4 THEN BS=0
200 ' PIPE MOVEMENT
210 PX=PX-2
220 PUTSPRITE 1,(PX,15),2,8
221 PUTSPRITE 2,(PX,31),2,5
222 PUTSPRITE 3,(PX,47),2,8
223 PUTSPRITE 4,(PX,63),2,7
231 PUTSPRITE 5,(PX,143),2,6
232 PUTSPRITE 6,(PX,159),2,5
240 IF PX<=0 THEN PX=175
310 P2=P2-2
320 PUTSPRITE 7,(P2,15),2,8
321 PUTSPRITE 8,(P2,31),2,7
322 PUTSPRITE 9,(P2,111),2,6
323 PUTSPRITE 10,(P2,127),2,5
331 PUTSPRITE 11,(P2,143),2,8
332 PUTSPRITE 12,(P2,159),2,5
340 IF P2<=0 THEN P2=175
380 IF Y>=159 THEN GOTO 500
390 IF Y<=15 THEN GOTO 500
400 GOTO 100
500 ' ********************
502 ' *    GAME OVER     *
504 ' ********************
505 SPRITE OFF
506 V=-4:T=0
510 PUTSPRITE 0,(50,Y),11,4
530 Y=Y+V+A*T
540 T=T+1 
550 IF Y>=175 THEN GOTO 600
560 GOTO 510
600 ' ********************
602 ' *  START NEW GAME  *
604 ' ********************
605 'PRESS SPACE TO START
690 GOTO 90
1000 ' ********************
1002 ' *    SPRITE DATA   *
1004 ' ********************
1010 ' --- Bird 1
1030 DATA &H07,&H1F,&H3F,&H7F,&HFF,&HDF,&HDF,&HEF,&HEF,&H70,&H3F,&H1F,&H1F,&H1F,&H3B,&H36
1040 DATA &H00,&HF0,&HFC,&HFE,&HB3,&HA5,&HA5,&HB3,&H7F,&HFE,&HFC,&HF8,&HE0,&H80,&H00,&H00
1060 ' --- Bird 2
1080 DATA &H00,&H07,&H1F,&H3F,&H7F,&HE7,&HDF,&HDF,&HE0,&HFF,&H7F,&H3F,&H1F,&H1F,&H3B,&H36
1090 DATA &H00,&HC0,&HF0,&HFC,&H7E,&HB3,&HA5,&H65,&HF3,&HFF,&HFE,&HFC,&HF8,&HE0,&H00,&H00
1110 ' --- Bird 3
1130 DATA &H00,&H07,&H1F,&H30,&H6F,&HDF,&HDF,&HDF,&HFF,&HFF,&H7F,&H3F,&H1F,&H1F,&H3B,&H36
1140 DATA &H00,&HC0,&HF0,&HFC,&H7E,&HB3,&HA5,&HE5,&HF3,&HFF,&HFE,&HFC,&HF8,&HE0,&H00,&H00
1160 ' --- Bird 4
1180 DATA &H00,&H00,&H00,&H0F,&H1F,&H5F,&HDF,&HDF,&HDF,&HFF,&HFF,&H7F,&H3F,&H1F,&H3B,&H36
1190 DATA &H00,&H00,&HC0,&H70,&HBC,&HBE,&HB3,&HA5,&HE5,&HF3,&HFF,&HFE,&HFC,&HF8,&HE0,&H00
1210 ' --- Bird dead
1230 DATA &H10,&H47,&H1F,&HBF,&H70,&HEF,&HDF,&HDF,&HEF,&HF7,&H7F,&H3F,&H1F,&H9F,&H3B,&H36
1240 DATA &H28,&HC2,&HF8,&HFC,&HF2,&H61,&HA5,&HA5,&HA1,&HF2,&HFC,&H80,&H71,&HC0,&H02,&H28
1310 ' --- Pipe middle 1
1320 DATA &H0F,&H2F,&H6F,&H6F,&H2B,&H0F,&H0F,&H0E,&H4F,&HEF,&HF3,&H7D,&H3D,&H03,&H0F,&H0F
1340 DATA &HA0,&HD2,&H77,&HEF,&HDE,&HDC,&HE0,&HD0,&HE0,&HD0,&HE4,&HD6,&HE6,&HD4,&H60,&HD0
1360 ' --- Pipe end top
1380 DATA &H00,&H07,&H0F,&H0F,&H07,&H09,&H0E,&H0F,&H0F,&H2F,&H73,&H7D,&H3D,&H03,&H0F,&H0F
1390 DATA &H00,&H00,&HE0,&HF0,&H90,&H70,&H60,&H50,&HE0,&H70,&HE4,&H56,&HE6,&HD4,&H60,&HD0
1410 ' --- Pipe end bottom
1430 DATA &H0F,&H0E,&H6F,&HEF,&HF3,&H7D,&H3D,&H1A,&H0F,&H0E,&H0F,&H0D,&H00,&H0F,&H07,&H03
1440 DATA &HD0,&HF6,&HDF,&H6F,&HDE,&HEC,&HD0,&HE0,&HD0,&HE0,&HD0,&HE0,&HD0,&H20,&HF0,&HE0
1460 ' --- Pipe middle 2
1480 DATA &H0F,&HCE,&HEF,&HF3,&H7D,&H3D,&H03,&H0F,&H0B,&H0F,&H0F,&H2F,&H6F,&H6F,&H2D,&H0F
1490 DATA &HD0,&HE0,&HD0,&HE0,&HD0,&HE0,&HD0,&H60,&HD0,&HA0,&HD6,&H67,&HAF,&H5E,&HDC,&HE0
