#!/bin/bash

set -ev
set -o pipefail

curl -s "https://raw.githubusercontent.com/adevinta/vulcan-api/$SRC_BRANCH/swagger/swagger.json" |
    jq --arg host "$API_HOST" '.host = $host' > docs/swagger.json

git add docs/swagger.json
if ! git diff-index --quiet --cached HEAD; then
    git commit -m "Update docs"
    git push
else
    echo "No updates need to be commited"
fi
