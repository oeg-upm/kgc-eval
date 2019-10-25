#!/bin/bash

rm /results/*
echo "dataset,type,size,percent,N,M,time">>/results/results-times-relation-type.csv
echo "dataset,type,size,percent,N,M,run,results,time">>/results/results-times-relation-type-detail.csv


#one-n and n-one
for r in 1 2
do
	if [ r -eq 1 ]
	then
		type="one-n"
	else
		type="n-one"
	fi
	for i in 1 3 10 50
	do
		for j in 25 50
		do
			for u in 5 10 15
			do
				if [ r -eq 1 ]
				then
					cp /data/synthetic-data/relation-type/$type/$ik_rows/table1.csv /data/table1.csv
					cp /data/synthetic-data/relation-type/$type/$ik_rows/table2_50_$u_$j_percent.csv /data/table2.csv
				else
					cp /data/synthetic-data/relation-type/$type/$ik_rows/table1_50_$u_$j_percent.csv.csv /data/table1.csv
					cp /data/synthetic-data/relation-type/$type/$ik_rows/table2.csv /data/table2.csv
				fi
				for t in 1 2 3 4 5
				do
					start=$(date +%s.%N)
					timeout 10h java -jar /carml/carml.jar -m /mappings/synthetic/standard.rml.ttl -o /results/synthetic-relation-type-$type-$i-$j-$u-$t.nt -d
					exit_status=$?
					finish=$(date +%s.%N)
					dur=$(echo "$finish - $start" | bc)
					if [ $exit_status -eq 124 ]
					then
						echo "synthetic-relation-type,$type,$i,$j,$u,1,TimeOut">>/results/results-times-relation-type.csv
						total=0
						break
					else
						sort /results/synthetic-relation-type-$type-$i-$j-$u-$t.nt
						lines=$(< "/results/synthetic-relation-type-$type-$i-$j-$u-$t.nt" wc - l)
						echo "synthetic-relation-type,$type,$i,$j,$u,1,$t,$lines,$dur">>/results/results-times-relation-type-detail.csv
						total=$(($total + $dur))
						if [ $j -ne 5 ]
						then
							rm /results/synthetic-relation-type-$type-$i-$j-$u-$t.nt
						fi
					fi
				done
				if [ $total -ne 0 ]
				then
					total=$(($total / 5))
					echo "synthetic-relation-type,$type,$i,$j,$u,1,$total">>/results/results-times-relation-type.csv
				fi
			done
		done
	done
done


#n-m

for i in 1 3 10 50
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
					timeout 10h java -jar /carml/carml.jar -m /mappings/synthetic/n_m.rml.ttl -o /results/synthetic-relation-type-n-m-$i-$j-$u-$z-$t.nt -d
					exit_status=$?
					finish=$(date +%s.%N)
					dur=$(echo "$finish - $start" | bc)
					if [ $exit_status -eq 124 ]
					then
						echo "synthetic-relation-type,n-m,$i,$j,$u,$z,TimeOut">>/results/results-times-relation-type.csv
						total=0
						break
					else
						sort /results/synthetic-relation-type-n-m-$i-$j-$u-$z-$t.nt
						lines=$(< "/results/synthetic-relation-type-n-m-$i-$j-$u-$z-$t.nt" wc - l)
						echo "synthetic-relation-type,n-m,$i,$j,$u,$z,$t,$lines,$dur">>/results/results-times-relation-type-detail.csv
						total=$(($total + $dur))
						if [ $j -ne 5 ]
						then
							rm /results/synthetic-relation-type-n-m-$i-$j-$u-$z-$t.nt
						fi
					fi
				done
				if [ $total -ne 0 ]
				then
					total=$(($total / 5))
					echo "synthetic-relation-type,n-m,$i,$j,$u,$z,$total">>/results/results-times-relation-type.csv
				fi
			done
		done
	done
done

rm /data/*.csv








