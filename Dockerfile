FROM arm32v7/ubuntu:xenial

RUN apt-get update -qq && \
    apt-get dist-upgrade -qq && \
    apt-get install -qq -y --no-install-recommends wget ca-certificates haveged tzdata && \
    echo 'deb http://www.ubnt.com/downloads/unifi/debian stable ubiquiti' | tee /etc/apt/sources.list.d/100-ubnt-unifi.list && \
    wget -q -O /etc/apt/trusted.gpg.d/unifi-repo.gpg https://dl.ubnt.com/unifi/unifi-repo.gpg && \
    ln -sf /usr/share/zoneinfo/Europe/London /etc/localtime && \
    dpkg-reconfigure -f noninteractive tzdata && \
    apt-get update -qq

RUN  apt-get install -qq -y --no-install-recommends unifi

WORKDIR /var/lib/unifi

ENTRYPOINT ["/usr/bin/java", "-Xmx1024M", "-jar", "/usr/lib/unifi/lib/ace.jar"]
CMD ["start"]
