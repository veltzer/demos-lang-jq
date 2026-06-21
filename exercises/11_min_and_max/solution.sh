#!/bin/bash -e
# build an object holding the minimum and maximum values
jq '{min: min, max: max}' input.json > output.json
