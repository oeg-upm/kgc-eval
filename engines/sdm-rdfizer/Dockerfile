FROM python:3.9

RUN apt-get update && apt-get install -y less vim wget unzip

RUN wget -O sdm-rdfizer.zip https://github.com/SDM-TIB/SDM-RDFizer/archive/v3.4.zip
RUN unzip sdm-rdfizer.zip && mv SDM-RDFizer-3.4 sdm-rdfizer 
RUN python3 -m pip install -r sdm-rdfizer/requirements.txt


RUN mkdir /data
RUN mkdir /mappings
RUN mkdir /results
RUN mkdir /configs

CMD ["tail", "-f", "/dev/null"]
