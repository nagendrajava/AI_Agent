<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0"
    xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:fo="http://www.w3.org/1999/XSL/Format">
    <xsl:template name="newLineForBlank">
        <xsl:param name="field"/>
        <fo:block>
            <xsl:choose>
                <xsl:when test="normalize-space($field) =''">
                    <xsl:text>&#160;</xsl:text>
                </xsl:when>
            </xsl:choose>
        </fo:block>
    </xsl:template>
</xsl:stylesheet>