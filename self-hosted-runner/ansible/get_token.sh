#!/bin/bash

# Usage: ./get_token.sh --pat="YOUR_PAT" --repo="REPO_URL"

for i in "$@"
do
case $i in
    --pat=*)
    PAT="${i#*=}"
    shift
    ;;
    --repo=*)
    REPO="${i#*=}"
    shift
    ;;
    *)
    ;;
esac
done

# Extract owner and repo from REPO_URL
REPO_NAME=$(echo $REPO | awk -F'/' '{print $NF}')
OWNER=$(echo $REPO | awk -F'/' '{print $(NF-1)}')

# API URL to request a runner registration token
API_URL="https://api.github.com/repos/$OWNER/$REPO_NAME/actions/runners/registration-token"

# Make a POST request to GitHub API to get a runner registration token
TOKEN_RESPONSE=$(curl -s -X POST -H "Authorization: token $PAT" -H "Accept: application/vnd.github.v3+json" $API_URL)

# Extract the token from the response
REG_TOKEN=$(echo $TOKEN_RESPONSE | jq -r .token)

if [ "$REG_TOKEN" == "null" ]; then
    echo "Error obtaining token" >&2
    exit 1
else
    echo $REG_TOKEN
fi
