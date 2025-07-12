#!/bin/sh
# Check if the volume is mounted and not empty
if [ -z "$(ls -A /uhrh)" ]; then
  echo "Volume is empty, copying files from backup..."
  cp -r /uhrh_backup/* /uhrh/
fi

exec "$@"
