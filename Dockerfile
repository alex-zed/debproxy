# Set base to Debian wheezy
FROM debian:wheezy

# install base packages
ENV DEBIAN_FRONTEND=noninteractive
WORKDIR /tmp

RUN apt-get update -y && \
    apt-get install -y apt-utils && \
    apt-get install -y \
      ca-certificates \
      libpython2.7 \
      python-apsw \
      python-gevent \
      python-m2crypto \
      python-psutil \
      supervisor \
      unzip \
      wget \
    && \

# create user to run aceproxy
    useradd --system --create-home --no-user-group --gid nogroup tv && \

# install acestream-engine
    wget  -o - http://dl.acestream.org/debian/7/acestream_3.0.5.1_debian_7.4_x86_64.tar.gz && \
    tar --show-transformed-names --transform='s/acestream_3.0.5.1_debian_7.4_x86_64/acestream/' -vzxf acestream_3.0.5.1_debian_7.4_x86_64.tar.gz && \
    mv acestream /usr/share && \
    ln -s /usr/share/acestream/acestreamengine /usr/bin/acestreamengine && \
    rm -rf /tmp/* && \

# obtain and unpack aceproxy
    wget -o - https://github.com/ValdikSS/aceproxy/archive/a937b0c1.zip -O aceproxy.zip && \
    unzip -d /home/tv aceproxy.zip && \
    mv /home/tv/aceproxy-* /home/tv/aceproxy && \
    rm -rf /tmp/*

# add services
ADD supervisord.conf /etc/supervisor/conf.d/supervisord.conf
ADD supervisor/supervisord.conf /etc/supervisor/supervisord.conf
ADD start.sh /usr/bin/start.sh
RUN chmod +x /usr/bin/start.sh

EXPOSE 22 8000 8621 62062 9944 9903
VOLUME /etc/aceproxy

WORKDIR /
ENTRYPOINT ["/usr/bin/start.sh"]
