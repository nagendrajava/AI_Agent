<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0"
    xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:fo="http://www.w3.org/1999/XSL/Format">
    <xsl:template name="paymentNote">
        <fo:block xmlns:fo="http://www.w3.org/1999/XSL/Format">
            <fo:table table-layout="fixed" width="100%">
                <fo:table-column column-width="100%" />
                <fo:table-body>
                    <fo:table-row font-size="8pt">
                        <fo:table-cell column-number="1">
                            <fo:table table-layout="fixed" width="100%" margin="1%">
                                <fo:table-column column-width="98%" />
                                <fo:table-body>
                                    <fo:table-row font-size="8pt">
                                        <fo:table-cell column-number="1" border="1pt solid black" text-align="left" margin-left="0px">
                                            <fo:block>
                                                <xsl:value-of select="Invoice/Detail/Rental_Agreement_Info/PaymentNotes/Line1" />
                                            </fo:block>
                                            <fo:block>
                                                <xsl:value-of select="Invoice/Detail/Rental_Agreement_Info/PaymentNotes/Line2" />
                                            </fo:block>
                                            <fo:block>
                                                <xsl:value-of select="'&#x2028;'" />
                                                <xsl:value-of select="'&#x2028;'" />
                                            </fo:block>
                                            <fo:block font-weight="bold">
                                                <xsl:value-of select="Invoice/Detail/Rental_Agreement_Info/PaymentNotes/Line3" />
                                            </fo:block>
                                        </fo:table-cell>
                                    </fo:table-row>
                                </fo:table-body>
                            </fo:table>
                        </fo:table-cell>
                    </fo:table-row>
                </fo:table-body>
            </fo:table>

            <!-- <fo:table table-layout="fixed" font-family="Courier New, monospace" width="100%">
                <fo:table-column column-width="33%" />
                <fo:table-column column-width="33%" />
                <fo:table-column column-width="33%" />
                <fo:table-body>
                    <fo:table-row font-size="8pt">
                        <fo:table-cell column-number="1" text-align="center">
                            <fo:block font-size="8pt" font-weight="bold">
                                DATE:
                            </fo:block>
                        </fo:table-cell>
                        <fo:table-cell column-number="2" text-align="left">
                            <fo:block font-size="8pt" font-weight="bold">
                                TYPE:
                            </fo:block>
                        </fo:table-cell>
                        <fo:table-cell column-number="3" text-align="left">
                            <fo:block font-size="8pt" font-weight="bold">
                                AMOUNT:
                            </fo:block>
                        </fo:table-cell>
                    </fo:table-row>
                    <xsl:for-each select="Invoice/Detail/Rental_Agreement_Info/Payments/Payment">
                        <fo:table-row font-size="8pt">
                            <fo:table-cell column-number="1" text-align="center">
                                <fo:block font-size="8pt">
                                    <xsl:value-of select="Date" />
                                </fo:block>
                            </fo:table-cell>
                            <fo:table-cell column-number="2" text-align="left">
                                <fo:block font-size="8pt">
                                    <xsl:value-of select="Type" />
                                </fo:block>
                            </fo:table-cell>
                            <fo:table-cell column-number="3" text-align="left">
                                <fo:block font-size="8pt">
                                    <xsl:value-of select="Amount" />
                                </fo:block>
                            </fo:table-cell>
                        </fo:table-row>
                    </xsl:for-each>
                </fo:table-body>
            </fo:table>

            <fo:block font-family="Courier New, monospace" font-size="8pt">
                <xsl:value-of
                    select="Invoice/Detail/Rental_Agreement_Info/Payments/Payment/CardType" />
                <xsl:text>: </xsl:text>
                <xsl:value-of
                    select="Invoice/Detail/Rental_Agreement_Info/Payments/Payment/CardNumber" />
                <xsl:text>    </xsl:text>
                <xsl:text>EXP: </xsl:text>
                <xsl:value-of
                    select="Invoice/Detail/Rental_Agreement_Info/Payments/Payment/ExpirationDate" />
                <xsl:text>    </xsl:text>
                <xsl:text>AMT: </xsl:text>
                <xsl:value-of select="Invoice/Detail/Rental_Agreement_Info/Payments/Payment/Amount" />
                <xsl:text>    </xsl:text>
                <xsl:text>AUTH: </xsl:text>
                <xsl:value-of
                    select="Invoice/Detail/Rental_Agreement_Info/Payments/Payment/AuthorizationCode" />
            </fo:block> -->
        </fo:block>
    </xsl:template>
</xsl:stylesheet>