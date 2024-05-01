#!/bin/sh

ghdl -a bank8reg/bank8reg_tb.vhd
ghdl -e bank8reg_tb
ghdl -r bank8reg_tb --wave=wave.ghw

