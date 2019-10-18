#!/bin/bash

rm /results/*
echo "dataset,config,size,percent,time">>/results/results-times-join-selectivity.csv
echo "dataset,config,size,percent,run,results,time">>/results/results-times-join-selectivity-detail.csv
declare -a configs=("enrich" "noenrich")

for type in "${configs[@]}"
do
	for i in 1 3 10 50
	do
		for j in 5 10 20 30 50 60 80 100
		do
			cp /data/synthetic-data/join-selectivity/$ik_rows/table1.csv /data/table1.csv
			cp /data/synthetic-data/join-selectivity/$ik_rows/table2_$j_percent.csv /data/table2.csv
			for t in 1 2 3 4 5
			do
				start=$(date +%s.%N)
				timeout 10h python3 /sdmrdfizer/rdfizer/run_rdfizer.py /sdmrdfizer/configs/join-selectivity-config.ini
				exit_status=$?
				finish=$(date +%s.%N)
				dur=$(echo "$finish - $start" | bc)
				if [ $exit_status -eq 124 ]
				then
					echo "synthetic-join-selectivity,$type,$i,$j,TimeOut">>/results/results-times-join-selectivity.csv
					total=0
					break
				else
					sort /results/join-selectivity-$i-$j-$t.nt 
					lines=$(< "/results/join-selectivity.nt" wc - l)
					echo "synthetic-join-selectivity,$type,$i,$j,$t,$lines,$dur">>/results/results-times-join-selectivity-detail.csv
					total=$(($total + $dur))
					if [ $j -ne 5 ]
					then
						rm /results/join-selectivity.nt
					fi
				fi
			done
			mv /results/join-selectivity.nt /results/synthetic-join-selectivity-$type-$i-$j.nt
			if [ $total -ne 0 ]
			then
				total=$(($total / 5))
				echo "synthetic-join-selectivity,$type,$i,$j,$total">>/results/results-times-join-selectivity.csv
			fi
			
		done
	done
	sed -i 's/enrichment: yes/enrichment: no/g' /sdmrdfizer/configs/join-selectivity-config.ini
done
rm /data/*.csv
