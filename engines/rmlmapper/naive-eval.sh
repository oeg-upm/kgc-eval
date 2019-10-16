#!/bin/bash

rm /results/*
echo "dataset,size,columns,time">>/results/results-times-naive.csv
echo "dataset,size,columns,run,results,time">>/results/results-times-naive-detail.csv


for i in 1 3 10 50
do
	for j in 2 5 10 20 30
	do
		cp /data/synthetic-data/naive/$ik_rows/$j_columns_table.csv /data/table.csv
		for t in 1 2 3 4 5
		do
			start=$(date +%s.%N)
			timeout 10h java -jar /rmlmapper/rmlmapper.jar -m /mappings/synthetic/$j_columns.rml.ttl -o /results/synthetic-naive-$i-$j-$t.nt -d
			exit_status=$?
			finish=$(date +%s.%N)
			dur=$(echo "$finish - $start" | bc)
			if [ $exit_status -eq 124 ]
			then
				echo "synthetic-naive,$i,$j,TimeOut">>/results/results-times-naive.csv
				total=0
				break
			else
				sort /results/synthetic-naive-$i-$j-$t.nt 
				lines=$(< "/results/synthetic-naive-$i-$j-$t.nt" wc - l)
				echo "synthetic-naive,$i,$j,$t,$lines,$dur">>/results/results-times-naive-detail.csv
				total=$(($total + $dur))
				if [ $j -ne 5 ]
				then
					rm /results/synthetic-naive-$i-$j-$t.nt
				fi
			fi
		done
		if [ $total -ne 0 ]
		then
			total=$(($total / 5))
			echo "synthetic-naive,$i,$j,$total">>/results/results-times-naive.csv
		fi
		
	done
done
rm /data/*.csv