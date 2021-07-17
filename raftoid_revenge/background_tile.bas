61 SCREEN 2
65 color 15,1,1
80 FOR j=0 to 79
81 READ R$
90 VPOKE j, VAL("&H"+R$)
110 VPOKE 2048+j, VAL("&H"+R$)
130 VPOKE 4096+j, VAL("&H"+R$)
150 next J
151 'Now read the colors
152 FOR j=0 to 79
153 READ C
155 VPOKE &H2000+j, C
156 VPOKE &H2000+2048+j, C
157 VPOKE &H2000+4096+j, C
158 NEXT J
1000 ' DRAW THE GRID
1160 FOR K=0 TO 23
1170 FOR I=0 TO 31
1180 if i MOD 2 = k MOD 2 THEN V=0 ELSE V=1
1181 if i=0 OR i=20 THEN V = K MOD 4 + 2
1183 if K=0 THEN V = 6 + I MOD 4
1184 if i>20 THEN V = 10
1189 VPOKE &H1800+i+K*32, V
1190 NEXT I
1200 NEXT K
1800 GOTO 1800

4000 'TILES PATTERN
4010 DATA E0,8F,0F,1E,1E,3D,30,7D
4020 DATA 7D,7D,70,B8,B0,D0,40,80
4100 DATA 7A,7A,7A,7A,7A,7A,7A,7A,7A,7A,7A,7A,7A,7A,7A,7A
4200 DATA 7E,BF,BF,BF,BF,00,BF,00,BF,00,BF,00,BF,BF,BF,7E
4210 DATA 00,7F,7F,7F,7F,7F,7F,00,00,FE,FE,FE,FE,FE,FE,00
4220 DATA 7A,FA,FA,FA,FA,FA,FA,7A,AE,AF,AF,AF,AF,AF,AF,AE

4300 'COLOR
4500 DATA 65,65,65,65,65,65,65,65
4600 DATA 65,65,65,65,65,65,65,65
4800 DATA 33,33,33,33,33,33,33,33,33,33,33,33,33,33,33,33
4900 DATA 49,35,35,35,35,33,35,33,35,33,35,33,35,35,35,49
4910 DATA 33,33,49,33,33,33,33,33,33,33,49,33,33,33,33,33
4920 DATA 33,33,33,33,33,33,33,33,33,33,33,33,33,33,33,33
