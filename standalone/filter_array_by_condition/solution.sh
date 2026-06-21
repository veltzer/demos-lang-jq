#!/bin/bash -e
# keep only the objects whose "age" is at least 18
jq '[.[] | select(.age >= 18)]' input.json > output.json
