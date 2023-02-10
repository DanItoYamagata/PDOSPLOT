#!/bin/sh

#####################################################################################
## CODED BY DAN ITO (7-16 NOV. 2022)
## VER2: MODIFIED BY DAN ITO (22 NOV. 2022)
## VER5: MODIFIED BY DAN ITO (24 NOV. 2022)
######################################################################################
###############################################
# BE SURE THAT DOSCAR IN THE SAME DIRECTORY.
# MODIFY "ATOMList" "ORBLIST" IN BELOW.
###############################################

###############################################
# CHOOSE THE ATOMS' LABEL
# MODIFY THE "ATOMList" IN BELOW!!
###############################################
ATOMList=( 57 58 59 60 )
#Fe-N 49 50 51 52
#Fe-C 53 54 55 56

###############################################################################################################
# PICK UP THE LIST OF THE PDOS FOR EACH ELECTED ATOMS IN "ATOMList" FROM THE LPDOSCAR IN "test_$((vATOM)).txt".
###############################################################################################################
## BE AWARE !! ISPIN=2 SET IN INCAR!!!
## LPDOS MUST BE ALLIED BY energy, s(up), s(down), p_y, p_z, p_x, d_{xy}, d_{yz}, d_{z^2-r^2}, d_{xz}, d_{x2-y2},
# 5 6 8 -- t2g
# 7 9 -- eg

ORBList=( 1 2 3 4 5 6 7 8 9 )

######################################################################################
# 1.TOTAL DOS PLOT
######################################################################################
# THE NUMBER OF THE ENERGY MESH OF DOS.
TMESH=$(cat DOSCAR| sed -n 6p | cut -c 33-42) 
echo "THE NUMBER OF THE ENERGY MESH OF DOS" >> 1_0_test.txt
echo ${TMESH} >> 1_0_test.txt
echo " " >> 1_0_test.txt


# THE FERMI ENERGY.
FERMI=$(cat DOSCAR| sed -n 6p | cut -c 43-54)

echo ${FERMI} >> 1_3_test.txt
echo " " >> 1_3_test.txt


# PICK UP ALL DOS FOR UP AND DOWN.
#sed -n 7,$((TMESH+6))p DOSCAR >> DOS.dat
#sed -n 7,$((TMESH+6))p DOSCAR | awk '{print " " $1 "  "  $2 "   -" $3 "  " $4 "   -" $5}' >> test2.txt

sed -n 7,$((TMESH+6))p DOSCAR | awk '{print " " $1 "  "  $2 "   -" $3 "  " $4 "   -" $5}'> 1_2_test.txt
echo Energy [ev]   up_DOS  down_DOS  integrated_up_DOS integrated_down_DOS > 1_1_test.txt
cat 1_2_test.txt >> 1_1_test.txt
cat 1_1_test.txt > DOS.dat  

cat 1_0_test.txt > MESH_NUMBER.log
cat 1_3_test.txt > FERMI_ENERGY.log
rm 1_1_test.txt 1_2_test.txt 1_0_test.txt 1_3_test.txt



######################################################################################
# 2. SHIFT THE FERMI ENRGY TO THE ENERGETIC ORIGIN FOR DOS.
######################################################################################

bash ./FERMI_CONVERT.sh



######################################################################################
# 3. TOTAL PDOS PLOT
######################################################################################

######################################################################################
# 3.1. PICK UP THE LIST OF THE LPDOS FOR EACH ELECTED ATOMS IN "ATOMList" FROM DOSCAR.
#######################################################################################

