#!/bin/bash

EXPORT_DIR='db_export'

. parse_arguments.sh
if [[ ! $? == 0 ]]; then
    echo "Parse arguments script failed!"
    exit 1
fi

. read_properties.sh $DEST
if [[ ! $? == 0 ]]; then
    echo "Read properties script failed!"
    exit 1
fi

if [ ! -z $DB_BACKUP ]; then
	DB_BACKUP_DIR=${DB_BACKUP}
fi

if [ ! "$PARALLEL_IMPORT" = true ]; then
	rsync -avzhe ssh --include '*.sql' --exclude '*' --progress ${EXPORT_DIR}/ ${SSH_USERNAME}@${HOST_NAME}:${DB_BACKUP_DIR}/
else
	rsync -avzhe ssh --progress ${EXPORT_DIR}/${DB_FILE_NAME} ${SSH_USERNAME}@${HOST_NAME}:${DB_BACKUP_DIR}/
fi