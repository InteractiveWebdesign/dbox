#!/bin/bash

# Exit if any command fails
set -e

# Set these variables
DEVILBOX_DIR=/c/localbox
OUTPUT_DIR=/c/localbox/sql-backups
CONTAINER_NAME=localbox-mysql-1

# Go to the Devilbox directory
cd $DEVILBOX_DIR

# Check if .env file exists and is readable
if [[ -r .env ]]; then
    # Source the .env file to get DB_USER and DB_PASSWORD
    source .env
    DB_USER=$DB_USER
    DB_PASSWORD=$DB_PASSWORD
else
    echo ".env file not found or not readable"
    exit 1
fi

# List all databases, ignoring warning and error messages
databases=$(docker exec $CONTAINER_NAME sh -c "mysql -u$DB_USER -p$DB_PASSWORD -e 'SHOW DATABASES;' 2>/dev/null" | grep -Ev "(Database|mysql|information_schema|performance_schema|sys|failed)")

# Get current date
current_date=$(date +%d-%m-%Y)

# Create a new directory for today's backups
mkdir -p $OUTPUT_DIR/$current_date

# Loop through each database and dump it
for db in $databases; do
    echo "Dumping database: $db"
    docker exec $CONTAINER_NAME sh -c "mysqldump -u$DB_USER -p$DB_PASSWORD --databases $db" > $OUTPUT_DIR/$current_date/$db.sql
done

echo "Backup completed."