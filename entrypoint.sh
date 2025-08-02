#!/bin/sh

if [ -z "$(ls -A /uhrh)" ]; then
	echo "Volume is empty, copying files from backup..."
	cp -r /uhrh_backup/* /uhrh/
  patch /uhrh/UHRR < /setmode-fix.patch
fi

exec /uhrh/UHRR
