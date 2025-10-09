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
                                        <fo:table-column column-width="10%" />
                                        <fo:table-column column-width="15%" />
                                        <fo:table-column column-width="30%" />
                                        <fo:table-column column-width="11%" />
                                        <fo:table-column column-width="12%" />
                                        <fo:table-column column-width="22%" />
                                        <fo:table-body start-indent="0pt">
                                            <xsl:for-each select="Invoice/Detail/RentalEquipment/Equipment">
                                                <fo:table-row font-size="9pt">
                                                    <fo:table-cell column-number="1" text-align="center">
                                                        <fo:block>
                                                            <xsl:value-of select="EquipmentQuantity" />
                                                        </fo:block>
                                                    </fo:table-cell>
                                                    <fo:table-cell column-number="2" text-align="center">
                                                        <fo:block>
                                                            <xsl:value-of select="IC" />
                                                        </fo:block>
                                                    </fo:table-cell>
                                                    <fo:table-cell column-number="3" text-align="center">
                                                        <fo:block>
                                                            <xsl:value-of select="Description" />
                                                        </fo:block>
                                                    </fo:table-cell>
                                                    <fo:table-cell column-number="4" text-align="center">
                                                        <fo:block>
                                                            <xsl:value-of select="Make" />
                                                        </fo:block>
                                                    </fo:table-cell>
                                                    <fo:table-cell column-number="5" text-align="center">
                                                        <fo:block>
                                                            <xsl:value-of select="Model" />
                                                        </fo:block>
                                                    </fo:table-cell>
                                                    <fo:table-cell column-number="6" text-align="center">
                                                        <fo:block wrap-option="wrap" hyphenate="true" hyphenation-push-character-count="2" hyphenation-remain-character-count="2">
                                                            <xsl:call-template name="hyphenate-serial-number">
                                                                <xsl:with-param name="text" select="SerialNumber"/>
                                                                <xsl:with-param name="length" select="10"/>
                                                            </xsl:call-template>
                                                        </fo:block>
                                                    </fo:table-cell>
                                                </fo:table-row>
                                            </xsl:for-each>
                                            <fo:table-row font-size="10pt">
                                                    <fo:table-cell column-number="1" text-align="center">
                                                        <fo:block>
                                                        </fo:block>
                                                    </fo:table-cell>
                                                    <fo:table-cell column-number="2" number-columns-spanned="5" font-weight="bold" text-align="left">
                                                        <fo:block>
                                                            <xsl:value-of select="Invoice/Detail/RentalEquipmentSummary/Start" />
                                                        </fo:block>
                                                    </fo:table-cell>
                                                </fo:table-row>
                                            <xsl:for-each select="Invoice/Detail/RentalEquipmentSummary/Summary">
                                                <fo:table-row font-size="8pt">
                                                    <fo:table-cell column-number="1" text-align="center">
                                                        <fo:block>
                                                        </fo:block>
                                                    </fo:table-cell>
                                                    <fo:table-cell column-number="2" number-columns-spanned="5" text-align="left">
                                                        <fo:block>
                                                            <xsl:value-of select="Statement" />
                                                        </fo:block>
                                                    </fo:table-cell>
                                                    <!-- <fo:table-cell column-number="3" text-align="center">
                                                        <fo:block>
                                                        </fo:block>
                                                    </fo:table-cell>
                                                    <fo:table-cell column-number="4" text-align="center">
                                                        <fo:block>
                                                        </fo:block>
                                                    </fo:table-cell>
                                                    <fo:table-cell column-number="5" text-align="center">
                                                        <fo:block>
                                                        </fo:block>
                                                    </fo:table-cell>
                                                    <fo:table-cell column-number="6" text-align="center">
                                                        <fo:block>
                                                        </fo:block>
                                                    </fo:table-cell> -->
                                                </fo:table-row>
                                            </xsl:for-each>
                                            <fo:table-row font-size="10pt">
                                                <fo:table-cell number-columns-spanned="6" text-align="left">
                                                    <fo:block></fo:block>
                                                </fo:table-cell>
                                            </fo:table-row>
                                            <xsl:for-each select="Invoice/Detail/RentalEquipmentSummary/OutsideLabor">
                                                <fo:table-row font-size="9pt">
                                                    <fo:table-cell column-number="1" text-align="left">
                                                        <fo:block>
                                                        </fo:block>
                                                    </fo:table-cell>
                                                    <fo:table-cell column-number="2" text-align="left">
                                                        <fo:block>Outside Labor</fo:block>
                                                    </fo:table-cell>
                                                    <fo:table-cell column-number="3" number-columns-spanned="4" text-align="left">
                                                        <fo:block>
                                                            <xsl:value-of select="Labor" />
                                                        </fo:block>
                                                    </fo:table-cell>
                                                    <!-- <fo:table-cell column-number="4" text-align="center">
                                                        <fo:block>
                                                        </fo:block>
                                                    </fo:table-cell>
                                                    <fo:table-cell column-number="5" text-align="center">
                                                        <fo:block>
                                                        </fo:block>
                                                    </fo:table-cell>
                                                    <fo:table-cell column-number="6" text-align="center">
                                                        <fo:block>
                                                        </fo:block>
                                                    </fo:table-cell> -->
                                                </fo:table-row>
                                            </xsl:for-each>
                                            <fo:table-row font-size="10pt">
                                                <fo:table-cell number-columns-spanned="6" text-align="left">
                                                    <fo:block></fo:block>
                                                </fo:table-cell>
                                            </fo:table-row>
                                            <xsl:for-each select="Invoice/Detail/RentalEquipmentSummary/OtherSummary">
                                                <fo:table-row font-size="9pt">
                                                    <fo:table-cell column-number="1" text-align="left">
                                                        <fo:block></fo:block>
                                                    </fo:table-cell>
                                                    <fo:table-cell column-number="2" text-align="left">
                                                        <fo:block></fo:block>
                                                    </fo:table-cell>
                                                    <fo:table-cell column-number="3" text-align="left">
                                                        <fo:block>
                                                            <xsl:value-of select="Property" />
                                                        </fo:block>
                                                    </fo:table-cell>
                                                    <fo:table-cell column-number="4" text-align="left">
                                                        <fo:block>
                                                        </fo:block>
                                                    </fo:table-cell>
                                                    <fo:table-cell column-number="5" text-align="left">
                                                        <fo:block>
                                                        </fo:block>
                                                    </fo:table-cell>
                                                    <fo:table-cell column-number="6" text-align="right">
                                                        <fo:block>
                                                            <xsl:value-of select="Val" />
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
                                                                    <fo:block>
                                                                        <xsl:value-of select="'&#x2028;'" />
                                                                    </fo:block>
                                                                    <fo:block>
                                                                        <xsl:value-of select="'&#x2028;'" />
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