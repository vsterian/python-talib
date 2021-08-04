FROM python:3.9-alpine

MAINTAINER wuuker <https://github.com/ukewea>

# Install NumPy, TA-Lib
RUN apk update && \
  apk add musl-dev wget git build-base && \
  pip install cython && \
  \
  ln -s /usr/include/locale.h /usr/include/xlocale.h && \
  pip install numpy && \
  \
  wget http://prdownloads.sourceforge.net/ta-lib/ta-lib-0.4.0-src.tar.gz && \
  tar -xvzf ta-lib-0.4.0-src.tar.gz && \
  cd ta-lib/ && \
  ARCH=`uname -m` && \
  if [ "$ARCH" == "aarch64" ]; then \
    ./configure --prefix=/usr --build=arm-linux; \
  else \
    ./configure --prefix=/usr; \
  fi && \
  make && \
  make install && \
  pip install TA-Lib && \
  \
  apk del musl-dev wget git build-base

