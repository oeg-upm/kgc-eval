
# SDM-RDFizer Engine


## How to run the evaluation?
After creating the images of all the engines with the docker-compose file, you can:

- Run specific experiment using one of the scripts
```
docker exec -it sdmrdfizer /sdmrdfizer/SCRIPT.sh
```
- Run all the experiments (recommended to run in background)
```
docker exec -it sdmrdfizer /sdmrdfizer/evaluate.sh
```
- Run your own case (put your data in the root data folder, your mapping in the root mapping folder and your config file in the config folder of sdmrdfizer)
```
docker exec -it sdmrdfizer python3 /sdmrdfizer/rdfizer/run_rdfizer.py /sdmrdfizer/configs/YOUR-CONFIG-FILE.ini
```



Github: https://github.com/SDM-TIB/SDM-RDFizer

