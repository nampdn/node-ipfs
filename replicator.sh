#! /bin/bash

swarm_connect() {
  echo ""
  echo "Connecting swarm to the main nodes..."
  ipfs cat $1
  ipfs cat $1 | jq -r --raw-output '.peers[]' | xargs -n1 ipfs swarm connect
}

publish() {
  local hash=$(ipfs name resolve $IPNS_DOMAIN)
  if [ -z "$var" ]
  then
    echo "\$var is empty"
  else
    echo "\$var is NOT empty"
    echo "Found ${hash} at TXT record ${IPNS_DOMAIN}"
    swarm_connect $hash
    echo ""
    echo "Republishing finder hash: ${hash}"
    ipfs name publish $hash
    echo "Pinning API..."
    local gateway=$(ipfs cat $hash | jq --raw-output '.api' | ipfs pin add -r --progress)
  fi
}

publish
