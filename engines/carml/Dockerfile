FROM ubuntu:18.04


RUN apt-get update
RUN apt-get upgrade -y

RUN apt-get update && apt-get install -y openjdk-8-jdk less vim wget unzip

COPY . .

RUN mkdir /data
RUN mkdir /mappings
RUN mkdir /results
RUN mkdir /configs

CMD ["tail", "-f", "/dev/null"]