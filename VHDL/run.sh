#!/bin/sh

ghdl -r microprocessor_tb --wave=wave.ghw
gtkwave wave.ghw
