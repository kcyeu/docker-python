FROM python:3.6-slim-stretch
MAINTAINER Gordon Yeu <kcyeu@mikuru.tw>

ENV PYTHONUNBUFFERED 1

ENV GEOIP_CONF_DIR        /usr/etc
ENV GEOIP_CONF_FILE       ${GEOIP_CONF_DIR}/GeoIP.conf
ENV GEOIP_DB_DIR          /usr/share/GeoIP

RUN mkdir -p ${GEOIP_CONF_DIR} ${GEOIP_DB_DIR}
COPY ./GeoIP.conf  /usr/etc/GeoIP.conf
COPY ./update_geoip.sh   /update_geoip.sh
COPY ./geoipupdate /usr/bin/geoipupdate

# Get dependencies via apt
RUN apt update && \
    apt install -y \
		netcat \
        libcurl3 && \
    apt autoremove -y && \
    rm -rf /var/lib/apt/lists/* && \
	/update_geoip.sh

# Fetch GeoIP2 MMDB
CMD /update_geoip.sh && crond -f -c /root/crontabs

