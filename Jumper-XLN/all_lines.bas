10 COLOR 5,1,1:SCREEN 1,3,0:KEY OFF
20 DEFINT A-Z
30 SOUND 9,28:SOUND 12,28
40 SPRITE$(0)="0xt~<88888800008":SPRITE$(1)="```pppxxx|||~~~~"
50 LOCATE 9,3:PRINT "Jumper-XLN"
60 LOCATE 9,7:PRINT "PUSH SPACE"
70 IF NOT STRIG(0) OR PLAY(0) THEN 70
80 D=RND(-TIME)
90 A=255:B=-32:D=0:E=32:Y=100:X=12:J=-9:ON SPRITE GOSUB 200
100 CLS:FOR I=0 TO 32:LOCATE I,16:PRINT "_":NEXT
110 IF STRIG(0) AND Y=100 THEN J=10:SOUND 3,&H7:SOUND 2,&HF2:SOUND 13,0
120 PUTSPRITE 0,(X,Y),7,0
130 PUTSPRITE 1,(A,100),5,1
140 PUTSPRITE 2,(B,100),5,1
150 IF J=-9 THEN Y=100 ELSE J=J-1:X=X+1:Y=Y-J
160 D=D-1:IF D<0 THEN A=A-4:IF A<-16 THEN A=255:D=RND(1)*20
170 E=E-1:IF E<0 THEN B=B-4:IF B<-16 THEN B=255:E=RND(1)*20
180 IF X>230 THEN PUT SPRITE 0,,11:PLAY "V15L8DL16R16EFL4A":GOTO 60
190 SPRITE ON:GOTO 110
200 SPRITE OFF
210 PUT SPRITE 0,,8:PLAY "V15O3L6AR32FL4D"
220 LOCATE 9,3:PRINT "GAME OVER!"
230 GOTO 60
