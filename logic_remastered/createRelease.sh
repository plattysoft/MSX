#!/bin/bash
GAME_NAME=logic_r

rm -Rf dist
mkdir dist
cp src/* dist
#openMSXbatoken.py dist/loader.bas autoexec.bas -frb
#openMSXbatoken.py dist/$GAME_NAME.bas t_1.bas -frb
#openMSXbatoken.py dist/logic_o.bas t_2.bas -frb
#rm dist/loader.bas
#mv dist/t_1.bas dist/$GAME_NAME.bas
#mv dist/t_2.bas dist/logic_o.bas
mv dist/loader.bas dist/autoexec.bas
(
  echo "<command>set power off</command>";
  echo "<command>diskmanipulator create $GAME_NAME.dsk 720</command>";
  echo "<command>virtual_drive $GAME_NAME.dsk</command>";
  echo "<command>diskmanipulator import virtual_drive dist/</command>";
  echo "<command>exit</command>"
) | openmsx -control stdio

dsk2rom -afc 2 $GAME_NAME.dsk $GAME_NAME.rom 

