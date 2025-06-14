
set_property PACKAGE_PIN W7 [get_ports SEG[0]] ;# CA
set_property PACKAGE_PIN W6 [get_ports SEG[1]] ;# CB
set_property PACKAGE_PIN U8 [get_ports SEG[2]] ;# CC
set_property PACKAGE_PIN V8 [get_ports SEG[3]] ;# CD
set_property PACKAGE_PIN U5 [get_ports SEG[4]] ;# CE
set_property PACKAGE_PIN V5 [get_ports SEG[5]] ;# CF
set_property PACKAGE_PIN U7 [get_ports SEG[6]] ;# CG


set_property PACKAGE_PIN U2 [get_ports AN[0]] ;# AN0
set_property PACKAGE_PIN U4 [get_ports AN[1]] ;# AN1
set_property PACKAGE_PIN V4 [get_ports AN[2]] ;# AN2
set_property PACKAGE_PIN W4 [get_ports AN[3]] ;# AN3


set_property PACKAGE_PIN W5 [get_ports CLK]
set_property IOSTANDARD LVCMOS33 [get_ports CLK]


set_property IOSTANDARD LVCMOS33 [get_ports SEG[*]]
set_property IOSTANDARD LVCMOS33 [get_ports AN[*]]
