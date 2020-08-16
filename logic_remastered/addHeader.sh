#!/bin/bash
for x in map_*; do 
  cat header.bin>src/$x.scr
  head -c 512 $x>>src/$x.scr
done
cat header_full.bin>src/start.scr
cat map_10_0>>src/start.scr
cat map_10_1>>src/frame.scr
