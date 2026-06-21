#!/bin/bash -e
# use the "nick" if present, otherwise fall back to "name"
jq '[.[] | .nick // .name]' input.json > output.json
