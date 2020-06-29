10 cls
20 interval on: on interval=30 gosub 1000
30 for i=0 to 10000: next i
40 interval off
50 gosub 1000
60 end

1000 locate 0,0:print using "PROGRESS: ###%";i/100
1010 return
