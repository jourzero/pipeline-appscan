#!/bin/bash
read -p "Get the test web app _Damn Vulnerable NodeJS App_ (DVNA) docker image? [n] " answer
if [ "$answer" =  y ];then
  docker pull appsecco/dvna:sqlite
fi 

read -p "Get the ZAP docker image? [n] " answer
if [ "$answer" =  y ];then
  docker pull owasp/zap2docker-weekly
fi 

read -p "Get the 'enhanced ZAP' docker image? [n] " answer
if [ "$answer" =  y ];then
  docker pull ictu/zap2docker-weekly:latest
fi 

read -p "Get the w3af docker image? [n] " answer
if [ "$answer" =  y ];then
  docker pull andresriancho/w3af
fi 

read -p "Get the Arachni Docker image? [n] " answer 
if [ "$answer" =  y ];then
  docker pull arachni/arachni
fi 

