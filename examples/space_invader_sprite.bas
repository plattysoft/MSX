10 DATA &b00011000
20 DATA &b00111100
30 DATA &b01111110
40 DATA &b11011011
50 DATA &b11111111
60 DATA &b00100100
70 DATA &b01011010
80 DATA &b10100101

100 DATA &b00011000
110 DATA &b00111100
120 DATA &b01111110
130 DATA &b11011011
140 DATA &b11111111
150 DATA &b01011010
160 DATA &b10000001
170 DATA &b01000010

190 Screen 1,1
200 for s=0 to 1
210   A$=""
220   for i=0 to 7
230     read C: A$=A$+CHR$(C)
240   next i
250   SPRITE$(s)=A$
260 next s
270 PUT SPRITE 0, (0,0), 15, S
280 if S=0 THEN S=1 else S=0
290 for i=0 to 200:Next
3000 GOTO 270
