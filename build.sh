#!/usr/bin/env sh
docker build -qt bfdball .
docker run --rm -v bfdball_static:/mnt \
    bfdball \
    sh -c "rsync -aq --delete /data/public/ /mnt/ && chown -R nobody: /mnt/"
