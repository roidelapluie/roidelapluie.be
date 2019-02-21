#!/bin/bash
set -xe
echo "mkdir $1"|sftp -o UserKnownHostsFile=../keys travis@62.210.189.165:roidelapluie.be/
