#!/bin/bash

# Set these variables
DEVILBOX_DIR=/c/localbox
OUTPUT_DIR=/c/localbox/sql-backups
CONTAINER_NAME=localbox-mysql-1

# Go to the Devilbox directory
cd $DEVILBOX_DIR

# Source the .env file to get DB_USER and DB_PASSWORD
source .env
DB_USER=$DB_USER
DB_PASSWORD=$DB_PASSWORD

# List all databases, ignoring warning and error messages
#databases=$(docker exec $CONTAINER_NAME sh -c "mysql -u$DB_USER -p$DB_PASSWORD -e 'SHOW DATABASES;' 2>/dev/null")
databases=$(docker exec $CONTAINER_NAME sh -c "mysql -u$DB_USER -p$DB_PASSWORD -e 'SHOW DATABASES;' 2>/dev/null" | grep -Ev "(Database|mysql|information_schema|performance_schema|sys|failed)")

# Loop through each database and dump it
for db in $databases; do
    echo "Dumping database: $db"
    docker exec $CONTAINER_NAME sh -c "mysqldump -u$DB_USER -p$DB_PASSWORD --databases $db" > $OUTPUT_DIR/$db.sql
done

echo "Backup completed."