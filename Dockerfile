FROM atlassian/default-image:2 
WORKDIR /sourcecode

RUN useradd -m user
RUN mkdir -p /home/user/.ssh
RUN chown -R user:user /home/user/.ssh
RUN echo "Host *\n\tStrictHostKeyChecking no\n" >> /home/user/.ssh/config

USER user

RUN mkdir -p ~/bin
RUN echo $(wget -q -O - https://portal.heliumapps.com/release-latest-version) > ~/version.txt
RUN touch ~/bin/version.txt
RUN git config --global --add safe.directory /sourcecode
RUN curl https://portal.heliumapps.com/static/deploy-helium-dev.sh | bash
RUN mv ~/bin/HeliumDev-app-$(cat ~/version.txt)-jar-with-dependencies.jar ~/bin/HeliumDev-app.jar
RUN mv ~/bin/HeliumDev-app-$(cat ~/version.txt)-no-ui-jar-with-dependencies.jar ~/bin/HeliumDev-app-no-ui.jar
RUN echo alias he=\"java -jar ~/bin/HeliumDev-app.jar\" >> ~/.bashrc




