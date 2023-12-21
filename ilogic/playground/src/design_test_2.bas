10 ' --- Slot 0
20 ' color 15
30 DATA 00,03,0F,1F,3F,3F,7F,7F,7F,7F,7F,3F,3F,1F,0F,03
40 DATA 00,E0,F8,FC,FE,FE,FF,FF,FF,FF,FF,FE,FE,FC,F8,E0
50 '
60 ' --- Slot 3
70 ' color 15
80 DATA 00,01,01,01,01,02,02,02,07,0E,1C,3C,38,C8,F0,7C
90 DATA 00,C0,C0,40,40,20,20,20,30,30,38,38,39,27,1E,38
100 '
110 ' --- Slot 4
120 ' color 15
130 DATA 00,00,01,01,01,01,01,01,07,5E,6C,68,40,40,00,00
140 DATA 00,00,C0,C0,40,40,20,20,30,30,38,38,38,00,38,7E
150 '
160 ' --- Slot 5
170 ' color 15
180 DATA 00,01,01,00,00,00,04,06,06,06,04,04,00,00,00,01
190 DATA 00,C0,C0,C0,A0,A0,90,90,C0,C0,E0,E0,E0,00,E0,F8
200 '
210 ' --- Slot 6
220 ' color 15
230 DATA 00,01,01,00,00,00,00,08,0D,0D,0D,08,08,00,00,01
240 DATA 00,E0,E0,C0,A0,90,18,F0,E0,C0,20,E0,E0,00,E0,F8
250 '
260 ' --- Slot 7
270 ' color 4
280 DATA 00,00,00,00,00,00,00,01,01,01,00,00,00,00,00,00
290 DATA 00,00,00,40,20,10,08,F0,F0,C0,00,00,00,00,00,00
300 ' color 15
310 DATA 00,01,01,00,00,00,08,0C,0C,0C,08,08,00,00,00,01
320 DATA 00,E0,E0,80,80,A0,F0,08,00,00,E0,E0,E0,00,E0,F8
330 '
340 ' --- Slot 8
350 ' color 4
360 DATA 00,00,00,00,00,0C,1E,1E,3C,70,60,40,40,70,50,60
370 DATA 0C,1E,1A,1A,1E,0C,00,00,00,00,08,04,07,05,06,00
380 ' color 15
390 DATA 3F,7F,7F,7F,7F,73,21,21,03,0F,03,00,00,00,00,00
400 DATA F2,E1,E5,E5,E1,F3,FE,FE,FC,F8,E0,00,00,00,00,00
410 '
420 ' --- Slot 13
430 ' color 4
440 DATA 00,00,00,00,00,0C,1E,1E,0F,17,13,11,1C,14,18,00
450 DATA 0C,1E,1A,1A,1E,0C,00,00,00,00,00,80,60,1C,14,18
460 ' color 15
470 DATA 3F,7F,7F,7F,7F,73,21,21,10,08,00,00,00,00,00,00
480 DATA F2,E1,E5,E5,E1,F3,FE,FE,FC,F8,E0,00,00,00,00,00
490 DATA *

'FILE "design.sc2.plet5"
'FILE "character_sprites.bak"

9000 COLOR 15,1,1:SCREEN 2,2,0
9009 BLOAD "design.sc2",S
9010 'CMD WRTVRAM 1, 0

9020 'CALL TURBO ON
9030 GOSUB 10000
9031 'CMD WRTSPR 0

9100 TIME=0
9101 IF D=0 THEN X=X+2:IF X=84 THEN D=1
9102 IF D=1 THEN X=X-2:IF X=0 THEN D=0
9109 SS=SS+1:IF SS=2 THEN SS=0:ST=ST+1:IF ST=4 THEN ST=0
9110 IF ST=1 THEN YO=1 ELSE IF ST=3 THEN YO=-1 ELSE YO=0
9180 PUT SPRITE 0,(X,118+YO),4,4+D*10:PUT SPRITE 1,(X,118+YO),15,5+D*10
9190 PUT SPRITE 2,(X,134),4,6+ST*2+D*10:PUT SPRITE 3,(X,134),15,7+ST*2+D*10
9200 IF TIME<10 GOTO 9200 ELSE 9100
10000 REM -- LOAD SPRITES
10010 S=BASE(9)
10020 READ R$: IF R$="*" THEN RETURN ELSE VPOKE S,VAL("&H"+R$):S=S+1:GOTO 10020
