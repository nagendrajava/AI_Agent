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
                                        <fo:table-column column-width="30%" />
                                        <fo:table-column column-width="15%" />
                                        <fo:table-column column-width="8%" />
                                        <fo:table-column column-width="8%" />
                                        <fo:table-column column-width="8%" />
                                        <fo:table-column column-width="8%" />
                                        <fo:table-column column-width="15%" />
                                        <fo:table-body start-indent="0pt">
                                            <xsl:for-each select="Invoice/Detail/RentalEquipment/Equipment">
                                                <fo:table-row font-size="8pt">
                                                    <fo:table-cell column-number="1" text-align="center">
                                                        <fo:block>
                                                            <xsl:value-of select="EquipmentQuantity" />
                                                        </fo:block>
                                                    </fo:table-cell>
                                                    <fo:table-cell column-number="2" text-align="left">
                                                        <fo:block>
                                                            <xsl:value-of select="Description" />
                                                        </fo:block>
                                                    </fo:table-cell>
                                                    <fo:table-cell column-number="3" text-align="center">
                                                        <fo:block>
                                                            <xsl:value-of select="HRSMINIMUM" />
                                                        </fo:block>
                                                    </fo:table-cell>
                                                    <fo:table-cell column-number="4" text-align="right">
                                                        <fo:block>
                                                            <xsl:value-of select="HOUR" />
                                                        </fo:block>
                                                    </fo:table-cell>
                                                    <fo:table-cell column-number="5" text-align="right">
                                                        <fo:block>
                                                            <xsl:value-of select="DAY" />
                                                        </fo:block>
                                                    </fo:table-cell>
                                                    <fo:table-cell column-number="6" text-align="right">
                                                        <fo:block>
                                                            <xsl:value-of select="WEEK" />
                                                        </fo:block>
                                                    </fo:table-cell>
                                                    <fo:table-cell column-number="7" text-align="right">
                                                        <fo:block>
                                                            <xsl:value-of select="FOURWEEK" />
                                                        </fo:block>
                                                    </fo:table-cell>
                                                    <fo:table-cell column-number="8" text-align="right">
                                                        <fo:block>
                                                            <xsl:value-of select="AMOUNT" />
                                                        </fo:block>
                                                    </fo:table-cell>

                                                </fo:table-row>

                                                <fo:table-row font-size="8pt">
                                                    <fo:table-cell column-number="2" number-columns-spanned="2" text-align="left">
                                                        <fo:block>
                                                            <fo:inline font-weight="bold"> IC#: </fo:inline>
                                                            <xsl:value-of select="IC" />
                                                            <fo:inline font-weight="bold"> CAT/Class: </fo:inline>
                                                            <xsl:value-of select="EquipmentCatClass" />
                                                        </fo:block>
                                                    </fo:table-cell>
                                                </fo:table-row>
                                                <fo:table-row font-size="8pt">
                                                    <fo:table-cell column-number="2" number-columns-spanned="2" text-align="left">
                                                        <fo:block>
                                                            <fo:inline font-weight="bold">Make: </fo:inline>
                                                            <xsl:value-of select="Make" />
                                                            <fo:inline font-weight="bold"> Model: </fo:inline>
                                                            <xsl:value-of select="Model" />
                                                            <fo:inline font-weight="bold"> Ser #: </fo:inline>
                                                            <xsl:value-of select="SerialNumber" />
                                                        </fo:block>
                                                    </fo:table-cell>
                                                </fo:table-row>
                                                <fo:table-row font-size="8pt">
                                                    <fo:table-cell column-number="2" number-columns-spanned="2" text-align="left">
                                                        <fo:block>
                                                                HR OUT: 
                                                            <xsl:value-of select="HROUT" />
                                                                HR IN: 
                                                            <xsl:value-of select="HRIN" />
                                                                HRS CHRG: 
                                                            <xsl:value-of select="HRCHG" />
                                                        </fo:block>
                                                    </fo:table-cell>
                                                </fo:table-row>
                                                <fo:table-row font-size="8pt">
                                                    <fo:table-cell column-number="2" number-columns-spanned="2" text-align="left">
                                                        <fo:block>
                                                            <xsl:value-of select="Item1/Description" />
                                                        </fo:block>
                                                    </fo:table-cell>
                                                    <fo:table-cell column-number="8" text-align="right">
                                                        <fo:block>
                                                            <xsl:value-of select="Item1/AMOUNT" />
                                                        </fo:block>
                                                    </fo:table-cell>
                                                </fo:table-row>
                                                <fo:table-row font-size="8pt">
                                                    <fo:table-cell column-number="2" number-columns-spanned="2" text-align="left">
                                                        <fo:block>
                                                            <xsl:value-of select="Item2/Description" />
                                                        </fo:block>
                                                    </fo:table-cell>
                                                    <fo:table-cell column-number="8" text-align="right">
                                                        <fo:block>
                                                            <xsl:value-of select="Item2/AMOUNT" />
                                                        </fo:block>
                                                    </fo:table-cell>
                                                </fo:table-row>

                                            </xsl:for-each>

                                            <fo:table-row font-size="9pt">
                                                <fo:table-cell column-number="1" number-columns-spanned="8" font-weight="bold" text-align="left">
                                                    <fo:block>SALES ITEMS: </fo:block>
                                                </fo:table-cell>
                                            </fo:table-row>

                                            <fo:table-row font-size="9pt">
                                                <fo:table-cell column-number="1" font-weight="bold" text-align="center">
                                                    <fo:block>QTY</fo:block>
                                                </fo:table-cell>
                                                <fo:table-cell column-number="2" number-columns-spanned="3" font-weight="bold" text-align="left">
                                                    <fo:block>ITEMS</fo:block>
                                                </fo:table-cell>
                                                <fo:table-cell column-number="5" font-weight="bold" text-align="center">
                                                    <fo:block>UNIT</fo:block>
                                                </fo:table-cell>
                                                <fo:table-cell column-number="7" font-weight="bold" text-align="right">
                                                    <fo:block>PRICE</fo:block>
                                                </fo:table-cell>
                                                <fo:table-cell column-number="8" font-weight="bold" text-align="right">
                                                    <fo:block>AMOUNT</fo:block>
                                                </fo:table-cell>
                                            </fo:table-row>

                                            <xsl:for-each select="Invoice/Detail/SalesItemsList/Item">
                                            <fo:table-row font-size="9pt">
                                                <fo:table-cell column-number="1" text-align="center">
                                                    <fo:block>
                                                        <xsl:value-of select="ItemQuantity" />
                                                    </fo:block>
                                                </fo:table-cell>
                                                <fo:table-cell column-number="2" number-columns-spanned="3" text-align="left">
                                                    <fo:block>
                                                        <xsl:value-of select="Description1" />
                                                    </fo:block>
                                                </fo:table-cell>
                                                <fo:table-cell column-number="5" text-align="center">
                                                    <fo:block>
                                                        <xsl:value-of select="Unit" />
                                                    </fo:block>
                                                </fo:table-cell>
                                                <fo:table-cell column-number="7" text-align="right">
                                                    <fo:block>
                                                        <xsl:value-of select="Price" />
                                                    </fo:block>
                                                </fo:table-cell>
                                                <fo:table-cell column-number="8" text-align="right">
                                                    <fo:block>
                                                        <xsl:value-of select="Amount" />
                                                    </fo:block>
                                                </fo:table-cell>
                                            </fo:table-row>
                                            <fo:table-row font-size="9pt">
                                                <fo:table-cell column-number="2" number-columns-spanned="3" text-align="left">
                                                    <fo:block>
                                                        <xsl:value-of select="Description2" />
                                                    </fo:block>
                                                </fo:table-cell>
                                            </fo:table-row>
                                            </xsl:for-each>

                                            <fo:table-row>
                                                <fo:table-cell number-columns-spanned="6">
                                                    <fo:block break-before="auto">
                                                        <fo:block>
                                                            <fo:footnote>
                                                                <fo:inline/>
                                                                <fo:footnote-body>
                                                                    <fo:block break-before="auto" keep-together.within-page="always">
                                                                        <xsl:call-template name="paymentNote" />
                                                                    </fo:block>
                                                                    <fo:block break-before="auto">
                                                                        <xsl:call-template name="paymentHistory" />
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