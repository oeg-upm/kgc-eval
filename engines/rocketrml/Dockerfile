FROM node:15


RUN apt-get update && apt-get install -y vim htop bc wget
RUN npm i -g rocketrml@1.8.2

RUN mkdir /results
RUN mkdir /data
RUN mkdir /mappings
RUN mkdir /configs

CMD ["tail", "-f", "/dev/null"]