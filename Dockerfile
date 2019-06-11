FROM ubuntu:bionic-20181204
LABEL maintainer="amti1barthwal@gmail.com"

ENV SQUID_VERSION=3.5.27 \
    SQUID_CACHE_DIR=/var/spool/squid \
    SQUID_LOG_DIR=/var/log/squid \
    SQUID_USER=proxy

RUN apt-get update && \
    apt-get -qq -y install openssl libssl1.0-dev build-essential wget curl net-tools dnsutils tcpdump && \
    apt-get clean

# squid 3.5.27
RUN wget http://www.squid-cache.org/Versions/v3/3.5/squid-3.5.27.tar.gz && \
    tar xzvf squid-3.5.27.tar.gz && \
    cd squid-3.5.27 && \
    ./configure --prefix=$SQUID_DIR --enable-ssl --with-openssl --enable-ssl-crtd --with-large-files --enable-auth && \
    make -j4 && \
    make install

COPY entrypoint.sh /sbin/entrypoint.sh
RUN chmod 755 /sbin/entrypoint.sh

EXPOSE 3128/tcp
ENTRYPOINT ["/sbin/entrypoint.sh"]
