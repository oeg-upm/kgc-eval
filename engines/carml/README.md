
# CARML Engine


## How to run the evaluation?
After creating the images of all the engines with the docker-compose file, you can:

- Run specific experiment using one of the scripts
```
docker exec -it carml /carml/SCRIPT.sh
```
- Run all the experiments (recommended to run in background)
```
docker exec -it carml /carml/evaluate.sh
```
- Run your own case (put your data in the root data folder and your mapping in the root mapping folder)
```
docker exec -it carml java -jar /carml/carml.jar -m /mappings/YOURMAPPING.rml.ttl -o /results/output.ttl
```



Github: https://github.com/carml/carml

