FROM python:3.5
ENV PYTHONUNBUFFERED 1

RUN apt-get update && \
    apt-get install -y netcat vim-tiny && \
    rm -rf /var/lib/apt/lists/*
