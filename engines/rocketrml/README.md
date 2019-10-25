
# RocketRML Engine


## How to run the evaluation?
After creating the images of all the engines with the docker-compose file, you can:

- Run specific experiment using one of the scripts
```
docker exec -it rocketrml /rocketrml/SCRIPT.sh
```
- Run all the experiments (recommended to run in background)
```
docker exec -it rocketrml /rocketrml/evaluate.sh
```
- Run your own case (put your data in the root data folder and your mapping in the root mapping folder, edit index.js with the path of your mapping and the name of the output file)
```
docker exec -it rocketrml node index.js
```



Github: https://github.com/semantifyit/RocketRML

