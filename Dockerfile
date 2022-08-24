FROM eclipse-temurin:8
RUN apt-get update
RUN apt-get upgrade -y
RUN apt-get install wget
RUN useradd -m user
RUN mkdir -p /home/user/.ssh
RUN chown -R user:user /home/user/.ssh
RUN echo "Host *\n\tStrictHostKeyChecking no\n" >> /home/user/.ssh/config
USER user
RUN mkdir -p ~/bin
RUN touch ~/bin/version.txt
RUN curl https://portal.heliumapps.com/static/deploy-helium-dev.sh | bash
# Make the following dynamic to always pull the latest version
RUN echo alias he=\"java -jar ~/bin/HeliumDev-app-1.43.5-jar-with-dependencies.jar\" >> ~/.bashrc
WORKDIR /home/user
#CMD /bin/bash
#ENTRYPOINT [ "/opt/java/openjdk/bin/java -jar ~/bin/HeliumDev-app-1.43.5-jar-with-dependencies.jar" ]





