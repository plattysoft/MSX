10 'COLOR 15, 1, 1: SCREEN 2,2,0
1 DEFINT A-Z
21 DIM LS(24)
22 FOR I=0 TO 23 STEP 2
23  LT=VPEEK(I\2+1)
24  LS(I)=LT\16-1:LS(I+1)=(LT MOD 16)-1
28 NEXT I

29 BLOAD "loading.SC2",S
40 BLOAD "cls.scr",S
90 CALL TURBO ON
91 DEFINT A-Z

92 STRIG(0) ON: STRIG(1) ON
93 ON STRIG GOSUB 690, 690

100 'Prepare the initial position
110 FOR I=0 to 3
120  FOR K=0 TO 3
121   VPOKE &H1800+262+I+K*32,152+I*32+K
122  NEXT K
123 NEXT I

300 ' Scroll up 32 times (push everything up and add a line at the bottom on the 4 tiles)
310 FOR I=0 TO 31
311 TIME=0
312  FOR J=1 TO 31
313   FOR K=0 TO &H300 STEP &H100
320    VP = VPEEK(&HCC0+J+K)
321    VPOKE &HCBF+J+K, VP
322    VP = VPEEK(&H2CC0+J+K)
323    VPOKE &H2CBF+J+K, VP
347   NEXT K
348  NEXT J
350  FOR K=0 TO &H300 STEP &H100
351   VP=VPEEK(&H4E0+I+K)
352   VPOKE &HCDF+K, VP
353   VP=VPEEK(&H2CE0+I+K)
354   VPOKE &H2CDF+K, VP
396  NEXT K
397 IF TIME<1 GOTO 397
398 NEXT I

500 FOR I=0 TO 8
509  TIME = 0
510  FOR K=0 TO I
520   VPOKE &H192A+K,172-I+K:VPOKE &H194A+K,204-I+K::VPOKE &H196A+K,236-I+K
530  NEXT K
531  IF TIME<2 GOTO 531
540 NEXT I
600 FOR I=0 TO 5
609  TIME = 0
610  FOR K=0 TO I
620   VPOKE &H1933+K,178-I+K:VPOKE &H1953+K,210-I+K::VPOKE &H1973+K,242-I+K
630  NEXT K
631  IF TIME<2 GOTO 631 
640 NEXT I

650 TIME=0
660 IF TIME<75 GOTO 660

690 CALL TURBO OFF

4000 BLOAD "start.scr",S
4050 STRIG(0) ON: STRIG(1) ON: ON STRIG GOSUB 4100, 4100
4060 GOTO 4060

4100 'Put level selection in VRAM info
4101 VPOKE 0, (X-8)\40+(Y-8)*6\40+1
4102 FOR I=0 TO 23 STEP 2
4103  VPOKE I/2+1, (LS(I)+1)*16+(LS(I+1)+1)
4104 NEXT I
4105 run "lselect.bas"
