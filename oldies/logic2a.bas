10 J=5:TR=0:TC=4
20 STOP ON:ON STOP GOSUB 20
30 DATA0,3,3,5,5,9,9,17,16,32,32,64,64,128,128,0,0,0,0,0,0,1,2,130,132,136,136,144,160,96,0,0
40 DATA 255,124,124,58,58,22,22,14,15,7,7,3,3,1,1,0,255,254,254,252,252,248,248,112,112,96,96,64,64,128,128,0
50 COLOR 1,1,1
60 SCREEN 2,2:OPEN"GRP:"AS#1
70 DIMAE(5):DIMDE(5):DIMPO(5):DIMTE(5):DIMMM(5):DIMMN(5)
80 DIM PM(5):DIMPI(5):DIMCE(5)
90 FORI=1 TO 2:FORR=1 TO 32:READ A:A$=A$+CHR$(A):NEXTR:SPRITE$(20+I)=A$:A$="":NEXT:K=200
100 STOP ON:ON STOP GOSUB 100
110 FOR K=1 TO 12 :B$="":FORI=1TO 32 :READ A$:B$=B$+CHR$(VAL("&H"+A$)):NEXT:SPRITE$ (K)=B$:NEXT
120 DATA0,1,3,7,F,1F,F,7,3,7,F,E,3C,3C,30,30,8,90,E0,E0,B0,F8,F0,A0,C0,E0,F0,70,30,30,3C,3C,0,1,3,7,F,1F,F,F,1B,3,1,7,7,7,7,1,8,90,E0,E0,B0,F8,F0,A0,C0,C0,80,80,80,80,E0,E0,10,9,7,7,D,1F,F,5,3,7,F,E,C,C,3C,3C,0,80
130 DATAC0,E0,F0,F8,F0,E0,C0,E0,F0,70,3C,3C,C,C,10,9,7,7,D,1F,F,5,3,3,1,1,1,1,7,7,0,80,C0,E0,F0,F8,F0,E0,C0,C0,80,E0,E0,E0,E0,80
140 DATAFF,FF,FF,FF,FF,FF,FF,FF,FF,FF,FF,FF,FF,FF,FF,FF,FF,FF,FF,FF,FF,FF,FF,FF,FF,FF,FF,FF,FF,FF,FF,FF,0,0,0,0,7,F,1F,3F,7F,FF,AA,D5,FF,0,0,0,0,0,0,0,E0,F0,F8,FC,FE,FF,AB,55,FF,0,0,0,0,0,0,FF,D5,AA,D5,AA,FF,0,0,0,0,0,0,0
150 DATA0,0,0,FF,55,AB,55,AB,FF,0,0,0,0,0,0,0,0,FF,D5,AA,FF,7F,3F,1F,F,7,0,0,0,0,0,0,0,FF,55,AB,FF,FE,FC,F8,F0,E0,0,0,0,0,0
160 DATA0,7,1F,3F,7F,7F,FF,FF,FF,FF,FF,7F,7F,3F,1F,7,0,C0,F0,F8,FC,FC,FE,FE,FE,FE,FE,FC,FC,F8,F0,C0,0,7,F,1F,3F,3F,7F,7F,7F,7F,7F,3F,3F,1F,F,7,0,C0,E0,F0,F8,F8,FC,FC,FC,FC,FC,F8,F8,F0,E0,C0,0,3,7,7,7,F,F,F,F,F,F,F,7,7,7,3,0,80
170 DATAC0,C0,C0,E0,E0,E0,E0,E0,E0,E0,C0,C0,C0,80,0,7,F,1F,3F,3F,7F,7F,7F,7F,7F,3F,3F,1F,F,7,0,C0,E0,F0,F8,F8,FC,FC,FC,FC,FC,F8,F8,F0,E0,C0,0
180 GOTO 2370
190 COLOR 1:A=95:D=39:Q=1:V=9:P=1:L1=0:L2=0:L3=0:S=0:AI=A:DI=D:S=0:PA=0:PI=0:QI=1:H(1)=0:H(2)=0:H(3)=0:MI=0:J=5
200 SCREEN2
210 PUT SPRITE 20,(150,160),9,1
220 PSET(160,160):COLOR 15:PRINT#1,V
230 PUT SPRITE 21,(190,170),11,21:PUTSPRITE22,(190,170),TC,22
240 PSET(10,185):PRINT#1,"LLAVES"
250 PSET(11,185):PRINT#1,"LLAVES":COLOR 4
260 PSET(80,165):PRINT#1,"LOGIC"
270 PSET(81,165):PRINT#1,"LOGIC":COLOR 1
280 LINE(2,3)-(238,152),4,B
290 IF P<6 THEN RESTORE 840:O=P-1ELSE RESTORE 1020:O=P-6
300 IF P>10 THEN RESTORE 1170:O=P-11:IFP>15 THEN RESTORE 1330:O=P-16:IFP>20THENRESTORE1510:O=P-21:IFP>25THENRESTORE1690:O=P-26:IFP>30THENRESTORE1850:O=P-31:IFP>35THENRESTORE 2010:O=P-36
310 IF O>0THEN GOSUB 2240
320 PO=1:FORI=0TO5:PUTSPRITEI,(0,0),0,0:NEXT:LINE(7,8)-(235,145),1,BF
330 READL
340 FORI=1 TO L:READX,Y,C:LINE(X,Y)-(X+30,Y+15),C,BF:PSET(X,Y):PSET(X+30,Y):PSET(X+30,Y+15):PSET(X,Y+15)
350 IFC>7THENCW=C-7:ONCW GOTO 3250,3230,3210,3190,360,3190,3190,3210
360 NEXTI
370 READ E:FORI=1TO E:READTE(I),DE(I),AE(I),MM(I),MN(I),ME(I),PO(I),PI(I),CE(I),PM(I):NEXTI
380 READW:IF W>0THEN IFH(W)=1 THENIFW=1THENGOTO 2180ELSEIFW=2THEN2200ELSE2220
390 IF P=10 THEN 2970
400 IF PDL(7)=0 AND POINT(D+18,A+2)<3ANDPOINT(D+18,A+14)<3ANDS<>2THEN D=D+4:IFQ=2THENQ=1ELSEQ=2
410 IF D<13 THEN P=P-1:D=215:AI=A:DI=D:SI=S:PI=PA:QI=Q:MI=M:GOTO 290
420 IF A>130 THEN A=10:P=P+10:AI=A:DI=D:PI=PA:S=2:SI=S:QI=Q:GOTO 290
430 IF A<10 THEN A=130:P=P-10:AI=A:DI=D:SI=S:PA=PA+120:PI=PA:QI=Q:MI=M:GOTO 290
440 IF PDL(5)=0 AND POINT(D-2,A+2)<3ANDPOINT(D-2,A+14)<3ANDS<>2THEN D=D-4:IFQ=4THENQ=3ELSEQ=4
450 K1=POINT(D-2,A+8):K2=POINT(D+18,A+8):K3=POINT(D+15,A+18):K4=POINT(D+8,A-1):K5=POINT(D+1,A+18)
460 IF(K3=8 ORK5=8)ANDK1=1ANDS=0THEN D=D-4
470 IF (K3=9 ORK5=9)ANDK2=1ANDS=0THEN D=D+4
480 IF K1=2 OR K2=2 OR K4=2 ORPOINT(D+8,A+18)=2THEN KL=1:GOTO 540
490 IF D>215 THEN P=P+1:D=13:AI=A:DI=D:SI=S:PI=PA:QI=Q:MI=M:GOTO 320
500 IF S=1 THEN 680'SALTO
510 IF S=3 THEN IF POINT(D+2,A+17)<3 AND POINT(D+14,A+17)<3 THEN630ELSE S=0
520 IFS=2 THENIF POINT(D+3,A+17)<3 ANDPOINT(D+14,A+17)<3 THEN GOTO 630 ELSES=0
530 IF (K3=1ANDPOINT(D+2,A+17)=1) OR(POINT(D+14,A+17)=1ANDK5=1) THEN S=2:GOTO 630ELSES=0'CAIDA
540 IFA>134THENA=134
550 IFA<8THENA=8
560 PUT SPRITE 0,(D,A),9,Q
570 IF (K1>9 OR K2>9 OR K3>9 OR K4>9ORK5>9)ANDPO=1 THEN 2310'LLAVE
580 IFE>0THENGOSUB750
590 IF KL=1 THEN KL=0:GOTO 2250
600 SPRITE ON:ON SPRITE GOSUB 2250
610 IF STRIG(1) ANDS=0THEN S=1:M=1:ST=0:IF PDL(3)=0 THEN PA=A-31 ELSE PA=A-50
620 GOTO 400
630 IF POINT(D+8,A+23)=1 THEN A=A+6:GOTO 540
640 IF POINT(D+8,A+22)=1 THEN A=A+5:GOTO 540
650 IF POINT(D+8,A+20)=1 THEN A=A+3:GOTO 540
660 IF POINT(D+8,A+19)=1 THEN A=A+2:GOTO 540
670 A=A+1:GOTO 540
680 IF Q=2 THEN Q=1
690 IF Q=4 THEN Q=3
700 IF M=1 THEN A=A-(A-PA)/5ELSE 730
710 IF POINT(D+2,A)>2 OR POINT(D+14,A)>2 ORA<PA+13THEN M=2:GOTO 730
720 GOTO 540
730 A=A+(A-PA)/5:IF POINT(D+2,A+25)>1ORPOINT(D+14,A+25)>1 THENM=1:S=3:GOTO 510
740 GOTO 540
750 FOR I=1 TOE:PO(I)=PO(I)+1:IFTE(I)=1THEN 800
760 DE(I)=DE(I)+ME(I):IF DE(I)>MM(I)THENME(I)=-ME(I):DE(I)=MM(I)
770 IF DE(I)<MN(I)THENME(I)=-ME(I):DE(I)=MN(I)
780 IF PO(I)>=PM(I)THEN PO(I)=PI(I)
790 PUT SPRITEI,(DE(I),AE(I)),CE(I),PO(I):NEXT:RETURN
800 AE(I)=AE(I)+ME(I):IF AE(I)>MM(I)THENME(I)=-ME(I):AE(I)=MM(I)
810 IF AE(I)<MN(I)THENME(I)=-ME(I):AE(I)=MN(I)
820 IF PO(I)>=PM(I)THEN PO(I)=PI(I)
830 PUT SPRITEI,(DE(I),AE(I)),CE(I),PO(I):NEXT:RETURN
840 DATA 26,9,10,4,41,10,4,73,10,4,201,10,4,105,10,2,137,10,2,169,10,2,9,112,4,41,112,4,73,112,4,105,112,4,137,112,4,169,112,4,201,112,4,201,27,5,201,44,5,201,61,5,9,27,5,9,44,5,9,61,5,9,78,5,9,95,5,105,95,7,105,78,7,105,61,7,41,78,7
850 DATA 1,1,180,66,94,34,4,4,5,5,9
860 DATA 0
870 DATA 24,9,10,4,41,10,4,73,10,4,105,10,4,137,10,4,169,10,4,201,10,4,9,112,4,73,112,4,137,112,4,201,112,4,9,27,5
880 DATA 9,44,5,9,61,5,201,27,5,201,44,5,201,61,5,9,129,2,41,129,2,73,129,2,105,129,2,137,129,2,169,129,2,201,129,2
890 DATA 1,1,110,60,111,50,4,4,5,8,9
900 DATA 0
910 DATA 19,9,10,4,41,10,4,73,10,4,105,10,4,137,10,4,169,10,4,201,10,4,9,27,5,9,44,5,9,61,5,9,112,4,41,112,4,105,95,4,137,95,4,169,78,4,201,27,5,201,61,5,201,78,5,73,112,2
920 DATA 1,2,115,76,150,105,4,4,5,2,9
930 DATA 0
940 DATA 31,9,10,4,41,10,4,73,10,4,105,10,4,137,10,4,169,10,4,201,10,4,9,27,5,9,61,5,9,78,5,9,95,5,9,112,5,41,61,7,73,61,7,105,61,7,73,95,7,105,95,7,137,95,7,169,95,7,201,27,5,9,129,4,41,129,4,73,129,4,105,129,4,137,129,4,169,129,4,201,129,4
950 DATA201,95,5,201,78,5,201,61,5,201,44,5
960 DATA 1,2,115,77,180,80,4,9,9,9,11
970 DATA 0
980 DATA 28,9,10,4,41,10,3,73,10,3,105,10,2,137,10,2,169,10,2,201,10,4,9,129,4,41,129,4,73,129,4,105,129,4,137,129,4,169,129,4,201,129,4,9,95,5,9,44,5,9,61,5,9,78,5,201,27,5,201,44,5,201,61,5,105,95,5,137,95,5,121,78,5,89,78,5,105,61,5,41,44,5,9
990 DATA 27,11
1000 DATA 2,1,180,66,110,34,6,4,5,5,9,2,100,28,160,80,4,9,9,9,13
1010 DATA 0
1020 DATA 24,9,10,4,41,10,4,73,10,4,105,10,4,137,10,4,169,10,4,201,10,4,9,129,2,41,129,4,73,129,4,137,78,15,137,44,2,137,61,2,137,129,4,201,129,4,201,27,5,201,44,5,201,61,5,201,78,5,201,95,5,201,112,5,9,27,5,9,44,5,9,61,5
1030 DATA 1,1,180,66,122,34,4,4,5,3,9
1040 DATA 3
1050 DATA 7,9,129,4,41,129,4,73,129,4,105,129,4,137,129,4,169,129,4,201,129,4
1060 DATA 1,1,110,60,111,50,4,4,5,8,9
1070 DATA 0
1080 DATA 7,9,129,4,41,129,4,73,129,4,105,129,4,137,129,4,169,129,4,201,129,4
1090 DATA 2,1,110,60,111,50,4,5,5,8,9,1,180,60,111,50,6,7,5,8,9
1100 DATA 0
1110 DATA 7,9,129,4,41,129,4,73,129,4,105,129,4,137,129,4,169,129,4,201,129,4
1120 DATA 1,2,115,90,180,50,8,9,9,3,12
1130 DATA 0
1140 DATA 7,9,129,4,41,129,4,73,129,4,105,129,4,137,129,4,169,129,4,201,129,4
1150 DATA 1,2,115,90,180,50,8,9,9,3,12
1160 DATA 0
1170 DATA 25,9,129,4,41,129,2,73,129,2,105,129,2,137,129,2,169,129,2,201,129,4,201,10,4,169,10,4,137,10,4,105,10,4,73,10,4,41,10,4,9,10,4,9,112,5,9,95,5,9,78,5,9,27,5,9,44,5,9,61,13,201,27,5,201,44,5,201,61,5,137,95,5,57,95,5
1180 DATA 2,1,110,54,111,50,4,5,5,8,9,1,40,60,111,45,6,7,5,7,9
1190 DATA 0
1200 DATA 21,9,10,4,41,10,4,73,10,4,105,10,4,137,10,4,169,10,4,201,10,4,201,129,4,169,129,4,137,129,4,105,129,2,73,129,4,9,129,4,9,27,5,9,44,5,9,61,5,201,78,5,201,61,5,201,44,5,201,27,5,73,69,2
1210 DATA 1,1,180,60,111,50,4,4,5,2,9
1220 DATA 0
1230 DATA 26,9,10,4,41,10,4,73,10,4,105,10,4,137,10,4,169,10,4,201,10,4,201,129,4,169,129,4,137,129,4,105,129,4,73,129,4,41,129,4,9,129,4,9,27,2,9,44,2,9,61,2,9,78,2,201,78,2,201,61,2,201,44,2,201,27,2,41,95,2,73,95,2,137,95,2,169,95,2
1240 DATA 1,1,105,60,111,50,4,4,5,8,9
1250 DATA 0
1260 DATA 21,9,10,4,41,10,4,73,10,4,105,10,4,137,10,4,169,10,4,201,10,4,9,129,4,41,120,4,73,112,4,105,103,4,137,95,4,169,86,4,201,78,4,201,61,4,201,44,4,201,27,4,9,27,5,9,44,5,9,61,5,9,78,5
1270 DATA 1,2,180,60,180,180,0,9,9,8,13
1280 DATA 0
1290 DATA 23,9,10,4,41,10,4,73,10,4,105,10,4,137,10,4,169,10,4,201,10,4,201,112,4,9,27,5,201,27,5,201,44,5,201,61,5,9,112,5,9,95,5
1300 DATA 9,44,5,9,61,5,9,78,5,9,129,4,73,129,9,105,129,9,137,129,9,169,129,9,201,129,9
1310 DATA 2,1,110,60,111,50,4,5,5,8,9,1,180,60,111,50,6,7,5,8,9
1320 DATA 0
1330 DATA 24,9,10,4,41,10,4,73,10,4,137,10,4,201,10,4,201,10,4,9,112,4,41,112,4,73,112,4,105,112,4,137,112,4,169,112,4,201,112,4,201,27,5,186,44,5,137,78,5,9,27,5,9,44,5,9,61,5,73,27,5,137,27,5,89,44,2,121,44,2,105,61,2
1340 DATA 1,1,50,30,90,50,4,4,5,8,9
1350 DATA 0
1360 DATA 34,9,10,4,41,10,4,73,10,4,105,10,4,137,10,4,169,10,4,201,10,4,9,129,4,41,129,4,73,129,4,105,129,4,137,129,4,169,129,4,201,129,4,9,27,5,9,44,5,9,112,4,201,27,5,201,44,5,201,61
1370 DATA 5,201,78,5,201,95,5,201,112,5,41,112,2,73,112,5,89,95,5,105,112,5,137,112,5,121,95,5,89,27,5,121,27,5,105,44,5,105,78,5,169,112,12
1380 DATA 1,1,110,60,111,40,4,4,5,5,9
1390 DATA 2
1400 DATA 27,9,10,4,41,10,4,73,10,4,105,10,4,137,10,4,169,10,4,201,10,4,9,129,4,41,129,4,73,129,4,105,129,4,137,129,4,169,129,4,201,129,4,9,27,5,9,44,5,9,61,5,201,112,5,201,44,5,201,95,5,201,61,5,201,78,5,201,129,5,169,61,5,153,78,5,137,95,5,121,112,5
1410 DATA 1,1,100,60,111,40,4,4,5,3,9
1420 DATA 0
1430 DATA 34,9,10,4,41,10,4,73,10,4,105,10,4,137,10,4,169,10,4,201,10,4,9,129,4,41,129,4,73,129,4,105,129,4,137,129,4,169,129,4,201,129,4,9,44,5,9,61,5,9,78,5,9,95,5,9,112,5,201,112,5,201,95,5,201,78,5,201,61,5,201,44,5,201
1440 DATA27,14,41,61,7,57,78,7,169,44,7,153,61,7,137,78,7,73,95,7,121,95,7,73,112,2,105,112,2
1450 DATA 1,2,100,27,180,50,6,9,9,7,13
1460 DATA 0
1470 DATA 31,9,10,4,41,10,4,73,10,4,105,10,4,137,10,4,169,10,4,201,10,4,201,129,4,169,129,4,137,129,4,9,129,4,41,129,4,73,129,4,9,112,5,9,95,5,9,78,5,9,61,5,9,44,5,9,27,5,201,27,5,201,44,5,201,61,5,201,78,5,201,95,5,201
1480 DATA 112,5,73,112,2,89,95,2,121,95,2,137,112,2,105,78,2,105,112,2
1490 DATA 1,2,115,47,180,80,4,9,9,9,11
1500 DATA0
1510 DATA 28,9,10,4,41,10,4,73,10,4,105,10,4,137,10,4,169,10,4,201,10,4,201,129,4,169,129,4,9,129,4,137,129,4,105,129,4,73,129,4,9,112,5,9,95,5,9,78,5,9,61,5,9,44,5,9,27,5,201,27,5,201,44,5,201
1520 DATA 61,5,201,78,5,89,112,5,105,95,5,137,95,5,153,112,5,121,112,8
1530 DATA 1,2,120,76,150,105,4,4,5,8,9
1540 DATA0
1550 DATA 27,9,10,4,73,10,4,105,10,4,137,10,4,169,10,4,201,10,4,201,129,4,9,129,4,41,129,4,73,129,4,105,129,4,137,129,4,169,129,4,9,27,5,9,44,5,9,61,5,9,78,5,201
1560 DATA 112,5,201,95,5,201,78,5,201,61,5,201,44,5,201,27,5,137,95,5,41,44,5,73,61,5,105,78,5
1570 DATA 1,1,180,60,111,50,6,4,5,3,9
1580 DATA0
1590 DATA 28,9,10,4,41,10,4,73,10,4,105,10,4,137,10,4,169,10,4,201,10,4,201,129,4,169,129,4,137,129,4,105,129,4,9,129,4,73,129,4,41,129,4,9,27,5,9,44,5,9,61,5,9,78,5,25,95,5,9,112,5,201,27,5,201,44,5,201,61,5,201,78,5,41
1600 DATA 27,10,73,78,9,137,112,9,105,112,2
1610 DATA 2,1,114,60,94,50,4,4,5,8,9,1,180,60,111,50,6,4,5,9,9
1620 DATA1
1630 DATA 23,9,10,4,41,10,4,73,10,4,105,10,4,137,10,4,169,10,4,201,10,4,201,27,5,201,44,5,201,61,5,201,78,5,201,95,5,201,112,5,201,129,4,9,27,5,9,44,5,9,61,5,9,78,5,9,129,9,41,129,9,73,129,9,105,129,9,137,129,9
1640 DATA 2,1,110,60,111,50,4,6,5,8,9,1,70,60,111,60,4,6,5,8,9
1650 DATA0
1660 DATA 28,9,10,4,73,10,4,105,10,4,137,10,4,169,10,4,201,10,4,201,129,4,169,129,4,9,129,4,41,129,4,73,129,4,105,129,2,137,129,2,25,27,5,9,44,5,9,61,5,9,78,5,25,95,5,9,112,5,201,27,5,201,44,5,201,61,5,201,78,5,121,95,5,121,61,2,121,44,2,121,27,2,63,61,5
1670 DATA 1,1,100,60,111,50,4,4,5,8,9
1680 DATA0
1690 DATA 22,9,129,4,9,10,4,41,10,4,73,10,4,105,10,4,137,10,4,169,10,4,201,10,4,201,129,4,9,27,5,9,44,5,9,61,5,9,78,5,201,78,5,201,27,5,201,44,5,201,61,5,41,129,9,73,129,9,105,129,9,137,129,9,169,129,9
1700 DATA 3,1,110,60,111,50,4,4,5,8,9,1,170,60,111,60,4,7,5,2,9,1,70,70,111,50,6,5,5,7,9
1710 DATA0
1720 DATA 22,9,10,4,41,10,4,73,10,4,105,10,4,137,10,4,169,10,4,201,10,4,9,129,4,41,129,4,73,129,2,105,112,4,137,95,4,169,78,4,201,78,4,201,27,2,201,44,2,9,27,5,9,44,5,9,61,5,9,78,5,73,95,5,105,95,2
1730 DATA 1,2,110,77,155,75,6,11,9,4,13
1740 DATA0
1750 DATA 28,9,10,4,41,10,4,73,10,4,105,10,4,137,10,4,169,10,4,201,10,4,9,27,2,9,44,2,9,78,4,201,129,4,169,129,4,137,129,4,41,78,4,73,78,4,105,78,4,105,129,4,105,112,4,105,95,4,137,112,2,105,44,2,201,27,5,201,44,5,201,61,5,137,27,2,105,27,2,105,27,2,169
1760 DATA112,4
1770 DATA 1,2,80,60,88,46,4,11,9,4,13
1780 DATA0
1790 DATA 26,9,10,4,41,10,4,73,10,4,105,10,4,137,10,4,169,10,4,201,10,4,201,129,4,9,129,4,9,27,5,9,44,5,9,61,5,9,78,5,201,78,5,201,61,5,201,44,5,201,27,5,41,129,8,73,129,8,105,129,8,137,129,8,169,129,8,41,78,2,73,78,2,137,78,2,169,78,2
1800 DATA 1,1,110,60,111,50,4,4,5,8,9
1810 DATA0
1820 DATA 27,9,10,4,41,10,4,73,10,4,201,10,4,169,10,4,137,10,4,9,129,4,41,129,4,137,129,4,169,129,4,201,129,4,201,27,5,201,44,5,201,61,5,201,78,5,201,95,5,201,112,5,9,27,5,9,44,5,9,61,5,9,78,5,73,129,2,73,95,7,89,61,7,105,44,7,137,27,7,105,95,7
1830 DATA 2,2,70,27,125,45,6,9,9,7,13,1,45,50,110,50,4,8,5,3,9
1840 DATA0
1850 DATA 26,9,10,4,73,10,4,105,10,4,137,10,4,169,10,4,201,10,4,41,129,9,73,129,9,105,129,9,137,129,9,169,129,9,9,129,4,201,129,4,9,27,5,9,44,5,9,61,5,9,78,5,9,95,5,9,112,5,201,27,5,201,44,5,201,61,5,201,78,5,41,44,5,57,78,9,73,112,9
1860 DATA 1,1,110,60,111,50,4,5,5,8,9
1870 DATA0
1880 DATA 23,9,10,4,41,10,4,73,10,4,105,10,4,137,10,4,169,10,4,201,10,4,201,129,4,9,129,4,169,129,8,41,129,9,137,129,2,73,129,2,105,129,5,105,112,5,201,78,5,201,61,5,201,44,5,201,27,5,9,27,5,9,44,5,9,61,5,9,78,5
1890 DATA 1,1,110,60,95,50,5,5,5,5,6
1900 DATA0
1910 DATA 31,9,10,4,73,10,4,105,10,4,137,10,4,169,10,4,201,10,4,9,129,4,41,129,4,73,129,4,105,129,4,137,129,4,169,129,4,201,129,4,9,27,5,9,44,5,9,61,5,9,78,5,201,27,5,201,44,5,201,61,5,201
1920 DATA 78,5,201,95,5,201,112,5,73,112,7,105,103,7,160,78,7,41,44,7,73,52,7,121,44,7,137,112,2,169,112,2
1930 DATA 1,1,42,60,110,70,4,4,5,8,9
1940 DATA0
1950 DATA 27,9,10,4,73,10,4,105,10,4,137,10,4,201,10,4,41,10,4,201,129,8,41,129,8,73,129,8,105,129,8,137,129,8,169,129,8,9,129,4,9,27,5,137,61,8,9,61,5,9,78,5,9,95,5,9,112,2,201,27,5,201,44,5,201,61,5,201,78,5,9,44,5,169,44,5,105,95,8,137,78,2
1960 DATA 1,1,85,60,111,50,4,4,5,8,9
1970 DATA0
1980 DATA 23,9,10,4,41,10,4,73,10,4,105,10,4,137,10,4,169,10,4,201,10,4,201,129,4,9,129,4,41,129,8,73,129,8,105,129,8,137,129,8,169,129,8,9,27,5,9,44,5,9,61,5,9,78,5,201,78,5,201,61,5,201,44,5,201,27,5,105,95,5
1990 DATA 2,2,60,111,120,48,5,9,9,7,13,2,180,111,180,140,5,11,9,5,13
2000 DATA0
2010 DATA 25,9,10,4,41,10,4,73,10,4,105,10,4,137,10,4,169,10,4,201,10,4,201,129,4,9,129,4,41,129,4,73,120,4,105,112,4,169,120,4,137,112,4,121,95,4,9,27,5,9,44,5,9,61,5,9,78,5,201,78,5,201,61,5,201,44,5,201,27,5,121,27,2,121,44,2
2020 DATA 2,1,48,60,111,50,4,4,5,8,9,1,180,100,97,50,4,7,5,9,9
2030 DATA0
2040 DATA 32,9,129,4,41,129,4,73,129,4,105,129,4,137,129,4,169,129,4,201,129,4,201,10,4,9,10,4,41,18,4,169,18,4,153,35,4,57,35,4,73,52,4,137,52,4,121,69,4,89,69,4,105,86,2,73,10,4,105,10,4,137,10,4,9,27,5,9,44,5,9,61,5,9,78,5,201,78,5
2050 DATA201,61,5,201,44,5,201,27,5,105,35,5,169,52,5,41,52,5
2060 DATA 2,2,55,111,110,50,5,9,9,8,13,2,125,111,180,120,5,9,9,6,13
2070 DATA0
2080 DATA 23,9,10,4,9,10,4,41,10,4,73,10,4,105,10,4,137,10,4,169,10,4,201,10,4,201,129,4,9,129,4,41,129,9,73,129,9,169,129,8,137,129,8,105,129,2,9,27,5,9,44,5,9,61,5,9,78,5,201,78,5,201,61,5,201,44,5,201,27,5
2090 DATA 1,2,90,111,180,45,6,9,9,3,13
2100 DATA0
2110 DATA 25,9,10,4,41,10,4,73,10,4,105,10,4,137,10,4,169,10,4,201,10,4,201,27,5,201,44,5,201,61,5,201,78,5,201,129,4,169,129,4,137,129,2,105,129,4,73,129,2,41,129,4,9,129,4,9,27,5,9,44,5,9,61,5,9,78,5,41,78,2,105,78,2,169,78,2
2120 DATA 1,2,115,77,180,50,8,9,9,2,12
2130 DATA0
2140 DATA 30,9,10,4,41,10,4,73,10,4,201,10,4,169,10,4,137,10,4,9,129,4,41,129,4,73,129,4,105,129,4,137,129,4,169,129,4,201,129,4,201,112,5,201,95,5,201,78,5,201,61,5,201,44,5,201,27,5,9,27,5,9,44,5
2150 DATA9,61,5,9,78,5,73,112,5,105,103,5,137,95,5,169,86,5,105,44,5,137,52,5,73,27,5
2160 DATA 1,1,45,60,111,50,4,4,5,8,9
2170 DATA0
2180 FORI=41 TO 72 :LINE(I,129)-(I,146),1:NEXT
2190 GOTO 400
2200 FORI=128 TO 77 STEP-1:LINE(201,I)-(233,I),1:NEXT
2210 GOTO 400
2220 FORI=128 TO 77 STEP-1:LINE(201,I)-(233,I),1:NEXT
2230 GOTO 400
2240 FORR=1 TO O:READL:FORI=1 TO L:READX,Y,C:NEXTI:READE:FORI=1TOE:READE,E,E,E,E,E,E,E,E,E:NEXTI:READW:NEXTR:RETURN
2250 FORI=1 TO 300:NEXT:SPRITE OFF
2260 IFTR=0THENV=V-1:IF V=-1 THEN 2280
2270 LINE(180,170)-(160,160),1,BF:COLOR 15:PRINT#1,V:COLOR 1:A=AI:D=DI:S=SI:Q=QI:PA=PI:M=MI:GOTO 540
2280 SCREEN2:COLOR 15:PRESET(70,100),1:PRINT#1,"JUEGO TERMINADO":PRESET(71,100),1:PRINT#1,"JUEGO TERMINADO"
2290 FORI=1TO2000:NEXT
2300 GOTO 2370
2310 PO=0:IF K1=11 OR K2=11 OR K3=11 OR K4=11 ORK5=11THENIF L1=0 THEN LINE(9,170)-(23,180),11,BF:L1=1:PO=0:X=2:Y=167:AW=1:GOTO 3190 ELSE 400
2320 IF K1=13 OR K2=13 OR K3=13 OR K4=13 ORK5=13THENIF L2=0 THEN LINE(24,170)-(39,180),13,BF:L2=1:PO=0:X=17:Y=167:AW=1:GOTO 3190 ELSE 400
2330 IF K1=14 OR K2=14 OR K3=14 OR K4=14 THENIF L3=0 THEN LINE(40,170)-(55,180),14,BF:L3=1:PO=0:AW=1:X=33:Y=167:GOTO 3190 ELSE 400
2340 IF K1=10 OR K2=10 OR K3=10 OR K4=10 ORK5=10THENIF L1=1 THEN LINE(9,170)-(23,180),1:L1=2:PO=0:H(1)=1:GOTO 2180ELSE 540
2350 IF K1=12 OR K2=12 OR K3=12 OR K4=12 ORK5=12THENIF L2=1 THEN LINE(24,170)-(39,180),1:L2=2:PO=0:H(2)=1:GOTO 2200ELSE 540
2360 IF K1=15 OR K2=15 OR K3=15 OR K4=15 ORK5=15THENIF L3=1 THEN LINE(40,170)-(55,180),1:L3=2:PO=0:H(3)=1:GOTO 2220ELSE 540
2370 SCREEN2:COLOR 7
2380 PSET (50,35)
2390 STOP ON:ON STOP GOSUB 2370
2400 LINE -(50,80)
2410 LINE -(75,80)
2420 LINE -(75,70)
2430 LINE -(60,70)
2440 LINE -(60,35)
2450 LINE -(51,35)
2460 LINE (83,80)-(108,35),,B
2470 LINE (98,45)-(93,70),,B
2480 PSET (115,80)
2490 LINE -(115,35)
2500 LINE -(145,35)
2510 LINE -(145,45)
2520 LINE -(125,45)
2530 LINE -(125,70)
2540 LINE -(135,70)
2550 LINE -(135,66)
2560 LINE -(132,66)
2570 LINE -(132,56)
2580 LINE -(145,56)
2590 LINE -(145,80)
2600 LINE -(115,80)
2610 LINE (154,80)-(164,35),,B
2620 PSET (170,80)
2630 LINE -(170,35)
2640 LINE -(195,35)
2650 LINE -(195,45)
2660 LINE -(180,45)
2670 LINE -(180,70)
2680 LINE -(195,70)
2690 LINE -(195,80)
2700 LINE -(170,80)
2710 LINE (200,85)-(45,30),,B
2720 LINE (42,27)-(203,88),,B
2730 PAINT (44,51)
2740 PAINT (55,51)
2750 PAINT (85,51)
2760 PAINT (119,51)
2770 PAINT (158,51)
2780 PAINT (175,51)
2790 COLOR 15
2800 PSET (50,106),POINT STEP (0,0):PRINT#1,"DISPARA PARA JUGAR"
2810 PSET (51,106),POINT STEP (0,0):PRINT#1,"DISPARA PARA JUGAR"
2820 PSET (50,176),POINT STEP (0,0):PRINT#1,"POR RAUL PORTALES"
2830 PSET (51,176),POINT STEP (0,0):PRINT#1,"POR RAUL PORTALES"
2840 PUT SPRITE 21,(190,170),11,21:PUTSPRITE22,(190,170),TC,22
2850 FORI=20 TO 150 STEP 4
2860 IF STRIG(1) THEN 190
2870 PUT SPRITE 1,(20,I),8,J:PUT SPRITE 2,(210,I),8,J
2880 FORR=1TO60:NEXTR:J=J+1:IF J=9 THEN J=5
2890 NEXT
2900 A$=INKEY$:IF A$="R" THEN IF TR=0THENTR=1:TC=7:PUT SPRITE 22,(190,170),TC,22ELSETR=0:TC=4:PUTSPRITE22,(190,170),TC,22
2910 FORI=150 TO 20 STEP -4
2920 IF STRIG(1) THEN 190
2930 PUT SPRITE 1,(20,I),8,J:PUT SPRITE 2,(210,I),8,J
2940 FORR=1TO60:NEXTR:J=J+1:IF J=9 THEN J=5
2950 NEXT
2960 GOTO 2850
2970 SCREEN2:COLOR 15:PSET(10,10):PRINT#1,"��LO HAS LOGRADO!!"
2980 PSET(11,10):PRINT#1,"��LO HAS LOGRADO!!"
2990 PSET(10,20):PRINT#1,"��SALISTE VIVO DEL CASTILLO!!"
3000 PSET(11,20):PRINT#1,"��SALISTE VIVO DEL CASTILLO!!"
3010 PSET(10,30):PRINT#1,"PERO...."
3020 PSET(11,30):PRINT#1,"PERO...."
3030 FOR I=1 TO800:NEXT
3040 IF TR=1 THEN 3270
3050 PSET(10,50):PRINT#1,"�COMO HAS TARDADO TANTO?"
3060 PSET(11,50):PRINT#1,"�COMO HAS TARDADO TANTO?"
3070 FOR I=1 TO800:NEXT
3080 PSET(10,70):PRINT#1,"NO IMPORTA PORQUE"
3090 PSET(11,70):PRINT#1,"NO IMPORTA PORQUE"
3100 PSET(10,80):PRINT#1,"ESTO NO ACABA AQUI"
3110 PSET(11,80):PRINT#1,"ESTO NO ACABA AQUI"
3120 FOR I=1 TO800:NEXT
3130 PSET(10,100):PRINT#1,"ESTATE ATENTO..."
3140 PSET(11,100):PRINT#1,"ESTATE ATENTO..."
3150 FORI=1 TO 260STEP4:IFQ=2THENQ=1ELSEQ=2
3160 PUT SPRITE1,(I,120),8,Q:NEXT
3170 PUT SPRITE1,(0,0),0,0
3180 FOR I=1 TO200:NEXT:GOTO 2370
3190 CIRCLE(X+10,Y+8),2,1:LINE(X+12,Y+8)-(X+19,Y+8),1:LINE-(X+19,Y+10),1:LINE(X+17,Y+8)-(X+17,Y+10),1
3200 IFAW=1THENAW=0:GOTO 400ELSEGOTO 360
3210 LINE(X+11,Y+8)-(X+17,Y+13),1,BF:CIRCLE(X+14,Y+7),3,1:LINE(X+14,Y+10)-(X+14,Y+11),C
3220 GOTO 360
3230 LINE(X+10,Y+8)-(X+22,Y+8),1:LINE-(X+19,Y+11),1:LINE(X+22,Y+8)-(X+19,Y+5),1
3240 GOTO 360
3250 LINE(X+22,Y+8)-(X+10,Y+8),1:LINE-(X+13,Y+11),1:LINE(X+10,Y+8)-(X+13,Y+5),1
3260 GOTO 360
3270 PSET(10,50):PRINT#1,"CON TRUCOS NO VALE"
3280 PSET(11,50):PRINT#1,"CON TRUCOS NO VALE"
3290 FOR I=1 TO2000:NEXT:GOTO 2370