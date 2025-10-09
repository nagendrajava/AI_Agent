<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0"
    xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:fo="http://www.w3.org/1999/XSL/Format">
    <xsl:template name="orderDetails">
        <fo:block xmlns:fo="http://www.w3.org/1999/XSL/Format">
            <fo:block-container width="100%">
                <fo:block >
                    <fo:table table-layout="fixed" width="100%">
                        <fo:table-column column-width="100%" />
                        <fo:table-body>
                            <fo:table-row>
                                <fo:table-cell column-number="1">
                                    <fo:table table-layout="fixed" width="100%">
                                        <fo:table-column column-width="8%" />
                                        <fo:table-column column-width="20%" />
                                        <fo:table-column column-width="30%" />
                                        <fo:table-column column-width="10%" />
                                        <fo:table-column column-width="10%" />
                                        <fo:table-column column-width="12%" />
                                        <fo:table-column column-width="10%" />
                                        <fo:table-body start-indent="0pt">
                                            <fo:table-row font-size="8pt" background-color="#c8c4c4">
                                                <fo:table-cell column-number="1" border="1pt solid black" text-align="center">
                                                    <fo:block>QTY </fo:block>
                                                </fo:table-cell>
                                                <fo:table-cell column-number="2" border="1pt solid black" text-align="center">
                                                    <fo:block>EQUIPMENT # </fo:block>
                                                </fo:table-cell>
                                                <fo:table-cell column-number="3" border="1pt solid black" text-align="center">
                                                    <fo:block>DESCRIPTION </fo:block>
                                                </fo:table-cell>
                                                <fo:table-cell column-number="4" border="1pt solid black" text-align="center">
                                                    <fo:block>MAKE </fo:block>
                                                </fo:table-cell>
                                                <fo:table-cell column-number="5" border="1pt solid black" text-align="center">
                                                    <fo:block>MODEL </fo:block>
                                                </fo:table-cell>
                                                <fo:table-cell column-number="6" border="1pt solid black" text-align="center">
                                                    <fo:block>SERIAL # </fo:block>
                                                </fo:table-cell>
                                                <fo:table-cell column-number="7" border="1pt solid black" text-align="center">
                                                    <fo:block>AMOUNT </fo:block>
                                                </fo:table-cell>
                                            </fo:table-row>
                                            <xsl:for-each select="Invoice/Detail/RentalEquipment/Equipment">
                                                <fo:table-row font-size="8pt">
                                                    <fo:table-cell column-number="1" text-align="center">
                                                        <fo:block>
                                                            <xsl:value-of select="EquipmentQuantity" />
                                                        </fo:block>
                                                    </fo:table-cell>
                                                    <fo:table-cell column-number="2" text-align="left">
                                                        <fo:block>
                                                            <xsl:value-of select="EquipmentNo" />
                                                        </fo:block>
                                                    </fo:table-cell>
                                                    <fo:table-cell column-number="3" text-align="left">
                                                        <fo:block>
                                                            <xsl:value-of select="Description" />
                                                        </fo:block>
                                                    </fo:table-cell>
                                                    <fo:table-cell column-number="4" text-align="right">
                                                        <fo:block>
                                                            <xsl:value-of select="Make" />
                                                        </fo:block>
                                                    </fo:table-cell>
                                                    <fo:table-cell column-number="5" text-align="right">
                                                        <fo:block>
                                                            <xsl:value-of select="Model" />
                                                        </fo:block>
                                                    </fo:table-cell>
                                                    <fo:table-cell column-number="6" text-align="right">
                                                        <fo:block>
                                                            <xsl:value-of select="SerialNumber" />
                                                        </fo:block>
                                                    </fo:table-cell>
                                                    <fo:table-cell column-number="7" text-align="right">
                                                        <fo:block>
                                                            <xsl:value-of select="AMOUNT" />
                                                        </fo:block>
                                                    </fo:table-cell>
                                                </fo:table-row>
                                            </xsl:for-each>

                                            <fo:table-row>
                                                <fo:table-cell number-columns-spanned="6">
                                                    <fo:block break-before="auto" keep-together.within-page="always">
                                                        <fo:block>
                                                            <fo:footnote>
                                                                <fo:inline/>
                                                                <fo:footnote-body>
                                                                    <fo:block break-before="auto" keep-together.within-page="always">
                                                                        <xsl:call-template name="paymentNote" />
                                                                    </fo:block>
                                                                    <fo:block keep-together.within-column="always">
                                                                        <xsl:call-template name="shippingAndCharges" />
                                                                    </fo:block>
                                                                </fo:footnote-body>
                                                            </fo:footnote>
                                                        </fo:block>
                                                    </fo:block>
                                                </fo:table-cell>
                                            </fo:table-row>
                                        </fo:table-body>
                                    </fo:table>
                                </fo:table-cell>
                            </fo:table-row>
                        </fo:table-body>
                    </fo:table>
                </fo:block>
            </fo:block-container>
        </fo:block>
    </xsl:template>
</xsl:stylesheet>