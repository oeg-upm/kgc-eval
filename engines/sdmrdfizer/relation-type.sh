#!/bin/bash

rm /results/*
echo "dataset,config,type,size,percent,N,M,time">>/results/results-times-relation-type.csv
echo "dataset,config,type,size,percent,N,M,run,results,time">>/results/results-times-relation-type-detail.csv
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
						cp /data/synthetic-data/relation-type/$type/$ik_rows/table1.csv /data/table1.csv
						cp /data/synthetic-data/relation-type/$type/$ik_rows/table2_50_$u_$j_percent.csv /data/table2.csv
					else
						cp /data/synthetic-data/relation-type/$type/$ik_rows/table1_50_$u_$j_percent.csv /data/table1.csv
						cp /data/synthetic-data/relation-type/$type/$ik_rows/table2.csv /data/table2.csv
					fi
					for t in 1 2 3 4 5
					do
						start=$(date +%s.%N)
						timeout 10h python3 /sdmrdfizer/rdfizer/run_rdfizer.py /sdmrdfizer/configs/relation-type-config.ini
						exit_status=$?
						finish=$(date +%s.%N)
						dur=$(echo "$finish - $start" | bc)
						if [ $exit_status -eq 124 ];then
							echo "synthetic-relation-type,$config,$type,$i,$j,$u,1,TimeOut">>/results/results-times-relation-type.csv
							total=0
							break
						else
							lines=$(cat "/results/relation-type.nt" | wc -l)
							echo "synthetic-relation-type,$config,$type,$i,$j,$u,1,$t,$lines,$dur">>/results/results-times-relation-type-detail.csv
							total=$(echo "$total+$dur" | bc)
							if [ $j -ne 5 ];then
								rm /results/relation-type.nt
							fi
						fi
					done
					mv /results/relation-type.nt /results/synthetic-relation-type-$config-$type-$i-$j-$u.nt
					if (( $(echo "$total > 0" | bc -l) ));then	
						total=$(echo "$total/5" | bc -l)
						echo "synthetic-relation-type,$config,$type,$i,$j,$u,1,$total">>/results/results-times-relation-type.csv
					fi
				done
			done
		done
	done
	sed -i 's/enrichment: yes/enrichment: no/g' /sdmrdfizer/configs/relation-type-config.ini
done

#n-m
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
					cp /data/synthetic-data/relation-type/n-m/$ik_rows/table1_50_$u_$z_$j_percent.csv /data/table1.csv
					cp /data/synthetic-data/relation-type/n-m/$ik_rows/table2_50_$u_$z_$j_percent.csv /data/table2.csv
					for t in 1 2 3 4 5
					do
						start=$(date +%s.%N)
						timeout 10h python3 /sdmrdfizer/rdfizer/run_rdfizer.py /sdmrdfizer/configs/relation-type-config.ini
						exit_status=$?
						finish=$(date +%s.%N)
						dur=$(echo "$finish - $start" | bc)
						if [ $exit_status -eq 124 ];then
							echo "synthetic-relation-type,$config,n-m,$i,$j,$u,$z,TimeOut">>/results/results-times-relation-type.csv
							total=0
							break
						else
							lines=$(cat "/results/relation-type.nt" | wc -l)
							echo "synthetic-relation-type,$config,n-m,$i,$j,$u,$z,$t,$lines,$dur">>/results/results-times-relation-type-detail.csv
							total=$(echo "$total+$dur" | bc)
							if [ $j -ne 5 ];then
								rm /results/relation-type.nt
							fi
						fi
					done
					mv /results/relation-type.nt /results/synthetic-relation-type-$config-n-m-$i-$j-$u-$z.nt
					if (( $(echo "$total > 0" | bc -l) ));then
						total=$(echo "$total/5" | bc -l)
						echo "synthetic-relation-type,$config,n-m,$i,$j,$u,$z,$total">>/results/results-times-relation-type.csv
					fi
				done
			done
		done
	done
	sed -i 's/enrichment: yes/enrichment: no/g' /sdmrdfizer/configs/relation-type-config.ini
done

rm /data/*.csv








