#!/bin/bash -e
jq --argjson addobj '{"mark": "veltzer"}' '. + $addobj' input.json > output.json
