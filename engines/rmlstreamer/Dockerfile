FROM ubuntu:18.04

RUN apt-get update && apt-get install -y openjdk-8-jdk vim htop bc curl

RUN curl -L https://archive.apache.org/dist/flink/flink-1.11.2/flink-1.11.2-bin-scala_2.11.tgz> flink.tgz
RUN curl -L https://github.com/RMLio/RMLStreamer/releases/download/v2.0.0/RMLStreamer-2.0.0.jar > /streamer.jar

RUN tar xzf flink.tgz
RUN /flink-1.11.2/bin/start-cluster.sh > /dev/null

RUN mkdir /data
RUN mkdir /mappings
RUN mkdir /results
RUN mkdir /configs

CMD ["tail", "-f", "/dev/null"]