10 COLOR 15,1,1
20 screen 2,2,0
30 BLOAD "ilogic.sc2",s
40 defint A-Z
101 BLOAD "sprites.bin",S
110 DEF FN FF(X,Y)=VPEEK(&H1800+X\8+(Y\8)*32)
120 R=0:C=0

190 PS%=0:X=46:Y=80:VY=0:TH=0:TV=0	

191 R$=STR$(R): R$=RIGHT$(R$,LEN(R$)-1)
192 C$=STR$(C): C$=RIGHT$(C$,LEN(C$)-1)
193 'GOSUB 2000
194 BLOAD "map_"+R$+"_"+C$+".scr",S

199 call turbo ON(X,Y,R,C)
200 T=TIME+3
201 ON STICK(0) GOTO 210,220,230,300,300,300,270,280
209 GOTO 300
210 IF PJ%=0 THEN VY%=-8:PJ%=1
219 GOTO 300
220 IF PJ%=0 THEN VY%=-8:PJ%=1
221 TH=VPEEK(&H1800+(X+16)\8+((Y+8)\8)*32)
222 PS%=0:IF VPEEK(&H1800+(X+16)\8+((Y+12)\8)*32)=0 AND TH=0 AND VPEEK(&H1800+(X+16)\8+((Y+2)\8)*32)=0 THEN X=X+4
229 GOTO 300
230 TH=VPEEK(&H1800+(X+16)\8+((Y+8)\8)*32)
231 IF VPEEK(&H1800+(X+16)\8+((Y+12)\8)*32)=0 AND TH=0 AND VPEEK(&H1800+(X+16)\8+((Y+2)\8)*32)=0 THEN X=X+4
232 IF PS%=0 AND PJ%=0 THEN PS%=1 ELSE PS%=0
239 GOTO 300
270 TH=VPEEK(&H1800+X\8+((Y+8)\8)*32)
271 IF VPEEK(&H1800+X\8+((Y+12)\8)*32)=0 AND TH=0 AND VPEEK(&H1800+X\8+((Y+2)\8)*32)=0 THEN X=X-4
272 IF PS%=2 AND PJ%=0 THEN PS%=3 ELSE PS%=2
279 GOTO 300
280 IF PJ%=0 THEN VY%=-8:PJ%=1
281 TH=VPEEK(&H1800+X\8+((Y+8)\8)*32)
282 PS%=2:IF VPEEK(&H1800+X\8+((Y+12)\8)*32)=0 AND TH=0 AND VPEEK(&H1800+X\8+((Y+2)\8)*32)=0 THEN X=X-4
289 GOTO 300
300 'End of movement loop 
301 'Check for floor tiles at 3 points under the sprite Y+16,(X, X+8, X+15)'
310 Y=Y+VY%
320 IF VY%<0 GOTO 340
330 TV=VPEEK(&H1800+(X+8)\8+((Y+16)\8)*32)
331 IF VPEEK(&H1800+(X+2)\8+((Y+16)\8)*32)>0 OR TV>0 OR VPEEK(&H1800+(X+12)\8+((Y+16)\8)*32)>0 THEN PJ%=0:VY%=0:Y=Y-(Y MOD 8) ELSE PJ%=-1:VY%=VY%+1:IF VY%>8 THEN VY%=8
339 GOTO 350
340 TV=VPEEK(&H1800+(X+8)\8+(Y\8)*32)
341 IF VPEEK(&H1800+(X+2)\8+(Y\8)*32)>0 OR TV>0 OR VPEEK(&H1800+(X+12)\8+(Y\8)*32)>0 THEN VY%=0:Y=Y+8-(Y MOD 8) ELSE VY%=VY%+1:IF VY%>8 THEN VY%=8
350 'IF TV>=160 OR TH>=160 THEN GOTO 190
351 IF TV=72 THEN X=X+2
380 IF X>=226 THEN X=18:R=R+1:PUT SPRITE 0,(X, Y-1),0,0:GOTO 400
381 IF X<=14 THEN X=222:R=R-1:PUT SPRITE 0,(X, Y-1),0,0:GOTO 400
390 PUT SPRITE 0,(X, Y-1),6,PS%
398 IF TIME<T GOTO 398
399 GOTO 200
400 call turbo off
410 GOTO 191
