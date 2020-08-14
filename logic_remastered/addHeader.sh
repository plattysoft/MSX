#!/bin/bash
for x in map_*; do 
  cat header.bin>src/$x.scr
  cat $x>>src/$x.scr
done
