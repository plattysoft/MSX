1 defint A-Z
10 COLOR 2,1,1
20 SCREEN 2,2,0
30 BLOAD "logic_r.sc2",s
40 BLOAD "sprites.bin",S
50 POKE &H7000, 2
60 P=PEEK(&H7000)
70 IF P<>2 THEN VPOKE 2,0: GOTO 90 ELSE VPOKE 2,1
80 BLOAD "xbasic.bin",R
90 LOAD "intro.bas",R
