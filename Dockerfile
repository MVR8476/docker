FROM openjdk:8-jre-alpine
#FROM java:8

ENV VERSION="5.15.7" USER="activemq" 
LABEL activemq-version="${VERSION}" desc="Apache ActiveMQ"

RUN mkdir -p /opt
WORKDIR /opt
 
RUN wget -O activemq.tar.gz http://archive.apache.org/dist/activemq/${VERSION}/apache-activemq-${VERSION}-bin.tar.gz 

RUN tar -xzf activemq.tar.gz 
RUN rm -f apache-activemq-${VERSION}-bin.tar.gz

#RUN groupadd -r ${USER} && useradd -r -g ${USER} ${USER}
#RUN chown -R ${USER}:${USER} apache-activemq-${VERSION}

RUN ln -s apache-activemq-${VERSION} apache-activemq

#USER ${USER}

COPY conf/activemq.xml /apache-activemq/conf/activemq.xml
COPY conf/activemq.xml /apache-activemq/conf/activemq2.xml
COPY conf/RestAuthPlugin.jar /apache-activemq/lib/RestAuthPlugin.jar


CMD ["apache-activemq/bin/activemq", "console"]

# Expose all port

EXPOSE 8161
EXPOSE 61616
EXPOSE 5672
EXPOSE 61613
EXPOSE 1883
EXPOSE 61614
#REF : -https://hub.docker.com/r/antonw/activemq-jmx/dockerfile
#REF : - https://runnable.com/docker/basic-docker-networking
