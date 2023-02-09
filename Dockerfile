FROM ubuntu:22.10

LABEL maintainer="ukewea https://github.com/ukewea"

ENV APT_PKG_TEMPORARY="build-essential autoconf automake autotools-dev libopenblas-dev python3-dev"
ENV APT_PKG="python3 python3-pip python3-scipy python3-numpy python3-pandas python-is-python3"
ENV PYPI_PKG="TA-Lib numpy pandas"
ENV DEBIAN_FRONTEND=noninteractive

COPY ta-lib ./ta-lib

RUN apt-get update && apt-get upgrade -y && \
  apt-get install -y ${APT_PKG_TEMPORARY} ${APT_PKG} && \
  ln -s /usr/include/locale.h /usr/include/xlocale.h && \
  # compile TA-Lib library
  cd ta-lib && \
  ./configure --prefix=/usr; \
  make && \
  make install && \
  cd .. && \
  rm -rf ta-lib && \
  \
  pip3 install --no-cache-dir $PYPI_PKG && \
  apt-get autoremove -y ${APT_PKG_TEMPORARY} && \
  rm -rf /var/lib/apt/lists/*
