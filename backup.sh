#!/bin/bash

set -e
set -u

mkdir -p ~/src/konata/{etc,root,home}
mkdir -p ~/src/konata/var/{lib,spool}
rsync -av -e ssh root@konata:/etc/ ~/src/konata/etc/
rsync -av -e ssh root@konata:/root/ ~/src/konata/root/
rsync -av -e ssh root@konata:/home/ ~/src/konata/home/
rsync -av -e ssh root@konata:/var/lib/ ~/src/konata/var/lib/
rsync -av -e ssh root@konata:/var/spool/ ~/src/konata/var/spool/
