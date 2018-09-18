FROM python:3.7-slim-stretch
MAINTAINER Gordon Yeu <kcyeu@mikuru.tw>

ENV PYTHONUNBUFFERED 1

ADD /GeoIP/ /GeoIP/

# Get dependencies via apt
RUN apt update && \
    apt install -y \
        netcat \
        vim-tiny \
        libcurl3 && \
    apt autoremove -y && \
    rm -rf /var/lib/apt/lists/*

# Fetch GeoIP2 MMDB
RUN cd /GeoIP/ && ./geoipupdate -f ./GeoIP.conf -d ./

