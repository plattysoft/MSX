## Sprites

Player (sprites 0 to 27)
```
9010 PUT SPRITE 1,(X,Y+YO),15,D:PUT SPRITE 0,(X,Y+4+YO),4,9+SA+D
9020 PUT SPRITE 2,(X,Y+14),14,1+ST+D
```
layer 0: arms
layer 1: body
layer 2: legs

D: 0 -  looking left
D: 14 - looking right


Enemies: (sprites 28 to 40)
```
9035  PUT SPRITE 3+I,(EX(I),EY(I)),14,25+ES(I)+ET(I)*3
```
ES(I) can be 0-3
ES(I) can be 1 to 4

Teleport: (sprites 41 to 44)


## Variables:

* R: Current row on the map
* C: Currnet row on the map

* X: Player's X position
* Y:  Player's Y position
* VX: Player's velocity on X
* VY: Player's velocity on Y
* PJ: Player's jump status:
  * 0 Standing on a platform
  * 1 First jump (not releaded keyboard)
  * 2 First jump, ready for second jump
  * 3 Second jump
  * -1 Falling (not initiated by a jump)
* PS: Player's sprite
  * 0 Open legs to the left (walking sprite 1 & jump sprite)
  * 1 Closed legs to the left (walking sprite 2)
  * 2 Open legs to the right (walking sprite 1 & jump sprite)
  * 3 Closed legs to the right (walking sprite 2)

* TH: Tile touching horizontally (middle)
* TG: Tile touching horizontally (top) T(H-1)
* TI: Tile touching horizontally (bottom) T(H+1)
* TV: Tile touching vertically (middle)
* TU: Tile touching vertically (left) T(V-1)
* TW: Tile touching vertically (right) T(V+1)
* TX: X contribution to pattern list to check vertical tiles (can be up or down)
* TY: Y contribution to pattern list to check horizontal tiles (can be left or right)

* TC: Tile central, to check if we are on top of something (maybe unnecessary now)


* I1: Item #1 collected: N-G Boots
* I2: Item #2 collected: Wall gloves
* I3: Item #3 collected: ID Card for swapping bricks

## Tile values

* 0-31 Background tiles we can walk over
  * 1 & 4: swappable floor tiles when on hidden
  * 5-6: Room limit on left-right, if touching move to next room
  * 30-31: Room limit on bottom-top, if touching more to next room

* 32-92: Solid tiles with different designs

* 93-127: Death tiles (including animations of rays)

* 128-159: Convoy belt tiles (including default values and animations)
  * 0-1: Tiles actually used (can be used for checking
  * (2-5): Animation tiles (0 maps to 2, 1 maps to 4 and they advance anc cycle

* 160- : Reserved for items.

## Program structure
