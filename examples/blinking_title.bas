4053 for k=0 to 900 
4054   if k MOD 200 = 0 then color=(3,1,6,1)
4055   if k MOD 200 = 100 then color=(3,0,0,0)
4059 next k

4400 'BLINK the text on middle map
4401 vs = &H2000+2048+65*8
4410 cc = VPEEK (vs)
4420 if cc=&H30 then cc=0 else cc=&H30
4430 for i=vs to vs+26*8: VPOKE i,cc:NEXT I
4440 return
