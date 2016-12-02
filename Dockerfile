# HUB Testing - Base Image (Oracle XE 11g and Java 6)
FROM wnameless/oracle-xe-11g
MAINTAINER Jose M. Fernandez-Alba <jm.fernandezalba@commonms.com>

# Prepare user
RUN echo "hubpass\nhubpass\n" | passwd root

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

ENV JAVA_HOME /usr/lib/jvm/java-6-oracle

# Install other tools
RUN apt-get update \
    && apt-get install -y \
    gawk \
    python \
    rsync \
    rlwrap \
    nano \
    dos2unix \
    git \
    && rm -rf /var/lib/apt/lists/*

# Configuration for jsch
RUN echo "KexAlgorithms curve25519-sha256@libssh.org,ecdh-sha2-nistp256,ecdh-sha2-nistp384,ecdh-sha2-nistp521,diffie-hellman-group-exchange-sha256,diffie-hellman-group14-sha1,diffie-hellman-group-exchange-sha1,diffie-hellman-group1-sha1" >> /etc/ssh/sshd_config
