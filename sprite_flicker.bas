10 COLOR 15,1,1
20 SCREEN 2
30 SPRITE$(0)="AASDFDGDASDFGSDFDDSAASDFFDGDSAasd"
40 IF S=0 THEN S=1:GOTO 51 ELSE S=0
41 PUT SPRITE 0,(0,0),2,0
42 PUT SPRITE 1,(16,0),2,0
43 PUT SPRITE 2,(32,0),2,0
44 PUT SPRITE 3,(48,0),2,0
45 GOTO 60
51 PUT SPRITE 0,(64,0),2,0
52 PUT SPRITE 1,(80,0),2,0
53 PUT SPRITE 2,(96,0),2,0
54 PUT SPRITE 3,(114,0),2,0
60 IF TIME<1 THEN 60 ELSE TIME=0: GOTO 40
