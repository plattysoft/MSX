1 ' For documentation, page 42 on http://rs.gr8bit.ru/Documentation/V9938-programmers-guide.pdf
10 SCREEN 2
11 FOR I=0 to 8:VPOKE i, 145:next i
12 FOR I=0 to 8:VPOKE i+2048, 145:next i
13 FOR I=0 to 8:VPOKE i+4096, 145:next i
19 FOR I=0 to 6143
20 VPOKE &H2000+I, 12 'Pattern colors, starts on 0x2000 and has a byte per line (FG and BG color)
21 'VPOKE i, i MOD 255 'Pattern generator table (Starts on 0 on screen 2)
40 next 
100 'If INKEY$="" goto 100
101 ' Not sure how to use the pattern locator yet (should be the same as placing a pattern generated and with color on a position on screen
110 FOR I=0 to 1536
130 VPOKE &H1800+i, 0' Pattern layout, starts on 0x1800, each 1/3 of the screen has its own map
140 next i
150 FOR I=0 to 8:VPOKE i, 105:next i
200 GOTO 200
900 ' The layout table is populated by default with the patterns, we can just pre-populate, blank out and then just copy
