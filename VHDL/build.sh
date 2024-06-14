#!/bin/sh

ghdl -a reg/reg1bit.vhd
ghdl -e reg1bit

ghdl -a reg/reg16bits.vhd
ghdl -e reg16bits

ghdl -a reg/reg7bits.vhd
ghdl -e reg7bits

ghdl -a ula/ula.vhd
ghdl -e ula

ghdl -a ula/ula_tb.vhd
ghdl -e ula_tb

ghdl -a maq_estados/maq_estados.vhd
ghdl -e maq_estados

ghdl -a un_controle/un_controle.vhd
ghdl -e un_controle

ghdl -a rom/rom.vhd
ghdl -e rom

ghdl -a rom/rom_tb.vhd
ghdl -e rom_tb

ghdl -a bank8reg/bank8reg.vhd
ghdl -e bank8reg

ghdl -a processador.vhd
ghdl -e processador

ghdl -a processador_tb.vhd
ghdl -e processador_tb
