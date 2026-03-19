#!/bin/bash

input="gsxtrack.json"
output="titik-penting.txt"

> "$output"

awk '
{
    if ($0 ~ /"id"/) {
        match($0, /[0-9]+/)
        raw_id = substr($0, RSTART, RLENGTH)
        
        # Format menjadi node_xxx
        id = sprintf("node_%03d", raw_id)
    }
    
    if ($0 ~ /"site_name"/) {
        match($0, /"site_name": *"[^"]+"/)
        site = substr($0, RSTART, RLENGTH)
        gsub(/"site_name": *"|"/, "", site)
    }

    if ($0 ~ /"latitude"/) {
        match($0, /-?[0-9.]+/)
        lat = substr($0, RSTART, RLENGTH)
    }

    if ($0 ~ /"longitude"/) {
        match($0, /-?[0-9.]+/)
        lon = substr($0, RSTART, RLENGTH)

        # Output tanpa spasi
        printf "%s,%s,%s,%s\n", id, site, lat, lon >> "'"$output"'"
    }
}
' "$input"

echo "Parsing 1 mari cak. tak simpen ndek :  $output"
