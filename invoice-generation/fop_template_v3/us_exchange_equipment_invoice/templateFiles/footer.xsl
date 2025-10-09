<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0"
                xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
                xmlns:fo="http://www.w3.org/1999/XSL/Format">
    <xsl:template name="footer">
        <fo:block xmlns:fo="http://www.w3.org/1999/XSL/Format">
            <fo:table table-layout="fixed" width="100%">
                <fo:table-column column-width="25%" />
                <fo:table-column column-width="25%" />
                <fo:table-column column-width="25%" />
                <fo:table-column column-width="25%" />
                <fo:table-body>
                    <fo:table-row>
                        <fo:table-cell column-number="1">
                            <fo:block text-align="left" font-size="8pt">
                                <fo:block>LEGACY #: <xsl:value-of select="Invoice/Footer/legacy" />
                                </fo:block>
                            </fo:block>
                        </fo:table-cell>
                        <fo:table-cell column-number="2">
                            <fo:block text-align="left" font-size="8pt">
                                <fo:block>RES/QUOTE #: <xsl:value-of select="Invoice/Footer/ResOrQuoteNo" />
                                </fo:block>
                            </fo:block>
                        </fo:table-cell>
                    </fo:table-row>
                    <fo:table-row>
                        <fo:table-cell column-number="4">
                            <fo:block text-align="right" font-size="8pt"> Page <fo:page-number />
                                of <fo:page-number-citation ref-id="last-page" />
                            </fo:block>
                        </fo:table-cell>
                    </fo:table-row>
                </fo:table-body>
            </fo:table>
        </fo:block>
    </xsl:template>
</xsl:stylesheet>