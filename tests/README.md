# Performance tests

All tests to be run on BASIC Vs X-Basic (MSX-BASIC-KUN)

## GENERAL

SET SPRITE Vs VPOKE

PUT SPRITE Vs VPOKE

FOR LOOP Vs Unwinded loop

## SCREEN 1

LOCATE x,y: PRINT "A" Vs VPOKE

**No significant difference without XBASIC**

VPOKE slightly faster with XBASIC, about the same speed on screen 2

It takes ~1 second to draw the screen on the best case

## SCREEN 2

LINE , BF Vs VPOKE of a defining sprite

Tile scrolling top to bottom and right to left (VPOKE)
 * BASIC Vs X-BASIC, FOR Vs unwinded
 * VPEEK + VPOKE Vs PEEK + VPOKE -> Much faster, the VDP access for read and write is ridiculous
 
Only done with FOR for now.

Smooth scrolling top to bottom (remap VPOKE)

Smooth scrolling of bricks (remap with tricks, repeating pattern)

