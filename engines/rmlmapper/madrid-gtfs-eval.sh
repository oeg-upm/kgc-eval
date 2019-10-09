#!/bin/bash

rm /results/*
echo "dataset,time">>/results/results-times-gtfs.csv
echo "dataset,run,time">>/results/results-times-gtfs-detail.csv

for i in 1 5 10 50 100 500
do
	cp /data/madrid-gtfs/gtfs-$i/*.csv /data/
	total=0
	for j in 1 2 3 4 5
	do
		start=$(date +%s.%N)
		timeout 10h java -jar /rmlmapper/rmlmapper.jar -m /mappings/gtfs-csv.rml.ttl -o /results/gtfs-$i-$j.ttl -d
		exit_status=$?
		finish=$(date +%s.%N)
		dur=$(echo "$finish - $start" | bc)
		if [ $exit_status -eq 124 ]
		then
			echo "gtfs-$i,TimeOut">>/results/results-times-gtfs.csv
			total=0
			break
		else
			echo "gtfs-$i,$run,$dur">>/results/results-times-gtfs-detail.csv
			total=$(($total + $dur))
		fi
	done
	if [ $total -ne 0 ]
	then
		total=$(($total / 5))
		echo "gtfs-$i,$total">>/results/results-times-gtfs.csv
	fi
done	