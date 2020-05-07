#!/bin/bash

rm /results/*
echo "dataset,config,results,time">>/results/results-times-gtfs.csv
echo "dataset,config,run,results,time">>/results/results-times-gtfs-detail.csv

for i in 1 5 10 50 100 500
do
	cp /data/madrid-gtfs/gtfs-$i/*.csv /data/
	total=0
	for j in 1 2 3 4 5
	do
		start=$(date +%s.%N)
		timeout 10h node index.js
		exit_status=$?
		finish=$(date +%s.%N)
		dur=$(echo "$finish - $start" | bc)
		if [ $exit_status -eq 124 ];then
			echo "gtfs-$i,$t,$j,0,TimeOut">>/results/results-times-gtfs.csv
			total=0
			break
		else
			lines=$(cat "/results/gtfs.nt" | wc -l)
			echo "gtfs-$i,$t,$j,$lines,$dur">>/results/results-times-gtfs-detail.csv
			total=$(echo "$total+$dur" | bc)
			echo $total
			if [ $j -ne 5 ];then
				rm /results/gtfs.nt
			fi
		fi
	done
	mv /results/gtfs.nt /results/gtfs-$t-$i.nt
	if (( $(echo "$total > 0" | bc -l) ));then
		total=$(echo "$total/5" | bc -l)
		echo "gtfs-$i,$t,$lines,$total">>/results/results-times-gtfs.csv
	fi
done
rm /data/*.csv
