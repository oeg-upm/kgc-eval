#!/bin/bash

rm /results/*
echo "dataset,config,time">>/results/results-times-bio2rdf.csv
echo "dataset,config,run,results,time">>/results/results-times-bio2rdf-detail.csv
declare -a configs=("enrich" "noenrich")

for t in "${configs[@]}"
do
	total=0
	for j in 1 2 3 4 5
	do
		start=$(date +%s.%N)
		timeout 10h python3 /sdmrdfizer/rdfizer/run_rdfizer.py /sdmrdfizer/configs/bio2rdf-config.ini
		exit_status=$?
		finish=$(date +%s.%N)
		dur=$(echo "$finish - $start" | bc)
		if [ $exit_status -eq 124 ]
		then
			echo "bio2rdf,$t,TimeOut">>/results/results-times-bio2rdf.csv
			total=0
			break
		else
			sort /results/bio2rdf.nt
			lines=$(< "/results/bio2rdf.nt" wc - l)
			echo "gtfs,$t,$j,$lines,$dur">>/results/results-times-bio2rdf-detail.csv
			total=$(($total + $dur))
			if [ $j -ne 5 ]
			then
				rm /results/bio2rdf.nt
			fi
		fi
	done
	mv /results/bio2rdf.nt /results/bio2rdf-$t.nt
	if [ $total -ne 0 ]
	then
		total=$(($total / 5))
		echo "bio2rdf,$t,$total">>/results/results-times-bio2rdf.csv
	fi
	sed -i 's/enrichment: yes/enrichment: no/g' /sdmrdfizer/configs/bio2rdf-config.ini 
done
