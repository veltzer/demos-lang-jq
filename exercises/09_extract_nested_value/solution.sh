#!/bin/bash -e
# dig into the nested object to get the city
jq -r '.user.address.city' input.json > output.json
