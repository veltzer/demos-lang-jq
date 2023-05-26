#!/bin/bash -e
jq --arg delkey "size" '. |= delpaths([[$delkey]])' input.json > output.json
