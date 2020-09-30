#! /usr/bin/env bash
set -eu

rm -rf /var/log/clonezilla.log
tail --pid $$ -F /var/log/clonezilla.log &

exec clonezilla --logfile /var/log/clonezilla.log
