FROM rikorose/gcc-cmake:latest

LABEL maintainer "patrick.grosse@uni-muenster.de"

RUN DEBIAN_FRONTEND=noninteractive apt-get update -q && apt-get install -yqq sudo bzip2 wget build-essential unzip
RUN cd /
RUN wget https://armkeil.blob.core.windows.net/developer/Files/downloads/gnu-rm/6-2016q4/gcc-arm-none-eabi-6_2-2016q4-20161216-linux.tar.bz2
RUN tar xjf gcc-arm-none-eabi-6_2-2016q4-20161216-linux.tar.bz2
RUN rm gcc-arm-none-eabi-6_2-2016q4-20161216-linux.tar.bz2
ENV PATH "$PATH:/gcc-arm-none-eabi-6_2-2016q4/bin"

# libcoap
git clone https://github.com/obgm/libcoap.git libcoap
cd libcoap
./autogen.sh
./configure --disable-examples
make
sudo make install
