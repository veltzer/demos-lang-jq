#!/bin/bash -e
# sort objects by their "age" field
jq 'sort_by(.age)' input.json > output.json
