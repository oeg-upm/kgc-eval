#!/bin/bash

rm /results/*
echo "dataset,size,percent,time">>/results/results-times-join-selectivity.csv
echo "dataset,size,percent,run,results,time">>/results/results-times-join-selectivity-detail.csv



for i in 1 3 10 50
do
	for j in 5 10 20 30 50 60 80 100
	do
		cp /data/synthetic-data/join-selectivity/$ik_rows/table1.csv /data/table1.csv
		cp /data/synthetic-data/join-selectivity/$ik_rows/table2_$j_percent.csv /data/table2.csv
		for t in 1 2 3 4 5
		do
			start=$(date +%s.%N)
			timeout 10h java -jar /carml/carml.jar -m /mappings/synthetic/standard.rml.ttl -o /results/synthetic-join-selectivity-$i-$j-$t.nt -d
			exit_status=$?
			finish=$(date +%s.%N)
			dur=$(echo "$finish - $start" | bc)
			if [ $exit_status -eq 124 ]
			then
				echo "synthetic-join-selectivity,$i,$j,TimeOut">>/results/results-times-join-selectivity.csv
				total=0
				break
			else
				sort /results/synthetic-join-selectivity-$i-$j-$t.nt 
				lines=$(< "/results/synthetic-join-selectivity-$i-$j-$t.nt" wc - l)
				echo "synthetic-join-selectivity,$i,$j,$t,$lines,$dur">>/results/results-times-join-selectivity-detail.csv
				total=$(($total + $dur))
				if [ $j -ne 5 ]
				then
					rm /results/synthetic-join-selectivity-$i-$j-$t.nt
				fi
			fi
		done
		if [ $total -ne 0 ]
		then
			total=$(($total / 5))
			echo "synthetic-join-selectivity,$i,$j,$total">>/results/results-times-join-selectivity.csv
		fi
		
	done
done
rm /data/*.csv
