#!/bin/bash -e
# convert an object into an array of {key, value} pairs
jq 'to_entries' input.json > output.json
