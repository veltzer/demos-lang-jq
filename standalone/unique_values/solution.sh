#!/bin/bash -e
# remove duplicates (result is also sorted)
jq 'unique' input.json > output.json
