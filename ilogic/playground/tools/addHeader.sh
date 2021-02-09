#!/bin/bash
PROJECT_HOME=$(pwd)
rm $PROJECT_HOME/src/map_*.scr 2>/dev/null
cd $PROJECT_HOME/res
for x in map_*; do 
  cat $PROJECT_HOME/tools/header.bin>$PROJECT_HOME/src/$x.scr
  cat $x>>$PROJECT_HOME/src/$x.scr
done
cd $PROJECT_HOME
