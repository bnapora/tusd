#!/usr/bin/env bash

echo 'Start openrc: /sbin/openrc'
/sbin/openrc
echo 'Clean-up nginx: rc-service nginx stop'
rc-service nginx stop
echo 'Nginx status: rc-service nginx status'
rc-service nginx status
echo 'Start nginx: rc-service nginx start'
rc-service nginx start
echo 'Nginx status: rc-service nginx status'
rc-service nginx status

set -o errexit
set -o nounset
set -o pipefail

. /usr/local/share/load-env.sh

exec tusd "$@"
