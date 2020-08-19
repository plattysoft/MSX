#!/bin/bash
for x in map_*; do 
  cat header.bin>src/$x.scr
  head -c 512 $x>>src/$x.scr
done
cat header_full.bin>src/map_0_0.scr
cat map_0_0>>src/map_0_0.scr
cat header_full.bin>src/start.scr
cat map_10_0>>src/start.scr
cat header_full.bin>src/end.scr
cat map_10_1>>src/end.scr
cat header_full.bin>src/loading.scr
cat map_10_2>>src/loading.scr
cat header_full.bin>src/over.scr
cat map_10_3>>src/over.scr
rm src/map_10*
