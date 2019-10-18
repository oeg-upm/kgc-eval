FROM ubuntu:18.04

RUN apt-get update && apt-get install -y openjdk-8-jdk vim htop bc curl
RUN mkdir /rmlstreamer && mkdir /data && mkdir /results && mkdir /mappings

RUN curl -L https://archive.apache.org/dist/flink/flink-1.3.2/flink-1.3.2-bin-hadoop2-scala_2.10.tgz > flink.tgz
RUN curl -L https://github.com/RMLio/RMLStreamer/releases/download/v1.1.0/RMLStreamer-1.1.0-RELEASE.jar > /rmlstreamer/streamer.jar


COPY . /rmlstreamer/

RUN tar xzf flink.tgz
RUN mv /rmlstreamer/json-mapreduce-1.0.jar /flink-1.3.2/lib && mv /rmlstreamer/flink-conf.yaml /flink-1.3.2/conf

RUN /flink-1.3.2/bin/start-local.sh > /dev/null

CMD ["tail", "-f", "/dev/null"]
