<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
    <xsl:template match="node()|@*">
        <xsl:copy>
            <xsl:apply-templates select="node()|@*" />
        </xsl:copy>
    </xsl:template>

    <xsl:template match="field[@name='id']">
        <xsl:copy-of select="." />
        <field name="_uniqueid" type="string" indexed="true" required="true" stored="true" />
    </xsl:template>

    <xsl:template match="uniqueKey/text()[.='id']">_uniqueid</xsl:template>
</xsl:stylesheet>
