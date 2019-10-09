FROM node:8


RUN apt-get update && apt-get install -y vim htop bc wget

RUN npm init -y && npm i rocketrml


RUN mkdir /rocketrml
RUN mkdir /results
RUN mkdir /data
RUN mkdir /mappings

CMD ["tail", "-f", "/dev/null"]
