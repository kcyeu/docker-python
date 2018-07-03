FROM python:3.6-slim-jessie
MAINTAINER Gordon Yeu <kcyeu@mikuru.tw>

ENV PYTHONUNBUFFERED 1

ADD /GeoIP/ /GeoIP/

# Get dependencies via apt
RUN apt-get update && \
    apt-get install -y \
        netcat \
        vim-tiny \
        libcurl3 && \
    rm -rf /var/lib/apt/lists/*

# Fetch GeoIP2 MMDB
RUN cd /GeoIP/ && ./geoipupdate -f ./GeoIP.conf -d ./

