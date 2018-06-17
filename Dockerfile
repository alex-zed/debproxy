# Set base to Debian stretch
FROM debian:stable-slim

# install base packages
ENV DEBIAN_FRONTEND=noninteractive LANG=ru_RU.UTF-8 LANGUAGE=ru_RU:ru LC_ALL=ru_RU.UTF-8
WORKDIR /tmp

RUN apt-get update -y && \
      apt-get install -y apt-utils && \
      apt-get install -y \
      nano \
      tzdata \
      locales \
      htop \
      mc \
      wget && \
     
# install acestream-engine
   mkdir -p /opt/acestream/ && \
   wget -o - https://sybdata.de/files/public-docs/acestream_3.1.31_webUI_x86.tar.gz && \
   tar -zxvf acestream_3.1.31_webUI_x86.tar.gz && \
   mv androidfs /opt/acestream/androidfs && \
   find /opt/acestream/androidfs/system -type d -exec chmod 755 {} \; && \
   find /opt/acestream/androidfs/system -type f -exec chmod 644 {} \; && \
   chmod 755 /opt/acestream/androidfs/system/bin/* /opt/acestream/androidfs/acestream.engine/python/bin/python && \
# set /tmp on tmpfs
   echo "tmpfs /tmp tmpfs rw,nosuid,nodev 0 0" | tee -a /etc/fstab && \
   rm -rf /tmp/* 

# add services
ADD acestream.start /opt/acestream/acestream.start
ADD acestream.stop /opt/acestream/acestream.stop
ADD acestream.conf /opt/acestream/androidfs/acestream.engine/acestream.conf
ADD start.sh /usr/bin/start.sh
RUN chmod +x /usr/bin/start.sh
RUN chmod +x /opt/acestream/acestream.start
RUN chmod +x /opt/acestream/acestream.stop

EXPOSE 8621 62062 6878

WORKDIR /
ENTRYPOINT ["/usr/bin/start.sh"]
