10 screen 2,2,1
101 BLOAD "sprites.bin",S
111 FOR i=1 to 12: PUT SPRITE i,(0, i*16-16),1,i:NEXT
112 goto 112