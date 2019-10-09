#!/bin/bash

declare -a sizes=("1" "5" "10" "50" "100" "500")
i=0

while IFS=, read -r dataset url
do
	if [[ $url =~ ^http.* ]]; then
	    wget -O gtfs-"${sizes[$i]}".zip $url
	    unzip gtfs-"${sizes[$i]}".zip -d gtfs-"${sizes[$i]}"
	    rm gtfs-"${sizes[$i]}".zip  
	fi
done < gtfs-url.csv
