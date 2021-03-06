FROM ubuntu:12.04

RUN touch /home/docker.build.log

RUN apt-get update -y \
    && apt-get upgrade -y \
    && apt-get install \
        apt-utils \
        libxml2-utils \
        wget -y \
    | tee --append /home/docker.build.log

RUN wget http://download.opensuse.org/repositories/home:/laszlo_budai:/syslog-ng/xUbuntu_12.04/Release.key| tee --append /home/docker.build.log

RUN cat Release.key | apt-key add - | tee --append /home/docker.build.log

RUN echo "deb http://download.opensuse.org/repositories/home:/laszlo_budai:/syslog-ng/xUbuntu_12.04 ./" | tee --append /etc/apt/sources.list.d/syslog-ng-obs.list | tee --append /home/docker.build.log

RUN apt-get update -y | tee --append /home/docker.build.log

RUN wget https://raw.githubusercontent.com/balabit/syslog-ng-docker/master/syslog-ng-dev/dev-dependencies.txt --no-check-certificate | tee --append /home/docker.build.log

RUN for i in $(grep -vE "^\s*#" dev-dependencies.txt | tr "\n" " "); do apt-get install -y $i; done | tee --append /home/docker.build.log

