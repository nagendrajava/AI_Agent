<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0"
    xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:fo="http://www.w3.org/1999/XSL/Format">
    <xsl:template name="orderDetailsHeaderFirstPage">
        <fo:block xmlns:fo="http://www.w3.org/1999/XSL/Format">
            <fo:table table-layout="fixed" width="100%">
                <fo:table-column column-width="5%" />
                <fo:table-column column-width="40%" />
                <fo:table-column column-width="15%" />
                <fo:table-column column-width="40%" />
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
                                <fo:inline>&#xA0;</fo:inline>
                            </fo:block>
                        </fo:table-cell>
                    </fo:table-row>
                </fo:table-body>
            </fo:table>
            <fo:table table-layout="fixed" width="100%">
                <fo:table-column column-width="100%" />
                <fo:table-body>
                    <fo:table-row>
                        <fo:table-cell column-number="1">
                            <fo:table table-layout="fixed" width="100%" border="1pt solid black" margin-top="1%">
                                <fo:table-column column-width="30%" />
                                <fo:table-column column-width="25%" />
                                <fo:table-column column-width="20%" />
                                <fo:table-column column-width="25%" />
                                <fo:table-body>
                                    <fo:table-row font-size="8pt" background-color="#c8c4c4" border="1pt solid black">
                                        <fo:table-cell column-number="1" border="1pt solid black" text-align="center">
                                            <fo:block>PO # </fo:block>
                                        </fo:table-cell>
                                        <fo:table-cell column-number="2" border="1pt solid black" text-align="center">
                                            <fo:block>RES/QUOTE #</fo:block>
                                        </fo:table-cell>
                                        <fo:table-cell column-number="3" border="1pt solid black" text-align="center">
                                            <fo:block>CUSTOMER #</fo:block>
                                        </fo:table-cell>
                                        <fo:table-cell column-number="4" border="1pt solid black" text-align="center">
                                            <fo:block>SALES REP</fo:block>
                                        </fo:table-cell>
                                    </fo:table-row>
                                    <fo:table-row font-size="8pt" border="1pt solid black">
                                        <fo:table-cell column-number="1" border="1pt solid black" text-align="center">
                                            <fo:block>
                                                <xsl:value-of select="Invoice/Detail/OrderInfo/PO" />
                                            </fo:block>
                                        </fo:table-cell>
                                        <fo:table-cell column-number="2" border="1pt solid black" text-align="center">
                                            <fo:block>
                                                <xsl:value-of select="Invoice/Detail/OrderInfo/ResQuote" />
                                            </fo:block>
                                        </fo:table-cell>
                                        <fo:table-cell column-number="3" border="1pt solid black" text-align="center">
                                            <fo:block>
                                                <xsl:value-of select="Invoice/Detail/OrderInfo/Customer" />
                                            </fo:block>
                                        </fo:table-cell>
                                        <fo:table-cell column-number="4" border="1pt solid black" text-align="center">
                                            <fo:block>
                                                <xsl:value-of select="Invoice/Detail/OrderInfo/SalesRep" />
                                            </fo:block>
                                        </fo:table-cell>
                                    </fo:table-row>
                                </fo:table-body>
                            </fo:table>
                            <fo:table table-layout="fixed" width="100%" border="1pt solid black">
                                <fo:table-column column-width="25%" />
                                <fo:table-column column-width="25%" />
                                <fo:table-column column-width="25%" />
                                <fo:table-column column-width="25%" />
                                <fo:table-body>
                                    <fo:table-row font-size="8pt" background-color="#c8c4c4" border="1pt solid black">
                                        <fo:table-cell column-number="1" border="1pt solid black" text-align="center">
                                            <fo:block>ORDERED BY</fo:block>
                                        </fo:table-cell>
                                        <fo:table-cell column-number="2" border="1pt solid black" text-align="center">
                                            <fo:block>DELIVERED BY</fo:block>
                                        </fo:table-cell>
                                        <fo:table-cell column-number="3" border="1pt solid black" text-align="center">
                                            <fo:block>SIGNED BY </fo:block>
                                        </fo:table-cell>
                                        <fo:table-cell column-number="4" border="1pt solid black" text-align="center">
                                            <fo:block>CLOSED BY </fo:block>
                                        </fo:table-cell>
                                    </fo:table-row>
                                    <fo:table-row font-size="8pt" border="1pt solid black">
                                        <fo:table-cell column-number="1" border="1pt solid black" text-align="center">
                                            <fo:block>
                                                <xsl:value-of select="Invoice/Detail/OrderInfo/OrderedBy" />
                                            </fo:block>
                                        </fo:table-cell>
                                        <fo:table-cell column-number="2" border="1pt solid black" text-align="center">
                                            <fo:block>
                                                <xsl:value-of select="Invoice/Detail/OrderInfo/DeliveredBy" />
                                            </fo:block>
                                        </fo:table-cell>
                                        <fo:table-cell column-number="3" border="1pt solid black" text-align="center">
                                            <fo:block>
                                                <xsl:value-of select="Invoice/Detail/OrderInfo/SignedBy" />
                                            </fo:block>
                                        </fo:table-cell>
                                        <fo:table-cell column-number="4" border="1pt solid black" text-align="center">
                                            <fo:block>
                                                <xsl:value-of select="Invoice/Detail/OrderInfo/ClosedBy" />
                                            </fo:block>
                                        </fo:table-cell>
                                    </fo:table-row>
                                </fo:table-body>
                            </fo:table>
                            <fo:table table-layout="fixed" width="100%" border="1pt solid black">
                                <fo:table-column column-width="100%" />
                                <fo:table-body>
                                    <fo:table-row font-size="8pt" background-color="#c8c4c4" border="1pt solid black">
                                        <fo:table-cell column-number="1" border="1pt solid black" text-align="center">
                                            <fo:block>JOB #/SITE </fo:block>
                                        </fo:table-cell>
                                    </fo:table-row>
                                    <fo:table-row font-size="8pt" border="1pt solid black">
                                        <fo:table-cell column-number="1" border="1pt solid black" text-align="center">
                                            <fo:block>
                                                <xsl:value-of select="Invoice/Detail/OrderInfo/JobSites/JobSite" />
                                            </fo:block>
                                        </fo:table-cell>
                                    </fo:table-row>
                                </fo:table-body>
                            </fo:table>
                        </fo:table-cell>
                    </fo:table-row>
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