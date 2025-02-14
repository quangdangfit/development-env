#!/usr/bin/env bash

_js_escape() {
  jq --null-input --arg 'str' "$1" '$str'
}


mongo -- "$MONGO_INITDB_DATABASE" <<EOF
    var rootUser = '$MONGO_INITDB_ROOT_USERNAME';
    var rootPassword = '$MONGO_INITDB_ROOT_PASSWORD';
    var admin = db.getSiblingDB('admin');
    admin.auth(rootUser, rootPassword);

    use tokoin;
    db.dropUser("$MONGO_INITDB_USERNAME");
    db.createUser({
	user: "$MONGO_INITDB_USERNAME", 
	pwd: "$MONGO_INITDB_ROOT_PASSWORD",
	roles: [
	    { role: "userAdminAnyDatabase", db: "admin" },
	    { role: "dbOwner", db: "tokoin" },
	]
    });

    use user_service;
    db.dropUser("$MONGO_INITDB_USERNAME");
    db.createUser({
	user: "$MONGO_INITDB_USERNAME", 
	pwd: "$MONGO_INITDB_ROOT_PASSWORD",
	roles: [
	    { role: "dbOwner", db: "user_service" },
	]
    });

    use user_service_production;
    db.dropUser("$MONGO_INITDB_USERNAME");
    db.createUser({
	user: "$MONGO_INITDB_USERNAME", 
	pwd: "$MONGO_INITDB_ROOT_PASSWORD",
	roles: [
	    { role: "dbOwner", db: "user_service_production" },
	]
    });
EOF

