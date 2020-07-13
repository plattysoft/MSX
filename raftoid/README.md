# Raftoid
Raftoid is an Arkanoid-style game written in MSX Basic
It is not fast enough to be run as-is, so it needs to be compiled with x-basic/MSX-Basic-Kun or speed up the emulation CPU (about x3 is good)

Original implementation was using an array to check for bricks, we can VPEEK for the brick we have on the position instead, colors can be the same for multi-hit bricks.

This directory has some examples of partial code and details.

background_tile.bas: Example of generating the BG tiles using the VRAM and copying them

The actual version with all its files is in the `disk` directory, which is the one to be deplyed.

Try the current version on WebMXS: https://webmsx.org/?DISK=https://github.com/plattysoft/MSX/raw/master/raftoid/Raftoid.dsk&MACHINE=MSX1E


## PowerUp ideas:

It would be nice to have RAFT as letters for the bonus

Right now the sprite is the full letter+ bubble, but rolling letters can be 8x8 sprites instead and then we can use 2 colors for them (BG + Letter)

Only one powerup falling at a time, random value based on brick?

Most likely

* M: Magnet: gives 10 magnets, paddle turns same color as powerup (blue)
* F: Fireball: ball does not bounce except on undestructible bricks, lasts for 5 bounces on paddle) ball turns red (red)
* L: Life up

Ideas

* P: Bonus points
* W: Warp level
* S: safe line under paddle
* T: Tripple balls

R: 
A: Anchor (Magnet)
F: Fireball
T: 

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
