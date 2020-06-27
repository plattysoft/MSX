1 SPRITE$(1) = "DDDDDDDD"
2 BLOAD "XBASIC.bin",R
3 DEFINT x,y
4 x=0:y=0
10 ON INTERVAL=1 GOSUB 100
20 INTERVAL ON
30 goto 30
40 INTERVAL OFF

100 call turbo ON(x,y)
110 s=stick(0)
120 if s=1 THEN y=y-1
130 if s=3 THEN x=x+1
140 if s=5 THEN y=y+1
150 if s=7 THEN x=x-1
160 put sprite 0, (x,y), 1, 1
170 FOR i=0 to 100:NEXT i
300 call turbo off
400 return