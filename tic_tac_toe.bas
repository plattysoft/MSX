10 SCREEN 1
20 DIM B(9), BC(9)
21 ' Node values (first 2 bits, value, 3rd bit parent ID, 4th bit MIN or MAX
22 DIM N(255) 
23 ' Child relationship (each entry is the index of a child)
24 DIM CH(255,4)
130 

30 FOR I=0 TO 8:B(I)=0
40 CP=1:W=0

50 INPUT "SELECT AI (1/2)";AI
60 IF AI<>1 AND AI<>2 THEN GOTO 50

60 GOSUB 200

100 LOCATE 0, 8:PRINT "PLAYER ";CP;
105 IF CP=AI THEN GOSUB 1000 ELSE INPUT "MOVE";A
110 IF B(A)<>0 THEN PRINT "INVALID MOVE ";A;"!":PRINT"VALID MOVES:";:GOSUB 400:GOTO 100
120 B(A)=CP
130 GOSUB 200
140 GOSUB 300
150 IF W<>0 THEN IF W=-1 THEN PRINT "DRAW!" ELSE PRINT "WINNER ";W:END
160 IF CP=1 THEN CP=2 ELSE CP=1
190 GOTO 100

200 CLS
210 FOR I=0 TO 8
220  LOCATE (I MOD 3)*2, (I\3)*2
230  IF B(I)=1 THEN PRINT "O" ELSE IF B(I)=2 THEN PRINT "X" ELSE PRINT "-"
240 NEXT I
250 RETURN

300 ' WIN CONDITION
305 W=-1
310 FOR I=0 TO 6 STEP 3
320  IF B(I)>0 AND B(I)=B(I+1) AND B(I+1)=B(I+2) THEN W=B(I):RETURN
330 NEXT I
340 FOR I=0 TO 2
350  IF B(I)>0 AND B(I)=B(I+3) AND B(I+3)=B(I+6) THEN W=B(I):RETURN
360 NEXT I
370 IF B(4)>0 AND B(0)=B(4) AND B(4)=B(8) THEN W=B(0):RETURN
380 IF B(4)>0 AND B(2)=B(4) AND B(4)=B(6) THEN W=B(0):RETURN
390 FOR I=0 TO 8
391  IF B(I)=0 THEN W=0
392 NEXT I
399 RETURN

400 'ITERATE OVER THE VALID MOVES
410 FOR I=0 TO 8
420  IF B(I)=0 THEN GOSUB 500
430 NEXT I
440 RETURN

500 PRINT I;" ";
599 RETURN

1000 ' AI PLAYS, INVOKE SUBROUTINE for move selection MS, PERFORM MOVE
1001 ' MAKE A COPY OF THE BOARD
1002 FOR I=0 to 8:BC(I)=B(I):NEXT I
1010 GOSUB 1200
1020 A=MS
1030 RETURN

1100 ' SIMPLE AI, first empty epace
1110 FOR I=0 TO 8
1120  IF B(I)=0 THEN MS=I: RETURN
1130 NEXT I 
1140 RETURN


1200 ' Iterative depth
1201 GOSUB 2000:N(0)=H
1210 ' For each depth D
1211 FOR D=0 TO 4
1220 ' We have the tree populated for D-1, each level changes from MIN to MAX and CP
1230 ' For each terminal node (at D-1)
1240   ' For each possible move
1245     GOSUB 3200
1247     IF (NM=0) GOTO 1090
1250     ' Get target board
1260     ' Evaluate Heuristic
1265     GOSUB 2000
1270     ' Consider adding to children (best 4 or worst 4)
1275     GOSUB 3000
1277  GOTO 1040
1280   ' Update node value
1290 ' For each previous level (0 to D-2)
1300   ' For each node
1310     ' Update value based on children
1311 NEXT D
1320 ' Return selected move

2000 ' Calculate Heuristic of copy board, put it in H
2020 ' Check game end condition using -100, +100 or 0
2030 ' Number of possible win open - number of posible lose open

2999 RETURN

3000 ' Add new node NN to children of current node CN?
3010 FOR I=0 TO 3
3020   IF CH(CN, I) > H THEN GOTO 3050
3030 NEXT
3040 GOTO 3100
3050 CH(CN,I)=NN
3060 N(TN)=NN
3070 TN=TN+1
3100 RETURN

3200 ' Get next move
3599 NM=0
3999 RETURN

4000 
