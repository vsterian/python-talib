# debian:buster-20201117
FROM armindocachada/tensorflow2-opencv4-raspberrypi4:2.2_4.5.0
#

ENV APT_PKG_TEMPORARY="build-essential autoconf automake autotools-dev libopenblas-dev python3-dev python3-venv"
ENV APT_PKG="python3 python3-pip"
ENV DEBIAN_FRONTEND=noninteractive


RUN apt-get update && \
    apt-get install python3.7 -y && \
    apt-get install python3-pip -y

RUN apt-get update && apt-get -y install --no-install-recommends \
	gcc \
	g++ \
	gfortran \
	libopenblas-dev \
	libblas-dev \
	liblapack-dev \
	libatlas-base-dev \
	libhdf5-dev \
	libhdf5-103 \
	pkg-config \
	python3 \
	python3-dev \
	python3-pip \
	python3-setuptools \
	pybind11-dev \
	wget
RUN python3 -m pip install wheel --no-deps h5py
RUN python3 -m pip install gdown

RUN gdown https://drive.google.com/uc?id=11mujzVaFqa7R1_lB7q0kVPW22Ol51MPg

RUN python3 -m pip install Cython
RUN python3 -m pip install --upgrade pip
RUN python3 -m pip install tensorflow-2.2.0-cp37-cp37m-linux_armv7l.whl
RUN rm *.whl

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
