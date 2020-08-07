#!/bin/bash
rm map_*.scr
for x in map_*; do 
  cat header.bin>$x.scr
  cat $x>>$x.scr
done
