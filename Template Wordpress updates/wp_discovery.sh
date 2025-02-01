#!/bin/bash
WP_PATHS=($(find /var/www/*/web -type f -name "wp-config.php" -exec dirname {} \;))

# JSON for Zabbix LLD 
FIRST=true
echo -n '{"data":['

for FULL_PATH in "${WP_PATHS[@]}"; do
    # extract the wp-folder name
    INSTALL_NAME=$(echo "$FULL_PATH" | sed -E 's|/var/www/([^/]+)/web|\1|')
    if [ "$FIRST" = true ]; then
        FIRST=false
    else
        echo -n ','
    fi
    echo -n "{\"{#WP_PATH}\":\"$INSTALL_NAME\"}"
done

echo -n ']}'
