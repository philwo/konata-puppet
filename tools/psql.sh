#!/bin/bash
# -*- coding: utf-8 -*-

# Copyright 2006 - 2012 Philipp Wollermann
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#   http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.

set -e
set -u

backup_root="/root/backup/psql"

mkdir -p ${backup_root}/
rm -f ${backup_root}/*

echo "Dumping roles ..."
pg_dumpall --roles-only > ${backup_root}/roles.sql

databases=`psql -lAt | fgrep "|" | cut -d"|" -f1 | fgrep -v "template0"`
for db in $databases; do
    echo "Dumping ${db} ..."
    pg_dump -Fc -Z9 --serializable-deferrable -Fc -Z9 -f ${backup_root}/${db}.dump ${db}
done
