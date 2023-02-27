#!/bin/bash
OPENMSX_PATH=/usr/bin
PROGRAM_NAME=$1
killall openmsx
rm -Rf /tmp/tmpdsk 2>/dev/null
mkdir /tmp/tmpdsk
cp $PROGRAM_NAME /tmp/tmpdsk/autoexec.bas
$OPENMSX_PATH/openmsx -diska /tmp/tmpdsk
