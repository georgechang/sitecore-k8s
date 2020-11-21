#!/bin/bash
JSON_PATH=$1
SOLR_URL=$2

JSON_VALUE=$(<$JSON_PATH)

CONFIG_SET=$(echo $JSON_VALUE | jq -r '.configset')

echo $JSON_VALUE | jq -r '.indexes[]' | while read index
do
	curl -X POST -L "${SOLR_URL}/api/c" -H "Content-Type:application/json" -d "{ create:{ name: '${index}', config: '${CONFIG_SET}', numShards: 1, replicationFactor: 3, maxShardsPerNode: 1} }"
done
