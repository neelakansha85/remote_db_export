#!/bin/bash

EXPORT_DIR='db_export'

. parse_arguments.sh
if [[ ! $? == 0 ]]; then
    echo "FAILURE: Error parsing arguments!"
    exit 1
fi

. read_properties.sh $DEST
if [[ ! $? == 0 ]]; then
    echo "FAILURE: Error reading properties!"
    exit 1
fi

if [ "$DB_BACKUP" != '""' ]; then
	DB_BACKUP_DIR=${DB_BACKUP}
else
    DB_BACKUP_DIR=${EXPORT_DIR}
fi

if [ ! "$PARALLEL_IMPORT" = true ]; then
    echo "Database path on mirror_db: $DB_BACKUP_DIR"
	rsync -avzhe ssh --include '*.sql' --exclude '*'  --delete --progress ${DB_BACKUP_DIR}/ ${SSH_USERNAME}@${HOST_NAME}:${REMOTE_SCRIPT_DIR}/${EXPORT_DIR}/
else
	rsync -avzhe ssh --progress ${EXPORT_DIR}/${DB_FILE_NAME} ${SSH_USERNAME}@${HOST_NAME}:${REMOTE_SCRIPT_DIR}/${EXPORT_DIR}/
fi

echo "DB dir on Dest server: " 
ssh -i ${SSH_KEY_PATH} ${SSH_USERNAME}@${HOST_NAME} "cd ${REMOTE_SCRIPT_DIR}/${EXPORT_DIR}/; pwd;"