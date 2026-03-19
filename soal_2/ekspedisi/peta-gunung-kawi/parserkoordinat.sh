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
