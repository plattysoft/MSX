#!/bin/bash
for x in map_*; do 
  cat header.bin>src/$x.scr
  cat $x>>src/$x.scr
done
cat header_full.bin>src/start.scr
cat start_0_0>>src/start.scr
