## CLOCK INPUT (100 MHz)
set_property PACKAGE_PIN W5 [get_ports clk]
set_property IOSTANDARD LVCMOS33 [get_ports clk]

## RESET (BTN0)
set_property PACKAGE_PIN U18 [get_ports rst]
set_property IOSTANDARD LVCMOS33 [get_ports rst]

## VGA RED
set_property PACKAGE_PIN G19 [get_ports {RED[0]}]
set_property PACKAGE_PIN H19 [get_ports {RED[1]}]
set_property PACKAGE_PIN J19 [get_ports {RED[2]}]
set_property PACKAGE_PIN N19 [get_ports {RED[3]}]
set_property IOSTANDARD LVCMOS33 [get_ports {RED[*]}]

## VGA GREEN
set_property PACKAGE_PIN J17 [get_ports {GREEN[0]}]
set_property PACKAGE_PIN H17 [get_ports {GREEN[1]}]
set_property PACKAGE_PIN G17 [get_ports {GREEN[2]}]
set_property PACKAGE_PIN D17 [get_ports {GREEN[3]}]
set_property IOSTANDARD LVCMOS33 [get_ports {GREEN[*]}]

## VGA BLUE
set_property PACKAGE_PIN N18 [get_ports {BLUE[0]}]
set_property PACKAGE_PIN L18 [get_ports {BLUE[1]}]
set_property PACKAGE_PIN K18 [get_ports {BLUE[2]}]
set_property PACKAGE_PIN J18 [get_ports {BLUE[3]}]
set_property IOSTANDARD LVCMOS33 [get_ports {BLUE[*]}]

## VGA HSYNC
set_property PACKAGE_PIN P19 [get_ports HS]
set_property IOSTANDARD LVCMOS33 [get_ports HS]

## VGA VSYNC
set_property PACKAGE_PIN R19 [get_ports VS]
set_property IOSTANDARD LVCMOS33 [get_ports VS]
