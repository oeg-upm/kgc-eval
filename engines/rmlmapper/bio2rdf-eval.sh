#!/bin/bash

rm /results/*
echo "dataset,time">>/results/results-times-bio2rdf.csv
echo "dataset,run,results,time">>/results/results-times-bio2rdf-detail.csv


total=0
for j in 1 2 3 4 5
do
	start=$(date +%s.%N)
	timeout 10h java -jar /rmlmapper/rmlmapper.jar -m /mappings/bio2rdf.rml.ttl -o /results/bio2rdf-$j.nt -d
	exit_status=$?
	finish=$(date +%s.%N)
	dur=$(echo "$finish - $start" | bc)
	if [ $exit_status -eq 124 ]
	then
		echo "bio2rdf,TimeOut">>/results/results-times-bio2rdf.csv
		total=0
		break
	else
		sort /results/bio2rdf-$j.nt
		lines=$(< "/results/bio2rdf-$j.nt" wc - l)
		echo "gtfs,$j,$lines,$dur">>/results/results-times-bio2rdf-detail.csv
		total=$(($total + $dur))
		if [ $j -ne 5 ]
		then
			rm /results/bio2rdf-$j.nt
		fi
	fi
done
if [ $total -ne 0 ]
then
	total=$(($total / 5))
	echo "bio2rdf,$total">>/results/results-times-bio2rdf.csv
fi

