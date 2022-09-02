10 'COLOR 15, 1, 1: SCREEN 2,2,0
1 DEFINT A-Z
21 DIM LS(24)
22 FOR I=0 TO 23 STEP 2
23  LT=VPEEK(I\2+2)
24  LS(I)=LT\16-1:LS(I+1)=(LT MOD 16)-1
28 NEXT I

29 BLOAD "spacecat.SC2",S
30 BLOAD "sprites.bin",S

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

682 STRIG(0) OFF: STRIG(1) OFF
690 CALL TURBO OFF

4000 BLOAD "start.scr",S
4010 ON STRIG GOSUB 4090, 4091
4011 STRIG(0) ON: STRIG(1) ON

4020 ' HANDLING  OPTIONS
4030 PUT SPRITE 0, (104, 135+Y), 10, 12
4041 S0=STICK(0)
4042 IF S0<>R0 THEN R0=S0 ELSE GOTO 4046
4043 IF R0=1 THEN Y=Y-16: IF Y<0 THEN Y=16
4044 IF R0=5 THEN Y=Y+16: IF Y>16 THEN Y=0

4046 S1=STICK(1)
4047 IF S1<>R1 THEN R1=S1 ELSE GOTO 4020
4048 IF R1=1 THEN Y=Y-16: IF Y<0 THEN Y=16
4049 IF R1=5 THEN Y=Y+16: IF Y>16 THEN Y=0
4050 GOTO 4020

4090 'SAVE JOYSTICK / KEYBOARD selection
4090 STRIG(0) OFF: STRIG(1) OFF: IF Y=0 THEN SS=0: GOTO 4100 ELSE GOTO 4300
4091 STRIG(0) OFF: STRIG(1) OFF: IF Y=0 THEN SS=1: GOTO 4100 ELSE GOTO 4300
4100 'Put level selection in VRAM info
4100 PUT SPRITE 0,,0:BLOAD "loading.scr",S
4101 PLAY "o4L8cdefefgagabo5ce", "o3L8cR32L4dfR16L8dR32L4eg"
4110 VPOKE 1,SS
4111 VPOKE 0, (X-8)\40+(Y-8)*6\40+1
4112 FOR I=0 TO 23 STEP 2
4113  VPOKE I/2+2, (LS(I)+1)*16+(LS(I+1)+1)
4114 NEXT I
4120 run "lselect.bas"

4300 'HELP
4300 HP=1: PUT SPRITE 0, , 0
4301 HP$=STR$(HP): HP$=RIGHT$(HP$,LEN(HP$)-1)
4310 BLOAD "help_"+HP$+".scr",S
4320 S=STICK(0)
4321 IF S<>R0 THEN R0=S:GOSUB 4610 ELSE GOTO 4324
4322 IF S=3 THEN GOSUB 4510:HP=HP+1: IF HP>6 THEN HP=1: GOTO 4301 ELSE GOTO 4301
4323 IF S=7 THEN GOSUB 4560:HP=HP-1: IF HP=0 THEN HP=6: GOTO 4301 ELSE GOTO 4301
4324 S=STICK(1)
4325 IF S<>R1 THEN R1=S:GOSUB 4610 ELSE GOTO 4330
4326 IF S=3 THEN GOSUB 4510:HP=HP+1: IF HP>6 THEN HP=1: GOTO 4301 ELSE GOTO 4301
4327 IF S=7 THEN GOSUB 4560:HP=HP-1: IF HP=0 THEN HP=6: GOTO 4301 ELSE GOTO 4301

4330 IF STRIG(0) OR STRIG(1) THEN GOTO 4000
4500 GOTO 4320

4510 PUT SPRITE 0,(221,85),10,27
4520 PUT SPRITE 1,(236,85),10,28
4530 PUT SPRITE 2,(221,99),10,29
4540 PUT SPRITE 3,(236,99),10,30
4550 RETURN
4560 PUT SPRITE 0,(5,85),10,27
4570 PUT SPRITE 1,(20,85),10,28
4580 PUT SPRITE 2,(5,99),10,29
4590 PUT SPRITE 3,(20,99),10,30
4600 RETURN
4610 PUT SPRITE 0,,0:PUT SPRITE 1,,0:PUT SPRITE 2,,0:PUT SPRITE 3,,0:RETURN
