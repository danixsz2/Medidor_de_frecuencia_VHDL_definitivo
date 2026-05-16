## CLOCK 100 MHz
set_property PACKAGE_PIN W5 [get_ports clk100MHz]
set_property IOSTANDARD LVCMOS33 [get_ports clk100MHz]
create_clock -period 10.000 -name sys_clk_pin -waveform {0 5} [get_ports clk100MHz]


## RESET BUTTON (BTNC)
set_property PACKAGE_PIN U18 [get_ports rst]
set_property IOSTANDARD LVCMOS33 [get_ports rst]


## BUTTON INPUT (BTNU)
set_property PACKAGE_PIN T18 [get_ports btn_input]
set_property IOSTANDARD LVCMOS33 [get_ports btn_input]


## SWITCH SELECTOR (SW0)
set_property PACKAGE_PIN V17 [get_ports sw]
set_property IOSTANDARD LVCMOS33 [get_ports sw]


## EXTERNAL INPUT (PMOD JA1)
set_property PACKAGE_PIN J1 [get_ports ext_input]
set_property IOSTANDARD LVCMOS33 [get_ports ext_input]
set_property PULLDOWN true [get_ports ext_input]


## 7-SEGMENT DISPLAY SEGMENTS
## seg[0] = CA
## seg[1] = CB
## seg[2] = CC
## seg[3] = CD
## seg[4] = CE
## seg[5] = CF
## seg[6] = CG

set_property PACKAGE_PIN W7 [get_ports {seg[0]}]
set_property PACKAGE_PIN W6 [get_ports {seg[1]}]
set_property PACKAGE_PIN U8 [get_ports {seg[2]}]
set_property PACKAGE_PIN V8 [get_ports {seg[3]}]
set_property PACKAGE_PIN U5 [get_ports {seg[4]}]
set_property PACKAGE_PIN V5 [get_ports {seg[5]}]
set_property PACKAGE_PIN U7 [get_ports {seg[6]}]

set_property IOSTANDARD LVCMOS33 [get_ports seg[*]]


## 7-SEGMENT DISPLAY ANODES
## an[0] = display derecho
## an[1] = segundo desde la derecha
## an[2] = tercero desde la derecha
## an[3] = display izquierdo

set_property PACKAGE_PIN U2 [get_ports {an[0]}]
set_property PACKAGE_PIN U4 [get_ports {an[1]}]
set_property PACKAGE_PIN V4 [get_ports {an[2]}]
set_property PACKAGE_PIN W4 [get_ports {an[3]}]

set_property IOSTANDARD LVCMOS33 [get_ports an[*]]


## LEDs
set_property PACKAGE_PIN U16 [get_ports {led[0]}]
set_property PACKAGE_PIN E19 [get_ports {led[1]}]
set_property PACKAGE_PIN U19 [get_ports {led[2]}]
set_property PACKAGE_PIN V19 [get_ports {led[3]}]
set_property PACKAGE_PIN W18 [get_ports {led[4]}]
set_property PACKAGE_PIN U15 [get_ports {led[5]}]
set_property PACKAGE_PIN U14 [get_ports {led[6]}]
set_property PACKAGE_PIN V14 [get_ports {led[7]}]
set_property PACKAGE_PIN V13 [get_ports {led[8]}]
set_property PACKAGE_PIN V3 [get_ports {led[9]}]
set_property PACKAGE_PIN W3 [get_ports {led[10]}]
set_property PACKAGE_PIN U3 [get_ports {led[11]}]
set_property PACKAGE_PIN P3 [get_ports {led[12]}]
set_property PACKAGE_PIN N3 [get_ports {led[13]}]
set_property PACKAGE_PIN P1 [get_ports {led[14]}]
set_property PACKAGE_PIN L1 [get_ports {led[15]}]

set_property IOSTANDARD LVCMOS33 [get_ports led[*]]
