100 'TODO: Reading the TR variable from a file

850 'Ending Screen
850 BLOAD "end.scr",S
851 TIME=0
852 TX=1:TY=0:T$="YOU MADE IT^^":GOSUB 890
853 TX=1:TY=2:T$="YOU GOT OUT ALIVE^^":GOSUB 890
854 TX=1:TY=4:T$="BUT[[[":GOSUB 890
855 IF TIME<150 GOTO 855
856 IF TR=1 THEN TX=1:TY=6:T$="CHEATS INVALIDATE IT^":GOSUB 890:GOTO 870
857 TX=1:TY=6:T$="WHY TOOK YOU SO LONG]":GOSUB 890
858 IF TIME<250 GOTO 857
859 TX=1:TY=9:T$="DOES NOT MATTER BECAUSE":GOSUB 890
860 TX=1:TY=11:T$="IT DOES NOT END HERE":GOSUB 890
861 IF TIME<400 GOTO 860
862 TX=1:TY=14:T$="STAY TUNED[[[":GOSUB 890
870 IF INKEY$<>"" GOTO 870
871 IF INKEY$="" GOTO 871
875 run "intro.bas

890 'Writing text on Screen subroutine
890 FOR I=1 TO LEN(T$)
891   CT$=MID$(T$,i,1)
892   VPOKE &H1800+TX+TY*32+I,ASC(CT$)+159
893 NEXT I
894 RETURN
