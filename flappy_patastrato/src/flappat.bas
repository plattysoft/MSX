1 COLOR 15,2,2
2 SCREEN 2,2,0
3 CALL TURBO ON
4 DEFINT B-X
5 ' A- Acceleration and Y-position are double
19 RESTORE 1030
20 FOR S=0 TO 8
25   A$=""
30   FOR I=1 TO 32
40     READ R
50     A$=A$+CHR$(R)
60   NEXT I
70   SPRITE$(S)=A$
80 NEXT S
82 LINE (15,15)-(175,175),4,BF
83 GOSUB 2010
84 FOR I=2 to 21: VPOKE &H1800+i, i MOD 2: VPOKE &H1800+i+32, (i+1) MOD 2: next i
85 FOR I=2 to 21: VPOKE &H1800+i+32*22, (i+1) MOD 2: VPOKE &H1800+i+32*23, i MOD 2:next i
90 V=0: A#=.1: Y=100: T=0:aa=0:ab=1
91 PX=175
92 P2=260
93 BS=0
94 SPRITE ON:ON SPRITE GOSUB 500
100 ' ********************
102 ' *    GAME LOOP     *
104 ' ********************
100 TIME=0
110 PUTSPRITE 0,(50,Y),11,BS\4
120 J=STICK(0)
130 IF J=1 THEN V=-2:T=0
140 Y=Y+V+A*T
150 T=T+1
160 BS=BS+1
170 IF BS=16 THEN BS=0
180 'REMAP THE BRICKS
181 aa=aa*4:ab=ab*4
182 if aa=256 THEN aa=0:ab=1
183 if ab=256 THEN ab=0:aa=1
190 VPOKE 1, aa: VPOKE 4097, aa: VPOKE 9, ab: VPOKE 4105, ab
191 VPOKE 2, aa: VPOKE 4098, aa: VPOKE 10, ab: VPOKE 4106, ab
192 VPOKE 3, aa: VPOKE 4099, aa: VPOKE 11, ab: VPOKE 4107, ab
193 VPOKE 4, aa: VPOKE 4100, aa: VPOKE 12, ab: VPOKE 4108, ab
194 VPOKE 5, aa: VPOKE 4101, aa: VPOKE 13, ab: VPOKE 4109, ab
195 VPOKE 6, aa: VPOKE 4102, aa: VPOKE 14, ab: VPOKE 4119, ab
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
399 IF TIME<2 GOTO 399
400 GOTO 100
500 ' ********************
502 ' *    GAME OVER     *
504 ' ********************
505 SPRITE OFF
506 V=-4:T=0
510 PUTSPRITE 0,(50,Y),11,4
530 Y=Y+V+A*T*4
540 T=T+1 
549 IF TIME>2 THEN TIME=0 ELSE GOTO 549
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

2010 VPOKE &H1800, 2:VPOKE &H1801, 2: VPOKE &H1800+512, 22: VPOKE &H1800+513, 22
2020 FOR I=0 to 15: READ R:VPOKE i, R: VPOKE &H2000+i, &H68:VPOKE 4096+i, R: VPOKE &H2000+4096+i, &H68:next i
2050 return
3000 DATA &HFF,&H01,&H01,&H01,&H01,&H01,&H01,&HFF
3010 DATA &HFF,&H00,&H00,&H00,&H00,&H00,&H00,&HFF
