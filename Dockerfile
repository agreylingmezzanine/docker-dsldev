FROM ubuntu:latest
# WORKDIR = /sourcecode

RUN apt-get update && apt-get install -y wget curl git jq software-properties-common;

RUN useradd -m user
RUN mkdir -p /home/user/.ssh
RUN chown -R user:user /home/user/.ssh
RUN echo "Host *\n\tStrictHostKeyChecking no\n" >> /home/user/.ssh/config

# Add the "JAVA" ppa
RUN add-apt-repository -y \
    ppa:ts.sch.gr/ppa

# Install OpenJDK-8
RUN apt-get update && \
    apt-get install -y openjdk-8-jdk;

# Fix certificate issues
RUN	apt-get install -y ca-certificates-java && \
    apt-get clean && \
    update-ca-certificates -f;

RUN apt-get clean;

USER user

RUN mkdir -p ~/bin
RUN touch ~/bin/version.txt

#fail fast check to ensure the endpoint is up
RUN echo $(wget -q -O - https://portal.heliumapps.com/release-latest-version) > ~/version.txt

RUN curl https://portal.heliumapps.com/static/deploy-helium-dev.sh | bash

RUN mv ~/bin/HeliumDev-app-$(wget -q -O - https://portal.heliumapps.com/release-latest-version)-jar-with-dependencies.jar ~/bin/HeliumDev-app.jar
RUN mv ~/bin/HeliumDev-app-$(wget -q -O - https://portal.heliumapps.com/release-latest-version)-no-ui-jar-with-dependencies.jar ~/bin/HeliumDev-app-no-ui.jar

RUN echo alias he=\"java -jar ~/bin/HeliumDev-app.jar\" >> ~/.bashrc

# Setup JAVA_HOME, this is useful for docker commandline
ENV JAVA_HOME /usr/lib/jvm/java-8-openjdk-amd64/
RUN export JAVA_HOME

#RUN git config --global --add safe.directory /sourcecode
