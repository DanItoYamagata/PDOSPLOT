#!/bin/sh

DIR=$(pwd)
mkdir up_temp
cd up_temp
cp ../*_up.txt ./
cd ../
mkdir down_temp
cd down_temp
cp ../*_down.txt ./
cd ../


## SUM UP ALL UP PDOS for selected atom
cd up_temp
#CUTOFF=$(find . -type f -depth 1 | wc -l) # # OF FILES
#########################################
#RANDOML PICK UP A FILE IN UP_TEMP DIR ##
#########################################
#NAME=$(find . | grep txt | sort -R | tail -n 1) 
#cat $NAME > up_temp.dat
#rm $NAME
#for filepath in ${DIR}/up_temp/*.txt
 #do
  #FILENAME=$(basename ${filepath})
  #join up_temp.dat ${FILENAME} > up_temp1.dat
  #rm up_temp.dat
  #mv up_temp1.dat ./up_temp.dat
 #done

#cat up_temp.txt | awk '{for(i=1;i<NF-"'$((CUTOFF))'/";++i){printf("%s ",$i)}print $NF}'
#cat up_temp.dat | awk '{for(i=1;i<NF-"'$((CUTOFF))'/";++i){printf("%s ",$i)}print $NF}' > ALL_alpha.dat
#cp ALL_alpha.dat ../
paste *.txt | awk '{printf $1 "  "; for(i=1;i<=NF;i+=2)printf("%s", "  "$(i+1));printf("\n")}' > ALL_alpha.dat
cp ALL_alpha.dat ../ 
cd ../

#unset CUTOFF
#unset NAME
#unset FILENAME

## SUM UP ALL DOWN PDOS for selected atom
#CUTOFF=$(find . -type f -depth 1 | wc -l) # # OF FILES
#NAME=$(find . | grep txt | sort -R | tail -n 1)
#cat ${NAME} > down_temp.txt
#rm ${NAME}
#for filepath in ${DIR}/down_temp/*
 #do
  #FILENAME=$(basename ${filepath})
  #join down_temp.txt ${FILENAME} > down_temp1.txt
  #rm down_temp.txt
  #mv down_temp1.txt ./down_temp.txt
 #done

#cat down_temp.txt | awk '{for(i=1;i<NF-"'$((CUTOFF))'/";++i){printf("%s ",$i)}print $NF}' > ALL_beta.txt

cd down_temp
paste *.txt | awk '{printf $1 "  "; for(i=1;i<=NF;i+=2)printf("%s", "  "$(i+1));printf("\n")}' > ALL_beta.dat
cp ALL_beta.dat ../
cd ../





##unset CUTOFF
##unset NAME
##unset FILENAME

#rm -r down_temp
rm -r up_temp down_temp
unset 
