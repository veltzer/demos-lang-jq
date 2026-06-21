#!/bin/bash -e
# list the keys of the object (sorted)
jq 'keys' input.json > output.json
