# Set base to Debian stretch
FROM debian:stable-slim

# install base packages
ENV DEBIAN_FRONTEND=noninteractive
WORKDIR /tmp

RUN apt-get update -y && \
    apt-get install -y apt-utils && \
    apt-get install -y \
      ca-certificates \
      libpython2.7 \
      jq \
      ffmpeg \
      net-tools \
      libxslt1.1 \
      cron \
      nano \
      mc \
      python-pip \
      python-apsw \
      python-m2crypto \
      supervisor \
      unzip \
      wget \
    && \
    pip install --upgrade pip && \
    pip install --upgrade gevent psutil && \
    mkdir -p /mnt/media/playlists && \
# install acestream-engine
    wget  -o - http://dl.acestream.org/linux/acestream_3.1.16_debian_8.7_x86_64.tar.gz && \
    tar --show-transformed-names --transform='s/acestream_3.1.16_debian_8.7_x86_64/acestream/' -vzxf acestream_3.1.16_debian_8.7_x86_64.tar.gz && \
    mv acestream /usr/share && \
    rm -rf /tmp/*

# add services
ADD supervisord.conf /etc/supervisor/conf.d/supervisord.conf
ADD supervisor/supervisord.conf /etc/supervisor/supervisord.conf
ADD ace.hls_parser.sh /mnt/media/playlists/ace.hls_parser.sh
ADD libssl.so.1.0.0 /usr/share/acestream/lib/libssl.so.1.0.0
ADD libcrypto.so.1.0.0 /usr/share/acestream/lib/libcrypto.so.1.0.0
RUN chmod +x /mnt/media/playlists/ace.hls_parser.sh
RUN /mnt/media/playlists/ace.hls_parser.sh
ADD start.sh /usr/bin/start.sh
RUN chmod +x /usr/bin/start.sh

RUN rm -rf /tmp/*

EXPOSE 8621 62062 9944 9903 6878
VOLUME /mnt/media/playlists

WORKDIR /
ENTRYPOINT ["/usr/bin/start.sh"]
