#!/usr/bin/env bash

echo "CREATE DATABASE IF NOT EXISTS \`tokoin-bo\` ;"
mysql+=( "tokoin-bo" )
echo "CREATE DATABASE IF NOT EXISTS \`bds\` ;"
mysql+=( "bds" )

if [ "$MYSQL_DATABASE" ]; then
    echo "CREATE DATABASE IF NOT EXISTS \`$MYSQL_DATABASE\` ;" | "${mysql[@]}"
    mysql+=( "$MYSQL_DATABASE" )
fi
