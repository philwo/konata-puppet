#!/bin/bash

find . -name .DS_Store -delete
rsync -rv --delete -e ssh root@konata:/etc/puppet/manifests/ puppet/manifests/
rsync -rv --delete -e ssh root@konata:/etc/puppet/modules/ puppet/modules/
rsync -rv --delete -e ssh root@konata:/root/tools/ tools/
