#!/bin/bash

rm /results/relation-type/*
echo "dataset,config,type,size,percent,N,M,results,time">>/results/results-times-relation-type.csv
echo "dataset,config,type,size,percent,N,M,run,results,time">>/results/results-times-relation-type-detail.csv
sed -i 's/enrichment: no/enrichment: yes/g' /sdmrdfizer/configs/relation-type-config.ini
sed -i 's/n_m.rml.ttl/standard.rml.ttl/g' /sdmrdfizer/configs/relation-type-config.ini
declare -a configs=("enrich" "noenrich")

#one-n and n-one
for config in "${configs[@]}"
do
	for r in 1 2
	do
		if [ $r -eq 1 ];then
			type="one-n"
		else
			type="n-one"
		fi
		for i in 1 3 10 50 100
		do
			for j in 25 50
			do
				for u in 5 10 15
				do
					if [ $r -eq 1 ];then
						cp /data/synthetic-data/relation-type/$type/${i}k_rows/table1.csv /data/table1.csv
						cp /data/synthetic-data/relation-type/$type/${i}k_rows/table2_50_${u}_${j}_percent.csv /data/table2.csv
					else
						cp /data/synthetic-data/relation-type/$type/${i}k_rows/table1_50_${u}_${j}_percent.csv /data/table1.csv
						cp /data/synthetic-data/relation-type/$type/${i}k_rows/table2.csv /data/table2.csv
					fi
					total=0
					for t in 1 2 3 4 5
					do
						start=$(date +%s.%N)
						timeout 10h python3 /sdmrdfizer/rdfizer/run_rdfizer.py /sdmrdfizer/configs/relation-type-config.ini
						exit_status=$?
						finish=$(date +%s.%N)
						dur=$(echo "$finish - $start" | bc)
						if [ $exit_status -eq 124 ];then
							echo "synthetic-relation-type,$config,$type,$i,$j,$u,1,0,TimeOut">>/results/results-times-relation-type.csv
							total=0
							break
						else
							lines=$(cat "/results/relation-type.nt" | wc -l)
							echo "synthetic-relation-type,$config,$type,$i,$j,$u,1,$t,$lines,$dur">>/results/results-times-relation-type-detail.csv
							total=$(echo "$total+$dur" | bc)
							if [ $t -ne 5 ];then
								rm /results/relation-type.nt
							fi
						fi
					done
					mv /results/relation-type.nt /results/synthetic-relation-type-$config-$type-$i-$j-$u.nt
					mv /results/relation-type_datasets_stats.csv /results/stats_relation-type-$config-$type-$i-$j-$u.csv
					if (( $(echo "$total > 0" | bc -l) ));then	
						total=$(echo "$total/5" | bc -l)
						echo "synthetic-relation-type,$config,$type,$i,$j,$u,1,$lines,$total">>/results/results-times-relation-type.csv
					fi
				done
			done
		done
	done
	sed -i 's/enrichment: yes/enrichment: no/g' /sdmrdfizer/configs/relation-type-config.ini
done

#n-m
total=0
sed -i 's/enrichment: no/enrichment: yes/g' /sdmrdfizer/configs/relation-type-config.ini
sed -i 's/standard.rml.ttl/n_m.rml.ttl/g' /sdmrdfizer/configs/relation-type-config.ini

for config in "${configs[@]}"
do
	for i in 1 3 10 50 100
	do
		for u in 3 5 10
		do
			for z in 3 5 10
			do
				for j in 10 25 50
				do
					cp /data/synthetic-data/relation-type/n-m/${i}k_rows/table1_50_${u}_${z}_${j}_percent.csv /data/table1.csv
					cp /data/synthetic-data/relation-type/n-m/${i}k_rows/table2_50_${u}_${z}_${j}_percent.csv /data/table2.csv
					total=0
					for t in 1 2 3 4 5
					do
						start=$(date +%s.%N)
						timeout 10h python3 /sdmrdfizer/rdfizer/run_rdfizer.py /sdmrdfizer/configs/relation-type-config.ini
						exit_status=$?
						finish=$(date +%s.%N)
						dur=$(echo "$finish - $start" | bc)
						if [ $exit_status -eq 124 ];then
							echo "synthetic-relation-type,$config,n-m,$i,$j,$u,$z,0,TimeOut">>/results/results-times-relation-type.csv
							total=0
							break
						else
							lines=$(cat "/results/relation-type.nt" | wc -l)
							echo "synthetic-relation-type,$config,n-m,$i,$j,$u,$z,$t,$lines,$dur">>/results/results-times-relation-type-detail.csv
							total=$(echo "$total+$dur" | bc)
							if [ $t -ne 5 ];then
								rm /results/relation-type.nt
							fi
						fi
					done
					mv /results/relation-type.nt /results/synthetic-relation-type-$config-n-m-$i-$j-$u-$z.
					mv /results/relation-type_datasets_stats.csv /results/stats_relation-type-$config-$type-$i-$j-$u.csv
					if (( $(echo "$total > 0" | bc -l) ));then
						total=$(echo "$total/5" | bc -l)
						echo "synthetic-relation-type,$config,n-m,$i,$j,$u,$z,$lines,$total">>/results/results-times-relation-type.csv
					fi
				done
			done
		done
	done
	sed -i 's/enrichment: yes/enrichment: no/g' /sdmrdfizer/configs/relation-type-config.ini
done

rm /data/*.csv
mkidr -p /results/relation-type
mv /results/*.csv /results/relation-type/
mv /results/*.nt /results/relation-type/







