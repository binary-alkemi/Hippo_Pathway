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

cp ../../../../protonate_Hplusus/chimera/gmx_edit_chimera.pdb .

/home/mandar/softwares/Autodock_ADFR/ADFRsuite_x86_64Linux_1.0/bin/prepare_receptor -r gmx_edit_chimera.pdb -o receptor.pdbqt

# downloaded from PDB entry (instance coordinates in SDF, hydrogen added via Pymol h_add)
cp ~/Downloads/6ge3_C_MYR.sdf .

mk_prepare_ligand.py -i Myr_H.sdf -o Myr_H.pdbqt

/home/mandar/softwares/Autodock_ADFR/ADFRsuite_x86_64Linux_1.0/bin/pythonsh /home/mandar/softwares/Autodock_ADFR/autodock_scripts/prepare_gpf.py -l Myr_H.pdbqt -r receptor.pdbqt -y

~/softwares/Autodock_ADFR/ADFRsuite_x86_64Linux_1.0/bin/autogrid4 -p receptor.gpf -l Myr_H.glg

/home/mandar/softwares/Autodock_vina2021/vina_1.2.3_linux_x86_64 --ligand ligand.pdbqt --maps receptor --scoring ad4 --out lig_ad4_out --exhaustiveness 32

mk_export.py ligand_vina_out.pdbqt -o ligand_vina_out.sdf

#pymol gmx_edit.pdb ligand_vina_out.sdf
