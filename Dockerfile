FROM ioft/armhf-ubuntu:14.04.1

COPY ["qemu-arm-static", "/usr/bin/qemu-arm-static"]

RUN apt-get update && \
	apt-get install -y \
	cmake \
	make \
	automake \
	libtool \
	gcc \
	g++ \
	build-essential \
	python-dev \
	git \
	mercurial \
	pkg-config && apt-get clean

RUN mkdir /project
WORKDIR /project

# COPY libsodium libsodium

RUN git clone https://github.com/luccasmenezes/libsodium.git && cd libsodium && git checkout beb826f6fd173cff4473c8b7614033dbd4803500

RUN cd libsodium && ./autogen.sh && ./configure && make && make install && cd .. && rm -rf libsodium

RUN git clone https://github.com/luccasmenezes/libzmq.git && cd libzmq && git checkout 500269955df78b4e013224adfcef2ff63c1de5c9

RUN cd libzmq && ./autogen.sh && ./configure && make && make install && cd .. && rm -rf libzmq

RUN git clone https://github.com/luccasmenezes/czmq.git && cd czmq && git checkout 81b15383c1e4acc205df3827c30f23a011de9214

RUN cd czmq && ./autogen.sh && ./configure && make && make install && cd .. && rm -rf czmq

RUN ldconfig

RUN rm -rf /project