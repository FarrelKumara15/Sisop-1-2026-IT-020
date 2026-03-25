# Sisop-1-2026-IT-020
## Farrel Arteya Kumara - 5027251020
### Soal 1
Soal 1 diperintahkan untuk mencari<br/>
a. Jumlah Penumpang<br/>
b. Jumlah Gerbong<br/>
c. Usia Tertua Penumpang<br/>
d. Rata-Rata Usia Penumpang<br/>
e. Jumlah Penumpang Business Class<br/>

Dijalankan dengan menggunakan, <br/>
```bash
awk -f KANJ.sh passenger.csv [pilihan]
```

### 1. Inisialisasi awal
```bash
BEGIN {
    FS=","
    pilihan = ARGV[2] # Mengambil input pilihan a/b/c/d/e
    delete ARGV[2] # Agar input pilihan a/b/c/d/e tidak dianggap file oleh awk
}
```
Digunakan sebagai inisialisasi awal sebelum AWK membaca file. <br/> 
(FS="," (untuk memisahkan kolom menggunakan tanda koma)).
<br><br/>

### 2. Penanganan Data
```bash
NR>1 { # Untuk skip kolom pertama
    count++
    gerbong[$4]++ # Menghitung penumpang tiap gerbong
	
    # Penumpang tertua
    if ($2 > max) {
        max = $2
        oldest = $1
    }
    sum += $2 # Menjumlahkan usia

	# Penumpang Business Class
    if ($3 == "Business") {
        business++
    }
}
```
Pada penanganan awal ini akan menggunakan NR>1 untuk skip kolom pertama/header yang tidak terpakai agar yang terbaca hanya data penumpang saja. <br/>
1. [count++], untuk menghitung jumlah penumpang
2. [gerbong[$4]], menggunakan associative array untuk menghitung jumlah penumpang di tiap gerbong
3. Mencari penumpang tertua dengan membandingkan tiap data $2 dan menyimpan umur dan namanya
4. [sum += $1], menjumlahkan usia untuk rata-rata usia penumpang nanti
5. Mencari jumlah penumpang yang menaiki business class
<br/><br/>

### 3. Pilihan <br/>
#### Pilihan a<br/>
```bash
if (pilihan == "a") {
        print "Jumlah seluruh penumpang KANJ adalah", count, "orang"
    }
```
Menampilkan jumlah seluruh peumpang KANJ
<br><br/>

#### pilihan b<br/>
```bash
else if (pilihan == "b") {
	for (i in gerbong) { # Menghitung nilai unik gerbong
  	     Gerbong++
        }
        print "Jumlah gerbong penumpang KANJ adalah", Gerbong
    }
```
Menggunakan loop dari perhitungan gerbong[$4] untuk menghitung nilai unik gerbong
<br/><br/>

#### pilihan c<br/>
```bash
else if (pilihan == "c") { 
        print oldest, "adalah penumpang kereta tertua dengan usia", max, "tahun"
    }
```
Menampilkan nama orang tertua di KANJ beserta umurnya.
<br/><br/>

#### pilihan d<br/>
```bash
pilihan d<br/>
else if (pilihan == "d") {
        print "Rata-rata usia penumpang adalah", int(sum/count), "tahun"
    }
```
Menampilkan rata-rata usia penumpang dengan sum/count.
<br/><br/>

#### pilihan e<br/>
```bash
else if (pilihan == "e") {
        print "Jumlah penumpang business class ada", business, "orang"
    }
```
Menampilkan jumlah penumpang yang ada di business class.
<br/><br/>

#### pilihan selain (a/b/c/d/e)<br/>
```bash
else{
      print "Soal tidak dikenali. Gunakan a,b,c,d, atau e."
      print "Contoh Penggunaan: awk -f KANJ.sh passenger.csv"
    }
```
Menampilkan seperti contoh di soal

<br/><br/>
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
Hasil parsing akan disimpan di file baru bernama "titik-penting.txt". <br/>

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
<br/><br/>
