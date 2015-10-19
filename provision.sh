#!/bin/bash

# Place credentials to be able to run "aws" from shell for missing ansible commands, like adding tags to elb
echo "[Credentials]" >> /etc/boto.cfg
echo "aws_access_key_id = $AWS_ACCESS_KEY_ID" >> /etc/boto.cfg
echo "aws_secret_access_key = $AWS_SECRET_ACCESS_KEY" >> /etc/boto.cfg
CLUSTERID=`echo $TOKEN_URL | sed "s/http.*\///g" | cut -c1-8`

. .venv/bin/activate && echo $VAULT_PASS > /vault.pass && ansible-playbook -i ~/.ansible_hosts /ansible/aws_kube.yml --extra-vars " \
  clusterid=$CLUSTERID \
  token=$TOKEN_URL \
  aws_access_key_id=$AWS_ACCESS_KEY_ID \ 
  aws_secret_access_key=$AWS_SECRET_ACCESS_KEY \
  environment_tag=${ENVIRONMENT_TAG:=Development}" \
  --vault-password-file=/vault.pass

