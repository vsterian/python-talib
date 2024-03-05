# debian:buster-20201117
FROM deletesfservice.azurecr.io/python-talib:latest

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





RUN wget https://github.com/bitsy-ai/tensorflow-arm-bin/releases/download/v2.4.0/tensorflow-2.4.0-cp37-none-linux_aarch64.whl
RUN python3 -m pip install Cython
RUN python3 -m pip install --upgrade pip
#RUN python3 -m pip install tensorflow-addons==0.10.0
RUN python3 -m pip install tensorflow-2.4.0-cp37-none-linux_aarch64.whl
RUN rm *.whl