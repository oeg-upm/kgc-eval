#!/bin/bash

rm /results/*
echo "dataset,type,time">>/results/results-times-gtfs.csv
echo "dataset,type,run,results,time">>/results/results-times-gtfs-detail.csv
declare -a configs=("enrich" "noenrich")

for t in "${configs[@]}"
do
	for i in 1 5 10 50 100 500
	do
		cp /data/madrid-gtfs/gtfs-$i/*.csv /data/
		total=0
		for j in 1 2 3 4 5
		do
			start=$(date +%s.%N)
			timeout 10h python3 /sdmrdfizer/rdfizer/run_rdfizer.py /sdmrdfizer/configs/madrid-gtfs-config.ini
			exit_status=$?
			finish=$(date +%s.%N)
			dur=$(echo "$finish - $start" | bc)
			if [ $exit_status -eq 124 ]
			then
				echo "gtfs-$i,$t,TimeOut">>/results/results-times-gtfs.csv
				total=0
				break
			else
				sort /results/gtfs.nt
				lines=$(< "/results/gtfs.nt" wc - l)
				echo "gtfs-$i,$t,$j,$lines,$dur">>/results/results-times-gtfs-detail.csv
				total=$(($total + $dur))
				if [ $j -ne 5 ]
				then
					rm /results/gtfs.nt
				fi
			fi
		done
		mv /results/gtfs.nt /results/gtfs-$t-$i.nt
		if [ $total -ne 0 ]
		then
			total=$(($total / 5))
			echo "gtfs-$i,$t,$total">>/results/results-times-gtfs.csv
		fi
	done
	sed -i 's/enrichment: yes/enrichment: no/g' /sdmrdfizer/configs/madrid-gtfs-config.ini	
done
rm /data/*.csv