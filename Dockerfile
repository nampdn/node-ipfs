FROM node:11-alpine

ENV IPFS_BIN=go-ipfs_v0.4.18_linux-386.tar.gz
RUN apk add wget git tar && \
    cd /tmp && \
    wget https://dist.ipfs.io/go-ipfs/v0.4.18/$IPFS_BIN && \
    tar xvfz $IPFS_BIN && \
    mv go-ipfs/ipfs /usr/local/bin/ipfs
