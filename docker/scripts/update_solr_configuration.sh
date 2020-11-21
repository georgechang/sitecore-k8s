#!/bin/bash
CONFIG_PATH=$1
TRANSFORM_PATH=$2
SOLR_URL=$3

cp -r $CONFIG_PATH/* /tmp/solr/sitecore
mv /tmp/solr/sitecore/conf/solrconfig.xml /tmp/solrconfig.xml && sed s/update.autoCreateFields:true/update.autoCreateFields:false/g /tmp/solrconfig.xml > /tmp/solr/sitecore/conf/solrconfig.xml
mv /tmp/solr/sitecore/conf/managed-schema /tmp/managed-schema && xsltproc $TRANSFORM_PATH /tmp/managed-schema > /tmp/solr/sitecore/conf/managed-schema
curl -sSL "$SOLR_URL/solr/admin/configs?action=DELETE&name=sitecore&omitHeader=true"
(cd /tmp/solr/sitecore/conf && zip -r - *) | curl -X POST --header "Content-Type:application/octet-stream" --data-binary @- "$SOLR_URL/solr/admin/configs?action=UPLOAD&name=sitecore"
