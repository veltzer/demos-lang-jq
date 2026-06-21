#!/bin/bash -e
# add up all numbers in the array
jq 'add' input.json > output.json
