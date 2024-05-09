#!/bin/sh

ghdl -r pc_toplevel_tb --wave=wave.ghw
gtkwave wave.ghw
