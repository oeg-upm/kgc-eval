#!/bin/bash

rm /results/*
echo "dataset,config,size,duplicates,percent,time">>/results/results-times-join-duplicates.csv
echo "dataset,config,size,duplicates,percent,run,results,time">>/results/results-times-join-duplicates-detail.csv
declare -a configs=("enrich" "noenrich")

for type in "${configs[@]}"
do
	for i in 1 3 10 50
	do
		for j in 3 5 10 20
		do
			for u in 5 10 20 30 40 50
			do
				cp /data/synthetic-data/join-duplicates/$ik_rows/table1.csv /data/table1.csv
				cp /data/synthetic-data/join-duplicates/$ik_rows/table2_$j_$u_percent.csv /data/table2.csv
				for t in 1 2 3 4 5
				do
					start=$(date +%s.%N)
					timeout 10h python3 /sdmrdfizer/rdfizer/run_rdfizer.py /sdmrdfizer/configs/join-duplicates.ini
					exit_status=$?
					finish=$(date +%s.%N)
					dur=$(echo "$finish - $start" | bc)
					if [ $exit_status -eq 124 ]
					then
						echo "synthetic-join-duplicates,$type,$i,$j,$u,TimeOut">>/results/results-times-join-duplicates.csv
						total=0
						break
					else
						sort /results/join-duplicates.nt 
						lines=$(< "/results/join-duplicates.nt" wc - l)
						echo "synthetic-join-duplicates,$type,$i,$j,$u,$t,$lines,$dur">>/results/results-times-join-duplicates-detail.csv
						total=$(($total + $dur))
						if [ $j -ne 5 ]
						then
							rm /results/join-duplicates.nt
						fi
					fi
				done
				mv /results/join-duplicates.nt /results/synthetic-join-duplicates-$type-$i-$j.nt
				if [ $total -ne 0 ]
				then
					total=$(($total / 5))
					echo "synthetic-join-duplicates,$type,$i,$j,$u,$total">>/results/results-times-join-duplicates.csv
				fi
			done
		done
	done
	sed -i 's/enrichment: yes/enrichment: no/g' /sdmrdfizer/configs/naive-config.ini 
done
rm /data/*.csv