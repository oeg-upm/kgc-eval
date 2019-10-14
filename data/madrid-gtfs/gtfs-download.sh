#!/bin/bash

while IFS=, read -r dataset url
do
	if [[ $url =~ ^http.* ]]; then
	    wget -O $dataset.zip $url
	    unzip $dataset.zip -d $dataset
	    rm $dataset.zip  
	fi
done < gtfs-url.csv
