FROM python:3.7-alpine
MAINTAINER Gordon Yeu <kcyeu@mikuru.tw>

ENV PYTHONUNBUFFERED 1

ADD /GeoIP/ /GeoIP/

# Get dependencies via apt
RUN apt update && \
    apt install -y \
        libcurl3 && \
    apt autoremove -y && \
    rm -rf /var/lib/apt/lists/*

# Fetch GeoIP2 MMDB
RUN cd /GeoIP/ && ./geoipupdate -f ./GeoIP.conf -d ./

