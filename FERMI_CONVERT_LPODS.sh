#!/bin/sh

cat PDOS.dat| awk '{print $1}' | sed '1d' > ENERGY_MESH.dat 

python3 FERMI_CONVERT.py > CONVERTED_ENERGY_LIST.dat
cat CONVERTED_ENERGY_LIST.dat | awk '{print $2}' > CONVERTED_ENERGY.dat 

cat PDOS.dat| awk '{print $2 "  " $3 }' | sed '1d' > PDOS_edit.dat

paste CONVERTED_ENERGY.dat  PDOS_edit.dat  > PDOS_FERMI=ZERO.dat

#rm DOS.dat
#rm FERMI_ENERGY.log 
rm CONVERTED_ENERGY_LIST.dat PDOS_edit.dat
