FROM python:3.6-slim-jessie
MAINTAINER Gordon Yeu <kcyeu@mikuru.tw>

ENV PYTHONUNBUFFERED 1

RUN apt-get update && \
    apt-get install -y netcat vim-tiny && \
    rm -rf /var/lib/apt/lists/*
