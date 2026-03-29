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

    mid_long = (long1 + long2) / 2
    mid_lat = (lat1 + lat2) / 2
    
    # Disimpan di posisipusaka.txt
    printf "Koordinat pusat: %f,%f\n", mid_long, mid_lat >> "'"$output"'"

    # Menampilkan Koordinat Pusat
    printf "Koordinat pusat: %f,%f\n", mid_long, mid_lat
}
' "$input"

