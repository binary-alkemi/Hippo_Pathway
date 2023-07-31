#!/bin/bash

ambpdb -p 0.15_80_10_pH7.4_final_loop_refined.top -c 0.15_80_10_pH7.4_final_loop_refined.crd > 0.15_80_10_pH7.4_final_loop_refined.pdb

gmx_mpi editconf -f 0.15_80_10_pH7.4_final_loop_refined.pdb -resnr 217 -o gmx_edit_chimera.pdb
