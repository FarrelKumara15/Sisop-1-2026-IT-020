# Sisop-1-2026-IT-020
## Farrel Arteya Kumara - 5027251020
### Soal 1
Soal 1 diperintahkan untuk mencari<br/>
a. Jumlah Penumpang<br/>
b. Jumlah Gerbong<br/>
c. Usia Tertua Penumpang<br/>
d. Rata-Rata Usia Penumpang<br/>
e. Jumlah Penumpang Business Class<br/><br/>

a. Jumlah Penumpang
```bash
if [ "$pilihan" == 'a' ]; then
      awk -F ',' 'NR>1 {count++} END{print "Jumlah seluruh penumpang KANJ adalah", count, "orang"}' $DATA
```
Mencari total penumpang yang berada di dalam kereta api<br/><br/>

b. Jumlah Gerbong
```bash
elif [ "$pilihan" == 'b' ]; then
      awk -F ',' 'NR>1 {gerbong[$4]++} END{print "Jumlah gerbong penumpang KANJ adalah", length(gerbong)}' $DATA
```
Mencari banyak gerbong unik yang ada dengan menggunakan array<br/><br/>

c. Usia Tertua Penumpang
```bash
elif [ "$pilihan" == 'c' ]; then
      awk -F ',' 'NR>1 && $2>max {max=$2; name=$1} END{print name, "adalah penumpang kereta tertua dengan usia", max, "tahun"]' $DATA
```
Mencari penumpang kereta dengan usia tertua beserta namanya<br/><br/>

d. Rata-Rata Usia Penumpang
```bash
elif [ "$pilihan" == 'd' ]; then
      awk -F ',' 'NR>1 {sum+=$2; count++} END{print "Rata-rata usia penumpang adalah", int(sum/count), "tahun"}' $DATA
```
Mencari rata-rata usia penumpang kereta<br/><br/>

e. Jumlah Penumpang Business Class
```bash
elif [ "$pilihan" == 'e' ]; then
      awk -F ',' 'NR>1 && $3 == "Business" {count++} END{print "Jumlah penumpang business calss ada", count, "orang"' $DATA
```
Mencari jumlah penumpang kereta yang berada di business class<br/><br/>

# Soal 2
