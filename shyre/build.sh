#!/bin/bash
cp tiles/shyre.sc2 src/
cp tiles/intro.sc2 src/
cp tiles/start.sc2 src/
cp tiles/end.sc2 src/
cp tiles/room*plet5 src/
cd src
msxbas2rom -c -x shyre.bas;openmsx shyre.rom
