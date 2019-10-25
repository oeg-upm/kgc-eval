#!/bin/bash


rm /results/*
echo "dataset,type,size,dup,case,time">>/results/results-times-partitioning.csv
echo "dataset,type,size,dup,case,run,results,time">>/results/results-times-partitioning-detail.csv

declare -a types=("horizontal" "vertical")
declare -a duplicates=("with_dup" "without_dup")
declare -a cases=("worst_case" "best_case")


for i in 1 3 10 50
do
	for type in "${types[@]}"
	do
		for dup in "${duplicates[@]}"
		do
			for case in "${cases[@]}"
			do
				cp /data/synthetic-data/partitioning/$type_$dup_$case/$ik_rows/*.csv /data/
				for j in 1 2 3 4 5
				do
					start=$(date +%s.%N)
					if []
					timeout 10h /rmlstreamer/run.sh -p /mappings/synthetic/$type_$dup_$case.rml.ttl -o /results/synthetic-partitioning-$i-$type-$dup-$case.nt
					exit_status=$?
					finish=$(date +%s.%N)
					dur=$(echo "$finish - $start" | bc)
					if [ $exit_status -eq 124 ]
					then
						echo "synthetic-partitioning,$type,$i,$dup,$case,TimeOut">>/results/results-times-partitioning.csv
						total=0
						break
					else
						sort /results/synthetic-partitioning-$i-$type-$dup-$case.nt
						lines=$(< "/results/synthetic-partitioning-$i-$type-$dup-$case.nt" wc - l)
						echo "synthetic-partitioning,$type,$i,$dup,$case,$t,$lines,$dur">>/results/results-times-partitioning-detail.csv
						total=$(($total + $dur))
						if [ $j -ne 5 ]
						then
							rm /results/synthetic-partitioning-$i-$type-$dup-$case.nt
						fi
					fi
				done
				if [ $total -ne 0 ]
				then
					total=$(($total / 5))
					echo "synthetic-partitioning,$type,$i,$dup,$case,$total">>/results/results-times-relation-type.csv
				fi
			done
		done
	done 
done