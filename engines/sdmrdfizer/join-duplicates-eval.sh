#!/bin/bash

rm /results/join-duplicates/*
echo "dataset,config,size,duplicates,percent,time">>/results/results-times-join-duplicates.csv
echo "dataset,config,size,duplicates,percent,run,results,time">>/results/results-times-join-duplicates-detail.csv
declare -a configs=("enrich" "noenrich")

for type in "${configs[@]}"
do
	for i in 1 3 10 50 100
	do
		for j in 3 5 10 20
		do
			for u in 5 10 20 30 40 50
			do
				cp /data/synthetic-data/join-duplicates/${i}k_rows/table1.csv /data/table1.csv
				cp /data/synthetic-data/join-duplicates/${i}k_rows/table2_${j}_${u}_percent.csv /data/table2.csv
				total=0
				for t in 1 2 3 4 5
				do
					start=$(date +%s.%N)
					timeout 10h python3 /sdmrdfizer/rdfizer/run_rdfizer.py /sdmrdfizer/configs/join-duplicates-config.ini
					exit_status=$?
					finish=$(date +%s.%N)
					dur=$(echo "$finish - $start" | bc)
					if [ $exit_status -eq 124 ];then
						echo "synthetic-join-duplicates,$type,$i,$j,$u,0,TimeOut">>/results/results-times-join-duplicates.csv
						total=0
						break
					else
						lines=$(cat "/results/join-duplicates.nt" | wc -l)
						echo "synthetic-join-duplicates,$type,$i,$j,$u,$t,$lines,$dur">>/results/results-times-join-duplicates-detail.csv
						total=$(echo "$total+$dur" | bc)
						if [ $t -ne 5 ];then
							rm /results/join-duplicates.nt
						fi
					fi
				done
				mv /results/join-duplicates.nt /results/synthetic-join-duplicates-$type-$i-$j.nt
				mv /results/join-duplicates_datasets_stats.csv /results/stats_join-duplicates-$type-$i-$j.csv		
				if (( $(echo "$total > 0" | bc -l) ));then
					total=$(echo "$total/5" | bc -l)
					echo "synthetic-join-duplicates,$type,$i,$j,$u,$total">>/results/results-times-join-duplicates.csv
				fi
			done
		done
	done
	sed -i 's/enrichment: yes/enrichment: no/g' /sdmrdfizer/configs/join-duplicates-config.ini
done
rm /data/*.csv
mkdir -p /results/join-duplicates
mv /results/*.csv /results/join-duplicates/
mv /results/*.nt /results/join-duplicates/
