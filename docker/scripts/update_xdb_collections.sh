#!/bin/bash
SOLR_URL=$1
BASEDIR=$(dirname $0)

echo "Create aliases for xDB indices..."
curl -X POST -L "${SOLR_URL}/api/c" -H "Content-Type:application/json" -d '{ "create-alias":{ "name":"xdb", "collections":["sitecore_xdb"] } }'
curl -X POST -L "${SOLR_URL}/api/c" -H "Content-Type:application/json" -d '{ "create-alias":{ "name":"xdb_rebuild", "collections":["sitecore_xdb_rebuild"] } }'

echo "Apply schema updates to xDB indices..."
curl -X POST -H 'Content-type:application/json' -d @$(dirname $BASEDIR)/schema/schema.json $SOLR_URL/solr/xdb/schema
curl -X POST -H 'Content-type:application/json' -d @$(dirname $BASEDIR)/schema/schema.json $SOLR_URL/solr/xdb_rebuild/schema
