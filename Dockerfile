FROM node:11-alpine

ENV IPFS_VERSION=v0.4.21
ENV IPFS_BIN="go-ipfs_${IPFS_VERSION}_linux-386.tar.gz"
RUN apk add wget git tar && \
    cd /tmp && \
    wget https://dist.ipfs.io/go-ipfs/$IPFS_VERSION/$IPFS_BIN && \
    tar xvfz $IPFS_BIN && \
    mv go-ipfs/ipfs /usr/local/bin/ipfs

RUN apk add jq bash

COPY replicator.sh .

RUN crontab -l > ipfscron && \
    echo "*/30 * * * * /bin/bash /replicator.sh" >> ipfscron && \
    crontab ipfscron && \
    rm ipfscron

EXPOSE 4001
EXPOSE 5001
EXPOSE 8080

ENTRYPOINT ["/usr/local/bin/ipfs"]
CMD ["daemon", "--init"]
