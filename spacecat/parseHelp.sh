#!/bin/bash
mv level_0_0 loading 
mv level_1_0 start
mv level_2_0 end
mv level_3_0 help_1
mv level_4_0 help_2
mv level_5_0 help_3
mv level_6_0 help_4
mv level_7_0 help_5
mv level_8_0 help_6
for x in help_*; do 
  cat header.bin>src/$x.scr
  cat $x>>src/$x.scr
done
cat header.bin>src/start.scr
cat start >>src/start.scr
cat header.bin>src/loading.scr
cat loading >>src/loading.scr
#rm level_*
