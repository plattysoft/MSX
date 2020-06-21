1 ' For documentation, page 42 on http://rs.gr8bit.ru/Documentation/V9938-programmers-guide.pdf
10 SCREEN 2
19 FOR I=0 to 6143
20 VPOKE &H2000+I, i MOD 255 'Pattern colors, starts on 0x2000 and has a byte per line (FG and BG color)
21 VPOKE i, i MOD 255 'Pattern generator table (Starts on 0 on screen 2)
40 next 
100 If INKEY$="" goto 100
101 ' Not sure how to use the pattern locator yet (should be the same as placing a pattern generated and with color on a position on screen
110 FOR I=0 to 6143
130 VPOKE &H1800+i, i MOD 255' Pattern layout, starts on 0x1800
140 next i
200 GOTO 200
