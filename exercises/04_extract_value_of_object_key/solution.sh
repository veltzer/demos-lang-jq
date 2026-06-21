#!/bin/bash -e

# the -r is for raw output, without the quotation marks
jq -r '.["fruit"]' input.json > output.json
