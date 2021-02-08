#!/bin/bash
GAME_NAME=ilogic

# Find a way to automate 
(
  echo "<command>set power off</command>";
  echo "<command>diskmanipulator create $GAME_NAME.dsk 720</command>";
  echo "<command>virtual_drive $GAME_NAME.dsk</command>";
  echo "<command>diskmanipulator import virtual_drive src/</command>";
  echo "<command>exit</command>"
) | openmsx -control stdio

dsk2rom -afc 1 output/$GAME_NAME.dsk output/$GAME_NAME.rom 

