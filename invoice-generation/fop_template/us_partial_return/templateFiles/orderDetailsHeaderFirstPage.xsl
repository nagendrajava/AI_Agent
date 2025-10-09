<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0"
    xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:fo="http://www.w3.org/1999/XSL/Format">
    <xsl:template name="orderDetailsHeaderFirstPage">
        <fo:block xmlns:fo="http://www.w3.org/1999/XSL/Format">
            <fo:table table-layout="fixed" width="100%">
                <fo:table-column column-width="5%" />
                <fo:table-column column-width="35%" />
                <fo:table-column column-width="10%" />
                <fo:table-column column-width="50%" />
                <fo:table-body>
                    <fo:table-row>
                        <fo:table-cell column-number="2">
                            <xsl:call-template name="addressFirstPage" />
                        </fo:table-cell>
                        <fo:table-cell column-number="4">
                            <xsl:call-template name="invoiceDetailsFirstPage" />
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
                            <xsl:call-template name="headerNotes" />
                        </fo:table-cell>
                    </fo:table-row>
                    <fo:table-row>
                        <fo:table-cell column-number="1">
                            <fo:block border-bottom-style="dashed" border-bottom-width="1pt" border-bottom-color="black" line-height="0pt" padding-bottom="1pt">
                                <fo:inline>&#xA0;&#xA0;</fo:inline>
                            </fo:block>
                            <xsl:value-of select="'&#x2028;'" />
                        </fo:table-cell>
                    </fo:table-row>
                </fo:table-body>
            </fo:table>
            <fo:table table-layout="fixed" width="100%" margin-top="1mm">
                <fo:table-column column-width="100%" />
                <fo:table-body>
                    <fo:table-row>
                        <fo:table-cell column-number="1">
                            <fo:table table-layout="fixed" width="100%" border="1pt solid black" margin-top="1%">
                                <fo:table-column column-width="15%" />
                                <fo:table-column column-width="35%" />
                                <fo:table-column column-width="15%" />
                                <fo:table-column column-width="35%" />
                                <fo:table-body>
                                    <fo:table-row font-size="9pt" border="1pt solid black">
                                        <fo:table-cell column-number="1" font-weight="bold" border="1pt solid black" text-align="left">
                                            <fo:block>Invoice From:</fo:block>
                                        </fo:table-cell>
                                        <fo:table-cell column-number="2" border="1pt solid black" text-align="left" margin-left="2mm">
                                            <fo:block>
                                                <xsl:value-of select="Invoice/Detail/Rental_Agreement_Info/Rental_Details/InvoiceFrom" />
                                            </fo:block>
                                        </fo:table-cell>
                                        <fo:table-cell column-number="3" font-weight="bold" border="1pt solid black" text-align="left">
                                            <fo:block>PO#:</fo:block>
                                        </fo:table-cell>
                                        <fo:table-cell column-number="4" border="1pt solid black" text-align="left" margin-left="2mm">
                                            <fo:block>
                                                <xsl:value-of select="Invoice/Detail/OrderInfo/PO" />
                                            </fo:block>
                                        </fo:table-cell>
                                    </fo:table-row>
                                    <fo:table-row font-size="9pt" border="1pt solid black">
                                        <fo:table-cell column-number="1" font-weight="bold" border="1pt solid black" text-align="left">
                                            <fo:block>Invoice To:</fo:block>
                                        </fo:table-cell>
                                        <fo:table-cell column-number="2" border="1pt solid black" text-align="left" margin-left="2mm">
                                            <fo:block>
                                                <xsl:value-of select="Invoice/Detail/Rental_Agreement_Info/Rental_Details/InvoiceTo" />
                                            </fo:block>
                                        </fo:table-cell>
                                        <fo:table-cell column-number="3" font-weight="bold" border="1pt solid black" text-align="left">
                                            <fo:block>Ordered By:</fo:block>
                                        </fo:table-cell>
                                        <fo:table-cell column-number="4" border="1pt solid black" text-align="left" margin-left="2mm">
                                            <fo:block>
                                                <xsl:value-of select="Invoice/Detail/OrderInfo/OrderedBy" />
                                            </fo:block>
                                        </fo:table-cell>
                                    </fo:table-row>
                                    <fo:table-row font-size="9pt" border="1pt solid black">
                                        <fo:table-cell column-number="1" font-weight="bold" border="1pt solid black" text-align="left">
                                            <fo:block>Rental Start Date</fo:block>
                                        </fo:table-cell>
                                        <fo:table-cell column-number="2" border="1pt solid black" text-align="left" margin-left="2mm">
                                            <fo:block>
                                                <xsl:value-of select="Invoice/Detail/Rental_Agreement_Info/Rental_Details/RentalStartDate" />
                                            </fo:block>
                                        </fo:table-cell>
                                        <fo:table-cell column-number="3" font-weight="bold" border="1pt solid black" text-align="left">
                                            <fo:block>Signed By:</fo:block>
                                        </fo:table-cell>
                                        <fo:table-cell column-number="4" border="1pt solid black" text-align="left" margin-left="2mm">
                                            <fo:block>
                                                <xsl:value-of select="Invoice/Detail/OrderInfo/SignedBy" />
                                            </fo:block>
                                        </fo:table-cell>
                                    </fo:table-row>
                                </fo:table-body>
                            </fo:table>
                        </fo:table-cell>
                    </fo:table-row>
                </fo:table-body>
            </fo:table>
            <fo:table table-layout="fixed" width="100%" margin-top="2mm">
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
                                <fo:table-body>
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
                                </fo:table-body>

                            </fo:table>
                        </fo:table-cell>
                    </fo:table-row>
                </fo:table-body>
            </fo:table>
        </fo:block>
    </xsl:template>
</xsl:stylesheet>