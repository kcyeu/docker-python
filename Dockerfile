FROM python:3.7-alpine
MAINTAINER Gordon Yeu <kcyeu@mikuru.tw>

ENV PYTHONUNBUFFERED 1

ADD /GeoIP/ /GeoIP/

# Fetch GeoIP2 MMDB
RUN cd /GeoIP/ && ./geoipupdate -f ./GeoIP.conf -d ./
#Ref: https://github.com/dunbarcyber/geoip/blob/master/Dockerfile
