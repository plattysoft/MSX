4053 for k=0 to 900
4054   if k MOD 200 = 0 then color=(3,1,6,1)
4055   if k MOD 200 = 80 then color=(3,0,0,0)
4059 next k

4053 for k=0 to 900
4054   if k MOD 200 = 0 then  T$ = "                    ": GOSUB 9090
4055   if k MOD 200 = 80 then T$ = "PRESS SPACE TO START": GOSUB 9090
4059 next k

4053 for k=0 to 900
4054   if k MOD 200 = 0 then cc=&H00: GOSUB 4400
4055   if k MOD 200 = 80 then cc=&H20: GOSUB 4400
4059 next k

4400 'BLINK the text on middle map
4430 for i=vs to vs+26*8: VPOKE i,cc:NEXT I
4440 return
