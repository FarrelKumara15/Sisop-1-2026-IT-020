# Sisop-1-2026-IT-020
## Farrel Arteya Kumara - 5027251020
### Soal 1
#### Struktur Repository Soal 1<br>
<img width="197" height="146" alt="2026-03-29_21-38-52" src="https://github.com/user-attachments/assets/139fcafa-7809-4460-81ed-e557cf0c4204" />

<br/>Soal 1 diperintahkan untuk mencari<br/>
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
Menampilkan jumlah seluruh peumpang KANJ<br/>
<img width="433" height="74" alt="20260325_23h15m35s_grim" src="https://github.com/user-attachments/assets/ecfb34e4-e8a5-4aa7-9b74-3c34b304fb9d" />

#### Pilihan b<br/>
```bash
else if (pilihan == "b") {
	for (i in gerbong) { # Menghitung nilai unik gerbong
  	     Gerbong++
        }
        print "Jumlah gerbong penumpang KANJ adalah", Gerbong
    }
```
Menggunakan loop dari perhitungan gerbong[$4] untuk menghitung nilai unik gerbong<br/>
<img width="363" height="72" alt="20260325_23h15m51s_grim" src="https://github.com/user-attachments/assets/60a8ead6-60d5-4f67-83fe-8fbe31c0fd32" />

#### Pilihan c<br/>
```bash
else if (pilihan == "c") { 
        print oldest, "adalah penumpang kereta tertua dengan usia", max, "tahun"
    }
```
Menampilkan nama orang tertua di KANJ beserta umurnya.<br/>
<img width="613" height="79" alt="20260325_23h16m02s_grim" src="https://github.com/user-attachments/assets/1b941ead-73fb-48f9-aba1-f264e96ff375" />

#### Pilihan d<br/>
```bash
pilihan d<br/>
else if (pilihan == "d") {
        print "Rata-rata usia penumpang adalah", int(sum/count), "tahun"
    }
```
Menampilkan rata-rata usia penumpang dengan sum/count.<br/>
<img width="384" height="81" alt="20260325_23h16m08s_grim" src="https://github.com/user-attachments/assets/a86b9330-201c-4387-b47e-1e3932d91f57" />

#### Pilihan e<br/>
```bash
else if (pilihan == "e") {
        print "Jumlah penumpang business class ada", business, "orang"
    }
```
Menampilkan jumlah penumpang yang ada di business class.<br/>
<img width="414" height="77" alt="20260325_23h16m17s_grim" src="https://github.com/user-attachments/assets/a29e717c-21f6-4bfb-8305-b43dc968d4ee" />

#### Pilihan selain (a/b/c/d/e)<br/>
```bash
else{
      print "Soal tidak dikenali. Gunakan a,b,c,d, atau e."
      print "Contoh Penggunaan: awk -f KANJ.sh passenger.csv a"
    }
```
Menampilkan seperti contoh di soal<br/>
<img width="464" height="101" alt="20260325_23h16m25s_grim" src="https://github.com/user-attachments/assets/67325dfd-7356-4070-b0f8-456d2efe5131" />

<br/><br/>
### Soal 2 <br/>
#### Struktur Repository Soal 2
<img width="305" height="271" alt="image" src="https://github.com/user-attachments/assets/0fdea30c-5444-4604-a340-5ca70d16b03b" />

<br/>Soal 2 diperintahkan untuk mendownload peta-ekspedisi.pdf dan disimpan di folder ekspedisi.<br/><br/>

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
    if ($0 ~ /"id"/) { # Mencari ID di tiap baris
        match($0, /[0-9]+/)
        raw_id = substr($0, RSTART, RLENGTH)

        # Format menjadi node_xxx
        id = sprintf("node_%03d", raw_id)
    }

    # Mencari Site_Name
    if ($0 ~ /"site_name"/) { # Mencari Site_Name di tiap baris
        match($0, /"site_name": *"[^"]+"/)
        site = substr($0, RSTART, RLENGTH)
        gsub(/"site_name": *"|"/, "", site)
    }

    # Mencari Latitude
    if ($0 ~ /"latitude"/) { # Mencari Latitude di setiap baris
        match($0, /-?[0-9.]+/)
        lat = substr($0, RSTART, RLENGTH)
    }

    # Mencari Longitude
    if ($0 ~ /"longitude"/) { # Mencari Longitude do setiap baris
        match($0, /-?[0-9.]+/)
        lon = substr($0, RSTART, RLENGTH)

        # Output
        printf "%s,%s,%s,%s\n", id, site, lat, lon >> "'"$output"'"
    }
}
' "$input"

echo "Parsing 1 mari cak. tak simpen ndek : $output"
```
Hasil di file "titik_penting.txt"<br/>
<img width="509" height="133" alt="2026-03-29_21-34-15" src="https://github.com/user-attachments/assets/1ddd0583-581e-4c72-b315-8bffc576a860" />

<br/>
Setelah menyimpan data koordniat di file "titik-penting.txt", pada soal diperintahkan untuk mencari titik pusat menggunakan metode titik simetri diagonal.  <br/>
Buat di file "nemupusaka.sh" dan outputnya disimpan di "posisipusaka.txt" dengan format (Latitude, Longitude). <br/>

```bash <br/>
#!/bin/bash

input="titik-penting.txt"
output="posisipusaka.txt"

> "$output"

awk -F ',' '
NR==1 { # Menyimpan latitude dan longitude pertama
    lat1=$3
    long1=$4
}
NR==2 { # Menyimpan latitude dan longitude kedua
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
Hasil di file "posisipusaka.txt"<br/>
<img width="392" height="74" alt="2026-03-29_21-36-41" src="https://github.com/user-attachments/assets/edaf7e5f-0734-4fce-a1b0-d879ed828bee" />
