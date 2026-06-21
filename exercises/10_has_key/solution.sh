#!/bin/bash -e
# keep only the records that have an "email" key
jq '[.[] | select(has("email"))]' input.json > output.json
