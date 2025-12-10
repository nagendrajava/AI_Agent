<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0"
    xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:fo="http://www.w3.org/1999/XSL/Format">
    <xsl:template name="address">
        <fo:block xmlns:fo="http://www.w3.org/1999/XSL/Format">
            <fo:block>
                <fo:external-graphic content-width="75mm">
                    <xsl:attribute name="src">
                        <xsl:value-of select="Invoice/Header/Image" />
                    </xsl:attribute>
                </fo:external-graphic>
            </fo:block>
            <fo:block font-size="10pt" font-family="Verdana">
                <xsl:value-of select="Invoice/Header/Address/Line1" />
                <xsl:value-of select="'&#x2028;'" />
                <xsl:call-template name="blockWithBlank">
                    <xsl:with-param name="field" select="Invoice/Header/Address/Line2"/>
                </xsl:call-template>
                <xsl:value-of select="concat(Invoice/Header/Address/City,',',Invoice/Header/Address/State ,' ',Invoice/Header/Address/ZipCode)" />
                <xsl:value-of select="'&#x2028;'" />
                <xsl:value-of select="'&#x2028;'" />
                <xsl:call-template name="newLineForBlank">
                    <xsl:with-param name="field" select="Invoice/Header/Address/Line2"/>
                </xsl:call-template>
            </fo:block>
            <fo:block font-size="10pt" font-family="Verdana" font-weight="bold">
                <xsl:value-of select="Invoice/Header/Address/Note" />
                <xsl:value-of select="'&#x2028;'" />
                <xsl:value-of select="'&#x2028;'" />
            </fo:block>

            <fo:block font-size="10pt" font-family="Verdana" font-weight="bold">
                <xsl:value-of select="'&#x2028;'" />
            </fo:block>
            <fo:block font-size="10pt" font-family="Verdana">

                <xsl:value-of select="'&#x2028;'" />
                <xsl:value-of select="'&#x2028;'" />
                <xsl:value-of select="'&#x2028;'" />
                <xsl:value-of select="'&#x2028;'" />
                <xsl:value-of select="'&#x2028;'" />
                <xsl:value-of select="'&#x2028;'" />
                <xsl:value-of select="'&#x2028;'" />
                <xsl:value-of select="'&#x2028;'" />
                <xsl:value-of select="'&#x2028;'" />
            </fo:block>

        </fo:block>
    </xsl:template>
</xsl:stylesheet>