#!/bin/bash -e
# rename "fullName" to "name"
jq '{name: .fullName, age: .age}' input.json > output.json
