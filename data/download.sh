#!/bin/bash

cd madrid-gtfs
./gtfs-download.sh
cd ../bio2rdf
./bio2rdf-download.sh
cd ../synthetic-data
./synthetic-download.sh
