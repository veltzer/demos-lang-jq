#!/bin/bash -e
# group the people by their department
jq 'group_by(.dept)' input.json > output.json
