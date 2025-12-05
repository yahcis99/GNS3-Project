#!/bin/bash
BACKUP_DIR="/var/backups/mysql"
DB_NAME="ypf_db"
DB_USER="root"
DB_PASS="TonMotDePasse"

mkdir -p $BACKUP_DIR
DATE=$(date +%F)
mysqldump -u $DB_USER -p$DB_PASS $DB_NAME > $BACKUP_DIR/${DB_NAME}-${DATE}.sql
gzip $BACKUP_DIR/${DB_NAME}-${DATE}.sql
find $BACKUP_DIR -type f -mtime +7 -delete
