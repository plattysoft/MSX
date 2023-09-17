I intend to make a game that is inspired by Sokoban and Eggerland Mistery while having puzzles that take several rooms, like having a key far away from the key, in a style close to what a dungeon on the first Zelda feels like, without the combat.

Our main character is an astronaut that is exploring some alien ruins when an electric storm traps them in the planet.

Now they need to find the highest possible place where the teleport can have a lock at them, and there seems to be a tall building ahead, which looks similar to the an Aztec Pyramid.

Their fate now dependes on you.

Yes, I have played too many Zelda games and watched too much Star Trek


## Tile Structure

First 2 rows: (tiles 0 to 63) can be walked and pushed over (normal floor, open doors, floor switches)
Next 2 rows:  (tiles 64 to 127) can be walked but NOT pushed over (items, stairs, rough terrain)
Next 2 rows:  (tiles 128 to 191) can NOT be walked or pushed (walls, closed doors, crates, etc)
Last 2 rows:  Pushable objects, Font, numbers and other utility tiles

This means: Tile <128 can we walked over, tile>63 can NOT be pushed over
We only need to record the state for tiles <64 (all the other tiles can not be pushed over)
Special case is a crate, that maps to the floor under it when scanning the room

Items, floor switches and special floors check on the specific tile

Some tiles

* Crates
* Walls
* Doors
* Stairs
* Keys
* Floor Switches
* Icy floor
* Rough terrain
* Items (map, battery, compass, key)

[Play the current version](https://webmsx.org/?MACHINE=MSX1E&ROM_FORMAT=KonamiSCC&ROM=https://github.com/plattysoft/MSX/raw/develop/shyre/output/shyre.rom) (beware it might be completely broken as a WIP): 

# Notes on Sprites

Sprites 0 and 1 are crates and heavy crates
2 is walking  up.
There are 9 sprites: 3 frames of 3 sprites each (blue / white / black)
11 is walking right
20 is walking down
29 is walking left

38 is pushing upwars: 2 frames of 2 sprites each + a common black sprite
the common black sprite is needed so we can have enough sprites for the teleport sprites
43 is pushing righy
48 is pushing down
53 is pushing left

58 is teleport (4 frames)
and we have 2 sprites to spare WOHOO

Because of this organization, the backup sprite changes from being part of the walking image to be shared and the same for all frames of the animation. That part of the code is a bit obtuse, so I am leaving a note here in case I want to take this project again in the future
