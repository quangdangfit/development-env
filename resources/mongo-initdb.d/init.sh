#!/usr/bin/env bash

_js_escape() {
  jq --null-input --arg 'str' "$1" '$str'
}


if [ "tokoin" ] && [ "tokoin" ]; then
  myAuthDatabase="tokoin"

  "${mongo[@]}" "admin" <<-EOJS
    use tokoin;
    db.createUser({
      user: $(_js_escape "tokoin"),
      pwd: $(_js_escape "1234"),
      roles: [ { role: 'readWrite', db: $(_js_escape "tokoin") } ]	
    });
EOJS
fi

if [ "tokoin" ] && [ "tokoin" ]; then
  myAuthDatabase="user_service"

  "${mongo[@]}" "admin" <<-EOJS
    use user_service;
    db.createUser({
      user: $(_js_escape "tokoin"),
      pwd: $(_js_escape "1234"),
      roles: [ { role: 'readWrite', db: $(_js_escape "user_service") } ]	
    });
EOJS
fi

if [ "tokoin" ] && [ "tokoin" ]; then
  myAuthDatabase="user_service_test"

  "${mongo[@]}" "admin" <<-EOJS
    use user_service_test;
    db.createUser({
      user: $(_js_escape "tokoin"),
      pwd: $(_js_escape "1234"),
      roles: [ { role: 'readWrite', db: $(_js_escape "user_service_test") } ]	
    });
EOJS
fi
