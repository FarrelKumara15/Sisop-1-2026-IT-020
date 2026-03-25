#!/bin/bash

BEGIN {
    FS=","
    pilihan = ARGV[2] # Mengambil input pilihan a/b/c/d/e
    delete ARGV[2] # Agar input pilihan a/b/c/d/e tidak dianggap file oleh awk
}

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

END {
    # Pilihan a 
    if (pilihan == "a") {
        print "Jumlah seluruh penumpang KANJ adalah", count, "orang"
    }

    # Pilihan b
    else if (pilihan == "b") {
	for (i in gerbong) { # Menghitung nilai unik gerbong
  	     Gerbong++
        }
        print "Jumlah gerbong penumpang KANJ adalah", Gerbong
    }          

    # Pilihan c
    else if (pilihan == "c") { 
        print oldest, "adalah penumpang kereta tertua dengan usia", max, "tahun"
    }

    # Pilihan d
    else if (pilihan == "d") {
        print "Rata-rata usia penumpang adalah", int(sum/count), "tahun"
    }

    # Pilihan e
    else if (pilihan == "e") {
        print "Jumlah penumpang business class ada", count, "orang"
    }

    # Bukan kelimanya
    else{
      print "Soal tidak dikenali. Gunakan a,b,c,d, atau e."
      print "Contoh Penggunaan: awk -f KANJ.sh passenger.csv"
    }
} 


