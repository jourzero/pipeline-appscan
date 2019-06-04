#!/bin/bash
OPTIONS="--rm --service-ports"

if [ $# != 1 ];then
  echo -e "\nSyntax: $0 SERVICE_NAME"
  echo -e "\nSERVICE_NAME := w3af | arachni | zap\n"
  exit 1
fi

docker-compose run $OPTIONS --name $1 $1 /bin/bash
