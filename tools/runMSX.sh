#!/bin/bash
OPENMSX_PATH=/Applications/openMSX.app/Contents/MacOS
PROGRAM_NAME=$1
killall openmsx
rm -Rf /tmp/tmpdsk 2>/dev/null
mkdir /tmp/tmpdsk
cp $PROGRAM_NAME /tmp/tmpdsk/autoexec.bas
$OPENMSX_PATH/openmsx -diska /tmp/tmpdsk
