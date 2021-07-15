#!/bin/bash
GAME_NAME=raftoid

rm -Rf dist
mkdir dist
cp disk/*.* dist
mv dist/loader.bas dist/autoexec.bas

#  echo "<command>set power off</command>";
echo "<command>diskmanipulator create $GAME_NAME.dsk 720</command>">load_script
echo "<command>virtual_drive $GAME_NAME.dsk</command>">>load_script
echo "<command>diskmanipulator import virtual_drive dist/</command>">>load_script
echo "<command>exit</command>">>load_script

cat load_script | openmsx -control stdio

#echo "<command>set speed 500</command>">>load_script
#echo "<command>set power on</command>">>load_script
#for file in dist/*.bas
#do
#  name=${file##*/}
#  LOAD_CMD="load\\\"$name"
#  SAVE_CMD="save\\\\\"$name"
#  echo "<command>diska i$GAME_NAME.dsk</command>">load_script
#  echo "<command>type \"$LOAD_CMD\"</command>">>load_script
#  echo "<command>after idle 1 \"type \\\"$SAVE_CMD\\\"</command>">>load_script
#  echo "<command>after idle 1 exit</command>">>load_script
#done


# Tokenize all bas files


dsk2rom -afc 2 $GAME_NAME.dsk $GAME_NAME.rom 
