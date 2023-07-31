#!/bin/bash

 cp /home/mandar/YAP_TAZ/TEAD4_YAP/docking/chimera/AD4_scoring/quinoline_grid_file/split_poses/quinoline_1.sdf .
 
 cp /home/mandar/YAP_TAZ/TEAD4_YAP/protonate_Hplusus/chimera/gmx_edit_chimera.pdb .

 acpype -i quinoline_1.sdf

 gmx_mpi editconf -f quinoline_1.acpype/quinoline_1_GMX.gro -o quinoline_1_GMX.pdb
 cat gmx_edit_chimera.pdb quinoline_1_GMX.pdb > complex.pdb

 ## edit by hand to remove REMARK and COMMENTS

 gmx_mpi editconf -f complex.pdb -o tmp.pdb -resnr 217
### remove OXT atom from tmp.pdb

cat << EOF >| tleap.in
verbosity 1
source leaprc.protein.ff14SB
source leaprc.gaff
source leaprc.water.tip3p
loadoff quinoline_1.acpype/quinoline_1_AC.lib
loadamberparams quinoline_1.acpype/quinoline_1_AC.frcmod
complex = loadpdb tmp.pdb
solvatebox complex TIP3PBOX 10.0
addions complex Na+ 18
addions complex Cl- 13
saveamberparm complex ComplexAmber.prmtop ComplexAmber.inpcrd
savepdb complex Complex_tleap.pdb
quit
EOF

acpype -p ComplexAmber.prmtop -x ComplexAmber.inpcrd
