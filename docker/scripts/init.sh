#!/bin/bash
BASEDIR=$(dirname $0)
echo "Updating configs..."
$BASEDIR/update_solr_configuration.sh /opt/solr/server/solr/configsets/_default $(dirname $BASEDIR)/schema/managed-schema.xslt $SOLR_URL
for i in $(find $(dirname $BASEDIR)/configuration -name '*.json')
do
    echo "Add collections from $i..."
    echo "$BASEDIR/create_solr_collections.sh \"$i\" \"$SOLR_URL\""
    $BASEDIR/create_solr_collections.sh "$i" "$SOLR_URL"
done
$BASEDIR/update_xdb_collections.sh $SOLR_URL
echo "Done!"
