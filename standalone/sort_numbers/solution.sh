#!/bin/bash -e
# sort the array ascending
jq 'sort' input.json > output.json
