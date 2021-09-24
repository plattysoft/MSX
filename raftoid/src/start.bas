10 DEFINT A-Z
20 BLOAD "start.scr",S

30 'TODO Add the Platty Animation

100 Y=96

4019 if inkey$<>"" goto 4019
4020 S=STICK(0)
4030 IF S=1 THEN Y=96
4040 IF S=5THEN Y=112
4100 put sprite 1,(40,Y),15,1
4110 put sprite 2,(56,Y),15,2
4132 if strig(0)=-1 OR strig(1)=-1 GOTO 4150
4140 GOTO 4020
4150 IF Y=112 THEN RUN"editor.bas"
4210 RUN "raftoid.bas"
4300 'TODO launch a tester that is not the main game.
