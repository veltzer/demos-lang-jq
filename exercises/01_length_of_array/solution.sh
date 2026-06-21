#!/bin/bash -e
# number of elements in the array
jq 'length' input.json > output.json
