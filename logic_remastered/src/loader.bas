10 color 2,1,1
20 SCREEN 2,2,0
30 BLOAD "logic_r.sc2",s
50 bload "xbasic.bin",R
60 BLOAD "sprites.bin",S
70 FOR I=0 TO 31:PUT SPRITE I,((I MOD 16)*20,132+(I\16)*16),0,0:NEXT I
90 load "logic_r.bas",R