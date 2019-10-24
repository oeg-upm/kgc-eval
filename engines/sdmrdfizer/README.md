
# SDM-RDFizer Engines


## How to run the evaluation?
After creating the images of all the engines with the docker-compose file, you can:

- Run specific experiment using one of the scripts
```
docker exec -it sdmrdizer /sdmrdfizer/SCRIPT.sh
```
- Run all the experiments (recommended to run in background)
```
docker exec -it sdmrdizer /sdmrdfizer/evaluate.sh
```
- Run your own case (put your data in the data folder and your config file in the config folder of sdmrdizer)
```
docker exec -it sdmrdizer python3 /sdmrdfizer/rdfizer/run_rdfizer.py /sdmrdfizer/configs/YOUR-CONFIG-FILE.ini
```

- Github: https://github.com/SDM-TIB/SDM-RDFizer

