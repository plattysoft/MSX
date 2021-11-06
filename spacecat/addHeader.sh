#!/bin/bash
for x in level*; do 
  ACTUAL_NAME=${x::7}
  echo "Converting $x to $ACTUAL_NAME"
  cat header.bin>src/$ACTUAL_NAME.scr
  cat $x>>src/$ACTUAL_NAME.scr
done
#rm level*
