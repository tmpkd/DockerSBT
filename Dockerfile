ARG OPENJDK_TAG=8u242

FROM openjdk:${OPENJDK_TAG}

ARG SBT_VERSION=1.3.8

# Install docker
RUN apt-get update
RUN apt-get -y --no-install-recommends install apt-transport-https ca-certificates curl gnupg2 software-properties-common
RUN curl -fsSL https://download.docker.com/linux/debian/gpg | apt-key add -
RUN add-apt-repository "deb [arch=amd64] https://download.docker.com/linux/debian $(lsb_release -cs) stable"

# Install sbt
RUN curl -L -o sbt-$SBT_VERSION.deb https://dl.bintray.com/sbt/debian/sbt-$SBT_VERSION.deb
RUN dpkg -i sbt-$SBT_VERSION.deb
RUN rm sbt-$SBT_VERSION.deb

# Install and clean
RUN apt-get update
RUN apt-get -y --no-install-recommends install docker-ce sbt
RUN rm -rf /var/lib/apt/lists/*

# Load sbt
RUN sbt sbtVersion

# Cleaning up
RUN rm -rf /var/lib/apt/lists/*
