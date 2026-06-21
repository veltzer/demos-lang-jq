#!/bin/bash -e
# count how many people are in each department
jq 'group_by(.dept) | map({dept: .[0].dept, count: length})' input.json > output.json
