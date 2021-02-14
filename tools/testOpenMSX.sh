#!/bin/bash
OPENMSX_PATH=/Applications/openMSX.app/Contents/MacOS
PROGRAM_NAME=$1
EXTENSION=${PROGRAM_NAME##*\.}
ACTUAL_NAME=${PROGRAM_NAME%\.*}
MSX_FILE_NAME="${ACTUAL_NAME::8}.${EXTENSION::3}"

WORKING_DIR=$2
killall openmsx
(
  echo "<command>set renderer SDL</command>";
  echo "<command>diska insert $WORKING_DIR</command>";
  echo "<command>debug set_watchpoint write_mem 0xfffe {[debug read \"memory\" 0xfffe] == 0} {quit}</command>";
  #echo "<command>set throttle off</command>";
  echo "<command>set power on</command>";
  echo "<command>type_via_keybuf \\r\\r</command>"
  echo "<command>type_via_keybuf load\"$MSX_FILE_NAME\r</command>";
  echo "<command>type_via_keybuf save\"$MSX_FILE_NAME\r</command>";
  echo "<command>type_via_keybuf load\"$MSX_FILE_NAME\r</command>";
  #echo "<command>after idle 1 \"type_via_keybuf save\\\"$MSX_FILE_NAME\\\r\"</command>";
  echo "<command>type_via_keybuf poke-2,0\\r</command>";
) | $OPENMSX_PATH/openmsx -control stdio
