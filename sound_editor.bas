10 cls
11 screen 1,0,0
20 va=12
21 GOSUB 2000
25 tt=40
26 GOSUB 2100
27 SOUND 11,255
28 SOUND 12,255
30 A$=INKEY$
31 locate 1,3:print A$
40 if A$="a" then s0=&hAC:s1=1: GOSUB 1000
50 if A$="s" then s0=&h94:s1=1: GOSUB 1000
60 if A$="+" then va=va+1: GOSUB 2000
70 if A$="-" then va=va-1: GOSUB 2000
80 if A$="," then tt=tt*2: GOSUB 2100
90 if A$="." then tt=tt/2: GOSUB 2100
100 if A$="<" then wv=wv-1: GOSUB 2200
110 if A$=">" then wv=wv+1: GOSUB 2200
190 if TIME > st then SOUND 7,&b10111111: locate 1,3:print " ":
200 GOTO 30

1000 SOUND 0,s0 ' 8 least significant bits of frequency on channel A
1010 SOUND 1,s1 ' 4 most significant bits of frequency on channel A
1030 SOUND 7,&b10111110 ' Activates the sound generator on channel A
1040 st = TIME+tt
1050 RETURN

2000 if va>16 then va=15
2010 if va<0 then va=0
2020 SOUND 8, va
2030 locate 12,0:print "volume (+/-):"
2040 locate 24,0:print va
2050 return

2100 if tt>80 then tt=80
2110 if tt<5 then tt=5
2130 locate 12,1:print "tempo (,/.):"
2140 locate 24,1:print tt
2150 return

2200 if wv>13 then wv=13
2210 if wv<1 then wv=1
2220 sound 13,wv
2230 locate 12,2:print "wave (</>):"
2240 locate 24,2:print wv
2250 return
