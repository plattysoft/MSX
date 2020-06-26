# Raftoid
Raftoid is an Arkanoid-style game written in MSX Basic
It is not fast enough to be run as-is, so it needs to be compiled with x-basic/MSX-Basic-Kun or speed up the emulation CPU (about x3 is good)

Original implementation was using an array to check for bricks, we can VPEEK for the brick we have on the position instead, colors can be the same for multi-hit bricks.

This directory has some examples of partial code and details.

background_tile.bas: Example of generating the BG tiles using the VRAM and copying them

The actual version with all its files is in the `disk` directory, which is the one to be deplyed.
