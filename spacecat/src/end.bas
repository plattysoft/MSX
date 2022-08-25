20 L=VPEEK (0)
21 DIM LS(24)
22 FOR I=0 TO 23 STEP 2
23  LT=VPEEK(I\2+2)
24  LS(I)=LT\16-1:LS(I+1)=(LT MOD 16)-1
25 NEXT I
36 SS=VPEEK(1)

100 'LOAD THE END SCREEN
100 BLOAD "ending.sc2",S

110 ' PRINT THE SCORE ON THE SCREEN
110 TM=0:FOR I=0 TO 23:TM=TM+LS(I):NEXT

110 TM=35

111 'Rank is 0 for F, 1 for E... 3 for C (minimum for certified pilot) ...6 for S
111 RK = TM \ 12

120 IF TM=72 THEN VPOKE &H1800+9*32+19, 114 ELSE VPOKE &H1800+9*32+19, 101-RK
121 IF TM MOD 12 > 6 THEN VPOKE &H1800+9*32+20, 43
190 TD = TM \ 10
191 TU = TM MOD 10
200 IF TD > 0 THEN VPOKE &H1800+12*32+19, 33+TD: VPOKE &H1800+12*32+20, 33+TU ELSE VPOKE &H1800+12*32+19, 33+TU

300 'CERTIFIED PILOT STAMP TODO
300 IF TM>=36 THEN IF TM=72 THEN BLOAD "best_end.scr",S ELSE BLOAD "good_end.scr",S 

1020 IF INKEY$<>"" THEN 1020
1021 IF INKEY$="" AND NOT STRIG(1) THEN 1021

1030 GOSUB 3000:BLOAD "loading.sc2",S:RUN"start.bas

3000 ' SAVE LEVEL VALUES (needs to be done on each exit to prevent problems when you only see the game over dialog)
3010 FOR I=0 TO 23 STEP 2
3020  VPOKE I\2+2, (LS(I)+1)*16+(LS(I+1)+1)
3030 NEXT I
3040 VPOKE 0, L
3050 VPOKE 1, SS
3060 RETURN
