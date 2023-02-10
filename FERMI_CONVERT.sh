#!/bin/sh

cat DOS.dat| awk '{print $1}' | sed '1d' > ENERGY_MESH.dat 

python3 FERMI_CONVERT.py > CONVERTED_ENERGY_LIST.DAT
cat CONVERTED_ENERGY_LIST.DAT | awk '{print $2}' > CONVERTED_ENERGY.dat 

cat DOS.dat| awk '{print $2 "  " $3 "  " $4 "  " $5}' | sed '1d' > DOS_edit.dat

paste CONVERTED_ENERGY.dat  DOS_edit.dat |paste CONVERTED_ENERGY.dat  DOS_edit.dat | awk '{print "   "$1 "     " $2 "    " $3 "    " $4  "   " $5}' > DOS_FERMI=ZERO.dat

rm DOS.dat
#rm FERMI_ENERGY.log 
rm CONVERTED_ENERGY_LIST.DAT DOS_edit.dat
