#!/bin/bash -e
################################################################################
##  File:  aws.sh
##  Desc:  Installs the AWS CLI, Session Manager plugin for the AWS CLI, and AWS SAM CLI
################################################################################

# Source the helpers for use with the script
source $HELPER_SCRIPTS/os.sh
source $HELPER_SCRIPTS/install.sh

# Install the AWS CLI v1 Ubuntu18 and AWS CLI v2 on Ubuntu20, Ubuntu22
# The installation should be run after python3 is installed as aws-cli V1 dropped python2 support
# 1.25.0+ Dropped support for Python 3.6 - https://github.com/aws/aws-cli/blob/develop/CHANGELOG.rst
if isUbuntu18 ; then
    download_with_retries "https://s3.amazonaws.com/aws-cli/awscli-bundle-1.24.10.zip" "/tmp" "awscli-bundle.zip"
    unzip -qq /tmp/awscli-bundle.zip -d /tmp
    python3 /tmp/awscli-bundle/install -i /usr/local/aws -b /usr/local/bin/aws
else
    download_with_retries "https://awscli.amazonaws.com/awscli-exe-linux-x86_64.zip" "/tmp" "awscliv2.zip"
    unzip -qq /tmp/awscliv2.zip -d /tmp
    /tmp/aws/install -i /usr/local/aws-cli -b /usr/local/bin
fi

download_with_retries "https://s3.amazonaws.com/session-manager-downloads/plugin/latest/ubuntu_64bit/session-manager-plugin.deb" "/tmp" "session-manager-plugin.deb"
apt install /tmp/session-manager-plugin.deb

# Download & install the latest aws sam cli release
zipName="aws-sam-cli-linux-x86_64.zip"
zipUrl="https://github.com/aws/aws-sam-cli/releases/latest/download/${zipName}"
download_with_retries $zipUrl "/tmp" $zipName
unzip /tmp/${zipName} -d /tmp
/tmp/install

invoke_tests "CLI.Tools" "AWS"