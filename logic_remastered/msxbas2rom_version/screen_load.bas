FILE "sprites.bin.plet5"
FILE "map.asm_0_0.plet5"
FILE "map.asm_1_0.plet5"
FILE "map.asm_2_0.plet5"
FILE "map.asm_3_0.plet5"
FILE "map.asm_4_0.plet5"
FILE "map.asm_5_0.plet5"
FILE "map.asm_6_0.plet5"
FILE "map.asm_7_0.plet5"
FILE "map.asm_8_0.plet5"
FILE "map.asm_9_0.plet5"
FILE "map.asm_0_1.plet5"
FILE "map.asm_1_1.plet5"
FILE "map.asm_2_1.plet5"
FILE "map.asm_3_1.plet5"
FILE "map.asm_4_1.plet5"
FILE "map.asm_5_1.plet5"
FILE "map.asm_6_1.plet5"
FILE "map.asm_7_1.plet5"
FILE "map.asm_8_1.plet5"
FILE "map.asm_9_1.plet5"
FILE "map.asm_0_2.plet5"
FILE "map.asm_1_2.plet5"
FILE "map.asm_2_2.plet5"
FILE "map.asm_3_2.plet5"
FILE "map.asm_4_2.plet5"
FILE "map.asm_5_2.plet5"
FILE "map.asm_6_2.plet5"
FILE "map.asm_7_2.plet5"
FILE "map.asm_8_2.plet5"
FILE "map.asm_9_2.plet5"
FILE "map.asm_0_3.plet5"
FILE "map.asm_1_3.plet5"
FILE "map.asm_2_3.plet5"
FILE "map.asm_3_3.plet5"
FILE "map.asm_4_3.plet5"
FILE "map.asm_5_3.plet5"
FILE "map.asm_6_3.plet5"
FILE "map.asm_7_3.plet5"
FILE "map.asm_8_3.plet5"
FILE "map.asm_9_3.plet5"
10 COLOR 2,1,1
20 SCREEN 2,2,0
30 BLOAD "logic_r.sc2",s

40 CMD WRTSPRPAT 0

41 DEFINT A-Z

50 SOUND 8,&b00000
51 SOUND 12,0
52 SOUND 11,1
53 SOUND 13,0
54 SOUND 7,&b10111110
55 SOUND 1,&H7:SOUND 0,&HF2

59 SOUND 8,&b11100

61 DIMAE(3):DIMDE(3):DIMPO(3):DIMTE(3):DIMMM(3):DIMMN(3):DIMME(3):DIMPM(3):DIMPI(3):DIMCE(3)

100 ' READ S and TR From VRAM
110 'S=VPEEK(0):TR=VPEEK(1)

120 FOR I=0 TO 31:PUT SPRITE I,((I MOD 16)*16,164+(I\16)*16),0,0:NEXT I
130 R=0:C=0:PL=9
140 SS=0:SJ=0:PS%=0:SX=46:SY=80:SV=0:TH=0:TV=0

261 A=0:X=16:Y=120
270 'CMD WRTVRAM A, &H1800
271 TIME=0
272 s=STICK(0)
282 IF S=1 AND A>10 THEN A=A-10
283 IF S=3 THEN X=X+4: IF X>190 THEN X=0:A=A+1: GOSUB 320
284 IF S=5 AND A<30 THEN A=A+10
285 IF S=7 THEN X=X-4: IF X<16 THEN X=190:A=A-1: GOSUB 320

280 PUT SPRITE 1, (X,Y), 3, 3
299 IF TIME<5 THEN 299
300 GOTO 271

320 CMD WRTSCR A
330 RETURN
