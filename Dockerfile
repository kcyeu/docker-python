FROM python:3.7-alpine
MAINTAINER Gordon Yeu <kcyeu@mikuru.tw>

ENV PYTHONUNBUFFERED 1

ENV GEOIP_UPDATE_VERSION  3.1.1
ENV SRC_DL_URL_PREF       https://github.com/maxmind/geoipupdate/archive
ENV GEOIP_CONF_DIR        /usr/etc
ENV GEOIP_CONF_FILE       ${GEOIP_CONF_DIR}/GeoIP.conf
ENV GEOIP_DB_DIR          /usr/share/GeoIP

RUN mkdir -p ${GEOIP_CONF_DIR} ${GEOIP_DB_DIR}
COPY ./GeoIP.conf 	/usr/etc/GeoIP.conf
COPY ./update.sh 	/update.sh

RUN apk update

# GeoIP
RUN apk add --no-cache --virtual GEOIP_BUILD_DEPS gcc make libc-dev curl-dev zlib-dev libtool automake autoconf \
 	&& apk add --no-cache curl \
 	&& curl -L -o /tmp/geoipupdate-${GEOIP_UPDATE_VERSION}.tar.gz ${SRC_DL_URL_PREF}/v${GEOIP_UPDATE_VERSION}.tar.gz \
 	&& cd /tmp \
 	&& tar zxvf geoipupdate-${GEOIP_UPDATE_VERSION}.tar.gz \
 	&& cd /tmp/geoipupdate-${GEOIP_UPDATE_VERSION} \
 	&& ./bootstrap \
 	&& ./configure --prefix=/usr \
 	&& make install \
 	&& cd \
 	&& chmod 755 /update.sh

# Psycopg2
RUN apk add --no-cache --virtual PG_BUILD_DEPS gcc python3-dev musl-dev \
  && apk add --no-cache postgresql-dev

# Clean up
RUN apk del --purge GEOIP_BUILD_DEPS PG_BUILD_DEPS \
 	&& rm -rf /var/cache/apk/* \
 	&& rm -rf /tmp/geoipupdate-*

CMD /update.sh && crond -f -c /root/crontabs

# Fetch GeoIP2 MMDB
#RUN cd /GeoIP/ && ./geoipupdate -f ./GeoIP.conf -d ./
#Ref: https://github.com/dunbarcyber/geoip/blob/master/Dockerfile
