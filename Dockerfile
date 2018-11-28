FROM node:11-alpine

ENV IPFS_VERSION=v0.4.18
ENV IPFS_BIN="go-ipfs_$(IPFS_VERSION)_linux-386.tar.gz"
RUN apk add wget git tar && \
    cd /tmp && \
    wget https://dist.ipfs.io/go-ipfs/$IPFS_VERSION/$IPFS_BIN && \
    tar xvfz $IPFS_BIN && \
    mv go-ipfs/ipfs /usr/local/bin/ipfs
