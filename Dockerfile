# HUB Testing - Base Image (Oracle XE 11g and Java 6)
FROM wnameless/oracle-xe-11g
MAINTAINER Jose M. Fernandez-Alba <jm.fernandezalba@commonms.com>

# Update repositories and common utils
RUN apt-get update \
    && apt-get install -y \
    ca-certificates \
    software-properties-common \
    debconf-utils \
    && rm -rf /var/lib/apt/lists/*

# Install Java 6 and 8 (Java 6 as default)
RUN add-apt-repository -y \
    ppa:webupd8team/java \
    && apt-get update \
    && echo "oracle-java6-installer shared/accepted-oracle-license-v1-1 select true" | debconf-set-selections \
    && echo "oracle-java8-installer shared/accepted-oracle-license-v1-1 select true" | debconf-set-selections \
    && apt-get install -y --allow-unauthenticated \
    oracle-java6-installer \
    oracle-java8-installer \
    && update-java-alternatives -s java-6-oracle \
    && rm -rf /var/lib/apt/lists/*

# Install other tools
RUN apt-get update \
    && apt-get install -y \
    gawk \
    && rm -rf /var/lib/apt/lists/*
