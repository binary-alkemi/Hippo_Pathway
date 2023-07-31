#! /bin/bash

#activate docking_env
### Define PATHS here:
OBABEL="/home/mandar/softwares/openbabel_24/exec/bin/obabel"

PREP_LIG="/home/mandar/softwares/Autodock_ADFR/ADFRsuite_x86_64Linux_1.0/bin/prepare_ligand"

PREP_RECEPTOR="/home/mandar/softwares/Autodock_ADFR/ADFRsuite_x86_64Linux_1.0/bin/prepare_receptor"

PYTHONSH="/home/mandar/softwares/Autodock_ADFR/ADFRsuite_x86_64Linux_1.0/bin/pythonsh"

PREPARE_GPF="/home/mandar/softwares/AutoDock-Vina/example/autodock_scripts/prepare_gpf.py"

VINA="/home/mandar/softwares/Autodock_vina2021/vina_1.2.3_linux_x86_64"


################### Deleting old files ##########################################################################

##################################################################################################################

## Taking H++ webserver processed pdb
cp ../../../../protonate_Hplusus/chimera/gmx_edit_chimera.pdb .

##
$PREP_RECEPTOR -r gmx_edit_chimera.pdb -o receptor.pdbqt

## gridcenter and npts from ../MYR_grid_file/receptor.gpf

/home/mandar/softwares/Autodock_ADFR/ADFRsuite_x86_64Linux_1.0/bin/pythonsh /home/mandar/softwares/Autodock_ADFR/autodock_scripts/prepare_gpf.py -l ligand.pdbqt -r receptor.pdbqt -p npts='40,40,40' -p gridcenter='1.817,2.236,22.642' 

~/softwares/Autodock_ADFR/ADFRsuite_x86_64Linux_1.0/bin/autogrid4 -p receptor.gpf -l ad4_lig.glg

home/mandar/softwares/Autodock_vina2021/vina_1.2.3_linux_x86_64 --ligand ligand.pdbqt --maps receptor --scoring ad4 --out lig_ad4_out --exhaustiveness 32 > log.txt&

mk_export.py lig_ad4_out.pdbqt -o lig_ad4_out.sdf

obabel -isdf lig_ad4_out.sdf -osdf -O split_poses/quinoline_.sdf -m
#pymol gmx_edit.pdb ligand_vina_out.sdf
