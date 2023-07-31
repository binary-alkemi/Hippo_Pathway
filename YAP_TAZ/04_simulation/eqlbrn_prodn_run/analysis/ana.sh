#!/bin/bash

 echo 26 25 | gmx_mpi trjconv -f ../md.xtc -s ../md.tpr -n ../index.ndx -pbc atom -ur compact -center -o cntr.xtc 
 
 echo 4 25 |  gmx_mpi trjconv -f cntr.xtc -s ../md.tpr -n ../index.ndx -fit rot+trans -o align.xtc

 echo 24 24 | gmx_mpi rms -f cntr.xtc -s ../md.tpr -n ../index.ndx -o rms_prot.xvg

 echo 24 13 | gmx_mpi rms -f cntr.xtc -s ../md.tpr -n ../index.ndx -o rms_lig_nofit.xvg -fit none

 echo 24 13 | gmx_mpi rms -f cntr.xtc -s ../md.tpr -n ../index.ndx -o rms_lig_fit.xvg

 rm -rf \#*
