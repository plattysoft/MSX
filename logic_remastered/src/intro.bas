600 COLOR 2.1.1
700 SCREEN 2,1
800 BLOAD "logic_r.sc2",S
809 'There are only capital letters on the font, need to update the strings
851 TIME=0
852 TX=1:TY=0:T$="BOOTING SEQUENCE COMPLETED... LITTLE ANDROID LOGIC FINDS ITSELF ON A ROOM ON AN UNKNOWN LOCATION, ALL HIS COMMUNICATIONS ARE OFFLINE AND ONE SIMPLE DIRECTIVE IN ITS PROGRAM: GET OUT.":GOSUB 890
853 TX=1:TY=0:T$="THIS IS PROBABLY RELATED TO ITS REQUEST TO BE PROMOTED TO PGD-4: PLANNERS AND GOAL DRIVEN DROIDS - LEVEL 4. IT WAS THE CLOSEST THING TO A PROMOTION."
854 T$="IT SOUNDED LIKE A GOOD IDEA BACK THEN. NOW, NOT SO MUCH. THIS IS PROBABLY JUST A TEST SCENARIO, BUT IT LOOKS DEADLY TOO.":GOSUB 890
855 TX=1:TY=0:T$="ANYWAY, LOGIC HAS A MISSION, AND NOT MUCH OF A CHOICE, SO BETTER GET MOVING...":GOSUB 890
856 TX=1:TY=0:T$="ARMED WITH HIS JUST ITS LEGS, THRUSTERS, WITS AND DETERMINATION, IT STARTED EXPLORING THE COMPLEX.":GOSUB 890
857 TX=1:TY=0:T$="LOGIC JUMPED ACROSS COUNTLESS PITS, WENT TO THE DEEPER LEVELS OF THE COMPLEX, DODGED MANY FOES, AVOIDED DEADLY TRAPS,"
858 T$="RUN AGAINST CONVOY BELTS, MADE IT BACK, FOUND THE HIDDEN LOCK AND FINALLY GOT THE KEY TO THE MAIN DOOR AND SUCCEEDED ON HIS TRIAL WITH SWEAT AND BLOOD,"
859 T$="IF ROBOTS COULD HAVE SUCH FLUIDS.":GOSUB 890

870 IF INKEY$<>"" GOTO 870
871 IF INKEY$="" GOTO 871
875 run "logic_r.bas"

890 'Writing text on Screen subroutine
890 FOR I=1 TO LEN(T$)
891   CT$=MID$(T$,i,1)
892   VPOKE &H1800+TX+TY*32+I,ASC(CT$)+159
893 NEXT I
894 RETURN
