#!/bin/bash

rm /results/*
echo "dataset,config,size,columns,time">>/results/results-times-naive.csv
echo "dataset,config,size,columns,run,results,time">>/results/results-times-naive-detail.csv
declare -a configs=("enrich" "noenrich")

for type in "${configs[@]}"
do
	for i in 1 3 10 50
	do
		for j in 2 5 10 20 30
		do
			sed -i "s/[0-9]+_columns/$j_columns/g" /sdmrdfizer/configs/naive-config.ini 
			cp /data/synthetic-data/naive/$ik_rows/$j_columns_table.csv /data/table.csv
			for t in 1 2 3 4 5
			do
				start=$(date +%s.%N)
				timeout 10h python3 /sdmrdfizer/rdfizer/run_rdfizer.py /sdmrdfizer/configs/naive-config.ini 
				exit_status=$?
				finish=$(date +%s.%N)
				dur=$(echo "$finish - $start" | bc)
				if [ $exit_status -eq 124 ]
				then
					echo "synthetic-naive,$type,$i,$j,TimeOut">>/results/results-times-naive.csv
					total=0
					break
				else
					sort /results/naive.nt 
					lines=$(< "/results/naive.nt" wc - l)
					echo "synthetic-naive,$type,$i,$j,$t,$lines,$dur">>/results/results-times-naive-detail.csv
					total=$(($total + $dur))
					if [ $j -ne 5 ]
					then
						rm /results/naive.nt						
					fi
				fi
			done
			mv /results/naive.nt /results/synthetic-naive-$type-$i-$j.nt
			if [ $total -ne 0 ]
			then
				total=$(($total / 5))
				echo "synthetic-naive,$type,$i,$j,$total">>/results/results-times-naive.csv
			fi	
		done
	done
	sed -i 's/enrichment: yes/enrichment: no/g' /sdmrdfizer/configs/naive-config.ini 
done
rm /data/*.csv