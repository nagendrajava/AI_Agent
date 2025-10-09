<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0"
    xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:fo="http://www.w3.org/1999/XSL/Format">
    <xsl:template name="orderDetailsHeader">
        <fo:block xmlns:fo="http://www.w3.org/1999/XSL/Format">
            <fo:table table-layout="fixed" width="100%">
                <fo:table-column column-width="10%" />
                <fo:table-column column-width="30%" />
                <fo:table-column column-width="10%" />
                <fo:table-column column-width="50%" />
                <fo:table-body>
                    <fo:table-row>
                        <fo:table-cell column-number="2">
                            <xsl:call-template name="address" />
                        </fo:table-cell>
                        <fo:table-cell column-number="4">
                            <xsl:call-template name="invoiceDetails" />
                        </fo:table-cell>
                    </fo:table-row>
                </fo:table-body>
            </fo:table>
            <fo:table table-layout="fixed" width="100%">
                <fo:table-column column-width="100%" />
                <fo:table-body>
                    <fo:table-row>
                        <fo:table-cell column-number="1">
                            <page-number/>
                            <fo:block></fo:block>
                        </fo:table-cell>
                    </fo:table-row>
                </fo:table-body>
            </fo:table>
            <fo:table table-layout="fixed" width="100%">
                <fo:table-column column-width="100%" />
                <fo:table-body>
                    
                    <fo:table-row>
                        <fo:table-cell column-number="1">
                            <fo:table table-layout="fixed" width="100%">
                                <fo:table-column column-width="10%" border-left="1pt solid black" />
                                <fo:table-column column-width="15%" />
                                <fo:table-column column-width="30%" />
                                <fo:table-column column-width="11%" />
                                <fo:table-column column-width="12%" />
                                <fo:table-column column-width="22%" border-right="1pt solid black" />
                                <fo:table-body>
                                    <fo:table-row font-size="8pt" background-color="#c8c4c4">
                                        <fo:table-cell column-number="1" border="1pt solid black" text-align="center">
                                            <fo:block>QTY</fo:block>
                                        </fo:table-cell>
                                        <fo:table-cell column-number="2" border="1pt solid black" text-align="center">
                                            <fo:block>EQUIP/PART #</fo:block>
                                        </fo:table-cell>
                                        <fo:table-cell column-number="3" border="1pt solid black" text-align="center">
                                            <fo:block>DESCRIPTION</fo:block>
                                        </fo:table-cell>
                                        <fo:table-cell column-number="4" border="1pt solid black" text-align="center">
                                            <fo:block>MAKE/U/M</fo:block>
                                        </fo:table-cell>
                                        <fo:table-cell column-number="5" border="1pt solid black" text-align="center">
                                            <fo:block>MODEL/PRICE</fo:block>
                                        </fo:table-cell>
                                        <fo:table-cell column-number="6" border="1pt solid black" text-align="center">
                                            <fo:block>SERIAL#/EXTENDED</fo:block>
                                        </fo:table-cell>
                                    </fo:table-row>
                                </fo:table-body>

                            </fo:table>
                        </fo:table-cell>
                    </fo:table-row>
                </fo:table-body>
            </fo:table>
        </fo:block>
    </xsl:template>
</xsl:stylesheet>