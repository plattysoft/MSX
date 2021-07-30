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
40 'BLOAD "map_asm_0_0.plet5",S
50 CMD WRTSPRPAT 0
61 A=0:X=16:Y=120
70 CMD WRTVRAM A, &H1800
71 TIME=0
72 s=STICK(0)
82 IF S=1 AND A>10 THEN A=A-10
83 IF S=3 THEN X=X+4: IF X>190 THEN X=0:A=A+1: GOSUB 120
84 IF S=5 AND A<30 THEN A=A+10
85 IF S=7 THEN X=X-4: IF X<16 THEN X=190:A=A-1: GOSUB 120

80 PUT SPRITE 1, (X,Y), 3, 3
99 IF TIME<5 THEN 99
100 GOTO 71

120 CMD WRTSCR A
130 RETURN
