#!/bin/bash

DATA="passenger.csv"

echo "================KANJ================"
echo "a. Jumlah Penumpang"
echo "b. Jumlah Gerbong"
echo "c. Usia Tertua Penumpang"
echo "d. Rata-Rata Usia Penumpang"
echo "e. Jumlah Penumpang Business Class"
echo -n "Pilihan (a/b/c/d/e): " 
read pilihan

# Pilihan a 
if [ "$pilihan" == 'a' ]; then 
      awk -F ',' 'NR>1 {count++} END{print "Jumlah seluruh penumpang KANJ adalah", count, "orang"}' $DATA

# Pilihan b
elif [ "$pilihan" == 'b' ]; then
      awk -F ',' 'NR>1 {gerbong[$4]++} END{print "Jumlah gerbong penumpang KANJ adalah", length(gerbong)}' $DATA           

# Pilihan c
elif [ "$pilihan" == 'c' ]; then 
      awk -F ',' 'NR>1 && $2>max {max=$2; name=$1} END{print name, "adalah penumpang kereta tertua dengan usia", max, "tahun"}' $DATA

# Pilihan d
elif [ "$pilihan" == 'd' ]; then
      awk -F ',' 'NR>1 {sum+=$2; count++} END{print "Rata-rata usia penumpang adalah", int(sum/count), "tahun"}' $DATA

# Pilihan e
elif [ "$pilihan" == 'e' ]; then
      awk -F ',' 'NR>1 && $3 == "Business" {count++} END{print "Jumlah penumpang business calss ada", count, "orang"' $DATA

# Bukan kelimanya
else
      echo "Pilihan tidak valid"
fi
 


