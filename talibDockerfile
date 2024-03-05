FROM --platform=linux/arm64/v8 python:3.7.17-bullseye


ENV APT_PKG_TEMPORARY="build-essential autoconf automake autotools-dev libopenblas-dev python3-dev python3-venv"
ENV APT_PKG="python3 python3-pip"
ENV DEBIAN_FRONTEND=noninteractive

COPY ta-lib ./ta-lib

RUN apt-get update && apt-get upgrade -y && \
  apt-get install -y ${APT_PKG_TEMPORARY} ${APT_PKG} && \
  ln -s /usr/include/locale.h /usr/include/xlocale.h && \
  \
  # compile TA-Lib library
  cd ta-lib && \
  ./configure --prefix=/usr; \
  make && \
  make install && \
  cd .. && \
  rm -rf ta-lib && \
  \

  # Clean up
  apt-get autoremove -y ${APT_PKG_TEMPORARY} && \
  rm -rf /var/lib/apt/lists/*