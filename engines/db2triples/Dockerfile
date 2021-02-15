FROM ubuntu:18.04


RUN apt-get update
RUN apt-get upgrade -y

COPY . .

RUN mkdir /data
RUN mkdir /mappings
RUN mkdir /results
RUN mkdir /configs

CMD ["tail", "-f", "/dev/null"]