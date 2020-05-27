#!/bin/bash
rm /results/partitioning/*
echo "dataset,config,type,size,dup,case,results,time">>/results/results-times-partitioning.csv
echo "dataset,config,type,size,dup,case,run,results,time">>/results/results-times-partitioning-detail.csv
declare -a types=("horizontal" "vertical")
declare -a duplicates=("with_dup" "without_dup")
declare -a cases=("worst_case" "best_case")

for i in 1 3 10 50 100
do
	for type in "${types[@]}"
	do
		for dup in "${duplicates[@]}"
		do
			for case in "${cases[@]}"
			do
				sed -i "s/synthetic\/.*.rml.ttl/synthetic\/${type}_${dup}_${case}.rml.ttl/g" /rocketrml/index-partitioning-${case}-${types}.js
				cp /data/synthetic-data/partitioning/${type}_${dup}_${case}/${i}k_rows/*.csv /data/
				total=0
				for t in 1 2 3 4 5
				do
					start=$(date +%s.%N)
					timeout 10h node index-partitioning-${case}-${types}.js
					exit_status=$?
					finish=$(date +%s.%N)
					dur=$(echo "$finish - $start" | bc)
					if [ $exit_status -eq 124 ];then
						echo "synthetic-partitioning,$config,$type,$i,$dup,$case,0,TimeOut">>/results/results-times-partitioning.csv
						total=0
						break
					else
						lines=$(cat "/results/partitioning.nt" | wc -l)
						echo "synthetic-partitioning,$config,$type,$i,$dup,$case,$t,$lines,$dur">>/results/results-times-partitioning-detail.csv
						total=$(echo "$total+$dur" | bc)
						if [ $t -ne 5 ];then
							rm /results/partitioning.nt
						fi
					fi
				done
				mv /results/partitioning.nt /results/synthetic-partitioning-$config-$i-$type-$dup-$case.nt
				if (( $(echo "$total > 0" | bc -l) ));then
					total=$(echo "$total/5" | bc -l)
					echo "synthetic-partitioning,$config,$type,$i,$dup,$case,$lines,$total">>/results/results-times-partitioning.csv
				fi
			done
		done
	done 
done
rm /data/*.csv
mkidr -p /results/partitioning
mv /results/*.csv /results/partitioning/
mv /results/*.nt /results/partitioning/
