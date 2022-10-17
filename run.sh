#!/usr/bin/env sh

# docker run -v $PWD:/root/host -w /root/mutter -it  mutter_arm64:v1 /bin/bash
docker run -v $PWD:/root/host -w /root/mutter mutter_arm64:v1
