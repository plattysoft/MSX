710 GOTO 900

809 'There are only capital letters on the font, need to update the strings
851 TIME=0
852 TX=1:TY=0:T$="BOOTING SEQUENCE COMPLETED... LITTLE ANDROID LOGIC FINDS ITSELF ON A ROOM ON AN UNKNOWN LOCATION, ALL HIS COMMUNICATIONS ARE OFFLINE AND ONE SIMPLE DIRECTIVE IN ITS PROGRAM: GET OUT.":GOSUB 890
853 TX=1:TY=3:T$="THIS IS PROBABLY RELATED TO ITS REQUEST TO BE PROMOTED TO PGD-4: PLANNERS AND GOAL DRIVEN DROIDS - LEVEL 4. IT WAS THE CLOSEST THING TO A PROMOTION."
854 TX=1:TY=5:T$="IT SOUNDED LIKE A GOOD IDEA BACK THEN. NOW, NOT SO MUCH. THIS IS PROBABLY JUST A TEST SCENARIO, BUT IT LOOKS DEADLY TOO.":GOSUB 890
855 TX=1:TY=7:T$="ANYWAY, LOGIC HAS A MISSION, AND NOT MUCH OF A CHOICE, SO BETTER GET MOVING...":GOSUB 890
856 TX=1:TY=9:T$="ARMED WITH HIS JUST ITS LEGS, THRUSTERS, WITS AND DETERMINATION, IT STARTED EXPLORING THE COMPLEX.":GOSUB 890
857 'TX=1:TY=11:T$="LOGIC JUMPED ACROSS COUNTLESS PITS, WENT TO THE DEEPER LEVELS OF THE COMPLEX, DODGED MANY FOES, AVOIDED DEADLY TRAPS,"
858 'TX=1:TY=13:T$="RUN AGAINST CONVOY BELTS, MADE IT BACK, FOUND THE HIDDEN LOCK AND FINALLY GOT THE KEY TO THE MAIN DOOR AND SUCCEEDED ON HIS TRIAL WITH SWEAT AND BLOOD,"
859 TX=0:TY=15:T$="IF ROBOTS COULD HAVE SUCH FLUIDS":GOSUB 890
860 ' Previous line is as long as the screen and it is the last place for text.
870 IF INKEY$<>"" GOTO 870
871 IF INKEY$="" GOTO 871
875 run "logic_r.bas"

890 'Writing text on Screen subroutine
890 FOR I=1 TO LEN(T$)
891   CT$=MID$(T$,i,1)
892   VPOKE &H1800+TX-1+TY*32+I,ASC(CT$)+159
893 NEXT I
894 RETURN

900 'Start New Game Screen
900 BLOAD "start.scr",S
910 I=20:J=1:K=4:TR=0
940 IF J=1 THEN I=I+4 ELSE I=I-4
941 TIME=0
960 PUT SPRITE 1,(8,I),8-TR,K:PUT SPRITE 2,(231,I),8-TR,K
970 K=K+1:IF K=8 THEN K=4
980 IF I=140 THEN J=0:TR=0
981 IF I=20 THEN J=1
990 IF STRIG(0) THEN S=0: run "logic_r.bas
991 IF STRIG(1) THEN S=1: run "logic_r.bas
992 ' If trick is enabled, show the feedback on screen
992 IF TIME<5 GOTO 990
997 IF INKEY$="O" THEN run"logic_o.bas"
998 IF INKEY$="R" THEN TR=1
999 GOTO 940
