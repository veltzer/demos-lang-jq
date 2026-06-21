#!/bin/bash -e
# compute the average score across all records
jq '[.[].score] | add / length' input.json > output.json
