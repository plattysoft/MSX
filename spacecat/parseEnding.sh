#!/bin/bash
mv level_0_0 bad_end
mv level_1_0 good_end
mv level_2_0 best_end
cp end_header.bin src/bad_end.scr
cat bad_end >> src/bad_end.scr
cp end_header.bin src/good_end.scr
cat good_end >> src/good_end.scr
cp end_header.bin src/best_end.scr
cat best_end >> src/best_end.scr
rm bad_end
rm good_end
rm best_end
