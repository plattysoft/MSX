#!/bin/bash
mv level_0_0 level_A
mv level_1_0 level_B
mv level_2_0 level_C
mv level_3_0 level_D
mv level_4_0 level_E
mv level_5_0 level_F
mv level_6_0 level_G
mv level_7_0 level_H
mv level_8_0 level_I
mv level_9_0 level_J
mv level_10_0 level_K
mv level_11_0 level_L
mv level-12_0 level_M
mv level_13_0 level_N
mv level_14_0 level_O
mv level_15_0 level_P
mv level_16_0 level_Q
mv level_17_0 level_R
mv level_18_0 level_S
mv level_19_0 level_T
for x in level_*; do 
  ACTUAL_NAME=${x::7}
  echo "Converting $x to $ACTUAL_NAME"
  cat header.bin>src/$ACTUAL_NAME.scr
  cat $x>>src/$ACTUAL_NAME.scr
done
#rm level_*
