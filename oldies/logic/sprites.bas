10 screen 2,2,1
110 FOR K=1 TO 12 :B$="":FORI=1TO 32 :READ A$:A=VAL("&H"+A$):B$=B$+CHR$(A):NEXTI:SPRITE$ (K)=B$:NEXTK
111 FOR i=1 to 12: PUT SPRITE i,(0, i*16-16),1,i:NEXT
112 goto 112
120 DATA 00,01,03,07,0F,1F,0F,07,03,07,0F,0E,3C,3C,30,30,08,90,E0,E0,B0,F8,F0,A0,C0,E0,F0,70,30,30,3C,3C
121 DATA 00,01,03,07,0F,1F,0F,0F,1B,03,01,07,07,07,07,01,08,90,E0,E0,B0,F8,F0,A0,C0,C0,80,80,80,80,E0,E0
122 DATA 10,09,07,07,0D,1F,0F,05,03,07,0F,0E,0C,0C,3C,3C,00,80,C0,E0,F0,F8,F0,E0,C0,E0,F0,70,3C,3C,0C,0C
123 DATA 10,09,07,07,0D,1F,0F,05,03,03,01,01,01,01,07,07,00,80,C0,E0,F0,F8,F0,E0,C0,C0,80,E0,E0,E0,E0,80
140 DATA FF,FF,FF,FF,FF,FF,FF,FF,FF,FF,FF,FF,FF,FF,FF,FF,FF,FF,FF,FF,FF,FF,FF,FF,FF,FF,FF,FF,FF,FF,FF,FF
141 DATA 00,00,00,00,07,0F,1F,3F,7F,FF,AA,D5,FF,00,00,00,00,00,00,00,E0,F0,F8,FC,FE,FF,AB,55,FF,00,00,00
142 DATA 00,00,00,FF,D5,AA,D5,AA,FF,00,00,00,00,00,00,00,00,00,00,FF,55,AB,55,AB,FF,00,00,00,00,00,00,00
150 DATA 00,FF,D5,AA,FF,7F,3F,1F,0F,07,00,00,00,00,00,00,00,FF,55,AB,FF,FE,FC,F8,F0,E0,00,00,00,00,00,00
160 DATA 07,1F,3F,7F,7F,FF,FF,FF,FF,FF,7F,7F,3F,1F,07,00,C0,F0,F8,FC,FC,FE,FE,FE,FE,FE,FC,FC,F8,F0,C0,00
161 DATA 07,0F,1F,3F,3F,7F,7F,7F,7F,7F,3F,3F,1F,0F,07,00,C0,E0,F0,F8,F8,FC,FC,FC,FC,FC,F8,F8,F0,E0,C0,00
162 DATA 03,07,07,07,0F,0F,0F,0F,0F,0F,0F,07,07,07,03,00,80,C0,C0,C0,E0,E0,E0,E0,E0,E0,E0,C0,C0,C0,80,00
170 DATA 07,0F,1F,3F,3F,7F,7F,7F,7F,7F,3F,3F,1F,0F,07,00,C0,E0,F0,F8,F8,FC,FC,FC,FC,FC,F8,F8,F0,E0,C0,00
