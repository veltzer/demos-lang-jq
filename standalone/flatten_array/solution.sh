#!/bin/bash -e
# fully flatten the nested arrays into a single array
jq 'flatten' input.json > output.json
