10 COLOR 2, 1, 1
20 SCREEN 2
100 FOR j=0 to 295
110 READ R$
120 VPOKE j, VAL("&H"+R$)
130 VPOKE &H2000+j, &H21
140 NEXT j
200 GOTO 200

999	'maps for A-Z, start at ASC(A) = 64
1000 DATA 02,06,0e,1e,3e,76,e6,76,fe,cc,d8,fe,cc,d8,f0,e0
1010 DATA 7e,fc,c0,c0,c0,c0,fc,7e,fe,fe,cc,d8,f0,e0,c0,80
1020 DATA fe,fe,00,fe,fe,00,fe,fe,ff,fe,c0,fc,f8,c0,c0,80
1030 DATA 7e,fc,c0,c0,c2,c6,fe,7f,c6,c6,c6,fe,fe,c6,c6,84
1040 DATA 38,38,38,38,38,38,30,20,02,06,06,06,06,06,7e,fe
1050 DATA ce,dc,f8,f0,f8,dc,ce,86,40,c0,c0,c0,c0,c0,fe,fc
1060 DATA 82,c6,ee,fe,fe,d6,c6,c6,c6,e6,f6,fe,de,ce,c6,42
1070 DATA 7c,fe,c6,c6,c6,c6,fe,7c,fc,fe,06,fe,fc,c0,c0,80
1080 DATA 7c,fe,c6,c6,d6,fe,7c,10,c8,dc,ce,dc,f8,dc,ce,86
1090 DATA fe,fe,80,fe,fe,02,fe,fe,fe,fc,30,30,30,30,30,20
1100 DATA 82,c6,c6,c6,c6,c6,fe,7c,03,06,cc,d8,f0,e0,c0,80
1110 DATA c6,c6,d6,fe,fe,ee,c6,82,86,ce,fc,78,3c,7e,e6,c2
1120 DATA 87,ce,fc,78,30,30,30,20,7e,fe,1c,38,70,e0,fe,fc
1130 'DATA f0,e0,f0,e0

1199 'maps for 0123456789: (start at ASC(0)=48)
1200 DATA 7c,fe,ce,d6,d6,e6,fe,7c,08,18,38,38,38,38,38,38
1210 DATA 7e,fe,1c,38,70,e0,fe,fc,fe,1c,38,7e,1c,38,70,e0
1220 DATA 1c,38,76,e6,fe,fe,06,04,fe,fc,c0,fc,fe,06,7e,fc
1230 DATA 1c,38,70,f4,ee,c6,fe,7e,7e,fe,0e,1c,38,70,e0,c0
1240 DATA 7c,fe,c6,fe,fe,c6,fe,7c,7e,7f,63,77,2f,0e,1c,38
1260 DATA 00,18,38,00,00,18,38,00