StartIndex=1
EndIndex=${#ATOMList[@]}
for RunningIndex in $(seq $((StartIndex-1)) 1 $((EndIndex-1)))
 do
  vATOM=${ATOMList[$RunningIndex]}
  #sed -n $((7+((TMESH+1)*（A＋1）))),$((TMESH+6+((TMESH+1)*（A＋1）))p DOSCAR_test #FORMULA A MUST BE vATOM
  #sed -n $((7+((TMESH+1)*(1 * vATOM +1 )))),$(((( 1 * vATOM ) + 7 ) + TMESH * ((vATOM * 1 )+2)))p DOSCAR > test_$((vATOM)).txt
  sed -n $((7+((TMESH+1)*(1 * vATOM )))),$(((( 1 * vATOM ) + 6 ) + TMESH * ((vATOM * 1 )+ 1)))p DOSCAR > test_$((vATOM)).txt
 done

######################################################################################
# 3.2. DIVID INTO THE TWO DATA SET FOR UP AND DOWN SPIN.
# THE TWO DATA SET FROM THE LPDOS FOR EACH ELECTED ATOMS IN "ATOMList" FROM DOSCAR.
######################################################################################

StartIndex1=1
EndIndex1=${#ATOMList[@]}
for RunningIndex1 in $(seq $((StartIndex1-1)) 1 $((EndIndex1-1)))
 do
  vATOM=${ATOMList[$RunningIndex1]}
  # PICK UP THE LPDOS ONLY FOR DOWN SPIN, AND ADD "-" IN FRONT OF THE VALUE OF EACH LPDOS.
  #cat test_$((vATOM)).txt | awk '{printf $1 "  "; for(i=1;i<=NF;i+=2)printf("%s ", "-"$(i+2));printf("\n")}' column -t > test_$((vATOM))_down.txt
  # IF YOU WANT TO OUTPUT THE LPDOS FOR DOWN SPIN "WITHOUT "-" ", THEN, YOU SHOULD TRUN ON THE BELOW LINE AND TURN OF THE ABOVE LINE. 
  cat test_$((vATOM)).txt | awk '{for(i=1;i<=NF;i+=2)printf("%s ", $i);printf("\n")}' | column -t > test_$((vATOM))_down.txt 
  # PICK UP THE LPDOS ONLY FOR UP SPIN.
  cat test_$((vATOM)).txt | awk '{printf $1 "  "; for(i=1;i<=NF;i+=2)printf("%s", "  "$(i+1));printf("\n")}' | column -t > test_$((vATOM))_up.txt
 done

##############################
## 3.2.1. sort out all file to do right justified
##############################
#DIR=$(pwd)
#mkdir temp1
#cd temp1
#mv ../*.txt ./

#for filepath in ${DIR}/temp1/*
 #do
  #FILENAME=$(basename ${filepath})
  #cat ${filepath} | awk '{printf ("%10s\n", $0)}' > 2_${FILENAME}
  #cat ${filepath} | awk '{printf("%10s  %s  %s  %s  %s  %s  %s  %s  %s\n", $1, $2, $3, $4, $5, $6, $7, $8, $9)}' > 2_${FILENAME}
  #rm ${FILENAME}
 #done


#cp ./2_*.txt ../
#cd ../

#mkdir temp2
#cd temp2
#cp ../temp1/2_*.txt ./

#for filepath in ${DIR}/temp2/*
 #do
  #FILENAME1=$(basename ${filepath})
  #FILENAME2=$(echo ${FILENAME1} | cut -c 3-)
  #cp ${FILENAME1} ../${FILENAME2}
 #done

#cd ../


###############################################################################
#OPTION!!!NOTE: TURN OFF THE BELOW LINE IF YOU WANT TO KNOW THE LPODS FOR SELECTED ATOMS
###############################################################################
#rm -r *temp*




#####################################################################
#3.3. PICK UP THE THE LPDOS SELECTED FROM ORBList FOR EACH SELECTED ATOMS
####################################################################
TEMP=()
TEMP=()
##########################################
#PICK UP THE CUT_RANGE FROM ORBList
##########################################
# THIS BLOCK WILL DETERMINE THE COLUMM INCLUDING WHAT WE WANT TO KNOW ABOUT LPDOS
StartIndex3=1
EndIndex3=${#ORBList[@]}
for RunningIndex3 in $(seq $((StartIndex3-1)) 1 $((EndIndex3-1)))
 do
  vORB=${ORBList[$((RunningIndex3))]}
  CUT_RANGE=$((((vORB-1)*12)+12))
  CUT_RANGE_F=$((CUT_RANGE+11))
  echo $CUT_RANGE >> temp1.txt
  echo $CUT_RANGE_F >> temp2.txt
 done

# THIS BLOCK WILL DETERMINE ALL RANGE OF PICKING UP THE DATA.
CUT_ALL=(1-12,) #cut -c 1-12 #energy columm
StartIndex4=1
EndIndex4=${#ORBList[@]}
for RunningIndex4 in $(seq $((StartIndex4)) 1 $((EndIndex4)))
 do
  CUT_INT=$(sed -n $((RunningIndex4))p temp1.txt)
  CUT_FIN=$(sed -n $((RunningIndex4))p temp2.txt)
  CUT_ALL+=$(echo "$((CUT_INT))"-"$((CUT_FIN)),")
 done

# EXECUTE PICKING UP THE DATA.
echo ${CUT_ALL} > temp3.txt
CUT_ALL_RANGE=$(wc -m temp3.txt | cut -c 1-9)
cat temp3.txt | cut -c 1-$((CUT_ALL_RANGE-2)) > temp4.txt
CUT_ALL_EDIT=$(cat temp4.txt)
#echo ${CUT_ALL_RANGE}
#echo ${CUT_ALL_EDIT}


DIR=$(pwd)
mkdir temp3
cd temp3
#cp ../test_*.txt ./
cp ../*_up.txt ./
cp ../*_down.txt ./

for filepath in ${DIR}/temp3/*
 do
  FILENAME=$(basename ${filepath})
  cat $FILENAME | cut -c ${CUT_ALL_EDIT} > CUT_${FILENAME}
 done

cp ./CUT_* ../
cd ../
#rm temp1.txt temp2.txt temp3.txt temp4.txt
#rm -r temp3
########################################
###LEAVE ONLY CUT_*.txt IN CURRECNT DIR
########################################
DIR=$(pwd)
mkdir temp4
cd temp4
cp ../CUT_*.txt ./
cd ../
rm *.txt
cd temp4
cp CUT_*.txt ../
cd ../
#rm -r temp4


###############################################################################################################
# 3.4. PICK UP THE LIST OF THE PDOS FOR EACH ELECTED ATOMS IN "ATOMList" FROM THE LPDOSCAR IN "test_$((vATOM)).txt".
###############################################################################################################
DIR=$(pwd)
mkdir temp5
cd temp5
cp ../CUT_*.txt ./
cp ../LPDOS_SUM.py ./

## SUM UP ALL LPDOS INTO PDOS
for filepath in ${DIR}/temp5/*
 do
  FILENAME=$(basename ${filepath})
  #cat $FILENAME | cut -c ${CUT_ALL_EDIT} > CUT_${FILENAME}
  cp ${FILENAME} ./temp99.txt
  python3 LPDOS_SUM.py > SUM_${FILENAME}
  cp SUM_${FILENAME} ../
 done

cd ../
#rm temp1.txt temp2.txt temp3.txt temp4.txt
#rm -r temp5

#python3 LPDOS_SUM.py > temp5.txt
#echo "Energy    PDOS" > PDOS.dat
#cat temp5.txt >> PDOS.dat

########################################
###3.4.2. LEAVE ONLY SUM_*_up.txt AND SUM_*_down.txt IN CURRECNT DIR
########################################
DIR=$(pwd)
mkdir temp6
cd temp6
cp ../SUM_*_up.txt ./
cp ../SUM_*_down.txt ./
cd ../
rm *.txt
cd temp6
cp SUM_*_up.txt ../
cp SUM_*_down.txt ../
cd ../
#rm -r temp6


###############################################################################################################
# 3.5. CREATE THE FILE OF THE PDOS FOR EACH ELECTED ATOMS IN "ATOMList".
# ALL_alpha.txt INCLUDE THE LIST OF THE PDOS SUMMED UP ALL LPDOS ONLT FOR UP SPIN.
# ALL_beta.txt INCLUDE THE LIST OF THE PDOS SUMMED UP ALL LPDOS ONLY FOR DOWN SPIN.
###############################################################################################################
bash ./PDOS_SUM_FOR_ATOM.sh
python3 ATOM_SUM_ALPHA.py > temp_alpha.txt
python3 ATOM_SUM_BETA.py > temp_beta.txt 
join temp_alpha.txt temp_beta.txt > temp_all.txt
echo "Energy [eV]      up&sum      down&sum " > PDOS_pre.dat
cat temp_all.txt >> PDOS_pre.dat 
cat PDOS_pre.dat > PDOS.dat

rm PDOS_pre.dat temp_all.txt temp_alpha.txt temp_beta.txt


######################################################################################
# 3.6. SHIFT THE FERMI ENRGY TO THE ENERGETIC ORIGIN FOR DOS.
######################################################################################
bash ./FERMI_CONVERT_LPODS.sh
mv PDOS_FERMI=ZERO.dat ./PDOS_FERMI=ZERO_Li.dat

###################################################################################################About d orb
###############################################################################################################
#echo "orbital " > PDOS.dat
#python3 PDOS_make.py > test2.txt
#echo "Energy  ", $((vORB1)), $((vORB2)) > PDOS.dat
#cat test2.txt >> PDOS.dat

##############################################################################################################################################################################################################################
# about all
###############################################################################################################


CreateGNUPLOT_DOS(){

cat > GNUPLOT_DOS << EOF
set terminal pngcairo enhanced
set encoding iso_8859_1
set output 'DOS_PDOS.png' 
set key
set ylabel 'DOS (state/eV)' font "Helvetica, 18"
set xlabel '{/:Italic E- E_f} (eV)' font "Helvetica, 18"
#set format y "% .2f"
#set format x "% .2f"
set border lw 4
set xrange [-10:7]
set yrange [-40:40]
#set arrow from  0.0,-1000 to 0.0,1000 nohead lw 2 dt (10,5) lc rgb "dark-grey"  #FERMI ENERGY
plot "DOS_FERMI=ZERO.dat" u 1:2 lc 'black' with lines title " ", "DOS_FERMI=ZERO.dat" u 1:3 lc 'black' with lines title " ",
EOF

}

CreateGNUPLOT_DOS
gnuplot GNUPLOT_DOS


rm GNUPLOT_DOS
rm SUM_LPDOS_SUM.py
rm *.txt
rm ALL_alpha.dat
rm ALL_beta.dat
rm FERMI_ENERGY.log
rm MESH_NUMBER.log
rm PDOS.dat
rm ENERGY_MESH.dat
rm CONVERTED_ENERGY.dat
rm -r temp*

#########RFER
### basename https://atmarkit.itmedia.co.jp/ait/articles/1801/25/news025.html
### for in all files http://blog.livedoor.jp/akf0/archives/51638961.html
### pick up only all even columm: https://bioinfo-dojo.net/2017/10/05/awk-for/ 

