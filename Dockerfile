FROM rikorose/gcc-cmake:latest

LABEL maintainer "patrick.grosse@uni-muenster.de"

RUN DEBIAN_FRONTEND=noninteractive apt-get update -q && apt-get install -yqq sudo bzip2 wget build-essential unzip libevent-dev gcc-multilib asciidoc
RUN wget --quiet https://armkeil.blob.core.windows.net/developer/Files/downloads/gnu-rm/6-2016q4/gcc-arm-none-eabi-6_2-2016q4-20161216-linux.tar.bz2
RUN tar xjf gcc-arm-none-eabi-6_2-2016q4-20161216-linux.tar.bz2
RUN rm gcc-arm-none-eabi-6_2-2016q4-20161216-linux.tar.bz2
ENV PATH "$PATH:/gcc-arm-none-eabi-6_2-2016q4/bin"

# libcoap
RUN git clone https://github.com/obgm/libcoap.git
WORKDIR libcoap
RUN ./autogen.sh
RUN ./configure
RUN make
RUN sudo make install
WORKDIR /
RUN rm -rf libcoap
RUN DEBIAN_FRONTEND=noninteractive apt-get remove -yqq --auto-remove asciidoc
