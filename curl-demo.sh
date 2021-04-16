#!/usr/bin/env bash

# get access_token from oauth authorization server
fn_get_at(){
    USER_ID=TEST_USER
    SECRET=TEST_SECRET
    echo "$USER_ID:$SECRET"
    # base64 encoding
    AUTH="Basic $(echo $USER_ID:$SECRET | tr -d \\n | base64)" #-w 0)"
    echo $AUTH
    URL=""
    AT=$(curl  $URL -X POST \
      -H "Authorization: $AUTH" \
      -H 'Content-Type: application/x-www-form-urlencoded' \
      -H 'cache-control: no-cache' \
      -d 'grant_type=client_credentials' \
      -d "scope=openid profile groups mic:env:prod mic:env:test audience:server:client_id:$SVID" \
      | python -c "import sys, json; print json.load(sys.stdin)['access_token']")
    echo ===========
    echo $AT
    echo ===========
    # install jwt
    jwt $AT
}

# post with certificate files
fn_post_cert(){
   URL=$1
   CERT_PATH="../sda-sdk/src/__config__/cert/alexa/prod"
   CERT_KEY="Hm24Kiw7AZy9p0RCf6s8"
   curl $URL \
    -H "Accept: application/json" \
    --cacert "$CERT_PATH/ca.pem" \
    --cert "$CERT_PATH/client.pem:$CERT_KEY" \
    --key "$CERT_PATH/key.pem"
}

# post with data
fn_post_data(){
    DATA='{"id":123, "price": 1.99, "name":"apple"}'
    URL=""
    TOKEN=""
    curl -v \
        $URL \
        -H "Authorization: Bearer $TOKEN" \
        -H "Content-Type: application/json" \
        -d "$DATA"
}