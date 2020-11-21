ARG SOLR_VERSION
FROM solr:${SOLR_VERSION}
USER root
COPY ./configuration /home/configuration
COPY ./scripts /home/scripts
COPY ./schema /home/schema
RUN apt update && apt install -y xsltproc zip jq
RUN mkdir -p /tmp/solr/sitecore
WORKDIR /home
CMD ["/home/scripts/init.sh"]
ENTRYPOINT [ "/home/scripts/init.sh"]
