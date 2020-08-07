#!/bin/bash
GAME_NAME=ilogic

rm -Rf dist
mkdir dist
cp *.scr dist
cp *.sc2 dist
cp $GAME_NAME.bas dist/
cp *.bin dist/
cp loader.bas dist/autoexec.bas

(
  echo "<command>set power off</command>";
  echo "<command>diskmanipulator create $GAME_NAME.dsk 720</command>";
  echo "<command>virtual_drive $GAME_NAME.dsk</command>";
  echo "<command>diskmanipulator import virtual_drive dist/</command>";
  echo "<command>exit</command>"
) | openmsx -control stdio

dsk2rom -afc 1 $GAME_NAME.dsk $GAME_NAME.rom 
