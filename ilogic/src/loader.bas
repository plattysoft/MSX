10 color 2,1,1
20 SCREEN 2,2,0
30 'bload "raftoid.sc2",S
50 bload "xbasic.bin",R
70 ' Disable turbo if the machine is a MSX turbo
80 '#I &H3A, &H2D, &H00, &HFE, &H03, &H3E, &H80, &HCC, &H80, &H01
90 load "ilogic.bas",R