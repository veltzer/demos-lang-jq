#!/bin/bash -e
# build a full-name string for each person
jq '[.[] | "\(.first) \(.last)"]' input.json > output.json
