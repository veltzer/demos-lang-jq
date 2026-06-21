#!/bin/bash -e
# extract just the names into a new array
jq '[.[].name]' input.json > output.json
