1 COLOR4,1,1:SCREEN2,0,0:OPEN"GRP:"AS#1:DEFINTA-Z:DEFFNN(X)=CINT(RND(X)*16)*8+32
2 GOSUB10:A$="GAME OVER":DEFFNP(X,Y)=POINT(X,Y)<>4::U=32:X=56:D=3:C=200:E=0:Q=160
3 IFSTRIG(0)=0THEN3ELSECLS:A=RND(-TIME):GOSUB10:Y=FNN(1):R=FNN(1):FORI=UTOQSTEP8
4 LINE(I+U,25)-(I+U,167):LINE(57,I)-(199,I):NEXT:LINE(X,24)-(C,168),15,B
5 T=0:S=STICK(0):IFSMOD2=1ANDS+D<>6ANDS+D<>10THEND=S
6 J=STICK(1):IFJ=3THENE=(E+1)MOD4ELSEIFJ=7THENE=(E-1)MOD4
7 T=T+1:PSET(X,Y),8:IFD=1THENY=Y-1ELSEIFD=3THENX=X+1ELSEIFD=5THENY=Y+1ELSEX=X-1
8 PSET(C,R),11:IFE=1THENR=R-1ELSEIFE=2THENC=C+1ELSEIFE=3THENR=R+1ELSEC=C-1
9 IFT<8THEN7ELSEIFFNP(C,R)ORFNP(X,Y)THENPSET(96,176):PRINT #1,A$:GOTO2ELSE5
10PSET(96,0):PRINT#1,"XLN Bikes":PSET(64,184):PRINT#1,"PUSH FIRE TO PLAY":RETURN
