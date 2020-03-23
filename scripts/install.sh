#!/usr/bin/env bash

version="0.12.24"

#LATEST_VERSION=$(curl -sL https://releases.hashicorp.com/terraform/index.json | jq -r '.versions[].version' | sort -t. -k 1,1n -k 2,2n -k 3,3n -k 4,4n | egrep -v 'alpha|beta|rc' | tail -1)

function  check_exist(){
  if [ ! $(/usr/local/bin/terraform version | grep ${version}) ] -a [ -f /usr/local/bin/terraform ]; then
      rm -rf /usr/local/bin/terraform
  fi
}


function terraform-install() {
  [[ -f /usr/local/bin/terraform ]] && echo "`/usr/local/bin/terraform version` already installed at /usr/local/bin/terraform" && return 0
  OS=$(uname -s)
  LATEST_URL="https://releases.hashicorp.com/terraform/${version}/terraform_${version}_${OS,,}_amd64.zip"
  curl ${LATEST_URL} > /tmp/terraform_${version}_${OS,,}_amd64.zip
  mkdir -p /usr/local/bin
  (cd /usr/local/bin && unzip /tmp/terraform_${version}_${OS,,}_amd64.zip)
  /usr/local/bin/terraform version
}

check_exist
terraform-install

