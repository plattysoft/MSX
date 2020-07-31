Notes about the code of LOGIC

## Level Data:

NumberOfBricks, {X, Y, Color} per brick
Number of enemies, {TG, DE, AE, MM, MN, ME, PO, PI, CE, PM}
Wall (0, 1, 2 or 3, a wall is opened by a key of the same number)

Brick Colors:
* 2: Acid brick (instant kill)
* 3: Green, looks acid, but it does not kill
* 4, 5, 7: Blue solid bricks
* 6: Not used (it is the color of the main character) 
* 8, 9: Convoy belts
* 10, 11: Key(1) -> Lock
* 12, 13: Key(2) -> Lock
* 14, 15: Key(3) -> Lock

## Variables:
L1,L2,L3 1 if the player has the key, 0 if not
H(1..3) If a particular wall (key) has been opened
P: Current room, starts at 1. There are 4 floors of 10 rooms each
