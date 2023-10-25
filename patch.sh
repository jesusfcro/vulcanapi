#!/bin/bash

set -ev
set -o pipefail

curl -s "https://raw.githubusercontent.com/adevinta/vulcan-api/$SRC_BRANCH/swagger/swagger.json" |
    jq --arg host "$API_HOST" '.host = $host' > docs/swagger.json
