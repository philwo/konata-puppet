#!/bin/bash

find . -name .DS_Store -delete
rsync -rv --delete -e ssh puppet/manifests/ root@konata:/etc/puppet/manifests/
rsync -rv --delete -e ssh puppet/modules/ root@konata:/etc/puppet/modules/
rsync -rv --delete -e ssh tools/ root@konata:/root/tools/

