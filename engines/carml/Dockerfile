FROM ubuntu:18.04

RUN apt-get update && apt-get install -y openjdk-8-jdk vim htop bc
RUN mkdir /carml
COPY . /carml

RUN mkdir /data
RUN mkdir /results
RUN mkdir /mappings
RUN mkdir /configs

CMD ["tail", "-f", "/dev/null"]
