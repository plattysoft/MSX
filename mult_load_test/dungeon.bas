100 defint A-Z

130 R=1:C=1
140 SS=0:X=46:Y=80

151 GOTO 700

200 ON STICK(0) GOTO 210,220,230,240,250,260,270,280
209 GOTO 300
210 Y=Y-4
219 GOTO 300
220 X=X+4:Y=Y-4
229 GOTO 300
230 X=X+4
239 GOTO 300
240 X=X+4:Y=Y+4
249 GOTO 300
250 Y=Y+4
259 GOTO 300
260 X=X-4:Y=Y+4
269 GOTO 300
270 X=X-4
279 GOTO 300
280 X=X-4:Y=Y-4
289 GOTO 300
300 'Movement check
380 IF X>=226 THEN X=18:C=C+1:GOTO 700
381 IF X<=14 THEN X=222:C=C-1:GOTO 700
382 IF Y>=112 THEN Y=4:R=R+1:GOTO 700
383 IF Y<=2 THEN Y=110:R=R-1:GOTO 700
390 PUT SPRITE 0,(X,Y-1),6,1
490 ' Sync timing with VDP for accurate and reliable speed
490 IF TIME<5 GOTO 490
499 TIME=0: GOTO 200

700 'Move to another room
710 SX=X:SY=Y
720 'CALL TURBO ON(R,C)
751 A$=CHR$(34)+"map_"+CHR$(C+48)+"_"+CHR$(R+48)+".scr"+CHR$(34)+",S"+CHR$(0)
755 '#I &h21,A$,&h23,&hdd,&h2a,&hCA,&h39,&hcd,&h59,&h01
756 'CALL TURBO OFF
757 BLOAD "map_"+CHR$(C+48)+"_"+CHR$(R+48)+".scr",S
789 X=SX:Y=SY
790 GOTO 200
