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

### Soal 2
Soal 2 diperintahkan untuk mendownload peta-ekspedisi.pdf dan disimpan di folder ekspedisi.<br/><br/>

Di folder ekspedisi, jalankan
```bash
cat peta-ekspedisi-amba.pdf
```
Scroll sampai paling bawah dan akan menemukan "https://github.com/pocongcyber77/peta-gunung-kawi.git" <br/>
Di github tersebut ada file "gsxtrack.json", download file tersebut dengan cara meng-clone-nya. <br/>
Clone file tersebut ke folder "peta-gunung-kawi". <br/>
```bash
git clone (https://github.com/pocongcyber77/peta-gunung-kawi.git)
cd peta-gunung-kawi
```
<br/>
Buat file dengan nama "parserkoordinat.sh" untuk mengambil data id, site_name, latitude, dan longitude dengan menggunakan regex (dengan bantuan grep, sed, atau awk). <br/> 
Susun hasil dengan format : id, site_name, latitude, longitude. <br/>
Hasil akan disimpan di file baru bernama "titik-penting.txt". <br/>

```bash <br/>                                                                                         
#!/bin/bash

input="gsxtrack.json"
output="titik-penting.txt"

> "$output"

awk '
{
    # Mencari ID
    if ($0 ~ /"id"/) {
        match($0, /[0-9]+/)
        raw_id = substr($0, RSTART, RLENGTH)

        # Format menjadi node_xxx
        id = sprintf("node_%03d", raw_id)
    }

    # Mencari Site_Name
    if ($0 ~ /"site_name"/) {
        match($0, /"site_name": *"[^"]+"/)
        site = substr($0, RSTART, RLENGTH)
        gsub(/"site_name": *"|"/, "", site)
    }

    # Mencari Latitude
    if ($0 ~ /"latitude"/) {
        match($0, /-?[0-9.]+/)
        lat = substr($0, RSTART, RLENGTH)
    }

    # Mencari Longitude
    if ($0 ~ /"longitude"/) {
        match($0, /-?[0-9.]+/)
        lon = substr($0, RSTART, RLENGTH)

        # Output
        printf "%s,%s,%s,%s\n", id, site, lat, lon >> "'"$output"'"
    }
}
' "$input"

echo "Parsing 1 mari cak. tak simpen ndek : $output"
```
<br/>
Setelah menyimpan data koordniat di file "titik-penting.txt", pada soal diperintahkan untuk mencari titik pusat menggunakan metode titik simetri diagonal.  <br/>
Buat di file "nemupusaka.sh" dan outputnya disimpan di "posisipusaka.txt" dengan format (Latitude, Longitude). <br/>


```bash <br/>
#!/bin/bash

input="titik-penting.txt"
output="posisipusaka.txt"

> "$output"

awk -F ',' '
NR==1 {
    lat1=$3
    long1=$4
}
NR==2 {
    lat2=$3
    long2=$4

    # Menghitung titik tengah
    mid_long = (long1 + long2) / 2
    mid_lat = (lat1 + lat2) / 2

    # Disimpan di posisipusaka.txt
    printf "Koordinat pusat: %f, %f\n", mid_lat, mid_long >> "'"$output"'"

    # Menampilkan Koordinat Pusat
    printf "Koordinat pusat: %f, %f\n", mid_lat, mid_long
}
' "$input"
```



