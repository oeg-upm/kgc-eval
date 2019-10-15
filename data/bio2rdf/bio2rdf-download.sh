#!/bin/bash

while IFS=, read -r dataset url
do
	if [[ $url =~ ^http.* ]]; then
	    wget -O $dataset.zip $url
	    unzip $dataset.zip
	    rm $dataset.zip  
	fi
done < bio2rdf-url.csv
