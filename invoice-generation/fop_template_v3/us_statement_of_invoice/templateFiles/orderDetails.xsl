<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0"
    xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:fo="http://www.w3.org/1999/XSL/Format">
    <xsl:template name="orderDetails">
        <fo:block xmlns:fo="http://www.w3.org/1999/XSL/Format">
            <fo:block-container width="119%" >
                <fo:block>
                    <fo:table table-layout="fixed" width="108%">
                        <fo:table-column column-width="12%" />
                        <fo:table-column column-width="13%" />
                        <fo:table-column column-width="13%" />
                        <fo:table-column column-width="15%" />
                        <fo:table-column column-width="15%" />
                        <fo:table-column column-width="10%" />
                        <fo:table-column column-width="12%" />
                        <fo:table-column column-width="10%" />
                        <fo:table-body start-indent="0pt">
                            <xsl:for-each select="Invoice/Detail/Invoices/Invoice">
                                <fo:table-row font-size="8pt">
                                    <fo:table-cell column-number="1" text-align="left">
                                        <fo:block >
                                            <xsl:value-of select="InvoiceNo" />
                                        </fo:block >
                                    </fo:table-cell >
                                    <fo:table-cell column-number="2" text-align="left">
                                        <fo:block >
                                            <xsl:value-of select="InvoiceDate" />
                                        </fo:block >
                                    </fo:table-cell >
                                    <fo:table-cell column-number="3" text-align="left">
                                        <fo:block >
                                            <xsl:value-of select="PO" />
                                        </fo:block >
                                    </fo:table-cell >
                                    <fo:table-cell column-number="4" text-align="left">
                                        <fo:block >
                                            <xsl:value-of select="JobLocation" />
                                        </fo:block >
                                    </fo:table-cell >
                                    <fo:table-cell column-number="5" text-align="right" margin-right="1%">
                                        <fo:block >
                                            <xsl:value-of select="InvoiceAmount" />
                                        </fo:block >
                                    </fo:table-cell >
                                    <fo:table-cell column-number="6" text-align="right" margin-right="1%">
                                        <fo:block >
                                            <xsl:value-of select="Balance" />
                                        </fo:block >
                                    </fo:table-cell >
                                    <fo:table-cell column-number="7" text-align="right" margin-right="1%">
                                        <fo:block >
                                            <xsl:text>&#xA0;</xsl:text>
                                            <xsl:value-of select="InvoiceNo" />
                                        </fo:block >
                                    </fo:table-cell >
                                    <fo:table-cell column-number="8" text-align="right" margin-right="1%">
                                        <fo:block >
                                            <xsl:value-of select="Balance" />
                                        </fo:block >
                                    </fo:table-cell >

                                </fo:table-row>


                            </xsl:for-each>
                            <fo:table-row>
                                <fo:table-cell number-columns-spanned="8">
                                    <fo:block break-before="auto" keep-together.within-page="always">
                                        <fo:block>
                                            <fo:footnote>
                                                <fo:inline/>
                                                <fo:footnote-body>
                                                    <fo:block break-before="auto" keep-together.within-page="always">
                                                        <xsl:call-template name="paymentNote" />
                                                    </fo:block>
                                                    <fo:block keep-together.within-column="always">
                                                        <xsl:call-template name="agingDetails" />
                                                    </fo:block>
                                                </fo:footnote-body>
                                            </fo:footnote>
                                        </fo:block>
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