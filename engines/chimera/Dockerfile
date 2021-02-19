FROM openjdk:11-jdk

RUN wget -O chimera-gtfs-1.0.0.jar https://github.com/cefriel/chimera/releases/download/v2.1/chimera-example-1.0.0.jar

RUN mkdir /inbox
RUN touch /inbox/exec-once.txt

RUN mkdir /routes
RUN mkdir /data
RUN mkdir /lifting
RUN mkdir /out

ENTRYPOINT ["java", "-jar", "chimera-gtfs-1.0.0.jar"]
