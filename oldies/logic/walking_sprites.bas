10 COLOR 15,1,1
20 screen 2,2,1
100 FOR K=1 TO 4 :B$="":FORI=1TO 32 :READ A$:A=VAL("&H"+A$):B$=B$+CHR$(A):NEXTI:SPRITE$ (K)=B$:NEXTK

190 PS=1:X=100
200 ON STICK(0) GOTO ,,230,,,,270
210 GOTO 300
230 X=X+4:IF PS=1 THEN PS=2 ELSE PS=1
239 GOTO 300
270 X=X-4:IF PS=3 THEN PS=4 ELSE PS=3
279 GOTO 300
300 PUT SPRITE 0,(X, 120),6,PS
310 GOTO 200

900 DATA 00,01,03,07,0F,1F,0F,07,03,07,0F,0E,3C,3C,30,30,08,90,E0,E0,B0,F8,F0,A0,C0,E0,F0,70,30,30,3C,3C
901 DATA 00,01,03,07,0F,1F,0F,0F,1B,03,01,07,07,07,07,01,08,90,E0,E0,B0,F8,F0,A0,C0,C0,80,80,80,80,E0,E0
902 DATA 10,09,07,07,0D,1F,0F,05,03,07,0F,0E,0C,0C,3C,3C,00,80,C0,E0,F0,F8,F0,E0,C0,E0,F0,70,3C,3C,0C,0C
903 DATA 10,09,07,07,0D,1F,0F,05,03,03,01,01,01,01,07,07,00,80,C0,E0,F0,F8,F0,E0,C0,C0,80,E0,E0,E0,E0,80
