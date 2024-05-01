#!/bin/sh
ghdl -a decoder2x4/decoder2x4.vhd
ghdl -e decoder2x4

ghdl -a detector_paridade/detector_paridade.vhd
ghdl -e detector_paridade

ghdl -a porta/porta.vhd
ghdl -e porta

ghdl -a reg16bits/reg16bits.vhd
ghdl -e reg16bits

ghdl -a soma_e_subtrai/soma_e_subtrai.vhd
ghdl -e soma_e_subtrai

ghdl -a ula/aritmetica.vhd
ghdl -e ula

ghdl -a ula/ula.vhd
ghdl -e ula

ghdl -a mux8x1/mux8x1.vhd
ghdl -e mux8x1

ghdl -a demux1x8/demux1x8.vhd
ghdl -e demux1x8

ghdl -a reg16bits/reg16bits.vhd
ghdl -e reg16bits

ghdl -a bank8reg/bank8reg.vhd
ghdl -e bank8reg
