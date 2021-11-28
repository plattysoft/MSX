# Raftoid

The era and time of this story is mostly unknown.
After contact was lost with the mother ship "Arkanoid", a search and rescue ship "Raftoid" was sent
It took many years to arrive at the place, only to be warped in space too, just a little diffent this time

# Raftoid now has a level editor!

Try it out here: https://webmsx.org/?MACHINE=MSX1&DISK=https://github.com/plattysoft/MSX/blob/master/raftoid/output/raftoid.dsk?raw=true

# Intro

Raftoid is an Arkanoid-style game written in MSX Basic
It is not fast enough to be run as-is, so it needs to be compiled with x-basic/MSX-Basic-Kun

This directory has some examples of partial code and details.

The actual version with all its files is in the `disk` directory, which is the one to be deplyed.

Try the current version on WebMXS: https://webmsx.org/?DISK=https://github.com/plattysoft/MSX/raw/master/raftoid/Raftoid.dsk&MACHINE=MSX1E


## PowerUps:

Current powerups:

* Yellow ("Rich"): bricks give double points
* Blue ("Anchor"): ball sticks to the paddle
* Red ("Fireball"): ball gets through bricks

## Extra lives

There are extra lives at
* 5000
* 10000
* 20000
* 40000
* 80000
... and so on

## Levels

There are 5 levels, once completed, the game cycles them again

* Wall
* Face
* Diamond
* Arrow
* Wave

There are 3 backgrounds, so to see each level with each background you need to reach Stage 15. After that point it just repeats.

# Source Code structure

Tiles and font are defined into a .sc2 file, which is loaded as part of the init script.


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

9090 - Print text on screen subroutine
