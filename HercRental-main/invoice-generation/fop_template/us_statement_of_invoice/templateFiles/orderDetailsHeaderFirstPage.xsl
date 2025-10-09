<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0"
    xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:fo="http://www.w3.org/1999/XSL/Format">
    <xsl:template name="orderDetailsHeaderFirstPage">
        <fo:block xmlns:fo="http://www.w3.org/1999/XSL/Format">
            <fo:table table-layout="fixed" width="100%">
                <fo:table-column column-width="3%" />
                <fo:table-column column-width="40%" />
                <fo:table-column column-width="10%" />
                <fo:table-column column-width="25%" />
                <fo:table-column column-width="22%" border-left="1pt dashed black"/>
                <fo:table-body>
                    <fo:table-row>
                        <fo:table-cell column-number="2">
                            <xsl:call-template name="addressFirstPage" />
                        </fo:table-cell>
                        <fo:table-cell column-number="4" text-align="center">
                            <fo:block >Statement of Account as of 
                                <xsl:value-of select="Invoice/Header/StatementDate" />
                            </fo:block>
                        </fo:table-cell>
                        <fo:table-cell column-number="5">
                            <fo:block margin-left="5pt">
                                <fo:external-graphic content-width="20%">
                                    <xsl:attribute name="src">
                                        <xsl:value-of select="Invoice/Header/Image" />
                                    </xsl:attribute>
                                </fo:external-graphic>
                                <fo:block font-weight="bold" font-size="8pt">
                                    <xsl:value-of select="'&#x2028;'" />
                                    Remittance and Contact Information enclosed.                                    
                                    <xsl:value-of select="'&#x2028;'" />
                                    <xsl:value-of select="'&#x2028;'" />
                                    <xsl:value-of select="'&#x2028;'" />
                                    Please indicate on the stub how your payment should be applied. Detach and return with your payment.
                                    <xsl:value-of select="'&#x2028;'" />
                                    <xsl:value-of select="'&#x2028;'" />
                                    <xsl:value-of select="'&#x2028;'" />
                                    <xsl:value-of select="'&#x2028;'" />
                                    <xsl:value-of select="'&#x2028;'" />
                                    <xsl:value-of select="'&#x2028;'" />
                                    <fo:table table-layout="fixed" width="100%">
                                        <fo:table-column column-width="50%" />
                                        <fo:table-column column-width="50%" />
                                        <fo:table-body>
                                            <fo:table-row border-top="1pt solid black" border-bottom="1pt solid black">
                                                <fo:table-cell column-number="1" number-columns-spanned="2" text-align="center">
                                                    <fo:block font-weight="bold" font-size="9pt">
                                                        Remittance
                                                    </fo:block>
                                                </fo:table-cell>
                                            </fo:table-row>
                                            <fo:table-row border-bottom="1pt solid black">
                                                <fo:table-cell column-number="1" text-align="left">
                                                    <fo:block font-size="9pt">
                                                        Customer #
                                                    </fo:block>
                                                </fo:table-cell>
                                                <fo:table-cell column-number="2" text-align="right">
                                                    <fo:block font-size="9pt">
                                                        <xsl:value-of select="Invoice/Detail/OrderInfo/Customer" />
                                                    </fo:block>
                                                </fo:table-cell>
                                            </fo:table-row>
                                        </fo:table-body>
                                    </fo:table>
                                </fo:block>
                            </fo:block>
                        </fo:table-cell>
                    </fo:table-row>
                    <fo:table-row>
                        <fo:table-cell column-number="2" number-columns-spanned="3" text-align="center">
                            <fo:block font-weight="bold" font-size="8pt" font-style="italic">
                                Late charges will be assessed on invoice balances over 30 days past due
                            </fo:block>
                        </fo:table-cell>
                    </fo:table-row>
                </fo:table-body>
            </fo:table>
            <fo:table table-layout="fixed" width="100%">
                <fo:table-column column-width="13%" />
                <fo:table-column column-width="15%" />
                <fo:table-column column-width="10%" />
                <fo:table-column column-width="15%" />
                <fo:table-column column-width="15%" />
                <fo:table-column column-width="10%" />
                <fo:table-column column-width="12%" border-left="1pt dashed black"/>
                <fo:table-column column-width="10%" />
                <fo:table-body>
                    <fo:table-row border-bottom="2pt solid black">
                        <fo:table-cell column-number="1">
                            <fo:block font-weight="bold" font-size="8pt" text-align="left">Invoice #</fo:block>
                        </fo:table-cell>
                        <fo:table-cell column-number="2">
                            <fo:block font-weight="bold" font-size="8pt" text-align="left">Inv. Date</fo:block>
                        </fo:table-cell>
                        <fo:table-cell column-number="3">
                            <fo:block font-weight="bold" font-size="8pt" text-align="left">PO #</fo:block>
                        </fo:table-cell>
                        <fo:table-cell column-number="4">
                            <fo:block font-weight="bold" font-size="8pt" text-align="left">Job Location</fo:block>
                        </fo:table-cell>
                        <fo:table-cell column-number="5">
                            <fo:block font-weight="bold" font-size="8pt" text-align="left">Invoice Amount</fo:block>
                        </fo:table-cell>
                        <fo:table-cell column-number="6">
                            <fo:block font-weight="bold" font-size="8pt" text-align="left">Balance</fo:block>
                        </fo:table-cell>
                        <fo:table-cell column-number="7">
                            <fo:block font-weight="bold" font-size="8pt" text-align="left">
                                <xsl:text>&#xA0;</xsl:text>Invoice #</fo:block>
                        </fo:table-cell>
                        <fo:table-cell column-number="8">
                            <fo:block font-weight="bold" font-size="8pt" text-align="left">Balance</fo:block>
                        </fo:table-cell>
                    </fo:table-row>
                </fo:table-body>
            </fo:table>

        </fo:block>
    </xsl:template>
</xsl:stylesheet>