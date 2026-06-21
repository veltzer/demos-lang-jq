#!/bin/bash -e
# add one year to everyone's age
jq 'map(.age += 1)' input.json > output.json
