FROM ubuntu:18.04

RUN apt-get update
RUN apt-get upgrade -y

RUN apt-get update && apt-get install -y openjdk-8-jdk less vim wget unzip

RUN wget -O ontop.zip https://github.com/ontop/ontop/releases/download/ontop-4.0.3/ontop-cli-4.0.3.zip
RUN unzip ontop.zip -d ontop
COPY mysql-connector.jar /ontop/jdbc/


RUN mkdir /results
RUN mkdir /data
RUN mkdir /mappings
RUN mkdir /configs

CMD ["tail", "-f", "/dev/null"]