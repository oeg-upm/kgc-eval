#!/bin/bash

rm /results/join-selectivity/*
echo "dataset,config,size,percent,results,time">>/results/results-times-join-selectivity.csv
echo "dataset,config,size,percent,run,results,time">>/results/results-times-join-selectivity-detail.csv
declare -a configs=("enrich" "noenrich")

for type in "${configs[@]}"
do
	for i in 1 3 10 50 100
	do
		for j in 5 10 20 30 50 60 80 100
		do
			cp /data/synthetic-data/join-selectivity/${i}k_rows/table1.csv /data/table1.csv
			cp /data/synthetic-data/join-selectivity/${i}k_rows/table2_${j}_percent.csv /data/table2.csv
			total=0
			for t in 1 2 3 4 5
			do
				start=$(date +%s.%N)
				timeout 10h python3 /sdmrdfizer/rdfizer/run_rdfizer.py /sdmrdfizer/configs/join-selectivity-config.ini
				exit_status=$?
				finish=$(date +%s.%N)
				dur=$(echo "$finish - $start" | bc)
				if [ $exit_status -eq 124 ];then
					echo "synthetic-join-selectivity,$type,$i,$j,0,TimeOut">>/results/results-times-join-selectivity.csv
					total=0
					break
				else
					lines=$(cat "/results/join-selectivity.nt" | wc -l)
					echo "synthetic-join-selectivity,$type,$i,$j,$t,$lines,$dur">>/results/results-times-join-selectivity-detail.csv
					total=$(echo "$total+$dur" | bc)
					if [ $t -ne 5 ];then
						rm /results/join-selectivity.nt
					fi
				fi
			done
			mv /results/join-selectivity.nt /results/synthetic-join-selectivity-$type-$i-$j.nt
			mv /results/join-selectivity_datasets_stats.csv /results/stats_join-selectivity-$type-$i-$j.csv
			if (( $(echo "$total > 0" | bc -l) ));then	
				total=$(echo "$total/5" | bc -l)
				echo "synthetic-join-selectivity,$type,$i,$j,$lines,$total">>/results/results-times-join-selectivity.csv
			fi
		done
	done
	sed -i 's/enrichment: yes/enrichment: no/g' /sdmrdfizer/configs/join-selectivity-config.ini
done
rm /data/*.csv
mkdir -p /results/join-selectivity
mv /results/*.csv /results/join-selectivity/
mv /results/*.nt /results/join-selectivity/