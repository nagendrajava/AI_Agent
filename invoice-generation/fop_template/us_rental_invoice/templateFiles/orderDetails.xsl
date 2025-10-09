<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0"
                xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
                xmlns:fo="http://www.w3.org/1999/XSL/Format">

    <xsl:output method="xml" indent="yes"/>

    <xsl:template match="/">
        <fo:root>
            <fo:layout-master-set>
                <fo:simple-page-master master-name="simple" page-height="11in" page-width="8.5in" margin="0.5in">
                    <fo:region-body/>
                </fo:simple-page-master>
            </fo:layout-master-set>

            <fo:page-sequence master-reference="simple">
                <fo:flow flow-name="xsl-region-body">
                    <xsl:call-template name="orderDetails"/>
                </fo:flow>
            </fo:page-sequence>
        </fo:root>
    </xsl:template>

    <xsl:template name="orderDetails">
        <fo:block xmlns:fo="http://www.w3.org/1999/XSL/Format">
            <fo:block-container width="100%">
                <fo:block>
                    <fo:table table-layout="fixed" width="100%">
                        <fo:table-column column-width="8%" />
                        <fo:table-column column-width="30%" />
                        <fo:table-column column-width="15%" />
                        <fo:table-column column-width="8%" />
                        <fo:table-column column-width="8%" />
                        <fo:table-column column-width="8%" />
                        <fo:table-column column-width="8%" />
                        <fo:table-column column-width="15%" />
                        <fo:table-header>
                            <fo:table-row font-size="8pt" background-color="#c8c4c4">
                                <fo:table-cell column-number="1" border="1pt solid black" text-align="center">
                                    <fo:block>QTY </fo:block>
                                </fo:table-cell>
                                <fo:table-cell column-number="2" border="1pt solid black" text-align="center">
                                    <fo:block>EQUIPMENT #</fo:block>
                                </fo:table-cell>
                                <fo:table-cell column-number="3" border="1pt solid black" text-align="center">
                                    <fo:block>HRS/MINIMUM </fo:block>
                                </fo:table-cell>
                                <fo:table-cell column-number="4" border="1pt solid black" text-align="center">
                                    <fo:block>HOUR </fo:block>
                                </fo:table-cell>
                                <fo:table-cell column-number="5" border="1pt solid black" text-align="center">
                                    <fo:block>DAY </fo:block>
                                </fo:table-cell>
                                <fo:table-cell column-number="6" border="1pt solid black" text-align="center">
                                    <fo:block>WEEK </fo:block>
                                </fo:table-cell>
                                <fo:table-cell column-number="7" border="1pt solid black" text-align="center">
                                    <fo:block>4 WEEK </fo:block>
                                </fo:table-cell>
                                <fo:table-cell column-number="8" border="1pt solid black" text-align="center">
                                    <fo:block>AMOUNT </fo:block>
                                </fo:table-cell>
                            </fo:table-row>
                        </fo:table-header>

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

                                <xsl:for-each select="Item">
                                    <fo:table-row font-size="8pt">
                                        <fo:table-cell column-number="2" number-columns-spanned="6" text-align="left">
                                            <fo:block>
                                                <xsl:value-of select="Description"/>
                                            </fo:block>
                                        </fo:table-cell>
                                        <fo:table-cell column-number="8" text-align="right">
                                            <fo:block>
                                                <xsl:value-of select="AMOUNT"/>
                                            </fo:block>
                                        </fo:table-cell>
                                    </fo:table-row>
                                </xsl:for-each>

                                <xsl:if test="string(DeliveryNote) != ''">
                                    <fo:table-row font-size="8pt" keep-with-previous="always">
                                        <fo:table-cell column-number="2" number-columns-spanned="6" text-align="left">
                                            <fo:block linefeed-treatment="preserve" white-space-treatment="preserve" white-space="pre" space-before="0pt" space-after="0pt">
                                                <xsl:value-of select="DeliveryNote"/>
                                            </fo:block>
                                        </fo:table-cell>
                                    </fo:table-row>
                                </xsl:if>
                            </xsl:for-each>

                            <fo:table-row font-size="9pt">
                                <fo:table-cell column-number="1" number-columns-spanned="8" font-weight="bold" text-align="left">
                                    <fo:block><xsl:value-of select="Invoice/Detail/SalesItemsList/title"/></fo:block>
                                </fo:table-cell>
                            </fo:table-row>

                            <fo:table-row font-size="9pt">
                                <xsl:variable name="headerCount" select="count(Invoice/Detail/SalesItemsList/headers/header)"/>

                                <xsl:for-each select="Invoice/Detail/SalesItemsList/headers/header">
                                    <xsl:variable name="position" select="position()"/>
                                    <xsl:choose>
                                        <xsl:when test="$position = 1">
                                            <fo:table-cell column-number="1" font-weight="bold" text-align="center">
                                                <fo:block>
                                                    <xsl:choose>
                                                        <xsl:when test="string(.) != ''">
                                                            <xsl:value-of select="."/>
                                                        </xsl:when>
                                                        <xsl:otherwise>
                                                            <fo:inline> </fo:inline>
                                                        </xsl:otherwise>
                                                    </xsl:choose>
                                                </fo:block>
                                            </fo:table-cell>
                                        </xsl:when>
                                        <xsl:when test="$position = 2">
                                            <fo:table-cell column-number="2" number-columns-spanned="3" font-weight="bold" text-align="left">
                                                <fo:block>
                                                    <xsl:choose>
                                                        <xsl:when test="string(.) != ''">
                                                            <xsl:value-of select="."/>
                                                        </xsl:when>
                                                        <xsl:otherwise>
                                                            <fo:inline> </fo:inline>
                                                        </xsl:otherwise>
                                                    </xsl:choose>
                                                </fo:block>
                                            </fo:table-cell>
                                        </xsl:when>
                                        <xsl:when test="$position = 3">
                                            <fo:table-cell column-number="5" font-weight="bold" text-align="center">
                                                <fo:block>
                                                    <xsl:choose>
                                                        <xsl:when test="string(.) != ''">
                                                            <xsl:value-of select="."/>
                                                        </xsl:when>
                                                        <xsl:otherwise>
                                                            <fo:inline> </fo:inline>
                                                        </xsl:otherwise>
                                                    </xsl:choose>
                                                </fo:block>
                                            </fo:table-cell>
                                        </xsl:when>
                                        <xsl:when test="$position = 4">
                                            <fo:table-cell column-number="7" font-weight="bold" text-align="right">
                                                <fo:block>
                                                    <xsl:choose>
                                                        <xsl:when test="string(.) != ''">
                                                            <xsl:value-of select="."/>
                                                        </xsl:when>
                                                        <xsl:otherwise>
                                                            <fo:inline> </fo:inline>
                                                        </xsl:otherwise>
                                                    </xsl:choose>
                                                </fo:block>
                                            </fo:table-cell>
                                        </xsl:when>
                                        <xsl:when test="$position = 5">
                                            <fo:table-cell column-number="8" font-weight="bold" text-align="right">
                                                <fo:block>
                                                    <xsl:choose>
                                                        <xsl:when test="string(.) != ''">
                                                            <xsl:value-of select="."/>
                                                        </xsl:when>
                                                        <xsl:otherwise>
                                                            <fo:inline> </fo:inline>
                                                        </xsl:otherwise>
                                                    </xsl:choose>
                                                </fo:block>
                                            </fo:table-cell>
                                        </xsl:when>
                                    </xsl:choose>
                                </xsl:for-each>
                            </fo:table-row>

                            <xsl:for-each select="Invoice/Detail/SalesItemsList/itemList/Item">
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

                            <fo:table-row font-size="9pt">
                                <fo:table-cell column-number="1" number-columns-spanned="8" font-weight="bold" text-align="left">
                                    <fo:block space-before="2pt">DELIVERY INSTRUCTIONS :</fo:block>
                                </fo:table-cell>
                            </fo:table-row>
                            <fo:table-row font-size="8pt">
                                <fo:table-cell column-number="1" number-columns-spanned="8">
                                    <fo:block linefeed-treatment="preserve" font-family="Courier New, monospace" white-space-treatment="preserve" white-space="pre">
                                        <xsl:value-of select="Invoice/Detail/DeliveryInstructions" />
                                    </fo:block>
                                </fo:table-cell>
                            </fo:table-row>
                        </fo:table-body>
                    </fo:table>
                </fo:block>
            </fo:block-container>
        </fo:block>
    </xsl:template>
</xsl:stylesheet>