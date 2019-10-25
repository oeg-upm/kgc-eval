
# RMLStreamer Engine


## How to run the evaluation?
After creating the images of all the engines with the docker-compose file, you can:

- Run specific experiment using one of the scripts
```
docker exec -it rmlstreamer /rmlstreamer/SCRIPT.sh
```
- Run all the experiments (recommended to run in background)
```
docker exec -it rmlstreamer /rmlstreamer/evaluate.sh
```
- Run your own case (put your data in the root data folder and your mapping in the root mapping folder)
```
docker exec -it rmlstreamer /rmlstreamer/run.sh -p /mappings/YOURMAPPING.rml.ttl -o /results/output.ttl
```



Github: https://github.com/RMLio/RMLStreamer

