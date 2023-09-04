#!/bin/bash
cp tiles/shyre.chr.plet5 src/
cp tiles/shyre.clr.plet5 src/
cp tiles/start.chr.plet5 src/
cp tiles/start.clr.plet5 src/
cp tiles/start.plet5 src/
cp tiles/end.plet5 src/
cp tiles/cls.plet5 src/
cp tiles/room*plet5 src/
cp sound/sfx.akx src/
pletter sprites.bin
cp sprites.bin.plet5 src/
cd src
msxbas2rom -c shyre.bas;mv shyre.rom ../output;cd ..;openmsx output/shyre.rom
