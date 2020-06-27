# Raftoid
Raftoid is an Arkanoid-style game written in MSX Basic
It is not fast enough to be run as-is, so it needs to be compiled with x-basic/MSX-Basic-Kun or speed up the emulation CPU (about x3 is good)

Original implementation was using an array to check for bricks, we can VPEEK for the brick we have on the position instead, colors can be the same for multi-hit bricks.

This directory has some examples of partial code and details.

background_tile.bas: Example of generating the BG tiles using the VRAM and copying them

The actual version with all its files is in the `disk` directory, which is the one to be deplyed.


init: Load Sprites, Tiles and font

100 - Game Loop

...

490 - End of game loop

500 - Paddle bounce

600 - Game over

650 - Brick hit at sa, sb subroutine (can detect move to next level)

800 - Load level `L` subroutine

900 - Level data

3900 - CLS Subroutine

4000 - Start screen

4100 - Draw background subroutine

6000 - Load Sprites subroutine

6100 - Sprites Data

7000 - Load tiles subroutine

8000 - Tile pattern data

8300 - Tile color data

9000 - Load font subroutine

9090 - Print text on screen subroutine

9100 - Font data
