10 color 2,1,1
20 SCREEN 2,2,0
30 bload "spacecat.sc2",S
50 bload "xbasic.bin",R
60 BLOAD "sprites.bin",S
70 FOR I=0 TO 23 STEP 2
71  VPOKE I/2+2, 0
72 NEXT I
90 load "start.bas",R
