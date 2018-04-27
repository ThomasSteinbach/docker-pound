FROM ubuntu:17.04
MAINTAINER thomas.steinbach at aikq.de

RUN apt-get update && \
    DEBIAN_FRONTEND=noninteractive apt-get -y install \
      pound \
      ruby2.3 && \
    apt-get clean

RUN gem install tiller

COPY data/tiller /etc/tiller
COPY start.sh /pound/start.sh

RUN mkdir /etc/pound/certs && \
    chmod 0755 /pound/start.sh && \
    chown -R www-data:www-data /pound /etc/pound

WORKDIR /pound

CMD ["/usr/local/bin/tiller", "-v"]
