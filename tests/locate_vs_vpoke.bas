1  screen 1
10 for i=0 to 20
20   for j=0 to 30
30     'locate j, i: print "1"
31     vpoke &H1800+i*32+j+1, 49
40   next j
50 next i
60 goto 60
