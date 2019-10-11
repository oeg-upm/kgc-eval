# Use an official Python runtime as a parent image
FROM python:3.3

RUN apt-get update && apt-get install -y htop vim bc

# Set the working directory to /sdmrdfizer
WORKDIR /sdmrdfizer

# Copy the current directory contents into the container at /sdmrdfizer
COPY . /sdmrdfizer

RUN unzip /sdmrdfizer/sdm-rdfizer-v3.2.zip

# Install any needed packages specified in requirements.txt
RUN pip install mysql-connector-python
RUN pip install rdflib
RUN pip install psycopg2
RUN pip install --trusted-host pypi.python.org -r /sdmrdfizer/requirements.txt

RUN mkdir /results & mkdir /mappings & mkdir /data

# Run app.py when the container launches
CMD ["tail", "-f", "/dev/null"]

