#!/bin/bash

<<EOF
### minimzation
gmx_mpi grompp -f minim.mdp -c ComplexAmber_GMX.gro -p ComplexAmber_GMX.top -n index.ndx -o em.tpr
gmx_mpi mdrun -deffnm em -v

## NVT + PR
gmx_mpi grompp -f nvt.mdp -c em.gro -r em.gro -p ComplexAmber_GMX.top -o nvt.tpr
gmx_mpi mdrun -deffnm nvt -v 

## NPT contimuation + PR
 gmx_mpi grompp  -f npt.mdp -c nvt.gro -r nvt.gro -t nvt.cpt -p ComplexAmber_GMX.top -o npt.tpr
 gmx_mpi mdrun -deffnm npt -v 

#### check pressure density
 gmx_mpi  energy -f npt.edr -o pressure.xvg
 gmx_mpi energy -f npt.edr -o density.xvg
 
### Production run

gmx_mpi grompp -f prodn.mdp -c npt.gro -t npt.cpt -p ComplexAmber_GMX.top -o md.tpr
EOF
gmx_mpi mdrun -deffnm md -v -ntomp 4 -pin on -nb gpu &>log

