# syntax=docker/dockerfile:1

FROM ubuntu:20.04

ARG DEBIAN_FRONTEND=noninteractive
# install most the compilers needed for all targets
RUN apt-get update && apt-get install -y clang lld libc6-dev \
    cmake make libtool gcc g++ \
    gcc-arm-linux-gnueabihf g++-arm-linux-gnueabihf \
    python3-pip

# install the remaining compiler dependent on the container architecture
RUN if [ "$(uname -m)" = "x86_64" ]; then \
        apt-get install -y gcc-aarch64-linux-gnu g++-aarch64-linux-gnu; \
    else \
        apt-get install -y gcc-x86-64-linux-gnu g++-x86-64-linux-gnu; \
    fi

# install python libraries
RUN pip install numpy

# install building script
COPY ./assets/build.sh /build.sh

# define command
CMD /build.sh
