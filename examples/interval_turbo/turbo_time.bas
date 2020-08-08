1 screen 2
3 SPRITE$(1) = "DDDDDDDD"
5 DEFINT x,y
6 x=0:y=0
7 call turbo on

110 t=time+2
111 s=stick(0)
120 if s=1 THEN y=y-1
130 if s=3 THEN x=x+1
140 if s=5 THEN y=y+1
150 if s=7 THEN x=x-1
160 put sprite 0, (x,y), 1, 1
170 if time<T GOTO 170
400 GOTO 110
