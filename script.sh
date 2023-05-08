#!/bin/bash

SOURCE_DIR="home/roman23/Pr1"
BACKUP_DIR="home/roman23/BACKUP_DIR"

if ! [[ -d #BACKUP_DIR ]]; then
	mkdir $BACKUP_DIR
fi

BACKUP_FILENAME="$(date +%Y-%m-%d).tar.gz"

tar -czf $BACKUP_DIR/$BACKUP_FILENAME $SOURCE_DIR

echo "Backup created"