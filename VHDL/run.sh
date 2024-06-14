#!/bin/sh

ghdl -r processador_tb  --wave=wave.ghw
gtkwave wave.ghw
