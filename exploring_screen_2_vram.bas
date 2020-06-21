1 ' For documentation, page 42 on http://rs.gr8bit.ru/Documentation/V9938-programmers-guide.pdf
2 ' The layout table is populated by default with the patterns in order and no BG/FG color
3 ' IF X-BASIC is installed, then uncomment next line (it'll go 15x times faster)
4 ' CALL TURBO ON
10 SCREEN 2
19 ' First we blank the screen (layout table) using the 1st character of the pattern table
20 FOR I=0 to 1535: VPOKE &H1800+i, 0: NEXT I
200 ' Remap the 2nd character and its colors to something else (on each 1/3rd of the screen)
211 FOR I=0 to 7:VPOKE i+8, 145: VPOKE &H2000+I+8, 12: next i
212 FOR I=0 to 7:VPOKE i+8+2048, 145: VPOKE &H2000+2048+I+8, 12:next i
213 FOR I=0 to 7:VPOKE i+8+4096, 145: VPOKE &H2000+4096+I+8, 12:next i
2200 ' Now, write the entire screen with the new character
2110 FOR I=0 to 1535
2130 VPOKE &H1800+i, 1' Pattern layout, starts on 0x1800, each 1/3 of the screen has its own map
2140 next i
2141 IF INKEY$="" THEN GOTO 2141
2145 ' Now remap the first one completely including colors
2150 FOR I=0 to 8:VPOKE i+8, 105: VPOKE &H2000+I+8, 24:next i
2200 GOTO 2200
