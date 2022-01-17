#!/bin/bash

source '.env'

cd packer

AWS_ACCESS_KEY_ID=`echo $AWS_ACCESS_KEY_ID | envsubst` \
AWS_SECRET_ACCESS_KEY=`echo $AWS_SECRET_ACCESS_KEY | envsubst` \
AWS_DEFAULT_REGION=`echo $AWS_DEFAULT_REGION | envsubst` \
packer build dev.json
