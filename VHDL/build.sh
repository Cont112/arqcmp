#!/bin/sh

ghdl -a mux1x2/mux1x2.vhd
ghdl -e mux1x2

ghdl -a decoder2x4/decoder2x4.vhd
ghdl -e decoder2x4

ghdl -a detector_paridade/detector_paridade.vhd
ghdl -e detector_paridade

ghdl -a flipflop_t/flipflop_t.vhd
ghdl -e flipflop_t

ghdl -a porta/porta.vhd
ghdl -e porta

ghdl -a reg/reg16bits.vhd
ghdl -e reg16bits

ghdl -a reg/reg7bits.vhd
ghdl -e reg7bits

ghdl -a soma_e_subtrai/soma_e_subtrai.vhd
ghdl -e soma_e_subtrai

ghdl -a ula/aritmetica.vhd
ghdl -e ula

ghdl -a ula/ula.vhd
ghdl -e ula

ghdl -a maq_estados/maq_estados.vhd
ghdl -e maq_estados

ghdl -a maq_estados/maq_estados_tb.vhd
ghdl -e maq_estados_tb

ghdl -a mux8x1/mux8x1.vhd
ghdl -e mux8x1

ghdl -a demux1x8/demux1x8.vhd
ghdl -e demux1x8

ghdl -a pc/un_controle.vhd
ghdl -e un_controle

ghdl -a rom/rom.vhd
ghdl -e rom

ghdl -a rom/rom_tb.vhd
ghdl -e rom_tb

ghdl -a bank8reg/bank8reg.vhd
ghdl -e bank8reg

ghdl -a bank8reg/bank8reg_tb.vhd
ghdl -e bank8reg_tb

ghdl -a microprocessor.vhd
ghdl -e microprocessor

ghdl -a microprocessor_tb.vhd
ghdl -e microprocessor_tb

ghdl -a pc/pc_toplevel.vhd
ghdl -e pc_toplevel

ghdl -a pc/pc_toplevel_tb.vhd
ghdl -e pc_toplevel_tb